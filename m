From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [linux-dovetail][PATCH] dovetail: Make syscall hook configurable
Message-ID: <295f1454-5ffd-78e3-94af-0af5c04228fc@siemens.com>
Date: Tue, 9 Nov 2021 20:00:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoid breaking existing companion cores by enabling prctl hooks
unconditionally. Rather request converted cores to select
DOVETAIL_USE_PRCTL_SYSCALL which automatically turns off the then no
longer needed DOVETAIL_USE_SYSCALL_BIT (unless a core actually selects 
both).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This fixes the breakage of Xenomai 3.2 over 5.10.y-dovetail[-rebase] and 
also 5.15.y-dovetail-rebase.

 arch/arm/kernel/entry-common.S | 10 +++++++++-
 kernel/Kconfig.dovetail        |  7 +++++++
 kernel/dovetail.c              | 10 +++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 6d9719622daf..fa5aaf5dcb2b 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -259,12 +259,18 @@ local_restart:
 	add	scno, scno, #__OOB_SYSCALL_BIT	@ force in oob marker
 	b	fastcall_try
 1:
-#endif	
+#endif
+#ifdef DOVETAIL_USE_PRCTL_SYSCALL
 	cmp	scno, #__NR_prctl
 	beq	fastcall_try
+#endif
+#ifdef DOVETAIL_USE_SYSCALL_BIT
 	ldr	r0, =#__OOB_SYSCALL_BIT
 	ands	r0, scno, r0
 	beq	slow_path
+#else
+	b	slow_path
+#endif
 fastcall_try:
 	tst	r10, #_TLF_OOB
 	beq	slow_path
@@ -285,8 +291,10 @@ fastcall_exit_check:
 slow_path:
 	tst	r10, #_TLF_DOVETAIL
 	bne	pipeline_syscall
+#ifdef DOVETAIL_USE_PRCTL_SYSCALL
 	cmp	scno, #__NR_prctl
 	beq	pipeline_syscall
+#endif
 	ands	r0, scno, r0
 	beq	root_syscall
 pipeline_syscall:
diff --git a/kernel/Kconfig.dovetail b/kernel/Kconfig.dovetail
index a21377296c18..debbf2fb8104 100644
--- a/kernel/Kconfig.dovetail
+++ b/kernel/Kconfig.dovetail
@@ -17,3 +17,10 @@ config DOVETAIL
 	  Activate this option if you want to enable the interface for
 	  running a secondary kernel side-by-side with Linux (aka
 	  "dual kernel" configuration).
+
+config DOVETAIL_USE_PRCTL_SYSCALL
+	bool
+
+config DOVETAIL_USE_SYSCALL_BIT
+	bool
+	default y if !DOVETAIL_USE_PRCTL_SYSCALL
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index a59a21ac1303..8d918db92bc8 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -168,6 +168,8 @@ int __pipeline_syscall(struct pt_regs *regs)
 
 static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
 {
+	bool result = false;
+
 	/*
 	 * Check whether the companion core might be interested in
 	 * @nr. Hand the request to the core if __OOB_SYSCALL_BIT is
@@ -176,7 +178,13 @@ static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
 	 * a regular in-band request, the core should tell us to
 	 * propagate it to the in-band handler eventually.
 	 */
-	return nr == __NR_prctl || (nr & __OOB_SYSCALL_BIT);
+#ifdef DOVETAIL_USE_PRCTL_SYSCALL
+	result ||= nr == __NR_prctl;
+#endif
+#ifdef DOVETAIL_USE_SYSCALL_BIT
+	result ||= nr & __OOB_SYSCALL_BIT;
+#endif
+	return result;
 }
 
 int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
-- 
2.31.1

