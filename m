Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EF442C
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNTNlg3OXmFR0vE3ODMowJJcSze502R0m5pyNyiS0szU4TIARmLnRwRR9qUyB/o1RcUY3ZtGIYGf0sLRTmengc036S82aqRQMlzmK6PCIe1j16wLJWi/LQHJYeLUU2lsXqrCXa5yYPTRKnIJ+t9Z1bh/ciLt8I0GNPpuedvyyQuwrC+yxkd26+N9AGfE5Q+/Vobz2h+pxbkxoiUa/QtJxL6Zsu+/KX/L34rvJQnLfyrixt9zHwZMloTy1v+FgM86h8B31RjrnQjBGUFYb3fLjWYuJBI1hpmvZiVmGokFJQwf4zJ0zTGfcvHA2FjiECfGOEwxWWp6tEsb1XbEjHawqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7Pf1ByLLSnSHdB2lPCKPfuqepTa/raTpx5TwKSrxn0=;
 b=B5kPGvOLlXXb0G7IB8V6CtbC0gRHfjED3puLaXn+Ftdend/LUpnX3POVrQoJ7TWr/bricr8+vvV273OrTAWlb1qnadrn6uwxypTKmlNFRl7Zvt20ZI7rbF8VaX8zjWyxttFkRKWAY0yH1LyIWKMbBu31ExxviquBtOefTU3dxrAMq35mz+Ds3BnfBR+7p4TvmZ5+NEjKF1mygNGDkIFx52/AzoZWqxNXSBxSCG6AdYW9R+qja41oYkqFgnQSSZ60Viy7MFCxAWjTaBomoVITXF0K7tTqZox8mF0+17/VfYulQY5wlI6Ma1mX3bf41HGsyWYdPjxfJyv6xtSIcPShaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7Pf1ByLLSnSHdB2lPCKPfuqepTa/raTpx5TwKSrxn0=;
 b=vm0uVqNj7IxmFLWj6kEsQr6N38JlXPr/8qnlaFTwOdkMJf4rLu726bH1B51Z5NBTgwBsrThtQXMvUe08mtb5zd8gBniOoX3uMtf5ilZzaayL3W0d809XEE6cuqJR+Dm7yIW0uPya25hPelSjMmVMo7wW1Yz1bYpvckPDam9xttVeWJrckqIVnLnkZjhvvxE5vcdOh4rlhamaXYe/wdmSEXZC1gAlMWBPzauKHANcgdY5a2DZ3bqwBSqfJE8sGjWO64za3Yfsutq5kDaS2OC+vEjitXD5CXee6UB24WbaJpFzT7VEiKHusmUSZWfFxJCW4LPt2UMHkaBL6zFj7dNAfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:06 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:06 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 18/42] y2038: cobalt/posix/clock: Use timespec64_valid() for validation
Date: Tue,  9 Aug 2022 15:43:02 +0200
Message-Id: <20220809134326.23688-19-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649c57ff-dbfc-42ae-ba43-08da7a0d3ac6
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	na5EOoFM789OD48FEdPFIX7cQMn+Cze316rlWUr++iGpkZ7RplABTv4DHWHgyIG1LpMPXtf5p9llvHc/odcVh8MYWer7375ZhwlNcA6CuP1QHq/Np9rRTCqXHup6uYGiIFOcma4OnoFVSs5/vAEeizrPOalqJcQcDRlGgGBmcrVNsMfosg3EpUkMBPKuYXfYR5uW0tG+V1GTyIrZ1lzlwMNJKBJMkfsnZQovJQtTNcYqbxocUq3Y0uSwe5VSBb4QyhnTERrbIhSkQnlnt/De3/tKB2Wuuhpl3cVbVZnm+CIhni2SX0UJ98S6T89jJvCLeHsDftgwvuJUYolDK8V2HLQhpZ3Y1LAVOMrIKuwudVgAX88LkTeJlAJBu4EqczGqpHK52MPDat2EjsjZ+Dv3i6SVdGwxpXLJjM4NRMbvL2Vl7Bc1LKErbgg/UtIamGnFFQvWrq1+qBbv6HQEGJE686sVKGuOScJ55wsWt5s70x4e4FO6SGTccMwrsCvXvg6li9lbo9gziffjp6pwccQjzwSzLM13m7ope0AOMwLC6ywRfF/bnXWbas5wU353MFr/vr/OwxJfzINZ40w8VfLZSQPuXP38ftZFxNo0qXn842npSJ+v+4BPHDTZc8EOLqOpm2sL7p6eEIR66Ekahz/0rjUuH3HWg34vQqkwKRyPH4smW5BPap1sOCr87ZC56t3UzsOmL3xbYvgvXKkI8nqbp+L3EMMBItJCKMc5HVy8mfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(4744005)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(55236004)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvoSle59S5gbQYZeMLMTSoZR8cEBU6NZGT90hWsMpga57u6Au8o2J1c9Or6z?=
 =?us-ascii?Q?kWrQczoHGTQhz2PLSmdyS6bri6OHqkTBOWEFb/L6oVU+fdf/PAnfKkBvCDVk?=
 =?us-ascii?Q?tCGuxZNh8Y9PbWHSaqS4nq3SXg5YWpgeeyVthjpJLrT++aAIS1MkhIMyUp5z?=
 =?us-ascii?Q?1LVQZiLtDMKZOpfQZ1In2CtDES0yAVGThGPw07UdSvED41OvEG/MZjliufW4?=
 =?us-ascii?Q?2UVc7xrJYwoawymvCrhCSujdwiUj94z9zagJj+sAaKrqjMTE3ehpVp0/o+CY?=
 =?us-ascii?Q?LRbZaDDsl/qS+O/59QlHn3ctEXIJA0pbiwnxdAt9MOqb/xhIvkOTh+Lc64mo?=
 =?us-ascii?Q?4DXFJ3g4vDVRYwqTUvE8aQL/qcOmLyHoHZp/zJcerXeRPpCm6IzVitDj6s+7?=
 =?us-ascii?Q?DG3iUN1O45GCKHbniUZ6L4WtM6zLD+BqEPymoQ04UcGnRCcNzim1A/+JccoJ?=
 =?us-ascii?Q?8nL4FdQewOPR3ySX4EjknJ406EdI9z3A1SU6wgpIhww7jcCserJcUJhjTkNE?=
 =?us-ascii?Q?kNesRA4mRO+rfo0+AeUFpTchMcct1kmTunYAfqCmqGZLHP1l02WKXduQlDt/?=
 =?us-ascii?Q?1DnydEhhz71QxUCYrdOGzlcC7SdWGr1P60ojd45RrgIRUs1OjABNEn5hLltC?=
 =?us-ascii?Q?i+3ODNYukj3CzMspTEBBTh57+XBxJXZp+rkFTIUbdCFASPcQBPznNG5T7ShD?=
 =?us-ascii?Q?HwX1XyXjb8XqRIpa8MUQZ8MRSxsRUtKtD6tgEMz9lws0D4RfrLzfW7yTot6M?=
 =?us-ascii?Q?ZH8h5ziRLD1LwUi9spLnscJCYXQBWy8NkVqHTSurMUCaVK4H20wMD4BBPBo2?=
 =?us-ascii?Q?AINmg9eRaAFh3GptPZOI9OdklIui8qhUZh6rdX/p6pg3doeWYujRjgIPBHTP?=
 =?us-ascii?Q?LRU0KF7t0bINiaS5M/9436BUlQt8ozLB0kJegdUQhkhIYYRBmtotlOBZSSuf?=
 =?us-ascii?Q?cOKNjh1ufoxju/41CMlOc2kzo1LznLcMocVHiDLpthXbQBkbREnYcuCylZOx?=
 =?us-ascii?Q?Cy15naUUtt1aKeMSJKq5stu2jpHBqiKswQyk9UIx0J3PalVXDb32dF71UXH7?=
 =?us-ascii?Q?nNoV47fcQPnIKlOL4I8GhD75RKnKjx9QeXkBzn0P4JP5sB5hYmWJ8ZbdgbAe?=
 =?us-ascii?Q?rCVrGGLJHXam5XXJaAf2mSlM0psF78hwn3ZTWtqpgDAX4MDNBHCzhniVfG/4?=
 =?us-ascii?Q?wnQGeR5JiW4aenOszMWDGq8vq14yjJJKnHh16I9koj6brpMYBPcOhKIxLWve?=
 =?us-ascii?Q?85pcvlMuBKSQfwXtfgGmmnv883kKBFt/vmc0cm40k7+ciZVAIBbZ6kUDz7FD?=
 =?us-ascii?Q?VnI7123eW4JfKv00hifprc2WW+G9YqBVENYzbYbXf1c66fAbft2Ze9mFSHNy?=
 =?us-ascii?Q?RY9dgFJdwutYL8aWBMir560pOsRZ1D7um09GRv6BmpdoAVzZxy5f39nLJp/M?=
 =?us-ascii?Q?WIr6VPjV0KvsceePUzSh563PEGxsBGtsADmcWXUZUulHPwOAAHoQEsnZiR6H?=
 =?us-ascii?Q?H7GdUHgwx7Kw3xfwZ2WifSS944huizpuHWUtwKxnxcTJsZEdL5v0zotq99rJ?=
 =?us-ascii?Q?SeGxDhd/IL+qMuwQ7Hjg3QrfubDL+MBTzxpaw/qq/lGGL6B1q1m0OCUvGi3K?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649c57ff-dbfc-42ae-ba43-08da7a0d3ac6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:06.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz3akgedaIC+8SPfclhu7qTD+j+mScTZtgQrLAYysXuNFHM+3SmWqMLZHqHQ7Xbf3+k9yY8ykgkLq7wbkDMpjW2AsvGUiz0dxOG9i8r53xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

No need to re-code the timespec validation, we can just use the
available helper.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/clock.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 266ccef52..48cd87aef 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -286,10 +286,7 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 	    clock_id != CLOCK_REALTIME)
 		return -EOPNOTSUPP;
 
-	if (rqt->tv_sec < 0)
-		return -EINVAL;
-
-	if ((unsigned long)rqt->tv_nsec >= ONE_BILLION)
+	if (!timespec64_valid(rqt))
 		return -EINVAL;
 
 	if (flags & ~TIMER_ABSTIME)
-- 
2.37.1

