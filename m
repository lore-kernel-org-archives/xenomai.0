Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DBD7F
	for <xenomai@lists.linux.dev>; Wed,  1 Feb 2023 10:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+k/i7dsm6rXZ6IDYu7xHiE6wkM7yDPHWMem1rTVHPu3Fg/Tv4vEJNzI+MWQ2uwc84t7X4CvIPfbEoL9XbVlW980VMH5xV5BxSnVk8E74JfUCTAAUJ4xqjLBlozkle2lh9E0/GrW3QftC1df5Wi3K68Rrjo/UWmyPTNJvxYEd1qXC3X3mWGp2F40IXsFzRpHAvPqqDEnaH9a/h2XwR8N08wmXXWIy/IHdJSiQPTZ4S/l21q5i75rj/Rtb1/ACPzJ6ykoGpzXs9lDkQmCZFsWdpMxe6GQYK2WRWMTm7IZhE6YWQmmj1C6ehmC6EMRP2m4VewYBr7fx++JhTs0jfY9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7qAaY3I2sq4jbW8sHA7tk59HENwmVqhsjKMwZqLpTs=;
 b=mljmmzQ35P9pvxG6/PrBVKM+4FZm7GUxevHM6luHrlGgvrQ8QKkq3L5dUHw4ft+/uxSn7kDt6XkloiO6t6+AHPI5v1EKMZz/XeEr477Ha2uHOgV7CPw3s52hk6ZWSKm3IYN5gL3UEs7owszcECNq1g250XbjC/RT3ZDS5ITDkknXLJrO3qQJ3MZwP/faQZIKvvh9PZtv7wGCU7hoA+i2cccg6iRbdnvHdUxlLtqGkTGEZ0nMTbFOCJU1xRgjWsU9zpFCDxahMfowq14hod7gCBt/DMWAxoFdOL+nibLb7/Aiot7f4VeX+U59P6DRfQpAIuEBnpSyr+HkP2j4bsU1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7qAaY3I2sq4jbW8sHA7tk59HENwmVqhsjKMwZqLpTs=;
 b=N+UcC1y1dxpJin4KlP6stjTu/kpSwodzRzApxj4XzJaKWAOhLgE329Cvmkyncf/r9BLNNSgwK9zkjKxGo/HWoAPyvwl9dfXbGK7mGnb3+LW0eSiMMajCnSzu1bOZxqvxFCnbm3EmZNUeoOGEXo7n2e0VH7geSP8e+pF+9M4VJ7jNyHQElpiQfYDtj85ZzSndOKSGDonUjGpfvcPYBiMXyeVrYjRZgsh8Lzg7xYreJE0E7/5zn9i0nClzhIYZN6OKUmyD1XFWnM1rjO+hSPXadyY8LR03nZg/98gKUVMKkhl8JqfQjfvq7+b9YOo08xgeheAol8u9U0veVX+eHGWU6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5377.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Wed, 1 Feb
 2023 10:18:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 10:18:19 +0000
Message-ID: <04956f84-3e28-ba43-5810-2d42c7ac0444@siemens.com>
Date: Wed, 1 Feb 2023 11:18:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [xenomai-images][PATCH 2/2] Update Isar to latest next version -
 sbuild integration
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230123121538.2256043-1-florian.bezdeka@siemens.com>
 <20230123121538.2256043-3-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230123121538.2256043-3-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1232cf64-94b5-4eea-39cd-08db043da3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OVhYIblMLl8DCtpzMGKbkomcQbezGssUE4L39skgTt9DqfuOPx7l5LzZ/OF57W+53J2m9mz8/ZeHYyJ0VGX+h36rxsgsApcQKRgMUgDPLRANhZ5jKaBFuoYVzAKRsU9GAJF9augDEWV2JZ2vcmpS55qwK3JpJ/vVNwI5c6vAd9/fagYJgSo4pNupcbT6+WmvdmVgLMvifgmtKEpuye4u4X8lHDgLWN3tB873vaB9hr6AN/58cOc7d/WIN13azO3WV5OKraQfZy1k0OScJBRLJx4zaO3DWuEV0wUkA2pFkqABl/KGoLdJqb3WiZ54YP0UeXVs/pN9d1QA0kvvZui4D0MET6oW0SYKcNvWa84HP16JNMtD7OO/l+1bZ0kUCmUlpSEK/EN2EEexcSO2MGlR8BraD+7k/h7OQwi899xg+4R6rcl+AzAbFSlGrYYvCXiEfQCumT44Zubi0FONBzLxNruCs5ZM+GX8VH6qDMi8imFrXrSRZrRQCUtpQfku6zwLQp+bIIKSORVJL0Up5HmKQRX7P/xSk0Zl7hn5IKfZRTsssTKJPaajXqBe94jZ4TCNocUmbVDdNye9guQGtmjmSN3cQEUapRyYdfM1BpsbVn8sxlx5sJahogqaw3gAvdsx3JwYh5navdvpBPjYyfpLainGk2vnQkjafKS5d+Ha+5siO5y3/r5sIOpPEBcKyFKkmIQeCauQSZNS7V4vzF/S8VM4B95QFUl6klQg291gyMw72oaXjskNglI9y0ppLAIvg70n5z2M8eEKfxJttl3Mug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199018)(6486002)(6512007)(31686004)(186003)(966005)(2616005)(83380400001)(6666004)(26005)(478600001)(38100700002)(8676002)(41300700001)(316002)(82960400001)(6506007)(66556008)(53546011)(66946007)(2906002)(36756003)(5660300002)(66476007)(86362001)(31696002)(44832011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXNLTW12SHRtYTlISzRPR3MyZUZUSHhqVllaMDcrQ050L3NjMEh3TkRMYUxX?=
 =?utf-8?B?RHovOFBQSzBya1B4cWUyc0lBeDcxbThmVG5TQ0JTTnZKVDRMNHF6RUZDNmdC?=
 =?utf-8?B?WHlCNG9pQytwZUdmWTIweGdQWVF4aEJrTytKcDFnN1pKOURRc0xHZThOd2cr?=
 =?utf-8?B?R0U0WFhCOHFXeWtEejVqWk4xMzcrNkZCM2dkSGlibmd1V3lPekpETHFtS2FS?=
 =?utf-8?B?QTliTFk4cmJZd2tkdFdOcXpwaC96azZ2Yk1sem9pMG9UREJ5Q0JheVlaUk53?=
 =?utf-8?B?MC9NY0VveEdyRVJRdXFvQUZadjZNc3VXYUNPVCs5UlpScWdRQjQ3Tml3SWlM?=
 =?utf-8?B?VWwyOUUxNEZjSVZ4QXhVVkZhekNhdHJUaWZRdHhzY2JLMG41UjlOQW9LR1Nt?=
 =?utf-8?B?ZXlCYTRkNmpiNzJ0V3ZZNnFaejIzMjh1Tzl5OGo0d3pYWFc2Y0IweE5OeXFl?=
 =?utf-8?B?VG1QQitWV1B0dk5TU2FKQ2RSdXFmdXJBSFRXeXFmdCtPTXh0cEl6T2NtVVpD?=
 =?utf-8?B?aGhjVEdFSUc1dCsrTjc2anIrMEtPcG94NCtxNUhGV2hSRDdYa0ZPeFFqNUNX?=
 =?utf-8?B?VmJrdHVPUmRmdmF4S1luUllVWFNQWTd5UVB0bXNGWUxNbFFBUjlnbDhGM1hU?=
 =?utf-8?B?N1FBak8rWmx6UnI2Slh0ejdYVHZ2OG1iMEsyQmZEb250a0J0b2UweUExQWVj?=
 =?utf-8?B?RzdveVpzZ3ZnbGYwb2JWeWgraVI4dVdPRjBydWpCSEwrTEFJWGg1cFV3VC9z?=
 =?utf-8?B?NXYraDQ4SC8zUlRyTFBzUDh3c0pXNXB5MElBSGg3aDByVHY4YkIvNzBSSUZa?=
 =?utf-8?B?a2FZZWRJYmRpeEFzUStwbXlsdWpxY0JrS3krUGNsVHlvMktmbCs0Q3duQjBR?=
 =?utf-8?B?NlMwcVc4dzFqUkw5KzR3bGRsb0swRjRJU1JBMG5FUzBVRHM1L2NNWlh6Z1ds?=
 =?utf-8?B?QW0xTlZEYlZoMy9sZ3V0bUNNd1I0S2JOR1E2QUsyRHBJK3V1YjdvcDJDUmpY?=
 =?utf-8?B?YmpuSlhrQVgyOEtyMVUvNERDaXMyNG5ubENxWmsrRXZLOGRVNi82czNWNHI3?=
 =?utf-8?B?R3c4RXN4OUo0NkMvTGppVWUzV3RONHBJdGc3SDVkTEdXd0w1L3JjUU50QUo2?=
 =?utf-8?B?Zkw1WkJJcFpVcjdOM0V1ZCtoUG9adWxNR1MzaFlwR1JhZ2ZrQWNRditEQU4w?=
 =?utf-8?B?YzRqY1Z3aG1CODhtbUU3M3dkcjlHd2lYbDdrZjJVak9LeWoyWE9BcTJKZmlD?=
 =?utf-8?B?WEV6Vjc3NTFZV0tZYXVHc256QmFwM2JCRDYwTG9IS1MxalRlN283d3l4aXhK?=
 =?utf-8?B?LzBJOFliWXNLQkx1bVZYekFvQU9PQi9RVldxcExERnhSNEpseXU3QUF5aXJM?=
 =?utf-8?B?QzJENlBOVXJhU0s2UUVMU0dUcEJkdGFocUo0RGcwRU16Nm9MeGZBd1Y0WExY?=
 =?utf-8?B?dmlRS0c3Rm54WHV3QjJqVGNhMU9WYm8rcmhFNnFLTFJBaXoxM1lSY2ljVlpN?=
 =?utf-8?B?MHFtUnFHM2pJd0E0bzNFcTBTMHZ5ZExkSVA2cHc0bCt4N0dnYy9KckxFU0M5?=
 =?utf-8?B?UlFXd1cvRkZsYkE3L21CS3YvWW15OUFwa3FxczBsSk5pOTEvOS9JcnJITURT?=
 =?utf-8?B?SmhTRFpEQmFCWE1FeHBLeXBKQS9sVElFUEk1ZjlwT0FVTjhralJPT2lvOHZP?=
 =?utf-8?B?ZzltWEU1ekU5dk5UdWlDeHNTNVZsRjhDSHdtWXlDd0tHbmZXMFNIZm0vOXA0?=
 =?utf-8?B?L0Z5VjJJa0ZRYmN0bkw2MWpwei9YTXkxakdUU0JkUE1QcFNwZHBPeHFaREMz?=
 =?utf-8?B?RjErS2d6aXBmSE16ZlN4Zk9vM3c0N0RmK0w0Q0tqZEh2MkZRMkdzODhZMHpR?=
 =?utf-8?B?c1NwUlhZT2NsSHpNRitUTHhWRU1XN3BSbWYzR3M5VHBuUWF2SHRXMnNUVngy?=
 =?utf-8?B?Um9LajlsazZTK3Z1aCtVYnpFekdqeGtLYWZBS2Z2R1I2emlFN3RlSDIzUG94?=
 =?utf-8?B?RDhuN0cvZnQvc2NtT0k5OXRPNDJqcFpFN2lhR1UzSXkyY3N1ZU1MUVBERnJF?=
 =?utf-8?B?MS9uSzR6ZytBNC9MZEdSSlE3M3hlelp6VFFMRGlrRHdVV0RuOVM0ZGYyMkQv?=
 =?utf-8?B?K2lWQnJ5NmVjdzViYTNiZys5NDg1cnZVRVdqY3paR1VjVFJoRGcydFJmMWVT?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1232cf64-94b5-4eea-39cd-08db043da3d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 10:18:19.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRfPf2ENxOFKrjJUvGBF5x2gVohk13HAMKKSW8KPPrBENKaKAhg0eEciCWnFIfHM5n5TFTXCWtu8TQ6llo2AaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5377

On 23.01.23 13:15, Florian Bezdeka wrote:
> Updating to latest Isar will allow us to use Debian bookworm as base
> distribution. Bookworm ships a recent glibc which will help to enable
> y2038 testing in the CI environment.
> 
> This is the first version of Isar with sbuild enabled, so we can't use
> the tricks around ${BUILDCHROOT_DIR} anymore.
> 
> xenomai: The scripts/bootstrap call is already part of the upstream
> debian/rules file, so we do not have to call it again.
> 
> linux-xenomai: Moving the rules file provided by linux-custom.inc to
> rules.isar allows us to ship our own rules file and override the
> necessary steps.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kas.yml                                |  4 +--
>  recipes-kernel/linux/files/rules.tmpl  | 11 ++++++++
>  recipes-kernel/linux/linux-xenomai.inc | 35 +++++++++-----------------
>  recipes-xenomai/xenomai/xenomai.inc    |  8 ++----
>  4 files changed, 27 insertions(+), 31 deletions(-)
>  create mode 100755 recipes-kernel/linux/files/rules.tmpl
> 
> diff --git a/kas.yml b/kas.yml
> index f8790e5..5f41f18 100644
> --- a/kas.yml
> +++ b/kas.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2018-2020
> +# Copyright (c) Siemens AG, 2018-2023
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: 213b8f62fa74e87321f927fb6b4ed9db93e5cb37
> +    refspec: 8530a94bdc8919fadccad13e6061832d2f2c1fcc
>      layers:
>        meta:
>  
> diff --git a/recipes-kernel/linux/files/rules.tmpl b/recipes-kernel/linux/files/rules.tmpl
> new file mode 100755
> index 0000000..5f1b325
> --- /dev/null
> +++ b/recipes-kernel/linux/files/rules.tmpl
> @@ -0,0 +1,11 @@
> +#!/usr/bin/make -f
> +
> +include debian/rules.isar
> +
> +prepare_kernel:
> +	/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
> +		--linux=$(S) \
> +		--arch=${KERNEL_ARCH}
> +
> +override_dh_auto_configure: prepare_kernel
> +
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 7dba96e..bed58cc 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2018-2021
> +# Copyright (c) Siemens AG, 2018-2023
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -19,10 +19,13 @@ XENOMAI_DEBUG ?= "0"
>  
>  SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>  SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
> +SRC_URI += "file://rules.tmpl"
>  
>  DEPENDS += "xenomai-kernel-source"
>  KBUILD_DEPENDS += "xenomai-kernel-source:native"
>  
> +TEMPLATE_FILES += "rules.tmpl"
> +
>  def get_commit(d):
>      try:
>          return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> @@ -32,26 +35,12 @@ def get_commit(d):
>  LINUX_COMMIT ?= "${@get_commit(d)}"
>  
>  dpkg_runbuild_prepend() {
> -	case ${DISTRO_ARCH} in
> -	armhf)
> -		ARCH=arm
> -		;;
> -	arm64)
> -		ARCH=arm64
> -		;;
> -	amd64|i386)
> -		ARCH=x86
> -		;;
> -	*)
> -		bberror "Unsupported architecture ${DISTRO_ARCH}"
> -		exit 1
> -	esac
> -	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
> -			 ${PV} ${LINUX_COMMIT})
> -
> -	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
> -		--linux=${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=$ARCH \
> -		--outpatch=${WORKDIR}/xenomai-kernel.patch
> -	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
> -		-p1 -i ${WORKDIR}/xenomai-kernel.patch
> +    bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
> +                     ${PV} ${LINUX_COMMIT})
> +}
> +
> +do_prepare_debian_rules() {
> +    mv ${WORKDIR}/debian/rules ${WORKDIR}/debian/rules.isar
> +    mv ${WORKDIR}/rules ${WORKDIR}/debian/rules
>  }
> +addtask prepare_debian_rules after do_transform_template before do_dpkg_build
> \ No newline at end of file
> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
> index b874a4a..8ebba7c 100644
> --- a/recipes-xenomai/xenomai/xenomai.inc
> +++ b/recipes-xenomai/xenomai/xenomai.inc
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2018
> +# Copyright (c) Siemens AG, 2018-2023
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -32,12 +32,8 @@ do_prepare_build() {
>      # Remove upstream's "3.0 (native)" declaration so that we can define the
>      # package version more freely.
>      rm -f ${S}/debian/source/format
> -}
>  
> -dpkg_runbuild_prepend() {
>      bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
>                       ${PV} ${COMMIT})
> -
> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
>  }
> +

Thanks, applied, with some whitespace fixes and a bit further Isar bump
to get a few recent optimization (not the broken ones).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

