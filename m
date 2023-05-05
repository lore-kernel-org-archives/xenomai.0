Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C5D301
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 21:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOPpMi/I5h3OYkWnXuCiAAkVMTOSVOj3mW7eLCfAHjN7AzVd29AOaQKqQZn+REFXy+12U+FKSx5+r6zyQyPQx8YywsgX0U6MTVOOGV7L19v0SWpvXrIeiYxSDYoeaV+rEAwQgv4l60kK2r6AWJV3mJsT1UJqqLQRsaxNEuFgty5GjizclIF61E0J990vSrVs6+nbBCY0LgPEWEg+VXnBHtTCNXJdDVaxiboTQVNHMNCZXFkl5auuqt5Mv5bRnS/kRfLchB0QzR/KldpARkNkDf/k2UMrmxehtpPC7nWYX92zcm8A0osz5UtxbP7yI98vy68YQM3VA77oQlD7ewdFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VotmVRmnRvd2mh4/PGuFUxOLfirIBv1JVLBk4XTkVeg=;
 b=Idr5TWaC8StwETFQ7WMn5BT7eHgoT7ItO2//OglxQW14vduxz/3DpwsYAS67eGO1HtepbRkYsCr105Qvd8UNXowt19CmXIhIWJ0kTo2a7F4PexxYkwbD8VMZNfAEpqOF8thQyW6tRlwyLtGr5jeQCrOgg3YkJHgyGuntm8KtUihqPnY+aXjgP4J/LneKxiSIvh28EE9+ksaGrm9o8GQxK++dSrGDb2pP3B4Rb0oJCDtCeZghhPoC9N/zwNy0svMpYjE3C7rM1P297eZrGvzVQumMVWpd7c7orRa3OfzTaq2YRAZ3JlWQGWcoBeuP9Q1hNONyOSQi8XcB6yWFtTb6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VotmVRmnRvd2mh4/PGuFUxOLfirIBv1JVLBk4XTkVeg=;
 b=Ev4+moEpHB6Tf3lKrCPUQr4VeAjeFKlJf92dWFosESSxSpa8u8kOGidiRcHdh+ZMRrUm6vAGCmuMhi89VG5kVN8r61n00GOwXAYjYYTbWtY6XvcRQ+KyBbGMOnJ6ET0iYeoZstA41MfLH6B3UBVud06KN4nB/0n0NbJOFaAwl3vZz98Sq8w440di+TrXHfbnm6pk4p6YBn0unRqVvGoKBrGZI+AlExuFOk7nzftAYjUWXwmtiFc5tWr3qb61mm1Zhtbh0IHs3SukLRJmnPmJUtp7li6mJrg0E1ttui79TOycr2huDuqE30+AJWp59S20sJh0rF/wJnHRETIFwVjhXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 21:20:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 21:20:42 +0000
Message-ID: <43968a71-3b96-d886-afe0-32884f0b804e@siemens.com>
Date: Fri, 5 May 2023 23:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 00/17] y2038: Part one - Cleanup existing implementation +
 general preparation
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:208:55::41) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1bb09c-b8dc-422a-d721-08db4dae94b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qs9Kg7y5VKuzgJtnVSj1NzX5yI+vpgnK/o2skaN2uf3cSzl0ofI/ZZaEL5GSoT3zoUE+I/v6EqaHdtO83Zei4HIJsDXuijIPsFiujh6snw4df+DHz6wf+sGgcTjCVIfLQhlAc0pu6QwQpOVWZ3OYsXzgPMfgaYJ4ZhF4wJAJJtrtk3hdrW3k4qbTG0Af7dRPZgZV728oF143NjQBS93F1LIltKz2tlTeQ18PZik8Vdfl2SwC2kRSf4RKyP20BgRw+jckwgFfa7xBp2eLaDEV9t4jWvd4+7SSuRNQtQpaQMgsTbuoLpjmG2bqmHxtLqIiaCWZ3+QngL4sT/zSw9JWyG1eoCguujRa+GKwvAjGPkyoqX8If+KT11/i9/C3x3j+7nWANLiJLGhCh02m01+CzGgHimRCp92zKYT+G9XUHKuCdlDQEpFjwIb6Ihv+0qQp5QSbLbB2NPqWssQcPqOlNj192qbVaxx1R8mausj4c1TRobwHuiLSnv27w7XpOiQG993gWdKNxpocADehDO+oLIM0gj+iiRBA6amGF2u9iPnIV9s8QKbiLU+7UQngc7nKV7dVrq/FdLiBpuERIRB/HClkTwNXH0tVXGrzhmDbAX3/h0smXOdpzSTR7TvEoBjQWDTqyJsBnUq358znr9BxPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(2906002)(38100700002)(82960400001)(6512007)(83380400001)(2616005)(53546011)(26005)(186003)(6506007)(8676002)(8936002)(66476007)(5660300002)(44832011)(36756003)(966005)(6666004)(316002)(31696002)(6486002)(86362001)(478600001)(66556008)(41300700001)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXhXZzBjT0NzUFVXa3Y4Vy9ocm8vUkd3b0Nuc0Q1d2Q5alVJb2haWFByT3Jp?=
 =?utf-8?B?MERPaHNVcjlrU2xyZkpzcmRtMkxWOTVobituR0RSczdROFVJWHhJeGRDanRo?=
 =?utf-8?B?dVFTM2ljejRWQ3ZGTUtNYkhSSW1QSUVvcFpsaUllNzh0eGVVQ3JCZlk5SUlF?=
 =?utf-8?B?bEVSa053QnVPakpaRmJsQmUzakFNZTR1Nkh0ZDNSakJhMW1vb1J5NTRSeEZJ?=
 =?utf-8?B?UVhSeXFEZ1ZlVEZOdmpIb1pYbFhBVGdUa1hSZ0VNbGZXS05ZUTgyWTlVV0VK?=
 =?utf-8?B?VnFmbjRpSmZJSENrUU9mYnBqUVVuQ3pDMzlEV2tNWFhQYjBMaisrako0MDFh?=
 =?utf-8?B?QVF6eFNzTEZ2bFRQOVRPaGNpVllzd1dWRVcycFg5NFRMY1Eva0tVYU5QL2sy?=
 =?utf-8?B?TEdvU0VkRmpaTXBpK0d0Sldrd3Q2dFRTWksrY1pkRHNSVGpSMFhic09CU0Jm?=
 =?utf-8?B?VjIxL3BseDZBV1VJL05zNWhqcWRPa1BoZE1mUDFnYjIvWWZtR09uclc4SVRQ?=
 =?utf-8?B?WjIrN3JSRVBuVTNXZ3MycDdYSEx0V05FNWJRTkE3ZUVnRHhoZ0ZEdTY4cGNl?=
 =?utf-8?B?WlVZUE9pd0FSc1FUVnhhWWNYTWQ0OU93aWh0bjZxWSs4cXpOOUNWVDJZalVs?=
 =?utf-8?B?ckZTQ1orZ3ZEN3ErWUZvMWQ3THpyYllGbXVEUzZlNnc5ekpNcFFwTmROcER4?=
 =?utf-8?B?TmxwR0lhdjZkcXR0cGNBN2tMSEFRb3ZMdlNyclFGSmlnQ1NHNjNiUmUrbXh3?=
 =?utf-8?B?VW9TRURFTHdBVWFQdTVGbGdNTGFvdDZPV2c1aVpwYXRPWDZUcG5OOTZlMnRs?=
 =?utf-8?B?MS9TQlBGR0FabytLb25pdTJQQ0ZYUHFqODY3V090SGlGalhyQTcxb1VtUjRU?=
 =?utf-8?B?R1c3R1o2b3haSjFOR3hnMGhzcHZkbjRhYWwzcnN3Z3pQbVl2NEx5MjFqcW9y?=
 =?utf-8?B?OGNTSHU2MHJlZlZsbjNOR1E1QXp0OXFMVStZOHF1NHMzM1FpSDBWVWVsMS9M?=
 =?utf-8?B?NFRRZjVSMmxaZndTeC9nbVF4QjYwT2tHSzJsbjkyOEYrdlUzL2V6YzR2Q3JC?=
 =?utf-8?B?bW9NcTRubk9ONnkzQmdaRG9sNTh5VlEzaGw3bU9aR0x4SHc1dTFWWlJmcUc2?=
 =?utf-8?B?SUtQdHd6aEZiSytWam5RZ2RnZ1dnRHkwQzhMaUhtWDJYbEVRVXdLV0ZYbnFj?=
 =?utf-8?B?dVJNd1dXTWQ5V05FU084clZKTHhJWU9peFl5b2EvOGppamVJK0FLZDJDb1lQ?=
 =?utf-8?B?dlJhTHBUUW5sL045eDk1blpSNnd5b2hIY1Qzaisya29mNzQ1QVFZb2hpWEpB?=
 =?utf-8?B?NVM5OFdRV2dCYW1PaHRMM1Rsei9BajZTMzhmWWdGekdvYjN6ek02MU5wM0Ft?=
 =?utf-8?B?RTc4b1JvT3RMNW9SZU5NcjRJckEwYVpsMzJ5SkdlYkh3YkNsT2t5OEh4WFE2?=
 =?utf-8?B?TmJIdFlEYkNFcVFZZ1Y5T3ZyYlFvWFhLVk1ubVVJUGFENEF3SURyWThlMi84?=
 =?utf-8?B?VVdhcWRhRDNXTzZ4QlhOaGNrQnZwdnpJWWp4V1ZrYzR0ODlYa293akc4UE5x?=
 =?utf-8?B?MDl3cnNUczZUM1ZKR0JrbVFtanRIeFRTWFVuSm14WmFnaDBkM0dKaDVxNkJJ?=
 =?utf-8?B?ODF5cDZBR0N0OHNTQW1ORDBhWUVkd3g1VWxldFVPRDFzeHBuclB5NEtldUF1?=
 =?utf-8?B?V2RmaWlTTy9CRjVjSnlnVjFzbnBSQzFDaWJCSHFmbTFZQng2Q0FLODR6eHJl?=
 =?utf-8?B?RERtSTRZa0hFanhYMzhVVVNOamxoa3ozMC9lOU1CM09nUWRpME4vYkVlUzVl?=
 =?utf-8?B?QnowTHpTbXFqekovd0FCR29PRHA5SUhSRlgwajZ0RW0vL2NxZDRuVEhpcnAz?=
 =?utf-8?B?dzlTN2xYVjZneFJZdmZTaWJ6akRDcTE3dW9BaGMzcmVzb09KdXhBbUxockpk?=
 =?utf-8?B?QUhDL3BFZlFza3lWM25tTXZWOG5ESjYwcnh4aDNDNXJONzBaODlyZTAvYnp6?=
 =?utf-8?B?U0xQVEx2cXBMNEd0elVrWkg2TEV2M1VCbFlBbzN6Q2owb3lhQ2RUd1BSS0g4?=
 =?utf-8?B?ajRWZlFvRmZpRldjd09PME1HZXU3ZFg5T3pKdlFhTTN6UDJSOWJSZlEyUlRO?=
 =?utf-8?Q?145bS4EdzokgRrCqOIq8aP753?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1bb09c-b8dc-422a-d721-08db4dae94b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:20:41.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzFiRkADS/xilJcUy9i/xABDiy0gBo/0GBkUJ6MNnKXUxhLaQFfczn1irav0l6K9xZziluEraC/nRyvxx6PrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7184

On 05.05.23 09:20, Florian Bezdeka wrote:
> Hi all,
> 
> I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
> next/master branches. The full queue [1] holds ~40 patches. I'm trying to 
> split that up to keep reviewing efforts low.
> 
> Part one of this series:
> Basically removing some unnecessary compat syscalls. While initally evolving 
> a pattern that we followed for all the necessary syscalls we overlooked an 
> existing compat mechanism, so we accidentially implemented to much.
> 
> Part two of this series:
> Minor refactorings, fixes and preparations for 64 bit time_t.
> 
> Best regards,
> Florian
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (17):
>       y2038: cobalt: posix/sem: Remove compat syscall for sem_timedwait64
>       y2038: cobalt: posix/clock: Remove compat syscall for clock_gettime64
>       y2038: cobalt: posix/clock: Remove compat syscall for clock_settime64
>       y2038: cobalt: posix/clock: Remove compat syscall for clock_nanosleep64
>       y2038: cobalt: posix/clock: Remove compat syscall for clock_getres64
>       y2038: cobalt: posix/clock: Remove compat syscall for clock_adjtime64
>       y2038: cobalt: posix/mutex: Remove compat syscall for mutex_timedlock64
>       y2038: cobalt: posix/mqueue: Remove compat syscall for mq_timedsend64
>       y2038: cobalt: posix/monitor: Remove compat syscall for monitor_wait64
>       y2038: cobalt: posix/event: Remove compat syscall for event_wait64
>       y2038: cobalt: posix/cond: Remove compat syscall for cond_wait_prologue64
>       y2038: cobalt: Cleanup code style of time.{c,h}
>       y2038: posix/mq: Fix mq_timedsend syscall routing
>       y2038: posix/mq: Harmonize mq_receive and mq_timedreceive
>       y2038: testsuite/smokey/y2038: Fix a very unlikely resource leak
>       y2038: cobalt/posix/clock: Use timespec64_valid() for validation
>       y2038: Prepare code base for 64bit time_t
> 
>  demo/alchemy/altency.c                 | 26 +++++-----
>  include/cobalt/kernel/time.h           |  2 +-
>  kernel/cobalt/posix/clock.c            | 59 +++++------------------
>  kernel/cobalt/posix/clock.h            | 16 -------
>  kernel/cobalt/posix/cond.c             | 12 +----
>  kernel/cobalt/posix/cond.h             |  5 --
>  kernel/cobalt/posix/event.c            | 26 ++++------
>  kernel/cobalt/posix/event.h            |  5 --
>  kernel/cobalt/posix/monitor.c          | 26 ++++------
>  kernel/cobalt/posix/monitor.h          |  5 --
>  kernel/cobalt/posix/mqueue.c           | 10 +---
>  kernel/cobalt/posix/mqueue.h           |  3 --
>  kernel/cobalt/posix/mutex.c            | 10 +---
>  kernel/cobalt/posix/mutex.h            |  3 --
>  kernel/cobalt/posix/sem.c              | 22 ++++-----
>  kernel/cobalt/posix/sem.h              |  3 --
>  kernel/cobalt/posix/syscall32.c        | 86 ----------------------------------
>  kernel/cobalt/posix/syscall32.h        | 55 ----------------------
>  kernel/cobalt/time.c                   |  4 +-
>  lib/cobalt/mq.c                        | 47 ++++++++++++-------
>  testsuite/latency/latency.c            | 34 +++++++-------
>  testsuite/smokey/y2038/syscall-tests.c |  7 +--
>  testsuite/spitest/spitest.c            |  6 ++-
>  23 files changed, 116 insertions(+), 356 deletions(-)
> ---
> base-commit: 967cff01b071f2799db1de4d088c396a40a074b6
> change-id: 20230428-florian-y2038-part-one-713ed4f37308
> 
> Best regards,

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Competence Center Embedded Linux

