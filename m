Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D63DA7CB
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547481; cv=fail; b=rPUXM6cDWBBVbJjVaIUBJf7ufpMeJPul/zYv3GI+U/i5IhhUz88u7xO+E3lCzyokXIUd9AB+PStLQ0JXA2EsqWgER3v1qOobjMQ33TeyreVWJVvQl9PGaVLASRFrRQz/N+qssnX1qYYxsmpErn+ZNaw6cOFVJVBqd1uXabp5894=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547481; c=relaxed/simple;
	bh=rQatWvFsp1g6NkwStPSpCp36ltygwA66TAk9dtDMTmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxsAOUQzePE85DfMH7ur2+OftpIB+DwQ07hxlAJb/r50NmE5DRKQhbxIMHJG0SRcQptAI+io+7+7yOWY9VU3duhCzs1kIW/9uNWfX+a5KIeqQ4vJHkre2NcE+thNLUr4INW2+n7BDZMs325/0we9A8r/dq0oYDALgsh/D8Ql1VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fh5uv1Tf; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fh5uv1Tf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhgfcvGmjtsrKUccS2Lr2tyPhJ/wlzUDktWk2e/2nmzVJFnElIec9hcqmmdbosEYbWsADJx4nYlw0ZxiXOzDCUqA/g7xjHKMYySRpIySCmaf0brpqnNYudlIh3NNeM6Yd1rUSfGsRYJH/Yaf5a48hUjQ05YuSBDCcyQAYjpyrItbM6C8qJSPfUZcVhIB/X6i2WTrMpdKrr3Ab/g2Zog1ntcIyFnRnhEnSxKFgtYx3fZCDBOHCm+g3pu4urnCZpGhlzJASP6ICqvGK0M9Cs8PWKsSU95C7d0fWe8ROs5sdOg+q2PLMPX0JtYuaAkDfxwmMypGmC4pxc4+tC1wAtkLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK1/4W7PCekiHps+9P2PkSSKwrBPi9xfK/YUbhErM/s=;
 b=JJOhPnKEf6RvTGGF6/V1BnPXX/Hw4QvMrgG/UuOG96YcCPe/O/9OFEgyS5wi5XZDjmQFDOOdSOvkkLXTpPmjhoANMuhQm096raukQbCQceL3xUkdEHPGdnDsG8qQ5q6I775X0DYTWhlFzM8CIWa84SlcsWxSTmTNKt+y8RbEGtVKG9M6M6KuBUP8VdEKewXXR48qVrEoVFE34WupCFyTvoCFNlkY9TZKjwE1Pi2Y4+26Ssdku/dMOmvddCZyrVhY39misxPeFGzclYQI/XJMrrQ8EDTGRAzRL3U3+fpAS4C1pWt8IxCY+WxDZ0HUX1Rh0n3Ohagp/sYrCEAKeSDmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK1/4W7PCekiHps+9P2PkSSKwrBPi9xfK/YUbhErM/s=;
 b=fh5uv1Tf2iM1eKmm8XpqKrfkHq2phrOrCnmkiRFNRd9RFt+1rgkqlTZKN5ihtH4Sja9lmq2UQkFIDAkHK+/QsOqh4B8hV66ePrbqG9WnBYi7lnSPsmJVqbYgySTbJ0xWBYeWz483gLGkIblyyHlCT5y2d1qNIC3HvhEeBpi17Ul104PTNF5EYr8BlKCbY4+HCTeMQ4g3G/mk/ayVh8Pdoxv/0UkHXyyjU6z1wFPbC3Nk1Eigv+9ypAZryH3b7Fw+TE8oqgVqz+w6LMz13reVXAmiecXiTAXVozRLU0Ek92pmWZbjh1aUMcVbbcZI/f7Gu4OpLi0sYIqX0SAbDoEvyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 05/11] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Thu, 30 Apr 2026 13:10:55 +0200
Message-ID: <20260430111101.1539377-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|FRZPR10MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: 9306d56e-faf5-4e12-d792-08dea6a93034
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	F/K5LGhJA9p5OYu/ZxtmjT3TsvGIvdWITh/oppm7NwlPKgtXKazbkmzCFnsTE2+wzaaXmYOQpckgx+xXGU2MRhK+X9/c0AUY8ZhlIFyr/M1fTO1b7l43J78olII4k1jmAPJ5aKCg2I4ehUBgAT+gZ36h5MdPGmOC2Mxbv4LDZNQZOIQ+UQC10m5EWl3i1Jly3z9ArumLlZpuhMPdtqKWLBviHjjPvbBIWPLYt+w74rgnhQpnKbOMDs4oD14hP4fgShDl9fXZ+qR9EsTasLTiB/FT5KuNtZHSy838pJZOqLV2qqb9m3Abk8YKYJwtdd6J5ZNKnB80w15YW+kG0U4IpRtnmdtpdq7j861InJrRNmfut4jw3YQjRqSsh4BRZEYCnGu8TwXi6uwfEIvH+QqJjUfqKOCcOXzrqYQuQVRrinujkF06HTo/l/skJmRu20bpFAGIIhm6o6RpXZodIyz3178p4YJE55Yi/fSWFkgcRVUQ8y4QvPZ6xwcD+W1K4GYUlDVmhzyLF3HoQLigSeJ17AaAyfZstjfF9wVFG6rOTcfRSs9RsitO71SaHPMO8RZuqui37CQZv9YDir8S7BQdYQR3SHjHE7VwfMG5HGX1dbXje1at1CgdihLSgYIRbFGN8Vj9OfWR4tJsPm5S8pGEbQk7gn8T3SNOW04NCOQG1UJV4+M7ycNGqL0+/K5E265uJ/P3Iiw4w9zBipl+wKZzbyzL4j0bAW7Pm2tC5BPrGeY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9AueIH+vKudEI17bkdi8pRE7AH9ZKtYtHBlYdJUw/g2mz2Cyl1uJRNHfm71i?=
 =?us-ascii?Q?MSgFskm8XZs4wa8VZR+Js/K0TJO4KplaPtrkFUz56waVyU2IiLi7NuequXvv?=
 =?us-ascii?Q?5IKSaQK4S0qfkPuEA2R8HzXLzmMD5CjMZ+Qik2IlhZLdZ2SXgk3eq2mDn3yn?=
 =?us-ascii?Q?DMFrSyfaWZbSuX9ygdHonW2yD86w06dmRNLUxzpjw4UvmrVmdEpX0k10ES6W?=
 =?us-ascii?Q?QFSTbam6Fdn/1tfp8iy9t3DX9e7JEUCbMaIN4bBJokXjsHo17iPoVw5TzB7F?=
 =?us-ascii?Q?fOCghq15YG2y7yhv6GbJ6S+sHPBQ1m0pS9GuCvXiyLKxjh4xfvmtW1NYYPMs?=
 =?us-ascii?Q?6BEl/uLB8G0sag+sWTHxbBoXa5GHfmSdYn+W5hwXEhsH4MjZLquQmiTq6FZJ?=
 =?us-ascii?Q?rDwy3ZmxmAmq8DbB3Wu8tg7qY13b2kfd5q4c1UOlOnQteSECvs9UpIC8ImxT?=
 =?us-ascii?Q?qjXomX+XUvMwvRQkmKjYoo7JbMkKzCjylUYKrIoYC1Uq2KSkBt+lVAr+eNxB?=
 =?us-ascii?Q?7MHZ9Y0raBGSLTdxL+ywayIXlldJtizDR6TpmQ3MbRSNc8PcMmVuxP9aVGYl?=
 =?us-ascii?Q?hXm4NS7bJKaO0XqyJ1sQSb+oaf/7bAsExPQ52Xukv03S950WT441RbDAbMFe?=
 =?us-ascii?Q?NdOxDmQ3D2AZPBYtuRqwZENkQKwM2bMm8FrPmhVqGlPc7QJtjbseYTXJWDqA?=
 =?us-ascii?Q?tj7vjDDUCa02bm6B2SPUW4wynG14URawD/MYPhZpvEI17YnGMp+aTdeY+NpR?=
 =?us-ascii?Q?SeNechA98FxoTVAhO7VXX5x8qbA5nRQs/11AnOBM0HsJE2ef0byG2lp+3mMS?=
 =?us-ascii?Q?rb84F9rvkbhV8VZ6ENA2aBVCTRGfrOS2s7oimfGCyYmCnL8QkBuIAD3R4Jpc?=
 =?us-ascii?Q?IEC6aN36SY67DH8GxiABQ9gQN/ldkGtwQC99h7eK/tGRFAGJExv8tqkMz7aM?=
 =?us-ascii?Q?ULPWjGs4Vyl+7JkvQ4dJKqOZQmtqS+ou7KAEtGaXn6oTPbVHvq3ahF8HSbsX?=
 =?us-ascii?Q?7oQRyGrWXLDZmjZTgH0WE66kaNMmlUUthIxrU29R+5i8q2yvI6tYGf5d1dnm?=
 =?us-ascii?Q?sM2vtUT7CY4sNr80j/8kra9JitiPI4aSQaCYFLqxG81UJk1p8gGqniYl2zm3?=
 =?us-ascii?Q?pHkMB5XkR6pctQbdIXbg9uxNDjB78eosCw9YfMiFZs8rCR7ahLue1I+qUGHW?=
 =?us-ascii?Q?tQsWx6R8TwEIG+qC1NojXTLaFRUlGowmnP5Bhw1VBhQIQY/CthwmOMl8OUZU?=
 =?us-ascii?Q?+Tii4HIWHO4hLk9AzodOQ9yfYBVZUynvuwpdNfiT9ryRu5gsiO1v2evrN/AS?=
 =?us-ascii?Q?1EJGrOCiw8ISHjyRjc6LezMFcE1k8z479SqB8iWGrzIY8KFkh5+25/6o3NZb?=
 =?us-ascii?Q?sZeLbw1WE9cqjl2fN4FBsVVaYL0CzU485ANVxsrLCtTXwqHclEAHlOSEv0vU?=
 =?us-ascii?Q?rBtnjCMNdKR51gcG+jIeK/S689Nkoo0+F4mYWdBS85xric109S6JXk5GEgG1?=
 =?us-ascii?Q?kyV5J7zUIKQs2K7Us5JXVwNYV13jIE1kkg+AOK14B1aoNdymDye7Yxzu/d/7?=
 =?us-ascii?Q?OxvDju/7OYw855Tr1wrchKt648YASucGbF6mGgZt0EWP/zgENEj54Wi8J0lT?=
 =?us-ascii?Q?3LNtIi34jQmulBtIYc5n08CVVBQzEokwLxteVtLSMIDueXLzAbRKXk1mqF2R?=
 =?us-ascii?Q?4xk0NR5LZlq3hua6FzjV9RHG8jWaijsWlEmhO4bubrn86h/XAihJel0VkMVv?=
 =?us-ascii?Q?MMBNz8wt7aQKH4wJZ8ARoCYnNjsO80k=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9306d56e-faf5-4e12-d792-08dea6a93034
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:12.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAkRzXmPFBWEVAMIGNB6P3FJVlbI7pc3rrSmYLe1d1wxev7bW0G0piDdR8bFRMLiowZgjfevzf9VtFKgqUze1BlMIIF6f4aWQOkvbPK7Gws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

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

