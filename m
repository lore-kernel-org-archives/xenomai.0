From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/3] cobalt/kernel: substitute ipipe_processor_id() with
 raw_smp_processor_id()
Date: Wed, 16 Dec 2020 17:44:53 +0100
Message-Id: <20201216164455.158920-2-rpm@xenomai.org>
In-Reply-To: <20201216164455.158920-1-rpm@xenomai.org>
References: <20201216164455.158920-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

raw_smp_processor_id() has been callable from any pipeline domain for
many moons now, there is no point in using the legacy
ipipe_processor_id() call anymore.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/assert.h    |  2 +-
 include/cobalt/kernel/lock.h      |  4 ++--
 kernel/cobalt/arch/arm/thread.c   | 10 +++++-----
 kernel/cobalt/arch/arm64/thread.c |  2 +-
 kernel/cobalt/arch/x86/thread.c   |  6 +++---
 kernel/cobalt/debug.c             |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/cobalt/kernel/assert.h b/include/cobalt/kernel/assert.h
index 86d0a480f..7c93b7e5c 100644
--- a/include/cobalt/kernel/assert.h
+++ b/include/cobalt/kernel/assert.h
@@ -60,7 +60,7 @@
 #define primary_mode_only()	XENO_BUG_ON(CONTEXT, ipipe_root_p)
 #define secondary_mode_only()	XENO_BUG_ON(CONTEXT, !ipipe_root_p)
 #define interrupt_only()	XENO_BUG_ON(CONTEXT, !xnsched_interrupt_p())
-#define realtime_cpu_only()	XENO_BUG_ON(CONTEXT, !xnsched_supported_cpu(ipipe_processor_id()))
+#define realtime_cpu_only()	XENO_BUG_ON(CONTEXT, !xnsched_supported_cpu(raw_smp_processor_id()))
 #define thread_only()		XENO_BUG_ON(CONTEXT, xnsched_interrupt_p())
 #define irqoff_only()		XENO_BUG_ON(CONTEXT, hard_irqs_disabled() == 0)
 #ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
diff --git a/include/cobalt/kernel/lock.h b/include/cobalt/kernel/lock.h
index 4b1909f5a..bae047524 100644
--- a/include/cobalt/kernel/lock.h
+++ b/include/cobalt/kernel/lock.h
@@ -175,7 +175,7 @@ static inline void xnlock_init (struct xnlock *lock)
 
 static inline int ____xnlock_get(struct xnlock *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
 {
-	int cpu = ipipe_processor_id();
+	int cpu = raw_smp_processor_id();
 	unsigned long long start;
 
 	if (lock->owner == cpu)
@@ -242,7 +242,7 @@ static inline void __xnlock_put_irqrestore(struct xnlock *lock, spl_t flags
 static inline int xnlock_is_owner(struct xnlock *lock)
 {
 	if (__locking_active__)
-		return lock->owner == ipipe_processor_id();
+		return lock->owner == raw_smp_processor_id();
 
 	return 1;
 }
diff --git a/kernel/cobalt/arch/arm/thread.c b/kernel/cobalt/arch/arm/thread.c
index d3c2fed83..c68b5e3f4 100644
--- a/kernel/cobalt/arch/arm/thread.c
+++ b/kernel/cobalt/arch/arm/thread.c
@@ -78,7 +78,7 @@ static inline union vfp_state *get_fpu_owner(void)
 		return NULL;
 #endif
 
-	cpu = ipipe_processor_id();
+	cpu = raw_smp_processor_id();
 	vfp_owner = vfp_current_hw_state[cpu];
 	if (!vfp_owner)
 		return NULL;
@@ -214,8 +214,8 @@ void xnarch_leave_root(struct xnthread *root)
 void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 {
 	union vfp_state *const from_fpup = from ? from->tcb.fpup : NULL;
-	unsigned cpu = ipipe_processor_id();
-	
+	unsigned cpu = raw_smp_processor_id();
+
 	if (xnthread_test_state(to, XNROOT) == 0) {
 		union vfp_state *const to_fpup = to->tcb.fpup;
 		unsigned fpexc = do_enable_vfp();
@@ -252,7 +252,7 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 			do_vfp_fmxr(FPEXC, fpen & ~XNARCH_VFP_ANY_EXC);
 			if (from_fpup == current_task_fpup)
 				return;
-			
+
 			__asm_vfp_save(from_fpup, fpen);
 			do_vfp_fmxr(FPEXC, fpdis);
 		}
@@ -260,7 +260,7 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 	}
 }
 
-int xnarch_handle_fpu_fault(struct xnthread *from, 
+int xnarch_handle_fpu_fault(struct xnthread *from,
 			struct xnthread *to, struct ipipe_trap_data *d)
 {
 	if (xnthread_test_state(to, XNFPU))
diff --git a/kernel/cobalt/arch/arm64/thread.c b/kernel/cobalt/arch/arm64/thread.c
index 719c30a62..1068f80cc 100644
--- a/kernel/cobalt/arch/arm64/thread.c
+++ b/kernel/cobalt/arch/arm64/thread.c
@@ -90,7 +90,7 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 	fpsimd_save_state(from_fpup);
 
 	fpsimd_load_state(to_fpup);
-	to_fpup->cpu = ipipe_processor_id();
+	to_fpup->cpu = raw_smp_processor_id();
 }
 
 void xnarch_init_shadow_tcb(struct xnthread *thread)
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 1ed6acb46..f1f81b750 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -227,7 +227,7 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 		if (!copy_fpregs_to_fpstate(prev_fpu))
 			prev_fpu->last_cpu = -1;
 		else
-			prev_fpu->last_cpu = smp_processor_id();
+			prev_fpu->last_cpu = raw_smp_processor_id();
 	}
 #endif
 
@@ -288,7 +288,7 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 		 * PF_KTHREAD, i.e including kernel threads.
 		 */
 		struct fpu *fpu = &current->thread.fpu;
-		int cpu = smp_processor_id();
+		int cpu = raw_smp_processor_id();
 
 		if (!fpregs_state_valid(fpu, cpu)) {
 			copy_kernel_to_fpregs(&fpu->state);
@@ -513,7 +513,7 @@ void xnarch_leave_root(struct xnthread *root)
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
 	switch_fpu_finish(&current->thread.fpu);
 #else
-	switch_fpu_finish(&current->thread.fpu, smp_processor_id());
+	switch_fpu_finish(&current->thread.fpu, raw_smp_processor_id());
 #endif
 #else
 	/* mark current thread as not owning the FPU anymore */
diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index ddfecf813..12fc57289 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -577,7 +577,7 @@ int xnlock_dbg_release(struct xnlock *lock,
 	int cpu;
 
 	lock_time = xnclock_read_raw(&nkclock) - lock->lock_date;
-	cpu = ipipe_processor_id();
+	cpu = raw_smp_processor_id();
 	stats = &per_cpu(xnlock_stats, cpu);
 
 	if (lock->file == NULL) {
-- 
2.26.2


