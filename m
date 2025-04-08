Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABA270EC7
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115681; cv=fail; b=YicOw+LSpRYQ0q4wMacwFkQF33B66MkmE5XxmZcTki4AzL6Vns42eVR3giXjqVz1QFgC1L4Djftp5C6HyWI9rzr2v3S4PR0qZPCmyjOPZGQ5yPzaqGv1eDo5nVSXyKVKiQ3GFWsfb2GeL5dEVl4XbZPVZIeDTp45sCLgU1SY93w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115681; c=relaxed/simple;
	bh=vrnTsHkobybxTFQpec2uwBcfYkow8qZDBsuSAEDp1Us=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UrkU6QJQMQFYsNjoepg2f4KcDbIpIOGfT3aUnISLqVRWYGRDcUxvsZ6LmQxzRT+ZVPUrT2VAuToV3Rx+A5yFAG8EoClO4oRIr3jmwTAN4FpC8xYsbVecNPh33OGqYNvHoHMSbKLE6i17d83GSjwUoMY2wMYI5USCGPxUIRlfiIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=SNrLYzhQ; arc=fail smtp.client-ip=40.107.20.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="SNrLYzhQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umKtxgQdMvDqFMmxM3OMkyEUp07zJXxa1kwau/+RhJpzFhyDevajONwlZBIj4sceORJD9xPMeaAakTIFSjXp748PI9oY5csOUag361VLURUjmH5MlzjZs7Rl6XM5RCUlnUfzlUX5viVCnGNg7eWgU4PZvdRpJZSx0NtHKKEa2laIMWl7bUjzFCNhv5l7MXJV7NbdwhBmjTtpbcW3uNy9YzB9rorS3jx4J2nTyvpvRG5XA6d4fX4C6tGWG8P3nhJknWSdzpdeDn/QzWNKqXkY7xlnBSx/UXbhoHw+4I3UBbJdtg0U2QQ42EJdx+9Ote3f7b2JkWo6PPc7DGvq6uGyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oScPvrghC8fyPOGb6uc5oEEbSPmYHNpfbsS9dKv8Vac=;
 b=boVbVvoWMTBMrpUJMSWhfL47cD9rANtEGWUlZQXCQKZt67kMOc7EfvRgwE8qZOmakV+sWXs9jNqYAVJFb2ZtZbVkChOp+PcRi6SVi8RDqOqDTcAsiZ7RjSIbG6JXdi6Q/n4zRuTIwLSqHR/D+wNcBBpxi4WsYVmuqHbjkmaBPX4Y0XEafKAsEqy3ox7LOWj/d+OXBfLHMiNDKaYBAGSPTmdjSnZDikPsdFNTCkS2BztbEYQdHJ4+SHhVdut+C87HN5qy3nGMMBcwby+8s5Iue/PehKY7GZ4q5l2G3wXwqNrtjk7DNcnBwBSw2ToPaCjAP8bP3DaK6/afh7gwylqZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oScPvrghC8fyPOGb6uc5oEEbSPmYHNpfbsS9dKv8Vac=;
 b=SNrLYzhQNyp+fCsyEb+lwYYrdKYr8v7pig5SWwWfJQobhgxWbulrUd2QAMGZEiD4H2rqPeXPiP7bm3U2/jmjvGasrVzppjMi9fB7WHLEC5/u5cxRFsQM+i2jIHFA3p+bYc39WpNFpy/hXLzQdcbqlNYBKflJxXtF1GaofjiR8AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by DU0PR08MB9026.eurprd08.prod.outlook.com (2603:10a6:10:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Tue, 8 Apr
 2025 12:34:36 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:34:36 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 0/5] Dovetail: Real-time Exception Handling
Date: Tue,  8 Apr 2025 14:34:18 +0200
Message-ID: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|DU0PR08MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: be59ba91-c168-4008-b2bc-08dd7699b88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2FMMXALZW68Q6ygY47HdpGUVJk3LMTTBwfpYwoIdFdm+htqLqr5dNi1cUVao?=
 =?us-ascii?Q?ZWAplR6g84gVXqxqXB3CauABLVyzpr2trxZCjyHGERd3Ge9ivkk/jJnlJPoR?=
 =?us-ascii?Q?wwj7+07bdTb9IoMns1QSsrGBPVb0WS0bV8GhZQ/rvmek5tWkjtjZjIEHtOij?=
 =?us-ascii?Q?AxM/KgSuZn2SkQI87ron95Oq0if0Idycdh/qgLSZFlgIT4fv7g0Fq7pmUH40?=
 =?us-ascii?Q?BMfXZAxV8p+NshPY9wIKHstZYShBrD+DuIcSzIjdWO6qf//sk5wyORM9QbKt?=
 =?us-ascii?Q?rHiVEJIFMvm6CmqVtZy5zBTWRPxgHXhjQ8emLrhAbR4UBSLMcr3P0bfFJ7r8?=
 =?us-ascii?Q?wJiqZV37/HEl8JLo3FTmAdLERnux/orsQQvG5+rTi8iDHGagA08hVt82fQwU?=
 =?us-ascii?Q?5BrbPKl9sKzyf/ycMcPCx+5jXOiEWR9SgYLWNTpT96stCNvpqimjX7+UEL0u?=
 =?us-ascii?Q?rwDxdKkl4r7bCPXs3aWD5O1RRCeg8Y1ajF36efd/QC9bpwX+lcA5c9HdfMXC?=
 =?us-ascii?Q?0hKw08Rsh93hs05BZUhzZn0xa/kSIgRjAdfYaJp0u0iVN2Gjdd6jvsUPAf03?=
 =?us-ascii?Q?MvBPbh8dYhcVzm00Nyj0oOtll14CXCDKam0oOBxtgTrd4w8QX4bqGhPjzERY?=
 =?us-ascii?Q?7+vPaZTCw/n8ok7YmLhG6Bi6AXTNJdfG2Jm7KImN5cObGuZVXuYiUDOZnMX8?=
 =?us-ascii?Q?kFJ/zzwRz7mHtoGDXHjoh91eFdbXgZRIc0VuFH27xWgKQuBcg16CxyanjYG7?=
 =?us-ascii?Q?ee0eadKEjL9jZTqofGV5Nh9CvpTIvpmBhTZuSWNr+EOnNlgj1BNHDmZUlEmE?=
 =?us-ascii?Q?xPDC8ognThUgdsG0FggkwfthRBKETBf5ViPmgls/DJXiEcO4FcVv8KYxeHF+?=
 =?us-ascii?Q?9Jmmm5lMw1HZ3d0P0yafStmtGAOFHxjrpHCtjHH3l7UDDS4ce86DPDmolylg?=
 =?us-ascii?Q?AeDFvDvmaJPEzRgL3aY+ufVg3Cf7JtLBksJJnDlEvdEoBCiM7e3VmFvx6JIm?=
 =?us-ascii?Q?WxERHAMINvtN0krM1nx0WBz1VqlQlI4Ldy/XaLV361nCZE4FlcMPrW6S1Tlx?=
 =?us-ascii?Q?V5Pfc40rkRXjkW+p67a55bqi9+s3rlmUzY216LSfq7M8ohRI3dIqlwlXgvYR?=
 =?us-ascii?Q?zUvk65j8pF0cK1kjDY6B02to40kzIrrRxWERH5ekZgiMxy66/h4bv2eB4ZII?=
 =?us-ascii?Q?MNFBVPS9H8P3/sgNpP62/czOAzcFWg6JHlBsOfO/tYEp6kIRXzeOT16miRkY?=
 =?us-ascii?Q?7LIWSwxooTPMIgS84xfcdRrsdhZy0zQcbNWITK9EkqODknBhEkv/SVNSagn2?=
 =?us-ascii?Q?VaDQfy8/mAZuvSOZ0hrlM+Pjj8l3JzDo8pz0kGch20OC0lGnL/OjdgFh50a5?=
 =?us-ascii?Q?qIwV63UHV1uEdCxhdm8OtsfmGfUxbialhe3KLzbVRbiGDbyLAGea8q20Kmep?=
 =?us-ascii?Q?M+ekGgOSuus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ML8AWtZ/QxcM6UbNaRONCQi6lF++X8cgHeUpMIeO1p9XQjO6sKqrFyddkNIL?=
 =?us-ascii?Q?NNOIYGEkClIlJIHPJVQiaJd4QN+qPHvJdxc9j/NP1j4V1n4ro7+swXJuGuxD?=
 =?us-ascii?Q?QVlPOLqRfE+/Je+/7G9ognZoQ2FSPn8rUUHh+9NJcCA5S3c5AnNX9Fz3O8IS?=
 =?us-ascii?Q?o6AVvsq0Ncdv+PE/gpp8zR9hbdyqbqQqDstxnnUirBB2RhBdMxTAbyX7EvzZ?=
 =?us-ascii?Q?EGYMzv41b79MV10vpIqjCPSVN1QjZdTWc3bQul0hSgrxJRyvLT2phyHc+Nk6?=
 =?us-ascii?Q?nokrUQbKzz8lL7PlOfHqpQSqqWSpAfm7wgnl7fjlgyBHiQaZ2OvPcAlDdHgL?=
 =?us-ascii?Q?kiQMW4dV6YvMQlya71D1x/uEC4RSLc81YVIS1utbYngkGHxgo5dKZ1bN7Akx?=
 =?us-ascii?Q?7VPFc8vwdwJjWGlSWaxUzt74kfHUhUKPVjjFuah5Q4B71+EHlhv8zGZGDJfH?=
 =?us-ascii?Q?/eaqQTlbExsq2j75qIjQBSV3lb9cQfIJSlAbhyFA9uHs+G/yg5qfRRFy47Eo?=
 =?us-ascii?Q?xjxgfQrzSK7hmR8efbOxeX6h6TXUoYKTn43bC5SLZL8WQs+QqdBUdWXZxEUH?=
 =?us-ascii?Q?cYjgFTP7IB8h8gpk7dsL1282FnIVqomRt7Pr2ncjKrY3d33wBsBNOEhwkOmJ?=
 =?us-ascii?Q?jfNj906Sy7Zgwa2RV3ThpOSCASVZAuPvTrDLHxQS1j9RK5pyqQeiVV8Qj2yn?=
 =?us-ascii?Q?/Un6z3sr3JOeFSlHKFZfd2YdYgQGnEd6ys1IjOBE7GE6xHeuhZ9ceyxBucHc?=
 =?us-ascii?Q?O4uQRlref5c1Frub9lxNPaZdENG4m2aL0/enwprpUsLdYHM1ampKT0G2jzGJ?=
 =?us-ascii?Q?sKX9W89iUo62Vjb69O/xb33EDPzA97Z//k7dti2t8cL9axO0S2GH9KNqbSgj?=
 =?us-ascii?Q?2OLemLYq77vV7KAjkZDOmqJUkmXes1KXz83492xXWRPDyVPDboGkf6wct6pl?=
 =?us-ascii?Q?I6fi62AJUUoUzGmrq+7xu3FuR3POJ3ooxfmlf1YqHuJz0f/H4y/rvKo1Px8w?=
 =?us-ascii?Q?lJKlwqSggAtfmrqhXHV8YztiT4OaZEVlPkFoDAmLKAU80yx4mHD323CpC8Jn?=
 =?us-ascii?Q?WFv189YAHqZwkCRk14wx3k87vDofo9M7/DO9DZMtCzyXr2K7ZV6OT0RD9E65?=
 =?us-ascii?Q?I+qo45F/346wXQEoLzEU6YiTk3gjm1D1yE4PJQI+2V4EbvZsiCSvs+8Alhf+?=
 =?us-ascii?Q?F+p8DpwJCRTUW181bhg+5Eu+g7V7ApvVYWH/x+LBnnJEnySz5J/97JpKrtA5?=
 =?us-ascii?Q?8ExvlRj2KZKY9Fy0YbzR/GI5/vSjPYnY3qF2nIcERa3pY2FZu0FyoDPdSiRe?=
 =?us-ascii?Q?wEHCQr22dhAtJkXP5YQh5sWT41EdxK99UvS/fuaqmIlHSoxlp2UPKMkpbh43?=
 =?us-ascii?Q?Od+2gy7QXtSKrKvji+zspLccjFf7gJlTuDI46g3O3ebUaUZWWfdsVRT+oyvk?=
 =?us-ascii?Q?fsyUAI71AWqgGISFhgTShDQTswfmPHMGVkncOvwl5L1ttd8vV0t0yPAjtvc0?=
 =?us-ascii?Q?CljwuLD3I+NWJr7xyeiecVaUcSOyg5lkiSZ4rUFejwyhf/kHNHsYKtGhs6ql?=
 =?us-ascii?Q?oTeNGaUlCDZZ/giAAX895o3vFg7Mx2YOq1vs4ZDTEcQUvpMW639g2RIh39KW?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: be59ba91-c168-4008-b2bc-08dd7699b88d
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:34:35.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE5UzzeM7c0lSTfJ62TwvYestmfwfcYyyG4GRI5C68aYJU8MgZ66K8EkFKAG5+XRcvFtgK4zs8sBl9k10HmHIJnqON6VtV2t1gJl0Lyq1iI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9026

From: Richard Weinberger <richard@nod.at>

This is the Dovetail side of the real-time exception handling
(aka real-time signal) feature.

In its current form, it's a bit larger than expected because it also
includes the signal frame helper functions. It's debatable whether
these should be part of Dovetail or Xenomai.

The smaller, but much more important changes are for ARM32 and
ARM64. These allow fast return from exception handling so that
Xenomai can decide whether an exception should be propagated
to Linux or not.

Lorenz Kofler (1):
  x86: dovetail: Helper functions for signal frame setup and restore

Richard Weinberger (4):
  arm: dovetail: Fix user mode UND exception handling
  arm64: dovetail: Allow early return from traps
  arm64: dovetail: Helper functions for signal frame setup and restore
  arm: dovetail: Helper functions for signal frame setup and restore

 arch/arm/kernel/signal.c           | 50 ++++++++++++++++++
 arch/arm/kernel/traps.c            |  6 +++
 arch/arm64/include/asm/signal32.h  |  3 ++
 arch/arm64/kernel/signal.c         | 85 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal32.c       |  2 +-
 arch/arm64/kernel/traps.c          | 18 ++++---
 arch/arm64/mm/fault.c              | 15 ++++--
 arch/x86/include/asm/sighandling.h |  3 ++
 arch/x86/kernel/signal.c           | 80 ++++++++++++++++++++++++++++
 arch/x86/kernel/signal_32.c        |  2 +-
 arch/x86/kernel/signal_64.c        |  2 +-
 include/linux/dovetail.h           |  4 ++
 12 files changed, 254 insertions(+), 16 deletions(-)

-- 
2.48.1

