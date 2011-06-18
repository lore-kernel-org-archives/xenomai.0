Message-ID: <4DFCBDD6.6020706@domain.hid>
Date: Sat, 18 Jun 2011 17:01:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>
	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>
	<4DFBA305.9000303@domain.hid> <4DFC7C0E.1090700@domain.hid>
	<4DFC9575.1030904@domain.hid> <4DFC95B7.8070703@domain.hid>
	<4DFCA09B.20609@domain.hid> <4DFCA323.6030704@domain.hid>
	<4DFCA432.3070203@domain.hid> <4DFCA54B.1040405@domain.hid>
	<4DFCAAEA.7010007@domain.hid> <4DFCAC8C.4050400@domain.hid>
	<4DFCAFBB.1040409@domain.hid> <4DFCB0E1.2040804@domain.hid>
In-Reply-To: <4DFCB0E1.2040804@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/18/2011 04:06 PM, Jan Kiszka wrote:
> On 2011-06-18 16:01, Gilles Chanteperdrix wrote:
>> On 06/18/2011 03:47 PM, Jan Kiszka wrote:
>>> On 2011-06-18 15:40, Gilles Chanteperdrix wrote:
>>>> On 06/18/2011 03:16 PM, Jan Kiszka wrote:
>>>>> On 2011-06-18 15:12, Gilles Chanteperdrix wrote:
>>>>>> On 06/18/2011 03:07 PM, Jan Kiszka wrote:
>>>>>>> On 2011-06-18 14:56, Gilles Chanteperdrix wrote:
>>>>>>>>
>>>>>>>> Maybe in the irq handlers, we should skip the XNHTICK replay, when
>>>>>>>> current_domain is root_domain.
>>>>>>>>
>>>>>>>
>>>>>>> That would be against the purpose of the XNTICK replay (it only targets
>>>>>>> that particular case). And it would still leave us with broken ipipe due
>>>>>>> to enabled IRQs on return from the Xenomai handlers.
>>>>>>
>>>>>> What I mean is that xnintr_clock_handler, we should skip the XNHTICK
>>>>>> replay when the current domain upon return from xnpod_schedule is not
>>>>>> root. From what I understand, this case only happens when xnpod_schedule
>>>>>> migrated the thread, and in that case, the tick will have been forwarded
>>>>>> during xnpod_schedule anyway.
>>>>>
>>>>> In the problematic case, ie. when the XNHTICK replay uses an invalid
>>>>> sched, the current domain is root. It must be root because only then the
>>>>> context could have been migrated to a different CPU by Linux. So this
>>>>> does not help to avoid having to reload sched.
>>>>
>>>> I mean replace:
>>>> 	if (testbits(sched->lflags, XNHTICK) &&
>>>> 	    xnthread_test_state(sched->curr, XNROOT))
>>>> 		xnintr_host_tick(sched);
>>>>
>>>> with
>>>> 	if (!xnarch_root_domain_p() &&
>>>> 	    testbits(sched->lflags, XNHTICK) &&
>>>> 	    xnthread_test_state(sched->curr, XNROOT))
>>>> 	    xnintr_host_tick(sched);
>>>>
>>>
>>> That breaks Linux timer ticks: If we are only running the root thread,
>>> where should the pending tick be replayed? It is always deferred, even
>>> over the root domain. And __xnpod_schedule, which could replay it as
>>> well, is only entered if there is rescheduling required.
>>
>> I may be wrong, but it is my understanding that Adeos switches domain 
>> before executing interrupt handlers, so that the current Adeos domain 
>> when running xnintr_clock_handler is always Xenomai, except at this 
>> point if we have migrated. For instance, see the following trace :
>>
>>  |   +func                -9296 __ipipe_grab_localtimer+0x10 (__irq_usr+0x3c)
>>  |   +func                -9295 __ipipe_grab_irq+0x10 (__ipipe_grab_localtimer+0x20)
>>  |   +func                -9295 __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0x88)
>>  |   +func                -9295 __ipipe_ack_localtimer+0x10 (__ipipe_handle_irq+0xc8)
>>  |   +func                -9294 __ipipe_dispatch_wired+0x10 (__ipipe_handle_irq+0xd4)
>>  |   +func                -9293 __ipipe_dispatch_wired_nocheck+0x14 (__ipipe_dispatch_wired+0x50)
>>  |  # func                -9293 xnintr_clock_handler+0x14 (__ipipe_dispatch_wired_nocheck+0x88)
>>
>> where we clearly see that the current domain is xenomai when executing
>> xntintr_clock_handler.
> 
> Yeah, that's true.
> 
>>
>> Anyway, reading ipipe_current_domain is probably as expensive as
>> reading xnpod_current_sched().
>>
> 
> And it would extend the common code path by another test.

I am not sure I understand the xnstat stuff, but is not the call to
xnstat_exectime_switch(sched, prev) signalling that the current thread
is running again (in primary mode)? So, I do not think we can call it
before xnpod_schedule or after when in root domain will do.

So, the simplest fix seems to add:

if (xnarch_root_domain_p())
	return;

right after the call to xnpod_schedule.

-- 
                                                                Gilles.

