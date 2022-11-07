Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2071.outbound.protection.outlook.com [40.107.103.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55047BA55
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 13:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFfZfiwaqtNaWSpm7Vomy1OZREMNVpYyjn6KaihqCQIzE61RaiOyTcxSnhKmXEIZTMaeHkZOu0UkAnqBw5qLief4/YXdBXH+nJ36zCYxaxLD0eAzQohdFvWzwYexaBA99nmtJgIXs0SldnIKHOn/OGGimTvMvTWrmZ2Dd/xY5Jq4weagx03dC4v8cZy4KpCm/Nza+o1MXnpynp+g6pTDaMRVU8l1cCC1SyM5FlKHko2tmFPil46zVR1x7/QRzxjrD50CohwCGEFu5E8oCKYi74r8R7UJkZY6/u1teUEgoDn+2TiaszuTERL4eLZce+ebn0dEixEHWpGpy8yUQ9pN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NykzKAvx7X3JJWfmUbEli2dyI9UU+aOee/qWwNkvP1s=;
 b=mJzwd6xvVH3vh82X0tYoT6AUAOFpPi0I1TKPZm5nhXjMY8Pwk3foelTDyxfOPFAERvyZrj9cI79usXv2SgIxuUq8FhDKP/tVmDUvAc8E/++MQupKygYCgqAVN9/pAVKEgh2iXs6/fgjFLbbRWFJQAxzahMWBCw85lJRJiWc6avTWHuj1YxWsL8cjsfZNn1faavImdUFFPEcycafdH8HlzbO6gjNTdQqyvBurp8zgun+xLG4zAr+50Z+okgYQvWyNLakw9Lf5b5TIPrnE/bHuoz3dFLc5T8q0DWT8xxjyEwehESLP0ADtDQQwikaH3gJ2m0qvyhzqnr03dPsg+OH1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NykzKAvx7X3JJWfmUbEli2dyI9UU+aOee/qWwNkvP1s=;
 b=uGVpz7Vp2/F3CoeFZKqmt19mY4bQbQU6ydahg9WM08YjPTfJXj2gHvXzna7dnPS2eMxYm4z/NtDT2UQdm1QHPu2p22wgdJK2E9yQQNF04Zs3JbhcKVNTSlKVNrJD4djWsci4zzpz3T92zyTLFL13bmmsuonFvzd8ZUBuFT7rLHz5JJ2mtatkul7MknEvrXxfcGmhgVBWPLiAFGn3RnAT6W/3mDLKZzGaK9tXbbV/KwNd13Zqb/ZmZlrNLCBvrtw2qD7n3BpslC3DvhhWItYlwKEwtFy7W/QTcAVhxuqx3qU7e8fDd3nb4JbbUMPLS2uMAts11BYA5XvdNMs4uvDObQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 13:38:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 13:38:18 +0000
Message-ID: <b16c3606-da8a-7739-ff0b-de7fe8b54926@siemens.com>
Date: Mon, 7 Nov 2022 14:38:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
 "qiang1.zhang@intel.com" <qiang1.zhang@intel.com>,
 "Stefan.Heber@zwickroell.com" <Stefan.Heber@zwickroell.com>,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
Cc: "hongzhan.chen@intel.com" <hongzhan.chen@intel.com>,
 "rick.y.wang@intel.com" <rick.y.wang@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
 <FR2P281MB265412CDC9321A60BA8B87BCFC309@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB58807DD17256817B3BFC54A3DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
 <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
 <151047c2-a1cf-db66-d4d6-61d0df96976f@siemens.com>
 <b16e958f-bd57-5b18-c1fd-e2e67cc8f589@siemens.com>
 <PH0PR11MB5880A19D008C286A96BC9495DA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <6fd9a1fc76faa35924d2bf19407347a3ed525df5.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6fd9a1fc76faa35924d2bf19407347a3ed525df5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:130::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbb873e-117b-480a-a90b-08dac0c5543e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I/6x37mJk4jyfeX8oM8dksat4RAkQeyyonELUFL5yFORXgT5wwVAaVeGBh1Wp953sVlqd4k7F/1sqyeL0iDRN98xTjU7SsMnkcGzjGfZYKJqUxIRILriZKlfN9xL+ZWZDj0HSggpSc6omLmXGomkROpjlW+dXWMVQx21ZFlPnAK7MQp2yXdlGmOP3yGvf3kdXyFxVovKBVjmITgzPG/TVw61JZki6ytge80UK2Hb+9EjXCPlkzX9kA5nNYA2/RseWIb5QO3KdyVyDuEVO415shGPgnKov6qycyJ70CsRprC04gWCrKpX7M9m+ZcKLCU11WY3Cgnoz/pHa3QYMDT2uQ0IL8hrCTxyq4pGLnwJjF7xHGw8ujjzaGzO27oW2ZrPuWwR5BgaKjIbpDWMpmXVh/T+ixTL5jKOPCBljyjhM42nb19JipFhJzA/nccqzYimZ/q6eNt74THhaczqGz6w42BJcKUQcBb6CEhxahFVPG74w1g1YBGiPQsfidrCdHriNKsZ1hd0ZDmWdy7RnA3qBdYZQv3s54pTQcz5GcOlRA+BffoeIriSuCtni9JJYx1guFnYyj9u86BNdfVtDlzh09yc6kAW2txYJi9fi/QPeW2EycxN541JmCljuFmbe+BqpFo2mwYfEvilg5VADrV3srFt42kpGgBULgK9ys3nW+zX1EVcu+2oEnB/K3pCYJc6dEjleWHL/yUO4vMWewfbAPtAMj7Jszmwf3G31Qp+Es9ZN46efSsgPu8N+rRNOZL6vuLgQV7ssDtqzrlYSl3nq3hI8DwudtG8UWAGLnD6Ye2nJvGk4MntVF1kb6Es8HTqdveWiT59JseQsYQ43eZt4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(31686004)(38100700002)(82960400001)(44832011)(2906002)(83380400001)(2616005)(186003)(66476007)(8676002)(66556008)(26005)(6512007)(53546011)(6506007)(966005)(31696002)(66946007)(110136005)(54906003)(4326008)(316002)(41300700001)(6636002)(8936002)(86362001)(5660300002)(6486002)(478600001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFyVnpBRTkySEFVYTFyajZzVjAyZmZwaW1NMUl3M3dsUExoSFlQUkhqQ0dH?=
 =?utf-8?B?VnAzazUxLzIrVVpPV2NaL1ZUNUZrb09jTTJOUUtJOXg0RWE2NUZQZHEwODJQ?=
 =?utf-8?B?UTg3SmlBOTNBQnh3aTl1TkNSYzkrU01XbEhOSEFNTHB3SG0rajZRek5CUmg1?=
 =?utf-8?B?U2hQN3JVWWdVb0hFekcwUTVBdHlLaytRd091QUlkYmZXYUN6NmhiWngrK29o?=
 =?utf-8?B?MnN6N2ZWN3JES1BrYlExa1FwbXBKWHRDMEExVmorL2lxS1Z6ZFpWOWs0a1Uv?=
 =?utf-8?B?MVZDOE5oRFMyd0RpeTRnVktDSDJaOVB4dFB3WjJQSFU0Q0RZRm54cG9wU2ph?=
 =?utf-8?B?ZWMzZXozSFpBS294b3JIczc5OCtBZElyRXZEQ1RmYnFaeEhTN1RoMjQ4ekZR?=
 =?utf-8?B?cCtvN2RNWWNnMU1ESW5mcUp6bnlnSGRpekpUU25sTnlZTG9QaHNWeEVXcTdB?=
 =?utf-8?B?QlhaUmpleC9jQjlCdXRHQU83RWRJc2JUdWlDMm1Oell1YkE3V1NSclRqdmVr?=
 =?utf-8?B?SG5xM2lmSjR1Y1pmTTJlUDl6R2YvNzRQQWUweHVTOUNxakhwdHhtZGt3WHN1?=
 =?utf-8?B?cUxCYS8yV05BWjlEd3diMmlPR1kxSGtWREFHdHFDRmwzbjhOTGx2Y1BWNVVn?=
 =?utf-8?B?T1dGWjQxVkNsRmE0VUlwNm8wZTBUMUJjbkYyVGdjT2hHSmNqNUNGUHExK29l?=
 =?utf-8?B?M0NxR1A5OEg3SkZwWFRKblR6dEgreUlvb3FBa0VXYTJJUVNYdU5kRGN3Rkdt?=
 =?utf-8?B?SW16TUh3RHlja3pDeSt4NmMyVjVyTWxHekNjNm9iaFBhRDNQWHJkNUZ0REd5?=
 =?utf-8?B?aWVCWlVIMVd3OXJNWmFFeUlXOW5iUTFRdFRtUHFFRlpoc05DcUV1T0NFRmc5?=
 =?utf-8?B?OEpQMms5ZzFDa3JtMDhoVjRoY2ZuY05pSERlNVh3RDgxaTN5OTlQaHdSUmZo?=
 =?utf-8?B?cCsxYlZJVjkyVk91WWZ6ejhIVjJ4TlZpZ0JFRHVLcXUyWmZFRzJ0K21Db1Qz?=
 =?utf-8?B?ZmF6S1owdkx3ZklpaTJFNXhYZkt1UnFRL3pWZExGaTY0ZDZtOHRyMThPQU1N?=
 =?utf-8?B?eTRrY3dZc2FGU3hlREJXckdzRFk0OVZ1eXZwZXNQUmlJTGgyTUJBYzhRdWFL?=
 =?utf-8?B?QUxRWnhQdGExSms0U0FDOUdEUzg2dEtZRXorZllwSDR2Z0pTNlhsMllqQUFw?=
 =?utf-8?B?VWFNaytHY3I5aHZhMzFISXhXWkZGc3lVTnFqbE9NNkFYL2JFOXoxaXFiSGdF?=
 =?utf-8?B?OU8ybDl5ZHVjNjFUS1pBQUgxYmFyR3BQZGJiQm1PeDhkcUlmcnQrTDRHVXl3?=
 =?utf-8?B?cjl0eHpwWWJGN1NXbXRiWG1UcmJCOG1HS3U2L2JxdTQ5SWQ4cnBtZkdKQ1Rh?=
 =?utf-8?B?WGNaclFnZ2xON3RyaDZBRXpyd3V2MUltenpKY3Raa1B0WUM2dHpoclpOSnJi?=
 =?utf-8?B?SWZvWDZGS0ZrM2dtcWluWVZtUmZxR2N5Nk81ZndJKzBTVzJjeU51OGdXVVJL?=
 =?utf-8?B?c2p5dlJpYjlXOWoxNWdIVDZwSCt4UGJKYTd5elFQRDhVVVppam5EdTVqTmM3?=
 =?utf-8?B?b3A5Y3h6K1BkcmRBQ0JPVnVQSVdnU093Q3VsWW9mNmlHdFRZam5iakhzZVJC?=
 =?utf-8?B?eDJwYndFYWozdHNZc1ptcm9yK25jVzBBRSsxWitYbis0M1RhRHA2UHFPU2xS?=
 =?utf-8?B?d2NNVUJrZnVDOHVqZ09kQi9CYTUzSDMvaEhrUys1QzF1NGZEaktZZmNQcEFN?=
 =?utf-8?B?ZFpSZkRNNFFTODVnSHFKR2NMSmZnWi82RUhHMUdnbHFGYWgveDh2ekFaNFYx?=
 =?utf-8?B?bndqMEpxZjFPcEZDdFFpMGJTVndUaWJxNUZ5aEdPQS8ra2pNUDJTWjdQYzNV?=
 =?utf-8?B?QUhhTUxBSDMxa2RSL01HUnVYV3crS2dFNTUzOEpLTUlYM3hCZjVIWUIxVWgy?=
 =?utf-8?B?SjZtWlMwbnlYaDJwQS8wYkw3R0d5ZU5RZXJsYS8yMTZMNVNZdWRDZlRmYnJ0?=
 =?utf-8?B?SExUWGhQcHBsRkVzZUtZQkNLVTRmYTZIOUlkUWNuWnVwWjRsTnlxV2pzZFNw?=
 =?utf-8?B?M0I5UGRuQTRWWUlVU1dKYXhRRzhzQlpJN29xM1FTRnZnSGd1emtMcFBrSllS?=
 =?utf-8?B?ZWVoeENlRVJjaVNLcFV3ZGhmZlg3YlB2dFlJQ2g0Zm9Zb3RoaHg0cFkwUVdN?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbb873e-117b-480a-a90b-08dac0c5543e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 13:38:18.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow1HytJ2MOW69caC+ercO4XFwnad6tJR4Ho/PIgvn+YmolU6RfH6SSDv4AY4hU47hTi3PU1+BSUBcolBLu3ebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7179

On 07.11.22 14:22, Bezdeka, Florian (T CED SES-DE) wrote:
> On Mon, 2022-11-07 at 13:18 +0000, Zhang, Qiang1 wrote:
>> On 07.11.22 09:42, Jan Kiszka wrote:
>>> On 02.11.22 16:48, Jan Kiszka wrote:
>>>> On 02.11.22 16:34, Heber, Stefan wrote:
>>>>> Hello Zqiang,
>>>>>
>>>>> We tested your 0001-IPIPE-ignore-xenomai-FPU-operation.patch on our system (Linux-kernel 5.4, Xenomai v3.2).
>>>>>
>>>>> This patch makes the problem disappear with our tiny testapp on our system, too.
>>>>> But with a systemtest from our huge application (>250k LoC, >20 threads) the problem still exists.
>>>>
>>>> The patch is surely no solution, but it points to the direction where we
>>>> need to dig. Unfortunately, I still didn't find enough contiguous time
>>>> to start that.
>>>
>>> I'm starting to understand the problem:
>>>
>>> Somewhere between 4.19 and 5.4, the kernel moved FPU restoration for
>>> incoming threads from the thread-switching code to
>>> prepare_exit_to_usermode(). However, this path is not taken when
>>> switching in a primary thread, at least when it's coming from secondary.
>>> Need to look for the right way to account for this now.
>>>
>>
>>> A first, so far promising fix attempt:
>>
>> Hi Jan
>>
>> Thanks for the patch,  I have tested it base on Xenomai v3.2 and linux-v5.4
>> This problem disappear.  I expect Stefan's test result.
> 
> Even if this is the correct solution (LGTM) we should update the test
> suite to cover such cases. I fear there is more work to do.
> 

If we are lucky, "just" resolving
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/22 may help
here. I've asked my colleague Tobias to have a look at that.

Jan

>>
>> Thanks
>> Zqiang
>>
>>>
>>>
>>> diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
>>> index 7e28903a42..8bd2cd912b 100644
>>> --- a/kernel/cobalt/arch/x86/ipipe/thread.c
>>> +++ b/kernel/cobalt/arch/x86/ipipe/thread.c
>>> @@ -443,15 +443,19 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
>>> {
>>> 	struct xnarchtcb *const to_tcb = xnthread_archtcb(to);
>>>
>>> -	if (!tcb_used_kfpu(to_tcb))
>>> -		return;
>>> -
>>> -	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
>>> +	if (tcb_used_kfpu(to_tcb)) {
>>> +		copy_kernel_to_fpregs(&to_tcb->kfpu->state);
>>> #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
>>> -	/* redo the invalidation done by kernel_fpu_begin */
>>> -	__cpu_invalidate_fpregs_state();
>>> +		/* redo the invalidation done by kernel_fpu_begin */
>>> +		__cpu_invalidate_fpregs_state();
>>> +#endif
>>> +		kernel_fpu_disable();
>>> +	}
>>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
>>> +	else if (xnthread_test_state(to, XNROOT | XNUSER) == XNUSER &&
>>> +		 test_thread_flag(TIF_NEED_FPU_LOAD))
>>> +		switch_fpu_return();
>>> #endif
>>> -	kernel_fpu_disable();
>>> }
>>> #endif /* ! IPIPE_X86_FPU_EAGER */
>>>
>>>
>>> Jan
>>>
>>> -- 
>>> Siemens AG, Technology
>>> Competence Center Embedded Linux
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

