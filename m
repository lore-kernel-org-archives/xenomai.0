Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6D3E3C40
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547481; cv=fail; b=VFs0xuERVavwzEFl953kmI98oYCz8cVnRGo3DcN/9QTqSL/DjgEFbovPFmrNo0al4tUibAs4nIG/KNmd6TVX5yaZWqvmEEMrJjyXYu8oGrfL1xkc//e5cQXY21Xh0TztMHwtHUqvLo9v73x+9QHjBhDfy3PVsBsPfniRv5DmQqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547481; c=relaxed/simple;
	bh=htqJAWBnxuO8wr2E/dYCjndtP8DRoo3zvVdMCDlf9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axB+aig5aSRnZNQVSdIBxCOLNpvJEAOcqD5qcH03hPzuh9brTYjt4kjiLeHZYLW0Ws6CPFQbSEpw1yh23k8xM5bCfTF78/ux35poSpB47vh9Th5qp96pGcLX/cV2qjH7awpa5p4HmHPL8hrdtMY449oFc5foXGmgzzr6xzr2dEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FSho64H6; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FSho64H6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WghaKYp/H2KvRt/liB4ttEtSseht880Ad6wvooScm4r8izTCJcg8AaVmcLFAUq4jkSJhUI3QUPfIWyS1/auqBUpu4YZSr08Vq8gKo95zk3XIQ4yQp3TPmPn3zeUEZmTYRkJZu0rQhEJFEqbtfm36b/v/oyP7oMGxoXadrAOSqP4RWGkUMf5zlxrZjxydzI+8pR9YnNEOsEcjqr5OqwIPX30TCpteFhk8ln7OCjxspc65Mykd4kLGhQrBxDikuVvK6WFpRKkclnaW3k0b16jR094ysUNlnJAH5PPfLuT5coPe+86QQg1cUVDT+HU/WSG9+Sqg7zlSDMPwNBOsLXX6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVIeA/jBXLc5eA9WVKIvfc/PBBnrsnc8K0hOdQWZlbk=;
 b=rkk4DQ4dfTZTCUOtowwVBPQ34yKEKYDulcCx+8WUzHB+19AKOYK6V8cKJUtQPDH2PFwT6oqESlIfr/9zbtKqPKQwpVeCg1f8w+5MiTMR7jtP40uzSwBKWprN3cN6zNLeyaVtnFPH4oKE1SR/2AZHZkyFgyEip5bUoXyGA++dpF5GxgPIkschhD4wMRDcDpGPWXCgrg/9tQq7BWqUIX35d3XOpEZ3ek8W3tRJOGg9i7AiehAZ/2VmOnafTQqFFoi6wBy0IBfwImDBtjQE7pC4dyn8GSxVvm9iyB3Cgmwz56K6aePX3SCzMnjU64fMH91LuoJxqFvrSX4lC2wxu7vdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVIeA/jBXLc5eA9WVKIvfc/PBBnrsnc8K0hOdQWZlbk=;
 b=FSho64H6BPVBmAgUtoT6N/ZFhymJXjwVaH9GMNC/5EkIf4ThHRT0DMrMgDVz1OdxwgX5sdfBltkneXAaKUqhJEr2m/S9F4wQpjBML2cjS+weknBIlZZ1e/0LPErTiwWCSID5GbeYDgEbbgaXRgMHe1Blf4o0/1rJ4uqZ3gkpq0BkjCVhr8oFcaytWJxxW7zaKdHf2FgMrWiB1Om4FgxRDSYUCiMGCpUhXiuuNRcOkJ99EMGyLkjbl9dxuMZziFnxHyHPE8zAAEY9JOT0ULvw5e2Oso8dAFzfC3jAM2m+1Wj31BsVM1f5tSVXmy1p5eZFFrRYLaveri975GABG1Od+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 06/11] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Thu, 30 Apr 2026 13:10:56 +0200
Message-ID: <20260430111101.1539377-7-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d5dea6e-a8fb-4f41-c98b-08dea6a9308c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	kHrrAP+KRVQbpXCmqvgtniCtRtimBkTBlYwDC3a960sTlJhlYHt8KMF3lWIb6siAYekTVhvcJqlBMmK8RTl991fax6o7NVhRpp6baleEbff/usVebP+YegssutrbHoSQ3myPL78xD1/ijIZ99eBfHLuarSMbaLdGfUAKO9Zv9M9Pbjag/ktkrk8MycJDBqFVYSPgZY5IVfvs0r04w/dcM9Wp+wLaonLuFwWjExNoE2LxZ3qQsojxV4fLERvaZCsIsBO+0li6Lc8PgtX44hgQaj9/1iVxW5m893p9kGFXWsHMfogqCwcE1IhffG+fc25SStm6c7kwSoejCaAHWhQCzOcQsfOMbb50LAXNvg0VdxRXN97l9S7CCbVKixnDuLW5hRJU4e4SDamr4+ylhORf8sI/GSU7cEt59tnH9D4DHX0cvn16lNAEdmrSs5+tha7QZv2Gq9zgW0hiAD67317rvzdr1JaH54NfQUhYWGUWspgL1GhyN3Qqw5tiFI+ufoK3Om2lMucVE/uxMXt/J2bYq585uO3YjbJa1NirFaRqkizWsOn1HHGDGkkBN5Ot3Lk3blLSnJB7e9IPK8lvzozz5QzLJPR3NVLl+nksilYq83wQ01zc7LVXuuil3lFSVSLCq/Q9EqbmYooJlI9crhRfQX95TUfZulcGKLioXGNBVF2rP3FnVpUfdI92zRg4GgzVU8jnVAqPjikG67758rUAIGwg4y5rnmgCHGzYMLKfrKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R/tGsoTpD1S493ChEqE7AIlWFw2xDa+liFzIAiHVzCvx3knEaNB0XZb3MUEs?=
 =?us-ascii?Q?GLr//GSP7ggN9Ijd5AXaQoatQSdvDpj99c0kcq/z4irbv87Qp+sulrcWD+db?=
 =?us-ascii?Q?yNxQO/aCaSdbcSnmYKNyO8PFh1a20rta+r3beEEuHRuVy30NhnOHIggO79Jm?=
 =?us-ascii?Q?F9vuSczbULlBWGL8ZKIBiPMVxAj5s/S3g9BLHS8fuvpnXDRqJB9PME9Q/cT5?=
 =?us-ascii?Q?lNO1zuEAYLSEUwX0VG0dBSqru5cjjmDarRclQ2gBkK75aCIR+3ZmobgAZYy3?=
 =?us-ascii?Q?zCf5E4guwzdLAPlSguLq0o6sqj3LjP4xUw9LxkYkgHlmM3y6D4SWhAwlwDNl?=
 =?us-ascii?Q?6azvj970B33lA63VgktEl9VGlAX5wcQC2Uh5rCuqI81t5ZtKaFE4or39+pf2?=
 =?us-ascii?Q?BNBjaXyv5tpUBTolsJdPXpUpS1NxDCoZC8bj+wddyUoBIiUxOxdIVk+Sh9p/?=
 =?us-ascii?Q?J2wJ3mX3560ZjM1biWYPB29lVOUqKkSAu+ktbTsRLBd1i1lZs64EQZnQs5xM?=
 =?us-ascii?Q?oIC3pkpxXXeB4f1yZjPf2j8X8U1Qpyx/0E7zkUfq+AjMUEY5GW7Wsv3EyD1J?=
 =?us-ascii?Q?FFb9VT5t6zt4l4B0h2dNoItvIrabAyYp7fODf7mjPpMbQdlMdUNktbNkfPmD?=
 =?us-ascii?Q?wy5DoqIxjiAQyuHbOYQOo5pV/l0EDUUcCZLcrXCsXzLETy9lvY41J8jXnVze?=
 =?us-ascii?Q?UuJUdWCdPjZp6Q6FMS1vxvc3ebH+ytVKe+PKXZ78ssu2oGixxMxdR2X8K+o3?=
 =?us-ascii?Q?GIuV2gNonhhTPfMyPMAQn5gS56MPVsdp+EJj4vwnDMUlpFqvOylBB+b4FbnI?=
 =?us-ascii?Q?MOWDI2i1ZOGu4EMS6sNNOvay9/4hSxXY2xEGUQwIA9sAiDoiPNSzkWZAoSEO?=
 =?us-ascii?Q?ggxi9zNw6S2H3hpsg36uYkLLQFNsmaL9kCnpZYgnJOlGsnZ/OQyyb6CEQBWr?=
 =?us-ascii?Q?WVM74xNIWFv18UhtS3BzSDdJfiey0ZeqKmiU8yUDcEAi+i0WxAihGopS1ghG?=
 =?us-ascii?Q?ytf6eXgL+V+xKvN82nu5PsCB89rS5JRDzTKZA8n0gpEz6E13HpWMUSmkSCQv?=
 =?us-ascii?Q?ZTrs5gWiMSWdcR4J/ezUQM+rAIc3ekzQQOlwcCUvT4Vz7lipaSy/0QTtox5J?=
 =?us-ascii?Q?BJQS4y9L1pp4hXIMFzJ9Dq8kFsWV8XuWd/eeSkSB0Fg6ZT4QADLy8zxJipAA?=
 =?us-ascii?Q?qBu0XX+NHzusoqnnILbj8JjTNcPDQgoddgmEV5plPSqK+wSLcBO8x6L90KUB?=
 =?us-ascii?Q?LRXzmV4J2p7bHxYp9TxgHGCYRb75okRFMEwKuvbKij9kPAtMcmMSasyfU1+c?=
 =?us-ascii?Q?8VdAJzP6reXFDsw7+6f2Y6CxY5krg6Bn3SmYzfM9BWiT/jkSksyUoA93lQmZ?=
 =?us-ascii?Q?8+wc++UUzIapAlpL+C8NvsDwgXjNLYQuDUrmotdMJRVoW9C27pjXC6uPeVxc?=
 =?us-ascii?Q?qRQLWR9Y1EKbgNoBS6ImdYi61QN9tScFHrPx0CWtAfacf/0LFiga+8w+bs5n?=
 =?us-ascii?Q?zMGXBsVETNqx0mxXkrYYvPJbugndsDk+kRriZNizCJGn279YjbpEgymJKjOu?=
 =?us-ascii?Q?vycQsyLBPPluUW9ZGmVEPNUPnLD5r9/6Ly1ob9FeQbI0YEXYg7BvHc6bwqSU?=
 =?us-ascii?Q?gGOsNBIVedL//siuwULrRNyhAfhkWuLb4nWQKZvtb0y3KARudCnYBbpzJyU4?=
 =?us-ascii?Q?NcIIZOMSDzP3YIsxGnLf0cVxF/Z48PC181Ttlf591A7EIy/AuPMRvqJr+2k6?=
 =?us-ascii?Q?6+QW9F23C1IKbESX2zTIxrni2AOPHlQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5dea6e-a8fb-4f41-c98b-08dea6a9308c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:12.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0vp+peZbJ8NgflrW8Q1oj3izXYsyphAFsvM1GP+f2N2YJRwqTC4XWXvh7Y75WwvSHNsANLw6mLVerIXqu5DJ+sJu6fsuyWBodxbPlbWVv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 84418dbd5a270..855ce8dde27aa 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -111,6 +111,7 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip andes_intc_chip = {
@@ -118,6 +119,7 @@ static struct irq_chip andes_intc_chip = {
 	.irq_mask	= andes_intc_irq_mask,
 	.irq_unmask	= andes_intc_irq_unmask,
 	.irq_eoi	= riscv_intc_irq_eoi,
+	.flags		= IRQCHIP_PIPELINE_SAFE,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
-- 
2.43.0

