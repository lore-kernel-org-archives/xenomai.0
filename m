Message-ID: <4D7628BD.5050006@domain.hid>
Date: Tue, 08 Mar 2011 14:01:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [announce] Xenomai 2.5.6
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

Hi,

Xenomai 2.5.6, a.k.a. "Wormhole Wizards" is available at the usual
place: 
http://download.gna.org/xenomai/stable/xenomai-2.5.6.tar.bz2

It contains mainly bug fixes, for:
- SMP scheduling bugs introduced by the "optimization" in the last
release;
- a cleanup of all architectures kernel threads initializations,
triggered by an issue on powerpc;
- some psos skin updates;
- some analogy updates;
- some compilation issues on ARM and x86 for latest toolchains, and with
uclibc;
- some issues with gdb on blackfin.

And as usual an update of many I-pipe patches, including modifications
to use the latest kernel release to date (2.6.37), and wrappers fixes.

Regards.

The complete shortlog follows:
Alexis Berlemont (5):
      analogy: fix the default size of the buffer
      analogy: [pcimio] minor fix in log messages
      analogy: implement configuration of buffer default size
      analogy: add a "sys" function for the ioctl BUFCONFIG
      analogy: add buffer configuration facility in analogy_config

Gilles Chanteperdrix (33):
      build: bootstrap
      doc: regenerate
      arm: add missing armv6+ implementation of cpu_relax in user-space
      arm: make atomic.h implementation C++ friendly
      sched: separate the scheduler status bits
      arm: fix I-pipe patch version detection
      arith: Fix compilation of x86_32 nodiv_llimd with gcc 4.5
      posix: relock nklock in shadow signal handler
      prepare-kernel: fail if temporary directory already exists
      compat: fix PCI IDs for Lnux 2.4
      arm: upgrade I-pipe support to 2.6.33-1.18-01
      sched: Fix leftovers from 74d4cadd28 (sched->status split)
      nucleus/sched: Fix fallout of f6af9b831
      nucleus/sched: avoid useless nklock synchronization in relax path
      16550A: Disable PCI configuration option for platforms without PCI
      nucleus: try harder not to restart syscall with the __xn_exec_norestart flag
      Merge commit 'rpm/for-upstream'
      native: centralize allocation of mutex fastlocks
      Merge commit 'rpm/for-upstream'
      nucleus/types.h: fix compiler error with old compilers
      scripts: allow getting rtdm skin flags with xeno-config
      fastsync: explain invalid calls to xnheap_free
      skins/common: fix segv in the sigaction+linuxthreads+gdb case
      nucleus: switch completely to DEFINE_SEMAPHORE
      wrappers: only use new chip handler accessors above 2.6.37
      Whitespace cleanup
      arm: fix compilation with gcc 4.5.1
      arm: fix previous commit
      Merge commit 'rpm/for-upstream'
      arm: add calibration value for imx51
      arm: upgrade I-pipe support to 2.6.33-1.18-02/2.6.35.9-1.18-01
      build: bump release number and bootstrap
      doc: regenerate

Jan Kiszka (9):
      Re-enable marker support for latest LTTng
      Remove duplicate PCI ID
      nucleus: Avoid spurious calls to xnarch_send_ipi
      nucleus: Consolidate xnsched_self_resched_p
      nucleus: Optimize setting of XNRESCHED
      nucleus: Optimize reschedule signaling for UP
      prepare-kernel: Use auto-generated temp directory for --outpatch
      Add INTEL_IDLE to list of problematic config options
      RTDM: Add missing stddef.h to API header

Philippe Gerum (42):
      nucleus: fix race in xnpod_set_thread_tslice()
      posix: add missing declarations
      build: reverse default for TLS support
      nucleus/intr: sanitize IRQ number validation
      hal/powerpc: sanitize thread init trampoline
      nucleus: clear kthread stack while setting its TCB
      nucleus: fix typo in Kconfig help
      powerpc: upgrade I-pipe support to 2.6.35.7-powerpc-2.12-00
      x86: upgrade I-pipe support to 2.6.35.7-x86-2.8-00
      blackfin: upgrade I-pipe support to 2.6.35.7-blackfin-1.16-00
      hal/arm: remove redundant stack clean up
      hal/blackfin: remove redundant stack clean up
      hal/nios2: remove redundant stack clean up
      hal/x86_32: remove redundant stack clean up
      powerpc: add calibration value for P2020RDB
      powerpc: upgrade I-pipe support to 2.6.35.7-powerpc-2.12-01
      psos: fix task argument passing
      psos: export sm_ident() to userland
      posix: always reschedule after unlocking the scheduler
      powerpc: add calibration value for lwmon5 (44xFP)
      powerpc: upgrade I-pipe support to 2.6.36-powerpc-2.12-01
      nucleus/shadow: fix inverted change from 90b3e7cf6
      powerpc: upgrade I-pipe support to 2.6.36-powerpc-2.12-02
      x86: upgrade I-pipe support to 2.6.35.7-x86-2.8-01
      x86: upgrade I-pipe support to 2.6.35.9-x86-2.8-02
      rtipc/bufp: fix port number check
      nucleus/types.h: fix for uClibc/C++ inclusion (via stdio.h)
      x86: upgrade I-pipe support to 2.6.35.9-x86-2.8-03
      hal/powerpc: provide minimum stack frame on entry to kthreads
      scripts/prepare-kernel.sh: better catch missing I-pipe support in kernel tree
      nucleus/shadow: plug race while mapping a shadow
      x86: upgrade I-pipe support to 2.6.35.9-x86-2.8-04
      scripts/prepare-kernel.sh: set  as default value for --linux
      wrappers: wrap DECLARE_MUTEX in DEFINE_SEMAPHORE (2.6.37+)
      nucleus/shadow: use DEFINE_SEMAPHORE instead of deprecated DECLARE_MUTEX
      wrappers: introduce generic chip handler accessors for GENERIC_HARDIRQS-compliant kernels
      drivers: stop using legacy init_MUTEX()
      x86: upgrade I-pipe support to 2.6.37-x86-2.9-00
      nucleus/pipe: fix RT_PIPE documentation
      blackfin: upgrade I-pipe support to 2.6.35.9-blackfin-1.16-01
      wrappers: use latest irq_desc accessors
      powerpc: upgrade I-pipe support to 2.6.36-powerpc-2.12-03

Ronny meeus (1):
      psos: fix memory leak with message buffers

Stefan Kisdaroczi (4):
      debian: update debian/control for debian 6.0 "squeeze"
      16550A: customizable irqtype
      16550A: pci support
      16550A: Moxa pci board support

Wolfgang Grandegger (1):
      wrappers: fixup "struct of_device" for RTCAN MPC5xxx driver


-- 
                                                                Gilles.

