Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407E749A
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434680; cv=none; b=fbyRx8qb9GfNDXUY06VGnu3Pi/Sn26HoRhp0CxbFcCtySPd/am0WE0IUazNCnxOx3AnyU/8Q+owEbntU/YecR24ZI8nIzIeK2XMQRXZO0Nt7cO7LeteQeTTSkZHSMSk4f/DS/3PN1XWGWSV8SiS1SE4F9i3VkC/VbPpBz9q3Sxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434680; c=relaxed/simple;
	bh=wOWKv6d0cm5tHI2uyGvbexX8r9B9e6sTEX4w/ii3pw4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvpCjUo19b5y/fuWnj7vsyKnpodd3Xc5zliIXmofoV+4l63xsisU8aY21x0kKJVX6wgXXlJkaDxeceIq8yuQ5Ti+UPy5X3De+z+uB2fVWxQFRJWLuD63Ji8V2nxjoTkLIAeJPoqMfxECJRqr70aRvV7WaAWKlIEJ4Fypo2mDCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=XcqpMXwU; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="XcqpMXwU"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202403260631092c9973744d0c678f9a
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LGbokVBMsMTMApEqtYelyv7PxhXQpyrZQaBGMmGNV7A=;
 b=XcqpMXwUFVkAms+sb3mLatX907+JKTin9ebBGR3r132wWDKa8THkqRT38AU5dswBEegFWF
 fBuPh8tP0V9qrHorXbVak1TUu7kW0EZOQuf118yqhJeGNrggz5ZrBWcyYDbNmPlQ+d5TbdSN
 +RahCAxM7X4gedJTwhwjNmhG++ziY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 14/25] drivers/gpio: Address missing prototype warnings by adding includes
Date: Tue, 26 Mar 2024 07:30:53 +0100
Message-Id: <d297eba092c9b11c3408c6c419ce4b1e8f92868b.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/gpio/gpio-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index e41c640504..74ce94408f 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/platform_device.h>
 #include <linux/gpio/driver.h>
 #include <rtdm/gpio.h>
 
-- 
2.35.3

