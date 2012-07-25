Message-ID: <500FEB0F.9000308@xenomai.org>
Date: Wed, 25 Jul 2012 14:48:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Heads up: I-pipe patch status on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Short version: good news, we are able to compile a Linux 3.4 "all-in-one
kernel" with Xenomai support.

Long version:
As you may know, the direction followed by the Linux kernel on ARM is to
allow, as much as possible, to compile a single kernel to run on many
ARM SOCs. This basically means the systematic elimination of
SOC-specific piece of codes which were chosen at compilation time.
Historically, Xenomai SOC support code fell into that category, with
everything SOC specific being called __ipipe_mach_something, and being
selected at compilation time, this was not a bad choice at the time it
was made: Linux kernel code was not able to be compiled for several SOCs
at a time anyway.

Changing this started with the I-pipe patch for Linux 2.6.33, with the
implementation of the "kuser" tsc emulation, whose side effect was to
make the tsc emulation registered at run-time. The tsc emulation code is
provided in the "vector page", at the same place as other helpers
provided by the Linux kernel (the ARM user-space atomic_cmpxchg is
implemented this way for instance). The aim of putting the helper there
is to avoid having to compile a SOC specific code in user-space. This
has been exploited by Xenomai 2.6.0 which removed the --enable-arm-mach
option and uses the "kuser" helper by default (but allows to fallback to
the old way in order to remain compatible with old patches). This
allows, for instance, a Debian "xenomai-runtime" package which runs with
any SOC, whatever the implementation of their tsc. Incidentally, tests
have also showed that implementing the tsc emulation code that way,
actually reduced the average tsc latency despite the fact that reading
the tsc is a function call and no longer a piece of inlined C code, that
is probably because the helpers are implemented in assembly. To the
point where the latency of the (software) tsc is lower on a Cortex A9
based processor than the (hardware) tsc on an Intel Atom 230.

The I-pipe core patch for Linux 3.2 provided another occasion to move in
the same direction:
- the I-pipe timer factorization effort allowed to get the hardware
timer support code registered at run-time and no longer hard-coded at
compilation time. Again, this was not the original aim, the aim was to
have a hardware timer support uniform across all architectures to reduce
the Xenomai arch-specific cruft, and a secondary aim on ARM was to allow
sharing more code with the clockevent infrastructure, by simply reusing
the clockevent timer call-backs when the hardware timer is shared
between Xenomai and Linux. It turns out that we also reused the
clockevent call-backs on other architectures, and in fact, it also
simplified compiling a Linux kernel on x86, because we no longer need a
kernel compiled differently to use the local APIC timer or the PIT timer.
- we also get the PIC muting functions on ARM to be registered at
run-time, this time on purpose.

While writing a documentation on how to port the I-pipe core patch to a
new ARM board [1], I realized that we still had some "__ipipe_mach" code
in the I-pipe core patch: the IPI handling code on SMP systems.

So, I took the chance of working on the I-pipe patch for Linux 3.4 to
remedy this situation. The idea is simple: in the Linux kernel on ARM
the IPIs live in a different numbering space as the IRQs, but the
interrupt pipeline wants to mix them with irqs, to have a common
pipeline for both types of interrupts. Some __ipipe_mach macros made
that work. For instance, on Cortex A9, the IPIs are actually in the same
numbering space as the IRQs at the interrupt controller level, they
simply are irqs from 2 to 16, so, in the I-pipe patch before Linux 3.4,
we simply used the hardware IPI numbers as irq numbers. But this has two
disadvantages:
- starting with Linux 3.4, hardware irq numbers are remapped to Linux
virtual irq numbers, with the advent of "irq domains", so the fact that
there is room for the IPIs is no longer guaranteed;
- more importantly, on a cortex A9 kernel, this means that Linux domain
irq handlers for irqs 2 to 16 were redirecting these irqs to Linux IPI
handler, which is the wrong thing to do on non cortex A9 processor.
So, the cure was to systematically remap the IPIs to I-pipe virqs, (and
remove the __ipipe_mach macros), this does not change anything with
regard to the path followed for handling IPIs except for the particular
number they use along the interrupt pipeline, but this avoids the two
issues mentioned above:
- however Linux irqs are remapped, they do not conflict with I-pipe virqs
- a cortex A9 enabled kernel running on another SOC (a uniprocessor SOC
for instance), reserve virqs for IPIs which are simply never used, the
other SOC irqs are handled as irqs, as should be.

So, the net result of all this is that I have been able to run a Linux
kernel compiled with Xenomai support both for OMAP3 and OMAP4 at the
same time, both on an OMAP3 and on OMAP4, and to compile test a Xenomai
kernel for the two imx_v4_v4_defconfig and imx_v6_v7 kernel
configurations which cover about every Freescale IMX processors around
(including the cortex A9 based IMX6Q).

Whether the multi-SOC feature will really be used by Xenomai users on
ARM remains to be seen (but why not a Debian kernel or two with all ARM
marchines around?), but in any case, it is a net win for simply compile
testing the I-pipe patch on ARM. The only remaining problem is with
AT91s, which still have to be compiled separately on Linux 3.4, but I
see the 3.5 kernel allows compiling them all at once.

The bad news is that in order to achieve the goal of a kernel runnable
on multiple SOC, the Linux kernel has increased the path followed to
handle hardware interrupts (notably with CONFIG_MULTI_IRQ_HANDLER, irq
domains), and that is probably the reason why we get slightly worse
latencies with Xenomai for Linux 3.4 on ARM [2].

[1] http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
[2] http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/

-- 
                                                                Gilles.

