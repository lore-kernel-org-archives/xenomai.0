From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [I-PIPE Xenoami3.1 PATCH 2/2] x86/tsc: I-PIPE : notify I-PIPE about
 updated clockfreq
Date: Fri, 27 May 2022 02:22:03 -0400
Message-Id: <20220527062203.9498-3-hongzhan.chen@intel.com>
In-Reply-To: <20220527062203.9498-1-hongzhan.chen@intel.com>
References: <20220527062203.9498-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When there is refined tsc clock, notify Xenomai to apply it.
Linux may schedule a delayed work to refine tsc clock and update
tsc_khz which happen after Xenomai finsih init but tsc_scale and
tsc_shift still keep the value depending on origianl tsc clock
which is outdated. The difference between two clocks may cause
unexpected timing drift.

For example:
  [ 0.001731] tsc: Detected 2899.886 MHz TSC
  [ 5.588387] tsc: Refined TSC clocksource calibration: 2903.999 MHz
  cat /sys/module/xenomai/parameters/clockfreq
  2899886000
  After patching, we like to use 2903.999 MHz.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 835856efd71f..e2ca733d76ee 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1294,6 +1294,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	u64 tsc_stop, ref_stop, delta;
 	unsigned long freq;
 	int cpu;
+	unsigned int ipipe_freq;
 
 	/* Don't bother refining TSC on unstable systems */
 	if (tsc_unstable)
@@ -1345,6 +1346,10 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	/* Inform the TSC deadline clockevent devices about the recalibration */
 	lapic_update_tsc_freq();
 
+	/* notify xenomai about updated clockfreq */
+	ipipe_freq = tsc_khz * 1000;
+	 __ipipe_report_clockfreq_update(ipipe_freq);
+
 	/* Update the sched_clock() rate to match the clocksource one */
 	for_each_possible_cpu(cpu)
 		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop);
-- 
2.17.1


