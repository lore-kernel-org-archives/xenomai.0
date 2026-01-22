Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F633D1CBA
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077415; cv=fail; b=VVO2s25W6k4dgvi5upfV0oOLY4ylb0rpqh+QsE2BxlzpYdrtzb3HQgLcFWChxAZq2GKWe4WJdIushd14F/JAsbxZK5WeqgHb3R3VxKotiAdj0hReH4ThtIR3ex6UjVwp3aTtS2DUFTVc0qDnUrnHBKsxgUWlWS+nIjRcUGkSMf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077415; c=relaxed/simple;
	bh=agqFCwPfBatNBoX9OswY0RTVd/ByTO9yaDrvYYyWReU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OboI8L0WQiLcu6KScTF1kJ92CNGRAeV4em1Jm3GVOhb2Yn7OFPKV8ZzyKjcGW1GoB4H6fNEJoeTpQPVDMkCNxviFBbF41n4gid4xA8hQv4BL+8zGf+ioe2IMY9Z34Wsd0pzSTI8yKOk8SJu9FNIrXcPn7fCw6R0NFH6m8KTCMSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lo7BetHB; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lo7BetHB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utdDZB8p6/7HOHkmkkRNSp/64+tBdg65Caga1paFqCLqQOfEcb7ZYgMmQXrFIfE0LtWvNGLgE6RuEtAjbV30+DM+QubEwSMSJC4VPVbX+QqfHXFqkI0N6tBhZnyyvOutPPg5U6KdjYlDjV4bz6OVFQBVmuh2nI4aHuU+RqdSQTJhyFqfNfh4bcBQMdskkF8Xyjg0qPVaC1z7gfltsTMt8LeeICyGlWXsdSxOPAefYQQmoNtMwtsxMV6sCn+uBC+2JiVBFN7brIbV7yTv3jBNPt71hBnAl1hcGXPZxF9mci+T5mQnnlFjnUFPS2HeWfDYq13o+CUBytV+JwbRvNH6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZJiYO74XXfP17hEEq1d2LYb4n45rQgcw1YyR+MARHw=;
 b=WAc23AMf3RgwMXsHz/pp+fQHsXtwkiEXqWkJGFoD7lXGPOsdw2NPh3+YQhp+1Y69vv9KYcwdh1VcpzB/agq9IsX4NViSQUQbwrSzF1puR1ezuw8NFxAJH9WQlKAVJcMNdAhsSbJIgOn7o+piUkg5RIQDihvDmG48YW36fmUwbu1dnK5dX3gmMB2H9izQf/E9nIFl8Cy7WaVEI2H0ljdTQp+Ploy/7nlnQj7Y8/DiQ4QSNAlwn+6bl9ccAuB1ZMLILvEDa9EVIPKSm7EY/K7qd3sgr2IYhjAhdGi45qisiX+aUiKQm0+w9U7k/76eSl3xqt92aJoXpOoLHaLpRdUdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZJiYO74XXfP17hEEq1d2LYb4n45rQgcw1YyR+MARHw=;
 b=Lo7BetHBv/AWmzbWFqf6rt3oyZvwbjzZ0HKsLcVO8OHo1FDgbRba7iIFiSpJJNxf8JduvHtVfrJk7gzrm7aJJfQL47EZfWcV21GWiPAgkunZ1z8L7R7RG0WFq/HPN4wlpLThWxj1Bm4L9Jmk15JpNJ8AoCMl0VJkUCx+UcDr6iwn/oGTCWsFbCgRJOWsJGRIWEfhJZjHfCm7i34/yisLPcpTNj9LroMH3mE++JhMZ7xqZHMdyF3q+XoUtZBgP3UDOYfPtWHYy3Q+oFc+bCjB5bq5XWfwntDq8ZOKrz4q6PA17O3s3r2KoPTgBpymJPdIFvYiU/u6usFFZhr29aGjPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:16 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:16 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 08/12] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Thu, 22 Jan 2026 11:23:00 +0100
Message-ID: <20260122102304.421957-9-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b38b997-31e0-491c-48ab-08de59a0416f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lFVUjFI05nXykTynssR9ZgPqk3RNu4wRz/oT5h+Az6vVI1/T0j4jUnJdwOzx?=
 =?us-ascii?Q?9SzCXXXbh4pTw2iNBeEDoRQ0mCBCAgsSi6urENhxF6AW8fGx7/X3Bjl9/VEV?=
 =?us-ascii?Q?yL2f6Vu14eETOW9X+vJblumeq3h4sgq1V7E3lusnYm1mFleLDctG9K4JtbzN?=
 =?us-ascii?Q?9s58eqEvzdVtLaFtp/t6r1o0ALoe1E04FTORAo7tNlUH5AadvwWawvmMSWar?=
 =?us-ascii?Q?KDHysmzxdeFmbLwskhsWUP2+tZ2CmE/NfsZOPuSKCvhH6xVMWIcw+c8wePBX?=
 =?us-ascii?Q?INlhrJC+pg6Td2igprdsaVp82WsS2x/I2wlbj7m/wQI23AGVE+A/HFE4cNaG?=
 =?us-ascii?Q?HY14ialO3EIw6ZApRb0XU3t0hEL+SMqxZVRXJfLOetvdIYpDPoDE44pDXqIN?=
 =?us-ascii?Q?2RP4CQKbs5Fr5rDFP4SCmF3K5mdvRdGnFUV68VMnn9Kac73qAFvrPA8u7dE1?=
 =?us-ascii?Q?OtHbdh2NlX41Bq13jFM1jSakEewJJ/eOQ079+THJPR0mI7NF7VPVx+kK1I8C?=
 =?us-ascii?Q?Eczaou2zrxPkaUQB1OefURh4TaHYuEStrO3hpDOi46NKuuuJomIkE+obwGN7?=
 =?us-ascii?Q?5Nv2GqAGedO3kCeFiRJGwsRQ9tb0OD0/fFpfuZN31WtB2fLQPSqVefGxVGyj?=
 =?us-ascii?Q?j9UFB0h+QOTB9wQI2Y/mMsqUhpjCxVVLvfR02eXwC3mhKuNCE3n9/W0VPwXX?=
 =?us-ascii?Q?jzXLswDgJyzVGVCdLsQPOP4zzEe9NsAC0WBBr0Ccuo6CqLMqT9RqYSL/d3am?=
 =?us-ascii?Q?OzEFxAL/GQcH2g0VuOR1gYG4stpv5Cq5t/YcfoZPPfG8i09/TgSOIrWfv7v/?=
 =?us-ascii?Q?C6QWeB6mjdCyBt2tSMQEPJxtTzU+Hy8k3Z3YRRlZ1W8AHdK/YHz8uwQ8vmsP?=
 =?us-ascii?Q?x3LBkFqJyge/6SNJ5zkDI3G3CzeBA6yyBmWCAtyaKwMytx5jmoX4OMIt51jL?=
 =?us-ascii?Q?NgOtzNPwDLpBzYSsZOj5j1lfPjavwCiws9AwjIS8tjRJ1sAFKSR+RXXpVkVU?=
 =?us-ascii?Q?hCT14UjiFq0ysmv2wiM7MCgsFrdwgQXb9vjeMtxSKD9iuUbT4VyE7PTK0T3P?=
 =?us-ascii?Q?A1cQcYwJPuIiu/FIbSl0ivDHBnQO9VW3DSQskAUSicFGyHJ0jL7V2ScqNmd5?=
 =?us-ascii?Q?ZADJ++9QyqZ17YpvTCIDBRsNq+Vf1iWJBiktG2V+t0wKJhYZXPQFpLeTVU4G?=
 =?us-ascii?Q?GRenTV7qkTopC+IPPbaUBwJNdqByA3rLuoSqhM3Cu2Z8qtPJ5lqhIRRHEYpl?=
 =?us-ascii?Q?j0ulPcGHJPMYJBdENG2GHGWo6cvzW9TRyo47pIhwUSZF9ykfaRQvAdMNO2NL?=
 =?us-ascii?Q?35My+IhVe4UQshR/jFiNMdJ5HujydpyxFTNN4An3hGId+x26Be9MH7WKuDm3?=
 =?us-ascii?Q?SMQyS4c+3hC3IPsZ+Nvk+X1gSrPvKmuycQnPvtQfipgLXpVP1fLJgsTJdRY0?=
 =?us-ascii?Q?HxuvHr+02wDldsCD/10pnTFtpPhj6RI5Ehw4mFv6AvWFOO22UZtTNSp4aZFD?=
 =?us-ascii?Q?bq0PQHzjM1YSRqKIYBnOk6xF5EU25kh4DB7DX2kpA1Di+eLfBKQPbZ+lYhJs?=
 =?us-ascii?Q?Fwvl833sQJPgydQL0yk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WEmvlMb+MxzKTa+5iJurXIFQfF6nzBx12NZ6ElGnsII7tvY6G3SqZX8kNezj?=
 =?us-ascii?Q?qkd0hORxzkADjHbqierctd5zziAw1K36zeVsDsuDWhT8TtFF5f15Sj/FXEzt?=
 =?us-ascii?Q?h28s/yUJ0P720GQOJeN43kt+zkCDTiNz5t08zkeBoc5c8lwkvhoSyjA/8q6F?=
 =?us-ascii?Q?VhDffXTvKKWsAZKpHGmSCkprMkQd7mWl847W3BrZbMqIDINMv8joxzQfXRUV?=
 =?us-ascii?Q?mIKeQ+Iv0py/cNW4W1MbX//1TG0am4GvDZIngRXKPKwjTDLAqUVuCy/09si8?=
 =?us-ascii?Q?yXkeIbMkKF6FWhg36jH9IXS8dFLCAXPXF8Q+NE6mgbmdXVsAAcTRBtnX8hVY?=
 =?us-ascii?Q?ZpfKwyqQNT1TKQ823wlVbOiclf/H2gGLkuv6LJoxKlIwVFhJW/GZCxUquSo6?=
 =?us-ascii?Q?7kwQuoq33mPrwM9FQuoBSzM9/lX3ZyV2LKsdKrBbutbw851kGA93NcNBfbYk?=
 =?us-ascii?Q?sAE/6m4gwXfHqn/aulOjAtf1Z6Uid1DwNC54s+6bKy5EIHizqvhDP4M0NOnc?=
 =?us-ascii?Q?lHvOYw28tx5E5LiVhnOnMLI7Zu3yvdfx1sb//kEd5r82hw87F6ZPOdBJtKja?=
 =?us-ascii?Q?+DTvlvIxpshWIG2vokrK0XUnwYdbWxdY5EMZa8xjqg+59S42vdW59xstMR3z?=
 =?us-ascii?Q?bhKqOQ/ZKhp9Y+O7Vg6VX/fAdJIeqNAowAynyW+3JLc6wu5c6mIxgL8c9BBH?=
 =?us-ascii?Q?2SbftXpnUvAvP7kSqnx2XuJFUTNvYcYA77ZcqARfDypfk2MOospmr03dai4U?=
 =?us-ascii?Q?uGZKW0CLYoOv2EbdBPDE2jJW8TLm9pqTBfysF7ln14U580SSONPsaCdg+DTO?=
 =?us-ascii?Q?Cd91Ov7YhJy5WV81YcI3NMaVMm5KuviQ4lTLyvclDeXZIz9KCxE2BrKiam03?=
 =?us-ascii?Q?kZddYqlfk86j6Scu+KPFs+Xx+wFw3P7hZ/Y9EXvk2wRESa43SLrCbvcmEVyx?=
 =?us-ascii?Q?EjW7Uq22tT9gBjmyPjO8Wob+cbD0kNnx54oxsGQxZjFlfMjOEMcawyUkoJPL?=
 =?us-ascii?Q?H6C2NG5yp4Jz5WBewWoRB3dXnYwOhXJKzL4iUqv+sNQ0ccyNrSFaX5uRvgG9?=
 =?us-ascii?Q?lonGGPCumQJIyexEthUK7emvF7v4rIth0UeUp+3D382kB8ptz9J5C1u01hIV?=
 =?us-ascii?Q?HkZKjXtO+dOQxehlBaSoKMndKlWjsPdHdO89sSuFooSH0z6TDraENNbwttf+?=
 =?us-ascii?Q?HClld6DjSVs1KWfZdduyAQKgt1B3+gV0ej8SKQEidkZtyWmFPSCVjgWOiouE?=
 =?us-ascii?Q?/dLEfWpWalyr+y4oB7AGD4XyVrcsOGOo9OrcWIr5DkgThkac5fq+y4xQWwNb?=
 =?us-ascii?Q?gEZ/MQuHR4gSM3QYGQTOgcqr4shfS4Ll7cLDmEREqzKhkh7FUXQ9gud2WsXM?=
 =?us-ascii?Q?NaRlRPPPxpOatXUfk4mP3oMZwHdXfjtJC/cw0D4FJJF2vuHeiJ116ls/K3bC?=
 =?us-ascii?Q?nQplgqXjvBxpIAOrTKEReacm/DP8/YuAWLFDBume9+PkB14IzbRyyZmGDrUU?=
 =?us-ascii?Q?EZD4TBYHnbf4JfF8W0+MnX5Zc51q4WwqysK2g4o3QAETAHProcL3WBWy3L58?=
 =?us-ascii?Q?tgjqRJPXknlhXmN+u+g7P5A3wnaiHJt+m7XCCMawLDHJv/75xiplgUuKsMsI?=
 =?us-ascii?Q?51ZsZQhDZ3xnHMt6OeKstCqdRpYqz1S/FmDjFMCZxtzQ9ZBrzXLVWNzpQZgE?=
 =?us-ascii?Q?a9CKpLWUIBUZ03zQa+ijaGXIOfPwVhURUbZ/fFNAzUKB9hIPis7f3Ctxr0+c?=
 =?us-ascii?Q?mPKNQYKR+/X7DPCyKK9QpmJDPj/fAuU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b38b997-31e0-491c-48ab-08de59a0416f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:16.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMl3nRmkXYtr/pzYf4kTfZDHSLAG6Uh4ccWDMfnQGYNgQTCmNmOnMKrVtMLg952IqqmSYYSjvM41Ef+9uCLOUl+HOSi4fgFVG3n9sE40OK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-sifive-plic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbd7697bc148..94c9e9936042 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -204,7 +204,8 @@ static struct irq_chip plic_edge_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip plic_chip = {
-- 
2.43.0

