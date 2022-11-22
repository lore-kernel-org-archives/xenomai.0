Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A142F3F
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:40:26 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D1979CB8A8
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:36 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 962E540006
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3964F780452
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:28 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2022112222262734d4787f4ef5f047cc
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SxiUJEQMSiMUiViPkOXqSv/LH36FP+GEXinX4br0WEc=;
 b=AID20ExKNeErhAsi2vLO1dc6O5xAHlgO4xbUf2WAl5VyqrVTsckNzBc50otlsUg1J/sc3C
 i1BklKId5W8b3MsN6PNJSX2Pnvpl9bgzWQGl2SIiXUeEQSPzqobv/vvAj/foYxyOQGxhlLLf
 6GoNUA9H/HDiameI3jNIwB25zoJPs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 2/8] drivers/net/pcnet32: Adjust for kernel 6.1
Date: Tue, 22 Nov 2022 23:26:20 +0100
Message-Id: <30472d79b0bc3055f23e6ae2dbb87753f505c341.1669155986.git.jan.kiszka@siemens.com>
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
Received-SPF: pass (spool4: domain of rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) client-ip=185.136.65.226; envelope-from=fm-294854-2022112222262734d4787f4ef5f047cc-F2cqni@rts-flowmailer.siemens.com; helo=mta-65-226.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=AID20ExK;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-2022112222262734d4787f4ef5f047cc-F2cqni@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-294854-2022112222262734d4787f4ef5f047cc-F2cqni@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Align with mainline regarding DMA mask setting to allow compilation
against recent kernels up to 6.1.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/pcnet32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/pcnet32.c b/kernel/drivers/net/drivers/pcnet32.c
index 4fd5ba0b4a..eebb66ecb5 100644
--- a/kernel/drivers/net/drivers/pcnet32.c
+++ b/kernel/drivers/net/drivers/pcnet32.c
@@ -520,10 +520,11 @@ static int pcnet32_probe_pci(struct pci_dev *pdev,
 		return -ENODEV;
 	}
 
-	if (!dma_supported(&pdev->dev, PCNET32_DMA_MASK)) {
+	err = dma_set_mask(&pdev->dev, PCNET32_DMA_MASK);
+	if (err) {
 		printk(KERN_ERR PFX
 		       "architecture does not support 32bit PCI busmaster DMA\n");
-		return -ENODEV;
+		return err;
 	}
 
 	return pcnet32_probe1(ioaddr, pdev->irq, 1, pdev);
-- 
2.35.3

