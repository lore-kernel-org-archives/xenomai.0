Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAC49F67
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hjg9u82l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiYko9Uu0MQMqJamzsbDFZpl4SmWT1ObBDLs0GrBRSuvPOlUv711r+gBBDBhVuadK/0blm0NHqIkMJWTA+YRXqwV/D0IvUCwPLEnbmJmXJo5vuYnLEOtXl2aSq7rltQ55oIen3AP6a996sST5KsMFd2tofAoOBLmTRMDEIWogze+EZLm4x0Qq8Vfe3y8XYP0MrRoltSJgqVBVB0REfLiFNost/XFI0EW/1dPp4grWcpMmyYk0IhXIk+p42U1ozOmKQxz2cQG3dhGZZZAN4Z1ZWp3VMdHp4UsTy/H4JLb8Pf76YrhdW3HL4aSR5Z0QE/BKrLANvpvS08FoD13JaVUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJZn6ZNpU/JbCaExfLVI73J0J1lOLQxhIwfFuT++UG4=;
 b=B/TJZiAkCMmck0uG9d7blxqqsEDbY04ZqUuj9mQWt4kEX8eIlZID70G0m4nHE/x/xlB823G+Ko441CZQGO3YOoqxp12atWh/CjcC60z7k/Ixn+lCz6BKcMaeeDK+wyLEViwvO+wFWhQTJB6XWGDgvV3T77ucELGomIaYB3JywaWIAg8UDrEdshbj2yhSWeiJXwJqj9wV8FDQpgFaaIpc+yo9fpceVmeEPEJW1kk6y0L+6g0yRY2PIAUe7PljSElUM7MRKzRRy+8qi5oI6kERCWeW5jeBKb7QhX8eYFBM5ulW+hS/2i31bYnDpYwq1Iy1LeNP/QHNqBVyIKhOU4X/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJZn6ZNpU/JbCaExfLVI73J0J1lOLQxhIwfFuT++UG4=;
 b=hjg9u82lojBSJcNXdEB3iondn+KMGt84+hY/UbRnVJxYkSR06umUy5WP9B4hyO47M5H3twqCfYg/3MUa5Ame+U/Hn3A5T4Dxr1n2kFtmmLyowahckK2SxmvYhwr7t0aQiXkTeqFejdtVU93G+Q4rxQ7pdSzat3qWRyOqeQFk1xwM929uccsVaiRoOalkJT2OlkPVsdBYwT20WiuD395p8xVFDSqZvbPnXJSOvwSRidRRdZgi3L91k0pPWzYGAidoXdczTWglgO8t8F/cifcH4jL0Jbg+6fxTzJCadkpTmImkpWMODgi73FtFN5dGeTG+pl8Jzzq2sZtR/jx18yRcvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Fri, 15 Dec
 2023 17:28:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:28:19 +0000
Message-ID: <bb31a9a8-3eba-4d19-bb23-d558de470dbb@siemens.com>
Date: Fri, 15 Dec 2023 18:28:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v1 1/5] linux-xenomai: Factor out base.inc
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
 <20231215114349.2913803-2-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231215114349.2913803-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4740bc2b-89f8-41ae-3b2c-08dbfd933aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OTJlvdnMr3dhOsfT+JMI1yVNQdQ3hEEtOlOKOTT5ZOP9W6SvJqdT0/bCIJhmTMg7iQKrD0LoDdpgfZ2a3mOmOttw6VCwzkKB/DQsjyVspqNrx2XPDEm/Q/TgzYhMzXKS6z2yuIKtueyqqZIJCWbuKBQrGNdBVjR6jaibTEZg+LLtngg6tpcUYk2po6tz5gQgvQ2ZgrXRYUpr0grpOScFUBpEYaHrIqZ+P3WABDTNoXg2e42iX/iXWT7rR2qW6Jmu0GSFCCIgyAmHyDgJwbBxbc/iNcjX0K+KeQ9UOA3SUD7vPsBv9ibnXE5T+aFtApVYDc5hktK/t9uHrZpbS9s1M4fhd5k+5iyATLmXw1hKKtizKsmbwwkX6C4VDhMGSv6aPimZlzBzjGD0Vpx+1QsGYqp3GhYAF+tDd6H6ANRQzA2s5j01XcjVTDlVgM7DslMh8oeQ/siDgk887Oz0DqyWG+vOVkivguqaG3RMW0ZK77a/GhIVj7z5SBLSgKxJ4ak34CcF6B9KM4OP9fCDst+disJDjvwsefbCAObftVoIyJdUkxW3zY4sdyP+Bbe648vAF0DIxCY+bHh0lMKxlXhkaQuJewLs5WE67vPG40cBLI5GvouaKz2dacSgrqdIddRHr5rSccv4WF7mgYlKKq/azg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(316002)(2616005)(6506007)(6512007)(53546011)(5660300002)(44832011)(2906002)(83380400001)(41300700001)(478600001)(6486002)(8676002)(8936002)(66946007)(66556008)(66476007)(82960400001)(86362001)(36756003)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d05FNmVOdXpCM2Y1L1ZOdk9XMzFqaHNBbmQzZWVTdzJxVjBOV2xvcC9CZUtm?=
 =?utf-8?B?dEhRRzg5bWhSa1hhTFYzaGVnQzdRNlVPOGhJSjdUdGx6bENLSUxBcUxrS1Jl?=
 =?utf-8?B?Y1V1Ulc2cC9CZ3lOZHZqaFJ2OUpmQkpNd3c3cjVmcHJaNURUZFZpYmdHdGhT?=
 =?utf-8?B?dm93ZDVhZUkrUEwxcEMydm5DaXc4ZU14cmFIMU1Ub0ZRdU1CVjBhWFlSMlRu?=
 =?utf-8?B?eDdmNDE4M0tjcU0wT1h5NklXQW1Zd3UyNEFjQW1LN3RHT3phNWJ2Ti9MdUox?=
 =?utf-8?B?WUdWRUt6WGIvbXl4aFlIZ3lFei9wdnBLcTBIQ2E5dnNpbFdnT2xManpVRVpF?=
 =?utf-8?B?aXhRSjBzOVlUR1RmdVBIL2tGUk5tSkllY0lHdCtlUktqYkZ6WHgrM3huS1Jq?=
 =?utf-8?B?czFHUXBBRGJrcTVsc3dYVDY1UkUxZ3prQWM2b2xFSE9HSnhTcDNtZ3B0bUM1?=
 =?utf-8?B?SWFhekFyeVFQOUhvZFkySmdPaE40d254MzkzZkdRT00xNkswS2Y4YSs1RnZK?=
 =?utf-8?B?dXJQUFRIUTFVcXJxazkyRHNFbXJURzhsWnJoYlR6TmFrZ2xhZmRIVmNSTHJa?=
 =?utf-8?B?ZWNDa2VPdjRDVEducWE3bDJKaE9PTWtrSnpXb1FJWm1rWEoxcDQwc2l1aDlZ?=
 =?utf-8?B?djgzMnRmRmxUUnpTcjNyWDh2cC9HUjdKelQ0OFFwd00zL3Qvb243RjlyaEZh?=
 =?utf-8?B?elNwY09sT3U2QktFZlJyVGcweW5UbUhWeUR3dFEyKzRmaE42VGcvZTRnSDNs?=
 =?utf-8?B?SjBrR25jbTlVNnFsL1ZJaUFIQTZQYXVzajZsQlpwQXpTY2ZwUHRMWDVCSkN6?=
 =?utf-8?B?VkZTRzJLMk9QNCtick9zQXRvVXZqNUJBbDBtN3Zjd29MT0xTQjF5RGZLcHB5?=
 =?utf-8?B?SkM3WHZHRlZmRG9yQzJHc3c3SEdOOXN4Zk4zcW1VKzVvRk4zSVRydkZ1V0Fz?=
 =?utf-8?B?VVVCdVQ4YWJWRkdnZXlibHRGcjRMQmFaS3RYOGVZU0pOWlhucy9YSUg2eHI0?=
 =?utf-8?B?dElRNFZ3cmgwakhwTUdaWXNDS0h2MG5pZ1hjcHpQR1lMQnlHNzZaMnYxSVZI?=
 =?utf-8?B?NEw2WVpyTUMxSDYyTUg0NmhFLyt5NnNmczI0aStxcDhObXRtREltYWxwYlJE?=
 =?utf-8?B?cm1IOWlRa09VSU1mVlAvRjdnMnVTWlduVUpPb3hkVG1tUDRzYnJNNWJkbGVF?=
 =?utf-8?B?cjNLSmQ5WXZGWUJRT0xtYVQzR3ViaytxMWVuSk9DQTg3dTRxOTNVRzQxYkNt?=
 =?utf-8?B?VnVCaGltYTRqcXI3MTd2NkkrS1hmTjBGTys3cDJaeXUwUElaM0tqODFnT3FN?=
 =?utf-8?B?VWpVbit6d0JtNlREalZKY0VRN3I4Q1h3WEQydExrQWdWOUcxS2V2STlqMTEx?=
 =?utf-8?B?WnQ2cktpTG5hdHVwN09TZnlxc1V0QjVLb05jdzVITW1LZVZJYm81WFhlRGU2?=
 =?utf-8?B?MFRGUG0wamwxenZxbHgzVG5Qbk8rSkM0UC9FYWhZdDlBcXNBUzZLZ3UwMFNn?=
 =?utf-8?B?cnJOWDdScWx4OVl4YlhxRGVsNlhxYktrakIyMHRTRGlicTgrTkI2Uzc3a0Za?=
 =?utf-8?B?ZzFrYTNMYlc4cGJ5L1dMbTZZRk1wY2ZKdUV6bWpBd2pYazJQSUU1MjBkbXhZ?=
 =?utf-8?B?eHMzMXNBeTI1STJ4eUhKakg2ZzJsUDhSM1JWUCtPM2Z3VnlITXJOSlBJK3Ri?=
 =?utf-8?B?YzBuSDA1bWsyV3lmVlZ3b3VuelNtMGpKODhMbXltTFhnTlNjRE5vaElIUzV6?=
 =?utf-8?B?cnpnU2pTVnBpUUV3RkYzZ2JJajlrTnFEODBMWjNLdFdzejhwL1Rxekk2QnlJ?=
 =?utf-8?B?L0NJRkQ3UDRwQ0h3cFB1K0VKK3A3TW1EVW5tQlU0NzcxQkRjbHR3TFdWQVBH?=
 =?utf-8?B?eW5ZTFhUM3YrZzl5eTIxaEFnNmEvSGFWNDNMdUdKMkNlSHJ3aUJTWVJKR2xa?=
 =?utf-8?B?QXcxYTEzaDRUV2JDVHl0d1JMMG0xRnZRNlRySHdNNW5kSzZwOVk5SGg0aFlB?=
 =?utf-8?B?M0hHL2Q1UDhMRnNhT3dMNVl6b1FBdFF6RyttcTk2SUdRbElJK1ZSM2FtV0JI?=
 =?utf-8?B?Zmw2VVBLN0dGMW9rZ0JQdFJYNnViY2RaSEZyanN0dU5EcWZNWG1rbGl2bEl1?=
 =?utf-8?B?cGYvNXdyamhQZ3hvMlNLclBGdjM4NTBOOG1nTVIxM2VzSE9BWDZTbXI1cDJx?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4740bc2b-89f8-41ae-3b2c-08dbfd933aec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:28:19.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJQdyaRBjdx6m51JU5BSINScsh0OossQ3PHl5uJ/zUve5WyqdX4kONDKxPDzrf0HbDORE8oCpgzuX/TAToZy3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8088

On 15.12.23 12:43, Clara Kowalsky wrote:
> In preparation for the integration of EVL, common lines are placed in a
> separate file.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  recipes-core/images/base.inc           | 20 ++++++++++++++++++
>  recipes-core/images/demo-image.bb      | 10 ++-------
>  recipes-kernel/linux/base.inc          | 28 ++++++++++++++++++++++++++
>  recipes-kernel/linux/linux-xenomai.inc | 16 +--------------
>  4 files changed, 51 insertions(+), 23 deletions(-)
>  create mode 100644 recipes-core/images/base.inc
>  create mode 100644 recipes-kernel/linux/base.inc
> 
> diff --git a/recipes-core/images/base.inc b/recipes-core/images/base.inc
> new file mode 100644
> index 0000000..13bab7b
> --- /dev/null
> +++ b/recipes-core/images/base.inc
> @@ -0,0 +1,20 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2018
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +ISAR_RELEASE_CMD = "git -C ${LAYERDIR_xenomai} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
> +
> +IMAGE_PREINSTALL += " \
> +    bash-completion less vim nano man \
> +    ifupdown isc-dhcp-client net-tools iputils-ping ssh \
> +    iw wireless-tools wpasupplicant dbus \
> +    lsb-release"
> +
> +IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
> diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
> index 540583b..4344122 100644
> --- a/recipes-core/images/demo-image.bb
> +++ b/recipes-core/images/demo-image.bb
> @@ -11,7 +11,8 @@
>  
>  inherit image
>  
> -ISAR_RELEASE_CMD = "git -C ${LAYERDIR_xenomai} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
> +require base.inc
> +
>  DESCRIPTION = "Xenomai demo and test image"
>  
>  # The Xenomai testsuite was part of the xenomai-runtime package until 3.2.x.
> @@ -35,13 +36,6 @@ def get_testsuite_package_names(d):
>  # arch missmatch for compat builds on newer releases.
>  IMAGE_PREINSTALL += "${@ 'gdb' if not has_testsuite_package(d) else '' }"
>  
> -IMAGE_PREINSTALL += " \
> -    bash-completion less vim nano man \
> -    ifupdown isc-dhcp-client net-tools iputils-ping ssh \
> -    iw wireless-tools wpasupplicant dbus \
> -    lsb-release"
> -
>  IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym"
>  IMAGE_INSTALL += "${@get_testsuite_package_names(d)}"
>  IMAGE_INSTALL += "libxenomai1-dbgsym"

I would rather prefer to have

IMAGE_INSTALL:append:xenomai3 = " ..."
IMAGE_INSTALL:append:xenomai4 = " ..."

and, thus, a just one demo-image.bb. Those overrides could be set when
selecting the major Xenomai version.

> -IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
> diff --git a/recipes-kernel/linux/base.inc b/recipes-kernel/linux/base.inc
> new file mode 100644
> index 0000000..c6aad9c
> --- /dev/null
> +++ b/recipes-kernel/linux/base.inc
> @@ -0,0 +1,28 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2018-2023
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-kernel/linux/linux-custom.inc
> +
> +FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
> +
> +KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
> +
> +SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
> +
> +S = "${WORKDIR}/git"
> +
> +def get_commit(d):
> +    try:
> +        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> +    except bb.fetch2.FetchError:
> +        return ""
> +
> +LINUX_COMMIT ?= "${@get_commit(d)}"
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index ca63fea..df24c49 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc

This just likely be renamed to linux-xenomai-3.inc now. That "-3" would
also make sense then in the individual version recipe names
("linux-xenomai-3_6.1.bb" etc.), while the EVL kernel could be called
linux-xenomai-4_6.1 etc.

And that would allow to call base.inc linux-xenomai.inc instead - less
generic name.

> @@ -9,33 +9,19 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -require recipes-kernel/linux/linux-custom.inc
> -
> -FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
> +require recipes-kernel/linux/base.inc
>  
>  XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
> -KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
>  XENOMAI_DEBUG ?= "0"
>  
> -SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>  SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
>  SRC_URI += "file://rules.tmpl"
>  
> -S = "${WORKDIR}/git"
> -
>  DEPENDS += "xenomai-kernel-source"
>  KBUILD_DEPENDS += "xenomai-kernel-source:native"
>  
>  TEMPLATE_FILES += "rules.tmpl"
>  
> -def get_commit(d):
> -    try:
> -        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> -    except bb.fetch2.FetchError:
> -        return ""
> -
> -LINUX_COMMIT ?= "${@get_commit(d)}"
> -
>  dpkg_runbuild:prepend() {
>      bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
>                       ${PV} ${LINUX_COMMIT})

Jan

-- 
Siemens AG, Technology
Linux Expert Center

