Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1A6AA5
	for <xenomai@lists.linux.dev>; Thu,  7 Sep 2023 13:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAnneWqWx3pvX4lY35udSiadTsBH45N6C0zAh8/ph23VtbYvU/9rmwXsm73XkbWedZ9Q9dTm3YtT9ThjtMNU9Z7z4QN41XuTEO+FKiNgG4zOnpe/DoFmCZEvHnjCI8ReYqyjYrSGPcM+1uAysqkiJhZDW3xh9u/RqiXSG76cw/FYDN89rYZmA4a0oSb7yz7BcloLoScs0EdOZVwGjyrx+hPH5ehF3JTMTVHk52awwzvQ6Ppk5co2K2FnUB6r+Eukn9o9nJ/xO1xQWAlSdrRi+3mUbZLgX8PfeMJItZuQorIqEvJK0E8fUbdru74C/qnKR03+WPfPe1vV97G+QVyPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAzEIoyCNE+vYVc9idErDkZQvp0NWArJkjzyLiwVOWw=;
 b=LHpQs/5Boj8JKdySy2Tkcq5NtRoCrYzCMEP5eAJyC+uug0rOwiMBAxcwQeFZNlBnAHOdr0EYtul9XbT7xaL+VKszi4xvtxVGOMGjktJ5SVEoQKCnMrETmS3y3QThVpQc5zS6He4hmu4fyn+4SZyEZnl3IuSDKAaOM+95MUhl7iNV5S8TKP/PMJ6Jrkm1iAwUHZQY4Rbop8I4cIwG9IPQ03IB19ZQcKlU1GZxHQSz2bMxu97MwDk9hgh27rPRhRaExTWJRVyUqD5PxFXwCJnyFaG7gPPKUziHSrAZUcB0N52edajhVXHY6cAWAI3sOv6MeiZGvvwlHNO+yVt2SBCNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAzEIoyCNE+vYVc9idErDkZQvp0NWArJkjzyLiwVOWw=;
 b=FMh4QkzOAQVOTn5xzZ7mieC2dlIRO5kgm6CHNc9CMweCWeZnW9OzUqNBna+PqBd+Pd3Mq2TpTiAu1M3JLgxlM/Fe0MnRfixZ8vSV8iCFuOjzLbFJhjSvqLAGBzvqgr8Y1U7kMK8P1s0LN8ezkA4pUOkkOk/g8QZ5vKsn2bBilGHDqmdK7R8/DhRSCucJWc6MdjDfE1C1zV8xq53ggjs5ZBMGsFj6w3pt65o3KFPTyNyk42wTx08uBw/0OHCYUpGPAizcWzTPTK4geJXBmIoWQWSuQA5Fsimp2dp/ZiGAf061ECN9cD32v00Y7ES72lDrNKkDOnr6/4i0ctOdJqq2TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Thu, 7 Sep
 2023 13:39:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 13:39:43 +0000
Message-ID: <87fce991-3883-4fdf-9d80-9a797f09db29@siemens.com>
Date: Thu, 7 Sep 2023 15:39:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
 <61984786-9ecc-4605-bc07-70827584d3bc@siemens.com>
 <VE1PR08MB490971F4934FF3D73406070392E9A@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB490971F4934FF3D73406070392E9A@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a59f592-4ca1-4401-3525-08dbafa7e44c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 cfyKetDnurEVHdStOITxG0SSI4vAWvYFz2nR98tigrqd8uJsCMpukpF4lccbkhFGYKToCLALJNuOIbhKW8T/S2ZQz2vG+10hofjtJm10hOk3TFAAXTg+DS0jyfFqE7rNxBFPguNOkzlCenZtgBYcGgUhc+xWvaFlO+bgt2LDRn3v7zbVIOY1UtUhOoDohFa1gZQsCKjSNwVFMPqx+Un1xiMxJ+uKdSmr6l9WZe6/+wZzoBvY3v+ScSUSmaelCThx/jV4qbqafSKjovkYPfL1N7Gdpixg3JtPDJ9V8xw95YLnkJ0YXmfGz99xyD1WxkdHXoCqqZRDDJspIX52eBZBlpDBwOhOaRPfSYnkMjLO/KEl++YPyX8SixAfgFqEG9/+VSy4wTOnCVlwCxxN/bGcuVSMiMYYWfAtcyGagexrmKxpE8FFyieXFndxM5C1nWQR9F0UyCFiZFczdmLN0V0YzGmEEkUh/eep4FFO6OyCl13f6u4VKc/Pgs71ZSb8fymptgszCitD5JRd5+S8at6GwlpAQtrSLbTjp69dvC5RZOum7dmtKk7ska0VV1yVaBNYAgDrMXZNKgLAJnrdccyzX3AzG3NKzSSwsvEllVADlbNUlUHIwIyy9z6gy6lZUylpUda43M++TqymyU9mmHeRaw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(31686004)(26005)(83380400001)(82960400001)(36756003)(5660300002)(44832011)(86362001)(31696002)(41300700001)(6512007)(66946007)(478600001)(2616005)(110136005)(45080400002)(38100700002)(6666004)(66556008)(66476007)(2906002)(8936002)(8676002)(30864003)(6486002)(53546011)(6506007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NUJZd2U1cnY0OVA2WWU4bWRvdGxBQ20zbXRXQ2RXZmFmYnJhZHNaa0poR3hS?=
 =?utf-8?B?MktFZ0FwMW1QZWltdHZYUDBXNDBRcVgzZWttRE9ZV21mblVNZWhBZDFReXlF?=
 =?utf-8?B?cmQvRDl2QXZqdmFIcllVM0tpR3ZRa2xTdXhpMlJUVVN1cmhLNGZweURwTEhB?=
 =?utf-8?B?NzFYZTR4dVFiK2JlMXUwWjB5a2VJZjJ5Zlo1cDB0elBvNmpZcng4MkJWNUU3?=
 =?utf-8?B?MHZ1TG0vd3Z0azlOOHgyZkdoUk5yR1VIOGd5eis4MFc0K3U0YzFQSHZKN1Zl?=
 =?utf-8?B?SFZBSlVEWno2RWZjZlMxcW1JWVBDU1E3dmdBWmN3V2lSYWFaeTJ2UityQzg2?=
 =?utf-8?B?U0lmR2R5ZEhQaUM3WGQwamQ3a0JEaWtZZmhwUmVtWHhJd0Y1eUQ5VnVEWmFW?=
 =?utf-8?B?OW9zYzFtMHY5WkR0ak9EeUw0Wjd1UU5DMGpEc2pOTVBEa1k4ZjdwTFBGOXRh?=
 =?utf-8?B?Z2N6NVpSTHEycUV1ZnJyZE83ZjI2V2liU3dPRVptQVB5K1dGb1oxOXhDbEZB?=
 =?utf-8?B?Z2FEQ3dkdVE2em9NV3FKVVRGdkZYdm1qaHJ0a0hqcTcyMlR5SCthYTBSQ2NX?=
 =?utf-8?B?bVpxVGdTVEpLbWNIczNmRkVaM3JtWEdQb01oTTB5TGlMSXhJOEFKQ0FXc05o?=
 =?utf-8?B?c3BSQ1BUZjVhZys3cnRXTFp4Z3RIRGxBR3JZVzFLWXpFRDhuSUVqSjdxZEhF?=
 =?utf-8?B?K01GVDlDVmtNbmNuc0REYXZrdTA0RnZvblhrZlE2SW1mUTVubzJkVjFHMGdJ?=
 =?utf-8?B?TUhpQ0hFbjNNQVNkSVFvaHBEY2xhZy9ySExaUXUrYkxpbDI0aFptUm5qMVNZ?=
 =?utf-8?B?VWFYa2pweUVxRkZoM3FEVjJBMzd2TzRST0ZoN2REUXpXajkwUlNFcUVIai91?=
 =?utf-8?B?WTNaczQwTFpJUHNUYkNWVUUyc1hhcjlQb3dsTnVVQ1FtRHZaYm0wbnEzMnRP?=
 =?utf-8?B?c2hrekpudzhSS0xVaFNzTDl3SnJQQitPNnNZczVpbXphQ1MyMTh0cWtpR2Ro?=
 =?utf-8?B?dGlyZnFvKzYyK0gwQlNyc2ZsVGszUnJGRHpWWjFoVGM1bDROYmVsVW92YTdh?=
 =?utf-8?B?MnFLMUdobS9kbWVHdWMzY0IyM05MdFNOb205WUwzSU9Sbm8rNitzVmZ5UWdI?=
 =?utf-8?B?V21OdzkvL3hrOTd2M1RGSEdSUmFHMUYzVW1GeEdvV3lkTmJBa1JwOFBQY0Q0?=
 =?utf-8?B?MXNCRFNDeFlnQm1hNk9KU3dMTHV1U1ppWElMekpqRkMvWlBPZlpWOVdBRlhR?=
 =?utf-8?B?QmdydlZJOWZEb2Z2WjhvZVJTVHVpQTJ6UlR1UEdndjNPS2QrZlBjbHZTWFA4?=
 =?utf-8?B?MkpMTUFsMnp0TjFaU0JRYzBxSzgrZUtDdzNNU1NtNTYyZys5dGZUemZGNDVT?=
 =?utf-8?B?MERnancyRmxxeWpPdWxrWm1sRTBVdVY2R2lkMEJIZGUxVjZIUGIxcEx3Z3J6?=
 =?utf-8?B?Z2d6OWRDRnJzTnpYbGY0RE1YbXloS0NVc0N0OWNicTR4bTJOR3dJRGhZbFdm?=
 =?utf-8?B?RmNMYTZjaE91ZE5nNEJaZE1HcmtkZjJKTlY2Q0tBM2U1bHBDamM5cWdFcXY1?=
 =?utf-8?B?UHNaUXU1R3hvOUlmNnJYaHRBbUJkbGFVOXVhRlp4ZWUwM3prNmt3R0JrRkZ5?=
 =?utf-8?B?c2pxOFg3aDViWm10aGVPOFF6WWkyVWw1VDZBcXFncmkybVVMb0prM1JLMFA0?=
 =?utf-8?B?RjQwdWdOZXk2YkwyZFlTbldrZGxYQnUvWXNQdytxWlA1VmVpRWhsSzVYbEdp?=
 =?utf-8?B?RSt4NXE5RmdaSlphVURydVNZNnB6aU1uM2NRMm9HVnZYb1c0QjBKNHErTVZw?=
 =?utf-8?B?WTNlb2Fvckc3Rms1M3ZaZStsTXRMQzFQdUJ3TlhjdlpFME5oanJHSnErZURn?=
 =?utf-8?B?c3J3NUZSV1N0QlJxMkUrTnpFVG9Rc3FxdUQrb0xZTUQzU2ZtZU53UTc5eEUx?=
 =?utf-8?B?UHNlSTR2SVpiUXM5Q2RhV3VScnBFNE9CWVcxWmNTL3pTNGxaR2hrZXM3Qzds?=
 =?utf-8?B?WmZrVGptY2NkN3o3N09aY3QxWGZLc3UvWWpjc1ZHbUphUGRCemp5bDdobEhw?=
 =?utf-8?B?b0FtcEQ4VHE4SWJIbDVHZEdCcStZcExJV1IxTGh5TG4rY085K3pvK1ovdVNI?=
 =?utf-8?B?bGM1dCs5U3kzZFFUU1FHWUcvTEVseFlIaFNXZldockdFV1NQYUJKOVpOTHIv?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a59f592-4ca1-4401-3525-08dbafa7e44c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 13:39:43.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA+AXFioaJJk4jgQrt8AKceSjNAe/C5RwruviBRvrC7Xu9uIjkaNnghIu+8pVBs43DF/zeUZSUordpmvn48fKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3261

On 04.09.23 08:55, Johannes Kirchmair wrote:
> Hi Jan,
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Freitag, 1. September 2023 14:00
>> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>> xenomai@lists.linux.dev
>> Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
>>
>> CAUTION: External E-Mail !
>>
>> On 16.08.23 12:18, Johannes Kirchmair wrote:
>>> We implement rt signals to handle exceptions in rt stage.
>>>
>>> This is done using dovetail specific functions for setting up the signal
>>> frame.
>>>
>>> This can be used to handle fpe exceptions on the fly, like fixing
>>> division by zero. An other use case are breakpoints, implemented using the
>>> illegal opcode exception. The real time handling of the breakpoints would
>>> be handy for conditional breakpoints or also for stopping watchdogs and
>>> other tasks in time.
>>>
>>> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>>> ---
>>>  include/cobalt/kernel/ppd.h                   |  3 +
>>>  include/cobalt/kernel/thread.h                |  2 +
>>>  include/cobalt/signal.h                       |  2 +
>>>  include/cobalt/uapi/signal.h                  |  1 +
>>>  include/cobalt/uapi/syscall.h                 |  6 ++
>>>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>>>  .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
>>>  kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
>>>  kernel/cobalt/arch/x86/signal_ia64.c          | 37 +++++++++
>>>  kernel/cobalt/dovetail/kevents.c              |  5 ++
>>>  kernel/cobalt/posix/process.c                 |  3 +-
>>>  kernel/cobalt/posix/syscall.c                 | 28 +++++++
>>>  kernel/cobalt/posix/syscall32.c               | 16 ++++
>>>  kernel/cobalt/thread.c                        | 39 ++++++++++
>>>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>>>  lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++
>>>  lib/cobalt/internal.h                         |  2 +
>>>  lib/cobalt/signal.c                           | 13 ++++
>>>  18 files changed, 282 insertions(+), 3 deletions(-)
>>>  create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
>>>  create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c
>>>  create mode 100644 lib/cobalt/arch/x86/sigreturn.c
>>>
>>> diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
>>> index f0079fe6e..fb2f682da 100644
>>> --- a/include/cobalt/kernel/ppd.h
>>> +++ b/include/cobalt/kernel/ppd.h
>>> @@ -22,6 +22,7 @@
>>>  #include <linux/types.h>
>>>  #include <linux/atomic.h>
>>>  #include <linux/rbtree.h>
>>> +#include <linux/signal.h>
>>>  #include <cobalt/kernel/heap.h>
>>>
>>>  struct cobalt_umm {
>>> @@ -32,6 +33,8 @@ struct cobalt_umm {
>>>
>>>  struct cobalt_ppd {
>>>       struct cobalt_umm umm;
>>> +     void __user *sighand[_NSIG];
>>> +     void __user *sigrestorer;
>>>       atomic_t refcnt;
>>>       char *exe_path;
>>>       struct rb_root fds;
>>> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
>>> index b79cb8429..33d468419 100644
>>> --- a/include/cobalt/kernel/thread.h
>>> +++ b/include/cobalt/kernel/thread.h
>>> @@ -574,6 +574,8 @@ static inline void
>> xnthread_propagate_schedparam(struct xnthread *curr)
>>>               __xnthread_propagate_schedparam(curr);
>>>  }
>>>
>>> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs);
>>> +
>>>  extern struct xnthread_personality xenomai_personality;
>>>
>>>  /** @} */
>>> diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
>>> index 62694f93a..3d6540aff 100644
>>> --- a/include/cobalt/signal.h
>>> +++ b/include/cobalt/signal.h
>>> @@ -54,6 +54,8 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
>>>  COBALT_DECL(int, sigqueue(pid_t pid, int sig,
>>>                         const union sigval value));
>>>
>>> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *));
>>> +
>>>  #ifdef __cplusplus
>>>  }
>>>  #endif
>>> diff --git a/include/cobalt/uapi/signal.h b/include/cobalt/uapi/signal.h
>>> index 8a7ea15a4..1afb6050a 100644
>>> --- a/include/cobalt/uapi/signal.h
>>> +++ b/include/cobalt/uapi/signal.h
>>> @@ -68,6 +68,7 @@
>>>  #define SIGDEBUG_RESCNT_IMBALANCE    7
>>>  #define SIGDEBUG_LOCK_BREAK          8
>>>  #define SIGDEBUG_MUTEX_SLEEP         9
>>> +#define SIGDEBUG_SIGRESTOR           10
>>>
>>>  #define COBALT_DELAYMAX                      2147483647U
>>>
>>> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
>>> index 3e65efaab..f14bd8ffe 100644
>>> --- a/include/cobalt/uapi/syscall.h
>>> +++ b/include/cobalt/uapi/syscall.h
>>> @@ -142,6 +142,12 @@
>>>  #define sc_cobalt_timerfd_gettime64          119
>>>  #define sc_cobalt_pselect64                  120
>>>
>>> +/*
>>> + * Sigmatek specific syscalls
>>> + */
>>> +#define sc_cobalt_sigreturn                  121
>>> +#define sc_cobalt_sigaction                  122
>>> +
>>>  #define __NR_COBALT_SYSCALLS                 128 /* Power of 2 */
>>>
>>>  #endif /* !_COBALT_UAPI_SYSCALL_H */
>>> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
>>> index 93929b645..e725afbff 100644
>>> --- a/kernel/cobalt/arch/x86/Makefile
>>> +++ b/kernel/cobalt/arch/x86/Makefile
>>> @@ -1,5 +1,5 @@
>>>
>>>  obj-$(CONFIG_XENOMAI) += xenomai.o
>>> -xenomai-y := machine.o smi.o c1e.o
>>> +xenomai-y := machine.o smi.o c1e.o signal_ia32.o signal_ia64.o
>>>
>>>  ccflags-y := -I$(srctree)/arch/x86/xenomai/include -
>> I$(srctree)/include/xenomai
>>> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>>> index 745c32467..4d004680b 100644
>>> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>>> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>>> @@ -28,5 +28,18 @@
>>>  #define xnarch_fault_bp_p(__nr)              ((current->ptrace & PT_PTRACED) &&
>> \
>>>                                        ((__nr) == X86_TRAP_DB || (__nr) == X86_TRAP_BP))
>>>  #define xnarch_fault_notify(__nr)    (!xnarch_fault_bp_p(__nr))
>>> +#define xnarch_fault_code(__regs)            ((__regs)->orig_ax)
>>> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
>>> +                        long errcode, int *sig, struct kernel_siginfo *info);
>>> +
>>> +int xnarch_setup_rt_frame_ia32(int sig, void *handler, struct kernel_siginfo
>> *si,
>>> +                       struct pt_regs *regs, void __user *restorer);
>>> +
>>> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
>>> +
>>> +int xnarch_setup_rt_frame_ia64(int sig, void *handler, struct kernel_siginfo
>> *si,
>>> +                       struct pt_regs *regs, void __user *restorer);
>>> +
>>> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs);
>>>
>>>  #endif /* !_COBALT_X86_ASM_THREAD_H */
>>> diff --git a/kernel/cobalt/arch/x86/signal_ia32.c
>> b/kernel/cobalt/arch/x86/signal_ia32.c
>>> new file mode 100644
>>> index 000000000..140016460
>>> --- /dev/null
>>> +++ b/kernel/cobalt/arch/x86/signal_ia32.c
>>> @@ -0,0 +1,75 @@
>>> +#include <linux/signal.h>
>>> +#include <linux/uaccess.h>
>>> +#include <cobalt/kernel/thread.h>
>>> +
>>> +#include <asm/sigframe.h>
>>> +#include <asm/sighandling.h>
>>> +#include <asm/fpu/signal.h>
>>> +
>>> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
>>> +                        long errcode, int *sig, struct kernel_siginfo *info)
>>
>> Why is this function in file that suggests to handle only 32-bit? It's
>> shared by both 32 and 64 bit.
> Did not changed it yet?
> Should I add an distinct signal.c file for the function?

Yes, that would be logical in this case.

> 
>>
>>> +{
>>> +     switch (vector) {
>>> +     case 0: /* divide_error */
>>> +             *sig = SIGFPE;
>>> +             info->si_signo = *sig;
>>> +             info->si_errno = 0;
>>> +             info->si_code = FPE_INTDIV;
>>> +             info->si_addr = (void __user *)regs->ip;
>>> +             return 0;
>>> +     case 1: /* trap_error */ {
>>> +             unsigned long condition;
>>> +             get_debugreg(condition, 6);
>>> +             set_debugreg(0, 7);
>>> +             *sig = SIGTRAP;
>>> +             info->si_signo = *sig;
>>> +             info->si_errno = errcode;
>>> +             info->si_code = get_si_code(condition);
>>> +             info->si_addr = (void __user *)regs->ip;
>>> +             return 0;
>>> +     }
>>> +     case 3: /* trap_error */
>>> +             *sig = SIGTRAP;
>>> +             info->si_signo = *sig;
>>> +             info->si_errno = errcode;
>>> +             info->si_code = SI_KERNEL;
>>> +             info->si_addr = (void __user *)regs->ip;
>>> +             return 0;
>>> +     case 6: /* invalid_op */
>>> +             *sig = SIGILL;
>>> +             info->si_signo = *sig;
>>> +             info->si_errno = 0;
>>> +             info->si_code = ILL_ILLOPN;
>>> +             info->si_addr = (void __user *)regs->ip;
>>> +             return 0;
>>> +     case 16: { /* coprocessor_error */
>>> +             *sig = SIGFPE;
>>> +
>>> +             info->si_signo = *sig;
>>> +             info->si_errno = 0;
>>> +             info->si_code = 0;
>>> +             info->si_addr = (void __user *)regs->ip;
>>> +             return 0;
>>> +     }
>>> +     default:
>>> +             break;
>>> +     }
>>> +
>>> +     return -ENOSYS;
>>> +}
>>> +
>>> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = dovetail_restore_rt_signal_frame(regs);
>>> +     if (ret < 0)
>>> +             goto badframe;
>>> +
>>> +     return regs->ax;
>>> +
>>> +badframe:
>>> +     xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
>>> +     return -1;
>>> +}
>>> +
>>> diff --git a/kernel/cobalt/arch/x86/signal_ia64.c
>> b/kernel/cobalt/arch/x86/signal_ia64.c
>>> new file mode 100644
>>> index 000000000..3b8cd3330
>>> --- /dev/null
>>> +++ b/kernel/cobalt/arch/x86/signal_ia64.c
>>> @@ -0,0 +1,37 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + *  Copyright (C) 1991, 1992  Linus Torvalds
>>> + *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
>>> + *
>>> + *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
>>> + *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
>>> + *  2000-2002   x86-64 support by Andi Kleen
>>> + */
>>> +
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +
>>> +
>>> +#include <linux/signal.h>
>>> +#include <linux/uaccess.h>
>>> +#include <cobalt/kernel/thread.h>
>>> +
>>> +#include <asm/sigframe.h>
>>> +#include <asm/sighandling.h>
>>> +#include <asm/fpu/signal.h>
>>> +
>>> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = dovetail_restore_rt_signal_frame(regs);
>>> +     if (ret < 0)
>>> +             goto badframe;
>>> +
>>> +     return regs->ax;
>>> +
>>> +badframe:
>>> +     xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
>>
>> I'm not sure if this is the right way to react. Mayday will translate to
>> SIGDEBUG, but we need a SIGSEGV.
>>
>>> +     return -1;
>>> +
>>> +}
>>> +
>>> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
>>> index 4da4f51b7..61417717b 100644
>>> --- a/kernel/cobalt/dovetail/kevents.c
>>> +++ b/kernel/cobalt/dovetail/kevents.c
>>> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct
>> pt_regs *regs)
>>>               xnsched_run();
>>>       }
>>>
>>> +     if (xnthread_handle_rt_signals(trapnr, regs) == 0)
>>> +             return;
>>> +
>>>       /*
>>>        * If we experienced a trap on behalf of a shadow thread
>>>        * running in primary mode, move it to the Linux domain,
>>> @@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct
>> pt_regs *regs)
>>>               xnstat_counter_inc(&thread->stat.pf);
>>>
>>>       xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAULT);
>>> +
>>> +     return;
>>
>> Unrelated and unneeded change.
>>
>>>  }
>>>
>>>  static inline int handle_setaffinity_event(struct dovetail_migration_data *d)
>>> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
>>> index 1abc86f37..2069129cb 100644
>>> --- a/kernel/cobalt/posix/process.c
>>> +++ b/kernel/cobalt/posix/process.c
>>> @@ -738,9 +738,10 @@ void cobalt_unregister_debugged_thread(struct
>> xnthread *thread)
>>>               cobalt_resume_debugged_process(process);
>>>  }
>>>
>>> +#ifdef CONFIG_SMP
>>> +
>>>  int cobalt_handle_setaffinity_event(struct task_struct *task)
>>>  {
>>> -#ifdef CONFIG_SMP
>>
>> Unrelated and bogus change.
>>
>>>       struct xnthread *thread;
>>>       spl_t s;
>>>
>>> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
>>> index 46c4998e4..b4bd4c587 100644
>>> --- a/kernel/cobalt/posix/syscall.c
>>> +++ b/kernel/cobalt/posix/syscall.c
>>> @@ -277,6 +277,34 @@ static COBALT_SYSCALL(serialdbg, current,
>>>       return 0;
>>>  }
>>>
>>> +static COBALT_SYSCALL(sigreturn, current, (void))
>>> +{
>>> +     struct pt_regs *regs = task_pt_regs(current);
>>> +
>>> +     if (regs->cs == __USER_CS)
>>> +             xnarch_rt_sigreturn_ia64(regs);
>>> +     if (regs->cs == __USER32_CS)
>>> +             xnarch_rt_sigreturn_ia32(regs);
>>> +
>>> +     return __xn_reg_rval(regs);
>>> +}
>>> +
>>> +static COBALT_SYSCALL(sigaction, current, (int sig, void __user *handler,
>>> +                   void __user *restorer))
>>> +{
>>> +     struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
>>> +
>>> +     if (sig < 0 || sig >= _NSIG)
>>> +             return -EINVAL;
>>> +
>>> +     sys_ppd->sighand[sig] = handler;
>>> +
>>> +     if (!sys_ppd->sigrestorer)
>>> +             sys_ppd->sigrestorer = restorer;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  static void stringify_feature_set(unsigned long fset, char *buf, int size)
>>>  {
>>>       unsigned long feature;
>>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>>> index 780d276b1..7c858f904 100644
>>> --- a/kernel/cobalt/posix/syscall32.c
>>> +++ b/kernel/cobalt/posix/syscall32.c
>>> @@ -705,6 +705,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
>>>       return ret ?: __cobalt_sigqueue(pid, sig, &val);
>>>  }
>>>
>>> +COBALT_SYSCALL32emu(sigaction, current,
>>> +                 (int sig, void __user *handler, void __user *restorer))
>>> +{
>>> +     struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
>>> +
>>> +     if (sig < 0 || sig >= _NSIG)
>>> +             return -EINVAL;
>>> +
>>> +     sys_ppd->sighand[sig] = handler;
>>> +
>>> +     if (!sys_ppd->sigrestorer)
>>> +             sys_ppd->sigrestorer = restorer;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
>>>                   (struct cobalt_monitor_shadow __user *u_mon,
>>>                    int event, const struct old_timespec32 __user *u_ts,
>>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>>> index 41804b24f..71f97c481 100644
>>> --- a/kernel/cobalt/thread.c
>>> +++ b/kernel/cobalt/thread.c
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/signal.h>
>>>  #include <linux/pid.h>
>>>  #include <linux/sched.h>
>>> +#include <asm/sighandling.h>
>>>  #include <uapi/linux/sched/types.h>
>>>  #include <cobalt/kernel/sched.h>
>>>  #include <cobalt/kernel/timer.h>
>>> @@ -43,6 +44,7 @@
>>>  #include <pipeline/inband_work.h>
>>>  #include <pipeline/sched.h>
>>>  #include <trace/events/cobalt-core.h>
>>> +#include "posix/process.h"
>>>  #include "debug.h"
>>>
>>>  static DECLARE_WAIT_QUEUE_HEAD(join_all);
>>> @@ -2520,6 +2522,43 @@ int xnthread_killall(int grace, int mask)
>>>  }
>>>  EXPORT_SYMBOL_GPL(xnthread_killall);
>>>
>>> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs)
>>> +{
>>> +     struct ksignal ksig;
>>> +
>>> +     unsigned int vector = trapnr;
>>> +     unsigned int code = xnarch_fault_code(regs);
>>> +     struct cobalt_ppd *sys_ppd;
>>> +     int sig, ret = 0;
>>> +     struct kernel_siginfo si;
>>> +
>>> +     code = xnarch_fault_code(regs);
>>> +     ret = xnarch_setup_trap_info(vector, regs, code, &sig, &si);
>>> +     if (ret || sig == 0)
>>> +             return 1;
>>> +
>>> +     sys_ppd = cobalt_ppd_get(0);
>>> +     if (sig >= _NSIG ||
>>> +         sys_ppd->sighand[sig] == NULL ||
>>> +         sys_ppd->sighand[sig] == SIG_DFL)
>>> +             return 1;
>>> +
>>> +     if (sys_ppd->sigrestorer == NULL)
>>> +             return 1;
>>> +
>>> +     ksig.sig = sig;
>>> +     memcpy(&ksig.info, &si, sizeof(si));
>>> +     ksig.ka.sa.sa_flags = SA_SIGINFO | SA_RESTORER;
>>> +     ksig.ka.sa.sa_restorer = sys_ppd->sigrestorer;
>>> +     ksig.ka.sa.sa_handler = sys_ppd->sighand[sig];
>>> +
>>> +     ret = dovetail_setup_rt_signal_frame(&ksig, regs);
>>
>> All this is called with interrupts off on x86, and that makes dovetail
>> unhappy:
>>
>> [   17.051995] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported
>> by transport virtio
>> [   37.268218] ------------[ cut here ]------------
>> [   37.268223] WARNING: CPU: 2 PID: 1402 at ../mm/memory.c:5857
>> __might_fault+0x95/0xa0
>> [   37.268237] Modules linked in: 9p netfs rt_e1000 rt_e1000_new rtnet
>> [   37.268252] CPU: 2 PID: 1402 Comm: rt-task Not tainted 6.5.0+ #40
>> [   37.268259] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-
>> 1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
>> [   37.268262] IRQ stage: Xenomai
>> [   37.268265] RIP: 0010:__might_fault+0x95/0xa0
>> [   37.268271] Code: b8 a0 01 00 00 e8 cb bf e3 ff 48 8b bb e8 04 00 00 48 8b 5d
>> f8 48 c7 c6 6b 29 2d 81 58 c9 48 81 c7 a0 01 00 00 e9 2b bc e3 ff <0f> 0b eb 86
>> 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
>> [   37.268277] RSP: 0000:ffffc900007f3cd0 EFLAGS: 00010046
>> [   37.268283] RAX: 0000000000000006 RBX: 00007f5aa94016b8 RCX:
>> ffffc900007f3d70
>> [   37.268287] RDX: 00007f5aa9401cc4 RSI: 00000000000000a7 RDI:
>> ffffffff82962a10
>> [   37.268291] RBP: ffffc900007f3cd8 R08: 0000000000000444 R09:
>> 0000000000000000
>> [   37.268295] R10: 0000000000000000 R11: 0000000000000000 R12:
>> 0000000000000000
>> [   37.268298] R13: ffff888009e6e700 R14: 0000000000000000 R15:
>> 00000000000299a0
>> [   37.268302] FS:  00007f5aa9402700(0000) GS:ffff88803ed00000(0000)
>> knlGS:0000000000000000
>> [   37.268313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   37.268317] CR2: 0000560ba8044008 CR3: 000000000981a004 CR4:
>> 0000000000370ee0
>> [   37.268321] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [   37.268324] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [   37.268328] Call Trace:
>> [   37.268332]  <TASK>
>> [   37.268339]  ? __warn+0x81/0x180
>> [   37.268350]  ? __might_fault+0x95/0xa0
>> [   37.268363]  ? report_bug+0x10b/0x200
>> [   37.268406]  ? handle_bug+0x50/0xc0
>> [   37.268417]  ? exc_invalid_op+0xc7/0xe0
>> [   37.268427]  ? asm_exc_invalid_op+0x16/0x20
>> [   37.268467]  ? __might_fault+0x95/0xa0
>> [   37.268485]  copy_fpstate_to_sigframe+0x74/0x430
>> [   37.268496]  ? ___xnsched_run+0x223/0x590
>> [   37.268515]  ? __pfx____xnsched_run+0x10/0x10
>> [   37.268541]  get_sigframe+0xea/0x2b0
>> [   37.268562]  x64_setup_rt_frame+0x68/0x2f0
>> [   37.268583]  xnthread_handle_rt_signals+0xf8/0x130
>> [   37.268633]  handle_oob_trap_entry+0xaa/0x3a0
>> [   37.268640]  ? __pfx_CoBaLt_sigaction+0x10/0x10
>> [   37.268666]  __oob_trap_notify+0x27/0x30
>> [   37.268674]  do_error_trap+0x162/0x1d0
>> [   37.268695]  exc_divide_error+0x35/0x50
>> [   37.268707]  asm_exc_divide_error+0x16/0x20
>> [   37.268713] RIP: 0033:0x400e68
>>
>> I'm currently scratching my head if we can safely enable hard interrupts
>> here to resolve this (and the underlying latency source).
> Not sure what is the right way. Have some problems understanding, what has to be protected for the setup to work correct.
> 

I have a working dovetail patch locally will share it later.

>>
>> We will also need pagefault_disable in our dovetail functions, already
>> playing with that.
> Could you explain to me, what pagefault_disable does and by we need it.

For us, it primarily signals to the might_sleep() check that we don't
expect any waiting due to not yet mapped memory - accesses under that
protection are supposed to succeed or fail immediately. The kernel
writes: "If disabled, it will not take any locks and go straight to the
fixup table."

Jan

-- 
Siemens AG, Technology
Linux Expert Center

