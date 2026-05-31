Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD9306767
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206801; cv=fail; b=jIlALROFOH8W3Q6eloUEB09fB+3eSiULxdKmHQq1hpq/vSOMOEVpllOmUuYiFg9q0Ga7LxTKXyTI+8eq9kg/ovr2rpEbqtTeWjl1Lc39MaEtQ9MKjLL8jEDrKwM62OOWr/SPZoNPvsoAFRyAENwSrtWT1VFcpsAtPk0cBKyI4hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206801; c=relaxed/simple;
	bh=jOCc8hdvM2RI6q+llpHBeqbf5NnJxUeI2F//liAuZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fb3mWIBGRn/C5NKyKs1UG/enbk7cOvIOJFyQrkcvnKuj0VRPYb1r7/FeKdKA8/U57kfL3Ys26eSk8ualDvd4Cgmi4ZAU0MhJvkKzkBW5ZDJuQmguVQrPH9UGy27CRhkHnQZkGZScO/tVDLZqf42eBd8NUXOA7U43TWIpDtML8OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=go+JWOUu; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="go+JWOUu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhO/idv/Uh1Sv1Kv1IpQSzO5jEJBZcIRVKvQBtzTpxF5gatYT62vt5eprBy+eic1EqJX8g6sY/eSFoV/dl79A5V88LnEbmIZ5oFryCJNk7e3011t32EUfUuBYzWBw2EiyJc/lmLRptshOEnp4WzyF8yBG3AJMY3a977Ol3pd/o45FLoAKwlZqVjxC4XH2wR4DaJcwZIYv6dMnIYH5C3Tx9ccZ9l2I35WdknQ0S9s8PuXjRaZ8csy6ofMYY4T+7WDtMnFdvuQiOcGcxIw9H7S/HkZHYKulzh2DP1S4vFQhmdQHlvYBBlJFXNgXRtLnP/kaVu7SEfCLBCSUYIIB7dTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=eqDCsI0APtfZ2f4b35taWvgARjnKZulRVJPXiM0eT5cFDiZJcqR4dxTEoCDKPC0XQaTpVD6zF+Ys3pvjLKmSLAlWgNQCdd9wUr2ASvsTrbu0POhoyTsl0GuWjVGjJOPWzzEDzNPFpG2Eppvirv+rMGK0EApBtTu8hogO1UwtJMxZacB6GHWyPOXKnFVPAOfOX8ZNIlp1GaewPAitKGpRvdl6ImplVybxnnlNozTahyoohXb82PTwoUNZhsKzl3AWJOw/8ypPlXXUWhM5+fK0ntfTzNq6u/u2p2wM4xdDIBHQTs6gWj1kO3PNBUap8Xw9iYBo5/f+zxi0DmRb6Be/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=go+JWOUuSfDqQr2yLqpMCXvJ3Dc9N03HyFnlaFbrlnq1+g1IvE9u/Xe32UfpVZZST9iyDYTyK4f7YIDhWwsF+7H2jhCOPQBtZQWuskj1k0tY3h3UAkYAtVESMK30jhkJ0VZCoFjWxI6y9Z0LDpEavbIeHbReP8dVSQkOUu/EzbxSi7VUOKX6Qp+0KZzGQc3QOXc6qD9lmtqxOKrfL3F/JRdVCTnYJOBBk/yPxhSQ8UF8G2Q2poHmFpaA0fcIy4q+MjgASDFWy/BKIAEb2tr4toc8DTdRQESQKmhZw7/d87Lfe21a2xJ8LPH0v8vwyWCYMzuDk4/BVPT7XFcHTmEREA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 04/11] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Sun, 31 May 2026 07:52:57 +0200
Message-ID: <20260531055304.2890455-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: a2538806-e1e1-447f-f4a8-08debed8e799
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	YSm2blPScFdmjO/kKLL1WaBr9UmNNwCI4GOabttbou3TMuGU2vYerJxtFWFfbzxh4HLHJRq90vnd3ODP/erBdnAC8j8etc6K8a8XCD25A6m+Qf8Efqnezjqd6Nag4xbLG6RFrvgyaLLtj4WU8rwfWK0p+3x7VoR2JGktDeqz0j1DWYHAKQSEp+DsvhYlX25TwGpqprYbNF4/mBMSppUHwx9FQUwfDMKz0bJA0cAVuVuLDWEgSIkVdrn0ewh3Awx39klr40IJSOi/FCSfpjgg9/pRW+i3bZFRzVE8GH5kC3g+jxSiLJJEiVTqp+lI4RnyV80GNgmZjL6G6+JxmGbCNrqjMdVK8XOr1AzdhYTv1kevZRn/nb/V9Df7FzwBT8V955LJjhCPM2r8QP5Bw1ZsU3YHNnP2yq3z15F5KS3YTHbqa6FrvY5SvOvAHuLzbmsdONErZQCZF809gjwBAANhn1UcCSWvDkAd2yAGvGhD8jvzN4Ib8xdnkgANsNLSkYNiNadDWm7TRQ3+pQWZPoweAuasxQE5VDm+LsVAa6+TO3spL8v52LerWJ6foid1yo8Gzivbidi6057sYanpPIEHufWYPRxamuO63yrb1d60ySioCfFX9n6qnqZ+1d+ukul91nOQYV2Ftbm9pGTS7epBIQHDPlcFWXTDO6L5wtOZbiAGZdi+l6HF8bZx7dbDTj+a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4twl4034elE0mnDP5Dr7OiirlKp8rrMB8u4zAdl1pS+3E5IkLBZCVi1R+knt?=
 =?us-ascii?Q?bk0cdTrbOGkDfB4N4E63iBtY3w/qZTK+cwQT5+qY1zqrv46be/bFM5LE6Kg+?=
 =?us-ascii?Q?7/2MlmqWnrrU+ftgmGY1gwFbxOw0yhpzYSDVrHrLodH5+1tRX5McPEaRpLIR?=
 =?us-ascii?Q?poeyJw5nszAUSYqOUTPqcS4RsKBp7NLNd2c3Qd3w76K/E/EOhystCDzSz0W4?=
 =?us-ascii?Q?eEHAje89lJioo7J0EtDgAA1JXXzYo+CV34m33o1ge5zQCg/4qj6GiPfAl0sS?=
 =?us-ascii?Q?wpxcEuK/pzZ0epNLRu7vjsZlQ+pKkx8eS61gISXK9C1M6K6tBpejffVR73Gk?=
 =?us-ascii?Q?SzRqdl5XtVMBgvSIwt0YoxOtJ7cWutxIJmFuilrOtAEm55esqFz4QF5HKSXb?=
 =?us-ascii?Q?GG18mcDjJbrFeFZ1TmZtApsA7ig+3wnYTmVG+Bte+/RASRk3UL6UIwTbohGA?=
 =?us-ascii?Q?Fu4YItrvAja3T08UmujntykUkBqr/g0Oa3JkW08zLzimIdecRz7Nr7cyk9FA?=
 =?us-ascii?Q?y7scNdeY0WEizA2gPwCu9ZiDmnPUgqrbuh4YkvdlavJnaKMhICbcc+w6Ukxo?=
 =?us-ascii?Q?+l/lNL8D281XjvTR5X7KqSOeZQqo3RuG5ZALSm9nvHIRG7AgTuslLmibl6Lk?=
 =?us-ascii?Q?CMIPj4Ftdt5GRnmK/VyFjO6Iux2IU1TrHddvWVIYMn7Zn0PHXF6L/5CHvWxK?=
 =?us-ascii?Q?Xh5EzIBSZ0MMznU4iI3XGJqZnnFbLwK73cnW4ZFObPZgIKk7wl/pjQ3ZooB5?=
 =?us-ascii?Q?LYw9+Or4QCLfW8B0jMKVvY0dtZRSY6ii8DP3TlTJvC35lwNdKE2GG7oUPSd4?=
 =?us-ascii?Q?MWygX0hz8w/PQTzT0mxWCl8yVXEFAKz5GkpL/7uGuh/wO5Vl1k47LopdDbmW?=
 =?us-ascii?Q?xaf+3R2ZJgljazYrSXSzYngoRxB496LNBeEUjhHzNPaO/M9fGDdVcWJ70gJE?=
 =?us-ascii?Q?ntpOT0TQrvt2BOoz6QlGU/skbl/a6iKDVY2JwN87u01eMw02y7SG4O11Rpld?=
 =?us-ascii?Q?7yBLDLaYaZYy17vyAlHbVQv1dbJc6cn7b99wlY1Zw4VCHc8ZiGFc6nMMc72v?=
 =?us-ascii?Q?Lr07zDy1Ry847IRL9jEDnAWtVSDCdq70IUBFzBto+SaIQ1XWuTzSTarVH73e?=
 =?us-ascii?Q?ZE0CuQqR4PfYz1odhY1vCVEXaRM0w2CFH0TQOBeNyQ0QGFKUUwRKi7naz00L?=
 =?us-ascii?Q?aqXm8CSM9JCZxynibeERyNMelb41L0NCRmSeDbWPHCU4ygWoK5vHEc0zoRjQ?=
 =?us-ascii?Q?DQxEpZNn2rTVf8CLAUsiYWhTi3tXOHCF+XGDfUIdW23RV3aoiZ4XkUmzh/cv?=
 =?us-ascii?Q?zl8HlEq8NTpKm6PLz34kkEIOx/ZpNf7PTt8W3ht8MJtj0BG2xTYESPRWmrCn?=
 =?us-ascii?Q?9xqBYJ544o1GIeQqzZeo4LY/iKF4JNXehbup7nFXp1t5IQdVIfdqnaYnu921?=
 =?us-ascii?Q?Z+UpBRAxRxbUyxMELfqt807y7w3/P5MfVg4jyWfG1F7NLgv7GKVcsW7Eq1UP?=
 =?us-ascii?Q?jsWa7W4S1PBBuHEeDAcaV1FWQpuhqwiZnyNMkVfPpikHPmqOILBe1+ONb3pz?=
 =?us-ascii?Q?lVH1AWb9FaimQ2Y7anPIoDqumnWF5NxYwJBcRKrTvaOl4exvkQnKFN4V5VQ5?=
 =?us-ascii?Q?or4sqhlw+WFJLY03cI/Gqeld+BKtc8kjl+UeglEJzK9NbcaN4EB8vpvDFnwM?=
 =?us-ascii?Q?lyoiT/jRvL76JKzHJLeOeFtSa7Dv6MpErsmhvb/RITEFE/kgQlLLn7ff4jQz?=
 =?us-ascii?Q?W3o4ho9eiDJdHpH/BofzOEuG2X6VDTY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2538806-e1e1-447f-f4a8-08debed8e799
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:14.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u31Lsvx5cCq4WqDuXAXtzosjzJp+I1VYWFiZpmhLtJwgiEhnl3SL3HffykgkAWBUz2cn9chvnyfrFKS66D6jhckMa55O7eOcuv7Jj4df06E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609f..25de8929ea37 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -156,7 +156,8 @@ static const struct msi_domain_template aplic_msi_template = {
 		.irq_write_msi_msg	= aplic_msi_write_msg,
 		.flags			= IRQCHIP_SET_TYPE_MASKED |
 					  IRQCHIP_SKIP_SET_WAKE |
-					  IRQCHIP_MASK_ON_SUSPEND,
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 	},
 
 	.ops = {
-- 
2.43.0

