From: Wolfgang Grandegger <wg@grandegger.com>
Date: Thu, 27 Sep 2012 17:29:12 +0200
Message-Id: <1348759755-13500-1-git-send-email-wg@grandegger.com>
Subject: [Xenomai] [PATCH 0/3] rtcan: Flexcan driver for Freescale SOCs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org
Cc: Wolfgang Grandegger <wg@denx.de>

From: Wolfgang Grandegger <wg@denx.de>

This patch series adds support for the Flexcan CAN controller available
on various Freescale PowerPC and ARM SOCs. It is based on the Linux-CAN
driver "flexcan.c" from Linux v3.5. I have tested it on a i.MX28 board
under Linux 3.4.6. To get it working on the i.MX6, I'm afraid, there are
a few more mainline patches necessary, which entered the kernel for
v3.6. It should not be a big deal to port them over.

It would be nice if anybody else could test the driver.

Thanks,

Wolfgang.

Wolfgang Grandegger (3):
  rtcan: add some macro definitions for compatibility with Linux-CAN
  rtcan: add bit-timing calulation from Linux-CAN
  rtcan: add driver for Flexcan on Freescale SOCs

 include/rtdm/rtcan.h                     |   12 +-
 ksrc/drivers/can/Kconfig                 |   16 +
 ksrc/drivers/can/Makefile                |    2 +
 ksrc/drivers/can/mscan/rtcan_mscan.c     |   17 +
 ksrc/drivers/can/rtcan_dev.h             |   17 +
 ksrc/drivers/can/rtcan_flexcan.c         | 1135 ++++++++++++++++++++++++++++++
 ksrc/drivers/can/rtcan_internal.h        |   10 +
 ksrc/drivers/can/rtcan_raw_dev.c         |  127 ++++-
 ksrc/drivers/can/sja1000/rtcan_sja1000.c |   18 +
 9 files changed, 1351 insertions(+), 3 deletions(-)
 create mode 100644 ksrc/drivers/can/rtcan_flexcan.c

-- 
1.7.7.6


