From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/5] cobalt/posix: Add thread_setschedprio
Date: Mon,  2 Dec 2019 08:12:15 +0100
Message-Id: <fcbfaf4b61507bda49b446486fb5dc2432af198a.1575270738.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575270738.git.jan.kiszka@siemens.com>
References: <cover.1575270738.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575270738.git.jan.kiszka@siemens.com>
References: <cover.1575270738.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The approach of using thread_setschedparam_ex with __SCHED_CURRENT
failed for policies with complex parameter sets. Therefore, introduce a
syscall that is fully aware of how to apply only the priority change to
the target thread's scheduling settings.

We need a compat path as well because we are passing down pointers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/uapi/syscall.h                      |  1 +
 .../arch/x86/include/asm/xenomai/syscall32-table.h |  1 +
 kernel/cobalt/posix/syscall32.c                    |  9 ++++++
 kernel/cobalt/posix/syscall32.h                    |  6 ++++
 kernel/cobalt/posix/thread.c                       | 37 ++++++++++++++++++++++
 kernel/cobalt/posix/thread.h                       | 11 +++++++
 kernel/cobalt/trace/cobalt-posix.h                 | 15 +++++++++
 7 files changed, 80 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 1cb22a5936..aa3c308d0b 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -121,6 +121,7 @@
 #define sc_cobalt_recvmmsg			98
 #define sc_cobalt_sendmmsg			99
 #define sc_cobalt_clock_adjtime			100
+#define sc_cobalt_thread_setschedprio		101
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
index 7484c3a955..4784377b06 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
@@ -27,6 +27,7 @@
 __COBALT_CALL32emu_THUNK(thread_create)
 __COBALT_CALL32emu_THUNK(thread_setschedparam_ex)
 __COBALT_CALL32emu_THUNK(thread_getschedparam_ex)
+__COBALT_CALL32emu_THUNK(thread_setschedprio)
 __COBALT_CALL32emu_THUNK(sem_open)
 __COBALT_CALL32x_THUNK(sem_open)
 __COBALT_CALL32emu_THUNK(sem_timedwait)
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a2482b7a00..faa7ef53a6 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -88,6 +88,15 @@ COBALT_SYSCALL32emu(thread_getschedparam_ex, current,
 	return ret ?: sys32_put_param_ex(policy, u_param, &param_ex);
 }
 
+COBALT_SYSCALL32emu(thread_setschedprio, conforming,
+		    (compat_ulong_t pth,
+		     int prio,
+		     __u32 __user *u_winoff,
+		     int __user *u_promoted))
+{
+	return cobalt_thread_setschedprio(pth, prio, u_winoff, u_promoted);
+}
+
 static inline int sys32_fetch_timeout(struct timespec *ts,
 				      const void __user *u_ts)
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 5ba6513f38..34904f96bd 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -45,6 +45,12 @@ COBALT_SYSCALL32emu_DECL(thread_getschedparam_ex,
 			  int __user *u_policy,
 			  struct compat_sched_param_ex __user *u_param));
 
+COBALT_SYSCALL32emu_DECL(thread_setschedprio,
+			 (compat_ulong_t pth,
+			  int prio,
+			  __u32 __user *u_winoff,
+			  int __user *u_promoted));
+
 COBALT_SYSCALL32emu_DECL(clock_getres,
 			 (clockid_t clock_id,
 			  struct compat_timespec __user *u_ts));
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 9f1c802b63..c2a9fb46c5 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -568,6 +568,43 @@ COBALT_SYSCALL(thread_getschedparam_ex, current,
 	return cobalt_copy_to_user(u_param, &param_ex, sizeof(param_ex));
 }
 
+int cobalt_thread_setschedprio(unsigned long pth,
+			       int prio,
+			       __u32 __user *u_winoff,
+			       int __user *u_promoted)
+{
+	struct sched_param_ex param_ex;
+	struct cobalt_thread *thread;
+	int ret, policy, promoted;
+
+	trace_cobalt_pthread_setschedprio(pth, prio);
+
+	thread = thread_lookup_or_shadow(pth, u_winoff, &promoted);
+	if (IS_ERR(thread))
+		return PTR_ERR(thread);
+
+	ret = __cobalt_thread_getschedparam_ex(thread, &policy, &param_ex);
+	if (ret)
+		return ret;
+
+	param_ex.sched_priority = prio;
+
+	ret = __cobalt_thread_setschedparam_ex(thread, policy, &param_ex);
+	if (ret)
+		return ret;
+
+	return cobalt_copy_to_user(u_promoted, &promoted, sizeof(promoted));
+}
+
+COBALT_SYSCALL(thread_setschedprio, conforming,
+	       (unsigned long pth,
+		int prio,
+		__u32 __user *u_winoff,
+		int __user *u_promoted))
+{
+	return cobalt_thread_setschedprio(pth, prio, u_winoff, u_promoted);
+}
+
 int __cobalt_thread_create(unsigned long pth, int policy,
 			   struct sched_param_ex *param_ex,
 			   int xid, __u32 __user *u_winoff)
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index fec9d17859..51be372a7a 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -139,6 +139,11 @@ int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
 				     int *policy_r,
 				     struct sched_param_ex *param_ex);
 
+int cobalt_thread_setschedprio(unsigned long pth,
+			       int prio,
+			       __u32 __user *u_winoff,
+			       int __user *u_promoted);
+
 struct cobalt_thread *cobalt_thread_find(pid_t pid);
 
 struct cobalt_thread *cobalt_thread_find_local(pid_t pid);
@@ -181,6 +186,12 @@ COBALT_SYSCALL_DECL(thread_getschedparam_ex,
 		     int __user *u_policy,
 		     struct sched_param_ex __user *u_param));
 
+COBALT_SYSCALL_DECL(thread_setschedprio,
+		    (unsigned long pth,
+		     int prio,
+		     __u32 __user *u_winoff,
+		     int __user *u_promoted));
+
 void cobalt_thread_map(struct xnthread *curr);
 
 struct xnthread_personality *cobalt_thread_exit(struct xnthread *curr);
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index bda7bdd3c8..83ec748586 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -70,6 +70,7 @@
 		__cobalt_symbolic_syscall(thread_kill),			\
 		__cobalt_symbolic_syscall(thread_setschedparam_ex),	\
 		__cobalt_symbolic_syscall(thread_getschedparam_ex),	\
+		__cobalt_symbolic_syscall(thread_setschedprio),		\
 		__cobalt_symbolic_syscall(thread_getstat),		\
 		__cobalt_symbolic_syscall(sem_init),			\
 		__cobalt_symbolic_syscall(sem_destroy),			\
@@ -311,6 +312,20 @@ DEFINE_EVENT(cobalt_posix_schedparam, cobalt_pthread_getschedparam,
 	TP_ARGS(pth, policy, param_ex)
 );
 
+TRACE_EVENT(cobalt_pthread_setschedprio,
+	TP_PROTO(unsigned long pth, int prio),
+	TP_ARGS(pth, prio),
+	TP_STRUCT__entry(
+		__field(unsigned long, pth)
+		__field(int, prio)
+	),
+	TP_fast_assign(
+		__entry->pth = pth;
+		__entry->prio = prio;
+	),
+	TP_printk("pth=%p prio=%d", (void *)__entry->pth, __entry->prio)
+);
+
 #define cobalt_print_thread_mode(__mode)			\
 	__print_flags(__mode, "|",				\
 		      {PTHREAD_WARNSW, "warnsw"},		\
-- 
2.16.4


