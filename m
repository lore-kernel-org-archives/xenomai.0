Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753D41F5DE
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237161; cv=fail; b=ei9GlMr55mzoqp8ne6/c8z8zfHvOCvloFE2U7crh5hf3/Y/eJtNWjQANSgibeyhz/SzTdE4POqzhgO26hJnl0jYKN5OXNxT92ok/KuyTFH2SZ4mLbfSvMfiiy56Sc4tllM315+0ILHR9IIcCXw6Mzg0UZZmsmZh7VWQ1+pyf+Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237161; c=relaxed/simple;
	bh=YPYNvUhRctDSJGE7GHjNs5Z5668S4zp09jgtGXDCBO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXYpKTex9lztq47gdV5p7a52X7uYyTWBblA9cEQUIH0/XyEfboyG2bel3DgBAytUKnLm7d1OdgNeRV5ScRpkMYbuv24WzffOZTGbWAgr50NYHoXEpZ6V4PGqn7uCNeY/Hum2vTujCFYWjSaQQfD3PLEv86bX2oQ8UEp3cLUjGrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bNNt43Ko; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bNNt43Ko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9SxAW+97BSWlvpLK4smy8uqZ+YnnaJK8Q2uww6mbIyh0KFKDjBiao0i0LUMmB/afpHi49y4oIBlKsFITmso7z3t498vZrzyFAkiJbQJVm3+hBgcBqfRinMtEMJtxl4LcUoA1YFdApVv8GoFxJsFey/rqNduo/f93AjxumoE1z7SCV0PVYYTZf/cyCoWUmffPboGqkJZFv9Pb/r6KVY7J8PsKdKEToJu+pVpJKGB1rKtYZ4AuxK4JCIL9Afbw4zx41AczeYkj1jF8H8mgrbeVDexsfztKiXJXhx9McdkWaNGT2bIejc2FjprAIM1j++AzyHKi9B0gDVhaTRL54XwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWOVY6RJz7PdiR9oGetpNbQJBWMuJ2etrFun8MGoi2Y=;
 b=diVzfG70L2ssvyWFD7yRZQa4v5gQovi0u7ggVEwlx0v8tSyWRlu73zhT7OpM+W2PpcAfPze0GfF6cGb1rfljBY7MKIL/c9mnmUDZUNM4msdoKSntPbjTmWf3V5+2HUqdnp77jVZY2Xq0SJf39WUTJIakhtumEl/8XfHmHrwqeXq2qaWdw3CsQCo8341gaYAKTy2vMS+e44D5ut+udlEjlQUPX3aBCERMIAUpqrg6MTvNtHIszleBY5resAkW5lKrk6BjlamvFmMCR4YAH1lHq6Cl9W8dj2PpE8VlyU65ctgdCDZh+hvcUF93sZSainMdKmILDcd2GT2boer44uQfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWOVY6RJz7PdiR9oGetpNbQJBWMuJ2etrFun8MGoi2Y=;
 b=bNNt43KoZlCePW+waOQ32c0AoPawnfv8gJmzco7Oo3d/IMujcFFGxZTCAc7LGfGCVV6B6QtGbk9zl4gPwtokFZgYAEQfU5onUxpPktSrDyPyKMn7AB9bcViQorUT7Wv3p0J/cd2wQh1Zl987kOaDpoo8fa1B9w94skr8IbktwhQSKJwR08Nd44uCXI055NWFCi6qCFPsNKHJQ2+w7rRG+wYB7yOgzkwX377sFcl+l0KToHPCHhnCUAHfk4Iqe7sulVZVZuvxM1x6Zp/B/lLK8htFXMAVbzQ0Nex10rMfzblsrmN/MHLi0o2ZbGsPW0zOgWBc+id+JNZWsDSc4uKCmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:12:33 +0000
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
Subject: [PATCH dovetail v12 07/11] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Tue, 28 Jul 2026 13:12:18 +0200
Message-ID: <20260728111222.2699158-8-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: eefba3d4-5e98-4d68-1867-08deec991ef3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	19hM3YYtQeWkAfJcPo4Yy2snTr7ipRINZciCBbMpHmEsmmV3uK/uttaK2x3ZOtfMYrX7pd+yMaB1t/wi1emGsLK2QtFy+l3MzuUYhi7QnI2iz4WioJ9Cp8DFO/EKtOc+BDtNGYgpsLSL95m810FsqyY+1gJobIBrdhqBx48mD5ATBVaNie9x8uLadu7miwJs4kKw3gdVgKkXEPbI2H/UJcTnTz0F4xZ4FoexV7MDJh4OR6/TjkhyvLN/oRTL/ObTbMqSRBUpbuB8yJwOMqkBr7Yd8tecsf5hiatl3J/ZD09qWySUgOvaEnrXgzxZmTF+3kUlAvlAwZPhYTbm3cTgLgGStvU/7uglu39D6kpsIkwB4p7CXYj07gOgf+POvsV8hXYBt8pGAhIZufHmQIOUezj/UZveCzoFhXXCZe9o01lALr1+1WlcqKgBHJMlUPa4M8dKI7R/XiwKwoBOoceesfwAlSnPetJ6Jw5bMdu9S5NRkYJf24kaN0fxUJZ8DsgOLtV4VU57YPb0pD3F+c0SewzLqZat/uJH6s4nYkjghfM3/PXCyJ8rPZ8P9X1zQeB9Bwuio7FBP6NqgADz5vx3DGTN7MyBmC+DGDAkkzI630sw4Rw9kz7DF/PpdJTM/0ThoRm52JZzQpY8QGCDaKFB0qo4oa2K2+6oaR/toQBOBBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJNNZ9UVF0Ge0m7hn2+fJ0xSF5SptFa4pIyW3rtOdOuJ2c1r3f7l/CHlkllR?=
 =?us-ascii?Q?BMHOi0oTgFqblsyijcqZFxIqefoIuhwrMCAcpKpJIjTvUAtn+FoS99+Kp+gV?=
 =?us-ascii?Q?Dx6nQ1DA8pF8mANYyXDyKpj6h3uYXptkKrfY5bxRTUVJhDyfBLMquBLHdVlG?=
 =?us-ascii?Q?kVEsQTmL5Zh8SJP6ZNNFl0gMk15u3p77f+y+xOXw3DKDHoywyOiJKzV3dAqE?=
 =?us-ascii?Q?aIU6LKHJJJvV8+/b3RFcJYlW4Ivm9ArM1KOyL/YYOR5qE6qO1arjv7kGi7Vl?=
 =?us-ascii?Q?aa0L8B7/jfC4mz+z0m6E/Fcxv+JBGSn1eya/B5SWDnHHCRvINeEtajmn34Se?=
 =?us-ascii?Q?EK+JWIUx/yTOhxheEa7hYR4Zk1cKSPYsQYop5ZOZrLRu0kf74uTVLcyELfhs?=
 =?us-ascii?Q?N0EPDP7vA8Qq+wIJM4+XuxGFTiKD5upGPwXkXNhgCRS0pVxpR85XrkqbqTRV?=
 =?us-ascii?Q?g9wiD2DmweUFtSRKygQHSo6dXlMsQO6bCFX3iBYZEqF/D5e7Esj+Hz2CIdji?=
 =?us-ascii?Q?Yq0QNJa9jDl4ZlN/i9uDhpd/04SxJEQLFB92SFPTqEyJdaDG2XrcVDPY/gVw?=
 =?us-ascii?Q?IbgZ1itfWIhW8HxNDwocQfPsU12fsmuShuBlaA95GdqrIICv3DaPjB+jFUMT?=
 =?us-ascii?Q?XoT4BnqBjn1Ca1VIfVmxtzxPWX5yi8Mhshnjz0/eXjHBQt7TSIiqeCvvhSvO?=
 =?us-ascii?Q?+pnRyA0S10qgu/e5VhWemC0tXGClzMRz2M8U0QYFQRXoxL0Tl/C2nMYWNX9q?=
 =?us-ascii?Q?v0MrUxLvpC03eawH+Q7zgePZOQ1s9Cl17+/WDWyN6UpaCWKibXspgzlfYzDC?=
 =?us-ascii?Q?Z32ORaK8KV2CzSWchk6/3+9FIlM7qohSuL4Vd9bSp9sgLpR5jRSD1OkQC3by?=
 =?us-ascii?Q?G++E1j17tCOK6IpAx3twSVgzWcxuV5Gvb4LZIyPF+foH3+sbj0KlWcoRhefq?=
 =?us-ascii?Q?xcDAF0+KKLZ8ssATYK/Zue20ZuXKBAnmT8cN6p/rzIUWyrR92jbZGRGfnA+6?=
 =?us-ascii?Q?6fi2gRhxctoh8uuJ4DpYrFtQ5UqRzRFkncI7pnkwFF1zlvQtuVdt2RuyGQqo?=
 =?us-ascii?Q?V/qrN3QVl1MtufQZuCpPcNuoKi00oWNYo7RprxKUBo1vlXf7l0mjP966Cnwc?=
 =?us-ascii?Q?pF8bQtJ8CMueyhUPkXFpBz7poSjY9eGh7dO4Pyef9F3qw8p2tPNb3ubPvgwt?=
 =?us-ascii?Q?dnhw88O7v7GjQCwvbKzHAokb6CfQBXRSwHN6IrcENnRpmPyn2YALcItHZMRw?=
 =?us-ascii?Q?sYTfWjMde34O0woDVDNVxdOilDaeHgjk3IoXTL853NloThsEXMkOopod41r0?=
 =?us-ascii?Q?Q4eWD8OVAgdg6ROxANwSWGBkTRaSKPZa+fj//RHmFThGxcgpaTv1N86xSkxW?=
 =?us-ascii?Q?yUktLFq6zTi7CC6aPD3WYvx4mjEu1ftUaKCu3LMCE1xo8Ehtr6xJ3BfqGV1t?=
 =?us-ascii?Q?CKpt1RMMxXpnULmmX91VSy+6ItOXxFVM7J4T20jZhlQ2yhuuncvgMfXP6uS9?=
 =?us-ascii?Q?vO+REZRn3zZuWUcYtAAFwaE2wFh7ef0TA8NRVrdEk71Epzg4Af2gxzTkQBhd?=
 =?us-ascii?Q?2KI9JQOnTDKiHZm816WEfNTQc9dIibMy2rV49onPH0a29deRK+hUNNiMggU5?=
 =?us-ascii?Q?WrDkKAGBA4c3F5+cSEeB6JpwGJema7swL4aBxIca94nPa70nac7pvR/yoijN?=
 =?us-ascii?Q?tdQp9vagV3rSPzCrDysTj7N7BP4OUXmZuYwOg64LyHZAbKQVs+L1OIO5riuK?=
 =?us-ascii?Q?T2m6pmqjIEeFy3yLViWzjb5nU+gmAe0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefba3d4-5e98-4d68-1867-08deec991ef3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:32.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOP7ByKzNytOzOLQcaeYdICUVJjbhRoIqxR5M1x6hsCC9IqyA87reo0dzvrejZs5p+NRi/BAsOyVYLv/qJll2ZJqCKtNqK9t99Q5n5g5lho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-sifive-plic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b0dac104814..e9ea0c86366e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -88,7 +88,7 @@ struct plic_handler {
 	 * Protect mask operations on the registers given that we can't
 	 * assume atomic memory operations work on them.
 	 */
-	raw_spinlock_t		enable_lock;
+	hard_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
 	u32			*enable_save;
 	struct plic_priv	*priv;
@@ -227,7 +227,8 @@ static struct irq_chip plic_edge_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip plic_chip = {
@@ -242,7 +243,8 @@ static struct irq_chip plic_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
@@ -444,7 +446,7 @@ static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler, void __iome
 	u32 iso_mask;
 	int i;
 
-	guard(raw_spinlock)(&handler->enable_lock);
+	guard(hard_spinlock)(&handler->enable_lock);
 
 	/* Existing enable state is already cached in enable_save */
 	iso_mask = cp100_isolate_pending_irq(nr_irq_groups, handler);
-- 
2.43.0

