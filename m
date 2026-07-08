Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD043BFAE0
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492090; cv=fail; b=dGzEfP4aYa3ibRxp8bdVWskli7wzYUkoXa9ouEnFHP5v+jdesv4lbsrvvaaoNepCsbKuiW/zTCqVgamqgweSiQoAQNbeG7rsFJjLWDeaZKw68W8wgMn9dvJjHyrPNZTxr52dmLHB5TNtM/8QU2C/V5y6b6RZtOo3hhh65LvMioM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492090; c=relaxed/simple;
	bh=6mQOCTGkqYoblTG2viJ2VgniBCF7SP1KX+1ZS08p8RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGtEySPl13a+yuEpSFZic3IZQzOmUJefJ4+QN4oGGynghf6AW9iMc5cF8XaD8XQJUsx1EVI/8FX6r2NSZCZeG6agJ9RkWT3Y0u9yWwMbVqyY2dSr5CZAP76d0u/uw9spsziJZs0V48RCB6XVY3sUrvAxUR0tIWj2Kx/mbcCDuxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pf/ltJM3; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pf/ltJM3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVKuAy80eJSXsEwGH70kx4UnmYTbgQ0OMSItZ0NUXUDxvGvqF1vLOkOUNUHlDfcI5eImYvxpcCfAqKD4OtdBi3wqvpzYmIFOvt23e/28ouX8r3J31diBZseLusmUdSyIs8IIRxs2qZqsc9HsHBaCZX6I3+YMsSO/MBD0I9xVG/10nveDQ4CZce+XGzcud961NuAdcOYAFGEedx0YLiNeo/uqVCto70InxOBTlb+EcUXTNT1z7w1hPYIvrtm6sJouXV/PzoDn0qFqrIkFRQgZscXhzvcghZ5YS0gaUlmcRKJgxq5jDUxAy5o/aebbxJW9AqRk1uU9vRYpg7+Deb+VqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOTpuAIdFjyxxaWQGWatRjCPf9GF+srUHag5qrGm7hE=;
 b=uwLxqHclXNvt4qlQ+ye/HJU2SiaKB9lx5nBHvkv/wD3Lm3j/YSpNZMo8c+mbfCBPdsO2/RL3ROd6nUtziQ6wyMOYaEYEvDOEwpWhldDcnGlR9cwVOQyDpFpqLnO6yGup+7lqGS0+66BfwmlGB8WEzIjETF9e3Z7Ypy7uKpFvb1AZF9+fRhmFhIjieaN/gMwhEFl9Ko1w2im5wRxudDYhpxQBw9Hczzdt7xGXdvOIomyW/d+R1SZUL+95j4VbLZaFpivDxHkAg4qiHjZvxgJFU6eNw5swhuanEj5lRYuUklLPDhJRdwgvWP7rIN029WXf/YNKdmbf7vHziLRok07dZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOTpuAIdFjyxxaWQGWatRjCPf9GF+srUHag5qrGm7hE=;
 b=pf/ltJM3K4wz8ZStFYl9HCDjRQeO2bjLpP8slC/cbNKthIheq2dHA/t4BB1aXOAYjhBYRjNfzAOtOf7y88qsU1pEtzHy5Aq4L7ubHkIQxaoZ5ZAGu9DRwXEyq98dDZY2CEQ8eN0zhuJWFf0NdXvgsc27QdPsNSsxkjdlUhX1mA4xbElCXAOtnPKu4BuSm0/bkisD85I/wcV2iFf7BcBIjs8cZl0JPwWcIk5Atpaid/BJ+70xjB/7lAn/dkBbrMViiH8uAw5GufRA/4gVvkXyg53lNa44F1ExWmjESqCaUEsAOVRwOxtw4VCrlSivT9Za7koBXxpIBCmNAfWbvl3o/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:58 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:58 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 06/11] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Wed,  8 Jul 2026 08:27:43 +0200
Message-ID: <20260708062748.1029852-7-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce84ded-587b-4312-5327-08dedcba0da0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	FeEIOGRxwzunjkwaI99xvH0Pq2zE9t08TcO8D/owa9hospUERBetxc6tN1ZNgnU0wiv4CQLzdOL0Bqa0Btmb71smaoZ0zZgIeTKF8CSAGAJARO1G3R3yyr4PVkqW74POIcFD7cWMUZO983/kMK5ojLNSHzHp0HbJBYm99loj4KwFKH0b/PHwwRhojtO0DPkvB5kBNu4B9KWi19OEvjf1RvpGMacYpuahpybN0bCV3bhxIuk6Pt1yF4qh/thgX/fCy0mLOeKzb2nOy3s8JOSwddWxSHiHJNZKaem7MO8pR6wkIHwB7wDJX0WqlRCs3XAF7GllMM4LckrXTtxXGSLpAmax88AASRj5hCaPTlHzBYYusn1FWcuMfDYJ5N7NUhxRZ4DWbe3GJmQ0dOcL2gy61S0+ht96uhZ5chHzI3hnypY4bZYNoS2YWNBybkvzvE8hGQ+6XSAlTA3uv3kkvox5wfkGY0ZP2s0xsfnpt72MZpEarRWIqLs6wGbGO8yea/l0VFEayMkUsHvA7D6kLpzi/XsWtBgAaPl7AyU0qZjrNFEjXQNalefubBfv42E+NLy3NUHh3Wgr7sTWwzvGIdU9n+aIJtf3FiqhT2L1ncWEdUcxaKiKnDdDRZBAfcic4UnHUTCyi5DwzfWneUlh1PV+EIAMdl/TqJkAtAMmtFvyHWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OFL8qbd7aUdDh4UjK/yBU65TExsqM44fiZqMtth+BW33zE8E0flQ7SXbtP+e?=
 =?us-ascii?Q?fX36KHjs7Kq656wEA2/J8mJns8PuEUZ7/ny9VR1F/nc7ukqWaF9eksmoliSz?=
 =?us-ascii?Q?IKm/y8RCEVlG6WBQ/JlPamM86dDbvA+LxUl+sIe6hHlfXpnH1tvBWpxiRM2E?=
 =?us-ascii?Q?CBHUcgPFyKbY4bVnDibtdakurrfoyaZqAWvreF9Bv1q9qehSlqWAKuph4Tl9?=
 =?us-ascii?Q?iO19AoJUN0BgmnJRAKfUnVuKw3zN13dkDTUOhN0rBdXS5Z8fWLJUJVP9sFtK?=
 =?us-ascii?Q?6+4pkFiC6Cnoy+C3ZWdLurt5WkqQ2KsTB8ymrtWMRpspDpEx5pNRHLJ9x/xt?=
 =?us-ascii?Q?QahnOzsO24iwgA2bM3nuvmRbW9SwRU9rmmyt05NcFtsMTWR2tl3341uzCHK2?=
 =?us-ascii?Q?ffrMnRIup9518H+K6qwAbrHGTkkkhZbudLEsP8m/vFMYxCv3EJ+9KEFb4E1z?=
 =?us-ascii?Q?Xoh7Hw9wTaXLr2yLUrN2bEOoSlBkkWSBCBbIAdSLt6MJ2+KiJlYKZvut+lbJ?=
 =?us-ascii?Q?JdTxyAR+0et/SicRAXmOajwkruvhQqv4ov6q6wr1FHVvFGzOmMexht13c47W?=
 =?us-ascii?Q?iSy3l4zWgP4xtClNvLCdyLPh7TXQYQZ7HuVv11GmEoaMraebsndCeuIvsCxa?=
 =?us-ascii?Q?AKBCheRMS0JvdZ2cMMG33Z8T39C+XAN74rcUYuVObcvAR3dHKFftW8VfPKBh?=
 =?us-ascii?Q?MgPDn9JSZEAZO5CFFob2NqI6HXsaMwfrsPwL+5J/T9pV5YUAGvPx6R2k5wMc?=
 =?us-ascii?Q?68BzTX6s5i0QUdm86vgMYSJq1riSFoeGBQsdkwqkPsL9+hktolPuXp3Oo0f1?=
 =?us-ascii?Q?pNYzz7PouxQQW1GHSbnfx3qFl8Ci7iJt5p7bDwhrT6RXuJq+tubb0DQMoPWJ?=
 =?us-ascii?Q?r9J0ZA9iEhjREvFj/RT7dWOqf9PcYkmU9+vFsCwuzzV15BDEY32f7qCyX4Mx?=
 =?us-ascii?Q?8nVEjFwBmllDOrKRJ6JgLzFZX8/XAEfIuGANrjBFwc7GprVwMVFVoXgzyA/q?=
 =?us-ascii?Q?rTzRdFZ7Zd/cMbN8r55BI8ErgrEhlkI0qtGmXtYp7KOWqPeMh1/ZNXu3gcrk?=
 =?us-ascii?Q?SAafC2cbaZLC4OupfELc/pYTEJyRZCehtyBElGlBt4x8huPClsCXp9ZK5Jyk?=
 =?us-ascii?Q?flBGCsq5P/cX4XcWKVV2+cAyPEIAQH9FoLlMyGU5ru8pQzFbI8zjuYoUOcuC?=
 =?us-ascii?Q?bxwrsO5jnPSgWadwTxGsNUCEgww4KlpYOPoRwt97Vq5CetvxTEDS4ICqz3Cs?=
 =?us-ascii?Q?22UM0SvVBGNfllji55O21um8S1Q1Q2p/h8wcHvQ5aAHismhgiAm3JbyZYV6E?=
 =?us-ascii?Q?IVa163Le1ke6hlWurcgG4DIS7hwnklFD3A2dQkWWby2BcQKxMrqGzMJAu94t?=
 =?us-ascii?Q?p1boezdtfM4HvkZcbQgHyf3PKV7yftsW2f1mbs2p0XPh9p3idPiUJJcYcrFa?=
 =?us-ascii?Q?9urStofhcmedhTBBESb1Tg03wa+Zd8OlZ6SRCBjSisiD4PtP7oFM9Qwrtlqk?=
 =?us-ascii?Q?61871llH53WozgywhGWhcB5J9uY4nytUN63R/Rg2ubV8XM3cp2OoOj4j8zTt?=
 =?us-ascii?Q?YSj0CIFwScyJpVN6FB/rsX/zZmBEFbSwyW8nALWbGnxANxby3O6Ip9hG/QgJ?=
 =?us-ascii?Q?Esyv+S53GqIBpAXMqVSxkyga0WcJhZXaA2wzp+EDnWU4ifn4vyS7yMupcAnN?=
 =?us-ascii?Q?Q/y8Vrryn89uptfJcHq5aZS+mkTjzIkrjUyjCz4HAk4jj/ZN1z+F8xLmkelt?=
 =?us-ascii?Q?RgniMjvFhvutAYX1z1Ukq6AJv95sTZdFBD2K0irenNIZpMUD8LTMX2PYxoN+?=
X-MS-Exchange-AntiSpam-MessageData-1: Y4DKFojQ1jlELLfwYxYccAEJndl307N/8ec=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce84ded-587b-4312-5327-08dedcba0da0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:58.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80fvjjK+QoPLc3pD2h2r77La0B2c2NInZaE24dD9UWSWGlV1owrKlcY8DFlMOzlDRdKWD3NFuOSccwr3t/J/VT9SeoS2oMIqhp7s6i7yLIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 84418dbd5a27..855ce8dde27a 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -111,6 +111,7 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip andes_intc_chip = {
@@ -118,6 +119,7 @@ static struct irq_chip andes_intc_chip = {
 	.irq_mask	= andes_intc_irq_mask,
 	.irq_unmask	= andes_intc_irq_unmask,
 	.irq_eoi	= riscv_intc_irq_eoi,
+	.flags		= IRQCHIP_PIPELINE_SAFE,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
-- 
2.43.0

