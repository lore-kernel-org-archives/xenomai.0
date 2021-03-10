From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH dovetail/master & v5.10] x86: dovetail: add support to 32-bit
 syscall path
Message-ID: <09466f06-99c6-b98c-410f-1c834c92d182@siemens.com>
Date: Wed, 10 Mar 2021 16:51:34 +0100
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>, Evl <evl@evlproject.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to do_syscall_64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/entry/common.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index c93d6be8f3ac..dc90c7fb4b9b 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -99,11 +99,22 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 	 * or may not be necessary, but it matches the old asm behavior.
 	 */
 	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+
+	if (dovetailing()) {
+		if (nr == EXIT_SYSCALL_OOB) {
+			hard_local_irq_disable();
+			return;
+		}
+		if (nr == EXIT_SYSCALL_TAIL)
+			goto done;
+	}
+
 	instrumentation_begin();
 
 	do_syscall_32_irqs_on(regs, nr);
 
 	instrumentation_end();
+done:
 	syscall_exit_to_user_mode(regs);
 }
 
@@ -145,9 +156,20 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
 	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
 
+	if (dovetailing()) {
+		if (nr == EXIT_SYSCALL_OOB) {
+			instrumentation_end();
+			hard_local_irq_disable();
+			return true;
+		}
+		if (nr == EXIT_SYSCALL_TAIL)
+			goto done;
+	}
+
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
 
+done:
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 	return true;
-- 
2.26.2

