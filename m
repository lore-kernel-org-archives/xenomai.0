Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AE46BD
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 07:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTRu+1rkFQ1s1jNcC6EEf12FT2Op8QYEm/+rciaIpNSUct47AkZf5yo4a3mZdpUgrNRu8Zi1IC3S/6wsdIMVqkf19WDpwWCrmEsWIsBVVXhpHkwuIE2LIIhF3HitICwnuim84zccUFWDIDGyVh4Xl9Hy6qvMNSfZyS3pZ8eQ9ocsDLgZ52HRXNtttGMiAz6EDOxhmoR/pBomBTv1HJvjunbNnYzBdzpmh7PZnH7tdYqaxYOn5srldUDfQPQ+q5pwdX3clt2QSm5OZUUrKqpjhCihLg4AfR2hOvOmP1fjTwIzR3bmRqG7f/9AySkFr6SxkpXw0WRwiiXDRatQJZEHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyHsHcIZCqTc2QwjCYlTaFL4JpzRwScNrYoCYrLOfNE=;
 b=H3KVt05EhsjdR5uE2iTZEOiCrdg0+1sVEXqnhb6GjfzbdYHP0CdWfJUVpteU4JT9ct7mQVEam12BXqTwMxYYPxfZaPYc8dxCIKSaoAVqyccD1Olt+1T6v3TUSMFKAt2pxxnn/FPX7Feb6AeJuy1TDZIf4Kjp/HJe7J9KuUC69MfDkMws1j0jeGPDg2JGWweSER3Kjx3uY0S1KI2FPDcwOkCNc5M2l7LRAYtaAHkGjevGnYmkhwZNtL5aw0eTRpyEmu/Que9j51wp9LIxaWz1z7bbc82Mtrc+rafS7JbKEpHbpqNKGycejn456NHVwpLqXzKO811kbs4E6KukqObqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyHsHcIZCqTc2QwjCYlTaFL4JpzRwScNrYoCYrLOfNE=;
 b=l9jBR5RjmWZ1C9hjYKocyV1umpMuVxOABgfRCIuotj1woydoYDh4pMnVT1nBvVYEyc4yI2ZDHW65v+exSY/Wc1kZqlCA7AE9eYpb3tp9Pi3OGnRvZkRpqFGUWse5+XBV4CIiinutGx+2cRCC5Bl22xdt5DgZi1nZFuZQcKWaPMU/A0gskuqDqGLwRA3GqBx/irQJ/AxwH1f9z6aNPPOErbiivJrcuD1YCGIkGl0K6ud/vom4fjnB/f98M8q4/MZDCxuhlY2dwRHn92fkay1FiNx23SUK7ARh1LbWa2vPsdIYtkoX/Jd8/z+GRznLxZ68k6MmRfcfXcsAVbP7UjE6UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7288.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 07:58:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 07:58:02 +0000
Message-ID: <4c84597f-37bb-49ff-8433-ccba4f80deb7@siemens.com>
Date: Fri, 11 Aug 2023 09:58:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Issues with evl_mutex_trylock()
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, sang yo <stlfatboy@hotmail.com>
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org> <87h71zncwl.fsf@xenomai.org>
 <87h71xblu1.fsf@xenomai.org>
 <a2b3c058-6166-41fb-9e34-6f414faf814d@siemens.com>
 <87bkffqnwi.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87bkffqnwi.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 48170b0e-f82c-4b4d-8bc9-08db9a40b000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+IyKxZPr0tXpVORMld8Xtpffdk7Xa58mOxFyKT//mTzT7MQa2+tBqKjLQO0/MNvLxoM7K32BpmyQtbwK/H27kmrpJDFzBionceNWYHKnb8WKKWvbgqdrg2o7StI8ahIUwp/W4t2D09QFulAy04nndpGTebV9pw6JVanS18StB07Zb0JeMMBN6Tl5tFnZbyilEi2ebKWUBOwCFsj44ZyQ+yVG0Aya9v+Y4J/XDwaf1ZdsKXTxIE217cjdynAdACjwv7/AiuJFRVJXqDfN8wWHP1qtyrU++96pailEknsAskdqcnrTqYK4odvL4OSLJxSPTkfBLnDKDf1KBoTYHSrnY0g2A2/1DdmyUYM6Sl1yylEsKz2cMpSIWiTfAKPnI1zswZCG2RX/FCL+L98coxpwDO2YEr9sR5Ar9/Rbq024rloVIF+bJkMlu2dbNBR4yfPJYkJ5dsJWNUbMbo2nZEhzPBUPLUoR5Z/4DQ+ZM1YWLAW1HI0Q4F6WKtoFjdytttzkW7d5tY5vfZrkzUV+hO8bX3MTM1DSzunc/a5kLbmsb3NOJTQ7nUC3w3YvoYMz6ejVvvPWEaafslaVTLj6kUCCr+tS1rS0TwDuoXxahOml0rj0iksFxGE7UbFBePilRxWmTPqPDViUY42NM6OiH2eU5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(186006)(1800799006)(2906002)(31686004)(6512007)(966005)(4326008)(66556008)(66946007)(38100700002)(6916009)(83380400001)(66476007)(31696002)(478600001)(86362001)(2616005)(316002)(8676002)(8936002)(5660300002)(36756003)(41300700001)(44832011)(6486002)(82960400001)(7116003)(53546011)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHZaaHNxS1h1VW1MRFkya21tcGxNeWg3aEJ2QjFZNVpMWVU5Y1k0MFRiRmZP?=
 =?utf-8?B?NkdGVFRBNmFYa1FBQ01GSjU1a050elFpZnpGa3RQcjNwQkdSSDBjSjE1R2ZM?=
 =?utf-8?B?cm1OcTR4OUVGaFFORVdEaEJRc3hCbFNLUjVFL1ZSUktPVURza2t6Z1VYbHV4?=
 =?utf-8?B?eEZndUtZVmNhQUVlMjY0UWhzQkNWaFFmc05SUVlxVk0wZkp4MDRCRnl4K1VB?=
 =?utf-8?B?ZXkreHVCZUVDbUZFazRadEdVNDJlSXJFM1BkR0xFODBSMDFVZkdrdFlMTEZm?=
 =?utf-8?B?UU1sczQ2RitmeFNQUFI2SEM0WHFZcHpLOUFxcVFvOG50ZVp0czFvV2twMmdI?=
 =?utf-8?B?YjhSUHhBZmtIMnNnRGd2eWxrbkJHdlJ6NG1nZEdoR0FoVmlLRFRaVUxZVXZB?=
 =?utf-8?B?dUVtVWFDNEFyUjVGa3dsQiszbnJaTXNtMTNWazQ4UzYxYWJkWVpEaStvK0lS?=
 =?utf-8?B?SkZnVHk2TDFuTVV2NU01V3h0NXdjYWZzMWw5VWdNZ0t5T0MxQng0Q1IxQU9P?=
 =?utf-8?B?M2VEc05wZVl1V3dSYk9wTUs2R3NEZk9PRS9ZeSt6bnhIL2h0S2RuSWlCZCsr?=
 =?utf-8?B?ODI4aVd1Q0d1NkQrRDlvTis5M0tDYk1XMjNoZjJ4MDRWeHNWY0NjNXR1a1hD?=
 =?utf-8?B?YnhxcU1QR0wwQVE2NVJ5VzIyYmY1dEV3VFVYYTdTeGZaVWdEaDYwMUJOUk1S?=
 =?utf-8?B?NlR6Vm1MeU5WTGk5Yko5ZEVMZ0lVNFFnaU1vbWhKWnR6Uk13Wk9rbkladld2?=
 =?utf-8?B?STRRMWZMU3pvS3FHTEhqanhSYUl1SXpRL2MwZkxRZm5nNldQL3BqeC81aTBN?=
 =?utf-8?B?dEY4VlBwV0N4TXQ2aGYzN3ltcXdwS1BFdVk0QmdvRUtCbVN4dzVnMi9tZ2Fm?=
 =?utf-8?B?bGVIK1VvSklYV21zUExoMVlaNlFCUmIxVUFYalZzRlVJcU43bC9LWEtWYTUy?=
 =?utf-8?B?cWFsUXJvK1hXdWRKTE1pd2xxeVJUS1RES1RvMUdueTgvTWRCUTI5aE5UQ010?=
 =?utf-8?B?QmY2OU5Ib01NbnJEMjBkZGFQL0hoN3RoemtnQzZtRm1PN2Fjdm8wZC9WbWM4?=
 =?utf-8?B?WXhRejBrOXhHR0RDa1pDbWd6d3dVT05iZGlzZkJ1ZENBRkFQZTh3QW9YYytO?=
 =?utf-8?B?UGUzcDF6R1Ezd0JkNWw0Qys0aVhMU2laNy9pSk13K24rMzA0M0pNS3k3aTBK?=
 =?utf-8?B?Kzd4eHg4b2l3MGhiazMzNzh5bVRKNHJOTDRRNzhuWVpYOGZWYjhJV1I3dlVF?=
 =?utf-8?B?OGN6RXdIQXhRV1Y3T25INHRpdzRXTS85UCt4bFl6TFIrWm02UE0wbUtwRGZO?=
 =?utf-8?B?TWpiY0pGM1NFOWxxTnFRcTdMdWJyeHRhckJYU0pLMFpZMURRc0VwWDNUSHVm?=
 =?utf-8?B?ZFdrQzhWRTZ4QmlmZWJiaTFwNGJDV2xadHlCUEEzK0oxY0RVUjVvTWpyV1c0?=
 =?utf-8?B?cUtnTkJKbitIM1VxT2F6YjVMQm9OZXFtRHptUHVEZ2xUc096R0NqZGR4VzJk?=
 =?utf-8?B?eU14ejQxMUI1aDJpT3hPeWxJVVF0RWF5ZWlhMy9oV2YzMzRzWFo2TmUzNjdY?=
 =?utf-8?B?SmlnUEFXd2luZDF4cXFlVVk2ZTV0RTI4dDI3QVFWS3lVNHpTWEg0UUFwWmdI?=
 =?utf-8?B?NkZRRjZyNWRTVzlSU3pPOTlHWjhoM09LVlJiVVV0eHp4Wmd3cmdHRXkvNEpx?=
 =?utf-8?B?YnpxK0Fpckt6SUNVTEN2MDcycFZQQzVLeEhObCtEYjl3TmRsRHVmanVTZ0pO?=
 =?utf-8?B?T3BINDA2MXljK3BFalp3ZzVCYVYxQm1jZmxFL05YVFljc25ZRTcwb2VHOGtW?=
 =?utf-8?B?cXBaZHJHbHBycVhxcEVTV1k0bFQ0cjExdmxuOVV1S1FmWGl5R0RYM2d3TEwr?=
 =?utf-8?B?dVl5RmFQdW4yWHJSbUhvVVFEaFF1WnNIWFpBVzlUZXJsaUtpMEY2Nk90dWZH?=
 =?utf-8?B?eG9SdlNLSUNiTVVOYllTQUFFN0QvUTRQN2I0WHQwQUNwSVhFUWd3SHliWm5G?=
 =?utf-8?B?b3Q0d2tnb1RtVVNONG9icGUyTlUvYjY5RDdZcjluRzd4clBvT2p0YzF3RnRi?=
 =?utf-8?B?dXRnR0JPVlNITUduVnE1cVc0WE4yOHg2TWhSN2Vod21QVWFET0NOMGltRlp4?=
 =?utf-8?B?N3lZOXo5eGJiR0wwTWQyd3JxZExNQjZhOTJvV3U5RkMzOUxVQ1BTQUFUREZa?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48170b0e-f82c-4b4d-8bc9-08db9a40b000
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 07:58:02.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tS3yny2UBL/Im15ehGBmNxwxn2G7n1z/mqrvtwr5lR/67fDY84hgyyjhnIGcE6OhGcVUai/XXo2g5oCKzTyd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7288

On 10.08.23 10:18, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 27.08.22 19:53, Philippe Gerum wrote:
>>>
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>>
>>>>> Giulio Moro <giulio@bela.io> writes:
>>>>>
>>>>>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>>>>>
>>>>>> Here's a summary of what I get when running the test with some
>>>>>> parameters (arguments are: "max iterations", "number of threads to
>>>>>> create", "priority of the main thread", "flags (t means don't print
>>>>>> anything). The error code reported alongside failures is the base 2
>>>>>> representation of the return code. 100 means that errors were
>>>>>> detected in evl_unlock_mutex() in the main thread following a
>>>>>> successful call to evl_trylock_mutex(). During these tests, the
>>>>>> output is piped to cat and then redirected to /dev/null.
>>>>>>
>>>>>> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
>>>>>> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
>>>>>> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
>>>>>> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
>>>>>> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
>>>>>> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
>>>>>> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
>>>>>> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
>>>>>> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
>>>>>> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
>>>>>> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
>>>>>> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
>>>>>> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
>>>>>> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
>>>>>> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s
>>>>>>
>>>>>> So, when running with 2 or more threads, the same error keeps surfacing very quickly.
>>>>>>
>>>>>
>>>>> Confirmed. There is something wrong.
>>>>>
>>>>
>>>> Please retry with this patch in. There is clearly a race in the current
>>>> implementation of the mutex release code, specifically the release path.
>>>>
>>>> @Jan: If believe this gremlin may be in Cobalt too. The key issue is
>>>> with the handle transitioning to NO_HANDLE before transfer_ownership()
>>>> switches it to the handle of the first contender in line. If userland
>>>> manages to slip in with a fast_acquire() during this tiny window, we may
>>>> be toast, with two threads actually holding the same lock. The issue was
>>>> made more obvious with EVL which does not serialize the trylock code
>>>> around cmpxchg in kernel space, triggering the issue faster. I'll have a
>>>> second look to Cobalt, but since you know the mutex code in depth there,
>>>> four eyeballs would be better.
>>>>
>>>
>>> I believe that the problem just fixed in the EVL core also affects
>>> Cobalt. This is a suggested patch for fixing the same issue in the
>>> latter on top of 3.2.2. Smokey's posix_mutex test still happy with it.
>>>
>>> NOTE: the issue at hand is two threads being granted the _same_ lock
>>> concurrently, so this might be potentially catastrophic.
>>>
>>> ---
>>>
>>> commit 4417674f427a78ba7fe2c8e5b2607d5ca6886ec0 (HEAD -> master)
>>> Author: Philippe Gerum <rpm@xenomai.org>
>>> Date:   Sat Aug 27 19:44:30 2022 +0200
>>>
>>>     cobalt/sync: fix race in release path
>>>     
>>>     The mutex owner handle transitions to XN_NO_HANDLE before
>>>     transfer_ownership() may switch it to the handle of the first
>>>     contender in line. If a user context manage to slip in with a
>>>     succcessful cmpxchg() in this tiny window, two threads may actually
>>>     end up holding the same lock.
>>>     
>>>     To address this bug, set the handle directly to its final value as a
>>>     result of transferring ownership, without transitioning via
>>>     XN_NO_HANDLE, closing the race window.
>>>     
>>>     At this chance, stop duplicating the logic which transfer_ownership()
>>>     already provides.  We may unconditionally rely on this routine for
>>>     either passing the lock to the next waiter in line, or marking the
>>>     lock as free, updating the fast handle accordingly in both cases.
>>>     
>>>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>>
>>> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
>>> index 6e50e537f..c5398dba3 100644
>>> --- a/kernel/cobalt/synch.c
>>> +++ b/kernel/cobalt/synch.c
>>> @@ -850,6 +850,17 @@ static bool transfer_ownership(struct xnsynch *synch,
>>>  	xnhandle_t nextownerh;
>>>  	atomic_t *lockp;
>>>  
>>> +	/*
>>> +	 * FLCEIL may only be raised by the owner, or when the owner
>>> +	 * is blocked waiting for the synch (ownership transfer). In
>>> +	 * addition, only the current owner of a synch may release it,
>>> +	 * therefore we can't race while testing FLCEIL locklessly.
>>> +	 * All updates to FLCLAIM are covered by the superlock.
>>> +	 *
>>> +	 * Therefore, clearing the fastlock racelessly in this routine
>>> +	 * without leaking FLCEIL/FLCLAIM updates can be achieved by
>>> +	 * holding the superlock.
>>> +	 */
>>>  	lockp = xnsynch_fastlock(synch);
>>>  
>>>  	/*
>>> @@ -862,6 +873,8 @@ static bool transfer_ownership(struct xnsynch *synch,
>>>  		return false;
>>>  	}
>>>  
>>> +	XENO_WARN_ON(COBALT, !xnsynch_fast_is_claimed(atomic_read(lockp)));
>>> +
>>>  	nextowner = list_first_entry(&synch->pendq, struct xnthread, plink);
>>>  	list_del(&nextowner->plink);
>>>  	nextowner->wchan = NULL;
>>> @@ -916,8 +929,6 @@ static bool transfer_ownership(struct xnsynch *synch,
>>>  bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>>>  {
>>>  	bool need_resched = false;
>>> -	xnhandle_t currh, h;
>>> -	atomic_t *lockp;
>>>  	spl_t s;
>>>  
>>>  	XENO_BUG_ON(COBALT, (synch->status & XNSYNCH_OWNER) == 0);
>>> @@ -927,19 +938,6 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>>>  	if (xnthread_put_resource(curr))
>>>  		return false;
>>>  
>>> -	lockp = xnsynch_fastlock(synch);
>>> -	currh = curr->handle;
>>> -	/*
>>> -	 * FLCEIL may only be raised by the owner, or when the owner
>>> -	 * is blocked waiting for the synch (ownership transfer). In
>>> -	 * addition, only the current owner of a synch may release it,
>>> -	 * therefore we can't race while testing FLCEIL locklessly.
>>> -	 * All updates to FLCLAIM are covered by the superlock.
>>> -	 *
>>> -	 * Therefore, clearing the fastlock racelessly in this routine
>>> -	 * without leaking FLCEIL/FLCLAIM updates can be achieved by
>>> -	 * holding the superlock.
>>> -	 */
>>>  	xnlock_get_irqsave(&nklock, s);
>>>  
>>>  	if (synch->status & XNSYNCH_CEILING) {
>>> @@ -947,12 +945,7 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>>>  		need_resched = true;
>>>  	}
>>>  
>>> -	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
>>> -	if ((h & ~XNSYNCH_FLCEIL) != currh)
>>> -		/* FLCLAIM set, synch is contended. */
>>> -		need_resched = transfer_ownership(synch, curr);
>>> -	else if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
>>> -		atomic_set(lockp, XN_NO_HANDLE);
>>> +	need_resched |= transfer_ownership(synch, curr);
>>>  
>>>  	xnlock_put_irqrestore(&nklock, s);
>>>  
>>
>> This apparently fell through the cracks on my side, not being submitted
>> as top-level patch, thanks for pointing out, Sang Yo.
>>
>> Philippe, this is still valid?
> 
> From reading xnsynch_release() in Cobalt and the explanations in that
> commit log, it is. Since you were a direct recipient of this patch, I
> assumed you queued it for a deep review given its criticality, so I
> moved on, sorry for this.
> 
>> How can we check if we need it and it
>> does the think it is supposed to do?
> 
> Unfortunately I have no xenomai3 test at hand, this bug was originally
> uncovered in xenomai4 which initially imported the xenomai3 mutex logic
> into the EVL core before I reworked it heavily last year, starting with
> fixing this bug. Maybe the test case [1] Giulio posted back then could
> also trigger the issue with xenomai3 which still runs the original
> mutex implementation.
> 
> [1]
> https://lore.kernel.org/xenomai/a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io/
> 

Tried that, had to fix the test first (racy in thread setup), but it
does not trigger unfortunately.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

