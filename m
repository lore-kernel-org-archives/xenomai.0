Message-ID: <50644ACA.5080906@siemens.com>
Date: Thu, 27 Sep 2012 14:47:06 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
MIME-Version: 1.0
References: <5063141B.8070107@siemens.com>
	<1348665363-28222-1-git-send-email-wolfgang.mauerer@siemens.com>
	<50637398.3090108@xenomai.org> <50640E35.5010302@siemens.com>
	<506440BF.50001@xenomai.org>
In-Reply-To: <506440BF.50001@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] Refactor ipipe_select_timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 27/09/12 14:04, Gilles Chanteperdrix wrote:
> On 09/27/2012 10:28 AM, Wolfgang Mauerer wrote:
>> On 26/09/12 23:28, Gilles Chanteperdrix wrote:
>>> On 09/26/2012 03:16 PM, Wolfgang Mauerer wrote:
(...)

>>> Talking about readability, I find a goto with a clear label name much
>>> more readable than a flag. So, NACK this patch, please keep the goto.
>>  
>> So you're against the refactoring, or only against using the flag?
>> Keeping the goto leads to something like
>>
>> 	if (install_pcpu_timer(cpu, hrclock_freq, t))
>> 		goto found
>> (...)
>> found:    ;
>>
>> since we need a statement for the label, but nothing is left to do.
>> I find this fairly ugly, but if you prefer it over a flag, then
>> so be it.
> 
> Then use return instead of goto...

Won't work -- that skips the rest of the enclosing per_cpu loop and
the second part of the function introduced in the follow-up commit
that does the actual bugfixing.

Since I take the flag is the issue and not the refactoring as such, 
please find an updated patch with a goto below.

Cheers, Wolfgang

######################################################################
>From 713f567194520ba6bc32935402218f629d1fa134 Mon Sep 17 00:00:00 2001
From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Wed, 26 Sep 2012 13:38:44 +0200
Subject: [PATCH 1/1] Refactor ipipe_select_timers

Make the control flow more readable. No functional changes.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/ipipe/timer.c |   73 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index 8b2eb6f..360fc33 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -154,21 +154,54 @@ static void ipipe_timer_request_sync(void)
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
 
-	khz = __ipipe_hrclock_freq > UINT_MAX;
-	if (khz) {
+	if (__ipipe_hrclock_freq > UINT_MAX) {
 		tmp = __ipipe_hrclock_freq;
 		do_div(tmp, 1000);
 		hrclock_freq = tmp;
@@ -181,30 +214,14 @@ int ipipe_select_timers(const struct cpumask *mask)
 			if (!cpumask_test_cpu(cpu, t->cpumask))
 				continue;
 
-			evtdev = t->host_timer;
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-			if (!evtdev
-			    || evtdev->mode != CLOCK_EVT_MODE_SHUTDOWN)
-#endif /* CONFIG_GENERIC_CLOCKEVENTS */
+			if (install_pcpu_timer(cpu, hrclock_freq, t))
 				goto found;
 		}
-		printk("I-pipe: could not find timer for cpu #%d\n", cpu);
-		goto err_remove_all;
 
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
+		printk("I-pipe: could not find timer for cpu #%d\n",
+		       cpu);
+		goto err_remove_all;
+found:		;
 	}
 	spin_unlock_irqrestore(&lock, flags);
 
-- 
1.7.1

