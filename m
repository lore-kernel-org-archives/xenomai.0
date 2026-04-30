Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212C39B48F
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547473; cv=fail; b=Oj5R19fXjIk1PYU9osXama1J3dC0L5hbjULgGcaPICltIy5hxSyt7CFNvqmRRgGAb0o41FOpbAMaLpOjMMxYPUeKSKMxlw6fZS5siWgDMSgoc0ai1QSkVG6xLdfZhvK06TZuceBWJYV29eKdhd1FUIS1iC+xur753Fpu3GWcE4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547473; c=relaxed/simple;
	bh=IFuwN3vEnR4jmVnd2UhA+bEuvNcyPxCawmrKcjpfylc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=POFAeJ/4pdysGp+R9H0NLlWBNkkmGQC4wC5C/CI+AxJPcqhM7p++iicw6r3OEEtonuCR9kQAi5UQc82plGr4qxRCE6BQHa6IMLYuGQ4e2R2oZJLXhfzy3edZltbiwrskdguoghbeu+DsMfFtqovxN/4oNabxlJ4N0uA3/kezE+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZIsn/6zR; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZIsn/6zR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDjh+G5YeBV01ryLAJOS1eA4ciZoxWqGpnUbIijOifADff1xAkS1wBGSjEGfVFvJzfV7z9LGte9a+O02fBzvAjvJBAyq6yjFyalNh+1H97oB2fnF2wdn3Z9w7nRAuIsyNX1O0S34Y5qUy8WZ8OIE4oMlsr/ad2KRSCdSCFIAmshBNhKJHdyjzOxRdj8CyZRtMObuHQTdv8yJDokVO+qqTPXKr3LCHvyn5QFOLGQhVZrkiBk/yKkadhC1TKS8qpTj/gdXxuMEWF8UNDONCRR0AvOu8IyqtJ6qttnrIkzmqoqbjlHxq/F6IeuZmk2yN2vZmpQdmTkjRa65fA/dfiSsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y3dsdY6hD+XjB5AMsL8kMVMhdcjY2VPOGY7oolPMoM=;
 b=Zn1yCzmhSW02/11YjhDpvnfGUxnIuxXsQ2ZYpPpXHqO/wbc3rVt8/w/KLPz52NDmdmc/Hh1fnOVIjZmniA23dSxt1sNd2axCcXlsD+TcNZJ/uw8ETUBiJ/1XmoStsteGpX2TutV1v+QSoqPayXOOqS6p5M7q2yHss151s6xqDBlXJxQi7XyL6P6mZxDY7WUsJpTFoug3Ctipz29IGC3mf5n+e6jZzewgHxBKQpV30eYqkxaiBDSUQnEUH9AZICudaEuUmFG8Y4OqKSLZJdBwOTkFng1fZ2BwoPdaUa8uuGAH6TcmROX6N3z0GLYPwY2dZtcBFuvgJGOmdkoKZfDXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y3dsdY6hD+XjB5AMsL8kMVMhdcjY2VPOGY7oolPMoM=;
 b=ZIsn/6zRR3HRo7HvZCn04p2IuSuQn47FJqWGqW73aVQyIXWakBpnOQd2Y3NjuizJ01UGenyYBAEmUFXPzS//EVp7gjRCH4Ceo/VhOwZMIaDN8ZqcIhraHbZSKXZjL+KH2DhCmgAj/O0qKCe2idtBHSFCfjDroG1RGTa8apIe/wYYN6cPvJKg35FMoANJUK4FpqDT7U2vbpiR0b49GxR79KNI444Cddjk+AuLhj1pisT5LQwY8+lsAtWLqNeuDegbXyXsUJEz3pAnGth03e2w2NqaxE6sy78HJU6ZmXTOKHgjPSb5ffydWeqvv+r4l/JatApi2SdEO8D05iDJh5KV1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB9063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:11:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 00/11] riscv: Add dovetail support
Date: Thu, 30 Apr 2026 13:10:50 +0200
Message-ID: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: f6110876-7747-4f20-3b7b-08dea6a92e1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	nrdcPoCIlXFigrrs7qFDlOMdI/L+kR+115hARxhkA3OMosGFkNDbs9wuvDIWbQzJ5U+HKaepaoW6/EFD7qOBV4G7auyBeAmIKXxbsUg5nyb725lKkNT1bLbmg9rXdbGmK3UCbWKSuBPf2Prj7Oqn74H2jE685UjJe8sDSanyd64ilMEtlNc/qT1CGQYp9loRgpnpqBVyuFd1GOxfiDaPPX1WceQ0DTHG8/2XPkj6jq6K/0jltYWqosX0IAf5C+iL8BJTw8QbUHXq1kkepR2JvLhK7AkxKab5I0RETAtuCi4auLYZaSs/szfpDPBFaD2+H5fFeWwIXJ+Uh0HqRfC+jZJWKisIT+XQjiGdoe7wb2C9Y2KOkaUu3iQlU9z9Dqlcupb0zh6m4RiohrBCYgoLf9AUiMYdcMATd2BLLVZMT5PsTaNkjGKcwc/RNd07vYHjoraexFXhTXC1xUIOmJ3eiWZXMh2ffxVNkNSv9UNgS4MM+glDXP5E6mnUOsngGeeZwC6jArm5auZDwCYN1VbMWsAJ9ksjmvVhebeJH4aGS4CKwSKKKUouHje9mE74wORl062qHLVJh7bve89rFWbtgL17ZEaixwSqyNWsQ2/KxiI7pvbnFh4qRAZgBLI4pmhEnEUMjX8H13K/rHBQgaAVce3UQ+Ee3s+qy/+wz5otftJ0vhxvZe//po/qXSkNZ72mFeFEYuKK42OTYAcKT9D9GFnwtTHXNz6oRukTcqs8y0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdqP8E7TBpHE0uiumEl8P7C67CICrw+0TO8Zf5RqvAb7EinTqm8A416MEIHt?=
 =?us-ascii?Q?BKTXr/tznltbqDMzFbBfFMSkfDkeetT+jDwgZ3ykurARjUZjIS688qbNtID0?=
 =?us-ascii?Q?mYQnsCRxo1WmtM1iXAU64Xd3hVpG/IgtQb1XPFthlMRumb5/a2B6xXCQM3gh?=
 =?us-ascii?Q?97sGFJ8mCzLCFIqkC2Lepmmar8y974gKyERk3YuF8EDwY/2YjuLMCCOWqdp4?=
 =?us-ascii?Q?49wsqx12TPJo+SFttPpbukbIM4MhFInLI8Uk+hY990B42yG3z66hjJumG/Lm?=
 =?us-ascii?Q?PYnJTzTW6qt9eSsNTXWcaNecdM1GtSQR1TCmKj0ouapY/rv0YrtsTrcKVk8M?=
 =?us-ascii?Q?KjoOb6ETOTOono/LpZvN5GNE9QY8kbG188otMa+V94I6YMWAnL23GWwjx5w9?=
 =?us-ascii?Q?IDCjuIA3aIojIQQRqgNVN6buY2zCoSxeIeKi2MTMFFjpOzerrYCuC5ejh0rG?=
 =?us-ascii?Q?5PBuz6z9CFBm6h/tYfhN/B5s54YXNFGk1BQ+DEfQNg9y8LumyUx/Rk3VSmsG?=
 =?us-ascii?Q?Z4CPJvV1tGyxyFMuh2Er2A4ZxGrBZamwL7D/0h8WF+aLRVN5PPhdCPIBr8UG?=
 =?us-ascii?Q?cb8NVBYTK5FuAVC/b/2yJjbENouK2fx8kJf4FKnI/BOone485NxxD/DX3hev?=
 =?us-ascii?Q?WB/SECfci6VxjEzaGULYviqBISN5fsYafzG02iT/QY4CJSqpXKWC0GxhxNP9?=
 =?us-ascii?Q?kTNvgTwJQbE1N7/JMi0hgmO+FYLpz/xPmGyuQpEzMmHrLn4nYEU9NZXUwBr0?=
 =?us-ascii?Q?1FdWulX4GnxEkKfjoRRO9Kl49IvgszkOIlI57unhMp1NRNLM+LeB1teVODmN?=
 =?us-ascii?Q?scBPLzK8HwprHZZrxsC5nTgpIPsvB4Qf/Su/Xy0dlPwTR+/shtnhMwhaHQY8?=
 =?us-ascii?Q?7HaeV31y+nUdeb2Oi/+0znKTmE7CdxbcoxbKpdCn810XY6/H4DYamjLDWGij?=
 =?us-ascii?Q?06HDhKFvWVbQFT2PVAILfCbWNp0Qd04CI2ik/f1OZiqrQrVd1cjsc1UwmuhU?=
 =?us-ascii?Q?sw60KNMWjWH+4Yn2/W0vfGV80xcwyb7qxi0mlGrOeYSIu71nHEcsdTItk2sP?=
 =?us-ascii?Q?37EbDTMNrYxKFQSJBlD66TuiXN30wpEM15AWrr/fbz+pBdDlg/0j1hKzwHhK?=
 =?us-ascii?Q?bey5zR/GZCHrlezkbEpPYmFFm1z4E6qFS8ymgpyzHd1f7qOVWmKS6J4GIlD2?=
 =?us-ascii?Q?PUb3LcxtiQhmYdUJo3sjrBYQp/+7DpyWsJcjigyASInMfA3f6pPNhHJn+hhg?=
 =?us-ascii?Q?P7rJhjFf3rZavwHhwfCANaOLrRUFp/y2fDCnRvRap7W+qo2aaFrraNyICtpW?=
 =?us-ascii?Q?Css7+lkNtRQx4VHi86JlUXFPlO0oPWCBpz4RYJfXUFW5TrMudSb4CXEo+yVR?=
 =?us-ascii?Q?j3ldQG+4UwenDuRJCiTgMhMtfH43AbZ2fU9bfU4nCGhFZnCIWA5cWRFLalSP?=
 =?us-ascii?Q?lTDa5XjHreCgm/e3w5ywY5FzoOry81ibHiS0GlapCaxK5FlDNc51uU12AM5z?=
 =?us-ascii?Q?af3VZ1k3352ssTDHnlIkeZxp3DnAeemYVZxb0d3VreNrYyWn6n8BHqMmZgSp?=
 =?us-ascii?Q?qNl8kcBOZaWW2PY7fUy0JebsVcY6IFCJCpiEmDfiENet4eDecUiVOx0oUa33?=
 =?us-ascii?Q?5J8vun4p4vxZ8Z0AQUFHM8qqrSLYKnUz0GGa1wyNiBW5MahqeCd6Y9EGsvj9?=
 =?us-ascii?Q?KP8P0juNjAyBzssG3zoys6EvCCnJYDPquogQNSY4ExB70818mQkOEXHM8p3t?=
 =?us-ascii?Q?eo+kBOTCNk2Zg7zcvaxd/yagKtKhO/A=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6110876-7747-4f20-3b7b-08dea6a92e1d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:08.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azF1zUsrA9moryZKphOs0x/ex307kAlgFa3xyCPedNEQc1mwbTq/FbmtaYkd9zYKQEVEBmv5J5GwrCPSNxtq3C2ZHxQ2YNjYJCzDOsAA3No=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9063

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

Best,
Tobias

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
 arch/riscv/include/asm/irq_pipeline.h         | 143 ++++++++++++
 arch/riscv/include/asm/irqflags.h             |  32 ++-
 arch/riscv/include/asm/mmu_context.h          |   2 +
 arch/riscv/include/asm/smp.h                  |  25 ++
 arch/riscv/include/asm/syscall.h              |   6 +
 arch/riscv/include/asm/thread_info.h          |  17 ++
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/irq_pipeline.c              |  26 +++
 arch/riscv/kernel/kernel_mode_vector.c        |   2 +-
 arch/riscv/kernel/raw_printk.c                |  33 +++
 arch/riscv/kernel/sbi-ipi.c                   |  12 +-
 arch/riscv/kernel/smp.c                       |  56 +++--
 arch/riscv/kernel/smpboot.c                   |   2 +-
 arch/riscv/kernel/traps.c                     | 220 ++++++++++++++++--
 arch/riscv/mm/context.c                       |  20 +-
 arch/riscv/mm/fault.c                         |  29 ++-
 drivers/clocksource/timer-riscv.c             |  11 +-
 drivers/irqchip/irq-riscv-aplic-direct.c      |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c         |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c    |   4 +-
 drivers/irqchip/irq-riscv-intc.c              |   2 +
 drivers/irqchip/irq-sifive-plic.c             |  10 +-
 drivers/pci/controller/plda/pcie-plda-host.c  |   2 +
 .../starfive/pinctrl-starfive-jh7110.c        |   2 +-
 .../starfive/pinctrl-starfive-jh7110.h        |   2 +-
 27 files changed, 613 insertions(+), 79 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c
 create mode 100644 arch/riscv/kernel/raw_printk.c

-- 
2.43.0

