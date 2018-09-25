From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:48 +0200
Message-Id: <20180925103809.4932-12-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 11/32] x86/tsc: ipipe: keep calibration accurate
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hard disable interrupts to keep the calibration accurate.
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 8da0efb13544..9b2163d2c483 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -15,6 +15,7 @@
  */
 typedef unsigned long long cycles_t;
 
+extern struct clocksource clocksource_tsc;
 extern unsigned int cpu_khz;
 extern unsigned int tsc_khz;
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0bf06fa3027e..5269ef409010 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -683,9 +683,9 @@ unsigned long native_calibrate_cpu(void)
 	if (fast_calibrate)
 		return fast_calibrate;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	fast_calibrate = quick_pit_calibrate();
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 	if (fast_calibrate)
 		return fast_calibrate;
 
@@ -728,11 +728,11 @@ unsigned long native_calibrate_cpu(void)
 		 * calibration, which will take at least 50ms, and
 		 * read the end value.
 		 */
-		local_irq_save(flags);
+		flags = hard_local_irq_save();
 		tsc1 = tsc_read_refs(&ref1, hpet);
 		tsc_pit_khz = pit_calibrate_tsc(latch, ms, loopmin);
 		tsc2 = tsc_read_refs(&ref2, hpet);
-		local_irq_restore(flags);
+		hard_local_irq_restore(flags);
 
 		/* Pick the lowest PIT TSC calibration so far */
 		tsc_pit_min = min(tsc_pit_min, tsc_pit_khz);
@@ -1006,7 +1006,7 @@ static void detect_art(void)
 
 /* clocksource code */
 
-static struct clocksource clocksource_tsc;
+struct clocksource clocksource_tsc;
 
 static void tsc_resume(struct clocksource *cs)
 {
@@ -1058,7 +1058,7 @@ static void tsc_cs_tick_stable(struct clocksource *cs)
 /*
  * .mask MUST be CLOCKSOURCE_MASK(64). See comment above read_tsc()
  */
-static struct clocksource clocksource_tsc = {
+struct clocksource clocksource_tsc = {
 	.name                   = "tsc",
 	.rating                 = 300,
 	.read                   = read_tsc,
-- 
2.14.4


