Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A4441D
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 05:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmL1qsyagrPaBiJIPZiHgWe1A6JJvmslwL10MWQH6r60k+ZElY64fDxgyulUXh8keiqwXtOnkv8NUeB/PJdnrjZGk4CUlRgKQHwlhv6GkPuD02bTHatFHpecUCeVhRSQICN23NblQubeY2tWZuSlUnqKqPxOYTNVcpg9LC/JW6iX/Qf//OE62+B3/1llP4CwmByKpLXq05UqaIJibbUmsHlEomxnmeuItyLiRZpv0LrVmAONnXHwGQ4zERFw9Nb0tQrODWNgPUXATRGpkFDz3yjaP0QpgThywHvEitKH61/MQpJm5Xrsct7vjGLh7Gg950ZBahewx+Id5OYu6I/ELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ht2yixUmgFL0ihyjO53hRb57qyXiPbvHcyPqJ1XCYE=;
 b=mtyZS4k8GxgWuUxytlFK/gv6FXXlLSz0JTbUIqDTMxV0kx73aSOYYnpQcLypN3HKar6zIaZDYrLvqqFxY1PlipAVbc9Oxa/nWY8KKX0x/djoDqeDFILFQpkCnBl+sPJX4wV7/7qjDJ6lDVV+AFTlEWD1qS8SmVChnMg+gLqkYQEl8h3xefdzl73n0+3JpaC3qJNjOQY4C/5J30j5z2RgaGqOV41/8YzOznO8We5qlcXRI9nNHTiyRjXpjUsddtap+43qRPwNxW8H/OPf8k2zI4Q5qekdLhb8uUKkUHP0Bd2jjveQPQaivROYHaug7JbD5ZIr92SRkb2Hx49axdyIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ht2yixUmgFL0ihyjO53hRb57qyXiPbvHcyPqJ1XCYE=;
 b=qmw4nj4oaPn8LZOLYJXFmi6dKY83OZLaD9y23yFGcNs3aDbx3wYia8TOCNnS/GBESkhFAJrbSytLPhL73t3z9NB/ZkBCvGtlJe8iDOAe5qdM8oGGa3e/rPl8YpnvYfFFlzDOH+HrI0OEL9Io6gz3yZGBmKFmC35TYZuKLoRTVdAy7HMI1skrKApFB1oqEna7cgcGG7Rr7QHEyS/jPHcktcwQfD8Cwxl+zJym/2hPZ2se6YNklh/cPykNOabhCU8p4434Oy1PRn9L8BCgyKP+h/39XFSsMfK5W9FGJrE2j60+zzLwQjgQTVD45ImTbTAyrB2BSZaM8azfUwb1kXl5fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 05:30:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 05:30:26 +0000
Message-ID: <62aed0c7-54a0-6b55-0e1c-cf9b268a1c50@siemens.com>
Date: Wed, 26 Jul 2023 07:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] y2038: cobalt/uapi: Migrate struct sched_param_ex
 to time64_t
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
 <c6dcd8aa-f50e-633b-8b6d-7755cce2b98a@siemens.com>
 <3405c588f25b0bb07be8a427c43414a0fa86e6c1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3405c588f25b0bb07be8a427c43414a0fa86e6c1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3657:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b02b78-bc91-4ce0-89e2-08db8d996af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y4heaKoCpXMH2PsdZ0atKvNnsTAXvx1wEnw/nLWRdcFqeB0cvau74uViSuENS3WT/RqcV/8GeBBN4F+0y1o6MJkziLrNq9BXDFA2zghqFhwiewgy8l/FiF0Ud0vd0oWNS/733Tp/OgROe4mAFLJHUUKVE/tUhzOaP794itCkpo9IUJLIuwNIR3K95682hV2KlykIKFLGvzuNXWwA0NYaofizM7iFGVGlCGHSHQCsJlK4TekMibFt+WPTP+QA8O2TqrHgL2IDCAiHkS7JIi8Op+x7Slg+S7oq7Npr6wAMvX4uCee3Co9qTFxNBY9ioRzIPW9bMfg4t24hOA8nnt3h34HiOm+Ni1y0GhFEnMUnOEg/FOPr+xW3DvA/qHbe+Qw3sDiSlpKVigsollpbBJH7VEABzjOjW2VHViQXYppRAa+tdezptj2zap4c92hsQwKdF+1JO7dRxkhw509zd0CioUCr8A761bSBfDTczI+6jO4vhNepHKURyyCVODuJSMqst84rZdeJst7ythde+RVs4GUufUibaiCQG91jmD3yonMntscGIhfL0KJOCIqEwWNvx99cpwf+dX7e+ZZhzrIvq6RuMdwcir3eqOKW7+PK2XZhfXDPGWemC49hNKIb/0X/RuHttCKNxiu+8mPZX7hsWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(31686004)(66946007)(66556008)(2616005)(41300700001)(38100700002)(86362001)(36756003)(31696002)(8936002)(8676002)(5660300002)(82960400001)(478600001)(6486002)(66476007)(316002)(2906002)(44832011)(6512007)(53546011)(186003)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXI2UTEvaFlrM1NWRjE4VUpocWxmVGF0YkRoeFV4bFUyZjF5OTUrM3hxQzZl?=
 =?utf-8?B?ZlNJTmxuVlFHVnZ3NDFSTEN2ZE40aS9lQzdvbmZEYWFqT3pTQy9nd0ZFUmlD?=
 =?utf-8?B?YTRUV1VGZVpwUEJVVGVrZkMwbXE5QXlWbnpjL2FWekZoS3RYQVl6NXdNUElH?=
 =?utf-8?B?ejBjWVpaS0pQUHVrRzRSY3dIOTBZeWlKRGllYk8rMDNwcnI5T0p2WUVaMTJY?=
 =?utf-8?B?QlhNaHFNMmlQRUpvMWdRTEFsUnNvQk1RdVA1U1R0a0FqQ1U3ZkZ1ZUhPRExO?=
 =?utf-8?B?RTZDcDRIbjBTbEdXTHhwNGVnNUg0aGxaTi9CVVBZenkzb2ViWEZOWjdUa3lp?=
 =?utf-8?B?K2liNzRiQVN1M3QxS01PeFFJbHMzZkhLUzVDdWNOcHdmMG9KMStvMGxmeFhE?=
 =?utf-8?B?Z1llNFhCRnd5Z1Q4NTYzakFCMlEvSjkxdXN3YVJlNGJBNStqdDJzalJJZEdF?=
 =?utf-8?B?OUJiZ0UrOS96MmVQUHNMc042NWxyRlVtK0c2S0tKNGI4WXN5ZERvMXdlNFhh?=
 =?utf-8?B?RC9rNUxSWXJVMnZZSU9ZeERKWnk2WmN0RnFzelN6QXoyU2MxLzR1c1F3V1FX?=
 =?utf-8?B?RVlRSnN0c3FPSGhXRW54VDBrdllPMExpWVZ3UDJjT0RpRnBrZ1hKTVRiY2lM?=
 =?utf-8?B?R3UyaHpSVjIrZnNqTXhOT1dYZjQzRzlTTjlaUnd4UnQ3QXRjSmJhTzh5WTRN?=
 =?utf-8?B?eHlDbkc0QzA2a2kxYjRwcVZVUXh3RG5kWGYzOUsvZ2NkQllSQWlRWUdEZ1h6?=
 =?utf-8?B?YlRYcUlCZ2UzQnhLY1JscVZ4MnV2Q216UnFwYmt6c1hTSkt2dlZQRENnUS9o?=
 =?utf-8?B?elR3cHhzdHYraFRqcU16cWNoYTBqQyttNDdRblhFQndMUGtxN0twckpWNG9U?=
 =?utf-8?B?elFIa2NBL0dLN3Q0UE9nUjliMVFsWGZiQzhhMTB2VHdCbU5QbElqYkJMc0xK?=
 =?utf-8?B?OUZ3V2o1bjFma0pUR3dHaUs2d3NwYVhuNDBLdG40Y293NFpaWVVycG1lKzNR?=
 =?utf-8?B?KzVmcGlEblkvbTRxcGNpTmVoZnkwYXc3SGdod3ltY1BYbSt5MjREbTRnZkRz?=
 =?utf-8?B?Rkp2c0UyQ3dlRkx6UTk1bkVjZWhNTGIvQ3B3ZGMyMlIxM3pxYzlZOXJUTG1h?=
 =?utf-8?B?cmQyVDZLMFNpM1JzczhNTElVRW5BNGRibjdvTzNGdzJlcXhEOUpnTEhjazlr?=
 =?utf-8?B?ZnJ1SGdLOWlPT3JSV1RZc2ticVVObGx3RnpUTDJpaEtabDF2OFc5NUtGTWty?=
 =?utf-8?B?Rm0yWk1uNjVNZk9uK1Y4eHAyRlJ4ZWFkSGp0UXJCZjdwWTBQaUJyaTUrMmI1?=
 =?utf-8?B?clBBOHp6ckhoZjZkQnlGSTQxa0NuRWp3cmRlKzg2ajdnOTdwRWppSklpTHVv?=
 =?utf-8?B?Q3BEdFpJOEdzQkVRdVRVOWxpNUZFMUZwUHgzWSt3OXp5cGxkU1pLUndURlU0?=
 =?utf-8?B?WnpjQVp4RGgxVTMxbktoZzdhK1ZGcVY5OEY5ZGFHWU53V0lMbVJNN3BLWUtX?=
 =?utf-8?B?Rk9LNWFJMkQrQysxMFFmWnpHaG5JR0NHMGJRL3ZYRE9ZWWlNUlczUkdMVG9y?=
 =?utf-8?B?cy96UkREdFRkKytKaEF0dUFEUko4dUxCYW1mK0xxUHFIdzhzYVhzbGRkY0Z6?=
 =?utf-8?B?ZEFFVUc0bS9nZE5nWDlwcGVaOS9ZTEhURTVQYUE1SzVqV0Z4QWd5dms1SHdu?=
 =?utf-8?B?RisvS1JIVUxySzAvdFlKV3NxUkZFb2RETDJ4TmlZTS8wV0tSMUI2aHZhZjla?=
 =?utf-8?B?QXczd3AvWEJsZkVrU3JRQXYzdk9CNFkyV0ZhYVNpNzl3OWNXVDBsYjE1UnpX?=
 =?utf-8?B?YnJnSU0yOFJRaURpMjl6MHRmeloxQWlFS1E4MHRFZnFveHNRZ1RHc2x5M1d6?=
 =?utf-8?B?ODhtQWVoQzRMVGt2TldTN1cvK0tlMjBZY1JsZVU2MmxNcUNXOWczUlRSYWE5?=
 =?utf-8?B?L3BwT0xWZ1Bta2tDS2RkZ2hEbENSazZqRDJRRUpURW5CbnlPQzVCazZ2ZEcw?=
 =?utf-8?B?S3JnbEVDcVhORUZ0b1hlSFNSajRSVjRRYUFWV3hQQUdIaDJrY2h5WFBVSlV5?=
 =?utf-8?B?OE5Kdi96dkN0aWR1SW1HY2dlTk1pZHQ3citKWXdoQSs2WHV3c0J4OFVjc05w?=
 =?utf-8?B?bEFVcklxRmdtL2gzQjB6VjJNMlZEWlhlazg4WWxPeHpPOFR5Q3FQblVMZjhi?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b02b78-bc91-4ce0-89e2-08db8d996af8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 05:30:26.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeni3v9FECCe19C+Ky0Sei9hIt2ynTFJQLz6LWSnzEwPtGbq5lWtAbBMcQNVMVaOXUVGOLHKu17fvFM0dKApng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3657

On 21.07.23 14:51, Florian Bezdeka wrote:
> On Thu, 2023-07-20 at 18:47 +0200, Jan Kiszka wrote:
>> On 17.07.23 11:10, Florian Bezdeka wrote:
>>> Instead of implementing time64_t based cobalt services for the
>>> following services we simply break the ABI and make it time64_t aware.
>>>
>>> Affected cobalt services:
>>>   - cobalt_thread_create
>>>   - cobalt_thread_setschedparam_ex
>>>   - cobalt_thread_getschedparam_ex
>>>   - cobalt_sched_setconfig_np
>>>   - cobalt_sched_getconfig_np
>>>   - cobalt_sched_setscheduler_ex
>>>   - cobalt_sched_getscheduler_ex
>>>
>>> XENOMAI_ABI_REV is incremented on all supported plattforms to express
>>> the ABI breakage.
>>>
>>> The memory alignment of some data structures is changed by adding
>>> some anonymous paddings. This allows us to remove some compat specific
>>> services afterwards. The memory layout is identical on all platforms
>>> now.
>>
>> While the cleanups are enormous, I think we need to make sure that we
>> are not causing subtle issues to applications.
>>
>> I first thought we are only breaking the ABI for internal communication
>> kernel<->libcobalt. But some structs you touch here are used by
>> applications as well, aren't they? And then we are now exposing 64-bit
>> time types to them. Will they be fine with that? Recompilation is
>> needed, that is clear, but will applications not supporting 64-bit time
>> types yet nevertheless be able to use the 64-bit extended structures
>> without major code changes?
> 
> Recompiling is necessary, no question. That should be OK as this is
> targeting the next/master branch exclusively.
> 
> We never had any time_t in this API. We used our own data type (struct
> __user_old_timespec) in the past. This is why this "auto-conversion"
> with glibc support does not work here. If we would like to have that we
> would have to use struct timespec and we are back to v1 of this series.
> 
> Userspace code should use struct sched_param_ex and friends which will
> now hold struct xn_ts64 instead of our previously used struct with
> identical member names, so no problem expected. The testsuite stayed as
> is right now, that's a good sign.
> 
> struct sched_param_ex is part of the uapi, and hopefully only used
> there. Even if an application decided to use it internally as well that
> should work. Different memory layout but everything else should be
> backward compatible - only a recompile away.

OK, I think now we can go this way.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

