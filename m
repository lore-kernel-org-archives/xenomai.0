Message-ID: <493AB601.8080205@domain.hid>
Date: Sat, 06 Dec 2008 18:27:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493943B6.2040500@domain.hid>
	<493946AD.3040003@domain.hid>	<4939599E.7090208@domain.hid>
	<49395CA5.1040409@domain.hid> <493967D3.6020805@domain.hid>
	<49396D91.8000101@domain.hid> <493A54B9.9010806@domain.hid>
In-Reply-To: <493A54B9.9010806@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] SCHED_RR
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Hi Gilles,
>>>>>>>
>>>>>>> here is a trivial test case on my desk that points to SCHED_RR issues of
>>>>>>> the POSIX skin: simple pthread_create with an attribute block that has
>>>>>>> SCHED_RR set, but neither SCHED_RR nor the priority reach the new thread.
>>>>>>>
>>>>>>> The way the scheduling policy and parameters get to that user space
>>>>>>> thread leads via __real_pthread_setschedparam after
>>>>>>> __pse51_thread_create. This triggers do_setsched_event in shadow.c. But
>>>>>>> here we filter out all policies except for SCHED_FIFO. So neither the
>>>>>>> priority nor the required XNRRB flag make it to the target therefore.
>>>>>>>
>>>>>>> Even worse, we are running aperiodic timer mode, so this would not have
>>>>>>> worked anyway due to the scheduler limitations. Fortunately, it turned
>>>>>>> out that the customer is fine with SCHED_FIFO as well, but the broken
>>>>>>> priorities and/or lacking error codes on creation are annoying + the
>>>>>>> fact that it likely wouldn't work even with periodic timer mode.
>>>>>> The fact that it does not work with aperiodic timer is documented.
>>>>>> However, this used to work and was tested with periodic timer (you can
>>>>>> find the tests under sim/skins/posix/testsuite), that is why there is no
>>>>>> reason to return any error code.
>>>>> ...which is bogus IMHO. Expecting to read the doc when something does
>>>>> not work as expected is ok. But more or less silently failing even if it
>>>>> is documented that it will somehow fail is not what Xenomai is usually
>>>>> known for.
>>>>>
>>>>> That said, I still don't see (looking at TRUNK) how SCHED_RR should work
>>>>> even under periodic mode. Guess I have to enable and test it.
>>>>>
>>>>> But I guess the best we can do is to finally remove this limitation by
>>>>> allowing the use to create a periodic tick timer over aperiodic mode if
>>>>> there is a need for RR scheduling.
>>>> In ksrc/skins/posix/syscall.c, function __pthread_create:
>>>>
>>>>         pthread_attr_init(&attr);
>>>>         attr.policy = p->policy;
>>>>         param.sched_priority = p->rt_priority;
>>>>         attr.detachstate = PTHREAD_CREATE_DETACHED;
>>>>
>>>> So, the priority and policy are taken from the underlying Linux thread.
>>> Yep, but its prio/policy is set *after* the chunk above. Maybe it is
>>> already a sufficient hot-fix to move __real_pthread_setschedparam before
>>> __pse51_thread_create if this has no unwanted side effects.
>> Useless. Since do_setsched_event ignores the priority change, everything
>> should work as expected.
>>
> 
> Don't get what you mean.
> 
> Anyway, that reordering doesn't work for shadow threads as they do not
> go through xnpod_start_thread from pthread_create, so the XNRRB is not
> applied this way.

That is the point I missed.

> 
> Thus the only fix to get SCHED_RR working again is to call
> __wrap_pthread_setschedparam (or some extract of it) from
> __pthread_trampoline, as you suggested. That works, but I cannot asses
> right now if it may have side effects.

Ok.

-- 
					    Gilles.

