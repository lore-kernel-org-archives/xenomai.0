Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D332B9B7
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432740; cv=fail; b=M9JNGoiHO39KlYowDYItVjmsN1VKtYnMepHjyNaGnNYpUn30FWUU30OWbV52TRgwdBlZRQ6vZWnC8gnEB8rDWtvp6Jve3EqKMiFUNLhbsY7xrr25prp5oTqsSZxtdHT0uS2n2mIO+NRns3m4xh3H1FGgtyVikLhuUfVJh+YEBjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432740; c=relaxed/simple;
	bh=eBylErW1ks5v9xKKMLKAg+BLPSGKqk7g7i9fgz9WODY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/V6BeX7Brp/yVvTLptOJqPa1NGfI6Oxs3Zte+scg0Vy4y6I0h8gSo9U/cxXBWQHgYDS8IhIMdzpy83+tvvKl5e6uwfEKx8pxQHjUqk1Sh0Xm4okIsfLUArsVwxX4woC4mqPTFxwVQ8CZ+R91OcbG+wL57EYol434L8z39HHdTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kf7VATdM; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kf7VATdM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eu3nhtst4pv2ntq9mLJkHg2jFJ5X/6RQ1ur7ivWQ3HOvfuYaYF8JbcY+0zrmMjxnueExIlHDlp0VoBh/r7lsnlUTtMpcof0P+nyuObMvwTUJiMScMrXMNv2rOdv+56/BU0dLlpO+3pFwQeizZiFMCVjM2wN79TfVscQtRLKpiXHbxeciKMyPjnYCXGjF//ot4lghqVEEt5iOvcPfPMHlalKR8kaA0tWmYfpGyijFTI2lu9b23FjF5aYbvuQmsl0gjOZMguogPMqTL8fAITXaRZu8SrVLmJOvTO99kwf5DqSJ997JVFPbVG7D/23VyZlydWwXrG+vBblpK/zenwHnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vpa5bthkMn1R7ZObiNvfGy6+XLjpjDj+xq1+6ONSPP4=;
 b=auuVFCVdsfQJPZVGy8vcfgL8I2TOLQCQVkvwAKjVD6OxFYJ3HmdgfWf+zhsDMp7izNQ8PcgRuimzKW6E1EMdTYo9zSqupGjkKO6vMq44tM5AI+69b34qFi1RqghIB8RpifMwUqBhsGRNcclP+I/Z6dvSvat7QFLREqapwwvE/Kuk0+CSH52eyP1Qq27RhRgXP7KOly9DS27ZUx8oS60xY2FEmGw5tp8byYWIhTykQNqBkXfCizrpD8onX7qDUpAukJRvbM+xJa3B6KUJbMYYYr0ZB4MB7mu/Kh4U6BmNlJnUucnE6nj7gdHiLznyVF6MweyE9pp0+8/jRb3Pfstu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpa5bthkMn1R7ZObiNvfGy6+XLjpjDj+xq1+6ONSPP4=;
 b=kf7VATdMPqCAq2FoyQIl7bFEZMFR3id2lvwcETxeqGCSoi8yrf7TQV9IPO8v3PZzbGxQPH3ZCHrJ2bYe1wKa6vgQG+pUvWLMs1CWYdE2+dR9/Q6dGpPmtjOOjcR8FWPwf+gqOl4Tk44xZ+Qq12aXcxTcYBMFqVR+MSL9BCrWOLnQhSRb/10l7UidvK0TwUaqol6Q0KcCBorIgcDzAFoliqepyFRC/Mys5FwDpnunCq1D5bfBRjr1dhEYxrIJANutKkwpwuHs3PVHbNnJIOxWzMMCN3GIf4SgUeKJyET6qoZEUkd1zw6hclKoKa6d1pOUcluX9qfnnKQx7BUaapf+gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV2PR10MB9614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:302::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 12:38:54 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:54 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 7/8] riscv: add dovetail-aware memory management
Date: Thu,  6 Nov 2025 13:38:21 +0100
Message-ID: <20251106123822.1160385-8-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::21) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV2PR10MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: c801cbbc-286d-4ff7-adf2-08de1d317278
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICoGyg6rP9wO1GfZny7jeYPD8DEKPyA5jZ2GPB94qQ1VYMLNNG5abAqgo2DD?=
 =?us-ascii?Q?NHaSGeF78VQwgerDE+JRrVNNQZE6rEIIrO5nbnDHKzfpQeZF7BwdfRgPFvB2?=
 =?us-ascii?Q?Dqrm3RuS+ZuuJwVeWB2eC+qYF3NKV7yA7hBjGTtZZUZrHmCXbkhzfZp1Z/rb?=
 =?us-ascii?Q?iJcRBxf9W/TkaBJbbiEHvOGNxHEfsfs0aWupr3IcEi2fMVVCnZcVvIplYu+C?=
 =?us-ascii?Q?xmRn/dfRKO5n5WU9qv0Nl0If/PprfQN47uZ9d2Nd7RDRkplUV1/K9d2cch8V?=
 =?us-ascii?Q?ggxDZ7FRhmRW4TTaDCrRleHjTzdxJNHS7xtIVSxotPPiPy7etWR2FpR6ZO8j?=
 =?us-ascii?Q?jOVCH1L6I836U8FsY5kP7XNL61Exy9dnV4lk1CEhMtvUZT/8lR4+hVeGPmN4?=
 =?us-ascii?Q?iS61c8jqRpKN0L6JYp+88oHv1qFTpUs2FLy2nHcKn3xd+mQN+fG+Ct2fIWnf?=
 =?us-ascii?Q?gIyGkT3wwLwfviTt8S2Hk8kHB7GyWBXyHcXKXyAWEzIDZyqdJNCK/uXS7q6A?=
 =?us-ascii?Q?EQ5IssBJ6XPMgP9C0lG7ucVg9FRz5a6J5vqDhlNX+zc9tv5sraivleTZ3RLG?=
 =?us-ascii?Q?tVezgkdHDiZcX8Xo+PsLW6CV65TAhWPPg3hyCNemFr8cltkElDf3ZbK/NoRt?=
 =?us-ascii?Q?WLbdeWLp6cNs3Bz/vZk+XCbXDwvmj7H1/xySTi2FpsWggfjtW28+Loc2P8o8?=
 =?us-ascii?Q?jTQFwU9DahUILb6F0gDSM7Y8mjeC2S7wFU4N26iQ3UOpzxfrcCc84W/Id3rm?=
 =?us-ascii?Q?Hb1beYganEUzDTGNAedE9hDOPQ1M7t70RRZI2PvOgfq52RsyF6e05ibyBaKJ?=
 =?us-ascii?Q?5OsnPrJ0cToVE01zL4Fl4oEwPi3bWs1keeaLcdAvkw2QCpvbfo58Qh+qdVwf?=
 =?us-ascii?Q?yJmQTl9CYtQL16hZNpNcOjVYeQIqgcTNZT6oYZRBWR36XT0XN7O1hM6jT/rn?=
 =?us-ascii?Q?c2m6AIepDxMXJupCVoWh4lGVLPs5W217x/QV4/ZohNE31x3ylPls3Et6/tQA?=
 =?us-ascii?Q?vqJ8bBMyT/1mkJzjk6LJb0sX1KOFdM8z8IfkJkLlLgEPcjv7UyZv3JDE8dmr?=
 =?us-ascii?Q?UdeboknL8yR9k1xIw1zEIl4yMYazPUUmT+kzy1tiRHleJPbu3Wwv04kkkktu?=
 =?us-ascii?Q?n0Aa5B8O28B7FmkrcE5hrel7sJVB5qWfNGN3VGzya5aFw5H9I/sAT4WcVKAf?=
 =?us-ascii?Q?t9idpWWarK4vwwOPqD8tCUvgMIkVK5I4OFX7bDiEiZkWphqXnfPvl62XpnR6?=
 =?us-ascii?Q?Izf8NNZJQgSOXldnRrrQ3Jj7+yNwAA1i7ZHUbmi90Gz8hn7dGKrCQ6bAOI+q?=
 =?us-ascii?Q?22mpPSf7cMg412//gEu2a5BjCqwIOyZlBnLXuC/6ziG6W41GKrJ8hrpmJCDk?=
 =?us-ascii?Q?8sRVOIBkYtP+VXz2SnNqCD5PtJR4holMukcYgX7a6kz6uMSk/Afm/kM4q2xF?=
 =?us-ascii?Q?qEFeF6bHicGx8tx/8/O5N5pBf3OMvnNW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVHbHeuZLhpUjkuaZTBTRinoN9lA+exgm86Imwg2kUcqy0PBXtuIjy0mr433?=
 =?us-ascii?Q?j+SwNyZlbPGCqPtzpARYfoQ1CArwNtgbHd0SoquAXEZXXCE2N+WDq/llWi5+?=
 =?us-ascii?Q?fOo+t6pRZVYIrofP458r7UZ/YRVobxoRHRRNUfFO12e+1FQpOuRRAUKPDik/?=
 =?us-ascii?Q?VLfkP5M3OOmsp6tL6nDvpMfvXHB+xPsP5gNkfKTN7nrsk+JmCMNk6Xr9Gf5F?=
 =?us-ascii?Q?0AhlEzggMom0BUSPOt3NSDA/Di9hI3GBPIVegPjahjdzBgYzhAKgalt8QqmE?=
 =?us-ascii?Q?tiwA98cETZRyZU1zd2yC8J3oDImKySnVeWtk5etb0bEjYNSAKCnQlv0Drd/J?=
 =?us-ascii?Q?ZYFYiEbyI7+RHp9zeQ8m7bk2NQcfosMrfnH6/fzvJTmqCMYuATsz33XhN6Zn?=
 =?us-ascii?Q?KfJUxe4si0FqrfXjakruXisBlX/QzUIi5wnOwRGzDWE9DOHgfc6dmgFbSLVw?=
 =?us-ascii?Q?Y5T4s/N5JgCy61Z0MPIUCpYfi44kjHL4q6GgeL5DEdHjLT6xYhdDaojOMHPY?=
 =?us-ascii?Q?+RODqdPMvhfirA7nXbrvq/qBSHryt/2anCsRSNmfi6phODs6XVJHAdZNYNl4?=
 =?us-ascii?Q?tTGxuCN6HSBDktJR9UpHJUf9+KPj98gbda2igVwTKoH57obbp/6Y4DKJpr08?=
 =?us-ascii?Q?bj5UZWLCwv93vIJP9dV+vZ0zoyFt1XKd4YFdIgZFKSIzG0Jq4+QUVAfkH5g2?=
 =?us-ascii?Q?iVh9FTeIY5UDAaEaBjNhPtUY+1IjV2Gq6GKY5TxK7zb/sxTGI4xA+TYlDhLd?=
 =?us-ascii?Q?PIBR0luSNVLurOlEmvslX9u54oUe+IoGDTphkKy9opdyHr8cpTrWmpv1/6Ik?=
 =?us-ascii?Q?tA0p3AROVGb7sQyG6KrECB2EYgUnD1s9SdvOT+MJXUautvjU96zyJJ9drh5T?=
 =?us-ascii?Q?m7NdzF7E1xIe8yBrWGw93eDANyKMOvHPg9/QZxQe30jXMTNOQTm/2N6X1a/7?=
 =?us-ascii?Q?qO+xf4F7wtaUaMzXEHFk8GNbOfVKmQiFtydsrm9N+CG1jD6+PZsaixgu4phh?=
 =?us-ascii?Q?iisDyWmgXVo4ZMw/RKEG82I3inUCV3bJ9L3PoCfnj12WbV6GWQNXGjXQb3n/?=
 =?us-ascii?Q?8aTa6f8bi0Weatl86XFRMlBxGSRHsBLatLXejskVO8h1aE6A+0loKSSdxmWC?=
 =?us-ascii?Q?D/JeQVScHOt7HZy2tkGzAtK36asB/Q0RWy0KfBO/r22ILGNN2rib1D2taxh3?=
 =?us-ascii?Q?tI8Y3XJvfUIFKa6w0oBvTXxKcB4LDOWC6cvnJMSlHl79HoP3wrtXHGnEL4zv?=
 =?us-ascii?Q?doWq7GlloZfB/gKoI+5Jo05ctVYYmTHSPid1ppNAlwHCiwmuSL3JmXs4pIab?=
 =?us-ascii?Q?uFq9wfx+kHDkYNKjOfO+sqmOobN6oj2Pddc5YWSy6mgnP0rYAtdv3ZUqp065?=
 =?us-ascii?Q?XeRdRBxF40QK7DWot/rYX2h+Tqpe02IXyVGJ3HA/gLrtx2o0nSjSX2fhadsA?=
 =?us-ascii?Q?BLSHrW1beC+NnEAmUPgY9vpXBbz0EBQrcejXQFPv9mhcJrZw0A6Sn0gEaJqT?=
 =?us-ascii?Q?IRbjC1Smp6KFAyHbTi0Cv5XLxF2hQte4+hrT9i8sins6DKMzVGAjqAxP/5XH?=
 =?us-ascii?Q?xPnpMbf/J/l0dhsIt697vYC8uYgSMCW0qNyemruMfBZbIGKI0W/T6oloDe5+?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c801cbbc-286d-4ff7-adf2-08de1d317278
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:54.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /12HzwUPlc62iQuArzPRjZAy8uvfcAb988U8UHkv801O1SeUuYH+j42kClSFRKbn78Ls6vDLpQCp6Dl87IblKSb9YT4rqvewkiUQlvqZzJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9614

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

