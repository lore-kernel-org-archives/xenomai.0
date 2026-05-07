Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526903F0A91
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158426; cv=fail; b=rZ77ydOYV6LGBpjVzq2UfQhWCziGj9NUO5jUbt1829vphiuPmT9uTyLxI6Vv+FPRcicBPrEG9OWs2V5SvI9OZHzoYNgLUtBp7pEov8WqQiz/KZ5pmgCNc6zze3Oqur5cVz4sgqMQ/tKTlAh9VM25Enm/f8lifrutccLDEa8tTHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158426; c=relaxed/simple;
	bh=eqRZRKiRr1ZexQvCGVGAj/xuxIjI7/xrXpq4iLx7eyw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWZow33manQ06fYJw0R2YP1tLpG02Fr+xqNZnngIUGTeGZ1QwGO6uGHuoqzwQBXYHgYufgc6T8Tsu8Og18ref/nZQh0OympjaHaIGOHdeT8gB88NHt69iBMRsJexZUuHbubI6isd9Fv201OtI2ev8v9rX0BDcK/FgARyncUiALc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jaLGYZha; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jaLGYZha"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFTmH0oaAxch6QiOTGcEgVYaYb8DDxJ8pNT4WwsFF1O/k1zWGgftYVfkLYFaSUGmBalgJlsJjVfRuwuDD7uO2UWw+pKsHggkrq06Zp7dUt3a4exFkOf4BZLjK8//nohDX6xvIX5iCiEdmuvZTW11CGREmIvn3t5KzcFFJMmMWZ62Psjdt91osGJYnPKE4Vi1ymp/+6yfgrSWLcSZhWM11SIswCUQIBzt2blb8bmiIwN5dun72uUm+OHEqmkaNNKwVv2TQBBitsm9ldm1yR4UbG8MAqJ7h3n8LXuTSNaTPppUBpdJOSe7AgZczTZdgRwHoyjiZ84xqRmTR2yURms69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VzYtGOyJhbc5mcbj/Fi5aF4iUS3+Da6nUJg8nXaUfw=;
 b=Hq8guXwPSSIvUWy/S4DElfQUHjCO1wNM6IRxA5q0WZYbaYvbJA0GF2JWjPDhtcOGMYDQe4OCvWyLvypXDjoC1MNk1hd6dWJLoGGzc4qEg8qErtLG3diR29HKiZV+bR/sfNndjETH0jphOxp51HfC9IORwT9BQzn58SqUkS2GY9zSwndY79u1maRxBuqp05bZ4404QsBuGZJtGZSNCFncK4ugi9x7S0sLiYfpByWZXJyo8t100S4FnS2+bbpr19g4tQXAcP3YiAx9zukR3HTsXl7AVMUvgOZUpbK8Hc0A7sTmVAypm2u/BGA90yhCa0leUjaeMXSeZGhXBQUuRzvPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VzYtGOyJhbc5mcbj/Fi5aF4iUS3+Da6nUJg8nXaUfw=;
 b=jaLGYZha6iikGDKbi+kFSEzMncKqaEzXlV9bEBHXrE05QKAcQCwFU4VqQEgys53fp6JuYI3YxK6tbVqs3UFj4jVcbmgm85avzFarzPm7w+pu+9xjkDm20SSOYWkSfXX9aYZfuuMTZ9t1nh/u6JmZLrkSybwMhOUiCyJ+LZJCLjhaqLwarfyr4QNbnXaXIRt+nCb3RskLFjVKjKZYQs26EjowS1mN2Tkbymlp7tCGMWMd3kJ0HaemLcZePwfuvqtdL9kZGJVPKcgmtJ2C0lqTVKdfUdcdtbNR3Mimw/2bPtBcpTuQqeicq+TwnOhgOCzjekRvnn893L+tlG3GbUKYsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6787.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:437::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:53:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 12:53:37 +0000
Message-ID: <665e76d5-22fc-42e3-a65a-4b55c74bd008@siemens.com>
Date: Thu, 7 May 2026 14:53:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/smokey/alchemytests: Relax mq-2 test over VM
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
 <dc069eaf339d470fecc3bae1d1f6e2d299c0cafb.camel@siemens.com>
 <50dd943e-4c75-456b-b540-5d8d2781d901@siemens.com>
 <313fd59a45d7860b8772040e1b74d6a42bea2770.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <313fd59a45d7860b8772040e1b74d6a42bea2770.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: cc35a3d4-b4a9-45e4-02d0-08deac37a7a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RTCXzL1axFa0MZ1foYPkADvo9myjdXZjR1EHOzfPrFSK2qTRCIH6SYb/3hP7dPMDhQh1Zx6RUi72q+muULWI/W9VkBRMj9arGVpUnq/MfMSUYL8FiZXqu8L6CEpaX7TUXw7r1Kl7CWv+YqH++AxF7xeON1WeFbuJM2U8zA4bWrCeuF9f11mNfXmAKgizO2T6DVc2MR8JRlZSX9f2LeHVqmjp974q3SJ8wK3Qub7JFq07Yv2QyCcDCHkwVYayb10CA82DV7i5lfaKEv6coSzZmbDoxax0J2TEaQyOxZreR9+uCz0GVLxTcc3jxMc5woFH6wcRfd7i9qj/Gw/b4hSnGnpzsFKYlNY5TyyNVPJ/W/aDkgw+BTD9Y40O1RRrLGeKogEoZKOBA1KVqSLj8xx8oYszpTQKOUCUyBi9+33KVfiMin9sK/J6JoFe4NDpE6wL5F2ALJjSX8AxrLEJZKjFmN34WhEnw0CFy2I6VLZWmx6sR5sY0ZqexZjqdlts++Ptn9/TptFxpdqQtVH/UToOdVAcI6iUZYDkmlO5FAUHxdYmq7bGq83G/eZQaGJ1RhwzA9j2k/FatVs7eIXU4o3QS5JbVS+fteij3eCQfua13/F1b4NzKb2tJf2+v87rqvke3SHDc7elrYNzcB0i6irfB9RxW2qns5Eq/yjPd3lsejuTu4MUkY+7biyt3G/ee02x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGVWRkt2Z2x2dHpJYzQvTVVCSXNuaWZ1d3FPWWlqNVRmVzNBMVhxME1GeVFZ?=
 =?utf-8?B?dE1xVkRIS0JXVjEzN1pacmRVaTY1eERyeUhVVkNxN2xOU3VVZDJFOEc4cGZa?=
 =?utf-8?B?cmt2R2dKTWI4dXpJTUpCVTJ4YzRWZ1htL2IrTzEwSHRIZ1l2d3NVMEQ2NHQy?=
 =?utf-8?B?ZUlZR2JON2FRMDgwL3k4VmcxOHB0bTBtWVA3WXAvOVBwZ2QwMjJQU0ZJTDBJ?=
 =?utf-8?B?TlBTdUNPWklMV2ZoNUQ2MFc4TDYyZnJGTEV3N1RXTG5uT09KMmtGNjdub2JJ?=
 =?utf-8?B?UkN0MU5XSkxwMnRzZVA3WWtjRDhBbHBRZXIvam9lazF4cEJTRTY0RjlDSmdj?=
 =?utf-8?B?ZmZQcHJBQnZ0bzFhNy9DWEpBTUpBUkV5aEtxWmhMeEpFdmJoQ1VoTm9WOWts?=
 =?utf-8?B?b2hGS2ZkWUV3THBzQ08vWFlkcGNjN0hPOTFjaXYyK0tsc2dRNnBjQUFySHcx?=
 =?utf-8?B?UWF3SFZpMHMvbDNTSHpydXQwZjRDL3FKUTRNdEZSMUhGTWlmYVEyTWlRNmho?=
 =?utf-8?B?ZzJLdFVlNU9tcHAvb1RKTlMreDVPcUJIMHZXdWdUNWVEREdKdk93UzFZZkZj?=
 =?utf-8?B?Y2VxRWVtWFM2bzBiaFNpRGF6dVBmbEJVb1dhV3hLSjVudkVXOTY2d2VuUWsy?=
 =?utf-8?B?K0ZKdDBDQkdoZEI3dVFzRStISDcwM29BNEhTcDcrajBiRW9xdjhsWUJnYTRS?=
 =?utf-8?B?VlQ0d2NHaEtrNitmaW5pR0RFSjI0YkQvY3RDNHlvQ001L2ZsLzBTUTlkNEZ4?=
 =?utf-8?B?aWhMUjhobEVDSHY1a1NJVmhSZkwrZ1ZQYXRERTNDVk4xYTNLOUlHTkZXTmx5?=
 =?utf-8?B?MkdCQnV5K084eUl1MEJITWwwbDJyUzlqRzJYRWswb2lLK3FsQkdSbzc4L2o0?=
 =?utf-8?B?MDJ2KytRV1d1ZDlqTTZOVU5TbEEyTHJOYVFRMEFpOTVkRHRxdkFNVCtXM1lq?=
 =?utf-8?B?NkxqWitGTlVWSHY2WjdaanRkbmJ0Tkw1UVE4NFJVbW5NTXNQQ0dMSThiOThG?=
 =?utf-8?B?amRWdElMMG1RUTZhQ1JBdlVRS2RpUG1kOTNnVFgwQzh6TG5kRUQwbW55TFJm?=
 =?utf-8?B?NEpMVmxsZ1pvWEhrSWp3QktFbVVWanRPZjIrN1dNVTdmOGs2UFc1SWtXMFNG?=
 =?utf-8?B?eHdFa1Z1eEJnbDQ2RHNqT28xYmFoZ3dyWVRicVdsTE5YdElqdzVCN0tKZXYz?=
 =?utf-8?B?THZ1bE1YbnhqN2lhcVZsRlBrV1poekErUTNHQzdkNHQ3VEI4T0x4MFprKzBv?=
 =?utf-8?B?V24zb3VHb21kR1FKREl4bVQ3QXRaRlFQeTcyNHJJMG15RjhOSXlXc1dzTTZN?=
 =?utf-8?B?TWNxNC9Ia1Brb25PZ3UyNVcwanhNbUEzRVNuTDVBR0RwRzl3bDNDZEJrYUlN?=
 =?utf-8?B?UXl2dzRxRDdNV3p3RFlxbHlMbC9ieXZQbnh0TkNraXJWUmRKalI5RUVCRHNn?=
 =?utf-8?B?eWtyNDkxSHkzcVhSRWlxNUtBRGhLcUl5MEZId0dFL1l2VTB3QUI1MmhNWlYr?=
 =?utf-8?B?M1NHSmZiTExlZ0p1QjRkRFMzY0wvK0lsMTU3QmgydEZWVmRqMUZMcURURkdx?=
 =?utf-8?B?ZzFiWmdxclRSWjMrT3hWRUprV21EQmJTK3JPNjVLSUE4VXdqRWtiTjhodkpj?=
 =?utf-8?B?YWFYU2YxaDNKQk5oUHcyKzg0VXA2L3djcXF2eFdlcHhKRWhUclVSUWF4bjBh?=
 =?utf-8?B?VkQwSU9nd1JoSGFPanhHYkRuZklkWGQxdHZwSURXc2xBYzhyTmVCdjBmQm4y?=
 =?utf-8?B?cXFJQ213R2x6ckZsYnRmSEk1V1IrNTZ5T0lTREJPWkpEOE1IeDlZbkhYbC9X?=
 =?utf-8?B?SklFNlkyNXhsYTFKVitjdE9QeExGdTQ0V3RFOW90WHMyQjZMMGIwZndhbTVF?=
 =?utf-8?B?N1RVOWVNMEQ5QlhHYW15TnJORHN6ME82MDU0aFZzRVhvYU9WUGFDNUltaDVZ?=
 =?utf-8?B?NFdITkJlYlRZcUdXdTR3Y25oYTlxN00rU2RhRGJUaEVvR2krZ3g1Vk9Fcmgr?=
 =?utf-8?B?b0NYNTlrL3JZU0dLWVJXMFkwcFdSTVA2RWNaN2d3VkxzYTVvdmlQcDRaTXo2?=
 =?utf-8?B?aVJ3ampNa2pLQ2ZYaW00RzBjOW15eVZ2NWxhTUx6ZWVwUFBYYVc4Ylc5S0dD?=
 =?utf-8?B?b1QrQmRMaU5rRVNqSXpYMWE3MCt2ZW1xUjJ4RWRScFVEVUg5QkpkOWNaTlh6?=
 =?utf-8?B?OFl6WGZRMENxWFlvbHdNWnJnZkFUREVHZHRQUTRuVC9CRVhjQUxTaklLUXdm?=
 =?utf-8?B?b0p4OWgwV0NTanErdTZuOThJRkJlKzh3TUZLOVU1VmN4L2V6SGc4STdPYjNM?=
 =?utf-8?B?bTZoeWc5T3ZOQ1VtbXp2ckFhY2RTWmpqV3J5UzlhUHlqZjNSeng2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc35a3d4-b4a9-45e4-02d0-08deac37a7a1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:53:37.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oACr6cGrcKVPWqMhP6BMwC+07q8oOGudfEoPJrML8hlZoscYprPjSws+Q1xg7fYHFpp3jvICO+HMFSJchbg+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6787

On 07.05.26 14:35, Florian Bezdeka wrote:
> On Thu, 2026-05-07 at 14:23 +0200, Jan Kiszka wrote:
>> On 07.05.26 13:03, Florian Bezdeka wrote:
>>> On Wed, 2026-05-06 at 12:26 +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> VM environment may delay or reorder the execution of tasks, so relax the
>>>> checks.
>>>>
>>>> Part of #52.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  testsuite/smokey/alchemytests/mq-2.c | 8 ++++++--
>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
>>>> index a389e46db0..09b26b2135 100644
>>>> --- a/testsuite/smokey/alchemytests/mq-2.c
>>>> +++ b/testsuite/smokey/alchemytests/mq-2.c
>>>> @@ -7,6 +7,7 @@
>>>>  #include <alchemy/queue.h>
>>>>  
>>>>  static struct traceobj trobj;
>>>> +static bool on_vm;
>>>>  
>>>>  static int tseq[] = {
>>>>  	3, 4, 5, 6,
>>>> @@ -87,9 +88,10 @@ static void main_task(void *arg)
>>>>  
>>>>  	ret = rt_queue_inquire(&q, &info);
>>>>  	traceobj_check(&trobj, ret, 0);
>>>> -	traceobj_assert(&trobj, info.nmessages == 0);
>>>> +	traceobj_assert(&trobj, info.nmessages == 0 || on_vm);
>>>>  
>>>> -	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
>>>> +	if (info.nmessages == 0)
>>>> +		traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
>>>>  
>>>>  	traceobj_exit(&trobj);
>>>>  }
>>>> @@ -99,6 +101,8 @@ int main(int argc, char *const argv[])
>>>>  	RT_TASK t_main;
>>>>  	int ret;
>>>>  
>>>> +	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
>>>> +
>>>
>>> Seems a bit risky to expect --vm as first argument only.
>>>
>>
>> It's not a new pattern, and I thought (please prove me wrong) that this
>> is already a filtered argv, freed from generic switches.
> 
> Yes, that seems to be the case, but the filtering seems questionable:
> 
> Taken from run_alchemytests():
> 
> 	tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
> 				 smokey_on_vm ? args : args + 5,
> 				 &test_ret);
> 
> Where args is
> 
> 	const char *args = "--vm";
> 
> args + 5 is pointing to garbage in case smokey_on_vm is false. Right?

Yeah, went unnoticed in via 61fc9ff4b7214fb1d9802aa7d177a555f0ad47e3.
Please fix and also check the other tests at that chance.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
