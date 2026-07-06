Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8592436BF1
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362582; cv=fail; b=Sg3BKY8OJPn5ZBFD5RM6v4FEBPHSz24faWrtJRRqWxXaeYU77XJY6DazhC1uPK3Oo3HIPp9fDJV4HdZN75mrGM/7BiChKeG/IhjxbnbwGgsuLw9/mJaj5kdULvoKpdQwf3U5mT0OTh3GhIBXFEDfpcI+qmvZm2WMvxgUmrITIqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362582; c=relaxed/simple;
	bh=VQG+imQck3qEKrZpfkDvE9tPRTSDTYOKHvDKlVE3a3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAAjIow4LUb6zFT6d62h84Fb1S67xUfhs8SBpgN3wtLXy9y3RibB8Y3m/w5xcr/xhR10fhEF3MDmKsPr7jROCUqE1VSc01gJgtjVhNwJ+dAU5iZH/BlNtdE3Y2YFBiw78hOVMxy/6zQ0WkQpk/OK8eF5CqkJ7qc7HDy9HGlIrQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nli6TK4Y; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nli6TK4Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/dRMfH7pHeD/1qLbAjkIgx/xGd3HF0O0R9NVS8+xWFpWzCMnlLbNjthBSl0Nl5dQtRg6HvY0Ziqsyn1WZp5e5i/IsH6Z6IAHuoU1t5wazvwzLBZhcQun4wHm2eOBOE2GA2KsNcaGFD4PHhARbLZOicrGQgMtH1226sbX5G5xY/g3Z0Ec6kHUxACBS7UTx6ABPmSEIoRnYlUdOikzpu3VaulxncKdxeGuHYvP95Bq3pzdPAV49Vy26MINj58HXN3uuCFDKFa0wA7TyB+ztvWux7dopvmQrM+E68tH+6dJiZfhLvSyPsOGUz1CICuj/Q8jTlOproFYyjBLf1qbYB60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqLIl4X3XUf5E6DDHL+OvYySCj6qhf+dlsSrAyvB3j0=;
 b=Z+OXnTXYknq6goss+vB5L/d8IugPLJ8HD2RWTImrV6mQUl5g9yck0IS6llu9TcOYnQYy4y7iKiH1P5makn/1NUO4NnRUcuZiltm+0SG8SufpPcKATGOc/1K3D52ZNytwc9ewvacBlooy/DfsMfCyUALxoLJ2yI1amut/J6EJGCSF/Lvc15eQzzipa25NijMTvzLvQNuxoXOUXaqjFsAw8ViA28q6NPSZsgu1KAU2C2P1524BpYsGM9+2Hr4zAP5HsUKUF3MjW75BiLADjnxZ/qJCeUlWpD2lCwPMUdUI8NRar3zu5bWkIKk+5GWt6kJD47hsOBypGYr6hTHzezLhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqLIl4X3XUf5E6DDHL+OvYySCj6qhf+dlsSrAyvB3j0=;
 b=nli6TK4Y7lBuQ7pY+7nEZnJpWhVhHFFSsGi7dPcw2BRhUfToyG12u72jSjbuEwIjI4kHNuyvQniQEjyp2FsOlSdJrrmgcJ+a8yJgtsf+2lEJU13tGj+ybM1XPK7NMEmtrd29sNC4vA/yzFBp4/3AYkQb/7yKFTogxgfKs00KEiayS+MYliNMaYpCyiNnkBDSJm0tAFzK05aSZ1X+Cb/Dp2fr5BeNWGtDtjC1dmRCMKiGPO2cWbjtnV6bUSwEJawo/08oGTJ3SeL3cJjZRmmOBbpmc5aSY/u7TCIY3rv09i70oF/z9LBnioRxrcZ8VaaYZ0o5+0FOUHDA3LW5QVOtNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:35 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 01/11] riscv: introduce raw console device
Date: Mon,  6 Jul 2026 20:29:17 +0200
Message-ID: <20260706182927.281078-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: e248d7e8-032d-4b14-34a1-08dedb8c87c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jMVgU2fD05LBHrFBk0AhgEVxGqgGFNSOjJZnp/oTHYGjwrJue7PtJfhVEXjv4eC8AG0wBC/ptTQPO0fh/07DTWGI+Yzg9QFeC5sIew62VXx33MAZZS2V8AwtFW//Lx0bF+c1zdDPFQsbsh7JDbFIV3c/U2WsRUTSWpAqs0r0R3IBrjU9vdVSvSc5wDCOWQcGbrYKRV+Utzx9f0EFyDWQSqfoXzbCSouOaRh3rPgs3pGAbznpOJ+vbrPkmA3HTancaPoJqyjzK05QkBY4m7LEegx5+J7mlbjjjf7V/Mz1mTFs86Xf2m4lEZxog7ycJHd4gIN9byR3/Izv68JtCj0z0URGfRF68KSpmDT6c2ZqsCsjTDWKTwM4JbcHuZWU0g+Y0t//E2WeEtKMuStYJ4v+GudF2CSKSA+6HgxTOA0bqDJOHbaCEU/NHvv7CoZe6Db3wU/RvSXn88wL9RVAhOCDwnmLYpDAhHn/VoOVO406x3i3GyyD2ZgVf9H8MhYP7x8BfDBCQRSjb3fhj3YunNQvfxEaREbsCPqACCxLjckGMUoLV8oSrZcC08bgYhT6MwvMmOfZrl+eCmlsGpzTJvPzrMENcBXSITYeACvfDbbUSXnB1fR/GarB7ua9M4MKLeCpSsO2GkLQIOIq610GwpeMfJFhpmgZhw3KjgGlRtQF6m8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qTpzLUCwI5cNgTE9KQxbt0B8bL9rcB79f/NFLk+y/ACR8GZa663s4EstBwYC?=
 =?us-ascii?Q?5pjRgt0Vk/bEMqrzFTg+jdUyafGE7NVYvoZIOJLF5hXNSUhEIADS82x0OAAh?=
 =?us-ascii?Q?gQzxScgJdNTF5G+41ouRWX3xunXRocfH9PZz/YxKcM0O++OPXvqPBCmUvkeN?=
 =?us-ascii?Q?MejDp80e7gT1LIXvurN7cWVBdGm/bD6hod1Aoa7ndJZbAoQIDq6rc/cChefy?=
 =?us-ascii?Q?Z+RrZ0qQFMQ3MuvTj7o1CX9JEEdDx5v5nPhKW5WCOCw+smPbozIs1pDFx7RE?=
 =?us-ascii?Q?EMioKvMYsjhvtThwDDdeWVGUoN0cSFPSKy0bn69iM6poPU9QWMWkvkb7+eZO?=
 =?us-ascii?Q?3PYh5cYP/+i+wKDBQpf/xKA45dvNQlN75VWxHABNXIPidh8al31HlL1RD6cC?=
 =?us-ascii?Q?kfkpa9fBiUNra5+H1nSTQrYLGSMcSFVMUWEggAZ2vfGFHl/P4gnaQ3WHYhrV?=
 =?us-ascii?Q?yEUvYmpEwc9Np7m/UJQ8BmzGLFhKDxXA+EdTgfWEt+ousyplF1C9n0Sf6kgh?=
 =?us-ascii?Q?dIwideEZ+GzX7aJ6aID20efXocCoBK4Fm1/SqyDUhlSc2PWIh0sR1pQRlejA?=
 =?us-ascii?Q?VnG+o2p+jTNIm8ji7VyL/bbrpfbAR62Usi77hwVOkBR1TYeLVioYPcVA/yX8?=
 =?us-ascii?Q?0ac712fjyuhZiZ+lCc2DadGVWYm8+03I9bMiCZM3rzUPKjJNltHkxzWA140n?=
 =?us-ascii?Q?ViOFRW3toBPdcFoSJq9nk3CukWHfOLBS88kUMZvuxVSdIr9M6Btu7TMcvasG?=
 =?us-ascii?Q?dTmRhYBar7pbcIqoGxz1m6w9QtsdWfPL0GjJnmdqIQ7MJm51cy1KGztUZkHw?=
 =?us-ascii?Q?qwFfSsdm3jXVqxMiX8zHawsn9Z8M7gs31vsEH5h5XBa5nxcvhj2I0p+aZXmQ?=
 =?us-ascii?Q?SBER2tnSgV3TPUp09LMHXouvMYr18tl51KiZKFeurcRkmttavUFxSXSXRzkD?=
 =?us-ascii?Q?7L3/oiRAtSQg7J2quTBU3slY60CIdNsGjJ0ygsGnM6E9aoQgTQl82lediFZm?=
 =?us-ascii?Q?LKfKiKbrYoIMpJDU2WCDI4PyC2zc5XuBRQlr/8v2VAFuAWI2c7dIszPSTnAS?=
 =?us-ascii?Q?ArRB8wZXJ14i9AHJc2F55n3PEte/+VwSg8eor+S4XbDugkJ2ZQcCIp0K56C3?=
 =?us-ascii?Q?YDEEIy0WyrQHf6QRM9jwbi/kk8GzwqCjBbtmZj7F5b6ltnndUv4uw2kEJ89l?=
 =?us-ascii?Q?okfM3k0DEHGwuurfQO1wFhgbreOrP1yx/lAI4Y0gEX0Z+Kgg2peQUFMh72kW?=
 =?us-ascii?Q?qAjYsdWE5n4Jjw0WHFnwPs0LRjTa61Qkl0xudTBLlR2GOvKWMvd4wKeZqrug?=
 =?us-ascii?Q?61K2lEa0iG6ZhDzCWjKyqY7cazcWh6MuMRw7dQYZWYUUGn62czIpuwP/wTjs?=
 =?us-ascii?Q?N2vbIBEL+R5mkJRfLfZxOnSUWJwA5nov2AaSUOhnqPeGAjhbZ3h22OKVmLZX?=
 =?us-ascii?Q?0ZT1NzCArjKlnmbCNlHQCI5Dp5htBAVzNWvluxD7c8ClwyZC+XMP5I6dcPG1?=
 =?us-ascii?Q?X78TTnPCzIeN4sSUeVB3NAK0jV0+b5Fd7k4Ti6+/8448Qvfv3fdlsOixkDG9?=
 =?us-ascii?Q?BcQMcQzlCoHu4sjVEE54W0VnKq87jpGArRv92Cx1Eik9ghbZd7OJoazsw6/A?=
 =?us-ascii?Q?xVIw8WNEqtlPa9HCjuqRDv16cfOyixolMGTl3x4cvHsOTdJMy40ho7xcCF6V?=
 =?us-ascii?Q?RKACTBwcRPjj025lAjmgmtcsBpL5A4sVi10ACT8LS8ukQJF/epqsW3SERVCI?=
 =?us-ascii?Q?Dd33t1WM7ksGH8YWTlA3Tqrr125btFKSXDxBX0JVCsYPWRKTqaevwTnezy/X?=
X-MS-Exchange-AntiSpam-MessageData-1: z+UhK1wJuHt1ONmrRZsWdc1ZLizGn5YGxwg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e248d7e8-032d-4b14-34a1-08dedb8c87c9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:35.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlnmVkSmLOCQIv92cv+CuQLK4Ansrubi+kUmPz2/l+7J7RT89qb6Nzs3Ml3rNJ23lBqtAsxICUNv6jA63gwnB8D5ZzLBYc13BoGVX64I/RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

