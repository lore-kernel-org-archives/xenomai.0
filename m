Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68D3C6A57
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042923; cv=fail; b=U4zkGf2mn3rqK+M0AVaYJDJc5E0hvdErTzY/sotYLUw7tdBjL2BPmGNAjbOYfHXGaSzquXLmTX6JjM7UhwcsLcOYskx+bpZijAlpQClWLEi8PtyHIyCVDUyZ1FfuXKv/B0pB5EJzvamLzXeMiOTaRQRqMbU2YX3hjNSrNkm5cM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042923; c=relaxed/simple;
	bh=fKntdS83Hx1Gt5syZo2ljjKq1Boa/QmDD/YJuIf8JzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWpGCrmmFXem50ATtPKFvAfNGAzWd5mOyVioyM2ldUJVgLPV+TMg309KEP1GO+gamADW32kCxs8NbfRwkDMzWocyGT3O1Fy16Nn8xOsu0QKe6dJ98IigJ7/wCE67GBXs2Qe7sTsEhk8JdCY7Pv0rQEuIQMAUHJh6/afg2k+pqbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GN6I1ORW; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GN6I1ORW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyV2Hwmi0Bxq2rvdNq07ZFeUnqLdbQelG61Zkq+A2nXn3bzUzznrD4pVmV1Z+96dZ7ZeuPEn5TfYdvJ6jqwrw6t0Z6v7QDNGQQA2xRHXU+es8PSnuW5LgnM/0XzvXvdC3mt2JRRKNA3RB1+aS1xA2NWvBJ5Mitrfpe+Kru13iNOhkozTctJtLQY+o1t4LmDPefl/VnfF1YqOPzqgd0ApA/GBnYldlrC0dO0GEDgqxHo6BpuPAbeKJpJHl1eu2bbn6FVDpXkv7CeiKp+qh6lBPtcSbUZVFMALmfdOpwZWIBK79z5G3bJHC69WAt1Nj6DZxuoHrcHeVW6phgLOGwIqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYH9B+WZ8rPG4M7GH0EKLfJHDfu9BRb36nY2as7+17I=;
 b=IsfJ3uZc04zEK4n9qe1nyV9M+29bP0fjw4L2XzmoSs1mLTsz3KHptKGijcr8NJXA8h5a7iw5scKLy0oBgDt9NwLpWxTLuTrBPgp2XbT948b52hNxo0rwMfMtsohfcXpQXffTaOgLGm0g0sw/UvDaz1ZVtde+smsiHG/yMZ4lF+nnQvLiiqYHMzwWWVnbB38qYfWxakCXbKTQ8ECJhfedIaL9MAOTt4kWa6SMKA1sf6n0Pn8ULcUje5TO58XwZ+6gtMksapB3MVEGDCAPd+Ee4EVTiUZLHvnNoP+wcFBKoTCCgkRw3oLzIhLg6/p+9Ptb6V6YIII7vjdLFuNIPp9tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYH9B+WZ8rPG4M7GH0EKLfJHDfu9BRb36nY2as7+17I=;
 b=GN6I1ORWR/A1UnSkJzEMoI19ComNIpr4P5+nqlna+Wr9YGUt8S1OLyfyyydVhiu4Ap0BEwsVY9DdixsIjiwHpDV5U78bqU94TfC714n4GZ1Y8zy14Gbnb1FCJVU3qtWEYlGpEraUee/GjPIBcV2FFIadm+6trvDfAezGeb+MQD82AIvLpTE2ngVFYesJ3feMaOQEPJLinhaqDV6iQ+VcTJY1fZhRmMteciQCcJKiGmn0JaRRP5gUnU4i1usAHM7qqPnPWs1KgqPT3L0f0VCCu1yWqBPaFsY3Lp0Dn8eS/T8HDKAU2peuv66F2nmoy7vRbjPjmKXdZL9+ykbB8gxSDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 21:41:58 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:41:58 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v2 2/2] riscv: Add FPU register test support
Date: Fri, 20 Mar 2026 22:41:48 +0100
Message-ID: <20260320214149.2211433-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320214149.2211433-1-tobias.schaffner@siemens.com>
References: <20260320214149.2211433-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3157:EE_
X-MS-Office365-Filtering-Correlation-Id: 724bd6a7-e825-4c75-b71a-08de86c9835e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gO7dsSMj20KqUPNmaElEdWvDufHglRgVcXe1T4oPmzpUxAp90F5u54mPJtA6JIqX2NO65SXF8LjosK5nqyRL6KElKsQYnxlZngQ0s/aXiswj5FOBI/LJthjiKVxCJJP5wYI4JuU9VPmkB1Y8KYjsgygG7uQGY4sHUp3sUPxluGBE4kpoHrOwYqxLHzTHWy/8B8C+1P+MHt36/9Ir+gtZHmmLM4cir82slxS1l8Obl/nYfbP9FyCvX63lYZF+ubDfz9pTEhAghpTZTCuWf8fK3uEbEkdqGuaeonkpyFxP057SecFcXYJ9CcA0rYFs+v4j3ZR3FsJXPRLbJNiReOHbUIzaZfZWGM/3UFVMq+2obl5IeuxRE1aslI6w+SlvjYoyGy1HEyCB+fVCN5ylv/0dYoFNAapSkupwWgx8xOJoIML+LRL6mK3zMvlptbGJNU+582xqRxQCLj1bqAUifJqxqye5lFJ63iPYvQ1bwywbRyRzq+pircxTN/GfV4hClwenI8p3TbN8zQxqYz4U2PF6wofsBc6Fw7x4WkKIJNNdSo8x2vMqO7ItyyWsZyNOr/WwJ//0hqI/SLwEO2nmZi8Sf6yKbA8ZDwN2s7zuU383PDUkf0xG3Hn1h4hin+gfwSHh/BnlQB86fHnKjDk6KsMEKAj31Ue9LDOCpLGPgB42u6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16cvXJ3VqaLYSJVInZPL+fWNhkTseL5MHeGLxdAYY/jr3ckouE9iuAOhrVV8?=
 =?us-ascii?Q?BelsfQ9dBZzUpGxqtkhiNpSgSULckHGW28Ynp3fqSgMCcM/iE5hR3HvfHOo8?=
 =?us-ascii?Q?qWvZi2QMTY4Xc978UHXFTQJKO+zRiROCvlYoUBp+nGHwWhIBcC0rz8t7HBm7?=
 =?us-ascii?Q?ea+JJXpOf3g0+CkpV9GTSdEeJ37/X2aNune271oMeeldeVUyDIWFKdXEdrwX?=
 =?us-ascii?Q?jqsGLzozIigqIsX3xtamhtcjqKbSxD9Vq4HAOItNZLyZb0QAF1jjvyNTeqxf?=
 =?us-ascii?Q?WMZoUDfHYFoiljs+rnTNclw5y0Ey/lbqqhoHhO/vj5g7paVCNY16NFgXuzu0?=
 =?us-ascii?Q?m8DMkJ2H8b8rHlf9NGKA81rWL2HkIWx6BILp6E/qc601m19C0BBx/CXGeCZJ?=
 =?us-ascii?Q?40CyULtrsbvN/mRigJ8Afcr+kLf45ZcYnj94dLK9oDtCJAd6oBvpl/y36urV?=
 =?us-ascii?Q?eOwQlnm73jOtfW1KiwhFre7HIBYtG80DYXnjj74TPOYHY4XIt/areqoE3fVi?=
 =?us-ascii?Q?x9JVocX3uFTQWHL9JGUNVI1hWpL9Oo4eWVpSF4oTaqxELd7+vDPTWs/Q3vRp?=
 =?us-ascii?Q?xrlHv+l/0ypiA7tCxowngWEVx01avCa1COAui+tvwXtBcvq40aDcLoUiPxwa?=
 =?us-ascii?Q?V5elnxREGbdowGOsH1pjdf0bAWflrN3AGpXXbcNgg08CxW3SBF2WUZqftSdx?=
 =?us-ascii?Q?sO2yHcus65NoNt+HWxvUhF4qGT4/FLBJEstt74B7RFjm38TStE5iKRjukAzW?=
 =?us-ascii?Q?j8hPrEXKXU5D0sFhklVg0u7SsH7oqWO7qxCjOe0uQfzHk7cJXXXr0C57GgjR?=
 =?us-ascii?Q?eI+F8dlwucA28sXeRwhijBeaK/qTiIQLoa5/1ElKd6yQ/ZOlK/7x+Gmif2N3?=
 =?us-ascii?Q?8tnjnPQxzAMgIp0B896+42N3gySaWxBP76Lqo30alWY6XpqgElT7Q/b1om8f?=
 =?us-ascii?Q?0bz5+oJ+RpW+L9MIW9niV0wYB1SqxJhvSLwgaS9rmarxgEMvpiOPqGagkgup?=
 =?us-ascii?Q?3e75mSgOHXUx6alc/Is8EwxgyAk8V2Yns7Gy/JT5mYGNpHXjrPb2jFx3x+8h?=
 =?us-ascii?Q?eioI581Pn5csr6jnVWj46VtzlCqDemc7g2qfebjd/DQDKJrfC3tkZOixVBG8?=
 =?us-ascii?Q?W6ZUZ5lGSh/FN8+c7PoR9zb6PTnsJCrzKKrXtscoA8nAPfl5zEmx99TfKMrx?=
 =?us-ascii?Q?JGZOlN/Mc2fhh3WZLzg+xmcgKydapdMr0avMgN6Z6TMeFXoLligiGJCNkeLs?=
 =?us-ascii?Q?S/9jXA0Oik9naGzJWgaPFd29e9gJUXOnAkz/4QZtsVOjsrjXBnCHBpfReNxo?=
 =?us-ascii?Q?g3BQUrfwrqN1JFfjYx04f8zrmLMYMxAYJsOTdz4umeIgglDLV8XSiUokknV3?=
 =?us-ascii?Q?9b7Rnd3rWoRpFnEf5Z9HOGlmDF0Ept3pcx0Gpx3P3Ca9B6infD4fxyyvP8h3?=
 =?us-ascii?Q?wH/NKAZ3w1woCli7hMF6bElSgrwmAQ9kZo3PdplPUCzsfvm+QLuiphYLx43a?=
 =?us-ascii?Q?sikfX/GYp+2hF5a5muepPIG5skkRRIQ6FCTjB2FShrzhqOYXEdpyyj/BCXGV?=
 =?us-ascii?Q?+EFPyhG1o8mSTO8L8kUYVsRyuDHz5dk6ds6MVxa3FG39ydo0B60zhaHblVRl?=
 =?us-ascii?Q?/ejW1LS5U0emqnuVOeGxAR13C41o3qPE/ceQRxIXCjHiKUXpz9hAku3UxEyE?=
 =?us-ascii?Q?7LEJcpvPyHpeHbkoZrNG8nME9jeCt4twU38H6N38+mtc3G22/JwbQQHroURo?=
 =?us-ascii?Q?fr6UNC/upFvPgqs+Slb9AXV9Jkv90uM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724bd6a7-e825-4c75-b71a-08de86c9835e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:41:58.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBBXHMfXcE79urHm2E9a/QOklSGXIcgYn/Xnq6Q1d7m1J4pjgKtDPUF/syc0EFcpj/NQcUEzsrXdQJLwb7TVXo66SOMmjcppxyzPo5OLuuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3157

From: shannmu <shanmu1901@gmail.com>

Define evl_set_fpregs() and evl_check_fpregs(), allowing low-level
manipulation and validation of FPU register state.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/evl/fptest.h      |  13 ++-
 arch/riscv/include/uapi/asm/evl/fptest.h | 133 ++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/evl/fptest.h b/arch/riscv/include/asm/evl/fptest.h
index 987246edac69..d9a4ae9cbde8 100644
--- a/arch/riscv/include/asm/evl/fptest.h
+++ b/arch/riscv/include/asm/evl/fptest.h
@@ -3,20 +3,27 @@
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
 
-	/* TODO: Check if we have any FPU features. Not using any for now. */
+	if (has_fpu())
+		return features = evl_riscv_fpsimd;
 
 	return features;
 }
diff --git a/arch/riscv/include/uapi/asm/evl/fptest.h b/arch/riscv/include/uapi/asm/evl/fptest.h
index 9169fc5c1b50..7be41bc4e453 100644
--- a/arch/riscv/include/uapi/asm/evl/fptest.h
+++ b/arch/riscv/include/uapi/asm/evl/fptest.h
@@ -1,17 +1,138 @@
 /*
- * SPDX-License-Identifier: GPL-2.0
+ * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  *
- * Copyright (C) 2024 Tobias Schaffner <tobias.schaffner@siemens.com>.
+ * Derived from Xenomai Cobalt, https://xenomai.org/
+ * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
  */
 #ifndef _EVL_RISCV_ASM_UAPI_FPTEST_H
 #define _EVL_RISCV_ASM_UAPI_FPTEST_H
 
 #include <linux/types.h>
 
-#define evl_riscv_fp  0x1
+#define evl_riscv_fpsimd  0x1
+#define evl_riscv_sve	 0x2
 
-/* TODO: Implement fptest */
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
+				"fld  f0, 0(%0)  \n"			\
+				"fld  f1, 8(%0)  \n"			\
+				"fld  f2, 16(%0) \n"			\
+				"fld  f3, 24(%0) \n"			\
+				"fld  f4, 32(%0) \n"			\
+				"fld  f5, 40(%0) \n"			\
+				"fld  f6, 48(%0) \n"			\
+				"fld  f7, 56(%0) \n"			\
+				"fld  f8, 64(%0) \n"			\
+				"fld  f9, 72(%0) \n"			\
+				"fld  f10, 80(%0) \n"			\
+				"fld  f11, 88(%0) \n"			\
+				"fld  f12, 96(%0) \n"			\
+				"fld  f13, 104(%0) \n"			\
+				"fld  f14, 112(%0) \n"			\
+				"fld  f15, 120(%0) \n"			\
+				"fld  f16, 128(%0) \n"			\
+				"fld  f17, 136(%0) \n"			\
+				"fld  f18, 144(%0) \n"			\
+				"fld  f19, 152(%0) \n"			\
+				"fld  f20, 160(%0) \n"			\
+				"fld  f21, 168(%0) \n"			\
+				"fld  f22, 176(%0) \n"			\
+				"fld  f23, 184(%0) \n"			\
+				"fld  f24, 192(%0) \n"			\
+				"fld  f25, 200(%0) \n"			\
+				"fld  f26, 208(%0) \n"			\
+				"fld  f27, 216(%0) \n"			\
+				"fld  f28, 224(%0) \n"			\
+				"fld  f29, 232(%0) \n"			\
+				"fld  f30, 240(%0) \n"			\
+				"fld  f31, 248(%0) \n"			\
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
+				"fsd f0, 0(%0)   \n"			\
+				"fsd f1, 8(%0)   \n"			\
+				"fsd f2, 16(%0)  \n"			\
+				"fsd f3, 24(%0)  \n"			\
+				"fsd f4, 32(%0)  \n"			\
+				"fsd f5, 40(%0)  \n"			\
+				"fsd f6, 48(%0)  \n"			\
+				"fsd f7, 56(%0)  \n"			\
+				"fsd f8, 64(%0)  \n"			\
+				"fsd f9, 72(%0)  \n"			\
+				"fsd f10, 80(%0) \n"			\
+				"fsd f11, 88(%0) \n"			\
+				"fsd f12, 96(%0) \n"			\
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

