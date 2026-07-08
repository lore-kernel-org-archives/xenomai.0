Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445663BBA0D
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492092; cv=fail; b=okU2DdTauqhOi9L+2XUvHwh1I+hirZCe8sEaBtOuf9ymmIPqFmTXfUsTzrckfHUnRfHUtY4Y06pcn2WfTTRa/RUHtJsC8TyGo2bMmH94F3ZavvUJsO7XCqOlPDKiapXP0uuo89ece1tDCdpoWqgxQ0IGeLwa5GuJUQX6RVaYTIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492092; c=relaxed/simple;
	bh=Iz3YHZmRESpwmKf+WaQ+64QPVxsVOEjSZ4BqNDg2vps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IkrOomn2JpktxWZSAhhFtATkzoph1z0zG0ql7YfsGHdjjC6KCiG0/xiuolSPn+3Mgs6I6EzOcisipwQiANmmlMiPzgGCwASrTK3tAiKXFfdtHfK4Xv1V8xVOOYX2eybi6Q/4CyZ6N8ZYXkjFpi3C8tK+3R/KbBcChwdMcEgWLSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w7VoIgo9; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w7VoIgo9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKUm3OI9Gp8Od8W69TDjgPjgujfPW6fyiGLuNiRXz2vCcDo2JQuW7CCfKrzdBskm5h65XCyqtU9vFJxCC5vAPYTm3cq51xaJcag3hZrXI67l3FI/4b/sHblfUDBUC53sdjsJBcOxt3lv6/i9PMJl5Y5rfhKQ86jjh7oko13RchDGdfpr1E21/wESn77wMqqEYTdhVxpH7D9KE3dKGSm+KFPbEqYarbkylVJigDUlTqvqynMsIhnTk/hNwfOIm/30KdL4uDRit5SD6s+eVsLCzjx3cuHtWCQN9C0zh+Zpj+yJu+qSjsa3wSuzbbiFcPm8gWNT84Alc23gBGuZNOKCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvydnsv/5tDZT//OVC5tn9Sajip1SyUbjNhFmU4wCIw=;
 b=qmmzY3B/P4iuiKK3sWDL6QLFhudo7bR+2qlPaHhUlbVof2wE4gkwRFnz7Z931NU92IL6hwxd2Rn8aJotQJNTlwRkG8jYOhUlS13kq/y004FI24OUmVUzx7T2wAweyc67MepLj5QTgh/E0u7AcPq8BO1ntztq+ICbaQKcA03vx52OBsn7DZe0TpSDSl7eS+jQNdAiZZvI4b6Uie1lbZn4Ee/YohKLOgJovz4jkeBbsxtcNlJ5ILvvNgkEmB/9jvs+ZQayqUJBpJB8DzCnK6/AjgR5BtAs0hSdtU2xzJ/4CsWlFUdTZDYnp365WCqPOyvOMSyQnAIc+GkwoRcdkGf1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvydnsv/5tDZT//OVC5tn9Sajip1SyUbjNhFmU4wCIw=;
 b=w7VoIgo9hu4jtZv5SOZyul0gfmaFKVC+i+3gLaqhifwIO9azRbkCCeVaqzUDR78y8KxuytmKtolM+yKlgr8KYB+eYoA0WEb6etEjZ1i98/WEU53Muj/60rP3Hp+IlfthaEYckxL8G7u7Ui4edDcPkkxlpeVcB3FTgHk1PTNs0D54Tsq25nA+WLxUo/s/WbkHTeYjXPj3bNy3eSTFtHjrg5lkrmtZLTgGCmVIT+LWiVWYWBaxjG3Ne2pWd5VnbPzuWK6qmYkCvS1kEhjMAxLb11olq1WNnYvIaH8+wnP0iBM7Ix2H31lWVHR2z0nni8NB3jPQngOUdDKOui8Zly8QGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:28:00 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:28:00 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 09/11] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Wed,  8 Jul 2026 08:27:46 +0200
Message-ID: <20260708062748.1029852-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 5832d50a-0189-4a41-1f5d-08dedcba0e89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	2jRqjsV8dwI1L+IF4AtDDoOYq62PBjXRYMafdVvK1WXJvK7GB6vuTrVIT2CPLeEQ9byjwb9OmlZXz+oWziRdvRIaivtn7TEzHpoN+TEPP0JjHYOb7WKrYafiXBstpdr9jFdCu0mZafeVFz01iIiLqiUlM53pSK9nchcuDfCxp9vWIKdrJeim87uXZboJ8bnt8xNQWTeDKZpDGNB9dJCz5nZaRxDHnvJgvc8+0C6ggLQmhtlrTxYxdfirQrqJFHn9tXIR4t4MFOqZhieEAlg1tCmNtozRVPB+AwoLiMXFVRv5xr5ZayU24uMRtPRwlK6ibeu+NKOJF0U6jPxhCPCckx7AnAWRfKK6Fy4jyvVn2QxJXxZTCI58bU2LC1Afvq1u0I48hnqlg+G+EU14lbKL6JsnGMnDDCGJny76QdMSGwbUEF0zgmuutO8dOB8NT/1ultOB0jjsRSWa0k/Bv/zeR3qv7v/6SgDb5ZwnraVlb8YD2bwzJ8vVfsXyB+m6TOVYKumND3E/N2gXbpU3QDUaJf11Npwc7Wi7nuKn89UYRXT2jB9Ajo3irAOXv25oSjULM8e/c7eQ5Khjy+aWxy+9aF5nIjvgEpljNN7d8fqJ4P7AQExy30y2pvfOfhAvi29Ebkogbkwv6XfvRrORbRTyd4vUfmbgimPhqwM6+5SRFcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLjFbZztSzcfxgHe7wRc385ewr6HjA2FCV5PncshGRo1BxBvXYbE0wR9By4R?=
 =?us-ascii?Q?vPYg2TDBbwPpr8v3r0ZB65wd8FubCFL4EXpS0c8Ok2s1sF67KKIBc2PCgd37?=
 =?us-ascii?Q?583biZWLUHabfPhkd+VbsHkkH17yazsZUSGirrrySD7gs6t4OIMEfhcXGGOU?=
 =?us-ascii?Q?/DAI2y6GVZYwW2D+uVJVvobH2k79j9V/YmHRJ0owYD+DvCTRQYVg45BP6PUD?=
 =?us-ascii?Q?SjTjRtJxXGC1HzStbKPggEjg2C88+AwN99GYJRUHBQ7bACi7Zl2WeueDA9rI?=
 =?us-ascii?Q?xnmp6mLuUqyo0NxXz2cTqXG4m8EHUg03LJqE0Vl+pG0SSpBAWyy1b49QexXt?=
 =?us-ascii?Q?Lr5gtG6H+DXCJDUH/vEq/Gfot8t9X0WkwB4T8K0t2YkVNwxthQ0+GSCqgQ/c?=
 =?us-ascii?Q?2hiJ7nras038yduLTx+WOPvBr6l01/P3PyyeIsPuEuOrpFF3FUjxzvrKSEBQ?=
 =?us-ascii?Q?FiPRWx7c5YjvrYdXeE7U0N1LwdLgUdoOJTWfwG94/EsBEVRIM+ar/vI4VQU3?=
 =?us-ascii?Q?/kT/yXaOK4iz81v3jSHXkLKeiIUwbd1llkHk5ebTpEfLYI9OCztdwMjQJd8v?=
 =?us-ascii?Q?k7WF4o4JOT7cV1k0bOi4daULx2V0SgjU6JFN/Q+TmWkgpYN08LOOesQqhiHk?=
 =?us-ascii?Q?mM7H5ysHGWXNoncrWqkYMEA87GQ/3U6hoeB7/yIcwpSr2Opha4iZzuiqzCiY?=
 =?us-ascii?Q?ZhHK14z7TImwlQkf1h16yAW7wahgBdpLdy4Pb4tpv8pRrtnNLPWHaxlKAF4C?=
 =?us-ascii?Q?0l1/wB7HwiUbJoHLeJHHI7rRYNGLxGoFQF4rBYGQWIv/qTrfYGYPL0CE0XQ9?=
 =?us-ascii?Q?8IGQbWNnn91lFegVTWgrA9RKYwC8QLeHE41tKLT2tPrq8w/cToES0qnCJ9aY?=
 =?us-ascii?Q?3DBWU/hFSSCSGx5fXtM5jdR6ZnSriCNvrG53xHaJ3iTdNgiUZ2yPHbznG0Ru?=
 =?us-ascii?Q?NjO7cdkDorgMXehsmvtIuzupkN87Q8A3EwuvYwVZ+CZkYylDoTrPGHybgwDl?=
 =?us-ascii?Q?OZ7cBzwdKtKVRHvQNG14oxkulXs2Mbg7aZSXLtFbeubz0oReTmt3gd1xe/P4?=
 =?us-ascii?Q?klX4EYzv1WRCFfq2dA9ALopmXSVD03O0Wvm9FkXCxGg2s7NROkv+MDYykhYZ?=
 =?us-ascii?Q?tYlbNia49VKy8RPtZJBiwS7W5OADadTXwiSS5j5FW3i0u+U+LUzi3go+PTuR?=
 =?us-ascii?Q?H5CWpBoIG3+HP3Z+jHBtRSDO/MYGMWZnpWqvJHvSshyxVr+ItYT8xds6ZraL?=
 =?us-ascii?Q?2XJYmni+5B1r3SAWoSWWBt6ER0eShKFdSn3oQMupWrHrEBFniLzcGttRKz5y?=
 =?us-ascii?Q?1Cb8SkrGEPkZImft/8oJxeh1e6QszQAe4JVhAdLQHHciq2mI+YHOMzVhq1Rg?=
 =?us-ascii?Q?kC+deMFlEKnsR2Je54Dz1MURpozS8BN6rbvpMtIowZVaRQEgnQsGgoKUEo2l?=
 =?us-ascii?Q?t+davfei1kRP9IGlT/B8fIbQSZ5lK+q83F5dR9ShVsL/SuaemIEoyFMJQ7nf?=
 =?us-ascii?Q?ng++H3v8QLIgZWvmJKjhPCCqtp8u8jqed/9M68YYFSnI5MM70xXhrUfcw87K?=
 =?us-ascii?Q?atFF1baq0SqBjRBzly32Fo8lbPc+32z8Xzy1hs9T9OqxC2RWTUQKW5eMiaxk?=
 =?us-ascii?Q?u9pqMa2HpN+fkkRSm7UWJ/9NuolmeIGwDEYmfOTpSsQVU/62EuWJWs6fZGlL?=
 =?us-ascii?Q?ekasSR9RR8jpbovx4LEeA6i/qce4w0IW6t5OJrD1F003fg+rOti+ce5gWgph?=
 =?us-ascii?Q?Q5AJtVh2NecDd43BIX6y8Gd9AYzcwITFAqbXt0X+ddSd46H1RSipMz90UsWi?=
X-MS-Exchange-AntiSpam-MessageData-1: wiOf0NTvHG2Ubcpeqrn4Wyh7yAIauR4S2Zc=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5832d50a-0189-4a41-1f5d-08dedcba0e89
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:28:00.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeHLGRN5dYCViKpi73pCFu2tupZZ6MExuOV0vVZfxKMOy4vMD0J34nCTFs+zgBLrK/3QkJSL1BaSG+DP9srwVreTZJeohj8BsaH98xGFVqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

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

