Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4D46AD
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:13 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 9DBD9CA396
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 08B15240012
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DDDDE740054
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:36 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220704130836db89bd3352da5d1469
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aLIxWCHPHKqXSM+1NUgKGL3BAt6bq2baCOTwYkOlkN8=;
 b=kcYIxOVxUew4KXxYKOAVG7BNXp97gwlyVfuqJJu/9iwpjFRYtAdVDZJ3PWI5SIOx8agA4Y
 NcGv74tUNnLG/30AhufZkPj/E4FOzqW3902BBHoe0LfbnwQa3ERVGYObB359DzXzKDX0kF5m
 iusntaeKkjwoi8ifo/3Nec9PZ75gI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 04/15] drivers/serial/16550A: Account for privatized defines in 5.17
Date: Mon,  4 Jul 2022 15:08:24 +0200
Message-Id: <2d9adb26f51003dc8f3776c4d29791f41bb27ca8.1656940114.git.jan.kiszka@siemens.com>
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
Received-SPF: pass (spool2: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-20220704130836db89bd3352da5d1469-INY_eS@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=kcYIxOVx;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220704130836db89bd3352da5d1469-INY_eS@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-20220704130836db89bd3352da5d1469-INY_eS@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Those moved from the central header into the upstream driver code. We
have to do the same.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/serial/16550A_pci.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/serial/16550A_pci.h b/kernel/drivers/serial/16550A_pci.h
index 91b0390ff4..161874d1cc 100644
--- a/kernel/drivers/serial/16550A_pci.h
+++ b/kernel/drivers/serial/16550A_pci.h
@@ -33,9 +33,22 @@ struct rt_16550_pci_board {
 
 #if defined(CONFIG_XENO_DRIVERS_16550A_PCI_MOXA)
 
-#define PCI_DEVICE_ID_CP112UL	0x1120
-#define PCI_DEVICE_ID_CP114UL	0x1143
-#define PCI_DEVICE_ID_CP138U	0x1380
+#define PCI_DEVICE_ID_CP112UL		0x1120
+#define PCI_DEVICE_ID_CP114UL		0x1143
+#define PCI_DEVICE_ID_CP138U		0x1380
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,17,0)
+#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
+#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
+#define PCI_DEVICE_ID_MOXA_C104		0x1040
+#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
+#define PCI_DEVICE_ID_MOXA_CP114	0x1141
+#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
+#define PCI_DEVICE_ID_MOXA_CP132	0x1320
+#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
+#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
+#define PCI_DEVICE_ID_MOXA_C168		0x1680
+#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
+#endif
 
 static const struct rt_16550_pci_board rt_16550_moxa_c104 = {
 	.name = "Moxa C104H/PCI",
-- 
2.35.3

