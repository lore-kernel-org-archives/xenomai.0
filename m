Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49941417371
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092477; cv=fail; b=XxSrJej3MZht0AlejT4UxBA1BGcNv7YrdEK2f72Z3JD4b8VSejMm+3UBCWllcaAgJ63jy5rosw5WahbP0ACOHCp02uJgLQCCZtvtYs7phBuLXPGxRmQNG05WfT8rSJD16ia40guJsUXLeqQDm9E20IEG18ABzXK5ch7wxtGBHbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092477; c=relaxed/simple;
	bh=XUeUSUYiGNQ9LszHFaOVVCTQxuwChYLj6Msbo92jqOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+bkcEhiaCpaf91RvL+csDSxicCDxIuUH/A17ajbeno3a0sGHiUSRc+zRM5uc+DEc25GJJAipjhFjWOjFb/sG3/77AFduNbZeLoaonU2KOAoQcR6+DVpy07OSpIrbsga63JbUAHyKqXYEsLOjbh5ApSgj1lrMww1PCC5UmILKq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cKIxExCW; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cKIxExCW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC+qtSV8AeXCLliCXM9UJL3mSJLCvJcRlNXLVu+7lO6Vw2sadqx54uIE3aMsqfN6glgBt5BMew1VrtzY1yKCIoLmo9V3J1o8Gbz3SzGQ7/xPpWnZEYvLq5Ep8Jljg7sqxbCwyagsfFLR+FdZsDhHyje3Hv4gmmloOb9KuTM+lHPfqt7LkpBNhNp0LIy3PjsL3htDp4T/40oBCNqEyakDQQ76DfFJYPA3c/mi9mo42mkcn7VRNxiNE3eW86CpB4FgWlt4vcLeg9bzN9Uu4vtYSdYMh9kC4R8IB6SdsunJueZa6juhJ6ikWUtCFTVSkL4TvfZyHueJvMfYJGHFNwoGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t1z1C0VBReiysbcNBXANN3m/Cn2DXQl7DM3P9Hviw4=;
 b=gMDs9fyUe6r9Ri4kRGPEuSswA2yEF70Y8VFy8ZPEC061vZG6zcl1Dt9n1i37w8RW+JGq4nQKNlmT7IAUW1I+Hu6p04eJVtYo5dNjN3yW351lJolqoOhDcMfax1K7Aw1+9NVcw+s0shQg+W5UkREBMFwaRcRL7Zy704UGXF/79xbZYygFtS3ly5aCmPXkWbv7zjzizu3HGIIXQEyLGh0Kz16Z+aOaD1+adjCR5gpXvxbAK34w5ue1DY3FzMJeDn4TtW+ItJicA1eiw22HVq12Rk6+vy+DhmKi/KfnSjRtYhsMWnpuCmY4HXUojZywnKCZ+MWAjffZe8B9bAShx0/ZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t1z1C0VBReiysbcNBXANN3m/Cn2DXQl7DM3P9Hviw4=;
 b=cKIxExCW5h0pfz6k8RgukMcf+3vtIpuk9bueLnKJK4YgcrqhdA5EaZwm7frhToStP2w6u+X7UeFPrbJK6+p/gzR9QllQ7+dRJ9HoUmRidN1CkxcmMEU3gvUYAfcd5axh021j1BN/6duWkCLlgDFlvks9pSghLAKc3xaZbZ1PviUHTEDnC/Quacq+6Zr27RebwmDv+frR5Mpl1u1k1vEELIxxrx+yJuEsE51vyLuwrvn8kEQj13/kuaUqxiEzrD5ALz5hppVmI1HtDuoJAlFxSJjNaZcnfbRcCV1Y0maTEK4JsBA4Vmrb5AdcJ2B0BASX4c3zS448i1j41GfEkffa+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:48 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:48 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH dovetail v9 02/11] riscv: irq_pipeline: add IRQ pipelining core
Date: Fri,  3 Jul 2026 17:27:29 +0200
Message-ID: <20260703152738.129122-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab39e609-ad43-4df3-7f12-08ded917a33a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	1ZrJtiK3Q2Xy/Kewl4sLDSxkhRBzOSam7Vjv1yLbhIZdMLn0zAhf3ALaQ72Ba7s1gwn+Ze81h1ADCI3zWnVaAOy1Kp9a7obJTLaKGHa216qHJFzDFK67SR3spXp21vZHa2KlkqekMd1awu/GcnyhKDZpC0AuJomGt3bkdKhcg1DsK+ws9R4yxoyYeBvAnctwXNaMU4/KGeZYnhEiUt2lbyik21frcrswQcW0TXmN3KoLCAApC9thmUqlMZMNK6o2P2vK73O0gkS8FDNuAmwGcoXQYP0XBXd02w/nnFzxjEdVbeb08RjfBr4I69pvBnnKWtqJoXz0BjqqoB2kyYtCgy4WkyL9aUnkkI2kvFLcpLmz1znIKn9gtOnjW2RwgYJgj+ETiwNhNXGDWzJRI08wE1YUULHKaE6jwaLOMpW0qucx4VZNEZAQx9jNXvGFwqOgRQw+9kcAuU9WnwgYNn1trPx864srEccZpIUFGuBI8CDJVCbSl8nETCPfw8ueN4Zuhp3lBUKR6zpvw9NoX5gmx+jep0bEl6P/o0SvZvP9G3ZwVgXuysieoHA8wYcULRSDcchATUJBujlHj/Nq+LU+Io2FyXzkmqx0azf0499ogZ8BDl9Itpf1Hw3Dp5uk9seV0iuWEjmgEX/qQfqp7jLPQHRhneTvvFMjDYDmLm9DUDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eFPH0jNmr3rsRAFPlembxSBjYK6onq6l/AMQTMnyiMRml5vgH0IcmAH0vTfo?=
 =?us-ascii?Q?wEDG2lGPu+hmlD2g51DBgZeVa/U5qSVZCR7KkW8B32gaotPQkDxczBvbskqe?=
 =?us-ascii?Q?S9XOtNTPX0OQLyfKW3IrntCbKq8mkU9KDUC23sTWeQzNrltK5YJeh3KVPh05?=
 =?us-ascii?Q?2oFUONiClIGPzRz6BEPJG1XtSTwic0hnGUnQDSFMGxnwlG9ULNyW4b057Sms?=
 =?us-ascii?Q?K4i6hZ/oZ8NB0L3lr6Vstv3+7sA0HUctb7H7Fdar8fgdRlrdRW32cX08FWOO?=
 =?us-ascii?Q?8NjY4qxtNgjPWlX9Xlv3oLBZcmmhbq2YKF/EigtqQWD0o7rTPBlGCbqIpjtz?=
 =?us-ascii?Q?um9VirezBl4Io3o3MVADtQNxU6r9GKwRIJzLNFeP27N1gSaD2PSM79NXBQGO?=
 =?us-ascii?Q?pfuw4zU/tCj9YksRZf3j+kmXqY0368A2SuruACS4BoIapUc8LJz7pzwKyjJE?=
 =?us-ascii?Q?AurgE77/EWN7CIaJZsbVTcYirJmlfJTY93F+IxvGKW93nidfYbK2tYPfS9e6?=
 =?us-ascii?Q?4qObHKUZMQOrt68Syzrw10los3V9PKJ1fsz9rFk/7jBldjF3frdlLO2ZUsiV?=
 =?us-ascii?Q?5ttRw02H0dDpqpCiz+8FrhLDCLq3GFc6HAl0mDD+KJYakfRddOCTu5cZWpkN?=
 =?us-ascii?Q?6Y3zj+KKiHXGdYUD4iMSSYU1kXmUIhNYRhjRbRmzhGAfw1Bzwym17KCFHvhG?=
 =?us-ascii?Q?eDQ9isB+pvzVdoJH6kvOHj9gUPgkwzFDRFpiHo+xE43aqzob/d25WECrs/yQ?=
 =?us-ascii?Q?Y1pHH+RB6axHV25h9cWMURAMHy9yR3/4ypMWrljpwkB78Ih1hfvE1W0a5Yi6?=
 =?us-ascii?Q?6vCqd8dhNEChMa539pXo11x/ZAf0CpEb21i59UnHN/p2HuEKp1ixvMi1SQfE?=
 =?us-ascii?Q?QbijFo2fWwvSW+hM6tK7wx/VNGVJg900gncOJe1eFcBOgZSvbP8ry++eEVeW?=
 =?us-ascii?Q?L353i/hbTqK9GI0kU+P1LX7dCiPRh6UvNhgQL7jyvq9V6qqlwH/tzAH8p9GG?=
 =?us-ascii?Q?av9lVnG/t0WAvbFfkDNW0HVDIyFeW+eWiq0+h0mbLh7FS0AstvnNYQbpmRw/?=
 =?us-ascii?Q?d/a7/T/uN3xKLDsNAC4uXn8BdadOm4cqNR+GrPxJEDwnVzCMB3kCTxpaP7Ra?=
 =?us-ascii?Q?gIYYLw7nxIIFhyB9iDDdUmNH0NA6y7iL0tfqTQ5Zq1u6dTtnCTdrWYTaE6KZ?=
 =?us-ascii?Q?LSZzuI2f51cJj6ZtBPGIm7y3cqBNLwtl1dBLypw0myaXF7MVlxmE+d+PQkQg?=
 =?us-ascii?Q?FRsbj2jYaUeUBwk01353yWKb03S+pSIR+cU6lkcpk5gjzk+VPxDrHDxQeJpc?=
 =?us-ascii?Q?Z2dZvr6AvnS8hUj64ZWJzUA8mkvNTAOl9Ipzg13Mj7ee0IaDGOpfchUSPB/g?=
 =?us-ascii?Q?h2DsDEkI7wSnO6wSYegYr9d+5dtGAYxKUETXo+DNWMuCKk6PFb+cCBPkrdlj?=
 =?us-ascii?Q?lNWvLBcJJNCI6TZUgbsAoDcIIhm7a2neIM7ZmiOyKwcBtqTCWGk1b8kuf5EK?=
 =?us-ascii?Q?dcuQ04/RE/ElgJpCvOnIFDwfrh/eGxvx4Alxo5WPiV+lB6JcJAJxcgvxj7fT?=
 =?us-ascii?Q?xQhhJQzeoB+aXcP/ee8x9ESU81aL7ogmMRlAWjU1E1ycfeeNHvW49fy4yDtA?=
 =?us-ascii?Q?goeEqdThNWA9/ZSE6EAW6jZPVFsLbJNI8JrxpURtbxpZq5jrkqwh2iXrQ3z5?=
 =?us-ascii?Q?2H8wg+Cv/3LD5TB+4+lUWvlBE4jaIgZK4S0uu3w4uxmsu+dLau0iKBLeSboX?=
 =?us-ascii?Q?1cK+Bk5S4X8YfesQ/ZClnLciD9MMv1sGywIngwY9nKg/WDPV/oYXb/EBaX2E?=
X-MS-Exchange-AntiSpam-MessageData-1: TU+gOrSb9mIvmsPavlwG+XGaekmHsadCVu4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab39e609-ad43-4df3-7f12-08ded917a33a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:48.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elXE4C3NiAsKDvzsx5W53LIiMz4SIyJgu92tAmY+3TqRuI4VuVAIDB9TmoH0XW+4CRoZS5TAASyzwdvHRlqK67Kles6ocFPfjSmTuQl04UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

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
 arch/riscv/kernel/traps.c              |  85 +++++++++++++++
 arch/riscv/mm/fault.c                  |   8 +-
 14 files changed, 370 insertions(+), 35 deletions(-)
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
index 8c62c771a656..fe6c547c93e4 100644
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
@@ -421,6 +445,65 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
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
@@ -444,6 +527,8 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
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

