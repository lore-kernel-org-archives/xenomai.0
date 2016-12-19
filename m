From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eecc7588-b50f-e6b3-4a5b-a398d8134e78@siemens.com>
Date: Mon, 19 Dec 2016 19:03:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe: 4.4 fixes for x86 and tracer,
	update to 4.4.37
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

The following changes since commit 8121a3aca1742df09940f29b24ebee291481c1ef:

  ipipe: do not read irq_desc[] out of bounds with virqs (2016-11-25 17:11:39 +0100)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/4.4

for you to fetch changes up to b0499d6f230268b60b44ccc2dcacee8a30cd4e62:

  Merge tag 'v4.4.37' into for-upstream/4.4 (2016-12-09 19:46:32 +0100)

As noted earlier, we missed some x86 patches from releases > 3.14. I
think I found them all.

Note: The 4.4.37 merge was not tested on archs!=x86.

Jan

----------------------------------------------------------------
[leaving out the merge part in the stats]

Jan Kiszka (11):
      x86/ipipe: Skip lockdep check for vector_lock under I-pipe
      x86/ipipe: Always leave do_syscall_32_irqs_on with hard irqs disabled
      x86/ipipe: Maintain Linux IRQ tracing in enable/disable_local_irqs
      x86/ipipe: Fix DEBUG_LOCKS instrumentation of load_mm_ldt
      x86/ipipe: Fix root state on return from certain exceptions
      ipipe: Remove stray tabs from tracer output
      ipipe: Do not trace Linux irqs over the head domain
      x86/ipipe: Remove unneeded !CONFIG_IPIPE guard around TRACE_IRQS_OFF
      x86/ipipe: Resync exception handling with ipipe-3.14
      ipipe: Extend root domain guard to preempt_schedule_notrace
      Merge tag 'v4.4.37' into for-upstream/4.4

 arch/x86/entry/common.c            | 16 ++++++++++++----
 arch/x86/entry/entry_64.S          |  3 +--
 arch/x86/include/asm/ipipe.h       | 20 +++++++++++++++++---
 arch/x86/include/asm/mmu_context.h |  3 ++-
 arch/x86/kernel/apic/vector.c      |  2 ++
 arch/x86/kernel/ipipe.c            | 83 +++++++++++++++++++++++++++++++----------------------------------------------------
 arch/x86/kernel/traps.c            | 11 ++++++++++-
 kernel/ipipe/tracer.c              |  4 ++--
 kernel/locking/lockdep.c           | 10 +++++++++-
 kernel/sched/core.c                |  2 +-
 kernel/trace/trace_irqsoff.c       |  8 ++++----
 11 files changed, 91 insertions(+), 71 deletions(-)

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

