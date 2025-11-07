Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D53101B8
	for <xenomai@lists.linux.dev>; Fri,  7 Nov 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502444; cv=fail; b=Ir5T0w8igxr9xhuAmyLcJiQU1Zi70xKY4M6VNhX8kQaMeXVZdKg5XmEFLeolCLsKCSuiMvKLqNE5RScyZ6Jv3e9cQQ0KACD+IsmKo4laodjiy+huLeyRMhfFQGNFo7NYOXDNAc+uAI7j5dzfe7K1kHU64/i7lH2ylZoWhgExpgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502444; c=relaxed/simple;
	bh=/RDvo2DVmrOLgT0adBMuVBFNtTK4/NItjgql+SA35FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B85A38ABQVxiSkxOnQNgEuQpysu3LsIk6Vd9CvNXYjDRuN3EwlSb/ZTPpzxlXM9tsANWko1OTtsDcb14gIrJEhI9NBl9YjhBXNuvvb0jaGdoZf1gxQ3xFd3418TXQcs27HeAVu+mTAdvC2tWpnHdKhttQ86kkz+gkn5IJ/SOumg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ej2ZX30W; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ej2ZX30W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQSWyPCKvWWbbTCLNBdSSIMqbBAMG132z9zVZzJJ4OxVMlqp6gzxW/OKlfFMZuX6hWkLbe/1+WopeY2U5tQJg+QxVDhxxyalUtR/t0O7y1audxwAT6LrHfKoWyjSPfNdSWt1Mx41WU7s97balqrmLdqU6ELwrpglEl7zZPOLzubGO64YFDx1Q0fNcmWylMjAeV51hQTRk4rF6vVVg4vkzh6+QrUv/14Oo0lHpCoan5JgJdUhNap2eElOwq8KaFPNVJBZACp0VOpngVMeaog2yXoHiK3DlwqyZnGy+xYRVaZ9/tLOD+94cFHgKClnPWCLw49pZF6CNJWuLTdbCU9xQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mILkNEkeKRwlCgAkCyb631REUAqeOF61wa0BeYg9SmQ=;
 b=DVJZRakADnYZZjj7CM1WZSHjRu+56lOOf0g4ZdhLMqdk74+WAN5HVgcXHCwy1uC4HgndiaFeN9APYPvisJZS/A6Y/5bn1IHWjrJuE7q5siL1n22XwXEkHo9Z86UKt+VSEdYlOXVeSNAIKBQNFA7h0/cii2ZiIVMrUbHdfviQFNy+dj0F8jrTziuFRfSnJKf2KFnm4+nOxcem91dr2ycfyXX5YvhtRT9fG5hPkOcx7BQWGwLz2bnrYDbI6p8V08Wy4nkBKS6hU7CqfLLShUemaZLg455eJyVpBXvXoGGbFJW31Y7Rf+7F+90S0sPBiSkULKU+ek8Oa5gqi+X7rtFpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mILkNEkeKRwlCgAkCyb631REUAqeOF61wa0BeYg9SmQ=;
 b=ej2ZX30WO8VNwytw+978lX/cFJc+K/SfO+IhHmhZ+QnQ2SWYKkZG0WvcfbEeL90BPI5MnhkZv3FB5TL7sL78oe8F3sIHlgYc/DBtEt6W+FWq31uJCnkVRuD0AonFjf5SgjIrz6q8FKlQx+84TxStvVl3EgwELnxQBcwDimBP1PyopdNgpZBhsOjWEnG8Pyb+yACqXUrih6Tqm4FuTAwVUCVcpZfKf/7KkZaAS2FY2+hM3sAZxA4rdpX6dBpqoU1Y11dJyc9Cxt59wgPi2lg4KzGYYbQ7omY55wMmRfZkWzIfn9Zde7NsGne3B9tfr+lko0TWvBPVmPfUzG4GG4/G8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 08:00:36 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 08:00:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 2/2] linux-xenomai: Consolidate debug-configurations
Date: Fri,  7 Nov 2025 09:00:05 +0100
Message-ID: <20251107080005.1272435-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080005.1272435-1-tobias.schaffner@siemens.com>
References: <20251107080005.1272435-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:610:74::21) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: b0460b90-69d4-400d-9355-08de1dd3ba1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x9xjT/vPgiaywXSM9TzeZFTDVA7lIwpQWjcm2XINfJ+XZSPsQf/Gd1FFzIre?=
 =?us-ascii?Q?qrLfgJVcxF9RbPW2leqmMG/5NQno4MuYWXFsR7mWC0/sg82DB2QhlCXKGUGC?=
 =?us-ascii?Q?U/rGYj1gi40oJhk74Fax+lVAFYBEl3JTa6DWSJhQe5zak2cIWMqYFh6fpgNs?=
 =?us-ascii?Q?yV0iPrlf6qHveiPUMI4ycypEeYkPr64vSbEzc7byJQL2M/97kyDWzpLFWLJQ?=
 =?us-ascii?Q?zeHtIWGcvXvJownLuwVJ7+x3GGZlGEPeOJ6uE/8/3QIRwDfgbWKib/dRV/ZT?=
 =?us-ascii?Q?esMqGYnhiC9G+eEsrN6/bZ4G681twicbL15JmnmvPss//4LsY3LxHnC99vht?=
 =?us-ascii?Q?ef09WklE5I1jiTBZDv7RvUyyxLRdsm37HjDk9af/ArR929ZVcHAtFEq0cOyY?=
 =?us-ascii?Q?xlb631rt1cN/LcrDuP8S37MOykuv9kW75t1tf2rUjRYxiHk6nfNnhEV9ekd6?=
 =?us-ascii?Q?U3uNS7OOjOoE2yPOjVThN/1OuGHiM7ket+jbq3msH4fxSWovR7n4l59JziS2?=
 =?us-ascii?Q?WJL8pRTlERxj18VLd452u3zsdBgBKO3RuVYxf4BEJIu50a6Gdo+jpgj05cP6?=
 =?us-ascii?Q?odY/pPvSRZj2WuSKtUH42SLYL9jTXwgaLefHQBOx6dDKyHVqUITDv9I4V/Vx?=
 =?us-ascii?Q?qBZ8aRdqBhW/mPKm2zg9rh2KXihd055DEkvgg9H6apX0TI+6Hp+rQkWgsqGJ?=
 =?us-ascii?Q?zv3BKsQ5hhyIAJNW6Wgnhj6KJFC3XuI/mFuTjZWAcXP+7yjJAj+npf/ElWFD?=
 =?us-ascii?Q?Ji6zEpYgPr+cHzrcVqZpjSdgOegN8n1eGtNk05bls8t+rS0U4CDIJqzatUh9?=
 =?us-ascii?Q?6WoJsR7JFYnVAjvFOehJ0Q+32Cn0sexywpVrlcQPW6GvonT56gUoc7/v5qQm?=
 =?us-ascii?Q?kqgGR5KylaQObi1Yh5ptIYuBuPO8ffLqA4Qq/mAPnA1PMRcaarIdj6xbuMMR?=
 =?us-ascii?Q?OaPU6h9OCQh5LdmYQvBnCgbvBeRbfQlRw/3TRYVF6eGBVeGiAuBQZTWa3XS2?=
 =?us-ascii?Q?znQQhUP9u4C/Q1kUfOPtFyilFH3NYMwrA6GboW5g9czkh4J8BTexYkScxVkR?=
 =?us-ascii?Q?612tVx/oJ+hgCxgZ4HTbWC97h4YVsAGf1N+J+kBoGSfA5+3SL9iFKuh+7Wgu?=
 =?us-ascii?Q?i/lYbXUK+0kfqKEi0xEw4esI+SU/Cpb9BCJ9sUGk7OIq+mXk0TuzsJRynP8u?=
 =?us-ascii?Q?6gVyLBZYLOT9w/oLGosUq/tQ8R12OPecnYTPesAmbYFNJPt1ECQbDhUZys6g?=
 =?us-ascii?Q?WzprLAXhoZPVlaKOyZXw7QuAXFu9bHrn9dNiszwwgcOB39wZu5yS62gA7J0P?=
 =?us-ascii?Q?xvCOL+4YQZtdvgYE9NDhLoQKwjHPgg9Pb3d2y18+jFt0WX6UjIiwRvJH0LMa?=
 =?us-ascii?Q?mC90Ogc+L3hxLU4DOeAMRmMXZoLnh8xExmEdn99A30bMXNRnLGtmUl5iIeL3?=
 =?us-ascii?Q?Il0TQ9E7kXjbdCrK6ZcWzFQ5KFzfM6+X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TR5DjCbyaqtz/697dTUWiDF4QYzViMpN0Jz6Gf4jft76SvvGDiW/zhnTQ0X9?=
 =?us-ascii?Q?tSS4lwoZU9BQrtbUWG73UEMGrQAjsy345FZihVMOMr/4gdhipvIli8MyeOLj?=
 =?us-ascii?Q?xDBiSh2MFKWa1J6qo/3e2IA1b/PcbTDeC1QTEN1xtbX8mb1HEfyOao0QOQhD?=
 =?us-ascii?Q?maH3ZvuKeDdoSQqlaR/R+2MJS+QIvf4oHDiTa238QKk6NVvq5u1AlByBw7Rh?=
 =?us-ascii?Q?peutyshjzf5wjkCmJz1bxjff8ux/+N9a9+UF3hN7bwMjotD8HUgOu60LVKHA?=
 =?us-ascii?Q?BDE5tQkqgrCVFeJMZBvi9tBoZFy/kwUZ1GoFIcS06St6oOj8WvE9o+FM3ZZg?=
 =?us-ascii?Q?7nqN7WtvImZ+KYVT2Qxxvf9rSWhlbeYGSHaLE9Sch6Es3YadlsF5FhLrXoDd?=
 =?us-ascii?Q?wGOfx6mFTj8rpTyFtB+GMUkxjbebojBIOSlMQp7O32OiJ9fkU1mtjkimqZVa?=
 =?us-ascii?Q?OIApIHMz0ouf/cIXEna0rzHan6c0HOsWkxvYNJaMKmOd3H5yfFUf3VhMfwTK?=
 =?us-ascii?Q?7EufUB9QT1lfLYylfGHet2/nvO0ch/lLckvW+zOLkRJgte+kqSZqsnrhzqkY?=
 =?us-ascii?Q?zpCtnMAMEZwptAqedz5hyO0oWfkyYu/g2+MEYylc3OQ09GW39n5ZOY7LCwat?=
 =?us-ascii?Q?ZdSRbghz/dle/3yOT4PcADIyl9LNM6KxBZzQT48v6ao4kqeVQ4vwYABNG63U?=
 =?us-ascii?Q?K7XSJUhsVKh0PHKxr1LKkuuuhi6L9Qy6cSIQhETFEegQz4YyMGGTuYsMJETA?=
 =?us-ascii?Q?UMw5Jxr2vEVRwf1vXO+DaLnDaJHD6QmL/H3vh/5hRJY2CezbsfdDNA1/CTGA?=
 =?us-ascii?Q?liKgqBMHJYC28XNMeDF7FsGLtDeurmjSaSdXPNsm49RDxS9iR8bn7B6Cfwor?=
 =?us-ascii?Q?pWknXfX64GLmHy0yj4lNILoj4P0aSMB20wXlErtpIdNbxlPW7+WX7XVJ4fWK?=
 =?us-ascii?Q?IIl2NmFriyclRmo6ZaA6U3oajE+gT2WZ5rPObFwBbDvaa524kXQfnvT07stN?=
 =?us-ascii?Q?Wx4sE9comG8NAIPQZ57LzB5L6YTweEyHc0wonXQOaau3G7d8dAWCswJLX11w?=
 =?us-ascii?Q?NdRII5uk392z/SuWZFhWRbzUjQ0T40VyraiavIIsNodF3+3AWOmHEJc9F/L6?=
 =?us-ascii?Q?tttcTYFa0sHDFxYO+WUirw2TGthMizIIA/9PqLGuNEUFBJYMtlI0ga9FQzdI?=
 =?us-ascii?Q?KmTR3HFb6w8IyvZFqrrfnh7mkVEQGTpXmvx4voc5yFUM4ItOi0ECZeiwCQzz?=
 =?us-ascii?Q?Dx8cN0wHYE05fKbezKPhN7ImEdqgF/0OvpvC8fM0qpR1WeMm05bhXAYi8KwA?=
 =?us-ascii?Q?EtbahUgCBGPvV5J7wYPzjcSYbunOJutzbW1+t5fKB9Bf7ToO7WcpS2c7Xir3?=
 =?us-ascii?Q?Y9CxFcnl8MRbZpFkRveVMdk5SuNeKktCyLQqf64mtwuXffNuYlfsGg7jzIMD?=
 =?us-ascii?Q?JhjBovH3Oc+hMfXdvMwWrar2WNfTeo2dE9JgexwMBLa2C0U7qeHLwbCmDt7Y?=
 =?us-ascii?Q?paZloY64U2UhcUJAPTD5KrscKHc6nkN6RLbqqr7F3n/rP3/1Nz0p10VTLnPt?=
 =?us-ascii?Q?qBFf/nVcB8K8VAHS35g4PrSWNW/HLJpLGPeJgHnRL6OL5qC++qgjSxTu10bP?=
 =?us-ascii?Q?zxognTP5VsadKICPkfEDIOY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0460b90-69d4-400d-9355-08de1dd3ba1c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 08:00:34.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7QXNfPW+SQds0CmitVxZo2JijYjwnzfpMG+352MlWZsKu2jBvjjRnTYsqyZIZ3cpJd1r4nLt2Me4VIAX91voRqNQi+VuFhiaDZC6JyEzgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6675

Remove the per-architecture debug configuration snippets that were
previously introduced to collect common kernel debugging features.

All enabled debugging options have been merged into a unified
configuration, eliminating duplication across architectures.

This results in more debugging features enabled for the individual
archtectures.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-kernel/linux/files/arm64_debug.cfg    | 404 ---------------
 recipes-kernel/linux/files/armhf_debug.cfg    | 438 ----------------
 .../{amd64_debug.cfg => common_debug.cfg}     | 474 ++++++++++++------
 recipes-kernel/linux/linux-xenomai.inc        |   3 +-
 4 files changed, 323 insertions(+), 996 deletions(-)
 delete mode 100644 recipes-kernel/linux/files/arm64_debug.cfg
 delete mode 100644 recipes-kernel/linux/files/armhf_debug.cfg
 rename recipes-kernel/linux/files/{amd64_debug.cfg => common_debug.cfg} (70%)

diff --git a/recipes-kernel/linux/files/arm64_debug.cfg b/recipes-kernel/linux/files/arm64_debug.cfg
deleted file mode 100644
index df45c04..0000000
--- a/recipes-kernel/linux/files/arm64_debug.cfg
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
diff --git a/recipes-kernel/linux/files/armhf_debug.cfg b/recipes-kernel/linux/files/armhf_debug.cfg
deleted file mode 100644
index 68f525d..0000000
--- a/recipes-kernel/linux/files/armhf_debug.cfg
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
diff --git a/recipes-kernel/linux/files/amd64_debug.cfg b/recipes-kernel/linux/files/common_debug.cfg
similarity index 70%
rename from recipes-kernel/linux/files/amd64_debug.cfg
rename to recipes-kernel/linux/files/common_debug.cfg
index a07ec9d..16b5f78 100644
--- a/recipes-kernel/linux/files/amd64_debug.cfg
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
index d93eb1b..f90de9b 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -16,10 +16,9 @@ FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
 
 XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
 KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
-KERNEL_DEBUGCONFIG = "${DISTRO_ARCH}_debug.cfg"
 XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
-SRC_URI += "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
+SRC_URI += "${@'file://common_debug.cfg' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
 
 S = "${WORKDIR}/git"
-- 
2.43.0

