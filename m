From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Fri,  2 Jul 2010 13:50:01 +0200
Message-Id: <1278071401-13880-3-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278071401-13880-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Adeos-main] [PATCH 2/2] ipipe: CLOCK_HOST_REALTIME: x86-specific
	part
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

x86 specific mechanism to make NTP-corrected time information
available to non-Linux domains.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/Kconfig              |    1 +
 arch/x86/include/asm/tsc.h    |    1 +
 arch/x86/kernel/tsc.c         |    4 ++--
 arch/x86/kernel/vsyscall_64.c |    6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 89b72a9..4ab6f49 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -50,6 +50,7 @@ config X86
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZMA
 	select HAVE_ARCH_KMEMCHECK
+	select IPIPE_HOSTRT if IPIPE && GENERIC_CLOCKEVENTS
 
 config OUTPUT_FORMAT
 	string
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index c042729..aed7d66 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -14,6 +14,7 @@
  */
 typedef unsigned long long cycles_t;
 
+extern struct clocksource clocksource_tsc;
 extern unsigned int cpu_khz;
 extern unsigned int tsc_khz;
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 597683a..5e298a2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -699,7 +699,7 @@ core_initcall(cpufreq_tsc);
 
 /* clocksource code */
 
-static struct clocksource clocksource_tsc;
+struct clocksource clocksource_tsc;
 
 /*
  * We compare the TSC to the cycle_last value in the clocksource
@@ -745,7 +745,7 @@ static void resume_tsc(void)
 	clocksource_tsc.cycle_last = 0;
 }
 
-static struct clocksource clocksource_tsc = {
+struct clocksource clocksource_tsc = {
 	.name                   = "tsc",
 	.rating                 = 300,
 	.read                   = read_tsc,
diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
index 8cb4974..f1b90f7 100644
--- a/arch/x86/kernel/vsyscall_64.c
+++ b/arch/x86/kernel/vsyscall_64.c
@@ -32,6 +32,7 @@
 #include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/notifier.h>
+#include <linux/ipipe_tickdev.h>
 
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
@@ -89,6 +90,11 @@ void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
 	vsyscall_gtod_data.wall_to_monotonic = wall_to_monotonic;
 	vsyscall_gtod_data.wall_time_coarse = __current_kernel_time();
 	write_sequnlock_irqrestore(&vsyscall_gtod_data.lock, flags);
+
+#ifdef CONFIG_IPIPE_HOSTRT
+	if (clock == &clocksource_tsc)
+		update_ipipe_hostrt(wall_time, clock);
+#endif
 }
 
 /* RED-PEN may want to readd seq locking, but then the variable should be
-- 
1.6.4


