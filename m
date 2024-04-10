Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2112.outbound.protection.outlook.com [40.107.105.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D716D302
	for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757480; cv=fail; b=dWxUlaU4pPvz8whM5dDKHquraweu8BxTxndy6A47keMmVJRzUdmXFHIOgJOu6sEpOexoRpC4A517ARR7SRkHCLfkEXoPC4zXadceKsPeCiEecaxVluuQPFxx4eZI7Wb1hqgue3MOp8lsA2EJVMeizfgObq714LT9KaWop2M4Bzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757480; c=relaxed/simple;
	bh=u96XhrLXLi/49WcQw/1NSPcGftzw3Sa+UmPL6HvloGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZvuYwVZRLSvbiVub+86uXtPUaHwmX+ZgnUkO9fJW23gKXcIi7lNw9hEPM3S6fipDcVY3vSsBb1cAewUmKyPB7kqtyi5gG3xqBgzT8Cvn/5LZ7S+U+4LOKumxDwbXuVBju2fOS8oaD9D9t/dwJB0Y+/CD7uiTwJv/5oud6leYDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=L3Q/AHzF; arc=fail smtp.client-ip=40.107.105.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="L3Q/AHzF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcTKVtvRUAZLR8HEhmvfmSlPLCBHuaAEzvMYaWRBPlbL7/PEhhbMzgwXSCn5y4BXTw85zoWhNoVaUij9K6dop2xW+iXsfLoolLaFR0t/XzZo7n8HfNxGqi8hbnhakdxEpNP0Ljuk1blx98knWoYFCu+xwauwtkmP1bKET1G/Qukyg52T3wrIbYgb81ZAIsYX0QghSnA4299zUgM3sFVcHD7y5OCdsduwUMzR0qP85uDt25Uu6j81XzIRuoKCbllhByhGe9eWjKFh6YkjxAbcWrKRCX+eeN4yscLYvloGp1fiVIKussVdBtIxD8ZlHR39cIgMbnQ7zkSWjVDV2msYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qscgW69gPZtY3Z03x5GxbHb5bCTFK9PyVgQPmskupCY=;
 b=AeXwV1SG1pXoizqyTKpUIXWBrgPYN0iLExycDx3OXeO465/JuEiOeE7LS17SCxqhuh1eIjlOfrLZK2FnAjBeNyErJ3RGx1t6OHRQAB7Q714L/P0ADEiAP5rgfS7xnqJu51uls3RvhAMIspJ0FFJwnU543Hz8kjCCHXb8DiW0Af5qXfS7sfXxWqRBe7+V6Jp3av6h+y7vSPC8hyQr8lDNuXcXbilrA50PVqldOV+Ut6dA0ryhQBD12MmdOSN8uOt+sbSAXTCvcrrc+x8G/ofgiO957BWmRnkr7kMCke3iFVXufuTZ2D/Dk6srm3WCLIqSukAUbbqcy1ll5d2/KLZz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qscgW69gPZtY3Z03x5GxbHb5bCTFK9PyVgQPmskupCY=;
 b=L3Q/AHzFgh6Cz+2WAHjCj7EhJBaaMGQjH9HC79D49CTUg6t+21UW/qJQwskS9+AZd0XE4gRD52TsqiXCMBy/+hHbT0XsjBJi7ks2uOPXBXq1VWzfRjFn9+t/RFhVWZ6cD9DadnVcBFx5luWalvaotZJLTTOk3C1fWY3DN/bLvXLt1hWqF7WBA9rApSmc2avLNNxiZaNvVJp5oZGniQBTytBi2lFaoCS33l07WXbQuj4Dq8imv/S01YIil0II9hAfzwI/TO6ybpfvZdJrafAlQLIWGzzOCO2bsput9P157jfxkYDjBFlGJJfN+Jk89RQvXiPgaoDPH9LZWYQmdtoj3g==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 13:57:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 13:57:54 +0000
Message-ID: <c659e50a-f3bc-474b-b8b1-808a2c99a0f2@siemens.com>
Date: Wed, 10 Apr 2024 15:57:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with rt_task_set_affinity() in combination with
 xenomai.supported_cpus
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <2fc736948068580213268be9548154799b5c8633.camel@siemens.com>
 <aab40d57-cd36-419d-ad04-5700cbef9d94@siemens.com>
 <2315a45d9328c17bd9d7be36c0755bcb4f297744.camel@siemens.com>
 <2a1c8a5a-5ebb-4195-b986-7ac1ed849a9b@siemens.com>
 <555d1fbec426cb00fb8bc23412802df51f60bb83.camel@siemens.com>
 <0c9e4bbe6a68452f2ab6c5526609de514ebb2b3a.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <0c9e4bbe6a68452f2ab6c5526609de514ebb2b3a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6691:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EXmsWHixG0r80fhxlBr3DVBzIE/S/doVRmvPRgFxKoJMggiMW3HE7if4MgtK4WI4nXfgKF9eFgamT635pGNpP3GNrqaxTL55lmgKLTwY8Wvgv82HwiXCyo4d0cL53ztWQ48nOlGWj9B89eKAA/468xumf3YH521xFbWrejWxc+cbYP5hJ7EY+X+7+Mnj92AhyIkaG7AbClR1gwp65cjezU9WZ0jG87Kto8gLDmbGHwAUrad6CM/h862H1YlZRVRf9YDXb5T3h8ra3IuSqgqo8xXhnIbjb9W2NsHmQOBAXKWwhX7xfQuoaCWzdZmqvV41Jav4ZxAzFFrgbLaL86+NW3F+qblMIIhzEDe0YuKulGpfNF4Zzr3Iz8DMMrTAaeCp+PgYQEbjVbDIecbpMBj0BxcwckfSilfeJV7prMypcdqKGMcR5CqpLnSfUpXrpj9lXF0YZRyxNqpFtSb9v9wvS1XMgGp0eD0RfjzlAxiS/oxPUoHabltamdW/BZ2hIta2qstkN5t7WEjoPSMe4cqjovE19gqIFRSm6wSxZQqza3rUA5TwYrHQvg/aeoasecKJSjg1rgXWdIdcA//rmM5TyixsNIoW8vY3KyGXsDhLIRbYe7/StA3156pZeRxQkA33uWmsrKxrP4nwMfwqLHMrfQZ9lgRViwyS7ig2G46sbzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzVMSTVSRnZYRXFDOHU1ZFY2Uy9ZWjArTHliL3ZIZEFMMnVPWTJDS0hJczZv?=
 =?utf-8?B?MXlaSGx5bGxZNGo5VnNVTUtXOFJwNlRGNjYxbEFFemt0a1hwaktlbUNrc21v?=
 =?utf-8?B?bk1Ma0w2bjM2b01adDhBZ3ZDWXJyU1MzTGlzSlQ0d2dOYTRBb1UwN05wSGZW?=
 =?utf-8?B?QWFlUjRzYTdzbmI1Yll6NjIyOTJySGFYOStHcHlqY3BWQ1VaRHowTUFadmJu?=
 =?utf-8?B?S1IyTTl5ZUxXd2JnZUcyS2U3Y2x2N2ptcCtKRE9IT09adVlheTZhb3NXaSs1?=
 =?utf-8?B?dTIvUzJjWGJVUG9TMXNSSytsdldWVDlVUCtRN05FYXhLOFI5ekg1S1RFRHRK?=
 =?utf-8?B?UnIreGIyZTlIM3NSaXdKT3BVUHh3ZEsya09MMVcrdERnUUl6eDdaalhVVGRF?=
 =?utf-8?B?NDRaUHFMUndLWnBUTkFjcTQxRHZmVFNUSXNDczBjTEhKRFZNb1lCYmJXd3l3?=
 =?utf-8?B?UllsdGd0QzZaQWR5R2Q5OHFzemFPd0k4eHFMV3VYTjI5SW5rNXFCZDNBK0Uy?=
 =?utf-8?B?NDBkYUtSOXBvMUZLZS9yWW9LY3JDSTRaS2gwQUlYT0VGUCs2WUFEZDF4M0JG?=
 =?utf-8?B?ZXFKMU0zckVNdTc2bldMditkak9UdkF3ekhtaE1LYzFud1Z1eno0QmpmN3J6?=
 =?utf-8?B?VzNKTWF3VmtYRHZFbVFDRkowbWlwS1llWDQ1cUpkRkw0a2o4YTR2Z0k4QTBJ?=
 =?utf-8?B?MFVVaEVUaWl4Y3NvT2ZxbjhCZ2sySGJ4Y2E0QTFiTG41djZpYWFnaTQ2UkdP?=
 =?utf-8?B?TmMyY0x4cmRUSk4rZ1lNZndHUTY4cjFmbW16cnBXd2IxT0s2QVRaY0h1aHFO?=
 =?utf-8?B?dU9xS2pVMlpFRk9pSTdUblN0VXpObnp5enU3WjhEZmFZVDFBU2pCOFNvMFNx?=
 =?utf-8?B?NnByTC9iUmJsQjdPOEpEcVpiQm5RRDE4VHpCU2xEZ0RnQ09JWXpLai8rclNG?=
 =?utf-8?B?SVdaTncwV2t6YTZMT0ZjTlA2S1pXZjdnU2x2SmpmdzBUZ012WHhWdUNLQ2dj?=
 =?utf-8?B?RVoxVjBWREVlSUQrTHE4azVDV1NMQmZYR29DMXlOVDUyb044ak52dlJRanJ4?=
 =?utf-8?B?eDZGTXBDNDlLbUttVldjdWpBdDZkZDhQNzZtSkphR0l4R3EyRGZOZ3VPWjV3?=
 =?utf-8?B?TVZMaTRBRjAxZVhhejczV0xKdzlUWFFaUHNuVDRhbnEzRDQ0dzVlVWxLdDV4?=
 =?utf-8?B?aHZjMTFEVXNidkRkaElmUFBQTVFsSUp5WXVZK0RLQ3d4aU5aemxtbElPZ3Nw?=
 =?utf-8?B?UkhHTE9kVEpFOGNMUEthV1hqSkhYNStMNHVIV2d4M1ZxVmVNVkQrRmNjeXdv?=
 =?utf-8?B?QnAwMmYzdTZHMEtYdTJ1RGdsNGpUYnA4M25sV0w2cXlhZ0VlNTF4N3FPdHVt?=
 =?utf-8?B?Z3Q4TGkrTVY4OThwdUdWWnZvRWlrM3Y0VS9VRjV1bTRxTTlUNTNWMHZEbmVr?=
 =?utf-8?B?VmRFYlFiRmdYRjczZFZLK3krZk5Ic1hQVjBtYTd5cGhrdXNEOFVOYlZXV2Jj?=
 =?utf-8?B?QnM2ZVVXNWVHaVdEV1lRQ0JyaEY3ZmpUWEFnMDdxQ1hBeThpQVRiOG5vV2xm?=
 =?utf-8?B?UnpVbGRGcTJTVlFxZ0t2OHZCMEM2SjFyUTFpOVg3VWxnbjBDV2FkVjVXMkIz?=
 =?utf-8?B?bXhhVDlQR2lEOUY1Z1kzRWZDcGF4VmxjOThIbXhhbVJGWUhiTnNITVZuSWtk?=
 =?utf-8?B?RFRQRnVIazVQVGppUEFFRFI1R3lKVXhLZTlLRU5aRG9PeEtkbG5JQ1hLNExX?=
 =?utf-8?B?MkQwajQ1T1hOai9QY1lCSzBLa0dZaUY3YTg2MnQzcHlUSDhxb2hIVmt5SHpV?=
 =?utf-8?B?SGxmZmJFOHZjUFZHdk5nbWJLOTZidldFTHpWU3RnOVg2cVBZMTRuRnVxUW54?=
 =?utf-8?B?SjVvSkRVTzZFblk4bEd6OW9FNU5kUFF6NzdyeUF0M2NkUlBxQ3dIeU4wSEll?=
 =?utf-8?B?czFVNXNUV3ZrNThaNFhWQmlOaXNDRjJtRXJ3d0JIb1lwall2N3RqbkI0djg1?=
 =?utf-8?B?U1FZaHpHUEhGeDB3c3ExSDhvV1BRQTZkalV6UlVoZUQ0S1NpeVovSDJxSWNj?=
 =?utf-8?B?V1NHbWpwWWZFa0ZuNUt3bjZORHZEejM0R1BlcjBBaGtWMU1jeGZhcExROXpE?=
 =?utf-8?Q?ANFWVqYU6UDgIsDx0QjwH8A19?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714b5379-dc80-49cb-33bf-08dc5966380d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 13:57:54.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yai/KGue/Jf+sybcYfHZJsM8WPd3jzJ01W7lV0dCG4YCNqdhede9KyQE8eB7J0/5bvoDHkAsiOWrsCv+rV0z5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6691

On 10.04.24 13:59, Florian Bezdeka wrote:
> On Wed, 2024-04-10 at 13:37 +0200, Florian Bezdeka wrote:
>> On Wed, 2024-04-10 at 12:49 +0200, Jan Kiszka wrote:
>>> On 10.04.24 12:09, Florian Bezdeka wrote:
>>>> On Tue, 2024-04-09 at 19:13 +0200, Jan Kiszka wrote:
>>>>> On 09.04.24 13:56, Florian Bezdeka wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> while looking into recent bug reports we were facing a situation where
>>>>>> we were seeing completely different behavior of provided test
>>>>>> applications / reproducers than the original reporter.
>>>>>>
>>>>>> It turned out that reproducers were assuming that specific CPUs are
>>>>>> allowed to run Xenomai applications, which was not the case. The
>>>>>> cmdline parameter xenomai.supported_cpus=0x3 (= allow the first 2 CPUs
>>>>>> to serve RT tasks) was used here to shrink the set of CPUs that are
>>>>>> allowed to run RT tasks.
>>>>>>
>>>>>> Example (out of my head), error handling ignored:
>>>>>>
>>>>>> void rt_main(void *arg)
>>>>>> {
>>>>>> 	// do RT stuff
>>>>>> }
>>>>>>
>>>>>> main()
>>>>>> {
>>>>>> 	RT_TASK demo_task;
>>>>>> 	cpu_set_t mask;
>>>>>> 	int ret;
>>>>>>
>>>>>> 	CPU_ZERO(&mask);
>>>>>> 	CPU_SET(3, &mask); // Assumption: CPU 3 is allowed to run
>>>>>> 	                   // RT tasks
>>>>>>
>>>>>> 	rt_task_create(&demo_task, "demo", 0, 50, 0);
>>>>>>
>>>>>> 	rt_task_set_affinity(&demo_task, &mask);
>>>>>>
>>>>>> 	rt_task_start(&demo_task, &rt_main, 0);
>>>>>> }
>>>>>>
>>>>>> rt_task_set_affinity() does not report any error in case the supplied
>>>>>> CPU mask is "invalid" in terms of "there is no usable CPU available".
>>>>>> If an invalid affinity was set rt_task_start() will block forever.
>>>>>
>>>>> But the task was already created, is only waiting for the kick-off by
>>>>> rt_task_start. What happens to it?
>>>>
>>>> The thread is canceled inside the wakeup path to the primary domain: 
>>>>
>>>> [510675.581142] [Xenomai] thread demo[1570] switched to non-rt CPU3, aborted.
>>>>
>>>> The caller of rt_task_create() will block forever:
>>>>
>>>> #0  0xf7fc7579 in __kernel_vsyscall ()
>>>> #1  0xf7e544e7 in syscall () from /lib/i386-linux-gnu/libc.so.6
>>>> #2  0xf7f74791 in do_sc_cond_wait_prologue (cnd=0xf746b82c, mx=0xf746b758, 
>>>>     err=0xffffd9a4, timed=0, abstime=0x0) at cond.c:243
>>>> #3  0xf7f74915 in __cobalt_pthread_cond_wait (cond=0xf746b82c, 
>>>>     mutex=0xf746b758) at cond.c:329
>>>> #4  0xf7f9db5a in threadobj_cond_wait (cond=0xf746b82c, lock=0xf746b758)
>>>>     at ../../include/copperplate/threadobj.h:572
>>>> #5  0xf7f9e9a8 in wait_on_barrier (thobj=0xf746b750, mask=16)
>>>>     at threadobj.c:1237
>>>> #6  0xf7f9ea92 in threadobj_start (thobj=0xf746b750) at threadobj.c:1274
>>>> #7  0xf7fb2464 in rt_task_start (task=0xffffdb60, entry=0x5655647a <rt_main>, 
>>>>     arg=0x0) at task.c:644
>>>> #8  0x565565b1 in main ()
>>>>
>>>>>
>>>>>>
>>>>>> How should the application know that the affinity is invalid?
>>>>>>
>>>>>> My current understanding is that the there is no hook (provided by
>>>>>> dovetail) that would allow intersecting the sched_setaffinity() call
>>>>>> that is used at the end.
>>>>>>
>>>>>> Should we implement such a hook? Is there something that I missed?
>>>>>>
>>>>>
>>>>> We could check the mask from userspace in libalchemy. That would remain
>>>>> racy, though, as the set of supported CPUs could still change after
>>>>> set_affinity and before start.
>>>>>
>>>>> Do we only have the problem in libalchemy due to its split create/start
>>>>> pattern?
>>>>
>>>> AFAICT this is a general issue, not limited to the alchemy skin. We
>>>> never intercept sched_setaffinity(), so it's basically a pure Linux
>>>> API.
>>>>
>>>> I would say - as it is a pure Linux API - that we can not validate
>>>> affinities regarding Xenomai supported CPUs. We could implement
>>>> something for the alchemy skin, but the POSIX skin would need an
>>>> additional wrapper.
>>>>
>>>> We have /proc/xenomai/affinity, that might be useful. Not sure if we
>>>> can read that without triggering a Linux migration. IMHO, validation on
>>>> kernel side would be better. At least it would avoid one more wrapper.
>>>
>>> Not an issue: sched_setaffinity & Co. are not intercepted, so those are
>>> causing a migration anyway.
>>
>> The remaining open topic would be: How to do that for the POSIX theme,
>> we don't have any kind of interception available for
>> sched_setaffinity() right now.
>>
>> I see two possibilities: 
>> a) additional an additional wrapper
>> b) validation (by implementing some kind of additional hook into the
>> cobalt core) on kernel side
>>
>> Validation in userspace is more racy, but does not require any dovetail
>> extension...
> 
> a) should have been "add an additional wrapper". Sorry.
> 

I'm not yet saying that this is the best option - it's one. We could
also think about adding an in-kernel hook but that won't be simple either.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

