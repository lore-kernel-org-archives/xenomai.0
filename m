Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747117CD
	for <xenomai@lists.linux.dev>; Fri,  1 Dec 2023 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SrcJgziE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhttgQyn2A85Q0zSHAakRFUzdzT69sz5i2q8OPnW1NGaMML+w0ZMuG+nwtXc0UWFionNz2XHePeaqjmtEF5qID3P9CkxMj8ttljN04/xDo3itgBaiY9Dyg52RBknKxJFUAa6aa2hMjwWam5Jx3D4IWNyC9fPKtuuiRWFBBM5Y0IruFUfXfZYopa6RUViFwZt9q1lNgSO1iVjYIJFZFTvDO6I7b8bYfxq8e3cProa6PlFDB0475Y1W6N5p1en7fVfXyPbBOQNXOKZ2xn7rBfCnCNN9oz4EmdMhr1nqDfUKOuzuxaoD/5gBPzEWnemUycNtUr+8YZ47OcPOfzcxMl2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WwmbtuXIBhwKbD/UWSwVTmrt9wzCWpuAeVsnY+Rs28=;
 b=a4pnqjvdUXXjjuu3iP5AROx8CbP0zLRO8IxY8SuGpLJSEEXYa21ocQpy1LY4Bns857WCxgfAA1Dv9F2aFOI8d2fFyBsTPYwQy46deen0aWufBzlpPKjjxN4nEpCFAqDQnf5Kx4JsqAJryeasEc1HjtRW2d3T8KXN9mCtmfqW1BPRisZU9c0/4L92Hx7ysGHjZSqZX4aTp6YX84eoflzveB09j+N91h8f/c1RZe5BbYEanjSkqZYGE+n9RkeHJHjlXKDLVog6dLi0QbAooTcejeFMZS/baZ72ZVec6XFqatD0aObipGA2DdK+B5N2lk78NTdaJmtT355w90KkC8rLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WwmbtuXIBhwKbD/UWSwVTmrt9wzCWpuAeVsnY+Rs28=;
 b=SrcJgziE16BldoA3wljHs5Th5NM03F6vrgxtrEYHNPUMSChHXyq/Efw8y5HRQGugaLa1/2WgrPeC4DFr8Dst+1Z1knkR3rOm5oHaHea4UXTM9n1HFRNm5zqwq5zZ/CTVpI6BKgaREDGKI5+1ipZNSgrQvqC6ItWf3g1PubkutJIpNFar8Fu1Uppyo+um4wWTBwS3cUqcObMnuAid0o/D3uojPctVH8bDVKt59RdDQi/X/EfJBxWcVTRl7YSFpoYSZ4gljq50k+xf7z4thGPYFg0c4cP7YSKXA3EFRwr8KaXLRS+iVALIw/oh+3ti0v3uLNwt9lJox0p8RBeO/xgThg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 01:31:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 01:31:43 +0000
Message-ID: <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
Date: Fri, 1 Dec 2023 09:31:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
Content-Language: en-US
To: Mauro Salvini <mau.salvi@yahoo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 663a9ee5-213b-4ae3-319a-08dbf20d4633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GICR5JgaVwejJr7nHt871tbQUYtvgV1NVWUVehZrCUOr239GeMUvBYYvyhpyX6D4c6pJcrKfTw1ACTOwXO5m8fQL7IrT9m70QOoWHaJaT7X/idD9bfd50wmNqb7/WqJtdEjnIElF39QmFy01o0N7o5AkcoPAs/kvHVpoa6w9o9mjpPl4uBP7IHsKwT2YVWeeUBWCX2QfQQWz60aSBPTuOY/Qs/1ji+GFVkgr1xlbKtbTk3MgmZ2+RnFb/7t8uIFdPdWBJxQmat93yosEevgNPjOrntU8lwpw8aihaJ3emPNjaJDDmqzWn8VF3hINyiX9sKfjRrZd/K0Iz+orREV4Jnk1EDl5iXuDBJqvgDijw6ifzjNkAhiu7tJbLnaVmjuLwWOnyyRQH9vns/1dPLIVL30Gi9ETxpwAmntXixmG5JKxj6YWANPAHSnjiOUff3NE0j9i7J/7OD+FpToitzqf9HATnBr/WMqT7L2xDi9OQoEY7h80TglOnlmIkO/HF7t5P5oXk2G8HkLmTBwASdeNUSc2kfxw7cp3fuuiqxXfqGnGjL2XmvOXdy+4Mk/BTCS/YpKdcuXjuu3+UjWmnbxD1e3tPf970GMp2RY9RapZfDPVCp7b6cHQkYein8YnGMRxcHD6TDy+cPi272XdRQqWXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(4326008)(66556008)(66476007)(66946007)(6916009)(316002)(8676002)(36756003)(8936002)(5660300002)(44832011)(41300700001)(86362001)(31696002)(83380400001)(82960400001)(2616005)(26005)(38100700002)(31686004)(6666004)(6512007)(6506007)(478600001)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFNvSXp0Z3E2OVFFWExMdlE5akY2YjVkYjBEVEpqZnhzZXMzdXJUZEx5ZlZt?=
 =?utf-8?B?amdZSmJGaEQ2Z2lYOWh3dUdOR0NVZjB2b3p0MTB4eVBYRGdRaFFRazBseWRR?=
 =?utf-8?B?cTgzK29HTHd5YVlvK2JhNVRlQk0vQzFoVXo2aWhoWGhMNDZyWXhrTk1uNUhx?=
 =?utf-8?B?Nnp6NG9wMFo0cUxaQ0k1RUNFWDBjNWR5cDBwQU9IY2R3bU9TNWlGSTZJVXdw?=
 =?utf-8?B?Mk45dE4wRnZQdkZXVE5TS3dQSWIvcDh6a2F6UHgrSmhWck11cFQ3OEFKaFFW?=
 =?utf-8?B?NHBwY2VuOGFwblQvRFhYeS9EZjhjT1VqK0JtdjlWMlRLTGpET3FrcThtd2lK?=
 =?utf-8?B?MHFBQzBvUnZlcnV5bFltRHpxVVZQS3kwR1laY0o0MGJzejBQeElhWDFTNHFq?=
 =?utf-8?B?WG1GWTBpMGgzM2N1VENlUmtjeXRraVQxWFlRbHBoY1dCTWJKdEFjeXIrVXJk?=
 =?utf-8?B?WGdDanc5SXdwdHhuMElhOHVrRVduYUVnZmpxL29SSHRjOXZkQzd5UTE4S2N6?=
 =?utf-8?B?T1dSUlZNcnJxeTJ2UGtrS2dlVjZQNEtwQ1JReHM0Yi9YNkR3b0Q5N0JZUVhD?=
 =?utf-8?B?RVZWUFBFYUtFVHNCb1VzMGtXc0QrV1VXc2ZWeisveDhQcG5za29rTjNhQWZO?=
 =?utf-8?B?RXlTUm02ZEFXRGpacDBBR1NUTThHQ0hqdkVCeFE5bi9hY3ZtclJWQ3lNRmZZ?=
 =?utf-8?B?ODJwYU5JMGkwUWxGR1dRdG9GT2RWcE5MYkpxR0tmK2RDVzBvRWUzL0JHajVV?=
 =?utf-8?B?Y3hsT0NXZEoyOUQrSkpORmNnWVpXQXpuNUIzQmNuWjlIcUxMVnROT29seU1Z?=
 =?utf-8?B?c1dyM0owWi9PUkE0WGJ1OVZLS2ZHVkxBR3hCamJlTUhueUVtcVR3RUcxaWpL?=
 =?utf-8?B?WjN0enVkZ3FIdVRlQXhtRGRzYWkxSFNEaHVCZVUrbiszN0QrU1lzYzVYTFZ0?=
 =?utf-8?B?ampwakJyN2tKWVlQeXY5SHVTY2R4UzlaS0NDVElBeUIrV05mNDFoYUxWeU9m?=
 =?utf-8?B?bDB1MUthS1N3cEN0WFl4OEc5MjhhOFpMelVyZ09SS3JPNmJ2aFVubG4zalBw?=
 =?utf-8?B?OFRYTzU3eUsvUXBiK3ppVVpydW5YeHNSamd6bzhwemFhYVRXNTErK1NoRm5N?=
 =?utf-8?B?cW55MHRZY1J3dGp2ZWdqZXpFTmlRdU5yci9ndFFSdWxjVllHTWlsSTYyZEVW?=
 =?utf-8?B?ZnBkRDAvTmNoZ3M0N2pHTkFMRFVNWGpML280RHJxWC9qVXExallHWDhzSGE0?=
 =?utf-8?B?RVc3M1loc3RZK3llS2duNW9uWE5UK0Z6U1NBd0VxbkdCaTQzQXV2cjFkMnZq?=
 =?utf-8?B?RDFBTFZpSW11aDZqNktXMU5qSGxYWjNoZGpFdHo4ZDZJWG9UaDJ2bHpJNHEw?=
 =?utf-8?B?Wmg4d2w0bFlzUUtKMkJPQmdOWnpDQ0x2cUVQRW4rQXZOS3J1RXNTTkJWbkQ1?=
 =?utf-8?B?SG9GRDJSUWs3NWRDa2lmVHg5WWFscHo3VkRkQXVvL3hMVm51djNrTjAzbUxB?=
 =?utf-8?B?YmtHREt5dmsveGxreUUzQ2VnK0pxVTBxb292d0c1KzhBWnZhK1V3cnZqMjV1?=
 =?utf-8?B?VVlFQXRXQ1VPbS9XWHR5WktXYzJYOUJpRkNlYytEZUdVYnkveTVWTFhhOVJE?=
 =?utf-8?B?VlpTRkhQQVpqTmZqUzFBMk5INXdxNHlxNWk1NVFLTjlCS0VkM3lXNEF4Zmxk?=
 =?utf-8?B?bXJuaUJIdlgwL3VTU2p0Ym1jb0pZcUNlajE2QTM0V3EwT3o3VzBjRVpKNlZk?=
 =?utf-8?B?MnlqTG00QU00UUlCcjFUN1hNRGNTNFptWHd5ZDhlT205OWE3ZG9ibEZvVG5u?=
 =?utf-8?B?V0owMjFucG9QVklCRm12UWxqS3RmSFc4Zm50WFF6ejF6NW9XU0owY015OXhu?=
 =?utf-8?B?UzdBRWh3akJ2Zmt0aUtTZzRhQVl3V3htamFRd2xlbi93cVJ0QTlWWDBqalUr?=
 =?utf-8?B?c0d3MDdhTEgrK0kvaW9WNjJ1S1ZSWlhMQzh6ODYrSGdieXdhck5EQXVjcTQr?=
 =?utf-8?B?WE1tSTVuN2I4T3VqalovTzU5SDBEdklub2hoRFZ3R1FBNTg5ZW8zc1R0OVNj?=
 =?utf-8?B?bjJ2MkUwdjA3OXRhWFpXcGRCZ1JNQkl3bmVPZjRlbHhhYnhzaEpGL3BEL2lt?=
 =?utf-8?Q?zTH4PkFUS2Tg34r9e4dSRZkXB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663a9ee5-213b-4ae3-319a-08dbf20d4633
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 01:31:43.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpRbiBIqvgYv+qNA1BVBFz81VIJWq+FHG5koly4E9cZKAgjpgrY0LaDfa1KYg+UtFxSnzH01bY2GJ/SRshrVMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7259

On 30.11.23 00:24, Mauro Salvini wrote:
> Il giorno mar 28 nov 2023 alle ore 09:39 Mauro Salvini
> <mau.salvi@yahoo.com> ha scritto:
>>
>> Il giorno mar 28 nov 2023 alle ore 00:15 Jan Kiszka
>> <jan.kiszka@siemens.com> ha scritto:
>>>
>>> On 27.11.23 22:02, Mauro Salvini wrote:
>>>> Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>
>>>>> On 20.11.23 22:23, Mauro S. wrote:
>>>>>> On 13/11/23 18:54, Jan Kiszka wrote:
>>>>>>> On 11.11.23 16:03, Mauro S. wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
>>>>>>>>
>>>>>>>> The application I'm running (a complex application, with about 60-70 RT
>>>>>>>> threads) has a simple loop in the main function, something like that:
>>>>>>>>
>>>>>>>> while (stay_in) {
>>>>>>>>      ret = rt_buffer_read(...);  // with 50ms timeout
>>>>>>>>      if(ret) do_something
>>>>>>>> }
>>>>>>>>
>>>>>>>> The main loop reads the buffer to receive some commands from outside,
>>>>>>>> and when the application gets a SIGINT, the custom signal handler simply
>>>>>>>> does "stay_in = false" breaking the main loop, and then the program
>>>>>>>> closes.
>>>>>>>> During normal running, I can see the timer associated to the
>>>>>>>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
>>>>>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>>>>>>
>>>>>>>> 0    291/290         2ms970us           -           myapp
>>>>>>>> ...
>>>>>>>> 0    609/608         34ms860us           -           myapp
>>>>>>>>
>>>>>>>> I also see the thread in "w" state (waiting for a resource with timeout)
>>>>>>>> doing "cat cat /proc/xenomai/sched/threads":
>>>>>>>>
>>>>>>>>    0  16328  rt     cobalt     50   21ms279us         w          myapp
>>>>>>>>
>>>>>>>> Sometimes, in a non reproducible way (at least for the moment), when the
>>>>>>>> process get the SIGINT it never exits, remaining in this status:
>>>>>>>>
>>>>>>>> /proc/xenomai/sched/threads:
>>>>>>>>    0  16328  rt     cobalt     50   -             W          flxcore
>>>>>>>>
>>>>>>>> The state becomed "W" (waiting for a resource without timeout) and in
>>>>>>>> fact the remaining timeout is not present in the row, also in
>>>>>>>> /proc/xenomai/timer/coreclk:
>>>>>>>>
>>>>>>>> 0    291609/291362         -           -           myapp
>>>>>>>>
>>>>>>>> (BTW, seems that some timeouts got lost, because scheds are many that
>>>>>>>> shots, and this happens also on other timers in coreclk)
>>>>>>>>
>>>>>>>> This is the backtrace in gdb:
>>>>>>>>
>>>>>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>>>>>>> /usr/lib/libcobalt.so.2
>>>>>>>
>>>>>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>>>>>>
>>>>>>>          /*
>>>>>>>           * If we got interrupted while trying to re-enter the monitor,
>>>>>>>           * we need to redo. In the meantime, any pending linux signal
>>>>>>>           * has been processed.
>>>>>>>           */
>>>>>>>          if (ret == -EINTR)
>>>>>>>                  ret = cobalt_monitor_enter(mon);
>>>>>>>
>>>>>>> But the problem is that the lock (monitor) is no free. Someone else
>>>>>>> holds it, and your interrupted reader does not proceed.
>>>>>>>
>>>>>>> If you dive into mon at this point via gdb, you may find the owner
>>>>>>> (according to libcobalt's view) when you resolve manually what
>>>>>>> get_monitor_state() does.
>>>>>>>
>>>>>>> Jan
>>>>>>>
>>>>>>
>>>>>> Thank you Jan.
>>>>>>
>>>>>> I rebuilt the Xenomai libraries with debugging symbols enabled.
>>>>>> But when I try to print the mon variable, I get
>>>>>>
>>>>>> (gdb) print mon
>>>>>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
>>>>>> (gdb) print *mon
>>>>>> Cannot access memory at address 0x7f3cb524e62c
>>>>>>
>>>>>> Seems that the memory address is not in the core dump, but I'm wondering
>>>>>> why
>>>>>
>>>>> Did you create a core dump or tried to attach live the hung process?
>>>>> Maybe the former was incomplete - for whatever reason.
>>>>>
>>>>> Jan
>>>>
>>>> Sorry for the delay, but every time I modify something I need to wait
>>>> for the issue to arise.
>>>>
>>>> I'm working on core dumps. The previous core was incomplete, as you said.
>>>> I needed to set the coredump_filter kernel cmdline argument to 0x7f to
>>>> have the complete coredump.
>>>>
>>>> Now, I can see also the values into the Xenomai lib memory space:
>>>>
>>>> (gdb) print *mon
>>>> $8 = {state_offset = 1047984, flags = 1, handle = 44}
>>>> (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
>>>> mon->state_offset)
>>>> $9 = {owner = {v = -2147483638}, flags = 0}
>>>
>>> This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
>>> thus 10 is the owner. Unintended recursion?
>>>
>>> Jan
>>
>> Oh, yes, my bad: I have seen the xnhandle_get_id, but not considered
>> that atomic_t is treated as a 2-complement number.
>> Then, the owner is the caller ID. I'm wondering how it could be a
>> recursion: the main thread is a simple while(..) rt_buffer_read(..);
>> I will investigate a bit more on it.
>>
>> Thanks.
> 
> Maybe I found something: in the backtrace of every core (cores are
> generated with SIGABRT) the first two frames are referring both to
> cobalt_monitor_enter(): frame #0 is at the source line where the
> program is stuck (syscall), frame #1 is at the cobalt_monitor_enter()
> function declaration source line:
> 
> Program terminated with signal SIGABRT, Aborted.
> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>     at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
> [Current thread is 1 (Thread 0x7f0d7628c400 (LWP 2751))]
> #0  cobalt_monitor_enter (mon=0x7f0d7583862c)
>     at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:218
> #1  cobalt_monitor_enter (mon=0x7f0d7583862c)
>     at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:186
> #2  0x00007f0d76612748 in cobalt_monitor_wait
> (mon=mon@entry=0x7f0d7583862c, event=event@entry=0,
> ts=ts@entry=0x7ffe7d7380f0)
>     at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/cobalt/internal.c:276
> #3  0x00007f0d76639497 in monitor_wait_grant (current=0x7f0d75842bc8,
> timeout=0x7ffe7d7380f0, sobj=0x7f0d758385f0)
>     at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
> #4  syncobj_wait_grant (sobj=sobj@entry=0x7f0d758385f0,
> timeout=timeout@entry=0x7ffe7d7380f0, syns=syns@entry=0x7ffe7d738074)
>     at ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/copperplate/syncobj.c:553
> #5  0x00007f0d7664c691 in rt_buffer_read_timed (bf=<optimized out>,
> ptr=<optimized out>, size=<optimized out>,
>     abs_timeout=0x7ffe7d7380f0) at
> ../../../../../../../../../linux+xeno-src/xenomai-3.2-new/lib/alchemy/buffer.c:555
> #6  0x000055b104840601 in rt_buffer_read (timeout=50000000,
> size=19216, ptr=0x55b104844180 <Request>,
>     bf=0x55b104844168 <ReqBuf>)
>     at /opt/sdk/3.1.22-2.0/sysroots/corei7-64-poky-linux/usr/include/xenomai/alchemy/buffer.h:129
> #7  main (argc=<optimized out>, argv=<optimized out>) at main.c:410
> 
> Could that be a clue?

That alone does not tell a story. We know now that - at least according
to the monitor data structure - thread with ID 10 is holding the lock.
If the very same thread is trying to re-aquire it, this will cause a
deadlock. And if that is true, we need to find out, how that could have
happened. I have no idea about that so far.

Would you be able to factor out a simpler, sharable reproduction case?

It also looks like as if the reader is receiving some signal while
blocking. Is that expected based on your workload? It may destroy timing
constraints, even without the deadlock.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

