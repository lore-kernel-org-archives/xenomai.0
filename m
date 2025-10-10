Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9742ED15A
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089951; cv=fail; b=QfhMgMk1KlCVFWZlugc+PuG+jtK+rZsFwLifO1QbOlco79gfEwuVATkYqiqHzjBgbsIjduUOOc8YS7S4Uyl72Du5/hDsnEaWF8uo5afzGDOcLH4/C/7/eQ1J6qT+IyhXOcRSnJvDDnyUTKxPnnw50CZ14DcmDo+gA4fEV2f6Fh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089951; c=relaxed/simple;
	bh=eBylErW1ks5v9xKKMLKAg+BLPSGKqk7g7i9fgz9WODY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j78KciA9C4YpM8ykJAdo8yAIHUIcunAe3bNU41ILGpCORmigPpl3DljYRMYhbgdqD77VJ+2VrlR1AOl33Qa0MMJscRVsouDlBA2QdIzrAz8Y2/yypI02qdSgjgfLXlQlRJc3Aa/I20N8mLdsbUeDZGv5aR+wcuGzjEaVjAE3gA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UG+VDtXI; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UG+VDtXI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZv3WJ7c+m+ctgJl3+Y4Emo8U0b5JN8WDYo4yhYM4aOHlOPFCU6CSJblAbomRF2AClZaLUw504CIC7l08Zzloh4fWSajHJluxvl6BwVQKd6rB/TaySVDMWQ6/oXY6ezbGKJ5+6+A2629an+YTd0VuKeTZH8X+rfn8PIKMGFI3fywuevzVcdAOvZO4Fr1UNcMIz6xqNy1WZFgClgZqpqpN83bHJXnXLWdJTojSI7UcUU0TJC2wjQkWRJGoluZAgXiAfjO0QKseXUuhXnfWl9/K0Td8hCxRRN3FbvzkzHRBm8dMdSgCOlzvROYXh4hlkMHv+VRxVfWuP08jeke7T0Wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vpa5bthkMn1R7ZObiNvfGy6+XLjpjDj+xq1+6ONSPP4=;
 b=wL/0YBhrvMxYbkxpWbU9E9Hqp8DDnsleiZ6elKvZ7Q2pxDytXerVYCsUbmNnkQJ9/6yV3nEiSRjTHzXZbX2a30/lAsi0PjxIHeo9BtMTtlrz+4eIkZsrVYAyuijYxUPtYgQV6Hkdv9Xw7mFUXuwZSOZOTuxknqOuDVLqvcRpV+2KGtPTExrf37wCeIi32hbsYrNvDUiL9dM8M6NnofHR+bg5q2n6nAMLFYbOecLTTLNB4ls7SQj651V1PvQaRk1qDbjfHGJRkLlwgWqpHdPCHVxBG0GtxAgjhu+XevHZ7E3UoyymQM0kYLupAFJPXxcl6qpp44PN6stqiLqvMNp7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpa5bthkMn1R7ZObiNvfGy6+XLjpjDj+xq1+6ONSPP4=;
 b=UG+VDtXIzURhheKszDzaoqFy4mhF31DxUSCortroMIUgwdtYEpeC5wFoBv/4tnK1G3ko3c7N7iB6FvHNZeoim33SQvVBLE2w9J7viKktxduaM1luKa74TIDeMHzKW9rgOV+aDuiZ6PiPFpCrjN2Dkxd6Ym7oPOnuFMCY0Z4hx2Mxh1PteYk/lPXJ1tvh7mZABCwPC0BezxLC+uA2GzNtDvavKagUjvdhws6vScBhboTBVsN9qSaJhF6MM2Np5uyjX8Q02iSAAsvWtomunWm3lCIG/AVz7s4pLkM35pFguzNrcciMWbw/80j3IXxXvKxdVvudOQ8y/MOdDelCgmXx5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:21 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:21 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 7/8] riscv: add dovetail-aware memory management
Date: Fri, 10 Oct 2025 11:51:55 +0200
Message-ID: <20251010095156.3756799-8-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: f91e35b7-0910-4e03-b770-08de07e2b4cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M3H3nGCvxhQ4gViNse0Wt4ZRkExu4WPfKlcQkO5iFly7XFrYZlpUqdYBhH6j?=
 =?us-ascii?Q?hwj/INw3p/8RobKnIeDuuZvK5rdumc1DOj+03mS5todIAYrBpVc9UXG/ksag?=
 =?us-ascii?Q?Cvxb0LKtdomIJzzU70c72dpA9PKCfFc2jV/xzNKnIb8Pr+UkpOaQZiMOd50T?=
 =?us-ascii?Q?WN4KenjfLEyuw6MtYy6FDbDstVc8/JFiDdWGJBCu+2O8YS0gnVlyWEH8EZv3?=
 =?us-ascii?Q?1DUqyxm0BjX+fKcCRm5O8azlPi1+ndeniCPHcX6Jhntx+dPyV76s/diQfSJq?=
 =?us-ascii?Q?4BPhJQPg8YntNLUOmUsNeloQsl13BEItv6A8jN9XrAcAycw225/C1seWyyXa?=
 =?us-ascii?Q?M1tuaC3/U6vNHcKoaVAdU2EMrkCumUmtIklEe4pzAtt1/Te3FTRT00uXRZ50?=
 =?us-ascii?Q?7TuVwn3IXkf7XSDZ+p3OyZNQ7U9WqGnld8UW/I3J4vMf0g2UZzqkGjWkd087?=
 =?us-ascii?Q?7HEr89zYou3wFrgfCuzn4HsrUf6B7ChCheHqTupg5vTmJVot8YsNFvZHJei3?=
 =?us-ascii?Q?2GbpjahKG0oozaGJvGKGu1VzddugQKdWqSYj5snLURK1Tc/tAcLA/Pu2d1/i?=
 =?us-ascii?Q?IF8aBwl1pOs9RrPOyYr4MDgKxx2DkKif7oGGV1YVSlrGZ5BAmhDlyxgnmqle?=
 =?us-ascii?Q?bVa2jnZQ20BeTwTSIjJti9A12h9PDV9umKydqSC9BQYrDa49GuAKaR1itwuL?=
 =?us-ascii?Q?Mmi+D0ddWUDp0lhzstFY0Bg4sJSIG8GAFzBuFm9XJiW4LSBq0xPGFIoX6gSW?=
 =?us-ascii?Q?Xm/dB+b1CRKutB+N5QjrJ4Gnye7nZ1apJnQl4dMfp0gk9DT/9CLEzssJWPYj?=
 =?us-ascii?Q?DnXk8BycoazveUbUOjv2Dn+nfVRQXGscVIfeMvK1PXChhSZb8711z9Q/M9h6?=
 =?us-ascii?Q?04ZKsQ9Z5PlN4ObXdCtfWa0FgEjW6FqQsbozz81jJWaTai93rU42y/K4gWj6?=
 =?us-ascii?Q?UzpGo+cBNz6SyvqnhzW3P8LE6+p3r30zf7jO9KjvG7J756QAEy9oP2GuQMv9?=
 =?us-ascii?Q?P+4grMsYjTr07Bv9Bzr0yWJvblyTvMTbwGJLYZuxSiJ1cQ+YHGf8HGq2lWLn?=
 =?us-ascii?Q?WMpq+sOuCiFwgDktYi+/4FoXFCNx/akrpYCe/Q2yOMKCzZ94gpAUKuaCu3hY?=
 =?us-ascii?Q?JvprIfTQ5DksaxwxN3HxcKJLUHlkRBvxkw+Ta0dxJCQnT1/uv+2bj+MVbCSY?=
 =?us-ascii?Q?H3TDdtxL1m0OUMpU8XXYjBYrOYRg34PxgOv0D5cbvPJmDyyLxGd0Y/hwqh5q?=
 =?us-ascii?Q?VgrtrZyPeGhUUZs4TtnvvtC3CUXuaFAFK/qWL+psclp8Qjh11jgEtbtYnLZR?=
 =?us-ascii?Q?sqntJ+IPLmOyuxTmkIRtjR7CsuwDaAgWGufCzuvuQOwFf8J04JFLxEMwQHir?=
 =?us-ascii?Q?pwzlNxYQcriJu3/XPD32Iq3htnQMHlXKMEq/l7iNBPhaUeaB0divsKN1AE6S?=
 =?us-ascii?Q?Q07R8nOX1Qn2p4ofd8IDzQmo2jAJe0Iw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EnrZ1MSqq/B7yvsBgekDVl8M2DXOTkbcP/Ji7NQxKzx3CxlaQvCxtJAllye3?=
 =?us-ascii?Q?K/n4uhgDDjk5uHbmztRNnbg73OrsaM6Ae5jntpwiJNAg+IOj0H5dZe3v+2Be?=
 =?us-ascii?Q?U4D1r9tX1DHV0lukwg2v42zT5fjN/qgJq6Quxc1SNhp9k8/0B4ZnSiFpfAA6?=
 =?us-ascii?Q?sjBsRtWxmhE64jOpVVwIsK2G3skaVjUBfhnO0shgFWKldK5BOdXshP4NDK5a?=
 =?us-ascii?Q?rNmdv5uBUuBlg6KKFuKzBYV00JfKFCR7E2aqQLlds0tKKQ21SMTBcig6h3Hn?=
 =?us-ascii?Q?r9qKV664/u6RNjOASASmTOKrKWsm8BGFviCh3+v4STJJ1A0JEZy6yrJxvYSZ?=
 =?us-ascii?Q?t0chFLP/tf7nkyzwcf33/vt5RFqOym5LuZnSvBBH/+nDeqfb/Y2xWfi+8khV?=
 =?us-ascii?Q?tS/qDlq6RYHb2Ka8r8t0I1ADhequ4SZW/UB/kEIfAlkmffaV/WHGo/rG83Gy?=
 =?us-ascii?Q?0aV3DSKrII+Ny42GK7AhSV6xACSnjKTiXurFV+aCXSn67qJ5K4WE2F4eJ13W?=
 =?us-ascii?Q?AIdEUUVKmhDk9KYg2XB0xiig8mM5S/BZ9bshTV0CkJ9AHnBnAQ/m/NPeh1pr?=
 =?us-ascii?Q?9zTLoJFhr17Hj3mnxjrJyRjobknFHgkzQvQe2G02Bq9IpGpck8hktgvFSfBE?=
 =?us-ascii?Q?ZdamJ4AQBt9wkdnMd/xb7lLffu4Zk97D8r5P8mFWAcpLnV72VEAz9TGXRckI?=
 =?us-ascii?Q?1X/kdsVQBJIwVbdHy5R6xjaOomwOlnZkI1TQUsYe1VqGo/ndJ6z+zCUOBUPX?=
 =?us-ascii?Q?IZTcBxlTEWO8uUexPcv0iAcpqnXgOsIcwlFBp/Fpjuk49fABOzt5Q3YZlYec?=
 =?us-ascii?Q?CbW3pbHtcbQvrxVN4ppcInwmFrvEHcEN58ivvGRsqPRXwbGBo9fzqkUrpDSM?=
 =?us-ascii?Q?oWXxXi3b/ClesqMJt7P40Tj4l5ilr/5C+o1gV4qc0xAMzffwT3wSxJGWBN0Z?=
 =?us-ascii?Q?eJiNw/n2oQRgs5PxRhNQozRyBYw7GKSlm9R+Y8caDHjIShCwOXemFJJhPlzO?=
 =?us-ascii?Q?+490kAcXLi1CcSC9QGMNqGRqs1ftwuKDKujTWGon/nGcpZwq+rUzhs4n3xje?=
 =?us-ascii?Q?uRveheFsg97/vYnoP/J3gJKu9m30iba94spTg4s3BId/EPDyBuaFNtppAYZr?=
 =?us-ascii?Q?dnKSTh22UavIODipJ04OnIK5fdV5iKClRCbnReXnmglyOzlYRBG7a4YSc7K7?=
 =?us-ascii?Q?Q1spRJDGONqcomdS/I1n4bczll59MKUmOzFLL3m22q6dPiALE8yp7qz5cx2j?=
 =?us-ascii?Q?fsHmuPLrS/Q/Hkf3pY5r2arcM6Cog+Y6gEvRCRTX6GsrGaZBJ8ZUSQP3paXL?=
 =?us-ascii?Q?yEakUCCuq40OXB74UY5zIeHAfIfVW/bYEoUwNZjtBSdNXVwpfQU85Jz8JKLR?=
 =?us-ascii?Q?h7u4OK2HkAzxE2VFPmWBlHwW5sNRZn8zIfzPFwNEW2FT801I2JTzVVW7o/k6?=
 =?us-ascii?Q?Ncwhwjuvm6kSj0CSM385d0FZw6SCKLDUrlKC0yFKaOo/fEPUOXYPTjaaPOfo?=
 =?us-ascii?Q?abLZZzD0ejoH3egSeCc/iGdhik24CdrnsJ27BiN7R8G9hYnwlYaVaO7un7eQ?=
 =?us-ascii?Q?2w4GdWDflwAQbzWATAf5d805DYQYMwHBnhL4UisbwjmBrLGnIqPwCf/rfqhA?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91e35b7-0910-4e03-b770-08de07e2b4cc
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:21.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMoazeMESN/HZ6vGZcl62Use7c+yYtvtGaV+yoC8LiJgADUNMtymeGvwq9xyNLdLa6Fum7lyK+ofoduTh8nMb4fiqJ4tN4/4QyIf9g8ny6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

From: shannmu <shanmu1901@gmail.com>

This patch provides the foundation for safely managing memory contexts
for both in-band and out-of-band tasks in the co-kernel.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/mmu_context.h |  6 ++----
 arch/riscv/mm/cacheflush.c           |  5 +++--
 arch/riscv/mm/context.c              | 18 +++++++++++++++++-
 arch/riscv/mm/fault.c                |  3 ++-
 arch/riscv/mm/tlbflush.c             |  5 +++--
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index acf3b8e20e27..b62d69dbdd06 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -15,6 +15,8 @@
 
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
+void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	struct task_struct *task);
 
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
@@ -33,10 +35,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-static inline void
-switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
-	      struct task_struct *tsk) { }
-
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
 #include <asm-generic/mmu_context.h>
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index b81672729887..6dabe4c0a203 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -45,8 +45,9 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 {
 	unsigned int cpu;
 	cpumask_t others, *mask;
+	unsigned long flags;
 
-	preempt_disable();
+	flags = hard_preempt_disable();
 
 	/* Mark every hart's icache as needing a flush for this MM. */
 	mask = &mm->context.icache_stale_mask;
@@ -78,7 +79,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
 	}
 
-	preempt_enable();
+	hard_preempt_enable(flags);
 }
 
 #endif /* CONFIG_SMP */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 4abe3de23225..81199e192804 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -315,7 +315,7 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
 #endif
 }
 
-void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+static void do_switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task)
 {
 	unsigned int cpu;
@@ -336,3 +336,19 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	flush_icache_deferred(next, cpu, task);
 }
+
+void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+	struct task_struct *task)
+{
+	unsigned flags;
+
+	protect_inband_mm(flags);
+	do_switch_mm(prev, next, task);
+	unprotect_inband_mm(flags);
+}
+
+void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	struct task_struct *task)
+{
+	do_switch_mm(prev, next, task);
+}
\ No newline at end of file
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index f7275f1a39ac..97bd890d65a4 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -7,6 +7,7 @@
  */
 
 
+#include <linux/preempt.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -263,7 +264,7 @@ void handle_page_fault(struct pt_regs *regs)
 	 * If we're in an interrupt, have no user context, or are running
 	 * in an atomic region, then we must not take the fault.
 	 */
-	if (unlikely(faulthandler_disabled() || !mm)) {
+	if (unlikely(running_inband() && (faulthandler_disabled() || !mm))) {
 		tsk->thread.bad_cause = cause;
 		no_context(regs, addr);
 		return;
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce3867..0009593bd5ec 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -83,11 +83,12 @@ static void __flush_tlb_range(const struct cpumask *cmask, unsigned long asid,
 			      unsigned long stride)
 {
 	unsigned int cpu;
+	unsigned long flags;
 
 	if (cpumask_empty(cmask))
 		return;
 
-	cpu = get_cpu();
+	cpu = hard_get_cpu(flags);
 
 	/* Check if the TLB flush needs to be sent to other CPUs. */
 	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
@@ -104,7 +105,7 @@ static void __flush_tlb_range(const struct cpumask *cmask, unsigned long asid,
 		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
 	}
 
-	put_cpu();
+	hard_put_cpu(flags);
 }
 
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
-- 
2.43.0

