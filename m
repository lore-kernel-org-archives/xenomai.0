From: Philippe Gerum <rpm@xenomai.org>
Date: Wed, 5 Sep 2018 17:21:58 +0200
Message-Id: <E1fxZtI-0005mj-NW@xenomai.org>
Subject: [Xenomai] [I-PIPE][PATCH 0/7] arm64: interrupt pipeline rebased
 over the split series
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

Hi Dmitriy,

This patch set is a full rebase of the arm64 bits over the split
series implementing the generic pipeline core sent a month ago
[1]. The arch-specific code was rearranged as an incremental series in
the process as well.

The resulting pipeline now supports lockdep and plays nicely with the
ARM/ARM64 CPU idle driver.

With the combined generic+arm64 series in, the mainline kernel runs
Xenomai -next over the following SoCs:

- HiKey LeMaker (hi6220)
- Raspberry PI 3B

It has also been tested with Xilinx's vendor kernel on a Zynq
Ultrascale (expect ~50 us worst-case for scheduling latency on a
highly stressed system, < 20 us for interrupt latency).

[1] https://www.xenomai.org/pipermail/xenomai/2018-July/039302.html

Dmitriy Cherkasov (1):
  arm64: fpsimd: ipipe: enable sharing with head domain

Philippe Gerum (6):
  arm64: ipipe: add pipeline core
  arm64: context_tracking: disable if CONFIG_IPIPE
  arm64: ipipe: share context switch code with the head domain
  arm64: ipipe: route traps to co-kernel
  arm64: ipipe: route syscalls to co-kernel
  arm64: ipipe: turn hard irqs on when leaving the idle state

 arch/arm64/Kconfig                   |   5 +-
 arch/arm64/include/asm/assembler.h   |  12 ++
 arch/arm64/include/asm/ipipe.h       | 205 +++++++++++++++++++++++++++
 arch/arm64/include/asm/ipipe_base.h  |  96 +++++++++++++
 arch/arm64/include/asm/ipipe_hwirq.h | 191 +++++++++++++++++++++++++
 arch/arm64/include/asm/irqflags.h    |  18 ++-
 arch/arm64/include/asm/mmu_context.h |  27 +++-
 arch/arm64/include/asm/percpu.h      |   1 +
 arch/arm64/include/asm/thread_info.h |  14 ++
 arch/arm64/include/asm/uaccess.h     |   5 +-
 arch/arm64/include/asm/unistd.h      |   2 +
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/entry.S            | 113 ++++++++++++++-
 arch/arm64/kernel/fpsimd.c           | 138 ++++++++++++++++--
 arch/arm64/kernel/ipipe.c            | 267 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c              |  10 ++
 arch/arm64/kernel/process.c          |   2 +-
 arch/arm64/kernel/ptrace.c           |   6 +-
 arch/arm64/kernel/signal.c           |  13 +-
 arch/arm64/kernel/smp.c              | 150 ++++++++++++++++++--
 arch/arm64/kernel/traps.c            |   9 +-
 arch/arm64/mm/context.c              |   2 +-
 arch/arm64/mm/fault.c                | 118 ++++++++++++++--
 24 files changed, 1345 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/include/asm/ipipe.h
 create mode 100644 arch/arm64/include/asm/ipipe_base.h
 create mode 100644 arch/arm64/include/asm/ipipe_hwirq.h
 create mode 100644 arch/arm64/kernel/ipipe.c

-- 
2.14.4


