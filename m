Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC981FC2
	for <xenomai@lists.linux.dev>; Sat,  9 Sep 2023 11:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFXmmwLDbl1zKHMUtIyncb/+Po5l1UaacdB+sziBHM2DOz5ceTCIpQFnX9vVnEPqKsxd/oRLS14a7Dwf1YAGAyeHVVrcKkGj6vNqm+CUe2B0YE0Cp06p8WtYLO/NxaTIQqcKGh1v0hOGb7B8CEuJ9cfgDsbzYIzxynJQxjQOEOa2ixbrYJbQA4McBpUkW/TOBIUu6+7l+CNx2U5SqK3Tg4AFr+Jz4y3rndJ1I/WOqAvroa0YrMd4qh/U1ZTvag3g1WDIp9/8WAg3v+OoFWYnMK2ylddaz5gBO0wOaLhLfVLLYMiZA6XIeqxlwo+YaeesAeCYQmZOgReZ6vpAf86Rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P85p9vg4i+TV7R9q4mVg4aLvafhFQxlQf4Ya0t/oSc=;
 b=fcgd7Fe0wQOZLkuWaVYX0N0YqvnCWa5BOCEgHb5JezWR96t/Zfx0P2MRCZxOocdSwPA46khgGqCmE7Lln3Tb3DpHrZy489ctW1TEjdxaK2jqZq7167tHnc2AnCKujrUuK3PvK313HX29jLzBvVMeNfKVbbvaRK4nY7Q7wyXe1GPdWINqRoN7pcsoxOlJuws7Ccfm4lcJM2/lr0wZWCLcfG24/180M3dlKGitFppOhyKwsy9s211Y/cblaFw9+BNlQhf6egPTK6Q/0XC6hhdESU9fHZ62NdcMd4ms5IyF4QzFKbrgkmxTAA9qoRtPWjs8JHqALtlHzmaD8ywL24n0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P85p9vg4i+TV7R9q4mVg4aLvafhFQxlQf4Ya0t/oSc=;
 b=Wfk11G9AO2ZAJjUk4QvmpdTNJ/MVuZ55c0zkQEHUu8CcYOo8z6FRyc1nISpu67gth1EhQdZXP2KKoc52yf9HF9eWMtijU7i5IJyd9JjMuYC7zUjfgHhRkhX+Ddh+E2yeD+NLl/WA43tZM/0JVdKnG928weRCVV5ytBfmglm3uB/PpT8O8wKB/pl/fXAh1dYT7KDGX7pMkey/1Jc+B2R3mThjdIeImTssukwSrOLQbWxcFiOxRUkEO8Or5bOsuEuRcSRmND0nLwqsKbEoxNx4sERr9lcn4jYNet+pnddN7yg2QvUudDurG2msVPdJValn9PHWSmwvUPqLkD0hlf4ohg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7661.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:637::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sat, 9 Sep
 2023 11:35:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 11:35:51 +0000
Message-ID: <ec99faa4-c3e5-46ac-9f71-5fc45172964e@siemens.com>
Date: Sat, 9 Sep 2023 17:05:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 xenomai@lists.linux.dev
References: <20230908105043.1355310-1-johannes.kirchmair@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230908105043.1355310-1-johannes.kirchmair@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ee9599-a649-4b31-db08-08dbb128eb66
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 32YrOuRVzgO5bxilfwKC3EdFYGZNcNsGPUm2rudPgd4PGSTAUCMoT0YLHkjMGtWgb5T/TmY/7KVr3+DPkSCMRCuGAml7UWYGlMEx579eWhfiiLnfNDDED2NnTidrWVogScuXU+jfIlikHl6YA3IL07RgBanWf2UAy2yy6UYrVl1xxxx2e4HUkALZ98OuwOlm1qXOd/6qDJ/tOHuznRSkj+q/nwFK/6UilRUBjItvs15yDZK9z5HoMX3nEScH8NWAeZZia/iORhTJbyznNKRjh/eoNx1/sGqUWyE9jacE3p9AM0gZJAH/yyrFVMO7AiwkjEp28u+6FXa7qLWEnmaCEE+efjL0zxTAyalymEBDp7CDedRw2pq50B1ZQ8lnyO29dZupT7acihSbx4TSvDAtetWP1+dhldRqv4IC6AAaAaschMl8WhuuACVLjvbbTaTCKGa/JWjkf4KgnxtUOnnONueewBnyz5pljq244mf5/XyP560xaQDbADnfk3i4F86ZvktG+8xfaaAAiXMiIpU8gHCoWiflq7PGcoGughVCcaiHYDRbXNONx6QNXVd154vIKFLAi0nzix8cmqWcIdmna2o9sIc+/H0TVsJcDpjLoUSZRwwMMYpcTr3cxK6EBuyl5ghPZEy+Kx365j4kHvbnjg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(26005)(8936002)(8676002)(5660300002)(2616005)(83380400001)(44832011)(31686004)(6512007)(6506007)(6486002)(41300700001)(53546011)(66476007)(66946007)(38100700002)(66556008)(6666004)(36756003)(82960400001)(316002)(86362001)(31696002)(30864003)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZVhhZmZBcGUrVVA5T1FiTHgxTkFhQW5mek5UUXZhNmVFT25DN2NrelB2SFRY?=
 =?utf-8?B?V0pSZUdDZWZaYnF6T0MvNHVlYUxlTG9LRUoydUdnL0tNTWd4Y2thMlN2RStL?=
 =?utf-8?B?ejZXeDFmQnIvZm0zU1VFV1V5QjA5MTlpVmlSLzQwNjYyVGo2NWFRcDV3YThY?=
 =?utf-8?B?TUMweXNlR3ljS01sb1NsUmN2MU92N2U0QTZoV2x3U0h3NndiV1RVaVh5a0dY?=
 =?utf-8?B?Z2JUTHNvei9DZ0RWRGlldnArVURlWlc4TTZlOERhMG9LUjlsdFptb3gzVFlx?=
 =?utf-8?B?dXJJUkorR041Vlp5SlgrSFBnYXdIYm53QW9YZWlTbnpqWW1rK0tFVTBwWWQ3?=
 =?utf-8?B?UTNOOG9xMFhzVFg3WVpuaVFkSDNnS2RkM2NlanAxbkVOa25OeVZKL2lxejUw?=
 =?utf-8?B?MHNvZHl6Y0tlVzV0TlFBWG5UUFhkeHhBREVJSVRpQjd0ZEVmT085VE44RjEw?=
 =?utf-8?B?T0hXZlV4V3NhYy8xQVdxemgzM1hQYmJOSjJvekEwcU85ZUxQWEd6U01ZSWZY?=
 =?utf-8?B?SUluWTR0dzRSMjRLS3NGdHFPZ1VTYTlkNFZKMklUNW5QNlV6bWUxWUUzSVps?=
 =?utf-8?B?TFFQazdlVElmSWxOd0F6eVltK2lZZTVwUVJpbTZVdEVtd3VtRVBneDBTbW03?=
 =?utf-8?B?WVlIYkhIYis1MU9oa210emRhQ3B3RkFGcnlSaERJTlVrNzFhZ3Fzd09WaHpG?=
 =?utf-8?B?eWNxY241ZkZTM3lLWUhJaW1aODFhV1EvM2xiT05zclUzZ01ndXRiMHNiMk56?=
 =?utf-8?B?amtJRm05YUVTNTBvWCtBLzk5ZkI0WkhxQ0dpVThyZDVpelkxQk9QclVocFdS?=
 =?utf-8?B?SU8vYUt1K0pQZnZrNmxSeGVwZWJKWnZpWVM0YWFlMkxhYzd5ZXF3Q1A5NW4v?=
 =?utf-8?B?S29ockRidmUydkU4R3ZHOXA0cFVNYXpFYmQ1UVdteEllMHgzM3hDL1hmOEFj?=
 =?utf-8?B?eUlhQ3hMbTBsVzRBL2dxT1VlTFZlOTZ2d0NlL1c5MlA4dzRXRS9ObHAxNWZ0?=
 =?utf-8?B?NW5CZlViS1Y4WkpHUEwvT3RxOXRWOXJyaEdPbmZrUFRpUEhJM09iNVNCK212?=
 =?utf-8?B?S1hYTHV0b0FRc0ZOTzd3RGJBbVNlRWhOQlptTm4yUmQ3dmRTU1g2bHB3WEVC?=
 =?utf-8?B?dUxDeHprU3ZzWU5NM28wYXJsd2Z6UEhVak1ub1N3N1gwRnR0MlFJTHc4UWRC?=
 =?utf-8?B?UWxOdWsrT2ZHejlwL053NVFadHR0MHFiM3ppUk1OY1NlWU9yZWJaUTF3ZDJ4?=
 =?utf-8?B?MnZBbjVPMnphaTFSUjduTno1OEpnRmlrbzNMNTIzQXZqdWJmeENMQmdtRGRP?=
 =?utf-8?B?ZlduQU5uaDJ2cWhDWmhsbUd3UnlhclJiWGlYTVcxMkhvS000aldPcFdBWitD?=
 =?utf-8?B?c1NHdWpmQVRabFFZcW5GVWJJZVBQMUdxZE13UXY3NGsweG5kdG1wcEl2SkQy?=
 =?utf-8?B?amxjTUpFRWxjZEsycENxOFR3TExTVmlOemJwcFc3dXlYMnJJTUZ2ZDVzQS9l?=
 =?utf-8?B?R0JMZTEyZWFxcTdiWVp2MDFndGI2VlcvMVpSamp6MVRmaTVhbVJxdUNValRu?=
 =?utf-8?B?T01lampPRm1aY1BNMEUvdGl5VG5hMTBvNGl0bm42RmtZV1dMVUEwMTZOY1gw?=
 =?utf-8?B?OERnMVN1dGEreGFyNXZrbXh1bDgvSEF5Q2JlWDdMWFZ4TVJwYjhaMVBjTDkx?=
 =?utf-8?B?T3NFRkwyRXN5eE11R2ljbUNUMW0zVUxKTWhUWUFIZ0xsWXIvbHZPcjMxci9p?=
 =?utf-8?B?YmQvY2xWQnFCc2NydFNld1FkRzlsdVBwRGVnRmFpSjQrako1VGo3dW5KVHdK?=
 =?utf-8?B?VmpLQTkrNmVmcXM5SnBiM09NaGg2VXBNM0MwZHVQLzRMM01kUFNUVi9GVmx6?=
 =?utf-8?B?dm1zVnJ5NGFvcGt1OTBjNGE5R2pUNTR3bno1K1B3eUxsbTREWGM4N3FVaFBX?=
 =?utf-8?B?NVJzNTFqVlk2b3d2aWhhOTZLSzVjZjROUG5DRGxVb1hiWTM0b01uNFhNRzM0?=
 =?utf-8?B?clJuNUQrSXpsZXMzSjFEZy9pZ3FCdEtXRmxZclVVdHk2R2ZtL2FVSTF3L3ZE?=
 =?utf-8?B?U2lpbFZyZGhSTlJGR1c3RWVaMmN6TkFRYjk3bVo2b3ZjNzgyb2dTdU9EWE9p?=
 =?utf-8?B?UGJiajhlNlVIaGNnb2lTMUNrUWgvUkNCek1IYVlYRnV3OUx5bFdLdmZCSW92?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ee9599-a649-4b31-db08-08dbb128eb66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 11:35:51.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJzt9vzw8OUrGVd2pyLrEF7ZOMfWiNTsAM5vTCnbbzZsZ+fu3mOgwn8f8GIvX7JEbJTztB+XG0rB6DGeaOIyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7661

On 08.09.23 12:50, Johannes Kirchmair wrote:
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
>  include/cobalt/kernel/ppd.h                   |  3 ++
>  include/cobalt/kernel/thread.h                |  2 +
>  include/cobalt/signal.h                       |  2 +
>  include/cobalt/uapi/syscall.h                 |  2 +
>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>  .../arch/x86/include/asm/xenomai/thread.h     |  3 ++
>  kernel/cobalt/arch/x86/signal.c               | 51 +++++++++++++++++++
>  kernel/cobalt/dovetail/kevents.c              |  3 ++
>  kernel/cobalt/posix/syscall.c                 | 32 ++++++++++++
>  kernel/cobalt/thread.c                        | 38 ++++++++++++++
>  kernel/cobalt/trace/cobalt-posix.h            |  4 +-
>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>  lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++++++
>  lib/cobalt/internal.h                         |  2 +
>  lib/cobalt/signal.c                           | 13 +++++
>  15 files changed, 192 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/cobalt/arch/x86/signal.c
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
> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
> index 3e65efaab..3913cc610 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -141,6 +141,8 @@
>  #define sc_cobalt_timerfd_settime64		118
>  #define sc_cobalt_timerfd_gettime64		119
>  #define sc_cobalt_pselect64			120
> +#define sc_cobalt_sigreturn			121
> +#define sc_cobalt_sigaction			122
>  
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>  
> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
> index 93929b645..e3d8eb476 100644
> --- a/kernel/cobalt/arch/x86/Makefile
> +++ b/kernel/cobalt/arch/x86/Makefile
> @@ -1,5 +1,5 @@
>  
>  obj-$(CONFIG_XENOMAI) += xenomai.o
> -xenomai-y := machine.o smi.o c1e.o
> +xenomai-y := machine.o smi.o c1e.o signal.o
>  
>  ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> index 745c32467..70f3df2f1 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> @@ -28,5 +28,8 @@
>  #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
>  					 ((__nr) == X86_TRAP_DB || (__nr) == X86_TRAP_BP))
>  #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
> +#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info);
>  
>  #endif /* !_COBALT_X86_ASM_THREAD_H */
> diff --git a/kernel/cobalt/arch/x86/signal.c b/kernel/cobalt/arch/x86/signal.c
> new file mode 100644
> index 000000000..2e8fdc571
> --- /dev/null
> +++ b/kernel/cobalt/arch/x86/signal.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/signal.h>
> +#include <linux/uaccess.h>
> +#include <cobalt/kernel/thread.h>
> +
> +#include <asm/sigframe.h>
> +#include <asm/sighandling.h>
> +#include <asm/fpu/signal.h>
> +#include <asm/trapnr.h>
> +
> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
> +			   long errcode, int *sig, struct kernel_siginfo *info)
> +{
> +	switch (vector) {
> +	case X86_TRAP_DE: /* divide_error */
> +		*sig = SIGFPE;
> +		info->si_signo = *sig;
> +		info->si_errno = 0;
> +		info->si_code = FPE_INTDIV;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	case X86_TRAP_UD: /* invalid_op */
> +		*sig = SIGILL;
> +		info->si_signo = *sig;
> +		info->si_errno = 0;
> +		info->si_code = ILL_ILLOPN;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +	case X86_TRAP_MF:
> +		*sig = SIGFPE;
> +
> +		info->si_signo = *sig;
> +		info->si_errno = 0;
> +		info->si_code = 0;
> +		info->si_addr = (void __user *)regs->ip;
> +		return 0;
> +        case X86_TRAP_PF:
> +                *sig = SIGSEGV;
> +                info->si_signo = *sig;
> +                info->si_errno = errcode;
> +                info->si_code = 0;
> +                info->si_addr = 0;
> +                return 0;

Indention got damaged.

> +	default:
> +		break;
> +	}
> +
> +	return -ENOSYS;
> +}
> +
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 4da4f51b7..09eb12acb 100644
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
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
> index 46c4998e4..d570bd595 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -277,6 +277,38 @@ static COBALT_SYSCALL(serialdbg, current,
>  	return 0;
>  }
>  
> +static COBALT_SYSCALL(sigreturn, current, (void))
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	int ret;
> +
> +	ret = dovetail_restore_rt_signal_frame(regs);
> +	if (ret < 0)
> +		goto badframe;
> +
> +	return __xn_reg_rval(regs);
> +
> +badframe:
> +	xnthread_signal(xnthread_current(), SIGSEGV, 0);
> +	return -1;
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

Checked if we can do better during binding or thread mapping but,
indeed, none of those calls provide a convenient channel to carry this
information.

But then let's avoid the "optimization" and simply always deliver this
from userspace (what you already do) and always assign here in kernel space.

> +
> +	return 0;
> +}
> +
>  static void stringify_feature_set(unsigned long fset, char *buf, int size)
>  {
>  	unsigned long feature;
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 41804b24f..ae8fa5c88 100644
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
> @@ -2520,6 +2522,42 @@ int xnthread_killall(int grace, int mask)
>  }
>  EXPORT_SYMBOL_GPL(xnthread_killall);
>  
> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs)
> +{
> +	unsigned int code = xnarch_fault_code(regs);
> +	unsigned int vector = trapnr;
> +	struct cobalt_ppd *sys_ppd;
> +	struct kernel_siginfo si;
> +	struct ksignal ksig;
> +	int sig, ret = 0;
> +
> +	code = xnarch_fault_code(regs);

Duplicate assignment. But actually I see no value in asking the arch
first for this fault code, only to deliver it to an arch-specific call,
and only to it. Just let xnarch_setup_trap_info retrieve the fault code
itself.

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
> +	if (ret)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /* Xenomai's generic personality. */
>  struct xnthread_personality xenomai_personality = {
>  	.name = "core",
> diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
> index 47dc77e1c..8eda3bb27 100644
> --- a/kernel/cobalt/trace/cobalt-posix.h
> +++ b/kernel/cobalt/trace/cobalt-posix.h
> @@ -173,7 +173,9 @@
>  		__cobalt_symbolic_syscall(timer_gettime64),		\
>  		__cobalt_symbolic_syscall(timerfd_settime64),		\
>  		__cobalt_symbolic_syscall(timerfd_gettime64),		\
> -		__cobalt_symbolic_syscall(pselect64))
> +		__cobalt_symbolic_syscall(pselect64),			\
> +		__cobalt_symbolic_syscall(sigreturn),			\
> +		__cobalt_symbolic_syscall(sigaction))
>  
>  DECLARE_EVENT_CLASS(cobalt_syscall_entry,
>  	TP_PROTO(unsigned int nr),
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

I still need to play with those two in order to see if we can do it more
elegantly, ie. without assembly.

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

Not sure if we need that getter, definitely not as non-inline function
unless you make cobalt_sigreturn static.

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

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

