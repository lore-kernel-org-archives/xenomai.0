Message-ID: <527A760E.3030908@xenomai.org>
Date: Wed, 06 Nov 2013 18:02:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] pull request: ipipe 3.8 fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The following changes since commit 74307024d967e97252a49537e92b8eccea5f5c0b:

  x86/ipipe: Fix !CONFIG_IPIPE build breakage of x86-64 (2013-10-07 12:25:09 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.8

for you to fetch changes up to c5332cdd60ba82b1823d973b7fac64af5baf7139:

  Merge remote-tracking branch 'origin/ipipe-3.8' into for-ipipe-3.8 (2013-11-05 18:44:06 +0100)

----------------------------------------------------------------

Gilles Chanteperdrix (6):
      x86/ipipe: get FPU backup area allocated for all threads
      arm/ipipe: fix mx28 gpio irq demuxing
      arm/ipipe: add missing EXPORT_SYMBOL
      x86/ipipe: ipipe-core-3.8.13-x86-4.patch
      arm/ipipe: ipipe-core-3.8.13-arm-3.patch
      Merge remote-tracking branch 'origin/ipipe-3.8' into for-ipipe-3.8

 arch/arm/include/asm/ipipe.h |    2 +-
 arch/arm/kernel/ipipe.c      |    1 +
 arch/x86/include/asm/ipipe.h |    2 +-
 arch/x86/kernel/process.c    |   10 +---------
 drivers/gpio/gpio-mxs.c      |    2 +-
 scripts/ipipe/genpatches.sh  |    1 +
 6 files changed, 6 insertions(+), 12 deletions(-)

-- 
                                                                Gilles.

