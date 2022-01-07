From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/6] drivers/net: Account for changes to of_get_mac_address in
 5.13
Date: Fri, 7 Jan 2022 12:35:31 +0100
Message-ID: <2ec3117760c601d8f05bc664874afa02ca031449.1641555334.git.jan.kiszka@siemens.com>
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
 kernel/drivers/net/drivers/at91_ether.c         | 7 +++++++
 kernel/drivers/net/drivers/freescale/fec_main.c | 6 ++++++
 kernel/drivers/net/drivers/macb.c               | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/kernel/drivers/net/drivers/at91_ether.c b/kernel/drivers/net/drivers/at91_ether.c
index 7a2436c273..f8223b0bc5 100644
--- a/kernel/drivers/net/drivers/at91_ether.c
+++ b/kernel/drivers/net/drivers/at91_ether.c
@@ -303,7 +303,9 @@ static int __init at91ether_probe(struct platform_device *pdev)
 	struct macb *lp;
 	int res;
 	u32 reg;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 13, 0)
 	const char *mac;
+#endif
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
@@ -356,10 +358,15 @@ static int __init at91ether_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0))
+	res = of_get_mac_address(pdev->dev.of_node, lp->dev->dev_addr);
+	if (res)
+#else
 	mac = of_get_mac_address(pdev->dev.of_node);
 	if (mac)
 		memcpy(lp->dev->dev_addr, mac, ETH_ALEN);
 	else
+#endif
 		rtmacb_get_hwaddr(lp);
 
 	res = of_get_phy_mode(pdev->dev.of_node);
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 38396a08e1..0192a09970 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1267,9 +1267,15 @@ static void fec_get_mac(struct net_device *ndev)
 	if (!is_valid_ether_addr(iap)) {
 		struct device_node *np = fep->pdev->dev.of_node;
 		if (np) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0)
+			int err = of_get_mac_address(np, tmpaddr);
+			if (!err)
+				iap = tmpaddr;
+#else
 			const char *mac = of_get_mac_address(np);
 			if (!IS_ERR(mac))
 				iap = (unsigned char *) mac;
+#endif
 		}
 	}
 
diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
index ccda6aecda..77957d9062 100644
--- a/kernel/drivers/net/drivers/macb.c
+++ b/kernel/drivers/net/drivers/macb.c
@@ -1570,7 +1570,9 @@ static int __init macb_probe(struct platform_device *pdev)
 	u32 config;
 	int err = -ENXIO;
 	struct pinctrl *pinctrl;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 13, 0)
 	const char *mac;
+#endif
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -1688,10 +1690,15 @@ static int __init macb_probe(struct platform_device *pdev)
 	config |= macb_dbw(bp);
 	macb_writel(bp, NCFGR, config);
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0)
+	err = of_get_mac_address(pdev->dev.of_node, bp->dev->dev_addr);
+	if (err)
+#else
 	mac = of_get_mac_address(pdev->dev.of_node);
 	if (mac)
 		memcpy(bp->dev->dev_addr, mac, ETH_ALEN);
 	else
+#endif
 		rtmacb_get_hwaddr(bp);
 
 	err = of_get_phy_mode(pdev->dev.of_node);
-- 
2.31.1


