Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DEC19BDC
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:49 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202308312037424ac0108cadc8e5d075
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1erMxPz6gQIvQbI55cLSdEr+oCwITLVBFP8GQhXhcHQ=;
 b=lTYd6MmKR0oWNbfiEd5RRX4rhKSWUqCrTA6KdgASlXrSoEHuPVxvjrsnC8vtJAn9UUdb9g
 MVcnFJnTJsK9eRf5iN+MG4ODl7Bln8pkFSxZgtQqEzmdvotxh47noBYbivYc1Sd1MWuusYJN
 xGHLyuUcT5TTU3x+cTYui3t5utHwY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:29 +0200
Subject: [PATCH stable/v3.2.x 03/19] drivers/serial/16550A: Account for
 privatized defines in 5.17
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-3-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
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

