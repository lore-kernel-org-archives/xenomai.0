From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="s2LBNsv77J"
Content-Transfer-Encoding: 7bit
Message-ID: <17536.40316.183366.284818@domain.hid>
Date: Fri, 2 Jun 2006 22:20:12 +0200
Subject: [Xenomai-core] [rfc] unit testing context switches.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--s2LBNsv77J
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Now that the big context switches bugs have been solved, here is a patch
that adds a unit test for context switches and FPU switches
with various type of threads (kernel, user, user in secondary mode,
not using FPU, using FPU, etc...). As is the case of the latency test
there is a small RTDM driver in kernel-space, put in the benchmark
class, even though this test is for unit testing, not for benchmarking.

The FPU switches need a small piece of code architecture dependent,
put in <asm/xenomai/fptest.h>, currently only implemented for x86.

The kernel-space driver is called xeno_switchtest.ko, the user-space
testing tool is called switchtest, because there is already a context
switch benchmarking tool called "switch".

-- 


					    Gilles Chanteperdrix.

--s2LBNsv77J
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-switchtest.diff"
Content-Transfer-Encoding: 7bit

--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ include/rtdm/switchtest.h	2006-05-31 08:04:01.000000000 +0200
@@ -0,0 +1,43 @@
+#ifndef SWITCHTEST_H
+#define SWITCHTEST_H
+
+#include <rtdm/rtdm.h>
+#include <rtdm/rtbenchmark.h>
+
+#define RTSWITCH_FPU     0x1
+#define RTSWITCH_USE_FPU 0x2 /* Only for kernel-space tasks. */
+
+#define RTDM_SUBCLASS_SWITCH 1
+
+struct rtswitch_task {
+    unsigned index;
+    unsigned flags;
+};
+
+struct rtswitch {
+    unsigned from;
+    unsigned to;
+};
+
+#define RTSWITCH_RTIOC_TASKS_COUNT \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x30, unsigned long)
+
+#define RTSWITCH_RTIOC_SET_CPU \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x31, unsigned long)
+
+#define RTSWITCH_RTIOC_REGISTER_UTASK \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x32, struct rtswitch_task)
+
+#define RTSWITCH_RTIOC_CREATE_KTASK \
+    _IOWR(RTIOC_TYPE_BENCHMARK, 0x33, struct rtswitch_task)
+
+#define RTSWITCH_RTIOC_PEND \
+    _IOR(RTIOC_TYPE_BENCHMARK, 0x34, struct rtswitch_task)
+
+#define RTSWITCH_RTIOC_SWITCH_TO \
+    _IOR(RTIOC_TYPE_BENCHMARK, 0x35, struct rtswitch)
+
+#define RTSWITCH_RTIOC_GET_SWITCHES_COUNT \
+    _IOR(RTIOC_TYPE_BENCHMARK, 0x36, unsigned long)
+
+#endif /* SWITCHTEST_H */
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ include/asm-i386/fptest.h	2006-05-21 19:50:40.000000000 +0200
@@ -0,0 +1,38 @@
+#ifndef FPTEST_H
+#define FPTEST_H
+
+#ifdef __KERNEL__
+#include <linux/module.h>
+#else /* !__KERNEL__ */
+#include <stdio.h>
+#define printk printf
+#endif /* !__KERNEL__ */
+
+static inline void fp_regs_set(unsigned val)
+{
+    unsigned i;
+
+    for (i = 0; i < 8; i++)
+        __asm__ __volatile__ ("fildl %0" : /* no output */ : "m"(val));
+}
+
+static inline int fp_regs_check(unsigned val)
+{
+    unsigned i, failed = 0;
+    unsigned e[8];
+
+    for (i = 0; i < 8; i++)
+        __asm__ __volatile__ ("fistpl %0" : "=m"(e[7-i]));
+
+    for (i = 0; i < 8; i++)
+        if (e[i] != val) {
+            printk("r%d: %u != %u\n", i, e[i], val);
+            failed = 1;
+        }
+
+    return failed;
+}
+
+
+
+#endif /* FPTEST_H */
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ ksrc/drivers/benchmark/switchtest.c	2006-05-31 10:38:42.000000000 +0200
@@ -0,0 +1,504 @@
+#include <nucleus/synch.h>
+#include <nucleus/thread.h>
+#include <rtdm/switchtest.h>
+#include <rtdm/rtdm_driver.h>
+#include <asm/xenomai/fptest.h>
+#include <asm/semaphore.h>
+
+#define RTSWITCH_RT      0x4
+#define RTSWITCH_NRT     0
+#define RTSWITCH_KERNEL  0x8
+
+typedef struct {
+    struct rtswitch_task base;
+    xnsynch_t rt_synch;
+    struct semaphore nrt_synch;
+    xnthread_t ktask;          /* For kernel-space real-time tasks. */
+} rtswitch_task_t;
+
+typedef struct rtswitch_context {
+    rtswitch_task_t *tasks;
+    unsigned tasks_count;
+    unsigned next_index;
+    struct semaphore lock;
+    unsigned cpu;
+    unsigned switches_count;
+} rtswitch_context_t;
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gilles.Chanteperdrix@domain.hid");
+
+static rtswitch_task_t *rtswitch_utask[NR_CPUS];
+static rtdm_nrtsig_t rtswitch_wake_utask;
+
+static int rtswitch_pend_rt(rtswitch_context_t *ctx,
+                            unsigned idx)
+{
+    rtswitch_task_t *task;
+
+    if (idx > ctx->tasks_count)
+        return -EINVAL;
+
+    task = &ctx->tasks[idx];
+    task->base.flags = (task->base.flags & ~RTSWITCH_RT) | RTSWITCH_RT;
+
+    xnsynch_sleep_on(&task->rt_synch, XN_INFINITE);
+
+    if (xnthread_test_flags(xnpod_current_thread(), XNBREAK))
+        return -EINTR;
+
+    if (xnthread_test_flags(xnpod_current_thread(), XNRMID))
+        return -EIDRM;
+
+    return 0;
+}
+
+static int rtswitch_to_rt(rtswitch_context_t *ctx,
+                           unsigned from_idx,
+                           unsigned to_idx)
+{
+    rtswitch_task_t *from, *to;
+    spl_t s;
+
+    if (from_idx > ctx->tasks_count || to_idx > ctx->tasks_count)
+        return -EINVAL;
+
+    from = &ctx->tasks[from_idx];
+    to = &ctx->tasks[to_idx];
+
+    from->base.flags = (from->base.flags & ~RTSWITCH_RT) | RTSWITCH_RT;
+    ++ctx->switches_count;
+
+    switch (to->base.flags & RTSWITCH_RT) {
+    case RTSWITCH_NRT:
+        rtswitch_utask[ctx->cpu] = to;
+        rtdm_nrtsig_pend(&rtswitch_wake_utask);
+        xnlock_get_irqsave(&nklock, s);
+        break;
+
+    case RTSWITCH_RT:
+        xnlock_get_irqsave(&nklock, s);
+
+        xnsynch_wakeup_one_sleeper(&to->rt_synch);
+        break;
+
+    default:
+        return -EINVAL;
+    }
+
+    xnsynch_sleep_on(&from->rt_synch, XN_INFINITE);
+
+    xnlock_put_irqrestore(&nklock, s);
+
+    if (xnthread_test_flags(xnpod_current_thread(), XNBREAK))
+        return -EINTR;
+
+    if (xnthread_test_flags(xnpod_current_thread(), XNRMID))
+        return -EIDRM;
+
+    return 0;
+}
+
+static int rtswitch_pend_nrt(rtswitch_context_t *ctx,
+                             unsigned idx)
+{
+    rtswitch_task_t *task;
+
+    if (idx > ctx->tasks_count)
+        return -EINVAL;
+
+    task = &ctx->tasks[idx];
+
+    task->base.flags = (task->base.flags & ~RTSWITCH_RT) | RTSWITCH_NRT;
+
+    if (down_interruptible(&task->nrt_synch))
+        return -EINTR;
+
+    return 0;
+}
+
+static int rtswitch_to_nrt(rtswitch_context_t *ctx,
+                            unsigned from_idx,
+                            unsigned to_idx)
+{
+    rtswitch_task_t *from, *to;
+
+    if (from_idx > ctx->tasks_count || to_idx > ctx->tasks_count)
+        return -EINVAL;
+
+    from = &ctx->tasks[from_idx];
+    to = &ctx->tasks[to_idx];
+
+    from->base.flags = (from->base.flags & ~RTSWITCH_RT) | RTSWITCH_NRT;
+    ++ctx->switches_count;
+
+    switch (to->base.flags & RTSWITCH_RT) {
+    case RTSWITCH_NRT:
+        up(&to->nrt_synch);
+        break;
+
+    case RTSWITCH_RT:
+        xnsynch_wakeup_one_sleeper(&to->rt_synch);
+        xnpod_schedule();
+        break;
+
+    default:
+        return -EINVAL;
+    }
+
+    if (down_interruptible(&from->nrt_synch))
+        return -EINTR;
+
+    return 0;
+}
+
+static int rtswitch_set_tasks_count(rtswitch_context_t *ctx, unsigned count)
+{
+    rtswitch_task_t *tasks;
+
+    if (ctx->tasks_count == count)
+        return 0;
+
+    tasks = kmalloc(count * sizeof(*tasks), GFP_KERNEL);
+
+    if (!tasks)
+        return -ENOMEM;
+    
+    down(&ctx->lock);
+    
+    if (ctx->tasks)
+        kfree(ctx->tasks);
+
+    ctx->tasks = tasks;
+    ctx->tasks_count = count;
+    ctx->next_index = 0;
+
+    up(&ctx->lock);
+
+    return 0;
+}
+
+static int rtswitch_register_task(rtswitch_context_t *ctx,
+                                  struct rtswitch_task *arg)
+{
+    rtswitch_task_t *t;
+
+    down(&ctx->lock);
+
+    if (ctx->next_index == ctx->tasks_count) {
+        up(&ctx->lock);
+        return -EBUSY;
+    }
+
+    arg->index = ctx->next_index;
+    t = &ctx->tasks[arg->index];
+    ctx->next_index++;
+    t->base = *arg;
+    sema_init(&t->nrt_synch, 0);
+    xnsynch_init(&t->rt_synch, XNSYNCH_FIFO);
+
+    up(&ctx->lock);
+
+    return 0;
+}
+
+struct taskarg {
+    rtswitch_context_t *ctx;
+    rtswitch_task_t *task;
+};
+
+static void rtswitch_ktask(void *cookie)
+{
+    struct taskarg *arg = (struct taskarg *) cookie;
+    rtswitch_context_t *ctx = arg->ctx;
+    rtswitch_task_t *task = arg->task;
+    unsigned to;
+
+    to = task->base.index;
+
+    rtswitch_pend_rt(ctx, task->base.index);
+
+    for(;;) {
+        if (++to == task->base.index)
+            ++to;
+        if (to > ctx->tasks_count - 1)
+            to = 0;
+        if (to == task->base.index)
+            ++to;
+
+        if (task->base.flags & RTSWITCH_USE_FPU)
+            fp_regs_set(task->base.index);
+        rtswitch_to_rt(ctx, task->base.index, to);
+        if (task->base.flags & RTSWITCH_USE_FPU)
+            if (fp_regs_check(task->base.index))
+                xnpod_suspend_self();
+    }
+}
+
+static int rtswitch_create_ktask(rtswitch_context_t *ctx,
+                                 struct rtswitch_task *ptask)
+{
+    rtswitch_task_t *task;
+    xnflags_t init_flags;
+    struct taskarg arg;
+    char name[30];
+    int err;
+
+    ptask->flags |= RTSWITCH_KERNEL;
+    err = rtswitch_register_task(ctx, ptask);
+
+    if (err)
+        return err;
+
+    snprintf(name, sizeof(name), "rtk%d/%u", ptask->index, ctx->cpu);
+
+    task = &ctx->tasks[ptask->index];
+
+    arg.ctx = ctx;
+    arg.task = task;
+
+    init_flags = (ptask->flags & RTSWITCH_FPU) ? XNFPU : 0;
+
+    /* Migrate the calling thread to the same CPU as the created task, in order
+       to be sure that the created task is suspended when this function
+       returns. This also allow us to use the stack to pass the parameters to
+       the created task. */
+    set_cpus_allowed(current, cpumask_of_cpu(ctx->cpu));
+    
+    err = xnpod_init_thread(&task->ktask, name, 1, init_flags, 0);
+
+    if (!err)
+        err = xnpod_start_thread(&task->ktask,
+                                 0,
+                                 0,
+                                 xnarch_cpumask_of_cpu(ctx->cpu),
+                                 rtswitch_ktask,
+                                 &arg);
+
+    /* Putting the argument on stack is safe, because the new thread will
+       preempt the current thread immediately, and will suspend only once the
+       arguments on stack are used. */
+
+    return err;
+}
+
+static int rtswitch_open(struct rtdm_dev_context *context,
+                         rtdm_user_info_t *user_info,
+                         int oflags)
+{
+    rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+
+    ctx->tasks = NULL;
+    ctx->tasks_count = ctx->next_index = ctx->cpu = ctx->switches_count = 0;
+    init_MUTEX(&ctx->lock);
+
+    return 0;
+}
+
+static int rtswitch_close(struct rtdm_dev_context *context,
+                          rtdm_user_info_t *user_info)
+{
+    rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+    unsigned i;
+
+    if (ctx->tasks) {
+        for (i = 0; i < ctx->tasks_count; i++) {
+            rtswitch_task_t *task = &ctx->tasks[i];
+
+            if (task->base.flags & RTSWITCH_KERNEL)
+                xnpod_delete_thread(&task->ktask);
+            xnsynch_destroy(&task->rt_synch);
+        }
+        xnpod_schedule();
+        kfree(ctx->tasks);
+    }
+
+    return 0;
+}
+
+static int rtswitch_ioctl_nrt(struct rtdm_dev_context *context,
+                              rtdm_user_info_t *user_info,
+                              int request,
+                              void *arg)
+{
+    rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+    struct rtswitch_task task;
+    struct rtswitch fromto;
+    unsigned long count;
+    int err;
+
+    switch (request)
+        {
+        case RTSWITCH_RTIOC_TASKS_COUNT:
+            return rtswitch_set_tasks_count(ctx, (unsigned) arg);
+
+        case RTSWITCH_RTIOC_SET_CPU:
+            if ((unsigned) arg > xnarch_num_online_cpus())
+                return -EINVAL;
+
+            ctx->cpu = (unsigned) arg;
+            return 0;
+
+        case RTSWITCH_RTIOC_REGISTER_UTASK:
+            if (!rtdm_rw_user_ok(user_info, arg, sizeof(task)))
+                return -EFAULT;
+
+            rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+
+            err = rtswitch_register_task(ctx, &task);
+
+            if (!err)
+                rtdm_copy_to_user(user_info, arg, &task, sizeof(task));
+
+            return err;
+
+        case RTSWITCH_RTIOC_CREATE_KTASK:
+            if (!rtdm_rw_user_ok(user_info, arg, sizeof(task)))
+                return -EFAULT;
+
+            rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+
+            err = rtswitch_create_ktask(ctx, &task);
+
+            if (!err)
+                rtdm_copy_to_user(user_info, arg, &task, sizeof(task));
+
+            return err;
+
+        case RTSWITCH_RTIOC_PEND:
+            if (!rtdm_read_user_ok(user_info, arg, sizeof(task)))
+                return -EFAULT;
+
+            rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+            
+            return rtswitch_pend_nrt(ctx, task.index);
+
+        case RTSWITCH_RTIOC_SWITCH_TO:
+            if (!rtdm_read_user_ok(user_info, arg, sizeof(fromto)))
+                return -EFAULT;
+
+            rtdm_copy_from_user(user_info, &fromto, arg, sizeof(fromto));
+
+            rtswitch_to_nrt(ctx, fromto.from, fromto.to);
+
+            return 0;
+
+        case RTSWITCH_RTIOC_GET_SWITCHES_COUNT:
+            if (!rtdm_rw_user_ok(user_info, arg, sizeof(count)))
+                return -EFAULT;
+
+            count = ctx->switches_count;
+
+            rtdm_copy_to_user(user_info, arg, &count, sizeof(count));
+
+            return 0;
+            
+        default:
+            return -ENOTTY;
+        }
+}
+
+static int rtswitch_ioctl_rt(struct rtdm_dev_context *context,
+                             rtdm_user_info_t *user_info,
+                             int request,
+                             void *arg)
+{
+    rtswitch_context_t *ctx = (rtswitch_context_t *) context->dev_private;
+    struct rtswitch_task task;
+    struct rtswitch fromto;
+
+    switch (request) 
+        {
+        case RTSWITCH_RTIOC_REGISTER_UTASK:
+        case RTSWITCH_RTIOC_CREATE_KTASK:
+        case RTSWITCH_RTIOC_GET_SWITCHES_COUNT:
+            return -ENOSYS;
+
+         case RTSWITCH_RTIOC_PEND:
+            if (!rtdm_read_user_ok(user_info, arg, sizeof(task)))
+                return -EFAULT;
+
+            rtdm_copy_from_user(user_info, &task, arg, sizeof(task));
+            
+            return rtswitch_pend_rt(ctx, task.index);
+
+        case RTSWITCH_RTIOC_SWITCH_TO:
+            if (!rtdm_read_user_ok(user_info, arg, sizeof(fromto)))
+                return -EFAULT;
+
+            rtdm_copy_from_user(user_info, &fromto, arg, sizeof(fromto));
+
+            rtswitch_to_rt(ctx, fromto.from, fromto.to);
+
+            return 0;
+
+       default:
+            return -ENOTTY;
+        }
+}
+
+static struct rtdm_device device = {
+    struct_version: RTDM_DEVICE_STRUCT_VER,
+
+    device_flags: RTDM_NAMED_DEVICE,
+    context_size: sizeof(rtswitch_context_t),
+    device_name:  "rtswitch0",
+
+    open_rt: NULL,
+    open_nrt: rtswitch_open,
+
+    ops: {
+        close_rt: NULL,
+        close_nrt: rtswitch_close,
+
+        ioctl_rt: rtswitch_ioctl_rt,
+        ioctl_nrt: rtswitch_ioctl_nrt,
+
+        read_rt: NULL,
+        read_nrt: NULL,
+
+        write_rt: NULL,
+        write_nrt: NULL,
+
+        recvmsg_rt: NULL,
+        recvmsg_nrt: NULL,
+
+        sendmsg_rt: NULL,
+        sendmsg_nrt: NULL,
+    },
+
+    device_class: RTDM_CLASS_BENCHMARK,
+    device_sub_class: RTDM_SUBCLASS_SWITCH,
+    driver_name: "xeno_switchbench",
+    driver_version: RTDM_DRIVER_VER(0, 1, 0),
+    peripheral_name: "Context switch benchmark",
+    provider_name: "Gilles Chanteperdrix",
+    proc_name: device.device_name,
+};
+
+void rtswitch_utask_waker(rtdm_nrtsig_t sig)
+{
+    up(&rtswitch_utask[xnarch_current_cpu()]->nrt_synch);
+}
+
+int __init __switchbench_init(void)
+{
+    int err;
+
+    err = rtdm_nrtsig_init(&rtswitch_wake_utask, rtswitch_utask_waker);
+
+    if (err)
+        return err;
+    
+    return rtdm_dev_register(&device);
+}
+
+void __switchbench_exit(void)
+{
+    if(rtdm_dev_unregister(&device, 0))
+        printk("Warning: could not unregister driver %s\n", device.device_name);
+    rtdm_nrtsig_destroy(&rtswitch_wake_utask);
+}
+
+module_init(__switchbench_init);
+module_exit(__switchbench_exit);
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchtest/switchtest.c	2006-06-02 15:51:00.000000000 +0200
@@ -0,0 +1,752 @@
+#include <ctype.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sched.h>
+#include <signal.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <sys/mman.h>
+#include <semaphore.h>
+
+#include <asm/xenomai/fptest.h>
+#include <rtdm/switchtest.h>
+
+struct cpu_tasks;
+
+struct task_params {
+    unsigned type;
+    unsigned fp;
+    pthread_t thread;
+    struct cpu_tasks *cpu;
+    struct rtswitch_task swt;
+};
+
+struct cpu_tasks {
+    unsigned index;
+    struct task_params *tasks;
+    unsigned tasks_count;
+    unsigned capacity;
+    unsigned fd;
+};
+
+/* Thread type. */
+typedef enum {
+    IDLE = 0,
+    RTK  = 1,        /* kernel-space thread. */
+    RTUP = 2,        /* user-space real-time thread in primary mode. */
+    RTUS = 3,        /* user-space real-time thread in secondary mode. */
+    RTUO = 4,        /* user-space real-time thread oscillating
+                        between primary and secondary mode. */
+} threadtype;
+
+typedef enum {
+    FP   = 1,        /* arm the FPU task bit (only make sense for RTK) */
+    UFPP = 2,        /* use the FPU while in primary mode. */
+    UFPS = 4         /* use the FPU while in secondary mode. */
+} fpflags;
+
+sem_t idle_start, terminate;
+
+void timespec_substract(struct timespec *result,
+                        const struct timespec *lhs,
+                        const struct timespec *rhs)
+{
+    result->tv_sec = lhs->tv_sec - rhs->tv_sec;
+    if (lhs->tv_nsec > rhs->tv_nsec)
+        result->tv_nsec = lhs->tv_nsec - rhs->tv_nsec;
+    else {
+        result->tv_sec -= 1;
+        result->tv_nsec = lhs->tv_nsec + (1000000000 - rhs->tv_nsec);
+    }
+}
+
+static void *idle(void *cookie)
+{
+    struct task_params *param = (struct task_params *) cookie;
+    unsigned tasks_count = param->cpu->tasks_count;
+    struct timespec ts, last;
+    int fd = param->cpu->fd;
+    struct rtswitch rtsw;
+    cpu_set_t cpu_set;
+
+    CPU_ZERO(&cpu_set);
+    CPU_SET(param->cpu->index, &cpu_set);
+    if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
+        perror("idle: sched_setaffinity");
+        exit(EXIT_FAILURE);
+    }
+
+    rtsw.from = param->swt.index;
+    rtsw.to = param->swt.index;
+
+    ts.tv_sec = 0;
+    ts.tv_nsec = 1000000;
+
+    __real_sem_wait(&idle_start);
+
+    clock_gettime(CLOCK_REALTIME, &last);
+
+    /* ioctl is not a cancellation point, but we want cancellation to be allowed
+       when suspended in ioctl. */
+    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+    for (;;) {
+        struct timespec now, diff;
+
+        __real_nanosleep(&ts, NULL);
+
+        clock_gettime(CLOCK_REALTIME, &now);
+
+        timespec_substract(&diff, &now, &last);
+        if (diff.tv_sec >= 1) {
+            unsigned long switches_count;
+            last = now;
+
+            if (ioctl(fd, RTSWITCH_RTIOC_GET_SWITCHES_COUNT, &switches_count)) {
+                perror("idle: ioctl(RTSWITCH_RTIOC_GET_SWITCHES_COUNT)");
+                exit(EXIT_FAILURE);
+            }
+            
+            printf("cpu %u: %lu\n", param->cpu->index, switches_count);
+        }
+
+        if (tasks_count == 1)
+            continue;
+        
+        if (++rtsw.to == rtsw.from)
+            ++rtsw.to;
+        if (rtsw.to > tasks_count - 1)
+            rtsw.to = 0;
+        if (rtsw.to == rtsw.from)
+            ++rtsw.to;
+        
+        if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw)) {
+            perror("idle: ioctl(RTSWITCH_RTIOC_SWITCH_TO)");
+            exit(EXIT_FAILURE);
+        }
+    }
+}
+
+static void *rtup(void *cookie)
+{
+    struct task_params *param = (struct task_params *) cookie;
+    unsigned tasks_count = param->cpu->tasks_count;
+    int err, fd = param->cpu->fd;
+    struct rtswitch rtsw;
+    cpu_set_t cpu_set;
+
+    CPU_ZERO(&cpu_set);
+    CPU_SET(param->cpu->index, &cpu_set);
+    if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
+        perror("rtup: sched_setaffinity");
+        exit(EXIT_FAILURE);
+    }
+
+    rtsw.from = param->swt.index;
+    rtsw.to = param->swt.index;
+
+    /* ioctl is not a cancellation point, but we want cancellation to be allowed
+       when suspended in ioctl. */
+    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+    if ((err = pthread_set_mode_np(PTHREAD_PRIMARY, 0))) {
+        fprintf(stderr, "rtup: pthread_set_mode_np: %s\n", strerror(err));
+        exit(EXIT_FAILURE);
+    }    
+
+    if (ioctl(fd, RTSWITCH_RTIOC_PEND, &param->swt)) {
+        perror("rtup: ioctl(RTSWITCH_RTIOC_PEND)");
+        exit(EXIT_FAILURE);
+    }
+
+    for (;;) {
+        if (++rtsw.to == rtsw.from)
+            ++rtsw.to;
+        if (rtsw.to > tasks_count - 1)
+            rtsw.to = 0;
+        if (rtsw.to == rtsw.from)
+            ++rtsw.to;
+
+        if (param->fp & UFPP)
+            fp_regs_set(rtsw.from);
+        if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw)) {
+            perror("ioctl(RTSWITCH_RTIOC_SWITCH_TO)");
+            exit(EXIT_FAILURE);
+        }
+        if (param->fp & UFPP)
+            if (fp_regs_check(rtsw.from))
+                pthread_kill(pthread_self(), SIGSTOP);
+    }
+}
+
+static void *rtus(void *cookie)
+{
+    struct task_params *param = (struct task_params *) cookie;
+    unsigned tasks_count = param->cpu->tasks_count;
+    int err, fd = param->cpu->fd;
+    struct rtswitch rtsw;
+    cpu_set_t cpu_set;
+
+    CPU_ZERO(&cpu_set);
+    CPU_SET(param->cpu->index, &cpu_set);
+    if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
+        perror("rtus: sched_setaffinity");
+        exit(EXIT_FAILURE);
+    }
+
+    rtsw.from = param->swt.index;
+    rtsw.to = param->swt.index;
+
+    /* ioctl is not a cancellation point, but we want cancellation to be allowed
+       when suspended in ioctl. */
+    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+    if ((err = pthread_set_mode_np(0, PTHREAD_PRIMARY))) {
+        fprintf(stderr, "rtus: pthread_set_mode_np: %s\n", strerror(err));
+        exit(EXIT_FAILURE);
+    }
+
+    if (ioctl(fd, RTSWITCH_RTIOC_PEND, &param->swt)) {
+        perror("rtus: ioctl(RTSWITCH_RTIOC_PEND)");
+        exit(EXIT_FAILURE);
+    }
+
+    for (;;) {
+        if (++rtsw.to == rtsw.from)
+            ++rtsw.to;
+        if (rtsw.to > tasks_count - 1)
+            rtsw.to = 0;
+        if (rtsw.to == rtsw.from)
+            ++rtsw.to;
+
+        if (param->fp & UFPS)
+            fp_regs_set(rtsw.from);
+        if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw)) {
+            perror("ioctl(RTSWITCH_RTIOC_SWITCH_TO)");
+            exit(EXIT_FAILURE);
+        }
+        if (param->fp & UFPS)
+            if (fp_regs_check(rtsw.from))
+                pthread_kill(pthread_self(), SIGSTOP);
+    }
+}
+
+static void *rtuo(void *cookie)
+{
+    struct task_params *param = (struct task_params *) cookie;
+    unsigned mode, tasks_count = param->cpu->tasks_count;
+    int err, fd = param->cpu->fd;
+    struct rtswitch rtsw;
+    cpu_set_t cpu_set;
+
+    CPU_ZERO(&cpu_set);
+    CPU_SET(param->cpu->index, &cpu_set);
+    if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
+        perror("rtuo: sched_setaffinity");
+        exit(EXIT_FAILURE);
+    }
+
+    rtsw.from = param->swt.index;
+    rtsw.to = param->swt.index;
+
+    /* ioctl is not a cancellation point, but we want cancellation to be allowed
+       when suspended in ioctl. */
+    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+
+    if ((err = pthread_set_mode_np(PTHREAD_PRIMARY, 0))) {
+        fprintf(stderr, "rtup: pthread_set_mode_np: %s\n", strerror(err));
+        exit(EXIT_FAILURE);
+    }    
+    if (ioctl(fd, RTSWITCH_RTIOC_PEND, &param->swt)) {
+        perror("ioctl(RTSWITCH_RTIOC_PEND)");
+        exit(EXIT_FAILURE);
+    }
+
+    mode = PTHREAD_PRIMARY;
+    for (;;) {
+        if (++rtsw.to == rtsw.from)
+            ++rtsw.to;
+        if (rtsw.to > tasks_count - 1)
+            rtsw.to = 0;
+        if (rtsw.to == rtsw.from)
+            ++rtsw.to;
+
+        if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
+            fp_regs_set(rtsw.from);
+        if (ioctl(fd, RTSWITCH_RTIOC_SWITCH_TO, &rtsw)) {
+            perror("rtuo: ioctl(RTSWITCH_RTIOC_SWITCH_TO)");
+            exit(EXIT_FAILURE);
+        }
+        if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
+            if (fp_regs_check(rtsw.from))
+                pthread_kill(pthread_self(), SIGSTOP);
+
+        /* Switch mode. */
+        mode = PTHREAD_PRIMARY - mode;
+        if ((err = pthread_set_mode_np(mode, PTHREAD_PRIMARY - mode))) {
+            fprintf(stderr, "rtuo: pthread_set_mode_np: %s\n", strerror(err));
+            exit(EXIT_FAILURE);
+        }
+    }
+}
+
+static int parse_arg(struct task_params *param,
+                     const char *text,
+                     struct cpu_tasks *cpus)
+{
+    struct t2f {
+        const char *text;
+        unsigned flag;
+    };
+    
+    static struct t2f type2flags [] = {
+        { "rtk",  RTK  },
+        { "rtup", RTUP },
+        { "rtus", RTUS },
+        { "rtuo", RTUO }
+    };
+
+    static struct t2f fp2flags [] = {
+        { "_fp",   FP   },
+        { "_ufpp", UFPP },
+        { "_ufps", UFPS }
+    };
+
+    unsigned long cpu;
+    char *cpu_end;
+    unsigned i;
+
+    param->type = param->fp = 0;
+    param->cpu = &cpus[0];
+
+    for(i = 0; i < sizeof(type2flags)/sizeof(struct t2f); i++) {
+        size_t len = strlen(type2flags[i].text);
+
+        if(!strncmp(text, type2flags[i].text, len)) {
+            param->type = type2flags[i].flag;
+            text += len;
+            goto fpflags;
+        }
+    }
+
+    return -1;
+
+  fpflags:
+    if (*text == '\0')
+        return 0;
+
+    if (isdigit(*text))
+        goto cpu_nr;
+    
+    for(i = 0; i < sizeof(fp2flags)/sizeof(struct t2f); i++) {
+        size_t len = strlen(fp2flags[i].text);
+        
+        if(!strncmp(text, fp2flags[i].text, len)) {
+            param->fp |= fp2flags[i].flag;
+            text += len;
+            
+            goto fpflags;
+        }
+    }
+
+    return -1;
+
+  cpu_nr:
+    cpu = strtoul(text, &cpu_end, 0);
+
+    if (*cpu_end != '\0' || ((cpu == 0 || cpu == ULONG_MAX) && errno))
+        return -1;
+
+    param->cpu = &cpus[cpu];
+    return 0;
+}
+
+static int check_arg(const struct task_params *param, struct cpu_tasks *end_cpu)
+{
+    if (param->cpu > end_cpu - 1)
+        return -1;
+
+    switch (param->type) {
+    case IDLE:
+        if (param->fp)
+            return -1;
+        break;
+
+    case RTK:
+        if (param->fp & UFPS)
+            return -1;
+        break;
+
+    case RTUP:
+        if (param->fp & UFPS)
+            return -1;
+        break;
+
+    case RTUS:
+        if (param->fp & UFPP)
+            return -1;
+        break;
+
+    case RTUO:
+        break;
+    default:
+        return -1;
+    }
+
+    return 0;
+}
+
+static void post_sem_on_sig(int sig)
+{
+    __real_sem_post(&terminate);
+    signal(sig, SIG_DFL);
+}
+
+const char *all_nofp [] = {
+    "rtk",
+    "rtk",
+    "rtup",
+    "rtup",
+    "rtus",
+    "rtus",
+    "rtuo",
+    "rtuo",
+};
+
+const char *all_fp [] = {
+    "rtk",
+    "rtk",
+    "rtk_fp",
+    "rtk_fp",
+    "rtk_fp_ufpp",
+    "rtk_fp_ufpp",
+    "rtup",
+    "rtup",
+    "rtup_ufpp",
+    "rtup_ufpp",
+    "rtus",
+    "rtus",
+    "rtus_ufps",
+    "rtus_ufps",
+    "rtuo",
+    "rtuo",
+    "rtuo_ufpp",
+    "rtuo_ufpp",
+    "rtuo_ufps",
+    "rtuo_ufps",
+    "rtuo_ufpp_ufps",
+    "rtuo_ufpp_ufps"
+};
+
+void usage(FILE *fd, const char *progname)
+{
+    unsigned i;
+    
+    fprintf(fd,
+            "Usage:\n"
+            "%s threadspec threadspec...\n"
+            "or %s [-n]\n\n"
+            "Where threadspec specifies the characteristics of a thread to be "
+            "created:\n"
+            "threadspec = (rtk|rtup|rtus|rtuo)(_fp|_ufpp|_ufps)*[0-9]*\n"
+            "rtk for a kernel-space real-time thread;\n"
+            "rtup for a user-space real-time thread running in primary mode,\n"
+            "rtus for a user-space real-time thread running in secondary mode,\n"
+            "rtuo for a user-space real-time thread oscillating between primary "
+            "and\n     secondary mode,\n\n"
+            "_fp means that the created thread will have the XNFPU bit armed "
+            "(only valid for\n     rtk),\n"
+            "_ufpp means that the created thread will use the FPU when in "
+            "primary mode\n     (invalid for rtus),\n"
+            "_ufps means that the created thread will use the FPU when in "
+            "secondary mode\n     (invalid for rtk and rtup),\n\n"
+            "[0-9]* specifies the ID of the CPU where the created thread will "
+            "run, 0 if\n       unspecified.\n\n"
+            "Passing no argument is equivalent to running for each cpu:\n%s",
+            progname, progname, progname);
+
+    for (i = 0; i < sizeof(all_fp)/sizeof(char *); i++)
+        fprintf(fd, " %s", all_fp[i]);
+
+    fprintf(fd,
+            "\n\nPassing only the -n argument is equivalent to running for each"
+            " cpu:\n%s",
+            progname);
+
+    for (i = 0; i < sizeof(all_nofp)/sizeof(char *); i++)
+        fprintf(fd, " %s", all_fp[i]);
+    fprintf(fd, "\n\n");
+}
+
+int main(int argc, const char *argv[])
+{
+    const char **all, *progname = argv[0];
+    unsigned i, j, count, nr_cpus;
+    struct cpu_tasks *cpus;
+    pthread_attr_t rt_attr, idle_attr;
+    struct sched_param sp;
+
+    /* Initializations. */
+    if (__real_sem_init(&idle_start, 0, 0)) {
+        perror("sem_init");
+        exit(EXIT_FAILURE);
+    }
+
+    if (__real_sem_init(&terminate, 0, 0)) {
+        perror("sem_init");
+        exit(EXIT_FAILURE);
+    }
+
+    if (mlockall(MCL_CURRENT|MCL_FUTURE)) {
+        perror("mlockall");
+        exit(EXIT_FAILURE);
+    }
+
+    all = all_fp;
+    count = sizeof(all_fp) / sizeof(char *);
+    nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    if (nr_cpus == -1) {
+        fprintf(stderr, "Error %d while getting the number of cpus (%s)\n",
+                errno, strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+
+    cpus = (struct cpu_tasks *) malloc(sizeof(*cpus) * nr_cpus);
+
+    for (i = 0; i < nr_cpus; i++) {
+        size_t size;
+        cpus[i].index = i;
+        cpus[i].capacity = 2;
+        size = cpus[i].capacity * sizeof(struct task_params);
+        cpus[i].tasks_count = 1;
+        cpus[i].tasks = (struct task_params *) malloc(size);
+        cpus[i].tasks[0].type = IDLE;
+        cpus[i].tasks[0].fp = 0;
+        cpus[i].tasks[0].cpu = &cpus[i];        
+    }
+
+    /* Check for -n, -h or --help flag. */
+    for (i = 1; i < argc; i++) {
+        if (!strcmp(argv[i], "-n")) {
+            if (argc != 2) {
+                usage(stderr, progname);
+                fprintf(stderr,
+                        "-n option may only be used with no other argument.\n");
+                exit(EXIT_FAILURE);
+            }
+
+            all = all_nofp;
+            count = sizeof(all_nofp) / sizeof(char *);
+            --argc;
+        }
+
+        if (!strcmp(argv[i], "-h") || !strcmp(argv[i], "--help")) {
+            usage(stdout, progname);
+            exit(EXIT_SUCCESS);
+        }
+    }
+
+    if (setvbuf(stdout, NULL, _IOLBF, 0)) {
+        perror("setvbuf");
+        exit(EXIT_FAILURE);
+    }
+
+    /* If no argument was passed (or only -n), replace argc and argv with
+       default values, given by all_fp or all_nofp depending on the presence of
+       the -n flag. */
+    if (argc == 1) {
+        char buffer[32];
+
+        argc = count * nr_cpus + 1;
+        argv = (const char **) malloc(argc * sizeof(char *));
+        argv[0] = progname;
+        for (i = 0; i < nr_cpus; i++)
+            for (j = 0; j < count; j++) {
+                snprintf(buffer, sizeof(buffer), "%s%d", all[j], i);
+                argv[i * count + j + 1] = strdup(buffer);
+            }
+    }
+
+    /* Parse arguments and build data structures. */
+    for(i = 1; i < argc; i++) {
+        struct task_params params;
+        struct cpu_tasks *cpu;
+
+        if(parse_arg(&params, argv[i], cpus)) {
+            usage(stderr, progname);
+            fprintf(stderr, "Unable to parse %s. Aborting.\n", argv[i]);
+            exit(EXIT_FAILURE);
+        }
+
+        if (check_arg(&params, &cpus[nr_cpus])) {
+            usage(stderr, progname);
+            fprintf(stderr, "Invalid parameters %s. Aborting\n", argv[i]);
+            exit(EXIT_FAILURE);
+        }
+
+        cpu = params.cpu;
+        if(++cpu->tasks_count > cpu->capacity) {
+            size_t size;
+            cpu->capacity += cpu->capacity / 2;
+            size = cpu->capacity * sizeof(struct task_params);
+            cpu->tasks = (struct task_params *) realloc(cpu->tasks, size);
+        }
+
+        cpu->tasks[cpu->tasks_count - 1] = params;
+    }
+
+    /* Post the semaphore "terminate" on termination signals. */
+    if (signal(SIGINT, &post_sem_on_sig)) {
+        perror("signal");
+        exit(EXIT_FAILURE);
+    }
+    if (signal(SIGTERM, &post_sem_on_sig)) {
+        perror("signal");
+        exit(EXIT_FAILURE);
+    }
+
+    /* Prepare attributes for real-time tasks. */
+    pthread_attr_init(&rt_attr);
+    pthread_attr_setinheritsched(&rt_attr, PTHREAD_EXPLICIT_SCHED);
+    pthread_attr_setschedpolicy(&rt_attr, SCHED_FIFO);
+    sp.sched_priority = 1;
+    pthread_attr_setschedparam(&rt_attr, &sp);
+    pthread_attr_setstacksize(&rt_attr, 20 * 1024);
+
+    /* Prepare attribute for idle tasks. */
+    pthread_attr_init(&idle_attr);
+    pthread_attr_setstacksize(&rt_attr, 20 * 1024);
+
+    /* Create and register all tasks. */
+    for (i = 0; i < nr_cpus; i ++) {
+        struct cpu_tasks *cpu = &cpus[i];
+
+        cpu->fd = open("rtswitch0", O_RDWR);
+
+        if (cpu->fd == -1) {
+            perror("open(\"rtswitch0\")");
+            exit(EXIT_FAILURE);
+        }
+
+        if (ioctl(cpu->fd, RTSWITCH_RTIOC_TASKS_COUNT, cpu->tasks_count)) {
+            perror("ioctl(RTSWITCH_RTIOC_TASKS_COUNT)");
+            exit(EXIT_FAILURE);
+        }
+
+        if (ioctl(cpu->fd, RTSWITCH_RTIOC_SET_CPU, i)) {
+            perror("ioctl(RTSWITCH_RTIOC_SET_CPU)");
+            exit(EXIT_FAILURE);
+        }
+
+        for (j = 0; j < cpu->tasks_count; j++) {
+            struct task_params *param = &cpu->tasks[j];
+            void *(*task_routine)(void *) = NULL;
+            pthread_attr_t *attr = &rt_attr;
+            const char *basename = NULL;
+            int err;
+
+            switch(param->type) {
+            case RTK:
+                param->swt.flags = (param->fp & FP ? RTSWITCH_FPU : 0)
+                    | (param->fp & UFPP ? RTSWITCH_USE_FPU : 0);
+
+                if (ioctl(cpu->fd, RTSWITCH_RTIOC_CREATE_KTASK, &param->swt)) {
+                    perror("ioctl(RTSWITCH_RTIOC_CREATE_KTASK)");
+                    exit(EXIT_FAILURE);
+                }
+                break;
+
+            case IDLE:
+                task_routine = idle;
+                attr = &idle_attr;
+                goto do_register;
+                
+            case RTUP:
+                task_routine = rtup;
+                basename = "rtup";
+                goto do_register;
+                
+            case RTUS:
+                task_routine = rtus;
+                basename = "rtus";
+                goto do_register;
+                
+            case RTUO:
+                task_routine = rtuo;
+                basename = "rtuo";
+            do_register:
+                param->swt.flags = 0;
+
+                if (ioctl(cpu->fd, RTSWITCH_RTIOC_REGISTER_UTASK, &param->swt)) {
+                    perror("ioctl(RTSWITCH_RTIOC_REGISTER_UTASK)");
+                    exit(EXIT_FAILURE);
+                }
+                break;
+
+            default:
+                fprintf(stderr, "Invalid type %d. Aborting\n", param->type);
+                exit(EXIT_FAILURE);
+            }
+
+            if (param->type != RTK) {
+                err = pthread_create(&param->thread, attr, task_routine, param);
+
+                if (err) {
+                    fprintf(stderr, "pthread_create: %s\n", strerror(err));
+                    exit(EXIT_FAILURE);
+                }
+
+                if (param->type != IDLE) {
+                    char name [64];
+
+                    snprintf(name, sizeof(name), "%s%u/%u",
+                             basename, param->swt.index, i);
+
+                    err = pthread_set_name_np(param->thread, name);
+                        
+                    if (err) {
+                        fprintf(stderr, "pthread_set_name_np: %s\n",
+                                strerror(err));
+                        exit(EXIT_FAILURE);
+                    }
+                }
+            }
+        }
+    }
+
+    /* Start the idle tasks. */
+    for (i = 0; i < nr_cpus; i ++)
+        __real_sem_post(&idle_start);
+
+    /* Wait for interruption. */
+    __real_sem_wait(&terminate);
+
+    /* Cleanup. */
+    for (i = 0; i < nr_cpus; i ++) {
+        struct cpu_tasks *cpu = &cpus[i];
+        for (j = 0; j < cpu->tasks_count; j++) {
+            struct task_params *param = &cpu->tasks[j];
+
+            if (param->type != RTK)
+                pthread_cancel(param->thread); /* kill the user-space tasks. */
+        }
+        
+        for (j = 0; j < cpu->tasks_count; j++) {
+            struct task_params *param = &cpu->tasks[j];
+
+            if (param->type != RTK)
+                pthread_join(param->thread, NULL);
+        }
+
+        close(cpu->fd);         /* kill the kernel-space tasks. */
+        free(cpu->tasks);
+    }
+    free(cpus);
+    __real_sem_destroy(&idle_start);
+    __real_sem_destroy(&terminate);
+
+    return 0;
+}
Index: configure.in
===================================================================
--- configure.in	(revision 1143)
+++ configure.in	(working copy)
@@ -564,6 +564,7 @@
        	src/testsuite/latency/Makefile \
        	src/testsuite/switch/Makefile \
        	src/testsuite/cyclic/Makefile \
+       	src/testsuite/switchtest/Makefile \
        	include/Makefile \
        	include/asm-generic/Makefile \
        	include/asm-blackfin/Makefile \
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchtest/Makefile.am	2006-05-31 07:45:50.000000000 +0200
@@ -0,0 +1,27 @@
+testdir = $(prefix)/testsuite/switchtest
+
+test_PROGRAMS = switchtest
+
+switchtest_SOURCES = switchtest.c
+
+switchtest_CPPFLAGS = -I$(top_srcdir)/include/posix $(XENO_USER_CFLAGS) -g -I$(top_srcdir)/include
+
+switchtest_LDFLAGS = $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
+
+switchtest_LDADD = \
+	-lpthread -lrt \
+	../../skins/posix/.libs/libpthread_rt.a
+
+install-data-local:
+	$(mkinstalldirs) $(DESTDIR)$(testdir)
+	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(testdir)/run
+	@chmod +x $(DESTDIR)$(testdir)/run
+
+uninstall-local:
+	$(RM) $(DESTDIR)$(testdir)/.runinfo $(DESTDIR)$(testdir)/run
+
+run: all
+	@$(top_srcdir)/scripts/xeno-load --verbose
+
+EXTRA_DIST = runinfo
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchtest/runinfo	2006-05-31 07:58:17.000000000 +0200
@@ -0,0 +1 @@
+cyclictest:posix+rtdm+switchtest:!./switchtest;popall:control_c
Index: src/testsuite/Makefile.am
===================================================================
--- src/testsuite/Makefile.am	(revision 1143)
+++ src/testsuite/Makefile.am	(working copy)
@@ -1 +1 @@
-SUBDIRS = latency switch cyclic
+SUBDIRS = latency switch cyclic switchtest
Index: ksrc/drivers/benchmark/Kconfig
===================================================================
--- ksrc/drivers/benchmark/Kconfig	(revision 1143)
+++ ksrc/drivers/benchmark/Kconfig	(working copy)
@@ -5,3 +5,11 @@
 	help
 	Kernel-based benchmark driver for timer latency evaluation.
 	See testsuite/latency for a possible front-end.
+
+config XENO_DRIVERS_SWITCHTEST
+        depends on XENO_SKIN_RTDM
+        tristate "Context switch unit testing driver"
+        default n
+        help
+        Kernel-based driver for unit testing context switches and 
+        FPU switches.
Index: ksrc/drivers/benchmark/Config.in
===================================================================
--- ksrc/drivers/benchmark/Config.in	(revision 1143)
+++ ksrc/drivers/benchmark/Config.in	(working copy)
@@ -3,3 +3,5 @@
 #
 
 dep_tristate 'Timer benchmark driver' CONFIG_XENO_DRIVERS_TIMERBENCH $CONFIG_XENO_SKIN_RTDM
+
+dep_tristate 'Context switches test driver' CONFIG_XENO_DRIVERS_SWITCHTEST $CONFIG_XENO_SKIN_RTDM
Index: ksrc/drivers/benchmark/Makefile
===================================================================
--- ksrc/drivers/benchmark/Makefile	(revision 1143)
+++ ksrc/drivers/benchmark/Makefile	(working copy)
@@ -6,8 +6,12 @@
 
 obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
 
+obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
+
 xeno_timerbench-y := timerbench.o
 
+xeno_switchtest-y := switchtest.o
+
 EXTRA_CFLAGS += -Iinclude/xenomai
 
 else
@@ -18,12 +22,16 @@
 
 obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) := xeno_timerbench.o
 
+obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) := xeno_switchtest.o
+
 list-multi := xeno_timerbench.o
 
 xeno_timerbench-objs := timerbench.o
 
-export-objs := $(xeno_timerbench-objs)
+xeno_switchtest-objs := switchtest.o
 
+export-objs := $(xeno_timerbench-objs) $(xeno_switchtest-objs)
+
 EXTRA_CFLAGS += -I$(TOPDIR)/include/xenomai -I$(TOPDIR)/include/xenomai/compat
 
 include $(TOPDIR)/Rules.make
@@ -31,4 +39,7 @@
 xeno_timerbench.o: $(xeno_timerbench-objs)
 	$(LD) -r -o $@ $(xeno_timerbench-objs)
 
+xeno_switchtest.o: $(xeno_switchtest-objs)
+	$(LD) -r -o $@ $(xeno_switchtest-objs)
+
 endif

--s2LBNsv77J--

