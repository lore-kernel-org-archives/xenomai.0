Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E1359A7E
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042642; cv=fail; b=PFsEPKskTQ9oaQyu1PlQ20e1HYJ2LUpS81P07gtkVUnEQUyZ0yi8qf6++xxYRpgbz6Ab99zIpGFY8OvCu/rTcfDxZOi4B9KX8XJp2OHdmPXbz7suTisaT1u25LVJCTmWZ6IIq1KY3AVEGdeNBoolWuhMNcTKZ017ndxTaPVSDU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042642; c=relaxed/simple;
	bh=OogYQMa+kEGQvR74DOx9XEtIkWr0I22EoESxxGMC058=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfqePkOCBBOsBvlHkJ5XHJefevyiwHXolNBB+Gh5fWdMEOpsh5b9YdzfpXlrU57Wk+5TJXGgVMKMK5odmv/6gb2tms0IAVeUbDs8c0tx5eA1pkVDgX6DMBlIMU36YkDK23RNcFt02lN9cMEO7aDqAZrOgGHH5MtCbzGni0MDVLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zHtKA0tc; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zHtKA0tc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sokZIw07fsycLdiIeGa0eGNgltrlnEXUBPsa/vp6Q0Shn/xbcho8ErZ4elMrWIOdPs58uPGLCUbCcno4lzrlEMaDy5Gt8PwRchCIZL4tRKucKblkMZQZ1Ffxw2/VGPYvzWAndgyojzCyA99yeQ+SLCqfBd6lsmFP0UmdAg1XS3WuFEjVSvth8XDUz5qp8AI97HAi5w0jFmjbkuo6D4vKq87qggaY7Ps0ztOVElamyy0KPpnHRjf6WyRI0zoxHjYws8yAnGIGN3CEeZB0yzZHfQB7waaKOy1f2F3bLH9RbrnKgX5vR686EtaZJCt+UzyuQ27RNqZbSlvQGbja3Mhglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDXwJ5gb3H+8UAfeEhl67/tyPyTigDpHaewTnLz/G80=;
 b=NalkWVTiVnKS1xdS/3kwBgaFV926s684nowJ5sQcr2xiYP+qLLwY2BY7pLN0n8stk+UgZrQlREM6ZPQNlNlBXYAlfcbXWnelEh2opXlF9GXpmLynuxvgrAHtQsh9i7V2C6wnysxb6lsK56z4ha7kfd9U6+2SmquRzIGwzHLPHKCTo055zq2ARJhUYNc0R1LBRybKd2e3C4E9xZj6s9dkG/nCHFm4Bs4tDgbtpJIeK6VHJ8HKZ/aP9YdYPlAn0+utaJsZQDy91UaMW8yvaBjtA0BzKaUIuUfQ4WgV6559Ag9qdumlN7wohem4ELte1DQhgMU+Gj4UNTAdKNTAgu8oBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDXwJ5gb3H+8UAfeEhl67/tyPyTigDpHaewTnLz/G80=;
 b=zHtKA0tcIJPetdPLdT/LC9toDQeNhUZWbogxKdCQLtsa+MFDQVC3uAbmnnpfOxzHhRZpvsH1gSTVTqGit/NDQsOEaGfCTVCPLpzk8UQv040AbGr0iAHVt4YpqzvdEeAIW4OHEiuSUAVDFb1yBjW7NCbpB/snZjFEjZ0VyLOAo2moYPQI8l/ua1oN6wYprnzQFR0pwl0kUzz+uzZ0gZE9IJgnYawzu/Ul2w97fy9f1GYIQpeImhJKKmQrqFQHlKjIvmafKYC+w+Jp/KiSmL+/7Xy94KSXsfp4hwmHn21VCIlyNQftMdwHz4xLWtcnWmTTUm+ENBULO1C6LAF3CtDOkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 10/12] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Fri, 20 Mar 2026 22:36:55 +0100
Message-ID: <20260320213657.2210419-11-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: e57fc1be-c08d-4c48-12ee-08de86c8d8eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	dmtTqVXFvMwbvNLeBuY4axcCNhQxFfJcOFIOSRWhJfOHnLNw5ndIuLGGn2dFY4PHZMBbQVD1JDGlYy4KW89k2LrNoUWFdv5d3qAWOiiJCtGcGnuM0HNMVXSjlbp2b2PxYhiekqGuWOEIyewbSEDWaysohwQzFYO6NdmysUMowMW1zkdKLlPnafZ3J6wZNrz/PUFLOL0M0k5PS0YXcKhyxZZhJh2Og3V3CgKYJK8TpC2DvUC1fGH29psbETsJPlaTpXxlHbIYbiZvqW32fxCfWfsk5TDcnos4JNb55WPUkTNsPNO+99Q8p5UGAQe+StXwZ2834jDT4mCXYATi3QsIGLMP6SvfnUXQaxw2VO6+QW8HTRvVFZ4Pp9eDaODj1FI2BW9nrAJZbdX3m6iyXWk1m43/YjEDg+gX6i/0kymHrIcNfRZA1HkHnqvyM1cH6Oi0HqWJGDs6A2t4wfTGkh8/APYHrp3WCQMqdAPDQkMXpSsKdos8RFBJPP1xQ9rpUXR169Dv3U8wPyYyljF+e+mU8w713/sYNKUByA7Y8R0DtR5GA7ypm1sUzFkqaMtaVv25LW52Jr0vAs4WjcONWivRgHJtuX7t8JbkhIPI5gGtO2mgiKZfTyBBBv/ZP6L6mJ8eZHv/QNvbxJB9kO/x/RfMk37l5LcULFVs1KYxFnhDXl5+8hvd6Xxevxec//WYIRXwhbfmG0j8Lw2/xd3g2RdCOxoQzT8B/C+n7Avm9Ma6hUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88Q2Yc2IClmZIqvfA1mTi0v0ccwjkfKbY1NsgwylT4XNgYUViedcCKSBX2qQ?=
 =?us-ascii?Q?bSxHZDywJcirEWBVe+jGpWxnr37kdPDKp1z8mfzljbGVid4h26oQeZbcXqbx?=
 =?us-ascii?Q?PnTnCwmq19aEDKOAkr3pdETqYyg4q7IoyIvf0UGHxQwM+gn+yQ41lSb5OPTy?=
 =?us-ascii?Q?RphvXdtfX1oWw/fYzRlRInMOmL7Ovx3bsxpR5n+U5O48X1LBbGzcPIWn2epc?=
 =?us-ascii?Q?EdAlX7iSQHIAw/s7eVogaMS+BFTytpAESXWJRWvE1u6inBFRoG3OrGLHy/lO?=
 =?us-ascii?Q?IIZQ+eUOaJul65qAJMXMzLm3hKAfQq0OLw1d2RLXW+G9tEU5rqO4Zy4XxBno?=
 =?us-ascii?Q?7M5TdDR8kis3yfL0omvqkSDKmkpV4oDqc4P4nb957w3ga3v18J+cxfPbgpmG?=
 =?us-ascii?Q?V/V0bCBrcDhvqtVP7CQiKkspAa5XIstp3u/AGdcP5wDUhVaFtUbvHz3kN5/Y?=
 =?us-ascii?Q?b0n3k6BPjbbbtX2M3t0XZ9y80vn2F4KZ1Z85Je46B4FgqS9qy5lEOaN2rFWl?=
 =?us-ascii?Q?yGsN9LF459nhMQV9+GSYMkj7o6momfnri0Fq+/pfZvc7znAXpSzn5/tCu46y?=
 =?us-ascii?Q?2z4ZoptOiba56aCzS8879UI+Ofovt5SBFiBaug5XaYMqkez6PAQL2GCsBKTa?=
 =?us-ascii?Q?MSfnpCgawGDgtrC9blynzefBOLVMen+OAbGp6X7FbPHLjJ6X6nHWmBQoC9pt?=
 =?us-ascii?Q?3+Jl3X5szow5uG72sTlLoM5XEf1LCOIOy88niWxVJa/e+kR9cKdB8wL26ZQe?=
 =?us-ascii?Q?/paRrU+cWw8XY8W6XyM9525JDZePwaRxdJuf0INAn3oSzHomzYNfk8mkv7uT?=
 =?us-ascii?Q?A58ROQ/LsUxr20V+BHaBRPC7+9qby2d4hFaCO8cnnxwMYlRriQtLzpo9EoXr?=
 =?us-ascii?Q?qK24kGwrmB6k+o/dN4XVcGz+AIpIfQvHb79vTcwoslmejqsbA74Vnijz8fcv?=
 =?us-ascii?Q?52/GBl3l4DEcTceI0qB32WXpf9Qk59p9nGyTSWwtbxCFAlABVG6IkrQUbdnK?=
 =?us-ascii?Q?fDjaR4w15JUny43JmoTJiLnMb2YayTPcxBXB1Glwk0T3TYe1UK3I6OA8bzvX?=
 =?us-ascii?Q?OdcRNXP027sTIPL+nnzti2yN1vpUa/jO+gR6xrTqhcyCgMiKdm5FcfKFv7IO?=
 =?us-ascii?Q?4yclPIWOs0LKIejd9JR9N9UfP/3zb7sDtYmcdapEO3/9vZVPEKryx0+03nc9?=
 =?us-ascii?Q?s782b9YAmTP9Xz27+DTt6hmPdiLyHxFg6m5fa+3BJIPue+PjejufGoJr8Wai?=
 =?us-ascii?Q?DL3YdAozqLV2+Zjq7Mx+y/C189+xFRNREgWjtsnrtjXa6B/eOPpIq6VbN4A2?=
 =?us-ascii?Q?/Cj6MQ5GjkQRYoi4dc8r+oltXPzptA0Fe2geCf0kYkhQ0OvoXHD7fCLn5qxN?=
 =?us-ascii?Q?rLYFpHhJWec8RmGxgO3+/a8k4BHo0FodbrvCPmWLQqT1CsiUU7VW0F+wlQux?=
 =?us-ascii?Q?tYIhg5eibyuGZZdgYjn1B5yHXZ0fgf75r/duDhLV0iNcAXbRlCmcdrOCuIY1?=
 =?us-ascii?Q?/IkufkY9W92CghOCTgHjyrlKRx6C29SZVOgQhuWa6rmrnyuUzuikdg152KQq?=
 =?us-ascii?Q?CR8rlBDsfDn+Pyup6b4oEsHK+xJ2cShoVsofvOxQcawIdyzYK+M2PajZnlF0?=
 =?us-ascii?Q?xSdj9oWew9nm/lqDibaxccrhMBoldNaf/S2+LZa/MuZI8qUeIxFlsiySYa6s?=
 =?us-ascii?Q?R/sKr/glsuhzu1P4I1DRZ7MCpHQCXhB58haZVi3tAgf9MV6IfrObAFOU+88Y?=
 =?us-ascii?Q?rMSf+e2zOamCVKIYv1/5QCG9qsWX8X4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57fc1be-c08d-4c48-12ee-08de86c8d8eb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:12.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIXHfwCFiefm13UerRkcIi1yupGqXCx/edRD1KcFyStfEPDvNhyUpRrGLVo56q09EeiYiC7aQKsu5EhjUSuzqO9uEXDq8Rw8wtrRLC2PxAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

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

