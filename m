Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83FC2FF
	for <xenomai@lists.linux.dev>; Mon, 14 Aug 2023 17:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR+xG9qI3qVlEoBWn6IrP3LlYCc+e/aUFEzgeFP2aEIDAMDOP03Aee/iQm/8qyS9ffczBthaT7i4uCNtSJKsUiIRLbWTUuLLZ4ReEFbTxqgRMyWwWsQ71gM4vTNKQU67Q/Djmn8y4dL2/kszz8uPCYKQQEOXIunqbEwcT11WQwSt6Sy9GZEtkaL3B1BrLqXrtFqlQX4eXC7MTy0Lnj1ToKJIJU81KknccQwj8eeiyItLIvqT/cCNtDQMofhKYBaA3fRy4/zgIdpi2ec6CB18huQz3rX5niUvztSPMe2w9VIECoyiIsTpC49zpZx+DLil9OCuMSjzCebNh4URXvAtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+Pl+Xlxx4EVKhQzohb4bQVqEoHkIIjvMvgBftvhIOQ=;
 b=W1xOMBrbpEHJfL2oiD3pdS8ruGO19Fw5tSeeo0Gs6Wf+PR55uR+KtfansK60NM07tiUCwUYlmq16BWduupSuA5uvc1Gfo+DpqkO9MMP9epEs9E0SkrNDNk1vOzpHOCiZhfz6ojVqKvYdmZw3Y2SGTZFQZwZykylZHR7VRTP1RKGjOWpwBaxUWhv1QfY6Ih/d/80iuBJ1yFZBiaunJ0OA9RrIZIoBVSuh8VQMHt78ygrBvpc5LG5DUNHuRWqRH6FeSLjGASxW0QiVf/6A1A8OdNt5CwjALOHeEYWkcBOcVEex2fSiL3ZxO7oLRR+gRuyar63/AvOpkdrKVDEgNcaAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+Pl+Xlxx4EVKhQzohb4bQVqEoHkIIjvMvgBftvhIOQ=;
 b=m9kuiI64hWrpumz3SeBhu/mXoktvGCjgeLwNJQXZEWlGx7ppMrfxSJee3fpvGO5B7UQ/nJJV4zSFIdtS0ltWKHRW5uTF+RvY0s4j6QLGF1HebPIbuTIb0q8K9dwHtL94sjVhwbW0Nf7y3fVXMXyPS2RYjG+28bSAu9ubR8z27fsJtjP8lxDHZpk1Ha1XctVOK+Y7SfMFv7NmO53H/K/V/x4KGWZVZTLHJUQebwGdYEKQmyajIAGciIscu9L833c4Berkn2u3W7QqpBnppmAj32zL9+dwMwC96LamHC/crTUm7aC2bvEUfWkHONuCGjm892gKEPYaEy2BixG6HtLBWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:33:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 17:33:02 +0000
Message-ID: <10100be7-f83b-4882-a147-25471784af01@siemens.com>
Date: Mon, 14 Aug 2023 19:33:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add dovtail signal setup function
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 xenomai@lists.linux.dev,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
Cc: johannes.kirchmair@simgatek.at
References: <20230509131151.3003178-1-johannes.kirchmair@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230509131151.3003178-1-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 58637048-f510-47bd-72e1-08db9cec82d7
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 c+mGD3Jdb9lfUKRs8Z7RZFs/JTkv5bfig9x8NU4LP14xsOjrfXwWxn9JSESE5pfiRtKtxqgTMwa4xx+KDMMO4HO8o1t2Pq+y0bHToEiugX2VnILxi7RLpYFqX9Eb1gHCieqsLgEzeijdwfsXDdM/Sd33Qe0xIODhFNL5nSL1fQ7NXgp1oR2XozQF6u6BINB9AnUkd5xHoU3ZgvBcp+xnvc7LqDOOY4qQ0pF/8S10TWUoQyPmDARD/PbILanA6Li2brQZ5ghN/RNpX5QqHssehMWtDS6zXtCUqWa3Gslj1MaVuxb6pbvdtjzKh1xVL5EAtD0bwKWQ0N++iSXAp+ieB8k+/SLfz7z8O63hbp1wBw1lRO04Q+bE4xPCIG7Keh5CYHQW1uOelED2ITN73dvNHdybd/CcwRtu7EeUtVmMy7P3gKAwM3t3pZPQXl7ZJW7fCwHmAOVLIExrog+noaJ772JonWXhp+0dY1PM8AsiHIMqU+BF/S4oO/5Ut+lWM67o3y/dci8/d9C5V6bqbVLmrK7XPkwiPDLe7dmboc91Wjd+Ums8IjX0XOgSZklF72JhXepKPZMshn/Z01fCf+ZXtiAPdNd+uJZj50xp3yztvTTH0WPatO+lLkNLWgVMxILysVPtX8dHAqhFbMN5o82j5g==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(82960400001)(478600001)(6486002)(6506007)(110136005)(26005)(6512007)(2616005)(53546011)(66946007)(2906002)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(6636002)(44832011)(5660300002)(38100700002)(36756003)(31696002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dko3ZVJCSmlpaTFQQlY1RFRYcFpySkpTcUNwUGMzVkdia1hsUzI3VWN0VHM5?=
 =?utf-8?B?ZDAxR2diVU5KNU15UThpMjBySHd3R3pwUWUwTnFIMkgveTlPVXI5VFpMTkpx?=
 =?utf-8?B?S1ZTaW9LdDVxZEZ3dVNMOFJYK0l5M3VoRThaOFQ0bm1kT1Byck0vMXlyQi9p?=
 =?utf-8?B?TVNOYnNwUlI1UVlaTWo4dU9pNmtMVEhTNWhRYkswcXJvQXpPZkRzNEZlNnZD?=
 =?utf-8?B?OHJTdlFwYTMwWkI1eDNlVnJzZi9RN05XR0tPRCtPaUpTbzB4MGphRzdHZkJW?=
 =?utf-8?B?YkZTcEFnWHVXbkdiOVJXdm92MGpZY2NkUmlYVkNxejN1MDZWOVZTVkxiQXNW?=
 =?utf-8?B?N2Yzb2NPR21yZFhwTnpON2gwdmRCeHMva3ZpTSt4V00zb0dueVNMdDg0R3Zm?=
 =?utf-8?B?NDI5NmlZWmYwbGNKOU5hYlhOODdFWDFramJ1ZkNURENwbW9lUnVWZ3l5ODgy?=
 =?utf-8?B?T3RKUzVXZFQ0ekZkY2lnQ0czeUlEZGEvaGNndWYvK3hOSnZXempidCtqQ2Fv?=
 =?utf-8?B?VldjRXNPOXZrMVltVzNIYnRmQVZSNnR4b0NMS0wraHNxSUh2SWxnbVorR2R6?=
 =?utf-8?B?Q081T2VET3hjVnlrRE50VTk4cXNMVDAwcjZhTWtxdlBlQ0NUb1ZRSW1JelBH?=
 =?utf-8?B?OUZscmZZb2d6TFJpcmljV3dWS2ZWTERKL21mVTA3K3N0MnVsQnRsS1JvWWRk?=
 =?utf-8?B?dUUrcW04WnRDL0dOcGhjQlk4ZW56WTY2ZVZzOVE4TkdsbnpDMXdoVkpCQzZ5?=
 =?utf-8?B?emJWVE8yNHY5S0lKL1lDSER3S2pJTG9FalZaUFhsR1pML3FCckpaYkUrQStF?=
 =?utf-8?B?U2FWK0F5Sy9CMXo1VVpiZ0ZpOURiczRVYngraWY1Y1ZrQnVPUWRxWHZXRlNh?=
 =?utf-8?B?eFNXNFk5WWZFRVE4UkFpekFVdmd3QXBIUFB1SkxudVdraXNDbktMMmxESmhQ?=
 =?utf-8?B?dkNUbS8wd3l1eVI5eFBDdjFPdC8rSHFXOGNFZ3hRSDB3TkJFM0p3N0JSUkIv?=
 =?utf-8?B?ZmxTOC95K20wbkJ3aWgrN0hucmg5S3N3RFNLdzRRNEVDRGJ2c1paamJQd0RP?=
 =?utf-8?B?YVdPbFBydmVManpuSGp5ZzF4RWJPVytKblhmTS9ZSHc4TFFjSDljY3JzTmJs?=
 =?utf-8?B?Rjd6UzJHMUIycjlsYWgrRFYyUGN3cEcyUnlHS2lCV05MSzhxK1A1eDFwOERZ?=
 =?utf-8?B?Slc5V0M2T0ZNRzFHWXZDMjl2Y3ZaQ0czM0Z5aVlNckhZbDZkZ0dwR2t1WGpP?=
 =?utf-8?B?SjVXQmpLeWZRMDNkdmtnOVpxdVhRK01zTWRUQ0dkcCs1QjJwNnE4R2lnNXJv?=
 =?utf-8?B?NVhKUE9IU2lHdTd3dStyVXpQN3E1ZFNDb1JCN0s3QUJ4cjB0RVJaeldUbUR5?=
 =?utf-8?B?TFl6NURnRk5zSHE0MVJtdXFhQzhNWHJSOWtybmxobERpTytjL1VYcmxSL3hH?=
 =?utf-8?B?c1paTFJrSnYxQy82SnhjZ3JnMXEvbmdFcXd0OFJEYjZ5aUY1dElrd3VWNC9T?=
 =?utf-8?B?S0srNnRXdE9jaHQra0FWMlBKdmxhT3BlYlN3NHFhRjl1MzNxMzJTWDhxV0Fs?=
 =?utf-8?B?ZzVFOFRtVzJpSjJqUy9UNG5OTm1CSEpXMm1JVWVoN05QWjIyeHpLblNrNE54?=
 =?utf-8?B?UFBxY21waEhKTThjY3hCRTBUc2gwcC9MWklCWG13ejNLdW1COTVOWjJyTjA2?=
 =?utf-8?B?WXZ6dWJyRVVDeERDUUZDSXlBanFOWW1STW5QKzdMWlNobGNZRUxIVmxWY203?=
 =?utf-8?B?K1BtZE9BYkhmOWRFbXdDY2VkN0ZQdCtRZ29TUDB1a1N3eXh4VWVhWXZ3OFBr?=
 =?utf-8?B?NEFGTWxnOStVdWUydUR1YmRNVS9Rdm45NGdOMm1ITU5nM01oMmRybC9tVzQy?=
 =?utf-8?B?am1ydXQrMXlLSHcyZm80d08rV0FDeEJTWUkxUWVVRm5OLzRTVmpnN2xvZzAv?=
 =?utf-8?B?bm52UGlxdHNjcVlnekdTMTAyVlRuZEdYMDYrZkxIbGRSUHluR2RXelMvdjZa?=
 =?utf-8?B?dkdiemQ4Tm1yb3dKTFpNTGRlZ2Fqci83eTdlSTU2dHRKT0pkM1d1bllZMHVw?=
 =?utf-8?B?aG55eCtvcVo2Sko4VHF4RnppczhrT3NwaFhzbk1WUG1rUmxFT1BqTFlxdWtK?=
 =?utf-8?B?RVRnL1Z4c2t1ODdWQUhTTXdwVTVhakdRRXFGQ0YzeHFWdE8rbUdmMGFBWXJ6?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58637048-f510-47bd-72e1-08db9cec82d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:33:02.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITH4EpCa/uJR9Eo7/Km1Ixj7RqQp40uB9YBLN8krQTH2b2PWciNxSHtOyjUhWCnTkqAZtsSanaAI56C3INcalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5641

On 09.05.23 15:11, Johannes Kirchmair wrote:
> add an interface to dovetail for signal frame setup and restoring.
> 
> This is useful for implementing rt signals within Xenomai.
> 
> The interface makes it possible to use the setup use functions provided
> by Linux.
> 
> This is just a proof of concept using a very naive approach using most
> of the code provided by Linux to setup signals.
> The patch should be discussed, especially considering if using the
> Linux functions is viable in a rt context.

I didn't find issues in using the Linux services so far. But the code
needs restructuring to move arch-specific bits into the respective arch
code.

There is also the issue with the return value that Tobias found. I think
the dovetail helpers do not need to return the return register, rather
only 0 on success or a negative error code.

> 
> Also to discuss would be the interface itself,
> for convenience I used the kernels struct ksignal for testing. But maybe
> we should maintain our own struct, that is not that feature rich.

Before inventing something new, we would really have to understand that
this is better. Also, some of the functions you reused expect ksignal -
another reason to keep it.

> ---
>  arch/x86/include/asm/sighandling.h |  3 ++
>  arch/x86/kernel/signal_32.c        |  2 +-
>  arch/x86/kernel/signal_64.c        |  2 +-
>  include/linux/dovetail.h           |  4 +++
>  kernel/dovetail.c                  | 57 ++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
> index e770c4fc47f4..ed6b7fcd7250 100644
> --- a/arch/x86/include/asm/sighandling.h
> +++ b/arch/x86/include/asm/sighandling.h
> @@ -24,4 +24,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>  int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>  int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
>  
> +bool ia32_restore_sigcontext(struct pt_regs *regs, struct sigcontext_32 __user *usc);
> +bool restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *usc, unsigned long uc_flags);
> +
>  #endif /* _ASM_X86_SIGHANDLING_H */
> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
> index 9027fc088f97..dc8d60378e75 100644
> --- a/arch/x86/kernel/signal_32.c
> +++ b/arch/x86/kernel/signal_32.c
> @@ -74,7 +74,7 @@ static inline void reload_segments(struct sigcontext_32 *sc)
>  /*
>   * Do a signal return; undo the signal stack.
>   */
> -static bool ia32_restore_sigcontext(struct pt_regs *regs,
> +bool ia32_restore_sigcontext(struct pt_regs *regs,
>  				    struct sigcontext_32 __user *usc)
>  {
>  	struct sigcontext_32 sc;
> diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
> index 13a1e6083837..d24845ee6a8d 100644
> --- a/arch/x86/kernel/signal_64.c
> +++ b/arch/x86/kernel/signal_64.c
> @@ -47,7 +47,7 @@ static void force_valid_ss(struct pt_regs *regs)
>  		regs->ss = __USER_DS;
>  }
>  
> -static bool restore_sigcontext(struct pt_regs *regs,
> +bool restore_sigcontext(struct pt_regs *regs,
>  			       struct sigcontext __user *usc,
>  			       unsigned long uc_flags)
>  {
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

I think, this makes a reasonable interface. Its goal would be to
create/restore a Linux-compatible signal frame and hide all those
details from the RT core.

>  int dovetail_start(void);
>  
>  void dovetail_stop(void);
> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
> index 79fd75918b37..2a61bf1dbc23 100644
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
> @@ -447,3 +450,57 @@ void dovetail_stop(void)
>  	smp_wmb();
>  }
>  EXPORT_SYMBOL_GPL(dovetail_stop);
> +
> +int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
> +{
> +	int ret;
> +	if (regs->cs == __USER_CS) {
> +	        ret = x64_setup_rt_frame(ksig, regs);
> +	} else if (regs->cs == __USER32_CS) {
> +	        ksig->ka.sa.sa_flags |= SA_IA32_ABI;
> +	        ret = ia32_setup_rt_frame(ksig, regs);
> +	} else {
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}
> +
> +static int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
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
> +	return regs->ax;
> +}
> +
> +static int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct rt_sigframe_ia32 __user *frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
> +
> +	if (!access_ok(frame, sizeof(*frame)))
> +	        return -1;
> +
> +	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext) != true)
> +	        return -1;
> +
> +	return regs->ax;
> +}
> +
> +int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
> +{
> +	if (regs->cs == __USER_CS)
> +		return dovetail_restore_64_rt_signal_frame(regs);
> +	else
> +		return dovetail_restore_32_rt_signal_frame(regs);
> +}
> +

These need to go into x86. Not sure if there would be anything generic
remaining, likely not.

And then we need code for arm and arm64.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

