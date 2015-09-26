From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Sep 2015 13:42:45 +0200
Message-Id: <1443267765-30719-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH] arm64/ipipe: emit I-pipe events upon FPU faults
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

---
 arch/arm64/include/asm/ipipe_base.h | 8 ++------
 arch/arm64/kernel/fpsimd.c          | 6 ++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/ipipe_base.h b/arch/arm64/include/asm/ipipe_base.h
index 72ad7a4..60ce10e 100644
--- a/arch/arm64/include/asm/ipipe_base.h
+++ b/arch/arm64/include/asm/ipipe_base.h
@@ -100,8 +100,8 @@ unsigned __ipipe_processor_id(void);
 #define IPIPE_TRAP_DABT		 2	/* Generic data abort */
 #define IPIPE_TRAP_UNKNOWN	 3	/* Unknown exception */
 #define IPIPE_TRAP_BREAK	 4	/* Instruction breakpoint */
-#define IPIPE_TRAP_FPU		 5	/* Floating point exception */
-#define IPIPE_TRAP_VFP		 6	/* VFP floating point exception */
+#define IPIPE_TRAP_FPU_ACC	 5	/* Floating point access */
+#define IPIPE_TRAP_FPU_EXC	 6	/* Floating point exception */
 #define IPIPE_TRAP_UNDEFINSTR	 7	/* Undefined instruction */
 #define IPIPE_TRAP_ALIGNMENT	 8	/* Unaligned access exception */
 #define IPIPE_TRAP_MAYDAY        9	/* Internal recovery trap */
@@ -163,10 +163,6 @@ static inline unsigned ipipe_test_and_stall_root(void)
 #define __IPIPE_FEATURE_PREEMPTIBLE_SWITCH	1
 #define __IPIPE_FEATURE_SYSINFO_V2		1
 
-#ifdef CONFIG_VFP
-#define __IPIPE_FEATURE_VFP_SAFE		1
-#endif
-
 #ifdef CONFIG_IPIPE_ARM_KUSER_TSC
 #define __IPIPE_FEATURE_KUSER_TSC		1
 #endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3dca156..b7c44ef 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -93,6 +93,9 @@ static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
  */
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 {
+	if (__ipipe_report_trap(IPIPE_TRAP_FPU_ACC, regs))
+		return
+
 	/* TODO: implement lazy context saving/restoring */
 	WARN_ON(1);
 }
@@ -105,6 +108,9 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 	siginfo_t info;
 	unsigned int si_code = 0;
 
+	if (__ipipe_report_trap(IPIPE_TRAP_FPU_EXC, regs))
+		return
+
 	if (esr & FPEXC_IOF)
 		si_code = FPE_FLTINV;
 	else if (esr & FPEXC_DZF)
-- 
1.8.4


