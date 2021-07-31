From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 0/4] Dovetail fixes (v5.13)
Date: Sat, 31 Jul 2021 11:49:30 +0200
Message-Id: <20210731094934.1799307-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

The usual pain with synchronizing the virtual and real interrupt
states. These issues have been detected while porting to v5.14, some
are reported by CONFIG_DEBUG_LOCKDEP=y.

Philippe Gerum (4):
  x86/ioapic: irq_pipeline: unbreak irqflags tracing
  init: early sync the inband stall with the hardware state
  x86/fault: dovetail: unbreak irqflags tracing
  genirq: irq_pipeline: fix inverted check in debug assertion

 arch/x86/kernel/apic/io_apic.c |  4 ++--
 arch/x86/mm/fault.c            | 12 ++++++------
 init/main.c                    |  1 +
 kernel/irq/pipeline.c          | 10 +++++-----
 4 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.31.1


