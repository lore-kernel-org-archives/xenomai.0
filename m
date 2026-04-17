Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF75191F91
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459735; cv=fail; b=kr+fvoLVuEH9Prs0adIV/kt38Sf4dlpQEyvzH20XQGottjuw664LShDt4DJJHSGTdzStsIeDXOzh0S0emw4kwjUspA23HP6NTicHozE9knLfQe/YcwpdIGjL+vtz90ntSh1uRFJxMB/vbSXCJdkgZkFH+SDv89lzihrGUud04gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459735; c=relaxed/simple;
	bh=htqJAWBnxuO8wr2E/dYCjndtP8DRoo3zvVdMCDlf9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BK/mHb70CI1/oqOzDZLUBErcS2CiFLIEazpa9g5Y3woJlecD2ISBSjER08dKu0M/rut0ZGM3uF+SHpUa9PEJX1q3ZF4W5N1P5D6W7CEJtz80mtTNdzSKmySZ1PT9lcI43fdpkJ2PZH9/qGnW2m3Za7UCQoYfqETN0vhqDJYZctg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CbxbtWM4; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CbxbtWM4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9ejyhr4RZ1d3Zf/FYttbIydMuJIUE5wWQ+ydDiqponn1A2DwAvxD+AAWmb0LcBscWMFXlCBY/kCOkybb/wF8U1exJudPEEhij6QPA6bOzUPrwPVNvS1DBAnfF4xI/o0EQHXnRN6xwJb1DqKP7pCDw2CIcQ7RLEaZSo9vYU5zH2InqRA6q1FLAyAdzhWhnmxOGaIB87vvlkof12EXLr5rMwF81fcv+J1a9/5PB2Kd52EF8Da2HChDuIu7ZP9coRzeB/WJrCjJF6sYymA6j3BUmqY3QSZod0hEsYZ6zdhjNN+xOra8qSz8eaZKqr/Yu6p2TCDjCnF31i5qUYocsPQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVIeA/jBXLc5eA9WVKIvfc/PBBnrsnc8K0hOdQWZlbk=;
 b=T9/zxCI6pbXG5ItuTGJrhirGGe9VuqL9DheWcqyYc1dI/toLsc2wFsdIFnyzT4itwzCHraZXOUdIO3uskRA9buD/lOQW66JCp90xJjE8YJv0NkOtfOQ93WM5eu5aw8UKksHEKIWlNlek3X6XItQrcza0JSDLeSi25f1xpJhaHwS06GQnVcYyx83Zgp2Xy55nWCmXMxiA71clKK97E1eMNPESxgwBw9GaHFuOtTgpBo6NWOFEzHriS83faVkeZZR1pDEbjAPowpJuRgCJkymmGh3zTyOQq0wC4WNqvPOJMSqq/gLYX3vMBbfb7+dqtUXm7j9ZiFqahN+pnBjnxzuK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVIeA/jBXLc5eA9WVKIvfc/PBBnrsnc8K0hOdQWZlbk=;
 b=CbxbtWM4P1Cff5btwBsTbVIcSXayEhc2tnbRfOHevQggFz+1A/jbMWDM4caTIaL/jek2fWbEBsR0DiQrexfPiFHfuoFEhHPFu6K3HZWN6XSH1Jk8gRFWgelhanoGammSwJhIsv700m8Utel2TlXYiSAZHWsyPTzFIO/F/pMnIoFuqQSl9XAG4bPlB9+vb4i743aKMBslYLxxsMdxc4Ze9a0pOJr4VahfSbK/g/O68uvwMHZnB1QsZfoJP/MeaihMXKHxNU4MOgbZshSTI6UyPUB3ISYTFD4wDTl2+yBUshT+3iPGEYRdcNH4vUhubq2NE1YnpwjQmpPAJa6j+kdMXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:04 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:04 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 06/11] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Fri, 17 Apr 2026 23:01:49 +0200
Message-ID: <20260417210154.2290819-7-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: a42e7f05-3d14-464d-690e-08de9cc49411
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	uLSRBGoGeXOiArZrxXFCmGkHUuKJ3/IXaTOZ+v3MivYr1DCDkEw8oLnFM32A4CiVphw5k2qTPyDsd5DEmOOC3j82MDzKdfgBumu6jbNAY0E2OW4rA1fzWIf/M70Ouy6U53A71rgXHkVG5DwT5lIOl1wFzv1rfNtxDx+H5jKLnSi6n+D1oLHL/j5k8Cc7w1zVmbKjZP+2f9fihYwEUf9wjbvkwHvyEk60ruRcmKtPRa5N/gqWJ/YVxh9C6X3/UWemV3c7g61i5s/oou2/ORqn8aYzx7KN7xn3K5PWMtonKn4aaoLeJKYRr4SuzW1XUVxDHONohayvmC9egODXjQjIGUD+HuQUZW/os1MhTGwfomuZecOA4Mjk9IGj7jEQtCXh+9B3Crsd8KAwswISiSZu2WV0jX2K3ywMqM3s4iuL1/HMluvwuULXrBOzklPwHwIaR8DV1R3jEswswm9/vEobRkQYvAT/F2H0wJk3VIW5hQ8JL81zh+7XpiIbfci6U6NLr8pXwQEBX3NweteF/U06Clsnf0MaxviegEsxebF2qjS/if4qAxWcpQnmdvsKp9zohxjTYW4spFgLBB21ieExPfAijVBfU9M7B6rbjKv4LbJZZ8XHUj7jtr8LvrtYxktTnLfWUEbEWsfMjavP5HlSWqY5r9iokImFmw9lekC8MeGZENkWwFfLTWsktqf19YxHM6relXEbxBA30k+z/QEVr+F66K3VTaeWxrAMDlFD7BQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ki1y0WTiDsud37GCAEXCyWs00tB11ICeRMBghYrr5cTtxXS2DnDp7wGwZJTs?=
 =?us-ascii?Q?8HCQN++D4cwyHxu4+HKyiRljQ6mPybX8JDf06QmVFksYYFcuJnCPATHGoSMg?=
 =?us-ascii?Q?wPuRwFZCUEZSbopZgL+sjBbz7KoM3Ekb6/1jHH8CvhcamPTWaKWL1LKnkgzy?=
 =?us-ascii?Q?o6Op8aKk+mMoFYUdu02jIIySefiU3b733lhFMy7gWm7eZt7AZJDRW/cSrENb?=
 =?us-ascii?Q?KfSfAUwzG6SL+QIEFMnUMT1UCVLzOAoHnBm43gq0QY0dPtDz+0tAiFusS6lb?=
 =?us-ascii?Q?MFf54gvOMtWD0p9Wo+thZgmvj9Cr7AfLwNMFlHyCWkW70ba1MW7TGqeedh8l?=
 =?us-ascii?Q?ioPZCVxJ+NAM2Rbgmz5G40DBV/zIhmLCVEPxhdpvVVrjSsAmnzv4JgyuLIIz?=
 =?us-ascii?Q?TMHlUpTZQCVU2MlTo18ittMDZv3d7rHCm/8vn5VRsui3zfMEvlXMWKdFbb6s?=
 =?us-ascii?Q?EnoabikzTCXTYDDu7MtElJxIcJFP7E1YNXmWww9uI2NxyBWVQ9c/beWlPN4P?=
 =?us-ascii?Q?f+1VUN56EEg5ce/n++AfmR/b43/fDc4ZcA5/gbhPKRtFB/9C+meh6AdvqUPY?=
 =?us-ascii?Q?sx/rW58RXSzRiSfqKLjFvcdYzhas299M9EwH7t7fI9Yn5S8qWU79NIx0seyV?=
 =?us-ascii?Q?xOI90zT+h8dq0GRWCL6tHEXKjdt1bHpwjjJIR0YUYbhEzPnOSumbDMxECODX?=
 =?us-ascii?Q?8auKic3ebHwetzy6DYBqyRheFquI+KG9mRqiC0B6aBU7I5ckNZ795kHW1zEF?=
 =?us-ascii?Q?q/Wg7bKVJPqO62HKa9akKvfIDfvtUm1ywJY+ZvRx8+4GpfTsNJ9LPu6bc56v?=
 =?us-ascii?Q?aGI93m7cWbAYkSbdFW7eotc4Tow+v/KTJe86yPsO9GU5CKFbXFO7H4OlrKIC?=
 =?us-ascii?Q?f/qEyhuSqYNttBbLXX4KGDohYL48t1mAQCxaAg387CyqY4GWiWRDHuEkJzcU?=
 =?us-ascii?Q?Z8XRhkXyBUmtZeaE++5Wr24jtmq2Tlkx6JV296oGVHE9dDxlWdp+2XrfVUzE?=
 =?us-ascii?Q?tFLaXzuLpkRHM+qFj0Oxajmuqdd3J2nDbvaQ9upmQ1Vn2lRNsGsczt33W8P2?=
 =?us-ascii?Q?1I5pb6XTVpAhsxrhtnuCnaS9jprtg+nXv4p7XdAvPlszpjVhNAiBtcrAxOv4?=
 =?us-ascii?Q?UyxR/MBLUtcSS4vM0IPEap+pHeOOk2lslcLKcOHbydKgA5F2zyEs0bf7FeTI?=
 =?us-ascii?Q?sN5Gd6fMLNI76Qud2JNj/Ih9ig7QlWlOxy9hwBeq0mHsSDB99YCUhunMdrjs?=
 =?us-ascii?Q?ZZ6VlqCGEZip5toc+nbWc3ONFqMu2L+C46CLM+lga8rq/GtUVC/3c4Xp+vmQ?=
 =?us-ascii?Q?+DS9d7DAQAjj3V+y3hzvmhqh8HuDVRO7Kdniq+mDHq1oopN8n/i2UpOTPLKU?=
 =?us-ascii?Q?AnR9PVzrHwUVjDwlmzQBUPJUBJHnWvKKXLmqBpxKdrqUOmogitu3RvGQ5Jla?=
 =?us-ascii?Q?SbvuIOVf4pbfo5FIaQX7aUufEUDcqDKKY70XSvhwlyTSHGcHU2SmRvANpJLM?=
 =?us-ascii?Q?g+uZRUn0Fu3WZ0fiCGPR0uXy/7yyyiQenZr692lSrCJil6xyW/nGIs6Ccgho?=
 =?us-ascii?Q?hrwARTxKy8HtsqP7KumtdiyqT3epgrLlnWQ0x2c27elOkhWaUpwuYvp3cRI+?=
 =?us-ascii?Q?t27xi1qg1wQStAVJujV9wNaS1NnP6KaYWYPXwfQa4FMpcP+JdVEkOd5wSa8w?=
 =?us-ascii?Q?BjGsctd+G47mTuEQx1sFVvBDJeI/eKrhYghH4fktsCRlx9l9oALWY5RQgzFX?=
 =?us-ascii?Q?i5RjM9QYWogieOax3lvnw0a2zLymLKs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42e7f05-3d14-464d-690e-08de9cc49411
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:04.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqZkyD5AVqJOYqQUqppM9wYi55dN6ZI6vBjkmHoU6mdX+rUYYWyzx+y/LWxBZBaj92HIVg03B2F2dkvieUf9/hm57VyZs8MPBvyM390mW08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

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

