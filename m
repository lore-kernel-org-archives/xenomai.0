Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2043787E
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362593; cv=fail; b=tbeb/8VuV8/lsjhTE+l43JLsIofecLEpSF4vrkYHvIEI/bQfUqHzikQ6zJiSWlYrb6q/LoCr6uB2M2EnvGftUNWPjPp7MCoNULX91KiLW96krmG7XruuOCE1m+Kz5u0Mb8ym7e02qZIf0j3kRjG4W4m/bqFeJtHZFZZL2DxjMug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362593; c=relaxed/simple;
	bh=1Jwtrs1bS9zYwfVTH5W+pxxs9pIFXmmRoUSpmbTYsFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InzU5cp2rOC376gpfMZa7QMme+B0ThYlFD5FzgNqMkN4D83iLcQJ48HB/lZsUiHh7mOMKkMxms8J+2djAl6JoEl55EhyYkwerCTAG84atHXtEM6e9s3riV3nnhIve+aBVY1n6MK+mF4XCh2aiPXWlIJ0t0vx3pvoo0hn7rboJ6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fA91JPdD; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fA91JPdD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFQ2ZwZ3tQh5Swm5ilfgWnRs9qk5NIxrni6q82vwLh/Lec4MWahNPHI6JGzWWBAs7oKSeAqZW9UgzULtP+XcV1mwIS+x44fBEJbII7SDRByLZQf2sFF0JKwwbDBNxiqHEtQONRgVCPYhq42oImtb/sqbI1cZ4JmW8xykz9FaJtxF1QAqt+kMIYNu8016GPpZpYay1Iu1PmcCxUdQGWKswmNs2mpMP5FCt6uUXKwGoYGKHd1DQq0t9gDMnqruIhRjs5gFw9/oe04HsmXWdvx6Nnb5dV4x2VBqiKHwH3jTW9/UNadPa3dvFO+fV9+lLzLl86EVjL/YShMiq7BCatSZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob15ry/j7A35hqzPPZYSXancU26a1tK7xpb5yjO7lek=;
 b=PnZcMYeVPWr4uFBusI7rD//VHYvsTNSZK9BsYRMlPGDLtgwSgJ91ddzEJzCOyCa7F6/7itWn2UTU3CXZgQnSaFFjPKLwTli5nqxPLYSaLrjGH47BsQf0O8Oy9ITno3tJ36TKL1pXZFcF/TV1vZRm01ihm/YXUu870LsB231xjwKkuzXPncJdhIPt2vVESXtgsAA+Lh1P5EiIfcRDwz9kqiQByFUFaPKWLmwsf7eubzAOIfGnw/FEwvBJMjACGoyh3vtBsA+9JBQPLWtv0Qs4ZiY96MzoQO5wUeNSYEPd6MalFCwvO3ZMXipFv4gvYg6mB9nr67VdBKZgiGXN5/bHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob15ry/j7A35hqzPPZYSXancU26a1tK7xpb5yjO7lek=;
 b=fA91JPdDPkE4M3CXCleDZwW3iL03IWqbHQdSC4/Nai+G0LPXO+sDXGwocml9d4aIAdwrah03Ph9cilBOngNY0A9ym3DsH7wcEjtD4r3DfHZ/lf0pIgo4wgNNZ4WJnjGZMH9mc0zn8tH83srE9ptoQITP083BOb8EoA7Ob86GaCa2jFnqM68gADcqwouOTJrh2ttuZuwM9hR0tLSEumVlIdrtddR1QUzx9CcAJSVAKoCXufYzoCwZeinULJ9TYmL1DU7oWk8c/zNkgeEOnYOnvKdFM9BpIFnTv7SlHP1lQ+wmLhrwFNS+yZX3EftH/Ty83oJCC03aStJitYl21qwAiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:42 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:42 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 11/11] riscv: dovetail: add core support
Date: Mon,  6 Jul 2026 20:29:27 +0200
Message-ID: <20260706182927.281078-12-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7153b044-6762-455b-8900-08dedb8c8bb0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	3uO4EH0hVHcF+fnNjp0gmSPvYlER3L+Cm73bN9/i65CEzI8xYgYKklclf7hcCFxue1zswiIngKie/OkDOwC9cwqW5+n2ly6xxJb8SYcr4syThekJ1DeDNcqcTWVYA/9q/aOa3b5XWC61GfgyIClB0MeGPe+5g0AKXCBu4ukHozZ8ZAHQcrCxGwmwLZordJPeI2tP+rephV2XtuA0GtK2WV3sjpnwfQD9l7TRpn14fgm+QOhWxkWvG33CSX4rgq8Kg1odcKz+HvHbU4AX7HMsMWCQISVYtaoOlUum3s2gff/q0/cSjtITF4f4G13bk8aiUnv86CQSMWsQBlMMsV5KS8v16iBLvWSudJOfqsBE1RzCLPh5fzfGqEfylGMhBqJpqAZU3IP6rS9rPpcSNFa1qa7XF7PKe/5t9d8/cV/Bk0cLvdIrFz+HXBVaopXUzHBMR1r2PzhIfXGioBEUisadpe6qBkhuEl1G4PVVT9rlVxaJjuTiukHh1x76x2ibYTv1kqi1gA4q7fVRzVnfu6FClvTyZxB4g0/PSr/l5aaIAYNc40/T8TAnNYRb4xRW9Pg39G17+THIJIFl4+IaKwCRUm28jPkhaXnnVFYNVj3OTzEvuRn38lwxhM2IZyCzQEWnVUk4jztwfFw6TqOVfA7Fn+8LsAe5v+Ag5B8lhNpLdJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJ2YEyDa5CW0QoO5DRhv/nr/m0G9dc9XyJAPAyVtHahj2NizwPa3dMFQncPM?=
 =?us-ascii?Q?HYqDVv3DKPEL08rbCNLXTvjha/3kfRZR4+LPJKrtkkmYAmsukK7O7Uv0KZFR?=
 =?us-ascii?Q?N8mwYeyCpvfsTiaUhhhHySRWIuYZS8tLmQlbMipTKBSsd/NRCyXCzlAgZOQw?=
 =?us-ascii?Q?Nt7umF51bffISPl/r9DajSjwySQbxKiycjB0/EMBhAmdluLEAzeV3CXTM3xY?=
 =?us-ascii?Q?g+RbcF9ISOAQYaqI0hZtmwzRLPD4AIZ1MwqeUBt1SWakTIZ1LsjDYXS0C11t?=
 =?us-ascii?Q?PzhvLycK02EaoABFkrAp8g1uXecTy7dxB9cosw2PFBGXJ3O7YOQicWzkDau0?=
 =?us-ascii?Q?/Us2NVX/lSslmts4WS48D2QZGwGP79+UYqWxWBQFMAMlvRT9Qtubxv5PIACJ?=
 =?us-ascii?Q?7VonZHXj5ARWVrsyF7MeAjLB9fHzXWmdrCzQWvjGbRdBpaecxpmLCth0z7ri?=
 =?us-ascii?Q?4ej0FIPK7DuAeD6Cfp3/TnU4VB562JWwgUe/V3UeKin22tYF+itsYmbxrDWT?=
 =?us-ascii?Q?bP3UF4J5vib8KCycebZHb+t0m1OAErpw853GP1LPVaIwDP4FtJhQ6xCCvjS0?=
 =?us-ascii?Q?xvAIXe0TNNfIG/5/Oh3yf0bwj3yPUIhQY1VajTjkzVrXPu7Re9ohxogHBH/g?=
 =?us-ascii?Q?q59z10R/09ZqPPyvfq1wuZq/aavOhk8d29qK292FdjZk8nJ7cEYOvpgcXPuN?=
 =?us-ascii?Q?7Q5EJEWNs/2pknCl40XNByDiF9VGgtPbOeUk4ZZevtLBlbgkObVBUL7h0ZDf?=
 =?us-ascii?Q?HwK453qmCZtYiYcU2CAcrxhqRBqujouT+8+5lorYFLIuNH130sswGmUD7kgT?=
 =?us-ascii?Q?S72JQCtuQNoJrm6IiHgtDp1jMrkV6iqszQO7Asd/JxBFziyUd9Cxshhgq9YQ?=
 =?us-ascii?Q?Q2WdTzzx/M8gvBZlbA16i9QFy1TbOoPStcmbuOW4NS6OGoiMiWQvue7QXWBN?=
 =?us-ascii?Q?oeLmeFRB5dWs0bZ6htIWc9WO5ASkZm7Z2z+TIVDUzDAM+d6qdijHgz9pwNG2?=
 =?us-ascii?Q?oobUGHs1hc4KI2XRnVbBn/5hlvaEDrai+yFzAtx9nKi8iwG2upmdJ0u81bjN?=
 =?us-ascii?Q?jWT5Qmhp5Iaiwf4xFEAzXdmwb1ksQz30ayhLStZyIcm/Ne6yb8us+CasAtyJ?=
 =?us-ascii?Q?ZNq1djw0uMzBh/ziAiYHOJLTDggesP9hDe3t2qu93hiwWpjIqXpRKQZDkeTI?=
 =?us-ascii?Q?huFj8CKYWGpiN7pQhla6kXexrthZ/sJ+/FXnRj95tgY0YEdP6DlgbRIROgcs?=
 =?us-ascii?Q?uWA1U8amO4pNErY5H1LevAj9airtJ0Mu1yl7ElT23psp9qhvWjKh9DJ3ZQQz?=
 =?us-ascii?Q?rU0/Bb7LrFr39VwdAFpkfTNwt3JxXOxkoFHbKHRMEDgD24QrI6dgVIKm4Z3k?=
 =?us-ascii?Q?VDSGrdn+RI1TqTYlyetE3KC8JDZeHC6Hm1kPO1ySXD44RwtqIGUI3eV15DgC?=
 =?us-ascii?Q?QQJsDnaJL7G3tLfs5d7XXzWvXDpAnEp5ReNjy38aZAxfycUJm7gKVDg2c3J+?=
 =?us-ascii?Q?yOC8vpxUhOwAUq9hmgiXcSbhz4eddEiitnzPxNsvRSoga9xgt1XDbOZnaQX+?=
 =?us-ascii?Q?KIdDm8+EIJ2EIB8mJH7kAUhAEGxmS3ChSSWceXninNJ7ldZMs6l56vENi54T?=
 =?us-ascii?Q?RYJP9qqV+JaoPHtsSZ3DEeyoLjkKdeQt+fddkwmOpwIXkZGQ92U9RAP4lMtO?=
 =?us-ascii?Q?3sznf+AsdSFIg7akjx82EnpuIYZtDNdQms1GN5DuI+O9YHCv/VBViuJ30Aed?=
 =?us-ascii?Q?fYbgcss9j9ncbVk1SN4Co6fH967jo/GESm9WoXJ3ZLGwbmcBPucECKjOlImr?=
X-MS-Exchange-AntiSpam-MessageData-1: qMMr1qzmBt+tTkd8o6NI7qzLWlMTXDmYX1k=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7153b044-6762-455b-8900-08dedb8c8bb0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:41.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BK18ikBUSXozQDgi0F42GEJf/LQMEzuud6k31egPb2DPdU1+ZijnZxzKGOsPXggW+1UlPToBz0vBFd+ezbYX6f1V3QKsIPoe49dr2BVy2aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

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
index fe6c547c93e4..ef368954e81d 100644
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

