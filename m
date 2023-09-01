Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCBF9CD
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:35 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230901194533206e123fae588ed2be
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uWTFBq4eOA8rvQSW56zf6bctEb7HT2CkPb21T8QCOn0=;
 b=muDB1vFcNMDpHnFyc8frPM+nSlEAaHz7u7gmW/4OORLeIaeN0j3IXIKhJIG1k7n8GhHPqw
 Ol5oihqaGWzf6I+IGiycJ2M6DMvId7v0i565nLhBDEz2N+zU4wLFzzcl4cLgYjTvYmKSU6F8
 N9QznlG+Q7gQA8BDOMGFEh1xd8Fl4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:36 +0200
Subject: [PATCH stable/v3.2.x v2 13/17] drivers/spi: Account for dropped
 return value of spi_driver.remove
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-13-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 76b64804630119c894be4e0352d24ea9d8982b38 ]

Changed in 5.18.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/spi/spi-device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index daa9b909f..c6ac7bd8e 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -147,13 +147,19 @@ static int spi_device_probe(struct spi_device *spi)
 	return 0;
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,18,0)
+static void spi_device_remove(struct spi_device *spi)
+#else
 static int spi_device_remove(struct spi_device *spi)
+#endif
 {
 	struct rtdm_spi_remote_slave *slave = spi_get_drvdata(spi);
 
 	slave->master->ops->detach_slave(slave);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,18,0)
 	return 0;
+#endif
 }
 
 static const struct of_device_id spi_device_match[] = {

-- 
2.39.2

