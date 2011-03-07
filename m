Message-ID: <4D750FCC.1080302@domain.hid>
Date: Mon, 07 Mar 2011 18:03:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] ipipe: x86: Harden TSC calibration
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

When I-pipe is active, local_irq_save will still allow hardware
interrupts to occur, potentially disturbing the sensitive TSC
calibration.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

The kernel applies some sanity checks on the results, but they allow up
to 10% jitter. And this variation of the TSC frequency has been seen
in the field, causing problems when synchronizing with external clocks.

 arch/x86/kernel/tsc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 23f74eb..42c6c8a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -409,9 +409,9 @@ unsigned long native_calibrate_tsc(void)
 	unsigned long flags, latch, ms, fast_calibrate;
 	int hpet = is_hpet_enabled(), i, loopmin;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	fast_calibrate = quick_pit_calibrate();
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 	if (fast_calibrate)
 		return fast_calibrate;
 
@@ -454,11 +454,11 @@ unsigned long native_calibrate_tsc(void)
 		 * calibration, which will take at least 50ms, and
 		 * read the end value.
 		 */
-		local_irq_save(flags);
+		local_irq_save_hw(flags);
 		tsc1 = tsc_read_refs(&ref1, hpet);
 		tsc_pit_khz = pit_calibrate_tsc(latch, ms, loopmin);
 		tsc2 = tsc_read_refs(&ref2, hpet);
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 
 		/* Pick the lowest PIT TSC calibration so far */
 		tsc_pit_min = min(tsc_pit_min, tsc_pit_khz);
-- 
1.7.1

