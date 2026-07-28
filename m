Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFEE423EB2
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237201; cv=fail; b=CNh+oeHsxNMoQruqitMryMwXE1bS/suR/Mul4dEzNkL4MkwL4UG38J7JJ2nPgQKvyZwymoM3A4hZSJtQxDj6ryhv9yHcH+IkOn32t+YNbjNWb/Uk57T624gC2po5ysTX+fgxFswjVb7BgzBTwYaGZZ0QZGaay5bvv8ZdTmZLxwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237201; c=relaxed/simple;
	bh=FqCWfunOi+LK4rKzNHMfmJXIjF/7cSacZxME04thjBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqkKCzcPnu1yA5FFvFecwsqAejbAy0sisAHozCUbxA3tRGhGCZsxoMzUb6SYBdbJP1HgqAoHBswhVc1jL1vR06G1TflCMtFsBHiYyXMvl0mYZ9hmMoKFwwVrp2Q0LKYgYrxFIJi/PIRDD0oQiPEA1R+/YajcGiOi0aU3zahqcuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lxbLiGuj; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lxbLiGuj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnDp7WkQWVV4h6zU/jaMuLdl8jxyih24+NvSV/INKzH83iUQ1g3BMfmmId+7XBWrPxCoA2qLhNcIELB1i3GLv3UwVAZjsHnZWIiiEtgWQAo7Pxr6WoAnKmza9mKW1rnhb9hU0ja4HXgZfpVl+5Iah+OnMyhbS3AnDUb0kJHZsd6OCu6Ae18R/MJFC5zaWgNDbIsWMfBUCzNk+wkF6b9mLFmPJ5FQgPIYDG/rANMNMRRcZ6fr/CdBdfL1I8Qe+EEbBL/8wqkdONW1JNQMsDJmEHnoWGNhqmSOV0WzG+b87BEIf/ns5LIQbhsNWs5rFLyUpfzoA/Maq+JKTBIbUU7Y9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQAwVQdkhFpiGbvf5nmoOyL5e/DC2vpLILuWcDnIK38=;
 b=PAvTZUyJ/1PIRecdqVwEOfEfYb/nATcTLmdeeMicdjbSfuAoARH5U9dotEe3HEJxyOWiFiPfJOhWt6onovWTzUJkd18pubh4qGquZ3F8BVZ6R9Vt5dORinLcjaieLOcQogq+8u8yOlHxdB0Q47+3enA8IfwI4lO9LVBh/OBTvt7sFaqEQUanBKIruxhQ9PYdhmElefTrFVc7sSBXGb8XoNIYUZb8AMEWwTOT23yFZD8o0vEfHGeUGRvpCANSIw7mBSY2qUCSEAbirfK7aFEYXBEWUHnM8NomM87IbnBdv6+zNVzD2zSrLTtgmI8+VeeRAXsRe6a7tmXwOwuuVdk1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQAwVQdkhFpiGbvf5nmoOyL5e/DC2vpLILuWcDnIK38=;
 b=lxbLiGujzbeDoSXh/Q0+nHyicM0Jn32IfE9nm0wvWMPO5CgMbizEobLCXcpAGVVGndo2lUgMJ9pK/fl/WwEJegy2zMox0ienoxmMq86WIMYJ1V+Zw8B4m0lJdw65XjzHStqZmna+0+oBLBTa9Mx0q5jSPmLcglUZ9OvgIB2Vkyxn3Dv0evtuyeasMKqDnB+CeHNpX2bCEHJoAFyFGMkDNqytvY7sHrQW9Wd2lKSPus5pI7Khin0nMvIHJK/hTY8kmcybwE/+1XySG87iedFPUSVRTHHHGm+bUf7MxB3nYvPDvJN4dR+GL14P/S5ZKAbmXD3SXKJ0/pg+sYE4DkK0yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:13:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:13:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v3 2/2] riscv: Add FPU register test support
Date: Tue, 28 Jul 2026 13:13:03 +0200
Message-ID: <20260728111305.2699306-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111305.2699306-1-tobias.schaffner@siemens.com>
References: <20260728111305.2699306-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a51b843-e40d-4162-aff8-08deec9936a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|3023799007|5023799004|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+hDg6c8Vvq2lm/X4zU2D5nYdUOEoTm0cKZQNKxtZXSfLmrwEwOhgGzjTf1SnCNKc5dLlEicHqueZxctEtLdi5BZfwnOMDGeMGNeNuk4c7AcPw5GH3vPd8xF0BKhZJ9Rr7u1FIQwIMhCZNmc9DyQ3ee9uWBQvhUq0ecXJi4ASJ3Qw6jaTPdxJScGXAQUBP8xc7rO3sct9HSnMzNwf2M+G3hcAzQ9IupJbXo+Xdnsch0BtKUPQOZDL/k8x2FQY13GhRVeyN46ZFozPgtEJbfQHLQNAn27ml6gLPoqtvoJOYp9sWMIFEy57QeC6nOawAvQTUvPknNXSXCFu1fOswDAHvPSm9CYcT71TRJlrQRJ39ybjuMnblgl4Iv5TsRbDvBfofobvuW/b0MWDNQV4VN0aHnkE0Ge++V8nyXTNb5QR4t4QgHnalGkcZe1iuVnKQZCI7+jd2qSSZA3/Gm1HWLFadNWQhe50+TiaA0hRafOZDJMrIhZVrFtRuBX+WjBwFa7NXdmUcPNT1EeNyMrMcHSLyzSwo2xzs2j9mzvcxrXhLJHZIre9Df9/QRDljh5BUojpe5LGqRZPo4F0H6KCfXcrizAW630mc57IXr/TF1eLdRmPd7cOum2hxjb4S0j26JdUz35Ism1RdZW3nZgebGaRbSj0yiaVQQ0LIqVrDTcQlrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(3023799007)(5023799004)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZyifAY329NHWEfRfL141vEnZMOqMF4E8zZ2zEuXcpf1NcV18nQE2vWvQ3jk?=
 =?us-ascii?Q?1QwP63QdP+RJ0R+VHz504gFrvL5O9DgUrt9oa5nPhaN24vjUzxdUUZt79N3q?=
 =?us-ascii?Q?rA55a8Kbr0zYLGMDEqqL9VeE4s4D5s/qEejcDZMtiyDm13SdhIvhiMz7T2I6?=
 =?us-ascii?Q?gSqDk2NEgBGKSaKQddfqc9VcPlMZSL0LgteAZbFrfdeBKVFXr5BKsVts6Fw6?=
 =?us-ascii?Q?imicKJf9AFFmenhz3jCsgIAB/i9PuYsE+zeCQeTdIW8oZkl4IBFGR/f+U3eK?=
 =?us-ascii?Q?0ARJ+V5mdRCmE85untsQE7Y5cFIwO731/f1NyzzE3a+NvcKav+H9BgSoxaAo?=
 =?us-ascii?Q?x/kwWMdAccdjqxqHYcKqlDfaA3uo0OWIPXvzrEeW8KaWQUE2llz0B+0L+7Y9?=
 =?us-ascii?Q?I2kZTcOHng7kb1DGgDToLkdCT8aRXAIm3DjYYwXb+iEpRZVYM9bayp1wr59L?=
 =?us-ascii?Q?yUFUWiGdYA/bojme02ziivMQv027fv1Pvl5JY2D/EijWQSOHSeYEJ6HO0/I/?=
 =?us-ascii?Q?9WFezULI+xzrdPYcvsNv4bTka6/SNSxv4V/uiIeb+7HGJ08YEV0Q4+8iDm3K?=
 =?us-ascii?Q?N/FjGZ+BpGV7FcbkXJiERpkFFxNO7GUt6NML/7ugVEkU2IX/5Or5yQOPvnuz?=
 =?us-ascii?Q?pJnzxyohg5qtD4L/UCD5UE2xaP5wblnewI+UVv/nKHmRQOM4e0q2NNElERLW?=
 =?us-ascii?Q?Bkdz/v7+UayytTpFAyaBcll8W2aH8XoKeFC/5gxY5NvJVRAZLLvjEAQIsube?=
 =?us-ascii?Q?6VNkfe6VyQE5aQeBAEJqRxzqmk33rg6TjdoqXC2BSwbF9Aty6qyF0fcpmbDq?=
 =?us-ascii?Q?qU9h6vO+B1M12u55AdEg2IY3LxUxElxgppt8pUitKzOjq1gAxmpbBc8GlS9I?=
 =?us-ascii?Q?fX6g7PfDj4AzvNCS6SdNook2wZGnXdoVrMWoRjSX59ZPpfBrvE0quZKTMiXR?=
 =?us-ascii?Q?ap1tRtPLpUpWVtJv7IL5bbZiHZfpNaD/+93nkcDLNFns3abQ/jj8Q2q2GJ4M?=
 =?us-ascii?Q?0EHkg99uhy/biMZ4rLYBNqNg1e5wvpb4l8wTJoJz2BkGmWr2emFLW9kvbLJU?=
 =?us-ascii?Q?+IVT/I2kiOJyWO002iUmewsj6wC5CjuYKQZRra+bbe0CR6Nu46gTiGM4Jknk?=
 =?us-ascii?Q?I9oHRg51Im5SSZ3oNSk4brv8f535l5KsEfitstN1jAe9cjQDAyafFpUdxxc+?=
 =?us-ascii?Q?nDfEOvLwTlvQEs6dPVu1IBysgVLdCCVPloVkFK9EifoSckVETXboOmjoUwxF?=
 =?us-ascii?Q?0g/eI7pA1KWNK0NTNjT1kXx2GgKBhZ2LH62eoDzCq4FvgdndyKhMLSTmY9ac?=
 =?us-ascii?Q?G0F8VBg+h50PagBD/XdXeNWDMhoTGgM2oaUEX4jxBlSw39DH2gB7jZPs/XG9?=
 =?us-ascii?Q?SDNOfNF20GJk4pA23aNtbLV+Gg7UgOT3STL7Ovl6/ri0U247NVpRgl2bB1pj?=
 =?us-ascii?Q?OMKJDSPt2EhZ3stqMNJblnkIdz2MPdW7Fxq7IA8W4GvQrdKNYY6LKWSY2HGC?=
 =?us-ascii?Q?Ja8lZ2RQxm8HeDoa8QNFcJB7aEDn+rl9+kn6+ib2l45EJ4XcCHxSQDAoYKd6?=
 =?us-ascii?Q?b3Svqh5kLDuYC16LYKAB59UHzKBDjUTWtZUndbTTidoKZ442DAyCQPuvZEHd?=
 =?us-ascii?Q?O8+o7oRXSllkl3Ct7FuQXpJsdkMPLlNUiT/r/qr4yIEvolrMx+BweqKkePVp?=
 =?us-ascii?Q?78zSDwK20BTK3hqU4/DGuzbkawSzInxJSJfEzE4DRigSW3hU0k3IgppdLN1V?=
 =?us-ascii?Q?HRMslr6VG/9T47DrPOjthShNaLHTzyM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a51b843-e40d-4162-aff8-08deec9936a9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:13:12.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0aGN3oDGKPMNO5AVRmh1xazQgQHQakizQu5go1jdpsUElKLxin/YoUan29YsxAi/wY029lMU1dU7H5O+6G2+17kAsTQy0sHQJRrZRHIuIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

Define evl_set_fpregs() and evl_check_fpregs(), allowing low-level
manipulation and validation of FPU register state.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/evl/fptest.h      |  13 ++-
 arch/riscv/include/uapi/asm/evl/fptest.h | 127 ++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/evl/fptest.h b/arch/riscv/include/asm/evl/fptest.h
index 76a8092af702..abbfe67055e5 100644
--- a/arch/riscv/include/asm/evl/fptest.h
+++ b/arch/riscv/include/asm/evl/fptest.h
@@ -3,19 +3,28 @@
 #define _EVL_RISCV_ASM_FPTEST_H
 
 #include <linux/cpufeature.h>
+#include <asm/fpu.h>
 #include <uapi/asm/evl/fptest.h>
 
 static inline bool evl_begin_fpu(void)
 {
-	return false;
+	kernel_fpu_begin();
+
+	return true;
 }
 
-static inline void evl_end_fpu(void) { }
+static inline void evl_end_fpu(void)
+{
+	kernel_fpu_end();
+}
 
 static inline u32 evl_detect_fpu(void)
 {
 	u32 features = 0;
 
+	if (has_fpu())
+		features = evl_riscv_fpsimd;
+
 	return features;
 }
 
diff --git a/arch/riscv/include/uapi/asm/evl/fptest.h b/arch/riscv/include/uapi/asm/evl/fptest.h
index 1b1f4f0ce373..1c9358005f0c 100644
--- a/arch/riscv/include/uapi/asm/evl/fptest.h
+++ b/arch/riscv/include/uapi/asm/evl/fptest.h
@@ -8,9 +8,130 @@
 
 #include <linux/types.h>
 
-#define evl_riscv_fp  0x1
+#define evl_riscv_fpsimd  0x1
+#define evl_riscv_sve	 0x2
 
-#define evl_set_fpregs(__features, __val)
-#define evl_check_fpregs(__features, __val, __bad) 0
+/*
+ * CAUTION: keep this code strictly inlined in macros: we don't want
+ * GCC to apply any callee-saved logic to fpsimd registers in
+ * evl_set_fpregs() before evl_check_fpregs() can verify their
+ * contents, but we still want GCC to know about the registers we have
+ * clobbered.
+ */
+
+#define evl_set_fpregs(__features, __val)				\
+	do {								\
+		unsigned int __i;					\
+		__u64 __e[32];						\
+									\
+		if (__features & evl_riscv_fpsimd) {			\
+			for (__i = 0; __i < 32; __i++)			\
+				__e[__i] = (__val);			\
+			__asm__ __volatile__(				\
+				".option push\n"			\
+				".option arch, +d\n"			\
+				"fld  f0, 0(%0)\n"			\
+				"fld  f1, 8(%0)\n"			\
+				"fld  f2, 16(%0)\n"			\
+				"fld  f3, 24(%0)\n"			\
+				"fld  f4, 32(%0)\n"			\
+				"fld  f5, 40(%0)\n"			\
+				"fld  f6, 48(%0)\n"			\
+				"fld  f7, 56(%0)\n"			\
+				"fld  f8, 64(%0)\n"			\
+				"fld  f9, 72(%0)\n"			\
+				"fld  f10, 80(%0)\n"			\
+				"fld  f11, 88(%0)\n"			\
+				"fld  f12, 96(%0)\n"			\
+				"fld  f13, 104(%0)\n"			\
+				"fld  f14, 112(%0)\n"			\
+				"fld  f15, 120(%0)\n"			\
+				"fld  f16, 128(%0)\n"			\
+				"fld  f17, 136(%0)\n"			\
+				"fld  f18, 144(%0)\n"			\
+				"fld  f19, 152(%0)\n"			\
+				"fld  f20, 160(%0)\n"			\
+				"fld  f21, 168(%0)\n"			\
+				"fld  f22, 176(%0)\n"			\
+				"fld  f23, 184(%0)\n"			\
+				"fld  f24, 192(%0)\n"			\
+				"fld  f25, 200(%0)\n"			\
+				"fld  f26, 208(%0)\n"			\
+				"fld  f27, 216(%0)\n"			\
+				"fld  f28, 224(%0)\n"			\
+				"fld  f29, 232(%0)\n"			\
+				"fld  f30, 240(%0)\n"			\
+				"fld  f31, 248(%0)\n"			\
+				: /* No outputs. */			\
+				: "r"(&__e[0])				\
+				: "f0", "f1", "f2", "f3", "f4", "f5",	\
+				  "f6", "f7", "f8", "f9", "f10", "f11",	\
+				  "f12", "f13", "f14", "f15", "f16",	\
+				  "f17", "f18", "f19", "f20", "f21",	\
+				  "f22", "f23", "f24", "f25", "f26",	\
+				  "f27", "f28", "f29", "f30", "f31",	\
+				  "memory");				\
+		}							\
+	} while (0)
+
+
+#define evl_check_fpregs(__features, __val, __bad)			\
+	({								\
+		unsigned int __result = (__val), __i;			\
+		__u64 __e[32];						\
+									\
+		if (__features & evl_riscv_fpsimd) {			\
+			for (__i = 0; __i < 32; __i++)			\
+				__e[__i] = __val;			\
+									\
+			__asm__ __volatile__(				\
+				".option push\n"			\
+				".option arch, +d\n"			\
+				"fsd f0, 0(%0)\n"			\
+				"fsd f1, 8(%0)\n"			\
+				"fsd f2, 16(%0)\n"			\
+				"fsd f3, 24(%0)\n"			\
+				"fsd f4, 32(%0)\n"			\
+				"fsd f5, 40(%0)\n"			\
+				"fsd f6, 48(%0)\n"			\
+				"fsd f7, 56(%0)\n"			\
+				"fsd f8, 64(%0)\n"			\
+				"fsd f9, 72(%0)\n"			\
+				"fsd f10, 80(%0)\n"			\
+				"fsd f11, 88(%0)\n"			\
+				"fsd f12, 96(%0)\n"			\
+				"fsd f13, 104(%0)\n"			\
+				"fsd f14, 112(%0)\n"			\
+				"fsd f15, 120(%0)\n"			\
+				"fsd f16, 128(%0)\n"			\
+				"fsd f17, 136(%0)\n"			\
+				"fsd f18, 144(%0)\n"			\
+				"fsd f19, 152(%0)\n"			\
+				"fsd f20, 160(%0)\n"			\
+				"fsd f21, 168(%0)\n"			\
+				"fsd f22, 176(%0)\n"			\
+				"fsd f23, 184(%0)\n"			\
+				"fsd f24, 192(%0)\n"			\
+				"fsd f25, 200(%0)\n"			\
+				"fsd f26, 208(%0)\n"			\
+				"fsd f27, 216(%0)\n"			\
+				"fsd f28, 224(%0)\n"			\
+				"fsd f29, 232(%0)\n"			\
+				"fsd f30, 240(%0)\n"			\
+				"fsd f31, 248(%0)\n"			\
+				: /* No outputs */			\
+				: "r"(&__e[0])				\
+				: "memory");				\
+									\
+			for (__i = 0; __i < 32; __i++) {		\
+				if (__e[__i] != __val) {		\
+					__result = __e[__i];		\
+					(__bad) = __i;			\
+					break;				\
+				}					\
+			}						\
+		}							\
+		__result;						\
+	})
 
 #endif /* !_EVL_RISCV_ASM_UAPI_FPTEST_H */
-- 
2.43.0

