Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20603A9633
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042633; cv=fail; b=CWMj//mdVpmjCmG2wpXGFrHrOztRgbu1h4e+tAO1wTWAdnhMFa8SRmiBAY/8GR6rolpIII3jFlQqpeTLEx482t5x+YfM00+grLH2xqxomeezkSArVhOTZFM/eXKmjLlisi7h51tgKxNNwxuY/sY4r1+3TZSanyCKlPzRj7F5DRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042633; c=relaxed/simple;
	bh=2pOUy5R9ZDcB7ZW7rxbzi/13pqo+XELQNBRpWi8UitA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmPsMbPn8qlSvuWhF6Nc2719KbHWAyeHZYwTpx4ChaC2b+d08rNCN9vG28h6w8TK3yjYrRrClKP/rpuokmaJSeiDRqkt2yqbq+GeIKHXEk0miz4cOTZH+CgsOB4ZOKw07ldGmxmIsyqmrqm3Rgdb1sTpPTGiB+hZq6X70ZvVe8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MDQgDF8I; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MDQgDF8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1+TJpGiMGEjEBA5DPRm+DwXfSiIIYY9mqRL+SPBi3A/EPRMwxHRXiIwPIZ0jreGEgje3Jk34zszRftc389P5lb6ueN8gZCe1UCJ9XGB2OZEYmkVq8O7WaNtpM9C6NbkP3wmgM4EnaVJUw0XZ9V8C93wvETbjFqJ8gTvxuDhwnrjvmE4d0JJC7R9mLJ/Shfuyi3M6X51D5KOLXrhEWYBk9HXCJcX64b14vma5JOn+VtRYEM52ZgNKXAcDBVlQR5hXnXfg/+Qo9AX2fbc748xTCioTHXfGtfGIlb6PzTlXXXAj56Iq3ZSv6/a5Z9K3FxT8RZWkxarFBCdBtE8zpZtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnS62UmUShYAbbKBxskURKV25pWFxj3i6k2T3eaawIs=;
 b=OOarvb5GE2BPrpOipqATDViFzv3bUSbSOUS085xUiGfggfxefIirWWVvBZ0ftmXoLAOgRQ61zDQNcY19hCTKfh4IkziV33W40bTxQfDN8LWSTjFxvFc2NvmPYhX2mC2/nrGbUMAe2suxQEx6sQGodOfzRwFQGPBmGbmWBZoin/cpT8WGOBLSIeg0qCiu2WJaVDLV9hjVdT7ENsNoi7AhN3Z9TG2WcZFGBuk4y/7cQWh4ecfbgKcMjqTzxzWDf018Jj143Kc9XXLor5BiZ8c5gu+uH5MveFH+/mGcS+24jMbyqIzNDJik9EElR+HCrKaM4WvMJKOCI2KPYP/xji3PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnS62UmUShYAbbKBxskURKV25pWFxj3i6k2T3eaawIs=;
 b=MDQgDF8ISX+oPwGuy/cqOC3rb/EpS9PLh7Aln53AoDpMBLVu9QvdxkwnhWmWyHGeDySs2cbQUA72+RQBmY3YZLZXWE+hRJKfTZmAXbikdnfrJTuQ+ipXmFYllLiyhNyvxiHIHi9PWzNiIg52wo15jkZm9VClVByRG7F2LxNMwUovMgMhGxSNhKCMhNiO32ZiP2fA9NZFji8hYXk47hCSVtg4YGk68zDAK/vU8Goj1RZnAJxDnbxApu8yK23lqo4YCT8Gwnt0a46J3gKliQfKg3co4RH/rSWHKxH9lhSnc3LOrUw4/HUUIJ6VF9JpHSBqBhzdJGAuBHL6SiKmjAQ4Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 01/12] riscv: introduce raw console device
Date: Fri, 20 Mar 2026 22:36:46 +0100
Message-ID: <20260320213657.2210419-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
References: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9a7df32-fa5e-45bc-8cfe-08de86c8d57c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	/9uMCdpI/4aqDFHQpdCl+O4ADFxFHAk/X9G9Yt0GCiDeLDTMTrMOmSROPmGTxhavTiCxz9zmd6SL6usWj3fWrNv4y6OUVqOqEBmVHRQVnoG3d15WjDSTyuXGNW1EG3DudnpBVMj+T24X761MYRDQJCZsO3svI5bXPV1K8AwUgpBn6LKR7w8UKw333I+juI56G2f86hcjH5MxHA9Mul4fNvktqvr4G30qOmV1g9L9xrktEGaxjcESd9bOVDuoVolWzXtqWJ+d/t5AiCK6Zq1iAaFg0aR+4l1HViSEu0BL+pTQPkKue+rxfu8DEPFG40oUnidDTDefh2dIPGEGE8mMHWWm1VbETHFxwxA6yK0C7i1u3PJ84EBfixFQwgionqqYH73oGDp4Y20gS4mYAjB8vuAEdf3ftO3Mj5138EBupKrQaINyls5RyvMrjaN2ozfAHMHvGIQAbwuluU1eJoLsNgbAbfobTEmh5S0LcEECmjJjhKcYhDwn3JeEkrjZz5kvEdRoozZ30Vd1TDW0Iq9FJ2z9nVQUid2qZmQs/pJuCZ143u8HV65gjyeLrIpuuvwg3KzPUNy+cTPbvJqBwtVCTwgtZJ0Np/B4jtB1xZL6guEE1US3ZlPTqJpEC/xx8lB3u1Ep+rrPV2InMProLClbVKNNDFRtTiM+BfHmmyvuTlsaI+NW+yCyLXGwKdVxdmm+EadHG1CHRq4RJ1OAQMwtkYpk4d9I8bxJFRQDC59bSU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IahBDjWOFpoXBCQcqrrLgxlC9xqIUo6FSklccrn0gsY6QmVtP1Y8+pNbCmFO?=
 =?us-ascii?Q?m0aAqDmyBay7SEsHhHw0VSY+NUn+GOt7JhmAOQgmOpBMcEzYWaGKQj5P4jim?=
 =?us-ascii?Q?4sS9TTCyyqjT/CNQrQo0hih+1FldiXv9chXNVJRjf5/bk1/qesXKWFr/BVRJ?=
 =?us-ascii?Q?ZaOLKAzEZgg2FUipqg6qY8KINSKabC4EAhXrXhoaIl2M+KaVELqc1EbPvGmX?=
 =?us-ascii?Q?gXmA99z9+vOLxXZQoJbBcFbhspO3dCIqnPAXWRZeA81AOzYjyURyTsBBJYbD?=
 =?us-ascii?Q?hZ1UR9zyks5W/wVg9G4BW82iKRPi0On/C+Ym1y30bLCEk04Eiv4Q9ZCJUciY?=
 =?us-ascii?Q?e0A2a+WDUZYfkOg1yvzqA1cenOrUSOvEgltXYuxgv2EyjklhxTDpoeQL2Fql?=
 =?us-ascii?Q?vb7YvDFJSA2dnHtFzYdfmyrt41M7rKmTqloYkJXsy7fLWkeHZOdvJTS0kI4K?=
 =?us-ascii?Q?6wALXCxr0ETnoSN6xx/85yP+7GaHyGwbsEHOanJzJciIQguqb0/5+8CWkE4C?=
 =?us-ascii?Q?eFLwWo7yG5u5mqCqM8kcGoshRwvnRteN2Xx5oFpkZn4/22qJZtbgrWJN20aK?=
 =?us-ascii?Q?0UZK7lyYLjQFxjCxyO8S89Sk4L5XzEArj85hY1/QDqES2cY1OF30N7VczBx5?=
 =?us-ascii?Q?qrwfu62+Y2Mw3l+PR0FpCDoN8wHzNBL6NiRZXPszukNriDyl2rKGliS+iH7f?=
 =?us-ascii?Q?AS0xe/eXIH9o63hnp3NIdRz4H6EMFSxacQFL5yvg+6DyLNAAX8uUZYJ1X0sq?=
 =?us-ascii?Q?uTMgIe3u0TpKrlwp7Yhk0wq/s88zrlYwLe5sfNknlviFE0dfgfB06x1GxJd0?=
 =?us-ascii?Q?dRJ8U9ZkUdYQ0oLNJVbimPQ9KPM6rOkdHMBy1ti3C3zZKFUd9yIccsk6ctV6?=
 =?us-ascii?Q?zNDcc+DMq62I1PzgxkDsHEp1SanCDBQGYqo/+alzBmh2TObkUPakMWw/pJpA?=
 =?us-ascii?Q?tnhyM9qTtoIKKc9Ix0oFvpI5wyJ70did4nPHIJdFzx1AVGfgaIhgjlDMuk+a?=
 =?us-ascii?Q?44tHvo0uPRW8R40zL2u/0Bd7K6nmnSgY8qbZF9iQEU/PL4qGVfnl7rTpFFiF?=
 =?us-ascii?Q?ux/7umqsGGT3Tx2zu7FQr2GX4WFBH/UJKMAZYLDtwvqaIrSpBJqC565Qx4qt?=
 =?us-ascii?Q?bI/SSAXryqf1JBf5VCY2v7Lv6DRxqJur6R79BvZBHNrYQs3pMb7+aTk9mEXB?=
 =?us-ascii?Q?kFYVbbinSQDp+HfPbVE9ypbOmsNXJF3hyr5Q8XTzSMxMPiwOlbkvEmjYPfiA?=
 =?us-ascii?Q?CEqukt1ymzr1HRhOzKM9upvu9XoQC42FyVMcWJwbtF1kosFF2ZJOk1S44MYC?=
 =?us-ascii?Q?RIAk4A7AVA7SdByMlultPwaF4WMdSNSBhVuXP4pfuRH5Pzr3chEMl/h+htSL?=
 =?us-ascii?Q?qLr2+x5eH8NpxghoeYSKnnFroN5uDAFAoJHxjXu9E3SfqB+gvJ6nAEdxLpJY?=
 =?us-ascii?Q?2p9/xUGSnE+gbXTEFs4sMpxOOyNLmE0TZyoAn7Hl/HPwTA7+X6W/f+OvGhhm?=
 =?us-ascii?Q?nqycFzs1xLdlxOwk0Z7rbDNGdtuXwUJppVAyEoqTDMUQgItcmlZGiEKvZKHF?=
 =?us-ascii?Q?snL+VLJYmalQWAPEZU4jQGVdBLACR8dBU0Sc22mwNY/ZCGy0TGkUE6mZ7aja?=
 =?us-ascii?Q?GFvS9jvSC89lVyKk9hCUhTRKCSFWiX6cSXTVhrVJXOVvl4SzgK2i6qyilFHe?=
 =?us-ascii?Q?uhrEEl6gOVpY8XOzYLeQ0hmGSpK31Jx6IO1LKQ+sYVMgZFr3syOj5BKi1ycN?=
 =?us-ascii?Q?UPs9W6NLhKQ/FY/Zppoq7Gsq+w3buFk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a7df32-fa5e-45bc-8cfe-08de86c8d57c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:06.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdFpOt2ti8GiBt7zb6xKGD5Lo/oFkkiSBXg40GdS2/Fkt/FFVSZiM4peDNiBCMTIiUZiNsAbo9MIqz6UtgncJ5i0CIRsl53LakSP7cTxT/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/raw_printk.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/riscv/kernel/raw_printk.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index cabb99cadfb6..4e310257499a 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
+obj-$(CONFIG_RAW_PRINTK)	+= raw_printk.o
 endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
diff --git a/arch/riscv/kernel/raw_printk.c b/arch/riscv/kernel/raw_printk.c
new file mode 100644
index 000000000000..aa2f287daa29
--- /dev/null
+++ b/arch/riscv/kernel/raw_printk.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Raw console device for RISC-V using SBI debug console (DBCN).
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <asm/sbi.h>
+
+static void raw_console_write(struct console *co,
+			      const char *s, unsigned int count)
+{
+	sbi_debug_console_write(s, count);
+}
+
+static struct console raw_console = {
+	.name		= "rawcon",
+	.write_raw	= raw_console_write,
+	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.index		= -1,
+};
+
+static int __init raw_console_init(void)
+{
+	register_console(&raw_console);
+
+	return 0;
+}
+console_initcall(raw_console_init);
-- 
2.43.0

