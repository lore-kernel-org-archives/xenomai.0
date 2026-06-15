Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF930F533
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506009; cv=fail; b=AmiXfnidr53ggL7pDoPfzguuEGw0k9mDFuUUkTDMhy1bLfrQpTfBLsoynG4gwgQgQObLgdUwvUSS40onnZNZUyUMSHxeaupd+DeIocinF6azWnS1wiw2xdzMBJPUnp6LIf9VB2bsIAqwmcloJUTMzfGMLhdtCVj95IMQVLSsO54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506009; c=relaxed/simple;
	bh=NWU515Ox4QT0ghHXSUP2XYEH7HVN3IWLa5kOb3usAjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BgqqZulekZPKvvOwajDJbQD4tlctLLoB07Dkl9HDAsICLV3DQJtvsByzfYlBvdPOjqDpS962iN3civEGNdswAQ4tNiJux9YAcVmLAep5WWLBWD3/D9yUfbe1pjicbkUiyywsygv/NSatZ5mTbTptZke0VbXpRcqtgHQI4YlxSvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FBE0kkan; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FBE0kkan"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq3tjrFKJ8a/otwZB//H2zLPcmM3U+kjzbSCNtE0oNc01MyDN/f+fvESn59c5AVGpGtNQGQIDk0ZvRUDU8ZtQmhM8vHMt+9mMJF5h+Z2FJnsE6MHfn5rQ8RPPSNhvETS2xLWR/pqYQkGVYqt7CdBQggeGAw7JjSAIC5RWS4/ZfU/sHRrSIQWs5IH9tjPggoRzCoThHcCswND9otKToyiCihMMU5FWNensrz4ah8OhA5F9b5Bw6hYG0N3blz4kbm1+N+mMkmxV8/QnHToHf87tM8ig12KPlVqPJfkXoWrMa8XNO3hDJTHuxbKiMBI4saNzOnJP2tRmfmx3YRRCFkMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHwXrDdsuf1MG5XCM1NVG9MPh6f1/KOUN67uJ/ySfig=;
 b=Uwmk95jQyGrti/X6EBgwreT0jF8HIAMSY7Zm7AHRn1HGQ3LGWiacoPz7v31/vjqdK45Y9e9038n7PDLlRjyfR7iyhsGNYzu8v5y4bYWT1bimsbvwWsjdGy+4KG/JdqBs7fOLsgmZ/gV0OT9PMgmScFrkDyZf9B0pKJJhGbE1oAuTMfq5uXMA/sL234QSFA4c07Ior+EMg3VetrSJtYJFb08mwUqPjflfvRiFRl51q8meuRjHU6ShS9AGcLuGPLYxJEovzI31Q1iewV+GPXMoWvrhDHxabR9+JB9uV3vzczIbILbcDnRWiSrWYs54mlUI8XRUmoLnlRoc6lAXwXgosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHwXrDdsuf1MG5XCM1NVG9MPh6f1/KOUN67uJ/ySfig=;
 b=FBE0kkan5WfbmuaPJJ4gSj93iA7X8hMcz1x823SBEVVAzRioGdsbmRR5o6j0h7oVO8UKG/soV0WUWvThzKtf1ePF3NVKFRYJFoP5OwS3PAO5I7RRNAbXwMElmo2JlFH45lcjDh7iZUXbwmjGy/FaPV+Scmjlj1GhcnwXuwYfRY/QGH5t5451fkj8PYeocuqTz+bSA+y+hmpigSr7oj/+6/MMtFHzYg8ABZ4PyTzJEdFBg8TmAWa6+tGA19i9EGYuEKLvmT8VcehE9skXR5yD4K6FcpCX/jbIdnUd8ADjBGNAhkj8ecb4NZ7MuuRYtaFJWKfq4SOGacon2HExsBvFoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5655.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Mon, 15 Jun
 2026 06:46:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 06:46:35 +0000
Message-ID: <d3d659d9-b327-4f19-89d0-7f53c3b18796@siemens.com>
Date: Mon, 15 Jun 2026 08:46:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
 <87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87a4swi9sy.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 275e557b-6d71-4b37-66aa-08decaa9d809
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|55112099003|6133799003|18002099003|22082099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	UfRddGYrEqCo5nM8IPBjJgVEXStsphnjUj8EAfnIxetBAlyJKM7lv+B2n9/GYPUtR7842vGFl4AtKUam9tCUsETmZ4/C9mpWQpKhVGv1ZWw0C1/e18pFQhMX/C5auyX6e0VFYjp0/vJ2+D5oh2RmYWTsltU9RUC/3UrstMxd6IfhW+fZzb6lZBiSvkOoSRZH9JmxJeqtZDX/i8o02LmJJDEvXhQjJZYsV6dB/Y4jY0Y5mSVMeZhhy3WXobQM7LsTZ2kcTtDlsSOPEWhQtqEGYhh5z2mqpltcDH13bf4cwSJN3/4mx6C8fBE6UeVRDjdYvpuXCfj/qsELWQq+1ZP32rzP1SyenmkayDJz7LYxaAiXCz+zt/tUgImZCW2pOpf7qc+nth1qNiiPMwPxm00x5WfTovSYc5I252pNu+jmXWXXfZfRy3KE2NYqdvAI/7RJlImeuSe1lfK3eyJlCDRmX3tMcci4TT+HYkNamlALwDZz9kGwTOmhZ+OiajQTOMi/90O4R98KoAoY8GTmhOiRj8aPm5I7L8kCAZw8GqfJ1RXLQkhk2jzJWBCJubQPqmQb8b2yvWcudIq9sg/XSkNH3RZqb9odKGZG1fya4IynEExEmPbPojxCI3hfrEl3BkGfF38wvG/9hGyFfp/hDuIvjLclGequXZxMsTkzIld8QBa23HENF43g1Q3PtfAXQfAm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(55112099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2hadGpIQnJ5M2NtN2ZFaS9ldzJLbFM1aE9ROTdnSk5XamtNRklsUGxtVEkz?=
 =?utf-8?B?emttczlkMUExQkRFVjJLeFRFZW02R0s3LzBROE90RkRWV2syR01tdnJHZWFU?=
 =?utf-8?B?UFYwRGtaVzREQnNwVEUwOEN4aVI2NGR3OTQ1VEJXNURwNzh4Y2M1MGFLUlJM?=
 =?utf-8?B?MUxwaXVQMjYySWdIby85cVBUYnp3ZzJ1anpzclhuR2c3b3ljdVNodVgxcVRH?=
 =?utf-8?B?Rlp2eHkrMkU3aVlTRkNMQzhmUzA5aENSKzVsQzFUNHBFZVFvVm5yYVhWTUtF?=
 =?utf-8?B?N3ZzZmdCQ0JxUHZPZWpiVDN2T0dkUE1FVVEySjNFcnpMVTFzSURRMncvM3pq?=
 =?utf-8?B?a0VPRGFYZnJmLy9yM2lxMWNvbUkyYmdKSFpJd09vMnFtTlU5eGR1S01ZTWpT?=
 =?utf-8?B?TjUrQk55VWFZUnd1ZDMvTWlvSzNFWEFjSkdxbDJ5aWVJcWxlc0U0OStjQzV3?=
 =?utf-8?B?T0pKWDR0WHpOajA5eW9ySU55RXZBdUhGVTNJTEcvNWd3MVZIdDdaU3BvdlJa?=
 =?utf-8?B?NkoxQjBBV3Y2SFV5TGxKZktLOEdKWmVMc2tWeUpJV0xFUytTRkJsWm11WkdN?=
 =?utf-8?B?U0l2VzB0ZnlqNkI3VVpZUVovQjRWWHBsUG1EcnllczE5L2RvanRwODFLMnBn?=
 =?utf-8?B?cFQxNk05WllJTGRHZVFMamRKSDBMSG9McU1vcGp5MEdaVkpYUnVwQW9HMG5k?=
 =?utf-8?B?Vm1BZzR1Tk41K3h3WXJlUnVueExMZWIrc2VaUk1oR2V4UmYzSEJPYXdXRE9I?=
 =?utf-8?B?YWdLTzIxZTFFRXR0SDkxcDk5ZXFVekozOERldUNYbVZqdFVaUzZkNm9ybXJY?=
 =?utf-8?B?NjZLUjFQNmEzRld4d3kycjBVVWpydnkwWWJpckE0U2UxVXNxeGF5bExaSnZv?=
 =?utf-8?B?NTAyc3Y5SmVOT0JodUcyVEIwbGQwajRveVR1d1lxeGJZQmFPWlF3dHBFL1Ns?=
 =?utf-8?B?RG9wTFVyVjZxallnd1VBbzBYU0RSeHlSczd6VjYyQnFtUVdtMVc5SzFFWDZR?=
 =?utf-8?B?YmlUWG5lc3RhdXlKWUJwWnQ2TityWDlzOGdBbXdxbmtRZWpSVHV3TVJ5Wm1L?=
 =?utf-8?B?L1lldVZiMDdpdDBOUnRjcy9mWS9CODBvbXhjdlEycUthdy90Wkh2Uk5ocDh0?=
 =?utf-8?B?SkE3a1JobzU1ajV2eW91bGF2SkRnM05FTFZLaDh3ZFlJaFFUZmhYT3Q3T1kz?=
 =?utf-8?B?dzRzSnpHQUJ1QjZLUEt2QVJYTUYyc2lVVUVWcUo4VkVLVzhNd0o1ZGVaVytw?=
 =?utf-8?B?VnZUb1dyZHE2UExTczNYSktzclhRYWJQMWROeWJmZzFUOGpsMHB3VlFUVGJ0?=
 =?utf-8?B?dnIvUzgva3R3NlFMaVNCVHZBdGZ6VzZuQitkUytRY21PckdNUkpGdE03eGk2?=
 =?utf-8?B?eENUNFVsczcvWVFUWVQvTmNuVlQxSzRBQjE4V1l6OU1nUWxyNUZITnRCQVNQ?=
 =?utf-8?B?WGlUMldCeTVZOXJ3MVVtOW1xd05yWHJuWVh2MkJKbjdkNzd3dGM1SDI2MnRD?=
 =?utf-8?B?UkZZeWtWbTB0QmJXMUhFQmxsVjBia0FmNjFvSGx2UXJERTFWYVk3RnFBV1Jr?=
 =?utf-8?B?dGFFckFoWTUveFpja1V3YzVJeXhqTnlQZ0E2WFlrUzR2RmliTXZRVy82R2dt?=
 =?utf-8?B?b0YycFBSQXFJTW5sVjVKWGFzMEZtVUI1Rzh0SW95M1NMeDZYRHBQdjZ1eHBN?=
 =?utf-8?B?WE8rUUVnOWlqSFZtRm5JY0hVWVl3TFZsT0FoemRYWEpTM0Q3aEJMTVBXSktK?=
 =?utf-8?B?ckp6cWwyQjFieFlrcXFtN2REOU9vc3FGaHNlMDVaNEdmWlBROUQ0YkVpd04y?=
 =?utf-8?B?WkF6S2NSYzZYVEtPVDlONkVjbitMOXhzanU4M1NWSHF6S0Y2M0x1b2d1dXRF?=
 =?utf-8?B?bC9PU1ppbCtWbVRWSXc2cS9CV3gvRytpVWFYbGErOFp4dHR1QkJ5NFowRDBs?=
 =?utf-8?B?cW1lMnY1S2Z0NGdiUm5ZVHQ4NE42cE5wWHJIaDlXamcrL3lxaXloSzkyZmk0?=
 =?utf-8?B?SkV3cHRrTGdzWHJVOFV4QWd0eXhLbFhBZ2xrRklETHZjSCtrNEVlL1pzUGRv?=
 =?utf-8?B?cXdUNjFjb3RIQnhNN29TVG1oMTFEanNWcVdKa0ZUMi9JVUl3YjI3WWRxTklG?=
 =?utf-8?B?S3V3cmhON3krNWRNYStRcWozQUNJN3NKWXFZQklLVWx3dlg4aHZqNXBaNFB0?=
 =?utf-8?B?ZlBvdnJRS25wNng4anQwRldFUTAxbDlGQnlyYUJnQWNuckFlVXBlRjMwQUh2?=
 =?utf-8?B?YWNXb2FjaXhYbUVrQlpTeU90bWMyZ2s3aWJEN3NkeFVRUW93MXFQcGlxMVRG?=
 =?utf-8?B?b256RGtlM0ZvZTllYmtOb09kWUo0c3ptN2JWck5oSE10NmpHRkpFdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275e557b-6d71-4b37-66aa-08decaa9d809
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 06:46:35.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjhpEM1okORlvFD3Iu79k0+r1jd/QlJ6SjnTSRonS/Dr+u3T0Hyss8kB6Ej0c7qxDwOGC0Az0hhCLJWpj6YQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5655

On 15.06.26 08:42, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This shall be invoked before a thread switch, providing both the current
>>> and the next thread as arguments. Some scheduling classes may need it to
>>> correctly handle their state as the sched_pick may not be invoked when a
>>> higher-weighted class is providing the next thread.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  include/evl/sched.h     | 2 ++
>>>  kernel/evl/sched/core.c | 5 +++++
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>> index ae9690860146c..0b16f1b1cf626 100644
>>> --- a/include/evl/sched.h
>>> +++ b/include/evl/sched.h
>>> @@ -120,6 +120,8 @@ struct evl_sched_class {
>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>> +	void (*sched_out)(struct evl_thread *thread,
>>> +			  struct evl_thread *next);
>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>  			      struct evl_rq *rq);
>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>> index eb133e334d30f..0d49fc16bd67e 100644
>>> --- a/kernel/evl/sched/core.c
>>> +++ b/kernel/evl/sched/core.c
>>> @@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
>>>   */
>>>  void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>  {
>>> +	struct evl_sched_class *prev_schedclass;
>>>  	struct evl_rq *this_rq = this_evl_rq();
>>>  	struct evl_thread *prev, *next, *curr;
>>>  	bool leaving_inband, inband_tail;
>>> @@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>  	this_rq->curr = next;
>>>  	leaving_inband = false;
>>>  
>>> +	prev_schedclass = prev->sched_class;
>>> +	if (prev_schedclass->sched_out)
>>> +		prev_schedclass->sched_out(prev, next);
>>> +
>>>  	/*
>>>  	 * Careful: we _must_ have updated this_rq->curr before
>>>  	 * performing the rest of the context switch code
>>
>> I've been working on this lately too. It turns out that we need more
>> than this, although this is definitely part of the solution. I'll follow
>> up on this issue.
> 
> This is still wip, I'm sharing this early to discuss details for
> reconciling both proposals (the hunk in __evl_schedule() is merely
> cosmetic, no functional change).
> 
> commit f49dbd63c1389a6b99508ef0da852545b102d1cc (HEAD -> wip/fix-quota-sched)
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Sun Jun 14 12:08:59 2026 +0200
> 
>     evl: sched/quota: fix budget tracking on preemption
>     
>     Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
>     runtime budget of the former is inaccurately tracked. This is due to
>     the fifo->pick() handler returning a valid thread, which prevents the
>     quota->pick() handler from being called. As a result, the last runtime
>     period of the outgoing thread is not accounted for.
>     
>     To fix this, we introduce a new sched_out() handler which is called
>     for the outgoing thread, which the quota policy uses to update the
>     remaining budget of preempted threads appropriately. In addition, the
>     implementation no longer shares the runnable thread queue with
>     SCHED_FIFO.
>     
>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> 
> diff --git a/include/evl/sched.h b/include/evl/sched.h
> index ae9690860146..cc824c28004b 100644
> --- a/include/evl/sched.h
> +++ b/include/evl/sched.h
> @@ -120,6 +120,7 @@ struct evl_sched_class {
>  	void (*sched_dequeue)(struct evl_thread *thread);
>  	void (*sched_requeue)(struct evl_thread *thread);
>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
> +	void (*sched_out)(struct evl_thread *thread);

The out handler also needs the target thread in order to identify if
there is a tg change or not.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
