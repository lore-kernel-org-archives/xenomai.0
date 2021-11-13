From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] dovetail: make legacy and prctl-based syscalls coexist
 transparently
Date: Sat, 13 Nov 2021 19:34:06 +0100
Message-Id: <20211113183407.1115539-1-rpm@xenomai.org>
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

These changes aim at enabling support for both the legacy and
prctl-based syscall formats by the same kernel, without affecting the
syscall handling logic in the companion cores which still depend on
the former. CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE should be turned on
by such cores in order to enable the legacy call format.

If CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE is set, we assume the
companion core may not handle the new prctl-based call format, but
expects the __OOB_SYSCALL_BIT to be set directly into the syscall code
register instead, defining its own syscall range.

In this case, prctl() requests with an oob signature might be received
by the oob syscall handler, but these should always be handled from
the in-band stage, regardless of the call arguments. To this end, the
oob syscall handler is allowed to ask for the request to be propagated
to the peer in-band handler, which would then decide to either handle
the request locally, or pass it down in turn to the regular syscall
handler. This is a rare case, when prctl-based syscalls are not
accepted by the companion core, but some application would issue
prctl() calls matching the oob signature (i.e. prctl(option |
__OOB_SYSCALL_BIT, ...)), denoting either a misconfiguration, or a
broken application.

If CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE is unset, every oob syscall
must be folded into a prctl() request, with the __OOB_SYSCALL_BIT set
into the option argument.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/Kconfig.dovetail |  4 ++++
 kernel/dovetail.c       | 40 +++++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/kernel/Kconfig.dovetail b/kernel/Kconfig.dovetail
index a21377296c188be..c9ec30d1b4a4d39 100644
--- a/kernel/Kconfig.dovetail
+++ b/kernel/Kconfig.dovetail
@@ -17,3 +17,7 @@ config DOVETAIL
 	  Activate this option if you want to enable the interface for
 	  running a secondary kernel side-by-side with Linux (aka
 	  "dual kernel" configuration).
+
+config DOVETAIL_LEGACY_SYSCALL_RANGE
+       depends on DOVETAIL
+       def_bool y
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 92af8d1e10b0c21..4df6b23cdb4f78c 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -65,8 +65,9 @@ void dovetail_stop_altsched(void)
 }
 EXPORT_SYMBOL_GPL(dovetail_stop_altsched);
 
-void __weak handle_oob_syscall(struct pt_regs *regs)
+int __weak handle_oob_syscall(struct pt_regs *regs)
 {
+	return 0;
 }
 
 int __weak handle_pipelined_syscall(struct irq_stage *stage,
@@ -169,13 +170,18 @@ int __pipeline_syscall(struct pt_regs *regs)
 static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
 {
 	/*
-	 * Check whether the companion core might be interested in
-	 * @nr. Hand the request to the core if __OOB_SYSCALL_BIT is
-	 * set in @nr, or this is a prctl() request into which an oob
-	 * syscall might be folded.
+	 * Check whether the companion core might be interested in the
+	 * syscall call. If the old syscall form is handled, pass the
+	 * request to the core if __OOB_SYSCALL_BIT is set in
+	 * @nr. Otherwise, only check whether an oob syscall is folded
+	 * into a prctl() request.
 	 */
-	return (nr & __OOB_SYSCALL_BIT) ||
-		(nr == __NR_prctl && syscall_get_arg0(regs) & __OOB_SYSCALL_BIT);
+	if (IS_ENABLED(CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE)) {
+		if (nr & __OOB_SYSCALL_BIT)
+			return true;
+	}
+
+	return nr == __NR_prctl && syscall_get_arg0(regs) & __OOB_SYSCALL_BIT;
 }
 
 int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
@@ -217,15 +223,19 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 	 */
 
 	if ((local_flags & _TLF_OOB) && maybe_oob_syscall(nr, regs)) {
-		handle_oob_syscall(regs);
+		ret = handle_oob_syscall(regs);
+		if (!IS_ENABLED(CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE))
+			WARN_ON_ONCE(dovetail_debug() && !ret);
 		local_flags = READ_ONCE(ti_local_flags(ti));
-		if (local_flags & _TLF_OOB) {
-			if (test_ti_thread_flag(ti, TIF_MAYDAY))
-				dovetail_call_mayday(regs);
-			return 1; /* don't pass down, no tail work. */
-		} else {
-			WARN_ON_ONCE(dovetail_debug() && irqs_disabled());
-			return -1; /* don't pass down, do tail work. */
+		if (likely(ret)) {
+			if (local_flags & _TLF_OOB) {
+				if (test_ti_thread_flag(ti, TIF_MAYDAY))
+					dovetail_call_mayday(regs);
+				return 1; /* don't pass down, no tail work. */
+			} else {
+				WARN_ON_ONCE(dovetail_debug() && irqs_disabled());
+				return -1; /* don't pass down, do tail work. */
+			}
 		}
 	}
 
-- 
2.31.1


