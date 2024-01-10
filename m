Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346CDDA2
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F0vZ2Ll/"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id CD320240006;
	Wed, 10 Jan 2024 04:44:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20601.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::601])
	by spool.mail.gandi.net (Postfix) with ESMTPS id A115DD8095A;
	Wed, 10 Jan 2024 04:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi1tIJchFUyrUg1/oSsVu8GuEV2OrQBRLYtKfwsb7Vh+nCHv3P9iRPfZ2BciOFxt06KequzcVr2eE+v+yP0JKGZRzBBl1nCk4E6hy2HwD4m5fDh3NJ0h+O6GO+QX+XsQeXHcpmptq4Hb3t9Tl7KOhZKzwtwjkNbvwfkm2aW4aVoxFbpdlgo5ZRySSu7niskFsmzL5y/pPsMiAS6yIJUecKMvTF9v8Mp8na3qiR4mAErKpT5JVBHDdd8gv9ZCGWgn+B/kdTaFT4MOMT+wjvtliXOiwC8IGNOXWJjoBxKKuE0cDXTYYUHYuPHSISQtETKIoCYhDlT4Ti7iNjISRzdXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgXfZEGtI8Svo1Umdg8wGsk8p5Bt46OY3VCyYNLCS1s=;
 b=Xs5I0r/R305fwF7dH1qQofmLZ3w7MpaBwsrHR1n2Gw7ARSj6ntdTYQHdN0MwA91PTLCbS7d3edIQaiMkx5z+cRKZ+8o8TQdr9+Y3NyfsEv1SPKQ2S49lkqONM+wMUAdVagKs7MKUI2r+zO8UJC13U/7QPG8zIIrZasFNIGNLgaNqVvHOU4Tflv9O4eSIN+hM2K8G/NGbWSlK/9/c1J02ISTV/9snuSVDgGfpNy2cmOSKGfbpXzBeZ4ROYmHBZuwM5WwuaHK/ptODnVosUUKpHy80d6TEZct/oQkTBSOdOUmAZYmkcTMAKRaYlVvcD/03v2e/PFoTJDH8DofSIaOzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgXfZEGtI8Svo1Umdg8wGsk8p5Bt46OY3VCyYNLCS1s=;
 b=F0vZ2Ll/coSD2C+hfprZhTu06/BH9ko/Y9aKH/aETnvAJ8kmzdVr5twAnzQQYuPR6NBpw94TzgJKYK8YqtS/WSFTuqD0MJd6kdKZtPHlmPY9WsBDmNrueVgVi0uhiqR6xNb5HnXw84i8mEj18HWXompmVuikqLiyUflPV+ZPKmNm4XvrvrQjtIG2Ai837UI2XfJTO5aGlo74eEb96bZamaFsUzkg5k/NeQ03GC44lf4F56+17rHh4wXdvgapjOIw2oAE8wPKN42E9ghFIuCv/ZkXfLY0VLzbitgMY8pnp9JWbBshLWfnj9MNRVHNTMpIahShPMd6N6t6UPUk35DCwQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 04:44:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 04:43:59 +0000
Message-ID: <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
Date: Wed, 10 Jan 2024 05:43:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: linz <powertree@163.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>,
 Philippe Gerum <rpm@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
In-Reply-To: <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e9c762-3e1c-4935-03a5-08dc1196c2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	27FB/F2Y3+SvH9BKWSREIm6GwTNVst6Fe3/CvV3UPf4Gs/aPlPOOyMqlQTHiL6aLXpNRFfjUXRd0MgiWjYfXk1syFYEFkl1MTwheBnah64Xr/OdaJF7JaF345JyPneBks+b/148kSwer/aENLocmPd9GQb3cSPP5W8ezpnmkGjYWJxcO8p1WIH5wqCk5JjSepj8IUY5Sgcc3vALpwkAzPAEbGaBfHhwe2A8qhnKr/yNVyUPKy3h/bspQmYkDvm+gLPbdtMa66Au4dUfV+AUIk+SYtDXniaPY1vMgb3Mxb/gu6zEW2orx9A1+WoqDQJf/YefpQhyhr+6tqSq0ufrSJJZ5R+wOnK1UWkFZjN2hvev4ypG+ofCsXHLMMJGSyD+NLe2qhhPJOZat7V5nANIglQfZjiNp9jkIJiD0RR8rDDt9gr+7VYnPvOuNA88aFr1iqfh2ha2ss3r1FKpK1gdEogCB6s4eemnkJiudXOd1HdgR68OJLZ+jV3cvgl6E03tbgyUSbluB7drrTRCCbXVTazu0mL70r3lErs9jXIhtIx/smo2eDw7Jh7hsz+OCBmW1AO7uXem6oa0XeKu98yineR+lTBxBuvC52Kfk7b86CqABURWpPKwfnXDGf0kNglZ573y+aT0llYeBSByLMb12WAztPgEncNUgATmlYdjoRZ+1RfgGiPQC0Cj2X00ZIvnA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(6506007)(26005)(53546011)(2616005)(6486002)(6512007)(478600001)(83380400001)(2906002)(5660300002)(41300700001)(66556008)(316002)(110136005)(66946007)(44832011)(8676002)(8936002)(66476007)(38100700002)(82960400001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjNxbUQwcjBmNWYvQjV1Qk9lZ1RFSElNeURld0crd0JsWGdxT000dndubTNw?=
 =?utf-8?B?S1gzeHd3NVh6YmpZMWVPSUVqWlZDMjJ3NHZ1TkxuaCs0Y3NZMkgrY1YrMWRR?=
 =?utf-8?B?L0Fpb1B6cEc5QWJkekZyeUxqZ3J1TVFDSVUzWjVybGQ1TTQ3YUcwRkx2c3ZS?=
 =?utf-8?B?S0ZxR2RuajZBKzZsMGhSR3g5aUdxTndZcXJQUHRwYXo5R1VrN0tnTGpnWCtO?=
 =?utf-8?B?bklaMkFIOUgyajh6MW00L3JkY2pZdHZYUkV6WFFrVUZIWFBndTRua253NjBn?=
 =?utf-8?B?TVpKa2ZFOThZQnE2V3QwbnFEYzUwa3ZqVkVLempleU44WGRmQVFqQ0htdjBZ?=
 =?utf-8?B?bHgwQnBscmRDSlduSlZlbC9OUVFKZkViQWcyc2hjaktBMXUzVVhFK2R5SU5j?=
 =?utf-8?B?TlZOdk9iRVc2M21JRUZqdHRMbXJYK1QrZEMyVmlFa29NM056R0djNU5tNTVN?=
 =?utf-8?B?aUNUWEpPRGN4WU5oUlRmRDVPaEZ6RkRjYU4yZDlTRW9QbUZCNFU4YVR3L1hk?=
 =?utf-8?B?M1ZTWFJsUHMrM21IanQrdFJONEdZUDZWdk4vZEVPWmZ0dWdud2JYMFRBcmlS?=
 =?utf-8?B?SzdKQlhKSWRUNEMrTWlCYVJ4amdzbUR3aG5qMEpjNkRRbklRbHlIK05vdzBa?=
 =?utf-8?B?bDFRSDd1S0I0WVFlWnlMdjhFbCtoUlVWQTZseW5pakJ6YzdYeXZDWDYxeFlH?=
 =?utf-8?B?N2VaRHRwdzRMd1FZWUxYR0JMUmJkRytaSFRydmRTYVEwRTUvRUxjQzlQSi9z?=
 =?utf-8?B?OXBOUHkrTURYQ1RKNEE0SG9IeVZ6UkliVlZJUENCVG9XRkp5Y2FsaHAzT1Rx?=
 =?utf-8?B?NFUvNXI3VzA4a0lRNXNFU1kxWTNkUjJtTEJiUmd5aHVKenZ1SVFLRkJjSHRV?=
 =?utf-8?B?STlrZFBUZTBiemcrNWlMVDFtQzJVRlNIaWVOaDVqOUd0cDhhOTJxK3lpVlNY?=
 =?utf-8?B?dGJteVFHSFdIQllvZHIyZ1Y1L3hUeFRpQU1LWmd4ZkE5QkZldTJzaEVlWTky?=
 =?utf-8?B?TW9iVEo3Y20zK3dwZmlDcXloNHpnTndhVWFFTTNuRGpyQ2txRG9vQ0srL2ZB?=
 =?utf-8?B?L2I5dXpVQXMrdG96MFdoeGNJVEdsSytlWHl0VHR0R1dVY2d3TWNXWjJEZmgv?=
 =?utf-8?B?YWZ5VThXaWE2TDlxc1dCSkxKQ1YxQk14TVZqeWs1bGFSMXZYcFVQcjJadjQ0?=
 =?utf-8?B?RTdZWDMzcVFSTklVLy82Ri9jWVoyb1RWb3VSK3JqM3hueHFBQ0JHSzdHMTRR?=
 =?utf-8?B?b2JNaGVwUWlnSGZWTk11WVVRNHArZTJoTUljZkZIT3JGUG9qMXE2M1B3MjN1?=
 =?utf-8?B?OStlenNkMWYySXRqVldGdEhNL2FZY2tVZHJKRW8vNHd0WFFwdC80dythbzlq?=
 =?utf-8?B?RDNTZFRCK3lDSkdyNEF2aWtyL3NFNEptWFpQYWV0TFQyeWhGNGRXcVBCR3ox?=
 =?utf-8?B?K3pBNHlFOVdrc25aS1pHeXVQTERIK3g5azhkbGRpMHk3eFNHenJxV0ZtbVV0?=
 =?utf-8?B?U0x2R28wdXUyY2cvSXNNalpOMXhNeFZoV0MzcDBiWGcxNm5JWWIyVXNtZGNm?=
 =?utf-8?B?dld5TzY4Z0RMcEw3UG9rSGlLeXY3M081dDlHcDhSTGNTbDJIUUdMYVEweWFi?=
 =?utf-8?B?NkU0aUlnc1RjOW9GR1ZyclliWjBsOXEydi9xVW5VK0JyZ0lnMk5SNFdaTllk?=
 =?utf-8?B?d3ZRbHFxR3RKeXVDQmxBeVZPWUN1Z0RodHNuVXFYRFBOT0hkVk1tc1k3TlY0?=
 =?utf-8?B?SFEvR0pOMGg4amthMVIyZ1R2bkNpSEcwRUxYTWJrd2laNzBCVzFkd29kVXpW?=
 =?utf-8?B?R3VSdEZBKzh3UU9LUEhkU1ltN0htckZCanJ6Vk5DSjZEMWtaK1J1aGwweVk2?=
 =?utf-8?B?ejhEdDhPclNiTDhLdlJ0ODl6dE1pM3dBMDdKcEJHczVWQkN6dGhOUzlxQXJ2?=
 =?utf-8?B?T2Y1T3MwTmY3NzBxZy9HYlZIS0R0aTAwTERFYWtEekdWWDRpVW5lWjJZbGRH?=
 =?utf-8?B?K1M5dTZ0SEJmWEgzb2xEdFZSenI3VnZya3Q3WEhyZDkyN3BHNDRGbS9oRUpu?=
 =?utf-8?B?eDIvblY2OTB3TGFINTBCNjVobWtqRno5cXRCUmxYVmo4ZDN6emhRV2JBYVhP?=
 =?utf-8?B?dkV1U05LbU8zUHFqZzVBSjVkejdQRWFEUXhuOEJ5a3pPcG5icHB3aEd4QXBY?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e9c762-3e1c-4935-03a5-08dc1196c2f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 04:43:59.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5v5bYJ22DqSoy/3rTAhcvqw1xONCNNuwird5fUiRynQ+SGoyt6uWkmcbKnSjDBzE7qPPw7kZ0jxP7Z9khIofrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7136
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="F0vZ2Ll/";
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:2613::601 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

On 09.01.24 10:33, Jan Kiszka wrote:
> On 09.01.24 10:16, linz wrote:
>> Hi, I find a call tracing when I use xenomai v3.2.2 branch and test
>> latency testsuit, the Call trace is as follows
>>
>> [  777.563100] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000000002c0
>> [  777.563101] Mem abort info:
>> [  777.563102]   ESR = 0x96000004
>> [  777.563103]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  777.563104]   SET = 0, FnV = 0
>> [  777.563104]   EA = 0, S1PTW = 0
>> [  777.563105] Data abort info:
>> [  777.563105]   ISV = 0, ISS = 0x00000004
>> [  777.563106]   CM = 0, WnR = 0
>> [  777.563107] user pgtable: 4k pages, 48-bit VAs, pgdp=000000200c513000
>> [  777.563108] [00000000000002c0] pgd=0000000000000000,
>> p4d=0000000000000000
>> [  777.563110] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [  777.563118] CPU: 3 PID: 149 Comm: kworker/u16:2 Not tainted
>> 5.10.153-dovetail3 #2
> 
> Could you check if the issue persists with latest v6.6-dovetail1-rebase?
> Just to avoid that we are missing some fix backports in 5.10.
> 
>> [  777.563119] IRQ stage: Xenomai
>> [  777.563120] Workqueue: efi_rts_wq efi_call_rts
>> [  777.563121] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)
>> [  777.563121] pc : xnthread_relax+0x78/0x1d4
>> [  777.563122] lr : xnthread_relax+0x78/0x1d4
>> [  777.563122] sp : ffff80001001bbf0
>> [  777.563123] x29: ffff80001001bbf0 x28: ffff001f809daa00
>> [  777.563124] x27: ffff001f803426c8 x26: ffff80001001c000
>> [  777.563126] x25: ffff800010018000 x24: ffff0020f6f93008
>> [  777.563127] x23: 0000000080000085 x22: 0000000000000003
>> [  777.563129] x21: ffff001f809daa00 x20: 0000000000000001
>> [  777.563130] x19: 0000000000000000 x18: 0000000000000000
>> [  777.563132] x17: 0000015a8ca44dbc x16: 0000000000000013
>> [  777.563133] x15: ffff800010f892a8 x14: 0000000000000002
>> [  777.563135] x13: 0000000000000043 x12: 0000000000000040
>> [  777.563136] x11: ffff001f804dab58 x10: ffff001f804dab5a
>> [  777.563137] x9 : 00000000000003c0 x8 : 0000000000000000
>> [  777.563139] x7 : 0000000000000000 x6 : 0000000000000001
>> [  777.563140] x5 : ffff0020f6f8ece0 x4 : 0000000000000000
>> [  777.563142] x3 : ffff0020f6f8eae0 x2 : ffff8020e5a57000
>> [  777.563143] x1 : 0000000000000003 x0 : 0000000000000002
>> [  777.563144] Call trace:
>> [  777.563145]  xnthread_relax+0x78/0x1d4
>> [  777.563146]  handle_oob_trap_entry+0x78/0x1b0
>> [  777.563146]  __oob_trap_notify+0x40/0x70
>> [  777.563147]  do_debug_exception+0x170/0x1c4
>> [  777.563147]  el1_dbg+0x34/0x50
>> [  777.563148]  el1_sync_handler+0x9c/0xd0
>> [  777.563148]  el1_sync+0x88/0x140
>> [  777.563149]  __get_cpu_fpsimd_context+0x2c/0x40
>> [  777.563150]  __switch_to+0x20/0x120
>> [  777.563150]  dovetail_context_switch+0x6c/0x130
>> [  777.563151]  pipeline_switch_to+0x10/0x20
>> [  777.563151]  ___xnsched_run+0x174/0x25c
>> [  777.563152]  run_oob_call+0x88/0x174
>> [  777.563153]  handle_irq_pipelined_finish+0x1d8/0x1ec
>> [  777.563153]  handle_irq_pipelined+0x38/0x50
>> [  777.563154]  handle_arch_irq_pipelined+0x10/0x20
>> [  777.563155]  el1_irq+0xdc/0x1c0
>> [  777.563155]  0x203626c4
>> [  777.563156]  0x20361190
>> [  777.563156]  0x203615b4
>> [  777.563156]  0x20361660
>> [  777.563157]  0x20361da0
>> [  777.563157]  0x203609ec
>> [  777.563158]  __efi_rt_asm_wrapper+0x28/0x4c
>> [  777.563159]  efi_call_rts+0x204/0x3d0
>> [  777.563159]  process_one_work+0x1cc/0x350
>> [  777.563160]  worker_thread+0x138/0x46c
>> [  777.563160]  kthread+0x154/0x160
>> [  777.563161]  ret_from_fork+0x10/0x3c
>> [  777.563162] Code: 97ff4dae f000a180 91236000 97ffdde7 (f9416260)
>> [  777.563162] ---[ end trace 5ef18d81e2ade362 ]---
>> [  777.563163] note: kworker/u16:2[149] exited with preempt_count 33554434
>>
>>
>> The reason is when kernel_neon_begin is called, it calls
>> __get_cpu_fpsimd_context. Then xenomai oob interrupt triggers function
>> named __switch_to, which calls  __get_cpu_fpsimd_context again.
>> Calling this function twice in a row will trigger a call trace.
>> The function call relationship is as follows:
>>
>> efi_call_rts
>>   =>__efi_fpsimd_begin

BTW, calling into the firmware on core that is also supposed to do hard
RT is a no-go. PREEMPT-RT turns off EFI runtime services for that
reason. That's another topic, not the core of this issue here, though.

>>     =>kernel_neon_begin
>>       =>get_cpu_fpsimd_context
>>         =>hard_preempt_disable  // disable interrupt
>>         =>__get_cpu_fpsimd_context    // *first call*
>>       =>hard_cond_local_irq_restore  // enable interrupt
>>
>>       handle_arch_irq_pipelined // Latency timer interrupt triggered
>>         =>handle_irq_pipelined_finish
>>           =>irq_exit_pipeline
>>             =>xnsched_run
>>               =>__xnsched_run
>>                 =>pipeline_schedule
>>                   =>run_oob_call
>>                     =>___xnsched_run
>>                       =>pipeline_switch_to
>>                         =>dovetail_context_switch
>>                           =>__switch_to
>>                             =>fpsimd_thread_switch
>>                               =>__get_cpu_fpsimd_context //*second call*
>>
>>
>> The fixed up patch is as follows:
>>
>> From f0cb2b2f3174789eb8348feff6abdc7dbdafc8c4 Mon Sep 17 00:00:00 2001
>> From: zhanglin <powertree@163.com>
>> Date: Tue, 9 Jan 2024 17:08:20 +0800
>> Subject: [PATCH] arm64/fpsimd: fix bug for calling __get_cpu_fpsimd_context
>>  twice in a row when kernel_neon_begin running
>>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 01a4774a2..bc180d0cf 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -44,6 +44,10 @@
>>  #include <asm/traps.h>
>>  #include <asm/virt.h>
>>
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +#include <cobalt/kernel/sched.h>
>> +#endif
>> +
>>  #define FPEXC_IOF    (1 << 0)
>>  #define FPEXC_DZF    (1 << 1)
>>  #define FPEXC_OFF    (1 << 2)
>> @@ -1367,6 +1371,7 @@ void kernel_neon_begin(void)
>>
>>      BUG_ON(!may_use_simd());
>>
>> +    xnsched_lock();
> 
> This would be a laying violation: dovetail has no knowledge of Xenomai,
> and it also serves EVL with a different API. But we will find a fitting
> locking construct here quickly once we understood the issue completely
> (or I - need to spend some calm cycles later).
> 

In addition, your changes make the sections kernel_neon_begin..end
non-interruptible. I'm not sure that this is something desirable. It's
also not what we do on x86 eg. for kernel_fpu_begin..end.

Philippe, is the kernel neon section already interruptible by OOB
scheduling and just the warning about the busy flag misleading here, or
do we still have more todos?

Jan

>>      get_cpu_fpsimd_context(flags);
>>
>>      /* Save unsaved fpsimd state, if any: */
>> @@ -1397,6 +1402,7 @@ void kernel_neon_end(void)
>>          return;
>>
>>      put_cpu_fpsimd_context(flags);
>> +    xnsched_unlock();
>>  }
>>  EXPORT_SYMBOL(kernel_neon_end);
>>
> 
> Jan
> 

-- 
Siemens AG, Technology
Linux Expert Center

