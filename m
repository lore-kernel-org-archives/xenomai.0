Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D014297
	for <xenomai@lists.linux.dev>; Fri, 12 May 2023 17:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODBji5oDhTZAuUqd4C1VOb1iLw0PeNba66PPh5cAGK3gQANVCI4V/5i+YpHiWmBca3nV+VUVpgSTryJWufpf36oKvFnZuIZ+AIbNde+Q00LPn8uXHsKu8qNugZdU6pWvFZ1lK87FnWg3zF+3IP/6oTtQxBRW3SBFbOeb2SpF1EI3TJzvgwVWAXZ6LbDqJpUyKRZAym6lMwvervbx2pOy1j4u+OCSDyf9fFcAJXS7CLykytn5bcUv+q59vW0lX4CX0Qe5DLV+fhx2r2MHl79hP85xUiR81VGexXQ+QfKbpv5zH63y0dzuZrEy+N/irRzjWpZ+EC9Q43G6e8Y0aGzR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpTZjK8s7GNU1ZKYgKn/StJYr4pdLZ7jluSS/sJEXh4=;
 b=XmwL9aPfbI/3PMujmJD9nb4xESDFooJZPy5qP4fSO7tIZ8wwrFOdk3Nsy/pcXstx05LrFh+kEOkK1ulCIbTvw0TFNTxxck3FHGGhQwB2J5yqQMh8/A7koFEzGc315pArrN4xZi0yJDp865QgOsbqlUBsMmvV7UZf4A/LGeaFbTbdP70QS/KQi9cdN9YczRVq0/NzsuU939KwH+3posuNOx6XL6CkT+QAZbV7Fp15+GyGZfY3WnqJdqNWjjOxY6o/+gBe72HmmQXQscbaArOu863hWUsh/6Axwfg0D7lpCNAo4lYLbgpoAwvWjcQ1fozZbBKyvdqKhYDsGOzBGfLjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpTZjK8s7GNU1ZKYgKn/StJYr4pdLZ7jluSS/sJEXh4=;
 b=aM3xQAkCzYz+aZSa4IGDKTNnHSYhv2wk/b8rOl6By9VYALXbQOyhTRlc7qTjqsU85s8vxuthiW5pakFQmQRl6o/FiyaY1S8GyaN1G18LA6zr8FoOK+JsThM1TiTi/ZpNtplh3iYXpGGYInmsFzdY64KvsxztdX5bhVa+Ts4ip9f4plfw2t38fqbXllHFBwiunxKD4ycR4/AtVW5wECsfbbdiQsQZzS4dCc6he+VMQ2/4OkFJ4hZAb5Vr7d5kllb1ZPa9yKM/6VzltvSSf0KyZvpnTY5k2nY1au+X4tPIYl9bN9a2LA1AXB4kfhlqhCsZArqYMI2gdEsp3TAUSEkveA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7966.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 17:38:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 17:38:57 +0000
Message-ID: <7bb48d32-0c2f-18bc-8d66-cf969e6be74b@siemens.com>
Date: Fri, 12 May 2023 19:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 "Schaffner, Tobias" <tobias.schaffner@siemens.com>
References: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
 <VE1PR08MB4909999B96106DD25AE0D19D92769@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909999B96106DD25AE0D19D92769@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: dc708db5-5f17-4e39-82c2-08db530fc35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	juMq8Uu52OICvfOGfBvD6U7wn4NxZqZ2EjOukrNg7aVAU7DHwIVWjgSlyBxGZM4UGE3rtqAeQMu8nyvayBqIC6oyB51ZaH+Sr84+OQarGVPe8sn4/NpjUeonx/JXaFakhGWRvTEHrPad3yzcvQ8V0NDPrIHYHbY92Gs8BCPxs551efvhIFAwATxVijAl7acS6HTFslwL2H4JVwUzmdXewpx0pdz3lpASZESnseNs6FXMvO6Ly4nhp/Wj0Ov03BEB/i59BJERoPWHqq3+As6HEmew0/A7cpxibhZxeqHQ8rJdgoR2VMvqPZZzK5k4nm0c6V7NsblMkdHHUdFYSG161/fgxDLScDvNwnXpGZ0PnBvRQFWtxyFOqgrsfC99nuo+B2pJet3FllH/vcOH2M3rooZBTiU+tYhQVMuNtAn6KS43lBBgWWUdkGdPgSjDT9Wt/YA9Fco34XcfcevzhZhVKnkrlRnIogRdMVv13ePprpV9jZt0U9OpJVdbZExl+WEvhnd6OWBIbr5gbgTEimvRliNc/aDOqZx6wV4VwG+VjsrndJ5awQmWj4volRJb5PVyKfK4zjsgZes2sRX9fmEOCPYiCA/MXbNyKNvRWUBP1rkRj90wukkUuZFSsvRFRrV13AmHue+bCAyU1JXNMv9nDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(6506007)(6512007)(26005)(38100700002)(186003)(2616005)(6486002)(6666004)(316002)(36756003)(83380400001)(6636002)(2906002)(44832011)(30864003)(86362001)(31696002)(66946007)(478600001)(53546011)(66476007)(41300700001)(110136005)(8936002)(66556008)(5660300002)(8676002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3NiU0VaVHFSNHBjaDQ3RzdVSXBRRWtzS0Jrak1CMXRQUTNKNzhEaDdwWjJB?=
 =?utf-8?B?akNINm1kWTRUTVU1ZFdXWWVKS1diM1Y3U1p6YklWS09SbnNLcGNnVkhLZm9G?=
 =?utf-8?B?WUpyZjJWMlJWM0NHTkxsWW96WUQ5ZUJUc1I2TndwNjIrMjgxdmNTb0tGYU8y?=
 =?utf-8?B?V3pPcUhseHcxSnZBNjk5ZC9BejBqN1VwZ0QrMmpvT1l4bzErR0NOS084QS8z?=
 =?utf-8?B?VHJRYUlYQVY3Rm5LMlB0Mkk3ZTVESDZXaTdHTWJ3RFdoMThOQXhXSDl3bzdy?=
 =?utf-8?B?V2FvV1dEMFVqSEo1TzRvZzlMWDJPcWgwdUdMYmJYSHdnbE5FbjB0UHF6VWpZ?=
 =?utf-8?B?N1h5a3RReTB3Z0o3Q1FIUmF5YS9RNE9ha2plTmx6TFNqVDU3VHoyZkJFaVZv?=
 =?utf-8?B?OTArUjRyZTFyV2NhWEVwRkx1cE9Fcnp5YnBLWUR5Y3FlYkx0T2IwRTNaUUxk?=
 =?utf-8?B?dGY1SzZNallDODBJdDZ1RHd1Q2Z2eFo3NkpPcEgrQkRGMXRNa3N5UlRVbkJk?=
 =?utf-8?B?U3BkK1FydW45aENJcFZKYUZneWhxbGRDcU1kN2c5ZlNySHl0blRleEhxeVVP?=
 =?utf-8?B?ZFNRN3lmSXdqTHJ5RGdmZitBc0RZWGdUYythN2N0TUhxWlpIbTBmaTA5M2ow?=
 =?utf-8?B?dVRJVjdUNUY4WC9XdXdmZWRMcUJMdHR4WXJFVFNKaDFabStLb25reGhyU3ZX?=
 =?utf-8?B?TDFSVEtYa2c5bXhWY0xNV3RqRlZTNzdQc09ROUlwSTJXaXluYjFnVnZtVFNR?=
 =?utf-8?B?bXBTWEFybFFVRndxM1BPVXU3NnJ5clMwUlFuWExUY3FyZzQ5dTQ0Z1JPTUpD?=
 =?utf-8?B?RTFZSnRhK2tpNHh6SEdUS24xSmRYbmdndzRmUy9WeFNuVkZUOE53ZVJwYTFQ?=
 =?utf-8?B?cE9rR0FndzZ3SGt6eElWZ0JRcHY0R3FqRDFNTVp2OXF0NGpFRUJoellxV1hE?=
 =?utf-8?B?NjFsRHBxbzk4WjBSZU8wRDhPV2xiNllTaDBvMWJ0dWMwZkRaTnJGMlpYREE5?=
 =?utf-8?B?RUFXMHB5bDRmZ1RNYXZIQWg2QzMzcDBHdVpBUkxMbXJTa2V3aTBXaUVRNTVx?=
 =?utf-8?B?QWFRNTc3OEYvR1dIbzlObk9lSTdEcFRmRTlsRDJrYnpEdDhHRElad05MdGN1?=
 =?utf-8?B?Rkl6N1VoRG43bFYzRFpKalBkeTZYNGg1WHZMTE9nVkhLdENuUm9adGxRVTdl?=
 =?utf-8?B?VFdUVS9EN3BMbHJPSi9xeW0vaklNNHk5dmV1bXI2VE9qYnM4Q0pZVW8yKzQz?=
 =?utf-8?B?YktYaGZtZS81ak9SY0czbzZUa1BtNUxlbHJRZ2hKck9uN0hSMmJGZGdwUldY?=
 =?utf-8?B?dll4YS9YTEMzQ3pWa0N0a0dpRXlDUXFpWjU1K0tOanUwb1ducklURDd6SE1P?=
 =?utf-8?B?WE12R2Rqb3JiTlFDQkNRZS80ODJOZUlNY0pzMVM4UkJad0hnMWpOS2owRERO?=
 =?utf-8?B?S1dPWVlJZDdIK0lrcW1aSlVrQmlVbTZMUVlvVXVWM0l2dWlRR1NRTlVVSHVG?=
 =?utf-8?B?Vm93QTE2ZTkra0E4ZFpieGk5ZGoyODdvd1duRXppcnFZWlNSR0Q2L080blRh?=
 =?utf-8?B?YXdlRVlITW1WMU5JNlNRSHlFVHRCVkxBQk5meGMxMEgwbUF5RWJyRFh3R05Q?=
 =?utf-8?B?b3cvbllzTzh1eXRMWi9ONVMzWnJ2dWIzaEtJZ2VPSjYyRHBKc00zOTNqRTlB?=
 =?utf-8?B?emNOaytzbzB6MmF2a0xnUnNEQUtwcVYyMGhVNTVNcjZsL0t0VzRuMSttZjh0?=
 =?utf-8?B?SElnTFg1ZC9jekxiSnFPYnA1UkpPZGU0b21JQUd3M3ZuUFhvRXhEYlNMSks5?=
 =?utf-8?B?WXpINTR1UUZUSVdiSmdNZmMrcnUrNStxdmVrdW1pU251RXFWQnczQ1B3Zk5a?=
 =?utf-8?B?bFpQaGRuakhJTkFFT05uWDk2WEl1cEZSRWN3U0FKNENTM2dDc0hLQjVCWGpl?=
 =?utf-8?B?ZXFPS2RjeUVlczkrR3kvMlE0ZEkxUTVxdm42SFpPSTRNRUNveTJjWWRIZVQw?=
 =?utf-8?B?d1lSRGxUUXR3bUpNdmxUK2JWMEpaLzJScHJ2ajdVeXpNTzcwdGtGWCtTeldy?=
 =?utf-8?B?V3g2QmM0Q2hGUlpqU29sT1hPQWc3L3ZMVXVhQldXL0dNZitmWkkvOUJydjA1?=
 =?utf-8?B?OXpPR1dHb0VJMDhsdy9jdFNKRmFPYlFyRGdKTFZYRUZoSkpERFZndjArOU1n?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc708db5-5f17-4e39-82c2-08db530fc35c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:38:57.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHXkLqGavsVejCp41EnClXD6Dyvdp1C5+IaIOSy4Ft4ROr7UB7sVL3UZTmA6Xj4HpnKdND0iZZiqWxxlVh8hkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7966

On 09.05.23 15:17, Johannes Kirchmair wrote:
> Hello Jan and Tobias,
> 
> I just dropped the patches on the mailing list.
> For the dovetail functions I took a rather naive approach, using most of the frame setup code provided by Linux.
> I just tested it for 32bit and 64bit x86 Applications and it seems to work. 
> 
> I also added a tool rt_signal_hist that runs in a cycle and measures the time an exception handling takes.
> It is afterwards put into an txt file that reassembles an histogram of the timings.
> 
> Unfortunately as a 32bit application the rt_signal_hist tool does not run to completion, printing the following:
> " Xenomai/cobalt: sleeping while holding mutex
> CPU time limit exceeded"
> 
> Maybe the naive approach is not so reliable ;-/
> Hope I find the time the look into it. 
> 

I looked into the x86 signalframe helpers before and found some traces
of locking that make them incompatible - if I rember correctly. After
that, I dropped the idea of just removing the "static".

> Sorry for not putting more effort into this so fare.
> 
> The next most important step in my opinion would be to define a clean interface into dovetail for the signal frame setup and restoring.
> Actually that's the task I consider one of the harder and I am not so sure how to approach this.
> 

Exactly, and we need to involve Philippe now soon. Let me medidate over
some interface options as well. Will pick up if you don't find the time
soon.

Jan

> Best regards
> Johannes
> 
>> -----Original Message-----
>> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>> Sent: Dienstag, 9. Mai 2023 15:14
>> To: xenomai@lists.linux.dev
>> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>> Subject: [PATCH 1/3] [POC] test implementaion of rt-signals
>>
>> We implement rt signals to handle exceptions in rt stage.
>>
>> This is done using dovetail specific functions for setting up the signal
>> frame.
>>
>> This can be used to handle fpe exceptions on the fly, like fixing
>> division by zero. An other use case are breakpoints, implemented using the
>> illegal opcode exception. The real time handling of the breakpoints would
>> be handy for conditional breakpoints or also for stopping watchdogs and
>> other tasks in time.
>>
>> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>> ---
>>  include/cobalt/kernel/ppd.h                   |  3 +
>>  include/cobalt/kernel/thread.h                |  2 +
>>  include/cobalt/signal.h                       |  2 +
>>  include/cobalt/uapi/syscall.h                 |  6 ++
>>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>>  .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
>>  kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
>>  kernel/cobalt/arch/x86/signal_ia64.c          | 26 +++++++
>>  kernel/cobalt/dovetail/kevents.c              |  5 ++
>>  kernel/cobalt/posix/process.c                 |  3 +-
>>  kernel/cobalt/posix/syscall.c                 | 28 +++++++
>>  kernel/cobalt/posix/syscall32.c               | 16 ++++
>>  kernel/cobalt/thread.c                        | 39 ++++++++++
>>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>>  lib/cobalt/arch/x86/sigreturn.c               | 32 ++++++++
>>  lib/cobalt/internal.h                         |  2 +
>>  lib/cobalt/signal.c                           | 13 ++++
>>  17 files changed, 266 insertions(+), 3 deletions(-)
>>  create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
>>  create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c
>>  create mode 100644 lib/cobalt/arch/x86/sigreturn.c
>>
>> diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
>> index f0079fe6e..fb2f682da 100644
>> --- a/include/cobalt/kernel/ppd.h
>> +++ b/include/cobalt/kernel/ppd.h
>> @@ -22,6 +22,7 @@
>>  #include <linux/types.h>
>>  #include <linux/atomic.h>
>>  #include <linux/rbtree.h>
>> +#include <linux/signal.h>
>>  #include <cobalt/kernel/heap.h>
>>
>>  struct cobalt_umm {
>> @@ -32,6 +33,8 @@ struct cobalt_umm {
>>
>>  struct cobalt_ppd {
>>  	struct cobalt_umm umm;
>> +	void __user *sighand[_NSIG];
>> +	void __user *sigrestorer;
>>  	atomic_t refcnt;
>>  	char *exe_path;
>>  	struct rb_root fds;
>> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
>> index b79cb8429..33d468419 100644
>> --- a/include/cobalt/kernel/thread.h
>> +++ b/include/cobalt/kernel/thread.h
>> @@ -574,6 +574,8 @@ static inline void xnthread_propagate_schedparam(struct
>> xnthread *curr)
>>  		__xnthread_propagate_schedparam(curr);
>>  }
>>
>> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs);
>> +
>>  extern struct xnthread_personality xenomai_personality;
>>
>>  /** @} */
>> diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
>> index 62694f93a..3d6540aff 100644
>> --- a/include/cobalt/signal.h
>> +++ b/include/cobalt/signal.h
>> @@ -54,6 +54,8 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
>>  COBALT_DECL(int, sigqueue(pid_t pid, int sig,
>>  			  const union sigval value));
>>
>> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *));
>> +
>>  #ifdef __cplusplus
>>  }
>>  #endif
>> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
>> index 9646a0d97..6307fae7f 100644
>> --- a/include/cobalt/uapi/syscall.h
>> +++ b/include/cobalt/uapi/syscall.h
>> @@ -137,6 +137,12 @@
>>  #define sc_cobalt_recvmmsg64			114
>>  #define sc_cobalt_cond_wait_prologue64		115
>>
>> +/*
>> + * Sigmatek specific syscalls
>> + */
>> +#define sc_cobalt_sigreturn			120
>> +#define sc_cobalt_sigaction			121
>> +
>>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>>
>>  #endif /* !_COBALT_UAPI_SYSCALL_H */
>> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
>> index 93929b645..e725afbff 100644
>> --- a/kernel/cobalt/arch/x86/Makefile
>> +++ b/kernel/cobalt/arch/x86/Makefile
>> @@ -1,5 +1,5 @@
>>
>>  obj-$(CONFIG_XENOMAI) += xenomai.o
>> -xenomai-y := machine.o smi.o c1e.o
>> +xenomai-y := machine.o smi.o c1e.o signal_ia32.o signal_ia64.o
>>
>>  ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
>> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> index 745c32467..4d004680b 100644
>> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> @@ -28,5 +28,18 @@
>>  #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED)
>> &&	\
>>  					 ((__nr) == X86_TRAP_DB || (__nr) ==
>> X86_TRAP_BP))
>>  #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
>> +#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
>> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
>> +			   long errcode, int *sig, struct kernel_siginfo *info);
>> +
>> +int xnarch_setup_rt_frame_ia32(int sig, void *handler, struct kernel_siginfo *si,
>> +			  struct pt_regs *regs, void __user *restorer);
>> +
>> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
>> +
>> +int xnarch_setup_rt_frame_ia64(int sig, void *handler, struct kernel_siginfo *si,
>> +			  struct pt_regs *regs, void __user *restorer);
>> +
>> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs);
>>
>>  #endif /* !_COBALT_X86_ASM_THREAD_H */
>> diff --git a/kernel/cobalt/arch/x86/signal_ia32.c
>> b/kernel/cobalt/arch/x86/signal_ia32.c
>> new file mode 100644
>> index 000000000..e78c8c4d4
>> --- /dev/null
>> +++ b/kernel/cobalt/arch/x86/signal_ia32.c
>> @@ -0,0 +1,75 @@
>> +#include <linux/signal.h>
>> +#include <linux/uaccess.h>
>> +#include <cobalt/kernel/thread.h>
>> +
>> +#include <asm/sigframe.h>
>> +#include <asm/sighandling.h>
>> +#include <asm/fpu/signal.h>
>> +
>> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
>> +			   long errcode, int *sig, struct kernel_siginfo *info)
>> +{
>> +	switch (vector) {
>> +	case 0: /* divide_error */
>> +		*sig = SIGFPE;
>> +		info->si_signo = *sig;
>> +		info->si_errno = 0;
>> +		info->si_code = FPE_INTDIV;
>> +		info->si_addr = (void __user *)regs->ip;
>> +		return 0;
>> +	case 1: /* trap_error */ {
>> +		unsigned long condition;
>> +		get_debugreg(condition, 6);
>> +		set_debugreg(0, 7);
>> +		*sig = SIGTRAP;
>> +		info->si_signo = *sig;
>> +		info->si_errno = errcode;
>> +		info->si_code = get_si_code(condition);
>> +		info->si_addr = (void __user *)regs->ip;
>> +		return 0;
>> +	}
>> +	case 3: /* trap_error */
>> +		*sig = SIGTRAP;
>> +		info->si_signo = *sig;
>> +		info->si_errno = errcode;
>> +		info->si_code = SI_KERNEL;
>> +		info->si_addr = (void __user *)regs->ip;
>> +		return 0;
>> +	case 6: /* invalid_op */
>> +		*sig = SIGILL;
>> +		info->si_signo = *sig;
>> +		info->si_errno = 0;
>> +		info->si_code = ILL_ILLOPN;
>> +		info->si_addr = (void __user *)regs->ip;
>> +		return 0;
>> +	case 16: { /* coprocessor_error */
>> +		*sig = SIGFPE;
>> +
>> +		info->si_signo = *sig;
>> +		info->si_errno = 0;
>> +		info->si_code = 0;
>> +		info->si_addr = (void __user *)regs->ip;
>> +		return 0;
>> +	}
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -ENOSYS;
>> +}
>> +
>> +int xnarch_rt_sigreturn_ia32(struct pt_regs *regs)
>> +{
>> +	int ret;
>> +
>> +	ret = dovetail_restore_rt_signal_frame(regs);
>> +	if (ret < 0)
>> +		goto badframe;
>> +
>> +	return regs->ax;
>> +
>> +badframe:
>> +	xnthread_call_mayday(xnthread_current(), SIGKILL);
>> +	return -1;
>> +}
>> +
>> diff --git a/kernel/cobalt/arch/x86/signal_ia64.c
>> b/kernel/cobalt/arch/x86/signal_ia64.c
>> new file mode 100644
>> index 000000000..a7044db40
>> --- /dev/null
>> +++ b/kernel/cobalt/arch/x86/signal_ia64.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 1991, 1992  Linus Torvalds
>> + *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
>> + *
>> + *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
>> + *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
>> + *  2000-2002   x86-64 support by Andi Kleen
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +
>> +#include <linux/signal.h>
>> +#include <linux/uaccess.h>
>> +#include <cobalt/kernel/thread.h>
>> +
>> +#include <asm/sigframe.h>
>> +#include <asm/sighandling.h>
>> +#include <asm/fpu/signal.h>
>> +
>> +int xnarch_rt_sigreturn_ia64(struct pt_regs *regs)
>> +{
>> +	return dovetail_restore_rt_signal_frame(regs);
>> +}
>> +
>> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
>> index 4da4f51b7..61417717b 100644
>> --- a/kernel/cobalt/dovetail/kevents.c
>> +++ b/kernel/cobalt/dovetail/kevents.c
>> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct
>> pt_regs *regs)
>>  		xnsched_run();
>>  	}
>>
>> +	if (xnthread_handle_rt_signals(trapnr, regs) == 0)
>> +		return;
>> +
>>  	/*
>>  	 * If we experienced a trap on behalf of a shadow thread
>>  	 * running in primary mode, move it to the Linux domain,
>> @@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct
>> pt_regs *regs)
>>  		xnstat_counter_inc(&thread->stat.pf);
>>
>>  	xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAULT);
>> +
>> +	return;
>>  }
>>
>>  static inline int handle_setaffinity_event(struct dovetail_migration_data *d)
>> diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
>> index 1abc86f37..2069129cb 100644
>> --- a/kernel/cobalt/posix/process.c
>> +++ b/kernel/cobalt/posix/process.c
>> @@ -738,9 +738,10 @@ void cobalt_unregister_debugged_thread(struct
>> xnthread *thread)
>>  		cobalt_resume_debugged_process(process);
>>  }
>>
>> +#ifdef CONFIG_SMP
>> +
>>  int cobalt_handle_setaffinity_event(struct task_struct *task)
>>  {
>> -#ifdef CONFIG_SMP
>>  	struct xnthread *thread;
>>  	spl_t s;
>>
>> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
>> index 46c4998e4..b4bd4c587 100644
>> --- a/kernel/cobalt/posix/syscall.c
>> +++ b/kernel/cobalt/posix/syscall.c
>> @@ -277,6 +277,34 @@ static COBALT_SYSCALL(serialdbg, current,
>>  	return 0;
>>  }
>>
>> +static COBALT_SYSCALL(sigreturn, current, (void))
>> +{
>> +	struct pt_regs *regs = task_pt_regs(current);
>> +
>> +	if (regs->cs == __USER_CS)
>> +		xnarch_rt_sigreturn_ia64(regs);
>> +	if (regs->cs == __USER32_CS)
>> +		xnarch_rt_sigreturn_ia32(regs);
>> +
>> +	return __xn_reg_rval(regs);
>> +}
>> +
>> +static COBALT_SYSCALL(sigaction, current, (int sig, void __user *handler,
>> +		      void __user *restorer))
>> +{
>> +	struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
>> +
>> +	if (sig < 0 || sig >= _NSIG)
>> +		return -EINVAL;
>> +
>> +	sys_ppd->sighand[sig] = handler;
>> +
>> +	if (!sys_ppd->sigrestorer)
>> +		sys_ppd->sigrestorer = restorer;
>> +
>> +	return 0;
>> +}
>> +
>>  static void stringify_feature_set(unsigned long fset, char *buf, int size)
>>  {
>>  	unsigned long feature;
>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>> index b65a0a760..f8b21bfb2 100644
>> --- a/kernel/cobalt/posix/syscall32.c
>> +++ b/kernel/cobalt/posix/syscall32.c
>> @@ -774,6 +774,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
>>  	return ret ?: __cobalt_sigqueue(pid, sig, &val);
>>  }
>>
>> +COBALT_SYSCALL32emu(sigaction, current,
>> +		    (int sig, void __user *handler, void __user *restorer))
>> +{
>> +	struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
>> +
>> +	if (sig < 0 || sig >= _NSIG)
>> +		return -EINVAL;
>> +
>> +	sys_ppd->sighand[sig] = handler;
>> +
>> +	if (!sys_ppd->sigrestorer)
>> +		sys_ppd->sigrestorer = restorer;
>> +
>> +	return 0;
>> +}
>> +
>>  COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
>>  		    (struct cobalt_monitor_shadow __user *u_mon,
>>  		     int event, const struct old_timespec32 __user *u_ts,
>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>> index 41804b24f..71f97c481 100644
>> --- a/kernel/cobalt/thread.c
>> +++ b/kernel/cobalt/thread.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/signal.h>
>>  #include <linux/pid.h>
>>  #include <linux/sched.h>
>> +#include <asm/sighandling.h>
>>  #include <uapi/linux/sched/types.h>
>>  #include <cobalt/kernel/sched.h>
>>  #include <cobalt/kernel/timer.h>
>> @@ -43,6 +44,7 @@
>>  #include <pipeline/inband_work.h>
>>  #include <pipeline/sched.h>
>>  #include <trace/events/cobalt-core.h>
>> +#include "posix/process.h"
>>  #include "debug.h"
>>
>>  static DECLARE_WAIT_QUEUE_HEAD(join_all);
>> @@ -2520,6 +2522,43 @@ int xnthread_killall(int grace, int mask)
>>  }
>>  EXPORT_SYMBOL_GPL(xnthread_killall);
>>
>> +int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs)
>> +{
>> +	struct ksignal ksig;
>> +
>> +	unsigned int vector = trapnr;
>> +	unsigned int code = xnarch_fault_code(regs);
>> +	struct cobalt_ppd *sys_ppd;
>> +	int sig, ret = 0;
>> +	struct kernel_siginfo si;
>> +
>> +	code = xnarch_fault_code(regs);
>> +	ret = xnarch_setup_trap_info(vector, regs, code, &sig, &si);
>> +	if (ret || sig == 0)
>> +		return 1;
>> +
>> +	sys_ppd = cobalt_ppd_get(0);
>> +	if (sig >= _NSIG ||
>> +	    sys_ppd->sighand[sig] == NULL ||
>> +	    sys_ppd->sighand[sig] == SIG_DFL)
>> +		return 1;
>> +
>> +	if (sys_ppd->sigrestorer == NULL)
>> +		return 1;
>> +
>> +	ksig.sig = sig;
>> +	memcpy(&ksig.info, &si, sizeof(si));
>> +	ksig.ka.sa.sa_flags = SA_SIGINFO | SA_RESTORER;
>> +	ksig.ka.sa.sa_restorer = sys_ppd->sigrestorer;
>> +	ksig.ka.sa.sa_handler = sys_ppd->sighand[sig];
>> +
>> +	ret = dovetail_setup_rt_signal_frame(&ksig, regs);
>> +	if (ret)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>>  /* Xenomai's generic personality. */
>>  struct xnthread_personality xenomai_personality = {
>>  	.name = "core",
>> diff --git a/lib/cobalt/arch/x86/Makefile.am b/lib/cobalt/arch/x86/Makefile.am
>> index a5095be3d..14f5eff97 100644
>> --- a/lib/cobalt/arch/x86/Makefile.am
>> +++ b/lib/cobalt/arch/x86/Makefile.am
>> @@ -2,7 +2,7 @@ noinst_LTLIBRARIES = libarch.la
>>
>>  libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
>>
>> -libarch_la_SOURCES = features.c
>> +libarch_la_SOURCES = features.c sigreturn.c
>>
>>  libarch_la_CPPFLAGS =			\
>>  	@XENO_COBALT_CFLAGS@ 		\
>> diff --git a/lib/cobalt/arch/x86/sigreturn.c b/lib/cobalt/arch/x86/sigreturn.c
>> new file mode 100644
>> index 000000000..76292e145
>> --- /dev/null
>> +++ b/lib/cobalt/arch/x86/sigreturn.c
>> @@ -0,0 +1,32 @@
>> +#include <cobalt/uapi/syscall.h>
>> +#include "internal.h"
>> +
>> +extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribute__
>> ((visibility ("hidden")));
>> +
>> +#ifdef __x86_64__
>> +#define build_restorer(syscall_number)                                         \
>> +	asm(".text\n"                                                          \
>> +	    "    .align 16\n"                                                  \
>> +	    "__cobalt_sigreturn:\n"                                            \
>> +	    "    movq $ " #syscall_number ", %rax\n"                           \
>> +	    "    syscall")
>> +#endif
>> +
>> +#ifdef __i386__
>> +#define build_restorer(syscall_number)                                         \
>> +	asm(".text\n"                                                          \
>> +	    "    .align 16\n"                                                  \
>> +	    "__cobalt_sigreturn:\n"                                            \
>> +	    "    movl $ " #syscall_number ", %eax\n"                           \
>> +	    "    int  $0x80")
>> +#endif
>> +
>> +/*
>> + * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
>> + */
>> +build_restorer(0x10000078);
>> +
>> +void *cobalt_get_restorer(void)
>> +{
>> +	return &cobalt_sigreturn;
>> +}
>> diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
>> index acb3989f1..4782d154a 100644
>> --- a/lib/cobalt/internal.h
>> +++ b/lib/cobalt/internal.h
>> @@ -132,4 +132,6 @@ static inline bool cobalt_features_available(unsigned int
>> feat_mask)
>>  	return (cobalt_features & feat_mask) == feat_mask;
>>  }
>>
>> +extern void *cobalt_get_restorer(void);
>> +
>>  #endif /* _LIB_COBALT_INTERNAL_H */
>> diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
>> index 40d315ebb..af174d570 100644
>> --- a/lib/cobalt/signal.c
>> +++ b/lib/cobalt/signal.c
>> @@ -126,3 +126,16 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, const
>> union sigval value))
>>
>>  	return 0;
>>  }
>> +
>> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
>> +{
>> +	int ret;
>> +
>> +	ret = XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler,
>> cobalt_get_restorer());
>> +	if (ret) {
>> +		errno = -ret;
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> --
>> 2.25.1
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

