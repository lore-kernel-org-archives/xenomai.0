Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6C15CBB
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:32 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5F8B1100003
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 01F0BAC1BF1
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:28 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20221122222628c85185d603bb01c51b
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qW3ZVGXanThmMuofIKNq/5bYDidnOn0RULBEHRskudA=;
 b=U0MKxb8nCBQRTA1/uD/rgmbOLSihpyOixIogaemx27E9bGCbUWgTYQqaI64S/3WybBAGsH
 X+YF/tck//IviLTvD1vOZ9t/aIoQ0x7nAcXnNXAPuW2sBHyMfRplbkUrmSGtE3KVf1QVLa40
 /NR6DycRqSxBVGpLatlcrg7eDYkXA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Cc: Gunter Grau <gunter.grau@philips.com>
Subject: [PATCH 4/8] drivers/net/freescale: Convert direct dev_addr access
Date: Tue, 22 Nov 2022 23:26:22 +0100
Message-Id: <f13c59a957f6861095dd97ee4faaa45667470f9f.1669155986.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1669155986.git.jan.kiszka@siemens.com>
References: <cover.1669155986.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool3: domain of rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) client-ip=185.136.65.225; envelope-from=fm-294854-20221122222628c85185d603bb01c51b-8JWPyX@rts-flowmailer.siemens.com; helo=mta-65-225.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=U0MKxb8n;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20221122222628c85185d603bb01c51b-8JWPyX@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-294854-20221122222628c85185d603bb01c51b-8JWPyX@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

This was forgotten in 5af4f16609c1.

CC: Gunter Grau <gunter.grau@philips.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 21d98e44df..5abf5e8220 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -2798,7 +2798,7 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	if (addr) {
 		if (!is_valid_ether_addr(addr->sa_data))
 			return -EADDRNOTAVAIL;
-		memcpy(ndev->dev_addr, addr->sa_data, ndev->addr_len);
+		eth_hw_addr_set(ndev, addr->sa_data);
 	}
 
 	/* Add netif status check here to avoid system hang in below case:
-- 
2.35.3

