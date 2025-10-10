Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863A2ED168
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089946; cv=fail; b=Q2tJJ/YCPKUmCsdJcY0GR4sbgjoQGVpN9oc8tewZXYkjjxpGn8EPPPkJtdK17Cc2WAnfVqmU8yl43ADVayb18a0g5z0MvDzersd1FOWtA1xz8mnMDAiwF8AqPj6nqceElG1pSBjxUXAQeNIen8P/XXIu6VMazUdytFPoCmMjTQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089946; c=relaxed/simple;
	bh=XveWj7b2ByD+A9MQZhCDmchpSWPp01/lg6eJktvpTlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MpvhuOL2LZQvZ7MUMiamnmotkPTEUKSa25xTunksV015k3uSoV3doaR3tPdFGqAfBQVSgTJ5iuk9Z4SfH319hkvNun4wcEvBp+qppbYkq2yLEUmuKjtiLkyQvKhvOKEXy/qDjkdNlse7B9YNvf1mNUjeEKNfv9C6NmYRBV23X5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RKvMPQyX; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RKvMPQyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4WUab+TvqMCkrN5GVlLln+SXBKqKIbmdnzT6qCEHiDu6z2GHUuy4nnQiCVB36zPvzo/6twpWR9SrSfxseMBxSXKnvL6ivs1dqy7nyo64UUmr3EZOOvAGSaJ0KK2NOXgGM0MycFBX3FEpPc9Jbh2F5SOmGjS19X8RpwYzc/IY4XN9uTJ4XJ/+ZigVO6GQnukaSrSPbrUFcHbTtITL4CmjyXuLQDeNO8h53u0jRs/HNEoZWEyAHctq6LCC1MLQeEMz2q5zyTrweg2XMsBhdBsEjf2/hO04+oLsJe07dLVtb2XhjJsISh9CFI9Iu1ImAiYFRKrrDOrJ1URLt9p3aFn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6+A0ZOnM49YLIf484XT6SwR3+hzpK7UP9JmvDmMRDw=;
 b=tMNiu0mfFR+eJWqwVUQYvZYYtaQ+KBtapRh4qSsbi1I1ODH4M1DHsoAt43PUwfAVr62DsK9+FokGFzVUAFaw0+rLv4dssdkRzBZTnHthsn+L2MLI7H1GXaWHuTfQi7jIxxTATsIItC5Xqm8PHKG9GLkWQm8jL35ODqWaO+GV8RQFR4p3AyIfRz5nl6IsFPz2es9bJwyGjwbouWHiT+jnPsrfNvVzq/JEWsYZCfBH8/2sTDIHK4YMY8iSAW46O0EbdPshpl97RKQ/8m+LGppKBkhTXzXZ6N9KOHptkBRpMUxeeIPmJwpUrPb7AvLWdsXmUo2rSt04Ak+Hl0aLgR1OvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6+A0ZOnM49YLIf484XT6SwR3+hzpK7UP9JmvDmMRDw=;
 b=RKvMPQyXsZl1opqeUohgeHypcjcE5fzYCbn+E0VNJ/EU9E3xkFabwi/D+Z1qacWlffj2aTOCQCgbAjK34akI63ygLa7xXrJt35XL35ruwnTOy6ce04ZbEcG5c0smtzlxut9zRNgRpyAve+qeSXNQh7ZAH41nTcL6yvGC3aADIRQ9ARZBB8qMqOGp2la9Bd8URgGS6WmucvuZjL9jTyryOIJCO45B/qAXN59ImhzCmNagSss7UsSpYeCh7O6ydYXynxG/4evPWTZT2/X0bKgzbMmF+82uMitGk2Nkqd7ngyKCmUA7YXuUOYRDbaaRxzgm5qt+nbm6DXCJrPNETE+JcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:19 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 5/8] riscv: add initial dovetail co-kernel skeleton
Date: Fri, 10 Oct 2025 11:51:53 +0200
Message-ID: <20251010095156.3756799-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: ec535c05-3024-434f-b423-08de07e2b3a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1CZuXSnP7cmfm4Hi+gCnn0AkQEN7DgBHYsha7AQhk6WeMsGGlO/JydbqSqne?=
 =?us-ascii?Q?9+qQV3jZ8HKgRo8mUpWx7o6yVWX/cCAqTzWjMpggzT9Ik1peKhqsNy1gEEdh?=
 =?us-ascii?Q?7FnDHy7EBZf4m9DEsbKnWuWaFmm+El2KD3s3MrwfJIRvz4D/GuJFBT9D4GDq?=
 =?us-ascii?Q?UWiqPFoAo+tNCCJjQjgKkirz84Sf4ORzNaASJ3lOWox+BnnD+wnA8jtAGT+7?=
 =?us-ascii?Q?HpKjGgRYFxSrecgJ2jubQcx08Z4R1Bry4wJRz1jPVoU5SUovl8hzqFEzr73e?=
 =?us-ascii?Q?N2PEdHb6AGhZBH3sVof5evhFj+7v1eJoQxnJaaq81kSUNQP+k1i0aUsUmnPQ?=
 =?us-ascii?Q?wKVUnl2T+E1PRaC4zi7CbxM0rfAwaMGWlRi9kaHRYOfNONgKsgzX7kkdNsWT?=
 =?us-ascii?Q?3ETjcMtGDe9luza/GwJSn0l1687woLGR4rxmtwGZMkoexC92+TKCkbFnFQZM?=
 =?us-ascii?Q?5w0W/8aBLli8biuj4XpeA0NZ9oPE+TLj7VXw4sHre8YT14/YmIYn7sooM2NT?=
 =?us-ascii?Q?+jUQ5Gj0oB7494u/qkz1gJHR5f21LfHtMlr+3S6gLu0SYbMPA1wW2sri4bii?=
 =?us-ascii?Q?9Nuf098enALB4dEkr6j9OE1dHU6eT1eitBZVwxbZRzQ5uqPkuNZNFJqZZbsV?=
 =?us-ascii?Q?Bjm+zcEx/ynfXCM15jxFdineum/hJxl4onPccz48LLxffkb+kc5pqZMOS9Ad?=
 =?us-ascii?Q?iFkwSFyg9lcjNpswHp0/V/inct37r+gaHV6tWHJOh4ILf7FDx3QqImJqbH1X?=
 =?us-ascii?Q?ziRUbFClgDuvBiplTyY6Jsh4Euf/6XZVs5xm/3a0oFlZpjo0VnCJHjxIPGnw?=
 =?us-ascii?Q?0nDToeKThoIXBE+UP+2bkBlu1espXVicoOvetTAvbeGNLK2d+JwVWL4zVDtD?=
 =?us-ascii?Q?xK2i9HyhEHsd6/MXX8IjX8k84HUj/1MlhhnIMQnbwQdY6OrjPnJN1/9ChMm1?=
 =?us-ascii?Q?sDvw1U5vW6lp+UyYgvA9t6iG/1eNUuM3hJCSYSitYfnmE5jFcOSo2NrdjBkL?=
 =?us-ascii?Q?3vUkdkcRkyVWVBNR2he0XbUzZ7hhnw3flIW7Av4EXLSY10HvH3wjyMQTw8gD?=
 =?us-ascii?Q?2+0wnWLdE1o8AgiN7rWxmna/pHJKXKymPRHlU/PbbbRwIwniCl7GpAxAWJ2i?=
 =?us-ascii?Q?UGP6ryRPfwhjud83ssSa1ehU99vQaNvgh3zlQBkCFtTqAZULERhRu1ZC8aeZ?=
 =?us-ascii?Q?dLkKaNnGDcD7kYmsA5c8k4NTOgDp1BbAPZq+QDAtkxo+53QHhMjni0el8qKP?=
 =?us-ascii?Q?CyfFrdSI/vaPjhD0q0SUNw+PI9De86wXu6aTD+xQ3nSCxAJ2zZ+9pn55wQ10?=
 =?us-ascii?Q?IMW0doOhs4q1v/T/6jdZhngBK//ZgVQguvon166T4fN1SFZenIrv9LK0jIVb?=
 =?us-ascii?Q?UHQMMiyFzbz8OZzD96E1le3r3mx9vgRzzpb6/OqHjMtyPpTTaVLVDAzQzDiK?=
 =?us-ascii?Q?OkkLZUiVuu2j6NVPv2p/ies0s41YKBiv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VM1SjQPr0wblBZbuhAZy+FXOpvnlRF7El5QAQCehtb1eJz946reuLIbeYGcV?=
 =?us-ascii?Q?aAdUJSseQbEYLRWnmguhxJNyz8/uZwpsh8kPqQaai2HWpwJCuTDDoIfPj86H?=
 =?us-ascii?Q?fJ7WMt83WRAIoejyBZrCGZc7I7XXDe2d7kxaWdxv+8HDnfMpOJkunm7t4bQj?=
 =?us-ascii?Q?Z5mWzyB88oUJxXcqrw4b8fCvKt+HQ5J3j1+cxuqRzWD4D2qQ51PcVEBp35NR?=
 =?us-ascii?Q?Jh3sOJzPnTwHRZh4MfeI0R+uTKFwUugPksKLfGvwp2gaTtUA0SjT5a6VnaNF?=
 =?us-ascii?Q?4lzIjbEN0mmcHXAgVneSuPz1hdKmkKGV8a0Wif7mNreeUgMrgU4w+uQgo5t9?=
 =?us-ascii?Q?J3iF7el2PENJUrwBAePAdjR6QHsRsT0FN+KEt6ClzIHJcspxM7qrWKm8bHEr?=
 =?us-ascii?Q?mbgCPoEII24q1DKhoZlAT+yRdMP7roallOdaMEPiUVUHwebu9E2tLbBs62Io?=
 =?us-ascii?Q?Q12k183cJZE5K36ktqNGz9eQZDtxHMmlEPVrZQ1FuI+EJWVHojl0SJi9wHXJ?=
 =?us-ascii?Q?h8mT50fN+YOuSKhVRVBOMywGcdNYqNX4QhsM8kPwkveiufobGgrXGjWxPVdg?=
 =?us-ascii?Q?c0P4DkzGffV8PYLEnsgxkMFb6DAds96yuNtctJ7EAl364GfN1SgfRPxZJd+1?=
 =?us-ascii?Q?odBP5aX4dKh+3Wne9nel7EH2QhRZtiSzGZm1+K7U12YJxWWcFZmsX9pF0TUs?=
 =?us-ascii?Q?mLnzuQOizjGbdEjg4lNMQmawfqN5uos3KibYbTk+ydADYIaVEmgPSIs1/mUR?=
 =?us-ascii?Q?FsNEtLgsRtTpL4lBhJWJp20RkFT/qsdWd0HomSyXpv7cHeLz6W/DiVh9zVxU?=
 =?us-ascii?Q?GXtHXh2rokrzyD2wkkBfO5FoZbShWfmv7vjWtPytir8qOK/pixg3kwpVfu3o?=
 =?us-ascii?Q?2EzEk+6LHbI6IbbrChgOi75ouW5Oz/CpVKCCtC+BL2SIzPCGtUqv69XJruTt?=
 =?us-ascii?Q?42mK2/XFuy3Z5ByaH7B2Dy2ix15SkE206dHnFGrUZ+UjTKfez+6DBbGGoPeM?=
 =?us-ascii?Q?9gVC2juRPjsOgeOj+EqTiGfUN+ozf2XV1yhtxrWsENadb0zGTLGNU7AVRvzT?=
 =?us-ascii?Q?+LaM1wEpp2Vk7a7zZ/iYHRc0z2rzfMGAvSEJ8eePJ2U3spUrQ/v3ATwC5sUe?=
 =?us-ascii?Q?0CmePfIMwrbiaJ2U568FvN9Re3YYF7//nBABKCLHRhOwOmpZ69mSHwNDVmDb?=
 =?us-ascii?Q?6jS+SHq7A0gCZsOBVlC/wbUesWWYI07TS6YaYP60UFwDzT3EAUjqk9J7bVSB?=
 =?us-ascii?Q?yy57IkzFOGG+TUHniUCD/EFNe4N3nJbM/fBtmJqP1QFTkCgHWyQ7jQptTu3s?=
 =?us-ascii?Q?USRsfGxtqBBKhWmu6pcdmlKTGMo+ObsckJlWHRgia7wv1TfapdHANMwlr5Dh?=
 =?us-ascii?Q?8ngtEfYMu13LTrzqQVyNnM0VuPintxFRsTfgGKr44cizud92vtP6oYw7PBr9?=
 =?us-ascii?Q?yBIpcaWipANvSa4ficlIHbi2qmQiPwiL0Y/DwK52EhMUh9vpiw2t9IA8XkCM?=
 =?us-ascii?Q?VISj5WhCkppEF8pC3y1zi2Wf0b6kdauIUtXsqB6etqGrEcNM5T6nQkh3yqKU?=
 =?us-ascii?Q?vLp5A8YKNqB7RwYR484DmJR7nVz4TsOg9a0/MPage2RmkM83VVw7jMtvLfnq?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec535c05-3024-434f-b423-08de07e2b3a4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:19.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNsVuOXA5uGLuIp1vJGgRd6lozuq2JL8rzA19pPtVY7O506t1lU1UnD1+o5tzCFziEJe7RC4jvzMzR9FsxbDbdy4Riv0gtD+YLnbLTxYOwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

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

