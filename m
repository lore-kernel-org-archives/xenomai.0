Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B120308F36
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042642; cv=fail; b=GDTvfCgyOR6f5cdpHdgO/kYZ3jWcNsVJNZWW9QDdPL3w1dR/Iz/AjUdm8u3ZZuyCrd/4O/CVrDJyRBIZaNfwnBTdYVewKZpc0g3DL3gWOnHwg8TXfimks8qR45hUMjBTz3qYa46rsNLu9+8VoF9UPPRENWBh71fnLF3g33r8xqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042642; c=relaxed/simple;
	bh=LgduWSsYxzm9yWIzp92uq9Yyf2wuC04qhjFPZr0uHmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwCRfZKBixp7tu4XID+6is2mSUQJe6b8Nh4nrAszBuGRejY6ovB/p41IRONwuv0HVtXb7u4IfXu+CZcgSb4p4/RPd5B58cKY9VpWe6E/rERRYKMDtwvNlw313ryy+q5xcDDO0t0mZ/yRKN2i7psh6G7/qsSj2GbbMmgRLLRN1HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jciST4es; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jciST4es"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+hVgOlRX9Zu0mk7/v62KWa6OajIVqehA3l3CJaij+f9ZG9NQpaKW+5cOCFqpE8hjYY9KEt7lwmeJ75NvwhPr5DCmupdwZxfV9tnWQI3SVuytwHE+J6WYgwz/vs9GPkB50+zrIkP6UqzWIAFiZo/rUkoKCBOhyYRqwjVsuHeweQ/yxxla+0dmbngtPpYUre0JoXYDt6Z+ZBI/ZKReHkm/1WI7H/vviMqeGw+IGdMnNMSNodEWHpaIZPnEEk6G0Jc8msfbehAlj82d2/boBDkD4+Sko95q78cSgjimP4dRLGbkbhebgyA4aXe1VkRmsJsc9d81mPhAD+3CVwvVzRWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlZGenQp2DOsDhLfM1Nvxc1dTvHotvKJaVnXJvPTqZc=;
 b=wpX91f2ouuctdN96miXZgYTCC5VHeqJhe3L+j34W90YfrDZE5EIoOf5gIZXWOTH65yqS8w3L9GnkXIPlNyWOKoDJsf7B6+Cri0kcbJ+qvnEX7GtK03EzMR+bOgo1/pnnGe5RiZ97FSfAidejLtjI4W+Xu1cGB93ykUSzdSOgXbEMQAgXRXmR+7v+8q9UocbKNdg9ZKSfoLkEIetOIODqViznucE2PORw2sXUIvXQv7Y1hIbFcK/rSPyUmFCBlcjKoeFlhat6xFitSfvhfsJHI1D0th+4to7spXOIw7duRwZf52iXj8LRtEFE9uS/VQMkbv3YrbVik3thGJVjLYMVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlZGenQp2DOsDhLfM1Nvxc1dTvHotvKJaVnXJvPTqZc=;
 b=jciST4eskIMpgP2hELWBEiGyVgTAFd9B7v6s8TIkrcSCZcDbERNE0DbM1Neu5X+WjmttsSfUxNWCRrA/9TvntmtXOkumkgxVtFtyzeBSCzT0KDZdvxpjNqFbLhj/4ofcwfAkeyuzBc2Lx2lYXReVxJtz2pbuk+vw1O+3CyoKdKzwzCBnfrTbE1/kkYcIO7b4zAfMADz8qJmsH/yDgKmCl0sRbNRT+yGLnYVvjYjgo9w/zUjVWHV57BY5OyIdvmg1tpn0TM/JvnGxXbK4gQWqNwLj9R5XsGAlEFth+8icW3Au4byq9IWKHkwxEQGMKmtNr23yICQIIkFkvpMl5gVMDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 11/12] pci: plda: irq_pipeline: enable pipelined interrupt control
Date: Fri, 20 Mar 2026 22:36:56 +0100
Message-ID: <20260320213657.2210419-12-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: dba7dedf-450a-46f1-cdab-08de86c8d93e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	8/UXiHLt5oiCCbwg+BsEN5cmdQAX2CtRtn8zl7OZ5DgO0xiq5dC8+L4oF5x9RPlEPQQVl/5LttD8e0wYDbO2L8kH608+ir+mo9FvVqCrx9AE4EAIGjC7HoeFS9fgB4+IpITeVzGk1IF0pp8FMfReYdfkGRqfBba8nk8FARpE5YDjVOQK9UpX8GNoQoZCK/tWss4Rjrid2BXYTFhniSyCGGYBZtJe6OchIR8BlZaq3mSekaXct0ZqISPmvw2BiSUUYDXjXJcw7cGbizvKZ7MT94aZb4qwz15Sc0P49uT+sarAt5JtoiyDvQYH9Behjz/dB0Q1WrHmi96+GkcuISXBh7PJC0/gzugtBd6Vgce4ODRcHtpGbxQ1ivYvQfOFn2x/rlIZQMT+a6a0Ghi2UAeXtZySoIQ3YYdXUCejjBmSH7PBKNlYQLcLWi4w32e7nbTjMxCa3mSbbS4XEEOv+kHfBIa/bfHb5TxNGgTFwyBUd0rzE+VhQyflEfqDTssiMUbq3dQ+FNrF0GBwcR1iZiQD9RskvTfGOUSc3JD+R0jdSl6jF4/QevObwzg0PlFn4HM+sikDt3SMhu0TNuGeQGLvo8tP9zSBR7pdNEDC6mp/RSEMNeYteDeiS+fKI7IQjP6eV2VzgSrls9KjZh9ONaLzRCM168CITLcjy0EcQchOF8NtEdR/9r4aiY9SWvyiRpISV9Z5fCa3SNOteWq+QyPk30J0wTuA+l6Dp/Z4ZHvbItU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xDqp4HMksn2Gr6SNtxBKQsj6RbDzASsm/JkaXesFA5xO5gUEEIIKQfZLLaYm?=
 =?us-ascii?Q?4fK24MrSOOukh3aCqXvhQfXnGs171ep87xzqCnAv1nJzfwE+Uq0jkftcQFxG?=
 =?us-ascii?Q?4wimXtGqldx4Beu3jAmTfLJFghaD6Oh07j4yJNVNbW0Vk+F/eusN8NnDEhJL?=
 =?us-ascii?Q?RcJ5BK5hE/dmJzUDJF8zjyy6WfOYjM4iXfO0C6t9258ALdrEwqsOfhza9DQr?=
 =?us-ascii?Q?LwZT0KM8crKts7nVXyQBKnGCSq7baIcNbFHW5HBF3DDJStIkVi/tGO5jerqC?=
 =?us-ascii?Q?ig2SKd6eM3DmapVvSS4FG6nh6gxc4v7120otf0JYM0IlOsFWUfN9AI53/G9U?=
 =?us-ascii?Q?1YXcRcqo0jqI3V1tFKgmFH2Sf768d1kJEo+ko4TAI6luRssyIP7ZtJf6yvdW?=
 =?us-ascii?Q?wyD4FFnWqzTkm/WAXZCnanEvgFD+SSfNZx+xp2cjUvK8N7DK6RS0funTfvUy?=
 =?us-ascii?Q?KpaHVLAM6SCl2kjk9wUcF62QP+UD2veS0wfVLcOQ1SaIwr2QpZEmFT9ELDsf?=
 =?us-ascii?Q?8c1Y41UT7C2vq/+DxtogbRduFEKvg/6zHQgtaUZrA+QBo5fNRud5oXfKbs4v?=
 =?us-ascii?Q?FYO5nFRI/6LcR7bFSesgiFXZwnG8k3W/aEz6FWUuyjMnS0KBl4JosIS4RXwz?=
 =?us-ascii?Q?uLCz65SgW2zyLzL7B+PpHV497tS8fV8mF2pV8zyie1LnYHY38Egx/yB6DgA9?=
 =?us-ascii?Q?MrLO7pueWx8nMIif4Z9/RKd+Lg+W299td4fGXNi7J8PwSLGBfxNuIh5NJT1K?=
 =?us-ascii?Q?oK+GIq7h7Y9p+JKsjm0+Tg4AqLpG0y1F+XA+12CZ3WAq9ayyPT+Ipy+H2ouI?=
 =?us-ascii?Q?lSCdAXX73RSibObzhfqeS+XUM7oGUlcqPlLAF82XU6Njmsu0Z81xaLpkx/gi?=
 =?us-ascii?Q?FByWbU7iLeJL4R/8/PyhXoM68W/xNvM9ItKxFxZDjkwCmr8Pbx36P+ng4HYf?=
 =?us-ascii?Q?i8ux3vIPB/rKCLYFID94Zg3sGL3ivErHcdy1tJ1sBKhlE5DpbUwtQYh+aSJw?=
 =?us-ascii?Q?xiDfDELRtq68MamD+TgD16FMFTH6hal9qQPsrfApEgL1vkX4vc2atXxE73xM?=
 =?us-ascii?Q?nmrWMOEG4DbpBsKI/Z89t8ZrLg5HijZNYN2658mGUUdqliQ7YjBWBlit4ncm?=
 =?us-ascii?Q?1CpTiQPyPf7qCvmT1HY6gkP0WLUXTNBYni5Hnf2mHRO73MyRmOf0G2Mvm6ba?=
 =?us-ascii?Q?GXxSIjljG+Y5kv18fQmqS2kFZ5DpZ8t+GzTITgXD0ksRzXnb3gk1GTt0/lKq?=
 =?us-ascii?Q?NiM6miYwCFYwZvpZN086h7OvA3H2EGb4bmgUDZFxYh6p70m7F6qGZaGoEwnZ?=
 =?us-ascii?Q?/t/FASd6uWTtQr1T4z2mHaircAUVsr2BZWdfpvJs/lfVJ8OV758jMCh0JtkF?=
 =?us-ascii?Q?+oZV4Aj0KX5O12hE/ZwGRDs2ghzk5OrvBfeyrr+Z9k0r+PI+0w8qEHmQapAl?=
 =?us-ascii?Q?YqLFJw9zFEEYsb3D4LQ/zlj+1dDgDsN7MCcpRiOCJwyCXAJUkKPGrTKKoaeo?=
 =?us-ascii?Q?GgrgVvAQ6ai7PRUYM4w4qIlVyHGLS+GQJYLvyA5G7SaXP2p0GCrZDH5coEq/?=
 =?us-ascii?Q?QX3tWI7hlEYtsEzqyC4gf1h4cHOifw63sF2l6VaED/H1uDAEgh5SE0VReRIj?=
 =?us-ascii?Q?ulhB3BjF3IducBedWwMvFuqJt8nxRnophoDuRYU2ZgTapo7sU8BvENNzAOPh?=
 =?us-ascii?Q?7vRdnT6Ct8a2xIK4ukjMej8QOQeZuNM4jmXo5lh9dnsIOEdFnVMiACs3oI//?=
 =?us-ascii?Q?Uxz4aKRckEuXiBJuIniETUwG5F+qGas=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba7dedf-450a-46f1-cdab-08de86c8d93e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:13.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1VhSglxqE/5qbniuz8LcAfEu/slts/hXz2hwJRdqcIjEzu8FIgVbF53rEZUJAUWYRsuv6bKGJE7UX1plEU2XQagqNUocAMGVu8RMy2Km5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 3c2f68383010..8f0fda4b9421 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -244,6 +244,7 @@ static struct irq_chip plda_intx_irq_chip = {
 	.irq_ack = plda_ack_intx_irq,
 	.irq_mask = plda_mask_intx_irq,
 	.irq_unmask = plda_unmask_intx_irq,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -358,6 +359,7 @@ static struct irq_chip plda_event_irq_chip = {
 	.irq_ack = plda_ack_event_irq,
 	.irq_mask = plda_mask_event_irq,
 	.irq_unmask = plda_unmask_event_irq,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static const struct plda_event_ops plda_event_ops = {
-- 
2.43.0

