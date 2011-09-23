From: Richard Cochran <richardcochran@domain.hid>
Date: Fri, 23 Sep 2011 13:16:45 +0200
Message-Id: <cover.1316775991.git.richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC 0/4] Sample driver using raw Ethernet packet
	interface
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

*** Applies to ipipe-2.6.36-powerpc-2.12-03

This patch provides an example driver for the raw packet interface.
Much of the code is copy/paste from the main gainfar driver. The patch
uses the hardware priority queues of the P2020 to make a fast path for
real time traffic. Note this might not work on other eTSEC devices due
to slight implementation differences in the hardware!

If you really want to run this code, you might also apply the
following patch.

    cd0ea241 gianfar: Fix crashes on RX path

Richard Cochran (4):
  gianfar: reserve the first transmit queue
  gianfar: reserve the first receive queue
  Add a real time module for the gianfar driver.
  Add a real time packet reception to the gianfar driver.

 drivers/net/Makefile          |    5 +
 drivers/net/gianfar.c         |  120 ++++----------
 drivers/net/gianfar.h         |   90 ++++++++++-
 drivers/net/gianfar_ethtool.c |  163 +------------------
 drivers/net/gianfar_rt.c      |  366 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 487 insertions(+), 257 deletions(-)
 create mode 100644 drivers/net/gianfar_rt.c

-- 
1.7.2.5


