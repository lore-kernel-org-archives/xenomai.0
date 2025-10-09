Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD22DCC06
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008367; cv=fail; b=rHUcj6AT81HtKSV2Jvd22OnLB6XvRuNHXOezq7eeV4OfpUZ8MUjjmsgMrxVhrk+yqCqW/bCW9lfMQ7y4qyTZSEvkWndCa5klQNzyS8UmEcxpzZdxsVfDpFs0sLjNRt1Oi2icYi8fFgzylnO439zXvWgdfVOIRN604bv9uTdENXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008367; c=relaxed/simple;
	bh=v40uJFsUt0lMc0Wqb9JTo5Of/xvmRTRqwmU1DsQnLM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIWBTWgYHq/N2trrbcnAdk/bi6Ntr5CJeo71eixcBxktq07NfmTUiu5tUb6PjdmTz5hvOxp1Ns9sv8lBKfNWpNkbCqHsyM3hYw/PlH8faimConVcx9r/9XIaYa2SJ+Kg0i3Cya8uGJRKYRGjGLv/sbfKiWTu5qNY79DsWDVActE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vFtReUzX; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vFtReUzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmW5dXJWD15BOTgs1hDXZzYfpoxHS94XCBwcBd+VGFyfKUNtMrZ4nHYxfGw2jb6XDE8J3XlIemSFWbzirlh6yjt864MPJYmB32w0RMUzsLLqsB5DxWg6uU+x2iLhrlkJCpu1xe/XokhU6ArKdTk9yz0lYFf4i2koDzGGgAoyXTUmHSI3zFT6LUzhLDOFy0MIv+NIYgFp/N17Ub1Ng6JdkoN4JmnjNjFeg99XGHKBCkLrdntAniBXdRFOvaBwP+FWHoQQbBb503d/DhZa53DDccz45kBnOIVlcJPoIdjZ45/79xLZt+y2TeTdvhsa/HJNGI+OzLy+vrc3ThM8PS+AoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5wVfJkCnDtHeNYtFlOIZZCiDwfGg+DzrJhUoSKq9V8=;
 b=uGa0rqHokh0qulACT2OBWjVjiAtIt3zBgPKzVM3vgKAY3EL+RALb2w/+4ewzqvAmM22Q8p9gAm95APZOm2IAcpQMZpPr06Rx6G676Zs1lrciZdf60WUSoniDZ/Dn8hZc+V0YXJqX6yiHbG+hB3z6ZXpPZ8hlYwgXfPXzqrZCgmcPwhpXwwo12QQjC4UaxoIURH7v0fI0YTcxBpjODEMeGJx60iMsJKuKVKA2ftgQoiu4BukLD/MYMtmnpQ3pLCpmvBfRNSmQWxqd7E9ptJlbpoaAr25VPVDHpdUkFIQXq+aom7lYHzuPqc89HMrOC05MqRm7EMg1D2NLA89K60xPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5wVfJkCnDtHeNYtFlOIZZCiDwfGg+DzrJhUoSKq9V8=;
 b=vFtReUzXXn9vC8ablPWDYPju1Kd6yoqANuOPqzZ19Y9xtCR9TUaUNUsos+MbR1HNAOB+TdwpZ7ImfoSNSIS3WzVF/i3AmY4pUIcc8kkIUBTMSLUduGDoEKWNAnHdRMnCqkH33u55j5YmfnT446q5T+vq4VZgzMXnRPfNLh4/nIvob2rH1w4J//a5lYoPLXHpPd36TPf9OCbnDjwHk1PUnAFpiUPBsbSJvXNjeb5x2AFXzkPhb3bPr3BJYXhK42ZYl+nO3/LoWWA6+uD9MINSqIrJqgBEAqIY5HIAu8lERspZaHda8RqD3TbPEDIuyWVqGtAgiBl3pfc4MenQF0UfEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by BESPR10MB9267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 11:12:38 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 11:12:37 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 2/2] linux-xenomai: Consolidate debug-configurations
Date: Thu,  9 Oct 2025 13:12:28 +0200
Message-ID: <20251009111228.3504354-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
References: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|BESPR10MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e90199d-bc87-4f2c-7561-08de0724c141
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8qpTjM3ztiGU+3TRnOsaamw7KL37gXnrJFwqvM8X57RJdX52qJMVEx7R4RMs?=
 =?us-ascii?Q?pA6uSx9mFI7IDYR6n+qE1EeBtY2vaRt+qQf7QkMOVTNi2Aj9IKWDrLTe++s5?=
 =?us-ascii?Q?NF1bKBRhxaTG36L7r3Ra9LCqIZct4CFYLtzgGF32D9UaqnpeOpJDaGeaoJeQ?=
 =?us-ascii?Q?Y1Xs91O+GHygxPqDfbQvVnPw7R14IV0RoQ3FbNTGi9ro0Y/bQ/5u8O3VMzc3?=
 =?us-ascii?Q?W8x6wu5ekpcJHjp/DHLmX3VUba3NRYEWthSTGRzD8t239Se3eB338DWWKi4y?=
 =?us-ascii?Q?2LjKL3HkkFH/4sUHVnUOc6ULrzEPqM04Vi5GQPTwYFdOceGTrw9SYki0ptMb?=
 =?us-ascii?Q?XxjWsk418iMgMqF8tAbihzEslXgMz0c2wa8EDLgjw8NOMeLCrOWlksgQKzjM?=
 =?us-ascii?Q?f5R9uf2/5JF5bD/bcYYuES+hhg348ZcdSji8SbVn9JxBArtZokgR0fhNC2xc?=
 =?us-ascii?Q?uOYwAjqzBqxu5jQ/9jR5gXMfvLols8QPI83iwLM78MnElLByKlvd4s9aRO9m?=
 =?us-ascii?Q?BhHVGXJeWXyIrewX6el6rxe37X4CEHBPDTlLv6O3W5C8+qjVxZ6fdVwxTf5j?=
 =?us-ascii?Q?oLca+/mTboJmbV9Qgmd7MlvuEIWxmwTRRvuxpixbHDXaOXRLQpj/v1Z94n/u?=
 =?us-ascii?Q?OOIp3YP5UCCTZKBSY43h+Bds/vMUawzHBfdgxzhsd3nb8zUfVG3YPyI3FNgL?=
 =?us-ascii?Q?b9C6IF3wXbZ/L0RxbYgSpfEp4nfugHUfw9DNKMHLqs0e85Ndj2C1gsIz4x53?=
 =?us-ascii?Q?x4eihlVaPiikC3jzoY61B+z2fYCRc+BVblYvwx1zA3wrzOghPPS60jyZ7TOg?=
 =?us-ascii?Q?VrVYmWefnfJkbchRq1pxMvDB/ewPvT6zRjEOvHgk03t9idsvH3k6iI/a0avd?=
 =?us-ascii?Q?WSM+Hils0D69IAcMOLHt265LCpqZehQ38tWxilq7dAE2DsKYtiQR1rJG6fsp?=
 =?us-ascii?Q?/EFm0KOsOucooePIFDlGD47CLPIAvwRtBMB4Iu9KCJv5jmBiPNbxxONOKJjI?=
 =?us-ascii?Q?0W9tw3bzzIulNtct2qBnN2U/qDr0VGpNs31zedYXwnc76cF2T4DZvuRyY0we?=
 =?us-ascii?Q?T8FdvtQaRLpW45HhQS1jLlZDyBacsE5RDXhybs8+2G23IZw6r3HTyeTUcnoD?=
 =?us-ascii?Q?qmKsM/B/k8YKPRgTyr5VqEgJuyWsOHwg3xwUh/e8RrEdHOiEQGh10d4B0ENT?=
 =?us-ascii?Q?TmcgdWTNzvuRZg3Akli39q4NXPp/bKbRVqGPAjSgPjd9D5rCJuTHi240Bh/J?=
 =?us-ascii?Q?pRIltG42gTiuB2XXyIzRsRiAC7tIqW4/yxdeXine43mwu1gcUhWGNPpJYcJQ?=
 =?us-ascii?Q?kSEYtl9PpMD5bHVoXT8eJ22eSjRs6DkObwUZXg92GY4GdSPTGmW221EOUpv7?=
 =?us-ascii?Q?IvIa17uIZP3tMX7l6wOlHogl6tf0V5ISXHMZK5AS+knNPCL5AO+EJMJ4lUCX?=
 =?us-ascii?Q?6ON4/x6GRTBDcWmLHocSFcXy8oclryat?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bdkSHkCdwlEfzd8OxhpHaYaRK6/kuGqPQvvNnBGFwVdLmE9lfiuV7jb/DTK8?=
 =?us-ascii?Q?0+ptHVe5muweqpjScmB1f/9EwAogKFvLL0ZFNZ/jeYd2snDjt8kughZHMvOC?=
 =?us-ascii?Q?O0x6FLMIA5ynl4GQLX+JKc/HZ8zB8K0A/N23Zb8+vHW3LF07ZUMwdU+q8SFt?=
 =?us-ascii?Q?B1k4QyTcoLVhhBEkkDPSYjZIZRPD0xwCf0UcrBw2RJFlrW1h/7aN/2Fr2Wue?=
 =?us-ascii?Q?mw0+vWVKvuVQPAa4tp9YGS/6Sh7fndZbe+pSvkzZ5VWjtpndM0/kSEHhsUyE?=
 =?us-ascii?Q?AtnRPMfJd7XLy4kV4vLAAEA0RIljiB8b9s6WegwmrtbAD3YHiiLf7HwtUUap?=
 =?us-ascii?Q?M+lcEgk61meDK3c3s56XCOu8EyTQ2W5BSDwuqcv6kDeyJWtfrmVvox5i+R14?=
 =?us-ascii?Q?lpJZ/DIo6OLh3F/HAKt/qVjHtoI9L29d+8J+h/VpST4f6yWughkqau8W8Hw5?=
 =?us-ascii?Q?0JbP9fArcwWUTA7Lvvx2j84OuH/OEZGbnb5qUQzsgWlQoIPZbbgdSR2rkTeD?=
 =?us-ascii?Q?W4yBjXRoz40d+iopH+yA03IE+BLxC1EEAkMxRoy5RQpyWJx3NWgkO7RV9WFC?=
 =?us-ascii?Q?nLzQ2dmMTaNCYq7FRcyxz8ddCfM3WXi41Epgd39lthxWRdAkKCGjlB3vNZEk?=
 =?us-ascii?Q?zPX/2ICz0tF4P0W5G2dm+yI9ldPnbXoQW1Iz7HD/R181/cJf1Iksv5i7vrAs?=
 =?us-ascii?Q?tbnwKMg4reabO04JRcsJmtZ2bvvnYzrs4MMBVy14gXfSU5moGGcBEq0wITuR?=
 =?us-ascii?Q?XUYYHgZtdyB/jI/2SJXHJGeNhDRG9CATSNi0fQqRlOvgKZHeVHkMgsK890IO?=
 =?us-ascii?Q?0LIYj9rUkkpHwktRdL+wAT3roF5C7ZayQDiSQTK82KxknFFsCZpHfhWzySiu?=
 =?us-ascii?Q?slQJ2uvhyLkiTiUb1dqJjcL61BHyeSRWjUeDJT0KhhfahytOvAWpctwmmDsU?=
 =?us-ascii?Q?+0HQW1jHV22CP4cL1Tep0U0LtBYfoY6Wg374Zov1k3BIU/kmjU7/8jbGjs6J?=
 =?us-ascii?Q?RT9gW7oZRA39gnUmpTGNYTC/yf7vxews/bxMDQBWIsyh2KY8brKmtdeefbFW?=
 =?us-ascii?Q?q+FfqrMCiV27/rFgdBETnh9SQxIKCvPSfbBwgiB0e2uwzR/7slqnvH3/dbXT?=
 =?us-ascii?Q?t5nbya7JaaoHcEj6NFeDmIHCY5IXblYk/NyUjg6Gsh+9waBZrsAl+okvIDwZ?=
 =?us-ascii?Q?DXEQI3yuKwolXe7SEDEoeIgCmoWAWkorUasWuxpX+RWxPoOQ2Ul9JfcwLV5p?=
 =?us-ascii?Q?+rHbakr7uCGfl64xl8JC6ACrR45PFHj4cHy/ppcEgcu5I+RqpCTnR2KOt6FL?=
 =?us-ascii?Q?DNvRriLzV7CQbgdKoNvrrkN6LwhgDCmLzzv1mgZlp+5dkvByzzlFrMmWsFJC?=
 =?us-ascii?Q?r45WcpJfgkRok0YmZCVAIIy5qKCilivQvFIexlrJfbP6PPIiN3MW+ayXbp7A?=
 =?us-ascii?Q?7rZRc5BIlvJ6yJjKIaqA7mF7teDB1bSSbc7dsHzCgtblh9nDVlpihlbR/NpZ?=
 =?us-ascii?Q?uFpYDDIlqaFTA2LB5zqn9xOCoY5Ea+XnDhkAgK9bun0Hvt8FMfrt/C9loJhm?=
 =?us-ascii?Q?0l5PAhcZ/LFwzIzc1TTUmc2Zur+3g7qWucmjUoQ5Nm6zsRX7YqQXvCY4McSt?=
 =?us-ascii?Q?tvEufyfdiH3UrwqucMUhelk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e90199d-bc87-4f2c-7561-08de0724c141
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 11:12:37.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW41udGLg6DbQ35p/cIHzdYBKLEPLbD1ohGgHZizBwJRHrz971CpdD+Jj6ZLOZeOtnvkRrS4NZtrY7eSYH2StviiVwwcuZHIZXizU8Efu8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9267

Remove the per-architecture debug configuration snippets that were
previously introduced to collect common kernel debugging features.

All enabled debugging options have been merged into a unified
configuration, eliminating duplication across architectures.

This results in more debugging features enabled for the individual
archtectures.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-kernel/linux/files/arm64_debugconfig  | 404 ---------------
 recipes-kernel/linux/files/armhf_debugconfig  | 438 ----------------
 .../{amd64_debugconfig => common_debug.cfg}   | 474 ++++++++++++------
 recipes-kernel/linux/linux-xenomai.inc        |   3 +-
 4 files changed, 323 insertions(+), 996 deletions(-)
 delete mode 100644 recipes-kernel/linux/files/arm64_debugconfig
 delete mode 100644 recipes-kernel/linux/files/armhf_debugconfig
 rename recipes-kernel/linux/files/{amd64_debugconfig => common_debug.cfg} (70%)

diff --git a/recipes-kernel/linux/files/arm64_debugconfig b/recipes-kernel/linux/files/arm64_debugconfig
deleted file mode 100644
index df45c04..0000000
--- a/recipes-kernel/linux/files/arm64_debugconfig
+++ /dev/null
@@ -1,404 +0,0 @@
-#
-# Debug Kernel Configuration
-#
-CONFIG_STACKTRACE_SUPPORT=y
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y
-CONFIG_ARCH_SUPPORTS_UPROBES=y
-
-#
-# IRQ subsystem
-#
-CONFIG_GENERIC_IRQ_PROBE=y
-# CONFIG_IRQ_DOMAIN_DEBUG is not set
-# CONFIG_GENERIC_IRQ_DEBUGFS is not set
-
-#
-# RCU Subsystem
-#
-# CONFIG_DEBUG_BLK_CGROUP is not set
-CONFIG_CGROUP_PERF=y
-# CONFIG_CGROUP_DEBUG is not set
-CONFIG_SYSCTL_EXCEPTION_TRACE=y
-CONFIG_KALLSYMS=y
-CONFIG_KALLSYMS_ALL=y
-# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
-CONFIG_KALLSYMS_BASE_RELATIVE=y
-CONFIG_HAVE_PERF_EVENTS=y
-
-#
-# Kernel Performance Events And Counters
-#
-CONFIG_PERF_EVENTS=y
-# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
-CONFIG_SLUB_DEBUG=y
-# CONFIG_KPROBES is not set
-# CONFIG_UPROBES is not set
-CONFIG_HAVE_KPROBES=y
-CONFIG_HAVE_KRETPROBES=y
-CONFIG_HAVE_ARCH_TRACEHOOK=y
-CONFIG_HAVE_DMA_API_DEBUG=y
-CONFIG_HAVE_PERF_REGS=y
-CONFIG_HAVE_PERF_USER_STACK_DUMP=y
-
-#
-# GCOV-based kernel profiling
-#
-CONFIG_BLK_DEBUG_FS=y
-
-#
-# Sizes and static limits
-#
-CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
-
-#
-# Latency settings
-#
-CONFIG_XENO_OPT_DEBUG=y
-CONFIG_XENO_OPT_DEBUG_COBALT=y
-CONFIG_XENO_OPT_DEBUG_MEMORY=y
-CONFIG_XENO_OPT_DEBUG_CONTEXT=y
-CONFIG_XENO_OPT_DEBUG_LOCKING=y
-CONFIG_XENO_OPT_DEBUG_USER=y
-CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
-CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
-CONFIG_XENO_OPT_DEBUG_LEGACY=y
-CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
-
-#
-# Testing drivers
-#
-CONFIG_XENO_DRIVERS_HEAPCHECK=y
-
-#
-# CAN drivers
-#
-CONFIG_XENO_DRIVERS_CAN_DEBUG=y
-
-#
-# Protocols
-#
-CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
-CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
-
-#
-#
-
-
-#
-# Bus support
-#
-# CONFIG_PCIEASPM_DEBUG is not set
-# CONFIG_PCI_DEBUG is not set
-
-#
-# ARM errata workarounds via the alternatives framework
-#
-CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
-CONFIG_HW_PERF_EVENTS=y
-# CONFIG_CMA_DEBUG is not set
-# CONFIG_CMA_DEBUGFS is not set
-
-#
-# ARMv8.2 architectural features
-#
-# CONFIG_RANDOMIZE_BASE is not set
-
-#
-# Power management options
-#
-# CONFIG_PM_DEBUG is not set
-
-#
-# CPU frequency scaling drivers
-#
-# CONFIG_ARM_BRCMSTB_AVS_CPUFREQ_DEBUG is not set
-
-#
-# Network testing
-#
-# CONFIG_BT_DEBUGFS is not set
-
-#
-# Bluetooth device drivers
-#
-# CONFIG_CFG80211_DEBUGFS is not set
-# CONFIG_CFG80211_INTERNAL_REGDB is not set
-# CONFIG_MAC80211_DEBUGFS is not set
-# CONFIG_MAC80211_MESSAGE_TRACING is not set
-# CONFIG_MAC80211_DEBUG_MENU is not set
-# CONFIG_NET_9P_DEBUG is not set
-
-#
-# Generic Driver Options
-#
-# CONFIG_DEBUG_DRIVER is not set
-# CONFIG_DEBUG_DEVRES is not set
-# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
-# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
-CONFIG_GENERIC_CPU_AUTOPROBE=y
-# CONFIG_DMA_FENCE_TRACE is not set
-
-#
-# RAM/ROM/Flash chip drivers
-#
-# CONFIG_MTD_JEDECPROBE is not set
-
-#
-# LPDDR & LPDDR2 PCM memory drivers
-#
-CONFIG_PNP_DEBUG_MESSAGES=y
-
-#
-# SCSI Transports
-#
-# CONFIG_SCSI_DEBUG is not set
-
-#
-# Distributed Switch Architecture drivers
-#
-# CONFIG_SKY2_DEBUG is not set
-
-#
-# MII PHY device drivers
-#
-# CONFIG_ATH_DEBUG is not set
-# CONFIG_BRCM_TRACING is not set
-
-#
-# Character devices
-#
-# CONFIG_TRACE_SINK is not set
-
-#
-# Other I2C/SMBus bus drivers
-#
-# CONFIG_I2C_DEBUG_CORE is not set
-# CONFIG_I2C_DEBUG_ALGO is not set
-# CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_SPI_DEBUG is not set
-
-#
-# SPI Protocol Masters
-#
-# CONFIG_PPS_DEBUG is not set
-
-#
-# Pin controllers
-#
-# CONFIG_DEBUG_PINCTRL is not set
-# CONFIG_DEBUG_GPIO is not set
-
-#
-# USB GPIO expanders
-#
-# CONFIG_POWER_SUPPLY_DEBUG is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Multifunction device drivers
-#
-# CONFIG_REGULATOR_DEBUG is not set
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_ADV_DEBUG is not set
-
-#
-# Graphics support
-#
-# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
-
-#
-# ACP (Audio CoProcessor) Configuration
-#
-CONFIG_NOUVEAU_DEBUG=5
-CONFIG_NOUVEAU_DEBUG_DEFAULT=3
-
-#
-# Sub-drivers
-#
-# CONFIG_DRM_TEGRA_DEBUG is not set
-
-#
-# Console display driver support
-#
-# CONFIG_SND_DEBUG is not set
-
-#
-# also be needed; see USB_STORAGE Help for more info
-#
-# CONFIG_USB_STORAGE_DEBUG is not set
-
-#
-# Gadget/Dual-role mode requires USB Gadget support to be enabled
-#
-# CONFIG_USB_DWC2_DEBUG is not set
-
-#
-# USB Physical Layer drivers
-#
-# CONFIG_USB_GADGET_DEBUG is not set
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-# CONFIG_USB_GADGET_DEBUG_FS is not set
-
-#
-# MMC/SD/SDIO Host Controller Drivers
-#
-# CONFIG_MMC_DEBUG is not set
-
-#
-# iptables trigger is under Netfilter config (LED target)
-#
-# CONFIG_EDAC_DEBUG is not set
-# CONFIG_RTC_DEBUG is not set
-
-#
-# HID Sensor RTC drivers
-#
-# CONFIG_DMADEVICES_DEBUG is not set
-
-#
-# Clock Source drivers
-#
-CONFIG_TIMER_PROBE=y
-
-#
-# Tegra firmware driver
-#
-# CONFIG_ACPI_DEBUGGER is not set
-# CONFIG_ACPI_EC_DEBUGFS is not set
-# CONFIG_ACPI_DEBUG is not set
-# CONFIG_ACPI_APEI_ERST_DEBUG is not set
-
-#
-# File systems
-#
-# CONFIG_EXT4_DEBUG is not set
-# CONFIG_JBD2_DEBUG is not set
-# CONFIG_BTRFS_DEBUG is not set
-# CONFIG_QUOTA_DEBUG is not set
-
-#
-# Pseudo filesystems
-#
-# CONFIG_SUNRPC_DEBUG is not set
-
-#
-# printk and dmesg options
-#
-# CONFIG_DYNAMIC_DEBUG is not set
-
-#
-# Compile-time checks and compiler options
-#
-CONFIG_DEBUG_INFO=y
-# CONFIG_DEBUG_INFO_REDUCED is not set
-# CONFIG_DEBUG_INFO_SPLIT is not set
-# CONFIG_DEBUG_INFO_DWARF4 is not set
-# CONFIG_GDB_SCRIPTS is not set
-CONFIG_DEBUG_FS=y
-# CONFIG_DEBUG_SECTION_MISMATCH is not set
-CONFIG_ARCH_WANT_FRAME_POINTERS=y
-CONFIG_FRAME_POINTER=y
-# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
-CONFIG_MAGIC_SYSRQ_SERIAL=y
-CONFIG_IPIPE_DEBUG=y
-CONFIG_IPIPE_DEBUG_CONTEXT=y
-CONFIG_IPIPE_DEBUG_INTERNAL=y
-CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
-# CONFIG_IPIPE_TRACE is not set
-CONFIG_DEBUG_KERNEL=y
-
-#
-# Memory Debugging
-#
-# CONFIG_PAGE_EXTENSION is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
-# CONFIG_DEBUG_RODATA_TEST is not set
-# CONFIG_DEBUG_OBJECTS is not set
-# CONFIG_SLUB_DEBUG_ON is not set
-CONFIG_HAVE_DEBUG_KMEMLEAK=y
-# CONFIG_DEBUG_KMEMLEAK is not set
-# CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_VM is not set
-CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
-# CONFIG_DEBUG_VIRTUAL is not set
-CONFIG_DEBUG_MEMORY_INIT=y
-# CONFIG_DEBUG_PER_CPU_MAPS is not set
-CONFIG_HAVE_ARCH_KASAN=y
-# CONFIG_KASAN is not set
-CONFIG_ARCH_HAS_KCOV=y
-# CONFIG_KCOV is not set
-# CONFIG_DEBUG_SHIRQ is not set
-
-#
-# Debug Lockups and Hangs
-#
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_SCHED_INFO=y
-# CONFIG_DEBUG_TIMEKEEPING is not set
-# CONFIG_DEBUG_PREEMPT is not set
-
-#
-# Lock Debugging (spinlocks, mutexes, etc...)
-#
-# CONFIG_DEBUG_RT_MUTEXES is not set
-# CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
-# CONFIG_DEBUG_LOCK_ALLOC is not set
-# CONFIG_PROVE_LOCKING is not set
-# CONFIG_DEBUG_ATOMIC_SLEEP is not set
-# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
-# CONFIG_STACKTRACE is not set
-# CONFIG_DEBUG_KOBJECT is not set
-CONFIG_HAVE_DEBUG_BUGVERBOSE=y
-CONFIG_DEBUG_BUGVERBOSE=y
-# CONFIG_DEBUG_LIST is not set
-# CONFIG_DEBUG_PI_LIST is not set
-# CONFIG_DEBUG_SG is not set
-# CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_DEBUG_CREDENTIALS is not set
-
-#
-# RCU Debugging
-#
-# CONFIG_PROVE_RCU is not set
-# CONFIG_RCU_PERF_TEST is not set
-# CONFIG_RCU_TRACE is not set
-# CONFIG_RCU_EQS_DEBUG is not set
-# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
-# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
-CONFIG_HAVE_FUNCTION_TRACER=y
-CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
-CONFIG_HAVE_DYNAMIC_FTRACE=y
-CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
-CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
-CONFIG_TRACING_SUPPORT=y
-CONFIG_EVENT_TRACING=y
-CONFIG_CONTEXT_SWITCH_TRACER=y
-CONFIG_TRACING=y
-CONFIG_FTRACE=y
-# CONFIG_DMA_API_DEBUG is not set
-
-#
-# Runtime Testing
-#
-# CONFIG_BACKTRACE_SELF_TEST is not set
-CONFIG_HAVE_ARCH_KGDB=y
-# CONFIG_KGDB is not set
-CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
-# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
-# CONFIG_UBSAN is not set
-# CONFIG_ARM64_PTDUMP_DEBUGFS is not set
-# CONFIG_DEBUG_WX is not set
-# CONFIG_DEBUG_ALIGN_RODATA is not set
-# CONFIG_DEBUG_EFI is not set
-
-#
-# Library routines
-#
diff --git a/recipes-kernel/linux/files/armhf_debugconfig b/recipes-kernel/linux/files/armhf_debugconfig
deleted file mode 100644
index 68f525d..0000000
--- a/recipes-kernel/linux/files/armhf_debugconfig
+++ /dev/null
@@ -1,438 +0,0 @@
-#
-# Debug Kernel Configuration
-#
-CONFIG_STACKTRACE_SUPPORT=y
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y
-CONFIG_ARCH_SUPPORTS_UPROBES=y
-
-#
-# IRQ subsystem
-#
-CONFIG_GENERIC_IRQ_PROBE=y
-CONFIG_IRQ_DOMAIN_DEBUG=y
-# CONFIG_GENERIC_IRQ_DEBUGFS is not set
-
-#
-# RCU Subsystem
-#
-# CONFIG_CGROUP_PERF is not set
-# CONFIG_CGROUP_DEBUG is not set
-CONFIG_KALLSYMS=y
-# CONFIG_KALLSYMS_ALL is not set
-# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
-CONFIG_KALLSYMS_BASE_RELATIVE=y
-CONFIG_HAVE_PERF_EVENTS=y
-CONFIG_PERF_USE_VMALLOC=y
-
-#
-# Kernel Performance Events And Counters
-#
-CONFIG_PERF_EVENTS=y
-# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
-CONFIG_SLUB_DEBUG=y
-CONFIG_TRACEPOINTS=y
-# CONFIG_KPROBES is not set
-CONFIG_UPROBES=y
-CONFIG_HAVE_KPROBES=y
-CONFIG_HAVE_KRETPROBES=y
-CONFIG_HAVE_OPTPROBES=y
-CONFIG_HAVE_ARCH_TRACEHOOK=y
-CONFIG_HAVE_DMA_API_DEBUG=y
-CONFIG_HAVE_PERF_REGS=y
-CONFIG_HAVE_PERF_USER_STACK_DUMP=y
-
-#
-# GCOV-based kernel profiling
-#
-CONFIG_BLK_DEBUG_FS=y
-
-#
-# Sizes and static limits
-#
-CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
-
-#
-# Latency settings
-#
-CONFIG_XENO_OPT_DEBUG=y
-CONFIG_XENO_OPT_DEBUG_COBALT=y
-CONFIG_XENO_OPT_DEBUG_MEMORY=y
-CONFIG_XENO_OPT_DEBUG_CONTEXT=y
-CONFIG_XENO_OPT_DEBUG_LOCKING=y
-CONFIG_XENO_OPT_DEBUG_USER=y
-CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
-CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
-CONFIG_XENO_OPT_DEBUG_LEGACY=y
-CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
-
-#
-# Testing drivers
-#
-CONFIG_XENO_DRIVERS_HEAPCHECK=y
-
-#
-# CAN drivers
-#
-CONFIG_XENO_DRIVERS_CAN_DEBUG=y
-
-#
-# Protocols
-#
-# CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG is not set
-# CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG is not set
-
-#
-# ANALOGY drivers
-#
-# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is not set
-
-#
-# Real-time GPIO drivers
-#
-# CONFIG_XENO_DRIVERS_GPIO_DEBUG is not set
-
-#
-# Real-time SPI master drivers
-#
-# CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
-
-#
-# CSR SiRF atlas6/primaII/Atlas7 Specific Features
-#
-CONFIG_UX500_DEBUG_UART=2
-
-#
-# Processor Features
-#
-CONFIG_DEBUG_ALIGN_RODATA=y
-
-#
-# Bus support
-#
-# CONFIG_PCIEASPM_DEBUG is not set
-# CONFIG_PCI_DEBUG is not set
-
-#
-# RAW_PRINTK to work. Otherwise, you will get no output on raw_printk()
-#
-CONFIG_HW_PERF_EVENTS=y
-
-#
-# Power management options
-#
-# CONFIG_PM_DEBUG is not set
-
-#
-# CAN USB interfaces
-#
-# CONFIG_CAN_DEBUG_DEVICES is not set
-CONFIG_BT_DEBUGFS=y
-
-#
-# Bluetooth device drivers
-#
-# CONFIG_CFG80211_DEBUGFS is not set
-# CONFIG_CFG80211_INTERNAL_REGDB is not set
-# CONFIG_MAC80211_DEBUGFS is not set
-# CONFIG_MAC80211_MESSAGE_TRACING is not set
-# CONFIG_MAC80211_DEBUG_MENU is not set
-
-#
-# Generic Driver Options
-#
-# CONFIG_DEBUG_DRIVER is not set
-# CONFIG_DEBUG_DEVRES is not set
-# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
-# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
-CONFIG_GENERIC_CPU_AUTOPROBE=y
-# CONFIG_DMA_FENCE_TRACE is not set
-
-#
-# RAM/ROM/Flash chip drivers
-#
-# CONFIG_MTD_JEDECPROBE is not set
-
-#
-# SCSI Transports
-#
-# CONFIG_SCSI_DEBUG is not set
-
-#
-# MII PHY device drivers
-#
-# CONFIG_ATH_DEBUG is not set
-# CONFIG_BRCM_TRACING is not set
-# CONFIG_RT2X00_DEBUG is not set
-
-#
-# Character devices
-#
-# CONFIG_TRACE_SINK is not set
-
-#
-# Other I2C/SMBus bus drivers
-#
-# CONFIG_I2C_DEBUG_CORE is not set
-# CONFIG_I2C_DEBUG_ALGO is not set
-# CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_SPI_DEBUG is not set
-
-#
-# SPI Protocol Masters
-#
-# CONFIG_PPS_DEBUG is not set
-
-#
-# Pin controllers
-#
-# CONFIG_DEBUG_PINCTRL is not set
-# CONFIG_DEBUG_GPIO is not set
-
-#
-# USB GPIO expanders
-#
-# CONFIG_POWER_SUPPLY_DEBUG is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_BCM_KONA_WDT_DEBUG is not set
-
-#
-# Sonics Silicon Backplane
-#
-# CONFIG_BCMA_DEBUG is not set
-
-#
-# Multifunction device drivers
-#
-CONFIG_AB8500_DEBUG=y
-
-#
-# STMicroelectronics STMPE Interface Drivers
-#
-# CONFIG_REGULATOR_DEBUG is not set
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_ADV_DEBUG is not set
-
-#
-# Webcam, TV (analog/digital) USB devices
-#
-# CONFIG_VIDEO_STI_HVA_DEBUGFS is not set
-
-#
-# Graphics support
-#
-# CONFIG_DRM_DEBUG_MM is not set
-# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
-
-#
-# ACP (Audio CoProcessor) Configuration
-#
-CONFIG_NOUVEAU_DEBUG=5
-CONFIG_NOUVEAU_DEBUG_DEFAULT=3
-
-#
-# Sub-drivers
-#
-# CONFIG_DRM_TEGRA_DEBUG is not set
-
-#
-# Console display driver support
-#
-# CONFIG_SND_DEBUG is not set
-
-#
-# also be needed; see USB_STORAGE Help for more info
-#
-# CONFIG_USB_STORAGE_DEBUG is not set
-
-#
-# Gadget/Dual-role mode requires USB Gadget support to be enabled
-#
-# CONFIG_USB_DWC2_DEBUG is not set
-
-#
-# USB Physical Layer drivers
-#
-# CONFIG_USB_GADGET_DEBUG is not set
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-# CONFIG_USB_GADGET_DEBUG_FS is not set
-
-#
-# MMC/SD/SDIO Host Controller Drivers
-#
-# CONFIG_MMC_DEBUG is not set
-
-#
-# iptables trigger is under Netfilter config (LED target)
-#
-# CONFIG_EDAC_DEBUG is not set
-# CONFIG_RTC_DEBUG is not set
-
-#
-# HID Sensor RTC drivers
-#
-# CONFIG_DMADEVICES_DEBUG is not set
-
-#
-# Clock Source drivers
-#
-CONFIG_TIMER_PROBE=y
-
-#
-# Extcon Device Drivers
-#
-# CONFIG_OMAP_GPMC_DEBUG is not set
-
-#
-# File systems
-#
-# CONFIG_EXT4_DEBUG is not set
-# CONFIG_JBD2_DEBUG is not set
-
-#
-# DOS/FAT/NT Filesystems
-#
-# CONFIG_NTFS_DEBUG is not set
-
-#
-# Pseudo filesystems
-#
-# CONFIG_SUNRPC_DEBUG is not set
-
-#
-# printk and dmesg options
-#
-# CONFIG_DYNAMIC_DEBUG is not set
-
-#
-# Compile-time checks and compiler options
-#
-# CONFIG_DEBUG_INFO is not set
-CONFIG_DEBUG_FS=y
-# CONFIG_DEBUG_SECTION_MISMATCH is not set
-# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
-CONFIG_MAGIC_SYSRQ_SERIAL=y
-CONFIG_IPIPE_DEBUG=y
-CONFIG_IPIPE_DEBUG_CONTEXT=y
-CONFIG_IPIPE_DEBUG_INTERNAL=y
-CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
-# CONFIG_IPIPE_TRACE is not set
-CONFIG_DEBUG_KERNEL=y
-
-#
-# Memory Debugging
-#
-# CONFIG_PAGE_EXTENSION is not set
-# CONFIG_DEBUG_PAGEALLOC is not set
-# CONFIG_DEBUG_PAGE_REF is not set
-# CONFIG_DEBUG_RODATA_TEST is not set
-# CONFIG_DEBUG_OBJECTS is not set
-# CONFIG_SLUB_DEBUG_ON is not set
-CONFIG_HAVE_DEBUG_KMEMLEAK=y
-# CONFIG_DEBUG_KMEMLEAK is not set
-# CONFIG_DEBUG_STACK_USAGE is not set
-# CONFIG_DEBUG_VM is not set
-CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
-# CONFIG_DEBUG_VIRTUAL is not set
-# CONFIG_DEBUG_MEMORY_INIT is not set
-# CONFIG_DEBUG_PER_CPU_MAPS is not set
-# CONFIG_DEBUG_HIGHMEM is not set
-# CONFIG_DEBUG_SHIRQ is not set
-
-#
-# Debug Lockups and Hangs
-#
-CONFIG_SCHED_DEBUG=y
-# CONFIG_SCHED_INFO is not set
-# CONFIG_DEBUG_TIMEKEEPING is not set
-
-#
-# Lock Debugging (spinlocks, mutexes, etc...)
-#
-# CONFIG_DEBUG_RT_MUTEXES is not set
-# CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
-# CONFIG_DEBUG_LOCK_ALLOC is not set
-# CONFIG_PROVE_LOCKING is not set
-# CONFIG_DEBUG_ATOMIC_SLEEP is not set
-# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
-CONFIG_STACKTRACE=y
-# CONFIG_DEBUG_KOBJECT is not set
-CONFIG_DEBUG_BUGVERBOSE=y
-# CONFIG_DEBUG_LIST is not set
-# CONFIG_DEBUG_PI_LIST is not set
-# CONFIG_DEBUG_SG is not set
-# CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_DEBUG_CREDENTIALS is not set
-
-#
-# RCU Debugging
-#
-# CONFIG_PROVE_RCU is not set
-# CONFIG_RCU_PERF_TEST is not set
-CONFIG_RCU_TRACE=y
-# CONFIG_RCU_EQS_DEBUG is not set
-# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
-# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
-CONFIG_NOP_TRACER=y
-CONFIG_HAVE_FUNCTION_TRACER=y
-CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
-CONFIG_HAVE_DYNAMIC_FTRACE=y
-CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
-CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
-CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
-CONFIG_TRACE_CLOCK=y
-CONFIG_RING_BUFFER=y
-CONFIG_EVENT_TRACING=y
-CONFIG_CONTEXT_SWITCH_TRACER=y
-CONFIG_TRACING=y
-CONFIG_TRACING_SUPPORT=y
-CONFIG_FTRACE=y
-# CONFIG_FUNCTION_TRACER is not set
-# CONFIG_IRQSOFF_TRACER is not set
-# CONFIG_SCHED_TRACER is not set
-# CONFIG_HWLAT_TRACER is not set
-# CONFIG_ENABLE_DEFAULT_TRACERS is not set
-# CONFIG_FTRACE_SYSCALLS is not set
-# CONFIG_TRACER_SNAPSHOT is not set
-CONFIG_BRANCH_PROFILE_NONE=y
-# CONFIG_STACK_TRACER is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-CONFIG_UPROBE_EVENTS=y
-CONFIG_PROBE_EVENTS=y
-# CONFIG_TRACEPOINT_BENCHMARK is not set
-# CONFIG_RING_BUFFER_BENCHMARK is not set
-# CONFIG_RING_BUFFER_STARTUP_TEST is not set
-# CONFIG_TRACE_EVAL_MAP_FILE is not set
-CONFIG_TRACING_EVENTS_GPIO=y
-# CONFIG_DMA_API_DEBUG is not set
-
-#
-# Runtime Testing
-#
-# CONFIG_BACKTRACE_SELF_TEST is not set
-CONFIG_HAVE_ARCH_KGDB=y
-# CONFIG_KGDB is not set
-# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
-# CONFIG_UBSAN is not set
-CONFIG_ARM_UNWIND=y
-# CONFIG_DEBUG_USER is not set
-# CONFIG_DEBUG_LL is not set
-CONFIG_DEBUG_IMX_UART_PORT=1
-CONFIG_DEBUG_VF_UART_PORT=1
-CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
-# CONFIG_DEBUG_UART_8250 is not set
-
-#
-# Library routines
-#
diff --git a/recipes-kernel/linux/files/amd64_debugconfig b/recipes-kernel/linux/files/common_debug.cfg
similarity index 70%
rename from recipes-kernel/linux/files/amd64_debugconfig
rename to recipes-kernel/linux/files/common_debug.cfg
index a07ec9d..16b5f78 100644
--- a/recipes-kernel/linux/files/amd64_debugconfig
+++ b/recipes-kernel/linux/files/common_debug.cfg
@@ -1,51 +1,55 @@
+
 #
 # Debug Kernel Configuration
 #
-CONFIG_LOCKDEP_SUPPORT=y
-CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
 CONFIG_ARCH_SUPPORTS_UPROBES=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 
 #
 # IRQ subsystem
 #
-CONFIG_GENERIC_IRQ_PROBE=y
-# CONFIG_IRQ_DOMAIN_DEBUG is not set
 # CONFIG_GENERIC_IRQ_DEBUGFS is not set
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_IRQ_DOMAIN_DEBUG=y
 
 #
 # RCU Subsystem
 #
-# CONFIG_CGROUP_PERF is not set
 # CONFIG_CGROUP_DEBUG is not set
-CONFIG_SYSCTL_EXCEPTION_TRACE=y
+CONFIG_CGROUP_PERF=y
+# CONFIG_DEBUG_BLK_CGROUP is not set
+CONFIG_HAVE_PERF_EVENTS=y
 CONFIG_KALLSYMS=y
-CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
+CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_BASE_RELATIVE=y
-CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
+CONFIG_SYSCTL_EXCEPTION_TRACE=y
 
 #
 # Kernel Performance Events And Counters
 #
-CONFIG_PERF_EVENTS=y
 # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
-CONFIG_SLUB_DEBUG=y
-CONFIG_TRACEPOINTS=y
-CONFIG_KPROBES=y
-CONFIG_OPTPROBES=y
-CONFIG_UPROBES=y
-CONFIG_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
 CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KPROBES_ON_FTRACE=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_OPTPROBES=y
-CONFIG_HAVE_KPROBES_ON_FTRACE=y
-CONFIG_HAVE_ARCH_TRACEHOOK=y
-CONFIG_HAVE_DMA_API_DEBUG=y
 CONFIG_HAVE_PERF_EVENTS_NMI=y
-CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
 CONFIG_HAVE_PERF_REGS=y
 CONFIG_HAVE_PERF_USER_STACK_DUMP=y
+CONFIG_KPROBES=y
+CONFIG_KRETPROBES=y
+CONFIG_OPTPROBES=y
+CONFIG_PERF_EVENTS=y
+CONFIG_SLUB_DEBUG=y
+CONFIG_TRACEPOINTS=y
+CONFIG_UPROBES=y
 
 #
 # GCOV-based kernel profiling
@@ -60,22 +64,22 @@ CONFIG_BLK_DEBUG_FS=y
 #
 # Sizes and static limits
 #
-CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
+# CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ is not set
 
 #
 # Latency settings
 #
 CONFIG_XENO_OPT_DEBUG=y
 CONFIG_XENO_OPT_DEBUG_COBALT=y
-# CONFIG_XENO_OPT_DEBUG_MEMORY is not set
 CONFIG_XENO_OPT_DEBUG_CONTEXT=y
+CONFIG_XENO_OPT_DEBUG_LEGACY=y
 CONFIG_XENO_OPT_DEBUG_LOCKING=y
-CONFIG_XENO_OPT_DEBUG_USER=y
+CONFIG_XENO_OPT_DEBUG_MEMORY=y
 CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
 CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
 CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO=y
-CONFIG_XENO_OPT_DEBUG_LEGACY=y
 CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
+CONFIG_XENO_OPT_DEBUG_USER=y
 
 #
 # Testing drivers
@@ -90,16 +94,16 @@ CONFIG_XENO_DRIVERS_CAN_DEBUG=y
 #
 # Protocols
 #
-CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
 CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
+CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
 
 #
 # ANALOGY drivers
 #
 CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
 # CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE is not set
-CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=0
-CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=0
+# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL is not set
+# CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL is not set
 
 #
 # Real-time GPIO drivers
@@ -115,30 +119,30 @@ CONFIG_X86_DEBUGCTLMSR=y
 #
 # Performance monitoring
 #
-CONFIG_PERF_EVENTS_INTEL_UNCORE=y
-CONFIG_PERF_EVENTS_INTEL_RAPL=y
-CONFIG_PERF_EVENTS_INTEL_CSTATE=y
-# CONFIG_PERF_EVENTS_AMD_POWER is not set
 CONFIG_ARCH_MEMORY_PROBE=y
+# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
 CONFIG_MTRR_SANITIZER=y
-CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
-CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
+# CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT is not set
+# CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT is not set
+# CONFIG_PERF_EVENTS_AMD_POWER is not set
+CONFIG_PERF_EVENTS_INTEL_CSTATE=y
+CONFIG_PERF_EVENTS_INTEL_RAPL=y
+CONFIG_PERF_EVENTS_INTEL_UNCORE=y
 # CONFIG_RANDOMIZE_BASE is not set
-# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
 
 #
 # Power management and ACPI options
 #
-CONFIG_PM_DEBUG=y
+# CONFIG_ACPI_APEI_ERST_DEBUG is not set
+# CONFIG_ACPI_DEBUG is not set
+# CONFIG_ACPI_DEBUGGER is not set
+# CONFIG_ACPI_EC_DEBUGFS is not set
 # CONFIG_PM_ADVANCED_DEBUG is not set
-CONFIG_PM_TEST_SUSPEND=y
+CONFIG_PM_DEBUG=y
 CONFIG_PM_SLEEP_DEBUG=y
+CONFIG_PM_TEST_SUSPEND=y
 CONFIG_PM_TRACE=y
 CONFIG_PM_TRACE_RTC=y
-# CONFIG_ACPI_DEBUGGER is not set
-# CONFIG_ACPI_EC_DEBUGFS is not set
-# CONFIG_ACPI_DEBUG is not set
-# CONFIG_ACPI_APEI_ERST_DEBUG is not set
 
 #
 # Bus options (PCI etc.)
@@ -164,11 +168,12 @@ CONFIG_PM_TRACE_RTC=y
 #
 # Generic Driver Options
 #
-# CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
+# CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
-# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
+# CONFIG_DMA_FENCE_TRACE is not set
 CONFIG_GENERIC_CPU_AUTOPROBE=y
+# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
 
 #
 # Bus devices
@@ -194,10 +199,11 @@ CONFIG_PNP_DEBUG_MESSAGES=y
 #
 # Other I2C/SMBus bus drivers
 #
-# CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_PPS_DEBUG is not set
+# CONFIG_SPI_DEBUG is not set
 
 #
 # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
@@ -207,12 +213,13 @@ CONFIG_PNP_DEBUG_MESSAGES=y
 #
 # USB GPIO expanders
 #
-# CONFIG_POWER_SUPPLY_DEBUG is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_POWER_SUPPLY_DEBUG is not set
 
 #
 # Multifunction device drivers
 #
+CONFIG_AB8500_DEBUG=y
 # CONFIG_REGULATOR_DEBUG is not set
 
 #
@@ -230,6 +237,7 @@ CONFIG_DMADEVICES_DEBUG=y
 #
 # File systems
 #
+# CONFIG_BTRFS_DEBUG is not set
 # CONFIG_EXT4_DEBUG is not set
 # CONFIG_JBD2_DEBUG is not set
 # CONFIG_QUOTA_DEBUG is not set
@@ -243,11 +251,7 @@ CONFIG_DMADEVICES_DEBUG=y
 # Pseudo filesystems
 #
 # CONFIG_PSTORE_FTRACE is not set
-
-#
-# Kernel hacking
-#
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+# CONFIG_SUNRPC_DEBUG is not set
 
 #
 # printk and dmesg options
@@ -257,180 +261,346 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 #
 # Compile-time checks and compiler options
 #
+CONFIG_ARCH_WANT_FRAME_POINTERS=y
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_INFO_DWARF4 is not set
 # CONFIG_DEBUG_INFO_REDUCED is not set
 # CONFIG_DEBUG_INFO_SPLIT is not set
-# CONFIG_DEBUG_INFO_DWARF4 is not set
-CONFIG_GDB_SCRIPTS=y
-CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
-# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
-CONFIG_MAGIC_SYSRQ_SERIAL=y
+CONFIG_FRAME_POINTER=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
 CONFIG_IPIPE_DEBUG=y
 CONFIG_IPIPE_DEBUG_CONTEXT=y
 CONFIG_IPIPE_DEBUG_INTERNAL=y
-CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
 CONFIG_IPIPE_TRACE=y
 # CONFIG_IPIPE_TRACE_ENABLE is not set
-CONFIG_IPIPE_TRACE_MCOUNT=y
 CONFIG_IPIPE_TRACE_IRQSOFF=y
-CONFIG_IPIPE_TRACE_SHIFT=14
-# CONFIG_IPIPE_TRACE_VMALLOC is not set
+CONFIG_IPIPE_TRACE_MCOUNT=y
 CONFIG_IPIPE_TRACE_PANIC=y
-CONFIG_DEBUG_KERNEL=y
+# CONFIG_IPIPE_TRACE_SHIFT is not set
+# CONFIG_IPIPE_TRACE_VMALLOC is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE is not set
+CONFIG_MAGIC_SYSRQ_SERIAL=y
 
 #
 # Memory Debugging
 #
-CONFIG_PAGE_EXTENSION=y
+CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
+CONFIG_ARCH_HAS_KCOV=y
+# CONFIG_DEBUG_HIGHMEM is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
+CONFIG_DEBUG_MEMORY_INIT=y
+# CONFIG_DEBUG_OBJECTS is not set
 CONFIG_DEBUG_PAGEALLOC=y
 # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
 # CONFIG_DEBUG_PAGE_REF is not set
+# CONFIG_DEBUG_PER_CPU_MAPS is not set
 CONFIG_DEBUG_RODATA_TEST=y
-# CONFIG_DEBUG_OBJECTS is not set
-CONFIG_SLUB_DEBUG_ON=y
-CONFIG_HAVE_DEBUG_KMEMLEAK=y
-# CONFIG_DEBUG_KMEMLEAK is not set
+CONFIG_DEBUG_SHIRQ=y
+# CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
+CONFIG_DEBUG_VIRTUAL=y
 CONFIG_DEBUG_VM=y
-# CONFIG_DEBUG_VM_VMACACHE is not set
-# CONFIG_DEBUG_VM_RB is not set
 # CONFIG_DEBUG_VM_PGFLAGS is not set
 CONFIG_DEBUG_VM_PGTABLE=y
-CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
-CONFIG_DEBUG_VIRTUAL=y
-CONFIG_DEBUG_MEMORY_INIT=y
-# CONFIG_DEBUG_PER_CPU_MAPS is not set
-CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
-# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_VM_RB is not set
+# CONFIG_DEBUG_VM_VMACACHE is not set
 CONFIG_HAVE_ARCH_KASAN=y
+CONFIG_HAVE_DEBUG_KMEMLEAK=y
+CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
 # CONFIG_KASAN is not set
-CONFIG_ARCH_HAS_KCOV=y
 # CONFIG_KCOV is not set
-CONFIG_DEBUG_SHIRQ=y
+CONFIG_PAGE_EXTENSION=y
+CONFIG_SLUB_DEBUG_ON=y
 
 #
 # Debug Lockups and Hangs
 #
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_TIMEKEEPING is not set
 CONFIG_SCHED_DEBUG=y
 CONFIG_SCHED_INFO=y
-# CONFIG_DEBUG_TIMEKEEPING is not set
-CONFIG_DEBUG_PREEMPT=y
 
 #
 # Lock Debugging (spinlocks, mutexes, etc...)
 #
-CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
-CONFIG_LOCKDEP=y
-# CONFIG_DEBUG_LOCKDEP is not set
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
-CONFIG_TRACE_IRQFLAGS=y
-CONFIG_STACKTRACE=y
-# CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_LIST=y
+# CONFIG_DEBUG_LOCKDEP is not set
+CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_NOTIFIERS is not set
 CONFIG_DEBUG_PI_LIST=y
+CONFIG_DEBUG_RT_MUTEXES=y
 # CONFIG_DEBUG_SG is not set
-# CONFIG_DEBUG_NOTIFIERS is not set
-# CONFIG_DEBUG_CREDENTIALS is not set
+CONFIG_DEBUG_SPINLOCK=y
+# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
+CONFIG_HAVE_DEBUG_BUGVERBOSE=y
+CONFIG_LOCKDEP=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_STACKTRACE=y
+CONFIG_TRACE_IRQFLAGS=y
 
 #
 # RCU Debugging
 #
-# CONFIG_PROVE_RCU is not set
-# CONFIG_RCU_PERF_TEST is not set
-# CONFIG_RCU_TRACE is not set
-# CONFIG_RCU_EQS_DEBUG is not set
-# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+CONFIG_CONTEXT_SWITCH_TRACER=y
 # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
-CONFIG_USER_STACKTRACE_SUPPORT=y
-CONFIG_NOP_TRACER=y
-CONFIG_HAVE_FUNCTION_TRACER=y
-CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
+CONFIG_EVENT_TRACING=y
+CONFIG_FTRACE=y
+# CONFIG_FTRACE_STARTUP_TEST is not set
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_FUNCTION_GRAPH_TRACER=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_GENERIC_TRACER=y
 CONFIG_HAVE_DYNAMIC_FTRACE=y
 CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
 CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACER=y
 CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
-CONFIG_TRACER_MAX_TRACE=y
-CONFIG_TRACE_CLOCK=y
-CONFIG_RING_BUFFER=y
-CONFIG_EVENT_TRACING=y
-CONFIG_CONTEXT_SWITCH_TRACER=y
-CONFIG_RING_BUFFER_ALLOW_SWAP=y
-CONFIG_TRACING=y
-CONFIG_GENERIC_TRACER=y
-CONFIG_TRACING_SUPPORT=y
-CONFIG_FTRACE=y
-CONFIG_FUNCTION_TRACER=y
-CONFIG_FUNCTION_GRAPH_TRACER=y
-CONFIG_IRQSOFF_TRACER=y
-# CONFIG_PREEMPT_TRACER is not set
-CONFIG_SCHED_TRACER=y
 # CONFIG_HWLAT_TRACER is not set
-CONFIG_FTRACE_SYSCALLS=y
-CONFIG_TRACER_SNAPSHOT=y
-CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
-CONFIG_BRANCH_PROFILE_NONE=y
-# CONFIG_STACK_TRACER is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_IRQSOFF_TRACER=y
 CONFIG_KPROBE_EVENTS=y
-CONFIG_UPROBE_EVENTS=y
-CONFIG_PROBE_EVENTS=y
-# CONFIG_FTRACE_STARTUP_TEST is not set
 # CONFIG_MMIOTRACE is not set
-# CONFIG_TRACEPOINT_BENCHMARK is not set
+CONFIG_NOP_TRACER=y
+# CONFIG_PREEMPT_TRACER is not set
+CONFIG_PROBE_EVENTS=y
+# CONFIG_PROVE_RCU is not set
+# CONFIG_RCU_EQS_DEBUG is not set
+# CONFIG_RCU_PERF_TEST is not set
+CONFIG_RCU_TRACE=y
+CONFIG_RING_BUFFER=y
+CONFIG_RING_BUFFER_ALLOW_SWAP=y
 # CONFIG_RING_BUFFER_BENCHMARK is not set
 # CONFIG_RING_BUFFER_STARTUP_TEST is not set
+CONFIG_SCHED_TRACER=y
+# CONFIG_STACK_TRACER is not set
+# CONFIG_TRACEPOINT_BENCHMARK is not set
+CONFIG_TRACER_MAX_TRACE=y
+CONFIG_TRACER_SNAPSHOT=y
+CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
+CONFIG_TRACE_CLOCK=y
 # CONFIG_TRACE_EVAL_MAP_FILE is not set
+CONFIG_TRACING=y
 CONFIG_TRACING_EVENTS_GPIO=y
-# CONFIG_DMA_API_DEBUG is not set
+CONFIG_TRACING_SUPPORT=y
+CONFIG_UPROBE_EVENTS=y
+CONFIG_USER_STACKTRACE_SUPPORT=y
 
 #
 # Runtime Testing
 #
-# CONFIG_KPROBES_SANITY_TEST is not set
-# CONFIG_BACKTRACE_SELF_TEST is not set
-# CONFIG_TEST_DEBUG_VIRTUAL is not set
-CONFIG_HAVE_ARCH_KGDB=y
-CONFIG_KGDB=y
-CONFIG_KGDB_SERIAL_CONSOLE=y
-CONFIG_KGDB_TESTS=y
-# CONFIG_KGDB_TESTS_ON_BOOT is not set
-# CONFIG_KGDB_LOW_LEVEL_TRAP is not set
-# CONFIG_KGDB_KDB is not set
 CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
 # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
-# CONFIG_UBSAN is not set
-# CONFIG_DEBUG_WX is not set
+# CONFIG_ARM64_PTDUMP_DEBUGFS is not set
+CONFIG_ARM_UNWIND=y
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_CPA_DEBUG is not set
+# CONFIG_DEBUG_BOOT_PARAMS is not set
+# CONFIG_DEBUG_EFI is not set
+# CONFIG_DEBUG_ENTRY is not set
+# CONFIG_DEBUG_IMX_UART_PORT is not set
+# CONFIG_DEBUG_LL is not set
+# CONFIG_DEBUG_LL_INCLUDE is not set
+# CONFIG_DEBUG_NMI_SELFTEST is not set
 # CONFIG_DEBUG_TLBFLUSH is not set
-# CONFIG_IOMMU_DEBUG is not set
+# CONFIG_DEBUG_UART_8250 is not set
+# CONFIG_DEBUG_USER is not set
+# CONFIG_DEBUG_VF_UART_PORT is not set
+# CONFIG_DEBUG_WX is not set
+# CONFIG_DEFAULT_IO_DELAY_TYPE is not set
+CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_HAVE_MMIOTRACE_SUPPORT=y
-CONFIG_IO_DELAY_TYPE_0X80=0
-CONFIG_IO_DELAY_TYPE_0XED=1
-CONFIG_IO_DELAY_TYPE_UDELAY=2
-CONFIG_IO_DELAY_TYPE_NONE=3
+# CONFIG_IOMMU_DEBUG is not set
 CONFIG_IO_DELAY_0X80=y
 # CONFIG_IO_DELAY_0XED is not set
-# CONFIG_IO_DELAY_UDELAY is not set
 # CONFIG_IO_DELAY_NONE is not set
-CONFIG_DEFAULT_IO_DELAY_TYPE=0
-# CONFIG_DEBUG_BOOT_PARAMS is not set
-# CONFIG_CPA_DEBUG is not set
-# CONFIG_DEBUG_ENTRY is not set
-# CONFIG_DEBUG_NMI_SELFTEST is not set
-CONFIG_X86_DEBUG_FPU=y
+# CONFIG_IO_DELAY_TYPE_0X80 is not set
+# CONFIG_IO_DELAY_TYPE_0XED is not set
+# CONFIG_IO_DELAY_TYPE_NONE is not set
+# CONFIG_IO_DELAY_TYPE_UDELAY is not set
+# CONFIG_IO_DELAY_UDELAY is not set
+CONFIG_KGDB=y
+# CONFIG_KGDB_KDB is not set
+# CONFIG_KGDB_LOW_LEVEL_TRAP is not set
+CONFIG_KGDB_SERIAL_CONSOLE=y
+CONFIG_KGDB_TESTS=y
+# CONFIG_KGDB_TESTS_ON_BOOT is not set
+# CONFIG_KPROBES_SANITY_TEST is not set
 # CONFIG_PUNIT_ATOM_DEBUG is not set
-CONFIG_UNWINDER_ORC=y
+# CONFIG_TEST_DEBUG_VIRTUAL is not set
+# CONFIG_UBSAN is not set
 # CONFIG_UNWINDER_FRAME_POINTER is not set
+CONFIG_UNWINDER_ORC=y
+CONFIG_X86_DEBUG_FPU=y
+
+#
+# Real-time SPI master drivers
+#
+# CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
+
+#
+# CSR SiRF atlas6/primaII/Atlas7 Specific Features
+#
+# CONFIG_UX500_DEBUG_UART is not set
+
+#
+# Processor Features
+#
+CONFIG_DEBUG_ALIGN_RODATA=y
+
+#
+# RAW_PRINTK to work. Otherwise, you will get no output on raw_printk()
+#
+CONFIG_HW_PERF_EVENTS=y
+
+#
+# CAN USB interfaces
+#
+CONFIG_BT_DEBUGFS=y
+# CONFIG_CAN_DEBUG_DEVICES is not set
+
+#
+# Bluetooth device drivers
+#
+# CONFIG_CFG80211_DEBUGFS is not set
+# CONFIG_CFG80211_INTERNAL_REGDB is not set
+# CONFIG_MAC80211_DEBUGFS is not set
+# CONFIG_MAC80211_DEBUG_MENU is not set
+# CONFIG_MAC80211_MESSAGE_TRACING is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_JEDECPROBE is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# MII PHY device drivers
+#
+# CONFIG_ATH_DEBUG is not set
+# CONFIG_BRCM_TRACING is not set
+# CONFIG_RT2X00_DEBUG is not set
+
+#
+# Pin controllers
+#
+# CONFIG_DEBUG_PINCTRL is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_BCM_KONA_WDT_DEBUG is not set
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_BCMA_DEBUG is not set
+
+#
+# Multimedia core support
+#
+# CONFIG_VIDEO_ADV_DEBUG is not set
+
+#
+# Webcam, TV (analog/digital) USB devices
+#
+# CONFIG_VIDEO_STI_HVA_DEBUGFS is not set
+
+#
+# Graphics support
+#
+# CONFIG_DRM_DEBUG_MM is not set
+# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
+
+#
+# ACP (Audio CoProcessor) Configuration
+#
+# CONFIG_NOUVEAU_DEBUG is not set
+# CONFIG_NOUVEAU_DEBUG_DEFAULT is not set
+
+#
+# Sub-drivers
+#
+# CONFIG_DRM_TEGRA_DEBUG is not set
+
+#
+# Console display driver support
+#
+# CONFIG_SND_DEBUG is not set
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+# CONFIG_USB_STORAGE_DEBUG is not set
+
+#
+# Gadget/Dual-role mode requires USB Gadget support to be enabled
+#
+# CONFIG_USB_DWC2_DEBUG is not set
+
+#
+# USB Physical Layer drivers
+#
+# CONFIG_USB_GADGET_DEBUG is not set
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+# CONFIG_USB_GADGET_DEBUG_FS is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_DEBUG is not set
+
+#
+# Clock Source drivers
+#
+CONFIG_TIMER_PROBE=y
+
+#
+# Extcon Device Drivers
+#
+# CONFIG_OMAP_GPMC_DEBUG is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_NTFS_DEBUG is not set
+
+#
+# ARM errata workarounds via the alternatives framework
+#
+# CONFIG_CMA_DEBUG is not set
+# CONFIG_CMA_DEBUGFS is not set
+
+#
+# CPU frequency scaling drivers
+#
+# CONFIG_ARM_BRCMSTB_AVS_CPUFREQ_DEBUG is not set
+
+#
+# Distributed Switch Architecture drivers
+#
+# CONFIG_SKY2_DEBUG is not set
 
 #
-# Library routines
+# Tegra firmware driver
 #
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 501c212..f90de9b 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -16,10 +16,9 @@ FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
 
 XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
 KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
-KERNEL_DEBUGCONFIG = "${DISTRO_ARCH}_debugconfig"
 XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
-SRC_URI += "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
+SRC_URI += "${@'file://common_debug.cfg' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
 
 S = "${WORKDIR}/git"
-- 
2.43.0

