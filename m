Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9918D
	for <xenomai@lists.linux.dev>; Thu, 10 Nov 2022 06:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+sBz2CVIffF9sopFGOvB5bdXpIAad7CASdIW8TXQxwPATi/kaZc7EzBLFtiAvMuU6Mbe2/hegTPV8+ocr6kQVs4Y/SK2x1rOaD9XO3ujQ5v+xt4pp/jNvB/BW2sccuv97bb+tfDjDhcFk9b3Cezx0TfOLIs7ffrrc9+ejbMOoHgk/sDaI6PSYliqVg0fe8Y626UQcMgyfy/kUVByJ3ySj9nCaWwJtY5tU9ln+herYxZlupAKaNqXcz62hdtS8uw+qztPH08b7bsOWmx5i2ikoNaw4EeICNOKjBRryJi2A+PUjoHnPGk7TZfDXrInH73IIyEJtpMUomjDZx7rfORmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIsJz0LwfAOH6Fti128KtfIJbAymWSF1fT9bnDU6Z4o=;
 b=W6dYW+yprbrowsTHXX3yhhT1KR3R+M7wjU+YpUXuWNYE+j3z+LMVnw5aqDatfja//S7i3CPxnW4B1hgQK11rrkPvZCAqZ29JjvSrLIJKYlG1hpJcDhBxj/2gnLa/knjTSn3AQA0UH4VEWNjsGjnYVHfAx2+yoGexrvFs+WRddQjJXMPpWfjbZHgPdenU3fL6vekiclseztldeVl6THsCcrdJNxkdPO65E0rgEjpWLBpGMZOkQ7ZyiX0tvvLopwF9Wrbl45FBWzvaUG/APSEPmY59EdfYmT1LMWr25SusrKK9uwS+7Fsxs/W3sEjYQ4rV34PcajHbNND9wDBkgcdLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIsJz0LwfAOH6Fti128KtfIJbAymWSF1fT9bnDU6Z4o=;
 b=C78V1UIiW4vqDtB4dP/B2JEbD9vyxKVLo3qdtC6BAW52uwf//MxLEMnMIH8JinoO1EBg6um4b5sBsgD/U1DRs5V3VUni4hPKVAE3o22QjwtRHDq4vqcjjKSvdjSCVtUxWSGyXpC7sRw5+11jvrHcm/X3PCIyKKvRvMj0nErQ9IRoGR0CoRfPWV8ted2/lEmUoYfr0gaQyzjj2/kt7UlecjH4Grr5rjHC6kRgO0CvO+mw4lLFsFQ2gvzOGdE4ZRMuYIg+ZtHTeTVaynPcwh5+t90qjfIJ4tBFrN0K9tdcwAIw7eF9ttt+jTlO7lkPNastFELie5VGZeHXxT8jZbFbMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:38:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 06:38:55 +0000
Message-ID: <2934513f-c67b-35ee-e72c-dbebd23a432d@siemens.com>
Date: Thu, 10 Nov 2022 07:38:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH, 3.2.x] cobalt/x86: Fix FPU switch during thread hardening
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Stefan Heber <Stefan.Heber@zwickroell.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <3a80ab49-09ac-2403-8e1f-6e61e3726657@siemens.com>
In-Reply-To: <3a80ab49-09ac-2403-8e1f-6e61e3726657@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: af78098c-63d4-40b4-4615-08dac2e63d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NlZyMg9SBLfoYKKXlwRN+ocvg6WS0VQWlQjNTIXtndhGvTb+8G0F1sRS+AaYDNFHRL/cPgBzlRvEBrB83vLxGoN3Mau2ClTTb19jdiF9xMZo7D4O/OaEZ+TdUvlE7ZNRpFgSbuheVhHPl76r4NK5uX2zRtxfCwgbqU90fJDAsEu0EfsXqKPijkBXEO4Bcxmf9Nd7aeBBULdCkhw7Xry5kEHkKtXFuXJLfUVvPKIxSPJ7Mco9bGPo3M3hPJqUkFIQyt+ckpBkPtawY510cQ9VkK343vhiUbI8deNS40z+rC5wfwAHAtK2LNa65bF6tOwWdUY8gscGkvbhmrpTnZmfjdedTYKo3IpdoysTp9ex4ZIncSJ8Jrq+Nlat9En4DToHqCgQtgq65pQ8aZCH0PWWkF1dFnftTM5f+WhZS3UMvzuSRr4OxuemY1jlHHaGLSi8GSJ0EWpKLa+YGW/w0N798rvaXabOZ4ripji5CTVcjoGmW3I7mErA5fSLeSDsHUKULdFzvCVo94WXN4O/jXrfiBhj5vP+TlzBZt+cxLumJMvcFl8HjAXFXDSoE27F9lAg3//cTsaiNfMOWSUQSxxz2n0N+X6fn2N1Oj9Vnjs+o5rQKrAxJzcCosq2+EPOZQlkrTK/PAkKf7jGkSmJpF3rfj5g/DRfKaanJ8mEPALdU3AcDascdsvyx1d55OhX2I0o2uCi8W6clqREFAwqnTI74fvhXjvTL/B/KaUC2W0y4rkIwUR/sUcSnaFmDZko3obQPAQfbvOGYOv3RNX8IsUCf+EBQSVXQQj6s5vTRBYv3ds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(83380400001)(2906002)(82960400001)(38100700002)(86362001)(31696002)(44832011)(186003)(54906003)(478600001)(66946007)(4326008)(6506007)(5660300002)(6512007)(8676002)(26005)(66476007)(2616005)(6486002)(66556008)(53546011)(316002)(66899015)(6916009)(41300700001)(36756003)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG11anJPRjZxU3JmRXV2U0p1MWNBMHllbWZOTzhTMUpGV0JNWnE0M0lCRm9q?=
 =?utf-8?B?cXJLRCsxMkdiVE02bFI2a1c3dVpEcjJ2RnBBMkpkWnl1VU8vNUpTK0VjMDVo?=
 =?utf-8?B?NEx3b1lSWlBOSmNDNHRjd3JtYzQvbUdWeTh5S2ZKSzVYcWJaVXVHRTdLbk92?=
 =?utf-8?B?enQ2OStiYlBJUWVOMUIrcXBncm9tVkY4KzJzdStndHBGTnh5dzRxWGFLazdZ?=
 =?utf-8?B?czNpd2E0aWFaR0E2TUw5VVZ0dnpuRnp2TlhlRUl6Umk1bG9mczZPUm9uZkU4?=
 =?utf-8?B?MHZTanBDQ0ZuVStya3Q0RzRFN0wzeWNqSi9laWpidkR4dEdMeURHREU2VEVw?=
 =?utf-8?B?VEltL2FvczV4UHgvejVWRElxZ1NRUjNmRG94c0VYUWM2cnJPSmZldnpSekJz?=
 =?utf-8?B?UXVlZUtjWk5wT1p1NTNRMkthZWkvS3RGMk1CUjQ5QUwveEhjMEtodGNpcTN3?=
 =?utf-8?B?MVE0cjUxOWxzKzBlSmRBbEVGRlVLMTRVRytVMlRLSDZZaGcvZlRwRjI2TmI3?=
 =?utf-8?B?c2RqaWlkRXczS1ZDRXBRcDdCbXNHbzFTT1N2SXhycWIvSGw0TWEwWjZZendU?=
 =?utf-8?B?VUs5ZjRMNFMvVVpORlNycjNFU3JCNDYxRC90SFdaZDV0RDhFT3EwckZSd0tZ?=
 =?utf-8?B?M2xaZFFTaFA1cDBUYlBtMjJXVEhxbUYyUm04bTRqemdLT2ZLRmxzMWpaOFBY?=
 =?utf-8?B?WU9ORElCWjIzVTU0eVlPRVIvdjJQK3czMUhpenljOVNXbEFuSnZhQWI0clFj?=
 =?utf-8?B?VXFSbzlhWkhRbkEyNEZLMEYyZ29QQlpBKzNsMVhmem1WaE1LNGZyVzJpL3FG?=
 =?utf-8?B?dTU3Sk1VaHlEeVJzM28rVzFBVktTai9Ib0lBRm53a0JtYUVIbGZLeHY2d1BS?=
 =?utf-8?B?RGJQeHZHVFdjNFU4OG8zL0hnK2VpaGkzaVMyb1VHc3Z4NkNwOU82TUdBU1Y4?=
 =?utf-8?B?c1FyMVJZZjdzb0lnNDhqRmg3OE1YM21pSWo0c1VzNGx6RFVkVjVyUmt6V1lC?=
 =?utf-8?B?UXZYYzNkUkhyTWo0b0ltaTgxL1h1b2pDaDd5ak53YTEwTUhPeWh5ZHVNQnNq?=
 =?utf-8?B?Skc1aHhKK0pNYWIxZUpjWWdqMHFDQVhMQ0R2MnlhdVBTbnlPSEMzbE1nTlRq?=
 =?utf-8?B?RzhrK1p1cnN3bXBRWWRZdURmUVUvT0dnTVVOMVhvcEQ0OGtxVXRIYzRjdWJn?=
 =?utf-8?B?WGk3R21kNXZtanFSZGsrcmY1MUNhMDh2cGxySUJMMVVuUWZpL2tNaU1ITVND?=
 =?utf-8?B?OENoOHZIbTN4ZXVMK0hmeE5PWHlzQmU1a1JUeWNOdTI0RzhxSGdXeWJ4ajYr?=
 =?utf-8?B?cWV1QkU5MDRjVUlGT2pqVnhHekJkUGUvUFdEQStyTm1DajJaVmY5MzFCdHBH?=
 =?utf-8?B?aHRCQksrZENhbTZVL1JoWUt4QXlBQ2hTMm51YVpLYjhqWjFJaVgxL1RxR25W?=
 =?utf-8?B?V1ludmZxbkZnN0tzaEZ1VHEyWExoTzgwcFZENnFGeXdMdVFwZnZCcXR3SDlQ?=
 =?utf-8?B?RUZmeHVFODRKK0tYclFaelVwM3JiK3RWRCtDS3krd253cGxrM2VBTHpnY1VG?=
 =?utf-8?B?eThPdTE3aGY1ZGVpZ0t3RGEyWHpCVTJUTGNaL3RkYUZTaGRVclVFL09hWHBT?=
 =?utf-8?B?VmRFOVB1RGVYYmtBcm9lYkwzSEx3ZFN3UFVOcnN1clhsWkVLSG05MHpmTjhU?=
 =?utf-8?B?dGVNNHFtSko5TTdQOWNua0JpcVQ3UEREMXN4cTlpT21ObllUa0dzZjNaa01V?=
 =?utf-8?B?OXFIMytISlo5amhTeERhWmRSN0xIbGtxWkhmc05uczd6QUczQ1pQNkcxdnBG?=
 =?utf-8?B?REE0bnNnaHltK0h4aEF5RGpCNVV2UnArK0VJdWFyTTc3Z2F4YWVzbTRmbU84?=
 =?utf-8?B?Slh4R2VvZkNlQ3FLRTJTZUp0VDZ4b1I2VGF0MUJGS1MyYzN3dmJhRXZYSVNO?=
 =?utf-8?B?R2hxVDlXNnUwS1lsdzNJVFVlYjJLLzh0NWp2OXY1OUgxV3o0R3VCU0FVNXk2?=
 =?utf-8?B?Nk1ST1Z0VGRSS0dFQUh5cDg2ZEViSXA2ZXQ0bStNbjZNVERDbU9RNEJtMmo3?=
 =?utf-8?B?V1luL3UyekxpaWEzUENPbkRFWmtxaDEvZ3V2UmIvaWdOQXVMbk0rVkZ6ZWpB?=
 =?utf-8?B?WHZCcEFsNlVaTDIvaGlIT0VMQVp6QnpIczdHNE40ODJGWFRhTFRPNlRyNURP?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af78098c-63d4-40b4-4615-08dac2e63d3e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:38:55.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EW9frMSxYmbtcJHm1ldfSEvz8OIzJkAgTnGR3xWQbh0sC0DP1jWb0HJ+m2zXMAStoutxCidYvujDqF3TrR76g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6055

On 07.11.22 18:42, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The current place to account for the missing call to switch_fpu_return
> when returning to userland in primary mode was missing one case: the
> switch-in of a thread while migrating from secondary to primary mode.
> Move the logic to xnarch_switch_fpu which is also called in that case.
> This also avoids having to deal with NULL xnthread_current.
> 
> Reported-by: Stefan Heber <Stefan.Heber@zwickroell.com>
> Fixes: 608c23297c4d ("cobalt/x86: Account for FPU changes in kernel 5.2")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> A similar fix will go into 3.1.x as well.
> 
>  kernel/cobalt/arch/x86/ipipe/thread.c | 54 ++++++++++++---------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
> index 7e28903a42..46c47af890 100644
> --- a/kernel/cobalt/arch/x86/ipipe/thread.c
> +++ b/kernel/cobalt/arch/x86/ipipe/thread.c
> @@ -209,29 +209,6 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>  #ifndef IPIPE_X86_FPU_EAGER
>  	stts();
>  #endif /* ! IPIPE_X86_FPU_EAGER */
> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
> -	/* 
> -	 * Refresh 'in', we switch the stacks. However, there might be no
> -	 * current thread at this point.
> -	 */
> -	in = xnthread_current();
> -	if (in && !xnthread_test_state(in, XNROOT) &&
> -	    test_thread_flag(TIF_NEED_FPU_LOAD)) {
> -		/*
> -		 * This is open-coded switch_fpu_return but without a test for
> -		 * PF_KTHREAD, i.e including kernel threads.
> -		 */
> -		struct fpu *fpu = &current->thread.fpu;
> -		int cpu = raw_smp_processor_id();
> -
> -		if (!fpregs_state_valid(fpu, cpu)) {
> -			copy_kernel_to_fpregs(&fpu->state);
> -			fpregs_activate(fpu);
> -			fpu->last_cpu = cpu;
> -		}
> -		clear_thread_flag(TIF_NEED_FPU_LOAD);
> -	}
> -#endif
>  }
>  
>  #ifndef IPIPE_X86_FPU_EAGER
> @@ -443,15 +420,32 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
>  {
>  	struct xnarchtcb *const to_tcb = xnthread_archtcb(to);
>  
> -	if (!tcb_used_kfpu(to_tcb))
> -		return;
> -
> -	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
> +	if (tcb_used_kfpu(to_tcb)) {
> +		copy_kernel_to_fpregs(&to_tcb->kfpu->state);
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
> -	/* redo the invalidation done by kernel_fpu_begin */
> -	__cpu_invalidate_fpregs_state();
> +		/* redo the invalidation done by kernel_fpu_begin */
> +		__cpu_invalidate_fpregs_state();
> +#endif
> +		kernel_fpu_disable();
> +	}
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
> +	else if (!xnthread_test_state(to, XNROOT) &&
> +		 test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +		/*
> +		 * This is open-coded switch_fpu_return but without a test for
> +		 * PF_KTHREAD, i.e including kernel threads.
> +		 */
> +		struct fpu *fpu = &current->thread.fpu;
> +		int cpu = raw_smp_processor_id();
> +
> +		if (!fpregs_state_valid(fpu, cpu)) {
> +			copy_kernel_to_fpregs(&fpu->state);
> +			fpregs_activate(fpu);
> +			fpu->last_cpu = cpu;
> +		}
> +		clear_thread_flag(TIF_NEED_FPU_LOAD);
> +	}
>  #endif
> -	kernel_fpu_disable();
>  }
>  #endif /* ! IPIPE_X86_FPU_EAGER */
>  

Would be great if you could also confirm this variant of the fix. It's
in stable/v3.2.x by now as well.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

