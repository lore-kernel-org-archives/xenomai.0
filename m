Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4FEB0F
	for <xenomai@lists.linux.dev>; Thu,  5 Jan 2023 18:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxiFiMMlNtZ/25qkoxVVEfg7ZinMb8+oaHyi29ttmPbDKQHnIazZq4SN1Uz7upa30ksYOJFbYc94wksstWAk/7Vpd/egAfo0cacijuf5LEM8mp6KAgnhSxegPMP/o5Nt7ny4tezWe/XlWlXTMg3eBou2/OAyDvvwjeovnq9ECiUgnRt2E7kfIYKRVbJQbw3YhSicGsepnXN22N5mQHJ5o+zAicQyA+aoaRCn4c6sgrPTrsJitMoaqvXW7zUBGjm5LmoHFROAKulpGUKxjLtfquuJrKO1w1JHXSCWplKuK5YK5EVghpJfCZ8cU5W6NJhxU78eKh0sNsfJWqoL264vMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgR/vc/HJfwHXDN4r35RAYgQU4eh28WtN9z7NaDKdyM=;
 b=VPTECBDR4F0s9lOE/XoZK7ahvMBnsAxqJxJ6edBGX3Hp0RxXPc3EA1krXbPhOU09k/q3+7fiY7GhMlORnH3codeWAcWpFC3wIlcKwnVh82dvNd9tJ+1lLaFUfa79cLiIYPaI+KL1bHgZk+/9LVxZPTT816WHsfmLhzCrwPZKeFC6BM8ICkd461ooW/TJ22j87sLOuTx2yvjNdncBlafCTCjwqk5Y7vZ55TStGhVPxXzquLlldmzDNn+bETGWKI213PJnQPd2NEDhnN6ZdgMDQKHApXFbsd6mbamzBNUaULPWaFjB8JNjdRvdeiG9rUAPp0AcGRtQQMr8UHw5I6fMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgR/vc/HJfwHXDN4r35RAYgQU4eh28WtN9z7NaDKdyM=;
 b=sGnLeS8+JMm/JfdzChhYW3V2SY8XoTAeOzKl4uKWojUhBayihhxbvN+z0+VWxWc9irVWB+jhl6vh0VD/5h3yu01ivRVKJWCL83QbDp5BlOMOFOsVP1qe8mIyZg1W2aLYmQaZkeoWlFfhlPG9lN5VC9R6rSs0guBpQJSBTz79X7Vfld4cnCYPtYIbrXOj4eUlQKBXLius5HbIBz1oQ/vEjta01LQNcueOYAeawUBdDNdiyMGpSuqFD8C/y/eyqRqhvtPE9xtttqcSCjYdmCxnJBJkdV0W8FKT2igrulrQT1NjKCKOQOa3E+UCD0ZqWrNtLlfkFQhcs1wT3XSiN1QGag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 18:06:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 18:06:40 +0000
Message-ID: <ee077ae5-b261-18cb-a903-8d268fa29883@siemens.com>
Date: Thu, 5 Jan 2023 19:06:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] Update Isar to latest next version - sbuild
 integration
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230105132733.3056171-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230105132733.3056171-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e4b4d0-ecfe-4fe7-8e36-08daef479858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pEnjL+1hkw3oITJatnpiMCGe/6NRTbbl1Uy56LVQ7zLkDhqU9oFGXpvZj0bGZgBo4O1o5PeyulF1ojemKLZNMuX5ynJRhTHz+t8sfCwbV+kEHX5ZN7LjbSVlfcReaIZt5/i/I2Dz/WCtTAmpL4OXeUq53b1h+H1MreicCe/GZx10zkI2dfMZ0epk7ZRbjgHJXceI1Fp0b/7L93cgGnXmrXDCJHgXOf3gPqHBlb4RnD0Mtgs7UXrx11EaSa7Abi5wHj5/GuhwLLPVlsIOHcnwe6Eic3czao7VEbjJ+dSgTj9UBbU3C29hiK735dld6UCmXW//3stNztMTMejRnI1oFa3AwHpLCBCij7r1WzssyPI9joVu/fbpw6yAbxd1PZgSwuPtKrhuR3Wv1KenapcKTS1RgXyotHrZuEI/DcE0Rc0PX/izdzhpEXdnIBd2kMG3fEY1EjUAuqX2HVRiZKq8AklCeDRY2He7k2QGv9c/QtK2xk9gMx2JHzZQszpPfW+vStUPaN+7DeUVIX5sN3UgeFAtMyCTy7ri11YlZqK5gWO4LxZM7E4EA+OCVq/jk70AjTLLkpdFxY6JIZpMNjz/WjGT++k2CTE1aNhEgZn04AgCvb0L13ixWFRv5OticgfakV2rtq78aDDNnoDIZzf3EHjSR/Fkfxfsj4+SBMDcwLeCUWL+1X7CEKTIZsPK9ElrbrbWDfYO+TLfYxcnHjrarL7ygBZsPnNwNhHVbJfFZfz2YJ6G3FwqacQhkdIUMmbmmQeclTBBKmZTuHpUgXXx6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(6486002)(6506007)(478600001)(6666004)(966005)(6512007)(26005)(316002)(2616005)(66899015)(53546011)(66476007)(66946007)(44832011)(8676002)(30864003)(66556008)(186003)(41300700001)(2906002)(5660300002)(15650500001)(83380400001)(8936002)(86362001)(31696002)(38100700002)(31686004)(36756003)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2pPTDJRUkswVERTblRPV1BGN2dmSzZGZ0crNW5VSnU5d0tPb0RwZDkyN1pY?=
 =?utf-8?B?Q2dWL3NqUXhIRC9CNlRjZWsvb3FURHlQMUg0ZzJHamV0NEJCZStiOVYyRnpl?=
 =?utf-8?B?eFB3Z0ZKcld1bGZSQStrZ2RDNFB4cDRyMnZGa3Z5VWU5b2NPajZyc2k2TmNm?=
 =?utf-8?B?ZTZXQnVnQ3k1WHVkNHltLy9zSjVyU1kvOTkwdndOS1o0eTdQQ3dwSHYyYlNS?=
 =?utf-8?B?MzJId0QzY0lqdzNpbzM1RkpTdDZlOEd1Z29XVVBMcXNKRERobDM5R1ZaSHk4?=
 =?utf-8?B?b2d0akdNaUtNVEdSYnhnQzl0bWxtcDhYaGl4Tnd1ajdwcFRkSmMrb2JWWXFa?=
 =?utf-8?B?MGtXaDVBQ0dmTkxIdXdJRTdjZjhGcmZyb1cxcGFraW1TMDBydTlBMlZuTkJT?=
 =?utf-8?B?Q1ZISndqK0RTb1RMdzRnbU1BY2FtV1NzV0R1S0svSCtnK1VDQkZvZXNQNEcw?=
 =?utf-8?B?RnA2MkdaMzRWK1pQeXh3RWdublhROFhBaktuMVhtMlVGL0RDMkRoaVRnNDAr?=
 =?utf-8?B?YjhJaDZhemtycDYxcGludS9valdSZFFIdFdzQ0ozS05tazFuaUo0UVp4Wll6?=
 =?utf-8?B?dTZOMkVVTXIvQzg0cGhmd3R4SFp4cEdiMnROeFNIM0xxaHhYeXZ4ZTdJTFJz?=
 =?utf-8?B?dTYvN1VESnNYNWNBWERLRnFDNG83T21CNXMyUHdEclpseGNHU2dkSVVMYXJu?=
 =?utf-8?B?TWtLajVaTmxscHM3SmxvRVRmQVQrM3lLL3pGSkk2TGpoTkdnaGZvL0hxelZE?=
 =?utf-8?B?QXVwbG9pUTBmeXYrL205ZHUydURpSzZTdllNdEV4WEtScm9qM0Q4WXhaVnlH?=
 =?utf-8?B?bXl3T3RXYjhkaVY3SkxGbE1McW1veFpiUkg0UlN2RWh1QU1rL04wYXZqcE9D?=
 =?utf-8?B?eVJULzZPUjlhK2xyTDJzekx3cDlDS3JPQVA5S2owVW12T2R4a2phWEV1SEJM?=
 =?utf-8?B?ZWtXa3BQb1VCYWtEMlM0U0FmZDhIUEZUeFdGTTlPUUV4VzAxbE9GbkFtam9z?=
 =?utf-8?B?M2RMQnpaeDJ1RXl2aGo2ZUJUbThrcXJzaDZkWmxZQUdGZGZ6MGNjK1A1V2hP?=
 =?utf-8?B?WVZLNkY1RWZVYXhLMmdJZ0NpRm53ZGpEQWZJYXpvcFIyc1lKVXVnY1FsbnFJ?=
 =?utf-8?B?bEMrRjR4MWFOOUZHWXlNQ3Z1bHpDenMwTEZWR1F4Ulc3MjE1SkFrc3lxRXNz?=
 =?utf-8?B?RmtSSlJFeVpOK3lyQ1liazE3aVQySWpwTnlYWms1VjJlSGJKZWc1ajZWOUta?=
 =?utf-8?B?NDVNRnBNL25jT25vNVBGb0ZrU04zYUI2V1R6WSs1Wm5rVDRzcUVCUC9DOXov?=
 =?utf-8?B?UGllT05FWVVKak9tQUFhT242ME0vZFlWSEs3NmFUaVZVQ3liTENQNXh5NWJY?=
 =?utf-8?B?c0szc2czd1d2aktjSHh1aVJqVitOcjAwL1BFc09ORDQrcUhFTmo3QUI1bzU4?=
 =?utf-8?B?Q1JaYVJsajdSNG9ha2FJZ2N5Q2FwdUUyZnAzREZvRGFzbGhmczFEYklEbnZT?=
 =?utf-8?B?VFlleGd6TWNYT0lYQ05oNFd4OGE1OHhrK0lOVngrZHczVVpUQlZFckkxcklB?=
 =?utf-8?B?cjlzbGp1eG9jejhwOHRKUkZXQ3RtcWd4cTFQRjFyOGNYNm14VmdjdmFybXo3?=
 =?utf-8?B?K2NncVBKQ1N4Wk42SXVUYmZpTUprSTA3bXFkSmhQSUhxNUxWNXVmaXNqUnZV?=
 =?utf-8?B?Z0RpSVQvSnhXWVNCQkJjdjBxMTh1RWZaM1VhcmtkaUV3YlQ4a3VYLzRUcDBa?=
 =?utf-8?B?KzZIbU0zWUZYWVJhaVdiQkE4ZGwwOXEyd0FwbGE5ZUtrTi9CZGtNbjFrRk9M?=
 =?utf-8?B?V2wvay85eXhzaUo4aGljQUg1WDdtb251V2M4a1l2RHUraEVvYVJucGdhQ0N2?=
 =?utf-8?B?aU1LZEF5b2x1b3duSU8yRWpKOU0xZ1dUbC8vYzhTekIrYVBWcXRhQllpOWh5?=
 =?utf-8?B?cmNsUkx6R3pKdDZtbnZzb3FVWXJ6ZWdqRm0wZm92M29FYS90Rkgzc1FodkRn?=
 =?utf-8?B?V2hTb3hpZXptM29HOTRiajhIZTU2UStwZmh2bmhUQkQ4UmFZS3c1czFhVE1r?=
 =?utf-8?B?cXFhVWlmM3A4UkFmTFgxV3Rocy9kU1NvMnlvRmxhRTgvOEV3eHVEejl1Y3VM?=
 =?utf-8?B?NkZxT2htQnRWYmZPK0hTcHhhQ3ViY1M3R3c0RytzVGtGYjRPdG5WdE5nbm5h?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e4b4d0-ecfe-4fe7-8e36-08daef479858
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 18:06:40.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O21WNv/uowsg70nNwGM1FpAN8YR8q7LOsd/6aATP1sMasuQkHjAD8y7LWPGrQxMtDcnSQrsIjdotBUR73fQCIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7120

On 05.01.23 14:27, Florian Bezdeka wrote:
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
> linux-xenomai: Moving the prepare-kernel and patch-kernel step into
> debian/rules requires patching the debian/rules file deployed by the
> Isar linux-custom.inc helper.
> 
> The added Isar patches can be removed on next Isar update. The problem
> was that the rootfs is no longer added to /etc/fstab. As a result the
> rootfs was mounted read-only failing LAVA tests. As the oe -> isar ->
> xenomai-images transition will need some time the patches are added here
> as well.

I think we should wait for Isar and/or OE to react on those patches
before moving the Isar revision forward. But we can already start
refactoring the problematic recipes as that should be independent of the
update. Comments on that below.

> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Some notes:
>   - One step closer to y2038-safe builds
>   - The upstraming process for necessary Isar patches started already
>     Might take some time until patches hit Isar next
>   - Internal CI did not report any issues
>   - Comments (especially on the sbuild stuff) are welcome
> 
>  kas.yml                                       | 11 +++-
>  ...age-remove-entry-from-fstab-template.patch | 28 ++++++++++
>  ...2-wic-replace-existing-fstab-entries.patch | 52 +++++++++++++++++++
>  recipes-kernel/linux/files/debian_rules.gdiff | 14 +++++
>  recipes-kernel/linux/linux-xenomai.inc        | 35 +++++--------
>  recipes-xenomai/xenomai/xenomai.inc           |  7 ---
>  6 files changed, 116 insertions(+), 31 deletions(-)
>  create mode 100644 patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
>  create mode 100644 patches/isar/0002-wic-replace-existing-fstab-entries.patch
>  create mode 100644 recipes-kernel/linux/files/debian_rules.gdiff
> 
> diff --git a/kas.yml b/kas.yml
> index f8790e5..b6e5133 100644
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
> @@ -22,7 +22,14 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: 213b8f62fa74e87321f927fb6b4ed9db93e5cb37
> +    refspec: 8530a94bdc8919fadccad13e6061832d2f2c1fcc
> +    patches:
> +      "0001":
> +        repo: xenomai
> +        path: patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
> +      "0002":
> +        repo: xenomai
> +        path: patches/isar/0002-wic-replace-existing-fstab-entries.patch
>      layers:
>        meta:
>  
> diff --git a/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch b/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
> new file mode 100644
> index 0000000..4354d32
> --- /dev/null
> +++ b/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
> @@ -0,0 +1,28 @@
> +From 5c9df8b8ac0691c2c4b11deaf763999bb7a136e6 Mon Sep 17 00:00:00 2001
> +From: Felix Moessbauer <felix.moessbauer@siemens.com>
> +Date: Thu, 5 Jan 2023 08:45:02 +0000
> +Subject: [PATCH 1/2] Revert "image: remove / entry from fstab template"
> +
> +This reverts commit fc4f004eb67237d9d09b1ffad0de1a19217fa94a.
> +
> +Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> +Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> +---
> + meta/classes/image.bbclass | 1 +
> + 1 file changed, 1 insertion(+)
> +
> +diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
> +index d8d605d..ccff810 100644
> +--- a/meta/classes/image.bbclass
> ++++ b/meta/classes/image.bbclass
> +@@ -327,6 +327,7 @@ image_configure_fstab[weight] = "2"
> + image_configure_fstab() {
> +     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
> + # Begin /etc/fstab
> ++/dev/root	/		auto		defaults		0	0
> + proc		/proc		proc		nosuid,noexec,nodev	0	0
> + sysfs		/sys		sysfs		nosuid,noexec,nodev	0	0
> + devpts		/dev/pts	devpts		gid=5,mode=620		0	0
> +-- 
> +2.39.0
> +
> diff --git a/patches/isar/0002-wic-replace-existing-fstab-entries.patch b/patches/isar/0002-wic-replace-existing-fstab-entries.patch
> new file mode 100644
> index 0000000..63e852b
> --- /dev/null
> +++ b/patches/isar/0002-wic-replace-existing-fstab-entries.patch
> @@ -0,0 +1,52 @@
> +From d162b4cfe3c8cce723372519bedb9d861e305135 Mon Sep 17 00:00:00 2001
> +From: Felix Moessbauer <felix.moessbauer@siemens.com>
> +Date: Thu, 5 Jan 2023 08:45:03 +0000
> +Subject: [PATCH 2/2] wic: replace existing fstab entries
> +
> +This patch extend the imager direct class to check if the mountpoint of
> +an to-be-added entry in the fstab is already there. If it is, the old
> +entry is removed and the new entry is appended.
> +
> +This solves issues with duplicated entries which coming from the rootfs
> +itself. One example where this happens is when generating images for
> +both direct kernel boot and EFI. In this case, the rootfs mountpoint
> +needs to be in the fstab of the rootfs and needs to be replaced in WIC.
> +
> +Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> +Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> +---
> + scripts/lib/wic/plugins/imager/direct.py | 11 ++++++++++-
> + 1 file changed, 10 insertions(+), 1 deletion(-)
> +
> +diff --git a/scripts/lib/wic/plugins/imager/direct.py b/scripts/lib/wic/plugins/imager/direct.py
> +index c44159b..7f8733a 100644
> +--- a/scripts/lib/wic/plugins/imager/direct.py
> ++++ b/scripts/lib/wic/plugins/imager/direct.py
> +@@ -104,6 +104,14 @@ class DirectPlugin(ImagerPlugin):
> + 
> +     def update_fstab(self, image_rootfs):
> +         """Assume partition order same as in wks"""
> ++
> ++        # return the mountpoint from an fstab entry
> ++        def _get_mountpoint(line):
> ++            parts = line.split()
> ++            if line.startswith('#') or len(parts) != 6:
> ++                return None
> ++            return parts[1]
> ++
> +         if not image_rootfs:
> +             return
> + 
> +@@ -141,7 +149,8 @@ class DirectPlugin(ImagerPlugin):
> +             passno = part.fspassno if part.fspassno else "0"
> +             line = "\t".join([device_name, part.mountpoint, part.fstype,
> +                               opts, "0", passno]) + "\n"
> +-
> ++            # if this mountpoint is already in the fstab, replace it
> ++            fstab_lines = [item for item in fstab_lines if _get_mountpoint(item) != part.mountpoint]
> +             fstab_lines.append(line)
> +             updated = True
> + 
> +-- 
> +2.39.0
> +
> diff --git a/recipes-kernel/linux/files/debian_rules.gdiff b/recipes-kernel/linux/files/debian_rules.gdiff
> new file mode 100644
> index 0000000..477e581
> --- /dev/null
> +++ b/recipes-kernel/linux/files/debian_rules.gdiff

Is .gdiff some specific file extension? Or is it just to avoid
interpretation by the do_patch job? That could also be achieved by
"...;apply=no".

> @@ -0,0 +1,14 @@
> +diff --git a/meta/recipes-kernel/linux/files/debian/rules.tmpl b/meta/recipes-kernel/linux/files/debian/rules.tmpl
> +index 8063c49..5ce2c5f 100755
> +--- a/meta/recipes-kernel/linux/files/debian/rules.tmpl
> ++++ b/meta/recipes-kernel/linux/files/debian/rules.tmpl
> +@@ -24,6 +24,9 @@ override_dh_auto_clean:
> + 	$(isar_env) && bash $(deb_top_dir)/isar/clean
> + 
> + override_dh_auto_configure:
> ++	/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
> ++		--linux=$(S) \
> ++		--arch=${KERNEL_ARCH}
> + 	$(isar_env) && bash $(deb_top_dir)/isar/configure
> + 
> + override_dh_auto_build:
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 7dba96e..eed372d 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -19,6 +19,7 @@ XENOMAI_DEBUG ?= "0"
>  
>  SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>  SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
> +SRC_URI += "file://debian_rules.gdiff"
>  
>  DEPENDS += "xenomai-kernel-source"
>  KBUILD_DEPENDS += "xenomai-kernel-source:native"
> @@ -32,26 +33,16 @@ def get_commit(d):
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
>  }
> +
> +do_patch_debian_rules() {
> +    # debian/rules is a template deployed by the the linux-custom helper in
> +    # Isar. The template needs some patching before it is processed by the
> +    # templating engine. We have to feed in the xenomai specific
> +    # "prepare-kernel" and "patch kernel" steps.
> +    # Note: We can't use the .patch or .diff file ending here (bitbake magic)
> +    patch -d ${WORKDIR} -p5 -i ${WORKDIR}/debian_rules.gdiff

I wonder if we could also come of with a pattern that uses the original
rules of Isar, including it, just adding a prerequisit to
override_dh_auto_configure:

include isar-rules

override_dh_auto_configure: prepare-kernel

prepare_kernel:
	...

.PHONY: prepare_kernel

> +}
> +addtask patch_debian_rules after do_unpack before do_transform_template
> \ No newline at end of file
> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
> index b874a4a..4994533 100644
> --- a/recipes-xenomai/xenomai/xenomai.inc
> +++ b/recipes-xenomai/xenomai/xenomai.inc
> @@ -34,10 +34,3 @@ do_prepare_build() {
>      rm -f ${S}/debian/source/format
>  }
>  
> -dpkg_runbuild_prepend() {
> -    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
> -                     ${PV} ${COMMIT})

We lost this part now.

> -
> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
> -}

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

