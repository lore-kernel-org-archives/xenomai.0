Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A62F2A
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 17:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8GN8wYmO2XViAlve3yRKpeV3YLL8CwtCvoLE7GhIjqo1BMRubx37TbEk/pBkxQq/iptdWdCKP1eelLzVVMvc82MRxTuYe4YeSVn9B++5mxzuICOIayS4QYiiwZIzCKCFA6xJW4RtzCiQYMrfzaJ3vWvkV8JC/VJf4KIscWSFc9ua+BCFhmnHGdky+DfF+Hm/Cf05RncoRzSrQFTUrQtnlXzuHOcV3CEkY3996MLOAMSnFAlsZuS1Ni+EBUt+ZFxy0fR8W8oRuz1NP0iUdeOgQt8vYV9MxnpFqiNsY48N90HwMjlgxPNj26gBTNV9DcXt7rD/wAzFE1Qcn+lsC0ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJZU1dEj9Vwsx112S/xFpTZuL+Ykvw4AuelFx+w2jRk=;
 b=EMxnlMgEA8doqhiLZeBXvA/dR1omDDMX+HzqaijGabcGTdQAUMl1q3H5hoyJ9iRbBEcjDZ6jAdTpWB5d6Kijj/Oo2Bb5tLb/Kxr6yqUZavw9GsxOw9Xe4xJ8M9TgWsJagVwpRKWGuWQ2TvqWhemTX+z+HKZWbXPTzeHLnnI2JBiEHfmmd4NdPcTJOI6sVagJO2TEAivgpd8q2UfttId6uLckDPXFNqLTcVQHMPr4et98qFMkHYjgcKjdJmQhsadPLQRr75C68U8H4L28dFC6v1CEvbsIvr5Pi2GbrnsLF8gavPpO2O6k+WQ4JKj07GXWGASRRncIj/4atFh5X+4GIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJZU1dEj9Vwsx112S/xFpTZuL+Ykvw4AuelFx+w2jRk=;
 b=EhhftpQOviw/Z54TlwiCr2xI46knHDhbNXXtOKzwbELIaCHfVi8q5JS8n8e5mrcwN7DWz2X25HR3y+p5wcBH8cQWPw66nr13qw9o8g1NbKGZ0m072+XEiATuvc35m3mtWbLa+A6YQJc8LK38Ol/JhbK31A3SJCtzeYymaC2Hg/EDjjdpKWQ6dMQyCPbSpHBaKYCd/NPWVQk+Xz+Flk6hscRqFQ+GGVc/5k5G9sHEsI/BZSZYbOv8HlKx3KanUYREV/+clsHU347IOx4Cc6ARLbi6CIvAWVwHVWoLPl2zcOGDKfb706rphH/5TtbYWzYcq9QBIxiPIp3qxJl+WNYLVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Thu, 23 Feb
 2023 17:18:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 17:17:59 +0000
Message-ID: <80cf58d8-c2fd-8b83-0d94-cebf7c2a8777@siemens.com>
Date: Thu, 23 Feb 2023 18:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: problem while handling exceptions in oob stage
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Philippe Gerum <rpm@xenomai.org>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <VE1PR08MB49090AD3D9BB287AFBD16EEA92AB9@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB49090AD3D9BB287AFBD16EEA92AB9@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f029fd-712e-4efa-8182-08db15c1e9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UKGxzmgEQoPKVbzDs+mxu3MNM8A5v/JDSB057Jn921OWJMJfRK/M9qwyejmdUCzogBjI5ZciB6gdY5jFdC568+T3q3YUMVFzOVO3cBKnJR7B1cIVvU4r1ZCePKNl4TfvrBsKBSbS/ZYHvXw6WFUZAvWmhCULRo0X5hPxl5NSEe4IwP8M5mchedZq/58CG5hd9YkE2azQenUsisZl4E+FuTzjUd7ggT7ekZJqfNLbmj5JlWzOYOZX/Dd8Xo2PMWlhqOPPVSXVyyiWLXGPjoUCjzBXRbcdmfS4gGDJ1IaBGDvaAdl/YgQHgohl5brLFA/oj9s7zWyN7iDk0VsKhTghUP+yET9I+RPKkbDWaaih3fFmRyHR2oNLbsrZfxLuGHSMAy5X0eCW+yatFIN+pEKJh0QKWhGOzak5SMVLsGf0Y13jLkllqy5cTFXPdW4rl7cg1TSQo6UeYEVAEvYvlTfDfZ1OKhVdnYFzAH0CZqTkdSl5J2D9UREICt4lcAt5FabsDAGE4+r+hlCeCoP2IjTJpWccvj++UNSATvI3cQ/0N9YNXfRqwQKpiHPoSYyW5p44ld9dOu7/dGUq5rj4OgVln/prCiX5QRyM2TrcWcgmVx/ErDYSku34H+ZLAsfoR2ieVMK7FET/zg74oWTYbuZPK7Ca0XW7hqPzvQhezczbJdwWzRZdIngAWdF1o13Nc5jG5LEl8NL1DeD3RNQBwEXMCujmv4RKqokTfQzrzaIz5Rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(31686004)(6486002)(478600001)(316002)(31696002)(86362001)(36756003)(38100700002)(2616005)(53546011)(6506007)(110136005)(6512007)(2906002)(66476007)(66556008)(41300700001)(66946007)(8936002)(44832011)(5660300002)(26005)(8676002)(82960400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW53SVh2UUpxeFdmaFdDb1hpMmdINi9zaXhVSUk5R1JFUlhsZ21tWG5XRGdm?=
 =?utf-8?B?ajRuMEM3dGhlcHp6RzlJNC9PR1FyV3pCaEdNdUt0eDdTNmhKRWIrL21VdU4z?=
 =?utf-8?B?QmNueHhNamRSSVRWTUdmampKem1LazVTeExHM1M4VU5wZFBLU2V6OS9FbVM5?=
 =?utf-8?B?eVlveUlWQkdLMW9WV0VyNExWODdSZnpUNXRaKzJDZ084THYyTmk2ZTB0ZVFC?=
 =?utf-8?B?MEJualZQSUVyelBIYWhnZHNKY29nNXVRMEx0aUV5L3ZwSENiNnpZMEo5b1hv?=
 =?utf-8?B?RlFyTzB2NnZPVFUzb3kyemJlRE5vQU1ka3ByN24xUTY5RUhWcjJLQW9SUTZn?=
 =?utf-8?B?bGJIMnUyQ1pLZ1RSMnFCSFBlZVpTT3I4SUVZVUZod2RBWUpwemVLMStFbC96?=
 =?utf-8?B?cnRUUTV3TkVMYWlURDByQ3FHcnlMbkJJditqeXZhdThHcTNDcTB0dXpVQytz?=
 =?utf-8?B?R3lLRUh6SzZ2UWJyeXVBdUR6Vktsck1EMHJsR2ZUd3FZL2l4cGdiYlNSZ0gw?=
 =?utf-8?B?RG9WYnRqUXJOVlNWYTJIeCtXbVd0K1ZERDYyZERkSVZJNWhvU0FPL3p5QjZi?=
 =?utf-8?B?OEp6SXJxc2dsOHdmOTJZeDIxK3VmMzkzZnFSd2JQSkNOOU9iUndoL2w1UUNE?=
 =?utf-8?B?YnluYXhOMEZHMjlGd1dZTzJsdVg4dkdWQW5qMWZneHBRTkppcVdRNlA4bHll?=
 =?utf-8?B?TENhMEk0NmNjVG91MDVCNnAzdkZVRTlOMjN6OFgvam5WaHV6RHMzN2o5Q0c1?=
 =?utf-8?B?ank0MWN2MHhIY0ZBcXFxcXVJbE1uaUVsSjBpYS9Va2Z5Vngvc0hzT0NWSWdv?=
 =?utf-8?B?ZTJpUTlMOHJxMHFieGxwRW5JUFlHZm8zV3ZPeWw2UEk2VHVNcFRVbWI3NkhL?=
 =?utf-8?B?YkJhZms3Q1h0VG4zNDlld1J6aEZXZzFCQWpJTGlvN01sVzZiWFI4aEt6RG93?=
 =?utf-8?B?a0w1dXdxZlIyRTFUc0NTeFE4aWNVdml1ZW5sYVVsb1pCSEl1QXNqbzRRQ0NU?=
 =?utf-8?B?UmRTQXI5QnlscjM4OUJTZFNZQlAzN3M1c1JlZ3Y1ZExvUFRGdHlVb044aCt3?=
 =?utf-8?B?NVBiQ1ZLZEZwaXNnaTcxRUZPYjZzRTRTVUdsNzJDNjRFbG04elJFSEdlNEJW?=
 =?utf-8?B?Z0c3NXlrUXg0Y2E5dURaLzZ3MDJIQWhmUGVVa211QjYxVVY4SWxLaUo3RTNC?=
 =?utf-8?B?bldUVUUyU0l3TGR6R04wOU1yUkdKNlQ1aGZ1amZxKzdGZXd6QVAxWFQ2Ny9t?=
 =?utf-8?B?RmRWZGtCU3JNV00yV2hPTEZ5eWpzb0hwNVhzZ2hSSm10M3UyUXZtdlkreGdh?=
 =?utf-8?B?VkEvSXBTTGc1V3VqQ0pabEN2aXdQd3BsRDhjdFZmZUtQS3JCUWpiLy9lQXdK?=
 =?utf-8?B?elFVd2FtTkRVc1c4cDhWWlduTUM5NG1BdktpOGlCTVRWMXUxam9xbVliSmh1?=
 =?utf-8?B?Nk4vWlNPeVRQUzEvOEx6NDQ4ZkhuR0FVLzJwazhSMWhJYnlaZTNwUFhvNjZt?=
 =?utf-8?B?OHMvZS94TzBFNDNVSXZIdlVReU1tOGJ0eVZLTVF5THJVUVhtQVYvOWJZUmhY?=
 =?utf-8?B?QkRqajM4ZVFzb1c4RUFDWXpTWGlwOElhcXBIWHorL29tU3N1ejJyRHZ3dFJL?=
 =?utf-8?B?MXQwUUFrWlZLcCtTWTJqczlXUW9qSnd1TEZqWkg2L3JrNUlWTERJemx1Wk8y?=
 =?utf-8?B?MkV4eXdKanJFQ25JYVg1L1NabnU3UklURmVLRWNpcW95Z09aeHluNEhydTd2?=
 =?utf-8?B?YTkvdVJWOE9UYUlUaGlhMTd2YVpyWjdxWlNjaUVFRDltRHNxREF3SE40VVFQ?=
 =?utf-8?B?M1h5dWRJd2RuV2UvZVltNXZoVzdUeTMzY1cwU0t3U0lCWWxTY1F0MTZ0UDEz?=
 =?utf-8?B?VXZYMkZKcVg5VVJtQWpkbm9hc0JueU9vSEd4ZEJxR2tRTGx4L29xWTNqWmdh?=
 =?utf-8?B?TVFNcUZ3Q3VjaDVTc2pSK0RTV2FHTkIzMU9kaTlpU21wQ2s3ckl0TEFKWGU0?=
 =?utf-8?B?S2J1aWxGWURzeUs4TnNORGtJRTNQREVTVzJBR29sUkw2M3liZ2lxMDJ1eER0?=
 =?utf-8?B?VFJDNU0yd05OUjRwY3RIMnFKS0gxaC9WRitlTzBoNFA3cUwrMXR5NVZWWnZo?=
 =?utf-8?B?UHdzUExtcU41c3pSampFNkV3TlJQYTZmYk1JYmsvZHQ3T2N6bXZxRC9SMGh6?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f029fd-712e-4efa-8182-08db15c1e9c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 17:17:59.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKmfvmmkroUAtG5QYa56hdIJlMREaZ1hmeltTUsmsoFp16wCPsHuRYF94BVCA9+FUJSfyOtBmMykbYVnEZ+hQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5749

On 23.02.23 14:22, Johannes Kirchmair wrote:
> Hello,
> 
> we encountered a problem, while handling invalid opcode exception in oob stage. 
> Our fixup code works fine if we execute ud2 instruction the first time.
> Upon second execution of ud2, we encounter the problem that our fixup code is not reached.
> 
> The problem is that the first time entering the kernel, mark_trap_entry_raw is called and in a subsequent call the _TLF_OOBTRAP flag is set.
> But because we do not switch to inband stage, we do not call mark_trap_exit_raw and the _TLF_OOBTRAP flag is not cleared.
> 
> The second time we enter the kernel on execution of ud2,  we encounter (again) the following code:
> 
> static __always_inline void oob_trap_notify(unsigned int exception,
>                                          struct pt_regs *regs)
> {
>          if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
>                  __oob_trap_notify(exception, regs);
> }
> 
> Because _TLF_OOBTRAP is set and because we are still oob, we just leave the kernel without calling __oob_trap_notify and subsequently our clean up code.
> This results in re-execution of the same ud2 again and again.
> 
> I fixed it for me in the following way:
> 
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -414,8 +414,9 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
>                 handle_invalid_op(regs);
>                 instrumentation_end();
>                 irqentry_exit(regs, state);
> -               mark_trap_exit_raw(X86_TRAP_UD, regs);
>         }
> +
> +       mark_trap_exit_raw(X86_TRAP_UD, regs);
>  }
> 
> I am not sure it this is a valid way to fix this issue.
> If it is, I could work up a patch next week that addresses all the places where this problem could trigger.
> 
> What do you think?
> 

Good catch. Looking at my old x86 patch, I was calling mark_trap_exit in
all cases as well.

Still, we should check what happens here if it is semantically correct.
When I look at __oob_trap_unwind which is now being call for both exits,
it contains the surely desired clearing of _TLF_OOBTRAP but also the
invocation of the handle_oob_trap_exit. That is harmless for Xenomai as
we don't use it, but maybe it is not desired. Philippe needs to comment
on this.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

