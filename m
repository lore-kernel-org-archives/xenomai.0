Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48C2570
	for <xenomai@lists.linux.dev>; Tue, 10 Jan 2023 08:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzjkO9h9z6HXKL2d92CbAI3smaeLMA39ZAGEk5LQwHV32Z0RlJ/ZK65e7DiA4Y21i/4LgOLnYwsDtiMcBiYvAzCV1UKvm3yJ728qGEnxSx4nqQNkYAFAwgzU3LRPf4WHiTifgPq9l0F/dHNI+GJPcWoE2MbpEJxBCD6g7VNODCb5fV/i9mljC52ldRyBSFJKqBKmXDCsgbsll7mc/uR2VkEhgBYFh+iLXw8GKe4ndn2is/WvzOqUP4XGzzNVolP/k2aTl2jqiwCPTEzhDh6jObOvgI5aGDz7/CBeS2C/m1M9X3vd/G9ICnaHpaeJAw4K/rkgqW2WQHxphEgw8NHC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIQTEk39RxxVxzKj0xSAw3XVywua/wGjlrLAMkdj0Jw=;
 b=LhIn5Awer+Ys+zdSfguLMtmqDg2JNkWo3eyAgdxxoyA/NtQ9LSPTxY3rW8L4l0ItzQy3FT5wLPl48dO6GWm4kQHAGxtXTd4eJ2gifU7XIxqKMqZqbNYh1uTsYKCUNh78WYlCRUDHHJdDOdO+E/55xKKbixiq89ogWm4vmgUGhynGykVUcE0l8KoXdrw+/grc0RNu6x4xdazP1SWc8htMVRbXX0ok801rSdiCM5yA9/b2s6cNUQXL4Iikc7CjIKElqq+6bTyLMLPP39gCBPisjBCgRH+xfTrRQpH/NzLuSqHt1WodmzPibgjjMCRq2FcWE5qwCP4bwaiFjKuE35enPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIQTEk39RxxVxzKj0xSAw3XVywua/wGjlrLAMkdj0Jw=;
 b=Z+HZqcDtyTF/6G5HkKdpblzMa6i71/itqa8pStlal8M1s1mToqg2WZUvLi62eQ5JJc/l8btYVNKAYnMAi7kX36la++oKMPPqb5TDUK3ZPELwX+TubL71lEK9IO436WT0ZtH9z82KPYpjgwmwQuX7W9L1H0y5NmjZU3gAlOnkZ+GqdR0YO6P9EDmOKi3AzB1HH22d60hZbAGdU7E2DaG/BtqgY+hK+WXpTeYs9TeWdz6sv+rXBP2sB9MFpsDEp66KQSIozBctCJ9XIWEqqX0eWkhXtJJTrRs7gkBZBMJZsIJRIEX+yC0QNcgvKH7VbJG5vW/8cONrRFi2lnDFUSEHhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:02:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:02:46 +0000
Message-ID: <6d0898de-f2fb-b0da-dc05-33e0dfdce1d3@siemens.com>
Date: Tue, 10 Jan 2023 09:02:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <20220330201614.31083-1-richard@nod.at>
 <20230109162528.26749-1-aaron@sigma-star.at>
 <78c09769-8f4e-a352-5d6a-4f46f326434b@siemens.com>
 <17333422-b80e-3442-674f-6780073a40e3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <17333422-b80e-3442-674f-6780073a40e3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: f010cb9c-3838-41ad-602e-08daf2e10f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aHK60b/cLRgIGtZP17z0/5Fd1RjG05poLffpA7aKVD7i0Zhue1Kl/0SfE7Jv375kdQAg1JXDMayM/kEv12Rev/P5Za9KsADSNoMByFjRqhIbCryUdpZVUkrAjPpNk2PpewEQyPmWhmOZEbH8FyWBuxTvfXrnBEcRlLwFABTGxrLcTPB6/4Pe2WWMtiz+btc1FBjXOb5WkYPbVSw15goet18P9nch1T9dhp3BrR2jxrAxeEm7XGXJNHS1P8lW9xUcn52R09fA1oW7SV2exh6IzadZgZleieq4e0sNqOsXXXUe6dshD/0S4h+Dtu2p02+MDYZ1p4xkL4u6PbvY5YqXC9YrZSbhMAL5pWr9VN0JcqLzXC8VT2i5Toed+3IDF78OYSn3xdbflFQOfah+1Ragr3PqqklEakxKcYAXXVzSl61Xab7dANC3VZi9Lz7VvohwRAid4ucZyaKSVvCGLv2DDzr77cYlK7QT60XX1JqLrg2FXsGFLz5iOqB2oveBALP2ooiDnbkGhpVByCY9CCqQ4TAQyGiPIwRll/CZ2FYQPla5l0VRHW/vGslhOaun8FZ2qwEH0Oa5d3oxBU3eWvHEiL5H4YuyAV2+CSsKEx1P3hcbup5eR4hFJWWnf6Jw5zk7Kmzz/6TmcpZVgF90vCerZBdPyFxB7/IzSA0uNO6kDec1+LgxQd0v4BRD3d63BDZjlpsur1Af2KCTHakfgYlE8uGFA4ln4ShAcGD3v282iUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(41300700001)(110136005)(316002)(2616005)(4326008)(36756003)(8676002)(66476007)(66556008)(66946007)(86362001)(31696002)(5660300002)(82960400001)(83380400001)(38100700002)(44832011)(8936002)(2906002)(6506007)(53546011)(31686004)(6486002)(6512007)(186003)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFNUK0pOZ2FoWG00WkxPSGh4UFd2N0FmS2Y4aWFDRElGS3R2dlh6dlVQV0Fj?=
 =?utf-8?B?M1Fna01NbHlnVW9qSXR4NVBHVXY5bzROYU1TREdaOHplbEpiZVZwN2t6dHpv?=
 =?utf-8?B?TkhFb1dYWkxmMTAvdVJZZ0ljbWJkcjljaS9sbllkVHFsbDBqbkQzdjR3VVlK?=
 =?utf-8?B?ZVVOSXpEVlVxVUMxamRrOVAzMlJNTmRRY05xNGRmUTE0c0lmQ2lKR3RiTHpu?=
 =?utf-8?B?ZkJCUENJa0VqT3hyd3plaFYrbnZaNEpLbHNCRjZrdlEya0VxL3N0L3pkdW53?=
 =?utf-8?B?OFhTM1g5UysyTy9ld0N0UDQzNGZIc1VkOHZWWGpCV0dPNFJXOGVyOGxYM01S?=
 =?utf-8?B?S1VVRXY1cDgrSHR5a2lDejQ2Q0FOcHBuZTk5aDFoekRQVytJYzhqdVJjME1I?=
 =?utf-8?B?YTFCSkxnRzhPd1ZMSWNvUUV2L0k2YlNncDg0UjJYUGtmdDA5YUFmNDJWeGcv?=
 =?utf-8?B?UnN4S2FySXNSYmdqZDZvYktHR2JTOTZHWHRRRzhHSGFweitUSmRoSzZYbC9M?=
 =?utf-8?B?M0VaNnA1TFhiSWJtUjJXdmNqNzJLNks4TDdvbXIrcVdtVmdGSE1uTlBkUlJx?=
 =?utf-8?B?OWtXUEt6N0dGbS9pTktaZGpZVGRKTy9QbEdyMk9FSUFaVXpNSThmZHNPSGNC?=
 =?utf-8?B?c3hNMVZOUTQyd3ZZYStLVDc2ak4xSkJTUXM0dnJDUmZHeHViZlg3dUEzbGNs?=
 =?utf-8?B?TlcxWTdEWWRIbGRUQWR1ZHBOMk1jSDB2cWdHd2dwcjNRelp0c3loRkpjUUZM?=
 =?utf-8?B?K3d6T3duSlVZbnp2aE9odENkSWt1SVlPOWFFQXFNKyt5SWFOaWJ4MVorbUdQ?=
 =?utf-8?B?Z1BtR0ZoQVZTNU9TVWZnNlp5NzFqZkZ6Z2t4NnlqUFlsMWVVYkZOU254Ny9k?=
 =?utf-8?B?d3FyK09CZ28wTkE3OUNQNTNvRElDcWxtbTlBNEFnZVJNVXNYelJQeS9jTGZp?=
 =?utf-8?B?QTVjYnRNQmMzck9KOFRKUi9IUGcvV0QrY0FMR0lPdXArZjZhUG1QYkdlMnpN?=
 =?utf-8?B?VlpnVjJORDZ4SXFMY0RvSlBvcS8ySE45RW9SUzlIZzFka0FzR0FNVXY1aWto?=
 =?utf-8?B?U1k2V21KM1N6TUtjQjVhQ2tOVE04ZUVBM0RtWlhROGhrc3hFOEJtdUxKb3BL?=
 =?utf-8?B?blVkdmlmOC94QlZKejYyMm5HL3dHaWNsdXZNWnBMY2padEh5WEQzclVMTGRJ?=
 =?utf-8?B?OUZvKzg4cEd6cjc0NGhPdGFVVTR5S00rQkp1OFdhTUhMMTNRVGNQb3g5V2lh?=
 =?utf-8?B?ZkxYNFlIeWhVQlpmUHBvTEVmakxUY1ppRnJkTjdmYW56a1gyWTRIYm9oYmJU?=
 =?utf-8?B?cGxjRDBEd0ZQOU5ERTl0cXh3VFp4eTg4L2NjNkZ4QmZHdnFXcXhlTi9qRzQ4?=
 =?utf-8?B?cTd2M0NBYkNIbVpvTW5iSmtORFpaWnJPMUV3VkxFVHJoa3Y3RmRvc3F0b0p4?=
 =?utf-8?B?Z0pSakZOSXlFa0xMc1MrWlMxSWViU3V0VExKTk95S2YvaHFmQ2tKSTMyQnFj?=
 =?utf-8?B?R1JWNFJaRXhNS1llK0VEM3dMa1VIMVgwMGZhTWpZdVN0cVQ5b3lhbHBCNlVv?=
 =?utf-8?B?N2tsMXk0ZTZGaEVsWmp3UURzYlBXR09WaFlKSkVsbUZndzJVMUcwQjhpZDhW?=
 =?utf-8?B?ZHNBQkhINW1Rd0Q2QVdvR200TnJSblZFY1ZncUp5Rmp6Ylc4Nko3ZGtXdGFB?=
 =?utf-8?B?NmlEQ25UWHBSdUJob1UvUDVvWmFjc2FVd0xGSkFBRVlFTGo4bjlhdDNMeHNu?=
 =?utf-8?B?TXM2TGc4MzZCb2dOdTZKaUE3dHd5QU5mVktlM0lHc29jc2dzYm43NDlqMlBj?=
 =?utf-8?B?QnhsOFVsM3B4dHlhYUVBanJISXNaS2pwWGNtMGxpWTlubjdTM2dYME9sb3NT?=
 =?utf-8?B?dVBlSEpmcFBmYUE4SkVvSGtFNFFjWDA2ZTg3a1hhYU9jZjhaRzg5ZWhMVHpV?=
 =?utf-8?B?M2ZsWjB4SHREa2U1SjdFU2hCcGx0YUdHTENkb1R0T21JWVROTW13M2l0Q0ND?=
 =?utf-8?B?NnVDdGR6U014SERtSnpWaVN3WkJLbnhxYjJ5dGFRZzFOdWVzZUR5MVM1MUtj?=
 =?utf-8?B?Q214bFpuWjlaNGRHeG0xK0RpWjNWTG9kTXRDc2ZUbnFHbWJKRGp2cmd2S3Va?=
 =?utf-8?B?Y1VhTjIzZGNoWEtmclRESGVPR0M3T1BHQklYRS9XVGNYTHdCKytUV1l1ZUNH?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f010cb9c-3838-41ad-602e-08daf2e10f35
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 08:02:46.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cddOWWOfzwW+oEAwE97boYUWnc90WZ/TqH0v7UOI6jQm1AnvYnKVo0/lsv3f6WkbVMkQX7a/xfHVnaGHSWWtEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7742

On 10.01.23 08:54, Florian Bezdeka wrote:
> On 10.01.23 06:52, Jan Kiszka wrote:
>> On 09.01.23 17:25, Aaron Marcher wrote:
>>> From: Richard Weinberger <richard@nod.at>
>>>
>>> Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
>>> implementation.
>>> POSIX requires that pthread_mutex_lock() shall not return EINTR,
>>> this requirement breaks rt_task_unblock() if a RT_TASK blocks on
>>> a RT_MUTEX.
>>>
>>> To restore the functionality provide a new flag to __pthread_mutex_lock().
>>> It can get interrupted and will return EINTR to the caller.
>>>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
>>> ---
>>>  include/cobalt/pthread.h |  2 ++
>>>  lib/alchemy/mutex.c      |  4 ++++
>>>  lib/cobalt/mutex.c       | 14 ++++++++++++--
>>>  3 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
>>> index 0451f6704..2d645c5d9 100644
>>> --- a/include/cobalt/pthread.h
>>> +++ b/include/cobalt/pthread.h
>>> @@ -174,6 +174,8 @@ int pthread_attr_getpersonality_ex(const pthread_attr_ex_t *attr_ex,
>>>  int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
>>>  				   int personality);
>>>  
>>> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex);
>>> +
>>>  int pthread_mutex_gc_np(void);
>>>  #ifdef __cplusplus
>>>  }
>>> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
>>> index 3b27a04b5..45db692a7 100644
>>> --- a/lib/alchemy/mutex.c
>>> +++ b/lib/alchemy/mutex.c
>>> @@ -399,7 +399,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>>>  
>>>  	/* Slow path. */
>>>  	if (abs_timeout == NULL) {
>>> +#ifdef CONFIG_XENO_MERCURY
>>>  		ret = -__RT(pthread_mutex_lock(&mcb->lock));
>>> +#else
>>> +		ret = -pthread_mutex_lock_eintr_np(&mcb->lock);
>>> +#endif
>>>  		goto done;
>>>  	}
>>>  
>>> diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
>>> index 634be35d3..28d2557eb 100644
>>> --- a/lib/cobalt/mutex.c
>>> +++ b/lib/cobalt/mutex.c
>>> @@ -411,7 +411,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
>>>   *
>>>   * @apitags{xthread-only, switch-primary}
>>>   */
>>> -COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
>>> +static int __pthread_mutex_lock(pthread_mutex_t *mutex, bool want_eintr)
>>
>> Let's call it 'interruptible'.
>>
>>>  {
>>>  	struct cobalt_mutex_shadow *_mutex =
>>>  		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
>>> @@ -470,7 +470,7 @@ slow_path:
>>>  
>>>  	do
>>>  		ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
>>> -	while (ret == -EINTR);
>>> +	while (ret == -EINTR && !want_eintr);
>>>  
>>>  	if (ret == 0)
>>>  		_mutex->lockcnt = 1;
>>> @@ -489,6 +489,16 @@ protect:
>>>  	goto fast_path;
>>>  }
>>>  
>>> +COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
>>> +{
>>> +	return __pthread_mutex_lock(mutex, false);
>>> +}
>>> +
>>> +int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex)
>>
>> Also here: pthread_mutex_lock_interruptible_np
>>
>>> +{
>>> +	return __pthread_mutex_lock(mutex, true);
>>> +}
>>> +
>>>  /**
>>>   * Attempt, during a bounded time, to lock a mutex.
>>>   *
>>
>> Logic looks good to me.
> 
> LGTM as well, but: What about testing? Shouldn't we add a test case for
> that, making sure we do not break it again?
> 

Ack -> lib/alchemy/testsuite/, likely.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

