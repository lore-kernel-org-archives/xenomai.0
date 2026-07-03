Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02051417368
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092483; cv=fail; b=fYdIY0ZPZiNj9Bfm0ITGGW3PJI8SGIPFO+XdImHnpRtopdxjIEODEfXZiWkDhgBm4hA/imZTdvjJ3V98L+m3hEH2XfPPBlKCilVrDxa4t5BHhPd9NqxXkuh2NI72++/zmOWmJ6xS4Ejxn65csauq06C8ahH7r9llcgweY1mWWaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092483; c=relaxed/simple;
	bh=Iz3YHZmRESpwmKf+WaQ+64QPVxsVOEjSZ4BqNDg2vps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l24t1ESR/INh1cSXDdEMC8/te+iZAqynNbt9muvkaSl6XUVoXHblc9h9N8UuxblwU7fPULEiDh+1V7bQifRQIqtiAvJnShiZeg7G7utQ3VK539wGsCMt/EqK3Y+Pu4OaK7RXU+LSW9QSslLGaqHd1PA5HO13tro80wKuoXomCu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Y8HpvGTd; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Y8HpvGTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy/de0mMfcjaqNE2xjQLlKMmTNqtwO+nzbCiSLNJty56eWMjqJT05HLwsOa1BKtR/oQdFYoFUSAZ3qyNNq1rrA9wws4OhPnVpQqTSVZvUFNiVYud3LaLf/3IgzWvbxCZaLXp6IikgCUI7uz9fclQgb2KPqnYXzSARqgE5Tf/06wMuQHv+nxJyv8muEN7jgiXWzAnWVNK6nBjJ3m7Ckvgzd/u6lvBduIEfFrFGHCIo8wu2TG4wC3BvSBMOI39+BMIgpWJNf4t1xy3fRGyEQBbvs34oa+Kx6Kf7F66j05FHtCI3hQK/uxR2QQi+6E1esBpUgcy9o/w9Pla3Vl3Se8QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvydnsv/5tDZT//OVC5tn9Sajip1SyUbjNhFmU4wCIw=;
 b=hY1fHqmDkRBv8yMTNBa6GnFQjjQfc+aWj/iztW50nEpaq2bT9e28rIJ1dhtkdEvkz38+JQr7Q8/iEW1RiApih+vB+upmYn3aO6W8ozrqB1+duzBzA8My4AUPbo/o6RbaLbK1ZDn/yTYjIG7HsfZ3vnNSs6EvL34oBpgSoUVk2Xo1Ae/DH9JcmRJAfhDjhgqbq2r55SDSGDGLCb0T9ShN7GWeB/FPiuEVFa6mfQ0IM9pGhLV3FrjfDEBcOCoUrHcqEN9SsJEVRPOqiWInji5VrI2vj+nfMQoVR32urLWbLCYS9KqmPWTHxWT1AfRiqWgP7/5/cP4ATQhhikt8m8SoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvydnsv/5tDZT//OVC5tn9Sajip1SyUbjNhFmU4wCIw=;
 b=Y8HpvGTd2xeczP9oBt3ZV731vb7tD0WIBWWbfi4MLdYnJ5I4xUUUqtXFd9GqgL/Atgg9lHc+MUaKOjLrw6vyd73g1HMVChRT/EWoOB5dEtdvPQUWiuX2bguK1RkzxqheTQwI4KYOtZxmYAHFLMeERoGY95H9VAMN8gDa9Luc0vsTTEIQ6OpknQEJ/A7UFBTv4CdM/EfZVsRRV7S0PUvtmGP5cW/UPGJWC66mrk1MKsMXMG/9l/yA2NZM+bzOnG99b/sAAE5kOYQYT0YDSt/0IA/BPGDiPt02ZStb2Q4B75s5XHzL/TBODBjSeLhx2VX3WxN+Azd60nuzUs0Ck1BxjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:53 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:53 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 09/11] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Fri,  3 Jul 2026 17:27:36 +0200
Message-ID: <20260703152738.129122-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ae19ce-0f77-45b4-d7d6-08ded917a5e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	q/tHod27hpD/TnsGiPp8jPfnjThHp7LJnySAdD/LcB8TKzOnPIsGMYrHWclq7pZWgBypQ58SFtf06EsaojC98DVHXKL6yjdLmTEfYf5ehsf0yXeeNSIcxINOaNtyxzz12ClRXLdke+/O90ARFmaAai1YUDdUvr2yhhSRpNRd34WdRi5intZ/t6XWe25/6oAVa78jqOVx/cCPqkfEnQXbhHPrOFntPk6eqltfSHVRM4MS1sNZWHMdlf9thmXcZD5fCLS3yg7Y2N5pRGHBqVc1AkaJlllkR9atnEwPBty87Dc4UwKAl53jrpGvB12U/hDO+4Ze4G2D8yW17MQlLdFLUrjEZRftgJhz6GGq08jokTC+lTD4ovPYagpJIjeEedzEgKKtgOBXorf3JQym+E58AKrGg1pXRbd7WS7qUpEyxRjvCiIVO31IyPAW59mcv3sU94Zc1i7x6KPUYtTkJwPgJW7fXh/zRVwQhiTVFouO/HRj0JqMgsjmbdbFS+KIsULwNntgksVMNQXtJ5LHph5UpKBihkFlqz6hm0BofNCYX3cYT9bCevWJmrPPiuaUON5HpBDz7e8xL9CJMaVp518Pf7tGhUhQ0+8a0fKohDyUskIHoYyWHrg1xZxlSQiQIKt4S6aq2gfFnL2Dac8QJntLxpxDjYrd+TF2uV9WvrnZAbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0q5AdFMpXEwcbkKjo694WSIRpR58FeWl78YgLMOCYgrvhUkQn2T5SXN+AuNc?=
 =?us-ascii?Q?7ao+72kfnRaIU/E10OaAZDgGGWbq69UKjJ2BnbvD0IW2nxOFjj4FnSJ+WNCe?=
 =?us-ascii?Q?fXoO2vRWKwAw56lBC6Qoc0+FLX7JyMwpKGDsx1Ev1ss+S6FVkGoF+Tf1Dzyj?=
 =?us-ascii?Q?PjXuuxexcTzfD/oCVAjrFltmN630EmQwM4wm46MCZkjnyM5D+tZQafgEX4Qw?=
 =?us-ascii?Q?h5fY3OJzKbeYYUN+E1DI/+7Nt1J1FyUGLwvfQaeTMvdijw8zFb02Z6431dLA?=
 =?us-ascii?Q?cGRHjMGrx6x0N7coTjZvz1sr3v6VPlhRDROuMMmyYocxMpQWISS09x1H8MZA?=
 =?us-ascii?Q?fkkVK6dQSd4zDIIBUd6t60Yl5Er2gOdZ9TK0kTcRkTbHdmpQComQNElZyK9q?=
 =?us-ascii?Q?LbM/Q1SAkIMSubhrt3WeAf+u2zCgdcu7Gaq88mCJn7/xlOtwshI7drot1qjs?=
 =?us-ascii?Q?4mC5yvTrE4BV8UBIP3BYn6g0FcCBIWI7halIidMoGPuQSUNbvUsLTU0I8tZB?=
 =?us-ascii?Q?Y7mENsgZLPtzrMOBRrjaCieOfn54wNY2V0oL273ttZyLWkUrzU8CCRWhJQJg?=
 =?us-ascii?Q?76UQbIuL0FjKlpsqlZjBcKjCu5p8o/Gd4CG7DWyzfM5dPZgTl5uc1mFpi4hJ?=
 =?us-ascii?Q?hmdIp6n1iPfZxspRqnzvJ5H+vlzfWbPvv3jtqdiNiH4br8VPjNhNRQr1L4Y0?=
 =?us-ascii?Q?ENY/+kKY1f+XbKgADAckI3kQ8JTl7MXgfDBUS7EVqB6cUAOrtaaiT7y5SnY1?=
 =?us-ascii?Q?d5SPPoSOmv0w6Rm12exPvjnLX/2xAsiIgNtSzsGzbH5OWF8fihFx3GkneMNp?=
 =?us-ascii?Q?Daj6EB7awGuc2aS6ls8NOm6vbwXb6gmkbrzt0W/27PiTibDxzUk7tfuoanZv?=
 =?us-ascii?Q?Cqk9fKQ0PV6NVi0rMr4mDGG9x8ELuSIbjTyFbRpvkbW0h/yGTjrBWRvDfiq5?=
 =?us-ascii?Q?XmBy0LwDjRQ4Z5n2h1Z71MeI71IlO1k2AAVSj9X6nOoh2/2xBn5/w0rW+7Fo?=
 =?us-ascii?Q?AvfUFIcnthpkQhi8RleMHmUEvHjcZ+Lp2h4t0J+bO/IFKH8NN2bvLD9Mvws4?=
 =?us-ascii?Q?v948UEEhQ/idgkKrgc3TyF3ZKGXswdSTfwaXYvy/7bURvMQuhyVdngI+vPle?=
 =?us-ascii?Q?QXfDpizOqGxbFMYz0AztIdw+AZYvrdyXcNk9EMQhEfikVjF1Gat6uFcrg1rV?=
 =?us-ascii?Q?MHnOZgW1zQy97VEYg8bM2qGaZTfV8TJiCtAYZFz6a4D+Yoe/7BRoFnU0F4UF?=
 =?us-ascii?Q?s7nFSDLBc4Wj1LevkWmHOwR/lFU+Se4885bJRWH/G5hYH9RfeSSlRxcHPGzb?=
 =?us-ascii?Q?HHq4ilnOi8ISPj4sIMy04HKawXsS10e8IsexIlD6k0IWr8y28G4OgoRL7Mch?=
 =?us-ascii?Q?DtI2bTkuNRmhpnhvgYd7ud2DD3yFN+n6IyBkD2dh2/KOMH0O1Gubjx5V9Jts?=
 =?us-ascii?Q?SUle4tBeGsCuTnOc9gB0r47BH8ryWWB/X1rDWaIlgC+OPD9YURkNfz43HxxJ?=
 =?us-ascii?Q?AR63O06Fr0x01rVYA/GYh0bDK2FpRclOnaFpFt8rfT5OjQaB3985LKip4DKq?=
 =?us-ascii?Q?AcWPJpJh4RlqVV/cLoMPSSaimi95fWJEOPFApnUbsoFW7v5D0Jl83Ey6jIlr?=
 =?us-ascii?Q?OpSJwRan/g4Of2fuK0vZPb+hIGWcbC7JQ1BVQ/CVJAdjfJ3AijV6RB5MxiHp?=
 =?us-ascii?Q?RaEPSt2/Ow3+LJRAyPuJRgEUPhtbKTa5XIftKGugFFc2c6akyFvQtlvsOnWF?=
 =?us-ascii?Q?W1gVuP9MgoPiObgKpvBWRtRuUVQXNBc0th56xAEHHmTQJq1v+szyjHMO2teH?=
X-MS-Exchange-AntiSpam-MessageData-1: iRATozDVfTYAg8wOK1RgnbqKHveO9NWBWEY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ae19ce-0f77-45b4-d7d6-08ded917a5e7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:52.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkXt941q6D+xVfqPwnILGWw77uJusr8lDDP/aaQDaWGMiZsJ1pIAC1mDF//hOidPCaao26Z5zPscD2ggx3B1JdjgO74fDrE43jjAyYuSQoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

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

