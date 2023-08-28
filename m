Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446D613F
	for <xenomai@lists.linux.dev>; Mon, 28 Aug 2023 12:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyzj1/VMB/5zcLLb8f1kAgEr14ayRrIVftXDbZHsuhQ1RdxlOlPRwRPEI7gAUGTO6F/wVPS1t1E/IhkYHzy2y7gciAL7gBVeUjlVmSBdkn8/TrFFJQZnhnQNgE09nnbqWyetgxGzqa0BX2fdpXkMyekD2CrJBMY/Mg/FHuukRlKNhlDJlldXgKH5PMHXZv+9UDnjy9Yjg4F0X8il0UDtwrDyLhN8nR/SZd15cZvXiXDZIfUZnl7jv4ogfujXKtiKKYSXiQlBjnzJOWHnhOcOy+bfTzSthVmA/0eT0nRoCzBHj9anjBPrKV44N+lfOWkvydkeeF4np2fabsawF8kK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FehITh9EO7VJ/kJTHFlQqU+HH5D2nHu8WgG+oZZ8v1o=;
 b=CyKuVwUCEWL2c426GZghW01PuZwSQyGgSRMczLzpJw+SiufX2Xzqh/uhmsJ0HKmoucILI0VH4WgTLy/u2Zke7+j0qwV6m7/73VjadZ54qP4dAZPfhaekGg1m2NI0wtVh7apTHLAE4zHICDjaiIVEzd2W1mmYAQQ+Pm1xnWsZTyD6P7TkiCer1imq3iP0jfm/rmGZe+HlbwdgK12u7g70sLC4SvIaj65thZo8x1vzbsegfanX3nRhwfu61puHHOD5NlsosBFqCdUHfoA+2LYwsigaiqkW1/oLPSyUFumoNZqJBp33P5eVndbz+p/kK17Zr4vVVlWs0CJhuzc57ZfkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FehITh9EO7VJ/kJTHFlQqU+HH5D2nHu8WgG+oZZ8v1o=;
 b=S2Czhf83IymZHKQHlGgJu73Yr+AFWou6MvjXOYUxa7yqZLHz5bVspgRC8HRgTkwjUU4JwhKiixPCR5RBSM6faQsgGdLNPVjPAaKK7KtkhKEMBVnfEyePu5xFAUghwkySJvCyySF77Wk0d6nhLNG4q/fmTOoWUMw95+b5Od2KB1w8lESANuZM2hQ6hVYs/HS+iM5i5nRReQPvGkvLZZm1lLuvQdLOwyB5PgiyKeBCzON9cViktgdZ75aNhuVg4IXsn2k9to5Jz+HqgjL4r4Bl/SoN6n5xhDopmOzcquk6AsgeQTmiYa+naXTiiqRsCQn0PC/EVpyqsHx2NPUnJjtm5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:33:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:33:21 +0000
Message-ID: <ec37174a-39fe-44c7-82a9-342b95682f81@siemens.com>
Date: Mon, 28 Aug 2023 14:33:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dovetail: Fix undefinstr/break trap handling
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, Clara Kowalsky <clara.kowalsky@siemens.com>
References: <20230825125844.588598-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230825125844.588598-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3857:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fb8147-ba9b-4fdd-2686-08dba7c2f6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Bsl0ws9kN/Hse82q/NtgQTnmeyt6fKAaWiHQ6u0yh78la1915ny2esV3EKNzZV1V7QEKG7Lh/o+dY8+XBcF0moTrJpwWBpmGDs5CqQV8+5GtW3ChFJ5Z0pJS8okc3jMIHs8ylfkjxEmaEooDv04m6rKB3IiWr/X5vs1Ug9FsbexrVClH/Oe8Bimb+2HMLHfEWnYGmkTWWCMlrKh2fb7j/WL44Pz3NsD4XaDlv7INKJ6CHhgFbawZY3Xxc9lmCbTotA5fmMZz9ziOGm4/0b9s2XtxmfItCllGhk/c+RNnnMVb6SfcG9T987lUolyA1ESNKH8HGbqyYzIjvDA2OWmDkjuQro5Z9m8b3H7hV3o5XP5r62YyK9S5J9GUrzyNgrhEweulYbi2u0J40y/53xbOl7prJshO66zqQ+OeK0BkkUJEHegf6rShV9+lnKy6p2i2Cku6sbKuurFnj4m2tcOSUiDL5Dw8YUZF+Zgo0JdmTuWQY2TbK0AJyxHPNAEFb5xMJu7lirE7wFdtuB3BQAmCj4iAV78H04KJn0A6tEKbLf+Go5wLOeWXHhDuja/oj//P6uKEk3H4U9N2q4Cag9FPNCl6zO2MeoXL30DGnqYcdDGm453mLvy2qOKGgMu/dXQCdXgmS9pRwyCdapoZhgrOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(1800799009)(451199024)(186009)(66476007)(31686004)(107886003)(6506007)(6486002)(6666004)(5660300002)(31696002)(36756003)(38100700002)(86362001)(82960400001)(66946007)(41300700001)(53546011)(26005)(83380400001)(478600001)(2906002)(966005)(2616005)(8936002)(44832011)(4326008)(8676002)(66556008)(6512007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDR3cE9mTzNUOWgwVUl4cTViU25sQmZvNWNGU1BvZnNhSE1YUVk5WkNWVm9t?=
 =?utf-8?B?dHB4Vkw2RlVyeGs1UjNPSUNvdGFVcWM3Ynl3a0h5TUFqamxBWDU2RFZlTkZn?=
 =?utf-8?B?K1lVL1F6YkRDaU15UXluTEVWOExtUDhBT2ZuTjNLY2hHYVp6Qno2emphRFUw?=
 =?utf-8?B?SnNJczMxU2NEOGhJRWNtWjRIQjliMEw3ZzVBakc4OXFOeS9GSVhyVVE4dFFB?=
 =?utf-8?B?bGtnUjFiSEFwRU1FOG5XMW40clRTVVFlWFdTOXczWkVtc3NYd3JYM2NjY2s3?=
 =?utf-8?B?emhrYmthSGpLTytyVlJpR2h3bldURndnb0NGazdQZjhESDF6RE4zVmRxTU1y?=
 =?utf-8?B?eUNVTm5zN0dqTzJEeTFHcG83dEtZRTNjYThNYjdsaWVib0lFY2V2VndacHY5?=
 =?utf-8?B?RTdMSEZvekliNWd0bUwzbFRGekZuQmdoUXVNaG1iUTA1ZTJwM1lqNlRzTUMr?=
 =?utf-8?B?WVBEZ09CLzlxaUxTaWY5OHJvM3lYNmhjSG9vK1hJZEtXVDlncVRGTTlaSEV6?=
 =?utf-8?B?K1pFVXRqd09RVzY2dytKTy9xQkFYN3JkSEJoUnBiS0dTcTZTcjVLVXlUbXVo?=
 =?utf-8?B?VHpNMUZUdkxlSWNEWis0bXpnZlUyalljQVJzVVI1NGtPMDlXTVFoam4zS1VZ?=
 =?utf-8?B?eFlXTkR4cHIweStoTFRxRTB6L3Q3dGVFbCtXQUxYSDJHZkcxS1ZlaWNPVzA5?=
 =?utf-8?B?Y25vTGFUYUFpYVJCV2VvN0JrZ2FBRitiN0xUWWtPSkJqbGg4cDBETFhvWDFy?=
 =?utf-8?B?S08vcVU5OVlwV1ZOWGczbkxFK0ZKV2NJRGNTUDZJYVlsSWY1aFJXZVR2NGJX?=
 =?utf-8?B?K1RHakRmRE1yVXcwZUJzVW54dmJkYkhFaWNRVmNLbUxDTEFSMkhUT1V3RklH?=
 =?utf-8?B?Z0s4cUFZL2IxbGF1WTdwakIrQUNZQ1lmVXB6aGRzbTQ3Yk5kNmZVdzRVcW9t?=
 =?utf-8?B?UDRRbXljRnRaRlRoVkQyMys4US9jZlllUUVYNUlXc1R3NDI3dXUwZVBOUkp5?=
 =?utf-8?B?bFdrb3RXaDJYVW50ZHVnR1BxeVJGbzJVV1U0OWhvTVVJYVRCU0FWT2swakxm?=
 =?utf-8?B?WmpGWWdOYWJGNGZsNTRjeW4zb2ZDSTVOSXMwajkzcitXSTNTVmRONHJ3b1ds?=
 =?utf-8?B?cHdjRXZLcG40bWdwUlpkL2EzMVRQd1QrRHprRHZxVm5kVmozYTZFRXlubDhE?=
 =?utf-8?B?ZWZ3OGZSR25ZaVVZWXVqbDhMWmRma1pIWHdlQ2draVYraDlDL05mcG5Mbyti?=
 =?utf-8?B?UU5maXdhOWtTZzdSRDV5T2V4VS9CR1hQUkk2MGxPSUhDYmVrVFJRdi8vWTh2?=
 =?utf-8?B?M1VDcFlQL3dFTjM4ZERLWmNKV3pSZ09XTHErSkxiM1ZIN05hMjlNRHJYZ2JB?=
 =?utf-8?B?TmRZWVVCUTc2Tm5yYStVOWJUMDdISmJBcEoyUk5NZTE1VWcwYm1VS3JjSUhM?=
 =?utf-8?B?Q1lTVUV3Q0plWTJmdzJsRTRRbmJWS2lHdXVqRDNEZ1ludzAzZnJnSWxQNEtz?=
 =?utf-8?B?L3dpU1J3VXdaWXVZaWhndndXNFhndUdEam9LV1Q1c3JrMFdQcC9Qa1BHSC9I?=
 =?utf-8?B?cVEzRmpnTk8rNElRK0VabmpsZzF6M0xrQ2lSUVdOOG9ZVHRwWjNXVzJUVTU0?=
 =?utf-8?B?RnQ0dUplbmh1ditMV25rWWNXeXBJbUtLd3dlM29zMTBoLzJ0SSt6QVkvaXZu?=
 =?utf-8?B?Q2NQV0NWNkNaem1Ga0VLdEM1dWdKRTNPalpsNnowMUt2a2FyQ1RodTVFZUdJ?=
 =?utf-8?B?dTB6Vk9KVXVTM2thL0h6a3pxbnUvWHpqTUFueE5QQ3JCM2xZQ2FoT3BzTEJT?=
 =?utf-8?B?T0pVNGxBMVJDd1RQekNtK01vZTZUWWNYelhrTTJjQW44N1E3NXQ1TEFZbk5o?=
 =?utf-8?B?RVNYelgrN1M5OENZUFV3ZElFWHNHenZUbEdDWHhVQjNpREZNdDZYZEYvNE9v?=
 =?utf-8?B?T21ZOXRIeHl1QnVpQWwrdzc5QnhlYmtZS2Y4b0JHZ21OR1JFYUFub0tSb2xW?=
 =?utf-8?B?MVhSem0zdTNUNkc2bVUvSVJUTXI5QWNXL3JkaWRQRGhqZUROeUk2ZHAwLzVw?=
 =?utf-8?B?Y0lSMllIZUVDVDNCZlExaU1PM0xnU0h0S2FReEJqdnQ0eCtGVlp6ZXdzR0tE?=
 =?utf-8?B?Y0lHSkpTdGxvNllReEhVOVVIZkhCMFVHSGR4VWFPZk50eVFBTzdoY2N1a1F4?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fb8147-ba9b-4fdd-2686-08dba7c2f6c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:33:21.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NXIXDD+DKH99ROh6kb97brfaayW8kb1TMUYqtAQ7FOIhz8AgrlDFTOAUwIayQptUvXjvVln57o3XZoWpxcVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3857

On 25.08.23 14:58, Florian Bezdeka wrote:
> When running an compat RT application on arm64 the break trap is
> handled via the undefined instruction trap.
> 
> A possible call stack looks like this:
> 
> Call trace:
>   handle_inband_event+0x2d0/0x320
>   inband_event_notify+0x28/0x50
>   signal_wake_up_state+0x7c/0xa4
>   complete_signal+0x104/0x2d0
>   __send_signal_locked+0x1d0/0x3e4
>   send_signal_locked+0xf0/0x140
>   force_sig_info_to_task+0xa0/0x164
>   force_sig_fault+0x64/0x94
>   arm64_force_sig_fault+0x48/0x80
>   send_user_sigtrap+0x50/0x8c
>   aarch32_break_handler+0xac/0x1d0
>   do_undefinstr+0x6c/0x360
>   el0_undef+0x4c/0xd0
>   el0t_32_sync_handler+0xd0/0x140
>   el0t_32_sync+0x190/0x194
> 
> The trap is never reported to the companion core at that stage so
> running_oob() in do_undefinstr() will always return true. As the
> following bailout happens before calling the compat breakpoint
> detection (aarch32_break_handler()) debugging the compat 
> application does not work.
> 
> In addition aarch32_break_handler() has to report the trap entry to the
> companion core.
> 
> Reported-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Tested-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 3 +++
>  arch/arm64/kernel/traps.c          | 7 -------
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 32271ed24ef5..ef7ac042a0a6 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -373,7 +373,10 @@ int aarch32_break_handler(struct pt_regs *regs)
>  	if (!bp)
>  		return -EFAULT;
>  
> +	mark_trap_entry(ARM64_TRAP_UNDI, regs);
>  	send_user_sigtrap(TRAP_BRKPT);
> +	mark_trap_exit(ARM64_TRAP_UNDI, regs);
> +
>  	return 0;
>  }
>  NOKPROBE_SYMBOL(aarch32_break_handler);
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cc68be400244..9bf2f309248f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -489,13 +489,6 @@ void arm64_notify_segfault(unsigned long addr)
>  
>  void do_undefinstr(struct pt_regs *regs, unsigned long esr)
>  {
> -	/*
> -	 * If the companion core did not switched us to in-band
> -	 * context, we may assume that it has handled the trap.
> -	 */
> -	if (running_oob())
> -		return;
> -
>  	/* check for AArch32 breakpoint instructions */
>  	if (!aarch32_break_handler(regs))
>  		return;

This is not against v6.5-dovetail-rebase, right? We likely need to start
from the top, then backport to stable.

Also note that this change came in via
https://source.denx.de/Xenomai/linux-dovetail/-/commit/2b2ccdaeb8116727cf4076960d664a3cedff0ac6,
so just dropping it will likely cause problems elsewhere. Should we
rather move that down in the handler?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

