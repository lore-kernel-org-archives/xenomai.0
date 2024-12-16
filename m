Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E318E20
	for <xenomai@lists.linux.dev>; Mon, 16 Dec 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366753; cv=none; b=toSqc3Coxn5oPIC7jys8FKrv2YDM17QdVbskQsMPYmxaGeZM8eQ+GxQ2WJwObm309iqGTjnmFPh16CcD/TmNyN4keFCyT6gck32Ufu8ybJgXGkR24xoSjMGe8AazXD7U0E1Dr5QzFFj+BT11y86f2HymH5vGqo16QKuyMot8cWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366753; c=relaxed/simple;
	bh=3xGRuVZO7nEdyD358yWahaWz9psXjvvWJoIvW55tmIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ehxvKWrXB7ivHm9dmZp5Mj9xdHCZREzErBpZvdoEYF1yUs+/kbqptdn0+dSCmbi1VhQiXCr5OtgFkrSouDW9NUyDvAKTBMm8HTiEpjAPcf3+/6hhw/Bqj/h2McgNasgFAYGoer7VwBCJGu4q0dWNqGB4Z2LJam+B+Eb7Vk0Zwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TUW7KxE+; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TUW7KxE+"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202412161632181b6469518e50b4a11a
        for <xenomai@lists.linux.dev>;
        Mon, 16 Dec 2024 17:32:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BQflkHv2CELL4Rtpa4Aykgm9M0597EY+7yvHD4pCFb0=;
 b=TUW7KxE+fhbiRhVTKSLqxqQq2StNk2zXfthKEyAenLc2gs385vZFVLG/cVGzu2kCGrjihG
 swZVO/ZKrXLfM05hsYm25Q+65vtNZJ9XA8gZJ7Qdl6ApSgJR4ETOmvtXIE9IRwLiECnvXzcH
 sSanMXIDiQn/28K3U8VPa8ooRly4OQlz+LOxGDDwBTds8n59qAl8ueJRCCMqfX/n6cEWKrvA
 yxipQ/xZJp2KEqLIHvUBlMxYhBdbTy7myx1h+2BhubBsW4yEkgGNOly5V45o5ZFE/a/LWm9c
 8SmuzxDEh77pdEGePQlQF3aCW4xuokPNb+fTOk/p6BFCQYLS3Dy0787g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] drivers/spi: Add support for Linux >= 6.13
Date: Mon, 16 Dec 2024 17:32:12 +0100
Message-Id: <20241216163212.935315-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

spi_alloc_master() has been replaced by spi_alloc_host().

spi_alloc_host() exists since Linux 6.1.0, so we can savely migrate to
the new name for "recent" kernels, older versions will introduce a
inline wrapper to the old API to keep support for those.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/spi/spi-master.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index f58fc900a..59836fd10 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -349,13 +349,21 @@ static char *spi_slave_devnode(struct device *dev, umode_t *mode)
 			 dev_name(dev));
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 1, 0)
+static inline struct spi_controller *spi_alloc_host(struct device *dev,
+						    unsigned int size)
+{
+	return spi_alloc_master(dev, size);
+}
+#endif
+
 struct rtdm_spi_master *
 __rtdm_spi_alloc_master(struct device *dev, size_t size, int off)
 {
 	struct rtdm_spi_master *master;
 	struct spi_controller *ctlr;
 
-	ctlr = spi_alloc_master(dev, size);
+	ctlr = spi_alloc_host(dev, size);
 	if (ctlr == NULL)
 		return NULL;
 
-- 
2.39.5

