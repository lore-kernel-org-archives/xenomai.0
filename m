Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296F3E024C
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547479; cv=fail; b=sIPPsrPYMqJ7ulsvXqoWUDbXdhQGRkzTFbneMWYNp5JAmd3i9edYuuyAkVEaDRGPSAK2RVzuUAeFBQ2Db+Md/OMQi69v2aHOY5uelLdqq7SlR6O1C4zZKAVcgx+zmF3gFDqtLuf/oMmnMczFCdQatJ9MqwcU/pgZBmHcIwXylVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547479; c=relaxed/simple;
	bh=39GCOayIqybswVpLcSNY6Z+YPpxGL4s38r71MQk6sMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVdYRnoA/vfMjQulDsnJYHG4jjctOXIUmb63yaVvv+sD35M7LfM+CFW30IoFNV9hEqNSQzE8bNKE/sB/toSagfF2WLI9BShU4fg3K0j7JbgrWmKAoWn3r9aF+DoGR1FefUjhrbK50R3cgi0KMH5XTe3gVKUE1I7tYxtpvAt7Ot0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bIaMXTVu; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bIaMXTVu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPn6IzRNnJuEjXQ0EH7AsOQ1nts6tHyfwRW1xQSGnzKzsVcmTpmQ5BQhkZJHaNUgGRYLvMGxcirLsPwFknN3Mgo8doT/ZxbVVQb79ekHdse7WpKH7d5qt5ts8WiJ904J7e3cF2Inv8hP4TFJgTEU9PLJy7VKZHqlu08cCYiYez5fI7MKv6bnCz3y+PMeMKb9vjNqUPIY1P3+AQwWuHjOxWZPpnCMq7ulNUGUq46vhYSJAF3MK7XZ2j0bmI0D+PBP5t6KFr5uIVRUtbskv6+NZUi2PphJZJaPKANv7SWs2nxAyNRm1MveL5Hd6f1O07RVCGEqsigEY31Ya36Dqf7DPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQXEJbUEMkZhOBDwWHD4F10QLN4h9DBdEX12kGS7TzM=;
 b=NvHxhmxr4Ic3h/DBUcoDqm+X0nQDBoEAbqtZOsk7mtWrEsneRowzJd8d8TW1Wsblq0LYcfeTEVtyS6Ly3WbnNA4YHMXg4U+N1BF2PoKa8uGNF689kS6gvAaZZNragKl5qxZ+Wt9CNGvZv1gnLsyLM3Jc1sWPslAGNjvYAi/cNVH1rl54WgAX/KfbaNWGwp0Z5O4DlLrL/Spsve1ZJNakLBVeERnyRYSYfkiJYc+sZoqyHYXVuVjcQhaJqbuJd7Rn8nMD11W8ofgm2fWHYm67t9o0Mq7pPb5uuuOFBrS4l0XpKuhn6JbRy7g3/ALNkUzQ16BSLkeXDx9fCajZkvYxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQXEJbUEMkZhOBDwWHD4F10QLN4h9DBdEX12kGS7TzM=;
 b=bIaMXTVu/pN/jWBksne9vP2m9Qoka/HyqB9Zd6FGtZyfTeAhbuo8I0rQigZ5ck7A0tvai8Ic6WXI1PKnV9+ajemCxsJxvujn4IkIQ9fCQkk2PD2qjI+7B7AX0WiGt9KGYmq/Uv07AYvVnRBEgF/s6oSJqUZ+lRSsqyxmQIozv3xgXdgnRDTBn7az/YmYHN4rcaIg6tWw8Q+TkI6Xvqxrz4xz36+dyJM++WBRgQSQDLGvsmTcWAZ1R7Nci0olvayYc88H+eul4JbYDA7U0IpvGATmOWUpOmXRdMMDWE38Eb7s9WhH4uA/SUFV4aSJcknMoW5HyW6CifxMEYSeYk/vkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 04/11] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Thu, 30 Apr 2026 13:10:54 +0200
Message-ID: <20260430111101.1539377-5-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2954b9db-e10c-4e5d-5805-08dea6a92f8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	IbeDlJEbuerNq+RtQUn/YIXODEZ/RhGesiSVmMSHbbZUn7VuQ+H5WXk4XENSxh7S2eKDPBI2FrxvZtsQrLwTdxvGw2zOi27yrdnPDURBJuxZKJc9sZKCl4x1+p/8OoCm2blZY6z+d6Ju4wvmot0IJoBKPH0WzhFjrodhdbHRHBDwb7uPfyewnSvgXtzvgW32mI8K6vYnCvZVBbL6gqgZIhxGKx6s24bhnrRGB8TWQZZGd9Xmm3dMIMpuKH9Ix4vpuxt5tZ0ENA0QqIfw5K9HT+3VM0T5lHoCGJrx1ohcb+O5CmbkvgUmLokPq5NZHK+whTl03ANYLD2eR7QqghHznaTt9Gb4vb+DGjO5qra4ti7cWgF9TpN7JenzVoat9ZYdV46evAQQ4lVGAxTaxoFogAx44C7PATTUbxG4S3WDTDY3t4ZT0xOO7NWSo2GyJ44SxtjLRgPuv9zcyrYmC9Pw2egUGQOgD1i7FP8eVDp0wtSeeTZgAA9s2Y/nV4H5mNvlWF1+TvQm9RgXNv4XvpQuaMSG3Ab5D+aKUPuKXeDvljMO4OiN/AAccsOcHNloifkP/5tPQTjfna+S0jiVcN35T3eonDpoY9KpbEuRKHnNvF4gpav2QvHEW9IRf8wkWmr6x4qOxcsFLmXMz+Fscx/OWOHTfRa1Gh07USVoZseltXgKOPrbhfsidGV3NE1J3YWCXig6Fa3PMYAJDARbSH0yk1r7sgRDdSJAPJUzEvRK5Lw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBr+lccUrtLj2vfBKG33r6fFeFWawxCtD1pDVrt65F0aNfgV7yuD0jr0037m?=
 =?us-ascii?Q?+95+Wk+f6d4R/6haR6aR8ThL8n/rnxWqnTbYJ0tqiIrwg3XSb+dja7V2n3Yb?=
 =?us-ascii?Q?CjIDEPcPgh/ajAS6tJbbW0WsrmkTOkP/nyWC0fWG69cmd2ayvRtMTXoafw2B?=
 =?us-ascii?Q?djYmdBgIBQDHtf25OaiRCI+eHq+xEDE3Bag/kU0vLrlHg84IxhyMQY3Lpe0j?=
 =?us-ascii?Q?Wpgz/x8aWmXu8H9HllKdJRjryMGwxP6oOVOdVdCwSyc5iNh0mMw/nnaNFw99?=
 =?us-ascii?Q?B36y5499vU54JIX/lKlPapIYlhnk8xYbcryMB21AGnE+2mo1j4IRTGGg+KM8?=
 =?us-ascii?Q?+o6cD4ut5NCmEI4JRgbhrvIPW89nk+BzRakg7NyETqlevZe3/ApHyKfvKYgp?=
 =?us-ascii?Q?mfH+vr9TBVKOikLkcqAXKQojRGk/FacP2qgqr2C3LoO6p0aeUZ6I5GcKEaLD?=
 =?us-ascii?Q?Pi0RNEXKdItv5k2Ai7bysZssm5sx3iKJZf1Sh8uEZwQRrIjx7otTR0vIBskX?=
 =?us-ascii?Q?hv8Iy2E0KtIAAIrZsHEVASldkCe1wQI5m4ZMSI+64qe48/Jj0w77l26tCqdZ?=
 =?us-ascii?Q?KnCvQbRqtlxs5w5sh1buHup9xD3kYmX7TG2Xd1hRYIhRkUkovUJ1EngC3DPl?=
 =?us-ascii?Q?CGrhlm6vmt5B3rRBsHboBMmxrmgeK6lYoUsakmcWipk1pD1XNJfJp3ARoqPc?=
 =?us-ascii?Q?bApaC8fdiDmbGemi+vzvMxnrXmOmiTATOZ0k82BmI1lm781lzoIY8TA6mtfG?=
 =?us-ascii?Q?kB75L4VHYb17i4jNAIHxMDWHA/ImySO9qpmRVRSFJZPmoE+Ywh7HdK1f/YMv?=
 =?us-ascii?Q?jTAGmqGKJGGZPzyP0571nLXU95x6PDXvyNve4bWnIH2+2mVZYE3ErbTiC3i3?=
 =?us-ascii?Q?LJJlMExmJ1TBIK6OMgd0J871LQ7A83GBuNDfOeeG8DOGO3Pt7KUzKFTzspxz?=
 =?us-ascii?Q?c1l48ooaWZQxIWV++EC1acJ9P8TDtv78lhONp8ny6axjgGj/t3tl1a4LieZ6?=
 =?us-ascii?Q?xZk8orFkWUbVpfuC0aSJb8pPj0Vkfu0lBKc5sGetr1/avzozQdzDEUAiKMJ+?=
 =?us-ascii?Q?FJB9cVDc7ZGbDg04sjaantD6yqZ6neFSLIf5zK8qNUVx9LN685MfL9wghtMj?=
 =?us-ascii?Q?sWPi4QhL5Ub41SUTCoKML7Gu0s+P2TK4HWmGRSaQm24XKBIC2DFOrgKR1T6+?=
 =?us-ascii?Q?wIROhPHPBBAAZ1S8mOZMPSfKek+aS1iN5ev4QNV+t088RDvBLRYDdAzWPljy?=
 =?us-ascii?Q?2EYfywmgvQmVlO3hSbevT25BDbfHlOQcKsb7ocLMKsaUHtGttEZsJBI3UvjX?=
 =?us-ascii?Q?mh6BAwE6qo3NK0nK+iZs4p6T4OdDmf0wJb7UWC1O1ZxNzAwUdeEfnu8gvzte?=
 =?us-ascii?Q?mtnXA2wzUxTzLocLSkPs8vR0pya8btZgr39EwZ5UN7xe1ynL/xpBGRxsGyDn?=
 =?us-ascii?Q?rGczzifRen45ab/kUUi/5Wl+s5UMfQnfNdOyJDuVwWXyCZmboYyQ5Xcrj1v3?=
 =?us-ascii?Q?GFO7+H0+UeITjqW/qgKJwjdWCW6SS322WW8zVMJiklnasJhkj/YD6qS0EIv4?=
 =?us-ascii?Q?gZQpRlx6vI/9RxTOABtiWY7sRzKnsm3OE1GP4nm2YRXhL41vsh5Y4lP3vi3y?=
 =?us-ascii?Q?yYLZl5WwMFGhH6G9x8PRsUriSJ4V7H2F27S3eYewOh9WTX24dxLKmoXNeCkV?=
 =?us-ascii?Q?UKha+MJ+FGKTBpO6uMQX2kqUBcEa1apfDRkMy2XTxL+O0EyY/XjxWy1AkPea?=
 =?us-ascii?Q?a+VnMkwcmsQozS0WG+snqjC/DooTmwo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2954b9db-e10c-4e5d-5805-08dea6a92f8b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:11.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1jc37f5WfHq2i6NF8R16d88Di7khUAA/mccs0dRxKm8GDVfO55FdE3L4jH9HAG3frM5iab+yBteDs0gexAUTbNAzNrU2NXYnR7Ac8r7rho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609fb..25de8929ea374 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -156,7 +156,8 @@ static const struct msi_domain_template aplic_msi_template = {
 		.irq_write_msi_msg	= aplic_msi_write_msg,
 		.flags			= IRQCHIP_SET_TYPE_MASKED |
 					  IRQCHIP_SKIP_SET_WAKE |
-					  IRQCHIP_MASK_ON_SUSPEND,
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 	},
 
 	.ops = {
-- 
2.43.0

