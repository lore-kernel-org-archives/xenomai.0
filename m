Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B342E8F8
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519783; cv=fail; b=CZHTMTItSsGuyaqCQHZKUFZTb9y5JPwjbgj0lCXB4TNmS/IeVjjdKB1JXj5yoNE+NBqg0WR7Jel1nbNS9d/nozHexhkGiVu147r2mMyZO0WTodO1LFuuNIxjHD8Vwis9lmpCoANMJh36Z7GV7sMbKqoCaozAF65jVtK5jWajHa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519783; c=relaxed/simple;
	bh=49SHkqZBzHgBy5dNzMD/FnuyS1L5/cTNNq8/h/7UwV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTNV2EgZx4CRtibiIEDqPgJNZptjqawf3hDdzmiwU6uW+5M6KAfVTpgoGFh3oFAcgqUA8NbIqmPgg0qdGfgA+pPgTyRZbR8Q7kXHK2YD7RNoV/3AgHQXjg43NJ6nlBRtD6AnK7IHra9R6a8NFF5sQUsEIkc3CPFI6/YKHkIk3kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=i1pTJKT0; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="i1pTJKT0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0GH8zEB1p9XcQWNOuUupfwae3jgRpLuD9YoS8NqDHo7lC5fAeomwzKmg+73XLNt8vpzGSMCL2joj78h9YLFPJqiBCBkUaDtY8xWJwoAA6mCOQP8Z+iSSu34EZJ0Rx9WcjfBMOUna5/RUOuRbvJpX9mxB4mBwY9hrNpNkdzGf/xGeEzsbUUsUPwOAGz1TFdcjdvsqXxNGUXMtrq6d87dJ/8yq1wPl9jAsHeHhZWiNnnymyrtAJbh/SAKIMmJYmrwrvmrUd17G9rVddMwMy/EghSdXvLGbxUwDo3c9dD/r7lqCCmHl+de9BRiQgauap15f+Ap4JyVtWH8NF8rK/6a8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zer9H2WtFmEWV69eoJI2Z/wZ+8Oj3e4s2SMaSOskkfA=;
 b=aH3fhqimy7WeTjTf/ndubstsHiRB0i0X2iRm/awpgPLkBHX64HxVhD9SprR1haBq48bjP6kx9ksdHsDzo8FwA0t3RHJx+oRVb6+k/AtvJnB7Zk+LLVnJG0iL1Fa64O8xXXQukJzkDjVb/pxQHgk9OYjMqS2Ahut8ti9PQLYKdJsKeUMULB5zypCrhBZYhBAiEmlD/YQpIc1xIiKWmfDsxTQznKyYXMnPTpBlCdhjy2IkWDs0nnleb2UcHtEo/ZwsIRQsJSdu7nRU2LvC0psNp4KBas11e/UqBOoRzvePuJ6MoRP1Q6gkUgQM2+nDKgHevRz/lQgWQgrnKhIhk7DPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zer9H2WtFmEWV69eoJI2Z/wZ+8Oj3e4s2SMaSOskkfA=;
 b=i1pTJKT00N3XOHhbJgU3/c88wxQGcdu+kyU8F0STEWWZcOq2nk7G8UqgRHAQ3CvK783YiI69N8htia3GzNIqhMsbSqd0Ik4qwq/DnWDyeSH/meaJT9dUGFsI5qRrxXCupddv/KiIc+1DITyJJMxhg3mIn/ZEnWTyvBJakDlKcE/rpDq+j/r8o7nB8xdfyqp24kelxsH9RWr8bunq+HoqEyRsJnnzFfWb2HX/E34iDiYRXbTpDUoVWto7Q4Rg3HwskBtVmGZw65hp7tsEVjyF4mnEHCgyzfdtRAN33dGFqpEZFyirktITlc+NANZQhQBTLUkctedH1u5/ZclyAVsWIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB9059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 17:42:54 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 17:42:54 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v4 1/2] riscv: Add EVL core
Date: Fri, 31 Jul 2026 19:42:44 +0200
Message-ID: <20260731174246.3431398-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731174246.3431398-1-tobias.schaffner@siemens.com>
References: <20260731174246.3431398-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd66bb2-27bd-46a5-2502-08deef2b268a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|23010399003|56012099006|18002099003|11063799006|10067099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5vQ6rqG1/A3UY6lxMA2yytOWqI8GMrvcTB4xV4iFuQlA97aJjanuoQpHfo99qtqKQ49c3FT3LT32qjyKIpBnHGe/h1X81u6mGxV1VgOYLEFE/1hWL12HHmVDkEA7Mo4G2FnE0RSIjoz3Y5Qhtj8SQjklsZSSLFk8+lr8fngOgrKPAUtpiVqo5DWyuBy0VHlNs9r5RqKmjEyRZGSM8uqnicnwc6To4b8vT33dglJqvkIFpGA2Uv1nJueUEhxVJ2v77HVEpkuCXd2CK+EY4VrbVEK3W+PA1W7TKxVCoIqBkLvbzJ/7GKCF2qz8cBfKPvC1dQj65XZf33ByRXoTz4e1/UO2kZqeGT5kY5c9L86XzBH49+l6v90I2ZrqWq+HXX9kmgGMI51lrf+vA+CBJnlbvwdF+wEtXpbXuLDLCufrazFAZ2ukz75TQnkBbG6OFeq4svhLCK3QY9avVUkbCh/ErQg4HDTEJTDxZiIo7PVky8BBWuMKKPCjYwQ4ddBmAY1UaEpxbBcZukEDwRKCOexALQp73I1luFKCk0wQukgZBgF27MYsfiDhXgUuimnp4zauv0uWJTK7zmug+mKGy9Bm8XbX7sFhmJCmgYT6tIUSpc/lcdVJV/2zuyOOuDAobRB1LOuIb2j7yUeSfw+yhgPBxh0+NE1nPf9HRgFM1iRaHTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(11063799006)(10067099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXEYRCjwZ5JDgivHVGsRk+FYjTVGWJO0TW9gBOuuE5zBq5PwnzcZ683LsG11?=
 =?us-ascii?Q?fztRUI9KFAxLsO1tU7MMTdn2SEeL+eBbxiZWyC8eYj9WGa6sb7Zq9B4Ib2En?=
 =?us-ascii?Q?eY2uwrxNrwVdyt8UQuRGn6Rex8lE5YX/9Hy3PV636QE24edEfHXekZVZ2Vzw?=
 =?us-ascii?Q?7r0cGjd/NP+DcfnMZllUnnktvmOAaMIqaHpsVUnU3rzNY4JgWl+arCiLry9J?=
 =?us-ascii?Q?4wVmQyzR9oRl5hQo9Iyx7MFgMuNVxnTvg6JMK2T1eZgfdqGnDUrL4HD6FikZ?=
 =?us-ascii?Q?85ZrSxG31GPuKRac4K1H+MArTndxmfwjQ+UjU0MpvsooJAYAqVphYSAL7sWK?=
 =?us-ascii?Q?3ZDMMbI4X3rWD21m1ox1bGQKL+V+paUAGBX3KpwzQhI0eRRBqLRSyZNPJOcC?=
 =?us-ascii?Q?v4nlbRyzotdnYZDbFOrHkAAQ+Ho8f2hWTIA0WUl5s/zgMxXrF5iqG1FOrNbj?=
 =?us-ascii?Q?0FHpWUvFPDaDfmG9EvgF0Z24ztCR0qEqiXtAiVF8cBSFN3cgoNIXrv8nuNZz?=
 =?us-ascii?Q?XvJkDHv1GD1htIjXuBaW41DVbgB4Z5SrtgFAskM5clznmqbsBL6vHnI02jML?=
 =?us-ascii?Q?hwmIcXhR5EVzoYtHzTdA6b70bpDXeAHrr0/MweffB81QFhXpTZ6l0TEQrBuj?=
 =?us-ascii?Q?PFjAsBJo9By1iDJQYGYQyVNXzAxwdWRxRJsGfEZUBg85uvrx+GhyNLSMb0xP?=
 =?us-ascii?Q?09amH90RK5rSRC/wXUih6HeWRBP9uqM7pF7eVrN35DqiQV1bz/qganJoHYnA?=
 =?us-ascii?Q?Rl+PUPO+cNCTGzwcnoKbno3oDpXI9gM6uHKZuAkPrAgVZaAjMJJMaubBa6ik?=
 =?us-ascii?Q?IcEuQS0Xz/cHNjwWlLhKcxlyW/F0UvoQRFETi922n7eFgic+BEKaesKI4GSB?=
 =?us-ascii?Q?ygPG9cn2kt9oAcVH3GKZxgmVBOM4BeCTONPXY9gN6/wptMqtU1MNo/VxJhQ9?=
 =?us-ascii?Q?vjU9/uLEi45hIBYvtTFzJSB9KBpQqAa4Y91m1E2G/Yoola6jlOBlTmerVJAm?=
 =?us-ascii?Q?p8GBbgoaHXgIFmDhI0iDwndgb7VKdMy5Khw8Jqy+/94qU8VjMYqkydkELOCA?=
 =?us-ascii?Q?/8fa9G8IWvPlxyngAfJKaZ8VVPhdRdWptNImEKSi6trIi4Su61nHxj3xbkd+?=
 =?us-ascii?Q?LqBRocG+9XOzO4OxO7efuF8/pK/kQ5Qs5ulAw4w9Fy0iOV90M4Q9A6IJ1VyD?=
 =?us-ascii?Q?kQHeLyb3W0M2KRJXRo3/VvZyc5kqcWo2GteZmlfllGoajq5y3JUzXKkt4YwV?=
 =?us-ascii?Q?hsHe2/C6P0YvA0n8tZPkipWpE7q7MGfEg4KcBS6XI5f6pwwYCXyyovrkxMOJ?=
 =?us-ascii?Q?Im+c4+wchomKpllJEfgpWwFJJR/GhfcIilTkpnBqhLOxiGa4Xy/Ql8c1kwZb?=
 =?us-ascii?Q?/b5XKXFl29BwvEDoQaetskXtfBZwiDLrGOaDF67Wiy9Ut3lIsgxH9E3le4d7?=
 =?us-ascii?Q?llFwHGLcwIhqZIe7AX7wwYMMT9EvwczVdfFhD4ISGUcVfYT/FiHLW2+mMbgF?=
 =?us-ascii?Q?eA5g0aldu9vnrWmFoLbdhBxYi+49gYZmpgyCgcRlMEye0ThS33XMQ6SknT4p?=
 =?us-ascii?Q?FsORLyx7AATEWTcwEZAXgSYq2OyN2hOUfX4zjZ8zMycYrikQhN5bAP4awjxN?=
 =?us-ascii?Q?20s+fQWyha1naqu3qVMs+pa7ldaOU78RRukcO/txrQccl6j8BQe9Q2yH9tgr?=
 =?us-ascii?Q?e4SLyfVzPsFw0fbIy5vanjcGUt9i/XRUKLATP2CNF9GV0bieJ77Z90v21fwm?=
 =?us-ascii?Q?LPSP9AJySlZ3J7i4LaTKZDRBhvXYGli1FS2eDQUgPvQxSohD2Z6NrZrVMaD8?=
X-MS-Exchange-AntiSpam-MessageData-1: SJpDRtJO/rO+OGpIIzwVAUAP6p01cHyYzSI=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd66bb2-27bd-46a5-2502-08deef2b268a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 17:42:54.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMcxuopd0M310dnbb7OLWwynrprDJQO5VETyH+bBhuB6GaQyVKvZ6kMlUsLxKTjOJh63PqDTjjK9fAs67N/9kWWXQE+n+7YAXHkpjhIfn0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9059

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                        |  2 ++
 arch/riscv/include/asm/evl/calibration.h  | 12 +++++++++++
 arch/riscv/include/asm/evl/fptest.h       | 22 ++++++++++++++++++++
 arch/riscv/include/asm/evl/syscall.h      | 25 +++++++++++++++++++++++
 arch/riscv/include/asm/evl/thread.h       | 12 +++++++++++
 arch/riscv/include/dovetail/irq.h         | 11 ++++++++++
 arch/riscv/include/dovetail/mm_info.h     | 11 ++++++++++
 arch/riscv/include/dovetail/net.h         | 11 ++++++++++
 arch/riscv/include/dovetail/netdevice.h   | 11 ++++++++++
 arch/riscv/include/dovetail/poll.h        | 11 ++++++++++
 arch/riscv/include/dovetail/skbuff.h      | 11 ++++++++++
 arch/riscv/include/dovetail/thread_info.h | 11 ++++++++++
 arch/riscv/include/uapi/asm/evl/fptest.h  | 16 +++++++++++++++
 13 files changed, 166 insertions(+)
 create mode 100644 arch/riscv/include/asm/evl/calibration.h
 create mode 100644 arch/riscv/include/asm/evl/fptest.h
 create mode 100644 arch/riscv/include/asm/evl/syscall.h
 create mode 100644 arch/riscv/include/asm/evl/thread.h
 create mode 100644 arch/riscv/include/dovetail/irq.h
 create mode 100644 arch/riscv/include/dovetail/mm_info.h
 create mode 100644 arch/riscv/include/dovetail/net.h
 create mode 100644 arch/riscv/include/dovetail/netdevice.h
 create mode 100644 arch/riscv/include/dovetail/poll.h
 create mode 100644 arch/riscv/include/dovetail/skbuff.h
 create mode 100644 arch/riscv/include/dovetail/thread_info.h
 create mode 100644 arch/riscv/include/uapi/asm/evl/fptest.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 70ea8457e1f6..193b14fd4b17 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -152,6 +152,7 @@ config RISCV
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_IRQ_PIPELINE
 	select HAVE_DOVETAIL
+	select HAVE_ARCH_EVL
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
@@ -381,6 +382,7 @@ config AS_HAS_OPTION_ARCH
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
 source "kernel/Kconfig.dovetail"
+source "kernel/Kconfig.evl"
 
 menu "Platform type"
 
diff --git a/arch/riscv/include/asm/evl/calibration.h b/arch/riscv/include/asm/evl/calibration.h
new file mode 100644
index 000000000000..4da81f33ce3c
--- /dev/null
+++ b/arch/riscv/include/asm/evl/calibration.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_RISCV_ASM_CALIBRATION_H
+#define _EVL_RISCV_ASM_CALIBRATION_H
+
+#include <linux/kconfig.h>
+
+static inline unsigned int evl_get_default_clock_gravity(void)
+{
+	return IS_ENABLED(CONFIG_SMP) ? 6000 : 3000;
+}
+
+#endif /* !_EVL_RISCV_ASM_CALIBRATION_H */
diff --git a/arch/riscv/include/asm/evl/fptest.h b/arch/riscv/include/asm/evl/fptest.h
new file mode 100644
index 000000000000..76a8092af702
--- /dev/null
+++ b/arch/riscv/include/asm/evl/fptest.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_RISCV_ASM_FPTEST_H
+#define _EVL_RISCV_ASM_FPTEST_H
+
+#include <linux/cpufeature.h>
+#include <uapi/asm/evl/fptest.h>
+
+static inline bool evl_begin_fpu(void)
+{
+	return false;
+}
+
+static inline void evl_end_fpu(void) { }
+
+static inline u32 evl_detect_fpu(void)
+{
+	u32 features = 0;
+
+	return features;
+}
+
+#endif /* _EVL_RISCV_ASM_FPTEST_H */
diff --git a/arch/riscv/include/asm/evl/syscall.h b/arch/riscv/include/asm/evl/syscall.h
new file mode 100644
index 000000000000..1ef2d008934f
--- /dev/null
+++ b/arch/riscv/include/asm/evl/syscall.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _EVL_RISC_ASM_SYSCALL_H
+#define _EVL_RISC_ASM_SYSCALL_H
+
+#include <linux/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ptrace.h>
+#include <asm/syscall.h>
+#include <uapi/asm-generic/dovetail.h>
+
+#define raw_put_user(src, dst)  __put_user(src, dst)
+#define raw_get_user(dst, src)  __get_user(dst, src)
+
+static inline bool
+is_valid_inband_syscall(unsigned int nr)
+{
+	return nr < NR_syscalls;
+}
+
+static inline bool is_compat_oob_call(void)
+{
+	return false;
+}
+
+#endif /* !_EVL_RISC_ASM_SYSCALL_H */
diff --git a/arch/riscv/include/asm/evl/thread.h b/arch/riscv/include/asm/evl/thread.h
new file mode 100644
index 000000000000..70a07d5bfdbb
--- /dev/null
+++ b/arch/riscv/include/asm/evl/thread.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_RISCV_ASM_THREAD_H
+#define _EVL_RISCV_ASM_THREAD_H
+
+#include <asm/csr.h>
+
+static inline bool evl_is_breakpoint(int trapnr)
+{
+	return trapnr == EXC_BREAKPOINT;
+}
+
+#endif /* !_EVL_RISCV_ASM_THREAD_H */
diff --git a/arch/riscv/include/dovetail/irq.h b/arch/riscv/include/dovetail/irq.h
new file mode 100644
index 000000000000..f214e2f6ee2b
--- /dev/null
+++ b/arch/riscv/include/dovetail/irq.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_IRQ_H
+#define _EVL_DOVETAIL_IRQ_H
+
+#ifdef CONFIG_EVL
+#include <asm-generic/evl/irq.h>
+#else
+#include_next <dovetail/irq.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_IRQ_H */
diff --git a/arch/riscv/include/dovetail/mm_info.h b/arch/riscv/include/dovetail/mm_info.h
new file mode 100644
index 000000000000..e38b97d1f50f
--- /dev/null
+++ b/arch/riscv/include/dovetail/mm_info.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_MM_INFO_H
+#define _EVL_DOVETAIL_MM_INFO_H
+
+#ifdef CONFIG_EVL
+#include <asm-generic/evl/mm_info.h>
+#else
+#include_next <dovetail/mm_info.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_MM_INFO_H */
diff --git a/arch/riscv/include/dovetail/net.h b/arch/riscv/include/dovetail/net.h
new file mode 100644
index 000000000000..34062fd4dd13
--- /dev/null
+++ b/arch/riscv/include/dovetail/net.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_NET_H
+#define _EVL_DOVETAIL_NET_H
+
+#ifdef CONFIG_NET_OOB
+#include <asm-generic/evl/net.h>
+#else
+#include_next <dovetail/net.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_NET_H */
diff --git a/arch/riscv/include/dovetail/netdevice.h b/arch/riscv/include/dovetail/netdevice.h
new file mode 100644
index 000000000000..ad3e7e99f1c0
--- /dev/null
+++ b/arch/riscv/include/dovetail/netdevice.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_NETDEVICE_H
+#define _EVL_DOVETAIL_NETDEVICE_H
+
+#ifdef CONFIG_NET_OOB
+#include <asm-generic/evl/netdevice.h>
+#else
+#include_next <dovetail/netdevice.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_NETDEVICE_H */
diff --git a/arch/riscv/include/dovetail/poll.h b/arch/riscv/include/dovetail/poll.h
new file mode 100644
index 000000000000..7196d625d0d9
--- /dev/null
+++ b/arch/riscv/include/dovetail/poll.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_POLL_H
+#define _EVL_DOVETAIL_POLL_H
+
+#ifdef CONFIG_EVL
+#include <asm-generic/evl/poll.h>
+#else
+#include_next <dovetail/poll.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_POLL_H */
diff --git a/arch/riscv/include/dovetail/skbuff.h b/arch/riscv/include/dovetail/skbuff.h
new file mode 100644
index 000000000000..c6ee9016a37a
--- /dev/null
+++ b/arch/riscv/include/dovetail/skbuff.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_SKBUFF_H
+#define _EVL_DOVETAIL_SKBUFF_H
+
+#ifdef CONFIG_NET_OOB
+#include <asm-generic/evl/skbuff.h>
+#else
+#include_next <dovetail/skbuff.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_SKBUFF_H */
diff --git a/arch/riscv/include/dovetail/thread_info.h b/arch/riscv/include/dovetail/thread_info.h
new file mode 100644
index 000000000000..bfef01471f0c
--- /dev/null
+++ b/arch/riscv/include/dovetail/thread_info.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_THREAD_INFO_H
+#define _EVL_DOVETAIL_THREAD_INFO_H
+
+#ifdef CONFIG_EVL
+#include <asm-generic/evl/thread_info.h>
+#else
+#include_next <dovetail/thread_info.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_THREAD_INFO_H */
diff --git a/arch/riscv/include/uapi/asm/evl/fptest.h b/arch/riscv/include/uapi/asm/evl/fptest.h
new file mode 100644
index 000000000000..a404662b12be
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/evl/fptest.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+#ifndef _EVL_RISCV_ASM_UAPI_FPTEST_H
+#define _EVL_RISCV_ASM_UAPI_FPTEST_H
+
+#include <linux/types.h>
+
+#define evl_riscv_fp  0x1
+
+#define evl_set_fpregs(__features, __val)
+#define evl_check_fpregs(__features, __val, __bad) 0
+
+#endif /* !_EVL_RISCV_ASM_UAPI_FPTEST_H */
-- 
2.43.0

