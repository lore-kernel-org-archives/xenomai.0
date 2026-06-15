Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A72ECE93
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512809; cv=fail; b=OZLvfUq7ug74ewq4TEa3//55SCC1e6Nz1J/cM3l8ex6CAaGxgXQoxeHAAOra+rEdQfLjVZ1gXcSRW+wDz6lBF+/VpTtU6d09KNkdGufDDP70NnUUEn8ohVxpOUYQvkT4PiosKftqY5k0I43R+EIE/qWEt5ZqKiZCiI1VY9G5fSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512809; c=relaxed/simple;
	bh=m3no7hR0LmgBaKZor9HSja3R7Ur/NmhGC6IJ5aQFHsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gel3wW0FEuyWOOcJiewtOUhbtrWWLhTTGo7BEmXjWlP6kdjkkxBeCdKpbxZbax/T/OpdPT/KGE4IJclyn9Xw97ou92yVKzTSYKiXCHhTGSKzZILPbGODZzsCXSPzqcWPXzGhnAKzygV6T4KivUNn+BelQre9p5DWU0/htmAFWtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CGAmdX1A; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CGAmdX1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl9HGCB/6g/+E2IfC8b2KSTmVaOO7m9uLYa3/8BS7Xrpg1TOdnk91M+xfg+qnt5wP/+95oAEVinSN33Znj6oGeRFBAMr0zRvm6JFTtWO9mwVyxeNk8wZzVDdbrJkm9PF5jQc8/NfJCNp91lCRn5sAIxR97qJKnjUAUY7orWMFaw76dH2dvtJBeB1fhen3v+/obDFhwJdfv0MkD6FOFd5u7kiYwqeiq3ZGV1nFQ3/dzTdAInc0XgBoexgN61F+DCqpxcmIqp3YupUINXTixKnKYSJDAQUsStNqbGa5s+KUR1oWz/thCzbEKyE+qImwdmPEl76kgtabfy6idg3MuaQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cghM+jrnjvj22nPK+dMqBw3pObKaqCvhL9/xtIB7fbs=;
 b=wL11Y+Tp6tTJ4jdEE5hHTZifKVvpXwbwCNKHdyKSlKuvw1h6h4RSZ6S/pacbdAHtVOWK4VIOEwxzNaxkRE2vKNsEf2qCpSuLxiye99loCOz099guDEqDX5+6wjvEAV0WlnmqLaczNNH401WGmhAvHo8J2yoBktdNalimGTHUQZly/VsW5JP2JO4UXvTamztr8dS231TsKQwRdMR94EvWPVyuCLzmZ2rKQujBSgQ0AS+sDhntgs4cteIIvnhtRrPD0JYC8xQkU4XKAWagz3f8COXb0Su0LUSKBbkVAsqfxUVz8445JdhzCDr8s4FHuPDya9o5E/s6VqRfNsmJGh44mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cghM+jrnjvj22nPK+dMqBw3pObKaqCvhL9/xtIB7fbs=;
 b=CGAmdX1A1l5GhYCK83VqBlFiOODbXA386Cx4OAETCD1mHGp1zWcQcqbNS5ABo2Gfdh0dk5OndFTcnQrhaOrXT1tEprFhWHdo0ayK3oSPmwKwGXoK8pq33Lis0RPnHj7fiduiezLxXSKrSQ3r36fW0ac/6T+9BjF3yXq89tEr9fWFYYzthFy01siadeZKgCr5vcVyFU8yfA1tsWRFe0eGj0IzJB6SIJV3p0GWmpM68uKiQDaqW1rkuUzLUvAM5I9ldCnt59mH9r1/OHvFtBFHbky3QjjHm/QK2KxD8pj+tsoMnkH6wIxu5vGyrE1ABu+PoaDucqNE/fKQ9fBWQOlUvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:554::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:40:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:40:02 +0000
Message-ID: <0b5c0904-0e02-4c0d-b95f-6da9b4465965@siemens.com>
Date: Mon, 15 Jun 2026 10:40:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
 <87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
 <c3ba6b74-6a07-458b-9b5a-255eb9853183@siemens.com>
 <87o6hcfcn4.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87o6hcfcn4.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 043599f9-9061-4e90-5459-08decab9b0ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|55112099003|56012099006|11063799006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VjQKV4RHhSuftbPVOzjlWvU/L9J6UCF98hY/KF3BhjkFpmXs2HGj1OlCptcmLE8rKOx+kGHaL10aTNpFUyScIMCu3L6onZxvKJfZMuMuhsZp+n4nlkoj/71S1FDTvVWrWGbBWMwU+5wuhNHYGzPdC748maixs0MU4LhX/bPEHajj9aTlj8uK4mCb+1JX+f3zLShYoquTocQxU7Ptq3BF1aGVB/emTLTkjlgJUGa+csST+xuPEhbZS2QvmRcWoS1PLDQlIEi4poMwr7GG7j5nPhsXkf9b1v3CJ+ehrKiyxoYONbk+LzrXrsrjw17fd/A1yJ/XpoVcWVo7HGgSCrM8P29TYRvhhQbBBK+6wMR3X4+Oxko5QfBIRsH8ci62sN69wUtE8SHFuWzQaOqcQD8VcIGXloLwLdJnpWYIMK3bKYxfgEA7DAw7zxbh5aFqvIecVWTcFIdlx1OfwhlWYTmotkrTlRyNWuOFlXVS5wMSqwsxWAJZDCnkuVNtJtY2PObfYS8CQVnr15lMenRdwsoyGJ7MsFbI06C9f9+fNBNm2jVAs+301UV3C1Sm8tAfJ5sdrGQGhHS0rMPuMLLo9aA5NOElOgOZrvZDokFCq4q2yGmDJfiMcrA2AdKTfib76w68GGeOf87btT6/6/bRX5BFgWGsyeOTkz3srYap9XexTuohVJ0fmjhDw8OBoew6CTPc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(55112099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW5vQ2pIUFdCVDJCUEQ5Tkc4Y3dSc3ZjcS8wc3ZXci96TjM4SWRLZG9UTnQr?=
 =?utf-8?B?OFBpcDNGNzZkMzRBQWxWUithVXlucjIrMXFkTzhIblplZE9EdzRldTVJcVVw?=
 =?utf-8?B?VkMySkpyMlY4VGhpOURla0ErWGJHbVMwQ083V2J2WDFzSnNWWlp3MVpNYmM3?=
 =?utf-8?B?YWViMTVRbzl2Y1FqaVZEcFlqVVpscVdtcjlaVHI5T0l1by9NbFJIM2ZsYy9P?=
 =?utf-8?B?K2NGMWlSTm9PMXBxNTAybEw1T2ZqOXJ4bkxoR1ZxN2F1ZkxCclBsYW9FWjJM?=
 =?utf-8?B?MTRFQ05GNlF6VjRrbFdERE81bWkyQTlMajdPWDdoSVVoMFhUOHNKWTJsTERE?=
 =?utf-8?B?YzB1NnRPRFpvWXZiMGdiRzY4TFVGUlo2Q0Nsa0RKd3B4bnlBb0U5ZEY4dXJR?=
 =?utf-8?B?Mjl0WktKVElGbG83UHd4YTIvb3NJTmk4SkNWQk1pTzF4emdEb2dNdzJTYVFB?=
 =?utf-8?B?VHVQOHI2S21TSlJqbGpGektaOTJSZjZrRWE1WXBNbW8wSDBZN043UjNFKzkx?=
 =?utf-8?B?N2QwanFWNGQvLzF2RmtYNEFVclBZRmUwTzR5bE12KzhDZENIUGdFM1N1b3N5?=
 =?utf-8?B?bWwvNHlFODRkMWV2dlhQSWppUE5GN3d6WkN0RDA0UmpwbWpCdjArWDZUOE9y?=
 =?utf-8?B?YWJFRzlQNVI3a1FLamUrMk9pVEx5NnRnVDkrckFta0grczJFMkprK1FDU3ht?=
 =?utf-8?B?NkxsbDJ1MUt1cUp5T3BWOFN6NWd1c0VQbDlkbytNTGRtckRPZDZzdkVXTzB0?=
 =?utf-8?B?enZSbytTOFNxYVg0L3hwT0h0dHBFT282NERZY1cxOXliQ2dYNElBSXBUM0F2?=
 =?utf-8?B?LzExTEVlZk1xdFpweVA1Q3docU5Jbm5LSUdWS1ZjTnh3VUF2QXFFMkV5SVBV?=
 =?utf-8?B?Y0Vhb0NlYWZ1UDlRcXlLdVIrY0dmMEdmNDMrMFl5U0l6M2pYY0FTRzZGUERO?=
 =?utf-8?B?dU9FRzdoQjNWVnBMYXFlZ0RPTTV6NExBVFhXRVhSWGM3YzN1OFdTNktRbVhr?=
 =?utf-8?B?OEhneHVuYnlhdFZpem1HODkrZVFXNkJLYUFZWU5hRkNCRU9JbEFldGhLTTJB?=
 =?utf-8?B?dVBRTHNzc1VEbzV3QXVqbjBTby9kQlpnbmZIL0EzMGNlQzdsRXEyeHBQSW14?=
 =?utf-8?B?OThiTmlZNHlUdlhTRVpzM1BLMVA1K3AyQUFkRkRvaitMZlo3MFFGWTRjdUFp?=
 =?utf-8?B?amRPOXR4ZXBvbzlNNU1KdXhYRTFNN2VCdEdqMEVSbEdGRmkyTWVZVG5rNE5L?=
 =?utf-8?B?aUM3SFF2cXNVQjZueUh0N0FXUmpZSVVwTDJYQlNTd1VNQktjWGsyNUlpUEZP?=
 =?utf-8?B?emUydVVrY09Dbmw3MHVsVjFYVThJUFVuMkMxK1RiV3hrT3QveGhhRTRLMVNz?=
 =?utf-8?B?dG1rT0Y5ZENaWU4vN1ZtSGhyU3BPQ1BaUFcwSWxmT0huQVVHVm5OUVZpTmZz?=
 =?utf-8?B?WVlZTFdRWE45U3ZoYjA0R3BjZjdoOStDS1NLZTZLaDNGaDFQL3k4bS95NnRj?=
 =?utf-8?B?eTNoUDRiNktOdTAxUXF1SnJjdFgrdnpuTlZSZUF6NHFEUjhNNUd1MmdCOC8z?=
 =?utf-8?B?QU5sVWZwZkpSLzRsUk9ySkQ2bFdQL1pQc1dwbHlpakcrVG5hMWQvVEFMeWIx?=
 =?utf-8?B?QTQ1R2RyNG9sK2k2VmxUY1VDZ1F2ZXBkZG52dTV2aWNNMUhIQU51YTl4a29s?=
 =?utf-8?B?VGs5a2FaZ1VVcUdxTFd4a3c5cFJ3VSt4Y2xOVkQrRVpTRFlYMVFvZG5NU1pC?=
 =?utf-8?B?dDJ4cy8yazQxaHU1T2RQTnFLVWp2NkJQUUIyaEVHZS9JOFF2MXpLV2hHcyt4?=
 =?utf-8?B?WVJjckYwUFVpL08yODF0M3FLeTlzbDg3bXJsMXVDTFYrUUpnTlY0TFh2Vm5S?=
 =?utf-8?B?bVordXU4SElMQ00vRDQ4aGxCSitYWjZ2bjFRcGlWVVpyQWVEcmNTOW5DK1pK?=
 =?utf-8?B?dDU0QzJhWkJnWDluZTFoaFNXTEtvWWJPcXIxVUl6ZDA4T1lmdXk5MjJOQVl3?=
 =?utf-8?B?NWtWZ0h4WS9mTG0yN3FId1JwMStRV1l6MFRla0NIMldFQWYraktWVnlxblp0?=
 =?utf-8?B?aXkyNmpRVlhGdFI3eEtTcy85SkVaKzNpWHBDdHpPbmp0WWVYYmJKTEhGOHRn?=
 =?utf-8?B?ZUZ0Z21LSHdpQjkxRXdNeG9EV3pQdnp0ZEg1cVhzY2RBMlN5UWY0dUlOT2Jl?=
 =?utf-8?B?WVJabjI0UWJRelB5YXRPYlNjMGQzZE5lUnB6dENQWk8xVVl1U0dVZU9Fbndx?=
 =?utf-8?B?SWJLTnJDSjJDR0Ryci9HUUtmc1EwQzRRQm5VelB4TGp3c2Z1RGIxQ2syR3lL?=
 =?utf-8?B?Wm5PcE8xeElXUCs2MzRwRy9Rdk42NG5KNjYyZ2lPV255TTUycDd2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043599f9-9061-4e90-5459-08decab9b0ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:40:02.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKy6N7C3K/FOn3tIHTk4Zqtox/2ZhaFczshGD7gDXGU5AUKoGu1/vgvxB500CiScZlHHzVEM3xUUeI3QMONa+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6373

On 15.06.26 10:09, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 15.06.26 08:42, Philippe Gerum wrote:
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> This shall be invoked before a thread switch, providing both the current
>>>>> and the next thread as arguments. Some scheduling classes may need it to
>>>>> correctly handle their state as the sched_pick may not be invoked when a
>>>>> higher-weighted class is providing the next thread.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>  include/evl/sched.h     | 2 ++
>>>>>  kernel/evl/sched/core.c | 5 +++++
>>>>>  2 files changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>>>> index ae9690860146c..0b16f1b1cf626 100644
>>>>> --- a/include/evl/sched.h
>>>>> +++ b/include/evl/sched.h
>>>>> @@ -120,6 +120,8 @@ struct evl_sched_class {
>>>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>>>> +	void (*sched_out)(struct evl_thread *thread,
>>>>> +			  struct evl_thread *next);
>>>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>>>  			      struct evl_rq *rq);
>>>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>>>> index eb133e334d30f..0d49fc16bd67e 100644
>>>>> --- a/kernel/evl/sched/core.c
>>>>> +++ b/kernel/evl/sched/core.c
>>>>> @@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
>>>>>   */
>>>>>  void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>>  {
>>>>> +	struct evl_sched_class *prev_schedclass;
>>>>>  	struct evl_rq *this_rq = this_evl_rq();
>>>>>  	struct evl_thread *prev, *next, *curr;
>>>>>  	bool leaving_inband, inband_tail;
>>>>> @@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>>>  	this_rq->curr = next;
>>>>>  	leaving_inband = false;
>>>>>  
>>>>> +	prev_schedclass = prev->sched_class;
>>>>> +	if (prev_schedclass->sched_out)
>>>>> +		prev_schedclass->sched_out(prev, next);
>>>>> +
>>>>>  	/*
>>>>>  	 * Careful: we _must_ have updated this_rq->curr before
>>>>>  	 * performing the rest of the context switch code
>>>>
>>>> I've been working on this lately too. It turns out that we need more
>>>> than this, although this is definitely part of the solution. I'll follow
>>>> up on this issue.
>>>
>>> This is still wip, I'm sharing this early to discuss details for
>>> reconciling both proposals (the hunk in __evl_schedule() is merely
>>> cosmetic, no functional change).
>>>
>>
>> Please avoid that for the final patch. I already had troubles telling
>> substantial from cosmetical changes apart in your lazy-blocking commit
>> (>50% unrelated changes in there).
>>
>>> commit f49dbd63c1389a6b99508ef0da852545b102d1cc (HEAD -> wip/fix-quota-sched)
>>> Author: Philippe Gerum <rpm@xenomai.org>
>>> Date:   Sun Jun 14 12:08:59 2026 +0200
>>>
>>>     evl: sched/quota: fix budget tracking on preemption
>>>     
>>>     Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
>>>     runtime budget of the former is inaccurately tracked. This is due to
>>>     the fifo->pick() handler returning a valid thread, which prevents the
>>>     quota->pick() handler from being called. As a result, the last runtime
>>>     period of the outgoing thread is not accounted for.
>>>     
>>>     To fix this, we introduce a new sched_out() handler which is called
>>>     for the outgoing thread, which the quota policy uses to update the
>>>     remaining budget of preempted threads appropriately. In addition, the
>>>     implementation no longer shares the runnable thread queue with
>>>     SCHED_FIFO.
>>
>> ...and why we need a separate queue now? Please provide reasoning for
>> changes.
>>
>>>     
>>>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
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
>>> diff --git a/include/evl/sched/quota.h b/include/evl/sched/quota.h
>>> index dfe3b7390958..dc8416645da8 100644
>>> --- a/include/evl/sched/quota.h
>>> +++ b/include/evl/sched/quota.h
>>> @@ -40,6 +40,7 @@ struct evl_quota_group {
>>>  
>>>  struct evl_sched_quota {
>>>  	ktime_t period;
>>> +	struct evl_sched_queue runnable;
>>>  	struct evl_timer refill_timer;
>>>  	struct evl_timer limit_timer;
>>>  	struct list_head groups;
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
>>>  
>>> -	prev = curr;
>>>  	this_rq->curr = next;
>>>  	leaving_inband = false;
>>>  
>>> diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
>>> index 0829da711a66..14748e3a843e 100644
>>> --- a/kernel/evl/sched/quota.c
>>> +++ b/kernel/evl/sched/quota.c
>>> @@ -12,45 +12,35 @@
>>>  #include <uapi/evl/sched-abi.h>
>>>  
>>>  /*
>>> - * With this policy, each per-CPU runqueue maintains a list of active
>>> - * thread groups for the sched_fifo class.
>>> - *
>>> - * Each time a thread is picked from the runqueue, we check whether we
>>> - * still have budget for running it, looking at the group it belongs
>>> - * to. If so, a timer is armed to elapse when that group has no more
>>> - * budget, would the incoming thread run unpreempted until then
>>> - * (i.e. evl_quota->limit_timer).
>>> + * Each time a thread is picked from the ->runnable queue, we check
>>> + * whether the group it belongs to still has runtime budget.  If so, a
>>> + * timer is armed to fire when that group has no more budget, would
>>> + * the incoming thread run unpreempted until then
>>> + * (i.e. quota->limit_timer).
>>>   *
>>>   * Otherwise, if no budget remains in the group for running the
>>>   * candidate thread, we move the latter to a local expiry queue
>>>   * maintained by the group. This process is done on the fly as we pull
>>> - * from the runqueue.
>>> + * from the ->runnable queue.
>>>   *
>>> - * Updating the remaining budget is done each time the EVL core asks
>>> - * for replacing the current thread with the next runnable one,
>>> - * i.e. evl_quota_pick(). There we charge the elapsed run time of the
>>> - * outgoing thread to the relevant group, and conversely, we check
>>> - * whether the incoming thread has budget.
>>> + * Updating the remaining budget is done each time the EVL core
>>> + * schedules out a thread undergoing the quota scheduling policy,
>>>   *
>>> - * Finally, a per-CPU timer (evl_quota->refill_timer) periodically
>>> - * ticks in the background, in accordance to the defined quota
>>> - * interval. Thread group budgets get replenished by its handler in
>>> - * accordance to their respective share, pushing all expired threads
>>> - * back to the run queue in the same move.
>>> + * Finally, a per-CPU timer (quota->refill_timer) periodically ticks
>>> + * in the background, in accordance to the defined quota interval,
>>> + * replenishing per-group budgets, pushing all expired threads back to
>>> + * the quota ->runqueue too.
>>>   *
>>> - * NOTE: since the core logic enforcing the budget entirely happens in
>>> - * evl_quota_pick(), applying a budget change can be done as simply as
>>> - * forcing the rescheduling procedure to be invoked asap. As a result
>>> - * of this, the EVL core will ask for the next thread to run, which
>>> - * means calling evl_quota_pick() eventually.
>>> + * NOTE: forcing a call to the rescheduling procedure is enoiugh to
>>> + * apply a budget change.
>>>   *
>>> - * CAUTION: evl_quota_group->nr_active does count both the threads
>>> - * from that group linked to the sched_fifo runqueue, _and_ the
>>> - * threads moved to the local expiry queue. As a matter of fact, the
>>> - * expired threads - those for which we consumed all the per-group
>>> - * budget - are still seen as runnable (i.e. not blocked/suspended) by
>>> - * the EVL core. This only means that the SCHED_QUOTA policy won't
>>> - * pick them until the corresponding budget is replenished.
>>> + * CAUTION: quota_group->nr_active does count both the threads from
>>> + * that group linked to the runnable queue, _and_ the threads moved to
>>> + * the local expiry queue. As a matter of fact, the expired threads -
>>> + * those for which we consumed all the per-group budget - are still
>>> + * seen as runnable (i.e. not blocked/suspended) by the EVL core. This
>>> + * only means that the SCHED_QUOTA policy won't pick them until the
>>> + * corresponding budget is replenished.
>>>   */
>>>  
>>>  #define MAX_QUOTA_GROUPS  1024
>>> @@ -61,15 +51,19 @@ static DECLARE_BITMAP(group_map, MAX_QUOTA_GROUPS);
>>>  
>>>  static LIST_HEAD(group_list);
>>>  
>>> -static inline bool thread_on_quota(struct evl_thread *thread,
>>> -				struct evl_quota_group *tg)
>>> +static inline bool current_on_quota(struct evl_quota_group *tg)
>>>  {
>>> -	/*
>>> -	 * Check whether @thread is running on some CPU, and belongs
>>> -	 * to quota group @tg.
>>> -	 */
>>> -	return thread->quota == tg &&
>>> -		!(thread->state & (EVL_T_READY|EVL_THREAD_BLOCK_MASK));
>>> +	struct evl_rq *rq = tg->rq;
>>> +	struct evl_thread *curr = rq->curr;
>>> +	struct evl_sched_quota *qs = &rq->quota;
>>> +
>>> +	if (curr->quota != tg)
>>> +		return false;
>>> +
>>> +	if (curr->state & (EVL_T_READY|EVL_T_KICKED|EVL_THREAD_BLOCK_MASK))
>>> +		return false;
>>> +
>>> +	return evl_timer_is_running(&qs->limit_timer);
>>>  }
>>>  
>>>  static inline bool group_is_active(struct evl_quota_group *tg)
>>> @@ -82,7 +76,7 @@ static inline bool group_is_active(struct evl_quota_group *tg)
>>>  	 * runqueue, in which case tg->nr_active already accounted for
>>>  	 * it.
>>>  	 */
>>> -	return thread_on_quota(tg->rq->curr, tg);
>>> +	return current_on_quota(tg);
>>>  }
>>>  
>>>  static inline void replenish_budget(struct evl_sched_quota *qs,
>>> @@ -134,10 +128,10 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
>>>  	} else if (tg->run_credit) {
>>>  		credit = ktime_sub(tg->quota_peak, budget);
>>>  		/* Consume the accumulated credit. */
>>> -		if (tg->run_credit >= credit)
>>> +		if (tg->run_credit >= credit) {
>>>  			tg->run_credit =
>>>  				ktime_sub(tg->run_credit, credit);
>>> -		else {
>>> +		} else {
>>>  			credit = tg->run_credit;
>>>  			tg->run_credit = 0;
>>>  		}
>>> @@ -150,8 +144,8 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
>>>  
>>>  static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled */
>>>  {
>>> -	struct evl_quota_group *tg;
>>>  	struct evl_thread *thread, *tmp;
>>> +	struct evl_quota_group *tg;
>>>  	struct evl_sched_quota *qs;
>>>  	struct evl_rq *rq;
>>>  
>>> @@ -167,7 +161,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
>>>  		if (tg->run_budget == 0 || list_empty(&tg->expired))
>>>  			continue;
>>>  		/*
>>> -		 * For each group living on this CPU, move all expired
>>> +		 * For each group pinned on this CPU, move all expired
>>>  		 * threads back to the runqueue. Since those threads
>>>  		 * were moved out of the runqueue as we were
>>>  		 * considering them for execution, we push them back
>>> @@ -178,7 +172,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
>>>  		list_for_each_entry_safe_reverse(thread, tmp,
>>>  						&tg->expired, quota_expired) {
>>>  			list_del_init(&thread->quota_expired);
>>> -			evl_add_schedq(&rq->fifo.runnable, thread);
>>> +			evl_add_schedq(&qs->runnable, thread);
>>>  		}
>>>  	}
>>>  
>>> @@ -195,7 +189,7 @@ static void quota_limit_handler(struct evl_timer *timer) /* oob stage stalled */
>>>  	/*
>>>  	 * Force a rescheduling on the return path of the current
>>>  	 * interrupt, so that the budget is re-evaluated for the
>>> -	 * current group in evl_quota_pick().
>>> +	 * current group in quota_pick().
>>>  	 */
>>>  	raw_spin_lock(&rq->lock);
>>>  	evl_set_self_resched(rq);
>>> @@ -221,6 +215,7 @@ static void quota_init(struct evl_rq *rq)
>>>  {
>>>  	struct evl_sched_quota *qs = &rq->quota;
>>>  
>>> +	evl_init_schedq(&qs->runnable);
>>>  	qs->period = quota_period;
>>>  	INIT_LIST_HEAD(&qs->groups);
>>>  
>>> @@ -337,8 +332,8 @@ static void quota_forget(struct evl_thread *thread)
>>>  
>>>  static void quota_kick(struct evl_thread *thread)
>>>  {
>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>  	struct evl_quota_group *tg = thread->quota;
>>> -	struct evl_rq *rq = thread->rq;
>>>  
>>>  	/*
>>>  	 * Allow a kicked thread to be elected for running until it
>>> @@ -347,7 +342,7 @@ static void quota_kick(struct evl_thread *thread)
>>>  	 */
>>>  	if (tg->run_budget == 0 && !list_empty(&thread->quota_expired)) {
>>>  		list_del_init(&thread->quota_expired);
>>> -		evl_add_schedq_tail(&rq->fifo.runnable, thread);
>>> +		evl_add_schedq_tail(&qs->runnable, thread);
>>>  	}
>>>  }
>>>  
>>> @@ -358,79 +353,82 @@ static inline int thread_is_runnable(struct evl_thread *thread)
>>>  
>>>  static void quota_enqueue(struct evl_thread *thread)
>>>  {
>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>  	struct evl_quota_group *tg = thread->quota;
>>> -	struct evl_rq *rq = thread->rq;
>>>  
>>>  	if (!thread_is_runnable(thread))
>>>  		list_add_tail(&thread->quota_expired, &tg->expired);
>>>  	else
>>> -		evl_add_schedq_tail(&rq->fifo.runnable, thread);
>>> +		evl_add_schedq_tail(&qs->runnable, thread);
>>>  
>>>  	tg->nr_active++;
>>>  }
>>>  
>>>  static void quota_dequeue(struct evl_thread *thread)
>>>  {
>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>  	struct evl_quota_group *tg = thread->quota;
>>> -	struct evl_rq *rq = thread->rq;
>>>  
>>>  	if (!list_empty(&thread->quota_expired))
>>>  		list_del_init(&thread->quota_expired);
>>>  	else
>>> -		evl_del_schedq(&rq->fifo.runnable, thread);
>>> +		evl_del_schedq(&qs->runnable, thread);
>>>  
>>>  	tg->nr_active--;
>>>  }
>>>  
>>>  static void quota_requeue(struct evl_thread *thread)
>>>  {
>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>>  	struct evl_quota_group *tg = thread->quota;
>>> -	struct evl_rq *rq = thread->rq;
>>>  
>>>  	if (!thread_is_runnable(thread))
>>>  		list_add(&thread->quota_expired, &tg->expired);
>>>  	else
>>> -		evl_add_schedq(&rq->fifo.runnable, thread);
>>> +		evl_add_schedq(&qs->runnable, thread);
>>>  
>>>  	tg->nr_active++;
>>>  }
>>>  
>>> -static struct evl_thread *quota_pick(struct evl_rq *rq)
>>> +static void quota_out(struct evl_thread *thread)
>>>  {
>>> -	struct evl_thread *next, *curr = rq->curr;
>>> -	struct evl_sched_quota *qs = &rq->quota;
>>> -	struct evl_quota_group *otg, *tg;
>>> -	ktime_t now, elapsed;
>>> +	struct evl_sched_quota *qs = &thread->rq->quota;
>>> +	struct evl_quota_group *tg = thread->quota;
>>> +	ktime_t now, consumed;
>>> +
>>> +	/* Timer off means that we are not tracking quota. */
>>> +	if (!evl_timer_is_running(&qs->limit_timer))
>>> +		return;
>>>  
>>> -	now = evl_ktime_monotonic();
>>> -	otg = curr->quota;
>>> -	if (otg == NULL)
>>> -		goto pick;
>>>  	/*
>>>  	 * Charge the time consumed by the outgoing thread to the
>>>  	 * group it belongs to.
>>>  	 */
>>> -	elapsed = ktime_sub(now, otg->run_start);
>>> -	if (elapsed < otg->run_budget)
>>> -		otg->run_budget = ktime_sub(otg->run_budget, elapsed);
>>> -	else
>>> -		otg->run_budget = 0;
>>> +	now = evl_ktime_monotonic();
>>
>> Thing brins some, though minor, glitch when doing the run_start update
>> for the next group already in pick. That's why I'm trying to reuse that
>> stamp when available.
>>
>>> +	consumed = ktime_sub(now, tg->run_start);
>>> +	if (consumed < tg->run_budget) {
>>> +		tg->run_budget = ktime_sub(tg->run_budget, consumed);
>>> +	} else {
>>> +		tg->run_budget = 0;
>>> +		evl_stop_timer(&qs->limit_timer);
>>> +	}
>>> +}
>>> +
>>> +static struct evl_thread *quota_pick(struct evl_rq *rq)
>>> +{
>>> +	struct evl_thread *next, *curr = rq->curr;
>>> +	struct evl_sched_quota *qs = &rq->quota;
>>> +	struct evl_quota_group *tg;
>>> +
>>>  pick:
>>> -	next = evl_get_schedq(&rq->fifo.runnable);
>>> +	next = evl_get_schedq(&qs->runnable);
>>>  	if (next == NULL) {
>>>  		evl_stop_timer(&qs->limit_timer);
>>>  		return NULL;
>>>  	}
>>>  
>>> -	/*
>>> -	 * As we basically piggyback on the SCHED_FIFO runqueue, make
>>> -	 * sure to detect non-quota threads.
>>> -	 */
>>>  	tg = next->quota;
>>> -	if (tg == NULL)
>>> -		return next;
>>> -
>>> -	tg->run_start = now;
>>> +	tg->nr_active--;
>>>  
>>>  	/*
>>>  	 * Don't consider budget if kicked, we have to allow this
>>> @@ -439,25 +437,29 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>>>  	 */
>>>  	if (next->info & EVL_T_KICKED) {
>>>  		evl_stop_timer(&qs->limit_timer);
>>> -		goto out;
>>> +		return next;
>>>  	}
>>>  
>>> +	/*
>>> +	 * __pick_next_thread() might have requeued the current
>>> +	 * thread which is still leading the pack.
>>> +	 */
>>> +	if (curr == next)
>>> +		return next;
>>> +
>>>  	if (ktime_to_ns(tg->run_budget) == 0) {
>>> -		/* Flush expired group members as we go. */
>>> +		/* Park expired group members as we go. */
>>>  		list_add_tail(&next->quota_expired, &tg->expired);
>>>  		goto pick;
>>>  	}
>>>  
>>> -	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
>>> -		/* Same group, leave the running timer untouched. */
>>> -		goto out;
>>> -
>>> -	/* Arm limit timer for the new running group. */
>>> -	evl_start_timer(&qs->limit_timer,
>>> -			ktime_add(now, tg->run_budget),
>>> -			EVL_INFINITE);
>>> -out:
>>> -	tg->nr_active--;
>>> +	/* Arm new limit timer on change of running group. */
>>> +	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
>>> +		tg->run_start = evl_ktime_monotonic();
>>> +		evl_start_timer(&qs->limit_timer,
>>> +				ktime_add(tg->run_start, tg->run_budget),
>>> +				EVL_INFINITE);
>>> +	}
>>>  
>>>  	return next;
>>>  }
>>> @@ -542,7 +544,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
>>>  	 * Unregister the group before we drop rq->lock. As a result,
>>>  	 * it won't accept threads anymore while we are busy moving
>>>  	 * the current members to the fifo class, and concurrent
>>> -	 * evl_quota_remove requests would receive -EINVAL.
>>> +	 * quota_remove requests would receive -EINVAL.
>>>  	 */
>>>  	__clear_bit(tg->tgid, group_map);
>>>  	list_del(&tg->next);
>>> @@ -556,7 +558,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
>>>  	 * hold rq->lock on entry, we do a trylock dance to prevent an
>>>  	 * ABBA issue. No livelock is possible since we unregistered
>>>  	 * that group already, so &tg->members can only be depleted
>>> -	 * (by this loop specifically).
>>> +	 * (by this loop exclusively).
>>>  	 */
>>>  
>>>  	while (!list_empty(&tg->members)) {
>>> @@ -583,10 +585,10 @@ static void quota_set_limit(struct evl_quota_group *tg,
>>>  			int *quota_sum_r)
>>>  {
>>>  	struct evl_rq *rq = tg->rq;
>>> -	struct evl_thread *thread, *tmp, *curr = rq->curr;
>>> +	struct evl_thread *thread, *tmp;
>>>  	struct evl_sched_quota *qs = &rq->quota;
>>> -	ktime_t now, elapsed, consumed;
>>>  	ktime_t old_quota = tg->quota;
>>> +	ktime_t consumed;
>>>  	u64 n;
>>>  
>>>  	assert_hard_lock(&rq->lock);
>>> @@ -615,16 +617,8 @@ static void quota_set_limit(struct evl_quota_group *tg,
>>>  	tg->quota_percent = quota_percent;
>>>  	tg->quota_peak_percent = quota_peak_percent;
>>>  
>>> -	if (thread_on_quota(curr, tg)) {
>>> -		now = evl_ktime_monotonic();
>>> -
>>> -		elapsed = now - tg->run_start;
>>> -		if (elapsed < tg->run_budget)
>>> -			tg->run_budget -= elapsed;
>>> -		else
>>> -			tg->run_budget = 0;
>>> -
>>> -		tg->run_start = now;
>>> +	if (current_on_quota(tg)) {
>>> +		quota_out(rq->curr);
>>>  		evl_stop_timer(&qs->limit_timer);
>>>  	}
>>>  
>>> @@ -646,7 +640,7 @@ static void quota_set_limit(struct evl_quota_group *tg,
>>>  		list_for_each_entry_safe_reverse(thread, tmp, &tg->expired,
>>>  						quota_expired) {
>>>  			list_del_init(&thread->quota_expired);
>>> -			evl_add_schedq(&rq->fifo.runnable, thread);
>>> +			evl_add_schedq(&qs->runnable, thread);
>>>  		}
>>>  	}
>>>  
>>> @@ -786,6 +780,7 @@ struct evl_sched_class evl_sched_quota = {
>>>  	.sched_dequeue		=	quota_dequeue,
>>>  	.sched_requeue		=	quota_requeue,
>>>  	.sched_pick		=	quota_pick,
>>> +	.sched_out		=	quota_out,
>>>  	.sched_migrate		=	quota_migrate,
>>>  	.sched_chkparam		=	quota_chkparam,
>>>  	.sched_setparam		=	quota_setparam,
>>>
>>
>> You also seem to miss the case I discovered only yesterday as well: When
>> starting the current thread on a quota via setparam, we also need to set
>> its run_start stamp at that point.
>>
>> Please have a closer look at both my test case (libevl) as well as my
>> patch 2. Currently, I don't see remaining issues with both, but I'm all
>> ears to learn what I missed.
>>
> 
> AFAIU, the logic of your changes is as follows:
> 
> 1. provide a sched_out() handler which charges the previous/current
>    group with the budget consumed by the outgoing thread, dropping such
>    accounting from sched_pick() in the same move. As a consequence,
>    charge the consumed budget in quota_limit_handler() too since you
>    can't expect sched_pick() to do so (i.e. turning on the resched bit
>    on curr->rq in quota_limit_handler() would not help in this case).

Yep.

> 
> 2. invoke sched_out() after sched_pick(), unless prev == next.
> 
> Since sched_pick() checks next->quota->run_budget to make sure that next
> may run, what if curr and next belong to the same quota group given that
> curr->quota->run_budget won't be updated by sched_out() until
> sched_pick() has returned?

Nothing is changed in case final next->quota == curr->quota. It's indeed
true that the run_budget == 0 check is not going to trigger anymore -
can be removed, the quota-timer will take care anyway.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
