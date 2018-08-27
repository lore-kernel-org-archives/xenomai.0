Date: Mon, 27 Aug 2018 19:44:52 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180827194452.49fc89bf@md1pvb1c.ad001.siemens.net>
In-Reply-To: <5e05ff77-579d-8dc2-d1a8-d645952f815d@xenomai.org>
References: <9807836c-9287-10a7-52bf-6b5947c87699@xenomai.org>
 <20180827132432.215475e3@md1pvb1c.ad001.siemens.net>
 <5e05ff77-579d-8dc2-d1a8-d645952f815d@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe split series
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, Dmitriy Cherkasov <dmitriy@oss-tech.org>, "Seeger,
 Steven D. (GSFC-444.0)[Embedded Flight Systems, Inc]" <steven.seeger@nasa.gov>, "Kiszka, Jan" <jan.kiszka@siemens.com>

Am Mon, 27 Aug 2018 16:15:21 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 08/27/2018 01:24 PM, Henning Schild wrote:
> > Hi Philippe,
> > 
> > Am Mon, 30 Jul 2018 20:10:17 +0200
> > schrieb Philippe Gerum <rpm@xenomai.org>:
> >   
> >> The generic I-pipe code is now available as a series of incremental
> >> commits at [1] on top of the 4.14.58 kernel. This allows to port
> >> the I-pipe patch gradually, first to enable IRQ pipelining per se,
> >> then add the bits required for co-managing tasks between the
> >> regular kernel and the co-kernel, which builds on the former. Most
> >> patches have gained a description in their respective short log,
> >> which added to Documentation/ipipe.rst, should help clarifying the
> >> process of porting the pipeline.
> >>
> >> While I was at it, I did a pre-port of the x86 patch to kernel
> >> 4.14.58, which has been useful for validating the split series. I
> >> hope this will help the x86 maintainers to clear that hurdle
> >> eventually.
> >>
> >> The whole pile of patches went through countless incremental builds
> >> over multiple configurations, and tedious manual fixups over a few
> >> weeks. However, there is room for issues, given the amount of code
> >> involved, and the varying configurations one can apply. If you find
> >> any problem with that split series, please report them here so that
> >> we fix them.
> >>
> >> Please note that those trees are rebased from time to time.  
> > 
> > Really cool! Thanks so much for your work, i quickly looked at the
> > structure of the patches and the commit messages. I think that
> > should greatly improve the documentation and we will see how well
> > that works for the next rebase. But i hope and assume that will
> > become much easier with this approach.
> >   
> >> == Generic changes
> >>
> >> - select HAVE_IPIPE_SUPPORT is needed from the arch-code (Kconfig)
> >> to enable the generic I-pipe bits. This way we can have an
> >> incremental build, without requiring the arch-code to be present
> >> in the commit stack for testing generic changes.
> >>
> >> - Likewise, select HAVE_IPIPE_TRACER_SUPPORT is needed from the
> >> arch-code when the tracer is available. Only ARM needs this
> >> currently, due to the TSC emulation support we need to provide
> >> there to get timestamps which is not part of the ARM-specific
> >> pipeline core. x86 and ppc32 have their own tsc/timebase readily
> >> available when the core bits are in.
> >>
> >> - __ipipe_init_threadflags() now receives struct thread_info *. To
> >> be updated in the arch-specific bits.
> >>
> >> == x86
> >>
> >> The basic port available at [2] boots over KVM and a couple of real
> >> hw I have here, x86_64 only, x86_32 is untested and likely not
> >> complete - although little should be left. It enables the interrupt
> >> pipeline, but has not been checked against Xenomai, since FPU
> >> support is not there (*).  
> > 
> > I have got a working eager-fpu 4.4 and 4.9 and looked into this
> > 4.14 as well, in the hope to get the patch against xenomai in a
> > shape that will work for all three kernels.
> > 
> > So i ported my kernel patch to this 4.14 and adjusted xenomai to
> > work on that as well. Unfortunately the kernel does not boot. It
> > gets stuck right after switching the clocksource to tsc. My current
> > assumption is that the timer does not work, maybe interrupts in
> > general.
> > 
> > Do you have a suggestion how to best debug that? I could also share
> > the current state of the fpu-patches so you could have a direct
> > look at it yourself.  
> 
> I recently wrote a (short) piece about identifying and chasing those
> issues:
> 
> https://dovetail.xenomai.org/pipeline/porting/devnotes/#losing-the-timer-tick

Yes, that description sounds about right. I am still digging to see why
_no_ interrupts seem to be arriving.

But i imagine you are looking forward to seeing the 4.14 split series
in action as well and might want to have a look as well. Here is what i
am currently working with, fpu should work ... once we are up.

https://github.com/henning-schild-work/linux-ipipe/tree/henning/fpu/4.14
https://github.com/henning-schild-work/xenomai/tree/henning/fpu

Henning

> This doc applies to Dovetail which unlike the I-pipe provides a
> full-fledged proxy tick device as a regular clockevent object, but the
> basics remain mostly the same.
> 
> Note: you may want to add another potential issue to the list given in
> this document, which is a wrong clocksource to hw timer tick
> conversion leading ipipe_timer_set() to program the timer hardware in
> a bad way (cdelay holds a delay expressed in clocksource tick unit,
> tdelay is the conversion of that input to timer ticks, you would
> write to, e.g. the decrementer register). This can't happen with
> Dovetail which directly works from a count of nanoseconds and
> therefore does not need such conversion, but could with the I-pipe.
> 


