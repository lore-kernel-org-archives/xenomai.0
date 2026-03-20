Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3623BD23C
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042644; cv=fail; b=la86TAK19AaRtDDV+f/iIoQ0dlrGhSRxOaSAZPoTl7BM+5skjaJj/T8y+w+9BQa0aJGxEg7ZRWGSQlw3WYpg/ukq7TTEjGmmmMj/GVhjonwhq7sUccPQIOtz3HQWvSdL9wLTZnzWHsezGaFbTRWR57PzMXFmzhUya1ROctnyavg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042644; c=relaxed/simple;
	bh=hIq/fLyLJVWNwD20kMq2U185eO7Fetg6ODwJE6BXerE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCWmap2nrCJBBFAUUl1TSu+A1FLyeHjimkNGgX99tkotqB0/AndXnT1Dr/G59aZReuOniXtIbwuTHLsneLbMf0BZ9J46bH0JEX76xTTwragpMp/V6bOkftNWBF43l3kt7UekgADzfTaXsLuykKU0xbyroBBEGpYMO3RJD+e0Plo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=su1cMyPw; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="su1cMyPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJJJflPMP/ciEDfzWSEp7Rg5EiYRvAWCHCTzY/ZMsbFX5MdD1PZrpEc6gXe7t2eUi8daVEjtPj48Utzp7nYd4Zk+5W/zbS61L7TgON0XqOSrSDYJh+iXudGp3jjCSLVAcQhVvDcHiol0LqC0Nnfa8aLRNU8PldSUfRVFEgMD6voYrSwCJcNqi8Jmsa4dqgmOXitA6ehyHj0QzVgkN2mRBWKyLf+E6Sj2PQ7+nL+CP8OmmUEnzqWKRRRuzWbNxnUZk9rYyGpoQaqz2gu0QI+UH4j5QUWnN9ZZUb5yO4eA1ZCRDr+5zX2/eQfbF0FbaP3Kf34qA5+Hv0TLiZravMboTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xem2zOMVWFJ7mjsB9pHvnoylWMIt1xU3jB0XOWQWE9o=;
 b=CIPYajr0VMGEQ4/8UbIRsIRjHeUdrX6w6lb9hbp98z35LjF6XqAuUt8wQaHQ1FIcpTSXLtxcm6aewMko42t2QdmTKZPeRu/WOHFlxv7LflIW30Byn1FyMqFBJR7h+EIE/EpoYGcPMiB07Ovgx3gwS2ka9QvAzYn0vPS7mHAevGrsE4o/tsQs0wSWuJLmGutxwH+dySdIR/WxUNpesIQJjtgQQOm7rVDWbP7NDYitcTB9M5bxjkaIyvMr/pDsDVzRSsbtUuCNwYAZ/DXxXVwnQRluzJEh+PH2rQR2Jl32gufU5BmV4P2vIzqNKO85NiiI5XLoHGYqMDB0uJ7qjbosjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xem2zOMVWFJ7mjsB9pHvnoylWMIt1xU3jB0XOWQWE9o=;
 b=su1cMyPwVSzd0Mp/NC6+HACnqjozcUkWURGFxKn+7bafsCUcyw7lvrtiIBVDRMogt/zKmrczYYjMjIANOBB/Xp5zdfVWzGDhCniSKQe1g0sj/PlqDCApKClUzSaJ9/6N48YBEpkUgKg6Okjh2ql3aN9yKlvEvTJ/f2JFPx3SCsa0lz911lZ0AbI4SikmYxVrNRxReMS8r+PkUpaUnOsqeYn2L5Va9P5WIRvUBV5Sx0PEb3ymIWddzSgqmmouMOLWieuXILNbkxbXu3APCFSLsozM2tHLKyKNguwr9jI1qGtcMXDT75tCPBNK2+VSqVfrX1EVukz90nRvAKLcVn2+jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 12/12] riscv: dovetail: add core support
Date: Fri, 20 Mar 2026 22:36:57 +0100
Message-ID: <20260320213657.2210419-13-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
References: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cc7216-a35d-4332-2251-08de86c8d990
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	izLOxPjoCOYS3iVoVl8nPWLJKOtvKn302UKvLQqnZEzwAGW5UgwTHOwtAs+T1iAOnMagtGr3vUlGmwBfDRU+hmZ9BhTGOYun+W+rL1nfUWf+5NQUVkUZErNN56QGNJQ4QCFjV+oWUqqkMCmTzWVRNUQhjHjTr6nrtp8W+dM5ofR7q8H0DyeP3ijz6KVSfV0nAXr+8022JshsIOh/+DJKwJKgga2pyPxjWpW0QSGdon99kZlEU/o9AMdpSkmM23QN8jn3jupF9/Q3lA8kWMvP3PNRQC5jdOldsqrC9dbg8tGkwnKA/2IHWaGH0xQ2idVz36zr/s+rK6lMn157MJGgo1CE89PD2hgVm5eczZT+iyRPjwZWUIldZ+T0N/hpYY82bxrGaRd+Kb8ZmeFX1+o92Ek3fenR2yVXTUKMz9+4mWo49QY68tnQUUsHJTrHAzhI8ez7+jhuMwu186A6Hczp/431eJWcH0C1AURKGUsew8UinGw6ovqH0aYeWqt4eXcs4IFEupFdUzbkFJbnNLAtB05TDryQpzDoc3mnaZ2zG/SzHJ4+D+c6M2VjY9WpJ5z6CoSKXdPSdZ0pVXf4n52D11t4Aa7JL9qiji5V5pkqEUGKcKBaji2U+tTDMrwkBFnnZT2niRlMPFwZpEN7ByGfAHFKgyapPdG6f6Am5/P1AoP6zmEHUFusn5xpK1dZ2KY4WTinLKuZAWNSGX9sIKrJkEHAC35hxiMqMGQTRePIlhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcT2WB+xDDsBX98CIjXYhWTFNEsAUABrEM874f6hzpLah5wOAq1pBLOZC52D?=
 =?us-ascii?Q?IZkRuPYhKWMVbAWTUeg8Rhs5Ho9tvAR8Ks6ioZ5J9pr+goMvS6A6kbP2FuVc?=
 =?us-ascii?Q?9vXM9uXinnhs+1mipn3q7iBOU9s9UuR+hacYEaRgIcmyPrDI+I28NuwiFujf?=
 =?us-ascii?Q?hBzS91iUyzL+lNY5BpHPOvRIFrZd2zlWvHgQczXd0yyxqCL/MiRJCCYICPy8?=
 =?us-ascii?Q?5pRTx6XklVuzSGXNF2tIqDLI2pO6GV7ihfZWIf+1esrm7GUTSBPa+nIixSE4?=
 =?us-ascii?Q?rTrrK71JtHHtVvRM/SelBKC6I9yDxPmOrvwQYjGlvgX9/7xq2MphsytDq3xa?=
 =?us-ascii?Q?OS2QkgaAdcG3Ybn70G8NgdN9XjLndSys02UNS5lL+r0AYCFGuL64P86qbqgz?=
 =?us-ascii?Q?6Jqxziei2UW16IyaSleSd/kSxTdmFV4dSawFI1h8FTItXtF34SkJtqIAM1RS?=
 =?us-ascii?Q?QDkjjQ3s2tdzIaAxoh+Az6+siNXe6bxuBgkjvfyolp9OP/n0RdnGrVYk7nhS?=
 =?us-ascii?Q?j2kSH3vBLJjFAAHIRyoDKi8PBfOEa6S22PWY+n5StYuH8tehPPkXJiJZaRhl?=
 =?us-ascii?Q?Ypw/EGI5bf7gBOH481xi9I2AmP9UIV1WL9Gkj4HGLnD8P16P0bhUV2POur/D?=
 =?us-ascii?Q?FUNn/SrtdNlyXb4lNx4hi/SDrlPcaELnMc7gPz4cqV4SeBT6V8wzpfLN9d2+?=
 =?us-ascii?Q?hr2jZPuTHs+MaHKcw5IqDGOdaPXw03qhm7eQxQngNQoQZJLlj5i/yj6C4q4q?=
 =?us-ascii?Q?Ve57BQuvvNkzdr13aRMCrmQ0nzorU/XUXdCgvieL3xMp43ZCEFwimOFwFgF4?=
 =?us-ascii?Q?/GSen6Cm0PqiF2ck4Zq9p5uL3CgbgfozqJez6nhpqHJVEELYt/UzKTGS6lTy?=
 =?us-ascii?Q?F6njFLxmjJaJvOZ1fQuBApVaVQeMgGea5MIfmlHd9mQ3X+ghPjGM16fLv9zI?=
 =?us-ascii?Q?pozy2SDisJ/LsPC04q7ZMdP/Z9d81+oSzgQ5sHxhKzYMaCIbGAsqoSzYHf96?=
 =?us-ascii?Q?JsZOBgMp+wYIUmSLDU6IPXQYAun+NcyOAE4Ts3d/jwTUx+91INU4um6aKKXA?=
 =?us-ascii?Q?JNnFWHoMeofMMNSldlM77ED7p4gOeQ+5kgRXdoav4g08WV8+e5C/mAsJrDa8?=
 =?us-ascii?Q?X9rU887wxRTS/ZBku1EIaD5Fhml22XyRCnuHoELHr33inZ/7Xcw+/m+vEZr4?=
 =?us-ascii?Q?3c6a0/zGLqJ3bpqJQXytDmAK37IqwtceNii0Kif7tnsFa4K/kXTZ7d4fRz+6?=
 =?us-ascii?Q?C46ZEZY2+cELM+VK+K6ucbmkjltBsSs9N1VV23m1eh78qIExT1vxr/ViaeCO?=
 =?us-ascii?Q?1Ed2T3l6mEZKdYLyllEcd0LFTXw9jEzOz/GSZZv6HchnunZf0B3VW2Z9h4Qc?=
 =?us-ascii?Q?08lua1hn0C7JfMC7MJ2NiVudG9QSaFC6awsQhVc60pXC4LWiTYWgkT2eqWpR?=
 =?us-ascii?Q?sUhsqg7tTPDm8AJNzLd+jWfw7dwb1DiGwt8xIU1ATTRc7tc2sBWMQlVAmgqs?=
 =?us-ascii?Q?Kq+/24dzJ8Kq1RlLcS8DQGmjYK4UxaoBSF5cal1fg3UpokRzTG3od3SBlA7c?=
 =?us-ascii?Q?8EkB+jfbnbuiR9MUUahPjChQZpvYKuVd1DnaW/z1tQp0fO6x0PjxdNCtQP17?=
 =?us-ascii?Q?nitfaVYr5Kgly3DS8oXiQUJeeBMvu23cpuTk6TpjHThvH32oQwphLyfnKATD?=
 =?us-ascii?Q?VIZ691DZ0HXIAKdhXpr5itSLmV0UFMhMPEuT7SXjYalQfglvC3+UIL9M1khN?=
 =?us-ascii?Q?fTZkIjA91pjieNBeFk9lusyefKdV7Cg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cc7216-a35d-4332-2251-08de86c8d990
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:13.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6g93M7pHJHczzV+mxGe7asO1HWBYbmt+zwBk7JZXk5nCyjfsjI9Xa+sGJoCW5OmzYPFbpXHbmVnll7XkvOlD3t4Yvz8w8ZMU/4atLy0ZyPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Add Dovetail co-kernel support for RISC-V, including, irq pipeline
integration, out-of-band aware trap handling and memory management.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |  2 +
 arch/riscv/include/asm/dovetail.h    | 23 +++++++
 arch/riscv/include/asm/mmu_context.h |  2 +
 arch/riscv/include/asm/syscall.h     |  6 ++
 arch/riscv/include/asm/thread_info.h |  8 +++
 arch/riscv/kernel/traps.c            | 92 +++++++++++++++++++++++-----
 arch/riscv/mm/cacheflush.c           |  5 +-
 arch/riscv/mm/context.c              | 20 +++++-
 arch/riscv/mm/fault.c                | 28 +++++----
 9 files changed, 154 insertions(+), 32 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0d8291a6c4da..70ea8457e1f6 100644
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
index 000000000000..ac08db99f4e9
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
index 8a9e85c6e631..8153a4f26363 100644
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
index 5b84e1ff0eeb..2980ec3faa22 100644
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
@@ -175,9 +204,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
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
 		local_irq_enable();						\
@@ -189,19 +221,24 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
+										\
+	mark_trap_exit(trapnr, regs);						\
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
 
+	if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -231,10 +268,11 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 		irqentry_nmi_exit(regs, state);
 	}
+	mark_trap_exit(EXC_INST_ILLEGAL, regs);
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
 
 enum misaligned_access_type {
 	MISALIGNED_STORE,
@@ -254,10 +292,14 @@ static const struct {
 	},
 };
 
-static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
+static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type,
+			       int trapnr)
 {
 	irqentry_state_t state;
 
+	if(!mark_trap_entry(trapnr, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
@@ -275,24 +317,26 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 	} else {
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit(trapnr, regs);
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
@@ -344,6 +388,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -367,6 +414,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
@@ -383,6 +432,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
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
@@ -402,6 +460,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 */
 		choose_random_kstack_offset(get_random_u16());
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -411,7 +470,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
-
 }
 
 #define CFI_TVAL_FCFI_CODE	2
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index d83a612464f6..762139b0ebb7 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -58,8 +58,9 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 {
 	unsigned int cpu;
 	cpumask_t others, *mask;
+	unsigned long flags;
 
-	preempt_disable();
+	flags = hard_preempt_disable();
 
 	/* Mark every hart's icache as needing a flush for this MM. */
 	mask = &mm->context.icache_stale_mask;
@@ -91,7 +92,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
 	}
 
-	preempt_enable();
+	hard_preempt_enable(flags);
 }
 
 #endif /* CONFIG_SMP */
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

