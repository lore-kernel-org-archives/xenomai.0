Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D3AD37
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 12:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4wcegv7ObBpOjBFte6hcm++TwANfj/LbcU3VSHCyM4O3+xwMCBTKrT1YVU9oc97QXZtVGuFGDrP+JZEcsoykbQewab9xEOsT26AV9PPvIhTJkMGoEVzKhQjd0TDQ6xAL0EubKnXU23ILn4onRCcvaI/LSUiL7PpuJ9mLXl8MF4VHBwoyeewZITLM9xW98bKmylbxSTHg702dNUm/cD2Fatee7L6xIuLC3B5XCU5pdd2bXcgmNOTUH4I3G3qBIKPVACiVXU+G7YmHrJYSScxWlZW3E/mGeOfuv+/XstEpQs2FtGutO1TP0LoFb7AtsbHDzECF5JeYBprqhb0pDT9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYEGbGIZ7lb8z6p/GqU8N4IlCTD9nHOw6LMzZVXxLs0=;
 b=lgRCgZvUoyLKybQp5F4NRgEtqsRM9pSMfkYyy82swo0dV15CdsOKr+5vxMVqmJ/WIVawGMDF8R96fQ2t1Pgnh8GcR04I8+6PQdc1wBOM7yJQhGz9rVVUvr0N4GO78Q323hJSslZXJZr3byCYTjjS1aCuTCe7b74cXt55mzFo2PkKeejpOToaL/pZpQwGWdY4TtTjUgVFA2FJOCwx0ohAqf7YX6wpJzNPE06qAL0h4JsQuRXXYMuMIV0xoAOI8Tfz55V9evdwbiLhxojwBZw6fOkAThuS7z8GmG9EVJdS4dMW0kO+mG1uo0djobT1ErOc8c0aGnNif1pDWwTy9AqIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYEGbGIZ7lb8z6p/GqU8N4IlCTD9nHOw6LMzZVXxLs0=;
 b=lOykFAjCqS1QmA0mqJUc4PWVL1R01D8FCYI5ki+yklrZ3OsufQkvi0xlVb+iNFhKSSaxdz+BO4XlKaHfF0PC6O8jSJZ7l9QIibJv1YjmK0PeOtnGTyGZmRgf+RAjvD5ffmuSBoAW+gZqYVTURwMbDYEKfcurVZ8DUIAgxMDEZOY7l9wIsnaNNKKWm6FvR+uFqDd0x0k5DikfCYr4KSKlabYqVeQMxz1tcfx7FuzzdGPEuAr+WR8FMw/A6+TuWl51HEY+Y6z5FpHFRi3gt2YGzWUgwDlErxhFP1AjIOgO1+CHs0Pjc3u9F+DwKUSBOBfHYtykqNqloDTCZ5pdmqB5/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:292::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 12:00:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 12:00:18 +0000
Message-ID: <61984786-9ecc-4605-bc07-70827584d3bc@siemens.com>
Date: Fri, 1 Sep 2023 14:00:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 xenomai@lists.linux.dev
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1498e5-11b5-49b6-f07d-08dbaae302d4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 nDvomaDtdpwpwooKyKCp5pwynPHDS86x6bsLYNau85n42oyuRxBFoiodPMmGQ1sqw/tu9Nz2IPANzl6qeicX6QbbdI/1GipXXDDXAt85kF2WgJcFFQPPzDE/Y85K6qsBVQYILIrj97v8tFCGfdxrFFVel0Jx7Xi/O3p3INk0hLUXAuRu4G3ODEvwgOmt9nFaNhiyguFZGqPF7sfp/ITPTKLsqChlCECkyRvv/OvABdl0SC1A+vaTXVP49mXc59zuCv2liKluawUA5yW2f7R+ySDO+RWtw2jktgOEkSmAda8QsuHWBCTywYclMRC8J5fuVYjoYNyvw2NTts5rkNlqrxnJPMyICMwcvg14TelUjoB/Ym9qb4KrGo+8rTc+OK22x8ikoYAxRwdzoHF0cZpElTKCrsaKcSYB89Bo8YKYePV6632jLzh7IM0uKEVZqT/m3/GeChWO2BTKrfB3YHP9UTmqPsW1MMO/u8r5A2ydlrFuPC2i6ENY5rFKgqSXXdkQEiY6vLaDqQ3r8dPsKemCeXa1ZWc1LH3o4+2P/MaEtJh0PDRwTmmVhs342P03XNOXHEY+jx1YIeO+X0oDAiBqC6gdmR055iqZwf+bFALaNNPXa8Hn/s758/krexKtMvnTQ/CPLnCQ/+ix23CxIx59sA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199024)(1800799009)(186009)(6506007)(6486002)(6512007)(53546011)(45080400002)(478600001)(83380400001)(2616005)(26005)(2906002)(30864003)(316002)(41300700001)(66556008)(66946007)(8936002)(5660300002)(44832011)(8676002)(66476007)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZmVjc0diN2RHcnNzRkVlRVg4SHJTbmVXODk3d29iUGJhRFZDRlFTWVZDM05D?=
 =?utf-8?B?aVdsV0RtVURWazVVT1hTUDRGMVJWak16M2xoZzVUMnVDU1ZpUkY4QWdRTEZk?=
 =?utf-8?B?NDY0T21tUUJNUUcxcndJQzJDYk43bENIQml4Q0JoYzhxS2J2ZHNCWUpnM1ZP?=
 =?utf-8?B?RGZ3M200QWdNUE0rdXdGZ2t1dXhNZjl5SDZwM1NHTmM2TE92TlNWQ216RG5Q?=
 =?utf-8?B?ZlQyYnVHRDFBZS9RQmMzYXp2QjZsWkVXRThDUXNLVEk1cHpEb0Q5UTFVOFdh?=
 =?utf-8?B?TXBiOGQwS3hVNFp1NVl4Um8yU2N3bjRuaHMwRFhkUTBtNjJ5ZWhTR1NyR010?=
 =?utf-8?B?cW5FbFhwLzlHcm96T1VtMXBRTlh6MlNBVFY4ZjdjU0RLNUF1TVMrR0J5Sndo?=
 =?utf-8?B?Rk41Y1JKUUtaR05Zd1ZUMElDaGoxMEtzRnkvMFVqR0NrTnQ2RzRuUHJGdDR4?=
 =?utf-8?B?RVNBTGJ5Sm1FT2hyU2pLY21uZU53VWpRWVFxUkZnbjhkeVNPSHlzaFRkeXQ1?=
 =?utf-8?B?bE5yTkJRZGZMV3RSK2ttT2VwYkpWVUFoZWVMN3dlT2RhR2ZoSlBwaytISzQz?=
 =?utf-8?B?MURPM25xWXhtZlMrNzloOFNPSXNxT2k0OGo0Tm5Nd1cvZERFa01vY0dHbUFy?=
 =?utf-8?B?OFhzdDZDUTlnbXZ5emV4ZmZWY0EzSEZLTU1IVGpCVWNzdW93ckVOcWxsTk1m?=
 =?utf-8?B?ZUtSYWcxQzNJd0JqVnVZc1lUOS9YTzBUbFR4RURKZGttdngxUks5bzhYOHFS?=
 =?utf-8?B?a2FaZ0pDdW1hTGJ4Ky95R0JWNEtlTXBYNmJHMnNxWGwyMnJzRVZrdzN6anZn?=
 =?utf-8?B?NW9CSTFNcGJHSEVUbmNjc2VJOFRucVZXSGZPSG1oTFRFQlFVckpkQlRFUkVB?=
 =?utf-8?B?cHNRVlJJOGM2aVIvM3dXTW1jRWJ2ZS9JNGhGbUtOUVRCR1hIa3dkYWlycFJx?=
 =?utf-8?B?OWg4WSs1SGFVL3JUTElQSlZ0QzRpLzVQcTU3cXRId2hRc0RQRnZ3dWExTWY2?=
 =?utf-8?B?V1Z2NFZJRGxpMUFvdlpWYXpHY2VLNldMQjVLcWNhWnR0STZVZXpza0RKRlcr?=
 =?utf-8?B?V3UrempDaDFsdFJjcVBLdlVrRjBKQW9Day9TMmI4T2ZNM0dORVp0V2hSMkEw?=
 =?utf-8?B?OW9RR0dXMUpyTTc2MFVGRGpKQ1ArNkNFY1BpK2ozb1lNNURzY3pnRDVvQTEw?=
 =?utf-8?B?QWtzalVPZHhtdkFaamdUVU8vOFM1Y21YRHJjWU9LTnVTa2EvZ2JlWWtvVjBr?=
 =?utf-8?B?RVB1bnlhTlBySkJuOEM3WVBNZkpLbHByOGN0UFJEVkl3cmZlVnhqUFE3eWRk?=
 =?utf-8?B?R3JlV3UrUWhSVW9HbVdsNEFWUEFrdnBlaGVPZ2Q4Vi9xUm1sWmE4eVVzVkdR?=
 =?utf-8?B?cFNDZGNocmZVQWR6ajNuMXVGTXVaNllNWldGK25mR1Z3bmNuTUI2RmtObVY0?=
 =?utf-8?B?KzZkVi9DOW5ON3czZHkzQkNHS1h3dzlwbHhsbU9EQUdaSDdxUTRPaFozeXAr?=
 =?utf-8?B?dzBQV2c4VjQ1Q1NpdDdhdDJZcnhHNTdlNUJuYkRtOEpIT2ExTE5qTURSYzV0?=
 =?utf-8?B?QSs3VkJ4dEhCWS9Uc05Jc3VOYlNGTkdXdGlvOWF5MEY2KzVNbGljRlQ3dmZY?=
 =?utf-8?B?MmRoYUc0YnZkaUZLZnBVM0lVTXcxb2pTTWp5QzBZYm1TMFVxZi84dll6ZVcv?=
 =?utf-8?B?T3M5SkV2dTNodkNwQ0dVSDJrMlhkbnIwVFRuK1c0cThvVVpOdmxJMnQyOE10?=
 =?utf-8?B?NitTUnAwUU1SK21SWDdDc0hHMHFaTlRxdjEyaU1VbW55YUJLUFZNb0NRRXFJ?=
 =?utf-8?B?OXkvVGMwdnd0RWFkVVpTQmYyeE1sOTNSOVlkd0ZrYTZvVUJLM1VmUUVyVStK?=
 =?utf-8?B?OUhLVWp2MUhrSFR5eStXeUkzUTE4ZzNnbFFsY1BlNjhvZm1Ib2pqMEs3bzJD?=
 =?utf-8?B?aStsY29LMzJQeFlGcnRvaXJWVzhNK05kdjh0MVlXMTNNSWNqSjhieVNXMjlB?=
 =?utf-8?B?Y2t6VURhb0J1S2xpbVlSamd6ci9iNDhMTXRvWUZmUU5vS3YySzlBdHN1Vyto?=
 =?utf-8?B?TG4yYUVUNWM2RWlSeDg3eHhmeG9FKzVDMllUdVpESXZjY2IyQ2RSSUlvaU5S?=
 =?utf-8?B?MEZTbFl2aTdnM2lDRmUzV3FCTW4ydEZ2S2VxMDJFbjRmUzk2amNReFg0S2xm?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1498e5-11b5-49b6-f07d-08dbaae302d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 12:00:18.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIIRgVFm5xdFtXSoeVw/PzPngiPLlfUqkEAfnj7Y9f79nFy9F1mwIGp5S9jgg7SCf9XyA4lGx1xY34MSaRNy8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5398

On 16.08.23 12:18, Johannes Kirchmair wrote:
> We implement rt signals to handle exceptions in rt stage.
> 
> This is done using dovetail specific functions for setting up the signal
> frame.
> 
> This can be used to handle fpe exceptions on the fly, like fixing
> division by zero. An other use case are breakpoints, implemented using the
> illegal opcode exception. The real time handling of the breakpoints would
> be handy for conditional breakpoints or also for stopping watchdogs and
> other tasks in time.
> 
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> ---
>  include/cobalt/kernel/ppd.h                   |  3 +
>  include/cobalt/kernel/thread.h                |  2 +
>  include/cobalt/signal.h                       |  2 +
>  include/cobalt/uapi/signal.h                  |  1 +
>  include/cobalt/uapi/syscall.h                 |  6 ++
>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>  .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
>  kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
>  kernel/cobalt/arch/x86/signal_ia64.c          | 37 +++++++++
>  kernel/cobalt/dovetail/kevents.c              |  5 ++
>  kernel/cobalt/posix/process.c                 |  3 +-
>  kernel/cobalt/posix/syscall.c                 | 28 +++++++
>  kernel/cobalt/posix/syscall32.c               | 16 ++++
>  kernel/cobalt/thread.c                        | 39 ++++++++++
>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>  lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++
>  lib/cobalt/internal.h                         |  2 +
>  lib/cobalt/signal.c                           | 13 ++++
>  18 files changed, 282 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
>  create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c
>  create mode 100644 lib/cobalt/arch/x86/sigreturn.c
> 
> diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
> index f0079fe6e..fb2f682da 100644
> --- a/include/cobalt/kernel/ppd.h
> +++ b/include/cobalt/kernel/ppd.h
> @@ -22,6 +22,7 @@
>  #include <linux/types.h>
>  #include <linux/atomic.h>
>  #include <linux/rbtree.h>
> +#include <linux/signal.h>
>  #include <cobalt/kernel/heap.h>
>  
>  struct cobalt_umm {
> @@ -32,6 +33,8 @@ struct cobalt_umm {
>  
>  struct cobalt_ppd {
>  	struct cobalt_umm umm;
> +	void __user *sighand[_NSIG];
> +	void __user *sigrestorer;
>  	atomic_t refcnt;
>  	char *exe_path;
>  	struct rb_root fds;
> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
> index b79cb8429..33d468419 100644
> --- a/include/cobalt/kernel/thread.h
> +++ b/include/cobalt/kernel/thread.h
> @@ -574,6 +574,8 @@ static inline void xnthread_propagate_schedparam(struct xnthread *curr)
>  		__xnthread_propagate_schedparam(curr);
>  }
>  
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs);
> +
>  extern struct xnthread_personality xenomai_personality;
>  
>  /** @} */
> diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
> index 62694f93a..3d6540aff 100644
> --- a/include/cobalt/signal.h
> +++ b/include/cobalt/signal.h
> @@ -54,6 +54,8 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
>  COBALT_DECL(int, sigqueue(pid_t pid, int sig,
>  			  const union sigval value));
>  
> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *));
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/uapi/signal.h b/include/cobalt/uapi/signal.h
> index 8a7ea15a4..1afb6050a 100644
> --- a/include/cobalt/uapi/signal.h
> +++ b/include/cobalt/uapi/signal.h
> @@ -68,6 +68,7 @@
>  #define SIGDEBUG_RESCNT_IMBALANCE	7
>  #define SIGDEBUG_LOCK_BREAK		8
>  #define SIGDEBUG_MUTEX_SLEEP		9
> +#define SIGDEBUG_SIGRESTOR		10
>  
>  #define COBALT_DELAYMAX			2147483647U
>  
> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
> index 3e65efaab..f14bd8ffe 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -142,6 +142,12 @@
>  #define sc_cobalt_timerfd_gettime64		119
>  #define sc_cobalt_pselect64			120
>  
> +/*
> + * Sigmatek specific syscalls
> + */
> +#define sc_cobalt_sigreturn			121
> +#define sc_cobalt_sigaction			122
> +
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>  
>  #endif /* !_COBALT_UAPI_SYSCALL_H */
> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
> index 93929b645..e725afbff 100644
> --- a/kernel/cobalt/arch/x86/Makefile
> +++ b/kernel/cobalt/arch/x86/Makefile
> @@ -1,5 +1,5 @@
>  
>  obj-$(CONFIG_XENOMAI) += xenomai.o
> -xenomai-y := machine.o smi.o c1e.o
> +xenomai-y := machine.o smi.o c1e.o signal_ia32.o signal_ia64.o
>  
>  ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> index 745c32467..4d004680b 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> @@ -28,5 +28,18 @@
>  #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
>  					 ((__nr) == X86_TRAP_DB || (__nr) == X86_TRAP_BP))
>  #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
> +#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info);
> +
> +int xnarch_setup_rt_frame_ia32(int sig, void *handler, struct kernel_siginfo *si,
> +			  struct pt_regs *regs, void __user *restorer);
> +
> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
> +
> +int xnarch_setup_rt_frame_ia64(int sig, void *handler, struct kernel_siginfo *si,
> +			  struct pt_regs *regs, void __user *restorer);
> +
> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs);
>  
>  #endif /* !_COBALT_X86_ASM_THREAD_H */
> diff --git a/kernel/cobalt/arch/x86/signal_ia32.c b/kernel/cobalt/arch/x86/signal_ia32.c
> new file mode 100644
> index 000000000..140016460
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal_ia32.c
> @@ -0,0 +1,75 @@
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info)

Why is this function in file that suggests to handle only 32-bit? It's 
shared by both 32 and 64 bit.

> +{
> +	switch (vector) {
> +	case 0: /* divide_error */
> +		*sig = SIGFPE;
> +		info->si_signo = *sig;
> +		info->si_errno = 0;
> +		info->si_code = FPE_INTDIV;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	case 1: /* trap_error */ {
> +		unsigned long condition;
> +		get_debugreg(condition, 6);
> +		set_debugreg(0, 7);
> +		*sig = SIGTRAP;
> +		info->si_signo = *sig;
> +		info->si_errno = errcode;
> +		info->si_code = get_si_code(condition);
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	}
> +	case 3: /* trap_error */
> +		*sig = SIGTRAP;
> +		info->si_signo = *sig;
> +		info->si_errno = errcode;
> +		info->si_code = SI_KERNEL;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	case 6: /* invalid_op */
> +		*sig = SIGILL;
> +		info->si_signo = *sig;
> +		info->si_errno = 0;
> +		info->si_code = ILL_ILLOPN;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	case 16: { /* coprocessor_error */
> +		*sig = SIGFPE;
> +
> +		info->si_signo = *sig;
> +		info->si_errno = 0;
> +		info->si_code = 0;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	return -ENOSYS;
> +}
> +
> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs)
> +{
> +	int ret;
> +
> +	ret = dovetail_restore_rt_signal_frame(regs);
> +	if (ret < 0)
> +		goto badframe;
> +
> +	return regs->ax;
> +
> +badframe:
> +	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
> +	return -1;
> +}
> +
> diff --git a/kernel/cobalt/arch/x86/signal_ia64.c b/kernel/cobalt/arch/x86/signal_ia64.c
> new file mode 100644
> index 000000000..3b8cd3330
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal_ia64.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 1991, 1992  Linus Torvalds
> + *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
> + *
> + *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
> + *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
> + *  2000-2002   x86-64 support by Andi Kleen
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +
> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs)
> +{
> +	int ret;
> +
> +	ret = dovetail_restore_rt_signal_frame(regs);
> +	if (ret < 0)
> +		goto badframe;
> +
> +	return regs->ax;
> +
> +badframe:
> +	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);

I'm not sure if this is the right way to react. Mayday will translate to 
SIGDEBUG, but we need a SIGSEGV.

> +	return -1;
> +
> +}
> +
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 4da4f51b7..61417717b 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>  		xnsched_run();
>  	}
>  
> +	if (xnthread_handle_rt_signals(trapnr, regs) == 0)
> +		return;
> +
>  	/*
>  	 * If we experienced a trap on behalf of a shadow thread
>  	 * running in primary mode, move it to the Linux domain,
> @@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>  		xnstat_counter_inc(&thread->stat.pf);
>  
>  	xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAULT);
> +
> +	return;

Unrelated and unneeded change.

>  }
>  
>  static inline int handle_setaffinity_event(struct dovetail_migration_data *d)
> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
> index 1abc86f37..2069129cb 100644
> --- a/kernel/cobalt/posix/process.c
> +++ b/kernel/cobalt/posix/process.c
> @@ -738,9 +738,10 @@ void cobalt_unregister_debugged_thread(struct xnthread *thread)
>  		cobalt_resume_debugged_process(process);
>  }
>  
> +#ifdef CONFIG_SMP
> +
>  int cobalt_handle_setaffinity_event(struct task_struct *task)
>  {
> -#ifdef CONFIG_SMP

Unrelated and bogus change.

>  	struct xnthread *thread;
>  	spl_t s;
>  
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
> index 46c4998e4..b4bd4c587 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -277,6 +277,34 @@ static COBALT_SYSCALL(serialdbg, current,
>  	return 0;
>  }
>  
> +static COBALT_SYSCALL(sigreturn, current, (void))
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +
> +	if (regs->cs == __USER_CS)
> +		xnarch_rt_sigreturn_ia64(regs);
> +	if (regs->cs == __USER32_CS)
> +		xnarch_rt_sigreturn_ia32(regs);
> +
> +	return __xn_reg_rval(regs);
> +}
> +
> +static COBALT_SYSCALL(sigaction, current, (int sig, void __user *handler,
> +		      void __user *restorer))
> +{
> +	struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
> +
> +	if (sig < 0 || sig >= _NSIG)
> +		return -EINVAL;
> +
> +	sys_ppd->sighand[sig] = handler;
> +
> +	if (!sys_ppd->sigrestorer)
> +		sys_ppd->sigrestorer = restorer;
> +
> +	return 0;
> +}
> +
>  static void stringify_feature_set(unsigned long fset, char *buf, int size)
>  {
>  	unsigned long feature;
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
> index 780d276b1..7c858f904 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -705,6 +705,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
>  	return ret ?: __cobalt_sigqueue(pid, sig, &val);
>  }
>  
> +COBALT_SYSCALL32emu(sigaction, current,
> +		    (int sig, void __user *handler, void __user *restorer))
> +{
> +	struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
> +
> +	if (sig < 0 || sig >= _NSIG)
> +		return -EINVAL;
> +
> +	sys_ppd->sighand[sig] = handler;
> +
> +	if (!sys_ppd->sigrestorer)
> +		sys_ppd->sigrestorer = restorer;
> +
> +	return 0;
> +}
> +
>  COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
>  		    (struct cobalt_monitor_shadow __user *u_mon,
>  		     int event, const struct old_timespec32 __user *u_ts,
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 41804b24f..71f97c481 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -25,6 +25,7 @@
>  #include <linux/signal.h>
>  #include <linux/pid.h>
>  #include <linux/sched.h>
> +#include <asm/sighandling.h>
>  #include <uapi/linux/sched/types.h>
>  #include <cobalt/kernel/sched.h>
>  #include <cobalt/kernel/timer.h>
> @@ -43,6 +44,7 @@
>  #include <pipeline/inband_work.h>
>  #include <pipeline/sched.h>
>  #include <trace/events/cobalt-core.h>
> +#include "posix/process.h"
>  #include "debug.h"
>  
>  static DECLARE_WAIT_QUEUE_HEAD(join_all);
> @@ -2520,6 +2522,43 @@ int xnthread_killall(int grace, int mask)
>  }
>  EXPORT_SYMBOL_GPL(xnthread_killall);
>  
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs)
> +{
> +	struct ksignal ksig;
> +
> +	unsigned int vector = trapnr;
> +	unsigned int code = xnarch_fault_code(regs);
> +	struct cobalt_ppd *sys_ppd;
> +	int sig, ret = 0;
> +	struct kernel_siginfo si;
> +
> +	code = xnarch_fault_code(regs);
> +	ret = xnarch_setup_trap_info(vector, regs, code, &sig, &si);
> +	if (ret || sig == 0)
> +		return 1;
> +
> +	sys_ppd = cobalt_ppd_get(0);
> +	if (sig >= _NSIG ||
> +	    sys_ppd->sighand[sig] == NULL ||
> +	    sys_ppd->sighand[sig] == SIG_DFL)
> +		return 1;
> +
> +	if (sys_ppd->sigrestorer == NULL)
> +		return 1;
> +
> +	ksig.sig = sig;
> +	memcpy(&ksig.info, &si, sizeof(si));
> +	ksig.ka.sa.sa_flags = SA_SIGINFO | SA_RESTORER;
> +	ksig.ka.sa.sa_restorer = sys_ppd->sigrestorer;
> +	ksig.ka.sa.sa_handler = sys_ppd->sighand[sig];
> +
> +	ret = dovetail_setup_rt_signal_frame(&ksig, regs);

All this is called with interrupts off on x86, and that makes dovetail 
unhappy:

[   17.051995] 9pnet: Limiting 'msize' to 512000 as this is the maximum supported by transport virtio
[   37.268218] ------------[ cut here ]------------
[   37.268223] WARNING: CPU: 2 PID: 1402 at ../mm/memory.c:5857 __might_fault+0x95/0xa0
[   37.268237] Modules linked in: 9p netfs rt_e1000 rt_e1000_new rtnet
[   37.268252] CPU: 2 PID: 1402 Comm: rt-task Not tainted 6.5.0+ #40
[   37.268259] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   37.268262] IRQ stage: Xenomai
[   37.268265] RIP: 0010:__might_fault+0x95/0xa0
[   37.268271] Code: b8 a0 01 00 00 e8 cb bf e3 ff 48 8b bb e8 04 00 00 48 8b 5d f8 48 c7 c6 6b 29 2d 81 58 c9 48 81 c7 a0 01 00 00 e9 2b bc e3 ff <0f> 0b eb 86 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
[   37.268277] RSP: 0000:ffffc900007f3cd0 EFLAGS: 00010046
[   37.268283] RAX: 0000000000000006 RBX: 00007f5aa94016b8 RCX: ffffc900007f3d70
[   37.268287] RDX: 00007f5aa9401cc4 RSI: 00000000000000a7 RDI: ffffffff82962a10
[   37.268291] RBP: ffffc900007f3cd8 R08: 0000000000000444 R09: 0000000000000000
[   37.268295] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   37.268298] R13: ffff888009e6e700 R14: 0000000000000000 R15: 00000000000299a0
[   37.268302] FS:  00007f5aa9402700(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
[   37.268313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.268317] CR2: 0000560ba8044008 CR3: 000000000981a004 CR4: 0000000000370ee0
[   37.268321] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.268324] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   37.268328] Call Trace:
[   37.268332]  <TASK>
[   37.268339]  ? __warn+0x81/0x180
[   37.268350]  ? __might_fault+0x95/0xa0
[   37.268363]  ? report_bug+0x10b/0x200
[   37.268406]  ? handle_bug+0x50/0xc0
[   37.268417]  ? exc_invalid_op+0xc7/0xe0
[   37.268427]  ? asm_exc_invalid_op+0x16/0x20
[   37.268467]  ? __might_fault+0x95/0xa0
[   37.268485]  copy_fpstate_to_sigframe+0x74/0x430
[   37.268496]  ? ___xnsched_run+0x223/0x590
[   37.268515]  ? __pfx____xnsched_run+0x10/0x10
[   37.268541]  get_sigframe+0xea/0x2b0
[   37.268562]  x64_setup_rt_frame+0x68/0x2f0
[   37.268583]  xnthread_handle_rt_signals+0xf8/0x130
[   37.268633]  handle_oob_trap_entry+0xaa/0x3a0
[   37.268640]  ? __pfx_CoBaLt_sigaction+0x10/0x10
[   37.268666]  __oob_trap_notify+0x27/0x30
[   37.268674]  do_error_trap+0x162/0x1d0
[   37.268695]  exc_divide_error+0x35/0x50
[   37.268707]  asm_exc_divide_error+0x16/0x20
[   37.268713] RIP: 0033:0x400e68

I'm currently scratching my head if we can safely enable hard interrupts 
here to resolve this (and the underlying latency source).

We will also need pagefault_disable in our dovetail functions, already 
playing with that.

> +	if (ret)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /* Xenomai's generic personality. */
>  struct xnthread_personality xenomai_personality = {
>  	.name = "core",
> diff --git a/lib/cobalt/arch/x86/Makefile.am b/lib/cobalt/arch/x86/Makefile.am
> index a5095be3d..14f5eff97 100644
> --- a/lib/cobalt/arch/x86/Makefile.am
> +++ b/lib/cobalt/arch/x86/Makefile.am
> @@ -2,7 +2,7 @@ noinst_LTLIBRARIES = libarch.la
>  
>  libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
>  
> -libarch_la_SOURCES = features.c
> +libarch_la_SOURCES = features.c sigreturn.c
>  
>  libarch_la_CPPFLAGS =			\
>  	@XENO_COBALT_CFLAGS@ 		\
> diff --git a/lib/cobalt/arch/x86/sigreturn.c b/lib/cobalt/arch/x86/sigreturn.c
> new file mode 100644
> index 000000000..df961469e
> --- /dev/null
> +++ b/lib/cobalt/arch/x86/sigreturn.c
> @@ -0,0 +1,36 @@
> +#include <cobalt/uapi/syscall.h>
> +#include "internal.h"
> +
> +extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribute__ ((visibility ("hidden")));
> +
> +#define TO_STR(x) #x
> +
> +#ifdef __x86_64__
> +#define build_restorer(syscall_bit, syscall)                                   \
> +	asm(".text\n"                                                          \
> +	    "    .align 16\n"                                                  \
> +	    "__cobalt_sigreturn:\n"                                            \
> +	    "    movq $ " TO_STR(syscall_bit) ", %rax\n"                       \
> +	    "    orq $ " TO_STR(syscall) ", %rax\n"                            \
> +	    "    syscall")
> +#endif
> +
> +#ifdef __i386__
> +#define build_restorer(syscall_bit, syscall)                                   \
> +	asm(".text\n"                                                          \
> +	    "    .align 16\n"                                                  \
> +	    "__cobalt_sigreturn:\n"                                            \
> +	    "    movl $ " TO_STR(syscall_bit) ", %eax\n"                       \
> +	    "    orl $ " TO_STR(syscall) ", %eax\n"                            \
> +	    "    int  $0x80")
> +#endif
> +
> +/*
> + * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
> + */
> +build_restorer(__COBALT_SYSCALL_BIT, sc_cobalt_sigreturn);
> +
> +void *cobalt_get_restorer(void)
> +{
> +	return &cobalt_sigreturn;
> +}
> diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
> index acb3989f1..4782d154a 100644
> --- a/lib/cobalt/internal.h
> +++ b/lib/cobalt/internal.h
> @@ -132,4 +132,6 @@ static inline bool cobalt_features_available(unsigned int feat_mask)
>  	return (cobalt_features & feat_mask) == feat_mask;
>  }
>  
> +extern void *cobalt_get_restorer(void);
> +
>  #endif /* _LIB_COBALT_INTERNAL_H */
> diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
> index 40d315ebb..af174d570 100644
> --- a/lib/cobalt/signal.c
> +++ b/lib/cobalt/signal.c
> @@ -126,3 +126,16 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, const union sigval value))
>  
>  	return 0;
>  }
> +
> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
> +{
> +	int ret;
> +
> +	ret = XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler, cobalt_get_restorer());
> +	if (ret) {
> +		errno = -ret;
> +		return -1;
> +	}
> +
> +	return 0;
> +}

IOW: I started hacking as well, based on latest 6.5 and xenomai next. 
More to come.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

