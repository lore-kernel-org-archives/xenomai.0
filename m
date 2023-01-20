Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2047.outbound.protection.outlook.com [40.107.14.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94A1844
	for <xenomai@lists.linux.dev>; Fri, 20 Jan 2023 11:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH7Txg/A60NxtQ2X3WEjbRQQbAqhp8Vbpk6Yf+9nPB2gw3Fee675D9YRdLqu/g82+hlsBBi4X76ycYRxjhDvZQkhB6tAuIa6z4An8NDOgHk9KvWZVRU18NhFzDOO17FKqX3nipordTwtX00eyzwbIbAgQ9wpk0ooozE3G8A/JT1AtVHLbjS5aDuwLVrzE+bjkeOJnTEFZmI0SkEWh5kqmS8iElQt5ira0ZOkI1kE2DyQ9uRFSuHqT/0407tBWiR1noRfhL2NOuX5SfCCrDGsATqfZl3fT+Yp9Qi/NMQUkLVYSlXuMM9YultU7Ba0XtPIXNua+Jb2UjsNBkA0ZCHFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lll3H3D9tCZGIvI6Bfdvmux16dS+wdOqF8TcaCIWXVg=;
 b=gOwVgZW9AhIzsY5W/I0HqqubYJhb6KFDqwH7mdbSP/RGWisx+GCCAogf5lNhfS/VSfJH5h33NK0YtGAJo9N/D2LLetd0SQ3kxpC6+LLnqrKLP4yZlAoTwOV439vMt/VUZTYsZB9BlMsZ03QlCwaMcmtbMjD8s9lckDni5u1CEnApAgcA+XFNIqVq2yeKVVUi14XABpdtz26nPMvYDEqoRFrMybSEJ4+qURG9jV8Nwd/vgswQNgKudeen7UX2B3/2w5rboJTXzd3UQp3bR2EOo34FvTjQ8jkHYGWxpxjrmQg7qzpw/ipxdYprh9rgzXOMdH9iQd0OonLJFr9wE5bKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lll3H3D9tCZGIvI6Bfdvmux16dS+wdOqF8TcaCIWXVg=;
 b=n39nYLmqYmE80xVcbVKmecnfm+zXammW4UPtHhdNomu9koNcgHhjij+7veBng5/IR/dRzuyfEy1SPrHeR8q8V94avF4OFvWl+ooVgWKpX4dc1znA3pTNE+b7Dohr30rhdJ8gygyf/ysGS0RrT0yfTxtI+vM5ViEIT9kO4gst5u57Uog8U9DIr1IqHqYCUJ52eKx6i2wq/h6AKhXcU+pPYH4+TbqILvYaeqa8dCjUue89GD9sNEV6c5UUyqEdC2c3AXk1O8AHlkmOrtxddxs9tTozxMznHUUuEqGyHT7JfGS+m20RCNL8LNMtGQr8mDTk8Q9lghDBNdpXqymA20AT5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 11:41:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 11:41:51 +0000
Message-ID: <35f36456-ee3a-12e6-3f90-83a1047aeb2c@siemens.com>
Date: Fri, 20 Jan 2023 12:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] rtsignals: part one, core code plus x86
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <20220707135952.5171-2-johannes.kirchmair@sigmatek.at>
 <327d7547-3485-1aa4-c686-60e81d4885e1@siemens.com>
 <VE1PR08MB490960CBB789FC9F26E4210192829@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <39d68bfe-f2ba-a183-f8d9-d477d696ffcd@siemens.com>
 <VE1PR08MB4909574295D8F9CE21C7DFB092C59@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909574295D8F9CE21C7DFB092C59@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3939:EE_
X-MS-Office365-Filtering-Correlation-Id: 81893b65-d574-4c57-e845-08dafadb5247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	heL1fejT33Qz++aNAY/WbHChtIXQBx9+Hz02W5Ftr7/BF6spxNvRCcd8lrrUlPJ0M25cBQ/sTp5LzKSKDSdwCBl4qBhnkpauxQpRYnoAqbtgQzxsKVBZkzdfPla/21vQOODwoXb9Qy0O47v1X1VGVw5YiZrch8TN9H36obqw6/280787W/WFId3defKTPfZ2IVgU+eqoRvvi03WbkTH3YJ+lz9Cz1jBr0QjSBgnW1ELfrcO/mu+qb6WuxCroIWT6lkI/wqQGghfondHHUNuTpNtYfEJKOpBDMZfutEGfjrngYWHA3jNxTXxL9d+K9GbliPF2F1MkwtlCuVYzQ7sknKM6yEnuYOG82sgVVmb6FM9jGHMDrAFRS7ibgVlRTLaXJJtbl9L4Y+NC9kTapXKRnBoKe4gHjP+nCF8Th4S4+N4dW/ympnePbHDnwTVlSKIoimLpp/sithcty9AvDFrhUEh6XSXnIY6/oGP88THCijbEwTAwelxQBL+nctgo98VJVeAN9Rvbw+I+h4mcMkbdF2v93jbFb5kHFK22WsprvNCICui3Vr0UofJmpjTE9WQ0XULwHy/CCGEhhd80NEh6jzLfAc/bMr07psSTiV4K35QYa24HE5CXkmmEpu1EUN/Eu4thmMXT0EXxODPXzitswauwKgYZTZeFg6UheorZ41G+TaKskdTt4wVoYbMDsmaTxplEMeO4CNjbTgnToEnDjDmcsxul8MXVMzstLYdSg/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(44832011)(38100700002)(31696002)(41300700001)(66476007)(66946007)(53546011)(6506007)(8676002)(2616005)(82960400001)(26005)(6512007)(186003)(36756003)(31686004)(66556008)(66574015)(2906002)(83380400001)(8936002)(110136005)(6486002)(478600001)(86362001)(316002)(5660300002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGJXb1Z1WVRwNXV1L0FHajNzbWlzNWlJWnowK29USitmZWpzZGVaL1RTTlpy?=
 =?utf-8?B?ZklFeGs2elNiaG94dmwrYVBtRTR5aWpFV2xkZitYVUx1Zmk0WXpnb21ob0ta?=
 =?utf-8?B?cGp4WVpmNzR1Yy9IVmN6QUFGWTd4enVJQ3VmdGd2a05INUZFRUFkY1FhdGs0?=
 =?utf-8?B?bVV6eTR2aUhCNU9LTWJjbjY4RThKM2xoMHNvczcyNkRPS2xlWW91aW5JZkpa?=
 =?utf-8?B?MWFCamJHdXBvcDZVZHQrVGpEMkRDSkdVcjdRSGI4ZG1sQnlZU1ZxUlZSdUZN?=
 =?utf-8?B?SXV5eXl5ZUpGVU5YY3JMbjk2N3ZVVUZXNVF2ZUFtMGNHYnU5ZER3eFBhMTI4?=
 =?utf-8?B?T3Rsa1hHNUF3c09pVC9EM0tQM2d4UHR4RjdCU0UwaE56WmtoNmRsVy9UVWlE?=
 =?utf-8?B?M2gxN2N1MStuQXRzcUx4TmI0WklRUDdhUHdBZkJNWWVkYW5pdXB0aGFjVlAx?=
 =?utf-8?B?Y3l4U0J6c2R5OVBlSXpuSEtQVTk4SUx6dlBERlR2V0dVanE5alJ2dWtPS3A1?=
 =?utf-8?B?ZGVQd3pEb3lWVFdNd1g2WFhZbG5BRXRua29HcDlWSkpNM2xMN0g2SWVjVHBm?=
 =?utf-8?B?L2d1bDcvUUYyaWhBd043OTAvTlQ2ZHZYVWRyMUFmdVZHS256ODJxWnU4QTRt?=
 =?utf-8?B?SEF6WHJwWE82dklxRGRwRXRIaTZsaTBSVWYyY1VTSm9NNHI3b1E2Y01wU0ND?=
 =?utf-8?B?NWhFTHl0NHN0dUFUWGlvY0FHZ1A1cjBDZHNiZVVqNTYvMHkzK1ZsS3REUG5W?=
 =?utf-8?B?dEV0MUMrak43bnNRR0lzVzhVWmtEWDNZSEFCVGFiSVhZZTZBTWwveUdTUHRM?=
 =?utf-8?B?Q2ZneEViOUdlYUZNcDl4U3BBQkdRWjV6RlNnK0hzRGdCVzhySW1iMzZ0b2Y5?=
 =?utf-8?B?a2FyZkxKUDlqemxvbWVPTHhaamRGWko0bTcwN0RVRjd4QzZyUHNUMS85N3lR?=
 =?utf-8?B?Wm9OUGdmdk9KY3EyMUFEZ01wbldYbHV2cVVCUXQzUHRyczFoMFdRQUpMcHFx?=
 =?utf-8?B?MzByM24raCtyRXBuYzB6Q00zTU1SKzM3K0JqYnRVVGlzVFRHek11bk52Q0xs?=
 =?utf-8?B?QVdJYWtGVWhZWTg4T0RZKzNzaEZuTEQ1dStXc2RWSVJHeFNDYWh0WDZudHhH?=
 =?utf-8?B?WTVPdVRJRzRHcFdvRWlPWEVUZG0wUjRFaGJ5RjhqK0o0K2tPU1hReks1alEr?=
 =?utf-8?B?Y2dGZkVIN092a1RVNHZhV0ZCejBGbklZdHFaOWE5YjByUHFaT0hic25Vem1V?=
 =?utf-8?B?cXRTbno4Z0VjUlAzVHZhUnA3UTJ0bzJzNTZtR1hoNFN1dVl1bUMxcGJYaEpK?=
 =?utf-8?B?UDM5WWpLaW9nNFAxVkVGWkZseXZydm9KK0tuWUoxSmVlRmFCRmZOMjllRlI2?=
 =?utf-8?B?b09MYng1K3ZPbDJRbE9zVmtFT3Rka0FlSFVkR2YrWHpyblVyaE9Na0RRc1J5?=
 =?utf-8?B?aHZ4YnI3N0hTSGt0K1pYQlEycS85UG5TVDVsRk1NOUpheEViUzBJR0d3cUlz?=
 =?utf-8?B?RGxrSGVoWmJwNDdWaXoxVDhqMzhoSjN2TmYwOUNHb1padm5yMUVBRFFmd09R?=
 =?utf-8?B?clRhNnJxK3JpUWNqRFAzOGxVWjMyNDJFZGp2V2xZVlcvbjJKcEJ2eXpsenk5?=
 =?utf-8?B?N2trQW05VGVnRHZwOHhNRmVsZndOaXoxaFNwcUpZNEkvMGNRNWhnQk1VYlhC?=
 =?utf-8?B?NVE0aTQ0ZzJlNzlpUWpRN1NkNysxeDFoMlNoKzRGYlMrS3p3dG5qYk1xVFVL?=
 =?utf-8?B?YWpMUlc3OFFpdVRubzZqWXhYYTc5aEJUdndIZHA2Y0Rra3lsTEhMMFVRa04r?=
 =?utf-8?B?Z2paSnphbmo4Wk1RNnZETUgrVHE0S09ObHdvTytrUFhuT0F4TzB4bUhReVpn?=
 =?utf-8?B?VHVDbDZtQndXeTVmMDdYNXU0T0g2d0kzL2NNNGxnVWZSWlRWeE5yeUNHaHNT?=
 =?utf-8?B?WnRsTTZEcVNzdW5ieTZIUE5vYzlNdVIyeHMwT09qMGZZQW5JY1hPem5YRjh3?=
 =?utf-8?B?L0lqa28wcTZRalRTUGR2bnpSVFlMWWxXZkdscUJVMThoM3A4SUs5bWhvdDA4?=
 =?utf-8?B?a20yQ0RXR3lIVy9aL0xwMzhOZVhVenMveE1FR0ZVMjY4ODhHeGF0T2NxbDF4?=
 =?utf-8?B?VjhqMmo3N1lLRlhLM3UrR0hjdXhqNWhUV0xtdkVDakVLWW9EV0l4eW1qR20v?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81893b65-d574-4c57-e845-08dafadb5247
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 11:41:51.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CEAIe4kihOVHfp3TJvZorTZqSY0WP67eURoTPEo6hMt6uTpDbaTzN2QEO6oYKgNd68T7dBRVok+qo7QoW7D0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3939

On 20.01.23 12:01, Johannes Kirchmair wrote:
> Hey Jan,
> 
> Sorry for not responding for so long.
> Got dragged away from this unfortunatly. 
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Freitag, 20. Jänner 2023 10:05
>> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>> xenomai@lists.linux.dev
>> Subject: Re: [PATCH 1/3] rtsignals: part one, core code plus x86
>>
>> CAUTION: External E-Mail !
>>
>> On 08.07.22 09:30, Johannes Kirchmair wrote:
>>> Hey Jan,
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Donnerstag, 7. Juli 2022 17:24
>>>> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>>>> xenomai@lists.linux.dev
>>>> Subject: Re: [PATCH 1/3] rtsignals: part one, core code plus x86
>>>>
>>>> On 07.07.22 15:59, Johannes Kirchmair wrote:
>>>>> From: Richard Weinberger <richard@nod.at>
>>>>>
>>>>> Adds code for implementing signals that are handled in the real time
>>>>> domain. This is done for 32bit process under an 64bit kernel.
>>>>> It works in a similar way to signals in the Linux kernel.
>>>>>
>>>>> Edited-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>>>>
>>>> ...
>>>>
>>>>> +static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
>>>>> +                            void __user *fpstate, struct pt_regs *regs,
>>>>> +                            unsigned int mask)
>>>>> +{
>>>>> +   int err = 0;
>>>>> +
>>>>> +   put_user_try
>>>>> +   {
>>>>> +           put_user_ex(get_user_seg(gs), (unsigned int __user *)&sc->gs);
>>>>> +           put_user_ex(get_user_seg(fs), (unsigned int __user *)&sc->fs);
>>>>> +           put_user_ex(get_user_seg(ds), (unsigned int __user *)&sc->ds);
>>>>> +           put_user_ex(get_user_seg(es), (unsigned int __user *)&sc->es);
>>>>> +
>>>>> +           put_user_ex(regs->di, &sc->di);
>>>>> +           put_user_ex(regs->si, &sc->si);
>>>>> +           put_user_ex(regs->bp, &sc->bp);
>>>>> +           put_user_ex(regs->sp, &sc->sp);
>>>>> +           put_user_ex(regs->bx, &sc->bx);
>>>>> +           put_user_ex(regs->dx, &sc->dx);
>>>>> +           put_user_ex(regs->cx, &sc->cx);
>>>>> +           put_user_ex(regs->ax, &sc->ax);
>>>>> +           put_user_ex(current->thread.trap_nr, &sc->trapno);
>>>>> +           put_user_ex(current->thread.error_code, &sc->err);
>>>>> +           put_user_ex(regs->ip, &sc->ip);
>>>>> +           put_user_ex(regs->cs, (unsigned int __user *)&sc->cs);
>>>>> +           put_user_ex(regs->flags, &sc->flags);
>>>>> +           put_user_ex(regs->sp, &sc->sp_at_signal);
>>>>> +           put_user_ex(regs->ss, (unsigned int __user *)&sc->ss);
>>>>> +
>>>>> +           put_user_ex(ptr_to_compat(fpstate), &sc->fpstate);
>>>>> +
>>>>> +           /* non-iBCS2 extensions.. */
>>>>> +           put_user_ex(mask, &sc->oldmask);
>>>>> +           put_user_ex(current->thread.cr2, &sc->cr2);
>>>>> +   }
>>>>> +   put_user_catch(err);
>>>>
>>>> Am I missing something - or did you miss to add the magic for this
>>>> get/put_user_try/catch?
>>> Tried to figure it out this morning, but don’t understand it fully jet. Actually
>> don’t quite get, how the errors of put_user_ex are propagated into the err
>> variable. Probably in this case put_user_try, put_user_catch is only for disabling
>> SMAP. But I will have a deeper look at it in the beginning of August after my
>> vacation.
>>>
>>
>> Was there a follow-up on this? I'm planning to revive this finally,
>> figuring out if there are pitfalls in going the sigaction/sigreturn path
>> for Xenomai.
> For the question of the try/catch 
> We don’t have really a catch clause here, as we check access to the sigframe beforehand and we only use the put_user_try to disable SMAP to be able to copy to the user stack.
> 
>>
>> BTW, I do not understand why you made the restorer function a direct
>> parameter of the sigaction syscall. It comes from the sigaction
>> structure. And your implementation cannot provide oact when we want to
>> add sigaction as library call as well.
> Oact? 

Previous (old) action handler, see man sigaction.

> 
> Actually I am not quite sure, but I guess the reason was to have a rather simple distinct syscall to Linux sigaction syscall. 
> We do not even pass a sigaction structure to the cobalt core, but just a handler and the restorer.

Enough for signal(), not for sigaction(). But it would be a valid
question if we really want/have to support all features of sigaction.

> 
> There are some things I thought about, but did not find the time to investigate:
> 
> - I copied and modified some of the signal code from Linux and removed everything I did not need for my purpose.
>   Maybe it would be possible to use the Linux functions without modifying. (Primarily the sigframe setup and restore code) 
>   I think it would be cleaner to not have too much copied code.

Ack, to-be-checked.

> 
> - I always wondered what would happen if we have a domain switch in a signal handler.
>   I still have not a deep enough knowledge of Xenomai. If we switch from Xenomai to Linux domain. 
>   The restorer code would make an cobald syscall ending up in the cobald restorer, but not quite sure about it.

I don't think this should cause troubles. Cobalt's sigreturn would
simply enforce a switch-back to RT (if that is needed, didn't check) and
would restore userspace state from the saved state on the thread's stack.

What should be considered as well is an async signal handling in the
middle of the RT handler - whether already migrated or only migrated
upon that. As all userspace-related state is on the userspace stack,
nesting should work, but it all becomes quickly rather complicated.

> 
> - Thought about, if we could use the sighandler stored in Linuxes task struct.
>   So we could handle signals in Xenomai domain, that were registered form Linux domain. 
>   But not sure if possible. 

Also worth the check, though it comes with the risk of making the core
too much depend upon the Linux structures.

> 
> I am not quite sure, at what time I will have time to work on this again. Will have to talk to my supervisor. 
> 
> But would be happy if we would find a clean way of integrating this into Xenomai.

Yes, specifically as we now have the underlying Dovetail support. I
tested it with out current out-of-tree pattern, and it works as expected.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

