Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A884184B
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rvMVRJMx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0nSnUMm0Z4BXyDqOKOojPeQW7p0eVGsotwb3azJApf0zrbJ+ys8b9iT4qcVStUz+n1wusvBzW+gl8mzbSEQ+QMnVB72UnoXL7DWzJ2jzzSKqzHCZ0ApSpGZqRGBxD7BvWybjbQuhbo1Am0XLdrWuDkfEsjUmwQI62u96L6bs9X86mnfeTMo8AR7L0NmnZCrTtwTiEUOG+YUl+oFIhBY1Gk/AfZLzs62/yMDd6pk7k/rJh3Cejv5lOLlLH5zIhqFdNa/Lbm9JnITXM87SzCumMwveBnCXsyRI3Wpu9uw/55p/Y1qdORa6OEB8ypT3t6KSc0eWGjT7mxWgdm4mKLhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfQ1C8m7g+4GrLYx32+milCSyfzfmVAEJyj70NX2E7w=;
 b=WLz2slTEal/IJiPhwdzSV3TZdRLA9fxdonb/P+WuUo/rvlTWhmclFBXPBjhNMs3cB/K/nWtAwL1oGlLZpK4cf3oMsC7AazhwWkNtHqqhlzI1vlwUJ8AB12ML+n3IVOSaDrOlihnxEdv6THialrYybALWZ+wsLHVw+ksI9lHvBQRD3LmgQrlkOp0eXuhksPQ+KGuDV4bV3jiPEWQbxtrdsVQhOIdXYN2CcZZcbF0dNpgmXq2DNnEJpETyV20nsF80GnG6n+0gp/cAhGm/MsZn+670SjGmIVKoKS9t3JydyJJLQB/xpJMeoz16fZzukx+XYb3c4iqCTulurjOAtpWh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfQ1C8m7g+4GrLYx32+milCSyfzfmVAEJyj70NX2E7w=;
 b=rvMVRJMxWxclj31Ns3adFgxM26/nQqirshgTcdd8X3KGP1tnkt1kF5TCDUiv3Oo2b16w3genApOld9e9pvNY1BucgtjgW/ovcCJga+gdYQ4bN5z8HAkZ5DdAiGabHjXx7EyBVqqhg+4V1tXEncegdIM38Gzoe64JbOGi9DqInCEUa7uRUevPlHqmB4atR1bvNvV5UsxyGK5yxZrSP6nhZFkKmA9gZ3hNvYqMuUP9NmMQ/JRDfC/lrHgTVptogcTK34h/vFIZKUjnsUO+LACfP40HvJK/7qUz6XXWyGbsMIFXGICk5YFl4aJYrXHA7uodU1orJo7M1cLO4K/uEJACbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Fri, 15 Dec
 2023 17:49:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:49:47 +0000
Message-ID: <d33682bb-c94b-43f4-abe3-9cc00c40037e@siemens.com>
Date: Fri, 15 Dec 2023 18:49:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v1 3/5] evl: Enable evl image build
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
 <20231215114349.2913803-4-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231215114349.2913803-4-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 361b7283-237c-4061-6741-08dbfd963a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WyaGZ/6T/orNQ4DivM6PB6bzjh6lGcLt+2jPgOLTsKleHrEuJ6wAga3MoOhsCG6HYGPyRyBn3PyUevOtk9aAtF8AssrkuoMZgmgk6s1cdpS/ZgN96FPywQbJeLNFWKZq/p7AX3zowNwCGbmB45DNsXyljhZP7h2sOE3c0sCdsKdYfBd+S5WYTR+g0kpMkmI4podiPJphLXZb8t2bB/s5ANqXw1x4vWaQf/qv29dzNPUnp9if0+OSvBzs7H4hoOmoiVFx931U+AY2O7t1j831RTyuqfO1tILppgkMKmIcXrQ2d/VVe8qZOzCjyeR4kUElZsPNqwzKOALia36168XgvMVSjuq7OyPWrEFOfdbljnQ4wRA6Uz7QlOZZL5J9kLEEUJBv1nQNSGyL/Ln9tRScFZb3Qi5tAvQD/JgHw00vRehyVEAkL0ia6Tci+n9DrLYa41R8+TWzUmsHSJupzdCOzyUwPBraGh52tabaI7PR2pWSs1EENnDAKWropsMmYdQer7z67c4TnMvwCFZhPRKx8ksJ3B7Or75UhPNP4vR7G5en4vEOuoKH6sIZIWtDCkyOJXAciL5mJwslgA2BFY13FxxT6TSrYi1QU5nOcLrJp4LvylE/cGEtfidyYMT0UDrc7B0Veql11Sgxvtug/7km6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(44832011)(6486002)(66556008)(66476007)(8676002)(66946007)(316002)(478600001)(83380400001)(6506007)(53546011)(6512007)(2616005)(8936002)(2906002)(5660300002)(41300700001)(26005)(36756003)(82960400001)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWljbnVqY3RZWTlQTEU4a2lzeXE2QVZiT3FHakd5WldHR2MxZk1FZzlGM29M?=
 =?utf-8?B?a0hZdW5STkVPNUtTUkYweldua1ljQ3ZuUXpkLy81MzVZWTZvdDQxcWFhTWZh?=
 =?utf-8?B?V1NFZUtOMTNoMUVJT3NTQ2ZtRXJQQWt5Q3RIWUdmcUEyclY5d2lxM3VsOUlD?=
 =?utf-8?B?MG1lcnVMNVpTL0JYOTJYb3JmQ2ZEZHd3MXVIZXRiQThib051S0lUTm5aQ0xl?=
 =?utf-8?B?eHRXNHlSbnExd3FWSmIvQjdVWVcvdTcvU3kzTUg0bnZjT1o0WmFwYTI5QllG?=
 =?utf-8?B?MGxkOGplWUgwaHVpOS9JV0h1R3Fybk12cUFYNEdmS3BoYUk2YjdNalFFbVlr?=
 =?utf-8?B?aC85NzZuNStRcjVKN0ZKckcvaEplMVl3U01DaENHQmdMaWZCVC80bkRKUG9W?=
 =?utf-8?B?dy9XclR0cFA2U1oxQnJucUtYMEZhNzZ5RjFORGVadS9mMWIvb1p2Y3pYUDBM?=
 =?utf-8?B?VUxUdXYvekpmZlYrWlI4N3J3TUtuaWxRdWxTNjNwbDZLRy81NVZmQ2JneHEv?=
 =?utf-8?B?enJJWUZsR0RFRmdyVkRDY3ZvWFlNQUlXZmExSGRudWpkaCt0bWZyZTVLSTFJ?=
 =?utf-8?B?WVpCNjViVWtPaEtuQnk4U2VYOWY0L3dIaWswem5LWEExNzlVZ240NktZZFdu?=
 =?utf-8?B?ODdIU1dHTEgyemUvNmQyNnVPcTh0ZUl1UmhRK3lYaGhGUGpQR3BIS3laREdp?=
 =?utf-8?B?amIrai9qbnRSVnhwZ1JPZklnUnNlTklBclRVM1J0T2plK0N1KzN1OUloOUtN?=
 =?utf-8?B?U3JPZG5tK1E3ejlNdHJPOWFXV2p3M3dJeEorSVUwR3pTWitjN3p3ME1zS0p1?=
 =?utf-8?B?SGhJVExBZzZWTE0vNFFiY0tpVnpEOXpTQmdtcXFyNlN4L0NaNWk0RldxQm4y?=
 =?utf-8?B?UTVSbVN1TGJUUGtkaEVuN2tDbXJ6bkVQSXhtbGhwYnZwd0ROdmJxNmJ0SFV0?=
 =?utf-8?B?cDh1dUNSY1diZ0VwWUtJYzFMODBHSDl6TGVoR3JKL3paQXRkTzZwVzluUTVZ?=
 =?utf-8?B?aWxHZWVDLzhGMFBPbWlPei8xUGhqYzFPa09kclFzV09FWnRkT2VoV0NvbGQ1?=
 =?utf-8?B?K24walBvUVlLeEl1TlFUNDVlTTg5a1BSZk1jK0xpMzFLVHpyZUp5QnY3UmZ4?=
 =?utf-8?B?bzBVYmM2bnJWS0hXQk00czNQcHpReDNWdWNkcktkOHRXMEtwcTBZZFRMdjJY?=
 =?utf-8?B?WHhwbC9FLy9ickRCY2ZZZmxHWDV2ZGtyL0oySlBzVmlWZTNNdHk5bGZIS2Jx?=
 =?utf-8?B?R2dyazhjRnhieXJvVjZpMDhIWEhvbVJqaE5JSFR0cko2aENKaEpZb2czM0hT?=
 =?utf-8?B?WVQ3ZG9rSE1aNnl4d1k1TVp4Vlg3Z05DVUt0OGZTbCtNcWE1TUVpR29uY0Z0?=
 =?utf-8?B?eWhRWnpRbi9IMUtueVNoMXVoWXdYRk9tSi9CeDU0TGM2NlF0RHFZTE41VnFW?=
 =?utf-8?B?Y2djZ0pLZWMwY2NIYTdKZ1lUMk9QNjlwc3FyOXRUVi9PQVNFaDRBSkMrcTcr?=
 =?utf-8?B?SzZ3VFdXdjFaUDFmQXkzeGNwMk5Bd0QwaGVINENteXIvOHo2SW1lMHhzbVJE?=
 =?utf-8?B?d09BSXVHU2FzdjJaRGRTVno3aTIyaVROZXNhNFVhMmJUU3BsMVlxTitFRGJ6?=
 =?utf-8?B?aTJHcXllU3F6Rkl4Nm80V0lZalhtVkl3dUxFT0FFQjBUdHlzM1pwNXNOMmgw?=
 =?utf-8?B?Vm55c3p3WklpTEQzOU56QVROdzhZOHdJSUhEZmR5K0FjZkRFSUowYldtZmZn?=
 =?utf-8?B?VHpSNlpJZkhGbmVVeVBjT2JzVFBtNElTUzBSNlhoOWlvVmh4YWZPUVVNU0Ju?=
 =?utf-8?B?ajBnc3JMTVNrTkRNQkJzL2VFYlRVaVl2WEZVaEMwbFhETHdLNGEzUDM2K0Zv?=
 =?utf-8?B?VmFGRSsySk43d0x3a1M1VmVNbjZpOXN2bFc2dWdUL1hIWFhZb252bkJWdndD?=
 =?utf-8?B?NXkwUURtWXMvSDZ0RnJlZWF6Wk5rN1AxMHd5d1VRUDdrZ2xwVCtSOHQ2Tlg5?=
 =?utf-8?B?ZWZSL0E4Qzg1VXBScW9YcXRDNTlpWEtEYmRJb0thakpjdk4rSGhDZlk0Vngy?=
 =?utf-8?B?SG84b1luZ3J3SHgrK3Vpd2FSWWtzaFlZQVhrTHhhMm84TEh3bVRwc3E1NkZ0?=
 =?utf-8?B?UmthZS9LaVZOdldJS0dXeE45d0dWSHBCK2NxUVZnR3habnYvb1pzck5wNFdq?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361b7283-237c-4061-6741-08dbfd963a72
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:49:47.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQIDb8P3N0JbIb5qq3feLRCNB7PAJB2BkYf4EBLOne6CWIy3D3Gbji8YwxdGtPLFl8+9gGZUV1cosn3oeOidfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6209

On 15.12.23 12:43, Clara Kowalsky wrote:
> This permits to build the linux-evl kernel v6.1 and v6.6 together with the libevl
> userspace.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  conf/distro/evl-demo.conf                     |    16 +
>  opt-linuxevl-latest-6.1.yml                   |    21 +
>  opt-linuxevl-latest-6.6.yml                   |    21 +
>  recipes-core/images/evl-image.bb              |    18 +
>  .../linux/files/evl_amd64_defconfig           | 10618 ++++++++++++++++
>  recipes-kernel/linux/linux-evl.inc            |    23 +
>  recipes-kernel/linux/linux-evl_6.1.bb         |    14 +
>  recipes-kernel/linux/linux-evl_6.6.bb         |    14 +
>  8 files changed, 10745 insertions(+)
>  create mode 100644 conf/distro/evl-demo.conf
>  create mode 100644 opt-linuxevl-latest-6.1.yml
>  create mode 100644 opt-linuxevl-latest-6.6.yml
>  create mode 100644 recipes-core/images/evl-image.bb
>  create mode 100644 recipes-kernel/linux/files/evl_amd64_defconfig
>  create mode 100644 recipes-kernel/linux/linux-evl.inc
>  create mode 100644 recipes-kernel/linux/linux-evl_6.1.bb
>  create mode 100644 recipes-kernel/linux/linux-evl_6.6.bb
> 
> diff --git a/conf/distro/evl-demo.conf b/conf/distro/evl-demo.conf
> new file mode 100644
> index 0000000..297ce74
> --- /dev/null
> +++ b/conf/distro/evl-demo.conf
> @@ -0,0 +1,16 @@
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
> +require conf/distro/xenomai-demo.conf
> +
> +PREFERRED_VERSION_xenomai = ""

Why was that needed? But it may look different anyway when going back to
a single image, possibly also a single distro conf.

> +
> +KERNEL_NAME = "evl"

KERNEL_NAME:xenomai3 = "..."
KERNEL_NAME:xenomai4 = "..."

> \ No newline at end of file
> diff --git a/opt-linuxevl-latest-6.1.yml b/opt-linuxevl-latest-6.1.yml
> new file mode 100644
> index 0000000..cd284fa
> --- /dev/null
> +++ b/opt-linuxevl-latest-6.1.yml

We should try to to reuse existing option files, just by appending the
needed variables to them. Will make it easier for users.

> @@ -0,0 +1,21 @@
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
> +distro: evl-demo
> +target: evl-image
> +
> +local_conf_header:
> +  linux-evl-version: |
> +    PREFERRED_VERSION_linux-evl = "6.1"
> +    LATEST_GIT_BRANCH = "6.1"
> diff --git a/opt-linuxevl-latest-6.6.yml b/opt-linuxevl-latest-6.6.yml
> new file mode 100644
> index 0000000..1e5eca2
> --- /dev/null
> +++ b/opt-linuxevl-latest-6.6.yml
> @@ -0,0 +1,21 @@
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
> +distro: evl-demo
> +target: evl-image
> +
> +local_conf_header:
> +  linux-evl-version: |
> +    PREFERRED_VERSION_linux-evl = "6.6"
> +    LATEST_GIT_BRANCH = "6.6"
> diff --git a/recipes-core/images/evl-image.bb b/recipes-core/images/evl-image.bb
> new file mode 100644
> index 0000000..8b571d1
> --- /dev/null
> +++ b/recipes-core/images/evl-image.bb
> @@ -0,0 +1,18 @@
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
> +inherit image
> +
> +require base.inc
> +
> +DESCRIPTION = "EVL demo and test image"
> +
> +IMAGE_INSTALL += "libevl"
> diff --git a/recipes-kernel/linux/files/evl_amd64_defconfig b/recipes-kernel/linux/files/evl_amd64_defconfig
> new file mode 100644
> index 0000000..760a979
> --- /dev/null
> +++ b/recipes-kernel/linux/files/evl_amd64_defconfig

Can we build on top of the existing defconfig, just appending the
EVL-specific options via a config snippet (or possibly disabling the
Xenomai 3 bits there)? I don't think the base configuration should
differ a lot.

[snip]

> diff --git a/recipes-kernel/linux/linux-evl.inc b/recipes-kernel/linux/linux-evl.inc
> new file mode 100644
> index 0000000..96b3c02
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-evl.inc
> @@ -0,0 +1,23 @@
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
> +require recipes-kernel/linux/base.inc
> +
> +XENOMAI_DEFCONFIG = "evl_${DISTRO_ARCH}_defconfig"
> +KERNEL_LIBC_DEV_DEPLOY = "1"
> +
> +SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;nobranch=1"
> +PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
> +
> +dpkg_runbuild:prepend() {
> +    bbplain $(printf "linux-evl-%s: Building revision %.20s\n" \
> +                     ${PV} ${LINUX_COMMIT})
> +}
> diff --git a/recipes-kernel/linux/linux-evl_6.1.bb b/recipes-kernel/linux/linux-evl_6.1.bb
> new file mode 100644
> index 0000000..fc3f697
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-evl_6.1.bb
> @@ -0,0 +1,14 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2021-2023
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-kernel/linux/linux-evl.inc
> +
> +SRCREV ?= "v6.1.y-evl-rebase"
> diff --git a/recipes-kernel/linux/linux-evl_6.6.bb b/recipes-kernel/linux/linux-evl_6.6.bb
> new file mode 100644
> index 0000000..d0653d9
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-evl_6.6.bb
> @@ -0,0 +1,14 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2021-2023
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-kernel/linux/linux-evl.inc
> +
> +SRCREV ?= "v6.6-evl-rebase"

Jan

-- 
Siemens AG, Technology
Linux Expert Center

