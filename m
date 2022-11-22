Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B91848
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 10:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFS1YhoH2zbxgbDX4zCwvkJ/RqhvXGa8cbFDpvsp/BEVBFzN+Hw/E3jduRYX3ld93cUV5wfu+QeLl3t+Qmw8cR49K5XO7gQimf//As6y7E6vHP4A9XTWibuVtVMQ3ykLh20QUcEZUEIEVioAkVYBXxaK6PiNsHOvD68HvevMDbkWpY+q1JfspAX9ROn6lCRYVoapYxvZpqqTbK3AqYGmsmxW5SkHmxxO4d9GJxwmfoXXido9FnBCfrTaW2yrzqxyYm9m/r8G9Ft+DVgh89Y2WJKnLAUD5uOASabLOCtFGGU7CxiQpXEWrubOICXrXchYV/o58KDO71Iq/WzuAbKbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gu/Xm0+p4lfcPT4riDcDx8PmgD+zZ4WWMprV2P4JAA=;
 b=lj3Y2QhuJCooZg88aus5eKtUgixLCX8FT27Ah7yyR/AwY63fHOL4YfjRKTuESochsRW+mB1N3V239S4Qg5wdgFWfPAKPZzM4bJp9bKX821kn+rbMyVooLS1XiyE1J6cwuGZLZYqAkCWbj2mRhpuC9e541wqPPNptRt8e0C+/gn3alUIPx8hFwiSfv2/jhDaOwX6Lz4fxtNf80uv701vVgBno/sXf4o11ClJeePVCJvDLETzli606J3SJ7uG1d8N6yqMBEzjHo5MIzZsxD3MO46GlgjPwdmF5W/rVeNsV1d5OIaDLwItYJVh7ofpwBRBgcKRELQ2VOpqsDOJn1VMdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gu/Xm0+p4lfcPT4riDcDx8PmgD+zZ4WWMprV2P4JAA=;
 b=YSzXifr3CJm3DIV8R5D3zdB78aF5SdlTvVyGUD0NICHaS1sigWSa1uMr0VZQ2n8L3xSwxbZZZoHV2JjHkFBD9ViTZt6aZNjQtQtNCCe9VZLcVn4D275FSCgcRGueIQPdYrLvYV62ghSjbBVNEzhOmo9sZTKSC0tr/G/VxOPCcaQmU190wKP0gKpGK+i63+kb0Lx8rfuNZyeHVXZfP7b9CbyrWoNEuFfYUSmuqueVyeBTskDjaZSrXPgrdyhSAvxaFlokW90l25DEl4E2vBTAy9bF01SaPQ0xRVeERVj+hIMdvVtFoQre3/SXtttKg8bYeDioaWSqZZw4N0LRMiYWfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 10:27:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:27:59 +0000
Message-ID: <0d485cdd-62eb-37e0-c60c-826565d957b4@siemens.com>
Date: Tue, 22 Nov 2022 11:27:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: "suspicious RCU usage" in heapcheck driver
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <0835bd39-0dc8-e767-b39d-ee316f6b7ffd@siemens.com>
 <87a64j9zxm.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87a64j9zxm.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 42264131-2618-4d48-6f87-08dacc743a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K9kxYoKgrA03CvW5zkqg1PXWCfqvOy+ch+PvJkbmUVbTNzAUMZ545Q3FZnEFtIH6Im5SXeAV6WcWAVQEBIJ4Xy9R2ZK2pFyfo5T9BX8lOlpPY7kykLHyBnsFpQW/WLZJbASV02+Cvn5aAk2+5/aC4a2FirPOtVjj4b2mZAfqQxXDsLfnfurP03n2pG72iNbum8ypFlwvoWQwP81TU9qLngfIAnGsjSpXxZ46IflCqMquZw76A4Kpx3DSoHXCZXoSxR/Z0si9IJ09oYxWAT9MlHc0W7TreZp7eD9FFzTcn8k3wteNQT6nRdZPGWM8Padxqe7ao3grCQHTH+2q4FSvC30m7gFeb+hFfHA16MMNaCbL6bwgskZzhp07Dv/UE3XEaISe1pg5BeBn52R8HVjy9tafZNFhvbr2W4pT/4T4J7DVzHos1HkJV/FmoikuFIOADIxUp5AIr0I318ZR6Ao5+PfY8KjI4YJu1HQRVo8cUE2a/0fc77uAoZtA0Y+bQvdUW7ykwktAz81uXwB9vR3CmoT7qAKPl0SQLY8PeSsIu7jIBYMIBSCxTu5nVTLMkGErS+qaQQEQ2jJ5NvmOt0OpzxH3vK6FCK2EJzFzEMnp9NdlVsXrBPDYIHbmwwW7iPECw0O/TQ7WSw/Xvh4M2OnsLlZ25pi58wmK2IIKiQI6W9BVGiKNQWTBUyKzyVOTxs6UfBH9agoxSn0i1fC+N8HBsYjVMypT6dMTlxozZYlc9xjDA+Jnz74vtyXPaHMSj/tk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(2906002)(31686004)(2616005)(66946007)(53546011)(41300700001)(36756003)(31696002)(86362001)(66556008)(4326008)(6506007)(6916009)(82960400001)(83380400001)(38100700002)(8936002)(6486002)(8676002)(186003)(66476007)(5660300002)(6512007)(478600001)(44832011)(316002)(966005)(6666004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDJ1UGdaUTFjRXJPV0tFZHZsdjAzSWx6ZXVLY0ZFbjdsMjRhV0tqejYzcmUw?=
 =?utf-8?B?MU9HVWY3ZmNQYTNkZWZBVTJCcDZnRjhWN2ZCL09Jc05ZQVlWeXM4WkV2MHEy?=
 =?utf-8?B?aXgrR1Z1U05TcGhlQVYxTTdVTXR0V1hvbHU3MUV3dU5PTEVEdzZYVDB4UVlm?=
 =?utf-8?B?R1F1ZE9PKzVYaUZiMVdZckxlY3VVTGpuVEx1VVI0RHZOZE0wUkR1L2p6d2hY?=
 =?utf-8?B?eU9YWjFDSjVSOFVwcTlNUW5WcWl0ZllqTWhKLzA4S1M0U0N2dmw4eWNzLzIv?=
 =?utf-8?B?WE82dWxMZjlQOTZVMEhqSFJjaVRRNzdENjFqbXMwODVMMHVkOWxmcU5KUUZD?=
 =?utf-8?B?UGUzZ1NmQ2ZZVysvdU9TLzdUZzRrWExucVZ3NlNaWDRMdEk4dkVHZWxmc1lR?=
 =?utf-8?B?SjVEUUlvcFhyeDFMcjllbTdPdEd4SitBakt2YS9EanFqMzM3WjlYZ3l0a3dG?=
 =?utf-8?B?bUxtZ3JsQVpPZVZvazhwdzRyTHRxREIvUHVTZXBWamJhS1NQNThFOUk5TXA2?=
 =?utf-8?B?VE1UVVZqZUMzdGNGT21WTVhScW12VnU1RnlmOG93SXBxSVBHK09WWm15NS92?=
 =?utf-8?B?MU12NHFGYmZwUnFSSEE4aXFxL1JUUkZSVmF0Q0trVnNaeGpOZXdMeW0xQzRj?=
 =?utf-8?B?S291SUFNT01BYjFpN3BpUmhoYVl5M25uemZ0MFNET2FyeFRKN3JmUGJEdU1m?=
 =?utf-8?B?QnM5aGtxWlpnb1ZGNkROZHBETjZFMTUzSVgrbXk0NUoxSWpoSVdLQTZTYWNy?=
 =?utf-8?B?RnByVGdzbk5SdFI2aC9DLzcwZXZYZzZBbG81VnBXbHFOdlU1WUNwcGIxRUxI?=
 =?utf-8?B?Vkx4cm9IRWJqTlhlM0w4T3BGcnRiYUIzbGRHU3lpa3hnR3QyRkhLRS9SRW8y?=
 =?utf-8?B?aThFYWtlbDVqaS9UVFhFSXNFVk9hazdVbktvMjd3dFdsQmMwdFNmQVNqVzYz?=
 =?utf-8?B?NUZ0RVBUMGw5alEvb0l6bTFwc2daQmZuMFdrVkFGYXg5Y2ZRdG4wampKMDQy?=
 =?utf-8?B?UkM0YnFVQzd1Y2p4SWpJYkxpU1JkT2dFaFUvYTViKzJrQUhrMEJ6SC80Q0xp?=
 =?utf-8?B?cWZnZ3pDVjRJV2pvMjZxMEVtQm85N3VBRWJPQjUxSU1XUlZNM2oxb2hDb3Fl?=
 =?utf-8?B?NXBTOEQ2cEZlanZTVEVzQ3MvNDd6U2owbGtCTXBiOUR5VmJKVHk5QkIwVlFD?=
 =?utf-8?B?SC9TZmhzcnFJR0M1UXRHNVYvSWowSEdlQW9YVy9lSGwvTTJwdUd6RmZxMlkx?=
 =?utf-8?B?NXE4cmxDNEZoaVE5TmlSMUhmNEZ2MjJNMWRvaGtiNFRrbTV2SXdleERrZHZi?=
 =?utf-8?B?bW5BK1JpWjlpVHNIT3FhZEtlOVU0aXIzKy9JRGZXV3c0VWJNL3BuM2hJYldO?=
 =?utf-8?B?VWVJMm9ucStVRVZVWUdzaUpRRUwrNVNzZTVBRVMybEw3Y2dlaXF0d1BUVHIv?=
 =?utf-8?B?OHlxYUJpc21TMEZ6STR2aTJoRjlrUGthTjVVQkI3WnJTOUJvc0JBQ01MNmFL?=
 =?utf-8?B?RkVYUmdTcXJMNlEraDFrVVRLcDAvakIvZWhxUDVXWHJvTWsvR3RxZVI1MG9J?=
 =?utf-8?B?WU02eHNvbVMwcFdSZlNQdjA1Q2QzdVU1K21TdWVGLzc5N3ZpYXZqcnZLYlF0?=
 =?utf-8?B?OHAvYnp2RHdnVjRIRjRhN09SeEVNUzVnRkg3cHBvV3d1TlE1cyt4T3kyRS9V?=
 =?utf-8?B?MG03Z3lkRzBiVnc0bUVSdHFxUU1NS25QNkNDS0J6aDVtVjZMRnhLV1JHOFdw?=
 =?utf-8?B?T1M4Vjh0enNROHhpMSs1bVQxWjMza3ZTNE03VS94MjR6OFRhWDNiR3ZUSmpr?=
 =?utf-8?B?MWhTZElYZTdHbGJMMm1YaXFqYlBKR3NXQTJ6M1NwQ1h1VVlOUG5SUWRpTE1B?=
 =?utf-8?B?dU5HRHh5bXdFS0pGYTRKTUJreUgyZmxSNlJWdTZlUkU5RFRGOHZncWVBZmdW?=
 =?utf-8?B?TThZTXV1d3hlZGI3MHZIZlYvMGhJSjFsMWFKeDVSS0Z0TUZrbjNiTGV1NFNK?=
 =?utf-8?B?T240Y0xWMVNyTDJQMVQvSjJDR1JSblVNYmxYRVlUaXFnSFdadUJJYzV6Rjkz?=
 =?utf-8?B?R2lUYWhYQkh6S3lMd29IVU8wYnJtTjBnbXdPWVlWMWFxKzkvTmFiaUp0MnFm?=
 =?utf-8?B?bFZDb0VaZkpKNUVBZzNjQWY5dnlUNW5RVjVhMFBLZzVHQ09LVXI3OVpKREZF?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42264131-2618-4d48-6f87-08dacc743a6b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 10:27:59.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMotHZDscuOR0UPVb51Wic2bezeLbUw+RxVcrGvMbIqRhMpRGFV+ORxvJKS4EASGTwN5/oo6ZbNcaYwEWMqOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5716

On 22.11.22 09:00, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> while preparing Xenomai for recent kernels, switching prandom_u32 to
>> get_random_u32 [1], I triggered some RCU warning:
>>
>> [  515.060011] =============================
>> [  515.060011] WARNING: suspicious RCU usage
>> [  515.060012] 6.1.0-rc5+ #10 Not tainted
>> [  515.060014] -----------------------------
>> [  515.060014] ../include/linux/rcupdate.h:740 rcu_read_lock() used
>> illegally while idle!
>> [  515.060017]
>> [  515.060017] other info that might help us debug this:
>> [  515.060017]
>> [  515.060017]
>> [  515.060017] rcu_scheduler_active = 2, debug_locks = 1
>> [  515.060019] RCU used illegally from extended quiescent state!
>> [  515.060019] 1 lock held by smokey/1435:
>> [  515.060021]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>> __is_insn_slot_addr+0x5/0x120
>> [  515.060049]
>> [  515.060049] stack backtrace:
>> [  515.060050] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>> [  515.060053] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>> [  515.060054] IRQ stage: Xenomai
>> [  515.060055] Call Trace:
>> [  515.060056]  <TASK>
>> [  515.060058]
>> [  515.060058] =============================
>> [  515.060059] WARNING: suspicious RCU usage
>> [  515.060060] 6.1.0-rc5+ #10 Not tainted
>> [  515.060061] -----------------------------
>> [  515.060061] ../include/linux/rcupdate.h:768 rcu_read_unlock() used
>> illegally while idle!
>> [  515.060063]
>> [  515.060063] other info that might help us debug this:
>> [  515.060063]
>> [  515.060063]
>> [  515.060063] rcu_scheduler_active = 2, debug_locks = 1
>> [  515.060065] RCU used illegally from extended quiescent state!
>> [  515.060065] 2 locks held by smokey/1435:
>> [  515.060067]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>> __is_insn_slot_addr+0x5/0x120
>> [  515.060073]  #1: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
>> __is_insn_slot_addr+0x5/0x120
>> [  515.060078]
>> [  515.060078] stack backtrace:
>> [  515.060078] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
>> [  515.060081] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
>> [  515.060082] IRQ stage: Xenomai
>> [  515.060083] Call Trace:
>> [  515.060084]  <TASK>
>> [  515.060086]  dump_stack_lvl+0x7d/0xb5
>> [  515.060106]  __is_insn_slot_addr+0x10e/0x120
>> [  515.060112]  kernel_text_address+0xbf/0xd0
>> [  515.060126]  __kernel_text_address+0xe/0x40
>> [  515.060129]  show_trace_log_lvl+0x18c/0x3f0
>> [  515.060152]  ? dump_stack_lvl+0x7d/0xb5
>> [  515.060162]  dump_stack_lvl+0x7d/0xb5
>> [  515.060168]  __is_insn_slot_addr+0xd8/0x120
>> [  515.060171]  kernel_text_address+0xbf/0xd0
>> [  515.060176]  __kernel_text_address+0xe/0x40
>> [  515.060179]  show_trace_log_lvl+0x18c/0x3f0
>> [  515.060196]  ? dump_stack_lvl+0x7d/0xb5
>> [  515.060206]  dump_stack_lvl+0x7d/0xb5
>> [  515.060212]  inband_irq_save+0xa/0x30
>> [  515.060215]  get_random_u32+0x2f/0x230
>> [  515.060228]  heapcheck_ioctl+0xa42/0xbb0
>> [  515.060244]  ? ktime_get_mono_fast_ns+0x3b/0xa0
>> [  515.060260]  ? rtdm_fd_ioctl+0xec/0x340
>> [  515.060270]  rtdm_fd_ioctl+0xec/0x340
>> [  515.060284]  ? CoBaLt_fcntl+0x20/0x20
>> [  515.060286]  CoBaLt_ioctl+0xa/0x20
>> [  515.060288]  handle_head_syscall+0x115/0x5c0
>> [  515.060301]  pipeline_syscall+0x85/0x120
>> [  515.060307]  syscall_enter_from_user_mode+0x3f/0xa0
>> [  515.060312]  do_syscall_64+0x15/0xb0
>> [  515.060317]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> From my understanding of the code path we are taking here, it's a non-RT
>> IOCTL that should be fine to take random Linux locks or disable Linux
>> IRQs. But 5.10, 5.15 and 6.1 all complain about being idle here. Any
>> idea where we may confuse lockdep?
> 
> This syscall is processed from the head stage otherwise it would have
> been routed to handle_root_syscall() I believe, so the issue is most
> likely with rcu_is_watching(). There is a fix for this in the linux-evl
> tree [1], still in the -next branch ATM, will be upstreamed soon.
> 
> [1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/03d19b028241d0385ea72e91481d7468d806ffe8
> 

We are coming from head stage, but the caller should have been migrated
to Linux before calling the ioctl_nrt handler. The whole purpose of that
handler is to be able to use Linux services, e.g. vmalloc in this case.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

