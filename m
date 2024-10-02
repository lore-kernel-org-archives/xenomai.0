Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7421E764D
	for <xenomai@lists.linux.dev>; Wed,  2 Oct 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865629; cv=fail; b=FX7w7/S6wQ/axgH4peDxj29bHxl/AeZGQzNk5eb78dUAsOHBUAX/teLrbevNAxu9wGtLTnpaz8iMS3vLvVvSFwzUUiX+1dsLHDihfKWU2E1sxNQyscc26kigZHvt81qcwC2p0vQffril0Ava9BxThqgN3Wf6CEFoH5IQkFuG/8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865629; c=relaxed/simple;
	bh=6I6OXBehCbpFaR/KbYN4a/PQiVXb4z7421dy201iso4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qUsU2l5xUBH/3WQXW/WrODWQSnrUeRgGWR4tHFektS9QLvxsoBcABRstVD6I5PNP4df5tXMHGWV8WiBwNV76rhoZVCuCVWJDljwFxmUYhwxZ9+81TeAxW5+/xMMlIBVjT5xMiARVMW4NsfJQfkV52KJaPOOWRY0Go+WrIPfmCiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=opKmhnhh; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="opKmhnhh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ69vz21CkUuGp6oe1Msvpkq1dhntKUe/ZpzyW8xwAvsdnQgua3AQa8LkkjmErsUocm0bSXCWvgEmC4I/h0QXLoaD6rn1iiKSVXF9sD9gOg+pmwOg0E0X92ykqvY2GFtLu31VdqgUe8unNwthUw6vVUwdpSWBV6VtMJMaIX0xDgDu9DwJ9fRifCy3eSrX9mhSN9lSgoCfLB2RIZWicoUrkXTHtunQVe70YPi7qyacm9b9E+M7/VAwwTPrlFkJJL0ltE+POurLaw6MF8LP9iVWJtXfaUH+SeFobA9sYrEeL0smN5EQT+UvYc8IxIZV0mtk97fkUTxBeipmMS5fVjBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWSxecj7P/Ld3vnaLDuydoTnyEIPftcBMyrSvXM4fnE=;
 b=dRPbDv7qWKftkiw24octy58ZyHLfrNMrLmLlQmqRkxN0DWtHT+irS6ZYj7F+RXr7/a9WxBKC0Gjxb1wjEng/KFqQgPuZAx3ISomfY4Gfcl2qGg4Lr0WmWNtYwOilQlY6BtmtNjO5lExeuQai0WKrORASY3RTj4y9qWogshD7WHypE2h7PPLD5pghQs4WQZhQJdF0k4T+KAJY5wEyPB7Miqh4h3/WCaNNJjO+FbrO5PCHKHV6MOwcTrrpD47KflIn3jzPeZWi+cv9hzUItTF8WuqqaKyGClvqDKl53kx3R6X2/mRo4Nqiro+Xow8R8B67Z6H3Yil8TmN4W1+pTNxu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWSxecj7P/Ld3vnaLDuydoTnyEIPftcBMyrSvXM4fnE=;
 b=opKmhnhhqv5DSb4+vG5/sVueuvF3RG0viFN7l1QAa8Hnpv6TSFDPB4myKyY+eX7/NeYvzL46VOebrT/LRXqsWEJVv2KNCeV0hdv+skl22ULnXHhvB9TTJsxvfS98s2C/F20tyqfpXc6M9unoZsb7Tc3P7JEn1YiNkE0B36r+xzHFgxd1QOuo9UwOWJ0h5eho9mk47RMAiA0h2hZ9AK5cj57aBNFI/riK8Qj+9kBi8USRlnINYzxpIZqHAFFg4nMIFakZ5sOiZhMxuOeRW/rlJaN4lOTrBZBiBYnG8rbcOkQ5457DAAibHZp6Q3reMy3he9lXtrhEqZTif3qJVPPYtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM7PR10MB3908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 10:40:19 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 10:40:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 6.11 2/2] RISC-V: irq_pipeline: add IRQ pipelining core
Date: Wed,  2 Oct 2024 12:40:07 +0200
Message-ID: <20241002104007.991278-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002104007.991278-1-tobias.schaffner@siemens.com>
References: <20241002104007.991278-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AM7PR10MB3908:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9b36c7-cfb0-4bf9-c981-08dce2ce9c6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VM8+a87r528niD/y6aHCQas0XAX6OaKbSakWsZqzCCOvnjZ6TA6a5gOoWh+n?=
 =?us-ascii?Q?rDkBSIwdptpnuHzjHkVQLHsFsQOubCC/rUTs3YypdBlGSU3ZUOCC4Q3b/35I?=
 =?us-ascii?Q?rLv7Y6KyBLIdYawCBG6xxP6HqMURLDE/dzNttAcyTcbu0PgEDGAZtABP2jgq?=
 =?us-ascii?Q?zvCoG3n7fciOyUAql6IZG/G12KmPGzlWjN1e1rUbLCYmOczbw7DbGWNMed58?=
 =?us-ascii?Q?iofcOyJ3YWOh8wxsxaZaposNYu9e4wRd8esgQAN+Mhj0ahpkkr4iOekoYYKn?=
 =?us-ascii?Q?Tn/O6jjjHkCoKDtfUMvUzuyNdUQ9PI6EPl/4w3BlRk2rZ/SU4HcwCsPZcvQd?=
 =?us-ascii?Q?HZH2JpNlLfZ5m26zn7J4cATypWfuNiFIQRiKWF8KDhqU0tUZFZSKTwDmm92d?=
 =?us-ascii?Q?jfTd6VMpjliWVAGd9U3bbj0Uth2XdSasBp4MtaRsgzO2hVZ5MMJanUkdWi0h?=
 =?us-ascii?Q?4T/b6UFtOzkgQQalcGPCkTJZ716fs/AYCzJ8cgc15EnVnX+ieJUSU7gWTAJI?=
 =?us-ascii?Q?ajl7cBi03OxrQbS2NVQycc/OL5p3vwX96lq00yjM2Gdmjtyso/zBHt2lRCij?=
 =?us-ascii?Q?GhpkLnWyYxRyDwjTBfMBwAIDo2oro2eEjwf/19MA0UAqYgv7aBmRSE+h/FUH?=
 =?us-ascii?Q?m2h39qDuOnqZMgRkmezCh/aiMdNny8ReLKa4vRzTjgmgMNELPOS7FVeX+aR7?=
 =?us-ascii?Q?Maj3QzuNBM1AbUOGwkNFArZGCfltlIcnod2ffGo9mcnf6+FdVOHUZgb71mLI?=
 =?us-ascii?Q?vr/xvz/jGLPVlbFYLq7mkbZcPgOhtxfM8g1RrmOtc6Pv4sm7idKeNEnp5k3b?=
 =?us-ascii?Q?iIMnTJROOBb0Zb1DAMFjCnAJmTZqsQ0xGJvGiBkDPI9lE6M13OsTmZ9aGaUY?=
 =?us-ascii?Q?zyaG6q7OuzVtwTozKvi6pATP/zBJC40aM9Jsk5CQX6kzPizbs7vw6k1PA3c5?=
 =?us-ascii?Q?62yhXmVgXWvbc/pwPz8n19bVgHEhAP0EyjeJkW6SMI2ncyze1qj4klqRE1dy?=
 =?us-ascii?Q?zv2OcL1gnHvzD1nfONbahO6KjXVwNhD/diPdfK5Oj8H0bVs3VahzjX0YmUfW?=
 =?us-ascii?Q?bKz8lz0tndRbqxvJM/inA+ZTPZ1vGnrBFLEDs1uEAsdfv2DlsYmVAXOTkJIs?=
 =?us-ascii?Q?1zVvgJaJPgKTOhfNEi8flI/7kHTgV9XJ+dycQD0T8d6cK7je+FGK1ZJBoB2O?=
 =?us-ascii?Q?+8vSHhCQOxSkwZXMwCR9S3RGl0IYpwlM++//jkmZBQ5cBEzkd3inus8awfME?=
 =?us-ascii?Q?LP3A+Wcqgf5V9hnG3XiwriKF7NPHxJ5aHGPYEM8fuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ppPoyoZZ33EJRfgtHMGhidgIMr97WzLgVtNSZlkSYf2oqU4XvtbMAjR+YeYW?=
 =?us-ascii?Q?+Y1JbmRKgy+wRrh7++TX10Jy9pAmr+F6+Azgw86DuSshN348HZ19B4KccY6S?=
 =?us-ascii?Q?r6DzCDdaueZ2e7ssn6+WFhCa/MVl8bUGEUE0KbLPioZy97NKUqtGSXqIqYHc?=
 =?us-ascii?Q?p6ZnqaUn820Mg2WfUEN1ldfHL8XQ7hYfXjuA7Td3EDTfyH/kw/udGGnHq+zf?=
 =?us-ascii?Q?B1jPcDobsVA4hDRn6j79qCTnbU53AZBDMTnraP5B2EtbLiwynFBqk5pa6j84?=
 =?us-ascii?Q?IUSVhknLHbJI3vx86Wh4byzyhRtGz704/f7uwHiLPIatLih1SBLuVcGGTgd1?=
 =?us-ascii?Q?ehmBnScGeQCduveHGug4r8M/EfLoif9Mb0N8g38iCT/oHPERY/Xyn2656+ol?=
 =?us-ascii?Q?UA99gh9pzmgbVQnAGJ8/vN+Gx6eGsRALvkU26yC/DMV4kGzFRc5N0pT5SjNE?=
 =?us-ascii?Q?/MhpXy1bw0Cmea7rKAr3UrxBQ1unCkhooFFa6Uc1MdzFdRsr9Ry8yIP8p2/S?=
 =?us-ascii?Q?P9NObOMNcU4LRxYOmlaMMyTbJeE8cMVDhhiwTqWqOw4lKBxKZf9tmF2OQvrr?=
 =?us-ascii?Q?mH7kRlanXeOEVl1Qr7g7tyulnGXTJ+lZKb1KczUrr6y8A5isqJPk7cv3m4yG?=
 =?us-ascii?Q?wFjMO2F63w67pFBo/zR1KQ71ZuO7QqanuL+TstF7uPXMPxd/GqBetbP3ZsxA?=
 =?us-ascii?Q?i9yC8e9e1wT7b8xhp2qiy8iuO+udB5U4GjXTefIPCdKKOHKvqpcRHgT0Uf2P?=
 =?us-ascii?Q?22CqCS0tsOIn9mGDrdIP9VLHloBFUoacB5oPWr/p/9SgpoEiVJqMHsJZ9QCc?=
 =?us-ascii?Q?7Vk0CJSrlQFos5YATk3ASJfvvlghNkIZpV2jFlCNF21KOQTJ6pwEScJ/pVOc?=
 =?us-ascii?Q?MbgszNQtcIUzSoMaa1TydkCdRu6t9RKX4vs5rvkw9ebcjVc78bx9U6ncCUIP?=
 =?us-ascii?Q?jiLQV6TwPAyXuVb7s7IcE3mz7QDr4UGu4nFm49HuQsvOiqdvMHCQwIlfNpNS?=
 =?us-ascii?Q?yuOkC8BrBEuBXhoTyerrrTneicsjZQsx9u+OzeWDrUTz9WH7tb8L8F/EDgb0?=
 =?us-ascii?Q?y7fFDkvoYaWh/bd4B8SbUWH0yLv7XKToBAQVfDisG9U/HYa0FjCAqT+7Krcy?=
 =?us-ascii?Q?0upWRA2XafN/ZMLoG44cGAZuxleG/IsTeH9A5wluxKcT2xqetmP2RE5inJIz?=
 =?us-ascii?Q?FYLcZs2yJXIgEysotFPPKo+pbs3zMpM/h4aT/ItRBx++yqLj3tEtpKvvb9fA?=
 =?us-ascii?Q?bvHDathZLUI/czM3s+vcULOqpCzKsAiMuq9qO3urNbR7EWukO3WPFhehm02T?=
 =?us-ascii?Q?6bGnkZTrCiuQFeTGKkd4oCo+IhQCA1mt4rxYGRa0ace1vvzgf05tjBRLF+LY?=
 =?us-ascii?Q?JhlxIQejkeBMC76YclFR60lbgzhPsTVyxu687+DAwkcTKXXcgqceYSaBsnxC?=
 =?us-ascii?Q?uvoCM6BBnmPUOWVB8sooPyp8/m/k9pR3ePPzOlSDJig7MOXINeCpwLyzPOn3?=
 =?us-ascii?Q?crjEZh2HpAyRBKyTjyiYey7gbtBp/44JH+882x0eWFRzASInAsGzm7/L0M8D?=
 =?us-ascii?Q?pnAr4xspnvj3SPCU8S40G6y7cjV4DFziE9HlyuG6FSPECZwouKD5eao+aYur?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9b36c7-cfb0-4bf9-c981-08dce2ce9c6d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:40:19.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OV0xoCEL7ysE+cC6A4qI1W6oYs71+A0EHsJYEmzHI1Psu9S8HliJTfHfZ4OlA8R99NnsNUDCaRqvtf9nfv5LGhScVXwNu047T1W3WQ7Oyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3908

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                         |   1 +
 arch/riscv/include/asm/irq_pipeline.h      | 143 +++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h          |  35 +++--
 arch/riscv/include/asm/mmu_context.h       |   5 +
 arch/riscv/include/asm/syscall.h           |   6 +
 arch/riscv/include/asm/thread_info.h       |  17 ++-
 arch/riscv/kernel/Makefile                 |   1 +
 arch/riscv/kernel/irq_pipeline.c           |  26 ++++
 arch/riscv/kernel/smp.c                    |  93 +++++++++++++-
 arch/riscv/kernel/smpboot.c                |   2 +-
 arch/riscv/kernel/traps.c                  |  88 ++++++++++++-
 arch/riscv/mm/fault.c                      |  83 ++++++++++--
 drivers/irqchip/irq-riscv-aplic-direct.c   |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c      |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |   3 +-
 drivers/irqchip/irq-riscv-intc.c           |   2 +
 drivers/irqchip/irq-sifive-plic.c          |   3 +-
 17 files changed, 472 insertions(+), 42 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..d9ae490e015a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -131,6 +131,7 @@ config RISCV
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
+	select HAVE_IRQ_PIPELINE
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
new file mode 100644
index 000000000000..66f141ea23f8
--- /dev/null
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -0,0 +1,143 @@
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
+/*
+ * Multiplex In-band IPI messages over software interrupt 0
+ * as we do in the arm implementation.
+ */
+#define OOB_NR_IPI		3
+#define OOB_IPI_OFFSET		1 /* Software interrupt 1 */
+#define TIMER_OOB_IPI		(ipi_virq_base + OOB_IPI_OFFSET)
+#define RESCHEDULE_OOB_IPI	(TIMER_OOB_IPI + 1)
+#define CALL_FUNCTION_OOB_IPI	(RESCHEDULE_OOB_IPI + 1)
+
+extern int ipi_virq_base;
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
+/* test hardware interrupt enable bit */
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
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
index 6fd8cbfcfcc7..d268cf76b007 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -10,45 +10,54 @@
 #include <asm/csr.h>
 
 /* read interrupt enabled status */
-static inline unsigned long arch_local_save_flags(void)
+static inline unsigned long native_save_flags(void)
 {
 	return csr_read(CSR_STATUS);
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
 
-/* get status and disable interrupts */
-static inline unsigned long arch_local_irq_save(void)
-{
-	return csr_read_clear(CSR_STATUS, SR_IE);
-}
-
 /* test flags */
-static inline int arch_irqs_disabled_flags(unsigned long flags)
+static inline int native_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & SR_IE);
 }
 
 /* test hardware interrupt enable bit */
-static inline int arch_irqs_disabled(void)
+static inline bool native_irqs_disabled(void)
+{
+	return native_irqs_disabled_flags(native_save_flags());
+}
+
+#include <asm/irq_pipeline.h>
+
+/* get status and disable interrupts */
+static inline unsigned long native_irq_save(void)
 {
-	return arch_irqs_disabled_flags(arch_local_save_flags());
+	return csr_read_clear(CSR_STATUS, SR_IE);
 }
 
 /* set interrupt enabled status */
-static inline void arch_local_irq_restore(unsigned long flags)
+static inline void native_irq_restore(unsigned long flags)
 {
 	csr_set(CSR_STATUS, flags & SR_IE);
 }
 
+static inline void native_irq_sync(void)
+{
+	native_irq_disable();
+	asm volatile("nop" : : : "memory");
+	native_irq_enable();
+}
+
 #endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..a96a4a16819c 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,6 +33,11 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
+static inline void
+switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	      struct task_struct *tsk) { }
+
+
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
 #include <asm-generic/mmu_context.h>
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 121fff429dce..9e602ce18a18 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -95,6 +95,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 	return false;
 }
 
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
 asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index fca5c6be2b81..09162da76a02 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -47,6 +47,7 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	__u32			local_flags;	/* local (synchronous) flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
 	/*
 	 * These stack pointers are overwritten on every system call or
@@ -83,6 +84,8 @@ struct thread_info {
 	INIT_SCS				\
 }
 
+#define ti_local_flags(__ti)    ((__ti)->local_flags)
+
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
@@ -104,6 +107,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
+#define TIF_RETUSER		13	/* INBAND_TASK_RETUSER is pending */
+#define TIF_MAYDAY		14	/* emergency trap pending */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -111,9 +116,19 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
+#define _TIF_RETUSER		(1 << TIF_RETUSER)
+#define _TIF_MAYDAY		(1 << TIF_MAYDAY)
 
 #define _TIF_WORK_MASK \
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
+	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE | _TIF_RETUSER)
+
+/*
+ * Local (synchronous) thread flags.
+ */
+#define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 06d407f1b30b..f6827b2432d1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_MODULES)		+= module.o
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
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8e6eb64459af..61ce611aa4a2 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -20,12 +20,15 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irq_pipeline.h>
 #include <linux/irq_work.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
+#include <trace/events/ipi.h>
+
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
@@ -45,8 +48,8 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
-static int ipi_virq_base __ro_after_init;
+//static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
+int ipi_virq_base __ro_after_init;
 static int nr_ipi __ro_after_init = IPI_MAX;
 static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
@@ -77,7 +80,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	atomic_dec(&waiting_for_crash_ipi);
 
-	local_irq_disable();
+	hard_local_irq_disable();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_has_hotplug(cpu))
@@ -94,6 +97,47 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 }
 #endif
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+static DEFINE_PER_CPU(unsigned long, ipi_messages);
+
+static DEFINE_PER_CPU(unsigned int [IPI_MAX], ipi_counts);
+
+void irq_send_oob_ipi(unsigned int irq,
+		const struct cpumask *cpumask)
+{
+	unsigned int sgi = irq - ipi_virq_base;
+
+	if (WARN_ON(irq_pipeline_debug() &&
+		    (sgi < OOB_IPI_OFFSET ||
+		     sgi >= OOB_IPI_OFFSET + OOB_NR_IPI)))
+		return;
+
+	__ipi_send_mask(ipi_desc[sgi], cpumask);
+}
+EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
+
+static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask)
+		set_bit(op, &per_cpu(ipi_messages, cpu));
+
+	wmb();
+	__ipi_send_mask(ipi_desc[0], mask);
+}
+
+static void send_ipi_single(int cpu, enum ipi_message_type op)
+{
+	set_bit(op, &per_cpu(ipi_messages, cpu));
+
+	wmb();
+	__ipi_send_mask(ipi_desc[0], cpumask_of(cpu));
+}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
 	__ipi_send_mask(ipi_desc[op], mask);
@@ -104,6 +148,8 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
 	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
+#endif /* !CONFIG_IRQ_PIPELINE */
+
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
@@ -144,6 +190,26 @@ static irqreturn_t handle_IPI(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+static irqreturn_t ipi_handler(int irq, void *data)
+{
+	unsigned long *pmsg;
+	unsigned int ipinr;
+
+	pmsg = raw_cpu_ptr(&ipi_messages);
+	while (*pmsg) {
+		ipinr = ffs(*pmsg) - 1;
+		clear_bit(ipinr, pmsg);
+		__this_cpu_inc(ipi_counts[ipinr]);
+		handle_IPI(ipinr + ipi_virq_base, data);
+	}
+
+	return IRQ_HANDLED;
+}
+
+#endif /* !CONFIG_IRQ_PIPELINE */
+
 void riscv_ipi_enable(void)
 {
 	int i;
@@ -173,20 +239,33 @@ bool riscv_ipi_have_virq_range(void)
 
 void riscv_ipi_set_virq_range(int virq, int nr)
 {
-	int i, err;
+	int i, inband_nr_ipi;
 
 	if (WARN_ON(ipi_virq_base))
 		return;
 
 	WARN_ON(nr < IPI_MAX);
+
 	nr_ipi = min(nr, IPI_MAX);
+
+	/*
+	 * irq_pipeline: the in-band stage traps SGI0 only,
+	 * over which IPI messages are mutiplexed. Other SGIs
+	 * are available for exchanging out-of-band IPIs.
+	 */
+	inband_nr_ipi = irqs_pipelined() ? 1 : nr_ipi;
+
 	ipi_virq_base = virq;
 
 	/* Request IPIs */
 	for (i = 0; i < nr_ipi; i++) {
-		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
-					 "IPI", &ipi_dummy_dev);
-		WARN_ON(err);
+		if (i < inband_nr_ipi) {
+			int err;
+
+			err = request_percpu_irq(ipi_virq_base + i, ipi_handler,
+						 "IPI", &irq_stat);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
 		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 0f8f1c95ac38..c80673c6e8cf 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -246,6 +246,6 @@ asmlinkage __visible void smp_callin(void)
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
 	 */
-	local_irq_enable();
+	local_irq_enable_full();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05a16b1f0aee..636a956ed699 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -111,10 +111,59 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+static __always_inline
+bool mark_trap_entry(int signo, struct pt_regs *regs)
+{
+	oob_trap_notify(signo, regs);
+
+	if (likely(running_inband())) {
+		hard_cond_local_irq_enable();
+		return true;
+	}
+
+	/*
+	 * If the oob core did not switch us inband, our caller is
+	 * expected to leave the trap handler immediately, so we may
+	 * notify the core about this right now.
+	 */
+	oob_trap_unwind(signo, regs);
+
+	return false;
+}
+
+static __always_inline
+void mark_trap_exit(int signo, struct pt_regs *regs)
+{
+	oob_trap_unwind(signo, regs);
+	hard_cond_local_irq_disable();
+}
+
+static __always_inline
+bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
+{
+	oob_trap_notify(trapnr, regs);
+
+	if (running_oob()) {
+		oob_trap_unwind(trapnr, regs);
+		return false;
+	}
+
+	return true;
+}
+
+static __always_inline
+void mark_trap_exit_raw(int trapnr, struct pt_regs *regs)
+{
+	oob_trap_unwind(trapnr, regs);
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
@@ -126,6 +175,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+
+	mark_trap_exit(signo, regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -174,11 +225,17 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
-		local_irq_enable();
+		if (running_inband())
+			local_irq_enable_full();
+		else
+			hard_local_irq_enable();
 
 		handled = riscv_v_first_use_handler(regs);
 
-		local_irq_disable();
+		if (running_inband())
+			local_irq_disable_full();
+		else
+			hard_local_irq_disable();
 
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
@@ -324,6 +381,14 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		if (dovetailing()) {
+			if (syscall == EXIT_SYSCALL_OOB) {
+				hard_local_irq_disable();
+				return;
+			}
+			if (syscall == EXIT_SYSCALL_TAIL)
+				goto done;
+		}
 		add_random_kstack_offset();
 
 		if (syscall >= 0 && syscall < NR_syscalls)
@@ -341,7 +406,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 * The resulting 6 bits of entropy is seen in SP[9:4].
 		 */
 		choose_random_kstack_offset(get_random_u16());
-
+done:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -361,12 +426,24 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 
 	handle_page_fault(regs);
 
-	local_irq_disable();
+	if (running_inband())
+		local_irq_disable_full();
+	else
+		hard_local_irq_disable();
 
 	irqentry_exit(regs, state);
 }
 #endif
 
+#ifdef CONFIG_IRQ_PIPELINE
+static void noinstr handle_riscv_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	handle_irq_pipelined(regs);
+	set_irq_regs(old_regs);
+}
+#else
 static void noinstr handle_riscv_irq(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
@@ -377,6 +454,9 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 	irq_exit_rcu();
 }
+#endif
+
+extern void (*handle_arch_irq)(struct pt_regs *);
 
 asmlinkage void noinstr do_irq(struct pt_regs *regs)
 {
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index a9f2b4af8f3f..7a09fcfb534c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -22,9 +22,60 @@
 
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
+	/*
+	 * We expect kentry_exit_pipelined() to clear the stall bit if
+	 * kentry_enter_pipelined() observed it that way.
+	 */
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
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
+	irq_pipeline_oops();
 	bust_spinlocks(1);
 
 	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
@@ -61,6 +112,8 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
 {
+	unsigned long irqflags;
+
 	if (!user_mode(regs)) {
 		no_context(regs, addr);
 		return;
@@ -71,7 +124,9 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 		 * We ran out of memory, call the OOM killer, and return the userspace
 		 * (which will retry the fault, or kill us if we got oom-killed).
 		 */
+		irqflags = fault_entry(regs);
 		pagefault_out_of_memory();
+		fault_exit(irqflags);
 		return;
 	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
 		/* Kernel mode? Handle exceptions or die */
@@ -229,6 +284,9 @@ void handle_page_fault(struct pt_regs *regs)
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
+	unsigned long irqflags;
+
+	irqflags = fault_entry(regs);
 
 	cause = regs->cause;
 	addr = regs->badaddr;
@@ -237,7 +295,7 @@ void handle_page_fault(struct pt_regs *regs)
 	mm = tsk->mm;
 
 	if (kprobe_page_fault(regs, cause))
-		return;
+		goto out;
 
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
@@ -251,12 +309,12 @@ void handle_page_fault(struct pt_regs *regs)
 	if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
 	    unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
 		vmalloc_fault(regs, code, addr);
-		return;
+		goto out;
 	}
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (!regs_irqs_disabled(regs))
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	/*
 	 * If we're in an interrupt, have no user context, or are running
@@ -265,7 +323,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(faulthandler_disabled() || !mm)) {
 		tsk->thread.bad_cause = cause;
 		no_context(regs, addr);
-		return;
+		goto out;
 	}
 
 	if (user_mode(regs))
@@ -273,7 +331,7 @@ void handle_page_fault(struct pt_regs *regs)
 
 	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM))) {
 		if (fixup_exception(regs))
-			return;
+			goto out;
 
 		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
 	}
@@ -296,7 +354,7 @@ void handle_page_fault(struct pt_regs *regs)
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
-		return;
+		goto out;
 	}
 
 	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
@@ -314,7 +372,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 lock_mmap:
 
@@ -323,7 +381,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(!vma)) {
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -335,7 +393,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(access_error(cause, vma))) {
 		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -353,12 +411,12 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
-		return;
+		goto out;
 
 	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
@@ -377,7 +435,8 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
-		return;
 	}
+out:
+	fault_exit(irqflags);
 	return;
 }
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 4a3ffe856d6c..ae0d31f2d32c 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -87,7 +87,8 @@ static struct irq_chip aplic_direct_chip = {
 #endif
 	.flags		= IRQCHIP_SET_TYPE_MASKED |
 			  IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_MASK_ON_SUSPEND,
+			  IRQCHIP_MASK_ON_SUSPEND |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 028444af48bd..213679771828 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -138,7 +138,8 @@ static const struct msi_domain_template aplic_msi_template = {
 		.irq_write_msi_msg	= aplic_msi_write_msg,
 		.flags			= IRQCHIP_SET_TYPE_MASKED |
 					  IRQCHIP_SKIP_SET_WAKE |
-					  IRQCHIP_MASK_ON_SUSPEND,
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 	},
 
 	.ops = {
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 11723a763c10..1bfb7cc94f82 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -137,7 +137,8 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
+				  IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 47f3200476da..2df18b7d36a1 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -111,6 +111,7 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip andes_intc_chip = {
@@ -118,6 +119,7 @@ static struct irq_chip andes_intc_chip = {
 	.irq_mask	= andes_intc_irq_mask,
 	.irq_unmask	= andes_intc_irq_unmask,
 	.irq_eoi	= riscv_intc_irq_eoi,
+	.flags		= IRQCHIP_PIPELINE_SAFE,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..f61db2ae0ca4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -197,7 +197,8 @@ static struct irq_chip plic_edge_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip plic_chip = {
-- 
2.43.0

