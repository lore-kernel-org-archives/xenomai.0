Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D233D8
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014670; cv=fail; b=pYOMpznU9+0R2TXKQwhGGtE6bRmGWCFIW0x7V1YumG2khP/NWQBmO8rfthrLXdQpcKO/ZxWRDwmfCeCqc7gVsA0VD63toeVxvQTndy/SpSDN3ysXDLLzKzLsGU4DvcNOUaKnufRy40KfjVIJev2NMS6UNh9xU/PjXgfh/amNbKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014670; c=relaxed/simple;
	bh=fqvPPH3Hw7r9vDGwBifYElj/CmwBtkNSq4q8K+0tUdE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L0YK/rsObGUPxuunygIOoKPxCSJvWPfO9uJV8wbLe70+9HFc7TWQ3H/yrCle53f5n2d3FcNZ1KTdkWMzhZyrtHXw+kwLOwQj81Oh1j/6cn7KNUM6SMzyakabeAU42RwdZeBt7N/6v/DyG0ZSKX1D3JFL2ESCPaY6qhail8nAXNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sT7qnWn1; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sT7qnWn1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJeVKQ7QYixqOmXW4ox0aE+qsnt0ynhtMhqJ/2MVVzrePgGDmn3GZlRc4Qj+qkwRmZGA13r8rNYJMXXbAgf7j87jY+W24bge6okNH92csKbjKWpov71WA/UqTXoLcSHxH5e5LXU6pfPfBAWBncDTGOhjhfIfS4gQ60kY+isDG+/Mf+CG8MaQUpP1u5QvnSvmyv9KdJYw2PC/ybYizBYkyjMXwQw4VYHbBQnZrhBGwlA2T3eA3rMy5q1Ni7FLkiJMpc538LGyjwC8GkIk8woYEmJ5haJsi5IyiLO7wK7vlcUZK4JR8zkzNSHab0ganUrkj06ouPwHkb0rAhMSCMp+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxfM0cwz3t1cS9acWHhGUXzi2aOAMfajFEKVI+XGl5E=;
 b=md8TILPAaLgsGoYDbQBl/xveRB8E2zTuhsiccEGrac8wJOGyL36YTnrjofLk3iyyFMTmOvZcDdYSeUmjPFvAhabUpO/FFT8svLp8OteQ8ciS24SsqL8tqZ9IiSVNiqhSZlUTXkhMXZzLZISNICD5lUpsRClIWhHNHsGgNolo/zo8Ua0iu5OLIbVS5UpsvN1ufhmDuheB8hQXtpNoQte3rksbFy2yYadk0gDmqv98WCGRHYDkOO0lx5396E8lDjITj9mf5tMSuiodbc4ll3uKMCwEHYiTqOzDB8WVlvN9AqRviQEmO/wIC+8o4FuD0/6lsfuZWPXEiBkb8+4fBH7/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxfM0cwz3t1cS9acWHhGUXzi2aOAMfajFEKVI+XGl5E=;
 b=sT7qnWn1OGL5o8fjUt953FruCab0xrzMyFFvDpRe3s/InZOK4Npy87ZwszkG5e3vRFGMdM/ynzr9wwYF26ZZQu72N7Op2GM/5znw25CWnpsLJRYdyiuEa6cwJ1Z0Pr2WAJF1FH/5cs1xE7Oj8I9cBZ22fBK1I0sIZcisTIRWWcHTgsJvIkUroGvwB9q11i/ikuyBaxZmzq6JDjSMZz6EphwapxE7WvpVjGxzeOX1ddffTPhb9H0GPj1MjqEdyYxv3Ih7ssOhvkdGdpkLhBOGjMCmdVdEGpJXGh6iWPp7ftTqCJmELPT7YwJRfIcP35+MVCS8qWiaGp/02OUw4m1Ofw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV1PR10MB8705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 12:57:44 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 12:57:43 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl] build: add initial RISC-V support
Date: Thu,  9 Oct 2025 14:57:36 +0200
Message-ID: <20251009125736.3520623-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:59::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV1PR10MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9811d274-7594-4c57-94f1-08de07336fc6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FiLhuvVey8B4F7eGzcCb/NsRs+rwF+SJuWgDZxU0QEJxZQ//YP9H7Hdkw8oC?=
 =?us-ascii?Q?xJpI/sjFdVKwXuPWsa2efscHNc/DUNlNcxibrBoScbszfT67AUTWipxlx5F7?=
 =?us-ascii?Q?7tjqkBpV0AVFum6IfP1VMpAwqRCOV9kdrA5FDYiEVQyo9CHGvbc4y9ZsQyBD?=
 =?us-ascii?Q?XckAXQme88hzbK9e4JHY++mEF8PfyUYjd4QP9T9iMdgHDWbFWcibApSLtoZw?=
 =?us-ascii?Q?H19kBdUBK/z3nkotQDjWQSTdklcGc4m3YxTwrWNBNPuOZzYxSMlNxx8sPpCm?=
 =?us-ascii?Q?qjg6+DUoKJ/1zjBd3AGpSPGX4QpiCMbF3sQ6TzTrpH64C/Xn84yqZA/WzlqV?=
 =?us-ascii?Q?T3vjr5yGRmKAvhn4c7Bf/cFkYedMBK9K172Zq/sM/pbZ/pfaf8Pd8RDB3LJf?=
 =?us-ascii?Q?VquxVgNxhOdE0tV03nrx036SwIdXoCk/oNU7YF5wLI7IzFeqYRIebO/04MWS?=
 =?us-ascii?Q?EP4oL2bNCdfJBShIlfA+mS2Iku6GAHHy4irMoh2hnkZQwZ93Prm7hsaCcWSU?=
 =?us-ascii?Q?qSMWILsfxm5Yl9cTnN3s+fh6aO1BJl2gCg3NJTcRG4AzxHzYqDpUO0g1L0/z?=
 =?us-ascii?Q?1pT3HYCRLE/wO6QON5MEdABLg68JBq00q6LdmrH0+CL7+aFtkDqCvX/ph5QP?=
 =?us-ascii?Q?7lLo/WAiKORSUS+ycU2h1vIZvEqxamIZrupkNnrBMB4kX3qDUVA5JxvZwxWl?=
 =?us-ascii?Q?LJa2SRNeXsOwc+o4SeZlR3hWPiXqmAhRc6tQwK7ZYa17uvmBgn6emCwF7LDE?=
 =?us-ascii?Q?3fRxcAD1YAJJcabGSOHFFMSFqIhGJCK7XM1xfYEV9fCKjsYvRxwtD4wbZ4j7?=
 =?us-ascii?Q?c+2HD+i/1GKA4LF4IEisxi3n3n561m6PttvhhR4ECX/Q+yY8qxS17sX6hBrW?=
 =?us-ascii?Q?LZfmA2AsN7RF6res9VLj4N+B/eGzvRg03i2zBwC/iOTBLBlXJ09JA7SZ0weN?=
 =?us-ascii?Q?d/l7Oq3oT6m1DMo97b3ruI+FZ66pP/F4a8eXuMeuWQaJZgYZFsDrCWjpCt+R?=
 =?us-ascii?Q?5At431RJQ+653365phCTRUAuF2V0Rcm0ZjQPIGx3M/Cv4GrgrzowT8zXJgdT?=
 =?us-ascii?Q?mZQYWdA5Dbcy2YcYbGgLVgMTkRHlFHsOEcQnTYylJfyzc111hcLEibQicn6B?=
 =?us-ascii?Q?4LjaJWiCAUfMtFF9fFegea6Kx6jfArgrJ0bPkgjKH+FiO/kKhQZNGbt3x7lm?=
 =?us-ascii?Q?E7dYxxJJohRqKeb6aFfuaB0ENJXUyeEVu91FeQykUFvZb+sgfBTmnWwqK1fr?=
 =?us-ascii?Q?zzDYgYUWgx7t1wZ0NeATa+sT+Uje/33qaUCA1UK6mdKgCdL9N0cV54IZjZ3c?=
 =?us-ascii?Q?5Z7heGWRd0QuW+8NqdSD4TUNUZb+z6URqBiBlfpbPioyDxH4oO80mkSrWDIU?=
 =?us-ascii?Q?RvOqdO7pK0G1jMmWEwGWvMZtYzu3/q7r83HfSTjkBP8obgKMjGItG+ciIWZW?=
 =?us-ascii?Q?ybO7pIRfE6ETxzLHJAv6xU5ZPcOXrxOi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGU7s/Buxvp87RTZ2j9ON3/PVX8s2Nk5XxVi2Tl7EMXn2KczhtwPa9sbaGWJ?=
 =?us-ascii?Q?xg/rdoFS5PYFi0FlXQbkp4/WRqmEID13RQhdGPtn99EQ0y8cOuQyTYoaSjX0?=
 =?us-ascii?Q?mq83aggwbN48kgUYhbuDg4NbP1uNnOajl+1Zpjzq7y8+MrVKKZSfSJCMDIGA?=
 =?us-ascii?Q?gVUSK++5C2ky+wjtlhICWRiZ/UqZuSQ/wCYwari9mStgyHEPAdGztFeK75OW?=
 =?us-ascii?Q?ogC/LvVlOAnw2Q9VJ7M2XYG74z0l3x1z/OMU2FzUvLEu03mjiwPUGk9kevqk?=
 =?us-ascii?Q?WWyRA3sQnTdhJKfwXkcsq8SLusbjNHX7IwIUO2zZ+gVCQvR0h20vnK2ybLIV?=
 =?us-ascii?Q?2U8OWMPEuBfm8rZ8mL5mQBumTbLycAOoTnZAbt5wKyFvFe7EDjw3U1p9W5Tm?=
 =?us-ascii?Q?gjRWRRXbh74u7qVQvNVWH4p6x3LeTUchhqG4IZa0HsLLBOM1r93QC3R4NtDD?=
 =?us-ascii?Q?HycA3E931y0Ci3uG09062Oc2yokJkQbK0HZmJOeZP1EhM6CaT7C2U5GK98/2?=
 =?us-ascii?Q?vcN/FiqJ71hQ/RABs7T+/r1KvThT4gTpKdFOLjtiaDH81w93oMNLHFYYZonZ?=
 =?us-ascii?Q?Dn/e2MC/05tjCSNYCcF2rwAyd8Uq6oReTQKk15CEnoe+hBh9N6jfWDCwd5ju?=
 =?us-ascii?Q?7YQvDm8xXsC9lUUlx9BxQinxGSfQK3famQ6f2zC0voZvZfNclveOEpmVgQ6N?=
 =?us-ascii?Q?ZxDOkkZHqkujTUmLVGd+X/VQSyF0TG0Q99MjjWGflLZ20dKPdWbFj3C0GMS6?=
 =?us-ascii?Q?Jf9cyUFFUyBkBHDxq524zheJYSRnhaZfrVRbCv+V9QO+y8kJsKEMy3SkYh3R?=
 =?us-ascii?Q?hWuGvwSZKXkp+s4UCrKPaWXarcryO7Rwi1laauM4tKNH+re+CI0eNIsJ7jjv?=
 =?us-ascii?Q?I9nZp81T8M2ecimtUdKG1Jj9tHOcSnPtxKZt/RZGLIo2HfsLyzlinORoUqPG?=
 =?us-ascii?Q?E2rASjqwVC3r/imKpg2ULm2uYkZDkcmYtuzqrHqkceyttv1AhfYLJbZhjFh6?=
 =?us-ascii?Q?y8YKIbR30qpU4ienZn02T+Hws18K4E+BrCf2HDecyA+tqsdj6wEw9pCHbbQf?=
 =?us-ascii?Q?jv65jCnsd5DR+pdY4BPBtJGn5hgFVUdqSdr3Y7el7u58z4H34lo9LkniISpE?=
 =?us-ascii?Q?rapLbBYFJiOgTBKn7ZRucMjv5G1g5hroYdt2+VnG4EPDVKtd5/Sk5+ug3v5z?=
 =?us-ascii?Q?VGaOw2fC4TZcR20hQ1oPcEeU0JTwba0yM4E21LICtg6fYSIi9crYX55S1N02?=
 =?us-ascii?Q?R9Q9vYfve8GBey50cP5HwY1DrOcvd2Xb/Pm/ZgPVCFNT7bTxARHvCaA1MP3m?=
 =?us-ascii?Q?P6GZZ7o5p8EtOSyFwdZudEZEUV+NHgzzP00VPWMOG+NG3N6Ny7eg/Siw2Lfl?=
 =?us-ascii?Q?ZCunYJvS4+7O917wgo8hObJR3z0FaXVxr7rZy+Zl7sBdY8ify72pNbH3e5h+?=
 =?us-ascii?Q?7SqL8V0r2IQkSoMOOXq46d6VWqvLPHUMTwDiFIO30hGYU2DnLFCqIIAB1nHK?=
 =?us-ascii?Q?9J5ow6MSsc/BVVkQ+U11JRUEtKEeuILpvlSDTspE9CPa6+W1bBNsKYMJIDNP?=
 =?us-ascii?Q?uH210ocT0ASX6wVqOd6IO7Ktw8U4soPr0I/IHitK1sKKCQzKwX1R0zr8m6qk?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9811d274-7594-4c57-94f1-08de07336fc6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:57:43.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vY7q7mizCjQy7OPkV57bblJmA+4qXdHlmMwOmHtO7niNPsZq4rFV66p7gB1bNW3rPPx3N+tBZcbREBoiEHazAGFywUmmc0AW+ouyOzXY0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8705

From: shannmu <shanmu1901@gmail.com>

Provide the basic build infrastructure and VDSO definitions
required to build libevl on RISC-V.

Tested-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
 meson.build                           |  4 ++++
 meson/riscv64-linux-gnu               | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+)
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
index f241daf..038b2f0 100644
--- a/meson.build
+++ b/meson.build
@@ -57,6 +57,10 @@ if libevl_arch == 'aarch64'
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
index 0000000..6eb3b4e
--- /dev/null
+++ b/meson/riscv64-linux-gnu
@@ -0,0 +1,18 @@
+[binaries]
+c = 'riscv64-linux-gnu-gcc'
+cpp = 'riscv64-linux-gnu-g++'
+ar = 'riscv64-linux-gnu-ar'
+strip = 'riscv64-linux-gnu-strip'
+pkg-config = 'pkg-config'
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
+sys_root = '/usr/riscv64-linux-gnu'
+needs_exe_wrapper = false
-- 
2.43.0

