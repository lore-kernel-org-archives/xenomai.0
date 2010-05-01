From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BD6BF21.20303@domain.hid>
References: <4BD5987A.2050804@domain.hid> <4BD59A48.5070002@domain.hid>
	<4BD5BA03.5000101@domain.hid>
	<1272331158.28983.287.camel@domain.hid>
	<4BD68843.4030806@domain.hid>
	<1272356029.28983.333.camel@domain.hid>
	<4BD69F7D.9060006@domain.hid>
	<1272359559.28983.380.camel@domain.hid>
	<4BD6AE1E.6050704@domain.hid>
	<1272360740.28983.382.camel@domain.hid>
	<4BD6AFC2.1090300@domain.hid>
	<1272361898.28983.395.camel@domain.hid>
	<4BD6BF21.20303@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 01 May 2010 19:26:06 +0200
Message-ID: <1272734766.2440.46.camel@domain.hid>
Mime-Version: 1.0
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2010-04-27 at 12:40 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2010-04-27 at 11:34 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Tue, 2010-04-27 at 11:27 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Tue, 2010-04-27 at 10:25 +0200, Jan Kiszka wrote:
> >>>>>> Philippe Gerum wrote:
> >>>>>>> On Tue, 2010-04-27 at 08:46 +0200, Jan Kiszka wrote:
> >>>>>>>> Philippe Gerum wrote:
> >>>>>>>>> On Mon, 2010-04-26 at 18:06 +0200, Jan Kiszka wrote:
> >>>>>>>>>> Jan Kiszka wrote:
> >>>>>>>>>>> Jan Kiszka wrote:
> >>>>>>>>>>>> Hi,
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm meditating over an oops in rpi_clear_remote. NULL pointer deref, it
> >>>>>>>>>>>> /seems/ like thread->rpi is invalid. Looking at the code, I wonder if
> >>>>>>>>>>>> this could explain the bug:
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> static void rpi_clear_remote(struct xnthread *thread)
> >>>>>>>>>>>> {
> >>>>>>>>>>>> ...
> >>>>>>>>>>>>         rpi = thread->rpi;
> >>>>>>>>>>>>         if (unlikely(rpi == NULL))
> >>>>>>>>>>>>                 return;
> >>>>>>>>>>>>
> >>>>>>>>>>>>         xnlock_get_irqsave(&rpi->rpilock, s);
> >>>>>>>>>>>>
> >>>>>>>>>>>>         /*
> >>>>>>>>>>>>          * The RPI slot - if present - is always valid, and won't
> >>>>>>>>>>>>          * change since the thread is resuming on this CPU and cannot
> >>>>>>>>>>>>          * migrate under our feet. We may grab the remote slot lock
> >>>>>>>>>>>>          * now.
> >>>>>>>>>>>>          */
> >>>>>>>>>>>>         xnsched_pop_rpi(thread);
> >>>>>>>>>>>>         thread->rpi = NULL;
> >>>>>>>>>>>>
> >>>>>>>>>>>> ...
> >>>>>>>>>>>>
> >>>>>>>>>>>> So we deref (xnsched_pop_rpi) and clear thread->rpi under rpilock, but
> >>>>>>>>>>>> we check for it without any protection? Sounds racy. I think 'thread' is
> >>>>>>>>>>>> not only pointing to the current thread but could refer to a foreign one
> >>>>>>>>>>>> as well, right? Don't we need this:
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> >>>>>>>>>>>> index 872c37f..1f995d6 100644
> >>>>>>>>>>>> --- a/ksrc/nucleus/shadow.c
> >>>>>>>>>>>> +++ b/ksrc/nucleus/shadow.c
> >>>>>>>>>>>> @@ -331,6 +331,12 @@ static void rpi_clear_remote(struct xnthread *thread)
> >>>>>>>>>>>>  
> >>>>>>>>>>>>  	xnlock_get_irqsave(&rpi->rpilock, s);
> >>>>>>>>>>>>  
> >>>>>>>>>>>> +	/* Re-check under lock, someone may have cleared rpi by now. */
> >>>>>>>>>>>> +	if (unlikely(thread->rpi == NULL)) {
> >>>>>>>>>>>> +		xnlock_put_irqrestore(&rpi->rpilock, s);
> >>>>>>>>>>>> +		return;
> >>>>>>>>>>>> +	}
> >>>>>>>>>>>> +
> >>>>>>>>>>>>  	/*
> >>>>>>>>>>>>  	 * The RPI slot - if present - is always valid, and won't
> >>>>>>>>>>>>  	 * change since the thread is resuming on this CPU and cannot
> >>>>>>>>>>> Another worry: Can thread->rpi become != rpi without being NULL? Or can
> >>>>>>>>>>> we really only race for clearance here?
> >>>>>>>>>>>
> >>>>>>>>>> I think so now, therefore I'm proposing this:
> >>>>>>>>>>
> >>>>>>>>>> ----------->
> >>>>>>>>>>
> >>>>>>>>>> Most RPI services work on the current task or the one to be scheduled in
> >>>>>>>>>> next, thus are naturally serialized. But rpi_next is not as it can walk
> >>>>>>>>>> the chain of RPI requests for a CPU independently. In that case,
> >>>>>>>>>> clearing RPI via rpi_clear_remote can race with rpi_next, and if the
> >>>>>>>>>> former loses after checking thread->rpi for NULL, we will dereference a
> >>>>>>>>>> NULL pointer in xnsched_pop_rpi().
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> >>>>>>>>>> ---
> >>>>>>>>>>  ksrc/nucleus/shadow.c |    9 +++++++++
> >>>>>>>>>>  1 files changed, 9 insertions(+), 0 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> >>>>>>>>>> index 872c37f..cf7c08f 100644
> >>>>>>>>>> --- a/ksrc/nucleus/shadow.c
> >>>>>>>>>> +++ b/ksrc/nucleus/shadow.c
> >>>>>>>>>> @@ -332,6 +332,15 @@ static void rpi_clear_remote(struct xnthread *thread)
> >>>>>>>>>>  	xnlock_get_irqsave(&rpi->rpilock, s);
> >>>>>>>>>>  
> >>>>>>>>>>  	/*
> >>>>>>>>>> +	 * Re-check under lock. Someone may have invoked rpi_next and cleared
> >>>>>>>>>> +	 * rpi by now.
> >>>>>>>>>> +	 */
> >>>>>>>>>> +	if (unlikely(!rpi_p(thread))) {
> >>>>>>>>>> +		xnlock_put_irqrestore(&rpi->rpilock, s);
> >>>>>>>>>> +		return;
> >>>>>>>>>> +	}
> >>>>>>>>>> +
> >>>>>>>>>> +	/*
> >>>>>>>>>>  	 * The RPI slot - if present - is always valid, and won't
> >>>>>>>>>>  	 * change since the thread is resuming on this CPU and cannot
> >>>>>>>>>>  	 * migrate under our feet. We may grab the remote slot lock
> >>>>>>>>>>
> >>>>>>>>> The suggested patch papers over the actual issue, which is that
> >>>>>>>>> rpi_clear_remote() may not invoke rpi_next(), because it may only affect
> >>>>>>>> I don't think that in our case rpi_clear_remote called rpi_next and
> >>>>>>>> therefore crashed. It should rather have been the scenario of both
> >>>>>>>> running in parallel on different CPUs, the former on behalf of a
> >>>>>>>> migrated shadow that wants to clear its remainders on the remote CPU,
> >>>>>>>> the latter on that CPU, picking a new top RPI after some other shadow
> >>>>>>>> was removed from the queue. Is this a possible scenario, and would your
> >>>>>>>> patch cover it?
> >>>>>>>>
> >>>>>>>>> the RPI state of the argument thread which must be a local one, and not
> >>>>>>>>> that of any random thread that happens to be linked to the remote RPI
> >>>>>>>>> queue.
> >>>>>>>>>
> >>>>>>>>> By calling rpi_next(), rpi_clear_remote() shoots itself in the foot,
> >>>>>>>>> allowing a concurrent invocation of itself on a remote CPU, to fiddle
> >>>>>>>>> with the rpi backlink of a thread which is not active on the
> >>>>>>>>> local/per-cpu Xenomai scheduler instance, which is the point where
> >>>>>>>>> things start to hit the crapper.
> >>>>>>>>>
> >>>>>>>>> Now, unless I can't even synchronize the couple of neurons I have left
> >>>>>>>>> at this hour, the following patch should better fix the issue, because
> >>>>>>>>> it restores the two basic rules that apply to the whole RPI machinery,
> >>>>>>>>> namely:
> >>>>>>>>>
> >>>>>>>>> - rpi_* calls may only alter the contents of the local scheduler's RPI
> >>>>>>>>> queue, with the notable exception of rpi_clear_remote() which may remove
> >>>>>>>>> the given _local_ thread only, from a remote RPI slot.
> >>>>>>>>>
> >>>>>>>>> - rpi_* calls may only change the RPI state of threads which are
> >>>>>>>>> controlled by the local Xenomai scheduler instance, except rpi_push()
> >>>>>>>>> when called for setting up the RPI state of an emerging thread, in which
> >>>>>>>>> case this is a no-conflict zone.
> >>>>>>>>>
> >>>>>>>>> That breakage was introduced in the early 2.5.1 timeframe, so 2.4.x
> >>>>>>>>> should be immune from this particular bug.
> >>>>>>>>>
> >>>>>>>>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> >>>>>>>>> index 872c37f..1397ed1 100644
> >>>>>>>>> --- a/ksrc/nucleus/shadow.c
> >>>>>>>>> +++ b/ksrc/nucleus/shadow.c
> >>>>>>>>> @@ -340,7 +340,12 @@ static void rpi_clear_remote(struct xnthread *thread)
> >>>>>>>>>  	xnsched_pop_rpi(thread);
> >>>>>>>>>  	thread->rpi = NULL;
> >>>>>>>>>  
> >>>>>>>>> -	if (rpi_next(rpi, s) == NULL)
> >>>>>>>>> +	/*
> >>>>>>>>> +	 * If the remote RPI queue was emptied, prepare for kicking
> >>>>>>>>> +	 * xnshadow_rpi_check() on the relevant CPU to demote the root
> >>>>>>>>> +	 * thread priority there.
> >>>>>>>>> +	 */
> >>>>>>>>> +	if (xnsched_peek_rpi(rpi) == NULL) /* No rpi_next() here. */
> >>>>>>>>>  		rcpu = xnsched_cpu(rpi);
> >>>>>>>>>  
> >>>>>>>>>  	xnlock_put_irqrestore(&rpi->rpilock, s);
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>> I have to confess, I do not understand how the patch may relate to our
> >>>>>>>> crash. But that's because I still only have a semi-understanding of this
> >>>>>>>> frightening complex RPI code. However, the fact that thread->rpi is now
> >>>>>>>> again only checked outside its protecting lock leaves me with a very bad
> >>>>>>>> feeling...
> >>>>>>>>
> >>>>>>> My point is that we should not have to protect a section of code which
> >>>>>>> may never conflict in any case, by design; we will likely agree that
> >>>>>>> sprinkling locks everywhere to get a warm and fuzzy feeling is no
> >>>>>>> solution, it's actually a significant source of regression.
> >>>>>>>
> >>>>>>> The idea, behind keeping most rpi_* operations applicable to locally
> >>>>>>> scheduled threads, is to introduce such a design, even when remote RPI
> >>>>>>> slots are involved. thread->sched == xnpod_current_sched() for each
> >>>>>>> rpi_*(sched, ...) calls is what is important in this logic. Another
> >>>>>>> original assumption was that no RPI updates could be done in interrupt
> >>>>>>> context, which is now wrong due to the change in xnshadow_rpi_check().
> >>>>>>>
> >>>>>>> In short: we have to make sure that rpi_next() does not break the basic
> >>>>>>> assumptions of the RPI core, first.
> >>>>>> Please check my scenario again: My concern is that a thread can be
> >>>>>> queued for a short while on a remote sched,
> >>>>> No, it can't, that is the crux of the matter, well, at least, this
> >>>>> should not be possible if the basic assumptions are preserved (have a
> >>>>> look at the rpi_clear_remote() callers, the target thread may not
> >>>>> migrate or be scheduled in linux-wise, or exit RPI via rpi_pop() during
> >>>>> the call -- all places where the rpi backlink may be cleared). Only a
> >>>>> caller operating from the local CPU should be allowed to alter the RPI
> >>>>> state of threads linked to the RPI slot of that same CPU.
> >>>>>
> >>>>> rpi_clear_remote() is not even an exception to this, since it alters a
> >>>>> remote RPI slot, but for a thread which does run on the local CPU.
> >>>>>
> >>>>>>  and while that is the case,
> >>>>>> it can be manipulated (/wrt ->rpi) _concurrently_ (as we do not hold the
> >>>>>> remote rpilock all the time). I'm quite sure now that your patch does
> >>>>>> not change this.
> >>>>> My patch attempts fixing the core issue, not just plugging one of its
> >>>>> bad outcomes.
> >>>>>
> >>>>> Again, the point is not to pretend that your patch is wrong, and it
> >>>>> surely "plugs" one issue we have due to rpi_next(). The point is to make
> >>>>> sure that all issues are covered, by fixing the usage of rpi_next(), or
> >>>>> find another way to fix what rpi_next() was supposed to fix in the first
> >>>>> place.
> >>>> So, if you are right, we could (in theory) replace rpilock with local
> >>>> IRQ disabling? That would be the proof from me that it doesn't matter to
> >>>> test thread->rpi outside the lock.
> >>> Noo, you did not get it yet. The rpilock is protecting the per-cpu RPI
> >>> queues, NOT thread->rpi. 
> >> So linking a thread to an RPI queue and setting its ->rpi are not always
> >> related?
> > 
> > Exactly. Normally, a remote CPU should not be allowed to compete with
> > another one for updating the rpi backlink of a thread it does NOT own,
> > meaning not linked to the local scheduler. 
> > 
> > My understanding is that rpi_next() is deliberately breaking that rule
> > when called from rpi_clear_remote() for a non-local scheduler, therefore
> > altering rpi backlinks of threads which do NOT belong to the local
> > scheduler.
> 
> Just dug out the backtrace again: Where we saw the crash was (likely -
> lots of inline functions) in the chain schedule_event -> rpi_switch ->
> rpi_migrate -> rpi_clear_remote. To my understanding, this clear takes
> place on the CPU that is the target of the just migrated Linux task. At
> that point, isn't the task's shadow no longer linked to the original
> CPU's RPI queue? And if that remote CPU now calls rpi_next e.g. via
> rpi_pop, doesn't that step cause a clearance as well, thus races with
> the one we started via rpi_migrate?
> 
> Even if I'm wrong on the above, the conditions for manipulating
> thread->rpi should be documented or even checked (i.e. when setting
> thread->rpi, thread->sched must equal the local sched - right?).
> 
> > 
> > Who is wrong then? Well, I tend to think that rpi_next() should not be
> > called in the only cross-CPU context we have, namely rpi_clear_remote().
> > In that very particular case, where we own the target thread, and we
> > want to complete its recent migration to our local CPU.
> > 
> > This is why I was insisting on the notion of calling context for all
> > rpi* calls, with respect to what threads may be touched by a given CPU. 
> > 
> > But, I am now worried by xnshadow_rpi_check(), which - by calling
> > rpi_next() instead of simply peeking at the RPI queue head - introduces
> > a potential race wrt the rpi backlink, when we deal with
> > rpi_clear_remote() on the _same_ CPU.
> 
> OK, then we have at least one reason to not trust thread->rpi unless we
> hold rpilock. That's my whole point.
> 
> BTW, the pattern I suggested is a fairly common one in the kernel due to
> all its complex (because fine-grained) locking. And that I thought I had
> to introduce raised my worries about RPI locking noticeably. :-/

Don't you think that, quoting yourself:

"I have to confess, I do not understand how the patch may relate to our
crash. But that's because I still only have a semi-understanding of this
frightening complex RPI code"

does not fit that well with any kind of strong assertion made later on
the same topic, not backed by facts?

So, I'm suggesting that we move on, and end this discussion in a
positive manner, i.e. by fixing this code. I hear your concerns, like I
always do, and I'm trying to find a solution that does not paper over
another issue. I guess we should be able to settle on this.

I pushed two patches in my for-upstream queue, with lengthy comments to
explain what they do and why this is needed:

http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=ac5c739dabcb14334c2e390a9e3064f11f97283c
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=d3242401b8e1cf2c28822f801b681194243b4394

- the first patch is a plain revert of the commit introducing
rpi_next(), which caused the bug you observed in SMP mode, and that your
patch plugged successfully.

- the second patch is the proper fix for the issue rpi_next() tried to
address.

Could you please try them, and report whether this also fixes the issue
for you? In the meantime, I will be analyzing the RPI code once again,
to check whether your patch still covers a possible case, or not.

TIA,

-- 
Philippe.



