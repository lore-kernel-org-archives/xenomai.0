Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9221C3D
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 05:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnn+FkUiKXU3RyADe1Bvm1s0nEU91DcdEWXTbzNUvomw7HdstJIsiVFN0jiGYB6dr6bO96YUCDWnNNqMiT5yWE43OS2kolbsgjZzleMhsGHDJeB/OivZ2ecGkWoUklLRz9/kdMkSDBQi+U/x5f+zSDNuPtjtf9e2u0Hl2Eirvvq/bww3kkl0PsQ3UTETR6h0ysyMVXXJmuohr/7mXLVrty+GIOeErXBLgDCNA/z0FzBz36UpK+nKA/rZGsQ8+5PO/UYic6sV0xC6BtO2dzv6zcIe547Uvt3xMNZfw2BS4ssYRBP0inwL566kdfYLMAjKKXfGBf+Je8W3c39DKATDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1igH2MmCvFwTQcHWSfHE++Ts/+uKtYw+iZTi2NEnAlU=;
 b=BkyE/GYPXxrTsk0vHIx3YCuBYNPRTkFSuyuLfEcHYHdGO47F0frstF4II+lpQKlTD+4wKjlCTVZaYJsiatoBlkYBr7o9BiiyWUpLLKIgZzXnbo9NfJ4SBK7sF+cMs7d/s0TW46ALBqrq5T/xIhuzBSUEoJr2culzhsB9yU9OJLQ1fw5dBB2HTkdyt7+ze1p5KtNUKnJ4lwi4l9wUHsbhNjZCivdf9fC98AwuBJZm7aDl/dQTtWKrKOT41YBgFh3Zx9b7Agikrq+E+UPNwjXkHXj8OJnEXqCaG+QKbHFKIVsKnCwZkYvk1UGEKB1X6a+W8rbFNB75MJz2JlYC5D0pJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1igH2MmCvFwTQcHWSfHE++Ts/+uKtYw+iZTi2NEnAlU=;
 b=qt5d8BfbgNBnmnAbwYWi9GrVquMAR4HWtG+KAgV5NDwLyOvnT5ttpYf/eKi8EW5SdLFujl9Phre7FE2A4SkFl1KTnyQ94JzLOgt3rnyuleis0J+2nQpoW5M/vr5KFYkGWdySsOClXLxU2uBlwh7YVwSkZnhDNSAykdVe9KrzawHNsED3wKPboJkqOMYUyMvKH4h6HhB6IOT8NgzTidKjdpQ9E4E7mLDQNPRwSiTBib3EvO+2BkTsshRpXyn8PqnJduwm+syFcMXFx9LdTLGg2cCaYhuDHoF78iWX+pNcyBygrSKP4qRxo6Sk7u3Kyo8MvKoZwdTyZ9vab8rCHbOgeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7416.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 05:23:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:23:24 +0000
Message-ID: <570ca1d2-405f-481e-5290-bbda703d98c5@siemens.com>
Date: Wed, 31 May 2023 07:23:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/4] y2038: Part three - support for select()
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230516-florian-y2038-part-three-v3-0-ecb4d58538d7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v3-0-ecb4d58538d7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acf1947-d4ef-4316-3d1f-08db619727ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	998rnXLKrFJ52au9CZ2o11LQgjvPBZG0Vlk7q4ulNdMtbX+dNa/GkH7xhzpRvJzxhMb1oLWpwfbC5dT3pgEFIo/qoPxYFKLZELyhEFOw95I2zVZWTPDALm+cBoy0h3zAvt/sbooKuZJTGK8XG1OzIdzVDD8jS5eXfXjH6BjEVPzLDPRjQ/lrxo7HX0SFHVhL/4srIXfxfpx4vQByQI7vhd1ER4tEhLDQiO42LiqmcSZP3Qdg+vSV86s3YeOpcSxL1s+7j4HEsH+oRXiKUVZajdRRT87RZjFT9kwKP+exLReV+jxixdYhhMrKA6LxvFwimcpLavY9WHBWI/TvMW5mlw6q7Z2oEtrEM0kl3gV8HzgZoltOPs8GsXLqmL6zyAOlJp+BsOm5nOBNch/5pCXlrsFrhZ1xL7eLimWSs63qn0g4+AgJy87IPkKTx7kL+7g9UHGL2RXbMLoDzFAPJZX3wtLIGw6Vsc3sK5ZiSZ7+z5rACjPCh3+3BiVJerDwSUdJT767ZbOidqkIpl8Z0hJCWJGIjZWNz3M3aviFefKOaQK1GtgB0AV/YBny7EF8dJjBmJUzWrmrVQJVLS43J8lya3s7gBRlpWg5cVsLsTrP8iiWzYF7ebGOOmBZuPOob9Cktzv2Mh0AQLASlXvS2MFzhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(31696002)(86362001)(66476007)(66946007)(66556008)(44832011)(8936002)(8676002)(316002)(41300700001)(31686004)(5660300002)(2906002)(478600001)(38100700002)(6666004)(82960400001)(6486002)(966005)(83380400001)(53546011)(186003)(26005)(6512007)(6506007)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXZSVjQvcWVBdVl5aFRGRWYvU1dDY2dPWDhmMmpHMDFnNzBjLzJXNmIyZ2Jn?=
 =?utf-8?B?QXQ3UlRkM3p4eDBlQ1JLeEZsY3hiQTNEUFUvcmN6d1hFNUI4TENBWHUvTXd2?=
 =?utf-8?B?cGRYbExqcTV1NVNsTFRoWTZIMjFnOW04cUIyc2NnY3FUQ0FXSEJ2MXBwSVFR?=
 =?utf-8?B?OUhTTHpCUlA5ZStSVGpmTkhFLys1UmIxRC9qeWMwVnJHVjhEOTZZb3hjOFU0?=
 =?utf-8?B?YXpSOXJZY0E1ZDBFVG1iaHhZcitvS2xScjNIbVNmR1hCTkhGbzU0YW9xUGlK?=
 =?utf-8?B?TER0dHgvK25EVWE5UmkwMm00cVlvQ2ZEbjNiczh1SC9ueGZGOFcvL1IzTzVE?=
 =?utf-8?B?NGE5V3FxamQ4RS82TUlENTJmYkk3bmFYdE90RlorSkZkVVFNWlFhS3dIRDFZ?=
 =?utf-8?B?OFVmazFRdVUwdzRRT0FRYWF0anJ4SWo1RGJIV1BtQjRORTRRcXNhSmg4NnFE?=
 =?utf-8?B?a3RvTmJSeFIrbWlvRTAwdXgvSCtJZFFoNFdvOUNCZUM1RGRzT2MzRDJHYlVv?=
 =?utf-8?B?cFJJVTVHN21YRy9ZaFRvY2o5WlczNmlHbE1wNHR6T3pkeDFXT3Z6SlM2ZmUx?=
 =?utf-8?B?aXYwb1FpVHVOSldQdlZZN05hS1l5ZW9tT2tmUUpQNjAxN2JlSlBidXhHREkx?=
 =?utf-8?B?TWxIcDlwVjlaRGxUV3U5MUFDeFRoMC9FQXhHRndjSFJqT0FXMGRzRkc5ZE1n?=
 =?utf-8?B?U0kwSkkzZ3BobVk0RHNTb1dNcmVnWHR6U0dyMTRjYnhHcjNIZG1wenFQbUtH?=
 =?utf-8?B?dTk5N0RSSG1mVDNzdld0RmRzcmwvSE10SnBGeTFCK2dleERMWEVJNzRNZkM5?=
 =?utf-8?B?ZHFOcTNYU1gwMkRiSUY3YkxFSjhmMS9mREkvTWpDODFzYlhENEdud3BIOEZE?=
 =?utf-8?B?a2d3QmlmZmFuWXpPeUsvMFlxTkJNalBVVzdBZ3lBL2YxWi90SmV1R1NvYWU4?=
 =?utf-8?B?TFVkbzhtTU41eHRaU1B1dTRJRlFjZ2czUjJ0UC9IWFMzYjhxNHpjY2MrNFdL?=
 =?utf-8?B?WUtudGMvSnp5R1NBQ0hzOXZDam5JbitvU1lQeCtLekRKeWwrdXhDUnF3a09a?=
 =?utf-8?B?cVVDOHAyRXBTRk1EWE0rVzd1ZzZYZlVYWTJYSTMxUlR1T3NhT0pYcW8yQUNj?=
 =?utf-8?B?eDduNnIxK0xBMGZINi9KMGQwZkZuOEFjTXBLOW9neWVYNXI5MXhHQzVMMjJN?=
 =?utf-8?B?ZkRONlNxVTU5SWR5QU03S1V6ZG05SFdhZUJBa2oyZWdRUmhpekpTdElNQlc3?=
 =?utf-8?B?MHBVS3JTdCtRTE9aYUVtaG10aXhwQzdrUHQrYkFWWW9kMWxCL0dTamhtN0xC?=
 =?utf-8?B?TlRITEtiVnh5ZzFUN0ZWZk9Pb0JWdGl5Y0lnZjN2dWlZb3F1bmhDeTlBN25X?=
 =?utf-8?B?VUVxME40dVBFMXRMdzU5RlhXSkJVejBPQnQ0czR2aDFHUmdWSU9CSHhJa0E1?=
 =?utf-8?B?SVpNSzdhU2oybnZQNWp5NlZaZlB6SWljbDVwbGE5RTJ1Y2hpM2o0ZkpISnpq?=
 =?utf-8?B?L0FsYU9ZWkpmVVp3RWdqNEx3Q0g4MlJRS3U4YXYvTXAzTTAyL3NYV0JsVyt2?=
 =?utf-8?B?V3NlRkxkVDhMNzk0ZkUyZkhqdXNITCtiellKaUFUOG9GWFBvdVA1bVZEQ3lH?=
 =?utf-8?B?QUV2QVRKa1AxTDc1V25GdzFXbTUwQVFLZTU3ZGlpaHdWNklqYnZvcGF2elh2?=
 =?utf-8?B?SS9vVmpjTlk0OFBWNEZxQ3dzcGxoalc0UzhDOEMyZDBaZUJ2RmhhMlYzbGZa?=
 =?utf-8?B?OS90S1VXMm55TW5BVGgvVWI2bG1qWHh4c2ovenNmVy9ReTFMVFZOK1JDWnF4?=
 =?utf-8?B?aWYxOGRCVE05dDJiN3l4c1NnYVE0VURQWk1rWFA5ckc3MU81ODRHVzNOK0Fo?=
 =?utf-8?B?VStnb0tFOXhMWEdlUy9ydWxSaVRmUzFuODZkUUxFM3hrR3Q5MlBDTDNrNld0?=
 =?utf-8?B?VjFsck15NVZsejdVVEtXbG53Sk5wQ3Z5NzJ5TmxFWHl2RkZtOXV4bWQ1QTVP?=
 =?utf-8?B?QlJweXBMNEhFbFluNTJoTHVDOHdoNkE4WnpWWldlZm1wT2FTajhRSUs5eUwz?=
 =?utf-8?B?dlFNa3VJWC96SUhNV01sZ2VSMU1DM2NnZU85akpWNC9OQllSeDdlUTh1WkF4?=
 =?utf-8?B?YVpBY1kxd1c3S1dhZ0dPWnhTRmNhbmN4R1pmN3FNWGhEdFlTZTdIRHEvdHU3?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acf1947-d4ef-4316-3d1f-08db619727ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 05:23:24.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V405Im3zbjHt5Cpbup9jIpFoUdaDob83q3VXVijiqj3U32LHnSDweasF2rXSuI6Kcqdt1lCWllpMDPj+ERSnpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7416

On 30.05.23 20:57, Florian Bezdeka wrote:
> Hi all,
> 
> I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
> next/master branches. The full queue [1] holds ~7 patches. I'm trying to 
> split that up to keep reviewing efforts low.
> 
> This series brings y2038 support for select().
> 
> select() is somehow special. Linux does not support a y2038 safe
> implementation for select() itself. If the application needs y2038
> support the application has to use something like the pselect() service.
> 
> To make select() y2038 safe glibc wrapps select() and wires it to the 
> pselect() Linux service.
> 
> Xenomai (cobalt) does not provide pselect() yet and it's not easy to 
> implement that. The reasons:
> 
>   - The underlying xnsynch infrastructure is not prepared for waiting for a
>     combination of file descriptors and signals. (Let me know if I
>     overlooked something!)
> 
>   - Implementing pselect() would require up to 6 parameters that need to
>     be forwarded to the kernel. Xenomais current limit is 5.
> 
> To get select() y2038 safe a "pselect64() like" service service is being
> added. The signal part is skipped.
> 
> The wrapper for __select64() will be added later and will convert 
> struct timeval to struct timespec64 in user space. This way select() 
> provided by libcobalt gets y2038 support but pselect() is still not 
> supported.
> 
> Best regards,
> Florian
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v3:
> - Patch 1: Remove trailing comments, document error handling 
> - Patch 2: Remove trailing comment, document error handling
> - Patch 4: Rewrite commit message
> - Link to v2: https://lore.kernel.org/r/20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com
> 
> Changes in v2:
> - Patch 1: Do not skip updating the timeout if fds changed
>            Fix is in all entry points.
> - Patch 2: pselect64: Same as above. Do not skip the update if fds
>            changed.
> - Patch 3: unmodified
> - Patch 4: New patch. Fix timeout update in case of -EINTR
> 
> - Link to v1: https://lore.kernel.org/r/20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com
> 
> ---
> Florian Bezdeka (4):
>       y2038: cobalt/posix/select: Refactor __cobalt_select()
>       y2038: cobalt/posix/select: Adding pselect64
>       y2038: testsuite/smokey/y2038: Adding tests for pselect64
>       cobalt/posix/select: Fix timeout update in case of -EINTR
> 
>  include/cobalt/uapi/syscall.h                      |   1 +
>  .../cobalt/include/asm-generic/xenomai/syscall.h   |  22 +++
>  kernel/cobalt/posix/clock.h                        |   6 +-
>  kernel/cobalt/posix/io.c                           | 109 +++++++++-----
>  kernel/cobalt/posix/io.h                           |   8 +-
>  kernel/cobalt/posix/syscall32.c                    |  23 ++-
>  kernel/cobalt/trace/cobalt-posix.h                 |   3 +-
>  testsuite/smokey/y2038/syscall-tests.c             | 162 +++++++++++++++++++++
>  8 files changed, 290 insertions(+), 44 deletions(-)
> ---
> base-commit: a74abe52269f191654b449357bd9aaa57f2cd75c
> change-id: 20230516-florian-y2038-part-three-3093da9fecf8
> 
> Best regards,

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Competence Center Embedded Linux

