From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B6574A.1070404@xenomai.org>
Date: Mon, 27 Jul 2015 18:07:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RELEASE] Xenomai 3.0-rc6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <Xenomai@xenomai.org>


We are getting there. This release fixes a couple of bad bugs including a showstopper for some non-POSIX multi-process applications in dual kernel mode, and a few usability issues. The rest is about cleaning up some legacy leftovers. People using earlier Cobalt releases should definitely upgrade.

http://xenomai.org/downloads/xenomai/testing/latest/

Short log follows:

Jan Kiszka (13):
      cobalt/kernel: Rework thread debugging helpers
      cobalt/kernel: Fix locking for setting XNFPU
      cobalt/kernel: Print suspension mask as hex in traces
      testsuite/smokey/leaks: Terminate forked child directly
      cobalt/posix/timer: Set error return codes
      cobalt/kernel: Fix mode of mayday syscall
      cobalt/posix/sem: Do not register named semaphores with process resources
      cobalt/kernel: Mark backtrace syscall as lostage
      cobalt/kernel: Fix locking for xnthread info manipulations
      cobalt/kernel: Set commas in syscall tables inside the macros
      cobalt/kernel: Generate cobalt_syscalls and cobalt_sysmodes
      cobalt/kernel: Remove write-only local variable from handle_schedule_event
      lib/cobalt: Do no install syscall header

Philippe Gerum (52):
      cobalt/thread: fix missed rescheduling in SMP
      cobalt/thread: make xnthread_set_mode() a self-targeted service
      cobalt/arm: add calibration value for LS1021A
      cobalt/thread: generalize usage of ->lock_count for preemption control
      cobalt/thread: introduce local information flags
      cobalt/sched: simplify locking helpers
      cobalt/sched: make scheduler locking lockless
      cobalt/sched: get rid of XNINLOCK scheduler flag
      cobalt/kernel: make most SIGDEBUG notifications depend on XNWARN
      cobalt/kernel: improve handling of user debug options
      cobalt/thread, copperplate: fetch per-thread user window from the global heap
      cobalt/synch: do not serialize around nop code
      cobalt/synch: test information bits as returned by xnsynch_acquire() only
      cobalt/synch: test information bits as returned by xnsynch_sleep_on() only
      rtdm/waitqueue: fix error codes
      testsuite/xeno-test: accept a keep-going option for smokey
      copperplate/threadobj: inline window accessor (cobalt)
      copperplate: deobfuscate private/shared references
      cobalt/x86: fix missing early clobber in asm
      copperplate/threadobj, boilerplate/list: cope with pedantic C++ parsers
      cobalt/kernel: introduce late machine init handler
      cobalt/timer: de-macroize timer list scanners
      boilerplate: provide placeholder for pthread_attr_setaffinity_np()
      boilerplate/ancillaries: add command lookup routine
      copperplate/regd: do command lookup for fusermount/mount
      copperplate/regd: fix duplicate removal of /system tree
      testsuite: assume modern sched_setaffinity() is available
      lib/cobalt: assume CPU_COUNT, CPU_FILL are available
      lib/cobalt: enable application built with large file support
      cobalt: bump ABI revision level
      lib/cobalt: move rt_print_auto_init() to the compat API
      lib/cobalt: stdio: drop redundant cleanup handler
      lib/cobalt: drop "no shadow" binding mode
      lib/cobalt: turn environment variables into options
      lib/cobalt: output sync delay fit in a regular integer
      lib/cobalt: drop weak symbol binding for base options
      boilerplate/init: pull ancillary definitions from init header
      testsuite/latency: do not inherit the main scheduling parameters
      copperplate/registry: force SCHED_OTHER on helper threads
      testsuite/latency: remove redundant mlockall()
      testsuite/switchtest: remove redundant mlockall()
      demo/can-rtt: remove redundant mlockall()
      utils/can: remove redundant mlockall()
      utils/analogy: remove redundant mlockall()
      lib/cobalt: drop dandling declaration
      lib/cobalt: force cleanup of printer loop upon main() exit
      config: bump version code
      doc: prebuild
      cobalt/arm: upgrade I-pipe support
      cobalt/powerpc: upgrade I-pipe support
      trank/rtdm: add placeholder for rt_print_cleanup()
      lib/trank: move RTDK placeholders to the proper file

--
Philippe.


