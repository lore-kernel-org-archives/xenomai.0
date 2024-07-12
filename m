Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25114EC73
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781341; cv=none; b=oepiwWDCXIsringrl3I7kW6ZtyVprDVeFEDwf8IngMlGJKV0ap4PytwyL/TNnr8B1F7NlLZrS49ZECjCbBEDBq21U0wxYMV0SMRrpyDGuYC0qN3xzpVmfkJsWDQ7WDcI5vonWShoGCmNmET8V9+oLskD43sKhNFkb1C4sZK5StA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781341; c=relaxed/simple;
	bh=TTxL+6fGnzDQL6M3egp+JHmAUF6yfPJiLtx8vm+U4rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qd3bAEUAmuiHkBZPl7VBlNT1WzIf1XweYKLBm40lkgyMQa+Rdr/1OcZJrKiEMDh/DZY0wy5EslAuLl9urZRrG2m56fxi3nln3EO4JZnUjQwCp27JjoJAUyauPMxhBJrdcBAX4VSI77/C4yU1Jb9OA9ly1syHyx0PXb+YfTSoVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=s4GbmMhf; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="s4GbmMhf"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240712104850fff2618df56f490aab
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ywN30CK9V72aiFCDv0daUTuXVXM0bAKIbMj3tRtMNWI=;
 b=s4GbmMhfoxq63eg6LF09kV8ANl09U47LcRvtDHVSr9z2a0dZTqVDQ6aZZoUz04lZAQXXbT
 59628BRjsoQqFDFi5dGpfpAgBovbePQiSJkGSHaq6xUt637JNspy+yxvSXWSORxH8p4Z8qEM
 Fgs07O8v6sKewWe1IoteHs6TKx3Q4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:50 +0200
Subject: [PATCH v2 04/33] drivers/serial: Migrate from printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-4-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In this case all log levels were correct. Still migrating to pr_*() to
be consistent with other drivers.

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

