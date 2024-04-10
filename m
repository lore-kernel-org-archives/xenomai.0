Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3D1E893
	for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746168; cv=fail; b=KvIDhMNV+hPQLT5+prdrRuM/EzgLh3xlhS1FnAWvw7fRbGtg8I8ex5+edpKNCqhpZhJAZ4YLRXdW+JAAzJuVlcKsUFuXCWf1Xaz3IcynWHCEED+2oPnxp6xmY/9ircD3C5IkC5YF3qEcP1VUxNmYY3nwS6ytnnBOpU3HltfcQu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746168; c=relaxed/simple;
	bh=sdyr7yHerTk7GGfsVWVC6iTfMDXUaXfeOPDDiLp9ljA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RyTdM2gUJByk6Yxuj26FzS7h6nfjKcUXagjHVAPAfOfigU2oI0VeTCvS0NEHQnrbtmG5ennbkDiMdtyFtkE74fo7Rvbr2UEZZh419cFIRroCHALMZjUu5nI54Pwvsd0+qUsZroFd6N/JEg/CDQVWMdDdW+gQR7RNNUI25EDejrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZuMgJ2tZ; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZuMgJ2tZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpOMLeWtLDyD63DZezOwwHJ6HtXJWw8FR2/fs1PuQZf7gHYZLuDGLsIkGZHOkKxC+ZIIPt+hi7dBVO3t2o0p+HrNq1TQel9jmW/kr7HxWvpLO1X5TbvUGOzxPiwCQZJyCAm9I4mnn9YBFG6xxVzv+w+7viUliGlvYGlIdFaZ3hYSbF0bihRHObdlJmQlIVtdIFqtkBBX+u4HeJ9u21TD9d4S1aYGoshmjieFgjcVbqdWKXBXzwPhBCktpGRgeHvqy79ZG2J/e+h3QDrwEx0cHSW4tRA+FwWIYYQ1sFpX906lW2yRI3/D86tL4MFO3HB7t+Yt8tKAPcW4ZJsdKdJXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rswoDlRLKypk23npRT5vhOCd+7kk0AXitl8SsDDogR4=;
 b=V26QmY1pKe/1HgIiued88dp/zfV8HehqcGojYTQcZCfjZTru7bpFeg4Nqw9hokvR3N+qckIbti8HvqcZQZj4ROAQ7btvXiD9yVTJEvEsVjAqnoYeTaV/D5J1EnihPhUJHtFPJuDS2TTbPT/RCNynzGAtsFRpo9vUdT9QbEmaQueRLv+8YrFTpi7OZom3ga2XmuINIV1jZfGYKbxYiyj0kQ9z28UjLiHUxtvcHpKtIFqOgFbLEn/wXek2hHbR/D4x3b+pRficicfJrF6LzMVIAVUbtz2WA58W1LVQiBWqsMVD06JbrIo1ycXKDdpjfLPNNUrpIicsdnSZW/xVkI73aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rswoDlRLKypk23npRT5vhOCd+7kk0AXitl8SsDDogR4=;
 b=ZuMgJ2tZ1NDNYT3Ui/WWySPCjPt4GiCkuaBU3qLfpEYQHp4TZ1bHE+y+nguzN6FM181s9Oc5TjJwNP9kUgsJurrP/Bc4vH2PBa8rO7/vBqIZ+D/BG9jW7N0NzlAvnFkMc68kKtExQlLdI9JO2fdiMQ6G9prL/gSKw42D8b8sDoWUZWFmoMG54B4U8xtdPuSqE5NoZKqQnG60t8EL0vJMgRGL3gzQTufO2d1qjqcsypRe2ZxWw9yACutUbiQSbGLwM+K8iOFuZItjG5ZvoxoWwP8doL3FsfjUcm4rqrrU82Gh81ZPMFvThsj8pqocwWC7kaKEhTvYl3ltHd3N7qur8w==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 10:49:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 10:49:22 +0000
Message-ID: <2a1c8a5a-5ebb-4195-b986-7ac1ed849a9b@siemens.com>
Date: Wed, 10 Apr 2024 12:49:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with rt_task_set_affinity() in combination with
 xenomai.supported_cpus
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <2fc736948068580213268be9548154799b5c8633.camel@siemens.com>
 <aab40d57-cd36-419d-ad04-5700cbef9d94@siemens.com>
 <2315a45d9328c17bd9d7be36c0755bcb4f297744.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <2315a45d9328c17bd9d7be36c0755bcb4f297744.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HqGsGEiQ6KbzrJ5Irw8Cm6i0qgTJ9UF5LSN/e6vquaOa+jg7m4QAEbS0/BO0HC/ElMkhsCyGoUybnZf0EEs748JyZ2EilX6Lv6zO9Fv7Rx/05dgsD0MV7Wp5bHx7Q6V+2N1xR3TkeC/vHdyK7w43JzOw1to6ec80PKuHvfNFm67Zualg+CGZ5c8xF8RuJapvZXXbFd6l6gpbVdxmcz1tBPS5K0FgidIzbpT+D06r87vRAzB7h8MQ/ZGfvbP2l2mM0H57Od8USZxm7AN17U2zC6yCLUm8Kp2b/Ymd0LgnQK0EDMr6qsyPcNvJslxkzzTLw0zKsK5/dhClqDfWil3p+yQ1nRxE+/IEUPrhe4MPyYInzPbEsSW/3PYzedd+0kceJoxAtoblJT2EZzzARPQk4/HoGcZIdp0PF1Gya/hXQKxoD96gmJUd2WG1yoYyycEfVhfT74rJsZHv8EU1jU5ScSdzPIWuor8tDrBBbgTOYsgLHA9aNiFSKLGWmnqvUg0l0CYwtWmZMeWY84uru+m0h07FXcOq9MUzDC+tJiS3l1bsRiKDFT3MGtNCc76NevuXx2d4OHOdyo/4Xq1bZPzdijz0Ib4QjdmRO7JO2RPHAgNlozvU8hPQl+pQQGMLefr8IvLw7QQ8SR0ifP6AzRK5SE2ZxsCAIQXYuGI1fSuencI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjlvbGJKMElxUzk2OXZTQU9VMTNEcVdrV2p6MFVoMS9mQW4vcDV5dks3a0xx?=
 =?utf-8?B?b1ZmdmloOGRLVWU2UGFVc1FwckVvbFo5dENYSnZ0aVd2WDJ6a0dqRmYxRDhq?=
 =?utf-8?B?YkEyaDd3L01GbXE1MjI1cVJ6M3hPWWNoWTk3MnhmbERFVk1lR0F6Sk9aMVFK?=
 =?utf-8?B?YVdPY1NEMHJrRjhzRklZay92QnEvZFBaQnlQSTFjakFTSnEvbkRNS01yMUhx?=
 =?utf-8?B?bWtIZG5ac0h1Vm5UbVdsNnliUkdlZjgyVktDWlE0VWY5Z1QzbjlEdVN2TnNT?=
 =?utf-8?B?TlNncEN0bkFKbjY2WW9TVzVVazZ0UnlEOWJhRVZzRjM5NlJCbmlIZjlDWnJU?=
 =?utf-8?B?KzZaa2hZRndmVjN5WVVwSkliM0pTemhwMTdoZnRTalUxTTJHNDF4Q245SU0r?=
 =?utf-8?B?VGIyMWtiMEhJeHpVMU9iRk9hTGRDRjhSU244NDVodWZZQVJoOWNRbEJKdmNa?=
 =?utf-8?B?NTh4eU96ekJGajdTUWcvSDgrY3ZnQjRIRElxcFcyMk1NazJOdS9EZGZLa2p5?=
 =?utf-8?B?ZHZnMHROUGRBQ2x0YkZqaWphakVaVm5yUUVQOHdvZWEyQXlLNmJDa2VZOFFT?=
 =?utf-8?B?cXRuMk1WTStaU28wRXJRaFZsSS9iRjZhUElDM0dUNXZpaXdRK2Z3STlrblRx?=
 =?utf-8?B?Uys0M0xGZmxPdmdwMzZSUC9IQUhjenkyWGcxWTN3ZDRIaWo1eTA1U1VuOWg5?=
 =?utf-8?B?WFZmVFhRUjg5cUk3ODF0bFRMa3VtbzJuSXBBQktNY0twQ2ZpYm1sQk1vakRD?=
 =?utf-8?B?am95dG03WVdEQzBwUzZlVVJ3K2h6dU9WWHZrdVZXSitIZERrd1YvaEs4Umls?=
 =?utf-8?B?elRVZFJXUU9EVFM2NWtVOWk0QW8wRisxMkxBbFBiSmlmWVlqTGRmcXpDcmFJ?=
 =?utf-8?B?emNYWHFvclVycDBXVTZzMUpOZCtpUkdaMmxqajV4NmhZeEN0Wlg0ZHZjV0tr?=
 =?utf-8?B?eUFHbVhCNlFTQ29jbUxwc2dvZjZXeHhPRWc0K0JIYzJNWklUMkJJSWVhZjNC?=
 =?utf-8?B?RXdGSzZRY2Z1VWh2bUgxNys4UW9SVXRoeWNaOGxGKzhMeXNKRitaaVZ5WjU2?=
 =?utf-8?B?bGRDdnJ0cEFYbDdTcGpZY0ZFRFhDZkJId3FpTlpRL2thT0RIUjl3aTQzU3BZ?=
 =?utf-8?B?dWF2TXE0UmtMYjNFeG1CVXJuR0syREtEYXRxbTdCL3IzMmwwWFQ5V1FWKzBC?=
 =?utf-8?B?MjNiT09wVHMwRkJzNWJLZ3BXdTY4MEFBK1N5TEVGeSs2UEhnT095dy9jY29E?=
 =?utf-8?B?M3VyU3VRWXFVbTNBWjZ4UnFuWnZ2R0x6c01FWmFoNWx0SU5NbVpidm5sSlpn?=
 =?utf-8?B?UFo2czFTaDdEQ2liOW5ZeFRaWFlIN3N0eUpNOWE5c3ZDTVZ1MWkrOXBTL0VH?=
 =?utf-8?B?VnpPWjR5WCtkTVRkaUNHVnBxQzF5OWNYZXIzR0hSSjRFdjF2VU03VlB1Y01i?=
 =?utf-8?B?V2tvSUJPMkI4b1hNU0lEc3VvcmdiUE9FT3VDQ0I1a3FvOWRwakFwbFFiWDIy?=
 =?utf-8?B?MVNYRkZHaWxjbHBvQXgvcVpjNmhlQUQ1bGd2bEsxTmVWVUhHZlg4VVdWY3hy?=
 =?utf-8?B?cldVLzBST3BGN3orcUpzVXpOcGlMNDlkSUtwR3FWUStJSDBMd0xpVVdjUW1k?=
 =?utf-8?B?MGZIWjlscEJCN0E5V0JHZTRhMmZGOFVXczJpVmFBeHlMYnp3V0VVS3ZHZXZr?=
 =?utf-8?B?Ny9KT2MwQWxrdlRNbk5rOFMybGd5eWJkWTN3dnVsM2RyeTZVY0JVR2RkVUpV?=
 =?utf-8?B?cWtnY2ZZUVBWLzJCeXhucHFqSlg2SVZsU0J4VG5OOVlrdEY3VXM0aHY1TkZk?=
 =?utf-8?B?ek1XZWYrdE1MeHNHamdxU1pYYnk3c0lqVVpqTjlVWXIrSUJ6blZoMEF0NzNj?=
 =?utf-8?B?ZDZHSllSY0NRcXFSbVBaNE1IcmlhcXVlcC9zQ3lGTTh3dWFXNHM0T3lmQVBJ?=
 =?utf-8?B?Q3VoOUcwL3E1b2xmTFlNSVo2WGtTRXF4eHlScmNTektxcUlINUtNaS9qTVQ5?=
 =?utf-8?B?c0tEUVdZN3JDU1NtRm5ZWVhBVDJKS0dlem51czFQRUh6ZTA3YTR5U3JKb3lm?=
 =?utf-8?B?d3FJRjZlbFQ1M2MxTjdndjFjTmtMWjBKTENuUHBZcHhQRkRXWXJpcHM2R0ZK?=
 =?utf-8?Q?1nq4Fk+IDs1d/s+r+Lra7fAYM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cbc359-8666-4999-11a0-08dc594be169
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:49:21.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7br49bSsp2+8V2MhvKX235oFCpvDvQPgTqBYvz400zOSbpbXQC2rm+zKTCSjJFDqG1OBdlicGba0Xdc8YS6MXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863

On 10.04.24 12:09, Florian Bezdeka wrote:
> On Tue, 2024-04-09 at 19:13 +0200, Jan Kiszka wrote:
>> On 09.04.24 13:56, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> while looking into recent bug reports we were facing a situation where
>>> we were seeing completely different behavior of provided test
>>> applications / reproducers than the original reporter.
>>>
>>> It turned out that reproducers were assuming that specific CPUs are
>>> allowed to run Xenomai applications, which was not the case. The
>>> cmdline parameter xenomai.supported_cpus=0x3 (= allow the first 2 CPUs
>>> to serve RT tasks) was used here to shrink the set of CPUs that are
>>> allowed to run RT tasks.
>>>
>>> Example (out of my head), error handling ignored:
>>>
>>> void rt_main(void *arg)
>>> {
>>> 	// do RT stuff
>>> }
>>>
>>> main()
>>> {
>>> 	RT_TASK demo_task;
>>> 	cpu_set_t mask;
>>> 	int ret;
>>>
>>> 	CPU_ZERO(&mask);
>>> 	CPU_SET(3, &mask); // Assumption: CPU 3 is allowed to run
>>> 	                   // RT tasks
>>>
>>> 	rt_task_create(&demo_task, "demo", 0, 50, 0);
>>>
>>> 	rt_task_set_affinity(&demo_task, &mask);
>>>
>>> 	rt_task_start(&demo_task, &rt_main, 0);
>>> }
>>>
>>> rt_task_set_affinity() does not report any error in case the supplied
>>> CPU mask is "invalid" in terms of "there is no usable CPU available".
>>> If an invalid affinity was set rt_task_start() will block forever.
>>
>> But the task was already created, is only waiting for the kick-off by
>> rt_task_start. What happens to it?
> 
> The thread is canceled inside the wakeup path to the primary domain: 
> 
> [510675.581142] [Xenomai] thread demo[1570] switched to non-rt CPU3, aborted.
> 
> The caller of rt_task_create() will block forever:
> 
> #0  0xf7fc7579 in __kernel_vsyscall ()
> #1  0xf7e544e7 in syscall () from /lib/i386-linux-gnu/libc.so.6
> #2  0xf7f74791 in do_sc_cond_wait_prologue (cnd=0xf746b82c, mx=0xf746b758, 
>     err=0xffffd9a4, timed=0, abstime=0x0) at cond.c:243
> #3  0xf7f74915 in __cobalt_pthread_cond_wait (cond=0xf746b82c, 
>     mutex=0xf746b758) at cond.c:329
> #4  0xf7f9db5a in threadobj_cond_wait (cond=0xf746b82c, lock=0xf746b758)
>     at ../../include/copperplate/threadobj.h:572
> #5  0xf7f9e9a8 in wait_on_barrier (thobj=0xf746b750, mask=16)
>     at threadobj.c:1237
> #6  0xf7f9ea92 in threadobj_start (thobj=0xf746b750) at threadobj.c:1274
> #7  0xf7fb2464 in rt_task_start (task=0xffffdb60, entry=0x5655647a <rt_main>, 
>     arg=0x0) at task.c:644
> #8  0x565565b1 in main ()
> 
>>
>>>
>>> How should the application know that the affinity is invalid?
>>>
>>> My current understanding is that the there is no hook (provided by
>>> dovetail) that would allow intersecting the sched_setaffinity() call
>>> that is used at the end.
>>>
>>> Should we implement such a hook? Is there something that I missed?
>>>
>>
>> We could check the mask from userspace in libalchemy. That would remain
>> racy, though, as the set of supported CPUs could still change after
>> set_affinity and before start.
>>
>> Do we only have the problem in libalchemy due to its split create/start
>> pattern?
> 
> AFAICT this is a general issue, not limited to the alchemy skin. We
> never intercept sched_setaffinity(), so it's basically a pure Linux
> API.
> 
> I would say - as it is a pure Linux API - that we can not validate
> affinities regarding Xenomai supported CPUs. We could implement
> something for the alchemy skin, but the POSIX skin would need an
> additional wrapper.
> 
> We have /proc/xenomai/affinity, that might be useful. Not sure if we
> can read that without triggering a Linux migration. IMHO, validation on
> kernel side would be better. At least it would avoid one more wrapper.

Not an issue: sched_setaffinity & Co. are not intercepted, so those are
causing a migration anyway.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

