From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9807836c-9287-10a7-52bf-6b5947c87699@xenomai.org>
Date: Mon, 30 Jul 2018 20:10:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe split series
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Seeger, Steven D. (GSFC-444.0)[Embedded Flight Systems,
 Inc]" <steven.seeger@nasa.gov>, "Kiszka, Jan" <jan.kiszka@siemens.com>


The generic I-pipe code is now available as a series of incremental
commits at [1] on top of the 4.14.58 kernel. This allows to port the
I-pipe patch gradually, first to enable IRQ pipelining per se, then add
the bits required for co-managing tasks between the regular kernel and
the co-kernel, which builds on the former. Most patches have gained a
description in their respective short log, which added to
Documentation/ipipe.rst, should help clarifying the process of porting
the pipeline.

While I was at it, I did a pre-port of the x86 patch to kernel 4.14.58,
which has been useful for validating the split series. I hope this will
help the x86 maintainers to clear that hurdle eventually.

The whole pile of patches went through countless incremental builds over
multiple configurations, and tedious manual fixups over a few weeks.
However, there is room for issues, given the amount of code involved,
and the varying configurations one can apply. If you find any problem
with that split series, please report them here so that we fix them.

Please note that those trees are rebased from time to time.

== Generic changes

- select HAVE_IPIPE_SUPPORT is needed from the arch-code (Kconfig) to
enable the generic I-pipe bits. This way we can have an incremental
build, without requiring the arch-code to be present in the commit stack
for testing generic changes.

- Likewise, select HAVE_IPIPE_TRACER_SUPPORT is needed from the
arch-code when the tracer is available. Only ARM needs this currently,
due to the TSC emulation support we need to provide there to get
timestamps which is not part of the ARM-specific pipeline core. x86 and
ppc32 have their own tsc/timebase readily available when the core bits
are in.

- __ipipe_init_threadflags() now receives struct thread_info *. To be
updated in the arch-specific bits.

== x86

The basic port available at [2] boots over KVM and a couple of real hw I
have here, x86_64 only, x86_32 is untested and likely not complete -
although little should be left. It enables the interrupt pipeline, but
has not been checked against Xenomai, since FPU support is not there (*).

Some changes have been made compared to earlier x86 patch releases,
building on reasonable assumptions - I believe - to make it simpler. The
resulting patch is only a proposal, whether the suggested changes are
kept or dropped by the x86 maintainers won't impact the -noarch tree.

- dropped "select best clocksource for timings". This was only used for
enabling the i8253 on x86_32. We assume the TSC is fine there too for
the hw we want to support (constant, precise etc), timings with the
ancient i8253 are crappy anyway. This is why we don't need to patch the
PCSPEAKER code anymore either.

- arch/x86/include/asm/preempt.h not instrumented anymore with
ipipe_preempt_root_only() since we don't support legacy I-pipe contexts
(i.e. regular task stacks are required, no hand-crafted kernel thread
stacks as a la Xenomai 2.6).

- __ipipe_trap_prologue() was rewritten in a saner way, building on
several assumptions we may make since we don't have to care about
CONFIG_IPIPE_LEGACY anymore (e.g. no foreign stacks etc).

- LOCKDEP + IPIPE is almost available; there is still a warning produced
by the lock validation engine due to a missing/mispaced trace_irq_on
instrumentation in the asm entry code when pipelining is enabled, but
the overall picture looks fairly sane already. A few additional fixups
might be needed when we start traversing the asm entry code from the
head domain though.

(*) regarding FPU support, I would suggest to reuse the regular
switch_to() interface for x86. I don't think that open coding context
switching bits in the Xenomai core makes any sense these days, with the
KPTI dance and Spectre mitigation code all around, stack protector
instrumentation etc.

Thanks,

[1] https://gitlab.denx.de/Xenomai/ipipe-noarch.git, 4.14-split
[2] https://gitlab.denx.de/Xenomai/ipipe-x86.git, wip/4.14-split

-- 
Philippe.

