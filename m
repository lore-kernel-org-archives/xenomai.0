Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5013C0A0F
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492090; cv=fail; b=jcv+xk4LlOhfsGmKiOk9+EnKIcA6dUyt7n757UsY0fRvYCfMs9qEdL8uMsvP/HaMgtVJ7MmsFoMoO3Qm7c/ddUqbARwIm+bO+/7eg0WJvM9WszWwBg6o6pNOCAGIBm5TybaybbVcC5DuUiAPfMF1LoNXRncpi7zi8WOGBnsYz3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492090; c=relaxed/simple;
	bh=Jn+25HOejs2pmW9JQrFFo7EmRJeVU1Q7u5ys6wNKErk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XoN03r+aBi2LsMU4Dk81HfL+UR5vNuwUBZR0Hw/WsgIegRkYZqsGD9Gq8kCgBTfPcgRcBUVzeD/awMaTKhJ4PE5h2E++5lw9Zt9lYHcEBiUjLTPYrvjKKPRXTdKBCEeHbzGTPjC1i396pTRCqS8sabhENY3OnvBWh/DkYVqPWLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fepFRhbx; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fepFRhbx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCAbCQNKwISTkQXd38u8iqpL2GIViwyrD/9qZxh8YbZxgn6OLOykMQMC9bow1o2woSmnqcYvDYLrO8yYTVvBRLtQ2K3X8V+vGmXjcf+egfZG6FaAOPM5Ve46hYS5BkHZqX2wp7riyt3Q+KDoCz+dg766HlctNvLSbmXONAxQjfkw0MB4Z2loXRi12lRfVMMpQXDojQwLSAnwDDQnpOr+zyhqoFyS9l21MI+PQne5go7ut66D/vuDzaSa5DYjdAj/C2ThF9Jo/1R/56Y19gxrFDX+RAVUemMHsnhg4VTxJv3VFi4PhE4d/GOv2g7tjo9gVSAu1yZErZKNiVQ7ITtWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXTQf8p6CEtPbrQghjopZ5IQbvcoxtihLBr8HxJbuqQ=;
 b=N04wJnL2KseQqXQQZzkwTLtNaDqRFSPShc+z0VNLpyc8wZgEyJpisSxuEjb5YaLl1LtNzcSQxh1Wlssc2acW3C6lHkjAwqUfeIBi8lfHbQ7DCzHVLKYbiZujuKNLgTv9BG7urBQRwA47mpv+bQqkdyeVQh25KGfvMCKtvnk42tyy974rjloaoQZzzTFvI32D28O7+BDi9n9u7oJr1VsjBU509jtgK3rg1WpF6P0I2BbC8h/TPdTGMziaAuLtkUghjBESEA1fh5RTSNzWn/b/AuXQgo2OhOWJv87aMnXNaIAoSs8q1yiz8HNpUN+RsLHN5AnWPz7mnX4ELlmzkgAvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXTQf8p6CEtPbrQghjopZ5IQbvcoxtihLBr8HxJbuqQ=;
 b=fepFRhbxCZCv11LQamDO+miKHRRnENc9LgRzAszWn2wbDJ2i+Y/VDB7O6/me1SHGvQTdy6jbnF4nh2RaCVLMt/OTLR+tkjd8rUH5rugNtz/U12pKMVDArZwtkUTjw2garthpCoTpUeM3SGE1xDGfIHe22naQU18heamLRc3Huud7Eo/fckmGXJKGJBZrdtD7lvAe3ttjLp+2h6IUv/9p7fcXascmjgMSHNXuys870SEGwKHzWBbwB2wJDkD5It9uO7YZeEQfse3b0ZL5CNTUvWivzLfioq5EdujOi/mkfdikewFoePaorfa4zlLa9r4L5nHzyjBH6NXO9Uy4YA+4Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:59 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:59 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 07/11] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Wed,  8 Jul 2026 08:27:44 +0200
Message-ID: <20260708062748.1029852-8-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80fd305f-c788-4170-071c-08dedcba0dfb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QyfYwD2yr5URQOdAeWMZj3Ohsl0e0xXnkepll+lbnqiUVzviYWrVgR3XC0mZ98V2M3tZx1F1Z1WCL4GUwhpKN24IUYY1h3+UOjnpoFCQDuCk6vKNp7YaTZrLsMiHiP8/GBywKT8it0MylnmdD/osmNBPChnOscIDPNXJi2JBNpCT8llCbKCh2oimlBQtcaQY9fWL1jM1l607Htm7+ysI+K/eqhktrI4zv6R+s5Sy3YyYhXn2dnUhYx5Zp+otJtZpea2s/oebDoky/pZjUQYa+0ZVEejZJzmoQ2KU356wOi+rSXCHHW2ITtkN0iy2FBXPpQR/x4CkunbswGB4+0wuVl3ZPphjJcE0L5MVLz/ntbk/Xo90Atx9AHqUsoVNqdu8utaoSCl/HXjKSo3Z/UXyTWRodCz62j1E7H+LZCBQBN+09oZYivJYDWIBUf9b1nKc1kjIiCilJTqJ/uG57ULYyrwsNoFW8Y/msYeieVrc7hKjtjLKShpPF5QcBsKWe5ad1SAvtFn1YColLoxrcwDCtc3E+wRrI7KJNANcxttMn20u4jJh2QKkMh8w9Cyzqm+QyeHBei3VfpZqlPVft1WT1nnVfr/J1PxpVq9d9fT/m83eu2fB8OhFC8U2+QkFrHW7HoyhRFwOZdr+QZfv2HOqjVJc2mG5+S+nOfuM8vqpwWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/9JRBjfWmfq+sBgCbEkow3RTOEPY/0xozZbGL6zAHljaguf7MpUqBrfZF44T?=
 =?us-ascii?Q?OE/G6A3BGclQ4YZRnkgfuPyYzFzc2rJJ7WzmH0m/sGth0zMDsApJPP7o3c5+?=
 =?us-ascii?Q?ew5mXndaPmsRjBXMArCAiXuoE4b0ggwMIeg+cu+TclJLNydxJ4PW6vM9pR2c?=
 =?us-ascii?Q?hKO00qEO0HF0cTsPDEoCnDpIRc3BZtsemZLG8ViYwNgu8RuqngrJD8tqnO8w?=
 =?us-ascii?Q?OZKQ33LeiCPn2DckQ6FMw/yIPrU+n+i0j9zoAXZF+3G/NZ743xn5wshwR9v9?=
 =?us-ascii?Q?yDk/971cfuqnESvQ2qjef6ZXn2Sfk+4M1zAKLQDLF0vUyevuJHTqZtTrkw98?=
 =?us-ascii?Q?nYjPkXe8tJ8grlxqurSTfYwZIg+Kq+QC3o3COJVLz6qohpVXTJGK2nmUfF8e?=
 =?us-ascii?Q?V6LCwp2s0L91/8MhLm6zTX2iae5ceX6Is20eAbzeYm2SF/7wM9KVur4sr4pI?=
 =?us-ascii?Q?EFjMuwoFtT3VlB8NXM97yqAI6qqvpereE3bCOUCd7u7DgHlo+rJG/4BllQTs?=
 =?us-ascii?Q?DGjFwdBEGQVuFytYo3E4Vy/MuiGVoAGJ3QAFoEo9FyapntCLGN+s5VLzsbxQ?=
 =?us-ascii?Q?xlEw+3zJQc8aq1rdkrcagfVTqhdBxl9mMCZJ0zq8qSGnTOvVJl7+1wukN12G?=
 =?us-ascii?Q?m68HzNV3fIbhFX24/RQXzAZ/PRwRFUNVbI5M8LArJH7fj6QWpMaTleLQ/nQs?=
 =?us-ascii?Q?2ePKkPcLj7pTM5D9Jdtdz9Y7kSUExKtnsU9Q7gsxd1sBXQPvo0DtzOWw9mVw?=
 =?us-ascii?Q?qfHIngIdZvGtvYtDAw5qAiRsCY258bMjtwTdmiptPm94raQ6lVIVz/shChOt?=
 =?us-ascii?Q?5v2KZYeIYTucNftAxXAGk+LDWH1ybWCl7LqRSODTi0Xrw8Ovbmu15Ci6y4dR?=
 =?us-ascii?Q?9aM6mfSFn2HBTmhuvsZXggE5xMsOGPv1wZvP/k9Bd5ZZ2bhdy6eqKkaycbLu?=
 =?us-ascii?Q?5c2kZZRHysKH/AsEsAM8tVhusQqZJzc7CxNmslMkmvTeOdKjd6+rIK7p3WRJ?=
 =?us-ascii?Q?aNXCbfw1Wce5vjPEitmYoweCg2YGJmtYfHf01OWtEWUNnWYJOx2tYf2n756f?=
 =?us-ascii?Q?z4Iz+Z5kSD4W3wxluaJ1rNJ/uYdm+9ashUNp8QzXBgTJqPBa8YWMTnUal4+3?=
 =?us-ascii?Q?MhnkAk6Hm0hHtmNbOyj6iFx2Glolmvh2nAUKNyICXCzND7DIxTglaG5dq3R6?=
 =?us-ascii?Q?6Osi4GpplxSolY1S79HVXofkVybAWWwlJOYeidScoyzCgKi1g5zSjcw+SdiG?=
 =?us-ascii?Q?bTpn7CG94sgdnaA35fS925u2wAa8xafCsilZG6bGTqddiprV5Qi8uwLGtrMD?=
 =?us-ascii?Q?lH2++xiKu4dHhmUE72ZJPbLGK1hkK8ie149cVYK71j/i/401ylBOazUnC+DJ?=
 =?us-ascii?Q?MFgqpScFU/B2ewbAD7G4yvK2/X3cz6DRKbFaLoSRTXeU5kBSl/5z7m2DesyE?=
 =?us-ascii?Q?zVvOFG8it1vCQRFyQfD+zr8YSH/7k9b5x6wA2Aee/D6z/B8Uk8E5cXIqQasE?=
 =?us-ascii?Q?5mb8MxKiZOgLOLuYhgXBCmjf5dK3+/DBKegzBWKKfBw1Jf2n4+6epTa+pKQV?=
 =?us-ascii?Q?uDXE1r5KTKDchg4XMzNnfixhpkRxTDyyZDuRtqqzRHY10vZn7VXB0VZI1MEA?=
 =?us-ascii?Q?mWpv1h5Q0XFFVfh++DVmlxASaNktipxNdrlRyBDxUbCGIXEflZSt1NYQCAt5?=
 =?us-ascii?Q?Ik5+W0EdzRcrWx+mle3tSewl0rWfAhdNUnf8A0aupkjoAX6z2bxS/De4nIqI?=
 =?us-ascii?Q?8QB2lz8Cx+xMERlFjKYH9u47gBJS/PT33hvxTelE2YOD7NZV6ZPWKZA6wX0b?=
X-MS-Exchange-AntiSpam-MessageData-1: 2xTjbHcJutY6cbK5hO9otDuOdCCwZMIgYdY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fd305f-c788-4170-071c-08dedcba0dfb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:59.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AE31ANKepnt7Pl020ILXuVEmLu7xKfqJu7rUAUfs9KO5k5B+Dk22LPGIj9r9c614jVhhS657kz+HJrqkWZCrg/LRxl5klV8KPpaJaLYd3Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

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

