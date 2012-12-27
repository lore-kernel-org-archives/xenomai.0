Message-ID: <50DB9004.20400@xenomai.org>
Date: Thu, 27 Dec 2012 01:02:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [Announce] Xenomai 2.6.2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi, 

Please find Xenomai 2.6.2 at the usual place:
http://download.gna.org/xenomai/stable/xenomai-2.6.2.tar.bz2

Like the last release, we waited a long time before the release, so 
there are quite a few bug fixes, including those for:
- the bug happening for threads exiting under PIP boost, reported by 
Henri Roosen;
- the XDDP crash reported by Doug Brunner;
- the rt_printf buffer overrun reported by Alessio Margan;
- the pthread_set_name_np bug reported by Jean Baptiste Tredez;
- the RTDM spinlocks short-coming reported by Thierry Bultel;
- the select() but reported and fixed by Alexandre Duch;
- the native queues leak reported and fixed by Kai Bollue;

In addition to these fixes, the interesting novelties are:
- update of the I-pipe patches, with new I-pipe core patches for Linux 
3.4 and 3.5, an update of the I-pipe core patch for Linux 3.2, and a 
backport of some VM fixes to the I-pipe patch for Linux 2.6.38 for x86; 
- updates of the RTCAN drivers, with notably support for the Flexcan 
driver available on Freescale processors;
- simplification of the configure script to avoid having the 
--enable-smp option: the default user-space on most architectures works 
on SMP and non-SMP machines;
- documentation: conversion of README.INSTALL, TROUBLESHOOTING guide 
and manual pages, which means we now have an html version of these 
documents;
- ARM: allow user-space compiled in thumb mode (which is the default 
for some toolchains);
- x86: allow compiling kernels which works whether the machines has a 
tsc or not, and whether it has an APIC or not, which means we can now 
have a single kernel working on all x86 configurations;

Thanks to everyone who contributed bug reports, updates, and fixes.
Merry christmas and happy new year to all.

Shortlog follows:
Charles Retailleau (1):
      hal/powerpc: fix __xn_rdtsc for newer ppc cores

Gilles Chanteperdrix (65):
      hal/arm: adapt to I-pipe core patch for Linux 3.4
      hal/x86: adapt to I-pipe core patch for Linux 3.4
      hal: use ipipe_head_switch_mm as provided by newer I-pipe patches
      skins/posix: avoid symbol name conflict with rtdm skin
      hal: pass to ipipe_timer_set a delay in hrclock ticks
      hal/arm: fix compilation for thumb
      hal/arm: avoid recursive fpu faults
      doc: convert TROUBLESHOOTING and README.INSTALL to asciidoc
      doc: fix README.INSTALL/TROUBLESHOOTING cross links
      doc/asciidoc: add missing icons
      doc/asciidoc: add missing icons (take #2)
      nucleus: revert spurious commit
      nucleus: unregister hostrt event when removing nucleus module
      doc: update README.INSTALL and TROUBLESHOOTING
      nucleus: revert spurious commit take #2
      hal/x86: dynamically detect tsc with I-pipe core API rev >= 2
      hal: replace all remaining references to cpu frequency with clock frequency
      hal/x86: revert commit 89cb4933ec93d4e6209e2f681d1f932467d98db6
      hal/x86: dynamic tsc detection again
      doc: update README.INSTALL and TROUBLESHOOTING
      hal/x86: avoid crashes on CPU without a TSC
      config/x86: do not enable stats by default without tsc
      scripts/gnuplot: enable grid by default
      testsuite/latency: handle all SIGDEBUG cases
      hal/x86: use I-pipe core API rev 2 for tsc
      testsuite: add xddp crash regression test
      hal/arm: support any type of tsc emulation with I-pipe core patches
      nucleus/debug: allow resetting xnlock statistics
      skins: use put_user instead of copy_to_user for overruns count
      common/rt_print: fix buffer overrun
      testsuite/regression: remove debug code from tsc test
      testsuite: various fixes in xeno-test-run
      testsuite/regression: add test for thread exit under PIP
      hal/arm: change mx6q calibration value
      hal/generic: do not set not online cpus in rthal_supported_cpus
      hal/x86: fix timer calibration for non I-pipe core
      hal/generic: allow disabling xenomai on kernel comand-line
      testsuite/xeno-test-run: stop abusing the shell
      arm/arith: fix compilation with tracer+thumb2
      hal/arm: fix compilation of tsc emulation with older I-pipe patches
      posix: avoid oops when pthread_set_name_np is called for non-posix thread
      examples: fix compilation
      arm: rely on gcc for atomic operations
      doc: regenerate
      testsuite: avoid compiler warning
      doc: Re-add changes to TROUBLESHOOTING
      nucleus: rename XNSWLOCK -> XNINSW
      nucleus/sched: allow disabling preemption temporarily
      rtdm: get spinlocks to lock the scheduler
      arm/hal: use the ipipe_get_active_mm service provided by the I-pipe core patches
      arm/mayday: fix mayday with applications compiled in thumb mode
      posix: fix select syscall
      hal: select IPIPE_WANT_ACTIVE_MM when needed
      hal: add new atomic headers to Makefiles
      doc: start moving manual pages to asciidoc
      build: bootstrap
      doc: move asciidoc files to asciidoc directory
      wrappers: define the clamp() macro for older kernels
      nucleus/bheap: avoid array bound checking warning
      powerpc: re-add the commit number necessary for the 2.4.25 patch
      x86: introduce support for builtin atomic ops
      build: bootstrap
      wrappers: provide definition of cpu_online() for older kernels
      build: bump version number and bootstrap
      doc: regenerate

Jan Kiszka (1):
      rtdm: Restrict/clarify usage of rtdm_irq_request/free/enable/disable

Jeff Webb (1):
      debian: add missing directory creation

Kai (1):
      native/queue: fix memory leak upon failed write

Philippe Gerum (48):
      examples/rtipc: fix linker command line
      Merge branch 'master' of git://xenomai.org/xenomai-2.6
      hal/powerpc: fixup for kernel 3.4 series
      nucleus, skins: fix up for kernel 3.5 series
      hal/powerpc: fix up for kernel 3.5 series
      hal/blackfin: fix up for kernel 3.5 series
      nucleus: select IPIPE_CORE_APIREV 2
      wrappers: fix cpu_online_map/mask wrapping
      analogy: fix build for 3.4+ kernel series
      nucleus, skin: silence pedantic warnings (-Wunused-but-set-variable)
      wrappers: ipipe_head_switch_mm -> ipipe_switch_mm_head
      wrappers: wrap to ipipe_select_timers() for APIREV >= 2
      hal: wrap_ipipe_timers_request -> wrap_select_timers
      wrappers, hal: simplify checks for pipeline core API
      nucleus/shadow: do not clear PIP boost for an exiting thread
      rtipc/xddp: fix crash upon lingering close
      Merge branch 'master' of git://xenomai.org/xenomai-2.6
      hal/x86_32: fix build over legacy pipelines
      nucleus: introduce internal sched locking helpers
      Merge branch 'master' of git://xenomai.org/xenomai-2.6
      x86, powerpc: enable --enable-smp by default
      powerpc: CRITICAL: enable SMP sync insns in userland
      configure: introduce --with-atomic-ops
      powerpc: introduce support for builtin atomic ops
      blackfin: introduce support for builtin atomic ops
      blackfin: add declaration missing in uClibc
      arm: convert --enable-arm-atomic to generic --with-atomic-ops
      drivers/ipc: fix section mismatches
      Merge branch 'master' of git://xenomai.org/xenomai-2.6
      x86: upgrade I-pipe support to 2.6.38.8-x86-2.11-03
      Merge branch 'master' of git://xenomai.org/xenomai-2.6
      x86: fix inverted check for integrated APIC
      hal/generic: fix return type for local vm_mmap
      powerpc/atomic: fix 64bit build
      skins/common: silence pedantic warning
      posix: provide application interface to the SCHED_TP policy
      bootstrap
      wrappers: more fixups for legacy kernels
      wrappers: enable cpu_online for 2.4 kernels
      x86: force noxsave
      posix: fix TP conditional in pthread_getschedparam_ex()
      testsuite/sched-tp: fix build warnings
      x86: force noxsave only when xsave is present
      x86: upgrade I-pipe support to 3.2.21, 3.4, 3.5 core release 2
      powerpc: upgrade I-pipe support to 3.2.21, 3.4, 3.5 core release 2
      blackfin: upgrade I-pipe support to 3.2.21, 3.4, 3.5 core release 2
      arm: upgrade I-pipe support to 3.2.21, 3.4, 3.5 core release 2
      doc/x86: mention lack of xsave support

Roland Stigge (2):
      Updated debian/*
      Removal of dh-kpatches support

Thierry Bultel (1):
      rtcan: driver for the Advantech PCI cards

Wolfgang Grandegger (5):
      rt-imx-uart: RTserial driver for the UART's on the Freescale IMX SOCs
      rtcan: add some macro definitions for compatibility with Linux-CAN
      rtcan: add bit-timing calulation from Linux-CAN
      rtcan: add driver for Flexcan on Freescale SOCs
      rtcan: Adding device ID for PEAK PCIe card IPEH-003027

hauptmech (1):
      doc: move manual pages to asciidoc



-- 
                                                                Gilles.

