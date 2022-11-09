Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B546AB1
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 09:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAwh46iujKG61jTlpbSPwE5TxQVvvjqUxJJh0cYBCkx6yjir0CpYzsSWObmn7XoHDyYj52XCzHoKhZyFXBdO3Pdv8SKvpC/AlfGBDStnw47IgkRuSwTWuL5geZk+0phSBTIJvoFCAlmJxmUtMYvsLQqN4JojmXAahMGlW8+tfL4HrWKN6pvOcJdzI0DlL3kfdXemMpjrHEaZ5CZl3HQbdIfUmYpCVp3qgILy5IPYDhRmxH+uVSTGuWqvHl/far/LD66lH/iqaMARkY5APdKEqh0+UxabZq5li/mJqt+ookEiwYY2geK6nQres3btEcfVOc6kO9m2HcA5SzV44Us5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzpBXAvYz/L2Yeq8lvCmchhVcS2pKj78psFOJrhnvng=;
 b=DKrHKuL+ayccDUZyA1vqSXFtZMu/rG7cQkzs7kc2ZmckDyKFCVVcQ6rmX9xD5E9+nDS62VmyhGaNTj2pmtkwklZAFQ4MvnQzIJkd09G/Je7ud5d0INcGOQJ1rWZJBjOdJLGvu+YWWoEQn75XPD2hCuRNWb86NhS17hobKjeygI1z4dxeoYah4nW5dllNqFgvmg6Hd2hWSOQQOUoE98mVIhriC0gXjID7lktDeiUAeeVyNC02jwcmLVp77/JVJi6AvmgJ3KfAmxm/dVBGs2nBhZCZr+yS/n7OHzkcNwRUb+cTwLUxOoOh7gxnjbXdVyfz5n9nNjRIW3fjERxLluxl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzpBXAvYz/L2Yeq8lvCmchhVcS2pKj78psFOJrhnvng=;
 b=RTyk82FTwSxtkFNW+vxRkMCDxY1T6c16H9qsRWfI/gySse09zBFq3k6msiWUfRxXEqB+lFedPQemnDSh2OwQdS/Pj27mGl1n7NHLaU5yu+5hW9wdpKnsI0cNhAUhuHQzr0R6dsXMpkXl+hfUFR3o4EjrudoGjGpdC6wI1csXPKVHHFibN5W2dUPMNJp1djR47xdv3DBKtjH5lqCDFQ4sm5KseKkXthcBaVrLdLLF3j80f5VQGqlcEixnjs0gvIFVUpdxSZGoSBcv3JbUlYcAFLUiiUTRmuq+Lml3IRCWhkizJYjv6tc2ALG1SiaM/ekHEX5PHdH/jLiURjgncBBYkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 09:29:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 09:29:24 +0000
Message-ID: <83394091-0324-c178-afdd-c48db9c042c2@siemens.com>
Date: Wed, 9 Nov 2022 10:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
 Richard Weinberger <richard@nod.at>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <VE1PR08MB49099ABEC4BF51A6C364269B923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB49099ABEC4BF51A6C364269B923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 81df7af5-2c83-4fa7-89cd-08dac234e3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gj0AXLI92ixnKwr+zFHTzztiishFroIRkZ2Yu80LfLtaI7uXQWRLmKX0XvaGTd1+H5czLCHwjjw2gwk+UWNfxLDcwzygkiZV1yBjP6ceRsYB4F+Ge0dTLuKv+MjWR/I29sLhdqYMOWpcxqrr6TQ4YHdRTupwyYBnV+NvZlM+OztM14I7+VtlDIUU72EDTiZWNSMu3Kueg6o0KQ3KQxd83Es3Lg1q+3xAjm78DCz69za7w8BTnL0HR0kWjyoDlPc04dilEwaMRn3TbroVeUDTdNGZMG4EfUg+pB5TsTTQyqMc2AUGCZyyVu60b2JEEabFjJmE/6ORIoJFTL5oY42X4FY1cwgdxhRSg3AOMu0zJuFuclOwrnddW9w3OQyphJjWgfJbnulMFiNoCO8CQcEmEle9OhOIgPQ9Uj/6dt/HhIQ0vUdWdYaVZMa3HubeCoaxiZbuDAIwQ6waV47DtELN2dLlRrJRzQVaV5neh36bptcDdYZRMuLT5EF8+W5svBD7JOQOIbOYj5WiQ5XT9dcpW80EI08sgXEFF+g4lcnpH4zFaCKLw1iL01PJ1+zWYLe7gc6MA/WjZ0xRinAeNN2EefoM/XPzFGGttjfuWsfTx9wnEgxH82z3lq1hZCRIuBd6JUU6kcJuOPAZ5HxQUAo7iQupn6x74WjwgE/fXH+9b5V0iZUrcQqu/2PAgjvmrSMmJ6Pb2tSDqHxcY9X0e6+MbGW4fiGsM8+trCXf8SkXMllV6OsuUWXDR7CADK4Kllr4M6/JSlM7GJZ8OKr7kwly0qO9kQ2vqZOadBq9fNLH3j4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36756003)(38100700002)(82960400001)(6666004)(6486002)(2906002)(66476007)(478600001)(44832011)(53546011)(66946007)(66556008)(316002)(86362001)(8936002)(41300700001)(5660300002)(8676002)(110136005)(6512007)(83380400001)(2616005)(186003)(31696002)(26005)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RCeXpvdjh2WGNxdnhNMWRiOUtZc0tuc01iNWNDYTB6NUpvWS80Y3BPM1Z3?=
 =?utf-8?B?V1VWQSt6TEczUjdFWU1EUEZ3Q3FjZGMxdC8vRkVTNytHM3VzdWJSbGtuaVpY?=
 =?utf-8?B?V1psOU5SbU44dm40MXh2dTVySitoN1dnYnV6eXZ3SEJ2QzhNbHBWeHFIZDdF?=
 =?utf-8?B?MXZFdkh0eENkK1VoRzd1S2YvWkFuYTJ0TmhROFlGNkUrTHY3clorZDRQRnNJ?=
 =?utf-8?B?bVhpVCsxQ1oyYVV3NnA3elhzVzRseUxVdVJ5dDNQWk1VQnhzcEE2QzIwMmxs?=
 =?utf-8?B?VndLRnZxTGFzRkFXRWo0SzNIc1JieTVKNXNUMmhKN0ZSeTgxeEpEc1dicUJC?=
 =?utf-8?B?b2FocStEZG5xUFpZbmM1Qjgzdm9QZ1l6akIzQW9WOCtmN2toS3V4YzRkY2NP?=
 =?utf-8?B?SXBzYW5jS3NMZUNoNXV5ZVhGNEFrbmxtbzBlMXArVzhJa1FFRHh3WUwyckoz?=
 =?utf-8?B?U3p5ZXpvSGh5Qkphbm52SEdnSGE0UTZVc2pybDdFK1lhQmRmcmZVSTZ6OHVP?=
 =?utf-8?B?U1hlZVFqSlJOb2hqK2tSaWFLclZJUXhvaXBZSG1VVURsOHRSOExETWx0aTM3?=
 =?utf-8?B?WFVvcFlCYWxSWWcrWTdBWFo2cWlITmdpVXBUN3NqdS92bkFKWDdCdmFzSi9s?=
 =?utf-8?B?dXVVYXJaemN0aUNOMkdLU1AvSVlha2lVTzZma2wrOC93eFB2K3dIUm0xRnF6?=
 =?utf-8?B?eDg5N09vNzYxR2hML0dPb2JNeW1rMDNIVmpXUWJ3UmErZDA4bVF2NUY3cmFU?=
 =?utf-8?B?NHl2UTlYdGMyL3BQejBZeTVSbHJrUUN5RDNhaXlUWjIwY0sxUkdYWXZ4R0Vq?=
 =?utf-8?B?K1orbVhrMXF1VzdqTXc3VmxialBmVEdraEhtb1U1WVFRY3FmYk5tWGYzOW5V?=
 =?utf-8?B?ZDJ0UEhFZVpLcTQzNXQvOTVVVTN5WlJUdys1amRORll2UG9rVFJqY0lpcFp1?=
 =?utf-8?B?OHd0UmVvbForNzBmUFlPSGg4aGxoTXdjU2daU3d5VFhXb1g1U21UMGxBWVRM?=
 =?utf-8?B?QnhSREFQdE9EMXRucGovOFZDOVlQb3NMUytIWE9SdHBZSUc1VS9NQXNkZVlV?=
 =?utf-8?B?TTd5dEI1MHlwTG1WUzNyQWw4VU8rdmp0Z1RpcmowZnRrRVRPblVlL2lSMGZW?=
 =?utf-8?B?ZXJKSmhHeDh2eTkzczEvaktFcERmWUZIa0dvOVZrMDFMZW1nM05iM1N6Ymo1?=
 =?utf-8?B?MWdPVW5kdTVxRHo1a1ZPTDJqMUhnMmd1MG4zakhoWGo1TDFoZGFuUTFFbjhy?=
 =?utf-8?B?bGgrTm5KT0RDT3BIYitLeUlFc1k3aXhtbnNyK0xxYWZKajB2dmdYU25NV202?=
 =?utf-8?B?TGw5ZkJ5Skt5a2tFMzhYV20rT2MyUmg0RUdoUnhKOFRxbHlxQ21wVEZRdHJH?=
 =?utf-8?B?RnJDaDJhakFMczE4UEhtV2s2LzJMaTVabEQ5ZldWNGxra2NOQ3B3NGkvbFBv?=
 =?utf-8?B?dHJ6b0R6MTdWejRoT2d5MFlIZUVpWURZQk1IZjY3WmpKcDk0RkZzSlFNclAv?=
 =?utf-8?B?Uy9kUWNUNVBNNXdGbkFFREpVclMzWklCK3Q5R1M0Q0RydktLVTgvWndRT0dW?=
 =?utf-8?B?VDhQbnh5aU81Y0dESzZPbGhBcGNwaVJkbEpmb0tuazhpcDdvVTdndm43SkQ4?=
 =?utf-8?B?dWtOb0xmcEdsNGozWldrdGhPOU52NFBaVVdwOTJkOTNoaVZuNHEwc3pnSVUy?=
 =?utf-8?B?M09kQ3NWM2xZZUUwZHV1NXNQaGR4STMybnUzN2N5WnVzeDQ5akFZb1FZMGNY?=
 =?utf-8?B?Qm5ybTdMdnhwdFFqcFdSbmNlU1E0dWJLWGJ1SktyMy9LTUNHSlBQM1lHOWts?=
 =?utf-8?B?U1dmdWxPRU1SbVkzNFpqRlpOcXNHY1FlVWVkNVVSRTQrbWtUbXFqclFpVzAx?=
 =?utf-8?B?c2hUa00zNy9PT1J4dkk5N084ZWQ2TDdBSWFEUVk4ODRNOVM0UW5RRE11SVUx?=
 =?utf-8?B?NzFTTDRveG9SYXM5NngzWnVJUWNUSlFCQVFOSXNtSUUzUUNCZG54SHE1anhp?=
 =?utf-8?B?TUJrcVlJWmZkTEVwZWhQbHM4aXFvZkhuSjdIbkFDTmZGeUZqNXBwZ21VMzZ4?=
 =?utf-8?B?aUJBT0R4VldxUlRFWDB0cGpHT0xra045Ly9LMkRWK2d6V0d3U1VTUUdhRWc0?=
 =?utf-8?B?VmJBMk1iTUtrcEkvK3JIblFOZy9UdEkrWTNQTkRSbU1icktMQ3lFbk5NRnRG?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81df7af5-2c83-4fa7-89cd-08dac234e3ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:29:24.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxlVYsFuKUqqJrapVgWWQ2YH0DU1Hu+MJjtXO9XkFH/OuqQQgInjCyZ5KPUDUy8PSP5Ql1BBrcpd7NwcgQubBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6919

On 09.11.22 08:36, Johannes Kirchmair wrote:
> Dear Jan
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Freitag, 8. Juli 2022 09:11
>> To: Xenomai <xenomai@lists.linux.dev>; Philippe Gerum <rpm@xenomai.org>;
>> Johannes Kirchmair <johannes.kirchmair@sigmatek.at>; Richard Weinberger
>> <richard@nod.at>
>> Subject: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This allows to skip reporting a trap to Linux when the OOB handler
>> resolved it directly. The handler can signal this condition by returning
>> "true". This feature was present in I-pipe as well.
>>
>> By intention, not all spots of oob_trap_notify are enabled for this.
>> Debug traps are left out as well as asyncpf in kvm - no use cases from
>> OOB-perspective.
>>
>> NOTE: breaks unprepared users, breaks non-x86.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> I'm happy to add non-x86 support as well if the direction is fine.
>>
>> And if we introduce that to dovetail, we will have to add some kernel
>> version checks to Xenomai so that it does the right thing with the right
>> dovetail versions. Feature flags are out of fashion there as far as I
>> understood.
>>
>>  arch/x86/kernel/traps.c  | 38 ++++++++++++++++++++++----------------
>>  arch/x86/mm/fault.c      |  9 ++++++---
>>  include/linux/dovetail.h |  9 +++++----
>>  kernel/dovetail.c        |  9 ++++++---
>>  4 files changed, 39 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> index 3d04a80a1464..daf222f444f4 100644
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -163,10 +163,12 @@ static void show_signal(struct task_struct *tsk, int signr,
>>  }
>>
>>  static __always_inline
>> -void mark_trap_entry(int trapnr, struct pt_regs *regs)
>> +bool mark_trap_entry(int trapnr, struct pt_regs *regs)
>>  {
>> -	oob_trap_notify(trapnr, regs);
>> +	if (oob_trap_notify(trapnr, regs))
>> +		return false;
>>  	hard_cond_local_irq_enable();
>> +	return true;
>>  }
>>
>>  static __always_inline
>> @@ -211,9 +213,8 @@ static void do_error_trap(struct pt_regs *regs, long
>> error_code, char *str,
>>  {
>>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake
>> RCU");
>>
>> -	mark_trap_entry(trapnr, regs);
>> -
>> -	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
>> +	if (mark_trap_entry(trapnr, regs) &&
>> +	    notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
>>  			NOTIFY_STOP) {
>>  		cond_local_irq_enable(regs);
>>  		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
>> @@ -375,10 +376,12 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
>>  		return;
>>
>>  	state = irqentry_enter(regs);
>> -	mark_trap_entry(X86_TRAP_UD, regs);
>> +	if (!mark_trap_entry(X86_TRAP_UD, regs))
>> +		goto mark_exit;
>>  	instrumentation_begin();
>>  	handle_invalid_op(regs);
>>  	instrumentation_end();
>> +mark_exit:
>>  	mark_trap_exit(X86_TRAP_UD, regs);
>>  	irqentry_exit(regs, state);
>>  }
>> @@ -411,7 +414,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
>>  {
>>  	char *str = "alignment check";
>>
>> -	mark_trap_entry(X86_TRAP_AC, regs);
>> +	if (!mark_trap_entry(X86_TRAP_AC, regs))
>> +		goto mark_exit;
>>
>>  	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) ==
>> NOTIFY_STOP)
>>  		goto mark_exit;
>> @@ -595,7 +599,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
>>
>>  DEFINE_IDTENTRY(exc_bounds)
>>  {
>> -	mark_trap_entry(X86_TRAP_BR, regs);
>> +	if (!mark_trap_entry(X86_TRAP_BR, regs))
>> +		goto out;
>>
>>  	if (notify_die(DIE_TRAP, "bounds", regs, 0,
>>  			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
>> @@ -806,7 +811,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>>  		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
>>  			goto exit;
>>
>> -		mark_trap_entry(X86_TRAP_GP, regs);
>> +		if (!mark_trap_entry(X86_TRAP_GP, regs))
>> +			goto mark_exit;
>>  		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
>>  		goto mark_exit;
>>  	}
>> @@ -1273,7 +1279,8 @@ static void math_error(struct pt_regs *regs, int trapnr)
>>  		if (fixup_exception(regs, trapnr, 0, 0))
>>  			goto exit;
>>
>> -		mark_trap_entry(trapnr, regs);
>> +		if (!mark_trap_entry(trapnr, regs))
>> +			goto mark_exit;
>>  		task->thread.error_code = 0;
>>  		task->thread.trap_nr = trapnr;
>>
>> @@ -1300,10 +1307,9 @@ static void math_error(struct pt_regs *regs, int trapnr)
>>  	if (fixup_vdso_exception(regs, trapnr, 0, 0))
>>  		goto exit;
>>
>> -	mark_trap_entry(trapnr, regs);
>> -
>> -	force_sig_fault(SIGFPE, si_code,
>> -			(void __user *)uprobe_get_trap_addr(regs));
>> +	if (mark_trap_entry(trapnr, regs))
>> +		force_sig_fault(SIGFPE, si_code,
>> +				(void __user *)uprobe_get_trap_addr(regs));
>>  mark_exit:
>>  	mark_trap_exit(trapnr, regs);
>>  exit:
>> @@ -1416,8 +1422,8 @@ DEFINE_IDTENTRY(exc_device_not_available)
>>  		 * to kill the task than getting stuck in a never-ending
>>  		 * loop of #NM faults.
>>  		 */
>> -		mark_trap_entry(X86_TRAP_NM, regs);
>> -		die("unexpected #NM exception", regs, 0);
>> +		if (mark_trap_entry(X86_TRAP_NM, regs))
>> +			die("unexpected #NM exception", regs, 0);
>>  		mark_trap_exit(X86_TRAP_NM, regs);
>>  	}
>>  }
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 834a6edd0be5..1cffd321878f 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -650,7 +650,8 @@ page_fault_oops(struct pt_regs *regs, unsigned long
>> error_code,
>>  	 * Do not bother unwinding the notification context on
>>  	 * CPU/firmware/kernel bug.
>>  	 */
>> -	oob_trap_notify(X86_TRAP_PF, regs);
>> +	if (oob_trap_notify(X86_TRAP_PF, regs))
>> +		return;
>>
>>  #ifdef CONFIG_VMAP_STACK
>>  	/*
>> @@ -890,7 +891,8 @@ __bad_area_nosemaphore(struct pt_regs *regs,
>> unsigned long error_code,
>>  	if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
>>  		return;
>>
>> -	oob_trap_notify(X86_TRAP_PF, regs);
>> +	if (oob_trap_notify(X86_TRAP_PF, regs))
>> +		return;
>>
>>  	if (likely(show_unhandled_signals))
>>  		show_signal_msg(regs, error_code, address, tsk);
>> @@ -1363,7 +1365,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>>  	 * event, so that it might switch current to in-band mode if
>>  	 * need be.
>>  	 */
>> -	oob_trap_notify(X86_TRAP_PF, regs);
>> +	if (oob_trap_notify(X86_TRAP_PF, regs))
>> +		return;
>>
>>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>>
>> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
>> index 6a244a44ab1f..4bd27531f9e5 100644
>> --- a/include/linux/dovetail.h
>> +++ b/include/linux/dovetail.h
>> @@ -58,14 +58,15 @@ void inband_task_init(struct task_struct *p);
>>
>>  int pipeline_syscall(unsigned int nr, struct pt_regs *regs);
>>
>> -void __oob_trap_notify(unsigned int exception,
>> +bool __oob_trap_notify(unsigned int exception,
>>  		       struct pt_regs *regs);
>>
>> -static __always_inline void oob_trap_notify(unsigned int exception,
>> +static __always_inline bool oob_trap_notify(unsigned int exception,
>>  					struct pt_regs *regs)
>>  {
>>  	if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
>> -		__oob_trap_notify(exception, regs);
>> +		return __oob_trap_notify(exception, regs);
>> +	return false;
>>  }
>>
>>  void __oob_trap_unwind(unsigned int exception,
>> @@ -248,7 +249,7 @@ static inline void arch_dovetail_exec_prepare(void)
>>   * Keep the trap helpers as macros, we might not be able to resolve
>>   * trap numbers if CONFIG_DOVETAIL is off.
>>   */
>> -#define oob_trap_notify(__exception, __regs)	do { } while (0)
>> +#define oob_trap_notify(__exception, __regs)	false
>>  #define oob_trap_unwind(__exception, __regs)	do { } while (0)
>>
>>  static inline
>> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
>> index 79fd75918b37..167dc61dbcce 100644
>> --- a/kernel/dovetail.c
>> +++ b/kernel/dovetail.c
>> @@ -254,14 +254,16 @@ int pipeline_syscall(unsigned int nr, struct pt_regs
>> *regs)
>>  	return 0; /* pass syscall down to the in-band dispatcher. */
>>  }
>>
>> -void __weak handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>> +bool __weak handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>>  {
>> +	return false;
>>  }
>>
>> -noinstr void __oob_trap_notify(unsigned int exception,
>> +noinstr bool __oob_trap_notify(unsigned int exception,
>>  			       struct pt_regs *regs)
>>  {
>>  	unsigned long flags;
>> +	bool handled;
> 
> Wouldn’t it be better to have this initialized to false?
> So if dovetail_enabled is false, we don’t return a not well defined value?
> Or do I miss something. 

Yes, this is a bug.

Jan

> 
> Best regards Johannes
> 
>>
>>  	/*
>>  	 * We send a notification about exceptions raised over a
>> @@ -273,10 +275,11 @@ noinstr void __oob_trap_notify(unsigned int exception,
>>  		set_thread_local_flags(_TLF_OOBTRAP);
>>  		flags = hard_local_irq_save();
>>  		instrumentation_begin();
>> -		handle_oob_trap_entry(exception, regs);
>> +		handled = handle_oob_trap_entry(exception, regs);
>>  		instrumentation_end();
>>  		hard_local_irq_restore(flags);
>>  	}
>> +	return handled;
>>  }
>>
>>  void __weak handle_oob_trap_exit(unsigned int trapnr, struct pt_regs *regs)
>> --
>> 2.35.3

-- 
Siemens AG, Technology
Competence Center Embedded Linux

