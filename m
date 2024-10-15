Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED64172BCC
	for <xenomai@lists.linux.dev>; Tue, 15 Oct 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009901; cv=fail; b=mWFCzhD3j4pNB/c67gAM1o5aX6tL819hZsL3R1ByLQ/6Tdz2dXmlpYMMrSGUb2LffAhjSM0g2SHfFJyuo1WDbH+WiCJNs7rBp8qGarLrT1ND5FwgS71/7b+V34AqoDDnuiHrqjiz1hdIZh9az0ezClb4ubptYdKpta+Xd4t0VRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009901; c=relaxed/simple;
	bh=/pzD6M0D4UNHTrQ/dEC1STqWV/LQWLx/K5Q0lKE4UZM=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=mt6D/ZDwUYK6nEyey+CJdeGZNOf19z4g7+UW6Z+VoFGuouPHIELbRQAWEy7JUhM/6PNjK1Td1r6LKiYm+ygYViweSZhXlJr2vdztPF36m56dCe8kWe0+IyQKIKeV3CR3mdLe8BljYPj5pKqJG2/uFp/tUoTesdtyazd6P3BeDJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tkAnOKse; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tkAnOKse"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvwRDLCWdpadq+YsGIGewdn5cq0SM7NQ/58fa8xq0fjflpOUgleUQuGi630GgcgOaliacx+U04tbQIViwn6AV9XRZnbGCdn1EXLfjJV0wMoXumHqvvIHmEFTztd6vZzZSXmdLE3vt/prCWKsnMSFuvY3cKxX7bHB8ceVZRnLmKq4rZ23eYeeHrdX2rk7ABCjK05ED/as418WqV/XqZKfGWX4w/JhHu5/J/da83x+M0sP0tw+9JULBdF7nJ1BY2Z62MZ+qa3sVYM6KxkzCk9riSqWkmVbXwmjPMtu5q3CAQPtfaWhdeU7e/e/OXb2yl+v4t3HfTokNJwJfpBIUzgFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obp/k/gClHsdVcEGNejigN/ewqdR0wJTrLNAm1WqUd8=;
 b=Wqmrj/FgQvrqB/m9TGs/fYIgIRn1Qa/m0SDXY6MtcvqVwfSEUmORI0QIEWoHP+uVIRwxc5ZS/YyKQsHe3geXxQA1bkp/M1W+J1YKncZu92kqlPMvWGyOK+heCROz4e6WMGtNUpzrbuYZb3WtloGfuwd33NPy6/BZK1ZUfsJB6XoEJv4fM7hkAmH32io4kkUNbxgHv371XJwHIyXdSuzHip220TCq2Mr2Er06qIARmKusb0IY13i/DZxINlPgNYk8yD4Byt6qDrlM6BHhCrOsfmRMFLfynx2gualjRIGHkwe2Wy1lw7ozEdqTyopBoOXpIQjQOGJ2d/+OkCWrrDYSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obp/k/gClHsdVcEGNejigN/ewqdR0wJTrLNAm1WqUd8=;
 b=tkAnOKseOdRxzHQRF/FCsydMhWJR53tA69qYuBJnn0lpK1xO4GmCuSK2z/O86JvzwGMGmK+/KNZWloBEDkDzk/2e4F3KlDe3iO6Qiw4djSObclv1NT8ji3UmTyNfBCKvRF2AgAZiyh+nQneto/1lTKuBfwSkMupneOii0ZtvEVIzZRQaAKFP6i2SV7d8K3u26TPlvpbGsk5ILn65LL32JvSPptKEbpvA1r7luez6v50HQLFrEi8KXkeKCke+6VKc1/TXoT2A9KMwPGORVdXVXMT31GUdjlgr6qpj+WfJMkLQQaeWpLgD9oHWLOYPoT6Lj7eTMeNYr8dBIWTn+Oi/rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 16:31:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Tue, 15 Oct 2024
 16:31:31 +0000
Message-ID: <567a962f-82d1-49f3-a30a-04fb784f51b8@siemens.com>
Date: Tue, 15 Oct 2024 18:31:30 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite: alchemytests: Give more time when running in a VM
Content-Language: en-US
Cc: Richard Weinberger <richard@sigma-star.at>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3843:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5f2287-3f60-4a27-2ac5-08dced36d3bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTdLcm54K0E5MGVDano5Z0lpMmtzZlNUaFpHV1E4emhoakNTL0pYSk0rK2JS?=
 =?utf-8?B?ZDB5UzBBcnpKTXFuUW84bTI2TTBYU1hVSTVxQzNqb3lxZHpNWjFCa1NaNW5w?=
 =?utf-8?B?SHYzd0pqZFRQK2NnK2FVV3VsM0ROS3dWeWEzUXBPNFkvZk1MaUNFTzZLRnpw?=
 =?utf-8?B?TzVhU0JRMkVuU3RzL24vT0ExMmVFbWZmMVhKa0xOdm5DWEVSclJveURKN3U0?=
 =?utf-8?B?UCtmNTZvc0kzLzBNVVVhUzNSWmNueU9vSFJMZSs1QkJaMlJ4V2RHd1RXNzdJ?=
 =?utf-8?B?S0ZZT0JoSkMyK1oxUmxNTGlRQTA0NWtqeHdkWitHQWxxTGUrTnU4YkdBVUdv?=
 =?utf-8?B?K05YUXRhMDJiYjRNUlltS09nN0VzMTZsdDNYckhmZFN4L2kxTE51TGliSmdJ?=
 =?utf-8?B?TEdtY0hPUC8zeW82ajB6eGV5Nndzdm04SjduSnhWczZDOVl2NG9KRUltdmFL?=
 =?utf-8?B?b1Z2QlF1ckQ2UCsrMWhXTXVvbVgwK0VMbXdWWVFHT2UvazZCNnIrZTVnZ0wx?=
 =?utf-8?B?MGZJMGhTcUdLb3lxbFVNU2QwY2dJSm9vd1FyTWljeG9yT09ENVJoL1dpVjA1?=
 =?utf-8?B?WTIxTHQ5TWgxd2NyaHFLMWl5K2FzUzlnM3YyenlFUCt4Q0U5ZUNUckZuYU5O?=
 =?utf-8?B?dC9BMGJjdlAyZHlWd2hQdDVWd3ovM0kzMkZ3ZTVxZ2VYWEFvRHdpRlRJdTFl?=
 =?utf-8?B?RWViNTlRRUJZUlNMUUkzV2YwMXpwZHVlTFVVa2gvejZWUlI5enJ6Sm5XcTFC?=
 =?utf-8?B?ZVVZQW1MNFpDU0xVQ2YzVVE0M1NoVXBtaEIwL1BrSXVYRmhrTXlYYWp6VWNo?=
 =?utf-8?B?OTU1S2s0ajFEdmUxT2ViUFFUYnJpSEVUbldPNWM2RFpNMmRWYXJNb2NxQVgr?=
 =?utf-8?B?cmVkcmorM2xhcWNiN3phdlRqZERYQkl1ZVpEVXN0MkM1SVRrRE1LdVdYSC96?=
 =?utf-8?B?SnlUSnJwSFlFYmNoMGdWanI5ZDYrNms3ZmZ5M3MwU0JyL3k2MU4wQytxUmZo?=
 =?utf-8?B?dVJMd1RkdGZHQTQxV1BRN2JpVHlLQlRoalE2c0QyM3ZXMldpUEo2bkppelg2?=
 =?utf-8?B?c2s2RldJWDRVRGpjNHc0WER1Y3FudzVmazhwMW1pcDRFQVNUbzJRU24zZHJk?=
 =?utf-8?B?bm5raTZwTk8yU3E5eGhPRVArSU1LU0RNbnpmdXF1dVFzSHNud0hEWWdNSkhl?=
 =?utf-8?B?Z2pjMFNDMldJZUgyNE55WHJHY0tCOW1BaWVvMVByZVIzbytPdThSTUg0MS9M?=
 =?utf-8?B?d1N4Y003MlYzTFBYSUNuSFJyRWc2VlBqWW9sNDZvcTV3RGlGMUN6Q0Zmblhs?=
 =?utf-8?B?U0dHR0ZHU2ZUVWdkME9RbjNLdmJvU3JQYUNsVUxZaGZtRjRCUGs3RGJXVktl?=
 =?utf-8?B?VHJiU0VkNEVYRTZnbzVzdmsrcWNNTDh3cjU5bVJhbXZaQTZQbWx4c3Y4NHFT?=
 =?utf-8?B?cjl1SjFkZE4vZWkzRVpFY2xMWk4vNmtIYnVzWlE3bzJveStlQTVqREFCVG9q?=
 =?utf-8?B?ZHNPc0VLSW9BMDg4WUtDZWpnZEVEYm1Yd2hKbU5KcGF4SS9samNoMjY0UWor?=
 =?utf-8?B?MFV3SG5PZEZaVU93K21DSHRwTkI0Y1VzeFE0aDZ4dzFjVTBqdGJFSnFPeGJ4?=
 =?utf-8?B?TzVVdVI5QmNuVUc0cndrOGVtaXpvZUw5ZmZkRjlOZ2xUR0sxMlBLRnhWNDhU?=
 =?utf-8?B?VDRtM21vTS9uZkNxK29haDVzMjhzeHJnSDd4bXBxOHVrNisxZGJaazdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJPQlFoS3ZmOE5KbUVyLzl4eTBCaGNPV1lFL2Uwa0hxSGxpTXl2MUgveCt4?=
 =?utf-8?B?aEg3QTZkbHFKaVlOa0JLUS9XbmttUHlnNnI2VjNpeHAzNjQ0N3JjcW85Q01j?=
 =?utf-8?B?MUhRQXB0ZVpYeU1ESFBZd2lreFFYYmkwZ296eWwxWVd3RmtLUW5FSnljbTVv?=
 =?utf-8?B?RGtYNDZhNzFCZ2pJcFhtUWVZTWtIUlNoblZnOXRuRGppenAyc3Q0V0lXOVdC?=
 =?utf-8?B?eHA2NGpmYURJelN5TzdBZ1NPSDZwQWNkRjdVamtCeDVWdSsvZ3kyMjlmeUY4?=
 =?utf-8?B?cU9WclNDZ293WkJVemthZGZYTUlLVVc1UExHdzVSTk13TVY0TytGcGtWZDMx?=
 =?utf-8?B?L1VsREdrWDk1Q2lOMXlyZ0JCL0hUdjYvU2tiSzAwVWdEOFRQYk1aMmdVV0NQ?=
 =?utf-8?B?cGVPbzVMZmxQM05Mc3dJM3UvUXhzSjE2bno2SG1UTjc2eEtkaGdmdGJsbXpZ?=
 =?utf-8?B?UjdMTzZYQUI5UlFabEhCZnBpNTBEN0F2TTluQjI2YzJhalBRRkR1d1hGREFo?=
 =?utf-8?B?cjYyOUU2S2lDLzNVR0R0RnFndXNTMkNNMXFzQ0xjVWdmeXRLWTRLeW9qeHRa?=
 =?utf-8?B?UytlbkJmcDdSbnFYN21NaDVLQkhiU0E0ajZ5SmdhRWo5bTB4NS9CUzNqZ044?=
 =?utf-8?B?enJvMCtOKytnaUhyUFZtQkE4RFN5UHhzRnlWT3BSMzdMRlpSM216R3VPanpS?=
 =?utf-8?B?R3JoZnZhc2kzVjZZMGRRb0hFMThMT3hZTWhJdUp3c0JWR0Y2UHN2a3FZaGxO?=
 =?utf-8?B?aTlWTUU5a24wZUtmR1dhdUNnbVJnNUlXdkJucDFSQ1dtYUdUcTk0aEU5Vmp2?=
 =?utf-8?B?OXJzMG1HSityc2FpclRKTWpudllhbXRGTVVPQURRQ3BKY2c1YXpScTFNQnJo?=
 =?utf-8?B?Q0l0Um91RTdYOHFrL25aNUt3cVB2aWluOGc1VTVjcngyQVErVVloRS8rYmtk?=
 =?utf-8?B?Rm1zbWMwS1VkQnJZOEVKSmRsV1RGanQwaXk5WFBuZDRzblhpNEkzRGI2REU1?=
 =?utf-8?B?WXR1NmtlS2VYWkRnSXhBUlFSRTcrZkgzYldQV2xaS3hVa1A4Nm5leWE1Tm02?=
 =?utf-8?B?dml2ZHhTY2p6VWV4aGJMbHRWTUZFNUlycVBtL2xEVExHZTErSWdsdE5abitM?=
 =?utf-8?B?QW15NzFNZzdWWWZteC9VRlNZOFdnZTcvZ01lTERRanYxZnc2WWNxVDV5TVYx?=
 =?utf-8?B?RWJZcjI3L01jMVNpb2JHSE9OTkxreXp6ZUsydkRSNzJuSFdsZWN1YjV1ZW1R?=
 =?utf-8?B?ZlBaUXU5a05VQnBJTVFtRkJXYnZDcnJyYUtWT2FtS2dNMDZXd3ROcXB5MXRn?=
 =?utf-8?B?dWZXWUNwN2hDYlVpZXhVaDhNc0tSdlQrQWkvK01VVUJCTG1zK1ZBTWFaclhj?=
 =?utf-8?B?RTVVR0RFTzZGVmJLakpMbkV4TTB3dzZ6bWxWQ1cxOHpieTJnbDBBSUFpNVlL?=
 =?utf-8?B?WEJFMzR1c2ZsM2xhb3l3QUFlV3pDblQrQjhQaGdZUW8wZDdLZUE0cU5ZWTR6?=
 =?utf-8?B?Uk1Ea0V4eEE1R09ZS01ZZ0xYSjN2K0E0ZDFmQ3kxSmZKTHU4dkVsQklUbDc1?=
 =?utf-8?B?aFlwRm1Fc0xnTDcwZ2RpKzJWMGw1MnROYjJJeklwWUZwSXE4TWNMRFlWdzFv?=
 =?utf-8?B?ZTRCYmtma25PdmFtN1NpMkFxVXhyZmdTSkx5emFvTi9aNG9KaU9mTmVzcGpv?=
 =?utf-8?B?OFRkcFdkSnJURElqazNiM0hSdW42THl6QmEwSTl2aThUVnZtZFR3OVV1NDJN?=
 =?utf-8?B?VjYrRWtiZmVOVkVxQUhWclh0WURMRkpHY0liVTZVdE9RNlcwRm1sMHhUN25x?=
 =?utf-8?B?U29QUEpMNE9DNm1xUkRHTzFjWTM2TnE4Ui95YTFRQlF5MFdvc3hvaUkzelZE?=
 =?utf-8?B?ZmljWjZlMEIzMTN4eG9HZ3IxYXhNNDE4WEszSjVUMGpkRmFOVGlqL2xsYXRK?=
 =?utf-8?B?STdMRHB5ZWtWRUpobkppQk9yODJqUmVDNzg5TWhWWmRXQzNUY2s4TnBSOVd3?=
 =?utf-8?B?QTJjV2dvU1EyWFhNeWhRMXZBQXRjWVA1Q203VXVEQUoyUWR1UFpsazBPdGZj?=
 =?utf-8?B?S3ZZblAyQjZRTFJsWjZLWnJDL3FjV1hUN0hkWHRNaS82ejJod0x2aG5HLzBx?=
 =?utf-8?Q?mXAK0VqrHzKiIWjA0ckK06Atq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5f2287-3f60-4a27-2ac5-08dced36d3bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:31:31.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPa1Tafy75Y8cgp+1kl70DljWSEw4BMAYhVbVizlDoarsRBfUbJs93Gp5Sjs1YudpOg/iQ2kHz4t8umAf8pViw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3843

From: Jan Kiszka <jan.kiszka@siemens.com>

This should make sporadic CI failures due to overloaded hosts less
likely: wait 100 ms before deleting the heap so that the background_task
really had enough time to block in its final rt_heap_alloc.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/heap-1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/heap-1.c b/testsuite/smokey/alchemytests/heap-1.c
index f0904439f7..5b0ff78ca8 100644
--- a/testsuite/smokey/alchemytests/heap-1.c
+++ b/testsuite/smokey/alchemytests/heap-1.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
@@ -15,6 +16,8 @@ static struct traceobj trobj;
 
 static RT_TASK t_bgnd, t_fgnd;
 
+static bool on_vm;
+
 static void background_task(void *arg)
 {
 	void *p1, *p2;
@@ -76,7 +79,7 @@ static void foreground_task(void *arg)
 	ret = rt_heap_free(&heap, p2);
 	traceobj_check(&trobj, ret, 0);
 
-	rt_task_sleep(1000000ULL);
+	rt_task_sleep(on_vm ? 100000000ULL : 1000000ULL);
 
 	ret = rt_heap_delete(&heap);
 	traceobj_check(&trobj, ret, 0);
@@ -89,6 +92,8 @@ int main(int argc, char *const argv[])
 	RT_HEAP heap;
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = rt_task_create(&t_fgnd, "FGND", 0,  21, 0);
-- 
2.43.0
