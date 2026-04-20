Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16213B7AE
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663881; cv=fail; b=eSZ72k4AZh4ZxHCXkh0PaaZw+N+OGbdICQ0hbTplocij7Pavsgd1mR+TrKpSlHt9G2A0igs55Dyf1ea3wXfDlJzpbnGrtX7FnrcokZatwPhy2yat6vtOoLyjvj7yq0AxQkq4AjaJEHecgkiKCNeUrXm97Xg4j26tEJpWTbnG4RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663881; c=relaxed/simple;
	bh=rLecue2sN7eqi2E5tYjqBx4pFdKnZ7GSFSOK+ACchOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PYUSxdlvLK3PI5UeqljaUfKjNDaUcayHgvEEz2oYjiCrFImSEzoe4X9fYRzGBSD19YlanpxC4JRkXwOykFaOec1q1mwwayG5B8UOzzGJoF8oSGaEQDmwPW2mzqGOxz3nmelDkYeODKf0EASZ3/lpRHvzsi3ox9Nx9pfXVw+i9Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uXXMk3Ps; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uXXMk3Ps"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aps081nhB7on2RAMaUydulvwh3tT90hG9dgizG9UAw+ECMfu7zx1kvxAJjyZHH20rfoKV0gVrwgq8ugzUYtT1DbR2Lh7S0TtwxURNYHO6nl7QiH/9xM7eMRkszj66Yt8qcz1+SdG8ZEjH7E6v4mbEref//YbBcaihKaokeXp+aNUzGerahOAOYMXl8lOP+c5+AHI7QX4glPtEpX0Gd5YeXZr/L0jZgwgsS0lKVKB68YhE8u7dIlLJzc49oRsGp6yv2FjhGSLqziFyze8f/BZ4saZnKWrIfGQ+MzBR36C2pVJzLHYCcckGHXhdLRiWLTV+ehq+Q7ufjebm0sHnQp9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2UaVnZFdoQINE9wKiVc8/gqLEvwVW6tCgojoXIRrKM=;
 b=rUs5KXzF6N5KHwy0G/RzFvsB0X/8ONNWLktuHS+ibTpcIK4n4CyDayAY7/fNDhbKWaTtlj290Z3fssyoGp8dmFsaBuHoSsA53iwZ229G6qTDNA2fCE++suttY0h7ejTf5hNgA0Kd6/kKlxALWE3q3cxybXsz9eAsjPAYdiLJtOAZD4cMrnlRNAtXYKpXj1GHkeTe7WR5enAMdmIlshddDzTajE4CuFOtrIhI7cNHmccvGihh7j2RojGQnveSxgQER0gSxIfIfMgngl6jJJSa6mM9BDuCOauNTWfJ6be+BX0Yioi9dDVtszau8qC4UxxsQN1TiC2MpnmVgFh/Iw2hBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2UaVnZFdoQINE9wKiVc8/gqLEvwVW6tCgojoXIRrKM=;
 b=uXXMk3PskxtjdVYSWUKzX+dnDo8YyKCSRHoln50B1PfsuTIP0Nmj+Uzmqd+qFMGrm/uQEckP5JDRRfjbbauk/H+jSBY1aD8Ceur1aSca255WQTZcV8dvPJvQrKYLuV20pAdQLP0gp7I1HSmjWAOuFpzZuYWiJsgIbm9/ivPNT2NU9r7wQiDSPafWqr1Jss/hokAVuzxBN8xudC74J4xv9rx2EwvVtf1XLIkyc6tB3ocMj4HDHfUc9kkSgyymsAl+rlB379r7MZGiwVyhDjbm05+mAco7B0MI9niYZV/RKOI7qyPJODeD4uHfLxM6L++GYGdxVvRQXWOHac/aVOQnEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:44:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:44:36 +0000
Message-ID: <8943f471-08a3-41ce-b094-fccdb94a3810@siemens.com>
Date: Mon, 20 Apr 2026 07:44:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC xenomai-images 3/5] ci: Add the starfive visionfive2
 board
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
 <20260417205713.2290350-4-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417205713.2290350-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8ef8be-4c16-4529-fd13-08de9e9fe82d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|18096099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jlqnBNyDSPkCrCaaW1lXYEgeJJewwRmeSf3pKg30wwX0Im9ziGhM6m08dGUIVprXKtFxLK/UuIKVwm/EGDgu/9Jn3vPcoq0rSgVZwoZ2MPdwt8IVFeGim6louGMpxHluWKGa1OQTFfrOpn+F4mbvhvian7v+zLIC2XW7Excxu3p9reJWWajMZsP2IgYuFSzq4w2at323xwaGu5mOzhL+MjJJk3FRoJrigbP8wSJcIIx9zKuszX1j9rsvZbywTgfE/qNR6FNvPnaUEvEMruaarEpBHdJe6JDeln+ODmEzxCvgPk7rYSJMmPWVTlb+V2Uv570zlNgZThSUmqJDRYZmwajMxt5Tmoe1PL8Ifovz31D8SF5xTGkM6W1PgNhKRzfk+6evay3jIkXjBifqooHlkMQyGffNsxsSgg+OenL8AMnTpqNBCJYb2lS+RM3KPKBR18ltBtS2arHphH9ZY/g0U8MtiheTY/ykEv9rQBmuONsEo6stdXX1XFRD8wA29ZVoIF7O0cjRkleNFw4teE6dRsKFSzaM2gqCy2flx2aBzimQ/7d863A2gsEInq7iIRfeoErIY4uz8o+NAhFLiPjXXus5ZlMfDzoMrJgCR0CqIWFmFVouoTOPQXf3tacuNSoyLJ7AHjinH5fgQLF+4RGbWhdYESEN9uKOFSfRKLcqmjDHvlGMeRtK58beZwCGL4lKw5nlD9Br2qVSF8HMJNHFv2I4dVqvBCByAWjVTP9R1PQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(18096099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enkxa0pXRmg2bWF1Rnc1UUtMSXFpLzY2cEl6M0dGeVd4cE9kVnhLVnYvM01W?=
 =?utf-8?B?U2czNXRURk1JdjQ4QXBHUDh2Z1U2eWRIQm9McWhLcnhpblg2NmplMkZib2ky?=
 =?utf-8?B?WlNEQ0dJU2tobmJpaFVPZlVFaTBUMk5hUU1hUXJteTRWN0NxcC9MclJnSGhO?=
 =?utf-8?B?NXpYeHRabHJDZ2laQXhuL3hJSmRSYUNuV3Q4ZldkbWRvcEtGSkIwWFJXd0dE?=
 =?utf-8?B?bEJ1ZUM1YzFPdTdWaDVXNkxFUS9QSW9ITEcxczd5SGo0V3NtbFlWdkJrYkhO?=
 =?utf-8?B?cTlydS82KzdiSkR4K1RQSTVmeTFXcWp4NjlmQ29XcitVckdWYjNjblczSHls?=
 =?utf-8?B?SEZmVGVLaHBhUWYxUVRJQW90eEJLTTBUVVBNdjB4RnFPUU0veHI1MVpNdEg1?=
 =?utf-8?B?K0pJVGptcm1mSitLN2piSVhxSFBFbVByRU5oalZBZ1hac3F2VjcrbGNpemow?=
 =?utf-8?B?WSswVE5Xb1FGTWx0dmVPOXBMb1JZUjRWSG5JcEZNOWJUU1JsSU5LV2tueFU1?=
 =?utf-8?B?WVpvVE1vWDZJWWRlL0h4QVJncm9YMjlxeXpZYlByT1BBeG55R2Vsa2tBdExu?=
 =?utf-8?B?M1planArbzlqenkxNkp2aXRXaHJ4Q3JkREN0NVUzeDNHK2YrTUUzWENkWElG?=
 =?utf-8?B?MUMwSjZpQXQ5UFBSdGZPaSttUlpNMkRGSTBUZm8yaEp5aHV5NG1EN2xxYmZN?=
 =?utf-8?B?cW5FUGVZNVVIR2pSaTM3YVZPblIyMlBKRi9wL0h0N01MaTNMRkhNSkdKdkl1?=
 =?utf-8?B?RVl2enN5R3dsRUNzVXJ6M1lHSmtFNFQrelhVbFQxQml0VnFvS3lqV0tlQU1U?=
 =?utf-8?B?VzZTdms5MnZONUVXYU5obGI2VzVjVU1FV2xORCtQZkRhcHlaSnZBaHpZUnBj?=
 =?utf-8?B?T2pwTk1TaWFOcktxeW81WktZanpVaFdzNktsdlcyZk5nSFBvaDlHVnJRL1l1?=
 =?utf-8?B?aW9pSnlmeEpNdjFyYmZRSHpES3ZZcDBZTkdDdUY4ZHNrclluV21QYlI5dUJE?=
 =?utf-8?B?UVZQSU14Rnhia1ZyL1p0OEZ5a1dnVUxIK0ZOOW9EZXFta3RDSHFNTjhwd0dH?=
 =?utf-8?B?Vy9HWmw1NWRWTHZ1TWViWm9yZXJLWHg5TWZwT2dob2ViT1N6THBERCthMjZZ?=
 =?utf-8?B?T2lPZ2dOdjZuTzdqdzZyT1ZtV2RvQy9DSC9QMFg4WnRpdk1nZVVPeHJrWFVP?=
 =?utf-8?B?YmttSkthRldYM1U0UlRxRndDZ2xKd0hPOGdzNEVHWXVHd0RlaUlmbFQrU3dX?=
 =?utf-8?B?ZGNUbmwxdEF3STlXMnhXWUp2Q2w2VjdOdVpGUWw0bjFXOUJ2TjVobWIzczdq?=
 =?utf-8?B?d0IvUkVpczl1YlgzZGJ1dGQ0R3ZVUWRINmJWVFRvYkxZZ0NnSnFGb1hla3hh?=
 =?utf-8?B?YkhkbTZpejNDelhuSmRDSVdCUW9BRG9Mdk1PWlRNaGVoNkVTZlIxdTZBWnRT?=
 =?utf-8?B?RnBnQ3IrWTNMbHZrUVRnWUpGMmtpYkszSHV6SUZPa3E4TG5mb0V5djZBbGor?=
 =?utf-8?B?RlNNYjdqQUpoS1hMYzJVRUFCRldlb1JvS1YxWVhlSkxNOVFmUDFrNytTOERT?=
 =?utf-8?B?bGFtWTBvQ3gzZWxnaDgrWHYzSkZXczMwanpMaVRJT3ZRdkx6dndxWXRNdTZ4?=
 =?utf-8?B?Z1djZXdjQUlaSUoxdVRmaDNMN01ZRHJyMld3TjN4MWpiWEJYSVd6cHNDZElL?=
 =?utf-8?B?RFJrSnhOYUVFRVF3cmM5YmxSd1NlOFpDajhqRXVEZFNORzV2Q0VkMnBEODYy?=
 =?utf-8?B?OWd1eWVxWENjTTJlQUxtVXBMQWx1d25yejhwQWlYWjlEcDRIdmV2c2hSN1po?=
 =?utf-8?B?MEtnaE13ekM3UWJLWmYvUWhRcUtWclAyVzBybGRRREp4U2JOampxOHNzeWNG?=
 =?utf-8?B?cGk1MUgxTkwyRTkzL21FVnZDZHNWSmZzcnJHNHAvUDVsc0NQdmFNZmo2bEVB?=
 =?utf-8?B?L3NJVmdrSVlTMVRuOHE2d2JOaFFrNERKY3RJQ0VXWjJ2aEVWbEpnakk1eTZJ?=
 =?utf-8?B?TXlxbXBaU1g2Ri9oNXNyeVFyb2pKNlE1YnJ6L1pEeTI4ZnRUZEJaK1prUmpl?=
 =?utf-8?B?QU1icG9wQnllRmFrdFNrS0VIYlpONkFZWW82VGdFa0tLUHhmMDFFSUpDZTM1?=
 =?utf-8?B?V0xMNFMwOG43K1YvQ3pwQnFxZnl4ZjJoQWRVK0pqMWVoQVREeVVvOTVLNzZ6?=
 =?utf-8?B?WkdnNGdXVGphajc5MHVKY0E5VEpQNTcxSnNpT3lrNmlveWR2Q082ZmVzaDlZ?=
 =?utf-8?B?VjViem9pWUZVZEZDVllNZUZBbG04QTBVaUhYZ0IxbkFqcEd2V0dNUGtUa0F5?=
 =?utf-8?B?M0hEd1VXcXlKb2V0UEdGRTFPRGZWTTE5dXNNRE9jREpPb2VudXFLdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8ef8be-4c16-4529-fd13-08de9e9fe82d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:44:36.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYAYRXGeyRbIPxXeWPuasFaoifJF2bJqEYhpPGyoJH5dy6UrwG6UfB+TKBXvFN2xooPsL3CSBcv0SoJvuGducg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7125

On 17.04.26 22:57, Tobias Schaffner wrote:
> Add everything needed to run the evl tests on the starfive visionfive2
> board in the xenomai-images lava lab.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/lib/gitlab-ci-base.yml                   | 21 +++++++
>  ci/lib/kernel/head.yml                      | 13 ++++
>  conf/machine/visionfive2.conf               | 18 ++++++
>  kas.yaml                                    |  1 +
>  kas/board/starfive-visionfive2.yaml         | 15 +++++
>  tests/jobs/xenomai-starfive-visionfive2.yml | 69 +++++++++++++++++++++
>  6 files changed, 137 insertions(+)
>  create mode 100644 conf/machine/visionfive2.conf
>  create mode 100644 kas/board/starfive-visionfive2.yaml
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
> diff --git a/conf/machine/visionfive2.conf b/conf/machine/visionfive2.conf
> new file mode 100644
> index 0000000..ff42ecc
> --- /dev/null
> +++ b/conf/machine/visionfive2.conf
> @@ -0,0 +1,18 @@
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
> +
> +require conf/machine/starfive-visionfive2.conf
> +
> +MACHINE = "starfive-visionfive2"
> +
> +DTB_FILES = "\
> +	starfive/jh7110-starfive-visionfive-2-v1.2a.dtb \
> +	starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
> diff --git a/kas.yaml b/kas.yaml
> index f856ae1..875132b 100644
> --- a/kas.yaml
> +++ b/kas.yaml
> @@ -25,6 +25,7 @@ repos:
>      commit: 9792d18e9334b3cec72e2ade6a1065084c0c24d6
>      layers:
>        meta:
> +      meta-isar:

As already expressed privately: I dislike being dependent on the
exemplary BSPs that are (not) maintained in Isar upstream. Plus, that
brings in conflicts (hikey.conf). Better build up a fresher version of
the BSP based on U-Boot 2025.07 (due to SD-card discontinuation) but
without legacy jh7110-u-boot-spl-tool. I shared that code base.

Maybe split your patch then as it will definitely become a bit larger.
Step 1 is the board addition, step 2 the tests and CI hook-up.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
