Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2123C3
	for <xenomai@lists.linux.dev>; Tue, 16 May 2023 06:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcpqXMk5uJBfeVc439q7NCsCDO0QT0dB/dDw9z5OBv/pJWPcVSLAONOznEFP52eBqvP76x8m3KwTqKRdmkF+ofnLuKyRSI77Qcyb1uRNXj5g79y4jAZZqi09v7PIEoNQqkb2lpCNbI1beSUkkhOtVZsoTeVyRPjWyU75UGKRdc81nAi4TiLB6TlfUbKMedBBTa2lbG3jVadxYTaDYPE3YQQvinzQ/cshJLNoFq6mpzLPpzE4gxea11ZIclyrCHZL+t/t2sO180OQcDrX+o1ewQjCUUmS7Mdt4OjT2Bf5vKwJGRbrC+tfdZkYATV1fZpfTBVVdQQMGAqSzHtm/yI6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVQMq5JkrP0MwlWTSD59LvM+SD1shwvSjBdkRj3tN0Q=;
 b=Pm5z5zbxbUoGJP5iYLD3gz5kX1XaXUwvBrG+3ZWQDwAFGqGbzYL+rGB5nAay9oJAUsSJ9Rf69jzxGjSbKsbZbQlCP/A4Shw0uZ6C/cgHfXedPbxYjCCVDeNKfzI/+8YSf+rM3jyi0zzMPipXEN/Eb+cg3vP19PlqJSRXYQ8x01E/iLD9O+HcqPEqc9/ADa05/mT4K/8MMhGY7E9tvgaqny7+rQKwDwiNr1o3a4DUkVKyCd16F/fkeAntCZxFXJVHymRcXcLO+zK0ivxqv9ZD6dSA4UzddJkDNNPfWFh8Hv12sgNMRWMW+JBeYI4SyiibpwShOXY1jLESGwiUxdfwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVQMq5JkrP0MwlWTSD59LvM+SD1shwvSjBdkRj3tN0Q=;
 b=UD1BzryovQXJ6tg4GbYtgZEWrYc7ut8Gh+pXgytRG4qCCIMwzNik36qBtCdWVxxOY2wb78WOXIEuOgzyv3Boug1qVcEbaDpgPQdoh7meOq2f3H5N/8RPVGhNBrFqegrG/8FdD89/PPyhFpa4Y1so3k43s6s4JqZtAcSDOvMopdVMdmUgxB/727tXISNWqnQaBmWgYB9Hi2YMgvvEnMK/goIBSpe/4NorRJw4KO5NyJvpgD4XR7AII9m4WMaGdZeOWcb+m8jh+zj+FEdf2WkVkaM/ad9apRujPsp2ejxbnNTlM1z+a6KW07ZkD8tNjEIUakgEVshDxLvnnZH+pv2GBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 06:43:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 06:43:59 +0000
Message-ID: <c6c9f3be-c5b0-9618-952f-4f3809771ad3@siemens.com>
Date: Tue, 16 May 2023 08:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 00/14] y2038: Part two - timer and timerfd support
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610::22)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 057cb321-f742-4e96-821f-08db55d8ed4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8KT8/3emSVxs7W+vsOV/xgfvHjoj4kR++efdnffpfcEOJkR0E2/r87mWWyDBYwGHQAHBWtg7SHjRYocy+oyVZuX+vbVvn++UDAJLJENtrWfD5yuh6n1GSKcJvJrYIYMYW8zxi+uGBPU+nRWKnenE59N3BDSZwulQb4BIJp7QSQag/FP5X8sOXe99MQNXvEBW2Y6ce4UYcabr3Z+fWBXUrJ8zGgod4pMZNAK/EBwPZan2o9VaG00sxsQo5lm6zdKJ1esSAEoJ2XABOtEsyFiyvtUX1vxM+5GX154ISvkgjDrEPLBvzmeeZ4nvNw+HdW22Cx3ftBg65mrq7HgW/dg5JsFt+KI+EC3vifHBrD7XCH0YuDxIsxg6mEHcGcPd1tNGDud9eIEFmk0fxl0pjxI8AsWcU5CcPYiGsNO15NElHkPRuIeyBahxGgtu+X93aVMHDDCjTtqIgeBEPlS41N3X/d0aiZnRcTln9KTvtKn84l5s+PT9Wb3Cbtdp/TObvDmu8mNxa0Tym/HqpRbN3azWUYqCyU4tsEQdf70OrUehFZXriyVosf28dRPH9nQIpciIowXhAEb+8gzUObflQlhl6jJNN7G5As0B3KSuCHHnh8PBGbAVhzToAnZDu7+LgIR9dhnGjfTe/hQ09CyWc3TU7oqTx1Df5QJVI2k5t6mUQA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(36756003)(6666004)(6486002)(966005)(2616005)(83380400001)(6506007)(6512007)(26005)(186003)(53546011)(5660300002)(44832011)(82960400001)(38100700002)(86362001)(31696002)(41300700001)(31686004)(316002)(66476007)(66556008)(66946007)(8676002)(8936002)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmV2UGRkQkgxVDFZeElKaWdKbFplaG9uUTZ5ejk3NHgvTklnQ0x5eEoxd2RS?=
 =?utf-8?B?amNMQjZVNkp3WUV2NWpjL1pnNWx3djBwWkMzOFp1bHZobWRZTnpRN2l2Q3hJ?=
 =?utf-8?B?QnRWRWx0UXhWTm9PTGFzSytmeVg2blZMUWVFaU8wYldCaXBzeWhCd2VEb0NB?=
 =?utf-8?B?VTNSMjF6VTFKUDRpYis3V2IvcmI5VVExWVNFc3Y5S0RqSzkxSlBaV0NyQ3ZY?=
 =?utf-8?B?cUxXZ2xxMzdFSXdPVFdPQkh3U2FsbXVrRURLUFdGRmgzVGJUN1FZMjg3VmdN?=
 =?utf-8?B?bHkzbW56QWVjZHlIeTNJVUhjZUxIdXJRUFJWQUZFTUxhTlFQNEt1eGE1RGpP?=
 =?utf-8?B?QXlvWlVRQ1ZNbjhXWnBwRnVLNGhEWjdUU1dSQjRRVkVUelhiZHRrQm8vWlh6?=
 =?utf-8?B?UWM3NjJEQnYrSmhHeUhVMFVRdk1HV0l5cVEvbk1peXFvN1VRSUVJWEdnT3l1?=
 =?utf-8?B?dXhHN2o2YmRJZXBIQ2pjZnlCVUhrLzJJYlc1MDFsWkdZbnRHbWFZYlBFVHdj?=
 =?utf-8?B?QnMyc1Q4OVMwUEZCM1dyZ1RjQUZOTEtTRlV3Q3NpTlNzblJxUkRVSDYyNy9y?=
 =?utf-8?B?U1h3S0EvT3JycEtDN20zMFN4SUpGYnZxMTZKSGluc3pGRW9acmZFcE5pUlBF?=
 =?utf-8?B?Rmxla3ZLVStYVXVqOFNqS2xwWU9EZERhTDRZOWVTdmhNendndVpCNkNPMis1?=
 =?utf-8?B?dWsrT1ZNS2tKUHIyZ0FEQW1IeTV4cnJ4L1RYTnFvYk5BWGRLNDhMRFd5ZXk0?=
 =?utf-8?B?K3FUMjdudHZ5ZGZsWWFvY0M5YVNQRG1TVWhtT2t1UzlQS3R4YzVRQ3NEU2Jy?=
 =?utf-8?B?TDhNenNUaFhwc3dDeFV0dTdMVXVCOFFidC9DdnlXcjZTT1I5VllCWFZZNk9j?=
 =?utf-8?B?T0U5NzM3OEtYL2UyQkI0ZzM2Wm9DNERXdk0wSTErOEFpRm1mUi9uK2lYU3Nl?=
 =?utf-8?B?VlFLdVBJTk11bEhWeVBrUkgvZkxiYXdYbFY5WmZwV0lueUw5MHphVWp0bE53?=
 =?utf-8?B?QUxONkdKb2puaTEyblh2U3NacnFMOW9rVWlJRXhZTlFDU2pia2FHWG5kdVlH?=
 =?utf-8?B?cUVJL1ZpQWdLRjlCbUc2cEdtQUpSRzR2S083WTN0RVlTUktKcFZ1czVJSW1y?=
 =?utf-8?B?VGNUUURBNlBYVFJDTVltRk1mVmI2Nk0rZFREWnNJTE5xV0xxYzhNdEp1NU5p?=
 =?utf-8?B?SUZqNzhxWkVaSGRIS09WVXpWcmhZSTRjQ2ZkemtlVDIrS2toMGZPcEdlMXVk?=
 =?utf-8?B?MnJua0I2dDRQMUtuQ0pRcnlyM3k1ZVF1ZHhwZG44UkpaaE83UFZxZmkrSmIz?=
 =?utf-8?B?YU44SitXb2NDOHkyckJxT2xTUk4zSFZuUlUvcW5jcmc4ZUVSVExVMFcwUWM4?=
 =?utf-8?B?REdEMG5hWXIrbTdkeUIya0E5a3M5Nk9DTUtuU1B5SklEaWQxNm02YWpsVFMx?=
 =?utf-8?B?eWhjOWluVmtyWEorSklkSjZHdHE4eVA3QU41WHJOdytlRWdvRStPVEI1RXJz?=
 =?utf-8?B?VnFZUGU2UUxMdVdzczRZSmV4VGJGYnpRQmR0SGR1VG9mbHV2VGxmblhJSXZZ?=
 =?utf-8?B?Z3dYWitLNjFrL3M4WVkwWm5yMUg3Zyt5OWoxUm1OZ0JyNHlSVVJnelkvNFBo?=
 =?utf-8?B?YW1tL2J3eDE4YkhXT3pqTjVLd1hFdS8xWDFjQmoyMnpSRHhrSUlPWlZySUp2?=
 =?utf-8?B?ZGozU2kvT2N2UTh4NGd4WGFnNFc4VFJhWUp1aG5zbGpobW5NNVE4VDZUTEdX?=
 =?utf-8?B?bmNMS0FBUWQ3K2VOUFVONUM5VFBCd2pidURxSnZwVjBwRnZKR2YxM25EQVhm?=
 =?utf-8?B?YUhXN3ZMVy9DZmlsOUJCdGpEa3ozS202cktjR2oySUlFb1dEWW1ZaUV6bXhK?=
 =?utf-8?B?bnFGSFZHSXhTeUgxUER0RXFDNVNzdE5QVldXT0hWNG9kbzVPWWk1UUFvbnZo?=
 =?utf-8?B?UW5peW9yR0lVa1UzS3VsZGxkWjdjcWdPUmNlNjFpSEJZamFxcW5BWGVHdU5o?=
 =?utf-8?B?WUhsdENHYllpbkNyOVVXWEZPY0JJZ3hiMzJNZ1h6eW9ETjRPb0w1K2Vrcndq?=
 =?utf-8?B?bE83cStFalppdWNraHBDOTVsUkpucWhxUTdubW5tYmtpeGx1TnE1eUxaV1hm?=
 =?utf-8?B?TlNjSWljVG9ZZ3l5V0RUcEo1bWRkRWY2T0IwZ0F0WmhVTjh4bktzaE1RUytv?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057cb321-f742-4e96-821f-08db55d8ed4a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 06:43:58.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvQ0AMaKQx5n+OEd92hkzMGLhgtHnhbDEPkUu6glmwoKITA0QaY29U7y4PMH3x80A3/Hz2e8JBPO+mRva5e4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6152

On 15.05.23 16:50, Florian Bezdeka wrote:
> Hi all,
> 
> I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
> next/master branches. The full queue [1] holds ~20 patches. I'm trying to 
> split that up to keep reviewing efforts low.
> 
> This series brings y2038 support for
>   - timer_settime
>   - timer_gettime
>   - timerfd_settime
>   - timerfd_gettime
> 
> Best regards,
> Florian
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Patch 1: Remove unnecessary NULL check
> - Patch 2: Split timespec validation into separate patch (now Patch 3)
> - Patch 3: New patch
> - Link to v1: https://lore.kernel.org/r/20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com
> 
> ---
> Florian Bezdeka (14):
>       y2038: cobalt: Introduce some itimerspec64 related helpers
>       y2038: cobalt/posix/timer: Adding timer_settime64
>       y2038: cobalt/posix/timer: Use timespec64_valid() for validation
>       y2038: lib/cobalt: Dispatch timer_settime
>       y2038: testsuite/smokey/y2038: Adding tests for timer_settime
>       y2038: cobalt/posix/timer: Adding timer_gettime64
>       y2038: lib/cobalt: Dispatch timer_gettime
>       y2038: testsuite/smokey/y2038: Adding tests for timer_gettime
>       y2038: cobalt/posix/timerfd: Adding timerfd_settime64
>       y2038: lib/cobalt: Dispatch timerfd_settime
>       y2038: testsuite/smokey/y2038: Adding tests for timerfd_settime
>       y2038: cobalt/posix/timerfd: Adding timerfd_gettime64
>       y2038: lib/cobalt: Dispatch timerfd_gettime
>       y2038: testsuite/smokey/y2038: Adding tests for timerfd_gettime
> 
>  include/cobalt/kernel/time.h           |  21 +++
>  include/cobalt/uapi/syscall.h          |   4 +
>  kernel/cobalt/posix/timer.c            |  45 +++++-
>  kernel/cobalt/posix/timer.h            |   8 ++
>  kernel/cobalt/posix/timerfd.c          |  40 +++++-
>  kernel/cobalt/posix/timerfd.h          |   8 ++
>  kernel/cobalt/time.c                   |  35 +++++
>  kernel/cobalt/trace/cobalt-posix.h     |   6 +-
>  lib/cobalt/timer.c                     |  17 ++-
>  lib/cobalt/timerfd.c                   |  27 ++--
>  testsuite/smokey/y2038/syscall-tests.c | 247 +++++++++++++++++++++++++++++++++
>  11 files changed, 442 insertions(+), 16 deletions(-)
> ---
> base-commit: 2a60f423f269539f1af0d261810644ed09ee494d
> change-id: 20230508-florian-y2038-part-two-7d7864dadd71
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

