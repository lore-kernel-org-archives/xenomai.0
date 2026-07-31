Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC233AFB1B
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519786; cv=fail; b=gJT6tXu3NA4I5djzQfIWWhcKJqODq5STVnj4R3s8Yi1y2TmT/zHBXHt5t9gc5CnoEU+rHpn4RuEiwWQNvPZH18GQ0FwbmODt59WPOia0ooNNylK2SY6dgFb7DnOQp7uetNQYu/tQerU64Yc1UMcUDqNZHWOf8Ibhq01Yf/UdPRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519786; c=relaxed/simple;
	bh=5Qz6+qv0/lM1qHI2p9KKp3SR7zE5nP8Jx9c5fCjVLgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pn9UrLQB3QX5+tQ0QKtjPQAl2MeDEhTQJwVZDdoVhbBjjHfeRPubeKyTTbIppo1HSnyu9Xvj+ziKK+T8MnvOTI4cS35fvZrAv2QKFQp6mF+INI9KvIjVPScEeXxY2mm+B4wXTwp24e4GaKUWez3zxXfKLCTIbUd3pMctCYBAfo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=a4Q4o8lF; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="a4Q4o8lF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwyMmmYcOAI/2YO3dwYg+9Er5VJi1a5beOTWd0I7O+fOViI9qxmub5Y5RBnGsAzcMToBmcvnudAzfGhGOZr/vcGf63TmpdfMPNGNSJdmpfPcjiRTmQubz1jsIjlHym1XwLzf1fW9iIs9K6BNry2MhNpwnvcpEliQkz5rU0dIGNW6Vt4J1oj5bbo86HzKnk7XAg0MCPq47cO/1ZLMuaEkGBuZaGwvpAG3hRRS2CjJO4todcZGPNyz0/mKhZFGkCidMrFIEeotm5udZaoJyftosivGW/yMDE+54hKrK8ErO+5OhWDGiFNt8/e27ZEhY+RMLLRHbSbU2Z28bIE3PISVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eNCu4qoPrcMXYOh7HeG11miO/i8GpL6mXOCfc/Bn3A=;
 b=Pv1TEmyavlg95AAnVQdXFgPxS93CfYvFny90dD1N6i3EX/w/K6NKScCsfRhRrCVXNnZ7KdoYmw9iJCMhto6hdGZ2Igimn3tAohsTztQUxoyG9mH/Mz6GiPF3U+MC+6YVX912MWwH/7oRlAfz1sPpbrTURXY3zt+ZOkEdlXUCv60IQ8EWZOEzHTS40RLz+Qf2DtLgZlTptvJyycCVU+nAne5Xr7Iu/45jmQddZ8qYbmKPyAmBq0iJo6dMCUfs8a/2Ek6VhOH4aUYZ+TkzRPSA1d+Y8TevmSiQM/71adTvHwrpCjwWWYyFe52E1uhh9I1C6hFioGI6z45G4h9e5hgbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eNCu4qoPrcMXYOh7HeG11miO/i8GpL6mXOCfc/Bn3A=;
 b=a4Q4o8lFQOtia3S+e9UJBSacCD2pOJPidp5a8pjMHB+IXKKhwYhp9ZF9IC3d1xbvIL/mx5ihd3/4/r68Wxu/mojFSJ8T1hQ1LXaxPEup2epA93gn3nmeAfNjwOIORWCOCYcwz4FrLW6ovq2VCLQuJCaanpdKYcPeG3FRuPVKh7TrI76PDqA2b48cGbaGbvqmtlGZoRdeV1J0EaqUKCRGiuHz5K80bLsYo2aFj2ZWnZdD9bPNsu7WjpgolAZcM3Yb/1yYPZKMKOdq+3McJVXpeBelb5Y+B6Vv/XPPOEjqCqF8ggYQjxwVSXRVZG4QTRkjG3J2QLydRXFuGSk4l1eRdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB9059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 17:42:54 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 17:42:54 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v4 2/2] riscv: Add FPU register test support
Date: Fri, 31 Jul 2026 19:42:45 +0200
Message-ID: <20260731174246.3431398-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731174246.3431398-1-tobias.schaffner@siemens.com>
References: <20260731174246.3431398-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ce64b0-1309-40bd-b909-08deef2b26cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|23010399003|56012099006|18002099003|5023799004|11063799006|10067099003|3023799007|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pyLrb4eotPR1uuci0EO+4roCYNgFURw4OOgaDtkiUDIG9Eh5TZYKz0tZChcBJkGTHb5z//E9+peiLqDImSwIefCGjDjRjqdPwlb+a6xHRUY0DmK4FYmmzuy1LCbGuCcRnj0qAVCxksKCglHQpONhp1hxvarh/IpUrvdjpxA5tCI3b7yeI01w5VcyZSI78bp08z8xAHBDbhiMWYtGkV7tsguLnaJrQj3OTVdxrczSPDVnSQNdTI1QlkpEmJblEonDYHUwDZ5pzP0S2r09Z1GpfX48govAkxs4E1PV4usQA4coBaeowXj5mDzoZoJk6vvzx8AuixbyQKd3Sq34/Lv0CymeP/r4AA1ym2lSxfYvexUI5gzt0VcB4DlEC2ygGAEhW/cxxNjpQJWe9GlSpJcTvh8uOyF3Zu9JaAqJALi4oied/bhP4RUI46c+lJvAje+OX4aSba6uLwBF8yjjaJPSBVy6zuVL7HJmwoV8KImdtlaZ2goXGa4Wv/skc0SS3JIwJ/QtvRcmpguFUkh83yfZ/rDc0lSNQNLADKTc33/yTrL5lf0ZDtwDPy/4GFTlp2TmMwTF0XVM6cauHJySvzjQnyAP3StP7i7rDNuMOvgn2q3EMQkRZvZCzpqVPoLu7JuJTezp5jWoHf5u2j7SpGT9yLNiv8T4fy9DHeqNtyeOgVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(5023799004)(11063799006)(10067099003)(3023799007)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYD7JE8ekFPIPdkhGUQU5M/G4W3c0PSDA8ObxuBCOb0qzyGieLYLCMvlePci?=
 =?us-ascii?Q?xbZxJQq4w58UwwDpo4zeTHtKYqtm/PVz4oJJCYgsQ4G1jCfs5UrswZqC/v8C?=
 =?us-ascii?Q?Jf4YehYZVPgpueQx2sl/xeZ8zBf/DXZDg1ARPrwJzWn4ECq+RTbHmuJvtahl?=
 =?us-ascii?Q?PVg307mxblisMLtKQRzuCtG7GcpC5XqHs3Rk2neoLRWwUkwZHZgCDm0xm2iI?=
 =?us-ascii?Q?NC66zBtf00Hw2nqeXTqyZlCTrWfARTpr8+6TrJpS6aSTsdRekCyB1Qyko+vg?=
 =?us-ascii?Q?uJnPvzFOCiew6EIiCfEtnEYlNuTtU9lHarJRPehh+9ih/jk3iOBLax6pabJo?=
 =?us-ascii?Q?1kZo+ixNW5UHPGUy2YW8iSTe7QlKyMiAjz44MGmTTb/t7tV9e2qPs5Qk7fOL?=
 =?us-ascii?Q?Aw84UFNtFHwQvE/pP4pyvc3aTxcdT9IZckz8Zsus0hwA/Raf6WqgG6YwnQFI?=
 =?us-ascii?Q?qfI24QHb4aS+03Iv+z4+mzpleQ50gFuBE1lGx9I2Os2YZuXzqfRG27Iy4ZPc?=
 =?us-ascii?Q?1p33GJK06yD6+edUO7hlsWS1ZUDA73ayYiCAt9zIniZnuF/NqdCuBtZQyQex?=
 =?us-ascii?Q?QNXUNO8J59497JZhCP9HZkOYvgO7Fn5q8PhVgay9w/hfZKGSdVv1rAQ5uima?=
 =?us-ascii?Q?36WbqhbaQ4RnLR37YQUgMfqh81eSSXvBFqgaTnr0UN1wVbg19XuXm4fo/txp?=
 =?us-ascii?Q?Yzcyw5ywMTNhW9c91dDaWD9WZHOlLK8RPwnZ7nR1BsZEAcuyXFAYa9/JZtSG?=
 =?us-ascii?Q?EfuP4bxItsN8vuk3ImMQeVYU3J0eOTTiApu6OzcD3uU3+HikW7pWlhZJTMl9?=
 =?us-ascii?Q?7KHLEo5NfhcL9dLQQK9auCAcvOaP7rUB6dM9ehWlp9U2LsOSCa2MY5ga6eL0?=
 =?us-ascii?Q?SC+b94oQr8UpSwvwd06przh/sXCg1BWKGa2JvZsn2MTz35WBmcwgDc6u8aZN?=
 =?us-ascii?Q?BeyFJuqpp/IY2WOMUWojzKuyZh1ynybiE+fJi7p8g7ZshPUsmH3GamiZGRHD?=
 =?us-ascii?Q?vF8q3uIv5KNEpUn0v/eVeXYu7BTTgfPIkGCbnDxlRrDdWMZpXbEpwk/KQGZY?=
 =?us-ascii?Q?zmdVz3X4yEPZOIHzQ5X7KbD45qbrFeGOkBVJHRzN+8BYI2aKDCUEdQS2oLRt?=
 =?us-ascii?Q?w93hsS5CrAsVSJzDcJbrWBK0hmKN8hY5ssmntg39Lb04VLvsLHlMOrNLo/Tp?=
 =?us-ascii?Q?FbeUEMrksVFMKzq7VhzCstHCxPL2tm0KTunW1TdzCAAGxYa/9juB6gmqiUZT?=
 =?us-ascii?Q?WqavSzF9HVIKXBZaBAGSj8Q6KtbBPJZcgvRynq0ICed0xMmSEWCYEdKawuRr?=
 =?us-ascii?Q?ww6nsPpDwAFKT5uLQKGF0zEL3LNraQDDH2/AjmOofvLRpXzeg0Q4m5U4U+HA?=
 =?us-ascii?Q?Pn/Ak+NV3QDT3uceLdU4Jj7EGVht1RCzKHyXcAPVBPZQhLPyVAO9MwyUrK9p?=
 =?us-ascii?Q?Znxi2S/oECpo650h2hNCh7j6V7mNKmqFNpBO8wMbBfz+XCnXOh87Ii+ZqGZE?=
 =?us-ascii?Q?KBH86liMAOVRkijYhT/HsEenloZMPrSbu3z5QcDeIMRGrcc/+I76fsYT014+?=
 =?us-ascii?Q?9CY5gFKZ6RC/DXtm17wO6YF3QpfPQI7zTq31QOgBt5LhLPi9L3wrPNK/k+bB?=
 =?us-ascii?Q?Gi9XqQGk3R0swper65RNFkS4dsv2pS9+ud/VV84O2P74ADPMLHd0mROIqcyV?=
 =?us-ascii?Q?vgbNuGboLeWfA1iyJQz5cf0SQKJrz7Pc/ckG90hEKAZXBAa5JrSsQamhXAHG?=
 =?us-ascii?Q?FmeVEmTz2DskcG8mj4KPqRHjrVDuu8/onXI9fz1j/3Bl3auvsTy0x/jt5XZn?=
X-MS-Exchange-AntiSpam-MessageData-1: kaiudn9hUXFRPx/VZmzMt/WyGH6ktgLXNps=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ce64b0-1309-40bd-b909-08deef2b26cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 17:42:54.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRPG7ZubhOcas+3cMG1hG9LTXTxdvZU7agEH9/NYCSZwQ4FWxgztXMmub2YbnAbH2oODCqSKewbr8q7QP+n4EnOMUrYI6PnusWSNAEOeZ3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9059

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
index a404662b12be..dd20d20f817e 100644
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

