Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652F3B95F4
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077414; cv=fail; b=P9zia6Dr+G+usJEs6AhBle8dsQATS62HJxs4IVptiBOKnTr5VxQWET7mESiJkAii5tZheaRC2GrQx4790IC7zSO4uWljFE2wPCkAJlrn9JjlgGwAVkXAL879EbDl5N+N47q9zs8YJ7o2NDrerHYF8vMakisHMn98Ukm4FjeEAd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077414; c=relaxed/simple;
	bh=DLVCIiThZNJmVUdHfjfwEoNnrH6p1YUg3XZ2lYhSnU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZotPeY9yOFt0qKWG5cpYXxySp7Ur5ShZUHVIeHpdyA34cN68BDXPEQhFLgKDZLlTiggR60SnclXjAgFMsvhV5jpGnmZ3hwFUrC3G/KeD451W2NAp5I0iJA4ofyqoMtikki+cMjeyFvCb5yWRD91Hh9azZ5+Z6ZytSEYFhdzDa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ju8P6K9q; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ju8P6K9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNPOxMnZ6U3vGBgrflvL/As/q5Qxcyi+0U4GMIFswxohXqkBeV2lTguZ7iFpk21FgHFiNKmj7VojkJJz4+o7zbFemrq2gENSFBOG2m1cjGf4Y+Q4AWAi31o5SQNOGcG55Q7vUvOrcaxeYlHxaKMM6aHUFHvCvHRHzOAaFG4RxoJyZlv55DBjp6kUOIk0rjmMdsjTEUnGDOxHI8drrkr3RBYd78X59wZxz+r8hY3Ii6VBpQC14L87sOvSAH2y1OWo9at3H3mycyM4okDIY1Y99iQ4+8rOTN6RVfH/7L2sHWyVDGMVbdw+w5S5tphvI+iPBZwSjVFQ/UlNqrjRW5wBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO2LhDcv1J9IQouH3497vrPKcq/VzNxpPTnolxaD8RI=;
 b=UTlopFtwJS8RJ3kaqkdzomVtKvhK9AGOL9RuKnNII0M82KgCeRHhc1LGHqJD8oUrsQ4/K7Y5x8snH5v5ctumiYF3AwTAf7ZVawyGAfPl6v0dWk0KLrXvWgpF58jUwmNImbu2B/5rRn+24XNPm7+FE/Ajcbw1+88F6NZ2tti3hLAAvU93St/emdxeaMpUnxXOZ3TGsb2W36KUiu7pZ/LD/EPHGdLf1ThDB6tTL/1fjJTBnup+NIRZX+QGWiZgkKcgwisXMfPK0NMdo4HfeFXC3cq3aL3M6b5RlRxW/D9Lb65hovbPXLJPvfijQt6Jh+XT227WIQyWOnXMCFqZ1lxjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO2LhDcv1J9IQouH3497vrPKcq/VzNxpPTnolxaD8RI=;
 b=Ju8P6K9qTZw8LHZYxaO83QFgZTakzIYSWSItU1KI/EHNLJ/SvCGf78QQrrP57jNK1MWgxNQKOSG/kxQclQjxW5obC7todAz96TxziVg1Vcj7keGB+QCcSx1lNRl0ltbtAhh5wl0c0UaFMYfBX0srSmZjZt/OVTg3dJQv0TgPd4yTv8lMsMNRnubiYiohX0rkVLqTeVv5UXWhMwdajN+1PyAIhdiYf54WhnUJQj70Wkw6IeHziB8JQfYO3EHtyKRGExYLRU5q0GTua6GutTx8BdtwZUPdpV1DYI515GjGqGfX/xETqAJJalLqlRtAgZlTy//mVb5xJJORvWA1XOMv9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:15 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 06/12] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Thu, 22 Jan 2026 11:22:58 +0100
Message-ID: <20260122102304.421957-7-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95a5fabd-1695-4dba-6c52-08de59a040c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WduU2dft52Nlt4XtmwQ7GQkBMPGbxt3C4oGjjDexq4TSjtEZHGZT9d3d6hq0?=
 =?us-ascii?Q?/GQm+s1Cy4YSX261C0U5kS5agMxvRce3PUOO5ANG52SnylOViSx6A2afQ0Lh?=
 =?us-ascii?Q?BvCGfaDsJshvWHMD+b31BCtjqML4PWo+hqWmOGch4oSXpHeXtsSwEW3yz8Ra?=
 =?us-ascii?Q?MLIbILcFTzffOBJeccIkMTQnQfLPAF3IZcy2KGETCXOI4MNQHDDu3oANp68h?=
 =?us-ascii?Q?PtNX0UQ+lem8Uz7wtM4U8nfAE9efxbHSRsl6ZR2YnuIzxlqwc+cm8TYyHXC6?=
 =?us-ascii?Q?yiD18RHIHlNsVssj1vcsXf52QFVWyPeEa5cqBeDKZPIgolSYzHhfb9NLwV0K?=
 =?us-ascii?Q?tIEGpKvMwsWWqdSFUzaQgicI6/VoQuS4UBMxG0JJtpcBhGGE8dyGFlp4t3E/?=
 =?us-ascii?Q?SVXfCmCfm1d8Csudyw8daC6nIeotFFaitrhe/c248rSRntUlWto7hTtft5uo?=
 =?us-ascii?Q?J+JM8HFek3dzF1bapqRhCJdq4n85G1Y0PPS6kKjVSvFV8x54eLI7rPzbtY6y?=
 =?us-ascii?Q?mt9I0aIBybmDQCx/G4Mbg+c8zqbLJojDJhhQx3EskfpWi53uB+TZeOomlI/d?=
 =?us-ascii?Q?WuE7oEBgn3B1+oAGGjmX1QoC0/FM68CfDSmL6Lp42RP8UbW9pT+6Pt+LYlre?=
 =?us-ascii?Q?sJADZdejQAbJ7FH5j1TlFjsE6q93XBu60PzZ3tUpMdtU2vQzNbRHNKN/z4Zt?=
 =?us-ascii?Q?zG/W8QnYTLlDVOimKZjBnLnFQIICqOV68677hrPCO9TPN3h9mXOQKGTMaU/B?=
 =?us-ascii?Q?6BDSwRsSTPHK1oeWWgY4re/jopC1BPckE7xzBxVE2wFIcHotJmKE85igSRPv?=
 =?us-ascii?Q?a+feYCz6he7v5KMqd6OYFYDJrQ367UZiJhlhQlHUDBy8YYaW7bS7Exq3f4xy?=
 =?us-ascii?Q?pbR3owen64QHsK/weNCeS2gZ2pz6DDITAZkZGqWuudNouPJA2usScm1Oa8BJ?=
 =?us-ascii?Q?YKw8TzsC9xgpBFaDGJYFnxrojEgRYy7hkqeNOFSyatvphk8Wvf6MyUQn/6vx?=
 =?us-ascii?Q?UFaEaHgbUCltBIs4QiXtK4le9jkoiHq2WfrE9SZl0EfuY8DXIgRF0Jf/3KoV?=
 =?us-ascii?Q?pAo16FsMa6zGU/rQ5SUqBlZ9fqhL/bBISS7KXC6KsNyaS3Ygledva13BsMdW?=
 =?us-ascii?Q?gYMuTnbTHz6y6ShyjQ/8FD2FxwQPTrV6qe/jloE6wwrepJVfX31s5XMG3PTG?=
 =?us-ascii?Q?003l/cLp8AeL6wFqxcwNI3LQwKElSCq+eBx64NyklcYxdjIGZulQ6TwmPAJK?=
 =?us-ascii?Q?1Z1Wp3BIHOKol5tFSEwh5Fr4LXu9NuUHnmf+4ZngCAxuEj9Vu+XhMgXgsBpV?=
 =?us-ascii?Q?RYrttF96dZt3uKP5zpx3xp7puKRcdA4QBaiyMAQQT07zHnWcY39ApY/JFlGy?=
 =?us-ascii?Q?MdPbwsW8jQORTDhSneB8+Fbb411pMa13ziQSuhxEsZ765CVvnJwF97syl301?=
 =?us-ascii?Q?tBwlksLMZuY+rl0RS/lfXTsFmhiDGJ0+xnA3TVz66Lq0JQhHERhKKAnxmrLv?=
 =?us-ascii?Q?mJW6TepVrr+VMObuHUHMHFBnH2qfEipLqFwHkwCgM/GNcjJH258qCgnmbgTf?=
 =?us-ascii?Q?8DqFmI3ipQThFqeS+gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TvyCBwbZfkdmReuqh25H1nCudJMeQJezXgL774KzQAZUQ7jyiO3D6EUlq+xP?=
 =?us-ascii?Q?/NS07kQxP+O+pqSN+dgHmfzfMpVU5N2wnzjxSmu0qXBdfouLMzBBvu5WnGKh?=
 =?us-ascii?Q?AeqHL6jH/g8Mv32wWoi5ha5v3RJ6pjzgzbvQknLoBR7kvHY0NLwiR/eEvwME?=
 =?us-ascii?Q?YUDswv0Tjc5o9WjP02j+RsEQ+pEJzf/UUxcK83XWDU9I2Yi3FdgKFDTLr77i?=
 =?us-ascii?Q?IAagKvOMay6+vMqJokulLI+M7A7KZFP4ykHpGP15fVM1fsc5ToAMh6OKzg01?=
 =?us-ascii?Q?BfN64rvPKu6q539mCkgxicJhEBvQV3tzV+1KAj3d/m0rmRtKaQLGrb6anN5q?=
 =?us-ascii?Q?83VG1bTRkURYhKY0IhS+1v61jm7lgDqYwBPuaAUwwh9ipN3JLczNBQln4E/q?=
 =?us-ascii?Q?cnr6ei33VbtxiJ85NXBQN4bv23K0LqFNXPNBdN2hfds3oRq3fqPO5fdhf4ux?=
 =?us-ascii?Q?wf487lntiYnAfLGJA7BQ6iEoTQQottXsjla+kuIlK5ZA7Y4lig6tcMbxKK2t?=
 =?us-ascii?Q?Pi01DBNEaEDcM+Tkhwc/r+0M+o+eq/Y0MAzww+8CPj1B2Lzl9xuKEIJLsPRQ?=
 =?us-ascii?Q?VvBCXio6RzBv+9+FSgGzFOvCMMsJ2jaEom3lSFjL5/j4Su4gxdwrwZqXpcEy?=
 =?us-ascii?Q?isfFP5r6KVV8dJYVuSmOpIHRfjMzjRIFOzH9UeoZzWmnmxVGzWIAEtqIPedF?=
 =?us-ascii?Q?f7Y2ELUcNK6nSqJ0BdbxTUqmk2Mz4NGIlTcidUyw16PpCMMk8AKq/3IMR3+0?=
 =?us-ascii?Q?GkseCAv6OkDmFe9futdzLklLg1eMM6Jm+BswvFHZPb7kmVY9nDUjdZpNdH3N?=
 =?us-ascii?Q?SeUC489JZVQtbHr011aCsuz/PkM1bgyYtp3HThbbSHjuJE2f+7VVUJjodswW?=
 =?us-ascii?Q?tXk4i6dFqXMckpqwQr4V8HiBCjzAOV/4qZzzHodJnGyR05W7wehHMaUEbDgS?=
 =?us-ascii?Q?nIFVF/GlqD1BiMZl7NayOH0ZkKH3ueCiBxRCb2LmmYJDxmEsZBGvmJgfZA1f?=
 =?us-ascii?Q?ngB8aW4dPTdKNmkOeXma1zqeeIXUmhCyicYa6jQd+gRm6THF028MISLO6jS7?=
 =?us-ascii?Q?M3rtgggU1QwWa8Cw10Phpi4DNNUdjaj0wDY0gdD+gjh2VPOuv7UmxForMYw9?=
 =?us-ascii?Q?3WM0Qwgn6Jp4sNWYvS7JoQrp/K12NSwGm/uunM9PqtgkpQcuemMiSrODUjHI?=
 =?us-ascii?Q?+uhF7oYTkiwpYTvKz8xaxSnLVaMKUJDMwLx7QGLfNSGhr7LbOw5Xo73uVCBz?=
 =?us-ascii?Q?/vjI0EuzSHMs353ip2Wi/yjWkO7LSzcNSidiiI0Ovj5q2JehvLokB57iNMHr?=
 =?us-ascii?Q?yBQ5ZjZFngS/5hiZxPT2di9OBBk4JdOIZzR3AgAdUuAGt8RU+9uoT/yU8PiO?=
 =?us-ascii?Q?srjLNkl8tWHP4ME9wskzjdg2X9MoLV11vDIfmQdVvWTglU62b7mFSETBZVdw?=
 =?us-ascii?Q?mdvRykAteZNX13czoe7vAPl90oPKhX29KDS89bHpegBC36ACP6JQeLbsF/0p?=
 =?us-ascii?Q?Bsi7k+c/TiQxbQGmqqafhHdhI0CfMtFiBzEa/dLHxK3tw+k2fPXY1iNKICly?=
 =?us-ascii?Q?VjevskbzMm8byALPUJkJzNwQVlKHN8TZ3NJyz90OdLRb8nySTdkZnv5+jKnS?=
 =?us-ascii?Q?lDWIR6XACUu7E6Uq2UslVqhn+V03HrwkZ9AL2cCWZm/TPr/2wJS9Yo9e7O1V?=
 =?us-ascii?Q?PBPFuxYqYj+t0bsRVKNblN+nFZfShTPld3zVu4j3MPrIYDHSVWuoExENjS/N?=
 =?us-ascii?Q?YoekZkOcObYDGjjDZ5PBZMZDTdlxAsc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a5fabd-1695-4dba-6c52-08de59a040c0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:15.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zBheQj3nU0By5e5bhrWqMZqvepevDpEaArcaBpfHFQjeP/MKq0OW8ADX456YPU5nNnRtWmL89n5YytE+XFF7+H0EXdvbcjAQOW92rFWT74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..5d7ac88b7d1b 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -219,7 +219,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_retrigger			= imsic_irq_retrigger,
 	.irq_ack			= imsic_irq_ack,
 	.irq_compose_msi_msg		= imsic_irq_compose_msg,
-	.flags				= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+	.flags				= IRQCHIP_SKIP_SET_WAKE |
+				  	  IRQCHIP_MASK_ON_SUSPEND |
+				  	  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.43.0

