From: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 9 Sep 2018 19:50:44 +0200
Message-Id: <E1fz3yB-00049L-Vw@xenomai.org>
Subject: [Xenomai] [PATCH 0/4] assorted 4.14/x86 updates
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

The topmost patch might hopefully fix the boot issue you have been
seeing on your hardware, provided I'm interpreting the trace dump
correctly.

You will definitely need the interrupt state fix for any running
Xenomai app.

With these patches in, I can run the latency test flawlessly with
clean latency values on real hardware here. However, switchtest
breaks, pointing the finger at an issue in the fpu support.

Philippe Gerum (4):
  x86/irq: ipipe: map the cleanup vector to a legit IRQ number
  x86/fpu: ipipe: add inline qualifier to kernel_fpu_*() helpers
  x86: ipipe: fix interrupt state in syscall routing
  printk: ipipe: defer vprintk() output

 arch/x86/entry/common.c             | 147 ++++++++++++++++--------------------
 arch/x86/include/asm/fpu/internal.h |   6 +-
 arch/x86/kernel/idt.c               |  14 +++-
 kernel/printk/printk.c              | 136 ++++++++++++++++-----------------
 4 files changed, 148 insertions(+), 155 deletions(-)

-- 
2.14.4


