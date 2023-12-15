Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2C82EE1
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Y/i9mOW+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8codgpP3TDlaInH9BFOSQbm6mInvBBP4dteKhB02ApyOpE9zOLsuZ6uyratl4z7ert1LaFPsG0ZSCpu40jspo/LTNbWxYMKpmSwLirU8BOGVWMS2H8FdUCfg9DTb06KtcV1Uvejelc+bCsoS5mxB3P6kby3i3JXfIE/w+7uMdLG6IEyN9Lr/Os9p2YfAQlXR2+DPSx/2IdAftCStj8P33VbNmzG/PFt3xpStLJGROLlaDptTAQvQuQ4HYhZsABiukjNtRKn/hRGJzqskK5A13/PbLnMQhk7dq0sBBu3bEY5JTPk5lE+vlD14OWU+Di6avf958XQogtkTWv6a/41Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15jNNStKzj8UWIVvhwEGUZwtJahBH8wEIopVKC9XKJo=;
 b=bzk8PyifF1W5LmQ8BO/RgdQbQBtPIgmChFkTsueF0cW2eE6C0NKDf9b3lKyUvfWkYtGNqwwLu+Zg/M/ZUX7usHYmpeP4lFh22h8Kkw/blR4wsjMMP04bzHIwnGBwESPm/QKNbvoLAa6o8/CN1J12b5vE+E0CjtGVnVmNohKl8RC51IFp+A5vnGYRvi8pX1p4nsR/1iconLLDNhEZh7hEeEWwHt2cEu4gORL9xlm38GP0b6IKKe1NQrQdZWKF2XR390PBQhhkcqEcnnyHlWHH/+sc8pC17iZnJQi3VQc/WIbvX1ooZDetmI6Q+F11TJz1HGiazp6SWEW3YeaGjkg5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15jNNStKzj8UWIVvhwEGUZwtJahBH8wEIopVKC9XKJo=;
 b=Y/i9mOW+PQTtmgnVqkTo8rrB6pajoCaPvsRX5K0aQN/Wr8R8EJSdYTFafg1h8h/pcibzQZ6oiMYIXcyr15feYwqok2RqaCgWKJt/JCFs1UgOla3Z5rrTw1buko84h53+Y6f/+exWBdLaRbvm81x8G7Ovrxe2gXySZxBn8wWxJW371Nn8HoMIEKLV7BOfOTTTy4wO5ojHTa/ALByXP6Re9J2pAZ9J4cn5jKzBh19xSObX5UpjYeM2n/vlh4ugx/eHXyH/V+Z2N7sGC9wUNJoD/bp7G5B2MhTzkhzO3xNetbT+OyfNRHtaCEu6VNIYyFX5HhOsgotrTtOOYPqYJsiX0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:42:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:42:21 +0000
Message-ID: <e74198a4-2a4f-4377-bfd3-124dbe31cacd@siemens.com>
Date: Fri, 15 Dec 2023 18:42:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v1 2/5] libevl: Add libevl recipe
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
 <20231215114349.2913803-3-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231215114349.2913803-3-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 82435a85-888b-42ad-2e8e-08dbfd9530f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AwCLvTldnltXW/a81fZ1Pbzt/BSnezdvXVksc1mSnMomaTqHce6IuPM8UPZ4PDI9S8AjoNbQaudWmhNpvUCNSt9tNO+pBAhEifVTRrVv4m8wnl4kVNY89o5P5dDLf+tcNpDmBPmUSt4EWWr+lT+kRKmtsERtStoglU9yRZu7cxjMn8aHVMkqnOL64dMoVwAyJ4W9YQuanm317aBWmlIJS4v/6ysskXtg8TxQQ5nBlF6vgwMy5zHEkp6CN0YYcnui+gxx/JzldY4VdR9R+vBA+6TxC0IGxuAdIlnoy3ZtmH7sBMoCIdwD789yCEUdqm0nEqJ8U23aH3CuHsAkiLAkcTbu9L0tPHQycLW6yf0IAkWrmPMHRBTkK5+ih59HZAjVUyGb9KEwmb8qGqnyk3a2ID5UFzqxa3qvoS76bHCbLYJgU65pi55VAh+3KsbsZBj8IoZ1m5nh9spdi42JTPMrzT7eKykIyUzZywrj3gFpfPrGI4ESJOsKL0f4SXW4nvUW1r7jJ9RNZ6wyg4U1rMLEuUQFqUrIA3dZ0SgB9U9dOlCoNp6seNY2DGuXsUodBfGSA9H1djkIrtXaRMIuaYLJJBK39Sr3yYAjtBK+66986gZs2EpiiUIDhddgJv9CkvCYFqe8eC33/7SEyhDKnaUL1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(26005)(6506007)(2616005)(82960400001)(86362001)(31696002)(36756003)(38100700002)(83380400001)(5660300002)(44832011)(6512007)(53546011)(316002)(66946007)(8676002)(6486002)(8936002)(66556008)(66476007)(2906002)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEpudEowZnM5SzhNeXNGR3M5NzdDRm81RXFoYnVGaHRJait5cXdxTzhTRkxs?=
 =?utf-8?B?TUZTUG56cmhnQmJNZ21qeFdTNllRS1dzNGJ5enlxT25FOERnZy9KTzNPUnpZ?=
 =?utf-8?B?L21oc2ppMitWWXlNT0xiWkIrVW5LeVJETmhtRWNLdnU1aXlGdllMOE4zZmdn?=
 =?utf-8?B?ZDRuL2VzcWNCazU3Z3pweGF1ODAyWE5tTG5HS3B5ZGdLWGxBMlVBQzFtZ01H?=
 =?utf-8?B?OWpzV2ZqSWtBN25DWGlVWEFXWjVzRXhhKzlMZHN1eTltSnRpbFpzSW9nTld1?=
 =?utf-8?B?NVlSZGVLWGFNYy9HK2NpZm96bDhZZzF3SUFRZU1wZGQ4MG1hQVE4QlFtNldj?=
 =?utf-8?B?UHdCa1hINlJUaytaYThrMENDQ2JxMjdhUjltS3hYeUdtSUttQW9NTFdaUXM0?=
 =?utf-8?B?ZlpNL3lpMllXLzNyOVZsZnhWbjVCcU5ZVlptakttMTZveW9iQkVxKzBUREhw?=
 =?utf-8?B?VFhORjUvR3Ezc3pnU2l5L2ZZc2JvVTA0V0c2ZExCMEFGZHUvUjZ2WExablRJ?=
 =?utf-8?B?Y0Jsajc2WGphWlQzamNZNU1SKzMwbkFIOGxYMVhrRnJQcHVJdU82WGZoV2Zt?=
 =?utf-8?B?YnF5bjNOVkk5VURvSkhRa2VQQitrTzZVdlBVOERLTnAxNmU0K0kxOTZSMDQz?=
 =?utf-8?B?NWd2UnYxYjFMNVJJOHF0Wi9rV3h1QThneXpPeDNEYUM5Y042ZU5mckt5b0tJ?=
 =?utf-8?B?bTJ0emdSNlNvbis3NktBWWZQT21iQTFWNXJtdUNzWE14MVd1QW0wUURrcS8y?=
 =?utf-8?B?QnVoUW9TT3cyODkwS3l6U2I5bDY1RE9qRjU0YkFqTXBEMjV2SWR5NUhyT2hz?=
 =?utf-8?B?NC91RUtPLzIvVVlGd3UrV3JEbFEzUXZnN2hZYUtLUmlqTkJ4U0VFdkRWTjZY?=
 =?utf-8?B?WEYrc2c3RkdzSUh1d0g3V0V0bjM0WS83UW1ES2ZxaWdmVzhSMWVuc2doUVZl?=
 =?utf-8?B?a2xzSUgrOUFOVDJXc1dyd2l3WFM0eTNkRVpnUzR1OEh5VlNGcjhzazdkcGkw?=
 =?utf-8?B?cytRNWxVU3FGcHkxS2g0S1ExY1l0bFp6Mmw5SFg1UWt3Um1BL012bzBEZEY4?=
 =?utf-8?B?QnduMjZXN3RERGh1SU93ZlhWbE0vOFo0WVh4NCtGelM1L2tCcTJzbGZxNU5a?=
 =?utf-8?B?OG9lSXQrNkVCR1gzZzZpbEI2Zlo5eVRHYmxsYmR5SFM0V2treWtMZ3lGUk44?=
 =?utf-8?B?cTVwL3pFanhYNmpBd011eS9oVWJSQW9pVHhIdVNmbFo2SHcwUE9ISGdFcWcx?=
 =?utf-8?B?ZWNXdE5DUHAzRkNuRUpMUmRYeFIzcytQK0xsS0VwMVdOZmNVT0hqYXFuSEgx?=
 =?utf-8?B?MHVBU1hLaWRWZFZNcFVvRzlkYk5CdUZBaHYzUC9RbElWOEdleHVYU2llb0Jw?=
 =?utf-8?B?UlhUN2R0UjU3cnZMVG9iaDUveU14MEx0RUxVNzhac1gvb3RicklUcWVKV3Zx?=
 =?utf-8?B?Z0FtZGlZaWY0RWRhSnRCR1hSeE9GdlV1U1E4Mm03bXlvWmFDelkyeDRSbXpo?=
 =?utf-8?B?V2NBOVBpaE5KbHFyZUREWlNIdjFGTkNvc0VnNERSTlN0MUFQUVBlQmhWeitV?=
 =?utf-8?B?RmJUU1JwZ0x2L0NUcGNWTy8zTjdEemtoR0lPVzRNT1l3dFdrVEVVcUMzZkRp?=
 =?utf-8?B?aGI0bkZ3ejVKKzA0RENnTDh3NW4yVkR3dnBzQW1HalZxMkw4SnJYRnZCbWVO?=
 =?utf-8?B?aEpmdzVDYUtTc3hMNGg4Q0xzZ2hXckU5UEg2NVM5bnR3V0lXWFpJZnUvMUlz?=
 =?utf-8?B?SVRhUS9rWC9BOFR5QnhyWUQ5MjEwakRYSWtYSm41V0VSSDJjcHBEa0NzWEc0?=
 =?utf-8?B?R0NxMS9hS1ZydEVYSU5JZ1BTMXNCUTByNUxwc05yQUJ5UUFma1A5dE1waDIy?=
 =?utf-8?B?Tlk0cHhMMmFrL2lxSWlvRzRXTzdCYm9pYnVGTnl0eHNlbFU3MERCamJRVHB3?=
 =?utf-8?B?ZVA3M09QUjJRYlBVaXM5RHY5REMxZENiY0J5U0o4c3U1WDlvVUVjdmVGUDZk?=
 =?utf-8?B?U2VrQkdoc1hMcVpYNWdhVFNkUkVqSWxkaVJTTG1reXRPS1Q3cE5nbGdjMzZT?=
 =?utf-8?B?NlVSSDNmZHFRSWQrUHR6aGlCVmxENVZDZHRxdForSFYrMWNtZ3hvK0V1Mkov?=
 =?utf-8?B?UlFuM1FheUwxNFNCWHZ1Sm1hZzE2NjgxOTBHUWRBYkpCaEJ3WllaMk9CRkxj?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82435a85-888b-42ad-2e8e-08dbfd9530f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:42:21.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLMF0NrKimwJ+fkDRVEKv7Fxt1QAYk4R4i75yYo/sdTRV3Nt1CnjKezwxPNmqeK8ZSvTxl6yelP3WTxLeE0V/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7336

On 15.12.23 12:43, Clara Kowalsky wrote:
> This recipe allows building the evl userspace.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  opt-libevl-master.yml                      | 17 +++++++++
>  opt-libevl-next.yml                        | 17 +++++++++
>  recipes-core/libevl/files/debian/changelog |  5 +++
>  recipes-core/libevl/files/debian/compat    |  1 +
>  recipes-core/libevl/files/debian/control   | 12 ++++++
>  recipes-core/libevl/files/debian/rules     | 12 ++++++
>  recipes-core/libevl/libevl_0.1.bb          | 44 ++++++++++++++++++++++
>  7 files changed, 108 insertions(+)
>  create mode 100644 opt-libevl-master.yml
>  create mode 100644 opt-libevl-next.yml
>  create mode 100644 recipes-core/libevl/files/debian/changelog
>  create mode 100644 recipes-core/libevl/files/debian/compat
>  create mode 100644 recipes-core/libevl/files/debian/control
>  create mode 100755 recipes-core/libevl/files/debian/rules
>  create mode 100644 recipes-core/libevl/libevl_0.1.bb
> 
> diff --git a/opt-libevl-master.yml b/opt-libevl-master.yml
> new file mode 100644
> index 0000000..b241541
> --- /dev/null
> +++ b/opt-libevl-master.yml
> @@ -0,0 +1,17 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 10
> +
> +local_conf_header:
> +  libevl-version: |
> +    LIBEVL_BRANCH = "master"

Better use PREFERRED_VERSION_libevl for this.

> diff --git a/opt-libevl-next.yml b/opt-libevl-next.yml
> new file mode 100644
> index 0000000..6b64ac7
> --- /dev/null
> +++ b/opt-libevl-next.yml
> @@ -0,0 +1,17 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 10
> +
> +local_conf_header:
> +  libevl-version: |
> +    LIBEVL_BRANCH = "next"
> diff --git a/recipes-core/libevl/files/debian/changelog b/recipes-core/libevl/files/debian/changelog
> new file mode 100644
> index 0000000..b8f8279
> --- /dev/null
> +++ b/recipes-core/libevl/files/debian/changelog
> @@ -0,0 +1,5 @@
> +libevl (0.1) UNRELEASED; urgency=low
          ^^^^^
This is always incorrect.

> +
> +  * generated by Isar
> +
> + -- Unknown maintainer <unknown@example.com>  Thu, 01 Jan 1970 01:00:00 +0000

If generated anyway, let's do that via the recipe (debianize).

> diff --git a/recipes-core/libevl/files/debian/compat b/recipes-core/libevl/files/debian/compat
> new file mode 100644
> index 0000000..f599e28
> --- /dev/null
> +++ b/recipes-core/libevl/files/debian/compat
> @@ -0,0 +1 @@
> +10
> diff --git a/recipes-core/libevl/files/debian/control b/recipes-core/libevl/files/debian/control
> new file mode 100644
> index 0000000..94d2d8a
> --- /dev/null
> +++ b/recipes-core/libevl/files/debian/control
> @@ -0,0 +1,12 @@
> +Source: libevl
> +Section: misc
> +Priority: optional
> +Standards-Version: 3.9.6
> +Maintainer: Unknown maintainer <unknown@example.com>
> +Build-Depends: debhelper (>= 10), meson, linux-libc-dev (= 6.1+r0)
> +
> +Package: libevl
> +Architecture: any
> +Depends:
> +Conflicts:
> +Description: install libevl related repositories

Not "repositories" - it's libraries and tools, those should possibly be
split up in separate binary packages.

> diff --git a/recipes-core/libevl/files/debian/rules b/recipes-core/libevl/files/debian/rules
> new file mode 100755
> index 0000000..80e995e
> --- /dev/null
> +++ b/recipes-core/libevl/files/debian/rules
> @@ -0,0 +1,12 @@
> +#!/usr/bin/make -f
> +
> +override_dh_fixperms:
> +	dh_fixperms
> +
> +%:
> +	dh $@ --buildsystem=meson
> +
> +override_dh_auto_configure:
> +	dh_auto_configure -- \
> +		-Ddeb_host_multiarch=$(shell dpkg-architecture -q \
> +		DEB_HOST_MULTIARCH)
> diff --git a/recipes-core/libevl/libevl_0.1.bb b/recipes-core/libevl/libevl_0.1.bb
> new file mode 100644
> index 0000000..76a45aa
> --- /dev/null
> +++ b/recipes-core/libevl/libevl_0.1.bb

The recipe version should reflect the package version. Like for Xenomai,
we should have

 - master (head of branch, floating)
 - next (head of branch, floating)
 - stable (latest tag, floating)
 - 46 (r46, fixed, the current last release)

The first two can be handled by the same recipe (second one as link).
Check how xenomai_master.bb works.

> @@ -0,0 +1,44 @@
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
> +DESCRIPTION="install libevl related repositories"
> +
> +inherit dpkg
> +
> +LIBEVL_BRANCH ?= "master"
> +
> +SRCREV = "${LIBEVL_BRANCH}"
> +PV ?= "${@d.getVar('SRCREV')}"
> +SRC_URI = " \
> +        git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=${LIBEVL_BRANCH} \
> +        file://debian \
> +        "
> +SRCREV = "${AUTOREV}"
> +
> +DEPENDS="linux-evl"
> +
> +S = "${WORKDIR}/git"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    cp -r ${WORKDIR}/debian ${S}
> +
> +    bbplain $(printf "libevl-%s: Building revision %.20s\n" \
> +                    ${PV} ${COMMIT})
> +}
> +
> +def get_commit(d):
> +    try:
> +        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> +    except bb.fetch2.FetchError:
> +        return ""
> +
> +COMMIT="${@get_commit(d)}"

Jan

-- 
Siemens AG, Technology
Linux Expert Center

