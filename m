Message-ID: <4FFC89CA.70809@xenomai.org>
Date: Tue, 10 Jul 2012 22:00:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [Announce] Xenomai v2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <Xenomai@xenomai.org>

Hi,

At long last, please find Xenomai 2.6.1 at the following URL:
http://download.gna.org/xenomai/stable/xenomai-2.6.1.tar.bz2

We have been waiting so long since 2.6.0 that quite a few commits
happened. To try and summarize, we got:
* fixes, there are too many to list there, see the shortlog

* the usual updates of I-pipe patches, the main one being the I-pipe
core 3.2 patch, by Philippe, a much simplified and refactored version
of the Adeos patch.

The complete shortlog follows.
Thanks to all those who have contributed.
Regards.

Christophe Blaess (1):
      tools: fix rtps with NULL name tasks

Paul Janzen (1):
      Mask signals in rt_print:printer_loop()

Fabrice Gasnier (2):
      mpc5121 can: adapt to platform driver infrastructure changes for 2.6.35
      fix mscan init on mpc5121

Wolfgang Grandegger (5):
      rtdm: add rtdm_printk_ratelimited
      serial/16650a: fix missing value in default_config initialization
      serial: add shift register empty event and RS485 support flag
      serial: add driver for the MPC52xx PSC UARTs
      nucleus: fix poll EOF issue with xnpipe/rt_pipe

Jan Kiszka (14):
      nucleus: Privatize __xnpod_reset_thread
      x86: Fire root preemption notifier
      nucleus: Fix relaxed owner check
      mayday: Fix code setup for x86 and blackfin
      Add sigdebug unit test
      Remove obsolete mayday regression test
      native: Interrupt rt_timer_spin syscall on pending signals
      Add dependency of skin libraries on libxenomai
      Only export required CFLAGS via xeno-config
      mq_select: Fix for --enable-dlopen-skins
      Re-apply 2dc4288baba1bb701aeb61c44f12a2115b0aef77
      Append missing newline to rt_[f]puts output
      testsuite: Only use rt_print services in leak test
      Add regression test for mprotect on pinned memory

Philippe Gerum (43):
      native/queue: fix rt_queue_flush()
      nucleus/pod: dequeue kicked threads from any synch wait list
      powerpc: upgrade I-pipe support to 3.0.13-powerpc-2.13-06, ipipe-3.1.5-powerpc-2.13-06
      Merge branch 'master' of ssh+git://xenomai.org/xenomai-2.6
      hal: detect and enable upcoming pipeline core
      x86: upgrade I-pipe support to 2.6.38.8-x86-2.11-01
      hal: don't expect return values from SMP-specific core IRQ routines
      scripts: prepare for upcoming pipeline core series
      hal/powerpc: plug race in thread context switch
      hal/x86: drop wrappers to IPI vectors
      nucleus: drop pointless CPU synchronization upon shutdown
      Revert "hal/x86: drop wrappers to IPI vectors"
      hal, nucleus: introduce support for pipeline core IPIs
      hal: introduce support for mm tracking w/ pipeline core
      nucleus: set as pipeline head w/ pipeline core series
      Merge branch 'master' of ssh+git://xenomai.org/xenomai-2.6
      Merge branch 'keepme'
      nucleus/sched: keep non-rt thread flag unaffected by priority boost
      nucleus, native, psos, vxworks: fix build w/ OPT_PERVASIVE disabled
      Merge branch 'master' of ssh+git://xenomai.org/xenomai-2.6
      hal/powerpc: fixup for refactored timers of pipeline -core series
      nucleus/sched: update scheduling class weights
      nucleus: silence warning
      powerpc: upgrade I-pipe support to 3.1.10-powerpc-2.13-07
      hal/powerpc: fixup for refactored timers (take #2)
      nucleus: enable back PREEMPT_RT support
      hal/powerpc: introduce calibration data for P1022
      nucleus: deprecate priority coupling
      Merge branch 'master' of ssh+git://xenomai.org/xenomai-2.6
      hal/blackfin: fix build enabling refactored timer API
      Merge branch 'master' of ssh+git://xenomai.org/xenomai-2.6
      hal/blackfin: fix build for legacy timer code
      Merge branch 'master' of ssh+git://xenomai.org:2322/xenomai-2.6
      build: fix up for autoconf 2.68, automake 1.11.3, libtool 2.4.2
      hal/x86_64: fix build over legacy pipeline
      x86: fix mayday support in 32bit+SEP mode
      build/x86: assume x86-sep available by default
      hal/generic: enable/fix threaded APC with PREEMPT_RT
      hal/powerpc: fix build over legacy 2.4 kernel
      Merge branch 'master' of git://xenomai.org/xenomai-2.6
      powerpc: upgrade I-pipe support to 2.6.36.4-powerpc-2.12-05, 3.1.10-powerpc-2.13-08
      powerpc: remove obsolete ipipe-3.0.13-powerpc-2.13-06
      blackfin: remove obsolete ipipe-2.6.34-blackfin-1.15-01

Gilles Chanteperdrix (78):
      posix: fix compilation for LFS
      testsuite: install regression testsuite with other tests
      rtdk/posix: implement fwrite
      posix: fix pthread_mutex_trylock in FASTSYNCH case
      x86: compile user-space with frame pointers
      posix: add forward declaration of struct sched_param_ex
      examples: fix compilation issues
      examples: fix compilation with kernel 3.0
      tests: global exit using exit() instead of rt_task_delete()
      arm: no known SOC supports SMP with pre-v6 architecture, forbid this option
      arm: clarify README.INSTALL
      arm: clarify README.INSTALL again
      rt_print: wait for first initialization before spanwning rt_print thread
      nucleus: fix switchback with explicit migration
      posix: fix linux-side posix threads priority
      testsuite: add auto-switchback feature test
      xeno-test: use monotonic time
      x86: remove old adeos patch
      arm: upgrade adeos patches
      posix: avoid kernel oops
      arm: add support for imx6q to mxc patches
      arm: fix heaps pre-faulting with kernel newer than 2.6.22
      nucleus: do not touch XNOTHER bit for threads under PIP boost
      arm: fix mayday assembly
      bootstrap
      debug: enable the relaxed owner check by default
      testsuite: get the sigdebug test running on ARM
      testsuite: run sigdebug instead of mayday in regression test script
      testsuite: test auto-switchback feature better
      arm: upgrade adeos patches
      arm: (re)fix OABI mayday code
      posix: fix pthread_mutex_trylock in XNOTHER case
      posix: cosmetic fixes in src/skins/posix/mutex.c
      posix: use wrap-link.sh to link posix tests
      bootstrap
      Revert 7c601b91f218d05bf6c243469cc21c97ae2d237c
      Revert 2dc4288baba1bb701aeb61c44f12a2115b0aef77
      testsuite: fix mq_select in the auto-shadowing case
      Fix previous change
      arm: adapt to ipipe core 3.2
      arm: forcibly select unlocked context switches when SMP is enabled
      arm: optimize tsc emulation
      hal: unregister virq handler before freeing virq
      arm: add suppport for spear6xx
      common/rt_print: mask all signals for logging thread
      scripts: fix extract-doc, git-clone no longer exists
      hal/arm: support new type of tsc (spear tsc)
      rt_print: add support for fputc and putchar
      hal/arm: fixup for refactored timers
      testsuite: try running clocktest with CLOCK_HOST_REALTIME
      nucleus: get CLOCK_HOSTRT working with ipipe-core
      hal/blackfin: fixup for refactored timers
      arm: upgrade I-pipe support to 3.0.13-arm-1.18-08
      hal/arm: fix compilation in the non ipipe-core case
      hal/arm: use a more sensible timer load value for calibration
      arm: upgrade mxc I-pipe support to 3.0.13-arm-1.18-08
      hal/arm: support backport of linux 3.2 VFP fixes
      posix: fix build with LFS flags on 64 bits platform
      wrappers: avoid warning due to CONFIG_PREEMPT_RT
      hal/x86: fixup for refactored timers
      testsuite: add latency options and gnuplot script to generate histograms
      posix: get pthread_set_name_np to set linux thread name too
      mayday: fix xnshadow_sys_mayday return value
      hal/x86 adapt to newer kernels where TS_USEDFPU was replaced
      doc: change mailing lists address
      hal/x86: warn user when using a kernel without tsc on a cpu with tsc
      hal/arm: update adeos patches
      x86: only compile xenomai libraries with frame pointers enabled
      posix: fix nanosleep when interrupted by a signal
      testsuite: add nanosleep regression test
      testsuite: fix x86 compilation issues in nanosleep test
      build: only enable frame pointers on x86_32
      testsuite/nano_test: do not assume auto-shadowing of the maint thread
      doc: fix various doxygen warnings
      nucleus/vfile: avoid buffer overflow
      doc: use the more complete server based search engine
      hal: upgrade adeos patches with ipipe-core patches
      build: bump version number and bootstrap
      documentation: regenerate

-- 
                                                                Gilles.

