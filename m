Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B05C27FD43
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490179; cv=fail; b=EZNOx/CIeajsXapmAg/kyN53Iwvn2lLyPHYpeO07EzB+/vFf9MeTwwxjXRgwU5YgZO9kXuqHuGQ2qNkCHuwhvp1dmRaVYnCQzRv0a/yQUz/Ax/tQB+4j2EZ5BEMGQvUQBVUaeaKGO1E/XYDQE8d3mX+eo55BsW4cxva2jGF/E/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490179; c=relaxed/simple;
	bh=+PaGa+HSh8GtQeB/s50ABJYFXf1zMLJIuzlCmNb7m8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W3KV6/sPt5A4s1uBbrCNyVQ4O6mVWHP2TR9bVXl32egFcShOD5f7bf1ZLH2Gt/ytL2F+FuKekU6ygfo3pugahXQ67Jss/3lquzL0I1i7mfDtyjoDuGe0GcI38O435M1fIKrjGoKTMuxRLmdToOkRk6ygIOPsSbi6FvxeZdx1Okc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Iq5CL2Yt; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Iq5CL2Yt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc7UiZgjj2+D8yPcKLva1d2JMvuH1o55x9tQ+rN5bpi//CUGjoPt2wRyMUyfGyfoBGKbPnSO+kDnITA+ED49Pp42/ozpVMAtEBB644ZRH/DtNGkdDdSowuIocFKZq17ymSLzcRLvCgBjQ7fmmPyLH6EEiNnOk9fecSYVxEAG/iORWyh4Wo5l+73MmPg1e7tkZs99u8Jy/U/UqKyUnH9YnaH2ZDkhJ1+vzEGEoZXtqVctGuhAkGpJlAW0Xy9alEUpSZVh++HF7rl8jX+Vwdt7t/jUVqUdVTBVZTQfCBcKIzW30CADYKVocaCRq65QVxury2USdKFQ5bDxiWjWTYnb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HdeH0Nz0yv/mgmZhStM6A7p8YsGYguqOeaztImwhh4=;
 b=BmMnjdsRF+7A51WsCW1ketMfi1GXvNeBLhQ0616Mzt+3U3lJUFdiEdroQKlyWBKROBItoSjWUVxIpsKo6rWVQ+p4RSU8SFH7ipfKvLAs3aIFNEKTANEifXiemRxxYbUqQl2XtQR9fmJ0fOyaCvl1/MT5WSOMVZAIj6liO7ZRdcq9yZGjAE31IWJd5HJOaCSYcc8JN3tmSn06I6OeNyfRwkPBSxVZUj3N2KhNWb7C0nkLmqZjKGaO8z2qpfXXMWIS8fJXdXM7EZdltscZ+HuPE8HtXaTHTPVHqWXEG+hsqx4L0HQy3t45c4poVuv5Wwon+TGDlNSRjpgP2SKoaZxPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HdeH0Nz0yv/mgmZhStM6A7p8YsGYguqOeaztImwhh4=;
 b=Iq5CL2Ytut33CtXU1WJsIIomD9HqnXDeq6fOyoLlJAB227VRNN54a7mE2GFRAorwW7GAbhCeauxpeu804cuysf5tiUpHZjgYaFHKKs8Jy7nEZLiR4tPxDKaUdUJScc//VBZ5UnOMd6XfHw+4sPrWKSF17S0t/QKari9nBLTwAIL6DoZgRfbQBKKjRZ2wfRs4HRo1z6fww0DuJLON4mmbyEeJHQTF15+0LdcIdbAnAlqEPI4Xatwi4FmW+Kr9Bs04dWdFcXp7LV4o5MGt/7dLh9oFbUNyYMPSJJlGL70RHS+xtN/IJY7mO6iTBxq2EZ5W1EyH8qqISnzbi3g3OBn2Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 05:56:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 05:56:14 +0000
Message-ID: <f6148a61-0401-48a2-ab53-dade677b7c51@siemens.com>
Date: Wed, 8 Jul 2026 07:56:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v9 11/11] riscv: dovetail: add core support
To: Florian Bezdeka <florian.bezdeka@siemens.com>, rpm@xenomai.org
Cc: jan.kiszka@siemens.com, xenomai@lists.linux.dev
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
 <20260703152738.129122-12-tobias.schaffner@siemens.com>
 <60e6a386a564780148293e3b47692d636e91ba2f.camel@siemens.com>
 <dd6f0c05-ae5f-4e2c-a96e-d476168907fc@siemens.com>
 <df451d92ebfd185c10095a5635b44b150a1786de.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <df451d92ebfd185c10095a5635b44b150a1786de.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB8PR10MB3308:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fa67fc-7af7-463f-86fa-08dedcb59e93
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|10070799003|366016|56012099006|11063799006|4143699003|5023799004|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4wzYIom5O9s+q6+sA2tvJGTqZTtzp/tKOLhnfU3bK4/4gCA+NvZyuoGZf+4DpOFmd/OD16znTkN5REkLn44o8mr0Xim4WzlEZz9LXQalDV5kusg50Zc+rTbpwyWBR3aQzd5fxysYj0NzS7SGait3J8zAs7KGjj4cIUdcywoQrQShe6LmS1sMwfVJmIsnUD/7i9ZPXyrKk/xyDqiMfH/qcVDOHRbcgCwgBIp1Ou1k/uS0C8D+NfHYh9mQb8Bb2yvd7QYQM6gfp8kV4opm9SCSK7Om56IzOyNZ+p3KuCsr9smGKA4DxkCoiE2HJiSZvCA8a3reHatsqhfBg7QH2dj1xc/GpidR1S4juiiw3jaDl+rtlzlZzeN2FiNUe6+e+ZzgpIZXQwjXUTs9Jf2Dmden49H3YorHm0mT61dZhSuk9b9R0MGH/8TvgXsCPLs5ByIOBw/kQDjp6Coc8IBJGhuOp7LGX/KuPPFJzst1662aJREOBJikCIMHd/pHijeovZmeo5nWwAGkfg5EpYfvposbu8YmjsWlIyRNV24x/AWCNM8Y/twnYx7+kFk1rt5oKzIgIVi1Rj5BV8oXSzlwPlN+PPwmPrRyF3LxuxNMtJ8RhH8PavBSS9x2T+0ueUj4Lfh5UmRJWXQb+nW9HWEZfQXKMViuMLTo2Qwide7Te8FCP8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(4143699003)(5023799004)(22082099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjdCU1prUzFqVU1iZ0ZNOEJEdlRQRFZ5SHdsL0ZTVlFJUEtvTy96czJBQU9a?=
 =?utf-8?B?b1kyRjRJdkdRbE0wZWdBUTE1NEVEdjVia0ZwSlZOZE9xU1NXM0Y5ZVN3UzZ5?=
 =?utf-8?B?Q0ZjTk5tTkYyV3RsMXUrNllSbXBKNm1pUjlKU21lWExJQWE4aHlVR04xYzBu?=
 =?utf-8?B?YmhCa2NxR01ZMWZRVWlWbCtra3J0dGVJY1AyOFRUWS9GN09iRDVDMHMrNWJK?=
 =?utf-8?B?SXN0eFVUTkVkM0xTZTZOT2FIRnIrL216WCswU1dTY0JtYTJqZ1BHQ0I3WHBQ?=
 =?utf-8?B?UlJGSEVBOHY5L3I4YStnZ09YbEtqSFFERHY3UEJwRTdWdUZDZkVwT3Z5eTBK?=
 =?utf-8?B?T2REUkVIekh3NzIyZ3dJVWFPY0sxQXYzQ0NRNEkxZU5Tdisva3g2MTVsRWFo?=
 =?utf-8?B?Rml6c3VmOEEzMzJKMldNYzB2QVY5MnBaM1crMS9aYTYrdDFDeE9ITGczam1H?=
 =?utf-8?B?aHprWVYyMzhqdThWY0NTRCtTNHEzelB0Z3QvU2tzTmFrT3RNQWo3TlFMekJ2?=
 =?utf-8?B?bE9raERSc0tvUWhDanV6VUJoN0xGdHgyeUpmYXBaVzgrcEpIY3Btc2dCZkFG?=
 =?utf-8?B?Y2hyWHhuV0w5MXk2VUdzRmkvQ3QyY21NNzlxNWdpNGRvRENmQm54WURPWVI4?=
 =?utf-8?B?aGhNODY3NDVVYmg0cU5UNEdkNTVTV2pwKzY0MzY1ZHNZR0pnTEEvOHlLKy95?=
 =?utf-8?B?ekQ3ZGhvbHVnNmxQT29VcFNXMXZBNVRsU3ZtVE9pRUZOdERXc016K3VEQTBL?=
 =?utf-8?B?S3JtNUV6QlBLOVVySzRiejA5OXI3WGs5YTVKaGcvOEtOd3UxVHdIOS9ZRXQz?=
 =?utf-8?B?Uk04N0RDQXJYc1BZODZrL1BwZGo2ZXhsUWtvc2pTUjFLYzZOampKNGpjQ3RX?=
 =?utf-8?B?dkQ4L0R3emk3bVFqanJnR1RvQWw2R1dEeXVGRm5UcWRKQWRjTE9hRjJ5dHY3?=
 =?utf-8?B?NVFLa1J2TWxkSkpMVk5sUzh1NG9PWmJoU1hsdmdXOGpPRmZMS3hnb2V3eFhV?=
 =?utf-8?B?Z3NES3RWZ2NsNUdHempPcWJMNXBRN1R1Y0JiaTB4U1VVWGVybUJZQ2pBM3N0?=
 =?utf-8?B?SkxBQXN3YXhpaTMvMVl3NzFENThhNXNzUzVFVW5tcmMrSGFtSmVRQ0R2akZS?=
 =?utf-8?B?dVZHL1EzTXhmRytsU2VFWW1CSzRISUhBRVE3c3QzVXROQk9zWlhReTBFb2dw?=
 =?utf-8?B?ZHZjT2FyZ1FhVzM1czVIU1RXSWxYejREajQxd3czRUlhR1JIME1pbkFrZFM2?=
 =?utf-8?B?cnlndWs3UVIyUTk3MkRNdllhN2ZTNmd4MFZMWHlyTEJUdDIzWWJMTkxQV0Fs?=
 =?utf-8?B?T1JvYnZYM29kVkpjUUtQS054OGh2VCtXRE1aUWhqWkhvN0phd0RNUTUrc3BU?=
 =?utf-8?B?MUg0aUZTNmw3eXVRLzQwV2Q2d041Sk0vMGpTeXExZEYxOGxOenBQQ1hRaTFq?=
 =?utf-8?B?eXBLUWlqM3VhVkQyMUNZYmh6Vk9qZjM2d1dYSmExamVJNUVhWTduM0VtVjhG?=
 =?utf-8?B?NFJ5dHZERktBR1MvREErdDJ6WkliQTdiTm1TKzFWMGRUczZrQmRrckJlTVBh?=
 =?utf-8?B?R1c1ZnhtR0tKYzE5a05SVEVPVEY1NVl4UG1xRUxFS2Z0N1Mya0dneXgweURV?=
 =?utf-8?B?MUcvdE8va3FYeUdNQ2tZaUMvbmxwZlg3QjBIZHI2Y3hLVWVOMlg4MFk1SURK?=
 =?utf-8?B?akRUdmxDaENZdTRqMkFxdFZXd1BDUi9YeXZNaVpkZ1pqVUNFMVp1SjJ5RmZu?=
 =?utf-8?B?bXZ0REswdzcveXpVUVBIWXNjNkthRXBQWnZMTTJERjByNW1EQzl2MjI5WHgx?=
 =?utf-8?B?Z2NvSjBhRG9MMFVOY29INnlZZDg4VFpndXZqNHNpTmFjYnVwYXZJSkRHdE44?=
 =?utf-8?B?K0pPbDN3ejVwbzAreTlXZHg4WlViU3Q0eUJLaXhQUXZleXp5WXNPaVI1UDR1?=
 =?utf-8?B?TGhWdS95SllTcVNzc09FcEdZQ0RlL2lxZ3RDa1NDZFQrR0t6TGhYOW9NV0hE?=
 =?utf-8?B?eWU0a0Racld5NHl4L2Y4S1FxSG5waWJZVXdNT09RSG5YMWRKczBzMW1PdlBL?=
 =?utf-8?B?YmVRQWFDT216dWs2YXQvdUZldjIxWThoSmlmY1o2amtxKzlJK0dHUHY4YXNP?=
 =?utf-8?B?MDJDOC8zTklIUkZ4emVZSE9tSVpUZWQ5UTdXUjZCMWwvSFhOOTliNG9tNVNw?=
 =?utf-8?B?THJiQUpUVFBTRnF0QVpLRTJOTUdGcTFrZ1hxOFZJRWFxQXBWSEgxSE9ubXcx?=
 =?utf-8?B?QndrWHB4UFYySlQzYWExYVArRTVkdVN5cmxpSlAvbDBDczFrbnVwRHhXc1VP?=
 =?utf-8?B?WGY0RUZGNXRqTWora3p6TkF1Zis3V2MwUFBBTGpQb1lMbFM0Z1pYWlVKNnRx?=
 =?utf-8?Q?QLY9PdIztL6UbkgLA1HTLzkqa0GOlNwfuGQyo8+D1AHHO?=
X-MS-Exchange-AntiSpam-MessageData-1: l3ociMttepzpBodjpfNVo6uZi4dOeh2DQ+4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fa67fc-7af7-463f-86fa-08dedcb59e93
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 05:56:14.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eK3mJ9zQgxHmHidOjKWiY2DehCCFDxylr0fUU4lNhbDntUXsEL+HP6uJUFsLkTXXRrKbavcWL4/V8gV3zk0UKV47YIwluaS9r8PrRLyQFnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308

On 7/8/26 00:18, Florian Bezdeka wrote:
> On Mon, 2026-07-06 at 19:16 +0200, Tobias Schaffner wrote:
>> On 7/6/26 17:06, Florian Bezdeka wrote:
>>> On Fri, 2026-07-03 at 17:27 +0200, Tobias Schaffner wrote:
>>>> @@ -359,6 +391,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
>>>>    
>>>>    		syscall = syscall_enter_from_user_mode(regs, syscall);
>>>>    
>>>> +		if(dovetailing()) {
>>>
>>> checkpatch:
>>>
>>> ERROR: space required before the open parenthesis '('
>>> #1426: FILE: arch/riscv/kernel/traps.c:394:
>>> +		if(dovetailing()) {
>>>
>>>
>>> Please double check checkpatch output for the complete series, there
>>> seems room for improvement.
>>
>> Ah... That's the only checkpatch comlain. I will send a new version.
> 
> Looking at the complete series there is more...
> 
> The most important ones (on v10):
> 
> WARNING: function definition argument 'struct pt_regs *' should also
> have an identifier name
> #271: FILE: arch/riscv/include/asm/irq_pipeline.h:131:
> +extern void (*handle_arch_irq)(struct pt_regs *);
> 
> WARNING: Missing a blank line after declarations
> #682: FILE: arch/riscv/kernel/traps.c:455:
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +	handle_arch_irq(regs);
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #1174: FILE: arch/riscv/include/asm/dovetail.h:1:
> +/*
> 
> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
> #1175: FILE: arch/riscv/include/asm/dovetail.h:2:
> +* SPDX-License-Identifier: GPL-2.0
> 
> WARNING: Block comments should align the * on each line
> #1175: FILE: arch/riscv/include/asm/dovetail.h:2:
> +/*
> +* SPDX-License-Identifier: GPL-2.0
> 
> Any reasons why you didn't address all those further warnings?

Got it. My tooling filtered these warning as long as there is no
error. I fixed the last styling issues and will push them in a few
minutes.

> Btw: Line numbers above relate to a one-series mailbox file compiled by
> b4:
> 
> b4 am <your-message-id-from-the-list>
> scripts/checkpatch <generated.mbox>
> 
>>
>>>> +			if (syscall == EXIT_SYSCALL_OOB) {
>>>> +				hard_local_irq_disable();
>>>> +				return;
>>>> +			}
>>>> +			if (syscall == EXIT_SYSCALL_TAIL)
>>>> +				goto done_inband;
>>>> +		}
>>>> +

