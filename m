Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10F3AFCEF
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237160; cv=fail; b=tExdBd/jOANO7EUFWS/B2MnBtjxUJg45pO0KQKrv2+/RItF5H/KnG/FcS+gAYwHMrKHxP1W9Wi0hyHd6PvWg9HG/J4By9FjGPoEc3OuomeLegNfMxpQUJ6TYD13UHdJoE7Q8RPYximRJ5ulVsXDe+//eGmsZLHD1BD35EczqqeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237160; c=relaxed/simple;
	bh=weahQ+dooGdePMBjJDIaPKlQADd7k8uivoV9dNNWpQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JjjaT+TBKK805SRoN9xb+k8pNdRxCUllpEf7FXT5OYc2xfPTY4WAYN5tptCBBO4HW7GTsUqNb5y5u2i2lnvPCUjK4F3pNy8FRVSPWWfsVUH1tleHf/yphT8HSVIIt5JAAMw5alVkH67zTgG93xhXK/S83oonwImsobnHxW5uzqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UNC8LhS7; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UNC8LhS7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZZidaXBeLvQzsDyJbpFruVodo2htiH0hkq+4xYqlVdmUO3ZVc2AkpYfzxwXR6F9YnavzYE02Rg5QdPYWY5AFIq8Mi22gmVgMbkh3NO32bVBATVXVvBQHljQeKkZEPSzQ63yKOMkAH565y/QN7RtiShRkxjJ5tInN+8ReutIcHXx/VsrOpgE3Izfgn40GbU2tyZxGPMsYL2MoESMPG3cUGYcIMgt2Xe00w9i8OOyXfxnqWozSPItPBf7PGMp6F996Tby4HT0mSJSqUJZsRhbPsQi3YM34VFmSR08CnNLYeL/+r/mnNqn5EmmelmcjjgHYo1x+pEhv4AgK+m6qDoZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk5jwQbpCv07MQjc4G2pNa5PAnE+iUP9wlVIv42DINw=;
 b=Hry8K/lMv1iB6gcoirWpFcdISIAzoYT4pXepuxfnDVvP269li6PJ1Z9WtdqcP9Ol8gGLocfIhtr1WSKoPMo4w08/VIEj5WlDoELspM+ajr3wEPDcmJ0nPsCX8lHrMMc9H8oHTjlGDJ7Nykj8EFLD3a1WLAyx6Z8FcNR8ncUU68saF8loGnffBME39yX1gRTcKV7AilOiWtOFDeiDshpMEClXvkqXCcolRbaVvirv6hgVK+1mnakOtQuqZDwqvHyj5X7z1chx62Ny0bTe2L8pMjzTTEBeg7r7wQZaSG/LJC9xOkJlzs2+XO/W0kCIv/Gt2FMpNGdHYMexvTRPXgX/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk5jwQbpCv07MQjc4G2pNa5PAnE+iUP9wlVIv42DINw=;
 b=UNC8LhS7NhOl9nhvJPL1r4H80gp4zydiZr4p1fNifr2CymQUrvh+QHALdE+IdON5msXxWSCy0Vx1xdk7t//C07AixKaO6B91wWvKXDZylHZIl+2plvRr7NC74MZLmHJ5gNW3WVWwRvzoRpHHgpw9q7n4zAb8VACeO1Qxft3GX7n9Lmfubxj3nMklAbnba2FjxLOMKYiXO5cvAzZoz30yOqXO/VjBiEP9Cw/W2da/PDRFTHYHDOc5pTG9nzrgX4EHTszbdT/HcGNkTTouC/hLrsn1xubvlkRiO02eOsq/w9fYi7Z8DuJb2dBaiQPeBnpuQDmL5gc8srC8xazQKHN72g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 11:12:31 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:31 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 03/11] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Tue, 28 Jul 2026 13:12:14 +0200
Message-ID: <20260728111222.2699158-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: eaf5d0c5-6558-419c-edca-08deec991dae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	96oEbFYcl1dyFrrOsublfyz94+9Mjnvzpxs+77/Xzp4zzli+HtUdzELu17HiSIfENXF1ClsfRnr5DdBVEPe722HR/i2/NJQMPbHJKYJn8nJNW0fT7sknFKm7cjPq8LQlHwH+b1COZeHiOVRBDAqKwkgE6iIfLSgxD42xa5UVoAZB+IwRGN81ddhofTozkWBoxZzDEqjWrYGFbqyuYuOZMzBxFlFlv6WJQRsrecDO040Cfe9xIapjomgDmpbXGL5GMBtHrC9EXKDTFSVx1Eam7t8cKCMfOi4w/MdJPZnqo5WEF2bReSEgyFvkJGNFJ9Bz3F0mwdtyd3ordtEMgsAsjvSEgWbKWaTTXQgcSqM/7PPM74fHchJcz3TyylaYsdXBcR8LuRhWBulGJkZ0+xScgdk9KFkGbB5Y3/r2vgFTjk1LwE0RzZdUkHQeuBpvkZgPxNkz+irTXgvcrJDuUJkrYqG0qey5fq37epDEyj7QhH+V76Qw7rgCkXoib+JF+89zwUuzrHccY/CbapMKo9dvA/0Im0lGHjk8MGJ+Mfc97HBrdvPLijhTEn/Pqa68UYe7Ffw2BYJFg9P0PBReXDsjFLuCdXF4DAfJAJHmslpKLO3TxSZViPisazdLnRHNPsqS2bcjkQTA4rHpUTPY5HHTSlykGCuD5Ks1Zc1Gnj/OgoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2uoaACJ2RxXc5NvSSV0j7iYp5c6KSK5Y3B7Pnsot2Lh1CWJbItBc7sVKILx?=
 =?us-ascii?Q?mQ7TtcLbqr1f4KjZulRMJXDnCnFCwIqP+zg80DMa/4fRu9g30kMXf3VoPejZ?=
 =?us-ascii?Q?66lW3Fd71IyvBBlo5jJgbg1BYoGZCDIAjUmnpDDByCK4ba2ZlK9XEGlQRUlv?=
 =?us-ascii?Q?E15DcNYRtntvPV2G4kex5KGIdiUS3zWMUI+hjyeRP2KOwPk4qhb9dKLQWbVq?=
 =?us-ascii?Q?8j3qUlx4uu9CtcZrh7LtXIn5iR4Y5wb/W94obLzvLKBoXFvOadL35XkT6l8U?=
 =?us-ascii?Q?9Sp8vBkEt6MCXQh0xmpxx6QB7abK4NSL3ULLuFhrUMuq6jX94gKyrsKQPkRK?=
 =?us-ascii?Q?kfJJGDvK+yRHwGCo/4HlmkoyX9Kj9+MXQ9DoYQkY9jqoTiNUygCo9X3mVJhj?=
 =?us-ascii?Q?e1mRU6VCUXdMXi4E3nh9anVJvdx5i6Ekn/ZF21/LOncbJ2xPtWDHd6VWMttc?=
 =?us-ascii?Q?8ws4jW9BfEHH+gg7INllpLzPItKuKq9yxGNGxSq+WxRo5xwXI3Rx5nX2ST38?=
 =?us-ascii?Q?qRn9+0up35KeldgEZ28PVVapO31Frzvy280ZyRUtGgtDnqjfyYDjkkM92e+C?=
 =?us-ascii?Q?d+5OQ7rmN5P92MBXhBNtQtuF0VmxUMXEBEbTr9Db3bhw3NzmIAUf+yTsLzac?=
 =?us-ascii?Q?gUIUKcHPH524mnjq9Ut+3WXqYBTd6/BNYxYxe6KecIAGJXtyJ6iH2fPe9kqW?=
 =?us-ascii?Q?iQqmIUMFxQ6obgI82/qqO5+D6V21GVy1AihGioKTH2VNj3YEpLXYM5OgQRoE?=
 =?us-ascii?Q?YTNJVWHMfo2WaSQ6uoOgwvz/JSzlbxzFAwQzPWi6GtPew96/Edas5zzqd9wi?=
 =?us-ascii?Q?QUCOK2yKA2i7mwS0Oe7Misdyh4HjT/2X2PV73ScVqUa0WyPihZ3ZYGfBC8fn?=
 =?us-ascii?Q?v3rjz6vlRHdSWCzotg07qbKXL06pXMhMUjYbyO3vF257Qi6gm0I6KSK6vk8Y?=
 =?us-ascii?Q?wf1spogg8I5wL0Pq04/3ogopCbuMHB3MZE5DEQS3dCyZTjjgCNF5QAWWzJ3g?=
 =?us-ascii?Q?DuwfHSIb+7RBhGPr22N2oeuBfPDQKzZCTYpwSpMKdXWVzBNDW29gu897eLHe?=
 =?us-ascii?Q?B1bDDvkCcqUfdi3TAt8TNTnirm1CS5/paIGfXK8LauZxYKZG/cTbl7qV+rxd?=
 =?us-ascii?Q?zyXVcPVFsMtUuALZ9vKScIeMHKEE42/0bWmxdjo9wDa5OLSY/PdOKTCvn/et?=
 =?us-ascii?Q?bslu01qK+ayD0R6ZNKXyeT+jHMVcd1NsIVb50XEDsPWM5h540CIYcT0rcqIZ?=
 =?us-ascii?Q?6a0RoIqpO6pteT7WfWzoAh0tVyNOmAlD5E4A+V56/3gaW+aVcdRrbpEJyL1A?=
 =?us-ascii?Q?Cs7pmJS5fB3SvUhLwTO9SRYx1wymo0ImMGREWQw7Kwi1fwa4gcKL4+Z9x3BT?=
 =?us-ascii?Q?wxJaX5KeK3zjDJ19Og0iD45v4qpBKEmxhFyuMNgrBWoINNLao8VeJfQhLSfG?=
 =?us-ascii?Q?b4eT+X5PkzHUEENpF8grQaT+e8Rn2ErHbWR1x2seCx1oMAe5cq+TvlKyNVwC?=
 =?us-ascii?Q?5ozIHkAvAr5vtImFWFvHm9lBmo7R6Kmk/HxHRkAx4NXknbpGqBjK25j31tgJ?=
 =?us-ascii?Q?S2ojv5tdvJfdgGf+WDxz+/sOZSegqSiJ2uPBiBqhW2VRCGP9IZ+yah2PBgG4?=
 =?us-ascii?Q?e+C2W1VLGqh7pDawLEOyGvK8oC444Z0RcaKLoZ67al2jDS/Tkt73Op16kiAp?=
 =?us-ascii?Q?uOzTb6Or42xRNEtPP4o5tlk7E8C9y9Dk6fUNWI00HwDNDoCO80iteewVlv3O?=
 =?us-ascii?Q?xcqkRHCBPWQI7oeVdKPKRIbrV/PsUsM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf5d0c5-6558-419c-edca-08deec991dae
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:30.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llrRncvoyxlYVTQspDgxo23kZtbTF2IeynlLVvR/TA/2qVdgNBLcMHkTUlfXP0yjgS9xQVQc0G9gHF0c4RX1NS8NeTYhls8gbiJ0RkILZpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8685

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 5a9650225dd8..b5d7205e1055 100644
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

