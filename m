Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CD225AA
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KXi4jNqy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsD1l2+1yT+3aMfa+F2CiOilnJ6cI/MqVjp0kLMahxQohaehAsvCBwsmxXj7os+898nlGEWiZGWs/dhgpeE8tbkMSgdAoD5GwdGmjGDOPHOmlKmEPc+9UxxK5c+OsxWz/r3tmCmzt+VfExgt4bCkn8HU5gKguD7ZRzFuThmSN2Hpb88rbisp35DysPWKIdEJMbj7jMCziv/kT+0OILbWtoXMZ4dnn2P7AOvu7dlfGHFO7nZ4u6liKUYI9AC5Ugw7yOkS4eEdlY4klFZoEMGa/Vbhp/LT7XDSzdl51chxyJlujfIbvL2J1e9i63I08t76bZ4Yah5BP1jIjTuADZBbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ9ThKyojod6I83yZMM5Ix/8bxPZZ1iiNzHPupJxPws=;
 b=QTg8avXlvhvfdtM0WhxceALmnjIgMaG9PIrV8HAfPS5zEmg56KVZp1r3c6cN6qsaGi8c9kQ9cSd/ie5qV3HeOki2lP0xwkZAv3DLA67TKKT/D4ksY+lmmlCJ+AyBOikHQwKHpu75A/j5BKEax8c8yF5UcmYVjx5TP12hRLQ41iGE2wVDpdffFffwVtKKirtVIWcg5u+yAWe9Ezm7jn9tIWcE/aSChgZ1OYm85I7g8b6tT9x4todA4FjNTMbRqMojXZ/lJrnkB86CRwgkr6uzp8vITD1g7TLW6K2K2koKJLKzxKf31HcWgaqnGVccXh6ufKlzScaCwMOIPoiFfT4+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ9ThKyojod6I83yZMM5Ix/8bxPZZ1iiNzHPupJxPws=;
 b=KXi4jNqyQY84PASHzVJf74o4UvfR1w85iwaYgBkNN+fkCdJPeXEw1kN6hLxuYfMaY/dN/obDvNRljc0TzCqNq6fNvjvVRPnB8QYHgMYdx+UN5m5PRvrLaXuq7soNB6yGPeryfs2rw1hsceYFXXARsafXXsMFJaq8E1GOgjrnkrEo//3NyacKL/Iu2NxypP1Tnok0tqEog76QN8B0LZbn96zfqaTzLsinS8L7yWD+wtyPGg46ZHiYdu/sooHUgZGiD09DvanJMv2aXCz7LAqL3PvwJ9P3/x6LkPI3cgMAfG30KAKOm/hisR6koo7d086KrGPy61UzVhwimaUOEFPdmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8086.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 13:51:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 13:51:13 +0000
Message-ID: <2843f351-d3d2-435f-a306-8b027dc7bc4c@siemens.com>
Date: Thu, 4 Jan 2024 14:51:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 3/7] xenomai-4: Enable kernel build
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
 <20231221163743.2923801-4-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231221163743.2923801-4-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: a119ff31-4b0e-403c-198e-08dc0d2c3729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApWcSaYAnq4GKyq6pK4GlH4M+yrAH79T5FEU3uVByl/p3CRJ/if84CfGt8l4BBvp5ACk7phd2bMHzkUsGZNaLiSnJF/+kDtxP0vLZz82QoBY/4LbH+s5iifB+22IYF8/s447R/idlNZvoTrUTASr+S5mR4UOG9MhZsdpnx2u36KGTQ3hGw9brMuuNyZMOQ8hcTdJrkl6DO0K/scMYfdBrUfGXoSWNjv5jePl6+HrcNkJp/kGpEDQM8m8eFS9HrLynyUKHqBnTxevcfvcqCzIG/1Ekuaw5RWAf6EFLfBgo/5WHJp3ohko6+it7D8curslcx2U4izelD+NVTI+NW12aa6hd/brmIT6Q+11nYjwWzgrwQWyCW7zwVEOv1FztfI7TL4MjLosHOCUka9AVQh/ndmS+7SXwZCj+2O0QeAEvlPS1J0x3f8f4EMy8BWczKggZ1U78xPDyZSxCf24NZjErKw8Cc0D/d69PrB5yc8z6Riu6i7st2f3GK7nD1Xs5VOnrSlmGVGxCvFjbfF8ZkzNIcjLS8pSvBiGZgx3MjU3+o+dien9eDz5b1cJnW6iWGTvqN9x2VSuNk8f5pxNF018aIi4Wi1wgb7Y2bAqusNNoZ+DmaRPWJmhwckzEk8KGTaN254SAVnHNrSMMP6MGZ7MNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(2906002)(8936002)(8676002)(44832011)(36756003)(316002)(6486002)(66476007)(86362001)(5660300002)(478600001)(31696002)(6512007)(41300700001)(53546011)(6506007)(82960400001)(66556008)(26005)(2616005)(83380400001)(66946007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTN3dFdjdHpxRzkyMGxNSGk3M0g2L1dyemNLKzFGWXllR3phQmZiU3pjcWFy?=
 =?utf-8?B?c1VpSEFnUjRSejZ5OTF3SGZwSDNnL3JGbEgzWUdXQWlKNFBzOWI1RExYODhQ?=
 =?utf-8?B?cm9yNTBaUyt4Lzk5eDNsUy9TbXlPTExMd3BPeXVoaDZoRVFyTEZKVU1iRVVM?=
 =?utf-8?B?STJIVlpZeDZLUXN3QXdXbHZOWUpmUUMzUkE2dDl2dm9UNnpUQlZRenN3T3Ay?=
 =?utf-8?B?bjJoT1dOREYwclhwZ0NtQ2pNU3NTSGVLRVlyMGNMVUpJSkhaMS92ME1lVldX?=
 =?utf-8?B?K2JyVDIzemdaNUlLY0JJcmNFK0lOaUpTREMzSHJkaFpxVEJLUlI3c3luNWll?=
 =?utf-8?B?MGVYVG1kQlk5V3lZUFdCL2JDeTI1WmlsVW5jVWZ5OXdlM1hEOXFDVUVBZGRU?=
 =?utf-8?B?ZEQ4S0RkUDYrRnJRSnJaT25OTTUwMkI5eXlpZElCY05mMWtVM3RUN3kza3VV?=
 =?utf-8?B?K2NTYlA0alhiaU53d2tnSGE4VVRFeWN3NlFpc1I1MTZQNzkxcFZRaUVoVG9W?=
 =?utf-8?B?QXY0L25vT1h5SVFyS2U1dGw1SjIyNDduUmlnMGtiR25OVVdnamlIc2FOTE5I?=
 =?utf-8?B?UlFvcHZMVTdwZ0l4UEVPNFBFWTU5T0h1S29mMU9nK000dGVPbzZ6b2FiRVVa?=
 =?utf-8?B?ZlF2bkZVWTJMZW5iTnZ3bXpHSUlmVTJVclN1ZXkxNG9EYVExSmFOVVlZVkoy?=
 =?utf-8?B?WjhWRFNyK2NaMEQvUW5Hck81OXhLaGhPaUhUTFlzMmNNS05pbEtDcW0rMzlx?=
 =?utf-8?B?clZmTjl4ajlrVDFMbTViY0VCR0wxVE8wM2JIbVFJL0FyNGVxYmYwbXV4WThY?=
 =?utf-8?B?d0l5Y0VPcjIvS1ZRcFV3RFVCUUlWM0hyU1F2L2twS0dja3MzVXZhT2hKK1FL?=
 =?utf-8?B?YXdjRm5DOTV4eVBOQWlLZFlqbjZhdXEwb3ltMkhwNXpOcnpIUkg5QTlyRzda?=
 =?utf-8?B?ZU5aT3pwSDN4L21TZVdEUFNJMmdKbG1MRmJyOVRrdk80UUMzTjJJbzhFdVlo?=
 =?utf-8?B?Ym5jUjY4dVlEZk52Mm40NnVBV20vZFJOUW5WY2pTeUZVdUZzakZzQ1BLUTA1?=
 =?utf-8?B?a2V2SUJVZm40dVBBVEZ5eTNlaE4vOXB0NW9FNk1uTTBWMGhTekhPSUtNZ3Ro?=
 =?utf-8?B?Y1dHQzFidnRwUTU1K1FLRFo4RmhTcE1DK1l0RytjTElZTEt5NXpydnRiZXp6?=
 =?utf-8?B?cHNHK3ZRNy82Qzg3NUJreVNXcmxnTDdOMTc2aVIzL0lrRTR2ZDRtWlRaVXYx?=
 =?utf-8?B?Sm0zWjV6L3ZIT2pWVTBBemJEbU9JR2Z2Q3pZa01mR0EvVEhDTWk2SlQvL1Vz?=
 =?utf-8?B?SUJLWEM3STArMFo5NzFlUVEwY2NYMkZBVE5KZnFubzRNUW9jeHhvTE9obXds?=
 =?utf-8?B?bUpndWJXZ2J4NGJGV2QyVDdPY0FYZXg0VGlVYjE3VE9ZcnRPUXg3dGptRWhv?=
 =?utf-8?B?T2RuejByQW5yb0FxTU5IdlNjTFdZMjdMQ2dEUzlIeDM2TVM4WW41VkhkRStx?=
 =?utf-8?B?b2hBVWRtNStWZjBlM3g1ZjJSRTNQZlBXZE4ycWkxRWRpbGNkRnoxTjQxaWJW?=
 =?utf-8?B?L3NzcU16VzlSazNuWUEyV2JYdzNTeUxnT2lqNlpidE1BZ3NzL0dmUHR6cCtC?=
 =?utf-8?B?L3A0QlR5Y1RhZU5vV0NRZ0UvLzFUaklrQWVKdm5MNnZKK2ZWZ1Q0VFV6TlV5?=
 =?utf-8?B?N2FKSXhURThlMVdOa2FMNGY0WGxjN0ZxaWVqRWNsdHJSbm5FcE8vTm1NemdZ?=
 =?utf-8?B?SlhYMktNOHhPaHpGVkNWMXBVaVJGWDhKTDBBTUdCZkJybExvVC9MdmxuMTRo?=
 =?utf-8?B?ZEpqR3BEcXg3dVB4aG9zbjk5eHY2cU11aDVBVGI4ZEg5NUR3QU1ObzUwNXVK?=
 =?utf-8?B?VUx0a0NIcVd5WjdiVmZoS21MNldwRDNaNm5jL3lxL3RKcUNlcFRaTEdIenRP?=
 =?utf-8?B?NkdpRGF2blFZajMrRXEwQ1kvdmxVcDQrdEN4VHVKcjdkVWNBUER2a20zbWtW?=
 =?utf-8?B?ek12cnJBS3o5VFFINnJGUHliYkI1QnhIWFFLWUhPNVMvVjdpWDA1MXRtektY?=
 =?utf-8?B?aTVRWVdJSG1Sd2o1VFd1V2VtenZaSjNOV0E5KzA1bXZmTW9ZcEZDVzlqVXpD?=
 =?utf-8?B?NjJ2MzhpZVo3VDE3YkIvSkRVWGxIVUYyUFRyYlM0ci82VDhFSFVHc3BBQ1pN?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a119ff31-4b0e-403c-198e-08dc0d2c3729
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:51:13.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrDkhpKj6EskXNtZMXJ6TbZ2QvGFxxmAUoG1X0NyfwCvt8i4TrJiePvDEmO5mGhvKYLTMtVnbCNf2oIRCO94Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8086

On 21.12.23 17:37, Clara Kowalsky wrote:
> This permits to build the linux-evl kernel v6.1 and v6.6.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  conf/distro/xenomai-demo.conf               |  1 +
>  opt-xen4-linux-latest-6.1.yml               | 18 ++++++++++++++++
>  opt-xen4-linux-latest-6.6.yml               | 18 ++++++++++++++++
>  recipes-kernel/linux/files/xen4.cfg         |  3 +++
>  recipes-kernel/linux/linux-xenomai-4.inc    | 24 +++++++++++++++++++++
>  recipes-kernel/linux/linux-xenomai-4_6.1.bb | 14 ++++++++++++
>  recipes-kernel/linux/linux-xenomai-4_6.6.bb | 14 ++++++++++++
>  7 files changed, 92 insertions(+)
>  create mode 100644 opt-xen4-linux-latest-6.1.yml
>  create mode 100644 opt-xen4-linux-latest-6.6.yml
>  create mode 100644 recipes-kernel/linux/files/xen4.cfg
>  create mode 100644 recipes-kernel/linux/linux-xenomai-4.inc
>  create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.1.bb
>  create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.6.bb
> 
> diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
> index d96cdaf..db5a5df 100644
> --- a/conf/distro/xenomai-demo.conf
> +++ b/conf/distro/xenomai-demo.conf
> @@ -17,6 +17,7 @@ include conf/distro/include/xenomai-version.inc
>  HOST_DISTRO ?= "debian-bookworm"
>  
>  KERNEL_NAME:xenomai3 = "xenomai-3"
> +KERNEL_NAME:xenomai4 = "xenomai-4"
>  
>  WKS_FILE = "${MACHINE}.wks"
>  
> diff --git a/opt-xen4-linux-latest-6.1.yml b/opt-xen4-linux-latest-6.1.yml
> new file mode 100644
> index 0000000..a71cf92
> --- /dev/null
> +++ b/opt-xen4-linux-latest-6.1.yml
> @@ -0,0 +1,18 @@
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
> +  linux-xenomai-version: |
> +    PREFERRED_VERSION_linux-xenomai-4 = "6.1"
> +    LATEST_GIT_BRANCH = "6.1"
> diff --git a/opt-xen4-linux-latest-6.6.yml b/opt-xen4-linux-latest-6.6.yml
> new file mode 100644
> index 0000000..5710222
> --- /dev/null
> +++ b/opt-xen4-linux-latest-6.6.yml
> @@ -0,0 +1,18 @@
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
> +  linux-xenomai-version: |
> +    PREFERRED_VERSION_linux-xenomai-4 = "6.6"
> +    LATEST_GIT_BRANCH = "6.6"
> diff --git a/recipes-kernel/linux/files/xen4.cfg b/recipes-kernel/linux/files/xen4.cfg
> new file mode 100644
> index 0000000..0460249
> --- /dev/null
> +++ b/recipes-kernel/linux/files/xen4.cfg
> @@ -0,0 +1,3 @@
> +CONFIG_EVL=y
> +CONFIG_EVL_SCHED_QUOTA=y
> +CONFIG_EVL_SCHED_TP=y
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-xenomai-4.inc b/recipes-kernel/linux/linux-xenomai-4.inc
> new file mode 100644
> index 0000000..d91d618
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-xenomai-4.inc
> @@ -0,0 +1,24 @@
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
> +require recipes-kernel/linux/linux-xenomai.inc
> +
> +KERNEL_LIBC_DEV_DEPLOY = "1"
> +
> +SRC_URI += "file://xen4.cfg"
> +
> +SRC_URI += "git://source.denx.de/Xenomai/xenomai4/linux-evl.git;protocol=https;nobranch=1"
> +PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
> +
> +dpkg_runbuild:prepend() {
> +    bbplain $(printf "linux-xenomai-4-%s: Building revision %.20s\n" \
> +                     ${PV} ${LINUX_COMMIT})
> +}
> diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
> new file mode 100644
> index 0000000..89683dc
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
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
> +require recipes-kernel/linux/linux-xenomai-4.inc
> +
> +SRCREV ?= "v6.1.y-evl-rebase"
> diff --git a/recipes-kernel/linux/linux-xenomai-4_6.6.bb b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
> new file mode 100644
> index 0000000..0ce145e
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-xenomai-4_6.6.bb
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
> +require recipes-kernel/linux/linux-xenomai-4.inc
> +
> +SRCREV ?= "v6.6-evl-rebase"

This is v6.6.y-evl-rebase by now.

But we should rather introduce a linux-xenomai-4_latest.bb to track the
tree heads and reference a concrete release here and in
linux-xenomai-4_6.1.bb, just like we do for xenomai 3.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

