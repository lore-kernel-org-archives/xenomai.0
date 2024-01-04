Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56AF2231D
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hqU3Kz6U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnvJ9za6OG0iUPKRlLt9hau1BC+Va/EnCUH7npO+qOpzU9w+HJENrxYjBM8R/qu/ECiZh4sAcNMuDDvIr+EKeAxjunXkk0x2S73IjK69uYQLZGWbIBVMpt+QWUPtSvamJtbDEEhF1ziJzAT3rJWGZRIVIMnBI/Ws1ksBTcNSAicjnOSeH4RpftKPl2QPK0zJt5U+eYof9Pn0S7yJg7uaYDJ9b66DDiPqGOQVKmJSYqSZpGcMU8Px8vMlE3Naaw2+zpiDz1795qt38ezNVdFCBCzRtj8casDIgnTGTJrGQUmtODjQAvyC0eE08zhrd2d3v+HOLDGT0RkduvtFl3klNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKFvaznWbk8yDvoQYGF1RvEzVl1YVFaXfZ15zT+EaIA=;
 b=JHxjpCAq7FkvzRHwvTKcHo/a+FdMfOybOi2wyarDEeCcJ7bfXY9GCmRXEs4M7S5F+JlW7WCXJsL5tf9VYw4kB5/6/K0nkVY2RNuiv2IL2kN6OuKtOK2zflGskBqnhKdjjieUOvDbXOA6vyz/KteB0/q2PSAJEZzXz2KTRIQZgVxvEj8QcH3uQVBAFAtMpixfrC6vG7MnqhI0L0uyneSMeFFsRRqN+jLcDBM/V1HA1ZGg8EN9mIyCzGnYteFvH7tjTo3HUmb2AnEBeagA04t7EtBVQvBlPZCc9eeM73K8WUSjsIGKVM2GNLWYyPftDjLVMMhO1RHToj0vCQb1OPX4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKFvaznWbk8yDvoQYGF1RvEzVl1YVFaXfZ15zT+EaIA=;
 b=hqU3Kz6UFon8PrNG/IqbaIITbPZjZYVOBSYGXzoD2F/P+6prwq6EWGEjR9ABDW6c6OLjZ1BIepTdUrNOWIP3Bk0CDrngux+iAtj4imm3UzJxDj9RFuFrKNkrtzUrc3ZqB4r4AQ3adCMO8i9Px7kN29/4Dutroi0cCPxYOfwdHqr+qEGQAr/9fTvPa3r4ACSaf4TQUvgXlTG2q72wNQ7oP89ENwGZSwTq5IMGK34oLZqCO8Vcep2hxebMJcAxxBIk1GbjYeJ9qBt+2Vv9vabBDz2Qy4jsP8Gm9zGeU6Rq7ZcvyLSDnbFsOLY+670H2BCMNB0h16V3dcYAjJeIhiWotA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7462.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 12:40:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:40:12 +0000
Message-ID: <5fa6714c-4c81-4d09-909a-7f1ced7634be@siemens.com>
Date: Thu, 4 Jan 2024 13:40:11 +0100
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
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: e96738d9-3f1a-48de-ccba-08dc0d224b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2/HZhrQWZXn5T9ZFzwQWZR72cbxtwG8g7L6Xxzd7Aryu4kBkFHQLPup1yi6j4U20JmbtGbTieffaO3GmTWl8QSaKFPB4jufIwZkF5T7qNTKBXaLFihEgeJRDh+SOYX4NHK7nG8QammWKvXSk86qIIYxl5AZz8u0mPZ2w7im0h3R+glGKinqHuixeaB+6DyiaLqzqtkllZ28RQPn9XkS8tC+KHiZ9LwwTZV+j88SZTwVtVxQxuvOmx53nwa39pgsPfm67/o5zuE/xlvbIZ3Q49ahkXG4agcWvwwrfN/n7+4jSAs+pXXkBErdfAD3I1zoC+Z4Jpq9nQUS0UhuXh82wgvxVyO9xgx0CcHB65F7pkTGvU9U1o7dsokRvbrprsVw+9oMuZf4JEPpizZuLk2wpJwT91p30/OEPun2TpMD/zUkNE761ghLq66vW8t5jzM8ZMW0QgrvT+zV40qJH/LYXBmDB35rcnE4UeFNXIB6L5AWSYZxeFojtDdgRVh8G525ve59wKa6uCCp2wAgsfFmZwB8h4XtJm93JomRWHIPB4MvEuLFRTc3WJh2apHOw1SMZRVr4V/CIsaUbWAPWhCOVLC2AA5E8nfIB+ypuurRLpHi/om8wWZ1LKpv3AHgh/GOjQDZrJOWLbpDE8SrQ/bDUmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(2906002)(8676002)(8936002)(44832011)(66476007)(6486002)(36756003)(86362001)(316002)(5660300002)(478600001)(31696002)(41300700001)(6512007)(53546011)(6506007)(82960400001)(26005)(2616005)(83380400001)(66556008)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzhYRlJ1T2lkNjl4MnNXcmY2SCtEaGg1VjI2ZmhwNHI4VHNkMGpRa3oxdkNa?=
 =?utf-8?B?T2xqQ0VrRFBKc3lzT0tNVTljUExHbytmaUxJM3lIV1hwZXdrTjZKK3JJdXQ3?=
 =?utf-8?B?RjF3T2p4MHV2ajU2TjFCOEg3VHJjbTJEVDFhcFZKemw3eWVobWQ4SGg5dE9j?=
 =?utf-8?B?L3A1VVZQZDE0QUU0V05MMHhGTUdYaU8yYjRFbnRWS0lIb2RQdGhLSHhBRHo1?=
 =?utf-8?B?aWhYbHFZRGN3ZGhzUXdSaGkyME5CSzBZU3M3WGdOZktKNkx1aVdqRC8wWDdK?=
 =?utf-8?B?YldMZmtPNWwzOXhlSWw2RzVxcVhVbXkrSUNYKzFnOVZVYXFybVMvdWNZYUZi?=
 =?utf-8?B?N3J4ZjJhcUJ4QlBRcmhRM1N0NFRwSzdMeE1PWWkrcC9vTnZ1elE1MjlRblRK?=
 =?utf-8?B?b3pYaDg3NDI5S2pvRzUxdjgxUUczYmVPQmcyV2J0eThKKzdaNjhUVkdicTlF?=
 =?utf-8?B?TzJvRDNYeEtxK241UEZhTUNMSlBFZWJuTUNoSk80N21UeE9rYS9pTDZIM3p4?=
 =?utf-8?B?aThNVEhoV1ZVUUFVV21PTzVueWQzVmN6VmlSbFpaUXFIUFAzWFJUTXkwTzA3?=
 =?utf-8?B?Q0NGN0tuUlVmUjJmRzFMb2xVU09SYmNJVE1jZ25lQjVzYTN1TEc1OXQrN1dT?=
 =?utf-8?B?cDNUNmY1ZmNFc2ovS0l5WmZ2YmZHQ2c4b2poZEVOVUtCT2t0c1E1TTRhRldt?=
 =?utf-8?B?dGJhMndVeUhyblpyQVRtZzRnMStIMkZmR0RLbmd3ZzFwNDZpRkhMNkIwQkE1?=
 =?utf-8?B?bjZHQkZVYnVXeGV4Zk9lUmdLbGx0RC8xelFjQkJEVTNqRDYvTS9ucFZ6UjFC?=
 =?utf-8?B?NXM4TXlMeUtqTE5ZdlFBN2dqTjlhK0JHTGRWM1craHF2ZFpnU0M4bll4VzV0?=
 =?utf-8?B?THdrR29pOG9uc0hLQjBaSnpYbkErSU8zRjFVRDVJNEU5TUZZMzRCc3c3bjE5?=
 =?utf-8?B?MWhiSEVQamdWdFN1QmIxUkNMR0oyMWFHMzcwdzRQYlJsNUFFTTkxR0R2T0RQ?=
 =?utf-8?B?Z25HL0x1T2lhY3QwN2Z6dVdIQUZEd05jY01NUnlORmRvQ1hCYmFlREU3ODAx?=
 =?utf-8?B?M0RuTjIzYldjM2VVK1RUaDV2OVpnaDFXakZvUE02blJ0VjJjYzh0YWV4ZDdC?=
 =?utf-8?B?bCtqUTVuZXVKMFo0Z3pvbFpQS2FKRU5XOWdRWVA0OGx0U0UrNjR1Rkc5dzhP?=
 =?utf-8?B?VktDUzllbTBoUFVqekFhT0NvNVBWc3VUWWRxWGkyUXBMQU9JcXQyNTVLcldo?=
 =?utf-8?B?anFJbjIvZ21hODFabm9jNDR2ZWVUQUhZR25MaW1KN0x6ZktESGVPeExjYis3?=
 =?utf-8?B?cmZsRVh6ZFROTzFZekpmMlpnVi82SjkyWWtGSGtvenlNSUxJRDNiTXN6dzRj?=
 =?utf-8?B?VDhoY2pQMHNVTUNjS2YzUU9wQjdyeHVMNXErdVRXQmlpN0ovZlhXNGhReEFU?=
 =?utf-8?B?UFZnRlNmSytReEIxN0NCeDREb2JvZ3lPa0Y4RFpUS1dnQjc3ZE1IMFYzRytj?=
 =?utf-8?B?UFYzNG1icU1oQjRJZ1Q2eVRRV1I4c0hhNW5VNUwxY2tFU21jNmJHb01Ucmow?=
 =?utf-8?B?VGVxY2dQV0JqQjh4bnNIUWdvK01SeitWZWtVbkZIOHhjL0gvbDh1VmNGd1k1?=
 =?utf-8?B?L1JkWEJNQ3FNR0VnZVppVWNMb3ZCSGhWNFlGSDhVT3ZqTFNtbzhZSUx1Wlgv?=
 =?utf-8?B?WjhPajRwQThGb2QrSEp3VlJYVUx1aEdpQnRjTGt5YkZpY2JPbng1T1QzTzky?=
 =?utf-8?B?aU1UT3RGaDI3NDdZZE4zY1A5Zk5QMWcyRlZoSVA3QWlaZW41MjNQcGs0V01S?=
 =?utf-8?B?SnVRRVBIODVUMkNnbUwwT1NKRTFxTVlpb296M0tnS0lrS3lJT25QTmI1bUFq?=
 =?utf-8?B?TWV4bmw5N0JQb1JESm1FbEpDQ3RuN1BtZ0Q3VXVxUnUrRGVwQWNZRmlyNG9U?=
 =?utf-8?B?QkV2YXArL2lsQngvRmVadzZpdHErRUdxTlh3ak5YdFN5akp5M1luRnpMa0hG?=
 =?utf-8?B?a29EQlJZK00yeVF1WGhJRTA4VmpXWndRQm1xQW9XK0FUUXptTlVweUI3U3hw?=
 =?utf-8?B?OHJ0VTFqcnJnOVArTVlWSmJLVFhMaUYveGNVL0NiM0xFUTZlejR1K1dOSmFT?=
 =?utf-8?B?VHpURlc3NThwbjdrZ2MwMHRtamtiRnRUMEp5elV1eHJsYnVHZGZqZXlzQi9N?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96738d9-3f1a-48de-ccba-08dc0d224b36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:40:12.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUy1O4x9T6uFSdUIxVv4PaQN6gcTathXaOctIKQPX+zF/wo0l0HGQ3cKFAGdBBgSyV59jXByiSrg4zN9LhC+Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7462

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

We are at 14 by now.

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

Jan

-- 
Siemens AG, Technology
Linux Expert Center

