Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00B2414A
	for <xenomai@lists.linux.dev>; Fri, 12 May 2023 16:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm0snXfRR2wDqYADuskvmUXyG8Yixu8vqqktUNHBWz87zrxZacq0RKD8yLMab9rhp4MSUTH0RXT3PlyTP3blD3Mv5wOOV7M4cIiLnBKVLHlivzXf5kLdq9saH1fsuPWvmE8xNXaIW8qtLyHo0yKQTm+AvCil02R88zKX2yl/8c4/5Q4PSQroQPPWAFXVrf1XzWsFNm+XW1/jfvr1JO+I7U4IAfib4AQxB1Gz2EOO23d9xgfpo47AcZtvkaw1DE7z3/aPTxIc9hxtymVPzSbmtsnZVUkQNgZ+RE8ZzeVqxDBh1kTkgZ/JJT0EDj4BNpqLPKgs/JqmnlBUcPvgrHP29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1F/bj71ECdBiV0DXEYBMYy70vVEkKrk04555xGrAwY=;
 b=KwEmnd0Vil9tuj1T2geVEjx5EG23WBl2733pcmpv+lw/H1M3EjSOeZQQ1AAlP/lKaaE3JqP71j4sXnTGFNAaYMWDKu/aF5Te1NBBhYznLsv7bHkzxiSq9GUEJsL5P4ZKHPfi9wJg+1+BrhuoIJAX37NkPEXEmHqCy3/xgMWtXy2SgK+8B2nPs7aVg3CCTXka/hYXZYoT9elp6Z5Iqf4HYmlv+Jkc5Hsq+v9uNqbUEt8hAQpRlobdKRC7nV47F97zLJhp/qn0lsH4cE8VSfz0xh9rqJqxJINgfSojCrakUkpAfUoxM4R2v0j3Eaiks8r7lD8itPLJaYnYooKfZ0NwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1F/bj71ECdBiV0DXEYBMYy70vVEkKrk04555xGrAwY=;
 b=VJg3lEubfotiILikhYuMUaqIxxuxvhCp22VKhutu6Gj/ey8qP2URgqqp2eRNiZupL28zrXzomoCBeIRCxgX0lczC5HeuzRGI9QqzoKDNLf9KXLt98uzCj0kKpqG28TiUJUzvcfcuG1eXWMXp8eanZsMdRWmKL+vtJ1Hrql7yy88/jx5Lzm52/I2o3VtQEnD5rwGLXba0YdnR6Y/oiORUdYGc4hJZS9yMyG0iYxGxpQjWs/WyFzHsaDTKFtAzPHM4RNDypseXyKznmbtwmiy7U1ixiCVyUXkDF7JZOgp8VbkviNayRbLuoiXAVHcpmq/C3EnQNoNwRT9+gKK9Banfxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:585::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 16:02:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 16:02:34 +0000
Message-ID: <a38c9123-f06e-f17c-ea83-0ca96cde7555@siemens.com>
Date: Fri, 12 May 2023 18:02:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 02/13] y2038: cobalt/posix/timer: Adding timer_settime64
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
 <20230508-florian-y2038-part-two-v1-2-a417812fba85@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-2-a417812fba85@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: cc856f58-9983-498c-d54e-08db53024c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xQtLkvkq8FjNIPS2AT0OJ8Vsioec801XupDS+Gu2HJgcVGjM9yvsFkxNLvPfTbPqhkm1nJB3G7TJ058YBTuztVdA5q4IEgVlE5RZHC5xhFs9ZKlrZi+rzxC2OECqJtnSeIXqzVR4Az0E9gLh/FbMB8RLP7hYwWEaX6fQVbGcr/9zdv4Zg2jR+H+xHDhTEqOXaFnEkIDREMtmnSECP/GdZwCGRft6nY7qrFn5cyMrhdT5nkGnuvpR41hTckQhDh0Y0x92HCdk465xedypfVbKOGw17znR2GSTvJCfBNbGYpwj6zad87NgND8JHghimgY2pznIVuAQwZyyeEkfKTi2jdwpRQ8LuW3DjiOOCs/hn+ptCLdrXXThtL/fawyjWbdH9r6EuSuMUwJK6so4OHs1L4pKlBaGPoyZPTFQwQFuuwc0SVhYBuelfuaU0cZ4qGTSLe8FORji51H6hxRpff6FoxXuS/1x6Au4yiE8XGgI9q/oFVcJ47BND9eTI2PaPVCaCccn/958hpQn0byy9Dt8/tsWmid821Y0QKa3A6APjZsVt4IaOHiXOPoUflFaBXkM/XI+hiX8ole2KHZy+gOxZTntQHLEvFv+qcdtBvCUhsKhWWml6nu/AGuFRPhD3FJBTlL6HTEt1VT4n+ytuAPKsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(31686004)(31696002)(41300700001)(316002)(6666004)(36756003)(478600001)(86362001)(66476007)(66946007)(66556008)(26005)(6512007)(83380400001)(2616005)(186003)(38100700002)(6486002)(5660300002)(53546011)(82960400001)(44832011)(8676002)(8936002)(6506007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk9HckhEbEpFaUxRcklUeVJNZ21DcDdRQmlXSGpWYy9uR3ZOVWdmd3JoZFUy?=
 =?utf-8?B?ZzFKcmFRandVZGF0YmlZYWFOeGpxMnhCM0ZIbTU0VkcyTkFyUzVzWlU5azRz?=
 =?utf-8?B?aDU1Q25Kdmo1NWJpajZKWElyRkJtUFlFOGtadmtrNy80QVN1WlVhb0tqbDNE?=
 =?utf-8?B?UWR3NUpudkJxTXI2djB4b1Z4Vm5sQXp5RUN5ejQwdTdaQ3loMjFRVTMxWHV4?=
 =?utf-8?B?ZFBtYVp3U0IybjMweEFEK0hjZG41elM3cW9hbkI1bWVLOXBGVkkwWlcxRlgy?=
 =?utf-8?B?TFVYRzltc2lJdlo2VFpTWkFlUFdWSVZnRzdkMWR0a0czMmNoYlR3Q1doZU52?=
 =?utf-8?B?YTdjZFlQVzdOWldpR015MGR2YXM4M2RGbFZGdnU0TVMrTXRaQjZmK1dlME8v?=
 =?utf-8?B?VGs5ekFaY3pXekwraHl1Y0IxbTFhNUJBL2poVjVoRUc2K0tDMDVUR1gvcVdG?=
 =?utf-8?B?SzRnd01HcFZHbmRlTlhycHFORkMzQmkzWFk2VCtUcVFVYWRNWkxVaXVnNkV3?=
 =?utf-8?B?QzhJaWVEcjgrcCt4TU5kYUFTajVmcFluM3ZvSGNlOHNTdGVQK0RKUkJCZnFL?=
 =?utf-8?B?TGg2QW5ZZnhsc1IzMyt4ZUIvb2tOTlRQRkpQajJyUEJiSEFvUnhaelpUTlJH?=
 =?utf-8?B?dlFrRURNSThQQWM5Q2RrY1M0cjRsQWUzZ3ZoYlJxN1BvQVBDZGtjOWh5Zm01?=
 =?utf-8?B?bnJwMjAydjVEeTBnbW0yVllvNE1SazJNNkFtMHo1MzhwbEVUeHNNR3FPT2N0?=
 =?utf-8?B?UmIxVjQzc04xSjlVYlU5VzR5c3BJNTN3NVM5dTcwVE1BOUZRNDcrV25FOWY0?=
 =?utf-8?B?SlptaHhPUWZ6ankwV0J2MXk2WEVmWlE1WktEcThvYWN2bVZxZlBRekJ2ZG1B?=
 =?utf-8?B?TURvY0VvMHRsc0tXSHk4QktFQ0NGSTcvSHo1a0pmOFUycHlQNzl4SHFNckcv?=
 =?utf-8?B?Wk1zYzNOQmFTN0FuK0RuZnRoeUg3eWF4VEZnZTFDUWthcXo2Vysxa3E5VnNO?=
 =?utf-8?B?dFJLaVZNUFQwbllBNjJWeEtvVWFVSzhvQmgzdXBPL3dnNlhJRE9jeENSWXVP?=
 =?utf-8?B?N0ZXcFJOWnN0cFdrNzlSZUI3WVo2S0JaNG5xdjRmVFFFRnZndUcyUVpSdnBq?=
 =?utf-8?B?bHlKaHdsMFgwWURkSEJGd01aMHJTU0R6bk9aZjJYTzNpbmtsVlZnUnRGUTJF?=
 =?utf-8?B?SHVTMVhTMWVNVWRsM00zM1Z4TGF4S0ZkaURTN2ZuZVdqcjZ2a0g3R215YXUw?=
 =?utf-8?B?bmxHbjUvYVNMcTRoUEIvSXhyNXhYaTZrOUtWbHNCc3BSVXQrblZTL1NkZ0dr?=
 =?utf-8?B?Y1ZTOGx6bDRGalZIMUgxdjlJRmplU1BoUnFITFBYSndVQjBiSlNGZDlXeTdz?=
 =?utf-8?B?RGU1SHBWRklQZlR4NU1xWVQwYnEzVGFwcVg0UUd1VEY2aUI5NjluWlU5ZXJ2?=
 =?utf-8?B?WGFyVTJhaWY2Y2t3QldiL1pCeVVqNFd6QjArUVRMcGRlamRLbDMrWXF1c1hI?=
 =?utf-8?B?NHdYbk43cGN2TU0vc3VJTDM0bjlwSG9DaFlzVVJWRXZPZEErd1dOMTFPZHhF?=
 =?utf-8?B?MEVEOEJTLy83a2t0Mk1OUmoxenBSWWhCSm1POEdPWmlYVGt3TU1VRVRXR2pB?=
 =?utf-8?B?by9HLzNJN3ZDYXM1YnBmWGpnZG1NMGc1ZjhCcllaQmRvbTcxb05nY1JoSW5J?=
 =?utf-8?B?SEFaelZvbEJmajRwWkgxYVhodDhjVDVGa3g0NWZzMWZ2UDdLM2tOS1lxSFVR?=
 =?utf-8?B?bmEwRXlWMHBwZnpoTW9LR2oxelU5ZHVtN1NjWkJrTGprbUtTYjVlbzdpWWl5?=
 =?utf-8?B?MVRxYXJNRVNCc2tjZExydjhyWUxTQlk5YjB1Y1dhOVRvU0o2OUk1VFZtQkE1?=
 =?utf-8?B?Vm1VWVdOU1p0NGxHQTM0QWVKU1FWWG0yMWR3cElOMXpmYi9PSUVUd0tCSU1W?=
 =?utf-8?B?K1ZlV290RldPa0RnZWN1emRkdkVCMUpkVkhSRUh0RU9KaU5XcS9XWlB3TGdQ?=
 =?utf-8?B?UzAwanNUanNUcmNIcnpodUtaS1I4eUNtbmFSR2hNSmNwY2NZTHU5UzhaemZl?=
 =?utf-8?B?MUN6N0FhUHcwUHdCaDJvMkdGM1EyU09nTStNUnV0VkhKSldpSkJnWDM2RVZt?=
 =?utf-8?B?Ri9BWEtCaGhqQ1B2U1hHRGJGM05ZUFFyQThxckxlTG5zL3RZcVpMbjA3VVI0?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc856f58-9983-498c-d54e-08db53024c5d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:02:34.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSp37fnPMVbu6J9NhUvXEFywCdkga5FabhcP2i988LGx+v+Kbm1TO5q3neQBTQMyhdSBrBnmX76dFEWY7Dcwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6157

On 08.05.23 10:13, Florian Bezdeka wrote:
> Add a syscall specific for timer_settime with 64bit time_t.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/uapi/syscall.h      |  1 +
>  kernel/cobalt/posix/timer.c        | 32 +++++++++++++++++++++++++++++---
>  kernel/cobalt/posix/timer.h        |  5 +++++
>  kernel/cobalt/trace/cobalt-posix.h |  3 ++-
>  4 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
> index 9646a0d97..77184bd22 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -136,6 +136,7 @@
>  #define sc_cobalt_event_wait64			113
>  #define sc_cobalt_recvmmsg64			114
>  #define sc_cobalt_cond_wait_prologue64		115
> +#define sc_cobalt_timer_settime64		116
>  
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>  
> diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
> index a115ded53..3c7579def 100644
> --- a/kernel/cobalt/posix/timer.c
> +++ b/kernel/cobalt/posix/timer.c
> @@ -16,6 +16,7 @@
>   * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>   */
>  
> +#include <cobalt/kernel/time.h>
>  #include <linux/module.h>
>  #include <linux/cred.h>
>  #include <linux/err.h>
> @@ -295,9 +296,8 @@ int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag,
>  		return 0;
>  	}
>  
> -	if ((unsigned long)value->it_value.tv_nsec >= ONE_BILLION ||
> -	    ((unsigned long)value->it_interval.tv_nsec >= ONE_BILLION &&
> -	     (value->it_value.tv_sec != 0 || value->it_value.tv_nsec != 0)))
> +	if (!timespec64_valid(&value->it_interval) ||
> +	    !timespec64_valid(&value->it_value))

Is that directly related to this patch? Or rather some cleanup?

>  		return -EINVAL;
>  
>  	start = ts2ns(&value->it_value) + 1;
> @@ -495,6 +495,32 @@ COBALT_SYSCALL(timer_settime, primary,
>  	return 0;
>  }
>  
> +COBALT_SYSCALL(timer_settime64, primary,
> +	       (timer_t tm, int flags,
> +		const struct __kernel_itimerspec __user *u_newval,
> +		struct __kernel_itimerspec __user *u_oldval))
> +{
> +	struct itimerspec64 newv, oldv, *oldvp = &oldv;
> +	int ret;
> +
> +	if (u_oldval == NULL)
> +		oldvp = NULL;
> +
> +	if (cobalt_get_itimerspec64(&newv, u_newval))
> +		return -EFAULT;
> +
> +	ret = __cobalt_timer_settime(tm, flags, &newv, oldvp);
> +	if (ret)
> +		return ret;
> +
> +	if (oldvp && cobalt_put_itimerspec64(u_oldval, oldvp)) {
> +		__cobalt_timer_settime(tm, flags, oldvp, NULL);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  COBALT_SYSCALL(timer_gettime, current,
>  	       (timer_t tm, struct __user_old_itimerspec __user *u_val))
>  {
> diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
> index 3b580d470..16d3a572a 100644
> --- a/kernel/cobalt/posix/timer.h
> +++ b/kernel/cobalt/posix/timer.h
> @@ -78,6 +78,11 @@ COBALT_SYSCALL_DECL(timer_settime,
>  		     const struct __user_old_itimerspec __user *u_newval,
>  		     struct __user_old_itimerspec __user *u_oldval));
>  
> +COBALT_SYSCALL_DECL(timer_settime64,
> +		    (timer_t tm, int flags,
> +		     const struct __kernel_itimerspec __user *u_newval,
> +		     struct __kernel_itimerspec __user *u_oldval));
> +
>  COBALT_SYSCALL_DECL(timer_gettime,
>  		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
>  
> diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
> index c7eef7fba..5f99b1162 100644
> --- a/kernel/cobalt/trace/cobalt-posix.h
> +++ b/kernel/cobalt/trace/cobalt-posix.h
> @@ -168,7 +168,8 @@
>  		__cobalt_symbolic_syscall(monitor_wait64),		\
>  		__cobalt_symbolic_syscall(event_wait64),		\
>  		__cobalt_symbolic_syscall(recvmmsg64),			\
> -		__cobalt_symbolic_syscall(cond_wait_prologue64))
> +		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
> +		__cobalt_symbolic_syscall(timer_settime64))
>  
>  DECLARE_EVENT_CLASS(cobalt_syscall_entry,
>  	TP_PROTO(unsigned int nr),
> 

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

