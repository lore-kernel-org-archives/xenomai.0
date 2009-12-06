From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 Dec 2009 18:58:36 +0100
Message-ID: <1260122316.2174.162.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.5-rc5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Here is 2.5-rc5. Alex still seems to be in frantic mode these days, so
the Analogy DAQ framework got a lot of changes in. Aside of this, the
most notable addition since -rc4 is real-time signal handling, aka "I
want my event handler running in primary mode". This is still an
internal feature for now, but Gilles will likely give some details
about it, maybe when the first in-tree user shows up.

http://download.gna.org/xenomai/testing/xenomai-2.5-rc5.tar.bz2

--

Alexandre Coffignal (1):
      psos: fix q_vreceive

Alexis Berlemont (32):
      analogy: force NI TIO / MIO selections when NI PCIMIO is set
      analogy: force NI MITE selection when NI PCIMIO is set
      analogy: fix a critical bug in the NI PCIMIO driver
      analogy: rename 8255 and NI PCIMIO driver
      analogy: fix a bug in NI PCIMIO driver
      analogy: improve ioctl error handling
      analogy: fix a bug in the attach procedure
      analogy: remove EXPERIMENTAL flag from 2.4 Config.in files
      analogy: fix a mistyping error
      analogy: fix functions declarations in the 8255 driver
      analogy: add an analogy driver for standard parallel port
      analogy: add default attach options for analogy_parport driver
      analogy: make analogy_parport compile only for x86 architectures
      analogy: use the A4L_INSN_* constants to configure the DIO subdevice
      analogy: minor cosmetic change in instruction header
      analogy: change prefix for traces (a4l -> Analogy)
      analogy: some coding style corrections
      analogy: fix a minor bug (filename management) in insn_read
      analogy: add a test program which performs synchronous write
      analogy: fix missing renamings for testing drivers
      analogy: fix doxygen documentation generation for analogy
      analogy: minor indentation fix
      analogy: fix positive error code in transfer cleanup
      analogy: add some details on the error codes for the syscall API
      analogy: add error codes descriptions for the asynchronous API
      analogy: fix a scan size miscalculation in cmd_read
      analogy: report scan size miscalculation fix in cmd_write and insn_*
      analogy: add error messages in instruction handling
      analogy: add error codes descriptions for synchronous operations
      analogy: add error codes descriptions for descriptor routines
      analogy: add error codes descriptions for range management routines
      analogy: fix mistakes in license declarations

Andreas Glatz (1):
      nucleus: do not lose base priority in nested PIP boosts

Bernhard Walle (1):
      hal: check CPU frequency

Fabian Godehardt (1):
      scripts: use new 'head -n' syntax.

Gilles Chanteperdrix (17):
      rtipc: Remove rt-ipcs exit functions from the exit section.
      rtipc: xCompile the rt-ipcs driver by default
      nucleus: defer selector block deletion to an APC.
      bind: Replace bind.h with a convenience library.
      skins: add per-skin user-space signal handler, and dispatch function.
      arm: implement signals handling
      x86_64: implement signals handling
      x86_32: implement signals handling
      nucleus: implement kernel-space per-thread per-skin signals handling.
      skins: move sigshadow to libxeno_common
      posix: fix pthread_cond_wait restarting
      native: fix rt_cond_wait restarting
      testsuite: add user-space real-time signals unit test
      build: bootstrap
      signals: reduce signals handling memory footprint
      posix: cosmetic cleanup of pthread_cond_*wait
      posix: revert commit 58c1b922a96fedaef110c925a0dddb0e86dbcaf4

Jan Kiszka (13):
      buildsystem: Fix shared libs generation
      rtdm: Add padding to rtser_config
      native: Properly update lockcnt on recursive call from secondary mode
      nucleus: Track heap mapping on to mm-clone
      nucleus: Fix trivial build warning
      hal: Ensure atomicity of rthal_local_irq_disabled
      nucleus: Cosmetic cleanup of lostage_handler
      nucleus: Improve lostage_work instrumentation
      nucleus: Fix endless loop of DEBUG_SYNCH_RELAX
      nucleus: Fix build warning of thread_fault instrumentation
      rtdm: Fix copy&paste mistake in instrumentation
      nucleus: Include all heaps in statistics
      nucleus: Allow runtime setting of xeno_nucleus.watchdog_timeout

Luis Herrera-Bendezu (1):
      rtdm: Extend rtdm_iomap_to_user to map phys addr > 4G

Peter Soetens (2):
      nucleus: move posix selector in nucleus for every skin to use.
      posix: Fix __wrap_select() when timeout happens.

Philippe Gerum (33):
      build: bootstrap
      native: pass errno back as returned by kernel
      nucleus: fix shared heaps for MMU-less configs
      nucleus: fix deferred release handling for shared heaps
      nucleus: fix locking in shared heap deletion
      nucleus: set vma private data early enough
      nucleus: wrap find_task_by_pid()
      doc: fix typo
      wrappers: introduce DEFINE_SPINLOCK in 2.4 section
      powerpc: upgrade I-pipe support to 2.6.30.3-powerpc-2.7-03
      wrappers: make sure pgprot_noncached() is always defined
      nios2: upgrade I-pipe support to 2.6.30-nios2-1.1-00
      nios2: upgrade I-pipe support to 2.6.30-nios2-1.1-00
      nucleus: initialize heap->stat_link holder
      powerpc: implement signals handling
      blackfin: introduce support for real-time signals
      nios: implement signals handling
      skins: give a more explicit message about ABI version mismatches
      native: fix signal related code in the FASTSYNC-disabled case
      sigtest: fix UCLIBC check
      blackfin: fix syscall template
      nios2: fix syscall template
      blackfin: do not stack registers already marked as clobbered
      powerpc: upgrade I-pipe support to 2.6.30.3-powerpc-2.7-04
      build: introduce CONFIG_XENO_SHARED to reflect shlib support
      build: bootstrap
      x86: upgrade I-pipe support to 2.6.31.1-x86-2.4-07
      x86: upgrade I-pipe support to 2.6.31.1-x86-2.4-08
      wrappers: fix for Linux 2.4
      testsuite: fix sigtest build rules for Linux 2.4
      analogy: fix Linux 2.4 build
      build: update version stamp
      doc: regenerate

Sebastian Smolorz (1):
      can: Free I/O region when unloading the xeno_can_isa.ko driver


-- 
Philippe.



