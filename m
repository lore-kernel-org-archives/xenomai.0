Date: Mon, 27 Aug 2018 13:24:32 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180827132432.215475e3@md1pvb1c.ad001.siemens.net>
In-Reply-To: <9807836c-9287-10a7-52bf-6b5947c87699@xenomai.org>
References: <9807836c-9287-10a7-52bf-6b5947c87699@xenomai.org>
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

Hi Philippe,

Am Mon, 30 Jul 2018 20:10:17 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> The generic I-pipe code is now available as a series of incremental
> commits at [1] on top of the 4.14.58 kernel. This allows to port the
> I-pipe patch gradually, first to enable IRQ pipelining per se, then
> add the bits required for co-managing tasks between the regular
> kernel and the co-kernel, which builds on the former. Most patches
> have gained a description in their respective short log, which added
> to Documentation/ipipe.rst, should help clarifying the process of
> porting the pipeline.
> 
> While I was at it, I did a pre-port of the x86 patch to kernel
> 4.14.58, which has been useful for validating the split series. I
> hope this will help the x86 maintainers to clear that hurdle
> eventually.
> 
> The whole pile of patches went through countless incremental builds
> over multiple configurations, and tedious manual fixups over a few
> weeks. However, there is room for issues, given the amount of code
> involved, and the varying configurations one can apply. If you find
> any problem with that split series, please report them here so that
> we fix them.
> 
> Please note that those trees are rebased from time to time.

Really cool! Thanks so much for your work, i quickly looked at the
structure of the patches and the commit messages. I think that should
greatly improve the documentation and we will see how well that works
for the next rebase. But i hope and assume that will become much easier
with this approach.

> == Generic changes
> 
> - select HAVE_IPIPE_SUPPORT is needed from the arch-code (Kconfig) to
> enable the generic I-pipe bits. This way we can have an incremental
> build, without requiring the arch-code to be present in the commit
> stack for testing generic changes.
> 
> - Likewise, select HAVE_IPIPE_TRACER_SUPPORT is needed from the
> arch-code when the tracer is available. Only ARM needs this currently,
> due to the TSC emulation support we need to provide there to get
> timestamps which is not part of the ARM-specific pipeline core. x86
> and ppc32 have their own tsc/timebase readily available when the core
> bits are in.
> 
> - __ipipe_init_threadflags() now receives struct thread_info *. To be
> updated in the arch-specific bits.
> 
> == x86
> 
> The basic port available at [2] boots over KVM and a couple of real
> hw I have here, x86_64 only, x86_32 is untested and likely not
> complete - although little should be left. It enables the interrupt
> pipeline, but has not been checked against Xenomai, since FPU support
> is not there (*).

I have got a working eager-fpu 4.4 and 4.9 and looked into this 4.14 as
well, in the hope to get the patch against xenomai in a shape that will
work for all three kernels.

So i ported my kernel patch to this 4.14 and adjusted xenomai to work
on that as well. Unfortunately the kernel does not boot. It gets stuck
right after switching the clocksource to tsc. My current assumption is
that the timer does not work, maybe interrupts in general.

Do you have a suggestion how to best debug that? I could also share the
current state of the fpu-patches so you could have a direct look at it
yourself.

Henning

> Some changes have been made compared to earlier x86 patch releases,
> building on reasonable assumptions - I believe - to make it simpler.
> The resulting patch is only a proposal, whether the suggested changes
> are kept or dropped by the x86 maintainers won't impact the -noarch
> tree.
> 
> - dropped "select best clocksource for timings". This was only used
> for enabling the i8253 on x86_32. We assume the TSC is fine there too
> for the hw we want to support (constant, precise etc), timings with
> the ancient i8253 are crappy anyway. This is why we don't need to
> patch the PCSPEAKER code anymore either.
> 
> - arch/x86/include/asm/preempt.h not instrumented anymore with
> ipipe_preempt_root_only() since we don't support legacy I-pipe
> contexts (i.e. regular task stacks are required, no hand-crafted
> kernel thread stacks as a la Xenomai 2.6).
> 
> - __ipipe_trap_prologue() was rewritten in a saner way, building on
> several assumptions we may make since we don't have to care about
> CONFIG_IPIPE_LEGACY anymore (e.g. no foreign stacks etc).
> 
> - LOCKDEP + IPIPE is almost available; there is still a warning
> produced by the lock validation engine due to a missing/mispaced
> trace_irq_on instrumentation in the asm entry code when pipelining is
> enabled, but the overall picture looks fairly sane already. A few
> additional fixups might be needed when we start traversing the asm
> entry code from the head domain though.
> 
> (*) regarding FPU support, I would suggest to reuse the regular
> switch_to() interface for x86. I don't think that open coding context
> switching bits in the Xenomai core makes any sense these days, with
> the KPTI dance and Spectre mitigation code all around, stack protector
> instrumentation etc.

The new way basically does that. The only case left for the co-kernel
is the interruption of in-kernel-fpu. The save/restore for that is done
eager as well.

Henning

> Thanks,
> 
> [1] https://gitlab.denx.de/Xenomai/ipipe-noarch.git, 4.14-split
> [2] https://gitlab.denx.de/Xenomai/ipipe-x86.git, wip/4.14-split
> 


