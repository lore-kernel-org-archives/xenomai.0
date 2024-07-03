Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6617A596
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013152; cv=none; b=HlxQeqKiF942cfPmWOtEDM41pUzCrbOkXKx2UYym3lIaw+8jwzLkm2AWxK4t+F5xVOztaXbODFKFGGgbzQGMRLfRih4373HweH+B6HIHvWjJ9hWsygU/MC2y0DluggLvFpCvm2WHlxhE7IRqEutk7f1qwg9/k2WtnXyFJgwpAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013152; c=relaxed/simple;
	bh=cgMGEbXiMsh7tn1TYTRaTJotEQoR/bBO+ge/AR3V0r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYye6h3Ou030PDwGiiAV+zbmcDoXG2KyzQ3U8sKHk/wtmD8FuYZC+Ga0JjhfiC4DFHROkeBmXkO2+6b5uTre50Ra8mEQEa5qUg/7DJ7SwZt3IWO/BzsKBES43bsY0CwYnCUa8WYAD8FFdRZYbiudEt0vvTX9teS5sjKxFC45A8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=uDeZ4QLl; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="uDeZ4QLl"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240703132542ee598e48378527fce9
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XTHTTZJqE23aIV/+e5iIfz5yH4bj5BLc1U4IReM8drk=;
 b=uDeZ4QLlqqJweqmDmm+T9uC5JNnyBVhslRoc81BexFdobSGJSllz43bvBAKQfaLF0h0u7N
 VCt+E7mutGEzBYl8V2vejjQcIcgMrQM0uEFpFODAvfSfiZbLXgSXs3MVcMOC8EtHlUEYv2YU
 /u3znSmfGDpNNmOWCV3c2Y5IVLg2A=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:33 +0200
Subject: [PATCH 10/33] drivers/net/e1000e: Migrate from printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-10-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In this case log levels were correct. Migrating to pr_*() to keep
consistent with other drivers. Info messages have been synced with
the upstream Linux driver (Linux 6.9).

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/e1000e/netdev.c | 205 +++++++++++++----------------
 1 file changed, 92 insertions(+), 113 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index dab8e9b7f..04312a54b 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -167,16 +167,13 @@ static void e1000_regdump(struct e1000_hw *hw, struct e1000_reg_info *reginfo)
 			regs[n] = __er32(hw, E1000_TARC(n));
 		break;
 	default:
-		printk(KERN_INFO "%-15s %08x\n",
+		pr_info("%-15s %08x\n",
 		       reginfo->name, __er32(hw, reginfo->ofs));
 		return;
 	}
 
 	snprintf(rname, 16, "%s%s", reginfo->name, "[0-1]");
-	printk(KERN_INFO "%-15s ", rname);
-	for (n = 0; n < 2; n++)
-		printk(KERN_CONT "%08x ", regs[n]);
-	printk(KERN_CONT "\n");
+	pr_info("%-15s %08x %08x\n", rname, regs[0], regs[1]);
 }
 
 /*
@@ -212,14 +209,14 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 	/* Print netdevice Info */
 	if (netdev) {
 		dev_info(&adapter->pdev->dev, "Net device Info\n");
-		printk(KERN_INFO "Device Name     state            "
-		       "trans_start      last_rx\n");
-		printk(KERN_INFO "%-15s\n", netdev->name);
+		pr_info("Device Name     state            "
+			"trans_start      last_rx\n");
+		pr_info("%-15s\n", netdev->name);
 	}
 
 	/* Print Registers */
 	dev_info(&adapter->pdev->dev, "Register Dump\n");
-	printk(KERN_INFO " Register Name   Value\n");
+	pr_info(" Register Name   Value\n");
 	for (reginfo = (struct e1000_reg_info *)e1000_reg_info_tbl;
 	     reginfo->name; reginfo++) {
 		e1000_regdump(hw, reginfo);
@@ -230,15 +227,14 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 		goto exit;
 
 	dev_info(&adapter->pdev->dev, "Tx Ring Summary\n");
-	printk(KERN_INFO "Queue [NTU] [NTC] [bi(ntc)->dma  ]"
-	       " leng ntw timestamp\n");
+	pr_info("Queue [NTU] [NTC] [bi(ntc)->dma  ] leng ntw timestamp\n");
 	buffer_info = &tx_ring->buffer_info[tx_ring->next_to_clean];
-	printk(KERN_INFO " %5d %5X %5X %016llX %04X %3X %016llX\n",
-	       0, tx_ring->next_to_use, tx_ring->next_to_clean,
-	       (unsigned long long)buffer_info->dma,
-	       buffer_info->length,
-	       buffer_info->next_to_watch,
-	       (unsigned long long)buffer_info->time_stamp);
+	pr_info(" %5d %5X %5X %016llX %04X %3X %016llX\n",
+		0, tx_ring->next_to_use, tx_ring->next_to_clean,
+		(unsigned long long)buffer_info->dma,
+		buffer_info->length,
+		buffer_info->next_to_watch,
+		(unsigned long long)buffer_info->time_stamp);
 
 	/* Print Tx Ring */
 	if (!netif_msg_tx_done(adapter))
@@ -273,37 +269,32 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 	 *   +----------------------------------------------------------------+
 	 *   63       48 47     40 39  36 35    32 31     24 23  20 19        0
 	 */
-	printk(KERN_INFO "Tl[desc]     [address 63:0  ] [SpeCssSCmCsLen]"
-	       " [bi->dma       ] leng  ntw timestamp        bi->skb "
-	       "<-- Legacy format\n");
-	printk(KERN_INFO "Tc[desc]     [Ce CoCsIpceCoS] [MssHlRSCm0Plen]"
-	       " [bi->dma       ] leng  ntw timestamp        bi->skb "
-	       "<-- Ext Context format\n");
-	printk(KERN_INFO "Td[desc]     [address 63:0  ] [VlaPoRSCm1Dlen]"
-	       " [bi->dma       ] leng  ntw timestamp        bi->skb "
-	       "<-- Ext Data format\n");
+	pr_info("Tl[desc]     [address 63:0  ] [SpeCssSCmCsLen] [bi->dma       ] leng  ntw timestamp        bi->skb <-- Legacy format\n");
+	pr_info("Tc[desc]     [Ce CoCsIpceCoS] [MssHlRSCm0Plen] [bi->dma       ] leng  ntw timestamp        bi->skb <-- Ext Context format\n");
+	pr_info("Td[desc]     [address 63:0  ] [VlaPoRSCm1Dlen] [bi->dma       ] leng  ntw timestamp        bi->skb <-- Ext Data format\n");
 	for (i = 0; tx_ring->desc && (i < tx_ring->count); i++) {
+		const char *next_desc;
 		tx_desc = E1000_TX_DESC(*tx_ring, i);
 		buffer_info = &tx_ring->buffer_info[i];
 		u0 = (struct my_u0 *)tx_desc;
-		printk(KERN_INFO "T%c[0x%03X]    %016llX %016llX %016llX "
-		       "%04X  %3X %016llX %p",
-		       (!(le64_to_cpu(u0->b) & (1 << 29)) ? 'l' :
-			((le64_to_cpu(u0->b) & (1 << 20)) ? 'd' : 'c')), i,
-		       (unsigned long long)le64_to_cpu(u0->a),
-		       (unsigned long long)le64_to_cpu(u0->b),
-		       (unsigned long long)buffer_info->dma,
-		       buffer_info->length, buffer_info->next_to_watch,
-		       (unsigned long long)buffer_info->time_stamp,
-		       buffer_info->skb);
 		if (i == tx_ring->next_to_use && i == tx_ring->next_to_clean)
-			printk(KERN_CONT " NTC/U\n");
+			next_desc = " NTC/U";
 		else if (i == tx_ring->next_to_use)
-			printk(KERN_CONT " NTU\n");
+			next_desc = " NTU";
 		else if (i == tx_ring->next_to_clean)
-			printk(KERN_CONT " NTC\n");
+			next_desc = " NTC";
 		else
-			printk(KERN_CONT "\n");
+			next_desc = "";
+		pr_info("T%c[0x%03X]    %016llX %016llX %016llX %04X  %3X %016llX %p%s\n",
+			(!(le64_to_cpu(u0->b) & BIT(29)) ? 'l' :
+			 ((le64_to_cpu(u0->b) & BIT(20)) ? 'd' : 'c')),
+			i,
+			(unsigned long long)le64_to_cpu(u0->a),
+			(unsigned long long)le64_to_cpu(u0->b),
+			(unsigned long long)buffer_info->dma,
+			buffer_info->length, buffer_info->next_to_watch,
+			(unsigned long long)buffer_info->time_stamp,
+			buffer_info->skb, next_desc);
 
 		if (netif_msg_pktdata(adapter) && buffer_info->dma != 0)
 			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS,
@@ -314,8 +305,8 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 	/* Print Rx Ring Summary */
 rx_ring_summary:
 	dev_info(&adapter->pdev->dev, "Rx Ring Summary\n");
-	printk(KERN_INFO "Queue [NTU] [NTC]\n");
-	printk(KERN_INFO " %5d %5X %5X\n", 0,
+	pr_info("Queue [NTU] [NTC]\n");
+	pr_info(" %5d %5X %5X\n", 0,
 	       rx_ring->next_to_use, rx_ring->next_to_clean);
 
 	/* Print Rx Ring */
@@ -339,10 +330,7 @@ rx_ring_summary:
 		 * 24 |                Buffer Address 3 [63:0]              |
 		 *    +-----------------------------------------------------+
 		 */
-		printk(KERN_INFO "R  [desc]      [buffer 0 63:0 ] "
-		       "[buffer 1 63:0 ] "
-		       "[buffer 2 63:0 ] [buffer 3 63:0 ] [bi->dma       ] "
-		       "[bi->skb] <-- Ext Pkt Split format\n");
+		pr_info("R  [desc]      [buffer 0 63:0 ] [buffer 1 63:0 ] [buffer 2 63:0 ] [buffer 3 63:0 ] [bi->dma       ] [bi->skb] <-- Ext Pkt Split format\n");
 		/* [Extended] Receive Descriptor (Write-Back) Format
 		 *
 		 *   63       48 47    32 31     13 12    8 7    4 3        0
@@ -354,35 +342,40 @@ rx_ring_summary:
 		 *   +------------------------------------------------------+
 		 *   63       48 47    32 31            20 19               0
 		 */
-		printk(KERN_INFO "RWB[desc]      [ck ipid mrqhsh] "
-		       "[vl   l0 ee  es] "
-		       "[ l3  l2  l1 hs] [reserved      ] ---------------- "
-		       "[bi->skb] <-- Ext Rx Write-Back format\n");
+		pr_info("RWB[desc]      [ck ipid mrqhsh] [vl   l0 ee  es] [ l3  l2  l1 hs] [reserved      ] ---------------- [bi->skb] <-- Ext Rx Write-Back format\n");
 		for (i = 0; i < rx_ring->count; i++) {
+			const char *next_desc;
 			buffer_info = &rx_ring->buffer_info[i];
 			rx_desc_ps = E1000_RX_DESC_PS(*rx_ring, i);
 			u1 = (struct my_u1 *)rx_desc_ps;
 			staterr =
 			    le32_to_cpu(rx_desc_ps->wb.middle.status_error);
+
+			if (i == rx_ring->next_to_use)
+				next_desc = " NTU";
+			else if (i == rx_ring->next_to_clean)
+				next_desc = " NTC";
+			else
+				next_desc = "";
+
 			if (staterr & E1000_RXD_STAT_DD) {
 				/* Descriptor Done */
-				printk(KERN_INFO "RWB[0x%03X]     %016llX "
-				       "%016llX %016llX %016llX "
-				       "---------------- %p", i,
-				       (unsigned long long)le64_to_cpu(u1->a),
-				       (unsigned long long)le64_to_cpu(u1->b),
-				       (unsigned long long)le64_to_cpu(u1->c),
-				       (unsigned long long)le64_to_cpu(u1->d),
-				       buffer_info->skb);
+				pr_info("%s[0x%03X]     %016llX %016llX %016llX %016llX ---------------- %p%s\n",
+					"RWB", i,
+					(unsigned long long)le64_to_cpu(u1->a),
+					(unsigned long long)le64_to_cpu(u1->b),
+					(unsigned long long)le64_to_cpu(u1->c),
+					(unsigned long long)le64_to_cpu(u1->d),
+					buffer_info->skb, next_desc);
 			} else {
-				printk(KERN_INFO "R  [0x%03X]     %016llX "
-				       "%016llX %016llX %016llX %016llX %p", i,
-				       (unsigned long long)le64_to_cpu(u1->a),
-				       (unsigned long long)le64_to_cpu(u1->b),
-				       (unsigned long long)le64_to_cpu(u1->c),
-				       (unsigned long long)le64_to_cpu(u1->d),
-				       (unsigned long long)buffer_info->dma,
-				       buffer_info->skb);
+				pr_info("%s[0x%03X]     %016llX %016llX %016llX %016llX %016llX %p%s\n",
+					"R  ", i,
+					(unsigned long long)le64_to_cpu(u1->a),
+					(unsigned long long)le64_to_cpu(u1->b),
+					(unsigned long long)le64_to_cpu(u1->c),
+					(unsigned long long)le64_to_cpu(u1->d),
+					(unsigned long long)buffer_info->dma,
+					buffer_info->skb, next_desc);
 
 				if (netif_msg_pktdata(adapter))
 					print_hex_dump(KERN_INFO, "",
@@ -390,13 +383,6 @@ rx_ring_summary:
 						phys_to_virt(buffer_info->dma),
 						adapter->rx_ps_bsize0, true);
 			}
-
-			if (i == rx_ring->next_to_use)
-				printk(KERN_CONT " NTU\n");
-			else if (i == rx_ring->next_to_clean)
-				printk(KERN_CONT " NTC\n");
-			else
-				printk(KERN_CONT "\n");
 		}
 		break;
 	default:
@@ -409,9 +395,7 @@ rx_ring_summary:
 		 * 8 |                      Reserved                       |
 		 *   +-----------------------------------------------------+
 		 */
-		printk(KERN_INFO "R  [desc]      [buf addr 63:0 ] "
-		       "[reserved 63:0 ] [bi->dma       ] "
-		       "[bi->skb] <-- Ext (Read) format\n");
+		pr_info("R  [desc]      [buf addr 63:0 ] [reserved 63:0 ] [bi->dma       ] [bi->skb] <-- Ext (Read) format\n");
 		/* Extended Receive Descriptor (Write-Back) Format
 		 *
 		 *   63       48 47    32 31    24 23            4 3        0
@@ -425,29 +409,37 @@ rx_ring_summary:
 		 *   +------------------------------------------------------+
 		 *   63       48 47    32 31            20 19               0
 		 */
-		printk(KERN_INFO "RWB[desc]      [cs ipid    mrq] "
-		       "[vt   ln xe  xs] "
-		       "[bi->skb] <-- Ext (Write-Back) format\n");
+		pr_info("RWB[desc]      [cs ipid    mrq] [vt   ln xe  xs] [bi->skb] <-- Ext (Write-Back) format\n");
 
 		for (i = 0; i < rx_ring->count; i++) {
+			const char *next_desc;
+
 			buffer_info = &rx_ring->buffer_info[i];
 			rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
 			u1 = (struct my_u1 *)rx_desc;
 			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
+
+			if (i == rx_ring->next_to_use)
+				next_desc = " NTU";
+			else if (i == rx_ring->next_to_clean)
+				next_desc = " NTC";
+			else
+				next_desc = "";
+
 			if (staterr & E1000_RXD_STAT_DD) {
 				/* Descriptor Done */
-				printk(KERN_INFO "RWB[0x%03X]     %016llX "
-				       "%016llX ---------------- %p", i,
-				       (unsigned long long)le64_to_cpu(u1->a),
-				       (unsigned long long)le64_to_cpu(u1->b),
-				       buffer_info->skb);
+				pr_info("%s[0x%03X]     %016llX %016llX ---------------- %p%s\n",
+					"RWB", i,
+					(unsigned long long)le64_to_cpu(u1->a),
+					(unsigned long long)le64_to_cpu(u1->b),
+					buffer_info->skb, next_desc);
 			} else {
-				printk(KERN_INFO "R  [0x%03X]     %016llX "
-				       "%016llX %016llX %p", i,
-				       (unsigned long long)le64_to_cpu(u1->a),
-				       (unsigned long long)le64_to_cpu(u1->b),
-				       (unsigned long long)buffer_info->dma,
-				       buffer_info->skb);
+				pr_info("%s[0x%03X]     %016llX %016llX %016llX %p%s\n",
+					"R  ", i,
+					(unsigned long long)le64_to_cpu(u1->a),
+					(unsigned long long)le64_to_cpu(u1->b),
+					(unsigned long long)buffer_info->dma,
+					buffer_info->skb, next_desc);
 
 				if (netif_msg_pktdata(adapter))
 					print_hex_dump(KERN_INFO, "",
@@ -458,13 +450,6 @@ rx_ring_summary:
 						       adapter->rx_buffer_len,
 						       true);
 			}
-
-			if (i == rx_ring->next_to_use)
-				printk(KERN_CONT " NTU\n");
-			else if (i == rx_ring->next_to_clean)
-				printk(KERN_CONT " NTC\n");
-			else
-				printk(KERN_CONT "\n");
 		}
 	}
 
@@ -2937,16 +2922,13 @@ static void e1000_print_link_info(struct e1000_adapter *adapter)
 	u32 ctrl = er32(CTRL);
 
 	/* Link status message must follow this format for user tools */
-	printk(KERN_INFO "e1000e: %s NIC Link is Up %d Mbps %s, "
-	       "Flow Control: %s\n",
-	       adapter->netdev->name,
-	       adapter->link_speed,
-	       (adapter->link_duplex == FULL_DUPLEX) ?
-	       "Full Duplex" : "Half Duplex",
-	       ((ctrl & E1000_CTRL_TFCE) && (ctrl & E1000_CTRL_RFCE)) ?
-	       "Rx/Tx" :
-	       ((ctrl & E1000_CTRL_RFCE) ? "Rx" :
-		((ctrl & E1000_CTRL_TFCE) ? "Tx" : "None")));
+	pr_info("%s: NIC Link is Up %d Mbps %s Duplex, Flow Control: %s\n",
+		adapter->netdev->name, adapter->link_speed,
+		adapter->link_duplex == FULL_DUPLEX ? "Full" : "Half",
+		(ctrl & E1000_CTRL_TFCE) && (ctrl & E1000_CTRL_RFCE) ? "Rx/Tx" :
+		(ctrl & E1000_CTRL_RFCE)			     ? "Rx" :
+		(ctrl & E1000_CTRL_TFCE)			     ? "Tx" :
+								       "None");
 }
 
 static bool e1000e_has_link(struct e1000_adapter *adapter)
@@ -3086,10 +3068,7 @@ static void e1000_watchdog_task(struct work_struct *work)
 				e1e_rphy(hw, PHY_AUTONEG_EXP, &autoneg_exp);
 
 				if (!(autoneg_exp & NWAY_ER_LP_NWAY_CAPS))
-					e_info("Autonegotiated half duplex but"
-					       " link partner cannot autoneg. "
-					       " Try forcing full duplex if "
-					       "link gets many collisions.\n");
+					e_info("Autonegotiated half duplex but link partner cannot autoneg.  Try forcing full duplex if link gets many collisions.\n");
 			}
 
 			/* adjust timeout factor according to speed/duplex */
@@ -3165,8 +3144,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 			adapter->link_speed = 0;
 			adapter->link_duplex = 0;
 			/* Link status message must follow this format */
-			printk(KERN_INFO "e1000e: %s NIC Link is Down\n",
-			       adapter->netdev->name);
+			pr_info("%s: NIC Link is Down\n",
+				adapter->netdev->name);
 			rtnetif_carrier_off(netdev);
 			if (!test_bit(__E1000_DOWN, &adapter->state))
 				mod_timer(&adapter->phy_info_timer,

-- 
2.39.2

