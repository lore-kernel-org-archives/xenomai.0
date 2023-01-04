Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78ADBA45
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 20:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNZqN3NYNUQxnK8fjXfKl1Y0RPTrtApCCTx8HlokllPs9RgwiMpQ4lFM4WjqroJIxdI+iN422cz2/scuInjjuDUcg2l/gwwb57uVpmrVdq8xzeUhuKB6gsK92hAaaeK852I9VAWQZ/CiG39DV+z8Ez2AJ30sAPvtfG3VWjthiY457MVIsS/4bSQx6PMnDiv6A5+n2zbE+KdXjJUC4LqsuL6RBW9o6ECoAqmxkaSpkBkhBmR9awFE5yx3DaH+/vGCXDZwH1GVZNf+NRANkgq+Z7gT9mWujimVEgk9FaCMK45ew4RvPcYp1wv/U/WQXzD41k0Z2r1ifMrvHuYNtDUfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNQhEsn4pQVK4zGHpAj368t4MH/iLz/aaiYIFatlu0Y=;
 b=U3Kld9Ngo5Lgf01kv+LTG+ZoNjvA/XlGk0aWd7C3Xije+lxv0CNbyz8MmeJMe8eo+J5bRSP5tLbzNS46MKs6CG1PhI0mmc0ZQdFH9LmuWSB9b53zpVl0DI/P9rNkMFt/XonAqzhFuYtx/SNvPg6b56W0fNQzywhi+Q7qPo/3DzyLzp2tkuwqcEqXY6aAKHj73j7nzdglMyj8vixnW+onQeyKAfxYqDims39wSR/BGHo+uS++3cf0Nyb7W2byEUZjy166chlS4Dc09Soq3LMNj/LNSJHCxmIsSlbnmjg5+rSDGj2FnHeL/9oxk6cGzn6cga/e1A3K5yiMUy/A+63WRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNQhEsn4pQVK4zGHpAj368t4MH/iLz/aaiYIFatlu0Y=;
 b=zVJX/OUMZ+0Q2upPWiyRG+RFqBxTxfs0m95nkhAAwjd6lRD+dPwjfCo7KVZQNfa4f8WdDe5uRnCWf99OvtARg3l/wGfPjLXibAD0Nr/wy351ONlxH47InMAbO9N+e4t36UJEmr9D2ov6XfWvFW1ma34zshfIl3r4k/sgGjQUFRyJutbcVn6gKKx4WEfAiAH3ZkuIX3ohraMrBFP9BVIkWjMlwtHg/k0I81knIdMK2KzVZYP1kyZsyadsE5R+d5rCo0/onGMy8YHb0w3f9LWjPuGrT/baWLbzHRFNqp1udsxLpPbsrvhZ8jHg8FxAIWSfum6+fgtAQHJvcsgtPxZnaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 20:58:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 20:58:38 +0000
Message-ID: <27b5a8c0-8955-35da-1663-8e561dc84541@siemens.com>
Date: Wed, 4 Jan 2023 21:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/timer: Rename timer_* functions
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: f81d9449-4e4a-4d92-4239-08daee967391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KTuVp4Pw11ABXkMewHXEwKM1w1FmYBYcQsSAPb1KW6y8I8srs2nnjCxbzhwJPOqOLvzh2y3EldJWaX+oUG0MuIABokDhe+mdPbJ/O8WD79ZNlndkJnlY28Fxp6zrmKjOPOn+fnSwjr53MATxSlenhFpgHeIY+vITLzHDRgt+HjL76Sb6ipm9teyTChqXTsmvSRtrAU9t90gJtJvuDZud1JEM5q4fF/2KJjhtx7sFnsknbEbW45+Mxhg9ar1AdprsQkda2dfYV7A8Z9ypp/AJQmxLR9KI+G8hD1EzkRlex99EurQX8OZ2OHXLSlSzrEb43y30DLtKPXDM4l8X5gKoUKwzdJusZ0sBXtrxM27MoYEN9OqedkwC3cqbUYHXjvOJU2GaCj2eiQmFdD7RQ1wBQyOxB82VLV5hTKjVrp+MT1VGJilD9dHhRN4dc2h7hL/8c8z3BSdrQ8NJUuBXBkfhnJwq6vH8IUChnKqA+3o+V9U0xn6f5E6qmSEDXmdXJGKuR8Vz/xqYJq2oomRWk+cc0kdYyyyzE7a84g4Cqt69O2tCYJoA7WwiQaijvGKtv/COAImZZo5oJhowQDQs83KSYMm2LeUu1K5si5uI00bLT/xnLsViyL5lvGNBKERsy6OBftqM+B+vpV5JJCvUDkdPdRo0bSNQoRH6J9II3R0BkpTYMz4QOzhpXsj/svDBsyD0uBIEzHFbRiM+ZgA8pSj/Sj8Lu48WRP+JJjl/rB1pTxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(6512007)(26005)(6666004)(6506007)(86362001)(36756003)(31696002)(82960400001)(2616005)(38100700002)(186003)(316002)(41300700001)(478600001)(8676002)(2906002)(5660300002)(8936002)(44832011)(66556008)(31686004)(6486002)(66476007)(66946007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ozK0NWUU1HakxBYVR3TGVQQjBGaERCVFV0aFVIVzVpdnViRGF6NVBMbDRv?=
 =?utf-8?B?TnpmckdkbkhmMWlDMzFnQncrekRscXowRkpRa1h3dmN2Uk5GRnFGb3JpUW1N?=
 =?utf-8?B?QWxhN3BCZXlsb1lBWG1MVUV3Zm1mWlNJS2ladjlhWWYyT1pvb05weXg3NWpZ?=
 =?utf-8?B?OXlDMGh1WndmSm1zWCt2R1RjNHFNVm5zcElBNVZIR25KUWRYMFRPQklhRmsz?=
 =?utf-8?B?bHlLdXBqNGpxalVCZ1Y2bFl2eVAxOFRURzNjeUFBZThGWkxCZEFQL29yTUNF?=
 =?utf-8?B?NTA2SHdZR1c0Q3Q3aktJWFZhWFRhK2x2YnI0cUtuOTkySCtRc3UvZ3FaeG91?=
 =?utf-8?B?a0pZS0R4YVBvWktyM0pQc2QrWjRtb2VOUUt5a2FxVlJjVm9QS3ZoYlFEdnJV?=
 =?utf-8?B?MFNhTGoxQWFGRFdUZWRRM1djcjVtZ0hOMDA0MXEyMGljbDhQdkdQT3pJRFNy?=
 =?utf-8?B?K0hMbU5BRm1lWEJ0RmVJWjVqRDN5WTY4M2tObUlZYml0dXpHV2o2YldYVnlj?=
 =?utf-8?B?OUFNa0xSbkcrWWZEUFhJOEZXcTlIQ3FrVDZhUDZLa1pmMVZWZG9oMGFKZ2Zr?=
 =?utf-8?B?SnFtYmhTYUtZK1VDQzl4MnRna2pQbzJRVGwySGxkN1QzbnFkbnBJUHA4bTRD?=
 =?utf-8?B?SnBhUTZPTmVVOVA2dWlTU09QbjVpYlQrQ1JmdXdULytpQlQvdnFlTS9BbFVs?=
 =?utf-8?B?VlNFdCtxZmE4VkJSTnFFU2tjNXRndURSUnJ6WjhBeDhTYUFDaGo0QTVVd3c0?=
 =?utf-8?B?TDl6Nm44c1pheFl0d3AxZmZ6M3l5blczYm1iazlnRiszYnZIMzdyNEZWZDNJ?=
 =?utf-8?B?enYyUURpUnNkK2ZGQ0FscVpOSTVxakxQSnA5QXgwVlEyQk96YlNOTHl6cGsx?=
 =?utf-8?B?WWVkblRzWmNjdit1eFpOWVVHa2tWMmQveWdTS3pZU0NQNk1seDJMNThycnZO?=
 =?utf-8?B?MVllZXpnQ1lScWJ1cUlkdkk5UzRlbkFXOHlDbzljWUMvRE5vV0JVUXVVRnZG?=
 =?utf-8?B?QWlDQ1diRDBOZnBZa3Vsc0kwVVdnRGxpZzdtZEtvS0d0WnJROXRvMXpORGJx?=
 =?utf-8?B?MVZNdGVUZmt6Mk1heHB6VEN3T3lZRVRSWmFMWm9uWkpIaXc0Y1pTZ3JVLzlh?=
 =?utf-8?B?TERGSFp3bnZVemYwT09yUEFaV0FGZnJJTUZlQVVnTzNGd3IwSGwzWjY1R0RT?=
 =?utf-8?B?bnJTZ0lFNmh1K3JZMkprVGtmV3owcVJFSjcxakZnS3ZkMmwxTXdpVEJtWXZE?=
 =?utf-8?B?MjRFNDJ6R0MxK0tQTnZoQ1lPeDNRSjI2ZkZEaTM5NWVNYlk3dXhYOGdkRWs0?=
 =?utf-8?B?NUtBZ2NvNHN2M3lzK1pVcnV0NTJWdFhML2t0VzFnS0tTdFE5REFjcmVFczUv?=
 =?utf-8?B?bCtYRSsyUDB0a1pyRVhlWGk0MC80bnBnQlpmcDNhU0xYdXhYU041ZFhURXFS?=
 =?utf-8?B?U1ZITXpzZXpGa1N5dGlrZDFROTcyVmdsbGh2WnJrMWNHTVNIcDlPRFVhdzNI?=
 =?utf-8?B?ckpQQnl0d3dMRGQ3YkZmTUk3Q3JtVHBDV2dDdFVzYW5zcGEvOE5sek8rTkdv?=
 =?utf-8?B?enp6NkFzQXV6OEJ0amVTV1IrUG93L2dIUk8yaGpJY2wzcDNPRjdhb0Y5WGg3?=
 =?utf-8?B?K2FBYmEzMlNneVFYQ201M3dKNWJsOVBEdGtlSGNRMjQ1NWJaOTlBY0dYVVQy?=
 =?utf-8?B?VHluWlJONU5NSitlOFd3cElOZUdPaDRQZTBoSDRGbnhpYlNCeHp3c2k4dU1q?=
 =?utf-8?B?dnlzQ1VoMmVsenlPaEpmZmJmQzFrbEMxUC83M0FMMjZSblBLbXFLdVI3SUFr?=
 =?utf-8?B?T2hJMDhocEFFVWVHbWRMNGZweGRlejh1SHh2RVZZQlVxS2VYNFkzQmdrR1Fr?=
 =?utf-8?B?YW8vNHRjckkzamVLbXU2Vng0VHY4MzBPV29yNXZxd1Q0YUlsbzdyUEg5R0Rj?=
 =?utf-8?B?TzltNXVpbEYzZWpjRHhZOEtmN1hwMHBqZGRFb2FQWGFmajU4Uzc1NGdtdDUz?=
 =?utf-8?B?NUxyQ09hYTdJcFo0YU5OSzMyV3FLZ1RCd1VTUzZYUzg5bHhET2tiUEpnOXVO?=
 =?utf-8?B?ZkM2L0lTQ0Q1WlYyV1dmUXpzL0YveGlkZC9HWmFBK0YzdjA5QTVQeFhDeUZD?=
 =?utf-8?B?QWJJU2trQ3oxY2txQngrL2tXM3A2MFRRcjhyU3VOb2ZJYlJhNlFuNDM3RUxv?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81d9449-4e4a-4d92-4239-08daee967391
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 20:58:37.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgKSimulG2wpDCWiiSyawedAXjYFld/9/clxJNRY3fTRUdrhRG6jhRg1BjFQvhVsrqn/4mt/QCtVAGbbMcySJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7110

From: Jan Kiszka <jan.kiszka@siemens.com>

The kernel claims this namespace, and we now collide on timer_delete
with 6.2.

At this chance, drop some inappropriate used 'inline' declarations from
large function used more than once.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/timer.c | 56 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index a58ea99a36..a115ded535 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -43,7 +43,7 @@ void cobalt_timer_handler(struct xntimer *xntimer)
 EXPORT_SYMBOL_GPL(cobalt_timer_handler);
 
 static inline struct cobalt_thread *
-timer_init(struct cobalt_timer *timer,
+cobalt_timer_init(struct cobalt_timer *timer,
 	   const struct sigevent *__restrict__ evp) /* nklocked, IRQs off. */
 {
 	struct cobalt_thread *owner = cobalt_current_thread(), *target = NULL;
@@ -88,7 +88,7 @@ init:
 	return target;
 }
 
-static inline int timer_alloc_id(struct cobalt_process *cc)
+static inline int cobalt_timer_alloc_id(struct cobalt_process *cc)
 {
 	int id;
 
@@ -101,7 +101,7 @@ static inline int timer_alloc_id(struct cobalt_process *cc)
 	return id;
 }
 
-static inline void timer_free_id(struct cobalt_process *cc, int id)
+static inline void cobalt_timer_free_id(struct cobalt_process *cc, int id)
 {
 	__set_bit(id, cc->timers_map);
 }
@@ -118,9 +118,9 @@ cobalt_timer_by_id(struct cobalt_process *cc, timer_t timer_id)
 	return cc->timers[timer_id];
 }
 
-static inline int timer_create(clockid_t clockid,
-			       const struct sigevent *__restrict__ evp,
-			       timer_t * __restrict__ timerid)
+static int cobalt_timer_create_internal(clockid_t clockid,
+					const struct sigevent *__restrict__ evp,
+					timer_t * __restrict__ timerid)
 {
 	struct cobalt_process *cc;
 	struct cobalt_thread *target;
@@ -146,7 +146,7 @@ static inline int timer_create(clockid_t clockid,
 
 	xnlock_get_irqsave(&nklock, s);
 
-	ret = timer_alloc_id(cc);
+	ret = cobalt_timer_alloc_id(cc);
 	if (ret < 0)
 		goto out;
 
@@ -172,7 +172,7 @@ static inline int timer_create(clockid_t clockid,
 	timer->sigp.si.si_tid = timer_id;
 	timer->id = timer_id;
 
-	target = timer_init(timer, evp);
+	target = cobalt_timer_init(timer, evp);
 	if (target == NULL) {
 		ret = -EPERM;
 		goto fail;
@@ -192,7 +192,7 @@ static inline int timer_create(clockid_t clockid,
 
 	return 0;
 fail:
-	timer_free_id(cc, timer_id);
+	cobalt_timer_free_id(cc, timer_id);
 out:
 	xnlock_put_irqrestore(&nklock, s);
 
@@ -201,19 +201,19 @@ out:
 	return ret;
 }
 
-static void timer_cleanup(struct cobalt_process *p, struct cobalt_timer *timer)
+static void cobalt_timer_cleanup(struct cobalt_process *p,
+				 struct cobalt_timer *timer)
 {
 	xntimer_destroy(&timer->timerbase);
 
 	if (!list_empty(&timer->sigp.next))
 		list_del(&timer->sigp.next);
 
-	timer_free_id(p, cobalt_timer_id(timer));
+	cobalt_timer_free_id(p, cobalt_timer_id(timer));
 	p->timers[cobalt_timer_id(timer)] = NULL;
 }
 
-static inline int
-timer_delete(timer_t timerid)
+static int cobalt_timer_delete_internal(timer_t timerid)
 {
 	struct cobalt_process *cc;
 	struct cobalt_timer *timer;
@@ -248,7 +248,7 @@ timer_delete(timer_t timerid)
 	else
 		ret = 0;
 
-	timer_cleanup(cc, timer);
+	cobalt_timer_cleanup(cc, timer);
 	xnlock_put_irqrestore(&nklock, s);
 	xnfree(timer);
 
@@ -273,9 +273,8 @@ void __cobalt_timer_getval(struct xntimer *__restrict__ timer,
 	}
 }
 
-static inline void
-timer_gettimeout(struct cobalt_timer *__restrict__ timer,
-		 struct itimerspec64 *__restrict__ value)
+static void cobalt_timer_gettimeout(struct cobalt_timer *__restrict__ timer,
+				    struct itimerspec64 *__restrict__ value)
 {
 	int ret = 0;
 
@@ -311,8 +310,9 @@ int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag,
 	return xntimer_start(timer, start, period, clock_flag);
 }
 
-static inline int timer_set(struct cobalt_timer *timer, int flags,
-			    const struct itimerspec64 *__restrict__ value)
+static inline int 
+cobalt_timer_set(struct cobalt_timer *timer, int flags,
+		 const struct itimerspec64 *__restrict__ value)
 {				/* nklocked, IRQs off. */
 	struct cobalt_thread *thread;
 	int ret = 0;
@@ -344,7 +344,7 @@ static inline int timer_set(struct cobalt_timer *timer, int flags,
 }
 
 static inline void
-timer_deliver_late(struct cobalt_process *cc, timer_t timerid)
+cobalt_timer_deliver_late(struct cobalt_process *cc, timer_t timerid)
 {
 	struct cobalt_timer *timer;
 	spl_t s;
@@ -382,9 +382,9 @@ int __cobalt_timer_settime(timer_t timerid, int flags,
 	}
 
 	if (ovalue)
-		timer_gettimeout(timer, ovalue);
+		cobalt_timer_gettimeout(timer, ovalue);
 
-	ret = timer_set(timer, flags, value);
+	ret = cobalt_timer_set(timer, flags, value);
 	if (ret == -ETIMEDOUT) {
 		/*
 		 * Time has already passed, deliver a notification
@@ -393,7 +393,7 @@ int __cobalt_timer_settime(timer_t timerid, int flags,
 		 * break the atomic section temporarily.
 		 */
 		xnlock_put_irqrestore(&nklock, s);
-		timer_deliver_late(cc, timerid);
+		cobalt_timer_deliver_late(cc, timerid);
 		return 0;
 	}
 out:
@@ -418,7 +418,7 @@ int __cobalt_timer_gettime(timer_t timerid, struct itimerspec64 *value)
 	if (timer == NULL)
 		goto fail;
 
-	timer_gettimeout(timer, value);
+	cobalt_timer_gettimeout(timer, value);
 
 	xnlock_put_irqrestore(&nklock, s);
 
@@ -431,7 +431,7 @@ fail:
 
 COBALT_SYSCALL(timer_delete, current, (timer_t timerid))
 {
-	return timer_delete(timerid);
+	return cobalt_timer_delete_internal(timerid);
 }
 
 int __cobalt_timer_create(clockid_t clock,
@@ -441,12 +441,12 @@ int __cobalt_timer_create(clockid_t clock,
 	timer_t timerid = 0;
 	int ret;
 
-	ret = timer_create(clock, sev, &timerid);
+	ret = cobalt_timer_create_internal(clock, sev, &timerid);
 	if (ret)
 		return ret;
 
 	if (cobalt_copy_to_user(u_tm, &timerid, sizeof(timerid))) {
-		timer_delete(timerid);
+		cobalt_timer_delete_internal(timerid);
 		return -EFAULT;
 	}
 
@@ -578,7 +578,7 @@ void cobalt_timer_reclaim(struct cobalt_process *p)
 			continue;
 
 		cobalt_call_extension(timer_cleanup, &timer->extref, ret);
-		timer_cleanup(p, timer);
+		cobalt_timer_cleanup(p, timer);
 		xnlock_put_irqrestore(&nklock, s);
 		xnfree(timer);
 		xnlock_get_irqsave(&nklock, s);
-- 
2.35.3
