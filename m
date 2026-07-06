Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29458437872
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362590; cv=fail; b=SRuhEJzE+e8WqjcG3QKOuteI418wEL5dsiCw3pPYgbMauOZBjJCgXRVodwz2fgx5eAnwwHgY3Cq2yTtF5QRYXngx6auyAEbns4aAdlERgx350P5xSXMSzh3qiFNIONigY5azq3V9IWhHqaA4WdoC8ZkBw+mwLx016swxt4TmJY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362590; c=relaxed/simple;
	bh=Iz3YHZmRESpwmKf+WaQ+64QPVxsVOEjSZ4BqNDg2vps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9XYFYDm6tsscu4qmXKI5A+49ykGHLQVUtOCgeI84qzhVdnUyW+0tR1gFfYXRoIrIXqkMkmqrOSvr8KRatIO/SR5kTX73Zct66CGLAUQoaucCTXi8+SF+Lq2/hYHO5g7V02jhntDZgQ3BKA+vQkPxpwim2uZonDpfOyRyv1uHfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ypS/J1DX; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ypS/J1DX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwsxRxvLMgV0IDFF31EnzIn2aDwI5JLKceRoM38TpxzXYADTgBNCArXjFyLBjYxSWuo9VXsYcVWGb4uEEpQ7PgdJB8A024MIaGCeLoYASxW1hLg00wNcshvZCkisien8eg90mwW7yTLDClAQAQ8U0Ef31XRZ+JEa7MSFkEooaWxCI4ANb4A+NG4E89/sX6uP40wkst+LgeKgd+IOKQhRWoY5FJkBoI2TnYGYGoaX8CmnGmt+C1iETc6WjQe3Kzo9rigOIeUz4TIA++sLF3J4fh0GEzvCK5uatHU8PQ5WsSb7GwnUsUU/Hp5uCXRhD87v9SDgQZEvcdVUyLDFXyJ82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvydnsv/5tDZT//OVC5tn9Sajip1SyUbjNhFmU4wCIw=;
 b=aNm7HCbtpjT4+Es9AkCCrul0pWTTuFVlhl7eaqx1TqWXuFPFZXtqNuJl1/cpdOa0fMeb0ViUgoTdOUKfqax8CVo0qBVcuQhPmcfcOrbco+WMFYhNEThaqJT1ocfJQxH72je4D0zSSBJ7njomYV+UjGcz/baOWfGlUM0JA5Gm6bK1f/K8QV+ulFRySsADW+yv8qbQlzXACpgU76Hc3ZxRUz1S0Eq2PRy05OhAC5bEtVty7o5JeiG5ClOm6+e1S1T8ZmkNnuHZuCBUCbGXq3vfK+mek33+vuQ8M8df5RHkLeOso0BXGsQj8++6KYlwlv136CNEKOedxq6SPfBIJQOmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvydnsv/5tDZT//OVC5tn9Sajip1SyUbjNhFmU4wCIw=;
 b=ypS/J1DXRPKSOz6B6Ws8Q5SHLRItf99yIwLMhYs40B1KExPuv4j87XPpz9PZhfdGF4PEPJhgFZf3RCGNyChv7ZNR6ZQHc4be5akfATq4ZAcw+QQISXMo7FScQIq8iCYfHgueGxIduYgzAluVa/E3Tr0yR00xtYhSXbNygfEYbvco+6foZestkMVvVRSGdguU/vLz3OgF26NqENDeiRL5q1eP7VndgpNvFyp3U86f3X/wqwPitracwMXV0LC9Z5zTXQi+Jvy3oegUpt4yGtpYX5WI1d3r+7lTr2VA66KTvklY8Xh7vddEFgAluMHN38JEl++Ykm4f8Wk0izPD3PsKdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:40 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:40 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 09/11] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Mon,  6 Jul 2026 20:29:25 +0200
Message-ID: <20260706182927.281078-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: a625f9e8-4f3c-43f7-af03-08dedb8c8ab3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hy7NU9IP7wFREb/FC81TiUpRmpBxXXgapF4vGjUjmXK8tuK4hHCZFFF8vMmd0nLHcfSi69pt7pg1KUJ0BAklFlgwaAAq2VM+bp099TZOx2nrK3xrOOmvF7KOSQrU1z4aip/O4RkG8+x1rxe+iaoYLaBmWdXABm6RquNaV3esoZgVffWGshW6LPEEiFnLSaDdECPqy1xCLFX/feuegId3OYDLizcRNQSpG9jvhyf1ks8yWXIrXgrkuDwZtlAwE6ZeSPCuGRr9tRKiWss2KgioymDs8vj//ZAlu2bDHvbVhUtv1FZEUDMWHDM71DGsLHnk/UfardgWsle5ob1NKTdYv1r9cLVHTStwIpCtpqzgu2zcKTdOtmZgif1YrE8npVTxHnccz5HTp190BjD1PLSUaZva8GjB0v3NcoKROR9q9uItt6yn/SXxei/YskOtF/kchJJvvGpro9S6J4L1HqHEQdlsZS+vNmAjQyTPjlfrXe+bUmMiRsVSy79orc51G1Q/PFwxSXJptARXfwiOH1DjcN0gcGU+L3dG6ehvxAoiV71H4t/SfIfzz4WtEJNuPAxK/TMnkl7bYo5RaugnuFA2ZT6g13gPkhPZfIS6AGGqXAyTe8bVx2M8WRIXyOnnA1pogyzq6+EoPYlhcNot/xS6qCDvcvh0ulkZkeWQ9bk7CiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVmeevhB2va+Wgt+POKkQnQX9Wob/Z+f6CsrWSfadMItNeaKd+8dYwoKmszi?=
 =?us-ascii?Q?frxH+uE2Q44D/hLe/usXXXdqFr7LBhTUi8/nMFtstWSaFcMzrlxfxygE3Ego?=
 =?us-ascii?Q?WqELnQSv9rgK1hT77dAO73KFJSHBv8ZW1NVkzgCbaGt9mVmYGfb1QZZFpCY9?=
 =?us-ascii?Q?hZ0EAEsL7aCfMn71N6W7fOBs3RoCIeaM6biItY6fZBMNzB24IeZ3/rgqVNRL?=
 =?us-ascii?Q?o7PCgViuSu1dtCpjq62ZUMtOG9MuAx1Gelh3Ht2Jxq7eSgd5eVVyD8rIqJp2?=
 =?us-ascii?Q?1iFKIOLfsHA61LGFZ/HNKp0OLe5SYH3yZnoEyxLw2gCyhz7efGf4EbzqeXWp?=
 =?us-ascii?Q?QIxpA9TtP6rZaHKoEEIV1ZxlHIxuy69u8P9K18iyyoC0UHdPng/6FnXu5i+9?=
 =?us-ascii?Q?Szrzprs5hFREhhkKiPKPDG6gSpdH6rUBu8SP+D4bwv6ZFRJhg2O7gJffTw6K?=
 =?us-ascii?Q?ycOm8prDFOL2V6ztLkrncigX/J3k0BD8aj8/zcUD1rxX/Yn/EG4RfELhK0AO?=
 =?us-ascii?Q?1FvgQvFKy8zslRmZGH2ZqesRlaD5nO2TiseUvz199zbyuY0Css77gbVdhvK4?=
 =?us-ascii?Q?0curERRwUchRKsgNGlJ+m1HMNeXAzzc5+Ay6YxzasIZ5VvfUyEVoOVN8vnMz?=
 =?us-ascii?Q?wDtRbsavl73O36197lMa1UI4sggURActd7Y7trZxM1NTnuCF56s/Be1Zvig+?=
 =?us-ascii?Q?J0P2VM5d0FDcKc7yvqt/tw+CaZmGKpjk8/eyajfqaWlvXEWK2JsO9AzyoVhG?=
 =?us-ascii?Q?lf6IuQeEAs4i8MObqSDfwjFRH1Wbe3Ulfd2xMQxNjDr195Xk3W1dREUYC9zm?=
 =?us-ascii?Q?b6Hne0YNGLjSxuVhshauoBUGMXIJb0cThmzFtbO8r6YUiN45lEJhfA/vn18Y?=
 =?us-ascii?Q?ARsRB1hzSNXnnHImhtJ7gJH+pPjx3i4lAzbrTGh1HQgibiU0VLO3FyzZDSL+?=
 =?us-ascii?Q?loxUDQfA/6ADBF2ofKofsgUm07Fb1VgxxmtzWwofyZn7+5kPyegafeDr78iw?=
 =?us-ascii?Q?w/Oq8MjFq0u0n3GpVEgBaP0g67o7kYcc/VVBUhUAh3riG4r4UAZdsT46jkNI?=
 =?us-ascii?Q?fN30LetI/k9OGxdFZwGxAYA6eOYELVD5NRNzE91i5LL8fI1XmW+j7B0hSBIm?=
 =?us-ascii?Q?O6sNRHk/W+N7O8lBI9hBRTm43513xewG/pYP5y5+53G8/oyLZFFu1oSqoTP0?=
 =?us-ascii?Q?GUa7F4eW0wdxoZMySkGuBYiLU4TxFZuGJbgZ0OVHk/aHlX1pa/D30fFJVXSx?=
 =?us-ascii?Q?3fjmyHP86k/TmPMyEpCXfeOTtg29LYoQkOWaHkejunAccCABr10a/LuU/j2Q?=
 =?us-ascii?Q?/A+MAH0F+6cZ9mtBYHkYLmSUJasVjggLVIGzNFyjJck/KRSQbTwPdNxZtr4d?=
 =?us-ascii?Q?rUepe581OzfiSv1f/hfm3xuek59LIWWFVBrOsmuag9IhXle9rAAcom/4XKJ1?=
 =?us-ascii?Q?A5/YmADV4tBP+EGnp2GlFaO40QI5vB/XG9oKUGj36lrz7D6RtZ6r79w8kQMU?=
 =?us-ascii?Q?3Wbg9LSDCfCSSbr/VSZU42ecGC/6QeuiWErwsJNqAtjObM8RPpM58XBI+8mX?=
 =?us-ascii?Q?b6LO+MDMKuEmR4rPHZpyqAaqIKMvet0D2wV0VWjJ738wloytZSC4bn0XZ6CZ?=
 =?us-ascii?Q?VATWFs+6Ua0aPsp1IYPEmEzzLlTcv0q/Tdue7H8wrGHxvEIfAZQCM97GDXF2?=
 =?us-ascii?Q?KjTO4PVZH0CvpO5KrQcwiLWahGtEU3ej0wQAfAVkD/AZvQD9+t84PBai8N5S?=
 =?us-ascii?Q?J6ZG3j/vAeZE/l/yWlYoIOPxR0HInZq/6sic2NhGleEaVubwTu6tolZ4vHzA?=
X-MS-Exchange-AntiSpam-MessageData-1: CDTub3kbsoz973bR8+0zegEnuSiB4YRawWs=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a625f9e8-4f3c-43f7-af03-08dedb8c8ab3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:40.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBcfNS+DvhTafWB+ZakWjOmzFVmo8lczSSVcXm3nFbH+ZPpRyEXUTqpH0c11GdCA1hFqYeRCNCbo3/CaqJ8qTzKkQ9YpUq552weFhOY8tXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

