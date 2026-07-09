Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C972C237E
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604710; cv=fail; b=iDMv5+gerCvY2SB+1GuaDCQi8DOR8e/yk0rgbHLLWWxyXFy426bahJ/oRS1jwnm18Lu5EemC5dJmE69cdRktXdlLjh4Fif5ShRUJQTdQ/MONedIid5ZaCrgLO1Npah/4FCwsxHNvk1lrfwM976eG3NGdfsSZOYDVfnvAvkLWJFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604710; c=relaxed/simple;
	bh=3Tucc2Yx7gCUmrJ5GD8y5PypZbKFMQ8mvtjCOBCMfhc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZIp4uEPL7CggJITt1pcadIxdA8yhBKje2ym/AnxhBuzbj2Bqn27uXNVGzpEqhPt/ye5vEPH8mK4fEjPC1A7/mn1XU4R8xeIah4qhdeE7qbDWwbnSffpu/MSiXM95eQmQPp5OGQiQ1FWWmqOxIBrZhDj0aO+kzESrqwjibkNlKv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AEYHZW2G; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AEYHZW2G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCKFUT5Oj4mepqjEg1GALB0VTDAB8SofP8Nl1MB4MIciIbKyllpkIvoozfhDzgL0j3DDTPF8ixQZCx5E5AJj6D53hx+kk2SgF8JG23w5LiDgOeKhps7fSyodb/xoMc5hqCB/d6FQ0WLhVw78bH4W33E89Lkpxgn8dc+6nLrqIiWaTDNKkE35odadu9bLgUckBLRcHD3XexcgR/y/00j30BlFuSWDLp9LL7zasRChC/hXOCb34VB5VIMxAG5RZLo+Wz5JRLd/AHLl3bRW+Y1GDRv6VbxnOd46Hzdmn8tt6ROi0pvzS38FhCcbSeHhnsGFS/2RIwKmn/hf/Cpj9DHA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R2Cr1F5ASz1sEvbiLwaZkZLLzq3yax69K0OpYOfXwY=;
 b=XOJwiyI70Rf1XxvcxjBWjbp/f068+RjhSAo9Md+eN3nSfiBDDblfBaEFIkwRHM5OCvyYlyYLOLjKCdosndTuFh5m1VTsEhzuad7kKsYMdvwLlhccuQ0HCkrFiHSekfl230suV3pOSUIEGR++gnN+1D37YZBcP3NfTKuCgrSwGL2nI+11dA82YgEvOSBpTKO/A014FlB+ZsPZmrrSmdu9q/+iqecVUc/hzg8xreQECE4Pnw+aoExwTjW4HpFtv/8I2nyOHiWk95eTgfatkgJeG8XWbd4NRfp9Y7yHY0mGe2AfymtP5GnTFeeZTh0GL4L0G96w3sUTcpzubeSgZlpG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R2Cr1F5ASz1sEvbiLwaZkZLLzq3yax69K0OpYOfXwY=;
 b=AEYHZW2GFhHXdofupWVW+kd5hmFedrULn6zanNiEZ0Z2cVzRzZaCu3eOfCWBjyugpX1i8rS1j+ZcTfTGpUIQ/xVNalkyinz6HraCATMW/6bKPsYOylq+IQbn8BJPp+5xJlvTD2oCkAV6oXH+imG73v/lJ+8LbYqL9lhF/vAq5H6dBHzAAt3w0xqPC5YrcQXf64OFdhaYZsWp76/fImZ3ZsOtMS/etjhb5mfOjmzhkOcAvAZpSqdjlpUo84zu6WA5k7u2ILZEvriBy87d/fwQaUz3zLo/Wv5179Td1B0TQ7ziaxmwXzN0jv2mdf9LASYa+Baq12tjFIIQKEUpC9nzuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB6825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:45:00 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:45:00 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v2] build: add initial RISC-V support
Date: Thu,  9 Jul 2026 15:44:51 +0200
Message-ID: <20260709134451.325524-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 84304cf5-310a-4ae7-56e2-08deddc04543
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|55112099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XzwY9Ksg+YyWl5SxT288YQRz5Ltlfjgao5xuoozGpGeaq/id2o6at6OYq6oaOf/pVAQ0bi624Y8lw6FDxz1wvjaJHPeJZ3s4D4pv1mi/ohsy1kY3dczWqaK1K6xoFoY5Le2vUefdAz3nepR0ZPZ2iccUbxkRv5B7QSISGMaS+02pBb/9I6gHPBG60aHOYLlrQ31l6usywNPfhwqUPmzA8ijRmeGsqoCuRwBDwMWTCxGjWoTsk9CCanUKQHTYff3v+V4WRlMqKXxydbc+GSTryzxNh4jqg8JQOAuwW5jjZqE9xybWPLDQ/nykAPmq9oSH0HFt7G5TJgYmaMIQ+o0bVaHc5zSGcyvSazJxVpvpEgFmEgv8M4jlPK2o1tlFHNsrhWH9gsvwRir22ShfsC8R3riZiHuVs62ju5UwN3WXeqSVwT71ib/HHKsxWOCX0RZTj9TJ2k6tQpwNwvJ4PerlBR2+Jc+GKGvc0urREJbDx1097BEH3+c0iV6CMVXqcMstpmJZjhnCm5DtmGeJ/raSsOnDqa6nx61ndSHzH/Iwav23w3vT9RXBkQiF27JiCGpta5uWQYoxWS+AOzmJxROcnehLBwlyM6gzFvZItSKVks3G5wcDC8mq1Q9dZjLm4ozi45z4/X7NV5YOFYZQRDi1vppykfKVcvAmgahC9mCZjuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(55112099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q7moxcmLHFvh1p20rHuVaKtPRDH4eAapqSm5HiM75G758ax667JVogm0FRMY?=
 =?us-ascii?Q?5e3zMjOBle7Gkog5SQq488MJ5D1JSOEMXkfcWJKI2Gji9u6GHmTs9W0qA3qq?=
 =?us-ascii?Q?172nQAJJYBsmijtZTwMRIcuP+uRXRm2WNzaWPjs+GjRPY3GuWzAmoPzPnfa6?=
 =?us-ascii?Q?Cl2XDRzEunF0S6bXxO5kkQSfBBc7dlEXTLXpvBHviKR5M+4gtoo0b/tc8gDD?=
 =?us-ascii?Q?GEinDj/Oo5fSZpyT8dBsIuBPIwzlACI0Ia6j4qBvlGm+Tsf2b2FtEEeWjata?=
 =?us-ascii?Q?RPggX+yc9vzvX4jRc0Fct4Ha0/yqT3FRJdnfL24p5Cb4cMifUkkwUWVQ6ff/?=
 =?us-ascii?Q?PqKFQCUTR3hh1bJYijoLT/N3NwLDzKh3Vvjj1QVS6KPQzz2xb9Bnr6c+6UU7?=
 =?us-ascii?Q?YesutKhM+GpGVm2GaSpRJOiNNJYLUh0eUapIwLlRbTYzdYEGLhgE+3kOPDrx?=
 =?us-ascii?Q?s0RkikT3f0N8CDu88tyGaAkNTR0lnamd1U11NsZuMECjQ9lf8oX0EowlvEUw?=
 =?us-ascii?Q?YRC1IUQKviBE5TVPQWhR4M0xmY9Tho6Ogn2HFQ9Jt6s6LLEjTWKA9acmK8hC?=
 =?us-ascii?Q?7TB+3FUJdXB7hvu0oSiicrWeT0CrwfAvsfLMhj8HSMVtLvglwmxZfGfB9CWH?=
 =?us-ascii?Q?gUbKEyqodIJNMgcRwSXXyp55Fvw2a0qwn7cNAtFU29VI8PKYK/G2gT1OrkK8?=
 =?us-ascii?Q?fPCT0ifRDdw07txO2NjbFMlmTlo2jOSIpDZkw3xtqF5qDasmi339TLkof+Wr?=
 =?us-ascii?Q?0iX1VfxsP14Ort1Kp0cZOiGx85di85n2dunfDY8DEDnOjX0Z+tI+AkE/jb0i?=
 =?us-ascii?Q?E2fr72np/xH+x5/tYogd0Se3i5VOYNBH3e343hpoTPvtOktakYgO48+LzGuk?=
 =?us-ascii?Q?W+gbUpPiu+MJSUfLOuqhvJlMRekZjJR64e2QN0c6aFPqw7HK2f4FfgoZdSfq?=
 =?us-ascii?Q?Q743MrwaVKfcddUIZCbZ7yzwoSSuMgfE6B7QnvpZWfUIh/NpYnJXmWZGA/5R?=
 =?us-ascii?Q?SuPSF0R5CBlxIzbucxtrLy2ANiH/8b+/iWSwPThkVYOEu5HUl1nywSg+DfCH?=
 =?us-ascii?Q?5I9zaI2NYPJKS3+VN2xdOfAn3TeEhBn94B4ysfi4d5LRBVdLzSG5EcG8MoFw?=
 =?us-ascii?Q?Sf3PCPGhlHUIktyRkU8YwCDQAetY1huW4p3jPNQBkKaojOWgXDYs0DoQQrsu?=
 =?us-ascii?Q?/E2KHgaxQy3iopypX9s5A4hDObGnnTMkFpRGIypBHW9uHNfvGkPLECsiXTP/?=
 =?us-ascii?Q?oxHEnNaFoCaDLB0htvUE+fiNBdUkmSPvmOuGzu/Qokka+8CftUW30jM9eXa6?=
 =?us-ascii?Q?LPEidebWoK+M5GrhVfQfThhh/bnkR2ef3Rf3QvyqHPv5l5p7wAz6aDwOhcFt?=
 =?us-ascii?Q?AtYCWnWwgpmTEcO8G5GE4keLOCpzmDouHghSIKCQmI1f2SZWuPiLHpYCLvIr?=
 =?us-ascii?Q?K12o+XLehqX9nkvUUAw/cqSnoozoDfRIaCVYi7Zuxx53CV4A+4cz8j+BDeS2?=
 =?us-ascii?Q?jq5vYoMIsvwzpkmn2XZaR2+NaCnpotFDYMQTeFpbv6nelE+iJQnIRWbGYFN9?=
 =?us-ascii?Q?DawntXr7K4B2pgK1gUIlPl8IgC3bNHZY4iyidDkR3CF/FFa1Gz+3GBxlkELU?=
 =?us-ascii?Q?M/igqhIGWWThsBLT1BYeh6xawRG3FzNRSOPepqEibeWajZVzj2vD2DkCHF+s?=
 =?us-ascii?Q?45+ps7HNZT5HIdi7WZvmcM4mC9TUmZ03bNZILmyjJbllGOGEZeX20oXJ1kAC?=
 =?us-ascii?Q?sLxFjSx2GQETR8Os8jdRjf4hZn2wSXc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84304cf5-310a-4ae7-56e2-08deddc04543
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:44:59.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IapETj2mnwkXxemrR6W+UKoIz2kKuqDDtj0p+WuzpWI4aBBfzTuA72qcymyldRMP+3SWdnBl4rHfqw51cS1i63862mVJHut/gf+mKh4w+RI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6825

Provide the basic build infrastructure and VDSO definitions
required to build libevl on RISC-V.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
 meson.build                           |  4 ++++
 meson/riscv64-linux-gnu               | 17 +++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h
 create mode 100644 meson/riscv64-linux-gnu

diff --git a/lib/arch/riscv/include/asm/evl/vdso.h b/lib/arch/riscv/include/asm/evl/vdso.h
new file mode 100644
index 0000000..5e331fb
--- /dev/null
+++ b/lib/arch/riscv/include/asm/evl/vdso.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _LIB_EVL_RISCV_VDSO_H
+#define _LIB_EVL_RISCV_VDSO_H
+
+#define __EVL_VDSO_KVERSION "LINUX_4.15"
+
+#define __EVL_VDSO_GETTIME "__vdso_clock_gettime"
+
+#endif /* !_LIB_EVL_RISCV_VDSO_H */
diff --git a/meson.build b/meson.build
index 674c661..4acbc40 100644
--- a/meson.build
+++ b/meson.build
@@ -63,6 +63,10 @@ if libevl_arch == 'aarch64'
     libevl_arch = 'arm64'
 endif
 
+if libevl_arch == 'riscv64'
+    libevl_arch = 'riscv'
+endif
+
 post_install = find_program('post-install.sh',
     dirs : libevl_scripts,
     required : true
diff --git a/meson/riscv64-linux-gnu b/meson/riscv64-linux-gnu
new file mode 100644
index 0000000..b99fc0f
--- /dev/null
+++ b/meson/riscv64-linux-gnu
@@ -0,0 +1,17 @@
+[binaries]
+c = 'riscv64-linux-gnu-gcc'
+cpp = 'riscv64-linux-gnu-g++'
+ar = 'riscv64-linux-gnu-ar'
+strip = 'riscv64-linux-gnu-strip'
+pkgconfig = 'riscv64-linux-gnu-pkg-config'
+pcap-config = ''
+
+[host_machine]
+system = 'linux'
+cpu_family = 'riscv64'
+cpu = 'riscv64'
+endian = 'little'
+
+[properties]
+platform = 'generic_riscv64'
+needs_exe_wrapper = false
-- 
2.43.0

