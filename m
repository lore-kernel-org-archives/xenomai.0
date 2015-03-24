Message-ID: <55114499.7050509@xenomai.org>
Date: Tue, 24 Mar 2015 12:03:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  [RELEASE] Xenomai 3.0-rc4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <Xenomai@xenomai.org>


This release mainly fixes Cobalt issues, in addition to addressing bugs
in the shared session management for Copperplate-based APIs (alchemy,
vxworks and psos currently).

Please note that autoconf-generated files have been dropped from the GIT
repository, so you will have to bootstrap the source tree if you plan to
build from the repo from now on:
see
http://xenomai.org/installing-xenomai-3-x/#Installing_the_Xenomai_libraries_and_tools

3.0-rc4 supports kernel 3.18, for which no I-pipe patches have been
formally released yet; the pipeline code can be obtained from branch
ipipe-3.18 at git://git.xenomai.org/ipipe.git though.

>From that point we will likely go to 3.0 final directly, I don't see any
reason to plan for -rc5.

http://download.gna.org/xenomai/testing/latest/

Short log follows:

Jan Kiszka (9):
      cobalt: Remove unused __xn_success_return
      cobalt/posix/timer: Properly wrap timer_delete syscall handler
      cobalt/posix: Convert syscalls to long return type
      cobalt/posix: Add support for return long values from syscalls
      cobalt/posix/syscall: Exclude sc_cobalt_get_current from debug
warnings
      cobalt/timer: Fix build for kernels < 3.18
      cobalt/procfs: Fix layout of APC header line
      cobalt/posix/sem: Increment semaphore on interrupted sem_wait
      alchemy/sem: Fix nwaiters reported by rt_sem_inquire

Philippe Gerum (80):
      cobalt/x86: exclude %rsp from mayday fixup in long mode
      cobalt/x86: drop %esp from mayday fixup in 32bit mode
      lib/cobalt: lock memory upon deferred init too
      lib/cobalt: control auto-shadowing via __cobalt_no_shadow
      cobalt/thread: send SIGTERM to weak user threads upon cancellation
request
      cobalt: finalize the core control interface
      cobalt/kernel: unify naming of extern data - cobalt_kernel_ppd
      cobalt/kernel: unify naming of extern data - cobalt_machine
      drivers/serial/mpc52xx: fix build issue
      cobalt/kernel: unify naming of extern data - cobalt_pipeline
      cobalt/kernel: unify naming of extern data - cobalt_machine_cpudata
      cobalt/kernel: unify naming of extern data - cobalt_nrthreads
      cobalt/kernel: unify naming of extern data - cobalt_cpu_affinity
      cobalt/kernel: unify naming of extern data - cobalt_heap
      cobalt/kernel: unify naming of extern data - cobalt_vfroot
      cobalt/kernel: unify naming of extern data - cobalt_debug_vfroot
      cobalt/posix: convert 32bit syscalls to long return type
      cobalt/kernel: rebase assertion mechanism on BUG/WARN support
      cobalt/kernel: sanitize usage of internal copy_to/from helpers
      doc/man/autotune: mention static CONFIG_* values for gravity
      cobalt/x86: allow symbolic state names for xenomai.smi
      cobalt/kernel: add back sysfs exposure to parameters
      build: turn on _FORTIFY_SOURCE on --enable-fortify
      autotune: fix build with _FORTIFY_SOURCE > 0
      copperplate/regd: fix build with _FORTIFY_SOURCE > 0
      build: auto-detect fortify support in libc unconditionally
      smokey/sigdebug: account for uclibc lacking clock_nanosleep()
      build: do not set _FORTIFY_SOURCE in autodetect mode
      scripts/prepare-kernel.sh: fix check for supported major kernel
version
      cobalt/intr: catch invalid status from IRQ handlers
      debian/rules: xeno-config also belongs to the base package
      cobalt: fixups for kernel 3.18
      scripts/xeno-config: dump the compiler version with --info
      copperplate/registry: execlp() is pointless with an absolute path
      cobalt/x86: upgrade I-pipe support
      build: make $prefix value available to configure script
      cobalt/x86: upgrade I-pipe support
      copperplate/regd: be resilient in presence of a stale /system tree
      cobalt/timer: fix heap-based timer management
      alchemy: fix internal error handling
      boilerplate/hash: no dependency on address space in shared h-table
      boilerplate/hash: pass opaque arg to table walk handler
      copperplate/cluster: add support for walking a cluster
      copperplate/init: allow pure copperplate-based applications
      copperplate/init: fix shared heap name with default session
      copperplate: drop useless session reset option
      copperplate: fix cluster probe routine
      copperplate: fix synchronization with shared clusters
      utils/hdb: add basic shared heap debugger/viewer
      README: refer to build & run howtos
      cobalt/sched: do not choke on redundant policy setting
      doc/asciidoc: update guides
      copperplate/regd: fall back to umount if fusermount -u failed
      cobalt/posix/process: move global thread list out of kqueue container
      cobalt/posix: cleanup reclaiming of process-local objects
      cobalt/posix: group init work
      cobalt/posix/process: introduce resource management API
      cobalt/posix/cond: use resource management API
      cobalt/posix/mutex: use resource management API
      cobalt/posix/event: use resource management API
      cobalt/posix/monitor: use resource management API
      cobalt/posix/sem: use resource management API
      include/trank: add C bindings
      cobalt/arm: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      cobalt/blackfin: upgrade I-pipe support
      cobalt/x86: upgrade I-pipe support
      cobalt/posix/mutex: fix release of shared state to UMM heap
      demo/altency: allow for longer thread names
      copperplate/registry: shorten sync delay with sysregd
      copperplate/regd: drop references to stale threads in sysgroup
      copperplate/heapobj: use per-process heap for anon sessions
      copperplate/registry: disambiguate socket usage
      build: drop autoconf-generated files
      copperplate/registry: move anon sessions under the user tree
      config: bump core version
      cobalt: bump ABI revision level
      doc/asciidoc: update guides
      copperplate/registry: fix build issue with non-wrapped symbol
      doc/asciidoc: update guides

--
Philippe.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai


