Message-ID: <49A59041.2040205@domain.hid>
Date: Wed, 25 Feb 2009 19:38:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/2] Add xn_sys_current_info
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Provide a new nucleus syscall for retrieving low-level information about
the current thread in a skin-agnostic way. This is useful for building
diagnosis services like the assert_context the following patch will
introduce.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-generic/syscall.h |   21 +++++++++++----------
 include/nucleus/thread.h      |   27 ++++++++++++++++++++++++++
 ksrc/nucleus/shadow.c         |   42 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index c378ea9..cf3ea9d 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -21,17 +21,18 @@
 #define _XENO_ASM_GENERIC_SYSCALL_H
 
 /* Xenomai multiplexer syscall. */
-#define __xn_sys_mux        555	/* Must fit within 15bit */
+#define __xn_sys_mux		555	/* Must fit within 15bit */
 /* Xenomai nucleus syscalls. */
-#define __xn_sys_bind       0	/* muxid = bind_to_interface(magic,featdep,abirev) */
-#define __xn_sys_completion 1	/* xnshadow_completion(&completion) */
-#define __xn_sys_migrate    2	/* switched = xnshadow_relax/harden() */
-#define __xn_sys_barrier    3	/* started = xnshadow_wait_barrier(&entry,&cookie) */
-#define __xn_sys_info       4	/* xnshadow_get_info(muxid,&info) */
-#define __xn_sys_arch       5	/* r = xnarch_local_syscall(args) */
-#define __xn_sys_trace      6	/* r = xntrace_xxx(...) */
-#define __xn_sys_sem_heap   7
-#define __xn_sys_current    8
+#define __xn_sys_bind		0	/* muxid = bind_to_interface(magic,featdep,abirev) */
+#define __xn_sys_completion	1	/* xnshadow_completion(&completion) */
+#define __xn_sys_migrate	2	/* switched = xnshadow_relax/harden() */
+#define __xn_sys_barrier	3	/* started = xnshadow_wait_barrier(&entry,&cookie) */
+#define __xn_sys_info		4	/* xnshadow_get_info(muxid,&info) */
+#define __xn_sys_arch		5	/* r = xnarch_local_syscall(args) */
+#define __xn_sys_trace		6	/* r = xntrace_xxx(...) */
+#define __xn_sys_sem_heap	7
+#define __xn_sys_current	8	/* threadh = xnthread_handle(cur) */
+#define __xn_sys_current_info	9	/* r = xnshadow_current_info(&info) */
 
 #define XENOMAI_LINUX_DOMAIN  0
 #define XENOMAI_XENO_DOMAIN   1
diff --git a/include/nucleus/thread.h b/include/nucleus/thread.h
index 27765ca..4e17000 100644
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -22,6 +22,8 @@
 #ifndef _XENO_NUCLEUS_THREAD_H
 #define _XENO_NUCLEUS_THREAD_H
 
+#include <nucleus/types.h>
+
 /*! @ingroup nucleus 
   @defgroup nucleus_state_flags Thread state flags.
   @brief Bits reporting permanent or transient states of thread.
@@ -121,6 +123,31 @@
 
 /*! @} */ /* Ends doxygen comment group: nucleus_info_flags */
 
+/*!
+  @brief Structure containing thread information.
+*/
+typedef struct xnthread_info {
+
+	unsigned long state; /**< Thread state, @see nucleus_state_flags */
+
+	int bprio;  /**< Base priority. */
+	int cprio; /**< Current priority. May change through Priority Inheritance.*/
+
+	int cpu; /**< CPU the thread currently runs on. */
+	unsigned long affinity; /**< Thread's CPU affinity. */
+
+	unsigned long long relpoint; /**< Time of next release.*/
+
+	unsigned long long exectime; /**< Execution time in primary mode in nanoseconds. */
+
+	unsigned long modeswitches; /**< Number of primary->secondary mode switches. */
+	unsigned long ctxswitches; /**< Number of context switches. */
+	unsigned long pagefaults; /**< Number of triggered page faults. */
+
+	char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at creation. */
+
+} xnthread_info_t;
+
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 #include <nucleus/stat.h>
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index b9303b2..612c8d8 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1807,9 +1807,9 @@ static int xnshadow_sys_sem_heap(struct pt_regs *regs)
 	return __xn_safe_copy_to_user(us_hinfo, &hinfo, sizeof(*us_hinfo));
 }
 
-#ifdef CONFIG_XENO_OPT_REGISTRY
 static int xnshadow_sys_current(struct pt_regs *regs)
 {
+#ifdef CONFIG_XENO_OPT_REGISTRY
 	xnthread_t *cur = xnshadow_thread(current);
 	xnhandle_t __user *us_handle;
 
@@ -1820,8 +1820,42 @@ static int xnshadow_sys_current(struct pt_regs *regs)
 
 	return __xn_safe_copy_to_user(us_handle, &xnthread_handle(cur),
 				      sizeof(*us_handle));
+#else /* !CONFIG_XENO_OPT_REGISTRY */
+	return -ENOSYS;
+#endif /* !CONFIG_XENO_OPT_REGISTRY */
+}
+
+static int xnshadow_sys_current_info(struct pt_regs *regs)
+{
+	xnthread_info_t __user *us_info;
+	xnthread_info_t info;
+	xnthread_t *cur = xnshadow_thread(current);
+	xnticks_t raw_exectime;
+	int i;
+
+	if (!cur)
+		return -EPERM;
+
+	info.state = xnthread_state_flags(cur);
+	info.bprio = xnthread_base_priority(cur);
+	info.cprio = xnthread_current_priority(cur);
+	info.cpu = xnsched_cpu(xnthread_sched(cur));
+	for (i = 0, info.affinity = 0; i < BITS_PER_LONG; i++)
+		if (xnthread_affine_p(cur, i))
+			info.affinity |= 1UL << i;
+	info.relpoint = xntimer_get_date(&cur->ptimer);
+	raw_exectime = xnthread_get_exectime(cur) +
+		xnstat_exectime_now() - xnthread_get_lastswitch(cur);
+	info.exectime = xnarch_tsc_to_ns(raw_exectime);
+	info.modeswitches = xnstat_counter_get(&cur->stat.ssw);
+	info.ctxswitches = xnstat_counter_get(&cur->stat.csw);
+	info.pagefaults = xnstat_counter_get(&cur->stat.pf);
+	strcpy(info.name, xnthread_name(cur));
+
+	us_info = (xnthread_info_t __user *) __xn_reg_arg1(regs);
+
+	return __xn_safe_copy_to_user(us_info, &info, sizeof(*us_info));
 }
-#endif /* CONFIG_XENO_OPT_REGISTRY */
 
 static xnsysent_t __systab[] = {
 	[__xn_sys_migrate] = {&xnshadow_sys_migrate, __xn_exec_current},
@@ -1832,9 +1866,9 @@ static xnsysent_t __systab[] = {
 	[__xn_sys_barrier] = {&xnshadow_sys_barrier, __xn_exec_lostage},
 	[__xn_sys_trace] = {&xnshadow_sys_trace, __xn_exec_any},
 	[__xn_sys_sem_heap] = {&xnshadow_sys_sem_heap, __xn_exec_any},
-#ifdef CONFIG_XENO_OPT_REGISTRY
 	[__xn_sys_current] = {&xnshadow_sys_current, __xn_exec_any},
-#endif /* CONFIG_XENO_OPT_REGISTRY */
+	[__xn_sys_current_info] =
+		{&xnshadow_sys_current_info, __xn_exec_shadow},
 };
 
 static void *xnshadow_sys_event(int event, void *data)

