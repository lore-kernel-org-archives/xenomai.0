Date: Sat, 9 Jul 2016 15:29:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160709132949.GA22236@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] [Announce] Xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

you will find the latest release in Xenomai 2.6 branch here:
https://xenomai.org/downloads/xenomai/stable/xenomai-2.6.5.tar.bz2

It contains fixes for known bugs in the 2.6.4 release, now almost
two years old, notably:
- a scheduler bug, fixed by commit b03e3d08379f236eb75b34c1b705e127c6e3b2e5
https://git.xenomai.org/xenomai-2.6.git/commit/?id=b03e3d08379f236eb75b34c1b705e127c6e3b2e5
- a bug in ARM VFP support, fixed by commit d4e755b2a9909afb7bbd0a522ff1d97718494cd7
https://git.xenomai.org/xenomai-2.6.git/commit/?id=d4e755b2a9909afb7bbd0a522ff1d97718494cd7

Users of the Xenomai 2.6 branch are encouraged to upgrade. It is
expected to be the last release in the 2.6 branch. It supports all
I-pipe patches up to those for Linux version 3.18. The short log
follows.

Thanks to all contributors.

Gilles Chanteperdrix (45):
      debian: also include the config directory in the xenomai-kernel-source package
      hal: fixups for kernel 3.16
      hal/arm: fixup for Linux 3.16
      posix: fix user-space interrupt syscalls
      hal/arm: simplify fpu handling
      nucleus/registry: initialize vfile structure to 0
      hal/xnlock: also indicate file, line and function in unlock debugging
      can/flexcan: avoid dereferencing clocks twice
      nucleus/timers: fix the timers situation
      posix/clock_host_realtime: fix error handling
      posix: avoid dereferencing user-space address
      autotools: regenerate
      sigdebug: add SIGDEBUG_RESCNT_IMBALANCE
      posix/mutex: handle recursion count completely in user-space
      posix: fix pthread_once
      posix/mutex: avoid warnings
      posix/once: cosmetic fixes
      build: add .gitignore
      nucleus: replace do_munmap with vm_munmap
      nucleus/shadow: avoid tasklist_lock for find_task_by_pid
      hal/powerpc64: fix compilation with I-pipe patches >= 3.18
      nucleus/shadow: fix crash with debugs enabled
      testsuite/cond-torture: increase sleep duration
      testsuite/mutex-torture: increase sleep duration
      testsuite/mutex-torture: avoid race-condition
      nucleus/Kconfig: warn about CONFIG_MIGRATION
      hal/arm: fix VFP support
      testsuite/switchtest: detect more FPU errors.
      x86/fptest: do not use the same value for all the registers
      switchtest: set the registers before switching mode
      hal/x86: forbid compilation with Linux 4.0+
      switchtest: clarify the mode switch
      x86/fptest: add missing asm constraints
      switchtest: align kernel-space fpu register values
      posix/mutex,cond: allow static initializer
      doc: adapt to different installations of asciidoc and doxygen
      doc: fix generate-doc script after removal of docbook documentation
      posix/clock: remove documentation of internal function
      doc/sched: move sched documentation under nucleus section
      bump version number and bootstrap
      hal/arm: update patches
      hal/blackfin: update I-pipe patches
      hal/powerpc: update I-pipe patches
      hal/x86: update I-pipe patches
      doc: regenerate

Jeffrey Melville (2):
      posix/doc: Fix sched_get_priority(min|max) doc
      posix: fix pthread_mutex_timedlock for recursive mutexes.

Jorge Ramirez-Ortiz (2):
      drivers/analogy: fix detach logic
      drivers/analogy: remove unnecessary spinlock

Matthew Lindner (1):
      drivers/can: Properly initialize bittime

Philippe Gerum (14):
      native: fix user-space interrupt syscalls
      hal/arm: add specific calibration value for imx6q
      can/flexcan: fixup for kernel release >= 3.11
      arm/hal: silence C89 warning
      nucleus/pipe: care for spurious wakeups waiting for events
      nucleus: add default calibration value for imx7
      nucleus: fix calibration return for imx7
      nucleus/pod: fix missed rescheduling in SMP
      rtipc/bufp: fix wrong TX timeout
      hal/generic: add backward wrappers for legacy cpu mask ops
      scripts/prepare-kernel: allow building over 4.x kernel series
      ksrc, include: cope with introduction of user_msghdr
      testsuite/xeno-test-run: requesting /bin/sh is enough
      cobalt/x86: fix missing early clobber in asm

Stefan Roese (1):
      hal/arm: Add Zynq v3.14.17 patches

-- 
					    Gilles.

