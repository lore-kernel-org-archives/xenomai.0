Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1D41735F
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092481; cv=fail; b=Izcjfcd2ebY2v2GYhz72SoTbLhzRAzYuw3GP3vaCvCw01NOpnoJ54kHQ1D6RpECedbbd6KBa1mVjCfYuI/Ycwq61EmT+mg0W16WSD3AM6qWTnmP3sdFMiHQr2EsjpDiVMl5czTlZKS2wNqhtS2wV842kttSLOpy85j8FmlP36oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092481; c=relaxed/simple;
	bh=Jn+25HOejs2pmW9JQrFFo7EmRJeVU1Q7u5ys6wNKErk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Za76RyWaSg6FfTMKxx9aIlSrJEdW8h+qwsubRMNiiZPUSOSlJ/i+UifG23L50D4X+MlAwD7hCPbG+tBDoLC9U/oUUPowAX7N1FMZMOVExumhx1VGXCoVsAfHw8g7FkkdaSvKtPM3tIwHGMsfPPrGmfbyGn4TpAi8QwPbQJ6uqLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gCydyVex; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gCydyVex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo8DyQWebEALL/7j47rB0IBizNB6JBhLTIR5OX2bR0U4uKcrikPGfzOnOtEI2Ng7h4NScdzwB+7lR/HYaQo/5z0+ZxsRaKZQLHmKiqonuJpz5F9WwPWKorFFiUGgxZSr8V63i4w7cNy7p2HZj8Kq+2Yj4fXalHDUfy3hnNdqqvcCtJ2CsPh00yOxPy+A8bSjzp5sMcczSKBQ7CyIIn92mLP9qXTIpe1vPwjCFefTjhNyeOwB0GBxYZrMPZq97Kx6jrFD51+CkIVfWIOgmypR1r4im8vzo2/2iNRofeQRQ7C7Sf+H7b73DZut25G0nnNxsOKGRWKE2jqbYJChyqFm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXTQf8p6CEtPbrQghjopZ5IQbvcoxtihLBr8HxJbuqQ=;
 b=APJD00OVFpSRyi8tmu1CkchdDQ9ESwiWH3ddiaYrDbhYrITjojt4RReVS2sbC+yq2prhvioF0PhXXrKGKMC7U8VubIId7Zm1xH3dsp9FWHX6Jlr53uieftD6c5kb+S5UbW7TH8Oscmro1MDcccDJP8Q+xBppKmxSFfskjzawll2cW2WbLukah+4zepLHLbZwCS4Ayfei+NmgfMZsxusY/NSGqVcRw+x4thdQwlrpv5jc8HXKx2NFvyBv9HYG5srfG/H2+D96nyD/cjkTZv8vaEYg5U4FSzN+lSWz+uy8R9Tdivbt4ZdrSM6QHnxpl4ud+NFnwcqS8K292dM/w0tt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXTQf8p6CEtPbrQghjopZ5IQbvcoxtihLBr8HxJbuqQ=;
 b=gCydyVexyskcnYGZTjp1JeGjPiv2GwQl5INuW63sCZfw7eKgC/BkyLiaAgO+hRlcYoQbALvjAFO89M7W7ql2gxuoVuw5X7UrueYzxOLS2RF6B8025IsvhfU7A3fTA7VUOAOmHVKD2c7SLdqsYiYrmKMdAxPfQulVNeGJ3moofpFOXQXz9Tx2WNcEl0WhaDbk2YJewX7UgUX1R0g1+XvXiUokA7yoRWP31ZTjT8WwcVCXJizE6o+onKWCtVrIfusWQkBDVRQCfpd2FJ+UrcrmWI4jQ/Y832W+NwgKABmxAgP7Q3YxYFNgzMNoNx0RmsThmOU0tGSwRk6ePTg0tkeS5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:52 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:52 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 07/11] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Fri,  3 Jul 2026 17:27:34 +0200
Message-ID: <20260703152738.129122-8-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44b5618d-c882-416d-ccc9-08ded917a52e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nR44Gm212TsqONkRpAC196OV3ilLUTHHa/NoG+Tm9Dcj9cJgDddUVlTtVjCPI+BrDKrut+8aqzaYHFF0+zXcMu66KNX4VEe12AGVBnrMJdH1+rCiGHNBoNgqjmRw4FziRrpXSE+c5H4u/OuPHK9n8Y1a/Q8RL+DXer4EUaF0t0XPbAHe4Z+ZO+dLxWEZ/VSs98eek/7mDoPBbdtp3dGHAGnAYDWMqrufrckAfmhnSmBIYFI3qJrew9YeZlsD8gSzim8abZam/BEADKMwCWhoEVmEvAZoyoTnj8Jv8M+tuHP1pykwSxi26vj3/3aqF4PMLdrl+CYakVXZgNbi7UxMOtjxk1OsvTnsEsuw6g0pHrtPER/NnOHn+Z0TjJkbribFe+xlvNoADkDZ5WaBsNW+Iz0giNY391/DHPgWAiN5U3LCAQv+bG+B/ongFc0b6ythmZHnlIB1rvyNgRTbZiBSEQLAJE0Grhe7TKMDjY2Y2NqTeXa05uiYhGFDMU4+y04Sv/Br3k0n3Lm0lOoT9dq/u7weJ4MsQphC6YPTT62DpH2WDM3JC5l1n1ZBNAh1NXHa9Rrr60tQnDFlScwd+q1UaRN+PDyHzC6oMd+LSySzw1P8bkUkVns3EkqKUSb2coc0sT/9E0ELLVzj0Geep6B2m4+L6oGzKihaiCNMcjIq8Po=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQ7Dgrw9nTPARD8ydccca2j8v+2Lu8DtPUqBKzoar63EhfkOxlTCyZ88+Dv7?=
 =?us-ascii?Q?T6oQ3Hk6BQKSQbDLDn4Dc144/VU8G51kiFRsTCFfp2g8Q852f5YCk3u7Sfh7?=
 =?us-ascii?Q?IqXBWR5+rvsSqIA2JDaCdjIdhrZ9k9NUxuTpBKuLtOFOIh7xcAekDzBL6v/P?=
 =?us-ascii?Q?nFOSojaJjAc4F2ANzrFpmTRf14rDGlqWqDjOrAf5ikz/jpw7BVHfB+GzeBXk?=
 =?us-ascii?Q?DmfFUtim/kISuAPYuOOaXJgyjlXL8bBB2Mzp+9eaDKjfh1/eesKsCmCVtdKO?=
 =?us-ascii?Q?+efvRHbHgMtozxMLfPST5ct9eKLEu763Z0/CFvyiD2cUeUUHjCwW1HGDdOw0?=
 =?us-ascii?Q?E2GF/EB003Lj2zQgvqQJckB06MsjgVoEg20IkbTuqZGrCReCp+8z5P+01uCk?=
 =?us-ascii?Q?+U2HJ0OAj/zZ88fkKGUXuVsB31Id0oRRQAGF177PWFEKyaDMXL7TuS9YpIXE?=
 =?us-ascii?Q?CoBg7vOz7liKEYuiMWKGZuQJGqTIELEbDbRhZtRKaHAY3Uj4HUYOuxFJAGM/?=
 =?us-ascii?Q?uAvYJ4XZsO13IqBcTzVO6m/TFq5Of67lEIWLIzsGstCepnsCeS9iGxa8/8cs?=
 =?us-ascii?Q?VvAEvUqBHuaR1LhNaTDO32aGZyuXP2IfwfU5JwP03BGiuPtXGkmF0JyMLY4h?=
 =?us-ascii?Q?0MT3cTWzFUN2NdBC8bqECNt57sE3sD1sjnsi/SrYFEPbRHSFEw+gyh5BgnS2?=
 =?us-ascii?Q?/DUYNSp3jGuNdwGQenFl2C1VFSFR/Pge24c2MFJ4eidEQOQyV/kt+TYR8v7j?=
 =?us-ascii?Q?S6C12OOa9+YDJ/N3/fteGk9jdxwBsOD9hHzJcDGD9PkHARbghOa2P7R6J+RK?=
 =?us-ascii?Q?zZvJtTEE2X8aH83+hSBP+ZJZwYMxDjZs3ErUYI8GLSramFPKm9OTMO+ilWV3?=
 =?us-ascii?Q?gqtrsr9Wq8UzihD5LZa+sZYCh6hKa++05jNbR0QIlOZ4kX2UojDm+fsLxf3n?=
 =?us-ascii?Q?JIGeJCwrjnMiMhKhlalcVgyXADmGX3kokG5WsRsx4V+GSsnJ3vEjfxVGXgEt?=
 =?us-ascii?Q?v8kuHa/nWaQbvrGz3f0gFhvKhp0UI/0luP2tP3qP2vGSxIju8gOQe5QcJLqY?=
 =?us-ascii?Q?4WN/WvuM+cQekI8KpImbYP0pWy9En1FkoHxveFDDbi+7X+CEynV3+JvRAGHx?=
 =?us-ascii?Q?/TIUGDDDs7f7QjhVxfJfHIEX8frxlZx+u/YDAxvbGV6h+vrJxy/oGhgr419x?=
 =?us-ascii?Q?bNR79/skjAH2nLTjuwNdzVNDEhZx+xIqp9E1rG23OK+nW30S/kt2/Ovo86SI?=
 =?us-ascii?Q?/8FQOBvgXhYfY9TAITUnx3QOaltuc7kkSTVBW1BysYu3zNqyzdGG9nOfjcjg?=
 =?us-ascii?Q?4EoAe6YmsRqfJO5sPNZOwimGtUOHI99lKup6yWb0TmAKpY8OVu0gecxKxLPc?=
 =?us-ascii?Q?2kNH5Y85sIJL3dti7soe8svYfwFUAhLnn5UVAWuvLmxWqE0DbSduPYhvHB+z?=
 =?us-ascii?Q?iuWBhAs3dXzTb/d2h1Q6PxOBkkuT7IM51K0/Ra5NsXHHVU0POpKbu/CJXzTw?=
 =?us-ascii?Q?EGhThjWx4JZ+Nh3wnpUX5OIjr8DrcjhDKDF47CsRsh6+EWDEOaq7Otuhfkmd?=
 =?us-ascii?Q?EMEb33ADzb6nVo/8sULtC/mtucteR54ChDHGRWM/WfZCXxSnuFC495F38gMy?=
 =?us-ascii?Q?+E6ICGdcH73PpXzVLX3z+mPDdUq0kK53LHxkIQl5DLwqMr9Gg56z/U75T6kg?=
 =?us-ascii?Q?wWLAZTWECkNKh3wKSbJiXrBrQnMmrUVNT6Jja3D6YUY0V8K2Qbw/qqio/4bj?=
 =?us-ascii?Q?pGF8KWrp88Gfz4wMmMhzvVxMpp1QsYb7dXCIZ8n4oYUBvQdJMiy2PJfCN5Nd?=
X-MS-Exchange-AntiSpam-MessageData-1: 70tMJsZ+sb2pNMdKwsaiQ/eSjP1GuLk96/U=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b5618d-c882-416d-ccc9-08ded917a52e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:51.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAFlouN/kE4Hq+yKpVy58vH3eBGhGmxUzHqSb6Om5/dqnagIQn9BrjNzZyeLaOqVBIpJ1iZUxgIpGcPxIz8aLjn8Wgc39iM/AKy4rB7Olq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

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

