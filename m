Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1B3F075B
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077407; cv=fail; b=Zy3fAONWB7f5vrnJGPlc+jLUOxMpTyR2kHDJxgb/Opo8K5TbXiTSCNpfuO0tdqXCChH3OfNVOWQB4tWS1fLTOsp91mfZDe9zzTqyhTuapZipE0+36hpZ5nfT6AmKjA3Fb2OMAB4/d3qfPzZ2D0WegJidN3QsfZf4FNm5LS7v0Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077407; c=relaxed/simple;
	bh=GwBV8dqsREYzwKq3FDsJIj+RgDacNxmTHloYHuxvLrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3vdV1HichoBnE+9zxNXlVkAjs0GcA4a0tvbmBIrgPeVHDE/aYxoGCJVNaH9pnfpjiN6h+/en7GNlRolonJYJcIij0vhrzzu0B9S25A61IfaF0HdMNdAIMOJYR+5npKypTfFkGXceId8qK0L3fsKATaYffHxkqa1S9KxCQ9Do6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fZe6C+H1; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fZe6C+H1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqYIn8DNvW2GMDRxU59/bTmq1SgGuukloHHRMbcLM9wZjJ8Km/3rc2gLvg1PiO23o0d2MfWyGSfPvGnGeWbtnI2WkkoHzqJKq8lF9+qll50si5ss6rT4RDsToL6wdFTSdCSTa9JAvPeCRC1R7n/mZBNFsKvifpunGCvQgQQTCoLIsQ7vwsHWjtU8L2pEjizbUhoSuh2OtSyYEh7vlkbvqJpOZu8mxPKgRz9yyQB2ZvgbRUhtmqQsVkpD7VmOuNY7Nzhai2mqIOnr4ZyCP7jZFg16AU7xK9uzDAAykNAIAf5fAXlG/r2080oPZhcB2U+tonHvTUKUadZX5T0jg5Bw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn1ZfL8xg3ZGJK8PneSSbjDzRaS66pJby5PVzB7UQt0=;
 b=s7c3iHBLjnY8S44i6hXVQwzaKIYKoo5OFqosPD3JDJacNgEnNl+fn2sY86Uv7Sey/CNPb3or0RFaPv1f5+z5e4YbnONrPzdDq6ukrheS2o0CxlIg3DEVJ/bG1GS2nupwXj/hXRvXsrsHfK6q4Xve9HZCj0QlveYJWjhe/CzjZc7d5MTc7wl6sv5UywZsS7TRKZnIg0GrjpwT7ADFnkTW3YHwQoSPWln3fKrpTHjiG1jOoS91RpsDVd2uv9zFiPeSipnJW/3tkc18W5QXdwlK/3fUJ80DG8jRAOouXI2j2h2+6V1Iem76btgM+yp1bjesFxN58Y/1DvXR7rxJjvbtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn1ZfL8xg3ZGJK8PneSSbjDzRaS66pJby5PVzB7UQt0=;
 b=fZe6C+H1TeJhr9jvGfcbqEvSI5ToW/R5Mtr9enXr/85UScuDiUTGJhG4zyvTUb7gLANatnxde++rRTWIprzDKqnk4GPcBaLQ0ZKhBWo5U88O2miTkeTLJnYMclMUZYjx+aCBg9AeJ+Jp76ddGusY3/X3vISRMF6FBZW19teT5rwx5CqwTcAhOZgj2QkwPgJFO6fAmDqhc+/W8Oxm83IbNtGMyuSZIadDEnNU5avptO6uOXOfPrn2U4BmIydc1VlNYVlfsbosAbQnRKZ27+4w5if4gWnwWWy+5hsoQIKFml1jO9QSuN4zGEVjLdtZd0Vw9eMi6GV76/S4Yipg3v9/Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB8115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:19 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 12/12] riscv: add dovetail-aware memory management
Date: Thu, 22 Jan 2026 11:23:04 +0100
Message-ID: <20260122102304.421957-13-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ebeb494-a21a-4108-de21-08de59a0432c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gITsqYcrlo6Tr/bXGqD9JvWZ2HPuTGVTaj3jj2zxGCwwBIyOJ6awo5Grvvdr?=
 =?us-ascii?Q?qJCr+e1/ZQLmGXuMTVPXznEvSIUF+7tFVNN9jV3JnAniGR/sRKk2rbhhYaGH?=
 =?us-ascii?Q?nVPC2xt1SUpDcOSqRO8NqIAwTa/O4jiJvaYaLUzRx0zVcRtdyG1OJFwnXfft?=
 =?us-ascii?Q?fbyTZGpBJTbVy9fmjA1nCLdGz/8vyuL8qt21I5jHD3yH09gQnJ93BuMx9AGd?=
 =?us-ascii?Q?B9bRKJMs3pkI4BrFIkvwI2DShxiHV/c+74R3n/TWasRsxqlsIBapB4PlEJ1U?=
 =?us-ascii?Q?aSHYda6p2vdSjG4+iNWH8mNbnBKS+DpPI446VCFv7R4iNQQbE7Db8Y5v4HDU?=
 =?us-ascii?Q?Dct2RngaAdHOKVDJ7DaL5n3l+hqIJa6nm1g95MyoReeyHmej+tUKGA/IPUYT?=
 =?us-ascii?Q?x6+D7CnQjfhhXqCgfyM6MDsIl0OLdISZb7K1yWCvMHVsDqrd/uWVuIxViTyl?=
 =?us-ascii?Q?QhwBUG11/NQ6by9XeC7IWQtZYsz6wfL54w3zBOPHIvTvl+1RwZYlCIW+8JPe?=
 =?us-ascii?Q?sd0PuDszgE97NIVZA5bI6P7V5VVM59YuZopqSYcwC/sODs/3yptC6VqNYmcT?=
 =?us-ascii?Q?u6t7WxJIUxcUhc6kyrKMziuMLu9snt7ZoFfiiuCi5Uye2jJGs7KQkNiX/qtf?=
 =?us-ascii?Q?FPGDT0xuAGN3K8m8EyRLuU9HUflEHcLdY8/zRStIAaq0ooEnDCeQf55mBR0B?=
 =?us-ascii?Q?xfTYQKIW9ePg38Phuywsxsx5IVVmUW8LmjQb7s5oYgaOM6/4yEu7Ue2+xxVB?=
 =?us-ascii?Q?fYQ2YsPggV7FjTdAg/23UDRVExTue8MI1dQ03ZScmZhNqC7+e80QrvOQH1+0?=
 =?us-ascii?Q?GgegzlMzwf1dLdMqerLSUKGt7ewdGCvy6bDQ6FPpiKtpq1xcnIDHQlNbTr9H?=
 =?us-ascii?Q?M7X5vw0nmnmFizMGsR6oFvYL3LpEA77jcTY/MN0sGduLmvD7qaOsiIphRqAl?=
 =?us-ascii?Q?agVTyEhVok7ifuQZvtxdsPygIQrl1H4q4k7lQNuD8mQP+DYdLewhz/iQpB1s?=
 =?us-ascii?Q?Yr4KTJK9JDWtbFR5ftkx9GGkAm2CAeqe/ECLliXXprSHqsU7/jSwD4OSWMN9?=
 =?us-ascii?Q?h1vnRNvn+uxPu/AXtcPoPppc45DGvaJ+TPg9pzL++x3ewLTCWb9t5akGgE0X?=
 =?us-ascii?Q?yKu5QPACPYpouqM0970XyLNM5Cnk9tBQyCQiV/IFqd4hJrqN2Tsj63HrJX4o?=
 =?us-ascii?Q?InS2/1fGpc8rPHCUnrEJ/dFvJMRVXje37qQhshYA9o9UVEm6ifDqipqWHcuO?=
 =?us-ascii?Q?rHERPoy9HvyydpOwP9K8U+3SpR5T84jSig8PyAZ7OkY2QtmQnW8McnJDx279?=
 =?us-ascii?Q?B2Ja7nq3jZ4R7NMIKsG+BFEHY2xGei+Gv21lA+nvF520a8Vh8s0ZHFOavIsE?=
 =?us-ascii?Q?fEP2Cf3KYfx6U/SR4++gtsSkAJECBc7SmWqpdJWr6Vn9OQijAnV6AJUf9SN6?=
 =?us-ascii?Q?MN+9roGROB8Obn2e3dwW6HapVih23OBZqRl6ElJwMIruMG2hq8K5NPoV+kxB?=
 =?us-ascii?Q?xhL07DaC3YhmbucBcMbYffEYQPgoI6NCF7z/fClSiZbddUiD0FlbQKePJYPk?=
 =?us-ascii?Q?9Ct34aMx9uWHMdNiq8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcM0mlupmDQOU5E/yFzZ1K/rP6emD5+lppws8Mrof3eHTxa0rHv6cJW743Hq?=
 =?us-ascii?Q?vYncwZbcAK+08s8e5CBF+DnVmrXokWcI24ZxRccLGfVDC7kzCy/VgPCo7Ns9?=
 =?us-ascii?Q?9LtK2pvDoMm32Ol3eAjDntZx6/hvzI3CXFVnEPEaT3ffTQ37LJgOCoudEWDw?=
 =?us-ascii?Q?w+7Wa1F9/xsCU160TxR29rWlrfgz5wgD+ym3gm5w9+147G4MNq0Haw7fOeie?=
 =?us-ascii?Q?QXErQ5dMb5RylR6L1Gj7WIm4b05VldwXoaBdaoEDB1cm0d2HZAb8wEszBNRB?=
 =?us-ascii?Q?IxYIwobW/C4I8Z2B00JHVOMD00+v6QHYjoCBJJC1V2gnpfPy/d4VB2v5zmo0?=
 =?us-ascii?Q?MK11NOg1o0TmpBiNfwy4tdx6Jx8921+tZxKONTL56QDudzerI6gJxsTzszA0?=
 =?us-ascii?Q?GQXThMk5vIXt83eb4lD8DAPBN8+k+jgJoV4m7dnGaEruSihV1oyDXKuxgH/U?=
 =?us-ascii?Q?aPJCRHdsSKdBPEVHZS5Xvi+gQobWFZtWNbYjcxdSBxyJvJcmy66BcP9GavyM?=
 =?us-ascii?Q?33a1AcaQ9rh+Mkb7mMgDlrTbneROUBx+Ab9gQysfXyzfadHlsxlc1qsvIAo6?=
 =?us-ascii?Q?/seCMnyzr1nFEszt2RlNALtaSqIo+pmmXtdEsGNukqxRsFZWmod/zE0/4aJM?=
 =?us-ascii?Q?PYMPEq/4EmG24CO6sMwAGUel31h/t7YvrpY9BzOVND/KUi8mod2dQ0ouWgiy?=
 =?us-ascii?Q?+KghSZoUbGEi4Gzghp3HEQqhjhA3UujawqCQ0xzdpw3AXaBpHHMX8RcqQgei?=
 =?us-ascii?Q?fnrvbN6P1xr9PeheD5en8tnh4K0zH7baWS3znXi3tMRlxSO1LJET1b6B9n6o?=
 =?us-ascii?Q?trZEpfYijkT6fFY0i+rxWfCT1cXSnKTOpSlG39mw5X1x1sGpZePfFtG1/MCm?=
 =?us-ascii?Q?eptRnsspXVyPxioXV31f7kpevp+IUEbsjiIa9mvHvkOmN4BsNyxzLhuhlh7d?=
 =?us-ascii?Q?Nfs4wqDI/6Gq9dKveNUkS8+WWhGC170c65VC9CeY6Cf1muKU6L+IocpDL8P8?=
 =?us-ascii?Q?HtWsFAeorJpV0+IaZNHFSiB6xU20qzu8AttQ2nPVYlvWgLqaizsU82u4nWDU?=
 =?us-ascii?Q?3XJoXOtGYUg0YRzUPB2OJt3u+lsK5Do3fPwOEDxLiAwZsM/ywP1fo+GtTs0Q?=
 =?us-ascii?Q?VlFFoNeejgW9GBDRgjzpKEG93Cfz2WBh9dxwdUcZsh09Ffffzw8t9S/thkLq?=
 =?us-ascii?Q?b04VffvTHOshEpmZwbvrBj6SRpWhdPd3+Zsl9FJt//oeIjTPcb3SXFpX7jB/?=
 =?us-ascii?Q?/fznIZqKxk16FtKFbmu/EOylqRV84gf1di4KFBj4wW+s+EUmbaBmuP03MJ65?=
 =?us-ascii?Q?ymnQoWWUcVSxeFS5JkZBRSDgNOqh5Smj6qBfTAeRlo7KFzg4NYIMpeXPjOMU?=
 =?us-ascii?Q?fY0/WFmTUszWbfn2i/dcfTHoX1TRawnRCI1PSOr1WnfJltPHESWZQ4pIYJzp?=
 =?us-ascii?Q?gXdLFIuNaWQ0eKDiwXnt6zvxM8fpMSZsTFLZ6/zURQpY+9TbeRI8HX/FqojL?=
 =?us-ascii?Q?7TX0yW4XTqms3WnupJ2sSDtgYGsO669MIBCSiSfFAVbL/Nb1aTMxSKuAabtg?=
 =?us-ascii?Q?S9eME3JEUN8Rvbnh2d39QJSZRpP1cmJhJHWh5iI98ZntkYK4Ly/4pkcGoRwi?=
 =?us-ascii?Q?S0/IejvUs64anU3kzgZIDuGh2W5NvBVg3/7xCyqkwsm9crol8eQkK7oclf7U?=
 =?us-ascii?Q?e1Olp/AYl9L5atMFfQ7GYAKvMVGipaerAj9nJloDO8ESGwBav2PZYYwDCQmy?=
 =?us-ascii?Q?BL+N6GjJX4S4ZpR8VJ1+/bFndKg8xc8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebeb494-a21a-4108-de21-08de59a0432c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:19.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM7BkIo8d/Ei+KDyW41LBm9vB31TVwsbtfo5AT75JWOyXYwF6oyWHgaUAeECO7hmfNrONLsd9IX0MHu6C/YPiIdPCWx7hvJEJsJECyfmQm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8115

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
index 444136d7b253..da5d88d270c3 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -15,6 +15,8 @@
 
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
+void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	struct task_struct *task);
 
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
@@ -38,10 +40,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-static inline void
-switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
-	      struct task_struct *tsk) { }
-
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
 #ifdef CONFIG_RISCV_ISA_SUPM
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index d83a612464f6..762139b0ebb7 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -58,8 +58,9 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 {
 	unsigned int cpu;
 	cpumask_t others, *mask;
+	unsigned long flags;
 
-	preempt_disable();
+	flags = hard_preempt_disable();
 
 	/* Mark every hart's icache as needing a flush for this MM. */
 	mask = &mm->context.icache_stale_mask;
@@ -91,7 +92,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
 	}
 
-	preempt_enable();
+	hard_preempt_enable(flags);
 }
 
 #endif /* CONFIG_SMP */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 55c20ad1f744..f5f50b3e8407 100644
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
index 42450c47ee12..0e2269e33cb9 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -7,6 +7,7 @@
  */
 
 
+#include <linux/preempt.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -369,7 +370,7 @@ void handle_page_fault(struct pt_regs *regs)
 	 * If we're in an interrupt, have no user context, or are running
 	 * in an atomic region, then we must not take the fault.
 	 */
-	if (unlikely(faulthandler_disabled() || !mm)) {
+	if (unlikely(running_inband() && (faulthandler_disabled() || !mm))) {
 		tsk->thread.bad_cause = cause;
 		no_context(regs, addr);
 		return;
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8404530ec00f..294f0af63d6a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -122,11 +122,12 @@ static void __flush_tlb_range(struct mm_struct *mm,
 {
 	unsigned long asid = get_mm_asid(mm);
 	unsigned int cpu;
+	unsigned long flags;
 
 	if (cpumask_empty(cmask))
 		return;
 
-	cpu = get_cpu();
+	cpu = hard_get_cpu(flags);
 
 	/* Check if the TLB flush needs to be sent to other CPUs. */
 	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
@@ -143,7 +144,7 @@ static void __flush_tlb_range(struct mm_struct *mm,
 		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
 	}
 
-	put_cpu();
+	hard_put_cpu(flags);
 
 	if (mm)
 		mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + size);
-- 
2.43.0

