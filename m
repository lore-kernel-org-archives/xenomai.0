Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526B308F23
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206798; cv=fail; b=klDzjXmdubmD8Mi24X+nmeFx8X3bwHHrmMHb3+a6LcqX4y4LLsPBtj9Ry/CglWu0YYdJeXxw44qkSi4GvswS012rcxvk/ifNVmhc7mAa0VYr9+ibFZsDlfC87fccOY5ROgDJLTIv4JS/sflTwo1SukfgjE9QrDl0/NhFs5KDK8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206798; c=relaxed/simple;
	bh=2pOUy5R9ZDcB7ZW7rxbzi/13pqo+XELQNBRpWi8UitA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pkwpiBtSzo+3qjjYr4JDLb2bcHFKratOzrwdKdcYaN0lDYruLBLlfF8m5JmWe3cFRpBAbBOiRmADfHdyvKHpnzwGgXMDhTMG/rd2wJl54YcOczn4yg54W71/tdmzTV76E6Cjau61P2hYtryO6o/y3xQ2pTW3txHn/QTxL0Wwjio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aYK+gotn; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aYK+gotn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIvK1vVyzU16ZdDwQdB0PQOAhjdwx4g+hmc3u5Q46bW/pQuclXVr73oSJp10rpMWiQjP1wo4S3fZYIUpHYD2f37a2KPUABRgX4pxFxbrSkJ2GIlQITyt3Ohf5MYNiuyFRcN50YjP+TbsRwT+v0nL0VtUtSpbskwxjitkknd9sOvBY5/ch3fxXgZva3BLOyxa7rAN50S9GkwvY6j7aJJ5MBev5KAQiuv7aO2SI7Xuh2hOG3bTscD1lCqhdooq6RvXHhe9iGanxal0QMnKPzREifZ2MUVtzt3bsXraOI8Pq6PZ5PEsyKNxIFv8V1h2feJBRUiGj+Lr5vEVhvOeThq+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnS62UmUShYAbbKBxskURKV25pWFxj3i6k2T3eaawIs=;
 b=g+rE6nqfsPWNah4mWwJOoEexttg0GTCLSbsmFiGHHBU4tB5MV5ylPV9FCNi8VmDF6dTzXnFWOul1sJop2/CgiHBN9Vf3f29KAFUhgnuz8Ovy3ernWAaP8QMGtTYQ2Q2PATd3qFK7UI4PbUXQkZ6qd2JIryBX078n51tQZ2K/wPEUYcsOC28HyfzZTqttQduYlGv/mBGtbROSxy2ElX/cq1dKrZGBhFvIprh33QbtYeHYuKwoYrV3jfdbMovTNJzwiCZ2YfCr8992O1pMmnSmdOzrstB8CnlJ+yegxErt1eeCjbMKGNOs20xeL9z4WiVrTLeF4y9+JPPr56M5sOsbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnS62UmUShYAbbKBxskURKV25pWFxj3i6k2T3eaawIs=;
 b=aYK+gotn/8BwNFOSNlf/I6+VaFVOQk7Cwup7yfNgEWAWmSzw7zhY3W6nVjWUKYAGGArk+fr01ij0Noyi7DTNMo0PypSdXi+Ce74TSXqwS7093iv/lqyTNVj4pu/yyMQnUuyXB7zwq3npZag30I5KjH3x2gyPJCh9xVOY/NQ6YUvigVkYjFDCS14Gb1EsEItpCofrzOOqvXmKlTZrHtzTbYAonazCC61xMVV4y9HvdeouDUb6Gh/dvXVXbGhiUT2X3DaNO0ndN7qL724A+PxYtNktTafga0P0bVJFBJS5NWq7VExzVr9/29qksYgJkKl3XNFcQg3TYFTuNM4NgVWvyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:13 +0000
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
Subject: [PATCH dovetail v8 01/11] riscv: introduce raw console device
Date: Sun, 31 May 2026 07:52:54 +0200
Message-ID: <20260531055304.2890455-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93daaf2f-2eb2-4ec6-24c5-08debed8e6b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	lYMrmEZ5JeYgy+vD5477a4EB5TmkBYhT4YAcdpmUg0xj6ZzU74BfFKlexuMSi9/6u5Nw//Yqh8fkWp6TejozbYvvRVKBR7W9ziNyfbNHKPEbsW+P+z8Sp4icX5zNOB5FyT30hPw+xqsKtuq03YdzlITm0jme/HOZCSPv4VZ9MBns+KUDhU3ChL+M3xOQD0a93RlE2ibjOeFwUItpNjyZCbPMl8PXRRv04ROQvRE3ucL4+q4PcsmTUUMuE6iokh5F91aQUbO6v4eLsTHwrAJxI7ddb/7dVNe74nBQ1/jig+8/MSEzkKL8CqHQdnF1WOfIGK6BaBfUAQQXCVegBsPGV1JOqXmslEEuKauU7Ar+4Tsz9jh3iKkxqSNtsXg/x1HMOxF8Be07FGyQnIgIbN48RsTMctTIiJHUQuQ4IRQ9PL0Zim15+Lf1KhGKVA9uEpuleJWVc35ZrSQ9bjKmhPoaGB1JVjIFWwH/CBJzkQYIa3vudGFZ2gR7hZAaR8xZDNTnpV+5h2/3MJKBr956xNn+SNNZazwp4/ylmvuORy0wtpGmyqO3NeVgzh6CPSt2Ch3IAuNeYUgLhlbVBeuUdY2gNcdL+IyC63QOcR03rfaDorDOwE6F5lfsB7/QovAdJ2KkL9YdGGKxNnW/OrEPSd2o7zTDZb47o6bPSIJJLQ5C185Ak8lu9iGmnFAUPgx6l8ol
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jwnuw1WM06tjGWjGqKewnROuEv9zl1I21BasSJJIaSCBcgulQJvYD83GmqUo?=
 =?us-ascii?Q?ApgD0tvjw6pVVrEUxGzdTCrE2DL4XyCU9n9LGHGXvrWwrJU8txYhWnoCb/oh?=
 =?us-ascii?Q?GcM4Odo3oZ3qkoE6WlKh9TopXKwZdg9fZR6mjW7MTxb87mTdrmiD7xFoPWdG?=
 =?us-ascii?Q?EHhUigHSwbaQ9bzbVOR65ngeTSN/VEAwx2Vcb1Y0KnCO4n6y/tZ+bbpW1rc/?=
 =?us-ascii?Q?/rtPcLCK/o4O8Q5ES3Oh+YjlsIo44IFur/1wNgWzpdnx2lhky59W3O4VvUia?=
 =?us-ascii?Q?/yY+w58D9vLjY3woqjb2FFKKBh49NJl9JWY+qwMt7D+Fd07zqqvv8dzzj2eE?=
 =?us-ascii?Q?0kUGXJGYQ1HZPSFkwKaoV2F7Z8wajn4HEe6P1rcdOCrLFKlDLQP+zEqwQybH?=
 =?us-ascii?Q?4x28sxR0WLSzowBVDvVdBiQlK/ZHzAcaAJPa6SYwj6BbAlJPop/my6tII3MU?=
 =?us-ascii?Q?KHqTSc5BOfzban9JITayhFP9mOyoy0SkDR7XRx/Yw+rUtLBC6Fsp9cLLZest?=
 =?us-ascii?Q?rTRxOz+ZroF1N+9OyES4hy4Mw5LZN3K70Ur60Jo8JbZAPu7JkIAqkWPl9lm7?=
 =?us-ascii?Q?UQ0V9Vg0NHFO8DotRX5db4F55cyo2Nxpyzp0Gz94bs60hk1PmZJTUgXs1jb+?=
 =?us-ascii?Q?hlU28fhIVhrs70ZBmwh/XkluBZ/NwzpfuR9LIdyypXwwPm9k3YId3VFCiXwd?=
 =?us-ascii?Q?SBGscxtd3SW0KfTgPInywAnNg9/FfzBbmAM9xGUJ0TenoWTOSsgunDqz6wJx?=
 =?us-ascii?Q?/girCTyeeaXxPwhM1bvLo9XpW1CEmp6wr5m4sSatffhC+kfobOogMGxehuHs?=
 =?us-ascii?Q?iRPcplRHxc2Z16zUD3rSc2svxU/lCS5iLvlT67aatY7YkHGjCUXidjBkmbAZ?=
 =?us-ascii?Q?/q3Dq+M6QPj2NzYkGhhQvWLuaA3UQPsIUb9TAiogRVWvSpueXwDDIDjVmISk?=
 =?us-ascii?Q?rMnWV7P/IF3/ARiQ3vzHsNaPNF30lE+ubGFimLRkRwFwQukl5WB6ibesWnO3?=
 =?us-ascii?Q?wRJajDG+AUew8eREFJvW/mi4lAy/HivroDv93VtLqcaLB212oXPjtKzDYgW0?=
 =?us-ascii?Q?dHHe+jG/sdBfcsceCwy0C7ubwb+9fNOhewR/MqfsTxzAL41wty9fKGhlhker?=
 =?us-ascii?Q?V9PuNz5AAPzDAymBP9FZi2pwBm986u17Eum2+dZFTr4vJIep/v3GCRlH4f6z?=
 =?us-ascii?Q?86BuKObO1EYDtJS8jHw3JjQXO3MbAzQzXkTh+hYq10Kz37u/VwGsxxmhodKv?=
 =?us-ascii?Q?yd5K/ttbjh43RmSZPHPn3PRv/9z/2YlE/Rxs7RiSaY1a/bNPfIBvLjPSe0N8?=
 =?us-ascii?Q?KYtM9qiBV16wx6s6mUCUAw4U+FgBk0sy6E+ig9+5cMad3TqcTTV4w5y+Y800?=
 =?us-ascii?Q?ghlrf8qt6y8K+XcnN1Xmh4YH0G2SctY3jQf2Xu4Vuq1km06XQzSz6snBqd/U?=
 =?us-ascii?Q?ii73r1xXEv/thhAwas15Fyj1R1a/UVBTKxFVP7BoUrVhSdO71kH1dCT3z+Ct?=
 =?us-ascii?Q?EY9RZPZsGChB23nUyZEn7wqoEYJDekMxnsm4VkpNTN+WSkiIKZSoCkKr6M40?=
 =?us-ascii?Q?MAnGXts55JuwqwFjox6Os5DpvxYEyOzPJt293+Tq1V/OLkU4fvp/KRQPqyfl?=
 =?us-ascii?Q?GvPTWGoihrHG6uDaeKseXJXKfdIxo0jzNnCHXo59/t6DmWKXdaLdMAWu2VCk?=
 =?us-ascii?Q?ah60pozhGsOYZ+qNNDZCO3Ob3kl7hS/1B56+DYYIe6Qd67qQVSDKE7LH/2Yz?=
 =?us-ascii?Q?qBK3MZwsLSYOZCu4D+1v8cq+FVvUKWY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93daaf2f-2eb2-4ec6-24c5-08debed8e6b8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:12.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz0rFD3eFcMloahZkEKHuRMxuAl/hAPlUdyUqyXYlHY7W9X5R7LZjJREqZdl3io2ekRHqfLCmOkooPvetyCDRYWiLOrp8zJzfa5KGekjvQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

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

