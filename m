Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED213019D8
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206804; cv=fail; b=kmici1BFe5ATLUujNWMnWFihixtTYwLu6HEbgYe/ok7EBUkde9FMnq7D1D3gDNKkWC8E6EmSRcZcuvKf99s6oB64Gqybr2lEJ00xS31U6t6R3B4oo6bqGiLIGB6qiZMC9cuF5bzhmCMtLyOMmkg5TkPrevrsVEHr1P1+GtcLiWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206804; c=relaxed/simple;
	bh=OogYQMa+kEGQvR74DOx9XEtIkWr0I22EoESxxGMC058=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bwsd7KBtjcoYD+XGrduEiVmWAIkEnL8D3WNBK2vCTK02qY4cjFzDXhb70G07TELAqL6mnTjsI4fo9z6vuBH29bS0EwbimzPZcaSwmNiQk+lbE/kbQlOr2pHZKMh7TIN8tSjELH9f1N3+iOtJChdTOhvQqIX9LFDydJtwJWfuv1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PqUnfsq2; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PqUnfsq2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK74fv/T+P9m38Hj1HgFHNIlt3VpiM7dpD1gOVJLNFzZLibA3UyQgBnV6KP0veYDY035d+xZHIp6by39a9nb2a5UpTBZQgKzVKrHg33vOvaz/SpLWjkQxSa9RLFd6WKg10kzoIyWqF9eaR8WYS8Ztkq5vvsOVayM6cXvOF8RAR1xNl0jIEsfYQganjNC+wP5YMax2/nm5ujo8OxExu6iYxeTySVfK3ge3KdownUV7a/53nOviRr0XhxaXpoToJ69AhJrVQY4dQ8aJrcM/8aii9xBJ3jJ/2R6XwHhE70e296NZq4v//0yT/h/lLTDuEuTnlO3GL+V8HNbzTijXsWaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDXwJ5gb3H+8UAfeEhl67/tyPyTigDpHaewTnLz/G80=;
 b=vI1hy8e9xmWo8c8P9/eIXJsmVjZkM2gjzs9PQSQhzxlzrqPb/D1oZh22Afj5PVQCp693wcn7c/TGqrnz1MfRrTangnkhXLThqcQB3Bbo/b7qAe5Ym/++tj8Xc/Q2DBIdLjz8a0kHPo8JQdWDUo1ellM88l8XjN5uWZJnluybzr6NVAcu9z0WGX/O7STpXZSf0l5Yuu+S8HdsghNUqe7ZgXus8dsFYH392MHBjeWIk59gl/o3dk3UzrQLPfLpe0JMSAv3dzeEpfpW/4YryWd/LHVyPd838omXV+7kRHxswEvvmGBqqmv10v1K+LfJcKe9M+PRc+qhCsy49/9HJnM2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDXwJ5gb3H+8UAfeEhl67/tyPyTigDpHaewTnLz/G80=;
 b=PqUnfsq2tKl5WapzLGlhGMtbC6UMcp1tt/GyLoRDm9j3k7GNhPXzHGoYfT9JZpD3j052FVNfLDLqSLYjPgkewUjR5Y2BM1ZuJLmqX29rgRzds35pmIFMf0JTgiobXWu2pzkZ9Y7PR5OF3ol2HZAsKorf9YHfcyPaVDVFvtabTh1dv+FEmJ2LOey6vzeJwP7kJ++ov6N+M9BYJntpt0vBQVULTonlzVMKsJMM1noIX5iy5f86BfYJbLHDAyQkOSW7dQt00bTsnm+WdfyZ2x5XD908VCkKjTrtd69cClb8b6S1sBoB0NGQHQPvCxvapiSSf6ReZZ3c4NMP07kzq1tm+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:16 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:16 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 09/11] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Sun, 31 May 2026 07:53:02 +0200
Message-ID: <20260531055304.2890455-10-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: b483154b-7dd9-4ff4-0bc4-08debed8e8e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	7Z2CEiepJFV6YBRfyOjqcW/ldhlIlv9WEdUTl/R1ttq5XOS4vRPGrFb14vLGTuCty/DVpJA4tuXNyhDYkoVva/J2kP7TXKebWIUNJWHW0jKq32CCCVkISHu4kbbF5+xB+D91/KFYVzdh4JMc+UtfBSVeGin6qnb9I3gTU0A5FCI36F7Sl9ZzQFcVJTFaKwJkuJrE+iw3tq4cLl3WFPo7vYn8k18HG263OmPSx6Op+5Iz3jZHpuZ6w8yoriqBZ9i3a86JlzLgRnyHDkizMkuyadTRXj+jy/6e4D85fQefVbEEo2gKaCYSJVUM/ewalv5hcXak5gYzshvSKAdqjB32JhR2uWEiZQwzQCL6CL0DroGni8NkOkOjFOeHmvH8b3aPWez3uJ6RM38PyRJHvQKtBl5ptkOLAYnBLaL8eI6ILJt78TkTiDREjXEpNFKya5NLubuYaN8W2tXsF2q0E5YBueT9SEDXpAcLsKs7GQMz3ypSfvnunpWQVICAm1qWo9Xkj1RzkWyMuukxGgaGkHdhxG/Px0N78t50WFEhgnCdYRjaEwcTgtPd+PRrcqOuqo4Va3JpqwATDeOZKWqlSpK1Z1Fpa/tPJSREg2rAPY1kL/RxqjT7agfenUp7K3gV8l94/gfPboJE2EarTfvxEyQX/wTy99Gys5OCF2GcZdAuL8dySde2ptfWdm88nEuX+m7T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DGb8YnH5T8Bjo4kogl9YPWgq1v21J8+SEt2XH6Zs42/OSlUuAG2D+KZiyYKO?=
 =?us-ascii?Q?6E7xxEfN1GBv16+fEjl5g5/JNkW1zf49bNXppdi8eg1AWoQ+vSW44pTsox6+?=
 =?us-ascii?Q?wp7j1g6zVLI21TmFaqIWb6zz4fdTVCbzbSxrI2avAqg+gZB8QO4KOBz6JYUC?=
 =?us-ascii?Q?ibTO3v1qHuofiObjVbFZbg2EhrFtKhkqeNp2ULAtb/PBvGWu979DgbgwRemz?=
 =?us-ascii?Q?iXDOhtO/r1DtuFF2qa+ccaWKICQMv86F8CrKmDAdgzQO/Ovfsa6cgWu8qEbY?=
 =?us-ascii?Q?/cpgsXRn0ebwhDsIs/bOTihwFHC1ZkQDQS0bVYJaGjm4kC2P3BMGckO/FaMn?=
 =?us-ascii?Q?z/L2wc1OtupMnhY6uMev+/RP96iVqEbix+hWNeRsp1+jlvdUFMhBY5Q6ARSo?=
 =?us-ascii?Q?26/LkvxYjhhG5hfcO+2frnriBE5/DqTCh09knvlt7bUJDFfjVsI4/0GLnOOX?=
 =?us-ascii?Q?zlVyZG4d2WVkAOOm7ExcYYeeA0iRub1aBi3fXdhIbi12K11od+WsS9lRuBq8?=
 =?us-ascii?Q?3BUpJUrgPunZ6BFzBwFw8pLwz9wqmr/3TTgUkj3bN0M6GBgcjn8gSxCLeSHy?=
 =?us-ascii?Q?xIzxfweeFUs4CPi8nwo5uOEb1D0cVXN/1KVKJxsw7poycMsBtxGwRf6AdSk4?=
 =?us-ascii?Q?gquT8hWaQ79OAiHULDNMKLqrkaDTyo19dqe3bBs6cEY+JinB5MtGGuv1zB8V?=
 =?us-ascii?Q?c0U8J18/z8/KjwX4Li/9cLPTbujbgkfJvdzXsU10fAHBQH9JH182oM+aEucm?=
 =?us-ascii?Q?NJnU9fGGerZrjVRlY3FvuruPfPeK3fpeIpRNID7atBGvEFJRHRntUKZ4K659?=
 =?us-ascii?Q?OSmMO1+WI3k57Nw6rPFffYSSZKJ7//fB72Bf5RjZ1cnwX6fW7LjLvZm9a/KM?=
 =?us-ascii?Q?04Bvj7jiIRLv8Q4AllufACe6m+3gSJ0j8aHdBYvV+hG6Kj0gxyS+W8DrlJu2?=
 =?us-ascii?Q?okluHhglwHZBrF7JMgLvGprZ1LbhzFvb88t0cDKQLcIY1gxDn+BtPGl3xGm7?=
 =?us-ascii?Q?PIcuXSGEPOsMEArJaM3fb9xyWLJ+DZDkJWtqbi1OQmQUiEzLhgCGU3m7yUCW?=
 =?us-ascii?Q?mcysbJjwgFOi8fufsc7MDdky1qVdhSoCApbBiFeTNvHCmJgKuv9Cau6O8XbB?=
 =?us-ascii?Q?q+v6TNxWm4NISL5KupqDr3AjlMLD66WQEIavJSMq0OhSfkFfoMoh7kU+5FcS?=
 =?us-ascii?Q?x01IEHa2l36t09GTbXvBxgVG0Em+z7XbmjeMcSXuIQAd2OPdBwyAa5O1EPqY?=
 =?us-ascii?Q?9slppA7yqqdiTOO1wpz9o4ipX51X5zf2V0NSXOz0ZIU52E3D9Dm3gDKV6DEW?=
 =?us-ascii?Q?10gZKrncqQ6KcnaSWbw6/aS97Te+Jjq8vt/Wl0lDgty8nD8d4pbyWj7O3DjW?=
 =?us-ascii?Q?AkT4ZTiwWxeau7VdMPCTfRUMOSJj/fdfuy+s1HwaOdMfQixpNxqw0hWGJ78f?=
 =?us-ascii?Q?Jr1/TK2xaHxto/HOOdCaSziQeXtfFb/NXMhiDtzH09AysqF8vA/NzEFUpNdw?=
 =?us-ascii?Q?6DnozqudrTK6URT12Hf63TWiD3QfIon12naz0NyXtILfuZ7V1/JWU+5qq0QX?=
 =?us-ascii?Q?D2MkJEx+HI5ObRI/+W6H2V/cYm3g5qU2FJYFOq2iY8iuRQSpFpOCjGkwJSii?=
 =?us-ascii?Q?kQhYG6X5OSqgbVf5IY4MMSSzRZq6iy2sTfBDFM+wf/vbWWNqo5JEFBtLC/nn?=
 =?us-ascii?Q?SfTrrQVY+EFwc3/hvzRzQJCD04ncRaIcgWQb+Nk3dV9jKGlO/n+bHwd6OENU?=
 =?us-ascii?Q?7epUvKSdrW+A+AANqUo1fPvJKlvwzao=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b483154b-7dd9-4ff4-0bc4-08debed8e8e6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:16.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abMaDFEJ8xm3nhn8Aerb3UxLWwPrjTuk/HnmRWpy9qRsoOgjU8zziyCk9y2IQrkq00lVO0KfkZOOqZUUohGMbnqqz59I5ZzZ360IrNbeSaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index e44480e71ea8..88c8940fd975 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -829,7 +829,7 @@ static struct irq_chip jh7110_irq_chip = {
 	.irq_mask_ack = jh7110_irq_mask_ack,
 	.irq_unmask   = jh7110_irq_unmask,
 	.irq_set_type = jh7110_irq_set_type,
-	.flags	      = IRQCHIP_IMMUTABLE | IRQCHIP_SET_TYPE_MASKED,
+	.flags	      = IRQCHIP_IMMUTABLE | IRQCHIP_SET_TYPE_MASKED | IRQCHIP_PIPELINE_SAFE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
index 2da2d6858008..959578765cba 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
@@ -15,7 +15,7 @@ struct jh7110_pinctrl {
 	struct device *dev;
 	struct gpio_chip gc;
 	struct pinctrl_gpio_range gpios;
-	raw_spinlock_t lock;
+	hard_spinlock_t lock;
 	void __iomem *base;
 	struct pinctrl_dev *pctl;
 	/* register read/write mutex */
-- 
2.43.0

