Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68C25785D
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465761; cv=fail; b=hBRTTsxgX2CM+BCqKgarxpeCFG9KVrkiFcXn//xB09GLO2MyVGQ9kkhs9oqashXLlY0jLRpVOUi/AnIqSIR3KStcWaCpni3Zijtad+EocTYZP33ExMaxXj5l8Aw78SDubagFkA7nqBkrRRQdALfnPGchiaMJwqKxt7hV+QYG1jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465761; c=relaxed/simple;
	bh=+3GeTrpRXqYfDxc/qavRY/Q+S3j7SLO2TvIMrS50EbQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a8iEb8Ovy3gmy85I+askQ810K+mH/5gJOyLQy60MOwfSKx7SykWzsXZOvzqAv4oic9VOG2qxfetSVYNaXikhRbSl5OYiDeJzvSUVNSx1gXKwxh06mmXFzuCqHrZzed6mA2HJSJ3FGs4+r6g5y0eaFEYdUC2omaTWCo0Cw+6cJf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TiQ1SOrK; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TiQ1SOrK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1txJ2k47Y7+mnfKbqvn7p0eR1q8QFc4yJwlHjHD+fHjIM2hJF08FsmK5y9A371WSp1wti+aXJmIpOkmS477fNi8M6rcLGdSz7b8mqsiWplBI0omr8s2oLjYD7eaviH1rJAAdJR5ca1gP8QExZlKBGVPvyzMPIfHqzkZrlGM/dqwfyh8h+uJuO/C0RIzKkhFAMzNSKpgl3g6O0ElrdCwBT0oM8AJmwhRkmxBourJcNPL1TSA/QPpJdW2oQIvLrT3MTpqGRL7Hqic5WMBCtjO9HFcauki9uTAVN2gV2xYDWmS/nwm5egYHdbm/FGNShbeXFxTKY4jBucHKyee7IMTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jzpupV/lO/D2z5jlYfeggS4uKOwDVDTJpJ2lehVbOE=;
 b=B/a7PA/Ss7p0vSpWM7twWFMRLIK+lTJjUIvd67S5kGNu0USQIbV4bicRHDnMfDCtVNEN9Q9bv4zQwZ0CW4lnuok0/yJpZNE2zpGwlj1sLWDrrgaX2QZqyR3u7A/8/dgG8PjanH4UU3lmn4FTdmuoQ7gW3ArFbOYgY+V5YgFzw0GEpCiEc68oh5VvdPeByB2uH7tOQmRDKgLHYYsaxagTG2aPrwCLgaIAg5yNI3AqPVGxZka2zrcuryX6LWZ6qg/uO0gcLQFH6O6e6ytA8j0wI3UvTJmNOTsfh4aC6dmfriwEQ9yPUqbZgRWSwhDw4yjSF+1vX52BzSqdzbNkW4wFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jzpupV/lO/D2z5jlYfeggS4uKOwDVDTJpJ2lehVbOE=;
 b=TiQ1SOrKLB2E3PEPCCWnXRaB0pXoG4F7VwEWgde/4eIwdaY9NkfnofkamBXdNxO3RNSuh50t94tlkEsIxxJo6iPRAir6S3tV2KmEuPRpxMsRGiiGpx7wFQCoaEffqvqf9oOs/MsPDo5WRIQtMdfT0vayKHaZ2GOwAY7/WC9TVw6ju8ii8LN++tMSaiJr5R8d7X1oPn8dvSEhUKqWQgwJ3kyYdA24ikF1NrXDZbmGIB8THSVrmq8y7zrL0sT6VrX8vwMQin5VT79AWpqFgL0BfyHQczXo01fUt8vDN1jD4yWyou7PUuS+wrZgc7qe39ohrOXYQPLHhXJAlogqTbTOyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 19:35:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 19:35:56 +0000
Message-ID: <5e63aec5-e782-4936-a526-c2fffbbc9635@siemens.com>
Date: Sun, 14 Jun 2026 21:35:55 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] evl/sched/quota: Correct budget tracking for preempted
 threads
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe0534b-9bc4-445d-3274-08deca4c27ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hc4AGuzPbPJ4etCdVcf7j9PS+IUR4o0lIy0thiWLvRdo3DNN3XDVx536TKfpSxvOBVzajp/8BL6DZKnd/XDiyvhDiRi9DQCM2L/LxPJZ4fpci8+sPkylVrVOBB1kRlM3UdpFws+n5FsFM405HGsH8+QyiRbZ2jSwQl3XSKS0qBuZw4oG69xlYdSWUMcA1G7W+wtNtM+bU7kpmUGMdKfKkx99EurORkHFizfr3RxZn3jT0P10fOfkBJ/09QCWS3kbRG+6Jtq4MShpwuXnXtVhml0BbZ17W4FHbMeeuy7YahZv9iK8ikOt4HpMKevrGn3cPCmUhewGFgAnIKPVYlqI+QaBSE/qGyjzOkDfTtToaZCFHW9vPFUG4/2iZEtDK71xDXxuTtfAH1TYLnCbsoDj1hCOVGxGDF1+PsYbAXTxPx9jOib7VGRdTkciam2/IFrlRMyxljGUrTY+hnZEFAzyE1h14I6t5vTfn/11lzbpZYPgV7eIhiL2jNAycS0rVRuDej76Wp2Y2JmEv14uLbny/BP7jG73a6OT7pZWp4/JzKyJE/cBwjsAPlhE/LvQ5MYH5LI+7Ym2ymuO7QZOSz5ie/mAyQIAezu8LNdI8aKjPu6jTSDmLySyILKzR7lYIlKK4s29V07r3tcpuxjvkGhPr157q4npfLF4nJ8XBSWhaArPeka9ce5UzPrEZmya3oxl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEM5STlxL2VWT1JEbFEwV1pTbE9UV2wrSmJnamE1cXlDaFZzMzhUZVBKUTBr?=
 =?utf-8?B?YkE2OE15U0lCMHQxd09ESTB2b0NUY2RPYWJGdVNMYVlJMVp3ZU1zUGNDd0tE?=
 =?utf-8?B?dmczd1hPUVBLdkVFQzdObXlVN3k3aGIycUhUN3RwckFSdXFYY1AzZGJHSlFI?=
 =?utf-8?B?Z0ZzUnk4SXFLa1lMQnJGWlNZeG50K3F5aWZ5MXdsL1JTQ1ltSjRJVGcwMkQr?=
 =?utf-8?B?YnI5V1JuWFpLZXZ0a2t2eisweVhmeEIyVHY5TW84VThidVcwT2hiNW1iSGNw?=
 =?utf-8?B?QnpTZ09mSXRiTWlGNnhQUTdSQWNsYUNJN0JQOTBvZEZVYUNZTFEwVUFZUSs0?=
 =?utf-8?B?M3dmbW9OUW4wekQ2M0RRY3k5bCtzZE1iUjBJeWt2eVUrYlFtSXBKTjA2aDRS?=
 =?utf-8?B?UHlCNTg4bTlMY2p1ZzdEbTlXeUswSGdkeVR3b21Nc3pwT2o0eDJDZUY2Tjk0?=
 =?utf-8?B?VmpzalV0dm9vMGRjd0xneHdxUm9QckVSbVd3YVV4Z05GakJ5TE9vbnRCeith?=
 =?utf-8?B?bURaeXZsQ0ZJTCt4TjkxNXNlRHhUNitScmhNaFJ1N0UwcEhQU0FnTEFydy9Y?=
 =?utf-8?B?ZlJxQ3d0TUFZR3lIL1c1YTY3US8zOFBDc3hwVU5IN1hCbkNpaW1lVzJHTGdL?=
 =?utf-8?B?eVlEZU5XMHJIV3F0OS9yOGpiUngvSHgrWCtZRUtTcTRYanZIK3Zqa0w4RXlK?=
 =?utf-8?B?amNsdFM3bXpPRTU1Q3dOWlNTZVNGcURHSUsrelBrdjZGRmZVVStaQU5MTGVn?=
 =?utf-8?B?QVZRb2pJdmJvNmIxcWZONlpaSDEwelVSMFN4aTNpdTJGc21mbTFyUEpxRWdY?=
 =?utf-8?B?VVVrM0E4Y0FrQ1ljckx4Nk9KbmNGWnkvaGNKQUJqUkQ3Y1ZVOFcyVloxRzhl?=
 =?utf-8?B?M0JkL01VdjZadjVHU0hNSjZSVjN4Sm5zYkxCUmJtZ3JzbEpOQ1NLRFRMT00v?=
 =?utf-8?B?UkJQakhVSU5BZWZjaDlhQ01tVTZHL3diblQvMklkL0dHVTllclM5Z2orZUww?=
 =?utf-8?B?T1BvZ3dYT2tkSkZVNUdRc0RETDMrZXRkVUNQTzZ5Rk5xWXBDS3U2M3B5UFpz?=
 =?utf-8?B?MXFYWVFySlZ2OVFtdVd6L2ZWMG1qRm9wMDZnTjVUbU5oODAyeE1CbFYzY3hD?=
 =?utf-8?B?Q2NQVUhYSUEwajZnNEo4M0tVVjlqVlJtdXQrYXU4T29MMC9GdmlQRGtjYWhF?=
 =?utf-8?B?Vkd5Q3hiNFMwQVZJMEV0ZzVEWDQwUUhHVG0vOUpJZjBpa2FYaGJOSHdxSGda?=
 =?utf-8?B?aFN5VmVXU2JsZVNLVXpJbWk2NmxCRy9tZ3RSTmZaRWFVcTRzNFlncUdOMlk0?=
 =?utf-8?B?U1laRlFQL2NYVE10N3NQa3BKK1VjOW4rd0FXRVhlekhIL1hlTGFSaWFheHZX?=
 =?utf-8?B?SWkzZ1BtWE03MVpNWEsvSFZwS1lZUTZ2dm5NTGNNaWJwanVJbS8rSUVmVzEv?=
 =?utf-8?B?YWFhOHRzUWxibHpGNXYxNzhYTHN0NDJYNDNhUDNhNTlrdFNGeDNSVEkyUmRV?=
 =?utf-8?B?R0dEb09aNk0wMVg5d2l5Sk5CQ0dtbTROcHlEQkxSTml3bFgwL2dPOG5VdnRq?=
 =?utf-8?B?NklwNkdGNnJuLyt6MTlCQWtaMGV5WU1DN3crbWU5NHNvWVBhREdTSTJ0N2g3?=
 =?utf-8?B?NDIvUm16UHpTY2xoNVNzTUZLS1NnV1N1a1VEZm9VSFMraFpUeEkyQ1h4LzRa?=
 =?utf-8?B?NU54VXQrbGV4bWltU0JRbmVNcGRxdHV6MjhPaUlOUEFKSmY2WVhwVW0vL2gy?=
 =?utf-8?B?aFlXOUlaT1VSSTN3VUtaeDJ5Q2M3c1l6M2pFM1RFdXJ6R2tFZXhDRDVqUEsy?=
 =?utf-8?B?SGdQWEVNd1VlWkY2cWowaGViUDRjV3o3VjhqcHZ0alVPY1VaYTRaMmZUd3B6?=
 =?utf-8?B?ZGk0anZqL09MNUpSTVEvRWVFSG56ZFNuY0ZXMlcrR1ZkRVhvT0x3czNCTEsr?=
 =?utf-8?B?R2JHdFhaUG9HWFAxdU8xSmgwb0UzUEI2UzBZb25GcG5qNC9HcFZYOENkYjBD?=
 =?utf-8?B?SkhRRjFIbEtaSGZPRDNZSm1Lc0wyUmxYWlcrdWZFNnZVQURqMU1Jd1dXQ0Vk?=
 =?utf-8?B?UVBRalB5cGF4cjZIa3B2bDdQUFBLcHFZZEhiemNiMHB2cmpORzZIRnZ3d1FL?=
 =?utf-8?B?SmNIalN5RFAvblhlano0MnBvcTIwUXEySlhWdzRYVm8xbDlMUzFVMXBtOGxx?=
 =?utf-8?B?bXVLK0tGazhqRkxsODBOVkdlWUEvN2YwVzNEc2xTWFowc0c4eG55dzVMRGdr?=
 =?utf-8?B?YVRCbjY4c2lBU3lNUGEwTDMvUmsrTm55dGlHaXBoZmdLMnNzRHVQNkkvKzho?=
 =?utf-8?B?WHVkcUlwU0YyK21odlVlYXh0NGp1a2NHVDhlZ0tQY1U0S1VRVTdPUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe0534b-9bc4-445d-3274-08deca4c27ce
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 19:35:56.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1Bz4qZvBg74EEKmoIS9yirLqzX/5wnRjTAcE7SoXvMD+UD45FtxEE0fJ9CKCLwW9u96c29vZdRlotdYctY1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7382

From: Jan Kiszka <jan.kiszka@siemens.com>

This was so far not possible due to a missing sched_class callback,
causing threads being credited for the preemption time of threads from
higher-weighted classes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/evl/sched/quota.c | 56 +++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
index 0829da711a66a..d331dc2e8f7ac 100644
--- a/kernel/evl/sched/quota.c
+++ b/kernel/evl/sched/quota.c
@@ -187,11 +187,28 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
 	raw_spin_unlock(&rq->lock);
 }
 
+static void charge_usage(struct evl_quota_group *tg, ktime_t now)
+{
+	ktime_t elapsed;
+
+	elapsed =  ktime_sub(now, tg->run_start);
+	if (elapsed < tg->run_budget)
+		tg->run_budget = ktime_sub(tg->run_budget, elapsed);
+	else
+		tg->run_budget = 0;
+}
+
 static void quota_limit_handler(struct evl_timer *timer) /* oob stage stalled */
 {
+	struct evl_quota_group *tg;
 	struct evl_rq *rq;
 
 	rq = container_of(timer, struct evl_rq, quota.limit_timer);
+
+	tg = rq->curr->quota;
+	if (tg)
+		charge_usage(tg, evl_ktime_monotonic());
+
 	/*
 	 * Force a rescheduling on the return path of the current
 	 * interrupt, so that the budget is re-evaluated for the
@@ -253,6 +270,8 @@ static bool quota_setparam(struct evl_thread *thread,
 			/* Dequeued earlier by our caller. */
 			list_del(&thread->quota_next);
 			thread->quota->nr_threads--;
+		} else if (thread == evl_current()) {
+			tg->run_start = evl_ktime_monotonic();
 		}
 		thread->quota = tg;
 		list_add(&thread->quota_next, &tg->members);
@@ -400,21 +419,11 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
 	struct evl_thread *next, *curr = rq->curr;
 	struct evl_sched_quota *qs = &rq->quota;
 	struct evl_quota_group *otg, *tg;
-	ktime_t now, elapsed;
+	ktime_t now;
 
 	now = evl_ktime_monotonic();
 	otg = curr->quota;
-	if (otg == NULL)
-		goto pick;
-	/*
-	 * Charge the time consumed by the outgoing thread to the
-	 * group it belongs to.
-	 */
-	elapsed = ktime_sub(now, otg->run_start);
-	if (elapsed < otg->run_budget)
-		otg->run_budget = ktime_sub(otg->run_budget, elapsed);
-	else
-		otg->run_budget = 0;
+
 pick:
 	next = evl_get_schedq(&rq->fifo.runnable);
 	if (next == NULL) {
@@ -430,8 +439,6 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
 	if (tg == NULL)
 		return next;
 
-	tg->run_start = now;
-
 	/*
 	 * Don't consider budget if kicked, we have to allow this
 	 * thread to run until it eventually switches to in-band
@@ -448,9 +455,12 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
 		goto pick;
 	}
 
-	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
+	if (otg != tg) {
+		tg->run_start = now;
+	} else if (evl_timer_is_running(&qs->limit_timer)) {
 		/* Same group, leave the running timer untouched. */
 		goto out;
+	}
 
 	/* Arm limit timer for the new running group. */
 	evl_start_timer(&qs->limit_timer,
@@ -462,6 +472,21 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
 	return next;
 }
 
+static void quota_out(struct evl_thread *thread, struct evl_thread *next)
+{
+	struct evl_quota_group *otg = thread->quota;
+	struct evl_quota_group *ntg = next->quota;
+	ktime_t now;
+
+	if (otg && otg != ntg) {
+		if (ntg)
+			now = ntg->run_start;
+		else
+			now = evl_ktime_monotonic();
+		charge_usage(otg, now);
+	}
+}
+
 static void quota_migrate(struct evl_thread *thread, struct evl_rq *rq)
 {
 	union evl_sched_param param;
@@ -786,6 +811,7 @@ struct evl_sched_class evl_sched_quota = {
 	.sched_dequeue		=	quota_dequeue,
 	.sched_requeue		=	quota_requeue,
 	.sched_pick		=	quota_pick,
+	.sched_out		=	quota_out,
 	.sched_migrate		=	quota_migrate,
 	.sched_chkparam		=	quota_chkparam,
 	.sched_setparam		=	quota_setparam,
-- 
2.47.3

