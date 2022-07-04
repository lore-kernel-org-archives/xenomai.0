Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E6469C
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:13 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A53C3CA498
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id F310E4001A
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id CA7EFD8101A
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202207041308376c40345f62dc750171
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6D3Gkxr0S/hDwAEyc0a69sf03ua4nwZWZmOdEk9ew1Y=;
 b=gcZL17ZKyBVhX4NctKd4SFJc+Xqx4Jjnt/y0/cY7PC5cU5o/IigZ2HqHccKyd9MQIFjz9i
 VO3xXqLeN5Ia0FiTcvNV7Y7MGW56nyYC7IWzfewTxILGvGt3G50ONHK0IHPKTI4uayAMwaTs
 KvIP2Oj0n/e3hObBoY1g2Q6tL7cmM=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 14/15] drivers/spi: Account for dropped return value of spi_driver.remove
Date: Mon,  4 Jul 2022 15:08:34 +0200
Message-Id: <30a87748f6469bc1778e4abd55e43de99a9f28d1.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-202207041308376c40345f62dc750171-uTFuSE@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=gcZL17ZK;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202207041308376c40345f62dc750171-uTFuSE@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-202207041308376c40345f62dc750171-uTFuSE@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Changed in 5.18.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/spi/spi-device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 397af0f33d..6e368bd555 100644
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
2.35.3

