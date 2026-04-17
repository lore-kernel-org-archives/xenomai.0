Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431830EF7C
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459733; cv=fail; b=a3k50RKpaid5+g9lKdfhVMRkMmxSiLgl8ULBTLvyxdHx8QlYZVk6qRC2o6I+CULtrbBPrkpiytJ23p7D0P+Je9BEvT9ZpSKotDYdYP6GZBtpNqrRwaHxGGc4LWfKvji/bYGNZnimsLUG9O7BmCsOcwwosI6FjJ5zS8pFQOhCYbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459733; c=relaxed/simple;
	bh=rQatWvFsp1g6NkwStPSpCp36ltygwA66TAk9dtDMTmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jGHEl7b29zixZ0Daop+qtV4oOvOOGyybJf0ZJ2r/NGjsYj0E4p9PbHiONplMuKYydx/82DRlmTbOSgJQ6kdbQ4KQAFb5Jz3k4sOD/Ym+GRQ57l6Mb8CY2VEydJX1MSOC9xApzT8uqhiD31ESmdcbM9W3D3blbYcmtoiDPJYOo/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dGMSZCzj; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dGMSZCzj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jexO9GxZKUN2TAJS9sLxB2ShbkNng/Ijd0GFr4Ume6ziFBJ0wgH/MrTuFXz9b/iNaHc402/GbqDlqObIw/GGecAPr5YqBzeMjVyRuK0sAhq9ebpIPKjLZgdQT/MOT79QNII8yElhOo71jAK7NS3n9efCFeJ3sD/BBKcPPwrb+5K59GV4LoD1ifvyXwIbQoQzdB4Q0n2XO/Ap5KOkNMDFfUOefmyOiTQ8KAxCgidgCDDi9BJJP78ZHznoeSnwetaO2LtPQyykrgu3j8wG1VgPfmwn3q/VumYkZzacyYMa/HOkJpJ1HrGz+HyYzOrfEvojB6mwlsaeKSmuq9ovrx0Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK1/4W7PCekiHps+9P2PkSSKwrBPi9xfK/YUbhErM/s=;
 b=QZF2p0xK/w4cXaXEMaLNmyoMSFzSpNjeRflevAeeHevrtCBcgKDVgmgWGw/f1pkDgyd0a50fkvbkWjbBqIJTjEAcj4FZLldXQLVbnG+4GzqHTTBa71sUSxo+psitXmLqRw8pzeOaSHPQoXBYq1sulV+xxrKKsS5hAyopd/xgXP1EkeE+W+LNH02k0Nvb7f/p6/sZxi0yk2Xvl/2+1W+6Q+p3hhKV1ELe7zdjBbLj0Gis1G5EJTY0vMXmUZ9+C9Smxb6HefxH4yGiduT/Sx7kmVsOVn8zGmdGqdNnNdchIxFUZ15u3BHhF4qGV96m9wvqwY2Zz3JvvRiIta/jFtA3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK1/4W7PCekiHps+9P2PkSSKwrBPi9xfK/YUbhErM/s=;
 b=dGMSZCzjZgGr1V+hDjhEJiz510IxazZCPRVTiZjwRTWE21LpOWyDGsr1N5QvkGV6NtVdkb6qAtk6kg3/gy2pgbwZZlbP82w5CQVrY2PXO3TlPQNUAvoMl82aKHf7GHZ6eBSL/VAD6Jxlh6Cj4OLOxlBjfn7zUf2u0gedVoky3bU2aW9xE6NM+53bEf7csXdEUFCC0JnA9B83G+30qOMBeCDnT+bQjdmHM2gXE78NX6oCHqthpY9hlKyjZMzHo+xMAQhEhNbdlVDFO91DMaxwlbm7BHv/yrUwDmPBmaA6K+cx8D7f1VnwQ6Q7YRQ393DAB8ajI02gtCLT0hSk6BthUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:04 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:04 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 05/11] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Fri, 17 Apr 2026 23:01:48 +0200
Message-ID: <20260417210154.2290819-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 967fff44-40f2-4873-cc17-08de9cc493c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	qcwR39MPK9DaVAPJYuEJckAROiyH3/Y/NHuAhlYZKIXjoo2hBGzWn5Y7s+AWF+dKy76FbJ87muz980mqFAlzPaMp3QM6y/lUpoIAAGXOYMiYrOVzufxWtf6Nib3b4xrQIhJ97+HRK79NxNl+Yb4Wsfi/dFNujBOR9uab6461fvXXotU3GHEjJZ7+Vnyxe8smjyFbhPCrJ/2XsgVclX42B8mPYfPhBZLVaRKUwdzlGQ0qs7ocokY5xE9fboKLy2Y5v/QRKNU7kAkzop+slBkMOdvemlD9l9H98GPmND8zXACwCsO6xLW/wDhr0SfPESbs3sLPXfhOyTf7Ogsoq79Z+fgIiEunVgWwP4xq7b1BidutIVd4bCwVwRCtKZdtamBePVQ1JTlo5LnXQucg7V+DSFwhKE1ETTkbaIXbgquP5FZ83S3nHIeiab74B1rkgI/mwUuDe4i5s/tUkCOQXxLMZuTI0Fc1Or4y6zc/TPeWlaynER9TyvQOePpEE9bSgT8mOvyWEjyVTy+HUu/wksEFejuwxGgE+K1zalOPJIGOF5xDrh4JZlbCdoPoRqLX0haOyI8MY4x8axZXICmHgPsc3vqj72ZW8XiSGR5pAAPYpGeef81E/a7tf1MujuDOabBj9JJMoTlzQ68hDZ5fK1f6XXAkP+59ajDMmMPZ1r7nVXZR963wRUXHtZEoayQerqg7DwY9w7BBP+pwqdrKnLgSzWlkvia8zvzbmTuRbBRWHIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/pOHsXh3RNZ5krXT4l+s3bnHAg+feIgvceF7tH/j90VrYHtARsTPBhrylSB?=
 =?us-ascii?Q?TbXFutc0vU4TQ/cI8qY8N89fI96nj/Rv9QHmze4FzSWIhctbQ4DZbwhyi7br?=
 =?us-ascii?Q?6EiSCTiKpclkpr5TOO6WfmudYg3jqoasAm5OVAZVX6+VZ/cRsKJbE0yFOO2s?=
 =?us-ascii?Q?JyeuNcVsdvdXvXHqgyQt9rNrH+PCU44cEjoRG2X0qssuxoBLdaAzYGtJ6HN6?=
 =?us-ascii?Q?rQL9W9oYDWfFXmgQgtS+u/7kxojXIRnCmRE0HOTsmF6o4BGM8+4GXHS6bRCG?=
 =?us-ascii?Q?SbKvVms8di436zwLF0x7S3ZVuO8p71BmuQKTNn4FPdHbrZUmX2Sjrrlc1zQQ?=
 =?us-ascii?Q?PrtmMI2RHuw7xjun6u/zaq+FVoJKIqiJvd04Kke1jz2IP5P2fixf2mTGCRDK?=
 =?us-ascii?Q?oIJayxGdIkIkSBlhlnhiDuDDA7EssvExuH5BBqopQt1p/Q7dHcTsCUdkHRy7?=
 =?us-ascii?Q?3gir+Q6se0TVuTPnXn2uZqX6pPTewr0doQSIehtswM+z3TnHDkcvD4SMO1+A?=
 =?us-ascii?Q?GAdDkix4x1kfeCaEhdmDTdqPqL/MYYqYG7E2xyYRRTbFZ0vAkKrDKvfZlQIj?=
 =?us-ascii?Q?gro9A7HWDashCgQnKyPCz+x3AUusCM8jAt0k1Lsscmzch682sFRzHoJj/6Rt?=
 =?us-ascii?Q?E0Xi6bSGcTF3u0mmTJxbFOQ9A/wEyc+OPnFiww5nIP1q1Ceus5AZFY9K2Orw?=
 =?us-ascii?Q?G8xfxjQBxP4n9zFbeFDLCFt35o3bKA9IRrVIyFVzztM+TDB/CojE/GxZzmiL?=
 =?us-ascii?Q?XukTgNb9SGmcXu/Eh2Sv/OBlc7UE18aU7Z2ybiZ/JRdcmNoiHVA7G3WuwHCT?=
 =?us-ascii?Q?sH/ageeCU4HbRyBd1qltHaLiBBekbr5XH5cRNaEEozckWKzVW4017twNS0Mt?=
 =?us-ascii?Q?z1muoIX4V4T4cmNyGeOCB8elXiLIi9wm10/S1fakxLgl3F17AhKnrUgVL6bS?=
 =?us-ascii?Q?n632p57YF8rLFlnsrQPzXRw0GXkmv2wDz3XuzsARVqHHBNQv/BhzY2HJ0fkV?=
 =?us-ascii?Q?mIvMtVjbmGvUeIhR6yNVplDumPsIYjVv4zgtCYxBq/UQgntWt26+DQEPrit4?=
 =?us-ascii?Q?tT1QgWxmEELb2SBJONd2dnQtd9xijmsmdhX7HYm5nHWibWaVrCJn09+2pZkg?=
 =?us-ascii?Q?ZrSZ+SXdSyhSIpTXiLNHk9UtFUl5QmI25Zka/Do8rEOR2FAnMNBf1v8rzOm3?=
 =?us-ascii?Q?GoiB+197HFNxgZWNXuCJ53cUIfr5NGTGGdvnhkAE4LOPap/Kl0AG2LtPBWTF?=
 =?us-ascii?Q?/jb3/x1JC//klf/FrKeW8KlX011Mdz3Tw6zkfKBWIxhQ7hBvkkkDit2CbFq8?=
 =?us-ascii?Q?Z1WgeNkseWcg2ULyxwMgvGxoSBqgzumpuj4dCAqfCuOhXZqeo88+s2XpuGNx?=
 =?us-ascii?Q?NA8yXLA2rovqZVUt2AnlDGfoNlEEJQroM5/b45zEPIHTuS/GdiWJLbyxd4TN?=
 =?us-ascii?Q?Z+amvR3A9sQ4xKvFlIkmoujP3e/nlrwPG8WyA74obUeY+qbDN8ydM3NgPgZs?=
 =?us-ascii?Q?uLsIJXG9i4ZCwZLRW0aKEZRFG+JAqSM5huvoLjT2XpnYYizdGYNb3yUkHj+7?=
 =?us-ascii?Q?GQ6j5dFUljPQ/IdJDci9WWYG4nST30HDrNusUHj+nM6j3Qfcxwj/EQQ7nyCk?=
 =?us-ascii?Q?IBK6fu57d3MJYOGsT+eQyopvbA+Y+SLYMSddd265Divs6uXsd+brT+/lO/hb?=
 =?us-ascii?Q?syphSaqAnNne0bYXUjG0qqty0YCL0lkAflMcQnT9+YyIPwd7BxyJmUvKv4CM?=
 =?us-ascii?Q?1lxJ6w1GOYVBufGs5mpvFJyUm8rH2gE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967fff44-40f2-4873-cc17-08de9cc493c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:04.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7Xwgttz/k2jCIA8PaqQ/RRXYj338OlLUF5pwzprcrqx3A6fpLkgZR0IBYxR1FbDpCsF+rMv1scNtgh+2GtivHsxnHO8VF2XSCKpJW3UJTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e4596117..0b0dafecbfff0 100644
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

