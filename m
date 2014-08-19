Resent-To: xenomai@xenomai.org
Resent-Message-ID: <53F3C9CE.5070405@xenomai.org>
Message-ID: <53F3C9BF.6040405@xenomai.org>
Date: Wed, 20 Aug 2014 00:03:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] ipipe patch for Linux 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>

This concludes my tests of the I-pipe kernel for 3.14. For benchmark 
results, see:

http://xenomai.org/2014/08/benchmarks-xenomai-dual-kernel-over-linux-3-14/

The following changes since commit 4946c5cd6f59101a274232a456690fd76cedf6af:

  ipipe/genpatches.sh: fixup for arm-based drivers (2014-07-03 11:01:26 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch for-ipipe-3.14.0

for you to fetch changes up to 45c827b5b23a8f2f47fc97d6bb84b5b8456cf863:

  at91_ipipe: look for a 5MHz clock instead of 1MHz if TC has 32 bits (2014-08-16 18:32:23 +0200)

----------------------------------------------------------------
Anders Blomdell (1):
      ipipe: fix genpatches.sh

Gilles Chanteperdrix (8):
      arm/fcse: avoid compilation error without FCSE
      arm/ipipe: automatically start a timer to refresh tsc
      at91/ipipe: rework at91_ipipe again
      ipipe/at91: re-add the 1ms margin to the timer programming time
      arm/ipipe: remove calls to __ipipe_tsc_update
      at91/ipipe: adapt to AIC5
      ipipe/genpatches.sh: move the 8250 serial debug to the noarch section
      at91_ipipe: look for a 5MHz clock instead of 1MHz if TC has 32 bits

 arch/arm/common/timer-sp.c            |    4 +-
 arch/arm/include/asm/fcse.h           |   12 ++--
 arch/arm/kernel/ipipe_tsc.c           |   40 ++++++++---
 arch/arm/kernel/smp.c                 |    2 -
 arch/arm/kernel/smp_twd.c             |    7 +-
 arch/arm/mach-at91/at91_ipipe.c       |  135 ++++++++++++++++++++----------------
 arch/arm/mach-at91/at91_ipipe.h       |    9 +--
 arch/arm/mach-at91/at91rm9200_time.c  |    5 +-
 arch/arm/mach-at91/at91sam926x_time.c |    5 +-
 arch/arm/mach-at91/at91x40_time.c     |    3 +-
 arch/arm/mach-at91/gpio.c             |   19 +++--
 arch/arm/mach-at91/irq.c              |   51 ++++++++++++--
 arch/arm/mach-davinci/time.c          |    3 -
 arch/arm/mach-imx/time.c              |    2 -
 arch/arm/mach-ixp4xx/common.c         |    4 +-
 arch/arm/mach-omap2/timer.c           |   15 ++--
 arch/arm/mach-pxa/time.c              |    3 +-
 arch/arm/mach-sa1100/time.c           |    5 +-
 arch/arm/mach-spear/time.c            |    4 --
 scripts/ipipe/genpatches.sh           |    4 +-
 20 files changed, 192 insertions(+), 140 deletions(-)

-- 
                                                                Gilles.

