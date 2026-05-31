Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1631ED81
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206808; cv=fail; b=pHEcmA8XAZ3yte/OYXK4nC9gNw9sxLbdS+Bu8Oy1umPCXQLjaIU9k+CgIz0kf/oLelMV/4qt9d+l4YzNJmqURGDTn8D9IXyUXjojmgbeip0X1rqsF4E0Gb4YW3BX7xcNAwoUtIlG+jX0aD0haNe/r1B/s9ShcfI/GYXbZcaB0VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206808; c=relaxed/simple;
	bh=X87S9De/PeMefyzmczTU3/KenJIPEbPio3XIJN6ALWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNoy1tB46AqbY2iedg+3AKmYQ06QBWnrAdh8WoI7B0/8FmzHRb6+4n2iLoDg3TzxxKYGJYjW9hnLUZsBaUNKfW5e8lswSec3wzkQYY4lIPZlG15AEXhf9TqysPDH7XF/zYlDMD40wPRiSdHL19xnhSlc5Slw1gMrovSrIDo0cT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VRv2v8V0; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VRv2v8V0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMm1KwSMXT0qEgoDOs4BTTwZULug/sU4X9HFxdvmXBBvHfQt9bQn0LciBZC/5cwU8MFpiIsUi3HKVjtlm60oZ/H2jWi7Mh1KxFzOVGKtwmpJAazv+CWwMrcbiYcEWKoDfWv7ZsSY99EkuDHB3udH7lk9MrqIJbRXEwdZf8W9YURqkLeprem6UKoPRXxHTPsWXgJVse6aY1H6RL81odD6gYGzyLVapulfuzLsBpYpxjSeHROu/ApvaK2ugxGWBaExCgq2R2OkXHiIqEoTVZh41+q+1yCX3DWofAvgLYM9UkACTbzE83nwgxR4FdT0Irc2i0slgp0WS66g2qMu/vqqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS7ctKmMJLSDxm2P7pAFYZTAM3WctSKsxaGVtgvgA+s=;
 b=agoP7IdX2m4GTfVx3ZssVQeKXfRD4NucOZ/yipUD+VAtOuI3RVDIlz6iSLjIWaEDUxOGsQec2wx9HQ7j+DR3S7rl2RzHbtGRwhk3h9jFwVoGEzKYnTem6C+MXUUg3zPj+Qm0yAqeCkfoK1VfVbvBY+xGLK5gEPuRImA5otyasDOD1ufEMc7zOg3DF3fj02IEr1iF5RzT3zN32XuOlqoizVwWbwSgMoNGTmttosnKq+rHTCUpMaCDkxTLDuUvbhQSsmSEEL0dLKNGLhkk4KoJvxDjuNOFDFK/uhjSuE6wcQwjwDmNu7rDqLQf2h8Eoas8xPiluWmF9QnG2s+eddIUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS7ctKmMJLSDxm2P7pAFYZTAM3WctSKsxaGVtgvgA+s=;
 b=VRv2v8V0+6A8TaDqlbZ++WhJjNb6pjO8Y8Y3kamb3usgBdk145uVWvrkb/tauNmA7llUiWWs6RehInIJXvXbXwyirDvKM6GPEzVS0xHrd5gVZYnv6sQV0AiTNsbbak3b5i42KZoq2nAcarYd81t81JKBctJbPeXtzCxfmTPkoUzn7JQ1deQ38zmEScI0l79uqvthhAoUgOF9AscwuP6VVGiG2yYitTP7NPnUBZ0RN7Z7b5q9DcRakeD8CH9pVXJPG0ah83vTOZAJ/E0rQgnK+789e44+RVqq35qUR7TM142kEO1txUM1bG5z7RcmtfSyv84TuBBmPkdX6qmJd7c1vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:17 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 11/11] riscv: dovetail: add core support
Date: Sun, 31 May 2026 07:53:04 +0200
Message-ID: <20260531055304.2890455-12-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2875ab-0909-40e2-7145-08debed8e975
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	0BD/wZiVW8UhvD0X3DQL/Lc25FZUaeu1vte4eMkj1bfYAE9PWQHc2r5FTbL/psKieOdTwW9DLHHplN0X4bmMR34zWG6GAyBMMuWBIdKX55oJbFYAV2GxgwVERUFgZatBqfnmWa1oOye2OP8xkG9AN0WQdSe6E49jFxuT+iOIL2miK1Q4+aervpF3akRwSN8s/jOuQC09Vak9aWHTlBqKr5Risb9LuLdaE40w+2wrrt3GC9avI8QmlC/W1yf0VzPFn5F388wblmIqpfCUanOB7gh3vBUyp9f35fQRnQn5o026KIVnpGf1wP3OkBDC6IbqfiOz9WvKiKYnzq0HhZcQIJvv7E/ILz4CmtIO5DQqUjLfo6HApD0GKOjlFYgenB82spBJ/QmNMkhI6p1+VAd9YxVG0+7uPw19fOabTBQeMYtS0tsgjTZRKzkWBBJdfbhmYROhYVxiBmx8gLEBSVzzJP+uA+WxPoMyMMUPGh7Po3ubftAc32++VhNHWfcuDFSX2f3OWz/r08Fhv70pk3BQC7tOLdKNN/TSnn6ICVoTeVlM2rprB5kRCICEyvRb7LkwIAfMnd/Tsj7iAXMToK5jZU6y4mGZ1M3ViS9iZH3qqa1WQeQ7uLRK4jv0xOQjqgd75zLWzf9MCk8/F2JLh4RXpSG1W7wyncdkaspQ2EmAhamewXMC1X6e98HdJEshtPqc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?121hTFejFP8eEoiV1ub+j8J/9snZoBXf74/mMjSq3YSX0X0IRo4rGvqqKAuy?=
 =?us-ascii?Q?6z/UctPMxwtYvrVmArLSjp5zg3JVRHGrks03874XAySWwpfgbge3hxUmfDee?=
 =?us-ascii?Q?9cWyqSDcSf8WFoRCNc7QRPFtfsmL3qDryP3AFVVZ/U+pEkTe4pGqRAOOjDH1?=
 =?us-ascii?Q?gYyFLs1fx7gGCRWbhtZxhSKp8LrJoI9U7mfAufjWcZ3g8PsHYo9MHtIYGYaZ?=
 =?us-ascii?Q?JU/T9f4MFRKLgZ6HM9CIzbXR9ld56Paj+5yYt8JCB06bXB6tWmIMIEJpl/45?=
 =?us-ascii?Q?Q8l1VOddnzsuy1BnGLuHgg+gULrCnRYf9LPPCo29C0R47ZfEPzdCs0drKjeL?=
 =?us-ascii?Q?FGJHkeNK70czyetWmc1PZ1aIMr+KmjN+OqAMrc0OwosDjNreX2TCd2HXmykU?=
 =?us-ascii?Q?+HQpqV/33Ri/f8C7BAQK2lOck7I5tvLPqU0Z2ZRR1CrfLgUjUemOk6wBEKbU?=
 =?us-ascii?Q?/47eUPaKszDvMHX7xJp3ls09CSuP7cpLbgOzCZ7NklYe/i8JjwoSvIO7LV9g?=
 =?us-ascii?Q?2HP7JFAP9GKT39VXCQnDh78DuRV/bXbIoYCJbSoaWOmPZ8SQPaLd1yHvq2A3?=
 =?us-ascii?Q?i/STVJ/AkBAfSz2TV/dYmnFE45U7hQLmi9uR96UC0JLROEIbUuQkzWrper4h?=
 =?us-ascii?Q?aZ06nYo57OEoHWmXcxjxJK7Bd7fq/vsl6OK6yO8rAXWUyfyP79NjznrjDqqw?=
 =?us-ascii?Q?6MIyouWA1nQ2Hybkn34cZu7La2PkakxGhe9KaB3fUrmqs/LlTMVqFeUPwZqV?=
 =?us-ascii?Q?sqxyg2RyCtHbuNBiSNcWGbWdbrnYaCde/fS+J2qxucQ9v0IuUlcv57br5Oxg?=
 =?us-ascii?Q?ksPGEMzmIZWh1GakI/TfserYabz0BLHqtYY+leuirB90BmY6mqPXXPjkDJeh?=
 =?us-ascii?Q?q81d2uxj8InaArHpf7fkczimIWfx/V4baNfYTt5HsSzzgf5yPBdosyipzh4B?=
 =?us-ascii?Q?AA5l1vHl/Yca219DymTfhxuLUKosGN3V9pOe3ZHmnsf4U9nGhEcjHNDdG6lZ?=
 =?us-ascii?Q?6xk/4ll6Urfz372SE5q5Z3x2dIid2v38kbQrCuPTIKQo9s1afIAqIQIPgHYA?=
 =?us-ascii?Q?rcpxLrS2hLC/Y5n8ileOnSryibENmFfwEMZ1fpDB9T/3tCsTfPxR9dom5NB6?=
 =?us-ascii?Q?ol8Sz/KLdokeQTM4lafpguL3RIrpAUhBM5vJKOcWuozP5OKkBTt+/uRcJRnU?=
 =?us-ascii?Q?h/MSVGS9uAkLI401MCs4dpgu/iGiplUti6Dklav+G8CJCv1/MwcziwVkCKFN?=
 =?us-ascii?Q?oOEXETt5DyxcpQsIHHV/2TyV0+EvO+bBT3FuqYyp/9b+xrdvv/fP+sR4ijlf?=
 =?us-ascii?Q?XhVrvx2O9Upvf0ztNNrd7p4RnMbrJHQxpXCW6WVjkmPIqptohGgC+JBwyAsP?=
 =?us-ascii?Q?keNoLPNGIXPkqrGW3s7KoX4xiPPO1f8/B2PE+H5Ltjs6gyy0e+VSbL7HKGfu?=
 =?us-ascii?Q?MxgznFKCbwAmFVY59p2yPvAjA0v63wIVCQGDj++IxJ1p28PtHSTOEKsupHjA?=
 =?us-ascii?Q?o3ksTStZCHelKVVWBZLr89nqye3uPk9uK/YAwWviPfpcX6EXm9rK4oI1lABn?=
 =?us-ascii?Q?zEEHbyNypKb6v0lz4ZZ2yZWP1+ouYWMKsVaAL/A7KhMzeQc0yv2Fbk4/91r1?=
 =?us-ascii?Q?0usny2V4MklgULys7IG2VKxR0nmJPZ2zFaoBA7XZCuaTiR+5PrlCV2YQ7BvI?=
 =?us-ascii?Q?/KQdJP+AR5UOwfD4M7sLJuDOe7XDDJVXTq2qw6ah0wbfr2wX81QkNyy5X9Xn?=
 =?us-ascii?Q?sI2aL2gD2j5GgB8/nOpXnunX41zHCFs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2875ab-0909-40e2-7145-08debed8e975
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:17.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhRActk4ulDJhXNg0dkG3T17Lzv8KtSJ2DcatNRM9x6m2z1fegh56j05HyNQmgpPdc3S7uQ/3As39ApzsOBSaM1y2rgCC6h+yRzNzR7VrjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

Add Dovetail co-kernel support for RISC-V, including, irq pipeline
integration, out-of-band aware trap handling and memory management.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |  2 ++
 arch/riscv/include/asm/dovetail.h    | 24 ++++++++++++++
 arch/riscv/include/asm/mmu_context.h |  2 ++
 arch/riscv/include/asm/syscall.h     |  6 ++++
 arch/riscv/include/asm/thread_info.h |  8 +++++
 arch/riscv/kernel/traps.c            | 48 +++++++++++++++++++++++++---
 arch/riscv/mm/context.c              | 20 ++++++++++--
 arch/riscv/mm/fault.c                | 28 +++++++++-------
 8 files changed, 120 insertions(+), 18 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7c58654c4ece..912aada80962 100644
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
@@ -376,6 +377,7 @@ config AS_HAS_OPTION_ARCH
 
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
+source "kernel/Kconfig.dovetail"
 
 menu "Platform type"
 
diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
new file mode 100644
index 000000000000..e5a46cf1f67f
--- /dev/null
+++ b/arch/riscv/include/asm/dovetail.h
@@ -0,0 +1,24 @@
+/*
+* SPDX-License-Identifier: GPL-2.0
+*
+* Copyright (C) 2024-2026 Siemens AG
+* Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
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
index dbf27a78df6c..a1ac9192d51c 100644
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
index 8067e666a4ca..12376b54268e 100644
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
index 8bfb02064f48..4934b7c8f1f1 100644
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
 #define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returning to user */
 
@@ -132,5 +137,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
  * Local (synchronous) thread flags.
  */
 #define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index a3f6dcc2eefa..32fcd33a1ed0 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -115,7 +115,10 @@ void die(struct pt_regs *regs, const char *str)
 static __always_inline
 bool mark_trap_entry(struct pt_regs *regs)
 {
+	oob_trap_notify(regs->cause, regs);
+
 	if (running_oob()) {
+		oob_trap_unwind(regs->cause, regs);
 		return false;
 	}
 
@@ -128,17 +131,16 @@ bool mark_trap_entry(struct pt_regs *regs)
 static __always_inline
 void mark_trap_exit(struct pt_regs *regs)
 {
+	oob_trap_unwind(regs->cause, regs);
+
 	if (user_mode(regs))
 		hard_cond_local_irq_disable();
 }
 
-void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
+static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (!mark_trap_entry(regs))
-		return;
-
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -150,6 +152,14 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+}
+
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
+{
+	if(!mark_trap_entry(regs))
+		return;
+
+	do_trap_raw(regs, signo, code, addr);
 
 	mark_trap_exit(regs);
 }
@@ -160,7 +170,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs)) {
-		do_trap(regs, signo, code, addr);
+		do_trap_raw(regs, signo, code, addr);
 	} else {
 		/*
 		 * Dovetail: If we trapped from kernel space, either
@@ -177,6 +187,8 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #define DO_ERROR_INFO(name, signo, code, str)					\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
+	if (!mark_trap_entry(regs))						\
+		return;								\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
 		local_irq_enable();						\
@@ -191,6 +203,7 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		if (!stalled)							\
 			unstall_inband_nocheck();				\
 	}									\
+	mark_trap_exit(regs);							\
 }
 
 DO_ERROR_INFO(do_trap_unknown,
@@ -206,6 +219,9 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 {
 	bool handled;
 
+	if (!mark_trap_entry(regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		unstall_inband_nocheck();
@@ -232,6 +248,8 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 		if (!stalled)
 			unstall_inband_nocheck();
 	}
+
+	mark_trap_exit(regs);
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
@@ -260,6 +278,9 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 	irqentry_state_t state;
 	int stalled;
 
+	if (!mark_trap_entry(regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
@@ -280,6 +301,8 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 		if (!stalled)
 			unstall_inband_nocheck();
 	}
+
+	mark_trap_exit(regs);
 }
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
@@ -349,6 +372,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if (!mark_trap_entry(regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		unstall_inband_nocheck();
@@ -370,6 +396,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 		if (!stalled)
 			unstall_inband_nocheck();
 	}
+
+	mark_trap_exit(regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
@@ -386,6 +414,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
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
@@ -393,6 +430,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 			syscall_handler(regs, syscall);
 		}
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		int stalled = test_and_stall_inband_nocheck();
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 55c20ad1f744..8f38b4a5eb26 100644
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
index 885e2f66515e..32cb7285d6db 100644
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

