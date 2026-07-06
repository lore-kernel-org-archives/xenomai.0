Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9C3939C2
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362580; cv=fail; b=P98IIJr82WVs4zX4feHVhuwH5Zj5jEJwmVw4NnWcoF/EDw0E0kB+YMiPVFAs3N8bkPx0UXA58L/xaKLNoNb5+c9QacFcXgYOI/pQg5UjdrTd6/bzb3QHE6F5Zf4dAi3iokeddLu3erLnawFFOy9GLGpnyJ63+srdVPLrtsgP4jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362580; c=relaxed/simple;
	bh=rGZfNs5DpP35NhM+TVf27QTwLrQZflTA6BmtGDUTpJU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MV2BTXKNUS5awTw1g4z6RevTEo16I34z0PI3FHhW5XEXUOVGtZn1LmaDaczdbuIBSNyWlLmiEvWGvI3Sg6QsLbI8gN7ewIkjRaxKNHmX78WkPCfrEeX8Ubk/Xzw8R7JJnz/+IWFlk7gXGhVeBaHsjS9vA+FUAM/hKkxgFu7JF0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Rrtbz4LP; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Rrtbz4LP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l20+I53NHTQWoNpM/K01kDenc+x40LfroMcbZc3EsP9+4YxpDXyd4hyFd6d9THGN1BjVQp6GBEXZjZkvNKeXR+GrzxYFcom3yT4zx0wJdOGUo9HBBqc0hy++3CV0w5SnSvSGBypNCHGRSlhjQEHuf60K0K97trALzOxSVUAATAEJlqzhxR11KW3h5qtheMtIJgiG5ChJfOuWn2WDTfJhRo8wCSQqETbUP/yOHAK8whHs4fDXTfDjGEx1shQAxvDOtYHREr85tq0UDdzPFM9Zsc1J62ZVGXTcbjHpQV2wvVQz1O6Zc+aAhdFmHWMSvgyuD/xR2ZKLU+vj2zoJL79Q1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1mJI8Jt11bTyLMuH1beiS463eOBOdO0Y0JZ8eApWO4=;
 b=uYHhthm5yxTjcDAtt+aniqkbI0+O2bDRQIJBHlIaAUYICFS1ZD1ykAlLuSQPGBV9h1FZwvO/FCUuIVDeECmT+pKzoHVXJxDH6BjeNftygZ2KIYeQdPxxSdB0hj3Xh3botBfrLX/SvBRFJTmToq+Lb8+Vk9CJORRtQOIKX362nN0jO8RNZB6etlrBb6EEnzk7Hpami7AlgD4kg2XYN6xMnBojqJ7BsNb7K4FQlQ933yqxVOxjEbV5yC9DYUL1c8dET2S7rdDLPCpk36KKdrioJppR3zgPI/oqtvvQgf20qOurOtw6cT/vBVW3lN9oxsZNGB+YF1NmwIsUp6IsliDVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1mJI8Jt11bTyLMuH1beiS463eOBOdO0Y0JZ8eApWO4=;
 b=Rrtbz4LPaUq/SCdhlz2VF1sKZRiwZZ4HtUm35Ai1uixR+XgHFmVkebEvQ5MPUXNbHKxixVyVKRECjgGvpSkCbbk9kS7tmem8T8EQGPw5G/A+nBzbGVvDKiCzZzFF+991Tc47mYA+j5grJJD3NDXteTV04FWosAhXa9QfJvij+5pxjCjUnhXHjWY1+0jbEa6uqXjXDG5PtLRJ6k2FePjITxW2ZtZQrgOswITUw/0RNd67rdbBRQ7QJk3nQDiDxjfE6sarYfoR+09TqtYQ7+n4/r7USHjhUKAbrkDiVDVKb8CsgC64ChhYoBkBdRqUSmZh1VgVdM3/621AbMNjguYd8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:35 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 00/11] riscv: Add dovetail support
Date: Mon,  6 Jul 2026 20:29:16 +0200
Message-ID: <20260706182927.281078-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: c8e82b34-ce09-4dba-9207-08dedb8c877c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	L1yMtUubPHWY1gzU1sGZEtCa452o5v45AyChqzBQKdNBABl/PE+DGHD0AEmN7gTqhyWbh5x0JzAj+8hvBe4u3kjZKagcnltOWBQqYrqHx99j5AfUJofmSa520wr8XirXj5d8DEOwWSntDvdDvfgGlJj31x7ndtA4Z59kpWGL0o2RLHSeVc/OkqloE2K4Z+b4l1p4Um2mcv2FqTqka4r4N8jLnbsfq4t+tSiQuvSCUfdVzRJFZ6B+6iXW9mDBbXb/EbYCGLjeVIXYPTc/ys047KkURTlykJ4x9ncO8oZz3Y2idxVM3oKdHuxm+vPjs7sWuYVisuZ4920r2XwYAh8T5sdSKF8PtZsdKRf2cG+3GRodSziGI5HkbtFUYf5i6ZjAB085aZvwD7958n9tV+8Y2tBYfDGwiT1U2GZQS5OPXnDDr8M3bKypZNFoh7RoTFBgy7UQ6j19WTRhydK3ytBOVtv3HqPFHvovYmdi62sA/Tk3T2hxuE/P5Hy/3uCvTHnQXsN6qcd1NrCU38PXyrj0MINTUAhIfLL7N6uoxrPmref/W7Qj2ZzkBEoGLbd6+2ZpbJLSReuXm5E5/ZFRn5e4dDpA0Qfg75OTy9ecWB3pcbgpTu65NkGKlnfAQho+kFmZeTM20uB6pKNPU3xHCETY0lMyf6bbPCU4lND09zZn7hY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Snq5zkqe9ESyjc28RB7Of4isXv5C3it4sZ2v1854fPZUDQauqO/NUKghxnRS?=
 =?us-ascii?Q?Tj7+Fxkn3IOwGT6COK93KdiGB87uJ2G7gHkROcyFI4iRcBMMOqDLQfFT4ZfA?=
 =?us-ascii?Q?vXKgKmTELbyecSlUUrNy3R2RyK1N5u/+xSsjK/xLOTPWCvOSsTHLLMVXARL6?=
 =?us-ascii?Q?xrhy/fZHCwtUosSBTLlFdy/+/dg3B+K0Lib6u8o1mVjxI9fMR9cwNJWV0+XL?=
 =?us-ascii?Q?ZJ41uokh6Cz5hjzd8Emb5IuuampUljBwkTJif0Hnx/hnJsloNEUFbn7rYSq+?=
 =?us-ascii?Q?DMDFiGa4OAovSbmOjq2Zpjt0e/ea4LmFLXegwtdAjJzYuiTeVNNy/R+FG6Jd?=
 =?us-ascii?Q?OiEggLcfNHGesgRO3g8KZzH89wc5q7EVicJ7phndkPLXQ0o4CpcO0B464jGH?=
 =?us-ascii?Q?iSfHF2G+HLvtQGX0YBFVASRqi3wzO/bRzSPZKOlsl+DmiEHZ6WQLrKiBKMus?=
 =?us-ascii?Q?bJZ40NGTvMDY5ueM6VhnJUQagLecMwtl7ZZuhAQSCKwcOBlJSwBtYpxXjIn9?=
 =?us-ascii?Q?30GdhrXk3QhMaYYiV53jvUtdI78P0bt62+qILuRW77Ux6mKpq7smQRDCBHcy?=
 =?us-ascii?Q?s43HxIVnWGQZDhQDr7eiyWorQNhGDGImEQ7M5QyivNz3B/bGy68EGEySWaay?=
 =?us-ascii?Q?4fvgRiElFm9+LQiak+hva3F1yndCrfeo94Js8KM24vzJNfdXDBpwl0hI4gZV?=
 =?us-ascii?Q?45CIm3pd6zOusKHffmQgacpZMcfZksgigsNogdurDCjIu+S+KDwTIVk60x0U?=
 =?us-ascii?Q?GrPQ3ti/hpDaYQIv4CRbfs9OfAf5x40H/x8ouEKiFl7NgiyU3c9BHLrgGQnp?=
 =?us-ascii?Q?bL26ynUZd0BtbHRBqxUYPtvxdEQuMvRM61HleUr5fqClC5KLbtz3dIougmFk?=
 =?us-ascii?Q?sqDmy9cz2zm2PNpPlv9JHm1UFcfoqlgoq39qPTLYzT/1Ak7atNtypp5PckAr?=
 =?us-ascii?Q?192dnUEbePov9XmbDe9Z7rjeh1ocHtq7s8NnixwYRRpGsvj6KluTo8hmL/ac?=
 =?us-ascii?Q?upoxZKfqAGQ+vZavWbttJVPacDGbChgQ0URkXTAVR4KWa/Gqjt5ADA6J4FCG?=
 =?us-ascii?Q?N9HV1exZAiEMPZeXjE425tuCW1iWpEp7a/KZd0fNzyegjDahEe6ZV5qSa1gs?=
 =?us-ascii?Q?DDO4x/J/sP4RpgUmmUGgByuJCDrJ8xzPulEuHm1auuC0BDAPI1HqIhS9AGqh?=
 =?us-ascii?Q?tWVKjljshkgaB4Kd8Jv3cfJKCZmjnOdct0p54/SCDWyIIFB4YaKHytcnrmD1?=
 =?us-ascii?Q?ARd0U+h4jcDWfFeUM5VttxzvH2ySTEOzTWQVsUqdGDFK1FnEtiC0GhnLBkHp?=
 =?us-ascii?Q?jF3NtJttsjB1fvSx6BkcU6sOWaqLBTx1LNEJPP1tqbosWvJoV2g2Gqc5sMV8?=
 =?us-ascii?Q?70/Qaw/bJYWmWDW14NvPb7PrwSKr6JpOY3CI15SjBHlVJuutVAvsqDD30I5W?=
 =?us-ascii?Q?Dre1o/SABSFIRjr3H7r5L2skqBzYvGMwHNKT3SiBO7jUjXGU+VJYO1AQjpcO?=
 =?us-ascii?Q?D8N1ix27avT7EhqARKfapOAozdc389Y88JstBQe3JEm6PYvcPGYLvpVbBOrD?=
 =?us-ascii?Q?m/NtHE0myoXG2B3pswAzrK548FdgbmOL4y3iSvl//Tx2Y5dO1AYrwsM++KRh?=
 =?us-ascii?Q?YI6FfEGnbohlhzIiJi4jvZKw5ojrGoohmc6DplObpbTrwBZ2tyZHW4Wbwx14?=
 =?us-ascii?Q?mPkZQLsztoIrbOObDrNcwTnkWNIkiA6jsuMdmMSn1W6e4taDusJ6URTnH12C?=
 =?us-ascii?Q?UM+mdy5cg3r8xGrcS1jY6nQuYgaHxCX4TyThTCVEHTSQQkXHDjFoU6wQF6Yb?=
X-MS-Exchange-AntiSpam-MessageData-1: 1FM+6XEwRfwX+FTvHFgGSmONe0GnXEC3GcM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e82b34-ce09-4dba-9207-08dedb8c877c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:34.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iX8WoG8foRDyLyVcK0PwoWQeyQ0KldAohkGkP2bNiq/wRDzX8t6AwoW6brH3S3eMYTHEmKUg38qrWA2tpxL3vivamQJl6p2sDiCQydtGubo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

Hi all,

this series introduces initial support for Dovetail on RISC-V.

Feedback, suggestions, and especially reviews are very welcome.

Changes since v1:
 * Disable independent irq/softirq stack usage when pipelining
 * Drop KVM changes as long as they can not be properly tested

Changes since v2:
 * Rework trap handling

Changes since v3:
 * Included the IRQ pipelining patches to have all riscv specific
   patches included
 * Rebased to dovetail/v6.18.y-dovetail-rebase
 * Merged most of the fixes
 * Fixed IRQ Stack handling and enabled IRQ_STACKS again

Changes since v4:
 * Rebased to dovetail/v7.0.y-dovetail-rebase
 * Applied suggestions from the last patch set
 * Added starfive-visionfive2 board support
 * Introduced raw console device based on sbi debug console
 * Reworked pipelined irq handling

Changes since v5:
 * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
 * Applied suggestions from the last patch set
 * Use mark_trap_entry/exit_raw for kernel mode exception paths which
   use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
   irqs to stay off. This may be be subject to further optimization at
   a later stage, but I do not see any negative impact latency wise in
   my tests.

Changes since v6:
Address the review comments from the last patch set:
 * Keep the virtual irq state in sync with the hard irq state in trap
   handlers
 * Fix irq_nesting imbalance when running with disabled IRQ_STACKS

Changes since v7:
 * Simplify Trap handling
 * Rebase to wip/flo/v7.1-dovetail-rebase

Changes since v8:
 * Further simplify trap handling adressing Florians suggestions and
   recent fixes to irq-entry-common

Changes since v9:
 * Fix checkpatch finding in patch 11 "riscv: Add dovetail support"

Tobias Schaffner (11):
  riscv: introduce raw console device
  riscv: irq_pipeline: add IRQ pipelining core
  irqchip/riscv-aplic-direct: enable pipelined interrupt control
  irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
  irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
  irqchip/irq-riscv-intc: enable pipelined interrupt control
  irqchip/irq-sifive-plic: enable pipelined interrupt control
  clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
  pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
  PCI: plda: irq_pipeline: enable pipelined interrupt control
  riscv: dovetail: add core support

 arch/riscv/Kconfig                            |   3 +
 arch/riscv/include/asm/dovetail.h             |  24 +++
 arch/riscv/include/asm/entry-common.h         |   3 +-
 arch/riscv/include/asm/irq_pipeline.h         | 143 +++++++++++++
 arch/riscv/include/asm/irqflags.h             |  32 ++-
 arch/riscv/include/asm/mmu_context.h          |   2 +
 arch/riscv/include/asm/smp.h                  |  25 +++
 arch/riscv/include/asm/syscall.h              |   6 +
 arch/riscv/include/asm/thread_info.h          |  17 ++
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/irq_pipeline.c              |  26 +++
 arch/riscv/kernel/kernel_mode_vector.c        |   2 +-
 arch/riscv/kernel/raw_printk.c                |  33 +++
 arch/riscv/kernel/sbi-ipi.c                   |  12 +-
 arch/riscv/kernel/smp.c                       |  56 +++--
 arch/riscv/kernel/smpboot.c                   |   2 +-
 arch/riscv/kernel/traps.c                     | 199 +++++++++++++++---
 arch/riscv/mm/context.c                       |  20 +-
 arch/riscv/mm/fault.c                         |   8 +-
 drivers/clocksource/timer-riscv.c             |  11 +-
 drivers/irqchip/irq-riscv-aplic-direct.c      |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c         |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c    |   4 +-
 drivers/irqchip/irq-riscv-intc.c              |   2 +
 drivers/irqchip/irq-sifive-plic.c             |  10 +-
 drivers/pci/controller/plda/pcie-plda-host.c  |   2 +
 .../starfive/pinctrl-starfive-jh7110.c        |   2 +-
 .../starfive/pinctrl-starfive-jh7110.h        |   2 +-
 28 files changed, 577 insertions(+), 77 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c
 create mode 100644 arch/riscv/kernel/raw_printk.c

-- 
2.43.0

