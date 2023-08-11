Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803C5692
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 14:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKh9OTG50ZJWc0N5Ard1nhjVqS4KwrNLEdqN8PBWz0Zg/d9yPj73FZfjd0PI39Zfmrr6KVLgXOffdm66wQNfJxGxWKoaSp3yQi0sKxUNfGGGRBXYrNSKojgij4pW1igPH+lnZnAfL6GwMOcSvskCQd+tZt8b/Q2H8w2KG3tAJXs15PIuNjGYzwzyVONIjHTxwVCesUnmHKRG8M1g288tHfZPsLRpZnGL+xUOxKfGik8ileS/N4ZlEOOufujdho06uH6l+nE+c3shiZUGC1jAdeR6EJPnHEgKuv/dnbpalQQkKI/PU5zs1PJOQPRl4PjYHMPl1rV0P9/F0x+s/8mgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKWqILTfmeXleDPQUtrprs5rgx//q4wPyydedk3b5xY=;
 b=amP+r9a0ROnJm7oeNnOtT3u+XCCiBsMPQpmsfigSLl2shfCPIyJT1JhpNcJek0xGSh1w/dZN9gx2bKTJEPMaI8BBRLxRj1qTPeHUnyvf4OuCYM8/JI+C64am0Ilv/s/k/cCP9+kje98i8ONdoPSihcyv3ItIqA+HHwdxpbQbAK/hcTkhjv338Kn9VfawvRtK7toz1rUde4Ygy0PmsHxWBjL/lhlF+TmGjghzpdiBv+KIh17PYtYfAVDeSC4O3+9Gd1ivwXg5/Iw+dJZYnkdAUJU/5rRK5YUeRsvk8C7WKCmbtFQUUJ1o+VLgY7xKuHKBS5EsGipTkFn5hCdQSkX5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKWqILTfmeXleDPQUtrprs5rgx//q4wPyydedk3b5xY=;
 b=oIm1ms9V6VDQna6TfLiaWgjzFTLSd9uBt4cPaIIAdvMysXAEmVnnS8N+mhJ7ckq50q5WJpX7nKFo0i/ao82LtUT69/cVOQBPzdW0JkLKORfvHFvOqr9881UgRhBNyT71gKm/7oGm+yy15fxjp5b1/ordIKz1L6YmtNplnshjpU7h++mNNnZmosBFxJRd3eGtA8sHv220onoHIXPpcJlsPbpXCe7XoCC9dGV3u4MIX/wwd0xs8zNRAH2mRgAGj3Q6yilHoDVpQMVJzsiBgUeSTDzhRkblfYNUnirWqIPko791thxEfF114fqURGbRve7wUpTud8V3DKEFGqcujYsqEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7651.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 14:57:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 14:57:50 +0000
Message-ID: <b7230826-40be-4b00-9a10-ed5c8aab487c@siemens.com>
Date: Fri, 11 Aug 2023 16:57:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] y2038: Route explicitly requested stdlib calls to
 time64 equivalents
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
 <20230809-florian-y2038-2-v1-6-d1cfe2f394a3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v1-6-d1cfe2f394a3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 996359f7-aaca-43ab-ceca-08db9a7b554f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qe8rYQFqWBYwTtHmPrrHu1KA8tXvhozbZzRhncHHaaz1Em4tPQnXtgqRGcxvQxQH7of2/4qlkFgGDLVinbcnnjq37j3NqLZHyVlj5SiIO+NYmXpx8CeiTeHfVWRR58KNYgELB7OKTmBrns18ceC/9ULAlrUkgCwGrF58RMMyI7ubpFxd+5vpb3nJP+C1Oj5uIZCO59/bCJSIrQh8XeAe8kHtkn7bRXKru6iTwtQP9TU4on+96yjriwAo8SxW0dsed3r3AGI6eCNwC6DDWEPaE5/dCzQT3dyY09qWS5EiaT/g7GjuR8O3BzPDNao5wCIhFWbHMmft++kS4FjqPapYcnXcqWlGiRahkc4fE8UXO1yVS61LSV1hME0C1tQ9gGip22s50p9S5u1B0AH+XmnHUpslDKfC1FSOfnOAzY22hAd4/PX346GnrMLobEVIFdOLF5u2oCOR4XqgRQeWJPkw/VcAi3JVICBip9DGPjgKer2NTFRPne0OsPnMNDDD1vHpqcMhLTnPCeyjSuH2RNaUoUuWM+k0h/ryQAEeOfSKOhfXbgGiz8Eo115h6hXeN4aq/QBujlrk3iY+fPbBxdVeapQGtOyrrIECzlksa74PkjvI2e4XwzaUcky3ehokoSzxlFZnSuyiNDAMh6Sx/8gogw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(186006)(451199021)(1800799006)(31686004)(5660300002)(478600001)(6506007)(44832011)(26005)(8676002)(8936002)(53546011)(2616005)(41300700001)(83380400001)(2906002)(6486002)(31696002)(86362001)(38100700002)(66556008)(66476007)(66946007)(82960400001)(36756003)(30864003)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW5KekpGUXlNdlFVUmZRY05CN0NkZWwvUnRveS9KSG01OGVicE9vZjI2R0dQ?=
 =?utf-8?B?ZDNPRS9TU3lKbXRFVlpjOU1ZWHYvRURSZFUwdG9pYXRJclJGZHNraGwyWGM5?=
 =?utf-8?B?elVRZjFtb2czTXdDOXh5Y1BRZ0R4MmtBOTZoR1A0MmR6QnFGRUF4MTh1S3Rp?=
 =?utf-8?B?K2NCRk4vMXZ5Zk1IdDF2M0FPdjdFbjBTKy9OeXhZQU01OCt2TmNPblo1eXAw?=
 =?utf-8?B?NUpqM3h4YllYd1BtRndxMFJpZzA2MHVRZzM3V09rNjBxQWwzdzAyRHFSRGY5?=
 =?utf-8?B?ekN3TjVKSkxXeXM5QlRvUXJacmFTaTJsbUJDZW00cmZ5QVNBTDhtTzZuN0dG?=
 =?utf-8?B?UFNCTGlHdXhGU3M3cHhDMDNvK2dJYjFJNkxCeks1a05wbWpFRWlLd21FY3VQ?=
 =?utf-8?B?R2Q4Vjd6Qi9rdGIzMWVtMHVVdHVnNzdOa0JGRWhsTGErRFlBUXg4SG5KNjRU?=
 =?utf-8?B?Vm1rSnRGVktIZkZJQ2U1U0pvSmRBVHZxQ2F4WFRPQ2JMTlQ1Nk5EcDRxNllZ?=
 =?utf-8?B?L0NMazRic3Y0dHVpdm5KNitibGh0b2VkeXNCb3pKeE5vcW9mVHQ3WjZnOWxk?=
 =?utf-8?B?UFhUQnRJdDd6emc3MGEyZjJIQ2Z1cHFKaE56eWpCYzZmQjlyOTljcDc4di82?=
 =?utf-8?B?YmI0c0FWcU1iQzNUZGZmRVBua2taNVp6SkkwYVlsUWFDU1RzSE1wT0ZGTGJH?=
 =?utf-8?B?NWk1SExodmNTc1ZrK1BsUjJmb0VLYnNPMnJyK0s3ZFloc1FwNW9IMGN3Z2or?=
 =?utf-8?B?SEVRWE5zZFpZd1RONll1ZjVheVdMdmlzeCtqYVNuMTlHUmZMc3pqSjZpdyts?=
 =?utf-8?B?bVVQemFBaDA4T1RQbUIxeG11UHhNcW9VTUV0R21TaEUrZjVTWloyVXZGeTVC?=
 =?utf-8?B?T1VIS3psU25oUldOR0dWdmNGelRlMGhUcWlHQUZEclVCQ2JZRDRSMDZRdFpU?=
 =?utf-8?B?N2hBNlJrMU04cW1RbVpnWU03K0kyRlEwTkV4TDZmUlVBSGxSQ3laSHlyTWd6?=
 =?utf-8?B?WDdhVGFqWXlIeDVzL0MrS1NnYkJ3Z21QVXl1UFZVVGxRRFZUOS9kRmtZdFZP?=
 =?utf-8?B?N0pETjZhUEtDeVlFZkZqQllBQ09Odjdhb1JLVFUzdTMwUzVjNExVQlpGQkt4?=
 =?utf-8?B?WXZaS1Z4WmRVbW9FekxsN3FwaWVvU2VCZWFXZmFsblUza1R2eGRrRGI3N0dW?=
 =?utf-8?B?cnlSQW1Xb2k2SXRJeFE3N0k5SHZpcWN5cUl4SWx6ZlMwR1E4b2h1ZlhiZTlO?=
 =?utf-8?B?Zkp2NFlzWlNXYXNnM3g4ZTI5dllOSFI1Um1LZ3Y5bEVMRnZOSDczaXNFT1ps?=
 =?utf-8?B?QXo5ZUlVM3lPM0NOTHovRHpvQVIzRTE2a2JmSit4T0daa3lyY01aUDg1WTVD?=
 =?utf-8?B?ZkN1QkY2WnBmVTZjZXVXL2RFbmg5S2gzYXVMT3duRDF0T3NRVE1veUl0SmRM?=
 =?utf-8?B?bDk4Q1ZnUW1RbnNVRmVpbmpSY1IydXVxMG1sYzNCVDRTQmpxN3B1SU9WbEgz?=
 =?utf-8?B?Zi9NZXN6ZFJ6UURDTFJsb3BiQlVXYkxmcjVTS1Y0QWMwQXRyQzJEWHRPWHFW?=
 =?utf-8?B?Nit4L2NDbVBVaEQxWVprVnltNmZ1UHJjR1IyZUdLdzQzaUxZMTFicURaRzBY?=
 =?utf-8?B?MUM4Nm1KVGRYT0V4bHBORVlZM0V5dktSbVBlK0huTWhZRmpSK2R4alhBaXBn?=
 =?utf-8?B?K2wxeUNNTmtBaks4eTNISVRCL1VMMk5zdnNwaGQ4eUlldXN3RUFXZkg5cFN4?=
 =?utf-8?B?Z3VVZldPOUIvVlJpdlZiaElqM0hsSUZzYmdMUW1GWnRySGQvY3NlTjFCbnRM?=
 =?utf-8?B?c3FPUkZmVEI2OGJjSk1SQW11ZzhDUnBIYWUvYVJIUzdRaGppTWhMU2pPN0w2?=
 =?utf-8?B?RXlDekVDdnA2dTRYNTlYUTQzblFvTlovYUtsVnFzeVROYzUycEo4VHY4TzRu?=
 =?utf-8?B?eC92c25XU2U3M01MQXhoaDkzc3R0dzVHSDdzaDJUcEpRK0RZMlY1b211ejVF?=
 =?utf-8?B?VzREbFB4YlFkZjhQSFBNV0hIbXlzcUFnNVZ6QXRlMkJ3Uk9lampCd05Ub3VK?=
 =?utf-8?B?aEgyVk9wQVVMNTBQanVZbUJjeGVhRnVUV1lWcnMzTFhXdEgvWXRhR0lKcWFP?=
 =?utf-8?B?K2tRM1BLZVo3L1k1dk9CUDluN29DV0pCZXhtYzlRdVdMd2s3TE0xR1o1Qktv?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996359f7-aaca-43ab-ceca-08db9a7b554f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:57:50.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qa9G2e1mm+joY3gYBvZwq3CDlabHFmQXvib8GKiDRpHK1uoKenEeQItzlzdLsA7qJLnZZC3/5f1VqgcM72YJDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7651

On 11.08.23 09:37, Florian Bezdeka wrote:
> Xenomai provides the __STD() macro to request a service from Linux.
> The code normally looks like below, taking clock_gettime() as example.
> 
> Note: Some y2038 safe services in glibc have the "_time64" suffix, while
> others only have the 64 at the end. This is taken into account while
> redirecting.
> 
>   int ret = __STD(clock_gettime(...));
> 
> For compat applications with available y2038 support in glibc the
> preprocessor will generate the following code:
> 
>   int ret = __real_clock_gettime(...);
> 
> __real_clock_gettime() is the service taking 32 bit time_t. We have to
> make sure that __real_clock_gettime() is redirected to
> __real___clock_gettime64() service. The same applies to all other
> affected services.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/mqueue.h                | 11 ++++++++
>  include/cobalt/pthread.h               | 10 ++++++++
>  include/cobalt/semaphore.h             |  4 +++
>  include/cobalt/signal.h                |  5 ++++
>  include/cobalt/sys/ioctl.h             |  3 +++
>  include/cobalt/sys/select.h            |  8 ++++++
>  include/cobalt/sys/socket.h            | 15 +++++++++++
>  include/cobalt/sys/time.h              |  4 +++
>  include/cobalt/sys/timerfd.h           |  9 +++++++
>  include/cobalt/time.h                  | 35 ++++++++++++++++++++++++++
>  include/cobalt/wrappers.h              | 10 ++++++++
>  testsuite/smokey/y2038/syscall-tests.c | 46 ++++++++++++++++++++++++++++++++++
>  12 files changed, 160 insertions(+)
> 
> diff --git a/include/cobalt/mqueue.h b/include/cobalt/mqueue.h
> index 496632dea..3da525a04 100644
> --- a/include/cobalt/mqueue.h
> +++ b/include/cobalt/mqueue.h
> @@ -67,6 +67,17 @@ COBALT_DECL(ssize_t, mq_timedreceive(mqd_t q,
>  COBALT_DECL(int, mq_notify(mqd_t q,
>  			   const struct sigevent *evp));
>  
> +COBALT_DECL_TIME64(int, mq_timedsend,
> +		   (mqd_t q, const char *buffer, size_t len, unsigned int prio,
> +		    const struct timespec *timeout),
> +		   __mq_timedsend64);
> +
> +COBALT_DECL_TIME64(int, mq_timedreceive,
> +		   (mqd_t q, char *__restrict__ buffer, size_t len,
> +		    unsigned *__restrict__ prio,
> +		    const struct timespec *__restrict__ timeout),
> +		   __mq_timedsend_time64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
> index 3e9bd4705..1caa54372 100644
> --- a/include/cobalt/pthread.h
> +++ b/include/cobalt/pthread.h
> @@ -173,6 +173,16 @@ int pthread_attr_getpersonality_ex(const pthread_attr_ex_t *attr_ex,
>  
>  int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
>  				   int personality);
> +
> +COBALT_DECL_TIME64(int, pthread_mutex_timedlock,
> +		   (pthread_mutex_t *mutex, const struct timespec *to),
> +		   __pthread_mutex_timedlock64);
> +
> +COBALT_DECL_TIME64(int, pthread_cond_timedwait,
> +		   (pthread_cond_t *cond, pthread_mutex_t *mutex,
> +		    const struct timespec *abstime),
> +		   __pthread_cond_timedwait64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/semaphore.h b/include/cobalt/semaphore.h
> index a7714fd34..20195094c 100644
> --- a/include/cobalt/semaphore.h
> +++ b/include/cobalt/semaphore.h
> @@ -58,6 +58,10 @@ int sem_init_np(sem_t *sem,
>  
>  int sem_broadcast_np(sem_t *sem);
>  
> +COBALT_DECL_TIME64(int, sem_timedwait,
> +		   (sem_t *sem, const struct timespec *abs_timeout),
> +		   __sem_timedwait64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
> index 62694f93a..9082765d0 100644
> --- a/include/cobalt/signal.h
> +++ b/include/cobalt/signal.h
> @@ -54,6 +54,11 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
>  COBALT_DECL(int, sigqueue(pid_t pid, int sig,
>  			  const union sigval value));
>  
> +COBALT_DECL_TIME64(int, sigtimedwait,
> +		   (const sigset_t *set, siginfo_t *si,
> +		    const struct timespec *timeout),
> +		   __sigtimedwait64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/sys/ioctl.h b/include/cobalt/sys/ioctl.h
> index 553aa566d..d7602ddf8 100644
> --- a/include/cobalt/sys/ioctl.h
> +++ b/include/cobalt/sys/ioctl.h
> @@ -29,6 +29,9 @@ extern "C" {
>  
>  COBALT_DECL(int, ioctl(int fildes, unsigned int request, ...));
>  
> +COBALT_DECL_TIME64(int, ioctl, (int fd, unsigned int request, ...),
> +		   __ioctl_time64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/sys/select.h b/include/cobalt/sys/select.h
> index 76e8476bb..8262e7764 100644
> --- a/include/cobalt/sys/select.h
> +++ b/include/cobalt/sys/select.h
> @@ -31,6 +31,14 @@ COBALT_DECL(int, select(int __nfds, fd_set *__restrict __readfds,
>  			fd_set *__restrict __writefds,
>  			fd_set *__restrict __exceptfds,
>  			struct timeval *__restrict __timeout));
> +
> +COBALT_DECL_TIME64(int, select,
> +		   (int __nfds, fd_set *__restrict __readfds,
> +		    fd_set *__restrict __writefds,
> +		    fd_set *__restrict __exceptfds,
> +		    struct timeval *__restrict __timeout),
> +		   __select64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/sys/socket.h b/include/cobalt/sys/socket.h
> index 156b49356..d16843877 100644
> --- a/include/cobalt/sys/socket.h
> +++ b/include/cobalt/sys/socket.h
> @@ -81,6 +81,21 @@ COBALT_DECL(int, getpeername(int fd, struct sockaddr *name,
>  
>  COBALT_DECL(int, shutdown(int fd, int how));
>  
> +COBALT_DECL_TIME64(int, recvmmsg,
> +		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
> +		    unsigned int flags, struct timespec *timeout),
> +		   __recvmmsg64);
> +
> +COBALT_DECL_TIME64(int, getsockopt,
> +		   (int fd, int level, int optname, void *optval,
> +		    socklen_t *optlen),
> +		   __getsockopt64);
> +
> +COBALT_DECL_TIME64(int, setsockopt,
> +		   (int fd, int level, int optname, const void *optval,
> +		    socklen_t optlen),
> +		   __setsockopt64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/sys/time.h b/include/cobalt/sys/time.h
> index 38f5a34b6..d3bd9f1f5 100644
> --- a/include/cobalt/sys/time.h
> +++ b/include/cobalt/sys/time.h
> @@ -32,6 +32,10 @@ extern "C" {
>  COBALT_DECL(int, gettimeofday(struct timeval *tv,
>  			      struct timezone *tz));
>  
> +COBALT_DECL_TIME64(int, gettimeofday,
> +		   (struct timeval *tv, struct timezone *tz),
> +		   __gettimeofday64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/sys/timerfd.h b/include/cobalt/sys/timerfd.h
> index a7df836e6..109409cf7 100644
> --- a/include/cobalt/sys/timerfd.h
> +++ b/include/cobalt/sys/timerfd.h
> @@ -35,6 +35,15 @@ COBALT_DECL(int, timerfd_settime(int fd, int flags,
>  
>  COBALT_DECL(int, timerfd_gettime(int fd, struct itimerspec *curr_value));
>  
> +COBALT_DECL_TIME64(int, timerfd_settime,
> +		   (int fd, int flags, const struct itimerspec *new_value,
> +		    struct itimerspec *old_value),
> +		   __timerfd_settime64);
> +
> +COBALT_DECL_TIME64(int, timerfd_gettime,
> +		   (int fd, struct itimerspec *curr_value),
> +		   __timerfd_gettime64);
> +
>  #ifdef __cplusplus
>  }
>  #endif /* __cplusplus */
> diff --git a/include/cobalt/time.h b/include/cobalt/time.h
> index e3f355c61..38e43fb9e 100644
> --- a/include/cobalt/time.h
> +++ b/include/cobalt/time.h
> @@ -70,6 +70,41 @@ COBALT_DECL(int, timer_gettime(timer_t timerid,
>  
>  COBALT_DECL(int, timer_getoverrun(timer_t timerid));
>  
> +COBALT_DECL_TIME64(int, clock_gettime,
> +		   (clockid_t __clock_id, struct timespec *tp),
> +		   __clock_gettime64);
> +
> +COBALT_DECL_TIME64(int, clock_settime,
> +		   (clockid_t __clock_id, const struct timespec *tp),
> +		   __clock_settime64);
> +
> +COBALT_DECL_TIME64(int, clock_nanosleep,
> +		   (clockid_t clock_id, int flags, const struct timespec *rqtp,
> +		    struct timespec *rmtp),
> +		   __clock_nanosleep_time64);
> +
> +COBALT_DECL_TIME64(int, clock_getres, (clockid_t clock_id, struct timespec *tp),
> +		   __clock_getres64);
> +
> +COBALT_DECL_TIME64(int, clock_adjtime, (clockid_t clock_id, struct timex *tx),
> +		   __clock_adjtime64);
> +
> +COBALT_DECL_TIME64(int, timer_settime,
> +		   (timer_t timerid, int flags,
> +		    const struct itimerspec *__restrict__ value,
> +		    struct itimerspec *__restrict__ ovalue),
> +		   __timer_settime64);
> +
> +COBALT_DECL_TIME64(int, timer_gettime,
> +		   (timer_t timerid, struct itimerspec *value),
> +		   __timer_gettime64);
> +
> +COBALT_DECL_TIME64(time_t, time, (time_t *t), __time64);
> +
> +COBALT_DECL_TIME64(int, nanosleep,
> +		   (const struct timespec *rqtp, struct timespec *rmtp),
> +		   __nanosleep64);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
> index 7e061caf9..fe3132127 100644
> --- a/include/cobalt/wrappers.h
> +++ b/include/cobalt/wrappers.h
> @@ -32,6 +32,16 @@
>  	__typeof__(T) __STD(P); \
>  	__typeof__(T) __WRAP(P)
>  
> +#if __USE_TIME_BITS64
> +/*
> + * Make __STD() usable in combination with time64_t related services.
> + */
> +#define COBALT_DECL_TIME64(T, F, I, A)                                         \
> +	extern T __REDIRECT_NTH(__STD(F), I, __real_##A)
> +#else
> +#define COBALT_DECL_TIME64(T, F, I, A)
> +#endif
> +
>  /*
>   * 
>   * Each "foo" Cobalt routine shadowing a POSIX service may be
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index 0c7de5216..45508641e 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -1613,6 +1613,48 @@ out:
>  	return test_pselect64_interruption();
>  }
>  
> +static int test_function_wrapping(void)
> +{
> +#ifndef __USE_TIME_BITS64
> +	/*
> +	 * We're testing some functions here that are wrapped only for 32 bit
> +	 * applications with y2038 support enabled. If that's not the case we
> +	 * can simply bail out and simulate success.
> +	 */
> +	return 0;
> +#endif

Won't that cause warnings about unreachable code after the return? Let's
rather do an #else ... #endif here.

Jan

> +	struct timespec ts64 = { 0 };
> +	int ret;
> +
> +	/*
> +	 * If the nsec part of ts64 is still 0 it's a good indication that our
> +	 * function wrapping does not work as expected. We retry up to three
> +	 * times to avoid shaky test results.
> +	 *
> +	 * __STD(clock_gettime()) is replaced with
> +	 * __real_clock_gettime() by the preprocessor. If
> +	 * __real_clock_gettime() is not properly redirected by the use of
> +	 * COBALT_DECL_TIME64() (linker magic) we will end up in the glibc
> +	 * implementation with "native" time_t.
> +	 */
> +	for (int i = 0; i < 3; i++) {
> +		ret = smokey_check_errno(
> +			__STD(clock_gettime(CLOCK_REALTIME, &ts64)));
> +		if (ret)
> +			return ret;
> +
> +		if (ts64.tv_nsec != 0)
> +			break;
> +
> +		if (i == 2) {
> +			smokey_warning("Function wrapping seems broken.");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int check_kernel_version(void)
>  {
>  	int ret, major, minor;
> @@ -1722,5 +1764,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>  	if (ret)
>  		return ret;
>  
> +	ret = test_function_wrapping();
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
> 

-- 
Siemens AG, Technology
Linux Expert Center

