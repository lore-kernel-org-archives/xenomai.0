Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794919158;
	b=aDKMtoaBDO0U1LfeZDM+R1UDj6PE6F4Yv+IylyrQM6Vql1Fs/eXkiBnJ0urcdjha3WpF
	 cNBrHNdx9xf+TMhB25sI7/BzCUPoJpeVXX/9oPwbbSZlatfwtFZTxxbAUUEEDknmWng8T
	 PaJxnkXwFHpZuSsqYImCNImNRZRxsVD37r86+CIJlA060nE6zM5UXYslWeHp25tifIpLd
	 RUNzRKWTwr+HyIshJExNMFp9S6EubONlrv9aeFpdIXfms60vav3R+gidCe85x2YKBete/
	 IccCcpV95c61ccLItkG9hB0KS4TFG5VdIt70EuabOvP8E4BQieS3kdNWLJN437xPj/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919158;
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
	bh=gKwsFwxod+7x3EoeFR9XmJLTgfp01pqxGAiwqYDvnCE=;
	b=WeEipYVyFK0vOerljliE9DpruL2rU2yZtxDskXkQBgWhhM9JhuAL5zKreiKW6z2tH+ia
	 66ZypkklcqqeCRlbmm1JPbtJBtq4/8BXBaJ4KQ9S/3WbRscp3qMKuWH0NHTmOEgXSLpEP
	 Gdxm6uWuVOA9KbIkFzv4fZ22XZzwplgiMHag9Mj629Att8b+6duLrOlGlYBDq/z4sSXpq
	 pxRuOfaathbMGzpyRhGWVeHv68tfyrN9NMj+34KwjsZ2EK6u6oLIMGKblTWRlmZEMzJ95
	 et24wOzhMYm2kUXazwwHrL4ShDZFn0yPBWhfefv1ZDaBteTdbWfa3j4gXMgTP/WwGHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=B53yq0oe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.65
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BED606A330
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 12:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BED606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=B53yq0oe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEQ6DdfXRvTl44v2jxsNGrH+4jA/Qu/cePERWFbna7BBgG1iQK+6qUb4xDJQ8Yd3K4y/AUG2bDWUwlcnbI9gjTMnmVJeuVo3x0sn9mxGMT7PB6e/d6qBnJlxCVUF6Ok1JPX41WDxLainys3d66p8F1z6yvQVSVMZd3FIT99wW8lC7h7yNKweimhwSAvh2dh+XEE2jSFuveTYjsFo4wHFjf73nA5/KETq1Byez7FxWnKKgVi7amKKR25qbdIregKi9kjBK2U/nl3cm2JRijdm6YcwYKR/ecl48dR5m0K4fmt+64BwS4D32PT+EwDSqGQwZGEI2nHXzNBlwtEz2y5wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKwsFwxod+7x3EoeFR9XmJLTgfp01pqxGAiwqYDvnCE=;
 b=Bp25X4tXDNPOwrElsSXsuuHnoYm+v8kdK/85XEGHp0Na5k8mPeW4xZJadsFHATC+A2LvcTZKGWWe0pN2JWhdmjWuctFuuc0LrKcDVYwFEhZDGdxjKbNT/Cl5bYUBL25yRT1j543NVZcAHB1evfVUblgDvmsCKwHnvAIhJjWjYZ9agCpWaYNWbEAR8JfPDBStoRhXxXzObz3cH/tFgdEzofjnzkt3bwXRR7A+D5IxBMphEXdeNZgFj/xAdki3ZRizI/dTeE+CeZkJmWA+JAH7KoqyJekhLqbLKC+Ko7UqDAJXrXPKnW41c57PycZkD6BgEGP8TrX7crbnhYe6/+Tliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKwsFwxod+7x3EoeFR9XmJLTgfp01pqxGAiwqYDvnCE=;
 b=B53yq0oefDhrKG/2PPXRw8KQsYCgwg3es2y66immPl9paoZpz4SB3yhlbPWYAdiEc1RW8oSDnZ8V90/UqITcTJT/JztO8mUaOsPf7oF9dol8HC493XAbJ8v9T/bICc+GcdZnTHvKizxeUbNO3k8WCmLNrTJdL20qVpe+meQolRfEStlwoBIrLzsp3c90n1VSN6gdS8urvPZt623kn2J07xPNYvCv5e8eFqyyADIpErQk1+e6LVEVJHN17i+Ct3PwITOmu2FgCxDf16fGkEVn0TATgA38MLztQTNO0wYMU96CI5R2m9OWdn4Zbz32V7zxGr/X01BWswasGwJH7RuLxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:77c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 12:39:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 12:39:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 2/5] riscv: dovetail: run kernel trap handlers the core did not demote for
Date: Tue, 17 Nov 2026 13:39:22 +0100
Message-ID: <20261117123925.597027-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 432bd272-0d79-47a8-7470-08df44a7c96b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261022105027099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BVX9Q0uZWPKqdvcsllwhP06oll7AOf0CixjbV+nHBPA6q8bZOz0K5iuE01b5Queqo/pAOMZCZqCcis+RktuHGrYUfpK6pUXgyauZnb2CpQgxoADkJHJr4an4buNW+1G5Qk5lIymZqD4Hx0+D8XBWE9a0oB2HTazgIlEKh3/hGEFhTetMFx2IT3Y6V8u/fYzqgvbBEmzI/RaDuFB9cSu8FJ4Eg3b0P2nlQRyR7yFQe8mo64iRJpYAs8zwAe3/gNZQ7PXNFXsFFJKt6FJKsyi89m2/YSD5qwnL2g7GmyVCDqUTi72JX0xY2qdk0XDXjxrNL9/EoDsJWWk/ZIxum/3qRkcDeKrRAWMvsIKfCeolIooAVmbOwv4drplEb7m+NNH8r9WWXGT0KRvvGO65iZlipb2wEE/ocHjmij1WwpIvZt02C4vNvO++aswuF8e6+BRWy2TDktSLGwtJDvJU3O7AQmOuelD9ZqVhFLL++KtSCpEs58DFcowNvn09cMl1vZzHuqeCbWyd+FzekUbQQ8PQfL+K9NoN+z550EJwdjLQyqMmW6OWX9ZUYtRKAwfg+p7VTkJIpwIz7aBE/zAGdOKK+dKGxhjgmjUCPADcPu2Tt7LmxhBE5YtfQXwaQ+p3c57kqLB5lKm8JzWpP+lQ+WXB0lL9ej8OrqqmvNw4o2goVG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261022105027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4SL8jMZ1trkztWXH32QfvqAQipyocxGGg6hdzM9DTBOjI3e3rN9aoLEMHYS?=
 =?us-ascii?Q?6vTSw0bJirg9wGVhi8/Tp1ckPXW/7WxplO4Ppu+6+EMi/ENDDKw3MI0X6e64?=
 =?us-ascii?Q?8PtCfx6BvGF78FQJpIzw61yTqUSgpmXWRjFSa+aZ3oaQJ2c4HDFiRv+nvnJ2?=
 =?us-ascii?Q?wXNhmtzdG/LhHzUbxVM0aMutrO39m//yVAarurabUAZHo2xJs4y2glqTuYdN?=
 =?us-ascii?Q?/KbIPmd0QE4u6+/Cq0ALydoJsTtzkLrGaiboy1/r2u60co4o1BgqLo9HwSBc?=
 =?us-ascii?Q?yjwf7PXY05oie7MbUurOJhLe5jmlOQDeczjpHg82S4O36zsVtkoRmhWFg7F0?=
 =?us-ascii?Q?xD8VMUDZm7MMKn850pZ5sGmGbHEreNFLMqCNLKHmlsQQVzjqCQZJ7jGjwFit?=
 =?us-ascii?Q?YrVXvJ01Gngq9uqZTvOY/SBucldw2rSigUt80Y99QTD/6kZtzjDwnkPqs6oJ?=
 =?us-ascii?Q?ILCF4k0ChZVcJYKLdLTInT8bpOF8R8ojG3RGZs4Up+GaF5I18HG9fjHnz1vO?=
 =?us-ascii?Q?jwcB5I2o02ypvg8XuMdEo53yFjN2f2w4gHzzsgOCXvr2Nk74aTaj6tosES2G?=
 =?us-ascii?Q?LF7p++uxHgNjfIwucfO5tMRoIBmF0AWxYsjwz57rGbYfeab2QZMqLxwOaz6X?=
 =?us-ascii?Q?6zNYmMv8bu9VihwPiJEpc5+X/V/TAwVHveG9SBquUjkdCa+eMB3Oacd6ATLT?=
 =?us-ascii?Q?HVix23kKyrS0JSgIVF4MMrP3MRGy36zJT0FrSVWcLj42eg3dOylM3PxKA9YY?=
 =?us-ascii?Q?2vP9l33LfqFI9oOZLlOV7VR0nqZMdShO0lPfSvtYsT5+A1jX2fkWPzsyTTgE?=
 =?us-ascii?Q?kJg9k2fbo5YGzSllz8R+O5sE2+z69qXDHx0EdRdIySyOdgmMhhW1laCfI4rX?=
 =?us-ascii?Q?bnjEmn0L3+8pc+/oXNWQ1AjWbVMr4FFB+Y2lJAKCFPYTGg7O513yyE9reena?=
 =?us-ascii?Q?O9J2i41xdM7NBrJRcmES24DHD6dvUIOZbmaNnqaLMBzQz4NcFsOScrLSLEsO?=
 =?us-ascii?Q?Y5Z60ndaizSqszJGmUQp7sEYhhriTOYJBjGQ/7uxETmZVjl2ALMi/KID2SwQ?=
 =?us-ascii?Q?GWw0DGJMej04nuxRvB96eOD331oEoxxRdCU6hFzOHVqkyPLWd0Hu7d3OBwUZ?=
 =?us-ascii?Q?QPwr6eHsIZPdF1x/clKa5+LPUmn+4tDVi1IwruDjadxmfoLExthvw02DMcnk?=
 =?us-ascii?Q?pmzyZWSnJ+q5bDNn32HcnKveyVpADqrMEiTMjhIq8XnPBHyBIHTmjPXRcCeO?=
 =?us-ascii?Q?4ho+7T+imYAGVvowW/Xlw9hBwGzwiWV/Hc5lJgaIp/LRFGFFVPMLA1C2JE53?=
 =?us-ascii?Q?emXLO9b6KBLYabVmmv9KF79RvjfEpef5tijDGz8jHKOLrokM3g06OiUHe38j?=
 =?us-ascii?Q?hYtcqeDiTwaHZnKEa17h0AaJpSRN7UV6tMd7G+7dP72DRHcr9lba7cQcB435?=
 =?us-ascii?Q?au0kKYQaS0wuYhDttyk08nKlzolkQJN/YmVp7ykoWo9Cnw3crjxposm9iA/Q?=
 =?us-ascii?Q?ym6hI7t0rG936CKrNrRTRJykxKePrpKmbNs2fpwasNRatMA36Rl2XdKWhMK4?=
 =?us-ascii?Q?b1Ov7BGG6URy8pNf0EC796gfUdJvyJuqmiRb6kdeT4kmNakUQhtZIPvN+S5I?=
 =?us-ascii?Q?kqOMFMvNpgULynmBEJRg18l7rw8xRBXPp3FLt6ja5/QufA8mDEvGr7e1hHKP?=
 =?us-ascii?Q?rxOpFW53jZTtMtst6wTRdxuCY8R+oqYKJ9IjfqXD1iflFjig4w16fSP27PRP?=
 =?us-ascii?Q?LldnwVmvEiydEAFQeEVFzy/xpTxKP3B3tG81tuO85viqagAOmQABOICNGKEJ?=
X-MS-Exchange-AntiSpam-MessageData-1: VQUsbQWKmzLmyUIGdeLReBv20Rrm/JYgae4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432bd272-0d79-47a8-7470-08df44a7c96b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 12:39:14.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTQXFtVqrxQTQKyw+mYDIo0qsE9YX0ttadyhVBWHUaw4UerL6Ey1sx+pWVQQhuoLRK0GmJtdUMPocTSGtaiV1Mjao6ok/TF7jT2jUZPoGlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992193

A kernel mode trap is skipped if the companion core leaves the current
context out-of-band. Kernel mode traps are notified from within
irqentry_nmi_enter(), where a core may not demote the current task (EVL
bails out on in_nmi()), so a kprobe, an access fault or a misaligned
access hit out-of-band in kernel mode is never handled and the faulting
instruction traps again forever.

Run the kernel handler regardless, as arm64 does. Only user mode traps
are still skipped, the core having to deal with those itself.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index e2d06cb87c6e..a8e37ec27cc2 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -113,6 +113,11 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+/*
+ * Kernel mode callers ignore the return value: skipping their handler
+ * would trap again on the same instruction, so it runs whether the
+ * core demoted us or not.
+ */
 static __always_inline
 bool mark_trap_entry(struct pt_regs *regs)
 {
@@ -183,10 +188,9 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
-		if (mark_trap_entry(regs)) {					\
-			do_trap_error(regs, signo, code, regs->epc, "Oops - " str); \
-			mark_trap_exit(regs);					\
-		}								\
+		mark_trap_entry(regs);						\
+		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		mark_trap_exit(regs);						\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
 }
@@ -221,11 +225,11 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-		if (mark_trap_entry(regs)) {
-			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
-				      "Oops - illegal instruction");
-			mark_trap_exit(regs);
-		}
+
+		mark_trap_entry(regs);
+		do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
+			      "Oops - illegal instruction");
+		mark_trap_exit(regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
@@ -262,8 +266,7 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 		local_irq_enable();
 	} else {
 		state = irqentry_nmi_enter(regs);
-		if (!mark_trap_entry(regs))
-			goto out;
+		mark_trap_entry(regs);
 	}
 
 	if (misaligned_handler[type].handler(regs))
@@ -366,10 +369,10 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-		if (mark_trap_entry(regs)) {
-			handle_break(regs);
-			mark_trap_exit(regs);
-		}
+
+		mark_trap_entry(regs);
+		handle_break(regs);
+		mark_trap_exit(regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
-- 
2.53.0

