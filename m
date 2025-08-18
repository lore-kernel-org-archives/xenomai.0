Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013A131B107
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520018; cv=none; b=Ucy/6JrHtBOrtDCzKuCA/UAaGS8Z9WvM2nZn528xrtfQ39/2+8iNo79ivIa26CgEF8yeQWQNZVryN2TloE0Coou70yLjQ463HUoZaLFKADhUYH9oi0jq5kW7N1O6PA95xu7qNeUfs01yfaOPNK36X8J9PxQY9C0gtxHphvC6Ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520018; c=relaxed/simple;
	bh=n2g/ects2EAgVZrdr2z3JXLl6auIb3w0ClS5vn5lg+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oq6quCZ+NVUXbtyUDrxZLSsUdZCUj+XR03IfC58Oh6d0bJz81rAH+U60/iQw8vnIAgwd3yPFlHwQqICZjTs8YCR0AlNCZUluFpzTQ4ekZbWpfWMNNn7clLKkpWHrBa2NnOxjLAXfz9Bbs2sAXwv0sEon5SgyJTsk0RiY73MAjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LLtwEyoT; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LLtwEyoT"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202508181226479b6c5d144f6838a665
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cDeIkHm8M8Ed26tkz9RvlW/96BwiRGXOkwmf/cGmOHw=;
 b=LLtwEyoTV9jL005y7BLhrjNKJRjLxfZ0tvFPalr5hjPBQ/M+UydvptVa6/S5rbONWm22wX
 lTht0LLQw4ZfL7xVObS7oPQeJ+CQ+onS0y9JDu1c+A+UcBcYdbcvX1DwZsYmTnGbLdTBSgYs
 7gEoLSUAOV5+n6YwrYR3GecAaPApdvnzqnDXqbwEWSdPW9P3XvAYI+zm39WeeCiacsp0aO6P
 IGFI+WGpFipUAOHK6kLXQxyC+icFkCYlTHCj9Jkd/UqNKS6awVBpcOBNYEAXqBL3JvjeENLi
 WocX43SekBC0P+kbI3n1qjoUkHMEzu7CJvFqQEYFJQVo4i7Ax4zmZmfA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:54 +0200
Subject: [PATCH 12/13] drivers/spi: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-12-c57f195e3f93@siemens.com>
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a build warning triggered when MODULE_DESCRIPTION() is
missing. Seen on builds with Dovetail 6.16, but likely older versions
are also already triggering the warning.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/spi/spi-bcm2835.c        | 1 +
 kernel/drivers/spi/spi-master.c         | 1 +
 kernel/drivers/spi/spi-omap2-mcspi-rt.c | 1 +
 kernel/drivers/spi/spi-sun6i.c          | 1 +
 4 files changed, 4 insertions(+)

diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index 4a1a6f201..7c3568d58 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -717,3 +717,4 @@ static struct platform_driver bcm2835_spi_driver = {
 module_platform_driver(bcm2835_spi_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM SPI driver for the Broadcom 2835 SoC");
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index 581b377ea..1c2cd0913 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -462,3 +462,4 @@ void rtdm_spi_remove_master(struct rtdm_spi_master *master)
 EXPORT_SYMBOL_GPL(rtdm_spi_remove_master);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM SPI master/controller driver");
diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
index 6b5c11b71..88c5132b8 100644
--- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
+++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
@@ -1030,3 +1030,4 @@ static struct platform_driver omap2_mcspi_spi_driver = {
 module_platform_driver(omap2_mcspi_spi_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM SPI driver for the OMAP2 family of SOCs");
\ No newline at end of file
diff --git a/kernel/drivers/spi/spi-sun6i.c b/kernel/drivers/spi/spi-sun6i.c
index 13dd325c9..72547e4cf 100644
--- a/kernel/drivers/spi/spi-sun6i.c
+++ b/kernel/drivers/spi/spi-sun6i.c
@@ -678,3 +678,4 @@ static struct platform_driver sun6i_spi_driver = {
 module_platform_driver(sun6i_spi_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM SPI driver for Allwinner A31 controller");

-- 
2.39.5

