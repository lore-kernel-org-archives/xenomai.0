Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2090.outbound.protection.outlook.com [40.107.247.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6E269801
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115685; cv=fail; b=kwrNwd9EvdycYCuI8fM8mckPHElQTDHxOkhwUJME/3Bm6hvPcM96einBVE4CYCEdTseMD5lk719GMUbChuzQRLvjG2cW6aK79sNt/wELCAjlOX9mCjpb0Lwjx/kdIk49yogIM12Tejxm5tezRx2tpn6xDuCSXU9Ct1G8opuvULI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115685; c=relaxed/simple;
	bh=cDiQ/DMjFkcZPSFrtXdWq0jbo2NQLkRdZvw0kpE2Sik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMSDz8p5mYYFaMW/agBDhRqAwJXZRyh7ifoILAvoMeIlrfy5w6OJavFO7HWu43VWihSCEaHWKkZDe6CoNZAFG9eEOB8/BcIaDczd9W5XHCGIsIK0VZI8a9AD9rXr6UDwbRMxFdjIyvEf3raRkfOEWvuXjhshqk0Am/9w15w/1to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=OjeGDfTP; arc=fail smtp.client-ip=40.107.247.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="OjeGDfTP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyHehC7BXbp7KYzWsHzbvYVV78kgz4AnA0SeIQb29B+wIDbteHR5oBq4LWcYcmF5ksapoUksiY5JVoAwKTrk+Nl3Afdv3J6SFT+/90RBhOplz3wITSlvdv4iaI8lcRAypzjbkELaMv07PGVeABuivKgfx+Rx6iIHsl2R4UaF1VnHQLp6FtQEm7+U4FkFIKIQQToydzsGkQpr1MbHMrwlmzIfr9ewSdQieTSNM8woQ7ivl2Xw0Uu8EAPQ9uT/1Li7sYPJKWivOIGgi2xQZotiVQdgLxytt5UNCOn+0+fxLrMxeUUp8LzDmmIWIZLfUlafcE6fZZC/ky1o/vSP6ju/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfBH5owDdLAQqEcSgVbLRY3/l4DNIrHWZHwQTdtI+uA=;
 b=uJL77WPd7VwHjx94QGbmoRXey+2wezjPLTksVmNirKZ2kJWMtXCM8lG5BRUdUBkEv599AQo7inaGLMCvPb9OppKUXnhNdM5eD1no5iAFosv1owzma3chgCc2YBJJwuceeaEwqPka/RqpGLKONRcJBoDDfh1IHhUw5vrsqjzDfBONstW59jTdg9RJQBLKv/GNOOsKJwGnLTHfA4j0taDA4cQPpyDhRj5E3pNTbnr2YobHDAt44QnJrWNxIzFLpnXgxYVo6uelfmqfmZSDK/MMm+eoKkvhgoz6kHSq1RUrxMGSt2+tKqWYv97Wryv7PnRzsFiyn6lCQXQHuCup+Xnd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfBH5owDdLAQqEcSgVbLRY3/l4DNIrHWZHwQTdtI+uA=;
 b=OjeGDfTPRig67+PxXUuoXs5GGPncmXm6S6p46PLQIOgagQf6Dz9e2aITa6JA2BRSf3nFZz0X/Ps2ynz3Edc/EvCPOP5A4EaxKxcRQLzZ63baYkqF+L4GcyaU/EeGvbyFmLMVkz6D72f2r05aezSnrLMnpMKQ9U+uAQ7FT3Hz3qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by DU0PR08MB9026.eurprd08.prod.outlook.com (2603:10a6:10:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Tue, 8 Apr
 2025 12:34:37 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:34:37 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Richard Weinberger <richard@nod.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH 3/5] arm64: dovetail: Allow early return from traps
Date: Tue,  8 Apr 2025 14:34:21 +0200
Message-ID: <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|DU0PR08MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: b34d1d62-eaa6-43d4-e1eb-08dd7699b97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8idkJ0SQVJaSNQRM2vyP66H1vvHQNwL4+0/wHWRF0kBq/zI8gWNFRTAdx4y/?=
 =?us-ascii?Q?ft2dl4Q+4Faer4JI85RtPo+1COTHNR6A73/NevyePH2dk5g3rU48TJhohKh8?=
 =?us-ascii?Q?zSyZ96c7c3zTxqIU/UgyMKg0pcweqVGtpoqiUBP4RqElx0PaXXTe7PwDncS/?=
 =?us-ascii?Q?PmthUT4IVPb7j+4+H+2r+CmRC1+OMbAG+hsgbAmOKOz5kqdaW+6h6z0w2cCT?=
 =?us-ascii?Q?p4jZ66AfYHiLinsBViwdQlHfJWrUCYWHurd2BN5wk01kFPSXQClmyfT/I4Vt?=
 =?us-ascii?Q?ZA0pxH4WDpuk9uUf5SQNPk9f4XldMG80FDW5N4QCdD3sNI7Ef7IX0yexjosX?=
 =?us-ascii?Q?CX0SAY4wiH+FsUNy+NOi1y5dzhucALrEb9xAblRa3vIXhhoC+bflH5IRw8jI?=
 =?us-ascii?Q?BoIEz8E2L0yBL4jEwKUSFG461Hl28sz9/bwvydw9QQgrW9LRty0nkofC5iAq?=
 =?us-ascii?Q?D8r0rf+HuAnb3JXgSF3ucTcugA+gRknvEw6xqFpwl48v1Ul/zv9nQfIU9I61?=
 =?us-ascii?Q?0KcC9egPBD7DTfTb1hWsy70zvGuqdXRCM4/mh4uz4kHp2XP81aSVqeMLO7D+?=
 =?us-ascii?Q?ZN2v93VCt6W7fKNV5G2jsXsPgTtLxCvse/z8yYSLkyKw0OM+tVZ5DtHtXyFB?=
 =?us-ascii?Q?riSdyzy0mErA5RuHb5J2Mq7oBm8ZsOGqqqiLAwf0/Q8suUcsGZM7rm/boEmZ?=
 =?us-ascii?Q?G7pih7vFKKQyfDK/HavkTT3A8cm/wWaPQDZ0+HNaLZztSHJNJI/mBH+mxZ/h?=
 =?us-ascii?Q?FoxuUJiIkcfQW3iFultiX6IwVokoNkd6Byp6nmFzW6wBkQOL01GdzlJFUV1B?=
 =?us-ascii?Q?6MLIax0sFcmtju6TY0hW426SbnWdxn4PCqDIeSL2ySCF67rnMjJine/SWyoX?=
 =?us-ascii?Q?NPwtZ1kc4blfOEuWIDKH8a8gYCLcZ8SrsxcMnGfeNyJ1Fw3ik+rFZnKr1t4P?=
 =?us-ascii?Q?YC5exgXMGiShKrxneAQaeIsY+e3/Ij4A/rqHdIobPTyd955LeGJTc0D+hnu5?=
 =?us-ascii?Q?TVr8RzcCGuPyEY9ltz4/AWAhjG6nS31TQDu/3DTLw5iNXceFMU7+iZY+NT/S?=
 =?us-ascii?Q?42GFNZy4TmPQuDqm34U74lNNi1VNzPBQLmp3LmyTcjWseJiFUYn6dx/k4dp1?=
 =?us-ascii?Q?hcpDOJTH/v0LL7hvfkbGDxOxpi1N5aj9mkr6XxjL6pbHQKIYdjsvsvfxyfEH?=
 =?us-ascii?Q?wNVIarRt9mmHgXUft1oz/ciotdManIvkcbdAxKVRZFzaeeCIjRirfhuyFJkn?=
 =?us-ascii?Q?LVN6nM0HhUqbEPvDcP7kl/t/BGKy7UKkOUESkk1jgRzkdy0Mwu3guZDVwZLJ?=
 =?us-ascii?Q?1OqvkdC+/oqdFYaJxPvTUhpRk6ZTFHX+9Xu5PWF+9snGrFS25c/qLtDLCe7a?=
 =?us-ascii?Q?kujcaerlXhB2zVB7Y0Bw/Ui10oMoDB0pkQtVJq1gevawAAMtFbBP9unzNcJc?=
 =?us-ascii?Q?3ILdyWG7HTgcnb13J8h78R4b2wdSriw1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2/CtP63BciC+AIlceQyIdEW3TNoSHjPpSIlXM269IOLDuU3NQMABiT631l/P?=
 =?us-ascii?Q?kM0c/xKXbLjs8Wd/17KnBwKk4sStZyzAkk8rUoZav55tsX0A1A0UGwLLjeMx?=
 =?us-ascii?Q?mA282d4nJeqIbYVOFTTv56s7+lf8N4IKIwhc61czsGf7muAePQMytuYHwMXN?=
 =?us-ascii?Q?mWAcAtLOtoedNs0wGbp/xzRsHj5BWKZtCBMrxsZxyJ3pgizaWP7TvjcUI089?=
 =?us-ascii?Q?cMHxItdvYFH+qd3iPeqivtvJkz4tZqoz/cCUWvTLUsMWT5hRutm9jjqD1svh?=
 =?us-ascii?Q?JBWjD8eIU1gnp6fyq4UoT0sjT2JJFYcFCtaZuTgthT10Nfj8BjkSd2KJzLiC?=
 =?us-ascii?Q?MJtXJF/au0ycvRu8Nb0YTsPz0X5iet1FufgzYg0fwvj9M8538DPwZstpKTvX?=
 =?us-ascii?Q?Xb62sWjcASQdTHy9r4/RkLzKg8ynNh/XEi/oaGhU3js7mOR2lnUxovjRBdrL?=
 =?us-ascii?Q?so4wKIrsStOVYI67rE3eNVPlroFbS3QTpjHkWD1e7Q36JEKjanfz2DBAaVyE?=
 =?us-ascii?Q?rlLbN/UhmMgCwQ/0sRxXIiduA7PSmWXV4IHwNtlbX2Jhf9DlsTyA8P0omg7b?=
 =?us-ascii?Q?OpoRXc3wwPxmvUwBebqcRCdKq1+fSAeOii9P3HoIlkbZMH6Z1R3VWP5Fknjw?=
 =?us-ascii?Q?8oPMeKepTRG55npZHA+hjTQuzbfmSAGf/kt6NMW6OfyReV+T1+ypG84S5OkT?=
 =?us-ascii?Q?R0wlYzofgNL12GHFvwjNn9CnvthDuN+BuDkoUTnKKU3UVeqc9wEqGGdyA253?=
 =?us-ascii?Q?K1z5t5sk3u4GX9N6eDpQl2N9nzRFQVr7g7Hxtnyar1fbpwG3gfrvWwK+7TNA?=
 =?us-ascii?Q?cgeHikduE5q60FPfACtRGI3E1y+mZcUzUy5xuAlwRlJCeJQwLlR6gBnFxiNJ?=
 =?us-ascii?Q?ywOxVzLRx0qjujnarRt+nAicTzg1/kPRiA0dul5b2ic7W7eHFhFmogfgEibo?=
 =?us-ascii?Q?YyJ1EMYurK9syvROyAuaOnxCvXhqNlvsRQ2iGYcvboOa8tLvycC9G6/vSrbA?=
 =?us-ascii?Q?RrP8RSUCg344kY1aXbLmBJQnb8GyU8MtYnw+aQXT5xdQn6wVnoAMa2zLtIEI?=
 =?us-ascii?Q?bT5KRpa1O9KEg81EcDn30BLSrm/cI0a7a2JfqtiXODNio9aeqzBlo3E+BocM?=
 =?us-ascii?Q?XxE7jGxfqWdMvpR95g41uGHle1BR1mdgn5h9ARdImDG9UwQMUt/RW/sTm6LA?=
 =?us-ascii?Q?E+0T6V05nGZe/Ihjmq081N0uTnJ4SVdupV1cA+N/515JW3Ov6bwlX8/VqN1Q?=
 =?us-ascii?Q?bx0ffxou1tNeN/ZhsOchTU37P6bsVsjSDyvr9n/CZBGzlhAMJtqxLxbENWqY?=
 =?us-ascii?Q?qNjBKY+BmXYpFlQyG8lduFZTQ1auBRKC4PdyjofVSDLK9RCGmfqROKcpFhAL?=
 =?us-ascii?Q?CrRp1UMy90yUlYHWK2FQtu1NrBle3MQqfDwFZE/qgcwWwogais6Kgl72Ts+U?=
 =?us-ascii?Q?yt4vu8wXmPxszQk0nDDRNtK75SQWeRxBd1f6TdRKVf4Z4q5iwhfjZdbHJjha?=
 =?us-ascii?Q?8nKwn0hF3wybNV5O5EUiWv1airBCN+8/9950J2GQZUGJVun9MmzU8ujXbitM?=
 =?us-ascii?Q?I9pZ8H1nwg76y0S3CuwGk9oBCJBsNhUm6pu+gySnZ+8BbcDoT2dMe/Bpqwit?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: b34d1d62-eaa6-43d4-e1eb-08dd7699b97b
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:34:37.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa30xRvw6Ym9+NEglDoWtwy1KaxZ0z7oHjdOC42wH3iNRoo/sd9RU84XIQ0uUieybKQe8zBb6sFNi6vKWtWXH3GqXQ1fpHYqOF+3CeehCFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9026

From: Richard Weinberger <richard@nod.at>

Like on the x86 side, allow early return such that
handling the exception on the Linux can get avoided.

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Co-developed-by: Lorenz Kofler <lorenz@sigma-star.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm64/kernel/traps.c | 18 ++++++++++--------
 arch/arm64/mm/fault.c     | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0f3dcd34be87..fb135f886486 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -462,14 +462,12 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	u32 insn;
 
-	mark_trap_entry(ARM64_TRAP_UNDI, regs);
-
 	/*
 	 * If the companion core did not switched us to in-band
 	 * context, we may assume that it has handled the trap.
 	 */
-	if (running_oob())
-		goto out_exit;
+	if (!mark_cond_trap_entry(ARM64_TRAP_UNDI, regs))
+		return;
 
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
@@ -507,7 +505,8 @@ void do_el1_undef(struct pt_regs *regs, unsigned long esr)
 
 void do_el0_bti(struct pt_regs *regs)
 {
-	mark_trap_entry(ARM64_TRAP_BTI, regs);
+	if (!mark_cond_trap_entry(ARM64_TRAP_BTI, regs))
+		return;
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 	mark_trap_exit(ARM64_TRAP_BTI, regs);
 }
@@ -613,7 +612,8 @@ static void user_cache_maint_handler(unsigned long esr, struct pt_regs *regs)
 	}
 
 	if (ret) {
-		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
+		if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
+			return;
 		arm64_notify_segfault(tagged_address);
 		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
 	} else {
@@ -672,7 +672,8 @@ static void mrs_handler(unsigned long esr, struct pt_regs *regs)
 	sysreg = esr_sys64_to_sysreg(esr);
 
 	if (do_emulate_mrs(regs, sysreg, rt) != 0) {
-		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
+		if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
+			return;
 		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
 	}
@@ -916,7 +917,8 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr)
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	mark_trap_entry(ARM64_TRAP_ACCESS, regs);
+	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
+		return;
 	current->thread.fault_address = 0;
 	current->thread.fault_code = esr;
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 00159c38911e..514382742118 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -486,7 +486,8 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 	if (user_mode(regs)) {
 		const struct fault_info *inf = esr_to_fault_info(esr);
 
-		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
+		if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
+			return;
 		set_thread_esr(addr, esr);
 		arm64_force_sig_fault(inf->sig, inf->code, far, inf->name);
 		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
@@ -567,7 +568,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (kprobe_page_fault(regs, esr))
 		return 0;
 
-	mark_trap_entry(ARM64_TRAP_ACCESS, regs);
+	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
+		return 0;
 
 	/*
 	 * If we're in an interrupt or have no user context, we must not take
@@ -818,7 +820,8 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 	const struct fault_info *inf;
 	unsigned long siaddr;
 
-	mark_trap_entry(ARM64_TRAP_SEA, regs);
+	if (!mark_cond_trap_entry(ARM64_TRAP_SEA, regs))
+		return 0;
 
 	inf = esr_to_fault_info(esr);
 
@@ -935,7 +938,8 @@ void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs)
 	if (!inf->fn(far, esr, regs))
 		return;
 
-	mark_trap_entry(ARM64_TRAP_ACCESS, regs);
+	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
+		return;
 
 	if (!user_mode(regs))
 		die_kernel_fault(inf->name, addr, esr, regs);
@@ -953,7 +957,8 @@ NOKPROBE_SYMBOL(do_mem_abort);
 
 void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_regs *regs)
 {
-	mark_trap_entry(ARM64_TRAP_ALIGN, regs);
+	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
+		return;
 
 	arm64_notify_die("SP/PC alignment exception", regs, SIGBUS, BUS_ADRALN,
 			 addr, esr);
-- 
2.48.1

