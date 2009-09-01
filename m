From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Tue, 01 Sep 2009 12:55:11 +0200
Message-Id: <1251802511.3205.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.5-rc3
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Here is -rc3, bug fixes are literally all over the map, with a special
mention for closing several powerpc and ARM FPU-related issues. The new
"buffer" IPC support from the native API (RT_BUFFER) should now be
working properly as well.

As usual, I-pipe patches have been upgraded for all supported
architectures.

http://download.gna.org/xenomai/testing/xenomai-2.5-rc3.tar.bz2

Gilles Chanteperdrix (16):
      native: increase user-space native skin default stack size.
      build: Do not compile with __thread by default on ARM
      arm: fix syscalls with gcc 4.3.2
      testsuite: fix division routines unit test feature macro test (for nodiv_llimd).
      maint: fix the extract-doc script to work with git
      posix: Fix user-space migration after pthread_mutex_trylock succeeds
      bind: avoid multiple initialisation of pthread_keys.
      trivial: Remove empty line
      testsuite: Fix mutex-torture-posix compilation, implement check_current_mode
      posix: do not declare pthread_mutexattr_setprotocol if already declared by the glibc
      arm: only enable I-pipe preemptible switch if UNLOCKED_SWITCH is enabled
      posix: fix shm leak
      Fix quotient and remainder after pseudo-division.
      arm: map all heaps with XNARCH_SHARED_HEAP_FLAGS to avoid cache aliasing issues
      timeconv: Fix xnarch_ns_to_tsc in the mulshft && !nodiv case
      arm: disable Xscale fpu switching code

Graf Yang (1):
      Blackfin: Update __sched_latency for blackfin processors (Resend)

Jan Kiszka (5):
      comedi: Fix build breakage due to typos
      posix: Fix build warning with dlopen support enabled
      native: Align documentation to code
      x86-64: Work around gcc issues with populating syscall registers
      x86: Merge syscall_{32|64}.h into syscall.h

Matteo Facchinetti (1):
      rtcan: fix MPC5xxx_GPIO definition for 2.6.2[0-4] kernels

Philippe Gerum (73):
      x86: upgrade I-pipe to 2.6.29.5-x86-2.4-02
      arith: export xnarch_divrem_billion() to modules
      x86: fix wrap_switch_iobitmap() for 2.6.30
      wrappers: remove code related to former IRQ shield
      x86: upgrade I-pipe support to 2.6.30-x86-2.4-03
      x86: remove now useless I/O bitmap switch code
      x86: upgrade I-pipe support to 2.6.30-x86-2.4-04
      x86: upgrade I-pipe support to 2.6.30-x86-2.4-04 - fix
      nucleus: remove leftovers
      Merge commit 'jan'
      powerpc: init FPU for userland Xenomai threads as well
      powerpc: discard useless backup field
      powerpc: fix fpu backup area layout
      nucleus: fix potential init race of the main pod
      powerpc: sanitize kthread init stack setup
      native: force no more than PTHREAD_STACK_MIN bytes for stack size
      powerpc: enable FE0/FE1 exceptions during fpu init
      powerpc: flip FE0/FE1 when saving/restoring the FPU in RT mode
      nucleus: do not dereference thread memory after deletion
      nucleus: use larger default sizes for heap and stack pool
      powerpc: reserve stack overhead in kthread trampoline
      powerpc: sanitize FPU handling helpers
      testsuite: do not specify stack sizes lower than PTHREAD_STACK_MIN
      testsuite: allow multiple switchtest instances to run concurrently
      testsuite: add missing compiler barriers to switchtest
      x86: fix 2.6.30 build in 32bit mode
      x86: upgrade I-pipe support to 2.6.30-x86-2.4-05
      arm: upgrade I-pipe support to 2.6.28-arm-1.12-03
      arm: upgrade I-pipe support to 2.6.29-arm-1.13-01
      powerpc: upgrade I-pipe support to 2.6.30-powerpc-2.6-03
      powerpc: upgrade legacy I-pipe support to 2.4.25-ppc-2.1-00
      powerpc: align preemptible switch tunable with latest I-pipe support
      powerpc: upgrade I-pipe support to 2.6.30-powerpc-2.7-00
      Merge branch 'for-upstream' from git://xenomai.org/xenomai-jki.git
      native: fix fast path in rt_buffer_write_inner()
      sim: inline xnarch_divrem_billion() to avoid multiple definitions
      native: introduce lockless data copy to/from buffers
      native: fix and complete buffer documentation
      native: alloc host memory for buffers
      nucleus: introduce unique id tags for threads
      nucleus: introduce buffer descriptors
      native: rework buffer IPC to optimize data transfers
      build: bootstrap
      nucleus: fix and update bufd documentation
      nucleus, skins: always compile in the registry support.
      blackfin: upgrade I-pipe support to 2.6.30-1.11-00
      build: update default config frags for 2.4 kernel series
      asm-generic: stop using deprecated find_task_by_pid_type_ns()
      blackfin: do not consider IPEND[4] for scheduling deferral
      powerpc: reinstate FE0/FE1 depending on the per-task fpexc_mode
      doc: fix generation script
      powerpc: do not leak MSR_FP when back to secondary mode
      powerpc: upgrade legacy I-pipe support to 2.4.25-ppc-2.2-01
      nucleus: trap wrong interrupt state upon return from hardening
      nucleus: postpone sanity check to allow for signal receipt
      nucleus: rework sanity check to allow for unlocked switching
      sim: provide irqs_disabled_hw()
      x86_64: disambiguate instruction size
      native: fix doxygen info
      scripts: use default autoconf version
      doc: regenerate documentation
      doc: rebuild with graphviz/dot support
      arm: upgrade I-pipe support to 2.6.30-arm-1.14-00, 2.6.28-arm-1.12-04, 2.6.29-arm-1.13-02
      arm: upgrade I-pipe support to 2.6.30-arm-1.14-01
      arm: upgrade I-pipe support to 2.6.30-arm-1.14-02, 2.6.28-arm-1.12-05, 2.6.29-arm-1.13-03
      native: fix (harmless) uninitialized reference
      x86_64: introduce support for CC_STACKPROTECTOR
      powerpc: upgrade legacy I-pipe support to 2.6.20-powerpc-1.9-02
      x86: upgrade I-pipe support to 2.6.30.5-x86-2.4-05
      doc: regenerate documentation
      build: update version stamp
      arm: remove obsolete I-pipe releases
      arm: fix patch name

Stefan Kisdaroczi (1):
      debian: fix kernel patch preparation script not to truncate init/Kconfig

-- 
Philippe.



