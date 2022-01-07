From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/6] drivers/net: fec: Account for changes of get/set_coalesce
 ethtool callbacks in 5.15
Date: Fri, 7 Jan 2022 12:35:32 +0100
Message-ID: <961e1d8ef82d0b206f3f1ea895e6b1a46dec794e.1641555334.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641555334.git.jan.kiszka@siemens.com>
References: <cover.1641555334.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/freescale/fec_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 0192a09970..be0ed0c51e 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -2171,7 +2171,13 @@ static void fec_enet_itr_coal_set(struct net_device *ndev)
 }
 
 static int
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
+fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec,
+		      struct kernel_ethtool_coalesce *kernel_coal,
+		      struct netlink_ext_ack *extack)
+#else
 fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
+#endif
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
@@ -2188,7 +2194,13 @@ fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
 }
 
 static int
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
+fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec,
+		      struct kernel_ethtool_coalesce *kernel_coal,
+		      struct netlink_ext_ack *extack)
+#else
 fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
+#endif
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct device *dev = &fep->pdev->dev;
@@ -2240,7 +2252,11 @@ static void fec_enet_itr_coal_init(struct net_device *ndev)
 	ec.tx_coalesce_usecs = FEC_ITR_ICTT_DEFAULT;
 	ec.tx_max_coalesced_frames = FEC_ITR_ICFT_DEFAULT;
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
+	fec_enet_set_coalesce(ndev, &ec, NULL, NULL);
+#else
 	fec_enet_set_coalesce(ndev, &ec);
+#endif
 }
 
 static int fec_enet_get_tunable(struct net_device *netdev,
-- 
2.31.1


