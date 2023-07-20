Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4D2FA20
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 16:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtXzwMAslt9NVT8RxZqv2ps5h9JEyVaey0/RUbCGD7vLb66ar/KUZmMUYppevXrpfp2Ryp3TAvot3EBcysS4fzwNwwXK/ymWL1kjSoMl/U32JtoFBauzhPYsGRlSky/LGv/9iLoNd4wSkplA0QISnB0vM+/Hn6Aro2e+34HpwkuyC/tS7H2KCSuKAjNZ1tvyfgppRPN7QjREl6ux/ZVOLuAuwD+ZZC+cpUJcJHXxAg/1denRp9hSCQnT86zgkQTLLLNh4dSx1Mbhegsp9fPeXqid5P+V8hxejTIBRi9gJ44UUOIWsLMEBhA6MsxY9IQlI70KsgAex0Nce3dVa7XuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PAI0tVvN3HKe7rngNxdcmJY3udYT4bdApxSybrJsB8=;
 b=D9cDeE8O4UOVxKAsculKurga44ojkcGdmvoC5kevmlzVc5PrGMKHjY7/+bnpgTArzEcfFDKPYa1ASRpT7uTqRp0A0OWmVZccK0+fBoTGdn2kvo5Nj9QGLm5zs/3kCH8b0uWLitWKPRFlqdsGVRY8jB9gNwyFzTeDcg/tTSelkRF0ngYMWPIlhlComMCfs/a+LLUephgSN+6+CF8CfGcXQZn7NFcAun42t5wx2dCo9DbHw+hWlvEnv4ef2lAl8KfL9r5Mt7V0yMubnwaMKb9T0sGgfv0VkbGVHdC0gOGYdFOpl1Py9EJRnA6FyvFxuoQvTzxCvZOlcu6cjdhqYpM4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PAI0tVvN3HKe7rngNxdcmJY3udYT4bdApxSybrJsB8=;
 b=UpOgbVcfmngOSurJ4/tb3T6yS9VZVklyQjEv0/novyDVG7syxceHjcreeo8W2YVvX2PeWm/ou7hO2hv9m3t9bDUIpOPIQNgHqbEumYs8ZG9gyLLpzQtnUH53BntwBOAKpwsjElhScX9F08i3e27sPD1jI6QESDE5a5LIw/+VC3+Mx7IwQ/upLEXrv8EB4J1A9sjYnMNdN03g5hUJEE5KxjDpX5mHeQk9blOuCK2nessEmxCZVf4zR6pTq3Q3jlF8NJP7Ck26Y9OzYLDaZAslpe3MXuIycv/t+4z1t0beYBBbCVr1G4RGYn+1XTAbmPDyJ4tQ3J9E4UL/zxnplt3LGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 16:36:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 16:36:25 +0000
Message-ID: <f0114278-3dc2-7faf-9b2f-fec6dcfbb4a8@siemens.com>
Date: Thu, 20 Jul 2023 18:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] y2038: cobalt/uapi: Migrate struct sched_param_ex
 to time64_t
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d39433-79c3-488f-0f74-08db893f755e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EtU+OzCz6Taq0GfwXuwHW8jCkLsg+8OqNs3mjuPFTVwrQo9QiA2ROj+dsfR6d303nmJFtCd8TPil30GtmBHjTMdhECKBeaTNt7BQidnREcn6wT/LoRIlw8BjKtby2A6dEdHXhaeLH9OEryaHhYmctPqUZ4Whh01pUJfq7YdFNLNAUadDsZwJxO1BgD9AakmtZcs9/Gr8BjmwM85W90ZOoD5ZSYI5ZnRyyx9WzHrAq8HA1E5j3TyO+q7HfogcQGU8buJvcapwnMq9vdAavbKgJRA59dLZjwi3RPW4l0qMcGr/+FPr6VyFN5MpvEcx/kJkAMd2ehyJXDQpgswogJPtiU6adrGdVEAvXJyv1ZZumlFZSEIsa26cTjh/6NadRYj9taCJLoIxUnFAdF7cfYqMm11+RoQ/umfY66pjGLFOQCpohrBrJs1gscnfbghu6eDsPdKnKapDJyyytlqaRAX97LermVlfgWSeNDz6r2288XHn2VoJzgox/kjO2yNuH6ZNMI/UY6xhJHAfeMtYZPQaWyNXNKW6PiK0BnUSNdjXl5Hw40M3SeZ8NDYpiFjOAorD6i5HIKob1wGRqX1iOyTWotv5HLtkaU+UPE62p4IgJcA2zk0rEAcoMkJCZa7TU23/OAeoCQqFdRr8S/8KS/EPyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(2906002)(83380400001)(2616005)(86362001)(36756003)(31696002)(82960400001)(38100700002)(316002)(66946007)(66556008)(66476007)(26005)(186003)(53546011)(6506007)(41300700001)(31686004)(478600001)(6666004)(6512007)(6486002)(8936002)(44832011)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWZaNlFDY1JsT1kyaXNWMnRDek5oVzc0R05uL3pKNVZRaWZlYkRlREFSdGsw?=
 =?utf-8?B?R1VMMExGdUtpUjlMV0o2U3kvQm9Mc1VuTEJEc09wZElVTHBleG03VHFocDNQ?=
 =?utf-8?B?cnpzMVdTaEp3bytiaDN2TlNhbU5mT1loZE5ZSzdRVDdyQkpGK1Q2cmJHSDM4?=
 =?utf-8?B?eGNSWmlud1BqN2dJVzRjek5JVkRVeEhFb2p1RE1GSm9MQVFMOUt3OG1OUXo3?=
 =?utf-8?B?S3dWWXNZNlgrQlphbTRJeXQvZnJWQndDenVWSTZ2dW1YcmF0ajFHQTZxVlJG?=
 =?utf-8?B?RmVpeU45NFFtUW1zR0xMMGhWaS9zdHBNK1dtRmlWOVo5bjBmZVlyN3FOSU40?=
 =?utf-8?B?b0lLQ2ViZTQyNkdsZTAwbWdnY3hkOGpNNEwrL2YyS0xtNmRrMWQvTjBHYnBS?=
 =?utf-8?B?U0ZJdEhVMmI0Wm43QzdSMGhrYytDV1JDSXRjWnZnOTJtZGdZNWw2QnFNUUhG?=
 =?utf-8?B?L1RnNE9BR3Ewa0ZjYzZTSUpkQnM2VGVBVWlFQkJlT2RDa1NWRlpNVGFTUWxH?=
 =?utf-8?B?clRzY1BjekdWNG1QcDZPbmFwN0YyZDZSbHlBYWNkczlpeVBXemFPNUl0VFFP?=
 =?utf-8?B?NHlLUGUzRG1ibm9MQkk1VEpSVFhJY0U0dnFYdHhLZ1RyRWt3VkxoK1plU3JX?=
 =?utf-8?B?cmt1NS91NERaclVwb0ZOR28ybEZFS0NpRnArMnpORHBIOVFvaU50RTNlOFI3?=
 =?utf-8?B?Szh2bCtIN01WVng1UGlPYXp2LzM4NW5mckhmMmxxNjhHcWVGU3RJaVhTakRl?=
 =?utf-8?B?eUU0MFlhRmNzU2VBNmMwaVhFWlBEaHZ4eGFOQjBlN0F4bDNrNjd6NFArT202?=
 =?utf-8?B?THZnL2VEUlE1SWEvT2tYWGc4SXh5eWpKWXQyV3ZRYXNnWGtDTnBwdWo1ZFpT?=
 =?utf-8?B?cnI2d3ZkN2ZFd2VaWUxrOHFZMUd2WFdDWVVqZnAvNngrR1NVWDJ1dkFLNTB3?=
 =?utf-8?B?TDBxRlN2QTlEK1RYbDlXL0dVTGF3SGo0UE5BUSswemtWVjRmeTlUa2EvR01v?=
 =?utf-8?B?WnNKdTQyUlpONzZJSFAzQWkrRDNNSHV3VGZsaldJZGhIZk5YblBLNE1sY2xv?=
 =?utf-8?B?dlplenZqcDNxSFNkdXNNdHRieEtRWEhFOERQRDdscXlFcHI0WmMzVm8zUEhN?=
 =?utf-8?B?eW91ZVpQZzNKc3A3TmtYbVRXWWwvUWVDMFIvMUgvWFF3aEFiL1Zka3V6OUwz?=
 =?utf-8?B?TE5YQTYwaGNKc25LbTN1bHphZ0JkVytCbGV4eW9mZGF4Sk5VTWRQZFk1QkhK?=
 =?utf-8?B?S3NaYUFpWkw1NC81YThjYlhSTmRLODhadi9NazdjYnhaZHRneWdyU2tvMEQr?=
 =?utf-8?B?R1pZZGx0SlB4T2s1NW43QjZPeFRnUFJiWllKVUZNT3R4aEpyWDRjdU5GWk5v?=
 =?utf-8?B?VU8xZU9qbVFDWTZOTU9uWTBLM25zeDE2a1d1LzBrdGt0Ry9oSHVNd1NrRStt?=
 =?utf-8?B?SXE1VFFHY0oxNmxSUUlPNDNkN0J4Y0xOb3Zmc0NKT3dOeCtod1Q0SDJaaktM?=
 =?utf-8?B?QlNIM3NHTzZNekxWSVRwcW1LTzg5SHVCN0lPcnRQWTM2amFOUHgxdk5UYWZG?=
 =?utf-8?B?Y1dXQkRtVVVvdGJzWEN1ckxWeTFYejBJdEtrSndOUkhSQkZMZEpEQ3Y1Tity?=
 =?utf-8?B?MUVvL1Z0RU1PZ2I0eHF6NXREeDN4Q25OYmUzVkJVd1FOd2xqbnc1aDR3UGl2?=
 =?utf-8?B?RkZYakJmZGpVWWhwOHUwQmloYVptZlZ3ME5VV0dOUUJ5L2NGWkxIRnRoLzNX?=
 =?utf-8?B?ZEFZUkZWZWc4eXg1eGo4c0VrVTFnMmlTZjVrL3B0NmVhTkJGYjNaSHVsUi9q?=
 =?utf-8?B?NHBaeHZ5RytTR0N3K1pZZTRud1pISTh5YlF6UHNXODBZUXNJNTF4SEl2d3VC?=
 =?utf-8?B?eTdnNmM5WEI4NkRiankzL1Z5emV4aGMxZnNOUGdjODFKTGlaLzR6SWlOdWMx?=
 =?utf-8?B?MFMzVk14N1hTcUlrZlRjSU9YTXk5cDdkYVQyaXZCTThLazZjSE83YXg4RC9L?=
 =?utf-8?B?UnZuTVhFOWpRWC9RMnBwYU1YbW9lckdSZk16ekVGK1E5S3g4emlVSGFZZjZE?=
 =?utf-8?B?MEZZRi9SZUR3YkZONVgyM1BYL1dWUGluWkdoQVNCT0RyREVsbmFPS0RmZmNw?=
 =?utf-8?B?aURjSHREb2R1ZlFoS2JvY1dQd3hXL0ZkYVZWb2NhSzFZS2w3T3MxSTNJU2cr?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d39433-79c3-488f-0f74-08db893f755e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:36:25.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrNzT2mCqvQf90muKXYkMFTJUowbJzo7hkO2Ybj+SCDnHagvk/AQD6/McejisRrxI8vfMC2P0YFI9wCgF+uqfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8266

On 17.07.23 11:10, Florian Bezdeka wrote:
> Instead of implementing time64_t based cobalt services for the
> following services we simply break the ABI and make it time64_t aware.
> 
> Affected cobalt services:
>   - cobalt_thread_create
>   - cobalt_thread_setschedparam_ex
>   - cobalt_thread_getschedparam_ex
>   - cobalt_sched_setconfig_np
>   - cobalt_sched_getconfig_np
>   - cobalt_sched_setscheduler_ex
>   - cobalt_sched_getscheduler_ex
> 
> XENOMAI_ABI_REV is incremented on all supported plattforms to express
> the ABI breakage.
> 
> The memory alignment of some data structures is changed by adding
> some anonymous paddings. This allows us to remove some compat specific
> services afterwards. The memory layout is identical on all platforms
> now.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/uapi/kernel/types.h                       |  5 +++++
>  include/cobalt/uapi/sched.h                              | 14 +++++++++-----
>  .../cobalt/arch/arm/include/asm/xenomai/uapi/features.h  |  2 +-
>  .../arch/arm64/include/asm/xenomai/uapi/features.h       |  2 +-
>  .../cobalt/arch/x86/include/asm/xenomai/uapi/features.h  |  2 +-
>  kernel/cobalt/posix/clock.h                              | 16 ++++++++++------
>  kernel/cobalt/posix/sched.c                              | 16 ++++++++--------
>  kernel/cobalt/posix/thread.c                             |  8 ++++----
>  8 files changed, 39 insertions(+), 26 deletions(-)
> 
> diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
> index 2c931c29c..495c94506 100644
> --- a/include/cobalt/uapi/kernel/types.h
> +++ b/include/cobalt/uapi/kernel/types.h
> @@ -57,6 +57,11 @@ static inline xnhandle_t xnhandle_get_id(xnhandle_t handle)
>  	return handle & ~XN_HANDLE_TRANSIENT_MASK;
>  }
>  
> +struct xn_ts64 {
> +	__u64 tv_sec;
> +	__u64 tv_nsec;
> +};
> +
>  /*
>   * Our representation of time specs at the kernel<->user interface
>   * boundary at the moment, until we have fully transitioned to a
> diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
> index 14095870f..6b1639feb 100644
> --- a/include/cobalt/uapi/sched.h
> +++ b/include/cobalt/uapi/sched.h
> @@ -33,15 +33,17 @@
>  
>  struct __sched_ss_param {
>  	int __sched_low_priority;
> -	struct __user_old_timespec __sched_repl_period;
> -	struct __user_old_timespec __sched_init_budget;
> +	int: 32;
> +	struct xn_ts64 __sched_repl_period;
> +	struct xn_ts64 __sched_init_budget;
>  	int __sched_max_repl;
> +	int: 32;
>  };
>  
>  #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
>  
>  struct __sched_rr_param {
> -	struct __user_old_timespec __sched_rr_quantum;
> +	struct xn_ts64 __sched_rr_quantum;
>  };
>  
>  #ifndef SCHED_TP
> @@ -54,9 +56,10 @@ struct __sched_tp_param {
>  };
>  
>  struct sched_tp_window {
> -	struct __user_old_timespec offset;
> -	struct __user_old_timespec duration;
> +	struct xn_ts64 offset;
> +	struct xn_ts64 duration;
>  	int ptid;
> +	int: 32;
>  };
>  
>  enum {
> @@ -122,6 +125,7 @@ struct __sched_config_quota {
>  
>  struct sched_param_ex {
>  	int sched_priority;
> +	int: 32;

Having these two lines back-to-back looks strange: Why do we specify 32
bits explicitly for the padding, why don't we have to specify that for
the sched_priority, and why don't we use the __u32/__s32 types here?
Same applies to the other structs touched.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

