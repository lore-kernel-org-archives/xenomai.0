Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6632481FAE
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999054; cv=fail; b=J7CD/SUNJrSEBXdJQ2zi6bNXMuSn8Dn7/VDvoMkmYLjaP7Vux+F5WIgzxCdm95ydGjOuwtuI+Ye6VP2RCqGExLsdwHqdQ8IcoeWVSIJ3eWDRVcMjbXi1rWVXyz3+PdG2mqcYzoEKxpxlAaO2D3D+cwlH77NnUzxE5GtoDUrDj/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999054; c=relaxed/simple;
	bh=wbQGCQT/ZFQOJGVllVQASCJYhx+i35NXUp4kqeNA3Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fW9PIk3HrfFustbGYCb+Go2lZ1Hugbt7jUki5gDnj9T6U8NoDAO6+JDNaFILijuGCIfLwy2IqEXookNkPFlhjyLg3u59L4P01P6+ptlJH2U+SGPUvfubooU8txIZxBjZVKytndT6qg2yNCRIzCWtnjxn/CCYVXtVeUDte0zzzHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iW+e70Na; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iW+e70Na"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDX2ozenxyDTXj/YrAxg44ZGH9pF5s76pfPvmUgS6WE0B/aT0Us6mvdgb7E+vX2ZmJ7sXy12rKI+qCUp1atUpbZ6q3HN2Lqu6ctmb2NGIXJ51mph49o2/MCYrcgrFnM70YKL8bBL3pte0uuKJs819oKdGFGvMyK9F0Fz2HVhuASgQ25XpoumrDxYhNgh/i/tyGFp8K5fw0+7HE64bdpyU2Y39OulRYMAqw1OvYPUNMeQhhx9ATV/MN54+FOi35nzc54fubsE7ontvVCUVqGQu+h3hPDaSL+loy/VPeWgqZ7Du5EM3mw7l8CjpkaD2GWDrSNKr/xfxpB26IhYv8QTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/wocZRj5vWWbHYzCUSNdCLrCoPbS+m1gasVV/i8jJQ=;
 b=M3BB7y6IM/wPdLEwbPZ5Vr8biXX4JJ6NxfXvWLQBENM9QM/DiRq/nHCpqb9Ho3k0D+LbQlwXnVCtngdpQE7oilE/HBLh77QEAVRDqZa0Q2uDWRL7gb4ucUjBNXvlDJUg+KQAWwfubRGhiZSiftFhbgK+NXTGTMYY4fgCgUa6DdIlUYZ2dEMmWxhLyBC91ZEGwNrngYSK3MRZ2PG6+SPsHhCJwPuWeR39Y0n9sqx42fDL0f4O22XG5ru9TgCkvbr9pWOd9RTcWsJx9qunrxxCtvPtuvOCM60TMZoTknpnkuajLDxMp0bPveKB/aRgrpD0y5aibqm73bzUYXjAMUeprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/wocZRj5vWWbHYzCUSNdCLrCoPbS+m1gasVV/i8jJQ=;
 b=iW+e70NaxDTnmLrYHtzlZvgNR6fiYuu1NHxxvyqcmNUFtzFS3AFMr2T8oYuLJrlXyeiNKI/5q5Z/bXbfjw0EiTSkZb3WwNddMxhqK67gqDjyNgkBy3C2ZfmzZT1YXwf/suVox70rMVGxpMrrBLWQEfP4cz3qPQfjkd8F2ih6Apy1i7GXXW5PwCKNt1ryOAgu1u4XAlDfSj6kpzwWKwvIGoFcNAN2fyiI0HWt+z05p0cO5VsKWzLI2DgtxiDcS1plS6qAISnEFxeUlPr3BsaPZbfFfU1MrerBWoOIma11J/hTjkpDV+P/FxV8mEF9FdATNFFn+BNmJyYEDZC4l73MzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:37:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:37:29 +0000
Message-ID: <21e609ea-3c8a-4c1f-9c1f-fef5441b3cec@siemens.com>
Date: Tue, 5 May 2026 18:37:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 1/4] ci: Build and test the evl risc-v
 port on qemu
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com
References: <20260505090627.65515-1-tobias.schaffner@siemens.com>
 <20260505090627.65515-2-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260505090627.65515-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3938:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e67ef81-386e-4e18-3e42-08deaac498eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	1h/t/3aCqYLzcMfgGv/y8llfWrcZkmJdaQKCR81pv5dFXCZmeyp6DAm3VcJFsIzTcOzFWEt3c/WOHOsnOL7U14APkINAJEQWhZky38EYzonk+RIq1SCxTjM0J+qUYq9IQp0L1RRnADfYjCxJuxca5hhPXfAED4xq1TmGo/SS14hrHVvmfA6dabdP30hOgQ2lX/PpqOvJmPgouHAzf8d9IAPhuWlyGmzI1iFUQ634LR2nfO700b5twD842q1Tw+F0J09XLMSZxmauODKpzYyUUZuFvg/NqfHUqdpqPyDO5XHC//jqlc/ks1wzhUioQQAhW0exY91zpHl3zcie3DHo1rQvwyA2W1710GutFRYXf52SZcKJ+oYHMyMNaKrid/bgp/qQt/t4lOf2EmY/GKSaC/Eyq/7NdRud1tlrnnquT8QBLGXiZ6NXsolIrxUq3ugdKF16jrZUDHsZOoh0Gm2urBI6nr4UdX5P7XhOyAKo9GB00zYhir7KOgsJbxTmnlwHiNbheqHLUGPQxJElYNVHH/eUyYxr1QRDdTvkKQTr519wz2sgGH6N//A+IqmLjYRNLMjtr4JR1w79yhceKqyHrael3OYccPOSbn94IdZTN/z478BXMt0GgvYMc5hgB0ek+hrLTHaAyi7Ci7ZA51laYBP9rSzoWaVUxkequ5KoyyQdKNgqyE1Z8zD5unGdl77I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2xBeEp2blR0OW5mM3dvZmhnSnRNWUpSb3dpLzB6U2l6WlFFZjV1Mm9HbWJP?=
 =?utf-8?B?aUhnb1ZSQllFOU5QMEFRU0RGR3c3VU1sVS91OGhKeTZ3UmhGc3VjQVZLYWtV?=
 =?utf-8?B?Wjl5SUw0ejhwaE5OT2hvYi9ucnhvL3F4SmgyV2RjOEpXYWR1VDR0cyt2Vk5N?=
 =?utf-8?B?cEQzUVpwNjZoNVlTQU9Ma0NQSkVHZDY0V3hnMEZFVHQ4ZFBWRHRkb0tNY0Zy?=
 =?utf-8?B?VWhpTldoeHkvMG04bEIzdTQ1dFh3QlNGRWY5MjJvcG1oQ0RRN1BtKzcwdDNx?=
 =?utf-8?B?N3NCMW9EUitnZURGZ3RiMitDcXFubnZmLzBRajhlYU96RS9KSktqeFkzQ2JS?=
 =?utf-8?B?Sy9BTWw1YWxZUGNvYXhXclR1Z3EwQXMzcTRXWWhXWHZDQVV3Zk5UeVM2WmNl?=
 =?utf-8?B?N2hwRCtlc1lYTzBBUHJSbk9YKzNra3h1SXBJRUYyNTZiUGdreTFmMmNMTmtB?=
 =?utf-8?B?SVNXdXlGR1QycllqYWs0OUx1QlVVWHp1cTdpTEQ5WW1MNkU0eThIOEtkaFQ2?=
 =?utf-8?B?MWpSeWJqODdSNFVWZCtpeDExNUkrZ2Voc3ZRN3VvTm9ua044OXZlQ1Rua0FT?=
 =?utf-8?B?Y1RXSWFmaTBNZ0lQWnRYdkRCY01ZN2FHYmNUak9RZHlMU1FYOXdnQmJhYjdl?=
 =?utf-8?B?bThUNHNXV21QYkpVWTRmSFp6Uzc5dkdVNnZXc1ZuSkxCSndEMUU5aXczcFBU?=
 =?utf-8?B?dFRuc3luRWg4T1dGeXljOXBzdXRIRXJwK1lZMEFnOS9RdGhCOCtObHFBOFlw?=
 =?utf-8?B?YmlOOUcwVEplZnBaa1lic2JjVmxzNFVNc0VsQ0JkbUIrU1FTMHdlNzArQTU4?=
 =?utf-8?B?UzRINDd6eVVXSlR4VGpPVHh5cml3bUhmUkdkNENscWRRUzFkTGY3ZDR6SmhH?=
 =?utf-8?B?MUlEalY3RlkrbVlWZERQL0ZJMnhTM2lUZjF6a1FWR0NJVXk2QllXVmZhVy9P?=
 =?utf-8?B?RVMzUHMxUWhIK1VqWDYybnpIRXpsWm8zenRabzVHQUQ0TG44QnN5ZEU3eHdO?=
 =?utf-8?B?VCtVWGdFTHlqSGRzQkdjbU1lYlpXWTBudDJnWU85dGcvN0lFWXdjZGljbUVC?=
 =?utf-8?B?RE9PUHZqeWpYOUIycE0rL3Z5K3EyVkhrWHJkWDBDRlVMMUl3YnNvVkp3M2pC?=
 =?utf-8?B?Rk4xRmtkcE90Z2FDNklIb2RKZlpWenIzZlErRStScXViRDhJK21WdEIyQVQv?=
 =?utf-8?B?dzhUK0pCTU1TdTc3bUw4R2lFWU1MTEFwVEZLUUg2TjViRFRZalZYZ1pEVW9Z?=
 =?utf-8?B?ZzNidFE0OHF4Q2w5ODRlZ2JOR082SEhpclJUQlNaSEM1M0htcTN3MnBzZlBH?=
 =?utf-8?B?TjRSa0NBRVozeXpEVXVzV2hFb21tdEtkTk5qeDZHZmppYjhwekIzZnFvYnM5?=
 =?utf-8?B?L2pFcGxYSStrdGRZWTg4c2NWd3pIa0xGVkV1NHRxbUt5Q2h4MG53SFB5SS8w?=
 =?utf-8?B?eHlTQkJuZ0U2SG5BWlF2SlVienVIRW5zM3RIWEUrdEZtSVZySExJVVJ6NjZ2?=
 =?utf-8?B?bHVJUVd5MXAxNC83cDhQcDZhYk44QWRRZGNXc1puTG1mVU5DTWJZUmU4b29u?=
 =?utf-8?B?MzBHdFlSOFMvalZxRFpyckNkeHRVVUs1b0E3OVA3N0NmeXhaSnhkaDdWdU14?=
 =?utf-8?B?K2NtQjN0TTlWV3Y5OERBSDY5RlBFSTNtSWtoTk5HWmtyNFFIamFSRmZnVGdV?=
 =?utf-8?B?TzRLMnBpNjZUbzJ0eWxGb1p5NndzVTF1K2RpdnZQMm1XWTltK0NUUFM5SnBZ?=
 =?utf-8?B?Z1NaZDRkNDdObVErTloxaVBxVEx2NGtsa1Q0WFc3T2kvYzBXSGF2dFlCdVNO?=
 =?utf-8?B?ZG5ucjVIMllOWW5LQ2RuM2RNNmYzWmtwL0c3VHd3d3gxSXo0bUVOS1VaY1pY?=
 =?utf-8?B?NlZrdlZKdzdMcmxPYlVIbXUzZXFLOEhlbGx5MzRib2JSZmlCOUdLYklpVDJk?=
 =?utf-8?B?Zkk1ZFV5bGFJQ3Vpb0QrWG1Za2VlVndobDJvY20yVm5ldDRvTnFhZ3pSdS94?=
 =?utf-8?B?VkNQTVQrQ3Y4YTlOdTk4bEZqSWFZWXE2WHVRb0RYalpuSVl4eGIvWjM2VnZw?=
 =?utf-8?B?SngrYlBZQXBwWklTREhBNGd3Q0RpU1lBVGdZVlUwYXFQVnlOVm8rQ25FUlpK?=
 =?utf-8?B?bVdPM2EwWW5UeExFOEZPRHh3SWhHWUJQbDdTN1NlMEVsRllyRFRyZ2RrRkwz?=
 =?utf-8?B?M2svMXNkRmZocFAreG9DaTBheDhURGtTQlM5bzRSNGZzOWtLUERUUjFRY08v?=
 =?utf-8?B?SlNlOWpmNnM2SFZlYnYvU2M0ZHJnaTcxaTNUaFEraU1Ldi9Zak9MelZsUjZU?=
 =?utf-8?B?cW5UMDBlQWZrN3FLRzlSZkl0ZVBvbEVlQUpCL3VCa3hjd083dk1KUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e67ef81-386e-4e18-3e42-08deaac498eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:37:29.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW9WWrDkimdQr9GW6ZjfXX4bAn+5MP2EAcd6l9r74V15P2EJl2+EN70TagSvAhQXUsTmkQLcyzwf2u0yDQ044w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3938

On 05.05.26 11:06, Tobias Schaffner wrote:
> Build evl for quemu-riscv64 and run the evl tests in lava. Skip the
> ptrace-sync test for now as it fails because of an open issue in EVL.
> 
> Added sections in the end of the riscv64 defconfig for nfs and
> debugging specific configs to allow easy factoring out as snippets
> later.
> 
> Only run the tests on the qemu05 runner (tag: SIEMENS_ERL_QEMU) as long
> as qemu01 runs on the outdated qemu 7.2.2 which hangs up with riscv
> workloads from time to time.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/lib/gitlab-ci-base.yml                    |  38 ++-
>  ci/lib/kernel/head.yml                       |  13 +
>  conf/machine/qemu-riscv64.conf               |   1 -
>  recipes-kernel/linux/files/common_nodbg.cfg  |   2 +
>  recipes-kernel/linux/files/riscv64_defconfig | 335 +++++++++++++++++++
>  tests/jobs/xenomai-qemu-riscv64.yml          |  95 ++++++
>  6 files changed, 477 insertions(+), 7 deletions(-)
>  create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
>  create mode 100644 tests/jobs/xenomai-qemu-riscv64.yml
> 
> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
> index d815474..aaeb778 100644
> --- a/ci/lib/gitlab-ci-base.yml
> +++ b/ci/lib/gitlab-ci-base.yml
> @@ -85,11 +85,14 @@ default:
>        paths:
>          - build/downloads
>  
> +.build-qemu-rules: &build-qemu-rules
> +  - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> +  - if: '$ALL_QEMU_JOBS == "true"'
> +
>  .build-qemu:
>    extends: .build
>    rules:
> -    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> -    - if: '$ALL_QEMU_JOBS == "true"'
> +    - *build-qemu-rules
>  
>  .test:
>    stage: test
> @@ -109,6 +112,12 @@ default:
>    rules:
>      - if: '$LAVA_TESTS_ENABLED == "true"'
>  
> +.test-qemu-rules: &test-qemu-rules
> +  - if: '$LAVA_TESTS_ENABLED != "true"'
> +    when: never
> +  - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> +  - if: '$ALL_QEMU_JOBS == "true"'
> +
>  .test-qemu:
>    extends: .test
>    variables:
> @@ -116,10 +125,7 @@ default:
>      ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>      EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
>    rules:
> -    - if: '$LAVA_TESTS_ENABLED != "true"'
> -      when: never
> -    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
> -    - if: '$ALL_QEMU_JOBS == "true"'
> +    - *test-qemu-rules
>  
>  .build:qemu-amd64:
>    extends: .build-qemu
> @@ -154,6 +160,26 @@ default:
>    variables:
>      TARGET: qemu-arm64
>  
> +.build:qemu-riscv64:
> +  extends: .build-qemu
> +  variables:
> +    TARGET: qemu-riscv64
> +    CACHE_ARCH: riscv64
> +  rules:
> +    - if: '$XENOMAI_VERSION != "4-next"'
> +      when: never
> +    - *build-qemu-rules
> +
> +.lava-test:qemu-riscv64:
> +  extends: .test-qemu
> +  variables:
> +    TARGET: qemu-riscv64
> +    EVL_TESTS_SKIP_PATTERN: "ptrace-sync|sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
> +  rules:
> +    - if: '$XENOMAI_VERSION != "4-next"'
> +      when: never
> +    - *test-qemu-rules
> +
>  .build:hikey:
>    extends: .build
>    variables:
> diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
> index 376a002..e2884c2 100644
> --- a/ci/lib/kernel/head.yml
> +++ b/ci/lib/kernel/head.yml
> @@ -48,6 +48,19 @@ lava-test-head:qemu-arm64:
>    variables:
>      KERNEL_VERSION: "head"
>  
> +build-head:qemu-riscv64:
> +  extends: .build:qemu-riscv64
> +  variables:
> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
> +    KERNEL_VERSION: "head"
> +    CACHE_KERNEL: evl
> +
> +lava-test-head:qemu-riscv64:
> +  needs: [ "build-head:qemu-riscv64" ]
> +  extends: .lava-test:qemu-riscv64
> +  variables:
> +    KERNEL_VERSION: "head"
> +
>  build-head:rpi4:
>    extends: .build:rpi4
>    variables:
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
> index 8dfcda4..4fb66c4 100644
> --- a/conf/machine/qemu-riscv64.conf
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -12,4 +12,3 @@
>  require qemu-machine.inc
>  
>  DISTRO_ARCH = "riscv64"
> -KERNEL_DEFCONFIG = ""
> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
> index a57463b..6637d16 100644
> --- a/recipes-kernel/linux/files/common_nodbg.cfg
> +++ b/recipes-kernel/linux/files/common_nodbg.cfg
> @@ -1,5 +1,7 @@
>  # CONFIG_IPIPE_DEBUG is not set
>  # CONFIG_XENO_OPT_DEBUG is not set
> +# CONFIG_EVL_DEBUG is not set
> +# CONFIG_EVL_DEBUG_CORE is not set
>  # CONFIG_DEBUG_VM is not set
>  # CONFIG_DEBUG_LIST is not set
>  # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kernel/linux/files/riscv64_defconfig
> new file mode 100644
> index 0000000..a4ffa7f
> --- /dev/null
> +++ b/recipes-kernel/linux/files/riscv64_defconfig
> @@ -0,0 +1,335 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_CGROUPS=y
> +CONFIG_MEMCG=y
> +CONFIG_BLK_CGROUP=y
> +CONFIG_CGROUP_SCHED=y
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_CGROUP_PIDS=y
> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CGROUP_HUGETLB=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_CGROUP_PERF=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_USER_NS=y
> +CONFIG_CHECKPOINT_RESTORE=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_PROFILING=y
> +CONFIG_ARCH_ANDES=y
> +CONFIG_ARCH_ANLOGIC=y
> +CONFIG_ARCH_MICROCHIP=y
> +CONFIG_ARCH_SIFIVE=y
> +CONFIG_ARCH_SOPHGO=y
> +CONFIG_ARCH_SPACEMIT=y
> +CONFIG_SOC_STARFIVE=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_ARCH_TENSTORRENT=y
> +CONFIG_ARCH_THEAD=y
> +CONFIG_ARCH_VIRT=y
> +CONFIG_ARCH_CANAAN=y
> +CONFIG_SMP=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> +CONFIG_CPUFREQ_DT=y
> +CONFIG_ACPI_CPPC_CPUFREQ=m
> +CONFIG_VIRTUALIZATION=y
> +CONFIG_KVM=m
> +CONFIG_ACPI=y
> +CONFIG_JUMP_LABEL=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_BLK_DEV_THROTTLING=y
> +CONFIG_SPARSEMEM_MANUAL=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_XFRM_USER=m
> +CONFIG_IP_MULTICAST=y
> +CONFIG_IP_ADVANCED_ROUTER=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +CONFIG_IP_PNP_RARP=y
> +CONFIG_INET_ESP=m
> +CONFIG_NETFILTER=y
> +CONFIG_BRIDGE_NETFILTER=m
> +CONFIG_NF_CONNTRACK=m
> +CONFIG_NF_CONNTRACK_FTP=m
> +CONFIG_NF_CONNTRACK_TFTP=m
> +CONFIG_NETFILTER_XT_MARK=m
> +CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> +CONFIG_NETFILTER_XT_MATCH_IPVS=m
> +CONFIG_IP_VS=m
> +CONFIG_IP_VS_PROTO_TCP=y
> +CONFIG_IP_VS_PROTO_UDP=y
> +CONFIG_IP_VS_RR=m
> +CONFIG_IP_VS_NFCT=y
> +CONFIG_NF_LOG_ARP=m
> +CONFIG_NF_LOG_IPV4=m
> +CONFIG_IP_NF_IPTABLES=m
> +CONFIG_IP_NF_FILTER=m
> +CONFIG_IP_NF_TARGET_REJECT=m
> +CONFIG_IP_NF_NAT=m
> +CONFIG_IP_NF_TARGET_MASQUERADE=m
> +CONFIG_IP_NF_TARGET_REDIRECT=m
> +CONFIG_IP_NF_MANGLE=m
> +CONFIG_NF_LOG_IPV6=m
> +CONFIG_IP6_NF_IPTABLES=m
> +CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> +CONFIG_IP6_NF_FILTER=m
> +CONFIG_IP6_NF_TARGET_REJECT=m
> +CONFIG_IP6_NF_MANGLE=m
> +CONFIG_BRIDGE=m
> +CONFIG_BRIDGE_VLAN_FILTERING=y
> +CONFIG_VLAN_8021Q=m
> +CONFIG_NET_SCHED=y
> +CONFIG_NET_CLS_CGROUP=m
> +CONFIG_NETLINK_DIAG=y
> +CONFIG_CGROUP_NET_PRIO=y
> +CONFIG_CAN=m
> +CONFIG_NET_9P=y
> +CONFIG_NET_9P_VIRTIO=y
> +CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
> +CONFIG_PCI_HOST_GENERIC=y
> +CONFIG_PCIE_XILINX=y
> +CONFIG_PCIE_FU740=y
> +CONFIG_PCIE_STARFIVE_HOST=m
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_SIFIVE_CCACHE=y
> +CONFIG_MTD=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_CFI=y
> +CONFIG_MTD_CFI_ADV_OPTIONS=y
> +CONFIG_MTD_SPI_NOR=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_VIRTIO_BLK=y
> +CONFIG_BLK_DEV_NVME=m
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_BLK_DEV_SR=y
> +CONFIG_SCSI_VIRTIO=y
> +CONFIG_ATA=y
> +CONFIG_SATA_AHCI=y
> +CONFIG_SATA_AHCI_PLATFORM=y
> +CONFIG_MD=y
> +CONFIG_BLK_DEV_DM=m
> +CONFIG_DM_THIN_PROVISIONING=m
> +CONFIG_NETDEVICES=y
> +CONFIG_DUMMY=m
> +CONFIG_MACVLAN=m
> +CONFIG_IPVLAN=m
> +CONFIG_VXLAN=m
> +CONFIG_VETH=m
> +CONFIG_VIRTIO_NET=y
> +CONFIG_MACB=y
> +CONFIG_E1000E=y
> +CONFIG_R8169=y
> +CONFIG_STMMAC_ETH=y
> +CONFIG_STMMAC_PLATFORM=y
> +CONFIG_DWMAC_STARFIVE=y
> +CONFIG_DWMAC_THEAD=m
> +CONFIG_MICREL_PHY=y
> +CONFIG_MICROSEMI_PHY=y
> +CONFIG_MOTORCOMM_PHY=y
> +CONFIG_INPUT_MOUSEDEV=y
> +CONFIG_INPUT_EVDEV=y
> +CONFIG_KEYBOARD_GPIO=y
> +CONFIG_KEYBOARD_SUN4I_LRADC=m
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> +CONFIG_VIRTIO_CONSOLE=y
> +CONFIG_HW_RANDOM=y
> +CONFIG_HW_RANDOM_VIRTIO=y
> +CONFIG_HW_RANDOM_JH7110=m
> +CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=m
> +CONFIG_I2C_DESIGNWARE_CORE=y
> +CONFIG_I2C_MV64XXX=m
> +CONFIG_SPI=y
> +CONFIG_SPI_CADENCE_QUADSPI=m
> +CONFIG_SPI_FSL_QUADSPI=m
> +CONFIG_SPI_PL022=m
> +CONFIG_SPI_SIFIVE=y
> +CONFIG_SPI_SUN6I=y
> +# CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_PINCTRL_TH1520=y
> +CONFIG_PINCTRL_SOPHGO_CV1800B=y
> +CONFIG_PINCTRL_SOPHGO_CV1812H=y
> +CONFIG_PINCTRL_SOPHGO_SG2000=y
> +CONFIG_PINCTRL_SOPHGO_SG2002=y
> +CONFIG_GPIO_DWAPB=y
> +CONFIG_GPIO_SIFIVE=y
> +CONFIG_GPIO_SPACEMIT_K1=y
> +CONFIG_POWER_RESET_GPIO_RESTART=y
> +CONFIG_SENSORS_SFCTEMP=m
> +CONFIG_CPU_THERMAL=y
> +CONFIG_DEVFREQ_THERMAL=y
> +CONFIG_WATCHDOG=y
> +CONFIG_SUNXI_WATCHDOG=y
> +CONFIG_MFD_AXP20X_I2C=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_AXP20X=y
> +CONFIG_REGULATOR_GPIO=y
> +CONFIG_MEDIA_SUPPORT=m
> +CONFIG_MEDIA_PLATFORM_SUPPORT=y
> +CONFIG_VIDEO_CADENCE_CSI2RX=m
> +CONFIG_DRM=m
> +CONFIG_DRM_RADEON=m
> +CONFIG_DRM_NOUVEAU=m
> +CONFIG_DRM_SUN4I=m
> +CONFIG_DRM_VIRTIO_GPU=m
> +CONFIG_FB=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_DESIGNWARE_I2S=m
> +CONFIG_SND_SOC_JH7110_PWMDAC=m
> +CONFIG_SND_SOC_JH7110_TDM=m
> +CONFIG_SND_SOC_WM8978=m
> +CONFIG_SND_SIMPLE_CARD=m
> +CONFIG_USB=y
> +CONFIG_USB_OTG=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_PLATFORM=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_HCD_PLATFORM=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_UAS=y
> +CONFIG_USB_CDNS_SUPPORT=m
> +CONFIG_USB_CDNS3=m
> +CONFIG_USB_CDNS3_GADGET=y
> +CONFIG_USB_CDNS3_HOST=y
> +CONFIG_USB_CDNS3_STARFIVE=m
> +CONFIG_USB_MUSB_HDRC=m
> +CONFIG_USB_MUSB_SUNXI=m
> +CONFIG_NOP_USB_XCEIV=m
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_CONFIGFS=m
> +CONFIG_USB_CONFIGFS_SERIAL=y
> +CONFIG_USB_CONFIGFS_ACM=y
> +CONFIG_USB_CONFIGFS_OBEX=y
> +CONFIG_USB_CONFIGFS_NCM=y
> +CONFIG_USB_CONFIGFS_ECM=y
> +CONFIG_USB_CONFIGFS_ECM_SUBSET=y
> +CONFIG_USB_CONFIGFS_RNDIS=y
> +CONFIG_USB_CONFIGFS_EEM=y
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> +CONFIG_USB_CONFIGFS_F_FS=y
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_OF_DWCMSHC=y
> +CONFIG_MMC_SDHCI_OF_K1=y
> +CONFIG_MMC_SDHCI_CADENCE=y
> +CONFIG_MMC_SPI=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_STARFIVE=y
> +CONFIG_MMC_SUNXI=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_SUN6I=y
> +CONFIG_DMADEVICES=y
> +CONFIG_DMA_SUN6I=m
> +CONFIG_DW_AXI_DMAC=y
> +CONFIG_MMP_PDMA=m
> +CONFIG_VIRTIO_PCI=y
> +CONFIG_VIRTIO_BALLOON=y
> +CONFIG_VIRTIO_INPUT=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_CLK_SOPHGO_CV1800=y
> +CONFIG_CLK_SOPHGO_SG2042_PLL=y
> +CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
> +CONFIG_CLK_SOPHGO_SG2042_RPGATE=y
> +CONFIG_SPACEMIT_K1_CCU=y
> +CONFIG_SPACEMIT_K3_CCU=y
> +CONFIG_SUN8I_DE2_CCU=m
> +CONFIG_SUN50I_IOMMU=y
> +CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_CTRL=y
> +CONFIG_RPMSG_VIRTIO=y
> +CONFIG_PM_DEVFREQ=y
> +CONFIG_IIO=y
> +CONFIG_PWM=y
> +CONFIG_PWM_PXA=m
> +CONFIG_THEAD_C900_ACLINT_SSWI=y
> +CONFIG_PHY_SUN4I_USB=m
> +CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
> +CONFIG_PHY_STARFIVE_JH7110_PCIE=m
> +CONFIG_PHY_STARFIVE_JH7110_USB=m
> +CONFIG_CLK_STARFIVE_JH7110_AON=y
> +CONFIG_CLK_STARFIVE_JH7110_STG=y
> +CONFIG_LIBNVDIMM=y
> +CONFIG_NVMEM_SUNXI_SID=y
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_BTRFS_FS=m
> +CONFIG_BTRFS_FS_POSIX_ACL=y
> +CONFIG_AUTOFS_FS=y
> +CONFIG_OVERLAY_FS=m
> +CONFIG_ISO9660_FS=y
> +CONFIG_JOLIET=y
> +CONFIG_ZISOFS=y
> +CONFIG_MSDOS_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_TMPFS_POSIX_ACL=y
> +CONFIG_HUGETLBFS=y
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V4=y
> +CONFIG_NFS_V4_1=y
> +CONFIG_NFS_V4_2=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_9P_FS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_SECURITY=y
> +CONFIG_SECURITY_SELINUX=y
> +CONFIG_SECURITY_APPARMOR=y
> +CONFIG_DEFAULT_SECURITY_DAC=y
> +CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_DEV_VIRTIO=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_DEBUG_FS=y
> +# CONFIG_RUNTIME_TESTING_MENU is not set
> +CONFIG_MEMTEST=y
> +
> +# lava lab nfs enablement
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V3=y
> +CONFIG_NFS_V4=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +
> +# debug additions
> +CONFIG_BUG_ON_DATA_CORRUPTION=y
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_DEBUG_LIST=y
> +CONFIG_DEBUG_LOCK_ALLOC=y
> +CONFIG_DEBUG_VM=y
> +CONFIG_DYNAMIC_FTRACE=y
> +CONFIG_EVL_DEBUG=y
> +CONFIG_EVL_DEBUG_CORE=y
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_STACKTRACE=y
> diff --git a/tests/jobs/xenomai-qemu-riscv64.yml b/tests/jobs/xenomai-qemu-riscv64.yml
> new file mode 100644
> index 0000000..d1f0217
> --- /dev/null
> +++ b/tests/jobs/xenomai-qemu-riscv64.yml
> @@ -0,0 +1,95 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +device_type: qemu
> +job_name: QEMU pipeline, xenomai-images-qemu-riscv64
> +tags:
> +  - SIEMENS_ERL_QEMU
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
> +# context allows specific values to be overridden or included
> +context:
> +  # tell the qemu template which architecture is being tested
> +  # the template uses that to ensure that qemu-system-riscv64 is executed.
> +  arch: riscv64
> +  cpu: rv64
> +  machine: virt
> +  no_kvm: True
> +  extra_options:
> +  - -smp 2
> +  - -m 2048
> +  - -device virtio-serial-device
> +  - -device virtconsole,chardev=con
> +  - -chardev vc,id=con
> +  - -device virtio-blk-device,drive=disk
> +  - -device virtio-net-pci,netdev=net
> +  - -netdev user,id=net
> +  guestfs_interface: virtio
> +metadata:
> +  # please change these fields when modifying this job for your own tests.
> +  docs-source: xenomai-qemu-riscv64
> +  docs-filename: qemu-pipeline-xenomai-riscv64
> +
> +# ACTION_BLOCK
> +actions:
> +- deploy:
> +    timeout:
> +      minutes: 15
> +    to: tmpfs
> +    images:
> +      kernel:
> +        image_arg: -kernel {kernel} -append "root=/dev/vda rw"
> +        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
> +      initrd:
> +        image_arg: -initrd {initrd}
> +        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
> +      rootfs:
> +        image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
> +        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.gz
> +        compression: gz
> +# BOOT_BLOCK
> +- boot:
> +    timeout:
> +      minutes: 15
> +    method: qemu
> +    media: tmpfs
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
> +          description: "runs the xenomai smokey test suite"
> +          maintainer:
> +            - tobias.schaffner@siemens.com
> +        run:
> +          steps:
> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
> +      from: inline
> +      path: inline/xenomai-test-suite.yaml
> +      name: xenomai-test-suite

This looks good, so I'm taking it to next already.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
