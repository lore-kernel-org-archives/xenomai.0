Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F715ADA7
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781344; cv=none; b=km+IMRVkhjtM4DRMfAW+y3JDmcF69ddTzXjLJyM0mRVTQULK+JsUIh50udJYe4WX9nKwhmbmqB3rmXIZkuH/njfO0ujQAdFN/Ov7LZQtzDMy/VBVx0aQrP/Xp3U8rH87DKf1c55k9sE8DxH5OKR9BHFpwyupZ+vnqnXjlQpb1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781344; c=relaxed/simple;
	bh=TBrd+jplLSY7jLLASgPk2Y9Uiwt/frdVxRqC1Y0YI54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7A46hBar0KhaPhuSD5S3RV7P4fds1GPi/PzalNFjIK6WzVXVQT1GC4sqRhyDpzw5+ZVF6UH1eb1Wl/VajoYXvw1F9qUCFh4EjmsvDRyUl0QlfGVrKXA20KrgzPIizlgmTTGlUjieRunwFuFZDNt/QDx7e+OTmyYXBv64KlJEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=n1PpkDub; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="n1PpkDub"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202407121048578f40bc7513cb624475
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z4+KkCGjDgviKG4/VqcF5gri7ueKDJS0ehVEFeNresg=;
 b=n1PpkDuboe1xGtYIRV4tT2SImpXct//MUCJt4Xd5fm5MZ/qHu1c32qcpsuZr1V4BZmePT5
 Exzg9K1PdT6lpUJaH5NFEtogSWpPOelc2tbUMqyWqd5PTCJ+79//tSZ8NsgncFjXtewIG495
 mORJJVevanK+kVSEyP7oivLWGzKvc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:07 +0200
Subject: [PATCH v2 21/33] drivers/r8169: Remove RT_DBG_PRINT() macro
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-21-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
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

