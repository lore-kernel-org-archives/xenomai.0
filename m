Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CD34D91E
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035828; cv=fail; b=X94RCy2c5ugkkHT/YDGtUX8OT/YDF1n8DfOzf0kbzHMohnNAgj5vPgYTjr49UG/wSlIVXyol6n3CNm8QCFz1GOmDoMpDTlp+Xnhz/+DeLAIlmQX3Gzw/SV+bhpXRq1ecrGkOmHsFYCcysWxjl5k96mU+2ZFLWLNBPrsGFKsuHiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035828; c=relaxed/simple;
	bh=3XpMROtlW7+u8Ecg5Ohtp+fblhtg76TJLD4GfWggwd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=crPxLjeOf9I/DLgDV0Vwejd+EMjOVXEgwdP4BOJSPQqC/Z5VK2d7BLCbf5bKl92D0XrnACZpHRQ1VxM5dc4kD3+aK0eyNCgSUMRc+ZNKVXgAYZkxBseUsKqrrhRy29pV3GDUbSLOe8IBZAhtt6TAP0wptJw46ykiU0L17aEsIMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DM2rKgsw; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DM2rKgsw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMIFC3m3teKLzQsyJXD8UKxRKl3ISMC6jX75eIVSc9sPQnuN8Qh6aDdZkq6z/wWplbfEjZf0LJXwX5u8//clmM0JQrxaStI0ROIet6znCOt1xOLivuw1R3ibjEQWR6YqR2SdhgPPMbn8ObM19Ke/nOPMPVeHV0GLE3AZFzg5Rb/SCTG079u50IYmSH3Te8Zki3/bEmBXKce802W0epkp2G/9Iwjg0gud2p5XTvpi6oI+uclAjtCpgGcQPm66Q2jm2At5qgUy1oRe5f+MxFKCFS3ApXmwHung3NvZjSpYU2OzXSMLPDPahrwL0leDxMcmRsr+v2fPRkke7uQDkVc9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuaVhMBwJ9g481V5G1iojLtt5K0x4MIzj0UKGcRQT+g=;
 b=bn2ZWics8JRRS4u5wddgoshH9LSZHV1BieTJPUDFScgttMqHoL2oaPDwUn2vPiIU6cbHFf5YWNUQhSiaq8RWrJUIF5jRHcP4FzHEOs34uNaPOAUxYaK3Q+dUndxrREoU0v4MSuprV5GDbbXENnA3r2rIvvXoDUhRMbjHYaZn+PuNrKNWPZLSn4uzi2qWgUwl7KoGcD2+qeEwQpaVKLNwNjgLjdfavneOtWJ3jeQ1LhB3ucnjWasixtr81Ex1AGmQP3MayeeeS2+1DdtXUyH+XoDOyHXefCsJO3NK6Be8GJfdB1w2butIVo64rJ6eS3s2AM3mg5lAoxWps9uYLYjzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuaVhMBwJ9g481V5G1iojLtt5K0x4MIzj0UKGcRQT+g=;
 b=DM2rKgswjzB2OhAogjPUyGn5Mt8Bn5cBztbljDdFRVUmymusP1/DfCor1PqtFw++4gbucwtfkeHsgpVJ0n4dIjcWdh3cte8H81yGpQQrdXiK3e/+JnI2G+/3jwih/wE9e6COI6WR8zDrv4GUyAUB7p7MusUtmZ18NlGU0Qp19sEms46yMJuVAlGfZmEBgnt3UcufORXs2DJ0c2pfr6RfM50XgRyl7A/7kgXbfUf+tge0IBYJmcmmVYClx0PV5EG+8JqJXTuz8XQMxg+Ua46yaMtPrqNx2w9vFFIZPXk4nNNuNNWiiWbGwn41JhBJE8LoXAS4ENn+IlXlMBBzgT8cig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB7859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Thu, 13 Nov
 2025 12:10:22 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:22 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 4/8] riscv: save program counter in arch_save_timer_regs()
Date: Thu, 13 Nov 2025 13:09:59 +0100
Message-ID: <20251113121003.416012-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113121003.416012-1-tobias.schaffner@siemens.com>
References: <20251113121003.416012-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1b38ce-2584-4339-0128-08de22ad9ecd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3piyqTtJEI+3awTJS1u4/m4CK2oJk3/E9g4oahRgYF+L+XMKh1xdFn4wsh8j?=
 =?us-ascii?Q?bLBCh7l+jSyOzG+YgLlCZY/NhZiyh0QBsvrdvmCHDCaCon1fRieoCuoxEFnZ?=
 =?us-ascii?Q?Kn3Pzahy+aq4YuKD2Yz0e2hPuWZfNTLFHpNlCiyrqjOp7eRckkoqhPOmmfJh?=
 =?us-ascii?Q?C3LeIZY/OfbFvGwth4JSkSM4dBp5rYYfdhGEq512scL1h1VI9S6N1WfjzDh1?=
 =?us-ascii?Q?zzSkV9NUQ/KvJy40bdN2fbmDil3Ss571UOgCuIxYPlWXF/lG5qiOVvW20oN6?=
 =?us-ascii?Q?ObX2oDHXBlDfkQtoKtKEDunHhl+tbAqVCMp7//qSp5KwCunXzd0ba/Aa1sYy?=
 =?us-ascii?Q?U0DCmcr5PLGoS1KhBP1i1zcePP72aKY9IQFdNvuHSyeBz/X1lLO7Dgr5q26A?=
 =?us-ascii?Q?yc3t8X6H/yFg33u9xM25ukykWu/XhNQdT04IFLmgLRI58UGgV/uqprWMPbMF?=
 =?us-ascii?Q?z/4oUz9RUiXvwQQIRauj1YPuhVumtvzJg9yWJVAAv8C86IZn9S5KM01c+SPk?=
 =?us-ascii?Q?I8JPwvcoGOhkBdlt4JK0YqygcGoAJuKrYmWCncZbPLiB9g//9W/YhM72Tv27?=
 =?us-ascii?Q?CckCszUfjne1F+r5SE4I1+EhprcApT2rDjgCyT+QBprdGLSNpbrwx7tPulFC?=
 =?us-ascii?Q?dpkoJuQ+axRLpbC5szSyPPsElKxHnh3gvvgahIHhFEXX3foa5tjmUkxDxYzB?=
 =?us-ascii?Q?kesOXBxA7JnESRaPrVRhzGtxbhLz0wacTRhKsoLcvm5X9COx8r1AjtxvU1ry?=
 =?us-ascii?Q?DCjnSRtvpWA3VmxE1JfKwPztddPMI+ELjiDxszkE33BvlgGUPBJKiy0ffrAL?=
 =?us-ascii?Q?SjZ15p7q402TgtZUc7q7mMzRMMNpw8TGC2z+TMaaPZkKcpUxitLwO8QOdY2U?=
 =?us-ascii?Q?HezKZmiuEInd5qhP20liJxC2tv2Ummx0CP/4QlVrtoxk0lN6QEdVwfPtJq/I?=
 =?us-ascii?Q?pe+QgrfS+CGeiyH+XIt1AExCH+WcUOvze5y8dM27lE95ZwAsTRwSVKN67+XP?=
 =?us-ascii?Q?SvTYBruRLMIAXXAgMPuxY1c9cwNDfW6sa8pu2A/byEzZdzGkTLsXWW8KgoQ9?=
 =?us-ascii?Q?rza/FE9DgsTO+TQPUrscbKXYed+rLjrMlcDP02oB2qnp58vhMtdkBTy7g7yQ?=
 =?us-ascii?Q?zqp5bcDvho2ayP71/aMGFqx3tRc/f+ggoxtf5GMjiUYwTSItP/rzc1yijqQO?=
 =?us-ascii?Q?zEJWuY08mJrf4MxWpWGaURT2lEp1MLXRAp7BEgiUmWIYAaW3cvsVK4rvZNzA?=
 =?us-ascii?Q?MCkm/NVKiqVp7m3lq+LMNZ2n/nSP37zam2+f/dFNbBg62waP0MERWB4epjph?=
 =?us-ascii?Q?M457pBmI/v3S+7BpBJc+of0NK8IbHC4u260SmK4QGAQPAywr4k4M0HSyjXfX?=
 =?us-ascii?Q?dajtBiJgTG/ZTWVK9Ywf3/osJUk9fJroInW1IyC7PCu5EEDu8Ip4+a+NM2Mb?=
 =?us-ascii?Q?cdzNsCh5r2IsQuDPABVz/ABHDRrzK1Ml?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8yKAiOu9tpKZhuEYQmVZXc8Y0RF15uAERoX8zcSpJzYg8dxj4vSgwbZUm6l?=
 =?us-ascii?Q?dg0wJDR82a6Yf38Z31xFadsdblrwa0NDKG+Of78m09jJPk2mGwgxnPN7zZfJ?=
 =?us-ascii?Q?2QS9k2zNWbwqZMi5+BwkDjx7ewt6POloyl9z3QzPazCK40uWKb07Ng+UmfZF?=
 =?us-ascii?Q?cgf6n7Dre2TRbvOI4PSpF6wOn3ENOdzJOVXySwLCDCZ/UbVd5TJmsWCsbpsh?=
 =?us-ascii?Q?viJ7kA9ET/k4RjcGbCIVtvfwaXxvrHJVmfJhhxYIP197uXWSQnqIiagbdKZ+?=
 =?us-ascii?Q?tR9BM3zYvfgmwjQAmMxGTt33i8LiozCY94doNQP7Ip1n9lTia6m16ZMBRsyc?=
 =?us-ascii?Q?sq5LMascm6VqakFnF9J45R+eYD6msK2oGDg6TWTZw9ezz5jg4IOym4RNW7UI?=
 =?us-ascii?Q?pt7bHjwhkKKPhsEH+tGjV5vDnl0p+drdDiTLsN4N2hRovgRG3Q3pLhDZ7IJq?=
 =?us-ascii?Q?8EufVFW2oQRS9fUqF12csPCcQt5H9QGdCRfeg2fwCZeb/VLFxKtrDv7bilv0?=
 =?us-ascii?Q?Sdu9EozsICKepye/R9sIpl7pInuKlj7UkpbPtOTp+tyHsqdAhmgswU7Xt2I+?=
 =?us-ascii?Q?lgffs3C0jXay6HdJRtNaQhsWOyDEH2og3IAVjR3CVqPxNSr0HgFLgqCCEGs4?=
 =?us-ascii?Q?ZcoES/PeUXm5icHFWYuH+dEJmW72LpE0Smc/I6T2DKdwD165d0XKeChpVS/N?=
 =?us-ascii?Q?gpp4dLwoC2NDWI3NLzc1QF5dKxpS0J3N0wjuf1tZ9yZuqyRQPlWxPWWRSdTR?=
 =?us-ascii?Q?zRW5Khu2lNJVKHS168rx4hK9EKztME9tUmuF1Cn82EpNyO0gWDPYxM6pQCUm?=
 =?us-ascii?Q?E+K6DYDUKUl9kH8CCx+t8IFqHlFv0PaTxaQdXVxDYlO3cLHJynTiJ6ObD7Tj?=
 =?us-ascii?Q?Gus/kPGrb5fjAu7p7uexgbcsUADTJWF6EalkqghLyKy10Nj4u8QvmvRrB5zt?=
 =?us-ascii?Q?ep4XMBIbbszTdTTTQI4wRGsFy1yKcjNRZHdw9oGENhr/kIbahCSYvVcALs0k?=
 =?us-ascii?Q?7X4Bj5sa0H+B79kZa2lQH7htBBX+3gYinWXpEwyFntb1g1qqTcyEOLr0UrSA?=
 =?us-ascii?Q?hbVckkO/nStORa3Q6KUD9J4cjEgaUSfw//bi6DUGBjvMO83m0ZRXez+wNVcV?=
 =?us-ascii?Q?B7lxWmQszlBpgHiMQJ8GmQjhi1LiyhUqsSfWhy1fl/68aMlHLRUS6BqLdlb/?=
 =?us-ascii?Q?fCPvFIkgQylIvGeTvkGrqfphHkfHIvu9VZOoJ3+yyFZsp4JvKeA/aAi/TSKZ?=
 =?us-ascii?Q?AOdldJG0KtQ/vDkgsBK+fQlBzB0Fss/VaB3SyEgZiJ6u7PE+2YTn+LuoWZfi?=
 =?us-ascii?Q?NyWZT7q5XzXW2IFZKXBmS4i0W6I5dKmX9QO53JkfaAaG0Y3OM5uko8C/cKSr?=
 =?us-ascii?Q?jo8L6HED1qelr5ddTNbtdO4NJvV63rhDpjTobXJFrdPWWeKYXxs+4rdABSWe?=
 =?us-ascii?Q?2xIqwl/xyF/9JZO+1iokKeOaoTRVpq1jBpADbToAtbmmevLxjC2SqfHQ+UhB?=
 =?us-ascii?Q?v39Ww/7/dpb1e+MsTzNQPAnB35yOeXfnobn0K5Wc/2AHHfhS9B/PMJIlzuOf?=
 =?us-ascii?Q?RSnjcjBTuGmbIEXwjde/tU9Oy/WYEdLLmpa8aVz/TPQRQxFIuyw4tpAOCJyk?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1b38ce-2584-4339-0128-08de22ad9ecd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:22.4950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpT2kI79pz9vBaObC1ZOaMH9QxpwkNoHpzFPCFBnF7z5lkjdP1GXNvE9KCo7vUIC2sErdkljUIHTh/c8hEjyp4n0oEP3K/NQ1U8G327h3hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859

Extend arch_save_timer_regs() to also save the EPC (program counter)
from the source pt_regs.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irq_pipeline.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
index 030823745787..c479ec44b3a5 100644
--- a/arch/riscv/include/asm/irq_pipeline.h
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -88,6 +88,7 @@ static inline
 void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
 {
 	dst->status = src->status;
+	dst->epc = src->epc;
 }
 
 #else /* !CONFIG_IRQ_PIPELINE */
-- 
2.43.0

