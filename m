From: Wolfgang Grandegger <wg@domain.hid>
Date: Thu, 14 Jan 2010 13:07:42 +0100
Message-Id: <1263470867-1533-1-git-send-email-wg@domain.hid>
Subject: [Xenomai-core] [PATCH xenomai-2.5 0/3] rtcan: mscan: new OF
	platform driver for MPC521x and MPC5200
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid
Cc: Wolfgang Grandegger <wg@domain.hid>

From: Wolfgang Grandegger <wg@domain.hid>

This patch series adds RT-Socket-CAN support for the MSCAN on the MPC512x
from Freescale by introducing a new OF platform driver for both, the
MPC521x and MPC5200, while still keeping the old driver for the MPC5200
for compatibility with older kernel versions.

Wolfgang

Wolfgang Grandegger (3):
  rtcan: mscan: use tabs for indention and white space cleanup
  rtcan: mscan: use proper io accessor functions for register access
  rtcan: mscan: new OF platform driver for MPC521x and MPC5200

 ksrc/drivers/can/mscan/Kconfig               |   21 +-
 ksrc/drivers/can/mscan/Makefile              |   11 +-
 ksrc/drivers/can/mscan/rtcan_mscan.c         | 1245 +++++++++++---------------
 ksrc/drivers/can/mscan/rtcan_mscan.h         |   38 +
 ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c |  254 ++++++
 ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c |  374 ++++++++
 ksrc/drivers/can/mscan/rtcan_mscan_proc.c    |  184 ++--
 ksrc/drivers/can/mscan/rtcan_mscan_regs.h    |   74 +-
 8 files changed, 1371 insertions(+), 830 deletions(-)
 create mode 100644 ksrc/drivers/can/mscan/rtcan_mscan.h
 create mode 100644 ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c
 create mode 100644 ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c


