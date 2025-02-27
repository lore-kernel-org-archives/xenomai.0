Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C8270044
	for <xenomai@lists.linux.dev>; Thu, 27 Feb 2025 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657798; cv=none; b=OKYKYsLSBwRFp9qw6E9bk9b7e/hJA7DBll9QWbGq0vOUWYtkXb83Vj+dQjZ/PP8d4/Dk/D5xmNKPpeWZSTJ0MIMeByCtqe/mgTmx1nYRZuwlMMsYakzTQsafUMuya8QvexbxVB4CQlBkoqu/BG4ebJp/P4HNRRQyy8TJfyOEuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657798; c=relaxed/simple;
	bh=t7A1EVHdhODIJjXZ3NlcZt78eZuRuqCA3KS1fh/1dnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rLkdWOgQ72C2kgTBYT0RFFz5FlBjL9cV1jD7bZVh3j499l8aYWu3MczUjWtxD0rhy+NVLsADHHLa/37c3DTeZcFEyyT7TDQzBr00/eYHWFeruHyXoHidlD3+f+dfk/evToZ5QoygeWbZpMT9V46d11uAmGdFlofPfxTx7t6TvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CvTavnEZ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CvTavnEZ"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025022712030426184b099e05438365
        for <xenomai@lists.linux.dev>;
        Thu, 27 Feb 2025 13:03:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=hvj5lyUiDVmu8SIHEoN5hXxRMaKUWyzN1Ar+d92PPcA=;
 b=CvTavnEZpGJEN36RKJhN6pHQTgUk0FgSJ/CbSqpBXgNrUcwj4twn94+I9GDSR+hZ52S9zi
 vvKdSF0ZF4d0Ae9pMQUwTbmvEERXB/OJMDsw5+iIbIIWc1jHjJv2WYqp6DkngJvnGjEcfSWp
 5nur406qIAnTuKD5c+3pNUZK+5jqhwn4U/vqZ23pUCBW9TVv5YrD/7CU77A0wefjyHe05FPS
 7OExe5Agze0IerNieWEOWOMHSnJIid4uqudH4iOZoRxXFKcV+A7kfj5wD0KXr9qjtiHTfrL3
 7Et3U0YD8NgCaX1Lc5ioSd5XpdkXIK41xFSBUq0Lrd11Dp8+I/hnGjVw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] drivers/via-rhine: Fix a build warning in via_rhine_init_one
Date: Thu, 27 Feb 2025 13:02:58 +0100
Message-Id: <20250227120258.85692-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixes the following build warning:

drivers/xenomai/net/drivers/via-rhine.c: In function ‘via_rhine_init_one’:
drivers/xenomai/net/drivers/via-rhine.c:677:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  677 |         ioaddr = (void *)pci_resource_start (pdev, 0);
      |

Inspired by the upstream via-rhine driver.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/via-rhine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
index 9b6a40188..8aac777d8 100644
--- a/kernel/drivers/net/drivers/via-rhine.c
+++ b/kernel/drivers/net/drivers/via-rhine.c
@@ -630,10 +630,11 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 {
 	struct rtnet_device *dev; /*** RTnet ***/
 	struct netdev_private *np;
+	void __iomem *ioaddr;
 	int i, option;
 	int chip_id = (int) ent->driver_data;
 	static int card_idx = -1;
-	void *ioaddr;
+	long pioaddr;
 	long memaddr;
 	unsigned int io_size;
 	int pci_flags;
@@ -674,7 +675,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 		goto err_out;
 	}
 
-	ioaddr = (void *)pci_resource_start (pdev, 0);
+	pioaddr = pci_resource_start (pdev, 0);
 	memaddr = pci_resource_start (pdev, 1);
 
 	if (pci_flags & PCI_USES_MASTER)
@@ -697,7 +698,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 		goto err_out_free_netdev;
 
 #ifdef USE_MEM
-	ioaddr0 = (long)ioaddr;
+	ioaddr0 = pioaddr;
 	enable_mmio(ioaddr0, chip_id);
 
 	ioaddr = ioremap (memaddr, io_size);
-- 
2.39.5

