Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763440E8D3
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237166; cv=fail; b=S7vzuMKqsoMK5s5I9PdMCjXY94BEbJZQ8fdrEU7ZcUWRF4Mtg3nWGp+ZPwktBvjpB6VERi+zgxYnCL+7cmjBnPn0TOBAcV2ZI7Mrm7unB5445s6GkjvcBb/gIZbyPnRHctDt0iqdu8jsp8bT3zjpbN4GwDiurx7FNRFuBYnIB1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237166; c=relaxed/simple;
	bh=LgduWSsYxzm9yWIzp92uq9Yyf2wuC04qhjFPZr0uHmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfXZFU8ce8XlI+pgyCoahb0nwa4B+xf2TqKVrIhypDOdAmzWfF/l5wp4LEkSZhfM67ln64JT/LQ57V0bVZCpBzfGMxtew/ex9RmJ4rbMTYy2W+mYWmMf6ZI2mxiMwcmheGwM6DUUodhtAPkBCNsfANy/vdDK3uBCNXBi4rQCMqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nia+NVCN; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nia+NVCN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXXHMOfpb85tGHhbxJBJg3IIr5WD81sIk2iiDuCO7GeEqocq7qe3VtAaBAjXYdedCy1WweGqpsO8llSvFnB99wNWDr0XDNy65hnbJU7dBnNzpgK9Q/ZQYqLR09nN8q/aV9BNkB4Dg65YmEB3X08wr1KvGcmQoFlldTUAW0VuAwKQ/wIUSBZR5FyaLLBBUbeMKI+p6v3UXWW9xDUlnxpNu64A30emHZ3MRFt+dZMoAkzkZ0OF/F1llZQPI2nI3gYHXys+dg3hr68yGlb0GM8hXAkGUETitVk5/yf2nRVpwKcvYn7aGvV4L6jGOW2qN3cqm1qY25OtjLvXHOzRfdR7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlZGenQp2DOsDhLfM1Nvxc1dTvHotvKJaVnXJvPTqZc=;
 b=AidNvwK5w2L9tlsiSohlh/adhKmxqq3Kg/ItHheCWJSGJ6jPso0kDwEgMKEZNiV5Msyf2X1K/i1S5AEAmpg8/VlIAMVaUMeb8kpACiviQ8/DqWfcRyCJwJt/TzRnenfvCdkCkP+c2sbqtjCQ37eiTrhGPfBWn1bmtk1FPCFCktUhpJKw4M8EJJ4tEcEmDBzKXnBZifCRa+d3PFbB6nIrYsTiJlWcf8mDzo2tvbPKDmPWkN7ZiP+Yz+nvXn5QR3R01u9N1w5G41JyGFKqL4QeE2xnDOfcchJR6YELPUv0akI3hV8jRebPru92mst0qgAONvBmNwx3ohYfYDs5Vw7r7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlZGenQp2DOsDhLfM1Nvxc1dTvHotvKJaVnXJvPTqZc=;
 b=nia+NVCNUcOio16uxowPQyi14NZ6g6Idrg8j0XOKva/UHRyIKiag8N5dr5sxdj8YdsS31ZZEBX+fVodN1ZKRK95tCVYgmpCYNWwU4OkHh+2oumayLiBYnbXGtOWKIPsl0T3i9/m0MLHYjK1fuFC5AEp43al0coiM5x5wwsR7Gd3Rn0XERLMnhyXn9afbHwjSxjzMgbtqesbukiP9MNtz/2m/DNzUyOrihL+qP1KhOjKCh3lHxM/BcJF8EzV37O/Dm83itcpkcee+xbD6ui6xpjGGGvyRfZ3WcFE606fK4UPIiLZ8Yk4qlefPutZnPRjtObZaps++efUVSLbTfYs8sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:12:34 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 10/11] PCI: plda: irq_pipeline: enable pipelined interrupt control
Date: Tue, 28 Jul 2026 13:12:21 +0200
Message-ID: <20260728111222.2699158-11-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
References: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: abcba90a-619d-4685-262a-08deec991feb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OKu/V6Zmca85TSvUsZIS9RQ3lWT8ImUvOLXdGhA9ebOZy5ZCyVvheDHNdXWcm/nbZ7q+bqFFP5gqeZ7IY5lUoihXMXQyYkYw26MUHRKvl4g5H1fSmZM7AcKE8qrirkMKa8shE23NcIIfGd76X7xnt4l8RjIyxScZg+QqElVooTkzjk0r7sMnPOdXD0bPFwodxFZYgf+CXQ8zFqV8S/9fuVHSVRGn33Pz4xL2Tf/1LwxRVRLdGtg1wULWVuMP8FArS1bRJQKmt16USK4TvlLARbxy8w1SDIYDKwm94iyI8ew3zVQ5d2mtSEkyObxTIe+SSokXjGuD0uYTtC+T7+iMjWnCbFcoh1IpUjFwWLMk3MEpNuYFTndJ75eSkJlrzh1a7UtouWF1exWDGqQnyMAl73nJ3JGYoQ7eF7EVVHq1m1kkLA0rknpgOwuEj2s/2Yr8fNSDTZlFKNQpHWHrPskdGZaK/6yjznfgcFBA3WU55GUG4r0pAMOfjH25pw7xeltq5/iglXrbtRXFH0XOxe16AW4Lg9tPck+rca9XeQvUSP54MvTFilFBEgKFSY4Yt/eGux4H/PUDwaojUa/JbkeiFHlosGIv28bTRgvnBI0RogrlZohAC3WpzvVCRJfQ2xegwJnK/w4b5S4k8kzqPaRBlhR/Gr67eLRx7o22Yf4LyaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hRDtqgcwqVzBiE+fx352QwNReb2ISEfcFRBaMQ/gL7bvqrDZYPybz2+OgdV6?=
 =?us-ascii?Q?U27PASi09fzm2xKZ7kor4A2LcUBO8Z0gLlJ2vMj+LIQimNkNCWhOq7Eh+dQ1?=
 =?us-ascii?Q?08SvYJZQNl4qykem+mfHxkoSXzyGjTMSkPc2SbDkS0dSGHNhLYp9QO4DG3zA?=
 =?us-ascii?Q?dSB53OKSZU3F+1kl0zfPpm2RgvwOgOmIT3shUNcn6pnjohBM6Wid1NLi9fMc?=
 =?us-ascii?Q?WLjAAy0KbB8R7v2u6bJJNZREpwRtBtmCynYt1Y3Yc5AFaJ0MH20LcfGR/pYz?=
 =?us-ascii?Q?AzEv7l7pA3ydmZW04Usz8Q/tu6oo3AZT+c0Z4jFullzxwRwCj+N3hcg35C5F?=
 =?us-ascii?Q?P1JGZdPJCzR3irDIlO7Ce5dg/SAnYCd9iEMhJlYbSnLOQwSaMbJNl/JRxkHf?=
 =?us-ascii?Q?Z2A2uIRsUc5eXVGeM6OwHc3tXRDr6mFLfjJBFW//ZkhgPH8rKHZZUI8sFXKY?=
 =?us-ascii?Q?bLbBIbaC6M21RRbHha+a5DcaIWwpgSKsrRfg+C9veVnELmwPWD3x1ajLX4jw?=
 =?us-ascii?Q?gRGvGffyshWTavVNPMT4JonQIeiKEOx6NZP30WlFsXQQMg3EvAiLmIFwnVBf?=
 =?us-ascii?Q?xi4zwJsE+BLN77S3ABHm+MiDrUPk5PEgfl5XgjlAyJi2V6TgcGtjJB9rWxJ7?=
 =?us-ascii?Q?XVyu6QApwacFGhz9GD80JJUsPCPL0ohS8virpEXQl1xKG5veeOpXwU/YBeCT?=
 =?us-ascii?Q?urfcritgv4m6f1uU07a75YL5rqXScRUrvMdM3YcSxGHbAM6gEBsI7z9dHibF?=
 =?us-ascii?Q?nQSXjk7QvE7MPWuMWacqZCMBXUaVertIUOcgKbmEajkU1FEZQulSpIwGIbHv?=
 =?us-ascii?Q?BC2i50TAQsS2a3oYTPL4l13TnzbVGDvOiyAWEqNABEkkcMht8LZdR4SCkcOQ?=
 =?us-ascii?Q?8KcexTF+R2CR5JQa/lZsLuUSDPSm3jJrJ6fTDednVOf3fAE0AXdGdhovM/Qb?=
 =?us-ascii?Q?iabtfU7FrE0zCn7EcL5HcB3qxPBRfFaClSNnQKbADNQO0ZfZZnS6QVCB3Xzr?=
 =?us-ascii?Q?EliC7kt7Y/+C1iJcM4iONDJFtrh5gt71I4SgnxepBhZDuBVtJVbXuLO9N0mk?=
 =?us-ascii?Q?LsfgvXo+1p94UMr9ygmBAflJ6f+uWJtryzQMmQAymFtZymtzn/NEKhRYERAg?=
 =?us-ascii?Q?9nVRxnshKGqgpax4u+Z0xeD2fh58P24JTHyT+OgR3jP26+AT/JuKZqlaB4zw?=
 =?us-ascii?Q?iQwf9u7ZklGQLDJhZYggQuGYHJAmtDEYXzEQIUm3ZmibB8XES8FO95s9fgiL?=
 =?us-ascii?Q?jUG7GmVVmL2NauzLr4niYw/xaj8G6i4rmM0Kzlo2pHp7oRj9v0roZKrgHiGh?=
 =?us-ascii?Q?Dqe9ZOrIUg6WZJ/50COTIYlTEVONyOm2pTryh7vSXw8GMKn3vNd7FOILaZcG?=
 =?us-ascii?Q?BPtxXDCwiWk20OnOetyCJmZz7I2SFEXB/KCeo8mmkfgO2IVSgLcjI8V32WEs?=
 =?us-ascii?Q?azUjdt9W2QwzsL5XsXHO6iM/nlYeirJqa0h46p52IeboAG5ruhPOE5cPSqTt?=
 =?us-ascii?Q?4NDJxVf6FCL+opWyhMzq6GHrIqmAoEt+Cwylbpu/gb677ZISjkLW5ZqIgo4P?=
 =?us-ascii?Q?UwsavE5tW0KF5Sm0J5yge4ozQz+PpLQp6ES6i2vGBGile9CbaNNZm5c8ZWo1?=
 =?us-ascii?Q?qRXHbA+CdHY5w5lYWBM5T9hTTeFscaFX6X8SZktTQEq4lIM6VbX6YZar0WZM?=
 =?us-ascii?Q?YuHNuE+VTWxHMe5vI1R4viCwyOi8CTFdynzFIinfgNjczLLucSKF9iIdrl/N?=
 =?us-ascii?Q?hzZ8A+AHCKb/D2b/d0ffIQiqDxlg8VA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcba90a-619d-4685-262a-08deec991feb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:34.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owXOWh3Eu/U6iAQ6fBGaa38k68VBW9YFr54/2MF4RRLcCgdtUFRA5qC1hQcz6cH/KVp/sUOxo3Y6PPMqZ//E0ZIqgFn1oj+PhzfoZjktrBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

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

