Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD910E1
	for <xenomai@lists.linux.dev>; Thu, 10 Aug 2023 06:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/8Tqg3O7C+sqXwW8WTGWgv3sVpzQADAqBHE7M+2JbGziwxK5QJE9BcSrGAZpu10m6FBolDdPfDrSwHmaXfEysHOHPC4nVgIrUKgIPaWfGbZBLPT+BJzNAgfFN3r7EccgukEWeWq9b9cwY40KnY7IOLT7ur76nrtbj5k6R/5vHP8bsjDdvkqSeu2cHiOsrjRQgUcEU06BHw4/t65d++TMQeX7ERZyQsSRs60EZfd7t5VQpdaGl+y9Dj5H07V7oKoGWIR+nj61RqeyOPmPD5mHLJbhoULcbdO4JME0PBclui4IkJiQMVHK2adH9ryvvol9ZBDYl/q7iw/UgcHSkGRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc+YHPEwviv2AzwISbUedtmvuurW6Kz5iIVh8RUL8s8=;
 b=Ep/CuY+KKiTYKyNPblY3rghtN0sh+4Apc79FtYgS6ueJI2ByhDFYijfIEjEpANR/slGpXWwmeD1X4Wj3q2IaQqgw86BMy3Oz2XDjg8bkN2yXz90pbW5nJZo484RWtknByGA0BB+KV09A96mzYLZ3cvK8jyksI7XCRAEh0KrTlRR6jUyJF+ytdtH/hfAnfBWoCUo2DKZDItD4LwbWpdozOgy9FGnruGvRUBaLvKfCTGUm15SYUQ4Psz/ZVneIzfBQ2XjphGq/X2ITNrEyKSRo9fZHrfNH7VYFx9yxZNochyYMxc73mcNy2R/gGFOrthg+VrOLOWRM12cMurw6pWR1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc+YHPEwviv2AzwISbUedtmvuurW6Kz5iIVh8RUL8s8=;
 b=t1ge+2HPSbqlYl4neiohpNrElJFAe7FWUxDtS7axFbXUGLN9M8zqjTc2MmEW4r8i0eZJ9xEzS740fKxDmn43CWcnWVUsPhfyQ6zUlcvpvHcs2CaP+mnCJGY5O4O3B/yY1j6ZMZH/mouHP1SCuaq0JxRG0FuTS/053opHytoTf+H6EqGmd/TjbAhiYhMr1AKeTNiVqrZA9uamWnmT0b5PpUBO/uY5NUX4d60dRETPvaGV33xSxe1iRiM//VlD1kstPCBsLXecz/Jk6a+nY+2oSauz0D1Nfi637tlbGzpFhnS/qagQW6MgxFhzNtzH9OY1mtXY4Pnrp6C7QLNxHxcnkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6770.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 06:00:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:00:55 +0000
Message-ID: <a2b3c058-6166-41fb-9e34-6f414faf814d@siemens.com>
Date: Thu, 10 Aug 2023 08:00:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Issues with evl_mutex_trylock()
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, sang yo <stlfatboy@hotmail.com>
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org> <87h71zncwl.fsf@xenomai.org>
 <87h71xblu1.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87h71xblu1.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: b4770a24-ae2c-42cc-aeb5-08db996728dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aUnU97VLSGOGhiLnz7d5UO6b8/4xdqkpO9zMTIm5Lkl7x02mTnOAN6T/HobzWJxNSnqzkINoihbg4DCz1uHRu3CZ3S3M95NZ5zVPv3OCm9dnIdGyo5C7Lk261NUJSBOV1r0QNuCZVcAybKSnMuqK7qPNKWSXvK57WFgvx/5DjQL0sE3zx18puqpWgsv424grDfG6Ge4AyPd+nAMBk1/pVm9GC4AguvY3I0SIkBR0niNOscwmRWZoe8SEsaHliBOorS7owj06SAp05Nb8AE6CCzhVkJS94msUFeCcXXF+XZ+1/gacCQQ4UfpnVukaT21LtVdoMbgOrSfDXDOjcCvQPT+otUcfgqzKZrCUFc9SvYx+215GlWMpq7B4ISbpsOHePr9RjvyOMI5Xxivwh5/DWypzGMFCyweOibcmF5SvHaNKAiY53u2BO+d25eLoQChj7vvQG4CF4815FozJwA4kh6ohhQN5tcGqFI4hB0ssDpjYDZqniPdCaw8AtsAL5pwuzzm7nuX3H7bAAY3dGkZTVbeJvvN2qItoTuD4lBR7nGBr06ix11hVL21R4GaVqt/JLJxhxu3DbBZH8g6g6SAhm4Qgxdk7sZwKZqjyMn291J8UQGVnzxQY3OhVFKT9WTAkGmZkQFs/7fjAMFaJ7N59Ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(1800799006)(186006)(2616005)(478600001)(86362001)(44832011)(31696002)(83380400001)(7116003)(6512007)(6666004)(36756003)(2906002)(6486002)(26005)(53546011)(6506007)(38100700002)(41300700001)(316002)(82960400001)(66946007)(6916009)(66556008)(66476007)(4326008)(31686004)(5660300002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hkWG1tZ2xTN0k2ck9uVm11aXE1RXRhWGNyL2lCVzJyenBLdUJ5VkNDTjJ2?=
 =?utf-8?B?aHBZbUlQemdSa1BrbURhQkI5SVZIUnpHWUxFczE1aWZ4M1JJVEo2QlpjeTRP?=
 =?utf-8?B?TlpoYXA1enJMa253NmplZ09QR3A1b1dDaURRR2hnaUtJV0FZSHEyVENZaHBo?=
 =?utf-8?B?N1RBYmNGYThOZWlyVjBITVk2Qk1pek9HeXZJMVQ4SWdQMFNCdnRLdWUyb1dV?=
 =?utf-8?B?cm5SSmpsUTlSQjFTM1BUSG90eTRWNUNZaXpYbXR6WU40NGNNK2E3Ymw2V1hx?=
 =?utf-8?B?L0ZMRFpWd3A1bEtMM0ptV1M2S3IzQ3E2bHBEUWI2VTZkU3oxQzl6c1lYL1E4?=
 =?utf-8?B?RzR3Zy8xWXJuNGliaWRLSVVrWUZrMHRTQ0ptWHNja1pCY1N4dXlHMkVKQzVD?=
 =?utf-8?B?THgyNkFHdHYyeWhXaHNRN2lrSlBXVWRxVGVnbm9PQ3RDSjZiVmJuQmhtUjVy?=
 =?utf-8?B?cFoxSzZTNDF0bjQ1bm1xZmx2UHJJMklxSHJsd0hQUHc1M1hveHIzM3dHUUxt?=
 =?utf-8?B?d0t0UC9WbVlzUzh3bnF6bGppVFhPRmgvMlJHUXZRSkpWNGhkUTk0akhaKzls?=
 =?utf-8?B?d3I4RFlJazU5eWYzeE9SRVhFSzh3bUJ6NTBvVzJVVHAzb0t0WGRBMVBqNU1I?=
 =?utf-8?B?UmlaWGNyMG5oZjBzbU9RMTU0SXc1Z0J3Tm1paEEra1J1eGU5eUh4WmkzVlRq?=
 =?utf-8?B?VnpxSWVSb1dQbnJveFc3R1pCYWhpWU1xeU53SWtyaFVmNStkdjl3UXBjUXZz?=
 =?utf-8?B?a3lud1hCN3lmOFlVc0hyM2tZQlBxT2wxZWRUejBzd3N6UDJsbTBaTXVHdUJh?=
 =?utf-8?B?QXNiYmw0TnlhSk4wZzVGaGNWSEtEZHl4MGJ4UTgzanExeXVuTWZPemRVbjMv?=
 =?utf-8?B?ZzQvalROVTJSZ0RDSGRHSVZQb1ozeVAwM3VDeS9uMXhmVkxBdWNxbC9pOWxD?=
 =?utf-8?B?WU5Lb243NktMMFhvL0s0bHFEd3dxSXdvc3p2cEo5bktTZ3JLOHlHNkNXRXJR?=
 =?utf-8?B?NjdEdXlCYzFOTlRCelEvSC85TUE0OXdXSTVEQ09iczBoMGs2S01CSE15UStM?=
 =?utf-8?B?Tk9JbytDbzVwYlVNZVFpUWZ4NnprY21xalVnWmZZSmpISEJrMUEwN2JJWmNY?=
 =?utf-8?B?VkxxdTBVdnlnbW1pK21uUWJwVFE5M3VHbWx2QzRqUFdzSU13Zk5Oc3VsVFc5?=
 =?utf-8?B?WEZLNXA4aC9MY056MDZoeEJxRnlRdlJVVThCMlZ3QmQ0TVAraVY0angrenJW?=
 =?utf-8?B?L3hDcHZhQlV5VnAxUGRaM0d0aXE4clNYY2l6a2N1cFhSaXYyd1g5MDdHb2FG?=
 =?utf-8?B?Qkk4cnI3R3ZRYWJkMHZsckRpOWpKT09KYmRKTWJHWXFRMHhHb0dnOUdjZFVz?=
 =?utf-8?B?MHlTcEZRb3hRaUZZeHFFdjRWQnd2TDNqbFRHMVVlY1I4N1d0Z0RwamxUejhj?=
 =?utf-8?B?VXFYU3lpU3NlcTgxdU5Ha1E4Qlczb1BNR0xyWndrQ3RaSWw5MFIrWGZSVFlr?=
 =?utf-8?B?UnRZS2Yyay85eUs0dUQ2Uy9rc20xSHhiNEovM05wMFRSMjBIVlJKTGx5NU8w?=
 =?utf-8?B?MXRsblQ4QTI3ZXVkaEo1ckxpaTBmbUVXRUxtQlZEQ3c1TmRsYVVkRk1ZVG5B?=
 =?utf-8?B?QjJhTjJiRVJwOVZvUnNIRDZHSTBtUCswZkU4TXJKd2huVTE3ZFVPUFB0SThO?=
 =?utf-8?B?QnBrb3pZRmt1b1dHUVNjSnpFYjlXaS95V3VaWndsaWRha3BTaU9vQnVkZGRs?=
 =?utf-8?B?U2VoUTBGU0FiZlRYVFppM3ZMeFlmRUJmdlFQTlNML2REMVZYdy9DUTMvcmY3?=
 =?utf-8?B?TWxnRGtobG0vQktBbW1hSmFud3BMWUNJR1ZVaDNZR29jMCsrYWEyOWZxSzhp?=
 =?utf-8?B?UUhvRWJQaFIzN2tvTis0VFV4aTc2SWhDdmdSdXJkanNTb3ZTL1VsdzhDazBR?=
 =?utf-8?B?U3A2RWgydkJDNEZkK0srdDRBb1dpUlJBa2pxUGgrQTh6K3dsTERZRklodTJJ?=
 =?utf-8?B?TTJBK1JNYnhXN2FWL0MrUVR4dG9Yb3FleURnc2ZMOHpZKysxeXNCU2hPb1ZP?=
 =?utf-8?B?NmVtYW9EdWJaTkRwcGIrZzVrTFNZazZObEhDRlJUZDE0MGs0V3ppMklRTXZQ?=
 =?utf-8?B?U1FqUkdscFVuYTZKK2pMaEZrOERkdk1pK3ltZVh4NHA4dzI0VUp2b0tCWHZN?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4770a24-ae2c-42cc-aeb5-08db996728dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 06:00:55.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwQyGwQjw8IQqtStSiVv4GWCanT/FF2CJTqS0w44CJMCSmWN+QgMT8BPKRnF9oiqE7MgIJ5bDt1r5vbZIPWNsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6770

On 27.08.22 19:53, Philippe Gerum wrote:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> Giulio Moro <giulio@bela.io> writes:
>>>
>>>> In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.
>>>>
>>>> Here's a summary of what I get when running the test with some
>>>> parameters (arguments are: "max iterations", "number of threads to
>>>> create", "priority of the main thread", "flags (t means don't print
>>>> anything). The error code reported alongside failures is the base 2
>>>> representation of the return code. 100 means that errors were
>>>> detected in evl_unlock_mutex() in the main thread following a
>>>> successful call to evl_trylock_mutex(). During these tests, the
>>>> output is piped to cat and then redirected to /dev/null.
>>>>
>>>> mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
>>>> mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
>>>> mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
>>>> mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
>>>> mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
>>>> mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
>>>> mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
>>>> mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
>>>> mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
>>>> mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
>>>> mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
>>>> mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
>>>> mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
>>>> mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
>>>> mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s
>>>>
>>>> So, when running with 2 or more threads, the same error keeps surfacing very quickly.
>>>>
>>>
>>> Confirmed. There is something wrong.
>>>
>>
>> Please retry with this patch in. There is clearly a race in the current
>> implementation of the mutex release code, specifically the release path.
>>
>> @Jan: If believe this gremlin may be in Cobalt too. The key issue is
>> with the handle transitioning to NO_HANDLE before transfer_ownership()
>> switches it to the handle of the first contender in line. If userland
>> manages to slip in with a fast_acquire() during this tiny window, we may
>> be toast, with two threads actually holding the same lock. The issue was
>> made more obvious with EVL which does not serialize the trylock code
>> around cmpxchg in kernel space, triggering the issue faster. I'll have a
>> second look to Cobalt, but since you know the mutex code in depth there,
>> four eyeballs would be better.
>>
> 
> I believe that the problem just fixed in the EVL core also affects
> Cobalt. This is a suggested patch for fixing the same issue in the
> latter on top of 3.2.2. Smokey's posix_mutex test still happy with it.
> 
> NOTE: the issue at hand is two threads being granted the _same_ lock
> concurrently, so this might be potentially catastrophic.
> 
> ---
> 
> commit 4417674f427a78ba7fe2c8e5b2607d5ca6886ec0 (HEAD -> master)
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Sat Aug 27 19:44:30 2022 +0200
> 
>     cobalt/sync: fix race in release path
>     
>     The mutex owner handle transitions to XN_NO_HANDLE before
>     transfer_ownership() may switch it to the handle of the first
>     contender in line. If a user context manage to slip in with a
>     succcessful cmpxchg() in this tiny window, two threads may actually
>     end up holding the same lock.
>     
>     To address this bug, set the handle directly to its final value as a
>     result of transferring ownership, without transitioning via
>     XN_NO_HANDLE, closing the race window.
>     
>     At this chance, stop duplicating the logic which transfer_ownership()
>     already provides.  We may unconditionally rely on this routine for
>     either passing the lock to the next waiter in line, or marking the
>     lock as free, updating the fast handle accordingly in both cases.
>     
>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> 
> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
> index 6e50e537f..c5398dba3 100644
> --- a/kernel/cobalt/synch.c
> +++ b/kernel/cobalt/synch.c
> @@ -850,6 +850,17 @@ static bool transfer_ownership(struct xnsynch *synch,
>  	xnhandle_t nextownerh;
>  	atomic_t *lockp;
>  
> +	/*
> +	 * FLCEIL may only be raised by the owner, or when the owner
> +	 * is blocked waiting for the synch (ownership transfer). In
> +	 * addition, only the current owner of a synch may release it,
> +	 * therefore we can't race while testing FLCEIL locklessly.
> +	 * All updates to FLCLAIM are covered by the superlock.
> +	 *
> +	 * Therefore, clearing the fastlock racelessly in this routine
> +	 * without leaking FLCEIL/FLCLAIM updates can be achieved by
> +	 * holding the superlock.
> +	 */
>  	lockp = xnsynch_fastlock(synch);
>  
>  	/*
> @@ -862,6 +873,8 @@ static bool transfer_ownership(struct xnsynch *synch,
>  		return false;
>  	}
>  
> +	XENO_WARN_ON(COBALT, !xnsynch_fast_is_claimed(atomic_read(lockp)));
> +
>  	nextowner = list_first_entry(&synch->pendq, struct xnthread, plink);
>  	list_del(&nextowner->plink);
>  	nextowner->wchan = NULL;
> @@ -916,8 +929,6 @@ static bool transfer_ownership(struct xnsynch *synch,
>  bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>  {
>  	bool need_resched = false;
> -	xnhandle_t currh, h;
> -	atomic_t *lockp;
>  	spl_t s;
>  
>  	XENO_BUG_ON(COBALT, (synch->status & XNSYNCH_OWNER) == 0);
> @@ -927,19 +938,6 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>  	if (xnthread_put_resource(curr))
>  		return false;
>  
> -	lockp = xnsynch_fastlock(synch);
> -	currh = curr->handle;
> -	/*
> -	 * FLCEIL may only be raised by the owner, or when the owner
> -	 * is blocked waiting for the synch (ownership transfer). In
> -	 * addition, only the current owner of a synch may release it,
> -	 * therefore we can't race while testing FLCEIL locklessly.
> -	 * All updates to FLCLAIM are covered by the superlock.
> -	 *
> -	 * Therefore, clearing the fastlock racelessly in this routine
> -	 * without leaking FLCEIL/FLCLAIM updates can be achieved by
> -	 * holding the superlock.
> -	 */
>  	xnlock_get_irqsave(&nklock, s);
>  
>  	if (synch->status & XNSYNCH_CEILING) {
> @@ -947,12 +945,7 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
>  		need_resched = true;
>  	}
>  
> -	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
> -	if ((h & ~XNSYNCH_FLCEIL) != currh)
> -		/* FLCLAIM set, synch is contended. */
> -		need_resched = transfer_ownership(synch, curr);
> -	else if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
> -		atomic_set(lockp, XN_NO_HANDLE);
> +	need_resched |= transfer_ownership(synch, curr);
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  

This apparently fell through the cracks on my side, not being submitted
as top-level patch, thanks for pointing out, Sang Yo.

Philippe, this is still valid? How can we check if we need it and it
does the think it is supposed to do? Sang Yo, did you see the issue, or
what raised your attention?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

