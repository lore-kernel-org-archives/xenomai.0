Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF12ED15A
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089942; cv=fail; b=ZVDSTXEVMIOhVllvSFDBQ9A3G7271DVNVovPd4VlrXCMqWCQlLn4d9FfX51CktyZAWvPVx20cSF8rTB2snG9ZGdCSH7GGEXQCGHAkKxmKkvRU5rzNEePwTPVYPfWNaddcImyOK1b5J2HG+RTe82upV3o27FGzRtFWMVa753G28M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089942; c=relaxed/simple;
	bh=p/TeAcBnRY+oeUJxT2mKKQnCOmVX7IOoF8VMEGFnYxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1EphFzDqnef2sI7CG8S7KXeRUCl+8BnMtpeiVZcWn2mTW8+2y2CHN35Rn87by3FhhdzFBB+i9djrMZ+rIFofuYLbV7jRfaifHT+whTs8cnWqmt/nAJXUrNcHRT9lbLU7XG8Yf1QiYTfDB+Pww9OSWT1Edd+gPX8Uou1RXbkYbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FWrQS2zI; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FWrQS2zI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwMrV53n0IVRvm7RN+4Tk/ge8iVvzu2d/Z8ffGB/pM4u2wevU4GvGumOhOHn6527o3WpACE/4AQSv8A7bVEomsqVJtk7wwNg36ws5cNrjyplFYkbUSzba7Z/LTJLVNQSCrGn4MyZ0f7ipcfaiqb1IUFldeF3+eQgWQ+fCS1D4CPU/qU7Xhp1GNgWuAzXTjd+p5dmTGl6NunR7oMzVB344frXy/FQFyBLvpT1uEs1QeFudKou8j7syoJFqAUURbFdYpI3LD06iknIYY42QVf04CCxZ+QroRM3f1MCeKVDm660bRzu5ZIoL1OmaPJ6ba+S3+Cp3JQI44W8F2BP/1k+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41h7E5maVO4mxEN1t80VnZ0HZZpsbS8X8+b3YLSjR+w=;
 b=jhA3VOohv5zhLvSLsOql8IukvGZq2PXGTA+DQ/1X64ibSm4gQ35ZkBxNE9hTZ3Q/elgJJfY0GvTZ87WEcdX8zwnU7mgb7jELSbgZ4fTzB3mPibBE74kWdKkbdn7TECjv/YhXIG6fXe+vruBA16E6LoBYpTd7Nyidv8eBgjpZ6jA9/JOnl0CovGXrnAA6Bwi3JB6Q2ibLMdWQPF7OLkBakDadCQp6V2tLdSPCXjUpIyyU/bkcpqoRDgqRNydmTeErSRP4jY/rSbN4paxK+oTJSOE+JLzsN3+0xNMkHxpywwU0hv7/BgmToT0WWE9jAj4fq1qifweFXDd0462q7dTq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41h7E5maVO4mxEN1t80VnZ0HZZpsbS8X8+b3YLSjR+w=;
 b=FWrQS2zIe2NFx1p/jCe1tI0ZfiIfVLKD84eyJP8iOcGZyJHEDG9SKE2OUfPYSY04vbbJqs9xAYnWJgWdu++BwE6qQfQsIvlzlRY6euW0I8TIZCFCpH7zBoSRs90dTpVB6ozEwZIkcNOQ+ai0VTaRp5YXo0XmppI07/r9yt1FqcfzTC9Zg2p+BAeMi5yY/pn5bqLVwASFzKcpad4Q1UpcVFJZ/sR3hB0/IOdCk41gj6M8UOjTOrvHO0XpbuKfNSr4yhlzBDR1aaEv9daHrd8FXXHof8dfcjGPCjxgeCK6HdrTDCb1P2LLwyrdEMq2kR9muTHgjJouEBhFjtc41UxlQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:16 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:16 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 2/8] riscv: only store interrupt enable flag in native_save_flags()
Date: Fri, 10 Oct 2025 11:51:50 +0200
Message-ID: <20251010095156.3756799-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb0bb19-12e8-4326-8aa9-08de07e2b1c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lyQhhnAgA7jYbKpamnmGnlm1mGn5e9qb7vrTHPjmnFZVX/ATeseZ30NVx3da?=
 =?us-ascii?Q?ohPsyn53+1uGlVxl2K1Ao+ci1UPF05bL+Kx5LrvXIRec7/Z6+t61RbbisM0x?=
 =?us-ascii?Q?44ItAhvUQVv5ooflzGLha3zr5EbYkXPnS0JSa3vLcXZBdCuSGti2W+YrVdEy?=
 =?us-ascii?Q?73QStpSGGxg9I5CQFybAphySDQFpzsyWygDQp1w6XYDTV0yihrFSKbxvWyBz?=
 =?us-ascii?Q?fUOVsFmBm/HwVAcJNVb9JntGzvjSz2BR1St2qSecI2BY8vUy9FV/zVm0HoQx?=
 =?us-ascii?Q?R+vP3iGKWO/jeR3ekX6yuwfOCbrruajtn9L7N4BQ1Rricn/ooaIHU8M3UO+Z?=
 =?us-ascii?Q?IEiANR6f56ZRyawad+2prl50EdQbZH26U9Q7czPFRcY7Svo8e6GWcEQhdsmj?=
 =?us-ascii?Q?qbFVt/pSX5Rm8eU481EmieSVL/peSgMHJTiSBPNJZ0navGVlrtQwt3zaq35k?=
 =?us-ascii?Q?jdDQRKA4O1O3o+rs7E4iN1Qd92Mft90//DkgssGrVgtpwpQa3VSqxfIXz55P?=
 =?us-ascii?Q?B04V4MS2c5PuW/IE9yTGMoCUTfOm0yN/mgeIs0b6fpwUYneyFieIblESZ1gp?=
 =?us-ascii?Q?bXcYYmOPySNJJQ5nT/rxlV6SXB0iozDhpEJxWHLH5B1ZNDMBMbJMpS2cd/1y?=
 =?us-ascii?Q?2KZHtmjK1KTbMUsfpjrlfh+tlecsAXXiHwwM7aYEcK9C4eUEptoVoW3eufhl?=
 =?us-ascii?Q?aFx9TDSwXZr2OV6hphhKIJ3gr0r2ayF0uPGp9jV6m6Qex2jZCs0xCLZxhVXL?=
 =?us-ascii?Q?liDw4NmIeUrqlBnJDVukA6o9dAAqaRinUh3J6/tS1pwjullWeJ9Ix0kBWxDK?=
 =?us-ascii?Q?V7cMgR8DCqXwd6y9pxSqCQtHhdNCKpw5RwtofADcdOqamVUC+QzWSmCKrUBw?=
 =?us-ascii?Q?S6nTyMezLLwkp754j32l+2WPmn6hUNmvHzY4HflNbp/YcG/H9zeq7qFb2gup?=
 =?us-ascii?Q?YzxWVyuNjOcryMraW70/0XVk/pS2N4oZ2Ex1EjGAwlk83Q/t10aAOVk/roW+?=
 =?us-ascii?Q?snoQzAA99YoN4Fy4fkdU30BWaaDYbBLuO2ntXBkfehD63bKbA6nFuh5d/Y4U?=
 =?us-ascii?Q?njXSW8P3QKMeZ8yzJ91o0QvEBjMjwR3VcF2CpRDJDAWKcrMlNGsEMhiOm2u1?=
 =?us-ascii?Q?oeCMHwSTwepm+GNg3WtIwWLL9yv6cTJy2yM4W6fT7YRedEcgbwwaGPbXwiMz?=
 =?us-ascii?Q?kHA/zGKEV+W7KXB6PRYoT9hflx9dS3bCMDlRSJC3+W5uTi8Ohpa/00xubCuD?=
 =?us-ascii?Q?lE6cYV8/hNiYOLA3aq8LyyYoq7x3QHuJn02G++2O476JGm6450PA1JfpeAqJ?=
 =?us-ascii?Q?ZIi0Tgjy2Tv1tfb5CwFf6ahy3rY/4EQ1GeIJwtHmZs/cfthY7QRSRDJHJ9Fn?=
 =?us-ascii?Q?EkGTmdXFt4hdfNFIIv3V/ein3bVvh+kKuPCoG0BR7GOYMqTs6QNctoOWiYXZ?=
 =?us-ascii?Q?5mrUrW4BPs8EGIosul5mns6gF+1s91OQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dn10HFvbt0Lb53Bsk6IyCx/rXfqLGBxbMl9AT24D7HcXXLWUkUvpvFWt9sHc?=
 =?us-ascii?Q?rKmqUikgW8u9lwzNagkvgJlHwTP5xeaF6EnQNXQTMTP/wSJLZjM94ZOmUCxG?=
 =?us-ascii?Q?svs6jV+gTLk2m6+wruo0c7OiYGXJk+bSPRn2SSAyajQRDBdvXGxtBb2gi+7p?=
 =?us-ascii?Q?bLQBvKxIzMI4NvP66+xeUJ1QW6zUSniEPolOlm8McKwTqYgqP1FsOBVZEqZ0?=
 =?us-ascii?Q?xQhSH/aADXiW18nQWsUU39E2I/eD/xTOTwLigydEon4XibZBqzeU7ZQ+izXr?=
 =?us-ascii?Q?IBF4Cp730aoY2MKMGvaIKKj3dKry36AEqboaGb2i/W+y4xEe19n0ux28JgvB?=
 =?us-ascii?Q?xFvbm83V8Rh4J8OxhPyNEQqiUEMKOTq/PU2SA52ik7OYNr5JY5n0AXsObOj1?=
 =?us-ascii?Q?Yy3Ebk9XNhspSBmUowKMBaiGbKtUJNqCokb4n7sOXhMGrOmx9Vt4hmX7MX/X?=
 =?us-ascii?Q?SYEV9GjTDV2XZLTZsa4LRqVMO96QVZt+D8N6w5nwT5DS8Lz3Xc2w59XKG0f1?=
 =?us-ascii?Q?LfQlVSRTwSO/CQXAn45AduwnCdwpRpALjcfvfVxxpFl+dtUXesT0HX/fvBDu?=
 =?us-ascii?Q?ii7jjE2pg1yBULbRY+pJaoe8TeW0mpQcDT27x5IZjxcYaM63S+gL3vS9ZlIF?=
 =?us-ascii?Q?qlnAowG5u+7mMGfn+7ah0Re8m0kuaID/sZJ2RKnMYt4ZR/qC0dPeeGF4Qqtt?=
 =?us-ascii?Q?rdxJIf1dvsw8HolhcQP3uPThZbzrYBKWSMPwQRPCWIsH/VUZ2G08Vqg46asT?=
 =?us-ascii?Q?qRpR+GKt5BC20bBcn0F5e/WWJo5MnEcmVDarLmRpf1pfA35FnVp5FPIteudC?=
 =?us-ascii?Q?Vl4ktv3I0jiBLcpadRG0gPzrmcLLOmUfHXtcsbtmUKVVqpCEV779cU2In/Hl?=
 =?us-ascii?Q?KTtiNswVilWYsAVJBT1j5tuH1A5EpzdIzMAvMBkAL8atFQVv8UKj/yrbfCR3?=
 =?us-ascii?Q?6CiE6GfQIZSINmkeTdyqMqn4l5tk+uBFlUXp3V3BRtsrWrm61Hk/rJ3DBRJu?=
 =?us-ascii?Q?1vM6XP4BV6pBqXHJOBYH/Pw3l0HmMtVq6Iv1qRcYI9Dh40+0e7twkfViOB0W?=
 =?us-ascii?Q?no9uXFDCDY0pAyN+gwAy5Ylg3nlkcAMGBKUoCy8ULuyBPb1kTCs9ul/mcVdD?=
 =?us-ascii?Q?G5w6iaCqjFhuP+tUd6rLGpmbfAp9AMJZABDZ4ROUJzze1fQ+1+pqGr7Y3MJ5?=
 =?us-ascii?Q?D1uVeifbHpikubSvbbCK4gFBzNjpp08E3oWtuPXwXWc/c2hNhvaVHEJehjF0?=
 =?us-ascii?Q?h2SqsSEZo3JZ4YW+pM2QA5eaMwDvur64Qx28xLHZDie8ENrY11RYTpM9CFCL?=
 =?us-ascii?Q?ljq3Cwer9fLjp8E9DfTxPHlGkKQ9VOgJD9Qh6qm+aVDbMjmw9RKTDseiDrX5?=
 =?us-ascii?Q?NDWGWcQeZDnjfs7RgOUFxoLmQh0etQlMhQm6nqELZ3je8s/gUVfxMNnbDjG1?=
 =?us-ascii?Q?1mLem50IPuyDqcRb9dx28bd6/IVt1RGCeXY0pOLXK64r7JfE/1aEyJ+/57oV?=
 =?us-ascii?Q?fwj1Amo9wj7IUBHzsmJ6ThuC+7U8yakm83ETiDKc5REL19FhF2gJ3eiByGa/?=
 =?us-ascii?Q?1aEwOos33h60XeqQZ6O+XotnEAjx7EtAC+qX2XEWyJwZvIWjyjvgd/6ti80D?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb0bb19-12e8-4326-8aa9-08de07e2b1c4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:16.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2KSPokXkcmhy7CHvlY8qLvwS1oupvVqS7lKv24IIJBZeiCJO7qdLLg9+ZwAIEN1qZsowDYr7L9c94QyPOAK1ZxGgcqDE14u6f88bZVdhw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

Limit the saved flags to the interrupt enable bit (SR_IE), since this
is the only status flag that matters for interrupt handling.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index d488b316735a..c7602250e981 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -12,7 +12,7 @@
 /* read interrupt enabled status */
 static inline unsigned long native_save_flags(void)
 {
-	return csr_read(CSR_STATUS);
+	return csr_read(CSR_STATUS) & SR_IE;
 }
 
 /* unconditionally enable interrupts */
-- 
2.43.0

