From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5701203A.6030209@xenomai.org>
Date: Sun, 3 Apr 2016 15:52:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RELEASE] Xenomai 3.0.2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


http://xenomai.org/downloads/xenomai/stable/latest/

Upgrade from 3.0.1 or earlier is recommended. Short log follows:

Gilles Chanteperdrix (34):
      smokey/tsc: remove redundant line breaks
      testsuite/smokey: tsc: shorten default duration
      drivers/rtnet: hide configuration options if globally disabled
      drivers/rtnet: forbid removing the rtnet module
      drivers/rtnet: fix loopback
      drivers/rtnet: refuse to uselessly queue packets
      drivers/rtnet: fix SIOCGIFNAME ioctl
      rtnet/ioctl: allow checking link state
      drivers/rtnet: upgrade igb driver
      cobalt/rtnet: tdma: remove deprecated construct
      cobalt/rtnet: e1000e: fix compilation warnings
      cobalt/wrappers: add wrappers for igb driver
      cobalt/rtnet: igb: fix compilation issues
      cobalt/rtnet: smc91111: fix compilation warnings
      cobalt/wrappers: reverse wrappers order (latest kernel release first)
      cobalt/wrappers: move get_current_uid() to ancillaries.h
      testsuite/switchtest: fix mode switches
      lib/cobalt: mutex: avoid compiler error
      cobalt/fpu: stall head domain to handle fpu fault
      cobalt/arm: remove redundant change of irq mask
      cobalt/x86: remove redundant change of irq mask
      cobalt/arm: remove unused variable
      cobalt/timer: avoid early tick in case of overrun
      rtnet/rtcfg: fix for Linux 4.1
      cobalt/rtnet: IGB driver requires I2C support
      testsuite/xeno-test: add -r option
      cobalt/x86: FPU fixes for Linux 4.1
      cobalt/corectl: allow retrieving RTnet configuration
      smokey: align Makefile on next branch
      testsuite/smokey: add RTnet testsuite
      testsuite/smokey: add RTnet raw packets test
      smokey/net: add missing file to distributed tarball
      drivers/net: move corectl to net drivers directory
      cobalt/config: disallow page migration

Jan Kiszka (8):
      lib/cobalt: Mark __cobalt_print_bufsz weak
      cobalt/intr: Fix unhandled interrupt detection
      cobalt/x86: Fix strncpy_from_user_nocheck for SMAP-enabled systems
      cobalt/kernel: Fix invalidation of cond shadow
      cobalt/posix/timer: Allow extension to override timer_gettimeout value
      cobalt/posix/timer: Remove redundant test for stopped timers
      cobalt/posix/timer: Return interval value also for stopped timers
      cobalt/timer: Make xntimer_get_overruns robust against stopped timers

Philippe Gerum (104):
      cobalt/kernel: fixup for v3.19+ (user_msghdr)
      cobalt/kernel: fixup for v3.19+ (trace_seq)
      lib/cobalt: add details about failing init step
      cobalt/posix/thread: fix failure code upon missing u_window
      smokey/sigdebug: fix probe for watchdog
      cobalt/posix/process: fix mayday mapping denial on NOMMU
      smokey/sigdebug: use mapping also compatible with NOMMU
      smokey: provide trace helper with variadic arglist
      include/boilerplate, lib: do not pull ancillaries.h indirectly
      cobalt/wrappers: fix backport prefix
      cobalt/kernel: fixup for v3.19+ (user_msghdr)
      cobalt/kernel: fixup for v4.1+ (TRACE_SYSTEM)
      cobalt/kernel: convert to current cpumask operators
      cobalt/assert: introduce SMP-specific WARN/BUG assertions
      cobalt/clock: introduce CPU affinity for clock event sources
      cobalt: select pipeline API revision 2 explicitly
      cobalt/corectl: move implementation to separate file
      cobalt/corectl: chain config requests to external subsystems
      copperplate/threadobj: fixup run state upon threadobj_wait_period()
      copperplate/threadobj: mercury: fix stat call (CPU number)
      copperplate/registry: handle bad stat reading in system/threads
      drivers/switchtest: stop timers before releasing task data
      cobalt/intr: remove unused label
      Revert "cobalt/intr: remove unused label"
      boilerplate/libc: fix detection of mutex protocols
      boilerplate/scope: add helpers for nullable reference
      alchemy/heap: handle nullable references properly
      psos/rn: handle nullable references properly
      alchemy/queue: care for messages crossing address spaces
      alchemy/queue: disable buffer-to-buffer transfer in broadcast mode
      lib/boilerplate: add --trace to the base option set
      lib/cobalt: add init trace points
      smokey/net: provide ETH_P_802_EX1 for outdated libc
      drivers/autotune: track gravit limit in progress messages
      drivers/ipc/xddp: fixup allocation rounding for tiny private pool
sizes
      cobalt/clock: display external clock id. in procfs
      cobalt/sched: fix timeout display in thread-related procfs information
      cobalt/clock: use proper reference clock for periodic timings
      cobalt/clock: add helper to change resolution
      cobalt/timer: fix handling of late arrival on first periodic delivery
      copperplate/traceobj: not all return values are status codes
      copperplate/threadobj: fix status returned by threadobj_sleep()
      copperplate/syncobj: fix race in aborted wait_grant/drain operations
      cobalt/registry: return -EAGAIN upon lack of registry slot
      doc/rtdm: work around Doxygen weirdness
      doc: prebuild
      testsuite/smokey: mutex: fix centralized init
      lib/smokey: add barrier support helpers
      lib/cobalt/thread: fix unwanted relax spot in pthread_create()
      debian/doc: switch mailing list URL to https
      lib/smokey: add common assertion helpers
      lib/smokey: add --exclude switch for dropping tests from the run list
      boilerplate: more helpers to retrieve various CPU information
      lib/smokey: add timed wait on barrier
      drivers/ipc: bufp: fix wrong TX timeout
      drivers/testing: rtdm: add actor task device
      testsuite/smokey: add test checking Cobalt's cpu affinity control
      testsuite/smokey: cpu-affinity: silence unused_result warning
      cobalt/arm: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/init: get main heap memory from vmalloc()
      cobalt/posix/mqueue: get buffer memory from vmalloc()
      cobalt/posix/signal: get buffer memory from vmalloc()
      drivers/ipc: bufp: get buffer memory from vmalloc()
      drivers/ipc: iddp: get buffer memory from vmalloc()
      drivers/ipc: xddp: get buffer memory from vmalloc()
      lib/smokey: init: fix regression introduced by #9489274
      cobalt/heap: export *vmalloc helpers
      cobalt/thread: do not demote kthreads when cancelling
      cobalt/thread: force secondary mode for joining threads
      cobalt/thread: fix SMP race with xnthread_join()
      cobalt/timer: allow binding core timers to passive CPUs
      cobalt/thread: wait for RCU grace period after killall
      cobalt/posix/corectl: clarify argument types for mixed ABI support
      utils/corectl: fix handling of argument to --stop (grace period)
      cobalt/kernel: use standard accessor to global pid
      cobalt/powerpc: upgrade I-pipe support
      config: bump version code
      doc: prebuild
      cobalt/wrappers: add wrapper for reinit_completion()
      cobalt/init: get system heap from the normal zone
      cobalt/umm: get UMM heaps from the normal zone
      cobalt/kernel: raise default sysheap size to 512 Kb
      cobalt/arm: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      cobalt/thread: fix join request handling from non-Xenomai context
      lib/cobalt: clear u_window when releasing TSD
      lib/cobalt: simplify checks for secondary mode
      include/boilerplate: add shorthand for deprecated calls
      utils/autotune: protect against SIGHUP in background mode
      cobalt/arm: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      cobalt/arm: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      cobalt/config: relax requirement on CONFIG_MIGRATION
      cobalt/arm: upgrade I-pipe support

-- 
Philippe.

