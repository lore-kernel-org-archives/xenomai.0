Message-ID: <4A267BBE.8010407@domain.hid>
Date: Wed, 03 Jun 2009 15:33:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20090603104015.13268.34073.stgit@domain.hid>
	<20090603104015.13268.59718.stgit@domain.hid>
	<4A267036.8010507@domain.hid> <4A267591.2060301@domain.hid>
	<4A267669.9030304@domain.hid>
In-Reply-To: <4A267669.9030304@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/3] RTDM: Instrument rtdm_lock_get for
 proper use
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> In case the user thinks rtdm_lock_get could be used like spin_lock or
>>>> messes up the IRQ protection for other reasons, catch this with a
>>>> XENO_BUGON.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>> ---
>>>>
>>>>  include/rtdm/rtdm_driver.h |    8 ++++++++
>>>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
>>>> index 058a9f8..fe42eea 100644
>>>> --- a/include/rtdm/rtdm_driver.h
>>>> +++ b/include/rtdm/rtdm_driver.h
>>>> @@ -655,7 +655,15 @@ typedef unsigned long rtdm_lockctx_t;
>>>>   *
>>>>   * Rescheduling: never.
>>>>   */
>>>> +#ifdef DOXYGEN_CPP /* Beautify doxygen output */
>>>>  #define rtdm_lock_get(lock)	rthal_spin_lock(lock)
>>>> +#else /* This is how it really works */
>>>> +#define rtdm_lock_get(lock)					\
>>>> +	do {							\
>>>> +		XENO_BUGON(RTDM, rthal_local_irq_test());	\
>>>> +		rthal_spin_lock(lock);				\
>>>> +	} while (0)
>>>> +#endif
>>> Why is it a problem to call rthal_spin_lock with irqs off?
>> Did I messed it up again? I meant it is a problem to call it with irqs
>> *on*. Checking what rthal_local_irq_test() actually means... Hmm, I
>> still think it's correct. Maybe we should rename rthal_local_irq_test to
>> rthal_local_irq_enabled to clarify the usage.
> 
> Ok. Got it. So, maybe, what you want is:
> 
> if (rthal_local_irq_test())
> 	xnpod_lock_sched();
> rthal_spin_lock
> 
> ?

That would be a semantical enhancement of rtdm_spin_lock/unlock, but I'm
not sure we want it. Because then you can run into bugs if the user
forgets to pick the irqsave version for task context when there is also
an IRQ context use of the same lock.

So far the semantic of rtdm_lock was very simple: cross-CPU protection
via spin lock, local preemption protection via IRQ lock. And that
pattern could easily be validated with the instrumentation I posted. And
so far no one asked for more. And finally: xnpod_lock/unlock_sched won't
be be cheaper than irqsave/restore as it involves a full nklock
acquisition - with irqsave/restore...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

