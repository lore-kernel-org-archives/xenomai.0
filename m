Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <4951382A.8010001@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 23 Dec 2008 20:06:49 +0100
Message-ID: <20081223190649.26094.60192.stgit@domain.hid>
In-Reply-To: <20081223190649.26094.61372.stgit@domain.hid>
References: <20081223190649.26094.61372.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v2 1/5] x86_32: Fix NMI watchdog build for
	2.6.27
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Fix build breakage against 2.6.27-x86-32 due to changes of die_nmi. At
this chance, switch the internal function call wrapping to latest
unified mainline instead of using the legacy prototype.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/arch/x86/hal_32.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/ksrc/arch/x86/hal_32.c b/ksrc/arch/x86/hal_32.c
index e8e1258..79b7c83 100644
--- a/ksrc/arch/x86/hal_32.c
+++ b/ksrc/arch/x86/hal_32.c
@@ -107,7 +107,7 @@ extern void show_registers(struct pt_regs *regs);
 
 extern spinlock_t nmi_print_lock;
 
-void die_nmi(struct pt_regs *regs, const char *msg)
+void die_nmi(const char *msg, struct pt_regs *regs, int do_panic)
 {
 	spin_lock(&nmi_print_lock);
 	/*
@@ -124,7 +124,11 @@ void die_nmi(struct pt_regs *regs, const char *msg)
 	do_exit(SIGSEGV);
 }
 
-#endif /* Linux < 2.6 */
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+#define die_nmi(msg, regs, do_panic)	die_nmi(regs, msg)
+#else /* Linux >= 2.6.27 */
+#include <asm/nmi.h>
+#endif /* Linux >= 2.6.27 */
 
 void rthal_latency_above_max(struct pt_regs *regs)
 {
@@ -136,7 +140,7 @@ void rthal_latency_above_max(struct pt_regs *regs)
 			 sizeof(buf),
 			 "NMI watchdog detected timer latency above %u us\n",
 			 rthal_maxlat_us);
-		die_nmi(regs, buf);
+		die_nmi(buf, regs, 1);
 	}
 }
 


