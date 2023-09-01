Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC33BE5A
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeYhYmmAFz8w5eWWdeCYawzSvsE1O4YsWSk+965U4WaBJltxdwd8oghy5LHwA1tdnmXc+jEAkVp137mriNMPfpzvwsCJSarntb6fVszZql9q1Xy2CZOU0C0m20TKvqHyJfT+o0AinwjhTEWXvl31QYO3zFBeOa4L8Rhe5+cnwE+K2H4n+x5kMCk1j7eGlKdKHcPQhK3hbmmyBUw1AV06nxtDFi743aL3GCFy9xGODcy7CeTJiKPZd0TSTJ/9sggUvHq3JuCPp43pb8WbyqFa1puFvSHl9fJvSnc/UrG0Sk6p/6B1/7g0aaUrFhwV5DY1rvfdQeOXdp8zaLjg9ATUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vLDHDp8AM2SOvZJBZBSwK/1lnx+uB4jJvmaL6gra04=;
 b=oZLOyMyKOhl71DZX29SmnUI4vVdIEfnXo0SmsfhifbOfpMJPZjgGsCiWV/lKoj4hQDQ7kdBOQ4TfshJY9OlVicfZhp3ifjeY59IVcy6JQiD/e3e+bZ4X5c3Se2kRVbeMbg4FrmzqgFVT7HH/IJcgVo9YEOK7BVj8+hBgITCp3gv8ZF8TnlphDnswBbR0uNb9ZufAO2A7H2jl+dVSbYC3tnPjwhJgq2wJ5c2ctchJE3i9zxSDmXJGU/VsKRzcUjNyQXXaOK+sUb8JmS8vB8vGJDXqrBtLqd6WUX79CsbgH2akxifr+42m0wUQGBiKZJ5u/oFEtu/rFLr6h7ri7bKeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vLDHDp8AM2SOvZJBZBSwK/1lnx+uB4jJvmaL6gra04=;
 b=os7kNf2FboPAXlB63f06IY8ejueWmklvgyTmHEOlI8JZAz5cBSa35BJprldjMRsTMzhZdQCyfmWc3nTCaPo+ToBq+oLWBZM3nvKWkIm59/vo56kCJwVxT8DsFScyXolk7yhnAvOazrWJmIf2ebZRLjyrC+EPVkd+se+pX6ZQElgsGe47kG4FV6Qrb/ZHct5bv3CedUtym6Ts4LcLujUglIjmrt4fp3unzHHRbuAdFswkT+dqI27iRVSKR5SsA0lFvT9xVlKku1d4UqJuQaghD9VOGw+nhumnFIeL3Yf+HtZS3EVcIz2OZBuVw4TRQBtw95NGQJMlMZwImMBJ/zsPJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 13:38:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 13:38:44 +0000
Message-ID: <3e686e84-1c6c-4c0e-aaee-b056a672e78c@siemens.com>
Date: Fri, 1 Sep 2023 15:38:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 xenomai@lists.linux.dev
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
 <61984786-9ecc-4605-bc07-70827584d3bc@siemens.com>
In-Reply-To: <61984786-9ecc-4605-bc07-70827584d3bc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 171eaf96-424f-4c27-91c2-08dbaaf0c2bd
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 OMh900JAz79Jn898I0lS1NKXpQ9bHa9vi/I5jTAfwQ0HLLPyJLZsEavbVcgvFNRWyl36VW4qEfeQoFZPBLve0IR0VJLV7yPFQGcmNQ+2X0xAKowkHWmBgAcBORqflmSVIwiAlgPe6KWKegc2StuntoD1DVW1Ti938Hw8Y7/UUcQjsSGbC/WBhul7aL3sxZ8Df36wSWZ4JOc6A2zaIKtGmjsrFO3c6SgzlkXh7CnNftVzceCkZNGYdE9KhYZRQqXHCH8j9wcnMrSR1wAwIwM1G/xNEOk2DoFbqNdU8oumX0eWdymcbljEYlRBmuwYWcJVDBWCRiU7mnlSZ3xjWLjZT58pYYzbAId6FPYZW4LXNSKaIGVEa+fg+CdblnVIE1iRQjBWTwVMp81LVOQ12JBodmedjZnjPvj5ZiDcpWHRbWsDYC9v7c/bIDXvJdPBiwpJHDtXFPHaEJAyF6EVOLSokDJBcFbxvad4rF/UsMpSeZ5QIIHl8jjsO8HaBkku9fWWRGin2vJyv4SjfzuOkm1pzKm80bKCuh8QKA8WtQcbkZd0bSkx0m7ySOvvbBuVgonA1b0D6c+zKJywhHsWgESjsWD54ix1uyG3hznKk+WQqsPyIblpoTeiXNNIoOT8Md6u3fVQ27zn8q2Ng+/1yn+CSg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(38100700002)(66946007)(66556008)(82960400001)(66476007)(316002)(2906002)(478600001)(41300700001)(86362001)(31696002)(5660300002)(8936002)(8676002)(53546011)(83380400001)(44832011)(6512007)(26005)(6486002)(6506007)(36756003)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WTdpTCt4SDNDcEVIRk1KUU04ZjE3aFlkVjdqQ0hCMTJjOTVLc2pxNUlXL2do?=
 =?utf-8?B?YmxrYjRqRXdzWGFtdFBrM0ZGUjFEaE93SUFZMTVyY2N2Ylp3c2VzWXpQZDJl?=
 =?utf-8?B?c3ZITjhJZGxLUWQwenRCQ1dZNmUxaU55cjFuM0MzZUR1RVNjVGNydFhGS0Jh?=
 =?utf-8?B?QnRyc3RKd3JVc2hQdFpiUndMbHJ5WFdtMUlOZkJ3TVpaTXFsTVpYajVkREhQ?=
 =?utf-8?B?QzhtMkZuRURMMzExcXBQdFlwNXdVVFY5cnpsb3ZTRkpaaHBJSVFLQXFrY0Ux?=
 =?utf-8?B?SnFXdXMzRGw5a3hEOGZORU41dUdzNWNtMWkyY1JuUFdTZXJ3ckZNUHFIYTkw?=
 =?utf-8?B?em85VlJNMDZ6b0xRMHRvbVdtRkNjVGpvNlAvUmY3dDZwOUJrbWVWSTBaajVL?=
 =?utf-8?B?dm1RUHgwT0FXN09RTUtqNXY2NTRudWgwL1gxMUVwRHZRNmJHL01vM2MrQU90?=
 =?utf-8?B?S2RXZ2JTTldFMDhRTWRLK2dTazQ1SG9oSmFYdVEyZ0RlSzZKWDdYbTFaeWNm?=
 =?utf-8?B?RktOaDFCZUFFRUJGU1FjamlXU2dReEdRbVB4dHFPWW1yVG12L1QvL2tVUE0w?=
 =?utf-8?B?eGFxcFVsS3gzK1JmRUdVTzFKSk9FMEFZT2NwbmxCaVVDa0pPRXpQdTdNcVY0?=
 =?utf-8?B?dllyN05zZk5paU9TNDRFQ3pDSUtXZTNpTUxrK2RMdWo0dFdzd3RNdW5VV21S?=
 =?utf-8?B?UUMxWnJTWldrbjI1dFpMaFE4MzZia2RMT1VJZUQvK1RkSjJSTXE3R3lMSmZn?=
 =?utf-8?B?d2M1SGw3am9RYlZlS3MzeHA5NTFxMWZ0OUpQUnErN0NQdlIyT2V0T3N0bzFo?=
 =?utf-8?B?ZE1IQzMvVlFyczFsVTJtK1Y3MnVvOVZZcmJaSTRxNDh5RFlWb2NERU1CaEJx?=
 =?utf-8?B?S3krVTVCRmhObmovdzhmMktrWFdSaFkybis2SFBFM2d3dkdqaGxjTHVzaGlM?=
 =?utf-8?B?ZmpnYlZSL2cwUmFKT2M1YmQzZTFnd2JzWXA2RllCMDRDbFQxRWl5WHFlV3pK?=
 =?utf-8?B?R2dkWnVCU1ZxWmkvdG1aaWlRVW9FQWRWMDFpRmFEUkVaZG1ZeDBzcDR1Z1BV?=
 =?utf-8?B?bCtSSDAyczNiTkRCd21weE5jSng5cnV2SVZVSFJ0R3lKTlJrVTN2K2JlSSt2?=
 =?utf-8?B?WUVMQzgrUUZFQ3pTQ3BJSnp5ZmttT09vS21JNjNoRUl0ZUpuWjFxN1BibG5E?=
 =?utf-8?B?aFY2a2pwRTFiUzZUUmh0WjZTVWxDTlIwMXNoV082cG1DeFNjSzFSMmJlRm9J?=
 =?utf-8?B?Tmc2VzN0OVg1em1hWGVvVDVwRHhvVllwTWxhYVh1Z0poUzJQc1BzekpNSjRt?=
 =?utf-8?B?c1dFR2FERkw4YkNqN09Qb2pXVUZORGI2MjJSK25XblU3bWZVc0Y2WC81K1ZL?=
 =?utf-8?B?TzQwQjRkUHVJc3craG43VGxvOGo1RG5XNUdUaCtuQk52ZXdmOEZIT2pIL3JC?=
 =?utf-8?B?SUlza09FeThIY0d0WjFMS3ZaMzJ4cm1RWlFFbTNKcVpXYTlyRkpBMFpMVFJo?=
 =?utf-8?B?R1VOdTZseGpwK05KS1BtVDNiQWlGU1dOSlRUbjBDcXloNDUreFY3ZzIyYzBq?=
 =?utf-8?B?VmJpV080dHlZRHZkeUJtMWgwMHNVTzA4U0NMRnVObUdLS3pKbXBKbHpGMDVN?=
 =?utf-8?B?ZXYwaFJ1TGdvMCtmTlRtc0d0ejRvQUpzQVltT3YzRUg2b0tFS0FZNEZnMXdD?=
 =?utf-8?B?ZEVSV1NOMlMwaXoraHRMR0g5S0xqeVBVRmg3d0M3djhhZnpaeU9idzhBTGRt?=
 =?utf-8?B?cHgwaUFpVzNhcmoxTTF2T3lTT3dIMXU5SnBOeWozSjRsR3NjOEFUTEdLV09i?=
 =?utf-8?B?a1lmeWJheUkxeHJCMkd0UmtsU2x2SWRGTFpCTzZVZjUrRnBhYi96aXRJeVZo?=
 =?utf-8?B?S3JPVC91UTFPWHNhcXRxQ2MwZkVvR0dFZ3pyMnNiTUNUU3ZDa2ZLd1lFS29r?=
 =?utf-8?B?Rjg2SW9zYlpENXFHbDdFK1RXeEVLNVVVOHoxZnlnUVB0MllqRDIwWEdmWUN0?=
 =?utf-8?B?QmlRSjJUNSs4Y3RKaklwd2dmUFp5TGVWV2d3blNtY05yL1g0MlZxOEZkOXBQ?=
 =?utf-8?B?MWFOMGtQUEVTK1E1RlBjWG0wMTd5QWpKNzIzMWloSEdKekZFVElMUy84dk5s?=
 =?utf-8?B?bnpQZzAwNnNFQWhlZ08yNnpXTUFaa09vWlJtT0g2Q3NrR2RRc0kxM3puQ2VT?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171eaf96-424f-4c27-91c2-08dbaaf0c2bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 13:38:44.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I33IR3mHUTqtwJ7RP/5xqVTA7Qk2aopGDoFsN8P5jc2Mc2KfB0AEm/L0xFnNb+aAPhz7TuwmK6w6diiQDUpEGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6331

On 01.09.23 14:00, Jan Kiszka wrote:
> On 16.08.23 12:18, Johannes Kirchmair wrote:
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
>>  include/cobalt/uapi/signal.h                  |  1 +
>>  include/cobalt/uapi/syscall.h                 |  6 ++
>>  kernel/cobalt/arch/x86/Makefile               |  2 +-
>>  .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
>>  kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
>>  kernel/cobalt/arch/x86/signal_ia64.c          | 37 +++++++++
>>  kernel/cobalt/dovetail/kevents.c              |  5 ++
>>  kernel/cobalt/posix/process.c                 |  3 +-
>>  kernel/cobalt/posix/syscall.c                 | 28 +++++++
>>  kernel/cobalt/posix/syscall32.c               | 16 ++++
>>  kernel/cobalt/thread.c                        | 39 ++++++++++
>>  lib/cobalt/arch/x86/Makefile.am               |  2 +-
>>  lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++
>>  lib/cobalt/internal.h                         |  2 +
>>  lib/cobalt/signal.c                           | 13 ++++
>>  18 files changed, 282 insertions(+), 3 deletions(-)
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
>> @@ -574,6 +574,8 @@ static inline void xnthread_propagate_schedparam(struct xnthread *curr)
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
>> diff --git a/include/cobalt/uapi/signal.h b/include/cobalt/uapi/signal.h
>> index 8a7ea15a4..1afb6050a 100644
>> --- a/include/cobalt/uapi/signal.h
>> +++ b/include/cobalt/uapi/signal.h
>> @@ -68,6 +68,7 @@
>>  #define SIGDEBUG_RESCNT_IMBALANCE	7
>>  #define SIGDEBUG_LOCK_BREAK		8
>>  #define SIGDEBUG_MUTEX_SLEEP		9
>> +#define SIGDEBUG_SIGRESTOR		10
>>  
>>  #define COBALT_DELAYMAX			2147483647U
>>  
>> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
>> index 3e65efaab..f14bd8ffe 100644
>> --- a/include/cobalt/uapi/syscall.h
>> +++ b/include/cobalt/uapi/syscall.h
>> @@ -142,6 +142,12 @@
>>  #define sc_cobalt_timerfd_gettime64		119
>>  #define sc_cobalt_pselect64			120
>>  
>> +/*
>> + * Sigmatek specific syscalls
>> + */
>> +#define sc_cobalt_sigreturn			121
>> +#define sc_cobalt_sigaction			122
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
>> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> index 745c32467..4d004680b 100644
>> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
>> @@ -28,5 +28,18 @@
>>  #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
>>  					 ((__nr) == X86_TRAP_DB || (__nr) == X86_TRAP_BP))
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
>> diff --git a/kernel/cobalt/arch/x86/signal_ia32.c b/kernel/cobalt/arch/x86/signal_ia32.c
>> new file mode 100644
>> index 000000000..140016460
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
> 
> Why is this function in file that suggests to handle only 32-bit? It's 
> shared by both 32 and 64 bit.
> 
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

I've also added this:

	case 14:
		*sig = SIGSEGV;
		info->si_signo = *sig;
		info->si_errno = errcode;
		info->si_code = 0;
		info->si_addr = 0;
		return 0;

That fixes the related test case.

As you can see, we can neither provide an accurate fault address nor a
proper code because those information are lost along the dovetail
notification path or do not even exist by that time. The address could
probably be forwarded by extending dovetail, the code likely not.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

