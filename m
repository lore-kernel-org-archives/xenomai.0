Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2143C3C07
	for <xenomai@lists.linux.dev>; Mon, 31 Aug 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188202; cv=fail; b=N+qFcbIMVyb1KfBwQ6tuxGZu4GkVfD/bNkbHVAwP59Hglrgz189jbU4OzxeTgMFP5lK8/5N6ropEHSOZ/JOA6O6A0eKqnm5O8MVI19gMYkU0f9ByUCqqjXqYUSiXM7UvKf2kmKYDHvsFKyyvhghtgZtvghQ5QcBzq8MONeMBhvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188202; c=relaxed/simple;
	bh=c/CGdOLEmmV529d8fW0xja4QVneVCxDqb4tGV0PZgiE=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=guJ4aTLZFNkvHiaw3K7o37o436F3sCTpUMzw81OrWY6zOaXuVSuc5X+asHx2aQtQLefVnyTUw8uL4zMqLxF6/1D8j3pVJ/Mdf80CQAoBhym7rukaj8hevHxv9u+SArcM03SsrfU/1PxCDsBTfei2igepxtgSs2aQNEAja0m0358=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OWUpCelO; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OWUpCelO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcbMr0A5ilLr36yCHexCy9lclew4ISyLVo8Bi8PHGzVZOBbowLoxesSkcEPoa8jWyi4KdfDXkGZeEzKqprqAY/5+eNjw/8yT+rzxC+yMEG9Shv610xX9hUdAu/oqyqZva3flZX5g0Be13WC7wSRvuebVQcxboSOPQcjPwofQYClwlwraBDq66Cvrozs/MPnY6cHDgUEWbbej7KuLAxSWpNpmacv9XQc7qnG4qL1oDAddCj/m10vIEyx8i7V5RhgFIvAHR87zXPrVrO4YUZMui/bUNfQnHkO37OaSgzox2CbipcNRvJ/yqPxcZ+X0lkfizhzHsnJZXgI4d/0uNFiICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW/VG/jFyPsVK/XXcKghU/ThVyYm6mKhz/iz9Kg3WdQ=;
 b=Hw8kWh5Fxy3wCJtD16H0XaUfEAfo3ilHEINw4McWj3xvLuTzHvDLd/yscCvPD9br4NGtzI+1rUglAwypODccBsz30kKGnzNI487ruHgSDUVS0pQVrKiv12eIPxUo4aHdvth9GDKaoT18bOrZxNHd/usYVqBpHJ2KTgvkwEpeVKlwg8rnDy8Y3/lqbaOPR8mfoEhNScWeShyn54ViQkt4ep3lTl4+Nv+YbYnS06Q28cIO7jHyLMsXmspjXuBogpUndJ/7XOGDYy6J2yx/vBd8VsTXG8ZHhIrFyE58lmlu1WBv864nRaoCcNvpz8c+pTbgm4HtejUaFzBkxx11Ejovqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW/VG/jFyPsVK/XXcKghU/ThVyYm6mKhz/iz9Kg3WdQ=;
 b=OWUpCelON7hjzMEIdvN100rwNt64bVMo8AGolwDG3zhOL3KZlwymmzgB1OywKu1bYkPbpw/MFvWA07GyzGHYHRYN+77xsB6Hg6uWLje70ZLf+l93dxc3yXe0G7eIvzsIeJzlhTVBPTgW7dYxyCm/7ZKlzh5nYQQLDCDUT/E3e+x8AAHfJKSEnZeDCKSdTgOYHebsVtXHJG0kglseOJmXYsiAV5XIKtg9ZDmVR+8Y4x67r1NKBmu5ezcoqZh18/jOYYMcmhmmYPVjXc4g7MZ+BnllAdYPS3O5ecD0pOk5U8uaL+t0uLSZ2L+9i8giieFHEq6Y4S2vchlsbDu1Uv+MMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6447.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:56:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:56:36 +0000
Message-ID: <b78962e2-2109-49c8-9c88-8acb4b282f67@siemens.com>
Date: Mon, 31 Aug 2026 16:56:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [libevl][PATCH] tests: sched-quota: Perform calibration without quota
 again
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 467be0de-0e03-44a1-93e3-08df07700e3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	9YMkGeqjpHzwI3+NnrZ5grUdd3EXft2L4gVEvkLWQSfjveea4lEhA1vLBVgriGu5FL5T6rBSBGZqL04LxDSHjem78dtdZN7qcQS7J0E0K3OP3JQgQXzx1kRu8y73rMTyynTRiZJZjrRO6mvVOTRvY32C/G+BWgksUvFsKOv27h7mTg8ENF2ISGZ7Z7Jscfo0RJeSqDh/XlIsNfP5SMiiSNzsTClVg2D8vCCngqEpEgg+erKZUZ9RC/pRBQo/avzOF0ieIMkmPR6eSSah4EBu2tkkCW3WT5wCJJKSDO1u40jLKAlLrlAC9GN9OrMJw7CJE5TruqE/WM7FrgjyQmUs/U66vR4yXHhmD7OpfyaxxSWm/IyyPI6fbVjEoQrbFNLrmsKkMRxqZjzu0DcaNRIJUXVMTX6ji0u5otKIVuh05b7Ft5tRXpwp1YdxDsqt6d0JYvzwnfiMW/+yR8woKFwLzn9lWPOwL+TlX1PTKJsmDfkk9Z6p705rGtf6UQLLZH8V8T/g0DLxqw2it/FtsEsVVNTpsgJ+5NSHGT3sgEGPVDON3D1Jsrf4bxyaPcLxOM9TDEOQHq0fKggb1GSvs7fOFu3q4KtGn82NT0dHG1fiigMqYLs8v/E0mYEJbGSkdvSULiDZyGMPDkaZWM+yqQ76rXJ+qNCBzLjBS5hqHqwOiew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3RLM0ZXc2NaTWVQK0ExY1Z2VlhDdGFQWms4WmlkTzNNOUN4VEJ0VGxESXlK?=
 =?utf-8?B?dmVmMFVLLzhWZ0xkeUNrMkEyMzY5YzgrcDhUSWpXVlhYZUNQL25BMXBxbkNw?=
 =?utf-8?B?dDN2WjNYUm45dm1GbklEMkZXL3VWVkp0SzVmN0tDbUdVdHhvVGZHZGh1aWFl?=
 =?utf-8?B?VnNicFBZS1lSTExTSG81WmpreUdQbjdBNU1YVkNWcS95RTVMZC9KelA0YmZY?=
 =?utf-8?B?cWlXY1g3OElKRUJGTnloblFtSDJLTkg0SDdSWnROb2dVa3h3VGhXRCtBT0tY?=
 =?utf-8?B?R2VDMUVXbTNJYnpDcnduTGRrS1NneExMdEZUL0pYYk43SHVPQk45ajdCVjI4?=
 =?utf-8?B?bHdsck5OeWN3SHpIdWFXRkdCQndjMGV0LzNnTGlYT1BnQzZGRlpYVWFSanIz?=
 =?utf-8?B?aWVSakpoUnVnWmRjaVFwd2hIR1pMMzk4d2NWenlIWlBPaUZacWpVZWpoK05Z?=
 =?utf-8?B?Q0ZxNFpQMGpJSzhDYnE2Q0FSZFJ1SEVZdm56akNpVGQzYzBhN0w4b1JGWkFn?=
 =?utf-8?B?V25qZlo3VFBFMW9VMlBRcG1sOGhVb2dua1IybDVrV0NUL3Zjd3VzMG91N2N2?=
 =?utf-8?B?K0I2cHVTS2tpWk5RU1R6TDhnTU82Sk5panRoNkFWakNicjF5dW1KSmFqdkRm?=
 =?utf-8?B?eXU1UXRJK0tIbEdneFFYeFZHYUJYZG83NHNORnFQR1ZuV3g4U29XYXhPNEk2?=
 =?utf-8?B?eG1WMm9ReTJLeS85QUFabHM2T3ltZkNlNXJrenN0TUl0Q1dDTHdTQWQvdG5k?=
 =?utf-8?B?RWw5OXRjeURSWmQ0S21tcWFHMnJmWDVWbUJUOHNKTnp1N3hqSDczQWVNaDVv?=
 =?utf-8?B?T0FsSXpPdUtiNllLY0oxWFZMeFp3T0IrWGVyQUF5MlBTV2lMOUtQdGZKUC9i?=
 =?utf-8?B?U3FmU01yTGs0STlBVnM4QkZRTk5NWWoyaGJzWGJDZ3pCVEcyaG04TGU3WUZX?=
 =?utf-8?B?TStJdXpQeElmdTFhQXNSMGJscWFXYnpuZzFtbHIvOExQM01EYXF0UXFlRjlT?=
 =?utf-8?B?Q3VBaDNpbDFtd1FaU0R3ejVZZTY4aE42MFNMTUZmRDRFZkZySDBLMFU2Qisv?=
 =?utf-8?B?blVUTzN4WHRJM2xHdUtWVk05aEZheTJlRmtBdVQ5WGI0K3Y1NmhOSktsTW1m?=
 =?utf-8?B?M0RhMXJ3SFJBSGNTa1RQRjVqQXdSZlFGWkRjS210NHdIbmtkeFlXTnBVOTlT?=
 =?utf-8?B?RUZpZFJjbEZSTk5QaGNvblJwaDNnVldIVEN2c2ZlRGlOTmtXQTY2WW9Oc1k4?=
 =?utf-8?B?MW1lYkU1SzUvK0wzZEtBYnBxQ0Mzd1dqd2RtSkhWUkdmNThSd1pOb0F0dXdt?=
 =?utf-8?B?elB1MjVRV2htTFgzOGtVZTdnVStMSDJzVVdtTHR2UURqNjlYa0doTENxYTd1?=
 =?utf-8?B?KzB5ZW1TU2c4UzZIekN4LzkxTk8yN0YyTUE0cjNUOUJzRkRuUDlPd2ZmR3Bw?=
 =?utf-8?B?aURxWmtTanJYY0ZKU0cvZnRjM0R5eURQYlRnakJhUVdMMnBWck1UT1JQNWZG?=
 =?utf-8?B?ZmoxZ1Mxa2lQMzVnd0QxdWMrZTFEbk5sLzlTb3lIZUdmWG9BTkp3SXZ4REVJ?=
 =?utf-8?B?NDVRVmRSUGJISVpqd210OE1EeGZnengvWlh3bU9scDhlYTdNQlFWNVF4OElP?=
 =?utf-8?B?OGc0SnRsbU44RGNaS2QzM0NrQzBiQTFwZWNDd0xneVJwMTFXVEczdzcrcmU4?=
 =?utf-8?B?ZUowZmxWd0I4eURnTVJxQU40bUJwS1g2SjJBcE05dzRVUHB2SEdDRkZJOXRO?=
 =?utf-8?B?SFVFY2lVQ0xLbVhSdkxoeDJKYklrTWJDRVRteEhZVzV6QXJRUkxsa1h3dysx?=
 =?utf-8?B?RWZXNGtRcC93K2UzM0tBY2J0U1M1czlRY2c0UEpuTUpVT1JzcjdpQmlhYXdM?=
 =?utf-8?B?VU1HRVB6SHAydkM1NWNTZ00veEd4c09VcS93Wm9Ndkw2L3dLOVRPYkdaQ2lK?=
 =?utf-8?B?bW5uN3R4V0FTVVpDOGIyUzBiTmJoZ3B1N0xiWGtUSmJlVFJMWGR6SVY4K0l2?=
 =?utf-8?B?a0ZGcTFBdkh0MksyVXZacmwxU1Y3MXBvUUQ5bWx2a2U1ZEVTUTl0aERjRGU1?=
 =?utf-8?B?VllFcWtSUzg1SzQvQnoyQ1hEL1Z4bWJKOU5Zc0I4aHdKbnZFNVlqdzVHTEZh?=
 =?utf-8?B?UDJMWGlNSXV3U1ROT1pmZ2ZBOWRjTVNWT2xFZXMzbFY4YnVBenVxZVRqUjNr?=
 =?utf-8?B?aHlwazhmQWZSa3NqUXl3bGR3RjlkcFh2Rmo0YTd4RVExTWtxbmhYeEU0bDZ6?=
 =?utf-8?B?cUsyTElsak56VU8rZ1BMaU5kS2puLy8zKyt1ZHhCM25jbGlzR3Myem1wWXo3?=
 =?utf-8?B?MEl5NUIxWUdSNWhpVm9jVnFYV1c2RUZuVkhMNnMyMUdWR2d5V2ZwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467be0de-0e03-44a1-93e3-08df07700e3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:56:36.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8MiQ5eRkSd/pe9SwgOddV32IaDTSjRu7TaGTVFzHr8ExV33bjAamq5G8zAdz1jlQZNnXam9IVGvkTum5sB2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6447

From: Jan Kiszka <jan.kiszka@siemens.com>

It defeats the purpose of the test when we calibrate under quota as we
can no longer compare the actual cap against the configured value.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/sched-quota-accuracy.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
index 1bf5eb9..ac04449 100644
--- a/tests/sched-quota-accuracy.c
+++ b/tests/sched-quota-accuracy.c
@@ -171,15 +171,15 @@ static void *quota_thread(void *arg)
 	__Tcall_assert(t->efd, evl_attach_self("quota-runner:%d.%d",
 						getpid(), serial));
 
+	wait_phase(calibration_phase);
+
+	do_work(t, PERIOD_NS * NR_PERIODS);
+
 	attrs.sched_policy = SCHED_QUOTA;
 	attrs.sched_priority = QUOTA_PRIO;
 	attrs.sched_quota_group = tgid;
 	__Tcall_assert(ret, evl_set_schedattr(t->efd, &attrs));
 
-	wait_phase(calibration_phase);
-
-	do_work(t, PERIOD_NS * NR_PERIODS);
-
 	wait_phase(accuracy_measurement_phase);
 
 	do_work(t, PERIOD_NS * NR_PERIODS);
@@ -338,7 +338,8 @@ static struct accuracy_results run_quota(void)
 	 * expressed as a percentage. The closest to the QUOTA_PERCENT
 	 * target, the better.
 	 */
-	results.accuracy = ((double)loops_at_accuracy * 100.0) / (double)loops_at_calibration;
+	results.accuracy = 100.0 *
+		((double)loops_at_accuracy * 100.0 / QUOTA_PERCENT) / (double)loops_at_calibration;
 
 	/*
 	 * Level of noise observed for the disrupted run compared to
@@ -346,7 +347,8 @@ static struct accuracy_results run_quota(void)
 	 * run was faster than the calibration one, which would still
 	 * be correct.
 	 */
-	results.noise = 100.0 - (((double)loops_with_disruption * 100.0) / (double)loops_at_calibration);
+	results.noise = 100.0 - (100.0 *
+		((double)loops_with_disruption * 100.0 / QUOTA_PERCENT) / (double)loops_at_calibration);
 
 	__Tcall_assert(ret, cleanup_group());
 
-- 
2.47.3
