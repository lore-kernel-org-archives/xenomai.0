From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <72ff078f-2cee-9ca9-8834-e2c8988c2ae8@xenomai.org>
Date: Sun, 11 Sep 2016 12:38:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RELEASE] Xenomai 3.0.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Xenomai 3.0.3 is out, tagged in the repository [1] and available from
the download area [2].

Changes which stand out address issues in the Cobalt core and
particularly RTDM, in addition to the fixups required for building over
the linux 4.4 series.

Regarding the latter, the interrupt pipeline supporting Cobalt is being
ported to linux 4.4; most architectures look good now, although they
need more testing, except arm64 which I will address later.

Please note that x86* - and to a lesser extent arm - have required
significant updates in core features of the pipeline and/or Xenomai, due
to massive code churn upstream since 4.1, so anything you can do for
helping in testing the pipeline is good for everyone.

[1] git://git.xenomai.org/xenomai-3.git
[2] http://xenomai.org/downloads/xenomai/stable/latest/
[3] git://git.xenomai.org/ipipe.git, branch raw/ipipe-4.4 (may be rebased)

Short log follows:

Gilles Chanteperdrix (1):
      cobalt/timer: replace bheap with rbtree

Jan Kiszka (5):
      cobalt/kernel: Null-terminate cobalt_print_sched_params output
      cobalt/kernel: Fix xntimer_get_timeout_stopped
      cobalt/kernel: Fix infinite loops on thread cleanup
      cobalt/rtdm: Fix driver reference counting
      cobalt/rtdm: Also initialized driver refcount for protocol devices

Philippe Gerum (66):
      alchemy/doc: fix and clarify documentation about calling context
      copperplate/cluster: do not override EPERM code
      copperplate/syncobj: let EPERM condition propagate on cleanup
      alchemy/task: allow calling rt_task_shadow() from a plain POSIX thread
      scripts/xeno-config: catch misusage of --[no-]auto-init
      copperplate/sysregd: fix fall back path to umount
      cobalt/rtdm: allow setting the kernel device class of a driver
      cobalt/rtdm: expose wait_context API from the core threads
      boilerplate/init: track automatic bootstrap mode in --dump-config
      alchemy/queue: fix calculation of metadata overhead
      cobalt/rtdm: allow device paths with multiple components
      cobalt/registry: allow slash in keys without /proc node
      alchemy/queue: allow zero-size message with rt_queue_write()
      testsuite/smokey: include errno dependency explicitly
      cobalt/rtdm: reinit driver magic after unregistration
      cobalt/rtdm: zero-init the private context area
      rtipc/bufp: fix cleanup on binding error
      rtipc/iddp: fix cleanup on binding error
      drivers/ipc/xddp: fix select() support for the real-time endpoint
      include/trank: add missing C bindings
      testsuite/xeno-test-run: requesting /bin/sh is enough
      cobalt/rtdm: allow up to 1024 minors per driver
      cobalt/rtdm: add base minor setting for named drivers
      boilerplate: provide count-leading/trailing-bits ops
      copperplate/heapobj-pshared: introduce allocation bitmap
      copperplate/heapobj-pshared: unlink main heap file on exit if no
registry
      cobalt/rtdm: ignore base_minor setting for protocol devices
      cobalt/rtdm: fix off-by-one error in device_count check
      cobalt/rtdm: add accessor to kernel device struct
      cobalt/rtdm: explain issues with driver registration
      cobalt/thread: fix race on accessing the global thread list
      copperplate/threadobj: mercury: fix error code in corespec_init call
      cobalt/powerpc: cleanup fpu support
      cobalt/kernel: use raw_spinlock* API to access IRQ pipeline locks
      cobalt/powerpc: add calibration value for CoreNet-based boards
      cobalt/signal: fix error code in kill() routine
      cobalt/powerpc: remove dependency on obsolete CONFIG_MATH_EMU
      cobalt/powerpc: fptest: include missing header
      cobalt/timer: prevent double dequeuing in overrun handler
      cobalt/syscalls: allow for handing over mode selection to syscall
handlers
      cobalt/rtdm: leave mode selection to I/O syscall handlers
      drivers/testing: drop unused context marker
      drivers/testing: add test helpers for mode switch handover
      testsuite/smokey: rtdm: add handover test
      cobalt/clock: add limited support for handling frequency updates
      cobalt/timer: guard against invalid calls to get_overruns()
      cobalt/process: fix build warning (missing CLOCKFREQ event)
      drivers/ipc: fix potential race in select()
      boilerplate: allow for auto-init of external shared libraries
      cobalt/kernel: stop using deprecated set_cpus_allowed()
      cobalt/thread: drop obsolete release_fpu() helper
      cobalt/powerpc: fpu: drop obsolete xnarch_save_fpu()
      cobalt/blackfin: fpu: drop obsolete xnarch_save_fpu()
      cobalt/arm: fpu: drop obsolete xnarch_save_fpu()
      cobalt/x86: fpu: drop obsolete xnarch_save_fpu()
      cobalt/x86: fpu: fixup for kernel 4.2+
      cobalt/arm: thread: move all TCB initializers out of line
      cobalt/powerpc: thread: move all TCB initializers out of line
      cobalt/arm: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      doc/man: xeno-config: document --auto-init-solib
      drivers/udd: fix profile information
      config: bump version code
      doc: prebuild

-- 
Philippe.

