Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F540179970
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013149; cv=none; b=femaZuHFsF6oQHtBSK2xvqrHBu/LPu9Pxe3V+bezLukiY8k1RON4ErfM7IuQb25JR7PQA2oeoJaXV7m0+O03vBCi916SBdeJsMiDi4wNAl4ed9URpurbPA2voXJlQCK1/9SVa/r+rUcdb6GNHvgIo1/9i7qGnnuw4RXC4COnBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013149; c=relaxed/simple;
	bh=3R6sJheSE87zot0Vh9xsticpfSOBmVhFdDqcf3Y8xkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkBVn8qRzwvWGxPVTT10Ctdi++zSOtMxXhYBuC4j2lKY9VkRW3Y81thOGWopkNbxCjIiXcufu2b/R8fUKfR2v7lZ9Tu0Ueo38gHRZZL5YIj7PG8F87po/pjveS/53bURYCbuqgNtw85X36px+oqPlUegjrSlVSsHvy99jB/VWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AGn76hpC; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AGn76hpC"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240703132539d6a3ad7bef30627393
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rBbraC66Qant46xUpoVAUDm/2n+0yGqqbZk8aMFIGxQ=;
 b=AGn76hpCm+xcRQpBcKIMq2/rRvXh638RUH+8wyBlCXfaXq/+OPC0ZolXJIAwsct+9yr8eQ
 Lent0ZvtQcVScViQArPy4Umc3aQ/e6eYYKMyQTaueParNGkze/NpYBhC+8wlbcNjR9AlqBCj
 Q4Z9Mfe7oUFcG99T43ihQG5NkQt/g=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:27 +0200
Subject: [PATCH 04/33] drivers/serial: Migrate from printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-4-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In this case all log levels were correct. Still migrating to pr_*() to
be consistent with other drivers.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/serial/mpc52xx_uart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/drivers/serial/mpc52xx_uart.c b/kernel/drivers/serial/mpc52xx_uart.c
index fe469d598..68d1a4cbd 100644
--- a/kernel/drivers/serial/mpc52xx_uart.c
+++ b/kernel/drivers/serial/mpc52xx_uart.c
@@ -17,6 +17,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define pr_fmt(fmt) "RTserial: " fmt
+
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1414,15 +1416,14 @@ static int __init rt_mpc52xx_uart_init(void)
 	if (!rtdm_available())
 		return -ENODEV;
 
-	printk(KERN_INFO "RTserial: MPC52xx PSC UART driver\n");
+	pr_info("MPC52xx PSC UART driver\n");
 
 	rt_mpc52xx_uart_of_enumerate();
 
 	ret = platform_driver_register(&rt_mpc52xx_uart_of_driver);
 	if (ret) {
-		printk(KERN_ERR
-		       "%s; Could not register  driver (err=%d)\n",
-		       __func__, ret);
+		pr_err("%s; Could not register driver (err=%d)\n", __func__,
+		       ret);
 		return ret;
 	}
 

-- 
2.39.2

