From: Wolfgang Grandegger <wg@domain.hid>
Date: Mon, 21 Nov 2011 10:05:58 +0100
Message-Id: <1321866361-19373-1-git-send-email-wg@domain.hid>
Subject: [Xenomai-core] [PATCH 0/3] serial: add driver for the MPC52xx PSC
	UARTs and RS485 mode
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

From: Wolfgang Grandegger <wg@domain.hid>

This series of patches adds a RTserial driver for the MPC52xx PSC UARTs
on the MPC5200 SOCs. It includes support for RS485 mode and shift
register empty events (RTSER_EVENT_TXEMPTY), which is introduced first.

Wolfgang Grandegger (3):
  serial/16650a: fix missing value in default_config initialization
  serial: add shift register empty event and RS485 support flag
  serial: add driver for the MPC52xx PSC UARTs

 include/rtdm/rtserial.h               |   14 +
 ksrc/drivers/serial/16550A.c          |    4 +-
 ksrc/drivers/serial/Kconfig           |    6 +
 ksrc/drivers/serial/Makefile          |    2 +
 ksrc/drivers/serial/rt_mpc52xx_uart.c | 1462 +++++++++++++++++++++++++++++++++
 5 files changed, 1486 insertions(+), 2 deletions(-)
 create mode 100644 ksrc/drivers/serial/rt_mpc52xx_uart.c

-- 
1.7.6.4


