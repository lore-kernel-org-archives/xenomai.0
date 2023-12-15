Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0210783
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J5eFWxlc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfJaCJDSenLieWnGFB4dnTWoGgufBhBxMHb4nbauzQ1+qeER+Mkpb38ZwylUfKFY7ul8/keXxivLCjx7N8d8ETM3JRSR1oyVm9nTJmw/AO6h46dzl3MI1GTwIkjN0DWy192KGwr9GcICHOx79crErjP4tIjABXBtBLGI6MwXHkwI3NtEY7lIr9zyntOWmJ4CGQJbDJkv3d26AEGuCx3qPptsGMfkKOIiYW+I6SvQBwmkZY8PncNdR7tHL6yoYg85BH28qf8flGDAi239M2ZKQU3n9Yxf349b6l7qdHshgtL75aBGXoAr74J9nZDLF5I5FNQUIqLoOoSQ1wQIG3Z75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TcJQfpOAW9jjqjgLOJ8ICoX8mLBRMQzzjgxhivJFgs=;
 b=J5yEgXH7lXIZNfhU/4/PAkmSOcYl8M/PDeb1QI8/w+uF1WVtFqTD5C5em9wWAcP1xmtpx4kBnXBYw603ILBpvO0kXRxwzHXnBk5aIKkktdTSAuS+mvP4kGKJJKE00m/EYDHjHOY+oEAKX4l0v71aQ8ip8ANvbrmXIJl9N36VPQvE9VkVjN8BDGXPU5pX41LGrdC0/hJmLf+r1WvU8De7Q/fbhN/9IMhhqhAErkivqk754H8kGBoIYpHHv4w3O1PFjC5FgtXXs6qunlvn/EszNxtXNAH6izU5PvvV1IcBMGzvgTo38zabzK4dfteVpPEplMihKByEayXJ6PpsusQrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TcJQfpOAW9jjqjgLOJ8ICoX8mLBRMQzzjgxhivJFgs=;
 b=J5eFWxlcsOO0Lm3hyzzniCxdXgxqzNqekF0qEg3jq7y4Iewvt8S+uMHnFEYJK1Ew1CEeWJmfOa20TsjPevJDBHPL41VAlsqIDFvBZs5PBqJiIpMK1ZY67rIEt6a3uFGrTinM+vm5FBNC1pSUGOZFmkdyawWRMo+AJsZyOJJkECDxkjHNBpWfryn2otX2551tQvM8zXGeo7m7IukeP82yRLLtPQD9evSfWG4+gwVSc0PabbST7CQ/tGxqUjXpWWdW7sxfZlVpTuzuYaVS61gVnGTKgKLBm9l/tOtRcBVaXFBQd9cksOBJRRFuGVTuPoOdflgqgAR7jVCMxRaFJZrvtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 06:56:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 06:56:52 +0000
Message-ID: <9f4e5d6b-87f6-41de-ae7d-73771d00ccc7@siemens.com>
Date: Fri, 15 Dec 2023 07:56:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Resolving a livelock between Xenomai 3 application and Linux
 kernel using GDB
Content-Language: en-US
To: "josh.nestor" <josh.nestor@protonmail.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <2eRq8h8p8SWhJ6EnmaVwi0DCGy_pWlWDoNQ5lE_y6bQ09xcwtVzNG5Cg7xc24KX92Dj1nULBDiNT9Gj37p3dHriAYApcqWkmvMVUwP8KjIg=@protonmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2eRq8h8p8SWhJ6EnmaVwi0DCGy_pWlWDoNQ5lE_y6bQ09xcwtVzNG5Cg7xc24KX92Dj1nULBDiNT9Gj37p3dHriAYApcqWkmvMVUwP8KjIg=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 118a8698-297f-441a-1eaf-08dbfd3b0499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RBoyrpKnMk6iTBpU9sHPxzKleQ8D0TERQofregXx5BZferc8bYMN6r//p8DHnpTNiWB9tJY5T29PVl8eV+Ha4+6Nju+lgn5oO051OxELnZI+xYEy1tjqVTg3XHnorcwsDs/2IrnlywIDT8nvTCFpe2ks3vEEwoBlvuQ2M128YmUUs+wk2Wb6Z72i/P0oQ1Wz3CeocpIngUhQIVci8I7alu9RH7Nq6gVvhf4ho0fb9ffU19fLU7jqCvY/fMO8A64aKh1fAvnKaRD1h4tX1NyMkCi0jNjzKBqD0HUltBX2Jxzt7w1TkmESssm7VVmyMTii+LJnoGiQ3IhP4Y//fhXBttdXj88u3O+C1KEEaoQA5rYGKs/2a/y1nEcmb4SGoM/zZmb5U1IaNoIFyQmDi7ZvTBDVw64VxBeSIBcsaiQ9gc8fZxDFt9h9Yub6Ybk355hTwA5R2xWogAYX0JBG+lzw+wIlR/+s4z5sMQaJUAPBrAwir9PJjsFWNCGBrxdGd4M661Fu8uKfEFYzf5Mkdl4sx2hdTGpNITEV32rZPOXwr0ljK6Txh9OOcIk9qwjbXc3AByTiyxeLqG3GmWknAiLu/uv0EvrSs8d6JhajP+jP4wfFi5j6u0oYd0h7H0d0h1DHneoR7ngpLgBWdI7p+3z09A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(36756003)(86362001)(31696002)(82960400001)(38100700002)(41300700001)(44832011)(6486002)(8676002)(8936002)(478600001)(6512007)(53546011)(6506007)(66946007)(110136005)(316002)(31686004)(66476007)(66556008)(2616005)(26005)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ako1TlN0SGVaNW4yMDh6ek1YN2ZHNGZrdWhzb056WVhIUkVRellwVUNvREJO?=
 =?utf-8?B?NDIrS3VLN1JWeXA2Vk9IQWYzbEtiUzZNU1FpR202bjN3Z3Q2Zk9FSys3eTVB?=
 =?utf-8?B?Z2lKVXB2UndTOW1LS212a09UYnFnU05FVVZYSVZOWTZhRUZnWVFTUmNndzh4?=
 =?utf-8?B?OTlnTUJnZFhQTW92d0NDS1JGWWRvc3poYmFCTWlrRzFOYTBZTnd5dWxKU3Rh?=
 =?utf-8?B?VDBDd3FmajdvSWYyaVpBZDYrWGtRcWRsZTk0Nkdhb2hXeTdZbzlscDg0TWov?=
 =?utf-8?B?YW84QlJObW1SckRlcVNYM0h0MWhxd0MrSmFMdmUxdzVrMUJJaG5yT3JZbHZs?=
 =?utf-8?B?aXN6bzI3MHh2OENka1NMYitFb3VHRjNTdGVXTE43VTNUU01pbVdqR2tUdXRi?=
 =?utf-8?B?UmozWlJObWVjKzVWeFppSlVXMmJ5Z0xQNW8xdUVqTDRjbGhiQ0tibGN2REVP?=
 =?utf-8?B?aFFJWXJ2ZTdiMkN3UU1JM3hLYnRGc3lQZ1hjMzRuc2RXM3VhSjBuYUVLTVUx?=
 =?utf-8?B?TUtIRVI3UXdsZzgrQmp5UjRpVlBCKzBYN29JUkZwZ2R4d3B6c3p3WnhKR3dv?=
 =?utf-8?B?QS9BbVVya0I1cmZOM3ZBUGFEeEJOVndIZGxIWWltaGJ1UksyRkJqYXRnMmw3?=
 =?utf-8?B?OHNxL0Q0U054N3NDSlFUMXlLMytqazd4dmNnQ2hUc0V1NWJMV1RmMUpJaWRM?=
 =?utf-8?B?ZlJUbVU1emxlaWIxUk5mMkZ2L0ZrM0poa2pjL2VrYTc5RVZqcDRhbXpuMVhp?=
 =?utf-8?B?VFRVcGhaektZK0FNY2VjU1NOM3Byek1GbVV1MjM5UU1iWmdxZFhDL3JQTzBv?=
 =?utf-8?B?Yng3eStvcDZPelBGZEdJU1dhMzg2S1Erc0hSRnI2MUxEMVdkRTlTSjdzV3BJ?=
 =?utf-8?B?UXdOdVQyWmtWbXlldlBYa1dEc2xnVThxdXpXNERJZFlZTk4zNm5GQW1LUTM4?=
 =?utf-8?B?eDBOOXdFbnVBNG96djY4ejFTZVZHMGVoNWVNQU9rc3FRajlPWUlBd01MOVp4?=
 =?utf-8?B?REpHckp6VzRMSGVLQUlaTThNM3llZW9wUGZ2bWdXMTZjQ0Z5UTJGOHEvRjBy?=
 =?utf-8?B?OXZFcDNVRGxISG5keW5DeWx2d2M3WHBSTlY1S2wrRWN4YzNsSlQxVWVOQVQ1?=
 =?utf-8?B?RGNTZXB6V0l2clFVK2dKOG9vK1diKzZBTU5BNXVvdXdGNTZwL3dXQzFGY3g1?=
 =?utf-8?B?UEN4dENVN3hyVStnWkJFM1ArRUI2b3VlY3B5a1dtdGtndlpqMjI1S0FoeEQ5?=
 =?utf-8?B?d3VKZ0NFRmJNNzVJSnZnRXpvQmlQZU9FNEpUYkNTZTluVERVR05aVkhzNTQx?=
 =?utf-8?B?cDJQcTF0N1pJK3JYWjl2RXVWVFB6OFljaGo5N3dLaGY3dTlpM1ZjUWZxNVI2?=
 =?utf-8?B?blI0WGtmenU4L1VQZnRsQXVBT0ppMUlXalJYdVFuaFJWYTRPUU1SeHJ6WFc1?=
 =?utf-8?B?aFVZQ01xMzlNUlMyZGpOQ0l6RzE1ckVVY0xtVlZsU1RzdmlaZGRnZFkreWtN?=
 =?utf-8?B?dmV3eTFEeHhJRXZrOHlTQmNaNVhFT3BjNWJpSWdyUC8rOVlqWGI2WHcwS09C?=
 =?utf-8?B?T05CNGlHaER6enZFMVNRdHl6Y0lRUGRxMGs1ZXMzUW5jUmhIa1pGYVZkNVpV?=
 =?utf-8?B?T2NzMDFVTlNrN25wTHNjM2FPLzR3WEZBTVF0YXFjbmNTN1RqclR3S1R1Rjhq?=
 =?utf-8?B?UEo2SHlUazRZZzA3R0dEMHkzRGIzZ2pSVldsS2tPanVYbmttcGdJTU1sODZX?=
 =?utf-8?B?Sm1OV0NpVEJ1NmpHa0JTeXNwZ1llaUFQRTlLcnZZU1BrV00renBlZW1LL29K?=
 =?utf-8?B?S2ZqWGRGTytiRU9xZ2FCRGxOanloSzlUdmRUVTRjemFLWVNjWUgxRU5BZzhk?=
 =?utf-8?B?UlR6b2pWQXdsVGFrRllIUThFaUVGdk5NdHZncUl0aVBNNjAvMi85Wmh3aXh0?=
 =?utf-8?B?N3VIaFhTQ1BwSWY2L0dreXJqRDVveGpTSGprVURGYUhlb2tmY2dnR1lqbGp2?=
 =?utf-8?B?WU9Zdk5wcGdTMUhNT0o4UjZaWWNHZTJ6aTRiNEZSQVhYWjZjOFNmTkF1ZVhW?=
 =?utf-8?B?MWQyQTBxcW82K284RnZrRTZiNXJvVHJqWHZ1VEhrSnhxaVFvVTVIWi92dTl5?=
 =?utf-8?B?bk1EaGF3WUorQzhrVW5RSDNuY05XK2orNFlXZ01LNzByS0hFVFIzRHAySjNR?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118a8698-297f-441a-1eaf-08dbfd3b0499
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 06:56:52.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sxeQsAOvz8vVif9tgoJDeqM7PeIUqQtDSVK16dvjKiecYu/aM65atSSNYV4ljqV/OorMNdPbpkxtBb97zkJ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

On 12.12.23 16:07, josh.nestor wrote:
> Dear list,
> 
> Apologies if this post appears twice, it looks like it didn't send the first time.
> 
> I am trying to resolve a livelock issue I'm having between between the Linux kernel and my Xenomai application.
> 
> I am running Xenomai v3.1.1, with Linux 5.4.72, on a Raspberry Pi CM4. The last 2 cores are configured as Xenomai cores. I've enabled debugging symbols on the Linux kernel before compiling. Xenomai is also compiled as part of the kernel rather than a kernel module.
> 
> I have attached a JTAG debugger (Segger J-link) to the Raspberry Pi and used OpenOCD connected with 4 instances of GDB, one for each CPU.
> 
> From the backtrace it looks like it is stuck at ktime_get() on a sequence lock, probably because somewhere in my application a time-related linux syscall such as gettimeofday() is being called somewhere. I've read that this can lead to livelocks as the reader will have a higher priority than the Linux writing thread.
> 
> I'm trying to get a backtrace of Core 2 to try and figure out where this syscall may be called from, however it looks like the debugging symbols are not loaded correctly. I have loaded the debugging symbols for Linux and my application as below, for each of the GDB instances.
> file vmlinux
> lx-symbols
> add-symbol-file my_realtime_application
> 
> Are there any other tricks needed to load the debugging symbols for Xenomai and for my realtime application running under Xenomai? And is there a way I can see where each of the realtime threads in my application are currently?
> 
> I've also attached a copy of the thread info and backtraces below.
> 
> --- Core 0 ---
> (gdb) info threads
>   Id   Target Id         Frame
> * 1    Remote target     cpu_relax () at ./arch/arm64/include/asm/processor.h:247
> (gdb) bt
> #0  cpu_relax () at ./arch/arm64/include/asm/processor.h:247
> #1  __read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:115
> #2  raw_read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:148
> #3  read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:165
> #4  ktime_get () at kernel/time/timekeeping.c:757
> #5  0xffffffc01014e294 in tick_nohz_irq_enter () at kernel/time/tick-sched.c:1257
> #6  tick_irq_enter () at kernel/time/tick-sched.c:1278
> #7  0xffffffc0100d3350 in irq_enter () at kernel/softirq.c:354
> #8  0xffffffc010122a1c in __handle_domain_irq (domain=0x0, hwirq=15, lookup=false, regs=0xffffff80bf984488)
>     at kernel/irq/irqdesc.c:671
> #9  0xffffffc01009e000 in __ipipe_do_IRQ (irq=<optimized out>, cookie=<optimized out>) at arch/arm64/kernel/ipipe.c:212
> #10 0xffffffc0101856c4 in __ipipe_do_sync_stage () at kernel/ipipe/core.c:1702
> #11 0xffffffc0101857d0 in __ipipe_sync_stage () at ./include/linux/ipipe.h:116
> #12 __ipipe_do_sync_pipeline (top=0xffffffc010cfd400 <ipipe_root>) at kernel/ipipe/core.c:977
> #13 0xffffffc010185c80 in __ipipe_sync_pipeline (top=<optimized out>) at ./include/linux/ipipe.h:332
> #14 __ipipe_dispatch_irq (irq=1024, flags=<optimized out>) at kernel/ipipe/core.c:1575
> #15 0xffffffc0100814bc in __ipipe_grab_irq (irq=<optimized out>, regs=0x400) at arch/arm64/kernel/ipipe.c:202
> #16 0xffffffc010081c24 in ipipe_handle_domain_irq (regs=<optimized out>, hwirq=<optimized out>, domain=<optimized out>)
>     at ./arch/arm64/include/asm/ipipe.h:160
> #17 gic_handle_irq (regs=0xffffffc010cfd400 <ipipe_root>) at drivers/irqchip/irq-gic.c:404
> #18 0xffffffc010085e04 in handle_arch_irq_pipelined (regs=<optimized out>) at arch/arm64/kernel/irq.c:43
> #19 0xffffffc0100834c8 in el1_irq () at arch/arm64/kernel/entry.S:696
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb)
> 
> --- Core 1 ---
> (gdb) info threads
>   Id   Target Id         Frame
> * 1    Remote target     cpu_relax () at ./arch/arm64/include/asm/processor.h:247
> (gdb) bt
> #0  cpu_relax () at ./arch/arm64/include/asm/processor.h:247
> #1  __read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:115
> #2  raw_read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:148
> #3  read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:165
> #4  ktime_get () at kernel/time/timekeeping.c:757
> #5  0xffffffc01014e294 in tick_nohz_irq_enter () at kernel/time/tick-sched.c:1257
> #6  tick_irq_enter () at kernel/time/tick-sched.c:1278
> #7  0xffffffc0100d3350 in irq_enter () at kernel/softirq.c:354
> #8  0xffffffc010122a1c in __handle_domain_irq (domain=0x0, hwirq=3, lookup=false, regs=0xffffff80bf99f488)
>     at kernel/irq/irqdesc.c:671
> #9  0xffffffc01009e000 in __ipipe_do_IRQ (irq=<optimized out>, cookie=<optimized out>) at arch/arm64/kernel/ipipe.c:212
> #10 0xffffffc0101856c4 in __ipipe_do_sync_stage () at kernel/ipipe/core.c:1702
> #11 0xffffffc0101857d0 in __ipipe_sync_stage () at ./include/linux/ipipe.h:116
> #12 __ipipe_do_sync_pipeline (top=0xffffffc010cfd400 <ipipe_root>) at kernel/ipipe/core.c:977
> #13 0xffffffc010185aec in dispatch_irq_head (irq=<optimized out>) at kernel/ipipe/core.c:1454
> #14 0xffffffc010185c10 in __ipipe_dispatch_irq (irq=1, flags=<optimized out>) at kernel/ipipe/core.c:1555
> #15 0xffffffc0100814bc in __ipipe_grab_irq (irq=<optimized out>, regs=0x100) at arch/arm64/kernel/ipipe.c:202
> #16 0xffffffc010081c24 in ipipe_handle_domain_irq (regs=<optimized out>, hwirq=<optimized out>, domain=<optimized out>)
>     at ./arch/arm64/include/asm/ipipe.h:160
> #17 gic_handle_irq (regs=0xffffffc010cfd400 <ipipe_root>) at drivers/irqchip/irq-gic.c:404
> #18 0xffffffc010085e04 in handle_arch_irq_pipelined (regs=<optimized out>) at arch/arm64/kernel/irq.c:43
> #19 0xffffffc0100834c8 in el1_irq () at arch/arm64/kernel/entry.S:696
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb)
> 
> --- Core 2 ---
> (gdb) info threads
>   Id   Target Id         Frame
> * 1    Remote target     0x0000007f8722a308 in ?? ()
> (gdb) bt
> #0  0x0000007f8722a308 in ?? ()
> #1  0x000000555c30a678 in ?? ()
> #2  0x97cd1a4acef21b00 in ?? ()
> #3  0x0000000000000000 in ?? ()
> (gdb)
> 
> --- Core 3 ---
> (gdb) info threads
>   Id   Target Id         Frame
> * 1    Remote target     cpu_relax () at ./arch/arm64/include/asm/processor.h:247
> (gdb) bt
> #0  cpu_relax () at ./arch/arm64/include/asm/processor.h:247
> #1  __read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:115
> #2  raw_read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:148
> #3  read_seqcount_begin (s=<optimized out>) at ./include/linux/seqlock.h:165
> #4  ktime_get () at kernel/time/timekeeping.c:757
> #5  0xffffffc01014e294 in tick_nohz_irq_enter () at kernel/time/tick-sched.c:1257
> #6  tick_irq_enter () at kernel/time/tick-sched.c:1278
> #7  0xffffffc0100d3350 in irq_enter () at kernel/softirq.c:354
> #8  0xffffffc010185694 in __ipipe_do_sync_stage () at kernel/ipipe/core.c:1696
> #9  0xffffffc0101857d0 in __ipipe_sync_stage () at ./include/linux/ipipe.h:116
> #10 __ipipe_do_sync_pipeline (top=0xffffffc010cfd400 <ipipe_root>) at kernel/ipipe/core.c:977
> #11 0xffffffc010185aec in dispatch_irq_head (irq=<optimized out>) at kernel/ipipe/core.c:1454
> #12 0xffffffc010185c10 in __ipipe_dispatch_irq (irq=1, flags=<optimized out>) at kernel/ipipe/core.c:1555
> #13 0xffffffc0100814bc in __ipipe_grab_irq (irq=<optimized out>, regs=0x100) at arch/arm64/kernel/ipipe.c:202
> #14 0xffffffc010081c24 in ipipe_handle_domain_irq (regs=<optimized out>, hwirq=<optimized out>, domain=<optimized out>)
>     at ./arch/arm64/include/asm/ipipe.h:160
> #15 gic_handle_irq (regs=0x6d2c59) at drivers/irqchip/irq-gic.c:404
> #16 0xffffffc010085e04 in handle_arch_irq_pipelined (regs=<optimized out>) at arch/arm64/kernel/irq.c:43
> #17 0xffffffc0100834c8 in el1_irq () at arch/arm64/kernel/entry.S:696
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb)
> 

This sounds like the classic mistake: Your application is calling
standard libc gettimeofday, rather than the service provided by Xenomai.
Make sure to use the right wrappings for those services to avoid that
situation because - as you debugged correctly - this will cause
deadlocks (RT thread preempts the kernel while updating the gettimeofday
data and then tries to wait for that update to finish when retrieving
the time).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

