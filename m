Message-ID: <4CD5B9FC.6050602@domain.hid>
Date: Sat, 06 Nov 2010 21:26:36 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>	<4CD1E890.5010702@domain.hid>	<4CD1EC2F.4040603@domain.hid>	<4CD1ED16.8030103@domain.hid>	<4CD1EDA8.10007@domain.hid>	<4CD1F33C.5070208@domain.hid>	<4CD1F3F5.5080505@domain.hid>	<4CD1F4FE.9020908@domain.hid>	<4CD1F69B.9070100@domain.hid>	<4CD1F906.1070703@domain.hid>	<4CD1FABD.1080301@domain.hid>	<4CD2612C.2070507@domain.hid>	<4CD279F7.7070502@domain.hid>	<4CD27C46.8010302@domain.hid>	<4CD27DC2.7060607@domain.hid>	<4CD2A96B.3080001@domain.hid>	<4CD2B2A7.9010900@domain.hid>	<4CD2C50F.1090604@domain.hid>	<4CD32E76.3080004@domain.hid>
	<4CD33F0C.1050403@domain.hid>	<4CD340AA.60002@domain.hid>
	<4CD34355.5020304@domain.hid> <4CD35DC7.1000507@domain.hid>
	<4CD3DAC5.6000400@domain.hid> <4CD4A0EF.1@domain.hid>
In-Reply-To: <4CD4A0EF.1@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Anders Blomdell wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Am 05.11.2010 00:24, Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Am 04.11.2010 23:06, Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>>>> At first sight, here you are more breaking things than cleaning them.
>>>>>>>>> Still, it has the SMP record for my test program, still runs with ftrace 
>>>>>>>>> on (after 2 hours, where it previously failed after maximum 23 minutes).
>>>>>>>> My version was indeed still buggy, I'm reworking it ATM.
>>>>>>>>
>>>>>>>>> If I get the gist of Jan's changes, they are (using the IPI to transfer 
>>>>>>>>> one bit of information: your cpu needs to reschedule):
>>>>>>>>>
>>>>>>>>> xnsched_set_resched:
>>>>>>>>> -      setbits((__sched__)->status, XNRESCHED);
>>>>>>>>>
>>>>>>>>> xnpod_schedule_handler:
>>>>>>>>> +	xnsched_set_resched(sched);
>>>>>>>>> 	
>>>>>>>>> If you (we?) decide to keep the debug checks, under what circumstances 
>>>>>>>>> would the current check trigger (in laymans language, that I'll be able 
>>>>>>>>> to understand)?
>>>>>>>> That's actually what /me is wondering as well. I do not see yet how you
>>>>>>>> can reliably detect a missed reschedule reliably (that was the purpose
>>>>>>>> of the debug check) given the racy nature between signaling resched and
>>>>>>>> processing the resched hints.
>>>>>>> The purpose of the debugging change is to detect a change of the
>>>>>>> scheduler state which was not followed by setting the XNRESCHED bit.
>>>>>> But that is nucleus business, nothing skins can screw up (as long as
>>>>>> they do not misuse APIs).
>>>>> Yes, but it happens that we modify the nucleus from time to time.
>>>>>
>>>>>>> Getting it to work is relatively simple: we add a "scheduler change set
>>>>>>> remotely" bit to the sched structure which is NOT in the status bit, set
>>>>>>> this bit when changing a remote sched (under nklock). In the debug check
>>>>>>> code, if the scheduler state changed, and the XNRESCHED bit is not set,
>>>>>>> only consider this a but if this new bit is not set. All this is
>>>>>>> compiled out if the debug is not enabled.
>>>>>> I still see no benefit in this check. Where to you want to place the bit
>>>>>> set? Aren't that just the same locations where
>>>>>> xnsched_set_[self_]resched already is today?
>>>>> Well no, that would be another bit in the sched structure which would
>>>>> allow us to manipulate the status bits from the local cpu. That
>>>>> supplementary bit would only be changed from a distant CPU, and serve to
>>>>> detect the race which causes the false positive. The resched bits are
>>>>> set on the local cpu to get xnpod_schedule to trigger a rescheduling on
>>>>> the distance cpu. That bit would be set on the remote cpu's sched. Only
>>>>> when debugging is enabled.
>>>>>
>>>>>> But maybe you can provide some motivating bug scenarios, real ones of
>>>>>> the past or realistic ones of the future.
>>>>> Of course. The bug is anything which changes the scheduler state but
>>>>> does not set the XNRESCHED bit. This happened when we started the SMP
>>>>> port. New scheduling policies would be good candidates for a revival of
>>>>> this bug.
>>>>>
>>>> You don't gain any worthwhile check if you cannot make the
>>>> instrumentation required for a stable detection simpler than the proper
>>>> problem solution itself. And this is what I'm still skeptical of.
>>> The solution is simple, but finding the problem without the 
>>> instrumentation is way harder than with the instrumentation, so the 
>>> instrumentation is worth something.
>>>
>>> Reproducing the false positive is surprisingly easy with a simple
>>> dual-cpu semaphore ping-pong test. So, here is the (tested) patch, 
>>> using a ridiculous long variable name to illustrate what I was 
>>> thinking about:
>>>
>>> diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
>>> index 8888cf4..454b8e8 100644
>>> --- a/include/nucleus/sched.h
>>> +++ b/include/nucleus/sched.h
>>> @@ -108,6 +108,9 @@ typedef struct xnsched {
>>>         struct xnthread *gktarget;
>>>  #endif
>>>
>>> +#ifdef CONFIG_XENO_OPT_DEBUG_NUCLEUS
>>> +       int debug_resched_from_remote;
>>> +#endif
>>>  } xnsched_t;
>>>
>>>  union xnsched_policy_param;
>>> @@ -185,6 +188,8 @@ static inline int xnsched_resched_p(struct xnsched *sched)
>>>    xnsched_t *current_sched = xnpod_current_sched();                    \
>>>    __setbits(current_sched->status, XNRESCHED);                         \
>>>    if (current_sched != (__sched__))    {                               \
>>> +         if (XENO_DEBUG(NUCLEUS))                                      \
>>> +                 __sched__->debug_resched_from_remote = 1;             \
>>>        xnarch_cpu_set(xnsched_cpu(__sched__), current_sched->resched);  \
>>>    }                                                                    \
>>>  } while (0)
>>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
>>> index 4cb707a..50b0f49 100644
>>> --- a/ksrc/nucleus/pod.c
>>> +++ b/ksrc/nucleus/pod.c
>>> @@ -2177,6 +2177,10 @@ static inline int __xnpod_test_resched(struct xnsched *sched)
>>>                 xnarch_cpus_clear(sched->resched);
>>>         }
>>>  #endif
>>> +       if (XENO_DEBUG(NUCLEUS) && sched->debug_resched_from_remote) {
>>> +               sched->debug_resched_from_remote = 0;
>>> +               resched = 1;
>>> +       }
>>>         clrbits(sched->status, XNRESCHED);
>>>         return resched;
>>>  }
>>>
>>>
>>> I am still uncertain.
>> Will only work if all is done under nklock, otherwise two almost 
>> simultaneous xnsched_resched_p from different cpus, might lead to one of 
>> the ipi wakeups sees the 0 written due to handling the first ipi interrupt.
> 
> This is a patch artifact, the function modified are xnsched_set_resched
> and xnpod_test_resched, and both are run with the nklock locked.
> 

Isn't this a possible scenario?

CPU A			CPU B				CPU C
take nklock
remote = 1
send ipi #1
release nklock					
			take nklock			handle ipi
			remote = 1			ack ipi #1
			send ipi #2
			release nklock
							take nklock
							if remote (==1)
							  remote = 0
							  reseched = 1
							relese nklock
							handle ipi
							ack ipi #2
							take nklock
							if remote (==0)
							  OOPS!

/Anders

