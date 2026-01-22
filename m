Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3E3EFD1B
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077409; cv=fail; b=sf5nvNXKAvpQzbgTyHlHye/nlVbWm86FWfqal3KxKPKHnuQot6y/kPLMAbrmDzHc9/2ov5dSH+y+25hGBhncVxVdtlNnthaEHS5+OMTfdTwH3jjObhI1FAjBdGq2PDbJDDflNuZWO81dJVh5RW6GHj1fKuzmokfZIQCqMSawFsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077409; c=relaxed/simple;
	bh=R5y5o1kvu8JmhNlVoEqc2jJqAr/WWACHx9MhHI+Mcrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ME0xXAqkrFZiYYfL5YR/xaqo3/9d8Ht4Q8ZqoMHoJGZSdlF8a258EVu5U5sjq+cGM9yigeEIMjY8HdDOF0LWUmhLrEf6XHw5nRB1wmu5Jwtb9tYRjHI24i5Oxl/DJbCWOUnpu1iJ/jDvBFdyYnFntuG78VTANZhOeaxUu0LwVFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z9Hpkvmr; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z9Hpkvmr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYZ3C/bEz+/ZiR10/FbGh7mDSD4YmqLMax8VZQ298DCrv4e9B6k/scUhn12oHv8DCyRW5dXsKJrut3qKN0xhgMWXGJCM3a9qLDFdS+AyqAEOh8gR3YxREwanIwsXFh1+HXrrBuY2Ae8A9Oxo5k6ueABUhIg/iE3+k9t3FOT5pUqFhWGiBqjMInx8mdlxH87iZWPQaiLayGpzzP5AAjZQLTciHUjBXlYw+dPjZBbfifbKKcFQyvlZXux3dYza8DMz42uP4J3bdyVs0S0NZCrKMF9x9d+FCUcupytaXJ6iq9l2BSoi2ArTCY7TAgGOVtVBOHxVeGMvF6DEHgvoJ/23Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/3I3lnnkEgfr1FiJuQFDrgKYreprMdkvxol47FufWY=;
 b=oxPWjFaoCsTtDqiDwPYKA4Q8spmwLZayEnuyre3FkiLNMRvFRIKI6cUO9mQXcHUX44FoHatMKFDwhTgdHKCDQjoi3xD++m7oRxQruHlUwJWwnvjSbGghHBKTT4Ij4TMOfvZoZ/tfMxbwOYlGS+BR2gL6tTyTHZqEcenSpTofc/86T3mwTyWdRxwuJBc7Q5Kb/q2dKMXFZ+Nd6il6TmxYGKtBwvOdlYgZN4uqg0O8QRN+kI2tPLz8vVbRIsNcX1DMCoyxwBZ5DA5w8Uz7E2FRzy2ZZ8A8viJHnSJiETWwdmCZ/KtMtZlfKF2cLJ4RgXTW4Lg1Wuty8NDdnP5IPgjSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/3I3lnnkEgfr1FiJuQFDrgKYreprMdkvxol47FufWY=;
 b=z9HpkvmrsN+DS7p+Snlj03UJNHxPNQgTdnK9wIqGDJDh7orLmd99EPsfVpK3CPBSQX9U/faEWF/xQzI7AOOowN7NgzVVl91hiyTtg7Cp3XJPFxvp28eKTYW1VTN0e9Sf5I0AdIiJ4fECh6Dwg3haNHimhUhehpX1tfAJ1SsqluRV/LMC+QGkuMnV2ZZeIVl/2cI0gVLDlosU+CAQRSFK0e/Xv7Suv/0OcLMSUYrTLylAP8VN47+Or28FCpxCXplRxoQgVJxqApAoBm483OButm3DjGuq3to0fhSS/C85a/YTRgc4rOBLxZ2GZre/EhjUUzFL1InllkwA1HL9hxnn7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 04/12] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Thu, 22 Jan 2026 11:22:56 +0100
Message-ID: <20260122102304.421957-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 0779de46-0eb2-4c17-a6b9-08de59a04021
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBpbVuaSseDeSh50HSBbvcrcOKzo8ILGtERy+PimXxReBnbNURWJkO8PbqFw?=
 =?us-ascii?Q?+DsbInT0Rl6C9Q0KmgP3Ipu9SYVfJeEdPzAGb5U7aYtWcErgunQWrmPkYcdV?=
 =?us-ascii?Q?N3vtM8CiMaELpym7z18T5kdeSRPJhksObqyvuhpf++psGyeN6gsATPpf5btM?=
 =?us-ascii?Q?uMKePfb7sqkR8fH4ojtnl5lZQ69D+cH1tgO5z1OnWm9nA5Bk2ps96f6fQbVM?=
 =?us-ascii?Q?3hxD0yvyXEZ5mVRYPHaSHg12EzcvigcKfppxFBcVtSpFwgJoE8D0lZEXzM08?=
 =?us-ascii?Q?9R1rYUa5uhNFkbokJiZENLMGe0KUMygONQbHLf8dW08Ms8QqAQ7Lr7CFXSaM?=
 =?us-ascii?Q?HBhVI5eSIIb906hSpz4HZO+MAtY1rhyE0SihrXeOWEMoFn34Q46mInl5xtnr?=
 =?us-ascii?Q?bEpR8XhALPXtpFkLSDurDP5Qg9zy5w68VVZEVSyRRSTsaOIUv5f2qxgwsnx2?=
 =?us-ascii?Q?zqmLFCkCCbWbcpma4NHUYxanZhGxOjWq1HwNua1PqiINPeWGKhiGJu4kaLPY?=
 =?us-ascii?Q?DgoD2U/iVp9CIAWc1SHJW0gubM+GkaeW+AKPzZt/FnqFblv0gNnd9w7y0RNQ?=
 =?us-ascii?Q?qvVendDQBynNCsQQ3bhNP9JwzU31u2xeWmNu8X7lWDWAc1rQR5RSPvPG2Fqp?=
 =?us-ascii?Q?YrQ0piXe+iFw6mR27pt+ZYvKroNxRL8NvO3iVRAgau8qDdgIELGs746gkhO4?=
 =?us-ascii?Q?88DE26lfVVNQxbrZ/F//wzJ24kPGLQJCEkVM0fsD+wKf0ZioJnUUrQtZnPct?=
 =?us-ascii?Q?Uu/Lhy8opaaHV5rznUOwEf3d62yvy6HauLZ7YASRo44cbdt3r6xC6z/phT6W?=
 =?us-ascii?Q?9ynqLe9SEMlarEqKQQ8cQQuyFxDaC9PdYKce9e8ggqhoMqPFaSbPKN8LlMZe?=
 =?us-ascii?Q?U7aGALGJUT21FoWauhbiY/3OZQWl62CLRC9WH/GyQVTLAyKU9F4oDYdN9lHj?=
 =?us-ascii?Q?aqeqkF9qcbVwGbrV37Q6GYOpc3/6EQlwEiQFU58x8YbbP1q+7jtmgs8ajEVP?=
 =?us-ascii?Q?WBi0KCtBHsdH0fmAvxRXagp9xAgQ+C4JmTtFApZKIb9P6KZ6jTGVRmdcSnVy?=
 =?us-ascii?Q?OxM4jAx4KxmXMLSrsD92Z2nnhk1KysHqdONdwi8x+kaf5Lgm6vzuYiG9Q9Vs?=
 =?us-ascii?Q?F62wkDEoVdfGlOhWxXNMgcJnYTMvi6oU33oQmxrgzKjinp1X0i0fBa8Lhi4L?=
 =?us-ascii?Q?Tbupq8ggNH2Njab1BsEzAoKLwu9Xef1m0UO1M6s6IAtA2SYzb3+HGM9et3b7?=
 =?us-ascii?Q?xGDHicCBDAOgxfI0clNrTprAaZuK2IkEsrNU94quzd/GBorrn18P8SkS5nLH?=
 =?us-ascii?Q?WkTUvQSikKQDat4KnqaFBbt1U5bMhIbY2PdnhnlanDocElicxMLPMgaLZBh6?=
 =?us-ascii?Q?3uO7Yvgc5bAYNrxyryCXFgJouGO9DBgSSqvKvN64jiZhBo/2hNmkGNfbE9XS?=
 =?us-ascii?Q?9H8APqOuDPIa2f1QBQdZTpckyvp5cNm22I9BFoXiCj4A1UK6y9ru7lVpCbLy?=
 =?us-ascii?Q?JbVE/kV9Q7aYLtHO6ewXg5QOjrbeB6hmhGS0BCKh7UGkGuKmxWLqvyC6fMyJ?=
 =?us-ascii?Q?krVEMWV7i1005BIdlcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bcXSyr234QcA0uAA69C3Y4JMykpDhL+UlMLeFjblZEFcd2wVP7URXV1vLsTG?=
 =?us-ascii?Q?PAcfdIjb712Lws7fkEBhwd6xn7tMr5EalMT7sK78ZoxQQ7roFpCpTJ7t0sgV?=
 =?us-ascii?Q?oj7B3N5iIZVuWU4OkJazP2P+LjRgATzm1qos3o+zgENgbaeRubjPHwGvLJls?=
 =?us-ascii?Q?isARh7tiUUCavusQGYXlNzjQXYPJRogElruJrHCsb8VR9W3oV5WCyv2g+FoR?=
 =?us-ascii?Q?K/Tylbv4qX6jw1Cskiiq2vba08c4/EKPr2G/mWmR6lyV+1O9PV06qKjFfThu?=
 =?us-ascii?Q?8+xoEO+lzrwcBi4ndWoM1u+03DoZ3bGwPkATgtVMR3ChCRtp8x9nsvIBYhm5?=
 =?us-ascii?Q?cr7fEfOXq+kLAgQ2oib97mmEkl01+BVdO7hdeelowKZwZAl2FQqKGcaIKzO8?=
 =?us-ascii?Q?EkBaOtsJlAwXYDIJsT6iXmgEFf4elL178aX6BjlFzXZbeC8JHY9BK6z1qBAc?=
 =?us-ascii?Q?UQcI5agUIlfxRwXIhNcpfaut+ADM9ha4E6lodzkY0xtUGx6C0NmBGiKlPaf0?=
 =?us-ascii?Q?eY93Kn7DZyigGCz2Asu4pwW+8UA8zgD0FZ4Sxzgjt8J2heTkFVgaaOeSsxPD?=
 =?us-ascii?Q?+jVAWE9vq/MonlCsofL7pJ6b4IGApYm5o9ussXtY5/NwVen2qYbBVy7BUaoG?=
 =?us-ascii?Q?eq35VGh26B4eu688HMJpDP+e/uIzcB6Ojhkk/CrE0RAj4wprskfz8NAjcXVh?=
 =?us-ascii?Q?bSXfIXlMssKEBaPB0w1aw5Z+S27On3KxBIzdA3GbmusOCDxe3KR0p8Y1vvTP?=
 =?us-ascii?Q?LzQHXm/dwRS1kbtfLCUM0rYVNrEqFvxQ9WY5DgYJE4xaquaITfduDTG+qDqi?=
 =?us-ascii?Q?mUNf2jHnrKKg4GREiHn3ZF9hBeWYLBvTXJxkPlNvw8ueCk4Z4qh+w23+6uNs?=
 =?us-ascii?Q?E5bw9McMzVQH9Uq9ia9JfaMwm6YvJ0Sp9VybX7X/W/iBB4ofehXTN69thH2t?=
 =?us-ascii?Q?bM3BtCPBrRGr3kt+GiKL4+7aNB0a+9WmrKDCx7e24N4wTqvXyGMaAc3d3Bzw?=
 =?us-ascii?Q?58rfkYDlihpduisGoIMJAw1k98lK2RkXh2fMr/L4OG8v1GBntwFLADTWtfAb?=
 =?us-ascii?Q?ypo4Huw4eG4Cw5wDAocYFvhUqMnUcFE8JWp+k90MdgTXIZ1shutydvv2EiOw?=
 =?us-ascii?Q?co00Tc92fbDlpHE/hIif/qvqUhQlELbxHQly3gi/2g9kiVWZbzZMmATtE79Q?=
 =?us-ascii?Q?x7MyoLNSyBZebMrVpyjKYRkBM4pLuNrqI0DAIUGSyn5UCFq3Pl9083K2yydU?=
 =?us-ascii?Q?um5AZGVS165SafWXhKdqkLpmBUhM5l34ActTcB5jI1dXfmLboU1U7Px0mMsK?=
 =?us-ascii?Q?Ns7EsIU3HghJCBNrcb5Hs/yYNB2KpA11iWsIx3DTI2vVrJGgLcDfJG3uD8Zl?=
 =?us-ascii?Q?yNLWAyw6sk5M4KRXQfqZxqdpv7wwWb8k1HfBO1gf8dACxcWWlqCR42wqS6Dg?=
 =?us-ascii?Q?duprC5eX2LIkh4Qmwr5hgMMY5cCJy7+fnbNUSSgLOaNyq+mM1XdU/BG7mqBz?=
 =?us-ascii?Q?wUVhRR9PYXSJCtiAJ5iN7xbq+KIZROnVIBL98hoItL1FobVBx+xUQvdlLOxJ?=
 =?us-ascii?Q?coSAUtFK/w66U8yM1PlaNlskRO3vPc82bT2SYmlxBb+ZbqrNenpEmecsd0vb?=
 =?us-ascii?Q?6DJagvzhmIslAFgDfZUCipoRkIflpN68jdqUZz3Io19mR2GbFzCPry0gj8ql?=
 =?us-ascii?Q?k8xlealA8vjPqrxUEQlxxXS9cNksnqhmtm61VRLCWSTLLPXog3A3WkddV4f2?=
 =?us-ascii?Q?RbS3Mtb/f74jDhnPYMHI+Tok7tqUN1s=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0779de46-0eb2-4c17-a6b9-08de59a04021
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:14.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV16FRQodm+S+BAUWdnEKhnoQkhij7wsO2CazxtDcBMP6eIvHYdS2aAh164gFO+2Z3RKsGCS97Ksj8OJAr2ruxU0qzBwqySPCTYbuZRWP18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index c2a75bf3d20c..c3b2b6b655cd 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -88,7 +88,8 @@ static struct irq_chip aplic_direct_chip = {
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

