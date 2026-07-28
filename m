Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061040D565
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237168; cv=fail; b=hiLOHDJisjsrkb9sovln4NwMg5vz4zXd9xNqgKEffenZed8UlslkJBScWychgpeiY2spW2Ca/riPTJ9luhdTymsiuzYqee2DYZiRgjMjB4IwToX1XcgqEIpT7IVmgg0sMiuTPEmhJP4GwPkq+dXt6VMx3Tkt15wv3T32arye1vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237168; c=relaxed/simple;
	bh=7IuT+G9rnIa47YMhmQYjHwZQLThDOrrwRWLugY5DVJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGAc19R6hs4iXPmlvjYyTF1PY6HutvNqicJ+ICsrnQoiTTB6JyZbFHyJFjPhWaq/9TKVWy1Dh9KRO/HcAvaRXSJ60Fi4PPlmjfWzjY70b7+MwiqiBOE8O1Ijws3vk89CraTFQ1wD9oYM0YTDYn4dIqCJx9hIsFyb9yhOCnxUfvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ew5ujhN2; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ew5ujhN2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oElTx468uQFQGRrsF9C2/8vkSEnHSpZ1AEe9ebSZWPlghWDbNQZpuNQ3JDCEvPG/Ho2w+WG/bHlZG2EpHy10DAT4OKYJz9eXb1gIf4S9lmFU4qUYC6l0mpUWufp+kFL6hiOtMibFBJJ4AkmSf9hsulH/nyNRZKAMkxobQ9/hzdcvaab2GHBMUPdeGZXCOsSQHn1dduWsGjpqqf65zeyJ3SkCqFvK9fvWQXUqrtyUUQcVqLp+2xRsGirH825lzPyMMiWtOjthBWmbpnWDPweAXc4yR6p1y0geja8BQdAM0ttw26/RezVdFY/mv6MFGCsCRKETs9wtbu0wF+ubPNkf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL5pqnLd1bFz8lw8WXgfe7JB1tqmtOnm6XqJPB0CAS8=;
 b=rOBHZpQPI0qUsHMlid2RQFIRVBZ9mYbqVAsKi4Uwi6AqYTlxftV1ItLkK7qzZnhSq02Ouz50+dDr8AiQPTjduUp2uy3EvvWXESBBhUDywa9fcmku2vJkGpVl1rXr+aVhyo0XGWWXP66JpxTXBRKWz3ks0n/xqhaW3pTXoVXHdsFJ1D+VRSdRCZ7ZCrSdY7B1bsDdiWnPbA/LjqNX0AHSssEDyg2TEG5RUgJv1gcnZgudXqeis1NqGwp6IW/WO+L0KmNPXsHgmdKtqF3eGetBmyGEo6F5CExmaO3ta4r/GuKbpNGUYNEwPuwrdGQNpZJ91Dak8K6HnG/iYxW9n1Fi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL5pqnLd1bFz8lw8WXgfe7JB1tqmtOnm6XqJPB0CAS8=;
 b=ew5ujhN2iafe31gxvpaW4OzCyUmkbrb0dQ5qCtar9mmG5gJ7JbM4UMVr4sQx8XejW+wQrFqrImJMf2lM6m0Psnv0owZngvIzqL+gcYjgQ2zH3kDk5MN/x+oXG2TXyLz6oIfXbyAc0jU5TVGm97NeE5wEthQAb225jaM61tGNGgpXIDzPCnKSZs08AZCcwg6B7Z3d6wYQ9VI/C51XUENi7Q/WHqOliGTLb750mQ/2nKlfwp91f82wQcS3sR/0ODW/wwZepF6bZmQbS7YsO35RdpyhN2FCVhQVPXYyG0iL2lagzFrL5AREjfAwUPmXyV67s80GIdaUvxPkjJ09F+25ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:12:35 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 11/11] riscv: dovetail: add core support
Date: Tue, 28 Jul 2026 13:12:22 +0200
Message-ID: <20260728111222.2699158-12-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
References: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: c082fbff-d59f-4988-7038-08deec992044
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|3023799007|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6YSkuKmSI1Miw1DnbJdi+r/CZPjyg735ayzNMHNKYlEF4AftfXSjC17y+vQCiLLD9bcPFb/sa307Eaiv3NzJ5zHdpEyT+CwU7Z+QCaySLMtM4QdXgfY+IlE9JYDJ8IuLAEHZ36AzAAbt6NRlP1X52vEFPLUwzfEA1OWyxyVYTisoOLX00e4oECoGrlIMHYkaod13fSlt0RpOuBYcHX/xryKWpJ0d40AVm6g5KYujjSanGdMyBKi9H5jD75UaJvt087IS1MnEyJNtxsUu3CDDEHPwquSQHZM6XK/vd81SIj7jDP/9UN/JafOo5THD0Mt48W1Qo7gJ3TXIBE9Qq0hNYaz7NYWAIRPDFiGOqkU/9OnEmfpVrFSkS3dSjicA590SOdPo7KwukBvak8BLV/SdtiARC7itCrwVJRjiCnqX0dPVOjdxb5ot2yL5/kMiyhI4caEHqQChluVD22hhw7B3aVOZe8kgJ1PVwowVdG/WiOdvMiiumtAm1tMNaA33xg3spuiNJ2YB+SE2aiJmKJi/ugTs0b/9tmbnDUFDxs1A5uNRnvmwemMtU048aaRx95Wt8MT52fqW2ZV4oYndEbl69rB9jiCKXLAYlzw21EiFHPg+9opP8GjuYF4Cwz3YNCCH4ixqFpn32Ra9Dcc2D2uWpq5vPGscKXw8fwgr+1Z+fgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ujMPCflapnVX0PEns/ybsikW/8oREbaNhIf5UeRdspBlxR7xuwl3YnWXFUi?=
 =?us-ascii?Q?EiGUT3X8ovuKZmiPtHpVTmCsLmNewm+OYQXYF8P0M8mL4OF/Y6NectQRquds?=
 =?us-ascii?Q?SPoBQCV+qjp1ykFA0wTrQe4Vg9Yo+djvQbcR3JhEIfY7zdMOotqj8ctJRniN?=
 =?us-ascii?Q?tn3ML8H+1TpyICzsiq9j1OZh6849bX9FHa2pGD/KzT8COWGlOj0eRfxtKbc/?=
 =?us-ascii?Q?GuGswTypCQf4Ab5gAqP3dOUCfRE4nJHRmkP6tgfVj+IVqdIQwIgWaWvM1Gxx?=
 =?us-ascii?Q?6Vm/0inUt3IDHAytr8BCFvkuInBXFyq2oCxFmZ1KEFFixk0EASW+/TrBz78I?=
 =?us-ascii?Q?qZBXLEqSrAmFjpwkB3L2n+qsaLWqZySQ7rbf6GSOpRKTP0Ige8nEH7cfpC/C?=
 =?us-ascii?Q?sMIjHl5/DlALKgpXQxyJkF0IhaflGWmk1gaC7FAdE+Ghv+BLo8LHLPnXanS8?=
 =?us-ascii?Q?750WxarUcn6BlgTwvlGH+Y1Wsgu78xp7QvC9SoVEzTnZPUd22L2+0iD2v0ye?=
 =?us-ascii?Q?djmmK1J6lzVSKlZODS4IFTvvHOzsl746PIAWr0qHKXxtx0HUa/8uSkENNXEK?=
 =?us-ascii?Q?j2kBhyqIB4gFE5ITc+xQND7NeD36tvILrh4mEXkZtZxyNPdC0BiziqynLdZr?=
 =?us-ascii?Q?Ub0T9kNONj23SDW237rQRBvtJTJqX2Ol3ugfLh+Rt8Ls/Fsk+rOO5swOx6+t?=
 =?us-ascii?Q?OM0TNgKNZYhIMVMu7ycFi3v45rf+xbxwhSo7PRUwcBbbYJxR58gYOpCx0kYk?=
 =?us-ascii?Q?CraDmTRsuPIOUQDnuCG5/pNZbUgtkmI3IHuVNyeI86XMJwtiam5KmPwfQz+L?=
 =?us-ascii?Q?OGPL4ijhkKR/36xqc9QahZE8Fz1yPeoFbaDoLRjQBAxFr89NRaZWCnDUV5dr?=
 =?us-ascii?Q?6IAQrD9fV/mjNQmNIZVMiNYZ2jDlgFocKlcfyaEvk0thKJd3fwNGAu+X/wqn?=
 =?us-ascii?Q?V+p2i4tDmmTfYfhSj1egHY7A4lbCGnE4qsFWfO/4euFxtdnTsRDxt7Np/nxS?=
 =?us-ascii?Q?Ytknha6oLKFjo/c+CVVfMG0FoPK5oBDhDQRdsT2axKid+Dc0pTBGlHeF4HQf?=
 =?us-ascii?Q?UreEjD4bXBLiex42JvJEdbQdMNe76/4JTx4plZKjeZX6CfZQtfUZNmEZIx9p?=
 =?us-ascii?Q?gBBk2qb6VyLXAON5mFDG3EbUNDoP01PaeRc91lCYinSCPOTpKldP+nbkMFmy?=
 =?us-ascii?Q?BbSLrysGn+uyct8qehAmnK7xGasEN1EDVGyqNs4emUfWAKN1JUcQMXkWgbnU?=
 =?us-ascii?Q?bCGz1EnazvWio5NvIrpUbDp1I/fJDGm28RvAcFp2g1p3q84W84iILCZEdb6C?=
 =?us-ascii?Q?5pasH+aqmFQ94zQb+HuTKHpKKGItioae8B2mMmEXruhqywa2lH3/ZyfSVMX1?=
 =?us-ascii?Q?k8v5mmh4JuEpYpuMwtn4WijxQh/OfibpJJQne3EEbz45clVM/xbA01tYXjjw?=
 =?us-ascii?Q?IJoytvdFGc7ozlhV+Avg+NGvTBUOq99PijlYO0suy0w1+NkzZM2v208GMzLz?=
 =?us-ascii?Q?59ZZwb8D6X1R5mFPSJJRmKLK9zjsMRV6DkcoPbTUZA5FyghOs7ljy7V84VIq?=
 =?us-ascii?Q?Zvuor+F/ypiv09800d+JLzL1tTyX8WcV3soudoCaiCDnVHW3edXBQY8b5K8n?=
 =?us-ascii?Q?34XOd2V9tHSf+IUOfqEICfvyemy77uk0cjyh7Wd+VVFS9GmhRqzF5Jdt35X+?=
 =?us-ascii?Q?PTgUXGOIED/lxdaS5FVRwI1zyI77TxRne7TiXj7ccQT8Os9zP54Wq9z0vQBG?=
 =?us-ascii?Q?g6gHIS5vvpDyCaha5c0D2k2Tx31V+Xs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c082fbff-d59f-4988-7038-08deec992044
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:34.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRO7D6PXAU4Ls7xoqud9bUH3JFDR2dh1G3uSFNU3nQ1WuUQbkv+RvPHqrlZ3J8+/9fnEnDzG7teNUjmLeVjXqg9ABh3GTQDEWWLjMDA62qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

Add Dovetail co-kernel support for RISC-V, including, irq pipeline
integration, out-of-band aware trap handling and memory management.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |   2 +
 arch/riscv/include/asm/dovetail.h    |  23 ++++++
 arch/riscv/include/asm/mmu_context.h |   2 +
 arch/riscv/include/asm/syscall.h     |   6 ++
 arch/riscv/include/asm/thread_info.h |   8 ++
 arch/riscv/kernel/traps.c            | 114 +++++++++++++++++++++------
 arch/riscv/mm/context.c              |  20 ++++-
 7 files changed, 147 insertions(+), 28 deletions(-)
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
index 000000000000..bbdfee7c95a7
--- /dev/null
+++ b/arch/riscv/include/asm/dovetail.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2024-2026 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
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
index be87cd58e754..55be4272f0dc 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -22,6 +22,8 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/entry-common.h>
+#include <linux/audit.h>
+#include <linux/dovetail.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -115,18 +117,24 @@ void die(struct pt_regs *regs, const char *str)
 static __always_inline
 bool mark_trap_entry(struct pt_regs *regs)
 {
+	oob_trap_notify(regs->cause, regs);
+
 	if (likely(running_inband())) {
 		if (user_mode(regs))
 			hard_cond_local_irq_enable();
 		return true;
 	}
 
+	oob_trap_unwind(regs->cause, regs);
+
 	return false;
 }
 
 static __always_inline
 void mark_trap_exit(struct pt_regs *regs)
 {
+	oob_trap_unwind(regs->cause, regs);
+
 	if (likely(running_inband()) && user_mode(regs))
 		hard_cond_local_irq_disable();
 }
@@ -172,13 +180,19 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
-		local_irq_enable();						\
-		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
-		local_irq_disable();						\
+		if (mark_trap_entry(regs)) {					\
+			local_irq_enable();					\
+			do_trap_error(regs, signo, code, regs->epc, "Oops - " str); \
+			local_irq_disable();					\
+			mark_trap_exit(regs);					\
+		}								\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
-		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		if (mark_trap_entry(regs)) {					\
+			do_trap_error(regs, signo, code, regs->epc, "Oops - " str); \
+			mark_trap_exit(regs);					\
+		}								\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
 }
@@ -198,21 +212,26 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		local_irq_enable();
+		if (mark_trap_entry(regs)) {
+			local_irq_enable();
 
-		handled = riscv_v_first_use_handler(regs);
-		if (!handled)
-			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
-				      "Oops - illegal instruction");
+			handled = riscv_v_first_use_handler(regs);
 
-		local_irq_disable();
+			if (!handled)
+				do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
+					      "Oops - illegal instruction");
+
+			local_irq_disable();
+			mark_trap_exit(regs);
+		}
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
-			      "Oops - illegal instruction");
-
+		if (mark_trap_entry(regs)) {
+			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
+				      "Oops - illegal instruction");
+			mark_trap_exit(regs);
+		}
 		irqentry_nmi_exit(regs, state);
 	}
 }
@@ -244,17 +263,26 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
+		if (!mark_trap_entry(regs))
+			goto out;
 		local_irq_enable();
 	} else {
 		state = irqentry_nmi_enter(regs);
+		if (!mark_trap_entry(regs))
+			goto out;
 	}
 
 	if (misaligned_handler[type].handler(regs))
 		do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
 			      misaligned_handler[type].type_str);
 
-	if (user_mode(regs)) {
+	if (user_mode(regs))
 		local_irq_disable();
+
+	mark_trap_exit(regs);
+
+out:
+	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_nmi_exit(regs, state);
@@ -330,17 +358,21 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		local_irq_enable();
+		if (mark_trap_entry(regs)) {
+			local_irq_enable();
 
-		handle_break(regs);
+			handle_break(regs);
 
-		local_irq_disable();
+			local_irq_disable();
+			mark_trap_exit(regs);
+		}
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		handle_break(regs);
-
+		if (mark_trap_entry(regs)) {
+			handle_break(regs);
+			mark_trap_exit(regs);
+		}
 		irqentry_nmi_exit(regs, state);
 	}
 }
@@ -359,6 +391,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		if (dovetailing()) {
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
@@ -366,6 +407,13 @@ void do_trap_ecall_u(struct pt_regs *regs)
 			syscall_handler(regs, syscall);
 		}
 
+done_inband:
+		/*
+		 * Dovetail: balance audit entry that generic exit
+		 * skips for in_oob_syscall().
+		 */
+		if (dovetailing() && in_oob_syscall(regs))
+			audit_syscall_exit(regs);
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -420,11 +468,13 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
+		if (mark_trap_entry(regs)) {
+			/* not a cfi violation, then merge into flow of unknown trap handler */
+			if (!handle_user_cfi_violation(regs))
+				do_trap_unknown(regs);
 
-		/* not a cfi violation, then merge into flow of unknown trap handler */
-		if (!handle_user_cfi_violation(regs))
-			do_trap_unknown(regs);
-
+			mark_trap_exit(regs);
+		}
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		/* sw check exception coming from kernel is a bug in kernel */
@@ -437,10 +487,22 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-	handle_page_fault(regs);
+	mark_trap_entry(regs);
+
+	BUG_ON(dovetail_debug() && !running_inband());
+
+	if (!user_mode(regs))
+		hard_cond_local_irq_enable();
+
+	handle_page_fault(regs, state);
 
 	local_irq_disable();
 
+	mark_trap_exit(regs);
+
+	if (!user_mode(regs))
+		hard_cond_local_irq_disable();
+
 	irqentry_exit(regs, state);
 }
 #endif
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
-- 
2.43.0

