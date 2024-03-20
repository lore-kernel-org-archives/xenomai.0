Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D7224F2
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920548; cv=fail; b=JWkqzY7R7tGX4Wa+Y/p9OUhgwMyt2bzfMLDZwhD8pqUUZaL54barsAD4JqmTH1erWR6QUsBiJyaw8c/JWxzbMteg+t/6wwKuvyJcggCfIi89hbofxBECntT9FI6uS2NPl45zsqEyGrzvOet4y+NVjcqEeIweAdxmiGswhkWeicc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920548; c=relaxed/simple;
	bh=0rsps88cWuHNTwMGqgA4JpN+CpXIiwXU8cSmECP2Bfs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IzuX3lTHrG5Jv1VvKLfCnBsdqPWtoMd+nVzAh7EpqRBp67aLCRB4pl2sl+zFUUpvuSQ12Xza/6L5OZ7F+2lpg1ehLqsNp/4GgjXtpTqorh6y5rLhYZ5ruFdiynIjXqqplwnpmWkmVvFm+TJLHUN5LxXGes9M1sS7kGZfM1UYs/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vIFk5odG; arc=fail smtp.client-ip=40.107.104.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vIFk5odG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCaJVp0HhP5NN5PzQVjt79mzWCXm81lUFBd/LIR6h+OGm7keiLm4Ik9zqzwSCtTHXAQufDuBVMoEnECoW3uh7VGjU1p4RpItHpUOAoPFaOFTQPEdFRAR5cdkqL2R4HalVikbgiBE56YN9zJzX5cShn7qP9KCxQrrwoLk1PykV1lp9nbi0oQcXe7sKt0OY2dk3RrKgn9WMydfPA3NTs+dH41AJT5E7JNMjZRDICyUUNHBhUwR7gLvi/glm9nMH38SrYF1Jj9JUKt8IfwZ6gf7WnPt3YzrxCMyPskUkOMiAtAZ7p3Z7SWHfX1wZpMZ67IOQXwPHTCqKDrF6cg/hnsSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKBLVb5WMUZvIlkGeclAW8GfMhSkz6+7LuZWKYyasTc=;
 b=Q4DjKAiSWgg+n23Q883xT6734ZMwSS8INeZ8MFAKWr0SAOhGBsMg0jF4WT6ZO5X7bP9rnsSl4R9kg5Nlf/Lydxp/fysU7c78zUXyjcKMPae8i2lPlaLXsN1gY9e5fZOrpgnqCugb23bw8AfDOWE2f+y8IMfT4rQ4D6zNiPKMymaeBfUjOqt18m8IJALxTJSDQLXDxi8su6hDDm5cPHAzROU4geMnGqvQx0mNjkbHmrRNGJj/MYG6asc+LyWvi5kvqiUxnCkOt6PsiRv7ygDe4BMmO9iS0zi0WK/D+8LJDR6jLywtvfOVqEIyCtz/4+wihIuMh2ZcQK8vBqiKWr+8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKBLVb5WMUZvIlkGeclAW8GfMhSkz6+7LuZWKYyasTc=;
 b=vIFk5odGH7UIXIOoJCsyMSCVQ2hhsj3s8ICojKTcRGgSEUA7VK8v+2btqBjCLskLVUzByQfNhndyHvTvRgTvL9G7mNJoxfmcTMBCFla+Rxnn7fqhten2culmedJnf1W9xI18+r5Pyu3c/R16+j5j36822UerWdVzgJWTcTlnbKMGDg+8VPBoa9+QOc8lRciWBwJIDnkoGXiNhoYAyUVREgo+mfPelHgCCJ+OZCno4cf0jdP56f1pmHxb1tABVY5M00WfCLeDe1JlAFNz8yQy1nuJeGmQeie0CPYpciTNeF6pdBp+9/zwA9SKieHHztPKaGH8bfgK4QYVlePvLJJDUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:42:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 07:42:21 +0000
Message-ID: <f3da1356-8a59-4bc7-b10c-aafa615e4c9e@siemens.com>
Date: Wed, 20 Mar 2024 08:42:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] testsuite: smokey - new testcase
 pi_nesting_contend_multicore
Content-Language: en-US
To: Fabian Scheler <Fabian.Scheler@siemens.com>, xenomai@lists.linux.dev
References: <df16b465-e1b3-4783-ab0d-749bbdc0f802@siemens.com>
 <20240314131927.27417-1-Fabian.Scheler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240314131927.27417-1-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3696:EE_
X-MS-Office365-Filtering-Correlation-Id: 353fc947-1670-4e19-f638-08dc48b14709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	psX3LU22X4d5IH6ISL5rak414bV+lJOXvZPU2VlFUgQH+QgLfriDjiYRt8IhS+/CflZIY3iewByw6AotpwgJllfAhETj5mFaHsfbD8LT9+nCsPjfyop79l0pcFa8KxdQB2HSJi8nImXhq98FUEOapi1+a5vhajBKlKxIc9GQYWj2Vju0s79huv0cZUBlsnqXhBtHKAIOihv/oTakStuWwevzbcHsLb9DjX9VuhMxPGhutqGCidvhU1w3LATrUafmCuhOUU+JnXzzXdrTgArCKe0D/PmOra6fRhoqZabPKdtv3OV7K1kztq9C9STgsIVcb232Wpb8oug/hIEQFBBYlow7fqntki9rH5D1EFLLjx3SmXdoZrghHeEb0zru7F7NDl/YZMXFUdnW7rRmtiJY0TqP9brvOFetE+x3FWwb2cTRQJ4matHOj0yG9CCUQCfVNgNeM0IQ1qwnpseuEyIyE1biKfoy/x8sOqiAX/sC08Uk1XwsMF7aV1pLC7M78bLCxHYTEmjCXkCLOna9o2U0G+Ti6lfz9FsCZTx7fBQOPJUwULnvM1IKCinTZxPpCysAyyiY2dzQiCbKIi7E7+eQi7jUUdSHlwsIcSIwYc5rt4o/CR+Wj+rVsY7B+doZu1r7378IgUYgEwJAV8lj3vyzaLVl4fV1PMbJhaGwKh6JXWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3JGM01aZDFVNlI4TDlqNlNhVWhtdDB4QWNWaUt6bDM4WVNGbkY0cmZJOTRt?=
 =?utf-8?B?dXR1OVkwNG0rOU9BdUVXYk5FZFRFNERoQ01TakhXeGVSbFg4MVRXcE9sdjJF?=
 =?utf-8?B?S3FGSWVnNGdjbC9JaWQzWVJZUnZNNUFIcjJSdnRhV3JwWUpQZTU1aXNVWHQx?=
 =?utf-8?B?UlBRcEJ5d2VycFplWDgwbTA5c2k5VGNIMlhyb2oxWW5zN0h5MzFRYWd0NzdR?=
 =?utf-8?B?V29oU1VncElJNUlnWWJCcWVEaHlobTM1UW51ay9UeWhobWtzczRWelNKNndl?=
 =?utf-8?B?M3RvZEJaQ0J2VFAvTmNnSXJQSFVRTW5ZRkFDZG4wTkVrMGQ0dDVvcnF1UThn?=
 =?utf-8?B?MXFNc1FyaVRvMzVpQWpwd1JSaG9QY29XSldwNURwZWJxNlZQbnVWRW5hc052?=
 =?utf-8?B?ck10eUYvOXpROWFyUG1OLzlPUzhuZms5MlJoY2RjUGV5MnpicVgxaW56RXZV?=
 =?utf-8?B?citBbk00ZHZ4N3lZZWhuWkFMdWJtKzdIdDN5am5adW9qeExRT0paUjBtVUF4?=
 =?utf-8?B?TTQ3R3FDNmVuTEkxaTFSU0JTNGN6MExrYXNZQi9DSk13RThkRTVwa2lFTTRy?=
 =?utf-8?B?M3B3cHdteTBiQllxaDE3bUZvYktkY3h5MGRqVEgxa2pCU3RCS0dYQTQwVVF6?=
 =?utf-8?B?allmZFBMNFZETGxwa3lWWGZQZzJ0T0gxb241OHd5bDdXWmZ2RzJWcHdiM0Yr?=
 =?utf-8?B?Ri9nL2FIL1JtWDlTQnBCcXVuOVJHNDdXbE5WSDVyeHJqUVd4YmJTblNoTXhn?=
 =?utf-8?B?RHlRaVVBdVRzTTFVSGdVNVo1Y1BoWm1oRHluMncvVGxnY2xrbHhzWkdnaTlI?=
 =?utf-8?B?UHVKNWNHMUdQK0lndFNvcENuNEdyWTlQRkhWTUY3QTJUQ0lNV1F1OHI2WTRo?=
 =?utf-8?B?NzQxWS9aekFlbzZnQU5qdGFSOElWOEk1eUYyNXFtdjltSnl4Wm5VR1dtLy92?=
 =?utf-8?B?ZGw0c1lUclpyQ3JlMmRWSmtyNmxIcWFxRW80N21QRkR5Nk0wUmovU2JyZWFL?=
 =?utf-8?B?WC8vZXdZY2hUM2RLNEcramx5SXRaamlqNEJ3VUxYL0s1NnJka0ZlcTJTYmRq?=
 =?utf-8?B?aGs1OGRMYXRmNU4wMXI2Z2hkN3NQM1BrbVVDblc4Zm9wNlhJMUJkMlBpT1Y1?=
 =?utf-8?B?VXZvZ3UyeHVXSjNXZnlFWUFSYkN0ZDh6eHl2ejRBQlNsZ2xWMEVpcmVmREVR?=
 =?utf-8?B?UkJFdTZaaVdUbWhncG00Rm9MQVdkMnI5T2pWOFVWSTI1TmtCSWtja2JvVWU1?=
 =?utf-8?B?M3IyV1MyYkJTUk1mK1A0RXNuR3B1bFJyNHhYNFd6Yk1xU1FSTTU3eHladmt4?=
 =?utf-8?B?bFJyamgrYi81TUhVSUdCYUJyQml4M1g4MWt6ckd4ZURZK3ZRTmNySUxwU1Vm?=
 =?utf-8?B?eFhJY3kwcTdyRWJBQ2Y1N0NLbWwxYjEreWl3OVZCQVZueENNQk95K2F3Tnc1?=
 =?utf-8?B?bU1tMGRtMUtXblB4eWlZblU5aUh6MlFodE9pZGJ5MWRIYUl3dWVzM2pEVW1p?=
 =?utf-8?B?Q3AyeEVVM3dFKzdGM1FqdDJmbndIcU5BeDYzUTZrTmRBME0rb1FQRWJ2NHlM?=
 =?utf-8?B?dm95MjNhM20xcDBkakZCQkxDOHpFeldJTjhtVkxrWXVkUmxkVGtFYWhsWDhH?=
 =?utf-8?B?Y1Jsa0VMQzFTN1MzNzRNQk00alR1UWJYNU9jRUJsNWM5VXR5bDRpa1I3MkN3?=
 =?utf-8?B?QW9RN3lBNVQ0ekF5eVZjRGZBVUxyTzJwTk96aGpaSk42ZnVaNVpmK3A4ZjR2?=
 =?utf-8?B?a3dsZWd4NC9wdFEvVk1tY0VtT3pmT0xHUVJuTVpFREI0ZkI2TzRER25iK0I3?=
 =?utf-8?B?bU9aZi9QODVlMURYSGtaQVlMTTdpeWNoWExyRkNoeVNXUzhJelg5TkZ5U25K?=
 =?utf-8?B?eGx4ZWFBOXdwOTRaZWlkRWVyakRxNlliakVkd1pVb2FwM3JMSU5jK2phWHQy?=
 =?utf-8?B?TjNySGFFWUtid3U4TEN5YjVtYWI3Qkt2NDF3RnBoUUNHQzh4RXg5VFhJbGJj?=
 =?utf-8?B?VVRnOXFwNk1NY1M4UWp1ZWlHUG8xYnQyTHdUdFB3OHFEeTNZWHVRZlZyRFha?=
 =?utf-8?B?bUdqYmt3Zyt6VFJYN3IrckJBaXZoL3AycHY1ZlR1alY3VGdYRTVPeFpEdy9a?=
 =?utf-8?B?akZQTUZpOTNjaitsQVJINU1uT0lDWHpNaUZ4MDFzYS92TzNkMTFyWGNoOEQ4?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353fc947-1670-4e19-f638-08dc48b14709
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:42:21.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt6PHVhl3VD4PHtVohj5u9mb9SPBEXubn+t3cn1bKdv846LQnJTj68/Wbv0tn5F4rHDyJmw7fjAthpzIyG51aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3696

On 14.03.24 14:19, Fabian Scheler wrote:
> The testcase ensures that the correct handling of priority boosts in a nested
> priority-inheritance scenario in a multi-core environment by assigning different
> threads to different cores if this is possible. On single-core targets all
> threads are assigned to the same core. In contrast to protect_nesting_protect
> and protect_nesting_pi only priority-inheritance is involved here.
> 
> For more details please refer to the detailed comment before
> pi_nesting_contend_multicore.
> 
> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
> ---
>  testsuite/smokey/posix-mutex/posix-mutex.c | 303 ++++++++++++++++++++-
>  1 file changed, 296 insertions(+), 7 deletions(-)
> 
> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
> index 4aad24964..5cca0d2a1 100644
> --- a/testsuite/smokey/posix-mutex/posix-mutex.c
> +++ b/testsuite/smokey/posix-mutex/posix-mutex.c
> @@ -86,11 +86,12 @@ static int get_effective_prio(void)
>  	return stat.cprio;
>  }
>  
> -static int create_thread(pthread_t *tid, int policy, int prio,
> +static int create_thread(pthread_t *tid, int policy, int prio, int cpu,
>  			 void *(*thread)(void *), void *arg)
>  {
>  	struct sched_param param;
>  	pthread_attr_t thattr;
> +	cpu_set_t cpuset;
>  	int ret;
>  
>  	pthread_attr_init(&thattr);
> @@ -99,6 +100,16 @@ static int create_thread(pthread_t *tid, int policy, int prio,
>  	pthread_attr_setschedparam(&thattr, &param);
>  	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
>  
> +	if (cpu != -1) {
> +		CPU_ZERO(&cpuset);
> +		CPU_SET(cpu, &cpuset);
> +
> +		if (!__T(ret, pthread_attr_setaffinity_np(&thattr,
> +							  sizeof(cpu_set_t),
> +							  &cpuset)))
> +			return ret;
> +	}
> +
>  	if (!__T(ret, pthread_create(tid, &thattr, thread, arg)))
>  		return ret;
>  
> @@ -194,7 +205,7 @@ static int do_timed_contend(pthread_mutex_t *mutex, int prio)
>  		return ret;
>  
>  	args.mutex = mutex;
> -	ret = create_thread(&tid, SCHED_FIFO, prio,
> +	ret = create_thread(&tid, SCHED_FIFO, prio, -1,
>  			    mutex_timed_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -256,7 +267,7 @@ static int do_contend(pthread_mutex_t *mutex, int type)
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
>  	args.lock_acquired = 0;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_MEDIUM,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_MEDIUM, -1,
>  			    mutex_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -496,7 +507,7 @@ static int do_pi_contend(int prio)
>  	args.mutex = &mutex;
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
> -	ret = create_thread(&tid, SCHED_FIFO, prio,
> +	ret = create_thread(&tid, SCHED_FIFO, prio, -1,
>  			    mutex_timed_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -533,6 +544,283 @@ static int pi_contend(void)
>  	return do_pi_contend(THREAD_PRIO_HIGH);
>  }
>  
> +struct multicore_low_context {
> +	pthread_mutex_t *mutex1;
> +	pthread_mutex_t *mutex2;
> +	struct smokey_barrier *low_barrier;
> +	struct smokey_barrier *locker1_barrier;
> +	struct smokey_barrier *locker2_barrier;
> +	struct smokey_barrier *medium_barrier;
> +	int *medium_flag;
> +};
> +
> +struct multicore_mutex_locker_context {
> +	pthread_mutex_t *mutex;
> +	struct smokey_barrier *barrier;
> +};
> +
> +struct multicore_medium_context {
> +	int *flag;
> +	struct smokey_barrier *barrier;
> +};
> +
> +static void *pi_nesting_contend_multicore_low(void *arg)
> +{
> +	struct multicore_low_context *context =
> +		(struct multicore_low_context *)arg;
> +	int ret;
> +
> +	if (!__T(ret, smokey_barrier_wait(context->low_barrier)))
> +		return (void *)(long)ret;
> +
> +	if (!__T(ret, pthread_mutex_lock(context->mutex1)))
> +		return (void *)(long)ret;
> +
> +	if (!__T(ret, pthread_mutex_lock(context->mutex2)))
> +		return (void *)(long)ret;
> +
> +	smokey_barrier_release(context->locker1_barrier);
> +	smokey_barrier_release(context->locker2_barrier);
> +	smokey_barrier_release(context->medium_barrier);
> +
> +	if (!__T(ret, pthread_mutex_unlock(context->mutex1)))
> +		return (void *)(long)ret;
> +
> +	if (!__Tassert(*(context->medium_flag) == 0))
> +		return (void *)(long)-10;
> +
> +	if (!__T(ret, pthread_mutex_unlock(context->mutex2)))
> +		return (void *)(long)ret;
> +
> +	if (!__Tassert(*(context->medium_flag) == 1))
> +		return (void *)(long)-20;
> +
> +	return NULL;
> +}
> +
> +static void *pi_nesting_contend_multicore_mutex_locker(void *arg)
> +{
> +	struct multicore_mutex_locker_context *context =
> +		(struct multicore_mutex_locker_context *)arg;
> +	int ret;
> +
> +	if (!__T(ret, smokey_barrier_wait(context->barrier)))
> +		return (void *)(long)ret;
> +
> +	if (!__T(ret, pthread_mutex_lock(context->mutex)))
> +		return (void *)(long)ret;
> +
> +	if (!__T(ret, pthread_mutex_unlock(context->mutex)))
> +		return (void *)(long)ret;
> +
> +	return NULL;
> +}
> +
> +static void *pi_nesting_contend_multicore_medium(void *arg)
> +{
> +	struct multicore_medium_context *context =
> +		(struct multicore_medium_context *)arg;
> +	int ret;
> +
> +	if (!__T(ret, smokey_barrier_wait(context->barrier)))
> +		return (void *)(long)ret;
> +
> +	*(context->flag) = 1;
> +
> +	return NULL;
> +}
> +
> +static int pi_nesting_contend_multicore_getcpu(cpu_set_t *rt_cpus,
> +					       cpu_set_t *online_cpus,
> +					       int num_cpus, int start_cpu)
> +{
> +	int tmp_cpu = start_cpu;
> +	int result_cpu = 0;
> +	do {
> +		result_cpu = ++tmp_cpu % num_cpus;
> +		if (result_cpu == start_cpu) {
> +			break;
> +		}
> +	} while (CPU_ISSET(tmp_cpu, rt_cpus) == 0 ||
> +		 CPU_ISSET(tmp_cpu, online_cpus));
> +
> +	return result_cpu;
> +}
> +
> +/*
> + * This testcase exercises a nested priority-inheritance-scenario preventing
> + * uncrontrolled prioritoty-inversion caused by a thread with a medium
> + * priority.
> + *
> + * In this test there are four threads involved:
> + *
> + * - low (prio THREAD_PRIO_LOW): holds mutexes mutex1 and mutex2
> + * - locker1 (prio THREAD_PRIO_HIGH): blocked by mutex1
> + * - locker2 (prio THREAD_PRIO_VERY_HIGH): blocked by mutex2
> + * - medium (prio THREAD_PRIO_MEDIUM): "tries" to preempt low
> + *
> + * The test ensures that the priority of the low-prio thread is correctly
> + * restored when it unlocks the pi-mutex and thus is deboosted. This test also
> + * checks this behavior in a multi-core environment by assigning different
> + * threads to different cores if this is possible. If only a single core is
> + * available, all threads are assigned to that core, i.e. the test also works on
> + * single-core targets.
> + *
> + * The threads are allocated to processor cores as follows:
> + * - low & medium: same core => low_medium_cpu, this is necessary, otherwise
> + *   medium could not prevent low from running
> + * - locker1: locker1_cpu != low_medium_cpu if possible
> + * - locker2: locker2_cpu != low_medium_cpu && locker1_cpu != locker2_cpu if possible
> + *
> + * (rough) execution sequence:
> + * 1.  setup test
> + * 2.  unblock thread low
> + * 3.  low: lock mutex1 and mutex2
> + * 4.  low: unblock locker1, locker2 and medium (in that order)
> + * 5.  locker1 and locker2: block when locking mutex1 and mutex2 respectively
> + * 6.  medium: blocked by low due to priority inheritance
> + * 7.  low: unlock mutex1 => locker1 can finish, medium => still blocked
> + * 8.  low: unlock mutex2 => locker2 can finish
> + * 9.  medium: run to completion
> + * 10. low: run to completion
> + */
> +static int pi_nesting_contend_multicore(void)
> +{
> +	struct multicore_mutex_locker_context locker1_args, locker2_args;
> +	int cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
> +	struct smokey_barrier locker1_barrier, locker2_barrier;
> +	struct smokey_barrier low_barrier, medium_barrier;
> +	struct multicore_medium_context medium_args;
> +	pthread_t low, locker1, locker2, medium;
> +	struct multicore_low_context low_args;
> +	pthread_mutex_t mutex1, mutex2;
> +	cpu_set_t rt_cpus, online_cpus;
> +	int medium_flag = 0;
> +	void *status;
> +	int ret;
> +
> +	/* setup test */
> +
> +	cpu = get_current_cpu();
> +
> +	num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +
> +	if (!__T(ret, get_realtime_cpu_set(&rt_cpus)))
> +		return ret;
> +
> +	if (!__T(ret, get_online_cpu_set(&online_cpus)))
> +		return ret;
> +
> +	low_medium_cpu = pi_nesting_contend_multicore_getcpu(
> +		&rt_cpus, &online_cpus, num_cpus, cpu);
> +	locker1_cpu = pi_nesting_contend_multicore_getcpu(
> +		&rt_cpus, &online_cpus, num_cpus, low_medium_cpu);
> +	locker2_cpu = pi_nesting_contend_multicore_getcpu(
> +		&rt_cpus, &online_cpus, num_cpus, locker1_cpu);
> +
> +	if (!__T(ret, smokey_barrier_init(&low_barrier)))
> +		return ret;
> +
> +	if (!__T(ret, smokey_barrier_init(&locker1_barrier)))
> +		return ret;
> +
> +	if (!__T(ret, smokey_barrier_init(&locker2_barrier)))
> +		return ret;
> +
> +	if (!__T(ret, smokey_barrier_init(&medium_barrier)))
> +		return ret;
> +
> +	ret = do_init_mutex(&mutex1, PTHREAD_MUTEX_NORMAL,
> +			    PTHREAD_PRIO_INHERIT);
> +	if (ret)
> +		return ret;
> +
> +	ret = do_init_mutex(&mutex2, PTHREAD_MUTEX_NORMAL,
> +			    PTHREAD_PRIO_INHERIT);
> +	if (ret)
> +		return ret;
> +
> +	low_args.mutex1 = &mutex1;
> +	low_args.mutex2 = &mutex2;
> +	low_args.low_barrier = &low_barrier;
> +	low_args.locker1_barrier = &locker1_barrier;
> +	low_args.locker2_barrier = &locker2_barrier;
> +	low_args.medium_barrier = &medium_barrier;
> +	low_args.medium_flag = &medium_flag;
> +
> +	locker1_args.mutex = &mutex1;
> +	locker1_args.barrier = &locker1_barrier;
> +
> +	locker2_args.mutex = &mutex2;
> +	locker2_args.barrier = &locker2_barrier;
> +
> +	medium_args.barrier = &medium_barrier;
> +	medium_args.flag = &medium_flag;
> +
> +	if (!__T(ret, create_thread(
> +			      &low, SCHED_FIFO, THREAD_PRIO_LOW, low_medium_cpu,
> +			      pi_nesting_contend_multicore_low, &low_args)))
> +		return ret;
> +
> +	if (!__T(ret, create_thread(&locker1, SCHED_FIFO, THREAD_PRIO_HIGH,
> +				    locker1_cpu,
> +				    pi_nesting_contend_multicore_mutex_locker,
> +				    &locker1_args)))
> +		return ret;
> +
> +	if (!__T(ret, create_thread(&locker2, SCHED_FIFO, THREAD_PRIO_VERY_HIGH,
> +				    locker2_cpu,
> +				    pi_nesting_contend_multicore_mutex_locker,
> +				    &locker2_args)))
> +		return ret;
> +
> +	if (!__T(ret, create_thread(&medium, SCHED_FIFO, THREAD_PRIO_MEDIUM,
> +				    low_medium_cpu,
> +				    pi_nesting_contend_multicore_medium,
> +				    &medium_args)))
> +		return ret;
> +
> +	/* start test */
> +
> +	smokey_barrier_release(&low_barrier);
> +
> +	/* wait for threads to finish */
> +
> +	if (!__T(ret, pthread_join(low, &status)))
> +		return ret;
> +	if (!__Tassert(status == NULL))
> +		return -EINVAL;
> +
> +	if (!__T(ret, pthread_join(locker1, &status)))
> +		return ret;
> +	if (!__Tassert(status == NULL))
> +		return -EINVAL;
> +
> +	if (!__T(ret, pthread_join(locker2, &status)))
> +		return ret;
> +	if (!__Tassert(status == NULL))
> +		return -EINVAL;
> +
> +	if (!__T(ret, pthread_join(medium, &status)))
> +		return ret;
> +	if (!__Tassert(status == NULL))
> +		return -EINVAL;
> +
> +	/* cleanup test */
> +
> +	smokey_barrier_destroy(&low_barrier);
> +	smokey_barrier_destroy(&locker1_barrier);
> +	smokey_barrier_destroy(&locker2_barrier);
> +	smokey_barrier_destroy(&medium_barrier);
> +
> +	if (!__T(ret, pthread_mutex_destroy(&mutex1)))
> +		return ret;
> +	if (!__T(ret, pthread_mutex_destroy(&mutex2)))
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static void *mutex_locker_steal(void *arg)
>  {
>  	struct locker_context *p = arg;
> @@ -572,7 +860,7 @@ static int do_steal(int may_steal)
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
>  	args.lock_acquired = 0;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
>  			    mutex_locker_steal, &args);
>  	if (ret)
>  		return ret;
> @@ -974,7 +1262,7 @@ static int protect_handover(void)
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
>  	args.lock_acquired = 0;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
>  			    mutex_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -1040,7 +1328,7 @@ static int check_timedlock_abstime_validation(void)
>  	 * validate the (invalid) timeout
>  	 */
>  	args.mutex = &mutex;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
>  			    mutex_timed_locker_inv_timeout, &args);
>  
>  	if (ret)
> @@ -1114,6 +1402,7 @@ static int run_posix_mutex(struct smokey_test *t, int argc, char *const argv[])
>  	do_test(timed_contend, MAX_100_MS);
>  	do_test(weak_mode_switch, MAX_100_MS);
>  	do_test(pi_contend, MAX_100_MS);
> +	do_test(pi_nesting_contend_multicore, MAX_100_MS);
>  	do_test(steal, MAX_100_MS);
>  	do_test(no_steal, MAX_100_MS);
>  	do_test(protect_raise, MAX_100_MS);

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

