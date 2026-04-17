Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783733DEE1
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459456; cv=fail; b=sQ1JlYtg3r0n2Zo3jx7mPY/ul5gPCcuOgLyIXC6ReBYl1MIcJYvEVPXOMrbjlTf5ZPSVASjbk7v4ZRo+BJCSmgUuUuS+a0zbye3OKgDkEhUz7g8Eu/PaXQ/yYGPwr8HezNT8swUdt6MA6fIiPXU56YSppLxUUvW9o8C2xX5xSvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459456; c=relaxed/simple;
	bh=2lNsBKE9kwSESJpoM40CnH22zrYIMNxWczrYC9mvsEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzKMH89w+87Pw8MpxEwYWA/TpMxwiSwNe+BFkkHamNMsmGH2TWmaD5Fql5v510pSpu9BLsf5QdchgOF+wNAw5SYiMjUZ7/nUnYTMbfV5HY4UGeBztGDBvgO0gcg5jwHU0ach1o1BGB4WyImzHmTKvXn6FwvBu1m+tgEV2rJGzjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=e8wG9UyQ; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="e8wG9UyQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpgzaxJAeKKr9WoMLH7y5LJrm3a3vO2LlMgPSvemUVMpBDWwcjDGAYkbxRNlDspSzbc1c1/sfSOyp9G2sASCQIUoIREaHF3iIN+zg+pgEKN8UgetMfERpCnnQZybRQ1YGYzLTy3ub9PE25YRIK6G3AsokL66Kk2CWQ4LdZtyBA3ZgOKe7XRMGxjn1yttdvfMPNO9nKnJ6DDeDkw89QwTyKGEM4ivQHVHNINPjp1SCoka3EfSzzbA0jjJSG0Cx26L1sqTlaBfkZhxUb6R8H3UoJyKqWYBvCMPhl9IXOW3FW+6Zn0jH3/kRkP2R3APxx45hbFB1JKfw6P6mvBtD+TmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG5wc95muwcQbAFLPuyf0cmdlrWF0SMuWQ02sYxoc5s=;
 b=iH/gYkCMGn3yrlfSc/zph1BwVkN/E/mKvdTPCi3xfFDqCpljRt7YyGPI1s87xWT7XPrn1NBr3dbU1QVYlnPrR4FiudI78xwcdz+ooHLLTKMaJ7oPQzJHl1qQ7hBfu0AsxYqFFDphwxIeiE4rIOjl20kgwVba4vC3DYkXJA5RZf6znoL8bQNmm4zP8VZkOjvPwmMs4scPjmBR57/OcSZESY3hBBbAXgD7uG0D9m8u1ca2QWvF944CrQaH3sww6KUqKreN1TmQK049kLdHURiVxpK+vm+4oVgKzDjVrWaT326fLT185XooJEUuMIIJsCR7vSKWnc11Xq5HvzFG36He4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG5wc95muwcQbAFLPuyf0cmdlrWF0SMuWQ02sYxoc5s=;
 b=e8wG9UyQsQmfVYiDiat1lRez8/G1P35UKGYfA+yinaugtWBe/mzhiCT+7UBr5muDJp+fjR9Dc1/K/W9M7OqX0JakzTiPz4um0q7w2ljvd+Hl+Eb9nl5NQPMCs+OPWMl4y5GYZYoM6L+z02pDIZ25ltFn4I6TnXigGZnrE9SjMDKS+einnFRFjFgIfmqrHg9yVzby8mSHCQaGe4DDhiQ0bY8hoDMYgg1DXMSEB1bPryo5BrESj8xTt8YqNLRRYPjWQyAsn6e/GbCWGXO7sothXSWVgD/wOuEWIJrzoONxv/SAKnfRu67Sza0P033OwtZrgI70TFljeVAjlknB6cfTnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:57:25 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:57:25 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images 5/5] recipes-kernel: add debug additions to riscv64_defconfig
Date: Fri, 17 Apr 2026 22:57:05 +0200
Message-ID: <20260417205713.2290350-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbfce92-b345-4af2-f15d-08de9cc3edcd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Jt7zW4tRyrfDVgDbJzjg2EL5sszgItDDo7i0YJe12poQs+FPr75oNaEu3VS/tYbEdCuHhIG0BVIxF1wDbJbqRd8tuc5RVitw/DLaxfXPnWKa4L7F4E4vHfuWsz9YuYX0ERl6SlHF5My0nP2TWnSXJ8bMWj3208PK9kVoJVrr2G2sQjKBL+3N/OCVRqDPTCMJq/bdyuXMDK3DhwEcu6boSCBnDpmEpMXs7ojWdLvZjegFKJzvr5brqBaOS/c0LONH+UbgwT6JbWqmfDJmSrOqtR6oYYflPFM0j6TRdrXCO9BlEzUK/Ucpude3aNd7jareM8Wl5uxY0YiuoVcF8n39XssJaUjP0oB2URThB0zXs8NR5+rglw5QTCgKR4A7TI/J7ZrDNj1d1AnLiZd0JD3TNA8PQRDFrOxNxTzc2wGKFy/4lJoNrHNagrdqnO+UAR2uS1lXiynA47jO91APHPG/Lzd+01WF/LXB2s+GUz0F6BdUz4aFDpbuP0vidpxUl5g3sGAPpS14ZBQBLOoc8ulhO5RsIiw+ifV65qk2UNGxU1PywRf4lKgUQxof2Ha8De1WD2o1VuTaprajG/NzvzYUDNCLjZr/usshJ9VvNrF6AWCL87B9QurI9QxDJkKjUViGj9dPG2CZnU3cLPY69BhKZhPBCAjfRK/Mrkj8nrwNhzsGrm8vTqye0n7DglIzoi9YZjpmaGttNM/WzxSjqQ65Yn9RR4D6+OEIOQMOYimGqrk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YtKjjc55k/vmAu5QgTTP+az9NeZG/tLdNA/HdlGjo8u1Ho4D9klTP4bn0O25?=
 =?us-ascii?Q?7r5EBux/gI2rbzYWbRoVX9q1UL7dI2b1KZuP2scadi+EUcXJY4A5tsCs+9R7?=
 =?us-ascii?Q?6nNDNBtAcqWXnMuXowYxpZIug/bRbpUEu96LG5gFc4gAq/9ZTLRjMS+1sX7H?=
 =?us-ascii?Q?6H21wIVp6AYZzt8xxZrSy5rOf42KB0ywEwjmwWV9pgO+MNne3vZ6GEanZCTi?=
 =?us-ascii?Q?iI2uhZOWjoLAg8cArk00EOOqkE2ta1vYvLswnEPnXXJrtv4tOfTxd+fYlfSX?=
 =?us-ascii?Q?1RUKOZkUgWm45JbBGti/yKr7WSUL+oCUZgyxe+gaNCYbi7G2QJQt5GApTOhh?=
 =?us-ascii?Q?KV+YyM8E4VFeWlpyLfoQytB1da+CfNruHKEYojoNWnLRZDiwoDHEzyv/kcTY?=
 =?us-ascii?Q?BQzelvBRnPZMZ/t8gi72A3Nt9NH2db2HrhLmVUtl0V+4owqJ5gnQw8zJwhRp?=
 =?us-ascii?Q?VGPxFU7c5mL3ZCD3+jk/95eJ446JK2icVfFSewGGHCs0vX7K9ygy0DNqm7F2?=
 =?us-ascii?Q?lb6fgoh9hVuIbGROrc0c1jQcUqvJUlncrbNajPe1lA9HSiv5LLyIVqwq2QwD?=
 =?us-ascii?Q?EbNjPkqivgX+XELw68NSiUN6K13Idk3UecK8YRfz9/Xfa7D0SafYr4aluCXG?=
 =?us-ascii?Q?qjj5m7kqWg0qPjO7JC0T6jZ3re7QwOZmFsVfPAv9hmgAbnBW2rOfHistlbZy?=
 =?us-ascii?Q?iaqpDiXkiJd/T38NEoTRK3CHQFbTFSh1fF+sHfIf5BWmnQREP2xyZpuOXZZ0?=
 =?us-ascii?Q?mVkLs2wecC9yYbr/KMaNA+ZzkdWK9c8fPLNC/WJqpac4F8rPpIfyPz1RUaUo?=
 =?us-ascii?Q?HEy2XX12kZiipNWkIEp6GT/mFIRAbtR8Ht2pdzdxyj4EGhf9T+8m49U5VLqu?=
 =?us-ascii?Q?pnT2Z68RqFdFoomGadYMLoU58bp3cXdQR6j1TfFe1FGvQZOBDBAk1pT8fw7v?=
 =?us-ascii?Q?ImDogyzHS6TqS8XgpyE6D2qrsdXBMNPm/AJNvO3m7KVUD8aegwvBMKibPz8v?=
 =?us-ascii?Q?y36HpsTGRaftLOsrYFu5Y8hwhvBOChiZQxW33dtEk6dM+StFz6/q11JvUC3z?=
 =?us-ascii?Q?cGN832RQUij92ebit2+KKWDOo2nF75ArqpD/gedjcmI+mQRG9sj5NlD1LETQ?=
 =?us-ascii?Q?Kxi7VQ72hc/rFUMaf8ZvmL+ib09X5JNCn6C4tfJCuyavggI4VCg8SV/X3PkF?=
 =?us-ascii?Q?uROMYvJc5VfxO4jZYRakyEYYDT8E0loNLvFqSOs4twieMyUOTv3HnLRrZyr5?=
 =?us-ascii?Q?I2Ebxb2EZi2PzYAbPBQ31dU2UMzJckLZhR4rho52m2sHzuJNmurpOZJzYMdP?=
 =?us-ascii?Q?zzAeXgbMkdKle/tU6ysk2rkLY48xChmQDHO+3e0L7WjkYN8jQ+qwRiBIa4dH?=
 =?us-ascii?Q?u776xrwi3B2V3S2CSwbG8zAjNQv7+TQdnJw80jArBF24vKlsaCGSuP7OOJyQ?=
 =?us-ascii?Q?JCuBCFsxz18Y7xKVXJfHMuiCprQ+BwWmeaqvvcB692hAcmdqhQTogkLmS4TA?=
 =?us-ascii?Q?X6TQkuB4/YHw97Val6xhacamMsYSyqenwsX/2MflVa5F+s/IcbMhqh1FMzxC?=
 =?us-ascii?Q?HJBmElwXguJ9fVPa9QggAkExUAWw9XI/IFDAhqc09fX1CqU/7Lp1Bu0yW6jF?=
 =?us-ascii?Q?2tAavJvhclpxmcjpuC9skFkfTDxIDvsT5AUaYbDTfrX/PUNfl1M3bwnUM9OA?=
 =?us-ascii?Q?K3PBIa89ybA2Uac/d6MBLqLjIXNP/Ppm11dniP8PEv3rbHmjuKuTYBRYlx3d?=
 =?us-ascii?Q?Ifx5d1VoMzz+mSP8twaH1OsYiMBgZSk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbfce92-b345-4af2-f15d-08de9cc3edcd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:57:25.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0qrqhC0USOy2jSa0dhvkLhilhUw+wlW3OPMoYVJ89yY2282AMwbqVKN46OcvGTwiB0gZGj2pPpFBumIS7weW7Ri5I1IZ8JIYUmecfw3ge4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

Added to the defconfig to support the current workflow with a debug
disablement snippet.

Added as a section in the end of the file to make factoring out debug
configs at a later stage easier.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-kernel/linux/files/common_nodbg.cfg  |  2 ++
 recipes-kernel/linux/files/riscv64_defconfig | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
index a57463b..6637d16 100644
--- a/recipes-kernel/linux/files/common_nodbg.cfg
+++ b/recipes-kernel/linux/files/common_nodbg.cfg
@@ -1,5 +1,7 @@
 # CONFIG_IPIPE_DEBUG is not set
 # CONFIG_XENO_OPT_DEBUG is not set
+# CONFIG_EVL_DEBUG is not set
+# CONFIG_EVL_DEBUG_CORE is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_BUG_ON_DATA_CORRUPTION is not set
diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kernel/linux/files/riscv64_defconfig
index 8f9e852..6b991ae 100644
--- a/recipes-kernel/linux/files/riscv64_defconfig
+++ b/recipes-kernel/linux/files/riscv64_defconfig
@@ -311,3 +311,18 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_FS=y
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
+
+
+# Debug additions
+CONFIG_BUG_ON_DATA_CORRUPTION=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_LIST=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_DEBUG_VM=y
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_EVL_DEBUG=y
+CONFIG_EVL_DEBUG_CORE=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_STACKTRACE=y
-- 
2.43.0

