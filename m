Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716E5399
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:48 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230831203747394fd5fda4ffa368fc
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=V4S6qw+FHFXYEepgI7urlkX8UjfYtnOB2NoxS+5na3c=;
 b=Nf0ZZ40OewwXqkmwB6ghs0gqSb0goiW8oqICmIfSy+YkXp4xFh67PuR9o74wAGsspQMxDI
 S+I65J97FcdvZ1IUCse2d48z6grMGAfdMTiy7d6QfFY6DBFj5NUmg4wVvdWdV68c/aLDgfeM
 ancHHb/l1sdQpW9tfx0w5zi+WWxwU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:41 +0200
Subject: [PATCH stable/v3.2.x 15/19] drivers/net/pcnet32: Adjust for kernel
 6.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-15-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
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

