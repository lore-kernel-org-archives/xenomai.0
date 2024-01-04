Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9DE219FC
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wvgOwPR2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZFJkfehLlVi8LoyrmwCXttFuihWDGlBbRedODY+t2mTMwCE8NbRgLp8AeHnVRjdznRgWElqMsL1HEeWD455an44Gtuy1sAtIIJi1nTPowZ8ydgeaEE32A0nhv+oRGA7BEhU9YBPTn/gkhr+9SkFg9LLasRubm1ZQKZ2Vi2UuhlYzDhl9l6xI65pqvcHeX73BzE+yEdctIUQz2NyKbY9n07OZK5Tuox5xdvUqnAowKrVBJoJaYM85V9s008MAhNkOINZOeroeT4HvozRa6j1CCdekuSK04Dcad9s4si6/e1ssXWhTGHv0vGysehynyiVl2alcGDPx0j07P7LuDjsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuBa1kgfDhFud9DNOsz4krDuYg7KTRvwz4hrYotCgNM=;
 b=UrGUIQbnqDj0JHfheqYjPC5/cCPQwbSYS3iiUHADP4HhDQaGlj3WE4BKgfxmn69LawX9indIoM5A1ttwYp8xSYaIpA4fLoWQO0SzUAgTZHX2r9ucj0iDlnn1G9RSkRDrD1nLDZVR9Pb2qCkfh2va3c4GhbnQ1qz8w5PkkBSgGLQpH5nXJevjk9vEQhEzlJShwAhjsIZcaXS7Dk19HGc1Sw7WA4ze5mPNpoJy9m6cJlUqyLhk0dQIftavQC+uiSUSVut4W6SGKPQd2GvPholjwgYmVDGXqZVzjNZCXt/te27ZQdPkF2vYmapVpsoeBtIcblEF6+eueskHd61FYqWp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuBa1kgfDhFud9DNOsz4krDuYg7KTRvwz4hrYotCgNM=;
 b=wvgOwPR2PaknbW8nOANGDteV6QS7+zXWUoMROS076H3TWyV2Ruw9Z/a35jhjXGZDNhZZsuXrmH/h4n1aAwb5W0YssNhvzp+8tWnPrh0J1tLzUEjM7/0lPa5IVTq+862XrtGN9jFMr5HN6TYWRU2+thj3kSEmMCjSp39CS1R4toao1/b/hOyX1s1VJyrxkkMPQvirDQ0ad/4ssL2h7DiDYjX2Ff+jV/l6+Z9glCwwP5+kOHnZyLhcZXMNSiMR8Cm5lF0WoHL2ZTuoFyhO6lyFCIQpjH0VzbLCwa8aPrYsaR6LlJDa2Q8Oj/g+Pf8T0WluPf31/LNnsAk2kPoOP/ip1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7462.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 12:41:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:41:50 +0000
Message-ID: <04e1a518-545a-4e1a-9fed-aea5cf055cff@siemens.com>
Date: Thu, 4 Jan 2024 13:41:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 4/7] xenomai-4: Add evl userspace
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
 <20231221163743.2923801-5-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231221163743.2923801-5-clara.kowalsky@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77b672f9-6538-4a5a-a334-08dc0d2285ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bkvP6Y2lL0jvLMHFq7Of4DZOIZtOlgG3yGPEbevwaCpLaK1X7JrHxJlI8KaQw8K+3FeC/RyBPEZE7dQ9lS80XBMKBE4PgkgtEPFuxCxqdtbhxtSUFWfAEk0/iHfi53Fylr+OOTqg8FOR4EkZ5WGGt6pM68AfOuRIglBMmaL+9MEl0C/1zKtkdc8opZqbb4FyYqmh1O1NhtEKFW9zod+CPzy3Wfwufhd9ZXYJCjvWAT7ADoqcX+IrEVCekKp2z1U2/l8c0QejYCf7nUI7LgJI7aZKfjhZDbN7cIgUi2NB+SAHHq8Z6I160Ox5XGy/nug7YQ3ddbQfnQlnyeTJt9UE/9uLr3kfPmfKet+GmljNTjSw2Zm5jnkUFIkMUXH1JqTemJep8wz1Cn1PSKF6MKD5sy3IIt/SGPPRSyiKQ/WecBvwf6Zr5XKAQlrmr+NS+6JrhCOlwI3cIu4FJGAo2wWABLdgqUBrb3G4cEkW1AYCjKMN5tTmRWyxsmZUT/fiIDnzSjKg8i/5dUlerb4q9ONrToMUgmMa3AOC6ZNlxiuwMITRwiqBru/iHz4b30TMRqnqYhlzrMOpyhymggpJTpaoRUaSvpbmYLbd0/ekf9QEZECuMChPZ2aJaT9+eB0H6RdKswKhbVFhYyowgKtC1BfpAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(2906002)(8676002)(8936002)(44832011)(66476007)(6486002)(36756003)(86362001)(316002)(5660300002)(478600001)(31696002)(41300700001)(6512007)(53546011)(6506007)(82960400001)(26005)(2616005)(83380400001)(66556008)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU03czlEKzZNUFV0aStMRXczdG5Bb0pqdkhYYlVzY0VDdEl0MmZ1bVV5YWNo?=
 =?utf-8?B?Y1h6RWJaYXErN1VtQXhBUHJXUUxyMXVhbFVUU2RXYWgvd3R0TC9jdDJoYXdJ?=
 =?utf-8?B?SFJzR0JCQ1FyT0U2b3JEK3FneXVVblpPdFRqNDFhZ2J1eks0UDFCcU9rRjZt?=
 =?utf-8?B?aDJpUGhtSFd1WGtNRVBBYXFWeWJPWU02L01ZLy83U0hjZW1iaGF2MDBIdXk5?=
 =?utf-8?B?YzVkTFFOMTI1L2FDY1pDMjhnYWFHem9EWXk4YkNLS21MSmYwV083OVJwYU5z?=
 =?utf-8?B?YTBXM3FVNDAwd3loaUVFYzAvcHF1akQ3eXdONlkwbkxzMUVCQXdZQjZQb29j?=
 =?utf-8?B?eVoyVy9heDdCMXRWcXpYblYrTjkyVjBFQkpVMThPL3Nzd1V0OURkS3BVYWVw?=
 =?utf-8?B?eE5lSlBqYjdkVDF2dER6TjVHTGZINngxQWYrUGR2ZjI2emIvelZRQlo3b0tn?=
 =?utf-8?B?N1ppMTcxRlFjTG9uUHRvdGVWMUdFUTFTU2pLTGt6em1Za1E1bUJSK0JIenZi?=
 =?utf-8?B?VjlqUSt1Nk1rbnRhRHI3a05RbjJTam80TkxtTENmbE1RU0ZmQkNaNkRXakZh?=
 =?utf-8?B?Vk1tdExjUzkzSXZhTDhIZU5iSzE3cDhQdm12UktRM0pheDZLNWsreExvNThX?=
 =?utf-8?B?Q0laZDF5amdpUzl4WlRRbFAveFNBbTJYOHlxZHovMllRRzFkK0ZONXl5YTJ5?=
 =?utf-8?B?anRmM3d4VGFhL2VuR1hHNkpvMmJ1ZDJnVkovN3NpZDBCQXhneGR2cXRzRXJ2?=
 =?utf-8?B?cmMyNlVha2JoTHE1Y2tqZ0kycmNjYlE4Syt6RE8vUGJPVDZraC8wTUsraFlL?=
 =?utf-8?B?T2JLQVF3b1d1b082K3liNjE3V3BMaXFFa3BzSUpvQ2xVL1daZUF4NThLdUlI?=
 =?utf-8?B?WlZBalNuUmZCWjB2SXJ4VXptaU1WYitSNFBQQWJuSXhYQm5uTlhTWDBMOXFl?=
 =?utf-8?B?VnU3dWM4MFlwR29oUVpEb0pPaGVSNUxKcGhucWNCQXFKZm5lRWE3bFp1ZFZF?=
 =?utf-8?B?K0lpODI0N2pzQ1RUcXJqSEVrTHhSY09PRTVHRUNsYXN5RFJoSXRiK0tyc3ls?=
 =?utf-8?B?TUZ5akFkQlVPemx6TFNLT0owOFgyT0JHSkhERnpXb1hhUzdaQVFqQlFoTG0z?=
 =?utf-8?B?SWJxU2srbkxyNlRpVWRyQWsvUWs5UndCWFVpODcybVhYNFNWd012b1VISDJk?=
 =?utf-8?B?RHhENnlsQXBLb21ybVcvZ25IM1IxL1UxRlpuWldaazFRaDZpSk50a2JTL0Fo?=
 =?utf-8?B?UmdMdU5jU3pmVlBvQzNtK3RUKzJTTnVuaTY2U1hheVB6RjduNGtTS3lTSm11?=
 =?utf-8?B?YWNHU2dCUU5vazhzQXMycG1UN3luRVVoS3l1R3FKSllEWnQ0d0VXY2hIRjdT?=
 =?utf-8?B?VkdKdTdjUGFNTDg1dVBuejNtWVJhWHBwMGNTRm83WFVRNGJLSER3V3JIV0JV?=
 =?utf-8?B?MXhEaWFQQldDK0ZBU1A1TGxCYy93QVpESVZuU1p1V0xpNmkzU0FMVjhEcXpr?=
 =?utf-8?B?SERWcVpmaktUdlZvblRFN2huNjkxV3lTNzRERWZPRGVncU5NdDl0TkdZc1lI?=
 =?utf-8?B?VmRNV1JqNGlCL2hYalVydnZaeDVWL2ltTEVxUnM0eHdlYkFJZVRsZk9kdlNz?=
 =?utf-8?B?a3h4K3JhZkZWdW93R2xrRkxXa3J5ZzVkdzZrZks1eTBvMTBmWnpNald0SEFO?=
 =?utf-8?B?QmNpNndwNTV2RDBoTzYrMHYrOUsybnh3YXE5SURBOHRiQWtxV1NpdW9vL25H?=
 =?utf-8?B?MGM0R29sdDkxcUkybXVPUlhyc1E3d1ZkbjJVZmdTc3pIN3lraVJKREo0bExq?=
 =?utf-8?B?WkNWZ2dGN3gyM24rdXlocm1OVVRSaElBS0ZkbHpvTDhkUTliTi9PbmF2UHE0?=
 =?utf-8?B?Mzhobk9ZdGdFcmd1RjE5bmpqL2U0NmJKcUh3YWFwOEZjc01JLzlPeXRzUURH?=
 =?utf-8?B?dTRBM1Q4U0IrTkUrQjR0ZWhlUmdlWVZXMFhramhnZi9ET2RCWkxrb21zdnhX?=
 =?utf-8?B?L0JhT2habklQQWpLaklzd2UyMjBTRWl4N3dwditncityMDlrWkJVdTFDa3Zo?=
 =?utf-8?B?eWdMK0Jvb3h1cWtGZkZrejdDZDhoaHFDOXRBaEd6SDZwUDM4MjAvSVBXbnlw?=
 =?utf-8?B?eXdSMlVtTWthT0VZQm9oQ2x6MHZRT1Q3dDRRM0dHaENDWEVta2s1UThKaVlB?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b672f9-6538-4a5a-a334-08dc0d2285ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:41:50.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXHWXf99Zy5SNXuNLy9xsN70jlyzejYj7ioXjyGFd3/ONbDqDUb0ErgbvuoxxnmfJ22CLxubKgsKRBsnPjRn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7462

On 21.12.23 17:37, Clara Kowalsky wrote:
> The libevl recipe allows building the evl userspace.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  opt-libevl-master.yml                         | 19 ++++++++
>  opt-libevl-next.yml                           | 20 ++++++++
>  opt-libevl-r46.yml                            | 19 ++++++++
>  opt-libevl-stable.yml                         | 19 ++++++++
>  recipes-core/images/demo-image.bb             |  2 +
>  recipes-xenomai/libevl/files/debian/compat    |  1 +
>  .../libevl/files/debian/control.tmpl          | 10 ++++
>  recipes-xenomai/libevl/files/debian/rules     |  7 +++
>  recipes-xenomai/libevl/libevl_master.bb       | 47 +++++++++++++++++++
>  recipes-xenomai/libevl/libevl_next.bb         |  1 +
>  recipes-xenomai/libevl/libevl_r46.bb          | 46 ++++++++++++++++++
>  recipes-xenomai/libevl/libevl_r47.bb          |  1 +
>  12 files changed, 192 insertions(+)
>  create mode 100644 opt-libevl-master.yml
>  create mode 100644 opt-libevl-next.yml
>  create mode 100644 opt-libevl-r46.yml
>  create mode 100644 opt-libevl-stable.yml
>  create mode 100644 recipes-xenomai/libevl/files/debian/compat
>  create mode 100644 recipes-xenomai/libevl/files/debian/control.tmpl
>  create mode 100755 recipes-xenomai/libevl/files/debian/rules
>  create mode 100644 recipes-xenomai/libevl/libevl_master.bb
>  create mode 120000 recipes-xenomai/libevl/libevl_next.bb
>  create mode 100644 recipes-xenomai/libevl/libevl_r46.bb
>  create mode 120000 recipes-xenomai/libevl/libevl_r47.bb
> 
> diff --git a/opt-libevl-master.yml b/opt-libevl-master.yml
> new file mode 100644
> index 0000000..a3fb14f
> --- /dev/null
> +++ b/opt-libevl-master.yml
> @@ -0,0 +1,19 @@
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
> +    PREFERRED_VERSION_libevl = "master"
> +  xenomai-4_override: |
> +    OVERRIDES .= ":xenomai4"
> diff --git a/opt-libevl-next.yml b/opt-libevl-next.yml
> new file mode 100644
> index 0000000..5e22d43
> --- /dev/null
> +++ b/opt-libevl-next.yml
> @@ -0,0 +1,20 @@
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
> +    PREFERRED_VERSION_libevl = "next"
> +  xenomai-4_override: |
> +    OVERRIDES .= ":xenomai4"
> +

".git/rebase-apply/patch:77: new blank line at EOF."

Jan

> diff --git a/opt-libevl-r46.yml b/opt-libevl-r46.yml
> new file mode 100644
> index 0000000..53d15f0
> --- /dev/null
> +++ b/opt-libevl-r46.yml
> @@ -0,0 +1,19 @@
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
> +    PREFERRED_VERSION_libevl = "r46"
> +  xenomai-4_override: |
> +    OVERRIDES .= ":xenomai4"
> diff --git a/opt-libevl-stable.yml b/opt-libevl-stable.yml
> new file mode 100644
> index 0000000..d9ce4a1
> --- /dev/null
> +++ b/opt-libevl-stable.yml
> @@ -0,0 +1,19 @@
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
> +    PREFERRED_VERSION_libevl = "r47"
> +  xenomai-4_override: |
> +    OVERRIDES .= ":xenomai4"
> diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
> index db7e2c7..e19a038 100644
> --- a/recipes-core/images/demo-image.bb
> +++ b/recipes-core/images/demo-image.bb
> @@ -44,4 +44,6 @@ IMAGE_PREINSTALL += " \
>  IMAGE_INSTALL:append:xenomai3 = " xenomai-runtime xenomai-runtime-dbgsym"
>  IMAGE_INSTALL:append:xenomai3 = " ${@get_testsuite_package_names(d)}"
>  IMAGE_INSTALL:append:xenomai3 = " libxenomai1-dbgsym"
> +IMAGE_INSTALL:append:xenomai4 = " libevl"
> +
>  IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
> diff --git a/recipes-xenomai/libevl/files/debian/compat b/recipes-xenomai/libevl/files/debian/compat
> new file mode 100644
> index 0000000..f599e28
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/compat
> @@ -0,0 +1 @@
> +10
> diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
> new file mode 100644
> index 0000000..9880ee9
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/control.tmpl
> @@ -0,0 +1,10 @@
> +Source: ${PN}
> +Section: misc
> +Priority: optional
> +Standards-Version: 3.9.6
> +Maintainer: Xenomai project <xenomai@lists.linux.dev>
> +Build-Depends: ${DEBIAN_BUILD_DEPENDS}
> +
> +Package: libevl
> +Architecture: ${DISTRO_ARCH}
> +Description: ${DESCRIPTION}
> diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
> new file mode 100755
> index 0000000..9d9670e
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/rules
> @@ -0,0 +1,7 @@
> +#!/usr/bin/make -f
> +
> +override_dh_fixperms:
> +	dh_fixperms
> +
> +%:
> +	dh $@ --buildsystem=meson
> diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
> new file mode 100644
> index 0000000..d5ad572
> --- /dev/null
> +++ b/recipes-xenomai/libevl/libevl_master.bb
> @@ -0,0 +1,47 @@
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
> +inherit dpkg
> +
> +CHANGELOG_V = "9999-${PV}"
> +SRCREV = "${AUTOREV}"
> +
> +SRC_URI = " \
> +        git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV} \
> +        file://debian \
> +        "
> +
> +DEPENDS="linux-xenomai-4"
> +
> +S = "${WORKDIR}/git"
> +
> +def get_commit(d):
> +    try:
> +        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> +    except bb.fetch2.FetchError:
> +        return ""
> +
> +COMMIT="${@get_commit(d)}"
> +
> +DESCRIPTION ?= "install libevl libraries and tools"
> +DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, linux-libc-dev"
> +
> +TEMPLATE_FILES = "debian/control.tmpl"
> +TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    cp -r ${WORKDIR}/debian ${S}
> +    deb_add_changelog
> +
> +    bbplain $(printf "libevl-%s: Building revision %.20s\n" \
> +                    ${PV} ${COMMIT})
> +}
> diff --git a/recipes-xenomai/libevl/libevl_next.bb b/recipes-xenomai/libevl/libevl_next.bb
> new file mode 120000
> index 0000000..85ab518
> --- /dev/null
> +++ b/recipes-xenomai/libevl/libevl_next.bb
> @@ -0,0 +1 @@
> +libevl_master.bb
> \ No newline at end of file
> diff --git a/recipes-xenomai/libevl/libevl_r46.bb b/recipes-xenomai/libevl/libevl_r46.bb
> new file mode 100644
> index 0000000..a8bc597
> --- /dev/null
> +++ b/recipes-xenomai/libevl/libevl_r46.bb
> @@ -0,0 +1,46 @@
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
> +inherit dpkg
> +
> +CHANGELOG_V = "9999-${PV}"
> +
> +SRC_URI = " \
> +        git://source.denx.de/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=${PV} \
> +        file://debian \
> +        "
> +
> +DEPENDS="linux-xenomai-4"
> +
> +S = "${WORKDIR}/git"
> +
> +def get_commit(d):
> +    try:
> +        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
> +    except bb.fetch2.FetchError:
> +        return ""
> +
> +COMMIT="${@get_commit(d)}"
> +
> +DESCRIPTION ?= "install libevl libraries and tools"
> +DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, linux-libc-dev"
> +
> +TEMPLATE_FILES = "debian/control.tmpl"
> +TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
> +
> +do_prepare_build[cleandirs] += "${S}/debian"
> +do_prepare_build() {
> +    cp -r ${WORKDIR}/debian ${S}
> +    deb_add_changelog
> +
> +    bbplain $(printf "libevl-%s: Building revision %.20s\n" \
> +                    ${PV} ${COMMIT})
> +}
> diff --git a/recipes-xenomai/libevl/libevl_r47.bb b/recipes-xenomai/libevl/libevl_r47.bb
> new file mode 120000
> index 0000000..54ca27a
> --- /dev/null
> +++ b/recipes-xenomai/libevl/libevl_r47.bb
> @@ -0,0 +1 @@
> +libevl_r46.bb
> \ No newline at end of file

-- 
Siemens AG, Technology
Linux Expert Center

