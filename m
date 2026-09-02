Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E43EDADC
	for <xenomai@lists.linux.dev>; Wed,  2 Sep 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387261; cv=fail; b=HAvZII7hx+Fz8AaQ13mrKdjSIPX4Ki5sVZe6jDEiqnK7+gk1EZb1N3BOpP85lID8wh5JpYMqNTyttfaNZeGvgyKkTafui/AR+sH5/AlYKBsdAwx8s/YNOz+NSlijKNFmE7b49jlsxRVzZMzYB+UFbFunPEyWAs49kdro5oGgsws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387261; c=relaxed/simple;
	bh=cMUS2jfZja3cu9QHuDE4os5vdLJKUVUjREWKlcEyOYI=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Z3OUiWMRSEXkLeOn1vxnQsSg3tCcIYfjHLsFykKivO9xQWtrrGUeEjIcsCbHkXOJNsIQWS5rjdUhNj9aV5yLRnzo3euaqXLsC8+fCCFZ3YVyogJnoUF5B/x6aN5YZzKQK4G4+JoHkkzjxL9QaGCCNzrxHldsMPb2qWXC2Qt8D0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KSfYDRqL; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KSfYDRqL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/KbKOcG+rMEhldBqmInzKcOV88WGr9bqx1kVk/FasCsHzB2LiaoTP/7CtQq080kXBCGhIdjKZCS4NCNy98F1eGx+FABw69VS3mJq0Y00rT4mgToeGMpSDIOxpM2hxrAa7vQ4+obEfrNWn136YtxMElfc0Ip2QDcq+JwxdHIlKHnNKSi0Kb1Xf8jzRJiUp/6aZ25upIvltDU4gIo1wz0ksVJlu0UESMCovQh7N3eSwjao0JOjRcbrJfv3kPKGFXfOarUDwoDYQY8k7vDlXx+pmj9scqyeSyYIVn7dAkgKSiP3jb0xYLbS81arEN9rAh/y8nyMbKivYf7qeF6JH2gCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnBqemVjaMQ4vRAiT7M2sSKsk0LbYHVVPK5oa2dgPUk=;
 b=w6xvzXTVyZWv29rPizCWYOMoChwPtgWGUqWwafBGdMCkQmE62NkW+T9aTs2QkE9UrRtZZxovpsrDmvUKE5slPyS9E1nK5zlOkhPWte5ABTChNb1Wr2Uirzs4MlSZVEIkkOhL8+KCeVXO5kogfsakr/YarMd5HBLlfoQ7rWUoWpBe0lEVMQNHpYRRZ9Slyj96OF9YmdSwGBZuws2bSTJQ/iQFGnrTT1lpCtV0gRB7hNyWMqV+8uj0415iyp/NibOV31fSnOm4IWa03noInmYMyWGt/YgM9cSy7temnfLH7XJqhRBogSPDuoBRaU9CoMUTPYFbAmnyz/TIXJ+lqJp0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnBqemVjaMQ4vRAiT7M2sSKsk0LbYHVVPK5oa2dgPUk=;
 b=KSfYDRqLend51jhZ/0ckDG1KmQca7gBj5vjpcJ0qcaC3F8eg5WAHE+hmUbgYTZB7oLCj7NjMmPg+fReZfcJd2Wkl36ZRMkEug06lz9D+Pbs1SZ7O2+VH1vV7uOOwmbnrZTfmbqzu1Z+ZENHuI1h3VoKFGuVOrZEC7DOmS4OqUu5ZzcvQoJ1eAtJj2FVZn1+AGqt76TZoX3673I/5cjB8Z6Bl+Xz7qsl/pGrEPwrhMCUDzT/LqggcCq38ioxTSc6mZKhZeBNZJKDw1zBHf0jjH0tdo+eKb1Rg7MMDCkuJK0rlncBb606aP4PsOwUxU+jE6uA0S5wUlQ+vz6KBgQEX2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 22:14:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 22:14:09 +0000
Message-ID: <1c6d14b9-8915-4f0e-95ae-989b3be7f412@siemens.com>
Date: Thu, 3 Sep 2026 00:14:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite: smokey: Raise some delays in skin tests when
 running in VM
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ce49ea-202e-48e9-6eb3-08df093f82ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	QfjQ22vs/Qxxdn2IRwiU/VbVa49pz+j0e/HYfVd+Vk70t9+LWiNZtv6gJWqQ593RIQiq4oSm6Zc8sQluZ4wr7CLYuBkorU1GuxgFi1z9w1n/NMqkEHTF5o31NA3i5l71WvG/xQb/p7EA4tItPLZgvBJKa/PPQUB26C7ySdsQSe5ocoXtl/kQmqlmeObXi58BPvt1NJ4ErnGrZesVgJPa90sEhqjJxYC0AFj8Wrs5SxPaHQgKKZ8lTOSjL9hGv2HP43FJyGT9KM/kFEXkcrYrxxntPapDdQNcNuaYvznufwO+84AxcxAENFCzWxOqUYFzGgSpgeXzsaeiNp/T+N8h2hGmVC6TcC2uKFDgBT3nYZN3+u0+rX2mo6odceeiELazUncBOWJ6t2FIEOVvzC2Iwb8Y1zwF6yTLiP4uwDf5r2qJ2/Hc1NoeeeF3z6CWI3mLWlYvSzdUvZTa4a8vrqw1YrETEc9+dIN6KZHOaMXjITas7LavcDrnC64awOUr92LA1gHl8M7PgD0KhtBWmmXtFoNOdX5pgtvbxnFW2i5BLtTH6TV9xbJy5y2pB7slX+gJvhK+yc51pB3xbf5tmDhf5Y8+kGMiQyoWlc6AbBKjqwBHajZEwrnqOSnDUr52utYA2HXC3xaHRhmsWPHin+wEZfFXCrW/G6YOlZQO5NJ5pd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzF6S29JMW51WWFxS0ZXN3B2SHc3ZnlRcGlNbjV0RUlNRTBTa2podHMvVk00?=
 =?utf-8?B?TGNSQzBXZEh1cDMvN01qbklNNHdzVUpqM0VURCtCem1XYjZLbXRmNGllQXF3?=
 =?utf-8?B?UlgzL2FsVVFLVDlNMEtWQzRHTmJ6TmxSNHl4RmJKS3VFMHUrQlZnSFpIa3FD?=
 =?utf-8?B?bVJVUHFYZjRIUWJDWUhNVWN4SlRpL1ZGcnpjSkJUNWN3bDJONWVjSll3ci9t?=
 =?utf-8?B?VDVPbWJUOVkvZ09lSXkwblR6TTFsVW03dnBBUXA5ZzZabkhoUkVtdlBIV1Ri?=
 =?utf-8?B?alAvdUhxRzlPd3d3QlJtMExMUml0T0llK0YvNlByYkN6S0NyM2xWVlpwTlV5?=
 =?utf-8?B?dUhDb3E0RHVzcmUvNEdqODNrYzZqaFJzWW1qMEV4UGRuNFVIRVhvRGlaWWMw?=
 =?utf-8?B?b1JkZ01PWUR5VTNuYWJXT2VheWdqcjFXbjJod3J6VncweGZnRllBYnlKZUxw?=
 =?utf-8?B?Q1U5Mnp5eXFrcmU2VndoYjlIVnhQQ21XcVhNN3hRblJmUDlQTG9CeEtlWCtj?=
 =?utf-8?B?a1dzOEZUQ3hFdWo4MFc3U2h5VFQzVWR3bngwcU9wdXVTZVBSY2wyQW1NLzNW?=
 =?utf-8?B?QTYvelZNS1R4RmM5d2hFeDZ1Uk5xZjdkT1BaS1FVVjhkUDJUcHE3aEJzaWND?=
 =?utf-8?B?RHI3OVBMeG1zSWZMOUp4VDY2NFFleGZBeWZwQlV3SEtDeG1EUWFMa29EVUli?=
 =?utf-8?B?bnVzVWRRdEFHTWFxaXZFVUVwTURjb002OGd6WS91b1pGTk1reEl0eHlOTWdW?=
 =?utf-8?B?cXVKRjdOanVpemJpekY2eGVQcytvSTQvUENLR0drSExFVW0wc1FyTzJpN1Bn?=
 =?utf-8?B?UTBvc0g4S0NHZFVnN2F0Vys4UUovUElwejNUdzNwOHVzTGIrTUpuMlhQZTJi?=
 =?utf-8?B?S3AzRGtFWW9HMHhNblRzSGJSeTFvdSttWkx3V0N3OE9MaVJmR2tEWGRaYkVK?=
 =?utf-8?B?UWdLY1JvSEZKSGthY24xL1d2Z0ZVbHBraVhaS1h1WU1DcTRJZW9HUlZMNGdE?=
 =?utf-8?B?UDZlVVpDMDZic0Q3YUk0ek1hRW4vek9ycTFRdDNpYjRPdG5nUUZsWEFreU1F?=
 =?utf-8?B?T1B3elNJOGZzSnZpUkZGUmwvYm9ienZsTU04THR2TjVqSmdCeGo1b0ZENzlF?=
 =?utf-8?B?ZGZxUzFFVXNGTWFEQmpTYnZhNXZZZUx1Nm9sd1BjNXFOSEc1RllxVkpPSmZu?=
 =?utf-8?B?OUhZQkJRbjlNTkZmZys2bkpGYjN6MzVpSHBjcXJ1VkJlUlUyRG9IUmRUTElx?=
 =?utf-8?B?RndVMy9jK2ZIZ2NIVTVQUzhoY0NtVks5eWdJbFFGcHhxQXRvR2oyWlVGT2FG?=
 =?utf-8?B?UTVPTVBFczR1T1JaRUhNTDFkbnJHc0tzVThUN0JCNVV0dnV2V3hpZGQyYXd0?=
 =?utf-8?B?empDVkJPc21ZQmlNUk1VWUtjemliRlBMWVJjVWRWRmFUTUZzcHlzQ2R6b2oy?=
 =?utf-8?B?RytPdGc0dnpwdzNDVXNFdDgxQWN1SllRUDVzYnNUNHBkN08vM0ZLcGNjazJq?=
 =?utf-8?B?TWUxak5mMkNFeFBWNG02L0VmaGZlbnJpM0N3eUN2YWRranp3c3MyMnd6bXNI?=
 =?utf-8?B?bUo5NlJ4SVh3ZlF5VGU0NEY0WVdrcTk3N0tQY3RkcU5ORWdjK1p6YXdJR3Rw?=
 =?utf-8?B?dlZ3aDlWZXlNT2JRWmFPTzNxdnhIdGMzWWJjYUI5N3dscGQ5YkpmcFNlN1Jv?=
 =?utf-8?B?ZStzOFJDdlRpVW15a0VFTTh2ZkJpY1lMeTg3MzZpSWNTTXNlMmdKMW9MWTA3?=
 =?utf-8?B?b0Z4cGlNd3N5Q215aHk1cFNPR3VUeTdIOCtJY3ZxbzRIbzcvT0ZJYXJZRUF3?=
 =?utf-8?B?bHBVVXRjRUVtaUxsVDFNVVlMSUhPOUoweG9la2lBWEZudCtRS3djVFRIaERO?=
 =?utf-8?B?UWdCVDRUWXh3MnFsVXIwYVFtUThZeW40Z3BEWHVWdjNqSHYyVnh5bEVVNDZB?=
 =?utf-8?B?cm5nZHg4aVVkV3ovUjF5RTRtaFJJR01WTUdaUVlWSld2b05JQ1N5VlFBSloy?=
 =?utf-8?B?dUVOMW9EbVNoRW9wTDFaYU1UQWJHUjltZjd2L2x2YVl5SzBMSWJNdEhmVFB6?=
 =?utf-8?B?R283SGZPNFBZa0NNOTl0UEFqalhESTdzVGdtMDNYL3RIcHh5NllTMjh4QUxj?=
 =?utf-8?B?MThFVkxia0dadnV0bVZZNFowVDRyMTNlNFBUZkxBeFdpSDhVK21xSDhWcU9u?=
 =?utf-8?B?dWZLUllmenU5WFZsYXBET1IyZFBvYWVkc05LdlVOdlVXOC81R24veDVjSFl0?=
 =?utf-8?B?TDNNU2F1VVhxbmVBZitnUGhnTlZ3eWQzS2V0WmFBT284enJjNXR3cmZMRVkw?=
 =?utf-8?B?MnNpdHFuZjBBL0RpcGRPTncrLzhaclY0OTRuOTVqZnRUclV0dGg4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ce49ea-202e-48e9-6eb3-08df093f82ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 22:14:09.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPG2Jgr8yC9O3oHykrlXXitZ+P17yWfeztncaJdR+4yhXgKVKD5W5niKBOEEN8NigJllrC1zHt4CJ68pAOoPHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9071

From: Jan Kiszka <jan.kiszka@siemens.com>

Those are too easily getting out of sync on slow qemu machines, e.g.

2026-09-01T18:12:20  <missing mark> |  [7] expected
2026-09-01T18:12:20    0"082.975| WARNING: [psostests_task2] mismatching execution sequence detected
2026-09-01T18:12:20 at task-2.c:73  |  [8] should be [8]
2026-09-01T18:12:20 at task-2.c:24  |  [1] should be [1]
2026-09-01T18:12:20 at task-2.c:81  |  [9] should be [9]
2026-09-01T18:12:20 at task-2.c:44  |  [4] should be [4]
2026-09-01T18:12:20 at task-2.c:89  |  [10] should be [10]
2026-09-01T18:12:20 at task-2.c:49  |  [5] should be [5]
2026-09-01T18:12:20 at task-2.c:53  |  [6] should be [11]
2026-09-01T18:12:20 at task-2.c:58  |  [7] should be [2]
2026-09-01T18:12:20 at task-2.c:94  |  [11] should be [6]
2026-09-01T18:12:20    0"093.148| WARNING: [psostests_task2] NOTE: --disable-async-cancel option was given - this might explain?
2026-09-01T18:12:20 test psostests_task2 failed: 1280

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/task-2.c | 6 +++++-
 testsuite/smokey/psostests/task-2.c    | 8 ++++++--
 testsuite/smokey/psostests/task-5.c    | 8 +++++++-
 testsuite/smokey/vxworkstests/task-2.c | 6 +++++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index ca2225ad70..d0180bfac1 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -7,6 +7,8 @@
 
 static struct traceobj trobj;
 
+static bool on_vm;
+
 static int tseq[] = {
 	8, 1, 9, 4, 10, 5, 11, 2, 6, 7
 };
@@ -49,7 +51,7 @@ static void foreground_task(void *arg)
 
 	traceobj_mark(&trobj, 5);
 
-	rt_task_sleep(20000000ULL);
+	rt_task_sleep(on_vm ? 200000000ULL : 20000000ULL);
 
 	traceobj_mark(&trobj, 6);
 
@@ -65,6 +67,8 @@ int main(int argc, char *const argv[])
 {
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = rt_sem_create(&sem, "SEMA", 0, S_PRIO);
diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
index 21497433f1..af0c0ff988 100644
--- a/testsuite/smokey/psostests/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -7,6 +7,8 @@
 
 static struct traceobj trobj;
 
+static bool on_vm;
+
 static int tseq[] = {
 	8, 1, 9, 4, 10, 5, 11, 2, 6, 7
 };
@@ -28,7 +30,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 
 	traceobj_mark(&trobj, 2);
 
-	threadobj_spin(2000000);
+	threadobj_spin(300000000);
 
 	traceobj_mark(&trobj, 3);
 
@@ -48,7 +50,7 @@ static void foregroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 
 	traceobj_mark(&trobj, 5);
 
-	tm_wkafter(2);
+	tm_wkafter(on_vm ? 200 : 2);
 
 	traceobj_mark(&trobj, 6);
 
@@ -65,6 +67,8 @@ int main(int argc, char *const argv[])
 	u_long args[] = { 1, 2, 3, 4 };
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = sm_create("SEMA", 0, SM_PRIOR, &sem_id);
diff --git a/testsuite/smokey/psostests/task-5.c b/testsuite/smokey/psostests/task-5.c
index dcb8ec6eaa..c9f4a0b094 100644
--- a/testsuite/smokey/psostests/task-5.c
+++ b/testsuite/smokey/psostests/task-5.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <copperplate/traceobj.h>
 #include <psos/psos.h>
 
 static struct traceobj trobj;
 
+static bool on_vm;
+
 static int tseq[] = {
 	8, 1, 9, 4, 10, 2, 11, 12, 3, 5, 13
 };
@@ -30,7 +34,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
 	ret = t_suspend(ftid);
 	traceobj_assert(&trobj, ret == SUCCESS);
 
-	tm_wkafter(2);
+	tm_wkafter(on_vm ? 200 : 2);
 
 	traceobj_mark(&trobj, 3);
 
@@ -63,6 +67,8 @@ int main(int argc, char *const argv[])
 	u_long args[] = { 1, 2, 3, 4 };
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = sm_create("SEMA", 0, SM_FIFO, &sem_id);
diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index d701394dda..bf26131432 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -14,6 +14,8 @@ static inline void safe_pause(void)
 
 static struct traceobj trobj;
 
+static bool on_vm;
+
 static int tseq[] = {
 	8, 1, 9, 4, 10, 5, 11, 2, 6, 7,	12
 };
@@ -59,7 +61,7 @@ static void foregroundTask(long arg, ...)
 
 	traceobj_mark(&trobj, 5);
 
-	taskDelay(3);
+	taskDelay(on_vm ? 300 : 3);
 
 	traceobj_mark(&trobj, 6);
 
@@ -78,6 +80,8 @@ int main(int argc, char *const argv[])
 {
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	sem_id = semCCreate(SEM_Q_PRIORITY, 0);
-- 
2.47.3
