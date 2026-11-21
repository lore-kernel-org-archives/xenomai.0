Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795280364;
	b=rEEfQm4RqZeTa9AM5D6GUD/mS6NZem/0n5o9rEs2ae7YtZ2GqN/RzoBVR2CNDZ26R2mV
	 lxlxF/qLOk0EaUsqTpHzXIC8Ypg4elxGXYREH31N56iqhAYdGsVMMmTfVkztMd9yAIgm5
	 r3PVp3wgpqFcJV57pByLNhmDu6Coy8615sMf8KrOEtUhS1VdnqUamoU9bLCd/VHzoRcr8
	 hBpCEbei5Bv3FJndcz/frwv53WSQmUfB+dEdWw5SdxwEU9ttC1DcvJ4Vvap6+MDmrGeGI
	 kdyHxGB6HdURb+LqTwmXJYxJfWy222AIXrSnDK1S7qu94kzuIbH/8f42YeSe7FFZ9fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280364;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8B45j0Qz+VQQCVdRHCBqmkgMovuR4tIPWsDoCVE74OU=;
	b=miJCjrslH0e3RtZG4Aja8Xec/yz1GZ/J8HRfimirh95OnfLZdFV60WHJ7QOz11IA84Hj
	 /Vbw+ZXYPPp8L9iM0mzbq48BL22evzQPoxF28DHiBapjvZInPWkxwBBpSKLs9tDDSn+aF
	 BVA4Xj8HO3+D315pQBVV5mGHxsjgnEZw/3Ln+wu+ub5wQFp6Lp3TDhtC5OJBW4bmEblFx
	 qWuo5Q1XNLRVaFuc+EBwgsNSJ4rwctOD/MGXSB/YbsZGwIGz9qYWAyIrqSFZc+wuhlY1P
	 2QA1hd79xGDvk6V53XCtJQvuCMcrSlnXrquF1dp9+S8PsOoh9EamRHjnujnrzEe0dWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=KF2BtsXd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BF606A330
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 16:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A7BF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=KF2BtsXd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pn8l16lxPP3xhJbSjlxvrzICCqYzWXsq0JoJr6VZtJc236wXPc2p2xQr4frTS58pOzQUUOFZhZbgU1qXyzmAFM4wXHvKj6xTFuwkDqxTNr6thvKUsfpJ/f0JffdctTuAR0yYaepn/EOQlnjZf5KNRVRT0q59R+AEh6HrpNP++ZJxs4Qn+ZJ11unyblrGT0tRlP0ahLoCYy6Ih3TUq42CqM3sm2C8BhScuqgwmRIPyFRALdLl0kcxXR5Q2lhl63cSIWXSEk8XoeF/Ys8zqPlDGjYj6G87LoSggIRkLwfTj5zaTU4NM3PUf9XyacKOGHQWz0deLbO/+6q54FKFLcQmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B45j0Qz+VQQCVdRHCBqmkgMovuR4tIPWsDoCVE74OU=;
 b=aaRtT+cwiRnVjRMrE1qTMKvg/ua2N4B7u06d4Sxa2+xH2+hoX8iEpVbklFGFsu8vuvemfucV/Ha+YjqGxb1/sPFZreHnmdVd2I+77R+gIN8N95vwO6r4VA2Pi7SefFpniyhstSLtdrAeZ9UAjnfudu/CruT0Q39Qeu30aMA/+oqD+MYjqO8M4xIjXAXG8Z/xA9OrS04EMllDmL5DTavhBJecLoLTW6J8hl4Blx4B0NxSsfjScYAnBr+teMl0mArSXLELe1I3It0G/BMD5a5nOmh73BTcCrYH/yZxSomDiuK5lTDihquXlInSTaida3Qede7udb6EaVPZtB9p/4wAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B45j0Qz+VQQCVdRHCBqmkgMovuR4tIPWsDoCVE74OU=;
 b=KF2BtsXdThwPd79O7O42Gx3NMTIQIwKXtJ6myriz4ZpgPpWYGy+P1tpYdvUVGXO5ePVme1dOudsP62vufjrle7dH7W4P3/XN9E8iYP3+BVykR6GRimTLYpJiAIzqe3YQeb7P7Z/+XN1CXh7z4HILnwZnXbpe9UxuSvbcUvr5r6LXxqtENl1QNTrGYQ5U/H28UN5oqHPkRj6vHbEOsaUs2F6/ACzYnn9Jyuh1DSHNvOt4hOAzsUtHlDSfk2iZf3nzGw4Mzfxons1bWj3k/6Ri6JW4NaEmqYdrK0OTMVFGEtA949rif7RtadtfgvWXVKQIWrgLCDUc9UHe3X/o/SED9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Sat, 21 Nov
 2026 16:59:19 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sat, 21 Nov 2026
 16:59:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v2 4/4] riscv: dovetail: read the CFI trap value from the saved registers
Date: Sat, 21 Nov 2026 17:59:33 +0100
Message-ID: <20261121165933.57310-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121165933.57310-1-tobias.schaffner@siemens.com>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: d27c08b9-5702-4c97-fa5c-08df47f0c8c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|11063799006|56012099006|261022105027099003|10067099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SdxO5jWj2AcN7TNB2SB85gthxXKTeej2/NJHunXf1MVrF7XhIcvyVK9o1BrR4BycoB3lDslaXICpUBf4354cHLHQUm5NuA2eUmTpQQdS/ZTblrl+6LtY6CJHuKrvc1XbFXGIQMNk3f38i8hYwyT+7FU6bmLx8Ypm36+WphUXfCzCI6oNgzm+qLVRZwTWhgJtPXWWn3q2IBfSqwpzmSjDGrNmDD8e43PhJkPCIvndD6IB4+3O07ab9rpiZuSqbnZC4KUyBrCJiojyNnFyLK1Dr4XlsRQgx9bURGOghuxe105WjZ3C9mzTgG4b8d9dQmxeVC2JGpHsmJ6UynAgo1I7rET4nGBRlmtp0tRbj3c7j9X9ZTp+1grzC37uhbAP3B2tpseKTRbDiR87CIGIOyOBjDurvxFJNdSWTSbfiAgUjrKXX3aHBAiRYfdqiA3EDdBqE8JgkeBLcNpoWDZ1XtI2GVgzCcJEz104P5VII2Mefuus6Abo172ng5wjAruq/1DqH+6aCyAojzV3XfZ7Bjct/2L2n4xX1X2LPsxw4q9FqLPCkVKCUHpkvaXD0HdXbqUB190ThD3B4PJrYgxg+GmbmBaaUfU3bUDKDj01bMejRb3bE/DrmpRY6Djw1amBwSZrLL4V/0WFydAUXZNbagJXeeoIQ/F0yaVesSGAqxL5f1k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(11063799006)(56012099006)(261022105027099003)(10067099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mjAhrlDYxW2ZnUSIBMcqBJDy9jOqddsw2pualVmjUyVxQlY/pTOFWyzgaDLf?=
 =?us-ascii?Q?KNygWvDz4PdTAkviJqkoMsi2FQctspdvpzSUZfG1L6QsReqzyI1Or0YbSNhn?=
 =?us-ascii?Q?DijDTuF9ehYdstdLHWHIHr5/RR7mtHxQfyeTqfotHCKKSg/rgvM8UUmRh0Rf?=
 =?us-ascii?Q?3gx5TvXWpB1dhKxDN169aQlH9ZTpxeLKTfOGJLiS7ae1EvTafjK2/hUuSyVY?=
 =?us-ascii?Q?0dcBUpKMw3vqBrAKZk0qrBn0MRqjt73nr7qUQybciOF3HYQQG45cY48y8FoD?=
 =?us-ascii?Q?S0CmkraISWdp7V2D9y15x/Y1WeUPUAG7K9U5NMh39VRX5dF8YiNmhxFWfszu?=
 =?us-ascii?Q?k1fMfbJgr9ylsFQ020L2vM+rYVu8N9Ueuxn4cX6PN8n5sIkI3kpJLFNkPsOV?=
 =?us-ascii?Q?WfZl8+8Rfqe7gwBO7kojEOGduCsDLqQnpP7Czd1furGXbBeYUS6Z3vtb9T4F?=
 =?us-ascii?Q?AVezYjUpVVyC0ZeO6WwwOlZad74ZmvxnX9LvXtb0b3rVMn5S/IbA1xdxueDs?=
 =?us-ascii?Q?rljXxjJzaUqlv0l09pIUCSPa+d64AFffY1vWW/IuHogAH558SmOLmqlJ5JR/?=
 =?us-ascii?Q?UCGuuz9ezjRxivJG9J7X+T5CCvBffwDbfHcZoGYhPNSIyzj1TwOgT1UUfcy2?=
 =?us-ascii?Q?OPgoP0XnDgJ7GG5drZHTXcs4uHDk7tXJWCotKdqqnnK4Gue+3A9rA8wcbfWm?=
 =?us-ascii?Q?rNCoske4pcr0BPJm5wfh5bJtLkMCXOGmXlMaXlnLJ4V5CWtElJy+ZwuLyLJ5?=
 =?us-ascii?Q?j/SV42Lgt3E0ttUmnSfYqy4TipLvvU80VqAi65T5Hx8dhASIQZ3cvBsUT4zq?=
 =?us-ascii?Q?x60h2tfhDlflBFbuebCaUIkrOkegiy7Q5UNxumDE7IJMVDp/6LnrJkhWTrIP?=
 =?us-ascii?Q?TUrcb2v6IL8TE+1kyfjnSJxuMj1EoLrhLpOCSJRaKE0c+w9uaM9PDQA7/mGE?=
 =?us-ascii?Q?OHehzfPvCxv6RoHP5OMc0Ig+OYqrpv6yjitrbnSaozMrpz1fub2/y8kVVU9g?=
 =?us-ascii?Q?Rvl0qMCYIMZmDBqv3OXdPBCTTLdjUKGyCwj+zx2NoqAZP1ZqFcY23JaV2Eq1?=
 =?us-ascii?Q?TQiDz/0qyc6KlzRjhFWjFubCJqVc94IK8bDK/ldraoJHLyphV0bC27cYMpHk?=
 =?us-ascii?Q?d3kNKWnv6yMLPUgKTBMMK0tuN+lxNy3VdM790TCrR1FQiXJ5xrakBOMFqEHK?=
 =?us-ascii?Q?T8lZpxpW2bN5yc3KjK025DzKUPCS1G5hklqcNynU4gobnFaIfYA5h25FfMti?=
 =?us-ascii?Q?+MI3WAmxdlSpz7nqwgp3CeX52axkcOfEuI0EL2mZ+4bz21j4BjyhTjLy+7aI?=
 =?us-ascii?Q?sSIq9QTA6TQHs8ONvAcYeQ7C/HD1dNt5kljdALGtEOrKkaSDlAIygLVmeeZe?=
 =?us-ascii?Q?NAMj7yo9CmFpaeDLM6wz2Dakfhd5pziDUspIEac39YjWyzPlAVmcsFMDV2Qz?=
 =?us-ascii?Q?yPtaHtjVK6ApOjeDdFooB7HQ0QElDBZqry1ywgTjDvlS+kYoauRvwAbIee2Y?=
 =?us-ascii?Q?5mbuWv86/BAK7tZbnWQe/Gcb/Sv9cNK+UlnkqBg49r7RmbMVhFLOtJuiA2He?=
 =?us-ascii?Q?BoFyKhuQkPjzRlpGYFgCUVF/7IdgXbol+//vLcmA+6a785Dd7/w8yONOS1+t?=
 =?us-ascii?Q?tvFqWLnUcnldGWmrhtrpZYRbo4KXa+K39sFPYGnRyobIl5oBbNV5T8l0TQwE?=
 =?us-ascii?Q?j29UpYgN151oy4x/kKiki0Dzj+SbyS7ulAXipT4tkvJGDuFFmzvDh32wL1Gv?=
 =?us-ascii?Q?lGKEUEnYpnJaNpdDVH7UCYp7lGtni2XUu73/nyvjG9pU7SmI8lLoY+E1L/dt?=
X-MS-Exchange-AntiSpam-MessageData-1: qaRxZd46SwkeoeNtMwlPkwfgTWYzOQGc2vk=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27c08b9-5702-4c97-fa5c-08df47f0c8c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:59:19.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bE3VpnwPhJ61g7YQ1f/PaGIDUFDUk2+dT2cvX2dh/MmDF2MDeUA2YsEbTIonM41pdc0INvbMdWwVEzqTYiOP2rL1BFpRKZmNQsuGWfDnoS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

handle_user_cfi_violation() reads CSR_TVAL after mark_trap_entry()
enabled hard irqs for the user mode trap. An interrupt taken in between
overwrites stval, so a CFI violation may be taken for an unknown
exception, or the other way around.

Use the trap value saved on exception entry.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 47799f18fa7d..6de8a7ee04d9 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -433,7 +433,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 /* handle cfi violations */
 bool handle_user_cfi_violation(struct pt_regs *regs)
 {
-	unsigned long tval = csr_read(CSR_TVAL);
+	unsigned long tval = regs->badaddr;
 	bool is_fcfi = (tval == CFI_TVAL_FCFI_CODE && cpu_supports_indirect_br_lp_instr());
 	bool is_bcfi = (tval == CFI_TVAL_BCFI_CODE && cpu_supports_shadow_stack());
 
-- 
2.53.0

