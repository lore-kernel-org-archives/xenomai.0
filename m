Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3C15A49F
	for <xenomai@lists.linux.dev>; Fri, 21 Jun 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960156; cv=fail; b=A83ECl3TdDqyFhkDaSdOHMgcCUnKJlxodlPy/+HrwhLDokfSVdBwZrLHfPGF/4XIOLmElVGzMK6tbD5CDGQZ9l9b6DavKoLU56/7G0H4eKJvkGXgsWp7IYaX0Wnp3StrKd3XM3zHQNnfrqMBCS8PUJr4zycHz8W5pilwnP4Qs5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960156; c=relaxed/simple;
	bh=yfbdwUulTD1PBvRJRgpQl6bjW63hkTynH5waNmw3g6w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pg96zUMB0g11S53QhSHSeDcMOOjKLy/qawgZJW/jSJwNcuP04H/Ndqse73OVstYedfi2DDo7AiMGxh6HlOfVkGIdpaMytj2j3unyfWA8vKFMfHMW6xTQ1aTLTq2+KRP+e/K0RgExxilezj0BVTscHLtWvx40MsgfdSABM1rso6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zHXlU3ab; arc=fail smtp.client-ip=40.107.247.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zHXlU3ab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6k5NtJQeTVV1yA2AemNoucHbhgd8NKNjXVGk3e0xeVHPlSXMNEO7HcLsC1x296uDQ76fOs3MS/eObe4FC+jFdbzHC5ZyB9kBXxBMed1qDVm2A/VKOMWUflK8vdBT+cAQ6AOwnJqZdUpWlSBBiWlxwupTYUTrUWj1JA1v6Vko3UcFlJ+4RKkD8SONFMZja3EFwUpCnVkkabyE48NTBJnnS2fpzqoFgntq/x+zebafgZMTKpcZxwakaF1xQCxzUoHSlkxej+RS8cunBo5lHootsrqWPBdNCXq0oYUiCjovLIgDwyV5teCbQrvmkRMyI56aVWuvhQfkuuj9fuuR5RoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onteYr8zs5PN6K6KBhS5RJUUV5TGqTqcHiDwfcFZYhA=;
 b=ku7x7DvZN2ogDfMwP8zfOgHKa3XgTFJM+IzxaPZX+dJNvFzvxYPoNjR9A7wZjKSk8/Y81cZTHUjHKS+ElfdEBTZrkVOLKt8g9wpzNQLGF0ClMKttL+sSPYvDADjMkpTgTjbJp1DG19iMJ4o8pyYiZZhV/trVHlNT8/dNxRbauKjOIZ4HdovQ87K5yj2ppDVvMis/qzy+eZIn6McZCnFmoMPy3RwyvwrWTmJZH5v6f2Wvgq6XVaBbDdLu32Eoc+xH3Ddr5VPvAFeS4b2He3WG1QQzvBpuBd0DTZ+73biN4hC3Ky0WZPTkSUxBFM4Kbuuk1i68bAKDUNfSdWzRPLshlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onteYr8zs5PN6K6KBhS5RJUUV5TGqTqcHiDwfcFZYhA=;
 b=zHXlU3abq8yuT0cypIQy1NOzIl3KEyHIl6hWRIK4sG4DPt0l/DSIIXFc+vEspIqMIjr2bu+Hxo0nlxGzv0Cf0bJ5ZkNfHFPVIzfazySTZF3m/sQDqH3jalQB3ZZJhzWWuMKgJTz1WPNV+uQ9TSlL2diaitCUTCmhdEbOa1O8RVIPsQwQvpRQfN6dlzjD2XDO1EXtjemyuWSiGvg1FQpTmtkWZwv1GmW6/DpdqdF/JIEZgelof0UMokjB1kyan41j3nx43UFQ3Y1O6fdvw61lapspDN1w2rXt8osnglU4PNZeO5pmI1CxSLTvwGaJQqccBy2NZJAo4ZaV4QQBJDGDkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU4PR10MB8640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 08:55:50 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 08:55:50 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH] testsuite: add latency treshold option to latency test
Date: Fri, 21 Jun 2024 10:55:47 +0200
Message-Id: <20240621085547.2088976-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU4PR10MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 32263e83-9d6e-4f4d-87ee-08dc91cff364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SYqUwux2ihRJNLvPvkmPucysUFK7IQOgd6FNouhpUC8k5+1ujrKNKSW+D5t7?=
 =?us-ascii?Q?td/WCYENGrRZtf0lGVpRhaRTwlbNc29gdFqxe/kqHWKva+IUpjkoPxW1SfRW?=
 =?us-ascii?Q?CXvv2nbmdUL2aPdbCEL/lIpcijtLSfRUjUeINm9TaXfEq4qO2eoLvY/tO1h0?=
 =?us-ascii?Q?BLR8Taxwjz9YDhN7ZdTnQl1VtOalwyPEreHTW0bbO0Fg6Tmj7ASONoyRCrLK?=
 =?us-ascii?Q?LiSkRrizbYla3b6xyyJwsNYwQcTA7xVGCMZDZio4N10kJVT/4Qh5e52nFCfX?=
 =?us-ascii?Q?U1lVJNz8ZLXD2dCMZuf6iN3y5/YWxkJq6LNzRnSzG2o3tFrv5qKxYlbdW0iH?=
 =?us-ascii?Q?GEN+YMB4yKPEj0pnPmkLjs5/0NJxfV0MfznTgo5VAxvUz5QsMkeTwhHjXo0b?=
 =?us-ascii?Q?y+b3M0BTRSkiBOLcRMVo0A3VUO+s/w5yt9FOwv5I5e/QyFNXDQbr4Qa9eYhl?=
 =?us-ascii?Q?plzJz1paZYD6ha2G9Mkr0csOFtYs4Dd46fPRCCRiuRxf69CnFfnS3GB9/27c?=
 =?us-ascii?Q?75aSV0fXssE05QKujmMo7jjzT20YrXofznIlDscgRI0h2VC1oSS7p8sFYrHR?=
 =?us-ascii?Q?jyD/9Bbe51/tIEl0/uy2rkbfXLfdQYICKLxb9ba5CDRspnVkkQvN6tIiPevF?=
 =?us-ascii?Q?Cl5D2743PfaDBAbda+QeBZ4GCHdGyl4e9cCbJ6oy2GY2jK7nAOhsxsDnXUc2?=
 =?us-ascii?Q?yv0DJmTQpTnj85IJo1TWadV0+Y4Exv7UoIM665kq7aAEsAFbnPIbT32W3+Bc?=
 =?us-ascii?Q?s2X7LVvN/BOlXCMNQYfZFbss2NEXVwB7whelepVenKjHGZLKow89PBwvQPyl?=
 =?us-ascii?Q?5JM5VyapcmfvQjuGFLPUSj3nyDZbEEENFFFnpJPxJqI4tICr+n12TPEwr+7p?=
 =?us-ascii?Q?8fhFJfRwtRLZtBs4JOoXaS/KHGzcS7a1O2AB0UWk23lo4tVRkBj7UKhO/E0H?=
 =?us-ascii?Q?nU6b/BrJfOC1IwPMp+BKs4uOBIVoEBBapC7ANufh5pSBBeYExS21FRh6JduC?=
 =?us-ascii?Q?eApPt4kPveqSVkLLvGjLUicinniLf+wTSEDpAgsOUk/Qqx26vViG6NBe+v+q?=
 =?us-ascii?Q?+Mh8W1KFs2DvfVaIW5H3SnVORPD86HHFUDwQn94xZ+PIvNYLhgZ+Wmeey0ws?=
 =?us-ascii?Q?U8VTTjalYePe6WdCKFFH24fpP8Ngt1ZAZwhpie4vgR+oZdWTuvVPcoCchuos?=
 =?us-ascii?Q?asuNE1iJUn1U5gJuR8o5KnokdG6LGTBODLPPrULJfEA5+YseerE01KCsYS9S?=
 =?us-ascii?Q?MDzoDTqzPfXb50LZNf9+ZL4ym/KhUYU4+Vm1xy+Du6gmHi4NGlC7Aw6sv8Qb?=
 =?us-ascii?Q?tY5WLWWB3GgGodbio8bHunO2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oleylomlnwuiltzqYGfVGE+jy3hR0oKrfZCQqnM6pn1rXnd3w09ZOwE0Pbna?=
 =?us-ascii?Q?wL6xyxtGWA+bUCIqt26r/A7Ysul1i5Y5uRx+yoYi3AuAxCPSn7erCQZC6jLi?=
 =?us-ascii?Q?TUo0fLko0k/bP22XAqnEZnf3IDlMJJSWrHaDd9OtRnw++v03dBqkq9tgtCSg?=
 =?us-ascii?Q?LVcp2xb7/PbEA9/t84Wnk51tXgYiyAr6DhMFo3aYcRm5FMQ6jAgUXiteQZkX?=
 =?us-ascii?Q?yIMUgOZctAwNOakUha+W5BP9pq5JKl7sDgtCAuv5PtEEBgSkIW6W4WWhxDLH?=
 =?us-ascii?Q?+T943fGMY5cVf3VKkl71glN2PKbK6DnZG0olNThITFvfZPl8xRvt/0AQqtbB?=
 =?us-ascii?Q?CyBvDugO9KLbFypkpv2W0AYbjOWadpCmYmb9FDYvcEKT+s1h2VSl03BABWJN?=
 =?us-ascii?Q?xKf9yB5EtzuPg+QDkCKNhCtorYyIjsf4Y89/34M+fchMmWlQE9qRX9MnFE4b?=
 =?us-ascii?Q?W7uaXg5QT/FF41csawScpZnOxBKemTuiCblxSMXaL/+WQnUASCVL6HZirB5k?=
 =?us-ascii?Q?TFwKFybOB8XQF6/dqLWM9a7z9IT4waz2JXIpyG5yfDH+jolrRn4XDfWO+NC4?=
 =?us-ascii?Q?Tht8qieEg+j3FJU/ZbafaFp1oHIgwNXqJr8WyipQ4rE76Zy/nG3FW3AddY+4?=
 =?us-ascii?Q?ZRc/p2wf26BaXynwCH22dvPcGINDonGqw+rZ6aOR/NwsciDf7xqH/7+5rWY1?=
 =?us-ascii?Q?9fwrhx9Ls0GFWkaXZQbGuSFtsA8NNF3PO70GJiMTHHTIvIYQo5E6Du6mkvnT?=
 =?us-ascii?Q?IoaW2tBxNGjKfQIDneuO69ZRW+KBKqMnyi8HVoC/MBIYJ43+I9R0rMn+Npd5?=
 =?us-ascii?Q?Oi2u7Cci3kl0p5XHl8AxXm2v//Gx2QlSLDH9lG9HgQbcFuUpYzjaIANyp+NK?=
 =?us-ascii?Q?mFMT75v9itBO5xuVe+wkuhzEYAzJLZwAcAXiMSQ3VMQ1p0Xs7uG+WVDVdksF?=
 =?us-ascii?Q?YXjUNgPxJUyF9U0pGbe5MLkcjTt/QKbjRbZSroFQ60Q2KDDwURs+KJdFPMg0?=
 =?us-ascii?Q?xj+SN63x3gUBuoaxSZ4uPAdEIBbqOdl9+TAqplTo4EDzZgdsZBCf0wGMUyeD?=
 =?us-ascii?Q?FOZaM83FDl28fE5R32flE0O3chR04smf6BcXaJUVC1ZGUwkEISDu9P8e9kQy?=
 =?us-ascii?Q?BXlEzEQvemVFlNPalzFK3ohGJN8ElKywbzO9S9BA5hXIX2dpjV685+jiLhvv?=
 =?us-ascii?Q?hxOSjQGseP2ezZsdwrFwb0sITWLoJtzWc4+ggT918RBiyG5GG5eV3RiG3ncY?=
 =?us-ascii?Q?hKoglJYBNj25qOQd3ZM4Q/uDCEelsyq+/jDPfWpB/kgmd8F4wNhgbOFAZXYU?=
 =?us-ascii?Q?hRzuNkJc3RgnGS4gyVE+uXFhJtU4nYFU9esphxAQwYbIN/nH8NEoGLxRU76U?=
 =?us-ascii?Q?gzkjlha3qUpwZCv6gsJ/ocGHjVJfJW+cTUsq6toZRfj0DhnL/wQMnwghuKUg?=
 =?us-ascii?Q?2D4hWCytJ4oJ7QYgpwdpRnii9PCQF4L+vllWiev4Tpor4muKaV4iwZ0qIpSR?=
 =?us-ascii?Q?p5MiV4DUjGP6fngwV9MX43vAC9DLBpj+waoC9LaztPbGaI/R1PKAZnEl5hl8?=
 =?us-ascii?Q?+84pjx3xAb5hU4RYAz9IF/hJpmwz9LAr8Vnf/+w01kAL5lwxBp/ayjL6/gqg?=
 =?us-ascii?Q?lXQ4oCxYI+EBhTHhe6I7/q2JTuGkWYs+VEo3jpDzsQjIxt/EZczUq+2Z3giE?=
 =?us-ascii?Q?jnBSLQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32263e83-9d6e-4f4d-87ee-08dc91cff364
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:55:50.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db1rzpOCLGTruMzjFC8eifbIEuRe3sU5CGRhuMGaSk30H9Sq1wWjDjDSA+nO2gtcqwnjDvd9P9xc2AKPmaXMDdS0gabN8jj+XVuICnDiq7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8640

Add an -m option that allows to set a maximum latency treshhold to the
latency test.

If the option is used, the test will fail if the maximum measured
latency is larger than the treshold passed in microseconds.

This is mainly implemented for CI long term latency tests to
automatically let the pipeline fail if the measured latency is higher
than expected.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/latency/latency.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 7856b48b8..52e315d9d 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -89,6 +89,7 @@ int32_t *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
 char *do_gnuplot = NULL;
 int do_histogram = 0, do_stats = 0, finished = 0;
 int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
+int max_latency_treshold = 0;	/* default = 0 (diabled), -m <max> (in us) to override */
 
 #define need_histo() (do_histogram || do_stats || do_gnuplot)
 
@@ -536,6 +537,12 @@ static void cleanup(void)
 	if (histogram_min)
 		free(histogram_min);
 
+	if (max_latency_treshold > 0 && (double)gmaxjitter / 1000 > max_latency_treshold) {
+		printf("\nMaximum latency exceeded: %11.3f > %d\n",
+		       (double)gmaxjitter / 1000, max_latency_treshold);
+		exit(1);
+	}
+
 	exit(0);
 }
 
@@ -614,6 +621,7 @@ void application_usage(void)
 		"-c <cpu>                        pin measuring task down to given CPU\n"
 		"-P <priority>                   task priority (test mode 0 and 1 only)\n"
 		"-b                              break upon mode switch\n"
+		"-m <max>                        fail if the maximum latency is larger than max\n"
 		);
 }
 
@@ -648,7 +656,7 @@ int main(int argc, char *const *argv)
 	cpu_set_t cpus;
 	sigset_t mask;
 
-	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
+	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:bm:")) != EOF)
 		switch (c) {
 		case 'g':
 			do_gnuplot = strdup(optarg);
@@ -722,6 +730,10 @@ int main(int argc, char *const *argv)
 			stop_upon_switch = 1;
 			break;
 
+		case 'm':
+			max_latency_treshold = atoi(optarg);
+			break;
+
 		default:
 			xenomai_usage();
 			exit(2);
-- 
2.40.1

