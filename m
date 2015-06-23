Message-ID: <558993D6.8080108@xenomai.org>
Date: Tue, 23 Jun 2015 19:13:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RELEASE] Xenomai 3.0-rc5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <Xenomai@xenomai.org>


Unlike originally planned, this is -rc5. We merged way too many changes
and important fixes since -rc4 for going final directly.

http://xenomai.org/downloads/xenomai/testing/latest/

Please test. Once done, please do it again. You know where to complain.

Thanks,

Short log follows:

Frederik Bayart (1):
      debian: drop xeno-config from -dev package

Gilles Chanteperdrix (6):
      build: drop more autoconf-generated files
      rtnet: forbid built-in rtnet
      rtnet: initialize rtdm_driver device_count member
      cobalt/mutex,cond: allow static initializer
      smokey/mutex-torture: test mutex initializers
      rtnet: fix alloc_netdev arguments after Linux 3.17

Henning Schild (1):
      debian: remove xeno-config from libxenomai-dev package

Jan Kiszka (9):
      lib/cobalt: Remove unused COBALT_DECLs
      demo/posix: can-rtt: Remove stack size adjustment
      lib/cobalt: Remove minimum stack adjustment
      lib/cobalt: Fault in PTHREAD_STACK_MIN for the main thread
      lib/cobalt: Introduce and use COBALT_STACKSIZE_DEFAULT
      lib/cobalt: Set default stack size via wrapping pthread_attr_init
      cobalt/x86: Fix 32-bit thread switch with stack protector on
      cobalt/synch: Remove bogus XENO_BUG_ON
      Create .gitignore for autotools files

Jorge Ramirez-Ortiz (1):
      drivers/udd: fix Makefile

Philippe Gerum (138):
      cobalt/posix: fix potential race when reclaiming global resources
      boilerplate/ancillaries: fix off-by-one index in name generator
      psos/task: use name generator for anon tasks
      vxworks/task: use name generator for anon tasks
      cobalt/kernel: drop pointless parameter descriptions
      demo/altency: set default affinity to CPU0
      testsuite/latency: set default affinity to CPU0
      copperplate/clockobj: drop useless name property
      copperplate/init: trap invalid session name early
      cobalt/kernel: pair debug options with pipeline debug features
      doc: drop @file markup from files with no documentation
      smokey/bufp: test POLLOUT support
      testsuite/smokey: skip tests lacking kernel support
      smokey: use real-time printf wrapper for output
      smokey: fix parsing of boolean args
      testsuite/smokey: adapt/fix sigdebug for Cobalt
      scripts/xeno-config: do not wrap POSIX symbols with --cobalt
      doc/man1: update xeno-config manpage
      cobalt/kernel: fix circular dependency in Kconfig
      vxworks: make FUNCPTR ISO-C definition more generic
      drivers/udd: fix documentation
      cobalt/timerfd: save a redundant range check in copy to user
      build: enable automake silent mode
      doc: prebuild
      drivers/udd: fix mapper device supporting multiple regions
      vxworks: add task hook services
      vxworks: add memPartInfoGet() service
      scripts/prepare-kernel.sh: add Xenomai-specific include directives
      drivers/udd: add sync mode to IRQ enable/disable requests
      include/rtdm: add rtdm/udd.h interface file
      boilerplate: silence config dump
      rtdm/irq: clarify documentation about masking/unmasking
      drivers/udd: fix the IRQ enable/disable API
      boilerplate: drop useless library version info
      cobalt/kernel: fix infinite recursion in Kconfig
      alchemy/testsuite: add multi-heap test
      scripts/xeno-config: make command switches position-independent
      copperplate/threadobj: prevent priority inversion in
threadobj_cancel()
      cobalt/synch: un-inline xnsynch_destroy()
      drivers/udd: no generic mask/unmask for custom IRQs
      drivers/udd: custom IRQs do not require UDD handler
      copperplate/clockobj: add missing explicit C bindings
      lib: move early setup code to the boilerplate layer
      lib: share the common setup and bootstrap code
      boilerplate/setup, utils, testsuite: enable application help strings
      copperplate/regd: probe for umount command
      boilerplate, copperplate: introduce API to manipulate tunables
      boilerplate/setup: add tuning step in setup process
      doc/man/autotune: fix documentation of --quiet option
      boilerplate/setup: output version stamp on --dump-config
      boilerplate/setup: introduce application_version() hook
      copperplate/registry: restore --shared-registry option
      boilerplate/setup: add user-specific run level
      boilerplate/setup: sanitize verbosity option handling
      cobalt/mutex, lib/cobalt: detect attempts to sleep while holding a
mutex
      lib/cobalt/debug: do not force exit on recoverable errors
      copperplate/heapobj-malloc: fix locking
      copperplate/timerobj: do not hold any mutex while intentionally
sleeping
      vxworks/testsuite: fix FUNCPTR targets
      cobalt/process: drop extraneous barriers
      psos: turn long names options into a standard tunable
      cobalt/pipe: care for spurious wakeups waiting for events
      cobalt/synch: fix return value upon release imbalance
      cobalt/synch: restrict imbalance signal to debug mode
      cobalt/kernel: increase default size of UMM areas to 64k
      copperplate/heapobj: fix build issue
      boilerplate, copperplate: fix syncluster with remote sync (pshared)
      alchemy/buffer: fix for remote requests (pshared)
      alchemy/heap: fix for remote requests (pshared)
      alchemy/queue: fix for remote requests (pshared)
      psos/queue: fix for remote requests (pshared)
      psos/rn: fix for remote requests (pshared)
      vxworks/queue: fix for remote requests (pshared)
      alchemy/task: fix for remote messages (pshared)
      copperplate/traceobj: add helpers for checking a status
      include: move version.h to xenomai/ subdir
      lib/cobalt: fix error status
      utils/slackspot: fix format strings for C99
      build: fix distcheck
      cobalt/kernel: add default calibration value for imx7
      copperplate: fix source list
      lib/cobalt: export service for reading the high resolution clock
      build: drop obsolete ARM switches
      testsuite/latency: dump configuration data along with gnuplot output
      boilerplate/list: rename to listobj (avoid conflict with STL)
      boilerplate/pvlist: rename to pvlistobj (for consistency)
      copperplate/reference: register function exports at early init
      testsuite/latency: dump main stats along with gnuplot output
      copperplate/clockobj: use proper type for clock ticks
      cobalt/arm: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      doc: fix documentation glitches
      config: bump UAPI level
      config: bump version code
      doc: regenerate documentation
      doc: give pointers about building from sources
      testsuite: add missing licensing terms
      kernel/cobalt: add missing licensing terms
      testsuite/xeno-test: fix clock id for HOST_REALTIME
      utils/analogy: add missing licensing terms
      demo/posix/cobalt: add missing licensing terms
      kernel, lib, include: add/fixup default license files
      cobalt/clock: output external clock id to vfile
      testsuite/clocktest: accept clock names with -C
      testsuite/xeno-test: pass clock names to clocktest
      copperplate/heapobj: fix references to shared pool
      copperplate: fix naming conflict with C++ access modifiers
      copperplate/heapobj: give unshadowed main thread a large wait_union
      include/trank: fix inclusion guard
      alchemy/heap: remove restriction on tiny heaps
      alchemy/heap: clarify documentation of RT_HEAP_INFO
      copperplate/heapobj: make heapobj_size() return the effective size
      lib/smokey: add warning and assertion helpers
      testsuite/smokey: add POSIX clock testing code
      lib/smokey, testsuite/smokey: issue terminating newline on
note/warning
      testsuite/smokey: rename POSIX tests consistently
      testsuite/smokey: fix return code in quiet mode
      testsuite/smokey: add POSIX select testing code
      lib/smokey: add trace helper
      testsuite/smokey: add timerfd testing code
      testsuite/smokey: convert notes to traces when appropriate
      testsuite/smokey: add leakage detection test
      testsuite/smokey/arith: tame down verbosity at default level
      testsuite/smokey: convert progress messages to smokey traces
      copperplate/heapobj-malloc: fix usage tracking
      alchemy/testsuite: use traceobj_check() when applicable
      alchemy/testsuite/task-2: drop extraneous tracepoint
      alchemy/heap: document rounding of large block sizes
      smokey/rtdm: detect absence of test module
      doc/prebuild: serialize asciidoc icons/callouts generation
      doc: regenerate documentation
      doc: hint about licensing terms
      cobalt/udd: fix documentation
      scripts/xeno-config: fix include directives for compat mode
      doc: use http in URLs
      doc: regenerate documentation

--
Philippe.


