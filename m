Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A63BE60
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:03:29 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 50ECD240006
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:03:22 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 51CB4740002
	for <xenomai@xenomai.org>; Wed, 31 May 2023 11:03:21 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230531110320456a6ecf336d89a290
        for <xenomai@xenomai.org>;
        Wed, 31 May 2023 13:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=l2wjbox4p7IgTjPMkM27+GX1Me4TliFUfD9zKOEUYms=;
 b=NMv0WhW2SpUAFxGEgnpiDa2rAKSdaWVat6H8jEH93RxCIL0PbtP9gNX0UAxXdy3nALMm22
 cfXj6mKDTbHofBO4XbPdNkTyLcwD6i4IWPy4tvDP/hr8mXGT5/rCksMcxgWaiki1e9OM2N8X
 Ktu8zMyy+HmRyKO1eKiBVpjhLiFQc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 4/4] drivers/gpio: Ensure compatibility with kernel 6.4
Date: Wed, 31 May 2023 13:03:14 +0200
Message-Id: <ba202eb8e976bbd03c524250dd4fa6810d167851.1685530994.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1685530994.git.jan.kiszka@siemens.com>
References: <cover.1685530994.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool2: domain of rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) client-ip=185.136.64.227; envelope-from=fm-294854-20230531110320456a6ecf336d89a290-CWpdjZ@rts-flowmailer.siemens.com; helo=mta-64-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=NMv0WhW2;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20230531110320456a6ecf336d89a290-CWpdjZ@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-20230531110320456a6ecf336d89a290-CWpdjZ@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

One include was missing, and gpio_export is now history. The latter can
be safely replaced by modern gpiod_export.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/gpio/gpio-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index ba5014f8bd..e12733466e 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <rtdm/gpio.h>
 
 struct rtdm_gpio_chan {
@@ -78,7 +79,7 @@ static int request_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
 	}
 
 	chan->has_direction = true;
-	gpio_export(gpio, true);
+	gpiod_export(pin->desc, true);
 
 	rtdm_event_clear(&pin->event);
 
-- 
2.35.3

