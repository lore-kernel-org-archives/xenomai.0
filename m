Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7225B5AB
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895992; cv=fail; b=awjdk1+33aG0moFirciKgt3F2f06SiFuxw5A8XOQ0novj9bF/O5qF0cKDHaBA9WUK/fYucNltfEmiJ+UhAFBbyAFTHGs0Vp768yo3U9PeEVUTdGJ/HiDesKS27wCHm/PMufM0z3h0Bk0KWdAlnrRuEqv225RzqBVRP8Wx1hDojo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895992; c=relaxed/simple;
	bh=azk4f+xO8ms2lBWFHmJocqasZy5j919tHigE40so75E=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=om0+tOlWEM/ul3C09qUsukdbGPlIbUfoK47IZctVmDvBnPIARtJKwRdvXlosMk5xZCNIKoHYjLu8MDK/GDsxOFnkS5vUOeog+pI8WixodgTaN/GRypMlY/bMOjN3WgEi/ggA8BTdcP60Q7m4685UDdddoABf2vzRTl5BWWKtbyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rfB9c+Yt; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rfB9c+Yt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBTeD0RYdJ3AxS5UDdcNZyxf00oJ0if8EUmRIWfH1FRXbL+iYXMq1N0QtZQRq6H2DOvBrAxkn5D2tSwEo8KDybzalrC+yUekUi/wmmy7YazcMzaZ+Nwh+EgRmI667/3M9Dam0THs3QadfMfiVpFuSjP0Yos3mmroiiOWI9H1/DYdiZ/ENG57vPDzpdYgzHw9wyZVTWA1OaJV+OohtN1IvBncC5zhN8Vep5pujE/rJyzXC0hGhzxAnp9irTCM8iejxLCFgu2rtNvaDhqpBP8Vad/lZEU0u9BmpMDZ3KWVqHil96jerpS7uFwkOlBQN8fTUqBwR4R1/yfzYg1H7XsauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+QblZc+3uEXqd0H64Bxb6MnIok3TUwi7ypB+mIXwgE=;
 b=RawS7x2Wa+5q5R9T0js0Zip0LUCMZZr1Xum/o/+oBixOXVjxDvq7MTdnShTIVFHRj0j7i85NzhiDgdJASszeDyzwMv8o6ym44ZnJu2X0wfGlzorH4cll4qpP+5iESTgRC14YAhNN3DQu7v2vjvoswbLuoUTlbWENzBtzQKrqRCgRKvcjXNcJ7f+zautyxY4YZ7ef/9JXcRkHlhV3Dt/7/PXdhi0/oyuhjVTRDRwjXmuL1xlQYdE31tVsoBQ6cotEV4qtQQWX30YqwfiKPilUAadoBOas/xD1fyhBk4aEgkXa9Aiyrhwx2eOppgLr3ozlAeXKm5U+9vWu4x9NREziyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+QblZc+3uEXqd0H64Bxb6MnIok3TUwi7ypB+mIXwgE=;
 b=rfB9c+YtFgMLi2LFMcDNmYkjfu7LDagpi44ouK00wlo1j4UEfUU9ILSWtdBCZieLM5ziJx0R4RVI5rDOPmZxvFrjl/ocUi3mFmVLA6r31wQEVlRZGW7RQWa3U6E4mxzCVHbd5jBDtKSFkvoro6W9ycJrkqPprUv9BZPtrGrj8+LmhwITwQ5yL0QmEuRTYrxvsox0osEYZjk/UGAJjdgoEA9UH5MhWI3On8ekI/INgGd+pIqG373V94WW2NV3ZWzTgBnMg/HbBzLvz7usUFz+HdVwvsxMUxjlrjOVPAQzvIjpKIpnRIcOW5rVgqV9yX6C+8QwGqyKtEa5v7P9RKVzJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3122.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 05:46:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 05:46:28 +0000
Message-ID: <a5498e33-54ca-4c7c-b260-3c8922685dfc@siemens.com>
Date: Fri, 28 Aug 2026 07:46:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [libevl][PATCH] tests: sched-quota-accuracy: Fix test cpu selection
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3122:EE_
X-MS-Office365-Filtering-Correlation-Id: d475bb09-f017-473f-775f-08df04c7b434
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|11063799006|56012099006|5023799004|20046099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gVo3cQ30nVSeeKRQNfJtkzuyd9oER1wvIBROas5aAHmTZ+UKymRPSs7pT/OVH79eHlIt+nxpAZUfpur27WkL6hzJxBXXmTqfdHSor63FYPNtEwcOdkEh0YM+caD1TM0gDiepGyfPY6YHPNluzYsNc9d1rBwf83m4ZiLJ3mhWPr4wHxEN2jNTjauXYASGUnn7LfSHtCyWeSKKq+GsajpwWbpUM/Ow9q3zUfL4ysIuIToIwgXkBTi41y+/9tSvWDGfsFRLFf6rw32Nh8jOKrISdfGiUPLlyIA6aLWkdnzFiupRjk2XbVeTcw8L0YCRL5ZhxR/o4r99HVapElGi7IanCrPwfXUgNxVp/possp+C6/m5wZiQCYSLgJ0X9cTi60+Ebfcf0w8BZgBpFJ7q6uXiCB8d5fN6MRQD1KatQwuC6WJHVOojxcZkJ7gnqVSGHcWLq8kdzkhzun3yjwrnhgJye7qCBtt4gNkhfxS8DvYlZ0E/mGZC4mo0YNMWXpymkgJUUhoI3sRi9o0upg4o8pKKDHc4WmZ7rKpF6JtEo6eDyrBfuFtf1d4ofMRY2DE2Gb+cQ3YqraLsoCetDfu+AxtUjpZdpZiPVDvGfD3nlf+KXO679FZChN1CYpryaWU7Yv3m/icnTEfle77QrPcG+mZ0Nzq/1I7THDRyT89UfJZTOEo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(5023799004)(20046099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWtseitGWEpweHlCeFNtUU4vVEpjRUtxQW93My9yYWZiUHRYWVV1WXRyMDJG?=
 =?utf-8?B?RXNTdE8xcWNZNlI4MkR1MHVMbzNMQ09lUi92K2svV0dyR21DV2NUa0lTaEIz?=
 =?utf-8?B?ZXhRb2VXU0Y0bDRhMmhPcEkvVjNGZGdVbFZkQ0N6OXdSQW9ETlpYWm9YS3dw?=
 =?utf-8?B?ZHloNWxOUllxbkRQNzFyNEI0b29FdG9jbnRONmlSZUVsMU9CWjRuUzBtemRY?=
 =?utf-8?B?QURCRTF0cjdrUHV5SHEwWlF3MWZmWnJzR1NoaTR3T0xqaGpTOEZWWmZvcFBR?=
 =?utf-8?B?N0lmam1XTmxUcFFxYklrNGdpaGtDcThWd2FtY2VNMSttbnM1TTA4VkFmdWxY?=
 =?utf-8?B?U2c3YkpBSndFV1l2OUpEWGF0U2d4b0JXbEkyU0t2SVVoYklTdCs2S0FNREda?=
 =?utf-8?B?VEp3Z3lpTFV6Z1NNR2hMRFJBY2Y1azJjVDVmOWJvNHFXNmlsa0YwekpuYkt6?=
 =?utf-8?B?NjIzVGZJUjFWNDZtUzFzamJPTUJrcCt6V2JLSTlPdkRMNVloVVZMeVAvUG9u?=
 =?utf-8?B?cnJjcHVCMjNwcDZRbVd1UjJyMnRHdE52c1Zzd3IwOEhhREdERjZZZlAvTG9w?=
 =?utf-8?B?V2U3a3F6Q1hlN3RNR2xHQ2psNFp1Vyt5djUrSURNOU9uZGYwanpvWFYvNW9q?=
 =?utf-8?B?YkFuL2VxOG1ZMjd4RWNuUmtzb1poZXkya2lUZFlMZm9LSXRoNit1aWZmamJw?=
 =?utf-8?B?blFBYzFjcnBoSC9MdjJMeVo3bmlydTZKTzRCWTZkRFFYR2hrRVl4TjhQeXNV?=
 =?utf-8?B?ZTgreWVFNDBjbDBGZ2VSU055Nk9WM3RTa3VEOE9La3lTamFibmRkNDhhbEtR?=
 =?utf-8?B?Z25DMHhKTzFqRUpML2tNWWpqcHQySXNVdmp6bHE0NnUrRTIwY0Q0UzhHR2pU?=
 =?utf-8?B?TDRWTDA1a3dCa0lvUTVQMGh2eFlmbmg5ek96Ym00bEIycXlRczJmYmVyOXZ0?=
 =?utf-8?B?SllTeHVDSVIzUTBMSmRSVXRxcXhmajFJTUh0UUdDZUJOVjF3cXp5aDJBc3Zz?=
 =?utf-8?B?ZmxVanZCRmwvZHZYem5ZU3BZS2xuSHVNUmwyVWFjbm5OZFFyRE1NTlN6QU4x?=
 =?utf-8?B?R3FDdEs3WE1CYWtteHFmTDViV1dISkRGMk1PeWJRNWZEcFhabnYxMFRPMVA5?=
 =?utf-8?B?djQwMlRBTVYyd21pMk1qWjhWR2RCTnJvdnMxSTFaWmNpVUJyZnV5c3dNbVA0?=
 =?utf-8?B?bXZXdkQ3bURTdytIQ3ROcG1YZkhFbUlHSEoyZGl4QUJRU29PZTh4djRPd1hW?=
 =?utf-8?B?YlptZ2FuSUpJSGltdExIMEhob1Q5a0NGazZGZm1xSkRmQ0VTOUdmUW5saER1?=
 =?utf-8?B?cnlOL2x1N3N5VzcwWlpqcXhFa1RMTjBRVkNUUFRMNWJWenRvWEFuQ3hvTURM?=
 =?utf-8?B?NGIzeDdUZEhFY0JWVFl1QURBQi9iNGxoRWlCN2VJSVR6dnQ1ZHZlVXR3czgx?=
 =?utf-8?B?Y0E2WlRNZTNZSVVPZnVmbnlLU1Qva3VmVnJVRFdMdHlVeDcyMHJmdEJyN09E?=
 =?utf-8?B?dW9UMnFNMDlPSFB6V2N1TU1US2FIQVlqbmFFbUNmNHJuZ0pVWHVsOGFiRDBU?=
 =?utf-8?B?dnZnVGhPQVRHK242UTdRTlQyd1FoSjJRYW80N2wvbkNYdWJvSVQ4SDhlby8w?=
 =?utf-8?B?UFYyTCtrQnRBR0NRMVRMZ1hzNzhGak53aWlDd21VSHEwYlZkaXZQS29Nd3Ro?=
 =?utf-8?B?OXFWVURWRC9LNlE2cFplL2ZnUkxpZmtCY2J5TVpVQnVKVVNtdXhLUk5nc1hk?=
 =?utf-8?B?bzNoWUY0ZGZHOUVCV2p0Ujh0SFNxQWY2cHVvR3hSMEl4eHJScmpuOHBGOTRw?=
 =?utf-8?B?dmZPckhGSW5WdmxkYmFNUEVlc3lxRTJzVXJWVisyZVplZVN2bytub0FxK05O?=
 =?utf-8?B?TmtLZW4xRmxyaC8rM2dsb3oxRnZyc0FjcXlSUWZWbngzRWNobkJLMWJ0Lytr?=
 =?utf-8?B?OE5WV2dDbm40VEpjb2NsRUlPZ0FBZ1JQMnZhRFlKaFRBbHc0NldXYmdKVUND?=
 =?utf-8?B?T2QyYXJoUnRTaEIzKyt1TVBySEZXblZZU3d5amZkblljRmY0aU1HVElOc3pB?=
 =?utf-8?B?TzM4akpKMTl1aEhVb2Z4bUZYYXNQNm00SGc4VmQxWlFJZnZRSGk0MUoxdkw2?=
 =?utf-8?B?eXhlbzZobHF4SUkyRU5tcllqVnRNZFVCbnE4eXpQVHpEMTdTcnZMSVhCN3JR?=
 =?utf-8?B?bXl1Z1Z1RGpaVUMzRC9uSFF5REFPQ3RJc3V3am0vTDN6VXpOa0pBYi85cWJq?=
 =?utf-8?B?MktVUzRHejZyZEdTMGJDaGJZNEg0NDFBaXNweGtFbWVmM01SNWFxNTMzTTdm?=
 =?utf-8?B?T3hBTWE1NUxxcWlpSlFUVVAvTEhBOW9XWnRMYi9ISzBzN0tDSFBnUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d475bb09-f017-473f-775f-08df04c7b434
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:46:28.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRFOovPEYGCD0VXiI2ZG0kyPUM3+OdD/DHW0rDTQsPwa7GUBKua+Ch9HdbG42NPyZ7CCKezVx+5NwczgKFjxvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3122

From: Jan Kiszka <jan.kiszka@siemens.com>

pick_test_cpu() is adjusting test_cpu to the system's possibilities.
That is 0 for a single-core machine, but it can also be something else
on multicore machines if the OOB cpuset is restricted. And this causes
the test to fail:

sched-quota-accuracy: ** BROKEN
../tests/sched-quota-accuracy.c:96: FAILED: sched_setaffinity(0, sizeof(affinity), &affinity) (=Operation not permitted)

Fixes: 245a2eac29eb ("tests: sched-quota-accuracy: extend measurement to preemption noise")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/sched-quota-accuracy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
index 2c4daed..2a2dc38 100644
--- a/tests/sched-quota-accuracy.c
+++ b/tests/sched-quota-accuracy.c
@@ -389,15 +389,6 @@ int main(int argc, char *argv[])
 	}
 
 	atexit((void (*)(void))cleanup_group);
-	set_cpu_affinity();	/* All test threads inherit this. */
-
-	param.sched_priority = MAIN_PRIO;
-	__Tcall_assert(ret, pthread_setschedparam(pthread_self(), SCHED_FIFO, &param));
-	__Tcall_assert(ret, evl_attach_self("quota-accuracy:%d", getpid()));
-
-	__Tcall_assert(ret, evl_new_sem(&ready, "quota-ready:%d", getpid()));
-	__Tcall_assert(ret, evl_new_event(&barrier, "quota-barrier:%d", getpid()));
-	__Tcall_assert(ret, evl_new_mutex(&lock, "quota-lock:%d", getpid()));
 
 	/*
 	 * We need all threads to be pinned on the same (oob-capable)
@@ -407,6 +398,15 @@ int main(int argc, char *argv[])
 	 */
 	test_cpu = pick_test_cpu(test_cpu, false, NULL);
 	do_trace("picked CPU%d for execution", test_cpu);
+	set_cpu_affinity();	/* All test threads inherit this. */
+
+	param.sched_priority = MAIN_PRIO;
+	__Tcall_assert(ret, pthread_setschedparam(pthread_self(), SCHED_FIFO, &param));
+	__Tcall_assert(ret, evl_attach_self("quota-accuracy:%d", getpid()));
+
+	__Tcall_assert(ret, evl_new_sem(&ready, "quota-ready:%d", getpid()));
+	__Tcall_assert(ret, evl_new_event(&barrier, "quota-barrier:%d", getpid()));
+	__Tcall_assert(ret, evl_new_mutex(&lock, "quota-lock:%d", getpid()));
 
 	if (nrthreads <= 0)
 		nrthreads = 3;
-- 
2.47.3
