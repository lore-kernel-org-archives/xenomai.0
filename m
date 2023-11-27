Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2075.outbound.protection.outlook.com [40.107.249.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F82DF91
	for <xenomai@lists.linux.dev>; Mon, 27 Nov 2023 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="t8gf2hDp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDue0RpLqiveRlpHtZ8mpY87b8uWNyX/CtvBrx8xgh/xZ3x1jqo3WRk4znN9SB3DkUkcPhT9bYRyeXrmnHEbp0kaEkDP0kHIdV0dwx6I8cT1uLs0DUph7ZI+7jWvg5mHp1cYyk4Tb5ivJPxsfv9PEWYi2YF3GtM/YS4lh/6wsgNGxzbY0tRXF7u4Tmtcl31OasC8VZ8t/k8M7UEhLxjbihqXo34vpQxzR3HYer/RBgx2GC+UUP5eHCN+AXUJ/wzXRKuzZGINL40wUP00no0I+oOxlEWg8RD6S+6dTeqLqRURpNr5FX8Hjv30euTsDDKTc2RYsxwPJsmQB7bfJlgg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD5kuf5pN4RZxUCmQP4X7gclZSWdvKFw6DnIs8BnQEQ=;
 b=JoLBPaKPu9yWjb/wv6L9I1q1OzbxyS8HcdkpEylYCJAzDjt06yFwbuyB6fZMTbnd8/W9isUoi/2C5yd2HawiZnZo18sVi6cJCu0fzctYyTRuCu7fpjqVZqSRxc9hZftAvzBpUl3WgjZ5rYGdLP2ZOB+cec6EXFdUjE3Sgp2ieggFA+zTBvPgaR4NhsGNuj+LdurkDeqNriUoABiJAidyR95DWjGdBbqF6Z6PiK4zQzQvg0/gl0czvYxv0RTRsT5zqsNBwE9Q5EB8s0Z+thq4OoA6vQvE/JFz9ZloCJnocjCGmP7zHsfwXAFiV1mQt+n4iVzQy6XwJcWzHchlVtjzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD5kuf5pN4RZxUCmQP4X7gclZSWdvKFw6DnIs8BnQEQ=;
 b=t8gf2hDpSyRVlR3SOh3F9JzHIHHXsU87PU5N4N1kYFT98bYJEVkNh8924M3Hz1U8DX+DIj6k6gKO4dLKUrewEmxGzcAtmNcpQHZ9agKUn12fxY0JLng1GOPVdurf4P30gjvQ5UQ7xPW4gepWIMJgMeVVr77y0bW+VUtGkS33U2ltEnMkjFkDbfiJv1WIDeKdxPbzugJ+P7245rYuNICZL8cG4EYlQsgxf4iZ1foxjLvt64xVIjN8Ojxl5Il1PH69l5X0QeEFscGREFVhKXwfez+obmPa3rgwPsKZjWxaO5YoweCqSOa7KQPW1V4oDOeWKgJPbo8PR2/kFizKW8mCWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5168.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 23:15:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 23:15:05 +0000
Message-ID: <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
Date: Tue, 28 Nov 2023 07:14:57 +0800
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:405:1::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: dedc39aa-4b1a-4e48-0946-08dbef9eb0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	33Xi3YrmYWSl3SIergDyrKxmYEjIUPR/LuO56RIZ562af81/GpGEOFs4dPWitqPyFVR8cP/agqQHRrfQFYXhE+GZWUv8tpANYeYf4YGpPe+Bn7JkocSPMad6+H+t1gZsIBBeuAFIdjeNRP8ABOArIIFUIMIda4PTA9RWXrhdrY47GwZLTtjjbg278xPus3OeJcY2RYyHgxDgK2XCQkeMgL1sKOyLTRw8/5ZeQN7NdQ9cLZqr/dY22j08DNf5XBA5EEK/Zy4uR79WYJWj3g++oOG7BH+q56M5pJanx/Xd9YUUcXz5NpBxkI047rj3DCRHB5xaD1onEiexcfULI+CDQrxsAa/pvFzYm5OaYCDPfTUGSDNmT5K+KQbZN32dV7+bxStqkI8+DOuYQ0NO1UiBYmDv1tcMcWm02vXW7TGvQdkZebEtV+6WUPkJJ4T+8Qi7QZpxNyGB+KKVexsjIbg3+ay8AGhwjjQjkoH2E7vGXdMOWQeeu+QqZijc0roQocFvOqZCJMjVhzPoQuE/Ty2r65SGr+H1uIuakfkkWwr+t3oJUJi/uOaZXeBxrYZBxsIQ6gev0FlQM2cilXvFzCJk+/9+5Mnx/WuTgMi6derKWKnR9bmifVVQhGxuMYoi5M+s5qklov2B9IiyH/89EyYqUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(44832011)(5660300002)(2906002)(6666004)(478600001)(6486002)(4326008)(8936002)(8676002)(66476007)(6916009)(66946007)(66556008)(316002)(41300700001)(31696002)(86362001)(31686004)(38100700002)(82960400001)(36756003)(26005)(6506007)(53546011)(83380400001)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0IrOVhTWThaNFZuS3VsRmNNdTh1WENId2JpMFNocjcyTGNoUmFnWXJzRnNa?=
 =?utf-8?B?WXl6RW1QVytlUUJoWnd1ajVIVDNsS3FwZDZqNlJZbjFpNm42RERCSlVMWVdL?=
 =?utf-8?B?MEVQaVE0T2ZyTFlIc0xYQXVGZzA3alVYcXdHK2tleGQ2dGIrcm12VkRjV29T?=
 =?utf-8?B?em1Jb1V1RHR1ditzeXVzNmJHbnlNYkJsQjBHZE83RGxoeDJELzJ0Q1BzOEU5?=
 =?utf-8?B?M0hteFFhdFRWY2lSQ243V0pNNWpHKytWclBhN1h1b0xQL1lrK3RsZXZETVVH?=
 =?utf-8?B?Z1ZOeEIzVGd5b1M4bGo3b3ByNzBVdFVseVF3NEYxVnpVNi9OTGRtcDFuSGRC?=
 =?utf-8?B?d21ENmxwaFhYY2dLeDRZeStGY2VoZjhjUmU4Yy8vdjFYVUdMUHhMR1BNSWI0?=
 =?utf-8?B?Tk42ZHJHMUdHdmxQdDlUaHJIR0xieS9GTDBrOVFWT1FSRFZ1VGYwUDRDY0Ro?=
 =?utf-8?B?ZkcycDdqQlRKbG5palkzZWVBUWRkVVRJa1JrQUx0akk5WlkrT1k3RGVjQmx5?=
 =?utf-8?B?Zk9uckZJZjRmQ0pkcmJOdS82WHM2VlA2cmdLanFNMnpNT2gyOGgycnEvQXpi?=
 =?utf-8?B?OE4wZ25lNmlTemNnYlRTdGlDYW15QTJkU25iRzkxOFVLSXpkSDlSaEsvUDlE?=
 =?utf-8?B?TFMzdytWWGcwN2pYVGd0T0tVRzZMczRQUW9nQWg4VW1oUHU2ZEEwRHA5Q0Jp?=
 =?utf-8?B?Vm1oYVdiUVdjeUdCT002V0t5Y1JPTlpaQ1N6MUMzZFBLc3IvOEVwQ1BXWGcw?=
 =?utf-8?B?UmVwUXl1RkVEWENFUzN2TmxKc0VLUUVGY3cvUmtZcDJGSk12dXd1dkxhOE9o?=
 =?utf-8?B?NGwwNEVaOFNDM1pKaFM3ZEYrbHhidCtjUHFoWC9YT1N3cmJjQ0hPWWxJb3Ju?=
 =?utf-8?B?VmJvbERLVi94bDhDZ2wweFFyTEVhL2Qvbk5MUW9FbHZBZkR0dDJKQUhpbnp4?=
 =?utf-8?B?OXRrQTZJc05CZFBZNnlWL0RFNTVaS0V4NzIvVEY3bXFtODBZcVlydmlxc1Rz?=
 =?utf-8?B?QzNnRmZuSGR1THRud0lQbEQ5czhVSGZtNnd1dWdwdGpSazhmYVd0VWZrdHpm?=
 =?utf-8?B?L21kcUJYWEVtL2lxVjdWT1YrUDlNcC9qeEZkenBOSDVPdzY5Vmppd1A5ZWU4?=
 =?utf-8?B?SDBhdkhxTWRCdVJydUZNUzBseksyNDM4TFI3bVd0WEY4NmRtOUswOVFObko0?=
 =?utf-8?B?R255R21LM2dBVGdES2doL0doK25LK3k3b3FVcHNublhlYzFpWkJtK213MTFh?=
 =?utf-8?B?NFQvUFdzbzVTRWJNMVZ4R2ZjVkM0d1dHVHdxRmw1SkxSWUpXU3I0NGhHaHA5?=
 =?utf-8?B?MkNqSjFWczI2c1NrZUV4VHA3QzFyOWM3cnRpSGlYd1lJTFhCcjZ6bEQ4VWgx?=
 =?utf-8?B?Nkg2N2dsd0pxS2Y1YXF0OUx3eHBqZmtDU01lS0lXVHRQNHJiQnFzOFZ6aWhO?=
 =?utf-8?B?WHNlSFhGYUlQS1QxM1VnUkNQYW1qTlBWZGZIcWFjdjlqQkttUTRyVy9meFZY?=
 =?utf-8?B?UTlQVWtweSs3NW5oVk5Yd3puSFlmR1R4eXd3eU1mcDN4bUZLZWV6Q2ROeDRl?=
 =?utf-8?B?L28rTWJvK3J3Vmg1b2t6NFFpVmV1VmtIR2FKQVhpOHFHWTFweE5RSXJqbitO?=
 =?utf-8?B?azhtOVNPVDZlU2UwbzFRZi9UL3lnRnRxTXVsUXhwbmhrNTkzQkZGbitHWTZI?=
 =?utf-8?B?bWVJSmxla2QyVUszZEJYeDJkS2pLcHRQS1l3bG9MdkxBS2JncjF4VksvenlX?=
 =?utf-8?B?QzUxQXR6c0FsUUJHZ2ZPR21RaGlkSDZCS0lnV2N6SDJIRVkxUC9KckRlcDBC?=
 =?utf-8?B?YnJseWVGNnFCSGtMU0xzUlQrYlZHeGdpd3B2em1JbGRhd2FjcU5pTERER0xt?=
 =?utf-8?B?Z2NTU1k4OEhlbkhzTk4wNXpFaVZ5TWNWbGJKVU0zZGluY09WYTdmZDdiM2o0?=
 =?utf-8?B?b2M5QjhtYkJqVjQ0RW1BcWRFOTN3eW5yUGQxV0Y1SjduTlp1bjdPK2J0VDY3?=
 =?utf-8?B?Nm84U0hyUEZRSDltem0xWjQ2dXVGNUlxNkZnRnN1RUQ3V3VTOEpOakwvTDgw?=
 =?utf-8?B?TnpmNURWUy9tcUlRMTR5RGMyY3Q0QXhmT2F5M29MRysvQXMzODF1VlVvN3Rp?=
 =?utf-8?B?bkRGRkFrY3hQb0FOZTdMKzY2KzZWNHJHek9uZ0U2MDUvdi9xa2VLTXAwdUFX?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedc39aa-4b1a-4e48-0946-08dbef9eb0b8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:15:05.5426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0QqdzolIgB+WqL0gp1Bm3yqFktLr+Zeu5eja/U08sw+qyobGVnvGz2YC6Bc3hWTdx/0QPHo/wp8MYmsbwsBAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5168

On 27.11.23 22:02, Mauro Salvini wrote:
> Il giorno mar 21 nov 2023 alle ore 01:06 Jan Kiszka
> <jan.kiszka@siemens.com> ha scritto:
>>
>> On 20.11.23 22:23, Mauro S. wrote:
>>> On 13/11/23 18:54, Jan Kiszka wrote:
>>>> On 11.11.23 16:03, Mauro S. wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm using Xenomai 3.2.3 on an Atom x84_64 with a 5.4.255 ipipe kernel.
>>>>>
>>>>> The application I'm running (a complex application, with about 60-70 RT
>>>>> threads) has a simple loop in the main function, something like that:
>>>>>
>>>>> while (stay_in) {
>>>>>      ret = rt_buffer_read(...);  // with 50ms timeout
>>>>>      if(ret) do_something
>>>>> }
>>>>>
>>>>> The main loop reads the buffer to receive some commands from outside,
>>>>> and when the application gets a SIGINT, the custom signal handler simply
>>>>> does "stay_in = false" breaking the main loop, and then the program
>>>>> closes.
>>>>> During normal running, I can see the timer associated to the
>>>>> rt_buffer_read() timeout get fired and reprogrammed, calling multiple
>>>>> times "cat /proc/xenomai/timer/coreclk" e.g.:
>>>>>
>>>>> 0    291/290         2ms970us           -           myapp
>>>>> ...
>>>>> 0    609/608         34ms860us           -           myapp
>>>>>
>>>>> I also see the thread in "w" state (waiting for a resource with timeout)
>>>>> doing "cat cat /proc/xenomai/sched/threads":
>>>>>
>>>>>    0  16328  rt     cobalt     50   21ms279us         w          myapp
>>>>>
>>>>> Sometimes, in a non reproducible way (at least for the moment), when the
>>>>> process get the SIGINT it never exits, remaining in this status:
>>>>>
>>>>> /proc/xenomai/sched/threads:
>>>>>    0  16328  rt     cobalt     50   -             W          flxcore
>>>>>
>>>>> The state becomed "W" (waiting for a resource without timeout) and in
>>>>> fact the remaining timeout is not present in the row, also in
>>>>> /proc/xenomai/timer/coreclk:
>>>>>
>>>>> 0    291609/291362         -           -           myapp
>>>>>
>>>>> (BTW, seems that some timeouts got lost, because scheds are many that
>>>>> shots, and this happens also on other timers in coreclk)
>>>>>
>>>>> This is the backtrace in gdb:
>>>>>
>>>>> #0  0x00007f5b15bb05f7 in cobalt_monitor_enter () from
>>>>> /usr/lib/libcobalt.so.2
>>>>
>>>> This relates to lib/cobalt/internal.c, cobalt_monitor_wait():
>>>>
>>>>          /*
>>>>           * If we got interrupted while trying to re-enter the monitor,
>>>>           * we need to redo. In the meantime, any pending linux signal
>>>>           * has been processed.
>>>>           */
>>>>          if (ret == -EINTR)
>>>>                  ret = cobalt_monitor_enter(mon);
>>>>
>>>> But the problem is that the lock (monitor) is no free. Someone else
>>>> holds it, and your interrupted reader does not proceed.
>>>>
>>>> If you dive into mon at this point via gdb, you may find the owner
>>>> (according to libcobalt's view) when you resolve manually what
>>>> get_monitor_state() does.
>>>>
>>>> Jan
>>>>
>>>
>>> Thank you Jan.
>>>
>>> I rebuilt the Xenomai libraries with debugging symbols enabled.
>>> But when I try to print the mon variable, I get
>>>
>>> (gdb) print mon
>>> $1 = (cobalt_monitor_t *) 0x7f3cb524e62c
>>> (gdb) print *mon
>>> Cannot access memory at address 0x7f3cb524e62c
>>>
>>> Seems that the memory address is not in the core dump, but I'm wondering
>>> why
>>
>> Did you create a core dump or tried to attach live the hung process?
>> Maybe the former was incomplete - for whatever reason.
>>
>> Jan
> 
> Sorry for the delay, but every time I modify something I need to wait
> for the issue to arise.
> 
> I'm working on core dumps. The previous core was incomplete, as you said.
> I needed to set the coredump_filter kernel cmdline argument to 0x7f to
> have the complete coredump.
> 
> Now, I can see also the values into the Xenomai lib memory space:
> 
> (gdb) print *mon
> $8 = {state_offset = 1047984, flags = 1, handle = 44}
> (gdb) print *(struct cobalt_monitor_state *)(cobalt_umm_shared +
> mon->state_offset)
> $9 = {owner = {v = -2147483638}, flags = 0}

This is 0x8000000a, XNSYNCH_FLCLAIM | 10 (see also xnhandle_get_id),
thus 10 is the owner. Unintended recursion?

Jan

> (gdb) print cobalt_current
> $10 = 10
> 
> Could you please tell me how I can figure out who my owner is starting
> from these values?
> I tried to find the owner ID with "thread apply all -q print
> cobalt_current", but nobody has that owner value.
> 
> Thanks in advance, regards
> 

-- 
Siemens AG, Technology
Linux Expert Center

