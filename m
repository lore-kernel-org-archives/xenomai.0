Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BE34D913
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035829; cv=fail; b=boav+DA0PZ38z1EnYyWt2uVUHrDxBDQvvEtBRDihY099T0LrrWoMFizMdsagzqkTQsdOY6yuc2xh74xVqTacDI85rVUxeemOyyOVjgB/kDyWZUSiLDc0uth09edNWIBnDMiljmSvcZyaNKKEQsf0K/oLQhNP3zGZ7+jLmfGTiq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035829; c=relaxed/simple;
	bh=XveWj7b2ByD+A9MQZhCDmchpSWPp01/lg6eJktvpTlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mp08MNNzdAXz3Eurw2X0x5pHqDpzDUmvLI2eikB6DnqOqtFjLOOn2tCYhS5G4poHPH5JVSlYigq5SuoOsF7pPaavFLjfRThwTu0tHCHtfiaH5LFgM/mgk8RVAa2Ps6aI6+43YwsBI5pqSOz4yLUKF4UWxl+/2X5+pguZM+GoH9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xwZ2mC3W; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xwZ2mC3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0liWrY3Ci39349E0+FpVmmrwh4UoI5HED08a3abJCiobbB+DEuyE4DxFmu2YIr07DGbtKVNnHXYPfTqd5iht7c+DXZpTIRHx3MG60zfYnYEasBFBgWL8NIzqzDb0SbFwqmwG41Ph5reBm5BcCFFbLSVTvl0yfxbinwVKIm35NnZD3fnUSRtGDOO2wKZSp2aAFd+DvgdbRNTWwynMUHaydcMuraItQ/8+ThDC8jS95UUEKLbbY7aQBFXR56S2e5yWem7A1sj53mYREwYQtVBbZXk99LTi2IGX0obVTvx7PAgB1ym8Sz9kxHvqPHc+R8yl9AOPJLl3kkpMnFGhRAMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6+A0ZOnM49YLIf484XT6SwR3+hzpK7UP9JmvDmMRDw=;
 b=gszLY5UzwwhJXUjsKkOFs2b699vsMP2W3jNiUH6RddjBUamiGLOJM0ZWfrIKf5iH0gd+DB+Eek9aL48pLm6Njku4ESpJx2alKKv4CJlWQkz6v/KVtim7EvbA3H2oRlrZbtPH/I0dsXMtk8cCCO0mNlaXZnzabargLhVxo+pCHgQxe7IlQ9hA4ZUABidrF9N+8ZakebOsN3gx2ozysiTRAhmTjYQdMmbH6y8hMiwI9/0Kl/jfhWtyeyvJEHHOrFDOIMW7eCIl9HZgesRnWd6N9NIJT0RLiy+H1zPiZjCbSZ7UlITjJfvBvx/tWVgkDqusHgryxmsobUyE6aSfod6LwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6+A0ZOnM49YLIf484XT6SwR3+hzpK7UP9JmvDmMRDw=;
 b=xwZ2mC3WAztx4FECeSRF/ZRYBYyNfyxwaZxCndhjuyOywDLmQhdWhkVk4upcUknGUIyz3thnwCyjPcEYBrCR+CIVXt0QfVDHCGd9sXWpTBy4ZrWu/U7s3C4ce2HGyswV2OQjIo39xQYXPzd/XT65Gu5NfQOXLDmKElhOJejSRD/kH0jCp15ZkBEnrP8+ZcLEGQ4m3w8aTlgWRAnvKzH8XN5aCoTp7MVP8ke02XQvFoY88vNuc749IPd8QeoWrb6fVE7Z2TLf5PogjtwUYNQyxVBeROrHvHxSG+cY1Pi52Eszctd4heRKXi4pxFyxBA5wm0fRLqCqvWWmwoPOgQLVbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB4PR10MB6069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 12:10:24 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:24 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 5/8] riscv: add initial dovetail co-kernel skeleton
Date: Thu, 13 Nov 2025 13:10:00 +0100
Message-ID: <20251113121003.416012-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113121003.416012-1-tobias.schaffner@siemens.com>
References: <20251113121003.416012-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DB4PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb663c4-5b80-4f08-02cb-08de22ad9fd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0l3S6hs3WCJfnt0/WPr1Wu8MXZvQ0hpSPLl/GiXVAEmO40cxp1XJK1UYM+g5?=
 =?us-ascii?Q?ApZN0hhU2pt2EM8cQRPRSSOz5OcInDkFd7xnEo23VQJxulrZXoof1SJi5RcO?=
 =?us-ascii?Q?IW7r4nKXsmhwhlKR7qSa6NbEMl1ruoJdWmVblPvs6vYcSA7/Nd9m+yW5CeIY?=
 =?us-ascii?Q?sdUc/zf9XmGYy7GEjrj9/5Ow+ydLCV8wHXCmIIuTt/TxR8doGr/r474OFHqk?=
 =?us-ascii?Q?wddzgtDwU47QlU+JeMVLS0JcZFxpSCrc7ouVrsp9LA9QJaFeyz45VPpIELBO?=
 =?us-ascii?Q?EMJRRhBvRndzo944DfD5zg99knbupKNg64tEhukPJ0opdG58gGI3B/x+Yk7U?=
 =?us-ascii?Q?wAvqi2/xWRuI28D+Y9EKkb3vOi+fJa7MjyyPfyZZ/613DTYJOIhZWIPfLjhh?=
 =?us-ascii?Q?iBDwahCavB/rkiNtpSm7YowYyXYIZ/lto87zPRGrzOkj2opKq6MaOrCn0Sjr?=
 =?us-ascii?Q?mgTjp9s//8imcsiEPxUs3K7Z7rRfaBzy+IJcduDuwrwOThLo4VqtxO5a1tMJ?=
 =?us-ascii?Q?5JQcGSVK57ekTKQupemhfcFK98mPmj3I+bdf9KBF6Gax/TSjagtRnUqshjbW?=
 =?us-ascii?Q?oQ/FC/7VLu0pGSTaRPogmPQHg3QxXTitwOVDaMEJ8VmGA7SImWSS7ilZQomC?=
 =?us-ascii?Q?Y1OpRxGB1zAuXG+mmCyCaeRf8rGc7cMoysHx0euvdzQmxJlyrLjBx/n7hSg0?=
 =?us-ascii?Q?q6jP1dXwD2BtBtrvj06E7TTpEkZwukuLMm2letYVwJjTVkdDaj0RcGFX/5V5?=
 =?us-ascii?Q?xE2m6GBX14tTgrzLmVRRGsqhXHw56z82XKfjcRBKRvavIFEwcCiPVuO9Bwx4?=
 =?us-ascii?Q?2fnHlpRkARxgTriQ4jOFqBiLbGJ6xf0Fy5R4+oERvV2N4RtQZJCIFSiw9ah7?=
 =?us-ascii?Q?sMTTKY5QagMYbHSkTTH6Czi30juocyM+WZbMgb9HYbvHVfyL6s3UUyI27L0e?=
 =?us-ascii?Q?i/KiDtBhY+noYNTILm5UUwHf2BwI7vTunGlVl3dVSBBKe25+0LQLQxKfpetD?=
 =?us-ascii?Q?LwzZMFyIVR5qvYklaF5rhV1GTsYKK+HW+JN97Rq3FC39Re7LGJrc1MiKaGEz?=
 =?us-ascii?Q?8a1nkclWiaW3xmWFzY044gIjAs7kKkFm6meHTW+sHjdobFwsfIbAcyozuhfH?=
 =?us-ascii?Q?XbEe7tx37RLT6RvYhUIdK/fq20G897mHfTZMzPVKfebtRl5KavC4VIPgC88N?=
 =?us-ascii?Q?MeOhs4QGc+E7KENLYWyGueucRkBKvpwSRsuOtaCmWwKXiO2cw0uhUkn1l5bf?=
 =?us-ascii?Q?cT/4L1Qk45X6t2g/RDTnhvC6TdGaoKHSVabVY08dETR/NyBHfQGiNi8UMErU?=
 =?us-ascii?Q?EV9hwrERhuHToDF+q6h45mdjEaWYx19En9vkI1Z/GlweatgQG/M9pbNqoLe5?=
 =?us-ascii?Q?BQDwHsmWm+YHSfIw4S8FRkN0jOvFyljruR35AlKiS/uq4o58QmCTYYOCHneH?=
 =?us-ascii?Q?I/+RHG6Pm2fvYSbrZ6Xl4Zwd3nvaWnmQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yw4TcUbje62AZ0aI5qzi/6uw40VEkPT1dsFORxDjl9amropLvh563S7R2Axr?=
 =?us-ascii?Q?jFMTAUvonpzJvcHEwIPk9JNE0+Q2wxC2Rwab/I0Cke4jyBQ523xyvVb+AXR2?=
 =?us-ascii?Q?loyDB6AvWQ5FXMiXwPQM8bkfKeCnT9gaE4sOZVrgt+rPm+cnbvFYqD3mR+PF?=
 =?us-ascii?Q?WcJwS5Hl3Vh9zhokVL7vd6Gm2oNHvXlCzJNzpxcFjALVedF+CZoR7/EEL4+u?=
 =?us-ascii?Q?OkLy0NsUAd/DazK21iSsiC7czPyCj0adPdQCzfYoke110OyQhsOnm5JNIt83?=
 =?us-ascii?Q?E7aSeyxnAr35Y6fu6eAbfECf4CmI2BWqeTxrGCd+xDfn6MJfnmxlkB4rz4gt?=
 =?us-ascii?Q?m8s+slX0emcDJQd0EhfaNXMjEyLM/gBmMr4bl0/0RevXUunLAeNEpdB+1tvS?=
 =?us-ascii?Q?atx4H3W8Em4InCVgj9H6zrZF2uTClQpQu1viNaz6SlrHycgYgTkmYMJCEZnF?=
 =?us-ascii?Q?5L7MOyO0bROXx96QnAkV6xAxEgTzVBoS6myu8V5B5P8kKaHh559DqhXr29Kq?=
 =?us-ascii?Q?jEMpTztgYzoAQomOlJJW1B+ND6p2KGZLJFRyqJJ5qYGW+SOb3y8JAEghzfaj?=
 =?us-ascii?Q?wCBoSL7sWXCShaloE6M6eKAIfyff/FJCdGqDFs0RsXy/PXnPMOChgmt/90DS?=
 =?us-ascii?Q?YtEX64Va6AttL0weOQSSRyGM5KLPMI9D+LCI4+npfV++lMGRcnyI3zeoeRqT?=
 =?us-ascii?Q?AO4vS6MyqKqZokx3vuoSFYwNPYWiEYF1+VGWPFrwu/e/NX6OB6oqPOVyUqzH?=
 =?us-ascii?Q?BKX3417zynfHHy77YHmRX1SpZ6D6/o+YHvRlnx8eNLtsPjEYcEi9qXRIvYZb?=
 =?us-ascii?Q?nWsGRTK6nfV/JW/H01dbpdqMP3l+NuaW6ME6KN6wGxa/zQkJ/4OeTmCgtvgR?=
 =?us-ascii?Q?gUhIPdeWBjKyoqUZva0ay6WOABt24Kc96iT+HQgjUMjcDJbyeTZmB1KiyPDx?=
 =?us-ascii?Q?83aJqRXd7jnhiigR/8OP/6/xv/v79D0de/IZg+RfNJWaFYomITatKgJjon/3?=
 =?us-ascii?Q?vlpH3JYspJQWb9Jgt9NV43pupmp3SyiZdzxdLE8n3Wz2R1Y7fYu+uYHsvXSE?=
 =?us-ascii?Q?3Hi0zDKuZiGAwhBG7cQ6rCPtase13SP865egdDKphlAVvP4+7QpXFormBLc2?=
 =?us-ascii?Q?en0RgJjH6/R0SFaOPaiEiuHTIAHeFwInEl53Aao8ESWcjPtM8StnU+QIgeNZ?=
 =?us-ascii?Q?CTpfy7HyzO9HiX1DAcJ4x9goofCRxK1xwbQr2McX1fOSieM9NBQcwIfUQZYQ?=
 =?us-ascii?Q?WgO7bqWSLgA4XTobQsCVRSNEiMb8rzfE0yjYVqWGiKQmaaRP8n51ndzL1gFv?=
 =?us-ascii?Q?jjvyNgyeMQ+3UzCJlqQKE1U5pyLOYwQWndjei/y1wFtgecWG6u4u+GYj30fB?=
 =?us-ascii?Q?uXO2Sn5ZWZBzb779D0fgL5a/oQ1jeHxKrfR8qWGEd7djyl0Cqd47vPWuWviP?=
 =?us-ascii?Q?93M/Qw04Ldpp+tvF+e3aEW2dm/nTg8QOAnh8XzX2IlyPIy0zcnRDhOVwStXc?=
 =?us-ascii?Q?mEXG0lkjByyTAkU+wUnodszb1Ywj3nENJ5ID+D90GGAgKls00XE9wpuIIyXS?=
 =?us-ascii?Q?Kxcl93nN7wkCqDVMYfOviLrGDZds4fzBvH8A/J8X8ykDeYJGwgbxEkwPFvJu?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb663c4-5b80-4f08-02cb-08de22ad9fd3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:24.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k//jB+kDv41VOOMsjIw5Z6d8dHvP53x0IMvY1692t9s9wPXCBKWUZb4gbJGxn7sSyonBeSGlBRL+vWCqQZnkZzJmF927unWECWZJ2rzULwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6069

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |  2 ++
 arch/riscv/include/asm/dovetail.h    | 23 +++++++++++++++++++++++
 arch/riscv/include/asm/mmu_context.h |  4 ++++
 arch/riscv/include/asm/syscall.h     |  6 ++++++
 arch/riscv/include/asm/thread_info.h |  9 +++++++++
 5 files changed, 44 insertions(+)
 create mode 100644 arch/riscv/include/asm/dovetail.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 19c5624b3ffb..5cc3df56a58c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -136,6 +136,7 @@ config RISCV
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_IRQ_PIPELINE
+	select HAVE_DOVETAIL
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
@@ -371,6 +372,7 @@ config AS_HAS_OPTION_ARCH
 
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
+source "kernel/Kconfig.dovetail"
 
 menu "Platform type"
 
diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
new file mode 100644
index 000000000000..bb342e9eb18a
--- /dev/null
+++ b/arch/riscv/include/asm/dovetail.h
@@ -0,0 +1,23 @@
+/*
+* SPDX-License-Identifier: GPL-2.0
+*
+* Copyright (C) 2024 Tobias Schaffner
+*/
+#ifndef _ASM_RISCV_DOVETAIL_H
+#define _ASM_RISCV_DOVETAIL_H
+
+#if !defined(__ASSEMBLY__)
+#ifdef CONFIG_DOVETAIL
+
+static inline void arch_dovetail_exec_prepare(void)
+{ }
+
+static inline void arch_dovetail_switch_prepare(bool leave_inband)
+{ }
+
+static inline void arch_dovetail_switch_finish(bool enter_inband)
+{ }
+
+#endif /* CONFIG_DOVETAIL */
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASM_RISCV_DOVETAIL_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..acf3b8e20e27 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,6 +33,10 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
+static inline void
+switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	      struct task_struct *tsk) { }
+
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
 #include <asm-generic/mmu_context.h>
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 121fff429dce..0e02161280e6 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -95,6 +95,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 	return false;
 }
 
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
+{
+	return regs->orig_a0;
+}
+
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
 asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 1c7a61a4292e..b8e0a5ea2fed 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -41,6 +41,7 @@
 
 #include <asm/processor.h>
 #include <asm/csr.h>
+#include <dovetail/thread_info.h>
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -77,6 +78,7 @@ struct thread_info {
 	 */
 	unsigned long		a0, a1, a2;
 #endif
+	struct oob_thread_state oob_state;      /* co-kernel thread state */
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
@@ -120,6 +122,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
+#define TIF_RETUSER		13      /* INBAND_TASK_RETUSER is pending */
+#define TIF_MAYDAY		14      /* emergency trap pending */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -127,10 +131,15 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
+#define _TIF_RETUSER		(1 << TIF_RETUSER)
+#define _TIF_MAYDAY		(1 << TIF_MAYDAY)
 
 /*
  * Local (synchronous) thread flags.
  */
 #define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
-- 
2.43.0

