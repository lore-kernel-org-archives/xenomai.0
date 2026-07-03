Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1ED417340
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092472; cv=fail; b=iYXOVcimiXrFlHtN8Tg9n4zQhe9KQJahAhBpBRgmWWfMaQulSEmFCQNPm7qc+L+nEkbaUCBRQCLjcGREVzfcFsO5Nhs1FlT72KIvaNiTJv57mgJdVdQYqTbA0ld6wJrKyaKk/FUDMHlERBgImpyOZyFlONME5TZEAGltsfgISe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092472; c=relaxed/simple;
	bh=1WB/VNRCfFahVPw2zXCukGTGXO6fWmZRK2JJMb+0Bvo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BJctyaQj8+B1xjH/5tR6JTPnnnidGqBx2ZlspXaEzYXeSynaBwNJpeSUPFh4Z7oAcjsNmugvIMR3f2uuLy2HFQmPOVAPpxb0Bt+SgHXCLRnzA6ASOnZWLgiFtIpDpD/S/V1CWP55n4+pv/RvuJmrcn9mlYDEb6QMua0Iapv3LyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wleiIJil; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wleiIJil"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfbXFFrU1CmkqQzkjOYs8b805ZOWqiR9GeytHPl+c6BrEtBH0QRzbz/kFljSqOlYJLeUoKlmEDWZStFjfU5iG1DngNVN6iaT8htyVE7cOb6cbMM+4NRh7Yamk57xkBsgUoXGHkaWwku3naG7VUKzH/+PGKXq1FB8aUyXSr8wZ812WwvIYoptBWjemv+BGSmcta2Mr9juoGIIgJZv7VKLNHieeitv9VT+K/fNxczdBbbgdUyH5j/GFT+7nDMK4VjFHlrdgx/lhWxFAHQu5cPBsyXVIisrQyJg55HRQgcGLzRbrcNOJoEZ1+Y4j05gT5Cti+7WyrbCa1gn5pEnotIYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJaPsUa7hMhpsXa0XGcA5FNLJr11qZqfe0vBTJe9B9A=;
 b=P9Nf6qG6y7rKyW/GHqxtsGsyTimPr0yEA9biXg2XNZyizngS4q6BGiG3qrip7uQwwz/3urIujLdJBadbVVY6YNp4YMVttc03pwPyiful+0EtkL4BkETRRQyWDAalFdwJ6lxQw+lkODlw5hARR00pdRty1zpmR6vK3o8dOwBCCe/BnSUurkE41F6XR7ZqTczCW8RGlZysJ1eCFDCKBvxkR3BSkcFCG8LsxxyHwfIZGLK5DUuREzxOYvzGq+djrQk5EM66ewXDh1AXy8uXBN030uWykK4JomyLkwExm0DdIZoVrvhhaerAJ7/qVrKIjJA09/UdcqfQrLbcFKRfd/oXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJaPsUa7hMhpsXa0XGcA5FNLJr11qZqfe0vBTJe9B9A=;
 b=wleiIJilib6jw3ckepxhXpr07gl4WnuiWGQUvnmSflqWebW1M8vEa4IUE8rXll8UG/q5FFJmeI5uyZ1LH4Jg1xUSKa6iFblYIQXcN6hDvMfgyD9ijTZHCQBcE+ZyhiKuc7FaHI+A5ujks9S/ORWIey3eahSTsOWZDOp7ApGDwmiFZ/bIcDPStOyDlfAD2U58laOs6YH7O+J/tijw2gxm3zlc98CbhDR/cy7HXbTdK+yq+mOZY51ay1ZXcka4bH21g7K1jxavD5m0ayMWpPI0SIiE3F3nMZ9MMcCLDY9Hmzxl9rnxhheaw8CXivDfoUPFPSgw53ThVCQTnivnVya2Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB7614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 15:27:47 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:46 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 00/11] riscv: Add dovetail support
Date: Fri,  3 Jul 2026 17:27:27 +0200
Message-ID: <20260703152738.129122-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6cf1fc-768a-46f7-2821-08ded917a1f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|366016|1800799024|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	/i7xRrNBRh9YPu5q/ySB8ehpwyZ4BkIthyVY9hdSRAjfuk4K6zpQpoj0Hf6RnJkML4lCmjdcbEkR84xja0dI7gYCQh2F9p2FcqTLZ2/RqODo5uoVINjvX1tj9yAtdfPIXzSPKloVHgJ5NeRJX9U+1OHQwfx15vD3YHmwQIxi8VthfeLlctWYcDSS5VQvQsMMpf8WZl0hjNzFvuAqKBlRZQA4i9IKKzHLUfDxh0crsl9eoyViLsx5TGIp33jGPoDiFNagIRyLydvEYH+G/kdSxdjyu2D/xxQL4QE+EC7DH0m8kUGOmjJmeITaqk7KQt82jPXGkAxh5JNPdAQfPipk5zxOTVfOPuWTUViOQvsxOljUNHj2vZTt8rFqLYNfEETHzfq+UlsOTgV5keFiYmfurvjwFuni5oYctYVcRbfjMio+wBsFKqNocspQAYJFJjPF9UbjNnmkknXzHt5vEK4L6lSctqazvc4d7ZuD9W6qUPK3ckfbXBwy2/OZFOopMTjBrrddxhGvfSkEZMs2rj/e1+rqk/hU6+S9A5heUbZUwqkVofz9eovNW/2aHj305TCee+dzyD8h9czgR8LFj22oM8H0AM0INCm35lN0P10PdMnzkw4oj4PowWbizQEYgaM1bfLK177+P+ErwC/0WiyLrXCLKyBegNucqLHxhJHIHOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(1800799024)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfzvBo87Pi0XaBWGaBjEAj4mjRoT/a8XvTpxEoD6cbAaEkr0a77dtqHGMcUK?=
 =?us-ascii?Q?0mL+DBSGROwcXIGGQ1Z80X5G7hrOLtwwUbm5Zujahxo6EeteivyWqBhRIo6j?=
 =?us-ascii?Q?8ESxGODjhxrgKsPuLisTPB73FCXwUHP9LZmdu9oZ7SCDl/RUj2V/EaBEOGnl?=
 =?us-ascii?Q?TNuwZB+5/8T5alwD6EEoz9NPW3a/Xz8A16netSzS52qVbgSlUKimuKJrwvEg?=
 =?us-ascii?Q?ws2Z340F5akLexb6gbxyKKNklsxGR1VxoIA8ZnKHftQToq6upgfug8voHVf9?=
 =?us-ascii?Q?nkfwKXGtq05UBjoUkTLX/oZGsvfQKjI1dh/GI888UbpcL27ZPicIyZVBc97f?=
 =?us-ascii?Q?A6+OpHVJWUKT0ueC3jaw7Yh/LeymXk1Uot8ZTQBQaiLvSDtX1rVJvHH54s/v?=
 =?us-ascii?Q?luLqBsu1ZOS6syer6AWzkOk64LKgPsNO5uEfhD9L2wQoKwuUT+ooVsPfsppT?=
 =?us-ascii?Q?rb/x2+CnPdNWwbmLhnsfHFhxVJelFn5owbjNjDcpwmhia010SSuBdAM6qTi8?=
 =?us-ascii?Q?jCPgC+c3bnIGkV5J6Dpy/99oxWfbZmEZJ6w0bLEOX5ZNrR+Zov4idqA0B89b?=
 =?us-ascii?Q?7S5jSyoUVXTblVyTsxWUkHFiXt6J7amo+QP2uobiuocKinDBZUz7RC8wnyro?=
 =?us-ascii?Q?wvObHD43TSdJxhm7LtW4/UKVjaSN/r6LTiVFJplhvURQ828rhsGv53wAK2qB?=
 =?us-ascii?Q?2JZztSO29zL9TO2DtxHybkStVm1hGCBIPYDuLYrgXjH1CMNQ1S70iH24RVJm?=
 =?us-ascii?Q?omZ620GUYp3M2BOZ2+xDmHBCPNouAjN5KvKSAp7Ek+CQGGDPhoY87UPsjJeh?=
 =?us-ascii?Q?mQ+u1bNnjf06XC3thp6S2WSf+ueC/zzkt2YycdJejuqOn5YB66P5BIRbSq74?=
 =?us-ascii?Q?BM43W+GIkWc8Nt7gk31AB4v4EHZAdM8PvJE3Hdq4dPccPYD2HteYPUVB1WBR?=
 =?us-ascii?Q?MxdGdpjonG8Gztyx+1PEgUeMZl2JlX/1fgAi5I9/ys/42BaoGc24O0c0ZtwG?=
 =?us-ascii?Q?akvW1UZhdJtIQH+l4+3/c85x51bVbzexT3sXqoQIsz0HPPolsPLoK3wxUMyr?=
 =?us-ascii?Q?UHuAwRHad/k6I/jhKDRcEpmvmTg8z905d6jHYmww/WSew8O0CJNcG08K3Y6o?=
 =?us-ascii?Q?UU3KIrjzceMbN2w+scqTbBPdBmfS1EcCKKQt/X/yY/ABbaI7YAHPO7XwLOGE?=
 =?us-ascii?Q?cEtxi+TbtBWnBhBPOj1b25eU3+jTOMMnH46PdxhzLbjNmLLvSVy1i3+hCfd8?=
 =?us-ascii?Q?6lHtQA3w6FQ1HywjOfz+6IJAszedy8N1gBkeeHv05s1/fjplpplsd/MFSOMJ?=
 =?us-ascii?Q?jsU1t2qOoEI7EGk7MbmOsbiJlx4ObwiToRTNJx/X8R8+4qdFt/7+H3K8WUAb?=
 =?us-ascii?Q?t25GUyYQ9IixpUcaNxfwP43XzO6OgXQOWuDmcSawf49huFvo6GKu+dJzwgEC?=
 =?us-ascii?Q?liu1Be8oNCP4Rp2TJ9PF10MA4y04uycbndjwrV6YZvMauR+3OQYRBhDEBJK9?=
 =?us-ascii?Q?xDElETeCEQMyE7xabWz4zdRrCnwrnRTtB9f73sajFsbv2u/L6PcaiOC4K/Zs?=
 =?us-ascii?Q?4754qmQ2JMubevuKH0R7dj3UTmic2z1WxKvrZYNhZHz12jDRShVIXkqs4CSc?=
 =?us-ascii?Q?ZqA7JWTowekK9h3iKkfTD2hv9hCT7r+w1lQpQtoXC6VsxTT3rhMHrXYVkiAn?=
 =?us-ascii?Q?9iPFoMhuzIcAIMs5PPdpp/yHTsF8nOVK9BfrP4PGSJKUpxHCxXgL4LN7+3fY?=
 =?us-ascii?Q?KVI4ELtmNwu7CgPSTAioCBaYkPGzhtRCy0JvB5pduEQr0qIAn2B9Jx8U0MTQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 7dS+uv2aWSSyJ7MRl2nBAaXWRC8ym7IYuD0=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6cf1fc-768a-46f7-2821-08ded917a1f1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:45.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfpX1wge0hWCBZNb9dqPZ6RymcGKyWwDNzQGKdXiWu/0BtYLQ3P8egguii88M3CThreqeTHFzgNeGXrGtDNH5FnvqP7TQAyAy/qXHhfphq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7614

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

