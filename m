Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9F480DC3
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523078; cv=fail; b=GrudWv2WDduKIExDJXxgL0ygrFizmgwwYx+S2DaZeC05JByu05cMOJVcKORP66hnps9NXivoGX0hricsx/l8bycPMwKuqcGKSpFnr27zQbypnVTUBI225Ih6we8F0g+e95sdVWyaje7CsyYWkwUaQCESMFbQGayS1heLGaEuKHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523078; c=relaxed/simple;
	bh=jOvKeGSC2hqbz9zKvuRHDu5/AQPpHeI2de6FNEdUYQU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IYoshfroELgKPmAh0KMLZ3xsRMSXBAKdUgyiarwdfy8oFwjO1coZKcwfyeHnyrWxxEk/0s46MWC2n44tOepskZE5+aL5QR/IfrviAQlLnq1XzvLHpAxQ6k+1lmMe63/QU+6/i/AGOkuCRFps6Rb468Lqc8zgj2Iwy6YxWoGfjoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FolBVEYZ; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FolBVEYZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eISQpL0i7UGAbMzR0RKdmDTkx9HgCfYeW3aiaJmQmpzkH9pKQroQz7/pQzHID44NgwYMhBsh4FmsCpE+9O9B37KoPh5HK50Dz2Wb2dXbxLaMUu+0NgbPrYPw8a+K/HHfcl5Bu8ybEwQ2gmteebSbGpuuID+Ct04dUvmnLXbAtGqaCegmkpfaegl3VcSFg5eBMb4fqehrxLo2OIOlsTng9lAcTDb7DHIMmOpSMXS/hawj8wsf/Fd0vvzFVLZ1AWPn2M7T8nYyhtbdHbWav/n1LPzNGT1qpP67pj52ZXe5p5Tguxf3Jy0tNcEngwP2GPlQBhl4TgMUo9qQFu7ByC/Gnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJbPpjHYu/fTnhj2ptmf8VJu9f7dP9VRzHMCz7oHy1A=;
 b=lj5sKLc7Y/CbT8iWszhtein9pzRsYVb2A78Ilm9+cr/hypiFQeRA3HmvE6UMFXRysDRKXF/lw8iBiY3lWWUJg2nYhMzRV4/QrgEVOHqOs2rHcciCGBPjVT9oFsTmmAO7aWu+Vgyp008hyNHBfYuwE0E0rDn3g/CWzx/ChS+jzFRM9yoCS5bTazXuRCNBfFvRdeIcE3WIgNNGLrMo9JD3OutCkAh/i1teizX9BLnOnLLXpZhrSFHeVD0Di5z3FUmD/0PMLAhE9jY9U7MWdHxZQV8fAIEwMgh/xfEkdShzqnWDdk5PTLB7wPtCHaV0/Nupb7IEB8cePA5FaCy1LivHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJbPpjHYu/fTnhj2ptmf8VJu9f7dP9VRzHMCz7oHy1A=;
 b=FolBVEYZy/EjXGVfJR+PvDVOoo8HKq4C3amUAdaUv42rM929u1Ua6lqXMnKDFmIaXaX25f7n2uUMNYmS50Bc5fkQumkK01GLPI/OTRqz9v4fzSdxSad9aTElr2UDPfQ2H8j3xsO6hY/8nh7hDcp2XrkyxhOl5oZKmqMU+tgERCLwel7LAw1wza5UGLgXLNqKRfEwRsTw9COR+xRthBD9ip7kRHFYg4dDEuBeyjxTqRlxJ0dLvBBUaIQ6UrGEEiHYGrAaJGtdoL2PBcLoWYhREQABVUijfDomyr3D+VhdKTuz/0fO7hUVr+q3O/QxCRpcEQPw15xoLLMj0EFGNY5Kxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9724.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:353::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 11:57:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 11:57:53 +0000
Message-ID: <15f5d6f8-350e-4468-821f-0b4c60a4a30f@siemens.com>
Date: Fri, 4 Sep 2026 13:57:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs(xeno3): Drop COBALT_DECL() to avoid duplicate search
 results
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260904115440.2981755-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260904115440.2981755-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 091f25c2-dc76-425e-421b-08df0a7bc026
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|10067099003|22082099003|18002099003|55112099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	g5omC+459utfJqRZZgG93tYgO8EVmEF0NUTMzRENWEAOfrubnVe58sfCC9xNIaMQznyIdynwW0LcgsaThgGfvO21+TfoDZtVKI7U+w+bOLKPcZwntp6PlScMf98DNx6/WBW5o1oJfPdcsjw/Q++0FSCygsTyVKZzWeknvxi0IYN/Tylh+wZswG30F4i9Dc4UorirsTeycZxWDbTWtYfcx4eEqX/HqXPkSftncpnAfekU4dvjYLuy3ckGCa5ETOKYPxTg65AVxHwQ1MH4i34tcPPOsmoPRi2mPOArPKaY9maTgBGNTATdA9yWgQkpLdTagsS56YbbVLPUbLz5+Y8wstMlEpYvSxzu4OC9NEWITMyi1rJisGGU3CjtvgkqeM9oHw4K0B6VfCGj1DBT1w4uil1Gk4DUySJN9thHjJYSNgKLhB2L26BVOmotnaoF/AkIj8vYWfFSNA0r3SS24kB/uw5yYXE/B74xF6H1XsywFJozDMeLxl736d0O5w4vphcOCKvI3144WaGevf+yf9Dk5eMgGJckkRrWfbTZAPrnwh4MxTotDyOA0tS/rEXPkU50rV96vH36OJXKodL5OPBszlUSFY4Wwmn9NB0dJaXmVGQAFkr5lbXXmkftCCTdwtRhgXsJWIsmcP+oD6rzYTfBq21XcQK0jG1vp6B2L/OKix8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG1UNUxabjF0bHNJbXc5V1hQeU9yWXVQT0lrdFRzLyt1U1VuUUZvVWNkWjI3?=
 =?utf-8?B?SkswWnRobUNUTnRkUDZVbDd6YjRRTnJBekZsMWM5UFZUaUF3eVFFY3E5U1ZS?=
 =?utf-8?B?WWxSRGdhS0YzV2JibHkrc0p1dDkvdWtNUjl0SGNOT2lvQ0tFalBnNkg0WmlX?=
 =?utf-8?B?dzZPemNsblNtakF0cXJGT0lnR28vTEYrcEl6OGV5bzJXdFd6QVJwTlFKL0Q2?=
 =?utf-8?B?eHI5VzhtRkxjWFNMK2p5TWVYY0htd3VwSys5YWRWQ0dBT3RRRmtuY2JwbEhG?=
 =?utf-8?B?K3d4MkgzZ2RieE55MXdPblVmQkVrY2lwTTdCN2VEblZ1MXl6emJ1RXlXZ2tn?=
 =?utf-8?B?OGNvZ2hweEh4WWRqRW5yVWxWK3dpUmlyaWQyTXVBN1lMZGJGaUtTRkErUkN1?=
 =?utf-8?B?eUhGN1dKMDFUeksvY1pNdFlGcGVCam5HUUtJN2NUSDUrZTRSL1d5a1llM0Uv?=
 =?utf-8?B?ZCs1OGF1S1gyMHVKMXpwSk9UQ0JnS1dPYVlFMDBlTVI5dytZMTgxSzIxSXhG?=
 =?utf-8?B?UkllS3pmellFY0hkOS9aeldXK1FQVTFlbU9vSUl0SzBhV2lmVW9WVUIzdG1u?=
 =?utf-8?B?YUNLSllDRlgyeWxEcWwxTnJHWlFUek5ud1BUbnVhVVlubzJNVFlheUpXaHZS?=
 =?utf-8?B?V0JSK0pvY0R4S3NDNWViRnFFbUJiZnFoVURYbDlxbEZJOFM0MmFYaWI2YStu?=
 =?utf-8?B?MThPWmpjaDluSTM2WmhLKzh0VEl0aHljU2FqNVBtS3ZDZDQzbVk2L0hLT0lO?=
 =?utf-8?B?MXJqOXFsTk8rUVhvZFdDVVdBQ2toNk5zUGRTckFKMXN1N0pzTzZwdzNoZDM3?=
 =?utf-8?B?UjZwSVcwQ0ZKVkJtditrWUpvdDF1RzEwYUtma2wxWE5reFB6SlBQRUlqS2J6?=
 =?utf-8?B?U25nbnFkSEZWN2FZSmZEbG43UTQ1QnV2bU44bmZVdkFyQ25qK2R6YkQ2V0JH?=
 =?utf-8?B?WGx3cmxGWEJneVNnK2tPWVdJc2JsbHoyNDYybzlIakRsaDJqdXRDQWNDbnNi?=
 =?utf-8?B?Kzc2T1ZFbTNJdkxtVVRnRmZNUXFSUmtUcEYwWDY4c1RERW5rMEFqRytBWnV1?=
 =?utf-8?B?SStiYzZhdlhGbEVzdGt4V0RaTy9EU3d2bnovY084dy9MWUxoa2wxQjJQOUFh?=
 =?utf-8?B?Mm9GaW1zcHZZTmYyMG9vcGViSXhSc3A3YkpBei9QUE5ISGZTVlY3WEdyZ0dI?=
 =?utf-8?B?Uzh0Rit2cTVIL1gzTFUwUXRSL2R2TmhybnNjVFhHUUZKMWRGSEZQQ25UTE5L?=
 =?utf-8?B?V3JzTVZCYnhnZ05IWml4cVpMUGRNQjFMK1daSFVhS0oxRVlwTy8rQVRVZ0Jm?=
 =?utf-8?B?eDFzVUhRb2FUbW41aWhTcyszNWtuZmRRUnVaUXFXS2ozM2xMbnEvUURpQ3Jx?=
 =?utf-8?B?SnlYODFQWHl4blo1YWJmYmN6Y1RlOTBGVXRrZVh4bWpwMFNvVmRydTlVNHZD?=
 =?utf-8?B?Um82QWg5Mk0wb1hkamhFRGF2NC9maU0wd1hVNGVQTWVDTC91Qy9IaXA5L3BO?=
 =?utf-8?B?cERncGpoMTNZRi9Wc0dMbFJPdFVLZldyMEFDV2tUcmFxTzBOSE42TFIrajJ6?=
 =?utf-8?B?dzlXanlFcFBNMmV1dTJKTk41UXhoRW91cklCQjVpa0NDaFd5eEhRY1VNOCtI?=
 =?utf-8?B?KzZicXIyR3MrbFQySHFkSmVVbGNyR3Z2NkVoekw0dVMxUTNNL2d0K21sSGlT?=
 =?utf-8?B?RE5yNjlJUUtxQ084dTh5eFpzaXErLytGOTE1YVJrRXc5UThtL0xHbVlCaE42?=
 =?utf-8?B?amlJQmdEbFFvdDZ2NHhxK1V3WWZ0RnBDKzIyeHQ5NVBMUEJVL1JVanlCSUc4?=
 =?utf-8?B?dnROZmtuallGcU5CdTJ1aUtlV3Y5WUxPd1NBSVRacnF6MWYybG5Ra0NnNUhr?=
 =?utf-8?B?RkZZdXNhd0VnRjFrSjZQdFNxN0NBZ0xOSTlGa3RodzBpRVlFT3RKTnhsck5P?=
 =?utf-8?B?RkVUeUFXN1h2aG1ZUXVVWlFQcGxvbWlUMXMrSFVlRlBURi94RVBMRllsUkkw?=
 =?utf-8?B?bE9CdDdpbk9CMVE2Y3QyUXEvaFRQaGNtb0pYMXhKeVVKM0RsVEhSdDR2aDZX?=
 =?utf-8?B?dkx3L243SStTQ0tEZ2tYZXNUWmRDblp0d2lheVZ1bU8yYUx0Vis5Z2EwUTJu?=
 =?utf-8?B?SDgwdHo3SHVDdFlLMmJkQTExRjlWYWZSNjVTQXE4Y3MzdndJQ2twSUJTbUM0?=
 =?utf-8?B?MWUybkdzcmo5T2FIaE03cXVWWFl3dEcyQkZmRmtiQk1ZSkdXdDh5dDFubi82?=
 =?utf-8?B?T2dyVXB3V29uSlBNaSt2QUdnVkVhK1YxQWNwVzFwZ2RsNmpNZlFVcjBYbWxM?=
 =?utf-8?B?cSsyMDVLN0tKZURDQ0tRWldrZ2wxdERIRWdZZEJCSWNDdVdUYnRTZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091f25c2-dc76-425e-421b-08df0a7bc026
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 11:57:53.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63XHtfe8sB4CuQ/PdHS0BdpCLT1lYEj7qW/wD9/eRbQd0fe2e5ZDyrR0AaerQD/BJybNcVI77u7+3Y7b6XGc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9724

On 04.09.26 13:54, Clara Kowalsky wrote:
> Expanding COBALT_DECL() causes doxygen to index the declarations from
> the headers in addition to the documented implementations of the Cobalt
> functions.
> As a result, functions appear twice in the doc search results, even
> though they point to the same API documentation.
> As the function documentation is attached to the implementation macros,
> keep the implementation-side expansion and drop the declaration-side
> macros.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  doc/doxygen/xeno3prm-common.conf.in | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
> index ee4ede10d..33ba35ee9 100644
> --- a/doc/doxygen/xeno3prm-common.conf.in
> +++ b/doc/doxygen/xeno3prm-common.conf.in
> @@ -648,7 +648,6 @@ PREDEFINED = DOXYGEN_CPP			\
>          "DECLARE_BITMAP(symbol, nr)=unsigned long symbol[BITS_TO_LONGS(nr)]" \
>  	"COBALT_IMPL(T,I,A)=T I A"		\
>  	"COBALT_IMPL_TIME64(T,I,N,A)=T I A"	\
> -	"COBALT_DECL(T,P)=T P"			\
>  	"COBALT_SYSCALL(N,M,T,A)=T N A"		\
>  	"COBALT_SYSCALL_DECL(N,T,A)=T N A"
>  

Sound reasonable. But did you cross-check that we do not lose anything
that is only visible to doxygen via COBALT_DECL (for whatever reason)?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
