MIME-Version: 1.0
In-Reply-To: <53BE4B0F.6030508@xenomai.org>
References: <CANKLDmuVD8_RKc37dKsVsfJhqpa-YyuiLaf8gMuBq0ZHSfB2Bw@mail.gmail.com>
 <53BE4B0F.6030508@xenomai.org>
Date: Thu, 10 Jul 2014 12:00:36 +0200
Message-ID: <CANKLDmuzb51aCMut6s_swBmt5PE-x28YNhjJsDcOsfUnqzPqzg@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Suspend-to-RAM of a Xenomai system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jul 10, 2014 at 10:13 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 07/10/2014 09:38 AM, Henri Roosen wrote:
>
>> Hi all,
>>
>> We have the requirement to put our ARM i.MX6 based Xenomai system into the
>> suspend-to-RAM state. Just before entering the mode we put the realtime
>> application in a state such that we don't need to be realtime anymore.
>>
>> The deep sleep mode is working on the system, however doesn't work well
>> with Xenomai:
>>
>> One problem we solved was a hangup when entering suspend-to-RAM state.
>> This
>> we traced down to Xenomai interrupts occurring during suspend mode where
>> interrupts need to be off. The lockup looks similar as described here:
>> http://www.xenomai.org/pipermail/xenomai/2014-January/029898.html.
>> Note: local_irq_disable_hw() cannot be used to disable the interrupts in
>> this case because later in the suspend sequence there are callbacks into
>> Xenomai which use xnlock_get_irqsave/xnlock_put_irqrestore which cannot
>> be
>> called after local_irq_disable_hw() because of inbalance of
>> the IPIPE_STALL_FLAG.
>>
>
> You would need ipipe_stall_head() to get both the real and virtual
> interrupt states in sync, which used to be called
> ipipe_stall_pipeline_head() in the legacy patches.
>
>
That is how we fixed this problem.


>> Now after we fixed the problem with disabling interrupts, we run into a
>> problem which isn't solved yet:
>>
>> Normally the system should go dormant on the WFI instruction, which it
>> does
>> almost half the time. The other times it doesn't and directly returns. And
>> that is only when Xenomai is enabled; a system running just an ipipe
>> enalbed kernel works as expected.
>>
>> I was trying to trace it down to Xenomai(-timer) interrupts, but cannot
>> prove it yet. The strange thing is that when I mask all interrupts on the
>> GPC, the wfi instruction still doesn't go dormant. Which doesn't make
>> sense
>> to me. Does anyone know why the wfi doesn't go dormant and/or what the
>> relationship is with Xenomai?
>>
>>
> I would rather stop the GP timer instead of only masking its IRQ channel,
> so that the timer can't fire during the short time window between flipping
> the I bit in the CPSR and masking the GPC sources. Also, WFI also senses
> FIQs - any chance you have one of those pending?
>
> FIQ's should be disabled by the additional call to local_fiq_disable_hw()
we added. Or is there an ipipe_stall_pipeline_xxxx() function that should
be called for that instead?

Anyway, you could double-check that the Xenomai timer is involved by
> enabling the nucleus but leaving all API skins unloaded/disabled. In that
> case, Xenomai 2.x does not grab the host timer, so it won't emulate the
> host kernel tick.
>

Based on your suggestion I did more tests. The problem triggers only when a
Xenomai module is loaded. Without the module loaded there is no problem. I
stripped down the module, it now only calls rt_task_create() and
rt_task_set_periodic() at module init, rt_task_delete() at module exit.
This reproduces the problem. However, if we leave out the call
to rt_task_set_periodic() the problem cannot be reproduced.

So does the rt_task_set_periodic() call lead to grabbing the host timer?
Any hints on how to workaround this problem when going into suspend-to-RAM?

Thanks!


>
>  Any help, suggestions, directions are highly appreciated!
>>
>> Henri.
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>>
>
> --
> Philippe.
>
