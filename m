Message-ID: <4BE081C8.5070607@domain.hid>
Date: Tue, 04 May 2010 22:21:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] adeos-ipipe-2.6.30-arm-1.15-02 pull request.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

The following changes since commit 3e02b1d21cafbf00dc12650f684035bbbd2d6566:
  Gilles Chanteperdrix (1):
        adeos-ipipe-2.6.30-arm-1.15-01

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.30-arm

Fabian Godehardt (1):
      Fix hang on 'Calibrating delay loop...' on S3C24xx

Gilles Chanteperdrix (1):
      adeos-ipipe-2.6.30-arm-1.15-02

Henri Roosen (1):
      Fix bug on imx31 when accessing hardware timer in user-space

 arch/arm/include/asm/ipipe.h            |    6 +++---
 arch/arm/mach-mx3/devices.c             |   13 +++++++++++++
 arch/arm/plat-mxc/cpu.c                 |   28 +++++++++++++++++++++++++++-
 arch/arm/plat-mxc/include/mach/common.h |    4 ++++
 arch/arm/plat-s3c/time.c                |    5 -----
 5 files changed, 47 insertions(+), 9 deletions(-)

-- 
					    Gilles.

