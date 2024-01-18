Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A918F40
	for <xenomai@lists.linux.dev>; Thu, 18 Jan 2024 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560712; cv=fail; b=Q2ZrVwnpGKU6FJS8ZIqrXkpOa9XKB8GvW+BmTFvCvdlemccBVYXaxxjEm29jU61foscwNgJQH6xBC1E79r2BOsMpEs5eEgkpRhtcesDP7ik8cxpgYucvViwFCuJr20z+W9CiBgZh6xyW3m93IE2NDIROBvRrtTIMAvvOQr527mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560712; c=relaxed/simple;
	bh=APtw+PHoD7rpt33RCGLy4tCO3C3/+SP/KfgpFyou3is=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=NuqCV17qxBKk38MwTWzzJPLkFexVgvvkJDIjeI5y3qL2O0To6RQGoxODTb2J0besHpZ1t8A7cfwEcPIxfv/uIwYsKRJXMVaW2DW2lKoac/E3QDfg6+hCYSWZONF2FGZbKDoXMHntUgS+sNgf+J7Uo35aXPQljElzlgPuPjGFXOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rMMNFYXH; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rMMNFYXH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcnfgiiZjS8s9nBbjiNUan8zjoVRRrclv2naxJj7+rleE7wrYJ07l66mpHA1/kS6Vj8DAsoIb7t22U62xkF7gm31VkO2YUmBHaaiA+nMS7+GVZPOd3vUE4+TfblordaybqOEY59t9suK7dXbSIbn4JUw8nu5Dfnb6NswYGZW0k9PtLhgkizjNuVwSxTh/tB+O/5MMzQdtz3xZidBoz6gB1/+92DZq1ojoZ3hLLow9qmo+ubZhToVQtuG+86rffxjA2J6YOrZt8CgqPpvpsYVP/dt534mqsbX8rn15Ms3jF0EVqb9DUhNHn7lB8lCTVDP9xkKiUy88+PigGq/FIQcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1Q8gYv16X8axxtKi6+eXr6HuRFrkHixpTc11F42dws=;
 b=Exe4IhphxuQxD4Mg9lekcZn+97L1r22e0oOz5hWQBUsZdR2gYhY8rkrQOwC1sFq3zAZJw2FiWgtYDP3nw9P+tVX55sNnRrIEW2TowtbIEWeoGeiSIvrIniRZuGTWmaK2sI+Nx4kWxnaEpG7D/Kkgenuh0n1zW//3EjylhHEZrUpt+cODCkk09I/nKevfNlJfHIAZS2GVycqbb8jNw4XOtslFdDS6YAwaMGF4KrVSA9Yb7QaMxIelkO+CoGe3X5xNGALDxcmgcoecn+GNRRRXQkX4X/M+1g66qX/n5JM/EKV5DKiCQVEI2sXN8ROVH+QQvp9+rC7AqZF9djSEm1+lYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1Q8gYv16X8axxtKi6+eXr6HuRFrkHixpTc11F42dws=;
 b=rMMNFYXHTzulOLRB5xKM5WTHK650wJs73h+wmMMVmmenWytHNsStfPRRKsE+28+BuEAdRLJ4BnVdBgpOdsWXPcqNEbnPD+PQf5UsQY71C0Dyp00p6BCmmbMqo7OUAxSD7lMAHYnVHJnNJQ6Ee6XE1miIBuxeyy7nx2DbAl2QgbyB/jxY3NGjnoAWpSgsRjmOoOkvfwWgB/Jb0CHWXjgz1ojfV4g1WCnvVhLAnD9X78cwQ2S60BOtPUGU0Wvyek92rbZDEPCDcri5X7Y/FS8ZZ7QwdQveu1pgQsN/GG4Fztmdpr7fMBu3JWLlQcNU5RSYBolr2Y3rDW6dA+02P58VhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 06:51:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 06:51:45 +0000
Message-ID: <e70b0272-8c4a-479e-b7f9-2dbfc6771389@siemens.com>
Date: Thu, 18 Jan 2024 07:51:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Troubleshooting x86_64 evl bootup
Content-Language: en-US
To: ivan@rtxi.org, xenomai@lists.linux.dev
References: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
 <34ba04db1b45f6c546a2195f0a8e0ad3@rtxi.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <34ba04db1b45f6c546a2195f0a8e0ad3@rtxi.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: dc07709e-2dc4-4127-0dda-08dc17f1ef51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iwCgatCRxHXVspkqkymgtfEkWWLwm9KrOoGggdaQpCmQ0tXgII9O9w+6sGFEl9JSi9gIT4PmG/y8VfuPeAPBMHTT2Dlf+adBjEMGPxAeJHGcAKeEKz0zkPdqHOTdcvWDk1kgBEpGaHFoY/OLZ//L50T8o0vGVUy2TA1kYjV3BmI+ijljey0gg/R5Fgj6Be73d3mDMm28FhxD1dGyzW6f9tJEvwKy77N9VEJ+Pp99b83GKFtNvW3TIMUF4hO4QM5OuevZVHk3u9a8YIacDsxnN0COLytQNs6Idf3M7qFrozli4qWl3KLyiHGpjSnYbUI1ktC4kxaxL+QXiP4YWNSpDo9iy+batsZjRVEN6ySUO4zSOY6vTJ+k+cqzlRiIvKpRQDi9ORUNZ+oeFvKmPSKCdcA7lQCg2vN/DDcokbhGgKpJpuQpw+BrbGm8sDoxwt7VP+jBbBese2xKMvjanUmusXb+/BsHwKhCcv/zP7KILKyui0hGLGibWv99ZenTsWrUXNV6wbBR/dFIw9y+JqDDEdFS9SeqpA5GXqSO22W8MiF6+dSF7Yji1HfSb31dhB8FbhLvb9oLljwW6L6AUrSz/HtMGbMe02RXgu/jX7YqYOBBisifVbzz52xCg4i2x5SkjmBdLS6LBM1jpssl7Z8FNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(83380400001)(31696002)(86362001)(36756003)(82960400001)(8676002)(8936002)(53546011)(2616005)(38100700002)(26005)(6506007)(6486002)(6666004)(6512007)(66556008)(66946007)(66476007)(966005)(5660300002)(316002)(478600001)(44832011)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUlzZmlVem9JQzJnOHpSRm92Rk1BZ3JQZERJa1l1dGpoNjk0ZnJ0elZUcUFo?=
 =?utf-8?B?ZzdXUGlWR0RZbk9nWHpHS0JGNXN2RHdoVEY1K0lKY2YvYXZYazJvMjJkRnMz?=
 =?utf-8?B?Uk5tVjRFa3JuR0QwZlN4N0NaSm1ITXZwZjFDaHZKa1MxWmNlWHZrTEphZFU4?=
 =?utf-8?B?Zll4YWhCK2xRZlNPRlh2cmRMdkFNVTQwMTVKSUZORTJ2YzZhOXdPanp3MG1v?=
 =?utf-8?B?aU96dUVNbFEzZnlYR2tpbEhabnhGVFlGMWZLK1ZqV3JjcVR3WmpDOUJEVkRP?=
 =?utf-8?B?Z1djd1hJVFlvWXRFWUwxbDFRemRaUS91WG1pLzA2NEQrY3FzN1QrUVB6YThv?=
 =?utf-8?B?eE1tcjM5RVc2Q25vR2VVMUp4SDB2eEhqTFlLRXBxdGpabms0ZU5Vb1owMlJl?=
 =?utf-8?B?U0VwWFZQa0kwajZYVFl5ejRYbllDY04wdFBIdW9JNUdBY2pIWkZNWWF3Q3cw?=
 =?utf-8?B?dHZTZEhrbm5KYjNWOXRFWWg1WnpHbTZuc05YcVhaTEQ4WG96dVR5dGZKdFBm?=
 =?utf-8?B?Yml5TEpITU9mYUZ2bXM0cFJsRVptRXh3TnlyNTdPT0YzdnNJN1VvNEVRTEFC?=
 =?utf-8?B?Vml5VUtOU3pCK2w5anlQK2NGZDhkY0VONGpocFJRZnJYUjFmOGtXclFVTlhV?=
 =?utf-8?B?TnI1OCsxdyswTDh1b29XMXhWeWExNDA2b3pBM2l3cUI1N0tpUmtaMXU0L0xM?=
 =?utf-8?B?bExsSm1ic1d6SkNmd1NSeW4vaWFaRk50MnNUZ2ptWXR5RjJwb0pKMUZyWXhu?=
 =?utf-8?B?RndwUWR4M292cnJPUkppcXJGSkc3Tmx6Y1ZoUzRQeWNycGZKZU1CR2thcUNw?=
 =?utf-8?B?RWZWc3NnTTdsdzNjVEZlRkpHdDh3dll5VENlSXVsOGtTSE9uT0JzNkdpNkQw?=
 =?utf-8?B?QVZjUlU2UVRQMGc0Q0UwWDYwMmFIOCtldzNWbEswY3VpaTYzZ1hQQXFTM0xo?=
 =?utf-8?B?cjlYT3ZoUkdXQ29ORnc1QTUzMmFpMklUVU9iMjJpbkVYNHlRTGYxUU9icDhj?=
 =?utf-8?B?eTVYYXMyVFVUekhvNVdHSXlMWFhBOFdMVldyelQwSm5vNXBQMmwzMGxPK2Rv?=
 =?utf-8?B?Nzc0RktUdEFGcG83Qjg4WDhBOFM2K1BGYk1rL1pVUTNNM0FRNUVlOGpKK2hn?=
 =?utf-8?B?amY3bVU0N2JsajNaQlFwSWk2T2I1S2IwREhtRzI2eHR1SDZTa3lGSVNZTmVM?=
 =?utf-8?B?bzNZd2R0WUpPQ0o5ZGlUa3ZDazZqR3FPMkx6dlBaN2JrV205MzQ5RGxUTDAx?=
 =?utf-8?B?a0NNd2ZCOVFvYWdjOVVKU0hraXo4dEtXdGtuejl4QXpzTHNRdjNZVEdybVlG?=
 =?utf-8?B?V0I1cjU3Q1ErNERaYXdqc092dkU4SUVZYVRwclRSRHdTR09SSDh6aGExSmlz?=
 =?utf-8?B?MVN1b21WNGkyYnlVUU9KOWpnUUZPSmFVVWZ3UlR5aDNnNlhKMTZmQ2RSNFpG?=
 =?utf-8?B?UjVjc0xRMzRJZ0xkdzJIZGxyVS9rM0h3eTgrZ0hUK2x2YnhvTWRjT0JWNGNS?=
 =?utf-8?B?ZUpMTHpsWFdzWW1vRlNhL3h1am9waXovSS9zcmw4Y1dNTk9xNVJKK1BBNG5O?=
 =?utf-8?B?UzBucndEc0JYRnFucGQ1UjJqR3pEdjBsZG11MW5YaGJqNlZKQmkyNmJYNGJ4?=
 =?utf-8?B?R2lBYmMvQTJLZ0dZZDJxQkEwYzEyZVQ2RCtXUGNFNlJYT3c3amlWNVBWbE8y?=
 =?utf-8?B?Mlk0Vk9SekdrWFpjU2lETktRV2JGdnR1bVhXU2RaUllnYnkvT2tUR0xBZklm?=
 =?utf-8?B?WG9TakY2MTFNQlhmemdYUjFRSGNxVDVOZHZpcGFiKzdYNnRRalZ6VThuSndX?=
 =?utf-8?B?SncyaGZuR25vY3J0Y3ppQnl1bUVwUmhTZjkwUC9aTXQ1VzNLSEFIOFhpb3dq?=
 =?utf-8?B?cE9BdzYxOWhrWGNYcmI5Q0ZxZU81NUpFNmZKaDd4SThRTG1ETDFsUDJCT2ll?=
 =?utf-8?B?UVpmYURTdUxTcjBza2tpMHJWTWZuc0JCem9ISU9LcW1ObzNIOE9XNWxPSWJi?=
 =?utf-8?B?RVJkYXh1M0wwQTNmUTdDN01XbFpEeTVEdmo1WjlIQUUrckltVStiK3pBSnlI?=
 =?utf-8?B?R29xYVFOd1VhSWJRMHZiUnFhdVRKY2lOc0I4RE5oN2JVVjYwSVQxOWZIMUpy?=
 =?utf-8?B?UmhRVGE3MVBiaGtmLzB1cnFNV25rUXdZV3dFOGJ5WkhPWlVqZ3l2aGlUdXZw?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc07709e-2dc4-4127-0dda-08dc17f1ef51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:51:45.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubFskB38Bdo8e5xkaRGnMuf3gsDmgKP27wpNwiPG6t2BrV+2Hn2ys3CgY24zllEdZZ6s11FP+99SDzXSRt3MOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7492

Hi,

On 18.01.24 00:22, ivan@rtxi.org wrote:
> On 2024-01-04 13:34, ivan@rtxi.org wrote:
> 
> Hello everyone,
> 
> I tried building and installing with a newer kernel version
> (v6.6.y-evl-rebase) and i get the same error during bootup. This time
> however, there is an additional message:
> 
> clocksource: Switched to clocksource tsc
> 
> After which it hangs for a minute then the same output previously
> described is printed. Am I doing something wrong? What additional
> information do you need?
> 

Yes, kernel config, to begin with. A complete boot log would also be
nice (catch via UART, please).

There is now a demo image, also for x86, generated via xenomai-images
(currently only in 'next'). That config ([1] + [2]) may be lacking some
bits you need driver-wise, but maybe it's worth to check and try if that
one makes any differences.

Do you see this boot issue only on the Phenom hardware or also on others?

Jan

[1]
https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads
[2]
https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/evl.cfg?ref_type=heads

> Thanks,
> Ivan F. Valerio
> 
>> Hello all!
>>
>> I have been trying to upgrade a desktop that used to have Xenomai 3 +
>> IPIPE to the new EVL system. Compilation is successful but the kernel
>> hangs during boot with an rcu error message followed by a stack dump:
>>
>> rcu: unless rcu_preempt kthread gets sufficient CPU time, OOM is now
>> expected behavior.
>> ...
>> Call Trace:
>> <TASK>
>> __schedule+0xd76/0x1950
>> ? sched_clock+0x9/0x10
>> ? sched_clock_local+0x17/0x90
>> ? inband_irq_save+0xe/Ux30
>> schedule+0x69/0x110
>> schedule_timeout+0x19a/8x2f0
>> ? del_timer_sync+0x50/0x50
>> rcu_gp_fqs_loop+0xf9/0x470
>> rcu_gp_kthread+0x15a/0x210
>> ? rcu_gp_init+0x640/0x640
>> kthread+0x12a/0x150
>> ? set_kthread_struct+0x50/0×50
>> ret_fron_fork+0x22/0x30
>> </TASK>
>>
>> After some digging, the evl page references possible issue as "loosing
>> the tick device" but don't know how to confirm whether that is the
>> case here. This computer uses an AMD Phenom II X6 1035T processor and
>> The kernel branch used from linux-evl repo is "v5.15.y-evl-rebase".
>> Any suggestions on how to track down the issue?
>>
>> Regards,
>> -Ivan F. Valerio
> 

-- 
Siemens AG, Technology
Linux Expert Center

