Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794919160;
	b=UC0lMUJgpPUYD1dM97mey/lwdKMM2C8Re+hDWD3Ku7lFqobU8WTtXL8JF2mKv7AAd4p6
	 cZ8yq9ksLU/hUg3K1r9Pd9RPbTPBkbXk8rUn7fjucmhkN1xXJ/ErjKlYhgnMnYKwtk7qD
	 jAK+d1ZIGv92scqZuUVhUyyIkU8GHcCS9Td8w1dENvrIMoBKVQcjh8f0ijleekvrs9+W1
	 Ai1fI3GYna9kX6dCtcZktSbMAzt8N/KrgewYFNF8T8CnoYEPSD4BBUVgoaXKQD0gAJ7Tj
	 /45UFM+KR7MVfFkO6YSUKcmEu5MBXX0EFhDBiwHpTBAgAnGr68g/6QhQc9QLmPu4rhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919160;
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
	bh=Bb2BHqurMTa3X6k6lN2XwoB2FI8TePtry1jkCOB/2qc=;
	b=0HokiLn5i7bytDFTmVNRREX+OPie/MCNimMf04sub4RsntZk5i6cfrqFAq8Ffztr/1J0
	 Uxw6ApeWrbKQcpdNdfMARrl971ikk/UwvyLwbmAsnDlY4yNVEmArINSefQrSw6U3RBUzg
	 zu0zgeSx8Z+Vt6Jut114C6QhSm0uTL+dAMumSIIfNDJT+5KrDs4cGMA4PNRHrl8zZ5hIs
	 V1SOll5lQlX1wts3bVHiBwippnEkM/8C/9lqAhyiPY3QEfhxPevOnJJLwXtikOLFxiyrq
	 IQzxOrmFLoTT0grPYgqFfxyGkhVLZIG5fzoOPdQ81gyTMEsr9j3WEgegrnOlqmlwa4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=YIkDGWg5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD0606A32A
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 12:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CD0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=YIkDGWg5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW7tToVIFkP89i/lcltX4pe4OYzUtBPauXMbra5ZZkvwyBVOL2H9f/6/d2UJVcvvHA2376i53OzBpWTd6G3QMwHf0AMnup6kPux7CYeKfUXwPNAsk3qq1Of08RP1uH8FbGwTNF79jhRm/CTk4GhrjKxoxEMHbVLKk7b0zVEih7eB9Exgh0XIpVBrIE5P/ahRIGL0tX6AS+iAcTspveCMPvB4Cs1dACOk0GTSR0P04x3cw02uJSc53fLzd3AjV5Pmgzx+eGpkyo/0hkcA9iUbQ4k/0d9H5BQiEUJpWI3A2A0GW+WJLK0P4R+FgVhV2nACwnBPR5RTFO5jZ1McJt+PUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb2BHqurMTa3X6k6lN2XwoB2FI8TePtry1jkCOB/2qc=;
 b=luBFearJ1hdbD8lX7yRBTwF0RTo2mCn07OMXTTbrlTYQwW7vm/7prfE9YsH5pCfOwJUy20UrAi9tPifGiYNCCE3XaAqmDimyCwcbxhD0Vs671kDOgr8jzlhhdKaiDVvtTLPgxGprArgxKHQE/BteTU0zGmiLdImFZwzruH1fkuoMCzma7EQVnV/6mkKZz6d6+qTm37bi/JDZ0XZOJ7sOP6cM4OQEXBPxAszSNhpTsXi9+Cn3hOCH9vHFXVvO44ysdLw+UQPCJSNoQgIj+njxn0tEQSUR96+FwwmeivUoT/mRQZUZmoGi9gDoZ5dNhD8cAfe7epmorBmGHw0pVqxiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb2BHqurMTa3X6k6lN2XwoB2FI8TePtry1jkCOB/2qc=;
 b=YIkDGWg5o04cqcwtMe0wOoYgsuTo7vIlWX/J74HpRoW/bMfta89+j2/UMJMoMwsuopQFksrgkX/I7wMjEqPpOSNK23R8ok+M9gDiLxSt8FVMfMPHvtk/+g5nQiZA6yghKivyDhpP22fJ+TLUBULX4+Y1YBg24A938ZJ9pGXnm/5FTyI3wJcX59SfntO0pVLuwNDKTLeCUpPMyVDgvu++Wpy0cvvft8chWn9jEEmeGBmLWjWxd9em22mzbD5ylgAB+spevUuiZYDI8rHQOHkODaLqSE0Pq35bTMcJmZWhu1bzAj4wEc/85pdcEwe4e5kq7hrvek1DruBMDSFQO/icsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:77c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 12:39:15 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 12:39:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 5/5] riscv: dovetail: read the CFI trap value from the saved registers
Date: Tue, 17 Nov 2026 13:39:25 +0100
Message-ID: <20261117123925.597027-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117123925.597027-1-tobias.schaffner@siemens.com>
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMCPR10MB992193:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d043ab-f155-49f4-4193-08df44a7ca27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261022105027099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CUqi5yHiDGQgcsXDoi8AITWp6vkKIkDwoOI7qIAbcXz6lmz9+yrdY7puGa1p19wnjCm39maP/uCW1q+VaGOO3aDXICFl9qIXHef0pSO/QXdzjwTDltIYW6mXe7Da/fsTyVDC95GMN0P6vnMUYZON23VgA36uJXXVZVR6A8dS7LKIb8XYEPRrnKVznEIAeYlUh5gG4Bq+wX/N3QC8AH+dw/9knR3avuITcbkRGZ70E8rXq+t/k2XzmvsjPt3vACI/nS16hUIEAyRKVWUAg91TfgC9KFZKlYTWbXjn2K6dHpiNeHLU0a2tkhL7sWqxpEqdf9mpGflfMd3ZvYnCfYLVTASLzwEazYsarquQ6dblcHDOPgsBAsT5hfx4jRxht6GGDiMivs8vtIF6J2ZbJCULZRly/SQivSiEBWH93BRy2KKaJz3DR8ZZeKM3Dh2Fi92Xe8p+rLvKanU4cteMXf6P6YijzmzL/s3k6VUouZFfuOA9Wmtb+XCh1gf+HkL4QgRsrefaM4zIUjuMTM9tBP6b+ZHVC3ndw4KJXhkhXPDZmSCHVJH31XYzaWlyRM0jEirjl9SoweyhCdJX/6fKh2GMBgiYUjm+FrhQNS14BRBuXs3ilY9gHDsGXvVEgSoN+WDJbS7a6GMl+lq8cECNd5R4S8sMHCP0oNvDgsolY9JUV8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261022105027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a/Ugd3owv2ADU80/pvGw7tIMrwJ72fKr1ukOW/qnBo2ePTT/hNJ4Qph9r/S2?=
 =?us-ascii?Q?rB/wtvgdRVQ6XnO+zrgYWt0iEkLZGb9WyPaNOvH7q4qfB9xRevO72+QlThj2?=
 =?us-ascii?Q?zIiQWAc5nbIR6SvrhuyOrTJ1spxCxMhDn9HEZkABBdKVpjYwDK29FZYMj3nD?=
 =?us-ascii?Q?5kyAok9/AfVxK1ZzyhZdWs4mQ9CoEoiwbX/qfbbk+A4MjiSMslHeh43TKdI2?=
 =?us-ascii?Q?7H5IA0E39noHWWd6cMWKD+gXU4kdNuFflB3EOHoAAjkAKQhBedLYajF/4j/C?=
 =?us-ascii?Q?BNYFCa2WEKDYxuAd1QrEPAECPRGEAamUp194xBAxiLKs2S4RUZfNm1gE7cUu?=
 =?us-ascii?Q?LYfHgiAFseGD+e/F5ILwI7IsdAzOzyLGApHCwbKRxLfZSjAJqWKlB46TH0Mm?=
 =?us-ascii?Q?FFXmpNRatu4lfCOnWBR+KSLC4/PaloYtXD/61hoYyrwe1YEwiEj/d3+ZPudh?=
 =?us-ascii?Q?NbxAPPwDmmNq59IVr6eJmBBbn2worX4Q27PCSA52ScylpxDZK9eU+Ik2VRFU?=
 =?us-ascii?Q?0nBeF+4pgzUgogRgadi+TUnHgKLReV6i4f1/q0MAAInlKiyffeElVAtfv/wj?=
 =?us-ascii?Q?IbA0ZtDKfej+vW/fYa4I1vebFox3Rl+XG18ocvyxDNLvguyj7y0C/BNjYwhH?=
 =?us-ascii?Q?qnxNTcgulpyLnAbcwKJefGxQ7y2ZJTF6NN+FdsO6v5XcYaujN3hFzeTD/MmZ?=
 =?us-ascii?Q?QQeYrWtVXHUF2iWK2wETUVJRCy5ZePA3xzhVDb7HAC97m+i0CrwbYgyuwV6p?=
 =?us-ascii?Q?U2l9hu5PNREAxUOCtqDSZYKcS/2WLwR7QxcZSFgOE7mmJmGBg2EV5UEtGruQ?=
 =?us-ascii?Q?jDc3enA9H+onYW5HsYj4ole4jgCv+uCWs/KNqYJx9UFJDWaKgZDIDV0AnrVO?=
 =?us-ascii?Q?ls0bGYwDvWhMe/4yTTiPk1aMGNImqYgtITCh5UA4rGyFEZNPUseskBdCA2BY?=
 =?us-ascii?Q?zwta7daIRbQT1MWZNM6WhwxwBTD9bhWTmQ/AqE+2i0FQCc5xTvUrIuWLlOO2?=
 =?us-ascii?Q?ESRqbFsUnCNyEXZIxohgFoLzIOC/9r6wD+IsS6dZ1ATwrQrn7rDsMz39EoXs?=
 =?us-ascii?Q?rZr0A6cf3GtW/EWvxNRy/dJ9GCtbHTL+zlTcHPZdDbTsGVPa3LGseTUmAAp6?=
 =?us-ascii?Q?nuVJMwb9SImB3pdl6WK3MCi5l0fUa8gNhWlBY/3evCPUjjEBSX1r4SlSQZlV?=
 =?us-ascii?Q?lwGKKPHlYjioG/4+kppX653JwlBqy1Pj2jBRC1wIGToZ9JvGLA6hhoxJulM7?=
 =?us-ascii?Q?nmYZwjaUurHIFj9PBwvJFlbfCNIoE6R0efLuGz37jB3yMj1eGRzmiEqcbwpb?=
 =?us-ascii?Q?bwQjNrVK96ZNpE9m1fS4s/ye0GoCoRPL4nQ5QW2cpfx+LM0mqPQI5QLMvsQb?=
 =?us-ascii?Q?LiAXEYvT29z4Vffb/oPrJmPhd54h0up2uiSr9PIm8LSaFhlxDrWpNuwCOTNe?=
 =?us-ascii?Q?PaQLVskh/PhBAHqnzhIpwQGsurMm/+rrix8E96FIFyjXvqmo4ViDdQVZOiQJ?=
 =?us-ascii?Q?UaS3aTXWifjmN2drir9VFCO91RdoLkQ8zPU5QipE2GZxyN6xmPat8f9aCwU8?=
 =?us-ascii?Q?tgyNrvc4JJhGWxTfq84bMW56G41W1xuTl0shvqc8PCvlGpv4/+z1qtOHLMnm?=
 =?us-ascii?Q?raxKPWRaMgxFJbp4nvyDhjFQSeu+LoiF3KVfXXLraHFIyJFE0xj1B6pxKQFe?=
 =?us-ascii?Q?yJuwhKoxhraHhH3z6B5ZfdAWo/oiJdXztgftqpNxK/VpnyUf8RfU0Pp3/Vf4?=
 =?us-ascii?Q?nOfhfNOkEAyweP8H/SLvR0LeYRuVHYUJaOajsY6oeYhsV0SAj/d1ZiFcDwCI?=
X-MS-Exchange-AntiSpam-MessageData-1: bdUuBNHO6J9o01tSiTg9OMlBIevekfL8AwY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d043ab-f155-49f4-4193-08df44a7ca27
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:39:15.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw6bBbEfZAgKUakbLegBn2LynfNE7/10QQAT1/WAh4w3z1PoW0mFgpQbQGdDTODZxQJRBdqn1yDs5NwI8zUW8wMLiPetj1xct9doid/XoNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992193

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
index 9f8dc6bd7b85..25ce3cc58cc8 100644
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

