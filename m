Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570134D92C
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035832; cv=fail; b=N67623GmBojFKF6fllJ+S+T+wkEkMe4ec1xk4Jpbc1kJoP9Rp2Tv1XOEUP8Izni4szkOgSZXOSRYUOPCH52Tkk9ZUsRCEefILX0A/oeaqMB7tjHQKVF0Ot8CTVd0eW2Hl0d5djkBnAk/9jo2DDHXBoNu3Owgh5v29PKZBuJLyVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035832; c=relaxed/simple;
	bh=26BrmrUI5THoxYIO2PlrFtCiLSkjnG3ME6xu+rJ7sr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpPOe7d+Uj/fp8s5oHKatxoznKIwmm4EY0sCYlJBaHQkgCQXMwoVY5iaLR3Oo7JTnnIaTZhdQj/V7q+jJ3IcYeG+EDREg2mOiE91T22lF6R6nq642zPWhxnqwiqbIKaQYFF/NCk5o68emV3BB9p3Q7KmJN3uqijI3dlZEqKlckQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YFWuptSd; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YFWuptSd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAObgOrJ2jkuo6cX2UfUw5VlTFWjVWO5dRyHH4tRpjIZp2e/g79F2W1NV7O4oVHXA5miueHMU+HGn38nGDwLyJ6vb2zdMS8HHdWmEM0eaTtZeeQY7w3op/uOvGTbsFy1fQesiN2HY4ArThEXmVviupD26QMgBH5kTypVLltC8w+7M/QIGc3imCe/noGTWZhrffqdWmzYn2U+FikkJqADxHDu7vAgm1HMyfnywffSUkO2QlN56fjNhe/Iji/GLUVct3oJKivthwaGfK8jfY75eZb6CA5v+DWHeww0f5NkOf6O68ytM5aAJWSeztI74Z+9ySk4GIRwVDSqkohL3N73Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbp2Gd1Qd6ZwAHrpsaIv6ObrfIsPfk4Lx3BSpN4uPgY=;
 b=eiiRVYn6+OTlrSST5W+ny8+QvEdsgKhgmVRdsuHN4TlGYlmOfAh+Y6gG1PRgad3LmYrWknHR0BYTy4XPoWZKDt7B1NM/fw2hTKXT1E1X0g00ydLHrcc7pXxv9wySD/s0wAdyOG8F9aZ2GRVH2aZBQECDsYOwwlKlliFugQVkBgoOcYvUyp5ZayXVwmJPmtm1bS0QTlGiw+En56uxjhb9rt632NMUGJtF0YnxrE/ORsriFWBUxRdeVDrFwaDjcscxeW3cwoOVJNyX/YIP88BEUfmd09MkK0ved7nbHbeP473q8njAtflDh0XP702az11s5Tfd6+vwegdlwB+jyb2mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbp2Gd1Qd6ZwAHrpsaIv6ObrfIsPfk4Lx3BSpN4uPgY=;
 b=YFWuptSdh5aFcRhotLBgjYcDnBMaTpvl5MK2QkWZ358LJn1xgDtUTr9qbPD8tNLF5tNjCMn/k3tm1zFMPI0LGXmg12BiLKIuVSobLimGVD0e7p4z3KbFkwuFnjLl3ZsZRmAKQ1DrLrIivkgvGC7sR2ud3BC7CJ3FjNaxnkz63EiTZjyccwWCg1HiFRHEKniFqRPeRbyrcVkhrA5+2AjLLKR4XlpMbA2ieG8siTGY1q7w8dYU7aQxQ42djlZ9xQx/v0mGdBjeCj3uhS0QjJtg7+80hWY8kUZMikONAz564cOVb0IGwzwUUW04tTLkuPZ74+KuUnPaM9tuygCHJU72HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB9PR10MB8286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:10:27 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:27 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 7/8] riscv: add dovetail-aware memory management
Date: Thu, 13 Nov 2025 13:10:02 +0100
Message-ID: <20251113121003.416012-8-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DB9PR10MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: b162e6df-ee36-46e7-9201-08de22ada1f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1RioZkmo71D0/f68wcC0QZxtwInszGFsjmxAK5uZ961FnnJjOGLZGG8lqfw?=
 =?us-ascii?Q?BOO5XPymVr165DAsgkQSBH9DJqvsagSrcLED0YWUZwY7zQCSzRt0wrxBKj3t?=
 =?us-ascii?Q?0r0dIhd87XJpdiOcuY4kg6wUfn4OTnv5cqQFaBHbv6Xsi57dvTtvltrW1WeK?=
 =?us-ascii?Q?Lma2r3dWF3j1fc+mWx+6Alx4XHRuu5/gG5m8k1/bV50iwXc9G0pO00anYiMu?=
 =?us-ascii?Q?HXvhSwOzkj0o9OABVkHq+VBU1Xb1YaO+NNnr6f5/VdJ2cTTGSAsF5ZSwxWzf?=
 =?us-ascii?Q?/KE514/k4GxhtBMeU3ZPY64aK3mBAPdw+AGa1k9SESR8nWkITDZvCKhDMi1Z?=
 =?us-ascii?Q?qe+/DBy5QDmc6uahNVB+82YLbbF3zPxHNF/NuH2TzhpaNy9w7hoHNwhPTqV0?=
 =?us-ascii?Q?iMEKJ0nDIKGF+pT3dV7fLH2+aE5BwSUBMeu06y77vsE/7SVlz5jwV1d1X5c9?=
 =?us-ascii?Q?xVopJdaREkU6W79cPElrS4GnubyvVXgkEDKICM1ci33wXKxML9Y0WPJDXKs3?=
 =?us-ascii?Q?N97ROFaIUp/VYxVGCJQhe2/bLyMFL/5ECVvhKyhfO1kEvwipv6VmkbIqiS31?=
 =?us-ascii?Q?4bA+jHRB+2h9AClczJLgC+IUWb/1sZKXtXSQNyrImsNk48otLHSqJt/AnQ8I?=
 =?us-ascii?Q?6AGehb4E7KD2ASlChoZrfYPtEn7Wqpb59VwrCdx74siloVqnGxKJsIMSF66T?=
 =?us-ascii?Q?gXRJcU+xOwRKFv6oOaDPzRpWKagYtYiKoY46W6GrBHNTnnFlqmWfqpdJUtOq?=
 =?us-ascii?Q?1Z7zfYK8KEf3CqSQmj27Amiac6LhKfSAY5X79qZEWqK687KfmeeC82rAXSpc?=
 =?us-ascii?Q?7w5JR/42qsH9IctggsO8Sr20i3U6winDAsF/EbQ68w8891wehbb7DrBPVRGS?=
 =?us-ascii?Q?S7N9TRAdus5GcRK2hjeRiDEUrr9aFrUdtAjUeRkcafyj1k5ONNc118zSjR5d?=
 =?us-ascii?Q?2vI6TQ28YX4h9tlI/gq8Cow5X+6MrMlfqD09XO0LyuLhazaE8TmeUhmqPs79?=
 =?us-ascii?Q?TpM1PwwogGl+AsI4KB0Lz/0lUkYB3qLDyYxnnksIaGAYQZcfecBxndVqrqLZ?=
 =?us-ascii?Q?Qv2+govHiZLqWYwOTjvyj94rwrHN4B+45MsRry4hgrrDI2Vyw7gJWO/P/Hbo?=
 =?us-ascii?Q?GMbSpLPuB7sLegOvXIg8ujjPoOim7uJ3E5eFooBNQYUytdt+i0UZB/3X0z3A?=
 =?us-ascii?Q?NtMPH3QjPd/Fiu7MfLmgR2WACLYHhfLP0Undsm31g5c+LpDTGdoMJEDHPOVQ?=
 =?us-ascii?Q?ZHgvQFgTZU/ZDoA0aSygYKixteSIaaCjDPtJALQuaTTYheEebnT/nSVSQiRR?=
 =?us-ascii?Q?S4d4u0QMcstAVTCGE4gTaWCbVFR0OULD5ucjheJGRHkkG8SBcvMMJf9xt+pf?=
 =?us-ascii?Q?9oFKjedNMRLN2qrdhxB5V2AqV8qLgI/h9Ub+f77DTsg3uF7VpneCqrLL51Mm?=
 =?us-ascii?Q?xfaBhO3DyiwPLpY4bTt85sXbaWJdgBr6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHoUGFfATDfsfB5uF8HwLAJ1Xbyly7uvZ4l2SGk5lD+rib4cWl+S5uFB1o33?=
 =?us-ascii?Q?TPcuFZ8LaMNBXPooRPWeoRIt7Vfwcuf3zw0/LgMn1ItgkLuZfTdNorT/JcGT?=
 =?us-ascii?Q?YaJin5Yme8U9Rc5mNo/4UCspP66snWsilOXvvXF3L3Dv0uGhQgoayueFvRrA?=
 =?us-ascii?Q?m++7uC5CG56aCak2e0U1k9TjlP7zAhF95dYS9Me3MXaR/0D/eifzFlX0l71X?=
 =?us-ascii?Q?g2XOfUVIFVCQXJAtlvkTATmID8Y8JvWuJFX0QsGfjTR2oEIyPkty/IXmtzSt?=
 =?us-ascii?Q?ax/Kxx8B0V55pfAqlbZ8//MZUnTaM0fZk9UuCqmwQsy3h+zBKk8TUkCNt9Zh?=
 =?us-ascii?Q?4VbcCRuSKOEUtG6zudQZ7VQByDv98K81UlOlvb72QWMWeTT9pgt/6yWpQvOq?=
 =?us-ascii?Q?7s4YGFQDl59kJ1eGZfKrIyW6UJ9/r6q1fwM15rRMz6RTOK6DT0PWDCEjVMNC?=
 =?us-ascii?Q?bFkxOwjks2XNrumD4nbwiANYQehzNOj7lGUMTlPDJbN408GP5KHkCg3lIiGl?=
 =?us-ascii?Q?5VdX2Aj1eEZ+3G+9vjHaBG4k2ewB4GnT+8AOuf62NSaDbEg0dkU361hxI8dj?=
 =?us-ascii?Q?nKho1hryWzXk5pi9MyfqhpQ8wLsm2EYG5n2H3vgYGFDzwjZ0OsPFkzzfwFcc?=
 =?us-ascii?Q?uKu6DmqLa3D7ImkfisUrTduqOJFOMCAT1XugwCJDrRzIFO7/sVtcUPITJK5y?=
 =?us-ascii?Q?DdJzY7BNw0GglSM4gYE7Gc+KWgTSM+6bKPDhxrUekE4qzmJmiZnJ1X4vIms1?=
 =?us-ascii?Q?IWq4OIURxC0PbYF9KeL/1z6Drq+1vLvaCwsB8zVfaXRsM1sUJv+woI6hdo+D?=
 =?us-ascii?Q?t0wHMWHJ2B9s1WkRU3xPxYEFADPQuJv3MpEnf8KskE/N7sOF0BoHPT7i1K11?=
 =?us-ascii?Q?QEHPNSvZ9ESBuAROrCfMqWTEs1nZdYyIf/kIDKDSH5uquchIerPkT1IeuNAP?=
 =?us-ascii?Q?tEL5Txc2YZMyiPXThWP01798au9bSL9i8+AcEqyPz2denctZ0AymN7IM+vF8?=
 =?us-ascii?Q?koIhjUFTeMo3rGP8SbpTXNTrX+mn6/hE0CLdGIbi4gY1I0XaifZCBUZ/gxsu?=
 =?us-ascii?Q?iSvKR8s2h5k7vrIByfInKDRqSZIsEgUAYibmSU9cO3qojmyO++AbDO8BCVUC?=
 =?us-ascii?Q?9SDTh2XAoD8Cxcp43BR4JPnh1Ekgvh+vEIG2mWbLCtc++MR59X3crPswabWI?=
 =?us-ascii?Q?A4oJGtUi/8D2DfTFnmJTdaJ/RIsB3h+EfAh58zX4OtXxr1t0mh/4ka25KlCq?=
 =?us-ascii?Q?XbXjISAGURcEwi2L5k8f98PTxe0UmPkasdS0IEdhAnFQCOQJAYlcfk0HMgRJ?=
 =?us-ascii?Q?aUTdC40RpYcGOKDXV8AVXhbMZ7uxcquctT49CcdCMf55il7fjqjOY6U9BeZN?=
 =?us-ascii?Q?rZjyGwlcqZeDyg3PeuSID/IJee6A92aM5Eiix3vgH8SxaV2T0K6RyxvbKeq4?=
 =?us-ascii?Q?RE1J7/tONSbguZUlFNP4NgbYhxr4nC1wRWyNtS2w7PTpOuswIo5BA5ZDQNCB?=
 =?us-ascii?Q?mHkyXvD2hTVFFhQinNf4D0d1WhVqMy9HR0ckHGfXc89EkyyzW+mGBvTZSlMN?=
 =?us-ascii?Q?plUXg7H8ixa8fjUVdiSLnFPvWg2/2M3he5yud1aP++hFkECHhkxRT15k/ctx?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b162e6df-ee36-46e7-9201-08de22ada1f7
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:27.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU8X7rqZP4OfLpLThCWjWLJgR0T8qoVzjVwaAzSeH1zy1tW4cGuYvUycIX9Aw9u+c6XkoiSNF7A1FUexdUgoOovu5YenDQpwDNYm5sweEx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8286

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
index 7033119e4e2f..712ba55e7a7c 100644
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

