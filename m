Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC76A2C
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 15:03:18 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 0BD87200007
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 15:03:16 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::603])
	by spool.mail.gandi.net (Postfix) with ESMTPS id EC92C941973
	for <xenomai@xenomai.org>; Tue,  4 Jul 2023 15:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgeD879TA+r5qt722T+fM2A+U0s8T/WukWEQFEO/bwbSb2ZwNi3mHpN7bYyohNeZ1zb2lw1S6mfl2OVPbdC/71w2n2Sk5jh1ZUkqRMlFpPTytWecYn4EJ5dU8w1ylFmsHye6WEcEmGcksoMahyN/bGQT8FA7YnWGsioS13D1rhqbvHzeuKJemKthJwr366uz0G0oruvf7nHLkSF/FESQ0tGko51r1iJKcQaw4tyj/51+Ls30HixnNrQORNPbttgtdiDPcscF/ohvoYUK4fxgQeDJ9Npn6Me9k8lbOXJ0bqhGddhX1q8y1cHLSgeqGshLfxr/P8V2WHCo1HqxRUqAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbd7JYnde74fx/oRr4n+e2HLdSg1NtRiwHKb7dhrVTQ=;
 b=Gd2D/48OcOtzBzW44PqfpiEZLVn/xrz1dSLZOZJ6ZZm6sNXlHL8VeiPzN/AWRb8Ct082J4YR+dowHYXq8HTKXC17JhWGtbc+Tlwozaf0RCy42L9RxiNmRDpvwPqjTz9me+IKXXOiUi4Z9F5dchFz+cWzzDs0j83ofO7v432gi0jl1xEnqIcWJTQm2yo1OODa9pqUK3ss2l9ovi0EfHaTeCkWVXshNStL1JybFmCgZJYefQ8ClRc6z8D31oDtX3Qjx0zUIYy7enCfRcrkEntO4GjL5LiEA8esmwi3P3UowqnQWyqYnnKX/GNfTUDMX9i2K73Y3mGMPkPtNC62vW2Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbd7JYnde74fx/oRr4n+e2HLdSg1NtRiwHKb7dhrVTQ=;
 b=JmbOEgLMpFt6eKCVOdl48dFSQoVWrdds4Z3v2HuyUSPW66PjP8+CsMqNzB1F+sVUsXLdOAZdQSAuZ0/GMN9SmvWVIZGSQmQOUp3+juCKuP3Cc/z2IvIAZCzXQZKoSCaE+3mswVUa5vK0p1U7gve4D6AKGy3f2OKtPFYS0xdxoJdIZ/apVUJP5nY0iVVxedXMUBc6t9NwkiUcBSVlTMDxFldXN2bNNk1KhztUHUa63973piXYpOwq4vRT637uyhq0c5yI+nhNsBm4Pv8SaQS2DjB23uYHrfuaayR6+4OVYooa1ZJiIXNHwDD1R1vyHG5yj7WQpY5Z3tE+DfqnjBuP+w==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 15:03:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 15:03:13 +0000
Message-ID: <40a81c94-2d46-930a-a087-7b3a75a204d1@siemens.com>
Date: Tue, 4 Jul 2023 17:03:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] Make macb/gem RT driver to be built against linux >=
 5.0 kernels
Content-Language: en-US
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>
Cc: xenomai@xenomai.org
References: <3b7514-64a41880-35-28cbfc80@10274948>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3b7514-64a41880-35-28cbfc80@10274948>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ce546d-1f45-4230-f1f1-08db7c9fca04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jRh+E9P4/Fm8KN3rSXk37lu3urWL7xrTuQyJIB1B0NoGjZmu92f01LHD1dS6yOoCEDEmh7JKGqNmkRxeVT5zu49WyUUVjktmzDxzzb5BMkW9x9gm+LnR7uKRgtakBb7KRhbCS0s9uIXkXm3mAb0PAVrEOLim7LCRCO/YlokCUwgqrHAuJqMc3YywL0/2aQUccFSEViUhO5kEyObggZU1EoA2GCFEK3vsq2Q3rt2vkFi8R10JE6vJ4QkA43KjXCmV8mO4W6vjtdi35G/PxXbsuY389e94TkGWPYmsxQjrhFj95eKzKDtAPacdidb/tqWSbff+vrD5slYOiWW+X+stSq0nE6udSI9nhpsx7Tl3lJbOqxsL41NFZNSZ3F039jjwRFr9w23rGZBqucSRanKmv845MizQQbuI9mX0aHzOd5bTxPWm2A4tB2nQPUPNi4rwF2JN1/iz2ssQLknhhRttvRZiLJamf3pbm7g0TFtqkmo+mwgIkUePBBL5cDTUYiv782ZOaI5tCkuIh9RLJL3ivU0bBQGJDCS6mrci41ZitG5RVukOu6Ev22lyJpFSjlETlMjgCreTZ5nIkWKWcrrB+qQL5n3ysf0wR4KH/vIy2yZIWLbugrlaLGiDxFzTVcZJ4xmmain2LSkoWMBQCGBsTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(31696002)(186003)(2616005)(82960400001)(478600001)(31686004)(26005)(6512007)(6506007)(6486002)(316002)(6916009)(4326008)(66476007)(66946007)(66556008)(53546011)(38100700002)(66574015)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW0xZ0ZEMElkNWZBSHZSem04Zktad0Vpc1V3QTdmMklPSkxPOXBLSlErSzlx?=
 =?utf-8?B?Q0VSdlVpL3JRU01FamtVVmd4K2hLd0tveVo1S2h2d3NneXhFUE0wY3ZYVzMr?=
 =?utf-8?B?WWhla05jMy9sMFA2b09Xa3lTdXl2dkpYWVI2NldvV1VsdXYwM2gyRGNMczNp?=
 =?utf-8?B?c1E2L2lQQXQrQ04ydVZXcmNuRmtQbis0ZXNnT1BFT0pDSVk4T1dLSldhVFQx?=
 =?utf-8?B?eXI3eEJSV2NJTXNod2dmMllDVElTeGorQzNjVmMra0VKODNvakZySnV0OEZa?=
 =?utf-8?B?N1NPUE5Tc1N0bFNQMk9MalB4elY2Vlp4MU1TOUxmTm9ub1l5WkVyT1MvaFZS?=
 =?utf-8?B?N3NhZkxsbjlEUnF3Q1dwemZuczZYdnQ1d1JVanQ0M0xmTG1wangwSUl4SFZo?=
 =?utf-8?B?Q3d1Mlh1QVd2cVFFQzFubEtIenNhck1VRnIyTTFHWnQ5TXRQQUVKNXFmNDlo?=
 =?utf-8?B?aWtLMTlrMjU4dW50RjdZN2FyU1NJWUZCRVhjN0xzM1FxT0l2VXQ4WWszMEZo?=
 =?utf-8?B?LzdROUVCMkJ5b1Y1bGdTd212Q05NL0FGNmxpckxpNGtKWjZ1bTNWa0dVVHBt?=
 =?utf-8?B?VE1zTXk1OVBUUzJtamN3Sk5nbTdCeGFYS0M2SmlpNERBUEs3ZnJ3WFljMmRK?=
 =?utf-8?B?ZnNiTFZHbmVnMVMzRm5pMHBFMnIrWHpycWIxTVEwdVlBZ0E2REV4MmRGVkN2?=
 =?utf-8?B?UThET2VPY1pQM3h6THBOMG9TektzU2lKb1p5eDRwLzNDSnlibGw4YTI3OXZV?=
 =?utf-8?B?UTFKZkc3UXE0clFZcVRvdjU2Z2kwRkVkRkUzc0MvS3RXWDVwVUtnT1VodDNy?=
 =?utf-8?B?Yk9LL292K2lpWTFZUk5OTnRUNUM4RkVwbXhHOHBoYmxtclFGdkdMY01OSnR0?=
 =?utf-8?B?dzl4a1Y0a2RPUWo3ZmRBbktZOGtCNG9VOEZSMWNuZ083R2dSeG9hY3NCNk9u?=
 =?utf-8?B?bi9aVEZDMFlpNTFjQXZLbHZlTmhlRDgwSktCcFRMRS8zUGtkRXlsM3ZZZ1Yz?=
 =?utf-8?B?eGt3LytBYy80WTJsdTh4SDRxT0liTEVLZFp0RHdKdlhlTGxoUWRwRTJHMFlJ?=
 =?utf-8?B?ak15RkFqOWVSL2JqSDUwRjQ0VWt4ZFpoeGk5R2oyY21tQjI3QUtXNFozaGNj?=
 =?utf-8?B?dU1JWTNXUU1nYTFlalVNQ0o1OGJRRkFuSFlacm9nY0RYTkRPeHZvSzAyTU1m?=
 =?utf-8?B?MHFJSnhhMVErYVdKSTRmNitrWit2MTFVNVFMdDVSdUp2THpkVmdtSXQ2OGhu?=
 =?utf-8?B?UTd5dkhHTWt6NGQ1amJSTmhRak51SHQ5ZnN4Y1Y3SlhXRjVvcUtwQ3ZMakZp?=
 =?utf-8?B?QWNYTHpnSHJhbzM2UFAvRlovZEwxZEQ4SUxOei9Cam82MEpDS3R6dTYxOVpM?=
 =?utf-8?B?WHpuRHdWS0JFdE9TQVREQTZDK3Z6d2Fwa29hY2JmZEI5VGJHWG5IdVVIRkVH?=
 =?utf-8?B?MFJRZzF0RjZRZDMzdkZUQ3VBVlBXR2tBczhKbTdHazZjMXFSRWRvY2xjUEFt?=
 =?utf-8?B?dkdNYnpOKzJwMERxN2IwVi82QmpzSkgvYkw1MXZtbFVFa2lTcndPRDdTakJF?=
 =?utf-8?B?YWUwR0VJREgyWUlHdldkSTVjbzBEdElKVHNxZzlBNHZ3a1BUeUZ1ZjlYbnla?=
 =?utf-8?B?aGRBZHNjVHRHWUFLbFgwdGdhd2pXaG1PaE5neU9VWmxqMHFvZjBCTGRodU5M?=
 =?utf-8?B?WnpPTVhzOUFPNmxlTTUzdVZZL3VFRlpVcXV1STNlTUtlTUgzb2VqN3dPd2My?=
 =?utf-8?B?Ukw2ZHpiQmNFUkNEbHJabFM5clhpWkUrYXFOUGVkNEVKb3c2MXBpZlNsYW1P?=
 =?utf-8?B?ZCtoVjFOdjNObVZOcnRBdThjTllvQkE4V3BBUWoxL1MzUm1HNnA5L1d0cUdD?=
 =?utf-8?B?RWt5b3U5S2Q5RGR2cThzRnVmQTFTSE1aRGMyTjRQVlhwc1N5OWRKUDFLRHA3?=
 =?utf-8?B?K2cxVmVNS2F3M0JTcXRKajhxTldoenNrNEx6UXMycmhBNE1BRklXaFhYMHN0?=
 =?utf-8?B?OTlOVDRzbVZlNkFqYWFzdkZjZlJQSkd4emI2dm5wS2pySmtFTUlXWUR1elRT?=
 =?utf-8?B?eEZQdXN1T1dtQzBzMXZRSjB4QzJ0UHRaMFc1S1lobE00ZWVDOVordW91WDYr?=
 =?utf-8?B?YTFMd3FTaDZLN0lncDlha24zNkZsT1Npck9pQzJJRU1ja0JROTF5cGxFYXZ4?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ce546d-1f45-4230-f1f1-08db7c9fca04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 15:03:13.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOEupr+suKqTXRgJoO5QjfkbJH343zGa2JX1gxCft4BqVJ+rLa5rOpxqkg4RM9mlaoeYEbfnf43yxH94ha7xiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5702
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=JmbOEgLM;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe1f::603 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com

On 04.07.23 15:02, François Legal wrote:
> Le Mardi, Juillet 04, 2023 14:46 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 04.07.23 14:24, François Legal wrote:
>>> Le Mardi, Juillet 04, 2023 11:25 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>  
>>>> On 29.06.23 22:04, François Legal wrote:
>>>>> PHY layer in upstream has changed a little after 5.0 in the way autonegociation
>>>>> capabilities are encoded.
>>>>> MACB platform data tend to disappear after 5.2 upstream.
>>>>> Plus, ioctl prototype has changed in xenomai. RTMACB driver does not build
>>>>> anymore.
>>>>>
>>>>> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
>>>>> ---
>>>>>  kernel/drivers/net/drivers/macb.c    | 60 ++++++++++++++++++----------
>>>>>  kernel/drivers/net/drivers/rt_macb.h |  2 +-
>>>>>  2 files changed, 40 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
>>>>> index 77957d906..0648afa3b 100644
>>>>> --- a/kernel/drivers/net/drivers/macb.c
>>>>> +++ b/kernel/drivers/net/drivers/macb.c
>>>>> @@ -132,6 +132,7 @@ void rtmacb_get_hwaddr(struct macb *bp)
>>>>>  		bottom = macb_or_gem_readl(bp, SA1B + i * 8);
>>>>>  		top = macb_or_gem_readl(bp, SA1T + i * 8);
>>>>>  
>>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 2, 0)
>>>>
>>>> Thanks for the patch, but master does not support kernels older than
>>>> 5.10 (dovetail) anymore.
>>>>
>>>> Is this patch needed for stable/v3.2.x or can it wait for v3.3? In any
>>>> case, we need a master patch first, then we can discuss whether to
>>>> backport it as well.
>>>
>>> Well, I started patching 3.2 then submitted it against master. I can submit for 3.2 as well. I believe this is my target version.
>>>
>>>>
>>>> What we also need is enabling of the driver for CI to catch such issues
>>>> earlier. See .gitlab-ci.yml and all those driver configs there.
>>>
>>> I don't really know about this.
>>> Do you want me to submit a patch for this file ?
>>> Would it be something like 
>>>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_E1000_NEW
>>>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_RT2500
>>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_MACB
>>>      - ./scripts/config -m XENO_DRIVERS_NET_FEC
>>>      - ./scripts/config -m XENO_DRIVERS_NET_ADDON_RTCAP
>>>
>>
>> Yes, if that is sufficient to actually build it (check if it has
>> dependencies that may not be fulfilled in a defconfig).
> 
> Thing is, XENO_DRIVERS_NET_DRV_MACB depends on ARM. I'm not sure how this can be achieved in your CI build system

Yes, we build for multiple arch, so the driver should at least be tested
via the arm-* targets.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

