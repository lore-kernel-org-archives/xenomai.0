Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5230567F
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508080; cv=fail; b=Rq5oeXppxxcDOmWhfaxfbPXll8L9gho3hA/R0Vl25Z28uUQrG4MPobArOoSaQPjKlN6ishmfl1uWqaVL/LVgBeRhA/reMH00X0u124sozYrQZN5zCJdvPh+/fh5a6eIEzHw9RbdvZ+7sJ+JhYTfnGlWZ+hGoplLKHnLyLzVJC54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508080; c=relaxed/simple;
	bh=ET4yDKH23NGSlZI/GkFCmyEXBjk0n9cgZ6N79+QEflo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WnijLDrC9AIk+G06YV3rpOZrejoBA93VR4ElljJAfguZx5QFnwtUPdmFETmeXbqCedzTRI6nBddiK6/lPr2ojIUv0414aoCAp4JianfOUTPZL9AwC5ADg4Dc8lCcOUc5fbVyQojneNx+D2iq1vFte4JL8jX7XlWG8apLm2hwIhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pQjm49of; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pQjm49of"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/RFqkV3XwHk8UgFmK9Y1kIMitBZYs1fD4MmfKCK91fqvL83rxjg7bTJxFojUxVDVpEk9qaaRn7YTfxrouz3myS5QWmUOkwOqwTIeyfeEvv1rTewIBxbvaDZADmETIyoAmx4XV64SivWBg5vXX7Pw4xdk+/GhtGHlwFkw5c4InBZOYgUbPmLgJCzOz7BocYOXagkMYvJ1tJht5ehabKkKqN/UlAHJKXoVnMxByIMN/bTzsUGOejL1+fsGi9b/8Xc7f0UjkBfaIn5VwkA3ZRJUaEnB9GZJfSIDl9KX1v2p4dt6+F0ECxe2SLHntVo1S8OJrTBQ464zpkLV0qvfK0IjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUK99Kdm2/E+OyT2Nn75wYt0S3dPKDgiXXfguXWAiRM=;
 b=u0VaDcELkfjSxvGCbCh1d8+iL2Kh8hIggJqtfvBbYomHz/4+g5T0dBwXK0w5mwDFidG9wsjSxa/5mh+3xoUSZWzkLWLBZE04Xpr7Xr07iBP4KGHUSRX1Z6h6gijo27V2Z7Vp5bdxko52aKnf1kIFqrCRmcrjlSJgwCjnL3Os1lrOH79fviIzInFvhrpMGPL8avV3Scw9ZL2eS4Vs2qOW85Gs4HmtzN/ujHWHG/GHEPbwmZq8GNO260oTYFURjVLPmfue/t43XW2+g6zQJ5tDlvOZ9oZ/f+lToK08P8m7Yw+sKVz8eVDi09xdDeSgK3FcJTaHtOAq3e1nUNEYLl2eCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUK99Kdm2/E+OyT2Nn75wYt0S3dPKDgiXXfguXWAiRM=;
 b=pQjm49ofSnlLN/c16Rtun9mw8rxiwfrKr87xva0BDss3B0CFx/GnGtTkeNLFT+AJCD4dkaMG8eUhuFmGyexVtR9DdaQnP0BReyJ09ZrUTa+ekz6bUdPa4bM3ARXsTGZ3TSMX29lGEHBIBNdEIScc58mzJ5yllXv/9jU/lexnKP5GnWzlnrtTkUhBJD+9mWvToT9HobApB18lCdlxYEDMA1Qcf+V6Q8Tlthxjx2pGWSk6T49W+7OA4aIYN7W7WUvrc3k7IH3S5wUAhwbOMERe/JdTZgObGThc1F4dr42YVSAmHnV9t4F6TkXtdKYsNAfkBbTZUtrSBFcOOEawyJJ1yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:21:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:21:13 +0000
Message-ID: <c9760910-9b99-4cab-a776-c472bfbc445b@siemens.com>
Date: Mon, 15 Jun 2026 09:21:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
 <87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
 <d3d659d9-b327-4f19-89d0-7f53c3b18796@siemens.com>
 <87pl1sgtr0.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87pl1sgtr0.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7d83fc-3a14-47a9-698b-08decaaeaea1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|55112099003|11063799006|5023799004|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	x76WCzAcXwLlW+519wTas6HRgph4iNVBbVq/EneqIOVOma/5/dMnSiRzJw0qypycp0gCYNyE9qT2L3TdeOk3PRmxetqlQoQo+mag+xGQYIheC7zKm1AOHwXZzTDoxP5rUIyThVclhG2ZLgvW+18g0aNBuqzrLeRDOBqMh3ni6qeFgtpTk80ZDDlcB+2KMIaU/oS33gBRXCxqXWweoPQ9gj9Xyjanbq4xoKamxZhJiUv50z8q3bz6bKVwmCTyxwjMouhplJPc5BOt8BKfIEyoAUP2t7hs1PZ5qi+W95gNsDQPfWqklAqGsZX3/RbIg2kI2MoGZhP9T/m/G3TfM/el0Iy7zjihsOe6MjH9fMKqBJL9kKsZ+oqQWxs1QjpfqrymL1mxg7GUBch+HQfS+g1ASPvLURpOMc+AjjlAmw66Ngi94byKKUUGTDKKoFfKrLWEsOpH+RW73N80+HhWpHw2q/jAW6mIcCDQoOTfNJ5FjqW+H8OkD51J0M5CJ0LbMCZrOItDKWSV6j1bgK+/eXReWwahKqrDE6K4S36d44SmrTAZHbICQ0r2+O0QG9qnn16oc18tWsBOWEEDqVSTWWCdylUk2oFzzAWvTIiY8SWJSiWzy8zKXYoAr0zBQYXu3Ev+0vOK/3q9WOz/1R2vZpX1wcjzPbkjOvOX5pi3GSKqKOIidS7G1+C9nqmpTKxYxwb3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(55112099003)(11063799006)(5023799004)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUxaSk5yNTRSMFVUbS9jWHlNOElmbFpMRjhqU2I2MXhNejBRZnAvN1FNamxI?=
 =?utf-8?B?akI0OTYvL2h5eUthaTdNMk9qVlRMNkU4YzZ4Yk0wWkVQbnppTEduRUpXSytD?=
 =?utf-8?B?c3ZlVVNxTjY5MDc0cVovMVp4dWtvZzVpSFFjZVkzZnZYcmNvV1RVQS9yZllV?=
 =?utf-8?B?QTg5YzUzMklWM2pKa1FzYy9BM1hhb0N4bTJTbUNlZytadWF0TVJONHhBdGZ4?=
 =?utf-8?B?d3lNZU9vOXlwQkwyUFRUamNZVk5rTVlBZ3ZjeU5lcTFLd05XTnR2aXZTQlRm?=
 =?utf-8?B?UnI5WldYZm5yN1BmU1dGZW5nMG1ldndVT3VDdlVlQlI1Q2JVUFowUTVLTzBa?=
 =?utf-8?B?RGZpaDBENVZSQUpxSDRyWWVMM3dDRVlDUXR5WVZ4STE2NE1OdWpLUjRlckpr?=
 =?utf-8?B?NzNmNXYvSVdrNXZmQ0VIUVV5TE9VdnRueExJblRXRUVWQWkzM01FTUkyUnc4?=
 =?utf-8?B?NWdORkU4L2lhc0FNMUVyanE2aG5jU0VpRTlFdWJIbUlsZW04VzA1S0FlVXRB?=
 =?utf-8?B?TXI2NE9oVFN1ZjlaTkpaSnQ2Qm5pbTM1T3Y0OCtDeVg5V2YyT3ZWakFnWnNi?=
 =?utf-8?B?a3RFdmlhWlVuai9uNHNuTG9YNkdEUmdXOWNDWmZUWTBsZHZyZUdIaUQyYk9j?=
 =?utf-8?B?RTNYd1BkQW0rWERRRGM1WjBNVjBMK0RsRExiMzVuNi9sclNBVklaVlRyZUpJ?=
 =?utf-8?B?aUVNRnd3TDdLTlBzZmZBaDl4UlR0cWhaUlQ3Q3dRMDZER0lORVE0SHJxbXk0?=
 =?utf-8?B?czVrdmxYSDJlRnVDMkthbnRxb2I0dy9hL1M1RWE0ckoyeGg5YVlPVzhFSHhI?=
 =?utf-8?B?MVhXeUl2bkhnS1JUVDNtci9YUUZBc2t6NDRFTlJ2eGpPYVlPcDlTOXRId3lk?=
 =?utf-8?B?U0RBZnZpYThQRjZDTWVmYklhU3BHV09IRzVWeC8zRTlVMFlhNEtXUkJWVXZ4?=
 =?utf-8?B?UU8zSEJ5WVQ3QUI2elBOTGxCQmpLcTFkdW9xSzhXQmZMSFg2dVBMazZiVHlH?=
 =?utf-8?B?c1NId25pZE1Tb0xCdjJYYmxJTlhPNXB3L3VtWnJnM3FMUFc2d3JjSGN6bXZS?=
 =?utf-8?B?S1hKOFJPdHNseml3MEdDS3NrNmdBMTAzalUyWjNKNWlDZGFVZkJXZ2VKL3Ux?=
 =?utf-8?B?dDNuTGM1aHRtalFDSnBROUlHZHdKUWFPZGlibWRwR0trblB6ZHNzM3d0UHlR?=
 =?utf-8?B?U0FsTnozK3doeFdhSXVrckhONlFqVUdGMW56QjBGREx4bFNuZ0FlL2NkbmJa?=
 =?utf-8?B?MXpxRThseUozUUUwclF4dFVyU2JVV2FIczNLRlJtWi8zQTNWby9WajI3Z25u?=
 =?utf-8?B?QVJsd3U0SUl4dUMya3pSWHhtNXZheGtUWXMxaXZINnFCTVlJR1dPZDhDaTFq?=
 =?utf-8?B?NW04NDlsWXFkMmtxb0phY1lVTlplMndmcUcvTzVYZXJyeWRXYjV6WHZTZ004?=
 =?utf-8?B?ZEVPa3NwdlJLWVp5TlFwM0s4eks5cUdJSlFGcTJCSEQ1MnpUcEJxdkdXSW94?=
 =?utf-8?B?M05WTGZXWkNPcitHdkZob0VaNGNRTnAyeURhMGZ0RGJsQ1ZrRnY0Sy9MSHFS?=
 =?utf-8?B?RzdBbjNYb21IY2lxNnBvalM3N1RqSlJlWTd0NTIrdEwycDN1dUhrU2tUUmV4?=
 =?utf-8?B?U2F6TitEVk9pNlVXWWJWNktRR2JSbDNKcElmQXdzVFJCL1IrNzd5TGFvOURZ?=
 =?utf-8?B?RUxQWVNVRlRuUTFOUjlYNk1oRjJHSGxrSUtmVmJGT092T01Nc3JraXNhYTFO?=
 =?utf-8?B?aFJZdVdwSGsyYVFqbGJhK1ZJRm12d2p1SGRsL0Q4QnptUWxOVmNrN010cEJr?=
 =?utf-8?B?TXNWSnpWazJ0d1ZHRHp4QmVldkxBSkxmdzY5aENuY2ZKMDVwSmRPNGdvZlcr?=
 =?utf-8?B?QmZOcndXMGFYSFdlTlFxTGR5U0xkZGxaalpLY3lrdEEwWnVpeUY1cG5KZitp?=
 =?utf-8?B?VXNJMzBqaGdHVm9jOGRjL1BFYUNzSjVMMHNpR1NKekxBdklFV3VCTnMxQ0Zi?=
 =?utf-8?B?K0UrQVVzLy9KTjRuZWhyRkJqVm9mV3U2c0p5SmVSNVFUSlNTMHc2Ri9USFo1?=
 =?utf-8?B?eFd2ZGRyQklXS2pzb0l3SWxHL3pobkEzWngyd01NWThDay82QWJjNXl3YXg3?=
 =?utf-8?B?S05kcDNhTnR4NlV1bDFYeDhyQUNueHBCS3hxcWl1RnVRc0R5SUxCN0pGUS9R?=
 =?utf-8?B?TFFuczA5VGdoSTF0K3crTkdrVVpjTDZiSjRIN3RnZW14eENtdWVkRmpvK3oz?=
 =?utf-8?B?Lzk1NFI4N2RGSWFTZ1VrVyt0M0lZT3FMTXdGUHBYQWtocis0b0hsWHVuaXRT?=
 =?utf-8?B?ZGJSM1hMQS9YSVRtWmh1N2pDQ0FKUkxtOEpXRkJFNGlXZjBOOENoUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7d83fc-3a14-47a9-698b-08decaaeaea1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:21:13.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kFsK0KMBxcIi5UwnqmoYUmlm4INWHPxD8PaBJj/MPTozEPoIkQ9FnNVzFsdWBlHcuylpyfRn3s5xf0Zy5+u7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756

On 15.06.26 09:14, Philippe Gerum wrote:
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
>>
>> The out handler also needs the target thread in order to identify if
>> there is a tg change or not.
>>
> 
> Your implementation needs this because the sequence is pick() -> out(),
> mine is out() -> pick(), with the latter using the budget updated by the
> former to figure out what to do next.

But that will call out even on old == new - does not sound right.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
