Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F483F6C46
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092485; cv=fail; b=G8kHnznRJRBpmyq3RJbEfUdsmZekw19qBWD8RRJfieDLIEeuTdOAIer0hWbPAY9Dw3DQOMxB+y40TeTXf7y/+ioz2hp49K6JF19ezgyzr8KckLDJBU+VW/t3aX8g3tX8IN7aN0rImadRb16bFT5KoVBy3XdOt8P44HNRMVeV+aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092485; c=relaxed/simple;
	bh=iOPmjlkrFH+2wL6E0JZsJebyzDtPBJN4D0jdVNSi9os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKNXzErgPnMDVw2/072Nm+wq5M56oLH12PrqxDumJvS9jDrxOd1r76zVaA38xczyK9mLclzUmhmJBeUvN+SGKCy3mlgs4K6HFSQesFRMYc2r1QR1vSEk6+k+bblZosev9kwSe8XIwjzDAFVs0fNC0z7pQyhZl08T1Ie7PT4l55o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CRpZJEKF; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CRpZJEKF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dl924TiyD6Hii3qHw2YWX4r3PN51KgVi3nwNUUG7TuWGntPskuddrjg9nLe6Q4hKA6eoGGBUwsBrNjPgBfH5NctdMMmXxAEi57T3ETcdhKfUUqSOo/GYAswtrFQhsx8Z27bc7bOxEyatVU/ROyv8a08sYS4TCBnr25gW3MEIYlYLpdkKm30lJFKjwV4WCTmlMDkN3cxsEMAaxKmO3PwVYf2cXNupzhVqgJ1b987OiSYEwcI9YvIcyDAig2NtiWqM9bqOrsXpoy/JVK1a6aM/J/ovt6rgz1C0BdUBpiPGjdbnXGMskt3wDNuUvFGJZF88JEcnD/4sx+1PUq5UwnPpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JWfrpvBu6X83KyYn6L7LT2fTKeRXiVgIHJyw0U7paY=;
 b=tvqHcfcZESSiOk1glrhk474nEMt4fJqWoPzKZJRuTPCJKbT+GreVvsdKaHBJgS/Auf3mW2qYpQzoMwbKYGJUQclwLxIJF/yfqcWQzrI6pZruApo2rSU8NeUTZsvr0gtmR57vZECmGlw4RINtg9WKtjJD16umq+eyhynKVwzYm68QkftU05Ig4ilQd3z7vOWPKIQ4CRt8loxJCxxoPwD9qdxVsvk40rO2I/uRuqjVlDVylwOm399Fc2v34ZwKGBP/H14rH/0tBmpIWhbEtpHU47M9PTA091B4JGbitkgeLXx99sRapbnKDAt48IVrTzyQBdE1sOVeMZVbiX1AAdJ75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JWfrpvBu6X83KyYn6L7LT2fTKeRXiVgIHJyw0U7paY=;
 b=CRpZJEKFsrPj12rDlQ3jKpkIJpdjqDGlyvKv4H35rJwR02lJCKzkL7vEFXhPD++4NkCfRK0+iVWG2g4X8Va+Udu2Wn/wGqkoHXFulVc2TfYwcUDJZQtbZaqXWJ/2+nJlWwk3NvOreNW7UQL/zCqmQ6+kks11C6dgEyrqbsq7znsgKHZ/gByQflVdM0bSB0MqAMlQkssaXHemYDwXfn9/gr41arnjx0kcFtlGYVNwc1dMmxyTvh+fmBiQS4KG1jcltOwFmhz/QTJRqZ4Mzdezmw6OsiyFyaeO2WE8LPDrqQR5+7w2DhOnQ/aDqxtunPKlVW6y0Fkl4KAYaQcv9Wtxmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:54 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:54 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 11/11] riscv: dovetail: add core support
Date: Fri,  3 Jul 2026 17:27:38 +0200
Message-ID: <20260703152738.129122-12-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a65423-1cba-42a2-d795-08ded917a6ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|3023799007|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qeDODck6LpBHW8hABLpm8V9mTg9VUfQmWiXJxi9ogOm5y7dx4ju6ZPOw9W+wOYurIgZzUbxR1HuUSk++/Lg8aA2+e1xQ+qdYeIoV3BumCAoZjNwNBRMCGitjbxRs+tbOkSZb9U7Ch1ABSS/bbeUoHvJwM4tItRVtlJObPwHZV8OrGLN924DpFOFaHTEi7loyrGArm/1PBwkPUuK1xLkubuXwnTbktalgjy3SDQ8XpEMa4+5hZeDBlCNmaggySrYOvHtEqTb7x+YMPBj3uyg8oEUZOdFVConfu0YovUOCyR9d3jN5uFRiQPk7TGY5JMS7v0HH7B0y+azAnhuOCaJBkICPSDIt90slOOqz9+joGVh+Hc9rw+efVSzm9DmLGZC/MPcDwcuG9HVYfVbfhW+nDmZeW0yEM5SPG70UnPJw4I7W479uXwYHZ3a/fIzW0/VSDzTWlquu5BRJByKtINLRNWXw2bt9gP88b7hKKnFW0A3bDeXcMWeQo8yizjLm6d9aUXywbgbgQRfLEcrPX0UrM1QH8kjSOj/WG1pLV6uOwXSOp1e1pa0frEstwS1Lcs4n99c/NkfIu1R8PTNMAs7LlGYGOlfdXe41pb6hKHvnRM/GKwccPdl0ntXy1CA8maK4smyBISnJDB+zyI7a2bH7PzIAI8XqU6IIou8owa4ySC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(3023799007)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/1s+D8xtqghraohas8m1HqrQxUXQ0ufL5CNbHIp2K/vdtulsRFDIVdS09KvT?=
 =?us-ascii?Q?sqhk2tGtC+FGJPSfx4ckrCigvJmr/eiFG2S3h1PhqjsP3CPJ7wZvCXgGGKL+?=
 =?us-ascii?Q?JmNeXp25121SvZwGxumrSCVH0HDAJVl7j4GI97pAwJAH/OPCMEGJJ03DLdYz?=
 =?us-ascii?Q?+gcQwiTmMi5JJJuoxb+XbLWf5sfDqwX2AtQE4N+t0xfegeytJRNTpCGBjJ12?=
 =?us-ascii?Q?iGW7x/yqipaDXYfcEABSkB1vquC732BDrhQgFcXHl3BvLZ/Y80EVyKjd+4Q/?=
 =?us-ascii?Q?Arfs/7w/A5QRW229AdSvZ07oxXtrKqrhBmPC5jm0h22VzLdUO//Sn3VuQYrj?=
 =?us-ascii?Q?fQxgDA3/ISMFSiZyG0vF/umhNADpzx6MevX9q1rJX+SdF6SclzDbAEAM3vlR?=
 =?us-ascii?Q?4veJsVNnBy4d3KNgHR4TYFM6Tbj5V6uCfFAWD7t95A2GWnVguNd0/evn89eq?=
 =?us-ascii?Q?ajiOceYmghUS5gF9tkPArM+LeAc1mLG3tuc6qITb3ER6uM9ACH2WpGDoBABK?=
 =?us-ascii?Q?RxribdxykFyVkK3joxVMVZZIo4FmHsAv2MSANHhg6dqmS1/+RNt3ZrnvoGos?=
 =?us-ascii?Q?/QjzI+7uGK/lMZMKL8VaCLJd8o27st5Ki8p1FXhlNJRN9NnLo6WBen7g+I56?=
 =?us-ascii?Q?rs/k9XTG4ccZjmCuHPsjZWQlfs1ZQe/4x3rOC1NMHfrq9hqjH6zRr9P6qpTj?=
 =?us-ascii?Q?Mrmgc1MoFlt8m+703/O0Dq51RmTkkCiJPeSeomtuEI4CpK/9cVmYEho6NUBs?=
 =?us-ascii?Q?Zp5CMYZBAKzfQr4uGxvpBXdVSYoqqkb+g7Oraq/9Kt8buTFN6inpxaG3BxK6?=
 =?us-ascii?Q?pP79UDXe2t+6qqtpB5nfUjhx1briJUTF6yjYYp1QqItCmsmqtvQF/0qWwyCM?=
 =?us-ascii?Q?yOfDR427l7vtoZAIvPbtDqFSRihUNXXdWJu7oS+6bgujwhw4D2Cb774/WlBx?=
 =?us-ascii?Q?aYbJd9s+3tDxZtqOFb2HtM0F0/8+l6Q6gv0FxqbnBhr/tIXuWjkDGfNGHmkP?=
 =?us-ascii?Q?Pz5yo8ktiuQwr/2Jmprx4lh3GVHttOuwTgoHRfQWBYxi1U/uCPQRPmxms9GG?=
 =?us-ascii?Q?0WaOZgBYV2uG64U4Fohdf1tKJ3YINiwRk+NxVotZ2DziS6LOhrOeWZoPZnAB?=
 =?us-ascii?Q?D6iiJ3M+cl1DsUt+8O5jqZ+GAsVVi0jVO7xmys5ftnTUKeLGVua5omqIZoGj?=
 =?us-ascii?Q?3LH6bP9NLVaXfUxFIRVPTKLCibqsUHUpFq403WLmtajnxGQVO3bBcO8UcsT/?=
 =?us-ascii?Q?5l8sXg+iCvFCok6S5dcWRQFi77jfCY8htSIsMP6tM+Kfblnx/wp5fVpxqr+J?=
 =?us-ascii?Q?NxFGZi/xWs2Tfyf41JSZ/1FQ5ppjVZyorJ0DnQf3ysXaI+0MN1zfRIgqcCbS?=
 =?us-ascii?Q?x89ZUBErgel1KMt6JY/Taxopwhow9gppL89gch1Gnmy3b6wQp0WBpEUMqB7M?=
 =?us-ascii?Q?lOm+JU7jzxGN9GfKCnZv/5N7VhP8mqwho6/aCELpc8kWl2rHTodYitU89x+Q?=
 =?us-ascii?Q?fV+/CmYigzBCqlX+5OKns6xUbdfIQpU2TsCIxBf5bSwTFfN52EbVpHVp2CNA?=
 =?us-ascii?Q?ev1ti1N4SeZpV7isr7Sj8/++jgBAGkVsugrsNxkNgjaVmu8DUpWGiVn7Bo+1?=
 =?us-ascii?Q?U16EMoHCBtBgH7wXp9f/ddOS0LH6E6ngFltX8zBE2PYb0BSXHv2oPUYFv591?=
 =?us-ascii?Q?XuWC9yIzqfj9RrFkRw1YCoSjiEcAWDqQXQv1S3DVZ6wASWuRDHa55QRpitJj?=
 =?us-ascii?Q?N22oQfYW7GQE/nanHKaZauZG95MdT3cA34M4KFyn5HG7ri5HNnoREX0qeXUM?=
X-MS-Exchange-AntiSpam-MessageData-1: tI4SnnJHUANSRjHjRBTLbbX9n7f+ybeivkU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a65423-1cba-42a2-d795-08ded917a6ba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:53.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0qAJcXlZ7kTRCsHmALYRiJTUacA29QX07cUHgAySv6pFguXDf6IKLoovPD1UenNHjXpwszamN+gYCvkyUFGdH5t7Q4aR7Chwm2TUwwqD9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

Add Dovetail co-kernel support for RISC-V, including, irq pipeline
integration, out-of-band aware trap handling and memory management.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |   2 +
 arch/riscv/include/asm/dovetail.h    |  24 ++++++
 arch/riscv/include/asm/mmu_context.h |   2 +
 arch/riscv/include/asm/syscall.h     |   6 ++
 arch/riscv/include/asm/thread_info.h |   8 ++
 arch/riscv/kernel/traps.c            | 114 +++++++++++++++++++++------
 arch/riscv/mm/context.c              |  20 ++++-
 7 files changed, 148 insertions(+), 28 deletions(-)
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
index fe6c547c93e4..4dd7160e19c3 100644
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

