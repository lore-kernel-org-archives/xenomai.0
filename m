Message-ID: <50F05652.4000002@siemens.com>
Date: Fri, 11 Jan 2013 19:13:38 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PREVIEW] x86/ipipe queue for 3.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

at

    git://git.xenomai.org/ipipe-jki for-upstream/3.5

I've lined up our current x86 queue for I-pipe core-3.5. We are not yet
fully done with testing, I'd specifically like to give x86-32 a final
kick, so this is just a heads-up. The queue got a bit long:

Jan Kiszka (23):
      ipipe: Rework and simplify __ipipe_pin_vma
      ipipe: Fault in locked vmas after changing the protection flags
# critical fix for zero-page corruption after mprotect,
# actually affecting all mmu-archs

      x86/ipipe: Fix registration of IRQ work vector
      ipipe: Add root domain guard to preempt_schedule
      ipipe: Make context in add/sub_preempt_count conditional
      ipipe: Harden clocks used by ftrace and perf
      ipipe: Harden ftrace function and function-graph tracer
      ipipe: Harden trace_vbprintk for non-root use
      x86/ipipe: Prevent copy_from_user_nmi over non-root domains
      x86/ipipe: x86_64 provides context-agnostic current_thread_info
# ftrace and perf support, tested on x86-64 only,
# some bits may work on other archs too
# Note: I didn't follow the ipipe_safe_preempt_* path but rather disable
# preempt_count instrumentation selectively now. I think this is more
# appropriate given that the issue is only legacy related.

      x86/ipipe: Disallow transparent huge pages when I-pipe is active
# if you copy a distro .config, this can bite you... (we need to account for THP later)

      ipipe: Allow raw_spin_is_locked for I-pipe spin locks
      ipipe: Provide hardened probe_kernel_read/write for kgdb-over-I-pipe
      x86/ipipe: Implement arch-specific probe_kernel_read/write support
      x86/ipipe: Call kgdb_handle_exception over any domain in __ipipe_divert_exception
      x86/ipipe: Drop kgdb exception hook from from __ipipe_handle_exception
      ipipe: Harden generic part of kgdb for I-pipe use
      x86/ipipe: Harden kgdb for I-pipe use
      x86/ipipe: Fix kgdb hook invocation from __ipipe_divert_exception
# kgdb for x86 (tested on -64 only), may lay the ground for other archs too

      x86/ipipe: Add missing local_irq_enable on canceled vmentry
      ipipe: Fix IPIPE_HAVE_VM_NOTIFIER config option
      ipipe: Only compile __ipipe_notify_vm_preemption when needed
      ipipe: Relax context check for accessing vm_notifier in KVM callbacks
# get KVM working again on x86-64 (x86-32 is not recommended, even with vanilla)

 arch/x86/Kconfig                     |    1 +
 arch/x86/include/asm/hw_irq.h        |    2 +-
 arch/x86/kernel/ipipe.c              |   88 ++++++++++++++-------------------
 arch/x86/kernel/kgdb.c               |   24 +++++----
 arch/x86/kvm/x86.c                   |    1 +
 arch/x86/lib/usercopy.c              |    2 +-
 include/linux/ipipe.h                |   12 ++++-
 include/linux/ipipe_base.h           |    9 ++++
 include/linux/preempt.h              |    4 +-
 include/linux/spinlock.h             |    4 +-
 kernel/debug/debug_core.c            |   32 +++++++-----
 kernel/debug/gdbstub.c               |    6 +-
 kernel/ipipe/Kconfig                 |    6 ++
 kernel/ipipe/core.c                  |   39 +++++++++++++++
 kernel/sched/clock.c                 |   10 ++--
 kernel/sched/core.c                  |    5 +-
 kernel/trace/trace.c                 |    6 +-
 kernel/trace/trace_clock.c           |    4 +-
 kernel/trace/trace_functions.c       |    8 ++--
 kernel/trace/trace_functions_graph.c |    8 ++--
 mm/Kconfig                           |    1 +
 mm/memory.c                          |   79 ------------------------------
 mm/mlock.c                           |   18 +++++++
 mm/mprotect.c                        |   36 +++-----------
 24 files changed, 193 insertions(+), 212 deletions(-)

If there is time, please have a look, specifically at generic bits. Once
testing is done and there are no remarks, I'll send a pull request.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

