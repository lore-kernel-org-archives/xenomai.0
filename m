Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46DE36C0CA
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042631; cv=fail; b=GY1HTELoxNwNwdqE4bh6XJ+mU0l9BZtUbZ1dOk8DO051dvQsfPsEKwvOBrQ66uLOGGtzu1ZLVVCLT3JpDKp9aM3dcPg9F3mWBN10hBg4Gk1KUYttIGIni5Fj/YhLqUNmPqdDyhbLWPGc61MtQeq0cEtNWhSgKxdVjIVIxG3Bvu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042631; c=relaxed/simple;
	bh=PR0Xy303bkiWN9ofcXrr4XdRAzIIkSUQco/K/vw+fzM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KbyF8SiDxUvq0qW2LlhzWrV3D17HLeM+jPb48U2PLUD2iRQ6pVwITnVpe5IMaLa4b5YRCRLaLQKqo+eIxcTMJiO1Tc7fVeNhFQVYquuvRJdoXdeFPW+rXA2WHH9GiQs4gJgtJLDjIOCAs5rWq1+SHktvYLFExcn/cOzGUubnMNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RlDB/Thp; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RlDB/Thp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1uyj6OTayHUMdEWR3DL5ich9duUT740wN+I/n3BFSxS0omxq0ZMeLElHso4TLY2xKV399Ecy7uOuftyJuJkkA6CaPqgSzU8zEhSWmxGeIrkLuekDMjMebJJ4JNrgAcsvXld/03VAxXLw00zcWNmBWGIPKogqY0Uur1Okz6YnSv6Rixyc6sQDIe5Ih/eCiBJ4qU39VxuHIxJP+8XhZXv8tf3oQZZ9xNiZScXeJyewGrdZCvGymVlsCbRqOHflWw8zU9iE6g/RxCszgJFd6YXmV1ec0J1Gy13CQVXecIc9rDF4+E+bglUQqpc4hrn3iuSavnb7c7xne/Y5cPWsVHbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12VKF8L8pqbMcytVPaHlaUgQF9aVBJpkkS4DjG8TNu4=;
 b=h8SqLq31U4GUeuM+msRVY0lRK/ijigb3q19rdTxjKTFbqBfkROG1qM5ata86qhXstAF8yk9c2Td/C5FAhhZuo8YDN7EfI50jm56jTRAWcWB7oFON6W8Qh15C1Gr7LiUFuPjsw6mZGQtnq2sXa3/V8rPc40qbRhZPnAm9dUreLHz+2R7ZGEYwCpPjQjn963l6UyfPzW2M/8ycGSxoDG4QhlN/1U+ra3MVJHwHYQTbYQmcrWjKRWE/81ZF0TpC1NmNhnOW0sEn+pjP9ELIworwQjRFzy1gfDvhkUzHVITgvCl8FAGttcvtFAhJ2SEg1Z9ZqQlwl8ZFSD9zqlTMrdDA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12VKF8L8pqbMcytVPaHlaUgQF9aVBJpkkS4DjG8TNu4=;
 b=RlDB/ThpOR/sVw35sO+1AQ1PRYyMe0S04iiTec2wYROtDIWmkEmIIbtMEXyMWX1a0sjz+AigTPJRTz/lGLcEM3DSdOdbWu2ISj9nzmn0RNPPuqTo0nlHE775/xPDgkAQUCm+47QoHs4b3u9YVN6Gy5JVf34/nBaU/d5/rdkvkUHXeC+mNSi9f362/phHjkZ+hzincP9eXjV26x9YtHXsoopF/LV51zIOW0fevqfC5HqmRBR18SvcsXYBvc9GaY+8YN8ToLmUifgCC5pZ4U1fy2+SbtRVofAQDLLTjBVOd/neaAh39YcGlmx2V0v2G5Dt6UxW80Ew7AsuwFzo1YWxXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:06 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:06 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 00/12] riscv: Add dovetail support
Date: Fri, 20 Mar 2026 22:36:45 +0100
Message-ID: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d55e430-aaf3-4739-a456-08de86c8d522
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	yT2QAVvaeXxucmAPD5utQL4FMqAExoZFoTZzb5oZ0mq5962+Kx8phGXYjL7FYYSDh/NmQmRTAz5J9qxctkhzTI4gnPMU8dti0foP5eSqsNTwvOBmwIl1GTIKX9tYlFykEjiCG5h018rAsr1FWiUwVU3/2cNAlWoC+X+kq4itaLzCksPAftVPdQNdnSpz5Dq68O+cSNUkeHza/4jlPFNVKJSgd/IP/uB2R1smhLQKw5cd6bMcAsZdNx8ldwZz6P79II1ewiOI9PpS68rllwB52GQs2lrRYuGmyfVn+ZysngbWpIdpckZeevRhzUjiLRrB9a8EFxaNmILL4SgT3tcZP/uC2kg2M7YuCEcT1LgEJKWJmghEQ/7a4QlzhnAS8gqFf4I5NmypXz4QNUwDauudbm52bYIQ+ABBgLd3490NjLlzDI/bZoGoOSkkaL1i9AdGGzqZ45iW1z86Mwx9wrYoPsPDuQK0nRjVCHRAPscyYDQORQpxxkgmD/E+ARhcb5gdpgT1win9LYYPhIMd4sgNN7dnWF7AkivOj6NoZzMxRkaBW2fQkC3H9qvSOIsljpKC7bcyt8zqO1zPJ+sYJowX9S8hUUF9sx0W9z+j+4EFxAmZKPzMDmijX/m3yMLNIQjHnYIcEz2EQBYa7gJiFUTOEny8ejoIuRR1k4+nYM4uyBeaLhVNmhlk31iJV9u78VWxA4g7Nw1XoEgG/Lloc+vbu2FlqI5p8DxWKi65UgyKYI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4HxW1/VeqFr5bxtdACbehXbQ2kaxu6ziNlfmtD+5BLgcQBzFmH1vMfk1NhK+?=
 =?us-ascii?Q?cHVuAvTbNOQVgcTIzutZZD5Ugjf5Pl60RQK+A4TIbdmwW9Tan+x0VW5munVh?=
 =?us-ascii?Q?XKPtW87K9/qJoTBDEtiuY6c2X7PDp00PtezUWuEmoDUfEbZuek8ABOtKrCr9?=
 =?us-ascii?Q?7pUYpcQDqEw1FNwoABFmQDKyiOc65iS3dUCeJ0XAxtYLrUcqkPtq3MgwiBK7?=
 =?us-ascii?Q?aIztd0nYbT2Hrd6o2fwWtoOxvlXS3lO1HFfmmi049tY0Q2/ITZ0WTx9X7Vy/?=
 =?us-ascii?Q?SB7Y/oDbM7qKc/LrparsKtZMSkFC4Q4E6ZOuILTjekceIBShOhYBZ+mPxt0X?=
 =?us-ascii?Q?iKXiSAnyA9Sub6rnNos/0rxXQc8p1pL1bXHKFnjHwKjBPkNswYXYPk0G5Vnn?=
 =?us-ascii?Q?++2xQ4kEqMOxCbjgG/YTw9J12Qsy0NmVlOYB8siFAhqNrqMbWdCOx+KYXmhQ?=
 =?us-ascii?Q?gOtDnFEeZMnIdCcLda600oVvox2t+/vA4LqfnJPIV+ipJ59b05W44hHoRc8B?=
 =?us-ascii?Q?wZVobjijQ8gcLjoMQcUgANgS1ShWHaspbIyHkUju9mLK8JPQEkDKTPgGl9UM?=
 =?us-ascii?Q?Csc+gjhzOO7V0PYjft/6Z/cJuebs6I04tFVkzYQ34itha9y8RCLaYnzbRXyx?=
 =?us-ascii?Q?Oix+FOsfTWDUb56kiQxddxmdc7rAZx1L4m16g5v13/jxNu26pboWRvY+qMOo?=
 =?us-ascii?Q?MylN/5MVOf9Cd0WhyNmF0lgOpR1RKY/9gmCH+/B4xYb3lefO793Z0pdH+SEg?=
 =?us-ascii?Q?cfTxQY5ZcaAqVF9hD8bonKxuQp0T2hHDvGd68zX0YgG6mvIX5sDgrycgYk57?=
 =?us-ascii?Q?6DXy914iwGysJCgA7MorpbgbM6tn3bjKNHPkFRrz3msMXyXBIHj6C7/w+DKc?=
 =?us-ascii?Q?2V6rdzjEY3xoBrvpttX6+ld8bhgJEIMLnrIjQ4Ju8IsD21BQ5DZsNnTtJqe6?=
 =?us-ascii?Q?gahcb9NA8puaQDw1swwN+1O+sVz9GsLAv3YWOc+X+S7FAaUwWGSVGpaT27JA?=
 =?us-ascii?Q?/UHRVFNSodN49jxeVZyydJXi+biA+GVsyKpcde3+3vgkaRofZYJpt4mouTYC?=
 =?us-ascii?Q?/uXix8Yaqx/h3LFtEijTczKo54DUz4bOLNyDo1JWSncc0hOgvNDJ9cvy1WKH?=
 =?us-ascii?Q?3513KVRLQLTKjeZja6UtjRshLRuHnXjn7LM5qMrfqvZkOLsbKuc4aBKuN9ra?=
 =?us-ascii?Q?L31B31ai6vrdt++JGwfxfT90Cq/9K9tSjNo5yxI6tS8h/ismBlSugRiiku5b?=
 =?us-ascii?Q?pYaWuwqOrdISANLC+CD4mlhbCqZd6gwtOOX34ufO7CjJ3xfS+TnEOTg2Qaug?=
 =?us-ascii?Q?ruWvAO/gYtnMhgYq4Lqk3m5OToFJ7cIv8yHxJggiQcZ29GStwSNEgxAFIYwJ?=
 =?us-ascii?Q?Hlgi6LRwWHLP/9RbnNFaCL9+r+5DnAOB46c7Xdoy+DyHpc3MuqUEH4Gp0f9W?=
 =?us-ascii?Q?5jyPbcnVvW5vZsw4kBEKjCw2eLP1Tm6qyR/r8ucBfIxTw1lJ6okYeJV8uw4z?=
 =?us-ascii?Q?b9wduNFrgZbAEoHyVAUi1+ohwSkPhAbKE5KSdiv5YJxuFrMhFXBfW+CglllS?=
 =?us-ascii?Q?iXmUVZoR9znYb1pvM0+mNRfDT0GCF29IuSNsWuYqHuhfHHUsyF93lp19Fjm0?=
 =?us-ascii?Q?IdcgM0sBz+ZFQO5pQdtIDNPH9TLrXtytvw+1mTBUroaHTl22+pO5p/5o+Iib?=
 =?us-ascii?Q?95bdlKppLPNmPP+m5/DFbMUZ/baj8yU2KSwEsCrZthpEGJI7euEqd8iffHCs?=
 =?us-ascii?Q?5FrkegmjyAtRQPXgu1Tv2EAB39PQy50=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d55e430-aaf3-4739-a456-08de86c8d522
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:06.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyisavrPZCS3xo7ocJj+RRK9V3Iqke6ij++SbDQCAds5aSLtE9dGZUdPNe/FYWtfUQWf8BNx/UnIqPDJxXaRH5kRK50DaGFj2AylsOEiASw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

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

Best,
Tobias

Tobias Schaffner (12):
  riscv: introduce raw console device
  riscv: irq_pipeline: add IRQ pipelining core
  riscv: irq_pipeline: enable hard IRQs during in-band trap handling
  irqchip/riscv-aplic-direct: enable pipelined interrupt control
  irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
  irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
  irqchip/irq-riscv-intc: enable pipelined interrupt control
  irqchip/irq-sifive-plic: enable pipelined interrupt control
  clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
  pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
  pci: plda: irq_pipeline: enable pipelined interrupt control
  riscv: dovetail: add core support

 arch/riscv/Kconfig                            |   3 +
 arch/riscv/include/asm/dovetail.h             |  23 ++
 arch/riscv/include/asm/irq_pipeline.h         | 145 +++++++++++++
 arch/riscv/include/asm/irqflags.h             |  32 ++-
 arch/riscv/include/asm/mmu_context.h          |   2 +
 arch/riscv/include/asm/smp.h                  |   7 +
 arch/riscv/include/asm/syscall.h              |   6 +
 arch/riscv/include/asm/thread_info.h          |  17 ++
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/irq_pipeline.c              |  26 +++
 arch/riscv/kernel/kernel_mode_vector.c        |   2 +-
 arch/riscv/kernel/raw_printk.c                |  33 +++
 arch/riscv/kernel/sbi-ipi.c                   |  12 +-
 arch/riscv/kernel/smp.c                       |  55 ++++-
 arch/riscv/kernel/smpboot.c                   |   2 +-
 arch/riscv/kernel/traps.c                     | 202 ++++++++++++++++--
 arch/riscv/mm/cacheflush.c                    |   5 +-
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
 28 files changed, 593 insertions(+), 69 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c
 create mode 100644 arch/riscv/kernel/raw_printk.c

-- 
2.43.0

