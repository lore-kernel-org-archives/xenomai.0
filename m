Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46013D9029
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166433; cv=fail; b=fwvZQ2o3j8Tz6zgmPX9UaBCeiU5FcZzh3ZjF0TT6qXJzFvpjdQiebcDY2O8XNTxhrJ5B0GnHEN+6i9H5S8rczS5kqtIPR6Ae3XZCqB5jX9aV2EjVR/8MKR6YHVBbIIvCtdTqQbTB/hZEakd3GF+kM+/37xN8837bjNtgvHFDt28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166433; c=relaxed/simple;
	bh=ktmYWc/aBC9G3x6IXd8sHhlNG3+wfAsw42bXvLxzpjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0FCf5Jocsoki+ymR0VnVo64+IB0I7KASJXPie6WTEFLbHauVMGghiGUyPHVPiW0uwuSsIW5CTLJMCSqBOfDHZwA1ge34rEPKJ624/UD0NmkUEhH0Gw7bzIhk0KKah68Bp5GCOjAwlvMthsAyTZNjbILbhKC+4H8FbG3qDz8nCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bVt05owD; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bVt05owD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnIbx4FDbWXlHuAw9nWtlRQblLe/sKqEok2q2XV5nAx3U9xgNFo+5fom2LGGKLoH0z+NoLW2OmrEyqsYk8mqDT/Zld3eMMqQC36iARKzvDrXnQQZE7ZaqeCmbTGs0j+uACGaQHc1hYD9urqPOZfHR1LWh3cv++ZzQ/BJs7Z56HkWfJMq5t6X9xcJhUf7RYn0YpnGnZWtOtknPqJhP9N9duGE5BVpd12MAvoC/Buh0LSLcn+J97hANeB9QmA9WGwka7E60r37yY/DQtTHeCQJ62iKFuXMaOiSdzB52iIq9ZZzsHUPZnagvM5E5VLxiM5giTLIUaIeXMCSk4cIBtn0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjOJe9qHIc5nMszME6rUXHRnoZGQrPkg8uu+1J7CQkI=;
 b=vEDsqIfmp5/Jj6lqLag0EUKqZ4kkhJVxwtr3ohuypd1EQE8tEOD/rv6rdJKOCaFEFbTY2Rz+BFf/3CX3SdKZlxSlPddIpqSTJZoC2GLwFwXIYgtL85CMB/Uk4kdn0lEc4x59dDUQDP9xVf2fNZOxqUwCDux3ImKqUTUp1ghR3TZfZtU7EsS3f3ORZhDbnS2DJXuo/O1glLkTzTQLIbTw0FC3q1gMiYDHS8AwsGZQTBazCO5zLOfxp0eOCofFhXVn+jtMXXeqKowgIZ6RwCQR+MRqQjfr20BSIko7MThkZla9XuLRgDpSiyoylUdoBzfKV34AQXhisPztZdzTfXTruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjOJe9qHIc5nMszME6rUXHRnoZGQrPkg8uu+1J7CQkI=;
 b=bVt05owDRYVR5tCcQVXOAr1fuhnGWppoi13MBnHogLHzEvUXWvigJ6Ma4NBbLGNkiN1LJyD1mz+er8G/0UOS9ZKtgdBQqx9PMX2XttNW/05RyFtw9QvSGRlTZmYEyrgSqN0j8MAMlO2oXuh+ohpklG8clc9C3RzGCdX46VLxHHMqIq4p6tOCwxJXQe0RCeWgVp4OpiyK2+uusglWKSrh9Fpn7Hiovh+R0HUuR+RacSdofnGvQCsPy8Evs7OP3h1T01cRMp1v1itTkG2eal2vMfS7dX2ypZUlzJBRc8qFdQ8rVk0+ZEruAADVBDIAgOImK3RaDhaR984rqkkP5U8sMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by MI3PR10MB9899.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 11:33:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 11:33:47 +0000
Message-ID: <e0887ec6-53b9-46b1-b360-84acd154a561@siemens.com>
Date: Tue, 14 Apr 2026 13:33:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xnsynch_requeue_sleeper: Return early when !XNSYNCH_PRIO
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
 upstream+xenomai <upstream+xenomai@sigma-star.at>
References: <20260412073425.956320-1-richard@nod.at>
 <af74e234-327a-4b59-a33d-8d817e34eaec@siemens.com>
 <946371069.54252.1776111069832.JavaMail.zimbra@nod.at>
 <0b212101-486d-4334-9e03-89ed95fdfd99@siemens.com>
 <277806441.56046.1776164574699.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <277806441.56046.1776164574699.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|MI3PR10MB9899:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea1ec13-fe3d-4522-dee9-08de9a19b12b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DcyHyOEhdIU6RtBUZXVUZoibk+9ATrw+EoVhD1sx4eMRIr3bMCjNGQwQYlMhI6PBuwBr8uekklA043FTkVx05RCw17JYlU+9mG1ibg9CP3ksHHvTWH/wZmK4JPDCXBse0ZfBgLulia1OBjs/FSeoFICIzMYdMiuOq1YVc8jwxgZxSIoPtbsA3Y+ZTvH7xfdvLKQ3vnqWCsauy+rVm4r0SYaI2jUESGf8MJqcTFKh4c9Uw/v+sWqkMK19XLkx7Kzyafy2DqgQLw+HX4pxjLgpaSfQF2Fs6djJTiuK8DeCah3vX3/Um0wjrQSqePPk9VDlpZa0TNDyBNtgGAhyTINfo+i5oLDbui11/GUEzcDAaARe49lUGqwXFW7nOHUH8z5A9gSRJCpCr1y02MQvTfzW2EYMdKSxB3ZaCHs8coCJII2b5zGnLiuGJBaKpC2g98SaLHm98RoP/pppz6J9RZiiJh/pqfKH3fbKT5YD1VEpNauXclceeb+YiwnkXobWc5zJdaT/uUxgrf3HTnqxitIW+qYUowzGMwtlFBB+TVn+QXiAkcekNmvc9OOECXXxLuM1c4eZy5NYpKki1CjjbgYf0MjPo3g+XvEkTye5DBvrXDuEX3bwJNFzTMjVffL5vTMegErEapHwcOiRkRiBh/P3qKz8OiCJUaO+7927iPZIYANcQoKjQcrUnYcZVyUaUBApxXABAlaSD3TEg3IYR7YOJH8pFtP9QATBYgSir13/n70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHQrbzNUUlh4WHM0VWlzUW1OVHZUbU5OWjNKellaTmlyMVZoSzBLYmFGd0RZ?=
 =?utf-8?B?NHFrRHVmVEsyZzQyRUJQNEFjdHQvK1dMMVVTWklSaWk0b0ZpMmF1Q21LUmIy?=
 =?utf-8?B?SmJnaXBURmZuSlhTN05qT01nT0dIQWxsU3o4aGQ4L3RWekVLc1RwM2FSeFJp?=
 =?utf-8?B?NDhFYzBTVElvSDhldEhrYTBsL0xPMFp2aW93YktxZXNGQVdTWHlReUs1UXZ3?=
 =?utf-8?B?eXlLZTEweGtnOHhHb245TmRYYXJUdTkybEFuUW5OVVA3cTFHUTJCaTRGcllJ?=
 =?utf-8?B?emZiVFRFRDNlVFQybXR3dzBjQkx1K2l5RXUwTVF2WnVCYnVwOFVyUFlITS9l?=
 =?utf-8?B?N0NnMjh3MXVIdkJkN011YVhKd0JDZXZnOEdXZ2FuOHVMcTJWR1FyY0dQbzNs?=
 =?utf-8?B?MXk4Z1RqUGlVNHRPaG1pT0phcXBnYk5jMVhBYXJiaEE0YitabUtOWW9LQmNS?=
 =?utf-8?B?Q0c0R01lalV3cWNTMGJzU3JpNWlUWjJPNzhrdUVDN2ZhbHpPMlA0VmZHbnJF?=
 =?utf-8?B?K1pHbUwwb0sxWFNNK3NlM2RRcGlSVTRCWXNNVlU0dHNSWDZ3ZWx1MWI0OHIv?=
 =?utf-8?B?c1pUZlQvUGJVcDF4OXN3OGR5RmJKU2V3eDR0V0ltT2hRWGFiM1NZc1lnU05Q?=
 =?utf-8?B?NmtyWkxqNTk1ZHJNTnh2NjRXWDQzMXdBYUozTmFlbTV2b2dzc2FlU2F4c2kx?=
 =?utf-8?B?U29oeUY4WHBXNm9NUVphWll3MXpxdmRjK2E2cUFvM21zMUlTZlVYRWZqTW1R?=
 =?utf-8?B?dzBuZmFINW5JbythZWxtRzZuYS9HcHdhV1NhUUxVMXVsR00vSHpQbTRxUUlz?=
 =?utf-8?B?MkhrNGFtbG0zVEhqUzhiV3JEN0JmbDlXaElLNUlieDNGUFMwVmFzbFZYR2dj?=
 =?utf-8?B?US9DeFBYVFNlMzhlY2VTYTBqNzBVMjVqNFJxdXdkTkxaQzNjWXRKdjlaaUky?=
 =?utf-8?B?RWZuTDVoVXNxY3JHRVo3bFBwWW5YODBKK2FQN1VEZU5IQ09Cd0RoQi9iTTNi?=
 =?utf-8?B?cVdsUXVIMm1GMDc3SXp5cGV5ZWtNd1l3MzNUTFE1MlIxZURoNDJFRTdSZmZL?=
 =?utf-8?B?RG9MazNyVDNvdHcrcU54NHFQcmZXUHNDZ2JGMklZMkxjbXVINUNld3VzVEZR?=
 =?utf-8?B?TEtxeTJXNWFQdlVKZVc1dlBTRmJtdVkwT2lHTlFJa3R5cTVtY3pCc0UxcEtt?=
 =?utf-8?B?eUs2Z1B4QzJIQ3VyQ2ZVTUtQNFFyek9La3kvRWRtRTJIUEFwdEFYbVVKdGZ0?=
 =?utf-8?B?YWhVZDdHbkN1NjNDWHc3UEZaY2c5Uk5ITVdVR3BUemRBTjc3a240QXFrTjFu?=
 =?utf-8?B?ZlFqOVNRUzhHSXBack5vekQ4cUhCSWtBaXpUZG1jNXJjdWlTK2dIcnpZckV4?=
 =?utf-8?B?K2YyMUEvc1VVR20yRStPckZmaTAvUWlvc3ZmN3o5YjN0cmp6Umg1alVpOVJj?=
 =?utf-8?B?RzFvZ2FURUF6b2tRbkxUQlNpRm9tVGtzWEhNOGtXWnZ6dWxkdW1GaDlZZGRu?=
 =?utf-8?B?RHd0T084bXQ4YXBTd24wMkw2WjljeTA3TjdKVmtMalhhVWZJYzRkcDRtWTl5?=
 =?utf-8?B?aEZnaExJUGQxcnA3c1IzMThLcGdhMDNCZVRsTExncjNQcG1pZnJ5ejluMlB3?=
 =?utf-8?B?cjhNVE1rRjZzS25Nd1Npc2dHaC9hM0g4QStrRnozeFRabEluZGhBTE9ocDQr?=
 =?utf-8?B?eURmVmliVEJudWhzbFBEd3pmRVRuN0ZVY1piaCtrS1NWZ21HWkZKYkJ0QytV?=
 =?utf-8?B?bHIvNldEWEcrVUhVa0Znck9lVWQvblJWSUU1WW9PL1BjQy9waVVlRXBsdjhD?=
 =?utf-8?B?Qm14c0pucmRURUI0eVJyM0RTUDd5NWxkVnpOTHJwdmVhOHBESmQ5ak1LRzBF?=
 =?utf-8?B?bFpCNTZLb1FQdDRFelFvdmNXcU1Bcm5zYVVyVnJvUmsxOS9RNDBoTzBsSlNy?=
 =?utf-8?B?enNJWGpBdkUyQUVGK2t1bkEyOTRVa2tDbFBmUGZUckMrQ1k2TEFwT25RZDRF?=
 =?utf-8?B?eW5uU2U2Sk1pRHMwV2NuaDJhWE5hWVVsb2xmemh4SGU2eG1YYUZrRHh2aElx?=
 =?utf-8?B?ZUY5QU9STGYzbjVUL3RHSDBiZTF2MHFTUzFRM09YenJoNzZ3Uk43YW9UcTcz?=
 =?utf-8?B?dG1kY05ZNWNXVmhYNDBTYVZMUHZLUmdXY3krVlZFRjZONUlBejNjN3hsV1Ev?=
 =?utf-8?B?TjF6TEpESWwwS0g4SytaRC8wRVBzTm4xb3pwS3VJNW01a00zTEpRbWUybTdP?=
 =?utf-8?B?K3A1N0xieEFYZythNXRzOGRnSTFBZ1FVV0dkd1AyREltU2lwUFdWYU0wNEZP?=
 =?utf-8?B?VHhlZ3BCdHV2REEzSitRMUNjeEFpSW1rcTcyQVAyM083RkZoR2YyQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea1ec13-fe3d-4522-dee9-08de9a19b12b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:33:47.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaOY/AxKKufADrOz6tvB2i0+0M+7KToUH0z94xonYcTbXzCiXZsCJ/8hmzX1pSqmWEG3YYYkdKZsHeUKnsqREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB9899

On 14.04.26 13:02, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> Right, a prio adjustment of the lock-holder that is blocked on xddp will
>> not take place with PP - prio adjustments happen already on lock entry.
>> But your changes would still cause regressions to
>> xnsynch_requeue_sleeper.
>>
>> Let's step back: In the PI case, the lock holder will be on a FIFO queue
>> while waiting for messages. So it may not be woken up first if there are
>> multiple waiters - that is something we probably cannot change as we
>> have no information about other waiters in that queue and their urgency.
>>
>> Once woken up, my next question would be if the right prio is used from
>> there on until the lock is released. That should be checked by test
>> case.
>>
>> Now to clarify why your changes is not yet correct: A thread is blocked
>> on a PP mutex while holding a PI one. If someone tries to get the PI
>> lock while have a high prio than the PP mutex, the necessary propagation
>> of this prio to lock owner will no longer work. I'm not sure if we have
>> such a test case in Xenomai, we definitely should, and this one would
>> reveal the regression.
>>
>> Maybe this is already enough and correct:
>>
>> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
>> index 70c05c1f49..33ef8ef183 100644
>> --- a/kernel/cobalt/synch.c
>> +++ b/kernel/cobalt/synch.c
>> @@ -963,7 +963,9 @@ void xnsynch_requeue_sleeper(struct xnthread *thread)
>> 	struct xnsynch *synch = thread->wchan;
>> 	struct xnthread *owner;
>>
>> -	XENO_BUG_ON(COBALT, !(synch->status & XNSYNCH_PRIO));
>> +	/* Nothing to do if waiting in a FIFO queue */
>> +	if ((synch->status & XNSYNCH_PRIO) == 0)
> 
> The comment is a bit misleading, IMHO.
> !XNSYNCH_PRIO does not guarantee that the synch object is a FIFO queue.

 * - XNSYNCH_PRIO causes the threads waiting for the resource to pend
 * in priority order. Otherwise, FIFO ordering is used (XNSYNCH_FIFO).

> 
>> +		return;
> 
> It passed my tests. I'll resend updates patches ASAP.
> 

Perfect!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
