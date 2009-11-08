From: Bernhard Walle <bernhard@domain.hid>
Date: Sun,  8 Nov 2009 10:18:26 +0100
Message-Id: <1257671906-18311-1-git-send-email-bernhard@domain.hid>
In-Reply-To: <4AF68CA8.6010105@domain.hid>
References: <4AF68CA8.6010105@domain.hid>
Subject: [Xenomai-core] [PATCH] Check CPU frequency
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: bernhard@domain.hid

In some conditions, while testing Xenomai in VirtualBox, I had the error that
xnarch_init_timeconv() is called from init_32.h with a frequency of 0. That
leads to a division by zero, followed by a system oops.

Of course that is a bug in the virtualisation and Linux reports a CPU frequency
of 0 in /proc/cpuinfo. However, there's no harm if Xenomai checks that instead
of crashing the whole system.

Signed-off-by: Bernhard Walle <bernhard@domain.hid>
---
 ksrc/arch/generic/hal.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index 4d2fd38..8a5ec39 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -822,6 +822,13 @@ int rthal_init(void)
      * The arch-dependent support must have updated the various
      * frequency args as required.
      */
+
+    /* check the CPU frequency first and abort if it's invalid */
+    if (rthal_cpufreq_arg == 0) {
+        printk(KERN_ERR "Xenomai has detected a CPU frequency of 0. Aborting.\n");
+        return -ENODEV;
+    }
+
     rthal_tunables.cpu_freq = rthal_cpufreq_arg;
     rthal_tunables.timer_freq = rthal_timerfreq_arg;
     rthal_tunables.clock_freq = rthal_clockfreq_arg;
-- 
1.6.3.3


