Message-ID: <4DEA1D6E.7050000@domain.hid>
Date: Sat, 04 Jun 2011 13:56:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] ipipe: x86: Fix 64-bit IRQ exit path
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

We need to skip of rbp in return now as it is saved to the stack on
entry.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

FWIW, this makes 2.6.38+ useable with x86-64 (tested with 2.6.38.8 so
far).

 arch/x86/kernel/entry_64.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index ba709ff..ed0f408 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -870,8 +870,11 @@ common_interrupt:
 	jnz ret_from_intr
 	decl PER_CPU_VAR(irq_count)
 	leaveq
+	CFI_RESTORE		rbp
 	CFI_DEF_CFA_REGISTER	rsp
 	CFI_ADJUST_CFA_OFFSET	-8
+	addq $8, %rsp
+	CFI_ADJUST_CFA_OFFSET	-8
 	testl $3,CS-ARGOFFSET(%rsp)
 	jz restore_args
 	jmp retint_swapgs_notrace
@@ -1039,8 +1042,11 @@ ENTRY(\sym)
 	jnz ret_from_intr
 	decl PER_CPU_VAR(irq_count)
 	leaveq
+	CFI_RESTORE		rbp
 	CFI_DEF_CFA_REGISTER	rsp
 	CFI_ADJUST_CFA_OFFSET	-8
+	addq $8, %rsp
+	CFI_ADJUST_CFA_OFFSET	-8
 	testl $3,CS-ARGOFFSET(%rsp)
 	jz restore_args
 	jmp retint_swapgs_notrace
-- 
1.7.1

