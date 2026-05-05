Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1623B0AEF
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999031; cv=fail; b=mrEDahGCenC+2jSm7F3D70O8cjIygl+t9AakXhfhCcHZ80qz6wACF1I8hhDmyLOjFk/BLehoA7kIXQlQyHbX9Qgi/4vKcdhvMqYPsEPGa0IzDhaivhdP3WWOmC8Aw2afY/15HyYz8CbBrEC5ZM76Ut5dRZKdhwS0+AY2AMxPXJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999031; c=relaxed/simple;
	bh=LC+ljVVLSRqid4gkoUOZ8JBlZWLTnPvpWl4gVB08Bw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tGD9p+CP0fs1undPXDzrvVgQ3UEBlF6/YA4KwfWJXV5+uZvwpuA5WeMEsgel5PXZKaVyaqLKyZJlffs8zeOi3L7HqyWbqd7c8ifO1LiZcug02Uxoms97AVxDgAl3HYpgNI41B2HD9xTTxEiybQyJxS8UFaQ4j4CVyhR3i5e8dtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RwdFXehV; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RwdFXehV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHtPZvtcKO+p8m77NAMI2RI52n1sZIL8vu4NytbjyeZO+yB6zhJUYeqbEMF4g9sQFN3zUNe+/DCFRwI7uDFaZk1RyWy3+9oyhuRRU/YNO+E0xJS8DcScbp0qSd1x3xBWcH8DJ0q66TN1l/hmxGfvXEfVIxNBKQo4Y4lViM3ptKDe6t3s+f1/SAJebLsvis+ToSVGUcN9qiwPCjs2crdhDLyPss7yVGoPRHio1AedgHxNziFdya3FfOrN/HGqZqrESi2d6589pKl2lfy4QtyCjtd5BdMKi8MfIaql7r5I61D9fESK4nXg9hm7xHGEqUj9rEhS86FH9vNZVdd69QOB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUFEXywAKdLCFnKfAPvAM0oiwU2733uX3qC42h7Sfkw=;
 b=HzWP1ofhCC/xxsjYFUGtTMRzV4bEz/r3e3//VKR/0h9fU6dNmCFQqC2sT5Z2uFUp+NdEPbFJzCnqThQZRWo+u1/VLPBBOH1Ph0Dc/igh5hcCvZUE+s2oMXFTqbvQ1GbyvSIaJyOqFLbtnAX9qSWI5r8e1Yc8v/BA7nRhUwfxYH4bpPNgszpRvzMCC88XLMyK2dqcF0QdSD+W4Kxtp/wlncUcCfDGAoP3lpPLmbSuqivX19k23C8osHt83n6MO5PkOtIjtUrPtNarUw27cY+w8/c6KJDRU5yqoVdcQTsPJ1yBXxEeewMWu+6X3dpVlbJz5Zp2tevshTZfUM5VVu4yQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUFEXywAKdLCFnKfAPvAM0oiwU2733uX3qC42h7Sfkw=;
 b=RwdFXehVJKi8lYU+Wh9auoPRaptcdsw3PsISNdb5/OGdJJZupcGZ610FFEsoGbCcRLs8APZWY1Bf1c7vHHYCVnGh2DlK+o9J7H4RPQNV7tGeZL9SgEHFECu5IQdvD1LqTfxzz2xp+UDDYnpnh+lW1oZknVi5UDFGpJsX0GZru18t/x9hx762uvhljeTdPOqdAsak5nPGMvqQWqeAZX3wp0VouAgaiBSCRsEl7ejoeVnfsxdsllAQr9z2Tr5MY7Ixyf6QFH5w+HkMbGn2f9zQq3xi+HpDLcJXS/cuIo1/gesZUI8PjOoUyjCXQSqT9LxIxFypFWM0Dqo2knW6JgD7eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:37:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:37:05 +0000
Message-ID: <c6d3e6e0-5531-426b-8d2d-939b2c9f68d9@siemens.com>
Date: Tue, 5 May 2026 18:37:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 4/4] ci: run ci tests on StarFive
 VisionFive2
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com
References: <20260505090627.65515-1-tobias.schaffner@siemens.com>
 <20260505090627.65515-5-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260505090627.65515-5-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d52376c-f024-4f37-09d5-08deaac48b20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SMtxMj/wzuaUzYavlU4wttl9kuFM8UtdsRksXQWdcjid5S1+TXJtdKf6jU5ND/asVaEc9ESB8oJZzJS0g3eW4aHne9jBw/It/a1RWh3T4FN0Zw3ZaxaSHlno1jhdRaYD7ZPmge8tI3Ht33DajP+Oy1wIfGCG9fIh4i86l73b+msFre0EqvseIYPrlZI/aH6eTU7IetLrzo2vDtF9LOcy4UBUEO+UZTpSDDielEvrjHINbVBqHwbhvIdnyde2GZ12/c/LjbYfVN84NYAz20+MoQaHsQ3MESst00iGaCNUk9QrURnYiSZHK3grkp92Xx5gFYEPvtUY4WYmPh9lKMQsx2NvGg+0Z5Xp87X+FECpvs1ZEtRxJgUMgHjyFVpPfZnA6kU9VFzIyD/TNGBGTP7pFZVNlN6nZdorvHzEnpPeIa3bRB8PZbhbZETOScj6o8bW0wrSTMbNjehS4bmLv4jIrsgCnKCZZjDcdXV9xpS1zI03t8eQF6vB5Su+sLhl/sO8UdN7Mih8lEPBBtqRcxapRh+CsBw50Qq/LHX8xJtM2TcS2Uf00VnYfPmuk91Iyd04U8o/xdeDPToMq4fUVXbm+ykw6lvEd5wlAvd1W2g+Vzp2493BxDZldO3BDG38TOzQdaU5oUnP7R948H0jZifsmLrPdvnX5qkbpwh+2pFeXNBwXyiHWw0iNuM/5c7tzz9L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2F5djQzYURoekorQnZFY1ZoZUJMQ1hYLzlqU2t3M1ptMHFpNTNwaytGQ1RJ?=
 =?utf-8?B?S0QxYUJ6VHdrSFRnbWxIWHFrRUxwMkRzYmp0T3EycjF6RVQ5MFBRN05Ea1BU?=
 =?utf-8?B?RWVDLzRvcUVDZjlMUldTKzRob2tsSm9pYzJlZFJEelhsZ2hlZk9GdFdsdjJ4?=
 =?utf-8?B?SnVWb280UzJKVEJldkpvSkVFeFpXVnZqY0FxZm10ZDZUN016OTEwMG0xbERm?=
 =?utf-8?B?U2daTTBUWWxBRDlMWFhyMlV2ekJsVjE2MGVocUl4bGk2V0NwbWtUa3dPOGJv?=
 =?utf-8?B?dVEvQkU0MUNxK1FDMk1aU0FvdGtQK2dVaGQ5VDZwSjBYNVBUeExybXpHN1p0?=
 =?utf-8?B?RHZ6eWVDaUEvVVk1UU0zMmY5Z2ZXNVF4WFY0WHkzVVZEZ3F1NnA5UTNOYUF0?=
 =?utf-8?B?ODh6WUFQSmh6eDh1cGlqQzEwTGF2OVRGSzZnNHZ2dkt1aWNkN3JnWVQyZWsw?=
 =?utf-8?B?QW4yK3lTS0E2Z3BxOVI3bEVsSGsvbUFnNjZWcDY1T2svVWRrOGxUVUxCUytD?=
 =?utf-8?B?V0tQTExPbC95QkZxbzFvR3VvSC9yK0pCSThsZ0toUzIvK2UzRWZFNFN2TjZr?=
 =?utf-8?B?blVDaU5ZNjBURW1Qc3FOMU44TzZUMENCMGlEcU9YMTIxN2w5d0x5SVdaQXM1?=
 =?utf-8?B?WldYczF3Q0JPNEV3cmE4WFE4RzZvTWRqSUNxTmpmbTdKN2QwQ2wxcjd3RUVu?=
 =?utf-8?B?a1hTNFdjdHYzdjl6R3h1empXVjBRYXV3RHhMNUNPbDJkRG04RURoQlR3KzJH?=
 =?utf-8?B?ZFZhSFRKakNaSUNuWkM5MlBsYVFLNzBuM3h4UmJVTXBzSUk1MTZmdGswc3cr?=
 =?utf-8?B?MVhZVEdZOXJqelV0eFlHcEh4Q282Rmdoa2tqb3BpZUluOXBGRzhuTHkxb3pY?=
 =?utf-8?B?OFl4VFFPUm5qT2pkZUs2ZExVbmllcHA1OXZva1YvYkVZRTlibzVGWVN0U2dy?=
 =?utf-8?B?ZTlJS2tpQ1JOUW9hRklXYmE4bVFSWjJUNkF1OTdldjlTUUk2emVtK3lrR2JG?=
 =?utf-8?B?SGk5dm0vME9zWDQ3b0NGbE1zM2IrSHN0QWpEQWd4eWQ0b3hSNzRGR0FLeURG?=
 =?utf-8?B?c3BndW12YzB6RjBaQ2Jvc1JKVXo5cXB0cHlGS2F0Z2pjVUlzV1dMd1lhSHgr?=
 =?utf-8?B?dW8wekErVEhib3JabDBGQ2FTRkZldzZOVkdCYmI3OEZoUWs4Z28wREYydVlZ?=
 =?utf-8?B?QVU4a1lCdGhJZ3hUempyZ0dDMHlLQ25NNzVXL3NmaEpGVkNCeVRjYzcza1hX?=
 =?utf-8?B?OENHRDRhZ2dvNm54OVpPbmNsT3FDc0YwcHBJNURqWnNvY0dEQTF1d25RU3VR?=
 =?utf-8?B?NWhhQllKUytMS29VVWtlS1Jsby9CU21SdGt3NVJFS0Rhd1Nzc2pxZTdrYWNL?=
 =?utf-8?B?clJUTWVXaHBvZU1mZ1BZd3ROdEtoSk0wR0RSaWtnV0M3RzUxQnNLR3g0b1NY?=
 =?utf-8?B?MUhKaXV6TElrTk0xZEdGOTRyKy9QeThSOUQzVDlHT09GZlBVNVV4aDYxUHI2?=
 =?utf-8?B?bGRXZ3ZmNUJ6WHNtSUtwZjZJdjFCeG1oemVNNTYwVW5MQTFiM0lYYzRPQ2JO?=
 =?utf-8?B?c01hUFI4QjFmV0NlcVcwbmxLQmIrRG9QWnlYSHBqQXU4bE1keFY5eGVSSWRK?=
 =?utf-8?B?dVYzOUI1a3NwaFhrYVFxcmZXK0xlQjlzMm11S1Nwd1J1TXU1dGZiZGYvMFha?=
 =?utf-8?B?M3IvNnp4dEFpY1huT0oraXdZK2FrMC9NczI5TFFKcm5DbE5xbWNjY21jbTI2?=
 =?utf-8?B?ZE9oVDdBUjlRbzZVcm91LzlVWTdKek1YcmROQTNOQmlOcmQ1djVNYWJ2cGp2?=
 =?utf-8?B?ZE1iTmtMZmZoUlA5UnZ6QkFoTjhhZ3EyRkJBMnU5KzlGT0l0djBqd2xVYkdD?=
 =?utf-8?B?ZzVnWXR5b2hDcnlpVzlFQ1pveFZ4U04xL2VvMVpvSVM3L0dSbTJzeDQrWHVV?=
 =?utf-8?B?MTViaWcxc1lMQjA0cTVpS1A1Qk1rK1BEejFCUngxbWVsZVJGbGhSSDBURkJr?=
 =?utf-8?B?eTZxSXQybkFwRFl6MVNOZGY3aWd3SGNFOXRFaS9yemZpeE9XRWlhZ2tQa09a?=
 =?utf-8?B?WHloOVdsMDFiNVJkcG5jNzRSeWxsRW1rYWZucmJXZ1l1Yjg4UGlERUE4clJF?=
 =?utf-8?B?VHJPSmpRZUVjR3E0YmkzVVFOblhOTkpKUnpOT2Q1UURqTkxybTFyMkxGMUNI?=
 =?utf-8?B?M1VPK25lU1hWMGtrb3VUWm8xTFRFNkRORUtJemxSSnlxMEFnQmYzWW9YRFZo?=
 =?utf-8?B?bktMRU0xczZTalZEbjBEVllPbXZ3K2hBZ1BLT3hhL2NPekN1TEdad3MvY1A1?=
 =?utf-8?B?bWNyWWhBWUwwVUJURkJVOFlsMVNvakpiOXRWUk93dnB2RUtzdm9LQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d52376c-f024-4f37-09d5-08deaac48b20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:37:05.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0e3y6rporjl19TIREdOMEAmDQfr7Sip9bYvwnpCr+On2ti3uTvgSFWKzw+789CeVtE3zHyBx34zUKOFgqm8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7904

On 05.05.26 11:06, Tobias Schaffner wrote:
> Add CI/LAVA build and test jobs for hardware testing on the
> StarFive VisionFive2 board.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/lib/gitlab-ci-base.yml                   | 21 +++++++
>  ci/lib/kernel/head.yml                      | 13 ++++
>  tests/jobs/xenomai-starfive-visionfive2.yml | 69 +++++++++++++++++++++
>  3 files changed, 103 insertions(+)
>  create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml
> 
> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
> index aaeb778..e297f54 100644
> --- a/ci/lib/gitlab-ci-base.yml
> +++ b/ci/lib/gitlab-ci-base.yml
> @@ -227,3 +227,24 @@ default:
>    resource_group: board-x86-64-efi
>    variables:
>      TARGET: x86-64-efi
> +
> +.build:starfive-visionfive2:
> +  extends: .build
> +  variables:
> +    TARGET: starfive-visionfive2
> +    CACHE_ARCH: riscv64
> +  rules:
> +    - if: '$XENOMAI_VERSION != "4-next"'
> +      when: never
> +    - when: always
> +
> +.lava-test:starfive-visionfive2:
> +  extends: .test
> +  resource_group: board-starfive-visionfive2
> +  variables:
> +    TARGET: starfive-visionfive2
> +    EVL_TESTS_SKIP_PATTERN: "ptrace-sync"
> +  rules:
> +    - if: '$XENOMAI_VERSION != "4-next"'
> +      when: never
> +    - if: '$LAVA_TESTS_ENABLED == "true"'
> diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
> index e2884c2..e5af966 100644
> --- a/ci/lib/kernel/head.yml
> +++ b/ci/lib/kernel/head.yml
> @@ -61,6 +61,19 @@ lava-test-head:qemu-riscv64:
>    variables:
>      KERNEL_VERSION: "head"
>  
> +build-head:starfive-visionfive2:
> +  extends: .build:starfive-visionfive2
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    KERNEL_VERSION: "head"
> +    CACHE_KERNEL: evl
> +
> +lava-test-head:starfive-visionfive2:
> +  needs: [ "build-head:starfive-visionfive2" ]
> +  extends: .lava-test:starfive-visionfive2
> +  variables:
> +    KERNEL_VERSION: "head"
> +
>  build-head:rpi4:
>    extends: .build:rpi4
>    variables:
> diff --git a/tests/jobs/xenomai-starfive-visionfive2.yml b/tests/jobs/xenomai-starfive-visionfive2.yml
> new file mode 100644
> index 0000000..6155fdf
> --- /dev/null
> +++ b/tests/jobs/xenomai-starfive-visionfive2.yml
> @@ -0,0 +1,69 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +job_name: xenomai-test-suite
> +device_type: starfive-visionfive2
> +
> +timeouts:
> +  job:
> +    minutes: 90
> +  action:
> +    minutes: 65
> +  connection:
> +    minutes: 5
> +priority: medium
> +visibility: public
> +
> +metadata:
> +  docs-source: xenomai-starfive-visionfive2
> +  docs-filename: pipeline-xenomai-starfive-visionfive2
> +# ACTION_BLOCK
> +actions:
> +- deploy:
> +    timeout:
> +      minutes: 30
> +    to: tftp
> +    kernel:
> +      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
> +      type: image
> +    dtb:
> +      url: ${DEPLOY_URL}/jh7110-starfive-visionfive-2-v1.2a.dtb

So, this only supports the old v1.2a, and I assume we need to be exact
here. Maybe name the test file accordingly so that it is clear which
hardware needs to be wired up?

> +    nfsrootfs:
> +      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
> +      compression: gz
> +#  BOOT_BLOCK
> +- boot:
> +    failure_retry: 3
> +    timeout:
> +      minutes: 5
> +    method: u-boot
> +    commands: nfs
> +    prompts: ["root@demo:"]
> +    auto_login:
> +      login_prompt: 'demo login:'
> +      username: root
> +      password_prompt: 'Password:'
> +      password: root
> +
> +- test:
> +    timeout:
> +      minutes: ${TEST_TIMEOUT_MINUTES}
> +    definitions:
> +    - repository:
> +        metadata:
> +          format: Lava-Test Test Definition 1.0
> +          name: xenomai-test-suite
> +          description: "runs the xenomai test suite"
> +        run:
> +          steps:
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
> +      from: inline
> +      path: inline/xenomai-test-suite.yaml
> +      name: xenomai-test-suite

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
