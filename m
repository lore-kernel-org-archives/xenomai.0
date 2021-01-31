From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 07/13] cobalt/arm: ipipe: remove obsolete calibration handler
Date: Sun, 31 Jan 2021 15:45:34 +0100
Message-Id: <20210131144540.243363-7-rpm@xenomai.org>
In-Reply-To: <20210131144540.243363-1-rpm@xenomai.org>
References: <20210131144540.243363-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/arch/arm/ipipe/machine.c | 59 --------------------------
 1 file changed, 59 deletions(-)

diff --git a/kernel/cobalt/arch/arm/ipipe/machine.c b/kernel/cobalt/arch/arm/ipipe/machine.c
index 721567182..0fd48cae1 100644
--- a/kernel/cobalt/arch/arm/ipipe/machine.c
+++ b/kernel/cobalt/arch/arm/ipipe/machine.c
@@ -19,13 +19,8 @@
  */
 
 #include <linux/mm.h>
-#include <linux/ipipe_tickdev.h>
-#include <cobalt/kernel/arith.h>
-#include <asm/cacheflush.h>
 #include <asm/xenomai/machine.h>
 
-#define CALIBRATION_LOOPS 10
-
 static void mach_arm_prefault(struct vm_area_struct *vma)
 {
 	unsigned long addr;
@@ -43,59 +38,6 @@ static void mach_arm_prefault(struct vm_area_struct *vma)
 	}
 }
 
-static unsigned long mach_arm_calibrate(void)
-{
-	unsigned long delay = (cobalt_pipeline.timer_freq + HZ / 2) / HZ;
-	unsigned long long start, end, sum = 0, sum_sq = 0;
-	unsigned long result, flags, tsc_lat;
-	long long diff;
-	int i, j;
-
-	flags = ipipe_critical_enter(NULL);
-
-	/*
-	 * Hw interrupts off, other CPUs quiesced, no migration
-	 * possible. We can now fiddle with the timer chip (per-cpu
-	 * local or global, ipipe_timer_set() will handle this
-	 * transparently).
-	 */
-	ipipe_read_tsc(start);
-	barrier();
-	ipipe_read_tsc(end);
-	tsc_lat = end - start;
-	barrier();
-
-	for (i = 0; i < CALIBRATION_LOOPS; i++) {
-		flush_cache_all();
-		for (j = 0; j < CALIBRATION_LOOPS; j++) {
-			ipipe_read_tsc(start);
-			barrier();
-			ipipe_timer_set(delay);
-			barrier();
-			ipipe_read_tsc(end);
-			diff = end - start - tsc_lat;
-			if (diff > 0) {
-				sum += diff;
-				sum_sq += diff * diff;
-			}
-		}
-	}
-
-	ipipe_critical_exit(flags);
-
-	/* Use average + standard deviation as timer programming latency. */
-	do_div(sum, CALIBRATION_LOOPS * CALIBRATION_LOOPS);
-	do_div(sum_sq, CALIBRATION_LOOPS * CALIBRATION_LOOPS);
-	result = sum + int_sqrt(sum_sq - sum * sum) + 1;
-	/*
-	 * Reset the max trace, since it contains the calibration time
-	 * now.
-	 */
-	ipipe_trace_max_reset();
-
-	return result;
-}
-
 static const char *const fault_labels[] = {
 	[IPIPE_TRAP_ACCESS] = "Data or instruction access",
 	[IPIPE_TRAP_SECTION] = "Section fault",
@@ -116,7 +58,6 @@ struct cobalt_machine cobalt_machine = {
 	.init = NULL,
 	.late_init = NULL,
 	.cleanup = NULL,
-	.calibrate = mach_arm_calibrate,
 	.prefault = mach_arm_prefault,
 	.fault_labels = fault_labels,
 };
-- 
2.26.2


