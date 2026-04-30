Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B43E9580
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547486; cv=fail; b=ca0p7IhIuVKaCZb7i4/vDDkDxK6lxkLNs3KGfSiBNz+5oC6Eba+P1IkxfdpykTrbHAtduqwhUX3+PajJHIY6sbI/F1KY9QBojtw9RtleGADZelvSflPaiIo5iJRL5LXHoLbFbvZn7ZCT8u+zdpqRBLnDW+3AXR9dgzDwHjwGy4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547486; c=relaxed/simple;
	bh=63a7OlO5OZXn46OIFeuTQE6gL59l/5mFhzl+ql+ugg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETE1BX9O1DK+qxLmZ/5IaRgvmsEyBmUZ1f7JUn0eok0JqhDVWD0wWDWMHoCdiBrkhVQfHkcZJ2TRmRULp551ZXTq184rbEARYVP/1SMWy+mOjYGSJu3jWyWYPaT8TO2GILkoKSLJeMdbxYtViy0E8YwCnra8q3lmysq9xA+0F+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CZAaIpBs; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CZAaIpBs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyhaYNOmoFBetoiTAyconiCuUgz85W+aTX/pwpeUhGJNvY2unmVKr51IO4NW7deFL5i1nhVAGsdXXFZqt6LWoPnneAJMO+edHp/6gq0uMypalbOl5hTtOB6FjlxZ//QsXrc7lHuUjTP4bEeKcGQiuJnRvpP9n5SXnSEJcqFISoitajpM7xDizcRGy6FuIRsq/iJJybQ2R/atwlJ3fj2VypZ2ZNx3PEtoP/LUhKQb8c/yA4hnWnV2RNuQKiaWRx2aJGV2P/iHhzPJUSEc6iPtMgpd+BNFep50ZNG6UPpRSf8TKZ5em+6jldGGunNhsRU3s5uUaVMpygzATI6YhFV5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=589d12TTR/Fv2RNieZRIQlLHNu6M9WE/hDrj9BfM7cM=;
 b=Irg/U0CBG9qiOjPY2SxtY4yLRP82SVO9j7XW4BnSUVzZQjdIdJ5agO96Kz3zGNggafSw/+CTrF3GQ2+J0no8ZZYHlC2ot4w+hVfdh1+Nzd9D062L4rrTwqMBl+rg7N9lZH/f3H2GsPLAJ8sM6vhGJEA4yEsNf9maxiVp6ZbKSJkPwfxY+BiU1oyrUXo1Z/WDU/EvXbZVWrdovx+YnNIQR3BkceS3V5CT6xVsJSFOxIHngfdnUYxT/8mcoILy0Ays3ok0j/2QtZq0+hDLmrIirvAj4nYYoq+ndSDh9JA2v1W7T726H0eNtnF/mf1WKxjEK6CHuAY2yLv3ZoTg6cGL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=589d12TTR/Fv2RNieZRIQlLHNu6M9WE/hDrj9BfM7cM=;
 b=CZAaIpBsECZqvtjEg2Uibg5SQNXM2ieajJEmN5h884hsseQLOW4nvWbrShguccvD5jmYdLZ3dkeLZDkOqHF35YE/2E+1ez6cNndeWat8TIDOv3NpOM7E3CFJ6vRuVP2EfvXBwNkoLFY17k1iYhDP+eJC3yMS5hItPYi8hwCNa63uPSF1WJzoMHJ53JVJs8Hyst4AgGOwYgGa+gmJwBlYltpvXUh4tdKqojSwafpqIc2TJ3CK9wuma5BRkpIMnnn2sRC6OgkaEdCWh0Q6KntK/3gT1OCx+qDj7u7adkrC6T+dNWPRSZ6mWYpfuQuUmokkz6jqOGywKU4RGXXu/8c3Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:16 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:16 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 11/11] riscv: dovetail: add core support
Date: Thu, 30 Apr 2026 13:11:01 +0200
Message-ID: <20260430111101.1539377-12-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|FRZPR10MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: 692e9aee-b28a-4026-e9fa-08dea6a93229
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	tg2ra5H48xGv36/csGoisN8pgTHlsnt9L3QELmM9Q8HTGzX7WCOEAlvAUx9RZu5jknaKL8mY/ArsIJ4Pg3FboEBER4mRDoLZHb8jeNF44NjUGhrSeHQNXi6ACR7OBfGxXnlwZtLoAJeWwHng/pJFAU73mwtU0htZLc3bWOBLsSs3p/K1Ok3anEA/QfQRy/iQfLZ4TMKaMpjqs6as31fM0pvOhbI4Dlbwg6/6eZpsXRdxeYB4Y/oI44a59/NBO4iRaCO1OScArM0ueOz4Tyu4jaS+Agnunzuajbg2f6Wepps2+SmG4n4kIIUicKJBX2l2Xa5naLoqJoIe7VfyTRDDE9vI5OtTriGf40oLQhjgn+uetyXAYdOmho+NyEFxUz4qDHzk9TU15ny7L0q3m9CfHbC92QBVjUjder9T986LyHAFtXId5CFjBTiLJ440RYKiAONLxpJQRttLieSbQe+NUXo9O3TFDsW07pRG7LH7KMOW0qlRFJw66glITWfgk2u86x2cRt/w0l97jzrqYVlCz2w/0Kv87vJWEBXQbWGqltzlvN9G3ZRH8nLzoQwCseDMiEzAw2xmVwwgfL+XsYUf9vNALZ6wWNo1PmK9mwQTjdApqQ3Pkfg8uHLeYw1/fPLihtGABNAdh0jdEYIhM+EvKCTqtsFERJXcdyBwcF/VBVC0hdyxj73n8uThlfVsmhKvOTY+7EusaIWIExt85IYmF6tS43iXEQoUMmg6c/MysB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lh4Yg6n+fis+aYBdXGwGrTez1rXvYyYEz/He7OZMsFGeNNf+gl5XfU/P91Da?=
 =?us-ascii?Q?mwv9QKvGQJEZZBLqDU/W4bqEURGOcBbc15eSedBIEh7R8+FBHwcTVuJ1bOpt?=
 =?us-ascii?Q?nPPTCfXkBt94AQsiQvYrT//tdbDTJnsmjb18ifNdbFx5hwuTFWaEgx992GyZ?=
 =?us-ascii?Q?1yC/nI+asfv27l24p9NHe2xQEWQJKG2xdUV6hEBqLf1kRCFM8eGD3SVFCjot?=
 =?us-ascii?Q?Q4wxgZ1uE4RD2bZIGI+Fx3iPj2xKH0yic2F5D68uVyRRd/ChCy5ulf0/u7vb?=
 =?us-ascii?Q?6y8U0weLB69mPc8Nqqwuk68oHEsx04v50zhdOzR/5lyZJLKuetnchz93lbdT?=
 =?us-ascii?Q?C2E7zFfFSi1tLemRdubgvLsSbz5IAvMleBsXitNcJTnB1Cv7ShhXSquXoEp+?=
 =?us-ascii?Q?0fopFRXbkPqX4cJT6RBs1uI6nJx2Z8R7+nzt04dKhh2tR7W0xx++D0oU2oFp?=
 =?us-ascii?Q?C4XgQwfij1Ss+0hD+qUpelseAKodIZig68ScsxAxKfBVYeGbEwdxW16vhd95?=
 =?us-ascii?Q?Pwxy54gTvpexJxrse4i95fZycn+VhWt6YeNR38d98NIhqqrRBV3TKwW4/iXh?=
 =?us-ascii?Q?jMD9BEJh9QfWcSPURZX0pqAOwEfg12vy0EMy7O5zebxxs1JgygGxR1QhPIeB?=
 =?us-ascii?Q?NZX6PsbUr6XOlqhGVnhLSfY56EJ1EZpeF6TQO5bVcfY6xHJXM5kvXsQwn9Vw?=
 =?us-ascii?Q?hDzSVy+WZfpMOoCE+HseTUHGEanwb5VLXubBvyo3q4Vkp4hJ3l1bR3ul2FEi?=
 =?us-ascii?Q?8jEnq6AohV5ruczafHTNNQvpsbhJ2/1885ai8XKb/taLfnZbX1itoEaX2/kx?=
 =?us-ascii?Q?Y7dE63NR92EEhBrsZNdhRMVKrK/BcB+NbGmZcgt0ZgfAOzCeI5p9Q3IFjdp0?=
 =?us-ascii?Q?dhSsmuQwCozuMZZd2al5BNhDDjmImmuDdP2uX/G1ADrcsmK8EzGU6w88fGDz?=
 =?us-ascii?Q?+kbMFcD+EUEfEgrfVIe3ukNFo2TWTKxj4P0Jj/we1visdRIwU9UHE2CazYbR?=
 =?us-ascii?Q?y0d32o5JLSZZFVztlh86hh0MPo176guQQmoSaAD6QgT2dACh9Xl3DQGeRGBz?=
 =?us-ascii?Q?D7eBlNmxGI85gt7joPb2ktzToB+qxJXhkzB29Ual3h+DN1OhObeJpHh0fqG9?=
 =?us-ascii?Q?h2r2qHLQUV5rWlVBrYW6xONgnV7GHvw4hmqKSRB8jEtJvRdsozAuX4RFwzpO?=
 =?us-ascii?Q?s+Mis1j8sDbTddHoJKkGi53m2yoHcMFV4ApqYj0UpDxIoNFqR+TqUOaOt7RS?=
 =?us-ascii?Q?4IUbP0qsi6q1ZjKQRif+Y30mDuEiUCZBekXV/dPUu+ofhEOegM/pYLszbXNB?=
 =?us-ascii?Q?w3gDczqlMEPNinsEs9OuD2n4G8JM+/bl2ZQXYHUw1hmcisyhTU0vihePcjuC?=
 =?us-ascii?Q?XauvPUgO2AzmaIRAry2jJpAAzvcnf3XcOjOo13i37vDigxxAPGsJ3gsyG28E?=
 =?us-ascii?Q?uz3eXN7uwITBFRwh7dYkhZLMKDTHkFI8mV1Y5t6mQlHfjNnoy1OGtbRX4k6I?=
 =?us-ascii?Q?4WSDPIJ5+xVgZ4f5h6VdVWW7YPIDbAS1nUgotCZqrqVS4FWjywBvyCSiCg+1?=
 =?us-ascii?Q?dIavuNldB4xjAZ7v/E9wGd+3+AkOpnQ7wFv3f5wCivIL+8HSQDH5XSp1Dxt7?=
 =?us-ascii?Q?pmKvNZzwoQFuUEC84L95RqoRt/Esq/gFpRjkSx4AX1cG/2vuD8ey/fQJB9Vb?=
 =?us-ascii?Q?yb3DO8k5iBgtjkjO+PED53ew0rXygufbWlo2CdWAb8JMuJaXHzhxjGsf3dJ3?=
 =?us-ascii?Q?5KiZbAOIw+FsuxQe69Ma2jSkcpMpTbo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e9aee-b28a-4026-e9fa-08dea6a93229
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:15.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1g1CeXxsdYi+v55CyYyEgpobvkgCD23rGJx5VvDOsnN5SmV14AFPwcdHS4JY3u5oHraQmE/MVd2Xs7b2I3uuOzfIzGkPYiaAYZ49BkwjOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

Add Dovetail co-kernel support for RISC-V, including, irq pipeline
integration, out-of-band aware trap handling and memory management.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |   2 +
 arch/riscv/include/asm/dovetail.h    |  23 ++++++
 arch/riscv/include/asm/mmu_context.h |   2 +
 arch/riscv/include/asm/syscall.h     |   6 ++
 arch/riscv/include/asm/thread_info.h |   8 +++
 arch/riscv/kernel/traps.c            | 102 ++++++++++++++++++++++-----
 arch/riscv/mm/context.c              |  20 +++++-
 arch/riscv/mm/fault.c                |  28 +++++---
 8 files changed, 162 insertions(+), 29 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0d8291a6c4da5..70ea8457e1f66 100644
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
index 0000000000000..ac08db99f4e92
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
index dbf27a78df6c8..a1ac9192d51c8 100644
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
index 8067e666a4ca6..12376b54268e0 100644
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
index 8a9e85c6e6316..8153a4f263638 100644
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
index b37bb5da87c5c..1f7d471457892 100644
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
@@ -175,37 +204,46 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)					\
+#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
 	if (user_mode(regs)) {							\
+		if(!mark_trap_entry(trapnr, regs))				\
+			return;							\
 		irqentry_enter_from_user_mode(regs);				\
 		local_irq_enable();						\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		local_irq_disable();						\
 		irqentry_exit_to_user_mode(regs);				\
+		mark_trap_exit(trapnr, regs);					\
 	} else {								\
+		if(!mark_trap_entry_raw(trapnr, regs))				\
+			return;							\
 		int stalled = test_and_stall_inband_nocheck();			\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
 		if (!stalled)							\
 			unstall_inband_nocheck();				\
+		mark_trap_exit_raw(trapnr, regs);				\
 	}									\
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
 
 	if (user_mode(regs)) {
+		if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
+			return;
+
 		irqentry_enter_from_user_mode(regs);
 		unstall_inband_nocheck();
 		hard_local_irq_enable();
@@ -220,7 +258,12 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 				      "Oops - illegal instruction");
 
 		irqentry_exit_to_user_mode(regs);
+
+		mark_trap_exit(EXC_INST_ILLEGAL, regs);
 	} else {
+		if(!mark_trap_entry_raw(EXC_INST_ILLEGAL, regs))
+			return;
+
 		int stalled = test_and_stall_inband_nocheck();
 		irqentry_state_t state = irqentry_nmi_enter(regs);
 
@@ -230,11 +273,13 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 		irqentry_nmi_exit(regs, state);
 		if (!stalled)
 			unstall_inband_nocheck();
+
+		mark_trap_exit_raw(EXC_INST_ILLEGAL, regs);
 	}
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
 
 enum misaligned_access_type {
 	MISALIGNED_STORE,
@@ -254,15 +299,22 @@ static const struct {
 	},
 };
 
-static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
+static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type,
+			       int trapnr)
 {
 	irqentry_state_t state;
 	int stalled;
 
 	if (user_mode(regs)) {
+		if(!mark_trap_entry(trapnr, regs))
+			return;
+
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
 	} else {
+		if(!mark_trap_entry_raw(trapnr, regs))
+			return;
+
 		stalled = test_and_stall_inband_nocheck();
 		state = irqentry_nmi_enter(regs);
 	}
@@ -274,29 +326,32 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 	if (user_mode(regs)) {
 		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
+		mark_trap_exit(trapnr, regs);
 	} else {
 		irqentry_nmi_exit(regs, state);
 		if (!stalled)
 			unstall_inband_nocheck();
+
+		mark_trap_exit_raw(trapnr, regs);
 	}
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
@@ -348,6 +403,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		unstall_inband_nocheck();
@@ -369,6 +427,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 		if (!stalled)
 			unstall_inband_nocheck();
 	}
+
+	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
@@ -385,6 +445,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
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
@@ -404,6 +473,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 */
 		choose_random_kstack_offset(get_random_u16());
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		int stalled = test_and_stall_inband_nocheck();
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 55c20ad1f7444..8f38b4a5eb262 100644
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
index 885e2f66515e3..32cb7285d6db8 100644
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

