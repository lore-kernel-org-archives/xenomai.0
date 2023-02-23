Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69AC7E
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 19:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGMGHskFH9GSTFcm1OGpuJNOvxoeSSJMboq98nJ2isMgccN2b2cWmwOKAtKqxdRaQh9ImKiKOg+726kgUCeaS3qMEC8KinTS6Y2ftv3VdtwmbhMJoZ6EHn8SOVewVmSoMhxQ5Xe//wO/guDv1FXYvvoIiMrIZz2Ctt0HyzVE/U+/YvKBSIMmU21GOuuZNlcg8HQMXBEHCV7cWwF0mNVo8/013e9VlcVzoWhHm+V7YPdAJxbEGuz4EKjwtmv7X6c7GEQcPltnc2gbv+QuLGJtiLIbuQbUPVI8ZlKb4tjH1HCpaXh/Ty0pSdAu81cutU/U7a0YkFV6LVCGGVC3spOU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHztJI5z6WXfZ+J06KULuzCMM+LkbZTumiFkUcpY0cw=;
 b=AC7cqBrztS/lDE/t9blWjcP/YSp5BeGZP54Kz1M31AbFehF3rqqGqad0FTG06PlhFXPg76lQcePkUW4MISdPBOOxtsubW2M/r49B/S5Odf6ofWUqJaU3HWwPFPINqX7H20FxEV485TddZkFXAy4q7oJCSxw4dBu9JQhVZcEa788XV8b+xtme74QdDjKIoNQHjNewYk0qqfpnoiDnb+OJNSvp2894leze3sqG8CWIucNVhq+vffSVcgTwiMdCU9T+T49vQ7UPlLimal2YH1ns7uHqha1qE1l85vSBtyUI1Zx+nZEmrskyBU8ehqf9pKlTP0jtEnN/w3P5xsItYHqGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHztJI5z6WXfZ+J06KULuzCMM+LkbZTumiFkUcpY0cw=;
 b=lI7ESWa8ekR6U7mFyJ7rbealPm1xOjmaZTTqQyRMckszfq9Asg6EOeZPCVhssfEOi6vo4fyGc1rkrF7Te9e8SqCo5X9jpw83FvubMwaSJU/3DTmxjXqS5G0yvjvcvNSo62JEhOi7MhAWPa4v5ksHtFgsxNZltMhIvm0rsAEFNwL7t9ycP/IMKVh82Cx3axYc1pLLywceZhf+TmEisvlH5hJ4t46knjGvalxI8yV0lGaOe/wb70UjlygJGWmQ5pIeAIoWJj6+6As09S0d66VoTyGZtJw8rKn9SCp2I7lzN975m+rcAJSD/I4EHhIqCYmTrbWqCevdJn7VErkH6t72XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DBAPR10MB3995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Thu, 23 Feb
 2023 19:29:40 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 19:29:40 +0000
Message-ID: <1110fada-c2ff-c68d-042a-e19ab6878592@siemens.com>
Date: Thu, 23 Feb 2023 20:29:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] ci: Enable compat testing for the Xenomai
 stable/v3.2.x branch
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20230223074841.3977544-1-florian.bezdeka@siemens.com>
 <2f600298-5496-2651-cd0f-dfed4baedcb6@siemens.com>
 <608cd57b-85d8-ecfd-8221-69ba5dd5f340@siemens.com>
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <608cd57b-85d8-ecfd-8221-69ba5dd5f340@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DBAPR10MB3995:EE_
X-MS-Office365-Filtering-Correlation-Id: ebafcb27-06ab-45aa-1af8-08db15d44e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XCnLwzhFL20DPDCtL0zx0y5ec6KlpedVgOBHYI6V0TKsNoWtq+4/d9f8oYHHMVzihDbcextXZwg/YDjnue/hfHvCSAM7FkdmmNWpHmpp6Fvt/ohJkNfG6O3A6OQWGP1Y7A4UhYaBA8gG2/Jpb/E7NAKnkj2dWOvv3V+xu3TArM7mpKRK7t56IYaxsu679eULXqCcCeVAqYj0orUDWJR4yWdpYY0NCdSj3tSWcqyZXC5CX8vuPW4UYFKLb5dtUvwFV0rlfpn4Gm8eJJb6GzeZ01SZubYaZJ4SRUCOMbrSiRyoYlzIk6YcKADOELUys/qJvceFrOwX8DyWoGTYn2pbx/+sk/9PVKEhi2JbZO1oPaAJEQSzhUDMnrV4yMiF+GrZyNuVhaAdQzlrZHOQTsLYtuCtBmXz2O+TfKs5wTqPxH0w1rzg5Lx+3l4o93Ekq8thaz2ujVvzcT5V40fx0X+yVFM+awxYHuqVYQsxHLNssLY5+v8mOg584BjALjxVoPj+JUfwHVANnccVWP7lacIn3xmHerK7jG8H4/R1lfIulDtqv9ysirjqdL60LjSFE4YEHg8R7huIcAGHha6Zubo19AHkgh0V6BQVLxgPRosBvfZA7YJRBV4mYiWyuzL+961b6ZMG4nIeXUrb79ktIB4ySTWqmflOIoD/OlQQCOUjJvyevVrTESv6bcFxC2j65oNHGMijZlVYFTT8r4JfGKdP9oj5DSK88X86Deq7oC9cVzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(31686004)(186003)(6486002)(53546011)(66556008)(66476007)(66946007)(8676002)(8936002)(5660300002)(83380400001)(6512007)(2616005)(6666004)(6506007)(36756003)(478600001)(41300700001)(316002)(86362001)(38100700002)(31696002)(82960400001)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUhMVEVyaUpTTEhSTjZQWU9zc1hoMkYzLzNZM1BLK25LN0Y5dlR3Si94NnNv?=
 =?utf-8?B?U1dPOWU3Wkk2MzQ3TWEzNEdTOUE5c2VJaUJZU3J0elRWTHhiRFRvYlVqaHdN?=
 =?utf-8?B?WkRGV1hRSmlvODFMMUpJWW5Md3lBMHFYcm9lcnpzcFNpRnNqeC9tTzhZbFgv?=
 =?utf-8?B?K01PNlN3UVFWOC9NbG12cE1hR295ZkVabC9yWjlYbWtzNEhuTzYrN1pGNzVp?=
 =?utf-8?B?NHd3QUdjelFFb2pidkU3U2taYU5Lc0F0L0o5V1lYRlNqZzFGR0QyNXEvajM1?=
 =?utf-8?B?Q1NkYS9qeDdFSFJOMmM0cjh6TFdCdlhUTEZtWkwxdUV3TUdKVkNRNkYwNm8y?=
 =?utf-8?B?UnVsVWJTRjNMRlRsaWYxQjF3Yk9FQ3c4ei9kK1R4ZmZnS3BKUVlKUXpCS3Zp?=
 =?utf-8?B?VGx4N3RBN29PR1VhdEtvUTk3REUzN3MwbmpIaGczdzBXU09kY3QwN0NsMWgw?=
 =?utf-8?B?Yms5MDg5WVRqb1Y2eEt0Y2U5YlFiS1FORExnL3VoRkNGZHRRSmF1V0M0Slcw?=
 =?utf-8?B?d2VrVnE2RTBqd2VrSkg0UkdZTjAzZEFCNG5hbUlOc2N2WVFXbWdoTEsrdWF0?=
 =?utf-8?B?Nll4bUZKdjYwaVo5T2FWWGpDK3gwZWo1VkxaWm1FQzlBR29XK05EbXhZdHJh?=
 =?utf-8?B?QzlyWHd3MGI0MC9Yb3F1Znl1cW4xM1kwcW5qc0JpNmZKU3JWR2t2SU5MaFY0?=
 =?utf-8?B?RnNSZTA0RnppOWRPbWFkYlc4bmpwU3cybjFtamRFL29QSUNuWGxSeHVFcS9a?=
 =?utf-8?B?TVVVZ2IzK1g0anVNWFJENWQzL0ZGRkY4T0FLTzBHemhQanczK2dhay9FbmQ3?=
 =?utf-8?B?VncvaVhzSmhSTGcvSGdnQ1liZ3FXdG10d3BXRW0zZDRBdzhmY0NTeWc1UU9t?=
 =?utf-8?B?bDNpc1lzSFh6TDMwNWR4QUREaG9XS256dVNENThLYzJ0aUdiTXBZVFB2K1Za?=
 =?utf-8?B?NldTaGFWVjNqaDI0TFZQNzdzZHhoMGNWc1RmZUVOai9RVGk3YXpGM0JrU0hR?=
 =?utf-8?B?NGtNS3JTWFJkVXdzMGc5Y2taUWh1WGpkUXFpVzgvMURYTE05bjJ6dm9LdlJG?=
 =?utf-8?B?cGkyOS9JUWFrSitBZ2YvaDVnc1YxM0svYWw2UXJCejlFa0ZSTGNFSWFLQ1g0?=
 =?utf-8?B?cVBGdkY4Z0RwU0YzdjVUUzFWQTlvY2RJMzBKMWlHdCtoYVhTVlZ2aFVXMXFl?=
 =?utf-8?B?TzBkdHFJT084SFcyMDR0by9tK3ZHeEVMaUxTZFF2VFMvMlFWOFY0cXkwMFZx?=
 =?utf-8?B?Z0FCZjdhRWJCaEpHTU9rcHVFUEJQMU1qeXdqYjJUdmdycitrRGdKQTRpakpq?=
 =?utf-8?B?SlM1dS9lNGRtK0dZdDlGZVdLbU8xNU5uR09FWXZuS2E2NmVDVHMzUHFYdEtK?=
 =?utf-8?B?UWNXRzhUR3M4MGJORVRjZkdDR3JJUmhWWFlTTjVWbWN3Q0lzSU9LREZxcnVN?=
 =?utf-8?B?Z05ZY3VvRno1eFZpcW45SWMwNTRtL254SVhuZGpLajQ1dDNwS1k2VGxqbHUw?=
 =?utf-8?B?Smt5czk4ZU5YaENnZENnYVVNWnhVTkVoTDFTUnVqUjlrbkdEWU9qdjBpTHNT?=
 =?utf-8?B?dnZDQTdDdHc1MzNjY01yR2dXNERJSi9BRnFUWnlDTHFMWEZlVkhxNkF3cmRD?=
 =?utf-8?B?WlJtdGVwbzdQYTdNbTVDODVzd1M5TlRBWXYrS0wxQnBtRTUwQjQyUGNTVGkz?=
 =?utf-8?B?ejVBNGtJbVpvcmV1Nlh2S3lWdGlZcEVQRVlYZnVRcm84dFgvYVpCTEZXVitH?=
 =?utf-8?B?bVlOYndxUmVVT05ZT0xVa2pySVBOSCtrUHJSTlpWbjV0Ym9ibHk1QlVYbmp2?=
 =?utf-8?B?ZjFFZlI2T2JJa3M0cEFLNVdxY3Nmc2dYR3pVY3ZHT3NoSTRJNCtYbGM2cmty?=
 =?utf-8?B?ektIZlE0N0lzR1FCRVIvS3VoWHFVYnJCeTd4Rkg4WWF6cWw4V2wyeGNxa0xP?=
 =?utf-8?B?eHpxK3RLRHI3M3pMQm16Ykl4ZG9YeHVGblZxL2JhYXdaaXBTOHgvMVVrakhZ?=
 =?utf-8?B?cDNTcDBnb2x0SzhZT2lISWIrQWxOaVNXNUdnZFRxNFl6UFU4UXRuclNEam9G?=
 =?utf-8?B?bmVETjB1aVF1eVk5NncwSWtZT1RMUWpiRUpoaElxcDE0Ujd3OHhPV1pIV3p0?=
 =?utf-8?B?c2hMcVk4c2lDelJQZE9wMGlISWYvN0p6RVFDZFVoaVdZZ1l4WXp1ODBMUFRW?=
 =?utf-8?B?S2dQZUNjWWpUY25lYlYrVlBQUEI5dS9jamRrRVcrc05DTVNjaUVicDBoVFdK?=
 =?utf-8?B?UFlMUldQeVhxNnpGajIxWnY4TVl3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebafcb27-06ab-45aa-1af8-08db15d44e80
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 19:29:39.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stcJV7MYvXuM3VfUZM2O1B7tblVe1R4jS/xajoahzjkZYDrKNO+dJqFVhX6H8ykGXbAsvl9Ienkj7ylspijneXjv862qSOV2B67UKEQYnL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3995

On 23.02.23 19:03, Jan Kiszka wrote:
> On 23.02.23 18:58, Jan Kiszka wrote:
>> On 23.02.23 08:48, Florian Bezdeka wrote:
>>> Add compat build and test jobs for the stable/v3.2.x branch.
>>>
>>> The compat build and test jobs have been moved to compat_jobs.yml which
>>> is now included by xenomai_next_compat.yml and xenomai_3_2_x.yml.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  ci/compat_jobs.yml          | 43 +++++++++++++++++++++++++++++++++++++
>>>  ci/xenomai_3_2_x.yml        |  1 +
>>>  ci/xenomai_3_2_x_compat.yml | 19 ++++++++++++++++
>>>  ci/xenomai_next_compat.yml  | 34 +++--------------------------
>>>  4 files changed, 66 insertions(+), 31 deletions(-)
>>>  create mode 100644 ci/compat_jobs.yml
>>>  create mode 100644 ci/xenomai_3_2_x_compat.yml
>>>
>>> diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
>>> new file mode 100644
>>> index 0000000..aaf582a
>>> --- /dev/null
>>> +++ b/ci/compat_jobs.yml
>>> @@ -0,0 +1,43 @@
>>> +#
>>> +# Xenomai Real-Time System
>>> +#
>>> +# Copyright (c) Siemens AG, 2023
>>> +#
>>> +# Authors:
>>> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +build-5.15-compat:qemu-amd64:
>>> +  extends:
>>> +    - .build:qemu-amd64
>>> +    - .compat-vars
>>> +  variables:
>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>> +    KERNEL_VERSION: "5.15"
>>> +
>>> +lava-test-5.15-compat:qemu-amd64:
>>> +  needs: [ "build-5.15-compat:qemu-amd64" ]
>>> +  extends:
>>> +    - .lava-test:qemu-amd64
>>> +    - .compat-vars
>>> +  variables:
>>> +    KERNEL_VERSION: "5.15"
>>> +
>>> +build-5.15-compat:x86-64-efi:
>>> +  extends:
>>> +    - .build:x86-64-efi
>>> +    - .compat-vars
>>> +  variables:
>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>> +    KERNEL_VERSION: "5.15"
>>> +
>>> +lava-test-5.15-compat:x86-64-efi:
>>> +  needs: [ "build-5.15-compat:x86-64-efi" ]
>>> +  extends:
>>> +    - .lava-test:x86-64-efi
>>> +    - .compat-vars
>>> +  variables:
>>> +    KERNEL_VERSION: "5.15"
>>> +
>>> diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
>>> index 3a1d5e3..3ee0b7d 100644
>>> --- a/ci/xenomai_3_2_x.yml
>>> +++ b/ci/xenomai_3_2_x.yml
>>> @@ -15,6 +15,7 @@ include:
>>>    - local: '/ci/kernel_5_4.yml'
>>>    - local: '/ci/kernel_5_10.yml'
>>>    - local: '/ci/kernel_5_15.yml'
>>> +  - local: '/ci/xenomai_3_2_x_compat.yml'
>>>  
>>>  variables:
>>>    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
>>> diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
>>> new file mode 100644
>>> index 0000000..a212859
>>> --- /dev/null
>>> +++ b/ci/xenomai_3_2_x_compat.yml
>>> @@ -0,0 +1,19 @@
>>> +#
>>> +# Xenomai Real-Time System
>>> +#
>>> +# Copyright (c) Siemens AG, 2023
>>> +#
>>> +# Authors:
>>> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +.compat-vars:
>>> +  variables:
>>> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-compat.yml"
>>> +    XENOMAI_VERSION: "3_2_x-compat"
>>> +
>>> +include:
>>> +  - local: '/ci/compat_jobs.yml'
>>> +
>>> diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_next_compat.yml
>>> index 92571ef..f7e3146 100644
>>> --- a/ci/xenomai_next_compat.yml
>>> +++ b/ci/xenomai_next_compat.yml
>>> @@ -1,7 +1,7 @@
>>>  #
>>>  # Xenomai Real-Time System
>>>  #
>>> -# Copyright (c) Siemens AG, 2022
>>> +# Copyright (c) Siemens AG, 2023
>>>  #
>>>  # Authors:
>>>  #  Florian Bezdeka <florian.bezdeka@siemens.com>
>>> @@ -14,34 +14,6 @@
>>>      XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
>>>      XENOMAI_VERSION: "next-compat"
>>>  
>>> -build-5.15-compat:qemu-amd64:
>>> -  extends:
>>> -    - .build:qemu-amd64
>>> -    - .compat-vars
>>> -  variables:
>>> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>> -    KERNEL_VERSION: "5.15"
>>> -
>>> -lava-test-5.15-compat:qemu-amd64:
>>> -  needs: [ "build-5.15-compat:qemu-amd64" ]
>>> -  extends:
>>> -    - .lava-test:qemu-amd64
>>> -    - .compat-vars
>>> -  variables:
>>> -    KERNEL_VERSION: "5.15"
>>> +include:
>>> +  - local: '/ci/compat_jobs.yml'
>>>  
>>> -build-5.15-compat:x86-64-efi:
>>> -  extends:
>>> -    - .build:x86-64-efi
>>> -    - .compat-vars
>>> -  variables:
>>> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>> -    KERNEL_VERSION: "5.15"
>>> -
>>> -lava-test-5.15-compat:x86-64-efi:
>>> -  needs: [ "build-5.15-compat:x86-64-efi" ]
>>> -  extends:
>>> -    - .lava-test:x86-64-efi
>>> -    - .compat-vars
>>> -  variables:
>>> -    KERNEL_VERSION: "5.15"
>>
>> You aren't getting any benefits from AWS, are you? ;)
>>
> 
> Seriously, we should look into scoping our jobs down again, a bit. I'm
> currently counting 54 active jobs on xenomai-images. There were also 15
> kicked off on xenomai itself when pushing to stable/3.2 (build tests).

Totally agree. Any ideas which jobs could be removed?

> 
> Jan
> 

