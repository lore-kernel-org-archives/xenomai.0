Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634FE3C5DC4
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042923; cv=fail; b=C/KnCR0LtIaNHVKfeIMEUMddtQFF0yq+koyrN7aEE+MTU/aimRWrjga+Dj4HPpIY/sZrqoyfvu4FyYb4qAPQEkvbjvSsn8OAT2mQLDsoEWsJiYBmmLUcsRA101I6H8vex4vFRor0wpacz8TSlLo/2foBqASYq+KF3oZqiTpKH1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042923; c=relaxed/simple;
	bh=g2nopdTl1UgzF2rJJ6l2rb6r1i2lTseMFnuCZ0UQWsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inRIPXI6x/LHL8cCJZJzn4HwsYsFrkaxCqzXb38JoQ+k0pcpGQGNgkBvSXGY6ecRAlBd9N+sFQzN9LuCY1jGi7pqxWD0yoZat02BfuTuQZTFDgMxc+fObZBfuYkAALJ/hoN1Dg71KQ14z5qhEHdrxZ2CjzbiHUKGP2K2M5b6lG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jGv3F1+P; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jGv3F1+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCl3o+jcjE6Ytgs2KZTJWs2lffGy9EK/pLT7DvttuRqpzDQ3hjzQ/IW3tnBCXQuPPnwvh/gp/gemmd0ocPitzFzM5WbMxK4d24pSU0b3iIyNCnD8Gd4jmVquaELX8cBwpGChpqm7zRxDy5KuVf0RrINkOnTi/tT7Q7yp20iNac0IoECcn2QoOgwjd79yMaVu/Np3KGd5taagU5r99+ehbCKpOl2Y0NZj5/10YRlr8UOLknmq+Wmu499OGzr/uGOD4mU52h4GfnvFUMY6g5HJ3wJ1GwyuH5fOOLY0zOCU4TP6ze+4VEN6My6RZ0LceuuUdjYW+Q1V1PVk6pneQzLfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKCmR152I3xCz+hqkXJl2hjkF9ACpT/t770Zyz4A2sI=;
 b=QYfei4Gyp0KQZltNE+lNhPz1TZUnZiYu5l9WrLUSMLtFpbIYl9Rw6Oshx0H+Zfs0ODWhjUTlhKs6toZ/jJuXAvA8hTOuaCIQemedBWzxmj4Ol7TF8GCGhWxJTwN8NqMToxJ44aBeYs/pWY95k/4SNncdO1+oTAyfovkVmzR1d3foxZTtGOFhLxEvfJxaz2RzbMH46r7YAtIjLzuW3+51wUIW+G0VjdHXvMvExEUVPVqtfE8fyWptQO8ixlxMXvbc/+1lH//nkgaxtn7Z4Sdjlbky74HZphxH3XnskGOB8wdYtqua2IPHPTfuTWG+EnhqTNXx6uSWLl86uQtDQR2peA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKCmR152I3xCz+hqkXJl2hjkF9ACpT/t770Zyz4A2sI=;
 b=jGv3F1+PLOvhSfSN2HN0Lv6PBm6pp/11DR42nTOfvjRvH1beDDEgZGJ2mIkppzsSEjPvyyTytASFoiOIA4+kVa3+qosoHpBEykFtysS9gHvVycY+MnfaqOpYqsMtA8sLQy/utA1GE/XGVDd8ciXy+lZl+NlqX3/s2KqMbxAJmQu7ojfg1Vi2RmpSccpDqOaQ3+IRAom50ZOmwIqQ73oKrFRxxQugXHnERKbnjVKG9QyLzAS6vEIhPxSW9a4ikrmLitOToDQWBiEKm3xtJWDM+PqPYzRUn88ke7NVGWwP1KtYSFTsoDmfRxeTlxNORm4FEGqDQyw4PslRjTnmfZFwLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:41:57 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:41:57 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v2 1/2] riscv: Add EVL core
Date: Fri, 20 Mar 2026 22:41:47 +0100
Message-ID: <20260320214149.2211433-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320214149.2211433-1-tobias.schaffner@siemens.com>
References: <20260320214149.2211433-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: db7ce769-eced-4ffe-3ff5-08de86c9829d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	gwiv2Y7STsyXIxmcg87vrazZL+Nlb0x3HuWHlEu3ytSHCegawFRK4/ZzITG4picBAt8oYHl0V5eEZr1utm7/C/4vFs+o84HKZhkGE2vHbF6tRSUYKGWamqCAZ52NOV/ZSiUc92kHkJUdcOXOBkUATIG3UKN1QSRUHZ1yQAH9sNlGFIsb4Pg1+0mMBV1BYyrv11hkDHwMZr+Th60pPvX2RHP72W73Li+Na4bpjRqg8k4k//YM+3SzywC98IFP3mVOhIAjf0vfMm0ZdLxo7MCmnzECpK33Oe+2acl/zsfq/FCrVjIBlJ+vRhH/FXwBkzb21Yf5QrPXfzdxebWturE5jcPzFJl4iol8i97tvn/AaaShzkvTvFamDPyHKkXHBkHiVLKmnD6AKhhK5iOKGH8hQPlQOyv//aDPaWCujUUTPhIZsi5/7EqYjE2e5g4D38/VOHgANTTZopqmbr3YOk3AYJHIx+b2KakqnXps3l8h4lxGI8oGfB11ExIxYl/CF0sYoxa5c0TfDlIjJG9btKFQm7aXWWKIldwLEDQCDucUQbEotszrD3z1NJz+K8/V05eKOiDV70kkUVFUFiPwk3KxsvgAoJx6ZysubmfodEJJ5+PytPxRCAHPoQ7vz/XO9e6F/mYQ2bhFTp4cxgQ1tvnnpbBalT6wBBiP1nFjhkfWslr82vugaBfgJDpPTyQMwYfp5+9D6i/6Rly64+qB1Z0PkDNfJEJoYyCkpMh0vUvoHEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmIDMOGbzdWA3p7Qry4y6ZwUZxnRZ6WbSurPwQgTjVQQI/squMOasX2iy2oJ?=
 =?us-ascii?Q?GaOL3HeCNMhtNviPvzzpNI5u/dTDlJISIM51DXVZd1XnWF12CJ9Ocsbqr1Pt?=
 =?us-ascii?Q?TTdffIMZoNHQ1/JLVj5pijgMtxv47j7y/yhCKriAin8JVbQ2ZGUV1NADJRVc?=
 =?us-ascii?Q?TW07XmIZjMNHQTNlciCipmedVfHlAdlyZPnhq+1+1/bU2gEu7S7jN8RkyjZD?=
 =?us-ascii?Q?bIksgVjse+bFt/wbmhIghdcqXPVWuuJSTHy7Fc4frJB4SwZlIcapLuoEy2hI?=
 =?us-ascii?Q?56vR2gV0sMVYFA2wGlxy5C5Srz9MrVS15nKIiQf0C85KWdMUBfzuUe4Lj0IG?=
 =?us-ascii?Q?3Pc2YrLfWqwTShtpQ+Rs/VX35nfvTEBwXonaQa+LGStkSklW1//yjU2QcIcF?=
 =?us-ascii?Q?H0sif9w4AZtMDdrS7MpT4troBXe6q+zRZJhvSMa14pUz+/xEQPoHkvxcZ4JZ?=
 =?us-ascii?Q?2xgjbOiKfXISA8GBJxKAFmVC/Tq2DhniM7ojkt76yggDZD11SiSmwvFdJzOC?=
 =?us-ascii?Q?KDN8rhn/j/fgFptUfEsvD8HIrdkPeYFrButx0LHSKzKuZPcBuiF5LUZcnCX9?=
 =?us-ascii?Q?onWd3IER9iICaHbDkCGd9MfcQ4sahpc/Sgc3oIr2l+eQRuIHBc0wseyTkf+/?=
 =?us-ascii?Q?mjBbAnOubgyudWXGjVGGVccUVKsWEQltqDLT+No7wIlkvA05zDfpGhJZmBrh?=
 =?us-ascii?Q?BHP/bZGKvmuLcX5dNJWnricjwjI3ne9yO9fTTguoyu9CNC2hAXrBatyRhPi6?=
 =?us-ascii?Q?1DHzv+0cpkOIX8dv6BC4qByZs/NMoU6BQJHXQ9TN1ibnNcS78Yswc/IeuVEc?=
 =?us-ascii?Q?xraw/oNvsIstBJpby34M2DyvEa9AB7aNw2INPl5z60G1b+GZhioJSL51CSma?=
 =?us-ascii?Q?+vPfTCVcgcmvvuCJHXjVI7y2208RxV7IBnVuaeEzQ4AE9h6dgqgu5OlTJ5Om?=
 =?us-ascii?Q?gPygqTt5LyypV1w6A1Dqj/OyJrtFWut0RPNU/Z4DhIWx8WHb+E3smLHj9OLM?=
 =?us-ascii?Q?OgI5zLBDt6RmHQXAldcz6NpJeDRQVkfTOvCGf/vB12s7KfU3w53KqCGoexmX?=
 =?us-ascii?Q?Bt2JKXgShe8Z4MYvBaIq4gMaG8BTuorzeqLg3UxxJjF1pYNTTM870UwP1rQy?=
 =?us-ascii?Q?DguJDNTScY8vqTr8GHudXgKxmLEAuGY7T1lT5DW1CZpIl8t0ZD6ElmKN2mnV?=
 =?us-ascii?Q?yiKv4vRS23W1CodX16eDBTMDM0WH/F9dbXqMv8m/oy183o6kZ0XSsWo3dLpn?=
 =?us-ascii?Q?kBxGftlMDnGJxfev9GOoDvKE5HBkD+w9kCKuZa+MdJQElRSm6cdpSS+8JG8i?=
 =?us-ascii?Q?MIdzq7meUYcdw3Ic2+umtZOMZ4eBpglmdOLVPrOMZOJa07wScUS5eJxyrN1G?=
 =?us-ascii?Q?OfUYJBJcCWWwVmAOF1F8P9b6mFC48mHfIPf4fJGYnvY5PzYV9d93+AhlAQig?=
 =?us-ascii?Q?9+L42VoA157F5znyzi4Iksk+XkDtsAZt228eZF7I9lg8KxZ9NKjSd3LUf2UA?=
 =?us-ascii?Q?X3lyZpas/P5vm5u0lIV6kczmCLfSgK6S9gctZH1AvauldN/HSDWYeotQbEmQ?=
 =?us-ascii?Q?4FHw+a6LArfVsYnGP5uEKE9nrfIKjXZbaBjjgAWYRO2tr6ommJlt7Z+6Oe7Y?=
 =?us-ascii?Q?sfev/1neLkBOfMFLevwbdysftdLC3XgPSHfXLR++NVr8c6P2xXtPnQq82una?=
 =?us-ascii?Q?GD+OtVBYzL65OAGKSkIl84+0UP00cWrYNbetVMXTKFzjaFx7cL7x6C/sJFPN?=
 =?us-ascii?Q?YXIWLqQQkggpvebPORcz/pQqtTdo+io=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7ce769-eced-4ffe-3ff5-08de86c9829d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:41:57.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZLfGHm7CV8E/uIhYE1EX4mJ+HWt4+8vTrGvfcdudw6KhBSpU330pfFzvWPo4+qVD1EkCve4/PkYlNGGvFrGYEPqnEuoHo4bZL91VQFuHeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                        |  2 ++
 arch/riscv/include/asm/evl/calibration.h  | 12 +++++++++++
 arch/riscv/include/asm/evl/fptest.h       | 24 ++++++++++++++++++++++
 arch/riscv/include/asm/evl/syscall.h      | 25 +++++++++++++++++++++++
 arch/riscv/include/asm/evl/thread.h       | 12 +++++++++++
 arch/riscv/include/dovetail/irq.h         | 11 ++++++++++
 arch/riscv/include/dovetail/mm_info.h     | 11 ++++++++++
 arch/riscv/include/dovetail/net.h         | 11 ++++++++++
 arch/riscv/include/dovetail/netdevice.h   | 11 ++++++++++
 arch/riscv/include/dovetail/poll.h        | 11 ++++++++++
 arch/riscv/include/dovetail/skbuff.h      | 11 ++++++++++
 arch/riscv/include/dovetail/thread_info.h | 11 ++++++++++
 arch/riscv/include/uapi/asm/evl/fptest.h  | 17 +++++++++++++++
 13 files changed, 169 insertions(+)
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
index 000000000000..987246edac69
--- /dev/null
+++ b/arch/riscv/include/asm/evl/fptest.h
@@ -0,0 +1,24 @@
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
+	/* TODO: Check if we have any FPU features. Not using any for now. */
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
index 000000000000..9169fc5c1b50
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/evl/fptest.h
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2024 Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+#ifndef _EVL_RISCV_ASM_UAPI_FPTEST_H
+#define _EVL_RISCV_ASM_UAPI_FPTEST_H
+
+#include <linux/types.h>
+
+#define evl_riscv_fp  0x1
+
+/* TODO: Implement fptest */
+#define evl_set_fpregs(__features, __val)
+#define evl_check_fpregs(__features, __val, __bad) 0
+
+#endif /* !_EVL_RISCV_ASM_UAPI_FPTEST_H */
-- 
2.43.0

