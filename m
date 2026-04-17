Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6B2857EE
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459742; cv=fail; b=LtqFNCftiLTL138MInmIPMULn5BTjmMtBxlqUbFzX4I0Q5C+Iw+Jvhy/9pU8pI0907x1hyD2tPkHnWGUkPsHUadEGBYw1EwlvQ0Cw23x8Xa8mTyhoui6lrRC/f9wbHFdz3KyU/rG4B+gkrDcqwDnqmgn1DTwrn36GxSrp+2s8Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459742; c=relaxed/simple;
	bh=j7LrR61iQpObnglXM/YRJ3tBUCUbRFak7wRg17cujnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGDGDgbCy5hwOiSUlgLCM3NYqAo6+aFCLH1Nw2venV56us6dou81Z1eGKY8gc9Fq/nfHg2OWoTn/L4Db2Bq6mXJRIT+uw+/fpfMoLMh3yU23kY5gR6WTmf8OG+yDsmGTEQFGcuZvlZ7M87c4xiNWcPpajfdRSp4f3DBn2F8xqyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HVyjyYCg; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HVyjyYCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcDsh/FHrYzUpWCRCZafcfZAzMb+1gC5nPiJH/tv4N5S934G4aKzx0Iz8kBnQYPlJrFF4CK9XVfKEwlla0ouE301QxTE0Ocr/29up0A8cT/TdiuwKrxeglJTfebTrNhKyNYB/yalCM2ecEPulrNHgSWMjpBDjE17F7Ewq4hjeoqPoWNSvdubCgyZW+CLeHVzMgzo+0JrNZA6Gh8CreMNDkqsUjprQ1D/lgBECFWH5r1Phq82eBKnZusPY5vXsLBeAVT3a9wGmCsN86nYuzqQcmnJVg8yKZpf1cu8ki2PM39Ildhn76SPJOiF4uHlrmIALL51zY1QB9uCqv7G25CBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH/ZM3YO1sbk9Mi5qTuGQ8Iv65YFPwiMXdFKQw4Cczg=;
 b=OT8cZVI+ZOONaLm3qrcP/7dtCrwSx09Ic9nieJav1Ay8akjRM26iLhwAm5mOae+QpWe5V3NVU/Su/rkdDNQAMyX2WhuGjtPY9APnNrdlL5S7BRQfAXDOiM1Un9smVV2QXK6WPqcFBk1BM99f2a2N8oUmoTJmus/yeXuYrVEdqjH50GWTp3Q77QATZqiwArL90F8Pw1Ln4kXepmHR5a2n1skSolmUCt2WX0rpzpcUawOtiqxhv96krMR5cW+t7rnVoNlNSoCK703r6bVzk5GajpjC1HPpRLzV8mrrfoPQ9x/EaiP1eaMcmc2/R/ZtQyEddhKMq7oBoYM6hgS3bW/Mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH/ZM3YO1sbk9Mi5qTuGQ8Iv65YFPwiMXdFKQw4Cczg=;
 b=HVyjyYCgrjQy88bHMdnkP9naD2q7JwxDMz6hw3SrUzkiP6o09G4vnITuO25UUZZxGKXXb/2cmOi+A5jg7srbEu8fW/GuwPUZ9IN0rMpTkpVwwsnc2OstiZOkivNouiL/Y2KHdIBFstnA9jkPjybS7d1iU3AX6DXKh5OSm2dWJErxlXfg49BLvj4nQ7Wx62iS4E2szkpfskTo3PsvoAwuN8KJDfNU/lj7eHKs0bLZtnf4LHp6OxTQa5XX9NJbIKabdnYgTmIDAuyjEvCMNzyWjsCf6zGWrh5K6S4KEpz6s9QjfpAxL9MItd0Nbe55WwcoMpmfMfQwsi9GOiZrCn1s+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:09 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 11/11] riscv: dovetail: add core support
Date: Fri, 17 Apr 2026 23:01:54 +0200
Message-ID: <20260417210154.2290819-12-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ac670-66fd-49f5-17b7-08de9cc49573
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	wrI+RL6aQmeCCTgwFJDMBtYRokSNwq/B6nempViDaYTq5Dqh/+FHL4lcOX27wNmqJFePfNedguj2KiQAHknLyUpi1qaLhZq5tMWWuk2/1Z5ght1r85OurtO+1IMwgiGALV/iQtR91LXnwirgQvPo7QHmH54YTarusvhvrqOVIZ+Kf4VrYVIx3bTndCK4UOT0HoslL6ydii4smKZUvPUSYso+JE9377l8vIQZNW7x59jCOl0fepx0aIq0RWIbmjhsR4EeSfT0BbJ2dtcJh6CkV2pjtQnJMJrgWLcLpmoe9rjJMhv3Pu47a+Ndg7CaIeYrzjrR8CdJ2qYlGzgQ/+jn0CEZXKQZJwVEOEBDCiGMfKHQ04aiv16PW+oMlhAvQyDVR/Wq636dmq/ofXjMmTUAXcuC91Xhj4ixDKutyaYVqyd/8yOJ2m8E8rDbqozaW39Eil7Pxjx97Aw6/jsuXPiV9pddgAZ7sRh/6MJUQZMnER+E/5Nhhy+2rrf7y8aRwNOW6HA1eeyLN2XUQ5QpGKqdGU4XipCp5TMDZ2HzVqKk5qN5gH5tsTp+8YfTaO3K+b3EcoVkVA606k4xdsAeCnGKrhg69JOHtDe9I3wPvsrlUp8oiBj0rcqCmMh8hCqvJntHy5m5p3Y/u8p1Z4RNr73/Q4CEMQBaLvJJCSVHhJ7xMhPwlRyREaOOFB3v1r8W4j2zSZ5NDr4M+4F0tsPt3O4wpeaiLhJrT1kPwgSNkf8Y/IE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWRci42D54cOJHbPlf9EJdE1H6tOB6EsVi07T9o9abogmeWjK48kOttyyaBi?=
 =?us-ascii?Q?5fy21kLmruJcINbBKrFfrVpfH0vtOF3Zh80nk7gJoqL3K09rmW/8QcuxKcJK?=
 =?us-ascii?Q?F7bCtmQq2Qi7WtW9xUxrdzp23u4/R0Fpra/PL6ifjXO5bFJyi5cu8hsU0kxj?=
 =?us-ascii?Q?yu/5xiOkT9OsAAg39wv/yyTnE4oYoe/FcHLe4MKz25FWVw92fFWPk0xOEh5U?=
 =?us-ascii?Q?ZM/uGIJascA/zBR7k4YMYjrKvb7vh1I3+kUfTOqYmT90Lshh/FWHA/4AQbRj?=
 =?us-ascii?Q?BtZQFTayknu/A9cekhR0X2KSGc6ua5Nr6ImVRPPwx6izb1lmu7M/wY2mtwmg?=
 =?us-ascii?Q?Y/65n71njDXphkqJthWRDihlItAOkZoiC+/sbZw3+tyKcKSmXPlylK2P+ZN6?=
 =?us-ascii?Q?sWfsYQcx+Dui+OwQoV7VkFYHck99n0JzleG5J4G6sBrFjwnpWBT/n2LQABts?=
 =?us-ascii?Q?FnweORt2UNyyHyzM7No9DtsI4zBwhyWfVwoTLekzUt3rGvSya7w3BlbsMfqj?=
 =?us-ascii?Q?LBn+B/M6CC3g09fYLNo1Wc4ROSovf3lsBxYPWgIIHQoTZsQLUdSTpBvlPyck?=
 =?us-ascii?Q?MfDp8mCR6Z9+Tsuu3LK35Xqo3eCG2Lkom5rqOiiz5GCEmfQMK0GEKTjp/9ES?=
 =?us-ascii?Q?Jbggkbllb0ZtM+ySBmWfOH8JQa/Kkr3IOM3dzXnC8c3hzbEuTtdZmZUEqvoV?=
 =?us-ascii?Q?hddDPHNdN50rL/HogxQkaXTcVhV4yoRT/gof1iXMZrmZaA7sV2zh8yCM3drl?=
 =?us-ascii?Q?DUr1bM3SrhAFrmSUxqZtkBZcJsVDpNavFX/vs6v+xSRyS1Dhw6UpO94H9ESi?=
 =?us-ascii?Q?R6+lcRyoJ7gtH6Cvgqxzkof7u8INeZXpTgpcolCOi4Nht2CVj/lRfYYNRtKm?=
 =?us-ascii?Q?IYD1vhPjDdWby+gubD4rqicivqqNDTjq4qtR+aS+LIr9AcR73p4GV+ICwD40?=
 =?us-ascii?Q?mo9JIZyEFvaBoVmpHlrMMdTKP0JvJ285grdH7bU9ZCnqFBfEBNdQL26QwRd9?=
 =?us-ascii?Q?2JOcZYhPwgznxOooJFjyqqu8Tmww+DNA6WPQ8qPyaLPplDoDJhS7kZQFGZFo?=
 =?us-ascii?Q?r1yTmgnsPdeXVopH6TCVhOq1E1MOezr8YLIZSG9oABpVqkXxkwRxSWd1t42o?=
 =?us-ascii?Q?Ia5TzHIWSy3ORKljSU7cdMz8nC3T+g85Ct2bSUvOMCBRXhGcatUQ3el/lHnO?=
 =?us-ascii?Q?QHqw82Hagz+i3QhifqhIdXW5wMbyE+xkC7kdZIp9C6MWDaa691twCxzc3vvR?=
 =?us-ascii?Q?ysQhSuB91VMEGHvB485XifDRKLa352qHJvFRQtcAoabEZz3ulO1IdQIY8ZEm?=
 =?us-ascii?Q?SyxZABikhyHU4Nb/jEv+Y72+CBQo10qxyaeH/QDCsjVkS3Zey/hZU92SCiS/?=
 =?us-ascii?Q?SA82uzQ+nSQGisnsuQS8fntxRyxbvC1zrqBSIILWd7a0KnmXu8aiCGzaxfu/?=
 =?us-ascii?Q?A4Xy2gpOpiR0Kuor8egw/oQqMNadi7myC71Pq///YXI5eyQXqbsgJJVkcdIT?=
 =?us-ascii?Q?dHuT6Qvjstu84EVDssb3/Jq87SwcfkObg2G8BkqV75c7buextoFjsmvEhcUQ?=
 =?us-ascii?Q?K3I0o7pW0zF6Z3Rk1LKrvAICyhvHepmkTTtebT3Qc8ir2eJkc5ZRTLuDGauK?=
 =?us-ascii?Q?VPey1R98kAbQDHkoCWImFBasfUm1YXq8AG1KufQgshiBwLYI0r71CY+hVk7t?=
 =?us-ascii?Q?O/1StN4g7qwyqhHXHSlEBWpjqktNicsPKIa0dKqf8kXtsRJX1dmA0LxVHBhQ?=
 =?us-ascii?Q?lqSKmbWfMvBrpqP2rlkdZao+9kr8RhY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ac670-66fd-49f5-17b7-08de9cc49573
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:06.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOe0VCN00TgC04qDLm50IMGPQhAeNJ+EY/lyQdIMaIjaqOBqCTC7loUtsvWC4o2YEqErqDKpxK0NS74H5UcD4JEF5e09NcOD2ZkQJdJ0ilY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

Add Dovetail co-kernel support for RISC-V, including, irq pipeline
integration, out-of-band aware trap handling and memory management.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |   2 +
 arch/riscv/include/asm/dovetail.h    |  23 ++++++
 arch/riscv/include/asm/mmu_context.h |   2 +
 arch/riscv/include/asm/syscall.h     |   6 ++
 arch/riscv/include/asm/thread_info.h |   8 +++
 arch/riscv/kernel/traps.c            | 102 ++++++++++++++++++++++-----
 arch/riscv/mm/context.c              |  20 +++++-
 arch/riscv/mm/fault.c                |  28 +++++---
 8 files changed, 161 insertions(+), 30 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0d8291a6c4da5..70ea8457e1f66 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -151,6 +151,7 @@ config RISCV
 	select HAVE_ARCH_USERFAULTFD_WP if 64BIT && MMU && USERFAULTFD && RISCV_ISA_SVRSW60T59B
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_IRQ_PIPELINE
+	select HAVE_DOVETAIL
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
@@ -379,6 +380,7 @@ config AS_HAS_OPTION_ARCH
 
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
+source "kernel/Kconfig.dovetail"
 
 menu "Platform type"
 
diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
new file mode 100644
index 0000000000000..ac08db99f4e92
--- /dev/null
+++ b/arch/riscv/include/asm/dovetail.h
@@ -0,0 +1,23 @@
+/*
+* SPDX-License-Identifier: GPL-2.0
+*
+* Copyright (C) 2024-2026 Tobias Schaffner
+*/
+#ifndef _ASM_RISCV_DOVETAIL_H
+#define _ASM_RISCV_DOVETAIL_H
+
+#if !defined(__ASSEMBLY__)
+#ifdef CONFIG_DOVETAIL
+
+static inline void arch_dovetail_exec_prepare(void)
+{ }
+
+static inline void arch_dovetail_switch_prepare(bool leave_inband)
+{ }
+
+static inline void arch_dovetail_switch_finish(bool enter_inband)
+{ }
+
+#endif /* CONFIG_DOVETAIL */
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASM_RISCV_DOVETAIL_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index dbf27a78df6c8..a1ac9192d51c8 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -15,6 +15,8 @@
 
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
+void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	struct task_struct *task);
 
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 8067e666a4ca6..12376b54268e0 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -117,6 +117,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 	return false;
 }
 
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
+{
+	return regs->orig_a0;
+}
+
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
 asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 8a9e85c6e6316..8153a4f263638 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -41,6 +41,7 @@
 
 #include <asm/processor.h>
 #include <asm/csr.h>
+#include <dovetail/thread_info.h>
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -80,6 +81,7 @@ struct thread_info {
 #ifdef CONFIG_RISCV_USER_CFI
 	struct cfi_state	user_cfi_state;
 #endif
+	struct oob_thread_state oob_state;      /* co-kernel thread state */
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
@@ -123,6 +125,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #include <asm-generic/thread_info_tif.h>
 
+#define TIF_MAYDAY			14      /* emergency trap pending */
+#define _TIF_MAYDAY			(1 << TIF_MAYDAY)
+
 #define TIF_32BIT			16	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to user */
 
@@ -132,5 +137,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
  * Local (synchronous) thread flags.
  */
 #define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 99634104ce084..0a564ea45eb99 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -115,26 +115,47 @@ void die(struct pt_regs *regs, const char *str)
 static __always_inline
 bool mark_trap_entry(int signo, struct pt_regs *regs)
 {
+	oob_trap_notify(signo, regs);
+
 	if (likely(running_inband())) {
 		hard_cond_local_irq_enable();
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
@@ -147,6 +168,14 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
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
@@ -157,7 +186,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs)) {
-		do_trap(regs, signo, code, addr);
+		do_trap_raw(regs, signo, code, addr);
 	} else {
 		/*
 		 * Dovetail: If we trapped from kernel space, either
@@ -175,34 +204,43 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)					\
+#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
 	if (user_mode(regs)) {							\
+		if(!mark_trap_entry(trapnr, regs))				\
+			return;							\
 		irqentry_enter_from_user_mode(regs);				\
 		local_irq_enable();						\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		local_irq_disable();						\
 		irqentry_exit_to_user_mode(regs);				\
+		mark_trap_exit(trapnr, regs);					\
 	} else {								\
+		if(!mark_trap_entry_raw(trapnr, regs))				\
+			return;							\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
+		mark_trap_exit_raw(trapnr, regs);				\
 	}									\
 }
 
 DO_ERROR_INFO(do_trap_unknown,
-	SIGILL, ILL_ILLTRP, "unknown exception");
+	SIGILL, ILL_ILLTRP, "unknown exception", regs->cause);
 DO_ERROR_INFO(do_trap_insn_misaligned,
-	SIGBUS, BUS_ADRALN, "instruction address misaligned");
+	SIGBUS, BUS_ADRALN, "instruction address misaligned", EXC_INST_MISALIGNED);
 DO_ERROR_INFO(do_trap_insn_fault,
-	SIGSEGV, SEGV_ACCERR, "instruction access fault");
+	SIGSEGV, SEGV_ACCERR, "instruction access fault", EXC_INST_ACCESS);
 
 asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
 	if (user_mode(regs)) {
+		if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
+			return;
+
 		irqentry_enter_from_user_mode(regs);
 		hard_local_irq_enable();
 
@@ -216,18 +254,25 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
+
+		mark_trap_exit(EXC_INST_ILLEGAL, regs);
 	} else {
+		if(!mark_trap_entry_raw(EXC_INST_ILLEGAL, regs))
+			return;
+
 		irqentry_state_t state = irqentry_nmi_enter(regs);
 
 		do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 			      "Oops - illegal instruction");
 
 		irqentry_nmi_exit(regs, state);
+
+		mark_trap_exit_raw(EXC_INST_ILLEGAL, regs);
 	}
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
 
 enum misaligned_access_type {
 	MISALIGNED_STORE,
@@ -247,14 +292,21 @@ static const struct {
 	},
 };
 
-static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
+static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type,
+			       int trapnr)
 {
 	irqentry_state_t state;
 
 	if (user_mode(regs)) {
+		if(!mark_trap_entry(trapnr, regs))
+			return;
+
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
 	} else {
+		if(!mark_trap_entry_raw(trapnr, regs))
+			return;
+
 		state = irqentry_nmi_enter(regs);
 	}
 
@@ -265,27 +317,29 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 	if (user_mode(regs)) {
 		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
+		mark_trap_exit(trapnr, regs);
 	} else {
 		irqentry_nmi_exit(regs, state);
+		mark_trap_exit_raw(trapnr, regs);
 	}
 }
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
-	do_trap_misaligned(regs, MISALIGNED_LOAD);
+	do_trap_misaligned(regs, MISALIGNED_LOAD, EXC_LOAD_MISALIGNED);
 }
 
 asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
-	do_trap_misaligned(regs, MISALIGNED_STORE);
+	do_trap_misaligned(regs, MISALIGNED_STORE, EXC_STORE_MISALIGNED);
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
@@ -337,6 +391,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		hard_local_irq_enable();
@@ -353,6 +410,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
@@ -369,6 +428,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
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
 
 		if (syscall >= 0 && syscall < NR_syscalls) {
@@ -388,6 +456,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 */
 		choose_random_kstack_offset(get_random_u16());
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -397,7 +466,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
-
 }
 
 #define CFI_TVAL_FCFI_CODE	2
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 55c20ad1f7444..8f38b4a5eb262 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -25,7 +25,7 @@ static unsigned long num_asids;
 
 static atomic_long_t current_version;
 
-static DEFINE_RAW_SPINLOCK(context_lock);
+static DEFINE_HARD_SPINLOCK(context_lock);
 static cpumask_t context_tlb_flush_pending;
 static unsigned long *context_asid_map;
 
@@ -315,7 +315,7 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
 #endif
 }
 
-void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+static void do_switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task)
 {
 	unsigned int cpu;
@@ -336,3 +336,19 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	flush_icache_deferred(next, cpu, task);
 }
+
+void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+	struct task_struct *task)
+{
+	unsigned long flags;
+
+	protect_inband_mm(flags);
+	do_switch_mm(prev, next, task);
+	unprotect_inband_mm(flags);
+}
+
+void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	struct task_struct *task)
+{
+	do_switch_mm(prev, next, task);
+}
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 885e2f66515e3..32cb7285d6db8 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -7,6 +7,7 @@
  */
 
 
+#include <linux/preempt.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -315,8 +316,12 @@ void handle_page_fault(struct pt_regs *regs)
 		return;
 	}
 
+	oob_trap_notify(cause, regs);
+	if (!running_inband())
+		goto out;
+
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (!regs_irqs_disabled(regs) && running_inband())
+	if (!regs_irqs_disabled(regs))
 		local_irq_enable_full();
 
 	/*
@@ -326,7 +331,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(faulthandler_disabled() || !mm)) {
 		tsk->thread.bad_cause = cause;
 		no_context(regs, addr);
-		return;
+		goto out;
 	}
 
 	if (user_mode(regs))
@@ -334,7 +339,7 @@ void handle_page_fault(struct pt_regs *regs)
 
 	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM))) {
 		if (fixup_exception(regs))
-			return;
+			goto out;
 
 		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
 	}
@@ -357,7 +362,7 @@ void handle_page_fault(struct pt_regs *regs)
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
-		return;
+		goto out;
 	}
 
 	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
@@ -375,7 +380,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 lock_mmap:
 
@@ -384,7 +389,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(!vma)) {
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -396,7 +401,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(access_error(cause, vma))) {
 		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -414,12 +419,12 @@ void handle_page_fault(struct pt_regs *regs)
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
@@ -438,7 +443,8 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
-		return;
 	}
-	return;
+
+out:
+	oob_trap_unwind(cause, regs);
 }
-- 
2.43.0

