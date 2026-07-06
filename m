Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61469437869
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362588; cv=fail; b=EP2PWpiyYtVPx6XwwsQ6VeRuEvRgqlvNCole82KBKSRzdFpQN1cyWwmc4jloGtLoinroDaz6DvaQM0ZqcUrvRBSdJQm6PNCMC4tjAxuydmvaVuTg+H46B2ugcrrm5lkb/Che2R1yKgnzAjrmPjc9CzQ8nVekBeGzrOPOjPx8/NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362588; c=relaxed/simple;
	bh=Jn+25HOejs2pmW9JQrFFo7EmRJeVU1Q7u5ys6wNKErk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSjvrq4IVXElZCJLCxcs3bkShsosNV5Xtp/JEzt7uMS030n27/BL2/e5hQLYEDs2Rz5GGEnTEykjuSPxJGrDke0vEFJUatxE0Ej+pgYJxAGbro82PoKwoV7+ryWjdqLG99IY28b/1kNoef9+XQxPkGUXMc54/fK69FjtZAiMSn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eYJe7UY6; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eYJe7UY6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayQPa+GT+ciIT04vaQRmeAcTrLGDg6vGL1BPS+T1L1BvOqsZy5bDBY5NOfwOpY6txQ3Q+hgLItpk0dcoi+en4iEOqjL8jOk/UFEBxPOWNa4HfLLRJ5nSx9jvfdNzSQHlt7D57Fj8z1Mo51d61W8oX/91rWLwSnSSk+U+uBMxovF18jL2fjn2XnvGso1/CyEukj9O1F1CNvZ8KqsibtvzArBM8GlqsP+t7nK5bPO9U+FdDrQQX7nDCbDjY5JWiq9SgHfmCw1QaMx2eYTg+G+9jUZmyv7wBUPqHuIcXg0ShB/ZZrYNSRTohx71x4ifukyEcT/XLp/BXMamVEnDxMwAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXTQf8p6CEtPbrQghjopZ5IQbvcoxtihLBr8HxJbuqQ=;
 b=oW+MW0Cmf8KrhOH7iuaW9kezLNbQeRuG0VuzRtead6yOEJcofPEqfQNDaL0LRAR5L8oN4iqA/geR7c06FgktLwyDGT7jN50JEHTA5etQfSNUeTtNFA5mdw4QM7+Wt4/7XwQo1IArdr46i5mRKtdOj7y6FPouLvTILSOOwg098nxjRbQ1FaBZDTdJzulNbt6IR5Ue2zp1qbpKfYp1ANuQLhSwty+u7vOKZKd/BgtjjSCC/9nxHvn+6RRnOMHQ3A/tsMP1fdgc/qK/J6mjgEOP8LMLCWVs+E6F1+BWoIW1DMUwd3nqeJ5qjnYtNkxkT+yVplSV3gCuGHkwJ8+IXHfZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXTQf8p6CEtPbrQghjopZ5IQbvcoxtihLBr8HxJbuqQ=;
 b=eYJe7UY6HK/CRYpBXKfyUb8Uq9looSb1Sx+8UReoYn6rX6JnSfu7ZaeDLvjiBIrjAObthUOFUeDfcOvxi/uBxMpBzRTXqydVGHMUq6bvJ/AfxR5DUAHaQTs0sxNGqxe02LCI8L3AkGwNZ1792uTNKcLHY1C3ciyTGp626q9R5MCQbIkNzWSOGKsQfgQL6wJeuGGaXOTfmAP6kkAU8Tf3n1FEZHmFrUl45iviFEBAJOcDb+E4dp8d5BYl0u6X64Aabpv1S1d15NiZmcv8aFuuv819NTavGdGo1DsmA7cAkm9idCayHkwnHNc9X924VWiosdFQDsPejS1QFQNAq+MYsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:39 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 07/11] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Mon,  6 Jul 2026 20:29:23 +0200
Message-ID: <20260706182927.281078-8-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1bc96d4-82f8-43c2-0df2-08dedb8c89f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	t8mgTHFoio2MRRk5FNoNflaJKniLlJARt+C3D4EFxKN8+pO0V8Dx1X1j5Cd8Q8gPNJNLxq0D0bnarOA5VqQ3RgmRdGlHm/z/4kgqcMvd2wCroY3/jAgEoBRy4rQbBik/9FNAe9L6zjb4RoZnJyMAAw9yIKcO1qSBvJB1yYz5zUzPZItMcP3vB+AlKuGDc8D0CbJOq9fFrg1PfjidOUbH/b+lBxge3JMTNumU9jno1HxuGXJJXMpOnCZVvoWZS94bCmZG9avpQ+knqfXlhefPXkKhsuJP9b7zeG3bpBo/4BZSuz/fDdl7fEnhaKKSSIM5mBut3vUj+tlKjqLi/bOoxHT2gKF+11LTQ1+6r9rRTg3RiAEH2FPUj0IH0A9a1meX8XcxqjTwGNH4PQNyarIjw6uhErgilbMlJD8EEZTJ1rS1zMSPZSbJcEhZ1Rl/ewuwjwJkOOXcrS2A4U5SRInuNg1vCoCQAM8tPhAjac/qCiZ2lpVJcUBwv2X0NoxO7G0UldGabr5o+czn6zGPfyENidEVZx2yPPiaZaSw/os6hg9ke4Y1ZPwaN73wnJASI86EwX+KN13Ea5VspKnIpCnr5ymKg6/NVaE8apgp71xTnTWnD3zTltN9sdu5hkGBcQHV5tVqgRq55PIV9oUr8ySn14Nkf7Iopjh8b1KzhS2s9CA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/h9PMZC7B0JI6Wgos9P3c+xbI3bHLuLGwqI9gIhV0M8M/sBLWANxJ2442p6?=
 =?us-ascii?Q?4s8jnV+1FSSA8wz6bek1Sj41J+KJ9CvLM4Mftrguw7tgKiJ7Esuibet1FbDm?=
 =?us-ascii?Q?OudoyHJ7pBb8aIB+TrlMwV6uIrrvQyaUr6z/CTa7TtILEzGfsb/YqQvDOduz?=
 =?us-ascii?Q?iZBdlfItR4nmNfLtE2HU2F18bLgCTc8TWrpwdaEMVIH/w21eMF9gMM+s6MpN?=
 =?us-ascii?Q?wlkQiva3ztYTgGBU+UXFBl95QWHdkrmx5cjOZLaDYBDIqMZFMx5OjkbQekyc?=
 =?us-ascii?Q?uo9h7Yu6IqLrlhFTxLNWvxW0T8qAsZWCUG/+RBbCy2LEl8cLxmlZhwIyF60i?=
 =?us-ascii?Q?pQH4AiP+NbxsGKqJait9mMGr/k7RW6gQZpJjBkNZLxQx/XL54p6DP4Gm6Ry2?=
 =?us-ascii?Q?/TReLYNo7ikleg7SuQvoZq4nnoxSjfndyMSeFr9vFcXdQyPDLts3A3LtllmB?=
 =?us-ascii?Q?prPMR6C101Cb5Zg6fvBu1GIAUC8faZ6VWk8S0Tb+b99QMbCfDwTvUlCaEo0t?=
 =?us-ascii?Q?R2L3zyOAlubGjGeS+p9ExwxMb1KZaxWafdlZb3xqSu0XglpqxZ5kE7XEmmif?=
 =?us-ascii?Q?j2RE2rJyX70cpR2Z38ddlYKfwJzD1V4ndOCnVwL95gKwKdhsB2GIGN+KOJ96?=
 =?us-ascii?Q?kOwPtLyxsrBxuNhW91PBdLKfwHVeoeU88e44dmneeCocsHNvRYqz7+qrriyf?=
 =?us-ascii?Q?IfqXm1LVi0/0+uF54R0KU8JOL6o6+BkuseAny1zlh3Y2BIGszLfIgyDtbPUr?=
 =?us-ascii?Q?nBAby5uc9CGUG3O6PxZAUlz+x4583dNX7/CvuDhSlsVpLM+6vXdkfcds5yv0?=
 =?us-ascii?Q?0tr7n1XMO6ce80FfQUDbjJRvYBq9aTE1KZ2vcEkT9wxVSvU2OoOtnoG96fqs?=
 =?us-ascii?Q?iBRtRMitZ/TlkW5G5rrnH4zq6OAzGQOPPHf2QBMYK1bGO9jPHD4QTXJNMQ5b?=
 =?us-ascii?Q?a1RstXEiKzF0hnlj6KXN/7H3Zg5OK+JHrcvSdEmYplqdROEiZsWbXGkTKEj/?=
 =?us-ascii?Q?ZtvcOwnVc3baYy2PzB6/0AQyH9jAB1Trsifdi3XxdHTUi/oa6DkN+mU9qK3P?=
 =?us-ascii?Q?tJb+0egUppdzq2+hUd1gWNELo4GX6CHRyXCzpiLmSjdwB8lLIDsbzqYeHrtu?=
 =?us-ascii?Q?HjcsL5ZtncVoST0/1S/+/i0EzpYJ7q/XgenpM+ES3L+6zY1SewXsIQrh5eXR?=
 =?us-ascii?Q?YjyLwnf5PeDLT7LxiLbwNU/Gpo081h/1S1kWIcxe4P5qUBMUrlhgTsg1H5ay?=
 =?us-ascii?Q?dw3qTQxnaze3QwW546HES792i05zrj/ml0r1oAVZHeUoz9pMdCCBItRahRZU?=
 =?us-ascii?Q?sqNuhxpRO3kcSkc4P1tBqLUf9W/mOOTljLe5sPqtz6z0H1Nzd1kiQTiVYhxT?=
 =?us-ascii?Q?mvAv9/69OjWbhAYTPf2OYy5E0QCWFiyLA3kCCRIwXlZReixyNMPLRViyrVpc?=
 =?us-ascii?Q?unthggQtYoxPTNN7G7icpCp0AG+f0zasKmpwWQthTp9tBqzMcKE+3qDWz0UG?=
 =?us-ascii?Q?NLR51VpLIVJZA7kRs5TMJz9N0bw1txFq2ivqC5T3Sg6dnETORr/l+yVVHsJf?=
 =?us-ascii?Q?nwqTGXwrAGKasuV1aX71KiwKUA4b4MgqGv55izoEGcznEfpjMWHjt0mJcooi?=
 =?us-ascii?Q?dAv+/MxAcKdYrqPvp5SNXry2VMHDStkiUrkuKc3eAxnOtDLF78Qf4Tef71u1?=
 =?us-ascii?Q?/O7PfgV7o82bN6vj8NdGZGpX7vDOf7/2NVuSixrCokJ45CKsCFtKs4ZpX7Zd?=
 =?us-ascii?Q?XZ4LOE/xbHLOvuMXCeKlOeANtwTVshFpiahCEL362WQweOOqhh42IZp55x7/?=
X-MS-Exchange-AntiSpam-MessageData-1: iLmT2XZjFVlqUYsShZP/xEu58QJtLgOOht8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bc96d4-82f8-43c2-0df2-08dedb8c89f5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:39.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF6fVBNQZ/GnwohOcHhOXLvFuPSXeYGJDzv+Cyp7cjvrJoCvoUZj9jb/QWABFX6g/qBETxdZqqs8qFlhV+d+kZwdEcf0z4Deqycv7hQg8a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

