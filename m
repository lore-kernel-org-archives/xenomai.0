Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5902ED85F
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091106; cv=fail; b=MoUnE5HoTXEuISLR1OMzcZxhQDs+NFZPA0b+SZgPwjRME/3wDVwoQEDopiNegokYEOZLPQ3BD0qI9Uw10hQlgp/ql5Wk8iFtppfPnnpUa24aFS9GmF9Z7VqWeeubMhBBcoPSOhDLlaPkOoJfpygPEgnbYn5Tft3keuSvzj6Cxyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091106; c=relaxed/simple;
	bh=fr6tD/GLQIMtBRNlJWrra5ZWLu1/2TEFc6r5IDpKIo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8y5xipApLK5oQw9+O70+1+9cdFz5IyD7sLxuG5mGbEH+++gmoYy8Jnns60Rk/SjyxqqzWorm0o2GsdX3V9e2tnJqipy4qPFZlgQEYGYEelCbDZs2kzlXOHoNDV1UOn6hP5/in3IbRK/rlEBEQA+qBQhIiTKWjUhVzcRx2yY0ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xS6QgYkM; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xS6QgYkM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6vkrP6ma81Nm0nRUPq2YSBsZkQkcR0zaVM7Fx604+qpo/JzmwKhgAqIBSY1fbMn1R6FxQByOlFtttZwrE3oL40NmtX9ne+hjzVaCjotq7lTYN6y+yV9JPjZslzfIavQJ/Kot8rhvXecw0xralvtl0LW5f3+BdmzLhPYr21DO15eFBT1+3GS4IAM3PF9dgXL1eKnzI3PY2XL19wzDifsJUkCUGUkigESxiAzUiwY4i6Hi/AqJXLim4JQqEYKI/LfOvg7N65RLbsWnHLQcKIaCarvZs6Uj6of358tbaAlHACcmf4YCY8GlMbUdAoTn+HOeNrbKNrUt6rCR6vHh4BuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZaDXNZMqCi7PAGfLKBToJO+ciC8yhd+LOy2D7MnxS4=;
 b=Bs4Me3vw/OFvwWSN94Yl4QLJSmrSfQg3qOubsqmyU7c1xiSOyFXYCQ5LdjqKbIWDoObdIvSvrl61EvAaLpMsb+mLgmR+4uW1GM1UtAXBs8ODk05Irv1+CtLWtfh1os4MbtsHVa7vXTMth0zA9tiGXOduEAtZ6mLZKuhXXjJnVYz+N/vBFxazaJp+eOMxpStgzojSjOBdZvQygE7+B/FXfGRd7kt+nJ06hT6BekvR3+KiJvYJqshESb2jgy0XP7fdzPWmXmvQH1LW1hzJSDA6g3ABZ8IkK+WV2yqqylsOPfe3GIyz/J4jTrppjAgbUg8ymBf6B+awbncDoO4HTwZe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZaDXNZMqCi7PAGfLKBToJO+ciC8yhd+LOy2D7MnxS4=;
 b=xS6QgYkMKl0B7ZFnltuN4RB0kSIx9yA7JQ+bXDD5hlnwiFXdDue8cq0wTE8HneeB2140ls68y27RNjF65oDuBAZwMKRvaTGnMx/xViv2b3zHt+7gBiV844Rc1axRr7nOX7JCbt/czfAiHJ6fIoDCHZIaKKo+GASisQTgFqWZa1eqGtHnhfrwvIV4Wlj3ix8WLv1Bv9pAqQnT+jh01OA0/0OsYz17JhIrPHcNYEf69dsMRfunp394jmeUsgbf4taradM6YfYvKp3mECxs8WTnAQcyKFgbjeDwh94N0Hn9GcxH7UerKRO3zqvcPoXHU2nTM/Xt79EiAcPgOCbx+8P20A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB5217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 10:11:39 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 10:11:39 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 1/2] riscv: Add EVL core
Date: Fri, 10 Oct 2025 12:10:49 +0200
Message-ID: <20251010101130.3758633-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0c1553-b6b6-4856-91a2-08de07e566f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZdU1pxVSN1NVLMnvp+qGmwsihPvQZRt8vnK9kYj8YpSS1HFmwbRlBtbEWLf?=
 =?us-ascii?Q?R2pDbMtBz5rcw/NgjhVieZyhJ8KDLRe2mWhxiyBue8zGNM+Y9aoLuCvuLjMX?=
 =?us-ascii?Q?iHqoToC8U4RWZf7AAGn95yWc+oB/zc7292RVnhBMBcZMbnM43cQ2M7DFQPkv?=
 =?us-ascii?Q?06PAuft9GF4JEGcqAA+3NwIkAiblP+7pN2wU+bKjOS/VrsffqZJkpaktwmA6?=
 =?us-ascii?Q?LWbJePR7VaA0fxXae6khhpLalgr0x9kNxbkQuUT6AYiExJ69FXCxanKdDzpc?=
 =?us-ascii?Q?BPewTaxG7XvJV7VMFHkb8+yozB5h23RZ11aJxwTxC91AYBXGywjwo8FD/HIo?=
 =?us-ascii?Q?gcjLf3xrZyNeOW92o2WNYZ6088JRegZYwWnSJsKTAE5DSOV9oIZApUJ+hD65?=
 =?us-ascii?Q?QSSsAC8Pxjzj40T5X0AmwafF3E9k8eRIlcVjWsZF4fEs+H25FEZyrk+7n6/t?=
 =?us-ascii?Q?OE2giTtzBfPKnb8PVpxM0L89ipO3Bv2JrGCWscN8uL8SPW8WhP1bSKZx/TA/?=
 =?us-ascii?Q?hpbmkahZmsEzObpuKxP7SIawTaRjOKXZqsHBUWFmvgrnwylCDDjAuc1oOXTX?=
 =?us-ascii?Q?EfPYTXQuSov1wvWf12/Essmoq7XRYbbAnvnkFKCButWXpOrPpux7j3EEpVn6?=
 =?us-ascii?Q?BetVfR+VLeNqVrWo/52u0fKPITwVj6HVRuXhK5yaTwMxEI3H5d6ywgp1l7GU?=
 =?us-ascii?Q?8P4l4toru72Kbsmb0xPbAgQPzDsS3Pe/90GkjmSevJFl827M8JZdNeY3qD7O?=
 =?us-ascii?Q?5SAvMfnrRHZxsCpktBk9M84licWucihIjfOV4wy/8ZdZi5rBt1YoCviQfd+A?=
 =?us-ascii?Q?Lm93zTSuX3Th/xHlJBavmLyyP+Dh0If757h6CXHkx9MAOr9hgVzskx7hyyIh?=
 =?us-ascii?Q?B3vfZM4T6m+xG1JHMror6rHEK/p7JKYkVPjxBxJiQmtvY3Lj2iOTM2jBae0z?=
 =?us-ascii?Q?tP2YQDuC+jGlMLlTqej8ln7oWKuoixamxfH6+60qPhGB5qEOEh2FjvscT0yH?=
 =?us-ascii?Q?OyBejROt9nJ6iudz1AXzg9uGv4cWoSV3BkV0jIkXEZzed+qmbNM1RleRmeuO?=
 =?us-ascii?Q?MMSE3eFWWJmhbytd0rh5zmpL48lSjkXmflBMEn4sMptZ4if59aVw7I1ofuEP?=
 =?us-ascii?Q?kwEw/IC0VTXRwQo5J9RKL1Wh2MOZYvM38M9A76KlhOBH5qgCMFjC/0D7reU+?=
 =?us-ascii?Q?ZXcE1M0uXVhtnRxoh8VD2SiEj5CA0g23QN6NJMaHAktU1FmIO5gDYRz5OtxQ?=
 =?us-ascii?Q?J+sSubIvBM2RsMC/zDgKdzHq6B6zPkbdNCsnXrNGA2RJNsJVonXrasnkNwuW?=
 =?us-ascii?Q?SbFnNMt1ucdEYLpo7fBzNmIYgr86HqcI2t1+c3oYC9k4UVQXbiJ6ifDZwGbF?=
 =?us-ascii?Q?+wPdzzNxtBYT5qskACdA4Dfqc2+0obrhyUnix+SLwz7XNZW2bBsxOTl2fjGS?=
 =?us-ascii?Q?WDqv1aTyLdNprPp+zjxDMSlVHNZa/jx6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+e0uPTLyQP4peRKQYREWrIoaSlEsRVuFkS/5P+2/zBIEhsjuOPZguU/2hub8?=
 =?us-ascii?Q?L/aDkfl4EAalo7FsuAk5ItuHQQjIWmS/gDCpv5g4iFG2fe/guG/LpMpVRiGw?=
 =?us-ascii?Q?3BYGt7KAlKnrnDckf6U2sAEnoIeWkobhBXvwUPy52TiwmHbKhSUSrsF5x4Iy?=
 =?us-ascii?Q?5UnHeU97OItpIiSkLrHuJ0HsldX7mSbr1Vgvc0iK0nARcchEZsIXywMBVatV?=
 =?us-ascii?Q?2AZmYX5B14bJWX1pwpprZyDkjaEs0POh0puEg8oRi2DUP8K2OMwMxKrCYWJc?=
 =?us-ascii?Q?a4SrIE0+HImORCWn2siTL9VW3HrzyU+cyNAmPKWqyXwL3+DnSbcaRSFW0YdU?=
 =?us-ascii?Q?wkNVQLRhxq+WlXio6ByXewsj5uqGvV0dlA5AV4yRExZRbXOs9/CkqgXy/IVO?=
 =?us-ascii?Q?hEFJ6sRrVucUbiu1Ufh9hFg3IOPhln3pVR/wBGGgS/7FwDt3mJS9ewxBge6M?=
 =?us-ascii?Q?z1o6a+gQAZ0Nw/mIW/yBF1FmeDhY0DgN2r4p295LOUPMvFdLZtVr6qTzH0ao?=
 =?us-ascii?Q?PhDC7NOSHPkK54KQNNPMX54YNXf0Zhk60fW7adYmkM2lYowJmIh7srrI2VtY?=
 =?us-ascii?Q?KxogYjLxZhsZbcOYzp3/HTjTnbCcY3139fHuam9+Tsb3+u7ShunkPR/fkn8d?=
 =?us-ascii?Q?fCac2oNCoSl+7Erw1kYTDC/T0vwOEoQHeHtszlQ1Pq+3vBctOMz2bNkkyx03?=
 =?us-ascii?Q?qjuLpiGhaxiJQqioPRNQH7GX0m5b9TAZw/Iv9/ADU72hK1KeGa4q6Gu9/eOd?=
 =?us-ascii?Q?F9wd+9626iaozXRVCSyVWe8Ef/zaal84VqZ3SBp0xwED8qwwAs55tzVXrNve?=
 =?us-ascii?Q?kPmdMeIhYXdxcJ+8qsDfD7AF8ae43XTy344UVwhIPg0aI6YsKPEgV+EWK2I/?=
 =?us-ascii?Q?PZhv+dvNTxbhlV/wwvITur7So6vuKingSV8Sj+DPfePNNRPdYtY6zMcHtVZn?=
 =?us-ascii?Q?u8tr2ei5FmFlHoCccakGAyF4rCEvBKRfkd99Mwvn4lpdi4eXjzXePB0vBT0F?=
 =?us-ascii?Q?UF06u07PXBPIS8+wByuQJHfl1a9j4/FM66xkSrMMKWjgBnwiotd8aBkM9nc3?=
 =?us-ascii?Q?kBBF13BvqsiYUezouUfJEnC9RQ6MuOBR8wvNmS3pq94SPY7836+hUK8IcV1v?=
 =?us-ascii?Q?xNFVw3kf+PmDdNWvw8r3lyJlikiCVvFnOyIm+plGugRCmbaSc+lSkPsPipq7?=
 =?us-ascii?Q?ObOfomgVXK7/AU7QMkY9UzMk/K2agDry50s/M/j+qGXiSt2i0Y/S/RUPlK/V?=
 =?us-ascii?Q?g8PfbGmLVE9vdAN37CcIFGBZmIbbfHkDa7OJOI44AJ6pQ12P8v9RdercFrXX?=
 =?us-ascii?Q?ZKLhd+oH9NAMpq8JsWj1lx1Eb7OqqrIS5lFcnGRgvzlG/D4mMbbVgU2ZTt1z?=
 =?us-ascii?Q?h1Cxh0fwPArqJgUHmROGAkwTny5vhzp1QtjsKB9LDrSjoGDEuT3szReC39+I?=
 =?us-ascii?Q?Cm02XMHW70YToosxxLoszJLp87BddWVOcDPcw7K8rvuo26Xn8wHAppjSk+3X?=
 =?us-ascii?Q?ueY2X3yjUyxGKhdyBiwnQCU9/xvcOMrzvpsmFxK6dlbULjSKqXeArqnPD+L2?=
 =?us-ascii?Q?ua0s+t6Ci1pjBfz6avKIkFjPwUqR3BTybmgt74/MOVLW0ibIX4swpEfpJc8J?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0c1553-b6b6-4856-91a2-08de07e566f5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 10:11:39.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh2fYX9oR8SVVYmQsy+lDA7mn0M4Kqyy4wjUekzJjKkyCs+YunviB01iZxlohq17rIZIe6lbGFaBqGEWKdqrA/sB5byIEfxxWB0H9vcAQkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5217

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                        |  2 ++
 arch/riscv/include/asm/evl/calibration.h  | 12 +++++++++++
 arch/riscv/include/asm/evl/fptest.h       | 24 ++++++++++++++++++++++
 arch/riscv/include/asm/evl/syscall.h      | 25 +++++++++++++++++++++++
 arch/riscv/include/asm/evl/thread.h       | 12 +++++++++++
 arch/riscv/include/dovetail/irq.h         | 11 ++++++++++
 arch/riscv/include/dovetail/mm_info.h     |  7 +++++++
 arch/riscv/include/dovetail/netdevice.h   |  7 +++++++
 arch/riscv/include/dovetail/poll.h        |  7 +++++++
 arch/riscv/include/dovetail/thread_info.h |  7 +++++++
 arch/riscv/include/uapi/asm/evl/fptest.h  | 17 +++++++++++++++
 11 files changed, 131 insertions(+)
 create mode 100644 arch/riscv/include/asm/evl/calibration.h
 create mode 100644 arch/riscv/include/asm/evl/fptest.h
 create mode 100644 arch/riscv/include/asm/evl/syscall.h
 create mode 100644 arch/riscv/include/asm/evl/thread.h
 create mode 100644 arch/riscv/include/dovetail/irq.h
 create mode 100644 arch/riscv/include/dovetail/mm_info.h
 create mode 100644 arch/riscv/include/dovetail/netdevice.h
 create mode 100644 arch/riscv/include/dovetail/poll.h
 create mode 100644 arch/riscv/include/dovetail/thread_info.h
 create mode 100644 arch/riscv/include/uapi/asm/evl/fptest.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 11c1f93e6f9d..48468abae599 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -137,6 +137,7 @@ config RISCV
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_IRQ_PIPELINE
 	select HAVE_DOVETAIL
+	select HAVE_ARCH_EVL
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
@@ -373,6 +374,7 @@ config AS_HAS_OPTION_ARCH
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
index 000000000000..0a4f8e55ff51
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
\ No newline at end of file
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
index 000000000000..13087687d61a
--- /dev/null
+++ b/arch/riscv/include/dovetail/mm_info.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_MM_INFO_H
+#define _EVL_DOVETAIL_MM_INFO_H
+
+#include <asm-generic/evl/mm_info.h>
+
+#endif /* !_EVL_DOVETAIL_MM_INFO_H */
diff --git a/arch/riscv/include/dovetail/netdevice.h b/arch/riscv/include/dovetail/netdevice.h
new file mode 100644
index 000000000000..bc7ac6769530
--- /dev/null
+++ b/arch/riscv/include/dovetail/netdevice.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_NETDEVICE_H
+#define _EVL_DOVETAIL_NETDEVICE_H
+
+#include <asm-generic/evl/netdevice.h>
+
+#endif /* !_EVL_DOVETAIL_NETDEVICE_H */
diff --git a/arch/riscv/include/dovetail/poll.h b/arch/riscv/include/dovetail/poll.h
new file mode 100644
index 000000000000..76e51be38a40
--- /dev/null
+++ b/arch/riscv/include/dovetail/poll.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_POLL_H
+#define _EVL_DOVETAIL_POLL_H
+
+#include <asm-generic/evl/poll.h>
+
+#endif /* !_EVL_DOVETAIL_POLL_H */
diff --git a/arch/riscv/include/dovetail/thread_info.h b/arch/riscv/include/dovetail/thread_info.h
new file mode 100644
index 000000000000..4253b13fe47f
--- /dev/null
+++ b/arch/riscv/include/dovetail/thread_info.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_THREAD_INFO_H
+#define _EVL_DOVETAIL_THREAD_INFO_H
+
+#include <asm-generic/evl/thread_info.h>
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

