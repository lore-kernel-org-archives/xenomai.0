Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1B417369
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092474; cv=fail; b=IkKVa91MOxrbeLXBb0RzNs2qnv4yAY07AuZdcLbICI5kYcmevzJbUP4GLfcn+aFUggIq//wInMsjYl0BtchlUYVTXYwPGRq0rCkxrPJYDwtocxJvi6ciOJvwhnfsUqWSGZRDHoez6oDGRhp7ZLsez1QjP0iVGaFHk4GBWaVkk+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092474; c=relaxed/simple;
	bh=VQG+imQck3qEKrZpfkDvE9tPRTSDTYOKHvDKlVE3a3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSJe+CDjTUEqOCd2DT4Nt9IxJe/1aCytQwmSwrVoGmfW0zK0BHLY/y4k4AC2e0NJooGOd26XD0h2khQTu9fcY1guYoawA0vaJ3BdTwHLmMw505OfQEGz2VosfVYUBZS88e7V3QlcbR1AsorSpsbfnezJYiB3ZN55VgFfWHEaD9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=n9Zx1qKK; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="n9Zx1qKK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ4gNYBEsB6tVBn3zg+NTU0AK1evyoc5qexgJIpxwiDdHpa62TMXTMr3yn5329dL14ufT03VyaslLztwg+l6ZUgO/MZUcs+zvGV+oP3VlQqhwFvDYgsUSM2vLhTZTXBLRgUWiDU3Z6ndvL7vZOnJB+bLjX1rDYA4UPiXNKLEcQKX9eXsYaeyTH4faO2jQ9c6dKKfBPA8UxcTt/2yts1icE7uxUaqJn+bWZBJ+55FxJvEtW2+bxENm5iCsSemKUp/YYI1oi/TVq11PwKKH91fFwkr6pOfOLuthN6YUUkueSxN9Ek9xPNz+vqOIK8NfjRAnATE0GN/e6ssKTebBn23uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqLIl4X3XUf5E6DDHL+OvYySCj6qhf+dlsSrAyvB3j0=;
 b=TRqYsVtN00RFVYArEi0PPkGmmCmxviC+BeVmAYFXQvE/PeuIjJv3Mn6vZTTCdMOsEev20Wek0xl1nPSuWwEOLfqJugY/jA8GaEpsRjzXKDLppJ4HV9Porsz8FHMRmRXe1pOQmflwj93kyK+i0YMt/jUEn9mhrlMWxvvMfYZScxHNjiq7ld418cdkuAbV7LZQHqoWB91aL+8OeMIy2lDEa3l80i2JITHAygR1FLQC86cwgxXXM4rlRkHBxgvYISWPCUySxxo22JMZDdf4tPJ3Yzk1caXD4DEKl3emEsZnMiei3roEF2nvMgaLP7T/fBxtnExbMVzouqgDsKJuqHRDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqLIl4X3XUf5E6DDHL+OvYySCj6qhf+dlsSrAyvB3j0=;
 b=n9Zx1qKKTyadZ2vgLXBmcF9SpktKzQC1bvrEy7HMDeAX9phX8zLTxMlYI3jzmBGE2cIPvLjg2j8RtluzLjPRZJ9zCCfU1XEq+p/iZ4N8tzNDwR+ygXwBKgJUSrx+OA/DwiMWah4FJ8zvPmHST8g7ctf02HZ3Q3YDQvbqx//75C6WXS7mS11OqXeUJ8gbIcqnEi7cgvcc3OncCkTwsvLNbS6SPqAQ8bH2r1sOyK1pp3i/Pn3tTvwDX7fvZziS8gvJ/E1njv0gnmyQGpyfaoOtNrliYb8L14VN4SZXcfWK+HAF90tpAOPA/km7j0ZwZsBogaC1TAIREaGO69+huepRnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB7614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 15:27:48 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:48 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 01/11] riscv: introduce raw console device
Date: Fri,  3 Jul 2026 17:27:28 +0200
Message-ID: <20260703152738.129122-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2fe6407-1a28-48b6-9ffa-08ded917a294
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	qvblI/jKBdJqGTr7NStoz/mfEpgFXEbaKG50euX0JvoZuubUUCDHKu/eYclfDQkd4jTECY4ge+0YX26NruoqH72HLXD1eizaDAdrEevQCJY1RgKZbALzwMQrb7/+r4Go9YRPBOlBSlK5zX1F/4Zk0BRkBunJQALUawpfoRgdsPQEeqbQzfqyU86Uz6CGVIDqWKp9zUQZplAOjs3OLFqqP1YV6epGXPJ1cF/soGuCO+TYBjEP+E1Y0aQEd98dl8TBAhcENKaZG2/hk0+Gt2XA3V8oNznKiCacNRJ2XvxXzfJeOVozLhwffulvaY9IeDf8ZFtzlPssgkHirUUkJ2FSp/1eHvrZM7nGXWp2xUynT9SaV51AMAJzv7m+xnLDYPheejDhksGcCVUZU1X55aKgvjLcxGg6sc9Q9wGiRwgPuhNKYF+xZGmedDrg4m1ks9OXlzyURvkvPvM8aXHs/VqW3sIuJxR46HH0bEMKpD9LiQm8rF2cObCT/fyxjmqbLd7L/HDslmTxTZ5IvRj9PMP7ak+Tu2/6mSOHXRhg/Yn8lJqSVQeo5nrGwg03iNWt6RBTyxwl+1YqHEPPAd55nkF1vsFQYDou8wyF60LJHSeO5U8FbcSOKPninEanko3Vsz/n6BqQUV0IP4yyQEBs/urM3c/p9NifPtpdgipCxB69XEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTDNK03Q4/2tb4lSzI9ouxReb1i6xB6wsnFYZa9jxZPX9L5Zg6tOX874ksmO?=
 =?us-ascii?Q?/n4je++1AW5FzYoplrpqt4EY1t1lYtJpCubbKv/n3kq5klmVlS9wHXRHcQv9?=
 =?us-ascii?Q?7U3QoXIpb/V8i/OT2BA0+gsRKl4hfNUlXMUDTnzsMGCGGFpv069zVRo1Jnj0?=
 =?us-ascii?Q?q2lGC+U/7Cq1+PTh39bK1iCCcQTLVCfyXbtw1MAaMKhSuLFqLquUwfcP5biT?=
 =?us-ascii?Q?Cr1Y78zfJvX0wzHQhErxbCVwNqT8mhpwXJsoAr9N/4lIEXvyb3ejmYjYRvWj?=
 =?us-ascii?Q?jQ51Tewfzjivdgs2D/3VItDY9QRHNxsJ1YBhiIVvatwqD6MsnI4eA8XekdBD?=
 =?us-ascii?Q?JHNjzwy7bSHRztxdVGTVXtDfkTWTd93i7J4vZ4XVXjtVeBjiAgtlE+K3PLty?=
 =?us-ascii?Q?etdNYSTYwk+0bqJGl6yBu4YrPytywFWfQO1qLPyhYD2exebbMPxcqOT4FaTw?=
 =?us-ascii?Q?7Io93IRKcL+vA0XNPi3HL45tIY1IRXvDz8Rfh+4WFALPCJBwyz4TSTShAN/C?=
 =?us-ascii?Q?Pmxl60JdRccbnSaQg//j9t340O/9+ertDbh8SZKtXtVFTm2Sd+MaZ/9ONwcK?=
 =?us-ascii?Q?4jjtqCRv6nbqi94CI7305ikg6E+M9NHGQ7JUPooUKL9NfAx+J/JVIqM4ifKg?=
 =?us-ascii?Q?m/MSygR/oGrFig38oM0iakVFxqh9Z87sl5dnYRCTRY25ZfgyhGHsmBdbnCnH?=
 =?us-ascii?Q?VaAa+XIMr6PSa2txFVJtqgZmW+FYzS1BZ2weVhZz8dS7F99Z0cyeHCMr6EYf?=
 =?us-ascii?Q?bU5GmCUk47cVU3KZCk2BkQvarjJOzPhjsmQFfWiXE5poLv8+nhx10SYDqXrd?=
 =?us-ascii?Q?1Fi0JhvRqdS27hOyydA28FF+KFh09/+/D5rn0q+/hutewzVexLh2Eb0rT7ZA?=
 =?us-ascii?Q?PUBZpC4FTQEQXseLrPxMGREmvsP9FhCoGAxGk51VnhWyZ2Ldqn4EQXa7j8Gg?=
 =?us-ascii?Q?Haa6RQaypBQUS3Q5mDy5+8yVccFD5xxdAqfUCGmb2/9bMuBg8zpk1rlQX1SD?=
 =?us-ascii?Q?cOo2rxlbQUF/K3B89WKaMXv30aGDyfdzejBwyKssu+a6Nx6/sbomUc2L7xm4?=
 =?us-ascii?Q?3U8s4xgzPzhALO54+66dat1uiAeca7e2pqJux88TGEnW26lCYzy/79rt4rNW?=
 =?us-ascii?Q?Dgj9qgOAy+ZCIlA0kw6eJk59CjhS1+kS0JN/591rJHRH+I49juAMQXe+Ak99?=
 =?us-ascii?Q?HmghkZnVuql1fojIiqWqQzxH/TvNdGzOINUsHDWpSn4qQesHF+gUtpT/n+Am?=
 =?us-ascii?Q?AejeFsu5K8zW3sYepPGD6mtM4XhOIQL4LvxiIOfl51av3AaZuHq+NSLQBCAs?=
 =?us-ascii?Q?SYEzgBcYr5A2nSD+Ep9Uwbc0OfGnQcT7JqlaL1xsUNd5wmFCee7vUMX/Q7E5?=
 =?us-ascii?Q?938AqXau5IzUV2R7wKlaaRz+2Y+mBf2FAf2yjEM4b2FJTRvBYvQ6Om1Nsb/M?=
 =?us-ascii?Q?gDD+e/oHQABeem1AGX/3l6O3Pa9SRShuq+su3/TXNN/8NU6Y8ggpScpZNeB0?=
 =?us-ascii?Q?d4DTE8nC95pSf0vZamKj+pR9dl274QZMzVVJlEcaU/zG2urs1B0Z5tmhd5Xx?=
 =?us-ascii?Q?lbCZp1sePVgv/XdeAyPh4ajK9Ia2dozZaG4W/z2GP3aTuDXcgV5SC8kbZN2C?=
 =?us-ascii?Q?/BWYzUSjkwdOezXyifQlllAssq3DXKE5f4dQvsH1Ykz61MKCoymuzg9Mfdfr?=
 =?us-ascii?Q?yFrGsWBpyuvinEO5DlNKZmLPr9Qdfbwz5Hpo+CF6XJWZlTSDLOkdmRg9lh/v?=
 =?us-ascii?Q?8wBj/QqdxQqzg8LxywLfJNbXECfmMI1zwg/VtYHJiJ2cdJ6DFcZOn40dPllM?=
X-MS-Exchange-AntiSpam-MessageData-1: fXG5fULCh1p1hwtBHKV2g1NTbkcDGQWb3rA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fe6407-1a28-48b6-9ffa-08ded917a294
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:47.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nlp6BAJ62wpe0UNueFzSvWdebQ3I2hPBBj3hMN8i5bZHVIX1VtpUAbsTN6zfGjpWlRDqBeaCwoZIHJaBgjKZPTif6ehK6HgS8NKD+ImaB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7614

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

