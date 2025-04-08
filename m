Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD1268685
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115312; cv=fail; b=Rak5MmyG0GnRX/a6FiRY/f2fPPkaEbnDfEAQjYL9HE41MaMs3RouAausCOZQi1LeiSO62Y7+3ObB2xzMrVOnxs5oewiNkt8s/bt2xh/nJudMO0ZIvMnJ/BpehvKZK9dQ+nWDBCcVuLPCrrcWK/+h3fT8DFyhdBrT+CrmWnKqXBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115312; c=relaxed/simple;
	bh=Lrl0j4X8TeiNXRYD+jzP/uJISa3tyRj7Fk7f1q99unU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbYmlTjziWiI3mpbHDwxEZewzNDwlx5tmRdiruhX9RhZgGzaFVwey291hK5eSvP19z9kd4g5ukAEr1rWcMLw7JJ3VKgf+0Z/1H6GZDa6aw+xsm9O+KQ76skOjtFWTSA+BfdO0CgYtcoZukd97WuEF0uFihcyRh7e569Z3B0KYL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=w43dtsNl; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="w43dtsNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8cQvGMHNvxX8rmZ2WacIUERZFTtQo39LY3EIqeSgoEigaC7CDYSNKqmn3QereoCXFmmDL0EsOh8vXrpx7cCE6n21r6yfc/kvrckgIkOyS5Guv7zbHiJrpOQR08FACC/iMxtEj+5tcuQWpdOzYbyW2bUxTA3+1OXbbetsG2lAen+g23wJnQm4rgBVX6iJHaFGXgdTqIVgDWVy2Ge0rfTdlYjwpvd+b2oX3FswpOixZkU3i3cLgb8Fp9XcMvoL4fz1yB+iXdOMnfhzyqtjRfSUv96d32tc7aBX83rsm56LJYF9bY5fUmfG9/QVCltNqMeS+h7z5s4ef82DcPgTfuAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqRFBlJTcyy22CdAgUG1HR0U5K3Z7yAf4wPR7mSDRQ4=;
 b=O/hmV7JWJns7wK798locmEQQHae53Ag1iCJHidnfvDk85fvzBrks5zvHnB9khY3FvNveA+v2YAG1gjA5i1sOYKLaeMM7KuczrmXkdjONxITLG2iiYCNlWUhNekkx5now5D27VnR+rS3XrHejS+uSVfSq4Cdq1wGnqVnK7Rbc8iMGip+A2KVQ8BjDM/oZ2h2SHtxkZ8mcdVy1kK+pi5CGyaqXkzdwgHninMx9A72CeVCk1wr+FAYNjFH0JcQ9dNVE5VqnskxZ6RBwek2htT8yu22mgAxKO3XwPkxlt4kQTZzcU7fAHhgC091DnR/+Z15nM5tRT2Ns+JAHHe1/f4JZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqRFBlJTcyy22CdAgUG1HR0U5K3Z7yAf4wPR7mSDRQ4=;
 b=w43dtsNlEkQrBmPbCdgTtYRmDWt12voaliOIuixlOgFklGFonmuxAlbP7s0POD9RsvFBpea4iXD1FnFYA7cHcVizp3L/lsv+a0FuWDiiHdD4duQtUeOqYxrpYmEB2ZBUZnXezvS+54ydUsTnqqX2Kj5pHaW/pi5oNGP+EB0eAgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by AS8PR08MB6424.eurprd08.prod.outlook.com (2603:10a6:20b:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Tue, 8 Apr
 2025 12:28:25 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:28:25 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Lorenz Kofler <lorenz@sigma-star.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 2/6] cobalt/arm64: Add architecture specific signal code
Date: Tue,  8 Apr 2025 14:28:13 +0200
Message-ID: <20250408122817.626897-3-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
References: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|AS8PR08MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 716df4b6-176c-4214-7e50-08dd7698dbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/bXZBCkZDl4qwUpRVzpFw8A/UhgpEOAH/vKND2bZ5UAT92PJX8FnxC0Snsx?=
 =?us-ascii?Q?SEaZ7FGwC+i1tDVS1X3Dbhk+UrTiirvXXqoHyUOf9fXsHgZUKs2qXlVZKI7J?=
 =?us-ascii?Q?i2PExAAjChcwOf1ZiI660EfNE0dszZUZZJNooR9iJ5WUVwjq9HBKXhLctbro?=
 =?us-ascii?Q?+rZtyC95l8E32UqHsss13UNtaBuynlZ0khW86XOceRNWiic/8ewKSUw/8yTf?=
 =?us-ascii?Q?DsBz5VnY5FiTYixHppEvwpuG02Zx77Q4a9CEzxAlx2M2dJaJ3abFKK0fp9T2?=
 =?us-ascii?Q?ZkTtUm5j+TwEpwgbe0x4K3zb+i1uVg/n8vMb1C3Pt8trUSrcq9nPgZ9UyBPD?=
 =?us-ascii?Q?UDpIwkQ4Dz7jI/A6Etw1aIrFTyiZ+jZxjg4EZed6wf1+9+W3jfuq0jvnPmqJ?=
 =?us-ascii?Q?o+J3FbT1NUyU1A4hkVwW6NTfOeUcvg+bR4g+gKcSDm4FfqDJUoA81b3qUc4x?=
 =?us-ascii?Q?el+Vjn/mKovcJpQMeNB7b1tEtgxbXn4zDgtYG1XzE9IdYHCrQgw0pawV9LpO?=
 =?us-ascii?Q?Ik1lHckidKTbTA58fjvGTG7P2pcu3yVGsOENep66xgenK2P4+gFqIQFVRJ0Y?=
 =?us-ascii?Q?/udiF/RZMn0bXGCDwF2RcEP6H9F3iPnflMGk9nzVtZ27VLS0K3awYJ/OeApF?=
 =?us-ascii?Q?ydskHxede4LiF13ukXKM+iqriv9t/NNwgvgIQBLiOHs97culeiPb5bkpG1P1?=
 =?us-ascii?Q?lPmV9+s8IbLL5O5+m28bzJD8si+o7n88+6vK8CIOtt4j7rgwkMs7s2eWdKuB?=
 =?us-ascii?Q?jLcClLnydsE3tuG6ViAve38F2DFAGOAOByUMVtu6MHfYGHW4+B2dWxb8NFw3?=
 =?us-ascii?Q?tn1R2N42taJ42yYlR2UENFeMqd2fJWJO1IYzNYpBBTQG/gbxWDLX6/Rw7sKQ?=
 =?us-ascii?Q?bjoq5pTTjN2L2ZPch1OHQZnBJx29pFlwV0+jRPUD4VYkTjlJbxuqploDmxGI?=
 =?us-ascii?Q?Ll4uBV0i23zvCxgA2Ti4PLNG4y4d07aMAqOFvn2oMausjLk65frYrI3b2tn2?=
 =?us-ascii?Q?xPB05oMsoO6aawszZRrbL4Kn9e8GPd+xrqlKFgfct7FwvZCg3Mxlgc+s1GJf?=
 =?us-ascii?Q?LKN3o0juU24Q8aubrofLtgTV7AjHfpyHPjOuDpbd4PJE6Qz9E45zgRyrb0o5?=
 =?us-ascii?Q?gBdL1D3PSwHciy25jiUNh7Hq6SXMHN3ZyZCR+aOnKd8nDuRu4WKxqOcuSqpE?=
 =?us-ascii?Q?RpuTZsYNErkNYW2GVkSKii5p6QfaD5MW4LIqfKuJgnpOSlhbx+0/5pCr7qYM?=
 =?us-ascii?Q?ond9RGYpSNtXG6Qfghpqepk1D76aPc+0d35PS+SUWBL+sf2Z6kgxgVaUwfgn?=
 =?us-ascii?Q?8x04Ts42LVXEPDd7gkwP9iWv/vsrU60iDSTvHyj+BCZBHAHxJNG9VtTSECs4?=
 =?us-ascii?Q?KgK/deP/9dXaKtYWjLvdIqglM9lW8szhr8JUqRTaL32nkUaTiau3kazEUmNr?=
 =?us-ascii?Q?fdldLiY9odsPuKYcseC4gENmE1ZGVhyy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/qKV/p+4RdwqUx2IQErKylDIytdTakFkNYiwa/BwTi83h6uYfsmAzc97faS?=
 =?us-ascii?Q?idgGsWL2sEen5EKNRC4ngDWe0Jj+ohl/i/Vditrv57+k6BFEWC2AuU1PlHNa?=
 =?us-ascii?Q?jA4AB1sRq49GWtc5ab/Ri9Cz/UWeKiCzKtmLHWf7kszUMj8iGaGITk8dDYUP?=
 =?us-ascii?Q?41UdDHbIvsmzl6nQwo7EimYjlHszL3RuSjDEQqN250nMZAVF8uJKKHZHYSuY?=
 =?us-ascii?Q?tXCr8Lhld9Rj1CQO+/EYNt7lIqMkXXZI775amPg03CoWF/hrlIWAYUW+FvmN?=
 =?us-ascii?Q?XrF2fJgD9HzsIhGLmPrlA4L3WxYd4BwMRmycEU/ARzQzjHssVGrVnQcLbbZZ?=
 =?us-ascii?Q?yGhIvrDBKEDOmKdyc9+ZIM/koiM/RaZRb/rC1K1RZ/9SB6x1Rpy3bRFmNWTe?=
 =?us-ascii?Q?TqiZJ3FySOQXKDSBcg7VnS9lZYtyIiiT/s8H8kPRmwXc75iID8BUJDQBOCyu?=
 =?us-ascii?Q?cuCVuY6UTExWD1WrWRlM4/x5UUdSe4ny6HRc9XO+MXpPPqtxXDg8LcvAiySx?=
 =?us-ascii?Q?NNm05AIVDtQhXEqKtDbVCz87ZKRZ/g3yxNeT4iJERqNSevJ0z6WR93GUUVVa?=
 =?us-ascii?Q?heRPjKUdtmIktoxANmo5KDOICAp55p9EESx5WRgJVUSOnp+9n3tHHS7MDAhA?=
 =?us-ascii?Q?lqndWSnRXfAy7izpBJ3DMqBjH9wt0xlufv7cieVFlbkchNJS9ykkHT554SoS?=
 =?us-ascii?Q?ksWj8FP5bqd+Xno7BeghPKrW5e1Xxps1DNDcqgl1KoFao6SK/pnSItX1l3yI?=
 =?us-ascii?Q?M2L5YRwlYSaSVvBSVHQcy5eeZCgg2YA0w2wzd2X6elSw89vyRQiojhAnnbzv?=
 =?us-ascii?Q?CeEozk++7w1L7WV3XQbwGH9J922Q/BghnliSzuzoPb/Eva86mvcBC+5LdPaM?=
 =?us-ascii?Q?hDJ8Dvehp1rEcegXwZu+WYSpTMsz+TGcV1CgYrYT23OEthbA2Tcj9/RoWR9C?=
 =?us-ascii?Q?A5WCCXgMipneW68+6+a0eDMDfjskwfy4CWEdQkhs7q17Cca57TELK4auC5UH?=
 =?us-ascii?Q?kzHObb/176OQE/VFBh+Pa8b390qgoIg+CpdmlStO4Wl5ExoCbzqoveUp72Ql?=
 =?us-ascii?Q?jwvzdHTxJkSzzFt3M3NjOyKNdqEI9HDYU6pfr0RSKfDSSHNtavpYWmUk0WtB?=
 =?us-ascii?Q?y3YliwUy25ttpZcAz/ac/kvU2cPZFSBGoa26v1jXsbu7Wzx61+MN3B3YOGnf?=
 =?us-ascii?Q?Fdhx17i3btk/N0eiP/LeOpMkd1daKqx7OchOEQl5OCPrr/enHdFy/rJZ1K6o?=
 =?us-ascii?Q?5QtDj5dg1sNWZBksCD0SsSkPDU1bp2jOlnmUY0F41mnjYeQlxpjPK2k/Y7q0?=
 =?us-ascii?Q?94WU2g39ZUgjf7yBH6bWpkW6E2GK3f7TuBRNNlztNvcfUvsKR5KgM9dcmg+H?=
 =?us-ascii?Q?oaFMxlPd7Qsr6n25hHz1tGqxVOSgp500hHvJwOh63Y+kp5o3hDapKOGLj84X?=
 =?us-ascii?Q?0OTb6fSzKxVdIvgHhS1jjs8WFeaVIYR/x2oR6Q79yNzynVB5YJmqp4OxEJDX?=
 =?us-ascii?Q?uqvWjDfgyJ5qaB2MQCjMYmTg6HfugOhwsU48XxOdRdO5UonUn4tdBJsCDziO?=
 =?us-ascii?Q?qO/N1LMXKEiyl0Kh6IxdJmGLSSLENfhsmaRATV2O8edrcq+vqegfaL+HcS+5?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 716df4b6-176c-4214-7e50-08dd7698dbdd
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:28:25.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXdbwpdFcTKC7z/LZd+zGA0EIA9JdVr4Og7tcAbPjTRfpHQId4KTy/hIWPFe3RFj+nRRtRd894f+fYT0LNcHyHhtBdDJAbXuJbmiCCbFhis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6424

From: Lorenz Kofler <lorenz@sigma-star.at>

Add code for the ARM64 side including ARM32 compat mode.

The only supported signal so far is SIGILL, it is built from
BTI and UNDI exceptions.

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Co-developed-by: Richard Weinberger <richard@sigma-star.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 kernel/cobalt/arch/arm64/Makefile             |  2 +-
 kernel/cobalt/arch/arm64/signal.c             | 28 +++++++++++++++++++
 .../arch/arm/include/asm/xenomai/syscall.h    |  9 ++++++
 .../arch/arm64/include/asm/xenomai/syscall.h  |  9 ++++++
 4 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 kernel/cobalt/arch/arm64/signal.c

diff --git a/kernel/cobalt/arch/arm64/Makefile b/kernel/cobalt/arch/arm64/Makefile
index 6c872fdb2..125b4cc56 100644
--- a/kernel/cobalt/arch/arm64/Makefile
+++ b/kernel/cobalt/arch/arm64/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_XENOMAI) += xenomai.o
 
-xenomai-y := machine.o
+xenomai-y := machine.o signal.o
 
 ccflags-y := -I$(srctree)/arch/arm64/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/arm64/signal.c b/kernel/cobalt/arch/arm64/signal.c
new file mode 100644
index 000000000..2e586aaa6
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/signal.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <cobalt/kernel/thread.h>
+
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   int *sig, struct kernel_siginfo *info)
+{
+	switch (vector) {
+	case ARM64_TRAP_UNDI:
+	case ARM64_TRAP_BTI:
+		*sig = SIGILL;
+		info->si_errno = 0;
+		info->si_code = ILL_ILLOPC;
+		info->si_addr = (void __user *)xnarch_fault_pc(regs);
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	info->si_signo = *sig;
+
+	return 0;
+}
+
+bool xnarch_is_supported_signal(int sig)
+{
+       return sig == SIGILL;
+}
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 105bf9faf..da1cf4a21 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -24,6 +24,7 @@
 #include <xeno_config.h>
 #include <errno.h>
 #include <cobalt/uapi/syscall.h>
+#include <boilerplate/compiler.h>
 
 #ifndef __ARM_EABI__
 #error "ARM OABI support has been removed with Xenomai 3.3.x"
@@ -119,4 +120,12 @@
 #define XENOMAI_SYSBIND(breq)			\
 	XENOMAI_DO_SYSCALL(1,sc_cobalt_bind,breq)
 
+#define XENOMAI_BUILD_SIGRETURN()					\
+	__asm__ (							\
+		".text\n\t"						\
+		"__cobalt_sigreturn:\n\t"				\
+		"mov %r7,$" __stringify(sc_cobalt_sigreturn) "\n\t"	\
+		"orr %r7,%r7,$" __stringify(__COBALT_SYSCALL_BIT) "\n\t"\
+		"swi 0\n\t");
+
 #endif /* !_LIB_COBALT_ARM_SYSCALL_H */
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index d89697712..bbfb9c172 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -22,6 +22,7 @@
 #include <xeno_config.h>
 #include <errno.h>
 #include <cobalt/uapi/syscall.h>
+#include <boilerplate/compiler.h>
 
 #define __xn_syscall_args0
 #define __xn_syscall_args1 , unsigned long __a1
@@ -101,4 +102,12 @@ DEFINE_XENOMAI_SYSCALL(5)
 	__xenomai_do_syscall1(sc_cobalt_bind,			\
 			      (unsigned long)__breq)
 
+#define XENOMAI_BUILD_SIGRETURN()					\
+	__asm__ (							\
+		".text\n\t"						\
+		"__cobalt_sigreturn:\n\t"				\
+		"mov w8,#" __stringify(sc_cobalt_sigreturn) "\n\t"	\
+		"orr w8,w8,#" __stringify(__COBALT_SYSCALL_BIT) "\n\t"	\
+		"svc 0\n\t");
+
 #endif /* !_LIB_COBALT_ARM64_SYSCALL_H */
-- 
2.48.1

