Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8EC423775
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237163; cv=fail; b=A0K+fdOTxyvjOEfRxA9uBx+j/GR0V4T1/Z760a0Jd+clhXcJtJcI0RU3u/3bfVWkyBNskt7HYuB5HpHw/yzoKd2LDgJHUsC5ewVdk+OU2NMADwPvaxptC+x9imXqQSEyRkDU4RLkExrdp3ya24v18r/L5/cCLXC7fv41FUuJ+2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237163; c=relaxed/simple;
	bh=Iy1nrS7eTil3/oXfRjKWY9VqL4hHynOOdXeCqFnlq7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8HvMJYsOGmbVV4u2PHx4XT5KIQSig5BnnQEOq5xD+efBBIVG0qveZc6FxzOSAi4MQIeavWuAhdGEYvNSd91EM/KQOVIWKAIjuY1MbkJCN4ZFlbVaOv2m3usffaSb8+PbNX6E3mvo9gCZg1W8m0R58GcE8Ls2Qac2kWTqknpArI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Eo3MxPt/; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Eo3MxPt/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHiHQliZSFMyYPRgNxTE7IxKoc2/EGALJ1CWLAix0bD2fshEjbToVhnFdhvEyTBGX1EQoT97ZQzPnjp3MefoaZLkTbc6fdmoTLMwpAXose+5vzcjK2/bEE6WWM5QRIZihlHtik1EnnUK5PZb9/QBAY4jpKthhDSJnvkqOlLoCB3YlLXuDJcGots+HcSnlts7mnmyEXmpsPbGluB8YKG7LY8VyroBL13QKjdQNjh4wd2lnuA9bpcwbRUZNoaKcC2+n3o2GiPdUYwB7OuyPCk0S7uZA46rCqCYy96XWoVMBYg8zW7RWneFlofp6+hTDY2+2LOUYTGxagIXVCBwe7/Atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrJvV0msrN9WXt0uB1adKK1oFxVQ73oPXYPTa7aT/Hc=;
 b=Z87FdIT6NRMqD5V9EpoJ0Z27GT2NjeGlYVwJ9oqwblij9LCODZ7QLVyY8iUMkT2KOZgCsGD7XTp6wASOFnb0YNSIDWVFOFAuh8TsqP12xn2ZseXpMuC03gGsTFX6aFgfsK3vGcYVczkv6wST0quX4OHFYmwOYp8SN/K7Al4OmHTb10MKBTbRM3Bb+wcDobwyyy5lwzaxAaIG+hmdD8YFlAcumC4l3DpO9pwblkJYeJzCpvB4smtJx7Q+Ue1hSf8VyTtwoC3NpEzq2Lvy05dawbezMmKDoNP2QpAVMotgODK0Isg0m50jjRgS01C95TCAtmm9G797lPPBxpSz8pTLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrJvV0msrN9WXt0uB1adKK1oFxVQ73oPXYPTa7aT/Hc=;
 b=Eo3MxPt/ltfIZqkAgRCVxnNg9TDEfSoO95hmsZ8GWpoBod2ftIkzXTfSnNs/e0M+Qs56FP8SxtQje8/yaJFw2Jz4eVk+Dz/x9kc40n+aRjS3d26kCeN45sp/+bEVWGdDhHykE3kd5wx8GSHdfCF5DsKq+KDaKu1jgsT9ZhiG7mOawTJH7sNKfmjycPwxkOAvbejtJeSP736xVLNXVlQPztwgHiNqUqnFvhYSeyvuX+H52e6ezwklN6G1sPJvMlQMGYfAcKUjEbft6p1V54VH8RrsdtUYHmoW2uGlAYqKulHg3ghRkVu6sDCtmVs4qpFLqvZ8MLYvQlK2yh1K49CDtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 11:12:32 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:32 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 05/11] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Tue, 28 Jul 2026 13:12:16 +0200
Message-ID: <20260728111222.2699158-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
References: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: 523a3522-0133-4302-2b67-08deec991e70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	21RuVmE9cqx9uq31EzXlYE1AWiQnx5Ms/N0FZ3krSjIPLW0KeN8/v404QVcdkfAk1snQmPYxEpzHzXqQwJ8/XsKlb15eCdRnBv2JTN0YuWY0xkJz/47gXoUAAPYABJL6MiJZ3b5I7HdU8Ck0IFW7FmqhnML35CFhiUqPJUVDbGAAi7+hLFE0JC5cNcsKUBTiyFZDbvg3wlt0yvd63XHPIav6/As/cJZ91ngY7FH14bJeDZ5zsGqIKmQtbpb4JGCdqHqdMExa0ZHwEGs9FjAaGHAyJv9mFgLOPeSfa3N/tF6gMhLUHWQsRPQDaWzkioQDPz6hdyExK/o5kK8AGLe2Hf4wHCShlEYzRb74AdCqueFTKxWaHDdzPuxOpyqsDcjFTzLbHhkxiAOGAdGzjEYIedvzZcOWOWNSMVzYtCYSP+3AkfBSI//SuHgiCo69vXSXMplxX5S//OXy6zKzrZb0XZBzpGvVtXtU9F3Gyt2nklV1K9TpKuAwPm/Jj7o20PO+18jwAEOe5VD8mfSnzPREOaatxS2zbDdxEVrGxo5y50vCGh535E2MvzzeDFGr1w7ebRfe8UP6dmnvavrk7myaq3+Qh+VA96XACqKLotc9texiGwHKnHyNlHZ43pgH2s0anRtBgVcGY/mnNeHopxoUZR8rghhuXU+qeYXzoe2fJSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2+eTL8VeoAZNA6Rbwdpy0/6eeo/PA9ofRxR1PnDk/neG7Hja6EA7yE+J98X?=
 =?us-ascii?Q?94TUCc0DxGIgOxeI6fyxH0x++YL5RkPM7DiM35STSAFZUvpNYKt4v8TQME5d?=
 =?us-ascii?Q?vMjlvoLuACCLCs3r/Pm6WxhtLPAq2GPsruTENBjndUeU3flxWZoeOYMRpsiT?=
 =?us-ascii?Q?z/PS/ivycxOJlQ3iJTtAo/f1G2mlScpRVumLH7fEm99zn2jyOEVcBV/hSHKg?=
 =?us-ascii?Q?g4yN7froCevtrX/RPt0wvPKA8YlRIX0QaJvunfiWnHic8bSpNnHosuwWwP7e?=
 =?us-ascii?Q?EI+3kfW7jTk1OsMdH44PSBScO/9qYvBpJskov0rcI6YOJdCgMtcCrPByi9MT?=
 =?us-ascii?Q?vh1yxKjTCFK/PjmsHQAe4LHpneulRpp3xNkJ7/q2aV1vKNLUm7dmDK3MGYia?=
 =?us-ascii?Q?kx4XIIRA0I2iw7y8Pw7CLkJD5mgfs7A+t59F1W2yQ9aDYHOgssZQPGAcXC2o?=
 =?us-ascii?Q?HFpvcjJvBWLEgyV5ylyS5W+e24aiEPXyVJYCCFalhkVxhpyjZtGuG6wF21tc?=
 =?us-ascii?Q?HqLFsawVFPhTn/dHNRPOYQaPw8Stm5LbczPCsG20Tap6lODSwcdV+4YzU34v?=
 =?us-ascii?Q?RSuUgmSzvHcNtvK9/APNAYv/2NkLDiyDnJrLcK6rlN/c2i2k/68frWj58ylK?=
 =?us-ascii?Q?gWoV3Wmh54WXT2e4pRsmDLKikEw3LlzAPeJfkFYZ1PgaBFSETrzlXH/gq8AN?=
 =?us-ascii?Q?YJTuvJX5S9zPyN5zBxVQN/yRpS0+DV5mjnBgxMc/YWtal2qeNuMthKswrNOr?=
 =?us-ascii?Q?7R+T0r4S+Z4oJgOEP9SSs94zxRRtNJh+3SEt2fEiqOyfFWp5rdADfjoJtdZg?=
 =?us-ascii?Q?+XxRcLBmeZIq1MrQld9sIglAQABJQeCqPz+h3Q43eEVK5jAjqVsNNA4eQkMP?=
 =?us-ascii?Q?E5+YbE4a4kh7PUBMG/IyE9JfBwcgLNvsxvTpFvpvGAcims0AOwuVoUb5iELC?=
 =?us-ascii?Q?A8MiKaOsL8OM95IaT/rz/Xh36UtLYWfRkvVOMiM13PjwT3sN+agwZAXFGpKz?=
 =?us-ascii?Q?etO2QnBesayjA+rQT4Et/MVfsaNqa3VmwRpftDWT0mjvJ1J79s2sPgU9uvoZ?=
 =?us-ascii?Q?pWo2o23pXgQqwilrhRh8T1AjIZYlgVibkbpwPW6UPkIYnH2hRUPxzrzf1UtV?=
 =?us-ascii?Q?pUwVNt/24M76o6qbhHkkSrZsqxKSSmMpJbEg+w3kx0vnqPgC5rZHrPf3XhX9?=
 =?us-ascii?Q?x450vsh3v1LeMfpa1aGGKF33IMihNXa6lLW9j7sGDVdXzzSEbNaIyu4H3wLd?=
 =?us-ascii?Q?psFkxFVFDu7ihjLflAyn4anKQwtzBuKYAkOpivD1eRNY1WDeXqxp/noLWwli?=
 =?us-ascii?Q?Son34thBBAiltXqgPVq+lsHdAX6LoSS5mo9gLSoBI/EvwFQkzc1LB1+CqxOC?=
 =?us-ascii?Q?7osGa5zsiY72CxwPjL48CxmUYEifYZnbTO26WkqU6VbMOyQEARC8B+V88r22?=
 =?us-ascii?Q?0rmlUsxBfkSIETq7nr5G4SYTJyoY1xCQ7EQI9fGx+d4oZhzpNVTc9AXxX/r6?=
 =?us-ascii?Q?Az4fYtjf+y5FyNSL1/PQPJdfwsv48fVabnj1mIlgX3UZPsU2bYk1Gd9u0ziI?=
 =?us-ascii?Q?Kij4Zrc1meNYHvWKJy/Fp8/XBzMbLNHzhy9vQzyj82KzBxT+hiNrp76V9+DI?=
 =?us-ascii?Q?aUAW9ycjexmcxbhcLfHvJmQTHrYkotLL86dfz0MhVvA8ceG5oTo0xe9tMqOj?=
 =?us-ascii?Q?jJOZvByED/N+bdb0DP2300J/MegSemnOjlZtUS2fEjNHWyj17K9YWO+d8gbf?=
 =?us-ascii?Q?vGkfPExewZdxK5tPlO+QYJTavdzBP3w=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523a3522-0133-4302-2b67-08deec991e70
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:31.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5tHk1D+GBOvLqa2ijHnZghg7gevGZF5X5gv3PZkoiduyxFRNZIcdh1LLWg7/zOT+i/hPcZx//qm+fu550iC/EETpuPgkxMeweGyCKglZm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8685

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..0b0dafecbfff 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -219,7 +219,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_retrigger			= imsic_irq_retrigger,
 	.irq_ack			= imsic_irq_ack,
 	.irq_compose_msi_msg		= imsic_irq_compose_msg,
-	.flags				= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+	.flags				= IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.43.0

