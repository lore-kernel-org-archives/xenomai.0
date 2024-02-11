Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934D59B40
	for <xenomai@lists.linux.dev>; Sun, 11 Feb 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707656324; cv=fail; b=kr1mRdyfqKNHm1h+fQeSN7UQYvJo5LOmoVMv5oqEnc/CvwO16Jyi75z64CQskNFh3bY4WfKG+28m6a/7OV0oaA9RYu81F71ijUu0ccr9EHmxr5ISungK6vFzjq+uXBUDjpSYqt+/9wIQI85MjsgRGFcvjs1gvYuzfML0IErZB88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707656324; c=relaxed/simple;
	bh=+DANygRUkHJKQbUcVNxkhfJ43XC80uVSS04+0hGFgXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHjfXmlFrsSzUx/1MhqYHMbIQRVuBpEKbmqc4UoXYB7LZtcd2V8SZD8F9i99CM0FZ289GcIIRm4jPeIa6Uu16rEInUYN2xRLaQ8JyN/6sc/QqYVmavrtNTD7beyFH/8J+LWvHhd3/yNBVgAxPEW8lka4CGJQozEL3aKK4MNGupo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=O0ppIsX9; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="O0ppIsX9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RueJ0PsIuEECLB7kK46jZWkj4A6McXhjLXxyBpHl4jhElIt1dEX3ElhOalEPIuJ9zEBs6Rpu+Z8+XM8u7LvQFUoOCtOdYFVB+eFFPEmYNoGYl84AVGPgHJzBJ5KM0p4Ju4m9Z4lrawlpesfzwHakYz2PKWIa3LpKtPDS7yP/pbflGC6l5xoJNmC9WtWe40iXhzAS9vYcg0CjYHvHvI6e9AXyKczpCTDCdSJEp+ZGyE8MLXEp1b6vGGFT4yDC3YJ7cnfRd90BQPdPwL+uyXyVRzJ1i9zArwwswix9DSnyPucE1hgY+dOD63FtGEDis6EtrMaG4Lw/Ql8ukPg1jXvcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6VoCwIuREMyrU352neoefbWj0/wN969bpYMV0rdnQ8=;
 b=l5WdwePB7z48+xPzZpuOTBFX1VwGZrgHwz0avilY+8kOvuirTMuVflndrAOkMspMuN3nqe3hCvv6GnKCQ6T6irCHglct9vh8RDpV2MtbcUK08DegBeAkhlt7lME8rJgSyP5HU9lbHkFXuHuzzjmUcKUF/3QdcsOra+E5tTCkw47HsE6eB4/tBFcmkRuDoc//sqCdAHXDQ5UMLrarXvbMUwrE6k8cb7clp07wnZdQyg7zJkema6909H8w44xZvSoVmlG58XKYAwyWo8schNVfkHOgx3G8K4iZv2RDu7X7+B1nB3ylR3aYA2sL0QD8cKjHhFOKt5tYJAxuELzoE2XX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6VoCwIuREMyrU352neoefbWj0/wN969bpYMV0rdnQ8=;
 b=O0ppIsX9Xee9fCZ4fuU2wGeNJ1QHlMQx5asxT9tSLXikVd2BvCHgFoaAP8gc+791htYbA3X08k9oMWwXMrxfvG5ZIzjhhMV0R4+jBnZEhMLhzqu48IujNgq+CgZldo8lKSv+KXOq6b1Vrt013psUIwFECEeuzsO76RB/GszcAf5dPcW0Fm4CfgxhfgmHUPLvXM/6fNcdvzZA/x6t/okSFwvSqI9RWAqsjnGHt+KSqGR3ky7NDPJ+JOKqmtWTA5cbOlVuwq7EjRzNVLX1JOAcgh4Zg6fZc+0c4iG1HR79/Jvxekd8osWKvJYa+N6HCwUpe6cxkDmtmShGVgW+HIabHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Sun, 11 Feb
 2024 12:58:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Sun, 11 Feb 2024
 12:58:37 +0000
Message-ID: <2961d66a-abe1-4ef4-a6ac-93a74d54062a@siemens.com>
Date: Sun, 11 Feb 2024 13:58:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v3] compat: Fix compat builds, switch to
 new ISAR compat API
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <20240209-flo-fix-compat-testing-v2-v3-1-72e81671f1ec@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240209-flo-fix-compat-testing-v2-v3-1-72e81671f1ec@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: a183c47e-f9a5-4dd0-6292-08dc2b01297b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IPF/N3EX04MamwCnAtan2yyPU6bEqo2ypUO1lfDcjFW1BY0bdX3eFRaHMY+jFX1D9cX8lkMDLERWLifJKduA8GCgrf8MpX27uTUHyYUzrF8quOppG5nQQMlfIdqtH8FXHP5gYaoCD6Lixc7dWttv5O2piZpn8BbcKEXLhqYh1ChCmTtbL96I4j0KXFE/ECC9fzIPbxERc1Sr00EINFFbJpobCd3NYwn98ou8PcsSqwKnH/YcWBIgkL3J4yC7ekXfxvyrYGndvGVTNFBXmwPuwnSDvcvfFagubSyy2exnsG+NQXbwK8VQ7rJhfncaOGcZhleyfTihq+4csnhjWmaT/PUyBnweF+4K0Bcu8KR+FVHPc2m4D5xFpGDG3FKnFsxbok+8jGtXMCNTxm0UiHLZiR+P8+Nraifr5PYajA5MjxCYttUW3/Ji/vPV0G7fTeQLOyh0j9oG0lwjO/quNhtUtmysfC6U/yOlzExXIMQElxkbXxMnWSZL/IhIX7wK1dcxiB5U4aGV0Bue2NJrQzP7A34JG+DPrGIrE3CO9x1mgjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(2906002)(44832011)(6512007)(2616005)(107886003)(41300700001)(478600001)(53546011)(6506007)(5660300002)(6486002)(966005)(8676002)(8936002)(4326008)(26005)(83380400001)(66946007)(66556008)(66476007)(36756003)(6666004)(316002)(38100700002)(82960400001)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1V5SU1kdG9laGwxQmFJYmxXMG9KL2EveTZ5eC9PZEdScnQ3SUhqYjEvWmVB?=
 =?utf-8?B?bEQybENKRVV1NEN4b1ErYkpPR25YWFdBUG9YRzBmSi9WWEMxUFZIRVBDd1FL?=
 =?utf-8?B?YW84ODFKUkZsNldraE91clJqM3J4TkxSZ3BQSmxRVVJlZkcxVnZ2MHhWOTEz?=
 =?utf-8?B?V05vZEVFT2xoMC9VWXRBaC9XTkllWWJBcUpBYmdRQm5zaGhJTzdNalNEOTRu?=
 =?utf-8?B?blFKNEVjSVNUL2RTMDJaUzRIbzJGajlrOTJPKzFDZTcyNVdIUVRMcWh5c05K?=
 =?utf-8?B?RFFoOW96d3owaHFhUEhrTG1JaUI2bUNaaUdnTHBacHYwZ2trb25SQjduaWR1?=
 =?utf-8?B?RnUySGg1bjFTaXh4d0NMaHVzUGtLU0k5bjM1K1A4QWQrK3J5ZW5YQ0NDMmgz?=
 =?utf-8?B?WTExdnlnakZqVm9CaXFuUUpFQU93VE1mUnFJUEpwNFFqMUh6NTVtVUx2ampP?=
 =?utf-8?B?ZUYvWmlWSHJJTFYybmtML1FwL0J2enovclRmRm9Dc2oxeFRGZzhkejBCZWdv?=
 =?utf-8?B?a09hb1lXVURlc3I0cnM5S21MYkg0bnNablNGWUhtLzNJa0NIRWJhd2kxTit3?=
 =?utf-8?B?bTdZR21BbE1vaGM0N2thYWxvY0F2UHA2UUMvcTU3SlBWaGhJMW85eW9UMGpQ?=
 =?utf-8?B?SkVDRC8vRCtCcmpjQzFnV2syNXpMeUNLZ0g1b1lnbHZUWEErV0orQ2RxaXRh?=
 =?utf-8?B?eTA4emkvdTVjN2JvaDBBMldjOWZGdWsvK3BFbUdLNlpqOUZ0YXhSWGZsb2po?=
 =?utf-8?B?ZEF5NytMc3pocVNZSHUzbHk4cWpxWk51SmEvNldvdzVsSXBuNk9peEE0Q3J0?=
 =?utf-8?B?YytqZzl5YS9saXlVWkdZeW1iQ1k4VDhoOEVid2VUdGVEU2cyWnVMaXZ6c2tG?=
 =?utf-8?B?MFF4cDRUUXBrN0hwbFpmYWIzL0FRcU81UkRwZzEyY2R4aE4wZ2ZHMTZIYzRJ?=
 =?utf-8?B?SkNmMjdBREt6Qys5NjVTd01EVFFhZCtqZGp1M1VvOWg0VXVIVVJyVGFuMWhv?=
 =?utf-8?B?QmNobHZ4SWV3TzQ2VmNXb1VpTFpFZGE2RHRMQmpXNGlEaUdJMVoydjRQNTlo?=
 =?utf-8?B?NWxMMjVBNjdyN2tNVU10cEdKcHJpU256dStENTdiSVFvVnk3ODl6eTE1MVJX?=
 =?utf-8?B?a0hST2MzRnJqODZ2akZkcFlnK0ZvWXcxVHpyWnNldjU0N0hzbTRXd09ubUlX?=
 =?utf-8?B?ZC9VdFQvMyt6cTVjU1NWS3E5c0RrRi9hYnRVRFluSFV0UkJ5VjRqRlg0Wjc1?=
 =?utf-8?B?T2FVOXgrdmFubXlBQ0dacjNNeEdVamhDNmJkaHc4K1NnNmsvOTJJMTlDVHNY?=
 =?utf-8?B?czZhZU9GMWFWRjF1VW95Tm01ODRHUDcrVEZJdEI4UTR3SHdENFBJdVRaa2tx?=
 =?utf-8?B?U0FYYlhQcDVLZUFsMW9oMW9Zd2Q1WTlQaC9zS2dMcWlHV0orakM3QVV2dDBO?=
 =?utf-8?B?Zlc1QVphMUFYV21KYnBWMGcyNjlwOE56ZGZRM1ZVSlZVdlQxMXRySjcyVkdX?=
 =?utf-8?B?L3VMUm84TSs2Tk9iblZrdXJENzZBN2xremd1aFl5SDdjUG5ud0VjYkxoK2U3?=
 =?utf-8?B?Zm1sVEljNndCVXYzbzUwdW40UXVYVkhEcGUxV3d2L3I4NTY2QWtKTmd0VjRT?=
 =?utf-8?B?UlVYWW5veENUdjhkZ0RNSmhYQ1V6KzJBSG0yZk9jUTVkRDRFZ0lwdDd4SmlB?=
 =?utf-8?B?dVgxcnA3MWQyRnJCK0w5RFh6Q1ViZlVrdnlKWnM3dnZuK2R1MlVqd1lFVnJu?=
 =?utf-8?B?M0hhOE1NT0VUQWhUT0R6NlJXY2F5NjJ4bXpmbHZQTkdjZWtUZGRIYmJkV3hi?=
 =?utf-8?B?YTM3dDd6eVZITlhoQVU4NHVLMDQyWmhuQkNhOUtLQ3Bid1RueTMzVkdRL2VE?=
 =?utf-8?B?ekdBS09rOFk0OFZENHVob1cvWjRpMDZZRkpVR2RoaG9LNnJIaFhNcXFoNTBz?=
 =?utf-8?B?RkJ6dGJmNGNOU08vVnZONXlkcXNwUFRoZ1J5aG5xWlNzbGZIdjhJdlNUcUhW?=
 =?utf-8?B?NFhwd2lYbnhvOG1xR25ScUdzSllkcTBWa2FFN0ZIcEV4QWl6Unl6WFY0cEgw?=
 =?utf-8?B?VFRiNnJaeWpOWkFoczY5UGI4bTVvQ0NMUEJyaVJsY2Y3S09YakZQQmd6Z2dh?=
 =?utf-8?B?OVEwRUVReERsRVEvdzlvVklmbmVDMEt2bG1sRjczNk9YSDZrQVRaalk3Ymln?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a183c47e-f9a5-4dd0-6292-08dc2b01297b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 12:58:37.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxJRYxK0kspYekevjqwYMvhRlNpg1lLg6ZVomdMlTJJJya1gHy7XUhURHeiPbHIo3vyUfrpSC/7CMjwPIldX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6013

On 10.02.24 22:57, Florian Bezdeka wrote:
> The last ISAR update introduced a regression, silently switching our
> -compat builds to -native ones.
> 
> Whenever opt-compat.yml was selected it basically had no effect.
> 
> Adjusting to the new API requires us to specify the preferred version of
> xenomai-compat in addition to xenomai. We have compat builds enabled for
> the stable 3.2 series and current next/master.
> 
> To be consistent all kas option files that set a preferred version for
> the xenomai package have been updated.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Hi all,
> 
> it turned out that some CI jobs are not testing what the naming
> suggests. Since the last ISAR update compat jobs were no compat tests 
> any longer as they were silently migrated to native tasks...
> 
> Internal CI run was successful, but still: Review carefully!
> 
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
> Changes in v3:
> - Set PREFERRED_VERSION_xenomai-compat in distro config as well
> - Link to v2: https://lore.kernel.org/r/20240209-flo-fix-compat-testing-v2-v2-1-01fc5bf3a33f@siemens.com
> 
> Changes in v2:
> - Simplify get_package_names(), address review comments from Jan 
> - Set PREFERRED_VERSION_xenomai-compat in all remaining option files as
>   well
> - Link to v1: https://lore.kernel.org/r/20240209-flo-fix-compat-testing-v2-v1-1-cf0d7d52f68c@siemens.com
> ---
>  classes/print-revision.bbclass      |  4 ++--
>  conf/distro/xenomai-demo.conf       |  3 ++-
>  opt-compat.yml                      |  3 ++-
>  opt-xenomai-3.0.x.yml               |  3 ++-
>  opt-xenomai-3.1.x.yml               |  3 ++-
>  opt-xenomai-3.2.x.yml               |  3 ++-
>  opt-xenomai-next.yml                |  3 ++-
>  recipes-core/images/demo-image.bb   | 17 +++++++++++------
>  recipes-xenomai/xenomai/xenomai.inc |  4 +---
>  9 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/classes/print-revision.bbclass b/classes/print-revision.bbclass
> index ca4aa7b..7674129 100644
> --- a/classes/print-revision.bbclass
> +++ b/classes/print-revision.bbclass
> @@ -18,6 +18,6 @@ def get_commit(d):
>  COMMIT="${@get_commit(d)}"
>  
>  dpkg_runbuild:prepend() {
> -    bbplain $(printf "%s-%s: Building revision %.20s\n" \
> -                     ${PN} ${PV} ${COMMIT})
> +    bbplain $(printf "%s-%s: Building revision %.20s for %s\n" \
> +                     ${PN} ${PV} ${COMMIT} ${PACKAGE_ARCH})
>  }
> diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
> index 2915dbf..9e8c346 100644
> --- a/conf/distro/xenomai-demo.conf
> +++ b/conf/distro/xenomai-demo.conf
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2018-2023
> +# Copyright (c) Siemens AG, 2018-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -16,6 +16,7 @@ XENOMAI_MAJOR_VERSION ?= "3"
>  OVERRIDES .= ":xenomai${XENOMAI_MAJOR_VERSION}"
>  
>  PREFERRED_VERSION_xenomai ?= "3.2%"
> +PREFERRED_VERSION_xenomai-compat ?= "3.2%"
>  include conf/distro/include/xenomai-version.inc
>  
>  PREFERRED_VERSION_libevl ?= "4%"
> diff --git a/opt-compat.yml b/opt-compat.yml
> index 734066a..df01da8 100644
> --- a/opt-compat.yml
> +++ b/opt-compat.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2022-2024
>  #
>  # Authors:
>  #  Florian Bezdeka <florian.bezdeka@siemens.com>
> @@ -15,3 +15,4 @@ header:
>  local_conf_header:
>    compat: |
>      ISAR_ENABLE_COMPAT_ARCH = "1"
> +    XENOMAI_PACKAGE_NAME_SUFFIX = "-compat"
> diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
> index 0962373..b078e6c 100644
> --- a/opt-xenomai-3.0.x.yml
> +++ b/opt-xenomai-3.0.x.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2020-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -15,3 +15,4 @@ header:
>  local_conf_header:
>    xenomai-3-0-x: |
>      PREFERRED_VERSION_xenomai = "stable-3.0.x"
> +    PREFERRED_VERSION_xenomai-compat = "stable-3.0.x"
> diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
> index 937b5f9..91c097f 100644
> --- a/opt-xenomai-3.1.x.yml
> +++ b/opt-xenomai-3.1.x.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2020
> +# Copyright (c) Siemens AG, 2020-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -15,3 +15,4 @@ header:
>  local_conf_header:
>    xenomai-3-1-x: |
>      PREFERRED_VERSION_xenomai = "stable-3.1.x"
> +    PREFERRED_VERSION_xenomai-compat = "stable-3.1.x"
> diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
> index 401efa2..117161e 100644
> --- a/opt-xenomai-3.2.x.yml
> +++ b/opt-xenomai-3.2.x.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2021
> +# Copyright (c) Siemens AG, 2021-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -15,3 +15,4 @@ header:
>  local_conf_header:
>    xenomai-3-2-x: |
>      PREFERRED_VERSION_xenomai = "stable-3.2.x"
> +    PREFERRED_VERSION_xenomai-compat = "stable-3.2.x"
> diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
> index fd2fbab..1d8885a 100644
> --- a/opt-xenomai-next.yml
> +++ b/opt-xenomai-next.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2019-2024
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -15,3 +15,4 @@ header:
>  local_conf_header:
>    xenomai-latest: |
>      PREFERRED_VERSION_xenomai = "next"
> +    PREFERRED_VERSION_xenomai-compat = "next"
> diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
> index e19a038..69067ed 100644
> --- a/recipes-core/images/demo-image.bb
> +++ b/recipes-core/images/demo-image.bb
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2018
> +# Copyright (c) Siemens AG, 2018-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -27,9 +27,16 @@ def has_testsuite_package(d):
>  
>  def get_testsuite_package_names(d):
>      if not has_testsuite_package(d):
> -        return ""
> +        return []
>  
> -    return "xenomai-testsuite xenomai-testsuite-dbgsym"
> +    return ["xenomai-testsuite", "xenomai-testsuite-dbgsym"]
> +
> +def get_package_names(d):
> +    pkgs = ["xenomai-runtime", "xenomai-runtime-dbgsym", "libxenomai1-dbgsym"]
> +    pkgs = pkgs + get_testsuite_package_names(d)
> +    pkg_suffix = d.getVar("XENOMAI_PACKAGE_NAME_SUFFIX") or ""
> +
> +    return " ".join([p + pkg_suffix for p in pkgs])
>  
>  # Install gdb only for older stable releases. Enables gdb tests and avoids a
>  # arch missmatch for compat builds on newer releases.
> @@ -41,9 +48,7 @@ IMAGE_PREINSTALL += " \
>      iw wireless-tools wpasupplicant dbus \
>      lsb-release"
>  
> -IMAGE_INSTALL:append:xenomai3 = " xenomai-runtime xenomai-runtime-dbgsym"
> -IMAGE_INSTALL:append:xenomai3 = " ${@get_testsuite_package_names(d)}"
> -IMAGE_INSTALL:append:xenomai3 = " libxenomai1-dbgsym"
> +IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
>  IMAGE_INSTALL:append:xenomai4 = " libevl"
>  
>  IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
> index 95b2875..efb92ad 100644
> --- a/recipes-xenomai/xenomai/xenomai.inc
> +++ b/recipes-xenomai/xenomai/xenomai.inc
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2018-2023
> +# Copyright (c) Siemens AG, 2018-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -21,8 +21,6 @@ PROVIDES += "libxenomai1"
>  PROVIDES += "libxenomai-dev"
>  PROVIDES += "libxenomai1-dbgsym"
>  
> -PACKAGE_ARCH:compat-arch = "${COMPAT_DISTRO_ARCH}"
> -
>  do_prepare_build() {
>      # Xenomai currently does not maintain its changelog, plus we want the
>      # actual package version in there.
> 
> ---
> base-commit: 9c7bfa8f1af0faa68d19778d0e0a559f407e27df
> change-id: 20240209-flo-fix-compat-testing-v2-1a1157b6982a
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

