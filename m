Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A23C09E4
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492085; cv=fail; b=tjD/2QuR4Q7u/CxKcsIHRePgTfJgST7RYYRp03hWr7EhyIfBtw/5s47aEKkviV3+fkAFbVeseUkeMTo6gRqyNwuK0uCI0hw4JLd0zcbjVrQh4S1BALTgncmIHB5i6odx3SaELVSh/makweDy5F9sLaM85uBqU6+BKYsWf29LoWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492085; c=relaxed/simple;
	bh=ZFlG0X3CRNnksGFfFp5k8jC2mWy67cLGno0oaZfk1s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQjEeQAqORWNaYHVpMQno5Jc0tR7uKM8G0YUWBOJeEg2O/9unl5OKiXJE1W8UgiHkqAGXkj3/RgqPu70U/mGfCZwCvoIxBiy7GjfNhvhvf0k8f6ZmwdKgt9rMLphPiDv6ThVVcG0UFgz8KeI4KsIKP+ZMIEilANh5F2E4bNzqA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KOPxnO5R; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KOPxnO5R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvZ8kYy29UBESUzN+ImKeGltu2//o1GR5RQoo46Dpwi6pe3E99l7Pps2/QxbWObCVs8GGNkb+T2zMdfpgfWDmm+FXjlifHweP2Hq5qVbZXhkQh1rq1Tn5XidQpKG4FD5371qaLBCipnNgNnBsMcnyFfC4B+jDGD8CyUVp98rr3HthnhyTKY2ypM5bk2pX8CXQo28b4meN6/O2LSQ/3B0V3qjGsuZ8ZVyKKU58GDrQfHcanCcBLhJHsE76yZ7Ap9SPRQcyeSSzBofE8NDj0H01O7tX3J/7GhqKK79HWF/5XqrGRvX43uH5Fd84J9xOVp1lwiDKe3yq+4S9UlKcYRqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bBDo8Hl9Tn+8Cpx1m8KpIirlSMaYTkDydhBhr687xA=;
 b=hX4KGrmTBYR5rYk135SqzEozpqhd1+OISZd1z8z4dS7HnZbPojSllx52eziFq5l4PDDjACtBhDZ2QDHmw5U7O7/KuBlS2G+8CC5p5HQo+zKHI22t1fUtxWQJOtNCOe1Fwu8CVMqqXmZXC+4pPMoTsZc3NWe60BIN43V/IvwF+VqK6HflV2EygxyTZg+ZPZQ4IyAMWaI3NzJzDYrMnqAdkJ8ahxqfN+raIFzBU0w4R3EsdwKnnuKj9GIwR33Ay0TuEu9oHyxEkD+Tb1WYMOAp8/xWDmx7bj7z6//UNKp/PJwbTHWo0+s0Rpi3odgYDXDOPyxU89+wzNBamVdCS6WbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bBDo8Hl9Tn+8Cpx1m8KpIirlSMaYTkDydhBhr687xA=;
 b=KOPxnO5RMvPaXIP0bxnNXsUtaVv86ZBhWiH2C4NEdeboqDmhMYc02xP7BnO/qla5siMMfOIc3dTCc2N4DF6l1htxmzi2eiT2uGidBszKp0lelAPgqG0CWK6a5U+4p50GB/V/RUS6KfNLe9k0CCvYpU9fQ0Bupxf2e5MKpNE0J0KLiI/omZhMaxoD4cyx9RZboubeD4gmefPakKx40AA+eq5znUxS4rAyt86ro8gn2Ht29eLtT7xysR4UbsiGa9mukc07Jm+NMficOm7kNKDrXCEVthjyqOge1kRhKmEub/8+dFxdfK4aDHcEc9aZfZ4JGOMAfnDk7+rvpCjbhpkVfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:57 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:57 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 04/11] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Wed,  8 Jul 2026 08:27:41 +0200
Message-ID: <20260708062748.1029852-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: c62e6051-44b4-4ad1-211c-08dedcba0cfd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	v80Km75ghp/lKnu1KXd+4h+3367Bs5L2YK8sPsFf5NZb83lsjcr9O9UgGUmISgNp/8bC3cvh0qir0aXd1I3D8xdirZq+XIrEWbthII3KXffvS9OyMSkNr+rz3/ucGVpX7LnFP6how7HmK9qFuudp0XAop7MQzEpiWAghAbPZJarJK7lt2YlvpnxhEISgqqSOiOCag4GmyflRhKYB4T/9t+MwbrNYJlUd0AJd2uxvjv0COD40OX3/mMF7ZrWpmIQEYjjXvKMwr2Grva8yuCKF+Ltxomkt8eWqOkMuXXyYl9IAoFlCFOMTiW08x02H20zabTtg6OyxrnqWJVRKFFOBDe1qW5Jp2C319J12dFbOplhUMcTIyBYs8ERQw+5m5Y54Ir2zocMjf+uuNv84DPCPpPzbcX+5lEtCatJuRXLWJ+pdyQGHNTQHF+PYil6zrc+nLIZNIltsFaaQqZzZIjEHKOSPmzaok/Q4mNeRErd3jA44ypCOqmXFSMXnvrpiejFp8MD3SoiybqryE3mBP9TKPAqRWOmopvyXZjqLIC7YAXnyCqdMFwXo6/cyu8Lu43RKcjiR5+kl/XsjIOoL+WUK4ZafWo51AWKVMRJDnWtJkDOCPcvjzo6up2gZETEUwAHXCvF6Cs8eAN3qjpW4rvIX1b3776Iv4ZIQo4Qzdsldu/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ovs7HLlZzXbvrhpGMAjdBLBRtF+jE5ARF3BeW43Jf0gMkF2+GAxpyK0lhteG?=
 =?us-ascii?Q?6zUwEsnr7enLsc7HVa7UXJiYfZw2soy4iHVsK+vFDi5RdJtjrGyQF4pGQpke?=
 =?us-ascii?Q?bOHUvbq6Cqsee2WMEXGmYtLIHPnTaufmChYHvr5kUjIWbFc63coQtFoHBGDl?=
 =?us-ascii?Q?2z7EKk3+tPehlOYldSyYICqauKuBqLhMqNhJgOK2wnLjYlhaxLupQdGIP1qC?=
 =?us-ascii?Q?xx3X7+tgnFHacvgPgQMj8/fd907CekiiwJLQ946+HV9QXSBVV+xM6eQpgbB0?=
 =?us-ascii?Q?1zl9Yy5CMmlvTOsy3yzqI4/SRCZ0PAKKgQp1E2+ge8HGlZ8aw4PC5WBmUeGX?=
 =?us-ascii?Q?P7UYJ9UlcO3ApCYbf1V+/aVzC3f36imuhM3SxuB/sdBH/9vrhtf+M58fJV4O?=
 =?us-ascii?Q?jEHizQXT7Bv8hseBVEPwcPAR71nN1OUSri2y/OIF4NYQBLsmuXfEuR9kdy6F?=
 =?us-ascii?Q?/2malSpmrdEojh4ESwRITvS9bwy9ItUSL6Px76iJsE92JmS4bHTA8KcBG/lm?=
 =?us-ascii?Q?/9aYEnNWKv4GDqf3L014cTfBXspl1d4SdM++DynNTEAPiR6TEwq2dK4RMOXb?=
 =?us-ascii?Q?s5GuE8096ep/rjtqPdPe1BczW11gGjGckVwEWI1Y1CuN41b6IcjNEjNvd2Hq?=
 =?us-ascii?Q?yvy7ApjqZA2t5Wk17rZO31WpFcbkSWvFKmRxWA3Z8VyvlbsaVWLei+1DlzS6?=
 =?us-ascii?Q?862qcOjlmhyM5QQxKtDt1YO6BPDKV+h1/ZBYKJH8N2pqADRb5LfUHHvALq/j?=
 =?us-ascii?Q?H8A78ONs1UMbFZ5D7+B/5/T1+CEELifkVLtoz+Z7Y3dWVa2BtPxolxyPlqGq?=
 =?us-ascii?Q?xQy7qHRvOPeTuF2U9w1jvEC0q8ElXmPuT0Xlibkgls9HmDSV6pnoRFAKxFlv?=
 =?us-ascii?Q?2DdE7kfnxa+u1XFP4fAVdzw1FF74nSI8VOpfjVQUZ0rN+vLj37Q3HE419/Hy?=
 =?us-ascii?Q?SyC8e+jsJ1d0eTGEYMTunECdo4j4RmGDCZAf+Vt4MnBrCCQyS1uB8XwSS5Iz?=
 =?us-ascii?Q?m4B9orOE1zKh7tkp4s690xmOaOkRZXmYbuAmTt5tCSUfwbMeTOfZqftl8hLO?=
 =?us-ascii?Q?NDKmfrnqDLswIAcaRMHQh9cF7GV5ZYthStbArbrQ9Yth4fMaKRnOst5KR0rI?=
 =?us-ascii?Q?6NXVP9R+vRl7s75gi2QH7D41IzlpOBzz46gt8piCJd7A9fbwwVEPhnpEMwfL?=
 =?us-ascii?Q?VzNl2MHxG+Nwoq7sVXYvPrwFJ91XWOfHl6yHGDmxRvnUFZ4wPQj8lfn38ijn?=
 =?us-ascii?Q?7WUYP2sZyaDm58pwJ8I68UrPAUNMhPYcuEgFHtFbGLWsdB/yjqQq44fOgEi7?=
 =?us-ascii?Q?lbmgRfvOx9vJMcgL7IdamVrbAiCfAXEifzNY224Pee2/ciPLJTuJWMp4olgY?=
 =?us-ascii?Q?Jc4sPS45bgVeX4i7/8KtAEP1AqPQ2Y2pME1VOiHzGmZ+1fKWIEkW8ZjsRbEP?=
 =?us-ascii?Q?kJ8r7MHV+BRuCnMN81nR8Lh1PAVE2DKN0m4b1yMo2s60H9VBNCG4kPKBuI3x?=
 =?us-ascii?Q?Nssc9IyOJJeN7qZVsd2Mq3FFgyjjeMSDQ0UBK6DOW3w2DVof/qbiU3VDXCmy?=
 =?us-ascii?Q?Y9KR5Qr/gJ5ZeKveti8noKAUCYfUuZT554EOn+O2VZ/U+036EqQKGef0lruU?=
 =?us-ascii?Q?Jrx/ZFX9OTEuvZ5f44Whejizl/Fp3HNCWvJRvoO7rM15Dm/bB4gOKYPg/33/?=
 =?us-ascii?Q?7eJmAyiOTRVFnpBXzZsVT8JQmUYEOyM8BRg/PL7F9/w/LpNTlBMpL6Fvj9+C?=
 =?us-ascii?Q?ZxWZS4a6DI9JD8vwHDgjjZ84x3vYxpf0mpQUM/NIbtlGU33EOAfEdKMlTlw6?=
X-MS-Exchange-AntiSpam-MessageData-1: l9pZEwyAIQQ8xgEH2Mn83r1DqMs8GfNMEuc=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62e6051-44b4-4ad1-211c-08dedcba0cfd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:57.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIBJiZ1NqXikm0vQGd2mKdNnleS6biOA/pQnhNNjpA9dG4xBQDQ1u+C874JDvfuFDlu9YHzP1SefRT4QB5f6OuciJRSjYzeHEfoiDaeNDCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609f..25de8929ea37 100644
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

