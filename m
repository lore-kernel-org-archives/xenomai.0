From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Oct 2013 00:03:49 +0200
Message-Id: <1382738632-14649-4-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <526AEA7E.6030801@xenomai.org>
 <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 4/7] cobalt/fpu: dynamic XNFPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Instead of systematically creating user-space tasks with XNFPU enabled,
let the architectures decide when they want to enable it. In case they
arm it upon FPU fault, set sched->fpuholder if the fault is handled in
primary mode.
---
 kernel/cobalt/arch/arm/include/asm/xenomai/thread.h |    7 +------
 kernel/cobalt/arch/arm/thread.c                     |   10 ++++++++++
 kernel/cobalt/arch/sh/include/asm/xenomai/thread.h  |    6 +-----
 kernel/cobalt/arch/sh/thread.c                      |   10 ++++++++++
 kernel/cobalt/arch/x86/thread.c                     |    3 +++
 kernel/cobalt/posix/thread.c                        |    2 +-
 kernel/cobalt/shadow.c                              |   18 +++++++++---------
 7 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
index 346e329..8b54b97 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
@@ -99,12 +99,7 @@ static inline void xnarch_init_root_tcb(struct xnthread *thread)
 	tcb->fpup = NULL;
 }
 
-static inline void xnarch_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	tcb->fpup = (struct arm_fpustate *)
-		&task_thread_info(tcb->core.host_task)->used_cp[0];
-}
+void xnarch_init_shadow_tcb(struct xnthread *thread);
 
 int xnarch_fault_fpu_p(struct ipipe_trap_data *d);
 
diff --git a/kernel/cobalt/arch/arm/thread.c b/kernel/cobalt/arch/arm/thread.c
index 29a58fe..5f0d792 100644
--- a/kernel/cobalt/arch/arm/thread.c
+++ b/kernel/cobalt/arch/arm/thread.c
@@ -402,3 +402,13 @@ int xnarch_escalate(void)
 
 	return 0;
 }
+
+void xnarch_init_shadow_tcb(struct xnthread *thread)
+{
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
+	tcb->fpup = (struct arm_fpustate *)
+		&task_thread_info(tcb->core.host_task)->used_cp[0];
+
+	if (xnthread_test_state(thread, XNUSER))
+		xnthread_set_state(thread, XNFPU);
+}
diff --git a/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h b/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
index 6bf7329..2c7fe88 100644
--- a/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
@@ -60,11 +60,7 @@ static inline void xnarch_init_root_tcb(struct xnthread *thread)
 	tcb->fpup = NULL;
 }
 
-static inline void xnarch_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	tcb->fpup = &tcb->core.host_task->thread;
-}
+void xnarch_init_shadow_tcb(struct xnthread *thread);
 
 #else /* !CONFIG_XENO_HW_FPU */
 
diff --git a/kernel/cobalt/arch/sh/thread.c b/kernel/cobalt/arch/sh/thread.c
index 4c8b532..4b2361e 100644
--- a/kernel/cobalt/arch/sh/thread.c
+++ b/kernel/cobalt/arch/sh/thread.c
@@ -292,3 +292,13 @@ int xnarch_escalate(void)
 
 	return 0;
 }
+
+void xnarch_init_shadow_tcb(struct xnthread *thread)
+{
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
+	tcb->fpup = &tcb->core.host_task->thread;
+
+	if (xnthread_test_state(thread, XNUSER))
+		xnthread_set_state(thread, XNFPU);
+}
+
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 4ff699a..4e80495 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -339,6 +339,9 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
 #endif
 	tcb->fpup = x86_fpustate_ptr(&p->thread);
 	tcb->root_kfpu = 0;
+
+	if (xnthread_test_state(thread, XNUSER))
+		xnthread_set_state(thread, XNFPU);
 }
 
 int xnarch_escalate(void)
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 7ba91fc..df5949a 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -437,7 +437,7 @@ static inline int pthread_create(struct cobalt_thread **thread_p,
 	}
 
 	iattr.name = thread->attr.name;
-	iattr.flags = XNUSER|XNFPU;
+	iattr.flags = XNUSER;
 	iattr.personality = &cobalt_personality;
 	iattr.affinity = CPU_MASK_ALL;
 
diff --git a/kernel/cobalt/shadow.c b/kernel/cobalt/shadow.c
index 99ccee0..c858777 100644
--- a/kernel/cobalt/shadow.c
+++ b/kernel/cobalt/shadow.c
@@ -2591,12 +2591,14 @@ int ipipe_kevent_hook(int kevent, void *data)
 
 static inline int handle_exception(struct ipipe_trap_data *d)
 {
+	struct xnsched *sched;
 	struct xnthread *thread;
 
-	if (xnsched_root_p())
-		return 0;
+	sched = xnsched_current();
+	thread = sched->curr;
 
-	thread = xnsched_current_thread();
+	if (xnthread_test_state(thread, XNROOT))
+		return 0;
 
 	trace_mark(xn_nucleus, thread_fault,
 		   "thread %p thread_name %s ip %p type 0x%x",
@@ -2605,17 +2607,15 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 		   xnarch_fault_trap(d));
 
 	if (xnarch_fault_fpu_p(d)) {
-		if (!xnthread_test_state(thread, XNROOT)) {
-			/* FPU exception received in primary mode. */
-			if (xnarch_handle_fpu_fault(thread))
-				return 1;
+		/* FPU exception received in primary mode. */
+		if (xnarch_handle_fpu_fault(thread)) {
+			sched->fpuholder = thread;
+			return 1;
 		}
 		print_symbol("invalid use of FPU in Xenomai context at %s\n",
 			     xnarch_fault_pc(d));
 	}
 
-	if (xnthread_test_state(thread, XNROOT))
-		return 0;
 	/*
 	 * If we experienced a trap on behalf of a shadow thread
 	 * running in primary mode, move it to the Linux domain,
-- 
1.7.10.4


