From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Thu, 31 Mar 2011 13:31:28 +0200
Message-Id: <1301571088-14358-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Adeos-main] [PATCH] x86: get hostrt working on x86_32
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/x86/Kconfig        |    2 +-
 arch/x86/kernel/ipipe.c |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cef6fde..0a02ec5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -154,7 +154,7 @@ config GENERIC_CALIBRATE_DELAY
 
 config GENERIC_TIME_VSYSCALL
 	bool
-	default X86_64
+	default X86_64 || IPIPE
 
 config ARCH_HAS_CPU_RELAX
 	def_bool y
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index d1d4544..4de8cbe 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/clockchips.h>
 #include <linux/kprobes.h>
+#include <linux/ipipe_tickdev.h>
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -49,6 +50,7 @@
 #include <asm/apic.h>
 #endif	/* CONFIG_X86_LOCAL_APIC */
 #include <asm/traps.h>
+#include <asm/tsc.h>
 
 int __ipipe_tick_irq = 0;	/* Legacy timer */
 
@@ -814,6 +816,19 @@ int __ipipe_check_tickdev(const char *devname)
 	return ret;
 }
 
+#ifdef CONFIG_X86_32
+void update_vsyscall(struct timespec *wall_time, struct timespec *wtm,
+			struct clocksource *clock, u32 mult)
+{
+	if (clock == &clocksource_tsc)
+		ipipe_update_hostrt(wall_time, clock);
+}
+
+void update_vsyscall_tz(void)
+{
+}
+#endif /* CONFIG_X86_32 */
+
 EXPORT_SYMBOL(__ipipe_tick_irq);
 
 EXPORT_SYMBOL_GPL(irq_to_desc);
-- 
1.5.6.5


