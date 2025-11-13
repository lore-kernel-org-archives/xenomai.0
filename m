Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7134D3AF
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035830; cv=fail; b=MY3OgZKPCeBZqxVqOZa/gNAT90GjGy4RhCgy1dDu8cQaSXDoExpIceWz0b1XKjVArWNL6VPX7TiWuclscn72DI9+V5bdK05uBmrKMPK2Qprw+fjEyea4crvu4OZmPX73KcYu9hXetgwXfbUoLVKoQBg04bJD6ShJuUlHdq/fPgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035830; c=relaxed/simple;
	bh=lhIn0WUd+OHjKnZrTGO8WIiEOwWbmuv+3QsGCiEVt6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HcpT6A8Agk9aHm2Q+vHTIRWsjPpQFwzRosdmVMJepCuMEX2lxxmCPqTcnm4HpHrQuBQ+SK3SHqWlMGBOMPnZSbLXJ2oyi3y3KJ3l+be10708zonIdiQJzYYdjZ6Np0gNynRCRBi6MXyGrEAfLHjTCsBaxkAZHEPK3JXUf3kplnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dwysOGzy; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dwysOGzy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9vtzl0B0YNfURCmRltQ7iA5EMiP6hB5gEOVsOEI4Lw4DiWeQHDY8VIMjDD+qFiopibsoi7tFuk6Qsjg9VwZeVl8jNn/zDUuPCgJFh7bdLVHc0NHFCIEPGQ4OgvVq/sjazZrpZs7e+QrHm6+4X38bSq5HmgP5TtVVAI2lGJ6DmQ7MWfsfJAsM8T0YjluB+JgTd46uX30uE9VrBquchNKlZG/VGlavlgCSDskgmD26qygWHFoP5LBAoReE0i/LoQKhswc9A1UQ0cOlh+SOyXBlgyEgJ7uorskf50xAVGDC1JWhOaOLYkvgadyuSmgekInNVzEGT9J6Oc2DWyAppdFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffh2VDoFon8XhLlVbQiGLbWO2Ou2JtEv/8dcdVXOETQ=;
 b=Mz+FakmgwQJu8CvriDs9I5vawzNft5iPI0HJqYvSZj2F8aZqVqPnurSKSqQG/Nj3P8tbdPrPZijaR9NEY1/Z1ebyaOfZykG0NlOi1vzXdTN7NqULnybLSFgp/ouRD8+uAZy/VCh6K0YhEbKZCrkus7MEb7RS+s52uQ5TrQ1yyfcWtgFGcAReb/tKIaIZfx6qf7vNgxYz+DJtQx8V+0rYBy7tAeq0ADl2B/gI5BgYfTg5aJacfcOWPCgOfYVrFyzIutkErVZVONqamqQzSoQdWxqOsUSctrhImNM9UNILT7S/3hUgpu5I3o0N9dcBuB08/KkO1Bei9uSFly1JPSA/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffh2VDoFon8XhLlVbQiGLbWO2Ou2JtEv/8dcdVXOETQ=;
 b=dwysOGzysylb2aqzgcEgvoyAuJIMkhTMysdozHMtHnlLSJcNR3AVnpnfl3IHb/mJr5E+e43R9A65jjq7dAHuX98rcMm7cJvKdWo04fL+5c6xHwADYrDs1zPC5w//Dbawb+yxHdzY42acX8u6aeXEalavfj7nXj5b/v0NHpj1aZmDlzRdf0B6pZSrwWsWNATydMBZJmS6K62jEpuzxh69CyJmzsPMns18DlEzmayTR1MDtNw7LGci5ASPtaIqRDx5imAxDCnCk6bxJQIbcOOTcc6YFAWt6YZ983o67Fk7LV7x1juX743KeNid9DybmM9MLPPfzAvGXGygFANOb6osog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB9PR10MB8286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:10:26 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:25 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 6/8] riscv: add out-of-band aware trap handling
Date: Thu, 13 Nov 2025 13:10:01 +0100
Message-ID: <20251113121003.416012-7-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113121003.416012-1-tobias.schaffner@siemens.com>
References: <20251113121003.416012-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DB9PR10MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2710b1-7546-4246-56e1-08de22ada0d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w1jZdNeaAAukJWr0bCPL8gQxP9ShywhIY6//BWhqrAYNLs9yqsl3pAosi1Gm?=
 =?us-ascii?Q?ZvVGkWCEM4FOxLn9omQXkerdnjnQEhTFLjDE+TrF+soXeZBBoaeNMCF+uy4F?=
 =?us-ascii?Q?QKDWm2fWfI89m/l1YMQauycsgaDyEtB1LfqqZ5oUx0wdDRC5PE7nqUFdKEZ2?=
 =?us-ascii?Q?TXG+Rhe7nuU2w0A9VAqE6D6i66Bno1NicUKT1pAWJygtP0HPOV6++QJsAVbO?=
 =?us-ascii?Q?gqIzo06Rucc1AeN70YY9nvEjJLHyyfkK1y/YPSuGxJSj+6NZDYo2uMACTS10?=
 =?us-ascii?Q?KTr0NIX6f2/nl3rRXKDxWb3NlMYYsFVwWwtMvbXO89sPFuFqRdLgVBctbw3+?=
 =?us-ascii?Q?Ssh4GHa8PdiB8mPmNRMN0W/hnbMfQXeX7RRqsaLyTcdWgvjBLxgzxiSLY2sd?=
 =?us-ascii?Q?7PJB2JpYyujVVZ/D6WyV8Jt3/o44SJd8z+IxVFSeP4P8ADLh58MOrlLGRxmx?=
 =?us-ascii?Q?N3mCwFgkkYJWKno0v7e68eSh+h03pBfLghnpgviqAu2m8hsxuc3iBJ0MGbbJ?=
 =?us-ascii?Q?zUw2Xj8osJqtRO7iic7ijxm0qZolfx1lA6MTPIlQ2waXxv1xsGXkrbsov7Vh?=
 =?us-ascii?Q?/xf2pSmktJqLvvElpIGsPyD3Q7ZdBZbHvcDOJcweAtW3QpUmheBGItbx6rVO?=
 =?us-ascii?Q?fATInZgJG8/f3Fu2N/E7FSqTX1IuanNF2gQM40QO22D3x6Knex4+/tpcvbZM?=
 =?us-ascii?Q?FunF9sOTbl8Ir0RQMdb+aC/PORZGZYghTMG53AnmOuAoMg0X4fX48iUMbbXY?=
 =?us-ascii?Q?Fl8SmRMeLSc0uKLVcW7ocHiCG26f+ARi1QZERjTK1IchUB3JSagpDu0urV0v?=
 =?us-ascii?Q?l8QhiyVeitqbS/LAmVX3HqlrC4fEsTeBIGSeKu/20ykJ3eutAIXdJm1iDKlp?=
 =?us-ascii?Q?Jdg2B62FohHSHApBelrbUfAupIbIaErSit+BRx60VikFu0kX/HQj9p1gJIj3?=
 =?us-ascii?Q?+4aEUltL7mArezl+IUFyjOzXjzv5SKSM0zWDHLDdHV7MuWFp5SRt1TKnzT/X?=
 =?us-ascii?Q?tAF9fJpQ1wqWuqjUG+OLneMQAT7F3XHSIyff2Eon3DUuk11N6bph+b/x+j2N?=
 =?us-ascii?Q?bIm5f9Y6zDXXELR+sS43jIOc6r3jIbzy3u1ilmwAOGrboIxYIoKuRxHrRQ08?=
 =?us-ascii?Q?h6sKKeC2MEy8g0P9eLjStNSezUoP0pGqSAUaH9YiIZZOZ+J0ylNv8uSSvP0h?=
 =?us-ascii?Q?bvc67uGcYoONaqrAxdCU0aSk04HSDAs+ycBxzVq+gxtrZEU32pxlvSPSIeSJ?=
 =?us-ascii?Q?7s9BAVCw+C8rhnyxI8GskiX4tpOabJcbl5H6vYeHeiGjGcg/SGCCYTjd4Hht?=
 =?us-ascii?Q?u20f3LdKV4v3YZG1CsLs7NApRTsL1zB7sX6pnL6PNa1IT1nnwYtaTSEo5X6o?=
 =?us-ascii?Q?VR58riseRWbZQEvsi+m5ItJdHsyvDm/kUhjq7PZ+8+pnSHdfdPkaQIEwi2mi?=
 =?us-ascii?Q?dB0JbJcsAAqCoxrWZtgrR08eBq7uOSpY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?07vWP6FnlHaxzga8w7p+H21xvAjDXwhipiULiriMvkGTNPh4z4/2vFAc8bMp?=
 =?us-ascii?Q?Gb2F9wX7iqSiIKHx5hNZa6d0da7uT4TZjr/2oHFMpLrUzjkcSUKmddS4RL2L?=
 =?us-ascii?Q?Ydp5AHbA7DjfQOk1HnRasWhphsvFSmfgyHeB07p3eRvPYHGVTO5XSYbBchrk?=
 =?us-ascii?Q?MVftBHbPTwGlYZcwuN1oyRsIZ7wQUFxkIyNWDNGDZjzYJhkmaJWY39JhsmV2?=
 =?us-ascii?Q?CEhsup9WUrcrZnyQcEEU3D2/2wkszeJLUQCzGkdBeD9ku77ZNrLJd2b/LcXw?=
 =?us-ascii?Q?eINMqGsoXMGLcAjYmXH12p3md1lp11ywWyqqlkExBS9dt9sp2RmfsDYL2AE7?=
 =?us-ascii?Q?rYoqyi10S1AwfvZT89ITfMgwNW74uANRfAYqFsHHixT7FJBuvUf8AgIHfxfr?=
 =?us-ascii?Q?mhYl+RIMb0KYKtEGcbg7+tXuAZszdR4VTEMjoaM/hGnGxJ+/xM5EbF6Nh040?=
 =?us-ascii?Q?JiZMjzG/tKk2JhY4sIdKbU2i8Sw4ZXl5bW81+ar6tHCrVPWNGA49GHM8pjqV?=
 =?us-ascii?Q?g1RzbQY4/qXRL+R5Zl51Jmdmm00rJ28Xk24/DbG0y/2BJ5deSs8g1A00uCkB?=
 =?us-ascii?Q?tvZOfNXrFSvz3qq2A8Pj3RUC7ucJeh+c4xlwTaLmlD9h6toSJtMRm3xY6BzY?=
 =?us-ascii?Q?QB8U7s+UiTRWg4YF6uVo4it8PLjwo/Efd/iD219WqhroHKlab8cYh7l77P1g?=
 =?us-ascii?Q?vnlfQVCFIAA/OSmyftUtO9yzMyhyxccpFrn8bqOtZlSW/b3XVXJZJPdx6CMQ?=
 =?us-ascii?Q?faYps3ZU0hl/A/HkoL/+0Jh5kxiGGCjSA/a+dD9W4z8J3ljbUSf6RslnTNUs?=
 =?us-ascii?Q?HxjcIZtuoIIMCeyuXL5UtaxtNZDsRO+jo0gqkuHEy6F7IijPTxqH2R9ofwAJ?=
 =?us-ascii?Q?a+KYkhkTbQmvQALkLDOyoEkEqyyK9dBElEB3oOyheIOVivZda1etZlrhamAh?=
 =?us-ascii?Q?P+jBfiyk+4Ktpm+Xg73mEVhoaBxJPWBADUnsHHlCWENQeYIF7hoHbfQiC5t+?=
 =?us-ascii?Q?RUiQsJjzRJEpkiuy8YUv4x+gAwPIgTtLlwdZgS0pE9KAOuLnI9Sjfka8otBa?=
 =?us-ascii?Q?EmeTHaxgFvZNvVEhfMdjucVUxtsAetgD2ahZD0kBHrT/2xvuAliaeaD9SNip?=
 =?us-ascii?Q?95hISRImjK2ojCfurpBTJ3soouU6CCH2ZsOkUm/bSjeFI1+nDCL9mExn7yXb?=
 =?us-ascii?Q?EDLCXAjCs2uL+vBGOOuLGqqzeEDKHFnsczfBw6q0MHYl6oYnMjFhaOB9tj2+?=
 =?us-ascii?Q?xnEXJwRSYnRSSc8z7PADrftqPol9ykdInXLSfKPLXFy1y+VL1g2CFq/on1NN?=
 =?us-ascii?Q?TxU6y1ZzXqhvvWpYnrjN2nqI+7FlmH3276dgjxtdFnLO11wRXBFG6km3to6Y?=
 =?us-ascii?Q?at0inDzIkfFHNpIvPTf3vy20vZtgg2v0nbWzXV56KzeuCNfY5C3bnp76cub1?=
 =?us-ascii?Q?s7csUzMR7cCRNipiFgBMbcbT2NyhJTiBIo0C4tOFR11HwD8dgVB7WrwMcG9r?=
 =?us-ascii?Q?EPwaV8xVI9Tgj++er5i9E2etnCvgnekQcdinUktgFp9X/orv6cCgdrad5gPL?=
 =?us-ascii?Q?l/0ubw9Y+YUj8J+/KvPNsZeZc8cIREugt9vHOvzVKi3Xi9yawBKMOgXJjl4u?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2710b1-7546-4246-56e1-08de22ada0d1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:25.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsHovNeaHB/GcBzSq9ZbcAc0CPsmWevrR/U4pKnFxwhaDd1qfI6ipDf5aW0WkMekRdM/LsHMcNUiydkvXsfOcb72nrxSXHvTWHbm0ZyqPWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8286

Introduce trap handling hooks for the Dovetail co-kernel, integrating
out-of-band (OOB) notification and unwind support.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 92 +++++++++++++++++++++++++++++++++------
 arch/riscv/mm/fault.c     | 21 +++++----
 2 files changed, 91 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 83aef3fac26f..e156f83acd2e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <asm-generic/signal.h>
+#include <linux/compiler_attributes.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -114,6 +116,8 @@ void die(struct pt_regs *regs, const char *str)
 static __always_inline
 bool mark_trap_entry(int signo, struct pt_regs *regs)
 {
+	oob_trap_notify(signo, regs);
+
 	/*
 	 * Dovetail: irqentry_enter*() already synchronized the
 	 * virtual and real interrupt states for us. If running
@@ -125,21 +129,40 @@ bool mark_trap_entry(int signo, struct pt_regs *regs)
 		return true;
 	}
 
+	oob_trap_unwind(signo, regs);
+
 	return false;
 }
 
 static __always_inline
 void mark_trap_exit(int signo, struct pt_regs *regs)
 {
+	oob_trap_unwind(signo, regs);
 	hard_cond_local_irq_disable();
 }
 
-void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
+static __always_inline
+bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
 {
-	struct task_struct *tsk = current;
+	oob_trap_notify(trapnr, regs);
 
-	if (!mark_trap_entry(signo, regs))
-		return;
+	if (running_oob()) {
+		oob_trap_unwind(trapnr, regs);
+		return false;
+	}
+
+	return true;
+}
+
+static __always_inline
+void mark_trap_exit_raw(int trapnr, struct pt_regs *regs)
+{
+	oob_trap_unwind(trapnr, regs);
+}
+
+static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsigned long addr)
+{
+	struct task_struct *tsk = current;
 
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
@@ -152,6 +175,14 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+}
+
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
+{
+	if(!mark_trap_entry(signo, regs))
+		return;
+
+	do_trap_raw(regs, signo, code, addr);
 
 	mark_trap_exit(signo, regs);
 }
@@ -162,7 +193,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs)) {
-		do_trap(regs, signo, code, addr);
+		do_trap_raw(regs, signo, code, addr);
 	} else {
 		/*
 		 * Dovetail: If we trapped from kernel space, either
@@ -180,9 +211,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)					\
+#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
+	if(!mark_trap_entry(trapnr, regs))					\
+		return;								\
+										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
@@ -192,19 +226,24 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
+										\
+	mark_trap_exit(trapnr, regs);						\
 }
 
 DO_ERROR_INFO(do_trap_unknown,
-	SIGILL, ILL_ILLTRP, "unknown exception");
+	SIGILL, ILL_ILLTRP, "unknown exception", EXC_INST_ILLEGAL);
 DO_ERROR_INFO(do_trap_insn_misaligned,
-	SIGBUS, BUS_ADRALN, "instruction address misaligned");
+	SIGBUS, BUS_ADRALN, "instruction address misaligned", EXC_INST_MISALIGNED);
 DO_ERROR_INFO(do_trap_insn_fault,
-	SIGSEGV, SEGV_ACCERR, "instruction access fault");
+	SIGSEGV, SEGV_ACCERR, "instruction access fault", EXC_INST_ACCESS);
 
 asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
+	if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -233,13 +272,17 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 		irqentry_nmi_exit(regs, state);
 	}
+	mark_trap_exit(EXC_INST_ILLEGAL, regs);
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
+	if(!mark_trap_entry(EXC_LOAD_MISALIGNED, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -257,10 +300,15 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit(EXC_LOAD_MISALIGNED, regs);
 }
 
 asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
+	if(!mark_trap_entry(EXC_STORE_MISALIGNED, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -278,13 +326,15 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit(EXC_STORE_MISALIGNED, regs);
 }
 DO_ERROR_INFO(do_trap_store_fault,
-	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
+	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault", EXC_STORE_ACCESS);
 DO_ERROR_INFO(do_trap_ecall_s,
-	SIGILL, ILL_ILLTRP, "environment call from S-mode");
+	SIGILL, ILL_ILLTRP, "environment call from S-mode", EXC_SYSCALL);
 DO_ERROR_INFO(do_trap_ecall_m,
-	SIGILL, ILL_ILLTRP, "environment call from M-mode");
+	SIGILL, ILL_ILLTRP, "environment call from M-mode", EXC_SUPERVISOR_SYSCALL);
 
 static inline unsigned long get_break_insn_length(unsigned long pc)
 {
@@ -336,6 +386,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -349,6 +402,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
@@ -365,6 +420,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		if(dovetailing()) {
+			if (syscall == EXIT_SYSCALL_OOB) {
+				hard_local_irq_disable();
+				return;
+			}
+			if (syscall == EXIT_SYSCALL_TAIL)
+				goto done_inband;
+		}
+
 		add_random_kstack_offset();
 
 		if (syscall >= 0 && syscall < NR_syscalls)
@@ -382,6 +446,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 */
 		choose_random_kstack_offset(get_random_u16());
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -391,7 +456,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
-
 }
 
 #ifdef CONFIG_MMU
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index f7275f1a39ac..7033119e4e2f 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -279,6 +279,10 @@ void handle_page_fault(struct pt_regs *regs)
 		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
 	}
 
+	oob_trap_notify(EXC_INST_PAGE_FAULT, regs);
+	if (!running_inband())
+		goto out;
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 	if (cause == EXC_STORE_PAGE_FAULT)
@@ -297,7 +301,7 @@ void handle_page_fault(struct pt_regs *regs)
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
-		return;
+		goto out;
 	}
 
 	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
@@ -315,7 +319,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 lock_mmap:
 
@@ -324,7 +328,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(!vma)) {
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -336,7 +340,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(access_error(cause, vma))) {
 		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -354,12 +358,12 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
-		return;
+		goto out;
 
 	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
@@ -378,7 +382,8 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
-		return;
 	}
-	return;
+
+out:
+	oob_trap_unwind(EXC_INST_PAGE_FAULT, regs);
 }
-- 
2.43.0

