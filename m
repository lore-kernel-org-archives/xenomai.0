Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AF2BEFFF
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459737; cv=fail; b=HM2CLhG7pCJeqYQSvEGxaNE+65n7eaEgSs3ztzNZzUFembGNI9WmpGsCraprdfSPE//7pysKSI2Hnwg6lg4/zlipIeeM0uwviZ95hqKQ3DjVJFhIPUspVJR0aw6Piq50mC5HsNVn/s829BKDbR5wLUG2vh/hTEapZVSJkgusAyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459737; c=relaxed/simple;
	bh=X4jvMFxOthl9BNbditVzefjy+cdEpKUtitjpTU0Hw/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHDNC8k2KqSENLgI2ZaolYbpe4W7U4MoZ9hsk6OQ2CkdHo/1LEdi6X0KG3IkA6iGKVqMNGEr+ahCzN8uK0ZmU29/cj3O8rc5/XyZvCRvm7Yxu4556ePyasZtOl/z3iXhb2RjPnQTQnl6bbcY3pQIQb6ko87t4W5wkCes+75d0MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sfH0She4; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sfH0She4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5wHAZbg4OGtJZqChrFj9U5hnWIObJsG0SBBJ8JDC11z+/FDq6GIar5RGWuDbXUXVGQITxP8UPmllMEqsnjwZ9mk/UEEuxI3p1FOI+3dJ9pwM3LP1nCt7IYPU0P4NaLwtlKzSDBul5K4kKUxkGh8iIqjIEe+HA6NSi7cLM1Xmhviin9zlu6RA1v9xD74NbjoPnIxPIouupohVhBZX483T2Z6J0QHmVSajhLsFM2Bipr/MhGQwuZ1HM8jOSUg9vCbxYNvElsxceunlBuQghsMIWkb0YIQnczwrfo7ZIYfYXkQltFNK9pW/dteU43F6UWy9ckn+V38hpYE/BqlUHNS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TsOAEvUcqONhccQU8dOunBAKIt102H9FDeFVIlv0s4=;
 b=YbS9hh8r7PmPftfNY3OKYTewxJdAs1n1yay+eytblN6Nco+pDjZWNPTBzDh0O1rNJ0EVkCzC0Zrq9nzB57hDruqdPKKN42q2P7HCBctGq79vWiv2UHw/Z+MQkXht4fXO0BfkFcVsoDdUUzKDpk25O2C91AJNYM2xkTc14gQokGv8qGPZ9Hx308JMRpHaSlT+XAzOhBUqW1UTrL5WOtX+LiHEOMpTjY3H2msp4d56kp1Rlhp8z1xRbs/H5Du37xc/27XT5rdxY7lSEbPOQLaLpywk8v127qYC1T6qn2hLUKDq3oVSYu9I+o+LF2tVxpBSat4oKukwokxqClmLVZC+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TsOAEvUcqONhccQU8dOunBAKIt102H9FDeFVIlv0s4=;
 b=sfH0She4Yep7fQVPrNvWcJCEtAndPFQdhA2Qb26/JOPzly7AzCV+SnkhsrDDdz5BBIy43sL/2Ej5YczNCbUdx022nDBlMqrjZBs5cEI18CZwCoyKRm3tBlAmmCMNPZDkIxXqXAsJUow61SniOtKmkPBi9huNmfk8jk6p2GLEyClL8vz8UUZbRB7HUpo9pI+muhN7ZYd2KSmCekOzJVOBZs8H93OoH6H0A/6AC6nuUlOx8DJ3nGUaPKxqW+hc+OnQaElN6uIKkMvtG2ASxr4btYRWLgAhBUuh/8oTu+H+Ud3DJXD4TsDTw5Dl7riSvHkF+12XoSlJ/2CwQedM30+GdQ==
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
 21:02:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 07/11] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Fri, 17 Apr 2026 23:01:50 +0200
Message-ID: <20260417210154.2290819-8-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35219194-f03e-4ade-3e9b-08de9cc49453
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	odacYrlFI8Y5bHICzwwhaQZPQwD5gaD2rswg0e6+gv89Cdf15TWRPnRA9Gn2HEW5ZvXld7tNUadAcl+haINq3MOO1O13POdsCJ7N9seWZY/eQZ3Zui7t780JoXL3rSN7W2e4YCBEbq15s5TKsdFan8LcoTkzkDc/3js2rKJep+ySUStf6JPrRG6z4/hw6691gY9zGIa5RhlLOir0BgD5TDpjkmLuPhjKSzb6uLqftcZ9eUVhatb7+4Mw8P0RmUrIEPi6zx8afbor85J5oHZRFKQdOnmidJHuIVJGlKpnIZ8eSDePIwWtmDw6Ri/C9Lvi11/7j7NQOUzpRiX3xMTb8Ozb5XRha2DtHkkndZw7FefxrbjoxbXAUH/bkSgA9y6bUuluvIL6uF5b1A9BAZHxhLlFqV9w6tFFNNziYKRHOr9sOJ2+oB6qbNATxRZoZt+WCu5uoffsz/Pa+eksjtsXJNEWd53sve8Nlo9o/8o8ILwNsFvzmXBtl77JxRxrk46xVepRggD22M4h9Wrw7pKAwM6fKucSDGpadwKSC0veE3HeruyJbrBLpfLUdEnN9j6XDbPVmHUFHq2T4TZ5GJOT/Er3z9pfU2uCyeN2jxrz37xLefpTwDV3xP0PbmX/i0icQO8sDihyEOUGTY+ur1MuHnqdFzymvUeDzXOtlSCq13fbWjPSqtVgkwF8X8MEk3eh6FrVihKqL9QXgI9f58CHWnbqlRtv/sVwc+YBWjZehZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NI/lOJdWPeyVl6/WRFiEGj5UCYcCrjoUPF+ZAiP+jcmj2KXTj/RaiVdTDcRB?=
 =?us-ascii?Q?L3yN07oGTAZGgjz4pcLzSKIREPmYdnMHDnnLcsMnKJh6YG0cOEHnOB1IUrW2?=
 =?us-ascii?Q?FKO5qdnbABkBfnfRtA52seho4sw122V1vmjhppe9rDe1pvKkCwEzIrMkW2i+?=
 =?us-ascii?Q?M0IOpe6R+kdLKbV81HHuxbeRsX2SACtbzDY5hoAiqbclFZHXrq/XckpWl6sm?=
 =?us-ascii?Q?ZGbU46FTV8QF9WdwGH+KgtSJhEz4JVrce/Vql1YBMFCxlbtcMoOfuZeP2ouW?=
 =?us-ascii?Q?oJWA5RMgM8mdXmIX4VSPJxWot6QGAXz6b7JMuqatMM/sEG/4/xFe0Xvv5XoK?=
 =?us-ascii?Q?rJOY5QCJoUH6NHR46wcGv2wR6oSJ5fFdjACFYuYO8+qxyjGUZV1+ZxKrxWq3?=
 =?us-ascii?Q?MHlNAh1Oze+JyUOWbC5LfEkT+fEV9ofJ7XW53RL+fLPjELt1IINCebX45j1q?=
 =?us-ascii?Q?6jukH2i3/PgsvtuFpPnObzqKzU70jWw3AvGd+lIHzOspldv3qMrhBZXuzKBw?=
 =?us-ascii?Q?vQf0qD1wTwDY8Eq8ryBsac6fwOQ/dDyVLMMcRR+jduhXti+adWmLvYxHxsyU?=
 =?us-ascii?Q?8WYegulRD1wEmUKIlFq+j3pkszkYIk65ei7NcJ7Dl6tEVTY7EsImPuVUDXgl?=
 =?us-ascii?Q?1sNJlOol1sfplM3duEET/Hu1o5Jj9Xn5Y+mSLOA+Qt4aVQXQNP1z+bTeR36k?=
 =?us-ascii?Q?yohu18u3yDiGgXhwvL1xB1tWFiDnl9PezsZfH2ohZXUnajtXuphzK9mKep1I?=
 =?us-ascii?Q?kuPSL6Ta/71UdsojHOHEaC7hKXVrzyhVSWry+IpCb1mNYoQmCA/nanWjUCuZ?=
 =?us-ascii?Q?O7s0E76AazlyFGZqUbqMosyldQ4CgEIf/2yWM6tboi5YWK/7K6Fq1K5sZ4M5?=
 =?us-ascii?Q?Zv3UpQOA9O5+DV77+mDSgwGEf76oM87syFbVdyOsSwreYSUIqZbGSG2bnSPo?=
 =?us-ascii?Q?XrZlxH5bdxFLNMRvYMBxBZfC/1w4/VapKLKwE4v6Hov7yPFNkQTk9WLTIHzF?=
 =?us-ascii?Q?LREgWKlTSXxfOPuszPt+extE/Z2u+0zn4HhhA8TerUYGepoVfSDJegL6g06G?=
 =?us-ascii?Q?jJhVwGs+HUBggk9041TNINm1Iw+uRZTMlFEbKB8J+EUq/OcmRkxSB7Sk5C+B?=
 =?us-ascii?Q?9uatXsXwZo2tZDRWyZVtB164xIoYxZ5FOGkJBZk/cgGLtRCFjAXrTuuRxhhH?=
 =?us-ascii?Q?lU4YMlBpAFo/nw5MlztRl4sH3+/XwRfmJKBMejO2yRjtbqc1QRepcwpMHs0Q?=
 =?us-ascii?Q?mhrZP6KYRYEbk9kJeXG5pGQuCWPszErDsT4O624K/E8l2IbBF0LJmyAFSeyW?=
 =?us-ascii?Q?4vb+9plPEGdqtHenoKNmLMDOnIloH1+VvfA/tUrdT8hKa+ddM+Pea3QzQYpV?=
 =?us-ascii?Q?qFtO5JRPE2TCbJik96oabL6WlpuIAdFFevoPD/7wTY9qkVU8qx9Q2Gh5fz1a?=
 =?us-ascii?Q?uKgr/pDP5uWQE7UnUsgmUtbT1fWVeqhayvwEpLY3Radwejkrf/U5bjdsLYHf?=
 =?us-ascii?Q?wNtUDNso80uXHOvCIk0aRPCxBgJ6Vz+2hEr4MTP+LcXXR6j4IvslLx/OjqUG?=
 =?us-ascii?Q?X1Xbyc78KQcrFBng3C4JhfwnSpeb8/SGUEN3H2gEMRVGI784GNnzkIf67P2t?=
 =?us-ascii?Q?z1/I0m+Qc5A9PWDXMRAZGg8h3MiHkO9jrRlh9BNokShoqyL5BUbENb321ZiE?=
 =?us-ascii?Q?ByC+nZqMG0DGuybYD8d0wD+0cXQjh06ocIlZ8v3FkHWQjX+Iu6RrxAfPb7BA?=
 =?us-ascii?Q?bZdSJMEN36kXxxZzwz20TvbcSxxoBCQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35219194-f03e-4ade-3e9b-08de9cc49453
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:05.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCkgZVbTtR+jGnLoKmv6i8PFQ8B72GrUseKhLk6lBoS0EPGCV2Q0GuNyhH7WdVzRH40tQ2U42+nHF9aX2h1TBe2oCq7qBHLBf1AxqVdv2Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-sifive-plic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b0dac1048140..e9ea0c86366ec 100644
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

