Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC03803C8
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042635; cv=fail; b=uk41ryjaz6IR+7lPvyqSsswRM8lVwmK0joqzK6h+N0dLuin/s4p3+dW7tOPnMlLYRYfccYV/lN1uU/dzOkB1Bq4Nz2h8gLmtzul3jLGaGhE9Y2oWjHsjU2tt6x8miyqr2XLAHfaLIyuQ3f6G9IzqgFe8Uf58H4705mhlo32rO8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042635; c=relaxed/simple;
	bh=9C1FNbHyMDghXSBn3nA+UW4C/5FeLLSI8h/JhQ2nUC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8nJXIsy8ENgZvngxt7c0T5Z06GHaPoOs3ialKiqlTrMpbHTgHop7+h46aZ987GvphOiT9twVu6u0LIW3RYadV05zqBq9FI1YrrV7QPKlsJ7Bpk3ZnKAcy3FjdYkv7SifHTcfYz/4F17jA3KhG16ZxUxzp3Suvr5wGJY0SeCFSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fCpDaTPj; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fCpDaTPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyMGhbqBzsEOHZnK6jXQm/zSJFVtjgE+jTmdUpuJA4qJJ5/21VCRMLKaKPuVBJ5rTQdmXAq0gv7GZ6W2aTLAuaaV0IhGluuv2+JjLB86Tf+PPAelntcS+WVObUmr85CS594de/rronPcGS4bWha0kqNFS/mCsrN2lhMTMWR709cZyCQaa7fizgPc8Ctda2m6ufP7szsyPbCzoB0gEhTJ1UmgRoRaeRI0fn4kRy822ICMxMkS7BUcEXY/51GzYDe+TJHS8HgNaA2zUVZPF6rECdUg1iozte/4SLBZXbmi6qjXrJqlAMvD3npn1Rvl/4GQ/acbtDN0yMBkTWOTS/N3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaI7GrH0OPqy9lT+I+KmzwOxIV3aS4b+gzBlN7kX2gc=;
 b=pfT8Zhb4mcMNMqNAtK5BSQ6IJo3XX9DcyGLXRIYfzi2/NoGXJaNJKevHBqh8p7+pT6OFUuZiH+fdXQB9KycdcQe29g34b+jibhh8EjUZ6Z/cyGmEJ2FvgRw5GhhleiDt5YWt+Iry9/KrEmHDq5h86ByECxum8wGhediiT3fzfldKezGtblPeunU7JiY/Z8P7vDQgXtbcyHenhAxjmhbSfco0lY8Xg8euhXRX14E0QmX99mrzlx7FwuN/ttbGVAHKhccBjhm1qyxmeZL29nItKf59yk8Lv80/k094AgZOosv6/SuOVxIbijdjD1P50vAMLqAKYWU/W929zd5iVddPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaI7GrH0OPqy9lT+I+KmzwOxIV3aS4b+gzBlN7kX2gc=;
 b=fCpDaTPjhNMN5ygco5HE/MbErv4VoIJEO1tGlm5nA42jdAMRWYx7Qhcluyk/C+hfn9n29YWXujqxiOvn41H3T2mh9LdVz3jqN3rOi7zya+SqjklTobSWv3c8scDQW0U8IOWYL/yJb00QiXyYN5gNmrSAfCgfFVzj5lC9QBRpqvsAi1SIw5vh3i2oIZXWeSF/AeTCypO0beBnH6btLsXq805nBUDD5oKmaftqOiB6e8YsfqEX1otqAqr/fzYp1mJLWFnano/Ka0vu2dO+tPkUdhbEUwQGkbA0SqxthuDAT2ItZn02aEaDLF2XTBk3tuZI1hT9houwy1whGTk/CJ183A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH dovetail v5 02/12] riscv: irq_pipeline: add IRQ pipelining core
Date: Fri, 20 Mar 2026 22:36:47 +0100
Message-ID: <20260320213657.2210419-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: af4ea9b4-61d2-41ff-b8cf-08de86c8d600
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	/g3CX2XdiFco346AZ7z1LyUuzHTTEiCEw2JLcJUSHEnr6KyGtuupp62iTSE0bTc7ukt4ZGm6BcD6VHYterQk/IZ9Df7yL4G4X+bnZYCqac4u2lw3llSL+Yt1ASpjvYEnXfnhagXazgIlQ4otOi+HdvGo80gYEMjRp9mnFNsDk9DvpzecyNF8d3I92EJHjbQjaleAG/W2OGpHZ95sBhXXIjeWOkeZFwELKHsoiqIcPixXmq9vSRiU4giTnVkzJx0KB0aeS6Ut3GSw7Okblaxy6sdFjwUUygUzH+tBDtQVFZ0S6nM2FsTnKU3Lzlz9M865JTGMWIHIcw4+DKXafFtS1lziuliimS/8lDpthaWw98W4aDcxxjtZ8lQL9AAj0sIcYlmkDKPPKd1aFXGs6VhE+BUwWj/Xp9L4qs4KuspLPBisus++7z7DSjxKsX+f1605WlrWwyCUSgWNAgXROeuWFK+Ch1llEi7HM9ZXgQ+8VmHuis6PxuF/AsbVgoxZP1NY493GxVYpk9dkaRPO8SmbVv5NzxvTZSqIS5INcKr1Nj9v+2bXeUZaVpo2Vqj9rRgiEQr20mm6+m4FkII5ctjID8pirJJBPtPSY3m7WXausaYmEvY0pQ5Vr5QuV68s1KmrfiadVLbkD6Y1EzAMQk4P1ffqVnpAnsLJAt0rN0OWaMjybC8XO3EzsrCEhGSBiGv6RJhUEuBknY2cWrBWMoKgvEbqn2aUMWiLXEBA2US9y8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/2OE+nrk8t6kqo9fbUupWvuVvjtFIeiGgF8I31mAbFIWQu6L7sAiD+odhKjc?=
 =?us-ascii?Q?CZyz103wszGGph/rufnJtIkLJKAakd/uUgl8u00z81IVg4BDuO/E9hDJ3S1K?=
 =?us-ascii?Q?GcJ/V8eK/mZ73p5aapiQscVhFjvO5+kK4Q6qz2FsdZB/Rilg6z3V5w80ctr8?=
 =?us-ascii?Q?90gY73o4j5DobepUXoQU9Oe/nDY1O+64GzMpyZa4VhipOyzZ4iWyyuSofqMQ?=
 =?us-ascii?Q?gc08DrhzgtJDWAWddr6MB34ZmEAOZq2aEcQjqOi6zI6F2qnCN76OPMur0ACA?=
 =?us-ascii?Q?fpBvPTrkko90Ul9ALFJbpOLHZVTauZvhz1O0N09obfgrR027dHWYMavk9U3w?=
 =?us-ascii?Q?xqHp/8PmhrLdsiRpElck/UdsEbWVdmiM5oKE+L9u7cdAfhLkzWOFZCAP/71L?=
 =?us-ascii?Q?S6USdorDQwxMVPQMkRG08Cq8u9Dvz87ASqWkEmgDnVwbkxwX5DU/kkiAUMep?=
 =?us-ascii?Q?UeC08DncObnSvAx5TxX5qoHvHqRLMioyZvhtrwZHqSHX5TVqhmHHfHraSqn+?=
 =?us-ascii?Q?aTbGLKOssQhRlAE0rvq7aS6mxu0+hzB2CcUVDgkU+1gwsOoQadaRHDKhWewH?=
 =?us-ascii?Q?3bjt9922Jn1SlDcBQ3gJyRvb3EVUZGgWZzh+C0hLC69DajRKXB+fPbSL4FnQ?=
 =?us-ascii?Q?VvWR5wIDYIaav2zzOVuuCUr7doXJ6SO3/o6tGKk6enjBbHdMF6QkqUz/q5g8?=
 =?us-ascii?Q?DmuVMPb5ZRI/N3Ug9lkx5j6i+3VUhX6oMHfBQxdJOgJIQbDDsgd7vzN7GQEC?=
 =?us-ascii?Q?pcpGlQ2aYv/q/kVbom67/LSW/ycojEaUyTfcbLTY/d4xQvPVHSzAp5TMuxal?=
 =?us-ascii?Q?7O8okFgfFmp2vycbnlbIM4bhLw/GzzgkhPrZ9+9p0Rbx6HxSGgtm2QRbFoV7?=
 =?us-ascii?Q?TKKCiLCudnkcXEMgEv4LsNmccAM1dJk31BKbE7qoYloVydfn6653qQn6zpvX?=
 =?us-ascii?Q?+FeKZjMIe1O1y71RZ1eaMYNGYBo+xV7nRXaCjjzMwUTB6ya+Hy7APy/DEStJ?=
 =?us-ascii?Q?vLNV71AmQzp4OKRF5ac7YkymAna8FBwxEvQp4BxV7GRcgMfVIha4u0h7i4RQ?=
 =?us-ascii?Q?i4xy9DdrWKAVEGP/lvJgBeCPSUeaG6ahJkPXm5qA6ZVmTJp3XdA/e+3o99+0?=
 =?us-ascii?Q?8PcM3Y1j7s5LNGASU/p6e9HL3s4Cpg4Khc/asrVK4e82eubuNW2qhWK0cafl?=
 =?us-ascii?Q?XUkYN1CIPSJNr4Rg/VcCAVhfQH1SRP5J77/6G/Z6HKXM9jXc5h4bKBPIw+kN?=
 =?us-ascii?Q?Wo7kBPwCGc7PI9VAzQxfdfRD2uU3LD0lNA2jhkWnpk5GoWmK0fobybg/Tt8R?=
 =?us-ascii?Q?KYgXbON+4A3WaGXPxiKIT+/lutWaS8i3fQTBnNeEeB9u/Xuo7AJb8aGLTGTm?=
 =?us-ascii?Q?OKf0ei8exXG8NcSjrS3ZorkCdToMm0ex3f5n6xkPl89Fu8Og/8/dq3OJNAms?=
 =?us-ascii?Q?aGRzumw87fan4nZictY+T0Bj/Pff2WdczObqIihlaeB/vul+/2LWvxrKYAwl?=
 =?us-ascii?Q?G+yHfu53I4p7sYm6ZuZPPPN94q4yKVODsvICAk3ab8wpEGax9ZTozNabpC6+?=
 =?us-ascii?Q?qzWPTPdwBZqSppvq6Ao/7AqmhfgYJLjk/3GsQAjBoZKeUqulYkGQ2BkMlrB3?=
 =?us-ascii?Q?iZKE22yIBSndgSNVKUvZZZ0B04qz5e3TERuN9k0JJSmGOA7kNYqmFysbtjmW?=
 =?us-ascii?Q?vYPh6yt3bmi/S0qp0MdeQT+U07uqGRKKYuDi/AYmSgY452Wo6U4dTxXdgdTN?=
 =?us-ascii?Q?RmQUTPahfgUmghnY3qUcSu9fYaWJuLk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4ea9b4-61d2-41ff-b8cf-08de86c8d600
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:07.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcSp1h1Qiu/qRoOHusF9hNtn29ou+caJqt/WW0NakVlQNzLFzgxLAIVFJDjVv10N7/GMDQJ7dg4fJ7+aDivbNSQauUDGy4kvo7Xa6NH1b3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

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
 arch/riscv/include/asm/irq_pipeline.h  | 145 +++++++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h      |  32 ++++--
 arch/riscv/include/asm/smp.h           |   7 ++
 arch/riscv/include/asm/thread_info.h   |   9 ++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/irq_pipeline.c       |  26 +++++
 arch/riscv/kernel/kernel_mode_vector.c |   2 +-
 arch/riscv/kernel/sbi-ipi.c            |  12 +-
 arch/riscv/kernel/smp.c                |  55 ++++++++--
 arch/riscv/kernel/smpboot.c            |   2 +-
 arch/riscv/kernel/traps.c              |  88 ++++++++++++++-
 arch/riscv/mm/fault.c                  |   5 +-
 13 files changed, 357 insertions(+), 28 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5..0d8291a6c4da 100644
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
index 000000000000..30707d77c924
--- /dev/null
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -0,0 +1,145 @@
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
+
+#define OOB_NR_IPI		3
+
+extern int ipi_virq_base;
+extern int NR_CALL_FUNCTION_OOB_IPI;
+extern int NR_RESCHEDULE_OOB_IPI;
+extern int NR_TIMER_OOB_IPI;
+
+#define CALL_FUNCTION_OOB_IPI (ipi_virq_base + NR_CALL_FUNCTION_OOB_IPI)
+#define RESCHEDULE_OOB_IPI (ipi_virq_base + NR_RESCHEDULE_OOB_IPI)
+#define TIMER_OOB_IPI (ipi_virq_base + NR_TIMER_OOB_IPI)
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
index 7ac80e9f2288..f559c4f2ddc8 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,6 +15,13 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
+#ifdef CONFIG_IRQ_PIPELINE
+extern int ipi_max;
+#define IRQ_RISCV_IPI_MAX ipi_max
+#else
+#define IRQ_RISCV_IPI_MAX BITS_PER_BYTE
+#endif
+
 #ifdef CONFIG_SMP
 
 #include <linux/jump_label.h>
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 36918c9200c9..8a9e85c6e631 100644
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
index 5ed5095320e6..63711025716f 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irq_pipeline.h>
 #include <linux/irq_work.h>
 #include <linux/nmi.h>
 
@@ -37,7 +38,13 @@ enum ipi_message_type {
 	IPI_TIMER,
 	IPI_CPU_BACKTRACE,
 	IPI_KGDB_ROUNDUP,
-	IPI_MAX
+#ifdef CONFIG_IRQ_PIPELINE
+	OOB_TIMER_IPI,
+	OOB_RESCHEDULE_IPI,
+	OOB_CALL_FUNCTION_IPI,
+#endif
+	IPI_MAX,
+
 };
 
 static const char * const ipi_names[] = {
@@ -49,6 +56,11 @@ static const char * const ipi_names[] = {
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
@@ -63,11 +75,38 @@ void __init smp_setup_processor_id(void)
 	pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
 }
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
-static int ipi_virq_base __ro_after_init;
+int ipi_virq_base __ro_after_init;
 static int nr_ipi __ro_after_init = IPI_MAX;
 static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
+#ifdef CONFIG_IRQ_PIPELINE
+#define INBAND_IPI_MAX (IPI_MAX - OOB_NR_IPI)
+int NR_TIMER_OOB_IPI __ro_after_init = OOB_TIMER_IPI;
+int NR_RESCHEDULE_OOB_IPI __ro_after_init = OOB_RESCHEDULE_IPI;
+int NR_CALL_FUNCTION_OOB_IPI __ro_after_init = OOB_CALL_FUNCTION_IPI;
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
@@ -95,7 +134,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	atomic_dec(&waiting_for_crash_ipi);
 
-	local_irq_disable();
+	hard_local_irq_disable();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_has_hotplug(cpu))
@@ -209,9 +248,11 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 
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
index d85916a3660c..5eae21d4a0a8 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -263,6 +263,6 @@ asmlinkage __visible void smp_callin(void)
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
 	 */
-	local_irq_enable();
+	local_irq_enable_full();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 5fb57fad188a..267b8ec5a1bf 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -176,9 +176,19 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		local_irq_enable();
+
+		if (running_inband())
+			local_irq_enable_full();
+		else
+			hard_local_irq_enable();
 
 		handled = riscv_v_first_use_handler(regs);
+
+		if (running_inband())
+			local_irq_disable_full();
+		else
+			hard_local_irq_disable();
+
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 				      "Oops - illegal instruction");
@@ -308,11 +318,19 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		local_irq_enable();
+
+		if (running_inband())
+			local_irq_enable_full();
+		else
+			hard_local_irq_enable();
 
 		handle_break(regs);
 
-		local_irq_disable();
+		if (running_inband())
+			local_irq_disable_full();
+		else
+			hard_local_irq_disable();
+
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -429,12 +447,72 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 
 	handle_page_fault(regs);
 
-	local_irq_disable();
+	if (running_inband())
+		local_irq_disable_full();
+	else
+		hard_local_irq_disable();
 
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
+	if (IS_ENABLED(CONFIG_IRQ_STACKS) && this_cpu_inc_return(irq_nesting) == 1)
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
@@ -458,6 +536,8 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
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

