Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0045BF8
	for <xenomai@lists.linux.dev>; Sun, 17 Dec 2023 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iJckW8aK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9CUsFFDyInyJM+cS1ECQrgDp5e1qS+M5oRWrmn2/8UNO6bMf9SlRDGrzsVJwFc5jLPswOssQYZYOYZRl6IcogVYjM1kSzEA0dzSLuTuGmczwgmycJIDTRxdW4Y08yMMQoQxWPeYaD5P20jHqPCfOmk1cTjkcmw/HnuzzkTcBn51oGmJU5RCy9w6vzC+eiba5ljySMSTcqPQJbRa0WjvTQeeY2t6iL48KXL2dKKDnkSUx6m27zU+EvPl+du7nmvOfdJq5MeM2SAtgtOJOse+cpx6qXLZdoi+2Zex/sNsv//JjG/TQOD5SxZRzhuyZvzdVjGYXjjwb+Zhen8VXNBCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEH85KXCFk25uYHYYF7VVOqfbHmu64qaTJ+UMcp/A8E=;
 b=G55lW/+4X+FvWTEWyzrCAj6jEr0ThMg3ECYKZccfUWzzPEn+1sa8sTc31xOxBIfiK5KV/BplYGbrNDUZ/SuiWIvQ1Joon/YGNq9wkD6mn5dTLk4XQOoeXC6GNU9Dv2RuRKXytssWEfm2iG2yEDky6HgVpaVqP2vHW8ULedsiIPVIyhl2IRvzcM2SdLg7OucoxDiXmqLDzi+TnpbIJJU49lGIUSS0854oFPGVHNTb4vKGfTdkD2nnZx+uZ7SF1+fuE225ZohZjlZMtC1A7j3J1Qej/paaIHVBmMV7oeZOGQqsT+MgryT3bC4fPmpZlT6ZMLBsCXI648I+pEZqZWBv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEH85KXCFk25uYHYYF7VVOqfbHmu64qaTJ+UMcp/A8E=;
 b=iJckW8aKIqgP++dVTvgpSJxwYtUNgOuqtZEgWjq41H0DxOo6eou/AyjFAyU44/DjNwv4q4XoPn7VjPaVrH5BtRXuC8n6jtFyF8NBtk6ygMeYoKEdGjemxSAMZPJz0wqMzLcAZWpbfUZ16bXMwv4Q6+kAv5aFlVQ7Z+Ob9fWmR/ximDmDExlQwqjDPjLQ8R280+wtMQGdquakcIRKb1jO9AFtICYkNYkF1iozg6QL6I2zefHnW/FIjmZRjhrwzZZNPQCaJtrRY6nCKhMMSWzaeXKbPwdnpT7rqBtgJRohSRyFgz857gpLB8Vs/jc/rTcGOCL261rxXNdoeeH5keHLWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 16:53:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 16:53:13 +0000
Message-ID: <967c1b48-a7c8-4420-8178-372e75642b56@siemens.com>
Date: Sun, 17 Dec 2023 17:53:11 +0100
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
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 25befe7a-e3c9-4f88-d348-08dbff20a83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n5GpUJiJG8kDceqCi/xfCQf2YJ3wDEYJvLkSsYqP9U5UDpQxWm6QVjxq5/e5tJ2oHsYu/pLo+vcoHG8+RkIKgGjKpAIhJIW1DzXTWJNhqQf2XlbN0a7gN1SgVd0jUj5MtZBTFqtb2/8id33ssLyAbEo6ZdYvlic4SxTCUm6AAWJiot/I1nl5pKc0qH1E1nWYg6xqb/jGhHLaROMaVVZvsETYRLMBdSEuQvqk5zpU5jK1nUcCnC/ghFY6qiouQsBgXqrJVdYm7WtCvDIfa9Ivj3eOYFTbJZVFovsY2DLfsBLcZ50hNQ5KMChasB1uNzDFEsP/behAzA16a4e9ZXZTB643JDK3aFpl3k7MbZEy2UF0ijPCCaNEJdgbT3ed2CFiFGUiOeSCJWnzfW0q7l4Zvr3aC1ORELcwWKUNnwkLD658lE81EKrS4iMTYwJVCOaWPOtCZ3Ug+H/jx+Keu3EnuNxLNxowVgbuWz1j8lIfmxPBwdbvXuMnIZtkCWUkc5Lq32Km2pbIecYXUCXJBvQkFO/0uJ/GU4rZqtI923V/iyGQUr7MO+fxjrB16z4xwi8masa5HdPQ0cXLFWDmxRyaDvvuFcbdj5R5H9dJlygtWWyUdLfJEZKUGZvVSudB1pc7ZMBIx9eYlIdQ2DaxvM9QPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(8936002)(8676002)(5660300002)(44832011)(38100700002)(2906002)(53546011)(6512007)(6506007)(83380400001)(316002)(66556008)(66476007)(66946007)(41300700001)(86362001)(82960400001)(31686004)(478600001)(6486002)(26005)(31696002)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmMwZFdIWXZmVk9EU0NEZmswemtxRkhVVTZqcXRValFZMG9Uajh6VmVJeThG?=
 =?utf-8?B?YUQyWndvMm5yN0o3Y01CcTRNMnpVRzdVMU1HQXk4eHMrMGpIczRNV1U1aWxw?=
 =?utf-8?B?RG5JR3RmYUJWMTlNd29yTTdFQ0JpVG84aTdSUTE0dzV0enFjZGpSQzVCODJj?=
 =?utf-8?B?UFc3alEzMlJOY2x2cVJ6N1dhblpHbys2YWRINjl0ZFFRaTh2N3lNVGFOblBW?=
 =?utf-8?B?akxCRTk5ajhjRnM3cWdhOFVWM1Z6SEw1OFpqU3B4MCt2ZUZsbXNVd2NIUGN0?=
 =?utf-8?B?UkN3NFZBcnN0aDVJWTBYWm13bW9XSks0TzV1eVNnblVFVE1SMnU0STFMTUZY?=
 =?utf-8?B?L3ZmMHI1R1JwL012Y2ZBY0tQMDJWbTJsSXd3WjduN21ucHJubmE3VGpuVDlk?=
 =?utf-8?B?M0hkZ3RHc1pHRWFmN0V4cjRmN2lFK3N4VHVqWmdmbjNsVHNYcENWeWRzZElC?=
 =?utf-8?B?NU93bHZpdzU1czdKVkNZSmdBVGVqc0U0RzliUnNZaHI0ZW4wNG9BY0ZYcmlI?=
 =?utf-8?B?bWd4Tk9SbDk0OGNRNEJWeDVIeitMSk9meVJ0RldQekduYWowOGNRUER6djU5?=
 =?utf-8?B?MWlCbEIxNmlGWEdZMGpFQ0x5TWxFcXUwb2Jpbm9ESUpvbnFQU0pRQm1zcGlq?=
 =?utf-8?B?VkdQSnZ1L0lGNzBJM2pqU2JtdXErV0NOQ1pNeWY0MDY3N2pnamJJcFV1aGYx?=
 =?utf-8?B?djRRdGNJRTh0c0E3WXlpNnpXUjhzTXJ2aCs2dmZOdENWaEFkMXhJRVZCenNF?=
 =?utf-8?B?L1JmNitya3B3ejR5SjVpUWV1QWVKbDJJT0N5MHUyWWNZNzU0MnJ4RlJ4WXFj?=
 =?utf-8?B?Nm9DNmFpMi8zNEl1aG9Db0IzYmdUSFhQZHdiQk5DNEZ5TEh5aHNvUUJUQlZX?=
 =?utf-8?B?ZUlvaFpZd3EwSk5SQ3g4dGRyZXQ5cDkwdlUzZFNUdmNRT1hJZnRpb0ZQcjZn?=
 =?utf-8?B?VmF6SFB2czVrUjJpRkVSN3pwMnhZdWNTN3dxREU3djZoU0dhblVuall3SnY5?=
 =?utf-8?B?OTk4UGJQb3lBQkpodDJLQ243cVlCMTlSdzlneW9qK2thWEVtcGExTlJJRUNW?=
 =?utf-8?B?ZDJhMDE3QUJkWUFQcDVOM3dMeWpWNDVCOTcwMDVJdmlEd2hBRXcxSElnYXJP?=
 =?utf-8?B?NTBlYWhWYzRhTDUxcUVqak1YeXhYR0JCUzNnR29iQnlselBsU0Q1a2dtbi9K?=
 =?utf-8?B?U2RzcFBZNXNWMkdUUkt0UmRXa3pLRVdwcDUrMGFjRWZXTFNpMmpPTzBqNFh1?=
 =?utf-8?B?ZStuOGtVeEdhQ3cxRE1YMUdneTNaelp1d0NaWFZnK1RWUThSOW1pbUdSTjRm?=
 =?utf-8?B?Z2Vic0xNUlBwMDE5cTBCZk40TmEwL3FEOXR6RE9Ga2RPMFhOYmg4OWJSU3pJ?=
 =?utf-8?B?NUg4VFVXV01WVFZ6Y2JIQ2szYnRQQTh1aFdTVS9EeVZkMWlBdjNlbUQ5eGlI?=
 =?utf-8?B?UnJIejU2QzgrOUZJeTcxUHh3NVA5ZkpSSWliV1hnYTErb0x6WjV5TTZNYklU?=
 =?utf-8?B?RkgvVGliazlEU3hHMW5TRDErNjA4QnRqaVJqVkpZTFpraG4xbHcvdkZmQUcy?=
 =?utf-8?B?b1JKZjhRNlUrbTloT3MxekpnbmI5cElBWlRCRUdmRTRqenNKQ043c2kxWWlQ?=
 =?utf-8?B?TXd4Q2pmQTNVSGpIU3JJdU9hV3JTUndmS084dVRZNkl3aG9tSHZ6ZVI3NW1B?=
 =?utf-8?B?cUJPZ0tkckVQWUpkRlRLci9lNE9BVklZTmN0WE9LZmdjNmpTbmRpV2pqbFlJ?=
 =?utf-8?B?VjM5UGhxWkEzZ1RkOE9TZEt0cWdSUW5JVkVBMlNKVitHZkdzaStFM3VRcDVa?=
 =?utf-8?B?ckROQWQvaXFCZlpKeFduZzMwNkxTamx2c2ZWS2VUTTdHbWJMY2ZoNFdjdTRF?=
 =?utf-8?B?MFlHMzZrQmRuU1hDa3NTMklOc2JGS0NXN08ySklpSSsyU09IZlpkRndGTHlJ?=
 =?utf-8?B?UGtBNUhxQWM4b1RGOVdrcFA4SDE4MHVnV0svTkFiZGt1RUNkUkVkbVY5K3Bq?=
 =?utf-8?B?ODJUekNPMExsOWNzejZ0MmRtT29LLzRPb0pIczlXcllTZFlsNlF5bHh6NUhm?=
 =?utf-8?B?c3pGd3dlU2lwZlBDdXlSUEVKYytTNnBWaWNlaGNhSldySXBGRU9rT0lFUnlX?=
 =?utf-8?B?SEFsZERGUlJKVzBGMUp1cm91UUVEdkdXcVRHblpvbGN0M0JJN05ZbGhDTVVs?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25befe7a-e3c9-4f88-d348-08dbff20a83a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 16:53:13.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76+q9GXCv0Z49bawyvhuFvSqfGcgdFSylncb4j/aEy3vnqd8je9tK1VBVk6kLnjE3KrQPu4RHTzR9xgpuJyUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7062

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

libevl/ should go to recipes-xenomai/.

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
> +
> +  * generated by Isar
> +
> + -- Unknown maintainer <unknown@example.com>  Thu, 01 Jan 1970 01:00:00 +0000
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

Ok, that "(= 6.1+r0)" was likely the workaround for sbuild not updating
the pre-installed linux-libc-dev package with our self-built version.
Worked only for 6.1, failed for any other other EVL kernel.

I've sent a Isar patch that should resolve the issue, at least for x86.
We have more fundamental problems in Isar when it comes to using cross
linux-libc-dev.

Jan

> +
> +Package: libevl
> +Architecture: any
> +Depends:
> +Conflicts:
> +Description: install libevl related repositories
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

-- 
Siemens AG, Technology
Linux Expert Center

