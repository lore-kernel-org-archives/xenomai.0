Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007103BFAE0
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492093; cv=fail; b=DrhYTF6MjAjMJu6VsNM1qSm3zgdNXp5IXqvhQbdHOt4UAGlLgYfYtbxo3p35VQTH1MruicK5wTMB9rNQ/vaITVY7e5825OuAkwEMRpxNPCdtR0re+XIBHLADuFmdBDhREEISxImqJR7KSm/Cool2YQQ0E/jvxJRC/AE75dZdRVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492093; c=relaxed/simple;
	bh=Cdjil2q2PuZfehU0knHmX1mZKEuopio1UkTHzLP8Q4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OsOT2tCkofimGd5Oc9tEoyiE1EU7Xx5MKBmxvPFw4NPCMXnd88EQzufQefWe5WxrtO9uOUOomCTfpOt35ZG5uUKeOCjlsWanXZGMmZ4GNPL/u5X8W1cDjXhZ1oPo8/W18RlitArF21RTLtiY8rb/djteNTQ2M++K3yYCRstRRYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yh4ssLD1; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yh4ssLD1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj8t71f0T7fK3gK0H3QQzZBgU05cGdYJVYvtwp6fjAIsaJEVeWyvzEtPIY1sU7BStmMYfXfm+2DdX+WcVlRsNGeaEeJR+BBBceSJ8m1S9sn1WXfazSDweanq4+EX7eMt5VNYHgn0AnxTJuVUpwKuadjvR96+LZgEJQCFGhwbncHUkZywYbhE7I/v0KQCGoeKFcelbvaqaNgkjkJBZ2VtvyHigVvtB7omJ5QWpNr2TjfWMwEqUaLi7s+7vlA/rMNdfqx/rNMY9G8C3YOT7Kzf8ZQ5uXYvbXrq52s5SXnT01ZonHmu6djC2l4ykPYD0TG1vE2KHT/TA+Nmb1LKxV/0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQC0/nQ5gJPPCJoSc1vVM9nJbnVJRDg7ovgqURXwetM=;
 b=vSQD6Rk8J+3i+q00KHFEBTPlU88sbB0/Ks2kB50coR2U4WiSzKnGc7VG8X5QaxZDX9K33Pb9NrQxBSVwbYEfuxIp1Sl09QnDSSl2ezYXan7nykeCUCHLDtRg52GekKxdpDbB1+G1p7hbyrcJdt9NNiyl3iLy5en8XBcuVwtPKP1Kcma3CNp1ICQgsQosXYE9txkYukFTsi/p6MpTmo1Zt+axS8ZABCRKHvFYoWRSEAKbQjmkC+sLNUozccuKTLxjRbHU481z+xYpDn1y0VGkYMHmwALf0B76hbHDrwFZ8+6BgzIb+2HYLAUipnk+0KOZ1EN6bLGQ9FjUCaWjBZ0TFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQC0/nQ5gJPPCJoSc1vVM9nJbnVJRDg7ovgqURXwetM=;
 b=yh4ssLD1vZGFE8njI5tQQDFTyZgR2JKHMVezhMrf9cCJRLl75ba4GY8S37aBna6CpohsfKXNhIA2cyGdvd0Y8ZF8zKup4GRcpUq6QQtlZsh/hrUNp7lhRKzzkRnlsewuXY1r9E1xT9m2K9wcDbZK7gyn+x+i53G0jvZbbQsdRD5bHdG+YdIjMgexC/c8uwl7am3icTR7E3Ia1MDqeJ+882jyF/yvBahPLcIq2gtYEbudPhSu/4Qw5vAmGyxzo+nVsfHj3KjI8pt0JF6INEp7t4TSuet1jUz6Ew+jeiupHQCw8wETCw2NZnt21LI8G0npWu/Faf/9q7/lxpWYlnftxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:28:00 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:28:00 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 10/11] PCI: plda: irq_pipeline: enable pipelined interrupt control
Date: Wed,  8 Jul 2026 08:27:47 +0200
Message-ID: <20260708062748.1029852-11-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 70614b63-ca58-48f4-fa42-08dedcba0ecc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	rh+nq0/PURNo2HhofsdlYoR4lUW0qqLreCOmcBy49SfpBAcLJvY2vHSgyuWEhcUe3HfrfdmSEOyXOvgEmpQwYM5J1XQU+XlP6ln/57PiU5R+n0lwkqz7yIGwo02DMfsw5hdPR4oUrchjomiziU0Nw5ESjDw9ryIBVmg4prWPnBi+IESsZOlJiFt8IW+U55I43HsXs3A4bmrymLojSNL0OxLEHODnajLYDbSrpll24eEpDpYHigi5NVfKFy5txkvRt0QClosBAzv6CW9bREnGbeZ27yXp0CjEIumv3lcNZSrIojcyLLsf9o/vIHuTU1tc0M8nL3wnTUVBqnXjUYqFTHfy0u/Sbp4Gf4ZuulEASuvbp2YinQ4bNTytQ2UHFvsx22RnpfBEAKwOe/rqBcbxKfltU7Pow/6GuduoqVaVp2FXTaN1s1lNBJ8QhYJnJw2voNRL/Uo1hvTd7Zfg6NrzLaRyAVhudyNmNryCM4qxeAgKwlHtPoyRTYx32ZtjwpovmNwEvDl7s22J/9ppkdoBkFx8rclHLGtJvnR/aFnXaOMSgFlkz72Yt7WYM3g062rRQ6TlG8OPeDr8i2FzEDrkEw+Kd1V1Ak9sfJkQmYt1u6YDV32nyGNJZl7HVomzucaiG2y+MTeLTyJeC2qsrqNz2AhncgXEYKwg9aiwXbS9hRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YsDfHtqhPR1jNav9OgDtrwIUIyGo1EyHnYelo2dgXAGikblXCO36+46Pd6AH?=
 =?us-ascii?Q?K+NPNzsrZPMdBaV2exhhTqBeW6pXJ0txdTZ8kAleBEha4ZPZUjqKtDnLxGeB?=
 =?us-ascii?Q?0wCe/9BMoIOvZIMdieu8ibVWmnurjxFwSPKIb6wRgUiatC4nUiKbsNKbFbtD?=
 =?us-ascii?Q?9OtXVZ2PS3+HKXiVgrbBZXzDhD9cIFldqL5GCx0QB5Ugc9soonf1COCjNVHb?=
 =?us-ascii?Q?1B9Z+RwXSfcJKQJGhxUGNwMhQJGtNmruFu+oPqOXjI0NrheSpoq0/czkL1Cw?=
 =?us-ascii?Q?PVqe/NShy+wlgHJCq8FSedO8lXkt1UJFrG8zjmFuevrphNe8v1joOqLcVrcs?=
 =?us-ascii?Q?f0KCYbJGeYq7AhctlFDviy4Qj3fCaqsbTQMhaE28jaowlb/JxM8+FUR+qDM5?=
 =?us-ascii?Q?27bSLakWa70yiJ6X6PBMkxNEaxdYI1/unpJn9m8kS7gO99jLCraNsSH09Zd3?=
 =?us-ascii?Q?2hsIlkB6MjBea8n+Gtb4Kq05OGxVYPYHxr/yj0Iu5AXhHA5QMvGM9jDILtHQ?=
 =?us-ascii?Q?HJ9mtD+kdGgxgl5aeXBcMYEcq1cOWYt2+ICh04axhsCB3YRFiYgkT0kRY2gU?=
 =?us-ascii?Q?kuQX7PoHQ66oPXFLpXNgelDwTVdhn4Q+9qRbR0Rwk84yYgqWRs0rGqfSJ0RM?=
 =?us-ascii?Q?mpsVKebldfBRbYRgrwW6rkG3UxQl6kiLUGHZjB/zIbzFt73CU4cNKbnFC3ch?=
 =?us-ascii?Q?y7iPUkaDEpkAI+FnF80NvsiQUuvQIC7jgcVIVQZe3zBu0Hm6nP0GZOc6BsPA?=
 =?us-ascii?Q?oM9+1TQwgAq2cU3fTcCUHgkMxMyMEqZJZhIV2WYTlyeZoiKmLfamBv2ePMgH?=
 =?us-ascii?Q?hZvazfiNd6da2C4KJ50SmB+7DUPt1LW23F8wLKQqALy84heSSoFikdG+9Qvm?=
 =?us-ascii?Q?hkGoxD7Cubv3sN4b070DDoyuy4LLuIlG7taVKiiYmAA9XME35IOUYy60lFqn?=
 =?us-ascii?Q?6/cgw1TDZu/AgWn5htrchoLqzJbEA/iihF+sZpDzTkZVI5PCWB+iseJ3TmVD?=
 =?us-ascii?Q?t9P9sUTpFLs5hsW7QMWya5TDfYpPBBcKrOHdwkBWObmr8xor+1IStWZn/S7S?=
 =?us-ascii?Q?7Ws2YLei/a+PkBSCxmt6HxIPCkiWBcRycjxl8q2jdXj5CKAuxvvajtk7QmmG?=
 =?us-ascii?Q?sd09WSS1LtYuimjq6WRbqEUKYsbOqvEzirEx8/Mdm23vvWhjWobdxpGdZRMO?=
 =?us-ascii?Q?4fOTAYkWPnqqvUNTcV/Srqnz1kztVU8e6x3FaZpRuT/qbAkdsNN5I7v732kH?=
 =?us-ascii?Q?vGzBymPhDaBWflbSXlWeKGulLhicjxNCl9sriU5kAE97l9rO4yhI+ShnFXZC?=
 =?us-ascii?Q?Qo0ggaO1WfVW0wBQ+mfjmoHEHJllE3yiQjnp7Xuo8StUbnkCMUOd3ZKj+BcW?=
 =?us-ascii?Q?Z+2V2Sc2qAELtq1i8hOBJsaMiHjnOSneGi/ekMoV0ubfALedg05vXMU8PsyV?=
 =?us-ascii?Q?44HObCPqwao49ikIYpK98wRQ1/ObhcuQEmcmUcpOLo8v0J/K9BRxAr2D5908?=
 =?us-ascii?Q?K53ow5vkEpBy2/do/lm67mrJdOnwTWf/31WNXMr3paX/MTIgENuTtWy0/T5W?=
 =?us-ascii?Q?+Anw3mQVoQiI5tPcBKqXC7G1L1lU7PsAeJPbf6GOATuSA8nmvzKmE90F0ZAi?=
 =?us-ascii?Q?R31ueDeRd2Kc60bJFqNT2pCaAbtnLRc50Ht1Qry6P2vJfheLpFa4FuJfJ/Of?=
 =?us-ascii?Q?oRm7/SHoUWHOLff+pWk5uLLI9ligUhRJrkuqbbp71nV2JTubLk+qc1zdFgpn?=
 =?us-ascii?Q?XD4tHHODgpVG3sNS0lhZT31rxnsiEgJkWWFA1nwXsy2COty4PbDsvu2+vbSJ?=
X-MS-Exchange-AntiSpam-MessageData-1: Tt0Cg5+f7lqM3ref3VBPshjHvFSlut/deNU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70614b63-ca58-48f4-fa42-08dedcba0ecc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:28:00.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRzy4KXqr1m/MdkBhZ4g7w9i2Tb3D1EVxfRZPcvLPDxerYRdGi9rb7zoqHzLCReGf9GFUN+G9vDSCBWIO3lvEOm+JbCeWsnSR/+OgAfeLBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

