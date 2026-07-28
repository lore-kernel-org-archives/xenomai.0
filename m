Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9841F7D3
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237159; cv=fail; b=S6+xU6OFPb/Rfb01BxAgwbk3ivcVu8mhYHFXS7Q5RRFfRRVP6JSWN0hDXbtMKgIaFIkGiEg43hbsRlbYQjDwE9SAkMP3bqZGOg6rDNpgZnlLrlbwGCt1nICG5JOrKMWd07plmkQka3tu50bMeaa4L8UPpZebLjISTWlFp+XCjxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237159; c=relaxed/simple;
	bh=+7fucX37oMmwpDE4mLwlbKz7dgAWNpg3/IQXt5/Dq/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdnIByDMDQS2hkHY62Y7XZcboG0/Eygqlqgw7BbN5pTCy/Xh4S6IH1+NBtDdjVf3V1Ynt+BIXACHTodX651eyOnwVWYa9Up2L6tAlUHiedO0f8mcCuTs9rW73faNBh14iXrSkLd/Og6oxirP/8PvxlUtJJqr7v0fLC1phAzbcRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=D0zix8rV; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="D0zix8rV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it4PXk1dRSUDylNwrGLTG20c5/l3iiNF4JTE55LpAtf5XynUrP/UATa+wZoq0UCpTy0TX4NUVmvovXejllKBfmzMQp5u8AEJ71Gj5x4ptVDQT1ciVm7/BVs/y82LJ8EM2rJGRXKzrpwC8IbbbgJfSuyLslwhs+mIYQQzd9Q+eOZ8XC6kZ0DM/5dBJml/7XqUHD+PlyT84AT5Tn4f7AdDDkIsllzaQuD/+z9T1Upjc56dVx3qGMzwXMyaguAqnmUp5Jhr+kzJQ4a/4ziNlPeGeG4aeL54ZSArYYtXhD8yRqXKiMENUjskdY79F50LfN0IjD5AlPSsO+SWT44c/MzVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Br8P3Ori2bIXs6Za2cxbfmRcjC8/nUhp80ZZLSMenw=;
 b=xI+VAl3sc+xFvMp1N7KLhd7dBZdndNCbKzfBdUp99SsLvj6ppqP5sawM2Bis2TStyMkLOSPJdFutHr3QeRtp31EAmUeoedfT74e0e6CB0DFHD3Uygx1onYxmMvU3DsQgn3bwyznJ3z8AmVWy4Uk3ccqSfCvVxWMFoVbmQ3XYRgOoxcKKiyIcCdTFDbI+ngNN2inrC7EX4qEL/GhXcOTLOBrzx9BzK7dKLWw4DoAOVHetTqARteS3ZiMMWUyZsLKZF6Z8eiJaC06c3eJPMrWhP12qyqSLDNGipY7/A3aOEHs8etIrqzYO+cq15yQnqsiAqF5/zmyec6qIm/rvvF8kSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Br8P3Ori2bIXs6Za2cxbfmRcjC8/nUhp80ZZLSMenw=;
 b=D0zix8rVM3A+rP0kYzVqhQ3x4DlKA8PpFwn6H5rY0CgQQVYiaP22YSCBnKlJwr5IUmeiMbvyp/p3sJMPwKsJYCc313EnJi/2mxdqqj8YMZEyvlhA7OO2K1LTWoupolCsZGRzM44Ux8J9rU+gldthBAYwh3lPY+AsoUGHi+f1f4FB1gu6bojcWYg6KDM8WywBx8k5Em4isiMOZaOBcgWJ+sd620ompv4qrXmgAIjfwmbgf1kGnZj6+oXMgSYL9EX/qY52hhabTWv6a1M2o/Yws/EK0MwcxDJ6hBOkrqQ4MKIPARD19glYkjDI0NT3hifYPPf1BxLJBqDow0AbpyZsdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 11:12:31 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:31 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 02/11] riscv: irq_pipeline: add IRQ pipelining core
Date: Tue, 28 Jul 2026 13:12:13 +0200
Message-ID: <20260728111222.2699158-3-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a51e29e-3eed-4d07-8408-08deec991d6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|5023799004|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WGO0TI/queFAPKCtAldTPsRokimiSQDgiQ2Djfm0zY3S0h5EbAgJ2ygF4bTTSXLXArxKlxf9kGOk123VH6ORwCSzXY/fsRVTZ6mwoLt/uwhnf+H1kVbDnSyGUH73ohqNiVEafk4wwOIgLHGJSEuIbMPjipto7WtgM/ikU2vIzYcSxXsMsbLbmZkJ0keOVuxRdABQGIOrpnumkViW05dNGxe4SzT6k6yhx8gOTpNnU1PV5F+fVI9Rj9VMNNHkrZAhEJfAniGGQJAY/BRy6odThWTpAEiRWt1zac9EqsyozE1p6knEors36CSklPmfdBzXbaCCjCQVkvLVfR4AyyXbtGZ8tLQs1JFYOjLVfGj9mcGlUncyWcNsevgsy6UI7Ad7d7X90I9OVH4AXnuA6KgPlP5hAg/OowaCAjLF5DM0b7g0K8JczEH41CVp8M5m4oPoQLEwld/pdOMJnpKXUc7bLYenJJ3qyO2I7+4gRQg18ukUhJWiNr+iNeVdt4ercNeJBugG+hawq5Vpe5pxSSBsF/GXIbYqUCDSOP9VNER43RDMThyZYvP+7fkL0EwjSdXRZsEqmDOEzoiDM5NYWV6lIBXedo5zjg/Faa/qNU7Y7coJ9d7mUqe/9zhiB70qKvsrbmcXEs7NGPOn1CRjj8PdBMZ2SkEEG7rayXeq6dfcs8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpufgjZy5c5xJHIGt620f/7SGcOnBd2uiv3B6CYMZ3+gcJE8Yap90nbnj729?=
 =?us-ascii?Q?UP7HN8I10Zs6wD2LlFK7+GUJ4bo6Ohs2oXm6WWZwrJCelEKSed6MNlY25LW4?=
 =?us-ascii?Q?WeuyEhbikLN/49vc03xVBjktCw//iF8JrX3SeodVJaVwJmoGx3PQbLSMhJ4j?=
 =?us-ascii?Q?QMwzCzeEhvjIhOGZCSb+GHpCFAjgUSDw1hvlt/tVRyed67SMQtaD1RUKoonK?=
 =?us-ascii?Q?21b15VdBJjndTr5LMEgkbG7AEtCCqbGZc2a6+SbljzEghGRBHPrfmFwORMg6?=
 =?us-ascii?Q?nCuMblJKVbujghG8/XG0GrB/VSNNpZuOgfhHVS13/Ttlg/pIbFqKZn8Do7Mu?=
 =?us-ascii?Q?wUshrR5awv5n/hNl8eGallR4XsD0C1CI2nferchsG5TUNdt/8m8Z21HDNKsS?=
 =?us-ascii?Q?ZJdI8mgEiNlZm9YWdyoljhXy7yuR+W0Xb7Idl3ZFCdi5PSkBIghfunNTj0+n?=
 =?us-ascii?Q?ZPZJb2vQGmOTQ4D39WcyPgAwjZcHIRq4bqllZKUYkIDqW10hpUTlq2V8BQRs?=
 =?us-ascii?Q?QgHaDE4YyT6a+g3PDiipIaTiVNoPqVb6/RFdPeHZnJBRfE0YGS4VayRqo50i?=
 =?us-ascii?Q?jSEwaN2hBnT4ZTha5o0v0/hSu2Ra7s772o3X/bcejmLEWA3tq0EOz/X4l1M7?=
 =?us-ascii?Q?A5FEEZ/VhpGdEr4wGQKEJDMhmb5WHb7L1pU2olNfx3LRQty34+IA0wHz8y9O?=
 =?us-ascii?Q?uu80j9rqJyMfxYCV40HbMyYfL4qLh0qO6fiQ+C+oCLR4egqOPUj9Nr4aVIFj?=
 =?us-ascii?Q?VuRffgQcsxDHIHWv+e5XZ8wPfANfNhIQmR7YPF/8Wgzg7irnT5XipDYzZx4d?=
 =?us-ascii?Q?wUt/cDNPy4uMTo8Kfr0auY5i4aY2uR9zT4JUY9X9lYMIGlH0te1Ltg1pLdGj?=
 =?us-ascii?Q?AC0qWwMbyQfWTbPpmRg9wLfWrBw4e1IrKVwkVWHPk+KRx+kIgf4DymcKFA7L?=
 =?us-ascii?Q?qxBGtpOXnlAWJi1YWHaosuiguaV0C5uQ3sM9Vkfa4fIJtDCWKl6JsCYXeFh5?=
 =?us-ascii?Q?cfoVbe+jE7TjR3SMUoofjmlKNrKGOzNtcOC6h1qpEvjQqlMHuLcBQBJslL9T?=
 =?us-ascii?Q?UKpG1dfEE7TMLlg/1+sl+TgfVd7qUxldz/T8udxqQSwhLPSRyfz76DSfZB7x?=
 =?us-ascii?Q?9ExWl4SVodRvtGCz7VTv8k2w1Lh+K5R6a4XdRQau5XcYBdRGvRL+mTaNrKd3?=
 =?us-ascii?Q?61TPX8HgAYYI49TM+PD0ka50ui+eY7Ipe2lsQvogwHGUlbWtg9w+jlQzfwOx?=
 =?us-ascii?Q?RGHJUSTUs59EgIWEMOL4bncyXGP9x+VynlRXPqmB/fgK2rJ5GC62XrsmelL2?=
 =?us-ascii?Q?RCr22T1ReN8ox+30j1dUy2J5HC6fAINfDVZCFrcES431/OycE6woNKSTn0OZ?=
 =?us-ascii?Q?KMQuGBzFmF2UwtwV02NYpisueENdWfUbt6/W+GVUKfOLjdWVkgPhMt4ttEc5?=
 =?us-ascii?Q?Qdm4EKUbuCmW4EuQUFiXg5wPNSs/B4tKa5owCSbzmcbTVVzCMN25hOqt0c6H?=
 =?us-ascii?Q?cb3erYiljxA5OnDPoHr8Ji5BglcrGfg5gixTHa2Bui9EDuQr6739Bl8qJ9Pk?=
 =?us-ascii?Q?tK6M62EmtxVxCE3FZiZNo0M/9/1oJS/tvhnWdDn03eb9Y6P0wivd8A6PEOS5?=
 =?us-ascii?Q?BXgF6yx4ae7mlAfWL1R20tPubdturB7OHoQYoBNKzwAn0tpRiq6g7jnWtEvI?=
 =?us-ascii?Q?v9zkZGIjmHoU+qJ/wGKQ4jwyOFWSwqAZK8ry9JO9H/ZKP4Vlgfx0g2VjNz8O?=
 =?us-ascii?Q?YFBwo1dG1GavCF3B4JcxMlP2CZ1b94Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a51e29e-3eed-4d07-8408-08deec991d6b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:30.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muiYmbRT80DKpiJ14Kxv1yelvhHP3ZEO0xzXu5nRNNdnOTQyTfppwVLPjELYPGuXrCpBWfCY3EOcO1TBp9BBaXLGzWyAO+nYTpvlW2S3Tow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8685

This patchset integrates IRQ pipelining into the RISC-V architecture,
bringing it in line with the Dovetail/IRQ pipeline model used on other
architectures. It adds the core pipelining infrastructure and adapts
low-level primitives to cleanly separate in-band and out-of-band
interrupt handling.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Co-authored-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/entry-common.h  |   3 +-
 arch/riscv/include/asm/irq_pipeline.h  | 143 +++++++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h      |  32 ++++--
 arch/riscv/include/asm/smp.h           |  25 +++++
 arch/riscv/include/asm/thread_info.h   |   9 ++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/irq_pipeline.c       |  26 +++++
 arch/riscv/kernel/kernel_mode_vector.c |   2 +-
 arch/riscv/kernel/sbi-ipi.c            |  12 ++-
 arch/riscv/kernel/smp.c                |  56 ++++++----
 arch/riscv/kernel/smpboot.c            |   2 +-
 arch/riscv/kernel/traps.c              |  86 +++++++++++++++
 arch/riscv/mm/fault.c                  |   8 +-
 14 files changed, 371 insertions(+), 35 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5754942cf85..7c58654c4ece 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -150,6 +150,7 @@ config RISCV
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_USERFAULTFD_WP if 64BIT && MMU && USERFAULTFD && RISCV_ISA_SVRSW60T59B
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
+	select HAVE_IRQ_PIPELINE
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 34ed149af5d1..28ea8090316d 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -22,7 +22,8 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
-void handle_page_fault(struct pt_regs *regs);
+struct irqentry_state;
+void handle_page_fault(struct pt_regs *regs, struct irqentry_state state);
 void handle_break(struct pt_regs *regs);
 
 #ifdef CONFIG_RISCV_MISALIGNED
diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
new file mode 100644
index 000000000000..d6f548c525be
--- /dev/null
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * IRQ Pipelining adapted from the ARM version.
+ *
+ * Copyright (C) 2024-2026 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+
+#ifndef _ASM_RISCV_IRQ_PIPELINE_H
+#define _ASM_RISCV_IRQ_PIPELINE_H
+
+#ifdef CONFIG_IRQ_PIPELINE
+
+#include <asm/ptrace.h>
+#include <asm/smp.h>
+
+#define OOB_NR_IPI		3
+
+extern int ipi_virq_base;
+
+#define CALL_FUNCTION_OOB_IPI (ipi_virq_base + OOB_CALL_FUNCTION_IPI)
+#define RESCHEDULE_OOB_IPI (ipi_virq_base + OOB_RESCHEDULE_IPI)
+#define TIMER_OOB_IPI (ipi_virq_base + OOB_TIMER_IPI)
+
+/* NOTE: Any bit should be fine as long as we don't hit SR_SIE or SR_MIE. */
+#define IRQMASK_i_POS   31
+
+static inline notrace
+unsigned long arch_irqs_virtual_to_native_flags(int stalled)
+{
+	if (!stalled)
+		return SR_IE;
+	return 0;
+}
+
+static inline notrace
+unsigned long arch_irqs_native_to_virtual_flags(unsigned long flags)
+{
+	return (!!native_irqs_disabled_flags(flags)) << IRQMASK_i_POS;
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+static inline notrace void arch_local_irq_enable(void)
+{
+	barrier();
+	inband_irq_enable();
+}
+
+static inline notrace void arch_local_irq_disable(void)
+{
+	inband_irq_disable();
+	barrier();
+}
+
+static inline notrace unsigned long arch_local_save_flags(void)
+{
+	int stalled = inband_irqs_disabled();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+static inline notrace unsigned long arch_local_irq_save(void)
+{
+	int stalled = inband_irq_save();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+/* set interrupt enabled status */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	inband_irq_restore(arch_irqs_disabled_flags(flags));
+	barrier();
+}
+
+static inline
+void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
+{
+	dst->status = src->status;
+	dst->epc = src->epc;
+}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	return native_irq_save();
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	native_irq_enable();
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	native_irq_disable();
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return native_save_flags();
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	native_irq_restore(flags);
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+#endif /* !CONFIG_IRQ_PIPELINE */
+
+/* test hardware interrupt enable bit */
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+struct pt_regs;
+
+extern void (*handle_arch_irq)(struct pt_regs *regs);
+
+static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+}
+
+static inline int arch_enable_oob_stage(void)
+{
+	return 0;
+}
+
+#endif /* _ASM_RISCV_IRQ_PIPELINE_H */
diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 6fd8cbfcfcc7..c3087b74752b 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -10,45 +10,57 @@
 #include <asm/csr.h>
 
 /* read interrupt enabled status */
-static inline unsigned long arch_local_save_flags(void)
+static inline unsigned long native_save_flags(void)
 {
-	return csr_read(CSR_STATUS);
+	return csr_read(CSR_STATUS) & SR_IE;
 }
 
 /* unconditionally enable interrupts */
-static inline void arch_local_irq_enable(void)
+static inline void native_irq_enable(void)
 {
 	csr_set(CSR_STATUS, SR_IE);
 }
 
 /* unconditionally disable interrupts */
-static inline void arch_local_irq_disable(void)
+static inline void native_irq_disable(void)
 {
 	csr_clear(CSR_STATUS, SR_IE);
 }
 
 /* get status and disable interrupts */
-static inline unsigned long arch_local_irq_save(void)
+static inline unsigned long native_irq_save(void)
 {
 	return csr_read_clear(CSR_STATUS, SR_IE);
 }
 
 /* test flags */
-static inline int arch_irqs_disabled_flags(unsigned long flags)
+static inline int native_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & SR_IE);
 }
 
 /* test hardware interrupt enable bit */
-static inline int arch_irqs_disabled(void)
+static inline bool native_irqs_disabled(void)
 {
-	return arch_irqs_disabled_flags(arch_local_save_flags());
+	return native_irqs_disabled_flags(native_save_flags());
 }
 
 /* set interrupt enabled status */
-static inline void arch_local_irq_restore(unsigned long flags)
+static inline void native_irq_restore(unsigned long flags)
 {
-	csr_set(CSR_STATUS, flags & SR_IE);
+	if (flags & SR_IE)
+		csr_set(CSR_STATUS, SR_IE);
+	else
+		csr_clear(CSR_STATUS, SR_IE);
+}
+
+#include <asm/irq_pipeline.h>
+
+static inline void native_irq_sync(void)
+{
+	native_irq_enable();
+	asm volatile("nop" : : : "memory");
+	native_irq_disable();
 }
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 0ecc67641b09..8a409484d002 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,6 +15,31 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
+#ifdef CONFIG_IRQ_PIPELINE
+extern int ipi_max;
+#define IRQ_RISCV_IPI_MAX ipi_max
+#else
+#define IRQ_RISCV_IPI_MAX BITS_PER_BYTE
+#endif
+
+enum ipi_message_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_CPU_STOP,
+	IPI_CPU_CRASH_STOP,
+	IPI_IRQ_WORK,
+	IPI_TIMER,
+	IPI_CPU_BACKTRACE,
+	IPI_KGDB_ROUNDUP,
+#ifdef CONFIG_IRQ_PIPELINE
+	OOB_TIMER_IPI,
+	OOB_RESCHEDULE_IPI,
+	OOB_CALL_FUNCTION_IPI,
+#endif
+	IPI_MAX,
+
+};
+
 #ifdef CONFIG_SMP
 
 #include <linux/jump_label.h>
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 55019fdfa9ec..8bfb02064f48 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -52,6 +52,10 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+#ifdef CONFIG_IRQ_PIPELINE
+	__u32			local_flags;	/* local (synchronous) flags */
+#define ti_local_flags(__ti)    ((__ti)->local_flags)
+#endif
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
 	/*
 	 * These stack pointers are overwritten on every system call or
@@ -124,4 +128,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #define _TIF_RISCV_V_DEFER_RESTORE	BIT(TIF_RISCV_V_DEFER_RESTORE)
 
+/*
+ * Local (synchronous) thread flags.
+ */
+#define _TLF_OOB		0x0001
+
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4e310257499a..fb51d1bc5e3a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
 obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
+obj-$(CONFIG_IRQ_PIPELINE)	+= irq_pipeline.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
 
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
diff --git a/arch/riscv/kernel/irq_pipeline.c b/arch/riscv/kernel/irq_pipeline.c
new file mode 100644
index 000000000000..a478e9c3b3a4
--- /dev/null
+++ b/arch/riscv/kernel/irq_pipeline.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IRQ Pipelining implementation adapted from the ARM version.
+ *
+ * Copyright (C) 2024-2026 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+#include <linux/irq.h>
+#include <linux/irq_pipeline.h>
+
+void arch_do_IRQ_pipelined(struct irq_desc *desc)
+{
+	struct pt_regs *regs = raw_cpu_ptr(&irq_pipeline.tick_regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter_rcu();
+	handle_irq_desc(desc);
+	irq_exit_rcu();
+
+	set_irq_regs(old_regs);
+}
+
+void __init arch_irq_pipeline_init(void)
+{
+	/* no per-arch init. */
+}
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 99972a48e86b..c4444577449c 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -171,7 +171,7 @@ asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs)
 	struct __riscv_v_ext_state *vstate = &current->thread.kernel_vstate;
 	u32 depth;
 
-	WARN_ON(!irqs_disabled());
+	WARN_ON(!hard_irqs_disabled());
 
 	if (!riscv_preempt_v_started(current))
 		return;
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 0cc5559c08d8..600e2b51f1de 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -57,7 +57,7 @@ void __init sbi_ipi_init(void)
 		return;
 	}
 
-	virq = ipi_mux_create(BITS_PER_BYTE, sbi_send_ipi);
+	virq = ipi_mux_create(IRQ_RISCV_IPI_MAX, sbi_send_ipi);
 	if (virq <= 0) {
 		pr_err("unable to create muxed IPIs\n");
 		irq_dispose_mapping(sbi_ipi_virq);
@@ -75,12 +75,18 @@ void __init sbi_ipi_init(void)
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, NULL);
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+	riscv_ipi_set_virq_range(virq, IRQ_RISCV_IPI_MAX);
 	pr_info("providing IPIs using SBI IPI extension\n");
 
 	/*
 	 * Use the SBI remote fence extension to avoid
 	 * the extra context switch needed to handle IPIs.
+	 *
+	 * When the IRQ pipeline is enabled, avoid the SBI remote fence
+	 * extension because SBI rfence traps to M-mode via ecall.
+	 * Use the IPI-based fence path instead, which stays  entirely in
+	 * S-mode and can be preempted by OOB interrupts.
 	 */
-	static_branch_enable(&riscv_sbi_for_rfence);
+	if (!irqs_pipelined())
+		static_branch_enable(&riscv_sbi_for_rfence);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 5ed5095320e6..8f842aec1e0e 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irq_pipeline.h>
 #include <linux/irq_work.h>
 #include <linux/nmi.h>
 
@@ -28,18 +29,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
-enum ipi_message_type {
-	IPI_RESCHEDULE,
-	IPI_CALL_FUNC,
-	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
-	IPI_IRQ_WORK,
-	IPI_TIMER,
-	IPI_CPU_BACKTRACE,
-	IPI_KGDB_ROUNDUP,
-	IPI_MAX
-};
-
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
@@ -49,6 +38,11 @@ static const char * const ipi_names[] = {
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
 	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
+#ifdef CONFIG_IRQ_PIPELINE
+	[OOB_TIMER_IPI]		= "OOB timer interrupts",
+	[OOB_RESCHEDULE_IPI]	= "OOB reschedule interrupts",
+	[OOB_CALL_FUNCTION_IPI]	= "OOB call function interrupts",
+#endif
 };
 
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
@@ -63,11 +57,35 @@ void __init smp_setup_processor_id(void)
 	pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
 }
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
-static int ipi_virq_base __ro_after_init;
+int ipi_virq_base __ro_after_init;
 static int nr_ipi __ro_after_init = IPI_MAX;
 static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
+#ifdef CONFIG_IRQ_PIPELINE
+#define INBAND_IPI_MAX (IPI_MAX - OOB_NR_IPI)
+int ipi_max __ro_after_init = IPI_MAX;
+
+void irq_send_oob_ipi(unsigned int irq,
+		const struct cpumask *cpumask)
+{
+	unsigned int op = irq - ipi_virq_base;
+
+	if (WARN_ON(irq_pipeline_debug() &&
+		    (op < INBAND_IPI_MAX ||
+		     op >= IPI_MAX)))
+		return;
+
+	/* Init oob ipis at first involve*/
+	if (unlikely(ipi_desc[op] == NULL))
+		ipi_desc[op] = irq_to_desc(irq);
+
+	__ipi_send_mask(ipi_desc[op], cpumask);
+}
+EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
+#else
+#define INBAND_IPI_MAX IPI_MAX
+#endif
+
 int riscv_hartid_to_cpuid(unsigned long hartid)
 {
 	int i;
@@ -95,7 +113,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	atomic_dec(&waiting_for_crash_ipi);
 
-	local_irq_disable();
+	local_irq_disable_full();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_has_hotplug(cpu))
@@ -209,9 +227,11 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 
 	/* Request IPIs */
 	for (i = 0; i < nr_ipi; i++) {
-		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
-					 ipi_names[i], &ipi_dummy_dev);
-		WARN_ON(err);
+		if (i < INBAND_IPI_MAX) {
+			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
+						 ipi_names[i], &irq_stat);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
 		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 8b628580fe11..3eda9cbb31c3 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -259,6 +259,6 @@ asmlinkage __visible void smp_callin(void)
 #ifndef CONFIG_HOTPLUG_PARALLEL
 	complete(&cpu_running);
 #endif
-	local_irq_enable();
+	local_irq_enable_full();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c62c771a656..be87cd58e754 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -112,10 +112,32 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+static __always_inline
+bool mark_trap_entry(struct pt_regs *regs)
+{
+	if (likely(running_inband())) {
+		if (user_mode(regs))
+			hard_cond_local_irq_enable();
+		return true;
+	}
+
+	return false;
+}
+
+static __always_inline
+void mark_trap_exit(struct pt_regs *regs)
+{
+	if (likely(running_inband()) && user_mode(regs))
+		hard_cond_local_irq_disable();
+}
+
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
+	if (!mark_trap_entry(regs))
+		return;
+
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -127,6 +149,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+
+	mark_trap_exit(regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -421,6 +445,66 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 }
 #endif
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+extern void (*handle_arch_irq)(struct pt_regs *);
+
+static void noinstr handle_riscv_irq_pipelined(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	handle_arch_irq(regs);
+	set_irq_regs(old_regs);
+}
+
+DEFINE_PER_CPU(int, irq_nesting);
+
+static void noinstr handle_riscv_irq_pipelined_on_stack(struct pt_regs *regs)
+{
+	int nesting = this_cpu_inc_return(irq_nesting);
+
+	if (IS_ENABLED(CONFIG_IRQ_STACKS) && nesting == 1)
+		call_on_irq_stack(regs, handle_riscv_irq_pipelined);
+	else
+		handle_riscv_irq_pipelined(regs);
+	this_cpu_dec(irq_nesting);
+}
+
+asmlinkage void noinstr do_irq(struct pt_regs *regs)
+{
+	irqentry_state_t state;
+	struct irq_stage_data *prevd;
+
+	/* OOB fast path: Log the IRQ and return. */
+	if (unlikely(running_oob() || irqs_disabled())) {
+		instrumentation_begin();
+		prevd = handle_irq_pipelined_prepare(regs);
+		handle_riscv_irq_pipelined(regs);
+		handle_irq_pipelined_finish(prevd, regs);
+		if (running_inband() && user_mode(regs)) {
+			stall_inband_nocheck();
+			irqentry_exit_to_user_mode(regs);
+		}
+		instrumentation_end();
+		return;
+	}
+
+	/* Handle inband IRQ. */
+	state = irqentry_enter(regs);
+	instrumentation_begin();
+	prevd = handle_irq_pipelined_prepare(regs);
+	handle_riscv_irq_pipelined_on_stack(regs);
+	trace_hardirqs_on();
+	unstall_inband_nocheck();
+	handle_irq_pipelined_finish(prevd, regs);
+	stall_inband_nocheck();
+	trace_hardirqs_off();
+	instrumentation_end();
+	irqentry_exit(regs, state);
+}
+
+#else	/* !CONFIG_IRQ_PIPELINE */
+
 static void noinstr handle_riscv_irq(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
@@ -444,6 +528,8 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 	irqentry_exit(regs, state);
 }
 
+#endif /* !CONFIG_IRQ_PIPELINE */
+
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long pc)
 {
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4..c5709112c346 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -79,6 +79,7 @@ static void show_pte(unsigned long addr)
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
+	irq_pipeline_oops();
 	bust_spinlocks(1);
 
 	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
@@ -275,7 +276,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
  */
-void handle_page_fault(struct pt_regs *regs)
+void handle_page_fault(struct pt_regs *regs, irqentry_state_t state)
 {
 	struct task_struct *tsk;
 	struct vm_area_struct *vma;
@@ -315,8 +316,13 @@ void handle_page_fault(struct pt_regs *regs)
 	}
 
 	/* Enable interrupts if they were enabled in the parent context. */
+#ifdef CONFIG_IRQ_PIPELINE
+	if (state.stage_info != IRQENTRY_INBAND_STALLED)
+		local_irq_enable_full();
+#else
 	if (!regs_irqs_disabled(regs))
 		local_irq_enable();
+#endif
 
 	/*
 	 * If we're in an interrupt, have no user context, or are running
-- 
2.43.0

