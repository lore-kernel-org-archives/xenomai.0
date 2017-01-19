References: <eecc7588-b50f-e6b3-4a5b-a398d8134e78@siemens.com>
 <5bfef037-0efb-f82e-f036-5150a1f50ba0@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bc8ad741-937c-d93a-8533-497cdc540100@siemens.com>
Date: Thu, 19 Jan 2017 18:57:57 +0100
MIME-Version: 1.0
In-Reply-To: <5bfef037-0efb-f82e-f036-5150a1f50ba0@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL v2] ipipe: 4.4 fixes for x86 and tracer,
	update to 4.4.43
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

for you to fetch changes up to eca25839f95f585e874bf3e4d46f5761907c08df:

  Merge tag 'v4.4.43' into for-upstream/4.4 (2017-01-16 17:21:42 +0100)

Note: The 4.4.43 merge was not tested on archs!=x86.

Changes in v2:
 - two additional fixes, interrupt-related
 - updated to 4.4.43

----------------------------------------------------------------
[leaving out the merge part in the stats]

Jan Kiszka (12):
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
      x86/ipipe: Initialize vector_irq for IRQ_MOVE_CLEANUP_VECTOR
      x86/ipipe: Fix deadlock on irq migration

 arch/x86/entry/common.c            | 16 ++++++--
 arch/x86/entry/entry_64.S          |  3 +-
 arch/x86/include/asm/ipipe.h       | 20 +++++++--
 arch/x86/include/asm/mmu_context.h |  3 +-
 arch/x86/kernel/apic/io_apic.c     |  2 +-
 arch/x86/kernel/apic/vector.c      |  2 +
 arch/x86/kernel/ipipe.c            | 83 ++++++++++++++------------------------
 arch/x86/kernel/irqinit.c          |  7 ++++
 arch/x86/kernel/traps.c            | 11 ++++-
 kernel/ipipe/tracer.c              |  4 +-
 kernel/locking/lockdep.c           | 10 ++++-
 kernel/sched/core.c                |  2 +-
 kernel/trace/trace_irqsoff.c       |  8 ++--
 13 files changed, 99 insertions(+), 72 deletions(-)

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

