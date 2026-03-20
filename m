Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DF3BD23C
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042638; cv=fail; b=AN8VACoSvN+GvyqWs+Ky7zLRe1LIwsOenER8hY5NciY9ybtonnXLlYMm7PvQ9eq6DaVGmZtmoU5gpNrK09SJuTI4xzu50Nt0hz5zwI418I/iUpy2yL0RuNMUwvc5ujjONpO+hYrtsF1lS7vGwVPRiPg9oc7kEfqXdnA/9i5hyyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042638; c=relaxed/simple;
	bh=Iy1nrS7eTil3/oXfRjKWY9VqL4hHynOOdXeCqFnlq7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpZsIPP8I0zEqipiDLXSfiPIb4fNhdAEhMqLUNL/fhJlJ2u7hS5wz8UrGm1TRNPVz+tMLUSVkQhZ4pzE4Au+tOVCdihGfLY4AIKeJC67MCvM6evQlzJ24nbItl4JNDqUccKXsxMut10NtGyR1APWdK4qWgQc9my4585nud67tow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LWip22Ah; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LWip22Ah"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unob1k/+SmqKx6VzllR5HufJ/ARVv44Si51KLTRBuwL85zi0/dsZQJvJdIcB79dLXIFbjV/OU/80EEo/Bw5xKbVV6Z4zU+e2mSc8POwzM6M8ZOLwjxljjfkZirfiVlHCQgQVkVq9w4O4wLz86oyHsv7HruO5hh/0yPNN4ETnTBk6ah6zEWcrWI3669uyV3iYPCANNNxlEcvQTQMJ3ox8Nzf42SEQkSYKCXuP3Oy0fXO9wwQLuX+uMs4LHOe7uvLMFfJwIll8vGEf87ktNeH0h4IdsckTZSO0mZxVbHP2ghEu29Du72sdKVF8ppmizvvIFT1bOt2D4C5Hm8I+0J8YOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrJvV0msrN9WXt0uB1adKK1oFxVQ73oPXYPTa7aT/Hc=;
 b=A2QZCKFBWCerXIPCRHmjeQjlIPWsWO4uJzAdFPM4sj/gjwJ/4kvh2MbRpibwwGiA16tHTDsHGiCkqWXR5xsdG8X/2iT1PiCNRXN0ANzcIhJYq+42M7I+wWP5JLghBlVKf9EMUcLCpBl2KRN5I5m8KAfGAK4W51WDzXtjaoW9GbbRlvID+OR2DkuHAe5bERGf8ekisQw1zD2dYCjGYRe0I2EmfV+NmfcCf6SJ3r2wM/1hqchujxVSaxFQ/cefrT0YAZ3d1uv6zXZM/33DEtV0cmLLQyMJwhHrkoLoJXfS2VJEQvB+mC3qxJPtDb9XYxRCfVS/VVon+rKIoZnEVuR5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrJvV0msrN9WXt0uB1adKK1oFxVQ73oPXYPTa7aT/Hc=;
 b=LWip22AhBdu2CLNl4ezQKmrLLle5OoxUswmR80EVaFYmLgyYYSp+v90xnY8GuFOKMciYfF6wEzTtI2f/nR6LWjtf/6CsOQbFgDbTZ++Q42Zoiu2g86YO6se7dIYaFkJHuxUObSuh2Fvo79El54kNzNDmDbPa65exjghu0NHTt+7d6y+8ycgtwTMKpS0YYviLuWIROSBp79dhicTR3vpyjGh1BNqIkvy6R68y6ZVLnntGCbopKcamvkpwmneg4IZCI2y1y3VFil4/AM+J2E1fg48SyY/8umyZUMrdad1jWcUqSXFmaBwOGjzon7ne6cMmomOEvgZMU4Tbp5OmLoFeaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:10 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:10 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 06/12] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Fri, 20 Mar 2026 22:36:51 +0100
Message-ID: <20260320213657.2210419-7-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: c57c3d33-0ef1-42f9-06be-08de86c8d75b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	mrLR+BVza+W62ZG1Qn0ewFZKSBlcK6IppY/W8F2OzH2DwU/zrSxj0pa5N00BD1N8FAG9hBzcpMl44p1ou+hOVAB5LhLKdeHee78wkrq5ZI/b5rdMXNEYOEg18KkuUJ/QTwKD+MotlY8++X2JE+2wP2PmI2NWAt1k3h2f+ZqnQc72iX6aZDYs7a1mHU//KISCEY9sg16NgZaG2WuHwxnobgHfWagNH97e4pIfF7NxT8sFc/HIrK7HLo8lVBvFtg+bLpaCBc639tfY61yX/hDQXEVLtGA687NdiPYiIeSO+aWsYZLeH6VprY3Ey7oSZ84kanvBiqb4kUD4vxd7FzSG8jt4msc09yAqucmif2eruouiOOn+pRVILcH+gipz2nfKvWj5penkbbsihGXf4WC87BdMsbe1gkq2vJFnO21Danr9jA7pDQPJ7K66C9y2Oq8ut6Jo3ehHHVmbeTuwOzvdIg4nW6p+HTkBmtDFc+e2+CeTXPjNWKRFLXILxZU8vpV4cj/5OWjRXIa73vW/fnRXIQqIBA3v40zvuCH6TfDA2Z6wVSVINNuR+jLDGnaurk22o64Jn7KxC2SP48WyXI/zPXRiVmydNsGgj0owHlArTHTpbzod0G4PBaudnX+pCRE9xAHnMqEhCClHcZzb6KE5QqJ+IINGKKpTCak7t2ZZHWvhxF4MlnZ0sdsWSKqz7vDwH5+JNBPWo/shsG69/zCmQRf/VYsSr4ul9U+0RC8JBdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGgZvm4EULy0kLG6yqckh/3veI2kOEiYXlcQxJwMX3JLUaEeQh4LdGEijIeF?=
 =?us-ascii?Q?PJc6GBEIs3+fhIg0XUtrmEYJypy/uw93MgFJLTDYv8UB6TeBD9kM4UZLEV0H?=
 =?us-ascii?Q?6hUvzYPPyXTvPZCvLrZW0j5n3J0E7u2WOw+XFbGa91yix8nBB3Xim/wHGxNv?=
 =?us-ascii?Q?YtvYENhU49uurSXbCh2XFWMDEUzww8TQpi3jH+BXmAeTQXiCbuOtkZQ6qCLI?=
 =?us-ascii?Q?JQm/GxpOeiNQiMZb1uuXlWuAXst/akQhPGdrb2BJBvNbiqpU82drxQU8CtEH?=
 =?us-ascii?Q?yIVd4A3hwb+xrOmTCKB+hKMaqKiLDas1W5n1vl94fbMCddPdvoMFS1kaapXG?=
 =?us-ascii?Q?DTidAYiBnQkOHBYhhBxem++zPBPaGBarBax0UTcjRxxiC3toelfPeFqqFJUK?=
 =?us-ascii?Q?QwKsKC38Fusb6fmcLvIPvxdFJ/qgOTbgBJAViik2XoexJ+asaIzTJN/wnuBg?=
 =?us-ascii?Q?KFHB5gfsGPpCO+lXegv0wKTiUigaYscdHUsDTn+71JYs8s/H01+Gtz7rFowc?=
 =?us-ascii?Q?PilP+jx0JhxnalFyn4w/lljWA8u+NYPJOSztXirWtjUui4dMOyetQHJFZALF?=
 =?us-ascii?Q?Cj/AV1Vnd5tOxldATCCRGONDCqtZUtqgrwdL2SQAyJuqW95nCAb756x3Uz56?=
 =?us-ascii?Q?RXJE5RDf3MGRZQnCD29RGZCNo2nVCKnU7qGYPWxsJ6ff+ScrwqdAFeyZHiOJ?=
 =?us-ascii?Q?Kwu3lRskWfEycVEpYsvwkeBsIl9zdmX7ItaWh7yMwCAjS8Y/KsiehuvgKMtV?=
 =?us-ascii?Q?jLERmo7/42naw9R5nWzZFQTa0pBPzjk63G/3ElwcjYGoelEGtW3g1LzjHsYo?=
 =?us-ascii?Q?U+6kuHeqpXtf5ETLs8j4HiCLDQk5B2ee16pipF6bHguJ6DgLnCKi2Xou8gG/?=
 =?us-ascii?Q?uN8RG1PhSBQ/ZALr/pQhFLtHVUIMX2p8dxMeED0lLR7c0g24zn8wkxPckHwH?=
 =?us-ascii?Q?rCOyjsjpIKy/b5mH062SJUPluKH5quWuKnLpPBxupe3sKrzXwQCeuYM/eB/C?=
 =?us-ascii?Q?L0kwxjppIanmXJk6nEcCzvCHPXgEKc4m2tAlphZ7uMoQH0/zipsRQgHIqU2F?=
 =?us-ascii?Q?+9VB39u1sm4tenLc4FlKnmn17VXSJQEPUYKb5HPN7h0sIQOCY7/nKQsCl5PR?=
 =?us-ascii?Q?yMavyczp3gUpT6ACAdCP2bQXHIkm5vbPlGj0fjibirYg9N7QYYP75laJprmM?=
 =?us-ascii?Q?7q3C8y6t6azo1VzQBdkXcdJcSab1FjsrUkP/qeuJofWLYLtJx3gmldhR58HG?=
 =?us-ascii?Q?UHbyK+/x+fkabi0nvXGS4wk82PywbsvUmQDKmEYRnZfTwfyfPVYjNDVoV/4c?=
 =?us-ascii?Q?Vat5wBf2Q/7WVNHkDle5AL9aBTic6V8vMTeK5BbD4hl/kX3/Dq7grg7EoyAM?=
 =?us-ascii?Q?GPK+r139867wD6vzryPqI5Mb6Nj7QhmnrGfvJw8Le+hos19y1Q/DM3B0G4LR?=
 =?us-ascii?Q?QwRz7oupgN2M8zJvTG+LgXfh3f3ozYL+Cfo9u4MD2QzZcX3gOU5KvHb0KR0T?=
 =?us-ascii?Q?oKe/xPYQDWauillexMN707h6Kme8z5w61VdpAJaDemvPn8KnCo/S6dVz9IQq?=
 =?us-ascii?Q?Dbm6BE/cd1LUU14axd25LG7A8I+4W64vFS5lC7iC2UgzaWFx+bVzzLbCN6oB?=
 =?us-ascii?Q?x+Uy8ejbrdV+2Z0HqFpLoMjTrqBA2adZxzGrlMJpE9QLaR/k9sgCoLywT3aO?=
 =?us-ascii?Q?kTStQaTVllpecrUmLaY58pCYsAGgWz48E6aG3LZMxk1Dd0Oa/RdjtBCwUWwd?=
 =?us-ascii?Q?jSJmV5ShJawbNUH1N1ESlpLwBkMwLuo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57c3d33-0ef1-42f9-06be-08de86c8d75b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:10.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbhmGAsa43yNhn2ToQtkt+3ibGjncGv51v8j9zg8VrvDOcArDxKeR7bzx59p1HlK6AoLKl6I726qps/IfEOef7ke9kBUqgBW9x00KfK/1hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..0b0dafecbfff 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -219,7 +219,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_retrigger			= imsic_irq_retrigger,
 	.irq_ack			= imsic_irq_ack,
 	.irq_compose_msi_msg		= imsic_irq_compose_msg,
-	.flags				= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+	.flags				= IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.43.0

