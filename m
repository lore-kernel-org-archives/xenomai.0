Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508273B103B
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237159; cv=fail; b=GtOf2fg45Ta/sR/+LXow99vU8mu42AkVCCn6a+uUb3BsRq3o+twLyG61GHv7nPLaacQxLRdGHbOFITLsJTgCeztIPX4W0vmMYgrhiOq0NVo1qVrS1QTAl1a1OjDSpTydUkJPPCAm+nV4UPt0oJ7KDtVBcY7XnGP7N4cYy2Li+BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237159; c=relaxed/simple;
	bh=t9/8BvTOxaxxtZun+CiCNcJeIOxh3E5guEfLGpcNiTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VjLiAMNoDDPFJHhm/h/MU4MY/cyDwbnpPLdYqUZVhk5x1hRsHurEGaIXso1MceBWLczk/C1CG14h0HASbwX/kjGX2U3uU12ZqxaRigj5+OBwYH1vmFRDf2wGo0ToLnX0+GNk+ArPbrj6BP7bFAeIYYM/SL5jAePkt059tkpDZYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iAOG22JX; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iAOG22JX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtTl1EE6lUg6VF80S2pdgLJ6pxyt9ASNfmqJwhusr/pbUutxYM4oLCepmZbWplPfQPtKnKORdiMKyC00SduXrQGS1Qskg20uhiNKaU3BhkjeCiNKXLDqbBucgneNjUnxk4/9Qt2jS7NcosSWt/K9T7XZDeltQ5n+XJ/N+Oq1AdDzovuGwH8ua1vWzIYirUhWoDI/FP5vSOVdBiL4PxUEezp+tnwvkRckieisY5llWZIKVN15dJU3KikiCcAfIOC84RQRTAYmoe0OO0fXpm67fLiwj1Z57TKBaExlg0NiSrdgiO4NU+IK0MAdPXlCyML/nHGIFxOdPsAA0N6CNkk2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbpIl8ZTNc2LrKX+50gNgpcHxXL1cOwymo55vLqep/0=;
 b=ynhA2jv+d26w74aZxb0tM5ZMhHC7dbqvsMiNj+j+GIlkfAmmsB+Edfwk0Wr5nxJdhFVVW4EMtsYo4zT+hWNxY93CnPNdNjeAFr0DG3/hLK75ytXP6wgU5f9S55634jVKin7XyD3jjfzeFANyyXAT57Ht+70Oxat2gtOH6NNqjwpQk3jQnnRaVu5RJ0/aXr1zPNbAwK2d3F+xppc7QcvVhQXKWs0heDP3ynbc/d7Y20BBV1QQUZ68w6YlGEdBOVbS3VlFB6TMGu6zUIjttQhTMY9er9ZAJSXaj98GCPcJhoXqyAwRQdwwnMIR7SrnM5Ak4refAsUP6sUJDOsNZ8D26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbpIl8ZTNc2LrKX+50gNgpcHxXL1cOwymo55vLqep/0=;
 b=iAOG22JXhQFOHa+Mp42qoDaIKAb23jvvZOwPeBuZ0RSxPtD9ix4T+rZlwa4ngPYdF3c1Riv5ii1XVhEXRw+mzYWKUD89qbeVbd5F65qkwWhMo2iWCqHnysWl5sbjS9z2nfoJs9jjCB/hmjDC8cR0SBAFF+1+wWdjBxgfedOjKPDDbn8ojwjl9POI5ArLx+XgaAXcX1rj9WWAMSn6IX7+UWrLjlDV1ePG1JOgmWK77RSnCAafTjGrvJjRo+Uzv8snbLYZkONpVzP/CKvMge5bpUnB/fUj6MM45RYhk0s1D4VvCQtcl8tYerwVz7zqvlpukl6i4p49Wj7MspbDVayKXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:12:33 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:32 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 06/11] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Tue, 28 Jul 2026 13:12:17 +0200
Message-ID: <20260728111222.2699158-7-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 421efe79-2ebf-4878-dd87-08deec991eb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o1a7XT9W+qrqNcjKRZgfNWgb5YnrCOW8nEfP0Hcru9AVAMclqCEAomw0AIo/nzJphCvfBuhF/QnMGzfayEAhSQyxr9vMiySYWhrdv828NdHrBffXWbPavIzcePdu8bmeF44oruZsVoaQdqWW+teOiAocKqSDht8khLQI5x55CtdzglkWIBrJ6i0nRIl2cquxulKYriqjT2KVmvijWPcLLdmcN1uKOAFidALw2KFgRbpNDrsQDa7z3dn8jbibM0uS/1yiD9axzjpm1YibXnQI8rzIWTtRLrUvepPsYW/KUuucT8yWzz2/Ka87i/SWBc2cA/lq5jQrbrI/fNeEMODYy60TfYqWtB/lcgHSu1dkLNG7eeImsvzQ/8RdOqdT3C3yAJpeCNfo0uNHdl/Cjm2pUztbtWzSeoJrUb+UEaJYJZr75O2bEWpr33dco/B0XdC9NFOIqsxbXQ2/RDHQXqTKJ1zXZjzZFlK1Adxq0lG/E4z3YRHdy3L9/po57QspfVy+bM2lK63CT4i9GDX9BXlBUq8VoKlISpymdLzzWEcPwgIepYSvKEhMJjBYAEaUOCqwiN2Cc4WAK2tpD13YmXokh3zXk+jCB6bT79HbOFSSMx91xsYhgKejADCPyj5pcB6JI9kDbwdYLN8gpH9rxdKvIsO8DBLbSyTNl9n/07uvmDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?063ipjPO4imA95tc5gO12iT/Py2ziBYK0i4D489BL9mVOpQGNkBYZ24HFzUn?=
 =?us-ascii?Q?vBfHwB2EJcH4BP0SbRwLFlPLx8vkn0TLNjZhXKtexn4kji8jCULyytawf8ry?=
 =?us-ascii?Q?8Wb4z+YKI076/iqoTDmGtHAWDdCR0O/mHbJYnhMQCCz33YFvHHNfGTygNiwg?=
 =?us-ascii?Q?aAVt5fkVbiY5+5/SHTqNZX84UeQ6PcVhax0UiU7aFrx6shzRpFEnWUArlPDP?=
 =?us-ascii?Q?M/UFmlSwQ1joB01M9LdpbiNFKqdTFfI6t3fqx6x1Fq5IHrKtA/kp1EcWiuMs?=
 =?us-ascii?Q?sktI2VBXiakN+2aKPP2/3zCpQZKDeAf/YYJUjdenCxRU7N+yhPxkO8psOZ+E?=
 =?us-ascii?Q?5K9kFa/oeCI3so7KkvGZxt3wvVKgjcdeu5aA9nVhyuH4rABrSNewd/1NiGM2?=
 =?us-ascii?Q?4brH7xh/c+e7SaAGt7PUaJB3NCtlQ0VNPtnc9VLEcJVWV3TfxAmtKbrG/IAv?=
 =?us-ascii?Q?103mi9W72+VnYTbBnzPaLR4JummUvMuE3/Dhna5YYXm+tuy5AK43XW4WZdOt?=
 =?us-ascii?Q?b8Dz6dzg4wG9nCPpjXb4JBbaAqQHvY5eMP3bHV5HRB2S25CckCdDMUoDBb23?=
 =?us-ascii?Q?5fxfZ7tpe+SEqtA4/XeSqxp0hOcWbm8Kz7/ccaLuRpdEYYZKCJHxu39xzAYM?=
 =?us-ascii?Q?5HQCBFNPyFAVAUrpd3zPJcqL/VwcdJGIXFUC91ZUFeh5yyPWnKIRmAH88W5i?=
 =?us-ascii?Q?MdTKyBDl+aSq/+zDl1hb6TN3CGyELXD5jiG5kZKG+6tK7Lz90CkzRmut647N?=
 =?us-ascii?Q?kxvzZIo+ljpXDJk/dTgljY6gzD6VtDZRvE1lDikTmV1IOkZRgght5w0lDm93?=
 =?us-ascii?Q?8tKuHEK3asjhSg3iwn7Org/GQXufMwQeBP8nljvEv4+iflYjkk3ldeEKpVNf?=
 =?us-ascii?Q?N56e+81jNMEHpnBZ0wDMzPw3pZDWNtMb/SY131KIaCo97GCgbzoeM3Bxgpum?=
 =?us-ascii?Q?0SO1HtsDY2JSBcQzDx1sHzHLyFFhT6Mcy2lU3fN/4vwSNtW888U18ecgStxP?=
 =?us-ascii?Q?T0+BXqiWKH85KGcGk9sWR4V2JcCiAb1zI3QEwTRxYW6ArNKrUPmKWTZfaXJ2?=
 =?us-ascii?Q?aBR3YNCC4J1p9QoOFROw6XJ+l7n9DAZwA2qL1i9dIUxaFTLRfsJOfDvzytuZ?=
 =?us-ascii?Q?GvAFRrFPqVh5e47BsqzRemVsYu4QUtXzGMfDQxzPmu79cIkVoWAmUPVf+CwR?=
 =?us-ascii?Q?CmlFvUNf/AfAlMAQlGVXsXwvsvsuKFn0LXrBsLr95pN76Io+/2N01RLho8GX?=
 =?us-ascii?Q?udpGIm6Qg2JLJoDuwWlCnt35foiV1Uc9ps0lS5OJJJjygDxHKf3kDZ++fQdO?=
 =?us-ascii?Q?l365tsUdaHfN+Qi2aKgKKyiKEF9B9XHJwq/ZLy/iwTz+xDYuWo76+lPJs6ed?=
 =?us-ascii?Q?KwvY53uJYXV2rlNYd1aeDzDxwV0Q1KBmQsAsPBZSvqX66L/pAorXO9LQtlV8?=
 =?us-ascii?Q?n8ticG/K5TLRypi6ccFMcRPFBKQcaMJ/zKned/0pGwagt9vmVh6MV9BiGcB/?=
 =?us-ascii?Q?xcOD99xq3cuJr0kfHjULF2JwxMPRPyzXHOcicS4aKOheeRUbozMJ9sxLSXtY?=
 =?us-ascii?Q?OIPSIfSvp4AezZQ1oIiBd3miMOqWuJxjDQQuYwDGFf15+GhsIfAR3L+KypUy?=
 =?us-ascii?Q?zzAlkb6Rh7O7jvQuupPZjm0thz3Nl4Q2cY5VvaDG0JCkC/FHhoFdUyY/LTP4?=
 =?us-ascii?Q?3sp212FJQ3JP0eQ9Nv6RwNFu3Fwqkd+S6+5EVvuN43kIQn+wKhC8yd4sozkN?=
 =?us-ascii?Q?CX8Ukbyp7euMyph7nMB6fGtjiby/n48=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421efe79-2ebf-4878-dd87-08deec991eb5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:32.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzHNxNAffh4GWceXvfg/vzE8aM9HOy/iwhQxBc3sdnTb8qgW8HWSZT+mXCtez8SKi7t+d4ReQy9MocZezBXYucnX4vGlDtBPLvCV7HC0Vpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

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

