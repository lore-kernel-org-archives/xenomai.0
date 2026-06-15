Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBBE3BBFDE
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508172; cv=fail; b=Xtv2+hHNFfKIoPyEhwCUNPMBUdJeNSZh9draQdFgBEkosO0SkNBXgHIcESVJtG1DlzoQDgsV322oJ/hdlnW1o/wPZzh+T0zRUnPjVRWgyUs5D7VZKbpr34sA6HXkkeoWI857MUJZ8q5y10HPrnGXjXaCdKb3cnBN/3rZ61EgaUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508172; c=relaxed/simple;
	bh=N2kh8+mqC04ZvuxWZtjfSgEozC0zIT2t0ERRgEFHeD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TojX+wM7a85XY2BofO9VSrlF56Rsq65azOGxLIt8Z155t+PPbEKAw8IRlXwb1S0oJUDanNv3owpNlWPzx98yuip4/pAFyNB3hQ+WqDIAPpYOxeb9815xr/ta9xGKoMyo2cZ+o5LZPcZFL2KEa4KaJUcCeojXtD0uiRCG7zTwNcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CSOF6ndi; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CSOF6ndi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhYHR6RorlNMHBJk2uSg+SIOiXyB0Yx+7TgXc5Xrc6LtUaJkIrsElJiJ7H3n9Q+LeDPRqja6E+9u67dybqA8sbMEBJibdKrk1D+rdb4ssSqi7XZaHUYdip6LbNlohjZYT7UmOVRaJDd5sl5yP7Y+GeVeBmcDSxvwOhS+wnxN32M/SLslSFRGHGXRptSHIgtOygkKyovFCOvsGCf3IjmN7732+l3KfCoRPMuOnk7T0xqtIjqBN1mzYEF1NQE578eOvoPYoCoJ/r9S156dXeLUXmbR1ZtHTzdIAwtP6bKdUv0MlfYCRVs/L48ppqpyXR4SEBnHdn23IBtUpMG5eqChEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFGKaFHdRmaeyyVwW6ezuFpi371g7EjsfkdW2qYbV7o=;
 b=GK8XZFC7lRAK5lAYuFRjE/GahGhwUEMqxqiyDryM9SYDnq2Ywrr2kFdztCNUhEGKXVKCq2dG/jjOQ5LmWjMG2vp4p8r80ZuPpdb3a+h/dykcObzz0eXyI4H8S6CfPxcNIu7HoiZU4PxUsBBOumboQZYOywgJ00lU+fFZdRdSvZ8WVAYXvB+mnjdJxytACU3dqwngIBooXt/Is5Stze0XrSY4bs9i4p13fBcvcVj3wcZy+B8wVkIhhautdHn74AFqvhX6TZSuP4k4MfxptBv5E9rr16e9TklA+/XhEihpdhrfQBRfHaQvRMSlktF7zf8qtL8JLIJ1q0AR0lFvnt+Hxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFGKaFHdRmaeyyVwW6ezuFpi371g7EjsfkdW2qYbV7o=;
 b=CSOF6ndidydaPciiX/shEIZGGZqyTGw3mBsdbOqrriuw5o8egYlH3+vQk854bOEpzR2d0qvIxRlj41FVQVoXB10GvNUz55EADaXawYUg6/BlelSl6c6FXPNZ0G3OjkKbYupV8cvWTMZ5puyeCYstYuRJbpoHVnXDO81bR8uwXs8uTkoxv/6h9KWRgLcpMA0hrxd2qjSsYwp0SEn1EE9DagpPx3tXlcK0q/PjzNtI5+ehWNpJo/KbsCnNOjSEwDpEH/F46lNdGlL+STrvNcGbAGe4MeIglUuxpwg2rMghsFtg6Sw0LcwXiN1Yr6zqrA3X0uJL1c5viZbE8KdLZzHCvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:22:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:22:46 +0000
Message-ID: <8a0384df-69b7-43e1-93b7-79a8ba1137d9@siemens.com>
Date: Mon, 15 Jun 2026 09:22:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
 <87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
 <c3ba6b74-6a07-458b-9b5a-255eb9853183@siemens.com>
 <87jys0gtma.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87jys0gtma.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f960fe-ba48-479c-4742-08decaaee5c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|55112099003|11063799006|5023799004|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Xo3DQG6xb3Gj2q41tNh9qpAd0zwDqMKzJBJNB7jswe89h4z5nl3CP2Samekua/qedoLBsLVVDYL8dTy2YjQnu12WetxTT/M4Rx+J4NHeArY372g2FAdGU5Re7N7scUoBKoSyfzyH+ZHgDFDbwAyggz9QpSReCx8bDHMiXK4cQHVUoSTXwzAhu8jfkPnYP7ZHJ73oOYP6biJd6sdRKDAVpLAu8Mok5CS7fzHvWlOjoJpKpDfWMClQGw1eMLgE0zLv8VJsM/UohUWcPfAq2bpqmGmknkSDJf0X9TgdzVTyPOWFvMKFOl4ndLYuJxeLt+4nyojd4NNV18oPZRcOSpvBu1n1UlHmszYJt9ZFRwCCaGe5Wgcv1hguGTKJTZQyS8Iijq50eWyZwVaAfSUqQobB0GNjDERVCF3aGeUHGUU4xMJZ/np25kWbBaPAKpRjYYaocW5hylOeHNjpXVA/o7EqUTytGw0gFiFBK23oiNSDf34sBfteSFJEFtLqZirccqNObGBlVJGU+dh5Cslb3o/XzOkIpT6HyX2+mzpVdIaFBJRqSDlYV149w/YpfeUJV2+chpY17yoRtbMCAivBJH65Gef8hVo2QjDx5VIN601xxEL8lxSoDF0YQG90xfibJgVr++pcF3upKEv3E4nGx9McrxMERBm1TvfJOH8puhjX+9SWZMQwME6dBXpGuYTF7ix7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(55112099003)(11063799006)(5023799004)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnVwOGE3c1RDK2EvUG5FUDdRWDRzVDQ5Z0R3QUF5bmI2eXJxVWYxczNNczYr?=
 =?utf-8?B?R1Nzd2s0UzRlOTdRN3hqaFhUTkhTVGg2ZVNYQ1l0bjgva2t4aVRrU3Q5R1R5?=
 =?utf-8?B?NGhBL0VVYWNYeUt2NnZ6V2svUW5qT1NPWm9SNE0wdmlhcnlqME1OTE9RNFRS?=
 =?utf-8?B?d095SEZWckpYMzd6MVhya1dmL1lMZjBDenBSS0U2YlRqY05kSGNYbHpqem9L?=
 =?utf-8?B?c1kwVXZ1QURvemNpdXNMMnl5RDhpaEdEK0FTeUJOZXdIaXRDSXVCaFp3dW0x?=
 =?utf-8?B?dHhGKzRWUmo5Z3pSTUNlUlF2VkQ0eTNFTWZkSWxBc1pIUjRYVlpwNWhpNlV1?=
 =?utf-8?B?RUhVRU8rTkd3Z1pxczkwQ3hiL1hsVVF6dXlob3hId0hiQnBPRGlTS0w3YmRE?=
 =?utf-8?B?Y3pkVzdQWnZJa3hUV1BkNEEvMTZwdU8wMStrSjdOMElzUlpaQUswRjVWLyt0?=
 =?utf-8?B?aUdvQUNKNDJMQUszb2diUUE2SldBWlMyY0FwY3JvbUNnT2JSdUl0Q3M1bDFa?=
 =?utf-8?B?TEY3K1A0eFY5TlorK0sweHFlSkJmUDI5NjY2TXQyUjkzNzg4U2FnYlBXczcz?=
 =?utf-8?B?N0JlQWtxY0lDcUZUNEhNc3VoMXFoWldZcWdDRyt6M1dOUjBhdlJJcVhyQW5r?=
 =?utf-8?B?bTVSTWRXUi9KSmN4c1hBaVQ5OEhoS00wQWtITVhDcWZ2Wis0amJMZmlTaEUz?=
 =?utf-8?B?azZSZUZRbUtub3NoVG03V09zdUpPcVUzNElwemowb3BuSlI2SFZrQU9tbE5C?=
 =?utf-8?B?R2ZBR2xXLzFFcWp6YmpLT2x2b0JjdDVXeGY5QTlGQmUzVXZyRThzNEh1b0xq?=
 =?utf-8?B?QzNHUzkwdnp0MTdMTVY4eGFUQnRkLzhwUzQxbVl6L1M1d3BYeWRweHhIalBO?=
 =?utf-8?B?NkcraGlzTEtrMi9hV1gwMGJVSG84N0pJaVJPV2NtaVNXSmV2QVhuOFFOZFVi?=
 =?utf-8?B?NW13Mlh6VnJqWXp0ckdobFlNcjhTcU96VWc2ckNMWlgzL1NWYVdEYm56Tys1?=
 =?utf-8?B?Zk9UQStwNktGWVZvM0l4MitucnQvbnkyU2E0eEVsYkwrR0ZPUDIzVUhyQ2hO?=
 =?utf-8?B?Sy9JYVJWZlJQRlVFM0pndVRTckZHeSt0ZmtGdkZCNjh2VnFsSmVMTldMUGZY?=
 =?utf-8?B?WVUyblBPRTJjWDhCVUwwOXB1SjYvcEpCT04yVHNLblpUY2JnN0l3WkxSSVpy?=
 =?utf-8?B?dTd2MFViaGtuY2RpMndjUmloWmhVcnJwamQ5MUtzbEcxUVpla0xTTVZWSWUw?=
 =?utf-8?B?QkVIYmViaWRveE9SejdITFVIdXBudFZHUjJsMFMxWnIwM2lNcnh1bjMzTDNN?=
 =?utf-8?B?OThESWNQMVZCeHVwWkpNVlJiN1FKbDZiUDhzNGRFa1kxQWhIS2tUWDM2dHBr?=
 =?utf-8?B?d1g3RkRNRmF4YlNYeWo5VEF4MHNDVlhucU5MaGFqU3UxZUNKMk5UZkN6QVpV?=
 =?utf-8?B?VUxUbWplSWx1UWVhUGViQWFkMUl5aTJQcDJSL25Ic3c5anVxQmsrd2lJS2VE?=
 =?utf-8?B?cFlQbnU2Rnp0VWV3SkJ4RjFyTXRuWnlxYWpERWVseDJESjNwWHQyUncyNFJG?=
 =?utf-8?B?VEJrSkxwdzY1YUpiT3NMZ0lBZTNqMm9DTlRmcVV0anBCUEcrZ0hiRkx2aVEv?=
 =?utf-8?B?ZnUwTkNNN0gzdHlsd2w4M0tYbERSSnZlcEFoR3RkNURDMExWNFRiTkl5WUJQ?=
 =?utf-8?B?ZmlZQ0EzaTZOQXVOa0xPUXdwUlZqaVFkNWdXa0Y2MDdnQ2xiV1U3QjRKSEl4?=
 =?utf-8?B?b2w3UDRJdERpMzRUWE92TWJHWG16M1hBTXI4c2YwK3ZRQlNOczhKSEUrdlpY?=
 =?utf-8?B?S21OSzVpUjkzRm9welZhNE5jR1M4OFRYSisxSWk3QnJadmFoRUdLSnZ6S2xR?=
 =?utf-8?B?Zk5YSGJxM1pHellYaFNtK3UrOHZ0UG9lRGNKREZwellZa0U5czZINWwxV0w4?=
 =?utf-8?B?eTdCbTUvNk1PVTVCYUJUS3huQVF1Zmk5YSt3ZEJYNzNya0NUNWZNVlhySmNV?=
 =?utf-8?B?ZmFXOVpnVFVTVjEweXcwZjExSUFHbUlsdnZKZktiR2pHZG9KTVFWdEQ0bWJY?=
 =?utf-8?B?TkxuS0VBMHVKQVVhNjJJamw4dGhIeWNnUWVWMXBwN09qMUxVZ0RLdkkraEVI?=
 =?utf-8?B?OEwyT095akdBQWQ4ZUFxM0tXMFlrOHAxaCswVXNLb2JUdkd0anF0c1pPN0F5?=
 =?utf-8?B?RVNVbzVERUxFVWxuZm1rRzNqK2tYZ29uZW5lQVJZdDRLRm1uOWNVV0FmTjQ1?=
 =?utf-8?B?WUJyQ1NLMmMveXhxZG9tbWZvSzRsM0I1V3lwby81bXFETDhubXZUZkptaEpn?=
 =?utf-8?B?YWlGK2FiNjFZMEpGOEFqRW5hOHFMMVJXL3hnQTBFSVp3SkxkKzU0Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f960fe-ba48-479c-4742-08decaaee5c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:22:46.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9FUjgwhtL44BekgZX15vSsnISdnfVU7NTrZ925dGUWWDcUK7D/lwcv3qXKw0oaMaTwFYYFQhUBBH9SeSic+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756

On 15.06.26 09:17, Philippe Gerum wrote:
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
> 
> run_start should be meaningful only when a limit timer runs. 
> 

Right, but are you sure it will be started in the case I described...?

Jan

>>
>> Please have a closer look at both my test case (libevl) as well as my
>> patch 2. Currently, I don't see remaining issues with both, but I'm all
>> ears to learn what I missed.
>>
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
