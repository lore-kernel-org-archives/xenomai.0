From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Wed, 26 Sep 2012 15:16:02 +0200
Message-Id: <1348665363-28222-1-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <5063141B.8070107@siemens.com>
References: <5063141B.8070107@siemens.com>
Subject: [Xenomai] [PATCH 1/2] Refactor ipipe_select_timers
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

Make the control flow more readable. No functional changes.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/ipipe/timer.c |   82 +++++++++++++++++++++++++++++++------------------
 1 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index 8b2eb6f..765340e 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -154,21 +154,55 @@ static void ipipe_timer_request_sync(void)
 	timer->request(timer, steal);
 }
 
+/* Set up a timer as per-cpu timer for ipipe */
+static int install_pcpu_timer(unsigned cpu, unsigned hrclock_freq,
+			      struct ipipe_timer *t) {
+	unsigned hrtimer_freq;
+	unsigned long long tmp;
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	struct clock_event_device *evtdev;
+	evtdev = t->host_timer;
+
+	if (evtdev && evtdev->mode == CLOCK_EVT_MODE_SHUTDOWN)
+		return 0;
+#endif /* CONFIG_GENERIC_CLOCKEVENTS */
+
+	if (__ipipe_hrtimer_freq == 0)
+		__ipipe_hrtimer_freq = t->freq;
+
+	per_cpu(ipipe_percpu.hrtimer_irq, cpu) = t->irq;
+	per_cpu(percpu_timer, cpu) = t;
+
+	hrtimer_freq = t->freq;
+	if (__ipipe_hrclock_freq > UINT_MAX)
+		hrtimer_freq /= 1000;
+
+	t->c2t_integ = hrtimer_freq / hrclock_freq;
+	tmp = (((unsigned long long)
+		(hrtimer_freq % hrclock_freq)) << 32)
+		+ hrclock_freq - 1;
+	do_div(tmp, hrclock_freq);
+	t->c2t_frac = tmp;
+
+	return 1;
+}
+
+
 /*
- * choose per-cpu timer: we walk the list, and find the timer with the
- * highest rating.
+ * Choose per-cpu timers with the highest rating by traversing the
+ * rating-sorted list for each CPU.
  */
 int ipipe_select_timers(const struct cpumask *mask)
 {
-	struct clock_event_device *evtdev;
-	unsigned hrclock_freq, hrtimer_freq;
+	unsigned hrclock_freq;
 	unsigned long long tmp;
 	struct ipipe_timer *t;
 	unsigned long flags;
-	unsigned cpu, khz;
+	unsigned cpu;
+	bool found;
 
-	khz = __ipipe_hrclock_freq > UINT_MAX;
-	if (khz) {
+	if (__ipipe_hrclock_freq > UINT_MAX) {
 		tmp = __ipipe_hrclock_freq;
 		do_div(tmp, 1000);
 		hrclock_freq = tmp;
@@ -177,34 +211,22 @@ int ipipe_select_timers(const struct cpumask *mask)
 
 	spin_lock_irqsave(&lock, flags);
 	for_each_cpu(cpu, mask) {
+		found = false;
 		list_for_each_entry(t, &timers, link) {
 			if (!cpumask_test_cpu(cpu, t->cpumask))
 				continue;
 
-			evtdev = t->host_timer;
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-			if (!evtdev
-			    || evtdev->mode != CLOCK_EVT_MODE_SHUTDOWN)
-#endif /* CONFIG_GENERIC_CLOCKEVENTS */
-				goto found;
+			if (install_pcpu_timer(cpu, hrclock_freq, t)) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			printk("I-pipe: could not find timer for cpu #%d\n",
+			       cpu);
+			goto err_remove_all;
 		}
-		printk("I-pipe: could not find timer for cpu #%d\n", cpu);
-		goto err_remove_all;
-
-	  found:
-		if (__ipipe_hrtimer_freq == 0)
-			__ipipe_hrtimer_freq = t->freq;
-		per_cpu(ipipe_percpu.hrtimer_irq, cpu) = t->irq;
-		per_cpu(percpu_timer, cpu) = t;
-		hrtimer_freq = t->freq;
-		if (khz)
-			hrtimer_freq /= 1000;
-		t->c2t_integ = hrtimer_freq / hrclock_freq;
-		tmp = (((unsigned long long)
-			(hrtimer_freq % hrclock_freq)) << 32)
-			+ hrclock_freq - 1;
-		do_div(tmp, hrclock_freq);
-		t->c2t_frac = tmp;
 	}
 	spin_unlock_irqrestore(&lock, flags);
 
-- 
1.7.1


