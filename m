Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCA3093C6
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206800; cv=fail; b=USwz2UgJOJ4TcI+XKnaq57GZ/dtaNdKu6C27UOdlaED43ftm8m2I2z7i1kkRt3kTDF/DQdnKhl1Y8PoA8WZ0ZS9ILfreYnmN9Jq7eXvnaYwOipHG02BZidBEEPCX7W3BFhyNF8eVLfHuhF9T8NjVgDAQTdhrFEWzPx0/oA8CFeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206800; c=relaxed/simple;
	bh=zSVySJjfEFzCRFgtbTXdIVII9QfPB0t27ja+I3H78/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FA3ZYEkSHX7LQXXgOJEvY71lZW9NTeHZCBV15PG1qcYbRjB4j6h1UrEMpyvn0G1gexauFgJ9Z4QRAWyRisVwX7kgRRhqkMqspr9IpFg58nyDg/AtUCx0WwhUrzEZgD6tMV7sUDAd/0Clq1OhGaO6qqZIdyeAlTrektTD/Ii135E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dmRb2rJ0; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dmRb2rJ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFQBLY0hxbKbQE2QKmkSu66i923VCv48suwcbmX6VVhXJ2hWO+1huI0IJMrF9xYMtKEb/XAKCBX08cmnaAYOY/cP1olWf9iZPxl4ILmCuLTjDofnKj7ef86mM+hfIPPhEkMNFU6PI6inClr2VZ0R+d3kJYINytfw/UBua9W+lEqy2oESBuRzzVRUOntHN9cX3HtMhKQgzwR3tohcIe5mlePbPmnj/r2B7+/1QLFBP4AmDddALR1Aoq1t8FOH5EpOWib0B2zeeIe19Qx0eDK0Yana8jjvUVlCwhQ6OzsYFGGDnk+4A6dLSKwq7PZEMDU/nNx98QF1hXZdDWN5NcIodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLk7DyGKBRzmIgHTCSOP7F38htJI4yM/PzlM0ZFJ/84=;
 b=IY2fOGtcBKBQP06EPyk6iQ+IvEJNwmyohVZbRFEYCP+EK+wRAVgnkclZVKMefEEkwOX4ydKXaZqlIJPTAWJn/8JsPlK7/6Kx4aQyNFlaLoADHo2oBt8m+froR6W6+RpkFpRAs31fY1WCotAkWpMNyw+PlNDdi31IM3HksE5XWx4Usf0Jb5KDzw6hJa7M8hlFDTZRr2uVs2uGaSLJTCFckMrH4UQuZvjKvgMH9wOcO+8lEH8rjxWjUwqsu6cFX+d4kkbGe8giQ7mDmLw8Ea49hQyaFHZ1UmVcUhftDaPVMF+hIIK9EFPsjzpggaSSlT6f6YEfuyrvzEEBotuoLnQLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLk7DyGKBRzmIgHTCSOP7F38htJI4yM/PzlM0ZFJ/84=;
 b=dmRb2rJ0P+R2qqA0P6qBJtwclCCmG5k7MrLUyXqg/tG5VDWNK09Gg3fW8ZsYWm7WV/y12WBmh/DI5r4cJOpiZdh85LAVJSzkdpT3bLoX0lpw5RTVog298zo+dfJsq0mqIGSnKcMrxewP32UtrYUD6qgTiAOxzgIi2oMAvgBumufYP51ZGLtaMCrakyIi9Q4Efl671F8XEn8M2SxjXytqv6iuK1aYh05CvryqeyHNwI2roiQfKkihFSSbMf5ST9sAZwzSpGciv1kIF6IMDGi4dtKbJPbhziDkZ/b12MUveQI/LGUR7gttB81zIeh4AzmREbZGCvk57yHnsfWZOKgsXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH dovetail v8 02/11] riscv: irq_pipeline: add IRQ pipelining core
Date: Sun, 31 May 2026 07:52:55 +0200
Message-ID: <20260531055304.2890455-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: bfe19e44-48b1-4fb1-be2e-08debed8e70d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|3023799007|18002099003|5023799004|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	O0HJ5HX+J1KIJtmCT0WPd4LI/zpJUNcuelx+nS2e/xUbFUSqJ4CjWPpL+4/WuoLVJ/pio/vZ/JSRzCRZnfLdOLxTq0ekjkmpCe68r6o7Rrbm+zz4bRylPSVYMkyegx1jlUPW6ppgKK8tKywtjAuYoVCUiujaflPzNLKHU14IHXQklkiPuTnErsXmu+yrfcSMpYjFDI/rBX/xeII8Iz6gkYuCDlX6LXRji0XANwv3UO3JmuiMDB1daZkLFio6w5aEc4uz+qgG9vcOQ96AfRTK6a3ies4UjhYHPrydHPTnGvv02WobE9Sd9tofhAsb1/Tu7n+SrwNv7dDyFWEr9YStQDbONMO14Jh3h8OhMtmwigfbUyU/QSKw9r/6R/3pQYErdmKjWLJ7O2dR+XdqXZ/NDa0Tt1zYGjg/VgW8Q1GxJTQViHaX3BIezq+THS9Vr+Y72ytltbqVxXrVzkdD5/xfeC/gjnYYCpndKTLxMb7XbZOYiT3J3u9H5BVpMT5FDYa8KbvrooXjMeqiPTKA3l029n7SeAqaRqYugjnQZr6TyJshoeeDBvvzRXbH6X4cIDlnA62iwN68GX3ittmLfo4Pv4cBEAb6FoYvMIERetfrUmASWJyCssCVhD6Xg1KTb+e8zbMJr1UXohJcRTNHJCyMYWFJVlBZ2n12b8nJ7kEms/LOp1tNkMTR3ZfyaQNguwCo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(3023799007)(18002099003)(5023799004)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JoceaflZClDgDomxw1PX/ChBJ/tZeRZ+0Gz1Kxh0P3LT0Juil3boWnT5JVa3?=
 =?us-ascii?Q?6f20ug91KpDu6YFLpkZP28lImfOGKwkHDxuRKNVNAJHXyntpG/0YnvkEBDtU?=
 =?us-ascii?Q?Qh8f0oJDCYmNqsPUZ/r37WhuvEj4GHMmClPgM/dB7HAXPOHcJ+bahEkrTMTY?=
 =?us-ascii?Q?n3MAALFCKdr5X7sN/622tq5HPVzMmgJZEve5gRGcXw1nZX50IP3jzqN49izv?=
 =?us-ascii?Q?/1nhv8aqr0xKHyd3Q/EtsTO9OwNL30THT0z1RyAynTNmVArrSV7ACr7iy95k?=
 =?us-ascii?Q?B3bQFvGUvyPeNh8K8kQwvsO0j/XwGKAVc9P2Dsup/ntZR7249yh+xGK13Pmv?=
 =?us-ascii?Q?CV5YxFXM4Npp8sUG40FA54+jPNt10Mw1ZqjAb0fuSRkBpI39y46OG2znLJ04?=
 =?us-ascii?Q?wv2vUP2CegEmyzdcUAWyuYSE1DacpveD3bGR13idT+w34D58XquRCIgDD+bE?=
 =?us-ascii?Q?AAci5Ozp3hOcOY2Y9MHqPVv73ETzLknk9kixlDWc7Utbfj3oKAn17JKKYMsS?=
 =?us-ascii?Q?3LjCI2YQaDFv5ajyESgdPTpAbCRTxUxOsH9HV/KZnnDSY+44CSjV9OPQ6+dm?=
 =?us-ascii?Q?NbOBKuznZ7cbArh08jgwYzh3b1spUarBuOXZvZVINBaj5BF8oT3fk5Z0en/C?=
 =?us-ascii?Q?nPo/GHcnOXgN6R1GM9Io8TeN3BZJZCj1fMtmSZU2dUsNL8EoiBa8LwFtBzsw?=
 =?us-ascii?Q?/Ejsfi9VyWZCsO6w7/abuSGLeYSIHg7LADQnpSKfmkFD7N3hg6eM639dlyJD?=
 =?us-ascii?Q?raJW6KCya/XNiFFcIYAyPGQEqjMEs2sD626ucn/2d1GqPcJl63q1EjmDGBKn?=
 =?us-ascii?Q?LGVJn7UuJvG79U3aH7rtn3sJA3FDgi7dmcXVTIqT8Cj51CdFLCEwk8dTlVzo?=
 =?us-ascii?Q?1EmhdrR9CGBhGwtPR4ZGi92RL3Ws3JC56DxB76na255ckONjaavWVVdnfGmj?=
 =?us-ascii?Q?o2zjJ/BA+dyqDzNawfx5RlHJaAqnulEvm6EEQniGYU9fLlybz5XE/q8g5cRA?=
 =?us-ascii?Q?1/K4GeeFDau5Z7PZ0dlGyssbR+Q91hUj1fcdFyQ7y3FC/b/F30f1qhXdw0If?=
 =?us-ascii?Q?gXlC8+4RqOGSseiBlrGrUh9PYY+uJp+f+/wymoT731CFTBYZdA6trCxx6zkk?=
 =?us-ascii?Q?7uI0bzgpRW0yW6bImUQUyy/uEipXvv9Ho6ZjcYUgS9d4JhOUWEbsTgdYWbHp?=
 =?us-ascii?Q?JHEJh1fgcAfk2DWl6Tel+dBsCCTqbGpdncNICsl0lY/dBMSn2i0SzTKNR73b?=
 =?us-ascii?Q?Ns3//EiGt+kPRPSD92sz/KFAbaHncMhM7KraQtNR72G919CLKRRCiKj6M4nV?=
 =?us-ascii?Q?NMsiPBiNqsZRFnMnOa0xv34vW1TZaS5hE3/8fD/6cTfPgqmiUYhlxXlwkdnE?=
 =?us-ascii?Q?M1hzMwYqFitZ8O+seEqB0cUslUyDQ1xX9Bski3uGGtVOCv7tFK3KWbAZI67L?=
 =?us-ascii?Q?Xcw+HOMqD6Q7cQJLk3elmVPBE+Tr4DlnxpA2xTn5wJh/cjt1dhtb/GsFoxDH?=
 =?us-ascii?Q?uEqh2hOQvkKThiy6BXNKc8qcyBZBC18GiQtDj+zfjJ0xxJM8XzKzkDzYiZ9O?=
 =?us-ascii?Q?a2FPS6HGyL2EOtcQ/axE1tSoOYALIerzl/DyYgYAPUaezzIvqatc5IxRpJ5e?=
 =?us-ascii?Q?baSuI1evSZ+r7f/faZMdESoL4cmVoSnVKvJweTkOO4AFQs3xcJ4xT2T4rnnm?=
 =?us-ascii?Q?03l1oLkfN62WdeMXEFynV8soDrnwJSdTWZCQrY09G0CKas6e6Qd5ZFgBHpnE?=
 =?us-ascii?Q?zQUaUQxK3yJHr31/j5G1xycg4MB7kLM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe19e44-48b1-4fb1-be2e-08debed8e70d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:13.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voib9o0pDHiNKnHl29oksowKN8BUf2/I9wL2dULd1MJgQtn88bwrIiSEJ9j9R8Uru3ElrmAy2xZaX9gnx9NTN8EelBJU30kHm5fjagXpOsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

This patchset integrates IRQ pipelining into the RISC-V architecture,
bringing it in line with the Dovetail/IRQ pipeline model used on other
architectures. It adds the core pipelining infrastructure and adapts
low-level primitives to cleanly separate in-band and out-of-band
interrupt handling.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Co-authored-by: shannmu <shanmu1901@gmail.com>
Co-authored-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/irq_pipeline.h  | 143 +++++++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h      |  32 ++++--
 arch/riscv/include/asm/smp.h           |  25 +++++
 arch/riscv/include/asm/thread_info.h   |   9 ++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/irq_pipeline.c       |  26 +++++
 arch/riscv/kernel/kernel_mode_vector.c |   2 +-
 arch/riscv/kernel/sbi-ipi.c            |  12 ++-
 arch/riscv/kernel/smp.c                |  56 ++++++----
 arch/riscv/kernel/smpboot.c            |   6 +-
 arch/riscv/kernel/traps.c              | 127 ++++++++++++++++++++--
 arch/riscv/mm/fault.c                  |   5 +-
 13 files changed, 404 insertions(+), 41 deletions(-)
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
diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
new file mode 100644
index 000000000000..d4d4b7e79c67
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
+extern void (*handle_arch_irq)(struct pt_regs *);
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
index 8b628580fe11..2149855320bb 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -259,6 +259,10 @@ asmlinkage __visible void smp_callin(void)
 #ifndef CONFIG_HOTPLUG_PARALLEL
 	complete(&cpu_running);
 #endif
-	local_irq_enable();
+	/*
+	 * Disable preemption before enabling interrupts, so we don't try to
+	 * schedule a CPU that hasn't actually started yet.
+	 */
+	local_irq_enable_full();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c62c771a656..a3f6dcc2eefa 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -112,10 +112,33 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+static __always_inline
+bool mark_trap_entry(struct pt_regs *regs)
+{
+	if (running_oob()) {
+		return false;
+	}
+
+	if (user_mode(regs))
+		hard_cond_local_irq_enable();
+
+	return true;
+}
+
+static __always_inline
+void mark_trap_exit(struct pt_regs *regs)
+{
+	if (user_mode(regs))
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
@@ -127,6 +150,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+
+	mark_trap_exit(regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -137,6 +162,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	if (user_mode(regs)) {
 		do_trap(regs, signo, code, addr);
 	} else {
+		/*
+		 * Dovetail: If we trapped from kernel space, either
+		 * we can fix up the situation, or we can't and we may
+		 * happily crash with hard irqs off. Either way, don't
+		 * bother.
+		 */
 		if (!fixup_exception(regs))
 			die(regs, str);
 	}
@@ -153,9 +184,12 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		local_irq_disable();						\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
+		int stalled = test_and_stall_inband_nocheck();			\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
+		if (!stalled)							\
+			unstall_inband_nocheck();				\
 	}									\
 }
 
@@ -174,22 +208,29 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		local_irq_enable();
+		unstall_inband_nocheck();
+		hard_local_irq_enable();
 
 		handled = riscv_v_first_use_handler(regs);
+
+		hard_local_irq_disable();
+		stall_inband_nocheck();
+
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 				      "Oops - illegal instruction");
 
-		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
+		int stalled = test_and_stall_inband_nocheck();
 		irqentry_state_t state = irqentry_nmi_enter(regs);
 
 		do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 			      "Oops - illegal instruction");
 
 		irqentry_nmi_exit(regs, state);
+		if (!stalled)
+			unstall_inband_nocheck();
 	}
 }
 
@@ -217,11 +258,13 @@ static const struct {
 static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
 	irqentry_state_t state;
+	int stalled;
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
 	} else {
+		stalled = test_and_stall_inband_nocheck();
 		state = irqentry_nmi_enter(regs);
 	}
 
@@ -234,6 +277,8 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_nmi_exit(regs, state);
+		if (!stalled)
+			unstall_inband_nocheck();
 	}
 }
 
@@ -306,18 +351,24 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		local_irq_enable();
+		unstall_inband_nocheck();
+		hard_local_irq_enable();
 
 		handle_break(regs);
 
-		local_irq_disable();
+		hard_local_irq_disable();
+		stall_inband_nocheck();
+
 		irqentry_exit_to_user_mode(regs);
 	} else {
+		int stalled = test_and_stall_inband_nocheck();
 		irqentry_state_t state = irqentry_nmi_enter(regs);
 
 		handle_break(regs);
 
 		irqentry_nmi_exit(regs, state);
+		if (!stalled)
+			unstall_inband_nocheck();
 	}
 }
 
@@ -344,12 +395,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall_exit_to_user_mode(regs);
 	} else {
+		int stalled = test_and_stall_inband_nocheck();
 		irqentry_state_t state = irqentry_nmi_enter(regs);
 
 		do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->epc,
 			"Oops - environment call from U-mode");
 
 		irqentry_nmi_exit(regs, state);
+		if (!stalled)
+			unstall_inband_nocheck();
 	}
 
 }
@@ -414,13 +468,72 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 	irqentry_state_t state = irqentry_enter(regs);
 
 	handle_page_fault(regs);
-
-	local_irq_disable();
+	hard_local_irq_disable();
+	stall_inband_nocheck();
 
 	irqentry_exit(regs, state);
 }
 #endif
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+extern void (*handle_arch_irq)(struct pt_regs *);
+
+static void noinstr handle_riscv_irq_pipelined(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
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
@@ -444,6 +557,8 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 	irqentry_exit(regs, state);
 }
 
+#endif /* !CONFIG_IRQ_PIPELINE */
+
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long pc)
 {
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4..885e2f66515e 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -79,6 +79,7 @@ static void show_pte(unsigned long addr)
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
+	irq_pipeline_oops();
 	bust_spinlocks(1);
 
 	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
@@ -315,8 +316,8 @@ void handle_page_fault(struct pt_regs *regs)
 	}
 
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (!regs_irqs_disabled(regs))
-		local_irq_enable();
+	if (!regs_irqs_disabled(regs) && running_inband())
+		local_irq_enable_full();
 
 	/*
 	 * If we're in an interrupt, have no user context, or are running
-- 
2.43.0

