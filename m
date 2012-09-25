Message-ID: <5061C394.1050005@siemens.com>
Date: Tue, 25 Sep 2012 16:45:40 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
MIME-Version: 1.0
References: <50588110.6030701@siemens.com> <50588458.1010802@xenomai.org>
	<505892E8.6080605@siemens.com> <5058CD54.4070509@xenomai.org>
	<5059B76F.7020608@siemens.com> <505B4044.7030103@xenomai.org>
In-Reply-To: <505B4044.7030103@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [GIT PULL] core-5 for x86
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

On 20/09/12 18:11, Gilles Chanteperdrix wrote:
> On 09/19/2012 02:15 PM, Wolfgang Mauerer wrote:
>> On 18/09/12 21:36, Gilles Chanteperdrix wrote:
>>> On 09/18/2012 05:27 PM, Wolfgang Mauerer wrote:

>>> Ok. We have a currently pending issue on x86 which you should be
>>> informed about before discovering it during your tests: using
>>> rthal_supported_cpus is broken in I-pipe core patches when using the
>>> LAPIC timer: since there is only one irq handler for all the LAPIC
>>> timers, the handler is registered on all cpus, but on non started cpus,
>>> the handler will do nothing at best, and not foward the LAPIC ticks to
>>> Linux (which is still in control of the LAPIC timer on these cpus).
>>>
>>> This problem is due to the fact that we keep the same vector as Linux,
>>> and so the same irq. There are two ways out of this:
>>>
>>> - change the LAPIC vector when xenomai takes the control of the LAPIC
>>> timer, like we use to do, this is racy with current code because the
>>> timer is taken by Xenomai but still used a bit by Linux, before it is
>>> programmed by Xenomai, and Xenomai assumes that the host tick irq is the
>>> same as the timer irq. All this can be fixed, but the last drawback of
>>> this approach is that it does not fix the issue on architectures where
>>> the local timer irq is the same on all cpus, but can not be changed,
>>> hence the second approach;
>>> - the second approach is to add a test at the beginning of
>>> xnintr_clock_handler and forward the irq to the root domain if the
>>> current cpu does not belong to xnarch_supported_cpus. This means some
>>> patching of I-pipe timers so that ipipe_percpu.hrtimer_irq also gets
>>> defined for non supported cpus when they use the timer shared with other
>>> cpus, essentially what this patch tries (but fails) to achieve:
>>>
>>> http://www.xenomai.org/pipermail/xenomai/2012-September/026066.html
>>
>> thanks for the info! Unfortunately, I was not able to reproduce this
>> issue quickly using two latency instances bound to different CPUs on a
>> machine booted with isolcpus=1, though.
> 
> The issue is not with isolcpus, but with rthal_supported_cpus, that is
> xenomai "supported_cpus" parameter. And maybe Linux is running fine with
> the bug, but if you do a cat /proc/interrupts, you should see the local
> timer interrupt no longer incrementing on cpus not intercepted by xenomai.
 
the attached patch (against core-4), which is a slight modification of 
yours, resolves the issue for me when applied together with the xnintr 
patch (I've also rebased to core-5, see https://github.com/siemens/ipipe core-3.5_for-upstream)

Cheers, Wolfgang

########################################################################

Use ipipe_percpu.hrtimer_irq for non-RT CPUs when required

We need to be able to forward the timer interrupt to the
root domain on CPUs that are not used for real-time loads,
but use a timer shared with other CPUs. Based on a patch
by Gilles Chanteperdrix.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/ipipe/timer.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index 7dcd725..67ae4a7 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -172,11 +172,23 @@ int ipipe_select_timers(const struct cpumask *mask)
 	hrclock_khz = tmp;
 
 	spin_lock_irqsave(&lock, flags);
-	for_each_cpu(cpu, mask) {
+	for_each_cpu(cpu, cpu_online_mask) {
 		list_for_each_entry(t, &timers, link) {
 			if (!cpumask_test_cpu(cpu, t->cpumask))
 				continue;
 
+			/*
+			 * When the CPU is not used for real-time
+			 * loads, we need to be able to forward the
+			 * IRQ for this CPU to the root domain in case
+			 * it is shared with other CPUs.
+			 */
+			if (!cpumask_test_cpu(cpu, mask)
+			    && t->irq == per_cpu(ipipe_percpu.hrtimer_irq, 0)) {
+				per_cpu(ipipe_percpu.hrtimer_irq, cpu) = t->irq;
+				goto found;
+			}
+
 			evtdev = t->host_timer;
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 			if (!evtdev
@@ -184,6 +196,9 @@ int ipipe_select_timers(const struct cpumask *mask)
 #endif /* CONFIG_GENERIC_CLOCKEVENTS */
 				goto found;
 		}
+		if (!cpumask_test_cpu(cpu, mask))
+			continue;
+
 		printk("I-pipe: could not find timer for cpu #%d\n", cpu);
 		goto err_remove_all;
 
-- 
1.7.1



