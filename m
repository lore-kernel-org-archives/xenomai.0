Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7E30B51D
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115454; cv=fail; b=biOr55BUDTRlRNU9SxEA5TqtSmYLiBQv0CPNdWedrkyAmDxKdZopcjgwNfSO6IB03u8F6A43tgQLIg53N9iw7v454OpzWkagHfYvexbxCNL6Fe+b/vInH/649xkmm28hIwRpnR0t1cTcSg8rBPgPXbSPyClX4cz3OdeC5LxPt6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115454; c=relaxed/simple;
	bh=Xu5zv/KDJjPXaSQ/N40vjJdrjrUivdiQ6g+QpFCyvgQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sygN/t1ljhVRwT9I0RJVqoBnvCL+VXSQoP7vLO6nyakEFIKql66JcN+vvEAJBjhHML6+hz+DCGzXzC4P9PkDZOsvAOhx8kyCzhWfZBZmsSsjvGaBABLc7BMYsqlFZqDJp04jLPJEPYQJQzWB3xoC22yLXM0WzNUSUQ4RweUbVDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=P546Qg9+; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="P546Qg9+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyWEn8ul9Cn2BHa0eoWJYS5SVCLojqzW9o3jSVodfK6eHwNde3u9WQ9e2lBtUuHja7AnHQ4Zi4vfyqgPkYcwNL+Dh6uuXdXT1+8cUVymYS6OUXmSHydYlEDnuoAyP8urItQ1l86WqATH4vmK9GnKy30jWhuLtdeNvoRjnfjeDqtsIx+omdH/jMFyJY3CWQF6aIOpoTedXXYMt5tLy6TV09eHIijeDjqhW0GWxkj32reLvGx1tcsRlf3sDBF9/+zyI0zym4nZ50hxoJXMT4c6AgdTXYddg7Fo4U0YDP7lL2O22Fm0AnvO1GnAZ34Gv1Ld24clQgsLmc4dJiCduYdncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF3DCh4v65aaZjR9hmh9AkRRwqR/zwbeyUEXbxnt46Y=;
 b=a0fDvDQR3TlZjbnE0ssFJjits2kamkC7FYfSb+zJIP72wQ8BLiODpdliYGMBA7GhTmuAy7jb0Dud8+cDuQGqzTzcn7W23zPtNWC9MGpDGZ1T9092xG1SPGtvfH94he27CbEk3wqooEo4k0Jw3OgdWS/ICKcww4LOlG7NDnJjJeNeepF/YWnUSe2r3pBE3+dVuhv/KL4JoAI65U6FaMHyWhA/9wZCikNeZXin+cD7C2Ssahi3HUX7zwySVS9MxVHswLPs/6x2kLuogPxud5+PVA48DUCiD9PXC8ZeOy2ZXcb+7zQTa/ytTMjGIUl3N1H2Hd85TQUDL2jVjeIn8VnEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF3DCh4v65aaZjR9hmh9AkRRwqR/zwbeyUEXbxnt46Y=;
 b=P546Qg9+i0ClY32xdNzXz0rfd/SadYjKNirtsyz+rAL1kr6dfm0YIkKjHIYl3kLeFq0VUOby7/HKlo8hDrHi3OQxR2qaldRr+435JXgmJqQkek9mxWweyfwcFVca9i42NSI+8qIH4xeNsvq4XJvIZvyGLqfC0laow4/Xb7fptgThAIj2H5PWr6ii7CALX+gtfOg5Nm+oqsOEwmZU/2xS49AEq2toO3YktRDVbvTw5tGjMfV+miLiu32YIJWM5bhwH5nlA2hQIcKB/NBYpIDNRW/6xdiGboqaXgU8qrceKqakdYZkYDR4FxOucmnTaMw6Y0Rm8m6uEdnQ8FtZ6AVxLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 18:17:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 18:17:29 +0000
Message-ID: <2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com>
Date: Wed, 10 Jun 2026 20:17:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SCHED_SPORADIC in Xenomai 3
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
 <5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
 <c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a7395a-74d6-4e2c-7530-08dec71c8852
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|55112099003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	HOfLekohuygpcr9kE0tiXrgLbp9D/JX15iO+0UU+QRo4FDPOfT56TUpFDKT4scNYdPsYK9XedJBvAKUvMlKNZ1a4ZR7sKpsvgO1n95kzNMMXmQ0DPR5OQqTym41sMMlqg+WLT+PPIzp+/buAzy0B9bnLe7bCfdT17tvrBDOhFkRrNNUEsDG9Ha+X5LOKFZpKDIPh912RysH8UAuk5LKc+rg9IToy7lImFHDnw7svxT82TWAPHnE7n/8Pv+88jtbMXt5Wbi3ka/Vfc6A5uxVMm2ihrm4KjmH3GMRhRPHvzgelzJC7Myji1KY0sjhenF6kadjlLKa9BVzvtDrfIDfFwljrpsHVl6wS6hq34pCJR31Md19Ko4CI+Rem4Q5k6FiOj5sRycjrlCO21+/AOc0rJ6slX6Kt3fGeB3aEs6kH3CiROKWDojUyQ+yMtM72jIbrpkSR1kELofADXbiaUscs7MBaINFBxlzZRcW7AeVfDzmkWJPQGcTuJIRt2yLgyVa7meM5G1oEWIr98srploJsOFhrePxHuuJ/5UlmC6gLdjvNguFBdkvH0vMX0iyusSjaPNtG98/mC0DE3bMT9MTPC9kHCpPbyYGLLcHc103D0sy1Kro01TArMdJ9Tx/zsH3YLvfNl9L9FYgbUlXRJiHxn14nVusq03NHRwD+QFFGqUwz1+EuYTEPEQK5f9PWa2+G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(55112099003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFpYTRKUURIRFdEWFlqSWF0YjE0dlRTc1lMbnJCUXoxMXdFSWpTY1ZBZXc5?=
 =?utf-8?B?REE3bTU2cTJlYUwydkFBWWFrMTlrTlFBWU5xcUk3N05IbjZrQkd4Z2YzL0M3?=
 =?utf-8?B?ZVNXdXBJazdKU1RUb1dSaFF5ZjA5K3BSWUNTR25HNWROZ2RJZUNjejQ0UGpQ?=
 =?utf-8?B?Zk5kYmprWWo1Z0pBQm52WnB1QjhEbC9meUlaajZOYlh6T3ZZbGFkelNBNjlR?=
 =?utf-8?B?S0xCNnZEYmxCSGkvc01KZ1ZUV29pYmlEMTlqckowWlQ5L25wZUpLbVRjSzVs?=
 =?utf-8?B?SjFnYjRLaGY2YkF1UklFRlZHRDhZd0h2V1VGbUJKRktzSkpIL0o5S3o0YVgz?=
 =?utf-8?B?ZWZPZnB6Zk9ROUJMa09oTENHMStOVW0xZFpVRHRLVDZ3RTJlNHp5QnRTWDJS?=
 =?utf-8?B?MExSenpZV1YyOS81dlRxYk52aU5YcEJzREhMWXgrdkxrNFYzWm1GNUlZYUhR?=
 =?utf-8?B?NFg3bHhxYm84VGoxV3dVWncvU2s3VExDbDFGMmpyNHV1OVVOVEdRT3ZvK0ox?=
 =?utf-8?B?MDFVMHZhRU5FV2hZbWUvTXY2OE9BdjFYdnVBZzQ2WllOdGdJNW9lMmdwa0tr?=
 =?utf-8?B?bERmck9iZHJpbWcwK0t0OXFZVmtaTkUvaXN2bFB0a3MwQVpla0JnOUVLZWJS?=
 =?utf-8?B?eWdNYWJCSWVHTlpWbGhrUFNtSkVWQ25NRkd3NktTNjdXNE8wZ002V1MyL2d0?=
 =?utf-8?B?c3dsaFFGUkJESzAzcERUWnR5ZE9CSGI2cE1neVVRNHRCZjlWK25yRU12ZGdZ?=
 =?utf-8?B?TTFJSFB2QTVoQzlWenNlRHlTVmxJdkFvT1A1WVN5QkIxZEQ3K1BoeVN3ZkJ4?=
 =?utf-8?B?aDhSRE5DMjU1aEpxbFI4NWxEeUY5aEpOVENoNDJ0Q3c0b3B2RHRQUFMzeW5D?=
 =?utf-8?B?eFJ1bDlGelZ0TUxiQXBOWUsxdHhDMHJoTHV0REo3SDQwQ205S0cwNDNiWklU?=
 =?utf-8?B?UG9UVHcwNktGWW1wSXdmR0RkeFpiOC8zOFk5R0ZJNzIxWlBRUG9mZGNBcDE3?=
 =?utf-8?B?aXBEcjVTUnBweVQ0WjJPd2I3Z3pTaGM1TzdZYjVoRzFEY29hNzNBcys5bFA5?=
 =?utf-8?B?anNJQVJlNEtHZHNFV3RkN0JyalF0VUFSYlZqb05hS3owdGhsN3V3T1JTMlk4?=
 =?utf-8?B?YlkwMkhpU3V0V1RQSkRmM2doMHh4bWl0cy9VMlpuUVlUS3EvbWdaejdmWWxm?=
 =?utf-8?B?VmJVZ1lZNzVYN0ZWeTlFMTBLVVVtcXUzd3NYMFJNOUZhaWI1VjYwWCsxSkcy?=
 =?utf-8?B?SzFJL1N6Z3BuOGdnR0xKeCtINFJHMGJVajAyZkxXdkY5aVBlOHRnUkhRRFA0?=
 =?utf-8?B?RHhLZ3VBYVduSWdIZ0VUdlY4VG1ySTNuNU1zVGZickRxd01yK0Z6U0psWnU4?=
 =?utf-8?B?OGxBeDJzQ0VmZ1dHT0NHaURvVk5KcHBQam5uRnZVL1R3TEtJUmFWUVBrWUFO?=
 =?utf-8?B?eW9VWXlBWjB6TlU5by9CUGlNa3N5YUREUnhFMG1US20yZkJ6RnpuRWxXVExN?=
 =?utf-8?B?aGZQQUxEZUVoU1VZMWJlckdTRUlxQUlkdDBHV09TSWZXbDhnVkVuME5ScWpW?=
 =?utf-8?B?MlphMTJCVTI1Mk90RGRQRTFFU2phbEs3VVZkRDh1S0x3TnVKUmFvUDlEWlAx?=
 =?utf-8?B?SFVYWldXZ3Fsb0pFZ0RCZnRzR1E1SnFWcFIyU3hHWHJVQ3NwWlcxWm96VG9G?=
 =?utf-8?B?YzgxWlJiSEtiaXJuSXIvU09vamRLTFpoZG1NSFA4emVvSXZaTmk1Q3dFTlMz?=
 =?utf-8?B?ckNQbmx5UUpQZ1gzeVA3Nk1LY25TaUY0dGNFdEQxZXJ5dzNySm9HcC9PT0RD?=
 =?utf-8?B?ckxPYnBuQUpuN0NwQ09ZbWM1b1d2YS96ZFBLSS9OQzRNa1FDN3plampUbzlL?=
 =?utf-8?B?VkhhQVNDOG9UK1FlazMyMC9udUNpSk50TVgwbHVDMHVjMm9HYk5uZjN2UkJE?=
 =?utf-8?B?MEdiNjRId3ZpMUV1ZkdqUTEvdEtNSlFVN3BRcFloaVNzUldsMlplMW1xalFp?=
 =?utf-8?B?QWE4MURWcGFuZUtmbmlZYm9PZlJrdzI0M0xoY05EdktZR1k5cXgvckorMzZw?=
 =?utf-8?B?UjZPcVFqeHlMSHRyR2JMYVY2NVgwcU1oSXRkelpJaVMvZzltUFJjSzZ0MHRG?=
 =?utf-8?B?NEJYcnV6MDRsZXhMV3QraDBKc25aYjZyWUl4bDhKWTNZUXlwaTFndVN4NE0w?=
 =?utf-8?B?YnlqRkdOVjJKamI2Y3g4ZXdhSWtCalhNZURPYTR4dVNDTGxMN3RmalNkb2Vq?=
 =?utf-8?B?UUhoc3RvZlRyMXNObTh2V0c2SWU4czJPd0dkRVBLWVBTNzkvWjQvekc4UkdX?=
 =?utf-8?B?RlRJMnllZkJ5U2d4c3QrMHJ2LzdBeFdRSW5rdDhqS0Qzd3JoMCtTdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a7395a-74d6-4e2c-7530-08dec71c8852
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:17:29.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDFZjjPvDGia8NvzoRXLsuIh61pKATKZmhQF2db1Uytz9YSJX4GUL/tFw/cycGyhtg7VeY/VcYanxhMZ3JGMDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7072

On 10.06.26 09:33, Jan Kiszka wrote:
> On 10.06.26 09:21, Jan Kiszka wrote:
>> On 10.06.26 08:24, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
>>> into XNHELD, a state only existing there. I suppose that was once
>>> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
>>> SCHED_SPORADIC - so let's dive into that scheduling class.
>>>
>>> Turned out it was never documented, not even linked to the POSIX
>>> standard. But it also slightly differs from it (low_prio = -1 -> suspend
>>> on depletion). There is also no test case, so I asked an AI for one.
>>> That worked fairly well as it seems to have revealed an issue:
>>>
>>> Could it be that we are not properly suspending the budget tracking when
>>> a higher-prio task from a different scheduling class is preempting a
>>> sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
>>> if a thread is selected from a higher-prio class first, namely sched-rt
>>> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
>>> limitation/misconfiguration? Is that issue even affecting other
>>> time-slicing classes as well??
>>>
>>> That furthermore makes me wonder if we actually have users of
>>> sched-sporadic. Likely a hard to answer question, as usual. But such a
>>> limitation should have been observed earlier under real workload...
>>>
>>> Jan
>>>
>>
>> Here is a trace that proves how xnsched_sporadic_pick and, thus, 
>> sporadic_suspend_activity are not called:
>>
>>          disrupt-1682  [000] d..2.    94.171753: cobalt_head_sysentry: syscall=clock_nanosleep64
>>          disrupt-1682  [000] d..2.    94.171755: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
>>          disrupt-1682  [000] d..2.    94.171757: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)
>>          disrupt-1682  [000] d..2.    94.171759: cobalt_timer_start:   timer=0xffffc900008bbb00(smokey) value=60000001 interval=0 mode=0x0
>>          disrupt-1682  [000] d..2.    94.171761: cobalt_tick_shot:     next tick at 94.231756 (delay: 59995 us)
>>          disrupt-1682  [000] d..2.    94.171770: cobalt_schedule:      status=0x10000000
>>          disrupt-1682  [000] d..2.    94.171771: cobalt_trace_pid:     pid=1682, prio=30
>>          disrupt-1682  [000] d..2.    94.171776: bprint:               xnsched_sporadic_pick: xnsched_sporadic_pick, curr=1682 next=1681
>>          disrupt-1682  [000] d..2.    94.171777: bprint:               xnsched_sporadic_pick: sporadic_resume_activity, pss->budget 99964473
>>          disrupt-1682  [000] d..2.    94.171778: bprint:               sporadic_schedule_drop: sporadic_schedule_drop, pss->budget 99964473
>>          disrupt-1682  [000] d..2.    94.171778: cobalt_timer_start:   timer=0xffffc900008bc4d8(pss-drop) value=94216201725 interval=0 mode=0x1
>>          disrupt-1682  [000] d..2.    94.171779: cobalt_switch_context: prev_name=disrupt prev_pid=1682 prev_prio=30 prev_state=0x248044 ==> next_name=ss-d next_pid=1681 next_prio=20
>>             ss-d-1681  [000] d..2.    94.171784: cobalt_trace_pid:     pid=1681, prio=20
>>             ss-d-1681  [000] d..2.    94.171788: cobalt_synch_acquire: synch=0xffffc900008bd408
>>             ss-d-1681  [000] d..2.    94.171789: cobalt_head_sysexit:  result=0
>>             ss-d-1681  [000] d..2.    94.171799: cobalt_head_sysentry: syscall=mutex_unlock
>>             ss-d-1681  [000] d..2.    94.171801: cobalt_synch_release: synch=0xffffc900008bd408
>>             ss-d-1681  [000] d..2.    94.171801: cobalt_head_sysexit:  result=0
>>             ss-d-1681  [000] d..2.    94.231786: cobalt_timer_expire:  timer=0xffffc900008bbb00
>>             ss-d-1681  [000] d..2.    94.231789: cobalt_thread_resume: name=disrupt pid=1682 mask=0x4
>>             ss-d-1681  [000] d..2.    94.231790: cobalt_trace_pid:     pid=1682, prio=30
>>             ss-d-1681  [000] d..2.    94.231791: cobalt_timer_stop:    timer=0xffffc900008bbb00
>>             ss-d-1681  [000] d..2.    94.231794: cobalt_tick_shot:     next tick at 94.271741 (delay: 39948 us)
>>             ss-d-1681  [000] d..2.    94.231802: cobalt_schedule:      status=0x10000000
>>             ss-d-1681  [000] d..2.    94.231803: cobalt_trace_pid:     pid=1681, prio=20
>>             ss-d-1681  [000] d..2.    94.231805: cobalt_switch_context: prev_name=ss-d prev_pid=1681 prev_prio=20 prev_state=0x248048 ==> next_name=disrupt next_pid=1682 next_prio=30
>>          disrupt-1682  [000] d..2.    94.231810: cobalt_trace_pid:     pid=1682, prio=30
>>          disrupt-1682  [000] d..2.    94.231811: cobalt_head_sysexit:  result=0
>>          disrupt-1682  [000] d..2.    94.271767: cobalt_timer_expire:  timer=0xffffc900008bc4d8
>>          disrupt-1682  [000] d..2.    94.271771: cobalt_thread_suspend: pid=1681 mask=0x200 timeout=0 timeout_mode=0 wchan=(nil)
>>          disrupt-1682  [000] d..2.    94.271772: cobalt_tick_shot:     next tick at 95.130203 (delay: 858431 us)
>>          disrupt-1682  [000] d..2.    94.271914: cobalt_head_sysentry: syscall=clock_nanosleep64
>>          disrupt-1682  [000] d..2.    94.271916: cobalt_clock_nanosleep: clock_id=1 flags=0() rqt=(0.060000000)
>>          disrupt-1682  [000] d..2.    94.271917: cobalt_thread_suspend: pid=1682 mask=0x4 timeout=60000001 timeout_mode=0 wchan=(nil)
>>
>> Jan
>>
>> PS: I asked AI (opus-4.7) to confirm or disprove this, and it failed in 
>> its code analysis. It seems like the way the code is structured and 
>> commented misguided it in its conclusions. Sooo statistically human...
>>
> 
> Asked different ("find a path where..."):
> 
> "You're right — I need to retract part of my previous answer. Looking at this scenario through the cascade rule, sporadic_suspend_activity() is not invoked when a SCHED_FIFO thread preempts a SCHED_SPORADIC thread.
>                                                                                                                                                                                                                            
>   The path
> 
>   1. A SCHED_SPORADIC thread runs at, say, normal_prio = 50. Its drop_timer was armed by sporadic_schedule_drop() at the last cascade, set to fire at resume_date + budget.
>   2. A SCHED_FIFO thread at priority 80 becomes runnable (wakes from sleep, IRQ unblocks it, etc.) and xnsched_set_resched() marks the CPU.
>   3. ___xnsched_run() → xnsched_pick_next() iterates for_each_xnsched_class (sched.c:322). RT has the highest weight, so xnsched_rt_pick(sched) runs first.
>   4. In xnsched_rt_pick (sched.c:730–762), the head of the highest-priority queue is now the FIFO thread. Its sched_class == &xnsched_class_rt.
>   5. The cascade check at sched.c:757 (if (unlikely(thread->sched_class != &xnsched_class_rt))) is false.
>   6. xnsched_rt_pick returns the FIFO thread via del_q. The for_each_xnsched_class loop sees a non-NULL result and exits.
>   7. xnsched_sporadic_pick is never called. sporadic_suspend_activity(curr) never runs on the outgoing sporadic thread."
> 
> This looks more useful.
> 
> Jan
> 

The blast radius extends:

 - I added a preempting fifo thread to the sched-quota test as well, and
   it completely destroyed the thread group accounting: the group no
   longer gets throttled, rather than getting time stolen by the
   preemptions.

 - The evl core looks identical here and should be similarly affected,
   regarding quota-based scheduling.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
