Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4B3093A6
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206803; cv=fail; b=CG8ergmJBHJF3o7qWjq/92So85Pkb9IIJzzybEs+gsIVisRQl8DDpMhcpQstZ4/haZAGG+h+kuk17SkTG2yLKeYK3jmVioH6GlIwohNELYySvCNHMiWDwnp/TzFA4LEyz+zGlKFQKDbLYzTapYF7Agg+76dwnPt3ADJJRyqAMbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206803; c=relaxed/simple;
	bh=YPYNvUhRctDSJGE7GHjNs5Z5668S4zp09jgtGXDCBO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjXB6WntkMAJwpYxdlJ06xy4VZV2zu0MBCzJhRjaY1bhbfP/W+3O6e46W4eSMH23LPLHEXZ7SWGjlz2eAspbd/Qu7SjcDDGW+5K2lHapOX0wHfE2gNnXSF6LiGL/g4qtvF6/+9Ct7GGQWwW9tYl0YanNEKGKsNgNV8XdTBX2HuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NAtEMk1K; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NAtEMk1K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs3fdmJ16ISSq9HaUVhexMbLVVs1DGtKNVeZO0Ay8/ZxiNW8XEAbih/KomyodIc7rO0k76jWHSv+J4t+EE7wYSEpFoE8abd9kgPbGQi9hJ/z2faTbKbONbwfcs+nAWLzpg5tphiNUXaq6AAzB37UcMtfyQChPRjBp5s1zzhkXAsBKsjMzlqJwt40BAT+LA9XojGAQY6bkZjshcAYmNJwfQFoHJ5+jr67boU9lt/5VbpF5Y+WVCEpSU6tUQgKBUypqsA/+QpUJS2HLplR+074nc+dGOFLZxFd+8MSGTuC5y7gwAHKreHeKnh8O8PLdvcoMmffERwXoBp687joooWdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWOVY6RJz7PdiR9oGetpNbQJBWMuJ2etrFun8MGoi2Y=;
 b=trPHy/exF7l5t2zTFr/Um+LUG07l9/4aAMzZlWmAbbARA90vRoBdKb3BQ2lZ5aprR+u+sQJTH+ydAn7eS96bwLVokvU4OAHoIF8GFPDJvjtqMDiWo6sdsiQb3Z/CZRV7YE0uYz4MxSxwHOxTCOC24zszni7GLiMLutK9+/wGrXVLicv9+PodiAkZq4HQFa9GMs/On6WmrM/z/+c7yL4vezhGlReB+cYQ5d82nozeM9pz4o8QWmw9ji3tj2FZi/6hsRpEkohd+8pBZkIWRJ8byZeyXSGWWebvtevWZIvRYDkGyXHWe9MvknzeQvqqvjFqh0U7TL1KIg+3zC9R0hqqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWOVY6RJz7PdiR9oGetpNbQJBWMuJ2etrFun8MGoi2Y=;
 b=NAtEMk1KVTjMTDNDjAbMTA9LRBt+E7DLOr7au8ls23jcy+IxWnnG07hYjkyrp9VcXLYrSkGRRB6cNs0CrH8/RdZgTJNPxKK7jxV90wRMI61b7sortacSWYMybGbuCu/m38Cedm1Y6KEgQYdA4ewKf4BZzWhix/3Ebg6VQokpQMVNLtm3qMhbMbmK3z1DrfuISEbqig1iUB7KluD1OioUWEGVIigVp0+GOio7CEMm8SByo2hR1gQsLrVR/ENTopDCtSz5vepIiCxkyhFa1JFbhKllFaQ4Qd2e6d+ZbqEWgVCVFWnexjINgWmyHvY/TNvaOD67k1WGCOd/auS9oyiDCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:15 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 07/11] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Sun, 31 May 2026 07:53:00 +0200
Message-ID: <20260531055304.2890455-8-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 196cab5b-90ee-40ed-8109-08debed8e86e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	iB119EPZcOU7qIZQPSp8FIMcrgzHL/yW8wmTrV+k9CqXfyVMChQcdff12sV1nIHw7oCgcERx5uje6ohstaGdqugpZNaR2E12+4pN2nAfoM35UXcuOylWDQj10h/B8S9EAqXoaVeMua0g8xtc6d8lvTZfuT/dqwAH/cL6gx81xOApMeYq2zrlut0RwMAW3frwaVGdsLl1fB2QRUzHmIfd/0l12ycth0MsE+E7iglvIvIkX01S2OhvijkKGnE9PRL3kfJY3u4GVVLz7jkzzCgHEiiR6qOfytrKxr3thykljWBVYHCRebKOsxhX60ytgWsCnJwKrxAt6Sn3i8Igt0CxutxG9xw/STjf+i8EwQMAUtbrltJHjnyQaliCIlNWCXQnbK5gsDDPttjDDMmpm10Lxzx0ipuHvgqFE7hr/QfNn7xLtWQ2CASLgws6wz84bNY174g0LwzrqeU6yKD9w+9ugxEgtEGDDWcv/qqJeRYad/+puHM6xqki1oEHVs+PMbtWaQhGrkwrftJgBs0scnBhyFKugEpftPS57oaX57DYhrch+UyQ/gb6ZAW923tz/fH2JJm28U4xVColjj/T5oqiplDppSw09Q6yigor8dvA4pR1ieLreC5jNTcNyKnFPQ7gWG00YqPkbGcxuXgGtqy+ME63kLgW8vqf1q2lKfOlaVvuNopBxvieHJ9lkiWlblnq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JO8vcjGOzmdSbIkk/qalQjvTTWN/Ti/jEloWIZOLE9ttT+hi8r+3z+i3WbJg?=
 =?us-ascii?Q?t7Tyt1LiXJ/WbYY8+r8opNW1EGDpeuwI8Hm9UbVXdy04YXnRJ/4sSQxeC+ou?=
 =?us-ascii?Q?kG9h3zLr7dYMD0Lvzht5GFNC4+sIZYcnxxTASsHJXpbAw7RorXtQIjDk55+w?=
 =?us-ascii?Q?igQOxefNvrbLy+6rIIiTXoWgONduts21sEtC81U/0Cs08hVGEf6lEmaZwG2J?=
 =?us-ascii?Q?O2YTXmhWHD/gDTatj/sFgGReGhtUC9rp2dbP3p2iiDFd65T+vO7LKiJE7xD0?=
 =?us-ascii?Q?uhX784K2HwEqz6SM+J6ImIT5RNHL9jvSX2v6Yv/c+F+KpP2EY6MJ5aLvGC0M?=
 =?us-ascii?Q?ctWGUVVflGLWjfft/Gh3UV6ZkdH3Tji5tzI5db9pSVu7CV1iH775VioC7ktu?=
 =?us-ascii?Q?J8ZtSuceQPm7OXOl12Mq0F1R9PorJ1ftSb7rUcNmeGhH+WmbuEb6HdoQrdn0?=
 =?us-ascii?Q?ujuTR9R4bt9LSxsEbYT9chKQgAo9DGrPHCQwoFRJ9fUpNQP4YHIFA/TU9GgJ?=
 =?us-ascii?Q?VjJ/SXLz+GwhJe7YpHVHD8hZseSnjCL8kEy47PIsTnFb/CDNJVkRVlosoTsh?=
 =?us-ascii?Q?urW9Kozx0KIiW51ixGLp8jVfpInKLQbi0mwqtaBztGKVnIMbumAYuVEf0NrK?=
 =?us-ascii?Q?Yvz7EO0zoO3BLK1RXnzl04spJAcFDJacJT1ndi9KNa1ccEL7Wke32W0J6iN4?=
 =?us-ascii?Q?1qtjqfAa0q9M40lcy1bEnz9ER8OL9T3K3LEfc5x7TW6FQwY4WucXjlfQ3tTL?=
 =?us-ascii?Q?Wqxp/xRMtJCdQkUjvO7Ccn6k28SLSJKPIdeIO0RhTB7xUQlpcibCqf5iU18L?=
 =?us-ascii?Q?I7QKWAg+QA8ov0nlqFm0t0s9pXrMqb1ldvZ7jj5SYX+iqW4dw1RAZFjPZSDV?=
 =?us-ascii?Q?ySgMwe2Y4uOme8YL8fBzfsdjJMv6llhyDGKY8VomMXwG7/0LNAZCDfp0U5Tr?=
 =?us-ascii?Q?1F8hu9mjHkLWmcuMr5KPmYrmPEpnxIdZDI2QgpyfhJa2Fyk+bmoRwyK0n7tS?=
 =?us-ascii?Q?OLAS3R+k83whb+zGhJE/jsSDvcUhTiRgknVDZI94HpsRTnEnbu2Qv1BgiLuI?=
 =?us-ascii?Q?6AQ17KY7jIaAW85rj30EgNMka9o3XqsByrc/dPoXBzPIYb1t9vjkr2jPJ8Ju?=
 =?us-ascii?Q?8IE4GhZTBj4dL5xde1uyIfe/+pvssX9AM8raMykAmvYqg9ZSBoCHbumoh4P9?=
 =?us-ascii?Q?XVec2X/aXR1KQoMaCg9HfwkzKUPbzumHiX4wwa7vY9UEtolIZW0MUtXiTbNC?=
 =?us-ascii?Q?FuVW44BG0NLLzaPilbVNv/PSKqZgVqewsShehhyCXF6MeVFnjqgUypB++Duc?=
 =?us-ascii?Q?k/Dh/lb9hwBVidS2n+23Hv8w13q3oVh38BHV0d7RkSnK/EH/w4/6kAdB4DjW?=
 =?us-ascii?Q?HRTvx4PbUNPp37RPmTs5/iPetZmRwwhiJh5cy+zi+FPCslNX4FGAVOc2fvHj?=
 =?us-ascii?Q?9gXygu5Vya/JCKcD3F83Qskz5v8Gs9L4nnlXId3M9S4m5biPTTZWXZt0sGMh?=
 =?us-ascii?Q?q6BlVn6xGle/pDZlj+xgnZFrc/C86N1TMHYYAemdfnruXPjDQ7uUJuTn4NVV?=
 =?us-ascii?Q?klHZU5FHr0UymUFWIaODQXxT8Y6pdM9f/kS5zGm1wkTrVE7R8pd4cE57nkKJ?=
 =?us-ascii?Q?mzD4auanejlj12bJSezcwksizEEjk3KYpcpY0tSydYMD6qdtXcaqWiakzItq?=
 =?us-ascii?Q?V3HzdzBbvBTV3aucU2NCzXB6we84OqwvRCOCAxl4vM44H865B7bX7/58eMJ5?=
 =?us-ascii?Q?kj1wfm4zGDTfAYgQtgelVIVsf6MnZrg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196cab5b-90ee-40ed-8109-08debed8e86e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:15.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2z6WRBlgptO2Fg6LNs4eJ43V8ZJLjgSkHKAr9y+KxZeSabfL7lbtTGXRxEedTRP2G/sHpNHyfI6mQMFvfOv7hPOqSLXOcfxY9vbDJIqaAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

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

