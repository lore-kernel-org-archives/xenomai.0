Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA141AA7E
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:55 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20230831203746e5491785b751646eb6
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6Ix5uAkZr0x21nHlPisEZDfqyzmgmgEw5Kw3VpQvkRs=;
 b=cugMsLWg+xBrlJb20HDNbnKGhyd8UPieutZ7DRActZTOe1rvisxRQqMDCiORTp+RiVt7xP
 ppnOU7HT39N+qQgnHcFGwYIj6A72eTP9LOCWkTZUVvCMJZdJe50YKqbHnNqonNEUaxW3nmzi
 oPojcqRTm/2d+pkC6la5xrZGt05VQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:39 +0200
Subject: [PATCH stable/v3.2.x 13/19] drivers/spi: Account for dropped
 return value of spi_driver.remove
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-13-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
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
index 397af0f33..6e368bd55 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -124,13 +124,19 @@ static int spi_device_probe(struct spi_device *spi)
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

