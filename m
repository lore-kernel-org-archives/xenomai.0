Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B229A3BED37
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492084; cv=fail; b=qmLJyRvqNQnnBM3RKoevNLSuibuAnUR6FaUrzGThw4ip6/r5Wo9Mh0uM1DoaZClVWwY07C6373k/6tGyLXazGhxPhrcvLJjd1c1KK6TXMix2qmosgU3dgIMKr8uamYjwOzjHvi+tDZvpnUAwe1yEvfNbxy9pYwz1H4EdFiHhFPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492084; c=relaxed/simple;
	bh=zpqT5Wcp1y0pMXPDCyOhEe/1I8S0EXVeGtQcPxYKud4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZI2ZXMRlcK6udkFoR0g0JI6KaaFU/7NZLyFOHYpn2/l62RHnHqwlwo8A0bmTxJ5U3MDHdfQGk3UHwHSky8Ad5OX3WvSpQDFHzCy1NWU5HnH4A9yO9GRZTfBzpJB74BlsKTqyfwzAKvHdo3AtK5uQXZMtTuR8YDWqcA4ddbQBnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YF45INTx; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YF45INTx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJLSfPKDOqnVIK2qcG3GGWX0MZJ8mlOmmrEL/r3GJ7jWXViBOIsvvu+E+P03GskWFcEn6hn+onxJAdeVWSE06/vrVFt3PdfnSzKsuh7GCRoFht9URb8BMujiXm33szz295pDQxGGhRHZiDL313OIt/kbaWXKuIh19KDbkNu9iOT15sgHT7YuCQs9y5UGAe9cAFQSSDein9Lug+J9b5fRBTh69a6hwbpZK0rVcIJxkpoFG0l9ORvxV0NXeeQR+CG4pF+iO97inD1z5oo2jZUqfCnIzBTJtD1zK96QWp7sbOdfXpUfqQ80pQ5IoKu1AhMqSybsVZ4A3kykPAU1nYFPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFyCvXhffDaNfp7nPHoo0FPJ44vGPjZjiu8NyYSxyFA=;
 b=igL4h/ywhindLupPq2HncFwPHLCeoRM8zMvqIxEMgdZ4zuMHKN9cdGFe+dJ2RrqPvhd3QdLSa0zBnr0YWcV1TTW2FJCA/1fAZdCNmwBPf3lQFv+Rqq/GqWKRMb8PRF/C4vAoBFGuPFdfRrtm1ksWwcLnwYBtapa8ZU8K7/U1LmTVEaQB5YEEflbJRX1FczHSExWgpFeTjtMQ404w6G2VgL4VHQ2h9SRoCc7jhxCXNaDz5krid6ltxhZClMDi1N7iSCurxrxgyK5Tdksj2bRh8en8rJsIeToXNOiEcteVE1R+sw/aSoy22ITqNAK3x0o6vkHQNUyPeZugSzdCraBvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFyCvXhffDaNfp7nPHoo0FPJ44vGPjZjiu8NyYSxyFA=;
 b=YF45INTx060AmemAY15ooaXBLXZAdJMaykwxv/fUKI3SSxxE9rTkyFEqQ9OK2baYrXuHDLiIfdZcDCRlWG0hZIA89hyMF+3N47mDFIlIMC6rIPp3fln0bnZy7xa33tqK5QYsd/J7HRIaLEPOOAWzQRi7+odjdvjGE6Z0RH7ys+N4+jGmUo6Fy1A9bdDBZiIiDdMKWpgv7PUNtrlVL7h1Pb+TXZ8vwewOIyYPQ2x758rjCpMpCTQuLDs7UAFhq6E+mSjQv/y20nUcT9ft7WnZQOQ97E8l+SBJsOjUk4dwrXJVY1dId13Gy+4awOunq48tvwcmHuiwMdQjDxEvVH3ceA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:57 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:57 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 03/11] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Wed,  8 Jul 2026 08:27:40 +0200
Message-ID: <20260708062748.1029852-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24536316-a46f-44d0-3fd7-08dedcba0cb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	n6bIYFnN2u4BIEqMU1HssNiOI6zRKgNeoc4jy6Ab5oHCaIQkP1kzqL+fvDHhjW9mFpq7KxqMVd8i7aVHk70MYWa+3bNwphah/u8KFLcX1mJWMW0pa4Mewq+xtbE/EPWnMkeK8DCsRZzzlaHmtyAk+xgcjnbv+RhhbwPD88FedZPtLKy8DIf7UOlrPz25dyS9GSPYh/12Rs7DpclomSl9x6X1k7dsLcO9h3KRwvD+zDLiGyERbK/EBojltXYLPQdRVUw8qpfNg+JZ1pOmcQLwkeZQzLiilU2OPNSvPL/cFGLxOYoahVzGZLPA17esP9NVPOrct31XZa7X3mJmdcAyogmXYOSBMcT33X7txOCyWgeeMOhUhJzi7uG7y6dGwlsUpT2uyeR0I5g2nleSLE0Y+V4sMzO2cmPMDA0XCM1XGbYI/kT42aPV8sIWrLoZtDce6Zd6caaadwJsXusEAspncSrFlmnn8OqkI6vxzcQ53j24lMceVuIN+abhxeniutN2qG1ELGYUIaRoyMeAx3e21twjNeylZ2kG7Kl7hCHi7LCwyaocqyFYsxlZrPpYpOTX1sKrJhPczSBC3DrqMmrdrUQ4hJk/dSmeHgRFY66ynG2NGbC7FwaJWhHdXhcWrWV7d31hbDe3uGE+g//dEnIYaWe/nDFSA9MJ4blAo+LMcco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QtPrdBwEOQTBWyJdhkdAhRQqae1USmI560EgTg/BIG/XGWOtMNGIleZy6Jjr?=
 =?us-ascii?Q?EdsPsvcHCnNZj8QIHaDVenBgY4RWjtrGkhCI6A1h4wk5Vm4OMAYkhpiWeiG8?=
 =?us-ascii?Q?DXmB2zTMZQBcZ+2HRZuYbypo0h4xHZBqRvC4o7xNYeGrcTluyb1fYspJcnC5?=
 =?us-ascii?Q?fwVvosVuYq0eCJlzSA8DQ56rA4Umq82fvkx6NTE8GOEp2QCCyTYAkD90NQEX?=
 =?us-ascii?Q?62Xi6tpGxrtsLAGuYL8FbPI3RXf3cZzGrLHQe2T8qruPMhunlByvKOWBkZiz?=
 =?us-ascii?Q?Ka1nVQtTTpiRgP8wTibGDbenUKMN2n7vak+jplrplxp4fTwyRPFx0fzDvLgz?=
 =?us-ascii?Q?qHFanHYpCt0FBPVNWKctWxV9SBuClVxJD5kjRVe2KjG1EyYgbDdMp1gWIByf?=
 =?us-ascii?Q?YFlaZaFeRyk4dHofTSfMjy9iYaOeeDhiVKhVYNWFcUiUEZDfdWjgf494sQpc?=
 =?us-ascii?Q?Tu3wxmKE49kYm+T6+CbI+mqknWGEnPPnuQjBa7QxoJCsZCu3dE+0d1y4HClk?=
 =?us-ascii?Q?AntZCDnSvrjwnqKBlmm2iTLgJmXRiA5Um+ZK6wYndo6bPMxAGJtvQJ6PGEhd?=
 =?us-ascii?Q?W8Weh0CPkADU3tc5ULXzuO12HCAGrchTOy11p4sJMFky3ZeX8fwDHZtWRRRP?=
 =?us-ascii?Q?tLIwDB28zDtDXNw9ecytEYCOmtQT5Za9yBizMCQruH9zVIB6Bmot6zkPJVVd?=
 =?us-ascii?Q?BzwKK/5kpuV1LMVQqi0GeN6Mp53faYGmhr1TLGzwQuiBFo/dLq4yxmGjLPsP?=
 =?us-ascii?Q?vFriiHzd7PXZith5g1tupFOcpQGIQvS4qctEXN7fdN3yOxgjBZWznoyfvMc8?=
 =?us-ascii?Q?PFxiP90vBmUXJMUCP123nytQsc34aKM8l+QGvZuadHgZBW6SLDkRdnLFO+jA?=
 =?us-ascii?Q?dYixQPl09+Kju/OITptKEb67rtW2kcS36RkEmaeqKa3L6LFGND4sjH7EqQoa?=
 =?us-ascii?Q?MLIPed9GL/BegR0bz2wT2R1FPciHKkAw020ytt4VfyYPINxVK8qaYgmdQVnZ?=
 =?us-ascii?Q?+wHVOEuo52MZ2SP6IbwCYbxRsdPP6FBCeV81AjzqvtNBud/02p/WgvyvJeQ8?=
 =?us-ascii?Q?ADUx+Jla567nQ2zDkB+2v6wrWbVLZuc9a0T0M+RrOhx5GcxsbWMG1qo9z8mU?=
 =?us-ascii?Q?HLvjsD6YycwF52TfHDmtMcXVsqfdP4f/B9ZEG6f0yShntP47xjaMNua6OpwQ?=
 =?us-ascii?Q?8Zmecx6WuzT1rVXhpYEX6PMCsxzwQNR17UW7rRzQVrH70FXMToQC9pHGzGyK?=
 =?us-ascii?Q?o47gEd28yuwv5o/ojAo6AYiukWlNq/m+EFSBw2ISP5SyfUAKUqluIb/Qbr9r?=
 =?us-ascii?Q?ZxAZe3qdlDwJX4eQ6CMYMGByf2V/VmOnK+Hrck1VAKTqQNEc9GOm7dpr1GlW?=
 =?us-ascii?Q?A9ulssHhs+h9wqJy4U8BlM4+IMgFNpPez5guK9sGLwA4G1kAjU9BiHBSS5z2?=
 =?us-ascii?Q?yEk0WvqMJ/XLGRkgJRYlW/WR3Cdl1+P+zLx3GHQSfPov9lwLLUx+K6rcfbzm?=
 =?us-ascii?Q?cBcGD8dpWjCkIuCU1S+faglwwS8kx/G8cGYj5pDmj1Q5mX2WTaEKPScPikXb?=
 =?us-ascii?Q?xKnmVsijwP6EDKJ+FvXjgGDvF/rdChRiPFeCfzc91r/4CEYxPPvnEI5wLqQ4?=
 =?us-ascii?Q?Sj0fE7/B4npkhAJeobvqI7q2U7vYvSXJtM0WiikuJrgiXAhXJ8Ga1vOlUfvd?=
 =?us-ascii?Q?Uq5V7fQN+CJy0FoB8XwBq3/fBuZpPg+vEU/lNfXzfD8a2U2wQWNg3p6j1EfX?=
 =?us-ascii?Q?WRiIAZh71aiF6KJESmboxOzKGWIFUeQnBwd/PRyhLPygQT9cFu+5St7PSwUJ?=
X-MS-Exchange-AntiSpam-MessageData-1: i8nv9yDr3GcNHCfHspx76oiCsd1Dhwwjtw4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24536316-a46f-44d0-3fd7-08dedcba0cb4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:56.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkLhwADJjFIqMs3lXw15r40WFpGc/tl0MJ/6BU8zAJwlQ15+glXheSJWgvgeAmUJB15ekLjJF2oFO0a5BytG03bv4assWhKm3iZtJFSUXEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

