Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE91C04
	for <xenomai@lists.linux.dev>; Thu, 23 Mar 2023 05:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9R4fnw00NNH+xwaD6ea74i0cyYTIj6kpyV2gOpQlxYcf3Z0Swn7xUV9N3V9JDDFvuzjpHA7PVcAiKgNl3+v2HgrejtDHuPWCeQZSY1qh+rm5ldtsu+jncsP2IobS8zY8L3DFiqVw9bjnrK3lSRkfFT7zA61Q/qVq0eqVRK4Pnxnmh/ACJSJ2AVFhE96o5yE/P8d4rBJUdfzlW51x8j74TwrwQG9mC5TmBfuPiW3Zo+qkowci/3cKrY90Fg0Ozzan0TIApeHON8h5O2aG+9OF8gxCBUIfjb7xHNYv2ufnn8S4tizpOESufZxb4as4cbARleTEa9ipHBJQldEcv/PmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8bg7P4tuBJlBioILeK9/eB13ukiSdaWAh1dAHuML8A=;
 b=n6yyLDi9KBA08FuwZF0qytCaU3wj9HSGOob9U40go14GFXiNp9P8pWIH6/HtB0sTsM7/1HDS2a2G0byLxp4PI/ORvKUj2v3REEhgF3RCzVknSOuCTnFVGo6quaNcs873327yYkBfOQpWd+hjHeHw7iYlIK0Vgard6v3WlLKSn0EGTVUC4I9Dq0yvGxv1ZXWNANMvkSCwqJDWC54dmzMEycSv66DLO49N8hY9Th6OKRdpwIhVU2yKQg+sc6E4WyJd5tJCgZUVJItGWU8GF8zXWH/DN+jqslsZboQess1YozDvGgmFr0q8Wm6ohg2cywGhthiQYdYiEaep43aVna+huQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8bg7P4tuBJlBioILeK9/eB13ukiSdaWAh1dAHuML8A=;
 b=yaOruu/5f07o0pQspwq/DUdXXTyzojReF5kq/dXWnjXkRUcEWFxgwT15fGVwOPvS7STbku6cO6i8dYPGBTkrJgz0987Ewskksurcy0L0ey8R2buKOmK6SOXS+opD/wGBfHQmBCrRjEutuQYnJ2yrH6RHFnhnG5ypoNCnHWZ35JN6VZ20O/C2MHrcHXwy6zAn/SrMC3jnMGvbsRgp5FxHs6zK1nLjSkndur/+0KpshLmt7OH2CikKEg/4FG2ITX4ic0EmXvTk5zO+FtpQj+uNjUPvRyebPSSMdItXDXLfJxjwj4lPuYs6Bjb1uz+S/MZaFoHhBsr7usjvtIQEVUjo4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Thu, 23 Mar
 2023 05:10:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Thu, 23 Mar 2023
 05:10:55 +0000
Message-ID: <54225f22-9f9a-1ab4-8777-9b4c74dc4bb6@siemens.com>
Date: Thu, 23 Mar 2023 06:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [xenomai-images][PATCH v2 1/2] ci: Run qemu jobs only for the
 latest supported kernel version
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230322235936.1300665-1-florian.bezdeka@siemens.com>
 <20230322235936.1300665-3-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230322235936.1300665-3-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3789:EE_
X-MS-Office365-Filtering-Correlation-Id: 3478fcc3-f6e4-49c2-5102-08db2b5cfb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9n4R6gR9BgfhDNHfYhzO1OivzTEr+q4UXCEpAy+QoCR3+WPiAQGB8yZZNBhuYFvS7HyS8fwlK/CD7YFhfHkE4Tlj5psjL9Na/7wMR/y8XngCUoihMxkK0d7NN/N2qGFRdyziurhQk/ZIxZdJjZyl4v4NpTEdmErOPnQXajyrzWqR/aEKCksZpDJpCyxhARCcXJzBaJ47CK0C1Bgofsg4DdECER74Pym2bC1+W6lWz/M6aj/dWfD4v7eEy2So2thxVChLNg3N4wjJXcrEFRYwkn+ygF1BBnjp06Ooh4HxX7AB7gwYMzJhAhDqTh6rO9OJMPx7+aqvFpLRrVmyRWAhseCOcntd0wtZ4SkTwsO3p7yoZSndqHymmPrEOpXJlmZRM52TIY8YSTrJMTYmNxvLusl3qSzD+0kDdNKH9o8vHFXYcaYhL+hOJXiDIOfLPx2bE5j3SeOr3Rrb/RFFaQUgKFDTNO2r9BGLZSAwhYyrn/11pfMDKfEV4MIivCHhTj9I8n4NaRJUC483BHuYbnBASqnSdBaDeUSQ/6r6vtcXW9w6we9uet66qLsga2hXwFwv6CiT9iCTTH6HEU/RA2PfEnLs/JwYygQx1K/8RlRve5yXLchdCnSHHrPH14YoO1z1zqFeB66WKy4sl5bkKgEmSRMSjx9agr0Oqv6EuO8g2Zdd3MJa0kthh3U4XGVhwuNu1g+YGTJ0Y2YDcfkgFx4HQK6TtyyTF5IZbdS2Ls8AkY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199018)(66946007)(316002)(478600001)(44832011)(5660300002)(2906002)(41300700001)(8676002)(66556008)(36756003)(66476007)(8936002)(6506007)(53546011)(82960400001)(6666004)(186003)(38100700002)(26005)(2616005)(6512007)(83380400001)(6486002)(86362001)(966005)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTg0L1lTMHFNT3JyTnJ0YXBKSG5yR3FSS2pqbWkrV0p2SHJPaGJEeXhNMFUz?=
 =?utf-8?B?NENvV3lnRUIxdkJ6UDRoMzdtTldCWlRsTktrSHBPN3paT2YwMWZlSnVCWFR4?=
 =?utf-8?B?SXlUZk5COWJobjVReEg0ZEJsbm9GTm1MajdNVTI0aThsNXB2aVgxdDRuUndS?=
 =?utf-8?B?dzQwc1RSTStEbVI1akVLVUZhVUJYUStXcEIraVBua0luUlplK3dYbjdkSCta?=
 =?utf-8?B?Qkt0QjUxVWJoTTFnZ2JSY09nNnFjTkYzbzVUMHE4cW9FU2VyN0d5TkRFTlRF?=
 =?utf-8?B?aEVzZEFZOHV0b2ZmMWhNOHRvT0U3akZXUDhhV0ExTXZmTUk5NnB1YVgyZnhB?=
 =?utf-8?B?MitxT2p0eXNva1dVRDdpSWRQb2QrdnovY1FIbjh2ellkdE1oT3lYeDgyQnow?=
 =?utf-8?B?NjJvVDhBaVhleUFzL0twblo4SmZ6TUN4emdRVWZUVTFXWFhFNVFXcjhrNVJQ?=
 =?utf-8?B?QmNjQlQ4Ui9TMWtvT3VoTm1ySWk2ZkhLOHRDVC9ZNUpJYU9wOFJ6K29xcjFJ?=
 =?utf-8?B?NFdEVllPL0loMkRkWVIxQmJVcHhLOFNCLzM5eWg3TVZEUTNLUUg5YUtqemVl?=
 =?utf-8?B?d0h1K3dzbWlLWC9hNmtWLzFVUCtVU2k3NnBGdjBDUzFxMHBtckRLQ0ZKQW1U?=
 =?utf-8?B?Q3hwTGdKNitsMHpBZUFuTnQ1L3BvU1g3OHlGS2dDUWxVUVVXa0RzZk5ZT2ZB?=
 =?utf-8?B?eHhhbSt1QVRnQTFDc1FKbGF6OXh3VUpSLzJ2UWxzZCs4b1VSQlpHMitsZXpp?=
 =?utf-8?B?NTluRzVibjY4TUJ4RjZYRERLQjA4K0ZpdmNXcFRIMzZsbGZvMmJOT3JZT2Zs?=
 =?utf-8?B?SHM0MWJlT2wreFI5cUIreXN5SUI4c2YzSVlmdUU1b1NqbUVZTmtVZ1g3RUZH?=
 =?utf-8?B?L2FicCtua1VvSk9KcnQ1a2QxaVNIY3RjM2xpNzhlSkpWdlh3V2dtSWt2QlVY?=
 =?utf-8?B?Y3ZBYXg4ZlBDSXlGWEtCazRjMnk2RXQydU1sc2Ewa3lMQTN0N1FadU4yNHhI?=
 =?utf-8?B?bENwTGVZRDAySXhacHNUdm81ems3Nm1sejNVZGw1dHlGME1GRGJDRlUydEhz?=
 =?utf-8?B?cTU5UzQ0UHpmbzMwWXF4anJMSlNlbW1vZkR2WFZTc3RrdDA3bGhYQjlXL1pr?=
 =?utf-8?B?R3NEaW1paXFlNkl3dkwzTW1FZTlxR1ZOSGdGbzdzd2pKWGtIVnh0c0lNNXJ1?=
 =?utf-8?B?aVNqa1ZpZkNKeVB3L1U3eUhUMDFTdElmWmNyRTAxdElZclV5SHZqVTk5Q09m?=
 =?utf-8?B?aElKOVVpb2ZTYVhrN2x3OC9BbFhFMnAvRTV1VVJoTWd5U1lOU1NNTUZLT3NU?=
 =?utf-8?B?RVhvVnphY3RIa0FCQnhDWDNXSDdMVDBaY084Yk9oN1Q2UStRaVl1d3ZkQ29z?=
 =?utf-8?B?dG5xWTBwYWk5OHNoajc5UG12UC92Qzl3UjV5Vzl5dncwWXozM3RtVElYVWlY?=
 =?utf-8?B?cGl5MmRITEtUYklGbitKeFpmSHVod0lYMEFLK0xYLzA4a21xMFluSVVXMGM1?=
 =?utf-8?B?Vm5oUHpGM1cxVVZocEFuZGVKQzBtNjNzbTRQbW5vcDBDcHM3d0s5M0JWRGlv?=
 =?utf-8?B?WW1FTTZVRktNLzNPcXlJN0kvVmdDcWxSVHF6VDBoMmpTT3ZZS2I1UTVNTlZy?=
 =?utf-8?B?Q0Q1YzY4anhrdUZLNDVMNzBKNHI1c0M2S01kclRZWVMvVFhrZURXeEUxZEk0?=
 =?utf-8?B?YWZ4MTBYOVFnOFc5QVkydUZFZXYwNW1ZaEZqaTg1L1dpOGtjdTZjcEN4eEZW?=
 =?utf-8?B?U0xieEFBRnpyT2FyOTE0MTkxaExkVUFlUVA5dkpkbFUrS1RqVUZnd2Nyc0tt?=
 =?utf-8?B?RmZlK2d5czNmZ2JUeVl4cyt6Q29LbTRCNzV3RlExQU5GQndnTE1CZk8wWkY0?=
 =?utf-8?B?eXQ1OEhKSGs3Y1gwakpmRUNIUkw4N3MwUUk5RGw2anVzb1BrRmozRDlIaXQ0?=
 =?utf-8?B?bXpwZ0dFRUlTU0FkcGgrK1ExLzdrSUpabGNWT3JFdEMzOVJ4dENDTGpwUFVt?=
 =?utf-8?B?MjdiOTJmSENZYWVlRVpZOFVjUlZiQzI3M1Z6WDJYeHFIcHlWdERNY3JpWlMz?=
 =?utf-8?B?ZjI2RjNIYkNRNDJxY0JJYkUyZnl3TEJLcjZHU3ZGYXlxKzFzd1l5UVVubTI0?=
 =?utf-8?B?WXk3dFMxWkV5UFNPSUp2eElWTWFsbENid2NDM0RhK2VMVTVWRUVhVWlzUDY1?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3478fcc3-f6e4-49c2-5102-08db2b5cfb43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 05:10:55.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+kyTyNlZMPI8DeCuWtwVQ4uafWhsScl6oITTrm/zkXPvXivTfaDqhlyAJj8r6yxwrTFxMjYvj9J0xxBR4DJLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3789

On 23.03.23 00:59, Florian Bezdeka wrote:
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
> 
> v2:
>   - Fixed (GUI) variable forwarding from parent to child pipelines
>     Side effect was missing test jobs.
>   - Disable all LAVA tests when LAVA_TESTS_ENABLED is set to != true (GUI)
> 
>  .gitlab-ci.yml        |  6 ++++++
>  ci/gitlab-ci-base.yml | 27 ++++++++++++++++++++-------
>  ci/xenomai_3_2_x.yml  |  1 +
>  ci/xenomai_next.yml   |  1 +
>  tests/README.md       |  4 ++++
>  5 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 58398fc..6e4f1df 100644
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
> @@ -16,6 +20,8 @@ stages:
>    stage: parent
>    trigger:
>      strategy: depend
> +    forward:
> +      pipeline_variables: true
>    rules:
>      - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME'
>  
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index ee71ea3..b7dd4dc 100644
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
> @@ -62,33 +67,41 @@ default:
>    rules:
>      - if: '$LAVA_TESTS_ENABLED == "true"'
>  
> +.test-qemu:
> +  extends: .test
> +  rules:
> +    - if: '$LAVA_TESTS_ENABLED != "true"'
> +      when: never
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

Thanks, both taken to next. Looks better now:
https://source.denx.de/Xenomai/xenomai-images/-/pipelines/15707

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

