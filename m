Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE128437851
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362587; cv=fail; b=oPybATnAO0xcZ7/1lHazcRxJGPCt/xwzRRNqPIZHKEw3QuJ/d6ptQht6vsxpOQZ5kzJTo2AA8XY8kTVsuj06i9PpIwVz2TH5NtW8fFbwryXfxFlm+/HmNHydOv92yeXJGG0nW3mqyBvoqXpBhuMPC3xuSTDFGNXJ/eIuJXCyuRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362587; c=relaxed/simple;
	bh=cR9Rrx2sFu9lDuyV8bq68p2FDh5riwcqhTJNJDz1VB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EzGSM2Z3nX3nuKxe2rYYJPePFNjVw5/6ZGjHDC7asgblmR3jY0B3YZOkGL0tPg8sgPiPnSSqc0sqK0OzViw7QnNvOvQolXtAX6rmusu8LoFffIPcVTFtPfZjG0KUEtxwkjyHq2XP4bBBZIUHZh9JAIBmcKmdkF5wnYcEf+BItgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=k+JstDi4; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="k+JstDi4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHRFRmOhlvZkU4IOJ0CbduL7zeB5L0BGEC7iljMVsD5oV9cUhL1AiVhGiL1VG3YAXy/E01tdkdl4cx+S+tFZl/Gg8/6nCJlmOiK+x9RcTKNUN0+1UEN4o9NAqg1eFkGfV4RbHgirG6RpctEMUOdHmp0JOw8HjeuQvgnsW2qpYNfyA1rAWdlKYvxezffapms3TCv5DoUB3z2wH9JEy859eXPz1kHJxJ72cU8QGX3gVu5y597toKSgLDGddUYDsyoI0jbp3roGjOn97WGoUPK62HDlLAjQCldp/l78rxo7GjNKSlXY6vRWQP5KYCbqxsgfNeLeqh3HnVfnjLKuYTR9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEIIDWiOmg/0kajlvYUSpbv/F2fmI2Os5Mi5Cwng0NY=;
 b=CtacLhkUzlorA8XIK+nDN2xQ6lDfEDZ7WHLRX7RtBSyWF2m1x6X8Trhc8jSwdJdRE8IpgaBn/M3xlAHniGrkV66fHyiI4qtTI75109zGSt8e/hCfXv9teWzudnPaapRww7vWt+MK2CZy+CIS0ASxqFyJrK7Puvk9Jgf8pm5Mo8yfhay4Wtt9A6aGFwFCVW4i0R5KaozvesTo4hGQ2BPNB6h8dhESwjnlPaxbehKnZ6NXvUEcD6Kqtq9Uj3cT44AK378Iv8qVTaDIdb6izTo0bDsKbJ7sjP/6vl1iqYMNtX3wixHQkDzyfxNP08JyKeJY+UsvkOUOTo3RCtorennm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEIIDWiOmg/0kajlvYUSpbv/F2fmI2Os5Mi5Cwng0NY=;
 b=k+JstDi4MO6XrFelX5vvwuGr1wkjMlOz4XE9e1SyM/jJwtNyBQYgwiWbNMmncMMegFRBOXAfCsKBBzHoVc/lyw+TEoivRrO0RdnyiJsSpzvrui3rZF7d7p8A7JHhE4+tLFY04xFG9C2pE2jPv0TlRvcX+6PpQbDRdaez256SYNWj41q2e4Yw1p3WTrMYovzafJJbAsxklH+G+BeBg2YBm3HARqEhvKI2BKv+KJlcmzzqUZ9daXN6KQC0A+tpz0gIpBPh+ju3o8a0tCTkmeAdyBz3556VyLP4+tcvjWiHUAPtaIsYL6fixXMswYnvX5ufkJZYrZ4iOU5DQMST01I4TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:37 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:37 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 05/11] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Mon,  6 Jul 2026 20:29:21 +0200
Message-ID: <20260706182927.281078-6-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a63e85e-1088-4b32-2b09-08dedb8c893b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wjXFBAli0MwRF2Rwlqx2yYwB9xisSUxFyyqoSIMp8kNENlvz97Ax8z2c1BVULq7qlHyhsB0YEB+/15fVU3OplwE1Rgggy30Qpj9HkTf1VO80Qrg8eOcWYVUWyqG+vNi09faFF9P1Yy60CPL31iY7ow/JCtQMVnf9AdD5iY0chsC4YVO7KunTz0eODOGT2XmArB8Jx29TqS60y2VXcXevGZBwO+4CvuxNNyCYQEl6f+eGQg17ammQKZgk77UaZY+JFkakAdze7m966Cwqc1PQVUTMGBLArpiv9mqY8h3oPhrv1qrUPFbFRwYhmJLLma+SvIu+THQqT+FUE0Xtvy5SOxMjoJ+2nmDyp8xMJOSesqOAwLXwaEL/wrXy0pXugZK88/32TtTuv0AfRCqvOFy+pGEqLs1YKDVZ+PIbRvicrG4u7CnMDwGhdDeimgsN6/DGFV5mX5IJWFLI0a4vzsfHvrRVvodaBw0nlhjf3sXnOFwFhuy9TgDuoxcSB+lhgVRcx4Sz75qu7tdcQVAUtzn26W06Gc9GMPBZ5t5WZPljS2ATC+ZPAOEoEGmhPJCYhniIlhWtD1zLpn/1QUMrAP4qPKk5W0AOiYNwF5NM6aNkJISahjB2KG+Tcs4hePqY+Evjk1evZR08GtAwsFYKSQ0DbWvTSvxRyIZn3WRS4jYj4zk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTmfwV+PucExyBPI2FkjWo28RqX6bGv44wTeDvdd0OLffVnjIBU3r12q1kUV?=
 =?us-ascii?Q?k9+0u/tuRRX85Jz1S8xSyvoh/0DdegSk2j+Yp30rgIgiW3T7DLGQBjIo51AF?=
 =?us-ascii?Q?w+P+oYuNcR+M6+NjplajuAPV11qQYv5l1UDgVmyvd0vFgsGiw/uyxE4GuvO9?=
 =?us-ascii?Q?fMrda+thCF8cMlDs1Yb7bZNg22gcrAED1pSnZa5/vt9S748fF3IQM7p+V3FX?=
 =?us-ascii?Q?1f2bawyovidsHEuDZJYpXyH1eQmnR+3455WJuzx9jlkhPea3WhIHelFFBqAp?=
 =?us-ascii?Q?BCdrJqxSxIkmft4Fou3S6XhZdQKbDnIMLjiZE6LC1eZO5JuHJOBB4a+dJz5Y?=
 =?us-ascii?Q?OfWGH4DsgVFiC6Nl0O5sSj7N7xajhhPv2fSKS59AnEA9qpdoIFUKEHXT4pxh?=
 =?us-ascii?Q?WJMC/+mHMUdIhmFua5puSvHo3WXUNd57e5RuDff1L4SHAuflJsmhZJ9HbW8w?=
 =?us-ascii?Q?xfbi2mGwHoEQddzMqUUny9Q2rKcDSO7HEedhwtypIbZjHIrhQtX+yZkYTu2r?=
 =?us-ascii?Q?QyY6cUuuPGRaLhyXKSDpRNwBKJSSrdI+5wlcIrfUDTI63kzRA6qmsjqxyshE?=
 =?us-ascii?Q?H329yzXoPAGLBMAp0jLnCpdagmHjFmRCh5q9FCslrMfCRty84Bph9hDpYp5Z?=
 =?us-ascii?Q?PN9xIwNjd/+a/j7fmczC5MrdpR5yTFX6ESa01YOS1zxD1qqT17eQhOaC2MsF?=
 =?us-ascii?Q?cqt8+keyta5e3X5+ie/o7zMWhEYgOnQQCl1csTRWqTVqoWA80uTUSJz9Pd2l?=
 =?us-ascii?Q?2h/DtX55HRKx8HnTjbr2CNmkXZetnzX0Y2erZBVXUF+i4+31k3Z1UhgcQyGk?=
 =?us-ascii?Q?UbkpnpY0U+jLFoy9qFaaqx8uYkhMNuO50hH5nex6rbtD9VsbNJG929paulsH?=
 =?us-ascii?Q?XCMkaVpBkB5BQk1hEz6bQMAbZ8UKXjRA4MNPnEAA3xXG/ASJI+LZ6FEIwxKH?=
 =?us-ascii?Q?6lLNCXVTg6zo/IGWdV5wpg6zgIGWIFglMIoMsoqmXTBqgdIliNNL65VPNVGp?=
 =?us-ascii?Q?Lxy18MeV7wB+lIU5nlUf1W8d7h4kZRJF076RT96eLUTOmK3hMKm4N7W8/UwW?=
 =?us-ascii?Q?V2C891Zi07nVk2599eVA8o81SN7QzHol7bYV0v+E75G76yBLLngVCP8FhKEA?=
 =?us-ascii?Q?gzzEiZjY+UWznO+Z99cKzq59PTlJQr9YfLDipNqaT+wKIvSzYwOow/chPBF6?=
 =?us-ascii?Q?NBnLQXvppQ27jK8qNETwIpg1qb38kptMNY6wFb6b7FMA1WgGGuebPeTyiRh6?=
 =?us-ascii?Q?LNmLKLvAEwK4dtPHuI/kVJdlgWLhjktVMmxYqMxxkWhSPb1wFdXjG6x6JHJY?=
 =?us-ascii?Q?hHwI3XPXvqVDZFqaJnyHpqUytHLpfadzCqlPPaSooj2klmremosdw8RDrCZk?=
 =?us-ascii?Q?nSZY2PSagcTeU+RxzG/qdpKvkWMOqkMNUKhKFcUAC5CU+m7xSCDucjE0IGHd?=
 =?us-ascii?Q?FatjB0I8xKSnFfM4U3ppUEn3g8JX3yZ2xPduTUUvRdcCmdUv6kcFeN+7nqsi?=
 =?us-ascii?Q?4RzDLocVf2upo4s4W92irn6oWvkTIrR/dMkG2XVJQ/Toicx3EtsMraKNhmy7?=
 =?us-ascii?Q?9RFUdmA+TMv3uRf1Xpr8DceQA5lGqzGrX372W6aWZqA5fhTVwfqrTs6qxrFj?=
 =?us-ascii?Q?xP2VJKAtRDppqRLMOcdTy1okHWjYoUCjjG8YrOK+8HZ4PLLc6q3ZhLbbJcR1?=
 =?us-ascii?Q?JL1u93kxGWMVvmPhREcrohBDN2mkzKS1ZXwXTgv/Vp+GBUqT+gP6zPvdWf87?=
 =?us-ascii?Q?f8E7F6WVBPlppsEbsFmO3ZnZsGEmm8/HpKWSYEUaXy/M3v5vxRUJ5+CpD5df?=
X-MS-Exchange-AntiSpam-MessageData-1: zoMnfHByrndAQ9BsBcl5K+S5cf6VPi58xBI=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a63e85e-1088-4b32-2b09-08dedb8c893b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:37.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqUTk5u8mk/vXRUOFfUFW4eGEyqIzm9TozGRDbNEderQS5qxfLT+LSzY8DtDC9sbwUncfaQXD/7l4XsSXnlBorgnzGjS0esiXDtS9a3cvF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

