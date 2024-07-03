Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0717A5AB
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013151; cv=none; b=uJAvFXlpzCbe4AI/izD+UyVJ/U59rc+UUIHwOKm/nkrE3vFyiPlURE5rny/ISCG+GYvv7jGKu8AQX1MfbmnuHuoNqZqidGMYUssdY747RIQtAQD/52/5cdekr3IdF3RUEcunIoWZUZKZ3ZoMcOpNzCO7BdbZi53wRBQEb9murA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013151; c=relaxed/simple;
	bh=H0MkBrY/YzE7caNliLbqg5l6kBmH1+N7MA4MY+f97/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSP7wwA1IsrSrADkmLNKEx7wIWE13s/xY4hF26bCmcNks0obwdD/vLxYyNec2ZM+Gn+a1LNTGPpPBil0QdeelnNoCUWubznqrsh6xQPOrKdUL3zLcROhI5AZPp6FVO1XxQL+c6yjQ8hd0SS2XC5yPvbQC8FhbCHSj9yeZm5CyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HwAxXXgS; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HwAxXXgS"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240703132547547ebcff74992779da
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z76snBRzVijyxq3o6gVX9AhovoWZKcMljSsnoI36/dE=;
 b=HwAxXXgSVTjpQRafq7n2ImdMrCJDYtedoYZeAFiZz0B/SvRhvD2Is08XlBO3zXUAj/j3Um
 akwHcwVKZGb+UbDQ/7QLS6a9RVmK9JW0U+seUdSDPdVCQFmNpulE1ZlSPqr3BimKhKRS6CsP
 vdhi7bTvd92fTyA3AR5cmrUSDiiKE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:46 +0200
Subject: [PATCH 23/33] drivers/r8169: Remove rt_assert() macro
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-23-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is no difference to the assert() macro. Cleaning up rt_assert().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/r8169.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index 8f57752ad..295e34a60 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -99,12 +99,8 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 #ifdef RTL8169_DEBUG
 	#define assert(expr) \
 		if(!(expr)) { pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
-	/*** RTnet / <kk>: rt_assert must be used instead of assert() within interrupt context! ***/
-	#define rt_assert(expr) \
-		if(!(expr)) { pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
 #else
 	#define assert(expr) do {} while (0)
-	#define rt_assert(expr) do {} while (0)
 #endif	// end of #ifdef RTL8169_DEBUG
 
 /* media options */
@@ -1490,9 +1486,9 @@ static void rtl8169_tx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 	//int entry = priv->cur_tx % NUM_TX_DESC;	/* <kk> */
 	int txloop_cnt = 0;
 
-	rt_assert (rtdev != NULL);
-	rt_assert (priv != NULL);
-	rt_assert (ioaddr != 0);
+	assert(rtdev != NULL);
+	assert(priv != NULL);
+	assert(ioaddr != 0);
 
 	rtdm_lock_get(&priv->lock); /*** RTnet ***/
 
@@ -1551,9 +1547,9 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 	struct rtskb *rx_skb;
 	struct	RxDesc	*rxdesc;
 
-	rt_assert (rtdev != NULL);
-	rt_assert (priv != NULL);
-	rt_assert (ioaddr != 0);
+	assert(rtdev != NULL);
+	assert(priv != NULL);
+	assert(ioaddr != 0);
 
 
 	cur_rx = priv->cur_rx;

-- 
2.39.2

