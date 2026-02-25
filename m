Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED889387362
	for <xenomai@lists.linux.dev>; Wed, 25 Feb 2026 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030181; cv=fail; b=tLfsqdcEarAxyQz2JEuNrVvVN9xgQyVgIQ0Wf6l01t8oknbEMku1V6luGgqCcgfdJuPiAg3XvKnKl0i/IjRWc/iuq1HANcAP/DYGB/DX+QLkQnBsJKWv6LWanOcT7GK2CaDlZZ25tlK9b5dBNRJEkTNS0Tx06ibPMbmw+eC3T7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030181; c=relaxed/simple;
	bh=yoyC0CD2gTn5U6B6qKPLJnt0TLK4NdIO+oUlO4X3NlA=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBUSgWIZ65wSvIm0nwwJeOdYjRO0uRQqqxKdq4tyhpJDQXvUF4WVUlFVoAsEcM0z6WV4dha+REfKkoUgPVQMLNcNHTe8b7AXSaVUuF+5/HofEEeRMsXWBpHn9CVO4uvUv+rYO3grUAT3R375Xu+hFaJqRAwomQ4zc3j7Y/q3WfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eT9dr7fB; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eT9dr7fB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2sy38Zu+jJR9Ag2b/5qDvbcjx4cbNvBfkAdyP89yOR+cXOb7kc3l1cw48YJBIZ4M9HKMf4fI017zg/8rV7UeeJphxR64PxGGCJZEW1NB3LA8bK2+v0eR9uLkUG/lCiaCJebLOGOBHUP9rTws/GZQ+N6cKunUFieOkD2lFpFTerG5xn+YQ1qwpCeGEJGh8mRocHzJBi8c4qUXwknOGyXLOJ7GNCUqDX0fIv6T3hMLPT1q0oGGOAFuJKR0fDP/9A6Vdfmxtz38VY109glCcmF0phxWop9u+6Ol2R0Fl3Jn5mgqepZB7KsFZXh179vIRKr/Hx9Jiy2Edp2wtEZNNUmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gG5e7cu6gPGJguv4linhloN/WXVD71WfMfdnWgBM7s=;
 b=Psh26uSiYuSdnHGdeayR7F26GpkFPEnq6reYtZ36GnAYa0XEJvYqmKNX0KeR6EUnQ3RA/DQAqJXNg/tb/9livaCn1ZrTOkqpKu2ALAW8QWcfbkX1okKpJb9qpJOqMhP+AJ9UmXt/QP41KMXev4TgyiR24sUYl4gaTad96SAawtxFBPtfuGehyA3dlJgeT32CO9SUs9OmbK3EndmgIlQbPAYNLbRN842iEqomZ3017kiPRNn4EQBXg1hVgajdd0bJQqnbqht8cX44S+a8WPLKIcXJcfQH4a/XUSC70NDXVJOwotBkXhK4dfReUTVFjVoPs+AEticmwSUjUCBIQgQF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gG5e7cu6gPGJguv4linhloN/WXVD71WfMfdnWgBM7s=;
 b=eT9dr7fBxTjE5tGcuSlydaeA/5W4miFt69wpUAVl2w8F21z2ws8eDVNWdVHzVZCdRpxkKFuJ7LZHfjmTJ4CR/qGSJe7p1pj1CE3nKJ2JU2kfkp9z9Kpec6Q6hGTrVAudppBA+7P/FnWmkXtSGsqrk7wTZAcXXz8uktd4lW+FwNAfODDw56hrTAuWv1rOWkka12vhQEhVIhOyxiYPavoUlfAMLxj30byTFv6qd+kyuDVCk7SAnN+VhgV0QEFeh/b9V/HsXAo7qZRfvaxBPhMVop8eRgAuoeTxxsd9c6MrkayVvmtuLXb/CPS/BXTRcO9QaPYmrr4zYXw3GIH19imboA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 14:36:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:36:17 +0000
Message-ID: <c2a6c8bf-0bb9-470c-81f1-bd3dd60c5f3f@siemens.com>
Date: Wed, 25 Feb 2026 15:36:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
 <20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
 <cbadbf4e-0d05-476e-8d18-49436fe52868@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cbadbf4e-0d05-476e-8d18-49436fe52868@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: b487adea-4a93-44c3-a689-08de747b3bf0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	gkmYu3PIX2DjFJPAdplKks4BEZHpzMGdj6NpXgfYqJjaxeZYfQOdAchMz2Mqr+AaIBdFmV1Ea+KVHj0bi7ECOicmfj9tFZh8b+UthTS2jrkBqL/S78sdH2P0AzpoDCs3zIUH4KAh1xhi77gsxK/pkZO9Xi56cl+UaL0Ofy21CdXLeqzndob4DabOfYL6zMvKejjhcgb+QrzvE2QszmD+71zb2kUblZylx0L+pKupnc+vdP1IIIXrpNYT5Pg1GjIlgclnj7M2648nBKG2mepYj1iTVT3kke7NqoMaiaQBah+w6Ft4hgttsdTCF/BQnsGGhpz0UzrBqYJ5OrCF6F3BmvAYUCGwd02zluOpMbsKmCjZyPUgHvquxHiZus2RPvEFuCaCiPkO8MDdyqNenYNUlEXcKcc20vhNkTzRrnuohWy27WsYVw9kU1kJQF5HepTBeo1cjjXm8LVxkeS1aFqyIRb5LONiaFztBi7XJIh/IY9Kr3MUav8x4R31C8hEB/TAa5ix9xYYoxFmMfZYyzBw1QrhbBJTfkUa9JhdQeNVAgBW+zKgUmvUTL8TJnuyxuDWcnbjuCdv9NK2njz5pjlDfE/gIqwAHgI4tadNmW0Bs3bBbttZvZvKbhaJhdb9V21mbtRZDDHtkQM3/ZTvtuf1Knt0SHmdxaZQaL9cHbBMo8hi60tUNm+WsmB+5BUpAcG4NX8sQwWcZePn8PJWZCswAzXARbBIUmVJd+ASDZiM46o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFRIeFd0bnBLNTRlalZURzBTbzlqSUY4SG9maUVlNjNlSnlLblJ2amxFZnFy?=
 =?utf-8?B?MWZRUzhaQ0xtcHhWOEd5aG81b3dEMWVwOWJGam94bUYwQUJJZWYvY0dGUUpu?=
 =?utf-8?B?SjhCdWl1cFBaUFRIWXNNbitnT1p4dElSSncvYWZqQmNZK1VEcVllQ2FkK2Jp?=
 =?utf-8?B?Wkw1YlF0SXNBdS91dUVkNzFqdDYxRk1ON0RPZHJFNyt5WmhvZS93WUJrMnla?=
 =?utf-8?B?WGNGNXV2VmJIVjJ2LytwSGpyV0lRMXJvdUZwT0kzWjNoUlZKOVJhY0NMZ2Yw?=
 =?utf-8?B?WEp1WnYzT0JIUjZVcldrZEhRUmF0cVh0cHlmbFhsTEp5VlVlWDhBaGJJU09P?=
 =?utf-8?B?Ym9DMWd1SUJNQUpEUjNRRmltVlR0c0YzVVViUWJLZmt3Q1czQUhPaEdmbFB3?=
 =?utf-8?B?dDZTUE5CalQxWmt3a3BTVWFDZTE1QVV5eWVrN2JNQ29kcm1jbUZ1RUJtZWlI?=
 =?utf-8?B?TjJvV0o0a0pzN0E5amMxd2dCY3B0ZndNanp6eWtGU1l5VnNRSlorLzNUVmFS?=
 =?utf-8?B?YVpjaHFobm12NDVPNGNKUVVBTkhKUndtREoySGREMVViNW1paXFZckkrNDRJ?=
 =?utf-8?B?OHFHdGIrNXliMm8ySmFyeXdVVUU0R2pUMEZrS3h0dGNjUUxzUmtENnJxek53?=
 =?utf-8?B?WFR4MlJYVFpTZG9VYzFUZDEzRjI4amp0Y2NUbXlxcGZadWlLTlBUemE1YVg0?=
 =?utf-8?B?cHNXcTRzM0hmMEVaa2FjZXdoRThXTm4vWkZEMk9RbzdiWEk4ZVg3cDFYUDhC?=
 =?utf-8?B?TWhaeTNWMS9jeXR6Sjc2ZDF6dHBHMDEwdnNPMkNjMndKbFErOE1YS1FLLzAv?=
 =?utf-8?B?ZXpJaXlvaUhGT3ExcDdiemZaN2hwZS9nZnRpRTdCbVlCbXc1SVFibVFRYkVS?=
 =?utf-8?B?Tm1FK0Joejl1SnNIZFBwZzdBYVVPTHM3Qjl0TWFyVzVKSTRMb3VWZ3NBSmM3?=
 =?utf-8?B?NlJXN20rMWJoSGdZVDFNckNCUHRFb1JsaVlpK2hidHAzQWY3UTcvME1MUFhP?=
 =?utf-8?B?RHgzYVVXRjhMUWpYNjlML2I0aE8wV0lCZWlMUUQ5VlZvSU9saXRtSGlkOWpP?=
 =?utf-8?B?QkhpVDNyUUVwSnhxYWcyakxmVmZlTlB5dksxQnBCOUM3cGcySmgxWjJndU0y?=
 =?utf-8?B?R3FvVytMVEFZOEFyVUVqZ3B2K1V1UlBZdFI3eElUaWV5VnBPNXhIOG1lSHU1?=
 =?utf-8?B?VGpMek8vK3RQRVlYL3lMSFRMbHdQTnBDQ3J3QWpuL2pXUEVrYjNVaUcrWW56?=
 =?utf-8?B?V01EUGx5Z2VDdWVpbE5lY2M0UmpLeGt5cTNTd202T1BsUWtCMWZ2ME1GalJl?=
 =?utf-8?B?cXkxSG00Q1l4dS9KSHYwaFlKaFRGTXNGc0dHcDVzaVVORm5VZnVvRlRtaytL?=
 =?utf-8?B?OVlMREg0c0RhZnRnTzNvY2ppUXR3cDdQUmJTOTkrV1Fha252U0krdW5jUmYz?=
 =?utf-8?B?d0VSUHRNWCtiaHJYOXBNZjhjVDc2VThGQmx3dXpzcHkwQ0ZqM1pqRnRFL24y?=
 =?utf-8?B?OFNoMTJJSUxJVFJsek1CSDZKT3NBMS9KWjlxdEptYnh2WFc1azdONnpsQ0E5?=
 =?utf-8?B?SE8vYTBkdnlnSERQanZvN1FXd2g2ZTVkeHF6cGRoWVp6SThROGV5Z3o5Z3hH?=
 =?utf-8?B?SnhzSWdPdE9EOU1rbCtLYnJ4SGZMV1FwZkV2eWZLZW95M2RmN1VNMTUzSit4?=
 =?utf-8?B?TVB6dDNkRmtSaXN0TU1rTDU3KzVMQlhGOU4wNDBGL293UXM0RWVTcXdEV0hW?=
 =?utf-8?B?UnQ3SlJIZUdoQldFOTJwLy9uZnlKZHJZZTRjU3N3ZHlKVGI5YWhnNWFjQ0pU?=
 =?utf-8?B?Qmc5QTlLa01UUVc2Q1ZrVmJRTjZQVnYyQ2RJWHRVa0pPVXhDQTV1emFJTUtX?=
 =?utf-8?B?Q0hjWG1Rdmc2cS9IMlg0cjV2NWdXN0RTSjhJT0RVbFg1YmptTFJnL3paZ3RK?=
 =?utf-8?B?SXVzTFR2djlIWmJBZkgxLzV1QXY3K2hMVnp3Nzc4RjZJSlZUbURCalRJWUkw?=
 =?utf-8?B?NUw5M0NpTzVvejA2RGVSRGVJbjdETzI1VUN1bFhsVXJkYzR4cDBQN2xpRFhZ?=
 =?utf-8?B?RjZ1aVVnUmZFc2xUOTFlazkyeWlTNWZFZEFTLy8zQURleDhFZnZTYVgvd1l5?=
 =?utf-8?B?TllzZ0tqK0JxU1lkZjVnR2UvR3EvMzJSTFB2RkZBVUNaN0xlVDZuRFowajRa?=
 =?utf-8?B?TmpPTXltVHZPcGVGZitEZVZnOE1BUVJ6UTQ3ZDRKQlVieUlCZjRDNldzMzAy?=
 =?utf-8?B?djd3RFpLR1dYY0s0QzJHL1JHRStiSTVDT2NIcXRlekM1Y2NVMEEvdnNkTUhM?=
 =?utf-8?B?Vjd4QTJpalVzdzh2Rk8rYnMrZXZOZEViLzh0TTRHTHRVU2hYTVU5L2RiR0tM?=
 =?utf-8?Q?EYWTaHSi9HNy9qno=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b487adea-4a93-44c3-a689-08de747b3bf0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:36:17.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js7o3iHqDz4D7tIv1d0jYPDHAPDFbpAdywYjtP7E6gVY4LVkj9/TrODOt9ObpsN8wcKeKi+R0vAv+Q/TfTviNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8721

On 24.02.26 22:11, Jan Kiszka wrote:
> On 20.02.26 12:27, Florian Bezdeka wrote:
>> The signature of __request_percpu_irq() got one additional affinity
>> parameter in 6.19 and 7.0 will remove the function entirely.
>>
>> Dovetail 6.19 will introduce a new dovetail specific service called
>> request_percpu_irq_affinity_flags() that allows us to set flags and
>> affinity at the same time.
>>
>> It might happen that older Dovetail versions get the new API via
>> backports, so the re-#definement for older kernels might get
>> obsolete earlier than dropping support for Dovetail < 6.19.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 6 ++++++
>>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 9 ++++-----
>>  include/cobalt/kernel/dovetail/pipeline/sirq.h     | 9 ++++-----
>>  kernel/cobalt/dovetail/tick.c                      | 8 ++++----
>>  4 files changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
>> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..df0b8ceb05c25d655a331d238e7ef8ac8a6afeea 100644
>> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
>> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
>> @@ -5,6 +5,12 @@
>>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
>> +#define request_percpu_irq_affinity_flags(irq, handler, flags, devname,        \
>> +					  affinity, dev_id)                    \
>> +	__request_percpu_irq(irq, handler, flags, devname, dev_id)
> 
> BTW, this effectively invalidates the affinity parameter. Before we
> could make use of it, we would have to backport the dovetail function to
> older kernels as well (6.1 right now).
> 

For the time being, I would like to have a WARN_ON_ONCE(affinity !=
NULL) in the wrapper so that we have a chance to detect future overuse
of the new API.

> At the same time, we seem to be forced to create all the OOB interrupts
> on all the cores anyway, even when supported_cpus is set to a smaller
> set. I do not recall why that is the case, I just vaguely remember
> having asked this before. And as long as it is required, the new
> affinity parameter will remain NULL.

Would still be interesting to recap this aspect, both for classic cobalt
(supported_cpus) but also the evl core (oobcpus). Even if the lock
contention in the absence of a global nklock is not there anymore, I
guess there would be value in not having to proxy the timer on cores
that do not host RT workload. But evl is currently requesting the proxy
for all cpus as well, isn't it?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
