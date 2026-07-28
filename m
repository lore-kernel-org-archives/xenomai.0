Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB117414A2B
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237156; cv=fail; b=Ye7Vn3SO8hdrj1ruuiG9RPstXIkQjlBNyutp0524DQCjJR4odWe55YwQ1pq7PUI6EQ5ctl+a7N6elgrJ30W+tUu6OG9bo+Z1vGeCBi0aagRVtYC9h9pGix1YXGfsuV/TNieuxztxgEoaAf38ZREBVFb3KfwSczU26QO51x9o2Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237156; c=relaxed/simple;
	bh=2pOUy5R9ZDcB7ZW7rxbzi/13pqo+XELQNBRpWi8UitA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8VuKO8/OneSHzrhlw98YSJq/a4k2Kw/KVSnIVXbv+vQMc+cVH+EkgdFdzfNbvL/GnCD/52qXQJbdfGowNCFNfqZLsYVDegG6fyeM8Tex70UjXmrGP9T/5xkqfjaNVgW3BD6rHJSuJ6TfuIMMWSAkQUNjHjywnfwIjCgv3WtBfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kYFjwnVP; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kYFjwnVP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNRgwVNJRrM53rUulN9Pp7zaP0BqdsFBi6Bn/SJpng3Jjko7390vbje/l/Aeqk3jASMHld5JJpv3WIrJzpVdNmYF6OGjVrUbNf0mUVBngQzWe3Bn2E9+3chjhoIahabH9Ka7G6ETQpGhA7mggYuuW8p5RtHD8oQKZ2yutUvvkdy0kd8JVhTjbIBfSqJDbTYC7PmH+OByluHaAjjWpY2rwEXHv7+VTLxxzKiM40N9uRw5fvPauzVFpe+CthR3bacyMhjgCkgBmvrUYspDcBQqNVmTnxrIozkcD+YKX92hoN0GEvpQKddYKwhJ3ZUPMz267dL6oOptJpepTmrXNJAcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnS62UmUShYAbbKBxskURKV25pWFxj3i6k2T3eaawIs=;
 b=NjwGgtQOPEJCFFciPkuxP5YrN9vis+WXLRbFOiRRno+jdipOTOLoLv5a9cV3sEQIw6/1FD4Bfw9LuOsU84bqxnhJ70BWChIvOpyvBu1iQn3qv8xW2GxvQoOkAo07CqR3xRrG//NOhUJi6jEjOHInYlCxhzrES8GzIRKggOu036ySvcfV9Z9rrf3myQHjb3j0fM5SKcKZhoD1rY8FXfcqKL8sAJDmvtWjJD23Bn+f5uSQC1FFrii4I6KiqLqTmH+TuQdtHYeqwShOaXKFkmke1ahyg2yLMykxI3lNg+4a9fgu5UqsAw1Ts+5uoMrJffj/YZtNSVrWwZbb9LYnavzbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnS62UmUShYAbbKBxskURKV25pWFxj3i6k2T3eaawIs=;
 b=kYFjwnVPOERveiy+Kesoc/bXK3KM2XoFUr7zG/hA2B9orNY7hSHar5Kjpj4+bBAllKsXBF3DHSvPa7U3CCi4+O3y+q3T99J7jwcAn7TDiSyweZ7feILJqn1fyZeq19YWMyN0rN+rUHfGIfGRDPL8LeGIdf0x1SVpBz1wItLoUrkM0unPMG8g3RpVSnDvjjfGtRARvCIKDhRLOufe/RB+vl/Hw6bR66jJI6nMcTZHjqci8xM49Vf1DxeslOAiYfhTQezhl7LxYG+FFKN5+Y5YPIwEoaG/TmXOiAb5hDHWLgCxeZMblbklO+xl45zjyP3myt9C2JkoyRZq2hr9BfsNAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB8685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 11:12:29 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:29 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 01/11] riscv: introduce raw console device
Date: Tue, 28 Jul 2026 13:12:12 +0200
Message-ID: <20260728111222.2699158-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
References: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB8685:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a3bf57-3bc1-491a-ad7c-08deec991d1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mpg+kRLjgXx1r+A6UUEWXvvLCQlnXr7+8NaxAwq/zHztQx/ElhCb3gOGan0n3THSu4Z1Xob0UIlPVv+FWnc440LDf6INvV3NMu9+GcjzTxHMkBgDdCvYkk0/3suJ/uxan69j4psN5DW6KgTHDQFzgzvBSfQsOWCxXfIO3q5JA9cXdWkIxi5XBGuWN8zlUw1KJ72FqyY7pDY9kBjCp5CkdNmNkF8GeaY5Sbbm7g2mAj08m1/qTYkXUAt8xANk89QlXFo9K8B+CT5vl+m+70W/zrDNcdc7tYVdUcsfjNavLvwI46xgxJ+/YZeHZ5Ucel0mVORphBgl1IMLuEJI4FNxjj8F89pZ+rh1Ki4EthaME8Dyrwc1EezgWgSwUMUMdnbGt1cOi5LhLTRAHAVtI5gDnDQub7lYfUK5fkoayxDNFbWS4BZdUW2+vBH9n1udjpzyvKYMg+oO+6FD6aHlMFVSspWjNcURJAdvf1hDC2JAtxzFi+0Azylg4rf7eHSo9iwuS5+e0w5DfEH1MiIP5hMLZPi7JJNWjGgglOK8yenciPuQc8mEenUTbgWUtTuwP9zAG3TG7WOAsUcqounpUEn5roSvorvdAK64bne8xV3LwhET5NGnlAM2W25TmaMWSs3X/DqJD0URfX+a/nu/LI6RNtHwVmS/TfdeCea/pqNNOSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gAN+veG0VaknVtmfyGD2iQDWpxwphr3kt2rtJWbZ1ax99Zv7vYlbX1jsWutQ?=
 =?us-ascii?Q?aHwaVxfE8W1oaaxiJXc8dMkVfhDZPAIdiNjD6vYNj3Kv27vc+NeVLe+fx380?=
 =?us-ascii?Q?bJgfOt62C8f9fO6yPaV69uZEu0V0ZP8ru7Xdrcuxqk6QYe41POs7ZkNmKvPQ?=
 =?us-ascii?Q?AYQXFAoDdD5onnAos2KDbbR9rOP3nd5a/xAmQL98gPhvqKPYNIALOtdO0bWp?=
 =?us-ascii?Q?iUmK1ZMKkevYKDWDaihhVrnuOSHtuOKn8j/55IjLbWYY5Y1HdrCh9mP2iiFw?=
 =?us-ascii?Q?ZVZdBYq+qt/EEKkegMiWCPWKpOh/7HLg4k88lYAsc3hTC/j4BG+CCC/X9vWl?=
 =?us-ascii?Q?qDQwDlqvWT8FODgkgfwPQgqfyZ3mwHol+cj1iJJd8voBl8kghJ9zj2q66H0u?=
 =?us-ascii?Q?qSmA9XsovEDXKN/riN5kC7CZDH5LqvD1Zv2sTYM8yx4+fEMDvag/E4j1f8bk?=
 =?us-ascii?Q?rCZpa8Bhf5NqpEIhPD9chPYCvx7T1pwvVww0Uq/+19j9eAEany8w2qCDh0Wc?=
 =?us-ascii?Q?boJPrdS+FagSdT9i3/8Uq4h4XWTpJC/KWN27qdLRagDxgKU70d904AbSy6+l?=
 =?us-ascii?Q?+FEEN/rjVvQ9IuQufOWkHv5Xr0AX3yZ8pVGQrlDjmy+nlpJ6NKkDJUrW7U5G?=
 =?us-ascii?Q?Ld6vLlqkFlRoFIgdA/EW+0jNWQ78BXfvjHKp1P4fIMVh8HPcCNDxYWnnlHVt?=
 =?us-ascii?Q?5bRuMm8SqsXMt9L+2Oucjl9xTCtGZfy1NPqdJ4tLVg1F/BZqKivH3e3c5Y0X?=
 =?us-ascii?Q?pV8abrccT+aE4Mg1PyGjjgyUpsmg5uC+r/b6OJLgNNV+C6SEuqnvVT2C4Hdt?=
 =?us-ascii?Q?urolhsPmF/YxhyiFJkIWAIRIxwU4p6/4pehIulhrRJVYu9L4G/disBgUvsLy?=
 =?us-ascii?Q?0ukidYgT6gwryyLdMs6GqeT/WPzTgjuEfi0sh0w7AY/r59bU+dtJUqqcQ4Wh?=
 =?us-ascii?Q?1iSKtWj7Ox0NfzbocLRLEaBr6dFqee4+yZsc++LhxV/o1S94G5ePI3ZjnIlH?=
 =?us-ascii?Q?0xT016tRxyM9mRS5lMqBV4TSTTGZvXhdn39R44TIbm8kuwDYnRtyvvQaKNEk?=
 =?us-ascii?Q?2sB8YqswYZQPOAxewjuBRufd0krLV2Wn0qh7ueE3onzVHZXnUQuostCS196V?=
 =?us-ascii?Q?C7IVHY/CTw0Utw1LJap++jRiKEFUz3dGoDkJ0zkP8zd7RnnonUFzvFMnw+Xk?=
 =?us-ascii?Q?tiqorg9AbkuR5FAXkGkeJ7NXhr+zZ6cShnVB50Z75dSpcf58/gbIPn/C/hEK?=
 =?us-ascii?Q?ULegaV5pIAlKLKIKkosi9m5tPKiqAUWRNDvBVx2lINZ5QZXiURLtpJImESw6?=
 =?us-ascii?Q?EtKavfAFs0fnul6qzm8PxSUklXCAenl/juNbYQEaMyHeUg9upKVyjQelCfvT?=
 =?us-ascii?Q?LTGCpWQTbUz8tPxHgWpoYWtNqkHeAk/80iOKJ1b5cugdQoF1qudeFHAb+tqr?=
 =?us-ascii?Q?qV7Og1k9EN8yz1DKQXrakyatMcJH03r8sHDqMSNi5PRiwXx6WyXBAdSMzasI?=
 =?us-ascii?Q?uc+iJrh65aHCuuax33vTLrOc7IKZbXPN22/pj+2EfTYjWzHdPRgtnCuKgyqF?=
 =?us-ascii?Q?/WSANXbIfLTNdhzm8Z02ByNTsIp/7DIQ8qjqoSVx0ClzTPurAONV1Gdinhk/?=
 =?us-ascii?Q?UDJRRYeVfqUjuGzsVHhYDwLcJGUh4nuRu4YGUgHV2NEp4Lt6IIoPNbkXmD3f?=
 =?us-ascii?Q?c1E2+sofHGEwBFrB/Vf1ERnMVmeT6riaBWOL6/4JCTFVBKuzXlEkSY3VkHby?=
 =?us-ascii?Q?UhcKRNy+UGceo7u2+TM67QE+jvG80Uw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a3bf57-3bc1-491a-ad7c-08deec991d1e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:29.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnL8oe1aD2byNUL6F0etNMRL34fWi9teKVJDmFEp65BzLHibIuCFyMgSiRjH6AmFyXEk6PdFR/k8eBNypN0wr6AC29d9dJJFrs0ARE07Jyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8685

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

