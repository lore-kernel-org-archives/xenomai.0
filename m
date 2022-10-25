Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E217B
	for <xenomai@lists.linux.dev>; Tue, 25 Oct 2022 06:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euaRs7ZJudc/o+DPmU+ffMmlLYr3+F3NPZAUeaJM6JJYG5oUCQZqvpT3sq2GRfNBkIuOPdQIpbDmuIy9V8+PJWYWn/CnAp1KR/Xx8IkiVTAiacq7ocDU0Kf0qSW/Klht9wJOJIRujxIMcXDnxN0e6pHmm654q0SIO0V73zdfHhFd9KO0+4jNcryk+mja6x8MuPmvW/N0VZ9RSfjWzxRpcqncpiBUaKTtfSl3WuoQZw2K5l+9aV/FqmgztZgfqdmpTV3DGOxjE6NlyRQ0NAUyd5v2ACcrFWoc+HU49MrRSuHotm4pWo6Qr3GgqOx0tUjHy+9Iq9SUcXhDX2b8aWKqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9NP7bGCcWyFMm+dpi7yFdgxAt6lObXQGWCgHLTuxhE=;
 b=QduvQpwVj/+tiaGB5aE4ha/gShy2HUy5Gcu0lK2cCqZOOKJurO0974Rr1LkBUQC99JvS9wo7P50N9GIIL+AfRJ89j8S/aXd82mVgu0TkdmJDW1a0i42Ztur4wm7WaKHnZy/yPW1WzO5azIUPAw5gv1i2/1DaG+vqVbDMon8+PvtkzEe6moYJwXsJ9cLud3cCFHOnhgXL887Et/HLTtWe8oLeExibBSjcWwDcPEdqMf2VncWYXs1NY0I6FRIacmGSLnly4SRy7s4t5U+0AteEUluHYFcwcQtEO2kAmvbGvUPse479pAxBGtQh9Qeg/MhH1lQzXDG0PyZhQR9aDvYQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9NP7bGCcWyFMm+dpi7yFdgxAt6lObXQGWCgHLTuxhE=;
 b=QLm7tJN+BNeOs9fA4l8LHvR/RWBwXTHE5rmOGXCNnz1hgMCV+803/fdyqHhPvhUwLgO63SF99iE4ai/rMUfJhxaYWC/0uGfjsEvZdB5dR1cR9DybV5gW6KzvVddvL//QFf+ekk2u1w6sLbHX532WarWSPDzTs29kHXhid8aPfLS1MRal27LSjbQGKeRfri7sNWEC4H9Sc7c4MKhy09qSqcaGkwH0AlZrKDgKdKNU4k3wP1GB5qrB2mlDBVO+qDkUzvx+46nQXyRtUqEKKaV0uMkmBm2QvHxqUnCte3Q1o+gfxK4Xe9lJ74EBRXFW0ukztHcsfyIO1MIHC+hGOVpQmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5686.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 06:40:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 06:40:22 +0000
Message-ID: <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
Date: Tue, 25 Oct 2022 08:40:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
To: "Zhang, Qiang1" <qiang1.zhang@intel.com>,
 "Heber, Stefan" <Stefan.Heber@zwickroell.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Wang, Rick Y" <rick.y.wang@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c6a26d-8d4e-41af-22cf-08dab653cabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	klNK/xOpfBFu4cRq3LXy1TsOw8jFdqcCozrnf+b8K3W+VgGUSGzfcdfLr4As2IqRkU9wGiorwbcIt416nUIkP3+1JCXVwUKS87mGEx94Y36iMdH0X2F5JG6t5EumiuBItWdpEd6vwwxwnxhZau8v1oVxci4eL+kLIx0lB+Wsz0cyz+V5B14Rn/XM4buZzJgxryJiFDkfvzGEv1525zPFTNF9PMQ2RBLQqzWdXKHlYTnms9KoapdkiZHOPnmsC2FR8i/hMfE9vCfjLnfTzb0UzUUhi3yoFoZMnvfBG405GqXJtnn9pqtfRgRgSo0CFfHy8VQOqemTPH8xjp5Py/8LeM14NAflpg38JuHBBWk+4eM2CKhMN2Ks39D2BU9MBi+XJF7kNZkq3DDbEEu+KBi5rCGKZUAT90n/3D1DBIRTsvgRX3FvVM1kF5Vqx/lYwy1ipHZDShAYzQllRG9081aioa96xZ4xyGH60w0n2JfrgfLW+zcyvjFYgpV0oL/XRRWEU6VHIKJCQorL9mBCx90oV7uoBSSjSwMr5Xah/zdDc74HaMEZLNGygDf6dqgWRqbQwbFnKC2knFlK3DgFchmFXKTjW3FPiDzPtn6QlcX8/Yo+H0E5sNPhr3Xb5dEOK77EHRGaiigGILoDfZGLrHI5t3P2A78qQlaeUY0pJMlrUza4ZHAOiJlzlOIWsieEuzN7PQyFCRDVAahoS6hY7I1kSNkoUYr8XGDy9AHLSXAN64esBWQVK0lLw4Lu4TsEh14RYPQOoTml+GZxm+4bDXcwAwkkwWselKnLFGgrvgkVjMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(31686004)(66476007)(44832011)(66556008)(66946007)(4326008)(5660300002)(110136005)(54906003)(316002)(8676002)(36756003)(86362001)(82960400001)(53546011)(6666004)(478600001)(6486002)(26005)(6512007)(6506007)(2616005)(186003)(38100700002)(83380400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdvMTRPR2swMlN2ZTg3K0lnMjVoZnphdDdKK3cwSGI5YURMeElSQk0vcFVN?=
 =?utf-8?B?L2RkOWtpTE16VVJYM0gzUmlsMzBzZ2pQNXdxaDNjSU9IWDJtR0FDTWdIUXc4?=
 =?utf-8?B?YTFIcDg4T003ZW1IYksrQTdWdlRlRTJuc0c0eXNWeFZjQ01sWkF5bVNrOFhq?=
 =?utf-8?B?T1lFZ2ZtWFFDMUNpVFJqWUZFQ2VHMVkyNk00UGl3VXNVNDJxbXRqVE9ER2xa?=
 =?utf-8?B?TXBCU1V1R25VVjBpOXpTc3pCWWZIY29IaDhSQWtjS2N6eUIxYk1QTHZKUlR1?=
 =?utf-8?B?NDV4bXFsMTlrelZicURRa3VMWXNOYUwyY0FpKy9UMW1aNW9lajQvQVBJN0pI?=
 =?utf-8?B?YXMza2VlT1hlcVVtRGZWeDVQZkIrajdzMUlyQzFsTnFNalc5bGZvQlY0Ukhn?=
 =?utf-8?B?cUtxcDFFT2RkUU8weDNyY2FIMVQ0TGJNQWxwL05ueXMwbjV6amJ1UlhKUVlu?=
 =?utf-8?B?VzhPeEZabUZEbnM5cjU4SE1rQjl6NlJaT2tPZ0l6ZjJHdXBmU09kVUwwM3Qx?=
 =?utf-8?B?QVhkbWhlRFZUaktwVnE1b3JiM3p6Y3JuSnJBa0NMaW5wdStad0x3S2hwTEwx?=
 =?utf-8?B?UkFPbUdIak5tc2x2d3pFSmFtQ2ZSaW1iVG5nZ0QvM0VRbnEwa0tiaEtLOFZP?=
 =?utf-8?B?cFFiK0FIYWJuZlFRMHRicGUxNEFUK0xDQ2ZJMnl6RFZwK3VCWlBNaXJDbitH?=
 =?utf-8?B?ckVnTWxPTmMyVDkzMUdBU0JmdzJuQ3hrZXkzYnMzL3ZBbTZ2anpyZHZXd243?=
 =?utf-8?B?M2hMRHJaeEhFOVE1TytOSmI3aGx5eE9iSjlkbHhsWE5STU9EaGE0UWxHZEFE?=
 =?utf-8?B?aU9mWktJRWpsVUpHejAyeEpyWHVIaExsR213Q1dBUDRkWWFnaDRSNlUvOFli?=
 =?utf-8?B?QXZ5eERwem9HV1ZWTWg2YThCVXF4a0EwWkRWR1RWQXRER202eTdrYVMzWS8v?=
 =?utf-8?B?aFVXbmZzUHBjQUR3TGNuTVdPWkNzdDljaFNFRVdVTHdmaXNkRVBCaURpU2Ri?=
 =?utf-8?B?bkNMc0RkUXBxREhlMnIvcUxkRFZZSXBNeWtZVmZ3OVB6a1NUUStuclZWQlFQ?=
 =?utf-8?B?NWRuUFlzU29sVzJWSEFiaUwzc21jamMrN3ZESXVDdEhjL3pUZlRzQjRVYys3?=
 =?utf-8?B?S2kwbGl6VHova3dJbk8wY3pKQUZMamlUcXl4V3dIb0xmVGpWaGdnNzZWczAr?=
 =?utf-8?B?czdKa1BUak5PNkhuTCs0Z05RYkVBeEdvYkVSRUw0bGRaQlpONVhFNTVjR241?=
 =?utf-8?B?Y2R6QkNsK1VBcmQrOG9rQjF5TWtFb2xYYVh0aEFWaUVITG11b3o5RHpza1Q3?=
 =?utf-8?B?aklrL2w1OGJlcVI3ZCtDNUZ3QmsycC9JNzJiYzZNQldtbCs4VkN3WUJaWFU3?=
 =?utf-8?B?aVhvaThhZGt6R1kvdW1IQWZ3USszdHpNTUI4OEpRWjM5Y1I4QndTb1BYMytj?=
 =?utf-8?B?VHVsWEZFcFFPQldWUEVEQjdNclJPd3hHenF6VnRmYmlYV000UXhsaEt2U01p?=
 =?utf-8?B?dlFsbmh6eUprdWZ6NENEUTBCL2NzRk5TK2c2T0w5QVk1T1NlQ0NIdDV2MUhl?=
 =?utf-8?B?dDZzK2NSUFVhU3IxTjVhcWZDYWlIejliWGMrZG5qRjMyRGU2RGdkZ3ZpenBs?=
 =?utf-8?B?VGZIME41RXM0QUxiTlRPQ0NhNTZySWhJMGkzdnNDUTdHcDhLM0ZRZVZOYkZD?=
 =?utf-8?B?RTZVTnFhVmdPVW81SUJ1NFF2c3hQTUovY0RvczVnZjM3Ri9nMm5vYVAwNXhs?=
 =?utf-8?B?WCtlWnhBQ2d6bmxmb296V2JpMWtndXJ5cC9wbWJRQU9MSitKQUhGUDBkcFZH?=
 =?utf-8?B?NCtVVW1PTkxiSm1QU3FXN3BtbXhNdFpMYUFDaWJETHZubG8xb2ppUnlaclJz?=
 =?utf-8?B?eEQwVFo0cFlOYXYyZHliLzYyRzZyRjJwdHNhUzNOWDMxN0pDeTBSb0Uzc2F4?=
 =?utf-8?B?eWVDbU1QLzBPSy9zMkVITnc1bmwxd0lHdmpLTXQzTjVHWDYxZHNxOUtjUlZF?=
 =?utf-8?B?NTZtcXRudmpBVEVkaDN1TWFXV0NrUlgxUjExQjlTYVU0aWh4YjhsMTUvSzRw?=
 =?utf-8?B?RWJPcGZnckwwWnRUYjRsU2ZMOWtOSnFwaUN3Qit1YlJpbkUyMEtFLzM3cjJm?=
 =?utf-8?B?aTZVQ0pNZGZUV1FOTWR4SUZ3REgzRDFPN1ZFazFyOWFCNHRxaTlYdVl4YnlW?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c6a26d-8d4e-41af-22cf-08dab653cabd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:40:22.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5rR7KaR2flrFzoON93uQP5x5wReEs9kE7XfonQXRM7L8XtlpqnJE2nIHZ+kjwjS9PIeDN0NYa+Mhdfabu6kfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5686

On 25.10.22 04:39, Zhang, Qiang1 wrote:
> On 30.09.22 13:47, Heber, Stefan wrote:
>> Dear list,
>>
>> we, as long time Xenomai users now have a severe problem. We are currently
>> in the process of migrating our huge application from xenomai 2.6.4 32bit 
>> to 3.2.2 64bit (linux 5.4.105). In general we are almost done, but one 
>> problem remains: Obviously we have memory corruptions resulting from 
>> strcpy functions (transferring large configurations) being interrupted by 
>> high prio tasks.
>>
>> We now nailed this problem down in two minimal test applications in order 
>> to rule out any programming errors in our own sources. These two 
>> applications are:
>> a) a simple test that swaps two very large strings forth and back via 
>> strcpy (and alternatively other copy implementations) and then check the 
>> string contents. This simply happens on the main thread.
>> b) a "sleepproc" app that simply contains a while/nanosleep loop that 
>> wakes up every 500ms just in order to interrupt app a).
>>
>> When running the test app while sleepproc is running we see sporadically 
>> errors (typically less than 20 runs of test until we see that error). 
>> Without the sleepproc app, test runs without errors. And don't worry 
>> about this magic txr19391 prefix, it is just an issue number ;-)
>>
>> So, could you please help us and have a look into this problem?
>>
>> Some remarks:
>> - The test seems to be highly sensitive concerning timing. So we had to 
>> fine-tune a lot to see the error in this minimal test. Also it seems that 
>> even the CPU may influence performance enough to make the error 
>> disappear. Another weird thing is, that if we let the sleepproc sleep 
>> 100ms rather than 500ms the error disappears.
>> - In the test we can either work with individual mallocs for the needed 
>> 3 string buffers or with one large malloc and specific "pool allocations" 
>> from that large pool buffer. We can see the error only, if we use the 
>> pool approach (see the two options in the code switchable by commenting/
>> discommenting).
>> - We tested 5 different copy methods: strcpy, memcpy, two types of while 
>> loops, one for-loop. We can only see the error with strcpy, memcpy and 
>> for-loop. (also here: see the options in the code). Maybe that depends on 
>> timing, maybe it depends on the implementation ... we don't know.
>>
>> CPUs we tested on (all with more or less the same kernel config): 
>> - Intel(R) Core(TM) i5-8400H CPU @ 2.50GHz, 4 cores
>> - Intel(R) Core(TM) i7-7820EQ CPU @ 3.00GHz, 4 cores
>> - Intel(R) Core(TM) i7-4700EQ CPU @ 2.40GHz, 4 cores
>> - Intel(R) Atom(TM) CPU D525 @ 1.80GHz, 2 cores ... here we couldn't tune 
>>   it such that the error appears
>>
>> So, thanks in advance and, btw, thanks a lot for your excellent work 
>> during the last >15 years!
>>
>> Best regards
>> Stefan
>>
>> Ok, confirmed under xenomai-images, qemu-amd64, 3.2-head, 5.4-head. But
>> it does not seem to trigger with 4.19-head (all the rest was the same).
>> So we may "only" have to look into what makes 5.4 special. Didn't debug
>> anything yet, though.
> 
> 
> My test environment (xenomai-v3.2.1  linux-kernelv5.4.105  qemu), can reproduce.
> but after I made the modification as below, the problem disappeared, 
> It seems that the large memory copy uses the FPU.
> 
> --- a/kernel/cobalt/arch/x86/ipipe/thread.c
> +++ b/kernel/cobalt/arch/x86/ipipe/thread.c
> @@ -153,7 +153,7 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>                  */
>                 clts();
>  #endif /* ! IPIPE_X86_FPU_EAGER */
> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
> +#if 0
>         if (!xnthread_test_state(out, XNROOT | XNUSER) &&
>             !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>                 /*
> @@ -209,7 +209,7 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>  #ifndef IPIPE_X86_FPU_EAGER
>         stts();
>  #endif /* ! IPIPE_X86_FPU_EAGER */
> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
> +#if 0
>         /*
>          * Refresh 'in', we switch the stacks. However, there might be no
>          * current thread at this point.
> @@ -445,7 +445,7 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
>                 return;
> 
>         copy_kernel_to_fpregs(&to_tcb->kfpu->state);
> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
> +#if 0
>         /* redo the invalidation done by kernel_fpu_begin */
>         __cpu_invalidate_fpregs_state();
>  #endif
> 
> Thanks
> Zqiang
> 

Interesting. Yes, SSE instructions are preferred for memcpy on today's
CPUs. And that version-dependent code is obviously not taken by 4.19.
Forms a picture, but we still need to understand why our switchtest is
not catching the issue. And we need to understand the issue itself.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

