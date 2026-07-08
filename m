Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8ED35AC32
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492080; cv=fail; b=gf9cbOWB9M+9WQ6vdYEjQq2bjyfnjt27sh1ZLbLjGF3K5a1LvGVcAtZzPd92uUQT1bK1Y9qpGGsnw6C0WORy1rWZx/ml7XHzLxOUtRnZj6+BXSpeQBEBg2opOG9LENJnNumOxwf8v5CoGPyF/LODl51X5r34gPcW9gNS5olGwKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492080; c=relaxed/simple;
	bh=/9uU9MRha+UOQs/POgugxLBArDawBv2DGQbmmZ+ckI0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CZd62opXnaVtookvjh1/J1upahmGhDUELLamaxe+3ssYTZZ3CU4FY3ez+7XdJtOEAT05Jk8srYDJUXA8z1iHdp2ycYnaRmK4+ZB31jcH61rrC91ypoJUsrLRsZGBK4vP9ygVyCu2ijmaKf+9vq1bS3Kw6DHexsFPnZvx/ju6N2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Dw6zyeqW; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Dw6zyeqW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2zaGwZSCB8xe+ppFPnBMBuQ1bOm1hJ8DyMVuNKGBma9XaB0iGPlM/9itu8hhUCaA/ZU+Ln+ILpEMQu/iGBOvQPbTk27aqOAAG0UGUFjpadBXzwFmmRMZd4NmuAfJhBGSXblmTk8+iLAy5B4K7I55lT/lfsPEAbSsN5lWBjnnp+bbP+3FldwjACGqbOm6cmBzRwTslJ/Ls7GNRwjuUqotTQYpSJl5wSbjxd8pGelqG41uzQhglwaykLTNCniiAXAPz1+2LNUCI7Ho4wljviz5aShkraKtQB6476fOMsNwwNttH/HkPyJQyMiRldQJVRSFnu6uYUaz7qdK9WZAyZCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU90N6hEqlL/3pObgWR7K+8kbM2JJcrfpT7JhwHNilQ=;
 b=RHtk7pmnRcRufSgr9eBe0wnwvOPTSfEqUhzSSIA+GeHe+lw5/xH7qm2VdjVNlzhd2CkEozDrop4e+Z08YonallYeYZ6Rm+XBabyKYVO1mpB9fPNuaAA94VwivY+nlgLc4BBptP8yA0xq9v3TtpQVoJdFjDHJWxkhpJfe/7SuZQu6+C4Zd80yOys59RMUHIjhcv3AAP13QfXMRzDWgt/bHHeosVG00yBdKCyzmP4o/TXKoBaI2CNrmSIgW+WjkNQyYbz9fUWDsD1HEG7KrRPTN8sbJukdJAM+ZJGL5QF1RMTbRpZVqvhKsOTxmFiwYY1l5ESuwIbkuvF5rkY7uIz4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU90N6hEqlL/3pObgWR7K+8kbM2JJcrfpT7JhwHNilQ=;
 b=Dw6zyeqW2QDzPFC/3jJcZwjkjqdso+MNDD49wcHLMPM5JbSRYc1nP5/ugEMMSkGkrq6lWiJ33J8QidoKxmlaXu1krg5J5HHkI67tMehevOj+4Y5EvwFUWE5Xqa9NKptxs5zTsDghqBZpGcMYEe643hxGMusu1HTiVvAvgRQlDBuNvo8Bu4UQTNbmTx55D09D4F/D+MyvEXyMZnE0y0FenlGco8sOpJ4LnOf+3VgJHdgOwJO1ggWp+aJpqDhZPxMkWfynQkbla8Gi+cZkrZ74Zleu9643xsJMkkgR+uGzgfSkjzWcEHTFvzaJOdGOJ5jIBdeXIIQH0Hp7NEM7hFT72w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:55 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:55 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 00/11] riscv: Add dovetail support
Date: Wed,  8 Jul 2026 08:27:37 +0200
Message-ID: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c461c8f-2efe-43fc-586e-08dedcba0bd7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	IbB1qDdJ8gQZgKG/uUnYJHafiFROfeVOXTYRshUlybL1l4cekCkLSmNqaJzs4H7BhldjtMnrLcsEbsrWR2Xd/vjhk78ilad5VIenqJYqa6igHPP3RKR7B1CyWFSy0ggsY6TN28xbWroWcpSj0G0V40sCHQxjonNRx7kBb1P8+CrfgkYdlLlIvjd3PvvZOh83I90dOdpVbaOY3y41AY/pedr3sTyVrrSv20hCzAyhAgeFORQMPnaItkWII4KunJvn9xdOCrH7a5zSjulI/Db5n1Iy3HdpKFySoVHNVm77ZMlT6kX3Y4swTnaxf3DF1RWupoVyBTWnuVnMoOLgNBhq6DeoZ5EXrdRH/85RU2bs0rxDnaYyK2vWPEC1WVaRVCvCGbgtumJC3RkefpFZCwSwgFSXXWM47XsJrCqnSkn236vPURPu6f05sVNt+H8l8jtSlGum/oxcH+wCf1Jfx+IEcvoceutatN32F6DjT+OqX7INFJ3XTinqEIcrNH0BRmpAaM4eaggzZMlI0zUTiAj0+ivcwhs1cBXkd0zHitEvPa3YOcC31dJS0yVMSP7zndqeJr9E0KJxNyFQcbGgEyaNhTIWk4NtEM8jrVrF22K9WMqIXH77VzG6lU7qRGtolb3N4PknIKlQV5vj/kqzljd3odiEnxp3kd6/jXGbiGAIuB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDDMzeEIrVdDqnPeHooEUBnNtUNOMNB9fIJUE2MQf5pP9UHsQUxelkUKnLba?=
 =?us-ascii?Q?mJ6BtpbrGymPzeZ2ubbjyWnjVwFQ4JnIVjTvrg7Rw37Pv0qLo2QB/p3fiy3n?=
 =?us-ascii?Q?yO7I/dPO/bOHIG6tNANJofm9VqxLJ+UkYeRX3LTgGnhAfwdUpRERkutM9mWF?=
 =?us-ascii?Q?E9lAG7+S4KQpi87W0w3BawJGeapNo+G1Ecv3rPZGem7sAle6B3/BGlzQSN9Q?=
 =?us-ascii?Q?nPYsoLu80R+ktwk/mioELz4v79/qNCN+PeTv1AQKtMqjNjxdjmKAyFSFtV2p?=
 =?us-ascii?Q?FtZJXMuFhqU9suWeP4M6GAI9/rhhC3xoQpYMii/cZlWcL/z46Vt/ckenaJuJ?=
 =?us-ascii?Q?UW4oUHyVWne0BErJaG43412NB4SqAaO2yvYqYtF/axHUMGzT8aSDC/eoP9CM?=
 =?us-ascii?Q?bd9bS3YJy7Sp9UO2jb3WT+H02oJ9R/IO4xP/jw41sDdmdaTCGjKI84CmU6GU?=
 =?us-ascii?Q?pXrSAcomB3D6L8zqMWC4sD3T//Rim8/KQrRXIZjse+YAb2Zld1e66+sPNPaq?=
 =?us-ascii?Q?NGP+Epm3PQ2bvOpg/DUVPRg1RPXNLY7e3fquKqyZO268+YHD/Hh16OK1eN0k?=
 =?us-ascii?Q?3vFPFcTtI+3rJ7KaLpbhnCV20FfE3TZJEnj+NiuJ8A5L+nk/R0hoUa+UmKoM?=
 =?us-ascii?Q?5YOOLfEccm0IYb74H9PWRSFt2LIU85x0RVlcBz4g8vPZ+ufVcMPWzy6f8b5u?=
 =?us-ascii?Q?lJnrAFhwY+dprQwg9+skVI0BbCGWj1uEt+fFzWPzqYfGyUgq98d11NLPs1n9?=
 =?us-ascii?Q?dC0PvcckVazmfjfhJgxJRHvg9m8Y5Z6L2OBKi2xOBoga1elPNkFcQi+gTj43?=
 =?us-ascii?Q?wcakCtQoGOAMKgcmQ583EoJyZnmZb80SQ6zvZaQdbE1xEsPVC3jy3WOrE5LC?=
 =?us-ascii?Q?TvGssP5Xl96ICgEsDc9LwvvnuRTZhQSdSQ/UH7WdtQ2oX9W4sCXYsFGmH0jG?=
 =?us-ascii?Q?5xI9VPurhEx+AHCFSTanEQMRHBlfyqnpkZKCzXoxQZY9y+3sRt6XEnOWCiJ4?=
 =?us-ascii?Q?eLgSQVL4rvo0mp06i1O/YvWZVu44Ggz3iJZxaJRMs0svkfMlJWxmGgdFi+si?=
 =?us-ascii?Q?z8KWF1TPc2GTZ86yE4Ma4VE09FRgIV5gyRvdFGinOf4civlNrBVR/IRQrift?=
 =?us-ascii?Q?R6er2QqnVrA8HEDeAriJqMOa37cLieYf+tldtHWMi9wMlrNPwnm1WqHAzIYe?=
 =?us-ascii?Q?6UXTM0kb00c+UbvRcqrgWTbOwVbbd8YA9mY1glcnKUqt4kPIVyxJSy7iISqD?=
 =?us-ascii?Q?uoyHerfwAgeWAQXxfm6KNPIsX5vd7YcrnsvGf9LGD0H0muE7nN2u7fKuCcZt?=
 =?us-ascii?Q?wVD86a62W6rWItE1o53afN/IIaM+lwFT0aVlu2YmiveVrS7UDhGMgJFgXsIQ?=
 =?us-ascii?Q?zxjsYMiKLHYnc2Hwczs8aG1uTGJjC/OMWr0a/Jp9JkFS/Iy9Fcb+q521T9uJ?=
 =?us-ascii?Q?2n7CB6SIgweL2BrJZJGDZSL07zZDW/Oq8rhaBSLKqX6xEM1JngtZlWuQ07Hg?=
 =?us-ascii?Q?FXZ1sKLjj0NcwdKeV2lQQGAp05emufdmtQ72PYRMFMeL6b2qQD8KfmnLTWiy?=
 =?us-ascii?Q?tOr7E3T2PEDMQAeZ4qYyM9f4Fjdehr43vaBIgwKH7QS4h7BtB7W03jNNDydv?=
 =?us-ascii?Q?7aJKyfdRf11L2HIeUC13x9qJ1WeJ/qaN4kQjwpZHIf3CuY8EQz7St9W4zPjq?=
 =?us-ascii?Q?LbqhQq9s0dyF/54soTqp2NIkBGtBkK5k1bWfRizutvFZgiqULwsZdRzgVpeY?=
 =?us-ascii?Q?JsT7QmZXVU5FJrN/+ycUyYJ4cSd1/XJ+EwXBLnW7x5igDzKHJv7cjpCR0KPS?=
X-MS-Exchange-AntiSpam-MessageData-1: UhS6t9vHs5vu2PQIgqptrZfRuQ2UBE77CK4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c461c8f-2efe-43fc-586e-08dedcba0bd7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:55.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQTR1e1guXTQUhqHM+OOXyBwJXMmpX+All1f8vJXYlunpth9aIKumBHWuyPsOe1zvBQzdEBpFwozdziKp7EFg+bd0NpkE1jgfu0+KVwSkKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

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

Changes since v10:
 * Fix additional checkpatch warnings in patch 2 "riscv: irq_pipeline:
   add IRQ pipelining core" and 11 "riscv: dovetail: add core support"

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

