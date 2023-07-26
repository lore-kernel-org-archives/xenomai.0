Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680CA93E
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 10:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4YfK1p3osRLdsEDTRDyYy+aeQPuLivBajtqj3xIkD0DzvR9f5UP2EOAnjYv7HDos8WDRwkONQ2mkPesP4kaGTWvPwEXV0MRTUzWkjAvLxFm/kz5/sN5GBwCtrY8qjJ6etIl48azIQl6MSvYfOi/bS8CRIxKmvOdSoMDQiddq/NkgJDyrSfAhTSj5ckFG2jMftSVoocTQ2mEMAJ8IRSaNHxaAQbxcxFITej1Y4VSw7a1V9x9k36HFjEEjmtm4tScxIc9ONm69Zk/Txrohb8zMWzRjN8QBz5GwMUxvofQLJ7YrQR9cEmskjli23qR9DONh6ElqDn8mzhWLOhcGvubIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnhzkcmmiE8zI0HDhNL3VFBKqjkqD+4H9VTmaFVycpE=;
 b=eMU06OeAEow7EQMbDdzi70iaqrqCku+YUZuLd6Zb7tl1ui6x6Yr8ezcwj/PBVubQDt+E+RJC6SmIDWAc42YGQFPlijhxRE5k0hPIq3gPEe/qmhWavQ8c3tZgIcIAPqsxLK3R2+JLlH3RDZDShUJsrolLarcWU1fe8LC14JbKbtIhzHfL+AG9aOt+Vdp+NmDUmaXPPVddGRR1g8gUw8V4zDiKsr7f3NxGGUmUlIk7SJa+78gEjUOi9tV+VSA7TlTyW1kh6frBlDSH+UanQP+rkz6sBAxSPd+HsRsQQ58lR+Dm6qv4G3lJtM631QBFNsA1oXpMQY/I2OhLM0Xh6UJd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnhzkcmmiE8zI0HDhNL3VFBKqjkqD+4H9VTmaFVycpE=;
 b=AWFpx3YeLcCfQwO0pDAN854RS9KRbSijP5rwRhO+bQFR8iOhBFF7FjcgD1/woXn45kHdvw4I4elKU07Ga0XAq5ztancV63efVZ2UY2oN9Xvb52swePQ82bizW7LIxV21tpls9lfmkRgRzPgwx8DEcpu7G5tFH9HtujvKaWgvPnnh6uFI+hp8xsJQzP19uz5EDO+FNO1KIYhHdLugcjkaJyh+ftLMT8tdE81qG8brP92SJqnyT6NXjcnha5ZD/c5kIj6k+MBjO6fzzdvclR0FJmUiIoDCAaN3ifWgZyRqNEDg45QyfHcVemSfHaiblGql63mowJZFgNHCy4SSm/kn/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 10:11:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:11:55 +0000
Message-ID: <336eaa83-f369-f018-e781-be4e4d5f858b@siemens.com>
Date: Wed, 26 Jul 2023 12:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [xenomai-images][PATCH] xenomai: Update to latest releases
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20230726091332.182910-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230726091332.182910-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 580efa39-0fd5-4e85-5e56-08db8dc0bd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3oxw4l+7SzpLg2VHtqGbNmI7ntgA1W5/bQt52y9e7msBhxAqD0YWnVQFPGKjVxwUpGvX80yNxg4m58cvBtIJnrbWRzFKWO9NfZcBXOnFmzILTt4HytwuXvytBuyZlcvXxzIQtjLZ4lorovPECbpqueN6/q9dWWZKjWxZzF+bJPVD8z/+bI/IYsfySzYxOKI7mWsyOy/q39Bw9ocaYhFHA0uVlawAJAlDw6P/ujlpxiAzfZeAluzYqhls/wNqVz2t4eF4KO/G7qTUhjFfrYtd+sUvLmlPyRSXcZeTrblqc4d0SmrCDt5US1SWT8wFAwJiIz/jsGkal9OPNXJ7z9LNcJNUibkt299K77iQn6qXleqBZ7Wn0iteZJ61WSginDRRAjJEp43KWkxcYFHE6TpmfPmkSCem474cIKUkN7A67Eed0OWpC8YUyW7HpumqOlKEGEVkBb8Yg068TT2zS5ei/EHC1cJRQSRIJNAzBsVeFQQyf1iYOQa0Vcp8LNMDAwUOK6mSCclhAnxBCUS0gkpUft213xPX3LFnkF+fTtF90YfsIZEZ2POFy48gAjouY8Bn8CCvFi3ITHetiNH26QOx6087xXL49in5t/BG/tujGmW1ztGBlWBGTIgFN87SwZQ+BUnpvqsV+8H9K+l64B2yZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(41300700001)(26005)(53546011)(6506007)(478600001)(38100700002)(86362001)(6512007)(36756003)(8936002)(8676002)(31696002)(31686004)(186003)(66946007)(66476007)(66556008)(316002)(5660300002)(2906002)(2616005)(83380400001)(44832011)(82960400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWhCVVBBcHpibEdSSzNoeFU1dWhzbWdQdTljdGt1Q3JhYnAwakxhTS9JTDcx?=
 =?utf-8?B?eml5WlkyN254clJqekFRVXBMRnIweVd5MlZDV09JZGJnb0NVNjROUWcxdktj?=
 =?utf-8?B?bUQ3VS9kWGJYWDVXUWFFcG44b1B1QXQ1MmZtbE9BNzlTMkdWWjFIZ2JIR2dI?=
 =?utf-8?B?TXdSUy9oeFRkckQ3WGtBaG5FWDUrL0VXZ2hkdzYvdm9FL0VGMmNPMGtKdVRy?=
 =?utf-8?B?aktrODZSQnJXYUlCV2swaHNkd29TbmdSQzFXeVY5VWQ2V29aUWpvYVZnOUpt?=
 =?utf-8?B?eFNlYnpxRlZVMDNEUnI5VHNVQUh0QU1UeFN5YlUyOW9OTVpEYVVCRUpTU3BK?=
 =?utf-8?B?NGxEamJURmdBMG4yNytUTzUvZ01QTk1UbTN1Q0ZzNElPUFFHRFluM1pRT1cw?=
 =?utf-8?B?M2xmUnVQd282ZitFeHBDZXl6a21jYWl1Z1NrSXlrK2dVdnM0Rmd0VXVxN2Fj?=
 =?utf-8?B?ZVVvRmpmODBsVEVqemtBZHZLN0lRLzAvK2licnRTWGk5UnZMME1JUnFoNmRD?=
 =?utf-8?B?Y29OSFYyNE03QmdveDhMUFpuOWMwWUVSZFFLc1hrbUE4RCtXMG9NRGJHazFr?=
 =?utf-8?B?UDFtQmF2K0dSVmRybFY3TmdRVlNuOXQwUWVQTzU1Um91T2paQVN3WTBld2xO?=
 =?utf-8?B?TFFFZ0JrdVNTMXh6UEc5QlFmWEVDWVF6dXJGTU9PMVYwVjdOd0FDWkRPV0pI?=
 =?utf-8?B?QTgrOXBwa3dvQzU3eTd4dG5BcFdNRWFWdVNvMUg1TjE0dTY0V2lzbjNBVFk3?=
 =?utf-8?B?L0g2WlVobk5aRWlBRDNCQW14bUV4aW81TzRYeWt2SzNBYTh3bEhxbTh6Y0ww?=
 =?utf-8?B?MHIrTU9IUkJCaXRCMjVMTy9XWlNWWlNwelUzWDJON1U1Q3hiQzZ2ZUg2R1Nn?=
 =?utf-8?B?RGltbGVaTUdSMGtGMEVkMWViYjdrdU54dWYvZUVCMXhVck5RQ3g4OVZxNER1?=
 =?utf-8?B?VENhMjUweDVHcHdWSkZucjBHOEpDQXY5L3o2Q3NEVE5OSlU4eEgrTnVFS0Ir?=
 =?utf-8?B?a0ZmQlBDN3dxcm84ZjJ3SkN6VXZUY1c4ZDVSWFNkWUR5R3FxZnJsSEdySHlZ?=
 =?utf-8?B?QURQSUpqL2ZaTXNBUzgrRmRTakh6LzdsQVNWOGMzWVJzeEdlUGdxR3RVSUFq?=
 =?utf-8?B?UnQ3N0QwYnNPbW9kZ1NUZW9KWThUV2RwbzlodE82ck5tLzNJdVJIamZ1MW5C?=
 =?utf-8?B?QlpFdlNzTFdMNFRwTFhiRXhmRExhZHFxejV0QkVoQ2d1VVNNNzRodEtsdEZC?=
 =?utf-8?B?RlpicXNHUktDSjRISCtITGZBUnZ1SG81eGRCZzUxdUFKcXVIL2Z1UUtFS00z?=
 =?utf-8?B?dW4zN3RwRHhGdUQyOGZxQ01nc3B1MktiTjN3b2huQk5sM2xGdXdRZVFGZHFP?=
 =?utf-8?B?ZitGaGRiQnU3UWRDZ091eitFUzhLQTNCWFNXSnpRVTNkTG83MitobTVJdXRY?=
 =?utf-8?B?OFltM3habjJQMHZkd05tLzFvLy91L0REcHVDSkJDQW5WTlRiMUdNdFJiSE4z?=
 =?utf-8?B?dDR3UlFaeUhaVzB5bGkzS2JybkI2V2RYV0w2Z3RmNlBkaVkraXJqQjQydHdU?=
 =?utf-8?B?T1k3MktDZFg5aUV5clF5UUFhWlBJS1ZvZis5bTFjOWpIYUFsdGhINTZGZEEv?=
 =?utf-8?B?ditOOS9PUklYbXozVGErYmd0bTJGUzRVb09iZ2FzWWVVc2Q2YVIwdlpsemEy?=
 =?utf-8?B?MGZRa29PM08wRHZ4SG93eFpMNjgxQ0NJWGY2REx0WnhjSFZGYWlWbW13NHdD?=
 =?utf-8?B?NitHWXlNQXpRRkxndHNYc1l3TUFLcTVxeEUvUWFaajNFb1hETlZnK0UzSWxV?=
 =?utf-8?B?M0VRdG02eU1pYVgySTlnQnJuSThOeHNsbVBWSHp0dHZ4K25IZnovSW1QYVlY?=
 =?utf-8?B?a3paa213ZGFKVHZpdDAyMlh3YVAxODJJSVV0eXk5U0VwZzVzczhERjBMdDNH?=
 =?utf-8?B?WWt1R015WkhHT2puajJkSEI5YTB3eUhObndaWEVxQUpPUkNRamNyV0Z0aVNk?=
 =?utf-8?B?M3VEeUdDNVRFMHhHcWI3aFVKek1McHlrTnREeDVPZHltUnYwTkJXRitULy81?=
 =?utf-8?B?TUpOUlJtWEl1WXU1VUdiZndRTGQ5SFpSVjhhQld4aXBsUmVCSjJXQ1ZYdnR0?=
 =?utf-8?B?VXBDMlJKVmg2NkJUdTBjazA0bjgrVENaYUs2djA0OWZ3UEpHS1ZRbkt6M0xO?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580efa39-0fd5-4e85-5e56-08db8dc0bd2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:11:55.5384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usWC9HTCyDsTkM9hc+25/wykyMXVXsjBXq104sfY9DeFjtEg1C3XIJnjoliEudSb1ZsDgcy2pbwIHkenW/151A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5195

On 26.07.23 11:13, Clara Kowalsky wrote:
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  conf/distro/include/xenomai-version.inc                     | 6 +++---
>  .../xenomai/{xenomai_3.0.13.bb => xenomai_3.0.14.bb}        | 0
>  .../xenomai/{xenomai_3.1.3.bb => xenomai_3.1.4.bb}          | 0
>  .../xenomai/{xenomai_3.2.2.bb => xenomai_3.2.3.bb}          | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename recipes-xenomai/xenomai/{xenomai_3.0.13.bb => xenomai_3.0.14.bb} (100%)
>  rename recipes-xenomai/xenomai/{xenomai_3.1.3.bb => xenomai_3.1.4.bb} (100%)
>  rename recipes-xenomai/xenomai/{xenomai_3.2.2.bb => xenomai_3.2.3.bb} (100%)
> 
> diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
> index 61e86f7..a8d40ed 100644
> --- a/conf/distro/include/xenomai-version.inc
> +++ b/conf/distro/include/xenomai-version.inc
> @@ -11,13 +11,13 @@
>  
>  XENOMAI_DEFAULT_KERNEL_VERSION = "5.15%"
>  
> -XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.13 stable-3.0.x"
> +XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.14 stable-3.0.x"
>  XENOMAI_3_0_KERNEL_VERSION = "4.4%"
>  
> -XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.3 stable-3.1.x"
> +XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.4 stable-3.1.x"
>  XENOMAI_3_1_KERNEL_VERSION = "5.4%"
>  
> -XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.2 stable-3.2.x"
> +XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.3 stable-3.2.x"
>  XENOMAI_3_2_KERNEL_VERSION = "5.10%"
>  
>  # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
> diff --git a/recipes-xenomai/xenomai/xenomai_3.0.13.bb b/recipes-xenomai/xenomai/xenomai_3.0.14.bb
> similarity index 100%
> rename from recipes-xenomai/xenomai/xenomai_3.0.13.bb
> rename to recipes-xenomai/xenomai/xenomai_3.0.14.bb
> diff --git a/recipes-xenomai/xenomai/xenomai_3.1.3.bb b/recipes-xenomai/xenomai/xenomai_3.1.4.bb
> similarity index 100%
> rename from recipes-xenomai/xenomai/xenomai_3.1.3.bb
> rename to recipes-xenomai/xenomai/xenomai_3.1.4.bb
> diff --git a/recipes-xenomai/xenomai/xenomai_3.2.2.bb b/recipes-xenomai/xenomai/xenomai_3.2.3.bb
> similarity index 100%
> rename from recipes-xenomai/xenomai/xenomai_3.2.2.bb
> rename to recipes-xenomai/xenomai/xenomai_3.2.3.bb

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center

