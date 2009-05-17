From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A0C182C.1060407@domain.hid>
References: <4A0AC1C8.4050006@domain.hid> <4A0AC3F9.9090103@domain.hid>
	<4A0AC8A6.1000701@domain.hid> <1242220962.26544.955.camel@domain.hid>
	<4A0AE726.5090107@domain.hid> <1242230121.26544.977.camel@domain.hid>
	<4A0AF109.5050804@domain.hid> <1242247840.26544.981.camel@domain.hid>
	<4A0BF054.3040308@domain.hid> <1242298157.6816.10.camel@domain.hid>
	<4A0C140C.9010808@domain.hid> <1242306020.6816.44.camel@domain.hid>
	<4A0C182C.1060407@domain.hid>
Content-Type: text/plain
Date: Sun, 17 May 2009 12:32:58 +0200
Message-Id: <1242556378.17138.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix host IRQ propagation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Thu, 2009-05-14 at 15:10 +0200, Gilles Chanteperdrix wrote: 
> Philippe Gerum wrote:
> > On Thu, 2009-05-14 at 14:52 +0200, Gilles Chanteperdrix wrote:
> >> Philippe Gerum wrote:
> >>> On Thu, 2009-05-14 at 12:20 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Wed, 2009-05-13 at 18:10 +0200, Jan Kiszka wrote:
> >>>>>> Philippe Gerum wrote:
> >>>>>>> On Wed, 2009-05-13 at 17:28 +0200, Jan Kiszka wrote:
> >>>>>>>> Philippe Gerum wrote:
> >>>>>>>>> On Wed, 2009-05-13 at 15:18 +0200, Jan Kiszka wrote:
> >>>>>>>>>> Gilles Chanteperdrix wrote:
> >>>>>>>>>>> Jan Kiszka wrote:
> >>>>>>>>>>>> Hi Gilles,
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm currently facing a nasty effect with switchtest over latest git head
> >>>>>>>>>>>> (only tested this so far): running it inside my test VM (ie. with
> >>>>>>>>>>>> frequent excessive latencies) I get a stalled Linux timer IRQ quite
> >>>>>>>>>>>> quickly. System is otherwise still responsive, Xenomai timers are still
> >>>>>>>>>>>> being delivered, other Linux IRQs too. switchtest complained about
> >>>>>>>>>>>>
> >>>>>>>>>>>>     "Warning: Linux is compiled to use FPU in kernel-space."
> >>>>>>>>>>>>
> >>>>>>>>>>>> when it was started. Kernels are 2.6.28.9/ipipe-x86-2.2-07 and
> >>>>>>>>>>>> 2.6.29.3/ipipe-x86-2.3-01 (LTTng patched in, but unused), both show the
> >>>>>>>>>>>> same effect.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Seen this before?
> >>>>>>>>>>> The warning about Linux being compiled to use FPU in kernel-space means
> >>>>>>>>>>> that you enabled soft RAID or compiled for K7, Geode, or any other
> >>>>>>>>>> RAID is on (ordinary server config).
> >>>>>>>>>>
> >>>>>>>>>>> configuration using 3DNow for such simple operations as memcpy. It is
> >>>>>>>>>>> harmless, it simply means that switchtest can not use fpu in kernel-space.
> >>>>>>>>>>>
> >>>>>>>>>>> The bug you have is probably the same as the one described here, which I
> >>>>>>>>>>> am able to reproduce on my atom:
> >>>>>>>>>>> https://mail.gna.org/public/xenomai-help/2009-04/msg00200.html
> >>>>>>>>>>>
> >>>>>>>>>>> Unfortunately, I for one am working on ARM issues and am not available
> >>>>>>>>>>> to debug x86 issues. I think Philippe is busy too...
> >>>>>>>>>> OK, looks like I got the same flu here.
> >>>>>>>>>>
> >>>>>>>>>> Philippe, did you find out any more details in the meantime? Then I'm
> >>>>>>>>>> afraid I have to pick this up.
> >>>>>>>>> No, I did not resume this task yet. Working from the powerpc side of the
> >>>>>>>>> universe here.
> >>>>>>>> Hoho, don't think this rain here over x86 would have never made it down
> >>>>>>>> to ARM or PPC land! ;)
> >>>>>>>>
> >>>>>>>> Martin, could you check if this helps you, too?
> >>>>>>>>
> >>>>>>>> Jan
> >>>>>>>>
> >>>>>>>> (as usual, ready to be pulled from 'for-upstream')
> >>>>>>>>
> >>>>>>>> --------->
> >>>>>>>>
> >>>>>>>> Host IRQs may not only be triggered from non-root domains.
> >>>>>>> Are you sure of this? I can't find any spot where this assumption would
> >>>>>>> be wrong. host_pend() is basically there to relay RT timer ticks and
> >>>>>>> device IRQs, and this only happens on behalf of the pipeline head. At
> >>>>>>> least, this is how rthal_irq_host_pend() should be used in any case. If
> >>>>>>> you did find a spot where this interface is being called from the lower
> >>>>>>> stage, then this is the root bug to fix.
> >>>>>> I haven't studied the I-pipe trace /wrt this in details yet, but I could
> >>>>>> imagine that some shadow task is interrupted in primary mode by the
> >>>>>> timer IRQ and then leaves the handler in secondary mode due to whatever
> >>>>>> events between schedule-out and in at the end of xnintr_clock_handler.
> >>>>>>
> >>>>> You need a thread context to move to secondary, I just can't see how
> >>>>> such scenario would be possible.
> >>>> Here is the trace of events:
> >>>>
> >>>> => Shadow task starts migration to secondary
> >>>> => in xnpod_suspend_thread, nklock is briefly released before
> >>>>    xnpod_schedule
> >>> Which is the root bug. Blame on me; this recent change in -head breaks a
> >>> basic rule a lot of code is based on: a self-suspending thread may not
> >>> be preempted while scheduling out, i.e. suspension and rescheduling must
> >>> be atomically performed. xnshadow_relax() counts on this too.
> >> Actually, I think the idea was mine in the first place... Maybe we can
> >> specify a special flag to xnpod_suspend_thread to ask fo the atomic
> >> suspension (maybe reuse XNATOMIC ?).
> >>
> > 
> > I don't think so. We really need the basic assumption to hold in any
> > case, because this is expected by most of the callers, and this
> > micro-optimization is not worth the risk of introducing a race if
> > misused.
> 
> Well, I tend to disagree. The assumption that the thread is suspended
> from the point of view of the scheduler still holds even when the nklock
> is released, and it is what callers like rt_cond_wait are expecting. The
> assumptions of xnshadow_relax do not seem to me like a common assumption.
> 

The assumption is that the thread has been suspended _and_ scheduled out
atomically, not only put in a suspended thread, which is quite different
when considered from an interrupt context. I'm worried by the fact that
re-enabling interrupts in the middle of this critical transition breaks
the unspoken rule that sched->curr may not be seen as bearing any block
bit in its status word from anywhere in the code executed from the local
CPU but xnpod_suspend_thread().

Another issue may arise in the SMP case, where xnpod_suspend_thread()
would block a thread running on a remote CPU; in theory, re-enabling
interrupts before the IPIs are sent from xnpod_schedule() - to kick the
remote resched procedure - may introduce an undefined delay due to local
interrupts being processed, albeit some runnable thread may be waiting
for the CPU to be released on the remote CPU. We would then end up with
a local scheduling artefact leaking remotely. I don't quite like this,
in fact.

Admittedly, we could plug each and every subtle hole we find like this
one, introducing XNATOMIC to fix the migration case as well, but my
point is that it may not be worth opening pandora's box just for that
micro-optimization.

> To go further, maybe forwarding the tick in xnintr_clock_handler
> epilogue is wrong in the first place, precisely because the current
> thread where xnintr_clock_handler happens may be scheduled out for a
> long time by the clock handler itself.
> 

It was mostly ok in the early days before RPI came in and with legacy
kernels, since the root thread would always be the last to be scheduled;
it is now wrong because:
- RPI may boost the root thread, so we could pend the timer IRQ long
after the root domain has regained control.
- Linux tickless timing requires that no tick is lost due to the current
IRQ context not returning from xnpod_schedule(), such as when calling
xnpod_delete_thread() on behalf of a kernel-based RT thread, previously
preempted by a timer IRQ. The same goes if xnpod_suspend_thread() is
called upon this thread as well.

So in short, yes, you are definitely right. We would be better off
moving this code close to the deferred tick handling instead, since we
know for sure that the root thread is about to be scheduled in at that
point. I just committed a fix for -head; this is a good candidate for a
backport to 2.4.x.

-- 
Philippe.



