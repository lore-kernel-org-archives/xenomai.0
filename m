Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B3463B3
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 13:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTYS0h3fANjUh7P7/JlhSh2fKp93/ZdgCgWMb1tzjn9FndQFMBbeXaH/miuKXKkl/S97ZFADcXxcMFoYSqoFjohBhB38F37VKZHKyemPOmHIWlfgEqaTtPSPO4jVsPxlUQTfKm8wjwppgqrX1xvVf76BGb5XISwpJ7I1l/QV9qllr0+mSMsumDrUnyeOrynT8S8eUFULoWS+RIQLxOc+DleZ625cg9tcDHyz7hSunptDop8ST6IkoDONrU1mHk1VawLnRXRNvKHi/VBcXsPN217je0eveg/b1WCewFfR7koOyNeL8kt7YFAj/eByFGo+ByGa0Uu5wt9gCJLG5k9p9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBEG8+X0dSDxNnJTjO+CjAPizOSmVSlKwku4XvRXdCw=;
 b=iDMz66SVwGWcv2jm3wdZ2z0g0VEOnxr/TF+Bw3WdmUMc/OpRqtLblbNG3nt9t9sQoLlwkMBYuptJmgsKAIw/dPu7Gco33GdRAOze3yXLy5I7pE8e9itpRvtwMKcR/W2SVUudxiHAbfiIrFZzz3fUvEpVfYXN50qt2Xe8Vo91/4mCTVSHDERAFeNtAYvxAYpfG11yZVBVagH2kmJqT7h2ETrgdTfgEHcMwSY73awLHXg0OhiLtOhRkFYx33jk60Q3lPfyhOKB5Lw7riwTngdrV4R8aGF+Yg36Eppxymj3Rk88EO+rXD12C4Ud+QugvFdVTB3GXauF4gUEqIhJ5QLdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBEG8+X0dSDxNnJTjO+CjAPizOSmVSlKwku4XvRXdCw=;
 b=nH3VlUpacHii6H/mKsa0ZrwDeN/cDR6JVRlkzpaZMNAp/hJesc7oLLR2X9la4tfIx6gE/zluY4AEKFCF+YjvqDT3BIltZ81r+txIcJFlY1d2L5LJID11DJYl76PfnFtlA1q45UBOnXjj95kUmojmSf6yONx1Kl2v/oN3mg3Sc1bl+Tkp8QQXlJp134Tf/M96mOzTm2Uc5UVr+HmTe4fJDa8xAJDOAx8k9sIPLwPyHxQ1huaiQJTxCAIl0CVgn8sYYY4gufMfhVbnf28h+u1T4AmVr4kFrvUTlbZ38fzi4taGD/eLeu6/LY21GEvtWN+250JfqsMahhhmhO/HVyI6gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5679.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:315::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 13:49:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 13:49:55 +0000
Message-ID: <9b04ed69-f202-4dda-a4c8-856897ea7a48@siemens.com>
Date: Fri, 11 Aug 2023 15:49:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Issues with evl_mutex_trylock()
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, yo sang <stlfatboy@hotmail.com>,
 Giulio Moro <giulio@bela.io>
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org> <87h71zncwl.fsf@xenomai.org>
 <5e40a21c-2b7e-42db-88c3-5a6879f276af@siemens.com>
 <87il9l90k5.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87il9l90k5.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b8063a-c8e7-41a4-9261-08db9a71d81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8eZsRrkjFwuXGnQjyK0oPfFOfKQQ+F08bo+H3t/OOdvog83lXGMcd79lk9nxrwv6g3mm6kPNS0UjruqH9XF92BF5o8NBthSsVcOX1R/bbCIwZ1I/9WPsdRHHz4of4hmjCwznLEt9n9fG1CLB3Povs9n8qnj2fign7IC4G5nnHJfIUFvix6UtCIajkrYh6Rl6LKqt3ClPmwy9k+l1vzeW9jZIaEjhLXCQ0Mu9bFg/9+s/I9+PMI8fT61XWcyVtTtpphpfjMDXtOHMUBOeQZFCvxFQIQT1hyidw3B3hK9F7Wcci7UZaLJdjdsfduaoOn3WgGVW9dziPHv/3FTSgOurz0w9PPKcZfoSHwSGCUk3DWLmIuvaiKCWcJcGMOydHY2wcxL+1YAvIzRixarITnBvtusmeUBZGdOIvUr84hfzGRDYM+/sv37+0wRcgEKSeKJrt8NZYuej9pdEDLnh++JEb7/jsBKOQ5Zy+Pjzlh2T2sw3WI5zjn/q84q5N6MvZQvDYcesQ+7GmZFcUR/MsrtK48NXEDdlCWw5Gko8q74Ht6wdq6+suGB1KMXcXzhzjp+YsiMFKNQ3lwBmtPY++2GW75ZwyZ8k+xGw9DunPw2qLKTQc1MbPGEqIEDnX0T6qaxZ4WwIpUb73JvyDVMPuk+vMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(1800799006)(186006)(8676002)(8936002)(82960400001)(6506007)(53546011)(26005)(41300700001)(36756003)(2906002)(83380400001)(2616005)(38100700002)(31696002)(86362001)(44832011)(5660300002)(478600001)(6486002)(6512007)(66556008)(6916009)(66476007)(4326008)(66946007)(54906003)(31686004)(7116003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZTU2tUTFkzTk8yangwa1Vhamh4SEZURUNiYTl1MkhjY2JmSHJ5NFNENnpC?=
 =?utf-8?B?VmZLK25tWWZubjNkcnRZbVpVTG9RdUFjN2dtb21FVFRHdlpCazB6THkzSjNa?=
 =?utf-8?B?WjJmNm1KWUZSaDFDUWx3djJYdXc2QWY5czdlZ2c4MXRDa3ppdGJxVmVCOSs1?=
 =?utf-8?B?YnUzU0dRR29qWHRuczZLbkh0THVKa280ZUV3dlBFM05kMjdLdnNxYmlWdCtK?=
 =?utf-8?B?Qk40ZzhOR2JCVlNjRVRucWdzNzd3M2tQTEg2OFhpeUlLSFArQVNDQUFHU2pR?=
 =?utf-8?B?c0xkcGxOZDVNRGYzNTEwNlJESzZTenVsM1lFUVdDSldSQWFCQ2M4d0xva0J6?=
 =?utf-8?B?ZEp0K1V4Ti8zYlBOMlpXMHRqdVVVNU82OXZHYmJyTzQwdmpZcndHL0lmL3h3?=
 =?utf-8?B?QlZyNEFxUGpNT01JVFpXd2JEUlplZDZ5Zjc1cHJwc3BNeUcrMFIvTGtRbjdL?=
 =?utf-8?B?c29iSE1DbWhFMmZtdUs0VjdoWUsrRnVxdGJoNmtBWm5USUQvUVJ5M1pFcFo3?=
 =?utf-8?B?WFFZTzRMQzhJSlhuY29WZ2hUOE5XMUVHVVd5TFVGYm9mNTR4eUV0TllMZmtx?=
 =?utf-8?B?QU9QaWI0bXQvU21xZjE1M09nU2RLb3dqbFlxTCsza29WdnVQQzAyZUplNjhF?=
 =?utf-8?B?SWM2c3lOUUVZY2RERzYzc2VpbyttZnAzTDd3R3plU0lMVzBON0lpQURTL0hX?=
 =?utf-8?B?aFNPcEVtSDdsRmU4dzZxNGNMT0JLWFMvRnBydFVwcUhCclRwNmtZYjJhUGxh?=
 =?utf-8?B?TTFiNlM1UmcvMDU4TEU3a1ZWTlN5cjgwNE12OEp6TEc3VHlQaGdzQVdkSnhu?=
 =?utf-8?B?S1FRS2pGUjF1STZYSk1PN2lucTZSSVNRYVpETVI4SmFBWlZnbmprVnV3Wldq?=
 =?utf-8?B?bElQNXhQOG9tMkVwbWVtYzhnVzRLV2xSYldrU3BYb2R2Tkk2K3BCUE4vVFA0?=
 =?utf-8?B?TDEwcDBBRmNxdGp2UWJCQWVYWlNBbmNiNGdMNjlxcUpCQzY4bTR2ZkIrSi9k?=
 =?utf-8?B?SzJwOUg4TC83anhjMTRJZUh6NVdLSmE5SXA4azB2NEpycGJkZGkrYUVQd2ZG?=
 =?utf-8?B?WTN4WS9aT0lCNVBRYThDQmRFcTZWWHF0RCtTZkZLbDdSQVNyakFXclYvc013?=
 =?utf-8?B?MXc2MzY3MSt6L0kzcnpld3F0MlpmK1J2YWJDUG81OUxndDM2YVhESFRLVktD?=
 =?utf-8?B?SisrKzA4YXdVOHo5amgxdHZYcVZReGd5TEFMQmNCSGlFWEpuTDlta0tQVEN0?=
 =?utf-8?B?U1lsQW5KaXpLd3FsUG42aTF1ZW1KamoxNDhSaDBQZE5ZODB4REN2YWVQRThm?=
 =?utf-8?B?Q2pKUkcwMGdPUWk5V2NhOXhHZW9ON00wVnhxTmROTGZjaTUwRXM0T05tOUdK?=
 =?utf-8?B?OTZEdnNoeDNmSkhZbWl1MkQ4c0NFeFJvVjN6bDBjZmxKRnBXV21JMThLOUcv?=
 =?utf-8?B?WE01ZVZRUGxGcFVXNy9rcklhR0ZRR2dpK2xRdm9Gd0ZKVFhsbktaanhiQWhU?=
 =?utf-8?B?VmFzUk9IUW55VkxoTzlrelpoeFFPSHFYajMyYW1DL2NUTHhxb3BDMncvNjJY?=
 =?utf-8?B?d3NBNmtYdmQxRkFnMVpuUzRhdmVlUDZBMkdUMWNjVXlnbnFlS3ZwcHlYa1Y4?=
 =?utf-8?B?cjF2K1FsWEJEQVFCMzJiZTlIRThwV25IYVRTMlA1Nm1rd2NSdk5La0twUFlR?=
 =?utf-8?B?dzNUMGx6V0ZabXp1a215aUFvbVNHM1Y4a1V3Vm02VzgvUWRFRlFPZWV6VFYx?=
 =?utf-8?B?LzVwSlo1dU0vSnhxbXlMQStUS1lJbVVaZFdFK1FsU0pSRmJTVGVNejY1M1Jm?=
 =?utf-8?B?Q0R3eEh6NFlCa3NVUXZOYitjOEQwSHhjYm1pYWZ2OHQ0bGZRWHlMek9MUm9U?=
 =?utf-8?B?L0UwQkkwR0UzaUllSVVoT3ZLeGVCT0JtdG5rTHhVYm55RGluVFQ4MDU3ZnVW?=
 =?utf-8?B?d2dVSDRrSHlrMFQ0OFNMWllMZUR0T2tFTkE4NjFQalcrak9SQjRDbnBrUVl0?=
 =?utf-8?B?aCtLS2VraFB5UzE0bHBlZTRXN2VHK3N1bWovdlJPTjNQYldqZDNRMWZ4RG5M?=
 =?utf-8?B?OG5EWGE5eHB5b0JHYUY0L1pUU0pXczQvNE1wOUtDcWNoRWxEQmErdzh3MmVO?=
 =?utf-8?B?RUYwL0ZwZlJuQ3EwYmV6NEFOeWI1bExsYXFRTzQvRGFhaHRiZCtIWU4xRThI?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b8063a-c8e7-41a4-9261-08db9a71d81c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 13:49:55.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQCtF+XlyDbjsT6SlvRNm04Gij/dUxhczo/2tQNN98VKQNOD9qhcfkTSP2RBYTUnCmkswvZ2/THbPySpH0ze3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5679

On 11.08.23 15:17, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 26.08.22 18:17, Philippe Gerum wrote:
>>>
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>>> Giulio Moro <giulio@bela.io> writes:
>>>>
>>>>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>>>>
>>>>> Here's a summary of what I get when running the test with some
>>>>> parameters (arguments are: "max iterations", "number of threads to
>>>>> create", "priority of the main thread", "flags (t means don't print
>>>>> anything). The error code reported alongside failures is the base 2
>>>>> representation of the return code. 100 means that errors were
>>>>> detected in evl_unlock_mutex() in the main thread following a
>>>>> successful call to evl_trylock_mutex(). During these tests, the
>>>>> output is piped to cat and then redirected to /dev/null.
>>>>>
>>>>> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
>>>>> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
>>>>> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
>>>>> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
>>>>> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
>>>>> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
>>>>> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
>>>>> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
>>>>> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
>>>>> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
>>>>> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
>>>>> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
>>>>> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
>>>>> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
>>>>> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s
>>>>>
>>>>> So, when running with 2 or more threads, the same error keeps surfacing very quickly.
>>>>>
>>>>
>>>> Confirmed. There is something wrong.
>>>>
>>>
>>> Please retry with this patch in. There is clearly a race in the current
>>> implementation of the mutex release code, specifically the release path.
>>>
>>> @Jan: If believe this gremlin may be in Cobalt too. The key issue is
>>> with the handle transitioning to NO_HANDLE before transfer_ownership()
>>> switches it to the handle of the first contender in line. If userland
>>> manages to slip in with a fast_acquire() during this tiny window, we may
>>> be toast, with two threads actually holding the same lock. The issue was
>>> made more obvious with EVL which does not serialize the trylock code
>>> around cmpxchg in kernel space, triggering the issue faster. I'll have a
>>> second look to Cobalt, but since you know the mutex code in depth there,
>>> four eyeballs would be better.
>>>
>>> diff --git a/kernel/evl/mutex.c b/kernel/evl/mutex.c
>>> index e0cf1ba21d5b4..d96f8c9f04df7 100644
>>> --- a/kernel/evl/mutex.c
>>> +++ b/kernel/evl/mutex.c
>>> @@ -899,14 +899,16 @@ void __evl_unlock_mutex(struct evl_mutex *mutex)
>>>  	if (mutex->flags & EVL_MUTEX_CEILING)
>>>  		clear_boost_locked(mutex, curr, EVL_MUTEX_CEILING);
>>>  
>>> +	/*
>>> +	 * The whole logic is based on the invariant that the current
>>> +	 * thread does own the mutex being released.
>>> +	 * IOW: currh == atomic_read(lockp) & ~(EVL_MUTEX_FLCLAIM|EVL_MUTEX_FLCEIL).
>>> +	 */
>>>  	h = atomic_read(lockp);
>>> -	h = atomic_cmpxchg(lockp, h, EVL_NO_HANDLE);
>>
>> This here was different from current Xenomai 3:
>>
>> 	currh = curr->handle;
>> 	[...]
>> 	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
>>
>> Under cobalt, we are using the thread handle as expectation value for
>> the fast lock. If FLCLAIM should have been set there, the cmpxchg will
>> fail, and the fast lock will NOT contain XN_NO_HANDLE until we switch
>> things in transfer_ownership(). IOW, I don't see how Xenomai 3 could be
>> affected in the same way by the issue that you fixed in EVL.
>>
>> Am I missing something?
> 
> No, I agree, Xenomai3 is immune. Either FLCLAIM is set in which case we
> would not match the current handle therefore the fast handle would not
> be available for grab, or it is set and we would not attempt to transfer
> the ownership.
> 
> False alarm, my bad.
> 

Well, we still have Sang reporting that he saw an issue that was gone
after applying your patch.

Sang, could you share your test case to validate what you were seeing?
Maybe there is a different race somewhere, and the patch changes timing
but does not fix things for real.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

