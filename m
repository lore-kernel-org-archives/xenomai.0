Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D446AB
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:13 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A9ED7CA4B6
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 1022E40016
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:38 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 0B7439417B5
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20220704130836374791e7a25dea3f33
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tdzVrOnDJjvIF+W/E4ZA43+45WK7W0bEnCnAF6BUrFI=;
 b=KajsesC5Qq240pKeWBt42nfAjCaqsHVlwYbBDgVIBrNQwiNnQ7/B+jS/vMEdOQCMkbD0O4
 Q0sq0A+D/YH7oqKg06ec7zeScKg4pP+mH3f3gazB7oftsAHY7sjQQB3+CHQckuaQXvVXqs0D
 k07D5YJO5Lr9MHqeQkCgKEqp4WwCk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Cc: Gunter Grau <gunter.grau@philips.com>
Subject: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Date: Mon,  4 Jul 2022 15:08:25 +0200
Message-Id: <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool1: domain of rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) client-ip=185.136.65.227; envelope-from=fm-294854-20220704130836374791e7a25dea3f33-nj0sai@rts-flowmailer.siemens.com; helo=mta-65-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=KajsesC5;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220704130836374791e7a25dea3f33-nj0sai@rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) smtp.mailfrom=fm-294854-20220704130836374791e7a25dea3f33-nj0sai@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Latest kernel complain about accessing dev_addr directly and push us
toward the accessor functions. Use that and provide a wrapper for
kernels prior to 5.15.

CC: Gunter Grau <gunter.grau@philips.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h |  4 ++++
 kernel/drivers/net/addons/cap.c                      |  5 ++---
 kernel/drivers/net/addons/proxy.c                    |  2 +-
 kernel/drivers/net/drivers/freescale/fec_main.c      | 11 +++++++----
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c          |  5 ++---
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 88152a25e1..6489c82c8c 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -54,6 +54,10 @@
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
+#define dev_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
 #define pde_data(i)	PDE_DATA(i)
 #endif
diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 1e86440699..3784b65226 100644
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
index f70587678a..b37b42c9de 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -321,7 +321,7 @@ static void __init rtnetproxy_init(struct net_device *dev)
 
 	dev->tx_queue_len = 0;
 #ifdef CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP
-	memcpy(dev->dev_addr, rtnetproxy_rtdev->dev_addr, MAX_ADDR_LEN);
+	dev_addr_set(dev, rtnetproxy_rtdev->dev_addr);
 #else
 	dev->flags |= IFF_NOARP;
 #endif
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index be0ed0c51e..72ee4de738 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1315,11 +1315,14 @@ static void fec_get_mac(struct net_device *ndev)
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
+		dev_addr_set(ndev, tmpaddr);
+	} else {
+		dev_addr_set(ndev, iap);
+	}
 }
 
 /* ------------------------------------------------------------------------- */
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
index 138e276ad9..4b41785db8 100644
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
2.35.3

