Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AAC1E1DF0
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459729; cv=fail; b=YIVkZQBb13ofkHDwiVfA57BGTsrL99SWoGSnQg1TUqerHzQTQArnryX1i73zVv2cX10fdAktSP2pgLnWV/huXHimZW8Sfq8d1KcoZJC3iYHFoiCXSlyF6AyFWhDySw8bcQfpKY5qyzyGqqIDhAp3ROl6SgM3O+slZrXKcztLJ98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459729; c=relaxed/simple;
	bh=HmTIacp+T9zrO7O2PtcV0uIpaneEr1E3kHe2XeoExwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QLMUMtJvt1Whv6ZruNAYODzmcI6/6MT6sqwKZwmt0V76zhh/dCrKBRJBFhJfTKwlHL4HYZ8IdO4/HEOl5AEGlfrOSk/Yhmaqty+1dvx5YgnMjT5ATx1I/I6uugrO5Y4e6G0J0QfRq9bavNoml8JwBelfOYMXgBfhClaizbtqpzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uCC/VtXM; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uCC/VtXM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VF9Yu4ME3BMmLGZjOj6iD5IT/d6xfVq2oojQn1QHGT8gtj77FoEjE/R5H9pJqEOXNY8umx9SVJg+AEjV6/xy5N1JYpFS2ebzHfWgtQ6GqfDwzBJ8OGu8IlAf7rPoo5bhvov5cLf7cPNFced4I1KHKlakKICoMoGSWNZFd4wAncZItEIFUQiCEwp3j3ewDl8IVTc7TAWIq6ACknwSG0J8bCZshWhyYxr8NvrV6QXCo8WykZjkHiWB6v8rmb9KBcdAlQMH96ePSv9HCxLnWDGJObh9Oi5NMUltSLIJylv6TKTorVefMkopz7fbiC9uRYyI3MpuQMbYY+aMfd0X/QzX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUAA8btj9WPjO5eT1cc1GPO4M0Qas+MjZoMS+1GSZWY=;
 b=GuMPzySIPwrd62yK1Q9yG9iAPAGee/XdK7PuzpO4SdkD1rCnPMFbOv2gugzvrNPs6euRC+m5TRXy5d4vwpsdiG3rZdREUTiMo+xK44CJ0oFfyePYTLJTaWdFmjaNscm3s1uQgSF40dugLH3gERF/UNcHlqEbpTr4kHqsAWdZuQhphsyx3lLs2PjyzlFtgyu0mnQ+KUGmf6ONUrkBZ9238my0BoLTb3sk1cOHAdRJejcfUVmuajPCtiOSCthncAT3QnmFcxWupVTRchaA/uYnP1eOnzsBvmLmg5cES4B72z70/zKN9zcUEFJH/2p7/mSMgCOA0i4yBdih+XW7XRlOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUAA8btj9WPjO5eT1cc1GPO4M0Qas+MjZoMS+1GSZWY=;
 b=uCC/VtXMtTj48CAi9/XTHIyhRT+aDklTcZyvAcgvzNzl3lFVL87E487AuRPlceip61IDjsdbOtrD7V8gme487DXgeZZDKUaJWv6gJraw+ivF09tJekySWMaX5aWooDpMF482YM4i3Kb33K8SmIrVpFB9al5jBwXGMnIuqqIqdGK820SIJN8Y71RSO6XLlYtbjg/WyftcAZM8gQIoySGgOTHRx4x2UvK7m0DGJs2D/gTr3lbrLN1seQhH1fczyAN02jwhdYuezmrbOfPiuKn9n2RujEZoNvaxU1w5oZqk8i0HKyS5SufHEtsY58LypO+G5/R05S3B2ZeYW4UJXBdGCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:02 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:02 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 01/11] riscv: introduce raw console device
Date: Fri, 17 Apr 2026 23:01:44 +0200
Message-ID: <20260417210154.2290819-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8f51162-5182-423f-a792-08de9cc4928d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	rKU18WIcXDTD1UEqdfeFf6mob9SjiV2fwZpCm3Z66OI94zg4QY264WgGxZzwCKTfE0BGn0eIs49igrzaIPFRRbjrFLQCVMZY0E+Luf/aupuMPYJU2j4prD47n4dtJ9xgZ77AgjUukMHK0Zceo5UpBpotI2564khEdv/8LsdZ5GaqYDqZcUEmsK1Clh9bAowSGGiA4dRd3R3uzYLNXfghP6Ua98rzvp+yTKugBR9aHP9j5SMFW1YkZPDG+4PibXwHArKtMwuzCnjOMgv50ZZT+tG4W6rpOBa20/muiSfsFubTpyjab3ZYIx5yab0q/P2BAyDpME1YZ6BhN2GLt5TldqOsP0ATho6jZ/hh6h2+ZXjdlB0g/MWaXijUrnG/8Guc1Vr236NT+A5bOYXuqDfW9nhZ/4RK6sbILU3YHOlXyWO54LhxzZPkXDPE/H3WRvz+GcamvZflto9DpArHD98JkERV4/TkA2HQbCC5LaQoRCVnqkLsrQACtaybqdcXh1O5hjUEybqBOWKxSzc2YHUIFfSNiLuFH9PnEC1FA37MisLIVOdZ1gSmVbS/40pcwXwK14HwRn7mU4+MwmDTfJJOtW4pSl/RWDFNrfM+RBAh1ze8h/e8bAbvmtZnXETY2DmRmqP9SnkorHBXo70bEQl0MFUe8bGVR8agi3VZ4vklBAZNAdtLTbmwHiXktaobeiRqRYL1boVQHzA0Ypvy+QsalU8kUQ164fVRZoOY/F5qCgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9CHT32XRYKPmeDdXb/ZWnKe3Zia401jfIqa3l4ieuMR3kV4I7U62whVsrV9I?=
 =?us-ascii?Q?6BQfmiFHI/j0sU5iQzA1YOsU7sj9jhjU05sc7SUKz5dWwi8rEGPOJk43iGXF?=
 =?us-ascii?Q?NN/NoayiSSgQt3hQKw82wh123w5ok8cPP+ZGHWsPkOIuIPH1vFtWrA34ccXd?=
 =?us-ascii?Q?RuGxkZy9TQu5xmFCCBKiAfB7S5XXdHykHLQ5XL1+l2/ys6T+yFJHoYohS1fp?=
 =?us-ascii?Q?eehoLEgtAelI/75yMHGZVZtvkAZJjqJLetyfhNcHb9z9dvnnrLkO0pIdyUls?=
 =?us-ascii?Q?MRcEb42x6oZEZ4DYaL3YiyBWCb5W/aMXTE5yX2UmG4XSdLY2aOIG4QgoHjFy?=
 =?us-ascii?Q?u4wAtzTSKT84evV8U2pQfmi2lRylEj/4Ol7kI8lXVPRPbTOpEuFTEDzfxncE?=
 =?us-ascii?Q?4PTYMSjv97uQPiLf9yb8pKtmDiaduOe7i9y61WroRP+Jyd1aatJ9gflUyFXm?=
 =?us-ascii?Q?E9UR+v/O9TgFDHiVp3RUeiiqkSj+90O4As9/8VmdDrgWcq4/sSS81TzIDdZL?=
 =?us-ascii?Q?fOPAwB6uo4MNKXoqMd+2pivorKXPfxM6sWFfKWRH1Ie6IQAbpSiPo1I04Lwn?=
 =?us-ascii?Q?bXjTkOB1/xBv76xX2iQJDXN1WXvHG0YCR+M4cNxEU/fd8S09sB2viqAd392T?=
 =?us-ascii?Q?KSqNlsj+nslQU+MvWoTysR3huecSFnnjgCNXc5rmLArfBj+dGyq6J0S4U7sS?=
 =?us-ascii?Q?XfT+pdvGFa4K22U/BCGSBajdirgdRgzNeDvG2FmfOpbOiY8mQBNn9Pfzq52A?=
 =?us-ascii?Q?Hhw54OVFOgdnQ3zYZrImHXyNqijNkIKqbLikwFZRK0UMa6Bv2OiS3JAHtBHa?=
 =?us-ascii?Q?2tQgM6GgItpgwAnN/hDxIQoBfVgWLsZNaywdR8NlqWnPptf+maxL8+O0dqPu?=
 =?us-ascii?Q?jraXBLhG43k3z7zrg1R1QTMzdaXifN8EeFEeycZd3ghBCFh4/DYi6FKc8Man?=
 =?us-ascii?Q?PLrAZEvljjZKwGTNMxwP3w6aSPOpGpfCNnkoESz+FSIyG2prwKkiOvXjtk6J?=
 =?us-ascii?Q?cv2XC1Qd7i1WKU1pDOJfBLM4jzOA2W38LEPIAuqbI7L3d8ldRLy0fxnCxeQg?=
 =?us-ascii?Q?NIF+Iz2RMgeAjtXE0PGKVwHDY+G2o9/8+53/PkzJBKO70SC0GDE9P8AikcYr?=
 =?us-ascii?Q?wYPd+Uc6mjOvKGIcDdX06pRD/dmRDg85WUQozhMOICHAk7GZKKpHOJs9HeVZ?=
 =?us-ascii?Q?dhgdOUhL1Pf1bWYM2tKek2taiOP3lg9DvfC3bjyGegzsLJzGQo5aTkyQopko?=
 =?us-ascii?Q?dUFYisz0tGFvs18qL2fFiYi8V7QbVDV5HS7zs9oWim0VV4/qinw1dv9atxgO?=
 =?us-ascii?Q?kIOrgs+hG9Qpmd3fNR0Gv5SxrmQEPypzTTKSxPtHQD9Oxpz8/YdhLQ48/nhp?=
 =?us-ascii?Q?M+1SEXFhZEznB+MO/mRogsbUj5bjvIVYuPUPJC8S4CRUPsc8XbY38rF6pr6C?=
 =?us-ascii?Q?Rj1XAYVVUkiVWGO8gyykbZI8lBFlNM4Js0Hp646p3j8vgjaeMbIXuZ17+agv?=
 =?us-ascii?Q?WU5l0AT4mZf3q/1JUwCwMbYQhgmtqbwYbV8Y9SIpPP07LvnbiK20TMpbOFA3?=
 =?us-ascii?Q?LhYx1yMTxcsRGCSfdNF8OaogIhnjQdhk41tQ3ApfOczTJj8f1JyWyjqimTfE?=
 =?us-ascii?Q?o2LYG4rBZ0ynBJlQrBfRfQ4HebekAk9Ohr+Rlb593UOUOaqNQbUKDm5IVeFA?=
 =?us-ascii?Q?2VD2lOeuO3xKZZxMPbOK13bZmwYRzGZBtVQhfVhN5mrmidLem7htyZafEH8d?=
 =?us-ascii?Q?Ci5diYDUTz893D6F5QNK7mEfcCGAgio=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f51162-5182-423f-a792-08de9cc4928d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:02.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGDqfphxlvJDwT0Cj2978Hxpowj3VqGvAMRKS1Chwe9x5fhrXxkGWXhJJHyla4uLN54PS7ZovL8dkF0eRFMq3q7R/53sRgq+4S29hTR92lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/raw_printk.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/riscv/kernel/raw_printk.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index cabb99cadfb6d..4e310257499a1 100644
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
index 0000000000000..aa2f287daa29c
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

