From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Thu, 18 Jun 2009 14:52:30 +0200
Message-Id: <1245329550.3951.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.5-rc2
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


After two months since -rc1 - which is way too long, I know - there is
no point in delaying 2.5-rc2 any longer, so here it is.

http://download.gna.org/xenomai/testing/xenomai-2.5-rc2.tar.bz2

Since -rc1, we mainly focused on solving multiple interrupt pipeline
issues for x86, introducing optimizations in core arithmetic helpers,
and eventually adding new supported platforms to the powerpc port. And
as usual, fixes are all over the map.

x86-wise(32/64), if you happen to run any I-pipe release in SMP mode,
prior to Linux 2.6.28.9, and/or earlier than 2.2-07, you should
definitely upgrade to a more recent version. Really.

Regarding powerpc, we now officially support powerpc32/SMP, in
addition to powerpc64/SMP we have been supporting for quite some time
now. The first powerpc32/SMP platform Xenomai officially supports is
Emerson's MVME7100, which is based on a dual core MPC8641D.

There are things brewing in the ARM world, particularly an omap3 port,
but this is not ready for prime time yet (ETA is -rc3). Stay tuned.

Finally, Blackfin users may want to know that we will be tracking Mike
Frysinger's tree from now on:
git://git.kernel.org/pub/scm/linux/kernel/git/vapier/blackfin.git.
On this architecture, the I-pipe bits should be on their way to 2.6.31
mainline already, so Blackfin is actually ahead of everyone else with
respect to kernel support. Official support available with -rc2 is still
based on 2.6.28.10 though, from the Blackfin project SVN/GIT mirror
(see ksrc/arch/blackfin/patches/README for more).

Btw, more information regarding which hardware Xenomai supports is
available from:
http://www.xenomai.org/index.php/Embedded_Device_Support
http://www.xenomai.org/index.php/Other_Hardware_Support

Oh, last point: 2.5-rc2 has a decent stability record among Xenomai
maintainers, but as usual, let me emphasize the obvious: at the end of
the day, only _you_ can make sure the upcoming 2.5 will work for you,
and unless you feel insanely lucky these days or simply don't care
about upgrading, you should not wait for 2.5.0 to perform that check.

Here is the short log:

Gilles Chanteperdrix (10):
      arith: Fix xnarch_divrem_billion not to use rthal_ullmul.
      arm: Adapt to preemptible context switch proposed by newer I-pipe patches
      arm: Fix user-space tsc on ARM
      arm: Improve decrementer user-space tsc emulation
      arm: Use PIC mute routines on the ARM platform
      misc: Remove SIGSHADOW debug message
      nucleus: Fix computation of heap overhead
      posix: Fix the POSIX skin to use the common time conversion.
      posix: Preserve the main thread scheduling parameters when shadowing it.
      rtdm: Reorder headers include directives.

Jan Kiszka (6):
      wrappers: Add rthal_local_irq_disabled wrapper
      nucleus: Add missing header for isspace
      nucleus: Move xnarch_set_irq_affinity out of intrlock
      posix: Improve access checks in select
      rtdm: Avoid namespace pollution in RTDM_EXECUTE_ATOMICALLY
      rtdm: Instrument rtdm_lock_get for proper use

Martin Shepherd (1):
      rtdm: Document the special meaning of returning -ENOSYS

Philippe Gerum (45):
      arith: Fix signedness of divisor
      arith: Introduce xnarch_divrem_billion
      arith: Make optimized tsc<->ns conversion routines available to user-space.
      arith: Rename imuldiv_up to imuldiv_ceil
      arm: Update Adeos/arm support
      blackfin: Decrease some calibration values due to intrinsic latency reduction
      blackfin: Enable CORETMR interrupt when CONFIG_TICKSOURCE_GPTMR0 is set
      blackfin: Make sure to program the next core timer shot in a canonical way
      blackfin: Update Adeos/blackfin support
      build: Fix dist rule
      build: Fix host selection
      build: Fix patch selection with --enable-linux-build
      build: Upgrade to autoconf >= 2.62
      doc: Update README.INSTALL
      doc: fix generate-doc rule
      doc: regenerate documentation
      native, posix: Warn about deprecated usage of Xenomai skins in kernel space
      nucleus: Decentralize PROC_FS-based support
      nucleus: Increase default generic stack pool size
      nucleus: Introduce /proc/xenomai/schedclasses
      nucleus: Make sure to always propagate the host tick in time.
      nucleus: Move arch-specific capability flags to the feature header
      nucleus: Remove misleading comment
      nucleus: Round up results of tsc -> timer ticks conversions when programming
      nucleus: Shorten uninterruptible section within shadow relaxing path
      nucleus: Tell Linux whenever we failed programming the next host tick event.
      posix: Fix build w/o PROC_FS support
      posix: fix handling of HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
      posix: fix pointer signedness in __wrap_clock_gettime()
      powerpc: Add calibration default for Emerson's MVME7100 SBC (MPC8641D)
      powerpc: Add calibration default for MPC8272-ADS
      powerpc: Add calibration default for TQM8560
      powerpc: Add calibration info for 440EP Yosemite
      powerpc: Do not restore Altivec and SPE regs for kernel threads
      powerpc: Fix calibration values for known 85xx-based SBCs
      powerpc: Introduce PIC mute support, initially for powerpc.
      powerpc: Remove obsolete kernel support
      powerpc: Update Adeos/powerpc support
      powerpc: make thread_info reference depend on CONFIG_IPIPE_UNMASKED_CONTEXT_SWITCH
      powerpc: upgrade I-pipe/2.4 support to 2.4.25-ppc-2.0-01
      rtdm: fix build for 2.4
      testsuite/mutex-torture: make sure pthread_mutexattr_setprotocol() is available when building
      wrappers: Void wrap_proc_dir_entry_owner() argument if unused
      x86: upgrade I-pipe support to 2.6.29.5-x86-2.4-01
      Xenomai v2.5-rc2

Stefan Kisdaroczi (2):
      build: Fix Debian package build
      rtcan: Disambiguate PCI device id. for IXXAT-PCI boards

Vladimir Zapolskiy (1):
      wrappers: Made conditional inclusion of owner field in struct proc_dir_entry due to changes in 2.6.30.

Wolfgang Grandegger (2):
      rtcan: ixxat-pci: fix problems with device probing
      rtcan: mscan: fix build problems with recent kernel versions

-- 
Philippe.



