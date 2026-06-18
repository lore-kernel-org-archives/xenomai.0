Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928B3D669C
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768832; cv=fail; b=lDLjjQnEl1BryNyoi97CI6Mr2W9BQfsHpBJD24Wa4IVwyvp4w/Ac9SawIqtIPLgM5c4u1x4d/8Vx4fqMvgYyWADL+OpE9zle9Eg9+IkRjxzgyT18Z8XWmPGo/GLcBYLsu7Hg90pxud1U5uKp3ctQnS0Xg2wuokIveuUQcVmW0AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768832; c=relaxed/simple;
	bh=ZvyuhEdMN9nk1TPYpTPizTTywhLjJUAJiKGpa/Kqg3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sYZ1/PpoNnvKDeGd8TOOxxzjiDmi2c6L7D3wTr2CxHh7nLglohj8SkMQu9Lzu5igHmILnzsVg10YlBmTotfZaCDED8m7b8HZgYpCU8sBVqIAnIThixYsyn2W58MvFqRdCNPVBO/m9lt15MPWGVIvqEzq5iTvQ0gKOsGKDR3o6H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=D15TT2F3; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="D15TT2F3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAoUWMdSgAAUiDyiXnf1HyrhiPUj1bBMTS5mSu91niy3XaDcHHP+5YlPlqWFzNx/autHLRv3tQ9wMiEGgZy5DVLec5PydDWdVVgcok4TwyZX8JvR96fJ9BZ+ZSzqJGOC2cL5OsQN7N+G4LARAimOzA+USrK4VgHYRg48cqYJG1SrseDlh+zBydsb7ntJhnHilD9aBkFWdSexj7Cy9vHunVLbnntOswj8j6MjE+2EGlBV5UyLkpjZ3yrUPE+D+aNy95pyf/MEJoBKj8OgzjTRzOC6fcj36De9rSLzjjGtfvoGBD6ZAESMpx/axHimZILbO6hDbNVw5wZrtD/emwUuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6ubG48759mmFJS/ssGc/X9NnLSkHu3vwxZEbfHWAaA=;
 b=Ud/LjFobT3KJadTazrt77QNyTEnzKc9SGLM91a5nBlF1D42JLTdSlzfYMDTf6L+BiEeJqp5RZVxR543EvcREGYJu2l3/FNrzuoKqN+ewmgeZYad692c6/FxhPJZY6br1i9E1o5ljctd79o34rNiTUSD4+j1iG5/aHYuJq1C7m2EJgtjioNb3E7tNpObabNe9u3rPRU1ZIuSBmW9nUEhKH5T2ssrUn2OQaI79fvku5vMHCvwPBzrwdgsnqx7z1nxYEihDco0PlSgAflgTSo8NbX5BpJseRhcP+iKd4IaIM8jbc9gjTQoK0CHyqSKXJSKKXFTr0jayPVBUTRrysBOeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6ubG48759mmFJS/ssGc/X9NnLSkHu3vwxZEbfHWAaA=;
 b=D15TT2F3dUhixGdsL1zhPjwfSKDGLLPfI0gPZW6DcjFzW5mfxVALHWsyd0CaYtPnwH+zIvBYUfuNN1+wMNCiXcivaF4ZqC/Wizwxj4TSaiRWBlkjM+yf9XdItl0OJQ38c3cgFEZ8H+X48sHY5XhzoG4Et9iTwDXhum5HesOjFt8ncyfINooqO+t3CdsA289L52T3TwbNBrVyLhroKpqkcoZqrl1Lj60lB+nW9oseUbqhGzSZoHavXH7pZw/7oJcis+97BLEHGwR4WhdfERvaRu6SlzkhDjzC4cTX1jwBGFlW7QDss8XoLVf4nuY7BWphk+O3tBiunCJFtOjaXylTRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:47:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 07:47:06 +0000
Message-ID: <ce854c70-3f03-4393-81b7-813444280606@siemens.com>
Date: Thu, 18 Jun 2026 09:47:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] evl/sched: core: introduce schedule out handler
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260617142050.477809-1-rpm@xenomai.org>
 <20260617142050.477809-2-rpm@xenomai.org>
 <c7f75276-309a-4ed6-91b0-7df82ae8c59d@siemens.com>
 <87ik7gs367.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87ik7gs367.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:335::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: fa78f066-5e81-485e-c382-08decd0dcb6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	9U5AVStccVpOgRba/e5kcfDoFJflkxcS8qYw7ShDaqpR3pPL3Vr2x+dXy25LabUr4DQoAP78783MpzAM0+2Hz2es2hbAsoJU6LhNhC0mHICh41+7JyDxLIesbzLSkpDzrGedLnwL4YMEF1gpFiXCXbhH/RYmyPhfUqnI8kRGtuc9Noi/2WxPGWkln16chiBUEqibjTJE9L6iBuPPwzQwJFiA+5WIt/Dhy5iPtkOFPWPAFZO56dWHOxc+VRlbAI4EFzmZadiHqnhGBarc1SwttG2hNyyYGXU9GN2C5+6dWYUpNADR2XMbVTe355L/pDgBIxXqyLq06nbVBqM6Cu8uACFmcsTN3q424Fu5Qy9jX/TE4NxMzApOCm2G0LeGPcI9e75HZBNdyEPrgXi6/y7ijiAYKCUmkrqVIhMBH6x8CLSwog7avRj7y4pu+RKA/7BZNUfIVAmuxkq/SjAerTYqHdyaBNU+bgRj+R9t9+GFuFvK3VepHpWAI1zrTB2GIaWteNuoBklLzMo8EqJFbehyUR+ucnAzSYAhvEfift+HIu1ujq3OEZjOkV1pKykJR6ONXrIHN9uUblhLMMV6WvMNl4ftNYu335Av0TQWEwyJ9mX3AFHoXCsHR+LzFiozQ548lk7MDHMLNFqIQDtTDVgrRdhTX7Q4bu/sVIHoiDBtyaoxd3XZWnrqEQBNG9tEQzmf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW8reFd1RVpUajN2T2V3dXpLaXJSb1E4c1o3T1d3VmRzamxibWtOaEtEUElu?=
 =?utf-8?B?MStCeXZkbnRESGRWcFJEenpSTU85dDcyMnJsTGhTVklLTGorME90akpNQ2VD?=
 =?utf-8?B?TnQ1aXF6eS9odFRPUHBRNXVCWUlzK0ZuNnhkZ0Y3QkV3WmltMklQWGI4MU9U?=
 =?utf-8?B?enAzeFFuNDNiMnBKTTRCR2o5dmwvVFB5eHlkUEEyaGwxRmdqc0w1OUx6Tk83?=
 =?utf-8?B?aFRDZ241M3Ivbnc1aUZjZCtuY3BQeEQ0QVBjVkovYXF3Tk5VSCtsYThnYUVQ?=
 =?utf-8?B?TmFXQjlsaVlWNHJwSTYwS1hQcXV1MFhGUzNJMWFFQlJXaE81NlJxTkNjcnQz?=
 =?utf-8?B?cUg0enRlbDdYVjUwWmFrWEEreTRJaXpFUlBLdGo0QUNiZkptMHFKSWd4ZnVy?=
 =?utf-8?B?aWxrWlZQR0p2MGZPeW1LY2RrVk1CTGRZOHZkSXBna0FCYzN6MEpkai9ScWty?=
 =?utf-8?B?RDB4MDUyN2tGUERZemw2OEVvTDZXUUg3QVAzQ29zRnZLTVVaTlltamh1Y0g5?=
 =?utf-8?B?NTVjY1g4cE56YmpYNHFQYkpNa0xKcHRNdkdPaEVsZkgyU0FzNEhOeGE3MXNY?=
 =?utf-8?B?K3BFbEF6MEVxaHcwYlc1UThOUVFZZHJLUDNRRHVRclkyOVFkVnIvTFVlY2ZU?=
 =?utf-8?B?VVRLOHh2VnAwUlZvekJseHpTTnpCQmh1M1JXV0s4R0JSYzE3U0x6NzN6d1A1?=
 =?utf-8?B?YjhYa1BTRHI2UWpaQ3FER09rZTRFRjdOZ0dsSGFqd3EvT1BUaWNKSFoxTTZI?=
 =?utf-8?B?NmFqTUc4dWFWbytzOGJEa3ZURENkckdIRXFkK01BQXIwY2hpYk5VdjhKVjdW?=
 =?utf-8?B?bitIUkdESEJoOTZkTmV2YjdXYzN5QXdDTkh6b29oODZyaGl3YjU0Y3FzNWhk?=
 =?utf-8?B?UmxJcFlCOVBDeHdTQyswS3cyOW5wckdGc0R0T3RqSTVZK3hraTZTWHRGZkdW?=
 =?utf-8?B?bnlkUGE1amRYTWoyTlpvRlU1Q0owYk9PMFpXQUt2cDBQQUg3cURVeFN2VUg0?=
 =?utf-8?B?L0RpUmUwSHh6RHdpSzRjMlpVcGlIaENESTAvVFpHMjdDTTRCdG91WnZVblJZ?=
 =?utf-8?B?bDN5ZldwNUVyTW5MTjhZYjF5Y2FYdmQyU1BCbWlQRTczY1pwd0NRM2RnUVBT?=
 =?utf-8?B?a1F0dlRLOHNRWkVTcStxUStGV0dMMVFJaFZCKzZmUGVGeVk2NzIvelBVQzlC?=
 =?utf-8?B?aG1XV2lNYU9CY1pGWVJkRWV1dTVmY1VMRHBkcFF0Zm5URWxnTU56Q1lrdGlU?=
 =?utf-8?B?eXlHeUhZTnowa1B0d0ZhQkRsbEU4WGRBaVdKM0ZmZTkyTkRYT2RVcHNkOHRl?=
 =?utf-8?B?b0VSM3ozbmk5RUU1SlAwV0M1U2xoRzBRN3dpRTJHSUI3dU1oOFNlQUU0TmRm?=
 =?utf-8?B?YmhuSGVGMkJpTlV1L1hCYVRtakRYcFEvaWwzRTl6UXBEdW1reThGZlJZUjFz?=
 =?utf-8?B?UnRmOU0xaVRhRXk2OC9PcS9nTHRnZktRd0xGSVhEc0YzZ1VaVnhYSnNCT2xl?=
 =?utf-8?B?bEptRjB0RFRrWjVPd01xdW5sQkc1ck5zUWNhU3F5WDNuWkxLa3o5QkwzWW1X?=
 =?utf-8?B?WTdaMnM5cW12MjJzTCtlQTVZbGF4MXl0VWFIM01DM1RNRUhPK3hnSFA5Q2Vx?=
 =?utf-8?B?RGFzbUR4SXE5Y0Z4VTJpRHc1TlM4Z0VFUEEwYkFpWUl6SHlQMzdIZVRZZmEz?=
 =?utf-8?B?Nk40eWtEUkV0bEVwR25NbGNCcE5ML2UwdWxob2NBejdVWi9mNnp1R3c0blRV?=
 =?utf-8?B?anJ3UUpELzlMdmN3c3Q3V1hwSis0SXhyY1ROWEpOZk5UY2lxWnlhMmhXdlo1?=
 =?utf-8?B?OHN4TWx0TDhjUmdWMTBOalF5Y01SSUtCV1FsVlZ5SFJRc0c3NnpxT0FhVGhk?=
 =?utf-8?B?cDAvN0VkVmQ3WFU2NEk3M0xJbjBuSWY3WHR6b0xUaGRyVHVucHE2eWExemkz?=
 =?utf-8?B?VGVNMEZJeEhJR1RDb1RGRFpVQ3Q4RjRKLzEwRkQ3TVFhNGdRUzFNQS9CbkNQ?=
 =?utf-8?B?c28ydzBPelFxeUNxbnJWWG5qT2VkQkRLeDZyNHRBQUg4RWhqcEhkT3laeUlU?=
 =?utf-8?B?bUtNUlBlczVaKzZVUTJMY2YxWS9OdThZN21lRmZxMkNpRTdKb3VVL29tdTh3?=
 =?utf-8?B?WkIxUk51RUlDMDNEYXR3SWQ2YUxPTmRxa0RtZW1PR1ZpNURvNTk2UU5oSnB1?=
 =?utf-8?B?UnJFYWlLek9KRURHcVg2NGdsZGNSZlhvZFZCajZHV2lYT2JlTGk4Vm5jRVBq?=
 =?utf-8?B?SVZORy9iMEFhdGFVRngxZDBOWUtsMEhpdzRZaXhKeDRINHBKVnJQeU9qbDgr?=
 =?utf-8?B?RGRaNGZaNFZtMUpkQzNqNnBtSUYxa0Rzbm0wUFhWK05vZE1SMGxWdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa78f066-5e81-485e-c382-08decd0dcb6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:47:06.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nh8Rvcc6JKgG9jtW7HiC7Wt9rbX52frXyII52DSQ+0z8AhfTxX2GvAA6RufDr33phP/gTlYXB1H5OjxB4lNu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7672

On 18.06.26 09:44, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 17.06.26 16:20, Philippe Gerum wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> Some scheduling classes may need a way to perform specific
>>> fixup/accounting work for a thread which is being scheduled out.  We
>>> cannot rely on the sched_pick() handler for this since the first one
>>> to successfully pick a thread prevents other handlers down the class
>>> hierarchy to run.
>>>
>>> To address this issue, we introduce the sched_out() handler which is
>>> called for the current thread when scheduled out. This handler is
>>> invoked unconditionally when present prior to picking a new thread.
>>>
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>  include/evl/sched.h     |  1 +
>>>  kernel/evl/sched/core.c | 20 +++++++++++++-------
>>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>> index ae9690860146..cc824c28004b 100644
>>> --- a/include/evl/sched.h
>>> +++ b/include/evl/sched.h
>>> @@ -120,6 +120,7 @@ struct evl_sched_class {
>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>> +	void (*sched_out)(struct evl_thread *thread);
>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>  			      struct evl_rq *rq);
>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>> index d1d025e06a5d..7127d4e52df9 100644
>>> --- a/kernel/evl/sched/core.c
>>> +++ b/kernel/evl/sched/core.c
>>> @@ -773,7 +773,8 @@ static inline void set_next_running(struct evl_rq *rq,
>>>  		evl_stop_timer(&rq->rrbtimer);
>>>  }
>>>  
>>> -static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>>> +static __always_inline struct evl_thread *
>>> +__pick_next_thread(struct evl_rq *rq)
>>>  {
>>>  	struct evl_sched_class *sched_class;
>>>  	struct evl_thread *curr = rq->curr;
>>> @@ -821,8 +822,14 @@ static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>>>  /* rq->curr->lock + rq->lock held, hard irqs off. */
>>>  static struct evl_thread *pick_next_thread(struct evl_rq *rq)
>>>  {
>>> -	struct evl_thread *next = __pick_next_thread(rq);
>>> +	struct evl_thread *next, *prev = rq->curr;
>>> +	struct evl_sched_class *prev_class = prev->sched_class;
>>>  
>>> +	if (prev_class->sched_out)
>>> +		prev_class->sched_out(prev);
>>> +
>>> +	next = __pick_next_thread(rq);
>>> +	trace_evl_pick_thread(next);
>>>  	set_next_running(rq, next);
>>>  
>>>  	return next;
>>> @@ -972,21 +979,20 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>  		return;
>>>  	}
>>>  
>>> +	prev = curr;
>>>  	next = pick_next_thread(this_rq);
>>> -	trace_evl_pick_thread(next);
>>> -	if (next == curr) {
>>> -		if (unlikely(next->state & EVL_T_ROOT)) {
>>> +	if (next == prev) {
>>> +		if (unlikely(prev->state & EVL_T_ROOT)) {
>>>  			if (this_rq->local_flags & RQ_TPROXY)
>>>  				evl_notify_proxy_tick(this_rq);
>>>  			if (this_rq->local_flags & RQ_TDEFER)
>>>  				evl_program_local_tick(&evl_mono_clock);
>>>  		}
>>>  		raw_spin_unlock(&this_rq->lock);
>>> -		raw_spin_unlock_irqrestore(&curr->lock, flags);
>>> +		raw_spin_unlock_irqrestore(&prev->lock, flags);
>>>  		return;
>>>  	}
>>> - 
>>> -	prev = curr;
>>
>> This hunk subtly look like a pure cosmetic change, without any logical
>> impact. If it does have one which I missed, it should be explained in
>> the commit message at least.
>>
> 
> It has none, as mentioned earlier in a previous post. The point of this
> change is to clarify the naming, introducing 'prev' as an alias to
> 'curr' in the swap sequence. So there is no point in documenting this.
> 

Again, it is suboptimal style to fold refactorings into logical code
changes. If you split this up into two commits, properly explaining the
purpose of that renaming, things become readable to 3rd parties.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
