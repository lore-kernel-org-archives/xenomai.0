Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877E2F2A
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 17:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB6vYLo1YPS+ev0LmyUmo/k/ACswXZGpmUEWzHI7qJJKJ6+jLCdcV9kTM1fpZlO7fL9afAyLUy8e5XDDmIE5GeR6e+S6mSmhIzZKTLBlazh4pp/OXBUAxD6he46ge+EXLDQdbbiC5tMV156sV3Kad1p0I0zdQ0hEvcdA6QDFdWKLICs9sXz3l3wL5zB9REc99SyPpya62DIJLvOdhtFjCHeJOAycmKgrsfeGeAXqfMyrYM4VRWrPBCA9DXn/uOOCY8TGABjlkTx8b4TT6tQs1aCD76aKtXk9zEY3MHhpelcBYbpGQS1jdne4jAPmKTNbHvwlrdWfg08jHNglZ2Irjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isgpE65HrtBu5InCE/95hnjQNKcXhvpFhK2FO3FlRl0=;
 b=K1An7L1QY9S6DySDmxPqDSYdon2NqkTyiDO1peeLsIu96FeRpz5Z3vvbs7scqa5ZiiNoonUwdDH9ai4RhJ+z6g0PCc5gtRUnM3uVE8LAqRb7Mx3LhhipmCFOZ7RkUJTAZxn6govBjqlCkz5IWOb8nSbSLXhZWLMYCAGt8+JW0jbHPt/vgD2NhKRgIu+lay4usFpM9yzZQlyKzptJgPwiiHpXRkC1Gdh8+SapnwmqLZjBmadolISWso9nLDECyDHn+rh3g74btQRn1lrrNxrAMvWyHEfYkHEiUyI9RWjn7H8siFnuP342ZrjDlZlb3yuFV9r4hyqZLfJ5174d/Jl72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isgpE65HrtBu5InCE/95hnjQNKcXhvpFhK2FO3FlRl0=;
 b=eItdQCfrTVM1IxgycZFJmmIV4tpzPOQiXkjS/aMvUVVcqDAj84V7XAxvj2QYiPEMHq0VizpTbC/XePgwZ6103rNnAZd/uEMI05X4g/emrkZ1Fef8ROn0ULUKcHIxm9vjp3Q2uS6SRe6ORdwwb6nrhwKZezTbHFDXkx06yTXZDUpPMiOPW3Zt29sEby4tO7ykhfzCG8hY6kmpJvX/LQ2Jeic8B3edR18aEs75Wb7t3ehITj3HVfkbcN6b3wnloij1eCtoAo+cQIHzmTYlARuS7dajJD5nokFpWbTkwBhc7KoyUmC2SvQBxWueVPo8SvkAaaEbs4tq3uT59XGsNe6vdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 17:50:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 17:50:42 +0000
Message-ID: <ca37247c-c156-9832-f2d9-83f9b8334b92@siemens.com>
Date: Thu, 23 Feb 2023 18:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [stable 3.2.x][PATCH 0/7] Add full smokey compat support
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230223070417.3969366-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:610:76::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebebaac-a9dc-488e-b089-08db15c67b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9UirlbtP/HzW1V3sMwBjNEcYm4nOGKYW9m2mK8pkWvzNMNtwtclQj0f+VlM26LLWzN70izEVHb4+0+eb6BHeY1tYUYRg/FWvCzQoTCSuiXa9lZ10yio+AeauIke3vT9wa+bHzKsV7I0Nz6ZNOXDtI4Jbn1kxKd6PWMlDSAbXfKZt47BkItomTVBIiDkTn9Yf1LVvIp9LMK1nCUalG5nEjtpuv/F7UsruYnC/pCdLkTXQbX2y6VJCNt9n2H9UD+DhbxvQrs0rL3xOuEouQbkYWl6id+8PcLC2bF98W364Slw+vKp7MPB65K+5CcgavpZR55PU8vDkZ3sOI/QdBqrUG0p2/qk6pe/QgQa+ohQsAhzeBqPQmh76/5YaSavo44AJuaSxgb4rgvIWPII0/+Tut+L3S68wN8ZLKVW9BUtYRWp0/CW/KpQlAh57KyDvomiHLN4zwwJ4RuULQ+APhUsgHBYL/vqhTlulf0MxpK93tulynIQazDeOKQ/GofvXpaCZnydpCSY0Bi5Ua2E0Ef18XeVREqoWcnrFhW6Za0PpWb0rmqsMkTao2scOaLPWgHFFVfoqk37xCo+9mVy68LvcIqdUCFGf0mfklREOHSU/ysleYDxfQQAbZYRlpneREiivEUlfiXLGdku2u1/BNw8YWNBPU+RxVETqvVn/JGRMxCSTANGZXibgvrPbJSWlvlD5H/u4fmzo7LgVnJT0LvSHX2BXxDNfD9bENUUDchrB5HE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199018)(478600001)(6666004)(66556008)(66476007)(66946007)(83380400001)(316002)(8676002)(8936002)(5660300002)(41300700001)(6506007)(2616005)(53546011)(26005)(186003)(6512007)(6486002)(36756003)(86362001)(31696002)(82960400001)(44832011)(2906002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RER4aStIdFZVekZVVXBQTVFBWUZwT2FvbTZ5MURnTytJVDJMWWVVSDVSSXBK?=
 =?utf-8?B?ZlpEN0Zma1g0dUdySW5hMjlIa1RVcmdMMjIrSmFVaDZya3BaRk5Iand0MWYy?=
 =?utf-8?B?SW8xODhVOU55cmhZaDhmR3F2UVZaVG8zbTJXYzlaSGdhMDh5UmtLTXN3bmpn?=
 =?utf-8?B?Vk44ZFJXbEdsczVLZDhEOG5XdlpreXdTWkgzeUZqOXY5OEdtVC9Ec3h5NnYx?=
 =?utf-8?B?ZnMwbFFtWW53dkp3THZOK1N2TXY0Zy9scHczWWdnT1BHRjF5YUdOU3IySU1H?=
 =?utf-8?B?S3RqNGtuSk03YWswaEV3dkNLRVVuYldTekVPcXliVHdkVW44c1R5MWxKVkhK?=
 =?utf-8?B?WVIyRTVUdi9jV3N2NXc5bHBLbnMzOERjMnZ5T2x4NmVEb0Y4UXYrVVQxcjNY?=
 =?utf-8?B?c3hYZ1dQNGFIY3RVb0VZZEVmY1lvS0FucEV0RlNreDIvUXFOZlZRMUZ6MlVD?=
 =?utf-8?B?SVRsalQ1UXJCVWtGM3VKWTFlVGdpNlBlWXdUYnBnMnRSNU05eGZYd2sweTZY?=
 =?utf-8?B?a3VIaGRlWG1acFk3U3p2M1ZOWVF5czBkVEpINWhCWmY5Q2tIMHV4d243QXdv?=
 =?utf-8?B?TkFDMC8yelFTSFFhRHgyNi9PME5NZFdnelJXUUdOelo1aG1BTENLSDRLUS9t?=
 =?utf-8?B?L2s5OVNmZkl6MXUydE9QR1BwYUF3ckdraWZvQllZQlFEcmtYRHk0WGlqcktn?=
 =?utf-8?B?VndveG1pT1MvekFtRTFXMW0zdHZkWEVnWmo5TDF5NE9JbUpJaHR3TWZYZEV2?=
 =?utf-8?B?K1JsUE9uQmtQRFNMcERzU3RBbm1wSUdEN0owSys4YlJKd05uVXVqcVdNYytR?=
 =?utf-8?B?K0Jyb1Rxc3NPQWdwdjdCR3NlZCtrdW8xVzZBU2pEM1VvdXBJaHo1cDVwWENN?=
 =?utf-8?B?M0NHZ1NJV2Jzb2JrREFpYVExQ0JEWU5vVkdKMzdrdHZ5S05WTVU0bnVLTUEr?=
 =?utf-8?B?eExJelh0WTlleU5WYUVkRGRXbUE4dnJsM2VYWlZlY2RCaVBFZ2RMbVZVb2Uv?=
 =?utf-8?B?T0ZtZzB5NTRHeVQxRk1JQThENWVxRC9hY0xGQ1NUSnNwSVB3VkdTTmZ5eVBw?=
 =?utf-8?B?TkQreVh2SC9zSkVOMG9RTnl4OEVVR0RPZnZaMHJlK2tiSEUxK2JkcTEwdDBT?=
 =?utf-8?B?L3FXdkM3Vjg4REExTDU2a0RPbUFlQ2F6VGVmbE90cnBGeVU1MFAvOWk5ZkdB?=
 =?utf-8?B?NUhzNDlGdG1ZQ3ZEeHIwRGlSMHN6MjNQM1pPNjR0TC9MY3Zyb0FKZnR6eXl5?=
 =?utf-8?B?bVBiMG8xZ1Q0ZUtIck1BRExoOTJkdkVGUnltY1p0MGExRFRCdUNCcmpHdDZj?=
 =?utf-8?B?a3o0N3BSbCsrSFZxTi9NVjBESXVEVjRWR1FtWkY2bXNxcVppQlRwUkdqVlBX?=
 =?utf-8?B?ZTA1YklNMmJ0dUFCOEdWQno3ekFuUENtdlZhMitUVzE3TE5ZcWRTNjdHdU85?=
 =?utf-8?B?SVJUWld2T0ZVSFBVWXp5eFozNWl6ZklDdFpDZ3JkdDR6Um9SYWtBTzNxUGVy?=
 =?utf-8?B?amRxbVVWZFB5anQ3Qm9tQUxZNUdTQ004ZTdlYmxLRnhLSEcwanBUMUR2Q0pS?=
 =?utf-8?B?dFRrNWRVSDBtdVJsNHQzRzgwYU5YQWVVYVV4c043OFF0OWh5bTYvUXo1RjRG?=
 =?utf-8?B?ZktJNWQyYVN6U3RBdGs4SFBHbi9zQU04Nlo0WkNlcXhCMGw3c3plUlRrZFAw?=
 =?utf-8?B?dmo2WjhOOGQ5Z3FDU2tGQVRQTmFybVloTW5OZmlCa3hhRnpLUERVWmFsWlB5?=
 =?utf-8?B?SG1NWW5tL2hpL2xzL2twL3B4NFFjMGJ1OGd2cCtkMDVVK0prSEFvdGZvTEhS?=
 =?utf-8?B?RytGOE03OVBLUW1zaDd2K3hmL2R2QitURy8vZW1XaUtidWI2MHhkRG1TVXNo?=
 =?utf-8?B?N0RDMTQyMENiYklpa1NVRmtYcDlSYTJOa2FhZkZabjR5U1N1cVRXUkVXMVBH?=
 =?utf-8?B?M29uT0E0ZjB0WkU3NzB3a3F2bk5oaHN2WFRNVGtNbWVmTFNadXdYK2FidWpj?=
 =?utf-8?B?YklGRXBZV1NPYzhhTG43MWxuR2lRVUJIWE1pakNlZTBVSDYwWndja295aTRq?=
 =?utf-8?B?cC95UUpDOGVrYWpxZkIzLzFoM28zc1NORXZXUll3WmhjNXYwNVV4bDh4Umov?=
 =?utf-8?B?Ylg0a0djcllscGlBUWJmaldxajA2bUc1NVJSRmo3aFRqSzVvVjR2QXMyclR4?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebebaac-a9dc-488e-b089-08db15c67b8f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 17:50:42.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69yNmfhMyw3xre8+PF0dYqtRda+AG862Ml9MYbBr2XjRpwhD4JEJQanIMyWs2Ry4HSe91OqZS9rJbIg1rmqvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6236

On 23.02.23 08:04, Florian Bezdeka wrote:
> Hi all,
> 
> an internal customer detected some testing issues in the stable 3.2.x
> branch. All of them were directly related to compat support.
> 
> With this series applied the complete smokey testsuite can be run in
> compat mode without any issues. Patch 6 needed a backport (can driver
> got a refactoring in next/master), all other patches were taken from
> next/master without any modifications.
> 
> The failing testsuite looked like this:
> 
> /usr/lib/xenomai/testsuite/smokey --run \
>                                   --keep-going \
>                                   random_alloc_rounds=64
>                                   pattern_check_rounds=64
> dlopen OK
> syscall-tests.c:712, assertion failed: !ret
> xddp OK
> vdso_access OK
> tsc OK
> timerfd OK
> sigdebug OK
> setsched OK
> sched_tp OK
> sched_quota OK
> rtdm OK
> posix_select OK
> posix_mutex OK
> posix_fork OK
> posix_cond OK
> posix_clock OK
> setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for device
> setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for device
> setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for device
> memory_tlsf OK
> memory_heapmem OK
> memory_coreheap OK
> leaks OK
> iddp OK
> gdb OK
> fpu_stress OK
> cpu_affinity OK
> bufp OK
> arith OK
> start_timesyncd
> false
> child 269 returned: exited with status 1
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (7):
>   y2038: posix/mqueue: Fix compat case for mq_timedreceive64
>   y2038: cobalt: rtdm/fd: Take care of compat mode for recvmmsg64
>   y2038: cobalt: posix/signal: Take care of compat mode for
>     sigtimedwait64
>   rtnet: Enable compat ioctl interface
>   cobalt/rtdm/fd: Adding helpers for handling compat affected data
>     structures
>   drivers/rtcan: Implement compat support for the rtcan driver
>   drivers/net/stack/ipv4/udp: Implement compat support for the udp
>     driver
> 
>  include/cobalt/kernel/rtdm/fd.h               |  16 +++
>  .../x86/include/asm/xenomai/syscall32-table.h |   3 +
>  kernel/cobalt/posix/mqueue.c                  |  26 ++--
>  kernel/cobalt/posix/mqueue.h                  |   2 +-
>  kernel/cobalt/posix/syscall32.c               |  17 ++-
>  kernel/cobalt/posix/syscall32.h               |   3 +-
>  kernel/cobalt/rtdm/drvlib.c                   |  17 +--
>  kernel/cobalt/rtdm/fd.c                       | 122 ++++++++++++++++++
>  kernel/drivers/can/rtcan_raw.c                |  42 +++---
>  kernel/drivers/net/stack/ipv4/udp/udp.c       |  29 +++--
>  kernel/drivers/net/stack/rtnet_chrdev.c       |   1 +
>  11 files changed, 208 insertions(+), 70 deletions(-)
> 

Thanks, applied to stable/v3.2.x.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

