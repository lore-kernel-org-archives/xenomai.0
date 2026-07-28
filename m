Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA441D129
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237199; cv=fail; b=bvjc3Z2722PZM9+nb8NoMnc+ZrgTtdbB8I5M65KlQ+Md+WkH9G83igIJBjqsz9kVV/61jR6tN7uO9WhzG84OkmuNxg8trFQKfvvOh3mycP52OGrt09PN2vYE6+78t4AGe3dlq5wI8Pz46VlgTSZ4YjXkoHP/gNiWjXaw53VRki4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237199; c=relaxed/simple;
	bh=kKRwiMUROKnlu/s/sPxijclH/RWtHa+XvA3Kar+ytzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1cxKbCAaTyrD2d7Z+Exie9XaEpr6xo1haKxPn8fBghpC3FELzQ1+UCedmcWNKxGy0so43Bxma0taMLsBRljKh3CS5SEBUR2Ys8M1mKJZrRHD+ZJJybqH4mqmrIitm2uMNrPAq03XtA3HNfwq9H5gZpjcck1fjJQ9RDXenwnBC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CPjzbKsC; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CPjzbKsC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnXDLrrrjosepITvHv+RJ/nko9ow/zXpHmlPmAOvDMie946L2CMYrKvpGVpUS1dQCYpPA00NPKf5gYdJMdtYqwQGi1U19YYQgQG7nGkeOr2FZw0OonuBmRygRTHU66b9ZmNuR/Srmb+KS6asThe/ANVGQ2OOJg4kRaS/fzZf9w/VND8yeaMgMtoeGg9DOP6KDpyUcrzv1WbqjHlUdVB22bXLdL6vPNdW+4JdSfmT+yNqNRytCMcXfV2LwR4aHTkhaMEZkUkzx5ECKxv2ScFF8hI6s/+5ev8HZ2V+IeVPHehxEKnfzcYNGk3A0jIbUrGW6VsWIKo/Bb9LzhPWj7HlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUTGP7IdvoVUhnmSttXCA5iTnw2d49dDYSLRevavGno=;
 b=LWFw648gErmKJJzF08PiVRu3CKz0fE5SJ2Bfdu0YRyj72Y/dS8ry0jsQ0j2CNdlHxSRoxNy4eQet4d8YzYNWnXsusvfHYj47k7Y36PMdiPw1jioahOLtsTGKHzTli+1yWVfuwUXKxd8E7LYPNHvhSxruVefc/Hz+U4gRXSXXUeIicQ2LClRebXQRhdqdiksIxizeJRREVBurWRrMhl0H6e+W3UKo+IjrUqcmhU8uwXxbnhAW5tzlijVev3iRVLSBHzyl/IPusZPbP9Qh1FhQwFeZSeMxJeLqjduUW2bZJj9SECYtyo07HdrzwjYmigAfuZ3KOoBbWxta514g/v6FeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUTGP7IdvoVUhnmSttXCA5iTnw2d49dDYSLRevavGno=;
 b=CPjzbKsC7GnD8ZmjKcic7ZP77Z7t+NSTKC+JXf9oSG6mIu/dZ4hEU1qyjlIqstBjo5hv/sCEB/IsHkooBo673jpvkwnyoyMCOrtiliInoHz23/Qyt6YpAj302Bv4Sqa5dBR4ZyA+MXFgKfn8635vYrQxVGLaJM6/inAQggbn17C9oRl7Tarq1hDAuTS3jBpMfs4c7jU7Sh7h3r93PjXDcpv4n1ndznpcvAksEvnbRBasgfSIkzx4OY7hJ/VIK6fcJGUJH7MrRjy/5m32imr/wAiCLKZf+0RrEkhILTIteZiAXOBrsvKOwHNhY9RuDHNpeoSE5JQgJQLrC2Ak+BK+BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:13:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:13:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v3 1/2] riscv: Add EVL core
Date: Tue, 28 Jul 2026 13:13:02 +0200
Message-ID: <20260728111305.2699306-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111305.2699306-1-tobias.schaffner@siemens.com>
References: <20260728111305.2699306-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 700a899c-1ee9-464e-34d1-08deec993668
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5gFhg3ZlKE146KI5+W+kIsmNVDMyKeSbRI24THKDNQVdLUM9Iu1Iujh95phjV2/h7mMvo22eHi3s3FvbrkbTBL/6rMm+U7gUIVkBLhi8e07xtjptTWNAp0k3bbawHjREEo0XFXNMde5fhM4rcofO3uKQN8nXZ5tRfTS1L5f/5OH4tYiSSorh59CBsHznXygowkQi90uIi29Cm/WRHATjdcOib3M3bZ+LQubMI/F+A2FxcPpbsf3QzdD4mYM9QTeWQur6ZQAnGlrnz6WskmvmP3JWJOb+h9Qr0FZYqXzni7QXemmuNLxMwdxAas9MFloH/9zun9U1+6HHp6FjGKltAXPXk5C9Lw9u3L5KNTwAcPrh9azMfPRXQEnpCM7FumwXRYkBGwWGMbcx7rOtOz0lz5rxuIUf0mdjObA1z68B5939gSXmv/0Rd3fvK12rIT9cRq3CCZn0kOJk8v6aRauQbtiJ5GIUc9zEUXjVVZMtMZCivLhBxsfUov+vwUs3ltvMzI3lBAQWAOYGkw1sIRV/IlOccAo/j+yIE9hYTbF+Qkt9tX81WdaQAEvwhPuXaCBXXI6WMq3DqqWb7wIWR+K8hW5T+DSvSZ/sewS1bk4C3yI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXt+yAGAHfGNsdRgHgWajx99fRWuawJFJpW/5StvIQWGza08yw/cMHEr7HNQ?=
 =?us-ascii?Q?KrDJFbzqZfuIZzMm9dBMOf1x3tQfBpeb4ak85RiLBpKx/RRnJWqqmaawR10h?=
 =?us-ascii?Q?pxlVcJq34A0kaWlZOxR86zRTAyi2qmhXI5aREEi0BuOACJ5ojdFjSvMaFLAZ?=
 =?us-ascii?Q?Ef8xakLWJir9jBECRDpPPFNURz8IjxlkjLs5cxeZxfippySC6E+suw7KtpNf?=
 =?us-ascii?Q?1UGGbK0raT/+TjrhCHMM71vLzopcly/pjIxCCOwSBRlgw+IAM/Foa0DStlF1?=
 =?us-ascii?Q?5lWsyQTK8nwOJrp5FD6OaT5clOz3T9PdprFxnPfuQPPAouKt0/WO8yXlUpMV?=
 =?us-ascii?Q?X/E5egfm6UH2IfpkM5orQ8XdnyfWfMuAIu6tKwxPebapK5rxTfV6vKU5CDVw?=
 =?us-ascii?Q?1kzzTeStqv6N1DxXx7aaZBG5t7ZwfOZS+DRl3Hum2tRZAv1nfju/NawXxsFL?=
 =?us-ascii?Q?4ftPPC01gRmBE6ahOnYcENgXLwv/W6c9yWDWvD8x273iQihVb/3FdimVC0um?=
 =?us-ascii?Q?zMFDLwlWVfOAWlnjcETIiR8xMLe0AqHc+DITUzm3JX1d1tlsufVCnilR2o+0?=
 =?us-ascii?Q?BPTp5StZ3dWacssCw6Rw74ULPZgS0rVSS+z2aLC7nTXye6yeOcrNF42SPT7o?=
 =?us-ascii?Q?qyFQpN/7j/n5Nu6PJQ+Br+fg7i4A5EEWCvEmPvwJ91ZOpY5ezvRQVVqhqm4g?=
 =?us-ascii?Q?Dc2b6IBKSh21Wq3O9VhTD/B6z8uZ79WvwPXP2/BvSKvids8BNb2tY0a2G9eF?=
 =?us-ascii?Q?9rtiA291g9CEc+zXqYkctI3VNmMq5Ofa5kflTOjhG23gy9KkuvnMjyQe5zFo?=
 =?us-ascii?Q?sSVIfZEPX52m1mW/f6AzFEYvG1qj148QSz7YhAOO1Ul/iF10DCGpsHTnBPUE?=
 =?us-ascii?Q?cEahpa5TckMPS/gqS2dTaD/TlN5ThsOYeYDisSjEwsxhsBjbUi3bQWlLMCKg?=
 =?us-ascii?Q?ZOwQZvFFBTen3JF6NADaFrPhETU0neSIFvIlIa1l45Zt1nb2W+6VugZfWOmD?=
 =?us-ascii?Q?X+SWwOUiRfZjDcDGqUxPEPt/EWSmlaOp0jJ3/FKlcsQCMVqyD0OEd5Ft9tMC?=
 =?us-ascii?Q?JbxBbbLrWEsNLgXwD113edat9h45PRWdzwWWa9FwpRdRmuZ7i7gXXlXXx9DP?=
 =?us-ascii?Q?hl95ajE1UJwZy5Vpp5Po6xSDAxU39p/bnGyC2o2zWHSfQ8X2XsLgi39CoHIK?=
 =?us-ascii?Q?gnlBjxal+lF7t0rOa8aBBauo+y5ryOWagrFU+G1GdykEymOWk9dpZ8n2xtoA?=
 =?us-ascii?Q?tnlQ5pdNUU0k5RbFuHytkVZik0tZ/hZmBxXSwIlnx9e1OxOo7LdqBSbB4S/w?=
 =?us-ascii?Q?SsrAuJI59IBYXiS0JQVIICxc7Gng6INycA63kDJb2tAWkL60kdh2Ku4vmxbw?=
 =?us-ascii?Q?y+3vTyym1rxcgehegOKCC8cmgcTaNFSaFOGGMXXMh/gTn4dbqJ0203vQYo+q?=
 =?us-ascii?Q?wkRqM5KtMGc3Czc0cnEDN8ykSA/bvCE0UKvdmKwEh1ZaWKHXPcQWFC7ZzYtE?=
 =?us-ascii?Q?XcSwRiWwo2/86OaJF5Tr3h1wv7KJ+YqyjpzeEcXbv5m76lsfw/qxb9xbaYOv?=
 =?us-ascii?Q?8rR+iPEWcBrB4QhL0yRhEahrrwQ6SBamgTzS1Co3pV4K2hi1lZ/YcRVx4cTD?=
 =?us-ascii?Q?r1dWn7zBjluEmZ/R+FlfiZ/D30B5JfgI7+ErQ7QIHWqsYYoknwyK22lPpgqc?=
 =?us-ascii?Q?QAMFJRgGhiLBOPp0QVpX089qs0zsvJZLaeUqv56dt/NI7+Q4/GWQCZvKSTZ4?=
 =?us-ascii?Q?v8wNInnmMdd1J5hVgXgoCQYaWDuYSiM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a899c-1ee9-464e-34d1-08deec993668
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:13:12.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnuuWiMrhrxVjHZlJpv4z01/za1PItoVaKOxiVEn4Dy2NAfmVtilXPWCVTOGS4oPDUbwTUMfgxJo1kFKHIE7HTX0Qj/BTfZHOA9L6EkOmUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

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
index 912aada80962..cd5aba11360d 100644
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
@@ -378,6 +379,7 @@ config AS_HAS_OPTION_ARCH
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
index 000000000000..1b1f4f0ce373
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/evl/fptest.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Derived from Xenomai Cobalt, https://xenomai.org/
+ * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
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

