Message-ID: <5387293B.8080400@xenomai.org>
Date: Thu, 29 May 2014 14:34:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] please pull latest ipipe fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit a7adc69ef0473e88b4c9678408cd53800d08f0f5:

  arm/ipipe: export smp_on_up (2014-05-10 11:22:05 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.14.0

for you to fetch changes up to 4cbe7685083be26834850e62fb16802eea3610ef:

  arm/ipipe: Add support for Ti da850 board (2014-05-29 14:29:53 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (5):
      arm/ipipe: avoid calling irq_enter/irq_exit for IPIs
      arm/ipipe: forbid context tracking with I-pipe
      arm/fcse: always set fcse_large_process
      arm/fcse: pass mm to services instead of fcse pid
      arm/ipipe: fix syscall restarting

Peter Howard (2):
      dma: edma: fix incorrect SG list handling
      arm/ipipe: Add support for Ti da850 board

 arch/arm/Kconfig                   |    2 +-
 arch/arm/include/asm/fcse.h        |   74 +++++++++++++++++++++++-----------------
 arch/arm/include/asm/mmu_context.h |   40 ++++++++--------------
 arch/arm/kernel/entry-common.S     |    2 +-
 arch/arm/kernel/ipipe.c            |    4 ---
 arch/arm/kernel/smp.c              |    8 ++---
 arch/arm/mach-davinci/Kconfig      |    1 +
 arch/arm/mach-davinci/cp_intc.c    |    1 +
 arch/arm/mach-davinci/time.c       |   46 +++++++++++++++++++++++++
 arch/arm/mm/fcse.c                 |   51 ++++++++++++++-------------
 drivers/dma/edma.c                 |    6 ++--
 drivers/gpio/gpio-davinci.c        |    3 +-
 12 files changed, 143 insertions(+), 95 deletions(-)

-- 
                                                                Gilles.

