Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDEE2ED870
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091108; cv=fail; b=bRKX3C+3ec4ntRQS3gVNcNJwnkyV6qa7J9IvafKj0ZiRPX1BNcXgItIJe8i/b9JWjvnJAjFDTpbq8K+t81IErFkaCqDZ6pIamLTpqg0DtGNFjh+zi8M3dwmJmvzsBMmbg0oPao6JSs8+DmtuM9Ig7prG3kbfgmCjtauN7ozYkxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091108; c=relaxed/simple;
	bh=WI/I2xqSeB9py1kFadvQbGzKedhOewEuwjYW1xW8OO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECTt7EYbvagTJFhO3X+U5PA6JFhEyzExIWTZhc37Vh5lHkvmFGdgZg+iRFCaJpsL6YCN7IjltaAskpr0cGN/b+M+APUveExOIK7szbpfNIwGebg6ly7XbUlYOFQwy+kvVV2IpPAOmOMzvlVxspxw+T6of7pKnFjtAu41p/6jgFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wiFcXt8B; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wiFcXt8B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLU/72YXe0GmUoLUxxtMdU8n7yU7QliHbZzQoPeluMFUabHzt43i559urYL8dUXp1kGLZT+QrLf9ILRkyBWsKBsVzIwsjIUm87NRbGjazr3I/88TBcxhEslW4Tv0gcRlu7FHjXxOvkEcaeJBWopVprTSXqwN31R2UyGAT396fbXfJjyXjZVUBE3L6/9KhSJodLqrsHIT1C+y7EH+q20kCzjY2nJ08/XJH3A4IlYRnGlcFcgFwtxwhfyvNsydPp7R7dXJwhCK3aIuNd5pXxx83JYysCmu0dqr7gEaJMpFLm5Xel0vBvMFne+AM5sCGh/dcKIJwxVFxg9drg4AnfWfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR1jzzWcA+8mx3eU64+D2uOp0FkufpJ139WIlyKGook=;
 b=N12eV6zlrHdCfG0cNbDfCHUbSBRl8XIUrN95z5xLleXaZ53smTkCprQ7ZYkcrJx1U2Y8TslmBEY1NhY6MwwRn07lrirRYARNlBMddAndNrh7sH2sSMih8xRv9gCFG6HaD1bsME4angY3rC3zIws1xMBd4gopSUgXt9FUxnsq39o0Bh9vpniZsKQMSwwrKGD5FoF4uuvm885VTdgEIkvhLmqMaCNiUVznfzvdcMiXUs/3bHwGGCyKlcm6M7NER53dUdmgrK4WjRCQBAHVncuczKPInJWa4NTq9Mc9YzcztCfnSqtrsZfw5GMhBE3ALJMZcURcZH2mAgH2SPYveX6CTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR1jzzWcA+8mx3eU64+D2uOp0FkufpJ139WIlyKGook=;
 b=wiFcXt8BJOli19d7nOUEgN/zEyRyVGdVbXhz+o4XoO4Qi/rmSvtCWnthXTs+t+YSLtWaG2i2I7U4iwNws08RPNqgKAamxX0DtgDXqs4OpjwC05zKPesfj7lIT09dJNM6XnvKxPeI+mvsjsT7+NiuKz/NpjP/Tf+Y5rZ9vXAApjFXdT+fsBJ/RMUPIAExBMVawhOKqPrwrtijAp38WJB5qVpxcPOIytXJc34yB7Hf9LuiHuZzdqeXQN7+QUbniUN7Iek0KjHl8gY4RqNW6ypJfYMx/PK6KCLEvJn0f7CyHPko7MeQ7CoYCGu5mGn3UHMgirS4dea6RkvcXHsaK5bRDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB5217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 10:11:40 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 10:11:40 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 2/2] riscv: Add FPU register test support
Date: Fri, 10 Oct 2025 12:10:50 +0200
Message-ID: <20251010101130.3758633-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdcc513-faa4-49ea-2c47-08de07e5679d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YifsIKL1y9tfuKTciEl5Owv9rowXp4P6PfN6CmOxwX9ECw8iqMrox4B1JlF?=
 =?us-ascii?Q?H/lj1r5SiY2NLg9fFr76U9I6gNdab0c8EwmPSDtPU9zvGpUMi6WOtTNMARA9?=
 =?us-ascii?Q?lU3xfl5rTRCdZvEg9D2VQ84ICj696St1G+pLrhl5Qo9dZwDVOTQVX4mP+e+m?=
 =?us-ascii?Q?bJxseSSySFGv0/OgaVQ7h80ST5vhsRq2qY3aQhoxXbw75CQ+tmvd1azhohyH?=
 =?us-ascii?Q?Z91Svvp4wtuwUx/Wkjtw0I4C6cZqEQjsFggNlqMub7CrcIS8T2yTBSRv1uhM?=
 =?us-ascii?Q?3IfvFmPU8lQkKvgAIgDoF4fBCPfO5y7CIOHl9/IBlbCLkeAOQmfkyDiSpJGD?=
 =?us-ascii?Q?wIGLeEMZ4bjH5oGKaTOTOdhENPeN7vrs2yIfk7DpgjxBxJv4T54E53swX/mX?=
 =?us-ascii?Q?8mUgy/TKkPUMQS0AF3P+B05X8Ud6d5AdqUI+Z58bhfXhlpngeYUEsisj41HI?=
 =?us-ascii?Q?uNbICyfMgpJU7BhFgkvFyLvBIPIR/TSSGLKK8vIyclQVHdAlaxwSAUZmNWoi?=
 =?us-ascii?Q?NfgVTaupensg896VZQI4hKdMT3ceAp6p4EH9P857R+53DeD8mi9U8oDljNqK?=
 =?us-ascii?Q?S/A/oIvHXgRvFiFH8onwnwxqcZUfHairyu/Xb/zJg4wKTgmr+WtVFiDfH9aN?=
 =?us-ascii?Q?vGAr5sk70h6iNAigGIzQ0jt558njBwDmQRVjCCl97aHNCtpCuW+BH715koTs?=
 =?us-ascii?Q?0DNKmj0LuD6RatHeS+olGZ7BCH4Gj/Zomfd7Ha+mUBsnthg/Pu6cxT7ojxcI?=
 =?us-ascii?Q?QL6vPN04rCoH7G6XM6sJ+PFdlXNcyFudy2roNJAYxy9fFOr1aJev956v2ReW?=
 =?us-ascii?Q?BVNE8lWZx2u1NJ0Onj8xhlckB6RnU780BczN37B4k7nmJNTfAUnLoB1njHoi?=
 =?us-ascii?Q?7S/ZKseYT8jzmLW2dvdwhlEfstIBiTHASUY9jNF41DZ1h+LEF2snZuvJuS7/?=
 =?us-ascii?Q?63EBprMp5xul0e1XbvRbA3G0tVIkhcsedzNQkT5ce5n0GwuTg+7x0btzmbi9?=
 =?us-ascii?Q?ml5j+mbt4DjNytJN/C+3yPWh/1LZfQr/CCnSNa4GNtem7KquE32gUXQRNSAa?=
 =?us-ascii?Q?GTwWvT+zZ9cVwhfp51M20JJy7dGH8wdgsRpK+OpG1StnFM2BTVjmtqKrB3or?=
 =?us-ascii?Q?JWh6xfvnAS+3ERvAt2FUwjGguYpzcENkn+Iyli6W/TqDXvaM+lw0njT2DGog?=
 =?us-ascii?Q?c2B3NYFVmGTPU46UAD1GI4W0JzFePNuDdzQnKIYlUYfOproGOG34K82svvsD?=
 =?us-ascii?Q?h/jAjFiqXl4KgAniLztTcXN+sG777+/4ZP6DJqM7iFqv7mlYW7rnod2ECQqC?=
 =?us-ascii?Q?h1PVYB/PE7LFZ2ZaKT+nTQ28ladEa43ozkOnUKduQG3+JUeHp76pUPIXFaQB?=
 =?us-ascii?Q?6S1fhf8jrC3YXJpqxK+5fV1rCkKynYxmpzd3e330II7nFlwvKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxDfV4OuBSwySZegPPbymmWSe2wpGR4SMbSeXDEsdqdidCoin3pkc12o0Jh+?=
 =?us-ascii?Q?B7Waezk7dDk9cXD7LWLjaiKLnngX7tLeQBTd7/Drrs3zH0k0WQgPURAsfrcL?=
 =?us-ascii?Q?WCQuK6i8vCsfu15RO70LCIjJ6j1hIjrKT7c03vfSTXs7fyMXva9zEpQva6sV?=
 =?us-ascii?Q?/FPDCDjdzTnfFgebUmg6AUAHlHoxp6WKkBIR7GtGgwG0LiqV3R9brMzf9SVn?=
 =?us-ascii?Q?aQhFGBtSxXN8+yUGgjVaUOFW0B9xfMXIGHMezaQUMUDBqg6NqBqoiIa1PcM1?=
 =?us-ascii?Q?NNih8SUMs0doOohHNejRwAm5J0glKwBG3v3F80NPFQTg26ic2IsAtXj6FMPB?=
 =?us-ascii?Q?cNgriP2n6ZvTvWaULBg6YI9HIRvAgPY2jMbLU4ZBZFUnoiiWss3JnBCilpeh?=
 =?us-ascii?Q?sIszLsyxVyxNaa0OfBPpRNZ0tnfb88gq6kMpO3UWpa9kmj3xlb1J1a/I27md?=
 =?us-ascii?Q?Kv9UkLTBRDgaPVcAvV0TsIRqmcBXiVLqKrmtaGMP1DZEANvG23Fmes4WnDRw?=
 =?us-ascii?Q?yGQtrmooVUqjYTA3zQGguDRombRFl1Wn75UIuCG1y5+8l2FB6O1XS3eVQjky?=
 =?us-ascii?Q?TIyWWCKXUwsV0vJBjKY0ILtaunSJ2C00F+h8x5/fTCGCD0xtOMg6SxCLdiYH?=
 =?us-ascii?Q?uNxgCPwekyCWmEUESJU8XrGECCF/AmFZPrc3LHPPvQN+NkvLuuM8q+1gmrEx?=
 =?us-ascii?Q?EMybaUqPClXOZxdWo4ddXHilpJ5NQlxBiAj7968qaAbyPl4B0XjY7hxWbtuo?=
 =?us-ascii?Q?kpPpAOecWNanHUt/dZGdOj74ysyhT2omTUHCwKCJPZXiEYdLwRv6UoDhAC3u?=
 =?us-ascii?Q?BqjLexl4e/bgwmkX0UThk9Q2vXcb1wGZWSkavwfmkFYoMdpzfqth5U92KzlR?=
 =?us-ascii?Q?L5It+oTrUtyGzPXDG8hgSCgzn6ls/yEabjHkwMr/SxuoVZB8+OdZNsPHRz3W?=
 =?us-ascii?Q?BjFpr6ZOdFIDhpTYgE59VZwBxSOybYyWieV2hxYzresYZob+wF4/yA2uy7Zl?=
 =?us-ascii?Q?69kt+p+zyz84EtO0VgKDJWw4s5o2fmlza5BR3JVzHwfzGuEB9YpAhN9r+QUi?=
 =?us-ascii?Q?EB9p1T6URgagPZZamK29C7JP5MQE6CmdR/Swq78aOCg61N2AitLogJD/4zQN?=
 =?us-ascii?Q?vx9Lu7iNmWE7lZ8BqNT7cfhE0LZM5rrdOTU6r9TP6rxtZESeTIdY2GL6GzOv?=
 =?us-ascii?Q?t/JoI1U2r21x79zDRDrrPSgjTssyd1/zYsrbyV3sTPP0HeRqrT5dGQUuSYaT?=
 =?us-ascii?Q?Kp9AU/aMH7G/zwLPDrIgTkhAdIUlhcnIZ5YddxJ5Gywc3JSmfdEE9v5zC83I?=
 =?us-ascii?Q?bK/2iAZKYMmUb6XVVf6fTDh9DLwL5TDmdtth/Rd4oWzX3LiL3dG6LbgGATGS?=
 =?us-ascii?Q?ZKejCedKDtwW0qirZzhzB0ZL5VmPynfUS5na6G1aL91JbT1t9IqwYpmRo2fI?=
 =?us-ascii?Q?/GaERGlSSBw3e6son1WX3yhAhBUWfJF+mw/h6thQcEOoh3oh1/vVvNokK/n4?=
 =?us-ascii?Q?jvndFdq1hcLUUUcr1UnJcWGOo5+LrXMAo7ymK0I5FcNHuZdHFiikAAUsEHYh?=
 =?us-ascii?Q?P22qnhhEwY5T4Aj/iS7KVpVxaFaGhAS9s4r0xATpmeITW2APTTBPTt5Dac+A?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdcc513-faa4-49ea-2c47-08de07e5679d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 10:11:40.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUDgt/ZBoJ4WSphMEat0uL0udbAjaSiKq4GMFJbxUnSfr+o7HJ7jk+qPp3nNAjkiS2yNE++uJ9NMnuw5a0t1XvkT/HDS+Jf0lFjQVSoOgLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5217

From: shannmu <shanmu1901@gmail.com>

Define evl_set_fpregs() and evl_check_fpregs(), allowing low-level
manipulation and validation of FPU register state.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/evl/fptest.h      |  13 ++-
 arch/riscv/include/uapi/asm/evl/fptest.h | 133 ++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/evl/fptest.h b/arch/riscv/include/asm/evl/fptest.h
index 987246edac69..82394f733c4f 100644
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
+		return features |= evl_riscv_fpsimd;
 
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

