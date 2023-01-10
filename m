Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67191FD3
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 05:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+TMX4pZ0YcfoZjQCO+hUayh3GUL85hfsJu4H8ZLJ1e/Q/XaQn7zENmYV+T4vfSQm8aoTPXkd9BQc7EUJ06DK8vsJyz/DCy4M/xJ9I885aZkXP3nEIPAiZWWSUU6qtOa2QBfkxKtNP/Xlmrs4nWgz5jRJ63WQZxgeN3DgX/PuuEVZgMy52Y3sFWuP1cgOpTH7ry3agEDQhX+RXYr/N/28SyXFgU2Aw4xoVbxfI0yG2QNAeMjsi1tn1hQdS+yPuaRFYsL1pIGUcxeMUjlIocMP6jhXU35lgpChQVzU1i8M6qbAiPi3kfcpIeF9AULonFdbBg0jQp2y1FKeoMO6fRrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X28Ir4PcS5EkBbH4oQh3l/OvMJ+tFebWDZctSq3KQIw=;
 b=gn5HeJ9sVTNLlGrhIp22oQLsnqqOS+KsZSasF0SYJdVQpi/oGWaKn8yG7RMwkD2g6OQfNh73D/Zcxm+JhqFsKBt2JnrMfr5kBOFgDJEml1BkZdxps0BCVz8bHRS6NxDd4V0qNB8qOlmR+dBdCa1+SBNNdD80LL4uAlx9ZogUu46sTojKqej5f+qUwxvJVgMMmnXntyWUmspdb3b3TsV7D3L510W/eNzs/SL5VXcNy777Q5ZK4Be3CbylSL+sxuTjqLNgXCPIOqm/Bs+PCGS4f91Gp4VAV8f1OdeCsFT4cWzqsNKwlMcR27LTh3XODmEy3RIVgH/gHzX/cwIbSUSP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X28Ir4PcS5EkBbH4oQh3l/OvMJ+tFebWDZctSq3KQIw=;
 b=IaEYQd6U/WdcZrKY36I2skakhdKj42DaKUhmwPWdBro6x4YY7HISGxHFVh7L2KWimsXby/PTTlN/t2LSTkZyytlibNIB50UJodv8uNjh/h0cz3gii+6I3Of0sDsvH10A5jZ2q+jg/KyOHNsXHIkWF7Q5t5qLgc5ubbmgWcv2V7TExMQv0NKikooegWxkG6H8xCTzNSKI8+xWlU3PfRxqb2ZXhpIV8MNFRHcJiocSv+t/iUtlc57/FRE3Qyzny9lDbtM7CtO/oVwMWq8COkhWUsMgsf4xdvkb+lu4zc241wEzgpYpeil0ki6FobbdpdQIqA8KU786xzWLeXAsi3q++A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5527.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 05:52:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 05:52:22 +0000
Message-ID: <78c09769-8f4e-a352-5d6a-4f46f326434b@siemens.com>
Date: Tue, 10 Jan 2023 06:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at, florian.bezdeka@siemens.com
References: <20220330201614.31083-1-richard@nod.at>
 <20230109162528.26749-1-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230109162528.26749-1-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5527:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cb8129-930a-49f2-f4ec-08daf2ced762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x46swocJjZ5fRnUH3AOxwNJQW6jq8N65diq3DYpCGlvN3uXV32k9VZwBM9fb1Tma4X/r/vk9YOGgmZyDSsVy+hVc6rERHjGi5tNeC5BvB4Du+zEYwWB/qOW2J1J3RyubdDJ6hHkMWcWVnsx/caCkT5RJqUp0pCwGgcpC7gviwwhJPqzfcY24ZuFLd2kfloLjleem+cNHLRqCRYDgPwCrN13Oo9auZuATlLosVbJfwnj/186rCmnxxniEysF39P4MET/uKZDDVO0vc+5LDVDUOYV/1tdXhxpKJnA/3NOa85g+EJTv9+YMtyCijQ68/00IwhJoxJlgDOl1lQ0cavaP7bO+04ts0isWIeUbhdKnUL7gCE9CjkFySNQZipWtbSmzDePoQBfVQwkLQAm0T3L/H2zRu6JlPSETWktGz0m2x6i9H4hMorq3Y3ddbqZ2ydDM70ijfPIm/a0YhpnLxMQ5NxC8PCN3BZatpqkzHbHuY142aNS2l+/Dga7NuXX+tJIxlrMJ63gtCpmXUEYmuEjyejwKvSuG0zWxTCM2YgO66BCJ7mEPVKBXUHF40BCzEwOWqxIHv4JeaB+AnQte00QiR0EAyohG1qwEvVfmLGPrlS7r6KwpOVtX6hzSLrLzM3CMc/VWY6y3kONR/wWihAPQ+Cxp3tNQmaXrjjNK1IP7CCoiA2d4jj1iFAZc4rKSvtToNomRGlg+cNoL4yhVUZnbBpLLNlOf8iKn1SsghmONHTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(36756003)(2906002)(82960400001)(8936002)(5660300002)(44832011)(41300700001)(83380400001)(31696002)(66946007)(31686004)(86362001)(66556008)(6666004)(6506007)(107886003)(53546011)(38100700002)(186003)(66476007)(8676002)(6486002)(4326008)(26005)(316002)(478600001)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUxoWDRjVzlZQlE1bWNqRTMyWmV2anhLbWowK2p6c2g4VWQwQW9SamhaMnI5?=
 =?utf-8?B?M3NCMG9xWGRFOElnZ3ljdDdwUlNQM2tSdVdXR1BJejB2ajdGRWhpenNaRkNv?=
 =?utf-8?B?akJpbHIzd3QwTGQrZHo1eTIrSm4vcEJpM1V6bjZOTmRRUGlGQ0tHbExLK1Zy?=
 =?utf-8?B?M1BRakFoby9jYm50cjZlakh0Wkh1TmJNWlJLamdSZnRNTHNsOGJhdFFsdk9L?=
 =?utf-8?B?VlRHOWxueExXMmtHTmxFUWUzMWVnaEF3Z2I2dWlEbmlWcnRHZEVuekRQVExL?=
 =?utf-8?B?Ym1xYmtGWFU5VFYyaHB0dHdUYWVLY3pvTll2cklEVkZDaFg2WGx4am5XNWdi?=
 =?utf-8?B?ZWlqdnh1ZS9KakZoc01HOVdQV3Y0MTJXcC9LdE1JRGZhNGFpOFU3aitYM3hZ?=
 =?utf-8?B?bzJNSEVWeFM1c2F5WUVLTGM0YlkvMk9neDRyVFIySXpGREw0Y1h2UFF3MDNG?=
 =?utf-8?B?SWVwN0UxU2RYK1FlSmhqN1k5ZTFicVI4cEljaFZPaE42Qjc4T3dQSC82U3dr?=
 =?utf-8?B?TTNnWFZNVUdGRzRCcTBZWFYwZkdJeW9WU0hJR3VwRGZvYjJQbzFoUHphK0VW?=
 =?utf-8?B?bDNHRlZXQzBuMFQrSHhyT25jMFZYZ0xHRFRuWm1GUUxUUGQyb0pCQ1hSVCtG?=
 =?utf-8?B?cVFhNERMaVIzaTBaa3p1aVQ3MmdGWnByMlNoTnlxaWp3TVhVTERhcDY2MTFU?=
 =?utf-8?B?VTRHYm0wb3pEbWV3V2hDaWo5N2t0RnNmVTM2bE9YSi85MUpYa1NyS3dEQkFl?=
 =?utf-8?B?ck1nLzAwS0xWMVJVRGJNYVdzZStFdUcxOHQ4bDA3TkFzdm5qaFBBZ1F1dFlB?=
 =?utf-8?B?akNaZ1g1YlJsUUpCT1ZkTkJmZitsOG1ScGp3WGRKdXRqbzB5MWxkYU5IY3JG?=
 =?utf-8?B?SHNaWWNwMUdBNU42VnlTcVFMNXFUUjIyUitLSVoxWXFvbkxidUtFeTZ3YVdB?=
 =?utf-8?B?UUVtWk1IRkJUOS9rdGlwOUk2VkIrVjlvMnMwdUxhaHdHQzkvbDQ5K2xDQjRG?=
 =?utf-8?B?bVg5cmdWKzF1ZUlDMHRDWWNLclZHdXZ5TTNOUHdhc09xM0JJM0pQYnBWZkVw?=
 =?utf-8?B?dVVOb0U2WG9lK3kvRHhnbGdVMThrY1dpbGlVTXBoSFJnSWtLUUxHdFBwN21p?=
 =?utf-8?B?eUNyalp0OE5NYUZCZFVZbWEvM25yMy9zei9hOE44bTQ2MG1LcVlTQXEwcUFo?=
 =?utf-8?B?NG96T2RmTDl4TGdYdk9PV3VFQnRZVC9rQm9FaUVlWmJ3Z2o1TWl0ZTFNWFZl?=
 =?utf-8?B?YjNUQjB5QlRYL2xkY1FDbmVBaXRWblg5TzIzK0xubUFKYmFwZDh3NmxlZGFu?=
 =?utf-8?B?eURHSXhuY3dXYTFhcEV1N0FvWVFNSnRGNVNHOW9FeFE2L0h3OTErVEZQM25q?=
 =?utf-8?B?bjJtTXREZlhRN0NLR2doa1lqQ29mOGVtbWFRQ1lreWZhNTJiazlISm1TZnJQ?=
 =?utf-8?B?VlFoMnRVcmxieWh5KzU1L3o0UzNQRkExRmlFQVM1VXhFM1BsdkNHWlBGQXNw?=
 =?utf-8?B?NXF6NzVmZFhVMGZpV0lEa1dHbXZza0FWaENDZjV3NEt2R0lzR0VHamkvVGxu?=
 =?utf-8?B?L3ZLSUdHZnlsdmVwMEVZWU1CNGRjeFdhOXdvclBTNEpaUStjUkdsU0srQmFo?=
 =?utf-8?B?U2hwNmZERmtJZVV5eExXcE9MNXZuWC9QU2h2aHVaT2F1YmEyZEN2UjNGQWx1?=
 =?utf-8?B?QnBNY1JzTTlIcDhCeGxMVWlleTg4SFZKbmJkQmMvKzBUZlp4NU9hdG9uUGZW?=
 =?utf-8?B?MkQ3d0xlblBNVmtDWWlNTFpaT1RsSm1kOXM3OE5RR2tFTm9ZNXl4QWIwSG80?=
 =?utf-8?B?Tk5YOGVoZ1NYNm5lSXZmYkhrYmtuNFRVdU1nWWd3NnUxaldUTUFEMWYySXdT?=
 =?utf-8?B?S0tlUHBicWdMeU1iUEtDVXhpVmg1cXJEaWF1c0ZRajVycjlXb2l4K3djNmw4?=
 =?utf-8?B?RHZFNGFUN2s0by9wZ2xURXc3WDRwSitXQS80alU1ZFVsb0hhZm5BNkFIa3lM?=
 =?utf-8?B?WGtiNUFLMHYzdnZtRWhlbTc5ZE40S1dkM1ppUHBjNmZPV0R0ZTQvTmh6dGFU?=
 =?utf-8?B?UXlrNzBjTVRGSEZJZkMxd003NGhOcEM1YnJGdVBiV0djcWFiMHlmcThrcEI1?=
 =?utf-8?B?SlVQcytqODBnY1ZWZThBVmNkUVpkTDBtTXg3Z1FKM0NGNUFkMllHcWxzWmNG?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cb8129-930a-49f2-f4ec-08daf2ced762
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 05:52:21.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SIjBXfPkWEyHvmWQcphKUuR4wsVjX8mjQd6jim5KPCtlKfyVyZQyyWlzE51ftrrik+UuEAHpqhffnOHgQUWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5527

On 09.01.23 17:25, Aaron Marcher wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
> implementation.
> POSIX requires that pthread_mutex_lock() shall not return EINTR,
> this requirement breaks rt_task_unblock() if a RT_TASK blocks on
> a RT_MUTEX.
> 
> To restore the functionality provide a new flag to __pthread_mutex_lock().
> It can get interrupted and will return EINTR to the caller.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---
>  include/cobalt/pthread.h |  2 ++
>  lib/alchemy/mutex.c      |  4 ++++
>  lib/cobalt/mutex.c       | 14 ++++++++++++--
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
> index 0451f6704..2d645c5d9 100644
> --- a/include/cobalt/pthread.h
> +++ b/include/cobalt/pthread.h
> @@ -174,6 +174,8 @@ int pthread_attr_getpersonality_ex(const pthread_attr_ex_t *attr_ex,
>  int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
>  				   int personality);
>  
> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex);
> +
>  int pthread_mutex_gc_np(void);
>  #ifdef __cplusplus
>  }
> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
> index 3b27a04b5..45db692a7 100644
> --- a/lib/alchemy/mutex.c
> +++ b/lib/alchemy/mutex.c
> @@ -399,7 +399,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
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
> diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
> index 634be35d3..28d2557eb 100644
> --- a/lib/cobalt/mutex.c
> +++ b/lib/cobalt/mutex.c
> @@ -411,7 +411,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
>   *
>   * @apitags{xthread-only, switch-primary}
>   */
> -COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
> +static int __pthread_mutex_lock(pthread_mutex_t *mutex, bool want_eintr)

Let's call it 'interruptible'.

>  {
>  	struct cobalt_mutex_shadow *_mutex =
>  		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
> @@ -470,7 +470,7 @@ slow_path:
>  
>  	do
>  		ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
> -	while (ret == -EINTR);
> +	while (ret == -EINTR && !want_eintr);
>  
>  	if (ret == 0)
>  		_mutex->lockcnt = 1;
> @@ -489,6 +489,16 @@ protect:
>  	goto fast_path;
>  }
>  
> +COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
> +{
> +	return __pthread_mutex_lock(mutex, false);
> +}
> +
> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex)

Also here: pthread_mutex_lock_interruptible_np

> +{
> +	return __pthread_mutex_lock(mutex, true);
> +}
> +
>  /**
>   * Attempt, during a bounded time, to lock a mutex.
>   *

Logic looks good to me.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

