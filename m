Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462E2DEA6B
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769856; cv=fail; b=iIIbg7UEO8nheuKeE/c+blmukvAB9oMwDJwqNYllAGAJH1P2MqTcttsojn2oI7Al2y3O9grPTGlwvBj1b/wtqQ4Ct0EouDOpmbjSi0aPQJqXEECE+9NYuKc8X+CMo/lenXx5VdkjTBhKM/ekGpx4bjVkNMWh43g00Tq6hC0Q1g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769856; c=relaxed/simple;
	bh=QM+96IHzGZ3SoQjeQhqdFOHMkQ5fL0WOu/Vt0Gpq7+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VdWUmDGrC/Ln6RWR/OXGgsp3as2g2SZmW4Cs4wNt1EbfbfKEKZgFZ0K5rUCUod9wuxKiPkYRi57OWCGQB/kytiK5JLQ4/vXJ9GWmRH/bsVSNnjLGHlUvZ1Cyk7mxolP+lIVkTaI1yKUYsb2t143ZisdATwOmJpx12GwSfPARpxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bcm5+j8D; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bcm5+j8D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ/Z+rZwsjLgYrrNgH7o6eXOOEzsueWkrn4iEeuEwcTnLR4dB4XForOHsbSNeI9NCiON7my7RpLfDcpxnOuReO4oyoLh4Wux3ZvLuB2Qi23IyIxfhZJBWM+ylO1WvpWnkQrhTgs2g5r0UxCz8Rjr8qx92bFU+2HrtHQenlj1Kbq6DFXiFSNM0hUGGyTGLEW2DrzymZlu2NRPzqKnHBa3Wk2QRSefDKCxWiqCa31p8uJw+72CYeCHkW48wxvoBDOrqFa0JM59FC6DgPBoM1W4JFTmlWqUKayp1UA6+Tjua/VhBg2Gn+MuPiWb4dd7cDvQER0joKxDeKxN1NTFhj+IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrMFz9/hEuYMMYoJqUdPfHWgqv81PvAWPFNRZNSYRtY=;
 b=KOgP8j7fEIJBAVTfPLjBXPF/sSCSzwWqdPXIakczhho1svJeji3FpdR7tSDk29MO8Ehi5sMJzv8PYv/vqjbs+DL1u7ZMmsTOk/otpetoNFj7geq/6SyVx+mWD9operbDjbNG3qQ7EZH0DXnhf/HyCdWDX77bV25RnFG6DMbHFbhuDMXH1GUKaWcRpPmYOPKbujb1SUMOiw1hwJcwtSsFXRd460mL+yp/aTMTHKsy02R1qBizYYd8wgE9vA5JChq4ATB5lL+wMAsoY3GjaFamu6ttXPWQ3hCYjusU8vXZkb94HHcpzafw12N97LWG7HIX1l5WAy/s1ZxKxc9yCJQAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrMFz9/hEuYMMYoJqUdPfHWgqv81PvAWPFNRZNSYRtY=;
 b=bcm5+j8DkboHXQkcglW/WzO4qOgq9EphPwl/i4D5XxjwACiZesa3S5kmhfEz5DezOzHAtec8QOoh6A0+/F6JIHQXWZqa2qUEGG1v0ZsrpVHV6NaTu7rXustA4phYnptpgJKol+FuJmuKSfHeBR2F9he1gqGCAm7vxTtb8p/fFTIZOyjGuvEaxmHGUFELHxxfR/AzRt72Y+Gm+3roF3CRa84HTQoss7stn0V+uBuWlao96ZG0Zz0W8BpaQSSsHIq26Btk+Sh91Y1Q/28M0GQktmszpLE9MWR05Xs1Hd5Q6SS7gmzYpGoyU2I8AQV8iwx11umYbxZpskdaQP9Q25gHbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8430.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 08:04:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:04:09 +0000
Message-ID: <58885755-a25b-4b71-86f9-166d0428990e@siemens.com>
Date: Thu, 18 Jun 2026 10:04:09 +0200
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
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ad9551-9b44-4ea4-41f6-08decd102d62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|5023799004|55112099003;
X-Microsoft-Antispam-Message-Info:
	ImKz9xeMNRTYI0RxBGZr2TS+j61dksqskAMhyFEgTCvDiTNS4q8bZjpy8sO1rcMMBvPtqH6KXpu2Sb5OKiaFDw1BT7xvr6FVk8FYRksbwF/W5AyUzl8n0AT05uG64SzZ/dCIKcef6355gRMOSchivaUnoH9r3L2C1mgsMruT3vtUSrphm7LnXqz6wCqGLGSRHHVNc1M3qRFcfRVK5WiqPSdAXHENR2dw/a31RNx/QgyoZGr9zuTJUKEG2+0wFuuqbKcNdicp4qGuMkmZNnuDGhA3FdFt9uwZYnkS7ugHg0MPNH47yOmIa4vqd4HhQgTTz5rcavfKhDHXwcrOJ9oAz/jRKW27jBRnTfqdRlhkcLErnSUwdIoOZEwyV+Xni2Vk4kSKPjQPaGUn97H9Mz19++WJMK5ZTRatiGV1OFtclU1p0aCmVDMH9/Mi59WV0mEO9nJsz8XySv/9sfSbqTJLzcDMBK49eJQ/zf0SCp1KYPpQlu2jRkkAUM5/Y5Ksv7ifLjFfHzh5sgoEeYqqlLXWyamMCvokTJtB3Dd6q3pQ7xC3lwDFWmgzOnyiHaiDvFAdKpCj3Fwm/zzZMMUJVEHw53y6ToveSp1dwbCb4lOaQEq3pp4G2Ez+vbKwXvVh/oAWo3Qx9WOL/Hdxfkv4szmM/m8XvxKM3C6A7Ja0xiU3tqpryFxuGNj+qbjU8iL7dl6b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(5023799004)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em1WQnBIZVBVU0JRb2htamZoa1pkUUNvZ3lCN2xvT3FTaGg0eTJkRGtHVkFJ?=
 =?utf-8?B?M3pQZjhZbFF3NEpSNEhxZjJjRWk4TStXNzNGM3JqMlBOT2gxM3M4UDJkOVhP?=
 =?utf-8?B?a0JGUHZxZUd3eDJ1R1ZybGRnNG5CNUZiY0NiOHVFM0E1bHppVkRyZnpHTllE?=
 =?utf-8?B?SndpR1dweHFUYnpxYXlFU2NUVmxKNFluMndqd1krb2I1bDhCZTBZMTB5RlNn?=
 =?utf-8?B?NkJTYTh0TzhienVWU0xnMmo0cnNxam5tb1VLVEdvcXdhTjZLNTk4L041S0Ey?=
 =?utf-8?B?RGhUYmZqTEM2T1paRzRnTnk2UmhWR1ZqQkVGZi90WTJ5Qkk2UE1GVFU3b0xO?=
 =?utf-8?B?cE1Cc0xFRkd1ZjRKOVZ2c0lyU2M0RktkcWhZcS9FOFRRbzNDSDhCSnkwQXV6?=
 =?utf-8?B?MWNUUEQxTHJKVHhsVXhSZ0dDVkxBVDdENnJxY1N4d3JXNnBUM1hxM1FNZFdN?=
 =?utf-8?B?OGdMcWxpdzdlR1lJOEluK3QwVFNldmw2L2FlZWZwdSt3Qlpud3dBMVhodXp5?=
 =?utf-8?B?dHBwVnphN2wrNWk2NnZ1dDJDbVJyQnV1L2NZRC9qeVo2eHJkV1pkdzJPM0hv?=
 =?utf-8?B?VEdETm1CSnFxTlA5UnNpSys5TEsxd1JFWDlaMFEwRGlCSTB3Z0JUbkpCVXM1?=
 =?utf-8?B?UnNoQ2phMkRqNGttK29ESEs0NjR2bWV4bStObG96RXcyTW1OOXJCSjhRb1d3?=
 =?utf-8?B?UFIvUzk5NVd3dEpUSFpRT20wQzd4Q1h2enFVck1rb09XMVFDWVdGc2Vmc3gr?=
 =?utf-8?B?YTZ2NkVXZG5aRitvbUJGcUIzL3BGNHFHVHIzZ0h4bExESlpBVEw4cU5CQlVo?=
 =?utf-8?B?WkFZc2pQeWgvNlJTTnFscHhYakJsT1V6cFRmdm5oUEU4aVlFUFR6d2xMM3dY?=
 =?utf-8?B?V3lWUWt5OGFpZTdBN2p3UUVWNkZpYzVjR3BvR041ZjhZU0FFaXFtZmo0MFBj?=
 =?utf-8?B?YkZKTHA5aXVZM2RWV3hjemdnbkxEZ3I3OHNEaG91bi9ndWZtS2JleUNHWTda?=
 =?utf-8?B?eWRIVGtyZ0MzZ2lPSks0OVNtajVCcVFFa0taYVdHS1JXeVNMcWtiWEdCT1FU?=
 =?utf-8?B?LzNtbkp3NUJMUy9RL1lzSWVyazJrREtoVmNCdzBXREN2R1pKRVNCODFIRGFj?=
 =?utf-8?B?Mnp6eFdXcXoycE1kZ0lDS1ExUXNuaUY4anBCUTE3b1RZc0dpTzBIM29kSVZ0?=
 =?utf-8?B?ek9FYy9LN250TUFZakF2emVlK2Iwb2pwOWpzZGx5YS9ZRk1DL3NhT3R5cU5p?=
 =?utf-8?B?SnRMNlgxUy9tT05YUytxTWRBd0o2UXBwRTFzRlBlNlNaQ2cyN1M4M2RDNEMz?=
 =?utf-8?B?NjBTSTczemRnTEgvTHZOYnNlYjY5RlhCaXlPZzFpZURkcENQMnA5MytqTmZD?=
 =?utf-8?B?SzVZQVJ1NmtNbUFtMWZTM0p3L1FkZkJtOVdvMFNJSDN4QnR1QURSdWpVTVdo?=
 =?utf-8?B?blJoZE4rTzc1RGpwbkRZSkY0MVo3U1pHQmxEbEg0bStpV0dZZjd6eU1qWk1F?=
 =?utf-8?B?NDEwVjBJOS90ZUxXZHZtR084anJPMWZpQVdYQUFveW90MVpTN0NybSsxWE5i?=
 =?utf-8?B?QW5LaTZLemZlMG5BLzlwdnluaWxPanVxUFhCTE4xTVQ3emNQVzl2YzFkWlhG?=
 =?utf-8?B?ajlNWUVheUEzOWxSeVkyK3F0WHZzZEE1eFRHYW1FUmVxNTFqTTZvbWNUM216?=
 =?utf-8?B?N0ZJZnh1S1hqS24vWmhWbnNuSStYQlorRkZ5REsxTjkyY0lrSGZmZE5tOE1p?=
 =?utf-8?B?TXp6UzFGalQzeW5OanQ5NEVZaUNpQkRkV29veit6TUdjZFhBOTRTa080TlVM?=
 =?utf-8?B?K2pBT2g1RWtZbFZWTVZWYWlmYUFzaTA2OEkxU3NnZTB5YkkvN0tSSnk4VU9K?=
 =?utf-8?B?cE5GMTN4OGtDb0JxMDdWcUtFMVNyb3c0TzJRZ2F0bGxGSHdHZmJLelFQTmFv?=
 =?utf-8?B?UzJKZ0s2UzJaOTQrYW14Um5iL0E2RWRJK0t4MFFUcHJxT1FhbXhsS0YxVWdI?=
 =?utf-8?B?bzJCU3BpbW9XcWtLUjUrazFlTDd5blJMUG5RRnUwRlViczkrd2c2MldzNi9k?=
 =?utf-8?B?V0tlTjF1ZGZsWnBhcW9LZ2F6ZWFLWDhQR0xZaGtmZG5FeTRYL1JRVFZiK3Jl?=
 =?utf-8?B?RXRWdHhQaGFzRmlPQnFBWVBLaTZvc3Y3Q0wzWTBBSkd3WlljYk4zSmg1M052?=
 =?utf-8?B?OFREemlncnk1SXpqRlN2YjdVNEJ5WXF0Y21JVE9EOW9ZMld4elJJR2hLOXhM?=
 =?utf-8?B?M2NKZVViaDduS2VpTGlLdWVhRTJXc2xscFM0aTFuc1JaK3JteGF2QjdYQ2R4?=
 =?utf-8?B?N2kwNTJ4dXNRUVhYdmtEdGkzZTdZNWdxdVBFd3lUVkJXemVHZ2lUVUpBM2hR?=
 =?utf-8?Q?w1W2Uqi4PQCXLV58=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ad9551-9b44-4ea4-41f6-08decd102d62
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 08:04:09.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ejs5TB/gVL9ei3dzkI2jKhDYs5TPdDIie2hre3HJBZRKkwI9CkFEWc3u+DKL2n5rY1dXoHfhuuumzzdoJM1RNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8430

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

BTW, I would not make lock/unlock work against different variables
names, though they carry identical pointers. That is more confusing than
the current code.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
