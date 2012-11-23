From: stefan.roese@gmail.com
Date: Fri, 23 Nov 2012 14:50:06 +0100
Message-Id: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
Subject: [Xenomai] [PATCH v3 0/3] mpc5200: Add RTDM LPBFIFO driver and demo
	RTDM FPGA driver driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Stefan Roese <sr@denx.de>

From: Stefan Roese <sr@denx.de>


This patch adds support for the RTDM LPB (LocalPlusBus) FIFO driver
for the MPC5200. It will be used for DMA support in an RTDM FPGA
device driver. This rt-fpga.c driver is a custom device driver,
but might be useful for other developers as well. Thats why I
included it here too.

The lpb-fifo driver is ported from the Linux kernel lpb-fifo
driver:

arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c

With all locking etc changed from Linux call to Xenomai/RTDM
calls.

Thanks,
Stefan

Series-changes: 3
- Patch split into 3 separate patches
- Added RTDM_CLASS_CUSTOM
- Fixed usage of CONFIG_ options defined in Kconfig in driver
- Removed Linux v2.4 support (Config.in / Makefiles)
- Removed dbg macro and used existing kernel debug function
- Headers moved to include/rtdm
- Used different structs for the ioctl's

Series-changes: 2
- Moved debug switches from #define in source to Kconfig
- Some minor spelling fixes



Stefan Roese (3):
  Add RTDM_CLASS_CUSTOM for custom RTDM device drivers
  mpc5200: Add RTDM LPBFIFO driver
  mpc5200: Add demo RTDM FPGA DMA based device driver

 include/rtdm/rt-fpga.h                        |  46 ++
 include/rtdm/rt_mpc52xx_lpbfifo.h             |  13 +
 include/rtdm/rtdm.h                           |   1 +
 ksrc/drivers/Kconfig                          |   1 +
 ksrc/drivers/Makefile                         |   2 +-
 ksrc/drivers/mpc5200_dma/Kconfig              |  53 ++
 ksrc/drivers/mpc5200_dma/Makefile             |   9 +
 ksrc/drivers/mpc5200_dma/rt-fpga.c            | 711 ++++++++++++++++++++++++++
 ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c | 569 +++++++++++++++++++++
 scripts/Modules.frag                          |   3 +-
 10 files changed, 1406 insertions(+), 2 deletions(-)
 create mode 100644 include/rtdm/rt-fpga.h
 create mode 100644 include/rtdm/rt_mpc52xx_lpbfifo.h
 create mode 100644 ksrc/drivers/mpc5200_dma/Kconfig
 create mode 100644 ksrc/drivers/mpc5200_dma/Makefile
 create mode 100644 ksrc/drivers/mpc5200_dma/rt-fpga.c
 create mode 100644 ksrc/drivers/mpc5200_dma/rt_mpc52xx_lpbfifo.c

-- 
1.8.0


