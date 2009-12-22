Message-ID: <4B301690.9050500@domain.hid>
Date: Tue, 22 Dec 2009 01:45:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Pull request for I-pipe arm 2.6.29
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Adeos <adeos-main@gna.org>

The following changes since commit 78f59c2fc92d5bb1d9fbf229048812a81ba345f3:
  Philippe Gerum (1):
        ipipe-2.6.29-arm-1.13-03

are available in the git repository at:

  ssh://root@domain.hid for-ipipe-2.6.29-arm

Gilles Chanteperdrix (3):
      Fix compiler warnings
      Export fcse_needs_flush symbol
      Export missing symbols for modules and arm >= 6

 arch/arm/kernel/fcse.c               |    1 +
 arch/arm/kernel/ipipe.c              |    8 +++++++-
 arch/arm/mach-at91/at91_ipipe_time.c |    2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
					    Gilles.

