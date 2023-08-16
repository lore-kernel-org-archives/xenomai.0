Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32715FC17
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 11:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee/A35VdJbhvKHOpA6yN69D1lZySASz3/t0Q7LIuMoB0QBuBkrYwgIEH/pPJpKrQSxzWoUOQSLeGcyxaVwFefioRSXHcc5DAx8w+9UgcIi7uDoNl1k8e/3V7kirw4quvr2AcGE9i0csMyMVYCN2YVhp9Cl34vyCGd2jaV2z3f2E00D6vgLhT/qZei6v3+dO7ysq0noigqWne9qjoQMTGKw1R/9R27ah4qYkqIRlLc+pgJrmWOCUyGLHtX0/flOsAuZqEFQNSWIccy+nZwdX5dgP38C2NQszfWxXGYMKijZShEHKwRgwEnA6kCB+gB5EHsrIWC6KPZEbbrlag9abnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVTdrxEEhKg5CDMDOHHA2OW6Xn+OhLc9sris3KYMNPM=;
 b=BeNaBt1aBIbzGiQSkjEh85YlXvYMAagJJOxYfWx3z4S3YaEJPAHYpJTbbclkqQ18SK/d6BT84TG+rPSdaMoZktkpjpAqrfypeYkdwv1SIkgQDZDc+quGxfkmAPqQH7OPPuDmNQTQqXoP4Yiohyh5VhKPaYhdW7moQiuN5TTr2sDJs8drIUgkzq4YL4Jx8P5ZOwyhcOfW7k1cmFVn0n/sT+Cu5gMRr3vwiAQ/uNzwwM63DKRDQ8xVfrjlQO3RLnhMXyN+8kb3VbL7tOR8abwSXRphAkMxKtx+fjYNQsF0Ux51n33y4BJs7IJDD8UanWY6DTtedh9tOW7/0lTrn5Bbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVTdrxEEhKg5CDMDOHHA2OW6Xn+OhLc9sris3KYMNPM=;
 b=L2STjZmZksGlNM/D3kixT+A7KD9dMYnWIkGfXzrBK0MrROKpEY0La7jAozdHX9r+Qazb5SB2P3/yvZq2j5ZhybwkctJTTU2Nh0aWQpOqltOXOYeh1YKyMe8i/SkBBEppAQkPu2RcIVHlcuOmB4vO/FnPLZax04juxLgY7Oqst8cs1yxOUFo+8Ulg5wty1drrjidriCuZo4QA6UE7IHj0Lm9MKNAVlM4xOaJHOhhDc6aiB/V3LmSSnCKVI609roqPPUsQNlQV2qwUE2cfrKbQfMUZDGzKKhkifa+2B6viPsk1cC7SDul1TF45DxYBVnMGOvvTYhoA5KNWJSgfPBls0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 11:36:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 11:36:23 +0000
Message-ID: <f9a67d86-8cd0-44a9-b39b-fdbdaa8931be@siemens.com>
Date: Wed, 16 Aug 2023 13:36:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, xenomai@lists.linux.dev
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
 <d5e43ccdceba5f28de7798c0826318e1bbcfc1d4.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <d5e43ccdceba5f28de7798c0826318e1bbcfc1d4.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 061fdba9-6b21-4c18-31b8-08db9e4d04ae
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 /VHBmAYNkc0Wbmt7Rox2NiYrIJ2Nw9YPWesX8ZkS7q4t1IS/sX3IlS1yTEufEeiiKMGsETUXAIOi4vKN6g5j3N5iJWFAUe0YYaYT48cdg2ZEZu1VPAogGIE4pbxqOXB25RzDNERqN1oZQmbOCaTGR+aztgz5moXYME+VGuPwVEsZ1/QQehuM2bAaMmxEZ76oifpVcsNz93S56q/x1vr6Lzgxr2C0HAuv3C07V1X3Hw5+SfnZsvUKLmLXb5YzjClktErvvXVwNg6NAIPv7ab8XnwngdjWkEtjwKaxkCyHPbYHUQ2uRMnTyRC9SIJGkZSqj9jkg8GanOpKbBh3gLISRVWRp5cI8LZ+TIV0WDloi69IFbd4lNciDkMu65dPbDeyWPsvdADwoG75MiPUJXQAO3VDgtk3IVtTIPkZ3q2xetVNbtAzTEJGmrUnj/XzGyZCvCvRft0pWE6hNRyEzX7w8C6uOyl0rz33sna4nB+rurQh4SWauW7mqtA1s1pDp04MCcBquOYyJiws5jGrCgvGkvzsgJZDKk5EMneHrmHnHOpKj+VnWs92/CslCM4QDoj1Mdnvf/K1dUxfg+s3ZViz3iTqtlFy/dkjw8DG7Rz+ivEWczSX07RSxk9FV9qb6VleVkaQznJYp2mFYViuUjMJ5Q==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(8936002)(82960400001)(30864003)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZzdwSDJvbGxrVzROSkpUQjFPYmFvV3JiYUszRkZ2VnpIRm9KY2QzcXptU25J?=
 =?utf-8?B?UVdRNERCR3YvbVcyRG9aZ2pWcUJFK1NJYVZQYS9LVnY4ZjdzaHN5UGl4Q1Yr?=
 =?utf-8?B?RUtPVzN1eWxyTzNMbUVHNjl3MUU2NnNsWk9nMkdMb1pCYmdrWG1xVWgrS2t0?=
 =?utf-8?B?WVRKM3l1c255dlowZW5sVHBuanJrYWlZQ0dGRFJzTlBQa0pRZ01qSTJ0SHVG?=
 =?utf-8?B?cWdWeis5ZGoyU1ZodldLcmpyUnIzVExERjBsdVBSVmt0dmVPaTJTczAycXJU?=
 =?utf-8?B?c2lTSnpDUW1YM0NXckFuL3BwOVNuekFUWWRiejdRcUtNcTA5amVIZXpMVHJH?=
 =?utf-8?B?NTluUEdoaENLWDVzTnhmWlpJVkpnSWtqeWJSejNrSXNvOEVES045ZnpYUTYv?=
 =?utf-8?B?bS92ZWVJdUNEUTYxckNpM3JlM3hoejNCY0xLenBENlRlMjRFWFB4Nm5KOWRw?=
 =?utf-8?B?RHpsbk9URzR5NFlNVVBnVWVKa0pGczRPYUdhVTV4NGVBY1VVS2RzK0NDaGNm?=
 =?utf-8?B?c09KeHd6UHVWbkNzSTJhUTNqL3I0YzcySFZ0dVNpaStxdHo0LzBDWlVhWXl4?=
 =?utf-8?B?Uzcza1k1YndmM29mSlowRFlvT0FxU1BKQ0cva3R3ZHU5ZjlMTFhTRjRTNXR6?=
 =?utf-8?B?cTlmUUZNeGw3SmN2c01SWmY1UUFLOTB2dkIramR2L0NuNGsyaWNmWEpmNXlR?=
 =?utf-8?B?Vlk2NFJMZ0lQMnVZR1JTUks2RSswQnlsSTVXYm93ZXdLNTM5K1hJN1BpSlBu?=
 =?utf-8?B?Mk1Oa3FERkk0VmtmMi82alVmZHBsRXczNWc3S1FBaDZzdzg4dmFjOEZLZHlD?=
 =?utf-8?B?TFNLM1Awa2tnWm5wNTBrS2dNbGV1aTlqblF2Q2FSSDFvNS9vZWFvN3hvdWNN?=
 =?utf-8?B?dnJRc2tOcnhROHZSSzN4SU5PV3dnUVBoUmU2Z2R6cUV5azRFM2xKYnVuWlEv?=
 =?utf-8?B?VTlWMUxCR2lBdGhzMFhCWENPNUxINzUxbVJpa3ArUDZlK0Y5OTdCKy91N3kr?=
 =?utf-8?B?TXgxbU9LZGIrUjgrbnY0cStwUFpTeGtJNGFic1l6dnFvS2JIY01heFpJNUpJ?=
 =?utf-8?B?T3RIWVE5WXlXRHRYcm41R2NZcDNvUVFXRHRJQkVpK3gvZjJhSWszdHUrRnRi?=
 =?utf-8?B?SWplZmFEWTkwUDFEeTlHSXFBV2c3NjllY0dKRmQxcWRFRGZLNTF3SVJuTUV2?=
 =?utf-8?B?dU42UU00WnhOdWxSUnI4dHgva3Zzc2JMdnRIYnJHalpoTFkrUEgxaGU2WmRZ?=
 =?utf-8?B?UUNBOUFsTGtNeXpEL3BHV0dDLzR6NllKdjNWMERNMDVkU3diODY4REpvbkRP?=
 =?utf-8?B?bzMzVHpUOGd0RzZncGNYQW5uN25TVmdIZHJRMUZrUlBmbmlDS1oxK2M5OGFP?=
 =?utf-8?B?bndMeXpWbFFPL3IyVVh2V1hNVkNCV1NDYWV1YWJOK0kvbWRkTll1SDZ1WWNq?=
 =?utf-8?B?anlvZmNaVHhTTGFHeWphL2ZiWXhwZ0k3V3dxSDhOL1ZOcndDeU5SM3NydEEv?=
 =?utf-8?B?R3FReU9hV3BiMnBpSVdsTSs5aXhqTDJwZ05VeGI2Ly9jR0ZDSUFTYzdQeHZt?=
 =?utf-8?B?bEZoa1ZzL2VYT0VWR2xUT2QweG42LytiL1BXU2tVM2YzT1BQbHIxenhiK1ll?=
 =?utf-8?B?cDJxV0xpT3lQZTJNQXYwcTFIbWV3aG9Rd0kwb1JwVHJOS1FHWjZzaWthcVJk?=
 =?utf-8?B?UnpmZng5Wm5zd3k2M0NIaVVpS3Ywb3U4c1NyV1RHdTZYK3BGcVE5UGc1NWRD?=
 =?utf-8?B?WHhvRVlBSVVydHlBd1NvZVRlTG1FQ3VDdmFxSTNhYytFbk00QmpWcDVKQ0ZZ?=
 =?utf-8?B?TXE4WG4ySWFQV1hvRzhoVDhZTlZMcHl4ZFBEbytuaXhUeDNnUEt4TGFCeEtQ?=
 =?utf-8?B?YjNqQUNBdVlVcmZIK3NGb1VnZnFvYXhPQ01QT0NWdXlzcWxwaWptS1l1bTV1?=
 =?utf-8?B?YkNuVTdaekZEVmloQmlYdTBOekFpNW9DejhCS295WW13aVFYUEMrSXJkREdD?=
 =?utf-8?B?V0tpeGpnS1krZE1xcTN3VENVYXg0Q3JFVUtLcmRoTEpBNkVZdmlpekFic0wy?=
 =?utf-8?B?eWs3Q2pDem5ENTFuZkV3TTBicUp0OWxEQndaZ2VtZld2QXpaK2xlN1FtRFRo?=
 =?utf-8?B?UEFVcTZRTEh1NEhXN3VXaGI5Vk5zak9FcjRrcGUrTUFxUFpTQjRFSnNIeS9u?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061fdba9-6b21-4c18-31b8-08db9e4d04ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:36:23.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8bW2ZO8WZ+a1OMymBFGdWswZe7eobRJcRDG41A3JiFkgl2TDX6qwgj3GVOSs2YajZmDh78al9Bngiv2hrmjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8058

On 16.08.23 13:24, Florian Bezdeka wrote:
> On Wed, 2023-08-16 at 12:18 +0200, Johannes Kirchmair wrote:
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
> 
> The goal would be to become generic so no longer 
> "sigmatek specific" ;-)
> 
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
>> +{
>> +	switch (vector) {
>> +	case 0: /* divide_error */
> 
> Can't we assign names to the possible values of vector? Can't we model
> that as enum?
> 

arch/x86/include/asm/trapnr.h ;)

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
>> +	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
>> +	return -1;
>> +}
>> +
>> diff --git a/kernel/cobalt/arch/x86/signal_ia64.c b/kernel/cobalt/arch/x86/signal_ia64.c
>> new file mode 100644
>> index 000000000..3b8cd3330
>> --- /dev/null
>> +++ b/kernel/cobalt/arch/x86/signal_ia64.c
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 1991, 1992  Linus Torvalds
>> + *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
>> + *
>> + *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
>> + *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
>> + *  2000-2002   x86-64 support by Andi Kleen
>> + */
> 
> I think the copyright information is just wrong.
> 

Agreed I don't spot significant kernel code below.

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
>> +	int ret;
>> +
>> +	ret = dovetail_restore_rt_signal_frame(regs);
>> +	if (ret < 0)
>> +		goto badframe;
>> +
>> +	return regs->ax;
>> +
>> +badframe:
>> +	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
>> +	return -1;
>> +
>> +}
>> +
>> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
>> index 4da4f51b7..61417717b 100644
>> --- a/kernel/cobalt/dovetail/kevents.c
>> +++ b/kernel/cobalt/dovetail/kevents.c
>> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>>  		xnsched_run();
>>  	}
>>  
>> +	if (xnthread_handle_rt_signals(trapnr, regs) == 0)
>> +		return;
>> +
>>  	/*
>>  	 * If we experienced a trap on behalf of a shadow thread
>>  	 * running in primary mode, move it to the Linux domain,
>> @@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
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
>> @@ -738,9 +738,10 @@ void cobalt_unregister_debugged_thread(struct xnthread *thread)
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
> 
> No error if sys_ppd->sighand[sig] or sys_ppd->sigrestorer is
> overwritten? 
> Or the other way around: Why can only the handler be overwritten?

I think the idea behind this user-provided handler is to replace the
vdso approach of the kernel - which we can't use as-is because we have a
different sigreturn syscall. So, the first call from userspace sets this
handler for the whole process. But there might be better ways than this,
maybe something done during cobalt binding?

This syscall interface is not yet done in any case. It's missing the old
handler parameter e.g.

> 
>> +
>> +	return 0;
>> +}
>> +
>>  static void stringify_feature_set(unsigned long fset, char *buf, int size)
>>  {
>>  	unsigned long feature;
>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>> index 780d276b1..7c858f904 100644
>> --- a/kernel/cobalt/posix/syscall32.c
>> +++ b/kernel/cobalt/posix/syscall32.c
>> @@ -705,6 +705,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
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
> 
> You did not touch the syscall32-table.h (x86 specific), so I would
> expect that your compat support is broken right now. You should end up
> in the "native" so x86_64 implementation. That brings me to the next
> question:
> 
> Can't we avoid a special compat case here? The pointers themselfs are
> corrected by the syscall entry machinery but the memory pointed to is
> not. So is the memory pointed to by handler and restorer different in
> terms of memory layout/padding?

Yes, no new compats, please.

> 
> In addition you should update kernel/cobalt/trace/cobalt-posix.h to get
> proper trace support.
> 
> 
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
> 
> Style: Reverse christmas tree.
> 
>> +
>> +	code = xnarch_fault_code(regs);
>> +	ret = xnarch_setup_trap_info(vector, regs, code, &sig, &si);
>> +	if (ret || sig == 0)
>> +		return 1;
> 
> Why not:
> 
> 	if (ret)
> 		return ret;
> 
> 	if (sig == 0)
> 		return -EINVAL;
> 
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
> 
> Applies here and on more locations: Why returning 1 instead of
> reporting the underlying issue (return ret;) ?
> 
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
>> index 000000000..df961469e
>> --- /dev/null
>> +++ b/lib/cobalt/arch/x86/sigreturn.c
>> @@ -0,0 +1,36 @@
>> +#include <cobalt/uapi/syscall.h>
>> +#include "internal.h"
>> +
>> +extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribute__ ((visibility ("hidden")));
>> +
>> +#define TO_STR(x) #x
>> +
>> +#ifdef __x86_64__
>> +#define build_restorer(syscall_bit, syscall)                                   \
>> +	asm(".text\n"                                                          \
>> +	    "    .align 16\n"                                                  \
>> +	    "__cobalt_sigreturn:\n"                                            \
>> +	    "    movq $ " TO_STR(syscall_bit) ", %rax\n"                       \
>> +	    "    orq $ " TO_STR(syscall) ", %rax\n"                            \
>> +	    "    syscall")
>> +#endif
>> +
>> +#ifdef __i386__
>> +#define build_restorer(syscall_bit, syscall)                                   \
>> +	asm(".text\n"                                                          \
>> +	    "    .align 16\n"                                                  \
>> +	    "__cobalt_sigreturn:\n"                                            \
>> +	    "    movl $ " TO_STR(syscall_bit) ", %eax\n"                       \
>> +	    "    orl $ " TO_STR(syscall) ", %eax\n"                            \
>> +	    "    int  $0x80")
>> +#endif
>> +
>> +/*
>> + * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
>> + */
>> +build_restorer(__COBALT_SYSCALL_BIT, sc_cobalt_sigreturn);
> 
> This looks like a partial bypass to the XENOMAI_SYSCALL() machinery. In
> case we wan't to change the implementation of that interface (targeting
> prctl usage) we would have to touch the rt signal interface as well...

I wonder why this has to be written in assembly, in fact. Can't we
implement a C trampoline that issues cobalt's sigreturn with normal
means? That function would not take any parameters and will never
return, thus should not need a special assembly entry IMHO. Plus, we
would have it for all archs then.

> 
>> +
>> +void *cobalt_get_restorer(void)
>> +{
>> +	return &cobalt_sigreturn;
>> +}
>> diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
>> index acb3989f1..4782d154a 100644
>> --- a/lib/cobalt/internal.h
>> +++ b/lib/cobalt/internal.h
>> @@ -132,4 +132,6 @@ static inline bool cobalt_features_available(unsigned int feat_mask)
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
>> @@ -126,3 +126,16 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, const union sigval value))
>>  
>>  	return 0;
>>  }
>> +
>> +int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
>> +{
>> +	int ret;
>> +
>> +	ret = XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler, cobalt_get_restorer());
>> +	if (ret) {
>> +		errno = -ret;
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> -- 
>> 2.25.1
>>
> 

Jan

-- 
Siemens AG, Technology
Linux Expert Center

