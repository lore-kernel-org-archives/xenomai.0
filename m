From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/6] Further changes for 5.15 support
Date: Fri, 7 Jan 2022 12:35:29 +0100
Message-ID: <cover.1641555334.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This resolves remaining driver-related issues when building against 5.15
and enables this in CI.

NOTE: This only addresses compilation issues. We still have a bug,
likely in dovetail, see
https://xenomai.org/pipermail/xenomai/2022-January/047048.html.

Jan

Jan Kiszka (6):
  drivers/net: Remove dead smc91111 driver
  drivers/net: Account for changes to of_get_mac_address in 5.13
  drivers/net: fec: Account for changes of get/set_coalesce ethtool
    callbacks in 5.15
  drivers/serial: rt_imx_uart: Make it DT-only
  ci: Add 5.15 kernel
  ci: Drop some I-pipe left-overs

 .gitlab-ci.yml                                |   29 +-
 kernel/drivers/net/drivers/Kconfig            |    5 -
 kernel/drivers/net/drivers/Makefile           |    4 -
 kernel/drivers/net/drivers/at91_ether.c       |    7 +
 .../drivers/net/drivers/freescale/fec_main.c  |   22 +
 kernel/drivers/net/drivers/macb.c             |    7 +
 kernel/drivers/net/drivers/rt_smc91111.h      |  566 ---
 kernel/drivers/net/drivers/smc91111.c         | 3531 -----------------
 kernel/drivers/serial/rt_imx_uart.c           |   32 +-
 9 files changed, 64 insertions(+), 4139 deletions(-)
 delete mode 100644 kernel/drivers/net/drivers/rt_smc91111.h
 delete mode 100644 kernel/drivers/net/drivers/smc91111.c

-- 
2.31.1


