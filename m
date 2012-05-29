Message-ID: <4FC490AA.1080602@xenomai.org>
Date: Tue, 29 May 2012 11:02:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Pull request for adeos-ipipe-3.0.13-arm-1.18-09
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The following changes since commit a799c8c82f1327aa0c0a2067ab8d9826fc0477c5:

  adeos-ipipe-3.0.13-arm-1.18-08 (2012-05-01 16:46:02 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.0-arm

Gilles Chanteperdrix (7):
      ipipe/arm: fix irq demuxing again
      ipipe/at91: fix gpio irq demuxing
      ipipe/omap: fix gpio irq demuxing
      backport linux 3.2 vfp fixes
      ipipe/arm: user __raw_writel when programming twd timer
      ipipe/arm: avoid useless irq mask/unmask
      adeos-ipipe-3.0.13-arm-1.18-09

 arch/arm/Kconfig              |    4 +
 arch/arm/include/asm/ipipe.h  |    4 +-
 arch/arm/kernel/asm-offsets.c |    7 +-
 arch/arm/kernel/entry-armv.S  |    2 +-
 arch/arm/kernel/ipipe.c       |   10 ++-
 arch/arm/kernel/smp_twd.c     |    4 +-
 arch/arm/mach-at91/gpio.c     |   15 +----
 arch/arm/vfp/Makefile         |    2 +-
 arch/arm/vfp/vfphw.S          |  105 +++++++++++++++++++-------
 arch/arm/vfp/vfpmodule.c      |  166 ++++++++++++++++++++++++-----------------
 drivers/gpio/gpio-omap.c      |   71 +++++------------
 11 files changed, 220 insertions(+), 170 deletions(-)

-- 
					    Gilles.

