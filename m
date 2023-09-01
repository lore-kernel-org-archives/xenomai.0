Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15AF9CD
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:42 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202309011945344679a969ce981f813f
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=V4S6qw+FHFXYEepgI7urlkX8UjfYtnOB2NoxS+5na3c=;
 b=PTsDhWWIAOWw8k7JNVERr9Zwpl/llOdfeXUoapwv1i3pJwjK/cGDFyNR4WGtjOEfYAc9vO
 Wk49NP4CQaNk3DdpjNkEae+bo0cWMM0n52o4dA2cz45p6zc+Bm3WFcBV5mdoIBxyZ4jPn3o/
 tld3NYiDsFEpyyA7dHaTs+kj+RgzQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:38 +0200
Subject: [PATCH stable/v3.2.x v2 15/17] drivers/net/pcnet32: Adjust for
 kernel 6.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-15-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 30472d79b0bc3055f23e6ae2dbb87753f505c341 ]

Align with mainline regarding DMA mask setting to allow compilation
against recent kernels up to 6.1.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/pcnet32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/pcnet32.c b/kernel/drivers/net/drivers/pcnet32.c
index 4fd5ba0b4..eebb66ecb 100644
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
2.39.2

