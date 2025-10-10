Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454C2ED16C
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089949; cv=fail; b=NtWzJ7+dGPf2b13FhlifaUMGioIGNmXMsCSJREA9y4+76FOYpgO1rhyuEgnspFU7Jul3HX6PUE4+sEMgG6bAkg8WZQbJGMj8lSWrHlZqDHibPdXNQXOn+vAS/Bqym825NtVIf0vExayajNP58A6aFwtNdWYihiaUmiHK5EbVcXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089949; c=relaxed/simple;
	bh=6fi6/gRSPSXd2V9pAdQaHVK5CHgOd3/mvi6ZyBldqUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UU4jU943OPGQhNPq/z7N7VPViCXG85QFCRdDiQIj6x2hqSl1Kchk8UCALxBCbhuJjTv4oZaujkKkAVm1gEOeAiAtZxrTiilRoo/5CLY8Mi11tqlD0dLf01gLI3dyFEhPHuuP5nH4Tl7qtwSOXK8DWU5NWHro3LOeKneHdftD1JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=suYUzVzH; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="suYUzVzH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbDddvEy3jXoReR5yOZONcOn6JT7JIpdkfnabDiJZceV85ll7ywaEas4MNpC+RmGKf1PMdBNQSuRKYpZ1fUWkIKgRcH1dASE3+6ztEeKyXg0fGDTgeD5Av62stbi3hNYmbbnAaZ45i0dKXR3LKDRAbJfFGjZdq1OwCgD44EzF4bQrtbWMqpMF8kSIw/tj4YnukpgTlZPnnAfJ5quldA/8cEd8k2XQJg3LvYGT+xw5IY7FnJ1I9qkiSqAuIarPwnlccThfZwoTZcfKDpaUsg45bG5SigCaFbTzu8dlws7PdbKS+Gt3V6E8L7x+wFQZoW/tq9e9m7JfZ+pr1+L1hWIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTwWpNLeWHpqaZiFLcUnNsrgdXg20N7YWml0k78N0ZY=;
 b=HG8sO5DKqZ5ks1Mfaz2PPkdkR+y4xCKD7d+72ZuOywj42JdHLVOz4MbL3luzxBsOq1GgX80QjCm+LrzuUrw9v1OhSksL5uHtjid5BSGvEz5AJAkeFIou6TcLvl/dsactcQ9sxOBoDKZ8gTv3dVHv7dRIOMs1eUz2O8QFbMI141/00OX26u0CdOyw2cKxb5ntc0QuheQdkCr/rOCtPufpBomBwT3rtGQ0OIWxw1JSLGIplklMXZ/ZHVGGqqDa/kYbTE6/nFGYq4+Kh1bqtCLhlJZ8hcf2U3DH1hTAnknb/BJoR/iTIKyMbf6sqCx43StC2p3XddpHRlS2R20RutIGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTwWpNLeWHpqaZiFLcUnNsrgdXg20N7YWml0k78N0ZY=;
 b=suYUzVzHxcHCYn6oQOwtaDqnUHPY1sKQy/IXiuTp/QDnTOT3hjvpGhv4MPH+nrpSHPQljq5M0JOyAZrh6HuYtmMd82d4uGcSTqgyuoriDt3OGs7zEYyBv8w7/ME0et9hYrg+1FefECmgkIYXq8Cr7cMdHQ0dSKJUpVxnufXXnYhQwGM6bRtVNWBP1AdYCcjam4H1kwtJ4HJDy/AoL5+my5Q0jClHI6VjvmiWao9gTa2Q2LMI+h54F57hca9SHKIFbPjrpyeAvcJcqeik4KhDrIU2sOgaPF70UHkXHiBa9uvpLmQqtDv3rAq4+T7meSf4xHaH/zZ+NedolcuAtEAeXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:20 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:20 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 6/8] riscv: add out-of-band aware trap handling
Date: Fri, 10 Oct 2025 11:51:54 +0200
Message-ID: <20251010095156.3756799-7-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: cec727d9-2c39-4551-48be-08de07e2b42d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMnLpewMNNReAdWn7zkIiwRKRlvvMECrKoO/SGWGeDDsBqw7aTK+ad+wAOtD?=
 =?us-ascii?Q?B0CVvEW6pgPSL03aI6q0KQxxTeimVBU41i6ACx+kxE1tkUiFuYAUa2WTXR11?=
 =?us-ascii?Q?EHTfFrVlQ9z9YZ73qufZCDfG+fmg+LybmZrE08kJACPnMvMBRb0IWno3WY9H?=
 =?us-ascii?Q?76bjc4KKozeiIYXVeW8+iwstxmjqnIiXJXaw+8SyfuwEVZ+qmZdcddCYebo/?=
 =?us-ascii?Q?khyo8+nMWwc8/Gw61TspyvuJT79mkAsFSQL/s7+BbtwgkjkIAM3YRkrWb1bk?=
 =?us-ascii?Q?byEQovPzQTLTQaOnEp8tGSKPaF/R5cdOuUVJxwY6DAfpntMK8Sb6USD/VEKJ?=
 =?us-ascii?Q?Yagd5N0wFvDXytVMVk46Vct2yOMRCFw4mnFg0PAMGMu1Se/bN7SgIInPnO21?=
 =?us-ascii?Q?5iJbuVfIR0cUkhoUTLRtmuDEfUEf6OIsvVLQE4N4gbQztaJcpgYyBkbNsHmp?=
 =?us-ascii?Q?3Hff5Af4R+nm8wlvl7mL0BWm43o0rwBz8dahzwATx2ohGTl/tYElC2UmHyHr?=
 =?us-ascii?Q?udhGxZsqxx0LSEktXYj4zx47l31u9eP65Hm8J2PMdmNItrhC10g6GqkAYWdK?=
 =?us-ascii?Q?874FYWV/UjjB6n7IhomLQt+3K4//SNHcCnPBdmLRKVaxGGc6Xtex0cRlo5Iq?=
 =?us-ascii?Q?Lk2lo95dCW6kaFVz0kp6aN2ubflm6fc2m7MImOAHbmwMIO6j7zLCqPKPysBp?=
 =?us-ascii?Q?cOqvcShYJuk4sQ2IIUVEdqPz3REhUB2IKOElM9ol0qJwgXhYXSAWkpnVzWmc?=
 =?us-ascii?Q?F7nl+kk6xWnbms1xA6FCJKtZ9z+hx5WVDG2MiS+Pr5bG0YikY+6amx4fuKqf?=
 =?us-ascii?Q?sIlB3fWZOTTUvfqoJSptNzuaGLNNlSU9sOO4sPsXscX5cw/R3nCCaFD2i3VI?=
 =?us-ascii?Q?BFY06GD0W2YufI/jCuqz/xbpJK3NZC3ZSDSkAeU4ZJQwSDwqiamwLVC8psMu?=
 =?us-ascii?Q?+1kjJfh507CrNOlN388fDvbuno4DGzNdCDSI2XlvO5vKb+aPkr7F6LMmAeWz?=
 =?us-ascii?Q?Vx3DfMwVtTi5fuebgzXgYd/j7i1oQMpAr1wBJmXyaZNaUAfCoPcHiYDRyXNs?=
 =?us-ascii?Q?7CFTqKBHKR95CxN7mtBCiMcGwMdiNLgdWe9PQrQIYPTrRVaKSCiV6epx7kvQ?=
 =?us-ascii?Q?+4A44Zp5j25xS/xr7XvPpIuZWzI5MF28E3cfI66sejcNOhvDt2COnjpuO4cO?=
 =?us-ascii?Q?/WZxTAfmXy+tQV8x5rFR40mAtPo2ZKD3w+PjKXVprX5tp+w7hPgWGoHysn8a?=
 =?us-ascii?Q?83UOtUjd+kCA+vP6q6HGRi9kxKkMoKeWFzYgeNcDnctwIt0p+cENcXJNtswh?=
 =?us-ascii?Q?veJHi8dCXLsbJhH54GwepKRM7LNfnm0toeh0fIdGO41b1j03O/5oRfrEUr5/?=
 =?us-ascii?Q?pcRzO2QWgcBQugqC8lGO+rVRzZwMhaEPlbYlM/AFMnetOutweI1XSwwVJN6f?=
 =?us-ascii?Q?iHhVwVNyKGGuSzzxKjprIIYo+8b96Q4b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z7vvgSh/8Sr8uKdlZGFn1TB7rUrg9AgsrSlQkgp3qGcu2SzZDstCGQO4MoN9?=
 =?us-ascii?Q?lp4KXlx0nZlh93VLvIqeTuSPrIVqLn4yuk6luRwRIpqLlg+6RaQwCYlAErBX?=
 =?us-ascii?Q?P4keuqJaAfLfhhVegVK2hcjvw+1DxEjHSqE49y5/Ahgea1ePxdhHmTi2L7D6?=
 =?us-ascii?Q?6iWpIsfEPOOu78VIyGGGOQ/t2uESVmg+GTwyu5+I+nhhIResGGU6JWZ38TZr?=
 =?us-ascii?Q?Bfnaqstb8uF2Dqd563r3HhPH7OXKZ/4C0DO8XYbuNIPnaV9IvgOl0FQia+if?=
 =?us-ascii?Q?5mnjdyqzoqcazmGx+w3a9n/lwi7oWkS39hqcUaxrqzhvuwqN2MAEtZ5RrLwt?=
 =?us-ascii?Q?Z2HwQkTWjbjCLIbuCXp7pk50CaId5O/TvtbIT4cqHAJlP+mcdglGNShClY8I?=
 =?us-ascii?Q?0xHyBaF8HzmsdTXVf7RdtXp4VaI80ZfVCDD2n6vjJ++C4bCnkixMx9lEukMl?=
 =?us-ascii?Q?oMNoZ0r1qiywKKvv5ZovZVnPDYFtAj0A0ZbN7XJBlgVDPi9Knyx5AygN6OTX?=
 =?us-ascii?Q?cSTXkAI3BmS7LGJC2hrq+sxdD0XhJGf1SDY0YHuJbpjI+netz/AsZG6p3B5K?=
 =?us-ascii?Q?k3g+LcEslsNwp8e6q9RvArkth9h7q0IsPFeqRveGTc7elPqXaMftw4PqDqvx?=
 =?us-ascii?Q?A+pehfP83cWYmSOVAOOwlgQxxxayRc/qS0/HUHh+O8dpVRpShqLQMFHxLEUJ?=
 =?us-ascii?Q?yioyt5LqvRXzlj8djPia94Ks2Vao5xw3zzcTp/Zl8JOpCWnfhbg7oAJaEKCI?=
 =?us-ascii?Q?EJ2+NCJgSHT1sJkj2Zy87LiWpWbjQrpHi/kPebsDfrp8Ovdi/tLRbY1oN4aL?=
 =?us-ascii?Q?rkvSDWvu15AZHm/zInt0f0Q32LPk1co3I06F6nf0UgnQ7wA25R2YFCCEj6Km?=
 =?us-ascii?Q?Rib9oMFSSynJh1f/qL8bH8woVk25gazIrWNKWW6RkKAvleyEfLWw/9O+9adT?=
 =?us-ascii?Q?Q+fYeKqCRMki/gLgEKmEyB+ZNlxr/vnK9xO+UE9ywQXAXXL5BRoZZ+x3JdLA?=
 =?us-ascii?Q?DnOvrOnJdIdF80pwaeUmw2lGuVIjNBSuSw3fkdfyVznX+Y2/QNdz1DZnuxQL?=
 =?us-ascii?Q?qvaMx+hocaaAbCFm6Vh03ln/wBH+B3LvHsazNdAiok4HHUiCEs2PSaiIbV7d?=
 =?us-ascii?Q?QGE0xpM+x5o2/GTPwCtxdCG6toGdrefUoHeuQSdLnK4EAQbcWd3NZaHwQDns?=
 =?us-ascii?Q?ajynEvmde+3fn6jsC6fHxvPrQVi1ZcxcHVBb/Q9GNIkZhLxiHdWSU2vZNcW7?=
 =?us-ascii?Q?fknZF2J6Y/oYWUqtQtUzCnEW9K6jF8tJFKw9cmVVPqe9L8nCn1W9pUxPuREW?=
 =?us-ascii?Q?OStgv27Lr70dxrWgu4zY3r1tGQDPPRcvsO/9qLmJtv8WGi/a6GPLPVmakz79?=
 =?us-ascii?Q?iiwe8Mxe+8Ipyk3Yuw+9/izNe37A3kq4eLd3fFjFpjpFnA/7bLY2ZRcA17mY?=
 =?us-ascii?Q?3UQ3lobIHo1gRBAKG8CrW6KGCB00XqahXdtaP8j9jyhzUfDm8yr42dqGkWMW?=
 =?us-ascii?Q?jyVfhuw5EFiCbAqFvIQhTDBHZNGZcoi0gYg7bna1dlzhB5vgq782I3YgVydf?=
 =?us-ascii?Q?meEniYf6CnYWl6DlxtmUN+A8X+T3bmAhxv/wv0jq7LjKp3oiYi8Bpa6vAVxi?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec727d9-2c39-4551-48be-08de07e2b42d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:20.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igNDw1LGz1c44d8DX8VKB5eJae4iQv6kpxLJ2qxMG6vr2g55+ql4Zn9wdqL3X6I87eJaPl97iC2d4Q6KXQLWbMkivImImZ3DGqh6a9pcIkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

Introduce trap handling hooks for the Dovetail co-kernel, integrating
out-of-band (OOB) notification and unwind support.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 92 +++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 83aef3fac26f..f581dbf20d8a 100644
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
@@ -125,22 +129,41 @@ bool mark_trap_entry(int signo, struct pt_regs *regs)
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
 
+static __always_inline
+bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
+{
+	oob_trap_notify(trapnr, regs);
+
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
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (!mark_trap_entry(signo, regs))
-		return;
-
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -152,8 +175,6 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-
-	mark_trap_exit(signo, regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -180,9 +201,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)					\
+#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
+	if(!mark_trap_entry_raw(trapnr, regs))					\
+		return;								\
+										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
@@ -192,19 +216,24 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
+										\
+	mark_trap_exit_raw(trapnr, regs);					\
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
 
+	if(!mark_trap_entry_raw(EXC_INST_ILLEGAL, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -233,13 +262,17 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 		irqentry_nmi_exit(regs, state);
 	}
+	mark_trap_exit_raw(EXC_INST_ILLEGAL, regs);
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_LOAD_MISALIGNED, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -257,10 +290,15 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_LOAD_MISALIGNED, regs);
 }
 
 asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_STORE_MISALIGNED, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -278,13 +316,15 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_STORE_MISALIGNED, regs);
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
@@ -336,6 +376,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -349,11 +392,16 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
 void do_trap_ecall_u(struct pt_regs *regs)
 {
+    if(!mark_trap_entry_raw(regs->cause, regs))
+		return;
+
 	if (user_mode(regs)) {
 		long syscall = regs->a7;
 
@@ -365,6 +413,16 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		if(dovetailing()) {
+			if (syscall == EXIT_SYSCALL_OOB) {
+				hard_local_irq_disable();
+				mark_trap_exit_raw(regs->cause, regs);
+				return;
+			}
+			if (syscall == EXIT_SYSCALL_TAIL)
+				goto done_inband;
+		}
+
 		add_random_kstack_offset();
 
 		if (syscall >= 0 && syscall < NR_syscalls)
@@ -382,6 +440,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 */
 		choose_random_kstack_offset(get_random_u16());
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -391,12 +450,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
-
+	mark_trap_exit_raw(regs->cause, regs);
 }
 
 #ifdef CONFIG_MMU
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_LOAD_PAGE_FAULT, regs))
+		return;
+
 	irqentry_state_t state = irqentry_enter(regs);
 
 	handle_page_fault(regs);
@@ -407,6 +469,8 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 		hard_local_irq_disable();
 
 	irqentry_exit(regs, state);
+
+	mark_trap_exit_raw(EXC_LOAD_PAGE_FAULT, regs);
 }
 #endif
 
-- 
2.43.0

