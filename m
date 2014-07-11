MIME-Version: 1.0
In-Reply-To: <CANKLDmuhm6v-pWksFU0WQw0=8gzzt43LUQVii-g-Vrr0XW++yg@mail.gmail.com>
References: <CANKLDmuVD8_RKc37dKsVsfJhqpa-YyuiLaf8gMuBq0ZHSfB2Bw@mail.gmail.com>
 <53BE4B0F.6030508@xenomai.org>
 <CANKLDmuzb51aCMut6s_swBmt5PE-x28YNhjJsDcOsfUnqzPqzg@mail.gmail.com>
 <53BEC6E9.7010609@xenomai.org>
 <CANKLDmuhm6v-pWksFU0WQw0=8gzzt43LUQVii-g-Vrr0XW++yg@mail.gmail.com>
Date: Fri, 11 Jul 2014 14:33:03 +0200
Message-ID: <CANKLDmuTBt7RLWc9K-Cd4P4==V=agdjuE72Z_qfKbsR88DKf5w@mail.gmail.com>
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

On Fri, Jul 11, 2014 at 12:33 PM, Henri Roosen <henriroosen@gmail.com>
wrote:

>
> On Thu, Jul 10, 2014 at 7:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 07/10/2014 12:00 PM, Henri Roosen wrote:
>>
>>>
>>> FIQ's should be disabled by the additional call to
>>> local_fiq_disable_hw() we added. Or is there an
>>> ipipe_stall_pipeline_xxxx() function that should be called for that
>>> instead?
>>>
>>>
>> FIQ control is not part of the generic i-pipe API.
>>
>>
>>      Anyway, you could double-check that the Xenomai timer is involved by
>>>     enabling the nucleus but leaving all API skins unloaded/disabled. In
>>>     that case, Xenomai 2.x does not grab the host timer, so it won't
>>>     emulate the host kernel tick.
>>>
>>>
>>> Based on your suggestion I did more tests. The problem triggers only
>>> when a Xenomai module is loaded. Without the module loaded there is no
>>> problem. I stripped down the module, it now only calls rt_task_create()
>>> and rt_task_set_periodic() at module init, rt_task_delete() at module
>>> exit. This reproduces the problem. However, if we leave out the call
>>> to rt_task_set_periodic() the problem cannot be reproduced.
>>>
>>> So does the rt_task_set_periodic() call lead to grabbing the host timer?
>>>
>>
>> This is done earlier when turning on the services of the first API to
>> connect to the system (posix, native etc.) So this happens upon modprobing
>> the fist API module, or during the machine boot up if such API is built in
>> the kernel.
>>
>> If the Xenomai system timer is different from the regular kernel clock
>> event source, then calling rt_task_set_periodic() causes a stream of IRQs
>> different from the host timer IRQ to arrive.
>>
>> You can check the Xenomai system timer state and source looking at
>> /proc/xenomai/timer.
>>
>>
> It's definitely related to the timer irq triggering; a simple module that
> uses only rtdm to trigger a timer using rtdm_timer_start_in_handler() in
> the handler reproduces the problem,
>
>
>>  Any hints on how to workaround this problem when going into
>>> suspend-to-RAM?
>>>
>>
>> Why some IRQ would still be pending while reaching WFI is unclear to me
>> (read: I have no idea why), but maybe you could try checking the current
>> assumptions by disabling the Xenomai time source very impolitely, by
>> calling xnpod_disable_timesource(), then switching it back using
>> xnpod_enable_timesource() when exiting the suspended state.
>>
>> No guarantee that this will work flawlessly around a suspended state, as
>> a matter of fact these services are currently used only during Xenomai boot
>> up and shutdown phases. I suspect that if Xenomai does not share the clock
>> chip with the host kernel, Xenomai software timers depending on this clock
>> event source will remain stuck. You could probably work around this by
>> calling ipipe_trigger_irq(XNARCH_TIMER_IRQ) right after
>> xnpod_enable_timesource() though.
>>
>> In short, the corresponding and simplified sequence would be:
>>
>> xnpod_disable_timesource();
>> hard_local_irq_disable();
>> wfi
>> xnpod_enable_timesource();
>> ipipe_trigger_irq(XNARCH_TIMER_IRQ);
>
>
> Unfortunately this doesn't work. Enabling the timesource after the wfi
> leads to some kind of strange lockup of the system when trying to wake up,
> where it seems to be stuck at some cpu_idle loop.
>
> Any suggestions for steps to try or debug this?
>

Ok, found out why it was not working:  xnpod_disable_timesource() disables
and removes all existing timers. If I leave out the call, then the first
tests seem to be working as expected.

Are there similar problems when we have some other xenomai interrupts in
the system? I will probably shut those down, but might be good to know.

Thanks!


>
>>
>> --
>> Philippe.
>>
>
>
