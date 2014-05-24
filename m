Message-ID: <5380C520.8010506@xenomai.org>
Date: Sat, 24 May 2014 18:13:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] ipipe for 3.14 latest fixes
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

Note that I only disabled context tracking on ARM, because
I do not know whether it is broken on other architectures.
Maybe we could had a BUG_ON(hard_irqs_disabled()) to the
context_trackig_user_enter/context_tracking_user_exit functions
to be able to detect if other platforms have the same issue.

The following changes since commit a7adc69ef0473e88b4c9678408cd53800d08f0f5:

  arm/ipipe: export smp_on_up (2014-05-10 11:22:05 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.14.0

for you to fetch changes up to 2322859c85e71b183fd79b2185e7d89090f6fa74:

  arm/fcse: pass mm to services instead of fcse pid (2014-05-22 16:52:29 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (4):
      arm/ipipe: avoid calling irq_enter/irq_exit for IPIs
      arm/ipipe: forbid context tracking with I-pipe
      arm/fcse: always set fcse_large_process
      arm/fcse: pass mm to services instead of fcse pid

 arch/arm/Kconfig                   |    2 +-
 arch/arm/include/asm/fcse.h        |   74 +++++++++++++++++++++++-----------------
 arch/arm/include/asm/mmu_context.h |   40 ++++++++--------------
 arch/arm/kernel/smp.c              |    8 ++---
 arch/arm/mm/fcse.c                 |   51 ++++++++++++++-------------
 5 files changed, 88 insertions(+), 87 deletions(-)

-- 
                                                                Gilles.

