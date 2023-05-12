Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD424129
	for <xenomai@lists.linux.dev>; Fri, 12 May 2023 16:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzNbrSy4Jj2yMHUwke11kWPMq33EpO6VgFA3btt8asKtoRacRVxLXUYioyWo1/TQ9qTd3H8AseiKw7tdDEPmpZmDgPNfVOWmOx/Pn4Ra1ir3zZnb+EgYhVrA7ubwKz5vslzNNZ8zoyeciFiymtGx3RflAls9O74yTyfakoetFsxqQ8ZOksINmmgyVyToe+CBCPCrH7eBF+7p2XCRhwQJWfr4+CCmlbDH6IQTO9XTuHSTkkZ1T6aKB48WZpKoJiR7wtxXwdu90nNndPXAhfk0MPRgcS5PKu73XhIVFWzibBR5qO+Zm2DKSswBEbI315XtSDA9BhXBkQZDyBdJItv6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9mgDHg9jrVmdHOICXKMx33UYcX09oaXuwOhSLWGzYQ=;
 b=ij7v3PA37ENuuf1jNZnaRnXlTfVO5WWAHAM/IirBx0K/qke/teCcv8fKQ75L2xa3OX2G3goX/umubZ2hB2Ak5qORSYiF2iSHo9a2E2bqmWdTm2hOK791X3R9GzMymXBIxp8lNQAgdupO/J1f8tI9z2G0GqalL86u3e0eboeojbqk3jt7DrWtrvGn+TNOWpLyPQPeNkAb227PfCcftMchuDCXHW3THLK6CJYEQomfZPUXa0ZlbNkAP65qsIld0dY+Y/SdvkaVcbBZVW868oD0Fo1sxBUJoaRxSnn5l9Pxd7MozdbQ4vr4elauEfldqZqOy1v7LrHoaGKG9v7oQ+GGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9mgDHg9jrVmdHOICXKMx33UYcX09oaXuwOhSLWGzYQ=;
 b=RvktkE02gWm/neK7LU/jVn7oT8H49SUZdKs4wDNif+m+weVa80jqtRbDglpFv7lxnFu0mJ36zetKE1+A225F84Y+95Ec1JcpbLnzyM8i/p56oIVbiCJ+Eqgim+9jtm/6M43YyzMeB91YPCyXV8l9miJW5pP//iuILPuj9x66POBImV1SD+kzqOHrFVsHf08pYz7v5fnKJyHfsR2AyLncAFsrx0H9R7b8PAnkh4kqQ1VzOKqXqtfEW5x8q7vtEgbp9HRLkP2+QuxNmh9vPpB0JJGRb8XqYWYmJVhae7m3XQ+D1c2cn1Lbzk07W0TARI04c+TqIxn7/0UPXU38XO9GRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 16:09:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 16:09:23 +0000
Message-ID: <3f1152e4-3270-cecf-d4fb-c92488e4f2fe@siemens.com>
Date: Fri, 12 May 2023 18:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 00/13] y2038: Part two - timer and timerfd support
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c9b9ba-e50a-4bdd-ac7b-08db530340a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+mTJpTW7xR/jT4am5a44EW/DR8GNkxFPfXW7nSwoKQy4IWDTiapE9DWF799lL5KY82rbwPhRSgGNGcy/xcyL055uR2mhwkoHfy/NoT+qbkFWJ0lIPaN4WVp6SyUgGPSuMQN/cuE2z1bUKy58Mq9DvFvKEMFv11mM2BZkcxEGizJkesd3fnMxCySq/xr+KqFcKSdfhdKhc4++3QxGiWkU+OiOu6fqJHX69Ax3fTWeFYZrkYexV1vp+KifrgrT23TZlZ+hqhPlQMsuGpcSWTUdkz+ToAE48AOdFZbhfCxKKacoKJ2zDsfQjByqwPLFipUCljT86jFqtsa7De9HUkw7XNKd/qx1im994MoXRtEAqzYnUN7hw3oJLUix7poGdCV/jD0tRO8dFmq51D9D4ayRIGvPx7Ws47AvPfH/aJU22d0vPqzXJqVED5UGp2OgYkywgVEXzu2+5j4Fex1aaWJklmcaGPSu3AaXIHSRApyWJ+so0/Pof75thQFvqLVRq7A/3qFgON8/sfQWSEhkejkGOBqY4DLstIWodWjo/11Dh//pcYgp7ryfN2XbgxqDXbqVmioQHzSJpYFlLArJ/cT4Lps77/krsso5kgH4u5ppWs4yVDXVjNBAT18jXGr4x8gM65ktYLYlMe7kh04JTAss6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(6506007)(26005)(966005)(6512007)(6486002)(53546011)(8676002)(5660300002)(44832011)(8936002)(478600001)(86362001)(41300700001)(66476007)(66556008)(66946007)(31686004)(38100700002)(31696002)(82960400001)(2906002)(316002)(83380400001)(2616005)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzFXRkIxRUJzS3hrWk9OZmt0Y3ZsM3M5ZXR0OTFTSllSNG55MXRyenE5cUpE?=
 =?utf-8?B?T1lDUmJhVmNFTmhDT1BNZmg0VnZRTW0wOThkMEpCcU14Q1lIZUZxckNLT29P?=
 =?utf-8?B?dDhFalFISVJFV2c1SFNqQmtwejJtMnVtVE9zWUJoLzVDd3FONFFseU5lcGdo?=
 =?utf-8?B?ci9VTVNIdkh0Vm81MkR5Mjg1KytIYTlwL3RjRmRnTDNBWEVNTlVoMGEveVRj?=
 =?utf-8?B?SHZrZzk3eXlmTmNMNTZuZ1pKcE84VjlOTUp1UTF2M25HNnQ2MGhib2owOXF4?=
 =?utf-8?B?UnZtQXpuVTBNSUZub0VlVkYxU3A0Y1dMbHduSzRlSmFIZUk2dks1L0tFS2NT?=
 =?utf-8?B?emtGNkVlQ2p1cHFXZ25xTUdPTU96VVZScjl6YXkrM2N3Qkhwc0JHSEtYL21r?=
 =?utf-8?B?cHEyWG1xbG8zUVlRTFNsU25rVmo2OGsxMVdrTmYzT0g5STg2Mk1jdVJCMHFO?=
 =?utf-8?B?R2xMSVUvWGhOS0VPSnpobyt0L0RBaWtiZVY2ZVZmQ0dPTzhkbGJ2R1JqS01X?=
 =?utf-8?B?QkNIbDhhV0VDMXZYZGw5U3EzUy9vdCtkRkt3azRMK3ZPM0F0MTJweWI5bjJo?=
 =?utf-8?B?dDY4RjBhMXVOY3hBYVVMS1NXbW9MYmIyeTUwaUNJVkJYV0xNaWxBdmxZcDh5?=
 =?utf-8?B?MVhQNFlsejVVUWZLQnlrOHFwL3JoNDlRZ1JFS3JWMjFCbjU0Z3VUaTlmUUNQ?=
 =?utf-8?B?RjRPUkV0di9GNG1kVFJjYlNIZGFqSGdhRG43N09ZMUtnU3hYSXh4aC9jRWZC?=
 =?utf-8?B?Y0RWUDZrNzdSYlY0RGNZeDQ1Ri9mR0J4MmxQY29FcmhHWTIrcWZmM0NWTUcr?=
 =?utf-8?B?YzloaFQ5QnhtamxHWlVSVFhLNjRSWFRYOVF1TlJVKy92UmhLK01JSFd3VCtU?=
 =?utf-8?B?YXpLUFhVOE5mUlhlcklDeHdHdmlOZVZlcXdlODZ2V0VSc0tkODFXdDlIK0FW?=
 =?utf-8?B?N01nNURxZmNqYVBNZ2Vnby9BV0FqTElBMzJNR3VaS3hNSXI2YU1yb1hGdUZ6?=
 =?utf-8?B?Y25abVV6V3RLcXJEVmxuK3VHdG0yRFEyeURHYXNVRFFEV1IwLzE4TEVaQWN0?=
 =?utf-8?B?RnowMkpQTmprRER0Ykh3dWlFS0srczVreFB5WnQvSGJ4dVNITHpIRXdscWc4?=
 =?utf-8?B?d3hoMHVHYlV0d0NDVnh1aldXMk5zVFUxcm5zb0JXSVdNYWtwN1VKZk5BOFVk?=
 =?utf-8?B?RWp5UENWSjh6cFduVkxEQWVDUlRTdmNlMHYvdUQvMCtRUHpSRFRvOVNOdk1N?=
 =?utf-8?B?cHVBQTFqaDJxUTUyNDgzc3ExOURqMWttRC93eXcwdng2Y1M3MEJ3Y2o1eXpB?=
 =?utf-8?B?c0loSDFmVlBYeVBBdDlVd2IvY2Jxbi9xMzVza0ljVENxTzRReitjWFdzZVhR?=
 =?utf-8?B?a1JCSEdOaGR4UC81MUNPSkw5UnBLckJnWkNUWGhpdTAvWnhjUVVwZUEvUUJu?=
 =?utf-8?B?aVM1OTYyNy8xaUxqU2d2NFo1NEp4VGtJNXIwOFZRSkZOR3VjNkJkeUluNzEx?=
 =?utf-8?B?US9Ca2toQ3BabmJiUThuanF6a3FFc1prYzlhU0NDWDgyMDB3OWtGaDBjakQ0?=
 =?utf-8?B?bDkzK1JobXVnbGROTmVrajJER0F5RWgxYnQ3MlZUalpRUjFKMDFpbGN1RHhK?=
 =?utf-8?B?SWc3Ylh2NXQ0QWJkRXlMVXJyUm9PSmcwclRlbnRiWk9YVVhoN28xcXREYmdE?=
 =?utf-8?B?VW9nUDhUVG92THNZVXlBRDBGREpmQ1l2VEFCYXlkS0FlV1cyckZqQ016Nm1i?=
 =?utf-8?B?U1V4QldpSEhuWFhyVGp2V2pPdlBsVmdxZGduOFdPdmVFekh2YXlTVkErQmM2?=
 =?utf-8?B?OFRobTFFQ2paRVE3S1IwZTJ5SGZqREQwYUt0SFByTHM0K3ByK3diNW9FY1Za?=
 =?utf-8?B?dDRoTUw0K2dYTTNaNU8yNXpkdjJoODJLQXN2STRIdTQ2QWVsQVM1c3NXU1g3?=
 =?utf-8?B?QVd5eFFJU2RadTlEVUxkK2NQZ09sZ1ZSODAxVmxSaGN0Y0ZYV3kyV0VqUEs3?=
 =?utf-8?B?T0hHV3dvT1UrdlJZV3JSTmdZRzlVL0pidk5WTFJ0WG5ESUxyU0ZkY1Y3S3NQ?=
 =?utf-8?B?cnFBaDBhdnlQc01mUUozR1Vsa3lub09WdkI2SWdDM1ZqaWZZbUxzcGNoVzJy?=
 =?utf-8?B?SkQzdWpxOGU3RzNwaC8rK2QzbHRmT0xIQnBjNHV2c0I5VlZ0T1lSNktvbGdk?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c9b9ba-e50a-4bdd-ac7b-08db530340a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:09:23.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5TsbQa8rSU+1uHZnJFaaGtbN6fsywu6kur8yK1bkBgp4LkTVzdjDuQLZa/RKZkzrQ+USkQHmeoq3WrD+4Sk6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7008

On 08.05.23 10:13, Florian Bezdeka wrote:
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
> Florian Bezdeka (13):
>       y2038: cobalt: Introduce some itimerspec64 related helpers
>       y2038: cobalt/posix/timer: Adding timer_settime64
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
>  kernel/cobalt/time.c                   |  38 +++++
>  kernel/cobalt/trace/cobalt-posix.h     |   6 +-
>  lib/cobalt/timer.c                     |  17 ++-
>  lib/cobalt/timerfd.c                   |  27 ++--
>  testsuite/smokey/y2038/syscall-tests.c | 247 +++++++++++++++++++++++++++++++++
>  11 files changed, 445 insertions(+), 16 deletions(-)
> ---
> base-commit: 2a60f423f269539f1af0d261810644ed09ee494d
> change-id: 20230508-florian-y2038-part-two-7d7864dadd71
> 
> Best regards,

Looks good, just minor remarks on the first two patches.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

