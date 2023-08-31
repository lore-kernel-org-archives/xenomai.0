Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079981AA69
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:50 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230831203742c1c40bdfe11da4429f
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rZ2eRp4GtRyeeZlCuRfHVLVV44dh2UjnY0oZ0IkOYXg=;
 b=QvzoBK623UgKwZOrahcILmJF1Pa+8qTz38QoD+YeUYROBFC8gc13y6cM4lUMm+dp0ZYpFP
 JRMXYfK7NUNfgL8UH8qsxe+/voLz+GNT/BQVowtKtvypI0gRcDjJJ3ygTwPzZATeRsO7LGRD
 cUmCaVBWRhAVjDBef61/+Hs+eMb9I=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:30 +0200
Subject: [PATCH stable/v3.2.x 04/19] drivers/net: Switch to dev_addr_set
 and eth_hw_addr_set
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-4-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 5af4f16609c11805e86dc35164727235185b8676 ]

Latest kernel complain about accessing dev_addr directly and push us
toward the accessor functions. Use them and provide wrappers for
kernels prior to 5.15.

CC: Gunter Grau <gunter.grau@philips.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h |  5 +++++
 kernel/drivers/net/addons/cap.c                      |  5 ++---
 kernel/drivers/net/addons/proxy.c                    |  2 +-
 kernel/drivers/net/drivers/freescale/fec_main.c      | 11 +++++++----
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c          |  5 ++---
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 99059d2e9..62fbb1a2a 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -252,6 +252,11 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
+#define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
+#define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
 #define pde_data(i)	PDE_DATA(i)
 #endif
diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 1e8644069..3784b6522 100644
--- a/kernel/drivers/net/addons/cap.c
+++ b/kernel/drivers/net/addons/cap.c
@@ -263,9 +263,8 @@ static int tap_dev_open(struct net_device *dev)
 	if (err == 0)
 		return -EIDRM;
 
-	memcpy(dev->dev_addr,
-	       (*(struct rtnet_device **)netdev_priv(dev))->dev_addr,
-	       MAX_ADDR_LEN);
+	dev_addr_set(dev,
+		     (*(struct rtnet_device **)netdev_priv(dev))->dev_addr);
 
 	return 0;
 }
diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
index 0b3ec74fa..f61794a4a 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -324,7 +324,7 @@ static void __init rtnetproxy_init(struct net_device *dev)
 
 	dev->tx_queue_len = 0;
 #ifdef CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP
-	memcpy(dev->dev_addr, rtnetproxy_rtdev->dev_addr, MAX_ADDR_LEN);
+	dev_addr_set(dev, rtnetproxy_rtdev->dev_addr);
 #else
 	dev->flags |= IFF_NOARP;
 #endif
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index ba2d3ed0d..50db6bc6a 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1319,11 +1319,14 @@ static void fec_get_mac(struct net_device *ndev)
 		return;
 	}
 
-	memcpy(ndev->dev_addr, iap, ETH_ALEN);
-
 	/* Adjust MAC if using macaddr */
-	if (iap == macaddr)
-		 ndev->dev_addr[ETH_ALEN-1] = macaddr[ETH_ALEN-1] + fep->dev_id;
+	if (iap == macaddr) {
+		memcpy(tmpaddr, macaddr, ETH_ALEN);
+		tmpaddr[ETH_ALEN-1] += fep->dev_id;
+		eth_hw_addr_set(ndev, tmpaddr);
+	} else {
+		eth_hw_addr_set(ndev, iap);
+	}
 }
 
 /* ------------------------------------------------------------------------- */
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
index 138e276ad..4b41785db 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
@@ -114,9 +114,8 @@ static void rtmac_vnic_signal_handler(rtdm_nrtsig_t *nrtsig, void *arg)
 
 static int rtmac_vnic_copy_mac(struct net_device *dev)
 {
-	memcpy(dev->dev_addr,
-	       (*(struct rtnet_device **)netdev_priv(dev))->dev_addr,
-	       MAX_ADDR_LEN);
+	dev_addr_set(dev,
+		     (*(struct rtnet_device **)netdev_priv(dev))->dev_addr);
 
 	return 0;
 }

-- 
2.39.2

