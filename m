Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E666AD3C
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 13:14:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbMLUjR0+EpwLJwGik4sEcn7IEQvUsbDk4nvMGvNn+H0ygrRNFMGztdACxGyPVKmWm+HT0kVKjkMmkQYzRJAz7kWogOnrIzmXggIyOVbGdCos+Ohd42tam6dkkSwiz9Tda5ucryynX4QdACFRxzgeafEKixjZiL0uzjmcw0NuutjHoaGEViKeOOCw+4BEv3o18/vIvXQUJU41TdDJtfQcOlesfeIwo8YVExpZdsQcY8wersEJGvnfTYnQSwQq9+63XU9GX4nHEAzVX3bSDWXVne9Eag7es2Weg0s0hZf6dTSRam/lQc7bmY8ogsOW42WloSRTtwOtlRGWZK47SfjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rT7qBjHhchNeRgzSJH+bYw/+HBlIyy+d/eTOHj+0QI=;
 b=XFH+nZJ/C7RD1eyAP+03VtvuDGQ2UFZ2pMLA86raXXSBUutAr1pBrQubgc10d0YZvq1NEQmcN6L4MmxOgh2ge/hCfAi9WdLPrfbEQpAkK+D534mOsl5kjjJkoYwQeK/HuQDfy2lr/LRkz7brHuHzJLqC0p4lqApFn/cR0utvwRm0fVr+aPeCHYeEejyFK/YYc/zeXLZUQz/r9ndxNhpgCRls7SfBiBlrRkDRr/y2g96bD4BKgfkbzhpMQ8txy9X8N71WZ6l/kgvizxcRr3bqWxNPUMA2jTGuffkVSOYR5r6SJ6YOP7RdGBa1QvEdzS4JvMVJIEX8W35yPUVOBI4m5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rT7qBjHhchNeRgzSJH+bYw/+HBlIyy+d/eTOHj+0QI=;
 b=n5g4VVggZRW+3FybJEVxWZuVgOMIYbdcCejLIdYKN4PtmSLwgg4QdlaYrngj2vfrzohvpbywP+3WD4sk0Swj2ioNpJphKES79ncpgPQYYIYQJZryvCjctLlWWD/4humKHfS8mb3HJU1cKjyvdCHafydau9L3+5fWGVzUvQ1u0fKFwqgk4h4uEIXWi2641HQNjJaEKTDDG3D/nKf2x6BuIwW9ux0OGC1RfeO7pUFrClAUaK4e1E3C+twc9J/1N+YKklkUUPaeGOpn5PuoMxN7TUxTS3RGXqbHaVfuYfXA5gcb5RSNOUg/pmBsgW8nyu8enyrFy0G640GDA7gbfKFmvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 13:14:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:14:54 +0000
Message-ID: <d204d4eb-8c74-b7b1-3e2c-0c12795aac14@siemens.com>
Date: Mon, 17 Jul 2023 15:14:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [xenomai-images][PATCH] xenomai: Update xenomai 3.2 branch to
 stable
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20230717125309.1423429-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230717125309.1423429-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3837:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dd902f-7290-40ad-d67f-08db86c7cfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z9T4Yj4MKlzeqqXxweoVRqKk4kX5ncKwcwInvDcHCrh5cLRf13XD4kbSSukVkfy5IfJoFUO/DMLgAElEMyi/D5A+8C3UBqQC+0ogyADVK4m7Np+W3b6URy6EI4A52sOgcNOYN9xcjvhTrz8r0OeKiCP+5JQx/iMcyVjkuhCsiddVfi+xpJ6fsZ+vb4V1g3RqlVn5wpQDurjwqDnEMc1sMVB2MLJFRphWIPRv7dWb6DuTDcbAIHF7FVfszLs5IhfjalRnOJUtwHWZjFDippCajPsrURFLXT3/dCfyWvIUbpEtBrCyUZf6dM5G1DZB3RypZC4nBeM8oetWFyLdEbHPmR46KmeSgeTElg/EYwnlhcXJRJ13WbI7upx95TwlbRo+hD1u91C8yXs0A+qILBU6ba6kpCh0iKsuZfTwWgeLWP6VYUyLSU+LgoZH9QHMzJxDKx5ImE12O7MSSxtVao1gIQmI7H94zcRLdo1ya2tCf/ztAwQUXuXaTV35/fF4IPMpG7Iq3EybAObCAj5xt9UMPHnabFMW7aPduvn39WCQYqsPNBuEDzdfVrIR/S4SFuIhMJH8VWZJkFtXMiDHx938oqv6BUhMk+yArCUriBpDeizCEEoiBbhgXRdUIbqfVjgTN4MpdTrdEWQcTvimjo2DQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(478600001)(6486002)(6666004)(186003)(53546011)(6506007)(26005)(6512007)(2906002)(15650500001)(44832011)(41300700001)(316002)(66556008)(66946007)(5660300002)(36756003)(8936002)(8676002)(66476007)(38100700002)(82960400001)(86362001)(31696002)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cldTclljRjNyRm1ERzlpL3hxbTd0U1JvYk9nbVRmdUR6S0I2VE5TMkozNkJ1?=
 =?utf-8?B?eWJjSFZWZW9zem43ODNienlUd1Jacjk4RUJ0VXYvamNHOENQTHhuN0xqSVAr?=
 =?utf-8?B?WENUc2VzZzQwczJsWENiQTB0cDUzN2diTkdsTnlhRTVuK2lqU0w0TGdpNmpQ?=
 =?utf-8?B?MmFrN0tXRjFncjk3UXdoS2tMZk9XSERhQWlTUGhpSzFzVlFoVWwzVU0zUys3?=
 =?utf-8?B?dVZyS2xyRHpmNXRRYkNvUFd5K2J5Y2RRcXpwOUk3VXhBV1FEWnU3WCtLTzhB?=
 =?utf-8?B?WkhHTkswRnVVMUk0NW1Ta3E5TjVFVUZRZ3JXYTlVQkNNd1g5UWQvM2RqbUM5?=
 =?utf-8?B?Ymo4b2prSnV6QUdZREZXQkhqTlNDVFE1bXRWbFRrVkNaOW5wYm8yOW9KSGRl?=
 =?utf-8?B?MnlsL3F3a0FmcG5qYmpMcldyZkVMSnBqVU1xTnE3RzJPbVZIc2wwMnFCbVFx?=
 =?utf-8?B?QzRoTUc2L0lvVE0zNThnY3BMMnBxTXNyQmFkNnBWYlQwS3BuRi9rUk43Vkl6?=
 =?utf-8?B?S0J6RkkyejBwczF6RnVsVmtXbmEvZHNiLy8wdnRMazQxcUM4VkNsTzFYMDlt?=
 =?utf-8?B?M29Rdjd2ZTk5SzVaOUE1NXkrSWFwOUJPMkNOUy9BTTFVLzVjNWVqTC92T0JG?=
 =?utf-8?B?Ri91Sldlb2pQVDZsVjZXeUpPTEdPSGRvaGZ5a1QzNW9NOFNaaW5PdXhQQU9s?=
 =?utf-8?B?bXozb3RTdmcyTTJTN2I2OHNML09nVS8xVnNIV09SdUJaQTZMSCtkVlhwa2Z0?=
 =?utf-8?B?c0dHRFhBWkorem5Ra3ljMFV1Z3pSa3VFTW1XaSt0Y0NRcVdvWmhGTkRyR0Er?=
 =?utf-8?B?WGt6TkdYMnl1SE9xUnZRcUVHeWdaMVJQdE9FY0ZKNFFhZ2MvSExBcVlHRGU0?=
 =?utf-8?B?M2FjK1BJNjB6MjRpd2Y2YXZ3NVhST0JyRjZ3S0twYlc2MDgrN1NRNXhXakZ0?=
 =?utf-8?B?ME45QjdwT2pzTkYxaWJxYWluSmU3NUttTXZJR3M3V2NaaDZvQjVwdmNpQnAw?=
 =?utf-8?B?RXBtODBzZ3lwaTFSL1FkOXJ4NEdEUTduVVdxbnlHb3N3Rnl6bGtWTm9HdUVI?=
 =?utf-8?B?NEpHVlpSb2xhMk1yR3Y0NHNML21GWlRUWUx2bjkwTDdESFFGUkpMdzJQYUR2?=
 =?utf-8?B?TGN5QXAyb1FRblAyaWJGN2xhMklYT1RTN0dIYVNXV2pHV2VvSnZwWDYvRkF3?=
 =?utf-8?B?ZUYwN0FpSEh2V0RneUVEdFJOU1RiR05rT0tlRW1YME5LdlQrWEJocTdIWUp1?=
 =?utf-8?B?OW10eVBEWloxNFZkdjkyRCtja0JjaldFQmY2MGVEY0x6ejJjU1ZYVTZvZ2NV?=
 =?utf-8?B?K1FTc2FzSlBHMkFVeWJFZkVOUGlOeFovdVd5TndPRkNkRnAya2FnODRKTTcv?=
 =?utf-8?B?UmQ1UzZ0ZWtUZms1M0d6WlZmeGVxWDZYVVdCTlkzZ0lSWVBzZjFYb25xR2FY?=
 =?utf-8?B?a2xFSGM5OS9IeTdlQ1BJUlZBcGNtaktMRzc1anYybUR1U3R2SmVMaGtsNzE4?=
 =?utf-8?B?bVozVjNGTENNR0hvOTZZRWVIUDFUU3FnL1QxaFNPb3NBTHQ4enlBVEZsUXpV?=
 =?utf-8?B?cXFFWGFpWUhSaTVaTE53S2RLVU8yb2N5ZTVnMGdXOWREZFpZdjBKQ1V4bS93?=
 =?utf-8?B?U0FJdEMzbHNvZ2NhUnp6REtvcWJzaUNhZC8vSmVTUXE5bnlKeFF5bHZDaWlG?=
 =?utf-8?B?YVE1bEJKOTRiOHE2c2xKclRhL2tYOS9qeUZ0QTRCNFBtODl5RnI3NDR5VmZE?=
 =?utf-8?B?a2ZPUkVwZE9DaldqZG9CRGgrZzlCRno5SnZKUDBsQ24veXRiNWFySmhEeC9v?=
 =?utf-8?B?YVgwdGdNdUFpUWhzeTJUYTQrb2tQcUZIcjdSelIrZkN2S1Mya2xBSkNsQUcx?=
 =?utf-8?B?SlBiMW5oeGs3SHdiU1BXcXBPYTVxYTZwTVhkUndWc1UyYjhOSDZ0aTRzVG1j?=
 =?utf-8?B?dHlrMTF6eHM2VW90bUZEZ1dwZzJHTjVIbmZJSVdEYSs3bkR2ZlF4MENmUTEx?=
 =?utf-8?B?dTU1K3BMVTJNcjBWS1hvamR2UGRaMTJGVVB4Y3BWOTcrQlpMRUJGUEZ5eE1F?=
 =?utf-8?B?a0VTUGdramdwc0lWZW1WSFFGd3U2N1FCR1dLOFJvcndaV3RnbzJQdUcySThh?=
 =?utf-8?B?T3FPR3UrVkNUdnpBUUdPU0VSUVhPQWlHRlBDaHNRQlh2dHdXUVJpdXpBVWEx?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dd902f-7290-40ad-d67f-08db86c7cfd2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:14:54.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfK6Ib2prTDdW7N+WKFNauM+FV/5YtEq+5xCOfRl3JTSyWXui/pmvfwRDC+X90tv+RSclEjA+NqbPGjJbWDVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3837

On 17.07.23 14:53, Clara Kowalsky wrote:
> Stable tags like 3.2.2 cannot be found in the master branch. 
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  recipes-xenomai/xenomai/xenomai_3.2.2.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-xenomai/xenomai/xenomai_3.2.2.bb b/recipes-xenomai/xenomai/xenomai_3.2.2.bb
> index e99d7fe..f32cd06 100644
> --- a/recipes-xenomai/xenomai/xenomai_3.2.2.bb
> +++ b/recipes-xenomai/xenomai/xenomai_3.2.2.bb
> @@ -14,6 +14,6 @@ require xenomai.inc
>  # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
>  
>  SRC_URI = " \
> -    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
> +    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
>  
>  S = "${WORKDIR}/git"

Oops. We don't check that in CI, only build the latest branches there.
Not sure how to address that best without adding more variants to each
and every build.

While at it: Update to 3.2.3?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

