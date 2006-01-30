Message-ID: <43DDE708.1000908@domain.hid>
Date: Mon, 30 Jan 2006 11:14:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid> <43DD545A.50809@domain.hid>
In-Reply-To: <43DD545A.50809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Hi,
>>
>> well, if I'm not totally wrong, we have a design problem in the
>> RT-thread hardening path. I dug into the crash Jeroen reported and I'm
>> quite sure that this is the reason.
>>
>> So that's the bad news. The good one is that we can at least work around
>> it by switching off CONFIG_PREEMPT for Linux (this implicitly means that
>> it's a 2.6-only issue).
>>
>> @Jeroen: Did you verify that your setup also works fine without
>> CONFIG_PREEMPT?
>>
>> But let's start with two assumptions my further analysis is based on:
>>
>> [Xenomai]
>>  o Shadow threads have only one stack, i.e. one context. If the
>>    real-time part is active (this includes it is blocked on some xnsynch
>>    object or delayed), the original Linux task must NEVER EVER be
>>    executed, even if it will immediately fall asleep again. That's
>>    because the stack is in use by the real-time part at that time. And
>>    this condition is checked in do_schedule_event() [1].
>>
>> [Linux]
>>  o A Linux task which has called set_current_state(<blocking_bit>) will
>>    remain in the run-queue as long as it calls schedule() on its own.
>>    This means that it can be preempted (if CONFIG_PREEMPT is set)
>>    between set_current_state() and schedule() and then even be resumed
>>    again. Only the explicit call of schedule() will trigger
>>    deactivate_task() which will in turn remove current from the
>>    run-queue.
>>
>> Ok, if this is true, let's have a look at xnshadow_harden(): After
>> grabbing the gatekeeper sem and putting itself in gk->thread, a task
>> going for RT then marks itself TASK_INTERRUPTIBLE and wakes up the
>> gatekeeper [2]. This does not include a Linux reschedule due to the
>> _sync version of wake_up_interruptible. What can happen now?
>>
>> 1) No interruption until we can called schedule() [3]. All fine as we
>> will not be removed from the run-queue before the gatekeeper starts
>> kicking our RT part, thus no conflict in using the thread's stack.
>>
>> 3) Interruption by a RT IRQ. This would just delay the path described
>> above, even if some RT threads get executed. Once they are finished, we
>> continue in xnshadow_harden() - given that the RT part does not trigger
>> the following case:
>>
>> 3) Interruption by some Linux IRQ. This may cause other threads to
>> become runnable as well, but the gatekeeper has the highest prio and
>> will therefore be the next. The problem is that the rescheduling on
>> Linux IRQ exit will PREEMPT our task in xnshadow_harden(), it will NOT
>> remove it from the Linux run-queue. And now we are in real troubles: The
>> gatekeeper will kick off our RT part which will take over the thread's
>> stack. As soon as the RT domain falls asleep and Linux takes over again,
>> it will continue our non-RT part as well! Actually, this seems to be the
>> reason for the panic in do_schedule_event(). Without
>> CONFIG_XENO_OPT_DEBUG and this check, we will run both parts AT THE SAME
>> TIME now, thus violating my first assumption. The system gets fatally
>> corrupted.
>>
> 
> Yep, that's it. And we may not lock out the interrupts before calling 
> schedule to prevent that.
> 
>> Well, I would be happy if someone can prove me wrong here.
>>
>> The problem is that I don't see a solution because Linux does not
>> provide an atomic wake-up + schedule-out under CONFIG_PREEMPT. I'm
>> currently considering a hack to remove the migrating Linux thread
>> manually from the run-queue, but this could easily break the Linux
>> scheduler.
>>
> 
> Maybe the best way would be to provide atomic wakeup-and-schedule 
> support into the Adeos patch for Linux tasks; previous attempts to fix 
> this by circumventing the potential for preemption from outside of the 
> scheduler code have all failed, and this bug is uselessly lingering for 
> that reason.

Having slept on this, I'm going to add a simple extension to the Linux scheduler 
available from Adeos, in order to get an atomic/unpreemptable path from the 
statement when the current task's state is changed for suspension (e.g. 
TASK_INTERRUPTIBLE), to the point where schedule() normally enters its atomic 
section, which looks like the sanest way to solve this issue, i.e. without gory 
hackery all over the place. Patch will follow later for testing this approach.

> 
>> Jan
>>
>>
>> PS: Out of curiosity I also checked RTAI's migration mechanism in this
>> regard. It's similar except for the fact that it does the gatekeeper's
>> work in the Linux scheduler's tail (i.e. after the next context switch).
>> And RTAI seems it suffers from the very same race. So this is either a
>> fundamental issue - or I'm fundamentally wrong.
>>
>>
>> [1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.c?v=SVN-trunk#L1573 
>>
>> [2]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.c?v=SVN-trunk#L461 
>>
>> [3]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.c?v=SVN-trunk#L481 
>>
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> 
> 
> 


-- 

Philippe.

