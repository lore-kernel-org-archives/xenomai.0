Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79C14D70A
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781342; cv=none; b=jCdxYhyMby2ySty3yuPIEq210m0IfNnKyutxjhIW3Lo0rYtOF+5q0zf1jjzO7I2HSMneoSBFiAP2Xb1Yo1I/cPVe4jIphZkIYdR7kXERopNYBGl+u0JC+tTPA5kr2HOEoItMwnPxRIuMeZLiz7ra8bFkmo6eM/jh26EHW5Sng50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781342; c=relaxed/simple;
	bh=9x3l3brY4QgoZs37aEQB2UZ2hg8Y64rMjyPFfVmDkKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdmjC9Rg0QO3BmqNBeHj47nPv20+emzSo1qf8kCLklSn0viOLlwXtLO0hLA7xe8sXjB/Ooo5WVYLT6r+Q1MEgqJyiuzLTmOxK42GibdE7obcCpqlm9vQpVh9YWfTA1BjKwFpIgr1xeVv5bRoMUCh5qh2N39/Q2YA56pWReK2ugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=mDkr1e4f; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="mDkr1e4f"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240712104854833073844c9e2d3729
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3K4Yq4ug+MyYSJiHP+JnpOKqtZii03vVaWUYPbT7lUM=;
 b=mDkr1e4fFSXpJ0QJqucz1r27wbR0RKdOnzFcNESHC3i1+aW/1Z52IrgDjpVI9ffxqNRwJd
 S5Xr9WksyqcXxtxG04gEW8G9KAcfjACVXPLjscsoccDEm7l3wyoz/vTCU7AFBVZdKsfyuFtB
 5MegHJHO5Z4/pAAvRTUNR2d+7Zv64=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:00 +0200
Subject: [PATCH v2 14/33] drivers/tulip: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-14-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

A few (rtdm_)printk() calls were missing log level information. The
default log level (=warn) did not fit well for them.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/tulip/21142.c      |  6 +-
 kernel/drivers/net/drivers/tulip/eeprom.c     | 22 +++---
 kernel/drivers/net/drivers/tulip/interrupt.c  | 42 ++++++------
 kernel/drivers/net/drivers/tulip/media.c      | 38 ++++++-----
 kernel/drivers/net/drivers/tulip/pnic.c       |  4 +-
 kernel/drivers/net/drivers/tulip/pnic2.c      | 14 ++--
 kernel/drivers/net/drivers/tulip/tulip_core.c | 96 +++++++++++++--------------
 7 files changed, 117 insertions(+), 105 deletions(-)

diff --git a/kernel/drivers/net/drivers/tulip/21142.c b/kernel/drivers/net/drivers/tulip/21142.c
index a36cce8b2..eaa2f5314 100644
--- a/kernel/drivers/net/drivers/tulip/21142.c
+++ b/kernel/drivers/net/drivers/tulip/21142.c
@@ -15,6 +15,8 @@
 */
 /* Ported to RTnet by Wittawat Yamwong <wittawat@web.de> */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "tulip.h"
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -33,8 +35,8 @@ void t21142_start_nway(/*RTnet*/struct rtnet_device *rtdev)
 	tp->nway = tp->mediasense = 1;
 	tp->nwayset = tp->lpar = 0;
 	if (tulip_debug > 1)
-		printk(KERN_DEBUG "%s: Restarting 21143 autonegotiation, csr14=%8.8x.\n",
-			   rtdev->name, csr14);
+		pr_debug("%s: Restarting 21143 autonegotiation, csr14=%8.8x.\n",
+			 rtdev->name, csr14);
 	outl(0x0001, ioaddr + CSR13);
 	udelay(100);
 	outl(csr14, ioaddr + CSR14);
diff --git a/kernel/drivers/net/drivers/tulip/eeprom.c b/kernel/drivers/net/drivers/tulip/eeprom.c
index 5f3b16c22..c86ee51ad 100644
--- a/kernel/drivers/net/drivers/tulip/eeprom.c
+++ b/kernel/drivers/net/drivers/tulip/eeprom.c
@@ -15,6 +15,8 @@
 */
 /* Ported to RTnet by Wittawat Yamwong <wittawat@web.de> */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "tulip.h"
 #include <linux/init.h>
 #include <asm/unaligned.h>
@@ -96,13 +98,13 @@ void tulip_parse_eeprom(/*RTnet*/struct rtnet_device *rtdev)
 		if (ee_data[0] == 0xff) {
 			if (last_mediatable) {
 				controller_index++;
-				/*RTnet*/rtdm_printk(KERN_INFO "%s:  Controller %d of multiport board.\n",
+				/*RTnet*/pr_info("%s:  Controller %d of multiport board.\n",
 					   rtdev->name, controller_index);
 				tp->mtable = last_mediatable;
 				ee_data = last_ee_data;
 				goto subsequent_board;
 			} else
-				/*RTnet*/rtdm_printk(KERN_INFO "%s:  Missing EEPROM, this interface may "
+				/*RTnet*/pr_info("%s:  Missing EEPROM, this interface may "
 					   "not work correctly!\n",
 			   rtdev->name);
 			return;
@@ -116,14 +118,14 @@ void tulip_parse_eeprom(/*RTnet*/struct rtnet_device *rtdev)
 			  i++;			/* An Accton EN1207, not an outlaw Maxtech. */
 		  memcpy(ee_data + 26, eeprom_fixups[i].newtable,
 				 sizeof(eeprom_fixups[i].newtable));
-		  /*RTnet*/rtdm_printk(KERN_INFO "%s: Old format EEPROM on '%s' board.  Using"
+		  /*RTnet*/pr_info("%s: Old format EEPROM on '%s' board.  Using"
 				 " substitute media control info.\n",
 				 rtdev->name, eeprom_fixups[i].name);
 		  break;
 		}
 	  }
 	  if (eeprom_fixups[i].name == NULL) { /* No fixup found. */
-		  /*RTnet*/rtdm_printk(KERN_INFO "%s: Old style EEPROM with no media selection "
+		  /*RTnet*/pr_info("%s: Old style EEPROM with no media selection "
 				 "information.\n",
 			   rtdev->name);
 		return;
@@ -143,7 +145,7 @@ subsequent_board:
 		int count = p[2];
 		p += 3;
 
-		/*RTnet*/rtdm_printk(KERN_INFO "%s: 21041 Media table, default media %4.4x (%s).\n",
+		/*RTnet*/pr_info("%s: 21041 Media table, default media %4.4x (%s).\n",
 			   rtdev->name, media,
 			   media & 0x0800 ? "Autosense" : medianame[media & MEDIA_MASK]);
 		for (i = 0; i < count; i++) {
@@ -151,7 +153,7 @@ subsequent_board:
 			int media_code = media_block & MEDIA_MASK;
 			if (media_block & 0x40)
 				p += 6;
-			/*RTnet*/rtdm_printk(KERN_INFO "%s:  21041 media #%d, %s.\n",
+			/*RTnet*/pr_info("%s:  21041 media #%d, %s.\n",
 				   rtdev->name, media_code, medianame[media_code]);
 		}
 	} else {
@@ -169,7 +171,7 @@ subsequent_board:
 	        /* there is no phy information, don't even try to build mtable */
 	        if (count == 0) {
 			if (tulip_debug > 0)
-				/*RTnet*/rtdm_printk(KERN_WARNING "%s: no phy info, aborting mtable build\n", rtdev->name);
+				/*RTnet*/pr_warn("%s: no phy info, aborting mtable build\n", rtdev->name);
 		        return;
 		}
 
@@ -185,7 +187,7 @@ subsequent_board:
 		mtable->has_nonmii = mtable->has_mii = mtable->has_reset = 0;
 		mtable->csr15dir = mtable->csr15val = 0;
 
-		/*RTnet*/rtdm_printk(KERN_INFO "%s:  EEPROM default media type %s.\n", rtdev->name,
+		/*RTnet*/pr_info("%s:  EEPROM default media type %s.\n", rtdev->name,
 			   media & 0x0800 ? "Autosense" : medianame[media & MEDIA_MASK]);
 		for (i = 0; i < count; i++) {
 			struct medialeaf *leaf = &mtable->mleaf[i];
@@ -249,12 +251,12 @@ subsequent_board:
 			}
 			if (tulip_debug > 1  &&  leaf->media == 11) {
 				unsigned char *bp = leaf->leafdata;
-				/*RTnet*/rtdm_printk(KERN_INFO "%s:  MII interface PHY %d, setup/reset "
+				/*RTnet*/pr_info("%s:  MII interface PHY %d, setup/reset "
 					   "sequences %d/%d long, capabilities %2.2x %2.2x.\n",
 					   rtdev->name, bp[0], bp[1], bp[2 + bp[1]*2],
 					   bp[5 + bp[2 + bp[1]*2]*2], bp[4 + bp[2 + bp[1]*2]*2]);
 			}
-			/*RTnet*/rtdm_printk(KERN_INFO "%s:  Index #%d - Media %s (#%d) described "
+			/*RTnet*/pr_info("%s:  Index #%d - Media %s (#%d) described "
 				   "by a %s (%d) block.\n",
 				   rtdev->name, i, medianame[leaf->media & 15], leaf->media,
 				   leaf->type < ARRAY_SIZE(block_name) ? block_name[leaf->type] : "<unknown>",
diff --git a/kernel/drivers/net/drivers/tulip/interrupt.c b/kernel/drivers/net/drivers/tulip/interrupt.c
index d65bb3f78..7ab1a88cc 100644
--- a/kernel/drivers/net/drivers/tulip/interrupt.c
+++ b/kernel/drivers/net/drivers/tulip/interrupt.c
@@ -15,6 +15,8 @@
 */
 /* Ported to RTnet by Wittawat Yamwong <wittawat@web.de> */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "tulip.h"
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
@@ -107,15 +109,15 @@ static int tulip_rx(/*RTnet*/struct rtnet_device *rtdev, nanosecs_abs_t *time_st
 	int received = 0;
 
 	if (tulip_debug > 4)
-		/*RTnet*/rtdm_printk(KERN_DEBUG " In tulip_rx(), entry %d %8.8x.\n", entry,
-			   tp->rx_ring[entry].status);
+		/*RTnet*/pr_debug(" In tulip_rx(), entry %d %8.8x.\n", entry,
+				  tp->rx_ring[entry].status);
 	/* If we own the next entry, it is a new packet. Send it up. */
 	while ( ! (tp->rx_ring[entry].status & cpu_to_le32(DescOwned))) {
 		s32 status = le32_to_cpu(tp->rx_ring[entry].status);
 
 		if (tulip_debug > 5)
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s: In tulip_rx(), entry %d %8.8x.\n",
-				   rtdev->name, entry, status);
+			/*RTnet*/pr_debug("%s: In tulip_rx(), entry %d %8.8x.\n",
+					  rtdev->name, entry, status);
 		if (--rx_work_limit < 0)
 			break;
 		if ((status & 0x38008300) != 0x0300) {
@@ -123,7 +125,7 @@ static int tulip_rx(/*RTnet*/struct rtnet_device *rtdev, nanosecs_abs_t *time_st
 				/* Ingore earlier buffers. */
 				if ((status & 0xffff) != 0x7fff) {
 					if (tulip_debug > 1)
-						/*RTnet*/rtdm_printk(KERN_WARNING "%s: Oversized Ethernet frame "
+						/*RTnet*/pr_warn("%s: Oversized Ethernet frame "
 							   "spanned multiple buffers, status %8.8x!\n",
 							   rtdev->name, status);
 					tp->stats.rx_length_errors++;
@@ -131,7 +133,7 @@ static int tulip_rx(/*RTnet*/struct rtnet_device *rtdev, nanosecs_abs_t *time_st
 			} else if (status & RxDescFatalErr) {
 				/* There was a fatal error. */
 				if (tulip_debug > 2)
-					/*RTnet*/rtdm_printk(KERN_DEBUG "%s: Receive error, Rx status %8.8x.\n",
+					/*RTnet*/pr_warn("%s: Receive error, Rx status %8.8x.\n",
 						   rtdev->name, status);
 				tp->stats.rx_errors++; /* end of a packet.*/
 				if (status & 0x0890) tp->stats.rx_length_errors++;
@@ -146,7 +148,7 @@ static int tulip_rx(/*RTnet*/struct rtnet_device *rtdev, nanosecs_abs_t *time_st
 
 #ifndef final_version
 			if (pkt_len > 1518) {
-				/*RTnet*/rtdm_printk(KERN_WARNING "%s: Bogus packet size of %d (%#x).\n",
+				/*RTnet*/pr_warn("%s: Bogus packet size of %d (%#x).\n",
 					   rtdev->name, pkt_len, pkt_len);
 				pkt_len = 1518;
 				tp->stats.rx_length_errors++;
@@ -159,7 +161,7 @@ static int tulip_rx(/*RTnet*/struct rtnet_device *rtdev, nanosecs_abs_t *time_st
 #ifndef final_version
 				if (tp->rx_buffers[entry].mapping !=
 				    le32_to_cpu(tp->rx_ring[entry].buffer1)) {
-					/*RTnet*/rtdm_printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
+					/*RTnet*/pr_err("%s: Internal fault: The skbuff addresses "
 					       "do not match in tulip_rx: %08x vs. %08llx ? / %p.\n",
 					       rtdev->name,
 					       le32_to_cpu(tp->rx_ring[entry].buffer1),
@@ -212,7 +214,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 	csr5 = inl(ioaddr + CSR5);
 
 	if ((csr5 & (NormalIntr|AbnormalIntr)) == 0) {
-		rtdm_printk("%s: unexpected IRQ!\n",rtdev->name);
+		pr_debug("%s: unexpected IRQ!\n",rtdev->name);
 		return RTDM_IRQ_NONE;
 	}
 
@@ -223,7 +225,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 		outl(csr5 & 0x0001ffff, ioaddr + CSR5);
 
 		if (tulip_debug > 4)
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s: interrupt  csr5=%#8.8x new csr5=%#8.8x.\n",
+			/*RTnet*/pr_debug("%s: interrupt  csr5=%#8.8x new csr5=%#8.8x.\n",
 				   rtdev->name, csr5, inl(rtdev->base_addr + CSR5));
 
 		if (csr5 & (RxIntr | RxNoBuf)) {
@@ -259,7 +261,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 					/* There was an major error, log it. */
 #ifndef final_version
 					if (tulip_debug > 1)
-						/*RTnet*/rtdm_printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
+						/*RTnet*/pr_debug("%s: Transmit error, Tx status %8.8x.\n",
 							   rtdev->name, status);
 #endif
 					tp->stats.tx_errors++;
@@ -291,7 +293,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 
 #ifndef final_version
 			if (tp->cur_tx - dirty_tx > TX_RING_SIZE) {
-				/*RTnet*/rtdm_printk(KERN_ERR "%s: Out-of-sync dirty pointer, %d vs. %d.\n",
+				/*RTnet*/pr_err("%s: Out-of-sync dirty pointer, %d vs. %d.\n",
 					   rtdev->name, dirty_tx, tp->cur_tx);
 				dirty_tx += TX_RING_SIZE;
 			}
@@ -303,7 +305,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 			tp->dirty_tx = dirty_tx;
 			if (csr5 & TxDied) {
 				if (tulip_debug > 2)
-					/*RTnet*/rtdm_printk(KERN_WARNING "%s: The transmitter stopped."
+					/*RTnet*/pr_warn("%s: The transmitter stopped."
 						   "  CSR5 is %x, CSR6 %x, new CSR6 %x.\n",
 						   rtdev->name, csr5, inl(ioaddr + CSR6), tp->csr6);
 				tulip_restart_rxtx(tp);
@@ -315,7 +317,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 		if (csr5 & AbnormalIntr) {	/* Abnormal error summary bit. */
 			if (csr5 == 0xffffffff)
 				break;
-			/*RTnet*/rtdm_printk(KERN_ERR "%s: Error detected, "
+			/*RTnet*/pr_err("%s: Error detected, "
 			    "device may not work any more (csr5=%08x)!\n", rtdev->name, csr5);
 			/* Clear all error sources, included undocumented ones! */
 			outl(0x0800f7ba, ioaddr + CSR5);
@@ -324,7 +326,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 		if (csr5 & TimerInt) {
 
 			if (tulip_debug > 2)
-				/*RTnet*/rtdm_printk(KERN_ERR "%s: Re-enabling interrupts, %8.8x.\n",
+				/*RTnet*/pr_err("%s: Re-enabling interrupts, %8.8x.\n",
 					   rtdev->name, csr5);
 			outl(tulip_tbl[tp->chip_id].valid_intrs, ioaddr + CSR7);
 			tp->ttimer = 0;
@@ -332,7 +334,7 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 		}
 		if (tx > maxtx || rx > maxrx || oi > maxoi) {
 			if (tulip_debug > 1)
-				/*RTnet*/rtdm_printk(KERN_WARNING "%s: Too much work during an interrupt, "
+				/*RTnet*/pr_warn("%s: Too much work during an interrupt, "
 					   "csr5=0x%8.8x. (%lu) (%d,%d,%d)\n", rtdev->name, csr5, tp->nir, tx, rx, oi);
 
 		       /* Acknowledge all interrupt sources. */
@@ -364,13 +366,13 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 	entry = tp->dirty_rx % RX_RING_SIZE;
 	if (tp->rx_buffers[entry].skb == NULL) {
 		if (tulip_debug > 1)
-			/*RTnet*/rtdm_printk(KERN_WARNING "%s: in rx suspend mode: (%lu) (tp->cur_rx = %u, ttimer = %d, rx = %d) go/stay in suspend mode\n", rtdev->name, tp->nir, tp->cur_rx, tp->ttimer, rx);
+			/*RTnet*/pr_warn("%s: in rx suspend mode: (%lu) (tp->cur_rx = %u, ttimer = %d, rx = %d) go/stay in suspend mode\n", rtdev->name, tp->nir, tp->cur_rx, tp->ttimer, rx);
 		if (tp->chip_id == LC82C168)
 			outl(0x00, ioaddr + CSR7);
 		else {
 			if (tp->ttimer == 0 || (inl(ioaddr + CSR11) & 0xffff) == 0) {
 				if (tulip_debug > 1)
-					/*RTnet*/rtdm_printk(KERN_WARNING "%s: in rx suspend mode: (%lu) set timer\n", rtdev->name, tp->nir);
+					/*RTnet*/pr_warn("%s: in rx suspend mode: (%lu) set timer\n", rtdev->name, tp->nir);
 				outl(tulip_tbl[tp->chip_id].valid_intrs | TimerInt,
 					ioaddr + CSR7);
 				outl(TimerInt, ioaddr + CSR5);
@@ -385,8 +387,8 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 	}
 
 	if (tulip_debug > 4)
-		/*RTnet*/rtdm_printk(KERN_DEBUG "%s: exiting interrupt, csr5=%#4.4x.\n",
-			   rtdev->name, inl(ioaddr + CSR5));
+		/*RTnet*/pr_debug("%s: exiting interrupt, csr5=%#4.4x.\n",
+				  rtdev->name, inl(ioaddr + CSR5));
 	if (rx)
 		rt_mark_stack_mgr(rtdev);
 	return RTDM_IRQ_HANDLED;
diff --git a/kernel/drivers/net/drivers/tulip/media.c b/kernel/drivers/net/drivers/tulip/media.c
index 679a74ebe..a304f311a 100644
--- a/kernel/drivers/net/drivers/tulip/media.c
+++ b/kernel/drivers/net/drivers/tulip/media.c
@@ -15,6 +15,8 @@
 */
 /* Ported to RTnet by Wittawat Yamwong <wittawat@web.de> */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/init.h>
@@ -189,7 +191,7 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 		switch (mleaf->type) {
 		case 0:					/* 21140 non-MII xcvr. */
 			if (tulip_debug > 1)
-				/*RTnet*/rtdm_printk(KERN_DEBUG "%s: Using a 21140 non-MII transceiver"
+				/*RTnet*/pr_debug("%s: Using a 21140 non-MII transceiver"
 					   " with control setting %2.2x.\n",
 					   rtdev->name, p[1]);
 			rtdev->if_port = p[0];
@@ -212,13 +214,13 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 				struct medialeaf *rleaf = &mtable->mleaf[mtable->has_reset];
 				unsigned char *rst = rleaf->leafdata;
 				if (tulip_debug > 1)
-					/*RTnet*/rtdm_printk(KERN_DEBUG "%s: Resetting the transceiver.\n",
+					/*RTnet*/pr_debug("%s: Resetting the transceiver.\n",
 						   rtdev->name);
 				for (i = 0; i < rst[0]; i++)
 					outl(get_u16(rst + 1 + (i<<1)) << 16, ioaddr + CSR15);
 			}
 			if (tulip_debug > 1)
-				/*RTnet*/rtdm_printk(KERN_DEBUG "%s: 21143 non-MII %s transceiver control "
+				/*RTnet*/pr_debug("%s: 21143 non-MII %s transceiver control "
 					   "%4.4x/%4.4x.\n",
 					   rtdev->name, medianame[rtdev->if_port], setup[0], setup[1]);
 			if (p[0] & 0x40) {	/* SIA (CSR13-15) setup values are provided. */
@@ -247,7 +249,7 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 				if (startup) outl(csr13val, ioaddr + CSR13);
 			}
 			if (tulip_debug > 1)
-				/*RTnet*/rtdm_printk(KERN_DEBUG "%s:  Setting CSR15 to %8.8x/%8.8x.\n",
+				/*RTnet*/pr_debug("%s:  Setting CSR15 to %8.8x/%8.8x.\n",
 					   rtdev->name, csr15dir, csr15val);
 			if (mleaf->type == 4)
 				new_csr6 = 0x82020000 | ((setup[2] & 0x71) << 18);
@@ -292,7 +294,7 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 				if (tp->mii_advertise == 0)
 					tp->mii_advertise = tp->advertising[phy_num];
 				if (tulip_debug > 1)
-					/*RTnet*/rtdm_printk(KERN_DEBUG "%s:  Advertising %4.4x on MII %d.\n",
+					/*RTnet*/pr_debug("%s:  Advertising %4.4x on MII %d.\n",
 					       rtdev->name, tp->mii_advertise, tp->phys[phy_num]);
 				tulip_mdio_write(rtdev, tp->phys[phy_num], 4, tp->mii_advertise);
 			}
@@ -310,7 +312,7 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 				struct medialeaf *rleaf = &mtable->mleaf[mtable->has_reset];
 				unsigned char *rst = rleaf->leafdata;
 				if (tulip_debug > 1)
-					/*RTnet*/rtdm_printk(KERN_DEBUG "%s: Resetting the transceiver.\n",
+					/*RTnet*/pr_debug("%s: Resetting the transceiver.\n",
 						   rtdev->name);
 				for (i = 0; i < rst[0]; i++)
 					outl(get_u16(rst + 1 + (i<<1)) << 16, ioaddr + CSR15);
@@ -319,18 +321,18 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 			break;
 		}
 		default:
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s:  Invalid media table selection %d.\n",
+			/*RTnet*/pr_debug("%s:  Invalid media table selection %d.\n",
 					   rtdev->name, mleaf->type);
 			new_csr6 = 0x020E0000;
 		}
 		if (tulip_debug > 1)
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s: Using media type %s, CSR12 is %2.2x.\n",
+			/*RTnet*/pr_debug("%s: Using media type %s, CSR12 is %2.2x.\n",
 				   rtdev->name, medianame[rtdev->if_port],
 				   inl(ioaddr + CSR12) & 0xff);
 	} else if (tp->chip_id == DC21041) {
 		int port = rtdev->if_port <= 4 ? rtdev->if_port : 0;
 		if (tulip_debug > 1)
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s: 21041 using media %s, CSR12 is %4.4x.\n",
+			/*RTnet*/pr_debug("%s: 21041 using media %s, CSR12 is %4.4x.\n",
 				   rtdev->name, medianame[port == 3 ? 12: port],
 				   inl(ioaddr + CSR12));
 		outl(0x00000000, ioaddr + CSR13); /* Reset the serial interface */
@@ -342,7 +344,7 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 		if (startup && ! tp->medialock)
 			rtdev->if_port = tp->mii_cnt ? 11 : 0;
 		if (tulip_debug > 1)
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s: PNIC PHY status is %3.3x, media %s.\n",
+			/*RTnet*/pr_debug("%s: PNIC PHY status is %3.3x, media %s.\n",
 				   rtdev->name, inl(ioaddr + 0xB8), medianame[rtdev->if_port]);
 		if (tp->mii_cnt) {
 			new_csr6 = 0x810C0000;
@@ -368,7 +370,7 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 		/* Turn on the xcvr interface. */
 		int csr12 = inl(ioaddr + CSR12);
 		if (tulip_debug > 1)
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s: 21040 media type is %s, CSR12 is %2.2x.\n",
+			/*RTnet*/pr_debug("%s: 21040 media type is %s, CSR12 is %2.2x.\n",
 				   rtdev->name, medianame[rtdev->if_port], csr12);
 		if (tulip_media_cap[rtdev->if_port] & MediaAlwaysFD)
 			tp->full_duplex = 1;
@@ -394,7 +396,7 @@ void tulip_select_media(struct rtnet_device *rtdev, int startup)
 		} else
 			new_csr6 = 0x03860000;
 		if (tulip_debug > 1)
-			/*RTnet*/rtdm_printk(KERN_DEBUG "%s: No media description table, assuming "
+			/*RTnet*/pr_debug("%s: No media description table, assuming "
 				   "%s transceiver, CSR12 %2.2x.\n",
 				   rtdev->name, medianame[rtdev->if_port],
 				   inl(ioaddr + CSR12));
@@ -421,7 +423,7 @@ int tulip_check_duplex(struct rtnet_device *rtdev)
 	bmsr = tulip_mdio_read(rtdev, tp->phys[0], MII_BMSR);
 	lpa = tulip_mdio_read(rtdev, tp->phys[0], MII_LPA);
 	if (tulip_debug > 1)
-		/*RTnet*/rtdm_printk(KERN_INFO "%s: MII status %4.4x, Link partner report "
+		/*RTnet*/pr_info("%s: MII status %4.4x, Link partner report "
 			   "%4.4x.\n", rtdev->name, bmsr, lpa);
 	if (bmsr == 0xffff)
 		return -2;
@@ -429,7 +431,7 @@ int tulip_check_duplex(struct rtnet_device *rtdev)
 		int new_bmsr = tulip_mdio_read(rtdev, tp->phys[0], MII_BMSR);
 		if ((new_bmsr & BMSR_LSTATUS) == 0) {
 			if (tulip_debug  > 1)
-				/*RTnet*/rtdm_printk(KERN_INFO "%s: No link beat on the MII interface,"
+				/*RTnet*/pr_info("%s: No link beat on the MII interface,"
 					   " status %4.4x.\n", rtdev->name, new_bmsr);
 			return -1;
 		}
@@ -449,7 +451,7 @@ int tulip_check_duplex(struct rtnet_device *rtdev)
 		tulip_restart_rxtx(tp);
 
 		if (tulip_debug > 0)
-			/*RTnet*/rtdm_printk(KERN_INFO "%s: Setting %s-duplex based on MII"
+			/*RTnet*/pr_info("%s: Setting %s-duplex based on MII"
 				   "#%d link partner capability of %4.4x.\n",
 				   rtdev->name, tp->full_duplex ? "full" : "half",
 				   tp->phys[0], lpa);
@@ -507,13 +509,13 @@ void tulip_find_mii (struct rtnet_device *rtdev, int board_idx)
 
 		tp->phys[phy_idx++] = phy;
 
-		/*RTnet*/rtdm_printk(KERN_INFO "tulip%d:  MII transceiver #%d "
+		/*RTnet*/pr_info("tulip%d:  MII transceiver #%d "
 			"config %4.4x status %4.4x advertising %4.4x.\n",
 			board_idx, phy, mii_reg0, mii_status, mii_advert);
 
 		/* Fixup for DLink with miswired PHY. */
 		if (mii_advert != to_advert) {
-			/*RTnet*/rtdm_printk(KERN_DEBUG "tulip%d:  Advertising %4.4x on PHY %d,"
+			/*RTnet*/pr_debug("tulip%d:  Advertising %4.4x on PHY %d,"
 				" previously advertising %4.4x.\n",
 				board_idx, to_advert, phy, mii_advert);
 			tulip_mdio_write (rtdev, phy, 4, to_advert);
@@ -560,7 +562,7 @@ void tulip_find_mii (struct rtnet_device *rtdev, int board_idx)
 	}
 	tp->mii_cnt = phy_idx;
 	if (tp->mtable && tp->mtable->has_mii && phy_idx == 0) {
-		/*RTnet*/rtdm_printk(KERN_INFO "tulip%d: ***WARNING***: No MII transceiver found!\n",
+		/*RTnet*/pr_info("tulip%d: ***WARNING***: No MII transceiver found!\n",
 			board_idx);
 		tp->phys[0] = 1;
 	}
diff --git a/kernel/drivers/net/drivers/tulip/pnic.c b/kernel/drivers/net/drivers/tulip/pnic.c
index 7e57d7572..6e37cec4f 100644
--- a/kernel/drivers/net/drivers/tulip/pnic.c
+++ b/kernel/drivers/net/drivers/tulip/pnic.c
@@ -15,6 +15,8 @@
 */
 /* Ported to RTnet by Wittawat Yamwong <wittawat@web.de> */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include "tulip.h"
 
@@ -41,7 +43,7 @@ void pnic_do_nway(/*RTnet*/struct rtnet_device *rtdev)
 			new_csr6 |= 0x00000200;
 		}
 		if (tulip_debug > 1)
-			/*RTnet*/printk(KERN_DEBUG "%s: PNIC autonegotiated status %8.8x, %s.\n",
+			/*RTnet*/pr_debug("%s: PNIC autonegotiated status %8.8x, %s.\n",
 				   rtdev->name, phy_reg, medianame[rtdev->if_port]);
 		if (tp->csr6 != new_csr6) {
 			tp->csr6 = new_csr6;
diff --git a/kernel/drivers/net/drivers/tulip/pnic2.c b/kernel/drivers/net/drivers/tulip/pnic2.c
index e08f1ad9a..bb2e83bf9 100644
--- a/kernel/drivers/net/drivers/tulip/pnic2.c
+++ b/kernel/drivers/net/drivers/tulip/pnic2.c
@@ -16,6 +16,8 @@
 */
 /* Ported to RTnet by Wittawat Yamwong <wittawat@web.de> */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 
 /* Understanding the PNIC_II - everything is this file is based
  * on the PNIC_II_PDF datasheet which is sorely lacking in detail
@@ -111,10 +113,10 @@ void pnic2_start_nway(/*RTnet*/struct rtnet_device *rtdev)
         csr14 |= 0x00001184;
 
 	if (tulip_debug > 1)
-		printk(KERN_DEBUG "%s: Restarting PNIC2 autonegotiation, "
-                      "csr14=%8.8x.\n", rtdev->name, csr14);
+		pr_debug("%s: Restarting PNIC2 autonegotiation, csr14=%8.8x.\n",
+			 rtdev->name, csr14);
 
-        /* tell pnic2_lnk_change we are doing an nway negotiation */
+	/* tell pnic2_lnk_change we are doing an nway negotiation */
 	rtdev->if_port = 0;
 	tp->nway = tp->mediasense = 1;
 	tp->nwayset = tp->lpar = 0;
@@ -123,10 +125,10 @@ void pnic2_start_nway(/*RTnet*/struct rtnet_device *rtdev)
 
 	tp->csr6 = inl(ioaddr + CSR6);
 	if (tulip_debug > 1)
-		printk(KERN_DEBUG "%s: On Entry to Nway, "
-                      "csr6=%8.8x.\n", rtdev->name, tp->csr6);
+		pr_debug("%s: On Entry to Nway, csr6=%8.8x.\n", rtdev->name,
+			 tp->csr6);
 
-        /* mask off any bits not to touch
+	/* mask off any bits not to touch
          * comment at top of file explains mask value
          */
 	tp->csr6 = tp->csr6 & 0xfe3bd1fd;
diff --git a/kernel/drivers/net/drivers/tulip/tulip_core.c b/kernel/drivers/net/drivers/tulip/tulip_core.c
index 3d0b3dba6..23209f045 100644
--- a/kernel/drivers/net/drivers/tulip/tulip_core.c
+++ b/kernel/drivers/net/drivers/tulip/tulip_core.c
@@ -20,6 +20,8 @@
 #define DRV_VERSION	"0.9.15-pre11-rt"
 #define DRV_RELDATE	"May 11, 2002"
 
+#define pr_fmt(fmt) DRV_NAME ": " fmt
+
 #include <linux/module.h>
 #include "tulip.h"
 #include <linux/pci.h>
@@ -299,7 +301,7 @@ static void tulip_up(/*RTnet*/struct rtnet_device *rtdev)
 	udelay(100);
 
 	if (tulip_debug > 1)
-		printk(KERN_DEBUG "%s: tulip_up(), irq==%d.\n", rtdev->name, rtdev->irq);
+		pr_debug("%s: tulip_up(), irq==%d.\n", rtdev->name, rtdev->irq);
 
 	outl(tp->rx_ring_dma, ioaddr + CSR3);
 	outl(tp->tx_ring_dma, ioaddr + CSR4);
@@ -360,8 +362,8 @@ static void tulip_up(/*RTnet*/struct rtnet_device *rtdev)
 			(rtdev->if_port == 12 ? 0 : rtdev->if_port);
 		for (i = 0; i < tp->mtable->leafcount; i++)
 			if (tp->mtable->mleaf[i].media == looking_for) {
-				printk(KERN_INFO "%s: Using user-specified media %s.\n",
-					   rtdev->name, medianame[rtdev->if_port]);
+				pr_info("%s: Using user-specified media %s.\n",
+					rtdev->name, medianame[rtdev->if_port]);
 				goto media_picked;
 			}
 	}
@@ -369,8 +371,8 @@ static void tulip_up(/*RTnet*/struct rtnet_device *rtdev)
 		int looking_for = tp->mtable->defaultmedia & MEDIA_MASK;
 		for (i = 0; i < tp->mtable->leafcount; i++)
 			if (tp->mtable->mleaf[i].media == looking_for) {
-				printk(KERN_INFO "%s: Using EEPROM-set media %s.\n",
-					   rtdev->name, medianame[looking_for]);
+				pr_info("%s: Using EEPROM-set media %s.\n",
+					rtdev->name, medianame[looking_for]);
 				goto media_picked;
 			}
 	}
@@ -410,8 +412,9 @@ media_picked:
 		if (tp->mii_cnt) {
 			tulip_select_media(rtdev, 1);
 			if (tulip_debug > 1)
-				printk(KERN_INFO "%s: Using MII transceiver %d, status %4.4x.\n",
-					   rtdev->name, tp->phys[0], tulip_mdio_read(rtdev, tp->phys[0], 1));
+				pr_info("%s: Using MII transceiver %d, status %4.4x.\n",
+					rtdev->name, tp->phys[0],
+					tulip_mdio_read(rtdev, tp->phys[0], 1));
 			outl(csr6_mask_defstate, ioaddr + CSR6);
 			tp->csr6 = csr6_mask_hdcap;
 			rtdev->if_port = 11;
@@ -474,9 +477,10 @@ media_picked:
 	outl(0, ioaddr + CSR2);		/* Rx poll demand */
 
 	if (tulip_debug > 2) {
-		printk(KERN_DEBUG "%s: Done tulip_up(), CSR0 %8.8x, CSR5 %8.8x CSR6 %8.8x.\n",
-			   rtdev->name, inl(ioaddr + CSR0), inl(ioaddr + CSR5),
-			   inl(ioaddr + CSR6));
+		pr_debug(
+			"%s: Done tulip_up(), CSR0 %8.8x, CSR5 %8.8x CSR6 %8.8x.\n",
+			rtdev->name, inl(ioaddr + CSR0), inl(ioaddr + CSR5),
+			inl(ioaddr + CSR6));
 	}
 }
 
@@ -490,8 +494,8 @@ tulip_open(/*RTnet*/struct rtnet_device *rtdev)
 	if ((retval = /*RTnet*/rtdm_irq_request(&tp->irq_handle, rtdev->irq,
 						tulip_interrupt, 0, "rt_tulip",
 						rtdev))) {
-		printk("%s: Unable to install ISR for IRQ %d\n",
-			  rtdev->name,rtdev->irq);
+		pr_err("%s: Unable to install ISR for IRQ %d\n", rtdev->name,
+		       rtdev->irq);
 		return retval;
 	}
 
@@ -716,8 +720,8 @@ static int tulip_close (/*RTnet*/struct rtnet_device *rtdev)
 	tulip_down (rtdev);
 
 	if (tulip_debug > 1)
-		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %2.2x.\n",
-			rtdev->name, inl (ioaddr + CSR5));
+		pr_debug("%s: Shutting down ethercard, status was %2.2x.\n",
+			 rtdev->name, inl(ioaddr + CSR5));
 
 	rtdm_irq_free(&tp->irq_handle);
 
@@ -757,8 +761,7 @@ static int tulip_close (/*RTnet*/struct rtnet_device *rtdev)
 }
 
 #ifdef XXX_CONFIG_TULIP_MWI
-static void tulip_mwi_config (struct pci_dev *pdev,
-					struct net_device *dev)
+static void tulip_mwi_config(struct pci_dev *pdev, struct net_device *dev)
 {
 	struct tulip_private *tp = rtdev->priv;
 	u8 cache;
@@ -766,7 +769,7 @@ static void tulip_mwi_config (struct pci_dev *pdev,
 	u32 csr0;
 
 	if (tulip_debug > 3)
-		printk(KERN_DEBUG "%s: tulip_mwi_config()\n", pci_name(pdev));
+		pr_debug("%s: tulip_mwi_config()\n", pci_name(pdev));
 
 	tp->csr0 = csr0 = 0;
 
@@ -780,8 +783,10 @@ static void tulip_mwi_config (struct pci_dev *pdev,
 	/* set or disable MWI in the standard PCI command bit.
 	 * Check for the case where  mwi is desired but not available
 	 */
-	if (csr0 & MWI)	pci_set_mwi(pdev);
-	else		pci_clear_mwi(pdev);
+	if (csr0 & MWI)
+		pci_set_mwi(pdev);
+	else
+		pci_clear_mwi(pdev);
 
 	/* read result from hardware (in case bit refused to enable) */
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
@@ -833,8 +838,8 @@ static void tulip_mwi_config (struct pci_dev *pdev,
 out:
 	tp->csr0 = csr0;
 	if (tulip_debug > 2)
-		printk(KERN_DEBUG "%s: MWI config cacheline=%d, csr0=%08x\n",
-		       pci_name(pdev), cache, csr0);
+		pr_debug("%s: MWI config cacheline=%d, csr0=%08x\n",
+			 pci_name(pdev), cache, csr0);
 }
 #endif
 
@@ -866,8 +871,8 @@ static int tulip_init_one (struct pci_dev *pdev,
 
 #ifndef MODULE
 	static int did_version;		/* Already printed version info. */
-	if (tulip_debug > 0  &&  did_version++ == 0)
-		printk(KERN_INFO "%s", version);
+	if (tulip_debug > 0 && did_version++ == 0)
+		pr_info("%s", version);
 #endif
 
 	board_idx++;
@@ -881,7 +886,7 @@ static int tulip_init_one (struct pci_dev *pdev,
 	 */
 
 	if (pdev->subsystem_vendor == PCI_VENDOR_ID_LMC) {
-		printk(KERN_ERR PFX "skipping LMC card.\n");
+		pr_err("skipping LMC card.\n");
 		return -ENODEV;
 	}
 
@@ -896,7 +901,7 @@ static int tulip_init_one (struct pci_dev *pdev,
 		pci_read_config_dword(pdev, PCI_REVISION_ID, &dev_rev);
 		if(dev_rev < 0x02000030)
 		{
-			printk(KERN_ERR PFX "skipping early DM9100 with Crc bug (use dmfe)\n");
+			pr_err("skipping early DM9100 with Crc bug (use dmfe)\n");
 			return -ENODEV;
 		}
 	}
@@ -943,9 +948,7 @@ static int tulip_init_one (struct pci_dev *pdev,
 
 	i = pci_enable_device(pdev);
 	if (i) {
-		printk(KERN_ERR PFX
-			"Cannot enable tulip board #%d, aborting\n",
-			board_idx);
+		pr_err("Cannot enable tulip board #%d, aborting\n", board_idx);
 		return i;
 	}
 
@@ -956,7 +959,7 @@ static int tulip_init_one (struct pci_dev *pdev,
 	rtdev = /*RTnet*/rt_alloc_etherdev (sizeof (*tp),
 					RX_RING_SIZE * 2 + TX_RING_SIZE);
 	if (!rtdev) {
-		printk(KERN_ERR PFX "ether device alloc failed, aborting\n");
+		pr_err("ether device alloc failed, aborting\n");
 		return -ENOMEM;
 	}
 	//rtdev_alloc_name(rtdev, "eth%d");//Done by register_rtdev()
@@ -965,10 +968,10 @@ static int tulip_init_one (struct pci_dev *pdev,
 	rtdev->sysbind = &pdev->dev;
 
 	if (pci_resource_len (pdev, 0) < tulip_tbl[chip_idx].io_size) {
-		printk(KERN_ERR PFX "%s: I/O region (0x%llx@0x%llx) too small, "
-			"aborting\n", pci_name(pdev),
-			(unsigned long long)pci_resource_len (pdev, 0),
-			(unsigned long long)pci_resource_start (pdev, 0));
+		pr_err("%s: I/O region (0x%llx@0x%llx) too small, aborting\n",
+		       pci_name(pdev),
+		       (unsigned long long)pci_resource_len(pdev, 0),
+		       (unsigned long long)pci_resource_start(pdev, 0));
 		goto err_out_free_netdev;
 	}
 
@@ -1177,8 +1180,8 @@ static int tulip_init_one (struct pci_dev *pdev,
 	if (rtdev->mem_start & MEDIA_MASK)
 		tp->default_port = rtdev->mem_start & MEDIA_MASK;
 	if (tp->default_port) {
-		printk(KERN_INFO "tulip%d: Transceiver selection forced to %s.\n",
-		       board_idx, medianame[tp->default_port & MEDIA_MASK]);
+		pr_info("tulip%d: Transceiver selection forced to %s.\n",
+			board_idx, medianame[tp->default_port & MEDIA_MASK]);
 		tp->medialock = 1;
 		if (tulip_media_cap[tp->default_port] & MediaAlwaysFD)
 			tp->full_duplex = 1;
@@ -1230,21 +1233,18 @@ static int tulip_init_one (struct pci_dev *pdev,
 		goto err_out_free_ring;
 	}
 
-	printk(KERN_INFO "%s: %s rev %d at %#3lx,",
-	       rtdev->name, tulip_tbl[chip_idx].chip_name, chip_rev, ioaddr);
 	pci_set_drvdata(pdev, rtdev);
 
-	if (t2104x_mode == 1)
-		printk(" 21040 compatible mode,");
-	else if (t2104x_mode == 2)
-		printk(" 21041 mode,");
-	if (eeprom_missing)
-		printk(" EEPROM not present,");
-	for (i = 0; i < 6; i++)
-		printk("%c%2.2X", i ? ':' : ' ', rtdev->dev_addr[i]);
-	printk(", IRQ %d.\n", irq);
+	pr_info("%s: %s rev %d at %#3lx,%s%s%s %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X, IRQ %d",
+		rtdev->name, tulip_tbl[chip_idx].chip_name, chip_rev, ioaddr,
+		t2104x_mode == 1 ? " 21040 compatible mode," : "",
+		t2104x_mode == 2 ? " 21041 mode," : "",
+		eeprom_missing ? " EEPROM not present," : "",
+		rtdev->dev_addr[0], rtdev->dev_addr[1], rtdev->dev_addr[2],
+		rtdev->dev_addr[3], rtdev->dev_addr[4], rtdev->dev_addr[5],
+		irq);
 
-/*RTnet
+	/*RTnet
 	if (tp->chip_id == PNIC2)
 		tp->link_change = pnic2_lnk_change;
 	else if ((tp->flags & HAS_NWAY)  || tp->chip_id == DC21041)
@@ -1384,7 +1384,7 @@ static struct pci_driver tulip_driver = {
 static int __init tulip_init (void)
 {
 #ifdef MODULE
-	printk(KERN_INFO "%s", version);
+	pr_info("%s", version);
 #endif
 
 	/* copy module parms into globals */

-- 
2.39.2

