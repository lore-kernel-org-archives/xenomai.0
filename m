Message-ID: <4BD69F7D.9060006@domain.hid>
Date: Tue, 27 Apr 2010 10:25:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BD5987A.2050804@domain.hid>
	<4BD59A48.5070002@domain.hid>	<4BD5BA03.5000101@domain.hid>	<1272331158.28983.287.camel@domain.hid>	<4BD68843.4030806@domain.hid>
	<1272356029.28983.333.camel@domain.hid>
In-Reply-To: <1272356029.28983.333.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] nucleus: Plug race between
	rpi_clear_remote and rpi_next
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Tue, 2010-04-27 at 08:46 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Mon, 2010-04-26 at 18:06 +0200, Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm meditating over an oops in rpi_clear_remote. NULL pointer deref, it
>>>>>> /seems/ like thread->rpi is invalid. Looking at the code, I wonder if
>>>>>> this could explain the bug:
>>>>>>
>>>>>>
>>>>>> static void rpi_clear_remote(struct xnthread *thread)
>>>>>> {
>>>>>> ...
>>>>>>         rpi = thread->rpi;
>>>>>>         if (unlikely(rpi == NULL))
>>>>>>                 return;
>>>>>>
>>>>>>         xnlock_get_irqsave(&rpi->rpilock, s);
>>>>>>
>>>>>>         /*
>>>>>>          * The RPI slot - if present - is always valid, and won't
>>>>>>          * change since the thread is resuming on this CPU and cannot
>>>>>>          * migrate under our feet. We may grab the remote slot lock
>>>>>>          * now.
>>>>>>          */
>>>>>>         xnsched_pop_rpi(thread);
>>>>>>         thread->rpi = NULL;
>>>>>>
>>>>>> ...
>>>>>>
>>>>>> So we deref (xnsched_pop_rpi) and clear thread->rpi under rpilock, but
>>>>>> we check for it without any protection? Sounds racy. I think 'thread' is
>>>>>> not only pointing to the current thread but could refer to a foreign one
>>>>>> as well, right? Don't we need this:
>>>>>>
>>>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>>>>> index 872c37f..1f995d6 100644
>>>>>> --- a/ksrc/nucleus/shadow.c
>>>>>> +++ b/ksrc/nucleus/shadow.c
>>>>>> @@ -331,6 +331,12 @@ static void rpi_clear_remote(struct xnthread *thread)
>>>>>>  
>>>>>>  	xnlock_get_irqsave(&rpi->rpilock, s);
>>>>>>  
>>>>>> +	/* Re-check under lock, someone may have cleared rpi by now. */
>>>>>> +	if (unlikely(thread->rpi == NULL)) {
>>>>>> +		xnlock_put_irqrestore(&rpi->rpilock, s);
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>>  	/*
>>>>>>  	 * The RPI slot - if present - is always valid, and won't
>>>>>>  	 * change since the thread is resuming on this CPU and cannot
>>>>> Another worry: Can thread->rpi become != rpi without being NULL? Or can
>>>>> we really only race for clearance here?
>>>>>
>>>> I think so now, therefore I'm proposing this:
>>>>
>>>> ----------->
>>>>
>>>> Most RPI services work on the current task or the one to be scheduled in
>>>> next, thus are naturally serialized. But rpi_next is not as it can walk
>>>> the chain of RPI requests for a CPU independently. In that case,
>>>> clearing RPI via rpi_clear_remote can race with rpi_next, and if the
>>>> former loses after checking thread->rpi for NULL, we will dereference a
>>>> NULL pointer in xnsched_pop_rpi().
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>> ---
>>>>  ksrc/nucleus/shadow.c |    9 +++++++++
>>>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>>> index 872c37f..cf7c08f 100644
>>>> --- a/ksrc/nucleus/shadow.c
>>>> +++ b/ksrc/nucleus/shadow.c
>>>> @@ -332,6 +332,15 @@ static void rpi_clear_remote(struct xnthread *thread)
>>>>  	xnlock_get_irqsave(&rpi->rpilock, s);
>>>>  
>>>>  	/*
>>>> +	 * Re-check under lock. Someone may have invoked rpi_next and cleared
>>>> +	 * rpi by now.
>>>> +	 */
>>>> +	if (unlikely(!rpi_p(thread))) {
>>>> +		xnlock_put_irqrestore(&rpi->rpilock, s);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>>  	 * The RPI slot - if present - is always valid, and won't
>>>>  	 * change since the thread is resuming on this CPU and cannot
>>>>  	 * migrate under our feet. We may grab the remote slot lock
>>>>
>>> The suggested patch papers over the actual issue, which is that
>>> rpi_clear_remote() may not invoke rpi_next(), because it may only affect
>> I don't think that in our case rpi_clear_remote called rpi_next and
>> therefore crashed. It should rather have been the scenario of both
>> running in parallel on different CPUs, the former on behalf of a
>> migrated shadow that wants to clear its remainders on the remote CPU,
>> the latter on that CPU, picking a new top RPI after some other shadow
>> was removed from the queue. Is this a possible scenario, and would your
>> patch cover it?
>>
>>> the RPI state of the argument thread which must be a local one, and not
>>> that of any random thread that happens to be linked to the remote RPI
>>> queue.
>>>
>>> By calling rpi_next(), rpi_clear_remote() shoots itself in the foot,
>>> allowing a concurrent invocation of itself on a remote CPU, to fiddle
>>> with the rpi backlink of a thread which is not active on the
>>> local/per-cpu Xenomai scheduler instance, which is the point where
>>> things start to hit the crapper.
>>>
>>> Now, unless I can't even synchronize the couple of neurons I have left
>>> at this hour, the following patch should better fix the issue, because
>>> it restores the two basic rules that apply to the whole RPI machinery,
>>> namely:
>>>
>>> - rpi_* calls may only alter the contents of the local scheduler's RPI
>>> queue, with the notable exception of rpi_clear_remote() which may remove
>>> the given _local_ thread only, from a remote RPI slot.
>>>
>>> - rpi_* calls may only change the RPI state of threads which are
>>> controlled by the local Xenomai scheduler instance, except rpi_push()
>>> when called for setting up the RPI state of an emerging thread, in which
>>> case this is a no-conflict zone.
>>>
>>> That breakage was introduced in the early 2.5.1 timeframe, so 2.4.x
>>> should be immune from this particular bug.
>>>
>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>>> index 872c37f..1397ed1 100644
>>> --- a/ksrc/nucleus/shadow.c
>>> +++ b/ksrc/nucleus/shadow.c
>>> @@ -340,7 +340,12 @@ static void rpi_clear_remote(struct xnthread *thread)
>>>  	xnsched_pop_rpi(thread);
>>>  	thread->rpi = NULL;
>>>  
>>> -	if (rpi_next(rpi, s) == NULL)
>>> +	/*
>>> +	 * If the remote RPI queue was emptied, prepare for kicking
>>> +	 * xnshadow_rpi_check() on the relevant CPU to demote the root
>>> +	 * thread priority there.
>>> +	 */
>>> +	if (xnsched_peek_rpi(rpi) == NULL) /* No rpi_next() here. */
>>>  		rcpu = xnsched_cpu(rpi);
>>>  
>>>  	xnlock_put_irqrestore(&rpi->rpilock, s);
>>>
>>>
>> I have to confess, I do not understand how the patch may relate to our
>> crash. But that's because I still only have a semi-understanding of this
>> frightening complex RPI code. However, the fact that thread->rpi is now
>> again only checked outside its protecting lock leaves me with a very bad
>> feeling...
>>
> 
> My point is that we should not have to protect a section of code which
> may never conflict in any case, by design; we will likely agree that
> sprinkling locks everywhere to get a warm and fuzzy feeling is no
> solution, it's actually a significant source of regression.
> 
> The idea, behind keeping most rpi_* operations applicable to locally
> scheduled threads, is to introduce such a design, even when remote RPI
> slots are involved. thread->sched == xnpod_current_sched() for each
> rpi_*(sched, ...) calls is what is important in this logic. Another
> original assumption was that no RPI updates could be done in interrupt
> context, which is now wrong due to the change in xnshadow_rpi_check().
> 
> In short: we have to make sure that rpi_next() does not break the basic
> assumptions of the RPI core, first.

Please check my scenario again: My concern is that a thread can be
queued for a short while on a remote sched, and while that is the case,
it can be manipulated (/wrt ->rpi) _concurrently_ (as we do not hold the
remote rpilock all the time). I'm quite sure now that your patch does
not change this.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

