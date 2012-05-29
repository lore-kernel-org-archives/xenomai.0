Message-ID: <4FC48FB8.1020700@xenomai.org>
Date: Tue, 29 May 2012 10:58:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Pull request for adeos-ipipe-2.6.38.8-arm-1.18-08
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 5db89e7755817a3bd080235427ae9a1de8ba1cbf:

  adeos-ipipe-2.6.38.8-arm-1.18-07 (2012-05-28 20:36:59 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.38-arm

Gilles Chanteperdrix (4):
      ipipe/arm: defer chained interrupts handling
      ipipe/omap: fix gpio irq demuxing
      ipipe/at91: fix gpio irq demuxing
      adeos-ipipe-2.6.38.8-arm-1.18-08

 arch/arm/include/asm/ipipe.h   |   13 ++--
 arch/arm/include/asm/smp_twd.h |    2 +-
 arch/arm/kernel/ipipe.c        |   14 +++--
 arch/arm/kernel/smp.c          |    2 +-
 arch/arm/mach-at91/gpio.c      |   12 ---
 arch/arm/plat-omap/gpio.c      |  152 +++++----------------------------------
 6 files changed, 38 insertions(+), 157 deletions(-)

-- 
					    Gilles.

