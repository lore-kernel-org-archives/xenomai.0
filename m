Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB0156D1
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 10:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk1kY7RZ4rubcNAaJYXT2BUDlxX00GYasWzy0rxUXpRpQNYggNJ1UUzicpEJ6uRNnolrlneBJ5QTLqQ0u/j7JEcdB0Rwr8Tq0ddvisYICTcMp/zfB7EwXxLOLOXkFxn/4wd63aOkd4DyFfb/rDoR8CNXnGlgplYsw0Dj7mLuukypjJZhu3xdIochiEA4D8KNT3ZL4mgeic0C3q+P+imr73Zr0m90PTYtpkx65y3+VxBpRGlylyyPRQZ/gMVoH4wKDA7QZv0h9eTk2MKiwy9hZZtDXxzKBQMmOQC8BfXgHD2mSv8RU4vg4mXy+cELGceMgs/6saSbZKTF4XheH9O7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84T3aqyppDFPhsCD1ujhhzjAgXFSSq77hdcKYihtp0Q=;
 b=UsPbEsXSkoJ9FRalFIWYERbHbfFu/8tw5+byxAZthTliG6MLT6E96ani8yuIMYCddu7n7sbx3eUUBFuRTC8SdchktdCjsc1GnYL//68KtxKeJII8hm7b0u4kfRoSH+/o4I2nI1fZaV/IjO3t4p3ioJOUDKRkmtfQz2GgJnr8NmV80zqWjjm5TTvtP/jaeQNXPZcvwknZC7s8XoAMjqNFiRzAAcA6QJX1smx9KkcEAQ+5VRhDJHGKAtEbo8VHHC4BAr9ZCHGLrmZgKP9CtmSxxvXYWzkzNFo5vE0nD95lVj77TJt2EKKBnmrEVWrqe6NdL3Vm69UjPqx0RCyhkNLpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84T3aqyppDFPhsCD1ujhhzjAgXFSSq77hdcKYihtp0Q=;
 b=TlBooT1oPYQ1KfxMFuqzJsaCtAK0VopW6+4obtb4tOkV6mcVFO9w3qxptzR+7kGN6f85xfX7k7+lA8CO+GD4SDn1KgODGDL7yaxyPNdXh6WPya0dTEvSBmzOOdYecQHHyj1uWsw9YBed+wA6UfiulKiF4q8BRdeVN0YKxB66BDLnEBxOEvdUzrFpuzBbeI4G4YiOctar7wBZ75i4u7wAakUWRpGlFVFjsvBgpsp8ACe2Q8skv7ODBMcqai8HwgMHubMVcujVRzSujhyospjlqxwWllVj0ASOku2a2ZBOl5EjBU/9d7u/5QdTjhqVyJI6GjlzT06hZfcwdASOXWc3Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 10:33:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 10:33:37 +0000
Message-ID: <b211080f-f66c-48d8-b55c-2ada81e874e1@siemens.com>
Date: Wed, 16 Aug 2023 12:33:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add dovtail signal setup function
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 xenomai@lists.linux.dev
References: <20230816101853.3377721-1-johannes.kirchmair@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230816101853.3377721-1-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: baf78014-188a-48e0-688b-08db9e44404c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 qo6sGpB0f8+MThWj6I5dqYYhwTYx+Zju+EtAnuV+IutQmGt+NwV0MB74W6TvENj6YIxo2yv9ANQ/1ZyrkDD4ActeSnJqLOdwIjqg6fCy+56xFuhcXpBuraEjqMpauj2BEmOmB3U1szSbnpPeklgH7wI81kcSUzoRDEBMrYfMDs7zClx8NAB/0Vi4ZYCb2GebXAz3z9/jl7X7tU0TmZLV5cVOJQUCjRVgsrd+FamKNeVeczAm++dGIMsvmuzyXewUglEoI31KK48180kIyLMPglXDqceYJV5IKScosRtX0T6sOr4C+BIoUJoOJBo4ShmKiojlwXyA5fdtiVhLoOa9kL4+3CYtyhAN8f7u0coWP7Lto+ZmXC8wSAWaLk5ochhZqN+JUeIL5wVDY0CMOlX++puEnceDt0uwglm3gw1mLBXO/LYhu6RBh2LZ40be/LPAO5pZN8XXMcBq2KV9oi7BEJtUvcBp0+rKDAABmUElBs2ZXcIhdu9Qy0XS49W1Qgoc8busAFCaQa7Z43IZq2bK5YjKw0gFehkLm0ETiqtGjUdvWMHUTaFT/TcaQYgm1BAI+lhScbyzFZ6ZYjZLdQ/gn0djecxGqj2rphA1CbhwkOJ81bNnNBaB6wL1prrszm6w/rNwKje9FE7W9qdvlEvfnQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(31696002)(6506007)(36756003)(6486002)(2616005)(6666004)(6512007)(53546011)(26005)(5660300002)(44832011)(41300700001)(316002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QllDb1llNTJ1aWZhYThCRnBBUE84cDNFVnZKN2tadS9TazlHSTV3UCtKWnV4?=
 =?utf-8?B?Smduc0VSeTJNNDRSTXZzVlgvQWlnTG1EMWRPQWVpNUsxZ20vaUw3L0kyWXRE?=
 =?utf-8?B?VEJjSGxuRGM4UEFEL1diSitDcWUwdXdtTzQvRDE1TitqeE03QlIySjIweUY5?=
 =?utf-8?B?QjB1Vjh1aTRzVFZQU2lqRFZQY05YRzBsK2lxaDZRZWxWRldOc2kxUUt0QXp0?=
 =?utf-8?B?UkU3dnBNYWU0S1V4cVBZNSs3T1M0S20yNzJQcWZkZGZQMHpQNDdNQXM0OWVl?=
 =?utf-8?B?OFFqc0RsenVadk4vd0hVS2NGaGZwaWwrVkt5Rk9vdnNIdDF6ZDA4YWgzVEJZ?=
 =?utf-8?B?VHpmL0UrUk9SNFpBQUIrT1gyNUJKR0lvZkZWU2VXWnAybGpTUEZTWDVqSXdR?=
 =?utf-8?B?NkptZklyVlhsSWR2L0FSL3BVMTB5dUVUejk3b0tzNWZxNWM3S2EyUmRoeU54?=
 =?utf-8?B?MDdHa3o2TVVRZEpCbUMzOUNVUllLaEdrelVCTlhoTFA5RkhveGE1bTdkKzNk?=
 =?utf-8?B?aGRPRkpZT0ovVTVPaFlnNk56dGtmMGU0elhKUitjd2tRUytZZVUwWkFVVlUx?=
 =?utf-8?B?bmFnQTRoQmRoWW1aWXhMQjlWMzNaRzRlQ3Q0UDVKTVRMMHpBUHNBMFc1UEdq?=
 =?utf-8?B?TW5OQW1lNFJpQ1ZaTjZzQnIrQThNbzFJMEI4dGJGckRRM3k3am1hQUpidlhi?=
 =?utf-8?B?Tk9pNFJhYWRFN0JOenBPQUJoNzc3UytyM01xb25aK1cyc08reEovUnNtVHFW?=
 =?utf-8?B?RlJjZW13RDlXSWFWYytKY3FzR3RsWnNwREdQd3hYMFVLcHUvdFZaZjFheTN0?=
 =?utf-8?B?Wmt2RFk2MzlWK29IbVVvVFZEZWt5RGRFSjFSZGp2UHZnZDdSWTNxS29PZDNz?=
 =?utf-8?B?akE4UGtvclcxOVpYNCtkbTBzdVZyRUFiS0poOGhiOWlTT0JHeXQ0YWlncnBR?=
 =?utf-8?B?TWFXSUZ2MExidHNBSUREOTJ6NUZaSDU0bXNiakdOa2VYMWxKa2h6V0V2TlM0?=
 =?utf-8?B?bUFKbXBoZmhWOEc4b1p5V3VtRE9GR2Z2OVA1Nng3UHNFZ09RaFRiN3JxMnMx?=
 =?utf-8?B?dzFQMTlDOGVqMldVcjBPMm1RcHRIYS9hTGhtdnhBcHpBVU1CUmR4bit1UGRQ?=
 =?utf-8?B?NWluUFdMNENKLzJEL1pTYzFnZGJLeEJmVnFlbEdJVUtZYW1ZZ2Z4OXhxcVBw?=
 =?utf-8?B?aEtOUVdYWVFTZVRuK05ZRmR1OHdVakkyd0w5dmNHUTlJTVBWRWVydlJDNTFJ?=
 =?utf-8?B?YURucWVURThibklUVmM2T0RIS0tueFdIRWVUSXZMcTVtN0pXL2d1Z0xHK2JN?=
 =?utf-8?B?dHNsYm9hWlc3WEgwaDhJM29JdnJPWlc5M0ZXb2dBUXppZkJsVDJKN3o0a3c5?=
 =?utf-8?B?OUdDSkJ0OGhoSDJUR1Q5VFl3Z0g4NDRFUnU5YkI4WDdCaUFNYWY2Nnd6OEV4?=
 =?utf-8?B?OFQwZmVIUm0xU1JEUmV2Q3hwd0dpd2l3bS8wSzQ4WUh4STVuQ0FiSkpnUm9C?=
 =?utf-8?B?emJER0JXMFdOK3U5U043Y2FBZjRpTjNEdmY2NGVnZWQ1czFGYkJQbmJxTHdm?=
 =?utf-8?B?RTFXTGFuWWJWaFkxUVI1QjB3QTZ4T3FYL0ErbDBMem4rb0FPSE9Xd3pTRDg5?=
 =?utf-8?B?ZGluTnZPOFpwNi9QSGVacjVFY0xqK3FRNHQxSHRWK1YrY0dhNVZuUTlsbm1U?=
 =?utf-8?B?T2JZdVlpUVVsSDJZcWdwaHo3S1lleDU1Z2txZXNLTTloSVhrdU43dzNzQnQx?=
 =?utf-8?B?c01DTWU1WXJEeitjbEtnUWxacjlwMnJuczM5UGRBYVlveVorWEJoeFFtRG0w?=
 =?utf-8?B?THNQQ3h2bXYrcXFrem9wUXZhTnMwOTB5LzkvUmQzbHJzL3ltd0RjMFM5YkZH?=
 =?utf-8?B?czQrby9uSmJ1emhhb25hd1RpQ3p5YWwyRXpVUXdoVzE5L3R2ZjdqeFkzVTRY?=
 =?utf-8?B?eWJxUjRJalRQRTJqZWZDVk9hMEphVEswRTJ5Qjh4c3YydU5aMFBrejNNcjhX?=
 =?utf-8?B?SXJGOEFtYW1Md280WC81MUJpaFd0ZGNPdXNRc2lockZVdHJ2UmUwdEJ6UWQ5?=
 =?utf-8?B?RmxOQTI1UE5CcVd1ZHV6TUJlTEZCeUlsNkRVcElTVGRvSjlNejlReXFNSXZJ?=
 =?utf-8?B?MVN3WFVBZXN0KzA0YVdOUnpIZjlURmhRT0krZVo5cFZXNlBiTDBmYlM3Z0xT?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf78014-188a-48e0-688b-08db9e44404c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:33:37.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEGMLfEytZMa3szoi1FBZHivEugZh+/VQwsK4BUuoQ1PpkhH+vF0qlhNb9mgolHBAN6Q76Xi3hgR6g1Aj40u8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7026

On 16.08.23 12:18, Johannes Kirchmair wrote:
> add an interface to dovetail for signal frame setup and restoring.
> 

Subject should clarify that this is x86-only. Normally:

x86: dovetail: ...

But then you are touching generic headers as well. I think we need to
look into arm and arm64 first to decide about the patch structure.

> This is useful for implementing rt signals within Xenomai.
> 
> The interface makes it possible to use the setup use functions provided
> by Linux.
> 
> This is just a proof of concept using a very naive approach using most
> of the code provided by Linux to setup signals.
> The patch should be discussed, especially considering if using the
> Linux functions is viable in a rt context.
> 
> Also to discuss would be the interface itself,
> for convenience I used the kernels struct ksignal for testing. But maybe
> we should maintain our own struct, that is not that feature rich.

Signed-off missing.

> ---
>  arch/x86/include/asm/sighandling.h |  6 ++++++
>  arch/x86/kernel/signal.c           | 22 ++++++++++++++++++++++
>  arch/x86/kernel/signal_32.c        | 13 +++++++++++++
>  arch/x86/kernel/signal_64.c        | 17 +++++++++++++++++
>  include/linux/dovetail.h           |  4 ++++
>  kernel/dovetail.c                  | 14 ++++++++++++++
>  6 files changed, 76 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
> index e770c4fc47f4..35ffb1c52173 100644
> --- a/arch/x86/include/asm/sighandling.h
> +++ b/arch/x86/include/asm/sighandling.h
> @@ -24,4 +24,10 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>  int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>  int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>  
> +int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs);
> +int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs);
> +
> +int dovetail_arch_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs);
> +int dovetail_arch_restore_rt_signal_frame(struct pt_regs *regs);
> +
>  #endif /* _ASM_X86_SIGHANDLING_H */
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index cfeec3ee877e..d060931403dc 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -353,6 +353,28 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
>  	force_sig(SIGSEGV);
>  }
>  
> +int dovetail_arch_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)

Overlong line - try checkpatch.pl.

> +{
> +	int ret;

newline

> +	if (regs->cs == __USER_CS) {
> +	        ret = x64_setup_rt_frame(ksig, regs);
> +	} else if (regs->cs == __USER32_CS) {
> +	        ksig->ka.sa.sa_flags |= SA_IA32_ABI;
> +	        ret = ia32_setup_rt_frame(ksig, regs);
> +	} else {
> +		ret = 1;

What does "1" mean? Is that used by *_setup_rt_frame as well to signal
errors? Is that case possible at all, ie. does kernel code check for the
same condition?

> +	}
> +	return ret;
> +}
> +
> +int dovetail_arch_restore_rt_signal_frame(struct pt_regs *regs)
> +{
> +	if (regs->cs == __USER_CS)
> +		return dovetail_restore_64_rt_signal_frame(regs);
> +	else
> +		return dovetail_restore_32_rt_signal_frame(regs);
> +}
> +
>  #ifdef CONFIG_DYNAMIC_SIGFRAME
>  #ifdef CONFIG_STRICT_SIGALTSTACK_SIZE
>  static bool strict_sigaltstack_size __ro_after_init = true;
> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
> index 9027fc088f97..a99318a70755 100644
> --- a/arch/x86/kernel/signal_32.c
> +++ b/arch/x86/kernel/signal_32.c
> @@ -145,6 +145,19 @@ SYSCALL32_DEFINE0(sigreturn)
>  	return 0;
>  }
>  
> +int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct rt_sigframe_ia32 __user *frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
> +
> +	if (!access_ok(frame, sizeof(*frame)))
> +	        return -1;
> +
> +	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext) != true)
> +	        return -1;
> +
> +	return 0;
> +}
> +
>  SYSCALL32_DEFINE0(rt_sigreturn)
>  {
>  	struct pt_regs *regs = current_pt_regs();
> diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
> index 13a1e6083837..67b52bcc5b5e 100644
> --- a/arch/x86/kernel/signal_64.c
> +++ b/arch/x86/kernel/signal_64.c
> @@ -237,6 +237,23 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
>  	return -EFAULT;
>  }
>  
> +int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct rt_sigframe __user *frame;
> +	unsigned long uc_flags;
> +
> +	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
> +	if (!access_ok(frame, sizeof(*frame)))
> +		return -1;
> +	if (__get_user(uc_flags, &frame->uc.uc_flags))
> +		return -1;
> +
> +	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  /*
>   * Do a signal return; undo the signal stack.
>   */
> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
> index 70b78fd55d5e..3384437a4c74 100644
> --- a/include/linux/dovetail.h
> +++ b/include/linux/dovetail.h
> @@ -150,6 +150,10 @@ void oob_trampoline(void);
>  
>  void arch_inband_task_init(struct task_struct *p);
>  
> +int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs);
> +
> +int dovetail_restore_rt_signal_frame(struct pt_regs *regs);
> +
>  int dovetail_start(void);
>  
>  void dovetail_stop(void);
> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
> index 79fd75918b37..de220e90950d 100644
> --- a/kernel/dovetail.c
> +++ b/kernel/dovetail.c
> @@ -11,6 +11,9 @@
>  #include <asm/syscall.h>
>  #include <uapi/asm-generic/dovetail.h>
>  
> +#include <asm/sighandling.h>
> +#include <asm/sigframe.h>
> +
>  static bool dovetail_enabled;
>  
>  void __weak arch_inband_task_init(struct task_struct *p)
> @@ -447,3 +450,14 @@ void dovetail_stop(void)
>  	smp_wmb();
>  }
>  EXPORT_SYMBOL_GPL(dovetail_stop);
> +
> +int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
> +{
> +	return dovetail_arch_setup_rt_signal_frame(ksig, regs);
> +}
> +
> +int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
> +{
> +	return dovetail_arch_restore_rt_signal_frame(regs);
> +}
> +

Those could become static inlines as well. Or simply let the archs
implement them, like the kernel does as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

