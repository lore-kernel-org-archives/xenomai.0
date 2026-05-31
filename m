Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7987DA66
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206796; cv=fail; b=YP0WN0FksfdTPChQM+Afwvg5GzcjRuac4w4orQ116frZetwkfnILTAmEnvUhc/igN41Sfnn6Npg1MdWrObcz7LP18lHqehWEabUew6HzIzTt0g1BSKZSB5zf3SJ1DLnL9Drn9AzXKglq7ucV5Qt/+p21zLoKU+7p8XE4qEDl2gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206796; c=relaxed/simple;
	bh=6idpf5uQKJmK7bUIjnLRMQ5BV/qmpX9GaaS2uV8ktKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DVjVTSoRVJp1Jzu20YQdVgq2SWsQWvfcfUVNjn7TY6kztXK7CXRRXvp0d2BkYGY5NOZBuqP2vMdI91dQQo5UPp+H7r2YuTNOuZz02E4cnhM404vM25Jh1Iua03jFBOJJyafv8ZL+hqPG76+HqeKkxb8MigEU0LgubA+q+jQGRP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LZpJM0dN; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LZpJM0dN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5syocTS9Spc6ll8/n2+P6MYqrvNWuEGMEG93h+QufXxomZ01aKl6ynRZ+D3wMKcnjTccWES7XNne93nx50ATKH6v8dgeoK8I7UM+JCb7/YUUkrP4dQoIU9EIuWGaLUgGUU4Ww2wt8No2cb9wX8ILgl+6hUrjC3jpVeyFkC2GQzOwGUS2kLxYppTUSQn4MAGfurVd2fqFOz8IpX7yXkB60jq3TfxzZ1I9mVFPi0F5zjC4sgofv+fJ04d9OAY/vPDlB8cUonDlZkfcE366q7SPGlHAxiC3gi10gbpReaefRorzbu6ohiiWS189ZIaIiMLkX57y4uYdtVYC+C5fPMGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4KisJTH9kkfKu9tOqntnosTE2h6wXqbwdNbqf6j5jU=;
 b=kHma40GLwFuBSyKi70V3IuY1hLjHLDqfM8qCO9gCEFW/Kz9G7LVksYxVSsngSQUMjQG/oG9Abg6Ti0W2xbh21fV2pMYguTL49zZJIMOz8O5Gjrtpl/xaXYYFXSDC7hbdCWhleQxiugc6+lW2ET5U6HXlWZ4Aol5yONSHlfu1/QHP/GIcs1irMpaE2LFDOPuSZNSIeHsCnGmtc9/G4nzwLqiV2L0tRHE3PSvTyYqbkqjkJZTQNhfGgZlaWeesKI937lGY+wQ1edWkzZmL03ddQzsfgI4lf3uGLikd2DwlDw0By+SK+RDZrObxBYfiIZ2mxNY1SeBU/FAcZE59uiK/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4KisJTH9kkfKu9tOqntnosTE2h6wXqbwdNbqf6j5jU=;
 b=LZpJM0dNoQpxwdHdfiq6Eyxp0d1Yy0lr7C486DT78fUEPIEEJnq4SgbtS/98lb7Qf8g12U2XH5DJ3NvM4608yi/W4tE4/U7/If8GgTf5o7oL8YoCaJSxnd7rb5hNIDtKRvAmNgHHs4bHHeG/u8HVr7K0s3p8xN0Rl5MlkqHPHIWFTj2cimCbeNNd2YxMhlJTXV+ZIZRed0oeckGRlYTTRIZ4GNSLI3fdT+7urBW+KE8QJtHBcfrwf3UTul68rCzycrpAKY59oG54k9t00prxy7Fpj0UP55ALA+MApwwll0AvXGheMAPkBc8rs7IzL0c+7A77DTg1AoZiT0IUN6nvqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 00/11] riscv: Add dovetail support
Date: Sun, 31 May 2026 07:52:53 +0200
Message-ID: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9a735c-7eab-4715-8a04-08debed8e66b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	vVWTkHuu8eh80N4hg4m16KaYZnniVehfYPfRbA79OEVqkEnaCsW50ui+Jylm+RbSnEePEIHq/TO30ZvFurNuY4l8VZ4/g/Afc3p0ORxZDUJgeS8JNSo8+EVI4egIHpLD7w432i1oQb4qs8j9WQ+IvxIarhwGGGI+lcdmMgOiMU9ITLkm8a6hwtOLY5bU3RSKobmT/a9j5gV37StjC9LiPf/I06uRTRem+kAkcfSr6Aq9vcnplVEPU58sTnIG3uBwK3zwh9ea/NpeXSh9x9nK310bwBrdIlXXHLfbk0cfBgG6j8wbtzv9Zd/jipDBFPTrPreKDpgx1z8MvnK8kCiU6ImskkVSQj7UkoX0D4scmVWx+aNmHbbi8+kO0Swmr+5Bhou/Y7VGLrm8s69ukiatw9bdXL5H1n8B1EyxCKg68lpKmYcs1FHwfnXpD/cb/dLKRtwrjzAJGfVIe1lomR4wOELle0+gySEw4uSZaoyQ9CYQ7oOI6vkp2ck3Cwuqdd42suxqfhHzuoYIwEJI0UaJ6BVMYqcDApyY6dCldPusZR20t3s7pVpksCZgVLeztYq6Jw29eo5wGFAMJ+62sipE6QH2W1+TJnpXkQ6QaSfgikDVAZ9aaU2mkHLHzJgbrItk1hLJkNQ+XJ5hdbHtwtpjh5mtbuOgN+3nAfAcVFlK3E7eIqkTAhfQ8bsOFBCz5wSLF5V5q71xymFuleptvID16A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dIHskQa8essJY+gd0YOnp0+B5LuJs06SWumc9BnC0APoqO4hzYzC8Yw+mV0N?=
 =?us-ascii?Q?MLFLOH3lK7XnK8wxY3gImvhgb1DX+AxMk5gVgiia0AY4IEMA0VsBjio3k8G1?=
 =?us-ascii?Q?wDFfHX0umcKbIi6qQ2Lcp7xHSuGzweDxTfCxCNTk8XmxG5Qfhp6YGg+XxM42?=
 =?us-ascii?Q?QHhB1ox07tVOzHzChmFYujmKpNsCvqp4oNuTi1TdDkFNK1pvChYxMd/gcbEa?=
 =?us-ascii?Q?p+EGChn8i8v6TkvtsAOGxmI+lrZTO+3jnq3T7CK/GPQZqbp4Gv5E0ZZ1yhYJ?=
 =?us-ascii?Q?a+/++q4PtfOrDpJryMur6YRR4Fis3/ij5F+AL4OMaHKfDL/VMyE7ngCN2066?=
 =?us-ascii?Q?7yJ/hExGto2XG8pMiYY1AATlDInQ6NYto3gag0H9cnchMz0lRdgqLFPst+st?=
 =?us-ascii?Q?q6/tk2MCVA9MXssDo2jkKLGRf8j1ip0UN4xBs/w6NIscN7za+NJkHsOY4O2l?=
 =?us-ascii?Q?0YQss+lVvpBG7bkOUg0ouy+2oYNxmN782F9PFoqS/DJx0Ab5cvew4h5qxlUJ?=
 =?us-ascii?Q?JVGV+EQJ8W9f+irBHXAjGPwcaGPvPyw4cGyKbLVqlNJX1rpF8+V3VY0pDNLu?=
 =?us-ascii?Q?863sMGpSSZSF2afAJhzZH+9HBJvI4OtgJLGsbrlmezZiEVsbeDy0PhWFpKuZ?=
 =?us-ascii?Q?/iouT0kCg9g/dGXKlct1hKR95ANX1tP61xapmXSJm7VwTq2VvfU4dqXv/ERq?=
 =?us-ascii?Q?GlfEDSH7FA6AtDMQCcdFnVKdt4+SNEKLEodTufwuaRSdAcFY+h/03D2dtenW?=
 =?us-ascii?Q?iqwuAbV0wyu8L8XSqhBBtzENZkXb85+6JzfbN5tlNBh4+yqbF7iV7jpMCicl?=
 =?us-ascii?Q?WPAc6jd8zu5r43Thi7CtnbFsN5M4psPUQaOuXf6ULTyZNiLDq7ZswnOECM3X?=
 =?us-ascii?Q?N4tDf3UTpI3wlslwo+yY2SXSaLrloatVeMzG0tZ3cIxxHuFe4iIOiz2aw9zl?=
 =?us-ascii?Q?BkIobN0gGpoL5ZYv77uXfOSP7a2l2mpF4Y3+x4z4f3YTomoqDGtErFNvla/E?=
 =?us-ascii?Q?oZLGTgsFQCl3wIkVqQyW1fuiWue01COrUmsJ/ymsyysPQ1kf8Nr7jwDXrI3X?=
 =?us-ascii?Q?vD6rkDE2STj46mf1512o1I9WbALe7l6LJ5TQHmsWiF99+sfFdQXloIjPl5rb?=
 =?us-ascii?Q?2bgw6TcnCc8LzdoDWB8n5i8sRzaEOtGO3v4Xh8JLh1gv4+p/f1ktv+Ex4msW?=
 =?us-ascii?Q?yEU4oUawwzvUkMlRclVh0TfcnPvdm0RxerQqX5EzqGsSS4nKR5s8uE1ygnKp?=
 =?us-ascii?Q?JsCRBxiSFbqM9MK1zratCAmZc55eZ4PeE65Vd5a1muyKT6XbUVlKXBeOcgtc?=
 =?us-ascii?Q?VBUw+URHNPsa74xS3Jf+GMQ31LOBb88qiqmlChLDRhusV5UhCQzO1vNeTQo6?=
 =?us-ascii?Q?npJENped491djQKK/LRUAC0idQPgmvZvmWBjEq6LFJwJnfrhPYfWigibm/xO?=
 =?us-ascii?Q?fMfzvW4zMvDVuhiCOyFeNqo++lc9DPpbqEUtrO41DKP/n2Sq9FZA48ENtdu9?=
 =?us-ascii?Q?ZXgKuu+m+jv3twMeWoZucW3H5RIqJUagKE+CnAeYaF5mApYJJkzX4GPAEZ//?=
 =?us-ascii?Q?87JGyym4l8CCHOAI6XVr/nOQXV678ySjAo5XA63D4020yxaxfZQsPExQ+3ag?=
 =?us-ascii?Q?rx+6RgkhL8AAxXZde47i7EWWQvgxEHhT41Vi1wjkHz1UleYSQEBTYnptn3fz?=
 =?us-ascii?Q?udmlzUrqSrlTTZBXhHq048XrFBN1skZNngpGWXWOe+GI08bz/hhoNTV0FGlC?=
 =?us-ascii?Q?RjcTlTZTbpFBe7h3N+6wIX9FCNIoQuE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9a735c-7eab-4715-8a04-08debed8e66b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:12.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYNCg9sIaYyX1z3Hk0GZg2dFvpY7NKnX3c7ozOSpAQDd+GW5tCUdcrHgd37ludS3AYOSPFx25uqwzGDdLFTtwen/1tGE6xoUsxG7m3LltIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

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
 arch/riscv/include/asm/irq_pipeline.h         | 143 +++++++++++++++
 arch/riscv/include/asm/irqflags.h             |  32 ++--
 arch/riscv/include/asm/mmu_context.h          |   2 +
 arch/riscv/include/asm/smp.h                  |  25 +++
 arch/riscv/include/asm/syscall.h              |   6 +
 arch/riscv/include/asm/thread_info.h          |  17 ++
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/irq_pipeline.c              |  26 +++
 arch/riscv/kernel/kernel_mode_vector.c        |   2 +-
 arch/riscv/kernel/raw_printk.c                |  33 ++++
 arch/riscv/kernel/sbi-ipi.c                   |  12 +-
 arch/riscv/kernel/smp.c                       |  56 ++++--
 arch/riscv/kernel/smpboot.c                   |   6 +-
 arch/riscv/kernel/traps.c                     | 169 +++++++++++++++++-
 arch/riscv/mm/context.c                       |  20 ++-
 arch/riscv/mm/fault.c                         |  29 +--
 drivers/clocksource/timer-riscv.c             |  11 +-
 drivers/irqchip/irq-riscv-aplic-direct.c      |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c         |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c    |   4 +-
 drivers/irqchip/irq-riscv-intc.c              |   2 +
 drivers/irqchip/irq-sifive-plic.c             |  10 +-
 drivers/pci/controller/plda/pcie-plda-host.c  |   2 +
 .../starfive/pinctrl-starfive-jh7110.c        |   2 +-
 .../starfive/pinctrl-starfive-jh7110.h        |   2 +-
 27 files changed, 578 insertions(+), 68 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c
 create mode 100644 arch/riscv/kernel/raw_printk.c

-- 
2.43.0

