Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4955E73
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240286; cv=fail; b=Zoy4trlYvAgTpdPcnAM71I4qzla8hAF/BwDqusCYI46AAWwkb9fPQvPc8O0BbwCvl2aldKZNd4rj4c9+0UpMSxCmca4qISqOH/EYFYp5Q/6roftYyQbNB03KqPkgw2RxUvwjghrCCxsSMdGzSRNlJe5vq2otsvXnmSw3Uy+m/B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240286; c=relaxed/simple;
	bh=oHpm5KrZfwrfCks+R9L4A4bcR/EqqIjt9abLT+EnJO4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dMC0/gz6amX3CWxXxdN1pwACkPBdVDX7aojyb5q72NJmV5RTiM0nA46X8MRaAYzT2dIWCVcoRjdUl9jz2JIutfWEFh9yYHOOdhBeIdap9doHoisuYy83gWvG2nKaLDsyGfSggjezt2rakgDvRsv4XLxqwySZJZTQYkuDcFnUC7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mTpZo47q; arc=fail smtp.client-ip=40.107.13.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mTpZo47q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMhrl6gwC+L3sqJefd+Qr3oC55Nicd4oeUEaiQPCuxhBlY21AEN0hXls/Dw1VXRa1OdlGA+CenlSgJ/bCDLYyMXuj2gj1sycrOBwI0hO5grf+AUTufKp1XCHL96JKxI/+DH8DgdI1eWbwM+pGh2vi9gqJbLIrdQ18pXj9boDU/kl60BYhMh5jh5fFibgcdzsD+PFaNE8YE7kj4DJEcimYyzrDK7YNbpQWK+puTadSrRT1+5xTDVG5W2J9S+6A0YS8viPZT4lQV7cQ3yRjsWXEcrK55tojd7gRGWTrpcx7YAJ7nV+4oSLw7mBa/vO54W7McfkLAnaIVUBK+jPyqs5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQivM6HQgpgYH3opUqSfEx9PD1l7cbUonNYDagYmKHQ=;
 b=d3qogUqSGOljdhpxk3oD7BguqQKxIhKo+PdAkjeVOJeCR89P4sj7fcGm4P3tcg7oytsNF00nDiDCzfFtCda5J8CPW78AYI/Y12Md64QIE0XThmXZU82tQMzxa7hGT9s7zZ0hxYAH8MXmCcZKtq3l8noNOS5gAkSj+HxtY/UYE6/gJT37tW3BzENJvundAGb5raFCCv+bE4Do5sLsHKwuWAvciX4l7e3C2xdVAHmmNCx/1YETdfd/VH+IJgJfhTSYy/EyEefEvFuKaTsBBZ/etAhQm8z6/YDoeaWojL3SuF5BoLzBytXjSFBvj1Wt+vP98HpjnU6Mby6Ao8mJpkNTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQivM6HQgpgYH3opUqSfEx9PD1l7cbUonNYDagYmKHQ=;
 b=mTpZo47qbzVRCQjDn5KNRZWmDruDziX1QQyBakExRSZfH8ttXQrnk7zrB5KkHmoPyarMvnzP+5PbvrfqyMGYcgcnIvplV4jQZ6lunIBDxq8aIbKkWCKoQ2IZFhDx/8/49iX8len5/6v+7MQIQTN76hlgRwzlSKIZa1wKGdag6IXwo3oAqqCqv5hksfgMoNJv9Yq62nSWv2FBdNFc/SuWMpfVy08fnzwufr5RQJPT47sbCQdyQZ/u38Rb2QZdMG+Mhm/uhbXaIkT2RQNIP7cmJGPgjqCbZhIhYPoGu/MgRje71ELR/4VSgmLUU2zcucv8q1wLZJn91ULkjBCIMxyRHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 10:44:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 10:44:38 +0000
Message-ID: <df16b465-e1b3-4783-ab0d-749bbdc0f802@siemens.com>
Date: Tue, 12 Mar 2024 11:44:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite: smokey - new testcase
 pi_nesting_contend_multicore
Content-Language: en-US
To: Fabian Scheler <Fabian.Scheler@siemens.com>, xenomai@lists.linux.dev
References: <20240312072341.27967-1-Fabian.Scheler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240312072341.27967-1-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3135:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b96ab56-d8e9-42bd-53ee-08dc42816a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/gY5dgQLveUrSD+EtOEGMUEb7pIcPcO4+8MPpPTmhQJoI1sG1RcaDzmjmNx9Rkn/lWy9j2YF9+gViRoRl2XpcQq2f7DT9tnrG2Ohz2OAhnlUI/cM7muh4mUR1nLmOTrTcKwGmHnS5W/GRjQfSLA4JK1ftOSJkOcS0M4Wen/Ouakc46ExuzNb3q6MsiZBvSrlsEOpHyfecGMST5rKlMMQtbGmqoZ5A494P0HTFmdZa9MtFUBK3wVOmzVBttDESqWFRd6AwPR5NQoO/c3d6Iax3RX0gTELrA4tXRCjIZgZntmEUsMVB8gs3l9BvzAdeOVEwCWGT+DSZmmz5Jg/o1c+otXv3YHNduP2+ZDXlH04GQaO3LLrlZtwpVh7tx/sTMNDia0epB9FQ/G+0e85Nmggnyy+i7QwaT2JfX1uUx0VgLum2dwudze7JetJxEqeVmsJ1a44C9HDhk0Tin7AUfNglE8LtTkW1MiqgpQT+7nEvZ2TLrc4uLpgFaQbiuJfXeCYnChKh62FREmyDqv8gJ4seubW3Lo2iibd4Y27W2zmBgmb0laEk24SEu5X8lsFKL0LBet2szt5FnCyuQdhPOfz0bcHD8oA/F01XGi7VyxTdfnJxIhH5qQJ7+/EFMDcfO55HCv5vC5k2rWLLHLJ6EYrdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cktPeWhwOEZVZmVQbkZyWnlQQjJ0SThBdjltbE5QNkpJYk51ZXJENkVZTkVO?=
 =?utf-8?B?cFVTS09YOXZ0R1QrdjVuemU3LzdoeG1XNzhEd1RUekFvMEVYSk9JaHdhdmhJ?=
 =?utf-8?B?dnRpUkYyakNMMmgydVk0ZjhmQTVCektaeWNKenhHcFhCYjFGUVJmNXppQ0t6?=
 =?utf-8?B?dStuL2NiTDBOZElpR3JGQUdpUDNJVDlndWFYa1RGbVVuK1J1Sm9ZMXJhWGlr?=
 =?utf-8?B?TVI5WkxsYzdSWElyWUNTQlQyOU5Da3k4MHY2aS9hSU13Qzhmb3FURDQrUEJT?=
 =?utf-8?B?Njl4TEtmV3lDUzFZZ1YyZkxhSnZUQzFXMHR5YkY1TlM5b0pzM3d5TWpZK1Mw?=
 =?utf-8?B?d3k0THlpMzVJY2hLb0FNamdjUUdyejNONlJVbXpabmNWRU0zZkI2OUVNejlu?=
 =?utf-8?B?N00zUWZ5akVzSFBBcXo4d0ltY002dkIzYlNTbzVnN292QVhqcEtKMXdINDZa?=
 =?utf-8?B?UDl2UW4wMzhWUDllQkFaUjhIdStqc3dUeVlmRjhSbW1rQmlhSnh2ei84RXlZ?=
 =?utf-8?B?aEJOSFV5dEdnVEJnamg2UlJ6YWRoY2V3SmRjT0h5WXlkVHloeDVYZ3A5WXVq?=
 =?utf-8?B?d2VUNGYxK3JLUjNVODBhVjFnbFFYZ3V4V09lUWdMbFZ4T2R2REFneE9JY3Br?=
 =?utf-8?B?aHF6UWU1Wnc4M0NnNnY2QllVSm1Xb01vbXpJYzMwZEhpNDRoOU1OK3VVR0N4?=
 =?utf-8?B?UEN0djdDUDh6YUxZcmJldUx6VTZhZVBuRS9idFpDYzNyYkRwempXY3Y3OG9R?=
 =?utf-8?B?M2tQanNSa0RZM2RINFZ4MUdFQXZOSjRGdkpxUjN0aWl4bTA3UGpLMm9uK25w?=
 =?utf-8?B?eU1kajV0ODJmTWJGdlowaUdxYVg1MGQ1cVQyR0xaZWgwK2RKYUdYTzB3RlM5?=
 =?utf-8?B?aU1LaU9kamIrS3hDRXRGUE9NbVZjQmtCRWc2UHBhTENLTnpZRFk0bitsSEEy?=
 =?utf-8?B?dG53MEZPc3RIS051d0RKTkJ3a0l5WlowSW5hd09uSUJ4VnFFbTNSNG1yN2JH?=
 =?utf-8?B?bHBhZkdLMHVobTFIbHpsRXlFVlVHdlNGa2xjejcwd1lRUWQ5R1VrdU5aai9v?=
 =?utf-8?B?a1RBSzBuZVA2SGtMc1FUQkp5ME1ZcDNUOHBQbjlmUG52VkhRNEI1clh1REhY?=
 =?utf-8?B?bG4weGxJeDFQTDhENFpsanhhOUxTV3JJOCt0ZFpiUWNUdWxrUW9qaXZpbzlR?=
 =?utf-8?B?c3Z2QzZPZUpEVXlwTnFXVnJHSlJuUHpycHdGdzBWYjA1ci9GMmY0Y2JNK1hD?=
 =?utf-8?B?UlRxYVdwaW8vZ2QvK3l2b21UV3VDbFVLbXZBQXE5MTVHZGdlUUd6UTVSZVJQ?=
 =?utf-8?B?TENnV1NrTUFkWWdHdDhSTXk2VFZKNnlXSDNQMFEyV2pvWlA4aHpFSjZ3UDhl?=
 =?utf-8?B?NXBucFh0RllPMDN2U0sxVWd3YnFuMW1zanBXc2ZCQkxydkRqNWNoNFFjR2VS?=
 =?utf-8?B?ZE9UV0hTQVJETmIvL0pYeXhQQ21LNDhpZEorZVIzcEdLa09MamkxR05MRDg2?=
 =?utf-8?B?ZytybnBJNnFFL3Ewa3F3UHBTc1hhbUhtOUtISUZLSXVUTlo2OTRTYndUSXNy?=
 =?utf-8?B?Nkh2ZmR6K2tDWUwwT2pVS3UvbVQyOS84a29iZE9NazloTkJWZkZmOSs2Rlpk?=
 =?utf-8?B?TjR5V1RXY240TFQ4d1cya21QZGpCMnhHZ3dGaGxISkRnampnUVhjVkNjMEdS?=
 =?utf-8?B?MDRpSFU2V2kzZzdxc1RYR25CQ1JxdUdtQ3NCU3k2Zmw3djVlRjBiYlJTbzYz?=
 =?utf-8?B?Q3EvaHNOMEY1Q1ZnWU1HaUhYdzhnVnBlV01TVFByTmtCUEFrcHR5b0kweDZR?=
 =?utf-8?B?WHY4UmRuak1UcDN4cDcwWjJCbncxUWJrdWo2cW5mczhqanlHR0dPbU9nWWEw?=
 =?utf-8?B?NnVYbTNNNTVkTWcrR1BQTkwzSWxUTmZYclZVaDRlNE9YdU9tRzlKN1ZxdmhY?=
 =?utf-8?B?MjZqdWEvbmRuNXVpSEcvemVISHdEVmtaSEk2SWMybjhrU2xqWm9iekl3K2cx?=
 =?utf-8?B?Ykp3RVJHRkx2YkM2VlJVT3NaRGp1K01TT0gvQ0ZRTWpFOWJnVTh6WlV5aG8y?=
 =?utf-8?B?aDRuUVU4Rk5ZQWh5cWJrNmJrRmVCNUF5S2lrZkE1VVdJY1FObGU1YkdvaWNB?=
 =?utf-8?B?elplZEJGeFlwZzU2QU5DNHU2bzgyMlkzZVpieEllYTlDTnl4aTVJU3JlaEY2?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b96ab56-d8e9-42bd-53ee-08dc42816a64
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 10:44:38.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwE10rt2KpHl61PJP++hmcNk+gCVyXWlv1rcc24vmEtRwJKGCkg6MNSCUIJX3kMoluX6ooUJzFt/Z5evbiVocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3135

On 12.03.24 08:23, Fabian Scheler wrote:
> The testcase adds checks the correct handling of priority boosts in a nested
> priroity-inheritance scenario and distributes the high-priority threads involved
> in this testcase to different cores if possible. In contrast to
> protect_nesting_protect and protect_nesting_pi only priority-inheritance is
> involved here.
> 
> The testcase implements that check as follows:
> - A low priority thread locks two mutexes initialized as pi-mutexes.
> - Two priority threads (prio high and very high) block on these mutexes, thus
>   the priority of the low priority thread is boosted.
> - A medium priority thread is started on the same core as the low priority
>   thread that must no interrupt the low priority thread as this one is running
>   on a boosted priority.
> - The low priority thread unlocks the mutexes one by one, the medium priority
>   thread must not run until all mutexes are unlocked and the low priority thread
>   falls back to its original priority.
> - The correct execution of the medium priority thread is checked by the low
>   priority thread by checking a flag that is set by the medium priority thread.
> 
> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
> ---
>  testsuite/smokey/posix-mutex/posix-mutex.c | 301 ++++++++++++++++++++-
>  1 file changed, 294 insertions(+), 7 deletions(-)
> 
> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
> index 4aad24964..08d473e41 100644
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
> @@ -99,6 +100,14 @@ static int create_thread(pthread_t *tid, int policy, int prio,
>  	pthread_attr_setschedparam(&thattr, &param);
>  	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
>  
> +	if (cpu != -1) {
> +		CPU_ZERO(&cpuset);
> +		CPU_SET(cpu, &cpuset);
> +
> +		pthread_attr_setaffinity_np(&thattr, sizeof(cpu_set_t),
> +					    &cpuset);

Intentionally ignoring any errors here?

> +	}
> +
>  	if (!__T(ret, pthread_create(tid, &thattr, thread, arg)))
>  		return ret;
>  
> @@ -194,7 +203,7 @@ static int do_timed_contend(pthread_mutex_t *mutex, int prio)
>  		return ret;
>  
>  	args.mutex = mutex;
> -	ret = create_thread(&tid, SCHED_FIFO, prio,
> +	ret = create_thread(&tid, SCHED_FIFO, prio, -1,
>  			    mutex_timed_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -256,7 +265,7 @@ static int do_contend(pthread_mutex_t *mutex, int type)
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
>  	args.lock_acquired = 0;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_MEDIUM,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_MEDIUM, -1,
>  			    mutex_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -496,7 +505,7 @@ static int do_pi_contend(int prio)
>  	args.mutex = &mutex;
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
> -	ret = create_thread(&tid, SCHED_FIFO, prio,
> +	ret = create_thread(&tid, SCHED_FIFO, prio, -1,
>  			    mutex_timed_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -533,6 +542,283 @@ static int pi_contend(void)
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

Ah, here is the explanation I was looking for in the commit message. You
don't need to duplicate all that in the commit log. Just refer to this
block on focus more on the "why we want this test".

> + *
> + * The threads are allocated to processor cores as follows:
> + * - low & medium: same core => low_medium_cpu, this is necessary, otherwise
> + *   medium could not prevent low from running
> + * - locker1: locker1_cpu != low_medium_cpu if possible
> + * - locker2: locker2_cpu != low_medium_cpu && locker1_cpu != locker2_cpu if possible
> + *
> + * (rough) exeuction sequence:

execution

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
> @@ -572,7 +858,7 @@ static int do_steal(int may_steal)
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
>  	args.lock_acquired = 0;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
>  			    mutex_locker_steal, &args);
>  	if (ret)
>  		return ret;
> @@ -974,7 +1260,7 @@ static int protect_handover(void)
>  	smokey_barrier_init(&barrier);
>  	args.barrier = &barrier;
>  	args.lock_acquired = 0;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
>  			    mutex_locker, &args);
>  	if (ret)
>  		return ret;
> @@ -1040,7 +1326,7 @@ static int check_timedlock_abstime_validation(void)
>  	 * validate the (invalid) timeout
>  	 */
>  	args.mutex = &mutex;
> -	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
> +	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
>  			    mutex_timed_locker_inv_timeout, &args);
>  
>  	if (ret)
> @@ -1114,6 +1400,7 @@ static int run_posix_mutex(struct smokey_test *t, int argc, char *const argv[])
>  	do_test(timed_contend, MAX_100_MS);
>  	do_test(weak_mode_switch, MAX_100_MS);
>  	do_test(pi_contend, MAX_100_MS);
> +	do_test(pi_nesting_contend_multicore, MAX_100_MS);
>  	do_test(steal, MAX_100_MS);
>  	do_test(no_steal, MAX_100_MS);
>  	do_test(protect_raise, MAX_100_MS);

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

