Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603327B327
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520016; cv=none; b=jYbrqjkD02Um5lPeivQuO7/WzjVmTmqljrakpUUMtzs7rXsgo5ajTdKj2FOD8E1rOIXo0oN/8vEqmBuvjZ3ErczntA+l0sooZjynlRJVjV7rwkTFv0hxda+k2pM0NO4KHQ5yJJTxuajQ7w5yl+O63R0cF3yO8U5yvsRDr7UKFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520016; c=relaxed/simple;
	bh=0rkpLVQ/HopZwBE7aeBN7ZtKPp/jbPNOQvf47fGr1L8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQR9kK9IYvPkT6iSLiyB1s83iLLSwcV+qDssGEL9cnKbc5dUv+8Z8W62M2OxGHyIOh4f+0ESkIL03ou3Sj1+NrLOuX6crCNKi8OTZCEQeoZn5b5ALwW3PAQgYOI1x6eJIe0EYFctAEh6yDlA6AhVKf3byObdTEs2BdG8GSFLlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LUwjXmmf; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LUwjXmmf"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250818122645d198d0a38d98ac48b4
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DBaRHWHaMf/NgrAEJBpFXirs4OZhNmlEl9AUDN+CpM0=;
 b=LUwjXmmfYupp0ZrBo1IqNxPLdE5xTNg8EhKcS1tFQxiX+GjImL0MpCp1nz0cYtLHfOUGd0
 mP/ADSCjwO6kGFFDkwOoDdGI0ivPzdkyi1TqEFL2OxBPlOpDj61Z7Gf1pIuc6FtS7sK2BX8b
 xA/5Ufesd1A/fEs3GfDhg3IkJGSxRsokW+OwDO5cWr5R8pKNEaw2C0Q63oWFGMdNwEFhWQls
 3chloQk1BUSkZu3KZymZk8oU5poyWltpP9FeVOBZL6ylgz0Z35ePa3nv4tMV6tXbtL8aUztw
 T/QKsiZVQLaSytX3BfGZee8fa2XhRUn382Zb5/9vygEdcm167YEo4bKA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:46 +0200
Subject: [PATCH 04/13] drivers/net/freescale: Add missing
 MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-4-c57f195e3f93@siemens.com>
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
 kernel/drivers/net/drivers/freescale/fec_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 9561fbc58..69a351762 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -3699,3 +3699,4 @@ module_platform_driver(fec_driver);
 
 MODULE_ALIAS("platform:"DRIVER_NAME);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM driver for the Motorola Fast Ethernet Controller (FEC) MPC8xx");

-- 
2.39.5

