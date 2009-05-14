From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A0BF9E4.4050800@domain.hid>
References: <4A0AC1C8.4050006@domain.hid> <4A0AC3F9.9090103@domain.hid>
	<4A0AC8A6.1000701@domain.hid> <1242220962.26544.955.camel@domain.hid>
	<4A0AE726.5090107@domain.hid> <1242230121.26544.977.camel@domain.hid>
	<4A0AF109.5050804@domain.hid> <1242247840.26544.981.camel@domain.hid>
	<4A0BF054.3040308@domain.hid> <1242298157.6816.10.camel@domain.hid>
	<4A0BF9E4.4050800@domain.hid>
Content-Type: text/plain
Date: Thu, 14 May 2009 13:10:01 +0200
Message-Id: <1242299401.6816.17.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2009-05-14 at 13:00 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2009-05-14 at 12:20 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Wed, 2009-05-13 at 18:10 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Wed, 2009-05-13 at 17:28 +0200, Jan Kiszka wrote:
> >>>>>> Philippe Gerum wrote:
> >>>>>>> On Wed, 2009-05-13 at 15:18 +0200, Jan Kiszka wrote:
> >>>>>>>> Gilles Chanteperdrix wrote:
> >>>>>>>>> Jan Kiszka wrote:
> >>>>>>>>>> Hi Gilles,
> >>>>>>>>>>
> >>>>>>>>>> I'm currently facing a nasty effect with switchtest over latest git head
> >>>>>>>>>> (only tested this so far): running it inside my test VM (ie. with
> >>>>>>>>>> frequent excessive latencies) I get a stalled Linux timer IRQ quite
> >>>>>>>>>> quickly. System is otherwise still responsive, Xenomai timers are still
> >>>>>>>>>> being delivered, other Linux IRQs too. switchtest complained about
> >>>>>>>>>>
> >>>>>>>>>>     "Warning: Linux is compiled to use FPU in kernel-space."
> >>>>>>>>>>
> >>>>>>>>>> when it was started. Kernels are 2.6.28.9/ipipe-x86-2.2-07 and
> >>>>>>>>>> 2.6.29.3/ipipe-x86-2.3-01 (LTTng patched in, but unused), both show the
> >>>>>>>>>> same effect.
> >>>>>>>>>>
> >>>>>>>>>> Seen this before?
> >>>>>>>>> The warning about Linux being compiled to use FPU in kernel-space means
> >>>>>>>>> that you enabled soft RAID or compiled for K7, Geode, or any other
> >>>>>>>> RAID is on (ordinary server config).
> >>>>>>>>
> >>>>>>>>> configuration using 3DNow for such simple operations as memcpy. It is
> >>>>>>>>> harmless, it simply means that switchtest can not use fpu in kernel-space.
> >>>>>>>>>
> >>>>>>>>> The bug you have is probably the same as the one described here, which I
> >>>>>>>>> am able to reproduce on my atom:
> >>>>>>>>> https://mail.gna.org/public/xenomai-help/2009-04/msg00200.html
> >>>>>>>>>
> >>>>>>>>> Unfortunately, I for one am working on ARM issues and am not available
> >>>>>>>>> to debug x86 issues. I think Philippe is busy too...
> >>>>>>>> OK, looks like I got the same flu here.
> >>>>>>>>
> >>>>>>>> Philippe, did you find out any more details in the meantime? Then I'm
> >>>>>>>> afraid I have to pick this up.
> >>>>>>> No, I did not resume this task yet. Working from the powerpc side of the
> >>>>>>> universe here.
> >>>>>> Hoho, don't think this rain here over x86 would have never made it down
> >>>>>> to ARM or PPC land! ;)
> >>>>>>
> >>>>>> Martin, could you check if this helps you, too?
> >>>>>>
> >>>>>> Jan
> >>>>>>
> >>>>>> (as usual, ready to be pulled from 'for-upstream')
> >>>>>>
> >>>>>> --------->
> >>>>>>
> >>>>>> Host IRQs may not only be triggered from non-root domains.
> >>>>> Are you sure of this? I can't find any spot where this assumption would
> >>>>> be wrong. host_pend() is basically there to relay RT timer ticks and
> >>>>> device IRQs, and this only happens on behalf of the pipeline head. At
> >>>>> least, this is how rthal_irq_host_pend() should be used in any case. If
> >>>>> you did find a spot where this interface is being called from the lower
> >>>>> stage, then this is the root bug to fix.
> >>>> I haven't studied the I-pipe trace /wrt this in details yet, but I could
> >>>> imagine that some shadow task is interrupted in primary mode by the
> >>>> timer IRQ and then leaves the handler in secondary mode due to whatever
> >>>> events between schedule-out and in at the end of xnintr_clock_handler.
> >>>>
> >>> You need a thread context to move to secondary, I just can't see how
> >>> such scenario would be possible.
> >> Here is the trace of events:
> >>
> >> => Shadow task starts migration to secondary
> >> => in xnpod_suspend_thread, nklock is briefly released before
> >>    xnpod_schedule
> > 
> > Which is the root bug. Blame on me; this recent change in -head breaks a
> > basic rule a lot of code is based on: a self-suspending thread may not
> > be preempted while scheduling out, i.e. suspension and rescheduling must
> > be atomically performed. xnshadow_relax() counts on this too.
> 
> Oh, good that you insisted on this. Will you fix it soon? We are
> currently packaging a delivery of 2.5.git, and I would like to see this
> hole closed there already.
> 

I just pushed a fix for this.

> > 
> >> => timer IRQ intercepts
> >> => as the current CPU is marked for reschedule, we enter xnpod_schedule
> >>    before propagating the host tick
> >> => once the migrating thread comes in again, it will run the
> >>    xnintr_clock_handler tail, i.e. xnarch_relay_tick, already over the
> >>    root domain
> > 
> > Ok, makes sense now. However, this can't happen with 2.4 which has no
> > such lock release in xnpod_suspend_thread(). So the question is: was the
> > "lost tick" bug observed also on 2.4, or not?
> 
> I haven't tested on 2.4, but Martin anyway reported that his problem is
> still unfixed for 2.5 even with my patch.
> 
> Jan
> 
-- 
Philippe.



