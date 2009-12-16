From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B28EF6D.5020405@domain.hid>
References: <4B240D0B.50603@domain.hid>
	<1260723757.2216.2.camel@domain.hid>
	<4B252909.9090304@domain.hid>
	<1260727502.2216.19.camel@domain.hid> <4B253028.10607@domain.hid>
	<1260962769.2216.203.camel@domain.hid>
	<4B28CA44.2080304@domain.hid>
	<1260973175.2216.371.camel@domain.hid>
	<4B28EF6D.5020405@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Dec 2009 15:41:40 +0100
Message-ID: <1260974500.2216.379.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [pull request] x86: critical fix for
 native_safe_halt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Wed, 2009-12-16 at 15:32 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2009-12-16 at 12:53 +0100, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Sun, 2009-12-13 at 19:19 +0100, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Sun, 2009-12-13 at 18:48 +0100, Jan Kiszka wrote:
> >>>>>> Philippe Gerum wrote:
> >>>>>>> On Sat, 2009-12-12 at 22:37 +0100, Jan Kiszka wrote:
> >>>>>>>> Recent moving of ipipe_suspend_domain finally exposed a deeper flaw in
> >>>>>>>> cpu_idle on x86: We failed to check the pipeline log before issuing the
> >>>>>>>> real hlt. This caused IRQ latencies or even drops for Linux,
> >>>>>>>> specifically on SMP. Credits go to plain QEMU whose slow SMP mode caused
> >>>>>>>> ipipe_critical_enter to deadlock frequently enough.
> >>>>>>>>
> >>>>>>>> The first patch of this series fixes this (see below), the second one
> >>>>>>>> simply removes the two useless ipipe_suspend_domain calls.
> >>>>>>>>
> >>>>>>> What your patch does as well, is killing the ability to run low priority
> >>>>>>> domains below the root level.
> >>>>>> Yes, I'm killing the dream.
> >>>>>>
> >>>>>> I heavily doubt that the functions I removed in the second patch ever
> >>>>>> contributed something good to this. It's always the job of the lowest
> >>>>>> domain to issue hardware halt, not of some arbitrary mid-prio domain.
> >>> Actually, no it's not. You may use a low-priority domain to run idle
> >>> level jobs outside of the linux infrastructure for that purpose (e.g.
> >>> RCU). A high priority domain may want to post events for a low priority
> >>> domain to act upon when a mid priority domain is about to enter the CPU
> >>> idle state.
> >> Even if all the related bugs were fixed: When you pass down control to
> >> the lower domain on cpu_idle via ipipe_suspend_domain, you won't get a
> >> Linux reschedule (without CONFIG_PREEMPT) until the low-prio domain
> >> finally returns from its event handler - likely not what "low-prio"
> >> suggests.
> > 
> > low prio suggests nothing else than "runs whenever nothing else has to
> > be done higher in the pipeline". I just don't get why you seem to bind
> > the Linux rescheduling logic with what a low prio domain would do; by
> > definition, adeos-wise, both are totally non-related.
> > 
> 
> I meant that a low prio domain is able to (indirectly) defer activities
> of a mig prio domain due to the way the latter passed on the control in
> its idle loop.

That is a deal between domains, we could do the same by preventing
Xenomai to reschedule before exiting the interrupt handler, the pipeline
imposes absolutely nothing there. What it says, and only that is:
interrupts must be prioritized. What interrupt handlers do, e.g.
rescheduling or not, is not the pipeline's business. This is another
level of abstraction/logic.

If for some reason, I want to allow such deferral because it helps me
debugging a misbehavior in some upper domain, I may do this. This is
really as simple as that. You have an extended interpretation of what
the pipeline should enforce, really. Albeit it is practically true most
of the time, it may be relaxed in some (rare) occasions, without killing
the entire design, or considering this as a bug. Your perception of
something being a bug could very well be seen as a feature by others.
That's life.

>  Think about my scenario again: where are the preemption
> points of on idle, !CONFIG_PREEMPT Linux kernel?
> 
> Jan
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



