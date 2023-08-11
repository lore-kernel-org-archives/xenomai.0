Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6929DF2
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 12:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9YuLA1tCiIiemH9FuAeqjR4bcVA0cUwpz+FrEsEr9r9HYTxNaHwsEiIJzR0coA5dckJqWh4nRDgmqlYxAhF63f7CQSvN6UtYrJpqlaAiGgWaZREIWj1IpktvhPhunsgF61BndhNo1+wBBQNpGip8t7AUTYJXIDuv8oyXzmRy+ddLyahrI9D8f5QCfMrppjm+D58TL860RnS5315R3J1yCToFh3MGLsJgNuFdSOlMYco8zE4fsC0CyVRDJIYyL+VY/J5v3IPrnrh/HQN1RLMO615g3N9CMXWJp/+7SdNm+EnmNwhF8JqJpz/BdxJjP4kAGwtxL7TNrSrwVlkXd1MjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czzykW52kO9yZEJicESTifAq9ucxdwq3DwZSdjqYHKU=;
 b=LztzLT/O75D33qMCUayXi2zBV83yTkNn6qMPQw0y+Bnr+3a9ekjK1ycnfQ5Q6MmH/QE63RlY00uugDjocS4E57QtmFKS5i6ap9lGtc+m5zGXBbBQvWWHz+T68o9Bf5C4xsRYwf4qbqdTJCgVDPAjkXSLM+UmUbkUz5PPxgl9gKin8UB3g7arGUyqmj+bk1IqrcIV8U8Hkg8ijdnAralY7i2ZDNMjonQ4rNLcSL16ZJfM+WkQrVwHxbCd1hnJdw9UX6Kp2RmPUWyBE0xm9UooBcHjvo7Oe2mU1KxDsmwp3WGWRv57ATgzJ4kv0ZAus5QwKvwsJ9wJwhMgKaa6B9sFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czzykW52kO9yZEJicESTifAq9ucxdwq3DwZSdjqYHKU=;
 b=RucoQxSHCQjLjm22wFhrCmeyoy/Gu51bB1FgvxJkQIHKVI8liB5IruX3e+NkZjxjB5y1qdpW4HphvSZ1snfghtrpB7bePh/ASz8F5rkg4TVyjltiCaJuHr6DzfarOB/541yuKJ/68I1eu/0FkOA54feeAZbGltN++B3vEMnHyrpYP97htcovb20A7m0r1f/oQPAG2dLcFimi0pCcuaOaTtMvW79ioyOHgIzEKnO/2TGziyN9h41hk7L6jFDqGDEj8owArQ8MIGku5bnFp8n8WWTmYppQx2GHypShmcIsUKOg68AmDIhMr82emBSOpSpGRkX2msaVI+YEvJfo8oUZZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 12:32:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 12:32:11 +0000
Message-ID: <5e40a21c-2b7e-42db-88c3-5a6879f276af@siemens.com>
Date: Fri, 11 Aug 2023 14:31:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Issues with evl_mutex_trylock()
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, yo sang <stlfatboy@hotmail.com>,
 Giulio Moro <giulio@bela.io>
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org> <87h71zncwl.fsf@xenomai.org>
Content-Language: en-US
In-Reply-To: <87h71zncwl.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0439.namprd03.prod.outlook.com
 (2603:10b6:610:10e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 768521c3-83a6-44f0-68ee-08db9a66fc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WIgmB0jsuwbYcLz8TWESWVuoPemeHr5a1AW+DglmNdg0WzzJnkhVDrAm7ZDb2tUs2AFmfmzsPCaBFy2LbKsgMK2pg03b90FrRBdMLOj6wJ+mUKdKnRQEaXq/t/TToIXEFrCqhAjsI4Wl8nuFb0lRrdMei6Ufy65+8yd4j73ioPeH8I1zxl6jcIGbD5TGt/TpAGZerKWvmTI0NhC3LidrN88mIQQJSq5eF5eeGGuX5hFEcMvyZR7Rn7f0Y99hJHBrJK8cths7asV+Q0p9MlkB2MIYcO4Cu/dVrcjGeeYTmbRsY0rfz06oFRTDAGWrOseoDao7ljLyfNrSw5at5fGHgnfgBe6z01G9B7O0rBuXjZtGfejV65zVbsBhXopUlS6ncQ+5H9dVqg7La4JXC6flib4kWOqTZ3AFIImgeEMOeL8qIqcs1k5ICHDZ8XoRBcJc+HD1OoOt2ukUY/0GF65Id8uEqSxidBooqy/cfQcPCVLwdwmoIHafKKBH+3BNvuAPjgUK755Fd1Z2SKLejXgh7GDGX9WVnwoLChAGqEqxUU1WxYMEp1KPAkDDCocChV/lVieBj04sA3ETC27mEMsuFA14vxNq5ckQpplvs1i9C3I1/wORx4jXXpGPblj+iy6GGJ5HSsjrdLb2agFCxq0vVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(186006)(1800799006)(26005)(6506007)(8936002)(8676002)(53546011)(41300700001)(36756003)(83380400001)(2906002)(2616005)(38100700002)(82960400001)(86362001)(31696002)(44832011)(7116003)(54906003)(66476007)(66946007)(66556008)(4326008)(6916009)(31686004)(6512007)(6666004)(478600001)(6486002)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVl2V0gxcktYUWtzWU5qRm5POENIQTFVSlo4VUQ4Q1Y2a0h1eXlSSGRCckJD?=
 =?utf-8?B?Tjh6WkNmc1p1T1ozYUs0ZXl1dEw4S280dzh4aTlPSmhkbVVHeHhIMGNtaDRs?=
 =?utf-8?B?b0kxZ1pldFJCbDNyREoranVRSncvdUthVjlmUDh2NkQwY0doQi9OQ1FSK0RH?=
 =?utf-8?B?aEhQMEhqZUR4TXo5am5YNGlQd3FLY3dnWTJ5VHdlVGxLZi9kWjhHZ0IwVllY?=
 =?utf-8?B?R2pQRGhZeVpWb0c2NDdaazgxdnkyZldoU0NVcWJuSDRsZlJBdEZSTGR5ZG8y?=
 =?utf-8?B?QkZJM0NsUGpoNzltSmZvWkI5d1RzWUlXNjNCZkQyWmFFN0IyM3o4VGZoQVQ3?=
 =?utf-8?B?RnNKdkI5SWtIYWdqVWhtMy9jcnAzNTM2VWtORlA4Mzc2dlJYeU1XcFdjWWFS?=
 =?utf-8?B?UGVac0ZnQUJ3VjNXZDNac293N2U5aXRzb29Vb3BnckJId3IyNlAxajlzUXVO?=
 =?utf-8?B?aktlcml1OGIrYlZ3R2ptL1ZYaEk0ekZJaXFMdTVUQkxGYkhvT0djSmhFQldZ?=
 =?utf-8?B?NjNWWm42bFdxR0JpQTZBS3FyN2NpRTd6RnFpOFArOFNHZXVmSzMyWmVuVXJ6?=
 =?utf-8?B?NHhZODNWTEtnMnEyd2hvcUFTOW1sNEFJRVVKbTRGVk9TRVcyekVEYzQ2by9p?=
 =?utf-8?B?cFFLRUFqdllEdTlkb3hDOVI3TlVQQjUrTE8vSGtkdTdGQUt4UG9uRzBBTEtT?=
 =?utf-8?B?aWY5QUJFNWdiVUljMXUyNFptRGtsUittbDFZVUZaTUhGUUpyTmw4OHlJOFZj?=
 =?utf-8?B?bFY4UGJuRnNhZyt0Q05tclhtOHFMak54MU9CdlJEM3B2cGJYRW96eG1xclk0?=
 =?utf-8?B?dlJ4U1EyWmNEcmEvbG9XZGxNcDZCV1Iwdk10LzcvUFBaU0JhZTRqa1JBOFpk?=
 =?utf-8?B?cUd6MloyZ2RsSEhVYWt2a052K1pmbWMyYmlFMWRtc01xN0g4UWp6T0NpSDhw?=
 =?utf-8?B?Tnd2WGs3aHIvMm9TWjViVTBPR0d0alpGbFl4Nk9oS2R0RVpWeDRhdFBuN3Uy?=
 =?utf-8?B?MmNqVTFIRm9ucFM0THRXZURmdHIyeU8zOFdqdlhXdzNtNGJxT243Qi9EbFVu?=
 =?utf-8?B?ZFA4bUJWemh1NkVEYWppdjNIQkE4aFcvenZPd0dVYXBiMUU1aVFXSmtxQzFE?=
 =?utf-8?B?QzVOcFRRc0EyMkZCZDFielBVSklpN05qYUUxM3VmYTlkSkpEV3k5VTBaOTJE?=
 =?utf-8?B?b01YTllYbVg4Y283Z1NBSzlubGFEaS82dnBndXVFYUF0SHoySjY1MDVZTmdZ?=
 =?utf-8?B?WU1LVDBQSCtJTWxEekRvQXl3OUM3dnBKcDBST3FzemlvbmExdVJ2Y3U5QXVW?=
 =?utf-8?B?bnBoeFpqTFVQdjhRR2RXWU5Odlluc1FwSVlkV2RQdk5uNWtBalpwaWlTMHNs?=
 =?utf-8?B?OUxOVCs3dGdFOFYrVDUvTXcwZFVHczF5b0NPWHEvT056b3EwUUJzdG11TXo4?=
 =?utf-8?B?a3QyZHBqWnovTnpWR255OVl5MXd3WHgwZW4wWDlaRTJCUWFlS21zUDFuRGQy?=
 =?utf-8?B?b1NaVVlQTjNxT3c2RTMrTDNpS2RiOHVGWUNFbFFxMitTWUdxZGtFSjhVRmdi?=
 =?utf-8?B?N2dPc0pSYnc0OHRyT1IxdnhKSWN3TTk5NTROVlNPR3kzam5mN3QyM1BkOWMy?=
 =?utf-8?B?cUdRWXZjSmlqSksxdUl2ZS9YaXlhRUpMU1RUYUJWaHYrd201QlBYMHEvdG5r?=
 =?utf-8?B?OUo3QzYzVUd1K1d1TGhlU090VXdJRVRxeW0vVHNVZm5xUDhWemMyRlpuSlVR?=
 =?utf-8?B?QmFWQnhveEZodXRMbnRLWlRnQ09vbWVPQnhSUExuRlpFS2daQThNWmdoMi80?=
 =?utf-8?B?WjFna1B6amkwQUpCbkNjTkhCaVdORklvb25OV1EvOXlFOTBBcC96SmhkZDJo?=
 =?utf-8?B?a2tvL2hjMk9WT1cxZDdpeWRtOExoTkVKRGFMQ1JDd2VqMDMrTEEwTzNVN1lw?=
 =?utf-8?B?REo5UktYMnFuRzJYYXl4SjJIb2lBSWd3Q29CaUFxL0ZQVlRYdDRtMUxpK3lz?=
 =?utf-8?B?UFEvd3M3T2VvSXlXbUR1SmlMZ0ZsMWF1aEdqQ2puZlhuWkNLeEd1Yms5Wm5n?=
 =?utf-8?B?bUpkMHFxQ0Z5NnZ0bmF2M2NHZ0sxOWovbU9ZbDAyZkhFQy9MWkRCb1U5OGhx?=
 =?utf-8?B?N1ErcklVVkFibkZ2dVFzZmlISTJhR3VMSXduQ1FmYXMyeFMrUmV2elE5UUow?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768521c3-83a6-44f0-68ee-08db9a66fc24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 12:32:11.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7FYOrrK3Ae2RZMSbdKGoyAkiDm6zRVZJ91qKe+0myRtR/MQ62gIZ2HKyCME8oQAxZyiwmW97oHfsPBBxSTuYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7781

On 26.08.22 18:17, Philippe Gerum wrote:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Giulio Moro <giulio@bela.io> writes:
>>
>>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>>
>>> Here's a summary of what I get when running the test with some
>>> parameters (arguments are: "max iterations", "number of threads to
>>> create", "priority of the main thread", "flags (t means don't print
>>> anything). The error code reported alongside failures is the base 2
>>> representation of the return code. 100 means that errors were
>>> detected in evl_unlock_mutex() in the main thread following a
>>> successful call to evl_trylock_mutex(). During these tests, the
>>> output is piped to cat and then redirected to /dev/null.
>>>
>>> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
>>> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
>>> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
>>> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
>>> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
>>> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
>>> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
>>> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
>>> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
>>> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
>>> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
>>> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
>>> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
>>> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
>>> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s
>>>
>>> So, when running with 2 or more threads, the same error keeps surfacing very quickly.
>>>
>>
>> Confirmed. There is something wrong.
>>
> 
> Please retry with this patch in. There is clearly a race in the current
> implementation of the mutex release code, specifically the release path.
> 
> @Jan: If believe this gremlin may be in Cobalt too. The key issue is
> with the handle transitioning to NO_HANDLE before transfer_ownership()
> switches it to the handle of the first contender in line. If userland
> manages to slip in with a fast_acquire() during this tiny window, we may
> be toast, with two threads actually holding the same lock. The issue was
> made more obvious with EVL which does not serialize the trylock code
> around cmpxchg in kernel space, triggering the issue faster. I'll have a
> second look to Cobalt, but since you know the mutex code in depth there,
> four eyeballs would be better.
> 
> diff --git a/kernel/evl/mutex.c b/kernel/evl/mutex.c
> index e0cf1ba21d5b4..d96f8c9f04df7 100644
> --- a/kernel/evl/mutex.c
> +++ b/kernel/evl/mutex.c
> @@ -899,14 +899,16 @@ void __evl_unlock_mutex(struct evl_mutex *mutex)
>  	if (mutex->flags & EVL_MUTEX_CEILING)
>  		clear_boost_locked(mutex, curr, EVL_MUTEX_CEILING);
>  
> +	/*
> +	 * The whole logic is based on the invariant that the current
> +	 * thread does own the mutex being released.
> +	 * IOW: currh == atomic_read(lockp) & ~(EVL_MUTEX_FLCLAIM|EVL_MUTEX_FLCEIL).
> +	 */
>  	h = atomic_read(lockp);
> -	h = atomic_cmpxchg(lockp, h, EVL_NO_HANDLE);

This here was different from current Xenomai 3:

	currh = curr->handle;
	[...]
	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);

Under cobalt, we are using the thread handle as expectation value for
the fast lock. If FLCLAIM should have been set there, the cmpxchg will
fail, and the fast lock will NOT contain XN_NO_HANDLE until we switch
things in transfer_ownership(). IOW, I don't see how Xenomai 3 could be
affected in the same way by the issue that you fixed in EVL.

Am I missing something?

Jan

> -	if ((h & ~EVL_MUTEX_FLCEIL) != currh) {
> -		/* FLCLAIM set, mutex is contended. */
> +	if (h & EVL_MUTEX_FLCLAIM) { /* Is there a contender? */
>  		transfer_ownership(mutex, curr);
>  	} else {
> -		if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
> -			atomic_set(lockp, EVL_NO_HANDLE);
> +		atomic_set(lockp, EVL_NO_HANDLE);
>  		untrack_owner(mutex);
>  	}
>  

-- 
Siemens AG, Technology
Linux Expert Center

