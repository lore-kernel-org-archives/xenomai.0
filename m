Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2138.outbound.protection.outlook.com [40.107.22.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075C7E
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 10:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQofUMYGb4rzFeUaJ+iXlf7FA3SqFb2/2X3pcpObJAIxj3kNB5+QGLNkgwfuPbeI48E+PyvyA+1lSkTI8RRIAAEcqYX/DmYAErX+mdqqrTOxeUjK6NFGxIx8k8HySfjgN/YCmA/C+eifzLWmogETpOroej/TPdG1FFNSISoH6KY8TSEErdqi4DnGM8HpXKCfQ2RELMuFX8qaWOxCZO8orgz2yvvHyMgqjD3Gch5WN+QisBGZKBs5/t8QNRssUf3U96YZd6OQMijXwMfPy+7u81yWlZd4L8YmehF9jz/ct3hmdahDRxOWK8cdOvwy1RNXnTneeiNvsi4bdcowGjs8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axLgJYcJMtJqrBvrwlVteCr1KUtJ4esBP3NUPXHB2/Q=;
 b=gPvtWnbc+btwWHuYpHdxL1XOhz2ZEiwslLvWvHIOeoIgRJDgc1R9hUznzfTjzKybIfgIFpJ9JZCJBuc2NrGfsQYnF9tlDpt8Gsr0rJogDFJVCG3OyQ2gca79Cut/TWNn0FYsNnjns/Ue4eIog9BM9he0NdRJFQdqrDZWsUqZbqpUM/9H10coGKp8RjCNsomT9s4hMKgjoZ8HUMeBfYCDiI81w/2aUn9zt1/JgpB7SXgD++LogRyj9TmYg/4QgmaXvjFXeyvrhtQexCOeckdc1G37/QHM5OnD+OfENdN+9j6aGEVCJBx75+dbLc7bGnqW30E+PxQ90V5eA/S23xD92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axLgJYcJMtJqrBvrwlVteCr1KUtJ4esBP3NUPXHB2/Q=;
 b=LYrENliyFyN1Y6jXbpNo7EueBST+Gsg8pQRa8VQqNyjuELPrpI3u0px9MUn8SB33iaj1cZiJrG4OHRghvUct8J2jAHVY+A97/MJ2WJAp0etH9jY4R1XpReSBoicJz7F/Avi75VaGouR3YML7QRqUQXrlXaXAz6Ac/c2anG7ER+A=
Received: from DB6PR0802CA0025.eurprd08.prod.outlook.com (2603:10a6:4:a3::11)
 by AM4P122MB0082.EURP122.PROD.OUTLOOK.COM (2603:10a6:220:1a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 10:27:05 +0000
Received: from DB5EUR01FT035.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::82) by DB6PR0802CA0025.outlook.office365.com
 (2603:10a6:4:a3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Mon, 15 Aug 2022 10:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 DB5EUR01FT035.mail.protection.outlook.com (10.152.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 10:27:04 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id NTjWoGqJ5l9ZiNXJIo2RjC; Mon, 15 Aug 2022 12:27:04 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id NXJIob5pibpSaNXJIo768y; Mon, 15 Aug 2022 12:27:04 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xgg1.bbl.ms.philips.com (bbl2xgg1.bbl.ms.philips.com [130.143.223.142])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id A198F182F94
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 12:27:04 +0200 (CEST)
Received: by bbl2xgg1.bbl.ms.philips.com (Postfix, from userid 1992)
	id 9E9DC1C0084; Mon, 15 Aug 2022 12:27:04 +0200 (CEST)
From: Gunter Grau <guntgrau@bbl.ms.philips.com>
To: xenomai@lists.linux.dev
Subject: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
Date: Mon, 15 Aug 2022 12:27:04 +0200
Message-Id: <20220815102704.1825151-1-guntgrau@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
References: <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Reply-To: Gunter Grau <gunter.grau@philips.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5dc1226c-26d6-4690-b6a3-08da7ea8b302
X-MS-TrafficTypeDiagnostic: AM4P122MB0082:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YAq3C1bDxwWyN4Il6IQ2nNWRsCB+832NCZE25wFvWySQhAF3swaprdKvs0xPe57pn8N6bp7pK9BB/oNyBGvFrgxNZ1SyD+Fab5XBoT744Kq88srAVTOhZySSmXYJ0j9gn1jmTSEqURHHPVXnGcegOIzS4LChyb5JnHy/uW+hWQMMiXg76IbbpWQGFlp/54wB9jYYRAeYf5Ims5DJnePPkhUEYs6tsJddLYfLlXLVjbcL/IGT5N5zfeVq6IpvedbDfZBY8H9ObTzzb7/mqN/yAuxpQN2Sc5ZOMWfaXYbfDwdwV7XssQiDaTEGNj0d0w0QQ11qWdyZP7orqS3iyXUpx3t9ganPw78Uf2NSe0H4zN6eFpENZOBnBdo0M5NVV9maOI7IjybnCotXktgaBXtK88kSSGoz313S33kk2nz1v9gFnyl9bFWXcMd/o+Ic1oqp8VPWMaa6P3KCgqgdq5jdqZAhS/VrIPnEox7f0ldhIjcySEkHj9kZ9bm5hnzfTwuEO5+00jZr159kO9R4CaNgHA1EXOakloX25t7NUQrtZIvx9VSKuvHmE0XPIgYQ7ax3K+3bl+fYhz3w+872/SuecTNpoUL6fB+mv0lWtEoy+Ldvzy3uOF1wDOZ4XkBzLuBsbhkzt2WrWHKuA0ja1CsTmf9xlPawnD7OBBrb/WMcWWPCmd1wrYbafU5jtYq9ZGNIDo252qm+HmnM+QKuHhYSui47SsKugthQCjF4qu2LRHngvH8ITNQdGNra6RDeGAuPz5O2Yc+3L1sVfQHIOD9osHOgodINiUslHipB6HCabl7jROV1RI04y1z3QTTXZwI8
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(478600001)(86362001)(336012)(2616005)(6266002)(26005)(120186005)(186003)(1076003)(41300700001)(426003)(47076005)(83380400001)(82310400005)(5660300002)(40480700001)(8676002)(70586007)(70206006)(42186006)(316002)(40460700003)(6916009)(7636003)(7596003)(356005)(36860700001)(82960400001)(8936002)(82740400003)(2906002);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 10:27:04.8470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc1226c-26d6-4690-b6a3-08da7ea8b302
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT035.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P122MB0082

From: Gunter Grau <gunter.grau@philips.com>

There is the possibility that a new level triggered interrupt is
already waiting when __ipipe_end_level_irq() is called.
In this case at the moment when the irq is unmasked it may already
fire and call __ipipe_ack_level_irq() before the masked state is
cleared in the irq description. If this happens mask_irq() called by
__ipipe_ack_level_irq() will not mask the interrupt and the system
my stall.
To prevent this, the masked state will now be cleared before unmasking
the interrupt. A following direct interrupt handler call will then
correctly mask the hardware interrupt as needed.

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6a883a4cee87..25d0942b592a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1048,8 +1048,8 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
 
 void __ipipe_end_level_irq(struct irq_desc *desc)
 {
-	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 	irq_state_clr_masked(desc);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
-- 
2.25.1

