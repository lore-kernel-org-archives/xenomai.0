Date: Wed, 8 Apr 2009 16:08:19 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
Message-ID: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Selecting the TSC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

It appears that whereas Xenomai uses the definition of the obsolete
kernel CONFIG_X86_TSC configuration option to determine whether the
kernel uses the TSC, everything else in the 2.6.28.7 kernel now uses
either the macro cpu_has_tsc, or the macro, cpu_has(c,X86_FEATURE_TSC)
to do this.  Both of these macros eventually expand to

  test_bit(X86_FEATURE_TSC, c->x86_capability)

where c is the pointer to the cpu-data of a specified CPU. For x86
CPUs this accesses the TSC capability bit that is read from the
specified CPU at boot time (in arch/x86/kernel/cpu/common.c). This bit
is not affected at all by the setting of the CONFIG_X86_TSC option
macro.

The reason that I investigated this, is because I couldn't find any
way to get Xenomai to use the TSC on the ancient AMD Athlon that I am
currently using to try out Xenomai. Whereas the feature flags shown by
/proc/cpuinfo indicate that the kernel is using this CPU's TSC,
Xenomai's trivial_periodic example program complains that it
isn't. The reason is that for any processor type other than the
various Pentium CPUs, "make menuconfig" doesn't define CONFIG_X86_TSC
in the .config file at all, and if one manually adds this option to
the .config file, then the kernel make procedure removes it before
proceeding to build the kernel.

Is this a known issue, and if so, how are other people working around
it?

Assuming that the issue is known, has any work been done towards
moving Xenomai over to using the run-time cpu_has_tsc macro, instead
of the obsolete compile-time feature macro? Given that this is my
first experience with Xenomai, I don't know how problematic this might
be.

FYI, note that I have checked that, apart from the areas patched by
the xenomai prepare_kernel.sh script, there are only 3 places in the
2.6.28.7 kernel where the old CONFIG_X86_TSC macro is still used, and
none of these are involved in actually determining whether the TSC is
used or not.  Specifically, in
linux-2.6.28.7/arch/x86/include/asm/tsc.h, if CONFIG_X86_TSC is
undefined, then cpu_has_tsc is consulted instead, to check whether to
use the TSC anyway, and in linux-2.6.28.7/arch/x86/kernel/tsc.c, if
CONFIG_X86_TSC is defined, then the notsc boot-line option results in
an error message saying that the TSC can't be disabled.

Martin Shepherd  (mcs @ astro.caltech.edu)

