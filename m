Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9EB2135D
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VloI37jR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9ADHUt79gAC4KI2RbhusszQuYSKduV3Nl5hqsGgicK07WvYRd+BTkw+BshajXhIuu3IdKpk4RWEog35tAhO5Kg3MD5MBQcQfUpZl9gj90+erfrydX7tV7fMkIwtFG0LFrRQnuVwP39DJ4+XdavkURwvLvy8+120+kbIvNqYQWadRZ6bS6EjwjuP/bXnBhPCN5UlYz+1OiuKPV5ZAy/qR3VWB6KHCM9XvgB3H5Sc1Dv1elT+k7tEQ2p6nyr2D9XooCCWG3DfyrCrA/vnA9uOxGHlrI1/cE3CjBaCEcmzJ3cd7ab9jh/ceGmBfNuLEm1u+BK+kbm9C8SG22b4N8MXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMaYA175XPUFldsMoYEKgwwSLm7cne7llN/V+1cHz8k=;
 b=Xie2hO3vctpv0Ih5Jo3wBStHrtZGvyuR5gybrfmZvDVfhRn1GjZ8ckMNCiDvR6Oo3ltV7clCEwsgOmhBQM37sLEYNr/+s1JnhrvPafSpFCR3NZkPHQxAjz5d3eZl+TBM6h90khipzXvujoaHZ4mJvxhdGt2B2NvkqE1NrkIla+OjQC56SetUuVf+Yby8Zf0m0Bqv2kX092AiAVLajPELzrFX41Zj1635zRLNim/KlcWDHC8vTNFLP+loYcYhRXiexQ57sewOAmvy5tSeu7VRL3Tsqp9OE/7f/c83I/i8ZCPUq0SdPlPE7jhhyzwzM824fK+HkxNKabe0OAW6PuLzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMaYA175XPUFldsMoYEKgwwSLm7cne7llN/V+1cHz8k=;
 b=VloI37jR+j5LqRrtTEauVWi9jzismQH3zOrVoZWkWdXnru1I+FZK7gOy74ez1qEYUGT0XHAIi8wF0uI8RLFi6rBRztw2/t5+MJtF3u9n5tMm11GvePUrSMT2Put8JbM8fmgNr7eh31lIAqPrukWY30byzTmFLu/QTxDEbVBpmBaw8Js80UWCW1FTnFxaYiPFMSqcjar8QtXCIWLLfuRVwyG308xJmvf6GVSnUb3Dq6saLDSFpII0WrJ3hXwuWBRJ1xVNIZ+7xbH/EuuHLKhT8MGQbMM7JT9uiUZgSiB+5RnObCVfjZzOO10y68wBYzxZLZhlLUWDodtHDmmyWJx89Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 12:30:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:30:39 +0000
Message-ID: <9bbb7a58-940c-4cf5-84eb-05872b574841@siemens.com>
Date: Thu, 4 Jan 2024 13:30:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: Disable bracketed paste mode
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240104122904.2662979-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240104122904.2662979-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: d36e4d72-0601-4c9a-31e8-08dc0d20f606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4yPjccsDeKGq3ObObP4gw1QyHB605+dv7uwhws7oSRfcvGncOez6yJG3cRAezLQ/V9RXEZEC0pQNG4zTEI4BtWPFXQnWfzk3m87C3DFJ2b/RWgRluQPzs/zOsGZ45AhDG+DIRSLUXoJwTI+9eyQmk+6n94NrC2B0FoklEBUIpvWZjE1iq7bq9QvL8HlwEUz8avLUDbQPEREWedowz0ParMIF92K/cBo7Frs3qXOqYO9z01TzpovW9ZXAX2zV2Vf2Ac59Ac23WrOp/D8tmBuh+4O/ei4g00SGYfzrFD3Nw93ypVZP7fla9jauH0TffNgcK/+Wqgk+WyXryfEWoyM/rdvcJt/F3KunMI1RAZfrsxyAtoks4q9/4COsFa97ppDYUrX5UH0J67ccb3Q5dCG261k9/39Xd1gofqHFbT3gSqgfNIE4yUbobMwi4AhXrkWaafFqZY69bQROofqJ0ODPst4tq8bNp7cKhV+/IWz8MGxdhH4cYYCr/EJ3Cv0LfgJzJMS3RstHpeVuHQx9Ytq85sH6Bdg5Lj/TtTu94G6y+TCn9EJCD19D9LT8OxNQtDrl/A1+kKRQRkDSTCyaVnnjd+72RvF0vnbBnaBtrEpgkaLsp+0F2C2XEJMH3JQkIRUytt3c2lTm8asJyJrgxrelhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(44832011)(5660300002)(2906002)(8676002)(8936002)(316002)(66946007)(66476007)(66556008)(6486002)(41300700001)(6506007)(478600001)(6512007)(53546011)(2616005)(36756003)(26005)(83380400001)(82960400001)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC81bUIrTUFGNCt3bS90em90U2MwdEkzNnYyOUh0T2cvb1A4M1cyZlpyeWQx?=
 =?utf-8?B?VDRFWFRteXkxbjZJSG55WXJSUEtNODVxTmVkOVpaTkI1enA2dTM0MzBGZVZS?=
 =?utf-8?B?Q1gwRXJrRzl3TmFRaG5HMDEzM2lLQzU0dFh2VFppNGd6ZUpqNmpQN1FNYnNr?=
 =?utf-8?B?aHhCZ0R4eHgwQU0rK0I0M2d3WGRtWUg3Y0ZFYjNhYlJKVnRTRGt2bDVLT0hZ?=
 =?utf-8?B?WXhPd1BwUG00dTkxRzRhWlVqUWVKUnBqMUVJazd0T3NBVVl5eFpNRW40Wlgy?=
 =?utf-8?B?VEkrbGxmUnFtVW5qZnAyaGo4NkpOMVFQTVliMzRka2VTSWQwYjRpYUlZMzF1?=
 =?utf-8?B?ZDBlN04yVURzNWJCelpkeEIrL1k2RHdhZGFnMm9VRkR2M2hldkprblJaTUor?=
 =?utf-8?B?WGgxUWFkMnRHeCthNDNBR2YxSFFKamFWSU9rN0ZMbFZidENQVzJ3YkNpdlht?=
 =?utf-8?B?dGRzL05PWG02UUVmVVZ2Y203dDhrZExFNGQzbElIaEp1eUI1aUx4MU8yK2tN?=
 =?utf-8?B?aU94NHVEZlQzcFIra3cvMEg4dklSMDBFdE9rdk1CbjhQbDR5amFFSVBKdFBB?=
 =?utf-8?B?MGhOZzg0TS9hVys0Tmc5VlpqbjdUNXNLcjlEa0hFU1BZZiswcHVDL010bDJ1?=
 =?utf-8?B?N0c2cDN6YXBhSUh6MU9JSXZTY0FOTXNDbTFpMTJYY042MklhN3JsRzVkdHBN?=
 =?utf-8?B?elFheW95Rkx1U0pMWWlHS3htZlJRZ3ZZUytwT25zUkYrak53ZjZyMEsxWU5V?=
 =?utf-8?B?SHJRMzhleEVDYk8wQVZ5ek9oZHlGMkNhbjdqYUx0SWhGV1YyQ1paakhyMEli?=
 =?utf-8?B?KzFPcU9JK1hrL1VQd3ByZElXSWtzR1UzNzQ4SkZ2YUFIY0xjZDNZU1pwYWJt?=
 =?utf-8?B?VlE1SjBBeFVqZTFrL3E0ZlRudHRpb1FKUTczUnN2U0ZOUW0vWllzRzNONlVF?=
 =?utf-8?B?QU5nYndBZWxkWjVEVHZJN2VsNms1L2tqM1dISEZDL2JzUmN4K010VnJQTWZF?=
 =?utf-8?B?ZVkvY0MyS3IyOURWVDJXcURuaWpjaGZiZ2YrTGRJVVBMUHlEK1FhZzlydS9t?=
 =?utf-8?B?ZUtqVkJLZkFMRHZNcWs5cmVWaFBsQXV2RDhWb3VnY0hUbkVrSUs4SStIN2pa?=
 =?utf-8?B?djZ0MEN3Z3hTRERpNmMySXZzd2xvR1ZDaUNwV2xzUDNGYTgxNzNxNHdUU2pO?=
 =?utf-8?B?d1U3SHpKa2VrYjNhMkt6U2xRSzkyN0NCNk0vazFYOUZqNHNOU0J1d3RDeE1D?=
 =?utf-8?B?WGFidjc3dVVxUlZ4VFJMWlIzTDg1QjRsNjFGYjlGZzFSQkgyWlFRUk4xNy9B?=
 =?utf-8?B?SytJUDFjOFEwTVVJSm1rN05qWi80SWlkWndwQlJOTG1WWCtvT3VmcUhjSXhI?=
 =?utf-8?B?VFRvVERBMkZ0MFFXOFIvcy9uYkFPVXFTeW9TalkzWWgvMnpnb045bVMxclMr?=
 =?utf-8?B?bUxlREVHMExlbDN0M3loRXZhWkhJb0tTZWplc3VsdEVPRWpXeE9sTXRwSEZh?=
 =?utf-8?B?WVltaWtCL1hpUUhmREE3RW5ybHZBbU0xVFhubThibmFTaU9CSExLL3BnYUJr?=
 =?utf-8?B?azM1Qk8ydGxvOENkcTc3NEN4cTNweG9oUWN4ZjdyZVMvM1Q2MXRCL3p5Zk5M?=
 =?utf-8?B?dWViemdPYWc1NzFJMmd3V1FIYWdneEZLdEJENTVMV0g0SUozYTNHV0VNZ1dD?=
 =?utf-8?B?NmVMWGVIcnZNeHQvem1EWFZYVVNMK3p6dURsRGFvTU9xVTZJRnR1cjRVMWwr?=
 =?utf-8?B?MHVGQkhoU1JraXhhUFZoQTcwTzhhNUZTY0hKZTBWanJSTG94Z0hXTnR5U3cx?=
 =?utf-8?B?L1REbjVMMXRqUVBHM3lRaVAxRE81UnRZOXRnS25zRVBHT2FWYkFLWXg5RURH?=
 =?utf-8?B?NXp4cjZNcGw1YkNqYU9tUWdIcmNsRmpIdDVId1Q2S2xtOFZEOGRURlF0TDRZ?=
 =?utf-8?B?cEF6c3NYWWJ0MEdrOVB6cGNjZ0M2VjFHR3pLS3lncUFwQ0E3WWNlZUM4NHNN?=
 =?utf-8?B?Y2xMYmUyekVObnNQaG5zVHcyZjJWcWZyTU1BUFJKWDFSZGhwSmE1dU11akxO?=
 =?utf-8?B?MkhrTzhWa1BmdGsvd3JpU056OEJFQjg3T3lLQnlYL3NlWDBoRUN4cEV0T0Fy?=
 =?utf-8?B?NDRicUJNR21zOVVnd1p1bkRDMmtuQmpTR1pWZjRYZmMwZGR3S25BenpQdWlh?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36e4d72-0601-4c9a-31e8-08dc0d20f606
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:30:39.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDWlbV/5dSSnglb01G9f7t5OXme95ffJRYkJ8e++D/+yoPCmsnNG1w+4yg9lngxgYLawmS/jo/QWF/6yO3JYwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7967

On 04.01.24 13:29, Florian Bezdeka wrote:
> When looking at logs produced by our LAVA test runs something like the
> following could be spotted:
> 
> 	[?2004hroot@demo:~#
> 
> The escape sequence is triggered by the bracketed paste feature of bash.
> From time to time this seems to confuse LAVA while searching / waiting
> for prompts.
> 
> As this is a CI specific problem the feature will be disabled for CI
> builds only - where opt-ci.yml is being used.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  opt-ci.yml                                    |  3 ++-
>  .../customizations-ci/customizations-ci.bb    | 22 +++++++++++++++++++
>  recipes-core/customizations-ci/files/postinst | 13 +++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/customizations-ci/customizations-ci.bb
>  create mode 100644 recipes-core/customizations-ci/files/postinst
> 
> diff --git a/opt-ci.yml b/opt-ci.yml
> index 431b070..3581315 100644
> --- a/opt-ci.yml
> +++ b/opt-ci.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2021-2022
> +# Copyright (c) Siemens AG, 2021-2024
>  #
>  # Authors:
>  #  Florian Bezdeka <florian.bezdeka@siemens.com>
> @@ -21,6 +21,7 @@ header:
>  local_conf_header:
>    xenomai-ci: |
>      ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_sshd_key_regen"
> +    IMAGE_INSTALL += "customizations-ci"
>      IMAGE_INSTALL:remove = "sshd-regen-keys"
>      IMAGE_INSTALL:remove = "expand-on-first-boot"
>      IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
> diff --git a/recipes-core/customizations-ci/customizations-ci.bb b/recipes-core/customizations-ci/customizations-ci.bb
> new file mode 100644
> index 0000000..89bfed5
> --- /dev/null
> +++ b/recipes-core/customizations-ci/customizations-ci.bb
> @@ -0,0 +1,22 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "CI specific image customizations"
> +
> +SRC_URI = " \
> +    file://postinst \
> +    "
> +DEBIAN_DEPENDS = "bash"
> +
> +do_install() {
> +}
> diff --git a/recipes-core/customizations-ci/files/postinst b/recipes-core/customizations-ci/files/postinst
> new file mode 100644
> index 0000000..f89d9e9
> --- /dev/null
> +++ b/recipes-core/customizations-ci/files/postinst
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +echo "bind 'set enable-bracketed-paste off'" >> /etc/bash.bashrc

Thanks, applied. Let's see if it helps with our current x86 test issues,
at least some of them.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

