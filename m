Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7493B9DA3
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042637; cv=fail; b=s6QxNIcobx06dPVlFXJwFdGY6mGJlC/yh8sNCcS2Mfw2l0YrCz5KnK7x7bkcUAW/7LmJpexWEzyltmGtSbwsoc0Y9aQX+9G8AyjN4mkBOOBHZmcspEr5B+d0vMJxI4yutz1EqxbEf/6uhYoNgfCrlARv4JFfuJSn0z9Tjq2A/bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042637; c=relaxed/simple;
	bh=jOCc8hdvM2RI6q+llpHBeqbf5NnJxUeI2F//liAuZ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1WxacGhdmTYRukWr7M+TVULvv/uAgoxivty/4pna4NXFbfSxcR1NYuNAkzkCqkPz9yuwc+A86hZMOTJ7Xs9FW79ZsmQNPA9EnwBldjgd+v+v8uC4jGxHxFp/tJcpS1b2bYxQ0Czf6nXLP0HultkDV0Zx9XWoejyVJ2CsZ8TP3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aj91fq2l; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aj91fq2l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+O1rq0xjp+klOtxbLRILcXmESTL6b+jEH0+HsGMXq4AL2FS0AeTu/JXbxL/judJVgXP5OGFvqFDLeytRyhZ4bRyoQeNtYjhmCWvMkD8RP54XxdnZQ97cfSkZnnNqy1PiRaKh3wFFexRrdFKwyJSDxn2IA77v/uU1vQx3FunZJp6J+1TKpmrkcgmx+zABckVqKmCyk2nyXog4ys77LD+B4Cx7CK5VqR7W0HARVUZK/YYObhLkUevY+igZzl2uJxH9oF5byw6NUQLKJnLgHqaP1YJwTJETOFYGpokjDFtSvb4QsAG9b7/hWb8dSCdmoTMlenQtP7/hfJbdFZULzmogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=kMeHo02HhwwOlgrHtC/bCQ1OLt1kzzmKzK7aj9eAnyB2rKo/LKp0QWMx1jmDi9lsNjrzFnZGYk8RZqeQpe+JGbvE1y7ShwW5Wd3W0qg28atdhHcnJM+nVP3OgCBeekPikfi0sgGI1zK/xuY0qAEk/gVeSt++DCQ69of1pNtE3M994WbXAUUmJQElQmVw4dE/lgz/GyvpDZJmz2Do9CbihRuLwl4vSd8REr0OjccTxPdCoiiROgwcUPLaN8Rn8ToAHcoobC5ijM+Qwyxnb6Jg/jKSwcNi13hdFa+pNKNhrrCurc7d1hc7wEa8N5p3QcddBl4N6OKgqUt2GpG2vA1WnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtrtFvci6WP+JWacAh3BxRjDuRdBJyVwFTRL5MNLLTQ=;
 b=aj91fq2lAtjWg3iiiTfvkisGdo8G6JXiSBjamkvw55G7g1fUmH5GoNRlQnW/1xY9T4nOV5kjm6TuXo7k+QrJErnDQlHQIIO+lzbrMT5D2XL/KarwX18vLY8DSQM4KAxjdU9MEaiwZCvSppzq1VDv5FLwbHB/T+omk9wkLYj9xSdRg/y1N55k1KMTi8Dp5iTDjvNPDHXDevYXcDaMZaxL5PbDQYLCMj4u40UE/z1TRhlhZHXsVSKvvNTDNXY7bxrDk3HAMHPs/YUzLIm73Q+5SD8eq6SDyw5rlqfcmGx8/3CXmnhDRl6xdg9GI7i/fzKXpnVErlfZ8u1XmudGX3t9Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:09 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 05/12] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Fri, 20 Mar 2026 22:36:50 +0100
Message-ID: <20260320213657.2210419-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
References: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 637cef16-d21d-483a-72e0-08de86c8d70d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	+GaVYnnxGJo3A5YCO29mOX9yw8slPqulR0laWLC6fwx8fFULf8wKpo2n7qI0N1ItINWLVb4+RdyIVJ1bevmhRBSy2iQrVajHVSv3uSnLNFotKdvgym1O8CbExiCKQIfrZrHLHU1FFtnCRkEyvi01bCvFTcCsiunCVp4S7J8c9fqGyBme+bc79grHwoLzB8nGkegNZ2AqRKWxUpKCeDJ587/M1k95nXAaN7rk+JewvJmU4V5OLJdSfcDnDQPqE2frDJuVVZXglfHtcK+jslkd8KS4CZjAEeeU3bm1IuJGXP9CNxZkbuYAilcSBgyOY6h5m/K9uOeWOnchb+5h6qALNlZ5H6NiflQbbSDd4lfvOil+PfOb/8dudOgg5pqq6WnK+kxF4P5UITqnoAMfQSvlAlvUSPe7ThuRLpN/JPeKXrbaEwObwGZzDZtcAhMhTPITQ27OOHAFuXgFKkaUQerDtXriNiues/OwDVVhbP62TTC7UVtG52nUGh4XaDwblJX2IfrcEJjjViq8s6KNK3DzHq0LwpLjXRgdTjLdxh3iHlNmJfnenWayfhwll4ioBcqNACcRSTdQTuMV1o/N3BMsGLyzUboxvcMqKKO3+NcyYZ6NeT2RfBHnqXSHpXRq3dhIY2Y6ZlHZCioY3Op7UAPtat5tN4j5xosX2Wi18hVrV3sSzWguKxmygEud+Sb7ozsQ+EzmCCxpAg2K6Ed4Y5JFqE5jwcNCX+y3bu5xz52h9FQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQPfKpewWnRNUhNbMDazhixGsClpPzZL3TdcvdgcQgM50yzfCVB/W/FXYl2l?=
 =?us-ascii?Q?+/yFrf5+6fV6CubdqX/V5CxgEnqeO7DJBdHwHEVn53oYRxKCpWoZijIczPm3?=
 =?us-ascii?Q?vgJlrAcmLLandb6HhQxFSAZgzWudaQPLyx8teOE3MyHq9vmqk2rgTBhOVqJ3?=
 =?us-ascii?Q?Lz97tUIY6lKx5iFV1EHTE1S7KrtJN+26b/vG3A35ZkUJOqdyJ3TWTT1AgdGm?=
 =?us-ascii?Q?ag1N6Fko2Dy8fFsQ1bz3DF3eIx6nMeXwlWzlMdByPOSCVBOvmCxBlLCRcVP3?=
 =?us-ascii?Q?LknNHXfdfg486eQoprPWi0tyvhBs5sUNMUiRLUGk1DsKfzUWVSWN8CXOd1jU?=
 =?us-ascii?Q?piqnLczNmL8HPyGbqxZVb87bmIpBkc1wnDDdnc2YOw13HBXUkPjzLNAcOouY?=
 =?us-ascii?Q?gtjgF/9Dh58RTcUw5rXv8lznLqkXDGom4bsRFn961F4GIr8fCK/EC3zVf91d?=
 =?us-ascii?Q?sb8P6N+1gvN6iX0sOvQzWKB2NmjDBdXV9FC/EcgdeQAeuhCSTnXI5MvcXutd?=
 =?us-ascii?Q?VHgOB+9z5e22qQYSE8IE4WeTGnkZSedCUJ37ggkObRPjPpBAsCwPT81ioARf?=
 =?us-ascii?Q?OklFk9OLI30vxxJqcG+0/jFWjmx20EiV9tN79oWewSw4GmnOGA9sKegNvbK+?=
 =?us-ascii?Q?sn9LJstCXO2VLuOcB22r0uGLH8EtzsSw0APZYLyZ96xPjYobllPM9hMme96B?=
 =?us-ascii?Q?AOJY40OSBURSGIKkx37DBABBCsyFFcpFt3JK9T9IKBA9Uicu8m6piN57+sE7?=
 =?us-ascii?Q?C/xhGajcWu5Jn0c+7V9I5893ULe7g98GNHkm+H1jGdB6OXuMw6uV9bxqBWXq?=
 =?us-ascii?Q?SsdoLPDf4OetX7P3QF0lYmzxRx8lDifATv3QV/vaomO62Sgq+2UpYmVOI7Bj?=
 =?us-ascii?Q?RDGtktt70HRIfFpj++HAkBE8711U6/h0fuXYpn/I8nNammQnsDMrRkyd0KWo?=
 =?us-ascii?Q?EMCmrPXiSZ0idgF20KNJxeXgUvq2/BwJYiR54Z29qcRmI48joVLu1KSJZfMw?=
 =?us-ascii?Q?Lvzq6QSU31nEjaTF3AxsGwF+D8aoOlgPdThm4UigNhwYwuBY8cVqP4Tl5okD?=
 =?us-ascii?Q?mT01elFN/TX4iDt3jB3+MyfnUCDNwoO5xIdWUDpxbyKxMmlkXuaa2B8bjuMr?=
 =?us-ascii?Q?m71LL14ZRuPJOOy2xgA5yyXNd6pA1eb7DGQn/zG991Xbe4KlmFjQadPk4zkT?=
 =?us-ascii?Q?taxYFsO1Dsc8cwd2bny7oNpyjLU3fHm4/+3UNCb2axcu363gs1cQviIl9QEP?=
 =?us-ascii?Q?HBYrhPxR18QE+NwdirbMhmYQsz+e3dMQ6peMGkYiHHFvteQbQSNLlUyStJzP?=
 =?us-ascii?Q?NSiQeFE3yvXVYrysuWLlwHC+y8/NrWrKZa1FEHPRtMLj/TCyTu7MuPNTSmzG?=
 =?us-ascii?Q?HziXXf1gtGCWD/3pbtpXLOUOg1ZEZqm15J0jBuRYsJ2S11ToB9VqrR3hwJ1U?=
 =?us-ascii?Q?3w73aIgOVr+4h7xJ3OC6TKAnkmOXzd6pW8zzxuZhPeiKZYCF6OO81QC2k/Yl?=
 =?us-ascii?Q?Z82tqG1+K1ohyLGihbCKxJ+4Cnq2rt93OF42IYzxk+qC787wLNimElKUFAf8?=
 =?us-ascii?Q?lWvO2fLQ7lGB/Ev1jphSKs9pxY2AeaBhP1GZqzCNoUMXU9c+LBvafhzhfm5M?=
 =?us-ascii?Q?yXNidsQK3uj2K1ZEHlGQhD5sXz1/UpMJ4CoUTGSsoGmVKVu3qqrJOGbwoCgN?=
 =?us-ascii?Q?byhpskF8zqeeNx2uIBEkxRxH0rMUDoByz3vYekz6DmRYkj0reNkgW2zG0In/?=
 =?us-ascii?Q?6ukpdUpSQWj/YHYYGCSAazE9CletDLI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637cef16-d21d-483a-72e0-08de86c8d70d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:09.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0z+xDKk0RtCFbaR1w/MbxxS/ugn5ppZ6Ff7LiYtuxCgD/XtIX8VYuNnFegS8GJzUJKm4NyVIgdJrMmSJNRP27gY+0lDCu8nVmH7g/LPCX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

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

