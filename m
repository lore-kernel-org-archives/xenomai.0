From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:05 +0200
Message-Id: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [I-PIPE][PATCH 00/11] 4.14.71/arm64 port (split series)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This is a port of the interrupt pipeline to kernel 4.14.71 for arm64,
based on the split series published earlier this year [1].

The architecture-specific bits have been reworked to become a series
of incremental changes on top of the -noarch tree [2], enabling a
feature one at a time, which should ease future kernel upgrades.

As a by-product, the I-pipe/arm64 port now copes with lockdep.

This port is known to run on the following SoCs, using the current tip
of Xenomai's -next branch:

- Zynq UltraScale+ (zcu102 evb)
- BCM2837 (Raspberry 3B)
- Kirin 620 (HiKey LeMaker)

NOTE: the change to the dts for the bcm2837 chip does not belong to
the I-pipe port strictly speaking. It routes the serial output to the
pl011 UART for rpi3, which may be useful for developers needing a
serial console who can't cope with using the mini-uart.

[1] https://www.xenomai.org/pipermail/xenomai/2018-July/039302.html
[2] https://git.xenomai.org/ipipe-noarch


Dmitriy Cherkasov (1):
  arm64: fpsimd: ipipe: enable sharing with head domain

Philippe Gerum (10):
  arm64: ipipe: add pipeline core
  arm64: context_tracking: disable if CONFIG_IPIPE
  arm64: ipipe: share context switch code with the head domain
  arm64: ipipe: route traps to co-kernel
  arm64: ipipe: route syscalls to co-kernel
  arm64: ipipe: turn hard irqs on when leaving the idle state
  arm64: dts: bcm2837: provide for BT-less variant, re-enabling uart0 as
    serial
  arm64: ipipe: route debug exceptions to co-kernel
  arm64: ipipe: route all access traps to co-kernel
  arm64: ipipe: preserve the hard interrupt state across mayday trap

 arch/arm64/Kconfig                                 |   5 +-
 arch/arm64/boot/dts/broadcom/Makefile              |   2 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-b-nobt.dts     |  12 +
 arch/arm64/include/asm/assembler.h                 |  12 +
 arch/arm64/include/asm/ipipe.h                     | 205 +++++++++++++++++
 arch/arm64/include/asm/ipipe_base.h                |  96 ++++++++
 arch/arm64/include/asm/ipipe_hwirq.h               | 191 ++++++++++++++++
 arch/arm64/include/asm/irqflags.h                  |  18 +-
 arch/arm64/include/asm/mmu_context.h               |  27 ++-
 arch/arm64/include/asm/percpu.h                    |   1 +
 arch/arm64/include/asm/thread_info.h               |  14 ++
 arch/arm64/include/asm/uaccess.h                   |   5 +-
 arch/arm64/include/asm/unistd.h                    |   2 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/asm-offsets.c                    |   3 +
 arch/arm64/kernel/entry.S                          | 113 ++++++++-
 arch/arm64/kernel/fpsimd.c                         | 138 +++++++++--
 arch/arm64/kernel/ipipe.c                          | 254 +++++++++++++++++++++
 arch/arm64/kernel/irq.c                            |  10 +
 arch/arm64/kernel/process.c                        |   2 +-
 arch/arm64/kernel/ptrace.c                         |   6 +-
 arch/arm64/kernel/signal.c                         |  13 +-
 arch/arm64/kernel/smp.c                            | 150 ++++++++++--
 arch/arm64/kernel/traps.c                          |   9 +-
 arch/arm64/mm/context.c                            |   2 +-
 arch/arm64/mm/fault.c                              | 127 ++++++++++-
 26 files changed, 1354 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-nobt.dts
 create mode 100644 arch/arm64/include/asm/ipipe.h
 create mode 100644 arch/arm64/include/asm/ipipe_base.h
 create mode 100644 arch/arm64/include/asm/ipipe_hwirq.h
 create mode 100644 arch/arm64/kernel/ipipe.c

-- 
2.14.4


