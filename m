Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E113093C6
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206803; cv=fail; b=DJk2rtuXgrQz7HVs0c3RAWXQwasOHepcw5+lB8q99888GTbChmg3igJPK8YFg92f4Nuu4YKgtbzMTnwpPfkqMzXTTS3WZLMCSE96mX1QIpXU77BEs0mumF5d6zhQ9M9pFldEUuo9yEjCycCrkyv51qzoqOtQHSrxZr2iBNSpmPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206803; c=relaxed/simple;
	bh=t9/8BvTOxaxxtZun+CiCNcJeIOxh3E5guEfLGpcNiTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JepIBxzQrZzTUtxC1O4I/Yg1FleFrfdP1N9ev0Ex7FL8oej3IDyP0guUncVEh4vzVn9bHDhRoWoQY7fYvB5musOCm+8VbMOzjbnXfOrI6iy7z+1OSBNPKTHngBB85DqVDI6/9Bts6NzhgQ52wg5liUwTuXmenSWZLbou7zW9q/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=anhxHsi/; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="anhxHsi/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOZbA9hwN9YmQh1ECGiakG5SwwYFg7WjVpzNRdHXVfMKVgvBcgDtzuh9Zcud+OWVwZL+ME8i5GMjbV2TTqOjAwUzwNCvH1xfqQZWDw7yw2EXsBAXKjX5aNnNCX0Fl6ri2JME4aJOy9QXENCx3irptNnlhpiphZLPVsJELVEVHrasB7U8MjQL/9RvGS8FJxGIt2NzRepiTAg2jqlu2kpUTDf8jlyLfoKXswpECDjxr8kjpU2E9EcVul++euu/q1kJK5jER9RZdAEcucx1qidrRF8LGJKPuZOy7CD+1CahOOoPg0DyMrhVK8dU9i+cPCYA+XpAhs3wA8fFW8NyKUMwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbpIl8ZTNc2LrKX+50gNgpcHxXL1cOwymo55vLqep/0=;
 b=oKRj+Y/fxTXxuwmrfke5ute0pM7Q+exvsrxiG+ZlEvntkEcDJH6SRfyvw+6i4YDY7YY5PutfiP0vmdFrORDsg4uDYFd9jY7AXbSALrZpZbIKF6OMvEb3Wcb84lzztrorMOT1uxWhLg4UmZqS9Sf6oAF7q4pRTwToraibYFTc1W++0ZjC/22vG79cqfbau5zDiCjn1uwOTCUmi8bb9WCLLZ0qXSDKd8RuTvTSJPZI6AW5GgrJMf/8eLeBScaN5rvSgty7tm8G7aJFrsEIlJnTM6kireprxjMFL0RMb7vbjvKICUd3M0gZXTME62KMj525GZBGcko18Tm55HgZt3pvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbpIl8ZTNc2LrKX+50gNgpcHxXL1cOwymo55vLqep/0=;
 b=anhxHsi/Gg7uFmyH2UEZKALdAU6AeNyCHbm0SRlJqOpKxjn7Gb4UfrHzLRJgkq8pg8E5ZHDw9mzl+W1ffHeXkL7GPugoV5vmVqf538w0ENs/Ubmc03S/BXRMOKtdbMLE8eqwFLbt3tBS8s/3kn5Tkmcreeb0Jg1LGv6kWTWT9qFxYfwad82sSH9FoVD/CX0IriGbhOlcrSsi8HW0ID8X4T1ITizs40QtnEx/e0Vk7WmYJrmBUif6OTGjJGgWEgpJD7dbljs/wK9pU8/Q4267aTk6iq4e3nAABelKgemc2PCD+QVR/iK4ViJtN2ujvAmobqRqvQ4Jom3bjnng59uDng==
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
Subject: [PATCH dovetail v8 06/11] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Sun, 31 May 2026 07:52:59 +0200
Message-ID: <20260531055304.2890455-7-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 56c7cc15-c964-4ef6-1e69-08debed8e82d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	NO3tV5Gwy+sSgrhdCQxICcc0Hh6ogsJOZH48DSmt/MT1FfQDRVvjcrEcPAX/TW1rStWYVp++6ewbvF4bUfCjTphdXQ0WP6Xk6xPK6fzI1QCd7wa9B1LzC6F1fZ3vkI+nZu6GaWOukxLUiUvKQ/tOXW1TZ5zOKALPNbnz2LuQmhJAFo5XeTkbSd4vfFX6E7N4bQWKgEItQvxcoGOCmk2Z2hSDwvrYkrI59NcKVIFJHng1ly+ao0CueL+jLZ52CWtNjn4WfNsOoEo1jXiXhvbeGr2rzrhiNn2Ob+32dH5/N8F2etsSujLYqdIeLvK3TqC+xUuOD1WoOVimt3PIMM4tC8grM/5yjTvSLFiJ1tXb27Qrn81Z1LItU0SF/go7To5EIuH5rl48e1ayNaarRbm7DHT1/AacwxZQzSpOwT9OvoF5R8k13TVaPNCKjfh6NzEwr8ax9Cp3OXbg7Tpm/uel8VxqXEwYF6VPcw4gL87S1bSGCpzHjEUH/vSGQ58VgaoZx7T4vsaux2IcyYvIp99P0PxD4W3flIRkr0CCwytEnywXwZ1pOyxCEa6KljMs3zGVnx59Nze1MYfm4+ruVp96qxqhQNBNwxkJjoU50ri/qmOwM3/AanDn+FEZ5VwnYEGPpRww/TioxVUIKuk3Gnr8Y/EmjCj+q6E6lamawaQKI4NjYLkZkoR7aqAVy3Avl/+E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cXRQ5YHg2auQzQK8YeTI9LVxnPgPF11wis4qEqf1CY24czyQa4270A51rCMf?=
 =?us-ascii?Q?oNfLQ+V0To8yXaS7SyZoExZBh4YtO7AV3s2NWoni3C6uZtH+dcvO6T4s0ljM?=
 =?us-ascii?Q?pva2/tPZaQ79XxgflUj4FxLvBm0MyG8VjCLkMhVN3MvefOofHrkbXswn0utr?=
 =?us-ascii?Q?Tk7ChCMCA1EnAjonERM39cwOcuWjEWrbbGkta8ag9yjPuxg4/IbNHqodU3HI?=
 =?us-ascii?Q?xmoOfpXkfNNMNkC8AVJ+c8uxTq+KqXZZ5sApD8mQBjY5YR0Ksk7p8pcEJ7ju?=
 =?us-ascii?Q?krUBdSjh246tUk3fUTLShPfVnmRtg+pLqrpWwpigXnXYV5fSSYH28yjhEl3X?=
 =?us-ascii?Q?/k/WDvMdwWvPIB6LdZf+UDXjrrIoZpga2JDAYnYKNUHHCV+iw1fmjbsfrpfV?=
 =?us-ascii?Q?R/fu/EqJC3V8bJcaSwCvwzDylTbyWtflETGwOFCeUGJRBqKfK29ZoFbTnHwX?=
 =?us-ascii?Q?sRTb+t85VBVcEDs3hTLsKTZgoEyAJQycBSbs69eKxRSvxeNHAroC13oWVgvf?=
 =?us-ascii?Q?XXDC0gpg9xSXp5/Do/im8RLq4Q8i6bnaqQOcqN5+QUvTdR8dtsboxuJP14uX?=
 =?us-ascii?Q?KAcxSPWjjW7ktqUxeWMpBzrxPHPCyNeXUXmoOoYmtx6zTrawgQnJpSwQ4bWj?=
 =?us-ascii?Q?V1nzDgVtwyqIq9mxg4Ua1vCHX+AApMH02BysFO0lTEygO2ZvkRoYVQuTF+QD?=
 =?us-ascii?Q?hrzqGcPwEIz5AcTviUZQdu3B7Ga6b8yUr/q8HkNnha5qDdxbIPt0RxtmgRXB?=
 =?us-ascii?Q?aQx+8q75kZol/Rx6PSh0WKXrN/i2SPAiOYpI2NwMSNNTDidkQSjtDrQi7hLC?=
 =?us-ascii?Q?ZK0/Z/01QHZ+aTi57dkRUPmyeqcqkJCg5CQ+WBcfIJJOA1okHPLDvS7r6bUq?=
 =?us-ascii?Q?C6kRL86ssVWVL2OugPooBJxbR7j6wiZYnubry5B5NKNjUL4fROyDGvga2GOJ?=
 =?us-ascii?Q?4QguVEjZzy0UH/wDAUVBQgSZ0c5DTDVR3n/3ZZp0LegK+Z5PZ4gIIWQj1p8U?=
 =?us-ascii?Q?MZV0rIJbC5MQ+B7qN5F4SegTmqjb+SCu0aYnx3fqUM/p04hd8WpdQMPhLl7l?=
 =?us-ascii?Q?tRI6oe3aOzlUhdDnQar3dtteXo5ED1TtqNahEGnD0jX311KW+2VQ66v3CHjw?=
 =?us-ascii?Q?VR0sgU6KOhiFhdM5NYlK/xk/rhZEiGGBvzbS+symqQRAOdA/hT8nVz2IscqH?=
 =?us-ascii?Q?Ea5gUIJnTVUl54uPPqlkxgxrG0/LNboOl3EF1XwfCnuYZW4fVVBSc4/KKsGu?=
 =?us-ascii?Q?6/+qArSiMsgY8fgQSfSuPxlPEK0UUbErGPB/GkUxTCJbC6nHdH28EtiL9La3?=
 =?us-ascii?Q?txcAj11PXaEzILY8hnCwdQU8K2FtnJlzvP0v5H9oecqPz5c2YlqICVapiZqD?=
 =?us-ascii?Q?NUQu2XYCy1BdnozENTAHNDN4boWqCcXAucNeLyJfC/7V1SfSJKzli6muc+9J?=
 =?us-ascii?Q?w7Qn5BrKtMIuLs5lBrL3swPWEWpAceCKdxwxgtql7jGps4b4ID1IURhpkST6?=
 =?us-ascii?Q?w7ASzZVO6aK6sHXni6Tmtut/grC78d81iGbnU8tbIyVaGVkpVw4AWAtB+hRv?=
 =?us-ascii?Q?fASpgdsa3/eCpKej6AjP6WiWg8wgP6fspnBxz7KsXsrg5fCgKndXRSJvFvps?=
 =?us-ascii?Q?7BV/9wLs0vtkE9WYMqEcq5DP7TLEMEoOQ/B+i22FAVBv4igz1KjStOgOf4n8?=
 =?us-ascii?Q?rJZUG8bYKBT+3gU9AGTYzwVNvkTQIKlo5dsjILbWV6qcd4FqqsjCSCseV59C?=
 =?us-ascii?Q?U62S8t85kpwXCQvzRUvDYyfEyhYkpQM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c7cc15-c964-4ef6-1e69-08debed8e82d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:15.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kifmmp+XgHnZtH7tv2r6Ij8+OxFwa7WfPNAPBjLjJ0OLCtdngX7ZsHwI4iUUFJhnanPw8RKYsKQbzRh6FAEFNHxR4//kqv/Fs1UhBV3C+hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 84418dbd5a27..855ce8dde27a 100644
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

