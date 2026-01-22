Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61773D1CBA
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077419; cv=fail; b=hv9Xwz9ynuAJ9Y3USmJhlwE0oNmGlO7pJADzvMD/t0amm/y2tdSIha/GWmTk0M1t6rtFbR3GgW8uDfH1Eu9p6RAns463r8ttS/wNN6/oJlWWUHiNpbkahMcME57QDhmTyl7ZJGdl+pKvYrUwyO2S4zEVinlYhdMoCeTyAkCFKec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077419; c=relaxed/simple;
	bh=rZtAxtaIH5tz/96QD+9SYsweDjPutmNZCaz1CLkPRb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKMCW0PQiFCnKKx88Vqj4DjHITGaIzoaTqw83FDbesCkaAJ1jDa27Urq9ct73eh/5emb9rn1BEEnl+XiXq30yzpPQj6ajGT7WnbaADqD2V71iSEeZVvdk3dDkywYlTzx9ceB5z+bgVsQFD9yottdC6XcS9TOHrr0dH80NvaeLls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nX5Oq8c/; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nX5Oq8c/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0bDma2okBiS/9ykCs8IXoFrHQSlqW3oLmn6RAmR5Qeckneli4lt9/BxToxPvPuzEoqpZkLIvEMgVNCEfGWVrpR9YOIUADPl12HEZwv6Q0nuXxNM1fAF4SNrGm5DmBn05D62UbDuP6tAp+799I/6yaAhXyYUQquPOazCbtFtmWhVXeGpgAPtwSuZHPkTxvFuo21unOf59vtknbjOp6oP8qTEXz5XDA/Iyme7LC4pHKK88f+LEFu7+1e0UlBEHZc2sfToY+9iGkfBC85+Oe8EmWEAsULTmwWzrFdnt3ahuK3u6AqyxDQtOlM5kjcsEQi2OVosAW8cS1h2qpdlHOaQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQRw+x/ItLfBIJuMIHZszKyZf5Ip4DrDZlSLe7mYeHI=;
 b=bfGOURTLE4ECQerQqFr8SRg32mjMEhrYM6H580Ea6QEN/q07kYNinEPB4ylKoQ3ChUsrxLBY6JUObn/Eh0sN6aQLdpup1gQMTrc4/ShsW36A5crt9lz2KAi4MeSxzamh9Hxmp40EEj2GFjlJsSq3rVc+dudmoVHGRJFmSd55QwyxCYegB+QUhQkB7WE/0thITJtMhy4d0XWs8Y80qzUbpeO+QJvVKfaXu1qXgJLIXF76lODW+p9ElYR4l7QMWWeLw7yBliPk9hgP/wTlv9lozpnLZKQgpXXCWNcagB0fo5OsPDMxqP9lSSRLMPSQNyDGZOCaJ6/2sXMBO+bB0QSrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQRw+x/ItLfBIJuMIHZszKyZf5Ip4DrDZlSLe7mYeHI=;
 b=nX5Oq8c/d1WweNotE9OPSIDkYfaIqv1vGG8wW28YD3sBtX8b5n+LVnXXIe1tbNdykdsLVgXh7eHR/sBADDv6lJVCjIeiRPBz+xlwdZpzi5VfFzgXppz4lNNTE9tT4c1px8620a5yDfhwRSrjLSoDK7T/yM4rHfy3nccf8Hmxx3NeiXuSyGPaw0pAXmGkFr5uq3RknkOM/k14WAP5nrZCKwP0o7RABIEdpoBXTQuUMsqz55jQpTOATENG7PZcnmpJgdVrPKnLfXfmqrYaXzs4PY3Q2Mygyh4KiiHVkjN2Zf7NLA0L22hU9LdnKwltUUQ5PbFIQ+zY2+6qihGWC2CHRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH dovetail v4 01/12] riscv: irq_pipeline: add IRQ pipelining core
Date: Thu, 22 Jan 2026 11:22:53 +0100
Message-ID: <20260122102304.421957-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb87eba-5ae6-49e1-4f8e-08de59a03f37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t7xkn7JDT8PRq5UcwOGo6MGaHDri62AyprqPMpMGHvS+3TxAQEy/ujJ0ZoI+?=
 =?us-ascii?Q?8wFjM0D1NKurcap7xVJjRb17efHDOeeoEzhGu0l9j0wGdQUUXrtcvOSNKO3v?=
 =?us-ascii?Q?akHt8rcMw6semHaVvCCefncev8MEesl5O/9hwwNqwMwSyNV9Spj9QC2vrl5e?=
 =?us-ascii?Q?caqkem9tJSD0lPV23UyFMOa22m1e75DIdedKrzEnLobWskg+mna49WB4wAAx?=
 =?us-ascii?Q?XZ4jW0QWq/0zLIs+rAVTc1d1RrlM0PR0bKYbeqflsZTCvhXrnsnW1ou1pC+D?=
 =?us-ascii?Q?pEtgYc/gTxcyZf0lhCh2DfPOziBLofnijdv5946j16MdoRFRxnHi05UdfQgU?=
 =?us-ascii?Q?dzXLTxjZB8RPBTVTXgXCSBtEsKBNvSlImBdRTQDQ4Xfbbrh0JgQcUQ4UiYCe?=
 =?us-ascii?Q?ebb0t+uk17QW+O/Gp1C8Gdat6Z8eat9i9zWSrEaTF6AaWJ/7/eF1czE9id9B?=
 =?us-ascii?Q?KUkiQAvFbETHz4D/teLSmqL9SJrYw8IkzSErpG/eLvSA2PtOvwp4iy9x4z7x?=
 =?us-ascii?Q?BW4M5yGeKYsqGOFbJOvbGPRa3gePp3SyRLj8Txcwdvm+7ew1ZuvMBiOYevZZ?=
 =?us-ascii?Q?hwOzBM6T5vK6its7L9xqPoZcxO0le2TRKOKe42wno7egM3rEQz/xdISQQGYZ?=
 =?us-ascii?Q?HG7T8No6EHyP3tTNxJZgM4k2FUI8SYx4AXRTilFBshEP0YHNfELrfRcMA3rU?=
 =?us-ascii?Q?9VVu9XYeSNbvDpv0Qt/vkbNDINFZ2ff2jtMrwAoePHNblgv4zZtigshwYrHG?=
 =?us-ascii?Q?nWkoYxqpdc1QmnJ5RThXjrbScV8B8Ej4GQnq6i8+J8Su3T8mXd2vwSYFEbES?=
 =?us-ascii?Q?nxzls5xoh0i1u5Uib2QA/0pZyaWZLuTWi+f/Ezpz9rdIPfPU57ZlnwWzFw1y?=
 =?us-ascii?Q?p/JnNb9Q6toQ15dsDp453Sri9wx7QFj8GHro+/cknBIeAlnGiY+yqU3i2Iht?=
 =?us-ascii?Q?Hc8rLg7E/qhD+LelreqjjFHlluleig2Wzx/p2JPYJTJhwFlo/DZXKJGpNlr0?=
 =?us-ascii?Q?srSHAl5ssK2lwyh7aIjTu+6en0uegvwyS8xfPhWaDRxz1m44KNupRezj545c?=
 =?us-ascii?Q?y0AEyC2D90+lRrpP98QViaE1JbmgQjiXw+dpsbj+UOIF1ePXkFCKCC2zmXR1?=
 =?us-ascii?Q?qfClG/Yoj6UUorifXfQEeMufS2crfYRlC+JR3nyOUsjTQ0TeUdgVAbP3LUfU?=
 =?us-ascii?Q?Pz7XXyoGBwy1QH4JiR/5Tjjic1I9tkhAlEIPnFC/8jBzGaetzgGNjLMgaz7f?=
 =?us-ascii?Q?RN8jZp44nzoMtaF4HMKXbgwQvs/7ySmZ9VQAiMBLETWnhcGScPE03FeUVkXJ?=
 =?us-ascii?Q?oCXGJ0mz9NSrvLkHrj6VcJ3KAciSe6E7OADeUwf00Mm6OmgK588s9GfT67fl?=
 =?us-ascii?Q?3xboWRZoowkFAs5uiqv4ZkaqD3G7/m9ASlx15Q/XNY4nwPTnCSf+503Y48W/?=
 =?us-ascii?Q?5ctsnTF2U2b8e9P2oWM8omNogyWYTCVzsBvwqRrfKXVz8nxLOQi33rrmL/6K?=
 =?us-ascii?Q?WcWIo2vSefucehyABzKYr9Pf2m0q5MIYhO6CzB+y3LD4wdj/rhmuDLeLCBwq?=
 =?us-ascii?Q?YuMyf6MZSjeK00pLI8I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UuoBYWf4fY1RpA/iR5fWRzGRKBKIcn4t6ns7FbVYJF+o3Dy3MD0Xd5d+7mC0?=
 =?us-ascii?Q?cUQM4ONRIiOu8N1P4bTExnS1bwDvVJgqHpc8Se2Wv2zSD1aXwzBfgzkpDVqb?=
 =?us-ascii?Q?bQhQ7+n3jv1CJ7ir/WbddR3BcuSX1pztafmABXRyAu/HWr5uFSnMmj198+6a?=
 =?us-ascii?Q?+4kuIWiO2yx5CQ47z1EQY+09WCx5yZS6uPdO8yp14+AoKYeHmlmrxfDnEL3Q?=
 =?us-ascii?Q?SX6C/Q5Ivw+Ix6GUNSAQW44MNH000uWBH1hrGrgU6FTImc/ionnDjt0tVSAs?=
 =?us-ascii?Q?Xyf4SiRcWocQTcgooBAEDgqJDYnEdRlQPh/tWDyEIclAueUt2pF5FwJEoi+8?=
 =?us-ascii?Q?zSN10OlfnVb/b4j1kRvBmvpufhWtXO0PmCxNvAF2y0tazYxku26EyB/JA7Oa?=
 =?us-ascii?Q?OB560TRTUDEAsSEelVVwMMOU2tDsVSlgSTwKLsDVdoCIFZMXZZ9KgFPzoWgS?=
 =?us-ascii?Q?HLSL0fOnI341HR8S3lai8bvmOLRK3RnYK1SEwAPab8xOQVDYXV3sow6JzTwh?=
 =?us-ascii?Q?SzvYKI9jXKXbJfygLysVc7Re4oxKgcQY4kP0W25EWkjXWInXQVu6Hf17Irsc?=
 =?us-ascii?Q?phA+ytuYNn2p7b1yORSkRlxvY0PMZN0R2uivGS3qHEeQgqk0ESfbvYyWneph?=
 =?us-ascii?Q?bpSTk0/WMUaHXevNqigvL3QeAQ2bZWpNT5xnPKqhONcs9yDB0hQkpi5eojiW?=
 =?us-ascii?Q?L+M8I9xxwojh2wX1xjfXluw9Kotz8OWNix3rE68BCV8bohBfi34GNM/bJP/S?=
 =?us-ascii?Q?ynwYusPFcZo53yx0mAUkdsRkSOqtnMaAHoeucKNoDuK+TA+UXNaYzQ7pn/e8?=
 =?us-ascii?Q?jJetvqX+ZqpeJq8W/Z+yY/AY5CtkcjXSS/yWyXpZ6BIkiSP5hOPNPwtNzV+t?=
 =?us-ascii?Q?fvWzkVYc6hDmMfiO5vRcnnbotWRTX+l5tGiEBn7i7WH05qQm0SG4WyHVI5XW?=
 =?us-ascii?Q?4ko2s0qVtiLY9+fDqfEyY0m+oQU+GgUAoxkrvdb4dCT6HuBFbU2Kf0Yu2Eeu?=
 =?us-ascii?Q?p4Y7laZTjvHQ+7ThznAcXgEnneCzPfyxmoNTG7G4Y9r9/99XsNMDirL+4yKp?=
 =?us-ascii?Q?QESAMHw+fWZ9f8QMZfaZYznQsToALWIgnsPCTURxOz1KONHXF/You8qjR4x1?=
 =?us-ascii?Q?DiXhYlAVLrpkgpNWvclEdHwLIrn/N+1mIuXtlO8li18C9ooFh5dKSe3YouNz?=
 =?us-ascii?Q?2qdR9ejJGHFrjIWR22wcB01aXJhRLpFyQJtFcJPN4yj0XqDmQ3f7PQDlGQzJ?=
 =?us-ascii?Q?P0qkwM+CylT1KHQIiuCQKibKOjHwTr6Q4AGiYO+dynQvmWVcfJh3I89LNog6?=
 =?us-ascii?Q?HaoGca5bhxwvFp5Beb5iamzTYvRYk8BK64muDvP5dv9flk9eitGnV7jBjlp8?=
 =?us-ascii?Q?VrdfCcnNo+nwvK9jZzHsKTMpXIx7kGjKqzDSsoxkpPYHvtOMoIG69dJ2FOfl?=
 =?us-ascii?Q?UB+c0mlwwdNtzNDTfVnQBS9MenuP1KbYiXbV9J0dy2nY9TChZoSQzHNEYn/3?=
 =?us-ascii?Q?DejqZtq4OZAe8UPLCRj/z/wJgWSfPLWYk5v24uz7L2jb03Ihg0OBbbMT7rlh?=
 =?us-ascii?Q?Qy3U/VYNed8RBd5FDW/RjkC8tFQO1PWd8SLLcP8QploAaKzDlUHufRyw0NAD?=
 =?us-ascii?Q?53gfv39ZUHkD3JL99M9zrJYkk5kE4RtZZT49Is+wcLgr0u9JoIkECnKZUoAp?=
 =?us-ascii?Q?uqLwiZmWmI9w/zR2wvKHTxHHT7IXpjtG5jf8i4EdRzkl3X8Gx7yfKyGCFnKA?=
 =?us-ascii?Q?RWx7EYNW0gDeJrlk6KxPaEtO9szYhWw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb87eba-5ae6-49e1-4f8e-08de59a03f37
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:12.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGE5VH0gGbgM129wdL+GaFYmZwNnthR8k8Th3N2zDrzGwd2qj94sachZTr2h/9XMNSz6W5i01xJx8DLSrKVFK4nLAvIRewRNg3pPxelmF4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

This patchset integrates IRQ pipelining into the RISC-V architecture,
bringing it in line with the Dovetail/IRQ pipeline model used on other
architectures. It adds the core pipelining infrastructure, updates the
interrupt and trap entry/exit paths, and adapts low-level primitives to
cleanly separate in-band and out-of-band interrupt handling.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Co-authored-by: shannmu <shanmu1901@gmail.com>
Co-authored-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/irq_pipeline.h  | 148 +++++++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h      |  32 ++++--
 arch/riscv/include/asm/thread_info.h   |   9 ++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/irq_pipeline.c       |  26 +++++
 arch/riscv/kernel/kernel_mode_vector.c |   2 +-
 arch/riscv/kernel/sbi-ipi.c            |  10 +-
 arch/riscv/kernel/smp.c                |  97 ++++++++++++----
 arch/riscv/kernel/smpboot.c            |   2 +-
 arch/riscv/kernel/traps.c              |  67 +++++++++--
 arch/riscv/mm/fault.c                  |  51 ++++++++-
 drivers/clocksource/timer-clint.c      |   8 ++
 13 files changed, 408 insertions(+), 46 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fadec20b87a8..e93a0b6f9f2b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -148,6 +148,7 @@ config RISCV
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if 64BIT && MMU
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
+	select HAVE_IRQ_PIPELINE
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
new file mode 100644
index 000000000000..c479ec44b3a5
--- /dev/null
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * IRQ Pipelining adapted from the ARM version.
+ *
+ * Copyright (C) 2024 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+
+#ifndef _ASM_RISCV_IRQ_PIPELINE_H
+#define _ASM_RISCV_IRQ_PIPELINE_H
+
+#define OOB_NR_IPI		3
+
+
+extern int ipi_virq_base;
+extern int NR_CALL_FUNCTION_OOB_IPI;
+extern int NR_RESCHEDULE_OOB_IPI;
+extern int NR_TIMER_OOB_IPI;
+extern int ipi_max;
+
+#define CALL_FUNCTION_OOB_IPI (ipi_virq_base + NR_CALL_FUNCTION_OOB_IPI)
+#define RESCHEDULE_OOB_IPI (ipi_virq_base + NR_RESCHEDULE_OOB_IPI)
+#define TIMER_OOB_IPI (ipi_virq_base + NR_TIMER_OOB_IPI)
+#define PIPELINED_IPI_MAX ipi_max
+
+#ifdef CONFIG_IRQ_PIPELINE
+
+#include <asm/ptrace.h>
+
+/* NOTE: Any bit should be fine as long as we don't hit SR_SIE or SR_MIE. */
+#define IRQMASK_i_POS   31
+
+static inline notrace
+unsigned long arch_irqs_virtual_to_native_flags(int stalled)
+{
+	if (!stalled)
+		return SR_IE;
+	return 0;
+}
+
+static inline notrace
+unsigned long arch_irqs_native_to_virtual_flags(unsigned long flags)
+{
+	return (!!native_irqs_disabled_flags(flags)) << IRQMASK_i_POS;
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+static inline notrace void arch_local_irq_enable(void)
+{
+	barrier();
+	inband_irq_enable();
+}
+
+static inline notrace void arch_local_irq_disable(void)
+{
+	inband_irq_disable();
+	barrier();
+}
+
+static inline notrace unsigned long arch_local_save_flags(void)
+{
+	int stalled = inband_irqs_disabled();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+static inline notrace unsigned long arch_local_irq_save(void)
+{
+	int stalled = inband_irq_save();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+/* set interrupt enabled status */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	inband_irq_restore(arch_irqs_disabled_flags(flags));
+	barrier();
+}
+
+static inline
+void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
+{
+	dst->status = src->status;
+	dst->epc = src->epc;
+}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	return native_irq_save();
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	native_irq_enable();
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	native_irq_disable();
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return native_save_flags();
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	native_irq_restore(flags);
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+#endif /* !CONFIG_IRQ_PIPELINE */
+
+/* test hardware interrupt enable bit */
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+struct pt_regs;
+
+extern void (*handle_arch_irq)(struct pt_regs *);
+
+static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+}
+
+static inline int arch_enable_oob_stage(void)
+{
+	return 0;
+}
+
+#endif /* _ASM_RISCV_IRQ_PIPELINE_H */
diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 6fd8cbfcfcc7..c3087b74752b 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -10,45 +10,57 @@
 #include <asm/csr.h>
 
 /* read interrupt enabled status */
-static inline unsigned long arch_local_save_flags(void)
+static inline unsigned long native_save_flags(void)
 {
-	return csr_read(CSR_STATUS);
+	return csr_read(CSR_STATUS) & SR_IE;
 }
 
 /* unconditionally enable interrupts */
-static inline void arch_local_irq_enable(void)
+static inline void native_irq_enable(void)
 {
 	csr_set(CSR_STATUS, SR_IE);
 }
 
 /* unconditionally disable interrupts */
-static inline void arch_local_irq_disable(void)
+static inline void native_irq_disable(void)
 {
 	csr_clear(CSR_STATUS, SR_IE);
 }
 
 /* get status and disable interrupts */
-static inline unsigned long arch_local_irq_save(void)
+static inline unsigned long native_irq_save(void)
 {
 	return csr_read_clear(CSR_STATUS, SR_IE);
 }
 
 /* test flags */
-static inline int arch_irqs_disabled_flags(unsigned long flags)
+static inline int native_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & SR_IE);
 }
 
 /* test hardware interrupt enable bit */
-static inline int arch_irqs_disabled(void)
+static inline bool native_irqs_disabled(void)
 {
-	return arch_irqs_disabled_flags(arch_local_save_flags());
+	return native_irqs_disabled_flags(native_save_flags());
 }
 
 /* set interrupt enabled status */
-static inline void arch_local_irq_restore(unsigned long flags)
+static inline void native_irq_restore(unsigned long flags)
 {
-	csr_set(CSR_STATUS, flags & SR_IE);
+	if (flags & SR_IE)
+		csr_set(CSR_STATUS, SR_IE);
+	else
+		csr_clear(CSR_STATUS, SR_IE);
+}
+
+#include <asm/irq_pipeline.h>
+
+static inline void native_irq_sync(void)
+{
+	native_irq_enable();
+	asm volatile("nop" : : : "memory");
+	native_irq_disable();
 }
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 836d80dd2921..9e4c9b884b5a 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -52,6 +52,10 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+#ifdef CONFIG_IRQ_PIPELINE
+	__u32			local_flags;	/* local (synchronous) flags */
+#define ti_local_flags(__ti)    ((__ti)->local_flags)
+#endif  
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
 	/*
 	 * These stack pointers are overwritten on every system call or
@@ -121,4 +125,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #define _TIF_RISCV_V_DEFER_RESTORE	BIT(TIF_RISCV_V_DEFER_RESTORE)
 
+/*
+ * Local (synchronous) thread flags.
+ */
+#define _TLF_OOB		0x0001
+
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f60fce69b725..e4be4ae40b30 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
 obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
+obj-$(CONFIG_IRQ_PIPELINE)	+= irq_pipeline.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
 
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
diff --git a/arch/riscv/kernel/irq_pipeline.c b/arch/riscv/kernel/irq_pipeline.c
new file mode 100644
index 000000000000..4eeb4394434f
--- /dev/null
+++ b/arch/riscv/kernel/irq_pipeline.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IRQ Pipelining implementation adapted from the ARM version.
+ *
+ * Copyright (C) 2024 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+#include <linux/irq.h>
+#include <linux/irq_pipeline.h>
+
+void arch_do_IRQ_pipelined(struct irq_desc *desc)
+{
+	struct pt_regs *regs = raw_cpu_ptr(&irq_pipeline.tick_regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	handle_irq_desc(desc);
+	irq_exit();
+
+	set_irq_regs(old_regs);
+}
+
+void __init arch_irq_pipeline_init(void)
+{
+	/* no per-arch init. */
+}
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 99972a48e86b..c4444577449c 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -171,7 +171,7 @@ asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs)
 	struct __riscv_v_ext_state *vstate = &current->thread.kernel_vstate;
 	u32 depth;
 
-	WARN_ON(!irqs_disabled());
+	WARN_ON(!hard_irqs_disabled());
 
 	if (!riscv_preempt_v_started(current))
 		return;
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 0cc5559c08d8..176f4ad3c427 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -12,6 +12,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <asm/sbi.h>
+#include <asm/irq_pipeline.h>
 
 DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
 EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
@@ -57,7 +58,11 @@ void __init sbi_ipi_init(void)
 		return;
 	}
 
+#ifdef CONFIG_IRQ_PIPELINE
+	virq = ipi_mux_create(PIPELINED_IPI_MAX, sbi_send_ipi);
+#else
 	virq = ipi_mux_create(BITS_PER_BYTE, sbi_send_ipi);
+#endif
 	if (virq <= 0) {
 		pr_err("unable to create muxed IPIs\n");
 		irq_dispose_mapping(sbi_ipi_virq);
@@ -74,8 +79,11 @@ void __init sbi_ipi_init(void)
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, NULL);
-
+#ifdef CONFIG_IRQ_PIPELINE
+	riscv_ipi_set_virq_range(virq, PIPELINED_IPI_MAX);
+#else
 	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+#endif
 	pr_info("providing IPIs using SBI IPI extension\n");
 
 	/*
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 5ed5095320e6..ab404da52b46 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include "linux/compiler.h"
 #include <linux/cpu.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -21,6 +22,7 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irq_pipeline.h>
 #include <linux/irq_work.h>
 #include <linux/nmi.h>
 
@@ -28,6 +30,8 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
+#include <trace/events/ipi.h>
+
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
@@ -37,7 +41,13 @@ enum ipi_message_type {
 	IPI_TIMER,
 	IPI_CPU_BACKTRACE,
 	IPI_KGDB_ROUNDUP,
-	IPI_MAX
+#ifdef CONFIG_IRQ_PIPELINE
+	OOB_TIMER_IPI,
+	OOB_RESCHEDULE_IPI,
+	OOB_CALL_FUNCTION_IPI,
+#endif
+	IPI_MAX,
+
 };
 
 static const char * const ipi_names[] = {
@@ -49,8 +59,21 @@ static const char * const ipi_names[] = {
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
 	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
+#ifdef CONFIG_IRQ_PIPELINE
+	[OOB_TIMER_IPI]		= "OOB timer interrupts",
+	[OOB_RESCHEDULE_IPI]	= "OOB reschedule interrupts",
+	[OOB_CALL_FUNCTION_IPI]	= "OOB call function interrupts",
+#endif
 };
 
+#ifdef CONFIG_IRQ_PIPELINE
+#define INBAND_IPI_MAX (IPI_MAX - OOB_NR_IPI)
+int ipi_max __ro_after_init = IPI_MAX;
+int NR_TIMER_OOB_IPI __ro_after_init = OOB_TIMER_IPI;
+int NR_RESCHEDULE_OOB_IPI __ro_after_init = OOB_RESCHEDULE_IPI;
+int NR_CALL_FUNCTION_OOB_IPI __ro_after_init = OOB_CALL_FUNCTION_IPI;
+#endif
+
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -63,11 +86,11 @@ void __init smp_setup_processor_id(void)
 	pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
 }
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
-static int ipi_virq_base __ro_after_init;
+int ipi_virq_base __ro_after_init;
 static int nr_ipi __ro_after_init = IPI_MAX;
 static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
+
 int riscv_hartid_to_cpuid(unsigned long hartid)
 {
 	int i;
@@ -95,7 +118,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	atomic_dec(&waiting_for_crash_ipi);
 
-	local_irq_disable();
+	hard_local_irq_disable();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_has_hotplug(cpu))
@@ -112,23 +135,6 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 }
 #endif
 
-static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
-{
-	__ipi_send_mask(ipi_desc[op], mask);
-}
-
-static void send_ipi_single(int cpu, enum ipi_message_type op)
-{
-	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
-}
-
-#ifdef CONFIG_IRQ_WORK
-void arch_irq_work_raise(void)
-{
-	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
-}
-#endif
-
 static irqreturn_t handle_IPI(int irq, void *data)
 {
 	unsigned int cpu = smp_processor_id();
@@ -169,6 +175,45 @@ static irqreturn_t handle_IPI(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+void irq_send_oob_ipi(unsigned int irq,
+		const struct cpumask *cpumask)
+{
+	unsigned int op = irq - ipi_virq_base;
+
+	if (WARN_ON(irq_pipeline_debug() &&
+		    (op < INBAND_IPI_MAX ||
+		     op >= IPI_MAX)))
+		return;
+
+	/* Init oob ipis at first involve*/
+	if (unlikely(ipi_desc[op] == NULL))
+		ipi_desc[op] = irq_to_desc(irq);
+
+	__ipi_send_mask(ipi_desc[op], cpumask);
+}
+EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
+
+#endif
+
+static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+{
+	__ipi_send_mask(ipi_desc[op], mask);
+}
+
+static void send_ipi_single(int cpu, enum ipi_message_type op)
+{
+	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
+}
+
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
+}
+#endif
+
 void riscv_ipi_enable(void)
 {
 	int i;
@@ -204,13 +249,17 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 		return;
 
 	WARN_ON(nr < IPI_MAX);
-	nr_ipi = min(nr, IPI_MAX);
+
 	ipi_virq_base = virq;
 
 	/* Request IPIs */
 	for (i = 0; i < nr_ipi; i++) {
-		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
-					 ipi_names[i], &ipi_dummy_dev);
+#ifdef CONFIG_IRQ_PIPELINE
+		if (i < INBAND_IPI_MAX)
+#endif
+			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
+						 ipi_names[i], &irq_stat);
+
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 601a321e0f17..9cdd5908edf4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -248,6 +248,6 @@ asmlinkage __visible void smp_callin(void)
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
 	 */
-	local_irq_enable();
+	local_irq_enable_full();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 80230de167de..44b627d762f9 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -112,10 +112,36 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+static __always_inline
+bool mark_trap_entry(int signo, struct pt_regs *regs)
+{
+	/*
+	 * Dovetail: irqentry_enter*() already synchronized the
+	 * virtual and real interrupt states for us. If running
+	 * in-band, we may re-enable hard irqs to allow oob events in
+	 * while we perform the regular trap handling.
+	 */
+	if (likely(running_inband())) {
+		hard_cond_local_irq_enable();
+		return true;
+	}
+
+	return false;
+}
+
+static __always_inline
+void mark_trap_exit(int signo, struct pt_regs *regs)
+{
+	hard_cond_local_irq_disable();
+}
+
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
+	if (!mark_trap_entry(signo, regs))
+		return;
+
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -127,6 +153,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+
+	mark_trap_exit(signo, regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -137,6 +165,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	if (user_mode(regs)) {
 		do_trap(regs, signo, code, addr);
 	} else {
+		/*
+		 * Dovetail: If we trapped from kernel space, either
+		 * we can fix up the situation, or we can't and we may
+		 * happily crash with hard irqs off. Either way, don't
+		 * bother.
+		 */
 		if (!fixup_exception(regs))
 			die(regs, str);
 	}
@@ -176,9 +210,19 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		local_irq_enable();
+
+		if (running_inband())
+			local_irq_enable_full();
+		else
+			hard_local_irq_enable();
 
 		handled = riscv_v_first_use_handler(regs);
+
+		if (running_inband())
+			local_irq_disable_full();
+		else
+			hard_local_irq_disable();
+
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 				      "Oops - illegal instruction");
@@ -373,7 +417,10 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 
 	handle_page_fault(regs);
 
-	local_irq_disable();
+	if (running_inband())
+		local_irq_disable_full();
+	else
+		hard_local_irq_disable();
 
 	irqentry_exit(regs, state);
 }
@@ -383,13 +430,19 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
 
-	irq_enter_rcu();
-	old_regs = set_irq_regs(regs);
-	handle_arch_irq(regs);
-	set_irq_regs(old_regs);
-	irq_exit_rcu();
+	if (irqs_pipelined()) {
+		handle_irq_pipelined(regs);
+	} else {
+		irq_enter_rcu();
+		old_regs = set_irq_regs(regs);
+		handle_arch_irq(regs);
+		set_irq_regs(old_regs);
+		irq_exit_rcu();
+	}
 }
 
+extern void (*handle_arch_irq)(struct pt_regs *);
+
 asmlinkage void noinstr do_irq(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4..d64d01874a79 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -25,6 +25,52 @@
 
 #include "../kernel/head.h"
 
+#ifdef CONFIG_IRQ_PIPELINE
+/*
+ * We need to synchronize the virtual interrupt state with the hard
+ * interrupt state we received on entry, then turn hardirqs back on to
+ * allow code which does not require strict serialization to be
+ * preempted by an out-of-band activity.
+ */
+static inline
+unsigned long fault_entry(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	flags = hard_local_save_flags();
+
+	if (raw_irqs_disabled_flags(flags)) {
+		stall_inband();
+		trace_hardirqs_off();
+	}
+
+	hard_local_irq_enable();
+
+	if (running_inband())
+		local_irq_enable();
+
+	return flags;
+}
+
+static inline void fault_exit(unsigned long flags)
+{
+	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
+
+	hard_local_irq_restore(flags);
+}
+
+#else	/* !CONFIG_IRQ_PIPELINE */
+
+static inline
+unsigned long fault_entry(struct pt_regs *regs)
+{
+	return 0;
+}
+
+static inline void fault_exit(unsigned long x) { }
+
+#endif	/* !CONFIG_IRQ_PIPELINE */
+
 static void show_pte(unsigned long addr)
 {
 	pgd_t *pgdp, pgd;
@@ -79,6 +125,7 @@ static void show_pte(unsigned long addr)
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
+	irq_pipeline_oops();
 	bust_spinlocks(1);
 
 	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
@@ -315,8 +362,8 @@ void handle_page_fault(struct pt_regs *regs)
 	}
 
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (!regs_irqs_disabled(regs))
-		local_irq_enable();
+	if (!regs_irqs_disabled(regs) && running_inband())
+		local_irq_enable_full();
 
 	/*
 	 * If we're in an interrupt, have no user context, or are running
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 0bdd9d7ec545..5345e4d373ac 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -243,7 +243,11 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	}
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_IRQ_PIPELINE
+	rc = ipi_mux_create(PIPELINED_IPI_MAX, clint_send_ipi);
+#else
 	rc = ipi_mux_create(BITS_PER_BYTE, clint_send_ipi);
+#endif
 	if (rc <= 0) {
 		pr_err("unable to create muxed IPIs\n");
 		rc = (rc < 0) ? rc : -ENODEV;
@@ -251,7 +255,11 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	}
 
 	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
+#ifdef CONFIG_IRQ_PIPELINE
+	riscv_ipi_set_virq_range(rc, PIPELINED_IPI_MAX);
+#else
 	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
+#endif
 	clint_clear_ipi();
 #endif
 
-- 
2.43.0

