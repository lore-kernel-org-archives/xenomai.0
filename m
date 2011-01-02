Message-ID: <4D1FE286.2030302@domain.hid>
Date: Sun, 02 Jan 2011 03:27:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] pull request for adeos-ipipe-2.6.33-arm-1.18-01
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

The following changes since commit afe2e9febb4c2e665483bb6c965fdf1a3d2f01d9:
  Gilles Chanteperdrix (1):
        adeos-ipipe-2.6.33-arm-1.18-00

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.33-arm

Gilles Chanteperdrix (4):
      ipipe arm: fix free-running count-down tsc emulation
      ipipe arm: shorten the 16 bits tsc emulations
      ipipe at91: implement one-shot timer for linux
      adeos-ipipe-2.6.33-arm-1.18-01

Philippe Gerum (1):
      ipipe arm: remove useless #ifdef

 arch/arm/include/asm/ipipe.h         |    4 +-
 arch/arm/kernel/ipipe_tsc_asm.S      |   26 +++++++++----------
 arch/arm/kernel/smp.c                |    4 ---
 arch/arm/mach-at91/at91_ipipe_time.c |   46 +++++++++++++++++++--------------
 4 files changed, 40 insertions(+), 40 deletions(-)

-- 
                                                                Gilles.

