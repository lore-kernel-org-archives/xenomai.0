References: <20180923153646.32193-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <70db25a6-c073-3f5a-8511-8fb2d6c4682a@siemens.com>
Date: Mon, 24 Sep 2018 15:10:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180923153646.32193-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/3] drivers/can: flexcan: rebase on mainline
 v4.14.58
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 23.09.18 17:36, Philippe Gerum wrote:
> Usable with latest Flexcan controller revisions available from recent
> i.MX series. The older driver would break when initializing the chip
> (FIFO activation), e.g.:
> 
> [  957.052272] rtcan0: real bitrate 1000000, sampling point 75.0%
> [  957.058325] rtcan0: writing ctrl=0x011a2003
> [  957.062670] rtcan0: flexcan_set_bit_time: mcr=0x5980000f ctrl=0x011a2003
> [  957.069403] rtcan0: flexcan_chip_start: writing mcr=0x79a2020f
> [  957.069421] rtcan0: flexcan_chip_start: writing ctrl=0x011aac53
> [  957.075359] Unhandled fault: imprecise external abort (0x1c06) at 0xaec71a2c
> [  957.088371] pgd = cae8c000
> [  957.091106] [aec71a2c] *pgd=9d843835, *pte=ba49d75f, *ppte=ba49dc7f
> [  957.097447] Internal error: : 1c06 [#1] SMP ARM
> [  957.108324] CPU: 1 PID: 843 Comm: rtcanconfig Not tainted 4.14.34 #1
> [  957.115391] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [  957.121155] I-pipe domain: Linux
> [  957.124404] task: caee1900 task.stack: ca5d0000
> [  957.128968] PC is at flexcan_chip_start+0x180/0x34c
> [  957.133869] LR is at flexcan_chip_start+0x178/0x34c
> 
> As a bonus, the latest work arounds addressing silicon bugs are now
> included (e.g. use of timestamp-based offloading when the FIFO
> ordering does not match the time of arrival).
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/drivers/can/rtcan_flexcan.c | 1365 +++++++++++++++++++++++-------------
>   1 file changed, 864 insertions(+), 501 deletions(-)
> 
> diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
> index ac88d079a..ed855b2ed 100644
> --- a/kernel/drivers/can/rtcan_flexcan.c
> +++ b/kernel/drivers/can/rtcan_flexcan.c
> @@ -1,14 +1,20 @@
>   /*
> - * flexcan.c - FLEXCAN RTCAN controller driver
> + * RTDM-based FLEXCAN CAN controller driver
>    *
> - * Copyright (c) 2012 Wolfgang Grandegger <wg@denx.de>
> + * Rebased on linux 4.14.58 flexcan driver:
> + * Copyright (c) 2018 Philippe Gerum <rpm@xenomai.org>
>    *
> - * Derived from the Linux-CAN driver flexcan.c:
> + * Original port to RTDM:
> + * Copyright (c) 2012 Wolfgang Grandegger <wg@denx.de>
>    *
>    * Copyright (c) 2005-2006 Varma Electronics Oy
>    * Copyright (c) 2009 Sascha Hauer, Pengutronix
> - * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
> + * Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
> + * Copyright (c) 2014 David Jander, Protonic Holland
>    *
> + * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
> + *
> + * LICENCE:
>    * This program is free software; you can redistribute it and/or
>    * modify it under the terms of the GNU General Public License as
>    * published by the Free Software Foundation version 2.
> @@ -17,41 +23,29 @@
>    * but WITHOUT ANY WARRANTY; without even the implied warranty of
>    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>    * GNU General Public License for more details.
> + *
>    */
> -
>   #include <linux/clk.h>
>   #include <linux/delay.h>
> -#include <linux/if_arp.h>
> -#include <linux/if_ether.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/list.h>
>   #include <linux/module.h>
> -#include <linux/version.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> -#include <linux/pinctrl/consumer.h>
>   #include <linux/regulator/consumer.h>
> -#include <asm/unaligned.h>
> -
>   #include <rtdm/driver.h>
> -
> -/* CAN device profile */
>   #include <rtdm/can.h>
>   #include "rtcan_dev.h"
>   #include "rtcan_raw.h"
>   #include "rtcan_internal.h"
> +#include <asm/unaligned.h>
>   
> -#define DEV_NAME	"rtcan%d"
>   #define DRV_NAME	"flexcan"
> +#define DEV_NAME	"rtcan%d"
>   
> -enum flexcan_ip_version {
> -	FLEXCAN_VER_3_0_0,
> -	FLEXCAN_VER_3_0_4,
> -	FLEXCAN_VER_10_0_12,
> -};
> +#define CAN_MAX_DLC 8
> +#define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
>   
>   /* 8 for RX fifo and 2 error handling */
>   #define FLEXCAN_NAPI_WEIGHT		(8 + 2)
> @@ -72,14 +66,15 @@ enum flexcan_ip_version {
>   #define FLEXCAN_MCR_WAK_SRC		BIT(19)
>   #define FLEXCAN_MCR_DOZE		BIT(18)
>   #define FLEXCAN_MCR_SRX_DIS		BIT(17)
> -#define FLEXCAN_MCR_BCC			BIT(16)
> +#define FLEXCAN_MCR_IRMQ		BIT(16)
>   #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
>   #define FLEXCAN_MCR_AEN			BIT(12)
> -#define FLEXCAN_MCR_MAXMB(x)		((x) & 0xf)
> -#define FLEXCAN_MCR_IDAM_A		(0 << 8)
> -#define FLEXCAN_MCR_IDAM_B		(1 << 8)
> -#define FLEXCAN_MCR_IDAM_C		(2 << 8)
> -#define FLEXCAN_MCR_IDAM_D		(3 << 8)
> +/* MCR_MAXMB: maximum used MBs is MAXMB + 1 */
> +#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
> +#define FLEXCAN_MCR_IDAM_A		(0x0 << 8)
> +#define FLEXCAN_MCR_IDAM_B		(0x1 << 8)
> +#define FLEXCAN_MCR_IDAM_C		(0x2 << 8)
> +#define FLEXCAN_MCR_IDAM_D		(0x3 << 8)
>   
>   /* FLEXCAN control register (CANCTRL) bits */
>   #define FLEXCAN_CTRL_PRESDIV(x)		(((x) & 0xff) << 24)
> @@ -105,6 +100,27 @@ enum flexcan_ip_version {
>   #define FLEXCAN_CTRL_ERR_ALL \
>   	(FLEXCAN_CTRL_ERR_BUS | FLEXCAN_CTRL_ERR_STATE)
>   
> +/* FLEXCAN control register 2 (CTRL2) bits */
> +#define FLEXCAN_CTRL2_ECRWRE		BIT(29)
> +#define FLEXCAN_CTRL2_WRMFRZ		BIT(28)
> +#define FLEXCAN_CTRL2_RFFN(x)		(((x) & 0x0f) << 24)
> +#define FLEXCAN_CTRL2_TASD(x)		(((x) & 0x1f) << 19)
> +#define FLEXCAN_CTRL2_MRP		BIT(18)
> +#define FLEXCAN_CTRL2_RRS		BIT(17)
> +#define FLEXCAN_CTRL2_EACEN		BIT(16)
> +
> +/* FLEXCAN memory error control register (MECR) bits */
> +#define FLEXCAN_MECR_ECRWRDIS		BIT(31)
> +#define FLEXCAN_MECR_HANCEI_MSK		BIT(19)
> +#define FLEXCAN_MECR_FANCEI_MSK		BIT(18)
> +#define FLEXCAN_MECR_CEI_MSK		BIT(16)
> +#define FLEXCAN_MECR_HAERRIE		BIT(15)
> +#define FLEXCAN_MECR_FAERRIE		BIT(14)
> +#define FLEXCAN_MECR_EXTERRIE		BIT(13)
> +#define FLEXCAN_MECR_RERRDIS		BIT(9)
> +#define FLEXCAN_MECR_ECCDIS		BIT(8)
> +#define FLEXCAN_MECR_NCEFAFRZ		BIT(7)
> +
>   /* FLEXCAN error and status register (ESR) bits */
>   #define FLEXCAN_ESR_TWRN_INT		BIT(17)
>   #define FLEXCAN_ESR_RWRN_INT		BIT(16)
> @@ -138,41 +154,62 @@ enum flexcan_ip_version {
>   	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>   
>   /* FLEXCAN interrupt flag register (IFLAG) bits */
> -#define FLEXCAN_TX_BUF_ID		8
> -#define FLEXCAN_IFLAG_BUF(x)		BIT(x)
> +/* Errata ERR005829 step7: Reserve first valid MB */
> +#define FLEXCAN_TX_MB_RESERVED_OFF_FIFO	8
> +#define FLEXCAN_TX_MB_OFF_FIFO		9
> +#define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
> +#define FLEXCAN_TX_MB_OFF_TIMESTAMP		1
> +#define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_OFF_TIMESTAMP + 1)
> +#define FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST	63
> +#define FLEXCAN_RX_MB_TIMESTAMP_COUNT	(FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST -	\
> +					 FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST + 1)
> +#define FLEXCAN_IFLAG_MB(x)		BIT(x)
>   #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
>   #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
>   #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
> -#define FLEXCAN_IFLAG_DEFAULT \
> -	(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW | FLEXCAN_IFLAG_RX_FIFO_AVAILABLE | \
> -	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
>   
>   /* FLEXCAN message buffers */
> -#define FLEXCAN_MB_CNT_CODE(x)		(((x) & 0xf) << 24)
> +#define FLEXCAN_MB_CODE_MASK		(0xf << 24)
> +#define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
> +#define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
> +#define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
> +#define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
> +#define FLEXCAN_MB_CODE_RX_OVERRUN	(0x6 << 24)
> +#define FLEXCAN_MB_CODE_RX_RANSWER	(0xa << 24)
> +
> +#define FLEXCAN_MB_CODE_TX_INACTIVE	(0x8 << 24)
> +#define FLEXCAN_MB_CODE_TX_ABORT	(0x9 << 24)
> +#define FLEXCAN_MB_CODE_TX_DATA		(0xc << 24)
> +#define FLEXCAN_MB_CODE_TX_TANSWER	(0xe << 24)
> +
>   #define FLEXCAN_MB_CNT_SRR		BIT(22)
>   #define FLEXCAN_MB_CNT_IDE		BIT(21)
>   #define FLEXCAN_MB_CNT_RTR		BIT(20)
>   #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
>   #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
>   
> -#define FLEXCAN_MB_CODE_MASK		(0xf0ffffff)
> +#define FLEXCAN_TIMEOUT_US		(50)
>   
> -/*
> - * FLEXCAN hardware feature flags
> +/* FLEXCAN hardware feature flags
>    *
>    * Below is some version info we got:
> - *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT
> - *                                Filter?   connected?
> - *   MX25  FlexCAN2  03.00.00.00     no         no
> - *   MX28  FlexCAN2  03.00.04.00    yes        yes
> - *   MX35  FlexCAN2  03.00.00.00     no         no
> - *   MX53  FlexCAN2  03.00.00.00    yes         no
> - *   MX6s  FlexCAN3  10.00.12.00    yes        yes
> + *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR re-
> + *                                Filter? connected?  Passive detection  ception in MB
> + *   MX25  FlexCAN2  03.00.00.00     no        no         ?       no        no
> + *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no
> + *   MX35  FlexCAN2  03.00.00.00     no        no         ?       no        no
> + *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no
> + *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
> + *   VF610 FlexCAN3  ?               no       yes        no      yes       yes?
>    *
>    * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
>    */
> -#define FLEXCAN_HAS_V10_FEATURES	BIT(1) /* For core version >= 10 */
> -#define FLEXCAN_HAS_BROKEN_ERR_STATE	BIT(2) /* [TR]WRN_INT not connected */
> +#define FLEXCAN_QUIRK_BROKEN_WERR_STATE	BIT(1) /* [TR]WRN_INT not connected */
> +#define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
> +#define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
> +#define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disable Memory error detection */
> +#define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
> +#define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
>   
>   /* Structure of the message buffer */
>   struct flexcan_mb {
> @@ -196,49 +233,98 @@ struct flexcan_regs {
>   	u32 imask1;		/* 0x28 */
>   	u32 iflag2;		/* 0x2c */
>   	u32 iflag1;		/* 0x30 */
> -	u32 crl2;		/* 0x34 */
> +	union {			/* 0x34 */
> +		u32 gfwr_mx28;	/* MX28, MX53 */
> +		u32 ctrl2;	/* MX6, VF610 */
> +	};
>   	u32 esr2;		/* 0x38 */
> -	u32 _reserved2[2];
> +	u32 imeur;		/* 0x3c */
> +	u32 lrfr;		/* 0x40 */
>   	u32 crcr;		/* 0x44 */
>   	u32 rxfgmask;		/* 0x48 */
>   	u32 rxfir;		/* 0x4c */
> -	u32 _reserved3[12];
> -	struct flexcan_mb cantxfg[64];
> +	u32 _reserved3[12];	/* 0x50 */
> +	struct flexcan_mb mb[64];	/* 0x80 */
> +	/* FIFO-mode:
> +	 *			MB
> +	 * 0x080...0x08f	0	RX message buffer
> +	 * 0x090...0x0df	1-5	reserverd
> +	 * 0x0e0...0x0ff	6-7	8 entry ID table
> +	 *				(mx25, mx28, mx35, mx53)
> +	 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
> +	 *				size conf'ed via ctrl2::RFFN
> +	 *				(mx6, vf610)
> +	 */
> +	u32 _reserved4[256];	/* 0x480 */
> +	u32 rximr[64];		/* 0x880 */
> +	u32 _reserved5[24];	/* 0x980 */
> +	u32 gfwr_mx6;		/* 0x9e0 - MX6 */
> +	u32 _reserved6[63];	/* 0x9e4 */
> +	u32 mecr;		/* 0xae0 */
> +	u32 erriar;		/* 0xae4 */
> +	u32 erridpr;		/* 0xae8 */
> +	u32 errippr;		/* 0xaec */
> +	u32 rerrar;		/* 0xaf0 */
> +	u32 rerrdr;		/* 0xaf4 */
> +	u32 rerrsynr;		/* 0xaf8 */
> +	u32 errsr;		/* 0xafc */
>   };
>   
>   struct flexcan_devtype_data {
> -	u32 features;	/* hardware controller features */
> +	u32 quirks;		/* quirks needed for different IP cores */
>   };
>   
> -struct flexcan_priv {
> -	struct rtcan_device *dev;
> +struct flexcan_timestamped_frame {
> +	struct rtcan_skb skb;
> +	u32 timestamp;
> +	struct list_head next;
> +};
>   
> -	int irq;
> -	void __iomem *base;
> -	u32 reg_esr;
> +struct flexcan_priv {
> +	unsigned int irq;
> +	unsigned int mb_first;
> +	unsigned int mb_last;
> +	struct can_bittime bittiming;
> +	struct flexcan_timestamped_frame *ts_frames;
> +
> +	struct flexcan_regs __iomem *regs;
> +	struct flexcan_mb __iomem *tx_mb;
> +	struct flexcan_mb __iomem *tx_mb_reserved;
> +	u8 tx_mb_idx;
>   	u32 reg_ctrl_default;
> +	u32 reg_imask1_default;
> +	u32 reg_imask2_default;
>   
> -	struct can_bittime bit_time;
> -	const struct flexcan_devtype_data *devtype_data;
> -	struct regulator *reg_xceiver;
>   	struct clk *clk_ipg;
>   	struct clk *clk_per;
> +	const struct flexcan_devtype_data *devtype_data;
> +	struct regulator *reg_xceiver;
> +
> +	unsigned long bus_errors;
>   };
>   
> -static struct flexcan_devtype_data fsl_p1010_devtype_data = {
> -	.features = FLEXCAN_HAS_BROKEN_ERR_STATE,
> +static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
> +	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
> +		FLEXCAN_QUIRK_BROKEN_PERR_STATE,
>   };
>   
> -static struct flexcan_devtype_data fsl_imx28_devtype_data;
> +static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
> +	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE,
> +};
>   
> -static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
> -	.features = FLEXCAN_HAS_V10_FEATURES,
> +static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
> +	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> +	FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE,
>   };
>   
> -static char *flexcan_ctrl_name = "FLEXCAN";
> +static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
> +	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> +		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
> +		FLEXCAN_QUIRK_BROKEN_PERR_STATE,
> +};
>   
> -static struct can_bittiming_const flexcan_bittiming_const = {
> -	.name = "flexcan",
> +static const struct can_bittiming_const flexcan_bittiming_const = {
> +	.name = DRV_NAME,
>   	.tseg1_min = 4,
>   	.tseg1_max = 16,
>   	.tseg2_min = 2,
> @@ -249,10 +335,12 @@ static struct can_bittiming_const flexcan_bittiming_const = {
>   	.brp_inc = 1,
>   };
>   
> -/*
> - * Abstract off the read/write for arm versus ppc.
> +/* Abstract off the read/write for arm versus ppc. This
> + * assumes that PPC uses big-endian registers and everything
> + * else uses little-endian registers, independent of CPU
> + * endianness.
>    */
> -#if defined(__BIG_ENDIAN)
> +#if defined(CONFIG_PPC)
>   static inline u32 flexcan_read(void __iomem *addr)
>   {
>   	return in_be32(addr);
> @@ -274,66 +362,136 @@ static inline void flexcan_write(u32 val, void __iomem *addr)
>   }
>   #endif
>   
> -static inline void flexcan_clk_enable(struct flexcan_priv *priv)
> +static inline void flexcan_error_irq_enable(const struct flexcan_priv *priv)
>   {
> -	clk_prepare_enable(priv->clk_ipg);
> -	clk_prepare_enable(priv->clk_per);
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	u32 reg_ctrl = (priv->reg_ctrl_default | FLEXCAN_CTRL_ERR_MSK);
> +
> +	flexcan_write(reg_ctrl, &regs->ctrl);
>   }
> -static inline void flexcan_clk_disable(struct flexcan_priv *priv)
> +
> +static inline void flexcan_error_irq_disable(const struct flexcan_priv *priv)
>   {
> -	clk_disable_unprepare(priv->clk_ipg);
> -	clk_disable_unprepare(priv->clk_per);
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	u32 reg_ctrl = (priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_MSK);
> +
> +	flexcan_write(reg_ctrl, &regs->ctrl);
>   }
>   
> -/*
> - * Switch transceiver on or off
> - */
> -static int flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
> +static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
>   {
> -	if (priv->reg_xceiver == NULL)
> +	if (!priv->reg_xceiver)
>   		return 0;
>   
> -	if (on)
> -		return regulator_enable(priv->reg_xceiver);
> +	return regulator_enable(priv->reg_xceiver);
> +}
> +
> +static inline int flexcan_transceiver_disable(const struct flexcan_priv *priv)
> +{
> +	if (!priv->reg_xceiver)
> +		return 0;
>   
>   	return regulator_disable(priv->reg_xceiver);
>   }
>   
> -static inline void flexcan_chip_enable(struct flexcan_priv *priv)
> +static int flexcan_chip_enable(struct flexcan_priv *priv)
>   {
> -	struct flexcan_regs __iomem *regs = priv->base;
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
>   	u32 reg;
>   
>   	reg = flexcan_read(&regs->mcr);
>   	reg &= ~FLEXCAN_MCR_MDIS;
>   	flexcan_write(reg, &regs->mcr);
>   
> -	udelay(10);
> +	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		udelay(10);
> +
> +	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> +		return -ETIMEDOUT;
> +
> +	return 0;
>   }
>   
> -static inline void flexcan_chip_disable(struct flexcan_priv *priv)
> +static int flexcan_chip_disable(struct flexcan_priv *priv)
>   {
> -	struct flexcan_regs __iomem *regs = priv->base;
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
>   	u32 reg;
>   
>   	reg = flexcan_read(&regs->mcr);
>   	reg |= FLEXCAN_MCR_MDIS;
>   	flexcan_write(reg, &regs->mcr);
> +
> +	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		udelay(10);
> +
> +	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
>   }
>   
> -static int flexcan_start_xmit(struct rtcan_device *dev, struct can_frame *cf)
> +static int flexcan_chip_freeze(struct rtcan_device *dev)
>   {
> -	const struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> -	u32 can_id;
> -	u32 ctrl;
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	unsigned int timeout = 1000 * 1000 * 10 / dev->baudrate;
> +	u32 reg;
> +
> +	reg = flexcan_read(&regs->mcr);
> +	reg |= FLEXCAN_MCR_HALT;
> +	flexcan_write(reg, &regs->mcr);
>   
> -	/* If DLC exceeds 8 bytes adjust it to 8 (for the payload) */
> -	if (cf->can_dlc > 8)
> -		cf->can_dlc = 8;
> +	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> +		udelay(100);
>   
> -	ctrl = FLEXCAN_MB_CNT_CODE(0xc) | (cf->can_dlc << 16);
> +	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> +	u32 reg;
> +
> +	reg = flexcan_read(&regs->mcr);
> +	reg &= ~FLEXCAN_MCR_HALT;
> +	flexcan_write(reg, &regs->mcr);
> +
> +	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> +		udelay(10);
> +
> +	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int flexcan_chip_softreset(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
> +
> +	flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> +	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST))
> +		udelay(10);
>   
> +	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int flexcan_start_xmit(struct rtcan_device *dev, struct can_frame *cf)
> +{
> +	const struct flexcan_priv *priv = rtcan_priv(dev);
> +	u32 can_id, data, ctrl;
> +
> +	ctrl = FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
>   	if (cf->can_id & CAN_EFF_FLAG) {
>   		can_id = cf->can_id & CAN_EFF_MASK;
>   		ctrl |= FLEXCAN_MB_CNT_IDE | FLEXCAN_MB_CNT_SRR;
> @@ -344,72 +502,92 @@ static int flexcan_start_xmit(struct rtcan_device *dev, struct can_frame *cf)
>   	if (cf->can_id & CAN_RTR_FLAG)
>   		ctrl |= FLEXCAN_MB_CNT_RTR;
>   
> +	if (cf->can_dlc > CAN_MAX_DLC)
> +		cf->can_dlc = CAN_MAX_DLC;
> +
>   	if (cf->can_dlc > 0) {
> -		u32 data = be32_to_cpup((__be32 *)&cf->data[0]);
> -		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[0]);
> +		data = be32_to_cpup((__be32 *)&cf->data[0]);
> +		flexcan_write(data, &priv->tx_mb->data[0]);
>   	}
> -	if (cf->can_dlc > 3) {
> -		u32 data = be32_to_cpup((__be32 *)&cf->data[4]);
> -		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[1]);
> +	if (cf->can_dlc > 4) {
> +		data = be32_to_cpup((__be32 *)&cf->data[4]);
> +		flexcan_write(data, &priv->tx_mb->data[1]);
>   	}
>   
> -	flexcan_write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
> -	flexcan_write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
> +	flexcan_write(can_id, &priv->tx_mb->can_id);
> +	flexcan_write(ctrl, &priv->tx_mb->can_ctrl);
> +
> +	/* Errata ERR005829 step8:
> +	 * Write twice INACTIVE(0x8) code to first MB.
> +	 */
> +	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +		      &priv->tx_mb_reserved->can_ctrl);
> +	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +		      &priv->tx_mb_reserved->can_ctrl);
>   
>   	return 0;
>   }
>   
> -static void flexcan_do_bus_err(struct rtcan_device *dev,
> -			       struct rtcan_rb_frame *cf, u32 reg_esr)
> +static void init_err_skb(struct rtcan_skb *skb)
> +{
> +	struct rtcan_rb_frame *cf = &skb->rb_frame;
> +
> +	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
> +	cf->can_id = CAN_ERR_FLAG;
> +	cf->can_dlc = CAN_ERR_DLC;
> +	memset(&cf->data[0], 0, cf->can_dlc);
> +}
> +
> +static void flexcan_irq_bus_err(struct rtcan_device *dev,
> +				u32 reg_esr, struct rtcan_skb *skb)
>   {
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +	struct rtcan_rb_frame *cf = &skb->rb_frame;
> +
> +	init_err_skb(skb);
> +
>   	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
>   
> -	if (reg_esr & FLEXCAN_ESR_BIT1_ERR)
> +	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
> +		rtcandev_dbg(dev, "BIT1_ERR irq\n");
>   		cf->data[2] |= CAN_ERR_PROT_BIT1;
> -	if (reg_esr & FLEXCAN_ESR_BIT0_ERR)
> +	}
> +	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
> +		rtcandev_dbg(dev, "BIT0_ERR irq\n");
>   		cf->data[2] |= CAN_ERR_PROT_BIT0;
> +	}
>   	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
> +		rtcandev_dbg(dev, "ACK_ERR irq\n");
>   		cf->can_id |= CAN_ERR_ACK;
> -		cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
> +		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
>   	}
>   	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
> +		rtcandev_dbg(dev, "CRC_ERR irq\n");
>   		cf->data[2] |= CAN_ERR_PROT_BIT;
> -		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
> +		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
>   	}
> -	if (reg_esr & FLEXCAN_ESR_FRM_ERR)
> +	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
> +		rtcandev_dbg(dev, "FRM_ERR irq\n");
>   		cf->data[2] |= CAN_ERR_PROT_FORM;
> -	if (reg_esr & FLEXCAN_ESR_STF_ERR)
> +	}
> +	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
> +		rtcandev_dbg(dev, "STF_ERR irq\n");
>   		cf->data[2] |= CAN_ERR_PROT_STUFF;
> -}
> -
> -static can_state_t flexcan_get_state(struct rtcan_device *dev, u32 reg_esr)
> -{
> -	int flt;
> -
> -	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
> -	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
> -		if (likely(!(reg_esr & (FLEXCAN_ESR_TX_WRN |
> -					FLEXCAN_ESR_RX_WRN))))
> -			return CAN_STATE_ERROR_ACTIVE;
> -		else
> -			return CAN_STATE_ERROR_WARNING;
> -	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE)) {
> -		return CAN_STATE_ERROR_PASSIVE;
> -	} else {
> -		return CAN_STATE_BUS_OFF;
>   	}
> +
> +	priv->bus_errors++;
>   }
>   
> -static void flexcan_do_state(struct rtcan_device *dev,
> -			     struct rtcan_rb_frame *cf,
> -			     can_state_t new_state)
> -{
> -	struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> -	u32 reg = flexcan_read(&regs->ecr);
> -	u8 txerr = reg & 0xff;
> -	u8 rxerr = (reg >> 8) & 0xff;
> +struct berr_counter {
> +	u16 txerr;
> +	u16 rxerr;
> +};
>   
> +static void flexcan_change_state(struct rtcan_device *dev,
> +				 struct rtcan_rb_frame *cf,
> +				 struct berr_counter *bec,
> +				 can_state_t new_state)
> +{
>   	switch (dev->state) {
>   	case CAN_STATE_ERROR_ACTIVE:
>   		/*
> @@ -422,7 +600,7 @@ static void flexcan_do_state(struct rtcan_device *dev,
>   			rtcandev_dbg(dev, "Error Warning IRQ\n");
>   
>   			cf->can_id |= CAN_ERR_CRTL;
> -			cf->data[1] = (txerr > rxerr) ?
> +			cf->data[1] = (bec->txerr > bec->rxerr) ?
>   				CAN_ERR_CRTL_TX_WARNING :
>   				CAN_ERR_CRTL_RX_WARNING;
>   		}
> @@ -437,7 +615,7 @@ static void flexcan_do_state(struct rtcan_device *dev,
>   			rtcandev_dbg(dev, "Error Passive IRQ\n");
>   
>   			cf->can_id |= CAN_ERR_CRTL;
> -			cf->data[1] = (txerr > rxerr) ?
> +			cf->data[1] = (bec->txerr > bec->rxerr) ?
>   				CAN_ERR_CRTL_TX_PASSIVE :
>   				CAN_ERR_CRTL_RX_PASSIVE;
>   		}
> @@ -465,186 +643,307 @@ static void flexcan_do_state(struct rtcan_device *dev,
>   	default:
>   		break;
>   	}
> +
> +	dev->state = new_state;
>   }
>   
> -static void flexcan_rx_interrupt(struct rtcan_device *dev,
> -				 struct rtcan_skb *skb)
> +static bool flexcan_irq_state(struct rtcan_device *dev, u32 reg_esr,
> +			      struct rtcan_skb *skb)
>   {
> -	const struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> -	struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	enum CAN_STATE new_state, rx_state, tx_state;
> +	struct rtcan_rb_frame *cf = &skb->rb_frame;
> +	struct berr_counter bec;
> +	u32 reg;
> +	int flt;
> +
> +	reg = flexcan_read(&regs->ecr);
> +	bec.txerr = (reg >> 0) & 0xff;
> +	bec.rxerr = (reg >> 8) & 0xff;
> +
> +	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
> +	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
> +		tx_state = unlikely(reg_esr & FLEXCAN_ESR_TX_WRN) ?
> +			CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
> +		rx_state = unlikely(reg_esr & FLEXCAN_ESR_RX_WRN) ?
> +			CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
> +		new_state = max(tx_state, rx_state);
> +	} else
> +		new_state = flt == FLEXCAN_ESR_FLT_CONF_PASSIVE ?
> +			CAN_STATE_ERROR_PASSIVE : CAN_STATE_BUS_OFF;
> +
> +	/* state hasn't changed */
> +	if (likely(new_state == dev->state))
> +		return false;
> +
> +	init_err_skb(skb);
> +	
> +	flexcan_change_state(dev, cf, &bec, new_state);
> +
> +	return true;
> +}
> +
> +static unsigned int flexcan_mailbox_read(struct rtcan_device *dev,
> +					 struct rtcan_skb *skb,
> +					 u32 *timestamp, unsigned int n)
> +{
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	struct flexcan_mb __iomem *mb = &regs->mb[n];
> +	u32 reg_ctrl, reg_id, reg_iflag1, code;
>   	struct rtcan_rb_frame *cf = &skb->rb_frame;
> -	u32 reg_ctrl, reg_id;
>   
> -	reg_ctrl = flexcan_read(&mb->can_ctrl);
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> +		do {
> +			reg_ctrl = flexcan_read(&mb->can_ctrl);
> +		} while (reg_ctrl & FLEXCAN_MB_CODE_RX_BUSY_BIT);
> +
> +		/* is this MB empty? */
> +		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
> +		if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
> +		    (code != FLEXCAN_MB_CODE_RX_OVERRUN))
> +			return 0;
> +	} else {
> +		reg_iflag1 = flexcan_read(&regs->iflag1);
> +		if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
> +			return 0;
> +
> +		reg_ctrl = flexcan_read(&mb->can_ctrl);
> +	}
> +
> +	/* increase timstamp to full 32 bit */
> +	*timestamp = reg_ctrl << 16;
> +
> +	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
>   	reg_id = flexcan_read(&mb->can_id);
>   	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
>   		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
>   	else
>   		cf->can_id = (reg_id >> 18) & CAN_SFF_MASK;
>   
> -	cf->can_dlc = (reg_ctrl >> 16) & 0xf;
> -	/* If DLC exceeds 8 bytes adjust it to 8 (for the payload size) */
> -	if (cf->can_dlc > 8)
> -		cf->can_dlc = 8;
> +	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
>   
> -	if (reg_ctrl & FLEXCAN_MB_CNT_RTR) {
> +	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
>   		cf->can_id |= CAN_RTR_FLAG;
> -		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
> -	} else {
> -		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + cf->can_dlc;
> -		put_unaligned_be32(flexcan_read(&mb->data[0]), cf->data + 0);
> -		put_unaligned_be32(flexcan_read(&mb->data[1]), cf->data + 4);
> -	}
> +	else
> +		skb->rb_frame_size += cf->can_dlc;
> +
> +	put_unaligned_be32(flexcan_read(&mb->data[0]), cf->data + 0);
> +	put_unaligned_be32(flexcan_read(&mb->data[1]), cf->data + 4);
>   
> -	/* Store the interface index */
>   	cf->can_ifindex = dev->ifindex;
>   
>   	/* mark as read */
> -	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> -	flexcan_read(&regs->timer);
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> +		/* Clear IRQ */
> +		if (n < 32)
> +			flexcan_write(BIT(n), &regs->iflag1);
> +		else
> +			flexcan_write(BIT(n - 32), &regs->iflag2);
> +	} else {
> +		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
> +		flexcan_read(&regs->timer);
> +	}
> +
> +	return 1;
>   }
>   
> -static void flexcan_err_interrupt(struct rtcan_device *dev,
> -				  struct rtcan_skb *skb,
> -				  u32 reg_iflag1, u32 reg_esr,
> -				  can_state_t new_state)
> +static inline bool flexcan_rx_le(struct flexcan_priv *priv, unsigned int a, unsigned int b)
>   {
> -	const struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> -	struct rtcan_rb_frame *cf = &skb->rb_frame;
> +	if (priv->mb_first < priv->mb_last)
> +		return a <= b;
>   
> -	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
> +	return a >= b;
> +}
>   
> -	cf->can_id = CAN_ERR_FLAG;
> -	cf->can_dlc = CAN_ERR_DLC;
> -	memset(&cf->data[0], 0, cf->can_dlc);
> +static inline unsigned int flexcan_rx_inc(struct flexcan_priv *priv, unsigned int *val)
> +{
> +	if (priv->mb_first < priv->mb_last)
> +		return (*val)++;
>   
> -	/* State changed? */
> -	if (new_state != dev->state) {
> -		flexcan_do_state(dev, cf, new_state);
> -		dev->state = new_state;
> +	return (*val)--;
> +}
> +
> +static int flexcan_mailbox_read_timestamp(struct rtcan_device *dev, u64 pending)
> +{
> +	struct flexcan_timestamped_frame *new, *pos, *tmp;
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +	struct list_head q, *head;
> +	int i, count = 0;
> +
> +	INIT_LIST_HEAD(&q);
> +
> +	for (i = priv->mb_first;
> +	     flexcan_rx_le(priv, i, priv->mb_last);
> +	     flexcan_rx_inc(priv, &i)) {
> +		if (!(pending & BIT_ULL(i)))
> +			continue;
> +
> +		new = priv->ts_frames + (i - priv->mb_first);
> +		if (!flexcan_mailbox_read(dev, &new->skb, &new->timestamp, i))
> +			break;
> +
> +		head = &q;
> +		if (list_empty(&q))
> +			goto add;
> +
> +		list_for_each_entry_reverse(pos, &q, next) {
> +			/*
> +			 * Substract two u32 and return result as int,
> +			 * to keep difference steady around the u32
> +			 * overflow.
> +			 */
> +			if (((int)(new->timestamp - pos->timestamp)) >= 0) {
> +				head = &pos->next;
> +				break;
> +			}
> +		}
> +	add:
> +		list_add(&new->next, head);
> +		count++;
>   	}
>   
> -	/* FIFO overflow? */
> -	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
> -		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
> -		cf->can_id |= CAN_ERR_CRTL;
> -		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> +	if (list_empty(&q))
> +		return 0;
> +
> +	list_for_each_entry_safe(pos, tmp, &q, next)
> +		rtcan_rcv(dev, &pos->skb);
> +	
> +	return count;
> +}
> +
> +static void flexcan_mailbox_read_fifo(struct rtcan_device *dev)
> +{
> +	struct rtcan_skb skb;
> +	u32 timestamp;
> +	
> +	for (;;) {
> +		if (!flexcan_mailbox_read(dev, &skb, &timestamp, 0))
> +			break;
> +		rtcan_rcv(dev, &skb);
>   	}
> +}
> +
> +static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	u32 iflag1, iflag2;
> +
> +	iflag2 = flexcan_read(&regs->iflag2) & priv->reg_imask2_default;
> +	iflag1 = flexcan_read(&regs->iflag1) & priv->reg_imask1_default &
> +		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
>   
> -	/* Bus errors? */
> -	if (reg_esr & FLEXCAN_ESR_ERR_BUS)
> -		flexcan_do_bus_err(dev, cf, reg_esr);
> +	return (u64)iflag2 << 32 | iflag1;
>   }
>   
> -static int flexcan_interrupt(rtdm_irq_t *irq_handle)
> +static int flexcan_do_rx(struct rtcan_device *dev, u32 reg_iflag1)
>   {
> -	struct rtcan_device *dev = rtdm_irq_get_arg(irq_handle, void);
>   	struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> +	struct flexcan_regs __iomem *regs = priv->regs;
>   	struct rtcan_skb skb;
> +	struct rtcan_rb_frame *cf = &skb.rb_frame;
> +	bool input = false;
> +	u64 reg;
> +	int ret;
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> +		while ((reg = flexcan_read_reg_iflag_rx(priv))) {
> +			input = true;
> +			ret = flexcan_mailbox_read_timestamp(dev, reg);
> +			if (!ret)
> +				break;
> +		}
> +	} else {
> +		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
> +			flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
> +			init_err_skb(&skb);
> +			cf->can_id |= CAN_ERR_CRTL;
> +			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> +			input = true;
> +		} else  if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
> +			flexcan_mailbox_read_fifo(dev);
> +			input = true;
> +		}
> +	}
> +
> +	return input;
> +}
> +
> +static int flexcan_irq(rtdm_irq_t *irq_handle)
> +{
> +	struct rtcan_device *dev = rtdm_irq_get_arg(irq_handle, void);
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +	struct flexcan_regs __iomem *regs = priv->regs;
>   	u32 reg_iflag1, reg_esr;
> -	int recv_lock_free = 1;
> -	int ret = RTDM_IRQ_NONE;
> -	can_state_t new_state;
> +	struct rtcan_skb skb;
> +	int handled;
>   
>   	rtdm_lock_get(&dev->device_lock);
> +	rtdm_lock_get(&rtcan_recv_list_lock);
> +	rtdm_lock_get(&rtcan_socket_lock);
>   
>   	reg_iflag1 = flexcan_read(&regs->iflag1);
> -	reg_esr = flexcan_read(&regs->esr);
> -	/* ACK all bus error and state change IRQ sources */
> -	if (reg_esr & FLEXCAN_ESR_ALL_INT)
> -		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>   
> -	/* transmission complete interrupt */
> -	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
> -		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
> +	/* reception interrupt */
> +	if (flexcan_do_rx(dev, reg_iflag1))
> +		handled = RTDM_IRQ_HANDLED;
>   
> -		/* Wake up a sender */
> +	/* transmission complete interrupt */
> +	if (reg_iflag1 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
> +		/* after sending a RTR frame MB is in RX mode */
> +		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +			      &priv->tx_mb->can_ctrl);
> +		flexcan_write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
>   		rtdm_sem_up(&dev->tx_sem);
> -		if (rtcan_loopback_pending(dev)) {
> -			if (recv_lock_free) {
> -				recv_lock_free = 0;
> -				rtdm_lock_get(&rtcan_recv_list_lock);
> -				rtdm_lock_get(&rtcan_socket_lock);
> -			}
> +		if (rtcan_loopback_pending(dev))
>   			rtcan_loopback(dev);
> -		}
> -		ret = RTDM_IRQ_HANDLED;
> +		handled = RTDM_IRQ_HANDLED;
>   	}
>   
> -	/* RX interrupt? */
> -	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
> -		flexcan_rx_interrupt(dev, &skb);
> -		reg_iflag1 = flexcan_read(&regs->iflag1);
> -
> -		/* Take more locks. Ensure that they are taken and
> -		 * released only once in the IRQ handler. */
> -		/* WARNING: Nested locks are dangerous! But they are
> -		 * nested only in this routine so a deadlock should
> -		 * not be possible. */
> -		if (recv_lock_free) {
> -			recv_lock_free = 0;
> -			rtdm_lock_get(&rtcan_recv_list_lock);
> -			rtdm_lock_get(&rtcan_socket_lock);
> -		}
> +	reg_esr = flexcan_read(&regs->esr);
>   
> -		/* Pass received frame out to the sockets */
> -		rtcan_rcv(dev, &skb);
> -		ret = RTDM_IRQ_HANDLED;
> +	/* ACK all bus error and state change IRQ sources */
> +	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
> +		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
> +		handled = RTDM_IRQ_HANDLED;
>   	}
>   
> -	/* Error or state change Interrupt? */
> -	new_state = flexcan_get_state(dev, reg_esr);
> -	if ((new_state != dev->state) ||
> -	     (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) ||
> -	     (reg_esr & FLEXCAN_ESR_ERR_BUS)) {
> -		/* Check error condition and fill error frame */
> -		flexcan_err_interrupt(dev, &skb, reg_iflag1, reg_esr,
> -				      new_state);
> -
> -		if (recv_lock_free) {
> -			recv_lock_free = 0;
> -			rtdm_lock_get(&rtcan_recv_list_lock);
> -			rtdm_lock_get(&rtcan_socket_lock);
> +	/* state change interrupt or broken error state quirk fix is enabled */
> +	if (reg_esr & FLEXCAN_ESR_ERR_STATE)
> +		handled = RTDM_IRQ_HANDLED;
> +	else if (priv->devtype_data->quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
> +					       FLEXCAN_QUIRK_BROKEN_PERR_STATE))
> +		goto esr_err;
> +	
> +	if (reg_esr & FLEXCAN_ESR_ERR_STATE) {
> +	esr_err:
> +		if (flexcan_irq_state(dev, reg_esr, &skb)) {
> +			rtcan_rcv(dev, &skb);
>   		}
> +	}
>   
> -		/* Pass error frame out to the sockets */
> +	/* bus error IRQ - report unconditionally */
> +	if (reg_esr & FLEXCAN_ESR_ERR_BUS) {
> +		flexcan_irq_bus_err(dev, reg_esr, &skb);
>   		rtcan_rcv(dev, &skb);
> -		ret = RTDM_IRQ_HANDLED;
> +		handled = RTDM_IRQ_HANDLED;
>   	}
>   
> -	if (!recv_lock_free) {
> -		rtdm_lock_put(&rtcan_socket_lock);
> -		rtdm_lock_put(&rtcan_recv_list_lock);
> -	}
> +	rtdm_lock_put(&rtcan_socket_lock);
> +	rtdm_lock_put(&rtcan_recv_list_lock);
>   	rtdm_lock_put(&dev->device_lock);
>   
> -	return ret;
> +	return handled;
>   }
>   
> -static int flexcan_save_bit_time(struct rtcan_device *dev,
> -				 struct can_bittime *bt,
> -				 rtdm_lockctx_t *lock_ctx)
> +static void flexcan_set_bittiming(struct rtcan_device *dev)
>   {
> -	struct flexcan_priv *priv = rtcan_priv(dev);
> -
> -	memcpy(&priv->bit_time, bt, sizeof(*bt));
> -
> -	return 0;
> -}
> -
> -static int flexcan_set_bit_time(struct rtcan_device *dev)
> -{
> -	struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> -	struct can_bittime *bt = &priv->bit_time;
> +	const struct flexcan_priv *priv = rtcan_priv(dev);
> +	const struct can_bittime *bt = &priv->bittiming;
> +	struct flexcan_regs __iomem *regs = priv->regs;
>   	u32 reg;
>   
> -	if (bt->type != CAN_BITTIME_STD)
> -		return -EINVAL;
> -
>   	reg = flexcan_read(&regs->ctrl);
>   	reg &= ~(FLEXCAN_CTRL_PRESDIV(0xff) |
>   		 FLEXCAN_CTRL_RJW(0x3) |
> @@ -668,18 +967,15 @@ static int flexcan_set_bit_time(struct rtcan_device *dev)
>   	if (dev->ctrl_mode & CAN_CTRLMODE_3_SAMPLES)
>   		reg |= FLEXCAN_CTRL_SMP;
>   
> -	rtcandev_info(dev, "writing ctrl=0x%08x\n", reg);
> +	rtcandev_dbg(dev, "writing ctrl=0x%08x\n", reg);
>   	flexcan_write(reg, &regs->ctrl);
>   
>   	/* print chip status */
>   	rtcandev_dbg(dev, "%s: mcr=0x%08x ctrl=0x%08x\n", __func__,
> -		     flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
> -
> -	return 0;
> +		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
>   }
>   
> -/*
> - * flexcan_chip_start
> +/* flexcan_chip_start
>    *
>    * this functions is entered with clocks enabled
>    *
> @@ -687,50 +983,59 @@ static int flexcan_set_bit_time(struct rtcan_device *dev)
>   static int flexcan_chip_start(struct rtcan_device *dev)
>   {
>   	struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> -	unsigned int i;
> -	int err;
> -	u32 reg_mcr, reg_ctrl;
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
> +	int err, i;
> +
> +	err = clk_prepare_enable(priv->clk_ipg);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(priv->clk_per);
> +	if (err)
> +		goto out_disable_ipg;
>   
>   	/* enable module */
> -	flexcan_chip_enable(priv);
> +	err = flexcan_chip_enable(priv);
> +	if (err)
> +		goto out_disable_per;
>   
>   	/* soft reset */
> -	flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
> -	udelay(10);
> -
> -	reg_mcr = flexcan_read(&regs->mcr);
> -	if (reg_mcr & FLEXCAN_MCR_SOFTRST) {
> -		rtcandev_err(dev,
> -			     "Failed to softreset can module (mcr=0x%08x)\n",
> -			     reg_mcr);
> -		err = -ENODEV;
> -		goto out;
> -	}
> +	err = flexcan_chip_softreset(priv);
> +	if (err)
> +		goto out_chip_disable;
>   
> -	flexcan_set_bit_time(dev);
> +	flexcan_set_bittiming(dev);
>   
> -	/*
> -	 * MCR
> +	/* MCR
>   	 *
>   	 * enable freeze
>   	 * enable fifo
>   	 * halt now
>   	 * only supervisor access
>   	 * enable warning int
> -	 * choose format C
>   	 * disable local echo
> -	 *
> +	 * enable individual RX masking
> +	 * choose format C
> +	 * set max mailbox number
>   	 */
>   	reg_mcr = flexcan_read(&regs->mcr);
> -	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
> -		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
> -		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS;
> +	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
> +	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
> +		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
> +		FLEXCAN_MCR_IDAM_C;
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> +		reg_mcr &= ~FLEXCAN_MCR_FEN;
> +		reg_mcr |= FLEXCAN_MCR_MAXMB(priv->mb_last);
> +	} else {
> +		reg_mcr |= FLEXCAN_MCR_FEN |
> +			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
> +	}
>   	rtcandev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
>   	flexcan_write(reg_mcr, &regs->mcr);
>   
> -	/*
> -	 * CTRL
> +	/* CTRL
>   	 *
>   	 * disable timer sync feature
>   	 *
> @@ -745,116 +1050,143 @@ static int flexcan_chip_start(struct rtcan_device *dev)
>   	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
>   	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
>   		FLEXCAN_CTRL_ERR_STATE;
> -	/*
> -	 * enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
> +
> +	/* enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
>   	 * on most Flexcan cores, too. Otherwise we don't get
>   	 * any error warning or passive interrupts.
>   	 */
> -	if (priv->devtype_data->features & FLEXCAN_HAS_BROKEN_ERR_STATE)
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE)
>   		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
> +	else
> +		reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;
>   
>   	/* save for later use */
>   	priv->reg_ctrl_default = reg_ctrl;
> +	/* leave interrupts disabled for now */
> +	reg_ctrl &= ~FLEXCAN_CTRL_ERR_ALL;
>   	rtcandev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
>   	flexcan_write(reg_ctrl, &regs->ctrl);
>   
> -	for (i = 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
> -		flexcan_write(0, &regs->cantxfg[i].can_ctrl);
> -		flexcan_write(0, &regs->cantxfg[i].can_id);
> -		flexcan_write(0, &regs->cantxfg[i].data[0]);
> -		flexcan_write(0, &regs->cantxfg[i].data[1]);
> +	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
> +		reg_ctrl2 = flexcan_read(&regs->ctrl2);
> +		reg_ctrl2 |= FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
> +		flexcan_write(reg_ctrl2, &regs->ctrl2);
> +	}
> +
> +	/* clear and invalidate all mailboxes first */
> +	for (i = priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
> +		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
> +			      &regs->mb[i].can_ctrl);
> +	}
>   
> -		/* put MB into rx queue */
> -		flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
> -			&regs->cantxfg[i].can_ctrl);
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> +		for (i = priv->mb_first; i <= priv->mb_last; i++)
> +			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
> +				      &regs->mb[i].can_ctrl);
>   	}
>   
> +	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
> +	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +		      &priv->tx_mb_reserved->can_ctrl);
> +
> +	/* mark TX mailbox as INACTIVE */
> +	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
> +		      &priv->tx_mb->can_ctrl);
> +
>   	/* acceptance mask/acceptance code (accept everything) */
>   	flexcan_write(0x0, &regs->rxgmask);
>   	flexcan_write(0x0, &regs->rx14mask);
>   	flexcan_write(0x0, &regs->rx15mask);
>   
> -	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_RXFG)
>   		flexcan_write(0x0, &regs->rxfgmask);
>   
> -	flexcan_transceiver_switch(priv, 1);
> +	/* clear acceptance filters */
> +	for (i = 0; i < ARRAY_SIZE(regs->mb); i++)
> +		flexcan_write(0, &regs->rximr[i]);
> +
> +	/* On Vybrid, disable memory error detection interrupts
> +	 * and freeze mode.
> +	 * This also works around errata e5295 which generates
> +	 * false positive memory errors and put the device in
> +	 * freeze mode.
> +	 */
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_MECR) {
> +		/* Follow the protocol as described in "Detection
> +		 * and Correction of Memory Errors" to write to
> +		 * MECR register
> +		 */
> +		reg_ctrl2 = flexcan_read(&regs->ctrl2);
> +		reg_ctrl2 |= FLEXCAN_CTRL2_ECRWRE;
> +		flexcan_write(reg_ctrl2, &regs->ctrl2);
> +
> +		reg_mecr = flexcan_read(&regs->mecr);
> +		reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
> +		flexcan_write(reg_mecr, &regs->mecr);
> +		reg_mecr &= ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HANCEI_MSK |
> +			      FLEXCAN_MECR_FANCEI_MSK);
> +		flexcan_write(reg_mecr, &regs->mecr);
> +	}
> +
> +	err = flexcan_transceiver_enable(priv);
> +	if (err)
> +		goto out_chip_disable;
>   
>   	/* synchronize with the can bus */
> -	reg_mcr = flexcan_read(&regs->mcr);
> -	reg_mcr &= ~FLEXCAN_MCR_HALT;
> -	flexcan_write(reg_mcr, &regs->mcr);
> +	err = flexcan_chip_unfreeze(priv);
> +	if (err)
> +		goto out_transceiver_disable;
>   
>   	dev->state = CAN_STATE_ERROR_ACTIVE;
>   
> -	/* enable FIFO interrupts */
> -	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
> +	/* enable interrupts atomically */
> +	rtdm_irq_disable(&dev->irq_handle);
> +	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
> +	flexcan_write(priv->reg_imask1_default, &regs->imask1);
> +	flexcan_write(priv->reg_imask2_default, &regs->imask2);
> +	rtdm_irq_enable(&dev->irq_handle);
>   
>   	/* print chip status */
>   	rtcandev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
> -		     flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
> +		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
>   
>   	return 0;
>   
> -out:
> + out_transceiver_disable:
> +	flexcan_transceiver_disable(priv);
> + out_chip_disable:
>   	flexcan_chip_disable(priv);
> + out_disable_per:
> +	clk_disable_unprepare(priv->clk_per);
> + out_disable_ipg:
> +	clk_disable_unprepare(priv->clk_ipg);
> +
>   	return err;
>   }
>   
> -/*
> - * flexcan_chip_stop
> +/* flexcan_chip_stop
>    *
>    * this functions is entered with clocks enabled
> - *
>    */
>   static void flexcan_chip_stop(struct rtcan_device *dev)
>   {
>   	struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> -	u32 reg;
> +	struct flexcan_regs __iomem *regs = priv->regs;
> +
> +	/* freeze + disable module */
> +	flexcan_chip_freeze(dev);
> +	flexcan_chip_disable(priv);
>   
>   	/* Disable all interrupts */
> +	flexcan_write(0, &regs->imask2);
>   	flexcan_write(0, &regs->imask1);
> +	flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
> +		      &regs->ctrl);
>   
> -	/* Disable + halt module */
> -	reg = flexcan_read(&regs->mcr);
> -	reg |= FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
> -	flexcan_write(reg, &regs->mcr);
> -
> -	flexcan_transceiver_switch(priv, 0);
> -	dev->state = CAN_STATE_STOPPED;
> -
> -	return;
> -}
> +	flexcan_transceiver_disable(priv);
>   
> -static int flexcan_mode_stop(struct rtcan_device *dev, rtdm_lockctx_t *lock_ctx)
> -{
> -	struct flexcan_priv *priv = rtcan_priv(dev);
> -	can_state_t state;
> -
> -	state = dev->state;
> -	/* If controller is not operating anyway, go out */
> -	if (!CAN_STATE_OPERATING(state))
> -		goto out;
> -
> -	/*
> -	 * Drop the device lock early, we should not need it and we
> -	 * may not hold it for calling the regular kernel
> -	 * infrastructure.
> -	 */
> -	rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
> -
> -	flexcan_chip_stop(dev);
> -
> -	/* Wake up waiting senders */
> -	rtdm_sem_destroy(&dev->tx_sem);
> -
> -	rtdm_irq_free(&dev->irq_handle);
> -
> -	flexcan_clk_disable(priv);
> -
> -	rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
> -out:
> -	return 0;
> +	clk_disable_unprepare(priv->clk_per);
> +	clk_disable_unprepare(priv->clk_ipg);
>   }
>   
>   static int flexcan_mode_start(struct rtcan_device *dev,
> @@ -873,26 +1205,26 @@ static int flexcan_mode_start(struct rtcan_device *dev,
>   		break;
>   
>   	case CAN_STATE_STOPPED:
> -		flexcan_clk_enable(priv);
> -
>   		/* Register IRQ handler and pass device structure as arg */
>   		err = rtdm_irq_request(&dev->irq_handle, priv->irq,
> -				       flexcan_interrupt, 0, DRV_NAME,
> -				       (void *)dev);
> +				       flexcan_irq, 0, DRV_NAME,
> +				       dev);
>   		if (err) {
>   			rtcandev_err(dev, "couldn't request irq %d\n",
>   				     priv->irq);
> -			goto out_clk_disable;
> +			goto out;
>   		}
>   
> -		/* start chip and queuing */
> -		err = flexcan_chip_start(dev);
> -		if (err)
> -			goto out_irq_free;
> -
>   		/* Set up sender "mutex" */
>   		rtdm_sem_init(&dev->tx_sem, 1);
>   
> +		/* start chip and queuing */
> +		err = flexcan_chip_start(dev);
> +		if (err) {
> +			rtdm_irq_free(&dev->irq_handle);
> +			rtdm_sem_destroy(&dev->tx_sem);
> +			goto out;
> +		}
>   		break;
>   
>   	case CAN_STATE_BUS_OFF:
> @@ -900,62 +1232,91 @@ static int flexcan_mode_start(struct rtcan_device *dev,
>   		rtdm_sem_init(&dev->tx_sem, 1);
>   		/* start chip and queuing */
>   		err = flexcan_chip_start(dev);
> -		if (err)
> +		if (err) {
> +			rtdm_sem_destroy(&dev->tx_sem);
>   			goto out;
> +		}
>   		break;
>   
>   	case CAN_STATE_SLEEPING:
>   	default:
> -		/* Never reached, but we don't want nasty compiler warnings ... */
>   		err = 0;
>   		break;
>   	}
>   
> -	goto out;
> -
> -out_irq_free:
> -	rtdm_irq_free(&dev->irq_handle);
> -out_clk_disable:
> -	flexcan_clk_disable(priv);
>   out:
>   	rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
>   
>   	return err;
>   }
>   
> -int flexcan_set_mode(struct rtcan_device *dev, can_mode_t mode,
> -		     rtdm_lockctx_t *lock_ctx)
> +static int flexcan_mode_stop(struct rtcan_device *dev,
> +			     rtdm_lockctx_t *lock_ctx)
>   {
> -	switch (mode) {
> +	if (!CAN_STATE_OPERATING(dev->state))
> +		return 0;
>   
> -	case CAN_MODE_STOP:
> -		return flexcan_mode_stop(dev, lock_ctx);
> +	dev->state = CAN_STATE_STOPPED;
>   
> -	case CAN_MODE_START:
> +	rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
> +
> +	flexcan_chip_stop(dev);
> +	rtdm_irq_free(&dev->irq_handle);
> +	rtdm_sem_destroy(&dev->tx_sem);
> +
> +	rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
> +
> +	return 0;
> +}
> +
> +static int flexcan_set_mode(struct rtcan_device *dev, can_mode_t mode,
> +			    rtdm_lockctx_t *lock_ctx)
> +{
> +	if (mode == CAN_MODE_START)
>   		return flexcan_mode_start(dev, lock_ctx);
>   
> -	default:
> -		break;
> -	}
> +	if (mode == CAN_MODE_STOP)
> +		return flexcan_mode_stop(dev, lock_ctx);
>   
>   	return -EOPNOTSUPP;
>   }
>   
> +static int flexcan_copy_bittiming(struct rtcan_device *dev,
> +				  struct can_bittime *bt,
> +				  rtdm_lockctx_t *lock_ctx)
> +{
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +
> +	memcpy(&priv->bittiming, bt, sizeof(*bt));
> +
> +	return 0;
> +}
> +
>   static int register_flexcandev(struct rtcan_device *dev)
>   {
>   	struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct flexcan_regs __iomem *regs = priv->base;
> +	struct flexcan_regs __iomem *regs = priv->regs;
>   	u32 reg, err;
>   
> -	flexcan_clk_enable(priv);
> +	err = clk_prepare_enable(priv->clk_ipg);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(priv->clk_per);
> +	if (err)
> +		goto out_disable_ipg;
>   
>   	/* select "bus clock", chip must be disabled */
> -	flexcan_chip_disable(priv);
> +	err = flexcan_chip_disable(priv);
> +	if (err)
> +		goto out_disable_per;
>   	reg = flexcan_read(&regs->ctrl);
>   	reg |= FLEXCAN_CTRL_CLK_SRC;
>   	flexcan_write(reg, &regs->ctrl);
>   
> -	flexcan_chip_enable(priv);
> +	err = flexcan_chip_enable(priv);
> +	if (err)
> +		goto out_chip_disable;
>   
>   	/* set freeze, halt and activate FIFO, restrict register access */
>   	reg = flexcan_read(&regs->mcr);
> @@ -963,205 +1324,207 @@ static int register_flexcandev(struct rtcan_device *dev)
>   		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
>   	flexcan_write(reg, &regs->mcr);
>   
> -	/*
> -	 * Currently we only support newer versions of this core
> -	 * featuring a RX FIFO. Older cores found on some Coldfire
> -	 * derivates are not yet supported.
> +	/* Currently we only support newer versions of this core
> +	 * featuring a RX hardware FIFO (although this driver doesn't
> +	 * make use of it on some cores). Older cores, found on some
> +	 * Coldfire derivates are not tested.
>   	 */
>   	reg = flexcan_read(&regs->mcr);
>   	if (!(reg & FLEXCAN_MCR_FEN)) {
> -		rtcandev_err(dev,
> -			     "Could not enable RX FIFO, unsupported core\n");
> +		rtcandev_err(dev, "Could not enable RX FIFO, unsupported core\n");
>   		err = -ENODEV;
>   		goto out_chip_disable;
>   	}
>   
>   	err = rtcan_dev_register(dev);
> -	if (err)
> -		goto out_chip_disable;
> -
> -	return 0;
>   
> -out_chip_disable:
>   	/* disable core and turn off clocks */
> + out_chip_disable:
>   	flexcan_chip_disable(priv);
> -	flexcan_clk_disable(priv);
> + out_disable_per:
> +	clk_disable_unprepare(priv->clk_per);
> + out_disable_ipg:
> +	clk_disable_unprepare(priv->clk_ipg);
>   
>   	return err;
>   }
>   
>   static void unregister_flexcandev(struct rtcan_device *dev)
>   {
> -	flexcan_mode_stop(dev, NULL);
> +	struct flexcan_priv *priv = rtcan_priv(dev);
> +
>   	rtcan_dev_unregister(dev);
> +	if (priv->ts_frames)
> +		kfree(priv->ts_frames);
>   }
>   
> -static struct of_device_id flexcan_of_match[] = {
> -	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
> -	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
> +static const struct of_device_id flexcan_of_match[] = {
>   	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
> +	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
> +	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
> +	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, flexcan_of_match);
> +
> +static const struct platform_device_id flexcan_id_table[] = {
> +	{ .name = "flexcan", .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
>   	{ /* sentinel */ },
>   };
> +MODULE_DEVICE_TABLE(platform, flexcan_id_table);
>   
>   static int flexcan_probe(struct platform_device *pdev)
>   {
> +	const struct of_device_id *of_id;
>   	const struct flexcan_devtype_data *devtype_data;
> -	const struct of_device_id *of_id = NULL;
> -	struct flexcan_priv *priv;
>   	struct rtcan_device *dev;
> -	resource_size_t mem_size;
> -	struct pinctrl *pinctrl;
> +	struct flexcan_priv *priv;
> +	struct regulator *reg_xceiver;
>   	struct resource *mem;
> -	void __iomem *base;
> -	u32 clock_freq = 0;
> +	struct clk *clk_ipg = NULL, *clk_per = NULL;
> +	struct flexcan_regs __iomem *regs;
>   	int err, irq;
> +	u32 clock_freq = 0;
>   
> -	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> -	if (IS_ERR(pinctrl))
> -		return PTR_ERR(pinctrl);
> +	reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
> +	if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	else if (IS_ERR(reg_xceiver))
> +		reg_xceiver = NULL;
>   
> -	if (pdev->dev.of_node) {
> +	if (pdev->dev.of_node)
>   		of_property_read_u32(pdev->dev.of_node,
> -						"clock-frequency", &clock_freq);
> -		of_id = of_match_device(flexcan_of_match, &pdev->dev);
> -	}
> -
> -	if (of_id)
> -		devtype_data = of_id->data;
> -	else
> -		devtype_data = (typeof(devtype_data))
> -			platform_get_device_id(pdev)->driver_data;
> -
> -	if (devtype_data == NULL) {
> -		dev_err(&pdev->dev, "no feature set defined");
> -		return -ENODEV;
> -	}
> -
> -	dev = rtcan_dev_alloc(sizeof(struct flexcan_priv), 0);
> -	if (dev == NULL)
> -		return -ENOMEM;
> -
> -	priv = rtcan_priv(dev);
> +				     "clock-frequency", &clock_freq);
>   
>   	if (!clock_freq) {
> -		priv->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> -		if (IS_ERR(priv->clk_ipg)) {
> +		clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +		if (IS_ERR(clk_ipg)) {
>   			dev_err(&pdev->dev, "no ipg clock defined\n");
> -			return PTR_ERR(priv->clk_ipg);
> +			return PTR_ERR(clk_ipg);
>   		}
>   
> -		priv->clk_per = devm_clk_get(&pdev->dev, "per");
> -		if (IS_ERR(priv->clk_per)) {
> -			clk_put(priv->clk_ipg);
> +		clk_per = devm_clk_get(&pdev->dev, "per");
> +		if (IS_ERR(clk_per)) {
>   			dev_err(&pdev->dev, "no per clock defined\n");
> -			return PTR_ERR(priv->clk_per);
> +			return PTR_ERR(clk_per);
>   		}
> -		clock_freq = clk_get_rate(priv->clk_per);
> +		clock_freq = clk_get_rate(clk_per);
>   	}
>   
>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	irq = platform_get_irq(pdev, 0);
> -	if (!mem || irq <= 0) {
> -		err = -ENODEV;
> -		goto out_get;
> -	}
> +	if (irq <= 0)
> +		return -ENODEV;
>   
> -	mem_size = resource_size(mem);
> -	if (!request_mem_region(mem->start, mem_size, pdev->name)) {
> -		err = -EBUSY;
> -		goto out_get;
> -	}
> +	regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
>   
> -	base = ioremap(mem->start, mem_size);
> -	if (!base) {
> -		err = -ENOMEM;
> -		goto out_map;
> +	of_id = of_match_device(flexcan_of_match, &pdev->dev);
> +	if (of_id) {
> +		devtype_data = of_id->data;
> +	} else if (platform_get_device_id(pdev)->driver_data) {
> +		devtype_data = (struct flexcan_devtype_data *)
> +			platform_get_device_id(pdev)->driver_data;
> +	} else {
> +		return -ENODEV;
>   	}
>   
> -	priv->base = base;
> +	dev = rtcan_dev_alloc(sizeof(struct flexcan_priv), 0);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, dev);
> +
> +	priv = rtcan_priv(dev);
> +	priv->regs = regs;
>   	priv->irq = irq;
> -	priv->dev = dev;
> +	priv->clk_ipg = clk_ipg;
> +	priv->clk_per = clk_per;
>   	priv->devtype_data = devtype_data;
> -	priv->reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
> -	if (IS_ERR(priv->reg_xceiver))
> -		priv->reg_xceiver = NULL;
> +	priv->reg_xceiver = reg_xceiver;
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> +		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_TIMESTAMP;
> +		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP];
> +	} else {
> +		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_FIFO;
> +		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_FIFO];
> +	}
> +	priv->tx_mb = &regs->mb[priv->tx_mb_idx];
> +
> +	priv->reg_imask1_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
> +	priv->reg_imask2_default = 0;
>   
> -	dev_set_drvdata(&pdev->dev, dev);
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
> +		u64 imask;
>   
> -	dev->ctrl_name = flexcan_ctrl_name;
> -	dev->board_name = flexcan_ctrl_name;
> -	dev->base_addr = (unsigned long)base;
> +		priv->mb_first = FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST;
> +		priv->mb_last = FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST;
> +		priv->ts_frames = kzalloc(sizeof(*priv->ts_frames) *
> +					  FLEXCAN_RX_MB_TIMESTAMP_COUNT, GFP_KERNEL);
> +		if (priv->ts_frames == NULL) {
> +			err = -ENOMEM;
> +			goto failed_fralloc;
> +		}
> +
> +		imask = GENMASK_ULL(priv->mb_last, priv->mb_first);
> +		priv->reg_imask1_default |= imask;
> +		priv->reg_imask2_default |= imask >> 32;
> +	} else {
> +		priv->reg_imask1_default |= FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
> +			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
> +		priv->ts_frames = NULL;
> +	}
> +
> +	dev->ctrl_name = "FLEXCAN";
> +	dev->board_name = "FLEXCAN";
> +	dev->base_addr = (unsigned long)regs;
>   	dev->can_sys_clock = clock_freq;
>   	dev->hard_start_xmit = flexcan_start_xmit;
>   	dev->do_set_mode = flexcan_set_mode;
> -	dev->do_set_bit_time = flexcan_save_bit_time;
> +	dev->do_set_bit_time = flexcan_copy_bittiming;
>   	dev->bittiming_const = &flexcan_bittiming_const;
>   	dev->state = CAN_STATE_STOPPED;
> -
> -	/* Give device an interface name */
>   	strncpy(dev->name, DEV_NAME, IFNAMSIZ);
> -
> -	/* Register RTDM device */
> +	
>   	err = register_flexcandev(dev);
>   	if (err) {
> -		dev_err(&pdev->dev, "registering RTCAN device failed\n");
> -		goto out_register;
> +		dev_err(&pdev->dev, "registering netdev failed\n");
> +		goto failed_register;
>   	}
>   
> -	dev_info(&pdev->dev,
> -		 "RTCAN device registered (reg_base=%p, irq=%d, clock=%d)\n",
> -		 priv->base, priv->irq, dev->can_sys_clock);
> +	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
> +		 priv->regs, priv->irq);
>   
>   	return 0;
>   
> -out_register:
> -	iounmap(base);
> -out_map:
> -	release_mem_region(mem->start, mem_size);
> -out_get:
> + failed_register:
> +	if (priv->ts_frames)
> +		kfree(priv->ts_frames);
> + failed_fralloc:
>   	rtcan_dev_free(dev);
> -
>   	return err;
>   }
>   
>   static int flexcan_remove(struct platform_device *pdev)
>   {
>   	struct rtcan_device *dev = platform_get_drvdata(pdev);
> -	struct flexcan_priv *priv = rtcan_priv(dev);
> -	struct resource *mem;
>   
>   	unregister_flexcandev(dev);
> -	platform_set_drvdata(pdev, NULL);
> -	iounmap(priv->base);
> -
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(mem->start, resource_size(mem));
> -
>   	rtcan_dev_free(dev);
>   
>   	return 0;
>   }
>   
> -static struct platform_device_id flexcan_id_table[] = {
> -	{ .name = "imx25-flexcan", .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
> -	{ .name = "imx28-flexcan", .driver_data = (kernel_ulong_t)&fsl_imx28_devtype_data, },
> -	{ .name = "imx35-flexcan", .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
> -	{ .name = "imx53-flexcan", .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
> -	{ .name = "imx6q-flexcan", .driver_data = (kernel_ulong_t)&fsl_imx6q_devtype_data, },
> -	{ .name = "flexcan",       .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
> -	{ /* sentinel */ },
> -};
> -
>   static struct platform_driver flexcan_driver = {
>   	.driver = {
> -		/* For legacy platform support */
>   		.name = DRV_NAME,
> -		.owner = THIS_MODULE,
>   		.of_match_table = flexcan_of_match,
>   	},
> -	.id_table = flexcan_id_table,
>   	.probe = flexcan_probe,
>   	.remove = flexcan_remove,
> +	.id_table = flexcan_id_table,
>   };
>   
>   module_platform_driver(flexcan_driver);
> 

git am complained a about a couple of whitespace issue which I couldn't easily 
locate and which may also come from the upstream driver already. Still, maybe 
worth to check if your editor visualize them.

Applied all three to next.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

