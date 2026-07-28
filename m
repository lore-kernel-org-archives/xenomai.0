Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDD423EB2
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237164; cv=fail; b=BSR6EKdP2F6+AZ/oTbJSgNm7JrOO8o2P7R+dK3Teiuc2q1UIye6Vv5QO971uIoHHSPUQ2kcP64C9csrQ7C4kBMG+WFDMg1cieq3V2e5BOaYn9T72geRNO2KlzsY4DGr+csH3koOujfBZxo0RApd4YcSzdUFx5o76YL2x3iuFz10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237164; c=relaxed/simple;
	bh=OogYQMa+kEGQvR74DOx9XEtIkWr0I22EoESxxGMC058=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppccCQ3Irv5SjwK/wEPwAZAB9mn7g6pXKr7Hc5OfqsJ1+jqkfhoxmEpwvBZJ0VoMddbD5ospcZZU9Di8+8AUWEuy17y+lbep+6Rxf9sjswWMlaT1JPip5fR2stCPHhi0M0G9Tsop5iMrpPxMyTJGHQq4bS85MHPe5Wn0AcQQbS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N1eif8GZ; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N1eif8GZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiChX/XC6v6hfF6ZdU7ti7bshAfy3NmMHN9Y9YKVNBdD8t2nveZZCY/mGDvbra2bu7quZVaBmdeN1X2146RnBVePYA4U0GjObQ24gzc0Uy2XNbNkSI7kbPAJAgZK9DoOof21H4CeUKdIrCxPTuT/uuSQWunEN1NptX4Y3d/Q6RuiNm6XzhAhftDhiMSwk1vuOMwEVsGNnnCMJvgw7GJDgow/rrFdF5VnnQxH47hEKFxE71hkTVk5kriGjRhJ9rNi6uvKCQ9rXZgP3ss76t8lPiaUg7EQc2EAFR7UCwQgvP+VGHVRfqaXo7qB/bnMnx90vX6mz3PQbPnKImSfyUapPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDXwJ5gb3H+8UAfeEhl67/tyPyTigDpHaewTnLz/G80=;
 b=BtQO5v2o9ssSkHDsvzCdsf7K3JEQ4cgAX+g4KN7BT8k1Ms7Cyp5c01qIVcabMdKNQcScEBuZ9EijBCuhm4waqxDWB6AnafSLLfbpiL0zhmPtgNNW3/2geBP+KPmW5nSUloi7TZy5Ryj0MR1zuXl1NvdiiPUPdS/YycUJjTkgDpUaocqFcUbv2nsp/KhUFb0FCKlrwiJg/iPV3h8MYPPJJfLQgLTpgkC0OKXvAIE/MLczu60BSaWHPWbWTP+v8vxcyqcjDIcj9Y/iAlMEwuTLAP0OcW8+IMpFkTROgImBEjHSYqNd3ztn7EefoOZiCrQkdCcS9ElZGYgSnLkZLtvGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDXwJ5gb3H+8UAfeEhl67/tyPyTigDpHaewTnLz/G80=;
 b=N1eif8GZuHKiMF1Wp9jlwcoBwENioAXQJEmnicp/fYJGxailvXcrzEDeLRWNqBASCnkboKrWCNm6P1CnuzW2/JjQORcnctuLe+bcliv+dGRIZQBhOjOlmOepWYuZqOIdzWBx3cc4cSh7VgmffdgvWkENjfs4GG120JOAunwh9BjGCx7NphEHFZPGspe0C9T1b2ClcNlY1R5b0HwuK/8zU2esLC5xom+/Rp8FadX3MT43B1QitQ3+PRDyqMMpUeslIW78usXR3Z8kFnzO98x7uf4mKknC/i7A/Jf0uGFzbu+B0nAdyMRZ6KGkvA7Nj2kEJmJQd4KosGIRd2mwkg5Iww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:12:34 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:33 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 09/11] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Tue, 28 Jul 2026 13:12:20 +0200
Message-ID: <20260728111222.2699158-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
References: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a44926-4397-41b9-8389-08deec991f9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZOcT0bembqgH6gN0sMV0bKjxSedCgW4b1oAdH5gooRMvYZNgXXeeW5ksEG1qf7SABWo059NFmvCyh4M9UeXmWbEJsL4WasjWfpXlca2ZLZaCzigVD/mMfF4cHeFsjALg4+TEcm+ivX2d0Mu2dHl69Ge/Er+nyHC0h9hu3KQ0gQUoUbHphCOQ+BGl7mwf4C1QpPf2AgLDIa1v1LPCVJhLlu9buaogBxZ2b5rUMJKqgLzIllGvR0oVCyULu9KQo5wP4uYqPj+b/LGnY/iePcz3xeJB0R5xZkRe8eMRHhor7lyNk/ZH9c5f8yBJrdqVlF//y9wehSI47YJRYE+xTM1poNMhb8S6nLjeS1/nVVH/AG1w1htNFVWaqSzFCo8uW/kx2ZA1bb/0PcgiQNVAPukGuhU9UbY28BgeE+9SIguWM66dkQEx7nQDICpaUFGUvZLNfmG1hwbMqKN83gL7M7ml+fPaJS8enSPmHDp8muU7iY4uR5qVd8xAsQclFB1y3U1FBu7vIA83m1sGDvxJwVxi4tejLzeStqbtQomlUnSURIW8cr4c2oAMkDPERT8GwlMW0A1TiY919xtpLz4F6F4SKVbnWKU6pHi8MY89XCTkWb4j91hbtOuY1jVK6V9llolMu1qJgvzNVTbHZTx4W3jU/HLUw8H9seRkn11+DwNuPJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkO+n9v+xaTSb9yQRRsQ46RcPu51bOkm1Oiseg6ROhCQzJlRGDjhVFso7fK/?=
 =?us-ascii?Q?M2ZK8jrudIikNJq8wfuDazNfkCKIV6sUJZIIzQ9/b3q5bYwbfsrH4DV07eWH?=
 =?us-ascii?Q?Y+cxgce9ykzKSTc3fp66HMW2PK9ZEBMF9m9XP6gmqYZ56lvTgAPlwU9cgtC6?=
 =?us-ascii?Q?Utfg46ts/4+L75yf+9bgCPc3BA6wFUEIdV4pLPoqo3SA0ITI+PEZ1zUvLPpg?=
 =?us-ascii?Q?Qa0KEe0gkJjZRSweyQSbm3vIAVy41tHjOEEwFC4FylThW0G5aaxTsw3Jl7mx?=
 =?us-ascii?Q?tuxohnErQASW12A41kN+LLMbzB0ZQlTS5v1n2v6UiyX/Cr86g4gAq/OF3DHH?=
 =?us-ascii?Q?aM3mFvTmZAFPRg8DWWzjLYsYqf21tCcMTkEsUDAEb5p4czj7vwYHcP/7GESy?=
 =?us-ascii?Q?r+WKtxjASWHQY4e3jNrF4Gu5W/OSXF8LhwbvPyagaNPuJqBiSHSEHQajOl94?=
 =?us-ascii?Q?/ZXc0J3IFDeMZ6cH26TiIG+xePNlzWVUzNScLCsTpLtKj4pK9gfwrqrIW5Rv?=
 =?us-ascii?Q?qB2waQX3B/glHJX8mimGsKNP7/xQOjAxNHm5ukSTuuJ0bGiOs+ZC/6jQZDYZ?=
 =?us-ascii?Q?xLvLrwAwPid5VDhBxmjnBuwFY8BSSZrBNyZtVgIvW6+C08XQVL0keegWt3nY?=
 =?us-ascii?Q?F4WeNwFF2T9WPjbozpy6HL+JwgwxD/xZLqu/nPg1F4aZ3iFKgZ7isw49iGpf?=
 =?us-ascii?Q?67z/YtL/7KZacZi9TCMkm2e8M1Z/wxVWilPjtWPWO/3Jp2ZyBfcz9QfABEcY?=
 =?us-ascii?Q?AHxBms1ETk5VXye+M00fEPmbKvDWeOFDgco52I1T0yxRyfXXrvqwQnX+7B11?=
 =?us-ascii?Q?SfJJAaYw6G2u86vu41j2X5dX0elXz7CbbY8FXCZ/tIdqC7wvyJwFiYDubYs0?=
 =?us-ascii?Q?sgqjDJKtP5YrHzV6ELVpjmOcRKZ8G9fR/P3vuNpHQ8D322WyAFeFLpWQJwnp?=
 =?us-ascii?Q?fzjaMEIQQQfctYlzoOlalEUvKmV9eBB1fJPWKMMa62dY6DVonIy8KPJovIjg?=
 =?us-ascii?Q?M1lbiu3ni1N5Pm5LIGGD2LEp27iTxwtgT9Sns0R/UJumA0N0UXOrlJuTkE5x?=
 =?us-ascii?Q?rwN7uhK9tl6/QoaLExM3t+J7aEzsWoPZdl34HxLhwoT49vUFBHVM7bZ9mw7a?=
 =?us-ascii?Q?mSwib6tri2sjGvUDc/v/xtt8XxsB975d5Qz8vkImXwOTVekRccNbx7N+xR8I?=
 =?us-ascii?Q?hdFZvKgkwd5UsflIh0/MFTngau4UlAkG3L2Zu48GizmeLG/ydKpR20BqyqMA?=
 =?us-ascii?Q?0gxh4+1QN55CgZsw88uBI/MsgPyB/E+61ok7Z0L30ZwPKhs2kevRvYRp+6hz?=
 =?us-ascii?Q?LVqbaSuKnNzOgAibQCjoGzfQx2OO6K7U9Nfxdx8/S1K+EGkHWQsXUzXdiB4f?=
 =?us-ascii?Q?RMCaTtHJ0XgxtlJmFJ21ZBdD6y8kMWZR2kRVIFh1WNOcBhynoo05IYHPs221?=
 =?us-ascii?Q?LPZZTPDv0x7ilnhJPyGbbgpI09GC4Jl2KiFkui7bGlYi0nPoErPThzaZzuND?=
 =?us-ascii?Q?R2+ljDSLWZBlc2LmEWHA7OPPcD5a2A1bfBegxWzx2d1GeUjqY4yc5ORGo3XZ?=
 =?us-ascii?Q?oizxMHtY87WwRgjCQJ8jrDZMK3aaVrx19k9GshxIl1f1prfwdTCQIH2QncH3?=
 =?us-ascii?Q?wxO7CNTzS1yE/0A2OoQhyqyqx07M6XFSYMKYbAFFPgfCZJfWEMHg/OQUPShH?=
 =?us-ascii?Q?UA7m+EfeEMunUlu2Fjl90a4tN1v5PuZn6kNZTMaC25Fc99VQaZSJGioBT26J?=
 =?us-ascii?Q?adCKSm8VW5hx1fKbKeclNFzqxAWd9ug=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a44926-4397-41b9-8389-08deec991f9b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:33.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU5/Bcc41z4+lRSwZ8DZkioyyCgeJ2IOPbUKA8g3YU0qlLLvuRPijtQPoFlDID/r1eq6bBOud2kIixa2pA0BAjHeTR/2KiY26icXfKIjDXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

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

