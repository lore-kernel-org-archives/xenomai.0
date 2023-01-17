Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D051363
	for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 06:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpLwed3YfErXS061ftq/v3kUWirnxSgBaTrMWDSgU/WJjkrRiO7hk62EfIPQk0QnHAdzVkCmGkD6OGxPaXZd14BYpx2JFflPQPu1F7+rjvo8GNtlGGJqbwhAzrDvUnLDGOdyoMDnthOtBuHKmZpvgSpiuLRHMJbeeGGlPwbuzGq54sNjBByhw+Ps5u9jtEw2BQSV8qYD2Cr066ZBhD1mHXpl6RfENxXE7lmuIN2b8/IEYP8X6j5nBKN0nbACjaMRc2aMpFNzxZDeBn2h7SQeWHDlJkGQa96Yo7oQapfNQa9nXjoHtwKAw3YRRvWvbi1k5YrHLkIwLeKKURT5uu/45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPHtN1t6GudSPGIvcBzoo97YOntiUPM1kzrna4qeB9c=;
 b=JrZkVV6mHNUeEL+Eem52KSaeyiAW/cYwkjnkjudkuU9cpBrLJ6gD72hvzIypGOHPIAQH83VozjkLF1duBtKLgRmaZsFoJ7nQekg+RLpFXdNc01AI8pNlQOTl3arQDNIzWhnKIs6nCTnHaXrNXD7MMKhesiUOKoWZX0UpLutNX0yg0QU8u1mo5rqC8ZZY203Bearo1ea/4ZRKxpnEqFXRnxTH5FERKgXxo/kzeVKDgLQkNjFcv2acMTTKZhNSH2d22JLC09YBKo0PJAk/Eine0Jgs7pbe1do5xK1IFtVoCcTRS6t00DrzeKK3nF7BIemA/Tqcv0zOsZ54cb2hAl90Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPHtN1t6GudSPGIvcBzoo97YOntiUPM1kzrna4qeB9c=;
 b=WHW2l8oNbaB7ez/bq0/2/rEhbktkSIQaxNYhc62alk+IlFcwaCz8B4damUADVZBafnnYvO8lruj17DeKozRLPw79AyH26tGU0j0Gnhnyvtp0U+iBWaA2Onf0zRR++B3L0ySQy7mgwEeE01iWpd2qmruTDsLy+BD1OfaIbIZgJK5ysNzVXJDyzSNIFktmSDJge64DzACaOjzqv4YYgs8enXyyAeYUcHAawnwRLCCHKbkBavD8KoitrChU+rWxvNifHygTKSUnAJTEdmGp+r4Yx26A2CSY1LAHq0WEFigV0ODV6txWjHHW34kwhBMzRlsq1wxAzRxdJ+ENnS68HHOPwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:243::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 06:35:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 06:35:59 +0000
Message-ID: <3a6dca22-5f63-e6a5-1167-7d69a16a0686@siemens.com>
Date: Tue, 17 Jan 2023 07:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [xenomai-images][RFC PATCH v2] Update Isar to latest next version
 - sbuild integration
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230113211640.662759-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230113211640.662759-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 50de4ee9-3b2e-4104-f4a5-08daf855184b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DUaxnXR0874sOEvWBa5If5fV6fWIvUnB59xYQpk0XOSHFeBaTBel6QN8Pep9SX4OPQzglZHFRESZGoueBA+jKWnd17BVZBPpa4756zAAOsFcbllZQWipN1bukbvDsk/6aUbeY6u/ct0QvpSAm4SA7IW73vOK+Qdko0u3dT5bBjJ4Iz+MT1mv2t7oGa0vsevTIN5J7J0bnIg97YKo2aUd3QH2muC2s0Jo4/vKC+IWPgeKwapepmPQA3UlCuUgV6Q+obAWNKv2T1Ng2Ly+raujNKZzmMoe/b0b6DlotXghov/L8PbGOwYvTwM8FHrPT5dsIqZRRY0ZmCVHqGddhszlMmyC2CwLg8rTGZekLkyfOoN/K3PjRYzcQH+7J9EYCF3OmSvorpbsxUJUJVIeS3tc82zx/bXbAg9GQzFzgdwrBsQMyJVuaR3Zr0oL9AWF2Hh8qqyp9oy2V2nB2YHR3hWLZPdPn0hBG87Jq8pKvADWOtncBcakJqtbHyke3Hr2Z6IA6Lxpru0VwMKg/SRibwSGIMbiPhRBBWSSCoWE+F9HSEvyQqRYK40VdU/e9P9xithqRLy6MD5NH26Ckgrk6IOpbLx2MKU0GSLBbdxa9ewHWS0WiYNWnWDNE1phoO0/8IvQoI42CRcDwYa2IX7y0fwRgSqXrEA7aWOwrhRlAavV4Jrn0p0hCB+jEbWRhloOvZ8sEvLNy/nyF8ZpzyHlzsb60i56qTi/XEzYq0H2FAkYrht+Vxvm+xmjMQT4AaT/taVC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(31686004)(86362001)(41300700001)(66556008)(66476007)(2616005)(66946007)(26005)(186003)(6512007)(8676002)(31696002)(36756003)(53546011)(5660300002)(83380400001)(82960400001)(8936002)(6666004)(478600001)(316002)(6506007)(2906002)(966005)(38100700002)(6486002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmVVeGJZR3djN2RhVnkxM1Y2VGlvVmNTUVZQQ3NsWjEwWU1ka0VjTXpqSk5v?=
 =?utf-8?B?V2pSQUJTKzhuU3lLUGo1VU9vdXpqak9GWk9vUHpNM1dvaHNkZEFHeUQ0L0Nm?=
 =?utf-8?B?SFJWRzZMUFpnMitVOUJaQXdEN0c0MW00RTdFVjkyc1IrUFU0aTdiaDBLRGk0?=
 =?utf-8?B?eVF4VnhDcUFuaCs2VlJ3U2JpOGN1QUhHbEFNMWo2UXJyU3IwaUNUbElmdits?=
 =?utf-8?B?N21Ud2NTMTB5bmFSZHJaOGJZZEladlovRDBjY25pcld0UDFrWklKYkhPMDdX?=
 =?utf-8?B?WXNORmdDOGo0SkQwZS9mK1VWTGYyZ0J4Ym9IemdrZElVS0xqTnQ3L2Nsejc5?=
 =?utf-8?B?dndoYld4aXZ6a1hXSlVjSnVudm92VXJQaUJQTmIyQksxMCthM2F3VGx4dnZ4?=
 =?utf-8?B?VE5YSWNDdThNL0h4eHQ0MjNhMEpHSEtqZ3ZXUnJLdnI5Sk5uL3g3U1lrZmho?=
 =?utf-8?B?dGhLR0s5dUYwU28xZ2JoYzFmdlRRN3lLUnJINHFMSk5yaXd2RmQzMW9ZampC?=
 =?utf-8?B?dUYvbTNvOUVuVHQ3dHRTWXFSWTBabmQ0VkQ3VzEvTkJWRExpSHRaQXgyVVh2?=
 =?utf-8?B?dFJMSzljT1BXZ1FxUmozc0wybkhETTROS1lVK0JUVUxibnNmaUVBYVRuR24r?=
 =?utf-8?B?QXdJMGMwTUlXWXBrZURQVTRBUmsyUnl1V0dUeEE0Y3NEaW5tR0V4T1k1eFpa?=
 =?utf-8?B?b2RmTWJ5eWRGa1dNVDZaNUl6Vjd1b0V2T2JnVmViR2o3QzFrb3ZobnZaajFR?=
 =?utf-8?B?ZUhtYmx1ZDVTSzRFemxjSW9Gc2I3NlhzNTY2Q0h2Q1pWVDdFRy9rbWFFaDZj?=
 =?utf-8?B?aXJwdGlJdHkwQTFmSkx6VWNjQm55eHpwYmZwL0U3RnZwaVNReGdPZkRJQ1NW?=
 =?utf-8?B?MzFvaWp4YjRVbkFJMFhEVTJ1ZGNVbG8yaFNYcEM5MHBnamtXcHA3ZXZLcnRK?=
 =?utf-8?B?THg5aEJJVXNia0JmdmgxY3pLSnljdVUzT3puMEtwOWNQc1RNN0dDdFVNV0xU?=
 =?utf-8?B?Y1cwWTlDZWZHMVdLcG5PRmdDQWNxNGJlZXlKSzA4RjYrSDY4VGh4Q2tPZWtF?=
 =?utf-8?B?aTgyYUhkV00vdFowSEgrUDZzMWdTVlE1TGhnZEJSZTUwZ1hXQTlTc0RmenZi?=
 =?utf-8?B?NjgrR2RpbitQWm0yemJXOS9mdnhSU0JhaFUrZUhpa1VBcDlzQ0lVWElndVpp?=
 =?utf-8?B?bHlBTHJIbEUwM09LeVkvOE5BajM4V2NIT1JtblUvVTJhTmNMbWVkWGp1STl6?=
 =?utf-8?B?SEQvMmJhRE1jQ0hwM0FNRE1BK0U0dkJNakZESEhkcjdBVldDRzlFaEc4OHRQ?=
 =?utf-8?B?SExmcEw5N2htNWF5dGppdjJYcytyZkF5K3IwcjJrMFEzRDZxV2FJbWwwMmcz?=
 =?utf-8?B?Ni9qbGtPK1MzVHlLOXBtbEs3NDlPdzRUdlVQbkFkL1BQeWhuSlNHNW9majdn?=
 =?utf-8?B?SGhGMzh5Z281cnp1NXZDdU80V3FHOXFYbzI0cWFrU2pZVXcydEU0YllEVnZE?=
 =?utf-8?B?RzBPN1lwOXNPVWNBMEZsQVdwZWY3UGxBVXVJMnRyVTQyVURWaXk4NG55NDFL?=
 =?utf-8?B?eDVycGpyQVRIcmVNemUxOW1MYkd6MjQzdGdGTGFUcTZlazdrdEhrdmdGSFlh?=
 =?utf-8?B?TU11QW1DK1loOHNKdFVVSUFLQm1FZjNmTWNFUW9oS3FJa21rcnB1b090WkNq?=
 =?utf-8?B?OHhzU2NtZVU3NG9Pa3JqdVpiVkVRcU9mZWxuSi9iMDZ0RlhHdm1ZaDM1cjEr?=
 =?utf-8?B?Z0MzbDI5UElzMXBuMXBBRjA2dndqbFZMT04yVWV1N2Q4WEhyZGh0OHloS1d6?=
 =?utf-8?B?YlVHUzhUSktraE9aTVdxQlFoTVVRSHIxeTVOTnVFS1ptblJVWFQ2NDZFMFk2?=
 =?utf-8?B?TXN3d2N4dkt6aVlwamc1Zkp2NXpXeXhaZTdjR2ViZTI0VW9rSyt5ak9SUGtX?=
 =?utf-8?B?NmpnQ3RSZnZCbVZOa0luM0dhM3VrYzdUbUk3b3lqSWlVWW12RXJFQ2Z6R0pX?=
 =?utf-8?B?N1djRDdiVUVTS3JvZW5NVERrcGZkQ2Y5MTdGb2h4UVRZVWpKRG9GZjVOT1BW?=
 =?utf-8?B?TVlxd2c0NFVta2xac2N3bHE2b3VDckdqaVAxbGUxQURTdXdZUEpNdWZLVWVp?=
 =?utf-8?B?elAxbHZkSS80WVc2VWZsSjZFc21HRVdjbjlKQmNPUyt5RURzdy9hbFdtOGVF?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50de4ee9-3b2e-4104-f4a5-08daf855184b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 06:35:59.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xZZUJ9HKUvf7asY2m9W7FGnSrTQ5osN51vh6cbARumXrsUyCyMhOaiqho7olr+PpC/53pEfuccm1aTVX2tlxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5637

On 13.01.23 22:16, Florian Bezdeka wrote:
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
> Adding "rw" to the kernel cmdline for qemu based LAVA tests is a
> workaround for a current Isar regression. The rootfs entry is currently
> removed from /etc/fstab so the rootfs stayed in read-only mode. Upstream
> discussion is already ongoing.

Can you split this up before dropping the "RFC"? Except for bumping the
isar sha, nothing seems to have dependencies.

Jan

> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kas.yml                                |  4 +--
>  recipes-kernel/linux/files/rules.tmpl  | 11 ++++++++
>  recipes-kernel/linux/linux-xenomai.inc | 35 +++++++++-----------------
>  recipes-xenomai/xenomai/xenomai.inc    |  8 ++----
>  tests/jobs/xenomai-qemu-amd64.yml      |  4 +--
>  tests/jobs/xenomai-qemu-arm64.yml      |  4 +--
>  tests/jobs/xenomai-qemu-armhf.yml      |  4 +--
>  7 files changed, 33 insertions(+), 37 deletions(-)
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
> diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
> index 166d472..b989576 100644
> --- a/tests/jobs/xenomai-qemu-amd64.yml
> +++ b/tests/jobs/xenomai-qemu-amd64.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -46,7 +46,7 @@ actions:
>      to: tmpfs
>      images:
>        kernel:
> -        image_arg: -kernel {kernel} -append "root=/dev/disk/by-path/pci-0000:00:1f.2-ata-6 console=ttyS0,115200 console=tty0"
> +        image_arg: -kernel {kernel} -append "root=/dev/disk/by-path/pci-0000:00:1f.2-ata-6 console=ttyS0,115200 console=tty0 rw"
>          url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
>        initrd:
>          image_arg: -initrd {initrd}
> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
> index a1dcc1c..5bf513e 100644
> --- a/tests/jobs/xenomai-qemu-arm64.yml
> +++ b/tests/jobs/xenomai-qemu-arm64.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -50,7 +50,7 @@ actions:
>      to: tmpfs
>      images:
>        kernel:
> -        image_arg: -kernel {kernel} -append "root=/dev/vda"
> +        image_arg: -kernel {kernel} -append "root=/dev/vda rw"
>          url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
>        initrd:
>          image_arg: -initrd {initrd}
> diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
> index 3b5bc10..1ab35bd 100644
> --- a/tests/jobs/xenomai-qemu-armhf.yml
> +++ b/tests/jobs/xenomai-qemu-armhf.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -46,7 +46,7 @@ actions:
>      to: tmpfs
>      images:
>        kernel:
> -        image_arg: -kernel {kernel} -append "root=/dev/vdb"
> +        image_arg: -kernel {kernel} -append "root=/dev/vdb rw"
>          url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
>        initrd:
>          image_arg: -initrd {initrd}

-- 
Siemens AG, Technology
Competence Center Embedded Linux

