Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337C322774
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432730; cv=fail; b=PGHsYNMkCl6PLesox823gGx2+gX9NMRJRVqesjWQZonkrjuz9rL6wXN0b66BaS2OJU5XJ/k0oYtXfIJIin2B0w3Wj3MOeaYKDknrEdOVec0VQlnKzmB0FVGeyyQgiqmlFBF7E0aDtRv75x/vOmOE5H17u8ySzK5MMNb6m63d050=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432730; c=relaxed/simple;
	bh=XveWj7b2ByD+A9MQZhCDmchpSWPp01/lg6eJktvpTlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2SDMFHBimbfZTk8zIR0j70I0yDF5M1w1aI77ye+JIjbWDQvZ3G5l0/Jbc68oiMBbBF8VNbsf8AuhIJdYFQtmNoe+Lpi2qLfGHaZnNHxCK6ZqJNHPs0+FVnjiCRUuAIpltvnPyc8IyYc5aA1ZwoTOTgji/jmlAzcpJaFae55iGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=L/VOsm/T; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="L/VOsm/T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtXmZ5bKGL11N+9/sL+BMwiFeiHY7Rtq+qKgCFHQimIWuz8JV0SqZ5L/wC/fzv0Vpps21Q+hyDBEefveH2HvI/pgLOE1pOMUOYUu86Zyv55iI3DRBvOTm3XefsNg2l0yIkep/f1XEmzEfv2L0KyLKs2mAO65TuPXPH7g0+6feFRrrLPCnMNdmg7O618Kt+zzd7t4rSXMEYgHxdo7FwWmZr5J43FwCF1UalT7krRVGajocVZTG8wk+Gz7mzlBcTlZByqbIKO9oqhnV9ehvFxniI2UTWO+zACuXB2NXOarwsJYC1GodoCXlbPhz1WLv2sJBp1/1p3z+fP6LWKrBTxtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6+A0ZOnM49YLIf484XT6SwR3+hzpK7UP9JmvDmMRDw=;
 b=Qn57wavHFH4upGIQpPAD8Wokrh+ffI58hhyCf0QTwkiU0xbYQmuTj34khRqitFvaW/rSxw4rvR086IMW4zU/BrBAK9LQCWs8cicFzIUJLjrhGWBzv3/v4nSxe2C8WFtOGiAhPyv4HVtl5l4e59og90Had3TF28+RHTOa6yiewsjgiil3s9iAGvOJmP4h+3sRJPIr08eRXkKBGgRM8UZcvHcd3w3xSf9hP3lGfQyPmlBHa3tgQ8uFq2C3LXq3GHj9x2Que65mvpkEbghAD+Baeuh08UQXZKsObvJLUOdhPdQW2+Bwj1W2O1zK7qHePWzXQL8LH0AMEyeMSdCHb0t3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6+A0ZOnM49YLIf484XT6SwR3+hzpK7UP9JmvDmMRDw=;
 b=L/VOsm/TCbJ3jew1yKtiR5sajt+zjIH12L1BjuB5Yyn/+ENl2ww42aF3hvnNX5A0bPgP6NLz4A58LMjEQRkYY3a/PGDkcsy3Y6pc6hmJeQ6h9ooSM+1s+S6LaIRm8ZfGi+jvUaeWQSDrToPzyCrMP249JE7LWZvz5GdEzHIcrURb1xyLaPnI25Q66KjbTsyAKenSnOS/qwNF+IlqTmtR74aVaEmjnkuNSbGiqwHgeXKEjbapHn+2xZY4ke/4vqXbcqAJvkOmcwneDPvq8UebUOR0U5h8XfjuYC7qpVxQael2kw6qGftryeETVedn21csO7QO86R9WuM8dSYQJntUIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV2PR10MB9614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:302::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 12:38:46 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:46 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 5/8] riscv: add initial dovetail co-kernel skeleton
Date: Thu,  6 Nov 2025 13:38:19 +0100
Message-ID: <20251106123822.1160385-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:610:b1::16) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV2PR10MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 415c7f0c-7763-4ed6-ceff-08de1d316d96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9F7OfMMqitoxvQMmFfQHALWPN1djWvPvLz+EtaZxU2tyzhdk0vj2YTyFOSzm?=
 =?us-ascii?Q?qFDxHq0FsCIWutEZJdzK0Pq0eAdEvVoA/LP2EWSKv5JEPec/cEBsS5oaNsrD?=
 =?us-ascii?Q?HUyTmHuT4oi+dmR8/2q9j0SUCx5CUmVSt55IUWmV8AIcIQRQBHFJTKyq9WQG?=
 =?us-ascii?Q?9v4FwlnxVSuYpyNG9ci4V1BvMf4e3LE46lSfaptz7xd/egPIbOUI+Ega/ReF?=
 =?us-ascii?Q?Sebrr6Dcs5oK95ckffQU1qf/JzxGXx0kLitKeGQhq5V5I/BywdPyR3/vpqWM?=
 =?us-ascii?Q?aBwVJ3rNSzZegWDF+q/hJ6IRDm/XkuWonaYoCsKwzKhaHfnkg5XFOOsD8aPq?=
 =?us-ascii?Q?We6Nkl39kyVbaXRuVyhEriRN4eujvngd119OZHdF7YOyNRYVHj6FVvpXFqHd?=
 =?us-ascii?Q?of40/WMszzy+ExUJo9wK+ugdNVnbzmNU43W44CAhfTftG57GDKqY+CjCoM8O?=
 =?us-ascii?Q?XRtlT4Oo1U8O/+sVs+itny3tFeVnlbPbR2rKKS2sMPWONKw0rdU6x2dRizOD?=
 =?us-ascii?Q?whO8LSknaLtifmFT5A2XgSZAN21ztBWH8pMghUPmyXVKIrix2nXEdR7E7IXM?=
 =?us-ascii?Q?WwiKfo2TQOC/OLZ6BJoF4wztnRoa/YVhoJVxHUDNSTTI+L0w6SAml3nukEbv?=
 =?us-ascii?Q?Dm5Xdub8o2NegQ5hITrPeiD/U9kcKW5FZ+ZMZQu/OiixQXn/sFCgzMZ+4IE5?=
 =?us-ascii?Q?vnO3SXyZXOrK5r2acO41g1M7kUfEle5lqSg7ECUa781JucCcnC4Z6UZW2Cai?=
 =?us-ascii?Q?+Jr/HJF2zDbW39K33mJ/cD+VqryDH8Vcui58zWoEH3Zf4iSbSuOJMLR4eIrC?=
 =?us-ascii?Q?1H2k4BXKXmxnUhxJLOpxaAT9MMrYS/CxSV0qCzACYHwrOybLnWPTa1R4uXDy?=
 =?us-ascii?Q?Fetf6oh32rTLdoGdE5tZ9i3YjoI3QNVamg5vZik131VTKHyFf2iORrLb1ben?=
 =?us-ascii?Q?JkXVBIsKhGwhx44VyvG1q1VGOOBrtkpIGPwJDrJxHuyBrTNx9fInVa7W/zxZ?=
 =?us-ascii?Q?wTWQhPjBJsczoOc+/Kp6OOAo3SSJpT7OwkR9JWR4EVTY/aoraT2s1Q0WWzis?=
 =?us-ascii?Q?P/EanTvLC0jfSY2Pzfhpimo7Qa4eTZw/GH1912j6OgvGZa/c6MnpWM7n+PTq?=
 =?us-ascii?Q?15gsawWOU4WQDH6RhBKKlYQ6yZu5X9pxSKQ7Bw1CuqZz/Xq4ddQ6C8g2GZsG?=
 =?us-ascii?Q?SG1myzHQ4tBFt5ppaGDniTs9kpzGCMf3F309JjVqfEi2zh0qTn4KWkWPOn6e?=
 =?us-ascii?Q?/jqkxyuyrsnJbCObnoqYz/LjV/OrODzr7VbhnSLI1VS84TobTyIu9hRs8Uqa?=
 =?us-ascii?Q?R292DmS01liwX2iG/qvgSbZ9x8A1Kk+LEfnRT6ZBYVlbtokI4CNuoXrVylPS?=
 =?us-ascii?Q?xxcEitnLtUSw7gYdNY/rmW2xOGtR0WqA+fK+F1N9Fc2xIey3RdvPNBv/Mo+4?=
 =?us-ascii?Q?T5jUcAHMvYEBGw8StXliqTWbpbmgWfrN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G29gl1UrPYphPV6c/hpaZAJsXBfBP5EkKuQHMR74b/mn+QuJUG6LhHR93OuI?=
 =?us-ascii?Q?BhtPCbWrxO9WvbckDxcxpUHbOCUoR7WSBZjet7UCfIT26nCylpzPrBEgH46U?=
 =?us-ascii?Q?LpbnFuGA9+MGPCyJ0IkOI6nWlxLNVB1uovcDp1Pq/osHWZbpVckEr+QAPj4d?=
 =?us-ascii?Q?LsdjWmxlsXrYu+qVwNNb7C9B+a+651zUcZ2/Na2FmxOl/4lKzXJZCrmUFqvg?=
 =?us-ascii?Q?KaSBlB2OF1YTJ7Jqif4qhIi3HeORvivyHxOcgobcwpK1bVlyjZIxDcDqSWzN?=
 =?us-ascii?Q?jh+ZwhYimaurjYB3Gl2F5WtYDaMcc9DnHAc//mcnN2Ouc7SVIcpJa/26rzYU?=
 =?us-ascii?Q?75CNN1KMjLykK8+FkSt9Lmd4DVoSbERUbydGUHhx7sgKCPHzrCUw9ozEQ7tx?=
 =?us-ascii?Q?r4N0DPWkMFXw4qKWcE3PxoEOb11tiJzAyt6XDDaBVeM36sLQs4SBzCuvRX63?=
 =?us-ascii?Q?UwcFLu+nDLWQG5fAGJ3twz899PlRlankxejkDoFKVXTJACoOBAzqsh6psfOd?=
 =?us-ascii?Q?/bYFxFxwBv8QkgcGFGHanCsCJQsta88NM1uVTU4q7dvwCyO1Ch087bySimyH?=
 =?us-ascii?Q?6B8xe1IJm22ebQi98Kbg7M+PBquwSHJMISbquI6DPGKCIgVu5Z8qGgWE6f+h?=
 =?us-ascii?Q?OAxWyYek7t3F9cFp0AMyfd/MsAjlMTqleZ8WS4aNyVVds1iWYLrhH2prozZv?=
 =?us-ascii?Q?BIN2ZezxDd++ySSNbW+gdjKV5WAAMBJE1iw9BrgfdGiG5oV97tavzt/7jxWG?=
 =?us-ascii?Q?MqQWdZmTF2eTqBWeKumYSv2fB0PdemudXDcE4ZtoQmQ58Xt9Uy89qtQZ37pP?=
 =?us-ascii?Q?voX4kmDan+lMiPBF0HefPt/GLxfbYrtuDwD9IfxqUF7edMmXGU9Vy8PzPCQo?=
 =?us-ascii?Q?PPhhu8cM+yswSFvLfec0VeylT8FQPPWvzl76bdPx/AnwC+RqdaaaFT90HjiX?=
 =?us-ascii?Q?7Ymcw8P6b82i/MzrOpFF/8evp148YL++B23DU3ornQlqjSzt848sWR3tSaL/?=
 =?us-ascii?Q?1X6iLyR8yEL0/Sob56ZgrHx9wfG13Q5wSEhLDFDAB0kfIhPFX2dXeP88DqmV?=
 =?us-ascii?Q?kLMkvqXeYR0uta2LvGBeWzQkXIpxHFkXLhysEN4fXGOeDCxBSkHnnBi5xnx3?=
 =?us-ascii?Q?c8LWiwYPXcJNvdV8kBb+s5Rdr7wpz08FYFZGMMsH7AcIVpx5tKtLBH4BtqsX?=
 =?us-ascii?Q?njCAxg6B6M6tJKRdf9KD0AmFK8+TchmFd68mfUGL0Uckm2TEbHR0Bo9oBMko?=
 =?us-ascii?Q?capg/we2oxP5GRH8CNQ8m8Ua+366MTtgpaUkxKQn+Kmazvq8GVq/SjapvfBV?=
 =?us-ascii?Q?/yXzOPZCOO1VkivvB5KAitLLNCxK+LL6KuasleG0NVzAGYOPH/cA23d0Ev4y?=
 =?us-ascii?Q?4f/PQLgvbWs68oaoLZrqnaQrmX5xIPLojlAjsqQMYjsMavMPNS1LJ5soHLQm?=
 =?us-ascii?Q?PkWGC4pW3rKYHZ7q20nMjHZpi+HWO7X2tZRK5wqQeYZWjX2DrtDiEr3g8+yo?=
 =?us-ascii?Q?oxpc+cp2vmbWKnBf8QlPgPFf88rybrSo6xkH92ygsJoQjRbk/UC08AOL7wV/?=
 =?us-ascii?Q?dj6dYmgEWq2DYJphJ8OdJMgUQd9y5LGhSpWQyad68BSw3ObLCixNuMyQGWml?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415c7f0c-7763-4ed6-ceff-08de1d316d96
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:46.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYnUba1ohr1C1puEF35qMINCDr8yYNpUIOSILbpBLbLKiBahZsxdOaW6VKar5y//bVXAZNgO+SvtkOFbPVbbW7H3y+kT+N0nFdUyEY3WQrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9614

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |  2 ++
 arch/riscv/include/asm/dovetail.h    | 23 +++++++++++++++++++++++
 arch/riscv/include/asm/mmu_context.h |  4 ++++
 arch/riscv/include/asm/syscall.h     |  6 ++++++
 arch/riscv/include/asm/thread_info.h |  9 +++++++++
 5 files changed, 44 insertions(+)
 create mode 100644 arch/riscv/include/asm/dovetail.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 19c5624b3ffb..5cc3df56a58c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -136,6 +136,7 @@ config RISCV
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_IRQ_PIPELINE
+	select HAVE_DOVETAIL
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
@@ -371,6 +372,7 @@ config AS_HAS_OPTION_ARCH
 
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
+source "kernel/Kconfig.dovetail"
 
 menu "Platform type"
 
diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
new file mode 100644
index 000000000000..bb342e9eb18a
--- /dev/null
+++ b/arch/riscv/include/asm/dovetail.h
@@ -0,0 +1,23 @@
+/*
+* SPDX-License-Identifier: GPL-2.0
+*
+* Copyright (C) 2024 Tobias Schaffner
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
index 7030837adc1a..acf3b8e20e27 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,6 +33,10 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
+static inline void
+switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	      struct task_struct *tsk) { }
+
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
 #include <asm-generic/mmu_context.h>
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 121fff429dce..0e02161280e6 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -95,6 +95,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
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
index 1c7a61a4292e..b8e0a5ea2fed 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -41,6 +41,7 @@
 
 #include <asm/processor.h>
 #include <asm/csr.h>
+#include <dovetail/thread_info.h>
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -77,6 +78,7 @@ struct thread_info {
 	 */
 	unsigned long		a0, a1, a2;
 #endif
+	struct oob_thread_state oob_state;      /* co-kernel thread state */
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
@@ -120,6 +122,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
+#define TIF_RETUSER		13      /* INBAND_TASK_RETUSER is pending */
+#define TIF_MAYDAY		14      /* emergency trap pending */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -127,10 +131,15 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
+#define _TIF_RETUSER		(1 << TIF_RETUSER)
+#define _TIF_MAYDAY		(1 << TIF_MAYDAY)
 
 /*
  * Local (synchronous) thread flags.
  */
 #define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
-- 
2.43.0

