Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297B3E5EF8
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547484; cv=fail; b=GJkXFF3QxqSGzrj6DzXjRDp8LrgkN2h9ELvdKNhF9c4NklVzkNTIA2Kiy2nOvzWPqBdKVWFui0odwJpKKKhWf6KNkkaKYypyyhAdkIcdSBdhquRN6hDcsDAQNo7EdZrcP8MjFuQ63Y6/WjR2VBZyXKjLloDDO1njAq5uAsmdQQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547484; c=relaxed/simple;
	bh=nFro0Hv51MhrPgkbSrzbgjj0lgqFnW+OoXVjOo5i+mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QcM7M01ORCuV4EfWw8PK6AlBWGeDtnuhK9yAMmnlKgrPhUqJgOFcvR1uqyp8EQbGA00bIyA8YyEJoZ8Bn+4pdQK0BKEe8IvJsKEJUqBu3dAbasZw3gZNyHdV2e1MdLJeBfK3CMNJkFzpZ5GrdilkuBce71MrSwDIREkcVivTbgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fsrfjOP8; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fsrfjOP8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWbmXF6/Op441xl7XAsKWSUeTVYlV/1D8VNCFoBpeFYit0Y+exh4WAWOgrE2eIbcoj7LTxcLu8ZlDO5T86hcb8/a6bfgIo1fCruqx0ZlKp+a+91xCAoQwnrf2Ob8RP+kXtAA2YA3RPNzQ4Q9zbxmEojwEDlIRaBE92nv3JAG421ADFWRW3yVKDRemZh4jJWEob/JODPRpxwLIJaBrFN3zuudauI8uFA4lvWDX4h4GBC5Nes0Dpbd94QksSBswtS+tKcvD9Bos4xx4yuxEVvsCFOfUHa7eN2dq8IpULu8bgPK41Oh763bbX4OmcaHO0kW8j66jisFuPs2/ftPpKsWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=652yfiGCfSUP8xn6aqxRvuYn+78RhCvl6epeguecCc4=;
 b=f3SVDImfBUjx/LUyDXaElr5LYPyxqhkWwsPOPgPMaiZS6LM8Tx1K1Ty5lQ53IUr0CZzRRDdU/181cvNpHxSidhW1Oh7dDnwn8rxzMuxD4e6Y17jT8nQqCWH6G7UrC7kHTk7Mw2ieDFbBeXNnZHs5Bo2T/vTiNybqeYkduZfPW3QuDVV8d7495EBhdcdy79b7FeRyb1/BGzMQXb6Cnss0hIMCgo+3tMicRDBH6rmNF2pf3ox7vs95ehbFoo+f2g6N6CvrjOvB1U3TObWtm2EVbPCby1pwXsrT6q2nb/UO6mIi8TtFxC/OqLIN0qk8peCdRWVOi8da060zsr1nx5G0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=652yfiGCfSUP8xn6aqxRvuYn+78RhCvl6epeguecCc4=;
 b=fsrfjOP89z4WhSLD7hwFsqRKBwCpl66QgzagWj3TL5ojKws/TYclQxfWSgYTHcmtXi5QVJfUcIrqWyCUbcSOcHTYsV+tEkBiHxieBPLPyr1mJ020IzEdGAj4Loy06y6jr1lCL+/hF2+RNgO9AskIjFWOmjGF1qapZZg25VjlkFLz140Bnwh0zk/FsEH5h79gHTCkUyz2+V2sfMtmfrmmoQYtIMn+yaMBMsN9YEWV3tdI8U1Xuh1YoJQUV7z80qCu3228akbfHSzP7PTh0ya6QnfTH/08y03LX86JnhPLVPL0guDHE4Qn5MUvgH/XzzMCnrCufLaHRupKUxrCApj08w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:15 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 09/11] pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
Date: Thu, 30 Apr 2026 13:10:59 +0200
Message-ID: <20260430111101.1539377-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|FRZPR10MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d21768-f4f2-421c-aec5-08dea6a9318c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QYgTJPyH8427erUELtikxeYOFaA9dVL2Eea9HfgxRbpBTmeXqH9eHCQ/TTOZYw6OZyQy2UWQuHH1dIGxaIafl1HlSs4DHgU8aMXcz0Ltyb175TZGSg2/DXxefxI42lD/H0utCoEHSgZIf+fogDmhp/WT4kjhhQuP+QQE7jLT3zMG0iXydv9ERqx2pGNpDMImqdyVGfdeMCBCBlQsmWmZC6hHQ6fJ11A2RbB7NvRzxHPhu4/vlJtzycGOH216024ptSpf+E9DP/Eoqi+hD/rpKxXHI3I2THttTrhJndvBBRkCiqQk6VOdI0YkJd2LjEsDjGC1hR1oFGzwN/r8HDY215r8uWwIC2/q2ghF+fpNJBBlTNpiBlqU8JwXn2IlGb/BuPuOUdMdbeRoGAOy7Ta3A0iamAeWklEq31PBdsKkKaOWAxY3FNfzpAP+LiFpEUYX9WT+qYfu1Y6kTvzy86vVZTwbl3sh6IeAS9FVt/ap6Qr8C+NxAoKoM6GKfN4/B1QNzRjSC/rmnjmct7QKBmOjjw5Pua6TfJw0TVNQuTMs2jfEU5zWXXQnaxPAcP1+yTr9AwYNkusKKjg687A9aZTkiZjnCCF6bsvIwcsjs5yh96runzmJxtVkyWtnPeoS6IkSm+O+OEXatF+uP79yhv1GFhuvJelvMqcZ8H/eTlOQQLbMzzOYeR2uYY8uzx0qIIaOFIJ+K9aLFvyPcVEB677GicPnNHUe6kVu8guK29e/0Hg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPS6F+loQYDF6btq3fICHLhF9PPtkPkaUCUf6Yq5BUnJ/PWH9bH3bXqxboSz?=
 =?us-ascii?Q?gQtqaEr5f1hN/7nyzNLuxdwn+/04IPyt3fcMeJ1VqcA903GiIiUDB7XXMoMK?=
 =?us-ascii?Q?koOTTy1XBFrRKm4jzwbclc421splLJUy3434z83DwnHyjPk125V/g4/cdkDF?=
 =?us-ascii?Q?Unm/Wa1/gRcZvCE6fDPpr5wrh0q5BhFNzCVC8vzavD0UIa3tOS7oPaPFBbIb?=
 =?us-ascii?Q?xfya3Q/YBREfwkutd7Lyh2gFc1IglxA6mH3hltE3CVCMaSjNhvkgxD9nQSEs?=
 =?us-ascii?Q?kc1r49WZ3N5j9MGwdehdgzIL7z0Ul/yeXPTcL1nY/k2pdAdQ8SFUfYD+GvwP?=
 =?us-ascii?Q?gKvgaU6kQX55Peq46VUlWq/fg5QaMEa8h8P0pYxOU2Hb/8CE58Bd5PVC8YEy?=
 =?us-ascii?Q?83Re7QFzNvaeaLx55O8rdxtc2MLiFtT5FhnAQplwmxJZDAR720HPp74zLtnL?=
 =?us-ascii?Q?GvE6u0ecY6AhqIHl678J8eDQK633eeKqgivRnZ5lgN7PE6nQk7L/TOYZGub8?=
 =?us-ascii?Q?AId3Ny4nyBFDdb1kNvFFrvuc3/G0803zkHoFNh7tf5zK70T3ZIpLETCVoKUp?=
 =?us-ascii?Q?r+4Hmin6kwEv+KXFLHZy7Jt5omJ/Fg1ghBJwLA9ArkPbEdzeh40M5PaJ98cj?=
 =?us-ascii?Q?29pR/gvSyV12BhFJ5wThIYVs41Ki8nyG/baCV9EKrDqrUdDPYgR58BzFmWci?=
 =?us-ascii?Q?R2iPsm1yxd6FKuoVbAiDqBQO4dLasMqI3w8gfijf1NBcQgogXgc62MsujE6+?=
 =?us-ascii?Q?EayTI3k/Aizgd+IoTI0Zfg8PdL9SEOL1AErV8Su/cYQxzHSb9+I63EOpkAHB?=
 =?us-ascii?Q?XAqAkX5wxgglkfl8+gtsMcut6BZQX8VVrEhvpKry6GTjiphA4N0IowMZZ81O?=
 =?us-ascii?Q?cBvOta8Gmx86ctyAVN3GPG8dD8yTuWegmBHhaZQMPEdACXzJEfZG7ps4/WCq?=
 =?us-ascii?Q?T/5M/fT4p+VF5O4LHyWXIX77yENKfwDIH9PBc9Pp0gv7hMtuKxL7rIo+dU2n?=
 =?us-ascii?Q?eNGrD6+pEJsYcvm1LCaW48bLM7OEIk0K0gGsebK4+H4I8tWa/YEghKzz3Aht?=
 =?us-ascii?Q?eaVfPqPI13rtVILs/e2AhUo8ZH8M4GtvFBZzu14HCnQC1svHLzfJvfbsC0Un?=
 =?us-ascii?Q?TyVNGVWhasXJxr6X8oH88tm/MRoCtiuEmAwtILnwJuRJE2I5IDBZL5WvwCLm?=
 =?us-ascii?Q?wJ49CvWt6Rms1QWdJyj7KjgYwhiUkp7SGT+VCwXu1Oi9cf5E261Mo/G7N9et?=
 =?us-ascii?Q?tX3y37PlJfK+3o7Kyv1fdwRQjoqRw9kCZXHhL6L0ChGqujyy3/tWtLkaChLI?=
 =?us-ascii?Q?X+o3Ed4FCcH9cNsrLYjJ/rgSCPqAEcCUhsXOsVBF+BuxrDQJpewHJfrPs68C?=
 =?us-ascii?Q?VyQGPUjAm4YnU0qHG00kepbsqihklQ1G/PIlmsNneetUZN7/8Fd/QxDepjBv?=
 =?us-ascii?Q?HHuQitLeQWpj8q6CjkYWJEXWqCEzt2Eh8ziwgbE3LixvTjf9bQEIcSDQac5w?=
 =?us-ascii?Q?o7DQd0oZAdhOhA4EUoGzNVnKAmIgL3ZWajmEnhn0uqbiABxGmIqrNoU490/C?=
 =?us-ascii?Q?k6NnzEJ1/ExVbc7QF91+UNz/eqZMqjtaKrQxkASjod7bvJgJVldQqmG97o/j?=
 =?us-ascii?Q?3FGqVzFgFDI+YS3xhNF3yuYU28Cl6/Sk/BIx9JkSbR/VUPEDQgOHYvlpiRN/?=
 =?us-ascii?Q?JfGNRAcBvzl7zhT0voM2VcHRykSvKVztcF3DFfjXOevCR4WzPanJFKLXLFhs?=
 =?us-ascii?Q?mbA3YDhVWxZQ6byhue/Wnq3cMJXSs0M=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d21768-f4f2-421c-aec5-08dea6a9318c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:14.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLz/BW+DoiX19z2q0RdZSFEHwBb9CZzZkiOGmUvbGUNRiQHsAO1cnPpSKbB1r5kTw7HSoQSk+HIHZ3e/QdezmDG4Ot8BHfVf8TmJzjyck0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

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

