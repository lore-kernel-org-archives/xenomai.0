Message-ID: <49395BE6.3080107@domain.hid>
Date: Fri, 05 Dec 2008 17:50:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493943B6.2040500@domain.hid> <493946AD.3040003@domain.hid>
	<4939599E.7090208@domain.hid>
In-Reply-To: <4939599E.7090208@domain.hid>
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
>>> Hi Gilles,
>>>
>>> here is a trivial test case on my desk that points to SCHED_RR issues of
>>> the POSIX skin: simple pthread_create with an attribute block that has
>>> SCHED_RR set, but neither SCHED_RR nor the priority reach the new thread.
>>>
>>> The way the scheduling policy and parameters get to that user space
>>> thread leads via __real_pthread_setschedparam after
>>> __pse51_thread_create. This triggers do_setsched_event in shadow.c. But
>>> here we filter out all policies except for SCHED_FIFO. So neither the
>>> priority nor the required XNRRB flag make it to the target therefore.
>>>
>>> Even worse, we are running aperiodic timer mode, so this would not have
>>> worked anyway due to the scheduler limitations. Fortunately, it turned
>>> out that the customer is fine with SCHED_FIFO as well, but the broken
>>> priorities and/or lacking error codes on creation are annoying + the
>>> fact that it likely wouldn't work even with periodic timer mode.
>> The fact that it does not work with aperiodic timer is documented.
>> However, this used to work and was tested with periodic timer (you can
>> find the tests under sim/skins/posix/testsuite), that is why there is no
>> reason to return any error code.
> 
> ...which is bogus IMHO.

What is bogus ? Not to return an error when something works ?

> Expecting to read the doc when something does
> not work as expected is ok. But more or less silently failing even if it
> is documented that it will somehow fail is not what Xenomai is usually
> known for.
> 
> That said, I still don't see (looking at TRUNK) how SCHED_RR should work
> even under periodic mode. Guess I have to enable and test it.

It would work if __wrap_pthread_create called
__wrap_pthread_setschedparam which would issue a syscall passing the
policy and priority to kernel-space. I am almost sure that it used to
work, but it may happen that recent changes regarding the way priority
is handled broke it.

> 
> But I guess the best we can do is to finally remove this limitation by
> allowing the use to create a periodic tick timer over aperiodic mode if
> there is a need for RR scheduling.

Yes, a very low priority change on the todo list. Someone needing this
in a real-world application would boost the priority.

-- 
                                                 Gilles.

