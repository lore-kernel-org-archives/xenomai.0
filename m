Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270E126BF5
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909181; cv=none; b=LSj3IiWAwoUl1C11ad33vIVSlNH766Uw9M/SqTf2WJ2LdoPEV4raHs1dHNw21CO61hrLT1sig3gtB1yndcfw7F8GczTOqXfrl8Nm8IzKtgVqZxurwnlKJC4dq28WautNKhzZI/uri/xHQYYyKkY9K5R93rQ+0HwUGxPwxfLViQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909181; c=relaxed/simple;
	bh=aQ519guwaYg05QjQaE66q9CoVoXtHjL0lQHQkXafqf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IJft0KqNrXl+q1P37qh/fgyRx9OA9oPs7q3uQhCqaQNrT5Tfex760itZVyXHP7T/ON193zMAJduWVOkacdd58XSwctVEEBQUH56UGEX9jY8wROMXW9sQyEmOAog1HytRaRY8+IhiC21Lq4g2d2e4z2iOK/ByYgmvjSilZsm4rVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.aDTKrnr_1731909161 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 18 Nov 2024 13:52:42 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [v1] add BOSCH M_CAN support
Date: Mon, 18 Nov 2024 13:52:40 +0800
Message-Id: <20241118055240.193432-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
---
 .gitlab-ci.yml                             |    2 +
 kernel/drivers/can/Kconfig                 |    1 +
 kernel/drivers/can/Makefile                |    2 +-
 kernel/drivers/can/m_can/Kconfig           |   15 +
 kernel/drivers/can/m_can/Makefile          |   12 +
 kernel/drivers/can/m_can/rtcan_m_can.c     | 1534 ++++++++++++++++++++
 kernel/drivers/can/m_can/rtcan_m_can.h     |  106 ++
 kernel/drivers/can/m_can/rtcan_m_can_pci.c |  212 +++
 8 files changed, 1883 insertions(+), 1 deletion(-)
 create mode 100644 kernel/drivers/can/m_can/Kconfig
 create mode 100644 kernel/drivers/can/m_can/Makefile
 create mode 100644 kernel/drivers/can/m_can/rtcan_m_can.c
 create mode 100644 kernel/drivers/can/m_can/rtcan_m_can.h
 create mode 100644 kernel/drivers/can/m_can/rtcan_m_can_pci.c

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ad6f37d1c..f7e6ef6b8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -116,6 +116,8 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_CAN_PEAK_CANFD
     - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN
     - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN_PLATFORM
+    - ./scripts/config -e XENO_DRIVERS_CAN_M_CAN
+    - ./scripts/config -e XENO_DRIVERS_CAN_M_CAN_PCI
     - ./scripts/config -m XENO_DRIVERS_NET
     - ./scripts/config -e XENO_DRIVERS_RTNET_CHECKED
     - ./scripts/config -e XENO_DRIVERS_NET_ETH_P_ALL
diff --git a/kernel/drivers/can/Kconfig b/kernel/drivers/can/Kconfig
index 2d7e66965..d2efac320 100644
--- a/kernel/drivers/can/Kconfig
+++ b/kernel/drivers/can/Kconfig
@@ -88,5 +88,6 @@ config XENO_DRIVERS_CAN_FLEXCAN
 source "drivers/xenomai/can/c_can/Kconfig"
 source "drivers/xenomai/can/peak_canfd/Kconfig"
 source "drivers/xenomai/can/sja1000/Kconfig"
+source "drivers/xenomai/can/m_can/Kconfig"
 
 endmenu
diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
index 3f05a4b0b..e6d50360c 100644
--- a/kernel/drivers/can/Makefile
+++ b/kernel/drivers/can/Makefile
@@ -1,7 +1,7 @@
 
 ccflags-y += -I$(srctree)/drivers/xenomai/can -I$(srctree)/kernel/
 
-obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o sja1000/ peak_canfd/ c_can/
+obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o sja1000/ peak_canfd/ c_can/ m_can/
 obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) += xeno_can_flexcan.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_VIRT) += xeno_can_virt.o
 
diff --git a/kernel/drivers/can/m_can/Kconfig b/kernel/drivers/can/m_can/Kconfig
new file mode 100644
index 000000000..c9fca4654
--- /dev/null
+++ b/kernel/drivers/can/m_can/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config XENO_DRIVERS_CAN_M_CAN
+	tristate "Bosch M_CAN controller"
+	depends on XENO_DRIVERS_CAN
+	select XENO_DRIVERS_CAN_BUS_ERR
+	help
+	 Say Y here if you want support for Bosch M_CAN controller framework.
+	 This is common support for devices that embed the Bosch M_CAN IP.
+
+config XENO_DRIVERS_CAN_M_CAN_PCI
+	tristate "RT PCI Bus based M_CAN driver"
+	depends on XENO_DRIVERS_CAN_M_CAN && PCI
+	help
+	 Say Y here if you want to support Bosch M_CAN controller connected
+	 to the pci bus.
diff --git a/kernel/drivers/can/m_can/Makefile b/kernel/drivers/can/m_can/Makefile
new file mode 100644
index 000000000..2253b8dae
--- /dev/null
+++ b/kernel/drivers/can/m_can/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+#  Makefile for the Bosch M_CAN controller driver.
+#
+
+ccflags-y += -I$(srctree)/drivers/xenomai/can -I$(srctree)/drivers/xenomai/can/m_can
+
+obj-$(CONFIG_XENO_DRIVERS_CAN_M_CAN) += xeno_can_m_can.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_M_CAN_PCI) += xeno_can_m_can_pci.o
+
+xeno_can_m_can-y := rtcan_m_can.o
+xeno_can_m_can_pci-y := rtcan_m_can_pci.o
diff --git a/kernel/drivers/can/m_can/rtcan_m_can.c b/kernel/drivers/can/m_can/rtcan_m_can.c
new file mode 100644
index 000000000..c2bd16660
--- /dev/null
+++ b/kernel/drivers/can/m_can/rtcan_m_can.c
@@ -0,0 +1,1534 @@
+// SPDX-License-Identifier: GPL-2.0
+// CAN bus driver for Bosch M_CAN controller
+//  Copyright (C) 2014 Freescale Semiconductor, Inc.
+//      Dong Aisheng <b29396@freescale.com>
+// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
+// Copyright (C) 2024 Liu Yang <liuyang@sinsegye.com.cn>
+/* Bosch M_CAN user manual can be obtained from:
+ * https://github.com/linux-can/can-doc/tree/master/m_can
+ * port RTDM driver from linux-5.15.51
+ * Bosch NAPI implementation has been removed and replaced with RT Socket CAN implementation.
+ * Remove CANFD
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.*
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/of_device.h>
+#endif
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+
+#include <rtdm/driver.h>
+
+/* CAN device profile */
+#include <rtdm/can.h>
+
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+#include "rtcan_internal.h"
+#include "rtcan_m_can.h"
+
+/* registers definition */
+enum m_can_reg {
+	M_CAN_CREL	= 0x0,
+	M_CAN_ENDN	= 0x4,
+	M_CAN_CUST	= 0x8,
+	M_CAN_DBTP	= 0xc,
+	M_CAN_TEST	= 0x10,
+	M_CAN_RWD	= 0x14,
+	M_CAN_CCCR	= 0x18,
+	M_CAN_NBTP	= 0x1c,
+	M_CAN_TSCC	= 0x20,
+	M_CAN_TSCV	= 0x24,
+	M_CAN_TOCC	= 0x28,
+	M_CAN_TOCV	= 0x2c,
+	M_CAN_ECR	= 0x40,
+	M_CAN_PSR	= 0x44,
+	/* TDCR Register only available for version >=3.1.x */
+	M_CAN_TDCR	= 0x48,
+	M_CAN_IR	= 0x50,
+	M_CAN_IE	= 0x54,
+	M_CAN_ILS	= 0x58,
+	M_CAN_ILE	= 0x5c,
+	M_CAN_GFC	= 0x80,
+	M_CAN_SIDFC	= 0x84,
+	M_CAN_XIDFC	= 0x88,
+	M_CAN_XIDAM	= 0x90,
+	M_CAN_HPMS	= 0x94,
+	M_CAN_NDAT1	= 0x98,
+	M_CAN_NDAT2	= 0x9c,
+	M_CAN_RXF0C	= 0xa0,
+	M_CAN_RXF0S	= 0xa4,
+	M_CAN_RXF0A	= 0xa8,
+	M_CAN_RXBC	= 0xac,
+	M_CAN_RXF1C	= 0xb0,
+	M_CAN_RXF1S	= 0xb4,
+	M_CAN_RXF1A	= 0xb8,
+	M_CAN_RXESC	= 0xbc,
+	M_CAN_TXBC	= 0xc0,
+	M_CAN_TXFQS	= 0xc4,
+	M_CAN_TXESC	= 0xc8,
+	M_CAN_TXBRP	= 0xcc,
+	M_CAN_TXBAR	= 0xd0,
+	M_CAN_TXBCR	= 0xd4,
+	M_CAN_TXBTO	= 0xd8,
+	M_CAN_TXBCF	= 0xdc,
+	M_CAN_TXBTIE	= 0xe0,
+	M_CAN_TXBCIE	= 0xe4,
+	M_CAN_TXEFC	= 0xf0,
+	M_CAN_TXEFS	= 0xf4,
+	M_CAN_TXEFA	= 0xf8,
+};
+
+#define DEV_NAME	"rtcan%d"
+#define DRV_NAME	"m_can"
+
+/* napi related */
+#define M_CAN_NAPI_WEIGHT	1
+
+/* message ram configuration data length */
+#define MRAM_CFG_LEN	8
+
+/* Core Release Register (CREL) */
+#define CREL_REL_MASK		GENMASK(31, 28)
+#define CREL_STEP_MASK		GENMASK(27, 24)
+#define CREL_SUBSTEP_MASK	GENMASK(23, 20)
+
+/* Data Bit Timing & Prescaler Register (DBTP) */
+#define DBTP_TDC		BIT(23)
+#define DBTP_DBRP_MASK		GENMASK(20, 16)
+#define DBTP_DTSEG1_MASK	GENMASK(12, 8)
+#define DBTP_DTSEG2_MASK	GENMASK(7, 4)
+#define DBTP_DSJW_MASK		GENMASK(3, 0)
+
+/* Transmitter Delay Compensation Register (TDCR) */
+#define TDCR_TDCO_MASK		GENMASK(14, 8)
+#define TDCR_TDCF_MASK		GENMASK(6, 0)
+
+/* Test Register (TEST) */
+#define TEST_LBCK		BIT(4)
+
+/* CC Control Register (CCCR) */
+#define CCCR_TXP		BIT(14)
+#define CCCR_TEST		BIT(7)
+#define CCCR_DAR		BIT(6)
+#define CCCR_MON		BIT(5)
+#define CCCR_CSR		BIT(4)
+#define CCCR_CSA		BIT(3)
+#define CCCR_ASM		BIT(2)
+#define CCCR_CCE		BIT(1)
+#define CCCR_INIT		BIT(0)
+/* for version 3.0.x */
+#define CCCR_CMR_MASK		GENMASK(11, 10)
+#define CCCR_CMR_CANFD		0x1
+#define CCCR_CMR_CANFD_BRS	0x2
+#define CCCR_CMR_CAN		0x3
+#define CCCR_CME_MASK		GENMASK(9, 8)
+#define CCCR_CME_CAN		0
+#define CCCR_CME_CANFD		0x1
+#define CCCR_CME_CANFD_BRS	0x2
+/* for version >=3.1.x */
+#define CCCR_EFBI		BIT(13)
+#define CCCR_PXHD		BIT(12)
+#define CCCR_BRSE		BIT(9)
+#define CCCR_FDOE		BIT(8)
+/* for version >=3.2.x */
+#define CCCR_NISO		BIT(15)
+/* for version >=3.3.x */
+#define CCCR_WMM		BIT(11)
+#define CCCR_UTSU		BIT(10)
+
+/* Nominal Bit Timing & Prescaler Register (NBTP) */
+#define NBTP_NSJW_MASK		GENMASK(31, 25)
+#define NBTP_NBRP_MASK		GENMASK(24, 16)
+#define NBTP_NTSEG1_MASK	GENMASK(15, 8)
+#define NBTP_NTSEG2_MASK	GENMASK(6, 0)
+
+/* Timestamp Counter Configuration Register (TSCC) */
+#define TSCC_TCP_MASK		GENMASK(19, 16)
+#define TSCC_TSS_MASK		GENMASK(1, 0)
+#define TSCC_TSS_DISABLE	0x0
+#define TSCC_TSS_INTERNAL	0x1
+#define TSCC_TSS_EXTERNAL	0x2
+
+/* Timestamp Counter Value Register (TSCV) */
+#define TSCV_TSC_MASK		GENMASK(15, 0)
+
+/* Error Counter Register (ECR) */
+#define ECR_RP			BIT(15)
+#define ECR_REC_MASK		GENMASK(14, 8)
+#define ECR_TEC_MASK		GENMASK(7, 0)
+
+/* Protocol Status Register (PSR) */
+#define PSR_BO		BIT(7)
+#define PSR_EW		BIT(6)
+#define PSR_EP		BIT(5)
+#define PSR_LEC_MASK	GENMASK(2, 0)
+
+/* Interrupt Register (IR) */
+#define IR_ALL_INT	0xffffffff
+
+/* Renamed bits for versions > 3.1.x */
+#define IR_ARA		BIT(29)
+#define IR_PED		BIT(28)
+#define IR_PEA		BIT(27)
+
+/* Bits for version 3.0.x */
+#define IR_STE		BIT(31)
+#define IR_FOE		BIT(30)
+#define IR_ACKE		BIT(29)
+#define IR_BE		BIT(28)
+#define IR_CRCE		BIT(27)
+#define IR_WDI		BIT(26)
+#define IR_BO		BIT(25)
+#define IR_EW		BIT(24)
+#define IR_EP		BIT(23)
+#define IR_ELO		BIT(22)
+#define IR_BEU		BIT(21)
+#define IR_BEC		BIT(20)
+#define IR_DRX		BIT(19)
+#define IR_TOO		BIT(18)
+#define IR_MRAF		BIT(17)
+#define IR_TSW		BIT(16)
+#define IR_TEFL		BIT(15)
+#define IR_TEFF		BIT(14)
+#define IR_TEFW		BIT(13)
+#define IR_TEFN		BIT(12)
+#define IR_TFE		BIT(11)
+#define IR_TCF		BIT(10)
+#define IR_TC		BIT(9)
+#define IR_HPM		BIT(8)
+#define IR_RF1L		BIT(7)
+#define IR_RF1F		BIT(6)
+#define IR_RF1W		BIT(5)
+#define IR_RF1N		BIT(4)
+#define IR_RF0L		BIT(3)
+#define IR_RF0F		BIT(2)
+#define IR_RF0W		BIT(1)
+#define IR_RF0N		BIT(0)
+#define IR_ERR_STATE	(IR_BO | IR_EW | IR_EP)
+
+/* Interrupts for version 3.0.x */
+#define IR_ERR_LEC_30X	(IR_STE	| IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
+#define IR_ERR_BUS_30X	(IR_ERR_LEC_30X | IR_WDI | IR_BEU | IR_BEC | \
+			 IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L | \
+			 IR_RF0L)
+#define IR_ERR_ALL_30X	(IR_ERR_STATE | IR_ERR_BUS_30X)
+
+/* Interrupts for version >= 3.1.x */
+#define IR_ERR_LEC_31X	(IR_PED | IR_PEA)
+#define IR_ERR_BUS_31X      (IR_ERR_LEC_31X | IR_WDI | IR_BEU | IR_BEC | \
+			 IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L | \
+			 IR_RF0L)
+#define IR_ERR_ALL_31X	(IR_ERR_STATE | IR_ERR_BUS_31X)
+
+/* Interrupt Line Select (ILS) */
+#define ILS_ALL_INT0	0x0
+#define ILS_ALL_INT1	0xFFFFFFFF
+
+/* Interrupt Line Enable (ILE) */
+#define ILE_EINT1	BIT(1)
+#define ILE_EINT0	BIT(0)
+
+/* Rx FIFO 0/1 Configuration (RXF0C/RXF1C) */
+#define RXFC_FWM_MASK	GENMASK(30, 24)
+#define RXFC_FS_MASK	GENMASK(22, 16)
+
+/* Rx FIFO 0/1 Status (RXF0S/RXF1S) */
+#define RXFS_RFL	BIT(25)
+#define RXFS_FF		BIT(24)
+#define RXFS_FPI_MASK	GENMASK(21, 16)
+#define RXFS_FGI_MASK	GENMASK(13, 8)
+#define RXFS_FFL_MASK	GENMASK(6, 0)
+
+/* Rx Buffer / FIFO Element Size Configuration (RXESC) */
+#define RXESC_RBDS_MASK		GENMASK(10, 8)
+#define RXESC_F1DS_MASK		GENMASK(6, 4)
+#define RXESC_F0DS_MASK		GENMASK(2, 0)
+#define RXESC_64B		0x7
+
+/* Tx Buffer Configuration (TXBC) */
+#define TXBC_TFQS_MASK		GENMASK(29, 24)
+#define TXBC_NDTB_MASK		GENMASK(21, 16)
+
+/* Tx FIFO/Queue Status (TXFQS) */
+#define TXFQS_TFQF		BIT(21)
+#define TXFQS_TFQPI_MASK	GENMASK(20, 16)
+#define TXFQS_TFGI_MASK		GENMASK(12, 8)
+#define TXFQS_TFFL_MASK		GENMASK(5, 0)
+
+/* Tx Buffer Element Size Configuration (TXESC) */
+#define TXESC_TBDS_MASK		GENMASK(2, 0)
+#define TXESC_TBDS_64B		0x7
+
+/* Tx Event FIFO Configuration (TXEFC) */
+#define TXEFC_EFS_MASK		GENMASK(21, 16)
+
+/* Tx Event FIFO Status (TXEFS) */
+#define TXEFS_TEFL		BIT(25)
+#define TXEFS_EFF		BIT(24)
+#define TXEFS_EFGI_MASK		GENMASK(12, 8)
+#define TXEFS_EFFL_MASK		GENMASK(5, 0)
+
+/* Tx Event FIFO Acknowledge (TXEFA) */
+#define TXEFA_EFAI_MASK		GENMASK(4, 0)
+
+/* Message RAM Configuration (in bytes) */
+#define SIDF_ELEMENT_SIZE	4
+#define XIDF_ELEMENT_SIZE	8
+#define RXF0_ELEMENT_SIZE	72
+#define RXF1_ELEMENT_SIZE	72
+#define RXB_ELEMENT_SIZE	72
+#define TXE_ELEMENT_SIZE	8
+#define TXB_ELEMENT_SIZE	72
+
+/* Message RAM Elements */
+#define M_CAN_FIFO_ID		0x0
+#define M_CAN_FIFO_DLC		0x4
+#define M_CAN_FIFO_DATA		0x8
+
+/* Rx Buffer Element */
+/* R0 */
+#define RX_BUF_ESI		BIT(31)
+#define RX_BUF_XTD		BIT(30)
+#define RX_BUF_RTR		BIT(29)
+/* R1 */
+#define RX_BUF_ANMF		BIT(31)
+#define RX_BUF_FDF		BIT(21)
+#define RX_BUF_BRS		BIT(20)
+#define RX_BUF_RXTS_MASK	GENMASK(15, 0)
+
+/* Tx Buffer Element */
+/* T0 */
+#define TX_BUF_ESI		BIT(31)
+#define TX_BUF_XTD		BIT(30)
+#define TX_BUF_RTR		BIT(29)
+/* T1 */
+#define TX_BUF_EFC		BIT(23)
+#define TX_BUF_FDF		BIT(21)
+#define TX_BUF_BRS		BIT(20)
+#define TX_BUF_MM_MASK		GENMASK(31, 24)
+#define TX_BUF_DLC_MASK		GENMASK(19, 16)
+
+/* Tx event FIFO Element */
+/* E1 */
+#define TX_EVENT_MM_MASK	GENMASK(31, 24)
+#define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
+
+#define can_cc_dlc2len(dlc)	(min_t(u8, (dlc), CAN_MAX_DLEN))
+#define CAN_MAX_DLEN 8
+
+/* The ID and DLC registers are adjacent in M_CAN FIFO memory,
+ * and we can save a (potentially slow) bus round trip by combining
+ * reads and writes to them.
+ */
+struct id_and_dlc {
+	u32 id;
+	u32 dlc;
+};
+
+static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
+{
+	return cdev->ops->read_reg(cdev, reg);
+}
+
+static inline void m_can_write(struct m_can_classdev *cdev, enum m_can_reg reg,
+			       u32 val)
+{
+	cdev->ops->write_reg(cdev, reg, val);
+}
+
+static int m_can_fifo_read(struct m_can_classdev *cdev,
+			   u32 fgi, unsigned int offset, void *val, size_t val_count)
+{
+	u32 addr_offset = cdev->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
+			  offset;
+
+	if (val_count == 0)
+		return 0;
+
+	return cdev->ops->read_fifo(cdev, addr_offset, val, val_count);
+}
+
+static int m_can_fifo_write(struct m_can_classdev *cdev,
+			    u32 fpi, unsigned int offset, const void *val, size_t val_count)
+{
+	u32 addr_offset = cdev->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
+			  offset;
+
+	if (val_count == 0)
+		return 0;
+
+	return cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
+}
+
+static inline int m_can_fifo_write_no_off(struct m_can_classdev *cdev,
+		u32 fpi, u32 val)
+{
+	return cdev->ops->write_fifo(cdev, fpi, &val, 1);
+}
+
+static int m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset,
+			       u32 *val)
+{
+	u32 addr_offset = cdev->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE +
+			  offset;
+
+	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
+}
+
+static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
+{
+	return !!(m_can_read(cdev, M_CAN_TXFQS) & TXFQS_TFQF);
+}
+
+static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
+{
+	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
+	u32 timeout = 10;
+	u32 val = 0;
+
+	/* Clear the Clock stop request if it was set */
+	if (cccr & CCCR_CSR)
+		cccr &= ~CCCR_CSR;
+
+	if (enable) {
+		/* enable m_can configuration */
+		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
+		udelay(5);
+		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
+		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
+	} else {
+		m_can_write(cdev, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
+	}
+
+	/* there's a delay for module initialization */
+	if (enable)
+		val = CCCR_INIT | CCCR_CCE;
+
+	while ((m_can_read(cdev, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
+		if (timeout == 0) {
+			rtcandev_warn(cdev->net, "Failed to init module\n");
+			return;
+		}
+		timeout--;
+		udelay(1);
+	}
+}
+
+static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
+{
+	/* Only interrupt line 0 is used in this driver */
+	m_can_write(cdev, M_CAN_ILE, ILE_EINT0);
+}
+
+static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
+{
+	m_can_write(cdev, M_CAN_ILE, 0x0);
+}
+
+/* For peripherals, pass skb to rx-offload, which will push skb from
+ * napi. For non-peripherals, RX is done in napi already, so push
+ * directly. timestamp is used to ensure good skb ordering in
+ * rx-offload and is ignored for non-peripherals.
+ */
+static void m_can_receive_skb(struct m_can_classdev *cdev,
+			      struct rtcan_skb *skb,
+			      u32 timestamp)
+{
+	struct rtcan_device *dev = cdev->net;
+
+	rtcan_rcv(dev, skb);
+}
+
+static int m_can_read_fifo(struct rtcan_device *dev, u32 rxfs)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+	struct id_and_dlc fifo_header;
+	u32 fgi;
+	u32 timestamp = 0;
+	int err;
+
+	/* calculate the fifo get index for where to read data */
+	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
+	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &fifo_header, 2);
+	if (err)
+		goto out_fail;
+
+	cf->can_dlc = can_cc_dlc2len((fifo_header.dlc >> 16) & 0x0F);
+
+	if (fifo_header.id & RX_BUF_XTD)
+		cf->can_id = (fifo_header.id & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	else
+		cf->can_id = (fifo_header.id >> 18) & CAN_SFF_MASK;
+
+	if (fifo_header.id & RX_BUF_ESI)
+		rtcandev_dbg(dev, "ESI Error\n");
+
+	if (!(fifo_header.dlc & RX_BUF_FDF) && (fifo_header.id & RX_BUF_RTR)) {
+		cf->can_id |= CAN_RTR_FLAG;
+	} else {
+		err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA,
+				      cf->data, DIV_ROUND_UP(cf->can_dlc, 4));
+		if (err)
+			return err;
+	}
+
+	/* acknowledge rx fifo 0 */
+	m_can_write(cdev, M_CAN_RXF0A, fgi);
+
+	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + cf->can_dlc;
+
+	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc);
+
+	m_can_receive_skb(cdev, &skb, timestamp);
+
+	return 0;
+
+out_fail:
+	rtcandev_err(dev, "FIFO read returned %d\n", err);
+	return err;
+}
+
+static int m_can_do_rx_poll(struct rtcan_device *dev, int quota)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	u32 pkts = 0;
+	u32 rxfs;
+	int err;
+
+	rxfs = m_can_read(cdev, M_CAN_RXF0S);
+	if (!(rxfs & RXFS_FFL_MASK)) {
+		rtcandev_dbg(dev, "no messages in fifo0\n");
+		return 0;
+	}
+
+	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
+		err = m_can_read_fifo(dev, rxfs);
+		if (err)
+			return err;
+
+		quota--;
+		pkts++;
+		rxfs = m_can_read(cdev, M_CAN_RXF0S);
+	}
+
+	return pkts;
+}
+
+static int m_can_handle_lost_msg(struct rtcan_device *dev)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *frame = &skb.rb_frame;
+	u32 timestamp = 0;
+
+	rtcandev_err(dev, "msg lost in rxf0\n");
+	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+
+	frame->can_id |= CAN_ERR_CRTL;
+	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+	frame->can_dlc = CAN_ERR_DLC;
+	m_can_receive_skb(cdev, &skb, timestamp);
+
+	return 1;
+}
+
+static int m_can_handle_lec_err(struct rtcan_device *dev,
+				enum m_can_lec_type lec_type)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+
+	if (lec_type == LEC_UNUSED || lec_type == LEC_NO_ERROR)
+		return 0;
+
+	if (cdev->bus_err_on < 2)
+		return 0;
+
+	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+	cdev->bus_err_on--;
+
+	/* check for 'last error code' which tells us the
+	 * type of the last error to occur on the CAN bus
+	 */
+	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	cf->can_dlc = CAN_ERR_DLC;
+	memset(&cf->data[0], 0, cf->can_dlc);
+
+	switch (lec_type) {
+	case LEC_STUFF_ERROR:
+		rtcandev_dbg(dev, "stuff error\n");
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		break;
+	case LEC_FORM_ERROR:
+		rtcandev_dbg(dev, "form error\n");
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+		break;
+	case LEC_ACK_ERROR:
+		rtcandev_dbg(dev, "ack error\n");
+		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		break;
+	case LEC_BIT1_ERROR:
+		rtcandev_dbg(dev, "bit1 error\n");
+		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		break;
+	case LEC_BIT0_ERROR:
+		rtcandev_dbg(dev, "bit0 error\n");
+		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		break;
+	case LEC_CRC_ERROR:
+		rtcandev_dbg(dev, "CRC error\n");
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		break;
+	default:
+		break;
+	}
+
+	cf->can_ifindex = dev->ifindex;
+	rtcan_rcv(dev, &skb);
+
+	return 1;
+}
+
+static int m_can_clk_start(struct m_can_classdev *cdev)
+{
+	if (cdev->pm_clock_support == 0)
+		return 0;
+
+	return pm_runtime_resume_and_get(cdev->dev);
+}
+
+static void m_can_clk_stop(struct m_can_classdev *cdev)
+{
+	if (cdev->pm_clock_support)
+		pm_runtime_put_sync(cdev->dev);
+}
+
+static int m_can_handle_state_change(struct rtcan_device *dev,
+				     enum CAN_STATE new_state)
+{
+	unsigned int reg_err_counter;
+	u8 txerr;
+	u8 rxerr;
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+
+	/* propagate the error condition to the CAN stack */
+	reg_err_counter = m_can_read(cdev, M_CAN_ECR);
+	rxerr = FIELD_GET(ECR_REC_MASK, reg_err_counter);
+	txerr = FIELD_GET(ECR_TEC_MASK, reg_err_counter);
+
+	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+	cf->can_id = CAN_ERR_FLAG;
+	cf->can_dlc = CAN_ERR_DLC;
+	memset(&cf->data[0], 0, cf->can_dlc);
+
+	switch (new_state) {
+	case CAN_STATE_ERROR_WARNING:
+		/* error warning state */
+		dev->state = CAN_STATE_ERROR_WARNING;
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = (txerr > rxerr) ?
+			      CAN_ERR_CRTL_TX_WARNING :
+			      CAN_ERR_CRTL_RX_WARNING;
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		/* error passive state */
+		dev->state = CAN_STATE_ERROR_PASSIVE;
+		cf->can_id |= CAN_ERR_CRTL;
+		if (reg_err_counter & ECR_RP)
+			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+		if (txerr > 127)
+			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+		break;
+	case CAN_STATE_BUS_OFF:
+		/* bus-off state */
+		dev->state = CAN_STATE_BUS_OFF;
+		cf->can_id |= CAN_ERR_BUSOFF;
+		/* destroy waiting senders */
+		rtdm_sem_destroy(&dev->tx_sem);
+		break;
+	default:
+		break;
+	}
+
+	/* Store the interface index */
+	cf->can_ifindex = dev->ifindex;
+	rtcan_rcv(dev, &skb);
+
+	return 1;
+}
+
+static int m_can_handle_state_errors(struct rtcan_device *dev, u32 psr)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	int work_done = 0;
+
+	if (psr & PSR_EW && cdev->net->state != CAN_STATE_ERROR_WARNING) {
+		rtcandev_dbg(dev, "entered error warning state\n");
+		work_done += m_can_handle_state_change(dev,
+						       CAN_STATE_ERROR_WARNING);
+	}
+
+	if (psr & PSR_EP && cdev->net->state != CAN_STATE_ERROR_PASSIVE) {
+		rtcandev_dbg(dev, "entered error passive state\n");
+		work_done += m_can_handle_state_change(dev,
+						       CAN_STATE_ERROR_PASSIVE);
+	}
+
+	if (psr & PSR_BO && cdev->net->state != CAN_STATE_BUS_OFF) {
+		rtcandev_dbg(dev, "entered error bus off state\n");
+		work_done += m_can_handle_state_change(dev,
+						       CAN_STATE_BUS_OFF);
+	}
+
+	return work_done;
+}
+
+static void m_can_handle_other_err(struct rtcan_device *dev, u32 irqstatus)
+{
+	if (irqstatus & IR_WDI)
+		rtcandev_err(dev, "Message RAM Watchdog event due to missing READY\n");
+	if (irqstatus & IR_BEU)
+		rtcandev_err(dev, "Bit Error Uncorrected\n");
+	if (irqstatus & IR_BEC)
+		rtcandev_err(dev, "Bit Error Corrected\n");
+	if (irqstatus & IR_TOO)
+		rtcandev_err(dev, "Timeout reached\n");
+	if (irqstatus & IR_MRAF)
+		rtcandev_err(dev, "Message RAM access failure occurred\n");
+}
+
+static inline bool is_lec_err(u32 psr)
+{
+	psr &= LEC_UNUSED;
+
+	return psr && (psr != LEC_UNUSED);
+}
+
+static inline bool m_can_is_protocol_err(u32 irqstatus)
+{
+	return irqstatus & IR_ERR_LEC_31X;
+}
+
+static int m_can_handle_protocol_error(struct rtcan_device *dev, u32 irqstatus)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *cf = &skb.rb_frame;
+
+	if (cdev->bus_err_on < 2)
+		return 0;
+
+	cdev->bus_err_on--;
+
+	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+	cf->can_id = CAN_ERR_FLAG;
+	cf->can_dlc = CAN_ERR_DLC;
+
+	/* update arbitration lost status */
+	if (cdev->version >= 31 && (irqstatus & IR_PEA)) {
+		rtcandev_dbg(dev, "Protocol error in Arbitration fail\n");
+		cf->can_id |= CAN_ERR_LOSTARB;
+		cf->data[0] |= CAN_ERR_LOSTARB_UNSPEC;
+	}
+
+	cf->can_ifindex = dev->ifindex;
+	rtcan_rcv(dev, &skb);
+
+	return 1;
+}
+
+static int m_can_handle_bus_errors(struct rtcan_device *dev, u32 irqstatus,
+				   u32 psr)
+{
+	struct m_can_classdev *priv = rtcan_priv(dev);
+	int work_done = 0;
+
+	if (irqstatus & IR_RF0L)
+		work_done += m_can_handle_lost_msg(dev);
+
+	/* handle lec errors on the bus */
+	if (is_lec_err(psr) && (priv->bus_err_on == 2))
+		work_done += m_can_handle_lec_err(dev, psr & LEC_UNUSED);
+
+	/* handle protocol errors in arbitration phase */
+	if (m_can_is_protocol_err(irqstatus) && (priv->bus_err_on == 2))
+		work_done += m_can_handle_protocol_error(dev, irqstatus);
+
+	/* other unproccessed error interrupts */
+	m_can_handle_other_err(dev, irqstatus);
+
+	return work_done;
+}
+
+static int m_can_rx_handler(struct rtcan_device *dev, int quota)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	int rx_work_or_err;
+	int work_done = 0;
+	u32 irqstatus, psr;
+
+	irqstatus = cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
+	if (!irqstatus)
+		goto end;
+
+	/* Errata workaround for issue "Needless activation of MRAF irq"
+	 * During frame reception while the MCAN is in Error Passive state
+	 * and the Receive Error Counter has the value MCAN_ECR.REC = 127,
+	 * it may happen that MCAN_IR.MRAF is set although there was no
+	 * Message RAM access failure.
+	 * If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is generated
+	 * The Message RAM Access Failure interrupt routine needs to check
+	 * whether MCAN_ECR.RP = �?�?and MCAN_ECR.REC = 127.
+	 * In this case, reset MCAN_IR.MRAF. No further action is required.
+	 */
+
+	psr = m_can_read(cdev, M_CAN_PSR);
+
+	if (irqstatus & IR_ERR_STATE)
+		work_done += m_can_handle_state_errors(dev, psr);
+
+	if (irqstatus & IR_ERR_BUS_30X)
+		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
+
+	if (irqstatus & IR_RF0N) {
+		rx_work_or_err = m_can_do_rx_poll(dev, (quota - work_done));
+		if (rx_work_or_err < 0)
+			return rx_work_or_err;
+
+		work_done += rx_work_or_err;
+	}
+end:
+	return work_done;
+}
+
+static int m_can_rx_peripheral(struct rtcan_device *dev)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	int work_done;
+
+	work_done = m_can_rx_handler(dev, M_CAN_NAPI_WEIGHT);
+
+	/* Don't re-enable interrupts if the driver had a fatal error
+	 * (e.g., FIFO read failure).
+	 */
+	if (work_done >= 0 && dev->state != CAN_STATE_BUS_OFF)
+		m_can_enable_all_interrupts(cdev);
+
+	return work_done;
+}
+
+static int m_can_echo_tx_event(struct rtcan_device *dev)
+{
+	u32 txe_count = 0;
+	u32 m_can_txefs;
+	u32 fgi = 0;
+	int i = 0;
+	unsigned int msg_mark;
+
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+
+	/* read tx event fifo status */
+	m_can_txefs = m_can_read(cdev, M_CAN_TXEFS);
+
+	/* Get Tx Event fifo element count */
+	txe_count = FIELD_GET(TXEFS_EFFL_MASK, m_can_txefs);
+
+	/* Get and process all sent elements */
+	for (i = 0; i < txe_count; i++) {
+		u32 txe, timestamp = 0;
+		int err;
+
+		/* retrieve get index */
+		fgi = FIELD_GET(TXEFS_EFGI_MASK, m_can_read(cdev, M_CAN_TXEFS));
+
+		/* get message marker, timestamp */
+		err = m_can_txe_fifo_read(cdev, fgi, 4, &txe);
+		if (err) {
+			rtcandev_err(dev, "TXE FIFO read returned %d\n", err);
+			return err;
+		}
+
+		msg_mark = FIELD_GET(TX_EVENT_MM_MASK, txe);
+		timestamp = FIELD_GET(TX_EVENT_TXTS_MASK, txe);
+
+		/* ack txe element */
+		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
+				fgi));
+	}
+
+	return 0;
+}
+
+static int m_can_isr(rtdm_irq_t *irq_handle)
+{
+	struct rtcan_device *dev = rtdm_irq_get_arg(irq_handle, void);
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	u32 ir;
+	int ret;
+
+	rtdm_lock_get(&dev->device_lock);
+	rtdm_lock_get(&rtcan_recv_list_lock);
+	rtdm_lock_get(&rtcan_socket_lock);
+
+	if (pm_runtime_suspended(cdev->dev))
+		return IRQ_NONE;
+	ir = m_can_read(cdev, M_CAN_IR);
+	if (!ir)
+		return IRQ_NONE;
+
+	/* ACK all irqs */
+	if (ir & IR_ALL_INT)
+		m_can_write(cdev, M_CAN_IR, ir);
+
+	if (cdev->ops->clear_interrupts)
+		cdev->ops->clear_interrupts(cdev);
+
+	/* schedule NAPI in case of
+	 * - rx IRQ
+	 * - state change IRQ
+	 * - bus error IRQ and bus error reporting
+	 */
+	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
+		cdev->irqstatus = ir;
+		m_can_disable_all_interrupts(cdev);
+		{
+			ret = m_can_rx_peripheral(dev);
+			if (ret < 0)
+				goto out_fail;
+		}
+	}
+
+
+	if (ir & IR_TEFN) {
+		/* New TX FIFO Element arrived */
+		if (m_can_echo_tx_event(dev) != 0)
+			goto out_fail;
+		rtdm_sem_up(&dev->tx_sem);
+		dev->tx_count++;
+	}
+
+	rtdm_lock_put(&rtcan_socket_lock);
+	rtdm_lock_put(&rtcan_recv_list_lock);
+	rtdm_lock_put(&dev->device_lock);
+	return RTDM_IRQ_HANDLED;
+
+out_fail:
+	m_can_disable_all_interrupts(cdev);
+	rtdm_lock_put(&rtcan_socket_lock);
+	rtdm_lock_put(&rtcan_recv_list_lock);
+	rtdm_lock_put(&dev->device_lock);
+	return RTDM_IRQ_HANDLED;
+}
+
+static const struct can_bittiming_const m_can_bittiming_const_31X = {
+	.name = KBUILD_MODNAME,
+	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
+	.tseg1_max = 256,
+	.tseg2_min = 2,		/* Time segment 2 = phase_seg2 */
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1,
+};
+
+static int m_can_save_bit_time(struct rtcan_device *dev, struct can_bittime *bt,
+			       rtdm_lockctx_t *lock_ctx)
+{
+	struct m_can_classdev *priv = rtcan_priv(dev);
+
+	memcpy(&priv->bit_time, bt, sizeof(*bt));
+
+	return 0;
+}
+
+static int m_can_set_bittiming(struct rtcan_device *dev)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	const struct can_bittime *bt = &cdev->bit_time;
+	u16 brp, sjw, tseg1, tseg2;
+	u32 reg_btp;
+
+	brp = bt->std.brp - 1;
+	sjw = bt->std.sjw - 1;
+	tseg1 = bt->std.prop_seg + bt->std.phase_seg1 - 1;
+	tseg2 = bt->std.phase_seg2 - 1;
+	reg_btp = FIELD_PREP(NBTP_NBRP_MASK, brp) |
+		  FIELD_PREP(NBTP_NSJW_MASK, sjw) |
+		  FIELD_PREP(NBTP_NTSEG1_MASK, tseg1) |
+		  FIELD_PREP(NBTP_NTSEG2_MASK, tseg2);
+	m_can_write(cdev, M_CAN_NBTP, reg_btp);
+
+	return 0;
+}
+
+/* Configure M_CAN chip:
+ * - set rx buffer/fifo element size
+ * - configure rx fifo
+ * - accept non-matching frame into fifo 0
+ * - configure tx buffer
+ *		- >= v3.1.x: TX FIFO is used
+ * - configure mode
+ * - setup bittiming
+ * - configure timestamp generation
+ */
+static void m_can_chip_config(struct rtcan_device *dev)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+	u32 cccr, test;
+
+	m_can_config_endisable(cdev, true);
+
+	/* RX Buffer/FIFO Element Size 64 bytes data field */
+	m_can_write(cdev, M_CAN_RXESC,
+		    FIELD_PREP(RXESC_RBDS_MASK, RXESC_64B) |
+		    FIELD_PREP(RXESC_F1DS_MASK, RXESC_64B) |
+		    FIELD_PREP(RXESC_F0DS_MASK, RXESC_64B));
+
+	/* Accept Non-matching Frames Into FIFO 0 */
+	m_can_write(cdev, M_CAN_GFC, 0x0);
+
+	if (cdev->version == 30) {
+		/* only support one Tx Buffer currently */
+		m_can_write(cdev, M_CAN_TXBC, FIELD_PREP(TXBC_NDTB_MASK, 1) |
+			    cdev->mcfg[MRAM_TXB].off);
+	} else {
+		/* TX FIFO is used for newer IP Core versions */
+		m_can_write(cdev, M_CAN_TXBC,
+			    FIELD_PREP(TXBC_TFQS_MASK,
+				       cdev->mcfg[MRAM_TXB].num) |
+			    cdev->mcfg[MRAM_TXB].off);
+	}
+
+	/* support 64 bytes payload */
+	m_can_write(cdev, M_CAN_TXESC,
+		    FIELD_PREP(TXESC_TBDS_MASK, TXESC_TBDS_64B));
+
+	/* TX Event FIFO */
+	if (cdev->version == 30) {
+		m_can_write(cdev, M_CAN_TXEFC,
+			    FIELD_PREP(TXEFC_EFS_MASK, 1) |
+			    cdev->mcfg[MRAM_TXE].off);
+	} else {
+		/* Full TX Event FIFO is used */
+		m_can_write(cdev, M_CAN_TXEFC,
+			    FIELD_PREP(TXEFC_EFS_MASK,
+				       cdev->mcfg[MRAM_TXE].num) |
+			    cdev->mcfg[MRAM_TXE].off);
+	}
+
+	/* rx fifo configuration, blocking mode, fifo size 1 */
+	m_can_write(cdev, M_CAN_RXF0C,
+		    FIELD_PREP(RXFC_FS_MASK, cdev->mcfg[MRAM_RXF0].num) |
+		    cdev->mcfg[MRAM_RXF0].off);
+
+	m_can_write(cdev, M_CAN_RXF1C,
+		    FIELD_PREP(RXFC_FS_MASK, cdev->mcfg[MRAM_RXF1].num) |
+		    cdev->mcfg[MRAM_RXF1].off);
+
+	cccr = m_can_read(cdev, M_CAN_CCCR);
+	test = m_can_read(cdev, M_CAN_TEST);
+	test &= ~TEST_LBCK;
+	if (cdev->version == 30) {
+		/* Version 3.0.x */
+
+		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_DAR |
+			  FIELD_PREP(CCCR_CMR_MASK, FIELD_MAX(CCCR_CMR_MASK)) |
+			  FIELD_PREP(CCCR_CME_MASK, FIELD_MAX(CCCR_CME_MASK)));
+
+	} else {
+		/* Version 3.1.x or 3.2.x */
+		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE |
+			  CCCR_NISO | CCCR_DAR);
+	}
+
+	/* Loopback Mode */
+	if (cdev->net->ctrl_mode & CAN_CTRLMODE_LOOPBACK) {
+		cccr |= CCCR_TEST | CCCR_MON;
+		test |= TEST_LBCK;
+	}
+
+	/* Enable Monitoring (all versions) */
+	if (cdev->net->ctrl_mode & CAN_CTRLMODE_LISTENONLY)
+		cccr |= CCCR_MON;
+
+	/* Write config */
+	m_can_write(cdev, M_CAN_CCCR, cccr);
+	m_can_write(cdev, M_CAN_TEST, test);
+
+	/* Enable interrupts */
+	m_can_write(cdev, M_CAN_IR, IR_ALL_INT);
+	m_can_write(cdev, M_CAN_IE, IR_ALL_INT);
+
+	/* route all interrupts to INT0 */
+	m_can_write(cdev, M_CAN_ILS, ILS_ALL_INT0);
+
+	/* set bittiming params */
+	m_can_set_bittiming(dev);
+
+	/* enable internal timestamp generation, with a prescalar of 16. The
+	 * prescalar is applied to the nominal bit timing
+	 */
+	m_can_write(cdev, M_CAN_TSCC, FIELD_PREP(TSCC_TCP_MASK, 0xf));
+
+	m_can_config_endisable(cdev, false);
+
+	if (cdev->ops->init)
+		cdev->ops->init(cdev);
+}
+
+static void m_can_start(struct rtcan_device *dev, rtdm_lockctx_t *lock_ctx)
+{
+	int err;
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+
+	switch (dev->state) {
+
+	case CAN_STATE_ACTIVE:
+	case CAN_STATE_BUS_WARNING:
+	case CAN_STATE_BUS_PASSIVE:
+		rtcandev_info(dev, "Mode start: state active, bus warning, or passive\n");
+		break;
+
+	case CAN_STATE_STOPPED:
+		err = rtdm_irq_request(&dev->irq_handle, cdev->irq,
+				       m_can_isr, RTDM_IRQTYPE_SHARED, "M_CAN",
+				       (void *)dev);
+		if (err) {
+			rtcandev_err(dev, "couldn't request irq %d\n",
+				     cdev->irq);
+			return;
+		}
+
+		/* start chip and queuing */
+		m_can_chip_config(dev);
+
+		dev->state = CAN_STATE_ERROR_ACTIVE;
+
+		/* enable status change, error and module interrupts */
+		m_can_enable_all_interrupts(cdev);
+
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, 1);
+
+		break;
+
+	case CAN_STATE_BUS_OFF:
+		/* start chip and queuing */
+		m_can_chip_config(dev);
+
+		dev->state = CAN_STATE_ERROR_ACTIVE;
+		/* enable status change, error and module interrupts */
+		m_can_enable_all_interrupts(cdev);
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, 1);
+		break;
+
+	case CAN_STATE_SLEEPING:
+		rtcandev_info(dev, "Mode start: state sleeping\n");
+	default:
+		/* Never reached, but we don't want nasty compiler warnings ... */
+		break;
+	}
+
+	return;
+
+}
+
+static void m_can_stop(struct rtcan_device *dev, rtdm_lockctx_t *lock_ctx)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+
+	/* disable all interrupts */
+	m_can_disable_all_interrupts(cdev);
+
+	/* Set init mode to disengage from the network */
+	m_can_config_endisable(cdev, true);
+
+	/* set the state as STOPPED */
+	dev->state = CAN_STATE_STOPPED;
+
+	rtdm_irq_free(&dev->irq_handle);
+}
+
+static int m_can_set_mode(struct rtcan_device *dev, enum CAN_MODE mode,
+			  rtdm_lockctx_t *lock_ctx)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+
+	switch (mode) {
+	case CAN_MODE_STOP:
+		rtcandev_info(dev, "Set mode: stop\n");
+		m_can_stop(dev, lock_ctx);
+		m_can_clk_stop(cdev);
+		break;
+	case CAN_MODE_START:
+		rtcandev_info(dev, "Set mode: start\n");
+		m_can_start(dev, lock_ctx);
+		m_can_clk_start(cdev);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/* Checks core release number of M_CAN
+ * returns 0 if an unsupported device is detected
+ * else it returns the release and step coded as:
+ * return value = 10 * <release> + 1 * <step>
+ */
+static int m_can_check_core_release(struct m_can_classdev *cdev)
+{
+	u32 crel_reg;
+	u8 rel;
+	u8 step;
+	int res;
+
+	/* Read Core Release Version and split into version number
+	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
+	 */
+	crel_reg = m_can_read(cdev, M_CAN_CREL);
+	rel = (u8)FIELD_GET(CREL_REL_MASK, crel_reg);
+	step = (u8)FIELD_GET(CREL_STEP_MASK, crel_reg);
+
+	if (rel == 3) {
+		/* M_CAN v3.x.y: create return value */
+		res = 30 + step;
+	} else {
+		/* Unsupported M_CAN version */
+		res = 0;
+	}
+
+	return res;
+}
+
+static int m_can_dev_setup(struct m_can_classdev *cdev)
+{
+	int m_can_version;
+
+	m_can_version = m_can_check_core_release(cdev);
+	/* return if unsupported version */
+	if (!m_can_version) {
+		dev_err(cdev->dev, "Unsupported version number: %2d",
+			m_can_version);
+		return -EINVAL;
+	}
+	/* Shared properties of all M_CAN versions */
+	cdev->version = m_can_version;
+	cdev->bus_err_on = 1;
+
+	if (cdev->ops->init)
+		cdev->ops->init(cdev);
+
+	return 0;
+}
+
+static int m_can_tx_handler(struct m_can_classdev *cdev, struct can_frame *cf)
+{
+	struct rtcan_device *dev = cdev->net;
+	struct id_and_dlc fifo_header;
+	int err;
+	int putidx;
+
+	/* Generate ID field for TX buffer Element */
+	/* Common to all supported M_CAN versions */
+	if (cf->can_id & CAN_EFF_FLAG) {
+		fifo_header.id = cf->can_id & CAN_EFF_MASK;
+		fifo_header.id |= TX_BUF_XTD;
+	} else {
+		fifo_header.id = ((cf->can_id & CAN_SFF_MASK) << 18);
+	}
+
+	if (cf->can_id & CAN_RTR_FLAG)
+		fifo_header.id |= TX_BUF_RTR;
+
+	/* Transmit routine for version >= v3.1.x */
+
+	/* Check if FIFO full */
+	if (m_can_tx_fifo_full(cdev)) {
+		/* This shouldn't happen */
+		rtcandev_warn(dev,
+			      "TX queue active although FIFO is full.");
+
+		return 1;
+	}
+
+	/* get put index for frame */
+	putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+			   m_can_read(cdev, M_CAN_TXFQS));
+
+	/* Construct DLC Field, with CAN-FD configuration.
+	 * Use the put index of the fifo as the message marker,
+	 * used in the TX interrupt for sending the correct echo frame.
+	 */
+
+	/* get CAN FD configuration of frame */
+
+	fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+			  FIELD_PREP(TX_BUF_DLC_MASK, MRAM_CFG_LEN) |
+			  TX_BUF_EFC;
+
+	err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
+	if (err)
+		goto out_fail;
+
+	err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
+			       cf->data, DIV_ROUND_UP(cf->can_dlc, 4));
+	if (err)
+		goto out_fail;
+
+	/* Push loopback echo.
+	 * Will be looped back on TX interrupt based on message marker
+	 */
+	if (rtcan_loopback_pending(dev))
+		rtcan_loopback(dev);
+
+	/* Enable TX FIFO element to start transfer  */
+	m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+	/* stop network queue if fifo full */
+	if (m_can_tx_fifo_full(cdev)) {
+		rtcandev_warn(dev, "TX queue active although FIFO is full.");
+		return 1;
+	}
+
+	return 0;
+
+out_fail:
+	rtcandev_err(dev, "FIFO write returned %d\n", err);
+	m_can_disable_all_interrupts(cdev);
+	return 1;
+}
+
+static int m_can_start_xmit(struct rtcan_device *dev, struct can_frame *cf)
+{
+	struct m_can_classdev *cdev = rtcan_priv(dev);
+
+	return m_can_tx_handler(cdev, cf);
+}
+
+static void m_can_enable_bus_err(struct rtcan_device *dev)
+{
+	struct m_can_classdev *priv = rtcan_priv(dev);
+
+	if (priv->bus_err_on < 2)
+		priv->bus_err_on = 2;
+}
+
+static int register_m_can_dev(struct rtcan_device *dev)
+{
+	int err;
+	struct m_can_classdev *priv = rtcan_priv(dev);
+
+	dev->ctrl_name = "M_CAN";
+	dev->board_name = "M_CAN";
+	dev->can_sys_clock = priv->clock_freq;
+	dev->state = CAN_STATE_STOPPED;
+	strncpy(dev->name, DEV_NAME, IFNAMSIZ);
+
+	dev->hard_start_xmit = m_can_start_xmit;
+	dev->do_set_mode = m_can_set_mode;
+	dev->do_set_bit_time = m_can_save_bit_time;
+	dev->bittiming_const = &m_can_bittiming_const_31X;
+#ifdef CONFIG_XENO_DRIVERS_CAN_BUS_ERR
+	dev->do_enable_bus_err = m_can_enable_bus_err;
+#endif
+
+	err = rtcan_dev_register(dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void m_can_of_parse_mram(struct m_can_classdev *cdev,
+				const u32 *mram_config_vals)
+{
+	cdev->mcfg[MRAM_SIDF].off = mram_config_vals[0];
+	cdev->mcfg[MRAM_SIDF].num = mram_config_vals[1];
+	cdev->mcfg[MRAM_XIDF].off = cdev->mcfg[MRAM_SIDF].off +
+				    cdev->mcfg[MRAM_SIDF].num * SIDF_ELEMENT_SIZE;
+	cdev->mcfg[MRAM_XIDF].num = mram_config_vals[2];
+	cdev->mcfg[MRAM_RXF0].off = cdev->mcfg[MRAM_XIDF].off +
+				    cdev->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
+	cdev->mcfg[MRAM_RXF0].num = mram_config_vals[3] &
+				    FIELD_MAX(RXFC_FS_MASK);
+	cdev->mcfg[MRAM_RXF1].off = cdev->mcfg[MRAM_RXF0].off +
+				    cdev->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
+	cdev->mcfg[MRAM_RXF1].num = mram_config_vals[4] &
+				    FIELD_MAX(RXFC_FS_MASK);
+	cdev->mcfg[MRAM_RXB].off = cdev->mcfg[MRAM_RXF1].off +
+				   cdev->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
+	cdev->mcfg[MRAM_RXB].num = mram_config_vals[5];
+	cdev->mcfg[MRAM_TXE].off = cdev->mcfg[MRAM_RXB].off +
+				   cdev->mcfg[MRAM_RXB].num * RXB_ELEMENT_SIZE;
+	cdev->mcfg[MRAM_TXE].num = mram_config_vals[6];
+	cdev->mcfg[MRAM_TXB].off = cdev->mcfg[MRAM_TXE].off +
+				   cdev->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
+	cdev->mcfg[MRAM_TXB].num = mram_config_vals[7] &
+				   FIELD_MAX(TXBC_NDTB_MASK);
+
+	dev_dbg(cdev->dev,
+		"sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
+		cdev->mcfg[MRAM_SIDF].off, cdev->mcfg[MRAM_SIDF].num,
+		cdev->mcfg[MRAM_XIDF].off, cdev->mcfg[MRAM_XIDF].num,
+		cdev->mcfg[MRAM_RXF0].off, cdev->mcfg[MRAM_RXF0].num,
+		cdev->mcfg[MRAM_RXF1].off, cdev->mcfg[MRAM_RXF1].num,
+		cdev->mcfg[MRAM_RXB].off, cdev->mcfg[MRAM_RXB].num,
+		cdev->mcfg[MRAM_TXE].off, cdev->mcfg[MRAM_TXE].num,
+		cdev->mcfg[MRAM_TXB].off, cdev->mcfg[MRAM_TXB].num);
+}
+
+int m_can_init_ram(struct m_can_classdev *cdev)
+{
+	int end, i, start;
+	int err = 0;
+
+	/* initialize the entire Message RAM in use to avoid possible
+	 * ECC/parity checksum errors when reading an uninitialized buffer
+	 */
+	start = cdev->mcfg[MRAM_SIDF].off;
+	end = cdev->mcfg[MRAM_TXB].off +
+	      cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
+
+	for (i = start; i < end; i += 4) {
+		err = m_can_fifo_write_no_off(cdev, i, 0x0);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(m_can_init_ram);
+
+struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
+		int sizeof_priv)
+{
+	struct m_can_classdev *class_dev = NULL;
+	u32 mram_config_vals[MRAM_CFG_LEN];
+	struct rtcan_device *rtcan_dev;
+	u32 tx_fifo_size;
+	int ret;
+
+	ret = fwnode_property_read_u32_array(dev_fwnode(dev),
+					     "bosch,mram-cfg",
+					     mram_config_vals,
+					     sizeof(mram_config_vals) / 4);
+	if (ret) {
+		dev_err(dev, "Could not get Message RAM configuration.");
+		goto out;
+	}
+
+	/* Get TX FIFO size
+	 * Defines the total amount of echo buffers for loopback
+	 */
+	tx_fifo_size = mram_config_vals[7];
+
+	/* allocate the m_can device */
+	rtcan_dev = rtcan_dev_alloc(sizeof_priv, 0);
+	if (!rtcan_dev) {
+		dev_err(dev, "Failed to allocate CAN device");
+		goto out;
+	}
+
+	class_dev = rtcan_priv(rtcan_dev);
+	class_dev->net = rtcan_dev;
+	class_dev->dev = dev;
+
+	m_can_of_parse_mram(class_dev, mram_config_vals);
+out:
+	return class_dev;
+}
+EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
+
+void m_can_class_free_dev(struct rtcan_device *dev)
+{
+	rtcan_dev_free(dev);
+}
+EXPORT_SYMBOL_GPL(m_can_class_free_dev);
+
+int m_can_class_register(struct m_can_classdev *cdev)
+{
+	int ret;
+
+	if (cdev->pm_clock_support) {
+		ret = m_can_clk_start(cdev);
+		if (ret)
+			return ret;
+	}
+
+	ret = m_can_dev_setup(cdev);
+	if (ret)
+		goto rx_offload_del;
+
+	ret = register_m_can_dev(cdev->net);
+	if (ret) {
+		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
+			cdev->net->name, ret);
+		goto rx_offload_del;
+	}
+
+	dev_info(cdev->dev, "%s device registered (irq=%d, version=%d)\n",
+		 KBUILD_MODNAME, cdev->irq, cdev->version);
+
+	/* Probe finished
+	 * Stop clocks. They will be reactivated once the M_CAN device is opened
+	 */
+	m_can_clk_stop(cdev);
+
+	return 0;
+
+rx_offload_del:
+	m_can_clk_stop(cdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(m_can_class_register);
+
+void m_can_class_unregister(struct m_can_classdev *cdev)
+{
+	m_can_clk_stop(cdev);
+	m_can_stop(cdev->net, NULL);
+	rtcan_dev_unregister(cdev->net);
+}
+EXPORT_SYMBOL_GPL(m_can_class_unregister);
+MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_AUTHOR("Liu Yang <liuyang@sinsegye.com.cn>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
+
diff --git a/kernel/drivers/can/m_can/rtcan_m_can.h b/kernel/drivers/can/m_can/rtcan_m_can.h
new file mode 100644
index 000000000..6847d979b
--- /dev/null
+++ b/kernel/drivers/can/m_can/rtcan_m_can.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// CAN bus driver for Bosch M_CAN controller
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+// Copyright (C) 2024 Liu Yang <liuyang@sinsegye.com.cn>
+/* This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _CAN_M_CAN_H_
+#define _CAN_M_CAN_H_
+
+/* m_can lec values */
+enum m_can_lec_type {
+	LEC_NO_ERROR = 0,
+	LEC_STUFF_ERROR,
+	LEC_FORM_ERROR,
+	LEC_ACK_ERROR,
+	LEC_BIT1_ERROR,
+	LEC_BIT0_ERROR,
+	LEC_CRC_ERROR,
+	LEC_UNUSED,
+};
+
+enum m_can_mram_cfg {
+	MRAM_SIDF = 0,
+	MRAM_XIDF,
+	MRAM_RXF0,
+	MRAM_RXF1,
+	MRAM_RXB,
+	MRAM_TXE,
+	MRAM_TXB,
+	MRAM_CFG_NUM,
+};
+
+/* address offset and element number for each FIFO/Buffer in the Message RAM */
+struct mram_cfg {
+	u16 off;
+	u8  num;
+};
+
+struct rtcan_m_can {
+	unsigned char (*read_reg)(struct rtcan_device *dev, int off);
+	void (*write_reg)(struct rtcan_device *dev, int off, unsigned char val);
+	void (*irq_ack)(struct rtcan_device *dev);
+	unsigned short irq_num;
+	unsigned short irq_flags;
+	unsigned char ocr;
+	unsigned char cdr;
+	char bus_err_on;
+};
+
+struct m_can_classdev;
+struct m_can_ops {
+	/* Device specific call backs */
+	int (*clear_interrupts)(struct m_can_classdev *cdev);
+	u32 (*read_reg)(struct m_can_classdev *cdev, int reg);
+	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
+	int (*read_fifo)(struct m_can_classdev *cdev, int addr_offset, void *val, size_t val_count);
+	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
+			  const void *val, size_t val_count);
+	int (*init)(struct m_can_classdev *cdev);
+};
+
+struct m_can_classdev {
+	struct rtcan_device *net;
+	struct device *dev;
+	int irq;
+	unsigned int clock_freq;
+
+	struct can_bittime bit_time;
+	int bus_err_on;
+
+	const struct can_bittiming_const *bit_timing;
+	const struct can_bittiming_const *data_timing;
+
+	struct m_can_ops *ops;
+
+	int version;
+	u32 irqstatus;
+
+	int pm_clock_support;
+	int is_peripheral;
+
+	struct mram_cfg mcfg[MRAM_CFG_NUM];
+};
+
+struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
+void m_can_class_free_dev(struct rtcan_device *dev);
+int m_can_class_register(struct m_can_classdev *cdev);
+void m_can_class_unregister(struct m_can_classdev *cdev);
+int m_can_class_get_clocks(struct m_can_classdev *cdev);
+int m_can_init_ram(struct m_can_classdev *priv);
+
+#endif	/* _CAN_M_H_ */
+
diff --git a/kernel/drivers/can/m_can/rtcan_m_can_pci.c b/kernel/drivers/can/m_can/rtcan_m_can_pci.c
new file mode 100644
index 000000000..7f6a5eeed
--- /dev/null
+++ b/kernel/drivers/can/m_can/rtcan_m_can_pci.c
@@ -0,0 +1,212 @@
+ // SPDX-License-Identifier: GPL-2.0
+ // PCI Specific M_CAN Glue
+ // Copyright (C) 2018-2020 Intel Corporation
+ // Author: Felipe Balbi (Intel)
+ // Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ // Author: Raymond Tan <raymond.tan@intel.com>
+ // Copyright (C) 2024 Liu Yang <liuyang@sinsegye.com.cn>
+ /* This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License
+  * along with this program; if not, write to the Free Software
+  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+  */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+
+#include <rtdm/driver.h>
+
+/* CAN device profile */
+#include <rtdm/can.h>
+#include <rtcan_dev.h>
+#include <rtcan_raw.h>
+#include <rtcan_internal.h>
+
+#include <rtcan_m_can.h>
+#include <linux/pm_runtime.h>
+
+#define M_CAN_PCI_MMIO_BAR		0
+
+#define M_CAN_CLOCK_FREQ_EHL		200000000
+#define CTL_CSR_INT_CTL_OFFSET		0x508
+
+struct m_can_pci_priv {
+	struct m_can_classdev cdev;
+
+	void __iomem *base;
+};
+
+static inline struct m_can_pci_priv *cdev_to_priv(struct m_can_classdev *cdev)
+{
+	return container_of(cdev, struct m_can_pci_priv, cdev);
+}
+
+static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
+{
+	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
+
+	return readl(priv->base + reg);
+}
+
+static int iomap_read_fifo(struct m_can_classdev *cdev, int offset, void *val, size_t val_count)
+{
+	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
+	void __iomem *src = priv->base + offset;
+
+	while (val_count--) {
+		*(unsigned int *)val = ioread32(src);
+		val += 4;
+		src += 4;
+	}
+
+	return 0;
+}
+
+static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
+{
+	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
+
+	writel(val, priv->base + reg);
+
+	return 0;
+}
+
+static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
+			    const void *val, size_t val_count)
+{
+	struct m_can_pci_priv *priv = cdev_to_priv(cdev);
+	void __iomem *dst = priv->base + offset;
+
+	while (val_count--) {
+		iowrite32(*(unsigned int *)val, dst);
+		val += 4;
+		dst += 4;
+	}
+
+	return 0;
+}
+
+static struct m_can_ops m_can_pci_ops = {
+	.read_reg = iomap_read_reg,
+	.write_reg = iomap_write_reg,
+	.write_fifo = iomap_write_fifo,
+	.read_fifo = iomap_read_fifo,
+};
+
+static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct device *dev = &pci->dev;
+	struct m_can_classdev *mcan_class;
+	struct m_can_pci_priv *priv;
+	void __iomem *base;
+	int ret;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	ret = pcim_iomap_regions(pci, BIT(M_CAN_PCI_MMIO_BAR), pci_name(pci));
+	if (ret)
+		return ret;
+
+	base = pcim_iomap_table(pci)[M_CAN_PCI_MMIO_BAR];
+
+	if (!base) {
+		dev_err(dev, "failed to map BARs\n");
+		return -ENOMEM;
+	}
+
+	mcan_class = m_can_class_allocate_dev(&pci->dev,
+					      sizeof(struct m_can_pci_priv));
+	if (!mcan_class)
+		return -ENOMEM;
+
+	priv = cdev_to_priv(mcan_class);
+
+	priv->base = base;
+
+	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
+	mcan_class->dev = &pci->dev;
+	mcan_class->irq = pci_irq_vector(pci, 0);
+	mcan_class->pm_clock_support = 1;
+	mcan_class->clock_freq = M_CAN_CLOCK_FREQ_EHL;
+	mcan_class->ops = &m_can_pci_ops;
+
+	pci_set_drvdata(pci, mcan_class);
+
+	ret = m_can_class_register(mcan_class);
+	if (ret)
+		goto err;
+
+	/* Enable interrupt control at CAN wrapper IP */
+	writel(0x1, base + CTL_CSR_INT_CTL_OFFSET);
+
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_allow(dev);
+
+	return 0;
+
+err:
+	pci_free_irq_vectors(pci);
+	return ret;
+}
+
+static void m_can_pci_remove(struct pci_dev *pci)
+{
+	struct m_can_classdev *mcan_class = pci_get_drvdata(pci);
+	struct m_can_pci_priv *priv = cdev_to_priv(mcan_class);
+
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
+
+	/* Disable interrupt control at CAN wrapper IP */
+	writel(0x0, priv->base + CTL_CSR_INT_CTL_OFFSET);
+
+	m_can_class_unregister(mcan_class);
+	pci_free_irq_vectors(pci);
+}
+
+static const struct pci_device_id m_can_pci_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
+	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
+	{  }	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci, m_can_pci_id_table);
+
+static struct pci_driver m_can_pci_driver = {
+	.name = "m_can_pci",
+	.probe = m_can_pci_probe,
+	.remove = m_can_pci_remove,
+	.id_table = m_can_pci_id_table,
+	.driver = {
+	},
+};
+
+module_pci_driver(m_can_pci_driver);
+
+MODULE_AUTHOR("Felipe Balbi (Intel)");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+MODULE_AUTHOR("Liu Yang <liuyang@sinsegye.com.cn>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller on PCI bus");
+
-- 
2.34.1

