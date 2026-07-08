Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB57B3BBA0D
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492094; cv=fail; b=fZBYJkrxXMrSsvyuRHfKioIsNh5iRM1n316vgaMmHy3k2cg5czXgme/veQ6sCLbUIZKSx48v4mSnSKM7aaMtGlUMrvABwZ9BYaAx3b3/d0d2hXL/HSmuzIptnDrQSPH3SwTtqUhR+OxUdPEOKLMLh8GF/GV0DKyAjlaBn9LF3S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492094; c=relaxed/simple;
	bh=7IuT+G9rnIa47YMhmQYjHwZQLThDOrrwRWLugY5DVJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzQb21P5vJCoPOqKvNCznbTB33mvvvnriadIm0PUV1GJXJrNnRlpAMgMXofsdNfJD0Z3gwElT6SFdVELlye/5ND7TUZpbutVzdbAWM5oG34O3FmXb1JwnJdtYnodI+G2o4UoA8UrJ/ZWwqQKkRgRdlgMJhp9h2PBewYyr9mfYv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qiMb35HK; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qiMb35HK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixHAJSUEw7qua6ta09wcjdix8Q9emJqYh4417gtKlB85pxs1iTVey1B2z1SzXxgiogSgcP9KWhcGeKF14rsHXK5cpkl54TeZTUOM5K7/eCU+ya+SrSK5NqqNGHnUWg7RC3ZGjJCVAVaCQJXbPmVP/64QEG3B1sSjMH/YSbsF3S1VpPYiF1oFVIBSfzZO9cDlij4CAnb/ng6OlWRnHUDz0Xi4+Y4iJd9JOVh0rpIXpilzJ1c3OkqZr/hKp/RZh9zJwLsrxyJvQSFkDKelJbRzaKBLwW9xUfLbLNkOiYvEH6QViO0BAK5FSDsF/pWVlmXymOdB2jud006SudhOoqedDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL5pqnLd1bFz8lw8WXgfe7JB1tqmtOnm6XqJPB0CAS8=;
 b=sie0GJZ7haaE6a8yisa9N1oNlE7RxXzWs245rRIftrX4TBkkMRHSyNVydprHUXnIomj9qdlkujepjWDE6T+07eZf3dIVUdRgQdcLBUb1FoTJ3yWhQGtWLSKh2uFWnVbhrJDZl2WjxFvKRp+k1VrOkGv0u38y3zhknv2Bxkbh7zEXcXMb3lAnHU7p/vH24ZXsksI9tzzbb9YO31/h/92owZZweKwEAwy4128liHJ04bVDObkf4MnxUY33wcYSNfe8x7fTBf7lx1dMc7bpuy7VayeDHRODbtbri4cLPczY/sC60BlpxIymAfrVYTeMfqaUGWbaFIYSXBrzNCJ3VF7Ubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL5pqnLd1bFz8lw8WXgfe7JB1tqmtOnm6XqJPB0CAS8=;
 b=qiMb35HKmTxeEmNaqKPfV4xu0AopUqiX1i1JyOYIulK1Ir/pcQZZcymB3YYrfN9486hYvq1imoUYZ4uzXHFEbgAUMSyEf6Pta/cneibObyrJ6jWl/e0tN3vzJivnD0TY6vdx41c2NMkZtszGiympVrAg0PkL9Lh3VCs40GHec85z2sIhGWNPXNbFU/oGux+LaOZf5y/Ev7CPV6Mb7mzI4KO6viqvo3Ipq0FMi9FrweYJwYSd+8jRxgTXsFzBkXT/srLTCnJHfjCFOGySue11H1znTJROZSOygpbBWThd33leQS/cCvGxdHpKX7wEt/XgG3UeuQp6iiQ/iXx5SjXoTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:28:01 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:28:01 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 11/11] riscv: dovetail: add core support
Date: Wed,  8 Jul 2026 08:27:48 +0200
Message-ID: <20260708062748.1029852-12-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: cb89a953-ce9d-455c-9783-08dedcba0f16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|3023799007|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	99neyXJWm804H24YM/wozYM0AhIR0mA1VDjzTYD4qLsEWGshKSosruu31HspZf1HMcBBXvfgVvsH5gg6NMQYqmybnhvrnrahAXCd0YTU+8vcOs1fw72Sg/5BLh4R+r7Wee1qiQ6H0hSzyEFNHo/yAINPxGDlmA0DsF0rODLz/1+nM4VjrQSpxcsVuav5tD1pgn2nCTL/fyTdty1pj4sOGwsnOlt/9LrqnBYX50EhyXRxpa4EtwKLXoGW1jeQd+F/lqh1G/IzH8ZbezUrlDwrMYyxpeqFLfBARfxNYhmjDpiAd4CWlCUb6dkM3fXf4agQ9g+HJQ77Z6a32vcLQY6v+Ez93gFjzNxFChO/5zLMX+IJc5E2yXMRIvnPiLXaey/6qnU1jia6Gt0b8iyqMik0jTiG0JXB11GkcSXqwMLfffYwy2+Pp0vMsVtw9C8Jml2wJrz2KaoNX2l0+FYcC2ZHJoYpCls+jnm2yyYUkxqn9haPNJLdlYW5c36qFBuQFjmNKT3dd8zT/uF8xOD9MrGe+cSppj6icBI6EAhPRggrqeyY4qpHUKyJ0Q6Fk3w/5Is4hYGU2w0rdfYv6yUMEj+iYpbckt0rlsO3pdkku8OiyPq54fy7J49AWnXhMPyMpDJkxNVjSy3tWHxkuWl8SJr/9Qn8hQw+BK2Im+qwMTgEpTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9p0CT1JBEXyk7NAceJwme1xLg1UAJjgKtELQW3I2gvZygr+D8jjUoP6mNDT3?=
 =?us-ascii?Q?MBbaXV8qSbGVP+HDuNQj7sxEg+PVVJZjulcvTOVTHkpwkXLWffsInJJejfeh?=
 =?us-ascii?Q?jV5oYeCz+mF7dBVxVwVV37IoO8N6x4z2Xxv35fAn0+vqa8yEurxZPsDyg0QM?=
 =?us-ascii?Q?mkXU+kdBDAPVEHX7pnv1nw1ekHfvH8K9cYQ+/Z7ntufRYRa3H5zXTP8AqVNJ?=
 =?us-ascii?Q?1YQp/Vyp1TSLeFzP8ZaIYkXqY8wjDS8HAVVRFHI3VkbNF9PRCJY9I6Xa0USY?=
 =?us-ascii?Q?v0vj5VGUlEYAxcogLEc0QpjTomMA801Dv0qXgDLIJuC7H28l419BIduYI08f?=
 =?us-ascii?Q?lUlbNxnRgrPxtIuhKi86VTqx4uRK1FV9haLfV9ZBfVDIhzAL4bY3T9WX52N7?=
 =?us-ascii?Q?+ktd4yU7bvrnUHQwj1nXqnCC8u6x3znB/yBgjYa+Gj6q9TUkH8yNZ65KijjS?=
 =?us-ascii?Q?Kklu12JKyS99T/X6fXhieiaOgBR3cv6PgnsojBXSYTuW5UIWj7nJMb7PbCJJ?=
 =?us-ascii?Q?lNILwiZJIOMBvdV5KKvD2hfHvceaARUnEjlwgxps5nzcUCdDEry2u3lc3f5C?=
 =?us-ascii?Q?9n++QrvW+HOfKsQr+MOOBpwkHITXSHVKsiya8nhFHOmyW7qU8xJKkQGPTJ4W?=
 =?us-ascii?Q?tIedLE+1/c+B6jG8h8xeGYg04iTfkL3fKz/m1ZEZCmcSZLdM2UuRJu6zdwYd?=
 =?us-ascii?Q?FBS0kIz/kMLZdDsSgz16FG1kAm4xWTwv1ybgJnsM+C1TVhLmUFGnz662Fm7C?=
 =?us-ascii?Q?KwAhqm9Yewd1vPnIt6sn1jCwfHb1rs2qd3XS02OH2kVX0LgYm4kKQ/9pRdmL?=
 =?us-ascii?Q?YB+EhDKQU9i+gizXb9yWhmUA59fbZO7Mkr+z6sucVw10GDiJxZCatyFT1U3o?=
 =?us-ascii?Q?yAiQo2JChUwLWmhcylMHIPcfY9yaHcQZ9q7FZ4l2QXgqrfCftlsAnE+tV6xv?=
 =?us-ascii?Q?7PTomuJ4gNo1tAJxQZsRPzf8Xtyrt8JJzR2rzL2m73O6aVHMluAxnLjWD2EK?=
 =?us-ascii?Q?ZYcS2RyNGAIRgqb90uyiGguIavk7aS8aIVIaW/Xykonzrn8NvpK/8k8ydRqf?=
 =?us-ascii?Q?8C9NQmJpaVdy/EQuW+CZKDLd6SX1KY3ZqhGeitYd4UnrpDCacEptZau+nsf3?=
 =?us-ascii?Q?YNdzhotI9fRFIWopnlyB8lTL9eUiKyR+zEKGqqPiKVydIws2p4KjMfqJ95p3?=
 =?us-ascii?Q?eXpobczQRRIUvxXm3XrobSHQ13oDwwobCBdNWAKTGZWlwDm3VC9hnAYuEaKP?=
 =?us-ascii?Q?sOYWMGDEF7AEMMzgF5XSAoK5hB531EPqVI24fk8LkyTMhY88Bl1cDdeapwCe?=
 =?us-ascii?Q?+vnMEwf7+eJZykkmG4Rt+hGItwuB79BqSyuhaaTRqnzhTZtDjbfaz6z6YGlk?=
 =?us-ascii?Q?64Vsikt4wp16BEhTo6MG076xuECdEJAVYm3Wfj637lia9eAfqxiNS/H63bW4?=
 =?us-ascii?Q?CrNEaSy/Qcg7wQJaj5VpnK4iwTqOvxLXZtCuA/ORzTNjJcnkBjRmuj5CtJ26?=
 =?us-ascii?Q?j2oKs0sOlv1shmVw0wTUuvNz/lbJa//eJo0QJayDU31NlRkwPHR4WdM1suy8?=
 =?us-ascii?Q?PAAEw0pOZA8Zgu3K10ybou5jyjZ42yV9C0RtP/qSrnnb2QOHPn87NigOcMBf?=
 =?us-ascii?Q?fySbwENduyUWsLhlhrwa6RUsMUurOBBg9jRHvGMfyDTLeNpknOm0+CZI7Z2K?=
 =?us-ascii?Q?YEbfBVjzSE2MHcloyMvYC0Sn+GFPwpw6rAh+4Ej6h42C7uyHqbE74WUG2Q0g?=
 =?us-ascii?Q?hSc6Ap4T7GTqtD1EgKl/TwLus9NiaEAak3jHvTnzcN7hm7N5pwv5dMyJBVCB?=
X-MS-Exchange-AntiSpam-MessageData-1: LVPQS77+BTPRUQBCz+JYHzy3GsOu7WNLeNo=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb89a953-ce9d-455c-9783-08dedcba0f16
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:28:00.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsLGf0JOzTwv9TRXmB7K/op8l9zMYafFXkWp8bSqPDyJxM9UUh9//hxHw6vB1TruyKkuOc1I8YRHFmvnnDvHgLJiZD+UlLF0NMx16QvBwcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

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

