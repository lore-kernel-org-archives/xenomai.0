Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500143784B
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362585; cv=fail; b=WPR63sbcwCcF/zaqX1meT8CeI+Sua3dIVv4XNTxWAzwMTL5GzKH9aCEdfkw278eM3byERVeM5g4RnkzWxbLCGWcNDTNpvtpYZld9Hae5ZMMREK7xlzEYmS5eb8E/sUmy+kTvXQts3PpduW2sDYXpShvkHB8t4FLVDlF//o6FPeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362585; c=relaxed/simple;
	bh=zpqT5Wcp1y0pMXPDCyOhEe/1I8S0EXVeGtQcPxYKud4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTWaqTqhmO0An3LqoAeMqzwUJDLKEXgc8kVZ1acb2hOjS8YSGR13lOBRAW1iAl0Vsj3wHU4dEB0n46ewrGXPQg4ijp3Ozyhx53TiDJsRPLuY5Cu6iScNXW4GvaJ1lmusE2oNW0oyKJNd04YOqXl4p9N1ib3hQSZGjSX23C/XPMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Yqcx0RlP; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Yqcx0RlP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6CdBmNmB4uXf0/UL3m4ii6TF7++AKhfz4ukzxYd+DqkeYLWfK/jFhGuzHSH4LykFYiMw5c6WnJgkR35ylt1QPijlEwxws94t5XpeQZbwoRaLjc6R8FcJPH+aXqdn5ik1DcIs6IM8EffuJzFrn2POYVQ8wda8tBqCwdKthR8N4GD5zMkCEFkcD2K4u3b9aFBftPzf0qhPn77Owk3zowu89KK2k6LTkqlhe35LOSUsJGIOnQ97PVi69dwRKP8fJoBtx+xCOCMp5auuwfQGkZM1CNrCCCKuPRIEsSPhTFfL/uaeaxZgDmMdb/XsZTGvs/b7iAMP9OxTi0WnWrQUR6Rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFyCvXhffDaNfp7nPHoo0FPJ44vGPjZjiu8NyYSxyFA=;
 b=Lwl60vnCC3z/Cj7SSWoo2QB9hMjvCW5Dgn/uYikOiIzMRqN2KNl+Rq1Cw03YnFLjEmkQ3zVBvXUnhFhfsW/EroBd75HDjW09KSoC1OZE0G0UQe2QodIimnc5JflOWnRCNfGoFzZW9HyOeiUW/yKjqSfQFzq0fcX8TYALH8GmOUkGz9ToJdxbi/EyZpbANNExse0YvVa0pr9uffEixOfNVJN7aYZARbOqsRbVuHBJGSsxx5YkkXaizjjtx+CgGhIJ7H4LPejBCLL4iqIRhevERy5SBrDIijxvL9zNxKt4R5LHTvEt9EShQD5aZlUloxuREXEsDXaNPX9Z/BD3k9GQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFyCvXhffDaNfp7nPHoo0FPJ44vGPjZjiu8NyYSxyFA=;
 b=Yqcx0RlP1thHQJ+XGWcvwW8E+CSwwqBvBQ3GymFZDT/kegNBguiAdx8hlkpGRR7kQvenxXFhQW9gR6VJc3OrVyTuuciRsuAUZC8+AapPmRdXm77qexPg0+pCjCWGps200KIckgDNFgSQG2ks9oDVQ4tWZL3FVEeEJh71rhEiH786ShtUqSW1k2Au0v5INUMJBUoxP10gDuzYqSn9ju1e2YE5Gt16snzEaS4pAhEmn4Ogb+qcf1G74b6D1WDlmJP4lUinrij1Ll6/OVKzrd9bJWK+suwtloFOxHoT6tK+LeuOIAmv2Vk4X/UdxX49H1gRdSDyF/1ak8oxhaXB4fO9+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:36 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:36 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 03/11] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Mon,  6 Jul 2026 20:29:19 +0200
Message-ID: <20260706182927.281078-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: c64cd815-4ec6-48f6-d3a7-08dedb8c8870
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z9Qv/3bha7R7n0yfvTovKcn59Cey6G/SPQgpr3F+zxxO5RJ9l7P6BN2zIyRv7u4+F4TVosT46BGYYwW29gtvXGdz5q9JobdbD+ThryKBdmx/3HiiYbjUSqCpTC7TfNEyL/XoJA9NQJT4a++MUNQpMLL1qCowHNf/CX94JfghNnzfpdb5K0E177q1IpX3iiyLRWq/bGkoCpHBGEfoqcePTja93ElCtAwYwfRYTG4QCD0W2EUFpYss8Ec6RabjNnw7Tv73cEoDmnUToOU8UoY/G3o3xIoHEwaOt9r1ClT9K9Yc1t+qXnmYvtVhmZPcz6JpI7cFQROG0N4gJsm3sH1rirkD5MucR9/rE0WGViHitWICNTAsy1hfX6O+e6g4P5ss6aMN2WqMOY8frA7Hc38ZApGaXMzEq3tIaVfwc6S4vNmZvlPK0fGlZVC+9Ke8iB2nuSmohPfPv6dPsHFStLyly7Mm+EWa8KAy1KP6g+U5M+R/3tLWQXeVuqFsEwGQ9YCaUH5pvdJxXI5k/WCyhLNWeTOBmEnVyMe7JE3eYAwnNWwGOmRzMOeZvRFSRq/ZMEcd17yO/s76mboCYasjQq2WRGxMIwaAFz25pLhaHlwQO9Cmfa118a8PGCuS32xAFNn2vqeDifTTXx+nBJdZnwod59EbsIAJC/a9buCFoeK+lCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FliBFxE1lZO351G6mp6Y9GrVb0SsHr2x9a6ASqPt7Fbj2gBr3TzV81oBwaeX?=
 =?us-ascii?Q?gg7Oi1FqJ2FAV2RxF3FyNCgbc+tff/tWwTTgwAElOpm71DyaxpsMK/oe0/KI?=
 =?us-ascii?Q?loCk8EaNyNYN1AlPRjdWIe62BMcpV5RoJBQGJJWV/EZzDcZzDKrDqffzjEYV?=
 =?us-ascii?Q?KSsAA4YJrO1ttk4PiruVaUqUP+/r1zgn3UVQ9ZKm0/VES0DA2PRqEMRiqY7r?=
 =?us-ascii?Q?bL1FZmgqJ/q0WbbveHCfmhssly4l2FcfU17bLiDcbYk2naCP56Fy6LdyvwRm?=
 =?us-ascii?Q?jra66B+h5CAUy18y2bgX6ywPd9234lsT0AenVFtANk2Lu4YAQ2Scg56X+JOM?=
 =?us-ascii?Q?55pVfe4Ra+e/3FbBRl2sOH/FSJYutWVzu5WG9eVIbmfs/up4q42KGHsWJkRv?=
 =?us-ascii?Q?ZVM4JNxGWQYBYWr5KaUIXbebzB+49MXy40Qnmzc77qu7Z4sRSCfDzqMtEMjx?=
 =?us-ascii?Q?/e9V2SJKvr+Tq1nRfXcxhYQfOVV30fMjEks1nm0Q7xPUOaxztxghkjUMQ2KG?=
 =?us-ascii?Q?A2SbCvREuo6XFSIUH1d8moKIA7t4HEvTPAzWShYfYo2EjsHDZks2CkCCOHO5?=
 =?us-ascii?Q?E/BX9QVL/Tbde23UGVss9pn6CzZsJW2ogqq3Uxbt50CxdC2lO/CqWJDHSqIC?=
 =?us-ascii?Q?peB1T7BFYLpfJ06AorEg8y4G7fMiEF5jJGaxYC5RK5r6p25BkdN1eTjouxxX?=
 =?us-ascii?Q?Bpxk1z1+V0BOS4YZYWVgV9W9KUPa49MXVCFDjf1lKlFo0JWtnWYxfVv+puH7?=
 =?us-ascii?Q?HHQrXjiklDolmsigTwxjh5YAHLTMcWxXL6ae3FycFs0duVXu8j1jpC3vVOg1?=
 =?us-ascii?Q?4UcI2KwQ5goqghqZ1LN/k8zwhPVBdUYJmdA4ZadDKVDXqNKWnoHgZ/7F62E1?=
 =?us-ascii?Q?VRQ4Lhil6f57JmpeDnMm0O6rj9JG8yTPxmVY1msd5H/QFQLV1reWYdHfgE+F?=
 =?us-ascii?Q?1ZHwm+9MmNquUtrLY2cc412P7ypaHVw3v/nYJYVTePv8EpD2+C26BV0G6Ffj?=
 =?us-ascii?Q?Ob/OuU3jhrHCsRI2FZrxm2t9bx6sieX8s3jiG+ky0/sYr92SvergtiBjj+UX?=
 =?us-ascii?Q?eO1oJ4vstt3UlCqLtATHtJe3/DHGe7JT8LrOm5Kx+3+BQY3aw+/VLOZkmmoe?=
 =?us-ascii?Q?A6bc7C7si8dvqIShwlRlEXbOF8DRy/Et7Rm0jDESNSGCe51D/eANdKGUacne?=
 =?us-ascii?Q?2c+xnTsufwqt8Kc/cALLCQCsnWSQYAyvhnrtzfDPvn00T3Fl313uN2OqPO/1?=
 =?us-ascii?Q?/1qz58eDywR6MM1F0YLvYEMPjL8MCYOfg9rDTBq6/6VvNbLX/BHouubOsVU4?=
 =?us-ascii?Q?CeKT/l5He5IczvkUsk0yPT+PPxewUebhnd5b2B9OS0CYYAxoIzHHdn6dn1TM?=
 =?us-ascii?Q?FlprRRYK6FPTMMqgD+TrY+nGF/XC0jQPc142qYF/Yg5pGPxVEjF+k/hQ1OSU?=
 =?us-ascii?Q?6o1Uti6Fb33iEw5yzHtlhSF2/LKe/0mCPqUDSbT3Qi1tioAgdzLcAP2j838n?=
 =?us-ascii?Q?Qd0PGpVL4A5j1t3B5ULuBjJ4Yq6UuDL5SfgcEjMv9f4hFoaHlpG1oAwqpS0e?=
 =?us-ascii?Q?X7VLCc0Sbuyvbjz7ZWmWi5wpHYmYW+3I/W4V1mQyoGbN3cktR90gr7E9JHV1?=
 =?us-ascii?Q?r2pKAXgs40LRlRfyP1VxM5GOfT8pktoFezbwp5E/SFyO1jxnYA829LTiNN9d?=
 =?us-ascii?Q?TM5z1qRfdNq7+OOIrCq6GWIPb2njaTq94+TfmkD1fi/C5iU//BmsxIJml5fX?=
 =?us-ascii?Q?8wVS2FfdsRXq4KmoA7ydpb7d/X4DosfH2U6YPTzrF6XG1NkOuYZOyuUyK5Wo?=
X-MS-Exchange-AntiSpam-MessageData-1: 91xNTHzTWLr+quIJlD+haJrRqd4zW4+29K8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64cd815-4ec6-48f6-d3a7-08dedb8c8870
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:36.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzPV/Ddn+CZrjkopUU142RhJWdkH039DrP9BfVrsfgBhnWdpH/3ja3IQxXQlsDQ3GCYN+br6UnCrl57nTnRwBlkCS1kcOq44mnotTH7W36M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

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

