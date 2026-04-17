Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CA2E1722
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459731; cv=fail; b=U6ukyXLiHCnDqyZoCb9sHex1J31LRIKeEiXXfLenIvVIiNlHhJ4kMxCHe9oYxhC3YV3vidS+Y0fVZevY67IwfXdXhftAauJTQbSs2ANjXiNUUHHrnn0VSrfH+7Q6t5bx1sx5YZCvahmlGfiZGnGr4OXDl5VdiPVasj/Y9xq1cQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459731; c=relaxed/simple;
	bh=QZQHBPpKYR6BMtBrAMpbhdbMQTKt2DZfd0PSllJRLfk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JV8yzQ7AejCnfJs58eRZxs2V116IuilIH2PbEz5FMfxoGDzND129aojt+YF2XB+bwxCm3ttgV2Ka9s917aK88d+A8Rqx3AL6rpYzsUIiNdIm/xrR2rlBoVqpBO1MZwGbCeq887dlc0dXezJQGaGxnZXlbT9oC4yI0DlQI6XKzd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=t/830HPm; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="t/830HPm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNQm6yv0dow9v2/qaE9v0ap5RBCtNTNfEEzo3DGIy14MREj8HlO90MlRO6sADGiomyschGUJOkzZAYTbqG4Mcldn2ZXIXm1AO8lqoKcwx/b23A526SfuVxtPaXMarAgvl6aVWARJqDgACm26O+afgW9W1VSAjiagVt93sQtBdyJiMvKKKThI79bSEhcGJjsyBOrPO9OEMbQ+ziShDNaig+k+ZLKDmqTBLFE8goBuVrwqCx78DQWh9IxTp4aLhVWlg1KcDtanQ3UyvlZBkSBcBM11641aiNXYO0Pl0gf0XCswk0xKIC0kZGTZYKMIoD/DkLJ9n3LkyYPDhhRhBqwoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNdDfAGpc6bPFxix3xVCWDQx9SpaLy1+qdxvPUjAPPY=;
 b=lOBA87PLBE3y6qmcGh5Ze+h1HrmsB1RbUE82BjgI9deW51NaIaWtik8Ne2n6KuINv2nSt/rsXh7/Mj7MytWVEa/Jxq1Zsyu/ufGCrN/9NXnMfammucy003Khv5oGmqZMRj3IHcSMyGGTe4grAy0EVRKHZqaxUm5HHYF/ncmW7ekZEr6R5An8gwQKgFElLb26DzsClLqfXq7O3mUNW30hqnn4K6fFcrwdkb1bg4k+qhnbPSpqJT5pcZIcf7sReKZL7Irn3LlSb2ShXGeUB+MkXniYnouepctSPUIowcsx6XnDtKH3Vlv9ID4OFKhxr04H9dubVL+QxxMZnuDcbei7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNdDfAGpc6bPFxix3xVCWDQx9SpaLy1+qdxvPUjAPPY=;
 b=t/830HPmJofHj3X/bLEJxTyQTEaC9GkkNd4NHqpv9hwfDWldjrjcDPLgTdKmIMXKA6uMYrL6dlJG/XQ4sc55CQj6H8fy++5EzNEOVkrhBQ+1sD5KKXS30qCerQ8zcnoPaxmC5NjqRQf8EkQxoknTSH++kzHsQYvOJ8HvnU1chZs4Gp++8FVGtNjFZHFiv8eAJFAN4BWOEak1Y/UjJIkyudt8tZio1/xc7Zl4eL16bbzOEeX85eL4r0HF8e0rPFVp799jkBTimqp3LntjWtl2fchQbvssUl9ckVCEdSOhG8TyWYddOCmeIxB3vYohLA6/pp4VqJyz8/FpuHC3cg54lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:01 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:01 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 00/11] riscv: Add dovetail support
Date: Fri, 17 Apr 2026 23:01:43 +0200
Message-ID: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 725c5dbd-3183-41c3-d867-08de9cc49241
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	NeMjjylgEQhVSlbcOsBnDdjHZDfNYTQh53CPUHddF9ZoSj54W4Zvxymyi3xl27dFxVy3AfskDyQZWj+mARmw8R6F+rknCcJvJYArInzx32CpNkKh/u1DdlkoIy4Fk16NQlKqhsB0gm+IrnWJEjqhid1qHvrUzQ1W6tPLPkk05h5VTE9SmLCG3FEb270nwBIl6GMK0JKGM7bUhDnX/iJK+zh2jco2dB+QsQ9vrrvTS9TK7CCJ0ZAAPu9ixoHqTKnipDtVFUOkbUhuwGB9ryjhACyomMXLLC6JK7GNu/4T6Qy8k5pRbzbsiKnoaKqZ/1xCp4LWRZfhAr9XNa8EGYycQi9b2ASbMoU9lKCVdkrA1qkDA7bLSEF/DmIgfk21iTOtoJ1nZZVxWHJyEBem/yufbMpAUw5sjV4iSPiHfuzHaiN64Bv+/ynTU2wj8slDu9AqRGp6LBgIpuP2b83pIvL8/yux9PVJ1welArUMiEKu7pcrrNsqCHlwrL4PEFt7WeBzqRqHNbTPrCW6TG92BqzHET6OqnL+E5g+qADrhze+46ICPxaEAqSz4KeKhG1L483gwkdqrvKQfTtcUtFio4G0LMoYDk5y5agIN7fVwrAvzoaXR+AbO2l8qLEWXW+Los1+q4mfUrFXQw+ApRAy37/64KF+AHwdEXgku8Cnh4D3pjkSLX9Ag0X5gmtZk69yPuZ262QGMuEtXqSUs7vNsxtjNrQ0y68xzlq3eB22xV4YLjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tTrSZSK/DVCfe/RYLVlcB8noq7lwfdUhFs4bkSK/r9ns+CnJ0zKSZfMeBTi+?=
 =?us-ascii?Q?Xkab6txVtL9k1DG9FUeBZqynSslpOh1XqEaAZ2m16rwlyNjh5aLVqzsSeGHG?=
 =?us-ascii?Q?5t1llb+jB+4DkoVKcmrQtFTpFui+vYkmDFg7/3Bvdpr8/QYiekaSXnp1bKeX?=
 =?us-ascii?Q?trDYJDJH5s/nEhxrLMeuUJdLh1pqYrFIbTvkeAi/TwZzSeC4uI97L8AlZPGW?=
 =?us-ascii?Q?99JiDOyEWr9ivb3TA3WRoc45N4vY0iaMv1kIy3xwMoVXabJNYzjpWg9gduQO?=
 =?us-ascii?Q?YGcJc5Nc/KA5ceznOHse8vHur7EURFby7W9e7LeWwPZoWT22OMwAhG8Ek0+z?=
 =?us-ascii?Q?tIFyLVZ0hheFiPgocKibvT5n75MTxFUiIFRqS7yc8vRGqIC8cqE2CZEC37Pd?=
 =?us-ascii?Q?S2AXy1PdhYh/Hy9wso0ncuncoIb30Pj8i49Gsm6OoT82sVRL1nA+r3K5YSFW?=
 =?us-ascii?Q?TCH8Pfa0RPnm7gjGs8cID3L/9ynXXzFf6a4dS/j7sotWi9QXkHVOSz1BMq+L?=
 =?us-ascii?Q?i6aWwPoQfK04hYxBxk8MpgXb/U/CjycrGdQTju7a9pcXS1+KRZ3U5P0XmzmM?=
 =?us-ascii?Q?+MwUoJ+vrz/JkPZ0AXixFSd9SAuwCcjdREB96uHNTw7yV/BN3briceT4xhlp?=
 =?us-ascii?Q?MbZ0Mtg76vrwsMTaDau7BGs1R/CyXgKcRVemT1Fqr8MPLhWoALcUj4hAqWfd?=
 =?us-ascii?Q?O7fOI2DUjYLUfQ3MvaHbQ0nu021aEwHzyRMk8tbhfzd9tN+MdwG+PRwgsUyC?=
 =?us-ascii?Q?p3DSOEUWfG+WtfBGl9qeuWOe8NrrbtofDVOYBESKdmp1HAb6rfc2puZr9+C2?=
 =?us-ascii?Q?0F+CQwaRgWaSLBAlGYedHZYuNA1CMSeMJLehZpTeKF2UCJopdW4q0t+5AFZo?=
 =?us-ascii?Q?4TH71AB+dstCViHbnwaZSZiPwIsvviukpEp+PX3Lzc69J+mmoAtTAIy8d7db?=
 =?us-ascii?Q?SANCRP6iSaXGoVUjeansHrFSkJp3tXMIEHN4yjfdvdzou6UX1aJTKQzR3Prm?=
 =?us-ascii?Q?BGkQ9bHq/cnhtmu6Uc+tHpYk5Xz7BHoD8U6EhT3/jw1xE+0h89fOyFbKcSrz?=
 =?us-ascii?Q?5Jn6yk3Qpmd8Oppa4LlX6goZ5WlS7M5jKQxOCD42veat0TgF/dmS5T554UIO?=
 =?us-ascii?Q?GU/IzVKVgSDI1ISoAN7XpsEKZ6IGkCzVJ8nKXV7vP9yzxQC5p6b4MJhkGafI?=
 =?us-ascii?Q?O+CGb/AKUeiwpP9DDT3PEuFJFMOZ5j/a1R7ZS+x+gBprl44MpAHtBaiWRiNn?=
 =?us-ascii?Q?nECGWUI6S94CMdOe+IbMYYrtNWX1359CyvjShFtIKgr7yCf3qGNNuUNsQ5hX?=
 =?us-ascii?Q?kY5KB51ePy5Yh+TRB1MzlB9KlOGob3AdOgxnJa/5PkZTHenSfqs5WhZno2Jk?=
 =?us-ascii?Q?PEzsoUaz2l84V84EaVS5EYGrkBf2tSf/B5eyCCadRqiDRt3tUF3N+w0oRqiX?=
 =?us-ascii?Q?zu0X7RByWLpMWVQfhw3vYJfMZgcRGttJEMgro11XoqT+Y3IH6E875+XUAryt?=
 =?us-ascii?Q?CDEAml6/Rnd6NHqokPP06ZrU20b/XjeRdwO6dH2uguvrpmVAvJWBoewoEckT?=
 =?us-ascii?Q?7dbgTPXC3cL3Fskq0FP/qh5CUrtgGvj4H3hO1HDcQYXDsEYpEOMdVYak7TPe?=
 =?us-ascii?Q?PIkD3vtgeiiN0UJSUEDffGkqNoUAz3NGNOrCbDgdN2prhOJuiOLR1tDVqkfp?=
 =?us-ascii?Q?NDqNZdhADMtWz8FWDONRnNewEmHfwzrCFXluUmzH2NStTOv8SW2hItvRU13B?=
 =?us-ascii?Q?rGZs84qBrVnbZXTv7KHSYYREGDzvB3o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725c5dbd-3183-41c3-d867-08de9cc49241
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:01.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnJ8l96bvyMz0bJLoI28T62oyHB/FacbdE8uEUKC0wyX45u7Ty50w9OgyNk2CyPUwGRjyWxbJHUy8asJMy47Mz1WVzEqZCRynh7BnZ3Ov7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

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
 arch/riscv/kernel/traps.c                     | 196 ++++++++++++++++--
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
 27 files changed, 589 insertions(+), 79 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c
 create mode 100644 arch/riscv/kernel/raw_printk.c

-- 
2.43.0

