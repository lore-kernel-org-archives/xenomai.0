Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9263312837
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459739; cv=fail; b=Wq9wnjRIHlvEL9LzlkOp/R+71af4TK3wigfyr/8Q4RjB55f2uhR+bRf3j7YGGh+R6ceDeaGsToz0QveVzVpAOYX7AXX2CuLkbzAqLJnOYuvYWfa5oioqQrXXbh+PPN1gFKF51BrqWjfwsUoxnfogHHpvjJIWDk6HKy7bUVwbuKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459739; c=relaxed/simple;
	bh=nFro0Hv51MhrPgkbSrzbgjj0lgqFnW+OoXVjOo5i+mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNONH3EtH07Qz5h616iEq003PEo15rErUFua/kNb9O/BvE4F338t1HxBRyVnQcxxZxArFUy8Cy81VDMxLMqJhcqk1Sb15kKc5u7aTsIWdOiaVGq6jyrwGAJWtS73zNdpWsj3fZAKfkDEehVfIs2A81ZbTo/EznHvAE2QBIx3txg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Q/i4vxM/; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Q/i4vxM/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGcWslqIknDZS/lZ1GYvSiRX1mcObKNmTED7j4Wz2zk/aU3CLSUw37jp1EGJHcfLJ8586rgr4YneD2cuWFIPIXhQPl+FQ0GjrqFz1LXSs1viqpDrC9y/Ca08tzJXzmFwZYLpRp+plbahuR16mrvNwsclBLxPDaSC7DusUwSB3LjkWI4Nl2QS+FwuVkG6kWEgMaolq1S2e8r3Qxt4iSfXcNj/DkonrdgS3nv18mHSiJxeh0I+gXgCkp/qAIvAT26hBZFJUoPCvOIFuudOxVRn2WoOaAUrTyGIzis56vZz1V4rYhMPSS4KHpU360E+ySac5nkieVJRc9++/SttFmqk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=652yfiGCfSUP8xn6aqxRvuYn+78RhCvl6epeguecCc4=;
 b=iJNEfeGwfwnZZ8gxITpx8XwfSgcFylk+m5+TWWsTiU2hNITks4rIZrYe/LFemUFKKo+cSR3ZCQzkqmwyKhqZ0g2VKcWtJK4g0kED8OtrAPyWAWUnTnya9Q6tGnR/OpR+5/pYMXo2CEjCj+ucEmSu83eUf517IUZsS2Y9/S+7mvwuWSKQ6T7jqckwB/yy3LBhFV6I51T4XiGXe0HtVVjkHPgQIdun7g/zNIky/ymScx/KSj6pgDUbUQKzFoBpxuxHTF5Q6vfJSGYSPTgBGQmvOKT1wQ9ankVRQZK5MwOvMc3S0xIwQu6cF9BcxvLg71lvXf5rhimKV/VBJuA0tHPmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=652yfiGCfSUP8xn6aqxRvuYn+78RhCvl6epeguecCc4=;
 b=Q/i4vxM/2e1gjhMsYJCu57ILz2Zjy4eETbFVnNRAIStDtEj6c1XGEometshpVhsMG35i4LhPsCFMhyCeSOGN5zgfE36DqZh/z8DGQWJ6ti6j93DkqYtUxT158HGGcxYVtuu9xmvof+bRmXQHKxC+rx/ISFiJxT15lbAOsS3qJihTpezDenpsTd1e5vHBzk2PnMDm1yqsHiLvwZ4QoJyM426awyktNPYnpEbtzxp92pIw4Cvj92/1lSlZCctkgwhO0yEOzJ+OYeHFOHqAWH1Bu+A4s7TWdQ+zyMc8gvU1buOQKjJcvsSNK5EOO+ygEgIbI2BtmIUU9BiVGXNQ++jzzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 09/11] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Fri, 17 Apr 2026 23:01:52 +0200
Message-ID: <20260417210154.2290819-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c61baa4-25b8-4a50-2cd7-08de9cc494d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	xX1TscDPaF/881I3nCAg/HclcgiLuDSY4JMWWYsijivPLsQ5Orqzbx6nA5JyDLNCQuz109eqRZM+l1hZdeBe9lsBD4G480DZofaudflmsev8lTChVr2503dRtXeb6xFljClAyxMsJoyS+fxnMOBKhISb2WDV52QdTJva5noKUsevwmf8TvOBL/NIu0Py2c+XZ+759vgE7+MqRufVh+tfqP/45KQ7oPlJVp/hZbt2zyziME2GYdbZ9GWCjOsmjlL/KZxHpeztzyjN0SIVKWcTnu0EssRGgEM3uudoQl9wWR7fclGnq1/ehz2zQUF7jxNmuqU1gntjF4wgfJVTlV7NLcIoxzRYAogRSv563PkKv/NzIGxXs4P0eFA9WjSou/K2G6qmu3+julLd503zfNjNGQG8XxIZQnQnDzmf2YYZ9wZWRAxQsqDUDyNjFs7f6z7ubb+WMsaLBlEEsPqMRJiOSk3b3a0XaR44QANFhl0sNB41KSzCdh8T/nRsAN7lwB2z7xLnyo8h9D2yi6s2ZHqaAlDAoL/9L0wX8sv8n+DLJEiGfvE0Z9ahVALjnAD3V+gxtKScrRQbQeJq5/S7coUzuCvKA+uzD0Y8QId9QoDZGoli/1tu7nhOCPqn3VUr4w2HRxDnJevWJhjt6FiBtK7PJO9Gb5Mqk4mT4B5sfwgGyWwMzJe2BbMnOj/WU5n2k9Ws8Z3Cfvnmro4xHAzmfqbZsowE8s7sd5MnF1bucfn6bFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krWV9Rj0cHWYDHm5vRl63t8cNgCvf8vpfjFqHidJy5P5JPCDdoMlFmGghcqK?=
 =?us-ascii?Q?43GqUSHKWJo5Cz16hR5QJBozzXo1lDIFdyaLH5X8Ux5EWcgdgJnvzpOg62MY?=
 =?us-ascii?Q?BEcX9qIf+BEh5DPD1Ur/JMWmg2KIFBOtPsppD+d0tDfFUL25RY8EMgoqqsYR?=
 =?us-ascii?Q?0nNYT4Stkm40AcbzSPcFCEl1DRpHUDaoOdrPddeCcuSwitx+ygNHFF+a1bcW?=
 =?us-ascii?Q?QS3Vs7VsEFggNs6gYYj1punkFnZGeeh/D387AXIDkvhCPLHyBBpzIif5tDEC?=
 =?us-ascii?Q?Mx6bKqfF+sZ+keBx4ZtUewbyaOxupNWPGeO486VAoI9IMemp7tcP/JklpO+m?=
 =?us-ascii?Q?63ceQvtN6LvOv5EkhKfeDDpbkZYUi2t0bZbtQrDa3CkiAFFU4XSpL9l0hASb?=
 =?us-ascii?Q?ha6TWmnQ5ZXtByANzpaCzBDwwtfUq5eKEdJ8VNvOOTf1eySKVo7PpNqtWLcB?=
 =?us-ascii?Q?BGtBwbpgIV9WmfJ8O0gKqot3cv8EZhW+MdGwI4KHvDUtQ9YjxHOtPyxLhdjx?=
 =?us-ascii?Q?rXPIJNeBzu/p7NnVErqB3BTRJNAfztRvqGPjgdf6T1sxIk+l6sGLQKdQ72as?=
 =?us-ascii?Q?jEUGiarEkaynVVXjRBnXWNSjbfX75Tb1i3b2976ks34zzqVsVvXJ3LPkiIix?=
 =?us-ascii?Q?XZO6Wgep5Ru4XmlWbo10cYDQRkOCISgu32XeS+u9FViZFrhh4cMvp0e7AKcx?=
 =?us-ascii?Q?WJgDZxBAVUirvWiUZSBfNHLAFoqF2ckGxrnfAFBDEmcGlHihufcRMPUWINwr?=
 =?us-ascii?Q?T1FGx7bmJWdzLh/JlJFQbH5baWFYCAUsjz0BmSOj1YFoY9pQxQBjqTzz6re7?=
 =?us-ascii?Q?udp+/UQZ4/TA/oEh+cCq0SwUp9SUCRdJtwjkUBt/JCTSJ6yH8vDG7zGQkwPX?=
 =?us-ascii?Q?uY7Las7aQLikQM0fYvXHZeeQtetTIw9aNtKL4CaK1H13ZQG5QS12yJJxxk9a?=
 =?us-ascii?Q?Nl4P068et6VNmdyF0c/U3ClbBX/OL7tlLMXQhr4Qa19CIt2cDxU1ngb8MuNP?=
 =?us-ascii?Q?dA10Bc4aHT+IiyHmwYWzJoAhmS5xEzyGYrfLXmTogKxP59WAE6X7STeiFtks?=
 =?us-ascii?Q?+Wr6uGSJ+6FYHLbEvUGfENBhH/gyFQLfptMS/7E+mPH0sOfbZsc2e417ynP0?=
 =?us-ascii?Q?IJeI31dK9tYgrUP8R6LUVW1yCPk5sacoixXcaYmG2OGEeDkNrhe9/QvxVqGg?=
 =?us-ascii?Q?p0zN2PfK0gkUbvYUMZPSuRl2XwyDLqCwdW7yB7YkfDPKdQKlT05XpSNiMCNf?=
 =?us-ascii?Q?GzaGKV2N9Rk3ewVHbp4HtjcDhgDhzwMljAZA5dpwWOXmPq6NsvAU9Brw1ysb?=
 =?us-ascii?Q?ks7m+KYFc48l8EV5PntWqTnUaMBFW+CN4r3CuE9lNTRq++7bpE8vbttVHCtR?=
 =?us-ascii?Q?1/xeIDifWs8dfw4D3V2HygVFMM4hTMir8zPMswQ+53FWu1m+8OkLJ6OsfHKA?=
 =?us-ascii?Q?fTetzzNbpOAa5UnhYoaDjjKSTvl4/BCuNnc0XY/0PJiBR09H1DcTcOvKCRbw?=
 =?us-ascii?Q?WwqZUcz65U5M2UHO6w1CvCM7Etw9sSHa2nncbffXnh1tL/LA9qUUc4CI42Y7?=
 =?us-ascii?Q?W7cZXdhDNaeDiNCLRctTunNwidcp+XyBEi47Woa/M/lyb8r7soJJN4j8E3ni?=
 =?us-ascii?Q?0m++sg/AJ2rlbIFU4p8vhHl96emrTJUEtmnFSG/FmgVVfg3bBq9Tolo4/pS1?=
 =?us-ascii?Q?e2d507F6A+ZcZcGOvlfGJvpMBoQ9ixmMM1uGe3J+kP07kUV4KN0oZFD36Lgy?=
 =?us-ascii?Q?dyY/z+q9HQlVl72ast7vD5V3lFBtasg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c61baa4-25b8-4a50-2cd7-08de9cc494d9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:05.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S34+GsORLXlRiADCy93IeWIOFSuXz7NHNwXzPxDSUbpvW1+DV4g85KqK/3SlJrywko0oS2IchY+A116LR26bq7ElKNwoQo6GMA4YkQ2FqUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 2 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index e44480e71ea8f..88c8940fd975a 100644
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
index 2da2d6858008c..959578765cbad 100644
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

