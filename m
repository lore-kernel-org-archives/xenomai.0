Message-ID: <4CAC65FA.70506@domain.hid>
Date: Wed, 06 Oct 2010 14:05:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [announce] Xenomai v2.5.5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>


Hi,

Xenomai 2.5.5, aka "Ghosts", is available:
http://download.gna.org/xenomai/stable/xenomai-2.5.5.tar.bz2

It contains bug fixes for:
- the x86 I-pipe issue, which caused freeze-on-boot issue, very 
reproducible with grub 2
- a ppc I-pipe issue, which involved unaligned access to floating point 
values
- the debian patch generation script, which caused invalid patches to be
generated for recent kernel releases
- a few compilation issues with recent compilers and or innfrequently 
used compilation options
- issues with using fork with process-private user-space mutexes

And improvements:
- of the user-space latency on all platforms by optimizing the RPI code 
and the relax code
- of the ARM support to code, in order to support SMP systems
- of the analogy stack by Alexis
- of the user-space latency on ARM in general and OMAP3 in particular, 
as a result of some work both on Xenomai timer code and on the I-pipe 
patch
- of the scheduler "resched" bit handling by simplifying it, following 
the correction of an incorrect warning

Note: Xenomai 2.5.5 is the last release to contain a patch for Linux 2.4
on x86 and to export kernel-mode services to non GPL modules.

Enjoy.

The complete shortlog follows:
Alexis Berlemont (9):
      analogy: minor change in analogy Kconfig text
      analogy: add comments in the buffer management code
      analogy: fix a bug in the DIO subdevice's mite configuration
      analogy: minor changes in cmd_bits
      analogy: comsetic change in mite.c
      analogy: [pcimio] rework the mite setup procedures
      analogy: [pcimio] fix a forgotten warning
      analogy: [pcimio] add the initialization of the ring for gpct subd
      analogy: fix compilation warnings with gcc-4.4.1

Gilles Chanteperdrix (24):
      fix private heap unmapping upon fork.
      Do not assume that XN_NO_HANDLE is NULL
      Set user-space current thread handle to XN_NO_HANDLE after fork
      fix comment
      Fix typo in edaf1e2e54343b6e4bf5cf6ece9175ec0ab21cad
      sem_heap: map an inaccessible heap upon fork.
      posix: add a magic to internal structures.
      arm: fix VFP context handling on SMP systems
      Merge commit 'rpm/for-upstream'
      arm: fix atomic operations
      arm: fix typo in 4a739c5ce29b50bee780bf620852a2fff6a71431
      autotools: regenerate
      arm: better calibrate the timer programming latency
      arith: add the nodiv_imuldiv_ceil routine
      arm: use the nodiv_imuldiv routine for timer programming.
      hal: export missing apc symbols
      nucleus: modify /proc/xenomai/latency
      nucleus: add a margin for early timer shots
      nucleus/sched: fix rescheduling bit test macros
      arm: add calibrated scheduling latencies
      arm: remove debug printk
      smi: add PCI ID for old kernels
      build: boostrap
      doc: regenerate

Jan Kiszka (8):
      RTDM: Protect xnshadow_ppd_get via nklock
      nucleus: Fix symbolic status output of root threads
      nucleus: Create watchdog as non-blockable timer
      native: Improve documentation of rt_task_join and rt_task_delete
      x86: Add PCI ID of Series 5/3400 Intel chipset to SMI workaround
      x86: Add PCI ID of 631xESB/632xESB/3100 Intel chipset to SMI workaround
      x86: Add PCI ID of Intel ICH9M-E chipset to SMI workaround
      x86: Add PCI ID of Intel ICH9M chipset to SMI workaround

Mike Frysinger (1):
      blackfin: clean up syscall assembly

Peter Soetens (1):
      rtcan: Mask the SJA_MOD register when probing for channels

Philippe Gerum (36):
      powerpc: upgrade I-pipe support to 2.6.34.4-powerpc-2.10-04
      nucleus: demote RPI boost upon linux-originated signal
      blackfin: upgrade I-pipe support to 2.6.35.2-blackfin-1.15-00
      nucleus: requeue blocked non-periodic timers properly
      x86: upgrade I-pipe support to 2.6.32.20-x86-2.7-02, 2.6.34.5-x86-2.7-03
      arm: force enable preemptible switch support in SMP mode
      arm: enable VFP support in SMP
      arm: use rthal_processor_id() over non-linux contexts
      powerpc: resync thread switch code with mainline >= 2.6.32
      x86: increase SMP calibration value
      nucleus/sched: move locking to resume_rpi/suspend_rpi
      hal/generic: inline APC scheduling code
      nucleus, posix: use fast APC scheduling call
      nucleus/shadow: shorten the uninterruptible path to secondary mode
      nucleus/sched: prevent remote wakeup from triggering a debug assertion
      powerpc: upgrade I-pipe support to 2.6.35.4-powerpc-2.11-00
      nucleus/sched: fix race in non-atomic suspend path
      nucleus/sched: raise self-resched condition when unlocking scheduler
      nucleus: fix build issue introduced by 4860668b6
      x86: upgrade I-pipe support to 2.6.32.20-x86-2.7-03, 2.6.34.5-x86-2.7-04
      nucleus: please C++ parsers
      nucleus: do not rely on implicit header inclusion
      rtdm: fix build for non-pervasive mode
      rtipc: fix build for non-pervasive mode
      nucleus/shadow: fix build for simulation mode
      native: fix build for simulation mode
      nucleus/bufd: fix documentation group tag
      psos: fix t_shadow() regression
      psos: introduce t_setreg/t_getreg syscalls
      arm: upgrade adeos patch to 2.6.33-1.18-00
      x86: upgrade adeos patch to 2.6.35.7-2.7-04
      powerpc: upgrade I-pipe support to 2.6.34.4-powerpc-2.10-05, 2.6.35.7-powerpc-2.11-01
      blackfin: upgrade I-pipe support to 2.6.34-blackfin-1.15-01, 2.6.35.7-blackfin-1.15-01
      nucleus: disable u_mode watchdog for MMU-less
      can: adapt to platform driver infrastructure changes for 2.6.35
      powerpc: upgrade I-pipe support to 2.6.35.7-powerpc-2.11-02

Stefan Kisdaroczi (3):
      debian: fix asm include directory linking in prepare-patch.sh
      debian: move debian/prepare-patch.sh to scripts/
      RTDM device profiles: Document open_rt, socket_rt and close_rt deprecation

Wolfgang Grandegger (1):
      nucleus: switch to ioctl_unlocked


-- 
                                                                Gilles.

