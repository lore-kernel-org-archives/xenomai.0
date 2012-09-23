Message-ID: <505F383E.1020502@xenomai.org>
Date: Sun, 23 Sep 2012 18:26:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe pull request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

The following changes since commit d21e8cdbdcf21ade9878c038e8bd55555ae1d210:

  ipipe: ipipe_timers_request -> ipipe_select_timers (2012-09-03 11:15:35 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-core-3.4

Gilles Chanteperdrix (16):
      ipipe/timer: only use kHz for large frequencies
      ipipe/arm: add hard_irqs_disabled_flags definition
      ipipe/tracer: whitespace cleanup
      ipipe: allow architectures to use a Linux clock
      ipipe/x86: implement dynamic tsc selection
      ipipe/x86: more fixes for AMD processors
      ipipe/debug: call irq_to_desc once in __ipipe_dispatch_irq
      ipipe/debug: fix x86 __ipipe_serial_debug
      ipipe/x86: fix irqsoff traces
      Merge remote branch 'siemens/for-upstream' into for-core-3.4
      ipipe/x86: only take the ioapic spinlock when an ioapic eoi is needed
      ipipe/arm: shorten l2x0 cache interrupts masking sections
      ipipe/arm: allow detecting calls to arch_get_unmapped_area from do_brk
      ipipe/arm: print message when disabling wfi on ARM926EJ-S cores
      arm/M28EVK: avoid led gpios pinmux
      ipipe/arm: mx28 port

Jan Kiszka (1):
      ipipe/x86: Populate vector_irq for all dispatched vectors

Wolfgang Mauerer (3):
      ipipe: Remove superfluous symbol export of irq_to_desc
      ipipe,x86: Introduce hard_irqs_disabled_flags
      Fix IRQs-off-tracer for x86_64

 arch/arm/include/asm/ipipe_hwirq.h       |    4 +-
 arch/arm/include/asm/mman.h              |    4 +
 arch/arm/kernel/ipipe.c                  |    5 +-
 arch/arm/mach-mxs/Kconfig                |    1 +
 arch/arm/mach-mxs/clock-mx28.c           |    4 +
 arch/arm/mach-mxs/icoll.c                |   16 ++-
 arch/arm/mach-mxs/mach-m28evk.c          |    4 -
 arch/arm/mach-mxs/timer.c                |   67 +++++++++-
 arch/arm/mm/cache-l2x0.c                 |   17 ++-
 arch/arm/mm/fcse.c                       |    5 +-
 arch/x86/Kconfig                         |    1 +
 arch/x86/include/asm/desc.h              |    8 +
 arch/x86/include/asm/ipipe_32.h          |   42 ++++--
 arch/x86/include/asm/irqflags.h          |    2 +
 arch/x86/kernel/apic/io_apic.c           |    7 +-
 arch/x86/kernel/entry_32.S               |   14 ++-
 arch/x86/kernel/entry_64.S               |   26 ++--
 arch/x86/kernel/i8253.c                  |    4 +
 arch/x86/kernel/ipipe.c                  |   15 +--
 arch/x86/kernel/irqinit.c                |    5 +
 arch/x86/kernel/pcspeaker.c              |    7 +
 arch/x86/lib/mmx_32.c                    |    4 +-
 drivers/clocksource/Makefile             |    3 +
 drivers/clocksource/i8253.c              |   40 +++++-
 drivers/clocksource/ipipe_i486_tsc_emu.S |  106 ++++++++++++++
 drivers/tty/serial/8250/8250.c           |    4 +-
 include/asm-generic/mman-common.h        |    3 +
 include/linux/clocksource.h              |    4 +
 include/linux/ipipe.h                    |    8 +
 kernel/ipipe/Kconfig                     |    3 +
 kernel/ipipe/core.c                      |   15 +-
 kernel/ipipe/timer.c                     |   26 ++--
 kernel/ipipe/tracer.c                    |  222 +++++++++++++++---------------
 kernel/time/clocksource.c                |   92 ++++++++++++
 mm/mmap.c                                |    2 +-
 35 files changed, 591 insertions(+), 199 deletions(-)
 create mode 100644 drivers/clocksource/ipipe_i486_tsc_emu.S

-- 
                                                                Gilles.

