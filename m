Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2095.outbound.protection.outlook.com [40.107.22.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B19651B4
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577262; cv=fail; b=b2h80VmSDPEiuck34htCN/BFQY+h7v8YH35IYN0bw2xolfKc8viAksQNECGSxu+MbtIhhLp2ktjSWV0ASbIuchmbMW9NUnn/9hfp/2PuHUbP9i3teEa9+cxq+hKR/6Jy2QrG1kkk7w3P5S302uFBO9PyyRPC4K7LvQIbsJ4cTns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577262; c=relaxed/simple;
	bh=h/udbkfqghANFIb1/vaBcvZEroGwkOQC8EsBpM9l+cw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=knViKCQ7KLsIzANASg99A8ezMp66f6LhLEPbi8PqRRGLpMOp9h8TsDWIxACBx/9AlD0Bc1moBttkODJr0E5r2KjribzLEEyE/cEfEBbSeaOy7tsjVMnd/D5Spomc+/6UAxpIb+3UxK0w+DWQoRdYbU3eA5Yt6bHN5WItRbPt9Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=reDtRLmd; arc=fail smtp.client-ip=40.107.22.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="reDtRLmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGCFX+TKCUJIl6nPHkCETVXSVLnrlCLA694pvDyH6eLBOUcDnmcIVLEa7Z8MESa0E1KCN7gBITudFfJ4uami7sOYuX/bT3HGLg1pb9pWppmJWwGtxoXiWBKF5opftSAjZql70wVa/BOg5i+Gpoo43qZ9FeeLUVlvmXZlI+vpUiA0yxUga9/u2JHbpUSiT6Gljl067Xsg7p+/2MA63X6FZgLBJSHQigQB5mhQRNryCzBMKsf2LG88PwRq5BSANB6ApxVYMUXxQFNbEIqYyZ1t+JAFmT5W1PGnvbRN5IsBopNntwh4jGPLSJC7tDS+xlCrs/KKKbo8aKwByy+dWUGSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCKzCUYBXz/8DWE05dNSMGmqc6KyUOxMTrrq1yD8fvA=;
 b=QHXgBBHUZXRIrye93D8lgZ6IpEtsr0iI/AtgPQrx6HGNIx4lBMHGdb52w1n9TsxkrJDQvXQAjOkf3DUp6jPSl+Ciq8r6Xj8wKkhfUDougopMSLOhg3K+Dg54mzzScGarsFmopzj7qyosmNiYzGnskEW0gjnmSp5qO2iejy8EL7c0du5RE8+KwomX2VESU93c/2AxK2lOZ8vUt6/DSjAEtlK3B+cywoGWVaNIaU25dTS92buoYYYrtmvF3gwtWJ0b6CYoALp9+ivLtT8xw4AXGzqM2jHxYWRm4Pb5a8XKzCE2+DPo1jI/RZr+/sCgVHuI3dOd20b2FZJ0XdeGuZqokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCKzCUYBXz/8DWE05dNSMGmqc6KyUOxMTrrq1yD8fvA=;
 b=reDtRLmdgZqPCDpJQuPMZVzU1izWyB6DOOzezfkOLZzlBq3V2Bke2G+7XvU3io4DVY7HwD9pEeju46TE997T+6MLELR675TAwBMpgfn4os9V6NBv05LnuV8b6uEjnL11QH4VSJBQhy+x6b/7RGJ2o6k7Lhvgt6aUylHcITe0W/KlEAKNd6fgpm3K5NXmRJF9Lpu2tU6NrUkufWm2KWEG+x5uyeHfwj4+nclY+aJS9nw1M8Le2mUd2cuA+JQ0Lg6DBFLsj7o3D/Q8JSLUlmkvB7TrBt+KsAgyeelmpW2pjGZqdaPeRZYAIs+rRTwXlfjpBqmXxNODER9L75M8izPY8w==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6539.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 11:54:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 11:54:14 +0000
Message-ID: <91a15d69-ea68-49a9-8daf-d52ae31f6d49@siemens.com>
Date: Mon, 8 Apr 2024 13:54:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240326102934.15109-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240326102934.15109-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oA483i0BfoBhC0MhqesssSaDE9C1iPj3U+AgxLs5YYlwCcFwkA6HqpKVQKYAN3+pPg5R/FhN4aL6BIK1eIfYvWbxAN4PaV25jpMn3KrgnVUQI4u4WHfHkX3uAt2YYvEEwMJfELB46QX6SSPQuexhHvSlzrET+dQ+/YCmvKmiYbklSdSgPPVDOWktnuSFGdvOnAWaGuhqIpKNGAY8ga6LjnjTGLdGKaILlvMgU9DOXgbtMPGSam1ECRyy4Ad8zp/hSEFDnifUhLoZfGiDRAkoz59REO6MCQKqPTqrzTDJDLYSekk46qPhbTaKiCmwTAmc2Jr7P2vNR5kAP05+1B84jhNVAN19oe3+pof6Ga3JE/vXfQicQDlSP+IwhhB6BD+cTYEJauFyedI85DJIjWLqIE7cCtH0Du6iv1wLdq5g7Cpztt9cENw2n7fIATLnNB3gXDNoZfto5jJ3hH4HhKbZ9eAQyGXT1iRB+V7f8ENtg+TdHse36h04/hNLb0jEcvZAkjtmk9EEngWhIc/4rmi9YBp4ofMl5OFdZGSq0cktxHuHBVlq0Ykl/IrYL/nPxcuwPnul88QUVBI+LtOjztwdqzMqqRBKnUFgT4fBo8arKTO8PVTbkePpg0cuc80vYrnuOAGNyuiS6e6Ordpd9WyFq7efEVNJ0Kt+8MI9T6qD0XI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3hsNnUxQm9lYUZrOUczejRRNy9aRWJnUHY3NDV2RlJtS0JCWS9FaFU2YlVQ?=
 =?utf-8?B?Yi9tUWJDN3AreEhLWmdqWis3YUg4dlM0aTZGM3NreC8xajVsMm93MFdIVUgw?=
 =?utf-8?B?Wnd1VWhPZ3pXRVNmb0xRdnpHQnhIcmF0d2IxdndFVkxBeHJmTm5qd2lLcW93?=
 =?utf-8?B?bUJTdEF6U0pUbUFva3V3R0pBNlJaYXVJejFTU1VMMm9WZjJZbmFHNlVxclRD?=
 =?utf-8?B?NlFrQ3VJdHBRcDltOHBXTGxRQkRxbG5UaXpZRCtDTHF3dnA3Y1AyRitxS1Rj?=
 =?utf-8?B?UENwYnNyblFDTFVhclk2RkhObzlzOVlNdnpqNWd2a0xVQlI0eG9oUkhhNlBn?=
 =?utf-8?B?dEZKR0tXZWU0N3lIQ1EzRDRoZUFBY2JnNDUxNWhIem9obTRlSzZLUE9PWFVw?=
 =?utf-8?B?NGJlVHFEU3dQNlgxeEFBRDBoY0NFbllQZmlSMjAyU2lnbzR2OUhkNzkxdUtz?=
 =?utf-8?B?cGYzSFpScmFFc0I1ZkpvYjFvMFRZOUwxZ2dQNkhXbHR2MTI1cVlFUWRXTlQy?=
 =?utf-8?B?MWlFU3NlSU5kUzhmNFVobGMyOGVFYWVEV0gxd1hzUCtmdUNnRW5VcXFnck1Z?=
 =?utf-8?B?WTA3QUh4cC9aTFlSVUlGSlF4NVJGWmJCNXhXQ0QzUVRhNlBZbEs1eVI2WVBC?=
 =?utf-8?B?WEhyWVgxcUJpSjNDaWx0RGZiWW9FWVhwZEk0S2NpZ1ZZN2NzUmJVTURPSmo0?=
 =?utf-8?B?cjlzRG1velJCM0swOThIVFRLM2ZkS2pOYzZyYWR3NjNIRUVDN1NjbGVaYjVo?=
 =?utf-8?B?Z0JDYmpUSy9aS2FNRjB1aGJVaytjdHJuV2pyckZGL0RZeFAyZ3lKaDRuWTd6?=
 =?utf-8?B?d1pIWk4zaVhOUDNFNmZ3cTRFSzEvbWhFREZ6VGRLbEkwekw0OGZ6eU85dElT?=
 =?utf-8?B?ZVpGUlZ1MVh0TDVtRGVwZnFSKzNKTXBoaWl2Q2FPZ21jdG5xL0NFalJ1TW5T?=
 =?utf-8?B?a0J0RGVhenZtQURNOVVrMkcvZGJhSGUxeHgwZElYY3g5VEk4OWJub0ozZUFR?=
 =?utf-8?B?VnBjUWJXWnJRVUJ4SHdOV3dFL2xES0lxS3dmYlFxY3R5U1k5ZWxPLzJYOGl1?=
 =?utf-8?B?NDF4Q0xZT0NWNllFVUlrSW84WVhLTS9jTS83UTdienhybXZUZ24rUEhBV21i?=
 =?utf-8?B?SXlFYTZmcnFob0JvYS9NQ3o0cnFGejJ6M1hhRFF6N1g1S05Mc0ZCTTFjeHhm?=
 =?utf-8?B?bXJTOGJzT011VWVhTFpSaDJVN3A2SjRhRkRxdStKVUxaUlpwTFQwZDlIbklq?=
 =?utf-8?B?TUtZRE9EZENSazE3Z083S3NodjR2Y3JmM1NsVndKbVhocTdjNmNNUlVDNFNB?=
 =?utf-8?B?ZzVuMkczMDdhWXQ3WHFJalRyb3psSlB4NjBOQzdTQ3lrRmVqNWc5aUIyTnFC?=
 =?utf-8?B?bEdKOGgzQ2ZITkgrL2Z4emVCSVdFdi8vbFM3NmRvWjBFTWNGMDQyTURaNHBQ?=
 =?utf-8?B?WHl4R1pVYUFONGN4SkM2YWFTOEErOGR3R2s2akZ4SWhGSVhjbTR4d05IWkxr?=
 =?utf-8?B?eTVRVG8ybldVWWplRjFpWENKSlB2VlV4RTZzMDgySDhSYURDcTFUM1NSWE8r?=
 =?utf-8?B?am5DV1kydTJIUWRmdVVwVnFJUkg4MnhGY1JtTUFPNHRKcHd6ZXpxMmZLRlFI?=
 =?utf-8?B?UE5YNVQ5QTc5MWllekQyZ1IxSytJUmhKOThJUDJhNUFsZ0JLZGZLMlU4MWE2?=
 =?utf-8?B?cGZaOGcvTjRLS2Z1YW9TWS9ZWitlRjRTSHptWDZwa3NJZVVOK2FRdnd6SWlP?=
 =?utf-8?B?TXU3cHFXVnBWNStIakJGOENxRFdSR3lhYXl5TllPZkdMWGxhWW5ieGFEc0ZC?=
 =?utf-8?B?c3BLYlZnSWRGd3hDY0NZbklzdWFoR0lZbTJ1NXlsU0VsNkZUUFNsa2dBdUI0?=
 =?utf-8?B?SGYxRHA2K3RidWlOaE5kVGZGUkMvQURqSWI4Rm9wZjhjSnU0OW1kWXI4R2pJ?=
 =?utf-8?B?cUdJaisvbGxuZmlUOStvVTY0MnE4QUNPV1NIZmVJWUdrajZIclNNeXVkK2JT?=
 =?utf-8?B?bWlMLzNaWm5sMmsyUGN6T1kzMVQ5dTA2TkNXNnNFSFNleVJDMEw0QXJxeEp6?=
 =?utf-8?B?Mnc2NVNvY2diNlRCbmlLS0dUT0s0NmcwRHpBcDk5dnV4Yk96Q1Z5Tmw4cUpG?=
 =?utf-8?B?UjlSdFBWTXVOWWxQcEl2UzRmUk9qa21lZ0ZmZkI4ZXA0UE12R0VXeHN5dDV6?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29233a3b-a56f-4902-1e44-08dc57c29cd6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 11:54:14.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa7rPe2sNZE91CMQ40G+k3GRw1a1DO3fKtsSdz0zoenJRyxVH9DFkQ72p+lzKlmfZu+P0klXy/fl/V8ZrmWluA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6539

On 26.03.24 11:29, Richard Weinberger wrote:
> Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
> implementation.
> POSIX requires that pthread_mutex_lock() and pthread_mutex_timedlocks shall
> not return EINTR, this requirement breaks rt_task_unblock() if a RT_TASK
> blocks on a RT_MUTEX.
> 
> To restore the functionality provide a new flag to __pthread_mutex_lock()
> and __pthread_mutex_timedlock()
> It can get interrupted and will return EINTR to the caller.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  include/cobalt/pthread.h |  5 +++++
>  lib/alchemy/mutex.c      |  8 ++++++++
>  lib/cobalt/mutex.c       | 31 ++++++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
> index 1a8991f5c..4c0680053 100644
> --- a/include/cobalt/pthread.h
> +++ b/include/cobalt/pthread.h
> @@ -170,6 +170,11 @@ int pthread_attr_getpersonality_ex(const pthread_attr_ex_t *attr_ex,
>  
>  int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
>  				   int personality);
> +
> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex);
> +
> +int pthread_mutex_timedlock_eintr_np(pthread_mutex_t *mutex, const struct timespec *to);
> +

It's getting even longer, but pthread_[timed]mutex_lock_interruptible_np
seems more readable to me.

>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
> index 9681e124e..27b936ac5 100644
> --- a/lib/alchemy/mutex.c
> +++ b/lib/alchemy/mutex.c
> @@ -327,7 +327,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>  
>  	/* Slow path. */
>  	if (abs_timeout == NULL) {
> +#ifdef CONFIG_XENO_MERCURY
>  		ret = -__RT(pthread_mutex_lock(&mcb->lock));
> +#else
> +		ret = -pthread_mutex_lock_eintr_np(&mcb->lock);
> +#endif
>  		goto done;
>  	}
>  
> @@ -338,7 +342,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>  	 * the user timeout into something POSIX understands.
>  	 */
>  	clockobj_convert_clocks(&alchemy_clock, abs_timeout, CLOCK_REALTIME, &ts);
> +#ifdef CONFIG_XENO_MERCURY
>  	ret = -__RT(pthread_mutex_timedlock(&mcb->lock, &ts));
> +#else
> +	ret = -pthread_mutex_timedlock_eintr_np(&mcb->lock, &ts);
> +#endif
>  done:
>  	switch (ret) {
>  	case -ENOTRECOVERABLE:
> diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
> index c77d10684..3cd975a3f 100644
> --- a/lib/cobalt/mutex.c
> +++ b/lib/cobalt/mutex.c
> @@ -314,7 +314,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
>   *
>   * @apitags{xthread-only, switch-primary}
>   */
> -COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
> +static int __pthread_mutex_lock(pthread_mutex_t *mutex, bool want_eintr)
>  {
>  	struct cobalt_mutex_shadow *_mutex =
>  		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
> @@ -373,7 +373,7 @@ slow_path:
>  
>  	do
>  		ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
> -	while (ret == -EINTR);
> +	while (ret == -EINTR && !want_eintr);
>  
>  	if (ret == 0)
>  		_mutex->lockcnt = 1;
> @@ -392,6 +392,16 @@ protect:
>  	goto fast_path;
>  }
>  
> +COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
> +{
> +	return __pthread_mutex_lock(mutex, false);
> +}

Can't we loop over EINTR here? Then we don't need that extra parameter
for the inner mutex_lock. Requires a careful check that the prologue can
actually be re-executed without side-effects.

> +
> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex)
> +{
> +	return __pthread_mutex_lock(mutex, true);
> +}
> +
>  /**
>   * Attempt, during a bounded time, to lock a mutex.
>   *
> @@ -423,8 +433,8 @@ protect:
>   *
>   * @apitags{xthread-only, switch-primary}
>   */
> -COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
> -		   (pthread_mutex_t *mutex, const struct timespec *to))
> +static int __pthread_mutex_timedlock(pthread_mutex_t *mutex, const struct timespec *to,
> +				     bool want_eintr)
>  {
>  	struct cobalt_mutex_shadow *_mutex =
>  		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
> @@ -484,7 +494,7 @@ slow_path:
>  #else
>  		ret = XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock, _mutex, to);
>  #endif
> -	} while (ret == -EINTR);
> +	} while (ret == -EINTR && !want_eintr);
>  
>  	if (ret == 0)
>  		_mutex->lockcnt = 1;
> @@ -502,6 +512,17 @@ protect:
>  	goto fast_path;
>  }
>  
> +COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
> +		   (pthread_mutex_t *mutex, const struct timespec *to))
> +{
> +	return __pthread_mutex_timedlock(mutex, to, false);
> +}
> +
> +int pthread_mutex_timedlock_eintr_np(pthread_mutex_t *mutex, const struct timespec *to)
> +{
> +	return __pthread_mutex_timedlock(mutex, to, true);
> +}
> +
>  /**
>   * Attempt to lock a mutex.
>   *

Jan

-- 
Siemens AG, Technology
Linux Expert Center

