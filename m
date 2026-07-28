Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B83AEF22
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237154; cv=fail; b=C6M+HZBEXTBefGR4hw4p9HL13GpwIRTyUZv4ry6iQiKGF4J0COZeHqfL+kStFoxqaCoUEdO2XtCphKhwPNLxZ7Dvo06Zh186S2NxnKQH6sSE5FH3FWAHlFV1K353EIHgYlpi93RCVzupIOPbJSsDTQhiLnA+UvkvJFbH3AUqg+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237154; c=relaxed/simple;
	bh=sr4sYtcZXpfriBeJsorhGvQr27uTNZB1vgn3ziRKCZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EGauVgTrX3p27DUI9QvknDKKPvsO6Axda7AcdOC2X0XujYoFgbWrrQmA60Rk/LOVthKu6Ddug4xfP6wt/vkDGy2Dx8MwyHKh18jgulQOvN429tLkmRUMCk/ZGXILD6V3mGHWWmxLOmDMdgv66bLtaMUGfO23Xl/P63Wc8hidzIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=brjqVrnk; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="brjqVrnk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9XEawM5WSiHzL+3PX6ZEIdJ1SKFsp17X/Ltgd9DesuuLt7tf+Rq1Fj29PV1KuQhhVH4itTIXVOgBYhlfg2UgxGsZRWMsXM703awAHj0xV1h3VO3j/cWH9Uc3IvtccuOZaL0jLZmOPw7sD8+K0mJXVvJezHJaKKnw8DASAO50iFyEhLITU0eYkNhv0HtGwo+d/JqUW51oqdIcbRoj/aDIQtm0/t9VxuHCdAq+i1oW2lkHNuCdvWv/DtOjWYCG11O/fS0vA0KG/hklCH/d/5vzW1zAZqANEnER2AZTrjwVuA4wCSm/ZhP9TF+Iq4z4iqEB4lWXCJC0o0Ga5jFk/QSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=carTqE96Mh1MdULGrvr+49qhkf0WZwou13r+u1lAgj8=;
 b=NrZSMePcxML22n3YRm9RdpxgwACiHzFfpo7McBpcAuW/Lu/iOWCrViML3ySTQ/jbeL0Y+xHdJ1QQ2N8IYANUZcbFAFO3tpC5RmMiQdJH1pMIRepP9owlydOnoKUjPFGB+QmumQbTh3mQiHnstcOsXlwqHpP1e0KeI/ae1M7ZKNT/ZGUFgH+FUso/e7Y0sGUaKtLhaenX5q2+b9uqwUhFPoYkMv8Tg7LiIxbsyRVU6zEHFk4Axx3xzzCgbjYTzgGCobPKk5Gl5QWGg/hPAnsVddacUhEFQc6ZCMNzLrhrwxW1RwDErk0398ngpU8pJo/AWgrZejukRjjA8bmLtsfQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=carTqE96Mh1MdULGrvr+49qhkf0WZwou13r+u1lAgj8=;
 b=brjqVrnkQKWwDJjrb+az28+hqXCyvHOys1LHOLm/rW/DSlO281Xdw8IRd+igNXEC79metIZiDLkZJ5DuAarJpqsChiVD0BzCm8Ie/maou6UKwRAWkDKcCMlHB6bjWSksfOeyBYx1HoAs0WYi0kumTMu++LlomCG5AWOdCL1Nhoxd39ksivJ6qadHzfLbiQJylcZvMsHG2PmYwCOekVSd6FQv382l5VE8Bkg7HlnxxsQDcL+5QfnAhLUY7ZKHQ89b2jzAjrheq/2DqgTLd6JZQNDqfrnyBSaaAHcEH3ofRJjgby1Q0TCtDDhsIh5J0A8yngyjayckwW1/85CK6sgOvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 11:12:29 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:29 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 00/11] riscv: Add dovetail support
Date: Tue, 28 Jul 2026 13:12:11 +0200
Message-ID: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bfd7a7-6738-4c98-4550-08deec991cdb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3CWVhnrwhrDul2nR+zA18GWNdoYYoNrMZEs/EzJWRIu1glo6OKfjP7O9wLPiW5GeWiOU9/z9sPRUfBgLYjcaun/Lrg8bPYlFLnnWUQbzCqxsR1cZroO9SSpk26EtqCLsIPT+5N9EtDHkPss4qmhsBRUxCZ2JJ6niY3kWJ+PeuNen6HZX2koO1CIgkGHMX0Q6SJDP76Gy2j46VOks9Xk1g03Q9KM32UyxnmtrKvdwqyERbTWmdJrFNET54Yb65RGLzOFfi4bt6LJ2Jsni1uJj7OJkP3WXDcsbuA/ZmiQJWqGH3UnlPjj4Qiapl9NHsSgI85GK8IQD1hdQbiQ2Bhi6T9hcYEbpomhLub02WMl8en1a3LHx+ezpGn2GwuCe1fnXEQFxG93zhC0R425e8rWZ0iUO0a9uRNdfQkDzHfpI1mkcyMrW14F+UPeerliBU4HMkR3K9nmjRzeO7MMmIgUPtqZliPXiatxP+Z+qSpAcoYoNE5OtMNT0kzTJKRQe1FbPe3q216CaQftp4d9C6l1d//HKdLLuTX0PzeIEVaMmkfCsZmXZvtB1QnsXkurmJzVNSXTJYEMrX5V+EZYPj0A7evnxpYdwBjTe7F/6kbotVkTHmRkJHJXj6G7gO2xmyVE/oBDJ9hULifW3clD2Ekd0L57TbpzjXXBOaHXnyVT4syA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+IEYepcQFydRQxHszlK//CmhXWIcYvZkvHNvW/NDd5ftv/baqzIzuuk2eJ+?=
 =?us-ascii?Q?MFPqz2ExLDnI7kt993XV20Zd+qGK2D0qgxrbKo2B8gSow3CXItkTHqKPbeRK?=
 =?us-ascii?Q?+woYtjjSikz63wOYOJ46I8EHV4Ek1X3263KHtDxc7X5jkhwYK9DSA1oP+J1J?=
 =?us-ascii?Q?ATsR1qKRsz4uLkZya/vtlUzPMGCyxi4/9CzXtHzSLTdg/XlVTx5jmqB6b1TL?=
 =?us-ascii?Q?Akpg7ED/x/cCeFWegKwEVKzEMCbABMqQTg4Dsu7htkgr6HQmoeeR3mDNKR7W?=
 =?us-ascii?Q?Y9edGfqAZPG9eY+iB7XrP74zPdfF25hFulsldbAyuVARILYr9YJGUAjaTMpf?=
 =?us-ascii?Q?9uNgu0NnmiuD2hYk0mcCb4ZkKt0LaREaVG5trKRgOWAZsM90cqgROMBJie70?=
 =?us-ascii?Q?l64NuydfjXQ97KjzGZWxPmdTtUdwb1KmdtC7uTvInOhiRlXVQYyab/VBHbMB?=
 =?us-ascii?Q?eKSEIZDLt5GWLRBDjyWDjpVrKrpyM9NmyITS1BnbyCG8ZK2ZaCI8xlqSS6mT?=
 =?us-ascii?Q?0mCABLGfqgfUQ4oAKT+eLAzsMXeMyg/xN/3Qbx4Cg8D/6w1Xj3N+ktG0w6Y2?=
 =?us-ascii?Q?gq5+sm0LtcXWcVNjqhcOcM7+wnZqV02rPyJtov/Hn9wwkVDst1bezdtrV2aK?=
 =?us-ascii?Q?iBu5aRTXB4qioQyOyG/RpoWQjPRB0J9RAxYoPRdpxFUjPRSmPWLhZIDowQ1D?=
 =?us-ascii?Q?BHMKzrsOFdG8HVoy2dW0FwI+koE/BgQ6ERuuHH1XPcD4FdDOOX9naxyNWRr4?=
 =?us-ascii?Q?7Q6NV5n9j4Jj6mvX5YqWK8B50y4gItEJ00LLXudaTrv7vIQUtezfaeySbrCw?=
 =?us-ascii?Q?n5Su/N0dip7wcSl1XQsiKEunJXfccRFOk/ZmFxOZGikJXdJjDfM3PTydN+R9?=
 =?us-ascii?Q?IpIn2k/Z/N+8bTA6Z0/xMqV3tqjDAb5ramGs65KgqDCUxjJy9bNREmVtTMJ1?=
 =?us-ascii?Q?gEQB2uxVgqcbVR3sDb8dXFCYIQ+veVuJYdr8nAhIst/TDWsBsuF/mLrH0hm/?=
 =?us-ascii?Q?vLhIm5lqDEf/x/dlLG11MmONkUjIbzEUYqUyjERNb5mveIIzuwp7bSjycGia?=
 =?us-ascii?Q?yaBXUBnsGJEPrkM+Y4AKs3XmF8o0GxUCzDLA6Vf8fdOBCGJW+AJdlY2UXFQ3?=
 =?us-ascii?Q?hHypV1cuRrHs3qNOe8zICKdGUh7TWaj8k1Z9Xm8MRXhJOw4GApoB5+WP+Jsh?=
 =?us-ascii?Q?yYQnmb0lfordAR5vmfx0TYs9wYzY19y0eOCjBc2lgJoPH2cqAG0IqEbP5sjD?=
 =?us-ascii?Q?e0FfAe2E7yAifqz6bO1XHc7sKUXPdJDGbT0ZTn6GMvUovkEz+EZv+PRs75PC?=
 =?us-ascii?Q?8PIJiE8kN6U2Sh5yeOHteoAEl7GOi8VWP7p8F/SKTGx8RFI3APHGLQsMIIHc?=
 =?us-ascii?Q?4DZti/DnvpXyCuQ+/iY9OhoS7ORruAPVNQpH270yu+Mz4OipJYlclBh8s8vo?=
 =?us-ascii?Q?jkBItL87/na4zBymEvXHzAj7SHETHAGQ5nIsdRsDbT4KzlLMhz7dEGz9wkOz?=
 =?us-ascii?Q?w6mmqfeczycjCgnWcWzLPNEm5q2aHnaLCt/a011XPM8nNn6Nn68jn0NAw/DH?=
 =?us-ascii?Q?JUl7vZXJZ399ZiWJbYOZplp4YK6LqfDg72TAG4pD+jUWBv4BV4vJk4ujr2sz?=
 =?us-ascii?Q?b3afBUsF6Oo4qxm6XCZZJ3MMyAb1GI+IMu35JXLFiXz/NL3IAqO70pWbcPp6?=
 =?us-ascii?Q?nJwDISDbd/c/KC9QYM8+dvd3ZhE4UU5iBCA0GjlK9SxsMJ0E57CdR3cpkROZ?=
 =?us-ascii?Q?mxufqCPL1HwzzYf6qrJ28bim5whxY+Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bfd7a7-6738-4c98-4550-08deec991cdb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:29.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv19MvSAz2dcHLrp1SxAAEktv0NcgCAPdFECeIlsd34kLXpwcboHDdhg4NW5od3/1PuSIDb6SGDz0AD73NODLCUzEd/SUn0iiPtg8IDtE6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8685

Hi all,

this series introduces initial support for Dovetail on RISC-V.

Feedback, suggestions, and especially reviews are very welcome.

Changes since v11:
 * Remove sign-offs of Florian and remove shanmu as co-author

Changes since v10:
 * Fix additional checkpatch warnings in patch 2 "riscv: irq_pipeline:
   add IRQ pipelining core" and 11 "riscv: dovetail: add core support"

Changes since v9:
 * Fix checkpatch finding in patch 11 "riscv: Add dovetail support"

Changes since v8:
 * Further simplify trap handling adressing Florians suggestions and
   recent fixes to irq-entry-common

Changes since v7:
 * Simplify Trap handling
 * Rebase to wip/flo/v7.1-dovetail-rebase

Changes since v6:
Address the review comments from the last patch set:
 * Keep the virtual irq state in sync with the hard irq state in trap
   handlers
 * Fix irq_nesting imbalance when running with disabled IRQ_STACKS

Changes since v5:
 * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
 * Applied suggestions from the last patch set
 * Use mark_trap_entry/exit_raw for kernel mode exception paths which
   use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
   irqs to stay off. This may be be subject to further optimization at
   a later stage, but I do not see any negative impact latency wise in
   my tests.

Changes since v4:
 * Rebased to dovetail/v7.0.y-dovetail-rebase
 * Applied suggestions from the last patch set
 * Added starfive-visionfive2 board support
 * Introduced raw console device based on sbi debug console
 * Reworked pipelined irq handling

Changes since v3:
 * Included the IRQ pipelining patches to have all riscv specific
   patches included
 * Rebased to dovetail/v6.18.y-dovetail-rebase
 * Merged most of the fixes
 * Fixed IRQ Stack handling and enabled IRQ_STACKS again

Changes since v2:
 * Rework trap handling

Changes since v1:
 * Disable independent irq/softirq stack usage when pipelining
 * Drop KVM changes as long as they can not be properly tested

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
 arch/riscv/include/asm/dovetail.h             |  23 ++
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
 arch/riscv/kernel/traps.c                     | 200 +++++++++++++++---
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

