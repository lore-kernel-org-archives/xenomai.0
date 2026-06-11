Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579333A71B
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156354; cv=fail; b=dNDSLWNplzr9yCbL1I1rjtqYbiDZ5dlVllztI1daJEQi2Tw9ZypZUJlgNdVHgwt2FLSj7i8j4T255yeYEOyrQULjR7hpsFuZpQP9obv0l6pfK3SaM+j15N/xL9TfBEsVL6GJpjF2xCewyBo6acqL2Y21bt26EzdRu7Askaji0p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156354; c=relaxed/simple;
	bh=tsPk7OHTQ36CdDBHtLbwKye+r047ig0SSwhIbvh8Cno=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WRWkDCIeIatJrvM+fEDx+bG7pqCVRlqMuJnvymvD5aGpWSkpibb1dvFSFVkR4BMok8db/J5bSJKdrwvUj5jRxFhXj7qIdq3/fpEbDAccx30qkvHXaFpxTd8PLvK1BVHzF0yiA3+76OWgunmdfi12ViTVNvwBgsrh4BAhS9iwXao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZTHi+USW; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZTHi+USW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAD9ioSbBCwX4FXFmd1KTyuIDjcOIHnbhUAwT4X50CnAd/14E0PzpbrIU9MYI3onnJXJeR+t9AruJtpH2QsSZeLzr2F1Ob1ysIP+SZkVbxLF17vJnQnZBq6tBi+UpYyZ9izvOrmicXsf0i4/ShGwQF4OZQ9n6v66bbBHB9HqFE4zjg+E1sOaXoRXEYj+wm0okQFHrqqvoeWP28tG1uuwFGGlt/hBwWvOGCCBD1ytiF65N/22QRwgK7WL86CXRIE/kHO/gjOjGEmwdNXHRqXD95Ld/m0DAFf5ThNr+/ai35qc5C6XPPw5uAXlaFcr4pDENO8vob2SmGuVp1pWEI5JxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGzXLNvM4c6ynsMy6Uv2SPz7pb5HNKMmX7RE+1YlEqA=;
 b=ZpOS00W/XHpn2RuC1+kJaJYUev8iY2ndIHFZmHw5UJxkxOZw2SVzazD/oFA0eM2Xay5KD2XR+Hsou57RmevWbnjPMjwcwuGtdCro+4ndSFw2xNG7py7DvTvjzZsraf5OWne8+b9lmwSh+Y/XS4R1vv7lh9bn/Xp3SY8LckpziO9bxPx7wuRucFy5fuOsdRUceKiAieF0jmKEC9UJU1Zs5spJwSy8Y0vxe8yDTPoSH3QD5msQqdAKL8BXkBvMDpdhZMBj+nvLNRlReGWSnlurMJbqgt8T1a5GZq81uwOmDsiushlblMPvlHtUrqwYVBwWyZSQjKMI0i11SI6TqvJZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGzXLNvM4c6ynsMy6Uv2SPz7pb5HNKMmX7RE+1YlEqA=;
 b=ZTHi+USWUwf7+k4HGZAljXLsTVuP3AP4x/Lz6LGwTh5vhMaa96jLdfjVgTl1hWyCMeGgZrUW0ZW/GcO+MDQushYxLPEWVcMl8r6/jNOlhOWUT0RYdU0IjIEXYFcq3X4hfGY8UQ1oQ8ulRNGATIQoOW2PDoA68wm5D+eB5ZWMdZhbAP1JdtRFYT8P5dxerTWM1eHDi7duDzyz9DDeLaHIUFxdXIBNALVQ69PuytRGRX3OYekagFNJxKtgtTn2sVDDsDGuWtu17KkR6fTdnu5nhyvVLaNDkRaQyew7KcSIyIEcNmkPXUoHCO3XXSnYmH5U4E4eywW+4m0aW1SxSNYVug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 05:38:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 05:38:59 +0000
Message-ID: <30be9f34-4fd0-47fc-932f-70970217acb0@siemens.com>
Date: Thu, 11 Jun 2026 07:38:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SCHED_SPORADIC in Xenomai 3
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
 <5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
 <c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
 <2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 89684cc1-bf35-4c3a-f361-08dec77bbcb9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|3023799007|55112099003|11063799006|5023799004|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rDIsBiauVlioERUa2D11jjVrx1rTnePd3mcjCaspptLFRU80Hf4yymdzvyXYQ+9/FpnJKcBFkKGvbuWjBLVrqO3e6hWznoo8gbpP+LY3g823s8qVmTP0VSkbaBqloNzEQOs97qoqp2kSTShcuHz1b29tilhqTRVyUOVwrcylw5jKnZFhPLIIUd1cCiVwp5E2VIyUnDxdcmZcvz0iCK1pW+iT6hcfmpV66oPlXKX4/cWNSWHEAK3g9rUfqmms2B8FL1cS2MillosZlI3uWkd/nxX+lggltP4P0Yj0MX5ytDnBCjsw3vLcMhhUwpfc96eqY3xw5NKVbAAev/SlErrfj0ycAiaDL1rnKKA+POQz1u7iUQ7h59+hemtCvjau2wh7zDBEl371zTysGr1vvwpbcmlp6dnEhLfYOf1kv2YQfds5iE0Xj2ZssMi4u0CdMnUBljzVnY7Yc/AQbOzgouqq3ATw3zFDh2S5FvUGsSOTG+1a1HWFsmXIJD0ZTBOYJu0WIkWe15uRS0t2b73IZm7GYNJGNqT0Z9f7wEbb8sWE6yuHozvxLZiMtMTPgp+lKKOqNYUJ7GmXGNuGq1JXZoz4boiagRueF2J6c6nL1szwIj7VHFe3yEMDJLnvwcrzAqInR4DZ876A08g80v150kBh+S0x0lF6QehJJVaOKSAcqvBNdQjTGGSHEdcdhLOylj9X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(3023799007)(55112099003)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHJJcFM3dTNZclVYbnU2Zk15TEZJaWZTOXhZZzZnVFU4VEJBYnZSaDUyZUM0?=
 =?utf-8?B?QW9FbUZBYmNYUGxMVXE3RTYwM1hZanV2amVVMGIwRzF5UVpQWFQzd1EydEsv?=
 =?utf-8?B?U2NjR0NMRlFCcVJzVHVNa2h0U0hYSmRkWHYxYWpRdEIrMkU3ZFVycDU0UkM4?=
 =?utf-8?B?QlkvN1dIRHlGZ3dmUW01NTVHMmc2MWxVeDI2ckM0QlY0YXI2Mm1NMDB3YlEx?=
 =?utf-8?B?UzlvKzE3VGd6d3VsUEd2SHVLRGZwRWVpSFZoWG9YOGZ6YVM1L3d1UjVFVC84?=
 =?utf-8?B?MDFab0gyelVPUll4cWgzT0lLS3FNT1ZKNVk3cGpXSUxQUEp0UEhqNEZMcU9I?=
 =?utf-8?B?aElzQ3U3WGRObTJpNlEyeEVCdSt0LzlqYTBPelNUWFJVNVJCNnNseEIwVk1s?=
 =?utf-8?B?ZllJNlRCTHY1TktEdnpySnU2aXdxWGhQU3Z6MlpsN05CcHFsdG5nT1V2UnJ4?=
 =?utf-8?B?azl0S0tOZGN2OUhJQS9pQ0ZudlJWZ3dsV2NibzZ2ZnRaaXdyL09meXVINU5Y?=
 =?utf-8?B?NVo0T09MQ3E2cEFTRnNLMkFqUi9SQ0FobVVRamlPdWxvdG12QjArUTEyelY0?=
 =?utf-8?B?WkFlbU5CR1RTeUpndi9FR1pISmxpdnBuZUNsRlZwbmt3WnFBcXhpQWtIYkxj?=
 =?utf-8?B?Y1Y0NEhVSzV6emRFS085dW5VTm9TQlpyeEtYOU1lSnJLK25xclQ4T3pOMGRj?=
 =?utf-8?B?WXgwbzhxMnI5OFNSLzZzby9CbWlsbVBnSFNPUXZlT3VicnFSRzNLMlgwaHhW?=
 =?utf-8?B?cWxXMmpMd2lvUDJxZEdPMWwvbGo3MXZVaHVQNXNRa0VMZlJ5UHg5ZDZKdDZX?=
 =?utf-8?B?bUQ4dEJ3WVgrZ0ZuYlFEc1FaMmloY01MOGVLcmlwdXJEVUhYNHdLYXZCOHlE?=
 =?utf-8?B?M1pBeWUxZWEyNUZoTVhnR1JrTGRWYU5BakRMS0hybVpKbmk2SHR6dENZb1Nu?=
 =?utf-8?B?MVlWVmgzbmhDVWtXQnlKZ1g2RGR5TFNoVU5nL2Y2VTkzOHQydXJML21HR24z?=
 =?utf-8?B?TlJja3MxTjN4SmdhWW9hYWRHZ2dUUHJsNHpjRWJReDJyaWRSUnJGQnY0Y1l2?=
 =?utf-8?B?R1BWdE9SWXdVNW1RNDB4cDNNKy8xa2RTcHdRU0xyRUNJSjlINTJsVXFtRWhs?=
 =?utf-8?B?MUJMcTRaUThBOGt6bkdBV25QNEIyR09IZzFzMVVnaGhFWkxBS2dYZzJLUEpm?=
 =?utf-8?B?VVlMTnIxanU4RmZuZitmN0VFMjdlbW1HWG1jYkZ3YVZEMHNoUjkzbkUrZHU4?=
 =?utf-8?B?S0ZEcGFqcjNDeFVpeW1QZjduODV6NWpWU1NWSmRteHpLeWhuZjhWS3Q0SENW?=
 =?utf-8?B?VDk0Zms2UFpEbkw3NXhWbkRTbHdNWjRhbUZTUUtsTVI3a05OV1FEWHl5S0hq?=
 =?utf-8?B?Wk9nM0F4VWwvSXVxK0Y4eDlYYkR2UVdkZ05wUTRsZzhvWXVTTVRQVEl1RStW?=
 =?utf-8?B?dS9nL0dSU0xmQW5NWERUOHZCWnNyeDB6aVVsSHUvUDR6NXNGYXJSMkpmRk92?=
 =?utf-8?B?WWtaS2plZGxRK1BaUDFnNlZkV1VDNXNDd3BzVFV6L25vTURMUEVtWEIvNFg5?=
 =?utf-8?B?OUlzRGwxY0NHQTQraFlhZW9uQmRSYktNZTUvWHZXdmphVjAvVHdhdENaeVNs?=
 =?utf-8?B?SmFvaVZya0pjdUZUQ3NrSEdEVVRTeUgrZDVxZXdoSmZLQkJKUWlibHY1SnlK?=
 =?utf-8?B?cXh6b2QwZG9XUnNrNEhRSllyZ2ZTakZ1S1BycGVhYnQzUm8wM2RudFVkYXBQ?=
 =?utf-8?B?VkN0SlRxanFUTlhGOHQrL0c3clovbXo5YjdqTUFmTmNEaUU3Q3gwQ1dxU3FR?=
 =?utf-8?B?dlF1S2h3L0Rydm1tL1NCaElGcm5KTzg2NDA4K01OMHRYc2ljNEpCZEJJbzNs?=
 =?utf-8?B?NGp5L1BmamNWdGtRcmF5aTJxYXFIVUhjS2ZuSU5jL0JEZUdNcDZ5WUs1bGhV?=
 =?utf-8?B?WUhrTTc3enh0Ky8rYjBDWmVYTlo3WGl1SVVvR2hMVlBETlUzSjE5K2dmNFpu?=
 =?utf-8?B?UzI0dVBPQjhFVE9qTzYrMjM4dGo4dUFSZDVMUHdZTXRjWjM0YkF1U0FEd3Jt?=
 =?utf-8?B?T3NvQVp5QVVQT2kyNWl4cmJhSk8yMWtmWW13U21BOU1BNXAyWGNMdGtPaE1V?=
 =?utf-8?B?cTZGN0c5RmtIZE5FVWhVNDJhdjJlN0lLa1B0UmRyL1ZYUG16cnNBMnN0WGwz?=
 =?utf-8?B?UGJvb0ZydUVzRlNtYTllZzNZNU84UDVXZWtadTYyNkw0enMzcnBhVElSNTYx?=
 =?utf-8?B?SzF0TCtnNEV4aWV4azhvSG9mdmh2NmZiUWE4OEV0TjBiWkNCNkNBRkVPMEtE?=
 =?utf-8?B?dnp2bkVpOTc0Y1dYYzhxbUpBY1lIbVJkdWNyZG82Z0dzRk1FS1BPZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89684cc1-bf35-4c3a-f361-08dec77bbcb9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 05:38:59.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVb9K+PWofSFJPGzztnwxpcd0aJ51Y9gg5JV4wYtj0xYjeVhWUvrsZrBEBxE/TeiyhcIgiAkB3IL1EldFKhxKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9468

On 10.06.26 20:17, Jan Kiszka wrote:
> On 10.06.26 09:33, Jan Kiszka wrote:
>> On 10.06.26 09:21, Jan Kiszka wrote:
>>> On 10.06.26 08:24, Jan Kiszka wrote:
>>>> Hi Philippe,
>>>>
>>>> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
>>>> into XNHELD, a state only existing there. I suppose that was once
>>>> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
>>>> SCHED_SPORADIC - so let's dive into that scheduling class.
>>>>
>>>> Turned out it was never documented, not even linked to the POSIX
>>>> standard. But it also slightly differs from it (low_prio = -1 -> suspend
>>>> on depletion). There is also no test case, so I asked an AI for one.
>>>> That worked fairly well as it seems to have revealed an issue:
>>>>
>>>> Could it be that we are not properly suspending the budget tracking when
>>>> a higher-prio task from a different scheduling class is preempting a
>>>> sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
>>>> if a thread is selected from a higher-prio class first, namely sched-rt
>>>> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
>>>> limitation/misconfiguration? Is that issue even affecting other
>>>> time-slicing classes as well??
>>>>
>>>> That furthermore makes me wonder if we actually have users of
>>>> sched-sporadic. Likely a hard to answer question, as usual. But such a
>>>> limitation should have been observed earlier under real workload...
>>>>
>>>> Jan
>>>>
>>>
>>> Here is a trace that proves how xnsched_sporadic_pick and, thus, 
>>> sporadic_suspend_activity are not called:
>>>
>>>          disrupt-1682  [000] d..2.    94.171753: cobalt_head_sysentry: syscall=clock_nanosleep64
>>>          disrupt-1682  [000] d..2.    94.171755: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
>>>          disrupt-1682  [000] d..2.    94.171757: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)
>>>          disrupt-1682  [000] d..2.    94.171759: cobalt_timer_start:   timer=0xffffc900008bbb00(smokey) value=60000001 interval=0 mode=0x0
>>>          disrupt-1682  [000] d..2.    94.171761: cobalt_tick_shot:     next tick at 94.231756 (delay: 59995 us)
>>>          disrupt-1682  [000] d..2.    94.171770: cobalt_schedule:      status=0x10000000
>>>          disrupt-1682  [000] d..2.    94.171771: cobalt_trace_pid:     pid=1682, prio=30
>>>          disrupt-1682  [000] d..2.    94.171776: bprint:               xnsched_sporadic_pick: xnsched_sporadic_pick, curr=1682 next=1681
>>>          disrupt-1682  [000] d..2.    94.171777: bprint:               xnsched_sporadic_pick: sporadic_resume_activity, pss->budget 99964473
>>>          disrupt-1682  [000] d..2.    94.171778: bprint:               sporadic_schedule_drop: sporadic_schedule_drop, pss->budget 99964473
>>>          disrupt-1682  [000] d..2.    94.171778: cobalt_timer_start:   timer=0xffffc900008bc4d8(pss-drop) value=94216201725 interval=0 mode=0x1
>>>          disrupt-1682  [000] d..2.    94.171779: cobalt_switch_context: prev_name=disrupt prev_pid=1682 prev_prio=30 prev_state=0x248044 ==> next_name=ss-d next_pid=1681 next_prio=20
>>>             ss-d-1681  [000] d..2.    94.171784: cobalt_trace_pid:     pid=1681, prio=20
>>>             ss-d-1681  [000] d..2.    94.171788: cobalt_synch_acquire: synch=0xffffc900008bd408
>>>             ss-d-1681  [000] d..2.    94.171789: cobalt_head_sysexit:  result=0
>>>             ss-d-1681  [000] d..2.    94.171799: cobalt_head_sysentry: syscall=mutex_unlock
>>>             ss-d-1681  [000] d..2.    94.171801: cobalt_synch_release: synch=0xffffc900008bd408
>>>             ss-d-1681  [000] d..2.    94.171801: cobalt_head_sysexit:  result=0
>>>             ss-d-1681  [000] d..2.    94.231786: cobalt_timer_expire:  timer=0xffffc900008bbb00
>>>             ss-d-1681  [000] d..2.    94.231789: cobalt_thread_resume: name=disrupt pid=1682 mask=0x4
>>>             ss-d-1681  [000] d..2.    94.231790: cobalt_trace_pid:     pid=1682, prio=30
>>>             ss-d-1681  [000] d..2.    94.231791: cobalt_timer_stop:    timer=0xffffc900008bbb00
>>>             ss-d-1681  [000] d..2.    94.231794: cobalt_tick_shot:     next tick at 94.271741 (delay: 39948 us)
>>>             ss-d-1681  [000] d..2.    94.231802: cobalt_schedule:      status=0x10000000
>>>             ss-d-1681  [000] d..2.    94.231803: cobalt_trace_pid:     pid=1681, prio=20
>>>             ss-d-1681  [000] d..2.    94.231805: cobalt_switch_context: prev_name=ss-d prev_pid=1681 prev_prio=20 prev_state=0x248048 ==> next_name=disrupt next_pid=1682 next_prio=30
>>>          disrupt-1682  [000] d..2.    94.231810: cobalt_trace_pid:     pid=1682, prio=30
>>>          disrupt-1682  [000] d..2.    94.231811: cobalt_head_sysexit:  result=0
>>>          disrupt-1682  [000] d..2.    94.271767: cobalt_timer_expire:  timer=0xffffc900008bc4d8
>>>          disrupt-1682  [000] d..2.    94.271771: cobalt_thread_suspend: pid=1681 mask=0x200 timeout=0 timeout_mode=0 wchan=(nil)
>>>          disrupt-1682  [000] d..2.    94.271772: cobalt_tick_shot:     next tick at 95.130203 (delay: 858431 us)
>>>          disrupt-1682  [000] d..2.    94.271914: cobalt_head_sysentry: syscall=clock_nanosleep64
>>>          disrupt-1682  [000] d..2.    94.271916: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
>>>          disrupt-1682  [000] d..2.    94.271917: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)
>>>
>>> Jan
>>>
>>> PS: I asked AI (opus-4.7) to confirm or disprove this, and it failed in 
>>> its code analysis. It seems like the way the code is structured and 
>>> commented misguided it in its conclusions. Sooo statistically human...
>>>
>>
>> Asked different ("find a path where..."):
>>
>> "You're right — I need to retract part of my previous answer. Looking at this scenario through the cascade rule, sporadic_suspend_activity() is not invoked when a SCHED_FIFO thread preempts a SCHED_SPORADIC thread.
>>                                                                                                                                                                                                                            
>>   The path
>>
>>   1. A SCHED_SPORADIC thread runs at, say, normal_prio = 50. Its drop_timer was armed by sporadic_schedule_drop() at the last cascade, set to fire at resume_date + budget.
>>   2. A SCHED_FIFO thread at priority 80 becomes runnable (wakes from sleep, IRQ unblocks it, etc.) and xnsched_set_resched() marks the CPU.
>>   3. ___xnsched_run() → xnsched_pick_next() iterates for_each_xnsched_class (sched.c:322). RT has the highest weight, so xnsched_rt_pick(sched) runs first.
>>   4. In xnsched_rt_pick (sched.c:730–762), the head of the highest-priority queue is now the FIFO thread. Its sched_class == &xnsched_class_rt.
>>   5. The cascade check at sched.c:757 (if (unlikely(thread->sched_class != &xnsched_class_rt))) is false.
>>   6. xnsched_rt_pick returns the FIFO thread via del_q. The for_each_xnsched_class loop sees a non-NULL result and exits.
>>   7. xnsched_sporadic_pick is never called. sporadic_suspend_activity(curr) never runs on the outgoing sporadic thread."
>>
>> This looks more useful.
>>
>> Jan
>>
> 
> The blast radius extends:
> 
>  - I added a preempting fifo thread to the sched-quota test as well, and
>    it completely destroyed the thread group accounting: the group no
>    longer gets throttled, rather than getting time stolen by the
>    preemptions.
> 
>  - The evl core looks identical here and should be similarly affected,
>    regarding quota-based scheduling.
> 

Here is an attempt to fix sched-quota, along with the test case 
modifications:

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index 106e6e29a3..bf19391e2c 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -136,6 +136,7 @@ struct xnsched_class {
 	void (*sched_dequeue)(struct xnthread *thread);
 	void (*sched_requeue)(struct xnthread *thread);
 	struct xnthread *(*sched_pick)(struct xnsched *sched);
+	void (*sched_out)(struct xnthread *thread);
 	void (*sched_tick)(struct xnsched *sched);
 	void (*sched_rotate)(struct xnsched *sched,
 			     const union xnsched_policy_param *p);
diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index 60b2c92b8f..d6e7022d99 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -405,27 +405,36 @@ static void xnsched_quota_requeue(struct xnthread *thread)
 	tg->nr_active++;
 }
 
+static void charge_usage(struct xnsched_quota_group *tg, xnticks_t now)
+{
+	xnticks_t elapsed;
+
+	elapsed = now - tg->run_start_ns;
+	if (elapsed < tg->run_budget_ns)
+		tg->run_budget_ns -= elapsed;
+	else
+		tg->run_budget_ns = 0;
+}
+
 static struct xnthread *xnsched_quota_pick(struct xnsched *sched)
 {
 	struct xnthread *next, *curr = sched->curr;
 	struct xnsched_quota *qs = &sched->quota;
 	struct xnsched_quota_group *otg, *tg;
-	xnticks_t now, elapsed;
+	xnticks_t now;
 	int ret;
 
 	now = xnclock_read_monotonic(&nkclock);
 	otg = curr->quota;
 	if (otg == NULL)
 		goto pick;
+
 	/*
 	 * Charge the time consumed by the outgoing thread to the
 	 * group it belongs to.
 	 */
-	elapsed = now - otg->run_start_ns;
-	if (elapsed < otg->run_budget_ns)
-		otg->run_budget_ns -= elapsed;
-	else
-		otg->run_budget_ns = 0;
+	charge_usage(otg, now);
+
 pick:
 	next = xnsched_getq(&sched->rt.runnable);
 	if (next == NULL) {
@@ -477,6 +486,14 @@ out:
 	return next;
 }
 
+static void xnsched_quota_out(struct xnthread *thread)
+{
+	struct xnsched_quota_group *tg = thread->quota;
+
+	if (tg)
+		charge_usage(tg, xnclock_read_monotonic(&nkclock));
+}
+
 static void xnsched_quota_migrate(struct xnthread *thread, struct xnsched *sched)
 {
 	union xnsched_policy_param param;
@@ -814,6 +831,7 @@ struct xnsched_class xnsched_class_quota = {
 	.sched_dequeue		=	xnsched_quota_dequeue,
 	.sched_requeue		=	xnsched_quota_requeue,
 	.sched_pick		=	xnsched_quota_pick,
+	.sched_out		=	xnsched_quota_out,
 	.sched_tick		=	NULL,
 	.sched_rotate		=	NULL,
 	.sched_migrate		=	xnsched_quota_migrate,
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index d527b6be2c..6dfbf83220 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -895,6 +895,7 @@ static inline void do_lazy_user_work(struct xnthread *curr)
 
 int ___xnsched_run(struct xnsched *sched)
 {
+	struct xnsched_class *prev_schedclass __maybe_unused;
 	bool switched = false, leaving_inband;
 	struct xnthread *prev, *next, *curr;
 	spl_t s;
@@ -933,6 +934,13 @@ int ___xnsched_run(struct xnsched *sched)
 
 	prev = curr;
 
+#ifdef CONFIG_XENO_OPT_SCHED_CLASSES
+	prev_schedclass = prev->sched_class;
+	if (prev_schedclass->weight < next->sched_class->weight &&
+	    prev_schedclass->sched_out)
+		prev_schedclass->sched_out(prev);
+#endif
+
 	trace_cobalt_switch_context(prev, next);
 
 	/*
diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index f9e64e37f1..cebe629394 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -45,9 +45,9 @@ smokey_test_plugin(sched_quota,
 
 static unsigned long long crunch_per_sec, loops_per_sec;
 
-static pthread_t threads[MAX_THREADS];
+static pthread_t threads[MAX_THREADS + 1];
 
-static unsigned long counts[MAX_THREADS];
+static unsigned long counts[MAX_THREADS + 1];
 
 static int nrthreads;
 
@@ -107,6 +107,36 @@ static void *thread_body(void *arg)
 	return NULL;
 }
 
+static void *disruptor(void *arg)
+{
+	unsigned long *count_r = arg;
+	int oldstate, oldtype;
+	struct timespec req;
+
+	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, &oldstate);
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	*count_r = 0;
+	sem_post(&ready);
+
+	pthread_mutex_lock(&lock);
+	for (;;) {
+		if (started)
+			break;
+		pthread_cond_wait(&barrier, &lock);
+	}
+	pthread_mutex_unlock(&lock);
+
+	while (!throttle) {
+		do_work(1000, count_r);
+
+		req.tv_sec = 0;
+		req.tv_nsec = 1000000;
+		clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
+	}
+
+	return NULL;
+}
+
 static void __create_quota_thread(pthread_t *tid, const char *name,
 				  int tgid, unsigned long *count_r)
 {
@@ -133,7 +163,7 @@ static void __create_quota_thread(pthread_t *tid, const char *name,
 	__create_quota_thread(&(__tid), __label, __tgid, &(__count))
 
 static void __create_fifo_thread(pthread_t *tid, const char *name,
-				 unsigned long *count_r)
+				 void *(*func)(void *), unsigned long *count_r)
 {
 	struct sched_param param;
 	pthread_attr_t attr;
@@ -143,9 +173,9 @@ static void __create_fifo_thread(pthread_t *tid, const char *name,
 	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
 	pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
 	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
-	param.sched_priority = 1;
+	param.sched_priority = 2;
 	pthread_attr_setschedparam(&attr, &param);
-	ret = pthread_create(tid, &attr, thread_body, count_r);
+	ret = pthread_create(tid, &attr, func, count_r);
 	if (ret)
 		error(1, ret, "pthread_create(SCHED_FIFO)");
 
@@ -153,8 +183,8 @@ static void __create_fifo_thread(pthread_t *tid, const char *name,
 	pthread_setname_np(*tid, name);
 }
 
-#define create_fifo_thread(__tid, __label, __count)	\
-	__create_fifo_thread(&(__tid), __label, &(__count))
+#define create_fifo_thread(__tid, __label, __func, __count)	\
+	__create_fifo_thread(&(__tid), __label, __func, &(__count))
 
 static double run_quota(int quota)
 {
@@ -190,6 +220,10 @@ static double run_quota(int quota)
 		sem_wait(&ready);
 	}
 
+	create_fifo_thread(threads[nrthreads], "disruptor", disruptor,
+			   counts[nrthreads]);
+	sem_wait(&ready);
+
 	pthread_mutex_lock(&lock);
 	started = 1;
 	pthread_cond_broadcast(&barrier);
@@ -212,6 +246,7 @@ static double run_quota(int quota)
 		pthread_cancel(threads[n]);
 		pthread_join(threads[n], NULL);
 	}
+	pthread_join(threads[nrthreads], NULL);
 
 	cf.quota.op = sched_quota_remove;
 	cf.quota.remove.tgid = tgid;
@@ -243,7 +278,7 @@ static unsigned long long calibrate(void)
 
 	for (n = 0; n < nrthreads; n++) {
 		snprintf(label, sizeof(label), "t%d", n);
-		create_fifo_thread(threads[n], label, counts[n]);
+		create_fifo_thread(threads[n], label, thread_body, counts[n]);
 		sem_wait(&ready);
 	}
 

Something analogous for sched-sporadic does not help. It looks broken in 
its algorithm, specifically that is schedules consumed budget for 
recharge on preemption, rather than reducing the remaining budget. But I 
might also miss some case where this is actually needed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
