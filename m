Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C31E0E14
	for <xenomai@lists.linux.dev>; Fri, 10 Jul 2026 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690927; cv=fail; b=ZZzc8ICfHbQeXRtsr+sMPmR1cy9b66gIIfHt7Zq1sFpXdk/trC4RZmcLkIRT5iKgsFZ4Kb80+ke7m6W19AZCAjr4ja3t+WXibn3zL75Ji6M0uczFTkkVtVagysaGhAZOpQTzvhJeN36XOKrTbzNkDQl97Pby7JN/q5Z8wAQfL+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690927; c=relaxed/simple;
	bh=YeoOuRBYVq6xkvrKli4iUjEkne9/hLA19E2urumlJUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AdGBG4Kqmpu98pae3rO6ar7m4Jo8X8XKACEV8dJHFTUpCxsWfeLwz1iqYxI2nObK48VCaa389IKm6jJ4xxZmV06g+bDEZFNxpUbn1pO9GhhtaooaYrAjGM86h20yOyv88Y5NJAV3p2Q+kGOu4OYiAqqK2WHpzzM8w6guzkpGZWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qqZi8565; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qqZi8565"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUOgkwf9is2dkYPPwBJ/4yEQiJtBHNaNTgBwij9EIPmQAOQfLweYuM+GQWYfRid9s2CGnTTw+S8xLNVdmRph9y5kDHwyUT3u1sPKdeoznKViYAXKICFsVXGSPvYByGmvSW57Bnx4E1hjVjX26HBnVvwKSE4KMX6uQr7H9FermgCAWkYSRCQF0pOcA2QamLYMYXrokh9GCsFXjH/QQUfeMHfy/jHIqQ0tQMb5hk2RVgZdV+lU1bYF7Hg6KNhMWo1NDwUYROCqS9yYYCG1obrq6/48Jl3VSiV14uekmZo6yC8ZPSjv/2/XUsT8N8UlwTmP5+em2+IzyOlJEYoBh6lPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr3HMbU1sPmBTiJPKHhaHQdwxeQJRQTyz24inYWzs+8=;
 b=YHLgR29SmhQTUx9iy8Jcznb1fvQbcmNPh1YNMZOqvQ55u+dE9etU6tMmAPKGzm9nCxWqWtCqv3glPM3wXrgFlQVWYZ/B7hyP3PdPi5s7Y9RgJmDL97e8cmv42oGv1kiw70UJAEWe+c/pMN9OmbG3xrXWS7oXYlFel/jwxWXXU8iwj6cVWkQaaNdUQEzD43FPSl+IWT5k7CkBWBJkQpyeMRwteOgOYVqtmvZTUWz+nl0YSab/ERyAHzfpZOWnSvvssRY9yonXqFq8VJ8NrzmA4sMvq7+V9HOHf7Nk1nakDzI1yeh4SPYWGJ5NY+OxPUZiXV+h5zxN+F4LFtPPhTQcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr3HMbU1sPmBTiJPKHhaHQdwxeQJRQTyz24inYWzs+8=;
 b=qqZi8565g2evn5QplDSAP0JOY9nABXovPe+OtyRkkz156fsEfV33MPluhF98AJHcXAXZpc2usT7twm1AgUYz3Gh1NDXSHo0z/Nezt//TfSr1vHCjcbDslNTLc41HKLzIyFEJl9iTjR44gm4qoo+GrB6McVSOzBn3e1UPyOkT0zLlNwTUE+QX9O4OxPClMLSzKN3dG8tpYsBz5rnBjHbpTyy0auELsAosfsLUJGWJ0CtGuRTvubjs/BEZEl/hxckuNYq1RKb3KRNIwo/HC57s3xKpqKSdDSFiC1anuLH1MfPgnmlfWkMSHV4ljQYRNkIik16RV9GChrPc5Tvn14DjVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 13:42:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 13:42:02 +0000
Message-ID: <708c4972-6445-42c7-85b4-7b770263e272@siemens.com>
Date: Fri, 10 Jul 2026 15:42:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have been
 relaxed
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
 <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
 <88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
 <e7debecd-2490-40e8-8223-4e076d39165f@siemens.com>
 <27d44aef-6dd8-4323-b24b-70f0770a9f49@siemens.com>
 <22796f23-74ed-4cfe-8188-df22b2547ae3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <22796f23-74ed-4cfe-8188-df22b2547ae3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 172b047f-7acb-4449-6af3-08dede890571
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|4143699003|6133799003|22082099003|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	x6Wlaokj0c6SN3UfEpBOITrh9dQ3WW3DTBZqAIg3mTIJTUL1G3SphVONVksndlFEKCqb4wmmQnS5ajH+a4NzKUxTdja7iaboTWDNPwU9hGCElM8Jrzpdsp5h7EdnYZB+pFOSomWJ0yc1Y6hRltB7QytWMphtPUfDhvkK0wwn4AdpQPWZ5IxA7MbMKUf3mz0EYaZ+ZolMvN9dQoCCJhsBsg1ettLvmNl6hQMxgN7plTaM6YG9WmH81Z+AsmWvgZfBIpfCiGaHXoOHGcblUrnDoJZFKF8ZbQteYw3fFJXegKTc4P5hYRhb1ngMb49vqVWzUqdwR61MNqKK6I248zJ0gTFdALa8FZ42tMrWSklYcURvRWybRuQLykzDC0xw8PUhcdk180R+ckPSAQCUbPEaQpeaKU7+s1sbpxC5NXZ8i0dP8Le5xVayXe4Dxz1ZRmuPGKbeMht5a6jYqvHRxF2/qjhkYMg3yybTWve81CldpcouU4FtKi2n+9Ocgar/n3arXm+hNF91BfHZm8l1axPW2pJ4BT1z+7Qv3bdhzQoDt8d9z0KC6okVJGnAoYzv5pAa/BsAY9zB2D99l1kRokIl+BsGhY1uVj56mfNN3QUF65njrFraZvDwtf8Zqw9Pe3+96cq1YI7gcrxMEwjcy2K0QiSwGB0b9MNYJXIJm9lH34g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUZocHlqMDlGSnJVMkgvYTdpTHFSZmR2RHBnSU9mMXdjQlVxcVFwbnUxMk9s?=
 =?utf-8?B?VEtqdkZKS0k2RjFVMkNEMXVvV1p2bVg1dmEwcjc3dEtXYjdwcHpCZytzdS9n?=
 =?utf-8?B?OVVOZVVBdjAvVkpUTEJLTmc0dVFNemFOVHpaa21KWmNCMHVBYVBFK0ZDd1Rq?=
 =?utf-8?B?ZVJ1WXVlMTVNQTFGTzV5NldLQUg4Ymw3LzREdkpSVnRSaGhmdGE4K3h1a3ds?=
 =?utf-8?B?OUtyclFMVS94Uk1FL3VkaHRQYXgxQ3JZU1dGTWZlTFM4b1Q0eUpRVGVKRXpi?=
 =?utf-8?B?VDJnTXk2YUNJSDExMlpzRzMwdjE0YysraTMxVWsrWHVRVmpLWTFIMzRnRGtP?=
 =?utf-8?B?bEhHckRkRWRBRnZsUFkxZVlJRGdqSk41OCsvaDhxTWxrZHlGMTVqeGYxWVlN?=
 =?utf-8?B?U2NONkNUUGt3anlLWFFJZkpJOEhOWHdIdjZxUGcrUjllcXErcm1IZ3l5eXRL?=
 =?utf-8?B?NjlmZHU5Ukg2QmpudWJ5Njc0QUdKMWI4OExLcXpTaUoyZlhvd1p4TUV0dllt?=
 =?utf-8?B?ais5WnN6QlRDU0FRQ2oveWxmZEplWmVjWFBHMVpkVG9kZmVSY0RwVWV3ekRp?=
 =?utf-8?B?cVNKWUZNMFgwbkwrbG83RSttenZTejNjRnJ1M1NlSkV3d0ZJSjFMUTZpK3Jm?=
 =?utf-8?B?TzA4L3Y5SHhlQnpJVXd5Z1ZnckJUOWlWcXp4M2VjaUpKK1VLcTJUVTZNYXhJ?=
 =?utf-8?B?VkxwekFHZlJCK3lGVXh1NU1la2tkbEtkS3IzMzk4eWVwVThGRmFsUDdGbEJN?=
 =?utf-8?B?bHpnNEZTd0FPWmlMdmx6VkV5bnA0YlMzQ21KRkllRnQvMUQ1ZGx1R2J2a29h?=
 =?utf-8?B?Wm5ZNXRDczMwNVo3WmpUc0s1NENBeXFUVlZxbEdNSkk5R0hFVFBRTFFLcDh1?=
 =?utf-8?B?T1dmVXJPMHRqbDBydEFkcDQwRCtaZFFKaEpqOHJrY0xxbDhHSWUvc3VVQmhQ?=
 =?utf-8?B?QS83YjFZbEh4MjhYQ0NtWDZiZWhycVA4b1orZHlVUm9QNUhvZm1NZ3FrYnhl?=
 =?utf-8?B?bmpyL09DOFlVUHBSWnhIVUIvakdpVENzd3JFMEcvczRZMEQ4YmJGd1FDcElH?=
 =?utf-8?B?K2lDWHJDMFY2Y3ZSS3RjVXEvZmU0NEQ5TWVwR1FsZmZIamw3ZnFsRHhIUTZV?=
 =?utf-8?B?VzMvWGthNVpNNnZkR0lvYUc1Yk9BeWYrS2tzdjdnK21MVkxySEFpeVVkVFRN?=
 =?utf-8?B?MkhWNENYK1A1VEM3R2k3dDdFcmVaUXhGN014c1NlRzNzT0ZHWXI2VW9jZGt4?=
 =?utf-8?B?aE8zL3A4bW5iMjQ0TUcvZmcybk04bW4zUlNuRnBheVFWZUNtVVY0WDRhcmF2?=
 =?utf-8?B?eVY3K0lsVXVUbitVNUxDOHJIbUFvcFMzQzJPUmY1SEhTcGdubHJ4dng4NmNB?=
 =?utf-8?B?azhoSjV2Skw2dFVxTWNISk5LbDF5NjJvbm93ZndUUmhTUXg5VkhMZzdIemF3?=
 =?utf-8?B?QUJZQVBhQlpEdGlMVlhUcmNMYjVHdnBTT0FDQXJBVUlTVk9IeUlERlo4TkNn?=
 =?utf-8?B?MUE5NzBFWnpWNEVKWHJUYTc0VHJTeUhDTGpKZ0ZDSjU4VXNIek5BTjh4ZzVB?=
 =?utf-8?B?ZkVUdW01MUIybzdQYlEzT1I4R29waHQ0eGUrRG9MUUxRYjV6d2FpTDdZSVB3?=
 =?utf-8?B?YlpnYnBTSk5kcGQ5MVZ2M0pGZDdydlFhU21VZzRJZStweHdQMU9BLzFtMDFm?=
 =?utf-8?B?TGx5ejhwUVh4SVhuQUN5cXlCanRVd2ZFcmR0cENYdmp2N2RSU3RVTDlkaVFB?=
 =?utf-8?B?YjdEVmk5NCtaUXR5aVdMNTlEUTVmOEtiSDZHWGl0Wm1NV3Q3cVdoRlR6a1FN?=
 =?utf-8?B?VG5lRUtTZVZ2MEh6VVFCVmZIcXQ0R1pENGgwTlFtVXc2QVBBUVRsbE1HZm0z?=
 =?utf-8?B?SlBXaDNvVUtTVUZ6YlNjUGhpcUxhc1grbnNsMXNrNVRGL1VnakVrdEF6M0s2?=
 =?utf-8?B?eXBGUWZjSmVDMjRpOXkxLzJ2NzNRSFRUZlA1N3g2Zk03b3I3SmpuelBIYXFy?=
 =?utf-8?B?a3RIU3UzTXRzb1VlUXFGYXdueXpmTnd6YVRtcHFxNFRJdnZoR2VpS0VSSU9N?=
 =?utf-8?B?eHdsNktxOFkxdURHU3A5cHJaOHZheGRMVU1oWjhENjJLVFRScDYrR0xaL3l6?=
 =?utf-8?B?NzJyVWR5c0ZsWTJiNlhDcjBNNXNxUmdsL3hSWkNObUZrV0h3Z1d5czBkbjlp?=
 =?utf-8?B?ZkN1eklDdDA2YUFqZ0p5ZVd3TUhRN2ZxYnVmQzYrVXpIRXNwdW5uaDYwQnhk?=
 =?utf-8?B?ZE1nQ3RXbGx2TEF4VlhxSGFLKzVSOGkxNW1OeHJxcFR3OGdQOXZiWTd1Mzdp?=
 =?utf-8?B?L0h3b3lKakJrUEo2Q3ZlWlh1Nkx2RVhSREFhQS9NZkZRaGxLbk04Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172b047f-7acb-4449-6af3-08dede890571
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:42:01.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deNoHLaRHb3H7B42q4mF75+cPG2Ck7vgENTnEpd6HACEyQ2r75OUaLyrY/ak7Zk8S20lCFlAuVGVmerVk4aVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6259

On 09.07.26 15:39, Tobias Schaffner wrote:
> On 7/7/26 13:21, Jan Kiszka wrote:
>> On 03.07.26 16:00, Tobias Schaffner wrote:
>>>
>>>
>>> On 7/3/26 14:07, Jan Kiszka wrote:
>>>> On 03.07.26 13:54, Tobias Schaffner wrote:
>>>>> Hi all,
>>>>>
>>>>> in some of my test runs the sched-tp-overrun test was failing with:
>>>>> 2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED:
>>>>> evl_read_observable(tfd, &nf, 1) (=Resource temporarily unavailable)
>>>>> 2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN
>>>>>
>>>>> I only see this on virtual targets.
>>>>> e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/
>>>>> jobs/393605372
>>>>> Mostly on arm but also saw this on qemu-amd64 in one of my recent
>>>>> runs.
>>>>>
>>>>
>>>> Maybe improper/missing synchronization during test startup? Or when is
>>>> this hit?
>>>
>>>
>>> Does not look like a synchronization problem to me.
>>> The key part of the test failure is this combination:
>>>
>>> /*
>>> * Trigger an overrun condition by staying busy for longer
>>> * than the duration of our allotted time window.
>>> */
>>> for (;;) {
>>>      evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
>>>      if (timespec_sub_ns(&now, &start) > OVERRUN_TIME)
>>>          break;
>>> }
>>>
>>> /*
>>> * Now check whether we received the overrun event as
>>> * expected. Since non-blocking input is enabled, a lack of
>>> * notification would amount to an error (EAGAIN).
>>> */
>>> __Tcall_assert(ret, evl_read_observable(tfd, &nf, 1));
>>>
>>>
>>> The OVERRUN_TIME of 200us seems to be not enough to trigger the overrun
>>> or in some cases or at least the message was not send in time.
>>>
>>> I suspected the issue to be time stealing but saw the fixup parts of the
>>> tp scheduler trying to handle missed time frames. I think we just have
>>> to increase the overrun time but not sure how much to still keep the
>>> fixup parts tested. I guess these code paths are only exercised on
>>> virtual targets.
>>>
>>
>> So, do you want to drop tp-overrun from this patch for now, or how to
>> proceed?
> 
> This is resolved now. The test is skipped since the merge of:
> 84b8efc58b3db882d527e08b9e28af01fc5b2753 - "[PATCH libevl] tests: skip
> sched-tp-overrun in virtual environments"
> 

Then let's try this - thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
