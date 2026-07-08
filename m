Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C73BBA0D
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492082; cv=fail; b=PM0ZW+krjhzjFKc8DBR760nBshdiSnW1Dm1wPYoeOJg7eY/Bu9oCbH2HlPibF8OytpOUIblBgxQcST8woaNHWNmbSDEE2s5umfECMDYVBLKACIYdiKgptLs4g71ShxyQmaIyDVQwWXDgknz/567xPY6ypxXtqB0pPCSwJjsG2P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492082; c=relaxed/simple;
	bh=VQG+imQck3qEKrZpfkDvE9tPRTSDTYOKHvDKlVE3a3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KidDJfpyiw+PMzXfe9h427eZBqIOswUmGU8vdKyE0ikBtVdzQfaBl4dBa4YwbHXXwSvBfoHEv2OP8xQEnbktYBY96qDzVlwScik3zbZ0j2vR5LI4CPgtBkK/sRNQKrBPuKwDc3cLO2M4g7zPdwezbScmxzxJ197o5mE7PFIGNd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hqBXkYfT; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hqBXkYfT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO7QYL6/dwICEqjbSXjJXUuErXRuDBwFDqy2V6M50LiAcw5UoepoJS7UIbr1cGfcApT6dK673Mvls3VEiT2QOjQZ5z8oCM2FfmUM5U5StEsCjZ/ILJ1+3Xl62lV1HxITzDY8U4O2oc177Gh/J1AyJ/8p8r9ZIGsFGhG0aqfmKRTKuIZMB9cm8IiV8AWOK4guezhmOKch/zWVMiTsBHt2pcvQRzqLBUmzyDBO2Jm/2Haenuey6VwDtqGmLcxpTi0/mURBL2DzIxhCPwaC/hB5rZKvC7BfB/CWsvCct+x8DUgXH9MX6eUgtEUWXed5gWJwobqHQEnlt+1OvzW4e4JOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqLIl4X3XUf5E6DDHL+OvYySCj6qhf+dlsSrAyvB3j0=;
 b=wJDURB6GFeLb5xt/BIEr9/9I7Um5cP8PmTmznfQiKkKFcpfZSn6dFqdsVAniVOpHYLmpJpyW5WY0Ckjge4mY9rRnbBmlW0Zuyx+r1tAV49Xmgc0gXG25BKuTYTrWNYa4AHGL3vcLlWqWoFaJak9DpG4doNS1liHZwr6YXvAiQRyKic46Qg9Ii1KMLHdD5E7HZ+c4yTnS+2u+iH9q9sYJ/g3mU+TdNGiK27lyfv+j7bCKr4UcUKB4t6YGfpL2Rf88ebtIe6O/zaC+aSTvcpbPYJv8SToR9Wv2WepSfzC7hv0FA84xJYLGXZ2OpRtxnFhltdSz1UV5uGMelVQ0Krglmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqLIl4X3XUf5E6DDHL+OvYySCj6qhf+dlsSrAyvB3j0=;
 b=hqBXkYfTq0ivQmDQR663HnacN4e6rJL6RaKI7j8PhSAXKewZbgkAwscW43N/9AxMpUyvRFjm2D2xGAWyZ6qB5W/jmkumIO5Kjv6NgeriZpqxvyw6Vpi+ynhdcS9EtzRuK+hOdcf404nU9IQjIsw/A2DWYxsOgkZxbbNCrw9BdytP6GaQL5D88WqVWWoLEAAvUWFqecx87xtUeScMitvORy3amEbXmwJCG7VCQFX71RdYj0gS7rO2nwKly52RgeQ6fyNTRyTmnIuLAp5tdxQtD7wogkCTAZbvz9cTKYR6RYBHUXMHWinR+ZqdNe6ogOuTV3gmXSbjZ3eFXQk1M4emqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:56 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:55 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 01/11] riscv: introduce raw console device
Date: Wed,  8 Jul 2026 08:27:38 +0200
Message-ID: <20260708062748.1029852-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eff6952-074b-49ea-b162-08dedcba0c1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	r7QQ2kFz45D915NkMC1AQarAsBF1YyGkEUrVnF4pU8kuIcPQeqU54cSgqkyLS5g6HYLXDZ2PyKthJXisvJYvWzPgrbYQdECfSjXVXgDqZJvyF2FoWQA5/u80TH26AkBAvQfjQegQUfh3HBZJqO1YskUvNAlEIe5uxCdTKX+bhdQqBHayA0H4dH3KpGeEzPjAtpZPmUP9zDgs0HDW3Z8SkZ0MQagojetid39pURpv+mDSRoR2j2hmXBBOo2USulrb4cbZZJV274+VY3RNvP/1ZacQDj3TN71nLm3hvi6fL2xEY+bv0nYfhvCG4pERxVkhhaKxOB+1ZInvK740KuyS13vlCycSQ03NtUnVIEscx4QoYZTHdnS/0d4dkaSO4zMAWn6n+IYDCqJQsAuJq9obYw19q6PdnK8DEPiYfzyvWeq7e6ywfg9d58e+K/mxUG1Y+BAuVVmliJNJsn/Za8yAo24usRCSDV/nDRPhN4yT7CxYMxSI/UrM+pRKPYGWVPcD1biduEhkRzYTVaPMlFIz10FCsepEGWOAjPFG2726ofRNJaYYVejD5WQpor66safBvxB7X3mrL2z/FgIesZ5Oh+LI5ePJUtIp+eMztlq/EAWpA8Oe6+o2uSHPVKo9frttAeup2GxBf0gOCPVnHoNyLsCz7QKizzQo91Mu439Dbqs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WHcRZayq1tfOja+ybcE7T94QIVghgW8p1qT0cB86K+RSd04B7zaV+hFxgtgW?=
 =?us-ascii?Q?iz9xy/+xUhRLWMKtgaafsBCqC6p7hWXIHxFRv+EgVUB9cUDBPFMNDAXUczSr?=
 =?us-ascii?Q?w+PhZ/Ccm/wUm5AG1vjzzHUnuJW/3MWmHm1x6ZIjiKebXfU59EBPq/MCBEhz?=
 =?us-ascii?Q?6Un3LKXVNho1ySa8Zc6+sT2BgF1YMbDUV2/L+BCrTBd2Yi3j8g6w36jpx1nc?=
 =?us-ascii?Q?PrkWx0fjUm0swOeXd1Yi284jGib1CoOgX0g0hJmiolXJm252INkwxDEjiJlI?=
 =?us-ascii?Q?915n0tpdjM9GRMuxaJOE5Nf/wuS3Q2K9UyjfXUB8Tgg9hmow/8qOJjrUetgF?=
 =?us-ascii?Q?jYBTzcVbdYfvPTpz6mUY75u7enPLA0XVNBAy2AQoi4rMUa8u2juf6YCUeHUZ?=
 =?us-ascii?Q?F1t+rqPgTy5QJyQSmicEak49/446LEUTovSGCckj330vK+mGjL52Yq1q8dhp?=
 =?us-ascii?Q?PKUe83j+Iu0iJ5IgSv2X2lUPzaZbJVr/AN7tFEF4vKutq1vztyeDkn7Z3kq7?=
 =?us-ascii?Q?NfLw5gw8lk4eLKj/qoeb4det7SW2ZP7qprEOWpf/RYJMtURI2etMJyI6hDry?=
 =?us-ascii?Q?kYWWH6qU3qgGEIpI/XgPY3rhiWAVaBJVpgXqwEhdm62QmP73pWCPeLRdqjP1?=
 =?us-ascii?Q?cZMwuvRTTBrsqO5kgd/C1dQDbY5eCglgNd/HZ7kctS6VTUX0k8JT50O8boGD?=
 =?us-ascii?Q?OZR5AmOu9aFpKgaa1qNuEDbysbJiaAwxEwnOaAmEnW78CGaTmM7kbyFksUfF?=
 =?us-ascii?Q?ruGgpx7cWVly7CJEPUbP4G2CgHBrQBzT2b/7UucAZcwFrszadXkLQKD8j7L/?=
 =?us-ascii?Q?6k9FT2Mcc835hiNw6M/KHLTdDTXyty3oHAZCcRmFEWye4C2KSDy1vhK5R9RQ?=
 =?us-ascii?Q?wqJs0jiRy/yH+84XEp80OxuWkHt0Ob0IODqVVIBiakIyPvcAzTNcmQD/ORlv?=
 =?us-ascii?Q?w6rl97jNgao1VtxzbrQMMF8q9zkggh9R0GPdCcLUe7yncL36zxGjntk569Jh?=
 =?us-ascii?Q?Fti4Y5YpsqEeOt/bwKJ89PPzvhWR7FgURKH0EM4sitbcy8dpCRZ2Ty10o+PC?=
 =?us-ascii?Q?UMjSNPFkk7NgsbnVWbnOPEB7TZzDaHaIGI/xu7wKftOVqV6Byk8UqDo12+8l?=
 =?us-ascii?Q?DFVtmlVhU0Ai43SIr9524iCbMXa3RgFK5I5MoyoU4eSgF7WyVOJfXq0EZSqS?=
 =?us-ascii?Q?L1ggOD6NJnPYx1FGOdOMbxQk20VTd8WU+pY2JJQia92NDYnpBgybl4cP93M7?=
 =?us-ascii?Q?oG5UAO8O2D+3LljU6gNY11zYRlZz41DsEIAMBpISqHxqJNRvquq0a3J9daIh?=
 =?us-ascii?Q?ExjaijIIjVFwlvUICb+bnOtxWyBjmdYY+Rci9XdJKhDOuXV5fSCOhG3q91t1?=
 =?us-ascii?Q?Obk0B81H+zuRjeO7zD9ch0TtC+2rbvdVmtAAZN/8OLOSgyZAx3FYFEC08RZb?=
 =?us-ascii?Q?+g6WdpIAoSROHqD8NTnCB8IbbVHLSRC27fwvir+YRVpwpivqmWBDWKioW5uW?=
 =?us-ascii?Q?HG01m9cRoybIhIQ+AkCTRhZMmV6ZC4baxtaFJAQFsDa//UNRoOTjUKF5NtmH?=
 =?us-ascii?Q?i0mOZvpPqfuT0shn/w9HxGKAnbocKTbd/78i+EdEy+4LLqrsXmyrTfn53UNZ?=
 =?us-ascii?Q?yjmt/bXGO3s+GNg3d+yLL/N9Cah2ESpwxuRvtoOZTT364M7tedb5xNBqdCLL?=
 =?us-ascii?Q?7vqX6VFB86dxavHSmyHt2GLOf9iQHO5cDWmYfmHJjD894hFnr4zjnW7CIxmm?=
 =?us-ascii?Q?iDCid0SPAtLSdDo9s6ZvNZW+XnsfU2Ejrb0LoLT81UxrOy9mNubMGtTuIxAW?=
X-MS-Exchange-AntiSpam-MessageData-1: XjBz7IjcKf0RqTugmb5lwW46XlTj7gmPOio=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff6952-074b-49ea-b162-08dedcba0c1b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:55.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rhDs0c7BR1feVuh900j0ehIWKLAXEyMLH7aGJb7eHjvlgQBqG9fv7ZsKcvXiZsAkTiq1G36tY6QeEc2e+3EcM3VbQP76hSk+Xcmx0zgZgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

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

