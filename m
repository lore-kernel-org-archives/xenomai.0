Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA62264A9
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699368; cv=fail; b=FVYTWNzkUHfaCFRRFnA1bsQljubzYC4RccZaekIccGQXkZszB7u+tKIGBhr9XL4ETYYqce4seXFV0ryClmldIL/H7AJmzrxPbRqawhjv7d8bu54SHzesSLVeV2169biL2G1NRYyuJ3GkrbgWeDnL8AR2gFkue1tdcsS3Fj4kJMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699368; c=relaxed/simple;
	bh=slIbwOUF9KFSIqberFZwQRrbA62wHOrP4FUS4atRLM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FgI0gwKKFifHlFoAZoXGVDUWW3lddl4MpHPR90IsTtNiL2uhlT8YBKho+VB/kLQ8N72UKjKlX4n4Fn7BveApQK5KKJIEERde+NJ7Mmpsv/1IsqvRxqd4xjBlf3xTtlypbZKALjdTgMJI879NjduU029nQIo/MsGO9r38ZWUZdMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UKpwDSov; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UKpwDSov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLvsD4MXzeuhdElSD0wFnSxTZoy2vdhDmmcL4MryymH0raBsbSteJ8++Qvbtt9Q/dRMNxa1cZfAy30tVr2rstKy7r6IbLeu2N/K24oZCyWwvka7uQylCYHeYWWdVMjVREIjLSzYDHIL0d5MJmTc1leYSxrMS2r2gM60Z/V23vOhCI7XRQa4MOxAp6PKhZl9/YLEikmIl/Leh7s91j9xYT+p39c0Ar4sX/tigmZB52Eg3k4vBmhuMO+aWIlzjABSzvLR3G2NCLaubQaGhOxjRog06Rai9F7XYLmltoDWXiwxnjB668tqKHqwFUUwmy8XOVHTjpgXkgeZk7bdyrn2MCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DMFwh9MZkl4ue8lwGZylcgTsDVFP4cIzNzQP0rTGSQ=;
 b=S35hHl2EP3rlOEK7Y/zrMIplunUfF8ie4Wq4+RezgO+vOnAZlGrGEEbsx8XuzmcIfuM4nRa/NGZaclghba3nZ63yyihoAZi8nSnuc7U+rTpvqNp8sPoKAA5Px51U471mtOVc7c5wvp2/JiMy58pDhZK7J2EdSuD5V+X122aA7M8PM+kNTJJ3NFHJG0+g6SKM0TEEZB+J8pxEWc5BeR/iATk48F4Y8yekzwZ1PpsDyZrNpIPoFtQTdfXIrtWDX6YuWowEyPtuneA01WCg6o52uzc6M1gHwrZjYPO5G9DcVwbaWdgMg5dHGyRgUC0LG6hjsE8BjCbTjTOD/NyXXTigJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DMFwh9MZkl4ue8lwGZylcgTsDVFP4cIzNzQP0rTGSQ=;
 b=UKpwDSov4uJuiIqe0Ar+kJoGtocqXmyvOxwd2EVm2FMLCkO1zfRVVi+eeA7toIYB7Ku4+JqrWZMaoClpHYiQTYbZJwseECh3a/eXWhK4Oc4J9plQZqoWHd5VnGQh7Ve//xcqCsRy8BMFvHx/5IHF5Sgh+aBiaahg6fMZhE2ttzGbfOB1vgs2+thjD0I8C4qIS7ZQ2oPJqLn7IyYq3T2cnDNca8Lwg7o5m7AWbbUkAXt//ZJZOWCbj1xSNqg9HrwkozzBXlAX9Vrv7gbuSWXuFiZTU1Uw673c6CPchxs78sznbT/q5zeBNtxyDVDdwVs4R3/gpxQNHXF47G7ZHgSmUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM0PR10MB3330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 15:36:03 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 15:36:03 +0000
Message-ID: <2ffe3eda-5d10-448a-a6a4-eaab6a7564a5@siemens.com>
Date: Mon, 20 Apr 2026 17:36:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC xenomai-images 5/5] recipes-kernel: add debug
 additions to riscv64_defconfig
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
 <20260417205713.2290350-6-tobias.schaffner@siemens.com>
 <33746f3c-becc-488c-a2c1-22b52614107d@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <33746f3c-becc-488c-a2c1-22b52614107d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM0PR10MB3330:EE_
X-MS-Office365-Filtering-Correlation-Id: b4418f85-4eeb-4c58-cc62-08de9ef2881e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	qSkYpxyp4WV1N9yDR5/eF4TWdurYjkmT3lfIDEsv+bnq5E2hw5vSbrRi1OC3/0PahpBiJ181dQgsLmfeO1xVpKTNzFEpE9kiOpT7xXNdYVFnsWmrQ37ZFTDxc5CxwJiqAU1/q2T2YFlS/QFMiuBwDZ8Gv1BkYfsje8pmdiHihmISAlrQD/BGpdsSKvfwE5ZoqUKIIAk8AqNGYRKfP8vb2aizJtVSZqHovDPd6kMzyF27Q+BOwdloTch4z+RdwvZw7pHexdJpklZjxTyp7Xtwm4XzPBaLKJfhQmHTl6CJKtGsI+37ViseJ0nuOkrvN8Z/h+ZuZshRMrEydfK+OBXzcZka6I2hgZP3h/pO6V3ZnElvJk6eYyH1XZ2/Pn+Ewh4P/PL1/u9QL/t8Qbw7z6i5mqFNooEyV41P4Rj5BsCaO30ivCytIC97gpfifhBhEFckqXNNAWNc3GvO/ffnFC3BCFU3VtQ0Q/lmwrXh5OGP/vvunYKGwOeQnI4wEHAJRQexQc3+By1UcP4lyy+ypCWTrCl/hOLzVyi49ejZLEa9p69SYtQMS9yMHm3RrTkL17fvDPjHdUUfudVE+DyiyRAdWTnw3KcQwXUBVSpMqSXWJCQhWh8cx3vLYGIYb1Q4imtGeGt8wfDBlzahcBJYhnsIfzZKvabbkVjviIEVS6nNNXdX4U76iw1j/yE332wqpMvBlZzjZzdNcCFR76rbLzK2Dv2msTilMKxJF3TTvpDR/lY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTN3NTVBS2dTRFMyL0t0aENqRi91N3VEcy9OcG9vYUtTK0hKNkJSL3pvR0dK?=
 =?utf-8?B?cXg1eXZRYldBMTk2bmtINkplazJXWEVOeUovTStjTlRTalI4Szdzd3ExeUV6?=
 =?utf-8?B?SlBJL3gvenV6aXlUOUxVeWxvVTlmS1RYWmcyWEFHa01hS3NmZEQ4cXE4RkhJ?=
 =?utf-8?B?c2FpKzVUaDdzd0pJZnVKRkZRZVlpekNjRnlSR0wwSC9ibjZNajhQVXFZMk5C?=
 =?utf-8?B?WFE0SThFbHl5QUREMEJuc0NVZ09NRXFFNEQrNXJ6Tk9SYkVaM08wY2l6aEIz?=
 =?utf-8?B?RTRHQ2RUTVlOU2FLc0grb0RWNDl4c0NEbUFGQjR5SlRMck96TGhFVG0zbHpP?=
 =?utf-8?B?RkYxTU13ZDRCK3dVSFRWMEo5Y0lyUzBCQU15ejBqNUNkKy90aG14Q3JuajVM?=
 =?utf-8?B?c3Y2NlJTZUVCd0NndE5jdGxEeGJvcEZWNVBZOGIzUVdjcTA4R0ZYanVHdVRv?=
 =?utf-8?B?RnBEbUZIY1dWVVJrQTA1UXh0dkNjTCtUTStxK1c0eTF3bTkvUS91ZnhwNTM3?=
 =?utf-8?B?SVBqNVhFWGRwVVRvcjJTSVluem1RNUxNOHdldEd6QW9OdngyMUZ6U3I3cEJK?=
 =?utf-8?B?c2RqaCtQTXZuOG04bW8xUU5hTW10ZEQ5cGhKNzlSeVBjcGEvOTMxaHJEL0FF?=
 =?utf-8?B?OWQ0VkltK1lMRlJhY1VsVFVxV0dCYnloMGQ0M0gveHNKZ244aW5ZaVFjcGxa?=
 =?utf-8?B?MkRVRWYrc3NLcktoaitDRVZBaVFQUG4zRlVyTHpTSXNrcFpvaXlSbG5JMVR6?=
 =?utf-8?B?TWdmdzd6YnhxNkUxQXNpS25LQWJqL2ZtMHAyK0dSUWpubFE1VjRma1VBdEhP?=
 =?utf-8?B?c1FxazhEZTIxWUJZL0ZudUxTdU9vek03cU1FN090bHZkOGJhU3YybmlsT05r?=
 =?utf-8?B?bXAxR283MkJ6dGJ6cVhQRmFYTUdGTGZ2cytBYzhYSWpPMmVNbmdVb2R5bTkx?=
 =?utf-8?B?aWRISHRqWExTdElCbXBSUDJ5UDBUaW1oM1JWYlJ3UXFFU3RsdXN3TzZBZ0k0?=
 =?utf-8?B?cnRkS1RTVnBGY0UyMm1MM3I1TFNyLzR6ZXk2cE1vZjJQYkx0MEtTS0kwNkxX?=
 =?utf-8?B?MUZjTmxhVVJMYVNocVdhVmU0WmdmK1pNYlBKT3AwN2sxREJwMjJVSWRxZmVK?=
 =?utf-8?B?YnhaTnRIbTZrR3dHWFBlMTgvUEFvYlhSVzhyRXRyOUR3RW15aWRuemY1QU5I?=
 =?utf-8?B?UW9kdWRLZjlOdS9XRGFOaWtUR0s0eU5HOWE3S1c2V01nYW83am83RS94UW5L?=
 =?utf-8?B?dnhVUkZUNFFlbEl4QkVldjAwWlhCNDhsZFpPWWtOeVZUZzgzUmRoQ3JsNUxh?=
 =?utf-8?B?Q28xNFdnNzNyQ1Jrei9XakovaklDamEvd0k5aDdRN1U4eDF2Tm9kM2toblRt?=
 =?utf-8?B?c29KODlpWjZYTThHRGdJR0F4RklEQ0crKzlQSGpybExoTHZCdlJDa1l2TnVm?=
 =?utf-8?B?NWxCUncrUTFQS1JxNTBDVW1HZ1FJY0d5UU9iTTZUakxmWFcvcXVtS0RIekNj?=
 =?utf-8?B?NnRaOVNRM0pPaldDQ0dja0FQQVJJNXYvQWIreXRjcTk3dlgwdW9tYndFZWs2?=
 =?utf-8?B?ZTM0Z2lCRXg1Sm5jMFdRQ0JFUVorckhvQjNQRzNrdWxobmN2RzRvMTVpaEdM?=
 =?utf-8?B?bmRnaDlaelhLblNkVFNFSnllTkk5cVVWWGJDSHdyOWQxc0pHcVhsU3p0clli?=
 =?utf-8?B?YVZZMkpVdzBuSEgvbWxhaTF2VXR5emFCbUVGUjV5aGNmd1NveVNPVWFLRGZC?=
 =?utf-8?B?TFNvM2RJY1ZZNEdIOTFGRnRjYmU2dnNTZDgzN2IzNEMzZnFnb2lDeThISjVR?=
 =?utf-8?B?SW5lUS9wNkJjNENIaUtJbWVJTzZjTmE4NDdtbFU4elQramtRaU5kcVhwd1kr?=
 =?utf-8?B?eWxlNDFRNVplZ2dWczA3L1ZsR1hRbkxkTytzRlpFemNIYzJIdVRZczJ1TGhN?=
 =?utf-8?B?bkJKcGZscnNFT05vcGFiYmRqMjRvOWZ4cG5xVU1mTE9rZW9QWmQzS0xBTm9r?=
 =?utf-8?B?Y1U3azgyTGV6bHJ4NmxPMGMyU1hTbDRLc21kUXRzUEZNdTNDRnhjVG5BdVdB?=
 =?utf-8?B?cldrZ1htc1V6UTUyRXlQZ1BTSGtiWUNjTHlVMnVNb0IzNk41SVNQQlpuNDE5?=
 =?utf-8?B?Q2doaVJSbExvc3dMSjNCYjdKdjhqUm1mVXkzMGdSdEVVa1hCK0toaWxZNkFj?=
 =?utf-8?B?RVRTWkFHSVkwdU8vSThvK0dsTGc5cU9hRnVFSnFHQUNodktFS2pDbzBjTWQw?=
 =?utf-8?B?MXk5QlRaRS9RUmxIS1hKQTdBK3UxaWU0LzdyNFRQd1UrTi9RQ1dxQ3VQZVNR?=
 =?utf-8?B?UWMwU0RCQ0hwME1hUXlZajhPZDI5QkhpTDBaeVhRSDhVV3ZnelZqdXM2RnJu?=
 =?utf-8?Q?BQnZiDBSZI98iwVk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4418f85-4eeb-4c58-cc62-08de9ef2881e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 15:36:03.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrqspO60peN5/2BkACwbhuDlupGBUKmPG4OxwGSr0zWkDqnKQiZT8ZFABOSqy351dhTnj61vB24PinPUIGBnKn6ZFBl0dUAhAuDZIguQV4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3330

Hi Jan,

On 4/20/26 07:47, Jan Kiszka wrote:
> On 17.04.26 22:57, Tobias Schaffner wrote:
>> Added to the defconfig to support the current workflow with a debug
>> disablement snippet.
>>
>> Added as a section in the end of the file to make factoring out debug
>> configs at a later stage easier.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   recipes-kernel/linux/files/common_nodbg.cfg  |  2 ++
>>   recipes-kernel/linux/files/riscv64_defconfig | 15 +++++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
>> index a57463b..6637d16 100644
>> --- a/recipes-kernel/linux/files/common_nodbg.cfg
>> +++ b/recipes-kernel/linux/files/common_nodbg.cfg
>> @@ -1,5 +1,7 @@
>>   # CONFIG_IPIPE_DEBUG is not set
>>   # CONFIG_XENO_OPT_DEBUG is not set
>> +# CONFIG_EVL_DEBUG is not set
>> +# CONFIG_EVL_DEBUG_CORE is not set
>>   # CONFIG_DEBUG_VM is not set
>>   # CONFIG_DEBUG_LIST is not set
>>   # CONFIG_BUG_ON_DATA_CORRUPTION is not set
>> diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kernel/linux/files/riscv64_defconfig
>> index 8f9e852..6b991ae 100644
>> --- a/recipes-kernel/linux/files/riscv64_defconfig
>> +++ b/recipes-kernel/linux/files/riscv64_defconfig
>> @@ -311,3 +311,18 @@ CONFIG_DEBUG_KERNEL=y
>>   CONFIG_DEBUG_FS=y
>>   # CONFIG_RUNTIME_TESTING_MENU is not set
>>   CONFIG_MEMTEST=y
>> +
>> +
>> +# Debug additions
>> +CONFIG_BUG_ON_DATA_CORRUPTION=y
>> +CONFIG_DEBUG_ATOMIC_SLEEP=y
>> +CONFIG_DEBUG_LIST=y
>> +CONFIG_DEBUG_LOCK_ALLOC=y
>> +CONFIG_DEBUG_VM=y
>> +CONFIG_DYNAMIC_FTRACE=y
>> +CONFIG_EVL_DEBUG=y
>> +CONFIG_EVL_DEBUG_CORE=y
>> +CONFIG_FTRACE=y
>> +CONFIG_FUNCTION_TRACER=y
>> +CONFIG_PROVE_LOCKING=y
>> +CONFIG_STACKTRACE=y
> 
> I vaguely recall an attempt to invert this logic to "base config +
> common_debug.cfg" - what happened to it? But that's independent, no
> comments on this change.

That is one of the reasons I tagged this as RFC, and I tried to start a 
discussion about that in the cover letter.

The RFC for debug config snippet logic inversion was: "Rework 
linux-xenomai debug configuration".

When I started the rework, I tried to invert the logic without any 
changes to the resulting debug and nodebug configs. The idea was to make 
sure not to change the build behavior for any users of this layer.

But the "defconfigs" of the other architectures are not defconfigs but 
large configs that grew over time. For a lot of the switches, it is 
unknown why they were added and if they are still needed, right?

With a common debug snippet that makes sure all of these are set exactly 
as before in the debug and nodebug case, the debug snippet gets huge 
(check the RFC for reference), like 450 lines big (including comments 
but still...).

Now that I want to create the snippets for RISC-V, I am unwilling to 
pull in all of that into the riscv config. Even if we find ways to 
optimize this to <100 switches, it is still too much.

Best,
Tobias

> 
> Jan
> 

