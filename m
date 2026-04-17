Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219EC191F91
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459729; cv=fail; b=lIDJRL583n769etrDpmpq+MIdKwBEDB079E0nL4DB/xISVDnF9Lq8M3Vi+nSos7sIGMYoQqcSr1i4q+wVLRbMuyJOA0myODfclwkHJaeHNnBaiyAEbIXxiO0/C/iqK+B8wJYSNr+CjiJAfOnbMmpMFYJvCnBtE5M3SIHeVheqv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459729; c=relaxed/simple;
	bh=GXX+/aS0imoeP3UyEBL0c15Lp+eccu/SlotuSxBeu2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pp9GM8cqvbnBb0WceycjV5qDUHka5ajj5btTfXKECQ9+weh0tKIm5iCYyDoQcIIp4ocgz/ETWWrzoPjmiasec53j3ZOPWcn6C0WNQ4pLS36QJvbyd0HwU9Cl+UzCsPLpe4aadicarGJYS8cA8TNhYHboaaHB7QmvUoY6uNf8c5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jACejuiV; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jACejuiV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3hAkW4q2yAshZQu0/hWRGRhMBf3q/RYXyVKVMRmCtvtsbsBdyQoJY2vFcWAUYFun9sOsI1HCPGmxupYHFJt3/QWV5M1M80Nc9mIb5znysUpdxVI2JDYr5dACz0vH3KsxI3bWbwOiCvpwJlmzqPf6KVobi3SbotnY8Akx0/0wCiOSX2SpkTTiN8+5QABO//RUZ8O8ZLDyJXYdWyDmAjCudksaar+N8Ii1S30t3+mYfl78PS2biECrTcH/oDZT1zKtxlo1OMzQA5DsYPETLPNS49jCT8S1qptC+TteCqk/jisFMP98U7MXUQbmSQkH3keaDEAxJDlPBmQAOoaNS2I5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6b4yphSNkR/eTJer715BWvwyMeuuFbZS9qG9XMaQH0=;
 b=PDuM5pqjzBx0QV/8i5cgG6Ccgt2mvUdKUyJwewsowIwQjwXLKawXPi03Pe8MH9RsXpGQw5YLJPsuqDdnpYDz56m1fk2MkkJKtOSQesiWU886d/2+uBXNYOQj8rpkUZRIPDiUkY/3CgG0wluVgqwJ1gXUt6gFQsU2ZBJIrF1oHIT6Rgyw0JLC+/V7YrNaszQKIcFKLocLrHXbmOhNccjzpvts0GzwrtZA1W4OXklzEqPTWk4Z04/FoA7noB/k57BNCJ4z07W31XZLZU170oYxBjSyS/X+CqhgiApTaj+S5XXkRHZkZcQFvb39X5YkeflmMSRb6wgOxRdU/uMhL7k2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6b4yphSNkR/eTJer715BWvwyMeuuFbZS9qG9XMaQH0=;
 b=jACejuiVtzIeTf0jsvI26AzFKf1Z4ky8IE+gZB658jiM6a/V05LcL38ijr8fD4ATgCMpCV4WOzy7eTwaR6SP7C5j92N79BgxWUEREmSthTRNDKiuWMoIwi2i0GC/Byl9nCAvrdEkvpKkFlhMX5vGGI0v1+bERkwq8rkEVxzHX2C9Ws5tTpvXGLGyQ8u+G1EQPSYvFpJ0iYq6I4dFf2e4M6uR9GvfHF8X1QuO9jsjoMA86R0s45N89bjr572ktWNSIgljGdPCLZ82L9fWr8O2380Q4bM2ZRz/DxgxjiGeXJytUDe1MXJ2OKKa/hZrCMY5gE+Q1nKZQjK7uN28xxN6Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:03 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:03 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 03/11] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Fri, 17 Apr 2026 23:01:46 +0200
Message-ID: <20260417210154.2290819-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebda1f25-42d8-41ad-ce3a-08de9cc49328
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	KPePaUuP0oLziAjUv9T0/2z57JfuBvFFQxorS69CdVDJE5l58nNAwPvIGkv7U3j4W1tz+eT9UN6BtnKBHk+LkH9uGvZIVJNQ2rx0tj1fxYJRyVeAph8kkTgzFZZAPrEPEnc5GHX2dG1JTBnddPohDUu1vcqoWmtFI3ZC0nwhejSEjmzK8haP4+chDe3iwDSs+iurmIpFEj0Y0JOM5zanl1KfQuTV+Dz2qJNkQbM+kYGNVEUTEAsh2OnmGfBqoPx6VHypdo1rGTyEVcokUjnLBecRmUPaLO9XJI6S5ieNV+MOxDNkblB+DwA9eHFibDpK7nXWDMrQDXDLPM+Nd2T0cpKond+8GXts23s0vVQ2agNJf+PcDWbVrxqT6WUPB+JYtL5Nvj+hEwhfQ6ve2a9vDvSiyt6KfDlVfi+SpjGWih3DpYLJXa8191kutN2qhQWiEn3ZvyaMxgO19fGuafYvAYZ4aTcf0JP5I01r67+kOpu05/rHs0WRUBh6EX+cI5QVRZVETJNtfTohVAhf9Mv5jmbz/JQ6oQfuFURWwgepADd6Rt24rBjaulmqlgsj3Y6M53ocId0ufE6BM5xEqABV1QM9Wyho4dGOo/IIKVF8+18Cghu9t/1Dzvu6HWh52g5/JmZAcnKwptYrpkPrjwcYXocJ5tfQXym1Pxa4wn4Y8lD4gnrAQYFTM4Mp5Gyhf0vS+5L3VnSgNyLeAHmYBiB+RYin1yLg5FZ6xS9M/OcDtBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzLpIEX2ci26glYJpvphG1qyMKi8ZjHu5x4EU3yB4LKRRFoI7j/12HCVjBik?=
 =?us-ascii?Q?2Lwk0RI306tBCadxp57qaa5dD1CIYeszXxzP4iiqRzOfJkPosU9JcqVUEz4O?=
 =?us-ascii?Q?O5Xs9V1oy/BxJ3DSFNwg+vhcqzgYKuGHEEvDBkaLqWdgeTq6UzcLDFSSMB6C?=
 =?us-ascii?Q?0Sya+OLwBiNJYcLHtkFNx1SP+QdDevgSgBAv4LwzbvLGCCrtxrMkwaA6st4J?=
 =?us-ascii?Q?zknJLemSIdTLxeNpo+xOtFi36cGrC5xMzPAP9KhR0VwQgP9OivDKwvhVOTvn?=
 =?us-ascii?Q?fMlJRGAyPHQlTxqHVG+2E61yCs5PPEfPWnp3mbXhtcSwPyHHimXErfCfFjYt?=
 =?us-ascii?Q?PqZxzNT4UDOs3+DnVX0dR/NlQiFvXUDwhSW1ToGqkx10ASClQouZD5/qwPYx?=
 =?us-ascii?Q?4U4Kl57sYYX36gBCgYtiWzOM7TEnpDREs4k6DkFf5CyusnNTYIJsgQ9Pr3zc?=
 =?us-ascii?Q?W7byF6qtgMYSyySKIHOCGhd7VjRboHyxh//SlmZ4Qg+Ej+gt0rTT/R/uiWOJ?=
 =?us-ascii?Q?MgdNi8/XH9ZPDiTELeuBcHyKAHxM1mS+wjogInJ+IWwVEEIAAyDGIZU+QBPx?=
 =?us-ascii?Q?dQ60t62WFM+oeVp7rBP7CEys6vesYOT++Uo4aSdkrhxsnqehOn2lIXUsGZRB?=
 =?us-ascii?Q?tQZEww2UE12VrNw+JUmPcyu/zGO5D2ZhCOymoKdTh9wHVxwilRd3nsdlfqf2?=
 =?us-ascii?Q?ezRwn8UAV6cDNhYR5JqzgWOHW79rvXaF+3DKjaYLqfolahwjw9g+V0qvFfPk?=
 =?us-ascii?Q?CubjjM7XadYbwITpAtuA/Jw6vM1vYgbEmj8KNUtoJcH+qv5D/BO3IPd7Y3IE?=
 =?us-ascii?Q?WNrABRNXQYS8+f/8UjyqEYnUl98r8LY18SIFLG7lFHgY/2w/t3pLXDh28+9O?=
 =?us-ascii?Q?JeDuA1W659tzHt62bS/tt3il3xSbKf2I1fjDVmOx9lMcjG7q5STL38L3ppjJ?=
 =?us-ascii?Q?hEhGu+EThzLOO2KW1K3wd1T+9rMzIQ+zswFKO82k4mVkSxVLkpBioCCytj+L?=
 =?us-ascii?Q?ow8VxVkMI5t5jUZSlFQtHzdId8ovE43MAHt6akv2k9Xgq/01GQWSghUQXI7e?=
 =?us-ascii?Q?6Dx4jooBFa1I8xEtT4+HfsAg5ptxodSqvJK55LBsZkDqXGmbGITORQDCiHIr?=
 =?us-ascii?Q?bFH04UVoKNwq6RtuP6RTBrg2BLIsRVtBEiEjtJ3dyAT0jQKDH2EqWY1ZSeyN?=
 =?us-ascii?Q?PM3jTacD/mvy0clBOlCKINyJoRFTUl8UmZMEsPeEW6/aoGbAuZJdhvSMhocp?=
 =?us-ascii?Q?p8C9gJQCwgS7Taoh9Pg2nqpBCyB9EA/Jrhv+y799JSUHqHBjDzta0U0PYZ6w?=
 =?us-ascii?Q?5W+FpW1eBQUO82X0Fnq4MqtcF/XMwqBXDcp2nQcuBgboZQDZKzGGnwcQPXFZ?=
 =?us-ascii?Q?+TXmaJ+Wly1utF7yWenFTWhHj+GK5dvWCaTgZdVccTd9g2MxjcTenOa8q/bx?=
 =?us-ascii?Q?npZfy0Q54ncugS9s/xYhPU1VYS4+T3EUh9YcL+f9sGWm0nAbA1bxlchuANlA?=
 =?us-ascii?Q?utQ4nMm1iAl9qxbyFnm81+K/IARGck0vwCfENX8cDuWiT/m4WFwHcv2DexcL?=
 =?us-ascii?Q?cYdsfDoqbq+FzkcoTo6KL1fW4f8hjXvU+NWTDXzsBb2ahHiRR/IFVGecm1vK?=
 =?us-ascii?Q?aa022rdVlCcHQN/FO5Nfqcazfl6HD3a0O+BN762xDKlnEPrUQyswCge5fF97?=
 =?us-ascii?Q?68Rz25BS4MXq6SMpp2s824l1RyIrEANJ+kU0HJ5T60So9UAOvVVK20UVzcH4?=
 =?us-ascii?Q?JcJbtTuv1WDA4+s6TVPxugJIyxV8S+Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebda1f25-42d8-41ad-ce3a-08de9cc49328
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:03.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1I9nutQIKpCM4pjMat5p8jJrWx+VGReQ1kyMA6DGSrb4SJfPJlsKZPAmSY1MDc4W0ROUYhjbMr+rHouKVAmMHqkD+7JY64pE92hF5d/ezQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 5a9650225dd80..b5d7205e10552 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -89,7 +89,8 @@ static struct irq_chip aplic_direct_chip = {
 #endif
 	.flags		= IRQCHIP_SET_TYPE_MASKED |
 			  IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_MASK_ON_SUSPEND,
+			  IRQCHIP_MASK_ON_SUSPEND |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
-- 
2.43.0

