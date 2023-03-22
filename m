Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C851FB1
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 07:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE/j9uh6OBG23m43SFhl+9oZNY6RRruLShCHaJvp5ED7sX+t111hUwNIbiCtsg2zTATmZCTV0BCOcNF60TVdG/y5nC2ohFdGL22OMpImpHZkGXvxGfc30XemBOTA+gYBx3vphNydh8oO1ytkugSJfax0806Mfc1UK2AoyeKGcoE6vPde1n3deaDqiqyViOrsIQgps+X3cXzztAcXqIApBHyldhdGbri0wWZHH1h3rylp3+XG4wryxy9rs3o/D89QsOxck8RtzHjHmc9KOeMMZKXbEDwspxf6uWziRc9cvvFajpuG5+vj7iNbIcAg+jrxF6GrN3eH4uxZ9haKImoZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS6al7/QeDJRvNDNdbdI+zs7pq5dsvPUFsa4gMET/gw=;
 b=aOZURCnpvOiwlaGeeJOxMdVjNK2GpZxM9rb22xK5SI5C7uTRr5WAAmJJKjta1ETz+yldHFtCagP+AM1xJZLVwLdb7fNWroQUqmuSmkMYIPk3cgWnaQ+MyhUt9xdW0HzZO7lVPkB3u5PLOHGVwHWuiIQoGMBQm6aHgnDgCk62aymR6qxUWyzcMu2mcSno3EUdBB1OS0J5p2hROFxwlfUpXskCPdmQzjaq3cWcTFCX5ujVrauM+jwlK1HEvdwK/8RJnLdronjOp4ZEtWeLeKqEd13U4mafYXaLetImYkleDwOzdBm0sS20vc/skcKVczsvZELtT/ovj7szrv2bA6FT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS6al7/QeDJRvNDNdbdI+zs7pq5dsvPUFsa4gMET/gw=;
 b=PuhJ8x1R4exYdC8gYrP1SU98ny2awWQHflALpLcZmsZTiH/0/0MiIdrl8bcXKGYkGs1nuvQYBBbVHwCKdzsTLxcrzhOangk0W/ICxopQuSMVbD9vp0YjnGK1BbpESE8VK5JLScRes/iOdTXcNx+IO0hJnqFNI4UMJMcFBzsmZ1R7J054h806lLsLZF5f+hfzysNcoSfoT47B6LV+Fir6fOWJtEOOpHgIVlKxda6P606aRonQGOfkE2alOM6rWMdUJEifrO79/t5JSjyJa/q81vkHxcJKcK7IO2OPXcNNN094UeKDNH9F+JKBqWhbl5LKsJWYPbJQS+XVy9sTdfFRsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Wed, 22 Mar
 2023 07:49:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Wed, 22 Mar 2023
 07:49:53 +0000
Message-ID: <36d74732-6c5e-c4d8-621f-d6f8cff59edf@siemens.com>
Date: Wed, 22 Mar 2023 08:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [xenomai-images][PATCH 1/2] ci: Run qemu jobs only for the latest
 supported kernel version
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230228104434.15829-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230228104434.15829-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3800:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9dd3a4-c538-448a-c856-08db2aaa0605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dYOQdPs7y8MXBQnrCLOJEsUQjkoQPEiRq/wi6nrqCNAsiv7p01CnvOn9IGfVfNc2Hi/MDeQTykEwep4oMDXOWFHSTlR2eh1dw6nWnebSAuHXjmdzqGz9DUIWDjtNklmvFaD9yA0nbyUNC2eL4Xqz2lifuWP+UX5iART+oYXz+UKGnRlzqXNyqU1Z2YNEK8FOESgJoRtPzvbzPZJWBX7qkzigMTywOSeb49GynO6tDy/YQEsGO5pfcQ0TvXtfnc2TJXR+gk1GlwbcxeTA7J+E8bt8p1NtaTCVbZ05jsyzcdqNUfCfBwwh+MyW9tGdgAuooNaY8qgQebB/VHwvNVZPiA3t6CoqpHYu3XHrhS9ekk9iA0TTkI24re1kZWKggOukqII8ef2c3ez+dDREh0MUB7PbAonbfySzrvYoQfYmUyhlXfHBjrnymBzSP2mxZPFuM2F2m5q1eKifQS+7tnsxP/alPypLmTwNpRAa/pAg0Ho+133BIC/GVzUHft0WJr5nw15CIDylLWJH68YDo8mqFTlsRxE8zNON4EdlX7wYg/Bg1ZCf0/beWBIxP8L6j1XDtboVVbME605MNZKr6I+WzZR+srHxlVgpRoaUbibHS9tLHyvXsqtI+2upCKlQ2hjv7upzJ+2+SPRYwPDVv6maOVbFd9Z/TmG1tgmwYftTfkUXpkvvbMo9HZrCn3wghfJEbOthnAVeZAy5dK7MNMXRGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(41300700001)(966005)(83380400001)(66476007)(66556008)(66946007)(8676002)(36756003)(6486002)(26005)(38100700002)(8936002)(31686004)(82960400001)(478600001)(2616005)(316002)(186003)(6512007)(53546011)(6506007)(44832011)(31696002)(5660300002)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1NrYWFyOGJkQWpoMmdlT1VFUmJLY0wrTWhoSUFaNFU2eWIrYzBEdEZEc09S?=
 =?utf-8?B?ZVd0bzBOL2tiVHpXNzI1OWVDTWdaMFBiQTFqd0xna1dFZFo3a3k2dVFqZG5C?=
 =?utf-8?B?RmNCUm9VRzRleTBiVFNmSzE2L3FzUmtmQ3VYS0Y3V0VSWVNKTG1hOEJuV3Bs?=
 =?utf-8?B?M1VqdG5ZREJZMDZ4d3UxYXAydG9oY0tXdUNtUmkvT2NXd1hPdDJ5ekw0RWZn?=
 =?utf-8?B?ZmpvQ1ZCelROZ0xNMVhUUXdvenEwUEowaWl0N0VpVkcvMVlMN0VobTZNL1A3?=
 =?utf-8?B?UEY5V2c2TGlHbldnQTdoMlZvOE1vcmlFQndTNDkrTlJNOFNiKzFTYlJkL0du?=
 =?utf-8?B?MGVFRUpjMTN5MnBBNTdWZHlodzdJWFM2ZlN6WXVibjNkbFhFelVaemRwQTFm?=
 =?utf-8?B?UjZQc3RuV3FXYlB4QTI1TjJXdzdGdEZDL0VjYk5lODYwblNtWEdlZUk2NzVB?=
 =?utf-8?B?dVk5QVZqVy83TjVScCtja3ljdFdMa3gxQnVjYTh0bVl5d3c0L3hvYXhHL2ZM?=
 =?utf-8?B?blk2Z3NNSyt5Z0RzOEZ1dm12Ty9NYUo3alZXSWJKK1lLdktMZHpwd3lWNGJV?=
 =?utf-8?B?UE1nMWhRQm0rQ3JhZTJHUUM3R2w5bjU4WWh3OHFBcjFGcUNaeDJ4TDdoR2dk?=
 =?utf-8?B?eUZwaVJlUFdUQ3JvYkdmZFJxaStGZFFjdENVVU5KcGhpUGhBbnp5Q1VSWGd2?=
 =?utf-8?B?ek5CaHB3ODFWV2o2NzdKeFBBWXRHOWVMODVIWmR1ZzQ3Z2txRHpkdFRwZmFt?=
 =?utf-8?B?MDNtRlRUWm82SmZtczA2OTczVFFSMmVSWCsrVU5KSlFGMzVON0IwQTdrWEds?=
 =?utf-8?B?THQ0Q0xRQ2RVekRXQXdHZ1AyMHY0WEFDUkdoVjlzdHBCaE8zelpPTmpHM1pX?=
 =?utf-8?B?YVh6eEhzZG5EUlh5Y2xjcTVLRCs1V1lFYmxXaTVOQlVFSnVtRk5rSHZyUTQz?=
 =?utf-8?B?cUFXMW1IQ3BDTUxWNm1Bb0E3Tm5Eb0RnemZoUEJiNlAzRUxYSkJvYmwyeWdG?=
 =?utf-8?B?aFk1RHhwUzhPMVdBR0ovQmt0eVBYUThjdlY0NTR6Sk1RYnBqREdRK0E2TVAy?=
 =?utf-8?B?SlpkdW5lN0JGekR0ZFFVb3ZQOG9Gd0diQWNKekgzWkhKWm9EMk16ODBtTmpW?=
 =?utf-8?B?cWNrSnhPTlcvcWQzcnFrU2R5cC9iRFl0bFlNOEpjS2hLd1BaTk1LZUxUMnYv?=
 =?utf-8?B?K2NQRlN3NXJJUklNQm5paWhQdCs5QUk1NE4vT09OWlU1MnJERXNFeGhyWEQz?=
 =?utf-8?B?ZUYraVFFQW13QllUUjlMdzU4STBjamZqYjlrMXVqUXQxWlJoaHF1aWppZFVX?=
 =?utf-8?B?M2c4NlBJdk9LL0VjVnM2Z2lwSGQ2QUtTa3UzQVhoTDhaWS9hanY0Y1p0RVBH?=
 =?utf-8?B?anBOdFJmTzM3TmxoYnVwL0FNazN4Yk9RTjk3NTdRNGxVaEJmK1pTUDNIVUgv?=
 =?utf-8?B?NWd5RXpMdmlmMUpCZ3lKd0VHM1JyNVRCM0FaSzd0QzF6MWIxUmd1SjE0eUZN?=
 =?utf-8?B?cDlEQ0psZWZqSC9rcGNBeno2UTI4OTQ4SDdsR05OSmkxbk1lckx3V01BZ0hk?=
 =?utf-8?B?a2ltWmtRZUV5QUkrbWpnb1JzVDk4K0tVckJpUkxpZFZXMHNHaHVUMXc5bUs0?=
 =?utf-8?B?cWdPV0hTUU5PYmh4VWw3U2MrV3Bla3NPZFR4S1hwZnJZb1k5VmVoZGJqRDVQ?=
 =?utf-8?B?Vmc0OGZxWkdQdFJsVExXWEd4SnRVdjRyYllodmoxTmZrWHY0U0lYYzNLWHBN?=
 =?utf-8?B?VGVqZk1hKzhQTHZCZ2dPNDRubVo2REZxZkVKRmNYNXg4b0J4ZFBXQUgzcjY3?=
 =?utf-8?B?T2Z3K0czcWR3RFJITWpCeXlQVmNjTzZiTlFCRDRSUi9HYWxXV0I3RFZwSjJD?=
 =?utf-8?B?R3FmZCtZbWRMa3NVejFHQTQ4ZmZPcWpvWUxWTWFvTzRLTnRMZWcrNnk1VHk0?=
 =?utf-8?B?aEhnZjh0aU1nQmtWY0hXYVpwSHR6aFlkVXBRT284VmNPaUNZajg1cHVhOTlj?=
 =?utf-8?B?VVowcWhKSXhKa0lMQy9VNzcxaHFISXEwT3Uxd3gzZ2x4TnJuU1RjcisrcVBa?=
 =?utf-8?B?eE5tdDgwcEVQc0hQZHBPY0x0R0UzMjV3cS9vMlIvalJ3QldFU1J4TVcyczFP?=
 =?utf-8?B?bWhqNzlvSnFxSjBJdUhLRzJtcXpkMm9lVlFoT3FEVWRjLy9JOTlOV25NL1pX?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9dd3a4-c538-448a-c856-08db2aaa0605
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 07:49:53.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ywMONoXhZo4PDIj4Kd206WLdCANeET+7qlFUwlH1+yAji9qPqTaneLSFSIkCVJC744uSxH2DVM90Og5m8PPgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3800

On 28.02.23 11:44, Florian Bezdeka wrote:
> Each branch (represented by the xenomai_<branch>.yml files) can now
> define the latest kernel version that is supported by this branch. The
> qemu build and test jobs will only be run for this kernel version.
> 
> Note: The stable/v3.0.x and stable/v3.1.x branches do not define a
> latest kernel version. For those branches no qemu build and test jobs
> will be scheduled. For stable/v3.0.x the situation is unchanged,
> for stable/v3.1.x no qemu tasks will be scheduled anymore.
> 
> All qemu jobs can be re-enabled on pipeline creation time when the env
> variale named ALL_QEMU_JOBS is set to "true". CI documentation has been
> updated.
> 
> ALL_QEMU_JOBS and LAVA_TESTS_ENABLED might be feeded in by the gitlab UI
> to limit the number of CI jobs.
> 
> We have to forward this variables to the downstream pipelines. Previously
> they were defined with their default values in downstream pipelines which
> made it impossible to overwrite the default from outside.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  .gitlab-ci.yml        |  7 +++++++
>  ci/gitlab-ci-base.yml | 25 ++++++++++++++++++-------
>  ci/xenomai_3_2_x.yml  |  1 +
>  ci/xenomai_next.yml   |  1 +
>  tests/README.md       |  4 ++++
>  5 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 58398fc..58d61b1 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -9,6 +9,10 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> +variables:
> +  LAVA_TESTS_ENABLED: "true"
> +  ALL_QEMU_JOBS: "false"
> +
>  stages:
>    - parent
>  
> @@ -16,6 +20,9 @@ stages:
>    stage: parent
>    trigger:
>      strategy: depend
> +  variables:
> +    LAVA_TESTS_ENABLED: "${LAVA_TESTS_ENABLED}" 
> +    ALL_QEMU_JOBS: "${ALL_QEMU_JOBS}"
>    rules:
>      - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME'
>  
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index ee71ea3..f1980b6 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -20,7 +20,6 @@ variables:
>    no_proxy: "$NO_PROXY"
>    ISAR_IMAGE: demo-image
>    ISAR_DISTRIBUTION: xenomai-demo
> -  LAVA_TESTS_ENABLED: "true"
>    BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>  
>  default:
> @@ -45,6 +44,12 @@ default:
>      - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
>      - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>  
> +.build-qemu:
> +  extends: .build
> +  rules:
> +    - if: '$KERNEL_VERSION == $LATEST_KERNEL_VERSION'
> +    - if: '$ALL_QEMU_JOBS == "true"'
> +
>  .test:
>    extends: .common-config
>    stage: test
> @@ -62,33 +67,39 @@ default:
>    rules:
>      - if: '$LAVA_TESTS_ENABLED == "true"'
>  
> +.test-qemu:
> +  extends: .test
> +  rules:
> +    - if: '$KERNEL_VERSION == $LATEST_KERNEL_VERSION'
> +    - if: '$ALL_QEMU_JOBS == "true"'
> +
>  .build:qemu-amd64:
> -  extends: .build
> +  extends: .build-qemu
>    variables:
>      TARGET: qemu-amd64
>  
>  .lava-test:qemu-amd64:
> -  extends: .test
> +  extends: .test-qemu
>    variables:
>      TARGET: qemu-amd64
>  
>  .build:qemu-armhf:
> -  extends: .build
> +  extends: .build-qemu
>    variables:
>      TARGET: qemu-armhf
>  
>  .lava-test:qemu-armhf:
> -  extends: .test
> +  extends: .test-qemu
>    variables:
>      TARGET: qemu-armhf
>  
>  .build:qemu-arm64:
> -  extends: .build
> +  extends: .build-qemu
>    variables:
>      TARGET: qemu-arm64
>  
>  .lava-test:qemu-arm64:
> -  extends: .test
> +  extends: .test-qemu
>    variables:
>      TARGET: qemu-arm64
>  
> diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
> index 3ee0b7d..781eec8 100644
> --- a/ci/xenomai_3_2_x.yml
> +++ b/ci/xenomai_3_2_x.yml
> @@ -20,3 +20,4 @@ include:
>  variables:
>    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
>    XENOMAI_VERSION: "3.2.x"
> +  LATEST_KERNEL_VERSION: "5.15"
> diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
> index 3e4d513..b611e60 100644
> --- a/ci/xenomai_next.yml
> +++ b/ci/xenomai_next.yml
> @@ -19,3 +19,4 @@ include:
>  variables:
>    XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
>    XENOMAI_VERSION: "next"
> +  LATEST_KERNEL_VERSION: "6.1"
> diff --git a/tests/README.md b/tests/README.md
> index 50942df..c092d54 100644
> --- a/tests/README.md
> +++ b/tests/README.md
> @@ -106,6 +106,10 @@ The following variables are used and set by the ci system:
>    - `ALT_DNS_SERVER`: optional, can be set to something like "8.8.8.8" to use a specific DNS server
>    - `DISTRO_APT_PREMIRRORS`: optional, can be set to something like "deb\.debian\.org cdn-aws.deb.debian.org\n" to use a specific Debian mirror
>  
> +- CI job "filers":
> +  - `ALL_QEMU_JOBS`: Default is false. Set to true to enable all qemu based jobs
> +  - `LAVA_TESTS_ENABLED`: Default is true. Set to false to disable all LAVA jobs
> +
>  - LAVA settings:
>    - `LAVA_MASTER_ACCOUNT`: lava master account name to register lavacli for test execution
>    - `LAVA_MASTER_TOKEN`: token to connect with the lava master

This or patch 2 cause some overfiltering, only noticed now, see e.g.

https://source.denx.de/Xenomai/xenomai-images/-/pipelines/15462

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

