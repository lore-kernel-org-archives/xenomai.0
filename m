Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6323DB
	for <xenomai@lists.linux.dev>; Sat, 10 Feb 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555224; cv=fail; b=VAE52hqVg7UCubEAZPUA9ZkXuH3hmnn5FgBeWkGqddOPyapHWYe9cpp4mDmfJVD34hVf5X8qBjOe31p6Esnllrdpk16I11GIlutnaELNwY8UMmgarFU5HNOKIs/YMCmIxbL51eRSezPSqmcVWxEK7QplDq+q6FEdm8q4HvF2BKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555224; c=relaxed/simple;
	bh=Dob79JLU61QlceibhJFmCJBItL/foRUQzXV7whfB4qI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tntld9h3CjANjBdAauSxQ3CWaGLFw7Mj+QI4olR3ykXdNzPhxzfUAPepJ4agoflziCC0sSifd3XsQb1Qn2hmzgqXwemYG+6PSdLoH12H6nXOr+rMIJVKO3JPFuIOrPEWmg2OCAnt4nEXAaqDY0Uv8gK4FBN1iWzjauC1Eyxorvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ELbayeQx; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ELbayeQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehuNNX4hRR4psCpt0GZdAQ3U0GtpN1RnjYn4i5B7LRUc/IpgnBhG3uCobZS/L7NK3IIjzTAyQinSsT3+Zs2KLvCfKeSEUdobts+tBkQ2GdsWji0Hxqdr5YaARtU+KQFToXl6fapR6MECzkhQEpCesfDCuiR/qGcVjmvVveCfkjR7+fgV8oUc8iNtDZM+2itC8JgW2xPCK08ylkMwrV8qrJhxtMayitumwN2ImmSH7faGnWQ6na0uQTeEXaLDpX43a/hWL28kyQGQUdg4j5gUSwBuRb+xMe3Pbd305hbPGXj9zMueCg/tKDEXjjurkLwIRcT0Fr4DKWEiYc4C8sCUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfkyIPQLdKzcbiic3nCjuRsJVDDIyfoWlBiwxXkLuKc=;
 b=GJPDl9gkZSwze9XwDeplMc5r0hjdLDbae5uXjO0W+RGLh9uqUqPDbgi3OPHZEUN49tSHokvWAN9LFl05FbnUs4lGzT1mNi3YmJqZ3w4aMBD4MK8gvjzIHs8g3T6NI5KgUg/71AiElJtrBCLhPGqQlFHuyUZubST7srEsLYpJPrOzWX/WTA/Cq2NfsWQkJCv291+/Ub+ZILXdhaxBz6TAn3GGTG0Tnt9i+elx2MxHiSanB+om5cV+hHg+lO0cEzDr6PvW26qmWtWgoHNq1Xm8iObwrQGxF2PrxbCEuBJ+ZJniK8dMMJsjxtj0y60WaYP5eCOoGs1XSGazka6OtStdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfkyIPQLdKzcbiic3nCjuRsJVDDIyfoWlBiwxXkLuKc=;
 b=ELbayeQxgTF/zbmAGukEdeQBrxl6QMzCB3YpKIFevI2qBz+pQR21HcQNzUBNIIr+GIwsri82FYBWN3WvTHAfERw2BXJ46DymyZjL9ydHN8ElJrcgb9gNzEZ8WpjCeW3/suJbpSX0LOZZniv+cegU4fOPcg0p6wzH20CPmDEquUVRGMInk/VNjgqpuKE8UcPe5eY7GBI1+sNcRvRFaSmsLuQBq+OqAque86/Kh4pm0DDdCj3LQzz+K46KQLSugW2O1ayrd5cX+KmMoVy9+vQhPo00dny6GWlypokZPzCRYjlE6UlbxQmscZEq+YXeYSp4qN4DuzJ4aj3c99erCBNwSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7494.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Sat, 10 Feb
 2024 08:53:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Sat, 10 Feb 2024
 08:53:35 +0000
Message-ID: <cdedaf70-6aee-4dcf-99bd-4fe285ac4288@siemens.com>
Date: Sat, 10 Feb 2024 09:53:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] compat: Fix compat builds, switch to new
 ISAR API
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <20240209-flo-fix-compat-testing-v2-v1-1-cf0d7d52f68c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240209-flo-fix-compat-testing-v2-v1-1-cf0d7d52f68c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: f85314e8-d250-493d-086d-08dc2a15c40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T4cFiikTFV9uvuUkvjRXz/NMN/E4KU/6zVmlqNFLx2eYcHwwA5IGuwM++Ub23kY2Y8cN2YLXPxYjsSnLPNSpgag4Rc1lGQ52fXvxu8W+wyxoGI9foKSw4KRo4T7FJKJRtas906EWfc30Z9YJC6TWct7zD6LSpnDTJnElpBYVHqMw5lHBFS/xWZmJHMsak/vwMroQCe1+wl6+UoDp8lBbTk6kN3ImzYiUs9v8KOInvjrOMIOmGM+yXtCJ3kclkqA+7QNqknfqPzcvBSfis6tFM26QGC2Z+18MZSHITePpd+MV7Lj1YFCkoOnp15yewKeVwlUwSroQmogpCtXiUemYWtacrBbnErq3ufNoE8YNouQ83lE59+sAJyW1s0MJ/Z7waH+sgb/buAT0YevsnSaIp44tRfnPmI6hsm2BauSUfIZJilAqOxu10gko/dKiVXDcuCxeVwMcvyqhCX+cyQ0NVHgHZPc5X/CD5mXHP5htwucX5Hu/RjwGLkIo0/a5ie4JXPFMJ0dgfdY/evUBFQYkebWLnDNlv1YwUPvDcpiV23lQNVbgMLn3NcAKrBje83AJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(8936002)(8676002)(4326008)(5660300002)(44832011)(66556008)(83380400001)(2616005)(107886003)(26005)(38100700002)(36756003)(82960400001)(31696002)(86362001)(66946007)(66476007)(316002)(6506007)(53546011)(6512007)(6486002)(478600001)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlkyMXozRGpOK1pDOFc2aVcrSGZCaklxeTRxSjNibm5yejNhQ1JXL2ZCcG4v?=
 =?utf-8?B?T0JJOENqQUFBSHBydkU3SWMwSExxOGp1TTNQbk9vMXRrTGNVeklDRlBRNGdu?=
 =?utf-8?B?VVZwUDdGZ2R6dlFMQzdtK0k1c2RXNG1BeEpLOWc5d0EwSG1yNGljS1FBQ2Fw?=
 =?utf-8?B?L0ZRSTlOelYvVTZEc1poeklYVUNPU1N3ZWtLRWVkZG1PMGxPVUZRaERlUVk1?=
 =?utf-8?B?TnNrSU5BMnE3NVYrNzcwbmdiNHdmcUg5WVFDZ3J6b0NMekM3K2lCOG9lUDNk?=
 =?utf-8?B?RDY2MGo3UnJMZitRV3psbGNUWFhra0F6YW9JNEIrQmpIWDZiUEFBVll1MnlI?=
 =?utf-8?B?dU1tOXlzSHB3bjkvSUVuY1FiK2NzTkk0by9wVnJYSXZ0MWdRMWk1M0VNU2RV?=
 =?utf-8?B?WnAzdVlXZmtPN3c4V21XV3JmdE4ybDlBUlBEa21uVWZaQVFjYk9xc2FIUmF6?=
 =?utf-8?B?YVJnSkRDUWk2RnFiL29oN3c2MmdtQjd1Rk91cEtBVXVsV3JPK1MzNUtiUkpp?=
 =?utf-8?B?RnFzVjRNYzMrYWpPdEpPWjZjaFdqY0VDZjg3c2RpWCtmcmh5ZVJSeWRvd2pC?=
 =?utf-8?B?dGthUW1yTldESVMyUGhHYVN1SlZIWDJYUW8ySnpmSWtoMDE2NkFrTXgwa1c1?=
 =?utf-8?B?dEdQQ21IWkJIWUdjZ2o1YWxsWTlFQkRRMDdLSi9qZWYrUkxWcjBFN1ZuNnhI?=
 =?utf-8?B?R0FuY3gzL21kb1pwN0dEYlNHZGhzNXpwMGkrUDIvbldUU2RidUtHcFBkK2d0?=
 =?utf-8?B?V3BDUGxxalB3WHh5SllNUSs0Q2s1OHM0enMrbCs2K2NIVmpQNnRFL0tOZ29z?=
 =?utf-8?B?Qy9ENDJJYk8yaVI0VXNBQ2J0TnJTWTQrSk81bWlyaHpBYzE3aGo0R1BMY0FU?=
 =?utf-8?B?U2c5Umg3Ymd2NEoyMUpkWDlBL2V6K0I5d3o1ODBNbEdaK25mczJDVGJRQkZn?=
 =?utf-8?B?Z1Q4ZG5UaEY1dDZ2Nm9IQ0tOZGp0RVdIQ3hWeS9UWWZocnF1VWVsaW5JWHg0?=
 =?utf-8?B?NGpialV5ZGV1UXBXekxQRXpCZ0dxQnB6YWZUUDhBMytabk03TWtqSE5WU20r?=
 =?utf-8?B?SVBqTzBEdXpoNCtqbEpkWGZ5cEVISGlZV3g1NldEQjhaWUI0R3JtQS9mdHA1?=
 =?utf-8?B?SXJhTGVMODY5eDRGbGV5dHVnUVBhSEliZmlXQUtsemNWb0VpaUM3SEhuSDBN?=
 =?utf-8?B?TEVMem1IamNXQlAvaEhiN3B2QmhaOEdCM1hlMi9UQW5JUUdwMmR3alpxTDY0?=
 =?utf-8?B?UUp2bGIzcEdKL1IrYUVOc3FDUldOaDNpWjZTbGd4Mk1sajhTZGx3Y2FDcXR5?=
 =?utf-8?B?UGg3YWFadk1QSDc4OVVnMXc0WG9QT1dYZkc2WHpYOTN2ZTAvbVFoQUVzQ3Y4?=
 =?utf-8?B?Nlo1ZXhMM2FjSWtpU3hEZk40bk9BRG8wRWI4bFJDdGVJVmNISS9lZTBQYW51?=
 =?utf-8?B?UkNPWW1uUkFwYWdaS0lZbVNSdnZEQ1hsTDNucjFPV2h2RUNWZWVRdTArYW1R?=
 =?utf-8?B?aVEwamZTOUVZQllaNU1HQkQ4WlVoN1lKdUFkWWVpRXFZNUdBRmdYT3VEQUlC?=
 =?utf-8?B?aE9KdHZGdmV0TkhkZ0dJRHpLVFMyUE5WSm9Zc0NHUXZZelpLZlE2blFFSFpN?=
 =?utf-8?B?dUtQcmNSLzh4a1VBdzNEWWhSRUN6czVYaDIwODRNbmhhdXUvZWlBRTIrbUJu?=
 =?utf-8?B?L0IzUjhRQTdVTWxqbDRCK3NXaklrRmNJNUdRRjNtYlIrcDhwcFUvMWVSMlVn?=
 =?utf-8?B?SHpkNThPYkpVMXJJNjNnOEF5OVhCc1c0b2JUTWhyWS84YTlQRk1MZ2dXMkJD?=
 =?utf-8?B?d0JZRHZhYmVNQWIrTjV1VTg3Vy92dGI2dVlqYWRWYzllemFGcGdxVUk0MTA2?=
 =?utf-8?B?K1NWRFdBZUMrNEdSSjZYNTR5WHcwQ3luSHpGU1huYWVqYWVaSzFLU2I3dGNj?=
 =?utf-8?B?WGhGaUFSbWxXa0dNakpHK1FDbFgraE0rY0pMUWs1UGoyNmJTNEkxOVg5MWdF?=
 =?utf-8?B?MnlHK1orSFkvRjNIbVQ1S0hicXNwT3ZRRlBMczdNd3NSK3Z2WHlLSVFaSGFj?=
 =?utf-8?B?OVQ5UzBBd1FYU3dGbnZSNHNYRU03bjhRRU15eExQRE83VFY5dkRjZVcwUkpR?=
 =?utf-8?B?Rm5yMFcyR2FqSGFjaHRxQ25rN2x1T2lEcHIxRkIwQ2xoZTZQeUpobG5mcVpI?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85314e8-d250-493d-086d-08dc2a15c40b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 08:53:35.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcFxKo6gxzN5bayVlIxpK7NBgnBoyLZvg3Zc22gIrQPITxbZTYzRwfea5jcv05rZhKJ+E2dy6Q1l6rrbzDr36w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7494

On 10.02.24 00:09, Florian Bezdeka wrote:
> The last ISAR update introduced a regression, silently switching our
> -compat builds to -native ones.
> 
> Whenever opt-compat.yml was selected it basically had no effect.
> 
> Adjusting to the new API requires us to specify the prefered version of
> xenomai-compat in addition to xenomai. We have compat builds enabled for
> the stable 3.2 series and current next/master. The affected kas option
> files have been updated.
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
> Best regards,
> Florian
> 
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  classes/print-revision.bbclass      |  4 ++--
>  opt-compat.yml                      |  3 ++-
>  opt-xenomai-3.2.x.yml               |  3 ++-
>  opt-xenomai-next.yml                |  1 +
>  recipes-core/images/demo-image.bb   | 21 +++++++++++++++------
>  recipes-xenomai/xenomai/xenomai.inc |  4 +---
>  6 files changed, 23 insertions(+), 13 deletions(-)
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

This should be applied consistently across the whole tree.

> diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
> index fd2fbab..132a329 100644
> --- a/opt-xenomai-next.yml
> +++ b/opt-xenomai-next.yml
> @@ -15,3 +15,4 @@ header:
>  local_conf_header:
>    xenomai-latest: |
>      PREFERRED_VERSION_xenomai = "next"
> +    PREFERRED_VERSION_xenomai-compat = "next"
> diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
> index e19a038..7bb834c 100644
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
> @@ -27,9 +27,20 @@ def has_testsuite_package(d):
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
> +    pkg_suffix = d.getVar("XENOMAI_PACKAGE_NAME_SUFFIX")

... d.getVar(...) or ""

> +
> +    if pkg_suffix:

... avoids this test.

> +        for i in range(len(pkgs)):
> +            pkgs[i] = pkgs[i] + pkg_suffix
> +
> +    return " ".join(pkgs)

" ".join([p + pkg_suffix for p in pkgs])

>  
>  # Install gdb only for older stable releases. Enables gdb tests and avoids a
>  # arch missmatch for compat builds on newer releases.
> @@ -41,9 +52,7 @@ IMAGE_PREINSTALL += " \
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

Thanks for catching and fixing this!

Jan

-- 
Siemens AG, Technology
Linux Expert Center

