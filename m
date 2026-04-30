Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC993E024C
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547478; cv=fail; b=GjVqkANgDv46+uaXGLLgFzFABhKwu97Fc2KdA1+m/djMhwMiJMFTpljZX9mmifOfos0EyKd6TvZYi4pT3givWwlspQzwKZJMToV1+yezrpbmBdv+xy/vOyATtCwsoVwK5Yc/pikrZkMAUpfNwLFU+7xxsEO5/tzhKYu8JOqh2rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547478; c=relaxed/simple;
	bh=mf2kUxLv87fSjDYQBRQ9+480DMGZS2PxJF9maeuaPb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSd5SWQhuOxRvojfvFMUPIBJVB4kLoklazifQorjWnR5Cb0jG+aQnd9jjHz0MqqXacWxyL7cvyX9910lWVQdLXYfkTf1oqtAeX0iOFrRr+Mp9wswvHIzSOsw/VMT/3VLliwEW34Ha524qHVIZHZ+7W3oXkw8ipdptDKU5GUzbFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N5h1H/34; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N5h1H/34"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSOAkT9sqCnWGTibT1S15sODXonyhwJmt51xabbVOsbkBsE0IfRDNZ99QSSeDWcVBp0ed7ncUtrW2VBPEVmPumm1AhnjADLZ7VDeQ95JYxQoeWeMjCMYZ3E5UmbWZ+sUJpStNuE09sLCnHJ/M3ThoHDv53n4y8mkzy4qM30HKGlXLW6jevBSFHJbawA0lAXPBjUxMMr0GeHBPCZMYbHNufzbzUbZ1V9QLA4Y3DMjctMqxwwW7grxvbZkVE7zJSV0dvv5j6+8SMKB211WB+N9o6jxXLMv6+mSem5IgVK2BvPGPppfZtA7xzPh9m/3OBqN7Ii/mMbuQRwjEoH/IGzb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4ixmajvisvVxylcHQjZTMEvX84bBBfnxUMrzFEFOCc=;
 b=NK1It/0ncmvS/Ys+MgkgEyn9Yn7X0mVL5IKcBjLETGFEr8MnicQ+4RyN/KVmDtmZWe6x/87q5mtfq0+347isVQSDpXSYh/Jqe1EEtgCun38PBxjsBpG/Au3GgPaJrqgukGRRYlfkl5wu09iBUIpT/FXm9PZvSUzWJkdhwDNTUqR6Zt058/xbpLryaOO3qXxemWTg7bm+5BuefvW+cpwjEguxHOgjyJ5i1H5R3fRPKrXA7FXfVs3SA9CKZ8l3MDgMbFgX229ynxaHumvdmBlOPz7Hm0SRbFBA4FMmO1e/Z6579mzkXyOIcw35RGYgTkdKeHc2nt5Q1wNJ6kAF0BcByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4ixmajvisvVxylcHQjZTMEvX84bBBfnxUMrzFEFOCc=;
 b=N5h1H/34XJvA4jzA+shYpFHRSzkFmVM6NoCu4kakeMkJjNGJ4g/hPkXUi2YSwrkBZDmsLuc3UQTFd+PL7jUIbdv8No8kc5s/wnsanhg8XowafDDPFIVndY3HC273deu8XpBEa57GrwY+OHj8L7BEuhtVr1E4LWHb2YzxW29L3EcMjUCEUM9aBQlSuKp4sJQ9ge9bnNbsSOR+1P6AqCxEvfMEjoM9hUsqT3Vt1x9f2WfGWMV40FJtDMq+vugLK5tzy7zTcumsHlGLXe0PGdEvetKq3JNF8Tiq2Iyl4AAnJlNZogOs9CDCqR6O+TTRqw15SPJZglbirMjkDQvDeXN72g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB9063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:11:10 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:10 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH dovetail v7 02/11] riscv: irq_pipeline: add IRQ pipelining core
Date: Thu, 30 Apr 2026 13:10:52 +0200
Message-ID: <20260430111101.1539377-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 72db26d3-8d68-42e2-e0a5-08dea6a92edd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	zhKH+ndnKD+GoC3io3GPld0Xd2XdxaS91zEvVWhKDxLE2eylmH+o0hyAChqDaDeEPCAw9+iTx47wqGV/Ra09vUhv6shw6zeu/NBz1BhkhYbzPXRLoFCs/TrWjra9R6SdRhLL2X6TshvaXQbbVAV1Gf3K5McTbR1uf7eKuM8xFwgKBJLeCklIN/OWW5JO4Q6iG3gZv2JNFPJFjnIhPMSdMncFr8PRPi38/9CZs6d7w484/XD+OIiZq5U8RCfPLOau+UYC7weuL9X8F2/J4hUA7hoC2cHgzD+QvtJcot21pxNnfV4thqzxsNAa4vUAkap/ODf1gyQGk64ECx1fTTLGCB2ewNpfY5urxutmp5eYYkxk28AkzQmrd5meVlcuS0ztkQF2dQq4b9CSIxDVHzIyCFXNWXho8eybcKYcK1Z4b6DquetYbKOHxFVoIyLmIrs5dEUAiZWOXsJoTZ4iZd75fvIXe+Ca/OzL2jzPs5MlAZTrKGYaFRaCpLVMeyVQtBUE7+zyR7JQpLpnHnvjXurI7rsynGSiOIbthW4yjEBif7yLWetovQgSty3JfhLi0MkpdGsqDHo4y5Q0IGURWG+Spngl9XJlew32M4tUn/OTPDAWvIdEobsrFYoba9jl/YRgUQVLDBEUgfXz3c7/GVHl1Mdxc4uOiR+xGmQylUVG1gvYluVH1grJzApYHE1NgwWBJCvrm415vCf+f5VkMN6fpkxNOt9CTTLm8yvi3YmdfkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXaA2UkmfTvT9EuwCjIbHkZYR7uW4sRfrwbqOfuwRXR+z7knly2Vdrp0MX3e?=
 =?us-ascii?Q?qv6TL89oogUnxB44+u6dxrHkgxH9Ji/uJ3w/jf1q4JLYOPA1wrpnmhc/vZoq?=
 =?us-ascii?Q?UJSy3mqvDMtcN2EaUIvfsMPm658uC4qjg7w2f+GrB8HVMLpEjwlwOrKsExMG?=
 =?us-ascii?Q?jpSX9vAHUPkAiaFXXwu8sNL3oBua8rCDwXWQSxIwLvS1XrHs/AxwThULpaXd?=
 =?us-ascii?Q?SGOHs0OtCzafS17UhKrs0UGbqhfhex8BW29GJf2APmfeViqssWYl57LHiLf7?=
 =?us-ascii?Q?qxuJyAi4ma3m3DX6bOvLAB8v4EHgwQ2k8z6B6vIBcGtVJ2g7nYopjqSt39hr?=
 =?us-ascii?Q?wR+M13xpGiJVJX0fdVHmJOJuY0JOPZg5eDox+qw7Fp563J7HtS18VV4DC0vG?=
 =?us-ascii?Q?Q3a2EyS7o4/GBGsxIToB8fRHMuljwyrwDQ72Hy77CCnY5P+2l3qg3A0Oy/Ud?=
 =?us-ascii?Q?gm/8jL5WIRmaBkfie0IF7idYWwwGUjP86lrs6/DvhNRzQOBqD1H9BtE9YFpJ?=
 =?us-ascii?Q?WDqMo6FtWmyDaU1h0ouqaxANG4IsTlFmoIk1rMX99BAOE/qjPfI07nbgk3Se?=
 =?us-ascii?Q?M88K48YbZGdHQRw53iHqLry3rDaXykGK83E4yz214RjZwJIDVR2OQX0zM8pa?=
 =?us-ascii?Q?QnNZGB13K8fdw4wFqXkOIE9sVPChtVzcThl9ka0+g9jFQnsr3J3ZRt8W8rKm?=
 =?us-ascii?Q?1nvTLKxdskPhuSyXbOM+pDt9cioIVof8ieySsdTe5FsurDU0hOZ1lk3v3PFW?=
 =?us-ascii?Q?+UWTVG5I51580wzk8iNxTDRI2xgK4zBjKLXcSXyV0MayUb4v8WRrOoIrLWFs?=
 =?us-ascii?Q?MSNRo+BzAM7b/lTRurJ4l5pjgB++hHqhkGNtB+C34fxwYb+O3JZkK64+sjGa?=
 =?us-ascii?Q?axloWWYz1WCufFcSVkKqhJTrxE4do7Q41tYB5JgNmYI6U0xEmBtP4Qhl9xHX?=
 =?us-ascii?Q?wAzPBGH+o0wM3OP9SH/1MciSdAf7IQG3tv3Yh59uqbmn5RZNYKI7RNbFOGOq?=
 =?us-ascii?Q?QqkOk3mBsPpRVKWEXQImvgR2IVqnaK+CwjRCMzsadp8S2IRIFnhsd7pMnENE?=
 =?us-ascii?Q?65pFLMWePlVg0tDwB+BlE8t/xiFITmEZ9Z9FhoNWIV2lpjTps8ZWyaoiD0+T?=
 =?us-ascii?Q?FrvB0J6ypr8jZhiZ4A9VgLbLU0w4PQ51/HW559N53idOY1DapzaBagYkOCzW?=
 =?us-ascii?Q?CtTI3OQ64iX5a2v8KbLCQ1Ki8uBFs6k6ufK04Zkx942AjB7YHp83o027b3/Z?=
 =?us-ascii?Q?pJZ0ev587rfzDxoyuLaiZk2lLZEaEqzxtbPnwCjiNBrLjlh6AjUBUCcpCtnQ?=
 =?us-ascii?Q?IKfKQ0g79OZomP5YP/Q+gWFg5vQuROmrat/5wThev8FUq+e/RUV6gYzAJCE5?=
 =?us-ascii?Q?Ld0x59gAyze9uJBc2pgVaMFefKjvp7nk0MXOqwAl+/YCV7tqJI16xFrfsfVL?=
 =?us-ascii?Q?inpeEPXrBg0Fa3ldyqbPyvp8/1nVnRo6gN12+0UHjhRvD/YU9GIWMfAPdGuH?=
 =?us-ascii?Q?v5oMITD6n6BPsDBU1GiSPWQWgoV9G+hbE/RCOzmK1WomMYvCN/5qxt/cl8yf?=
 =?us-ascii?Q?DIQYwP3WBsIeYifQG2Ouo3Wp8bef9NAD9YMUF1+KIPEtqBhsamoIoygpNmJp?=
 =?us-ascii?Q?qAMKJBo8bAO9iDBOCCBR9s/lyvYktGV5ZTirT7oWT3EMNIqNhXn/77a2Pb7T?=
 =?us-ascii?Q?MgIPuT3nKboe19l9nc6TM+94iqrQD2VsG1IxoPwnG5UMxb45P4JwXWusdSIc?=
 =?us-ascii?Q?elEy11URiV9B68fOP1S81avm6ZkmdNc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72db26d3-8d68-42e2-e0a5-08dea6a92edd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:10.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XovDFxbg5f7hSZWSgZUnzMRQa3Wngx2Su+56wAblmVtz/5TAxn0BktPpRp74Pv3d1y5dBz7PZN8pXz5uHVOR1PQ3hICtSmLlU4W2PBW3mFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9063

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
 arch/riscv/kernel/smpboot.c            |   2 +-
 arch/riscv/kernel/traps.c              | 124 +++++++++++++++++++--
 arch/riscv/mm/fault.c                  |   5 +-
 13 files changed, 397 insertions(+), 41 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 90c531e6abf5c..0d8291a6c4da5 100644
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
index 0000000000000..d4d4b7e79c67d
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
index 6fd8cbfcfcc73..c3087b74752be 100644
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
index 7ac80e9f22889..7877d62a0bb76 100644
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
index 36918c9200c92..8a9e85c6e6316 100644
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
index 4e310257499a1..fb51d1bc5e3a8 100644
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
index 0000000000000..a478e9c3b3a4c
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
index 99972a48e86bc..c4444577449ca 100644
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
index 0cc5559c08d8f..600e2b51f1def 100644
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
index 5ed5095320e66..8f842aec1e0e6 100644
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
index d85916a3660c3..5eae21d4a0a84 100644
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
index 5fb57fad188a9..b37bb5da87c5c 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -112,10 +112,30 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+static __always_inline
+bool mark_trap_entry(int signo, struct pt_regs *regs)
+{
+	if (likely(running_inband())) {
+		hard_cond_local_irq_enable();
+		return true;
+	}
+
+	return false;
+}
+
+static __always_inline
+void mark_trap_exit(int signo, struct pt_regs *regs)
+{
+	hard_cond_local_irq_disable();
+}
+
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
+	if (!mark_trap_entry(signo, regs))
+		return;
+
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -127,6 +147,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+
+	mark_trap_exit(signo, regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -137,6 +159,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
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
@@ -157,9 +185,12 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
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
 
@@ -176,22 +207,29 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
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
 
@@ -219,11 +257,13 @@ static const struct {
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
 
@@ -236,6 +276,8 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_nmi_exit(regs, state);
+		if (!stalled)
+			unstall_inband_nocheck();
 	}
 }
 
@@ -308,18 +350,24 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
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
 
@@ -358,12 +406,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
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
@@ -428,13 +479,72 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
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
@@ -458,6 +568,8 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 	irqentry_exit(regs, state);
 }
 
+#endif /* !CONFIG_IRQ_PIPELINE */
+
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long pc)
 {
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4f..885e2f66515e3 100644
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

