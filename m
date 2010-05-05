Message-ID: <4BE1E20F.6040003@domain.hid>
Date: Wed, 05 May 2010 23:24:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [announce] Xenomai v2.5.3
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Xenomai help <xenomai@xenomai.org>


Hi,

here comes Xenomai v2.5.3, codenamed "Hordes Of Locusts" available from 
Xenomai download area:
http://download.gna.org/xenomai/stable/xenomai-2.5.3.tar.bz2

It contains several fixes for annoying bugs in v2.5.2:
- fix compilation issues with uclibc
- fix a stack overflow due to the stack faulting code on powerpc
- fix of a regression in the RPI code introduced by a clueless RPI 
newbie.

Upgrade of several components:
- ARM I-pipe patchs for more recent kernel versions, with support for 
new platforms, ARM imx51 based Babbage board and OMAP3 based IGEPv2 
board, and some fixes in ARM VFP code;
- RTDM, reverted using the "conforming" mode bit for RTDM syscalls to
the "current" mode bit, adding an rtdm_is_rt_capable service for 
driver such as analogy which need the "current" mode behaviour, as 
well as fixes in analogy to use that new service;
deprecated the rt handlers for open and close, dropped them in 
the in-tree drivers, reworked the close code to be more friendly;
- Debian packaging, upgrade to the level of Debian package version 
2.5.2-2.

Complete short log follows:
Alexis Berlemont (17):
      analogy: fix ring-buffer issues
      analogy: cosmetic fix
      analogy: fix buffer checkings so as to allow infinite acquisitions
      analogy: make cmd_read work with infinite acquisitions (-S 0)
      analogy: fix a misuse of channel descriptors in a4l_get_chan
      analogy: [pcimio] register the digital trigger routine
      analogy: minor change in the header command.h
      analogy: minor cosmetic fix
      analogy: add the test program cmd_bits (beta version)
      analogy: minor fix in insn_bits
      analogy: add triggering in cmd_bits
      analogy: in the core, call rtdm_in_rt_context() instead of a4l_test_rt()
      analogy: add calls to rtdm_rt_capable() in ioctl handlers
      analogy: remove useless device declarations in read / write syscalls handl
ers
      analogy: add rtdm_rt_capable() calls in read / write syscall handlers
      analogy: fix a stupid bug in the use of rtdm_rt_capable()
      analogy: make the command registering perform in NRT context

Daniele Nicolodi (2):
      analogy: make a4l_find_range return the index of the selected range
      analogy: minor change (white spaces removals)

Gilles Chanteperdrix (24):
      common: unconditionnaly map the semaphore heaps in user-space.
      testsuite: fix compilation of cond-torture with uclibc
      common: do not declare a large array on stack for non-main threads.
      arm: fix vfp floating point with armv7
      arm: add support for imx51
      switchtest: increase stack sizes
      arm: declare the VFP inline asm snippets as volatile.
      arm: add a generic-vfp architecture, which enables vfp and compiles for armv5
      Merge commit 'jan'
      bootstrap
      debug: fix CONFIG_XENO_OPT_DEBUG_* issues
      build: pass the *defconfig target to linux build system
      arm: rework the compiler flags to only enable interworking with EABI
      registry: export the registry_obj_slots symbol
      Merge commit 'rpm'
      arm: use current_thread_info() directly instead of going through current
      build: fix build for arm integrator platform
      posix wrappers: avoid undefined reference with uclibc
      arm: handle correctly primary mode VFP exceptions
      arm: add missing #include
      Merge commit 'analogy' into pending
      arm: upgrade I-pipe patches
      build: bootstrap
      doc: regenerate

Jan Kiszka (31):
      RTDM: Add rtdm_rt_capable() service
      RTDM: Bump API version and document changes
      Revert "rtdm: tag syscalls as conforming"
      RTDM: Deprecate open_rt, socket_rt, and close_rt
      RTIPC: Fix memory leak on failing socket creation
      RTIPC: Drop support for RT socket creation/deletion
      RTCAN: Drop support for socket creation/deletion in real-time
      16550A: Drop support for device opening/closing in real-time
      Analogy: Drop support for opening/closing in real-time
      RTDM: Instrument rtdm_context_lock/unlock to detect misuses
      RTDM: Add rtdm_context_put()
      Fix historic msleep wrapping
      irqbench: Fix x86-64 build
      irqbench: Refactor user space helpers
      irqbench: Auto-detect bases of port address and IRQ values
      rttest: Resolved test device conflicts via separate name spaces
      testing: Clean up Kconfig rules
      RTIPC: Drop unused wrapper around close_lock_count
      RTDM: Document device close procedure
      Add list_first_entry wrapper for older kernels
      Add legacy kernel support for delayed_work
      RTDM: Early fd release with poll-free context reference tracking
      RTDM: Add basic unit test
      RTDM: Use non-atomic bitops for used_fildes
      RTDM: Drop __exit from rtdm_dev_cleanup
      Move schedule_delayed_work into wrapping header
      uitron: Fix skin debug option
      RTDM: Restrict use of rtdm_rt_capable
      mutex-torture: Add test for disallowed lock stealing
      nucleus: Fix bogus lock stealing case
      nucleus: fix excessive host tick latencies

Philippe Gerum (13):
      nucleus: introduce bufd reset operation
      rtipc/bufp: reset buffer descriptor upon r/w preemption
      native/buffer: reset buffer descriptor upon r/w preemption
      powerpc: mention official URL to mainline kernel releases
      x86: upgrade I-pipe support to 2.6.32.11-x86-2.6-02
      scripts: fix xeno wrapper to consider --with-testdir
      nucleus: fix relaxing synch owner detector
      nucleus: reduce overhead of thread handle lookup
      x86: upgrade I-pipe support to 2.6.32.11-x86-2.6-03, 2.6.34-rc5-x86-2.6-03
      powerpc: upgrade I-pipe support to 2.6.34-rc5-powerpc-2.9-01
      nucleus/shadow: revert commit 96f5fa2
      nucleus/shadow: fix RPI race in xnshadow_relax() introduced by 695f3d0
      arm: convert to I-pipe sysinfo v2

Stefan Kisdaroczi (2):
      debian: add init-script to package libxenomai1
      debian: sync with 2.5.2-2 from debian.org

Wolfgang Mauerer (1):
      RTDM: Fix potential NULL pointer dereference

Enjoy.

-- 
					    Gilles.

