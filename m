Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED592570
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 07:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk0QGORnP5sjKCcoGVr2NPfD94l/5ECJgBjrqQL3pz/Rb1EuFn+5LD4mN+Pfq+LYqjKxUlLZw90Sq87/il+9K9N6Fqfxa4sebpjqSgN4DCEslfezbwl+GLrGEHaQGVKfWsXOckzGCesg6vIib+79kYG64z94V+Gxp+uItQ2gjNVje4IpdykHqNjwfvnVH20V6eNDZj5+zJ2deVr0cE+Xhez4apX/IWaGfCi5w1NMVIvHv+mGOjpnPbj6goMVeefLWWzcSEDZZwqpQqnXOzgrG92vaeecp9aUPOBVJ4cQv5ZVCvHSIJjADgYxHpqH3fIxcpGq4HBUzPYgRGDMPnXAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2YBq3US+8SAWvy7xwIBav+bU2hV28iYuEWIZVSZ9qc=;
 b=kSd3iMJAcGxYyr8ocRQIJCtT5AOSqBtAyBGkGLhnAMWMmhI6gCPnzWvmMNF0wc2TVmGamEbyCf5sEYz8SGfRWCM2adMh7asIdgoK4espf3WvMGSjU1fYqeH32dgWWbdc3Pd/u5YZ7lwMZxOtyYLKhOzs+V3VlZC0yRFyRthMHMU9NMyeVf4BxE5ubk184GsspUl/AbRls8m8HEhavySyZPfEnnYFEyBJ3cDbWg8JFR0NVL7ZEBRRbJyd+ROzsRvl53HEB5TKEurTAD6eS6oMsy9lUwc0gK5YzhYAOpBI4nbv+FisAhtPZLBoTnbRzBbX6+eIuGfhUWNXI9BI0PdJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2YBq3US+8SAWvy7xwIBav+bU2hV28iYuEWIZVSZ9qc=;
 b=tG2XDy/vAwwShfteyeB8LQTl6g5RJiay0DA3VMRm04bA/hJUPESYIdLNY9gitwJ3jiFQBE0i2BOxQ6GZuoLoN+hb0n+G663VzLWtK9xS0TfjAwB12Jm1cZlnVNgF3A0dnWbIvApC+QTs2xJbHAxkg6pCfwIuh+mcQjMPU0vIxNfB1aAGqi6M3Pns9gZKzb/Ki2Exm6ersJfGMoYfJOwgiblVGrpc9jQqssiyu0E970gWY0sQk/R9xRcydLVgHPBFrGy6U6Cgwy6wNlPrA/MLL0tplmVTWI2+Oyh2oA6TMLWn8+TV2y2oOct974mwlLnrwOKyuzkwvFPSVkaQKHl5bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU0PR10MB5945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 07:54:09 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 07:54:08 +0000
Message-ID: <17333422-b80e-3442-674f-6780073a40e3@siemens.com>
Date: Tue, 10 Jan 2023 08:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
To: Jan Kiszka <jan.kiszka@siemens.com>, Aaron Marcher <aaron@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at
References: <20220330201614.31083-1-richard@nod.at>
 <20230109162528.26749-1-aaron@sigma-star.at>
 <78c09769-8f4e-a352-5d6a-4f46f326434b@siemens.com>
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <78c09769-8f4e-a352-5d6a-4f46f326434b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0067.eurprd09.prod.outlook.com
 (2603:10a6:802:29::11) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DU0PR10MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: cb86a922-a1ec-4fad-68a1-08daf2dfdabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	abaGjL9p23JhAa3QfKdGFTls4bPhQe/o96I8c+tGomAAL5IPW6c7vMCsf+kmdxw7vC0X5pcJL9Rz5IizXHSMRWpNU6Pxyz2Gj0rGn4T7DZ7isDOzeNvcyqAGLBD0qaIuJbhMSrOSsI6ITq6UpZxhvFkda4oppBY08n+nI7pU9OWkVJeiC+DVQkUHOpHN60TiaehOIQCdIDdhSkGaNA6X7xptoLzsXZpCIbwX/CvJEn1pwE3DFrh4ZtuZNBB8QdC3IxBDbDpYdaJRofOu1a6lNUXRSvZb2eh95GeCwYvMEdSWsGgTvFJS492gk5q79zH9hFj6P0wCvmoo4iXD3iBsD3Ca6fMLe83rkAC2myeAwXre9IOX/HsD+a9V/gYQdi5+0OSim6GIEcqTQ/qcrZILgYVST+Sx4kIxQSMZccBEieaLo1h5IrMLz9dVIn708Wa5+sPRYd+ftKxA0CmSAPxunTddoowi/tALIHZhf8I4dRrdq8ZQaWxGO+qVUUHgpjEQhX9Ah/dQjxHmUO2+djaHo9i0n7rTKSZyr0gbz5IotG7hb7l7BmrZRsXUWDC51QHp8DlMVdcVFclxVmiD/u1kG47m/rO/dCPYlMzdRdBen2tIffCv+ONvMMDIBcwPahGR7GonN0RbAFpbBRSh15Aw5qjH5NffiE/dVFHMZS/IVA3WwVX9hkGoBaM2zWLYt+uYfSGhgBpPDXLmDzgdXf8Y+MqEpR0sCiv34DxTO+Vg7vM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(36756003)(8936002)(2906002)(41300700001)(5660300002)(4326008)(66476007)(8676002)(66556008)(316002)(66946007)(44832011)(110136005)(38100700002)(2616005)(6512007)(31686004)(186003)(31696002)(83380400001)(86362001)(478600001)(82960400001)(6506007)(53546011)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEhHTEVWcGVLSlZFTXgwNUVrRWVtV3lnYVlEY3RTcTVaeFhvMGpmRWZKZjRq?=
 =?utf-8?B?Nm5ldC9CbmhPZlRjTWdlalhqc0lubEluTElHRHdCY1pIWFJJUlJKWXU5SlBW?=
 =?utf-8?B?Ti9nV0tKMmVKMmhxV2tNbDdkL1dxeUZDdDRqZTdoQURLdnB4bm5SY3pTMlRH?=
 =?utf-8?B?WkY0Yi9CYlRGdk1mVmpEMktpVlFzdjFYNG9OUFZUWHZtOWxFY05QT3JvM2gz?=
 =?utf-8?B?SkdXaWMzWGREbGVvTEJxTU8vYU03VzdHbERVQllUTk8yTGdhdjNiZWpweTlJ?=
 =?utf-8?B?aTQ2OGlacnJyZ1BBaFlVWW5VTFhjQ1pWNmthWGZQRElCaFdFZm0zL2dJSzRF?=
 =?utf-8?B?VW5JNU1SV1Z0dlhaK1pLcEcxc3I0VkZyWkEzVU91b0RMODExTkVGR1hyMnpy?=
 =?utf-8?B?RVB1MHlDdFlDajAwVUMrUXhIdVJ3SGluYlpQWHVXYXFMaGVLVXRFd3pVTlhu?=
 =?utf-8?B?WlpQTElRSExWQkRBQ1BYK1dvd040eElzTEUyMzJUV1dzYVFXTlhNc0hDUUhm?=
 =?utf-8?B?d0c5QUVVTmUySzdPZUthVE5IZ2hiVUhkQ0YzcnZrSEFUVDM1c3BDT3JUNysw?=
 =?utf-8?B?RWt4RjR0VjZLNHNvMmVNZ21ESjNGcnhseFV3VUZpUUxSYVlDejkzNzJucDg1?=
 =?utf-8?B?MWxwcmhISmVXMk5zZVJCdUpLdUlZd2JNS3hUWHBBNkZDK3d6dkFOSzdIcjNN?=
 =?utf-8?B?M0d3L1dRMGFaVURwa0VhY0I0WjMvb0lTdXZwZTRYWC9UK2I4ZmhJc09hQXNk?=
 =?utf-8?B?L3pDVUowT3lmUi85bUNnS04xcWNtWjJHd0lqNTZYK1NSaEpnS1l3N2RwdTQ3?=
 =?utf-8?B?Y2ZESTd2NGZhSG85QlEwK2JmUmFTdEQrSU5nKy9wcUlOYlRMTGJUMjZ5eGd3?=
 =?utf-8?B?UUE4K2h5Qi9pamFyNG9wa0xlbTJnb2t6MTVac1hBSTR2QW9ZSkEvcXRhUm5H?=
 =?utf-8?B?ZDlWRlVZNDhFcVE3dEY0TEp2NnFwTlRPVCtoOWF6WVZ2Q3RaakswZmk4OWtW?=
 =?utf-8?B?Um16MUJvMytzK1FNVjJWNWd6RG9vb21DK0dpVktYV0RVNVh4aEliUmNRVHJz?=
 =?utf-8?B?cW1CNFdxZWpJQzVhNjhJOFJzM3NnUlU5Rk9IaXAwWXFsaUszbWNnbXBuWDdm?=
 =?utf-8?B?OEVsemxvcFFSYnFjbXR1NUsrMjBVMU9QQ05qaGkwTE5zTFp4emZuVk03LzE2?=
 =?utf-8?B?VVZyczlLaFRuUFNLMldSL0lsMTBFM2pMQ0tKeWU0a1RhUFd1ajRjc0pjcHFl?=
 =?utf-8?B?Q0FrWTU1czBqS2hKbTB1K2x4QUI0aC9IQVQ2ekVrZjdXdEp2aWZvTEhoQTdv?=
 =?utf-8?B?UmtkeDl3alNWYTF6T0N2Ynkxb0lHaVpyWWRhaHNWb2ZnV2JtZDN4aDRNdW5z?=
 =?utf-8?B?ZUVvNXdydS9ZWGdzekkyc3dlak9aZXRWWS9xVVRvY0hHVTVJMG1OL1ZGZFZp?=
 =?utf-8?B?Wms5UUxHc21jK044U015emVxTEhGMFE1ejQ4QnRUeU9CcE9ic1lGU09CSEkw?=
 =?utf-8?B?Nkp2MFVRSG8rMEY3VmdxcUZWUGVOZk1Qd0pYbGRUN2pyR25vM1F1NktmWlJn?=
 =?utf-8?B?dVM3WFpHZGZDdEFYTTY1VHVaWTBGeXY1TTFHYVNuSG5jZmZsTTlHa3orTEMy?=
 =?utf-8?B?a1U4VnRXaTRsaTh4bnBheDNYS3B2MHBqTU03QlNxdDJXdkhLNTVJeWlMY3or?=
 =?utf-8?B?U1czRVBWSDhnNXI5aklxYVg0TXMxL0JqQlpKN084T1ZJL2dtbWdpcU5QcnI0?=
 =?utf-8?B?eE5iQjdFR3cyMWtNbDNWRHAvT05MWGw1a0R4eWwrWWx5KzR1YW1TdDVnZGhh?=
 =?utf-8?B?YW0zdUlseStMaCs2OTBVc2ViZXl6UHAzNjFzeGF0ODVNY3psa3BaTEtBWkY3?=
 =?utf-8?B?TW5udUc0WDVodUFMQ05jYzlpNURMVFNmT0ZydXRJcnhvTkg5K1U0Zk5uTG15?=
 =?utf-8?B?SVFPWE9nNGZFc0Vrbll3SUZudlE5STIxWlpjRzJXZFlDTWRkeXozMUFpQTVV?=
 =?utf-8?B?NnA2enJDUFIrekdBa1U3TUtiOGtKV0NFNHBHcGc5cjQ5MVRJWitETmRFRzFE?=
 =?utf-8?B?R1AxU2ZoVzNWSWIwOFFwYlNkaGYvK1psSFNqdWYrZy9DQjJHdU9OSW5hdERs?=
 =?utf-8?B?cEVjMWwrRkVmZUN4K2pGeFdtVXh5SHpDaVdZOE9hTXZiOXRjZVlhNlVTK3Zk?=
 =?utf-8?B?ZVVuQm5UU3lKeUhpNkpLcmpjQkx1SzMrSXp5djlHNzlYMVh0QTlpejgvaC92?=
 =?utf-8?B?RllqeDFiRnA5NXVzcWVpb0dNQWFBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb86a922-a1ec-4fad-68a1-08daf2dfdabc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 07:54:08.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT7MOnnblI93NBGr3+ZkctYQBDVRrI3/IS2GRIniT/KxMNaEx2cKRrqZ1kh2EtJIIlrbj+pmlN7QZo5jS1pRVVWPy567duFqJB/bRtfG8ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5945

On 10.01.23 06:52, Jan Kiszka wrote:
> On 09.01.23 17:25, Aaron Marcher wrote:
>> From: Richard Weinberger <richard@nod.at>
>>
>> Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
>> implementation.
>> POSIX requires that pthread_mutex_lock() shall not return EINTR,
>> this requirement breaks rt_task_unblock() if a RT_TASK blocks on
>> a RT_MUTEX.
>>
>> To restore the functionality provide a new flag to __pthread_mutex_lock().
>> It can get interrupted and will return EINTR to the caller.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
>> ---
>>  include/cobalt/pthread.h |  2 ++
>>  lib/alchemy/mutex.c      |  4 ++++
>>  lib/cobalt/mutex.c       | 14 ++++++++++++--
>>  3 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
>> index 0451f6704..2d645c5d9 100644
>> --- a/include/cobalt/pthread.h
>> +++ b/include/cobalt/pthread.h
>> @@ -174,6 +174,8 @@ int pthread_attr_getpersonality_ex(const pthread_attr_ex_t *attr_ex,
>>  int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
>>  				   int personality);
>>  
>> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex);
>> +
>>  int pthread_mutex_gc_np(void);
>>  #ifdef __cplusplus
>>  }
>> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
>> index 3b27a04b5..45db692a7 100644
>> --- a/lib/alchemy/mutex.c
>> +++ b/lib/alchemy/mutex.c
>> @@ -399,7 +399,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>>  
>>  	/* Slow path. */
>>  	if (abs_timeout == NULL) {
>> +#ifdef CONFIG_XENO_MERCURY
>>  		ret = -__RT(pthread_mutex_lock(&mcb->lock));
>> +#else
>> +		ret = -pthread_mutex_lock_eintr_np(&mcb->lock);
>> +#endif
>>  		goto done;
>>  	}
>>  
>> diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
>> index 634be35d3..28d2557eb 100644
>> --- a/lib/cobalt/mutex.c
>> +++ b/lib/cobalt/mutex.c
>> @@ -411,7 +411,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
>>   *
>>   * @apitags{xthread-only, switch-primary}
>>   */
>> -COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
>> +static int __pthread_mutex_lock(pthread_mutex_t *mutex, bool want_eintr)
> 
> Let's call it 'interruptible'.
> 
>>  {
>>  	struct cobalt_mutex_shadow *_mutex =
>>  		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
>> @@ -470,7 +470,7 @@ slow_path:
>>  
>>  	do
>>  		ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
>> -	while (ret == -EINTR);
>> +	while (ret == -EINTR && !want_eintr);
>>  
>>  	if (ret == 0)
>>  		_mutex->lockcnt = 1;
>> @@ -489,6 +489,16 @@ protect:
>>  	goto fast_path;
>>  }
>>  
>> +COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
>> +{
>> +	return __pthread_mutex_lock(mutex, false);
>> +}
>> +
>> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex)
> 
> Also here: pthread_mutex_lock_interruptible_np
> 
>> +{
>> +	return __pthread_mutex_lock(mutex, true);
>> +}
>> +
>>  /**
>>   * Attempt, during a bounded time, to lock a mutex.
>>   *
> 
> Logic looks good to me.

LGTM as well, but: What about testing? Shouldn't we add a test case for
that, making sure we do not break it again?

Florian

> 
> Jan
> 

