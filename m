From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/2] ARM: dovetail: make legacy and prctl-based syscalls
 coexist transparently
Date: Sat, 13 Nov 2021 19:34:07 +0100
Message-Id: <20211113183407.1115539-2-rpm@xenomai.org>
In-Reply-To: <20211113183407.1115539-1-rpm@xenomai.org>
References: <20211113183407.1115539-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/arm/Kconfig               |  1 +
 arch/arm/kernel/entry-common.S | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cc2033a29e198bc..44b86d35d9e51af 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -238,6 +238,7 @@ config ARCH_MTD_XIP
 # Limited I-pipe compat (syscall routing only).
 config IPIPE_COMPAT
 	bool
+	select DOVETAIL_LEGACY_SYSCALL_RANGE
 
 config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime" if EMBEDDED
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 48d93a2d9b6290b..2a75de1254fa2ae 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -270,14 +270,15 @@ local_restart:
 	b	fastcall_try
 1:
 #endif	
-	cmp	scno, #__NR_prctl
-	bne	fastcall_not_prctl
-	ldr	r0, [sp, #S_OLD_R0]
-	tst	r10, #__OOB_SYSCALL_BIT
-	bne	fastcall_try
-fastcall_not_prctl:
+#ifdef CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE
 	ldr	r0, =#__OOB_SYSCALL_BIT
 	ands	r0, scno, r0
+	bne	fastcall_try
+#endif
+	cmp	scno, #__NR_prctl
+	bne	slow_path
+	ldr	r0, [sp, #S_OLD_R0]
+	tst	r0, #__OOB_SYSCALL_BIT
 	beq	slow_path
 fastcall_try:
 	tst	r10, #_TLF_OOB
@@ -285,6 +286,8 @@ fastcall_try:
 	mov	r0, sp				@ regs
 	bl	handle_oob_syscall
 	ldr	r10, [tsk, #TI_LOCAL_FLAGS]
+	tst	r0, r0
+	beq	slow_path
 	tst	r10, #_TLF_OOB
 	bne	fastcall_exit_check		@ check for MAYDAY
 	bl	sync_inband_irqs
@@ -299,9 +302,15 @@ fastcall_exit_check:
 slow_path:
 	tst	r10, #_TLF_DOVETAIL
 	bne	pipeline_syscall
-	cmp	scno, #__NR_prctl
-	beq	pipeline_syscall
+#ifdef CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE
+	ldr	r0, =#__OOB_SYSCALL_BIT
 	ands	r0, scno, r0
+	bne	pipeline_syscall
+#endif	
+	cmp	scno, #__NR_prctl
+	bne	root_syscall
+	ldr	r0, [sp, #S_OLD_R0]
+	tst	r0, #__OOB_SYSCALL_BIT
 	beq	root_syscall
 pipeline_syscall:
 	mov	r0, sp				@ regs
-- 
2.31.1


