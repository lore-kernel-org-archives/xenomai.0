Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD6D2F6
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:11:35 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230531111127bc6de1a574e1f6384d
        for <xenomai@lists.linux.dev>;
        Wed, 31 May 2023 13:11:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=l2wjbox4p7IgTjPMkM27+GX1Me4TliFUfD9zKOEUYms=;
 b=AGlXQcvZpenBgtkzVBL1+sWXHh7pzgw9pPsGjHDJ9vWAbtEtgN0C8CO1UBF/lH2hXms0Iz
 QoIgqz7XxiMtL42j1rOIYC4ixYry3yOqohJK4+X4MV8mMT8YIxdEBEmAJsYGiHQsi3fEnWFI
 1nUPjVU25SesUDyBC/d9vUpXY2iiM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH [REPOST] 4/4] drivers/gpio: Ensure compatibility with kernel 6.4
Date: Wed, 31 May 2023 13:11:26 +0200
Message-Id: <ba202eb8e976bbd03c524250dd4fa6810d167851.1685531485.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1685531485.git.jan.kiszka@siemens.com>
References: <cover.1685531485.git.jan.kiszka@siemens.com>
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

