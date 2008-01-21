Message-ID: <47946EBA.2020107@domain.hid>
Date: Mon, 21 Jan 2008 11:06:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86-64: fix build for CONFIG_PREEMPT
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Someone (me? :-]) broke CONFIG_PREEMPT for 2.6.24 x86-64. Here is the
required fix.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

---
 arch/x86/kernel/ipipe.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.24-rc8-xeno_64/arch/x86/kernel/ipipe.c
===================================================================
--- linux-2.6.24-rc8-xeno_64.orig/arch/x86/kernel/ipipe.c
+++ linux-2.6.24-rc8-xeno_64/arch/x86/kernel/ipipe.c
@@ -570,6 +570,8 @@ asmlinkage int __ipipe_syscall_root(stru
 #else /* !CONFIG_X86_32 */

 #ifdef CONFIG_PREEMPT
+asmlinkage void preempt_schedule_irq(void);
+
 /*
  * Check the stall bit of the root domain to make sure the existing
  * preemption opportunity upon in-kernel resumption could be

