Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA441736D
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092479; cv=fail; b=SU9nsGv77hutASrpSNtqB+vFbTq7f5IqkBOyAbixuWD748PwetqXtXg5zbUgHKRxGWfFATPbfiC/B986Q4+AxdV1VNCsVnEkrwVPNUwAxwchhKY2LbgtPdfBkW/31++hmqFRK6oekdSor2PsyzYPFvs04E6zS+4EzShhzO0LsBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092479; c=relaxed/simple;
	bh=cR9Rrx2sFu9lDuyV8bq68p2FDh5riwcqhTJNJDz1VB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOIkn2EbHKb8Pw8w+Wgkr8n407znJQVxjaml2dATLzAgyBZMFfy+fshBlLCgGsagayKJtVad6b9/dgdFN54Ze5liggnEQyk71bAgWmmijA1Ag5OaduyPQSQFFKZcNZbAOfi1qf8MhuGvs9NEIlqABtd83M1bYrlLH6Aaij3Fx2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bTac6XoH; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bTac6XoH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9SWSA2gKd5QwlHqVvaeGX6U+I9K8huuaj8OckILEY91T0VLCk0hcwAz1AVqgsuSgi7zp/qYYwJ008Zw+ea8Cc56YDImwkcmyurLPtfzt/W8M1R8wAk2xr068VmgJjXLL1Q6lXo6dZhkx7VvMe7x9DtTq+7Rhrar6rRywDgr/mZgnMrMOTaSnztZOhlqDely+oVxf7tlzCINATmocSFRZd5P72k6bA9+qO/Cqde2XyReP5oApA1+Qw5VdAIdVPDCf5PR0InZdkz9Tnl60WiEnoBAVa33OhRqlbJKI8rhds8j5HfUDyEm8s0fzA3zwJxWykX7UE8xdETAklzdckf5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEIIDWiOmg/0kajlvYUSpbv/F2fmI2Os5Mi5Cwng0NY=;
 b=FKDFGrIXqoyQGOlc3ez/08af/Mnjxq+ZaqIcCqEVsFV0tJiNMuMeL1u0HyV3pt7OITVyY2VyyYaaeD3BgjKaDnaXaJ4yFqPtkOWqEckG57RZBwTrBGsRlgBd+eBq1xNagyrMvURG30PGBz9I56y6+znR/vd43kSATzYLXEHTZvZ7XyorMrSiZomD1+r9h7bhLmXmAbrncRelgimyb9xkqogp2Ce7oxExUWbNX31KTmesS+eEuUaL8THBgY+hyKWDkgX158TW+xXZFwmbt8YxydTNPToTdpc9BNMpft/RfMRh5YCXLvt08QQ6ofh7+suyVZ+2cceBWRmsy9FCM2zSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEIIDWiOmg/0kajlvYUSpbv/F2fmI2Os5Mi5Cwng0NY=;
 b=bTac6XoHpYyvZRIrOldjwFDFYcj0ODwAGFu8Ta4TE0qUTqRw4PcbCavKFcrD2ksLqggTISaF6pFpPPCfNewiPKTWvG3d2i1MOoMI+QEg3xrADVWqBv1PgUjnQS5nR4PwyqToIaSClqAUxfenYgd+i9t5N82oEeynLUOWDOBwLxjlY0jqDuzgmhfO+8DEK2SFiRf/iCXlCmKx/LIIjFnplk/FDycUt3hjb9cmdRq6OtIOUjVo64VVecfE0g4YMF/tGhm4CcK/X+KMQ4lY8UI6SXokfJXQGRunrEB/B+QVjxhU0PRERIK3QhokAT8eSeVnTfpp/w4Vh7tfYzLX+oKugA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:50 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:50 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 05/11] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Fri,  3 Jul 2026 17:27:32 +0200
Message-ID: <20260703152738.129122-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 8530ca81-0768-4554-8462-08ded917a486
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|6133799003|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HqzKB3Z/fvOrq4CV493uFc+5yokEKo6O9//gvAtdfJnaa8nbW8LfW5ie5CXsf7V9e/SJ4K92s5o2uGIYVBnHRHw7PDw6HqlRPtARdJ57sthgiO8uc0UqHMYEaFEpA5vAPW9LfzMKvhN21b+wn2Tmh/419+KQOnre0sPVfvty/KsRnfWtBcRiB3YOh/X/fYveDK0RxJ2/M7SYGei/dJuMJ3DqCnlldOgKggT/DmH2sBoGs3gA3QDaWIaD4yE8LdE0wBkN37NjqnySXkS3q2V67L4MkKvQxDwr+dqjiQUEMvrYcpPRbg0Mp2m67GvfHS5E261HKXeR1v09aq6RHMcVfiIEVtpF7Q2ksIe/mtRhSPIT/AYZM1gByyrEYqFDX9cvFO78K0JqVev2vN3CpcMwd4je5iwtIcfJJn1/YCZA3p1vl4e195fs+7OxIIp90a+/teSbLrYMwlHPsRotfVeg1J1LNwQV4QYBm6ZB+MmTSolZZ/ltPs6HjQ5qpZsSTBlgnkfEuNazGTfVKBO1aCsUlC4OWd1JUEY8G8TYz3461Ywu0MoyPAC3LBL5gCwO7gKxYIElnLbkeZxxZ49KHBFDapKvMtelNizz/2NBnCphvq5hlth98l9rF0gRlXBEaPXb6GmHWDc78QF/DJ9IE2ep/uQDKRL98Ze6ukbOI9gppng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fYRLtRP/QJ2RHFMgmC9vewcHqU281yUSjFxw5rZHrLzN0YjPW5ZvbmtEIuJz?=
 =?us-ascii?Q?k94r6ZbGJ45YihUsKcUOAHURoOl5vz67I9FWOOhjeCofAJO47XirZyWC1sUr?=
 =?us-ascii?Q?OMrnm1Wa1o5L5joHgbfTOWhBY3UkBB3vduGcYYCcJ08WUoszCEygCS7nJOyD?=
 =?us-ascii?Q?zpWe9pzuTLGIezDyo2gmY9Izvm1GZZXKylxkI9qlFP4fy634pSQptSRkFVaL?=
 =?us-ascii?Q?1AOG5p3Tk2Davdr1An5g8xLSODk6Nf8FIKENuBUxREp/Px5mvVmOHT03+UDJ?=
 =?us-ascii?Q?Qzp5rDYUIXRR4aD34vofWge4F+q+5uaKGw6gM6KC2pH4mEX6axiAZ/6aEc9H?=
 =?us-ascii?Q?EEFbD+5XZe6rBm/GowG5BnM55441kZsOJhSJPnFFlmSl7X0w/U0H73ruEn46?=
 =?us-ascii?Q?3twM71v6Ap9RBG2NxNoTYZqI8r1YhJCU6zKyHs+vm/V+bHSup3PzzVg4M+np?=
 =?us-ascii?Q?GiER78Oo/IPv+v6Ol1W+1Je7l7c4SSJW4BRrvotdAW6GHm3DpevKAG+qHFI8?=
 =?us-ascii?Q?fNn+RIzkPEvtO9TOWoK41awkf461x9xDGvwYV17JoUsRJdJuHan/xzOH+thv?=
 =?us-ascii?Q?iXHOGcuA4UcyDoC2ba76xpG9yH8A8L8AdhK4EPNp89FHgsPSFbacDb1cGDYS?=
 =?us-ascii?Q?N8SDmqXxEx68rsON6Z2LRgm36HMcC2jgudnxxdgq74McHTm0/1cz2IID4EFP?=
 =?us-ascii?Q?YSYzMEW3PuX1XQwWEOaORqgphn/q1lXjSjFW9kDaBW0vXP0eoanZQAFtlfvy?=
 =?us-ascii?Q?vE6cT3zxlK4e0iWYxxJ7KegYkDIGIkqTrumP0yc3aE1KKcVHQStP+CZkl8BS?=
 =?us-ascii?Q?Ixgf2DZtNEDjqgFskHNOSPFWRVGNWwlkO7dzuzDzvExBJLA7O+B1LzK0S80J?=
 =?us-ascii?Q?mBnTu/JzUWul18XqQ+Nl1E51OOKrF0xKkcBVuXZeqe1GztKeZFQH18PfHgKf?=
 =?us-ascii?Q?HUcOgEVxVDDm0reByFx2y5kz+Ai4DSr1Mt11p76/TsCNeP49tOae4/9kfKdI?=
 =?us-ascii?Q?+8YKaBuGqcpgM+jUVGLeSfNlxvmVktmFisd4UGurdlamwLQsWnQhswsnXesz?=
 =?us-ascii?Q?rBJNiS6vBsbmtwpTlppFat3f1HAfBtRESLj0lPLKzzgnWS1xIZVqjfWWRxSY?=
 =?us-ascii?Q?ss+xYya34ORtdVfyZs16TFWqTsPzjdpmqVdRq96FogBVoq2Rh0EPI8hMHWuO?=
 =?us-ascii?Q?b3yLW8gLuXlCXg1XXNFyt8s5sRVsquP7b+hbQyAuqu88FldOiuJtKC51Hdtf?=
 =?us-ascii?Q?JxiQqqEW6PSOpB2IhghZKfmP1xerJ5+akWkKNx7VWp1nGUezYZYxJaWF63a1?=
 =?us-ascii?Q?PDjwB5AJ7Gxjc8frISZD3RXfjICnavGjIizyiE2MROuDPaV5WCJpdE6tZ8aK?=
 =?us-ascii?Q?pdHtkdH35P+5LapG7sFLsbfMuDT9D7pYGiBVTo3yUYRWrIKlP5oCPxEZoi/4?=
 =?us-ascii?Q?XUKVy11QLPVcaQm7S404cAeYL2ystf9qzYwXIIMv6Olhj9VtJGqlmHKlt8t3?=
 =?us-ascii?Q?NMtgHdr/QD/ehMkEcPWatggUDwyZL5hMVAEnOQ3DoYJyidsba6k9X5bpd3m0?=
 =?us-ascii?Q?st9u3OA8cbcCMQgdjVIbvKaJwRrGB/v4gA61L/+Zw7A88Nk5GhD3akGb2jkR?=
 =?us-ascii?Q?ZMgnyZuzOr2vCMjayS3Gga6TNYFmPQ+B9f4Gc7U86cksta+bGdZLFOYgkY0C?=
 =?us-ascii?Q?g8tDomSQERI2DSnL34uxBRRStDKsrQYhE3Y76fi0bYKZGG2hsnrDipM0LMj2?=
 =?us-ascii?Q?QJDy8OBbHIaXAQUQvczG1QyQwoVgQgo/H2Tfa+F1V8bbNWtwiblL9LUPPuzP?=
X-MS-Exchange-AntiSpam-MessageData-1: ahh9VGJ2vCc6DFm4ALvN7XsR0FC9nsZrMLY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8530ca81-0768-4554-8462-08ded917a486
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:50.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgxmUc6oDdLz6kfEnMKYZqwpNTIuf4nZJqwCaV46CWB7bk3rJIFvyi1ACwVLec5dnpGjzdTOcOGWYN+MrcJ104urqkxqQsAWcSFgCGOLyPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

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

