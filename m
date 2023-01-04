Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001F7EA
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 08:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuZ3iYxCDHpM0y5M27pKI16i6h79EwW0v46g32PuSQmCnX70qCvMU+c/PnE7I+nu2g2r09MbSh+cgJSihg7scTv//sdLz1qmSsDic3kEiM8QTwTCJC6P+ZxAJsGxyIK7g9wItZldnQ96AOQbYrjE3MTv8sfNcIKdgyIBZ4vA9OA/ZczKA9r/xrHk/tFTqXwDicBAbMxvlYCf0x4Pw1Nhh45hIJ/RIxCbd83M5Ig8MqrPFlfDXYRG/zwGfbRebs/dAzhzthElpzPQv79n99fDIkoQs8WGwQ0S3cF5DNt5wsZ2Lw3Lgh0WUZaw1fSx7yi1mLoz0nU6gyC/ndRNWf3I+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcnMlBDjZUuYKK3/8jGJ1ggaY7Vh9Efsa/N2QHhIx8Y=;
 b=MSuqOICD6thLIteh8q7nsbv9jtrG1Yy9Rrf7nA4nL219GwsMCHbLs8//k0yDX+0pIJJg0JbhOBjzM3dYGWwIo8DVvJ52vwkb0682cmocPgiFNcBCzgHzKt9gfIx2kunloWMQdYNNlv0jKTVZdIR6PmKeNOdwQSDKuVbT2TyDzliicT8RYraJwOTr5QzqdzaYV4e2dchISril7iYhI3e+uH+FaGque+7bQ5FToyGVY/p4CDshJkri8ASx+l45FCY2CV8lqi2J9W1OSXVf9bUoo/lpe7lU5cF+Wz+REoWv0tZ2awIXsd21mt1axD6mUMCroxAt7G60CsErf7h2/E85nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcnMlBDjZUuYKK3/8jGJ1ggaY7Vh9Efsa/N2QHhIx8Y=;
 b=qra4kVJImxnNHaIwWlGQG3WAgzjxtR8856F/vGnctDyGIL8b+a9kJ9DrqACugpFJ6reaAtVb6yGh6RqieOeTwexlytNmCYkEiTwFK2w6l8CYgNbYFEKdYjL67HB7KLavXRS8TjCWga7Gr1CVTzoi4s2YfM5+HLowl5YYITl0MIG98S30fmbZl51qkXgd0Snr2XGQsK3EfPLt5ltAgLRH4eMLqXTseAgVVaa5rizcoBG2Ffkw/dZXZZrVFLiWONp6hVKg4gxL6ASsECRVLjHXe5I3X6uB8wEkxxoy2x9Pz21rBrpxCOk+S5xXp6slr0uwHaSgFZ888xekXKqlYERJAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:53:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:53:51 +0000
Message-ID: <9cc96df8-fa87-23f9-9ce8-3914dadc17ea@siemens.com>
Date: Wed, 4 Jan 2023 09:53:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Is there something wrong with xenomai3.2.1
Content-Language: en-US
To: "Yxian.Yao" <yxianyao@126.com>, xenomai@lists.linux.dev
References: <16f22de1.2b6f.1857ae4c31c.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <16f22de1.2b6f.1857ae4c31c.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c57eb1-02ee-421e-f1af-08daee313380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c7C/4jWOArIEKP8yuaM4gFtAweDMbeCc7WdhRVkwUxoz2PowWEvXM8zynfY4SgCEFDAyjp2b5lze0XYhkS9QjVXr/DzPYWIWdEUAmUiHC7lXabigTysMinZe4DpAjFdwCZuvZipowRlkGNw+QJUf+xnA8/C6Mc6EvP37hfqmAgscZR0lVt2G31EuqNI+7TBqYFc6KY20KUsBMECD1rIzrt9Zr3Q8rnywVTdSpl19HKoKvDGe8EYIWsW/Icdzz/wGoJSiIOYReNes31pdv7KqW/8JlMP5s/+PYStBWnMmVwfvzA8BuzUQAVXljtuPFnsaaaGIcji5vV2r8OFv4C9BprJCnN2nNbfIipe8F1PpiY/UTTP7mKz5m/UsYtJvH2Kn2Cf7W25578PewgKtC6ZVxJp5Nxxj/737l0i3/O4fK+gN33tgkFK1Z/dqOT1Yw8xUq6BQBShDrqnN+oWfA4X26FNbPJIfk/RXyGTYKxWIgv0APPFpQjtKajUWugpRkcDqpw8HM/Je/finywVqTUu9uTJN8nIgaVG4iNYJ90zxzcZl+6zMD+McnF2E3paxH48xt7zj396tPsQvdfZcIj/WfhZJO8WmK/We9PFzDvJXvmuaFAfO9lJVUfI0Ii5daA7X5mX9byKS5kZChnDNSB60bAsBB+hBa/DyX+uxDEUl70QdGP+QddjDv/96FTfV/ik2aQ+ESX+o47T4i0jF+EhmNw1celYENnoXMX4Vj8yN5LlxR9OFu8/FJtfL1zU7IoOg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(41300700001)(478600001)(316002)(66556008)(66946007)(966005)(66476007)(6486002)(31686004)(186003)(53546011)(2616005)(26005)(6512007)(6666004)(6506007)(83380400001)(82960400001)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0JkWXhOVE5tbjZYNzdxWVVZWEoxM3JoYzhyY3dJOHpkckI0eTluTHE1cUFC?=
 =?utf-8?B?eTBVRTdNaUJyQkpXRkN1THAwaWQwL2l1MUZ3QVJxVHBFZ2hSdWxvNWNFeW5P?=
 =?utf-8?B?azhEOHoxdzJ3S2lWcW9EMXM4Z2l0R3laVTA4RVU5eWZZODZ3cDZUQTM0MWFD?=
 =?utf-8?B?cXRJOTFrbXZiSEowNVRKWGhScG9XSzJEQ0ZFd2dvb1ZWZzJzbHQ1SW1aU09h?=
 =?utf-8?B?VnlQUFlNWXIyeEFjbEhRb3lXVjNIN1JpeS9jcDFqS1NvZUkwNU4rRG9VV1Bs?=
 =?utf-8?B?U1BxVmtoMlhZRHlvejNqZFVISHU0SUFXYjlBWmtrOVNUNjhoRHRwQUF4M3Vj?=
 =?utf-8?B?RXRDTkw5d3BDVVd4VTVZRThnVGVqY2dJQVlpRXR2ZXh1UmcvY2ExaFBWMHlt?=
 =?utf-8?B?MVMwMndLTm9BQzBkZnluSVYxNXJUenNKY1lwclhjVjc5VzRhUy94U0F6TnVE?=
 =?utf-8?B?UWtsVG9SWlpoWXRXWE5GWVVFQWVESFo5c3hRZk5WakI3L3F6R1BnZDV5ZURP?=
 =?utf-8?B?UzV5UXh4OHNHcUM2ZmdQK0NZbUZDY2tPTUU4NE1qZUl1LzFWcmRaaTFsMlll?=
 =?utf-8?B?aGxNOW8wNzJITW8vRldEN1hZcW5Na0FaY2xhMlFDSnJ2UlpTUis1aWJoenF0?=
 =?utf-8?B?dGNKV1VGbTh1MEhxVEJJRmVSYVdlejE2cmJpTnpVNmI0RGwxRXZTYTd6NjZl?=
 =?utf-8?B?SVVmSXVtcG5wRnJEcUMwK3dKT0VjeHFrazJ6ZDc4dzlndEFGbGlCQ3JuUHZ2?=
 =?utf-8?B?UGt6bEoyU0pQSmk0bGN6ejhMVlh0ZlBvV3FpaW1SbGFpeU5jY0dQc0FWbEs3?=
 =?utf-8?B?OVYxb1QrNWloZFdwRU9qYWFUV2w4MW5RNC8ydG9VNHRVY0hDbHEvWVEwaXl2?=
 =?utf-8?B?RlJRdml6NnlmYm5WaWpxWElsS20wLyttY2g0UHdrZmJBV2h3MWxzQ0dKM29P?=
 =?utf-8?B?ZTNteThNQlVEOXdpYnF6aHF1UkQ5SWY0bmI1eERvYTJVT1pITzJkSjJNNFp6?=
 =?utf-8?B?bSt0enBNcHUwV2tlRFRaZk1OOXpSOEpabUJxcVBHYUhZNnFicDQzM0NhRzZ6?=
 =?utf-8?B?MmJPejY3cDZCZG0yRmtRRXE5QldJMUl4aSt2azRVc21xSndWNGN3Q09pTjNX?=
 =?utf-8?B?NXhqdGZJdkdibXZlTlluM2dEaTBWcHV0QjVvN0FZakNiZTNTMDZ1UnFTanVp?=
 =?utf-8?B?cGJJUnB2S3RXVE1TYUFSM3FBV3FpdXBrWWxtSEdsQTZId2pzTXZOL3I2OVll?=
 =?utf-8?B?Y3c0aXpmUUtta29JY3ZqY1Q0dUkzVnpkeVZrT2YyQ3lacExnQ0F5QmJyRTNX?=
 =?utf-8?B?MUhtb0I2bmtPb0dFYnJkUFFwU3UxTHk4N2VDcTQzcWI3b0t4UkZVdSt5NEtj?=
 =?utf-8?B?R3ZJNTd4T2E5OW5HeVNmL1c5R1NDRVpIY09SVWExMmxLamNJeXpsTlVTWEhI?=
 =?utf-8?B?MWFuL05Nek9mWk5tTEZ6WFk3clJqcmRDU0VXbWdXcU9LVDNMYzBEK3RYc0pt?=
 =?utf-8?B?bkptbytyRjJKUVdFOEJxWk94bEROQk15N2ovTHRjNVhraFZnamVkZmxQMVh3?=
 =?utf-8?B?aUgxTTlCeXo1ZTU3QzhoOFdJb04rVEZBKzZGQlQwVzRxQUgvb0VnL3ZLenhW?=
 =?utf-8?B?Ykx3TUJSdng5TlV1dHA2alVleGJKQ3htQytveTk5TE9kdVZlSFFBOHgyU3VR?=
 =?utf-8?B?WXVwaFpxaHZwN2xPdTNWUGk3d2k2OTZmc0dPZWFsWDF0Y2t6WkJDdjAyVlQy?=
 =?utf-8?B?bTdzbUJTR3BXTVJ3UVBqT3BJeTV0RUhMMTJaQ3U4bzkwbHZQOUhjWnRvaXZ2?=
 =?utf-8?B?b0k1UjM3ZkgxL2xqODA4ZnJNTHRSVERDUmVZd2s3em9Dd1h0S2JvbndUbzBP?=
 =?utf-8?B?NEE0K0FrM3pqeGZtS0N1MEs1ZkRSUkZrbEdqTWIyK2NXL2VCZzhGWkxaREgy?=
 =?utf-8?B?UDZiVzY5YWpqbnRuSENLM2tDV0VyY0VCUlIzL29oWjdNbHg2TDl6RytqMVlB?=
 =?utf-8?B?SndiTTRDN2FqUTZ2UXFBaDhNY3JqRUs0aGZMeFcvVkIxUUtDT2t6a1pYdEI5?=
 =?utf-8?B?M3dXZlZId1pPS1JuMDNxc21ZcnRwR3N3RUllemlici83MThlL2NyZlQyVkVN?=
 =?utf-8?B?ME9KaU1xK1E1elZNSHlCM29qQkJNS2Z6cDBCRERWOWVuOVNESHdjT0NCY2dP?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c57eb1-02ee-421e-f1af-08daee313380
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:53:51.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZhvdhB5wf4BquOYYnoLFywLc2oHcV11cGt68VKwbhIwYlap8JxjCHP/xG/mGW1IiSJp95TxEh/jzZd7Ip3yig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6729

On 04.01.23 04:48, Yxian.Yao wrote:
> 
> Hi，
> 
> The following information is prompted when compiling the kernel,linux-5.4.223-ipipe-11-xenomai-3.2.1.
> 
> root@debian:/home/uih/Workspace/build_kernel/build_cobalt_kernel/linux-5.4.223-ipipe-11-xenomai-3.2.1# make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CC      arch/x86/xenomai/ipipe/machine.o
> In file included from ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:22,
>                  from ./arch/x86/xenomai/ipipe/include/asm/xenomai/thread.h:24,
>                  from arch/x86/xenomai/ipipe/machine.c:21:
> ./include/asm-generic/xenomai/wrappers.h:176:42: error: expected declaration specifiers or ‘...’ before ‘&’ token
>   176 | #define mmap_write_lock(__mm) down_write(&mm->mmap_sem)
>       |                                          ^
> ./include/linux/mmap_lock.h:9:20: note: in expansion of macro ‘mmap_write_lock’
>     9 | static inline void mmap_write_lock(struct mm_struct *mm)
>       |                    ^~~~~~~~~~~~~~~
> ./include/asm-generic/xenomai/wrappers.h:177:42: error: expected declaration specifiers or ‘...’ before ‘&’ token
>   177 | #define mmap_write_unlock(__mm) up_write(&mm->mmap_sem)
>       |                                          ^
> ./include/linux/mmap_lock.h:24:20: note: in expansion of macro ‘mmap_write_unlock’
>    24 | static inline void mmap_write_unlock(struct mm_struct *mm)
>       |                    ^~~~~~~~~~~~~~~~~
> ./include/asm-generic/xenomai/wrappers.h:174:40: error: expected declaration specifiers or ‘...’ before ‘&’ token
>   174 | #define mmap_read_lock(__mm) down_read(&mm->mmap_sem)
>       |                                        ^
> ./include/linux/mmap_lock.h:34:20: note: in expansion of macro ‘mmap_read_lock’
>    34 | static inline void mmap_read_lock(struct mm_struct *mm)
>       |                    ^~~~~~~~~~~~~~
> ./include/asm-generic/xenomai/wrappers.h:175:40: error: expected declaration specifiers or ‘...’ before ‘&’ token
>   175 | #define mmap_read_unlock(__mm) up_read(&mm->mmap_sem)
>       |                                        ^
> ./include/linux/mmap_lock.h:49:20: note: in expansion of macro ‘mmap_read_unlock’
>    49 | static inline void mmap_read_unlock(struct mm_struct *mm)
>       |                    ^~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:262: arch/x86/xenomai/ipipe/machine.o] Error 1
> make: *** [Makefile:1739: arch/x86/xenomai/ipipe] Error 2
> root@debian:/home/uih/Workspace/build_kernel/build_cobalt_kernel/linux-5.4.223-ipipe-11-xenomai-3.2.1#
>  
> I found that there is a definition in the file(./include/linux/mmap_lock.h), so I commented it out in the file (./include/asm-generic/xenomai/wrappers.h),like this:
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
> //#define mmap_read_lock(__mm)  down_read(&mm->mmap_sem)
> //#define mmap_read_unlock(__mm)        up_read(&mm->mmap_sem)
> //#define mmap_write_lock(__mm) down_write(&mm->mmap_sem)
> //#define mmap_write_unlock(__mm)       up_write(&mm->mmap_sem)
> #endif
> 
> And compiled it again. 
> 
> root@debian:/home/uih/Workspace/build_kernel/build_cobalt_kernel/linux-5.4.223-ipipe-11-xenomai-3.2.1# make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CC      arch/x86/xenomai/ipipe/machine.o
>   CC      arch/x86/xenomai/ipipe/thread.o
> arch/x86/xenomai/ipipe/thread.c: In function ‘xnarch_leave_root’:
> arch/x86/xenomai/ipipe/thread.c:429:20: error: passing argument 1 of ‘switch_fpu_finish’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   429 |  switch_fpu_finish(&current->thread.fpu);
>       |                    ^~~~~~~~~~~~~~~~~~~~
>       |                    |
>       |                    struct fpu *
> In file included from ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44,
>                  from ./include/asm-generic/xenomai/syscall.h:26,
>                  from ./arch/x86/xenomai/ipipe/include/asm/xenomai/syscall.h:24,
>                  from ./include/xenomai/pipeline/pipeline.h:14,
>                  from ./include/xenomai/cobalt/kernel/clock.h:22,
>                  from ./include/xenomai/cobalt/kernel/stat.h:23,
>                  from ./include/xenomai/cobalt/kernel/thread.h:28,
>                  from arch/x86/xenomai/ipipe/thread.c:25:
> ./arch/x86/include/asm/fpu/internal.h:587:58: note: expected ‘struct task_struct *’ but argument is of type ‘struct fpu *’
>   587 | static inline void switch_fpu_finish(struct task_struct *next)
>       |                                      ~~~~~~~~~~~~~~~~~~~~^~~~
> cc1: some warnings being treated as errors
> make[1]: *** [scripts/Makefile.build:262: arch/x86/xenomai/ipipe/thread.o] Error 1
> make: *** [Makefile:1739: arch/x86/xenomai/ipipe] Error 2
> root@debian:/home/uih/Workspace/build_kernel/build_cobalt_kernel/linux-5.4.223-ipipe-11-xenomai-3.2.1#
> 
> Is there something wrong with xenomai3.2.1?
> 

Yes, that's why you should use the latest stable version, not some older
one:

https://source.denx.de/Xenomai/xenomai/-/commit/37714297bb36a7b7c878d6dcc271e486cba34a83

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

