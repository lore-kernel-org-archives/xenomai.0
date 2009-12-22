Message-ID: <4B30171B.2090504@domain.hid>
Date: Tue, 22 Dec 2009 01:47:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Pull request for I-pipe arm 2.6.30
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

The following changes since commit 64bcc2350d2099f10f004592968dc8a6402d4485:
  Philippe Gerum (1):
        ipipe-2.6.30-arm-1.14-02

are available in the git repository at:

  ssh://root@domain.hid for-ipipe-2.6.30-arm

Gilles Chanteperdrix (3):
      Revert recent changes
      Export fcse_needs_flush symbol
      Export missing symbols for modules and arm >= 6

Philippe Gerum (2):
      Make generic bitops locking Ipipe-ware
      Fix ipipe_preempt_enable/disable to work in non-interrupt context

 arch/arm/kernel/fcse.c               |    1 +
 arch/arm/kernel/ipipe.c              |    7 ++++++-
 arch/arm/mach-at91/at91_ipipe_time.c |   14 ++++++++------
 include/asm-generic/bitops/atomic.h  |    8 ++++----
 include/linux/ipipe_base.h           |   17 +++++++++++++++--
 5 files changed, 34 insertions(+), 13 deletions(-)

-- 
					    Gilles.

