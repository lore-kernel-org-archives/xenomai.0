Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B130323
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HGnWXdRn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9+Hslv0lCMmuLCoGEcsaZfUqjVII9OMKPr70BnpR+1KTxvf8FPiomSX0TXxVvZL7q5cP5gdUz4axYrhIC/Z5fn5rs+klqYY14r4yr8MdAil82KKsN2+JR2840ECURU9W7QznB67VC8dBIJVCdjcsdODA+84UxPocslcNQTbNIGhoJ5ahCprcIKNSwB/TrXnaRHwRP9ZRsc6KPsbK+1sOpNdC8WY42ALy2yxfQozftG13CiqLInCY86fQgjWKFz0FMC6ZW1jt0ySvh0KC7dbvQGS9h3FYALLDPYuYqzg4eDPZ5a9w4gVI9gv7lyJXNJPUvxAqFEcKX8/XD++k0scIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNdWKDLoyR+SeiPiLXy++5mVYPJ3vA5Vd0L9wlbfso8=;
 b=dLNPFjmpVOWr4a0jCVoVjIriDIL6Rhs5AW8AMk5mdjIaMR52xca7dlgmyMsIwxakWsJLfWl8oDGodQO7tkc4G8Wc3KZ6Z95jWrN+S5T7PaeZw1ESZuxXasg7h//P6903RkE7GT7eaHShP+Woq8A0MkdibbhS3tc2mzn6E26gzUTGByusSqKhUFPfI344QEkuKQbxk4eIW78kSD+KCYYOrkBXLDSBOb95IpoqzBNDy3+UdH/Fw5V6MHSSF3Vvy4bo+oJnWD7lCbrGdLXjh9mYlmsrUrTNu9IGt3p1oqXfSfDjMKB3xlX74fx3sd+uVrtIcV4PUK1uf3z1dzvZNr5PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNdWKDLoyR+SeiPiLXy++5mVYPJ3vA5Vd0L9wlbfso8=;
 b=HGnWXdRn3t2eHrcwDoypk7UiBDcaq78PeEeROzCWjB89dT7or/AR5kTOE9+0R2kAeRYhPZZky0UduKu0m6M1osp0eitGLabkG37aLgajX0/zCOZKdmRUvOH9OhPgeuLlL0U45Tt0D3TitmjFUOcRrr1BMKoBV/E4rggr8mWdOCPN7Xj+nTVO8NwuWiJDYLA+cevv3+YSk98PIYRZ2HWCeAQhV8H0nOfH4nsPR55aFXvwU3JM3XIgjMxXtHVDtU4OhUsi4eMob3EWf2pCfaYiAiZFP0PLTBxV/WjHM31jkHSyIlh24C4aljT0BG5zWyS0D/XjCVNIdFGudJ0egXwFEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3764.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:01:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 14:01:43 +0000
Message-ID: <08b7c3b1-046c-4325-b7eb-446a3ada7386@siemens.com>
Date: Fri, 15 Dec 2023 15:01:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH v1] build: Add debian multiarch support
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231215114252.2913765-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231215114252.2913765-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3764:EE_
X-MS-Office365-Filtering-Correlation-Id: 7387d099-839c-46f6-defd-08dbfd765e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ak3PnoJSbBnLDXHW4dyhTTHTOOoaj1+1iRBEHb9qhoCrWfTqQlaQbi8h8O6EWsFBxEcLcL3NJpqXYmcr4rmH+IAxt9xmU8ODKkA65dsFQsdN3J/E8YOSdIXy/AaSNPmUnuC4utzxI8UpXxxtt9EgTNmpLEcIcXjJMOI15URfB5KznLDuGPIFVx4PFudWwJfuLi1sN6Y3bzlK/JBm6Tntdvko48Y3K887DShYvFljV2qkeydpBTgZ57DzIe0pqXRo0H6mpEAayaVd8WftQmN/iRaw09sQ3O++D12cDW/WUmjJ0Uwsx7RgzQrCJPOKsqqnfb+8MPENCLhL1etydvsQQCvmQD51lRKvW4tSeVRDki4PV95zqH2ro1eSB2cTBChwvdb13+BN3OpDQ/MJoG+ZDwr5vmyUmDjfN5EnLbc1FA9zTCx0ozJKmb53hcdCSEPyaztYN80u1iLwjd0b3JMuSaH4iBBPCsONm38jgoWgBoTTzdbNp0EBUv0rt6MurtMyPCHEAGDxFlGV+TMOwrRNI9UXJXxFV2558ykwd5JWyAs7PuH4tHFr0qbXsz6btortbcYMEdXon64B3YssjxO9BgPs1idNygWTXMrmOzkRkCUMyy0ssJISgfq8bNq1nx305T7nnTVU5UUCNbtTp0MIjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(66476007)(66556008)(66946007)(8676002)(6506007)(53546011)(8936002)(6486002)(5660300002)(44832011)(31686004)(478600001)(31696002)(86362001)(41300700001)(83380400001)(2906002)(26005)(6512007)(2616005)(36756003)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFpQcDQzay9ubTNKNkp4TUhoZkZqcEVDN1J6UmdKMmliMHlzOVNzOFBoYjF6?=
 =?utf-8?B?a3E4TzRCakg3S3RKU3FhTGwzT2RaeVBGZThMb0dOOCsxN1cwVmFPRndNcDBi?=
 =?utf-8?B?OEhsTUFEUUhEdnlrTVdoOGMvVnlmbHMwaFk5WGxsMks0Uks1RVR4Z2d2a2RW?=
 =?utf-8?B?dnEra0ZTNVlKNDNkMEdyMmgvNTRzVUl3K0hYK0hiNy9nNnQveEZJV2tTeXhN?=
 =?utf-8?B?RVljSWlTcHJCSm43NnBmck1KRVhIVUcxMnd3b3dGSmRWVDIvRTRFcExCZzVM?=
 =?utf-8?B?aEdDelNPNjFxbTU1cEJnNm1oVlpnWGdUVjkvMGc4enNoWWlCQUh2R1YxZkh0?=
 =?utf-8?B?RXcxbU1vNmFRazQ4dlBrVFFWNllWUG5FSWU3TlU2S251SVlPdFV6S0tBUVc0?=
 =?utf-8?B?aVFlY0k4eXdVTnhYYjMwNXQyWVhDc3o3ZGlPYTVpTTZOTEhCSGtyY0FtbnNZ?=
 =?utf-8?B?enExMVJyZVFnODBKdEljb1ZnY2t1OFprVWc1MWVuY3dodmkycU0yVXBKNGlv?=
 =?utf-8?B?amhwbEM5SkRKUkxrTUZtVWp4bmVYZHVTTVR5Zi9rVW9UVG53b1p4ZXVqZmhH?=
 =?utf-8?B?dFJHZ1BURElvMlExVzFxTmZ2anN1c2JSUmNsNWl6QkF5TzFSMTZXUUVaYUtD?=
 =?utf-8?B?TEs0Z29ubjgydGNRaWdMSWhzV0xRTWVINm1kWEpiRkhkSVR5enpjRTJFQnI2?=
 =?utf-8?B?Y1VzMDJCdG9jNWYxdUcvU1RYWnZmaEZIY1VpUlQrYTFsMlFsUHhXdjM4dVZP?=
 =?utf-8?B?eWZqMi9rcEFTUTVlSzFYcGNacFR0NzVMck9XK3dRaTFHUXRFYmJvYlJ3TGFZ?=
 =?utf-8?B?UXJ2Wk8rUGxIVGxydFRPUkd4YmV6eTY5cnFER2dXUjZUQjFIc3d4UHdlSzJr?=
 =?utf-8?B?WEhvanNFUTNmeTRKckQ0L2wvdlZmclhYK3lBZ2dZZmU4QTFBRWhreWhOMXdS?=
 =?utf-8?B?VXk5c0JxcTF1QWNNcmZERzRIRWh4U3NyWWpHL2xlUlV6Q3JGZnl6SjkrdTQ1?=
 =?utf-8?B?UnZCSWc1U093aG15T1FaVGJRQUpoVUpPZHdnSEowRlFhcnRNYk15d0l0Q1Yy?=
 =?utf-8?B?Zm5FRWFsQzdEWGZUUHdqYzZXU1BPcklyUFlnZ2QzN28rNGNHT0g2YkkwT3F1?=
 =?utf-8?B?SmppVlFvKzFKZmtMbW1WQ1A4aFIvOEo3aXdHWTk4ZU1HMlpNZVR5NXp0bUQr?=
 =?utf-8?B?b1piTFRZQzZwL2htczl4NXhPWERJSi93MVR0VWVCemdlbG80aUs2NWY4Qjhk?=
 =?utf-8?B?Vnp2a3k4U08wcTJNL2x0VXZxYk15SzJsYXNkaDlCNnRyK0xBN2RFdG8wdGdj?=
 =?utf-8?B?bkwrY2VHM3JJbWFlRDJ4dWYzTDM4YXpzRmRpSGVrNHZOaGM1UmRidzEvcXhK?=
 =?utf-8?B?WXpuTUd6b2ttOEt4czRta0Ywb0VJZ3kyU2c4anZWNjA2YngzVXVkYStaZUdH?=
 =?utf-8?B?TGM0ZnJvSWk0UmdmUW5MN3g4ZXlXelJMSWY4K0JkNU1aa0RQZUlDV29zSkNo?=
 =?utf-8?B?OXgrd2Q1a2lGaVZEeHlBcG56eE1xWFdWVUF2c0JNamVFTTBhZ0tDL1VoT3hZ?=
 =?utf-8?B?OXZKMlVsRHVTbjBKR3NZMkRYL09zSnBaSklxU3paRi83dERNY1NUSlZPZlFK?=
 =?utf-8?B?N05UclBRbFFCblBWSWJsaEJOTER6SWxROGZuOS94YVpGQTVpTWZnNExlbDNu?=
 =?utf-8?B?M0VTWWpBem04S0JrNlZCSi9Rc3lacVRDRVNkNnJCMytVaDkxcEd1c3ZxUWFM?=
 =?utf-8?B?NDl1cXhUQnhzT0RnNkhqaC8rNnBWTmVDckQ3QmZLQThmT0dGR3VQclYzZzY5?=
 =?utf-8?B?QlhUNDVZME8xOGI5NWZOZGh4eDNhNDNDS0dPeDhwYnZKemd0SHA4RVViY29m?=
 =?utf-8?B?T1k5aTRKMTdHMlA1M0FPK2JKYjR5ZE1HQ0pLazl6UEMxQnR6N3FVWUlUdlpQ?=
 =?utf-8?B?aVJUSmxrY1hJZHkyalBrK3AwZ3hvb0VQcytyYVZxQnVBdFBjWTdqVUw5L3Q5?=
 =?utf-8?B?eVQ0UFVCaWljK0toQzQ5YU5qdEJuVzF5cHc2QVFJb3F0Y0lsQldNQVpsay9v?=
 =?utf-8?B?dm9xSllqWkMvK1lRbW1RMTVab2lLVVBhaHNCbkpPcENYVTVMYnh6OGVlY3JR?=
 =?utf-8?B?dnpsczZ5RlNjY25wWGpWWG5jTUhkakNuNnNmRWxZbEQwbHRUbCtweWtQbTQv?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7387d099-839c-46f6-defd-08dbfd765e67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:01:43.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W0DBf1Sax5uWp6k1bQbvZBT8vniLOoFadX0rN/hg8s/dnCJG6UnU24TpzraEO0D7LZXZ3zXe3n98LXQ2xHQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3764

On 15.12.23 12:42, Clara Kowalsky wrote:
> In view of introducing the possibility to generate evl images with
> xenomai-images, multiarch support for Debian is added to libevl.
> 
> The multi-arch variable can be specified in xenomai-images in the 
> debian rules file, e.g.:
> 
> override_dh_auto_configure:
>         dh_auto_configure -- \
>                 -Ddeb_host_multiarch=$(shell dpkg-architecture -q \
>                 DEB_HOST_MULTIARCH)
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  include/meson.build | 2 ++
>  meson/setup-uapi.sh | 3 ++-
>  meson_options.txt   | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/meson.build b/include/meson.build
> index c7c4860..0019ae5 100644
> --- a/include/meson.build
> +++ b/include/meson.build
> @@ -1,10 +1,12 @@
>  # SPDX-License-Identifier: MIT
>  
>  uapi_opt = get_option('uapi')
> +deb_host_multiarch_opt = get_option('deb_host_multiarch')
>  o_dir = meson.current_build_dir()
>  uapi_env = environment()
>  uapi_env.set('ARCH', libevl_arch)
>  uapi_env.set('UAPI', uapi_opt)
> +uapi_env.set('DEB_HOST_MULTIARCH', deb_host_multiarch_opt)
>  uapi_env.set('OUTPUT_DIR', o_dir)
>  run_command(libevl_scripts / 'setup-uapi.sh',
>      check : true,

I still think we can do that without exposing an option to the users.

How about passing ARCH to setup-uapi.sh...

> diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
> index f2d0774..fe37469 100644
> --- a/meson/setup-uapi.sh
> +++ b/meson/setup-uapi.sh
> @@ -2,6 +2,7 @@
>  
>  # Expand anything in the UAPI path meson did not (e.g. ~).
>  UAPI=$(eval echo $UAPI)
> +DEB_HOST_MULTIARCH=$(eval echo $DEB_HOST_MULTIARCH)

...and then trying to call

dpkg-architecture -q DEB_HOST_MULTIARCH -a $ARCH 2>/dev/null

to obtain DEP_HOST_MULTIARCH automatically? If that call fails and the
string remains empty, we skip setting the link below.

Jan

>  
>  link_dir() {
>      if test \! -d $1; then
> @@ -18,6 +19,6 @@ if test -r $UAPI/Kbuild; then
>      link_dir $UAPI/include/uapi/asm-generic .
>  else
>      link_dir $UAPI/evl .
> -    link_dir $UAPI/asm/evl asm
> +    link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
>      link_dir $UAPI/asm-generic .
>  fi
> diff --git a/meson_options.txt b/meson_options.txt
> index b4d43eb..4075a31 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1 +1,2 @@
>  option('uapi', type : 'string', value : '/usr/include', description : 'path to kernel UAPI headers')
> +option('deb_host_multiarch', type : 'string', value : '', description : 'Debian multiarch path')

-- 
Siemens AG, Technology
Linux Expert Center

