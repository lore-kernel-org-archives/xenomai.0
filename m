Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89990233921
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076811; cv=fail; b=I6AXbtvN1ruLWems/YupgNhGZKle6k3Y5cmIecREU7z1aA/j0RAvBanU2lKt0RR28CzvNPYsZfBc89qunYBBl2rDLt0O59DcNeP0cgG9MrXpT9RnZEkVRdT5IePuhCu1hUNGaRDnCXo+B9jGTiqmaLutGhDKVYu7m3n7D3BV7lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076811; c=relaxed/simple;
	bh=bkz/xLL/1ckTOeeAbsSXYrATECsdOFNj0qXVI5Y8hFE=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LUf1oX1fA3wi3IkCHaANy7+EOoY1VZ4TECksl0eTz5n7ZCZ76ebeeWAYhpUvoJIBAlVS5hMrFvWTzxMoJ+INlNn1xSZokLXF0bpZSJRb3RtVbft9uiAnfOCDHX4EPbL/m0xRF6wbz5k2xkik+W104sX0ZI5oiPrNZ/rzMt8dRV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hWmRgrY3; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hWmRgrY3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVdJDi+FavpPZyJXf0/VeLkvOyx9+t4vYe1d7oFBpJEXpqA/UkJop/9ik0ooiP33EGLQ/Igxpt11sq6fVBhNRcEA/s0K6R9hJ7cTeZa1EnnR2OLQH0vbkohyJxHCSWwL2/6+rYQXlMhvYDj6jQDykp8spVAw7rCCRfEblFvPL7F87eG1y8ZYNfEPj45g13WFfCZgAI+ZBe3hX/CaHDLWMLTwC9HWzZK3ph0jYgILWKW6GmSPEa/vFPx+m3CP11Wew9nwRKXOCOcDaFy5EWlu7whoSc+hqY3GdJD8aytJulrlIdHLv44PSSAhpiQYV+2TXDCS+2FeMxz+PzEHdFO7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uucg5I/rKiuyTafufLV4HbsN20i/1hz3m4xg/ZFK5/8=;
 b=VRB/f2/rsQ4qXWl+Ps5bo7lrjIUPm/YckMhOo0E3o1zz0T5q9v1Wcm7atfK+W8Duyc+DZDeWeNFfuDmVvSMO60lDGpmBHWt5eCkbmzc0Q2PGrGLc/f6Ui4aYDhMEeWnOJIEXBnb6fIizyhnNIbJVPA1OqEYyOJQ2j261sLA7q1RpF5QURvCXkFENn8pz20M3ubKAiHpmB5E5uAufaUiACb0n6Y3iEZ/p/e9H1w7VuR5zl+YDkZ2w0LZHTsh6QM+IlHnmq3jWr7Icm7lRWEFn55TK+Rpy2NaMVCjiXHpP8grSihXhfss4Y+pzjRJqYIAWI1h6EyYHHWEj8c/IHrJ16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uucg5I/rKiuyTafufLV4HbsN20i/1hz3m4xg/ZFK5/8=;
 b=hWmRgrY3JUjo1/Jps0yrS/QMgYXxSFneplDXzGgPBj9j9wzS2TbvZQz32H51Mhgctf3o1pAkVrXFOHsAYBj2PRZikTIdQklSl1UyXUKTBDMOc9Grnkh8gcN+kA2B7mqdOl0ja8hj3c8sh4vMLj3tgp21fegYRHDO0U2BRdk/UyKrsksEnyCGQY06CSrtZkcHMn6B+I/8uGiwb5/5XZc0Pez8jbdG3vKsiOn+t2NwWIOJhE36S6r2Gb376y43X8hQ+sgHkfAkkoBPpNDuL2OidErASPNgxQnPWfOxnPU61pitAjvWpiYDGIYwkE9Ct/gWex3alXubV+HZJnb5AvmU0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM6PR10MB9208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:33:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:33:24 +0000
Message-ID: <c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
Date: Wed, 10 Jun 2026 09:33:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SCHED_SPORADIC in Xenomai 3
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
 <5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM6PR10MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9479e2-7fbc-4348-adaf-08dec6c28e23
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|6133799003|55112099003|3023799007|11063799006|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	TquSeBU925D/DJDAS0HGYr1e9n5u/9Kx5AyAKX1QCvHy0lRLYxylJ30tkHANqXtscd4RXndY+ewlhesK6Pr6/1tgdtVoQ2EJ8Vq/kiQrAXVoxqoJ9m3yLjYSgYfzrN/VgKPQLeCKwY1bParhtIg5N/ET27kgWq52YGnTbwguknl5AfbYcQBtNCHRIDW6vrl0bcEnkhflXNJy8vdfZxeWu9Ui+GSpUkr2cGSr/63H+TlpnPQ1N4tIjp+UWfPaWaNT/wev4i2OSjPD0UZpj1oHFjFeLItLlUWy+sTBIQgF6ZayGIh+wk2dxo8bCpvniGf+VoSRGyDY+b4BISWFoA6hFs31SUaBUc63zFQMdl3/eHLWmE2JBBz7RpnjjZtbuigKqLnHF7p8aGamr8lY6DI7171DwLZidWqXJ66fyfK79mQf65r5CgymyUYQlKEMoaKZ8xu2QA/YHBQa/ZsOl7jrwAQblWKHwOHEXl2e8HRaY3uFoqOCOVghtqER9s+ULfhWXnWVIjS/ZHF4znb1djupG909XSlTVvuDk3cj9d4ys6C4gXvZ26/rY6J2CQcm4Tc1dU/creXCEKRo3TcwQ3yU4uHtlvJ/jX76a/h5ek71T+9Pyk+LU0NCQ7LLsBt/FjvUyeITdHDcjID+kaqasvEQJNzWjk/RKbRCzVAmzRwLpnVtBsubI75CU329KRtnrD8d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(55112099003)(3023799007)(11063799006)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlM5Rm1OcVAvRUlFMGpac2I0eEprZ09iWlphZmQrNEFSZ3BPS3JCcVNHM1Er?=
 =?utf-8?B?M0RmQStOcmZ0MFpYQlQyWmJ1UVVTUC8vUzJ1KzZRNW5kbzlLZFZmVXBtZ3Qw?=
 =?utf-8?B?bFRKVHBzbU43Mks1Zm9jK2dkZlc4aW0wZUMyRkZhMjYxdEliaFY1OVhIcFRa?=
 =?utf-8?B?SXJYWXBsTTVzUFFDMWdDUDZTQTlRcDJiaDVxNHhRTmRXVFZ0MTRCUUsxT2No?=
 =?utf-8?B?K1RnWW1JOStDMEJZanRhcDhUQXNVbVE3ZzcxS3ZMRmxXNUp5K2lwd0UvZjVT?=
 =?utf-8?B?aDRsNHlYQ0g2Mk5XRWloL3pKOWlib2RiOTlVeFhteVpSc0pqRjlLd2ZqZXJ4?=
 =?utf-8?B?Ulhxd3I4cklLSE1NZWhxSEtYK1BNK0N1Vm1qYW5ZRVdrNTJOVzFkOEJiRHc0?=
 =?utf-8?B?SDFaT0tKeGhvcW9kcmwvbDZwTWE1ZjRCeUYzVkVrQTUyM2RqeWF0QTdBSWU1?=
 =?utf-8?B?dUk0TGxGOUpSK3NMSGRsRFVZQmJvV2o4WGw2bWFmRG9SZkdWZWVTcE1DL2NP?=
 =?utf-8?B?c2pEd2RkL1JPaUVHRXZJTjRyRHNMTlRMb0lCM29vTEhoOTYyaXNLL0doT1pR?=
 =?utf-8?B?cDFEK1RNNW1TM3MwYUkrckRHcGxwZ2N0OW5wOFdlN0pUMXByVkdsRGI4ZHNm?=
 =?utf-8?B?RHJGTVRGWlV1OERoZmlkMWRXVk02TTcrVGE2S0paNE9DUjFQT2JQb0VrTFpI?=
 =?utf-8?B?bWhWMk02T0dDNXZUSTJZZ2htSXp6QXVrMDhUbFlTS1RjeGVRaHY3Y3pXcjF0?=
 =?utf-8?B?V2pZdk9YSGR2eG9HOUZhdXlqMkluZnRVaEZMNkRsYjlvMWwxMWQ2RG9WUGlM?=
 =?utf-8?B?ZjFJQnlDdUtzcC9FSmtxSGxsT2UrSlhheElzY3Q4cUZZN3NWdEM1VlVzNThD?=
 =?utf-8?B?LzNZUy9FTllITDdIS3B6MjduSU52RmZoUW8wRTQzdTJCRXBTdjFXb2lJTkxR?=
 =?utf-8?B?VzJFMjA3S2tOZU1pVXZONExmT3Z5Y1l1L0czNXhUUEZMcE9NekkxcWZsSHk2?=
 =?utf-8?B?amJkd1lMdUhKYjJ6ZGZ4c1VvMFdUa3l2MEFYNklIa0R4a2hpTnErZnE1clh6?=
 =?utf-8?B?UGhZaFBPM2lnSDJ6NlkzZGxyRHV4YzhFZjgwSzViOFB1a3c5MFdHL1M0VExZ?=
 =?utf-8?B?bDEwWEhzMGIvVjlTQjQvRkRTcTJ1NEZXYnVMdTNNWmxYU3JQNFR1Szd5VE5T?=
 =?utf-8?B?T3hyVUlSWFZOUVV5cEhGa2pNMFpoOC9wSE9lNC9ZS0ZsUFhCT1RLNTl4K1I3?=
 =?utf-8?B?TmpuZHExemJvZW9LWFQrQzVVdlo4RkRQOG1sazJQUGwydmRGdzNZUnZubTRh?=
 =?utf-8?B?aWJQV09NS3F3Y3pxL0RYZDJnQVFSRWJhRklJcHRNTEU1SGF2Zy9GZ3BVRjZh?=
 =?utf-8?B?M0VUSFd1ZFRpK3ZvTFVTYUJ6WTMxWXgyVy9uRWd0b0Zqak5ZUWVKcmY0L3FB?=
 =?utf-8?B?eENXYUQ5Y1RYaThMVDNNd1B3OEx0Y0xVNXBSZGUwZmNZb1E1QVpad3NmMm5U?=
 =?utf-8?B?UzA5UUtyYlhnMjJuOUozLzJhWU9obGYrS1pydkVFZnE2bEE4UXBMNkU3bHN6?=
 =?utf-8?B?eExudXJxSHpsbnRKYXdRZTVKZXhmVFV2VHk5VDZ5REVrQVJPcEJVc1M0V2Zn?=
 =?utf-8?B?T3RrbXJJb09GNXlnbitROGZhblBLbEdQZUlHcCs5cm9kZHB1aS9yMkZrdkVG?=
 =?utf-8?B?RElXSi93SDNSd3VIa2paL3VjNCtaMTNHS2Zja0I2ZHcvUUJ3dzErT2F0Sllk?=
 =?utf-8?B?T2dTNm1QdEw3bmcvZjhkUlJTLzFMK1UvMS96cFBGZWtMd2cyb0QrQjYzZm1S?=
 =?utf-8?B?ZWJlT3RrR1VjdTE0VlJTSHhyMEZBaTR0SWE1Y2p0eTQ2QTBteGUwVFl5UVZN?=
 =?utf-8?B?cmZGZDdIa0dlc0d1WG5UNDNrRnFFcm9lYzZEZWNUbUZoaU9PSWNROFAxSVVr?=
 =?utf-8?B?cjFRMTgybUZvUFJ2OGRzWVBUait6U3hYeEFmOVpucGUyanZTR2Z0NVBuMUlu?=
 =?utf-8?B?NnA1LzBFZ25yeWUwVUZLcStpWTRDMFZvUzJVVlM3N3pTaHV2UzJxZzFQLy9n?=
 =?utf-8?B?dU9FcDVmL1M5cTc0V0R6SURkZnhNZ1NkVDl4Q2IyVHVwd0doYXdaZnh0OTBn?=
 =?utf-8?B?dVl6a0FLM3EyRTExc0VMQ3kxRjkyY2RKZk9YSGkrT01RcXd1UEdHUXBHUSs2?=
 =?utf-8?B?aE45b2s1ekVORnVRQTA5YnZCalh1KzFlelFRMDdTZi83UzJLUDg3Vm5HakRs?=
 =?utf-8?B?TkFjYmJLSUc5UkVQRVk2MzdxbG1hTlB6WEw2cFdhaGRsZ0J0a3RFazAyK0xp?=
 =?utf-8?B?enM3aHErWVlIYkVia3FZeDNOZE9JTFE4Vk5UdGVMclZ6R1ZNL2F4UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9479e2-7fbc-4348-adaf-08dec6c28e23
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:33:24.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvwKFfRFt/QpWzwBoGTOTLcITMXoISn2s57PpU/BICOK6G/N0X9jNHtUhG6dDtb04PxFAGyLcv5/U5cNMGYlfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB9208

On 10.06.26 09:21, Jan Kiszka wrote:
> On 10.06.26 08:24, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
>> into XNHELD, a state only existing there. I suppose that was once
>> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
>> SCHED_SPORADIC - so let's dive into that scheduling class.
>>
>> Turned out it was never documented, not even linked to the POSIX
>> standard. But it also slightly differs from it (low_prio = -1 -> suspend
>> on depletion). There is also no test case, so I asked an AI for one.
>> That worked fairly well as it seems to have revealed an issue:
>>
>> Could it be that we are not properly suspending the budget tracking when
>> a higher-prio task from a different scheduling class is preempting a
>> sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
>> if a thread is selected from a higher-prio class first, namely sched-rt
>> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
>> limitation/misconfiguration? Is that issue even affecting other
>> time-slicing classes as well??
>>
>> That furthermore makes me wonder if we actually have users of
>> sched-sporadic. Likely a hard to answer question, as usual. But such a
>> limitation should have been observed earlier under real workload...
>>
>> Jan
>>
> 
> Here is a trace that proves how xnsched_sporadic_pick and, thus, 
> sporadic_suspend_activity are not called:
> 
>          disrupt-1682  [000] d..2.    94.171753: cobalt_head_sysentry: syscall=clock_nanosleep64
>          disrupt-1682  [000] d..2.    94.171755: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
>          disrupt-1682  [000] d..2.    94.171757: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)
>          disrupt-1682  [000] d..2.    94.171759: cobalt_timer_start:   timer=0xffffc900008bbb00(smokey) value=60000001 interval=0 mode=0x0
>          disrupt-1682  [000] d..2.    94.171761: cobalt_tick_shot:     next tick at 94.231756 (delay: 59995 us)
>          disrupt-1682  [000] d..2.    94.171770: cobalt_schedule:      status=0x10000000
>          disrupt-1682  [000] d..2.    94.171771: cobalt_trace_pid:     pid=1682, prio=30
>          disrupt-1682  [000] d..2.    94.171776: bprint:               xnsched_sporadic_pick: xnsched_sporadic_pick, curr=1682 next=1681
>          disrupt-1682  [000] d..2.    94.171777: bprint:               xnsched_sporadic_pick: sporadic_resume_activity, pss->budget 99964473
>          disrupt-1682  [000] d..2.    94.171778: bprint:               sporadic_schedule_drop: sporadic_schedule_drop, pss->budget 99964473
>          disrupt-1682  [000] d..2.    94.171778: cobalt_timer_start:   timer=0xffffc900008bc4d8(pss-drop) value=94216201725 interval=0 mode=0x1
>          disrupt-1682  [000] d..2.    94.171779: cobalt_switch_context: prev_name=disrupt prev_pid=1682 prev_prio=30 prev_state=0x248044 ==> next_name=ss-d next_pid=1681 next_prio=20
>             ss-d-1681  [000] d..2.    94.171784: cobalt_trace_pid:     pid=1681, prio=20
>             ss-d-1681  [000] d..2.    94.171788: cobalt_synch_acquire: synch=0xffffc900008bd408
>             ss-d-1681  [000] d..2.    94.171789: cobalt_head_sysexit:  result=0
>             ss-d-1681  [000] d..2.    94.171799: cobalt_head_sysentry: syscall=mutex_unlock
>             ss-d-1681  [000] d..2.    94.171801: cobalt_synch_release: synch=0xffffc900008bd408
>             ss-d-1681  [000] d..2.    94.171801: cobalt_head_sysexit:  result=0
>             ss-d-1681  [000] d..2.    94.231786: cobalt_timer_expire:  timer=0xffffc900008bbb00
>             ss-d-1681  [000] d..2.    94.231789: cobalt_thread_resume: name=disrupt pid=1682 mask=0x4
>             ss-d-1681  [000] d..2.    94.231790: cobalt_trace_pid:     pid=1682, prio=30
>             ss-d-1681  [000] d..2.    94.231791: cobalt_timer_stop:    timer=0xffffc900008bbb00
>             ss-d-1681  [000] d..2.    94.231794: cobalt_tick_shot:     next tick at 94.271741 (delay: 39948 us)
>             ss-d-1681  [000] d..2.    94.231802: cobalt_schedule:      status=0x10000000
>             ss-d-1681  [000] d..2.    94.231803: cobalt_trace_pid:     pid=1681, prio=20
>             ss-d-1681  [000] d..2.    94.231805: cobalt_switch_context: prev_name=ss-d prev_pid=1681 prev_prio=20 prev_state=0x248048 ==> next_name=disrupt next_pid=1682 next_prio=30
>          disrupt-1682  [000] d..2.    94.231810: cobalt_trace_pid:     pid=1682, prio=30
>          disrupt-1682  [000] d..2.    94.231811: cobalt_head_sysexit:  result=0
>          disrupt-1682  [000] d..2.    94.271767: cobalt_timer_expire:  timer=0xffffc900008bc4d8
>          disrupt-1682  [000] d..2.    94.271771: cobalt_thread_suspend: pid=1681 mask=0x200 timeout=0 timeout_mode=0 wchan=(nil)
>          disrupt-1682  [000] d..2.    94.271772: cobalt_tick_shot:     next tick at 95.130203 (delay: 858431 us)
>          disrupt-1682  [000] d..2.    94.271914: cobalt_head_sysentry: syscall=clock_nanosleep64
>          disrupt-1682  [000] d..2.    94.271916: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
>          disrupt-1682  [000] d..2.    94.271917: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)
> 
> Jan
> 
> PS: I asked AI (opus-4.7) to confirm or disprove this, and it failed in 
> its code analysis. It seems like the way the code is structured and 
> commented misguided it in its conclusions. Sooo statistically human...
> 

Asked different ("find a path where..."):

"You're right — I need to retract part of my previous answer. Looking at this scenario through the cascade rule, sporadic_suspend_activity() is not invoked when a SCHED_FIFO thread preempts a SCHED_SPORADIC thread.
                                                                                                                                                                                                                           
  The path

  1. A SCHED_SPORADIC thread runs at, say, normal_prio = 50. Its drop_timer was armed by sporadic_schedule_drop() at the last cascade, set to fire at resume_date + budget.
  2. A SCHED_FIFO thread at priority 80 becomes runnable (wakes from sleep, IRQ unblocks it, etc.) and xnsched_set_resched() marks the CPU.
  3. ___xnsched_run() → xnsched_pick_next() iterates for_each_xnsched_class (sched.c:322). RT has the highest weight, so xnsched_rt_pick(sched) runs first.
  4. In xnsched_rt_pick (sched.c:730–762), the head of the highest-priority queue is now the FIFO thread. Its sched_class == &xnsched_class_rt.
  5. The cascade check at sched.c:757 (if (unlikely(thread->sched_class != &xnsched_class_rt))) is false.
  6. xnsched_rt_pick returns the FIFO thread via del_q. The for_each_xnsched_class loop sees a non-NULL result and exits.
  7. xnsched_sporadic_pick is never called. sporadic_suspend_activity(curr) never runs on the outgoing sporadic thread."

This looks more useful.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
