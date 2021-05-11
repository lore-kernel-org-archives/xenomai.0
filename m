From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 21/31] net/drivers: fec: enable multicast
Date: Tue, 11 May 2021 18:05:25 +0200
Message-Id: <20210511160535.26580-22-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../drivers/net/drivers/freescale/fec_main.c  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 08956dfab..41c2fb1da 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -3608,6 +3608,65 @@ static void set_multicast_list(struct net_device *ndev)
 	writel(hash_low, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
 }
 
+static void fec_rt_set_multicast_list(struct rtnet_device *rtdev)
+{
+	struct fec_enet_private *fep;
+	unsigned int i, bit, data, crc, tmp;
+	unsigned char hash;
+	unsigned int hash_high = 0, hash_low = 0;
+	struct rtdev_mc_list *mca;
+
+	fep = container_of(rtdev, struct fec_enet_private, rtnet.dev);
+
+	if (rtdev->flags & IFF_PROMISC) {
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
+	if (rtdev->flags & IFF_ALLMULTI) {
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
+	for (mca = rtdev->mc_list; mca; mca = mca->next) {
+		/* calculate crc32 value of mac address */
+		crc = 0xffffffff;
+
+		for (i = 0; i < mca->dmi_addrlen; i++) {
+			data = mca->dmi_addr[i];
+			for (bit = 0; bit < 8; bit++, data >>= 1) {
+				crc = (crc >> 1) ^
+				(((crc ^ data) & 1) ? CRC32_POLY : 0);
+			}
+		}
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
 /* Set a MAC change in hardware. */
 static int
 fec_set_mac_address(struct net_device *ndev, void *p)
@@ -3945,6 +4004,7 @@ static int fec_rt_init(struct net_device *ndev)
 	rtdev->do_ioctl = fec_rt_ioctl;
 	rtdev->hard_start_xmit = fec_rt_start_xmit;
 	rtdev->get_stats = fec_rt_stats;
+	rtdev->set_multicast_list = fec_rt_set_multicast_list;
 	rtdev->sysbind = &fep->pdev->dev;
 
 	ret = rt_init_etherdev(rtdev, (RX_RING_SIZE + TX_RING_SIZE) * 2);
-- 
2.17.1


