Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14717A59F
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013150; cv=none; b=c1S/Vs9e+JSjY0UFCYAGmCtz+WlURcrxU3UCSqOrkBdlNWhGWRJogygGUUfhApFz3xfebZ0K4vClDYwXBW5fv7e9PE/yPRaLLhB0Tp7SRvrPYqhLBk8ktRQrKy95XQxDinInazNAw+jLG6aNK+K1C6zKkreGi8TM4l7X4AOy/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013150; c=relaxed/simple;
	bh=TBrd+jplLSY7jLLASgPk2Y9Uiwt/frdVxRqC1Y0YI54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdcCn5ULiazLFffFL6PmVbzZP2PMgNBlvbC7bYg0p5svW0FvJKSYdfMgBS8HwlMHCHP11e3iwXSL/am2ePI6HRrBxjwrZZatitsM94MCu5VjMBrEdt3+DFI0R1lUAX6H2swUpf04ojHfZAIGIRSAaC1LvZnT2dPClA/0wQojewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=u7f5sjDq; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="u7f5sjDq"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202407031325469592b6a02177aa178a
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z4+KkCGjDgviKG4/VqcF5gri7ueKDJS0ehVEFeNresg=;
 b=u7f5sjDqDSAneH6oKxCbJ132jGDCbbcJdr50IXxBwRhdx32zBcnKGqdMAXV/PWzuRiQ8o6
 Y6us2PXWSF8Ko6qicZ//rA2tzSFlhk6ks2MZptJhVoIXRx+EarWQHjB2CvfMsuAYrefbRuXc
 bC2MYY7yffK6/mhTz9YYvwXU3oat0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:44 +0200
Subject: [PATCH 21/33] drivers/r8169: Remove RT_DBG_PRINT() macro
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-21-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is no difference between the DBG_PRINT() and RT_DBG_PRINT()
macro anymore.

Removing RT_DBG_PRINT().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/r8169.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index b470ddb51..22d2697b0 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -102,14 +102,11 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 	/*** RTnet / <kk>: rt_assert must be used instead of assert() within interrupt context! ***/
 	#define rt_assert(expr) \
 		if(!(expr)) { pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
-	/*** RTnet / <kk>: RT_DBG_PRINT must be used instead of DBG_PRINT() within interrupt context! ***/
 	#define DBG_PRINT( fmt, args...)   pr_debug(fmt, ## args);
-	#define RT_DBG_PRINT( fmt, args...)   pr_debug(fmt, ## args);
 #else
 	#define assert(expr) do {} while (0)
 	#define rt_assert(expr) do {} while (0)
 	#define DBG_PRINT( fmt, args...)   ;
-	#define RT_DBG_PRINT( fmt, args...)   ;
 #endif	// end of #ifdef RTL8169_DEBUG
 
 /* media options */
@@ -1427,7 +1424,7 @@ static int rtl8169_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 			}
 
 			/* print frame informations */
-			RT_DBG_PRINT("%s: TX len = %d, skb->len = %d, eth_proto=%04x\n", __FUNCTION__, len, skb->len, proto);
+			DBG_PRINT("%s: TX len = %d, skb->len = %d, eth_proto=%04x\n", __FUNCTION__, len, skb->len, proto);
 
 			break;	/* leave loop */
 		}
@@ -1621,7 +1618,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 					priv->Rx_skbuff[cur_rx] = n_skb;
 				}
 				else{
-					RT_DBG_PRINT("%s: Allocate n_skb failed! (priv->rx_buf_size = %d)\n",__FUNCTION__, priv->rx_buf_size );
+					DBG_PRINT("%s: Allocate n_skb failed! (priv->rx_buf_size = %d)\n",__FUNCTION__, priv->rx_buf_size );
 					priv->Rx_skbuff[cur_rx] = rx_skb;
 				}
 
@@ -1641,7 +1638,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 					rxdesc->buf_addr = cpu_to_le32(priv->rx_skbuff_dma_addr[cur_rx]);
 				}
 				else{
-					RT_DBG_PRINT("%s: %s() cur_skb == NULL\n", rtdev->name, __FUNCTION__);
+					DBG_PRINT("%s: %s() cur_skb == NULL\n", rtdev->name, __FUNCTION__);
 				}
 
 			}//------------------------------------------------------------
@@ -1655,7 +1652,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 	}// end of while ( (priv->RxDescArray[cur_rx].status & 0x80000000)== 0)
 
 	if( rxdesc_cnt >= max_interrupt_work ){
-		RT_DBG_PRINT("%s: Too much work at Rx interrupt.\n", rtdev->name);
+		DBG_PRINT("%s: Too much work at Rx interrupt.\n", rtdev->name);
 	}
 
 	priv->cur_rx = cur_rx;
@@ -1707,7 +1704,7 @@ static int rtl8169_interrupt(rtdm_irq_t *irq_handle)
 		}
 
 		if (unlikely(status & SYSErr)) {
-			RT_DBG_PRINT("PCI error...!? %i\n", __LINE__);
+			DBG_PRINT("PCI error...!? %i\n", __LINE__);
 			rtl8169_pcierr_interrupt(rtdev);
 			break;
 		}

-- 
2.39.2

