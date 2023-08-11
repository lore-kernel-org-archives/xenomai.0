Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C2A46
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 11:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCO+FBzK/b2A8NCjKBupyH541egGwovtnMKseoU46KTALVNbWYw4tZ79yvhM+Usf3pmgqck0H/UbhOKJbAO3U9G2G2ld18K5oGyyyvxTtV6iQlavqk9x7D7nVYJoSVsLzEEn32aFib9opfQ1/ESj1eNK+99/ZbdnA1K/hfEsNLzQAUYwjuUjsyF6BdpGnahJTf1M+ho0VDF+BniA5qWigLUiBrsr3ZYIsY5uK4z6IBN8gNWV7TM9NaoRPk6EYz/o+izr7DOMqibf2DKoFEf8uyX+J7BtdgMmaaK71aRzq4FwtHS7ghJEkYpPDlw/7McdzzCPw7qad0Y1J6dGjA3kNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joeEPUsFFI6ycBdarBTHKsjRUgtGs1rjzIOUB4R5xEE=;
 b=DQHMGkxxVWEyfUMcPPLqJ2biIk0SrsbjnjcXAFbPze+aktfeDuptl9w0OO43jO3vSugefEuzbXgeLvIi8uu4BuNUR4dNwUQZQhEY9NguFySHd8j96VWLX9Op2iOf2Ojdt6jg1Ih8/brqRG4nsGcdIs2q2tf57z/jN8eiKWpWzIhxPD6e1um9uS7Ln/5Rd+z0n8lwTV4febqGf0C6uide79sinvy0AAuJA9wBcrl8RA4wlrMjcnAeNBxBfw+h7G3hDJyWhthPaxmjMOS2lOo56gCq21c9MzOpa+QcPNrdunD02HkP7jM00Le3kvWhBvjECN8XY65yVyuybUwjb4i04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joeEPUsFFI6ycBdarBTHKsjRUgtGs1rjzIOUB4R5xEE=;
 b=A/XgfPRp6UDyTYmXTsQ7wFYlLiz3VWWYeEL4oHnZgve6b/ANnlXxGabT/c8+BXGrjzfNk5BSUHvtkP+GHlw5aKAyHgbNPmkwUDNog7XudMGt4DSHrJDMQEVWtkfPhzSe5HouFJ6ae2QGHsY657ejEkXmBMQdiqCpFPe6x+5HsnYrOL42L1bpD011tHqlLVYw7WBRPnPhk5K+n37Dx5XiCNz1Pxx2E9Z8buibQt4QS462soqU3OT0DMx4xWbGdqe78Tcz/0vsjKGHgYjb2itfThjg9HHIEN9XUewskv7BsgisXQQYYAJ0N6i0dEtSMei8lNz6nz2UAByktLOG5Mnv2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6994.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 11:31:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 11:31:17 +0000
Message-ID: <54fa33d1-40dd-4295-8858-32071fd7efe4@siemens.com>
Date: Fri, 11 Aug 2023 13:31:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Issues with evl_mutex_trylock()
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
 <87pmgnnkyb.fsf@xenomai.org> <87h71zncwl.fsf@xenomai.org>
 <87h71xblu1.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87h71xblu1.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: bd683780-ac0d-4529-ba5d-08db9a5e7a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xZw72N2WI4dgxTtwjuiv7AC844YpgvD/vq5gUZtdsmReAjUgZz9qk34kcOfLm+poG8Fseb9aa21uU9btpVL8cfsBD/RegrljGRtvH9xoNOorwwP3WwfZxj1MLDHcv+8pjp9kTejvJli8dAVjxBuhpeFJ0iqxP4vPnmm9lZF4By0GGhFF9h47PjdG60GO2ZcvA2wnFfF/X806hKTJRHPR22bLR02v1dHEGtr51yDD5Yqg97VAw3yfkY+corscNYj+zade3UpbF7aiXTEYrc685aasp8I1wCwS+Jpb+BmbFCwlZoQ2asvpUAxUSmW9fnlxdXMvsAn3EJPOKONkIxSwp3h8EwFMS2zhBpZrSXE2BMySuPim3GC8eFU5DE7eLXvn8YCfowb1CZVtXkPL04kiW313mivR9Vrm3adw61UKhxBy2WRIjnPJQK9h/3tVAF2FUV6v1GC+XYhB8JY7ufcUwcTx96E5ioYnE6Ej4cTLWgf4jHhvmyJftRMZPhEPNtFHv5pgrON37s0Fstk+Z26JciSapK9KoJy/F8w/IvMM3yjA5zwt9aY9LzPXqUvFJ0o99p1Jbqhh6tU5hYvKRL6EhXmCgBfv21dkSbZqRNtPqiDoiO+NgEKcFjxJsx/N2A6XSko6OT2nSsnJQFmkliTxTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(1800799006)(451199021)(186006)(31686004)(66476007)(53546011)(6486002)(6916009)(6506007)(26005)(66556008)(478600001)(66946007)(36756003)(31696002)(83380400001)(2616005)(41300700001)(2906002)(316002)(44832011)(4326008)(6512007)(82960400001)(86362001)(7116003)(8936002)(5660300002)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG1RQ1JISjJkcnhNY3hYSUZBc3Nyc2trOGZGbkdFZmlIRmlmVUEyUSticGJx?=
 =?utf-8?B?ODRyRDZhM05PQllSTjd1eHlRU0x0bmpIaEZ3ODU5NmJ3eU9INFZwdmFoRmdN?=
 =?utf-8?B?elRSaFVsbVhoYlpMSjk4c2wzVTJRZGZzYjRFdXAxME8xdDI1dHZQcEVLOFhK?=
 =?utf-8?B?ZzFBWWl1emxzMTRKcWNWU2t2OUpSK1dTQVI2VFdCQSt3dVZ2SU1uaE1MYy8x?=
 =?utf-8?B?T0FyL1Y0SkQ0ZDV1RDZPS0lsMmxtQTkwaGExL1VJRGhsNXBUZ1pLSmlUMlRF?=
 =?utf-8?B?UnNQUjd1THJ2d0VtRzN6RXpySWdQQXNsamRRZ1EzM2hPd2JrVnR1eTRpL3lW?=
 =?utf-8?B?dm4vRExPRm93RkxuYmRobldMK3V2Q1pNcWcySjUvVjNwV0VMVXplQm1uV3l5?=
 =?utf-8?B?M3JsUlJ2V01RRFMrTWw3b1lhenZ1aGgrUmNwL3REYWdlV3FGbzJMSlhpZU1a?=
 =?utf-8?B?MkFpdi9jTnJXaEY1R2dzUXdNQVZ0SllXb3BJS0pYeUZOU09aY0NBdU5PV1Nv?=
 =?utf-8?B?R2VDa3R6dTQxZzdGbndYYnBxSUpsSFlWeWY4TllwNEdFT2V0cE5kVUF5YmRN?=
 =?utf-8?B?NTdsQ3BPaTdJRmc2TWtGVll4UW5sbGlVblN5L3E4N0FhenFQa2p3ZkNNOEFp?=
 =?utf-8?B?RW1UeUhDZFRISjVXZHlaelRzQ0pPSE94emxiK0F0eE5FRXFqdGFvYXdvd3VC?=
 =?utf-8?B?QmVsN2x1cktCMkpqTG9qekprVGdUZk9Oa204bWhDM283ajd5WlROWWQrMUl6?=
 =?utf-8?B?ZUlqdHRCMnppVDFMVEtNQ1lBYUlyN2xFSmVrMXk3S2ZvdHpzdTJJb1A0c2Uy?=
 =?utf-8?B?cHdoUnRMZzk2UDNjRkM1dkJLRlV3M1ppYnF3MGFMdGZyQzl6K1VyYlVyNURX?=
 =?utf-8?B?c1VvUDNJR3d3RkswMHpUMHZ4U09GenlEUnFVUEUzN0EyNWx4NnRvQUxISHNh?=
 =?utf-8?B?TFpFNnplRUNKU0JmSkpET1VwckVsb1hETzhFeTVTTGNVTVFDQVVpczMzMnFT?=
 =?utf-8?B?djlJanlUNnZXU0oyQkUwelhUNDVBTXNueVE3Z1lYZVkxb1E2ckp3MWNLYkdi?=
 =?utf-8?B?dDEwUThoZ3o0V1RDUVc2TkFETUc0blkwSHB2VFpEK1BrOHYrQnM0SjFlcmpG?=
 =?utf-8?B?WXJMTHdNQzRiZGdyTEwvdjJyTC9VZEViYXo1MTN6WEMzYXk1ZDU1VVU0VGh0?=
 =?utf-8?B?ZE1vQjV4d3dzSW1qSUw3c3ZxWmo3enh2VGRmbVdBU3ZrTVFOOXEzUDFNUlJp?=
 =?utf-8?B?MUNWLytWK0pWQ2RhbmV3dmE5SUduUE15M3lZTHlhQmxpQzFzU29PN1B6M1A3?=
 =?utf-8?B?TDlQeE9pWmNUaHRVUVZXc3VBM21VQkhxM2k5K1N6Ynd3Ujl0S1FBTW5sZzhk?=
 =?utf-8?B?KzNJbGdSakphN29FTzVQUVVOemJQSzY2dllQYXZIMFNibTBnbTA1UnRhUDFt?=
 =?utf-8?B?Y09tNjRWNEkxcEhzQU1UeTVvMXUwNlRRNlRrcE91TUIzZmZEUmxXTHBvTWFP?=
 =?utf-8?B?Skw0YitmZzh2RmZDZUg0SWhYbi9JeVJEcXU4LzRvcFRsNFVjckdiYk9OUC9W?=
 =?utf-8?B?SU1vMnJpNVYyT3JobzZWK0VUa01aTDl0S0VjVDBaTno0aXU0VFcreVNOMGpL?=
 =?utf-8?B?WEhMOG1GV3pIQnVQZDZLeUZ5bjBnNHNwTmR4VGpvTWxJenM0RWJVekp1d28x?=
 =?utf-8?B?Vys4a2Y2c2Y0WFZ0VVloTHFtb0FxOUwwNlZhaEY3ckN5UjBiUTBzRFcxVmtU?=
 =?utf-8?B?YU1KME9obGNMbDAweTg1T2NXMlVMVUVBVjMvQXcrUlplYzdWZmpGdk95dEJQ?=
 =?utf-8?B?UE91UEZHVmNVNmVjSlQvNXNrU0lyQjNjR2RJSUpWQXlhK283VTFIeGx5S1BC?=
 =?utf-8?B?KzRDYTNaRktMaFM2T2h2NGhsNVZmQlVQbi9JOUtrMGxPZk9iaFFSeDVVanAx?=
 =?utf-8?B?Q2dlT3hyeE9HUi9rTUp4REdZWWRlanVKVUdQeUJJSThvYW10UCs5SkZNR2lQ?=
 =?utf-8?B?c2R5Mll1NmdLV1pldEFmMzhDSlJ3M2ZOS09oMlcraFFpRlFQbDdxS2ZhNU40?=
 =?utf-8?B?VVdQeGwzSllmY0k3SW9OMksxWWl2aGJZalZCb3dWTWszd1d0U2w5TVZRNFZY?=
 =?utf-8?Q?FUTvKa9gzwGuiGAZyNxZ9RfX/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd683780-ac0d-4529-ba5d-08db9a5e7a18
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 11:31:17.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIxCITyNlziyIapDuNXE/0lBuxAjZ07fobD2R4KJm0mCxMRXBSgLt+lafbrygAMvkwrVCTShV6N6RHCJ4Ytddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6994

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

I've tried widening the race window by injecting some udelay after this
line, but still no luck in seeing the issue with Giulio's test case
under Xenomai 3. Am I on the right track with this at all?

Jan

> -	if ((h & ~XNSYNCH_FLCEIL) != currh)
> -		/* FLCLAIM set, synch is contended. */
> -		need_resched = transfer_ownership(synch, curr);
> -	else if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
> -		atomic_set(lockp, XN_NO_HANDLE);
> +	need_resched |= transfer_ownership(synch, curr);
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  

-- 
Siemens AG, Technology
Linux Expert Center

