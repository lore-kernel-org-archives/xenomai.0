Message-ID: <47977D5E.50001@domain.hid>
Date: Wed, 23 Jan 2008 18:46:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] 2.6.24: fix x86-64 build w/o CONFIG_SMP
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

...but do not break CONFIG_SMP :). Looks like this header became
irrelevant for us.

Jan

---
 arch/x86/kernel/ipipe.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -48,7 +48,6 @@
 #include <asm/apic.h>
 #include <mach_ipi.h>
 #else /* !CONFIG_X86_32 */
-#include <asm/ipi.h>
 #include <asm/mach_apic.h>
 #endif /* !CONFIG_X86_32 */
 #endif	/* CONFIG_X86_LOCAL_APIC */

