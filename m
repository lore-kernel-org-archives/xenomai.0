From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Wed, 26 Sep 2012 15:16:03 +0200
Message-Id: <1348665363-28222-2-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <5063141B.8070107@siemens.com>
References: <5063141B.8070107@siemens.com>
Subject: [Xenomai] [PATCH 2/2] Register high-res timer irq for non-ipipe
	timers if necessary
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

If a CPU that is not supported by ipipe, but used by Linux
shares an IRQ with a timer utilised by ipipe, it must be
possible to forward IRQs received on behalf of the Linux CPU.
Based on a patch by Gilles Chanteperdrix.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/ipipe/timer.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index 765340e..3b5e13e 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -188,6 +188,21 @@ static int install_pcpu_timer(unsigned cpu, unsigned hrclock_freq,
 	return 1;
 }
 
+static void select_root_only_timer(unsigned cpu, unsigned hrclock_khz,
+				   const struct cpumask *mask,
+				   struct ipipe_timer *t) {
+	unsigned icpu;
+
+	/*
+	 * If no ipipe-supported CPU shares an interrupt with the
+	 * timer, we do not need to care about it.
+	 */
+	for_each_cpu(icpu, mask) {
+		if (t->irq == per_cpu(ipipe_percpu.hrtimer_irq, icpu))
+			if (install_pcpu_timer(cpu, hrclock_khz, t))
+				break;
+	}
+}
 
 /*
  * Choose per-cpu timers with the highest rating by traversing the
@@ -201,6 +216,7 @@ int ipipe_select_timers(const struct cpumask *mask)
 	unsigned long flags;
 	unsigned cpu;
 	bool found;
+	cpumask_t fixup;
 
 	if (__ipipe_hrclock_freq > UINT_MAX) {
 		tmp = __ipipe_hrclock_freq;
@@ -210,6 +226,8 @@ int ipipe_select_timers(const struct cpumask *mask)
 		hrclock_freq = __ipipe_hrclock_freq;
 
 	spin_lock_irqsave(&lock, flags);
+
+	/* First, choose timers for the CPUs handled by ipipe */
 	for_each_cpu(cpu, mask) {
 		found = false;
 		list_for_each_entry(t, &timers, link) {
@@ -228,6 +246,24 @@ int ipipe_select_timers(const struct cpumask *mask)
 			goto err_remove_all;
 		}
 	}
+
+	/*
+	 * Second, check if we need to fix up any CPUs not supported
+	 * by ipipe (but by Linux) whose interrupt may need to be
+	 * forwarded because they have the same IRQ as an ipipe-enabled
+	 * timer.
+	 */
+	cpumask_andnot(&fixup, cpu_online_mask, mask);
+
+	for_each_cpu(cpu, &fixup) {
+		list_for_each_entry(t, &timers, link) {
+			if (!cpumask_test_cpu(cpu, t->cpumask))
+				continue;
+
+			select_root_only_timer(cpu, hrclock_freq, mask, t);
+		}
+	}
+
 	spin_unlock_irqrestore(&lock, flags);
 
 	flags = ipipe_critical_enter(ipipe_timer_request_sync);
-- 
1.7.1


