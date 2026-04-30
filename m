Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BE3DA7CB
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547475; cv=fail; b=h41tB04U+sTBi0inVM+7UI10qA3ZLG/gzwX50vTp5KCTBBFJcEouCEBOWAOPgqbaw408521Y6+FPbjM6Jp6UXMF9RxtMWOwXX3bqPjRCkJ4rStHCft0Leeq0YkylL/C5s14nbZpG7hwBObUkNcRgDGDZOpPetqkMotqjNx+5a+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547475; c=relaxed/simple;
	bh=HmTIacp+T9zrO7O2PtcV0uIpaneEr1E3kHe2XeoExwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkbnirHlud3mLPU+AQksBXJv3d/4gl7J87Pyu1XyluH2x40vGO9K2WY13Nip+XDMvTbtyQwXKuflnlUgUB16jiE7JHUXPYJlOFGQdn+Vz7ecGxH63T//ha/c7bcU6n8bTQ3/HjzDhdXgFAMx/Oya2ZaJnGdrO29pN1ut5Uum3xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lgqhxpu4; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lgqhxpu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX/FEUTCRhT44yupEtYahO+cegmUhs812eINP0Jedkho+Xi4/uI5PbNRoQ201UJKYzw1IFV2GoiQr5+knlJGWv5KNplaCVlT+piAYT7nqF7MjsdjQoIVonsLfyNxyIEe8chYbNQGyg8DeEElF9GgN9Q3HwyIzX5aEtlUb7QKk5+oddPGm9uOqF+kwwRrL93yI+H6T7CdTkWGsIQZxW7F4/adb9FzgEzvKSyE82Ql/EKbmEaQ1Y4saxZQxRrxXCEzlmrO235EXVNTMNRksS8RQuy01IS6YLgPvQvvNwl66Uw3nmYmYfkGprIMjoiqvhMeuhDWTU6527A8YvXoKRfmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUAA8btj9WPjO5eT1cc1GPO4M0Qas+MjZoMS+1GSZWY=;
 b=fAJdynH4ifHgJy3lzY38QabI2qjiwAxtYBnAGtoJ79udZ0MidkRUGUIj5h7lCwsHRAMix4xyR9lFui9W/1B69yQl2wWAF3ea+Tf40B+lApBVeryVyIS8frascBfFom5Tfb3ftoFpDlFU+pCttNFjuQUHOdr0D8aCzirNTQrrEW/ZkOOcop5WtgTXi1NzQz6gDAvMAvqy1mlrqzAWC7z0Eeq4wWKbKH9RIOwdZzTmUYmDRWckL4/TNJGHOBVevNVytAAg0Qt1A4zbfcdeDLllSabg9BcUgDHCMWmFKvdrJvW0ImB3TPKPnX5uCcF6zYqVpL9cxfnqjI7AW4JbFIWtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUAA8btj9WPjO5eT1cc1GPO4M0Qas+MjZoMS+1GSZWY=;
 b=Lgqhxpu4KkqqrJu20aSA+8riQ/qg25ouqf+AdyE8ibMQu6Py9tCJpVp028UnT87t9XOz2W/1dPvMJ/PgnpdDB40JuFpkGJreJPy+lRiwACOwCjNhzOgYi1ne+nrDzVo5bvfQ7EM4JD8hHD8K67PUN70wEfU4i/2LAxCfh69CPsRspxcA6UXnddt1FWEMelTXHI9DcWOn5VkqAQxiooiNprZVBXw7W2wCkdPKHBIFsBuCR2W0ZI9/ECwcp9DDgOx37MqSTZx5hY3bwPL1zk/V81LugaKTTOztrVj7rl9Oat15LFm6791907lyVLLKB54cnM+XDTVMNY4k3AW7q1OHNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB9063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:11:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:09 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 01/11] riscv: introduce raw console device
Date: Thu, 30 Apr 2026 13:10:51 +0200
Message-ID: <20260430111101.1539377-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: b14aed08-c707-4b92-8525-08dea6a92e79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ajnMRMLd556iAZG7w84Ib2uPodchwSW/ZEz8qX1p5Z6aUh8dE6G0L3++sls9E1BIXSp8TF/52VcnUv5fTIenGpb6tK47FN0RAV9rQb8xdglDC06LMffvCTIBlbx/hk3EOBtP6VlQeyi1GwKALACcgWEgEgrZvPKJOGNHLtG6e9bDLBt7NeIVH6+aD/J8t77rx9L+2AVTrhRx7i4R2L4/Ehtpm8u5I9cHdqszareBhRD2s46dfMoNktCFCkJ+QpaPpe2pBJ0d2husRSKLGB3r5v+IrLlaZQG44QhdKbYojLMspTLKUCbU507yW94gvKoVBCSW9mNmpYBEz1nfA7t8oPqWpSu8na6vNW1azOxH6GidmiKJmnw5jo+fXtcOoEZ3Jxr45ToAur/f/+Wq9Kt1O3DSkatKGGMwWeTmrcBH2SDn5vc+lMU+XdmgS89qNTSqG4Xd5ZMoC1cH8OiBem8+XOv8/7v/kvOn0PEsM8ZM9kTkpp34RomXDAgTFGiJT/IPleZT460UXQ+puz/vTLcKS575y73E073vOOw+Um9TNwcFqjxaYldGdDMsb22fem3e/elJLFtuivJ5K/GkPBVTQF1X3zXZRrgd/d6Cz8OdIE5lq9mazPXDFNjsUbd0ECCOdDBgxOD3FX7IrnYfLlwkvxsN3gM6UI893SRgim1v/uwVqjvNaIrt3uk18f6pr2crgP77RHjopR2eISaQUF5nkB2YJZYeLtUJbLbFL22cgVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQTVmSgnLSZbPeoVh/wTZdy3Q7TmdZVs1TUiQu1uC52HBSCGUm1hga0vjKVE?=
 =?us-ascii?Q?yYZ4hEuFjzxJX0EMyGGIq55/uZRv9NvJ6krgGdhRsGD0w5wtF1KMaDGbUQu7?=
 =?us-ascii?Q?2aYncmMQsvKE9XmKTUYAzc7+FuW9NXC3CIyZDOHUSxalwJEcw/EzcYKLysvj?=
 =?us-ascii?Q?3qhXtHmqOdEaj52QKZSdO55E2b0KszEItBXlxywHvHgtKDwZ8zRet7F2rgQu?=
 =?us-ascii?Q?WJ3HoQl13EZb9sXoMb8rX0AwIjo+wCrXL8VQyBb+6jYuFOsTvfHubdD8M4ev?=
 =?us-ascii?Q?tMIRosX58Yqpg1h4i8bgZm8BT4fv7Lq+in8gsKwO1+vEZ1ZlL01lSeRVDD+Q?=
 =?us-ascii?Q?ZtdU5quPzBILd4/Z0HXiz9JMzlsszn3SG0WsgGu40QsMXtQMuk07gZ6vThUd?=
 =?us-ascii?Q?WRoR1j1JK6LirUjfEEPPPm2ITUqe5j2zF0U1WQpo7bcKpLLraeAoIEUuIW/z?=
 =?us-ascii?Q?XwhEDJDXOEZauNOCBWIN3ZITliRPCCt5WIzZSZQv9dA2UoNT4IdxGY0ZHrWG?=
 =?us-ascii?Q?lStVhzB81aFVAtWzHxlfBBq/R6PTpCQnOiV05ak7RRJKoBg+mY5enP06uu+Y?=
 =?us-ascii?Q?yogkgNA+nGdzcFap02PC4aExkjw12jUryAcXDOuJssElroh8lI3niscVIEWb?=
 =?us-ascii?Q?LFbo/SgiCDRRb3i3V5KtzeqbkiyqYg+AC+XLmc2/fPmD7e1YlJudheFfRnwm?=
 =?us-ascii?Q?txfq8wpZcNLvhOCuyBdZPrCDcEq/IVx9yyqGdwbXCaxvSR+VQdkwjg6S3lSC?=
 =?us-ascii?Q?HOi+A+dGIfHPl6eYpH90LUdt0jB4MdLZkdERm3+oBvoISGiYsKVN8tShPkHp?=
 =?us-ascii?Q?A7jT8HcP12nTJK9nudrezH4jo+MZRgmByw3PQuA2jJAvzNdFp5nBHQ+Tga/a?=
 =?us-ascii?Q?nnnCRPIJ4/DIa/tA5c5JhcCn8lJf5U/JJ1rmEPMFHj6vrh48Ph2GxWcnbE4z?=
 =?us-ascii?Q?tx1T4kFp6jvFCWhyMFgmAuYulPdOt7Yc0pSQeSkS5AB9eY5AMFfkLBiLrw/z?=
 =?us-ascii?Q?gsMIIF8B7hf0mOhCzO22WM9HIJJ0VprkokzPQh0CEUjz0Rbwmx0tdQtrOgZN?=
 =?us-ascii?Q?sO71dt3rcOYKDhw35cXxEupRG6d7/zJQIsKp2Nsi5qsBjs0x8TT4unJGiE2p?=
 =?us-ascii?Q?qIbqIF1uHsgrA4IU3qgMUrPy0Plq5u23aS9ZOujJQZXGVPmXM4rzeLCRh+QG?=
 =?us-ascii?Q?ZMkwgTHNJ0fvnvI13ULEbrCXJtAwukN1TmBefVi5c0+HNBYj3zTUWdpopn9V?=
 =?us-ascii?Q?o5Z7aifykOXGA/VmYY1pmS4D9MyBqsBJN+o5AN5jTTtagEiAbrRbLB2o33yb?=
 =?us-ascii?Q?sixeZmDHPeqvvrk4zf0RkDcuWdPHWMTQ0/x2v22I7NeynzKoE6JLLAjVz0I2?=
 =?us-ascii?Q?aqLpi9KxZ3AYy8IhBfHOBkBslfY4DXLF1CchyGqSI829Q70lJduKg3clnhtN?=
 =?us-ascii?Q?AXl1a/xVCTp9O+R7ULGdc2HyNRWOLuCHpKTLyfbNwBbP+qc9A4EvYi0qZ96i?=
 =?us-ascii?Q?eXZNlTmSFFwHYQrn5I8am80PvnuAcLtnZrdOlc0RJDLfzhHK0CpSdKlpbPZF?=
 =?us-ascii?Q?kswMg1TkQKnKrfh/o1Gz+ZmCjTOl7DbTReOdUBwGNzS0wmw1C0SaFV62A2cd?=
 =?us-ascii?Q?oS4++Jk2NOudZAODJaLWfC2O8wY8otv+slB/1wsTOFqLdGKuIYp9zZqNdcUg?=
 =?us-ascii?Q?h/DEChdsdZ3mVgDUGbTLWDyidig9G4Ti0hbEtxD2jMtBsU+pwMCKYyv29Cxt?=
 =?us-ascii?Q?3U9GPE98391NZmRLV05Yde2O7CmP0e8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14aed08-c707-4b92-8525-08dea6a92e79
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:09.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRrO4lfmu8wAE3MxSXlwbJYXqGVcZvHUjd0dzD2nt/jvut0I2qFMbDShehOsGBR/X99OaB24QE9HuJgJvcduLbcNiq1GQw5cNe8tfAb6Ta4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9063

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

