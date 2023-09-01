Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B9C8DE
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:31 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230901194528822eb3e775978aa71c
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1erMxPz6gQIvQbI55cLSdEr+oCwITLVBFP8GQhXhcHQ=;
 b=mWuA3Atwc9hfsrSgGCWc9jpeGyUA2IcUeTl7VvldtGy7o74RsTIN5Dcje67SERvC+GRK5M
 MMGyY4rqflZhRjoKEnxBaOL3ogSSY43k+FV1Fy/6nf10PvMBMW4XPQkaLMwzdfKZ08hAtHQ/
 2/yTvMRbMeDZdDi8a+3SeMrN9HXw0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:26 +0200
Subject: [PATCH stable/v3.2.x v2 03/17] drivers/serial/16550A: Account for
 privatized defines in 5.17
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-3-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 2d9adb26f51003dc8f3776c4d29791f41bb27ca8 ]

Those moved from the central header into the upstream driver code. We
have to do the same.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/serial/16550A_pci.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/serial/16550A_pci.h b/kernel/drivers/serial/16550A_pci.h
index 91b0390ff..161874d1c 100644
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
2.39.2

