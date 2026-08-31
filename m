Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EC418342
	for <xenomai@lists.linux.dev>; Mon, 31 Aug 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198634; cv=fail; b=J6tR6DUih1OCygtm1wM7Cs49o/MmI6SpW0wMvOG/6to94OCdukBjwUq1wxgZRPuCHNxZ6hmPaDegF3hydOETCwgH9yY1V3CtfbezF55bXAbRo2KGp7rk/hjmEg1QBzfmtgg233bpiYCcDN6Nui1bsdxymzBUE+yJMZPJl4eEn7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198634; c=relaxed/simple;
	bh=W0CSDhwwiNnLW3/11c8jUJRI2P0Ki6/pqP9WRjihF3s=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=m4twCK/dYG609zBoDO6kcJlceX9/EPLnvT5/XM0Gup+qldb/Yp0oOXxWo/IqQvQ6MCNYAbxAbCKh3ln2L1260Bwd5m84QVPU8l4sjy7ZRORzbzZsxQCEcSuh273USP9J0ZvXuCX5u56bmFN6qvp/Bm58mz4uZRHZic0Zb3DVmng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=0LvAjkj+; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="0LvAjkj+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgrV1UJ1W1X3IFNMT4cgtjdb5K7XHn8mvFh/7posVjyz6z7PJnyU3jjTYaxJDCLOFnyo7cgVPPglQoCgKY/TcZdYOEBbRIBdm8ODtcmbzDvS5VysaHtGdzepJLzEnORLEIrqQE042qSEDLkJ/0vpjMxeLfZYSzwR4X7brUwOGZL/TWqeXsLpBtvFCFLyhSxIB9sHBIz9rrrvgisR6oYzNsBVC7J5Hf/ufkwbzL9sZxwyOY3DFH42EHh1tr5lLrriUfCBP7767YZIKk5pn/GFCLSs+28yFrbTtUv6xstVPQZqjY3II48ylQP8bBaKSjnPl2Ukd+x95oWQA0PizArEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrsLY+adyvNlvKgiJ5cOQzmWbSHjdukoySLl1LXo6Fk=;
 b=rdAxJJp1JczCRlmorwJ/WA87qUlsaTqPVF/lAoQzcgtsw6RbhPT+tus5Y3cgvlNnRFSktfwT8zpIFJuj2HX0wj3X14g0GRH9dhM/9Dp8F4q6Xgh2h33Qzw1cR2dEtwxHZIXIyt2SL2xFxBEZl+m2lRN+y7C6YJ8arHNQ83kXQFSGOLw8N47Xy7OiDBu+m2DMeONsN1lksRj06j1OnKHB/cJMzfR4sf08UNEpD+hTFxY2K9zIavhYod/+pUWJpuTl/CLUTGJKHTUMyknxS8F6SFFy3DWKL/eP6vugmM41tGQIFtcYZoe0KPlCwH3uwSwCm9X9R6Wht/hl0snP77s/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrsLY+adyvNlvKgiJ5cOQzmWbSHjdukoySLl1LXo6Fk=;
 b=0LvAjkj+n1sFPudOYEuNTyHYcHV2egH9tOot19X9FgWUyvjsjZ1/1LxssRPQY8NIHZBMmQuuxAeQeq21hl/rGMdb3fyuMDkX4RTmVDWtKK92PHzHic80h/zXbIHjtGH4b04+c8HEQyfEj06LMw7xLauDOxOcxmnBjDzhJDrUHKXlC3zPVGMtMrqs+Cuu7d5epxWxXGafCERtFCmFfNYTNToFFKSavv/zjKy51kDTo1MP4iHHLxQ7QguEfPz9NQ2ZhI/HzPIxlMUBc7BFltBuWsgOIFmwdK/8x62fMv5ZpFzedebEipGChcF1a+Ffz21l3MUb34zZVphra9sYS3Kiag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 17:50:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 17:50:29 +0000
Message-ID: <72486647-41b3-448b-bfe3-85135c1ad53f@siemens.com>
Date: Mon, 31 Aug 2026 19:50:25 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [libevl][PATCH] tests: sched-quota: Simplify disruption
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3848:EE_
X-MS-Office365-Filtering-Correlation-Id: 489c9e74-08a4-4d85-be15-08df07885858
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tqQrz51uuIOQOPK532pzQobOjp0HNXcHaMhUkPJ5vLAD5GRqpPjFLYx6G2zA4c5pwP9pyk1e86AJv/oSNQRo4DYwzS55Opqy+8/9gM1TsGIjdH9QmrFoZC+Bf9/QIkT26N7qzy6GQvFtQftRg1RByt3XPLYPeaabqg5GgNaUjf28ocEzZ8ZEaVkSKHGjXk4S1NLhoq9wASGZJh+1k2daAleV5DIKxCb+zv9u8+FJm4gZ1K4nIgxFwmdRLlp7nX8Gu8NALj0HdUN9U1RNdPj0L8XfmzZ4WzL+TkwJg0kDdQWYmQq69KMod57cydPvWTTJdd/Wet07bjsoEaf23mfcKUoJr8nbey6qR1EaF5TEkRP0r6LMjcKrr5mmdCsWjBrUoPaJOlQWaBQgk8MFQV63h4ThMvvx4n2W3N72cYGnf6RCsxqBmAcPYDWmf0fCZUZ7tZrIRSB0tQWwfOAhSmGUXEs0Uhslah1H7jYhKEDsfkPeXprySuM7+IzyqxOjvrzDEYF4+FZur73GILmHFRC+ttbYjKQ83P+muEiKEuFpfBGV2ugiXVoGrceJL4nKy3A+hP8V/Fvx2yofLPA7Lq68w3+xUCpCiU9Gap0sBW0iQEKs/wFtkjaZO+Qjlcb2Nuzy/agcMlkUQn6IvNgo10iLPm5RtwHiZXMT9X1V0jTnzvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG1Lc1kvdVFzREdJeFJoY3JvVUJhTk91RWNaK29wbHRCZzltNnhiYkZKc3c0?=
 =?utf-8?B?SkpmV2RBeTUrVm1SSXRMN1lBQ2tiS09aTHNxODNIamgzUHZVVTdQNHEzblY0?=
 =?utf-8?B?bWppNlJMYW9vcWZKcFdrbUVXRnh3OXNuUTV6MXkxVWJmOGo0aVVNTkJDaitj?=
 =?utf-8?B?dXgwWUsrMzZObWFLb0QyU0dvYnRXbmdCd09xUk4yOXFGQlgyWEszelNMV0V0?=
 =?utf-8?B?ckFjNGpIM2JhNmhIZnhVWklHSGMzSUNpZnBnRHg4ZHJvRXRoM05tQnFkT2tK?=
 =?utf-8?B?eUdOdjB3N0RxaElxamVYK0tjOS81NFp5V2g0aUVTZlZwV1JvQng4aHFDS3Fa?=
 =?utf-8?B?NFJOcjhFemNNdERZb1RJZTVVVEh0V0tqQ3lGK1lrdzB2NDViUFUrSFRoVERm?=
 =?utf-8?B?OVp2VE9LUkVOVDgzY093OWROWGFRbXRhRktHZHBXK0k5VExHQnRwSlZDekdN?=
 =?utf-8?B?UFhaL2Z6YmdCdCthNTBvN0hOMDQrWTh0NGF1SmZ5THU2SFJOSmtHVUEvWG51?=
 =?utf-8?B?NmVjV2JvdENUamFnWmpKM1hMT0RrTEFpRlRzdjBOenFKRjdWV09XekpCa2Fr?=
 =?utf-8?B?bFJ3b2lhS3YxTmlkVGZESDNyM3VucW05N005eW1lTGhEamV4UWxVSmkybWRx?=
 =?utf-8?B?K2NFd0JTdDEwQ3hzcmcraWJrbW1uUEVOaktZWVdNbGNWTXQzVnE1MVI3cmVG?=
 =?utf-8?B?Y09TWEMvUGJBbHRoMEV3VEJNdUpGdnM5d082b1JKNERtMWlJMmNnMkpTSGR3?=
 =?utf-8?B?U255QzdqMURmM1Y2TGZlWnlWZmlmV2RHcEl0eVhMWW56NWJkT1F6bzlvcDBo?=
 =?utf-8?B?RnhOZmQzSGczc3FuT2QwTXRoM0lMeklibXpLcVZxRU9GTkJXWUZLTDdiTWcx?=
 =?utf-8?B?UHRNdzJ0R3F0a2pVVWJheHptd1VJZTNESUpMcE9QTUN3SmNDenIvcm9sQUdj?=
 =?utf-8?B?dnlGNGFjVnRhZTJaN3FXSkg0TUpwclJXRnlKSjNya1MvM3JOc2Zla24zbWVh?=
 =?utf-8?B?K0lUSk44eXVaa1VKNlVBbXgyZWRXNmZjYzZkVXpWbXk0TlBFRVcrWEdHOHhy?=
 =?utf-8?B?RnRoWmVycmFjaE5GTXlGSVFZaFJ5a1pQSk1yVno3aEcrbnUzbnpudDhVWGVh?=
 =?utf-8?B?SWNaMWhBSXR5TjlGWDJqSFNhdzc2c2hOUWxyL0h2Nll2TldjcWprZldkblBo?=
 =?utf-8?B?eVNUTXpyeDlkNWRPSHlLazdMYjlma1J6WDA5anJ2WkkvTitGSWFoWHRlT1ZZ?=
 =?utf-8?B?UjR2L3pod0Q3SS81WHdOQ3BUdElSWmdIT2docDQ2MjNOZ2R0SUU3NzJteFlL?=
 =?utf-8?B?aGNYZHFST2RSL25NYVF1Y1RZVC9NaTJhenpRUVhZc3lyQzZQK1c4UjVwVUZr?=
 =?utf-8?B?a0hCeGV0R0ZqdC9MY1V4WW5DMHhGNExETy9YRGlya2NIbmw2dGxoWGQzMUtC?=
 =?utf-8?B?UWJZODdWWjdQMUpTWUk0OVhiQ0hVYnZML1lJU1JtTEJnSHJnMGE0NzJhMW53?=
 =?utf-8?B?UmdodEk2cjFvZEFMVXROd09KZHpGYzBMSzlrNnhmS0Q1NWk0TnN6RHIvRUVW?=
 =?utf-8?B?NWhnOExzdSt0eTNzS0ZPamd5MEpLd3VZYW1mNWgvSVRQeXBKWDlnMnZqcG83?=
 =?utf-8?B?VVFaZHhDS0dVWUNvMzZVc0x0V3I5Q0RqUVZ1R3BkZnZIVjlUbXU5ODUxaVU2?=
 =?utf-8?B?a2Izd2JkblI5V2xkVFoxRUdVeFJ4WDVtRHRDTFo2di82MkxuSVN5Y2xkZjVo?=
 =?utf-8?B?VlhxNzAvTTY5SjdURklZZHYwRDVGQWtNUmhXTDBRZzhDRVlEN1BFUFVQK3Vy?=
 =?utf-8?B?Qm1MRWJkcldDcU1nM3EydmFSVFFTczhtVW5sanV6UkFyWllMalA1YmRMWTZh?=
 =?utf-8?B?emhuWXVFcHN5emRTK3orL3pSNFZjaEw1dkN5bTBBaU1tOThnd1dXeHliUGRt?=
 =?utf-8?B?QVU4TzYrVWZQd2xMcnBIMXJmeThlc3hNd00xTCtIMmMyZXUyaGJtWWNxYkQv?=
 =?utf-8?B?dVRqNGFwaGNtdHI0aVNNcnBlNTNhL1N3KzUzNXM2ZDRHL1AyMDZJQnY5aHlq?=
 =?utf-8?B?R1hkMmFmRmwxOXVlT0RsaUo3ZmJuNHhxUXpRQm04MWpHaHJlSm1YbitkRi9G?=
 =?utf-8?B?eXBjT3ZPT2JPQkwwTVlNNjkxblB6dldtQUMzNVJWcTlXQUliZ1oyMTZxOFZC?=
 =?utf-8?B?MzVoK0x4bnFZTTV3YjlBQVBGWVZ0K1poWExtMGlvcCtscUY3WGFQMlFoRnd3?=
 =?utf-8?B?Z25sNGk3YWNkRjN6RlBmMzgxb1YxTHlpenZ3V3FvQlgyNTZBNFJBK1Q4emN4?=
 =?utf-8?B?MFgxczM5eG5VSldVNS9KQ01JK1JTMkhKQU5VRFhyaXg3T2dTWGZNZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489c9e74-08a4-4d85-be15-08df07885858
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 17:50:29.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCEQB5L+UM18Pbhb4fa2Ai0aATPUU+6hoPGfg/84r9GfP8W/zX9CbxekddgmJyMuSb0ON0StMmlBLOiy9DpJ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3848

From: Jan Kiszka <jan.kiszka@siemens.com>

No need to spawn an extra thread here and also play ping-pong with it to
generate an oscillating load. The main thread can do the very same thing
within a few lines of code.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

On top of my previous patches.

 tests/sched-quota-accuracy.c | 52 +++---------------------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/tests/sched-quota-accuracy.c b/tests/sched-quota-accuracy.c
index ac04449..251ea30 100644
--- a/tests/sched-quota-accuracy.c
+++ b/tests/sched-quota-accuracy.c
@@ -26,15 +26,13 @@
 
 #define MAX_THREADS	8
 #define QUOTA_PRIO	1
-#define DISRUPTOR_PRIO	2
-#define MAIN_PRIO	3
+#define MAIN_PRIO	2
 
 enum runtime_phase {
 	idle_phase,
 	calibration_phase,
 	accuracy_measurement_phase,
 	noise_measurement_phase,
-	disruption_phase,
 } current_phase = idle_phase;
 
 static struct quota_thread_desc {
@@ -111,23 +109,6 @@ static void wait_phase(enum runtime_phase phase)
 	__Tcall_assert(ret, evl_unlock_mutex(&lock));
 }
 
-static void wait_edge(enum runtime_phase phase)
-{
-	enum runtime_phase old_phase = phase;
-	int ret;
-
-	__Tcall_assert(ret, evl_lock_mutex(&lock));
-	for (;;) {
-		if (current_phase == phase) {
-			current_phase = old_phase;
-			break;
-		}
-		old_phase = current_phase;
-		__Tcall_assert(ret, evl_wait_event(&barrier, &lock));
-	}
-	__Tcall_assert(ret, evl_unlock_mutex(&lock));
-}
-
 static void start_phase(enum runtime_phase phase)
 {
 	int ret;
@@ -191,24 +172,6 @@ static void *quota_thread(void *arg)
 	return NULL;
 }
 
-static void *disruptor_thread(void *arg)
-{
-	int ret;
-
-	__Tcall_assert(ret, evl_attach_self("quota-disruptor:%d", getpid()));
-
-	wait_phase(noise_measurement_phase);
-
-	for (;;) {
-		wait_edge(disruption_phase);
-		do_trace("(...disrupting...)");
-		do_work(NULL, DISRUPT_NS);
-		start_phase(noise_measurement_phase);
-	}
-
-	return NULL;
-}
-
 static int cleanup_group(void)
 {
 	union evl_sched_ctlparam p;
@@ -236,7 +199,6 @@ static struct accuracy_results run_quota(void)
 	union evl_sched_ctlparam p;
 	union evl_sched_ctlinfo q;
 	struct timespec now, next;
-	pthread_t disruptor;
 	struct sigaction sa;
 	int ret, n;
 
@@ -304,10 +266,6 @@ static struct accuracy_results run_quota(void)
 
 	do_trace("CPU%d: starting noise measurement", test_cpu);
 
-	/* Start the disruptor thread then wait for sync. */
-	new_thread(&disruptor, SCHED_FIFO, DISRUPTOR_PRIO, disruptor_thread, NULL);
-	__Tcall_assert(ret, evl_get_sem(&ready));
-
 	reset_quota_period(PERIOD_NS);
 	start_phase(noise_measurement_phase);
 
@@ -316,17 +274,13 @@ static struct accuracy_results run_quota(void)
 		evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
 		timespec_add_ns(&next, &now, DISRUPT_NS);
 		__Tcall_assert(ret, evl_sleep_until(EVL_CLOCK_MONOTONIC, &next));
-		start_phase(disruption_phase);
-		wait_phase(noise_measurement_phase);
-		__Tcall_assert(ret, evl_get_sem(&ready));
+		do_trace("(...disrupting...)");
+		do_work(NULL, DISRUPT_NS);
 	}
 
 	for (n = 0; n < nrthreads; n++)
 		pthread_join(threads[n].tid, NULL);
 
-	pthread_cancel(disruptor);
-	pthread_join(disruptor, NULL);
-
 	for (n = 0, loops_with_disruption = 0; n < nrthreads; n++) {
 		loops_with_disruption += threads[n].loops;
 		do_trace("CPU%d: noise: quota_thread[%d]: loops=%llu",
-- 
2.47.3
