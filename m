Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150A2F21
	for <xenomai@lists.linux.dev>; Mon,  9 Jan 2023 13:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwzKbOV6OhdMwvtKRODWSieBTYRuSjPQ5hr4KTztyqkAvGV6amPLe9MaExYFb3qQz0nQAz6+XaKqlRZmEeDPNGCF6a/c5zPmVvyRpJyXyyod0OrDqqMTwEKPbkYPrdnsCbW4n+SXheZ7fb8Qls86G2CC03Y0PLbX1aMeYT4gDrZ97vVisC1bQRaQVQKU+wEE2zP92ZIB91pmEqT9xPMDu16Z0imCREhlX9C/xXbySww7WN/WVJ7GKVmguDWR0zzUKY0GKB2rJu5wDSBbDlb4wJGuxCDIsIf/p49t3Snpjskzys2ntGG31SQVxKuXs/33kJDmshshQ/qvCmzSPdNzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIJT7FdFveTqqvrimF2baQMiqP3K3Mhxs0D3Dw+uHfg=;
 b=eyVM0xbHNNtcqyUGxmjJFrBLqQtk0nSWIEfXdWrneUcO5/pRMkqIQrcbfHX7btQi75DrmG/RKpyWe4Q4sMHOa8went3cs9z8ovwYvrbdksFS8BAc2mf58TOjIEgtBbLPHZsFZ/9ERPrIvnLmIN5CbRoHposvmG+bpSS4QaBdgmHBq1OruI/tlHeYE4y9eq3cz3A4B/4gdqQGmn0mpLMgwcgDv8zimbwZasIi+MKlobDgSIi3WjsqikUjDQYQPDjjhZjLmmn3PDy2J0wP8ZsT7uKhBjEC+Qu1f10aj3j1XfdiTLhAZ4ivMUoTF65oLt2MpZC/9KxKZjszoH12cvpJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIJT7FdFveTqqvrimF2baQMiqP3K3Mhxs0D3Dw+uHfg=;
 b=tYQoJ5POoUDQ2GTn/B653uF94hwBV/z/agCIiNMT750YqiS4a+gqBS34gXy7I/6uT7XxbPcVNb1zdT2HlKbMUU+E2k6A7xifG+ipEFG+CcWYgFNDbrhxi2vOsF8wvw+DWkpnY8lu9bXWwb8dxQ1v2PzAxLAprumPGA20iecTVQVZhzWnvcTZmrsClCSk1sLx4ZE2yMWu9nD2TWTnlEbAAHJRS7Hwhe4VpN6zqys3tixCK+0dTPFnAQzIp8bC4ImmfXIkPumQOPZm7ocw8aiysPRs3jk/DwTw/miFg9ODzrpE8Mc4+PnsJZ4zCn5nTsAkCKxeuHycDhUFyWF+xO+NyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:00:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 13:00:39 +0000
Message-ID: <adcd0951-2bef-64b3-62ff-de30641538fb@siemens.com>
Date: Mon, 9 Jan 2023 14:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: "failed to allocate main tcb" error
Content-Language: en-US
To: "Mauro S." <mau.salvi@tin.it>, xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
 <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
 <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
 <fa74110f-f02a-3ef3-4690-bd6690700ee6@web.de>
 <d33591ec-f2be-3898-b87e-904d7da77bf1@tin.it>
 <7c281c36-f7d9-71f1-2346-cb00ac5334d7@web.de>
 <7f782cbd-7353-7573-7768-e61a2c885c88@tin.it>
 <30fdc0c6-d807-c062-2e98-c63f3a9d55b7@web.de>
 <641ab944-2cda-0f4b-00bd-73bd553495bb@tin.it>
 <ab51d02f-3403-7057-4403-f704ae278e74@web.de>
 <b8a7ea5c-1412-1bc6-8684-e8d2eacb2274@tin.it>
 <1c345c13-bd40-b8b2-31c0-0fd87ab95162@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1c345c13-bd40-b8b2-31c0-0fd87ab95162@tin.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 1773654d-b472-406c-be5c-08daf24181a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pcH3H/ffsCEl4+D0poTq03rCD+oxgLampaoflroz5+/cfJqYVtuWWWLAoGRgL5/wmBHgTSv1Drlc7zH7n5tHzySn5D9dMZdSwdGzuGfibSwrP8gJsTsMPaKRuAzzU2VKniAduWWTpLSrwIMtr9TAE9B1Tsy3PfskszlxJp8sLrqhROxr+42si1IDdnVyMrPZDcvhHPXDk59IuCQu80EYpCCC09S+a+8I5tQ2H+Yzu7C0wTMi+0ykq0gCCSSufI2YHyTIy+bmKprlTCDhx71cWaXZHnyCA89CtMw1EbSlUTrdSfJCDaaBcBMrfcBbusB0vRi4EdpOIQXacCJQFDZQ4SzVzGVeN3drFvH1zvjoDFN5RvulXKoAOXRW53F3kQIlQt3o5vq/ttjIawhqCq7Nm3QSNdv8gg00I4gGIeYoA92jviGI7J5DSjgkTuiDuMIIG8fBp1wsnDi0Urowtu2nPD3LC5u3udd2I5Fr++04HWAegt6TispAHJIdzN44N3vB0jYbCaoud9cTvwgcqZAGvaV2QW51VD2i1M94SyUy3vs4zn+LHprpwS1SGy/oWBsxMEsneJ2JcIBzC84r/QAd1Vdy79EXCoV3Tc2+BLQU7eae5Hqtv0of4MQ8wNKGpRgAZ30ojOXudKwtlCODip6cJJyEgsGJ4CQ2LqhJ/jKDwyR5GLOo9ssniuyBREDY3hegkpulHwOG3BhRuyMJBC7wnwhmme6UF/KnRS0zzHEhT6nriZYXYw3uBRTgyW5CIAY7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(38100700002)(82960400001)(31696002)(66476007)(66556008)(66946007)(8676002)(86362001)(41300700001)(316002)(44832011)(5660300002)(2906002)(8936002)(2616005)(83380400001)(6512007)(6486002)(966005)(186003)(26005)(478600001)(6666004)(53546011)(6506007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFhCVVAxeXBmamt2VklNZnJTK3FFcjF0cG9VSTUwR3E0aVkwbjljMUo4S2Qy?=
 =?utf-8?B?QlZ1cE5hSzF1akJpVFd6WmVRKzJidThGM0hVb3NCTnRneUtPNiszNU8vZ3Yw?=
 =?utf-8?B?dm9leUJwTExCNGs3Nk9DbVBlQ0VBa24zQUJaUk9Xa3dqdTliL015RFNVbFBy?=
 =?utf-8?B?UnM1RWllYnNncWFRV0M4Vm9Tb1hNVEM1RkRCNi9IQUtUTmVuRWRZSVZWcUdP?=
 =?utf-8?B?MDBielNxZ2FJZzRpckp4cVBrUFFOcVdidjVqR1gwT0N1S0R3N0JmeVd5ZThL?=
 =?utf-8?B?OGVaM0lGSGZFYkZQdVBXZnRpTDd5bTRKU0c2OGNCNFd4cS90aGVDQmxJeG5j?=
 =?utf-8?B?RXRDaXFGNEJBMWUvZ3FPZnhwaWE3a0RaNGxITHFEUVhkRnd6NW5SOWRuS2lK?=
 =?utf-8?B?RmRieHg4WTRqaU9pV0ErSnd6TmQ4eG5KZ2hPb3kvRy9VMERKS1NYSzdabEpK?=
 =?utf-8?B?SS8vQ2tSYWZHeHhyTGI1bXExUkRFWkFDZUdrQmRZZ1A0MDNneFcxTzR0Y3Zi?=
 =?utf-8?B?ZzdiU2JSUkhKTGdGUG9WUkVSL2JkZ1EzbEFMK3FiMFhIMXcyTG5DRC9ETFVH?=
 =?utf-8?B?Y0RXTGNTVW92MnlQbDFvWnJ0QnVIT3ZNV01oVDNadHI0U2FMdy9UUUI1aW5Z?=
 =?utf-8?B?UTVkYmlVcmtrbG83VEVEa3VvTWRtN3paWkxYQ2IvRGNnNnNocmJ1TWg0Z0tl?=
 =?utf-8?B?RlJFVFlsV1RFTVpLaUdUOWtSUWVUcDE2UHdIU0dvaTZiZEw5Ukg4Q1oyb0VR?=
 =?utf-8?B?UUZvZkpPaDBZSk9oV0VPZ2t4azZuWnZjM2VBSWlnK21LSHptdFJ5QzRmZ1Nz?=
 =?utf-8?B?VW1aVklyLzRsWGRhY3UySzJvd2JyZWUyenpsVEM3VW9GUW9HbmF1TE0wbXZC?=
 =?utf-8?B?ZjBXcDhqTXN0RjVCZ3Y1SmxKTEN0WTRwaUYrK0pTOW5tMEY0M1ZSSVVLSnpO?=
 =?utf-8?B?OGpDbGoyLzVQc3Q4VWF5alhQQUhTVTlIZDZLcWl2YytwUTlQWHNFNWxJUE91?=
 =?utf-8?B?OVhLQlJ6LzFNQTFKZ21jSUIwSVIzUkJqcHFYS2tHVjhGTnhUeWEvaXNJanRR?=
 =?utf-8?B?dGJIWWlpc1oxK2NTeUQrQytVNzhzaEwwcXNWVnYxQzRKNnVtQkwxQUZJcWJ2?=
 =?utf-8?B?OE8xTUJ2Nm83SnNvY0Z6YTcxeFpJRUpRVjFuQ3M0QnV3cUJpMnVsY0l2Zms0?=
 =?utf-8?B?djBiNGRwVjJQbXN3Kys4M0hybDFham9kYmVMZHlaaHRhUWhoblE1YkJHeHlC?=
 =?utf-8?B?eU44U2krZjZXa0YrWXZTWE9objFVVGt3RjVLUUZqVGNVUnd0Zy9wdWE2U0Nm?=
 =?utf-8?B?NEFLOFZjQlhKdXBMUzNrS2g5TTdZNWF4cXFHME9WUnZxdmtxMGh1eExwMVlL?=
 =?utf-8?B?UUF2aVFqYWhFUGVBeEFMUUxweHJFRU84aUttM2FOZFFqS0dkQVErN1Q3Nzh2?=
 =?utf-8?B?Nk5iWDhwa1RuRnpGOFpmTldtenlwcGtQdVNVOFJjTU1MVnhRN3YyZ05pZUV1?=
 =?utf-8?B?ODFmR1NuVVhDd2JzbW54cjVvS1J6eWxXNkx2NzdwUjNQVnNYOEZKaURLRkxR?=
 =?utf-8?B?aFdBSVBHamQ2WDJIM2IrL2pKaWErOUNPNEhhVHpHSkt1a29aZHBxZHhlNzJw?=
 =?utf-8?B?c29Vc0tPdWZLcUR1ekJMUE9nTHFYMGozRjE3cG9NV1RIdVNYaHcrR3REaTBu?=
 =?utf-8?B?clF5anIwYUlodGdiWlBTdnVNRzVCSlJUUzc0YmNKU1cvMXZPdjJtQkd6bzJu?=
 =?utf-8?B?VHArcjlWeEFEWjJqN2dkSXJ2RkwzUWlBRGI4N1AvRWdjK1dFeWE4VDUzTDUz?=
 =?utf-8?B?Qi83eCtoYmhrd1IrUlJYNFdkcitSQU54Mk1xangzMlM1c2ZXMWpCZ1lBQm10?=
 =?utf-8?B?cEJQMWFRY29FVitPSjlqWm56ZEhSekV0R1NHditGMENhZVJCOVlpNTNsU2k4?=
 =?utf-8?B?b3JxNjVqM1pOOERQK2xFUGR1NFRLK1hqZjVFUUptcFZQOXpubjV4YThpV0JV?=
 =?utf-8?B?QStkWk9Ham02eFlBdVMzU2t2elV5TjhIeTB4TWUvUjVOVFFyekUvS2tOT0VD?=
 =?utf-8?B?aE1McXJVcnBQd2NzRjJyUVNiY20xWVVPTzI5VWV0VE5xa3AzTllLODkydmhV?=
 =?utf-8?B?YXRnV3JPSytMa2M3M2FPMWtCM2dURU1OYjdsMUlLNVMwdEJpaW5CcUNMZk8z?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1773654d-b472-406c-be5c-08daf24181a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:00:38.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpWOIqPXe+o9JCbCaBHjWwShK5JHKm1GcjngVKGk2WlRWs1hKclOSyjFXpe7tOwDMkG8WBAQFJjInJDk4LuCdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7037

On 05.01.23 21:25, Mauro S. wrote:
> Il 22/12/22 16:42, Mauro S. ha scritto:
>> Il 22/12/22 15:11, Jan Kiszka ha scritto:
>>> On 22.12.22 14:57, Mauro S. wrote:
>>>> Il 21/12/22 17:04, Jan Kiszka ha scritto:
>>>>> On 21.12.22 16:25, Mauro S. wrote:
>>>>>> Il 21/12/22 16:11, Jan Kiszka ha scritto:
>>>>>>> On 21.12.22 15:57, Mauro S. wrote:
>>>>>>>> Il 21/12/22 15:48, Jan Kiszka ha scritto:
>>>>>>>>> On 21.12.22 15:45, Mauro S. wrote:
>>>>>>>>>> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>>>>>>>>>>> On 21.12.22 10:05, Mauro S. wrote:
>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>
>>>>>>>>>>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with
>>>>>>>>>>>> Copperplate and
>>>>>>>>>>>> pshared enabled. Linux kernel is 5.4.181.
>>>>>>>>>>>>
>>>>>>>>>>>> I have a main application, and another service application that
>>>>>>>>>>>> connects
>>>>>>>>>>>> to the main one using shared session.
>>>>>>>>>>>>
>>>>>>>>>>>> After some time the main application is running, the service
>>>>>>>>>>>> application
>>>>>>>>>>>> stops to connect to the main one with the error
>>>>>>>>>>>>
>>>>>>>>>>>>          0"004.166| BUG in main_overlay(): [main] failed to
>>>>>>>>>>>> allocate main
>>>>>>>>>>>> tcb
>>>>>>>>>>>>
>>>>>>>>>>>> Digging a bit in the code, I found that the failing function is
>>>>>>>>>>>> the
>>>>>>>>>>>> xnmalloc() call in
>>>>>>>>>>>> lib/copperplate/threadobj.c:__threadobj_alloc().
>>>>>>>>>>>> If I understood correctly, this function tries to allocate some
>>>>>>>>>>>> space
>>>>>>>>>>>> from the shared heap. But the shared heap is almost free
>>>>>>>>>>>>
>>>>>>>>>>>>        # cat /proc/xenomai/heap
>>>>>>>>>>>>          TOTAL      FREE  NAME
>>>>>>>>>>>>        4194304   3616512  system heap
>>>>>>>>>>>>        1048576   1041776  shared heap
>>>>>>>>>>>>        1048576   1048480  private heap[14505]
>>>>>>>>>>>>          36864     19968  xddp-pool@0
>>>>>>>>>>>>          24576      7680  xddp-pool@10
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> This is the code that triggers the message:
>>>>>>>>>>>
>>>>>>>>>>>              if (pthread_key_create(&threadobj_tskey,
>>>>>>>>>>> finalize_thread))
>>>>>>>>>>>                      early_panic("failed to allocate TSD key");
>>>>>>>>>>>
>>>>>>>>>>> pthread_key_create has nothing to do with xnmalloc. That's a
>>>>>>>>>>> plain
>>>>>>>>>>> glibc
>>>>>>>>>>> service, and its documentation says:
>>>>>>>>>>>
>>>>>>>>>>>             The pthread_key_create() function shall fail if:
>>>>>>>>>>>
>>>>>>>>>>>             EAGAIN The system lacked the necessary resources to
>>>>>>>>>>> create
>>>>>>>>>>> another thread-specific data key, or the system-imposed limit on
>>>>>>>>>>> the
>>>>>>>>>>> total number of keys per process {PTHREAD_KEYS_MAX} has been
>>>>>>>>>>> exceeded.
>>>>>>>>>>>
>>>>>>>>>>>             ENOMEM Insufficient memory exists to create the key.
>>>>>>>>>>>
>>>>>>>>>>> Already checked THOSE conditions? Are you possibly creating
>>>>>>>>>>> threads
>>>>>>>>>>> without cleaning them up completely?
>>>>>>>>>>>
>>>>>>>>>>> Jan
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi Jan,
>>>>>>>>>>
>>>>>>>>>> thank you.
>>>>>>>>>> Sorry but I can't figure out how the code you specified (that
>>>>>>>>>> panics
>>>>>>>>>> generating the message "failed to allocate TSD key") could
>>>>>>>>>> trigger the
>>>>>>>>>> "failed to allocate main tcb" message.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplate/threadobj.c#L86
>>>>>>>>>
>>>>>>>>> That's the only line in Xenomai which raises this message. If you
>>>>>>>>> don't
>>>>>>>>> believe it triggered it, start your application in gdb and put a
>>>>>>>>> breakpoint on that panic line.
>>>>>>>>>
>>>>>>>>> Jan
>>>>>>>>>
>>>>>>>>
>>>>>>>> I believe thet this code triggers the message "failed to
>>>>>>>> allocate TSD
>>>>>>>> key".
>>>>>>>>
>>>>>>>> But I get the message "failed to allocate main tcb", that is in the
>>>>>>>> same
>>>>>>>> file, but at the line #1790.
>>>>>>>>
>>>>>>>
>>>>>>> Ah, sorry, you are right. Didn't read careful enough.
>>>>>>
>>>>>> Ok, no problem :-)
>>>>>>
>>>>>>>
>>>>>>> Could the heap be fragmented after lots and lots of
>>>>>>> allocations/releases? But what is also a bit strange is that the
>>>>>>> main
>>>>>>> thread is continuously mapped. Are you restarting the main
>>>>>>> application
>>>>>>> for every request?
>>>>>>>
>>>>>>
>>>>>> The main application is started once and keeps running, but
>>>>>> internally
>>>>>> creates and destroys many Xenomay tasks.
>>>>>>
>>>>>> During the main application lifetime (that can be long), the service
>>>>>> application reads some statistics from the main application, prints
>>>>>> these statistics and exits. Then, the main application is never
>>>>>> restarted, and the service application is restarted for every
>>>>>> request,
>>>>>> that happens every 5 seconds (but the error seems not dependent on
>>>>>> the
>>>>>> service application restart period length).
>>>>>
>>>>> Ok, so the service applications are mapping its main thread against
>>>>> Xenomai, and that as pshared apps using the shared heap.
>>>>>
>>>>
>>>> Yes, exactly.
>>>>
>>>>>>
>>>>>> On another device I have a similar (but not same) main
>>>>>> application, and
>>>>>> the same service application, and this problem does not show.
>>>>>>
>>>>>> Then, the problem should be located in the main application, but I
>>>>>> can't
>>>>>> figure out where the problem could be.
>>>>>
>>>>> As the allocation happens against a shared, global heap, the issue may
>>>>> be global as well. You could either try to trace the
>>>>> allocation/release
>>>>> pattern against the shared heap and look for anomalies or even factor
>>>>> out that pattern into a stand-alone reproducer.
>>>>
>>>> Thanks for your suggestions. Trace the allocation/release pattern would
>>>> be a huge work for this application, then I started with a simple test:
>>>> enlarge the heap sizes.
>>>> Before I had a 4096kb system heap, 1024kb shared heap, 1024kb
>>>> private heap.
>>>> Now I have a 8192kb system heap, 4096kb shared heap, 2048kb private
>>>> heap.
>>>> Nothing, the error happens again. Could this be a clue that this is not
>>>> a fragmentation problem and could be a heap corruption problem?
>>>
>>> Not impossible. The control structures should be heading the allocated
>>> memory blocks, thus could get corrupted if some other user overwrites
>>> its assigned block.
>>>
>>>>
>>>> During tests, I also noted that when the error starts to happen, no
>>>> tasks in main applications are created/deleted. But there are some
>>>> queues and pipes communications active, then the heap could be used by
>>>> them.
>>>
>>> All objects that could now be used across processes are allocated on the
>>> shared heap if pshared is on. So we are not only looking at task objects
>>> and their life cycles.
>>>
>>>>
>>>> I will continue investigating on this problem. If you have some other
>>>> ideas/hints, I'll be glad to hear them.
>>>
>>> Try reducing factors that could contribute to it, e.g. the types of
>>> objects used. That may help narrowing down the actual trigger.
>>>
>>> Jan
>>>
>>
>> Thanks Jan, I will do some tests and (hopefully) come back with results.
> 
> Hi Jan,
> 
> sorry for the delay.
> 
> Attached there is the code of two small test programs able to reproduce
> the problem. There is also the script to start them.
> 
> Briefly, the "xeno-test-tcb-allocate-mainproc" application creates two
> rt buffers (request and response) and waits indefinitely on the request
> buffer. On the request buffer, the "xeno-test-tcb-allocate-secproc"
> writes a request and waits for the response on the response buffer. When
> the request is received by the "mainproc", the "mainproc" sends a
> response with an incremental counter on the response buffer, and returns
> to wait requests. "secproc" receives the response, prints its content
> and exits.
> 
> "secproc" is launched every 0.5 seconds. After about four minutes
> running, the "secproc" starts to fail at launch with the error
> 
>    BUG in main_overlay(): [main] failed to allocate main tcb
> 

Thanks, reproduced, now trying to understand.

Your test already revealed some other issue, namely avoidable
sign-conversion warnings of Xenomai headers. Patch will come.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

