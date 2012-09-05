Message-ID: <50470D2D.8020004@xenomai.org>
Date: Wed, 05 Sep 2012 10:28:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>	<50460BCE.8010505@xenomai.org>	<CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>	<50464969.2000902@xenomai.org>	<5046549C.7030008@xenomai.org>	<CANKLDmufv25Bngqb3CapS6ybHG9DH76DUq1q6dinzJ5ai7TowA@mail.gmail.com>	<5046FF0A.9000208@xenomai.org>
	<CANKLDmverDgL3c2BEtXAwkGhq7KLRopGnM3q9Z_TQiAAeMponw@mail.gmail.com>
In-Reply-To: <CANKLDmverDgL3c2BEtXAwkGhq7KLRopGnM3q9Z_TQiAAeMponw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09/05/2012 09:42 AM, Henri Roosen wrote:
> On Wed, Sep 5, 2012 at 9:28 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 09/05/2012 09:26 AM, Henri Roosen wrote:
>>
>>> On Tue, Sep 4, 2012 at 9:21 PM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> On 09/04/2012 08:33 PM, Gilles Chanteperdrix wrote:
>>>>
>>>>> On 09/04/2012 04:28 PM, Henri Roosen wrote:
>>>>>
>>>>>> On Tue, Sep 4, 2012 at 4:10 PM, Gilles Chanteperdrix
>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>> On 09/04/2012 03:42 PM, Henri Roosen wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I'm using the bleeding edge of Xenomai (0590cb45adce468f619) and Ipipe
>>>>>>>> (d21e8cdbdcf21ade) on a x86 multicore system and kernel 3.4.6.
>>>>>>>> I reserved one cpu (kernel param isolcpus=1).
>>>>>>>>
>>>>>>>> Our application triggers the following NULL pointer dereference when I
>>>>>>>> set the affinity of some tasks to cpu 0 and other tasks to cpu 1.
>>>>>>>> The application does not trigger this when all tasks have the same
>>>>>>>> affinity (set via /proc/xenomai/affinity).
>>>>>>>>
>>>>>>>> I was able to reproduce this also under QEMU and will do some
>>>>>>>> debugging, but maybe someone knows what is wrong already by seeing the
>>>>>>>> stacktrace below:
>>>>>>>
>>>>>>> Could you try to reduce the bug to a simple testcase which we would try
>>>>>>> and run to reproduce?
>>>>>>>
>>>>>>>> [  108.013023] BUG: unable to handle kernel NULL pointer dereference
>>>>>>> at 00000294
>>>>>>>> [  108.013550] IP: [<c0126a91>] __lock_task_sighand+0x53/0xc3
>>>>>>>
>>>>>>> Or send us a disassembly of the function __lock_task_sighand?
>>>>>
>>>>>
>>>>> Looks like someone is calling send_sig_info with an invalid pointer.
>>>>> There is something seriously wrong.
>>>>>
>>>>> On the other hand, now that I think about it, you need at least the
>>>>> following patch:
>>>>>
>>>>> diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
>>>>> index c75fcac..0f37bb2 100644
>>>>> --- a/ksrc/nucleus/intr.c
>>>>> +++ b/ksrc/nucleus/intr.c
>>>>> @@ -93,8 +93,18 @@ void xnintr_host_tick(struct xnsched *sched) /* Interrupts off. */
>>>>>
>>>>>  void xnintr_clock_handler(void)
>>>>>  {
>>>>> -     struct xnsched *sched = xnpod_current_sched();
>>>>>       xnstat_exectime_t *prev;
>>>>> +     struct xnsched *sched;
>>>>> +     unsigned cpu;
>>>>> +
>>>>> +     cpu = xnarch_current_cpu();
>>>>> +
>>>>> +     if (!cpumask_test_cpu(cpu, &xnarch_supported_cpus)) {
>>>>> +             xnarch_relay_tick();
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     sched = xnpod_sched_slot(cpu);
>>>>>
>>>>>       prev = xnstat_exectime_switch(sched,
>>>>>               &nkclock.stat[xnsched_cpu(sched)].account);
>>>>
>>>>
>>>> It should work (I did not test it), with the following patch on the
>>>> I-pipe:
>>>>
>>>> diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
>>>> index d51fa62..301cdc0 100644
>>>> --- a/kernel/ipipe/timer.c
>>>> +++ b/kernel/ipipe/timer.c
>>>> @@ -176,11 +176,17 @@ int ipipe_select_timers(const struct cpumask *mask)
>>>>                 hrclock_freq = __ipipe_hrclock_freq;
>>>>
>>>>         spin_lock_irqsave(&lock, flags);
>>>> -       for_each_cpu(cpu, mask) {
>>>> +       for_each_cpu(cpu, cpu_online_mask) {
>>>>                 list_for_each_entry(t, &timers, link) {
>>>>                         if (!cpumask_test_cpu(cpu, t->cpumask))
>>>>                                 continue;
>>>>
>>>> +                       if (!cpumask_test_cpu(cpu, mask)
>>>> +                           && t->irq == per_cpu(ipipe_percpu.hrtimer_irq, 0)) {
>>>> +                               per_cpu(ipipe_percpu.hrtimer_irq, cpu) = t->irq;
>>>> +                               goto found;
>>>> +                       }
>>>> +
>>>>                         evtdev = t->host_timer;
>>>>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>>>>                         if (!evtdev
>>>> @@ -188,10 +194,16 @@ int ipipe_select_timers(const struct cpumask *mask)
>>>>  #endif /* CONFIG_GENERIC_CLOCKEVENTS */
>>>>                                 goto found;
>>>>                 }
>>>> +               if (!cpumask_test_cpu(cpu, mask))
>>>> +                       continue;
>>>> +
>>>>                 printk("I-pipe: could not find timer for cpu #%d\n", cpu);
>>>>                 goto err_remove_all;
>>>>
>>>>           found:
>>>> +               if (!cpumask_test_cpu(cpu, mask))
>>>> +                       continue;
>>>> +
>>>>                 if (__ipipe_hrtimer_freq == 0)
>>>>                         __ipipe_hrtimer_freq = t->freq;
>>>>                 per_cpu(ipipe_percpu.hrtimer_irq, cpu) = t->irq;
>>>>
>>> Thanks for looking into this Gilles!
>>> I tried your second patch only and unfortunately I was still able to
>>> reproduce the same kernel NULL pointer dereference.
>>
>>
>> Sorry, I meant the first xenomai patch needs the second I-pipe patch to
>> work.
> 
> I applied both patches now, but still able to reproduce the same problem.

Ok, to debug this, you can add:
BUG_ON((unsigned long)xnthread_user_task(thread) < 0xc0000000);
in xnshadow_send_sig. Add:
BUG_ON((unsigned long)p < 0xc0000000)
in lostage_handler, in the LO_SIGTHR_REQ case.

Enable the I-pipe tracer, panic back traces, then set the number of
points to a reasonably high value before running your test.

-- 
					    Gilles.

