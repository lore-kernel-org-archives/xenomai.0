Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC3219E8
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qTkIOma2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hui4BYNxfBbKrLC08cKD2rcCEPNk9n86qnn7Lyro3aM+s7dIM+xGPko20UJAO3VJ+aUZ9FP+uK6S70KXKs3VJzQBajEDjs0sxBcYnYkQBwWb3V4Z3FFH3GuEApH8QSrOH0qxWyGE7ZNFOb7Jag8BfvOuIWHQQBd7tbdLYyqmfNLPGm56jJ3T0CiQ/Lsa3Z7JnerBdIel3uOfwDLNc4MEe5Gfmi4qPYYXz+4ff9QxY69uWK6/1PkBQZHKjeTEelxHy1uR/5GwrUIF8V0NKmlfdfhNWOxGCL9K8BXBu2HDALzPUM5bUpv2UvmhTZ751iJYM3qyVYc2A/zBIpBhEbrBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mh/r+q6HX7zTEZA+PM0/p0alPd+s13QTbNs401EsQ4=;
 b=R2lW2Y38c7cv2swumvQsTjMJYdCxPdMdJ0VPJcfzphFEoG2QxzVqRHQP4pOC87VQ71mswXT8nYTE9dAtY+zYFstZK70tZtQqcXl0av5c8QN3AuilqgrqfAt8UsXvkCa7SFj12ehE7OcJ83zL4EF53s5BKnLNFWP8VufNHeg5oLxTZilKDe08KXl0K7NU/TrvvZKp5w3Z3HRnKSfRpDeY3hKZQ7CFauD0zG04IXCOSp81XBsEHME9wp/dn4cL/1LHN8g40mx/YeVYjZ8eQx4iafr+ErWhewzdg5Z0MbvX35qm2kHrHavSSP+pHKKOJYRNOAJ25V1TDQsTBsTzOGDzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mh/r+q6HX7zTEZA+PM0/p0alPd+s13QTbNs401EsQ4=;
 b=qTkIOma2Qb52sOjPKqkvEm6EOT/RIQW27kklm0iPY03nE5zqaugWfM8drmVKqr8pJAIn0Pdz4TJzdUDe3oa8gTyjZ5UzW/dQn4qq8VKpk+iqHaOAeUtgykBSxICVSg7T5P5RyOB14WbdijIVsqykmz6MMcPULovqk2nbSCjvZms5HqiM8M//RnjFj4lfXtsAqnvEzCNOXhuyOKhz1ubtOIq2jv5OWB51VmS7wnSo5HmZUQGimqDw9WybCbHxuZU7y73+ebR1xlgHAU4+r9agijKaFD5jDfNPWsUc+g2UpidgJ4zh7kEg5dZfS1DHIYAwYoG3EeTUSxGVc3FnjYqKLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8290.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 12:38:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:38:57 +0000
Message-ID: <54c5b159-a59b-4d1b-a9e7-87dbe033aecf@siemens.com>
Date: Thu, 4 Jan 2024 13:38:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 2/7] xenomai-3: Mark xenomai 3 specific
 configs
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
 <20231221163743.2923801-3-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231221163743.2923801-3-clara.kowalsky@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eee1ee1-b7b3-4ce4-ec7a-08dc0d221e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JRnblgvd8v1i/wmUslJUHaFaB40tfwTAi/O+mHpZyb9GqmdbgLvJHwlRHuROZ9zKGknY16cxlB9dYb3v3tj+jOniPIl3BWNxzSPpGwrOnzVky1gPf8Po7Ut+7wrq9GWfFEQiZzyQ4DnGVExUIeShLyS3iRDOJplHVIlc8p6M2sdOtG1uK5T2ywF4C1z2VZhmshULF3cvVmYJthhcqD5jSIwji1+OJMNlnLqoDlpMaAPphBOiNu18M2Cr++IzYKfmmswgrad2qCAwIoqTP6ky4fvpukvD+J2M58oyIFXWncoGKqCIkoD3kKpnpvAZ5wF168RN4hpcY+n6eOJQF/tboqVpPiAn/mIK375tGSJnNLJLAJB4DvzxqkuL/4kKYqRpZDPXw55EC5xF/YAXfmdlk6dgftlinHFeGKWQhq2vthcmpGIVeml7g75C1738cGL1U9n1FtTEENQUCf5VX3/V2C4KGUVBTzXg+9mNNYQvOAD+Pj7FqjU8s9iB5zLKbtQZJTZGkhQZFULItPx7wWjNjeOj+q3qJzZOfyhvsMa1sxm5QkCOJ29G6PKVQs3Re4lGfsC8+iaembTuB1boyGBfbx90YxmBbEUTzBFVkW4ksOSWKz5AzZpgNuzNBNGRcxBOGSI8GFLtDoTJi5pU5QiDww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(44832011)(2906002)(5660300002)(66946007)(6512007)(478600001)(53546011)(6506007)(316002)(66556008)(66476007)(8936002)(8676002)(6486002)(41300700001)(38100700002)(82960400001)(31696002)(36756003)(31686004)(86362001)(83380400001)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmlXdkxPT3hCcFQydms3Q28xcm9mU1FBZllVd200N2pyZEYreEJVbEE1eWxB?=
 =?utf-8?B?M0V2YzdvWlNGS2h1NXVBcFAyV1pvN1NBcDIwb3dta1U1d05zd2pRdHVLcnNF?=
 =?utf-8?B?NkpjaFM2SWhRWGlXWGNOU2tGOHY3S2FNU3lBa2ZZNVBKdlpDV1MvTllWUDVP?=
 =?utf-8?B?bTJQZkNMYkR5SUlwa3VBeGswaEJtVVBMT1kwOHFhRUZHQjJ6YVJXc0lMZXNC?=
 =?utf-8?B?UEVZbmszSUZzK0hhdTJHcUphVHZab0tNeWg2ZzIzYWZUVUxGeWpDTlQzVndC?=
 =?utf-8?B?S3Y3d3RRL0VDVTkrVys3Sis3UVp6dElWR2pvR1ZZaktWNW84aDYyV2FNaCsr?=
 =?utf-8?B?RU1lcWRSRSt0THlNV3VobVJDS3p5dmltTmV2WU9xQStlcDhJNWlWUlJLSGJw?=
 =?utf-8?B?WnJIVHFETWJSajh1cG83V1c0ZW9BQUk1MzZXdFVCZGZmdGVDYk93WmVOUG5K?=
 =?utf-8?B?UlZsZVFuckVFRXh2ZC9qM0tHUEJTQnduL0NOZDBYenRkL3F6SHExK2xkWjAz?=
 =?utf-8?B?NjhpeGgzbnBsRGc1RkVaR0RWamh1a2dGVDJDMkpVbDhkWVVBU0JhZGVzenVj?=
 =?utf-8?B?RUNER1loZzBNVkdRa0hiVVpLMWtzVDNMVEYzckZjOXVuTStJYmwyR2psR1Q4?=
 =?utf-8?B?dFo3L0JFM21nQUVpSm5CUWR3U1JrSmJmOU5FNVpKdmQ4c2s0L2ZrYmpmOThx?=
 =?utf-8?B?MUt0RlJ0VWVxV05KK3ZIOEFKeE8wZFUvM0dGdk8wa0FPTGRRbCtwNzEyNW5m?=
 =?utf-8?B?c0RuU1pVL0FKc2FqU3JaV1NEdVRBeEN5anZ1OVU5OVNlV1huQUVSUG5XTEIr?=
 =?utf-8?B?WUc1TjlHNFVLY09uaTJMRUdERDd3RG02MmNHd0tNWnJYc3BQTEVMU01pdFdz?=
 =?utf-8?B?ZDdTSmZiOWRCMVgwNk9vc2VnNURmTnBZZHNiK25pcG9SVnRoVk9PYitRSWZx?=
 =?utf-8?B?Qkx0OTROUkwyMmw3SFRKNG1KMnROanVvVW5oR3gwOEN6aVJtTDU4ME1QckpX?=
 =?utf-8?B?MW4wa0d4VEFMK3RWbnUwTUpmdU9ZaDBPeSsrNU5xcE9KeXpMK1BHSVZZSlB5?=
 =?utf-8?B?UkFwM0tvV3YvdGRBSkxHRk1ocURuL2dFMmM2UXUwaExsREJZTHVENlIvb1JW?=
 =?utf-8?B?YkZXRGpPMzlaTU1rZ29WUnpXcXBoYVlaVEJ2NC9zRjNzRTU0QitoTWtLT3JM?=
 =?utf-8?B?NWZtNGp5ZkJZM1d1V0F4NXpuenZmZUtRaEwreitsRDk3T1prODZRdDZFT3I1?=
 =?utf-8?B?SU9NekFXRnp6S3VsemJYU1dzK0xJSzhXekxUWmhsU3N3ZVg2cVdaSzMraUJp?=
 =?utf-8?B?R1N1K0lCTFlNV3d2eWhhRlRCdnY5RTZqQ1VJVHo3cW92UEhINEU2NVNkZ1hM?=
 =?utf-8?B?WmM5cUpXZEk4VWNnbGUrY0FuTndHRzk1c0R5TzZXbm1COFVBU0l5Z2V4TVR0?=
 =?utf-8?B?Y2pDbVRzNGZVeGNucWdNbXkydHV3aGtQdlp6eUlReFFWbjd4dGd6ZmVSTFVn?=
 =?utf-8?B?U0QweFpmaDBzbkdnMkptWDM0YTBoMVEyOUlJNnMxL1JINmxPMXlYdWpjMUl2?=
 =?utf-8?B?TE1jVWsxTWlpNTdoajZCRjNwMk1BWXR3V2R2bTNTeFI2YjVhejdkZUxzdHdB?=
 =?utf-8?B?R21aUitFV0h1aU9Eai9pUmtER3pNR0dvQ0xmU2l2RWVjVUNzVlhBS0hnVGZY?=
 =?utf-8?B?YlRES2hUMm52M3hnanFmclNvUnMzVkhPVWhlS2VLVjdTM3B1MlVyV21YV0hi?=
 =?utf-8?B?bXdwU0RubnZDQVdmMDBwNlhUL01PUkRIbDZ6OFhnUlVlNFBJZDNMNS9vT2hV?=
 =?utf-8?B?WjF0OGc5SHoyWGZDOCt0OGpHMXB1OTFwdEpBTzlSeFhpd1RyZnNSL2s2MTFJ?=
 =?utf-8?B?dWwxMkVCaG1hVEpJZXRTUlF5VFB2WVFwNTRxRzNHSG4vTFFsWk1zN2ZZN0cx?=
 =?utf-8?B?TC92TldGUjRydlhya2x6bHo2dUdOemV5Wm95RFByRGhhaUdTdnR3dmJqRjEw?=
 =?utf-8?B?NDdSSVJyL0lWZnZPNE44cTBKQ0p5bG1FL3NJajBsUTIwdGRmN0d0M2RnQXdi?=
 =?utf-8?B?RnZzTlA0QjFKRENYbHpHbEhLbjhrd1hDK3kzeHQyQkV3bGVKYnJqcWFNMjRS?=
 =?utf-8?B?SUJEL0Z5RjVtK3FDdjQrNDNXcW9SV2pEalNyU3Y4VE1DWFZGdjJVYm84SnQ2?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eee1ee1-b7b3-4ce4-ec7a-08dc0d221e78
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:38:57.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKDHilyBryauhUYysu9tth4M4IO+zq8k4TXof9tv6jOTSohyTThtOC7tHObd0nLvJhUFhbX1ReIDhGFEXCEnGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8290

On 21.12.23 17:37, Clara Kowalsky wrote:
> In preparation for the integration of EVL, a xenomai-3 override is
> added.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  conf/distro/xenomai-demo.conf                  | 2 +-
>  opt-xenomai-3.0.x.yml                          | 2 ++
>  opt-xenomai-3.1.x.yml                          | 2 ++
>  opt-xenomai-3.2.x.yml                          | 2 ++
>  opt-xenomai-next.yml                           | 2 ++
>  recipes-core/images/demo-image.bb              | 8 ++++----
>  recipes-kernel/linux/linux-xenomai-3_latest.bb | 2 +-
>  7 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
> index c99669d..d96cdaf 100644
> --- a/conf/distro/xenomai-demo.conf
> +++ b/conf/distro/xenomai-demo.conf
> @@ -16,7 +16,7 @@ include conf/distro/include/xenomai-version.inc
>  
>  HOST_DISTRO ?= "debian-bookworm"
>  
> -KERNEL_NAME = "xenomai"
> +KERNEL_NAME:xenomai3 = "xenomai-3"
>  
>  WKS_FILE = "${MACHINE}.wks"
>  
> diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
> index 4559de8..35714b1 100644
> --- a/opt-xenomai-3.0.x.yml
> +++ b/opt-xenomai-3.0.x.yml
> @@ -15,3 +15,5 @@ header:
>  local_conf_header:
>    xenomai-3-0-x: |
>      PREFERRED_VERSION_xenomai = "stable-3.0.x"
> +  xenomai-3_override: |
> +    OVERRIDES .= ":xenomai3"
> diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
> index 2479e96..c5417d7 100644
> --- a/opt-xenomai-3.1.x.yml
> +++ b/opt-xenomai-3.1.x.yml
> @@ -15,3 +15,5 @@ header:
>  local_conf_header:
>    xenomai-3-1-x: |
>      PREFERRED_VERSION_xenomai = "stable-3.1.x"
> +  xenomai-3_override: |
> +    OVERRIDES .= ":xenomai3"
> diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
> index 1abcef9..54d0e9a 100644
> --- a/opt-xenomai-3.2.x.yml
> +++ b/opt-xenomai-3.2.x.yml
> @@ -15,3 +15,5 @@ header:
>  local_conf_header:
>    xenomai-3-2-x: |
>      PREFERRED_VERSION_xenomai = "stable-3.2.x"
> +  xenomai-3_override: |
> +    OVERRIDES .= ":xenomai3"
> diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
> index ba0b2da..9d74ed0 100644
> --- a/opt-xenomai-next.yml
> +++ b/opt-xenomai-next.yml
> @@ -15,3 +15,5 @@ header:
>  local_conf_header:
>    xenomai-latest: |
>      PREFERRED_VERSION_xenomai = "next"
> +  xenomai-3_override: |
> +    OVERRIDES .= ":xenomai3"
> diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
> index 540583b..db7e2c7 100644
> --- a/recipes-core/images/demo-image.bb
> +++ b/recipes-core/images/demo-image.bb
> @@ -33,7 +33,7 @@ def get_testsuite_package_names(d):
>  
>  # Install gdb only for older stable releases. Enables gdb tests and avoids a
>  # arch missmatch for compat builds on newer releases.
> -IMAGE_PREINSTALL += "${@ 'gdb' if not has_testsuite_package(d) else '' }"
> +IMAGE_PREINSTALL:append:xenomai3 = " ${@ 'gdb' if not has_testsuite_package(d) else '' }"
>  
>  IMAGE_PREINSTALL += " \
>      bash-completion less vim nano man \
> @@ -41,7 +41,7 @@ IMAGE_PREINSTALL += " \
>      iw wireless-tools wpasupplicant dbus \
>      lsb-release"
>  
> -IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym"
> -IMAGE_INSTALL += "${@get_testsuite_package_names(d)}"
> -IMAGE_INSTALL += "libxenomai1-dbgsym"
> +IMAGE_INSTALL:append:xenomai3 = " xenomai-runtime xenomai-runtime-dbgsym"
> +IMAGE_INSTALL:append:xenomai3 = " ${@get_testsuite_package_names(d)}"
> +IMAGE_INSTALL:append:xenomai3 = " libxenomai1-dbgsym"
>  IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
> diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
> index adda9b5..a9c223a 100644
> --- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
> @@ -72,6 +72,6 @@ GIT_BRANCH:arm64 = "${@ \
>      else d.getVar('LATEST_KERNEL_BRANCH') }"
>  
>  SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
> -SRCREV = "${AUTOREV}"
> +SRCREV:xenomai3 = "${AUTOREV}"

Why do we need to override here, in a xenomai-3-only recipe?

Jan

>  
>  SRC_URI:append:beagle-bone-black = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) else '' }"

-- 
Siemens AG, Technology
Linux Expert Center

