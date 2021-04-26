From: Jean-Baptiste Tredez <jean-baptiste.tredez@alstefgroup.com>
Subject: Updating fec driver for kernel 5.4 and I.MX8Q
Message-ID: <2dce9fd3-bc7e-d308-4485-7f7fe4df5eb7@alstefgroup.com>
Date: Mon, 26 Apr 2021 14:21:34 +0200
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

Do you have plans for updating fec drivers on xenomai 3.1 ?

We tried to merge uptream linux driver and Philippe Gerum work (commit 
1b7a4bd9598aa0d777016fda7e51d2e22aa51e77). Here is the result, it seems 
to work on kernel 5.4 (I.MX8Q target).

Any testing / help to improve this driver is welcomed.

Jean-Baptiste

--------------------------------------------------------------------------
From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
  <jean-baptiste.tredez@alstefgroup.com>
Date: Mon, 26 Apr 2021 12:42:53 +0200
Subject: [PATCH] Update fec for kernel 5.4

work from :
- linux driver (rel_imx_5.4.70_2.3.0)
- Philippe Gerum work, commit 1b7a4bd9598aa0d777016fda7e51d2e22aa51e77
---
  kernel/drivers/net/drivers/Kconfig            |   11 +-
  kernel/drivers/net/drivers/Makefile           |    6 +-
  kernel/drivers/net/drivers/fec.c              | 1859 -------
  kernel/drivers/net/drivers/freescale/Makefile |    5 +
  kernel/drivers/net/drivers/freescale/fec.h    |  658 +++
  .../drivers/net/drivers/freescale/fec_main.c  | 4926 +++++++++++++++++
  .../drivers/net/drivers/freescale/fec_ptp.c   |  638 +++
  kernel/drivers/net/drivers/rt_fec.h           |  153 -
  kernel/drivers/net/stack/include/rtskb.h      |    2 +-
  kernel/drivers/net/stack/rtnet_chrdev.c       |    8 +-
  kernel/drivers/net/stack/socket.c             |    8 +-
  11 files changed, 6248 insertions(+), 2026 deletions(-)
  delete mode 100644 kernel/drivers/net/drivers/fec.c
  create mode 100644 kernel/drivers/net/drivers/freescale/Makefile
  create mode 100644 kernel/drivers/net/drivers/freescale/fec.h
  create mode 100644 kernel/drivers/net/drivers/freescale/fec_main.c
  create mode 100644 kernel/drivers/net/drivers/freescale/fec_ptp.c
  delete mode 100644 kernel/drivers/net/drivers/rt_fec.h

diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index b2df1110f..e88273f27 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -116,7 +116,7 @@ config XENO_DRIVERS_NET_DRV_SMC91111
      depends on XENO_DRIVERS_NET
      tristate "SMSC LAN91C111"
  
-if ARM
+if ARM || ARM64
  
  config XENO_DRIVERS_NET_DRV_AT91_ETHER
      depends on XENO_DRIVERS_NET && SOC_AT91RM9200
@@ -131,6 +131,15 @@ config XENO_DRIVERS_NET_DRV_MACB
      Driver for internal MAC-controller on AT91SAM926x microcontrollers.
      Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
  
+config XENO_DRIVERS_NET_FEC
+    depends on XENO_DRIVERS_NET
+    tristate "Freescale FEC"
+    depends on ARCH_MXC || SOC_IMX28
+    select PHYLIB
+    imply PTP_1588_CLOCK
+    ---help---
+    For built-in 10/100 Fast ethernet controller on Freescale i.MX
+    processors.
  endif
  
  source "drivers/xenomai/net/drivers/experimental/Kconfig"
diff --git a/kernel/drivers/net/drivers/Makefile b/kernel/drivers/net/drivers/Makefile
index d97d5591c..03f475fd6 100644
--- a/kernel/drivers/net/drivers/Makefile
+++ b/kernel/drivers/net/drivers/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_XENO_DRIVERS_NET_DRV_TULIP) += tulip/
  
  obj-$(CONFIG_XENO_DRIVERS_NET_DRV_IGB) += igb/
  
+obj-$(CONFIG_XENO_DRIVERS_NET_FEC) += freescale/
+
  obj-$(CONFIG_XENO_DRIVERS_NET_DRV_8139) += rt_8139too.o
  
  rt_8139too-y := 8139too.o
@@ -40,10 +42,6 @@ obj-$(CONFIG_XENO_DRIVERS_NET_DRV_FEC_ENET) += rt_mpc8xx_fec.o
  
  rt_mpc8xx_fec-y := mpc8xx_fec.o
  
-obj-$(CONFIG_XENO_DRIVERS_NET_DRV_FEC) += rt_fec.o
-
-rt_fec-y := fec.o
-
  obj-$(CONFIG_XENO_DRIVERS_NET_DRV_NATSEMI) += rt_natsemi.o
  
  rt_natsemi-y := natsemi.o
diff --git a/kernel/drivers/net/drivers/fec.c b/kernel/drivers/net/drivers/fec.c
deleted file mode 100644
index d94ec690f..000000000
--- a/kernel/drivers/net/drivers/fec.c
+++ /dev/null
@@ -1,1859 +0,0 @@
-/*
- * Fast Ethernet Controller (FEC) driver for Motorola MPC8xx.
- * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
- *
- * Right now, I am very wasteful with the buffers.  I allocate memory
- * pages and then divide them into 2K frame buffers.  This way I know I
- * have buffers large enough to hold one frame within one buffer descriptor.
- * Once I get this working, I will use 64 or 128 byte CPM buffers, which
- * will be much more memory efficient and will easily handle lots of
- * small packets.
- *
- * Much better multiple PHY support by Magnus Damm.
- * Copyright (c) 2000 Ericsson Radio Systems AB.
- *
- * Support for FEC controller of ColdFire processors.
- * Copyright (c) 2001-2005 Greg Ungerer (gerg@snapgear.com)
- *
- * Bug fixes and cleanup by Philippe De Muyter (phdm@macqel.be)
- * Copyright (c) 2004-2006 Macq Electronique SA.
- *
- * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
- *
- * Ported from v3.5 Linux drivers/net/ethernet/freescale/fec.[ch]
- * (git tag v3.5-709-ga6be1fc)
- *
- * Copyright (c) 2012 Wolfgang Grandegger <wg@denx.de>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/version.h>
-#include <linux/string.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
-#include <linux/bitops.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/phy.h>
-#include <linux/fec.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_gpio.h>
-#include <linux/of_net.h>
-#include <linux/pinctrl/consumer.h>
-
-#include <asm/cacheflush.h>
-
-#ifndef CONFIG_ARM
-#include <asm/coldfire.h>
-#include <asm/mcfsim.h>
-#endif
-
-/* RTnet */
-#include <rtnet_port.h>
-#include <rtskb.h>
-
-/* RTnet */
-#include "rt_fec.h"
-
-MODULE_AUTHOR("Maintainer: Wolfgang Grandegger <wg@denx.de>");
-MODULE_DESCRIPTION("RTnet driver for the FEC Ethernet");
-MODULE_LICENSE("GPL");
-
-#if defined(CONFIG_ARM)
-#define FEC_ALIGNMENT	0xf
-#else
-#define FEC_ALIGNMENT	0x3
-#endif
-
-#define DRIVER_NAME	"rt_fec"
-
-/* Controller is ENET-MAC */
-#define FEC_QUIRK_ENET_MAC		(1 << 0)
-/* Controller needs driver to swap frame */
-#define FEC_QUIRK_SWAP_FRAME		(1 << 1)
-/* Controller uses gasket */
-#define FEC_QUIRK_USE_GASKET		(1 << 2)
-/* Controller has GBIT support */
-#define FEC_QUIRK_HAS_GBIT		(1 << 3)
-
-static struct platform_device_id fec_devtype[] = {
-	{
-		.name = "fec",
-/* For legacy not devicetree based support */
-#if defined(CONFIG_SOC_IMX6Q)
-		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT,
-#elif defined(CONFIG_SOC_IMX28)
-		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME,
-#elif defined(CONFIG_SOC_IMX25)
-		.driver_data = FEC_QUIRK_USE_GASKET,
-#else
-		/* keep it for coldfire */
-		.driver_data = 0,
-#endif
-	}, {
-		.name = "imx25-fec",
-		.driver_data = FEC_QUIRK_USE_GASKET,
-	}, {
-		.name = "imx27-fec",
-		.driver_data = 0,
-	}, {
-		.name = "imx28-fec",
-		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME,
-	}, {
-		.name = "imx6q-fec",
-		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, fec_devtype);
-
-enum imx_fec_type {
-	IMX25_FEC = 1,	/* runs on i.mx25/50/53 */
-	IMX27_FEC,	/* runs on i.mx27/35/51 */
-	IMX28_FEC,
-	IMX6Q_FEC,
-};
-
-static const struct of_device_id fec_dt_ids[] = {
-	{ .compatible = "fsl,imx25-fec", .data = &fec_devtype[IMX25_FEC], },
-	{ .compatible = "fsl,imx27-fec", .data = &fec_devtype[IMX27_FEC], },
-	{ .compatible = "fsl,imx28-fec", .data = &fec_devtype[IMX28_FEC], },
-	{ .compatible = "fsl,imx6q-fec", .data = &fec_devtype[IMX6Q_FEC], },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, fec_dt_ids);
-
-static unsigned char macaddr[ETH_ALEN];
-module_param_array(macaddr, byte, NULL, 0);
-MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
-
-#if defined(CONFIG_M5272)
-/*
- * Some hardware gets it MAC address out of local flash memory.
- * if this is non-zero then assume it is the address to get MAC from.
- */
-#if defined(CONFIG_NETtel)
-#define	FEC_FLASHMAC	0xf0006006
-#elif defined(CONFIG_GILBARCONAP) || defined(CONFIG_SCALES)
-#define	FEC_FLASHMAC	0xf0006000
-#elif defined(CONFIG_CANCam)
-#define	FEC_FLASHMAC	0xf0020000
-#elif defined (CONFIG_M5272C3)
-#define	FEC_FLASHMAC	(0xffe04000 + 4)
-#elif defined(CONFIG_MOD5272)
-#define FEC_FLASHMAC	0xffc0406b
-#else
-#define	FEC_FLASHMAC	0
-#endif
-#endif /* CONFIG_M5272 */
-
-/* The number of Tx and Rx buffers.  These are allocated from the page
- * pool.  The code may assume these are power of two, so it it best
- * to keep them that size.
- * We don't need to allocate pages for the transmitter.  We just use
- * the skbuffer directly.
- */
-#define FEC_ENET_RX_PAGES	8
-#define FEC_ENET_RX_FRSIZE	RTSKB_SIZE /* Maximum size for RTnet */
-#define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
-#define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
-#define FEC_ENET_TX_FRSIZE	2048
-#define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
-#define TX_RING_SIZE		16	/* Must be power of two */
-#define TX_RING_MOD_MASK	15	/*   for this to work */
-
-#if (((RX_RING_SIZE + TX_RING_SIZE) * 8) > PAGE_SIZE)
-#error "FEC: descriptor ring size constants too large"
-#endif
-
-/* Interrupt events/masks. */
-#define FEC_ENET_HBERR	((uint)0x80000000)	/* Heartbeat error */
-#define FEC_ENET_BABR	((uint)0x40000000)	/* Babbling receiver */
-#define FEC_ENET_BABT	((uint)0x20000000)	/* Babbling transmitter */
-#define FEC_ENET_GRA	((uint)0x10000000)	/* Graceful stop complete */
-#define FEC_ENET_TXF	((uint)0x08000000)	/* Full frame transmitted */
-#define FEC_ENET_TXB	((uint)0x04000000)	/* A buffer was transmitted */
-#define FEC_ENET_RXF	((uint)0x02000000)	/* Full frame received */
-#define FEC_ENET_RXB	((uint)0x01000000)	/* A buffer was received */
-#define FEC_ENET_MII	((uint)0x00800000)	/* MII interrupt */
-#define FEC_ENET_EBERR	((uint)0x00400000)	/* SDMA bus error */
-
-#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII)
-
-/* The FEC stores dest/src/type, data, and checksum for receive packets.
- */
-#define PKT_MAXBUF_SIZE		1518
-#define PKT_MINBUF_SIZE		64
-#define PKT_MAXBLR_SIZE		1520
-
-/* This device has up to three irqs on some platforms */
-#define FEC_IRQ_NUM		3
-
-/*
- * The 5270/5271/5280/5282/532x RX control register also contains maximum frame
- * size bits. Other FEC hardware does not, so we need to take that into
- * account when setting it.
- */
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM)
-#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
-#else
-#define	OPT_FRAME_SIZE	0
-#endif
-
-static unsigned int rx_pool_size = 2 * RX_RING_SIZE;
-module_param(rx_pool_size, int, 0444);
-MODULE_PARM_DESC(rx_pool_size, "Receive buffer pool size");
-
-#ifndef rtnetdev_priv
-#define rtnetdev_priv(ndev) (ndev)->priv
-#endif
-
-/* The FEC buffer descriptors track the ring buffers.  The rx_bd_base and
- * tx_bd_base always point to the base of the buffer descriptors.  The
- * cur_rx and cur_tx point to the currently available buffer.
- * The dirty_tx tracks the current buffer that is being sent by the
- * controller.  The cur_tx and dirty_tx are equal under both completely
- * empty and completely full conditions.  The empty/ready indicator in
- * the buffer descriptor determines the actual condition.
- */
-struct fec_enet_private {
-	/* Hardware registers of the FEC device */
-	void __iomem *hwp;
-
-	struct net_device *netdev; /* linux netdev needed for phy handling */
-
-	struct clk *clk_ipg;
-	struct clk *clk_ahb;
-
-	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
-	unsigned char *tx_bounce[TX_RING_SIZE];
-	struct	rtskb *tx_skbuff[TX_RING_SIZE];
-	struct	rtskb *rx_skbuff[RX_RING_SIZE];
-	ushort	skb_cur;
-	ushort	skb_dirty;
-
-	/* CPM dual port RAM relative addresses */
-	dma_addr_t	bd_dma;
-	/* Address of Rx and Tx buffers */
-	struct bufdesc	*rx_bd_base;
-	struct bufdesc	*tx_bd_base;
-	/* The next free ring entry */
-	struct bufdesc	*cur_rx, *cur_tx;
-	/* The ring entries to be free()ed */
-	struct bufdesc	*dirty_tx;
-
-	uint	tx_full;
-	/* hold while accessing the HW like ringbuffer for tx/rx but not MAC */
-	rtdm_lock_t hw_lock;
-
-	struct	platform_device *pdev;
-
-	int	opened;
-	int	dev_id;
-
-	/* Phylib and MDIO interface */
-	struct	mii_bus *mii_bus;
-	struct	phy_device *phy_dev;
-	int	mii_timeout;
-	uint	phy_speed;
-	phy_interface_t	phy_interface;
-	int	link;
-	int	full_duplex;
-	struct	completion mdio_done;
-	int	irq[FEC_IRQ_NUM];
-
-	/* RTnet */
-	struct device *dev;
-	rtdm_irq_t irq_handle[3];
-	rtdm_nrtsig_t mdio_done_sig;
-	struct net_device_stats stats;
-};
-
-/* For phy handling */
-struct fec_enet_netdev_priv {
-	struct rtnet_device *rtdev;
-};
-
-/* FEC MII MMFR bits definition */
-#define FEC_MMFR_ST		(1 << 30)
-#define FEC_MMFR_OP_READ	(2 << 28)
-#define FEC_MMFR_OP_WRITE	(1 << 28)
-#define FEC_MMFR_PA(v)		((v & 0x1f) << 23)
-#define FEC_MMFR_RA(v)		((v & 0x1f) << 18)
-#define FEC_MMFR_TA		(2 << 16)
-#define FEC_MMFR_DATA(v)	(v & 0xffff)
-
-#define FEC_MII_TIMEOUT		30000 /* us */
-
-/* Transmitter timeout */
-#define TX_TIMEOUT (2 * HZ)
-
-static int mii_cnt;
-
-static void *swap_buffer(void *bufaddr, int len)
-{
-	int i;
-	unsigned int *buf = bufaddr;
-
-	for (i = 0; i < (len + 3) / 4; i++, buf++)
-		*buf = cpu_to_be32(*buf);
-
-	return bufaddr;
-}
-
-static int
-fec_enet_start_xmit(struct rtskb *skb, struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	const struct platform_device_id *id_entry =
-				platform_get_device_id(fep->pdev);
-	struct bufdesc *bdp;
-	void *bufaddr;
-	unsigned short	status;
-	unsigned long context;
-
-	if (!fep->link) {
-		/* Link is down or autonegotiation is in progress. */
-		printk("%s: tx link down!.\n", ndev->name);
-		rtnetif_stop_queue(ndev);
-		return 1;	/* RTnet: will call kfree_rtskb() */
-	}
-
-	rtdm_lock_get_irqsave(&fep->hw_lock, context);
-
-	/* RTnet */
-	if (skb->xmit_stamp)
-		*skb->xmit_stamp = cpu_to_be64(rtdm_clock_read() +
-					       *skb->xmit_stamp);
-
-	/* Fill in a Tx ring entry */
-	bdp = fep->cur_tx;
-
-	status = bdp->cbd_sc;
-
-	if (status & BD_ENET_TX_READY) {
-		/* Ooops.  All transmit buffers are full.  Bail out.
-		 * This should not happen, since ndev->tbusy should be set.
-		 */
-		printk("%s: tx queue full!.\n", ndev->name);
-		rtdm_lock_put_irqrestore(&fep->hw_lock, context);
-		return 1;	/* RTnet: will call kfree_rtskb() */
-	}
-
-	/* Clear all of the status flags */
-	status &= ~BD_ENET_TX_STATS;
-
-	/* Set buffer length and buffer pointer */
-	bufaddr = skb->data;
-	bdp->cbd_datlen = skb->len;
-
-	/*
-	 * On some FEC implementations data must be aligned on
-	 * 4-byte boundaries. Use bounce buffers to copy data
-	 * and get it aligned. Ugh.
-	 */
-	if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
-		unsigned int index;
-		index = bdp - fep->tx_bd_base;
-		memcpy(fep->tx_bounce[index], skb->data, skb->len);
-		bufaddr = fep->tx_bounce[index];
-	}
-
-	/*
-	 * Some design made an incorrect assumption on endian mode of
-	 * the system that it's running on. As the result, driver has to
-	 * swap every frame going to and coming from the controller.
-	 */
-	if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
-		swap_buffer(bufaddr, skb->len);
-
-	/* Save skb pointer */
-	fep->tx_skbuff[fep->skb_cur] = skb;
-
-	fep->stats.tx_bytes += skb->len;
-	fep->skb_cur = (fep->skb_cur+1) & TX_RING_MOD_MASK;
-
-	/* Push the data cache so the CPM does not get stale memory
-	 * data.
-	 */
-	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
-			FEC_ENET_TX_FRSIZE, DMA_TO_DEVICE);
-
-	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
-	 * it's the last BD of the frame, and to put the CRC on the end.
-	 */
-	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
-			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
-	bdp->cbd_sc = status;
-
-	/* Trigger transmission start */
-	writel(0, fep->hwp + FEC_X_DES_ACTIVE);
-
-	/* If this was the last BD in the ring, start at the beginning again. */
-	if (status & BD_ENET_TX_WRAP)
-		bdp = fep->tx_bd_base;
-	else
-		bdp++;
-
-	if (bdp == fep->dirty_tx) {
-		fep->tx_full = 1;
-		rtnetif_stop_queue(ndev);
-	}
-
-	fep->cur_tx = bdp;
-
-	rtdm_lock_put_irqrestore(&fep->hw_lock, context);
-
-	return NETDEV_TX_OK;
-}
-
-/* This function is called to start or restart the FEC during a link
- * change.  This only happens when switching between half and full
- * duplex.
- */
-static void
-fec_restart(struct rtnet_device *ndev, int duplex)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	const struct platform_device_id *id_entry =
-				platform_get_device_id(fep->pdev);
-	int i;
-	u32 temp_mac[2];
-	u32 rcntl = OPT_FRAME_SIZE | 0x04;
-	u32 ecntl = 0x2; /* ETHEREN */
-
-	/* Whack a reset.  We should wait for this. */
-	writel(1, fep->hwp + FEC_ECNTRL);
-	udelay(10);
-
-	/*
-	 * enet-mac reset will reset mac address registers too,
-	 * so need to reconfigure it.
-	 */
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
-		memcpy(&temp_mac, ndev->dev_addr, ETH_ALEN);
-		writel(cpu_to_be32(temp_mac[0]), fep->hwp + FEC_ADDR_LOW);
-		writel(cpu_to_be32(temp_mac[1]), fep->hwp + FEC_ADDR_HIGH);
-	}
-
-	/* Clear any outstanding interrupt. */
-	writel(0xffc00000, fep->hwp + FEC_IEVENT);
-
-	/* Reset all multicast.	*/
-	writel(0, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
-	writel(0, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
-#ifndef CONFIG_M5272
-	writel(0, fep->hwp + FEC_HASH_TABLE_HIGH);
-	writel(0, fep->hwp + FEC_HASH_TABLE_LOW);
-#endif
-
-	/* Set maximum receive buffer size. */
-	writel(PKT_MAXBLR_SIZE, fep->hwp + FEC_R_BUFF_SIZE);
-
-	/* Set receive and transmit descriptor base. */
-	writel(fep->bd_dma, fep->hwp + FEC_R_DES_START);
-	writel((unsigned long)fep->bd_dma + sizeof(struct bufdesc) * RX_RING_SIZE,
-			fep->hwp + FEC_X_DES_START);
-
-	fep->dirty_tx = fep->cur_tx = fep->tx_bd_base;
-	fep->cur_rx = fep->rx_bd_base;
-
-	/* Reset SKB transmit buffers. */
-	fep->skb_cur = fep->skb_dirty = 0;
-	for (i = 0; i <= TX_RING_MOD_MASK; i++) {
-		if (fep->tx_skbuff[i]) {
-			dev_kfree_rtskb(fep->tx_skbuff[i]);
-			fep->tx_skbuff[i] = NULL;
-		}
-	}
-
-	/* Enable MII mode */
-	if (duplex) {
-		/* FD enable */
-		writel(0x04, fep->hwp + FEC_X_CNTRL);
-	} else {
-		/* No Rcv on Xmit */
-		rcntl |= 0x02;
-		writel(0x0, fep->hwp + FEC_X_CNTRL);
-	}
-
-	fep->full_duplex = duplex;
-
-	/* Set MII speed */
-	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
-
-	/*
-	 * The phy interface and speed need to get configured
-	 * differently on enet-mac.
-	 */
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
-		/* Enable flow control and length check */
-		rcntl |= 0x40000000 | 0x00000020;
-
-		/* RGMII, RMII or MII */
-		if (fep->phy_interface == PHY_INTERFACE_MODE_RGMII)
-			rcntl |= (1 << 6);
-		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
-			rcntl |= (1 << 8);
-		else
-			rcntl &= ~(1 << 8);
-
-		/* 1G, 100M or 10M */
-		if (fep->phy_dev) {
-			if (fep->phy_dev->speed == SPEED_1000)
-				ecntl |= (1 << 5);
-			else if (fep->phy_dev->speed == SPEED_100)
-				rcntl &= ~(1 << 9);
-			else
-				rcntl |= (1 << 9);
-		}
-	} else {
-#ifdef FEC_MIIGSK_ENR
-		if (id_entry->driver_data & FEC_QUIRK_USE_GASKET) {
-			u32 cfgr;
-			/* disable the gasket and wait */
-			writel(0, fep->hwp + FEC_MIIGSK_ENR);
-			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
-				udelay(1);
-
-			/*
-			 * configure the gasket:
-			 *   RMII, 50 MHz, no loopback, no echo
-			 *   MII, 25 MHz, no loopback, no echo
-			 */
-			cfgr = (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
-				? BM_MIIGSK_CFGR_RMII : BM_MIIGSK_CFGR_MII;
-			if (fep->phy_dev && fep->phy_dev->speed == SPEED_10)
-				cfgr |= BM_MIIGSK_CFGR_FRCONT_10M;
-			writel(cfgr, fep->hwp + FEC_MIIGSK_CFGR);
-
-			/* re-enable the gasket */
-			writel(2, fep->hwp + FEC_MIIGSK_ENR);
-		}
-#endif
-	}
-	writel(rcntl, fep->hwp + FEC_R_CNTRL);
-
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
-		/* enable ENET endian swap */
-		ecntl |= (1 << 8);
-		/* enable ENET store and forward mode */
-		writel(1 << 8, fep->hwp + FEC_X_WMRK);
-	}
-
-	/* And last, enable the transmit and receive processing */
-	writel(ecntl, fep->hwp + FEC_ECNTRL);
-	writel(0, fep->hwp + FEC_R_DES_ACTIVE);
-
-	/* Enable interrupts we wish to service */
-	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
-}
-
-static void
-fec_stop(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	const struct platform_device_id *id_entry =
-				platform_get_device_id(fep->pdev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
-
-	/* We cannot expect a graceful transmit stop without link !!! */
-	if (fep->link) {
-		writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
-		udelay(10);
-		if (!(readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
-			printk("fec_stop : Graceful transmit stop did not complete !\n");
-	}
-
-	/* Whack a reset.  We should wait for this. */
-	writel(1, fep->hwp + FEC_ECNTRL);
-	udelay(10);
-	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
-	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
-
-	/* We have to keep ENET enabled to have MII interrupt stay working */
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
-		writel(2, fep->hwp + FEC_ECNTRL);
-		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
-	}
-}
-
-static void
-fec_enet_tx(struct rtnet_device *ndev)
-{
-	struct	fec_enet_private *fep;
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct	rtskb	*skb;
-
-	fep = rtnetdev_priv(ndev);
-	rtdm_lock_get(&fep->hw_lock);
-	bdp = fep->dirty_tx;
-
-	while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
-		if (bdp == fep->cur_tx && fep->tx_full == 0)
-			break;
-
-		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
-				FEC_ENET_TX_FRSIZE, DMA_TO_DEVICE);
-		bdp->cbd_bufaddr = 0;
-
-		skb = fep->tx_skbuff[fep->skb_dirty];
-		/* Check for errors. */
-		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
-				   BD_ENET_TX_RL | BD_ENET_TX_UN |
-				   BD_ENET_TX_CSL)) {
-			fep->stats.tx_errors++;
-			if (status & BD_ENET_TX_HB)  /* No heartbeat */
-				fep->stats.tx_heartbeat_errors++;
-			if (status & BD_ENET_TX_LC)  /* Late collision */
-				fep->stats.tx_window_errors++;
-			if (status & BD_ENET_TX_RL)  /* Retrans limit */
-				fep->stats.tx_aborted_errors++;
-			if (status & BD_ENET_TX_UN)  /* Underrun */
-				fep->stats.tx_fifo_errors++;
-			if (status & BD_ENET_TX_CSL) /* Carrier lost */
-				fep->stats.tx_carrier_errors++;
-		} else {
-			fep->stats.tx_packets++;
-		}
-
-		if (status & BD_ENET_TX_READY)
-			printk("HEY! Enet xmit interrupt and TX_READY.\n");
-
-		/* Deferred means some collisions occurred during transmit,
-		 * but we eventually sent the packet OK.
-		 */
-		if (status & BD_ENET_TX_DEF)
-			fep->stats.collisions++;
-
-		/* Free the sk buffer associated with this last transmit */
-		dev_kfree_rtskb(skb); /* RTnet */
-		fep->tx_skbuff[fep->skb_dirty] = NULL;
-		fep->skb_dirty = (fep->skb_dirty + 1) & TX_RING_MOD_MASK;
-
-		/* Update pointer to next buffer descriptor to be transmitted */
-		if (status & BD_ENET_TX_WRAP)
-			bdp = fep->tx_bd_base;
-		else
-			bdp++;
-
-		/* Since we have freed up a buffer, the ring is no longer full
-		 */
-		if (fep->tx_full) {
-			fep->tx_full = 0;
-			if (rtnetif_queue_stopped(ndev))
-				rtnetif_wake_queue(ndev);
-		}
-	}
-	fep->dirty_tx = bdp;
-	rtdm_lock_put(&fep->hw_lock);
-}
-
-
-/* During a receive, the cur_rx points to the current incoming buffer.
- * When we update through the ring, if the next incoming buffer has
- * not been given to the system, we just set the empty indicator,
- * effectively tossing the packet.
- */
-static void
-fec_enet_rx(struct rtnet_device *ndev, int *packets, nanosecs_abs_t *time_stamp)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	const struct platform_device_id *id_entry =
-				platform_get_device_id(fep->pdev);
-	struct bufdesc *bdp;
-	unsigned short status;
-	struct	rtskb	*skb;
-	ushort	pkt_len;
-	__u8 *data;
-
-#ifdef CONFIG_M532x
-	flush_cache_all();
-#endif
-	rtdm_lock_get(&fep->hw_lock);
-
-	/* First, grab all of the stats for the incoming packet.
-	 * These get messed up if we get called due to a busy condition.
-	 */
-	bdp = fep->cur_rx;
-
-	while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
-
-		/* Since we have allocated space to hold a complete frame,
-		 * the last indicator should be set.
-		 */
-		if ((status & BD_ENET_RX_LAST) == 0)
-			printk("FEC ENET: rcv is not +last\n");
-
-		if (!fep->opened)
-			goto rx_processing_done;
-
-		/* Check for errors. */
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV)) {
-			fep->stats.rx_errors++;
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH)) {
-				/* Frame too long or too short. */
-				fep->stats.rx_length_errors++;
-			}
-			if (status & BD_ENET_RX_NO)	/* Frame alignment */
-				fep->stats.rx_frame_errors++;
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				fep->stats.rx_crc_errors++;
-			if (status & BD_ENET_RX_OV)	/* FIFO overrun */
-				fep->stats.rx_fifo_errors++;
-		}
-
-		/* Report late collisions as a frame error.
-		 * On this error, the BD is closed, but we don't know what we
-		 * have in the buffer.  So, just drop this frame on the floor.
-		 */
-		if (status & BD_ENET_RX_CL) {
-			fep->stats.rx_errors++;
-			fep->stats.rx_frame_errors++;
-			goto rx_processing_done;
-		}
-
-		/* Process the incoming frame. */
-		fep->stats.rx_packets++;
-		pkt_len = bdp->cbd_datlen;
-		fep->stats.rx_bytes += pkt_len;
-		data = (__u8*)__va(bdp->cbd_bufaddr);
-
-		dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
-				FEC_ENET_TX_FRSIZE, DMA_FROM_DEVICE);
-
-		if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
-			swap_buffer(data, pkt_len);
-
-		/* This does 16 byte alignment, exactly what we need.
-		 * The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = rtnetdev_alloc_rtskb(ndev, pkt_len - 4 + NET_IP_ALIGN); /* RTnet */
-
-		if (unlikely(!skb)) {
-			printk("%s: Memory squeeze, dropping packet.\n",
-					ndev->name);
-			fep->stats.rx_dropped++;
-		} else {
-			rtskb_reserve(skb, NET_IP_ALIGN);
-			rtskb_put(skb, pkt_len - 4);	/* Make room */
-			memcpy(skb->data, data, pkt_len - 4);
-			skb->protocol = rt_eth_type_trans(skb, ndev);
-			skb->time_stamp = *time_stamp;
-			rtnetif_rx(skb);
-			(*packets)++; /* RTnet */
-		}
-
-		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, data,
-				FEC_ENET_TX_FRSIZE, DMA_FROM_DEVICE);
-rx_processing_done:
-		/* Clear the status flags for this buffer */
-		status &= ~BD_ENET_RX_STATS;
-
-		/* Mark the buffer empty */
-		status |= BD_ENET_RX_EMPTY;
-		bdp->cbd_sc = status;
-
-		/* Update BD pointer to next entry */
-		if (status & BD_ENET_RX_WRAP)
-			bdp = fep->rx_bd_base;
-		else
-			bdp++;
-		/* Doing this here will keep the FEC running while we process
-		 * incoming frames.  On a heavily loaded network, we should be
-		 * able to keep up at the expense of system resources.
-		 */
-		writel(0, fep->hwp + FEC_R_DES_ACTIVE);
-	}
-	fep->cur_rx = bdp;
-
-	rtdm_lock_put(&fep->hw_lock);
-}
-
-static int
-fec_enet_interrupt(rtdm_irq_t *irq_handle)
-{
-	struct rtnet_device *ndev =
-		rtdm_irq_get_arg(irq_handle, struct rtnet_device); /* RTnet */
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	uint int_events;
-	irqreturn_t ret = RTDM_IRQ_NONE;
-	/* RTnet */
-	nanosecs_abs_t time_stamp = rtdm_clock_read();
-	int packets = 0;
-
-	do {
-		int_events = readl(fep->hwp + FEC_IEVENT);
-		writel(int_events, fep->hwp + FEC_IEVENT);
-
-		if (int_events & FEC_ENET_RXF) {
-			ret = RTDM_IRQ_HANDLED;
-			fec_enet_rx(ndev, &packets, &time_stamp);
-		}
-
-		/* Transmit OK, or non-fatal error. Update the buffer
-		 * descriptors. FEC handles all errors, we just discover
-		 * them as part of the transmit process.
-		 */
-		if (int_events & FEC_ENET_TXF) {
-			ret = RTDM_IRQ_HANDLED;
-			fec_enet_tx(ndev);
-		}
-
-		if (int_events & FEC_ENET_MII) {
-			ret = RTDM_IRQ_HANDLED;
-			rtdm_nrtsig_pend(&fep->mdio_done_sig);
-		}
-	} while (int_events);
-
-	if (packets > 0)
-		rt_mark_stack_mgr(ndev);
-
-	return ret;
-}
-
-
-
-/* ------------------------------------------------------------------------- */
-static void __inline__ fec_get_mac(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	struct fec_platform_data *pdata = fep->pdev->dev.platform_data;
-	unsigned char *iap, tmpaddr[ETH_ALEN];
-
-	/*
-	 * try to get mac address in following order:
-	 *
-	 * 1) module parameter via kernel command line in form
-	 *    fec.macaddr=0x00,0x04,0x9f,0x01,0x30,0xe0
-	 */
-	iap = macaddr;
-
-#ifdef CONFIG_OF
-	/*
-	 * 2) from device tree data
-	 */
-	if (!is_valid_ether_addr(iap)) {
-		struct device_node *np = fep->pdev->dev.of_node;
-		if (np) {
-			const char *mac = of_get_mac_address(np);
-			if (mac)
-				iap = (unsigned char *) mac;
-		}
-	}
-#endif
-
-	/*
-	 * 3) from flash or fuse (via platform data)
-	 */
-	if (!is_valid_ether_addr(iap)) {
-#ifdef CONFIG_M5272
-		if (FEC_FLASHMAC)
-			iap = (unsigned char *)FEC_FLASHMAC;
-#else
-		if (pdata)
-			iap = (unsigned char *)&pdata->mac;
-#endif
-	}
-
-	/*
-	 * 4) FEC mac registers set by bootloader
-	 */
-	if (!is_valid_ether_addr(iap)) {
-		*((unsigned long *) &tmpaddr[0]) =
-			be32_to_cpu(readl(fep->hwp + FEC_ADDR_LOW));
-		*((unsigned short *) &tmpaddr[4]) =
-			be16_to_cpu(readl(fep->hwp + FEC_ADDR_HIGH) >> 16);
-		iap = &tmpaddr[0];
-	}
-
-	memcpy(ndev->dev_addr, iap, ETH_ALEN);
-
-	/* Adjust MAC if using macaddr */
-	if (iap == macaddr)
-		 ndev->dev_addr[ETH_ALEN-1] = macaddr[ETH_ALEN-1] + fep->dev_id;
-}
-
-/* ------------------------------------------------------------------------- */
-
-/*
- * Phy section
- */
-static void fec_enet_mdio_done(rtdm_nrtsig_t *nrt_sig, void* data)
-{
-	struct fec_enet_private *fep = data;
-
-	complete(&fep->mdio_done);
-}
-
-static void fec_enet_adjust_link(struct net_device *netdev)
-{
-	struct fec_enet_netdev_priv *npriv = netdev_priv(netdev);
-	struct rtnet_device *ndev = npriv->rtdev;
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	struct phy_device *phy_dev = fep->phy_dev;
-	unsigned long context;
-
-	int status_change = 0;
-
-	rtdm_lock_get_irqsave(&fep->hw_lock, context);
-
-	/* Prevent a state halted on mii error */
-	if (fep->mii_timeout && phy_dev->state == PHY_HALTED) {
-		phy_dev->state = PHY_RESUMING;
-		goto spin_unlock;
-	}
-
-	/* Duplex link change */
-	if (phy_dev->link) {
-		if (fep->full_duplex != phy_dev->duplex) {
-			fec_restart(ndev, phy_dev->duplex);
-			/* prevent unnecessary second fec_restart() below */
-			fep->link = phy_dev->link;
-			status_change = 1;
-		}
-	}
-
-	/* Link on or off change */
-	if (phy_dev->link != fep->link) {
-		fep->link = phy_dev->link;
-		if (phy_dev->link)
-			fec_restart(ndev, phy_dev->duplex);
-		else
-			fec_stop(ndev);
-		status_change = 1;
-	}
-
-spin_unlock:
-	rtdm_lock_put_irqrestore(&fep->hw_lock, context);
-
-	if (status_change)
-		phy_print_status(phy_dev);
-}
-
-static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
-{
-	struct fec_enet_private *fep = bus->priv;
-	unsigned long time_left;
-
-	fep->mii_timeout = 0;
-	init_completion(&fep->mdio_done);
-
-	/* start a read op */
-	writel(FEC_MMFR_ST | FEC_MMFR_OP_READ |
-		FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
-		FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
-
-	/* wait for end of transfer */
-	time_left = wait_for_completion_timeout(&fep->mdio_done,
-			usecs_to_jiffies(FEC_MII_TIMEOUT));
-	if (time_left == 0) {
-		fep->mii_timeout = 1;
-		printk(KERN_ERR "FEC: MDIO read timeout\n");
-		return -ETIMEDOUT;
-	}
-
-	/* return value */
-	return FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
-}
-
-static int fec_enet_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
-			   u16 value)
-{
-	struct fec_enet_private *fep = bus->priv;
-	unsigned long time_left;
-
-	fep->mii_timeout = 0;
-	init_completion(&fep->mdio_done);
-
-	/* start a write op */
-	writel(FEC_MMFR_ST | FEC_MMFR_OP_WRITE |
-		FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
-		FEC_MMFR_TA | FEC_MMFR_DATA(value),
-		fep->hwp + FEC_MII_DATA);
-
-	/* wait for end of transfer */
-	time_left = wait_for_completion_timeout(&fep->mdio_done,
-			usecs_to_jiffies(FEC_MII_TIMEOUT));
-	if (time_left == 0) {
-		fep->mii_timeout = 1;
-		printk(KERN_ERR "FEC: MDIO write timeout\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
-static int fec_enet_mdio_reset(struct mii_bus *bus)
-{
-	return 0;
-}
-
-static int fec_enet_mii_probe(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	const struct platform_device_id *id_entry =
-				platform_get_device_id(fep->pdev);
-	struct phy_device *phy_dev = NULL;
-	char mdio_bus_id[MII_BUS_ID_SIZE];
-	char phy_name[MII_BUS_ID_SIZE + 3];
-	int phy_id;
-	int dev_id = fep->dev_id;
-
-	fep->phy_dev = NULL;
-
-	/* check for attached phy */
-	for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
-		if ((fep->mii_bus->phy_mask & (1 << phy_id)))
-			continue;
-		if (fep->mii_bus->phy_map[phy_id] == NULL)
-			continue;
-		if (fep->mii_bus->phy_map[phy_id]->phy_id == 0)
-			continue;
-		if (dev_id--)
-			continue;
-		strncpy(mdio_bus_id, fep->mii_bus->id, MII_BUS_ID_SIZE);
-		break;
-	}
-
-	if (phy_id >= PHY_MAX_ADDR) {
-		printk(KERN_INFO
-			"%s: no PHY, assuming direct connection to switch\n",
-			ndev->name);
-		strncpy(mdio_bus_id, "fixed-0", MII_BUS_ID_SIZE);
-		phy_id = 0;
-	}
-
-	snprintf(phy_name, sizeof(phy_name), PHY_ID_FMT, mdio_bus_id, phy_id);
-	/* attach the mac to the phy using the dummy linux netdev */
-	phy_dev = phy_connect(fep->netdev, phy_name, &fec_enet_adjust_link, 0,
-			      fep->phy_interface);
-	if (IS_ERR(phy_dev)) {
-		printk(KERN_ERR "%s: could not attach to PHY\n", ndev->name);
-		return PTR_ERR(phy_dev);
-	}
-
-	/* mask with MAC supported features */
-	if (id_entry->driver_data & FEC_QUIRK_HAS_GBIT)
-		phy_dev->supported &= PHY_GBIT_FEATURES;
-	else
-		phy_dev->supported &= PHY_BASIC_FEATURES;
-
-	phy_dev->advertising = phy_dev->supported;
-
-	fep->phy_dev = phy_dev;
-	fep->link = 0;
-	fep->full_duplex = 0;
-
-	printk(KERN_INFO
-		"%s: Freescale FEC PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
-		ndev->name,
-		fep->phy_dev->drv->name, dev_name(&fep->phy_dev->dev),
-		fep->phy_dev->irq);
-
-	return 0;
-}
-
-static int fec_enet_mii_init(struct platform_device *pdev)
-{
-	static struct mii_bus *fec0_mii_bus;
-	struct rtnet_device *ndev = platform_get_drvdata(pdev);
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	const struct platform_device_id *id_entry =
-				platform_get_device_id(fep->pdev);
-	int err = -ENXIO, i;
-
-	/*
-	 * The dual fec interfaces are not equivalent with enet-mac.
-	 * Here are the differences:
-	 *
-	 *  - fec0 supports MII & RMII modes while fec1 only supports RMII
-	 *  - fec0 acts as the 1588 time master while fec1 is slave
-	 *  - external phys can only be configured by fec0
-	 *
-	 * That is to say fec1 can not work independently. It only works
-	 * when fec0 is working. The reason behind this design is that the
-	 * second interface is added primarily for Switch mode.
-	 *
-	 * Because of the last point above, both phys are attached on fec0
-	 * mdio interface in board design, and need to be configured by
-	 * fec0 mii_bus.
-	 */
-	if ((id_entry->driver_data & FEC_QUIRK_ENET_MAC) && fep->dev_id > 0) {
-		/* fec1 uses fec0 mii_bus */
-		if (mii_cnt && fec0_mii_bus) {
-			fep->mii_bus = fec0_mii_bus;
-			mii_cnt++;
-			return 0;
-		}
-		return -ENOENT;
-	}
-
-	fep->mii_timeout = 0;
-
-	/*
-	 * Set MII speed to 2.5 MHz (= clk_get_rate() / 2 * phy_speed)
-	 *
-	 * The formula for FEC MDC is 'ref_freq / (MII_SPEED x 2)' while
-	 * for ENET-MAC is 'ref_freq / ((MII_SPEED + 1) x 2)'.  The i.MX28
-	 * Reference Manual has an error on this, and gets fixed on i.MX6Q
-	 * document.
-	 */
-	fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk_ahb), 5000000);
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC)
-		fep->phy_speed--;
-	fep->phy_speed <<= 1;
-	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
-
-	fep->mii_bus = mdiobus_alloc();
-	if (fep->mii_bus == NULL) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	fep->mii_bus->name = "fec_enet_mii_bus";
-	fep->mii_bus->read = fec_enet_mdio_read;
-	fep->mii_bus->write = fec_enet_mdio_write;
-	fep->mii_bus->reset = fec_enet_mdio_reset;
-	snprintf(fep->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
-		pdev->name, fep->dev_id + 1);
-	fep->mii_bus->priv = fep;
-	fep->mii_bus->parent = &pdev->dev;
-
-	fep->mii_bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
-	if (!fep->mii_bus->irq) {
-		err = -ENOMEM;
-		goto err_out_free_mdiobus;
-	}
-
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		fep->mii_bus->irq[i] = PHY_POLL;
-
-	rtdm_nrtsig_init(&fep->mdio_done_sig, fec_enet_mdio_done, fep);
-
-	if (mdiobus_register(fep->mii_bus))
-		goto err_out_destroy_nrt;
-
-	mii_cnt++;
-
-	/* save fec0 mii_bus */
-	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC)
-		fec0_mii_bus = fep->mii_bus;
-
-	return 0;
-
-err_out_destroy_nrt:
-	rtdm_nrtsig_destroy(&fep->mdio_done_sig);
-	kfree(fep->mii_bus->irq);
-err_out_free_mdiobus:
-	mdiobus_free(fep->mii_bus);
-err_out:
-	return err;
-}
-
-static void fec_enet_mii_remove(struct fec_enet_private *fep)
-{
-	if (--mii_cnt == 0) {
-		mdiobus_unregister(fep->mii_bus);
-		kfree(fep->mii_bus->irq);
-		mdiobus_free(fep->mii_bus);
-	}
-	rtdm_nrtsig_destroy(&fep->mdio_done_sig);
-}
-
-static int
-fec_enet_ioctl(struct rtnet_device *ndev, unsigned int request, void *arg)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	struct phy_device *phydev = fep->phy_dev;
-	struct ifreq *ifr = arg;
-	struct ethtool_value *value;
-	struct ethtool_cmd cmd;
-	int err = 0;
-
-	if (!rtnetif_running(ndev))
-		return -EINVAL;
-
-	if (!phydev)
-		return -ENODEV;
-
-	switch (request) {
-	case SIOCETHTOOL:
-		value = (struct ethtool_value *)ifr->ifr_data;
-		switch (value->cmd) {
-		case ETHTOOL_GLINK:
-			value->data = fep->link;
-			if (copy_to_user(&value->data, &fep->link,
-					 sizeof(value->data)))
-				err = -EFAULT;
-			break;
-		case ETHTOOL_GSET:
-			memset(&cmd, 0, sizeof(cmd));
-			cmd.cmd = ETHTOOL_GSET;
-			err = phy_ethtool_gset(phydev, &cmd);
-			if (err)
-				break;
-			if (copy_to_user(ifr->ifr_data, &cmd, sizeof(cmd)))
-				err = -EFAULT;
-			break;
-		case ETHTOOL_SSET:
-			if (copy_from_user(&cmd, ifr->ifr_data, sizeof(cmd)))
-				err = -EFAULT;
-			else
-				err = phy_ethtool_sset(phydev, &cmd);
-			break;
-		}
-		break;
-	default:
-		err = -EOPNOTSUPP;
-		break;
-	}
-
-	return err;
-}
-
-static void fec_enet_free_buffers(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	int i;
-	struct rtskb *skb;
-	struct bufdesc	*bdp;
-
-	bdp = fep->rx_bd_base;
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		skb = fep->rx_skbuff[i];
-
-		if (bdp->cbd_bufaddr)
-			dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
-					FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
-		if (skb)
-			dev_kfree_rtskb(skb); /* RTnet */
-		bdp++;
-	}
-
-	bdp = fep->tx_bd_base;
-	for (i = 0; i < TX_RING_SIZE; i++)
-		kfree(fep->tx_bounce[i]);
-}
-
-static int fec_enet_alloc_buffers(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	int i;
-	struct rtskb *skb;
-	struct bufdesc	*bdp;
-
-	bdp = fep->rx_bd_base;
-	for (i = 0; i < RX_RING_SIZE; i++) {
-		skb = rtnetdev_alloc_rtskb(netdev, FEC_ENET_RX_FRSIZE); /* RTnet */
-		if (!skb) {
-			fec_enet_free_buffers(ndev);
-			return -ENOMEM;
-		}
-		fep->rx_skbuff[i] = skb;
-
-		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, skb->data,
-				FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
-		bdp->cbd_sc = BD_ENET_RX_EMPTY;
-		bdp++;
-	}
-
-	/* Set the last buffer to wrap. */
-	bdp--;
-	bdp->cbd_sc |= BD_SC_WRAP;
-
-	bdp = fep->tx_bd_base;
-	for (i = 0; i < TX_RING_SIZE; i++) {
-		fep->tx_bounce[i] = kmalloc(FEC_ENET_TX_FRSIZE, GFP_KERNEL);
-
-		bdp->cbd_sc = 0;
-		bdp->cbd_bufaddr = 0;
-		bdp++;
-	}
-
-	/* Set the last buffer to wrap. */
-	bdp--;
-	bdp->cbd_sc |= BD_SC_WRAP;
-
-	return 0;
-}
-
-static int
-fec_enet_open(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	int ret;
-
-	/* I should reset the ring buffers here, but I don't yet know
-	 * a simple way to do that.
-	 */
-
-	ret = fec_enet_alloc_buffers(ndev);
-	if (ret)
-		return ret;
-
-	/* RTnet */
-	rt_stack_connect(ndev, &STACK_manager);
-
-	/* Probe and connect to PHY when open the interface */
-	ret = fec_enet_mii_probe(ndev);
-	if (ret) {
-		fec_enet_free_buffers(ndev);
-		return ret;
-	}
-	phy_start(fep->phy_dev);
-	rtnetif_carrier_on(ndev);
-	rtnetif_start_queue(ndev);
-	fep->opened = 1;
-	return 0;
-}
-
-static int
-fec_enet_close(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-
-	/* Don't know what to do yet. */
-	fep->opened = 0;
-	rtnetif_stop_queue(ndev);
-	fec_stop(ndev);
-
-	if (fep->phy_dev) {
-		phy_stop(fep->phy_dev);
-		phy_disconnect(fep->phy_dev);
-	}
-
-	fec_enet_free_buffers(ndev);
-
-	/* RTnet */
-	rt_stack_disconnect(ndev);
-
-	return 0;
-}
-
-#ifdef CONFIG_XENO_DRIVERS_NET_MULTICAST
-/* Set or clear the multicast filter for this adaptor.
- * Skeleton taken from sunlance driver.
- * The CPM Ethernet implementation allows Multicast as well as individual
- * MAC address filtering.  Some of the drivers check to make sure it is
- * a group multicast address, and discard those that are not.  I guess I
- * will do the same for now, but just remove the test if you want
- * individual filtering as well (do the upper net layers want or support
- * this kind of feature?).
- */
-
-#define HASH_BITS	6		/* #bits in hash */
-#define CRC32_POLY	0xEDB88320
-
-static void set_multicast_list(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	struct netdev_hw_addr *ha;
-	unsigned int i, bit, data, crc, tmp;
-	unsigned char hash;
-
-	if (ndev->flags & IFF_PROMISC) {
-		tmp = readl(fep->hwp + FEC_R_CNTRL);
-		tmp |= 0x8;
-		writel(tmp, fep->hwp + FEC_R_CNTRL);
-		return;
-	}
-
-	tmp = readl(fep->hwp + FEC_R_CNTRL);
-	tmp &= ~0x8;
-	writel(tmp, fep->hwp + FEC_R_CNTRL);
-
-	if (ndev->flags & IFF_ALLMULTI) {
-		/* Catch all multicast addresses, so set the
-		 * filter to all 1's
-		 */
-		writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
-		writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
-
-		return;
-	}
-
-	/* Clear filter and add the addresses in hash register
-	 */
-	writel(0, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
-	writel(0, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
-
-	rtnetdev_for_each_mc_addr(ha, ndev) {
-		/* calculate crc32 value of mac address */
-		crc = 0xffffffff;
-
-		for (i = 0; i < ndev->addr_len; i++) {
-			data = ha->addr[i];
-			for (bit = 0; bit < 8; bit++, data >>= 1) {
-				crc = (crc >> 1) ^
-				(((crc ^ data) & 1) ? CRC32_POLY : 0);
-			}
-		}
-
-		/* only upper 6 bits (HASH_BITS) are used
-		 * which point to specific bit in he hash registers
-		 */
-		hash = (crc >> (32 - HASH_BITS)) & 0x3f;
-
-		if (hash > 31) {
-			tmp = readl(fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
-			tmp |= 1 << (hash - 32);
-			writel(tmp, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
-		} else {
-			tmp = readl(fep->hwp + FEC_GRP_HASH_TABLE_LOW);
-			tmp |= 1 << hash;
-			writel(tmp, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
-		}
-	}
-}
-#endif /* CONFIG_XENO_DRIVERS_NET_MULTICAST */
-
-#ifdef ORIGINAL_CODE
-/* Set a MAC change in hardware. */
-static int
-fec_set_mac_address(struct rtnet_device *ndev, void *p)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	struct sockaddr *addr = p;
-
-	if (!is_valid_ether_addr(addr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	memcpy(ndev->dev_addr, addr->sa_data, ndev->addr_len);
-
-	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
-		(ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
-		fep->hwp + FEC_ADDR_LOW);
-	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
-		fep->hwp + FEC_ADDR_HIGH);
-	return 0;
-}
-
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/*
- * fec_poll_controller: FEC Poll controller function
- * @dev: The FEC network adapter
- *
- * Polled functionality used by netconsole and others in non interrupt mode
- *
- */
-void fec_poll_controller(struct rtnet_device *dev)
-{
-	int i;
-	struct fec_enet_private *fep = rtnetdev_priv(dev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		if (fep->irq[i] > 0) {
-			disable_irq(fep->irq[i]);
-			fec_enet_interrupt(fep->irq[i], dev);
-			enable_irq(fep->irq[i]);
-		}
-	}
-}
-#endif /* ORIGINAL_CODE */
-
-static const struct rtnet_device_ops fec_netdev_ops = {
-	.ndo_open		= fec_enet_open,
-	.ndo_stop		= fec_enet_close,
-	.ndo_start_xmit		= fec_enet_start_xmit,
-	.ndo_set_rx_mode	= set_multicast_list,
-	.ndo_change_mtu		= eth_change_mtu,
-	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_tx_timeout		= fec_timeout,
-	.ndo_set_mac_address	= fec_set_mac_address,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= fec_poll_controller,
-#endif
-};
-#endif
-
-/* RTnet: get statistics */
-static struct net_device_stats *fec_get_stats(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	return &fep->stats;
-}
-
- /*
-  * XXX:  We need to clean up on failure exits here.
-  *
-  */
-static int fec_enet_init(struct rtnet_device *ndev)
-{
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	struct bufdesc *cbd_base;
-	struct bufdesc *bdp;
-	int i;
-
-	/* Allocate memory for buffer descriptors. */
-	cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &fep->bd_dma,
-			GFP_KERNEL);
-	if (!cbd_base) {
-		printk("FEC: allocate descriptor memory failed?\n");
-		return -ENOMEM;
-	}
-
-	rtdm_lock_init(&fep->hw_lock);
-
-	/* Get the Ethernet address */
-	fec_get_mac(ndev);
-
-	/* Set receive and transmit descriptor base. */
-	fep->rx_bd_base = cbd_base;
-	fep->tx_bd_base = cbd_base + RX_RING_SIZE;
-
-	/* RTnet: specific entries in the device structure */
-	ndev->open = fec_enet_open;
-	ndev->stop = fec_enet_close;
-	ndev->hard_start_xmit = fec_enet_start_xmit;
-	ndev->get_stats = fec_get_stats;
-	ndev->do_ioctl = fec_enet_ioctl;
-#ifdef CONFIG_XENO_DRIVERS_NET_MULTICAST
-	ndev->set_multicast_list = &set_multicast_list;
-#endif
-
-	/* Initialize the receive buffer descriptors. */
-	bdp = fep->rx_bd_base;
-	for (i = 0; i < RX_RING_SIZE; i++) {
-
-		/* Initialize the BD for every fragment in the page. */
-		bdp->cbd_sc = 0;
-		bdp++;
-	}
-
-	/* Set the last buffer to wrap */
-	bdp--;
-	bdp->cbd_sc |= BD_SC_WRAP;
-
-	/* ...and the same for transmit */
-	bdp = fep->tx_bd_base;
-	for (i = 0; i < TX_RING_SIZE; i++) {
-
-		/* Initialize the BD for every fragment in the page. */
-		bdp->cbd_sc = 0;
-		bdp->cbd_bufaddr = 0;
-		bdp++;
-	}
-
-	/* Set the last buffer to wrap */
-	bdp--;
-	bdp->cbd_sc |= BD_SC_WRAP;
-
-	fec_restart(ndev, 0);
-
-	return 0;
-}
-
-#ifdef CONFIG_OF
-static int fec_get_phy_mode_dt(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-
-	if (np)
-		return of_get_phy_mode(np);
-
-	return -ENODEV;
-}
-
-static void fec_reset_phy(struct platform_device *pdev)
-{
-	int err, phy_reset;
-	struct device_node *np = pdev->dev.of_node;
-
-	if (!np)
-		return;
-
-	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
-	err = gpio_request_one(phy_reset, GPIOF_OUT_INIT_LOW, "phy-reset");
-	if (err) {
-		pr_debug("FEC: failed to get gpio phy-reset: %d\n", err);
-		return;
-	}
-	msleep(1);
-	gpio_set_value(phy_reset, 1);
-}
-#else /* CONFIG_OF */
-static inline int fec_get_phy_mode_dt(struct platform_device *pdev)
-{
-	return -ENODEV;
-}
-
-static inline void fec_reset_phy(struct platform_device *pdev)
-{
-	/*
-	 * In case of platform probe, the reset has been done
-	 * by machine code.
-	 */
-}
-#endif /* CONFIG_OF */
-
-static int fec_probe(struct platform_device *pdev)
-{
-	struct fec_enet_netdev_priv *npriv;
-	struct fec_enet_private *fep;
-	struct fec_platform_data *pdata;
-	struct rtnet_device *ndev;
-	int i, irq, ret = 0;
-	struct resource *r;
-	const struct of_device_id *of_id;
-	static int dev_id;
-	struct pinctrl *pinctrl;
-
-	of_id = of_match_device(fec_dt_ids, &pdev->dev);
-	if (of_id)
-		pdev->id_entry = of_id->data;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -ENXIO;
-
-	r = request_mem_region(r->start, resource_size(r), pdev->name);
-	if (!r)
-		return -EBUSY;
-
-	/* Init network device */
-	ndev = rt_alloc_etherdev(sizeof(struct fec_enet_private),
-				rx_pool_size + TX_RING_SIZE);
-	if (!ndev) {
-		ret = -ENOMEM;
-		goto failed_alloc_etherdev;
-	}
-
-	/* RTnet */
-	rtdev_alloc_name(ndev, "rteth%d");
-	rt_rtdev_connect(ndev, &RTDEV_manager);
-	ndev->vers = RTDEV_VERS_2_0;
-	ndev->sysbind = &pdev->dev;
-
-	/* setup board info structure */
-	fep = rtnetdev_priv(ndev);
-	memset(fep, 0, sizeof(*fep));
-
-	/* RTnet: allocate dummy linux netdev structure for phy handling */
-	fep->netdev = alloc_etherdev(sizeof(struct fec_enet_netdev_priv));
-	if (!fep->netdev)
-		goto failed_alloc_netdev;
-	SET_NETDEV_DEV(fep->netdev, &pdev->dev);
-	npriv = netdev_priv(fep->netdev);
-	npriv->rtdev = ndev;
-
-	fep->hwp = ioremap(r->start, resource_size(r));
-	fep->pdev = pdev;
-	fep->dev_id = dev_id++;
-
-	if (!fep->hwp) {
-		ret = -ENOMEM;
-		goto failed_ioremap;
-	}
-
-	platform_set_drvdata(pdev, ndev);
-
-	ret = fec_get_phy_mode_dt(pdev);
-	if (ret < 0) {
-		pdata = pdev->dev.platform_data;
-		if (pdata)
-			fep->phy_interface = pdata->phy;
-		else
-			fep->phy_interface = PHY_INTERFACE_MODE_MII;
-	} else {
-		fep->phy_interface = ret;
-	}
-
-	fec_reset_phy(pdev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq < 0) {
-			if (i)
-				break;
-			ret = irq;
-			goto failed_irq;
-		}
-		ret = rtdm_irq_request(&fep->irq_handle[i], irq,
-				       fec_enet_interrupt, 0, ndev->name, ndev);
-		if (ret) {
-			while (--i >= 0) {
-				irq = platform_get_irq(pdev, i);
-				rtdm_irq_free(&fep->irq_handle[i]);
-			}
-			goto failed_irq;
-		}
-	}
-
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		goto failed_pin;
-	}
-
-	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(fep->clk_ipg)) {
-		ret = PTR_ERR(fep->clk_ipg);
-		goto failed_clk;
-	}
-
-	fep->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(fep->clk_ahb)) {
-		ret = PTR_ERR(fep->clk_ahb);
-		goto failed_clk;
-	}
-
-	clk_prepare_enable(fep->clk_ahb);
-	clk_prepare_enable(fep->clk_ipg);
-
-	ret = fec_enet_init(ndev);
-	if (ret)
-		goto failed_init;
-
-	ret = fec_enet_mii_init(pdev);
-	if (ret)
-		goto failed_mii_init;
-
-	/* Carrier starts down, phylib will bring it up */
-	rtnetif_carrier_off(ndev);
-
-	/* RTnet: register the network interface */
-	ret = rt_register_rtnetdev(ndev);
-	if (ret)
-		goto failed_register;
-
-	return 0;
-
-failed_register:
-	fec_enet_mii_remove(fep);
-failed_mii_init:
-failed_init:
-	clk_disable_unprepare(fep->clk_ahb);
-	clk_disable_unprepare(fep->clk_ipg);
-failed_pin:
-failed_clk:
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq > 0)
-			rtdm_irq_free(&fep->irq_handle[i]);
-	}
-failed_irq:
-	iounmap(fep->hwp);
-failed_ioremap:
-	free_netdev(fep->netdev);
-failed_alloc_netdev:
-	rtdev_free(ndev); /* RTnet */
-failed_alloc_etherdev:
-	release_mem_region(r->start, resource_size(r));
-
-	return ret;
-}
-
-static int fec_drv_remove(struct platform_device *pdev)
-{
-	struct rtnet_device *ndev = platform_get_drvdata(pdev);
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-	struct resource *r;
-	int i;
-
-	/* RTnet */
-	rt_unregister_rtnetdev(ndev);
-	rt_rtdev_disconnect(ndev);
-
-	fec_enet_mii_remove(fep);
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		int irq = platform_get_irq(pdev, i);
-		if (irq > 0)
-			rtdm_irq_free(&fep->irq_handle[i]);
-	}
-
-	clk_disable_unprepare(fep->clk_ahb);
-	clk_disable_unprepare(fep->clk_ipg);
-	iounmap(fep->hwp);
-
-	/* RTnet */
-	free_netdev(fep->netdev);
-	rtdev_free(ndev);
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	BUG_ON(!r);
-	release_mem_region(r->start, resource_size(r));
-
-	platform_set_drvdata(pdev, NULL);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int
-fec_suspend(struct device *dev)
-{
-	struct rtnet_device *ndev = dev_get_drvdata(dev);
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-
-	if (rtnetif_running(ndev)) {
-		fec_stop(ndev);
-		rtnetif_device_detach(ndev);
-	}
-	clk_disable_unprepare(fep->clk_ahb);
-	clk_disable_unprepare(fep->clk_ipg);
-	return 0;
-}
-
-static int
-fec_resume(struct device *dev)
-{
-	struct rtnet_device *ndev = dev_get_drvdata(dev);
-	struct fec_enet_private *fep = rtnetdev_priv(ndev);
-
-	clk_prepare_enable(fep->clk_ahb);
-	clk_prepare_enable(fep->clk_ipg);
-	if (rtnetif_running(ndev)) {
-		fec_restart(ndev, fep->full_duplex);
-		rtnetif_device_attach(ndev);
-	}
-
-	return 0;
-}
-
-static const struct dev_pm_ops fec_pm_ops = {
-	.suspend	= fec_suspend,
-	.resume		= fec_resume,
-	.freeze		= fec_suspend,
-	.thaw		= fec_resume,
-	.poweroff	= fec_suspend,
-	.restore	= fec_resume,
-};
-#endif
-
-static struct platform_driver fec_driver = {
-	.driver	= {
-		.name	= DRIVER_NAME,
-		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
-		.pm	= &fec_pm_ops,
-#endif
-		.of_match_table = fec_dt_ids,
-	},
-	.id_table = fec_devtype,
-	.probe	= fec_probe,
-	.remove	= fec_drv_remove,
-};
-
-module_platform_driver(fec_driver);
diff --git a/kernel/drivers/net/drivers/freescale/Makefile b/kernel/drivers/net/drivers/freescale/Makefile
new file mode 100644
index 000000000..fadab2e43
--- /dev/null
+++ b/kernel/drivers/net/drivers/freescale/Makefile
@@ -0,0 +1,5 @@
+ccflags-y += -Idrivers/xenomai/net/stack/include
+
+obj-$(CONFIG_XENO_DRIVERS_NET_FEC) += rtnet_fec.o
+
+rtnet_fec-y := fec_main.o fec_ptp.o
diff --git a/kernel/drivers/net/drivers/freescale/fec.h b/kernel/drivers/net/drivers/freescale/fec.h
new file mode 100644
index 000000000..3749a2c53
--- /dev/null
+++ b/kernel/drivers/net/drivers/freescale/fec.h
@@ -0,0 +1,658 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/****************************************************************************/
+
+/*
+ *	fec.h  --  Fast Ethernet Controller for Motorola ColdFire SoC
+ *		   processors.
+ *
+ *	(C) Copyright 2000-2005, Greg Ungerer (gerg@snapgear.com)
+ *	(C) Copyright 2000-2001, Lineo (www.lineo.com)
+ */
+
+/****************************************************************************/
+#ifndef FEC_H
+#define	FEC_H
+/****************************************************************************/
+
+#include <linux/clocksource.h>
+#include <linux/net_tstamp.h>
+#include <linux/pm_qos.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
+#include <rtnet_port.h>
+
+#ifdef CONFIG_IMX_SCU_SOC
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/firmware/imx/sci.h>
+#endif
+
+#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
+    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
+    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+/*
+ *	Just figures, Motorola would have to change the offsets for
+ *	registers in the same peripheral device on different models
+ *	of the ColdFire!
+ */
+#define FEC_IEVENT		0x004 /* Interrupt event reg */
+#define FEC_IMASK		0x008 /* Interrupt mask reg */
+#define FEC_R_DES_ACTIVE_0	0x010 /* Receive descriptor reg */
+#define FEC_X_DES_ACTIVE_0	0x014 /* Transmit descriptor reg */
+#define FEC_ECNTRL		0x024 /* Ethernet control reg */
+#define FEC_MII_DATA		0x040 /* MII manage frame reg */
+#define FEC_MII_SPEED		0x044 /* MII speed control reg */
+#define FEC_MIB_CTRLSTAT	0x064 /* MIB control/status reg */
+#define FEC_R_CNTRL		0x084 /* Receive control reg */
+#define FEC_X_CNTRL		0x0c4 /* Transmit Control reg */
+#define FEC_ADDR_LOW		0x0e4 /* Low 32bits MAC address */
+#define FEC_ADDR_HIGH		0x0e8 /* High 16bits MAC address */
+#define FEC_OPD			0x0ec /* Opcode + Pause duration */
+#define FEC_TXIC0		0x0f0 /* Tx Interrupt Coalescing for ring 0 */
+#define FEC_TXIC1		0x0f4 /* Tx Interrupt Coalescing for ring 1 */
+#define FEC_TXIC2		0x0f8 /* Tx Interrupt Coalescing for ring 2 */
+#define FEC_RXIC0		0x100 /* Rx Interrupt Coalescing for ring 0 */
+#define FEC_RXIC1		0x104 /* Rx Interrupt Coalescing for ring 1 */
+#define FEC_RXIC2		0x108 /* Rx Interrupt Coalescing for ring 2 */
+#define FEC_HASH_TABLE_HIGH	0x118 /* High 32bits hash table */
+#define FEC_HASH_TABLE_LOW	0x11c /* Low 32bits hash table */
+#define FEC_GRP_HASH_TABLE_HIGH	0x120 /* High 32bits hash table */
+#define FEC_GRP_HASH_TABLE_LOW	0x124 /* Low 32bits hash table */
+#define FEC_X_WMRK		0x144 /* FIFO transmit water mark */
+#define FEC_R_BOUND		0x14c /* FIFO receive bound reg */
+#define FEC_R_FSTART		0x150 /* FIFO receive start reg */
+#define FEC_R_DES_START_1	0x160 /* Receive descriptor ring 1 */
+#define FEC_X_DES_START_1	0x164 /* Transmit descriptor ring 1 */
+#define FEC_R_BUFF_SIZE_1	0x168 /* Maximum receive buff ring1 size */
+#define FEC_R_DES_START_2	0x16c /* Receive descriptor ring 2 */
+#define FEC_X_DES_START_2	0x170 /* Transmit descriptor ring 2 */
+#define FEC_R_BUFF_SIZE_2	0x174 /* Maximum receive buff ring2 size */
+#define FEC_R_DES_START_0	0x180 /* Receive descriptor ring */
+#define FEC_X_DES_START_0	0x184 /* Transmit descriptor ring */
+#define FEC_R_BUFF_SIZE_0	0x188 /* Maximum receive buff size */
+#define FEC_R_FIFO_RSFL		0x190 /* Receive FIFO section full threshold */
+#define FEC_R_FIFO_RSEM		0x194 /* Receive FIFO section empty threshold */
+#define FEC_R_FIFO_RAEM		0x198 /* Receive FIFO almost empty threshold */
+#define FEC_R_FIFO_RAFL		0x19c /* Receive FIFO almost full threshold */
+#define FEC_FTRL		0x1b0 /* Frame truncation receive length*/
+#define FEC_TACC		0x1c0 /* Transmit accelerator reg */
+#define FEC_RACC		0x1c4 /* Receive Accelerator function */
+#define FEC_RCMR_1		0x1c8 /* Receive classification match ring 1 */
+#define FEC_RCMR_2		0x1cc /* Receive classification match ring 2 */
+#define FEC_DMA_CFG_1		0x1d8 /* DMA class configuration for ring 1 */
+#define FEC_DMA_CFG_2		0x1dc /* DMA class Configuration for ring 2 */
+#define FEC_R_DES_ACTIVE_1	0x1e0 /* Rx descriptor active for ring 1 */
+#define FEC_X_DES_ACTIVE_1	0x1e4 /* Tx descriptor active for ring 1 */
+#define FEC_R_DES_ACTIVE_2	0x1e8 /* Rx descriptor active for ring 2 */
+#define FEC_X_DES_ACTIVE_2	0x1ec /* Tx descriptor active for ring 2 */
+#define FEC_QOS_SCHEME		0x1f0 /* Set multi queues Qos scheme */
+#define FEC_LPI_SLEEP		0x1f4 /* Set IEEE802.3az LPI Sleep Ts time */
+#define FEC_LPI_WAKE		0x1f8 /* Set IEEE802.3az LPI Wake Tw time */
+#define FEC_MIIGSK_CFGR		0x300 /* MIIGSK Configuration reg */
+#define FEC_MIIGSK_ENR		0x308 /* MIIGSK Enable reg */
+
+#define BM_MIIGSK_CFGR_MII		0x00
+#define BM_MIIGSK_CFGR_RMII		0x01
+#define BM_MIIGSK_CFGR_FRCONT_10M	0x40
+
+#define RMON_T_DROP		0x200 /* Count of frames not cntd correctly */
+#define RMON_T_PACKETS		0x204 /* RMON TX packet count */
+#define RMON_T_BC_PKT		0x208 /* RMON TX broadcast pkts */
+#define RMON_T_MC_PKT		0x20c /* RMON TX multicast pkts */
+#define RMON_T_CRC_ALIGN	0x210 /* RMON TX pkts with CRC align err */
+#define RMON_T_UNDERSIZE	0x214 /* RMON TX pkts < 64 bytes, good CRC */
+#define RMON_T_OVERSIZE		0x218 /* RMON TX pkts > MAX_FL bytes good CRC */
+#define RMON_T_FRAG		0x21c /* RMON TX pkts < 64 bytes, bad CRC */
+#define RMON_T_JAB		0x220 /* RMON TX pkts > MAX_FL bytes, bad CRC */
+#define RMON_T_COL		0x224 /* RMON TX collision count */
+#define RMON_T_P64		0x228 /* RMON TX 64 byte pkts */
+#define RMON_T_P65TO127		0x22c /* RMON TX 65 to 127 byte pkts */
+#define RMON_T_P128TO255	0x230 /* RMON TX 128 to 255 byte pkts */
+#define RMON_T_P256TO511	0x234 /* RMON TX 256 to 511 byte pkts */
+#define RMON_T_P512TO1023	0x238 /* RMON TX 512 to 1023 byte pkts */
+#define RMON_T_P1024TO2047	0x23c /* RMON TX 1024 to 2047 byte pkts */
+#define RMON_T_P_GTE2048	0x240 /* RMON TX pkts > 2048 bytes */
+#define RMON_T_OCTETS		0x244 /* RMON TX octets */
+#define IEEE_T_DROP		0x248 /* Count of frames not counted crtly */
+#define IEEE_T_FRAME_OK		0x24c /* Frames tx'd OK */
+#define IEEE_T_1COL		0x250 /* Frames tx'd with single collision */
+#define IEEE_T_MCOL		0x254 /* Frames tx'd with multiple collision */
+#define IEEE_T_DEF		0x258 /* Frames tx'd after deferral delay */
+#define IEEE_T_LCOL		0x25c /* Frames tx'd with late collision */
+#define IEEE_T_EXCOL		0x260 /* Frames tx'd with excesv collisions */
+#define IEEE_T_MACERR		0x264 /* Frames tx'd with TX FIFO underrun */
+#define IEEE_T_CSERR		0x268 /* Frames tx'd with carrier sense err */
+#define IEEE_T_SQE		0x26c /* Frames tx'd with SQE err */
+#define IEEE_T_FDXFC		0x270 /* Flow control pause frames tx'd */
+#define IEEE_T_OCTETS_OK	0x274 /* Octet count for frames tx'd w/o err */
+#define RMON_R_PACKETS		0x284 /* RMON RX packet count */
+#define RMON_R_BC_PKT		0x288 /* RMON RX broadcast pkts */
+#define RMON_R_MC_PKT		0x28c /* RMON RX multicast pkts */
+#define RMON_R_CRC_ALIGN	0x290 /* RMON RX pkts with CRC alignment err */
+#define RMON_R_UNDERSIZE	0x294 /* RMON RX pkts < 64 bytes, good CRC */
+#define RMON_R_OVERSIZE		0x298 /* RMON RX pkts > MAX_FL bytes good CRC */
+#define RMON_R_FRAG		0x29c /* RMON RX pkts < 64 bytes, bad CRC */
+#define RMON_R_JAB		0x2a0 /* RMON RX pkts > MAX_FL bytes, bad CRC */
+#define RMON_R_RESVD_O		0x2a4 /* Reserved */
+#define RMON_R_P64		0x2a8 /* RMON RX 64 byte pkts */
+#define RMON_R_P65TO127		0x2ac /* RMON RX 65 to 127 byte pkts */
+#define RMON_R_P128TO255	0x2b0 /* RMON RX 128 to 255 byte pkts */
+#define RMON_R_P256TO511	0x2b4 /* RMON RX 256 to 511 byte pkts */
+#define RMON_R_P512TO1023	0x2b8 /* RMON RX 512 to 1023 byte pkts */
+#define RMON_R_P1024TO2047	0x2bc /* RMON RX 1024 to 2047 byte pkts */
+#define RMON_R_P_GTE2048	0x2c0 /* RMON RX pkts > 2048 bytes */
+#define RMON_R_OCTETS		0x2c4 /* RMON RX octets */
+#define IEEE_R_DROP		0x2c8 /* Count frames not counted correctly */
+#define IEEE_R_FRAME_OK		0x2cc /* Frames rx'd OK */
+#define IEEE_R_CRC		0x2d0 /* Frames rx'd with CRC err */
+#define IEEE_R_ALIGN		0x2d4 /* Frames rx'd with alignment err */
+#define IEEE_R_MACERR		0x2d8 /* Receive FIFO overflow count */
+#define IEEE_R_FDXFC		0x2dc /* Flow control pause frames rx'd */
+#define IEEE_R_OCTETS_OK	0x2e0 /* Octet cnt for frames rx'd w/o err */
+
+#else
+
+#define FEC_ECNTRL		0x000 /* Ethernet control reg */
+#define FEC_IEVENT		0x004 /* Interrupt even reg */
+#define FEC_IMASK		0x008 /* Interrupt mask reg */
+#define FEC_IVEC		0x00c /* Interrupt vec status reg */
+#define FEC_R_DES_ACTIVE_0	0x010 /* Receive descriptor reg */
+#define FEC_R_DES_ACTIVE_1	FEC_R_DES_ACTIVE_0
+#define FEC_R_DES_ACTIVE_2	FEC_R_DES_ACTIVE_0
+#define FEC_X_DES_ACTIVE_0	0x014 /* Transmit descriptor reg */
+#define FEC_X_DES_ACTIVE_1	FEC_X_DES_ACTIVE_0
+#define FEC_X_DES_ACTIVE_2	FEC_X_DES_ACTIVE_0
+#define FEC_MII_DATA		0x040 /* MII manage frame reg */
+#define FEC_MII_SPEED		0x044 /* MII speed control reg */
+#define FEC_R_BOUND		0x08c /* FIFO receive bound reg */
+#define FEC_R_FSTART		0x090 /* FIFO receive start reg */
+#define FEC_X_WMRK		0x0a4 /* FIFO transmit water mark */
+#define FEC_X_FSTART		0x0ac /* FIFO transmit start reg */
+#define FEC_R_CNTRL		0x104 /* Receive control reg */
+#define FEC_MAX_FRM_LEN		0x108 /* Maximum frame length reg */
+#define FEC_X_CNTRL		0x144 /* Transmit Control reg */
+#define FEC_ADDR_LOW		0x3c0 /* Low 32bits MAC address */
+#define FEC_ADDR_HIGH		0x3c4 /* High 16bits MAC address */
+#define FEC_GRP_HASH_TABLE_HIGH	0x3c8 /* High 32bits hash table */
+#define FEC_GRP_HASH_TABLE_LOW	0x3cc /* Low 32bits hash table */
+#define FEC_R_DES_START_0	0x3d0 /* Receive descriptor ring */
+#define FEC_R_DES_START_1	FEC_R_DES_START_0
+#define FEC_R_DES_START_2	FEC_R_DES_START_0
+#define FEC_X_DES_START_0	0x3d4 /* Transmit descriptor ring */
+#define FEC_X_DES_START_1	FEC_X_DES_START_0
+#define FEC_X_DES_START_2	FEC_X_DES_START_0
+#define FEC_R_BUFF_SIZE_0	0x3d8 /* Maximum receive buff size */
+#define FEC_R_BUFF_SIZE_1	FEC_R_BUFF_SIZE_0
+#define FEC_R_BUFF_SIZE_2	FEC_R_BUFF_SIZE_0
+#define FEC_FIFO_RAM		0x400 /* FIFO RAM buffer */
+/* Not existed in real chip
+ * Just for pass build.
+ */
+#define FEC_RCMR_1		0xfff
+#define FEC_RCMR_2		0xfff
+#define FEC_DMA_CFG_1		0xfff
+#define FEC_DMA_CFG_2		0xfff
+#define FEC_TXIC0		0xfff
+#define FEC_TXIC1		0xfff
+#define FEC_TXIC2		0xfff
+#define FEC_RXIC0		0xfff
+#define FEC_RXIC1		0xfff
+#define FEC_RXIC2		0xfff
+#endif /* CONFIG_M5272 */
+
+
+/*
+ *	Define the buffer descriptor structure.
+ *
+ *	Evidently, ARM SoCs have the FEC block generated in a
+ *	little endian mode so adjust endianness accordingly.
+ */
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#define fec32_to_cpu le32_to_cpu
+#define fec16_to_cpu le16_to_cpu
+#define cpu_to_fec32 cpu_to_le32
+#define cpu_to_fec16 cpu_to_le16
+#define __fec32 __le32
+#define __fec16 __le16
+
+struct bufdesc {
+	__fec16 cbd_datlen;	/* Data length */
+	__fec16 cbd_sc;		/* Control and status info */
+	__fec32 cbd_bufaddr;	/* Buffer address */
+};
+#else
+#define fec32_to_cpu be32_to_cpu
+#define fec16_to_cpu be16_to_cpu
+#define cpu_to_fec32 cpu_to_be32
+#define cpu_to_fec16 cpu_to_be16
+#define __fec32 __be32
+#define __fec16 __be16
+
+struct bufdesc {
+	__fec16	cbd_sc;		/* Control and status info */
+	__fec16	cbd_datlen;	/* Data length */
+	__fec32	cbd_bufaddr;	/* Buffer address */
+};
+#endif
+
+struct bufdesc_ex {
+	struct bufdesc desc;
+	__fec32 cbd_esc;
+	__fec32 cbd_prot;
+	__fec32 cbd_bdu;
+	__fec32 ts;
+	__fec16 res0[4];
+};
+
+/*
+ *	The following definitions courtesy of commproc.h, which where
+ *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
+ */
+#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
+#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
+#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
+#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
+#define BD_SC_CM	((ushort)0x0200)	/* Continuous mode */
+#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
+#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
+#define BD_SC_BR	((ushort)0x0020)	/* Break received */
+#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
+#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
+#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
+#define BD_SC_CD	((ushort)0x0001)	/* ?? */
+
+/* Buffer descriptor control/status used by Ethernet receive.
+ */
+#define BD_ENET_RX_EMPTY	((ushort)0x8000)
+#define BD_ENET_RX_WRAP		((ushort)0x2000)
+#define BD_ENET_RX_INTR		((ushort)0x1000)
+#define BD_ENET_RX_LAST		((ushort)0x0800)
+#define BD_ENET_RX_FIRST	((ushort)0x0400)
+#define BD_ENET_RX_MISS		((ushort)0x0100)
+#define BD_ENET_RX_LG		((ushort)0x0020)
+#define BD_ENET_RX_NO		((ushort)0x0010)
+#define BD_ENET_RX_SH		((ushort)0x0008)
+#define BD_ENET_RX_CR		((ushort)0x0004)
+#define BD_ENET_RX_OV		((ushort)0x0002)
+#define BD_ENET_RX_CL		((ushort)0x0001)
+#define BD_ENET_RX_STATS	((ushort)0x013f)	/* All status bits */
+
+/* Enhanced buffer descriptor control/status used by Ethernet receive */
+#define BD_ENET_RX_VLAN		0x00000004
+
+/* Buffer descriptor control/status used by Ethernet transmit.
+ */
+#define BD_ENET_TX_READY	((ushort)0x8000)
+#define BD_ENET_TX_PAD		((ushort)0x4000)
+#define BD_ENET_TX_WRAP		((ushort)0x2000)
+#define BD_ENET_TX_INTR		((ushort)0x1000)
+#define BD_ENET_TX_LAST		((ushort)0x0800)
+#define BD_ENET_TX_TC		((ushort)0x0400)
+#define BD_ENET_TX_DEF		((ushort)0x0200)
+#define BD_ENET_TX_HB		((ushort)0x0100)
+#define BD_ENET_TX_LC		((ushort)0x0080)
+#define BD_ENET_TX_RL		((ushort)0x0040)
+#define BD_ENET_TX_RCMASK	((ushort)0x003c)
+#define BD_ENET_TX_UN		((ushort)0x0002)
+#define BD_ENET_TX_CSL		((ushort)0x0001)
+#define BD_ENET_TX_STATS	((ushort)0x0fff)	/* All status bits */
+
+/* enhanced buffer descriptor control/status used by Ethernet transmit */
+#define BD_ENET_TX_INT		0x40000000
+#define BD_ENET_TX_TS		0x20000000
+#define BD_ENET_TX_PINS		0x10000000
+#define BD_ENET_TX_IINS		0x08000000
+
+
+/* This device has up to three irqs on some platforms */
+#define FEC_IRQ_NUM		3
+
+/* Maximum number of queues supported
+ * ENET with AVB IP can support up to 3 independent tx queues and rx queues.
+ * User can point the queue number that is less than or equal to 3.
+ */
+#define FEC_ENET_MAX_TX_QS	3
+#define FEC_ENET_MAX_RX_QS	3
+
+#define FEC_R_DES_START(X)	(((X) == 1) ? FEC_R_DES_START_1 : \
+				(((X) == 2) ? \
+					FEC_R_DES_START_2 : FEC_R_DES_START_0))
+#define FEC_X_DES_START(X)	(((X) == 1) ? FEC_X_DES_START_1 : \
+				(((X) == 2) ? \
+					FEC_X_DES_START_2 : FEC_X_DES_START_0))
+#define FEC_R_BUFF_SIZE(X)	(((X) == 1) ? FEC_R_BUFF_SIZE_1 : \
+				(((X) == 2) ? \
+					FEC_R_BUFF_SIZE_2 : FEC_R_BUFF_SIZE_0))
+
+#define FEC_DMA_CFG(X)		(((X) == 2) ? FEC_DMA_CFG_2 : FEC_DMA_CFG_1)
+
+#define DMA_CLASS_EN		(1 << 16)
+#define FEC_RCMR(X)		(((X) == 2) ? FEC_RCMR_2 : FEC_RCMR_1)
+#define IDLE_SLOPE_MASK		0xffff
+#define IDLE_SLOPE_1		0x200 /* BW fraction: 0.5 */
+#define IDLE_SLOPE_2		0x200 /* BW fraction: 0.5 */
+#define IDLE_SLOPE(X)		(((X) == 1) ?				\
+				(IDLE_SLOPE_1 & IDLE_SLOPE_MASK) :	\
+				(IDLE_SLOPE_2 & IDLE_SLOPE_MASK))
+#define RCMR_MATCHEN		(0x1 << 16)
+#define RCMR_CMP_CFG(v, n)	(((v) & 0x7) <<  (n << 2))
+#define RCMR_CMP_1		(RCMR_CMP_CFG(0, 0) | RCMR_CMP_CFG(1, 1) | \
+				RCMR_CMP_CFG(2, 2) | RCMR_CMP_CFG(3, 3))
+#define RCMR_CMP_2		(RCMR_CMP_CFG(4, 0) | RCMR_CMP_CFG(5, 1) | \
+				RCMR_CMP_CFG(6, 2) | RCMR_CMP_CFG(7, 3))
+#define RCMR_CMP(X)		(((X) == 1) ? RCMR_CMP_1 : RCMR_CMP_2)
+#define FEC_TX_BD_FTYPE(X)	(((X) & 0xf) << 20)
+
+/* The number of Tx and Rx buffers.  These are allocated from the page
+ * pool.  The code may assume these are power of two, so it it best
+ * to keep them that size.
+ * We don't need to allocate pages for the transmitter.  We just use
+ * the skbuffer directly.
+ */
+
+#define FEC_ENET_RX_PAGES	256
+#define FEC_ENET_RX_FRSIZE	RTSKB_SIZE /* Maximum size for RTnet */
+#define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
+#define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
+#define FEC_ENET_TX_FRSIZE	RTSKB_SIZE
+#define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
+#define TX_RING_SIZE		512	/* Must be power of two */
+#define TX_RING_MOD_MASK	511	/*   for this to work */
+
+#define BD_ENET_RX_INT		0x00800000
+#define BD_ENET_RX_PTP		((ushort)0x0400)
+#define BD_ENET_RX_ICE		0x00000020
+#define BD_ENET_RX_PCR		0x00000010
+#define FLAG_RX_CSUM_ENABLED	(BD_ENET_RX_ICE | BD_ENET_RX_PCR)
+#define FLAG_RX_CSUM_ERROR	(BD_ENET_RX_ICE | BD_ENET_RX_PCR)
+
+/* Interrupt events/masks. */
+#define FEC_ENET_HBERR  ((uint)0x80000000)      /* Heartbeat error */
+#define FEC_ENET_BABR   ((uint)0x40000000)      /* Babbling receiver */
+#define FEC_ENET_BABT   ((uint)0x20000000)      /* Babbling transmitter */
+#define FEC_ENET_GRA    ((uint)0x10000000)      /* Graceful stop complete */
+#define FEC_ENET_TXF_0	((uint)0x08000000)	/* Full frame transmitted */
+#define FEC_ENET_TXF_1	((uint)0x00000008)	/* Full frame transmitted */
+#define FEC_ENET_TXF_2	((uint)0x00000080)	/* Full frame transmitted */
+#define FEC_ENET_TXB    ((uint)0x04000000)      /* A buffer was transmitted */
+#define FEC_ENET_RXF_0	((uint)0x02000000)	/* Full frame received */
+#define FEC_ENET_RXF_1	((uint)0x00000002)	/* Full frame received */
+#define FEC_ENET_RXF_2	((uint)0x00000020)	/* Full frame received */
+#define FEC_ENET_RXB    ((uint)0x01000000)      /* A buffer was received */
+#define FEC_ENET_MII    ((uint)0x00800000)      /* MII interrupt */
+#define FEC_ENET_EBERR  ((uint)0x00400000)      /* SDMA bus error */
+#define FEC_ENET_WAKEUP	((uint)0x00020000)	/* Wakeup request */
+#define FEC_ENET_TXF	(FEC_ENET_TXF_0 | FEC_ENET_TXF_1 | FEC_ENET_TXF_2)
+#define FEC_ENET_RXF	(FEC_ENET_RXF_0 | FEC_ENET_RXF_1 | FEC_ENET_RXF_2)
+#define FEC_ENET_TS_AVAIL       ((uint)0x00010000)
+#define FEC_ENET_TS_TIMER       ((uint)0x00008000)
+
+#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII)
+#define FEC_NAPI_IMASK	FEC_ENET_MII
+#define FEC_RX_DISABLED_IMASK (FEC_DEFAULT_IMASK & (~FEC_ENET_RXF))
+
+#define FEC_ENET_ETHEREN	((uint)0x00000002)
+#define FEC_ENET_TXC_DLY	((uint)0x00010000)
+#define FEC_ENET_RXC_DLY	((uint)0x00020000)
+
+/* ENET interrupt coalescing macro define */
+#define FEC_ITR_CLK_SEL		(0x1 << 30)
+#define FEC_ITR_EN		(0x1 << 31)
+#define FEC_ITR_ICFT(X)		(((X) & 0xff) << 20)
+#define FEC_ITR_ICTT(X)		((X) & 0xffff)
+#define FEC_ITR_ICFT_DEFAULT	200  /* Set 200 frame count threshold */
+#define FEC_ITR_ICTT_DEFAULT	1000 /* Set 1000us timer threshold */
+
+#define FEC_VLAN_TAG_LEN	0x04
+#define FEC_ETHTYPE_LEN		0x02
+
+/* Controller is ENET-MAC */
+#define FEC_QUIRK_ENET_MAC		(1 << 0)
+/* Controller needs driver to swap frame */
+#define FEC_QUIRK_SWAP_FRAME		(1 << 1)
+/* Controller uses gasket */
+#define FEC_QUIRK_USE_GASKET		(1 << 2)
+/* Controller has GBIT support */
+#define FEC_QUIRK_HAS_GBIT		(1 << 3)
+/* Controller has extend desc buffer */
+#define FEC_QUIRK_HAS_BUFDESC_EX	(1 << 4)
+/* Controller has hardware checksum support */
+#define FEC_QUIRK_HAS_CSUM		(1 << 5)
+/* Controller has hardware vlan support */
+#define FEC_QUIRK_HAS_VLAN		(1 << 6)
+/* ENET IP errata ERR006358
+ *
+ * If the ready bit in the transmit buffer descriptor (TxBD[R]) is previously
+ * detected as not set during a prior frame transmission, then the
+ * ENET_TDAR[TDAR] bit is cleared at a later time, even if additional TxBDs
+ * were added to the ring and the ENET_TDAR[TDAR] bit is set. This results in
+ * frames not being transmitted until there is a 0-to-1 transition on
+ * ENET_TDAR[TDAR].
+ */
+#define FEC_QUIRK_ERR006358		(1 << 7)
+/* ENET IP hw AVB
+ *
+ * i.MX6SX ENET IP add Audio Video Bridging (AVB) feature support.
+ * - Two class indicators on receive with configurable priority
+ * - Two class indicators and line speed timer on transmit allowing
+ *   implementation class credit based shapers externally
+ * - Additional DMA registers provisioned to allow managing up to 3
+ *   independent rings
+ */
+#define FEC_QUIRK_HAS_AVB		(1 << 8)
+/* There is a TDAR race condition for mutliQ when the software sets TDAR
+ * and the UDMA clears TDAR simultaneously or in a small window (2-4 cycles).
+ * This will cause the udma_tx and udma_tx_arbiter state machines to hang.
+ * The issue exist at i.MX6SX enet IP.
+ */
+#define FEC_QUIRK_ERR007885		(1 << 9)
+/* ENET Block Guide/ Chapter for the iMX6SX (PELE) address one issue:
+ * After set ENET_ATCR[Capture], there need some time cycles before the counter
+ * value is capture in the register clock domain.
+ * The wait-time-cycles is at least 6 clock cycles of the slower clock between
+ * the register clock and the 1588 clock. The 1588 ts_clk is fixed to 25Mhz,
+ * register clock is 66Mhz, so the wait-time-cycles must be greater than 240ns
+ * (40ns * 6).
+ */
+#define FEC_QUIRK_BUG_CAPTURE		(1 << 10)
+/* Controller has only one MDIO bus */
+#define FEC_QUIRK_SINGLE_MDIO		(1 << 11)
+/* Controller supports RACC register */
+#define FEC_QUIRK_HAS_RACC		(1 << 12)
+/* Controller supports interrupt coalesc */
+#define FEC_QUIRK_HAS_COALESCE		(1 << 13)
+/* Interrupt doesn't wake CPU from deep idle */
+#define FEC_QUIRK_ERR006687		(1 << 14)
+/* The MIB counters should be cleared and enabled during
+ * initialisation.
+ */
+#define FEC_QUIRK_MIB_CLEAR		(1 << 15)
+/* Only i.MX25/i.MX27/i.MX28 controller supports FRBR,FRSR registers,
+ * those FIFO receive registers are resolved in other platforms.
+ */
+#define FEC_QUIRK_HAS_FRREG		(1 << 16)
+/* i.MX8MQ ENET IP version add new feature to support IEEE 802.3az EEE
+ * standard. For the transmission, MAC supply two user registers to set
+ * Sleep (TS) and Wake (TW) time.
+ */
+#define FEC_QUIRK_HAS_EEE		(1 << 17)
+/* i.MX8QM ENET IP version add new feture to generate delayed TXC/RXC
+ * as an alternative option to make sure it works well with various PHYs.
+ * For the implementation of delayed clock, ENET takes synchronized 250MHz
+ * clocks to generate 2ns delay.
+ */
+#define FEC_QUIRK_DELAYED_CLKS_SUPPORT	(1 << 18)
+/* request pmqos during low power */
+#define FEC_QUIRK_HAS_PMQOS		(1 << 19)
+
+struct fec_enet_stop_mode {
+	struct regmap *gpr;
+	u8 req_gpr;
+	u8 req_bit;
+};
+
+struct bufdesc_prop {
+	int qid;
+	/* Address of Rx and Tx buffers */
+	struct bufdesc	*base;
+	struct bufdesc	*last;
+	struct bufdesc	*cur;
+	void __iomem	*reg_desc_active;
+	dma_addr_t	dma;
+	unsigned short ring_size;
+	unsigned char dsize;
+	unsigned char dsize_log2;
+};
+
+struct fec_enet_priv_tx_q {
+	struct bufdesc_prop bd;
+	unsigned char *tx_bounce[TX_RING_SIZE];
+	struct  sk_buff *tx_skbuff[TX_RING_SIZE];
+	struct rtskb *tx_rtbuff[TX_RING_SIZE];
+
+	unsigned short tx_stop_threshold;
+	unsigned short tx_wake_threshold;
+
+	struct bufdesc	*dirty_tx;
+	char *tso_hdrs;
+	dma_addr_t tso_hdrs_dma;
+};
+
+struct fec_enet_priv_rx_q {
+	struct bufdesc_prop bd;
+	struct  sk_buff *rx_skbuff[RX_RING_SIZE];
+	struct rtskb *rx_rtbuff[RX_RING_SIZE];
+};
+
+/* The FEC buffer descriptors track the ring buffers.  The rx_bd_base and
+ * tx_bd_base always point to the base of the buffer descriptors.  The
+ * cur_rx and cur_tx point to the currently available buffer.
+ * The dirty_tx tracks the current buffer that is being sent by the
+ * controller.  The cur_tx and dirty_tx are equal under both completely
+ * empty and completely full conditions.  The empty/ready indicator in
+ * the buffer descriptor determines the actual condition.
+ */
+struct fec_enet_private {
+	/* Hardware registers of the FEC device */
+	void __iomem *hwp;
+
+	struct net_device *netdev;
+
+	struct fec_rt_data {
+		rtdm_irq_t irq_handle[3];
+		rtdm_lock_t lock;
+		rtdm_nrtsig_t mdio_sig;
+		struct rtnet_device dev;
+		bool enabled;
+	} rtnet;
+
+	struct clk *clk_ipg;
+	struct clk *clk_ahb;
+	struct clk *clk_ref;
+	struct clk *clk_enet_out;
+	struct clk *clk_ptp;
+	struct clk *clk_2x_txclk;
+
+	bool ptp_clk_on;
+	struct mutex ptp_clk_mutex;
+	unsigned int num_tx_queues;
+	unsigned int num_rx_queues;
+
+	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
+	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
+	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
+
+	unsigned int total_tx_ring_size;
+	unsigned int total_rx_ring_size;
+
+	unsigned long work_tx;
+	unsigned long work_rx;
+	unsigned long work_ts;
+	unsigned long work_mdio;
+
+	struct	platform_device *pdev;
+
+	int	dev_id;
+
+	/* Phylib and MDIO interface */
+	struct	mii_bus *mii_bus;
+	uint	phy_speed;
+	phy_interface_t	phy_interface;
+	struct device_node *phy_node;
+	bool	rgmii_txc_dly;
+	bool	rgmii_rxc_dly;
+	bool	mii_bus_share;
+	bool	rpm_active;
+	int	link;
+	int	full_duplex;
+	int	speed;
+	struct	completion mdio_done;
+	int	irq[FEC_IRQ_NUM];
+	int	irqnr;
+	bool	bufdesc_ex;
+	int	pause_flag;
+	int	wol_flag;
+	int	wake_irq;
+	u32	quirks;
+
+	struct	napi_struct napi;
+	int	csum_flags;
+
+	struct work_struct tx_timeout_work;
+
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_caps;
+	unsigned long last_overflow_check;
+	spinlock_t tmreg_lock;
+	struct cyclecounter cc;
+	struct timecounter tc;
+	int rx_hwtstamp_filter;
+	u32 base_incval;
+	u32 cycle_speed;
+	int hwts_rx_en;
+	int hwts_tx_en;
+	struct delayed_work time_keep;
+	struct regulator *reg_phy;
+	struct pm_qos_request pm_qos_req;
+
+	unsigned int tx_align;
+	unsigned int rx_align;
+
+	/* hw interrupt coalesce */
+	unsigned int rx_pkts_itr;
+	unsigned int rx_time_itr;
+	unsigned int tx_pkts_itr;
+	unsigned int tx_time_itr;
+	unsigned int itr_clk_rate;
+
+	/* tx lpi eee mode */
+	struct ethtool_eee eee;
+	unsigned int clk_ref_rate;
+
+	u32 rx_copybreak;
+
+	/* ptp clock period in ns*/
+	unsigned int ptp_inc;
+
+	/* pps  */
+	int pps_channel;
+	unsigned int reload_period;
+	int pps_enable;
+	unsigned int next_counter;
+
+	/* stop mode */
+	struct fec_enet_stop_mode lpm;
+#ifdef CONFIG_IMX_SCU_SOC
+	struct imx_sc_ipc *ipc_handle;
+#endif
+
+	u64 ethtool_stats[0];
+};
+
+void fec_ptp_init(struct platform_device *pdev, int irq_idx);
+void fec_ptp_stop(struct platform_device *pdev);
+void fec_ptp_start_cyclecounter(struct net_device *ndev);
+int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr);
+int fec_ptp_get(struct net_device *ndev, struct ifreq *ifr);
+
+/****************************************************************************/
+#endif /* FEC_H */
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
new file mode 100644
index 000000000..90c8bac69
--- /dev/null
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -0,0 +1,4926 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Fast Ethernet Controller (FEC) driver for Motorola MPC8xx.
+ * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
+ *
+ * Right now, I am very wasteful with the buffers.  I allocate memory
+ * pages and then divide them into 2K frame buffers.  This way I know I
+ * have buffers large enough to hold one frame within one buffer descriptor.
+ * Once I get this working, I will use 64 or 128 byte CPM buffers, which
+ * will be much more memory efficient and will easily handle lots of
+ * small packets.
+ *
+ * Much better multiple PHY support by Magnus Damm.
+ * Copyright (c) 2000 Ericsson Radio Systems AB.
+ *
+ * Support for FEC controller of ColdFire processors.
+ * Copyright (c) 2001-2005 Greg Ungerer (gerg@snapgear.com)
+ *
+ * Bug fixes and cleanup by Philippe De Muyter (phdm@macqel.be)
+ * Copyright (c) 2004-2006 Macq Electronique SA.
+ *
+ * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/pm_runtime.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <net/ip.h>
+#include <net/tso.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/icmp.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/crc32.h>
+#include <linux/platform_device.h>
+#include <linux/mdio.h>
+#include <linux/phy.h>
+#include <linux/fec.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/regulator/consumer.h>
+#include <linux/if_vlan.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/busfreq-imx.h>
+#include <linux/prefetch.h>
+#include <soc/imx/cpuidle.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include <asm/cacheflush.h>
+
+#include "fec.h"
+
+static bool rtnet_disabled;
+module_param_named(rtnet_disabled, rtnet_disabled, bool, 0444);
+
+static void set_multicast_list(struct net_device *ndev);
+static void fec_enet_itr_coal_init(struct net_device *ndev);
+
+#define DRIVER_NAME	"rtnet_fec"
+
+#define FEC_ENET_GET_QUQUE(_x) ((_x == 0) ? 1 : ((_x == 1) ? 2 : 0))
+static const u16 fec_enet_vlan_pri_to_queue[8] = {1, 1, 1, 1, 2, 2, 2, 2};
+
+/* Pause frame feild and FIFO threshold */
+#define FEC_ENET_FCE	(1 << 5)
+#define FEC_ENET_RSEM_V	0x84
+#define FEC_ENET_RSFL_V	16
+#define FEC_ENET_RAEM_V	0x8
+#define FEC_ENET_RAFL_V	0x8
+#define FEC_ENET_OPD_V	0xFFF0
+#define FEC_MDIO_PM_TIMEOUT  100 /* ms */
+
+static struct platform_device_id fec_devtype[] = {
+	{
+		/* keep it for coldfire */
+		.name = DRIVER_NAME,
+		.driver_data = 0,
+	}, {
+		.name = "imx25-fec",
+		.driver_data = FEC_QUIRK_USE_GASKET | FEC_QUIRK_MIB_CLEAR |
+			       FEC_QUIRK_HAS_FRREG,
+	}, {
+		.name = "imx27-fec",
+		.driver_data = FEC_QUIRK_MIB_CLEAR | FEC_QUIRK_HAS_FRREG,
+	}, {
+		.name = "imx28-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME |
+				FEC_QUIRK_SINGLE_MDIO | FEC_QUIRK_HAS_RACC |
+				FEC_QUIRK_HAS_FRREG,
+	}, {
+		.name = "imx6q-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
+				FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
+				FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358 |
+				FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_PMQOS,
+	}, {
+		.name = "mvf600-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_RACC,
+	}, {
+		.name = "imx6sx-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
+				FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
+				FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
+				FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
+				FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE,
+	}, {
+		.name = "imx6ul-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
+				FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
+				FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR007885 |
+				FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_HAS_RACC |
+				FEC_QUIRK_HAS_COALESCE,
+	}, {
+		.name = "imx8mq-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
+				FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
+				FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
+				FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
+				FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
+				FEC_QUIRK_HAS_EEE,
+	}, {
+		.name = "imx8qm-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
+				FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
+				FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
+				FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
+				FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
+				FEC_QUIRK_DELAYED_CLKS_SUPPORT,
+	}, {
+		.name = "s32v234-fec",
+		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
+				FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
+				FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
+				FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, fec_devtype);
+
+enum imx_fec_type {
+	IMX25_FEC = 1,	/* runs on i.mx25/50/53 */
+	IMX27_FEC,	/* runs on i.mx27/35/51 */
+	IMX28_FEC,
+	IMX6Q_FEC,
+	MVF600_FEC,
+	IMX6SX_FEC,
+	IMX6UL_FEC,
+	IMX8MQ_FEC,
+	IMX8QM_FEC,
+	S32V234_FEC,
+};
+
+static const struct of_device_id fec_dt_ids[] = {
+	{ .compatible = "fsl,imx25-fec", .data = &fec_devtype[IMX25_FEC], },
+	{ .compatible = "fsl,imx27-fec", .data = &fec_devtype[IMX27_FEC], },
+	{ .compatible = "fsl,imx28-fec", .data = &fec_devtype[IMX28_FEC], },
+	{ .compatible = "fsl,imx6q-fec", .data = &fec_devtype[IMX6Q_FEC], },
+	{ .compatible = "fsl,mvf600-fec", .data = &fec_devtype[MVF600_FEC], },
+	{ .compatible = "fsl,imx6sx-fec", .data = &fec_devtype[IMX6SX_FEC], },
+	{ .compatible = "fsl,imx6ul-fec", .data = &fec_devtype[IMX6UL_FEC], },
+	{ .compatible = "fsl,imx8mq-fec", .data = &fec_devtype[IMX8MQ_FEC], },
+	{ .compatible = "fsl,imx8qm-fec", .data = &fec_devtype[IMX8QM_FEC], },
+	{ .compatible = "fsl,s32v234-fec", .data = &fec_devtype[S32V234_FEC], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fec_dt_ids);
+
+static unsigned char macaddr[ETH_ALEN];
+module_param_array(macaddr, byte, NULL, 0);
+MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
+
+#if defined(CONFIG_M5272)
+/*
+ * Some hardware gets it MAC address out of local flash memory.
+ * if this is non-zero then assume it is the address to get MAC from.
+ */
+#if defined(CONFIG_NETtel)
+#define	FEC_FLASHMAC	0xf0006006
+#elif defined(CONFIG_GILBARCONAP) || defined(CONFIG_SCALES)
+#define	FEC_FLASHMAC	0xf0006000
+#elif defined(CONFIG_CANCam)
+#define	FEC_FLASHMAC	0xf0020000
+#elif defined (CONFIG_M5272C3)
+#define	FEC_FLASHMAC	(0xffe04000 + 4)
+#elif defined(CONFIG_MOD5272)
+#define FEC_FLASHMAC	0xffc0406b
+#else
+#define	FEC_FLASHMAC	0
+#endif
+#endif /* CONFIG_M5272 */
+
+/* The FEC stores dest/src/type/vlan, data, and checksum for receive packets.
+ *
+ * 2048 byte skbufs are allocated. However, alignment requirements
+ * varies between FEC variants. Worst case is 64, so round down by 64.
+ */
+#define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
+#define PKT_MINBUF_SIZE		64
+
+/* FEC receive acceleration */
+#define FEC_RACC_IPDIS		(1 << 1)
+#define FEC_RACC_PRODIS		(1 << 2)
+#define FEC_RACC_SHIFT16	BIT(7)
+#define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
+
+/* MIB Control Register */
+#define FEC_MIB_CTRLSTAT_DISABLE	BIT(31)
+
+/*
+ * The 5270/5271/5280/5282/532x RX control register also contains maximum frame
+ * size bits. Other FEC hardware does not, so we need to take that into
+ * account when setting it.
+ */
+#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
+    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
+    defined(CONFIG_ARM64)
+#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
+#else
+#define	OPT_FRAME_SIZE	0
+#endif
+
+/* FEC MII MMFR bits definition */
+#define FEC_MMFR_ST		(1 << 30)
+#define FEC_MMFR_ST_C45		(0)
+#define FEC_MMFR_OP_READ	(2 << 28)
+#define FEC_MMFR_OP_READ_C45	(3 << 28)
+#define FEC_MMFR_OP_WRITE	(1 << 28)
+#define FEC_MMFR_OP_ADDR_WRITE	(0)
+#define FEC_MMFR_PA(v)		((v & 0x1f) << 23)
+#define FEC_MMFR_RA(v)		((v & 0x1f) << 18)
+#define FEC_MMFR_TA		(2 << 16)
+#define FEC_MMFR_DATA(v)	(v & 0xffff)
+/* FEC ECR bits definition */
+#define FEC_ECR_MAGICEN		(1 << 2)
+#define FEC_ECR_SLEEP		(1 << 3)
+
+#define FEC_MII_TIMEOUT		30000 /* us */
+
+/* Transmitter timeout */
+#define TX_TIMEOUT (2 * HZ)
+
+#define FEC_PAUSE_FLAG_AUTONEG	0x1
+#define FEC_PAUSE_FLAG_ENABLE	0x2
+#define FEC_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
+#define FEC_WOL_FLAG_ENABLE		(0x1 << 1)
+#define FEC_WOL_FLAG_SLEEP_ON		(0x1 << 2)
+
+/* By default, set the copybreak to 1518,
+ * then the RX path always keep DMA memory unchanged, and
+ * allocate one new skb and copy DMA memory data to the new skb
+ * buffer, which can improve the performance when SMMU is enabled.
+ *
+ * The driver support .set_tunable() interface for ethtool, user
+ * can dynamicly change the copybreak value.
+ */
+#define COPYBREAK_DEFAULT	1518
+
+/* Max number of allowed TCP segments for software TSO */
+#define FEC_MAX_TSO_SEGS	100
+#define FEC_MAX_SKB_DESCS	(FEC_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
+
+#define IS_TSO_HEADER(txq, addr) \
+	((addr >= txq->tso_hdrs_dma) && \
+	(addr < txq->tso_hdrs_dma + txq->bd.ring_size * TSO_HEADER_SIZE))
+
+static int mii_cnt;
+
+static inline bool if_running(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	if (frt->enabled)
+		return rtnetif_running(&frt->dev);
+
+	return netif_running(ndev);
+}
+
+static inline void if_tx_lock(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	if (frt->enabled) {
+		rtnetif_stop_queue(&frt->dev);
+		return;
+	}
+
+	netif_tx_lock_bh(ndev);
+}
+	
+static inline void if_lock(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	if (frt->enabled) {
+		rtnetif_stop_queue(&frt->dev);
+		return;
+	}
+
+	napi_disable(&fep->napi);
+	netif_tx_lock_bh(ndev);
+}
+	
+static inline void if_tx_unlock(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	if (frt->enabled) {
+		rtnetif_wake_queue(&frt->dev);
+		return;
+	}
+
+	netif_tx_unlock_bh(ndev);
+}
+	
+static inline void if_unlock(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	if (frt->enabled) {
+		rtnetif_wake_queue(&frt->dev);
+		return;
+	}
+
+	netif_tx_unlock_bh(ndev);
+	napi_enable(&fep->napi);
+}
+	
+static inline void if_wake_unlock(struct net_device *ndev, bool all)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	if (frt->enabled) {
+		rtnetif_wake_queue(&frt->dev);
+		return;
+	}
+
+	if (all)
+		netif_tx_wake_all_queues(ndev);
+	else
+		netif_wake_queue(ndev);
+
+	netif_tx_unlock_bh(ndev);
+	napi_enable(&fep->napi);
+}
+	
+static struct bufdesc *fec_enet_get_nextdesc(struct bufdesc *bdp,
+					     struct bufdesc_prop *bd)
+{
+	return (bdp >= bd->last) ? bd->base
+			: (struct bufdesc *)(((void *)bdp) + bd->dsize);
+}
+
+static struct bufdesc *fec_enet_get_prevdesc(struct bufdesc *bdp,
+					     struct bufdesc_prop *bd)
+{
+	return (bdp <= bd->base) ? bd->last
+			: (struct bufdesc *)(((void *)bdp) - bd->dsize);
+}
+
+static int fec_enet_get_bd_index(struct bufdesc *bdp,
+				 struct bufdesc_prop *bd)
+{
+	return ((const char *)bdp - (const char *)bd->base) >> bd->dsize_log2;
+}
+
+static int fec_enet_get_free_txdesc_num(struct fec_enet_priv_tx_q *txq)
+{
+	int entries;
+
+	entries = (((const char *)txq->dirty_tx -
+			(const char *)txq->bd.cur) >> txq->bd.dsize_log2) - 1;
+
+	return entries >= 0 ? entries : entries + txq->bd.ring_size;
+}
+
+static void swap_buffer(void *bufaddr, int len)
+{
+	int i;
+	unsigned int *buf = bufaddr;
+
+	for (i = 0; i < len; i += 4, buf++)
+		swab32s(buf);
+}
+
+static void swap_buffer2(void *dst_buf, void *src_buf, int len)
+{
+	int i;
+	unsigned int *src = src_buf;
+	unsigned int *dst = dst_buf;
+
+	for (i = 0; i < len; i += 4, src++, dst++)
+		*dst = swab32p(src);
+}
+
+static void fec_dump(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct bufdesc *bdp;
+	struct fec_enet_priv_tx_q *txq;
+	int index = 0;
+
+	if (frt->enabled) {
+		return;
+	}
+
+	netdev_info(ndev, "TX ring dump\n");
+	pr_info("Nr     SC     addr       len  SKB\n");
+
+	txq = fep->tx_queue[0];
+	bdp = txq->bd.base;
+
+	do {
+		pr_info("%3u %c%c 0x%04x 0x%08x %4u %p\n",
+			index,
+			bdp == txq->bd.cur ? 'S' : ' ',
+			bdp == txq->dirty_tx ? 'H' : ' ',
+			fec16_to_cpu(bdp->cbd_sc),
+			fec32_to_cpu(bdp->cbd_bufaddr),
+			fec16_to_cpu(bdp->cbd_datlen),
+			txq->tx_skbuff[index]);
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		index++;
+	} while (bdp != txq->bd.base);
+}
+
+static inline bool is_ipv4_pkt(struct sk_buff *skb)
+{
+	return skb->protocol == htons(ETH_P_IP) && ip_hdr(skb)->version == 4;
+}
+
+static int
+fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
+{
+	/* Only run for packets requiring a checksum. */
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	if (unlikely(skb_cow_head(skb, 0)))
+		return -1;
+
+	if (is_ipv4_pkt(skb))
+		ip_hdr(skb)->check = 0;
+	*(__sum16 *)(skb->head + skb->csum_start + skb->csum_offset) = 0;
+
+	return 0;
+}
+
+static struct bufdesc *
+fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
+			     struct sk_buff *skb,
+			     struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bufdesc *bdp = txq->bd.cur;
+	struct bufdesc_ex *ebdp;
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	int frag, frag_len;
+	unsigned short status;
+	unsigned int estatus = 0;
+	skb_frag_t *this_frag;
+	unsigned int index;
+	void *bufaddr;
+	dma_addr_t addr;
+	int i;
+
+	for (frag = 0; frag < nr_frags; frag++) {
+		this_frag = &skb_shinfo(skb)->frags[frag];
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		ebdp = (struct bufdesc_ex *)bdp;
+
+		status = fec16_to_cpu(bdp->cbd_sc);
+		status &= ~BD_ENET_TX_STATS;
+		status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
+		frag_len = skb_frag_size(&skb_shinfo(skb)->frags[frag]);
+
+		/* Handle the last BD specially */
+		if (frag == nr_frags - 1) {
+			status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
+			if (fep->bufdesc_ex) {
+				estatus |= BD_ENET_TX_INT;
+				if (unlikely(skb_shinfo(skb)->tx_flags &
+					SKBTX_HW_TSTAMP && fep->hwts_tx_en))
+					estatus |= BD_ENET_TX_TS;
+			}
+		}
+
+		if (fep->bufdesc_ex) {
+			if (fep->quirks & FEC_QUIRK_HAS_AVB)
+				estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+			if (skb->ip_summed == CHECKSUM_PARTIAL)
+				estatus |= BD_ENET_TX_PINS | BD_ENET_TX_IINS;
+			ebdp->cbd_bdu = 0;
+			ebdp->cbd_esc = cpu_to_fec32(estatus);
+		}
+
+		bufaddr = skb_frag_address(this_frag);
+
+		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		if (((unsigned long) bufaddr) & fep->tx_align ||
+			fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+			memcpy(txq->tx_bounce[index], bufaddr, frag_len);
+			bufaddr = txq->tx_bounce[index];
+
+			if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+				swap_buffer(bufaddr, frag_len);
+		}
+
+		addr = dma_map_single(&fep->pdev->dev, bufaddr, frag_len,
+				      DMA_TO_DEVICE);
+		if (dma_mapping_error(&fep->pdev->dev, addr)) {
+			if (net_ratelimit())
+				netdev_err(ndev, "Tx DMA memory map failed\n");
+			goto dma_mapping_error;
+		}
+
+		bdp->cbd_bufaddr = cpu_to_fec32(addr);
+		bdp->cbd_datlen = cpu_to_fec16(frag_len);
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+	}
+
+	return bdp;
+dma_mapping_error:
+	bdp = txq->bd.cur;
+	for (i = 0; i < frag; i++) {
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		dma_unmap_single(&fep->pdev->dev, fec32_to_cpu(bdp->cbd_bufaddr),
+				 fec16_to_cpu(bdp->cbd_datlen), DMA_TO_DEVICE);
+	}
+	return ERR_PTR(-ENOMEM);
+}
+
+static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
+				   struct sk_buff *skb, struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	struct bufdesc *bdp, *last_bdp;
+	void *bufaddr;
+	dma_addr_t addr;
+	unsigned short status;
+	unsigned short buflen;
+	unsigned int estatus = 0;
+	unsigned int index;
+	int entries_free;
+
+	entries_free = fec_enet_get_free_txdesc_num(txq);
+	if (entries_free < MAX_SKB_FRAGS + 1) {
+		dev_kfree_skb_any(skb);
+		if (net_ratelimit())
+			netdev_err(ndev, "NOT enough BD for SG!\n");
+		return NETDEV_TX_OK;
+	}
+
+	/* Protocol checksum off-load for TCP and UDP. */
+	if (fec_enet_clear_csum(skb, ndev)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = txq->bd.cur;
+	last_bdp = bdp;
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+
+	/* Set buffer length and buffer pointer */
+	bufaddr = skb->data;
+	buflen = skb_headlen(skb);
+
+	index = fec_enet_get_bd_index(bdp, &txq->bd);
+	if (((unsigned long) bufaddr) & fep->tx_align ||
+		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+		memcpy(txq->tx_bounce[index], skb->data, buflen);
+		bufaddr = txq->tx_bounce[index];
+
+		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+			swap_buffer(bufaddr, buflen);
+	}
+
+	/* Push the data cache so the CPM does not get stale memory data. */
+	addr = dma_map_single(&fep->pdev->dev, bufaddr, buflen, DMA_TO_DEVICE);
+	if (dma_mapping_error(&fep->pdev->dev, addr)) {
+		dev_kfree_skb_any(skb);
+		if (net_ratelimit())
+			netdev_err(ndev, "Tx DMA memory map failed\n");
+		return NETDEV_TX_OK;
+	}
+
+	if (nr_frags) {
+		last_bdp = fec_enet_txq_submit_frag_skb(txq, skb, ndev);
+		if (IS_ERR(last_bdp)) {
+			dma_unmap_single(&fep->pdev->dev, addr,
+					 buflen, DMA_TO_DEVICE);
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+	} else {
+		status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
+		if (fep->bufdesc_ex) {
+			estatus = BD_ENET_TX_INT;
+			if (unlikely(skb_shinfo(skb)->tx_flags &
+				SKBTX_HW_TSTAMP && fep->hwts_tx_en))
+				estatus |= BD_ENET_TX_TS;
+		}
+	}
+	bdp->cbd_bufaddr = cpu_to_fec32(addr);
+	bdp->cbd_datlen = cpu_to_fec16(buflen);
+
+	if (fep->bufdesc_ex) {
+
+		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
+			fep->hwts_tx_en))
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+		if (skb->ip_summed == CHECKSUM_PARTIAL)
+			estatus |= BD_ENET_TX_PINS | BD_ENET_TX_IINS;
+
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	index = fec_enet_get_bd_index(last_bdp, &txq->bd);
+	/* Save skb pointer */
+	txq->tx_skbuff[index] = skb;
+
+	/* Make sure the updates to rest of the descriptor are performed before
+	 * transferring ownership.
+	 */
+	wmb();
+
+	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+	 * it's the last BD of the frame, and to put the CRC on the end.
+	 */
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);
+	bdp->cbd_sc = cpu_to_fec16(status);
+
+	/* If this was the last BD in the ring, start at the beginning again. */
+	bdp = fec_enet_get_nextdesc(last_bdp, &txq->bd);
+
+	skb_tx_timestamp(skb);
+
+	/* Make sure the update to bdp and tx_skbuff are performed before
+	 * txq->bd.cur.
+	 */
+	wmb();
+	txq->bd.cur = bdp;
+
+	/* Trigger transmission start */
+	writel(0, txq->bd.reg_desc_active);
+
+	return 0;
+}
+
+static int fec_rt_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
+				 struct rtskb *skb, struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct bufdesc *bdp, *last_bdp;
+	void *bufaddr;
+	dma_addr_t addr;
+	unsigned short status;
+	unsigned short buflen;
+	unsigned int estatus = 0;
+	unsigned int index;
+	int entries_free;
+	rtdm_lockctx_t c;
+
+	entries_free = fec_enet_get_free_txdesc_num(txq);
+	if (entries_free < MAX_SKB_FRAGS + 1) {
+		rtdm_printk_ratelimited("%s: NOT enough BD for SG!\n",
+					dev_name(&fep->pdev->dev));
+		return NETDEV_TX_BUSY;
+	}
+
+	rtdm_lock_get_irqsave(&frt->lock, c);
+
+	if (skb->xmit_stamp)
+		*skb->xmit_stamp =
+			cpu_to_be64(rtdm_clock_read_monotonic() +
+				    *skb->xmit_stamp);
+
+	/* Fill in a Tx ring entry */
+	bdp = txq->bd.cur;
+	last_bdp = bdp;
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+
+	/* Set buffer length and buffer pointer */
+	bufaddr = skb->data;
+	buflen = rtskb_headlen(skb);
+
+	index = fec_enet_get_bd_index(bdp, &txq->bd);
+	if (((unsigned long) bufaddr) & fep->tx_align ||
+		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+		memcpy(txq->tx_bounce[index], skb->data, buflen);
+		bufaddr = txq->tx_bounce[index];
+
+		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+			swap_buffer(bufaddr, buflen);
+	}
+
+	addr = dma_map_single(&fep->pdev->dev, bufaddr, buflen, DMA_TO_DEVICE);
+	if (dma_mapping_error(&fep->pdev->dev, addr)) {
+		rtdm_lock_put_irqrestore(&frt->lock, c);
+		dev_kfree_rtskb(skb);
+		rtdm_printk_ratelimited("%s: Tx DMA memory map failed\n",
+					dev_name(&fep->pdev->dev));
+		return NETDEV_TX_BUSY;
+	}
+	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
+
+	bdp->cbd_bufaddr = cpu_to_fec32(addr);
+	bdp->cbd_datlen = cpu_to_fec16(buflen);
+
+	if (fep->bufdesc_ex) {
+		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+		estatus = BD_ENET_TX_INT;
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	index = fec_enet_get_bd_index(last_bdp, &txq->bd);
+	txq->tx_rtbuff[index] = skb;
+
+	/* Make sure the updates to rest of the descriptor are performed before
+	 * transferring ownership.
+	 */
+	wmb();
+
+	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+	 * it's the last BD of the frame, and to put the CRC on the end.
+	 */
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);
+	bdp->cbd_sc = cpu_to_fec16(status);
+
+	/* If this was the last BD in the ring, start at the beginning again. */
+	bdp = fec_enet_get_nextdesc(last_bdp, &txq->bd);
+
+	/* Make sure the update to bdp and tx_rtbuff are performed
+	 * before txq->bd.cur.
+	 */
+	wmb();
+	txq->bd.cur = bdp;
+
+	/* Trigger transmission start */
+	writel(0, txq->bd.reg_desc_active);
+
+	rtdm_lock_put_irqrestore(&frt->lock, c);
+
+	return 0;
+}
+
+static int
+fec_enet_txq_put_data_tso(struct fec_enet_priv_tx_q *txq, struct sk_buff *skb,
+			  struct net_device *ndev,
+			  struct bufdesc *bdp, int index, char *data,
+			  int size, bool last_tcp, bool is_last)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bufdesc_ex *ebdp = container_of(bdp, struct bufdesc_ex, desc);
+	unsigned short status;
+	unsigned int estatus = 0;
+	dma_addr_t addr;
+
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+
+	status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
+
+	if (((unsigned long) data) & fep->tx_align ||
+		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+		memcpy(txq->tx_bounce[index], data, size);
+		data = txq->tx_bounce[index];
+
+		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+			swap_buffer(data, size);
+	}
+
+	addr = dma_map_single(&fep->pdev->dev, data, size, DMA_TO_DEVICE);
+	if (dma_mapping_error(&fep->pdev->dev, addr)) {
+		dev_kfree_skb_any(skb);
+		if (net_ratelimit())
+			netdev_err(ndev, "Tx DMA memory map failed\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	bdp->cbd_datlen = cpu_to_fec16(size);
+	bdp->cbd_bufaddr = cpu_to_fec32(addr);
+
+	if (fep->bufdesc_ex) {
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+		if (skb->ip_summed == CHECKSUM_PARTIAL)
+			estatus |= BD_ENET_TX_PINS | BD_ENET_TX_IINS;
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	/* Handle the last BD specially */
+	if (last_tcp)
+		status |= (BD_ENET_TX_LAST | BD_ENET_TX_TC);
+	if (is_last) {
+		status |= BD_ENET_TX_INTR;
+		if (fep->bufdesc_ex)
+			ebdp->cbd_esc |= cpu_to_fec32(BD_ENET_TX_INT);
+	}
+
+	bdp->cbd_sc = cpu_to_fec16(status);
+
+	return 0;
+}
+
+static int
+fec_enet_txq_put_hdr_tso(struct fec_enet_priv_tx_q *txq,
+			 struct sk_buff *skb, struct net_device *ndev,
+			 struct bufdesc *bdp, int index)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	struct bufdesc_ex *ebdp = container_of(bdp, struct bufdesc_ex, desc);
+	void *bufaddr;
+	unsigned long dmabuf;
+	unsigned short status;
+	unsigned int estatus = 0;
+
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+	status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
+
+	bufaddr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
+	dmabuf = txq->tso_hdrs_dma + index * TSO_HEADER_SIZE;
+	if (((unsigned long)bufaddr) & fep->tx_align ||
+		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+		memcpy(txq->tx_bounce[index], skb->data, hdr_len);
+		bufaddr = txq->tx_bounce[index];
+
+		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+			swap_buffer(bufaddr, hdr_len);
+
+		dmabuf = dma_map_single(&fep->pdev->dev, bufaddr,
+					hdr_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(&fep->pdev->dev, dmabuf)) {
+			dev_kfree_skb_any(skb);
+			if (net_ratelimit())
+				netdev_err(ndev, "Tx DMA memory map failed\n");
+			return NETDEV_TX_BUSY;
+		}
+	}
+
+	bdp->cbd_bufaddr = cpu_to_fec32(dmabuf);
+	bdp->cbd_datlen = cpu_to_fec16(hdr_len);
+
+	if (fep->bufdesc_ex) {
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+		if (skb->ip_summed == CHECKSUM_PARTIAL)
+			estatus |= BD_ENET_TX_PINS | BD_ENET_TX_IINS;
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	bdp->cbd_sc = cpu_to_fec16(status);
+
+	return 0;
+}
+
+static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
+				   struct sk_buff *skb,
+				   struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	int total_len, data_left;
+	struct bufdesc *bdp = txq->bd.cur;
+	struct tso_t tso;
+	unsigned int index = 0;
+	int ret;
+
+	if (tso_count_descs(skb) >= fec_enet_get_free_txdesc_num(txq)) {
+		dev_kfree_skb_any(skb);
+		if (net_ratelimit())
+			netdev_err(ndev, "NOT enough BD for TSO!\n");
+		return NETDEV_TX_OK;
+	}
+
+	/* Protocol checksum off-load for TCP and UDP. */
+	if (fec_enet_clear_csum(skb, ndev)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Initialize the TSO handler, and prepare the first payload */
+	tso_start(skb, &tso);
+
+	total_len = skb->len - hdr_len;
+	while (total_len > 0) {
+		char *hdr;
+
+		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		data_left = min_t(int, skb_shinfo(skb)->gso_size, total_len);
+		total_len -= data_left;
+
+		/* prepare packet headers: MAC + IP + TCP */
+		hdr = txq->tso_hdrs + index * TSO_HEADER_SIZE;
+		tso_build_hdr(skb, hdr, &tso, data_left, total_len == 0);
+		ret = fec_enet_txq_put_hdr_tso(txq, skb, ndev, bdp, index);
+		if (ret)
+			goto err_release;
+
+		while (data_left > 0) {
+			int size;
+
+			size = min_t(int, tso.size, data_left);
+			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+			index = fec_enet_get_bd_index(bdp, &txq->bd);
+			ret = fec_enet_txq_put_data_tso(txq, skb, ndev,
+							bdp, index,
+							tso.data, size,
+							size == data_left,
+							total_len == 0);
+			if (ret)
+				goto err_release;
+
+			data_left -= size;
+			tso_build_data(skb, &tso, size);
+		}
+
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+	}
+
+	/* Save skb pointer */
+	txq->tx_skbuff[index] = skb;
+
+	skb_tx_timestamp(skb);
+	txq->bd.cur = bdp;
+
+	/* Trigger transmission start */
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
+
+	return 0;
+
+err_release:
+	/* TODO: Release all used data descriptors for TSO */
+	return ret;
+}
+
+static netdev_tx_t
+fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int entries_free;
+	unsigned short queue;
+	struct fec_enet_priv_tx_q *txq;
+	struct netdev_queue *nq;
+	int ret;
+
+	if (WARN_ON_ONCE(fep->rtnet.enabled)){
+		return -EBUSY;
+	}
+
+	queue = skb_get_queue_mapping(skb);
+	txq = fep->tx_queue[queue];
+	nq = netdev_get_tx_queue(ndev, queue);
+
+	if (skb_is_gso(skb))
+		ret = fec_enet_txq_submit_tso(txq, skb, ndev);
+	else
+		ret = fec_enet_txq_submit_skb(txq, skb, ndev);
+	if (ret)
+		return ret;
+
+	entries_free = fec_enet_get_free_txdesc_num(txq);
+	if (entries_free <= txq->tx_stop_threshold)
+		netif_tx_stop_queue(nq);
+
+	return NETDEV_TX_OK;
+}
+
+static netdev_tx_t
+fec_rt_start_xmit(struct rtskb *skb, struct rtnet_device *rtdev)
+{
+	struct fec_enet_priv_tx_q *txq;
+	struct fec_enet_private *fep;
+
+	fep = container_of(rtdev, struct fec_enet_private, rtnet.dev);
+	txq = fep->tx_queue[0];
+
+	return fec_rt_txq_submit_skb(txq, skb, fep->netdev);
+}
+
+static struct net_device_stats *fec_rt_stats(struct rtnet_device *rtdev)
+{
+	struct fec_enet_private *fep;
+
+	fep = container_of(rtdev, struct fec_enet_private, rtnet.dev);
+	return &fep->netdev->stats;
+}
+
+/* Init RX & TX buffer descriptors
+ */
+static void fec_enet_bd_init(struct net_device *dev)
+{
+	struct fec_enet_private *fep = netdev_priv(dev);
+	struct fec_enet_priv_tx_q *txq;
+	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp;
+	unsigned int i;
+	unsigned int q;
+
+	for (q = 0; q < fep->num_rx_queues; q++) {
+		/* Initialize the receive buffer descriptors. */
+		rxq = fep->rx_queue[q];
+		bdp = rxq->bd.base;
+
+		for (i = 0; i < rxq->bd.ring_size; i++) {
+
+			/* Initialize the BD for every fragment in the page. */
+			if (bdp->cbd_bufaddr)
+				bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
+			else
+				bdp->cbd_sc = cpu_to_fec16(0);
+			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+		}
+
+		/* Set the last buffer to wrap */
+		bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
+		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+
+		rxq->bd.cur = rxq->bd.base;
+	}
+
+	for (q = 0; q < fep->num_tx_queues; q++) {
+		/* ...and the same for transmit */
+		txq = fep->tx_queue[q];
+		bdp = txq->bd.base;
+		txq->bd.cur = bdp;
+
+		for (i = 0; i < txq->bd.ring_size; i++) {
+			/* Initialize the BD for every fragment in the page. */
+			bdp->cbd_sc = cpu_to_fec16(0);
+			if (bdp->cbd_bufaddr &&
+			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
+			if (fep->rtnet.enabled) {
+				if (txq->tx_rtbuff[i]) {
+					dev_kfree_rtskb(txq->tx_rtbuff[i]);
+					txq->tx_rtbuff[i] = NULL;
+				}
+			} else {
+				if (txq->tx_skbuff[i]) {
+					dev_kfree_skb_any(txq->tx_skbuff[i]);
+					txq->tx_skbuff[i] = NULL;
+				}
+			}
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		}
+
+		/* Set the last buffer to wrap */
+		bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
+		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+		txq->dirty_tx = bdp;
+	}
+}
+
+static void fec_enet_active_rxring(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int i;
+
+	for (i = 0; i < fep->num_rx_queues; i++)
+		writel(0, fep->rx_queue[i]->bd.reg_desc_active);
+}
+
+static void fec_enet_enable_ring(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_tx_q *txq;
+	struct fec_enet_priv_rx_q *rxq;
+	int i;
+
+	for (i = 0; i < fep->num_rx_queues; i++) {
+		rxq = fep->rx_queue[i];
+		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
+		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
+
+		/* enable DMA1/2 */
+		if (i)
+			writel(RCMR_MATCHEN | RCMR_CMP(i),
+			       fep->hwp + FEC_RCMR(i));
+	}
+
+	for (i = 0; i < fep->num_tx_queues; i++) {
+		txq = fep->tx_queue[i];
+		writel(txq->bd.dma, fep->hwp + FEC_X_DES_START(i));
+
+		/* enable DMA1/2 */
+		if (i)
+			writel(DMA_CLASS_EN | IDLE_SLOPE(i),
+			       fep->hwp + FEC_DMA_CFG(i));
+	}
+}
+
+static void fec_enet_reset_skb(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_tx_q *txq;
+	int i, j;
+
+	for (i = 0; i < fep->num_tx_queues; i++) {
+		txq = fep->tx_queue[i];
+
+		for (j = 0; j < txq->bd.ring_size; j++) {
+			if (fep->rtnet.enabled) {
+				if (txq->tx_rtbuff[j]) {
+					dev_kfree_rtskb(txq->tx_rtbuff[j]);
+					txq->tx_rtbuff[j] = NULL;
+				}
+			} else {
+				if (txq->tx_skbuff[j]) {
+					dev_kfree_skb_any(txq->tx_skbuff[j]);
+					txq->tx_skbuff[j] = NULL;
+				}
+			}
+		}
+	}
+}
+
+/*
+ * This function is called to start or restart the FEC during a link
+ * change, transmit timeout, or to reconfigure the FEC.  The network
+ * packet processing for this device must be stopped before this call.
+ */
+static void
+fec_restart(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	u32 val;
+	u32 temp_mac[2];
+	u32 rcntl = OPT_FRAME_SIZE | 0x04;
+	u32 ecntl = FEC_ENET_ETHEREN; /* ETHEREN */
+
+	/* Whack a reset.  We should wait for this.
+	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
+	 * instead of reset MAC itself.
+	 */
+	if (fep->quirks & FEC_QUIRK_HAS_AVB) {
+		writel(0, fep->hwp + FEC_ECNTRL);
+	} else {
+		writel(1, fep->hwp + FEC_ECNTRL);
+		udelay(10);
+	}
+
+	/*
+	 * enet-mac reset will reset mac address registers too,
+	 * so need to reconfigure it.
+	 */
+	memcpy(&temp_mac, ndev->dev_addr, ETH_ALEN);
+	writel((__force u32)cpu_to_be32(temp_mac[0]),
+	       fep->hwp + FEC_ADDR_LOW);
+	writel((__force u32)cpu_to_be32(temp_mac[1]),
+	       fep->hwp + FEC_ADDR_HIGH);
+
+	/* Clear any outstanding interrupt. */
+	writel(0xffffffff, fep->hwp + FEC_IEVENT);
+
+	fec_enet_bd_init(ndev);
+
+	fec_enet_enable_ring(ndev);
+
+	/* Reset tx SKB buffers. */
+	fec_enet_reset_skb(ndev);
+
+	/* Enable MII mode */
+	if (fep->full_duplex == DUPLEX_FULL) {
+		/* FD enable */
+		writel(0x04, fep->hwp + FEC_X_CNTRL);
+	} else {
+		/* No Rcv on Xmit */
+		rcntl |= 0x02;
+		writel(0x0, fep->hwp + FEC_X_CNTRL);
+	}
+
+	/* Set MII speed */
+	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+
+#if !defined(CONFIG_M5272)
+	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
+		val = readl(fep->hwp + FEC_RACC);
+		/* align IP header */
+		val |= FEC_RACC_SHIFT16;
+		if (fep->csum_flags & FLAG_RX_CSUM_ENABLED)
+			/* set RX checksum */
+			val |= FEC_RACC_OPTIONS;
+		else
+			val &= ~FEC_RACC_OPTIONS;
+		writel(val, fep->hwp + FEC_RACC);
+		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_FTRL);
+	}
+#endif
+
+	/*
+	 * The phy interface and speed need to get configured
+	 * differently on enet-mac.
+	 */
+	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
+		/* Enable flow control and length check */
+		rcntl |= 0x40000000 | 0x00000020;
+
+		/* RGMII, RMII or MII */
+		if (fep->phy_interface == PHY_INTERFACE_MODE_RGMII ||
+		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
+		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID ||
+		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
+			rcntl |= (1 << 6);
+		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
+			rcntl |= (1 << 8);
+		else
+			rcntl &= ~(1 << 8);
+
+		/* 1G, 100M or 10M */
+		if (ndev->phydev) {
+			if (ndev->phydev->speed == SPEED_1000)
+				ecntl |= (1 << 5);
+			else if (ndev->phydev->speed == SPEED_100)
+				rcntl &= ~(1 << 9);
+			else
+				rcntl |= (1 << 9);
+		}
+	} else {
+#ifdef FEC_MIIGSK_ENR
+		if (fep->quirks & FEC_QUIRK_USE_GASKET) {
+			u32 cfgr;
+			/* disable the gasket and wait */
+			writel(0, fep->hwp + FEC_MIIGSK_ENR);
+			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
+				udelay(1);
+
+			/*
+			 * configure the gasket:
+			 *   RMII, 50 MHz, no loopback, no echo
+			 *   MII, 25 MHz, no loopback, no echo
+			 */
+			cfgr = (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
+				? BM_MIIGSK_CFGR_RMII : BM_MIIGSK_CFGR_MII;
+			if (ndev->phydev && ndev->phydev->speed == SPEED_10)
+				cfgr |= BM_MIIGSK_CFGR_FRCONT_10M;
+			writel(cfgr, fep->hwp + FEC_MIIGSK_CFGR);
+
+			/* re-enable the gasket */
+			writel(2, fep->hwp + FEC_MIIGSK_ENR);
+		}
+#endif
+	}
+
+#if !defined(CONFIG_M5272)
+	/* enable pause frame*/
+	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
+	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
+	     ndev->phydev && ndev->phydev->pause)) {
+		rcntl |= FEC_ENET_FCE;
+
+		/* set FIFO threshold parameter to reduce overrun */
+		writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
+		writel(FEC_ENET_RSFL_V, fep->hwp + FEC_R_FIFO_RSFL);
+		writel(FEC_ENET_RAEM_V, fep->hwp + FEC_R_FIFO_RAEM);
+		writel(FEC_ENET_RAFL_V, fep->hwp + FEC_R_FIFO_RAFL);
+
+		/* OPD */
+		writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
+	} else {
+		rcntl &= ~FEC_ENET_FCE;
+	}
+#endif /* !defined(CONFIG_M5272) */
+
+	writel(rcntl, fep->hwp + FEC_R_CNTRL);
+
+	/* Setup multicast filter. */
+	set_multicast_list(ndev);
+#ifndef CONFIG_M5272
+	writel(0, fep->hwp + FEC_HASH_TABLE_HIGH);
+	writel(0, fep->hwp + FEC_HASH_TABLE_LOW);
+#endif
+
+	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
+		/* enable ENET endian swap */
+		ecntl |= (1 << 8);
+		/* enable ENET store and forward mode */
+		writel(1 << 8, fep->hwp + FEC_X_WMRK);
+	}
+
+	if (fep->bufdesc_ex)
+		ecntl |= (1 << 4);
+
+	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
+		fep->rgmii_txc_dly)
+		ecntl |= FEC_ENET_TXC_DLY;
+	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
+		fep->rgmii_rxc_dly)
+		ecntl |= FEC_ENET_RXC_DLY;
+
+#ifndef CONFIG_M5272
+	/* Enable the MIB statistic event counters */
+	writel(0 << 31, fep->hwp + FEC_MIB_CTRLSTAT);
+#endif
+
+	/* And last, enable the transmit and receive processing */
+	writel(ecntl, fep->hwp + FEC_ECNTRL);
+	fec_enet_active_rxring(ndev);
+
+	if (fep->bufdesc_ex)
+		fec_ptp_start_cyclecounter(ndev);
+
+	/* Enable interrupts we wish to service */
+	if (fep->link)
+		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+	else
+		writel(FEC_ENET_MII, fep->hwp + FEC_IMASK);
+
+	/* Init the interrupt coalescing */
+	fec_enet_itr_coal_init(ndev);
+
+}
+
+#ifdef CONFIG_IMX_SCU_SOC
+static int fec_enet_ipc_handle_init(struct fec_enet_private *fep)
+{
+	if (!(of_machine_is_compatible("fsl,imx8qm") ||
+	    of_machine_is_compatible("fsl,imx8qxp") ||
+	    of_machine_is_compatible("fsl,imx8dxl")))
+		return 0;
+
+	return imx_scu_get_handle(&fep->ipc_handle);
+}
+
+static void fec_enet_ipg_stop_set(struct fec_enet_private *fep, bool enabled)
+{
+	struct device_node *np = fep->pdev->dev.of_node;
+	u32 rsrc_id, val;
+	int idx;
+
+	if (!np || !fep->ipc_handle)
+		return;
+
+	idx = of_alias_get_id(np, "ethernet");
+	if (idx < 0)
+		idx = 0;
+	rsrc_id = idx ? IMX_SC_R_ENET_1 : IMX_SC_R_ENET_0;
+
+	val = enabled ? 1 : 0;
+	imx_sc_misc_set_control(fep->ipc_handle, rsrc_id, IMX_SC_C_IPG_STOP, val);
+}
+#else
+static int fec_enet_ipc_handle_init(struct fec_enet_private *fep)
+{
+	return 0;
+}
+
+static void fec_enet_ipg_stop_set(struct fec_enet_private *fep, bool enabled) {}
+#endif
+
+static void fec_enet_enter_stop_mode(struct fec_enet_private *fep)
+{
+	struct fec_platform_data *pdata = fep->pdev->dev.platform_data;
+
+	if (!IS_ERR_OR_NULL(fep->lpm.gpr))
+		regmap_update_bits(fep->lpm.gpr, fep->lpm.req_gpr,
+				   1 << fep->lpm.req_bit,
+				   1 << fep->lpm.req_bit);
+	else if (pdata && pdata->sleep_mode_enable)
+		pdata->sleep_mode_enable(true);
+	else
+		fec_enet_ipg_stop_set(fep, true);
+}
+
+static void fec_enet_exit_stop_mode(struct fec_enet_private *fep)
+{
+	struct fec_platform_data *pdata = fep->pdev->dev.platform_data;
+
+	if (!IS_ERR_OR_NULL(fep->lpm.gpr))
+		regmap_update_bits(fep->lpm.gpr, fep->lpm.req_gpr,
+				   1 << fep->lpm.req_bit, 0);
+	else if (pdata && pdata->sleep_mode_enable)
+		pdata->sleep_mode_enable(false);
+	else
+		fec_enet_ipg_stop_set(fep, false);
+}
+
+static inline void fec_irqs_disable(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	writel(0, fep->hwp + FEC_IMASK);
+}
+
+static void
+fec_stop(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 val;
+
+	/* We cannot expect a graceful transmit stop without link !!! */
+	if (fep->link) {
+		writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
+		udelay(10);
+		if (!(readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
+			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
+	}
+
+	/* Whack a reset.  We should wait for this.
+	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
+	 * instead of reset MAC itself.
+	 */
+	if (!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
+		if (fep->quirks & FEC_QUIRK_HAS_AVB) {
+			writel(0, fep->hwp + FEC_ECNTRL);
+		} else {
+			writel(1, fep->hwp + FEC_ECNTRL);
+			udelay(10);
+		}
+		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+	} else {
+		writel(FEC_DEFAULT_IMASK | FEC_ENET_WAKEUP, fep->hwp + FEC_IMASK);
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
+	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+
+	/* We have to keep ENET enabled to have MII interrupt stay working */
+	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
+		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
+		writel(2, fep->hwp + FEC_ECNTRL);
+		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
+	}
+}
+
+
+static void
+fec_timeout(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	fec_dump(ndev);
+
+	ndev->stats.tx_errors++;
+
+	schedule_work(&fep->tx_timeout_work);
+}
+
+static void fec_enet_timeout_work(struct work_struct *work)
+{
+	struct fec_enet_private *fep =
+		container_of(work, struct fec_enet_private, tx_timeout_work);
+	struct net_device *ndev = fep->netdev;
+
+	rtnl_lock();
+	if (netif_device_present(ndev) || if_running(ndev)) {
+		if_lock(ndev);
+		fec_restart(ndev);
+		if_wake_unlock(ndev, true);
+	}
+	rtnl_unlock();
+}
+
+static void
+fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
+	struct skb_shared_hwtstamps *hwtstamps)
+{
+	unsigned long flags;
+	u64 ns;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	ns = timecounter_cyc2time(&fep->tc, ts);
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+
+	memset(hwtstamps, 0, sizeof(*hwtstamps));
+	hwtstamps->hwtstamp = ns_to_ktime(ns);
+}
+
+static void
+fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
+{
+	struct	fec_enet_private *fep;
+	struct bufdesc *bdp;
+	unsigned short status;
+	struct	sk_buff	*skb;
+	struct fec_enet_priv_tx_q *txq;
+	struct netdev_queue *nq;
+	int	index = 0;
+	int	entries_free;
+
+	fep = netdev_priv(ndev);
+
+	queue_id = FEC_ENET_GET_QUQUE(queue_id);
+
+	txq = fep->tx_queue[queue_id];
+	/* get next bdp of dirty_tx */
+	nq = netdev_get_tx_queue(ndev, queue_id);
+	bdp = txq->dirty_tx;
+
+	/* get next bdp of dirty_tx */
+	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+
+	while (bdp != READ_ONCE(txq->bd.cur)) {
+		/* Order the load of bd.cur and cbd_sc */
+		rmb();
+		status = fec16_to_cpu(READ_ONCE(bdp->cbd_sc));
+		if (status & BD_ENET_TX_READY)
+			break;
+
+		index = fec_enet_get_bd_index(bdp, &txq->bd);
+
+		skb = txq->tx_skbuff[index];
+		txq->tx_skbuff[index] = NULL;
+		if (!IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 fec16_to_cpu(bdp->cbd_datlen),
+					 DMA_TO_DEVICE);
+		bdp->cbd_bufaddr = cpu_to_fec32(0);
+		if (!skb)
+			goto skb_done;
+
+		/* Check for errors. */
+		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
+				   BD_ENET_TX_RL | BD_ENET_TX_UN |
+				   BD_ENET_TX_CSL)) {
+			ndev->stats.tx_errors++;
+			if (status & BD_ENET_TX_HB)  /* No heartbeat */
+				ndev->stats.tx_heartbeat_errors++;
+			if (status & BD_ENET_TX_LC)  /* Late collision */
+				ndev->stats.tx_window_errors++;
+			if (status & BD_ENET_TX_RL)  /* Retrans limit */
+				ndev->stats.tx_aborted_errors++;
+			if (status & BD_ENET_TX_UN)  /* Underrun */
+				ndev->stats.tx_fifo_errors++;
+			if (status & BD_ENET_TX_CSL) /* Carrier lost */
+				ndev->stats.tx_carrier_errors++;
+		} else {
+			ndev->stats.tx_packets++;
+			ndev->stats.tx_bytes += skb->len;
+		}
+
+		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) &&
+			fep->bufdesc_ex) {
+			struct skb_shared_hwtstamps shhwtstamps;
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+			skb_tstamp_tx(skb, &shhwtstamps);
+		}
+
+		/* Deferred means some collisions occurred during transmit,
+		 * but we eventually sent the packet OK.
+		 */
+		if (status & BD_ENET_TX_DEF)
+			ndev->stats.collisions++;
+
+		/* Free the sk buffer associated with this last transmit */
+		dev_kfree_skb_any(skb);
+skb_done:
+		/* Make sure the update to bdp and tx_skbuff are performed
+		 * before dirty_tx
+		 */
+		wmb();
+		txq->dirty_tx = bdp;
+
+		/* Update pointer to next buffer descriptor to be transmitted */
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+
+		/* Since we have freed up a buffer, the ring is no longer full
+		 */
+		if (netif_tx_queue_stopped(nq)) {
+			entries_free = fec_enet_get_free_txdesc_num(txq);
+			if (entries_free >= txq->tx_wake_threshold)
+				netif_tx_wake_queue(nq);
+		}
+	}
+
+	/* ERR006358: Keep the transmitter going */
+	if (bdp != txq->bd.cur &&
+	    readl(txq->bd.reg_desc_active) == 0)
+		writel(0, txq->bd.reg_desc_active);
+}
+
+static void
+fec_rt_tx_queue(struct net_device *ndev, u16 queue_id)
+{
+	struct	fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct bufdesc *bdp;
+	unsigned short status;
+	struct	rtskb	*skb;
+	struct fec_enet_priv_tx_q *txq;
+	int	index = 0;
+	int	entries_free;
+
+	queue_id = FEC_ENET_GET_QUQUE(queue_id);
+
+	txq = fep->tx_queue[queue_id];
+
+	rtdm_lock_get(&frt->lock);
+
+	/* get next bdp of dirty_tx */
+	bdp = txq->dirty_tx;
+
+	/* get next bdp of dirty_tx */
+	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+
+	while (bdp != READ_ONCE(txq->bd.cur)) {
+		/* Order the load of bd.cur and cbd_sc */
+		rmb();
+		status = fec16_to_cpu(READ_ONCE(bdp->cbd_sc));
+		if (status & BD_ENET_TX_READY)
+			break;
+
+		index = fec_enet_get_bd_index(bdp, &txq->bd);
+
+		skb = txq->tx_rtbuff[index];
+		txq->tx_rtbuff[index] = NULL;
+		dma_unmap_single(&fep->pdev->dev,
+				 fec32_to_cpu(bdp->cbd_bufaddr),
+				 fec16_to_cpu(bdp->cbd_datlen),
+				 DMA_TO_DEVICE);
+	
+		bdp->cbd_bufaddr = cpu_to_fec32(0);
+		if (!skb)
+			goto skb_done;
+
+		/* Check for errors. */
+		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
+				   BD_ENET_TX_RL | BD_ENET_TX_UN |
+				   BD_ENET_TX_CSL)) {
+			ndev->stats.tx_errors++;
+			if (status & BD_ENET_TX_HB)  /* No heartbeat */
+				ndev->stats.tx_heartbeat_errors++;
+			if (status & BD_ENET_TX_LC)  /* Late collision */
+				ndev->stats.tx_window_errors++;
+			if (status & BD_ENET_TX_RL)  /* Retrans limit */
+				ndev->stats.tx_aborted_errors++;
+			if (status & BD_ENET_TX_UN)  /* Underrun */
+				ndev->stats.tx_fifo_errors++;
+			if (status & BD_ENET_TX_CSL) /* Carrier lost */
+				ndev->stats.tx_carrier_errors++;
+		} else {
+			ndev->stats.tx_packets++;
+			ndev->stats.tx_bytes += skb->len;
+		}
+
+		/* Deferred means some collisions occurred during transmit,
+		 * but we eventually sent the packet OK.
+		 */
+		if (status & BD_ENET_TX_DEF)
+			ndev->stats.collisions++;
+
+		dev_kfree_rtskb(skb);
+skb_done:
+		/* Make sure the update to bdp and tx_rtbuff are performed
+		 * before dirty_tx
+		 */
+		wmb();
+		txq->dirty_tx = bdp;
+
+		/* Update pointer to next buffer descriptor to be transmitted */
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+
+		/* Since we have freed up a buffer, the ring is no longer full
+		 */
+		if (rtnetif_queue_stopped(&frt->dev)){
+			entries_free = fec_enet_get_free_txdesc_num(txq);
+			if (entries_free >= txq->tx_wake_threshold){
+				rtnetif_wake_queue(&frt->dev);
+			}
+		}
+	}
+
+	/* ERR006358: Keep the transmitter going */
+	if (bdp != txq->bd.cur &&
+	    readl(txq->bd.reg_desc_active) == 0)
+		writel(0, txq->bd.reg_desc_active);
+
+	rtdm_lock_put(&frt->lock);
+}
+
+static void
+fec_enet_tx(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	u16 queue_id;
+
+	/* First process class A queue, then Class B and Best Effort queue */
+	for_each_set_bit(queue_id, &fep->work_tx, FEC_ENET_MAX_TX_QS) {
+		clear_bit(queue_id, &fep->work_tx);
+		if (frt->enabled)
+			fec_rt_tx_queue(ndev, queue_id);
+		else
+			fec_enet_tx_queue(ndev, queue_id);
+	}
+	return;
+}
+
+static int
+fec_enet_new_rxbdp(struct net_device *ndev, struct bufdesc *bdp, struct sk_buff *skb)
+{
+	struct  fec_enet_private *fep = netdev_priv(ndev);
+	int off;
+
+	off = ((unsigned long)skb->data) & fep->rx_align;
+	if (off)
+		skb_reserve(skb, fep->rx_align + 1 - off);
+
+	bdp->cbd_bufaddr = cpu_to_fec32(dma_map_single(&fep->pdev->dev, skb->data, FEC_ENET_RX_FRSIZE - fep->rx_align, DMA_FROM_DEVICE));
+	if (dma_mapping_error(&fep->pdev->dev, fec32_to_cpu(bdp->cbd_bufaddr))) {
+		if (net_ratelimit())
+			netdev_err(ndev, "Rx DMA memory map failed\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int
+fec_rt_new_rxbdp(struct net_device *ndev, struct bufdesc *bdp, struct rtskb *skb)
+{
+	struct  fec_enet_private *fep = netdev_priv(ndev);
+	int off;
+
+	off = ((unsigned long)skb->data) & fep->rx_align;
+	if (off)
+		rtskb_reserve(skb, fep->rx_align + 1 - off);
+
+	bdp->cbd_bufaddr = cpu_to_fec32(dma_map_single(&fep->pdev->dev, skb->data,
+					       FEC_ENET_RX_FRSIZE - fep->rx_align,
+					       DMA_FROM_DEVICE));
+	if (dma_mapping_error(&fep->pdev->dev, fec32_to_cpu(bdp->cbd_bufaddr))) {
+		rtdm_printk_ratelimited("%s: Rx DMA memory map failed\n",
+					dev_name(&fep->pdev->dev));
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static bool fec_enet_copybreak(struct net_device *ndev, struct sk_buff **skb,
+			       struct bufdesc *bdp, u32 length, bool swap)
+{
+	struct  fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct sk_buff *new_skb;
+
+	if (length > fep->rx_copybreak || frt->enabled){
+		return false;
+	}
+
+	new_skb = netdev_alloc_skb(ndev, length);
+	if (!new_skb)
+		return false;
+
+	dma_sync_single_for_cpu(&fep->pdev->dev,
+				fec32_to_cpu(bdp->cbd_bufaddr),
+				FEC_ENET_RX_FRSIZE - fep->rx_align,
+				DMA_FROM_DEVICE);
+	if (!swap)
+		memcpy(new_skb->data, (*skb)->data, length);
+	else
+		swap_buffer2(new_skb->data, (*skb)->data, length);
+	*skb = new_skb;
+
+	return true;
+}
+
+/* During a receive, the bd_rx.cur points to the current incoming buffer.
+ * When we update through the ring, if the next incoming buffer has
+ * not been given to the system, we just set the empty indicator,
+ * effectively tossing the packet.
+ */
+static int
+fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp;
+	unsigned short status;
+	struct  sk_buff *skb_new = NULL;
+	struct  sk_buff *skb;
+	ushort	pkt_len;
+	__u8 *data;
+	int	pkt_received = 0;
+	struct	bufdesc_ex *ebdp = NULL;
+	bool	vlan_packet_rcvd = false;
+	u16	vlan_tag;
+	int	index = 0;
+	bool	is_copybreak;
+	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+
+#ifdef CONFIG_M532x
+	flush_cache_all();
+#endif
+	queue_id = FEC_ENET_GET_QUQUE(queue_id);
+	rxq = fep->rx_queue[queue_id];
+
+	/* First, grab all of the stats for the incoming packet.
+	 * These get messed up if we get called due to a busy condition.
+	 */
+	bdp = rxq->bd.cur;
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+			   BD_ENET_RX_CL)) {
+			ndev->stats.rx_errors++;
+			if (status & BD_ENET_RX_OV) {
+				/* FIFO overrun */
+				ndev->stats.rx_fifo_errors++;
+				goto rx_processing_done;
+			}
+			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
+						| BD_ENET_RX_LAST)) {
+				/* Frame too long or too short. */
+				ndev->stats.rx_length_errors++;
+				if (status & BD_ENET_RX_LAST)
+					netdev_err(ndev, "rcv is not +last\n");
+			}
+			if (status & BD_ENET_RX_CR)	/* CRC Error */
+				ndev->stats.rx_crc_errors++;
+			/* Report late collisions as a frame error. */
+			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+				ndev->stats.rx_frame_errors++;
+			goto rx_processing_done;
+		}
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		skb = rxq->rx_skbuff[index];
+
+		/* The packet length includes FCS, but we don't want to
+		 * include that when passing upstream as it messes up
+		 * bridging applications.
+		 */
+		is_copybreak = fec_enet_copybreak(ndev, &skb, bdp, pkt_len - 4,
+						  need_swap);
+		if (!is_copybreak) {
+			skb_new = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
+			if (unlikely(!skb_new)) {
+				ndev->stats.rx_dropped++;
+				goto rx_processing_done;
+			}
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 FEC_ENET_RX_FRSIZE - fep->rx_align,
+					 DMA_FROM_DEVICE);
+		}
+
+		prefetch(skb->data - NET_IP_ALIGN);
+		skb_put(skb, pkt_len - 4);
+		data = skb->data;
+
+		if (!is_copybreak && need_swap)
+			swap_buffer(data, pkt_len);
+
+#if !defined(CONFIG_M5272)
+		if (fep->quirks & FEC_QUIRK_HAS_RACC)
+			data = skb_pull_inline(skb, 2);
+#endif
+
+		/* Extract the enhanced buffer descriptor */
+		ebdp = NULL;
+		if (fep->bufdesc_ex)
+			ebdp = (struct bufdesc_ex *)bdp;
+
+		/* If this is a VLAN packet remove the VLAN Tag */
+		vlan_packet_rcvd = false;
+		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+		    fep->bufdesc_ex &&
+		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
+			/* Push and remove the vlan tag */
+			struct vlan_hdr *vlan_header =
+					(struct vlan_hdr *) (data + ETH_HLEN);
+			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
+
+			vlan_packet_rcvd = true;
+
+			memmove(skb->data + VLAN_HLEN, data, ETH_ALEN * 2);
+			skb_pull(skb, VLAN_HLEN);
+		}
+
+		skb->protocol = eth_type_trans(skb, ndev);
+
+		/* Get receive timestamp from the skb */
+		if (fep->hwts_rx_en && fep->bufdesc_ex)
+			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts),
+					  skb_hwtstamps(skb));
+
+		if (fep->bufdesc_ex &&
+		    (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
+			if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR))) {
+				/* don't check it */
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			} else {
+				skb_checksum_none_assert(skb);
+			}
+		}
+
+		/* Handle received VLAN packets */
+		if (vlan_packet_rcvd)
+			__vlan_hwaccel_put_tag(skb,
+					       htons(ETH_P_8021Q),
+					       vlan_tag);
+
+		napi_gro_receive(&fep->napi, skb);
+
+		if (is_copybreak) {
+			dma_sync_single_for_device(&fep->pdev->dev,
+						   fec32_to_cpu(bdp->cbd_bufaddr),
+						   FEC_ENET_RX_FRSIZE - fep->rx_align,
+						   DMA_FROM_DEVICE);
+		} else {
+			rxq->rx_skbuff[index] = skb_new;
+			fec_enet_new_rxbdp(ndev, bdp, skb_new);
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames.  On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+	rxq->bd.cur = bdp;
+	return pkt_received;
+}
+
+static int
+fec_rt_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp;
+	unsigned short status;
+	struct  rtskb *skb_new, *skb;
+	ushort	pkt_len;
+	__u8 *data;
+	int	pkt_received = 0;
+	struct	bufdesc_ex *ebdp = NULL;
+	int	index = 0;
+	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+
+#ifdef CONFIG_M532x
+	flush_cache_all();
+#endif
+	queue_id = FEC_ENET_GET_QUQUE(queue_id);
+	rxq = fep->rx_queue[queue_id];
+
+	rtdm_lock_get(&frt->lock);
+
+	/* First, grab all of the stats for the incoming packet.
+	 * These get messed up if we get called due to a busy condition.
+	 */
+	bdp = rxq->bd.cur;
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+			   BD_ENET_RX_CL)) {
+			ndev->stats.rx_errors++;
+			if (status & BD_ENET_RX_OV) {
+				/* FIFO overrun */
+				ndev->stats.rx_fifo_errors++;
+				goto rx_processing_done;
+			}
+			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
+						| BD_ENET_RX_LAST)) {
+				/* Frame too long or too short. */
+				ndev->stats.rx_length_errors++;
+				/*if (status & BD_ENET_RX_LAST)
+					netdev_err(ndev, "rcv is not +last\n");*/
+			}
+			if (status & BD_ENET_RX_CR)	/* CRC Error */
+				ndev->stats.rx_crc_errors++;
+			/* Report late collisions as a frame error. */
+			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+				ndev->stats.rx_frame_errors++;
+			goto rx_processing_done;
+		}
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		skb = rxq->rx_rtbuff[index];
+		if (unlikely(!skb)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_unmap_single(&fep->pdev->dev,
+				 fec32_to_cpu(bdp->cbd_bufaddr),
+				 FEC_ENET_RX_FRSIZE - fep->rx_align,
+				 DMA_FROM_DEVICE);
+	
+		prefetch(skb->data - NET_IP_ALIGN);
+		rtskb_put(skb, pkt_len - 4);
+		data = skb->data;
+
+		if (need_swap)
+			swap_buffer(data, pkt_len);
+
+#if !defined(CONFIG_M5272)
+		if (fep->quirks & FEC_QUIRK_HAS_RACC)
+			data = rtskb_pull(skb, 2);
+#endif
+
+		skb->protocol = rt_eth_type_trans(skb, &frt->dev);
+
+		/* Extract the enhanced buffer descriptor */
+		if (fep->bufdesc_ex) {
+			ebdp = (struct bufdesc_ex *)bdp;
+			if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
+				if (!(ebdp->cbd_esc & cpu_to_fec32(FLAG_RX_CSUM_ERROR)))
+					skb->ip_summed = CHECKSUM_UNNECESSARY;
+				else
+					WARN_ON_ONCE(skb->ip_summed != CHECKSUM_NONE);
+			}
+		}
+
+		skb_new = rtnetdev_alloc_rtskb(&frt->dev, FEC_ENET_RX_FRSIZE);
+		if (unlikely(skb_new == NULL))
+		{
+			ndev->stats.rx_dropped++;
+			WARN_ON_ONCE(skb_new == NULL);
+		}
+		else {
+			rtnetif_rx(skb);
+			rxq->rx_rtbuff[index] = skb_new;
+			fec_rt_new_rxbdp(ndev, bdp, skb_new);
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			ebdp = (struct bufdesc_ex *)bdp;
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames.  On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+	rxq->bd.cur = bdp;
+
+	rtdm_lock_put(&frt->lock);
+
+	if (pkt_received)
+		rt_mark_stack_mgr(&frt->dev);
+
+	return pkt_received;
+}
+
+static int
+fec_enet_rx(struct net_device *ndev, int budget)
+{
+	int     pkt_received = 0;
+	u16	queue_id;
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	for_each_set_bit(queue_id, &fep->work_rx, FEC_ENET_MAX_RX_QS) {
+		int ret;
+	    if (frt->enabled)
+			ret = fec_rt_rx_queue(ndev,
+					budget - pkt_received, queue_id);
+		else
+			ret = fec_enet_rx_queue(ndev,
+					budget - pkt_received, queue_id);
+
+		if (ret < budget - pkt_received)
+			clear_bit(queue_id, &fep->work_rx);
+
+		pkt_received += ret;
+	}
+	return pkt_received;
+}
+
+static bool
+fec_enet_collect_events(struct fec_enet_private *fep, uint int_events)
+{
+	if (int_events == 0)
+		return false;
+
+	if (int_events & FEC_ENET_RXF_0)
+		fep->work_rx |= (1 << 2);
+	if (int_events & FEC_ENET_RXF_1)
+		fep->work_rx |= (1 << 0);
+	if (int_events & FEC_ENET_RXF_2)
+		fep->work_rx |= (1 << 1);
+
+	if (int_events & FEC_ENET_TXF_0)
+		fep->work_tx |= (1 << 2);
+	if (int_events & FEC_ENET_TXF_1)
+		fep->work_tx |= (1 << 0);
+	if (int_events & FEC_ENET_TXF_2)
+		fep->work_tx |= (1 << 1);
+
+	return true;
+}
+
+static void fec_enet_mdio_done(rtdm_nrtsig_t *nrt_sig, void *data)
+{
+	struct fec_enet_private *fep = data;
+
+	complete(&fep->mdio_done);
+}
+
+static irqreturn_t
+fec_enet_interrupt(int irq, void *dev_id)
+{
+	struct net_device *ndev = dev_id;
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	uint int_events;
+	irqreturn_t ret = IRQ_NONE;
+
+	int_events = readl(fep->hwp + FEC_IEVENT);
+	writel(int_events, fep->hwp + FEC_IEVENT);
+	fec_enet_collect_events(fep, int_events);
+
+	if ((fep->work_tx || fep->work_rx) && fep->link) {
+		ret = IRQ_HANDLED;
+
+		if (napi_schedule_prep(&fep->napi)) {
+			/* Disable the NAPI interrupts */
+			writel(FEC_NAPI_IMASK, fep->hwp + FEC_IMASK);
+			__napi_schedule(&fep->napi);
+		}
+	}
+
+	if (int_events & FEC_ENET_MII) {
+		ret = IRQ_HANDLED;
+		complete(&fep->mdio_done);
+	}
+	return ret;
+}
+
+static int fec_rt_interrupt(rtdm_irq_t *irqh)
+{
+	struct net_device *ndev = rtdm_irq_get_arg(irqh, struct net_device);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	irqreturn_t ret = RTDM_IRQ_NONE;
+	uint int_events;
+
+	int_events = readl(fep->hwp + FEC_IEVENT);
+	writel(int_events, fep->hwp + FEC_IEVENT);
+	fec_enet_collect_events(fep, int_events);
+
+	if ((fep->work_tx || fep->work_rx) && fep->link) {
+		if (fep->work_rx)
+			fec_enet_rx(ndev, RX_RING_SIZE);
+		if (fep->work_tx)
+			fec_enet_tx(ndev);
+		ret = RTDM_IRQ_HANDLED;
+	}
+
+	if (int_events & FEC_ENET_MII) {
+		rtdm_nrtsig_pend(&fep->rtnet.mdio_sig);
+		ret = RTDM_IRQ_HANDLED;
+	}
+	if(ret != RTDM_IRQ_HANDLED)
+	    printk(XENO_ERR "fec_rt_interrupt ret %d \n", ret);
+
+	return ret;
+}
+
+static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct net_device *ndev = napi->dev;
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int pkts;
+
+	pkts = fec_enet_rx(ndev, budget);
+
+	fec_enet_tx(ndev);
+
+	if (pkts < budget) {
+		napi_complete_done(napi, pkts);
+		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+	}
+	return pkts;
+}
+
+/* ------------------------------------------------------------------------- */
+static int fec_get_mac(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_platform_data *pdata = dev_get_platdata(&fep->pdev->dev);
+	unsigned char *iap, tmpaddr[ETH_ALEN];
+
+	/*
+	 * try to get mac address in following order:
+	 *
+	 * 1) module parameter via kernel command line in form
+	 *    fec.macaddr=0x00,0x04,0x9f,0x01,0x30,0xe0
+	 */
+	iap = macaddr;
+
+	/*
+	 * 2) from device tree data
+	 */
+	if (!is_valid_ether_addr(iap)) {
+		struct device_node *np = fep->pdev->dev.of_node;
+		if (np) {
+			const char *mac = of_get_mac_address(np);
+			if (!IS_ERR(mac))
+				iap = (unsigned char *) mac;
+			else if (PTR_ERR(mac) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+		}
+	}
+
+	/*
+	 * 3) from flash or fuse (via platform data)
+	 */
+	if (!is_valid_ether_addr(iap)) {
+#ifdef CONFIG_M5272
+		if (FEC_FLASHMAC)
+			iap = (unsigned char *)FEC_FLASHMAC;
+#else
+		if (pdata)
+			iap = (unsigned char *)&pdata->mac;
+#endif
+	}
+
+	/*
+	 * 4) FEC mac registers set by bootloader
+	 */
+	if (!is_valid_ether_addr(iap)) {
+		*((__be32 *) &tmpaddr[0]) =
+			cpu_to_be32(readl(fep->hwp + FEC_ADDR_LOW));
+		*((__be16 *) &tmpaddr[4]) =
+			cpu_to_be16(readl(fep->hwp + FEC_ADDR_HIGH) >> 16);
+		iap = &tmpaddr[0];
+	}
+
+	/*
+	 * 5) random mac address
+	 */
+	if (!is_valid_ether_addr(iap)) {
+		/* Report it and use a random ethernet address instead */
+		dev_err(&fep->pdev->dev, "Invalid MAC address: %pM\n", iap);
+		eth_hw_addr_random(ndev);
+		dev_info(&fep->pdev->dev, "Using random MAC address: %pM\n",
+			 ndev->dev_addr);
+		return 0;
+	}
+
+	memcpy(ndev->dev_addr, iap, ETH_ALEN);
+
+	/* Adjust MAC if using macaddr */
+	if (iap == macaddr)
+		 ndev->dev_addr[ETH_ALEN-1] = macaddr[ETH_ALEN-1] + fep->dev_id;
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------------- */
+
+/*
+ * Phy section
+ */
+static void do_adjust_link(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct phy_device *phy_dev = ndev->phydev;
+	int status_change = 0;
+
+	/*
+	 * If the netdev is down, or is going down, we're not interested
+	 * in link state events, so just mark our idea of the link as down
+	 * and ignore the event.
+	 */
+	if (!if_running(ndev) || !netif_device_present(ndev)) {
+		fep->link = 0;
+	} else if (phy_dev->link) {
+		if (!fep->link) {
+			fep->link = phy_dev->link;
+			status_change = 1;
+		}
+
+		if (fep->full_duplex != phy_dev->duplex) {
+			fep->full_duplex = phy_dev->duplex;
+			status_change = 1;
+		}
+
+		if (phy_dev->speed != fep->speed) {
+			fep->speed = phy_dev->speed;
+			status_change = 1;
+		}
+
+		/* if any of the above changed restart the FEC. */
+		if (status_change) {			
+			if_lock(ndev);
+			fec_restart(ndev);
+			if_wake_unlock(ndev, true);
+		}
+	} else {
+		if (fep->link) {
+			if_lock(ndev);
+			fec_stop(ndev);
+			if_unlock(ndev);
+			fep->link = phy_dev->link;
+			status_change = 1;
+		}
+	}
+
+	if (status_change)
+		phy_print_status(phy_dev);
+}
+
+static void fec_enet_adjust_link(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	do_adjust_link(ndev);
+
+	/*
+	 * PHYLIB sets netif_carrier_on() when the link is up,
+	 * propagate state change to RTnet.
+	 */
+	if (fep->rtnet.enabled) {
+		if (netif_carrier_ok(ndev)) {
+			netdev_info(ndev, "carrier detected\n");
+			rtnetif_carrier_on(&fep->rtnet.dev);
+		} else {
+			netdev_info(ndev, "carrier lost\n");
+			rtnetif_carrier_off(&fep->rtnet.dev);
+		}
+	}
+}
+
+static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct fec_enet_private *fep = bus->priv;
+	struct device *dev = &fep->pdev->dev;
+	unsigned long time_left;
+	uint int_events;
+	int ret = 0, frame_start, frame_addr, frame_op;
+	bool is_c45 = !!(regnum & MII_ADDR_C45);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+
+	reinit_completion(&fep->mdio_done);
+
+	if (is_c45) {
+		frame_start = FEC_MMFR_ST_C45;
+
+		/* write address */
+		frame_addr = (regnum >> 16);
+		writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
+		       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+		       FEC_MMFR_TA | (regnum & 0xFFFF),
+		       fep->hwp + FEC_MII_DATA);
+
+		/* wait for end of transfer */
+		time_left = wait_for_completion_timeout(&fep->mdio_done,
+				usecs_to_jiffies(FEC_MII_TIMEOUT));
+		if (time_left == 0) {
+			netdev_err(fep->netdev, "MDIO address write timeout\n");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
+		frame_op = FEC_MMFR_OP_READ_C45;
+
+	} else {
+		/* C22 read */
+		frame_op = FEC_MMFR_OP_READ;
+		frame_start = FEC_MMFR_ST;
+		frame_addr = regnum;
+	}
+
+	/* start a read op */
+	writel(frame_start | frame_op |
+		FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+		FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	time_left = wait_for_completion_timeout(&fep->mdio_done,
+			usecs_to_jiffies(FEC_MII_TIMEOUT));
+	if (time_left == 0) {
+		int_events = readl(fep->hwp + FEC_IEVENT);
+		if (!(int_events & FEC_ENET_MII)) {
+			netdev_err(fep->netdev, "MDIO read timeout\n");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+	}
+
+	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int fec_enet_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
+			   u16 value)
+{
+	struct fec_enet_private *fep = bus->priv;
+	struct device *dev = &fep->pdev->dev;
+	unsigned long time_left;
+	int ret, frame_start, frame_addr;
+	bool is_c45 = !!(regnum & MII_ADDR_C45);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return ret;
+	else
+		ret = 0;
+
+	reinit_completion(&fep->mdio_done);
+
+	if (is_c45) {
+		frame_start = FEC_MMFR_ST_C45;
+
+		/* write address */
+		frame_addr = (regnum >> 16);
+		writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
+		       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+		       FEC_MMFR_TA | (regnum & 0xFFFF),
+		       fep->hwp + FEC_MII_DATA);
+
+		/* wait for end of transfer */
+		time_left = wait_for_completion_timeout(&fep->mdio_done,
+			usecs_to_jiffies(FEC_MII_TIMEOUT));
+		if (time_left == 0) {
+			netdev_err(fep->netdev, "MDIO address write timeout\n");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+	} else {
+		/* C22 write */
+		frame_start = FEC_MMFR_ST;
+		frame_addr = regnum;
+	}
+
+	/* start a write op */
+	writel(frame_start | FEC_MMFR_OP_WRITE |
+		FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+		FEC_MMFR_TA | FEC_MMFR_DATA(value),
+		fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	time_left = wait_for_completion_timeout(&fep->mdio_done,
+			usecs_to_jiffies(FEC_MII_TIMEOUT));
+	if (time_left == 0) {
+		netdev_err(fep->netdev, "MDIO write timeout\n");
+		ret  = -ETIMEDOUT;
+	}
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int ret;
+
+	if (enable) {
+		ret = clk_prepare_enable(fep->clk_enet_out);
+		if (ret)
+			return ret;
+
+		if (fep->clk_ptp) {
+			mutex_lock(&fep->ptp_clk_mutex);
+			ret = clk_prepare_enable(fep->clk_ptp);
+			if (ret) {
+				mutex_unlock(&fep->ptp_clk_mutex);
+				goto failed_clk_ptp;
+			} else {
+				fep->ptp_clk_on = true;
+			}
+			mutex_unlock(&fep->ptp_clk_mutex);
+		}
+
+		ret = clk_prepare_enable(fep->clk_ref);
+		if (ret)
+			goto failed_clk_ref;
+
+		ret = clk_prepare_enable(fep->clk_2x_txclk);
+		if (ret)
+			goto failed_clk_2x_txclk;
+
+		phy_reset_after_clk_enable(ndev->phydev);
+	} else {
+		clk_disable_unprepare(fep->clk_enet_out);
+		if (fep->clk_ptp) {
+			mutex_lock(&fep->ptp_clk_mutex);
+			clk_disable_unprepare(fep->clk_ptp);
+			fep->ptp_clk_on = false;
+			mutex_unlock(&fep->ptp_clk_mutex);
+		}
+		clk_disable_unprepare(fep->clk_ref);
+		clk_disable_unprepare(fep->clk_2x_txclk);
+	}
+
+	return 0;
+
+failed_clk_2x_txclk:
+	if (fep->clk_ref)
+		clk_disable_unprepare(fep->clk_ref);
+failed_clk_ref:
+	if (fep->clk_ptp)
+		clk_disable_unprepare(fep->clk_ptp);
+failed_clk_ptp:
+	if (fep->clk_enet_out)
+		clk_disable_unprepare(fep->clk_enet_out);
+
+	return ret;
+}
+
+static int fec_restore_mii_bus(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int ret;
+
+	ret = pm_runtime_get_sync(&fep->pdev->dev);
+	if (ret < 0)
+		return ret;
+
+	writel(0xffc00000, fep->hwp + FEC_IEVENT);
+	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+	writel(FEC_ENET_MII, fep->hwp + FEC_IMASK);
+	writel(FEC_ENET_ETHEREN, fep->hwp + FEC_ECNTRL);
+
+	pm_runtime_mark_last_busy(&fep->pdev->dev);
+	pm_runtime_put_autosuspend(&fep->pdev->dev);
+	return 0;
+}
+
+static int fec_enet_mii_probe(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct phy_device *phy_dev = NULL;
+	char mdio_bus_id[MII_BUS_ID_SIZE];
+	char phy_name[MII_BUS_ID_SIZE + 3];
+	int phy_id;
+	int dev_id = fep->dev_id;
+
+	if (fep->phy_node) {
+		phy_dev = of_phy_connect(ndev, fep->phy_node,
+					 &fec_enet_adjust_link, 0,
+					 fep->phy_interface);
+		if (!phy_dev) {
+			netdev_err(ndev, "Unable to connect to phy\n");
+			return -ENODEV;
+		}
+	} else {
+		/* check for attached phy */
+		for (phy_id = 0; (phy_id < PHY_MAX_ADDR); phy_id++) {
+			if (!mdiobus_is_registered_device(fep->mii_bus, phy_id))
+				continue;
+			if (dev_id--)
+				continue;
+			strlcpy(mdio_bus_id, fep->mii_bus->id, MII_BUS_ID_SIZE);
+			break;
+		}
+
+		if (phy_id >= PHY_MAX_ADDR) {
+			netdev_info(ndev, "no PHY, assuming direct connection to switch\n");
+			strlcpy(mdio_bus_id, "fixed-0", MII_BUS_ID_SIZE);
+			phy_id = 0;
+		}
+
+		snprintf(phy_name, sizeof(phy_name),
+			 PHY_ID_FMT, mdio_bus_id, phy_id);
+		phy_dev = phy_connect(ndev, phy_name, &fec_enet_adjust_link,
+				      fep->phy_interface);
+	}
+
+	if (IS_ERR(phy_dev)) {
+		netdev_err(ndev, "could not attach to PHY\n");
+		return PTR_ERR(phy_dev);
+	}
+
+	/* mask with MAC supported features */
+	if (fep->quirks & FEC_QUIRK_HAS_GBIT) {
+		phy_set_max_speed(phy_dev, 1000);
+		phy_remove_link_mode(phy_dev,
+				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+#if !defined(CONFIG_M5272)
+		phy_support_sym_pause(phy_dev);
+#endif
+	}
+	else
+		phy_set_max_speed(phy_dev, 100);
+
+	fep->link = 0;
+	fep->full_duplex = 0;
+
+	phy_attached_info(phy_dev);
+
+	return 0;
+}
+
+static int fec_enet_mii_init(struct platform_device *pdev)
+{
+	static struct mii_bus *fec0_mii_bus;
+	static bool *fec_mii_bus_share;
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct device_node *node;
+	int err = -ENXIO;
+	u32 mii_speed, holdtime;
+
+	/*
+	 * The i.MX28 dual fec interfaces are not equal.
+	 * Here are the differences:
+	 *
+	 *  - fec0 supports MII & RMII modes while fec1 only supports RMII
+	 *  - fec0 acts as the 1588 time master while fec1 is slave
+	 *  - external phys can only be configured by fec0
+	 *
+	 * That is to say fec1 can not work independently. It only works
+	 * when fec0 is working. The reason behind this design is that the
+	 * second interface is added primarily for Switch mode.
+	 *
+	 * Because of the last point above, both phys are attached on fec0
+	 * mdio interface in board design, and need to be configured by
+	 * fec0 mii_bus.
+	 */
+	if ((fep->quirks & FEC_QUIRK_SINGLE_MDIO) && fep->dev_id > 0) {
+		/* fec1 uses fec0 mii_bus */
+		if (mii_cnt && fec0_mii_bus) {
+			fep->mii_bus = fec0_mii_bus;
+			*fec_mii_bus_share = true;
+			mii_cnt++;
+			return 0;
+		}
+		return -ENOENT;
+	}
+
+	/*
+	 * Set MII speed to 2.5 MHz (= clk_get_rate() / 2 * phy_speed)
+	 *
+	 * The formula for FEC MDC is 'ref_freq / (MII_SPEED x 2)' while
+	 * for ENET-MAC is 'ref_freq / ((MII_SPEED + 1) x 2)'.  The i.MX28
+	 * Reference Manual has an error on this, and gets fixed on i.MX6Q
+	 * document.
+	 */
+	mii_speed = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 5000000);
+	if (fep->quirks & FEC_QUIRK_ENET_MAC)
+		mii_speed--;
+	if (mii_speed > 63) {
+		dev_err(&pdev->dev,
+			"fec clock (%lu) too fast to get right mii speed\n",
+			clk_get_rate(fep->clk_ipg));
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	/*
+	 * The i.MX28 and i.MX6 types have another filed in the MSCR (aka
+	 * MII_SPEED) register that defines the MDIO output hold time. Earlier
+	 * versions are RAZ there, so just ignore the difference and write the
+	 * register always.
+	 * The minimal hold time according to IEE802.3 (clause 22) is 10 ns.
+	 * HOLDTIME + 1 is the number of clk cycles the fec is holding the
+	 * output.
+	 * The HOLDTIME bitfield takes values between 0 and 7 (inclusive).
+	 * Given that ceil(clkrate / 5000000) <= 64, the calculation for
+	 * holdtime cannot result in a value greater than 3.
+	 */
+	holdtime = DIV_ROUND_UP(clk_get_rate(fep->clk_ipg), 100000000) - 1;
+
+	fep->phy_speed = mii_speed << 1 | holdtime << 8;
+
+	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+
+	fep->mii_bus = mdiobus_alloc();
+	if (fep->mii_bus == NULL) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	fep->mii_bus->name = "fec_enet_mii_bus";
+	fep->mii_bus->read = fec_enet_mdio_read;
+	fep->mii_bus->write = fec_enet_mdio_write;
+	snprintf(fep->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
+		pdev->name, fep->dev_id + 1);
+	fep->mii_bus->priv = fep;
+	fep->mii_bus->parent = &pdev->dev;
+
+	node = of_get_child_by_name(pdev->dev.of_node, "mdio");
+	err = of_mdiobus_register(fep->mii_bus, node);
+	of_node_put(node);
+	if (err)
+		goto err_out_free_mdiobus;
+
+	mii_cnt++;
+
+	/* save fec0 mii_bus */
+	if (fep->quirks & FEC_QUIRK_SINGLE_MDIO) {
+		fec0_mii_bus = fep->mii_bus;
+		fec_mii_bus_share = &fep->mii_bus_share;
+	}
+
+	return 0;
+
+err_out_free_mdiobus:
+	mdiobus_free(fep->mii_bus);
+err_out:
+	return err;
+}
+
+static void fec_enet_mii_remove(struct fec_enet_private *fep)
+{
+	if (--mii_cnt == 0) {
+		mdiobus_unregister(fep->mii_bus);
+		mdiobus_free(fep->mii_bus);
+	}
+}
+
+static void fec_enet_get_drvinfo(struct net_device *ndev,
+				 struct ethtool_drvinfo *info)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	strlcpy(info->driver, fep->pdev->dev.driver->name,
+		sizeof(info->driver));
+	strlcpy(info->version, "Revision: 1.0", sizeof(info->version));
+	strlcpy(info->bus_info, dev_name(&ndev->dev), sizeof(info->bus_info));
+}
+
+static int fec_enet_get_regs_len(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct resource *r;
+	int s = 0;
+
+	r = platform_get_resource(fep->pdev, IORESOURCE_MEM, 0);
+	if (r)
+		s = resource_size(r);
+
+	return s;
+}
+
+/* List of registers that can be safety be read to dump them with ethtool */
+#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
+	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
+	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+static __u32 fec_enet_register_version = 2;
+static u32 fec_enet_register_offset[] = {
+	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
+	FEC_ECNTRL, FEC_MII_DATA, FEC_MII_SPEED, FEC_MIB_CTRLSTAT, FEC_R_CNTRL,
+	FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH, FEC_OPD, FEC_TXIC0, FEC_TXIC1,
+	FEC_TXIC2, FEC_RXIC0, FEC_RXIC1, FEC_RXIC2, FEC_HASH_TABLE_HIGH,
+	FEC_HASH_TABLE_LOW, FEC_GRP_HASH_TABLE_HIGH, FEC_GRP_HASH_TABLE_LOW,
+	FEC_X_WMRK, FEC_R_BOUND, FEC_R_FSTART, FEC_R_DES_START_1,
+	FEC_X_DES_START_1, FEC_R_BUFF_SIZE_1, FEC_R_DES_START_2,
+	FEC_X_DES_START_2, FEC_R_BUFF_SIZE_2, FEC_R_DES_START_0,
+	FEC_X_DES_START_0, FEC_R_BUFF_SIZE_0, FEC_R_FIFO_RSFL, FEC_R_FIFO_RSEM,
+	FEC_R_FIFO_RAEM, FEC_R_FIFO_RAFL, FEC_RACC, FEC_RCMR_1, FEC_RCMR_2,
+	FEC_DMA_CFG_1, FEC_DMA_CFG_2, FEC_R_DES_ACTIVE_1, FEC_X_DES_ACTIVE_1,
+	FEC_R_DES_ACTIVE_2, FEC_X_DES_ACTIVE_2, FEC_QOS_SCHEME,
+	RMON_T_DROP, RMON_T_PACKETS, RMON_T_BC_PKT, RMON_T_MC_PKT,
+	RMON_T_CRC_ALIGN, RMON_T_UNDERSIZE, RMON_T_OVERSIZE, RMON_T_FRAG,
+	RMON_T_JAB, RMON_T_COL, RMON_T_P64, RMON_T_P65TO127, RMON_T_P128TO255,
+	RMON_T_P256TO511, RMON_T_P512TO1023, RMON_T_P1024TO2047,
+	RMON_T_P_GTE2048, RMON_T_OCTETS,
+	IEEE_T_DROP, IEEE_T_FRAME_OK, IEEE_T_1COL, IEEE_T_MCOL, IEEE_T_DEF,
+	IEEE_T_LCOL, IEEE_T_EXCOL, IEEE_T_MACERR, IEEE_T_CSERR, IEEE_T_SQE,
+	IEEE_T_FDXFC, IEEE_T_OCTETS_OK,
+	RMON_R_PACKETS, RMON_R_BC_PKT, RMON_R_MC_PKT, RMON_R_CRC_ALIGN,
+	RMON_R_UNDERSIZE, RMON_R_OVERSIZE, RMON_R_FRAG, RMON_R_JAB,
+	RMON_R_RESVD_O, RMON_R_P64, RMON_R_P65TO127, RMON_R_P128TO255,
+	RMON_R_P256TO511, RMON_R_P512TO1023, RMON_R_P1024TO2047,
+	RMON_R_P_GTE2048, RMON_R_OCTETS,
+	IEEE_R_DROP, IEEE_R_FRAME_OK, IEEE_R_CRC, IEEE_R_ALIGN, IEEE_R_MACERR,
+	IEEE_R_FDXFC, IEEE_R_OCTETS_OK
+};
+#else
+static __u32 fec_enet_register_version = 1;
+static u32 fec_enet_register_offset[] = {
+	FEC_ECNTRL, FEC_IEVENT, FEC_IMASK, FEC_IVEC, FEC_R_DES_ACTIVE_0,
+	FEC_R_DES_ACTIVE_1, FEC_R_DES_ACTIVE_2, FEC_X_DES_ACTIVE_0,
+	FEC_X_DES_ACTIVE_1, FEC_X_DES_ACTIVE_2, FEC_MII_DATA, FEC_MII_SPEED,
+	FEC_R_BOUND, FEC_R_FSTART, FEC_X_WMRK, FEC_X_FSTART, FEC_R_CNTRL,
+	FEC_MAX_FRM_LEN, FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH,
+	FEC_GRP_HASH_TABLE_HIGH, FEC_GRP_HASH_TABLE_LOW, FEC_R_DES_START_0,
+	FEC_R_DES_START_1, FEC_R_DES_START_2, FEC_X_DES_START_0,
+	FEC_X_DES_START_1, FEC_X_DES_START_2, FEC_R_BUFF_SIZE_0,
+	FEC_R_BUFF_SIZE_1, FEC_R_BUFF_SIZE_2
+};
+#endif
+
+static void fec_enet_get_regs(struct net_device *ndev,
+			      struct ethtool_regs *regs, void *regbuf)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	u32 __iomem *theregs = (u32 __iomem *)fep->hwp;
+	struct device *dev = &fep->pdev->dev;
+	u32 *buf = (u32 *)regbuf;
+	u32 i, off;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		return;
+
+	regs->version = fec_enet_register_version;
+
+	memset(buf, 0, regs->len);
+
+	for (i = 0; i < ARRAY_SIZE(fec_enet_register_offset); i++) {
+		off = fec_enet_register_offset[i];
+
+		if ((off == FEC_R_BOUND || off == FEC_R_FSTART) &&
+		    !(fep->quirks & FEC_QUIRK_HAS_FRREG))
+			continue;
+
+		off >>= 2;
+		buf[off] = readl(&theregs[off]);
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
+static int fec_enet_get_ts_info(struct net_device *ndev,
+				struct ethtool_ts_info *info)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	if (fep->bufdesc_ex) {
+
+		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE |
+					SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_TX_HARDWARE |
+					SOF_TIMESTAMPING_RX_HARDWARE |
+					SOF_TIMESTAMPING_RAW_HARDWARE;
+		if (fep->ptp_clock)
+			info->phc_index = ptp_clock_index(fep->ptp_clock);
+		else
+			info->phc_index = -1;
+
+		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
+				 (1 << HWTSTAMP_TX_ON);
+
+		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+				   (1 << HWTSTAMP_FILTER_ALL);
+		return 0;
+	} else {
+		return ethtool_op_get_ts_info(ndev, info);
+	}
+}
+
+#if !defined(CONFIG_M5272)
+
+static void fec_enet_get_pauseparam(struct net_device *ndev,
+				    struct ethtool_pauseparam *pause)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	pause->autoneg = (fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) != 0;
+	pause->tx_pause = (fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) != 0;
+	pause->rx_pause = pause->tx_pause;
+}
+
+static int fec_enet_set_pauseparam(struct net_device *ndev,
+				   struct ethtool_pauseparam *pause)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	if (!ndev->phydev)
+		return -ENODEV;
+
+	if (pause->tx_pause != pause->rx_pause) {
+		netdev_info(ndev,
+			"hardware only support enable/disable both tx and rx");
+		return -EINVAL;
+	}
+
+	fep->pause_flag = 0;
+
+	/* tx pause must be same as rx pause */
+	fep->pause_flag |= pause->rx_pause ? FEC_PAUSE_FLAG_ENABLE : 0;
+	fep->pause_flag |= pause->autoneg ? FEC_PAUSE_FLAG_AUTONEG : 0;
+
+	phy_set_sym_pause(ndev->phydev, pause->rx_pause, pause->tx_pause,
+			  pause->autoneg);
+
+	if (pause->autoneg) {
+		if (if_running(ndev))
+			fec_stop(ndev);
+		phy_start_aneg(ndev->phydev);
+	}
+	if (if_running(ndev)) {
+		if_lock(ndev);
+		fec_restart(ndev);
+		if_wake_unlock(ndev, true);
+	}
+
+	return 0;
+}
+
+static const struct fec_stat {
+	char name[ETH_GSTRING_LEN];
+	u16 offset;
+} fec_stats[] = {
+	/* RMON TX */
+	{ "tx_dropped", RMON_T_DROP },
+	{ "tx_packets", RMON_T_PACKETS },
+	{ "tx_broadcast", RMON_T_BC_PKT },
+	{ "tx_multicast", RMON_T_MC_PKT },
+	{ "tx_crc_errors", RMON_T_CRC_ALIGN },
+	{ "tx_undersize", RMON_T_UNDERSIZE },
+	{ "tx_oversize", RMON_T_OVERSIZE },
+	{ "tx_fragment", RMON_T_FRAG },
+	{ "tx_jabber", RMON_T_JAB },
+	{ "tx_collision", RMON_T_COL },
+	{ "tx_64byte", RMON_T_P64 },
+	{ "tx_65to127byte", RMON_T_P65TO127 },
+	{ "tx_128to255byte", RMON_T_P128TO255 },
+	{ "tx_256to511byte", RMON_T_P256TO511 },
+	{ "tx_512to1023byte", RMON_T_P512TO1023 },
+	{ "tx_1024to2047byte", RMON_T_P1024TO2047 },
+	{ "tx_GTE2048byte", RMON_T_P_GTE2048 },
+	{ "tx_octets", RMON_T_OCTETS },
+
+	/* IEEE TX */
+	{ "IEEE_tx_drop", IEEE_T_DROP },
+	{ "IEEE_tx_frame_ok", IEEE_T_FRAME_OK },
+	{ "IEEE_tx_1col", IEEE_T_1COL },
+	{ "IEEE_tx_mcol", IEEE_T_MCOL },
+	{ "IEEE_tx_def", IEEE_T_DEF },
+	{ "IEEE_tx_lcol", IEEE_T_LCOL },
+	{ "IEEE_tx_excol", IEEE_T_EXCOL },
+	{ "IEEE_tx_macerr", IEEE_T_MACERR },
+	{ "IEEE_tx_cserr", IEEE_T_CSERR },
+	{ "IEEE_tx_sqe", IEEE_T_SQE },
+	{ "IEEE_tx_fdxfc", IEEE_T_FDXFC },
+	{ "IEEE_tx_octets_ok", IEEE_T_OCTETS_OK },
+
+	/* RMON RX */
+	{ "rx_packets", RMON_R_PACKETS },
+	{ "rx_broadcast", RMON_R_BC_PKT },
+	{ "rx_multicast", RMON_R_MC_PKT },
+	{ "rx_crc_errors", RMON_R_CRC_ALIGN },
+	{ "rx_undersize", RMON_R_UNDERSIZE },
+	{ "rx_oversize", RMON_R_OVERSIZE },
+	{ "rx_fragment", RMON_R_FRAG },
+	{ "rx_jabber", RMON_R_JAB },
+	{ "rx_64byte", RMON_R_P64 },
+	{ "rx_65to127byte", RMON_R_P65TO127 },
+	{ "rx_128to255byte", RMON_R_P128TO255 },
+	{ "rx_256to511byte", RMON_R_P256TO511 },
+	{ "rx_512to1023byte", RMON_R_P512TO1023 },
+	{ "rx_1024to2047byte", RMON_R_P1024TO2047 },
+	{ "rx_GTE2048byte", RMON_R_P_GTE2048 },
+	{ "rx_octets", RMON_R_OCTETS },
+
+	/* IEEE RX */
+	{ "IEEE_rx_drop", IEEE_R_DROP },
+	{ "IEEE_rx_frame_ok", IEEE_R_FRAME_OK },
+	{ "IEEE_rx_crc", IEEE_R_CRC },
+	{ "IEEE_rx_align", IEEE_R_ALIGN },
+	{ "IEEE_rx_macerr", IEEE_R_MACERR },
+	{ "IEEE_rx_fdxfc", IEEE_R_FDXFC },
+	{ "IEEE_rx_octets_ok", IEEE_R_OCTETS_OK },
+};
+
+#define FEC_STATS_SIZE		(ARRAY_SIZE(fec_stats) * sizeof(u64))
+
+static void fec_enet_update_ethtool_stats(struct net_device *dev)
+{
+	struct fec_enet_private *fep = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fec_stats); i++)
+		fep->ethtool_stats[i] = readl(fep->hwp + fec_stats[i].offset);
+}
+
+static void fec_enet_get_ethtool_stats(struct net_device *dev,
+				       struct ethtool_stats *stats, u64 *data)
+{
+	struct fec_enet_private *fep = netdev_priv(dev);
+
+	if (if_running(dev))
+		fec_enet_update_ethtool_stats(dev);
+
+	memcpy(data, fep->ethtool_stats, FEC_STATS_SIZE);
+}
+
+static void fec_enet_get_strings(struct net_device *netdev,
+	u32 stringset, u8 *data)
+{
+	int i;
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ARRAY_SIZE(fec_stats); i++)
+			memcpy(data + i * ETH_GSTRING_LEN,
+				fec_stats[i].name, ETH_GSTRING_LEN);
+		break;
+	}
+}
+
+static int fec_enet_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(fec_stats);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void fec_enet_clear_ethtool_stats(struct net_device *dev)
+{
+	struct fec_enet_private *fep = netdev_priv(dev);
+	int i;
+
+	/* Disable MIB statistics counters */
+	writel(FEC_MIB_CTRLSTAT_DISABLE, fep->hwp + FEC_MIB_CTRLSTAT);
+
+	for (i = 0; i < ARRAY_SIZE(fec_stats); i++)
+		writel(0, fep->hwp + fec_stats[i].offset);
+
+	/* Don't disable MIB statistics counters */
+	writel(0, fep->hwp + FEC_MIB_CTRLSTAT);
+}
+
+#else	/* !defined(CONFIG_M5272) */
+#define FEC_STATS_SIZE	0
+static inline void fec_enet_update_ethtool_stats(struct net_device *dev)
+{
+}
+
+static inline void fec_enet_clear_ethtool_stats(struct net_device *dev)
+{
+}
+#endif /* !defined(CONFIG_M5272) */
+
+/* ITR clock source is enet system clock (clk_ahb).
+ * TCTT unit is cycle_ns * 64 cycle
+ * So, the ICTT value = X us / (cycle_ns * 64)
+ */
+static int fec_enet_us_to_itr_clock(struct net_device *ndev, int us)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	return us * (fep->itr_clk_rate / 64000) / 1000;
+}
+
+/* Set threshold for interrupt coalescing */
+static void fec_enet_itr_coal_set(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int rx_itr, tx_itr;
+
+	/* Must be greater than zero to avoid unpredictable behavior */
+	if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
+	    !fep->tx_time_itr || !fep->tx_pkts_itr)
+		return;
+
+	/* Select enet system clock as Interrupt Coalescing
+	 * timer Clock Source
+	 */
+	rx_itr = FEC_ITR_CLK_SEL;
+	tx_itr = FEC_ITR_CLK_SEL;
+
+	/* set ICFT and ICTT */
+	rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
+	rx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr));
+	tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
+	tx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr));
+
+	rx_itr |= FEC_ITR_EN;
+	tx_itr |= FEC_ITR_EN;
+
+	writel(tx_itr, fep->hwp + FEC_TXIC0);
+	writel(rx_itr, fep->hwp + FEC_RXIC0);
+	if (fep->quirks & FEC_QUIRK_HAS_AVB) {
+		writel(tx_itr, fep->hwp + FEC_TXIC1);
+		writel(rx_itr, fep->hwp + FEC_RXIC1);
+		writel(tx_itr, fep->hwp + FEC_TXIC2);
+		writel(rx_itr, fep->hwp + FEC_RXIC2);
+	}
+}
+
+static int
+fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	if (!(fep->quirks & FEC_QUIRK_HAS_COALESCE))
+		return -EOPNOTSUPP;
+
+	ec->rx_coalesce_usecs = fep->rx_time_itr;
+	ec->rx_max_coalesced_frames = fep->rx_pkts_itr;
+
+	ec->tx_coalesce_usecs = fep->tx_time_itr;
+	ec->tx_max_coalesced_frames = fep->tx_pkts_itr;
+
+	return 0;
+}
+
+static int
+fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct device *dev = &fep->pdev->dev;
+	unsigned int cycle;
+
+	if (!(fep->quirks & FEC_QUIRK_HAS_COALESCE))
+		return -EOPNOTSUPP;
+
+	if (ec->rx_max_coalesced_frames > 255) {
+		dev_err(dev, "Rx coalesced frames exceed hardware limitation\n");
+		return -EINVAL;
+	}
+
+	if (ec->tx_max_coalesced_frames > 255) {
+		dev_err(dev, "Tx coalesced frame exceed hardware limitation\n");
+		return -EINVAL;
+	}
+
+	cycle = fec_enet_us_to_itr_clock(ndev, ec->rx_coalesce_usecs);
+	if (cycle > 0xFFFF) {
+		dev_err(dev, "Rx coalesced usec exceed hardware limitation\n");
+		return -EINVAL;
+	}
+
+	cycle = fec_enet_us_to_itr_clock(ndev, ec->tx_coalesce_usecs);
+	if (cycle > 0xFFFF) {
+		dev_err(dev, "Tx coalesced usec exceed hardware limitation\n");
+		return -EINVAL;
+	}
+
+	fep->rx_time_itr = ec->rx_coalesce_usecs;
+	fep->rx_pkts_itr = ec->rx_max_coalesced_frames;
+
+	fep->tx_time_itr = ec->tx_coalesce_usecs;
+	fep->tx_pkts_itr = ec->tx_max_coalesced_frames;
+
+	fec_enet_itr_coal_set(ndev);
+
+	return 0;
+}
+
+static void fec_enet_itr_coal_init(struct net_device *ndev)
+{
+	struct ethtool_coalesce ec;
+
+	ec.rx_coalesce_usecs = FEC_ITR_ICTT_DEFAULT;
+	ec.rx_max_coalesced_frames = FEC_ITR_ICFT_DEFAULT;
+
+	ec.tx_coalesce_usecs = FEC_ITR_ICTT_DEFAULT;
+	ec.tx_max_coalesced_frames = FEC_ITR_ICFT_DEFAULT;
+
+	fec_enet_set_coalesce(ndev, &ec);
+}
+
+static int fec_enet_get_tunable(struct net_device *netdev,
+				const struct ethtool_tunable *tuna,
+				void *data)
+{
+	struct fec_enet_private *fep = netdev_priv(netdev);
+	int ret = 0;
+
+	switch (tuna->id) {
+	case ETHTOOL_RX_COPYBREAK:
+		*(u32 *)data = fep->rx_copybreak;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int fec_enet_set_tunable(struct net_device *netdev,
+				const struct ethtool_tunable *tuna,
+				const void *data)
+{
+	struct fec_enet_private *fep = netdev_priv(netdev);
+	int ret = 0;
+
+	switch (tuna->id) {
+	case ETHTOOL_RX_COPYBREAK:
+		fep->rx_copybreak = *(u32 *)data;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/* LPI Sleep Ts count base on tx clk (clk_ref).
+ * The lpi sleep cnt value = X us / (cycle_ns)
+ */
+static int fec_enet_us_to_tx_cycle(struct net_device *ndev, int us)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	return us * (fep->clk_ref_rate / 1000) / 1000;
+}
+
+static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct ethtool_eee *p = &fep->eee;
+	unsigned int sleep_cycle, wake_cycle;
+	int ret = 0;
+
+	if (enable) {
+		ret = phy_init_eee(ndev->phydev, 0);
+		if (ret)
+			return ret;
+
+		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, p->tx_lpi_timer);
+		wake_cycle = sleep_cycle;
+	} else {
+		sleep_cycle = 0;
+		wake_cycle = 0;
+	}
+
+	p->tx_lpi_enabled = enable;
+	p->eee_enabled = enable;
+	p->eee_active = enable;
+
+	writel(sleep_cycle, fep->hwp + FEC_LPI_SLEEP);
+	writel(wake_cycle, fep->hwp + FEC_LPI_WAKE);
+
+	return 0;
+}
+
+static int
+fec_enet_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct ethtool_eee *p = &fep->eee;
+
+	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
+		return -EOPNOTSUPP;
+
+	if (!if_running(ndev))
+		return -ENETDOWN;
+
+	edata->eee_enabled = p->eee_enabled;
+	edata->eee_active = p->eee_active;
+	edata->tx_lpi_timer = p->tx_lpi_timer;
+	edata->tx_lpi_enabled = p->tx_lpi_enabled;
+
+	return phy_ethtool_get_eee(ndev->phydev, edata);
+}
+
+static int
+fec_enet_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct ethtool_eee *p = &fep->eee;
+	int ret = 0;
+
+	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
+		return -EOPNOTSUPP;
+
+	if (!if_running(ndev))
+		return -ENETDOWN;
+
+	p->tx_lpi_timer = edata->tx_lpi_timer;
+
+	if (!edata->eee_enabled || !edata->tx_lpi_enabled ||
+	    !edata->tx_lpi_timer)
+		ret = fec_enet_eee_mode_set(ndev, false);
+	else
+		ret = fec_enet_eee_mode_set(ndev, true);
+
+	if (ret)
+		return ret;
+
+	return phy_ethtool_set_eee(ndev->phydev, edata);
+}
+
+static void
+fec_enet_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	if (fep->wol_flag & FEC_WOL_HAS_MAGIC_PACKET) {
+		wol->supported = WAKE_MAGIC;
+		wol->wolopts = fep->wol_flag & FEC_WOL_FLAG_ENABLE ? WAKE_MAGIC : 0;
+	} else {
+		wol->supported = wol->wolopts = 0;
+	}
+}
+
+static int
+fec_enet_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	if (!(fep->wol_flag & FEC_WOL_HAS_MAGIC_PACKET))
+		return -EINVAL;
+
+	if (wol->wolopts & ~WAKE_MAGIC)
+		return -EINVAL;
+
+	device_set_wakeup_enable(&ndev->dev, wol->wolopts & WAKE_MAGIC);
+	if (device_may_wakeup(&ndev->dev))
+		fep->wol_flag |= FEC_WOL_FLAG_ENABLE;
+	else
+		fep->wol_flag &= (~FEC_WOL_FLAG_ENABLE);
+
+	return 0;
+}
+
+static const struct ethtool_ops fec_enet_ethtool_ops = {
+	.get_drvinfo		= fec_enet_get_drvinfo,
+	.get_regs_len		= fec_enet_get_regs_len,
+	.get_regs		= fec_enet_get_regs,
+	.nway_reset		= phy_ethtool_nway_reset,
+	.get_link		= ethtool_op_get_link,
+	.get_coalesce		= fec_enet_get_coalesce,
+	.set_coalesce		= fec_enet_set_coalesce,
+#ifndef CONFIG_M5272
+	.get_pauseparam		= fec_enet_get_pauseparam,
+	.set_pauseparam		= fec_enet_set_pauseparam,
+	.get_strings		= fec_enet_get_strings,
+	.get_ethtool_stats	= fec_enet_get_ethtool_stats,
+	.get_sset_count		= fec_enet_get_sset_count,
+#endif
+	.get_ts_info		= fec_enet_get_ts_info,
+	.get_tunable		= fec_enet_get_tunable,
+	.set_tunable		= fec_enet_set_tunable,
+	.get_wol		= fec_enet_get_wol,
+	.set_wol		= fec_enet_set_wol,
+	.get_eee		= fec_enet_get_eee,
+	.set_eee		= fec_enet_set_eee,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+};
+
+static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct phy_device *phydev = ndev->phydev;
+
+	if (!if_running(ndev))
+		return -EINVAL;
+
+	if (!phydev)
+		return -ENODEV;
+
+	if (fep->bufdesc_ex) {
+		if (cmd == SIOCSHWTSTAMP)
+			return fec_ptp_set(ndev, rq);
+		if (cmd == SIOCGHWTSTAMP)
+			return fec_ptp_get(ndev, rq);
+	}
+
+	return phy_mii_ioctl(phydev, rq, cmd);
+}
+
+static int fec_rt_ioctl(struct rtnet_device *rtdev, struct ifreq *rq, int cmd)
+{
+	struct fec_enet_private *fep;
+
+	fep = container_of(rtdev, struct fec_enet_private, rtnet.dev);
+	return fec_enet_ioctl(fep->netdev, rq, cmd);
+}
+
+static void fec_enet_free_buffers(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	unsigned int i;
+	void *skb;
+	struct bufdesc	*bdp;
+	struct fec_enet_priv_tx_q *txq;
+	struct fec_enet_priv_rx_q *rxq;
+	unsigned int q;
+
+	for (q = 0; q < fep->num_rx_queues; q++) {
+		rxq = fep->rx_queue[q];
+		bdp = rxq->bd.base;
+		for (i = 0; i < rxq->bd.ring_size; i++) {
+			if (!fep->rtnet.enabled) {
+				skb = rxq->rx_skbuff[i];
+				rxq->rx_skbuff[i] = NULL;
+			} else {
+				skb = rxq->rx_rtbuff[i];
+				rxq->rx_rtbuff[i] = NULL;
+			}
+			if (skb) {
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 FEC_ENET_RX_FRSIZE - fep->rx_align,
+						 DMA_FROM_DEVICE);
+
+				if (!fep->rtnet.enabled) {
+					dev_kfree_skb(skb);
+				} else {
+					dev_kfree_rtskb(skb);
+				}
+			}
+			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+		}
+	}
+
+	for (q = 0; q < fep->num_tx_queues; q++) {
+		txq = fep->tx_queue[q];
+		bdp = txq->bd.base;
+		for (i = 0; i < txq->bd.ring_size; i++) {
+			kfree(txq->tx_bounce[i]);
+			txq->tx_bounce[i] = NULL;
+			if (!fep->rtnet.enabled) {
+				skb = txq->tx_skbuff[i];
+				txq->tx_skbuff[i] = NULL;
+				if (skb) {
+					dev_kfree_skb(skb);
+				}
+			} else {
+				skb = txq->tx_rtbuff[i];
+				txq->tx_rtbuff[i] = NULL;
+				if (skb) {
+					dev_kfree_rtskb(skb);
+				}
+			}
+		}
+	}
+}
+
+static void fec_enet_free_queue(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int i;
+	struct fec_enet_priv_tx_q *txq;
+
+	for (i = 0; i < fep->num_tx_queues; i++)
+		if (fep->tx_queue[i] && fep->tx_queue[i]->tso_hdrs) {
+			txq = fep->tx_queue[i];
+			dma_free_coherent(&fep->pdev->dev,
+					  txq->bd.ring_size * TSO_HEADER_SIZE,
+					  txq->tso_hdrs,
+					  txq->tso_hdrs_dma);
+		}
+
+	for (i = 0; i < fep->num_rx_queues; i++)
+		kfree(fep->rx_queue[i]);
+	for (i = 0; i < fep->num_tx_queues; i++)
+		kfree(fep->tx_queue[i]);
+}
+
+static int fec_enet_alloc_queue(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int i;
+	int ret = 0;
+	struct fec_enet_priv_tx_q *txq;
+
+	for (i = 0; i < fep->num_tx_queues; i++) {
+		txq = kzalloc(sizeof(*txq), GFP_KERNEL);
+		if (!txq) {
+			ret = -ENOMEM;
+			goto alloc_failed;
+		}
+
+		fep->tx_queue[i] = txq;
+		txq->bd.ring_size = TX_RING_SIZE;
+		fep->total_tx_ring_size += fep->tx_queue[i]->bd.ring_size;
+
+		txq->tx_stop_threshold = FEC_MAX_SKB_DESCS;
+		txq->tx_wake_threshold =
+			(txq->bd.ring_size - txq->tx_stop_threshold) / 2;
+
+		txq->tso_hdrs = dma_alloc_coherent(&fep->pdev->dev,
+					txq->bd.ring_size * TSO_HEADER_SIZE,
+					&txq->tso_hdrs_dma,
+					GFP_KERNEL);
+		if (!txq->tso_hdrs) {
+			ret = -ENOMEM;
+			goto alloc_failed;
+		}
+	}
+
+	for (i = 0; i < fep->num_rx_queues; i++) {
+		fep->rx_queue[i] = kzalloc(sizeof(*fep->rx_queue[i]),
+					   GFP_KERNEL);
+		if (!fep->rx_queue[i]) {
+			ret = -ENOMEM;
+			goto alloc_failed;
+		}
+
+		fep->rx_queue[i]->bd.ring_size = RX_RING_SIZE;
+		fep->total_rx_ring_size += fep->rx_queue[i]->bd.ring_size;
+	}
+	return ret;
+
+alloc_failed:
+        printk(XENO_ERR "RT FEC: fec_enet_alloc_queue alloc_failed\n");
+	fec_enet_free_queue(ndev);
+	return ret;
+}
+
+static int
+fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	unsigned int i;
+	struct sk_buff *skb;
+	struct rtskb *rtskb;
+	struct bufdesc	*bdp;
+	struct fec_enet_priv_rx_q *rxq;
+
+	rxq = fep->rx_queue[queue];
+	bdp = rxq->bd.base;
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		if (frt->enabled) {
+			rtskb = rtnetdev_alloc_rtskb(&frt->dev, FEC_ENET_RX_FRSIZE);
+			if (!rtskb)
+				goto err_alloc;
+
+			if (fec_rt_new_rxbdp(ndev, bdp, rtskb)) {
+				dev_kfree_rtskb(rtskb);
+				goto err_alloc;
+			}
+			rxq->rx_rtbuff[i] = rtskb;
+		} else {
+			skb = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
+			if (!skb)
+				goto err_alloc;
+
+			if (fec_enet_new_rxbdp(ndev, bdp, skb)) {
+				dev_kfree_skb(skb);
+				goto err_alloc;
+			}
+
+			rxq->rx_skbuff[i] = skb;
+		}
+		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+		}
+
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+
+	/* Set the last buffer to wrap. */
+	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
+	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+	return 0;
+
+ err_alloc:
+	fec_enet_free_buffers(ndev);
+	return -ENOMEM;
+}
+
+static int
+fec_enet_alloc_txq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	unsigned int i;
+	struct bufdesc  *bdp;
+	struct fec_enet_priv_tx_q *txq;
+
+	txq = fep->tx_queue[queue];
+	bdp = txq->bd.base;
+	for (i = 0; i < txq->bd.ring_size; i++) {
+		txq->tx_bounce[i] = kmalloc(FEC_ENET_TX_FRSIZE, GFP_KERNEL);
+		if (!txq->tx_bounce[i])
+			goto err_alloc;
+
+		bdp->cbd_sc = cpu_to_fec16(0);
+		bdp->cbd_bufaddr = cpu_to_fec32(0);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_TX_INT);
+		}
+
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+	}
+
+	/* Set the last buffer to wrap. */
+	bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
+	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+
+	return 0;
+
+ err_alloc:
+	fec_enet_free_buffers(ndev);
+	return -ENOMEM;
+}
+
+static int fec_enet_alloc_buffers(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	unsigned int i;
+
+	for (i = 0; i < fep->num_rx_queues; i++)
+		if (fec_enet_alloc_rxq_buffers(ndev, i))
+			return -ENOMEM;
+
+	for (i = 0; i < fep->num_tx_queues; i++)
+		if (fec_enet_alloc_txq_buffers(ndev, i))
+			return -ENOMEM;
+	return 0;
+}
+
+static int
+__fec_enet_open(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int ret;
+	bool reset_again;
+
+	ret = pm_runtime_get_sync(&fep->pdev->dev);
+	if (ret < 0)
+		return ret;
+
+	pinctrl_pm_select_default_state(&fep->pdev->dev);
+	ret = fec_enet_clk_enable(ndev, true);
+	if (ret)
+		goto clk_enable;
+
+	/* During the first fec_enet_open call the PHY isn't probed at this
+	 * point. Therefore the phy_reset_after_clk_enable() call within
+	 * fec_enet_clk_enable() fails. As we need this reset in order to be
+	 * sure the PHY is working correctly we check if we need to reset again
+	 * later when the PHY is probed
+	 */
+	if (ndev->phydev && ndev->phydev->drv)
+		reset_again = false;
+	else
+		reset_again = true;
+
+	/* I should reset the ring buffers here, but I don't yet know
+	 * a simple way to do that.
+	 */
+
+	ret = fec_enet_alloc_buffers(ndev);
+	if (ret)
+		goto err_enet_alloc;
+
+	/* Init MAC prior to mii bus probe */
+	fec_restart(ndev);
+
+	/* Probe and connect to PHY when open the interface */
+	ret = fec_enet_mii_probe(ndev);
+	if (ret)
+		goto err_enet_mii_probe;
+
+	/* Call phy_reset_after_clk_enable() again if it failed during
+	 * phy_reset_after_clk_enable() before because the PHY wasn't probed.
+	 */
+	if (reset_again)
+		phy_reset_after_clk_enable(ndev->phydev);
+
+	if (fep->quirks & FEC_QUIRK_ERR006687)
+		imx6q_cpuidle_fec_irqs_used();
+	if (fep->quirks & FEC_QUIRK_HAS_PMQOS)
+		pm_qos_add_request(&fep->pm_qos_req,
+				   PM_QOS_CPU_DMA_LATENCY,
+				   0);
+
+	napi_enable(&fep->napi);
+	phy_start(ndev->phydev);
+	netif_tx_start_all_queues(ndev);
+
+	device_set_wakeup_enable(&ndev->dev, fep->wol_flag &
+				 FEC_WOL_FLAG_ENABLE);
+
+	return 0;
+
+err_enet_mii_probe:
+	fec_enet_free_buffers(ndev);
+err_enet_alloc:
+	fec_enet_clk_enable(ndev, false);
+clk_enable:
+	pm_runtime_mark_last_busy(&fep->pdev->dev);
+	pm_runtime_put_autosuspend(&fep->pdev->dev);
+	if (!fep->mii_bus_share)
+		pinctrl_pm_select_sleep_state(&fep->pdev->dev);
+	return ret;
+}
+
+static int
+fec_enet_open(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+
+	if (frt->enabled) {
+		return -EBUSY;
+	}
+
+	return __fec_enet_open(ndev);
+}
+
+static int
+fec_rt_open(struct rtnet_device *rtdev)
+{
+	struct fec_enet_private *fep;
+	int ret;
+
+	fep = container_of(rtdev, struct fec_enet_private, rtnet.dev);
+	ret = __fec_enet_open(fep->netdev);
+	if (ret)
+		return ret;
+
+	rt_stack_connect(rtdev, &STACK_manager);
+	rtnetif_start_queue(rtdev);
+
+	return 0;
+}
+
+static int
+fec_enet_close(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	phy_stop(ndev->phydev);
+
+	if (netif_device_present(ndev)) {
+		napi_disable(&fep->napi);
+		netif_tx_disable(ndev);
+		fec_stop(ndev);
+	}
+
+	phy_disconnect(ndev->phydev);
+	ndev->phydev = NULL;
+
+	if (fep->quirks & FEC_QUIRK_ERR006687)
+		imx6q_cpuidle_fec_irqs_unused();
+
+	fec_enet_update_ethtool_stats(ndev);
+
+	fec_enet_clk_enable(ndev, false);
+	if (fep->quirks & FEC_QUIRK_HAS_PMQOS)
+		pm_qos_remove_request(&fep->pm_qos_req);
+	if (!fep->mii_bus_share)
+		pinctrl_pm_select_sleep_state(&fep->pdev->dev);
+	pm_runtime_mark_last_busy(&fep->pdev->dev);
+	pm_runtime_put_autosuspend(&fep->pdev->dev);
+
+	fec_enet_free_buffers(ndev);
+
+	return 0;
+}
+
+static int
+fec_rt_close(struct rtnet_device *rtdev)
+{
+	struct fec_enet_private *fep;
+
+	fep = container_of(rtdev, struct fec_enet_private, rtnet.dev);
+	rtnetif_stop_queue(rtdev);
+	rtnetif_carrier_off(rtdev);
+	rt_stack_disconnect(rtdev);
+
+	return fec_enet_close(fep->netdev);
+}
+
+/* Set or clear the multicast filter for this adaptor.
+ * Skeleton taken from sunlance driver.
+ * The CPM Ethernet implementation allows Multicast as well as individual
+ * MAC address filtering.  Some of the drivers check to make sure it is
+ * a group multicast address, and discard those that are not.  I guess I
+ * will do the same for now, but just remove the test if you want
+ * individual filtering as well (do the upper net layers want or support
+ * this kind of feature?).
+ */
+
+#define FEC_HASH_BITS	6		/* #bits in hash */
+#define CRC32_POLY	0xEDB88320
+
+static void set_multicast_list(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct netdev_hw_addr *ha;
+	unsigned int crc, tmp;
+	unsigned char hash;
+	unsigned int hash_high = 0, hash_low = 0;
+
+	if (ndev->flags & IFF_PROMISC) {
+		tmp = readl(fep->hwp + FEC_R_CNTRL);
+		tmp |= 0x8;
+		writel(tmp, fep->hwp + FEC_R_CNTRL);
+		return;
+	}
+
+	tmp = readl(fep->hwp + FEC_R_CNTRL);
+	tmp &= ~0x8;
+	writel(tmp, fep->hwp + FEC_R_CNTRL);
+
+	if (ndev->flags & IFF_ALLMULTI) {
+		/* Catch all multicast addresses, so set the
+		 * filter to all 1's
+		 */
+		writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
+		writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
+
+		return;
+	}
+
+	/* Add the addresses in hash register */
+	netdev_for_each_mc_addr(ha, ndev) {
+		/* calculate crc32 value of mac address */
+		crc = ether_crc_le(ndev->addr_len, ha->addr);
+
+		/* only upper 6 bits (FEC_HASH_BITS) are used
+		 * which point to specific bit in the hash registers
+		 */
+		hash = (crc >> (32 - FEC_HASH_BITS)) & 0x3f;
+
+		if (hash > 31)
+			hash_high |= 1 << (hash - 32);
+		else
+			hash_low |= 1 << hash;
+	}
+
+	writel(hash_high, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
+	writel(hash_low, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
+}
+
+/* Set a MAC change in hardware. */
+static int
+fec_set_mac_address(struct net_device *ndev, void *p)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct sockaddr *addr = p;
+
+	if (addr) {
+		if (!is_valid_ether_addr(addr->sa_data))
+			return -EADDRNOTAVAIL;
+		memcpy(ndev->dev_addr, addr->sa_data, ndev->addr_len);
+	}
+
+	/* Add netif status check here to avoid system hang in below case:
+	 * ifconfig ethx down; ifconfig ethx hw ether xx:xx:xx:xx:xx:xx;
+	 * After ethx down, fec all clocks are gated off and then register
+	 * access causes system hang.
+	 */
+	if (!if_running(ndev))
+		return 0;
+
+	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
+		(ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
+		fep->hwp + FEC_ADDR_LOW);
+	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
+		fep->hwp + FEC_ADDR_HIGH);
+	return 0;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/**
+ * fec_poll_controller - FEC Poll controller function
+ * @dev: The FEC network adapter
+ *
+ * Polled functionality used by netconsole and others in non interrupt mode
+ *
+ */
+static void fec_poll_controller(struct net_device *dev)
+{
+	int i;
+	struct fec_enet_private *fep = netdev_priv(dev);
+
+	for (i = 0; i < FEC_IRQ_NUM; i++) {
+		if (fep->irq[i] > 0) {
+			disable_irq(fep->irq[i]);
+			fec_enet_interrupt(fep->irq[i], dev);
+			enable_irq(fep->irq[i]);
+		}
+	}
+}
+#endif
+
+static inline void fec_enet_set_netdev_features(struct net_device *netdev,
+	netdev_features_t features)
+{
+	struct fec_enet_private *fep = netdev_priv(netdev);
+	netdev_features_t changed = features ^ netdev->features;
+
+	netdev->features = features;
+
+	/* Receive checksum has been changed */
+	if (changed & NETIF_F_RXCSUM) {
+		if (features & NETIF_F_RXCSUM)
+			fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
+		else
+			fep->csum_flags &= ~FLAG_RX_CSUM_ENABLED;
+	}
+}
+
+static int fec_set_features(struct net_device *netdev,
+	netdev_features_t features)
+{
+	netdev_features_t changed = features ^ netdev->features;
+
+	if (if_running(netdev) && changed & NETIF_F_RXCSUM) {
+		if_lock(netdev);
+		fec_stop(netdev);
+		fec_enet_set_netdev_features(netdev, features);
+		fec_restart(netdev);
+		if_wake_unlock(netdev, true);
+	} else {
+		fec_enet_set_netdev_features(netdev, features);
+	}
+
+	return 0;
+}
+
+u16 fec_enet_get_raw_vlan_tci(struct sk_buff *skb)
+{
+	struct vlan_ethhdr *vhdr;
+	unsigned short vlan_TCI = 0;
+
+	if (skb->protocol == ntohs(ETH_P_ALL)) {
+		vhdr = (struct vlan_ethhdr *)(skb->data);
+		vlan_TCI = ntohs(vhdr->h_vlan_TCI);
+	}
+
+	return vlan_TCI;
+}
+
+u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
+			  struct net_device *sb_dev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	const struct platform_device_id *id_entry =
+			platform_get_device_id(fep->pdev);
+	u16 vlan_tag;
+
+	if (!(id_entry->driver_data & FEC_QUIRK_HAS_AVB))
+		return netdev_pick_tx(ndev, skb, NULL);
+
+	vlan_tag = fec_enet_get_raw_vlan_tci(skb);
+	if (!vlan_tag)
+		return vlan_tag;
+
+	return  fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
+}
+
+static const struct net_device_ops fec_netdev_ops = {
+	.ndo_open		= fec_enet_open,
+	.ndo_stop		= fec_enet_close,
+	.ndo_start_xmit		= fec_enet_start_xmit,
+	.ndo_select_queue       = fec_enet_select_queue,
+	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_tx_timeout		= fec_timeout,
+	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_do_ioctl		= fec_enet_ioctl,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= fec_poll_controller,
+#endif
+	.ndo_set_features	= fec_set_features,
+};
+
+static const unsigned short offset_des_active_rxq[] = {
+	FEC_R_DES_ACTIVE_0, FEC_R_DES_ACTIVE_1, FEC_R_DES_ACTIVE_2
+};
+
+static const unsigned short offset_des_active_txq[] = {
+	FEC_X_DES_ACTIVE_0, FEC_X_DES_ACTIVE_1, FEC_X_DES_ACTIVE_2
+};
+
+ /*
+  * XXX:  We need to clean up on failure exits here.
+  *
+  */
+static int fec_enet_init(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct bufdesc *cbd_base;
+	dma_addr_t bd_dma;
+	int bd_size;
+	unsigned int i;
+	unsigned dsize = fep->bufdesc_ex ? sizeof(struct bufdesc_ex) :
+			sizeof(struct bufdesc);
+	unsigned dsize_log2 = __fls(dsize);
+	int ret;
+
+	WARN_ON(dsize != (1 << dsize_log2));
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+	fep->rx_align = 0xf;
+	fep->tx_align = 0xf;
+#else
+	fep->rx_align = 0x3;
+	fep->tx_align = 0x3;
+#endif
+
+	/* Check mask of the streaming and coherent API */
+	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		dev_warn(&fep->pdev->dev, "No suitable DMA available\n");
+		return ret;
+	}
+
+	ret = fec_enet_alloc_queue(ndev);
+	if (ret)
+		return ret;
+
+	bd_size = (fep->total_tx_ring_size + fep->total_rx_ring_size) * dsize;
+
+	/* Allocate memory for buffer descriptors. */
+	cbd_base = dmam_alloc_coherent(&fep->pdev->dev, bd_size, &bd_dma,
+				       GFP_KERNEL);
+	if (!cbd_base) {
+		ret = -ENOMEM;
+		goto free_queue_mem;
+	}
+
+	/* Get the Ethernet address */
+	ret = fec_get_mac(ndev);
+	if (ret)
+		goto free_queue_mem;
+
+	/* make sure MAC we just acquired is programmed into the hw */
+	fec_set_mac_address(ndev, NULL);
+
+	if (frt->enabled)
+		memcpy(&frt->dev.dev_addr, ndev->dev_addr, ETH_ALEN);
+
+	/* Set receive and transmit descriptor base. */
+	for (i = 0; i < fep->num_rx_queues; i++) {
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[i];
+		unsigned size = dsize * rxq->bd.ring_size;
+
+		rxq->bd.qid = i;
+		rxq->bd.base = cbd_base;
+		rxq->bd.cur = cbd_base;
+		rxq->bd.dma = bd_dma;
+		rxq->bd.dsize = dsize;
+		rxq->bd.dsize_log2 = dsize_log2;
+		rxq->bd.reg_desc_active = fep->hwp + offset_des_active_rxq[i];
+		bd_dma += size;
+		cbd_base = (struct bufdesc *)(((void *)cbd_base) + size);
+		rxq->bd.last = (struct bufdesc *)(((void *)cbd_base) - dsize);
+	}
+
+	for (i = 0; i < fep->num_tx_queues; i++) {
+		struct fec_enet_priv_tx_q *txq = fep->tx_queue[i];
+		unsigned size = dsize * txq->bd.ring_size;
+
+		txq->bd.qid = i;
+		txq->bd.base = cbd_base;
+		txq->bd.cur = cbd_base;
+		txq->bd.dma = bd_dma;
+		txq->bd.dsize = dsize;
+		txq->bd.dsize_log2 = dsize_log2;
+		txq->bd.reg_desc_active = fep->hwp + offset_des_active_txq[i];
+		bd_dma += size;
+		cbd_base = (struct bufdesc *)(((void *)cbd_base) + size);
+		txq->bd.last = (struct bufdesc *)(((void *)cbd_base) - dsize);
+	}
+
+
+	/* The FEC Ethernet specific entries in the device structure */
+	ndev->watchdog_timeo = TX_TIMEOUT;
+	ndev->netdev_ops = &fec_netdev_ops;
+	ndev->ethtool_ops = &fec_enet_ethtool_ops;
+
+	writel(FEC_RX_DISABLED_IMASK, fep->hwp + FEC_IMASK);
+	netif_napi_add(ndev, &fep->napi, fec_enet_rx_napi, NAPI_POLL_WEIGHT);
+
+	if (fep->quirks & FEC_QUIRK_HAS_VLAN)
+		/* enable hw VLAN support */
+		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (fep->quirks & FEC_QUIRK_HAS_CSUM) {
+		ndev->gso_max_segs = FEC_MAX_TSO_SEGS;
+
+		/* enable hw accelerator */
+		ndev->features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
+				| NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_TSO);
+		fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
+	}
+
+	if (fep->quirks & FEC_QUIRK_HAS_AVB) {
+		fep->tx_align = 0;
+		fep->rx_align = 0x3f;
+	}
+
+	ndev->hw_features = ndev->features;
+
+	fec_restart(ndev);
+
+	if (fep->quirks & FEC_QUIRK_MIB_CLEAR)
+		fec_enet_clear_ethtool_stats(ndev);
+	else
+		fec_enet_update_ethtool_stats(ndev);
+
+	return 0;
+
+free_queue_mem:
+	fec_enet_free_queue(ndev);
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static int fec_reset_phy(struct platform_device *pdev)
+{
+	int err, phy_reset;
+	bool active_high = false;
+	int msec = 1, phy_post_delay = 0;
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!np)
+		return 0;
+
+	err = of_property_read_u32(np, "phy-reset-duration", &msec);
+	/* A sane reset duration should not be longer than 1s */
+	if (!err && msec > 1000)
+		msec = 1;
+
+	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
+	if (phy_reset == -EPROBE_DEFER)
+		return phy_reset;
+	else if (!gpio_is_valid(phy_reset))
+		return 0;
+
+	err = of_property_read_u32(np, "phy-reset-post-delay", &phy_post_delay);
+	/* valid reset duration should be less than 1s */
+	if (!err && phy_post_delay > 1000)
+		return -EINVAL;
+
+	active_high = of_property_read_bool(np, "phy-reset-active-high");
+
+	err = devm_gpio_request_one(&pdev->dev, phy_reset,
+			active_high ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
+			"phy-reset");
+	if (err) {
+		dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
+		return err;
+	}
+
+	if (msec > 20)
+		msleep(msec);
+	else
+		usleep_range(msec * 1000, msec * 1000 + 1000);
+
+	gpio_set_value_cansleep(phy_reset, !active_high);
+
+	if (!phy_post_delay)
+		return 0;
+
+	if (phy_post_delay > 20)
+		msleep(phy_post_delay);
+	else
+		usleep_range(phy_post_delay * 1000,
+			     phy_post_delay * 1000 + 1000);
+
+	return 0;
+}
+#else /* CONFIG_OF */
+static int fec_reset_phy(struct platform_device *pdev)
+{
+	/*
+	 * In case of platform probe, the reset has been done
+	 * by machine code.
+	 */
+	return 0;
+}
+#endif /* CONFIG_OF */
+
+static void
+fec_enet_get_queue_num(struct platform_device *pdev, int *num_tx, int *num_rx)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	*num_tx = *num_rx = 1;
+
+	if (!np || !of_device_is_available(np))
+		return;
+
+	/* parse the num of tx and rx queues */
+	of_property_read_u32(np, "fsl,num-tx-queues", num_tx);
+
+	of_property_read_u32(np, "fsl,num-rx-queues", num_rx);
+
+	if (*num_tx < 1 || *num_tx > FEC_ENET_MAX_TX_QS) {
+		dev_warn(&pdev->dev, "Invalid num_tx(=%d), fall back to 1\n",
+			 *num_tx);
+		*num_tx = 1;
+		return;
+	}
+
+	if (*num_rx < 1 || *num_rx > FEC_ENET_MAX_RX_QS) {
+		dev_warn(&pdev->dev, "Invalid num_rx(=%d), fall back to 1\n",
+			 *num_rx);
+		*num_rx = 1;
+		return;
+	}
+
+}
+
+static int fec_enet_get_irq_cnt(struct platform_device *pdev)
+{
+	int irq_cnt = platform_irq_count(pdev);
+
+	if (irq_cnt > FEC_IRQ_NUM)
+		irq_cnt = FEC_IRQ_NUM;	/* last for pps */
+	else if (irq_cnt == 2)
+		irq_cnt = 1;	/* last for pps */
+	else if (irq_cnt <= 0)
+		irq_cnt = 1;	/* At least 1 irq is needed */
+	return irq_cnt;
+}
+
+static void fec_enet_of_parse_stop_mode(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct fec_enet_private *fep = netdev_priv(dev);
+	struct device_node *node;
+	phandle phandle;
+	u32 out_val[3];
+	int ret;
+
+	ret = of_property_read_u32_array(np, "stop-mode", out_val, 3);
+	if (ret) {
+		dev_dbg(&pdev->dev, "no stop-mode property\n");
+		return;
+	}
+
+	phandle = *out_val;
+	node = of_find_node_by_phandle(phandle);
+	if (!node) {
+		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
+		return;
+	}
+
+	fep->lpm.gpr = syscon_node_to_regmap(node);
+	if (IS_ERR(fep->lpm.gpr)) {
+		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
+		return;
+	}
+
+	of_node_put(node);
+
+	fep->lpm.req_gpr = out_val[1];
+	fep->lpm.req_bit = out_val[2];
+}
+
+static int fec_rt_init(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct rtnet_device *rtdev = &frt->dev;
+	int ret;
+
+	rtdev->open = fec_rt_open;
+	rtdev->stop = fec_rt_close;
+	rtdev->do_ioctl = fec_rt_ioctl;
+	rtdev->hard_start_xmit = fec_rt_start_xmit;
+	rtdev->get_stats = fec_rt_stats;
+	rtdev->sysbind = &fep->pdev->dev;
+
+	ret = rt_init_etherdev(rtdev, (RX_RING_SIZE + TX_RING_SIZE) * 2);
+	if (ret)
+		return ret;
+
+	rt_rtdev_connect(rtdev, &RTDEV_manager);
+	rtdev->vers = RTDEV_VERS_2_0;
+	rtdm_lock_init(&frt->lock);
+	rtdm_nrtsig_init(&frt->mdio_sig, fec_enet_mdio_done, fep);
+	
+	ret = rt_register_rtnetdev(rtdev);
+	if (ret) {
+		rt_rtdev_disconnect(rtdev);
+		return ret;
+	}
+
+	rtnetif_carrier_off(rtdev);
+	frt->enabled = true;
+
+	return 0;
+}
+
+static void fec_rt_destroy(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_rt_data *frt = &fep->rtnet;
+	struct rtnet_device *rtdev = &frt->dev;
+	int i;
+
+	for (i = 0; i < fep->irqnr; i++)
+		rtdm_irq_free(&frt->irq_handle[i]);
+	
+	rtdm_nrtsig_destroy(&frt->mdio_sig);
+	rt_rtdev_disconnect(rtdev);
+	rt_unregister_rtnetdev(rtdev);
+	rtdev_destroy(rtdev);
+	frt->enabled = false;
+}
+
+static int
+fec_probe(struct platform_device *pdev)
+{
+	struct fec_enet_private *fep;
+	struct fec_platform_data *pdata;
+	struct net_device *ndev;
+	int i, irq, ret = 0, eth_id;
+	const struct of_device_id *of_id;
+	static int dev_id;
+	struct device_node *np = pdev->dev.of_node, *phy_node;
+	int num_tx_qs;
+	int num_rx_qs;
+	char irq_name[8];
+	int irq_cnt;
+	bool rtnet;
+
+	printk(XENO_INFO "RT FEC: probe with RX_RING_SIZE %lu and TX_RING_SIZE %d\n", RX_RING_SIZE, TX_RING_SIZE);
+
+	fec_enet_get_queue_num(pdev, &num_tx_qs, &num_rx_qs);
+
+	/* Init network device */
+	ndev = alloc_etherdev_mqs(sizeof(struct fec_enet_private) +
+				  FEC_STATS_SIZE, num_tx_qs, num_rx_qs);
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	/* setup board info structure */
+	fep = netdev_priv(ndev);
+	memset(fep, 0, sizeof(*fep));
+	fep->pdev = pdev;
+
+	rtnet = !(rtnet_disabled || of_property_read_bool(np, "rtnet-disabled"));
+	if (rtnet) {
+		ret = fec_rt_init(ndev);
+		if (ret)
+			goto failed_rt_init;
+	}
+
+	of_id = of_match_device(fec_dt_ids, &pdev->dev);
+	if (of_id)
+		pdev->id_entry = of_id->data;
+	fep->quirks = pdev->id_entry->driver_data;
+
+	fep->netdev = ndev;
+	fep->num_rx_queues = num_rx_qs;
+	fep->num_tx_queues = num_tx_qs;
+
+#if !defined(CONFIG_M5272)
+	/* default enable pause frame auto negotiation */
+	if (fep->quirks & FEC_QUIRK_HAS_GBIT)
+		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
+#endif
+
+	/* Select default pin state */
+	pinctrl_pm_select_default_state(&pdev->dev);
+
+	fep->hwp = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(fep->hwp)) {
+		ret = PTR_ERR(fep->hwp);
+		goto failed_ioremap;
+	}
+
+	fep->pdev = pdev;
+	fep->dev_id = dev_id++;
+
+	platform_set_drvdata(pdev, ndev);
+
+	if ((of_machine_is_compatible("fsl,imx6q") ||
+	     of_machine_is_compatible("fsl,imx6dl")||
+            of_machine_is_compatible("fsl,imx8mq") ||
+            of_machine_is_compatible("fsl,imx8qm")) &&
+	    !of_property_read_bool(np, "fsl,err006687-workaround-present"))
+		fep->quirks |= FEC_QUIRK_ERR006687;
+
+	fec_enet_of_parse_stop_mode(pdev);
+	ret = fec_enet_ipc_handle_init(fep);
+	if (ret)
+		goto failed_ipc_init;
+
+	if (of_get_property(np, "fsl,magic-packet", NULL))
+		fep->wol_flag |= FEC_WOL_HAS_MAGIC_PACKET;
+
+	if (of_get_property(np, "fsl,rgmii_txc_dly", NULL))
+		fep->rgmii_txc_dly = true;
+
+	if (of_get_property(np, "fsl,rgmii_rxc_dly", NULL))
+		fep->rgmii_rxc_dly = true;
+
+	phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (!phy_node && of_phy_is_fixed_link(np)) {
+		ret = of_phy_register_fixed_link(np);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"broken fixed-link specification\n");
+			goto failed_phy;
+		}
+		phy_node = of_node_get(np);
+	}
+	fep->phy_node = phy_node;
+
+	ret = of_get_phy_mode(pdev->dev.of_node);
+	if (ret < 0) {
+		pdata = dev_get_platdata(&pdev->dev);
+		if (pdata)
+			fep->phy_interface = pdata->phy;
+		else
+			fep->phy_interface = PHY_INTERFACE_MODE_MII;
+	} else {
+		fep->phy_interface = ret;
+	}
+
+	request_bus_freq(BUS_FREQ_HIGH);
+
+	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fep->clk_ipg)) {
+		ret = PTR_ERR(fep->clk_ipg);
+		goto failed_clk;
+	}
+
+	fep->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(fep->clk_ahb)) {
+		ret = PTR_ERR(fep->clk_ahb);
+		goto failed_clk;
+	}
+
+	fep->itr_clk_rate = clk_get_rate(fep->clk_ahb);
+
+	/* enet_out is optional, depends on board */
+	fep->clk_enet_out = devm_clk_get(&pdev->dev, "enet_out");
+	if (IS_ERR(fep->clk_enet_out))
+		fep->clk_enet_out = NULL;
+
+	/*
+	 * We keep the companion PTP driver enabled even when
+	 * operating the NIC in rt mode. The PHC is still available,
+	 * although not providing rt guarantees.
+	 */
+	fep->ptp_clk_on = false;
+	mutex_init(&fep->ptp_clk_mutex);
+
+	/* clk_ref is optional, depends on board */
+	fep->clk_ref = devm_clk_get(&pdev->dev, "enet_clk_ref");
+	if (IS_ERR(fep->clk_ref))
+		fep->clk_ref = NULL;
+	fep->clk_ref_rate = clk_get_rate(fep->clk_ref);
+
+	/* clk_2x_txclk is optional, depends on board */
+	fep->clk_2x_txclk = devm_clk_get(&pdev->dev, "enet_2x_txclk");
+	if (IS_ERR(fep->clk_2x_txclk))
+		fep->clk_2x_txclk = NULL;
+
+	fep->bufdesc_ex = fep->quirks & FEC_QUIRK_HAS_BUFDESC_EX;
+	fep->clk_ptp = devm_clk_get(&pdev->dev, "ptp");
+	if (IS_ERR(fep->clk_ptp)) {
+		fep->clk_ptp = NULL;
+		fep->bufdesc_ex = false;
+	}
+
+	ret = fec_enet_clk_enable(ndev, true);
+	if (ret)
+		goto failed_clk;
+
+	ret = clk_prepare_enable(fep->clk_ipg);
+	if (ret)
+		goto failed_clk_ipg;
+	ret = clk_prepare_enable(fep->clk_ahb);
+	if (ret)
+		goto failed_clk_ahb;
+
+	fep->reg_phy = devm_regulator_get_optional(&pdev->dev, "phy");
+	if (!IS_ERR(fep->reg_phy)) {
+		ret = regulator_enable(fep->reg_phy);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable phy regulator: %d\n", ret);
+			goto failed_regulator;
+		}
+	} else {
+		if (PTR_ERR(fep->reg_phy) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto failed_regulator;
+		}
+		fep->reg_phy = NULL;
+	}
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, FEC_MDIO_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = fec_reset_phy(pdev);
+	if (ret)
+		goto failed_reset;
+
+	irq_cnt = fec_enet_get_irq_cnt(pdev);
+	if (fep->bufdesc_ex)
+		fec_ptp_init(pdev, irq_cnt);
+
+	ret = fec_enet_init(ndev);
+	if (ret)
+		goto failed_init;
+
+	for (i = 0; i < irq_cnt; i++) {
+		snprintf(irq_name, sizeof(irq_name), "int%d", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq < 0)
+			irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			ret = irq;
+			goto failed_irq;
+		}
+		if (rtnet)
+			ret = rtdm_irq_request(&fep->rtnet.irq_handle[i], irq,
+					       fec_rt_interrupt, 0, ndev->name, ndev);
+		else
+			ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
+					       0, pdev->name, ndev);
+		if (ret)
+			goto failed_irq;
+
+		fep->irq[i] = irq;
+		fep->irqnr++;
+	}
+
+	/* get wake up irq */
+	ret = of_property_read_u32(np, "fsl,wakeup_irq", &irq);
+	if (!ret && irq < irq_cnt)
+		fep->wake_irq = fep->irq[irq];
+	else
+		fep->wake_irq = fep->irq[0];
+
+	init_completion(&fep->mdio_done);
+	/* board only enable one mii bus in default */
+	if (!of_get_property(np, "fsl,mii-exclusive", NULL))
+		fep->quirks |= FEC_QUIRK_SINGLE_MDIO;
+	ret = fec_enet_mii_init(pdev);
+	if (ret)
+		goto failed_mii_init;
+
+	/* Carrier starts down, phylib will bring it up */
+	netif_carrier_off(ndev);
+	fec_enet_clk_enable(ndev, false);
+	pinctrl_pm_select_sleep_state(&pdev->dev);
+
+	eth_id = of_alias_get_id(pdev->dev.of_node, "ethernet");
+	if (rtnet && eth_id >= 0)
+		sprintf(ndev->name, "rteth%d", eth_id);
+
+	ret = register_netdev(ndev);
+	if (ret)
+		goto failed_register;
+
+	device_init_wakeup(&ndev->dev, fep->wol_flag &
+			   FEC_WOL_HAS_MAGIC_PACKET);
+
+	if (fep->bufdesc_ex && fep->ptp_clock)
+		netdev_info(ndev, "registered PHC device %d\n", fep->dev_id);
+
+	fep->rx_copybreak = COPYBREAK_DEFAULT;
+	INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	return 0;
+
+failed_register:
+	fec_enet_mii_remove(fep);
+failed_mii_init:
+failed_irq:
+	if (rtnet)
+		for (i = 0; i < fep->irqnr; i++)
+			rtdm_irq_free(&fep->rtnet.irq_handle[i]);
+failed_init:
+	fec_ptp_stop(pdev);
+failed_reset:
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	if (fep->reg_phy)
+		regulator_disable(fep->reg_phy);
+failed_regulator:
+	clk_disable_unprepare(fep->clk_ahb);
+failed_clk_ahb:
+	clk_disable_unprepare(fep->clk_ipg);
+failed_clk_ipg:
+	fec_enet_clk_enable(ndev, false);
+failed_clk:
+	release_bus_freq(BUS_FREQ_HIGH);
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
+	of_node_put(phy_node);
+failed_ipc_init:
+failed_phy:
+	dev_id--;
+failed_ioremap:
+	if (rtnet)
+		fec_rt_destroy(ndev);
+failed_rt_init:
+	free_netdev(ndev);
+
+	return ret;
+}
+
+static int
+fec_drv_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct device_node *np = pdev->dev.of_node;
+	struct fec_rt_data *frt = &fep->rtnet;
+	int ret;
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		return ret;
+
+	cancel_work_sync(&fep->tx_timeout_work);
+	fec_ptp_stop(pdev);
+	if (frt->enabled)
+		fec_rt_destroy(ndev);
+	unregister_netdev(ndev);
+	fec_enet_mii_remove(fep);
+	if (fep->reg_phy)
+		regulator_disable(fep->reg_phy);
+
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
+	of_node_put(fep->phy_node);
+	free_netdev(ndev);
+
+	clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ipg);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused fec_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	rtnl_lock();
+	if (if_running(ndev)) {
+		int ret;
+
+		if (fep->wol_flag & FEC_WOL_FLAG_ENABLE)
+			fep->wol_flag |= FEC_WOL_FLAG_SLEEP_ON;
+		phy_stop(ndev->phydev);
+		if_lock(ndev);
+		netif_device_detach(ndev);
+		if_tx_unlock(ndev);
+		fec_stop(ndev);
+		if (!(fep->wol_flag & FEC_WOL_FLAG_ENABLE)) {
+			fec_irqs_disable(ndev);
+			pinctrl_pm_select_sleep_state(&fep->pdev->dev);
+		} else {
+			fec_enet_enter_stop_mode(fep);
+			disable_irq(fep->wake_irq);
+			enable_irq_wake(fep->wake_irq);
+		}
+		fec_enet_clk_enable(ndev, false);
+
+		fep->rpm_active = !pm_runtime_status_suspended(dev);
+		if (fep->rpm_active) {
+			ret = pm_runtime_force_suspend(dev);
+			if (ret < 0)
+				return ret;
+		}
+	} else if (fep->mii_bus_share && !ndev->phydev) {
+		pinctrl_pm_select_sleep_state(&fep->pdev->dev);
+	}
+	rtnl_unlock();
+
+	if (fep->reg_phy && !(fep->wol_flag & FEC_WOL_FLAG_ENABLE))
+		regulator_disable(fep->reg_phy);
+
+	/* SOC supply clock to phy, when clock is disabled, phy link down
+	 * SOC control phy regulator, when regulator is disabled, phy link down
+	 */
+	if (fep->clk_enet_out || fep->reg_phy)
+		fep->link = 0;
+
+	return 0;
+}
+
+static int __maybe_unused fec_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int ret = 0;
+	int val;
+
+	if (fep->reg_phy && !(fep->wol_flag & FEC_WOL_FLAG_ENABLE)) {
+		ret = regulator_enable(fep->reg_phy);
+		if (ret)
+			return ret;
+	}
+
+	rtnl_lock();
+	if (if_running(ndev)) {
+		if (fep->rpm_active)
+			pm_runtime_force_resume(dev);
+
+		ret = fec_enet_clk_enable(ndev, true);
+		if (ret) {
+			rtnl_unlock();
+			goto failed_clk;
+		}
+		if (fep->wol_flag & FEC_WOL_FLAG_ENABLE) {
+			disable_irq_wake(fep->wake_irq);
+			fec_enet_exit_stop_mode(fep);
+			enable_irq(fep->wake_irq);
+			val = readl(fep->hwp + FEC_ECNTRL);
+			val &= ~(FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
+			writel(val, fep->hwp + FEC_ECNTRL);
+			fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
+		} else {
+			pinctrl_pm_select_default_state(&fep->pdev->dev);
+		}
+		fec_restart(ndev);
+		if_tx_lock(ndev);
+		netif_device_attach(ndev);
+		if_unlock(ndev);
+		phy_start(ndev->phydev);
+	} else if (fep->mii_bus_share && !ndev->phydev) {
+		pinctrl_pm_select_default_state(&fep->pdev->dev);
+		/* And then recovery mii bus */
+		ret = fec_restore_mii_bus(ndev);
+	}
+	rtnl_unlock();
+
+	return ret;
+
+failed_clk:
+	if (fep->reg_phy)
+		regulator_disable(fep->reg_phy);
+	return ret;
+}
+
+static int __maybe_unused fec_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ipg);
+	release_bus_freq(BUS_FREQ_HIGH);
+
+	return 0;
+}
+
+static int __maybe_unused fec_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int ret;
+
+	request_bus_freq(BUS_FREQ_HIGH);
+
+	ret = clk_prepare_enable(fep->clk_ahb);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(fep->clk_ipg);
+	if (ret)
+		goto failed_clk_ipg;
+
+	return 0;
+
+failed_clk_ipg:
+	clk_disable_unprepare(fep->clk_ahb);
+	release_bus_freq(BUS_FREQ_HIGH);
+	return ret;
+}
+
+static const struct dev_pm_ops fec_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fec_suspend, fec_resume)
+	SET_RUNTIME_PM_OPS(fec_runtime_suspend, fec_runtime_resume, NULL)
+};
+
+static struct platform_driver fec_driver = {
+	.driver	= {
+		.name	= DRIVER_NAME,
+		.pm	= &fec_pm_ops,
+		.of_match_table = fec_dt_ids,
+	},
+	.id_table = fec_devtype,
+	.probe	= fec_probe,
+	.remove	= fec_drv_remove,
+};
+
+module_platform_driver(fec_driver);
+
+MODULE_ALIAS("platform:"DRIVER_NAME);
+MODULE_LICENSE("GPL");
diff --git a/kernel/drivers/net/drivers/freescale/fec_ptp.c b/kernel/drivers/net/drivers/freescale/fec_ptp.c
new file mode 100644
index 000000000..bb148e99b
--- /dev/null
+++ b/kernel/drivers/net/drivers/freescale/fec_ptp.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fast Ethernet Controller (ENET) PTP driver for MX6x.
+ *
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/phy.h>
+#include <linux/fec.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_net.h>
+
+#include "fec.h"
+
+/* FEC 1588 register bits */
+#define FEC_T_CTRL_SLAVE                0x00002000
+#define FEC_T_CTRL_CAPTURE              0x00000800
+#define FEC_T_CTRL_RESTART              0x00000200
+#define FEC_T_CTRL_PERIOD_RST           0x00000030
+#define FEC_T_CTRL_PERIOD_EN		0x00000010
+#define FEC_T_CTRL_ENABLE               0x00000001
+
+#define FEC_T_INC_MASK                  0x0000007f
+#define FEC_T_INC_OFFSET                0
+#define FEC_T_INC_CORR_MASK             0x00007f00
+#define FEC_T_INC_CORR_OFFSET           8
+
+#define FEC_T_CTRL_PINPER		0x00000080
+#define FEC_T_TF0_MASK			0x00000001
+#define FEC_T_TF0_OFFSET		0
+#define FEC_T_TF1_MASK			0x00000002
+#define FEC_T_TF1_OFFSET		1
+#define FEC_T_TF2_MASK			0x00000004
+#define FEC_T_TF2_OFFSET		2
+#define FEC_T_TF3_MASK			0x00000008
+#define FEC_T_TF3_OFFSET		3
+#define FEC_T_TDRE_MASK			0x00000001
+#define FEC_T_TDRE_OFFSET		0
+#define FEC_T_TMODE_MASK		0x0000003C
+#define FEC_T_TMODE_OFFSET		2
+#define FEC_T_TIE_MASK			0x00000040
+#define FEC_T_TIE_OFFSET		6
+#define FEC_T_TF_MASK			0x00000080
+#define FEC_T_TF_OFFSET			7
+
+#define FEC_ATIME_CTRL		0x400
+#define FEC_ATIME		0x404
+#define FEC_ATIME_EVT_OFFSET	0x408
+#define FEC_ATIME_EVT_PERIOD	0x40c
+#define FEC_ATIME_CORR		0x410
+#define FEC_ATIME_INC		0x414
+#define FEC_TS_TIMESTAMP	0x418
+
+#define FEC_TGSR		0x604
+#define FEC_TCSR(n)		(0x608 + n * 0x08)
+#define FEC_TCCR(n)		(0x60C + n * 0x08)
+#define MAX_TIMER_CHANNEL	3
+#define FEC_TMODE_TOGGLE	0x05
+#define FEC_HIGH_PULSE		0x0F
+
+#define FEC_CC_MULT	(1 << 31)
+#define FEC_COUNTER_PERIOD	(1 << 31)
+#define PPS_OUPUT_RELOAD_PERIOD	NSEC_PER_SEC
+#define FEC_CHANNLE_0		0
+#define DEFAULT_PPS_CHANNEL	FEC_CHANNLE_0
+
+/**
+ * fec_ptp_enable_pps
+ * @fep: the fec_enet_private structure handle
+ * @enable: enable the channel pps output
+ *
+ * This function enble the PPS ouput on the timer channel.
+ */
+static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
+{
+	unsigned long flags;
+	u32 val, tempval;
+	struct timespec64 ts;
+	u64 ns;
+	val = 0;
+
+	if (!(fep->hwts_tx_en || fep->hwts_rx_en)) {
+		dev_err(&fep->pdev->dev, "No ptp stack is running\n");
+		return -EINVAL;
+	}
+
+	if (fep->pps_enable == enable)
+		return 0;
+
+	fep->pps_channel = DEFAULT_PPS_CHANNEL;
+	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	if (enable) {
+		/* clear capture or output compare interrupt status if have.
+		 */
+		writel(FEC_T_TF_MASK, fep->hwp + FEC_TCSR(fep->pps_channel));
+
+		/* It is recommended to double check the TMODE field in the
+		 * TCSR register to be cleared before the first compare counter
+		 * is written into TCCR register. Just add a double check.
+		 */
+		val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
+		do {
+			val &= ~(FEC_T_TMODE_MASK);
+			writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
+			val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
+		} while (val & FEC_T_TMODE_MASK);
+
+		/* Dummy read counter to update the counter */
+		timecounter_read(&fep->tc);
+		/* We want to find the first compare event in the next
+		 * second point. So we need to know what the ptp time
+		 * is now and how many nanoseconds is ahead to get next second.
+		 * The remaining nanosecond ahead before the next second would be
+		 * NSEC_PER_SEC - ts.tv_nsec. Add the remaining nanoseconds
+		 * to current timer would be next second.
+		 */
+		tempval = readl(fep->hwp + FEC_ATIME_CTRL);
+		tempval |= FEC_T_CTRL_CAPTURE;
+		writel(tempval, fep->hwp + FEC_ATIME_CTRL);
+
+		tempval = readl(fep->hwp + FEC_ATIME);
+		/* Convert the ptp local counter to 1588 timestamp */
+		ns = timecounter_cyc2time(&fep->tc, tempval);
+		ts = ns_to_timespec64(ns);
+
+		/* The tempval is  less than 3 seconds, and  so val is less than
+		 * 4 seconds. No overflow for 32bit calculation.
+		 */
+		val = NSEC_PER_SEC - (u32)ts.tv_nsec + tempval;
+
+		/* Need to consider the situation that the current time is
+		 * very close to the second point, which means NSEC_PER_SEC
+		 * - ts.tv_nsec is close to be zero(For example 20ns); Since the timer
+		 * is still running when we calculate the first compare event, it is
+		 * possible that the remaining nanoseonds run out before the compare
+		 * counter is calculated and written into TCCR register. To avoid
+		 * this possibility, we will set the compare event to be the next
+		 * of next second. The current setting is 31-bit timer and wrap
+		 * around over 2 seconds. So it is okay to set the next of next
+		 * seond for the timer.
+		 */
+		val += NSEC_PER_SEC;
+
+		/* We add (2 * NSEC_PER_SEC - (u32)ts.tv_nsec) to current
+		 * ptp counter, which maybe cause 32-bit wrap. Since the
+		 * (NSEC_PER_SEC - (u32)ts.tv_nsec) is less than 2 second.
+		 * We can ensure the wrap will not cause issue. If the offset
+		 * is bigger than fep->cc.mask would be a error.
+		 */
+		val &= fep->cc.mask;
+		writel(val, fep->hwp + FEC_TCCR(fep->pps_channel));
+
+		/* Calculate the second the compare event timestamp */
+		fep->next_counter = (val + fep->reload_period) & fep->cc.mask;
+
+		/* * Enable compare event when overflow */
+		val = readl(fep->hwp + FEC_ATIME_CTRL);
+		val |= FEC_T_CTRL_PINPER;
+		writel(val, fep->hwp + FEC_ATIME_CTRL);
+
+		/* Compare channel setting. */
+		val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
+		val |= (1 << FEC_T_TF_OFFSET | 1 << FEC_T_TIE_OFFSET);
+		val &= ~(1 << FEC_T_TDRE_OFFSET);
+		val &= ~(FEC_T_TMODE_MASK);
+		val |= (FEC_HIGH_PULSE << FEC_T_TMODE_OFFSET);
+		writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
+
+		/* Write the second compare event timestamp and calculate
+		 * the third timestamp. Refer the TCCR register detail in the spec.
+		 */
+		writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
+		fep->next_counter = (fep->next_counter + fep->reload_period) & fep->cc.mask;
+	} else {
+		writel(0, fep->hwp + FEC_TCSR(fep->pps_channel));
+	}
+
+	fep->pps_enable = enable;
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+
+	return 0;
+}
+
+/**
+ * fec_ptp_read - read raw cycle counter (to be used by time counter)
+ * @cc: the cyclecounter structure
+ *
+ * this function reads the cyclecounter registers and is called by the
+ * cyclecounter structure used to construct a ns counter from the
+ * arbitrary fixed point registers
+ */
+static u64 fec_ptp_read(const struct cyclecounter *cc)
+{
+	struct fec_enet_private *fep =
+		container_of(cc, struct fec_enet_private, cc);
+	const struct platform_device_id *id_entry =
+		platform_get_device_id(fep->pdev);
+	u32 tempval;
+
+	tempval = readl(fep->hwp + FEC_ATIME_CTRL);
+	tempval |= FEC_T_CTRL_CAPTURE;
+	writel(tempval, fep->hwp + FEC_ATIME_CTRL);
+
+	if (id_entry->driver_data & FEC_QUIRK_BUG_CAPTURE)
+		udelay(1);
+
+	return readl(fep->hwp + FEC_ATIME);
+}
+
+/**
+ * fec_ptp_start_cyclecounter - create the cycle counter from hw
+ * @ndev: network device
+ *
+ * this function initializes the timecounter and cyclecounter
+ * structures for use in generated a ns counter from the arbitrary
+ * fixed point cycles registers in the hardware.
+ */
+void fec_ptp_start_cyclecounter(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	unsigned long flags;
+	int inc;
+
+	inc = 1000000000 / fep->cycle_speed;
+
+	/* grab the ptp lock */
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	/* 1ns counter */
+	writel(inc << FEC_T_INC_OFFSET, fep->hwp + FEC_ATIME_INC);
+
+	/* use 31-bit timer counter */
+	writel(FEC_COUNTER_PERIOD, fep->hwp + FEC_ATIME_EVT_PERIOD);
+
+	writel(FEC_T_CTRL_ENABLE | FEC_T_CTRL_PERIOD_RST,
+		fep->hwp + FEC_ATIME_CTRL);
+
+	memset(&fep->cc, 0, sizeof(fep->cc));
+	fep->cc.read = fec_ptp_read;
+	fep->cc.mask = CLOCKSOURCE_MASK(31);
+	fep->cc.shift = 31;
+	fep->cc.mult = FEC_CC_MULT;
+
+	/* reset the ns time counter */
+	timecounter_init(&fep->tc, &fep->cc, ktime_to_ns(ktime_get_real()));
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+}
+
+/**
+ * fec_ptp_adjfreq - adjust ptp cycle frequency
+ * @ptp: the ptp clock structure
+ * @ppb: parts per billion adjustment from base
+ *
+ * Adjust the frequency of the ptp cycle counter by the
+ * indicated ppb from the base frequency.
+ *
+ * Because ENET hardware frequency adjust is complex,
+ * using software method to do that.
+ */
+static int fec_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
+{
+	unsigned long flags;
+	int neg_adj = 0;
+	u32 i, tmp;
+	u32 corr_inc, corr_period;
+	u32 corr_ns;
+	u64 lhs, rhs;
+
+	struct fec_enet_private *fep =
+	    container_of(ptp, struct fec_enet_private, ptp_caps);
+
+	if (ppb == 0)
+		return 0;
+
+	if (ppb < 0) {
+		ppb = -ppb;
+		neg_adj = 1;
+	}
+
+	/* In theory, corr_inc/corr_period = ppb/NSEC_PER_SEC;
+	 * Try to find the corr_inc  between 1 to fep->ptp_inc to
+	 * meet adjustment requirement.
+	 */
+	lhs = NSEC_PER_SEC;
+	rhs = (u64)ppb * (u64)fep->ptp_inc;
+	for (i = 1; i <= fep->ptp_inc; i++) {
+		if (lhs >= rhs) {
+			corr_inc = i;
+			corr_period = div_u64(lhs, rhs);
+			break;
+		}
+		lhs += NSEC_PER_SEC;
+	}
+	/* Not found? Set it to high value - double speed
+	 * correct in every clock step.
+	 */
+	if (i > fep->ptp_inc) {
+		corr_inc = fep->ptp_inc;
+		corr_period = 1;
+	}
+
+	if (neg_adj)
+		corr_ns = fep->ptp_inc - corr_inc;
+	else
+		corr_ns = fep->ptp_inc + corr_inc;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	tmp = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
+	tmp |= corr_ns << FEC_T_INC_CORR_OFFSET;
+	writel(tmp, fep->hwp + FEC_ATIME_INC);
+	corr_period = corr_period > 1 ? corr_period - 1 : corr_period;
+	writel(corr_period, fep->hwp + FEC_ATIME_CORR);
+	/* dummy read to update the timer. */
+	timecounter_read(&fep->tc);
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+
+	return 0;
+}
+
+/**
+ * fec_ptp_adjtime
+ * @ptp: the ptp clock structure
+ * @delta: offset to adjust the cycle counter by
+ *
+ * adjust the timer by resetting the timecounter structure.
+ */
+static int fec_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct fec_enet_private *fep =
+	    container_of(ptp, struct fec_enet_private, ptp_caps);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	timecounter_adjtime(&fep->tc, delta);
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+
+	return 0;
+}
+
+/**
+ * fec_ptp_gettime
+ * @ptp: the ptp clock structure
+ * @ts: timespec structure to hold the current time value
+ *
+ * read the timecounter and return the correct value on ns,
+ * after converting it into a struct timespec.
+ */
+static int fec_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
+{
+	struct fec_enet_private *adapter =
+	    container_of(ptp, struct fec_enet_private, ptp_caps);
+	u64 ns;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->tmreg_lock, flags);
+	ns = timecounter_read(&adapter->tc);
+	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+/**
+ * fec_ptp_settime
+ * @ptp: the ptp clock structure
+ * @ts: the timespec containing the new time for the cycle counter
+ *
+ * reset the timecounter to use a new base value instead of the kernel
+ * wall timer value.
+ */
+static int fec_ptp_settime(struct ptp_clock_info *ptp,
+			   const struct timespec64 *ts)
+{
+	struct fec_enet_private *fep =
+	    container_of(ptp, struct fec_enet_private, ptp_caps);
+
+	u64 ns;
+	unsigned long flags;
+	u32 counter;
+
+	mutex_lock(&fep->ptp_clk_mutex);
+	/* Check the ptp clock */
+	if (!fep->ptp_clk_on) {
+		mutex_unlock(&fep->ptp_clk_mutex);
+		return -EINVAL;
+	}
+
+	ns = timespec64_to_ns(ts);
+	/* Get the timer value based on timestamp.
+	 * Update the counter with the masked value.
+	 */
+	counter = ns & fep->cc.mask;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	writel(counter, fep->hwp + FEC_ATIME);
+	timecounter_init(&fep->tc, &fep->cc, ns);
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	mutex_unlock(&fep->ptp_clk_mutex);
+	return 0;
+}
+
+/**
+ * fec_ptp_enable
+ * @ptp: the ptp clock structure
+ * @rq: the requested feature to change
+ * @on: whether to enable or disable the feature
+ *
+ */
+static int fec_ptp_enable(struct ptp_clock_info *ptp,
+			  struct ptp_clock_request *rq, int on)
+{
+	struct fec_enet_private *fep =
+	    container_of(ptp, struct fec_enet_private, ptp_caps);
+	int ret = 0;
+
+	if (rq->type == PTP_CLK_REQ_PPS) {
+		ret = fec_ptp_enable_pps(fep, on);
+
+		return ret;
+	}
+	return -EOPNOTSUPP;
+}
+
+int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	struct hwtstamp_config config;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	/* reserved for future extensions */
+	if (config.flags)
+		return -EINVAL;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		fep->hwts_tx_en = 0;
+		break;
+	case HWTSTAMP_TX_ON:
+		fep->hwts_tx_en = 1;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		if (fep->hwts_rx_en)
+			fep->hwts_rx_en = 0;
+		config.rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+
+	default:
+		fep->hwts_rx_en = 1;
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	}
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+	    -EFAULT : 0;
+}
+
+int fec_ptp_get(struct net_device *ndev, struct ifreq *ifr)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct hwtstamp_config config;
+
+	config.flags = 0;
+	config.tx_type = fep->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	config.rx_filter = (fep->hwts_rx_en ?
+			    HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE);
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+		-EFAULT : 0;
+}
+
+/**
+ * fec_time_keep - call timecounter_read every second to avoid timer overrun
+ *                 because ENET just support 32bit counter, will timeout in 4s
+ */
+static void fec_time_keep(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct fec_enet_private *fep = container_of(dwork, struct fec_enet_private, time_keep);
+	u64 ns;
+	unsigned long flags;
+
+	mutex_lock(&fep->ptp_clk_mutex);
+	if (fep->ptp_clk_on) {
+		spin_lock_irqsave(&fep->tmreg_lock, flags);
+		ns = timecounter_read(&fep->tc);
+		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	}
+	mutex_unlock(&fep->ptp_clk_mutex);
+
+	schedule_delayed_work(&fep->time_keep, HZ);
+}
+
+/* This function checks the pps event and reloads the timer compare counter. */
+static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
+{
+	struct net_device *ndev = dev_id;
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	u32 val;
+	u8 channel = fep->pps_channel;
+	struct ptp_clock_event event;
+
+	val = readl(fep->hwp + FEC_TCSR(channel));
+	if (val & FEC_T_TF_MASK) {
+		/* Write the next next compare(not the next according the spec)
+		 * value to the register
+		 */
+		writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
+		do {
+			writel(val, fep->hwp + FEC_TCSR(channel));
+		} while (readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);
+
+		/* Update the counter; */
+		fep->next_counter = (fep->next_counter + fep->reload_period) &
+				fep->cc.mask;
+
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(fep->ptp_clock, &event);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/**
+ * fec_ptp_init
+ * @ndev: The FEC network adapter
+ *
+ * This function performs the required steps for enabling ptp
+ * support. If ptp support has already been loaded it simply calls the
+ * cyclecounter init routine and exits.
+ */
+
+void fec_ptp_init(struct platform_device *pdev, int irq_idx)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int irq;
+	int ret;
+
+	fep->ptp_caps.owner = THIS_MODULE;
+	snprintf(fep->ptp_caps.name, 16, "fec ptp");
+
+	fep->ptp_caps.max_adj = 250000000;
+	fep->ptp_caps.n_alarm = 0;
+	fep->ptp_caps.n_ext_ts = 0;
+	fep->ptp_caps.n_per_out = 0;
+	fep->ptp_caps.n_pins = 0;
+	fep->ptp_caps.pps = 1;
+	fep->ptp_caps.adjfreq = fec_ptp_adjfreq;
+	fep->ptp_caps.adjtime = fec_ptp_adjtime;
+	fep->ptp_caps.gettime64 = fec_ptp_gettime;
+	fep->ptp_caps.settime64 = fec_ptp_settime;
+	fep->ptp_caps.enable = fec_ptp_enable;
+
+	fep->cycle_speed = clk_get_rate(fep->clk_ptp);
+	if (!fep->cycle_speed) {
+		fep->cycle_speed = NSEC_PER_SEC;
+		dev_err(&fep->pdev->dev, "clk_ptp clock rate is zero\n");
+	}
+	fep->ptp_inc = NSEC_PER_SEC / fep->cycle_speed;
+
+	spin_lock_init(&fep->tmreg_lock);
+
+	fec_ptp_start_cyclecounter(ndev);
+
+	INIT_DELAYED_WORK(&fep->time_keep, fec_time_keep);
+
+	irq = platform_get_irq_byname_optional(pdev, "pps");
+	if (irq < 0)
+		irq = platform_get_irq_optional(pdev, irq_idx);
+	/* Failure to get an irq is not fatal,
+	 * only the PTP_CLOCK_PPS clock events should stop
+	 */
+	if (irq >= 0) {
+		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
+				       0, pdev->name, ndev);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
+				 ret);
+	}
+
+	fep->ptp_clock = ptp_clock_register(&fep->ptp_caps, &pdev->dev);
+	if (IS_ERR(fep->ptp_clock)) {
+		fep->ptp_clock = NULL;
+		dev_err(&pdev->dev, "ptp_clock_register failed\n");
+	}
+
+	schedule_delayed_work(&fep->time_keep, HZ);
+}
+
+void fec_ptp_stop(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	cancel_delayed_work_sync(&fep->time_keep);
+	if (fep->ptp_clock)
+		ptp_clock_unregister(fep->ptp_clock);
+}
diff --git a/kernel/drivers/net/drivers/rt_fec.h b/kernel/drivers/net/drivers/rt_fec.h
deleted file mode 100644
index 2982777ea..000000000
--- a/kernel/drivers/net/drivers/rt_fec.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/****************************************************************************/
-
-/*
- *	fec.h  --  Fast Ethernet Controller for Motorola ColdFire SoC
- *		   processors.
- *
- *	(C) Copyright 2000-2005, Greg Ungerer (gerg@snapgear.com)
- *	(C) Copyright 2000-2001, Lineo (www.lineo.com)
- */
-
-/****************************************************************************/
-#ifndef RT_FEC_H
-#define	RT_FEC_H
-/****************************************************************************/
-
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || \
-    defined(CONFIG_ARCH_MXC) || defined(CONFIG_SOC_IMX28)
-/*
- *	Just figures, Motorola would have to change the offsets for
- *	registers in the same peripheral device on different models
- *	of the ColdFire!
- */
-#define FEC_IEVENT		0x004 /* Interrupt event reg */
-#define FEC_IMASK		0x008 /* Interrupt mask reg */
-#define FEC_R_DES_ACTIVE	0x010 /* Receive descriptor reg */
-#define FEC_X_DES_ACTIVE	0x014 /* Transmit descriptor reg */
-#define FEC_ECNTRL		0x024 /* Ethernet control reg */
-#define FEC_MII_DATA		0x040 /* MII manage frame reg */
-#define FEC_MII_SPEED		0x044 /* MII speed control reg */
-#define FEC_MIB_CTRLSTAT	0x064 /* MIB control/status reg */
-#define FEC_R_CNTRL		0x084 /* Receive control reg */
-#define FEC_X_CNTRL		0x0c4 /* Transmit Control reg */
-#define FEC_ADDR_LOW		0x0e4 /* Low 32bits MAC address */
-#define FEC_ADDR_HIGH		0x0e8 /* High 16bits MAC address */
-#define FEC_OPD			0x0ec /* Opcode + Pause duration */
-#define FEC_HASH_TABLE_HIGH	0x118 /* High 32bits hash table */
-#define FEC_HASH_TABLE_LOW	0x11c /* Low 32bits hash table */
-#define FEC_GRP_HASH_TABLE_HIGH	0x120 /* High 32bits hash table */
-#define FEC_GRP_HASH_TABLE_LOW	0x124 /* Low 32bits hash table */
-#define FEC_X_WMRK		0x144 /* FIFO transmit water mark */
-#define FEC_R_BOUND		0x14c /* FIFO receive bound reg */
-#define FEC_R_FSTART		0x150 /* FIFO receive start reg */
-#define FEC_R_DES_START		0x180 /* Receive descriptor ring */
-#define FEC_X_DES_START		0x184 /* Transmit descriptor ring */
-#define FEC_R_BUFF_SIZE		0x188 /* Maximum receive buff size */
-#define FEC_TACC		0x1c0 /* Transmit accelerator reg */
-#define FEC_MIIGSK_CFGR		0x300 /* MIIGSK Configuration reg */
-#define FEC_MIIGSK_ENR		0x308 /* MIIGSK Enable reg */
-
-#define BM_MIIGSK_CFGR_MII		0x00
-#define BM_MIIGSK_CFGR_RMII		0x01
-#define BM_MIIGSK_CFGR_FRCONT_10M	0x40
-
-#else
-
-#define FEC_ECNTRL		0x000 /* Ethernet control reg */
-#define FEC_IEVENT		0x004 /* Interrupt even reg */
-#define FEC_IMASK		0x008 /* Interrupt mask reg */
-#define FEC_IVEC		0x00c /* Interrupt vec status reg */
-#define FEC_R_DES_ACTIVE	0x010 /* Receive descriptor reg */
-#define FEC_X_DES_ACTIVE	0x014 /* Transmit descriptor reg */
-#define FEC_MII_DATA		0x040 /* MII manage frame reg */
-#define FEC_MII_SPEED		0x044 /* MII speed control reg */
-#define FEC_R_BOUND		0x08c /* FIFO receive bound reg */
-#define FEC_R_FSTART		0x090 /* FIFO receive start reg */
-#define FEC_X_WMRK		0x0a4 /* FIFO transmit water mark */
-#define FEC_X_FSTART		0x0ac /* FIFO transmit start reg */
-#define FEC_R_CNTRL		0x104 /* Receive control reg */
-#define FEC_MAX_FRM_LEN		0x108 /* Maximum frame length reg */
-#define FEC_X_CNTRL		0x144 /* Transmit Control reg */
-#define FEC_ADDR_LOW		0x3c0 /* Low 32bits MAC address */
-#define FEC_ADDR_HIGH		0x3c4 /* High 16bits MAC address */
-#define FEC_GRP_HASH_TABLE_HIGH	0x3c8 /* High 32bits hash table */
-#define FEC_GRP_HASH_TABLE_LOW	0x3cc /* Low 32bits hash table */
-#define FEC_R_DES_START		0x3d0 /* Receive descriptor ring */
-#define FEC_X_DES_START		0x3d4 /* Transmit descriptor ring */
-#define FEC_R_BUFF_SIZE		0x3d8 /* Maximum receive buff size */
-#define FEC_FIFO_RAM		0x400 /* FIFO RAM buffer */
-
-#endif /* CONFIG_M5272 */
-
-
-/*
- *	Define the buffer descriptor structure.
- */
-#if defined(CONFIG_ARCH_MXC) || defined(CONFIG_SOC_IMX28)
-struct bufdesc {
-	unsigned short cbd_datlen;	/* Data length */
-	unsigned short cbd_sc;	/* Control and status info */
-	unsigned long cbd_bufaddr;	/* Buffer address */
-};
-#else
-struct bufdesc {
-	unsigned short	cbd_sc;			/* Control and status info */
-	unsigned short	cbd_datlen;		/* Data length */
-	unsigned long	cbd_bufaddr;		/* Buffer address */
-};
-#endif
-
-/*
- *	The following definitions courtesy of commproc.h, which where
- *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
- */
-#define BD_SC_EMPTY     ((ushort)0x8000)        /* Receive is empty */
-#define BD_SC_READY     ((ushort)0x8000)        /* Transmit is ready */
-#define BD_SC_WRAP      ((ushort)0x2000)        /* Last buffer descriptor */
-#define BD_SC_INTRPT    ((ushort)0x1000)        /* Interrupt on change */
-#define BD_SC_CM        ((ushort)0x0200)        /* Continuous mode */
-#define BD_SC_ID        ((ushort)0x0100)        /* Rec'd too many idles */
-#define BD_SC_P         ((ushort)0x0100)        /* xmt preamble */
-#define BD_SC_BR        ((ushort)0x0020)        /* Break received */
-#define BD_SC_FR        ((ushort)0x0010)        /* Framing error */
-#define BD_SC_PR        ((ushort)0x0008)        /* Parity error */
-#define BD_SC_OV        ((ushort)0x0002)        /* Overrun */
-#define BD_SC_CD        ((ushort)0x0001)        /* ?? */
-
-/* Buffer descriptor control/status used by Ethernet receive.
-*/
-#define BD_ENET_RX_EMPTY        ((ushort)0x8000)
-#define BD_ENET_RX_WRAP         ((ushort)0x2000)
-#define BD_ENET_RX_INTR         ((ushort)0x1000)
-#define BD_ENET_RX_LAST         ((ushort)0x0800)
-#define BD_ENET_RX_FIRST        ((ushort)0x0400)
-#define BD_ENET_RX_MISS         ((ushort)0x0100)
-#define BD_ENET_RX_LG           ((ushort)0x0020)
-#define BD_ENET_RX_NO           ((ushort)0x0010)
-#define BD_ENET_RX_SH           ((ushort)0x0008)
-#define BD_ENET_RX_CR           ((ushort)0x0004)
-#define BD_ENET_RX_OV           ((ushort)0x0002)
-#define BD_ENET_RX_CL           ((ushort)0x0001)
-#define BD_ENET_RX_STATS        ((ushort)0x013f)        /* All status bits */
-
-/* Buffer descriptor control/status used by Ethernet transmit.
-*/
-#define BD_ENET_TX_READY        ((ushort)0x8000)
-#define BD_ENET_TX_PAD          ((ushort)0x4000)
-#define BD_ENET_TX_WRAP         ((ushort)0x2000)
-#define BD_ENET_TX_INTR         ((ushort)0x1000)
-#define BD_ENET_TX_LAST         ((ushort)0x0800)
-#define BD_ENET_TX_TC           ((ushort)0x0400)
-#define BD_ENET_TX_DEF          ((ushort)0x0200)
-#define BD_ENET_TX_HB           ((ushort)0x0100)
-#define BD_ENET_TX_LC           ((ushort)0x0080)
-#define BD_ENET_TX_RL           ((ushort)0x0040)
-#define BD_ENET_TX_RCMASK       ((ushort)0x003c)
-#define BD_ENET_TX_UN           ((ushort)0x0002)
-#define BD_ENET_TX_CSL          ((ushort)0x0001)
-#define BD_ENET_TX_STATS        ((ushort)0x03ff)        /* All status bits */
-
-
-/****************************************************************************/
-#endif /* RT_FEC_H */
diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index 522b66715..916f16091 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -267,7 +267,7 @@ struct rtskb_prio_queue {
  #define DEFAULT_SOCKET_RTSKBS 16 /* default number of rtskb's in socket pools */
  
  #define ALIGN_RTSKB_STRUCT_LEN SKB_DATA_ALIGN(sizeof(struct rtskb))
-#define RTSKB_SIZE 1544 /* maximum needed by pcnet32-rt */
+#define RTSKB_SIZE                  (2048 + NET_IP_ALIGN)    /* maximum needed by fec */
  
  extern unsigned int rtskb_pools; /* current number of rtskb pools      */
  extern unsigned int rtskb_pools_max; /* maximum number of rtskb pools      */
diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
index 9457661a1..782be5728 100644
--- a/kernel/drivers/net/stack/rtnet_chrdev.c
+++ b/kernel/drivers/net/stack/rtnet_chrdev.c
@@ -30,6 +30,7 @@
  #include <linux/netdevice.h>
  #include <linux/spinlock.h>
  
+#include <rtnet_port.h>
  #include <rtnet_chrdev.h>
  #include <rtnet_internal.h>
  #include <ipv4/route.h>
@@ -125,10 +126,9 @@ static int rtnet_core_ioctl(struct rtnet_device *rtdev, unsigned int request,
  		cmd.args.info.broadcast_ip = rtdev->broadcast_ip;
  		cmd.args.info.mtu = rtdev->mtu;
  		cmd.args.info.flags = rtdev->flags;
-		if ((cmd.args.info.flags & IFF_UP) &&
-		    (rtdev->link_state &
-		     (RTNET_LINK_STATE_PRESENT | RTNET_LINK_STATE_NOCARRIER)) ==
-			    RTNET_LINK_STATE_PRESENT)
+		if ((cmd.args.info.flags & IFF_UP)
+		    && rtnetif_carrier_ok(rtdev)
+		    && rtnetif_device_present(rtdev))
  			cmd.args.info.flags |= IFF_RUNNING;
  
  		memcpy(cmd.args.info.dev_addr, rtdev->dev_addr, MAX_ADDR_LEN);
diff --git a/kernel/drivers/net/stack/socket.c b/kernel/drivers/net/stack/socket.c
index f030663be..8d6b7a709 100644
--- a/kernel/drivers/net/stack/socket.c
+++ b/kernel/drivers/net/stack/socket.c
@@ -37,6 +37,7 @@
  #include <rtnet_iovec.h>
  #include <rtnet_socket.h>
  #include <ipv4/protocol.h>
+#include <rtnet_port.h>
  
  #define SKB_POOL_CLOSED 0
  
@@ -298,10 +299,9 @@ int rt_socket_if_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
  
  	case SIOCGIFFLAGS:
  		flags = rtdev->flags;
-		if ((ifr->ifr_flags & IFF_UP) &&
-		    (rtdev->link_state &
-		     (RTNET_LINK_STATE_PRESENT | RTNET_LINK_STATE_NOCARRIER)) ==
-			    RTNET_LINK_STATE_PRESENT)
+		if ((ifr->ifr_flags & IFF_UP)
+		    && rtnetif_carrier_ok(rtdev)
+		    && rtnetif_device_present(rtdev))
  			flags |= IFF_RUNNING;
  		ret = rtnet_put_arg(fd, &u_ifr->ifr_flags, &flags,
  				    sizeof(u_ifr->ifr_flags));
-- 
2.17.1

