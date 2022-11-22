Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C11C03
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 11:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW6FZ2fmfElF9yNfy7Hjchew8AgC/TTMWfPoiP5vC/HrRbZgzIL3W1WcEKo6PePaAb/1p+wiCHjvxWiHQRDsf634pvim1iLDa7wwnB+mEsIKaU/nSPH7wBItyY6p8itb48B0D4vByzXBfQsh4fnMNIyklbgAWUW0+LZmyTDXWqAkzReof+EnkVgzfrGd9c3CLP3WNjDFp1JMy0ioGJ1i2SewS2ifcfFPX4hR7EjVLJfDI1w1jvSkqpo/04erayM1XqlgHtC4Gg0O6AcxIdZAE8hp63KZ0Mw6IBDqLQhulQzlqZw1aSB/+dbgUcgBSNyCX4xOhFYS1izBF+YODvi38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+vixl0nG2yo5i1Emtye5/VNIsVs4yxKu1IQOzVPheY=;
 b=jUFFm9NjU+t/m5LAsWrjzIuI1PWA/746PljhQjcTI99E5p1nV+vezSG9LRotkfht//+g9802hoSSx4/bQUXziG2iNBMhgd4E6txEwwz/OLPQESgNlt1eb44jagxajJ6GgOwrfJ8E9QaL03L1cKlBboXiTGf/knAbkvCY+MtsyN3V0awlKhvuoYQlSsQ6GyUaeiXbkyWE77NbHxIiWjdrV4WtdCJwGu0WLZf0Orb+MN9IBwLQ1ygxW91R3d6q/QQtVamhPx7VO6W1iO58a4hMhGBdIHs2O8vcDjCMvEpDs7iky6mygZ5oA1i6i2vEk37Vy85HHlrGyjAH+Q3yorLoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+vixl0nG2yo5i1Emtye5/VNIsVs4yxKu1IQOzVPheY=;
 b=k9jk0SbD7a5LM8uCLkFX6VB0SPwtkoD7sX6H8lhtvu+ozosKrfd7z/QgOhN6PPoDigdegBBAf7w50FcEVX/kJwkFGVLfwjtBp0TEdd1nAzOi49F5M/r1r5G5lzATyIt+ZviaXOdYFP6cwG/2XZjObeEPO/rrno83BnzeDn9dQYPhE46SHWdhBBV+u7T4+/M3itWnl+ymps1BmZbCyLk2o7hiI6yB5AMAX+fKM/ZvqEjZJ98wiliaU5H18e/sgdNWAGIk+px0enRs5dfZthRrehtkDDRbXlbi8a0v6pjOmDwj+V/cliehRRJxw30t/pUOC3y8jmDNUKtx/+MHEfCXgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7527.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 11:55:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:55:37 +0000
Message-ID: <81338678-744a-4ede-875f-d04f8d38255c@siemens.com>
Date: Tue, 22 Nov 2022 12:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: "suspicious RCU usage" in heapcheck driver
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <0835bd39-0dc8-e767-b39d-ee316f6b7ffd@siemens.com>
 <87a64j9zxm.fsf@xenomai.org>
 <0d485cdd-62eb-37e0-c60c-826565d957b4@siemens.com>
 <875yf79stt.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <875yf79stt.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: da4a9fc7-3358-4bbd-f31c-08dacc807886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R5/SJ45kW13+JaefwL2wy/KwZ1BRzFr6tZBDgAEIxg87yGGXIgQX3N1wz5wCq/t1M9zVua6Xhm1excxsyxnIWAdQsKfBxYz+l8o3Ss8iSSNW+m1HeP9H5DfIvk6WK+ikNL0ALrgeAmJngPwHBVdR/CCLoZFLK01XqmomR3SYp8XDNV1EzWrcJD+YcjJ4CPSwv6X7yW9NdxQ5zDmtIvN1+YVzahFgYlQekDegK12lkdT//0snXgamrEbAc8olLzZsDeMVzSRHn9jwz4NqkMkXJYwJoUADx/sDFCQdh+ZNKpdctSmHaiO+8gplG3tX7/bWV4XtkVmxF08kpyPBQrsByKx9gPbPgKDss/0IIYdn87Kz5VjZ/QQF1ZgFzb7ofGJQqvIeSURxC1+8hg1jXuDdrQSxNOwnxkm03G0tt7WxiB96kVRfSAu9KcMxWUI+bhcxefMbW/Q5GjUvHdY65TdIYKl0SQVEHk+MGfpT8VwGAzkgHIz5BYuKRhQCOJCchgyv6bbHr63Yg8Ecs3iesy6VozxZMDU/LXmQLgLl+J1DZ15AJbeJBphL0S1aLZe7RTjqktVKpSAAdEI2+aDIngVRXMgISEJLyAgb/AZ+5486xdqKwlV88CAvLdHobZjfclDmK0MsCZ13X6nGRiT8VXkjmbDUFee+o0JdLh6fgaV76YkmJqSsphlc+Ylmr9/f/mlJ6Xr7pzmgCPTdflk6atv4fMzaU8ajYj6XIjQcyGy7DDmgtsEbwMPWdQy84N6FWqF/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(31686004)(2906002)(83380400001)(82960400001)(86362001)(38100700002)(478600001)(966005)(36756003)(31696002)(316002)(6506007)(2616005)(8936002)(6512007)(44832011)(5660300002)(26005)(6486002)(53546011)(186003)(4326008)(8676002)(66476007)(66946007)(66556008)(6916009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1c2OGhOMUpQdXRJSjFzKzNKRzNPUURTVldHOTVMUnFuampKRDB5a1kwcVA3?=
 =?utf-8?B?Y2J5Tm1yeEhaeE1MMm53OFFma1k3eE5IbzY5N1FIM3FINUdOQWxEZUI1WGRX?=
 =?utf-8?B?NTNpcm42ZGRaWmV4ZlowTWtSaERuOEVmQXI4cWFGSVBOL2I2NS9IdUlkYjNZ?=
 =?utf-8?B?YUxzajNBUGxSSGlyejBlQ0RmVE9zcHFqYW95UTVOMVZjMmFaVW5EdDFMNkF1?=
 =?utf-8?B?eExES3NRdXBheXR1Z2VQU3NOMFVLK0JYUzhsN2NzNjEvOWZ0SjlvODBwTVI4?=
 =?utf-8?B?VzY0TDZpZERFdHh1YXAydGxIeFM1OXhyWWEvS0ZycG5CNit1bWUyejBRZVho?=
 =?utf-8?B?NzRpaHk1bkhpZHpQNUtGNzNSdmxDVU9ZbFk0NDJGQzIyQUZjK1UyaFk2eDJm?=
 =?utf-8?B?MHVCWU1VdFRDMjNrNUxTQ2haYldNQ1pvVHczdnRYN3I3cGF4MkRJU3BRZy9O?=
 =?utf-8?B?UWNJdDB6K1RTNStaeFBraWpjWFdkR29FSnN4Sm94Z0xpUktQdlJoOHZ1WTJS?=
 =?utf-8?B?emNRN2FLWlVZRytnTkYyNGhwTGQzc1loM2VmakRyTXVyT3EvVEFuR2EyV0Na?=
 =?utf-8?B?YnZGMSt4a3Q2endIZFBWbEJvVU43ZEJBNXQvTlltT21tSUJTRW4yM2hOeXRR?=
 =?utf-8?B?OTd5eGcxc1kwK0lVelp5OTYrRjRBWTZMZmdNdDQzYmFrNCtVeExaSGNROTNy?=
 =?utf-8?B?NUhPNDZOTHBUVkI0R2MzTVlpR21XQlRPdGlXREQ0Kzl5aWtkSGt3TDhSN0Js?=
 =?utf-8?B?ai9laTJzR0haZlp2UHoxNFlDakdseUR6TVdLZHpkSnU4Vy8zZFFmb2Vnbkxs?=
 =?utf-8?B?anpWK2tJRVIybGs2U3F1eHNMSVUzSC9iblZONVlCcFFaSm1oRlNkaFkzUnhJ?=
 =?utf-8?B?ZHZrbUIxTi9GRWRtTWFIZEM1cjBsd2tOTkZlRmIrZ1dDenl3QkR2TE0wS2kv?=
 =?utf-8?B?Uk9OMVlHTTFsdUJMQnBJMUczc2M5aGF2ZERFT3V0bEpCVmdmbXRGaWREOWJm?=
 =?utf-8?B?UlAvQVpRYmhOT2liSndtcFpIVmdiQkJXSnNOWGhqUkdBaTRBUGFrS1FGRzZi?=
 =?utf-8?B?NUhQRVdRVlVaWFkzUFdhaHJkVC9IRHd6RFNKR092aFh4YWVFTnU4WThnNHRq?=
 =?utf-8?B?NEpNckR6Y0N4VGVOV3ozYVUvS1pJSkEwQkNsTWFuRWV0cFVNWkpLM2JmS2FE?=
 =?utf-8?B?bTVvZHZ0NGtoRnd2citzbzJIS3hEbngrZ2pWckU1MTZoajNPczhJaS9zSEFR?=
 =?utf-8?B?K1p0K2pCTjErcmx6WWs5WWVkVG5GejhvZUtpU1AvTS9qdEs5bHBndFZYRzRy?=
 =?utf-8?B?UE8wQ05EWWE4cDdrNXAxWTRydXBxQmRRRW9IS3RsNHl5ZElVL2l4N2V3QTNp?=
 =?utf-8?B?bW5aR2JxUzcxVWJpSW96Vkh5VXc2S1IwNFBGb1FLM2NubHNKYnd1U3RaejRh?=
 =?utf-8?B?UHBHSTgzQWdKYXIrOGJVQk1pc01oMzFIOEhJWlc4NU9FdHAxS0R1S3N1Sm5F?=
 =?utf-8?B?c1VpV2ZVRmY5ZUkzeEJSUmdZaytreHMrSDNlSHMwYjhjbTc5eU5wRlZ6Y2NC?=
 =?utf-8?B?ZjZ3SjhHak9jQktzQ1BUV1pNSmxQKzdVMFUxN0NNY1g1ZHhkNFpBVVVOaXZ0?=
 =?utf-8?B?R24yRDRsanZscEx3M2RDV1NNcnhhVEVVc1dnckVCWm5xWGFGd1Fnb1NjbDVV?=
 =?utf-8?B?N1JlcW8wckhyQUxUMGFsbEFNcTkvRERiem1Yb05kNlc0cVRIdTdxSnNPWG1p?=
 =?utf-8?B?Um9wVklFZjZ5RGx5bWVSVXhzUFFPY0lSZ2lDZ3ZnclplU0pLRC9ZbFkzMHJ3?=
 =?utf-8?B?LzE3a3FTMUwzV3RXTDN5clljTUxsaHo3QUswNExSVUlpYnNYbzBEQ21udEFu?=
 =?utf-8?B?ekN4L1ZEaUZEUWJyYzl1RDNQam1QM0FRWWlzSHhad3BtMUtmeWFVQTNubDZ2?=
 =?utf-8?B?LzNtc0drZFBlQnNoMjVUZGUxWmhlWE5BbFdkYnhtRnEzMW83STBUOUIrNmo4?=
 =?utf-8?B?eC9JdkQrTi9vejFVOGRLRC9walBqaWRrclFuQzhGVzd4YjE3MnF2OGVjWGdy?=
 =?utf-8?B?dHhqUWgyOFloTlJRVTFzK0E2TGJtOUpEeUlRa2hTSm1rUHJFek9TNGNWS092?=
 =?utf-8?B?RE52T0w1Z3NkUHVMbmZhdE5RQVNmSk1JYWZpdys5c3BkU0hOdHNLZUxKVzQy?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4a9fc7-3358-4bbd-f31c-08dacc807886
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 11:55:37.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFkWFqqJ4YphY93YqhpEnTT5xyJ/UMS4BzcG5JRx5BQ2MkWhM7DEyXjDBi3JD6rQTmXPqMJ8qTAfL/f66y8SXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7527

On 22.11.22 11:38, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 22.11.22 09:00, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi Philippe,
>>>>
>>>> while preparing Xenomai for recent kernels, switching prandom_u32 to
>>>> get_random_u32 [1], I triggered some RCU warning:
>>>>
>>>> [  515.060011] =============================
>>>> [  515.060011] WARNING: suspicious RCU usage
>>>> [  515.060012] 6.1.0-rc5+ #10 Not tainted
>>>> [  515.060014] -----------------------------
>>>> [  515.060014] ../include/linux/rcupdate.h:740 rcu_read_lock() used
>>>> illegally while idle!
>>>> [  515.060017]
>>>> [  515.060017] other info that might help us debug this:
>>>> [  515.060017]
>>>> [  515.060017]
>>>> [  515.060017] rcu_scheduler_active = 2, debug_locks = 1
>>>> [  515.060019] RCU used illegally from extended quiescent state!
>>>> [  515.060019] 1 lock held by smokey/1435:
>>>> [  515.060021]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>>> __is_insn_slot_addr+0x5/0x120
>>>> [  515.060049]
>>>> [  515.060049] stack backtrace:
>>>> [  515.060050] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>>>> [  515.060053] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>>>> [  515.060054] IRQ stage: Xenomai
>>>> [  515.060055] Call Trace:
>>>> [  515.060056]  <TASK>
>>>> [  515.060058]
>>>> [  515.060058] =============================
>>>> [  515.060059] WARNING: suspicious RCU usage
>>>> [  515.060060] 6.1.0-rc5+ #10 Not tainted
>>>> [  515.060061] -----------------------------
>>>> [  515.060061] ../include/linux/rcupdate.h:768 rcu_read_unlock() used
>>>> illegally while idle!
>>>> [  515.060063]
>>>> [  515.060063] other info that might help us debug this:
>>>> [  515.060063]
>>>> [  515.060063]
>>>> [  515.060063] rcu_scheduler_active = 2, debug_locks = 1
>>>> [  515.060065] RCU used illegally from extended quiescent state!
>>>> [  515.060065] 2 locks held by smokey/1435:
>>>> [  515.060067]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>>> __is_insn_slot_addr+0x5/0x120
>>>> [  515.060073]  #1: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>>>> __is_insn_slot_addr+0x5/0x120
>>>> [  515.060078]
>>>> [  515.060078] stack backtrace:
>>>> [  515.060078] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>>>> [  515.060081] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>>>> [  515.060082] IRQ stage: Xenomai
>>>> [  515.060083] Call Trace:
>>>> [  515.060084]  <TASK>
>>>> [  515.060086]  dump_stack_lvl+0x7d/0xb5
>>>> [  515.060106]  __is_insn_slot_addr+0x10e/0x120
>>>> [  515.060112]  kernel_text_address+0xbf/0xd0
>>>> [  515.060126]  __kernel_text_address+0xe/0x40
>>>> [  515.060129]  show_trace_log_lvl+0x18c/0x3f0
>>>> [  515.060152]  ? dump_stack_lvl+0x7d/0xb5
>>>> [  515.060162]  dump_stack_lvl+0x7d/0xb5
>>>> [  515.060168]  __is_insn_slot_addr+0xd8/0x120
>>>> [  515.060171]  kernel_text_address+0xbf/0xd0
>>>> [  515.060176]  __kernel_text_address+0xe/0x40
>>>> [  515.060179]  show_trace_log_lvl+0x18c/0x3f0
>>>> [  515.060196]  ? dump_stack_lvl+0x7d/0xb5
>>>> [  515.060206]  dump_stack_lvl+0x7d/0xb5
>>>> [  515.060212]  inband_irq_save+0xa/0x30
>>>> [  515.060215]  get_random_u32+0x2f/0x230
>>>> [  515.060228]  heapcheck_ioctl+0xa42/0xbb0
>>>> [  515.060244]  ? ktime_get_mono_fast_ns+0x3b/0xa0
>>>> [  515.060260]  ? rtdm_fd_ioctl+0xec/0x340
>>>> [  515.060270]  rtdm_fd_ioctl+0xec/0x340
>>>> [  515.060284]  ? CoBaLt_fcntl+0x20/0x20
>>>> [  515.060286]  CoBaLt_ioctl+0xa/0x20
>>>> [  515.060288]  handle_head_syscall+0x115/0x5c0
>>>> [  515.060301]  pipeline_syscall+0x85/0x120
>>>> [  515.060307]  syscall_enter_from_user_mode+0x3f/0xa0
>>>> [  515.060312]  do_syscall_64+0x15/0xb0
>>>> [  515.060317]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>
>>>> From my understanding of the code path we are taking here, it's a non-RT
>>>> IOCTL that should be fine to take random Linux locks or disable Linux
>>>> IRQs. But 5.10, 5.15 and 6.1 all complain about being idle here. Any
>>>> idea where we may confuse lockdep?
>>>
>>> This syscall is processed from the head stage otherwise it would have
>>> been routed to handle_root_syscall() I believe, so the issue is most
>>> likely with rcu_is_watching(). There is a fix for this in the linux-evl
>>> tree [1], still in the -next branch ATM, will be upstreamed soon.
>>>
>>> [1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/03d19b028241d0385ea72e91481d7468d806ffe8
>>>
>>
>> We are coming from head stage, but the caller should have been migrated
>> to Linux before calling the ioctl_nrt handler. The whole purpose of
>> that
> 
>> [  515.060082] IRQ stage: Xenomai
> 
> As a matter of fact, the core thinks that rtdm_fd_ioctl() did not relax.
> 

Indeed! Just confirmed with a WARN_ON_ONCE(running_oob()). Then we have
a different issue. Debugging that one.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

