Message-ID: <4F79D13A.9040705@domain.hid>
Date: Mon, 02 Apr 2012 18:18:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F4150C8.7040104@domain.hid> <4F4278ED.9090802@domain.hid>
	<4F478285.8020105@domain.hid> <4F47A161.9010704@domain.hid>
	<4F79C838.2070609@domain.hid> <4F79CBAA.6040107@domain.hid>
	<4F79CEE1.4000302@domain.hid>
In-Reply-To: <4F79CEE1.4000302@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 2012-04-02 18:08, Gilles Chanteperdrix wrote:
> On 04/02/2012 05:54 PM, Jan Kiszka wrote:
>> On 2012-04-02 17:39, Gilles Chanteperdrix wrote:
>>> On 02/24/2012 03:40 PM, Philippe Gerum wrote:
>>>> On 02/24/2012 01:28 PM, Gilles Chanteperdrix wrote:
>>>>> On 02/20/2012 05:46 PM, Philippe Gerum wrote:
>>>>>> On 02/19/2012 08:43 PM, Gilles Chanteperdrix wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> restarting the ipipe-core is the good opportunity to look a bit at our
>>>>>>> current state and think about what we could improve. On ARM, at least,
>>>>>>> the thing we could improve is the timer subsystem. A long time ago,
>>>>>>> linux has switched to a system allowing to select at run-time which
>>>>>>> timer to use, and we do not really benefit from this, what timer we use
>>>>>>> is selected at compile time, resulting in a massive ifdefery on arm, and
>>>>>>> even on x86, we have to select at compile time whether using the 8254 or
>>>>>>> APIC, whereas we could decide to use whatever linux is using, even say
>>>>>>> HPET, without any compilation option. That is assuming we want to move
>>>>>>> the x86 timer-specific code from xenomai to I-pipe.
>>>>>>>
>>>>>>> The idea to reach this goal would be to add some ipipe specific members
>>>>>>> to the struct clock_event_device, the way we do for the interrupt
>>>>>>> controller:
>>>>>>> - a CLOCK_EVT_FEAT_IPIPE would signal that the clockevent device is
>>>>>>> ipipe capable, meaning that it implements the following callback
>>>>>>> - ipipe_steal would be called when stealing the timer, we could decide
>>>>>>> to call this callback either as part of ipipe_request_timer, or with a
>>>>>>> specific ipipe_steal_timer call, currently we simply set
>>>>>>> __ipipe_mach_timerstolen to 1, but it is pure luck that we never needed
>>>>>>> something more complicated, besides, we may want to start a timer that
>>>>>>> was not started by linux so, we would put its initialization here;
>>>>>>> - ipipe_stolen would record whether the timer is stolen
>>>>>>> - ipipe_min_delta_ticks, ipipe_max_delta_ticks would be used by the
>>>>>>> ipipe_set_next_event callback
>>>>>>> - ipipe_ack would be called to ack the timer interrupt the way we
>>>>>>> currently do it currently on arm with __ipipe_mach_acktimer
>>>>>>> - ipipe_set_next_event would program the next timer shot, the way it is
>>>>>>> currently done in __ipipe_mach_set_dec.
>>>>>>>
>>>>>>> All this is pretty straightforward, but there is still a question: how
>>>>>>> does ipipe_request_timer select a timer. The idea is that on platform
>>>>>>> without PIC muting, it is probably more efficient to use the same timer
>>>>>>> for linux and xenomai. But on platforms with PIC muting, we could want
>>>>>>> to select a different timer for linux and xenomai, but how do we find
>>>>>>> it, what if linux has not selected a timer because it is unusable on
>>>>>>> that platform?
>>>>>>
>>>>>> Checking the clock device mode for CLOCK_EVT_MODE_SHUTDOWN, and falling
>>>>>> back to sharing the active kernel tick device + disabling PIC muting?
>>>>>
>>>>> OK. Another question is: do we want to move x86 timer handling from
>>>>> xenomai to ipipe. If not, we have to find a way to support the two
>>>>> possible configurations. What we could do is using the timer name in
>>>>> ipipe_request_tickdev: if a timer name is supplied, we keep the old
>>>>> implementation, if no timer name is supplied, we use the newho
>>>>> implementation which looks for the best candidate with the
>>>>> CLOCK_EVT_FEAT_IPIPE bit.
>>>>>
>>>>>
>>>>
>>>> Yes, makes sense. At any rate, handling the real-time timer the way we 
>>>> want for Xenomai directly from the pipeline is the only sane option. We 
>>>> only have to be careful about backward compatibility of the newest core 
>>>> pipelines with 2.6.x, until we stop maintaining this branch in favor of 
>>>> 3.x. We may also move ipipe_request_tckdev() to the compat module fully, 
>>>> removing it from the current API if that makes sense.
>>>>
>>>
>>> For those who would like to follow, the result, a bit different from what
>>> was originally planned is the interface implemented by this file:
>>> http://git.xenomai.org/?p=ipipe-gch.git;a=blob;f=kernel/ipipe/timer.c;h=b9936469652d8fe998157d155fda77df81f0425a;hb=52d36aa86d5c5d463d86d384ad717f26ec96ef8c
>>>
>>> And ARM and x86 architectures were re-factored over this interface. As 
>>> an example, the implementation of x86 timers is in this patch:
>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=52d36aa86d5c5d463d86d384ad717f26ec96ef8c;hp=675a8ed4365eb1f23b098f913caf40e4dc792b80
>>>
>>> 8254, local APIC and HPET in legacy mode were tested, even selected 
>>> at run-time. Only per-cpu HPET remains to be tested (the hardware 
>>> I have does not support it).
>>
>> FWI, QEMU (w/ or w/o KVM) can emulated enough HPET timers, also with MSI
>> support, but that was broken in I-pipe last time I checked. Use -global
>> hpet.timers=4 (or more for more CPUs) and -global hpet.msi=on.
> 
> Ah thanks. How was it broken? MSI were broken? As far as I understood
> MSI support for HPET are required for linux to select per-cpu HPET.

I-pipe was not aware of Linux using the HPET as per-CPU timersource. So
things fell apart once Linux switched. And, yes, there must be MSI
support to make Linux use them as per-CPU timers.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

