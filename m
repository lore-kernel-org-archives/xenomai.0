Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02443787D
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362592; cv=fail; b=Ai9EqbxXROtuOl4pD19smkrhEabedq4uUUjrhf9xv8gzzzW0HEwxS4CvGX4RkqsMQuEpL/iev0n0+g584hzx+bKhiVYH9BiFaR2BYayBkBmJZRt6Druio9UsAYQ/D2Qaz58yfjU6dAlSmyB8JEwwfWdQeqgkSmYIlHsxVPJUXYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362592; c=relaxed/simple;
	bh=Cdjil2q2PuZfehU0knHmX1mZKEuopio1UkTHzLP8Q4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWSwBQtszS2cheuwIOCdyP7HebEA6D9y48FARO4THoIrGDe0LjS6C7SQUw28aM1ue+xzsplYkjJTFkP9Q8q8OUGFefyI7v/bRpQQADMVAa2kSihl0leVs5V0iBxaiIxjdekCBmgxlX1PgizkPTxr5C/ME4o25GuJ9F+VyovoE4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=u+GPj4mX; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="u+GPj4mX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOtXsHYE526NLKlTLIk4U/C7dywbvwcMmie1Zv4hAYIJf1Uy32iLZDzyh87WULeM6s5isqB37KwzFN9dKrEwrKDJQSlgC8u2kkn7M0GPH2zAEM8+YdmpszpUNgcIUaiIyUf0NRFiEY1EVNbzb/ny0wI9itrAvakn/aW1lspvdarWHSNruBqsTk+ixIIn2ov1Ft/gisf+MEFsb+hy7iQZ+WRDTgJmeyxgoZ2LEQsQIhPF3plQIFHO0Wc5xaaf0OSmJZSrOMoyiAG30NVgGECokSc4AjUiYquRYc2CsWEklP+SdpiBMjXkZi/7on1eJQSHUD6KWQuzuMZPGWGhaDIMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQC0/nQ5gJPPCJoSc1vVM9nJbnVJRDg7ovgqURXwetM=;
 b=TjnFLkwglQwLj66yqqEKVJY59xPAIE/vMlaSEpq0Ose50QzcAJfnvRwZtx7dyK5TqAiiWQtKZqALBfND57vzYj1IbFFqbklKEoygYYEdOoM0rulzCCu4ItMt4Pw0WfKMhJWTOWXv2bnZvXhueSt+EJKE66Fb/ofWnsXN4P+EWsRj/Bx70onlSJW12T8IcG2Bw1oYXLePgto1MrzbgJ5bkJKFUqqWZSgDCpaRD8C8n0n0h3xxRRBqf8DvhxEgG1TO/9wfxtz5nXWRzn9/3sHeM5lTu6vXM9wkER6xRx+/ca7vogmfWArLmzGVCSzmit0l+I3u3gLqfMyuII4oicTnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQC0/nQ5gJPPCJoSc1vVM9nJbnVJRDg7ovgqURXwetM=;
 b=u+GPj4mXmiqZSESYxmfNkTsQL9Cd3tYneBg59VAbjA8XNEhNr597rpAb096+ybQuA60O5UgaSwug1yS8Jxx2GQsBRiexkTaS8da8WleOsmK+0jzWOwRiw8DaBuNsf9e1L+xraGW+THecyv2XHs9afLuxRUqaaGnXYol1o3mguK1gOK+dptiFjby8doqtsFBtXISwqn/KY61KuOxDZYlzjl/f/NM4hld9d9ED6Z9LP0m5J4gWhTxuPj8VqvVeDS0ORCvwP1Abr/BWA+TQ2E0cVZOJT9n5X5af4WXKUV4cA10Rc4mkRxavvw9uVEwrI/D1dZbFAW6HAj2cDEZc7HN1ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:41 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:41 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 10/11] PCI: plda: irq_pipeline: enable pipelined interrupt control
Date: Mon,  6 Jul 2026 20:29:26 +0200
Message-ID: <20260706182927.281078-11-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: e83a210f-15ed-44eb-f124-08dedb8c8b5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WtuRsXmUaZD/9HR7G94JDnIylrGOQr4wN6XtiRoitAWe4kQXmpw4O4OBq0Z+yEkJGhD/Bc8R2CVsP8E6ey/2d6X15A2TlcTp+yKvpX1TKn6mm3TcdXhIoAxS6pJYhVwuxg8NJDsvWXKwUcc7aGQ9ShU1D1b7TZnSMGHbNYVQgKB+8TawP7ZOJEGzAUEViiHCTGtLPKF9PV18Qu5V+wYGTSy/6XX7DulUsQdtHlXwj+KefP7Kvznt2qxecWnSdQbK6ZbBnVJamkD1sfrdZSOiG6Oa/XC2X2nDNpTAVo0BP18Yjka8Xlk133VDnFgMVaxyg+aVGy/iYIXjDgrElaEpqihztI6RTJ2FL1Mxm/bZfu8ekezE6/+3r2s7ogqhkm7IjuO9KEWS7bDKf8o/JoqG89dK0y9CG4vNLQbZxvHKmWFyVvieYWLFFjN9H/rSHS8sDG9Wuv8HVLILdbonNgQKno7VqPXOjHAnM3G/y4GfhExv/RHpqTS8nGPL4Tt+U9NtTeF2nPbzmckF15Dq8cf6GzFFGiKT8oGxB22kD2qn3dhBuUw1v/7NPswhlSuCGItNdkNOWc2RWRXY4oAErocz2ErfKspPoSChj869l1ECYnMpd7K3YM2DC4P2Q+AsVl6+BgTktNCMl2LuyHUW0nRPcmTfq7HTA4VpMvPMIiOK0b0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ay3U5WXH0fO8/lrYf3ELgn8GviikU7TOaTfpjMMYcO3GF6+ZsKdvaCd2cYyZ?=
 =?us-ascii?Q?+EEZyeGf6eTvb1rj0htb5zWZ5bcw25QKysHdgX9HX/BFeM0cyq6lsBpCrfyd?=
 =?us-ascii?Q?ppUkAu9OkSBth8UapQJIxc97Buj6owwnzpnyqHnMBuez0btMadHefL5c8gzx?=
 =?us-ascii?Q?MMUEvrpEQ/AuKLb8kCKXqZ83/VJ0vsu8DhJylSugk2mWuj8E6QDje7uJDSkT?=
 =?us-ascii?Q?VGgoxQREU+iyDU/1UM6Hpb2bEXz693XooVl7EVZQbGTuy5YGaZ3b67moNerQ?=
 =?us-ascii?Q?Ybncuqk6cVyvRI0aMTSA1vG4qQptNoNFoWrrxC2nZu+HJDqo0ahwKxP0UWC9?=
 =?us-ascii?Q?kX7rKESeeovhqQ0QLmVXjoAzEilw4AzAmxW7z13MgzgY3a1+6ALsE370dwOe?=
 =?us-ascii?Q?MeArE4fai2ixUWCvgVFDO9S3zxV1iwbeN3/xvkB25cCmdD0msrILmcfX8vua?=
 =?us-ascii?Q?fN8EQi9wbaJAwLQTS8hSvfM1+8Bz4W81IVDAeUT9N41B6kWysfQ7PB30bs7H?=
 =?us-ascii?Q?3J29svM2ist71X20jyjE2yY+vSPHxw2AvyjPdNxNIKZf59gAH7orIrUsrHhY?=
 =?us-ascii?Q?tbkNYJBRn7tjpVL+l5s4VFVF6X+PxI4VU6dhKdgnksHjtX5JFW+GuHjdW7Qs?=
 =?us-ascii?Q?vu66+HAKfo6AQuPiujojq8W6eoLUWZmzg7dMEZaAMDeNvq8S48iO6YAU+XaB?=
 =?us-ascii?Q?2ntuhtKTz+i1vrMu1vhEFaTi6uUIOwJv9f6jPwn2EkOiRTdYKIdWuXHVzlgg?=
 =?us-ascii?Q?Vk0asEvVSHjozrTicXl0IzF0W4ioxSPPj4eHWxrax8poHtqq1bzTF3q6Wqkq?=
 =?us-ascii?Q?7rtiYnwegiKXu5ZXPQMw77Ii+m+9NToUiMweHzuPkmMSEZmNwlmJH6eqeAZq?=
 =?us-ascii?Q?2nPhMqUAD1XAQjx7mHfMfpiUx2BVcioqxXdB4hbvwO7UKntZAsq9ORN09DpY?=
 =?us-ascii?Q?sE752KgSInpY2mUn30IwEvKA3KJt+9QeLXzizsKV5pkX1WejkbHyExpBePcA?=
 =?us-ascii?Q?r1p8TywGwNjYLhQrruhd9Knpm4gtpx5PCsBKjqMZSXHXRIEyFkx1C1rhgFvq?=
 =?us-ascii?Q?LCEYYdhHNhl0y9ZJzaJ00AQkAn1Ia7+nAIWF6LYFrwP/76k4lvx/BB/o7zpM?=
 =?us-ascii?Q?wlyyxLFP1CVnN4srT2n0oY9ccwZUHbhqjJjBB5b5zjd1XyIOX0EooN8Ta/3g?=
 =?us-ascii?Q?hCLFlHdDNUzZUfPhoy9CTHoBrR6KTbkx+vY2L1e/eUDarLjEpq1vocTa952c?=
 =?us-ascii?Q?cO03F22EGsFpJY5siH7+3DFMbG/naXGd3ZyagmtRGtm0xv1WN5ufr3vXtRfc?=
 =?us-ascii?Q?t5swVuuAiqgkSOe/CznPaYmIN8Y1g6aVOkDPFAxUND42CK9iDrkDB5OKs3Kr?=
 =?us-ascii?Q?n7oPEv+9sriACMzocsHpBokeMOgr34vVojhmMQmfjnQneWU27ISFR8zJ/VJo?=
 =?us-ascii?Q?KNLKWh/LmGXhcDIq0AKCYtCLenXoIw4MXY5kYhAG/JwxQv4pMjS/+wiWD8xV?=
 =?us-ascii?Q?dqx5oJTUeE1XyTXGBz2pS75vxHedBXMkJ/Weh+Mkkn+KtzF4Ut4ZvU6K1rwb?=
 =?us-ascii?Q?ON8F8/19AWmIjabP+Mvldg4EGsNS6+cMzrVNL+avLT63kB1tUShVJFm6QNd3?=
 =?us-ascii?Q?+nUPA4cvzclBd8kdcDCakcjXK7dIKV7qpM14wa9e9Gm3hv7u/G7ZeGHEHhIO?=
 =?us-ascii?Q?mOvUc3D0PwUiCKkAOEvyQgSbizZ6u7Y37c8C+YvzippH66q/2Lw1p5YAhRi1?=
 =?us-ascii?Q?AYiaDTcVPS8nGfXRCOfZCONKRyCI0QOBW6LFJ45yvAWCiqF0/Y4ZxA5kMbR/?=
X-MS-Exchange-AntiSpam-MessageData-1: Ktia7u2ep5w4YfA3M/BsPRY6w83QWDTz3eM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83a210f-15ed-44eb-f124-08dedb8c8b5f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:41.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRNSdez5jfZV5/EmzlzvwNz9Ky0J8EacdxsZ1rHkhmr4Pg838Mn3sLokOzY4U9e9MuDfUC/gycO70yQ8E74Ql8qd2+1eCmbTYnqp7IVAjb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

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

