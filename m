From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="O3bnNIjOcb"
Content-Transfer-Encoding: 7bit
Message-ID: <17543.5163.684144.582942@domain.hid>
Date: Wed, 7 Jun 2006 20:00:11 +0200
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
In-Reply-To: <17536.40316.183366.284818@domain.hid>
References: <17536.40316.183366.284818@domain.hid>
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


--O3bnNIjOcb
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > 
 > Now that the big context switches bugs have been solved, here is a patch
 > that adds a unit test for context switches and FPU switches
 > with various type of threads (kernel, user, user in secondary mode,
 > not using FPU, using FPU, etc...). As is the case of the latency test
 > there is a small RTDM driver in kernel-space, put in the benchmark
 > class, even though this test is for unit testing, not for benchmarking.
 > 
 > The FPU switches need a small piece of code architecture dependent,
 > put in <asm/xenomai/fptest.h>, currently only implemented for x86.
 > 
 > The kernel-space driver is called xeno_switchtest.ko, the user-space
 > testing tool is called switchtest, because there is already a context
 > switch benchmarking tool called "switch".

Here is an updated version, applying the remarks of Jim and Jan:
renamed rtbenchmark rttesting, and renamed the already existing context
switch benchmark switchbench. The patch is large but contains mostly
renames.

I would prefer to commit this version before implementing the other
changes, namely allowing kernel-space non real-time tasks to use the FPU
and merging the context switches benchmark test with this test.

-- 


					    Gilles Chanteperdrix.

--O3bnNIjOcb
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-switchtest.2.diff"
Content-Transfer-Encoding: 7bit

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
+++ ksrc/drivers/testing/switchtest.c	2006-06-07 19:11:12.000000000 +0200
@@ -0,0 +1,504 @@
+#include <nucleus/synch.h>
+#include <nucleus/thread.h>
+#include <rtdm/rttesting.h>
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
+    device_class: RTDM_CLASS_TESTING,
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
+++ src/testsuite/switchtest/switch.c	2006-06-07 18:49:00.000000000 +0200
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
+#include <rtdm/rttesting.h>
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
+    if (lhs->tv_nsec >= rhs->tv_nsec)
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
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchtest/runinfo	2006-06-07 19:42:18.000000000 +0200
@@ -0,0 +1 @@
+switch:posix+rtdm+switchtest:!./switch;popall:control_c
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchtest/Makefile.am	2006-06-07 18:53:07.000000000 +0200
@@ -0,0 +1,27 @@
+testdir = $(prefix)/testsuite/switchtest
+
+test_PROGRAMS = switch
+
+switch_SOURCES = switch.c
+
+switch_CPPFLAGS = -I$(top_srcdir)/include/posix $(XENO_USER_CFLAGS) -g -I$(top_srcdir)/include
+
+switch_LDFLAGS = $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)
+
+switch_LDADD = \
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
Index: include/rtdm/rtbenchmark.h
===================================================================
--- include/rtdm/rtbenchmark.h	(revision 1168)
+++ include/rtdm/rtbenchmark.h	(working copy)
@@ -1,144 +0,0 @@
-/**
- * @file
- * Real-Time Driver Model for Xenomai, benchmark device profile header
- *
- * @note Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * @ingroup rtbenchmark
- */
-
-/*!
- * @ingroup profiles
- * @defgroup rtbenchmark Benchmark Devices
- *
- * This group of devices is intended to provide in-kernel benchmark results.
- * Feel free to comment on this profile via the Xenomai mailing list
- * (Xenomai-help@domain.hid) or directly to the author (jan.kiszka@domain.hid). @n
- * @n
- *
- * @par Device Characteristics
- * @ref rtdm_device.device_flags "Device Flags": @c RTDM_NAMED_DEVICE, @c RTDM_EXCLUSIVE @n
- * @n
- * @ref rtdm_device.device_name "Device Name": @c "rtbenchmark<N>", N >= 0 @n
- * @n
- * @ref rtdm_device.device_class "Device Class": @c RTDM_CLASS_BENCHMARK @n
- * @n
- *
- * @par Supported Operations
- * @b Open @n
- * Environments: non-RT (RT optional)@n
- * Specific return values: none @n
- * @n
- * @b Close @n
- * Environments: non-RT (RT optional)@n
- * Specific return values: none @n
- * @n
- * @b IOCTL @n
- * Mandatory Environments: see @ref IOCTLs "below" @n
- * Specific return values: see @ref IOCTLs "below" @n
- *
- * @{
- */
-
-#ifndef _RTBENCHMARK_H
-#define _RTBENCHMARK_H
-
-#include <rtdm/rtdm.h>
-
-#define RTBNCH_TIMER_TASK       0
-#define RTBNCH_TIMER_HANDLER    1
-
-typedef struct rtbnch_result {
-    long long               avg;
-    long                    min;
-    long                    max;
-    long                    overruns;
-    long                    test_loops;
-} rtbnch_result_t;
-
-typedef struct rtbnch_timerconfig {
-    int                     mode;
-    uint64_t                period;
-    int                     warmup_loops;
-    int                     histogram_size;
-    int                     histogram_bucketsize;
-    int                     freeze_max;
-} rtbnch_timerconfig_t;
-
-typedef struct rtbnch_interm_result {
-    struct rtbnch_result    last;
-    struct rtbnch_result    overall;
-} rtbnch_interm_result_t;
-
-typedef struct rtbnch_overall_result {
-    struct rtbnch_result    result;
-    long                    *histogram_avg;
-    long                    *histogram_min;
-    long                    *histogram_max;
-} rtbnch_overall_result_t;
-
-typedef struct rtbnch_trace_special {
-    unsigned char           id;
-    long                    v;
-} rtbnch_trace_special_t;
-
-
-#define RTIOC_TYPE_BENCHMARK        RTDM_CLASS_BENCHMARK
-
-
-/*!
- * @name Sub-Classes of RTDM_CLASS_BENCHMARK
- * @{ */
-#define RTDM_SUBCLASS_TIMER         0
-/** @} */
-
-
-/*!
- * @anchor IOCTLs @name IOCTLs
- * Benchmark device IOCTLs
- * @{ */
-#define RTBNCH_RTIOC_INTERM_RESULT      \
-    _IOWR(RTIOC_TYPE_BENCHMARK, 0x00, struct rtbnch_interm_result)
-
-#define RTBNCH_RTIOC_START_TMTEST       \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x10, struct rtbnch_timerconfig)
-
-#define RTBNCH_RTIOC_STOP_TMTEST        \
-    _IOWR(RTIOC_TYPE_BENCHMARK, 0x11, struct rtbnch_overall_result)
-
-#define RTBNCH_RTIOC_BEGIN_TRACE        \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x20, long)
-
-#define RTBNCH_RTIOC_END_TRACE          \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x21, long)
-
-#define RTBNCH_RTIOC_FREEZE_TRACE       \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x22, long)
-
-#define RTBNCH_RTIOC_REFREEZE_TRACE     \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x23, long)
-
-#define RTBNCH_RTIOC_SPECIAL_TRACE      \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x24, unsigned char)
-
-#define RTBNCH_RTIOC_SPECIAL_TRACE_EX   \
-    _IOW(RTIOC_TYPE_BENCHMARK, 0x25, struct rtbnch_trace_special)
-/** @} */
-
-/** @} */
-
-#endif /* _RTBENCHMARK_H */
Index: include/rtdm/Makefile.am
===================================================================
--- include/rtdm/Makefile.am	(revision 1168)
+++ include/rtdm/Makefile.am	(working copy)
@@ -7,4 +7,4 @@
 	rtdm.h \
 	rtdm_driver.h \
 	rtserial.h \
-	rtbenchmark.h
+	rttesting.h
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ include/rtdm/rttesting.h	2006-06-07 18:50:14.000000000 +0200
@@ -0,0 +1,188 @@
+/**
+ * @file
+ * Real-Time Driver Model for Xenomai, benchmark device profile header
+ *
+ * @note Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * @ingroup rtbenchmark
+ */
+
+/*!
+ * @ingroup profiles
+ * @defgroup rtbenchmark Timer benchmark Device
+ *
+ * This group of devices is intended to provide in-kernel benchmark results.
+ * Feel free to comment on this profile via the Xenomai mailing list
+ * (Xenomai-help@domain.hid) or directly to the author (jan.kiszka@domain.hid). @n
+ * @n
+ *
+ * @par Device Characteristics
+ * @ref rtdm_device.device_flags "Device Flags": @c RTDM_NAMED_DEVICE, @c RTDM_EXCLUSIVE @n
+ * @n
+ * @ref rtdm_device.device_name "Device Name": @c "rtbenchmark<N>", N >= 0 @n
+ * @n
+ * @ref rtdm_device.device_class "Device Class": @c RTDM_CLASS_TESTING @n
+ * @n
+ *
+ * @par Supported Operations
+ * @b Open @n
+ * Environments: non-RT (RT optional)@n
+ * Specific return values: none @n
+ * @n
+ * @b Close @n
+ * Environments: non-RT (RT optional)@n
+ * Specific return values: none @n
+ * @n
+ * @b IOCTL @n
+ * Mandatory Environments: see @ref IOCTLs "below" @n
+ * Specific return values: see @ref IOCTLs "below" @n
+ *
+ * @{
+ */
+
+#ifndef _RTBENCHMARK_H
+#define _RTBENCHMARK_H
+
+#include <rtdm/rtdm.h>
+
+#define RTBNCH_TIMER_TASK       0
+#define RTBNCH_TIMER_HANDLER    1
+
+typedef struct rtbnch_result {
+    long long               avg;
+    long                    min;
+    long                    max;
+    long                    overruns;
+    long                    test_loops;
+} rtbnch_result_t;
+
+typedef struct rtbnch_timerconfig {
+    int                     mode;
+    uint64_t                period;
+    int                     warmup_loops;
+    int                     histogram_size;
+    int                     histogram_bucketsize;
+    int                     freeze_max;
+} rtbnch_timerconfig_t;
+
+typedef struct rtbnch_interm_result {
+    struct rtbnch_result    last;
+    struct rtbnch_result    overall;
+} rtbnch_interm_result_t;
+
+typedef struct rtbnch_overall_result {
+    struct rtbnch_result    result;
+    long                    *histogram_avg;
+    long                    *histogram_min;
+    long                    *histogram_max;
+} rtbnch_overall_result_t;
+
+typedef struct rtbnch_trace_special {
+    unsigned char           id;
+    long                    v;
+} rtbnch_trace_special_t;
+
+
+#define RTIOC_TYPE_BENCHMARK        RTDM_CLASS_TESTING
+
+/*!
+ * @name Sub-Classes of RTDM_CLASS_TESTING
+ * @{ */
+#define RTDM_SUBCLASS_TIMER         0
+
+#define RTDM_SUBCLASS_SWITCH        1
+/** @} */
+
+
+/*!
+ * @anchor TIMER_IOCTLs @name TIMER_IOCTLs
+ * Timer benchmark device IOCTLs
+ * @{ */
+#define RTBNCH_RTIOC_INTERM_RESULT      \
+    _IOWR(RTIOC_TYPE_BENCHMARK, 0x00, struct rtbnch_interm_result)
+
+#define RTBNCH_RTIOC_START_TMTEST       \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x10, struct rtbnch_timerconfig)
+
+#define RTBNCH_RTIOC_STOP_TMTEST        \
+    _IOWR(RTIOC_TYPE_BENCHMARK, 0x11, struct rtbnch_overall_result)
+
+#define RTBNCH_RTIOC_BEGIN_TRACE        \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x20, long)
+
+#define RTBNCH_RTIOC_END_TRACE          \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x21, long)
+
+#define RTBNCH_RTIOC_FREEZE_TRACE       \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x22, long)
+
+#define RTBNCH_RTIOC_REFREEZE_TRACE     \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x23, long)
+
+#define RTBNCH_RTIOC_SPECIAL_TRACE      \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x24, unsigned char)
+
+#define RTBNCH_RTIOC_SPECIAL_TRACE_EX   \
+    _IOW(RTIOC_TYPE_BENCHMARK, 0x25, struct rtbnch_trace_special)
+/** @} */
+
+
+#define RTIOC_TYPE_SWITCH           RTDM_CLASS_TESTING
+
+#define RTSWITCH_FPU     0x1
+#define RTSWITCH_USE_FPU 0x2 /* Only for kernel-space tasks. */
+
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
+/**
+ * @anchor SWITCH_IOCTLs @name @SWITCH_IOCTLs
+ * Context-switch testing device IOCTLs
+ * @{ */
+#define RTSWITCH_RTIOC_TASKS_COUNT                   \
+    _IOW(RTIOC_TYPE_SWITCH, 0x30, unsigned long)
+
+#define RTSWITCH_RTIOC_SET_CPU \
+    _IOW(RTIOC_TYPE_SWITCH, 0x31, unsigned long)
+
+#define RTSWITCH_RTIOC_REGISTER_UTASK \
+    _IOW(RTIOC_TYPE_SWITCH, 0x32, struct rtswitch_task)
+
+#define RTSWITCH_RTIOC_CREATE_KTASK \
+    _IOWR(RTIOC_TYPE_SWITCH, 0x33, struct rtswitch_task)
+
+#define RTSWITCH_RTIOC_PEND \
+    _IOR(RTIOC_TYPE_SWITCH, 0x34, struct rtswitch_task)
+
+#define RTSWITCH_RTIOC_SWITCH_TO \
+    _IOR(RTIOC_TYPE_SWITCH, 0x35, struct rtswitch)
+
+#define RTSWITCH_RTIOC_GET_SWITCHES_COUNT \
+    _IOR(RTIOC_TYPE_SWITCH, 0x36, unsigned long)
+/** @} */
+
+/** @} */
+
+#endif /* _RTBENCHMARK_H */
Index: include/rtdm/rtdm.h
===================================================================
--- include/rtdm/rtdm.h	(revision 1168)
+++ include/rtdm/rtdm.h	(working copy)
@@ -68,7 +68,7 @@
 #define RTDM_CLASS_CAN              3
 #define RTDM_CLASS_NETWORK          4
 #define RTDM_CLASS_RTMAC            5
-#define RTDM_CLASS_BENCHMARK        6
+#define RTDM_CLASS_TESTING          6
 /*
 #define RTDM_CLASS_USB              ?
 #define RTDM_CLASS_FIREWIRE         ?
Index: configure.in
===================================================================
--- configure.in	(revision 1168)
+++ configure.in	(working copy)
@@ -562,8 +562,9 @@
 	src/include/Makefile \
        	src/testsuite/Makefile \
        	src/testsuite/latency/Makefile \
-       	src/testsuite/switch/Makefile \
+       	src/testsuite/switchbench/Makefile \
        	src/testsuite/cyclic/Makefile \
+       	src/testsuite/switchtest/Makefile \
        	include/Makefile \
        	include/asm-generic/Makefile \
        	include/asm-blackfin/Makefile \
Index: src/testsuite/latency/latency.c
===================================================================
--- src/testsuite/latency/latency.c	(revision 1168)
+++ src/testsuite/latency/latency.c	(working copy)
@@ -11,7 +11,7 @@
 #include <native/task.h>
 #include <native/timer.h>
 #include <native/sem.h>
-#include <rtdm/rtbenchmark.h>
+#include <rtdm/rttesting.h>
 
 RT_TASK latency_task, display_task;
 
Index: src/testsuite/switch/runinfo
===================================================================
--- src/testsuite/switch/runinfo	(revision 1168)
+++ src/testsuite/switch/runinfo	(working copy)
@@ -1 +0,0 @@
-switch:native:!./switch;popall:control_c
Index: src/testsuite/switch/switch.c
===================================================================
--- src/testsuite/switch/switch.c	(revision 1168)
+++ src/testsuite/switch/switch.c	(working copy)
@@ -1,223 +0,0 @@
-/*
-   Task switch latency test.
-   Max Krasnyansky <maxk@domain.hid
-
-   Based on latency.c by Philippe Gerum <rpm@xenomai.org>
- */
-
-#include <sys/mman.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <signal.h>
-#include <getopt.h>
-#include <native/task.h>
-#include <native/timer.h>
-#include <native/sem.h>
-
-RT_TASK event_task, worker_task;
-
-RT_SEM switch_sem;
-RTIME  switch_tsc;
-unsigned long long switch_count;
-
-long long minjitter = 10000000;
-long long maxjitter = -10000000;
-long long avgjitter = 0;
-long long lost = 0;
-long long nsamples = 100000;
-long long sampling_period = 100000;
-
-#define HISTOGRAM_CELLS 100
-
-unsigned long histogram[HISTOGRAM_CELLS];
-
-int do_histogram = 0;
-int ignore = 5;
-
-static inline void add_histogram(long addval)
-{
-       long inabs = rt_timer_tsc2ns(addval >= 0 ? addval : -addval) / 1000;  /* usec steps */
-       histogram[inabs < HISTOGRAM_CELLS ? inabs : HISTOGRAM_CELLS - 1]++;
-}
-
-void dump_histogram(void)
-{
-       int n;
-
-       for (n = 0; n < HISTOGRAM_CELLS; n++) {
-               long hits = histogram[n];
-               if (hits)
-                       fprintf(stderr, "%d - %d us: %ld\n", n, n + 1, hits);
-       }
-}
-
-void event(void *cookie)
-{
-       int err;
-
-       err = rt_task_set_periodic(NULL,
-                                  TM_NOW,
-                                  rt_timer_ns2ticks(sampling_period));
-       if (err) {
-               fprintf(stderr,"switch: failed to set periodic, code %d\n", err);
-               return;
-       }
-
-       for (;;) {
-               err = rt_task_wait_period(NULL);
-               if (err) {
-                       if (err != -ETIMEDOUT) {
-                               /* Timer stopped. */
-                               rt_task_delete(NULL);
-                       }
-               }
-
-               switch_count++;
-               switch_tsc = rt_timer_tsc();
-
-               rt_sem_broadcast(&switch_sem);
-       }
-}
-
-void worker(void *cookie)
-{
-       long long minj = 10000000, maxj = -10000000, dt, sumj = 0;
-       unsigned long long count = 0;
-       int err, n;
-
-       err = rt_sem_create(&switch_sem, "dispsem", 0, S_FIFO);
-       if (err) {
-               fprintf(stderr,"switch: cannot create semaphore: %s\n",
-                      strerror(-err));
-               return;
-       }
-
-       for (n=0; n<nsamples; n++) {
-               err = rt_sem_p(&switch_sem, TM_INFINITE);
-               if (err) {
-                       if (err != -EIDRM)
-                               fprintf(stderr,"switch: failed to pend on semaphore, code %d\n", err);
-
-                       rt_task_delete(NULL);
-               }
-
-               if (++count != switch_count) {
-                       count = switch_count;
-                       lost++;
-                       continue;
-               }
-
-               // First few switches are slow.
-               // Probably due to the Linux <-> RT context migration at task startup.
-               if (count < ignore)
-                       continue;
-
-               dt = (long) (rt_timer_tsc() - switch_tsc);
-               if (dt > maxj)
-                       maxj = dt;
-               if (dt < minj)
-                       minj = dt;
-               sumj += dt;
-
-               if (do_histogram)
-                       add_histogram(dt);
-       }
-
-       rt_sem_delete(&switch_sem);
-
-       minjitter = minj;
-       maxjitter = maxj;
-       avgjitter = sumj / n;
-
-       printf("RTH|%12s|%12s|%12s|%12s\n",
-                      "lat min", "lat avg", "lat max", "lost");
-
-       printf("RTD|%12Ld|%12Ld|%12Ld|%12lld\n",
-                      rt_timer_tsc2ns(minjitter),
-                      rt_timer_tsc2ns(avgjitter),
-                      rt_timer_tsc2ns(maxjitter), lost);
-
-       if (do_histogram)
-               dump_histogram();
-
-       exit(0);
-}
-
-int main(int argc, char **argv)
-{
-       int err, c;
-
-       while ((c = getopt(argc, argv, "hp:n:i:")) != EOF)
-               switch (c) {
-               case 'h':
-                       /* ./switch --h[istogram] */
-                       do_histogram = 1;
-                       break;
-
-               case 'p':
-                       sampling_period = atoi(optarg) * 1000;
-                       break;
-
-               case 'n':
-                       nsamples = atoi(optarg);
-                       break;
-
-               case 'i':
-                       ignore = atoi(optarg);
-                       break;
-
-               default:
-
-                       fprintf(stderr, "usage: switch [options]\n"
-                               "\t-h             - enable histogram\n" 
-                               "\t-p <period_us> - timer period\n"
-                               "\t-n <samples>   - number of samples to collect\n"
-                               "\t-i <samples>   - number of _first_ samples to ignore\n");
-                       exit(2);
-               }
-
-       if (sampling_period == 0)
-               sampling_period = 100000;       /* ns */
-
-       signal(SIGINT, SIG_IGN);
-       signal(SIGTERM, SIG_IGN);
-
-       setlinebuf(stdout);
-
-       mlockall(MCL_CURRENT|MCL_FUTURE);
-       
-       printf("== Sampling period: %llu us\n", sampling_period / 1000);
-       printf("== Do not interrupt this program\n");
-
-       rt_timer_set_mode(TM_ONESHOT); /* Force aperiodic timing. */
-
-       err = rt_task_create(&worker_task, "worker", 0, 98, T_FPU);
-       if (err) {
-               fprintf(stderr,"switch: failed to create worker task, code %d\n", err);
-               return 1;
-       }
-
-       err = rt_task_start(&worker_task, &worker, NULL);
-       if (err) {
-               fprintf(stderr,"switch: failed to start worker task, code %d\n", err);
-               return 1;
-       }
-
-       err = rt_task_create(&event_task, "event", 0, 99, 0);
-       if (err) {
-               fprintf(stderr,"switch: failed to create event task, code %d\n", err);
-               return 1;
-       }
-
-       err = rt_task_start(&event_task, &event, NULL);
-       if (err) {
-               fprintf(stderr,"switch: failed to start event task, code %d\n", err);
-               return 1;
-       }
-
-       pause();
-
-       return 0;
-}
Index: src/testsuite/switch/Makefile.am
===================================================================
--- src/testsuite/switch/Makefile.am	(revision 1168)
+++ src/testsuite/switch/Makefile.am	(working copy)
@@ -1,29 +0,0 @@
-testdir = $(prefix)/testsuite/switch
-
-test_PROGRAMS = switch
-
-switch_SOURCES = switch.c
-
-switch_CPPFLAGS = \
-	@XENO_USER_CFLAGS@ \
-	-I$(top_srcdir)/include
-
-switch_LDFLAGS = @XENO_USER_LDFLAGS@
-
-switch_LDADD = \
-	../../skins/native/.libs/libnative.a \
-	-lpthread
-
-install-data-local:
-	$(mkinstalldirs) $(DESTDIR)$(testdir)
-	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(testdir)/run
-	@chmod +x $(DESTDIR)$(testdir)/run
-
-uninstall-local:
-	$(RM) $(DESTDIR)$(testdir)/.runinfo $(DESTDIR)$(testdir)/run
-
-run: all
-	@$(top_srcdir)/scripts/xeno-load --verbose
-
-EXTRA_DIST = runinfo
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchbench/runinfo	2006-06-07 18:51:22.000000000 +0200
@@ -0,0 +1 @@
+switch:native:!./switch;popall:control_c
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchbench/switch.c	2006-06-07 18:51:22.000000000 +0200
@@ -0,0 +1,223 @@
+/*
+   Task switch latency test.
+   Max Krasnyansky <maxk@domain.hid
+
+   Based on latency.c by Philippe Gerum <rpm@xenomai.org>
+ */
+
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <getopt.h>
+#include <native/task.h>
+#include <native/timer.h>
+#include <native/sem.h>
+
+RT_TASK event_task, worker_task;
+
+RT_SEM switch_sem;
+RTIME  switch_tsc;
+unsigned long long switch_count;
+
+long long minjitter = 10000000;
+long long maxjitter = -10000000;
+long long avgjitter = 0;
+long long lost = 0;
+long long nsamples = 100000;
+long long sampling_period = 100000;
+
+#define HISTOGRAM_CELLS 100
+
+unsigned long histogram[HISTOGRAM_CELLS];
+
+int do_histogram = 0;
+int ignore = 5;
+
+static inline void add_histogram(long addval)
+{
+       long inabs = rt_timer_tsc2ns(addval >= 0 ? addval : -addval) / 1000;  /* usec steps */
+       histogram[inabs < HISTOGRAM_CELLS ? inabs : HISTOGRAM_CELLS - 1]++;
+}
+
+void dump_histogram(void)
+{
+       int n;
+
+       for (n = 0; n < HISTOGRAM_CELLS; n++) {
+               long hits = histogram[n];
+               if (hits)
+                       fprintf(stderr, "%d - %d us: %ld\n", n, n + 1, hits);
+       }
+}
+
+void event(void *cookie)
+{
+       int err;
+
+       err = rt_task_set_periodic(NULL,
+                                  TM_NOW,
+                                  rt_timer_ns2ticks(sampling_period));
+       if (err) {
+               fprintf(stderr,"switch: failed to set periodic, code %d\n", err);
+               return;
+       }
+
+       for (;;) {
+               err = rt_task_wait_period(NULL);
+               if (err) {
+                       if (err != -ETIMEDOUT) {
+                               /* Timer stopped. */
+                               rt_task_delete(NULL);
+                       }
+               }
+
+               switch_count++;
+               switch_tsc = rt_timer_tsc();
+
+               rt_sem_broadcast(&switch_sem);
+       }
+}
+
+void worker(void *cookie)
+{
+       long long minj = 10000000, maxj = -10000000, dt, sumj = 0;
+       unsigned long long count = 0;
+       int err, n;
+
+       err = rt_sem_create(&switch_sem, "dispsem", 0, S_FIFO);
+       if (err) {
+               fprintf(stderr,"switch: cannot create semaphore: %s\n",
+                      strerror(-err));
+               return;
+       }
+
+       for (n=0; n<nsamples; n++) {
+               err = rt_sem_p(&switch_sem, TM_INFINITE);
+               if (err) {
+                       if (err != -EIDRM)
+                               fprintf(stderr,"switch: failed to pend on semaphore, code %d\n", err);
+
+                       rt_task_delete(NULL);
+               }
+
+               if (++count != switch_count) {
+                       count = switch_count;
+                       lost++;
+                       continue;
+               }
+
+               // First few switches are slow.
+               // Probably due to the Linux <-> RT context migration at task startup.
+               if (count < ignore)
+                       continue;
+
+               dt = (long) (rt_timer_tsc() - switch_tsc);
+               if (dt > maxj)
+                       maxj = dt;
+               if (dt < minj)
+                       minj = dt;
+               sumj += dt;
+
+               if (do_histogram)
+                       add_histogram(dt);
+       }
+
+       rt_sem_delete(&switch_sem);
+
+       minjitter = minj;
+       maxjitter = maxj;
+       avgjitter = sumj / n;
+
+       printf("RTH|%12s|%12s|%12s|%12s\n",
+                      "lat min", "lat avg", "lat max", "lost");
+
+       printf("RTD|%12Ld|%12Ld|%12Ld|%12lld\n",
+                      rt_timer_tsc2ns(minjitter),
+                      rt_timer_tsc2ns(avgjitter),
+                      rt_timer_tsc2ns(maxjitter), lost);
+
+       if (do_histogram)
+               dump_histogram();
+
+       exit(0);
+}
+
+int main(int argc, char **argv)
+{
+       int err, c;
+
+       while ((c = getopt(argc, argv, "hp:n:i:")) != EOF)
+               switch (c) {
+               case 'h':
+                       /* ./switch --h[istogram] */
+                       do_histogram = 1;
+                       break;
+
+               case 'p':
+                       sampling_period = atoi(optarg) * 1000;
+                       break;
+
+               case 'n':
+                       nsamples = atoi(optarg);
+                       break;
+
+               case 'i':
+                       ignore = atoi(optarg);
+                       break;
+
+               default:
+
+                       fprintf(stderr, "usage: switch [options]\n"
+                               "\t-h             - enable histogram\n" 
+                               "\t-p <period_us> - timer period\n"
+                               "\t-n <samples>   - number of samples to collect\n"
+                               "\t-i <samples>   - number of _first_ samples to ignore\n");
+                       exit(2);
+               }
+
+       if (sampling_period == 0)
+               sampling_period = 100000;       /* ns */
+
+       signal(SIGINT, SIG_IGN);
+       signal(SIGTERM, SIG_IGN);
+
+       setlinebuf(stdout);
+
+       mlockall(MCL_CURRENT|MCL_FUTURE);
+       
+       printf("== Sampling period: %llu us\n", sampling_period / 1000);
+       printf("== Do not interrupt this program\n");
+
+       rt_timer_set_mode(TM_ONESHOT); /* Force aperiodic timing. */
+
+       err = rt_task_create(&worker_task, "worker", 0, 98, T_FPU);
+       if (err) {
+               fprintf(stderr,"switch: failed to create worker task, code %d\n", err);
+               return 1;
+       }
+
+       err = rt_task_start(&worker_task, &worker, NULL);
+       if (err) {
+               fprintf(stderr,"switch: failed to start worker task, code %d\n", err);
+               return 1;
+       }
+
+       err = rt_task_create(&event_task, "event", 0, 99, 0);
+       if (err) {
+               fprintf(stderr,"switch: failed to create event task, code %d\n", err);
+               return 1;
+       }
+
+       err = rt_task_start(&event_task, &event, NULL);
+       if (err) {
+               fprintf(stderr,"switch: failed to start event task, code %d\n", err);
+               return 1;
+       }
+
+       pause();
+
+       return 0;
+}
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ src/testsuite/switchbench/Makefile.am	2006-06-07 18:53:32.000000000 +0200
@@ -0,0 +1,29 @@
+testdir = $(prefix)/testsuite/switchbench
+
+test_PROGRAMS = switch
+
+switch_SOURCES = switch.c
+
+switch_CPPFLAGS = \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
+
+switch_LDFLAGS = @XENO_USER_LDFLAGS@
+
+switch_LDADD = \
+	../../skins/native/.libs/libnative.a \
+	-lpthread
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
Index: src/testsuite/cyclic/cyclictest.c
===================================================================
--- src/testsuite/cyclic/cyclictest.c	(revision 1168)
+++ src/testsuite/cyclic/cyclictest.c	(working copy)
@@ -36,7 +36,7 @@
 #include <sys/mman.h>
 
 #if IPIPE_TRACE
-#include <rtdm/rtbenchmark.h>
+#include <rtdm/rttesting.h>
 #endif
 
 /* Ugly, but .... */
Index: src/testsuite/Makefile.am
===================================================================
--- src/testsuite/Makefile.am	(revision 1168)
+++ src/testsuite/Makefile.am	(working copy)
@@ -1 +1 @@
-SUBDIRS = latency switch cyclic
+SUBDIRS = latency switchbench cyclic switchtest
Index: ksrc/drivers/Kconfig
===================================================================
--- ksrc/drivers/Kconfig	(revision 1168)
+++ ksrc/drivers/Kconfig	(working copy)
@@ -1,2 +1,2 @@
 source "drivers/xenomai/16550A/Kconfig"
-source "drivers/xenomai/benchmark/Kconfig"
+source "drivers/xenomai/testing/Kconfig"
Index: ksrc/drivers/Makefile
===================================================================
--- ksrc/drivers/Makefile	(revision 1168)
+++ ksrc/drivers/Makefile	(working copy)
@@ -2,7 +2,7 @@
 
 # Makefile frag for Linux v2.6
 
-obj-$(CONFIG_XENOMAI) += 16550A/ benchmark/
+obj-$(CONFIG_XENOMAI) += 16550A/ testing/
 
 else
 
@@ -10,8 +10,10 @@
 
 subdir-$(CONFIG_XENO_DRIVERS_16550A) += 16550A
 
-subdir-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += benchmark
+subdir-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += testing
 
+subdir-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += testing
+
 include $(TOPDIR)/Rules.make
 
 endif
Index: ksrc/drivers/benchmark/Kconfig
===================================================================
--- ksrc/drivers/benchmark/Kconfig	(revision 1168)
+++ ksrc/drivers/benchmark/Kconfig	(working copy)
@@ -1,7 +0,0 @@
-config XENO_DRIVERS_TIMERBENCH
-	depends on XENO_SKIN_RTDM
-	tristate "Timer benchmark driver"
-	default n
-	help
-	Kernel-based benchmark driver for timer latency evaluation.
-	See testsuite/latency for a possible front-end.
Index: ksrc/drivers/benchmark/timerbench.c
===================================================================
--- ksrc/drivers/benchmark/timerbench.c	(revision 1168)
+++ ksrc/drivers/benchmark/timerbench.c	(working copy)
@@ -1,575 +0,0 @@
-/*
- * Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#include <linux/module.h>
-#include <asm/semaphore.h>
-#ifdef CONFIG_IPIPE_TRACE
-#include <linux/ipipe_trace.h>
-#endif /* CONFIG_IPIPE_TRACE */
-
-#include <rtdm/rtbenchmark.h>
-#include <rtdm/rtdm_driver.h>
-
-struct rt_tmbench_context {
-    int                         mode;
-    unsigned long               period;
-    int                         freeze_max;
-    int                         warmup_loops;
-    int                         samples_per_sec;
-    long                        *histogram_min;
-    long                        *histogram_max;
-    long                        *histogram_avg;
-    int                         histogram_size;
-    int                         bucketsize;
-
-    rtdm_task_t                 timer_task;
-
-    xntimer_t                   timer;
-    int                         warmup;
-    uint64_t                    start_time;
-    uint64_t                    date;
-    struct rtbnch_result        curr;
-
-    rtdm_event_t                result_event;
-    struct rtbnch_interm_result result;
-
-    struct semaphore            nrt_mutex;
-};
-
-static unsigned int start_index;
-
-module_param(start_index, uint, 0400);
-MODULE_PARM_DESC(start_index, "First device instance number to be used");
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("jan.kiszka@domain.hid");
-
-
-static inline void add_histogram(struct rt_tmbench_context *ctx,
-                                 long *histogram, long addval)
-{
-    /* bucketsize steps */
-    long inabs = (addval >= 0 ? addval : -addval) / ctx->bucketsize;
-    histogram[inabs < ctx->histogram_size ? inabs : ctx->histogram_size-1]++;
-}
-
-static inline long long slldiv(long long s, unsigned d)
-{
-    return s >= 0 ? xnarch_ulldiv(s,d,NULL) : -xnarch_ulldiv(-s,d,NULL);
-}
-
-void eval_inner_loop(struct rt_tmbench_context *ctx, long dt)
-{
-    if (ctx->date <= ctx->start_time)
-        ctx->curr.overruns++;
-
-    if (dt > ctx->curr.max)
-        ctx->curr.max = dt;
-    if (dt < ctx->curr.min)
-        ctx->curr.min = dt;
-    ctx->curr.avg += dt;
-
-#ifdef CONFIG_IPIPE_TRACE
-    if (ctx->freeze_max && (dt > ctx->result.overall.max) && !ctx->warmup) {
-        ipipe_trace_frozen_reset();
-        ipipe_trace_freeze(dt);
-        ctx->result.overall.max = dt;
-    }
-#endif /* CONFIG_IPIPE_TRACE */
-
-    ctx->date += ctx->period;
-
-    if (!ctx->warmup && ctx->histogram_size)
-        add_histogram(ctx, ctx->histogram_avg, dt);
-}
-
-
-void eval_outer_loop(struct rt_tmbench_context *ctx)
-{
-    if (!ctx->warmup) {
-        if (ctx->histogram_size) {
-            add_histogram(ctx, ctx->histogram_max, ctx->curr.max);
-            add_histogram(ctx, ctx->histogram_min, ctx->curr.min);
-        }
-
-        ctx->result.last.min = ctx->curr.min;
-        if (ctx->curr.min < ctx->result.overall.min)
-            ctx->result.overall.min = ctx->curr.min;
-
-        ctx->result.last.max = ctx->curr.max;
-        if (ctx->curr.max > ctx->result.overall.max)
-            ctx->result.overall.max = ctx->curr.max;
-
-        ctx->result.last.avg = slldiv(ctx->curr.avg, ctx->samples_per_sec);
-        ctx->result.overall.avg      += ctx->result.last.avg;
-        ctx->result.overall.overruns += ctx->curr.overruns;
-        rtdm_event_pulse(&ctx->result_event);
-    }
-
-    if (ctx->warmup &&
-        (ctx->result.overall.test_loops == ctx->warmup_loops)) {
-        ctx->result.overall.test_loops = 0;
-        ctx->warmup = 0;
-    }
-
-    ctx->curr.min        = 10000000;
-    ctx->curr.max        = -10000000;
-    ctx->curr.avg        = 0;
-    ctx->curr.overruns   = 0;
-
-    ctx->result.overall.test_loops++;
-}
-
-
-void timer_task_proc(void *arg)
-{
-    struct rt_tmbench_context   *ctx = (struct rt_tmbench_context *)arg;
-    int                         count;
-
-
-    /* start time: one millisecond from now. */
-    ctx->date = rtdm_clock_read() + 1000000;
-
-    while (1) {
-        int err;
-
-
-        for (count = 0; count < ctx->samples_per_sec; count++) {
-            RTDM_EXECUTE_ATOMICALLY(
-                ctx->start_time = rtdm_clock_read();
-                err = rtdm_task_sleep_until(ctx->date);
-            );
-
-            if (err)
-                return;
-
-            eval_inner_loop(ctx, (long)(rtdm_clock_read() - ctx->date));
-        }
-        eval_outer_loop(ctx);
-    }
-}
-
-
-void timer_proc(void *arg)
-{
-    struct rt_tmbench_context   *ctx = (struct rt_tmbench_context *)arg;
-
-
-    eval_inner_loop(ctx, (long)(rtdm_clock_read() - ctx->date));
-
-    ctx->start_time = rtdm_clock_read();
-    /* FIXME: convert to RTDM timers */
-    xntimer_start(&ctx->timer, xnpod_ns2ticks(ctx->date-ctx->start_time),
-                  XN_INFINITE);
-
-    if (++ctx->curr.test_loops < ctx->samples_per_sec)
-        return;
-
-    ctx->curr.test_loops = 0;
-    eval_outer_loop(ctx);
-}
-
-
-int rt_tmbench_open(struct rtdm_dev_context *context,
-                    rtdm_user_info_t *user_info, int oflags)
-{
-    struct rt_tmbench_context   *ctx;
-
-
-    ctx = (struct rt_tmbench_context *)context->dev_private;
-
-    ctx->mode = -1;
-    init_MUTEX(&ctx->nrt_mutex);
-
-    return 0;
-}
-
-
-int rt_tmbench_close(struct rtdm_dev_context *context,
-                     rtdm_user_info_t *user_info)
-{
-    struct rt_tmbench_context   *ctx;
-
-
-    ctx = (struct rt_tmbench_context *)context->dev_private;
-
-    down(&ctx->nrt_mutex);
-
-    if (ctx->mode >= 0) {
-        if (ctx->mode == RTBNCH_TIMER_TASK)
-            rtdm_task_destroy(&ctx->timer_task);
-        else
-            /* FIXME: convert to RTDM timers */
-            xntimer_destroy(&ctx->timer);
-
-        rtdm_event_destroy(&ctx->result_event);
-
-        if (ctx->histogram_size)
-            kfree(ctx->histogram_min);
-
-        ctx->mode           = -1;
-        ctx->histogram_size = 0;
-    }
-
-    up(&ctx->nrt_mutex);
-
-    return 0;
-}
-
-
-#ifdef CONFIG_IPIPE_TRACE
-int tracer_ioctl(int request, rtdm_user_info_t *user_info, void *arg)
-{
-    switch (request) {
-        case RTBNCH_RTIOC_BEGIN_TRACE:
-            ipipe_trace_begin((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_END_TRACE:
-            ipipe_trace_end((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_REFREEZE_TRACE:
-            ipipe_trace_frozen_reset();
-            /* fall through */
-
-        case RTBNCH_RTIOC_FREEZE_TRACE:
-            ipipe_trace_freeze((long)arg);
-            break;
-
-        case RTBNCH_RTIOC_SPECIAL_TRACE:
-            ipipe_trace_special((long)arg, 0);
-            break;
-
-        case RTBNCH_RTIOC_SPECIAL_TRACE_EX: {
-            struct rtbnch_trace_special special;
-
-            if (user_info) {
-                if (!rtdm_read_user_ok(user_info, arg,
-                                       sizeof(struct rtbnch_trace_special)) ||
-                    rtdm_copy_from_user(user_info, &special, arg,
-                                        sizeof(struct rtbnch_trace_special)))
-                    return 0;
-            } else
-                special = *(struct rtbnch_trace_special *)arg;
-            ipipe_trace_special(special.id, special.v);
-            break;
-        }
-
-        default:
-            return 0;
-    }
-    return 1;
-}
-#else /* !CONFIG_IPIPE_TRACE */
-#define tracer_ioctl(request, user_info, arg)   (0)
-#endif /* CONFIG_IPIPE_TRACE */
-
-
-int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
-                         rtdm_user_info_t *user_info, int request, void *arg)
-{
-    struct rt_tmbench_context   *ctx;
-    int                         ret = 0;
-
-
-    if (tracer_ioctl(request, user_info, arg))
-        return 0;
-
-    ctx = (struct rt_tmbench_context *)context->dev_private;
-
-    switch (request) {
-        case RTBNCH_RTIOC_START_TMTEST: {
-            struct rtbnch_timerconfig   config_buf;
-            struct rtbnch_timerconfig   *config;
-
-
-            config = (struct rtbnch_timerconfig *)arg;
-            if (user_info) {
-                if (!rtdm_read_user_ok(user_info, arg,
-                                       sizeof(struct rtbnch_timerconfig)) ||
-                    rtdm_copy_from_user(user_info, &config_buf, arg,
-                                        sizeof(struct rtbnch_timerconfig)))
-                    return -EFAULT;
-
-                config = &config_buf;
-            }
-
-            down(&ctx->nrt_mutex);
-
-            ctx->period          = config->period;
-            ctx->warmup_loops    = config->warmup_loops;
-            ctx->samples_per_sec = 1000000000 / ctx->period;
-            ctx->histogram_size  = config->histogram_size;
-            ctx->freeze_max      = config->freeze_max;
-
-            if (ctx->histogram_size > 0) {
-                ctx->histogram_min =
-                    kmalloc(3 * ctx->histogram_size * sizeof(long),
-                            GFP_KERNEL);
-                ctx->histogram_max =
-                    ctx->histogram_min + config->histogram_size;
-                ctx->histogram_avg =
-                    ctx->histogram_max + config->histogram_size;
-
-                if (!ctx->histogram_min) {
-                    up(&ctx->nrt_mutex);
-                    return -ENOMEM;
-                }
-
-                memset(ctx->histogram_min, 0,
-                       3 * ctx->histogram_size * sizeof(long));
-                ctx->bucketsize = config->histogram_bucketsize;
-            }
-
-            ctx->result.overall.min        = 10000000;
-            ctx->result.overall.max        = -10000000;
-            ctx->result.overall.avg        = 0;
-            ctx->result.overall.test_loops = 1;
-            ctx->result.overall.overruns   = 0;
-
-            ctx->warmup = 1;
-
-            ctx->curr.min        = 10000000;
-            ctx->curr.max        = -10000000;
-            ctx->curr.avg        = 0;
-            ctx->curr.overruns   = 0;
-
-            rtdm_event_init(&ctx->result_event, 0);
-
-            if (config->mode == RTBNCH_TIMER_TASK) {
-                if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
-                    ctx->mode = RTBNCH_TIMER_TASK;
-                    ret = rtdm_task_init(&ctx->timer_task, "timerbench",
-                                         timer_task_proc, ctx,
-                                         RTDM_TASK_HIGHEST_PRIORITY, 0);
-                }
-            } else {
-                /* FIXME: convert to RTDM timers */
-                xntimer_init(&ctx->timer, timer_proc, ctx);
-
-                ctx->curr.test_loops = 0;
-
-                if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
-                    ctx->mode = RTBNCH_TIMER_HANDLER;
-                    RTDM_EXECUTE_ATOMICALLY(
-                        /* start time: one millisecond from now. */
-                        ctx->start_time = rtdm_clock_read() + 1000000;
-                        ctx->date       = ctx->start_time + ctx->period;
-
-                        /* FIXME: convert to RTDM timers */
-                        xntimer_start(&ctx->timer,
-                                xnpod_ns2ticks(ctx->date-rtdm_clock_read()),
-                                XN_INFINITE);
-                    );
-                }
-            }
-
-            up(&ctx->nrt_mutex);
-
-            break;
-        }
-
-        case RTBNCH_RTIOC_STOP_TMTEST: {
-            struct rtbnch_overall_result *usr_res;
-
-
-            usr_res = (struct rtbnch_overall_result *)arg;
-
-            down(&ctx->nrt_mutex);
-
-            if (ctx->mode < 0) {
-                up(&ctx->nrt_mutex);
-                return -EINVAL;
-            }
-
-            if (ctx->mode == RTBNCH_TIMER_TASK)
-                rtdm_task_destroy(&ctx->timer_task);
-            else
-                /* FIXME: convert to RTDM timers */
-                xntimer_destroy(&ctx->timer);
-
-            rtdm_event_destroy(&ctx->result_event);
-
-            ctx->mode = -1;
-
-            ctx->result.overall.avg =
-                slldiv(ctx->result.overall.avg,
-                       ((ctx->result.overall.test_loops) > 1 ?
-                       ctx->result.overall.test_loops : 2) - 1);
-
-            if (user_info) {
-                if (!rtdm_rw_user_ok(user_info, usr_res,
-                                     sizeof(struct rtbnch_overall_result)) ||
-                    rtdm_copy_to_user(user_info, &usr_res->result,
-                                      &ctx->result.overall,
-                                      sizeof(struct rtbnch_result)))
-                    ret = -EFAULT;
-            } else {
-                memcpy(&usr_res->result, &ctx->result.overall,
-                       sizeof(struct rtbnch_result));
-            }
-
-            if (ctx->histogram_size) {
-                int size = ctx->histogram_size * sizeof(long);
-
-                if (user_info) {
-                    if (!rtdm_rw_user_ok(user_info, usr_res->histogram_min,
-                                         size) ||
-                        rtdm_copy_to_user(user_info, usr_res->histogram_min,
-                                          ctx->histogram_min, size) ||
-                        !rtdm_rw_user_ok(user_info, usr_res->histogram_max,
-                                         size) ||
-                        rtdm_copy_to_user(user_info, usr_res->histogram_max,
-                                          ctx->histogram_max, size) ||
-                        !rtdm_rw_user_ok(user_info, usr_res->histogram_avg,
-                                         size) ||
-                        rtdm_copy_to_user(user_info, usr_res->histogram_avg,
-                                          ctx->histogram_avg, size))
-                        ret = -EFAULT;
-                } else {
-                    memcpy(usr_res->histogram_min, ctx->histogram_min, size);
-                    memcpy(usr_res->histogram_max, ctx->histogram_max, size);
-                    memcpy(usr_res->histogram_avg, ctx->histogram_avg, size);
-                }
-
-                kfree(ctx->histogram_min);
-            }
-
-            up(&ctx->nrt_mutex);
-
-            break;
-        }
-
-        case RTBNCH_RTIOC_INTERM_RESULT:
-            ret = -ENOSYS;
-            break;
-
-        default:
-            ret = -ENOTTY;
-    }
-
-    return ret;
-}
-
-
-int rt_tmbench_ioctl_rt(struct rtdm_dev_context *context,
-                        rtdm_user_info_t *user_info, int request, void *arg)
-{
-    struct rt_tmbench_context   *ctx;
-    int                         ret = 0;
-
-
-    if (tracer_ioctl(request, user_info, arg))
-        return 0;
-
-    ctx = (struct rt_tmbench_context *)context->dev_private;
-
-    switch (request) {
-        case RTBNCH_RTIOC_INTERM_RESULT: {
-            struct rtbnch_interm_result *usr_res;
-
-
-            usr_res = (struct rtbnch_interm_result *)arg;
-
-            ret = rtdm_event_wait(&ctx->result_event);
-            if (ret < 0)
-                return ret;
-
-            if (user_info) {
-                if (!rtdm_rw_user_ok(user_info, usr_res,
-                                     sizeof(struct rtbnch_interm_result)) ||
-                    rtdm_copy_to_user(user_info, usr_res, &ctx->result,
-                                      sizeof(struct rtbnch_interm_result)))
-                    ret = -EFAULT;
-            } else
-                memcpy(usr_res, &ctx->result,
-                       sizeof(struct rtbnch_interm_result));
-
-            break;
-        }
-
-        case RTBNCH_RTIOC_START_TMTEST:
-        case RTBNCH_RTIOC_STOP_TMTEST:
-            ret = -ENOSYS;
-            break;
-
-        default:
-            ret = -ENOTTY;
-    }
-
-    return ret;
-}
-
-
-static struct rtdm_device device = {
-    struct_version:     RTDM_DEVICE_STRUCT_VER,
-
-    device_flags:       RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
-    context_size:       sizeof(struct rt_tmbench_context),
-    device_name:        "",
-
-    open_rt:            NULL,
-    open_nrt:           rt_tmbench_open,
-
-    ops: {
-        close_rt:       NULL,
-        close_nrt:      rt_tmbench_close,
-
-        ioctl_rt:       rt_tmbench_ioctl_rt,
-        ioctl_nrt:      rt_tmbench_ioctl_nrt,
-
-        read_rt:        NULL,
-        read_nrt:       NULL,
-
-        write_rt:       NULL,
-        write_nrt:      NULL,
-
-        recvmsg_rt:     NULL,
-        recvmsg_nrt:    NULL,
-
-        sendmsg_rt:     NULL,
-        sendmsg_nrt:    NULL,
-    },
-
-    device_class:       RTDM_CLASS_BENCHMARK,
-    device_sub_class:   RTDM_SUBCLASS_TIMER,
-    driver_name:        "xeno_timerbench",
-    driver_version:     RTDM_DRIVER_VER(0, 1, 0),
-    peripheral_name:    "Timer Latency Benchmark",
-    provider_name:      "Jan Kiszka",
-    proc_name:          device.device_name,
-};
-
-int __init __timerbench_init(void)
-{
-    snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rtbenchmark%d",
-             start_index);
-
-    return rtdm_dev_register(&device);
-}
-
-
-void __timerbench_exit(void)
-{
-    rtdm_dev_unregister(&device, 1000);
-}
-
-
-module_init(__timerbench_init);
-module_exit(__timerbench_exit);
Index: ksrc/drivers/benchmark/Config.in
===================================================================
--- ksrc/drivers/benchmark/Config.in	(revision 1168)
+++ ksrc/drivers/benchmark/Config.in	(working copy)
@@ -1,5 +0,0 @@
-#
-# Xenomai configuration for Linux v2.4
-#
-
-dep_tristate 'Timer benchmark driver' CONFIG_XENO_DRIVERS_TIMERBENCH $CONFIG_XENO_SKIN_RTDM
Index: ksrc/drivers/benchmark/Makefile
===================================================================
--- ksrc/drivers/benchmark/Makefile	(revision 1168)
+++ ksrc/drivers/benchmark/Makefile	(working copy)
@@ -1,34 +0,0 @@
-ifeq ($(PATCHLEVEL),6)
-
-# Makefile frag for Linux v2.6
-
-EXTRA_CFLAGS += -Iinclude/xenomai
-
-obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
-
-xeno_timerbench-y := timerbench.o
-
-EXTRA_CFLAGS += -Iinclude/xenomai
-
-else
-
-# Makefile frag for Linux v2.4
-
-O_TARGET := built-in.o
-
-obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) := xeno_timerbench.o
-
-list-multi := xeno_timerbench.o
-
-xeno_timerbench-objs := timerbench.o
-
-export-objs := $(xeno_timerbench-objs)
-
-EXTRA_CFLAGS += -I$(TOPDIR)/include/xenomai -I$(TOPDIR)/include/xenomai/compat
-
-include $(TOPDIR)/Rules.make
-
-xeno_timerbench.o: $(xeno_timerbench-objs)
-	$(LD) -r -o $@ $(xeno_timerbench-objs)
-
-endif
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ ksrc/drivers/testing/Kconfig	2006-06-07 18:54:48.000000000 +0200
@@ -0,0 +1,15 @@
+config XENO_DRIVERS_TIMERBENCH
+	depends on XENO_SKIN_RTDM
+	tristate "Timer benchmark driver"
+	default n
+	help
+	Kernel-based benchmark driver for timer latency evaluation.
+	See testsuite/latency for a possible front-end.
+
+config XENO_DRIVERS_SWITCHTEST
+        depends on XENO_SKIN_RTDM
+        tristate "Context switch unit testing driver"
+        default n
+        help
+        Kernel-based driver for unit testing context switches and 
+        FPU switches.
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ ksrc/drivers/testing/timerbench.c	2006-06-07 19:12:05.000000000 +0200
@@ -0,0 +1,575 @@
+/*
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <asm/semaphore.h>
+#ifdef CONFIG_IPIPE_TRACE
+#include <linux/ipipe_trace.h>
+#endif /* CONFIG_IPIPE_TRACE */
+
+#include <rtdm/rttesting.h>
+#include <rtdm/rtdm_driver.h>
+
+struct rt_tmbench_context {
+    int                         mode;
+    unsigned long               period;
+    int                         freeze_max;
+    int                         warmup_loops;
+    int                         samples_per_sec;
+    long                        *histogram_min;
+    long                        *histogram_max;
+    long                        *histogram_avg;
+    int                         histogram_size;
+    int                         bucketsize;
+
+    rtdm_task_t                 timer_task;
+
+    xntimer_t                   timer;
+    int                         warmup;
+    uint64_t                    start_time;
+    uint64_t                    date;
+    struct rtbnch_result        curr;
+
+    rtdm_event_t                result_event;
+    struct rtbnch_interm_result result;
+
+    struct semaphore            nrt_mutex;
+};
+
+static unsigned int start_index;
+
+module_param(start_index, uint, 0400);
+MODULE_PARM_DESC(start_index, "First device instance number to be used");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("jan.kiszka@domain.hid");
+
+
+static inline void add_histogram(struct rt_tmbench_context *ctx,
+                                 long *histogram, long addval)
+{
+    /* bucketsize steps */
+    long inabs = (addval >= 0 ? addval : -addval) / ctx->bucketsize;
+    histogram[inabs < ctx->histogram_size ? inabs : ctx->histogram_size-1]++;
+}
+
+static inline long long slldiv(long long s, unsigned d)
+{
+    return s >= 0 ? xnarch_ulldiv(s,d,NULL) : -xnarch_ulldiv(-s,d,NULL);
+}
+
+void eval_inner_loop(struct rt_tmbench_context *ctx, long dt)
+{
+    if (ctx->date <= ctx->start_time)
+        ctx->curr.overruns++;
+
+    if (dt > ctx->curr.max)
+        ctx->curr.max = dt;
+    if (dt < ctx->curr.min)
+        ctx->curr.min = dt;
+    ctx->curr.avg += dt;
+
+#ifdef CONFIG_IPIPE_TRACE
+    if (ctx->freeze_max && (dt > ctx->result.overall.max) && !ctx->warmup) {
+        ipipe_trace_frozen_reset();
+        ipipe_trace_freeze(dt);
+        ctx->result.overall.max = dt;
+    }
+#endif /* CONFIG_IPIPE_TRACE */
+
+    ctx->date += ctx->period;
+
+    if (!ctx->warmup && ctx->histogram_size)
+        add_histogram(ctx, ctx->histogram_avg, dt);
+}
+
+
+void eval_outer_loop(struct rt_tmbench_context *ctx)
+{
+    if (!ctx->warmup) {
+        if (ctx->histogram_size) {
+            add_histogram(ctx, ctx->histogram_max, ctx->curr.max);
+            add_histogram(ctx, ctx->histogram_min, ctx->curr.min);
+        }
+
+        ctx->result.last.min = ctx->curr.min;
+        if (ctx->curr.min < ctx->result.overall.min)
+            ctx->result.overall.min = ctx->curr.min;
+
+        ctx->result.last.max = ctx->curr.max;
+        if (ctx->curr.max > ctx->result.overall.max)
+            ctx->result.overall.max = ctx->curr.max;
+
+        ctx->result.last.avg = slldiv(ctx->curr.avg, ctx->samples_per_sec);
+        ctx->result.overall.avg      += ctx->result.last.avg;
+        ctx->result.overall.overruns += ctx->curr.overruns;
+        rtdm_event_pulse(&ctx->result_event);
+    }
+
+    if (ctx->warmup &&
+        (ctx->result.overall.test_loops == ctx->warmup_loops)) {
+        ctx->result.overall.test_loops = 0;
+        ctx->warmup = 0;
+    }
+
+    ctx->curr.min        = 10000000;
+    ctx->curr.max        = -10000000;
+    ctx->curr.avg        = 0;
+    ctx->curr.overruns   = 0;
+
+    ctx->result.overall.test_loops++;
+}
+
+
+void timer_task_proc(void *arg)
+{
+    struct rt_tmbench_context   *ctx = (struct rt_tmbench_context *)arg;
+    int                         count;
+
+
+    /* start time: one millisecond from now. */
+    ctx->date = rtdm_clock_read() + 1000000;
+
+    while (1) {
+        int err;
+
+
+        for (count = 0; count < ctx->samples_per_sec; count++) {
+            RTDM_EXECUTE_ATOMICALLY(
+                ctx->start_time = rtdm_clock_read();
+                err = rtdm_task_sleep_until(ctx->date);
+            );
+
+            if (err)
+                return;
+
+            eval_inner_loop(ctx, (long)(rtdm_clock_read() - ctx->date));
+        }
+        eval_outer_loop(ctx);
+    }
+}
+
+
+void timer_proc(void *arg)
+{
+    struct rt_tmbench_context   *ctx = (struct rt_tmbench_context *)arg;
+
+
+    eval_inner_loop(ctx, (long)(rtdm_clock_read() - ctx->date));
+
+    ctx->start_time = rtdm_clock_read();
+    /* FIXME: convert to RTDM timers */
+    xntimer_start(&ctx->timer, xnpod_ns2ticks(ctx->date-ctx->start_time),
+                  XN_INFINITE);
+
+    if (++ctx->curr.test_loops < ctx->samples_per_sec)
+        return;
+
+    ctx->curr.test_loops = 0;
+    eval_outer_loop(ctx);
+}
+
+
+int rt_tmbench_open(struct rtdm_dev_context *context,
+                    rtdm_user_info_t *user_info, int oflags)
+{
+    struct rt_tmbench_context   *ctx;
+
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    ctx->mode = -1;
+    init_MUTEX(&ctx->nrt_mutex);
+
+    return 0;
+}
+
+
+int rt_tmbench_close(struct rtdm_dev_context *context,
+                     rtdm_user_info_t *user_info)
+{
+    struct rt_tmbench_context   *ctx;
+
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    down(&ctx->nrt_mutex);
+
+    if (ctx->mode >= 0) {
+        if (ctx->mode == RTBNCH_TIMER_TASK)
+            rtdm_task_destroy(&ctx->timer_task);
+        else
+            /* FIXME: convert to RTDM timers */
+            xntimer_destroy(&ctx->timer);
+
+        rtdm_event_destroy(&ctx->result_event);
+
+        if (ctx->histogram_size)
+            kfree(ctx->histogram_min);
+
+        ctx->mode           = -1;
+        ctx->histogram_size = 0;
+    }
+
+    up(&ctx->nrt_mutex);
+
+    return 0;
+}
+
+
+#ifdef CONFIG_IPIPE_TRACE
+int tracer_ioctl(int request, rtdm_user_info_t *user_info, void *arg)
+{
+    switch (request) {
+        case RTBNCH_RTIOC_BEGIN_TRACE:
+            ipipe_trace_begin((long)arg);
+            break;
+
+        case RTBNCH_RTIOC_END_TRACE:
+            ipipe_trace_end((long)arg);
+            break;
+
+        case RTBNCH_RTIOC_REFREEZE_TRACE:
+            ipipe_trace_frozen_reset();
+            /* fall through */
+
+        case RTBNCH_RTIOC_FREEZE_TRACE:
+            ipipe_trace_freeze((long)arg);
+            break;
+
+        case RTBNCH_RTIOC_SPECIAL_TRACE:
+            ipipe_trace_special((long)arg, 0);
+            break;
+
+        case RTBNCH_RTIOC_SPECIAL_TRACE_EX: {
+            struct rtbnch_trace_special special;
+
+            if (user_info) {
+                if (!rtdm_read_user_ok(user_info, arg,
+                                       sizeof(struct rtbnch_trace_special)) ||
+                    rtdm_copy_from_user(user_info, &special, arg,
+                                        sizeof(struct rtbnch_trace_special)))
+                    return 0;
+            } else
+                special = *(struct rtbnch_trace_special *)arg;
+            ipipe_trace_special(special.id, special.v);
+            break;
+        }
+
+        default:
+            return 0;
+    }
+    return 1;
+}
+#else /* !CONFIG_IPIPE_TRACE */
+#define tracer_ioctl(request, user_info, arg)   (0)
+#endif /* CONFIG_IPIPE_TRACE */
+
+
+int rt_tmbench_ioctl_nrt(struct rtdm_dev_context *context,
+                         rtdm_user_info_t *user_info, int request, void *arg)
+{
+    struct rt_tmbench_context   *ctx;
+    int                         ret = 0;
+
+
+    if (tracer_ioctl(request, user_info, arg))
+        return 0;
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    switch (request) {
+        case RTBNCH_RTIOC_START_TMTEST: {
+            struct rtbnch_timerconfig   config_buf;
+            struct rtbnch_timerconfig   *config;
+
+
+            config = (struct rtbnch_timerconfig *)arg;
+            if (user_info) {
+                if (!rtdm_read_user_ok(user_info, arg,
+                                       sizeof(struct rtbnch_timerconfig)) ||
+                    rtdm_copy_from_user(user_info, &config_buf, arg,
+                                        sizeof(struct rtbnch_timerconfig)))
+                    return -EFAULT;
+
+                config = &config_buf;
+            }
+
+            down(&ctx->nrt_mutex);
+
+            ctx->period          = config->period;
+            ctx->warmup_loops    = config->warmup_loops;
+            ctx->samples_per_sec = 1000000000 / ctx->period;
+            ctx->histogram_size  = config->histogram_size;
+            ctx->freeze_max      = config->freeze_max;
+
+            if (ctx->histogram_size > 0) {
+                ctx->histogram_min =
+                    kmalloc(3 * ctx->histogram_size * sizeof(long),
+                            GFP_KERNEL);
+                ctx->histogram_max =
+                    ctx->histogram_min + config->histogram_size;
+                ctx->histogram_avg =
+                    ctx->histogram_max + config->histogram_size;
+
+                if (!ctx->histogram_min) {
+                    up(&ctx->nrt_mutex);
+                    return -ENOMEM;
+                }
+
+                memset(ctx->histogram_min, 0,
+                       3 * ctx->histogram_size * sizeof(long));
+                ctx->bucketsize = config->histogram_bucketsize;
+            }
+
+            ctx->result.overall.min        = 10000000;
+            ctx->result.overall.max        = -10000000;
+            ctx->result.overall.avg        = 0;
+            ctx->result.overall.test_loops = 1;
+            ctx->result.overall.overruns   = 0;
+
+            ctx->warmup = 1;
+
+            ctx->curr.min        = 10000000;
+            ctx->curr.max        = -10000000;
+            ctx->curr.avg        = 0;
+            ctx->curr.overruns   = 0;
+
+            rtdm_event_init(&ctx->result_event, 0);
+
+            if (config->mode == RTBNCH_TIMER_TASK) {
+                if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
+                    ctx->mode = RTBNCH_TIMER_TASK;
+                    ret = rtdm_task_init(&ctx->timer_task, "timerbench",
+                                         timer_task_proc, ctx,
+                                         RTDM_TASK_HIGHEST_PRIORITY, 0);
+                }
+            } else {
+                /* FIXME: convert to RTDM timers */
+                xntimer_init(&ctx->timer, timer_proc, ctx);
+
+                ctx->curr.test_loops = 0;
+
+                if (!test_bit(RTDM_CLOSING, &context->context_flags)) {
+                    ctx->mode = RTBNCH_TIMER_HANDLER;
+                    RTDM_EXECUTE_ATOMICALLY(
+                        /* start time: one millisecond from now. */
+                        ctx->start_time = rtdm_clock_read() + 1000000;
+                        ctx->date       = ctx->start_time + ctx->period;
+
+                        /* FIXME: convert to RTDM timers */
+                        xntimer_start(&ctx->timer,
+                                xnpod_ns2ticks(ctx->date-rtdm_clock_read()),
+                                XN_INFINITE);
+                    );
+                }
+            }
+
+            up(&ctx->nrt_mutex);
+
+            break;
+        }
+
+        case RTBNCH_RTIOC_STOP_TMTEST: {
+            struct rtbnch_overall_result *usr_res;
+
+
+            usr_res = (struct rtbnch_overall_result *)arg;
+
+            down(&ctx->nrt_mutex);
+
+            if (ctx->mode < 0) {
+                up(&ctx->nrt_mutex);
+                return -EINVAL;
+            }
+
+            if (ctx->mode == RTBNCH_TIMER_TASK)
+                rtdm_task_destroy(&ctx->timer_task);
+            else
+                /* FIXME: convert to RTDM timers */
+                xntimer_destroy(&ctx->timer);
+
+            rtdm_event_destroy(&ctx->result_event);
+
+            ctx->mode = -1;
+
+            ctx->result.overall.avg =
+                slldiv(ctx->result.overall.avg,
+                       ((ctx->result.overall.test_loops) > 1 ?
+                       ctx->result.overall.test_loops : 2) - 1);
+
+            if (user_info) {
+                if (!rtdm_rw_user_ok(user_info, usr_res,
+                                     sizeof(struct rtbnch_overall_result)) ||
+                    rtdm_copy_to_user(user_info, &usr_res->result,
+                                      &ctx->result.overall,
+                                      sizeof(struct rtbnch_result)))
+                    ret = -EFAULT;
+            } else {
+                memcpy(&usr_res->result, &ctx->result.overall,
+                       sizeof(struct rtbnch_result));
+            }
+
+            if (ctx->histogram_size) {
+                int size = ctx->histogram_size * sizeof(long);
+
+                if (user_info) {
+                    if (!rtdm_rw_user_ok(user_info, usr_res->histogram_min,
+                                         size) ||
+                        rtdm_copy_to_user(user_info, usr_res->histogram_min,
+                                          ctx->histogram_min, size) ||
+                        !rtdm_rw_user_ok(user_info, usr_res->histogram_max,
+                                         size) ||
+                        rtdm_copy_to_user(user_info, usr_res->histogram_max,
+                                          ctx->histogram_max, size) ||
+                        !rtdm_rw_user_ok(user_info, usr_res->histogram_avg,
+                                         size) ||
+                        rtdm_copy_to_user(user_info, usr_res->histogram_avg,
+                                          ctx->histogram_avg, size))
+                        ret = -EFAULT;
+                } else {
+                    memcpy(usr_res->histogram_min, ctx->histogram_min, size);
+                    memcpy(usr_res->histogram_max, ctx->histogram_max, size);
+                    memcpy(usr_res->histogram_avg, ctx->histogram_avg, size);
+                }
+
+                kfree(ctx->histogram_min);
+            }
+
+            up(&ctx->nrt_mutex);
+
+            break;
+        }
+
+        case RTBNCH_RTIOC_INTERM_RESULT:
+            ret = -ENOSYS;
+            break;
+
+        default:
+            ret = -ENOTTY;
+    }
+
+    return ret;
+}
+
+
+int rt_tmbench_ioctl_rt(struct rtdm_dev_context *context,
+                        rtdm_user_info_t *user_info, int request, void *arg)
+{
+    struct rt_tmbench_context   *ctx;
+    int                         ret = 0;
+
+
+    if (tracer_ioctl(request, user_info, arg))
+        return 0;
+
+    ctx = (struct rt_tmbench_context *)context->dev_private;
+
+    switch (request) {
+        case RTBNCH_RTIOC_INTERM_RESULT: {
+            struct rtbnch_interm_result *usr_res;
+
+
+            usr_res = (struct rtbnch_interm_result *)arg;
+
+            ret = rtdm_event_wait(&ctx->result_event);
+            if (ret < 0)
+                return ret;
+
+            if (user_info) {
+                if (!rtdm_rw_user_ok(user_info, usr_res,
+                                     sizeof(struct rtbnch_interm_result)) ||
+                    rtdm_copy_to_user(user_info, usr_res, &ctx->result,
+                                      sizeof(struct rtbnch_interm_result)))
+                    ret = -EFAULT;
+            } else
+                memcpy(usr_res, &ctx->result,
+                       sizeof(struct rtbnch_interm_result));
+
+            break;
+        }
+
+        case RTBNCH_RTIOC_START_TMTEST:
+        case RTBNCH_RTIOC_STOP_TMTEST:
+            ret = -ENOSYS;
+            break;
+
+        default:
+            ret = -ENOTTY;
+    }
+
+    return ret;
+}
+
+
+static struct rtdm_device device = {
+    struct_version:     RTDM_DEVICE_STRUCT_VER,
+
+    device_flags:       RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
+    context_size:       sizeof(struct rt_tmbench_context),
+    device_name:        "",
+
+    open_rt:            NULL,
+    open_nrt:           rt_tmbench_open,
+
+    ops: {
+        close_rt:       NULL,
+        close_nrt:      rt_tmbench_close,
+
+        ioctl_rt:       rt_tmbench_ioctl_rt,
+        ioctl_nrt:      rt_tmbench_ioctl_nrt,
+
+        read_rt:        NULL,
+        read_nrt:       NULL,
+
+        write_rt:       NULL,
+        write_nrt:      NULL,
+
+        recvmsg_rt:     NULL,
+        recvmsg_nrt:    NULL,
+
+        sendmsg_rt:     NULL,
+        sendmsg_nrt:    NULL,
+    },
+
+    device_class:       RTDM_CLASS_TESTING,
+    device_sub_class:   RTDM_SUBCLASS_TIMER,
+    driver_name:        "xeno_timerbench",
+    driver_version:     RTDM_DRIVER_VER(0, 1, 0),
+    peripheral_name:    "Timer Latency Benchmark",
+    provider_name:      "Jan Kiszka",
+    proc_name:          device.device_name,
+};
+
+int __init __timerbench_init(void)
+{
+    snprintf(device.device_name, RTDM_MAX_DEVNAME_LEN, "rtbenchmark%d",
+             start_index);
+
+    return rtdm_dev_register(&device);
+}
+
+
+void __timerbench_exit(void)
+{
+    rtdm_dev_unregister(&device, 1000);
+}
+
+
+module_init(__timerbench_init);
+module_exit(__timerbench_exit);
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ ksrc/drivers/testing/Config.in	2006-06-07 18:54:48.000000000 +0200
@@ -0,0 +1,7 @@
+#
+# Xenomai configuration for Linux v2.4
+#
+
+dep_tristate 'Timer benchmark driver' CONFIG_XENO_DRIVERS_TIMERBENCH $CONFIG_XENO_SKIN_RTDM
+
+dep_tristate 'Context switches test driver' CONFIG_XENO_DRIVERS_SWITCHTEST $CONFIG_XENO_SKIN_RTDM
--- /dev/null	2006-05-03 22:25:59.000000000 +0200
+++ ksrc/drivers/testing/Makefile	2006-06-07 18:54:48.000000000 +0200
@@ -0,0 +1,45 @@
+ifeq ($(PATCHLEVEL),6)
+
+# Makefile frag for Linux v2.6
+
+EXTRA_CFLAGS += -Iinclude/xenomai
+
+obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
+
+obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
+
+xeno_timerbench-y := timerbench.o
+
+xeno_switchtest-y := switchtest.o
+
+EXTRA_CFLAGS += -Iinclude/xenomai
+
+else
+
+# Makefile frag for Linux v2.4
+
+O_TARGET := built-in.o
+
+obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) := xeno_timerbench.o
+
+obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) := xeno_switchtest.o
+
+list-multi := xeno_timerbench.o
+
+xeno_timerbench-objs := timerbench.o
+
+xeno_switchtest-objs := switchtest.o
+
+export-objs := $(xeno_timerbench-objs) $(xeno_switchtest-objs)
+
+EXTRA_CFLAGS += -I$(TOPDIR)/include/xenomai -I$(TOPDIR)/include/xenomai/compat
+
+include $(TOPDIR)/Rules.make
+
+xeno_timerbench.o: $(xeno_timerbench-objs)
+	$(LD) -r -o $@ $(xeno_timerbench-objs)
+
+xeno_switchtest.o: $(xeno_switchtest-objs)
+	$(LD) -r -o $@ $(xeno_switchtest-objs)
+
+endif

--O3bnNIjOcb--

