Message-ID: <49A2BCF3.40901@domain.hid>
Date: Mon, 23 Feb 2009 16:12:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] x86: Fix race in rthal_timer_request
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

There is a tiny race window between requesting a tick device, which
includes obtaining its frequency, and transferring that value to
rthal_tunables.timer_freq. Close it by passing a reference to the
latter to ipipe_request_tickdev. For older kernels, set the frequency
before calling into ipipe_request_tickdev.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/arch/x86/hal-common.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ksrc/arch/x86/hal-common.c b/ksrc/arch/x86/hal-common.c
index 19637b4..5adeae3 100644
--- a/ksrc/arch/x86/hal-common.c
+++ b/ksrc/arch/x86/hal-common.c
@@ -111,7 +111,7 @@ int rthal_timer_request(
 			 struct clock_event_device *cdev),
 	int cpu)
 {
-	unsigned long tmfreq;
+	unsigned long dummy, *tmfreq = &dummy;
 	int tickval, err, res;
 
 	if (cpu_timers_requested == 0) {
@@ -124,13 +124,16 @@ int rthal_timer_request(
 
 	/* This code works both for UP+LAPIC and SMP configurations. */
 
+	if (rthal_timerfreq_arg == 0)
+		tmfreq = &rthal_tunables.timer_freq;
+
 #ifdef __IPIPE_FEATURE_REQUEST_TICKDEV
 	res = ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu,
-				    &tmfreq);
+				    tmfreq);
 #else
+	*tmfreq = RTHAL_COMPAT_TIMERFREQ;
 	res = ipipe_request_tickdev("lapic", (compat_emumode_t)mode_emul,
 				    (compat_emutick_t)tick_emul, cpu);
-	tmfreq = RTHAL_COMPAT_TIMERFREQ;
 #endif
 
 	switch (res) {
@@ -162,9 +165,6 @@ int rthal_timer_request(
 	}
 	rthal_ktimer_saved_mode = res;
 
-	if (rthal_timerfreq_arg == 0)
-		rthal_tunables.timer_freq = tmfreq;
-
 	/*
 	 * The rest of the initialization should only be performed
 	 * once by a single CPU.

