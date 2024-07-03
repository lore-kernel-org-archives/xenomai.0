Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B917A5B0
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013151; cv=none; b=bu8fPha0ZH5PEyer76Lob68qhF1pF8zdmniXe3HBve9fezXjN74U3h4C+IPN/GtwSS7CaFlnqV1cPmy+BBx10DJng5JeNjofW9IghluEFlTxJUbuDgykaAMe3EO0Qku5304qrfMfNRs1QoQx5rXi2ah5AOTI5q71eP9AiTKdkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013151; c=relaxed/simple;
	bh=nLN5TEoiejRLljekqu2x8cdBngD2t3EQEwnGx5pww3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXUnafm1H4MFuAMlQ+5InEDSm8ds/tA5BzKAhLsalRMhTgx90LdH012Ps5kON+Lsgfk0b4HzRdZt96XOr528DMhOZPo9708rXENJcK3NOhHX6YU1zdjWmRPs56EcAngW1fNgvN7PEprkrVK/ZEB0bwlV17QPgZLHDeSu6LXcYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=lwVO/u92; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lwVO/u92"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024070313254483fdbfe76b48d5e1f3
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e1n/uAaTRhBTytZH007Pp3ndH2VgwxIACgIZ/ZfMYjw=;
 b=lwVO/u92ToYL9eaqRTsURLssMAKY9bG+Pm+nd6S0ehFBchGfajDFa3Q+9Hvn3lZth+f8v+
 WlafGituE5zUpFcWlaaNuGUbfntG/VBWfJEaz1sLOCAKnQnpA8XSEjpnXAqTrMFxHmQf80Bb
 4Nsfdk/HzxyIpRVaa0/0tbjCdBHWY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:40 +0200
Subject: [PATCH 17/33] drivers/eth1394: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-17-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some (rtdm_)printk() calls were missing log level information. This
alone is not a problem, but confusion starts when the default printk
log level is set to an unexpected value.

The missing log level is addressed by migrating the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

The DEBUGP() and TRACE() macros have been removed. They were never
used.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/eth1394.c | 83 ++++++++++++++----------------------
 1 file changed, 33 insertions(+), 50 deletions(-)

diff --git a/kernel/drivers/net/drivers/eth1394.c b/kernel/drivers/net/drivers/eth1394.c
index e6bf2d6ca..689648313 100644
--- a/kernel/drivers/net/drivers/eth1394.c
+++ b/kernel/drivers/net/drivers/eth1394.c
@@ -21,6 +21,10 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define driver_name "RT-ETH1394"
+
+#define pr_fmt(fmt) driver_name ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/if_arp.h>
@@ -45,26 +49,6 @@
 #include <highlevel.h>
 #include <iso.h>
 
-#define driver_name	"RT-ETH1394"
-
-
-#define ETH1394_PRINT_G(level, fmt, args...) \
-	rtdm_printk(level "%s: " fmt, driver_name, ## args)
-
-#define ETH1394_PRINT(level, dev_name, fmt, args...) \
-	rtdm_printk(level "%s: %s: " fmt, driver_name, dev_name, ## args)
-
-//#define ETH1394_DEBUG 1
-
-#ifdef ETH1394_DEBUG
-#define DEBUGP(fmt, args...) \
-	rtdm_printk(KERN_ERR "%s:%s[%d]: " fmt "\n", driver_name, __FUNCTION__, __LINE__, ## args)
-#else
-#define DEBUGP(fmt, args...)
-#endif
-
-#define TRACE() rtdm_printk(KERN_ERR "%s:%s[%d] ---- TRACE\n", driver_name, __FUNCTION__, __LINE__)
-
 /* Change this to IEEE1394_SPEED_S100 to make testing easier */
 #define ETH1394_SPEED_DEF	0x03 /*IEEE1394_SPEED_MAX*/
 
@@ -169,9 +153,9 @@ static int eth1394_init_bc(struct rtnet_device *dev)
 
 		if ((bc & 0x80000000) != 0x80000000) { //used to be 0xc0000000
 			/* broadcast channel not validated yet */
-			ETH1394_PRINT(KERN_WARNING, dev->name,
-				      "Error BROADCAST_CHANNEL register valid "
-				      "bit not set, can't send IP traffic\n");
+			pr_warn("%s: Error BROADCAST_CHANNEL register valid "
+				"bit not set, can't send IP traffic\n",
+				dev->name);
 
 			eth1394_iso_shutdown(priv);
 
@@ -188,24 +172,22 @@ static int eth1394_init_bc(struct rtnet_device *dev)
 				//~ return -EAGAIN;
 
 			priv->broadcast_channel = bc & 0x3f;
-			ETH1394_PRINT(KERN_INFO, dev->name,
-				      "Changing to broadcast channel %d...\n",
-				      priv->broadcast_channel);
+			pr_info("%s: Changing to broadcast channel %d...\n",
+				dev->name, priv->broadcast_channel);
 
 			priv->iso = hpsb_iso_recv_init(priv->host, 16 * 4096,
 						       16, priv->broadcast_channel, HPSB_ISO_DMA_PACKET_PER_BUFFER,
 						       1, eth1394_iso, 0, "eth1394_iso", IEEE1394_PRIORITY_HIGHEST);
 
 			if (priv->iso == NULL) {
-				ETH1394_PRINT(KERN_ERR, dev->name,
-					      "failed to change broadcast "
-					      "channel\n");
+				pr_err("%s: failed to change broadcast channel\n",
+				       dev->name);
 				return -EAGAIN;
 			}
 		}
 		if (hpsb_iso_recv_start(priv->iso, -1, (1 << 3), -1) < 0) {
-			ETH1394_PRINT(KERN_ERR, dev->name,
-				      "Could not start data stream reception\n");
+			pr_err("%s: Could not start data stream reception\n",
+			       dev->name);
 
 			eth1394_iso_shutdown(priv);
 
@@ -258,7 +240,7 @@ static inline void eth1394_register_limits(int nodeid, u16 maxpayload,
 {
 
 	if (nodeid < 0 || nodeid >= ALL_NODES) {
-		ETH1394_PRINT_G (KERN_ERR, "Cannot register invalid nodeid %d\n", nodeid);
+		pr_err("Cannot register invalid nodeid %d\n", nodeid);
 		return;
 	}
 
@@ -343,8 +325,8 @@ static void eth1394_add_host (struct hpsb_host *host)
 	dev = rt_alloc_etherdev(sizeof (struct eth1394_priv),
 				RX_RING_SIZE * 2 + TX_RING_SIZE);
 	if (dev == NULL) {
-		ETH1394_PRINT_G (KERN_ERR, "Out of memory trying to allocate "
-				 "etherdevice for IEEE 1394 device\n");
+		pr_err("Out of memory trying to allocate "
+		       "etherdevice for IEEE 1394 device\n");
 		goto free_dev;
 	}
 	rtdev_alloc_name(dev, "rteth%d");
@@ -378,18 +360,18 @@ static void eth1394_add_host (struct hpsb_host *host)
 
 	hi = hpsb_create_hostinfo(&eth1394_highlevel, host, sizeof(*hi));
 	if (hi == NULL) {
-		ETH1394_PRINT_G (KERN_ERR, "Out of memory trying to create "
-				 "hostinfo for IEEE 1394 device\n");
+		pr_err("Out of memory trying to create "
+		       "hostinfo for IEEE 1394 device\n");
 		goto free_hi;
 	}
 
 	if(rt_register_rtnetdev(dev))
 	{
-		ETH1394_PRINT (KERN_ERR, dev->name, "Error registering network driver\n");
+		pr_err("%s: Error registering network driver\n", dev->name);
 		goto free_hi;
 	}
 
-	ETH1394_PRINT (KERN_ERR, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet\n");
+	pr_err("%s: IEEE-1394 IPv4 over 1394 Ethernet\n", dev->name);
 
 	hi->host = host;
 	hi->dev = dev;
@@ -411,9 +393,9 @@ static void eth1394_add_host (struct hpsb_host *host)
 
 
 	if (priv->iso == NULL) {
-		ETH1394_PRINT(KERN_ERR, dev->name,
-			      "Could not allocate isochronous receive context "
-			      "for the broadcast channel\n");
+		pr_err("%s: Could not allocate isochronous receive context "
+		       "for the broadcast channel\n",
+		       dev->name);
 		priv->bc_state = ETHER1394_BC_ERROR;
 		goto unregister_dev;
 	} else {
@@ -826,7 +808,7 @@ static int eth1394_data_handler(struct rtnet_device *dev, int srcid, int destid,
 
 		skb = rtnetdev_alloc_rtskb(dev, len + dev->hard_header_len + 15);
 		if (!skb) {
-			ETH1394_PRINT_G(KERN_ERR, "eth1394 rx: low on mem\n");
+			pr_err("rx: low on mem\n");
 			priv->stats.rx_dropped++;
 			return -1;
 		}
@@ -992,8 +974,8 @@ static int eth1394_write(struct hpsb_host *host, struct hpsb_packet *packet, uns
 	int ret;
 
 	if (hi == NULL) {
-		ETH1394_PRINT_G(KERN_ERR, "Could not find net device for host %s\n",
-				host->driver->name);
+		pr_err("Could not find net device for host %s\n",
+		       host->driver->name);
 		return RCODE_ADDRESS_ERROR;
 	}
 
@@ -1028,8 +1010,8 @@ static void eth1394_iso(struct hpsb_iso *iso, void *arg)
 
 	struct host_info *hi = hpsb_get_hostinfo(&eth1394_highlevel, iso->host);
 	if (hi == NULL) {
-		ETH1394_PRINT_G(KERN_ERR, "Could not find net device for host %s\n",
-				iso->host->driver->name);
+		pr_err("Could not find net device for host %s\n",
+		       iso->host->driver->name);
 		return;
 	}
 
@@ -1196,8 +1178,9 @@ static inline int eth1394_prep_write_packet(struct hpsb_packet *p,
 	p->expect_response = 1;
 
 	if (hpsb_get_tlabel(p)) {
-		ETH1394_PRINT_G(KERN_ERR, "No more tlabels left while sending "
-				"to node " NODE_BUS_FMT "\n", NODE_BUS_ARGS(host, node));
+		pr_err("No more tlabels left while sending "
+		       "to node " NODE_BUS_FMT "\n",
+		       NODE_BUS_ARGS(host, node));
 		return -1;
 	}
 	p->header[0] = (p->node_id << 16) | (p->tlabel << 10)
@@ -1380,8 +1363,8 @@ static int eth1394_tx (struct rtskb *skb, struct rtnet_device *dev)
 
 	rtdm_lock_get_irqsave(&priv->lock, context);
 	if (priv->bc_state == ETHER1394_BC_CLOSED) {
-		ETH1394_PRINT(KERN_ERR, dev->name,
-			      "Cannot send packet, no broadcast channel available.\n");
+		pr_err("%s: Cannot send packet, no broadcast channel available.\n",
+		       dev->name);
 		ret = -EAGAIN;
 		rtdm_lock_put_irqrestore(&priv->lock, context);
 		goto fail;

-- 
2.39.2

