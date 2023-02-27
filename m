Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DD659
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 06:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNuol9yvVMeqVaTbBT9WHz7hxVFGwPnjoCQUcvkeK1Qqrm86Xw4JLeDsonzpwNFDJLw2TlkUhzZFg03IzMcSgy/RxVktNN+Xtct3d/JPdvYh55hcYt4cOMb8aY28VOKW2WhkxH/UALkPsCnY32L8fvXmO/l9feL1PVD31ldJ8gV1CULtEGAgbPpcP8phZ+z2Et1ffDbCbkbxcxYQvEXSRn6PSAaL5YLqPOMZd+094N3hdAIkvCyDnWfTuYRqCVuLM+KYr+InLdzkgy0wUDveXCP/QOhCvQF5rG4zgZ/mBM3q/y7pofy6Rh0ahlMxf+pw37etpc28pI0Excqtn+kg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1qBZ5JPXvATS9jY2VjfRRrgDcR4OTQpCtGPMAppPXs=;
 b=PHpdntxIc7bI0EXAV244f4LjLTcMNzu1Z/EWa6B1DucTZpfhlz0iXdkzKnkyHHbh9zjay5ey1RfbfU0AVDH7TWUgm2krksZtgIfqNfrJC4eSl5bwpyVWgaSqMcTck5vJESZAO1HAqJgM+WFEEJoz5EANSbGvh+lKlWzN53By21TmjPEhiUZv2B1YwihJsG7xBOqXh4qUf5hPa2V9tyTQ+kz84FiuBV84b+AESczJ1ZFRO5y58a0DQktrveITHXbdE4DgqBuvDtxf3oSdkx5NLrbwsvHeeaGNJIzm12QETLkLPKSrSA/0cmpZes4L8pU2GHVtw/Zp2KJd3/muTBSbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1qBZ5JPXvATS9jY2VjfRRrgDcR4OTQpCtGPMAppPXs=;
 b=ZUrLsd6kfIwcaGeE8aCDWJoC1zhDJrUCC+fb9WUaSYgLs519oa+2oUtUUn37XKShezu05dse/n5gNjHWlCTi+p8+cW0JnkkH7ZQfgEFUq2yZ9BNC8wj8iepyVUdlnVVxBvVXKOtx6vZI+uE97X40pMpGUtAL3hqk75feiBRlRXFUuwOtGS2FWdeKuFFu4hv5AxoA3GyCtSZyVfU9/tIXrFDDx6HA8yx1URBYhLQGnd/4WUgA08WyVauvHaBDFTHik/wqetz3D5N48XyPf1lj0gCI5pQG8Qdkf/INF9rjw+4r5cEvhAj+kghyTyNfEdH5VMPZ1iCcNTK+4SAqRgyI0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 06:45:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 06:45:52 +0000
Message-ID: <9d761c88-640f-5421-61d7-0f450fa7de91@siemens.com>
Date: Mon, 27 Feb 2023 07:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: problem while handling exceptions in oob stage
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <VE1PR08MB49090AD3D9BB287AFBD16EEA92AB9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <87y1olh9i4.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87y1olh9i4.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed36092-a7f9-4e69-e471-08db188e44ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IK6PrnFvWm7wMGt8cipN5CHIiKI8+HNC5ZrQGfGuAqJihQBSenKIOvW3OaN9EXbhQ3j0vKDYM41/V2CI7OJEjAaP2obxQbBdMTreQ6DWhpFafJldM42yqCwYyyt8lEEle9vcqgLzVipwV2c0oDYzt9LcfOMpKodptv4qBLt994Ju+rYeBiuCYonrUASy5bCTvgMx0NxZGwNWPaciSG4W8vNLBSbgDn6RH9DrRltpAOAMJmMvaCUL1P/4bbWFcodZB45xQWpbq8JNO5ca+ynr+6D5iK7CBUWho77IHLcdReKurF1UbQu3gahx9LHH7B46DgJa5Om3Zm31+Gh1247gQNn3d6m0F35ANgrSN9KbUG2AUjtR+ho2NH9zybuZHNXH3bl6CTvVxh+DjGbqMz8B7zkLNQnLe6OkHxhvDhvo9tBG5zCuu1yQ5acxenmthEgmGQEimUTqXd9ql00EY5ChVHFmryXTjd94WJ/eBkNx5la5HaaD1/F4Z8wz+SdPhL99n3PdXjWjxZsmAACsHxGo9ZYQsF/u3vKyyoqcQt+DtuDkJfNezCKifJ/0dBNGWFrWma8KBULB+3fsIo35Zsj8mdfkIa+YYMibxGQoYRxpqzEUF30heiEcctG3qXrMHWp7MHcZA2vp+0jK+81Z+40L/x5cM+qqsK1qGmZfPxSwBx8ntRa/EboM1f2VaJtdDjAWo4NL8UivHu7Eaij5Q4GIYigofZ0QuTxMI8JEEufBRoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(41300700001)(6506007)(6512007)(186003)(53546011)(31696002)(26005)(2616005)(36756003)(83380400001)(38100700002)(86362001)(82960400001)(66556008)(66476007)(66946007)(8676002)(2906002)(4326008)(31686004)(44832011)(8936002)(5660300002)(478600001)(6486002)(316002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXBBWlovdDVTbUdaQjRRNGxJdVhIbUMrWFBSWHpYYkVXb1dGMzhmZ0xHbWVH?=
 =?utf-8?B?QldGSW9SVjllRnJwajNoR24vaGZ1Vm11K1p4bCt0U29pVFBYVC9GMmVLWU9G?=
 =?utf-8?B?dzdCVC9udEtGRWxZRzR2YmZXT0RuNVFzUDYrS20wMXJNQThnUHRpZHZ6cmUv?=
 =?utf-8?B?NDhnUWF5MkUxZWF2ZDNVM2N6SHFlYWpZYnFNYmFab2tiWXlZekZRVDRGaHBP?=
 =?utf-8?B?aFFwcVQ1YWpUbVd1MTlZWE5oRjZPQXNUTWdtTFdQb3dtU0lldHRGUzJQRy9Y?=
 =?utf-8?B?S2NoMmNMS1hvcUdRUkJLKzBQT25CMVM2aWNDQ1FYOVBDbWY1akhoTVB4dnJR?=
 =?utf-8?B?dHFueDNRM0Rsa09FaElnTTZYd2ZKZ3dJM25ES3l4N1lwcHRQTHNXV3FnTjc2?=
 =?utf-8?B?YlBKOGJGY0RoNjRsSXBSVm5TQUt4NmRIUHRGWXI3TlJuT3dmYnBYM3NrT2lB?=
 =?utf-8?B?aVR5dDNzaTZ3SmZWTThyVE4wQUxzb1kxUzV4ZDExc1hoTENlZUZoVm9Hb09j?=
 =?utf-8?B?SHBBVCtHdk8yTEROell6V0tiN2dDYm4wQW1UQ1ZqbmxIejI4T2Z3SUxYdmJS?=
 =?utf-8?B?L25CWDhtOWdpSVNqZ3cvdFlwbU1UWFFWbk9nbnU4Q2FRd0NhWmN4cDd2Z1VD?=
 =?utf-8?B?ejIxZmJqK09YN1dCZmlpdk5OY0NaOTFLTjUwby81Zlh4YzNTNnR5OHFuS0lt?=
 =?utf-8?B?NWhhakVGQ3BFVG94UGhZTEVZaXB4YmFyaitoM3BQbVNQTStORzFvMkdFZWZ5?=
 =?utf-8?B?ZEFUdFQ1SlJSR3JSMUJ0SWVvUml4VTlqMFFvRyt3TllLVmxLMTlMVTc2MFND?=
 =?utf-8?B?c0E5SEpUaGIrVVhYNTRpN0h4YytxTVZ3VUhyeXZGUnZKZFR1SnFGS0Z5Tisv?=
 =?utf-8?B?VlM2c1dmZ1JhWEMxc0J0dG5sZGQrTTRKWk1kVnk5M0U3SDNkemdaNXFkOHox?=
 =?utf-8?B?dzhKcC9zZ1BhUit1U242Mmx5YVpNU2NPL1ZuZXc0bE5VZElqdTBaRjFUSTZQ?=
 =?utf-8?B?cHZZVkUzeVpISnovYUExeXdNWitIN2dXRTc1N21SVDhJNFBpYXRRMUtGeDZ2?=
 =?utf-8?B?N0t1b1NhR3dHQlUvUlVIVEJwY0dxUTc3ZTVIZHVldmw4V1d3RFFkMmZZaEVZ?=
 =?utf-8?B?YTJxcXRpdi9TRFQ2dW10akxSQTc0QXlSb0poaGFoUnBRREJRMmRrT3Zua0xV?=
 =?utf-8?B?bjhPcWlnNWxWbmt2czA4WDN4UzNSdzRjTk9zaDFtbkQ2QnIxaGZWQmdnY1Uv?=
 =?utf-8?B?S0tFSXdJK1l1c2hRV0VMUkxuT0lrcWxSWExNRWVEcENJc3VMZzBlelRvRHp2?=
 =?utf-8?B?YTA4NkE3c0xVMDlWeUdZc3VSVkpCKzhOczgwV2Yvd1lqcGRySTVjR292bjZn?=
 =?utf-8?B?NEduSUwyUFpXL1RhMmZ6SC9iTHhrVTJMcmREUFB3czBweHZBQTNTcWNvSjFP?=
 =?utf-8?B?VWF5Slo4VjlWRExMNWFya2I5OUU3OHJDNzJsOHBBWlhQeGZVSGdIeHdmYlBC?=
 =?utf-8?B?Z0R5TENNak9LTnVrSm81dGJkWFcvTUJBNm5xd3d5ZVdhUHNxd25sK1kyeE1N?=
 =?utf-8?B?azlYamJ2VVpNUWZmT0JJZUluSVJBaGdLa3FwZEJSUXlhNHdXa0RNU2lTQW82?=
 =?utf-8?B?R3JhSE4xcW04cjlyYS85bWcyZWFJN0F4NU53Yk5EUXFIQjU4UkxKQ093VEdz?=
 =?utf-8?B?NnoyYmNTMVpLRG1zQXE5T1pVSFhUOGpWZDVwTDNoT3lwYnYxNXR1VkRZcXc1?=
 =?utf-8?B?NU56bkNnWEhDMHNkTStCYWhFQnFRSWxuT0FNMFFTUlVGU2dsSGdic3k5TnVV?=
 =?utf-8?B?MGpGYXBRS0ZlRkN4RWR0YUhXVGQxb214c2EwS1JwVjNzdjJ6RDBybENzbkZm?=
 =?utf-8?B?Z3VkMTJnOW95QnZPWDgxbU81QXd2QWxIdml2R0ZzSEFjZUlzQmUvaTQ0aVZk?=
 =?utf-8?B?MVBCeGFTRmtWUGhBRUNwbjR3Rmg4MGtNQkpzd0sxYjhQNDJvTW1YTUt2b3ps?=
 =?utf-8?B?UTNjUUxaTGxUNFE5bDhHejkwMDhxM0NjelI2MmJDckZVUXJScFQ5VGF1WDlS?=
 =?utf-8?B?WVdDUW12RFU0Qjh6Z1pOUWl6eUoyeHFXeFdPd1Q3WEl6ZUxHbmQrOUN1NWw4?=
 =?utf-8?B?UnZEV2dqRGZlOVV0cjhscDVBYnovVVNqRU1ySE9zdlZkQ2ZpNGYyeTBVUkdN?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed36092-a7f9-4e69-e471-08db188e44ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 06:45:52.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcA1JWAVDw+i3TrXYLuGULdPVGw/oe6froPeN3/bk8ue2/8d+LXPVXJYfn+ufNh8vAIlbQ9U/8RcRpuH3c1wCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5522

On 25.02.23 19:17, Philippe Gerum wrote:
> 
> Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:
> 
>> Hello,
>>
>> we encountered a problem, while handling invalid opcode exception in oob stage. 
>> Our fixup code works fine if we execute ud2 instruction the first time.
>> Upon second execution of ud2, we encounter the problem that our fixup code is not reached.
>>
>> The problem is that the first time entering the kernel, mark_trap_entry_raw is called and in a subsequent call the _TLF_OOBTRAP flag is set.
>> But because we do not switch to inband stage, we do not call mark_trap_exit_raw and the _TLF_OOBTRAP flag is not cleared.
>>
>> The second time we enter the kernel on execution of ud2,  we encounter (again) the following code:
>>
>> static __always_inline void oob_trap_notify(unsigned int exception,
>>                                          struct pt_regs *regs)
>> {
>>          if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
>>                  __oob_trap_notify(exception, regs);
>> }
>>
>> Because _TLF_OOBTRAP is set and because we are still oob, we just leave the kernel without calling __oob_trap_notify and subsequently our clean up code.
>> This results in re-execution of the same ud2 again and again.
>>
>> I fixed it for me in the following way:
>>
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -414,8 +414,9 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
>>                 handle_invalid_op(regs);
>>                 instrumentation_end();
>>                 irqentry_exit(regs, state);
>> -               mark_trap_exit_raw(X86_TRAP_UD, regs);
>>         }
>> +
>> +       mark_trap_exit_raw(X86_TRAP_UD, regs);
>>  }
>>
>> I am not sure it this is a valid way to fix this issue.
>> If it is, I could work up a patch next week that addresses all the places where this problem could trigger.
>>
>> What do you think?
> 
> That would work in the current implementation of mark_trap_exit*(), I
> would recommend to keep the semantics of the mark_trap* pairs unchanged
> though, meaning that no exit should take place if the corresponding
> entry failed.
> 
> Dovetail-wise, the inner oob_trap_entry/oob_trap_unwind pair should mark
> the start/end of the in-band handling of a trap, so that the core can do
> some housekeeping before and after such handling. As you rightfully
> noticed, because such entry was actually notified unconditionally to the
> core, we should always tell it about the matching exit point as well,
> especially if we plan not to do anything about the trap event.
> 
> Something like this should do for x86 (same issue for arm64 and arm,
> I'll fix them up too):
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 7238f5c90b998..234e8ab84c221 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -174,6 +174,13 @@ bool mark_trap_entry(int trapnr, struct pt_regs *regs)
>  		return true;
>  	}
>  
> +	/*
> +	 * If the oob core did not switch us inband, our caller is
> +	 * expected to leave the trap handler immediately, so we may
> +	 * notify the core about this right now.
> +	 */
> +	oob_trap_unwind(trapnr, regs);
> +
>  	return false;
>  }
>  
> @@ -188,7 +195,13 @@ static __always_inline
>  bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
>  {
>  	oob_trap_notify(trapnr, regs);
> -	return running_inband();
> +
> +	if (unlikely(running_oob())) {

I don't think it is useful to declare oob the slow-path.

Jan

> +		oob_trap_unwind(trapnr, regs);
> +		return false;
> +	}
> +
> +	return true;
>  }
>  
>  static __always_inline

-- 
Siemens AG, Technology
Competence Center Embedded Linux

