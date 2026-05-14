Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66A330662
	for <xenomai@lists.linux.dev>; Thu, 14 May 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750020; cv=fail; b=o1lFSZhtMEbA+drBOhl3jTfCXasYp+pnNsi922It6WDZfEhMtxL7nvDu8dU9kNfHeLfaDmuNhN/rh79/RMG82S6LCwxR1lOEr3e7h5RD/HgJXU8ylhvE5qd6yCvnMv3pup0BG3Dij8bTjmTvMh2uccOaIzQ/ya2YApXPTp1JX2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750020; c=relaxed/simple;
	bh=AFQXU00JIusu3njvdUglm5c7ALxkbGtMVbaB7qiBXkc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k438fBPs5PndVD6/Xe5MLTYOqIHdrFhPfvHgUd5V8Mcb6cfeQmxBndtsyFfE62/PJcyH8a5oloBCUTzViFZw+bSXsk05xHEKMTzBypoq6g2aMpdd9UWTooMu1dPvxTxT7Xou9MIzxZoah+2YGSDs0L9u4fEUr7HXtWK0wnbFmg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cW4mr8I6; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cW4mr8I6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVhAnabREVgTfGncj8Od0grXMGyU2+FEGiGcIXF6Sed8okCHG9fmV1urduzwsf4CRLhR7i7QXe1Hm9Sp8InZB3E+P9EFLJQKyx43krEI959EKtVdQ6oi8U5XVc7bc7xti40tPA596twDufaEj2tHmOKR/e3UkiE+O0OL6jdwhJaBvr0FoaTyQnKnL2iAfDwscDhrY6kSdfUq0FuSwlUxX2huhq46NkpPSrGugu+yLaDA1eqm/ok+D+Ww570Kzf04OVfuDYw9kz1/gmaRsIleV6i0L5z341BP2YBiXT+V1iPdeZ1PFXAaTm22YZCV8znOv+QwgWayOsnQyucCnjqPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbkQKFrAmWo+5Ql3GeYtgheBXy4Z749vVIieOkK9diU=;
 b=HkAZfysrxPBvqbQUj4A3tpMs/55kozToxN/k+jGvRB2Ulv0yYY66tx/1TzEzVHZ1EQtrg1e/6S8RECAt7RIbkv1LcrguotR1iDWHr1Jy5UKd+AdwGnU0yiNS1SP6Hmk6RL+pyD3Yi/lOcF7Xa4Y5lxVwTZNz05qBW1PxPF8AsQzL5x3hgJ/4rHkAC2EVqOo4BskrMMq66EJO4mgV80b/sDZgIB1DbEnrtGcsnLTnLdXC2qmD4KmAjkaf5zz1o/tmx/aEavT74S9MLnV38OL2M7GHMqcI7ZLWWBSxTr9YzMxacxKzyxdNzgPJPc2yeBS6eUVmx/wNjpNH2FlvPVdg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbkQKFrAmWo+5Ql3GeYtgheBXy4Z749vVIieOkK9diU=;
 b=cW4mr8I6exP46uPMVdkoxBYREWIO2rYUZ6FedEAIjYU6LCLhrldN9AAUJC1C0duKRQJ+ayysYmM6+N9IPZ2F/JZfFzEGOp8CJ3tLgiJYqqsqfJNzTbt0UsixXZEBAZNQoQxFUMLU3C+HQ+zlQX92Sfr2fxiwhqh1rPKqoZwrkZdMMRhpiFzjErXizPP733VtFiclV9NCTL07h5O3wzdcjRqFfzAyFAibDV/zhUDsBz3p94LwY/gCSUDuJ6VWwVbuyiB+Jfw15DbCZrg1qolfVCZ4YUXnJdOfFYJqq0t1SGggGE2OWAZY+wpk5cuHVcIOLX4z3iWxyKdxXtowIcd2Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRZPR10MB9891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 09:13:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 09:13:35 +0000
Message-ID: <4b429990-1700-4a84-96b0-4f449e4e7e07@siemens.com>
Date: Thu, 14 May 2026 11:13:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] Add test to detect spurious suspend wakeups
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
 <20260512071703.2830843-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260512071703.2830843-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRZPR10MB9891:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e01de52-b7b2-4362-18f3-08deb19913f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799003|4143699003|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	cqSrwf8zNaHAsr6lNBdYUkWGXHRlnp8D4DbmbZe/bQy2+OmMo1+WBqWnrodGdZB9XesVYIlp7PTqDCilRr+YFVOjaBXfakDGuVVA2KQTIzMErU/mU/EGXYRBU/F8c6jh60Obx9DKYteEF7JkIgnbdXZMQXW4Lb2sqBUNJD1+bdRfr2lBlzm1wWf5EgMdNZC3/it15+u83b8QjfzCVieWYWZW6m3bhCptV98+kLPymj1wBNRvH7LOXLUei9cRzMMJPWXPpVC1cdhDTrqmlYEdxPiO/VHejCwOPkMaM37TtEyqdf0PbMyGIvbhKEQCKG3pp2KsJWuR+MdF2XPFwCiUI2d3oySvrc2rLVhoMfLwoGmJRgPOf/FOHsAxWfdeCnwt47eAM72DUDImsJIxamUNw/52lMW2Sw7BRoWyXk9qDldfDNBZF9M9UicPVFJZvXE6OCdDOkOuuN2HWgvxRIzociPY0vJsm46OXJbvr2hkD/36x91/7LLaVENky9ZrLmvu3EaitXAEOzW0iQ2kZNz5YZJ2mKsARQcR0kjkhYyNq+cMYDwyC85wvcyPqene53Lyy/rNggcXuwD8IyRgI9pUsRCOE39W8F6xCpgBHsTdaWINrB6orK9EVRB+/jsKsJP4verJ/iyFcs1/2e0+FjUfXbq6YswlD9xcnXechSOvdY/c/mi8jIChv4MiYIYa6/bw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME5zMk5kajNEM3ZXOHR5RkNZb3E5NnN0cXlvcm5BMG5IT29zRzkrRmZ5c2xz?=
 =?utf-8?B?VWQwaFB5NmNicmFidDFpU1dGd3Q0Sk1wSDREV3FPU2htOXorTzlkb1BlR2o2?=
 =?utf-8?B?aWkyR3JELzJFbzVDOXpOZDZqMWZIOHZ0bENKWC8wUzZhTHU1R3ZnK0NJWklw?=
 =?utf-8?B?YUEzWUw3MGdGRTFsUFdlUzYwU2xmZ2xIMlN3aGxleVpydGZudmsxRFFoWkcw?=
 =?utf-8?B?OFora2huZHQ4SkVuRS9VTXpaMGZUdXVWMVJNdmNPK04wcHNIaDQ4ZGpyaXV0?=
 =?utf-8?B?N2RZazAzeG5DRWwwTHBIZStmazl4OXNab25VaUw0Nmt4ekhWQUhUWmxObmxD?=
 =?utf-8?B?aUFOSkVjV3J3aGVCa3V1MFRJQU5UY0JLZGF6VW9lOENLeC9FelFZdGtaQW56?=
 =?utf-8?B?YXRsS3BVM09NdFgzRVBVRVdmU0daZXNKTnpXc3VqWndLTFF6ck1pSkxSbDVW?=
 =?utf-8?B?S0VXaEtYWllrQUxVT0NveWdMQ2VLK3NZOERzTXQ3eFRGV3VWQnU3SGhPSlk1?=
 =?utf-8?B?eGlaQ1BPejRYd3pXSUdGb2ZKa3gwZU5EYlprcmxsWXR2MHlDQmUvOXB0UjZB?=
 =?utf-8?B?eENQRU51YTg5a0xuL2JJUHIrcG9mRXF6WnNkeUFhTjd3NHhyM2M0b3Zwa0E1?=
 =?utf-8?B?WkdUL2FYSWp3bWlOWGZkZHlqdTNYT0NFdStUS0d4d3FFR1JvVWFnV1Bnd2RS?=
 =?utf-8?B?YzFQVk1TMFY2NHNuSER2TkNtbTRPcnVadmFKOWhnVnJabTQrTWtNenBPUGFj?=
 =?utf-8?B?aHlLWUJRZ3Y0S3lkRUExNVRBbk5wYzZEVkdtaG1IRlY2dDQrUmxVTnB1VlZO?=
 =?utf-8?B?QWtMNE5hUWwyME5rQUZpUUJoRDUvYkRSVExmWS8vYXp3eVFGeVovU0hBSXc4?=
 =?utf-8?B?ajJFWU9iN3lmemVRZk5OSERzaVIzK2ZTWjlLM3AzSC9ZdEFFUFovYllJUWE4?=
 =?utf-8?B?NFNPWEl4Q0dkQmRGVUpnSUJlcjFnYXBHYXo5VnNiditLS2RlWS9ZdlY4eWhO?=
 =?utf-8?B?SXlMcWMzMlo2dmlQd0xWR25BZEhjbHFkOW92QWVkYVFYdWkzVUwrY1RTYzN6?=
 =?utf-8?B?bUJWSGp0cjk1Uit1U21pN1MzaDNtSUJRRWgyQzVzaURJd0RXYW44bGFHN01Q?=
 =?utf-8?B?czNDNThFT1pla3NKVXh2TmZSSnV0OVFvUnFBbWo1WCt2KzY0R3NJeDBNNlRr?=
 =?utf-8?B?b1haUklnNWhndnZSS0RuVVJZZGsreHhXejhIOWlLaE93NDhsRE9nSVpNUEZQ?=
 =?utf-8?B?bzkzd051VXIyQURqQjB2Z1dFdGg5R0RRL1pkN2lsYncyUTRCYzc2bDZFa3c2?=
 =?utf-8?B?UzJud1hRMmlrTGt6bFRmUWFOT1crYTcreVpJTlp2dEJqVWI5UjJSblkrcU1X?=
 =?utf-8?B?TFYyakNDSHFxY041TEpCQzRkSFFDWjZoclBFNkt3SG9SdHVnUXV4VVh2emho?=
 =?utf-8?B?WnZMenV0eTlIRkpJcUk0bThGUmVFTG9VeTNUSjdlWDFQVlBER3JBV2x6TVVI?=
 =?utf-8?B?OHRrRjVVRk1kUFQyZVJFSFBKVGVRTHRsMmx5SFI5bmNNSzZUbDdoWWRTNVM2?=
 =?utf-8?B?L0lTZ290bU8wWWZMNFZnYVExejNRa2lqMWdISDBrS3luN09XUFMvcDRtQzBG?=
 =?utf-8?B?djFZeUlSOC9xdmh0L0tSZlRhVnlDZ1I5N1ZBOHVITjVrbzhKZ2ZUanVKcElC?=
 =?utf-8?B?NjRmWXlJRldUaVFnLzF4Ni9Oc0tKOFZKQUhJRGZ2YTJEOFZ1M01DMmV0VjI0?=
 =?utf-8?B?L0pQS2ZEMXIxVDdDcEQxWDRadCtJSCt0Y3BSMGxldWpoSC9xL2JxSkdwVDc4?=
 =?utf-8?B?RzBqbWJQRXFobmJtV2w2V2ZFWkp1R1JTRGN5UGNOYXZoY09sTlJWdVlHQmg4?=
 =?utf-8?B?ZGZ3V2Q1QnNsRm5LT0JxcnhBRWpUUU5SMU8zOXQ4a3drWjNhVmxFNWpBZGtW?=
 =?utf-8?B?QnorMy9tQ2JubE5BbHpOeXIxMkc4TFpaL3JoaW43M05VWkd0dkd4d2hrdjk3?=
 =?utf-8?B?bmxKekNaanE3LytZTmwxdmxKcThIMjk4QXg2OTc0b29FeFdEek5oQUF5N1du?=
 =?utf-8?B?VUlpSWExWDdyUkRRUG1GaWZjcWlrTHhFVERtUW4zTEp3b3g0QXdzZGlsU1Rp?=
 =?utf-8?B?Ui92S1BvYlV6QTBoOTJHWk9hM1NPRVlHUmxpTC8xbDBzaUtxRFI0YVRESEdZ?=
 =?utf-8?B?VjI1VFJhSi9PRG5wRWpjWDQzdk5RWTdLZ21nd3dxV0JPNEVVTU1idGg0cFFz?=
 =?utf-8?B?TG9JaFBWekVYV1g1ZE1UVGFTNDRDeU5NWGd0WUV4SzR0RTlrZHRQQTMreDAv?=
 =?utf-8?B?MG5LK0hscnFwWHZxem1wTWZvRUZ1RXBqbk9KMzNFaGNRYlUwS0RKUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e01de52-b7b2-4362-18f3-08deb19913f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:13:35.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwOe8APNPuEDjmeBLwC022wt8kwmP6JTNXqet/0dlYQMfVPYtFFhlWllvzKo+mHdSN+GvjrUI3tAWP5xOGPa+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9891

On 12.05.26 09:17, Richard Weinberger wrote:
> If a task is suspend and SIGSHADOW is used to harden it,
> it can happen that the target task itself harends (e.g. by using
> a syscall). Then the already hardened and suspended task will see
> SIGSHADOW and resumes.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  configure.ac                                  |   1 +
>  testsuite/smokey/Makefile.am                  |   3 +
>  .../smokey/spurious-suspend-wake/Makefile.am  |  10 +
>  .../spurious-suspend-wake.c                   | 238 ++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 testsuite/smokey/spurious-suspend-wake/Makefile.am
>  create mode 100644 testsuite/smokey/spurious-suspend-wake/spurious-suspend-wake.c
> 
> diff --git a/configure.ac b/configure.ac
> index 0d6dd87b6..69d9947fd 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1086,6 +1086,7 @@ AC_CONFIG_FILES([ \
>  	testsuite/smokey/bufp/Makefile \
>  	testsuite/smokey/sigdebug/Makefile \
>  	testsuite/smokey/timerfd/Makefile \
> +	testsuite/smokey/spurious-suspend-wake/Makefile \
>  	testsuite/smokey/tsc/Makefile \
>  	testsuite/smokey/leaks/Makefile \
>  	testsuite/smokey/memcheck/Makefile \
> diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
> index c49a5d77f..f3c1151b6 100644
> --- a/testsuite/smokey/Makefile.am
> +++ b/testsuite/smokey/Makefile.am
> @@ -37,6 +37,7 @@ COBALT_SUBDIRS = 	\
>  	setsched	\
>  	sigdebug	\
>  	timerfd		\
> +	spurious-suspend-wake \
>  	tsc		\
>  	xddp		\
>  	y2038		\
> @@ -82,6 +83,7 @@ DIST_SUBDIRS = 		\
>  	setsched	\
>  	sigdebug	\
>  	timerfd		\
> +	spurious-suspend-wake \
>  	tsc		\
>  	xddp		\
>  	y2038		\
> @@ -130,6 +132,7 @@ smokey_LDADD = 					\
>  	$(plugin_list)				\
>  	../../lib/smokey/libsmokey@CORE@.la		\
>  	../../lib/copperplate/libcopperplate@CORE@.la	\
> +	../../lib/alchemy/libalchemy@CORE@.la \
>  	@XENO_CORE_LDADD@			\
>  	 @XENO_USER_LDADD@			\
>  	-lpthread -lrt
> diff --git a/testsuite/smokey/spurious-suspend-wake/Makefile.am b/testsuite/smokey/spurious-suspend-wake/Makefile.am
> new file mode 100644
> index 000000000..b2f4f3b6c
> --- /dev/null
> +++ b/testsuite/smokey/spurious-suspend-wake/Makefile.am
> @@ -0,0 +1,10 @@
> +noinst_LIBRARIES = libspurious-suspend-wake.a
> +
> +libspurious_suspend_wake_a_SOURCES = spurious-suspend-wake.c
> +
> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
> +
> +libspurious_suspend_wake_a_CPPFLAGS =   \
> +        @XENO_USER_CFLAGS@              \
> +        -I$(top_srcdir)/include
> +
> diff --git a/testsuite/smokey/spurious-suspend-wake/spurious-suspend-wake.c b/testsuite/smokey/spurious-suspend-wake/spurious-suspend-wake.c
> new file mode 100644
> index 000000000..969bd5344
> --- /dev/null
> +++ b/testsuite/smokey/spurious-suspend-wake/spurious-suspend-wake.c
> @@ -0,0 +1,238 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sched.h>
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +#include <smokey/smokey.h>
> +#include <alchemy/task.h>
> +
> +smokey_test_plugin(spurious_suspend_wake,
> +		   SMOKEY_ARGLIST(
> +			   SMOKEY_INT(iters),
> +			   SMOKEY_INT(settle_us),
> +			   SMOKEY_INT(quiet_us),
> +			   SMOKEY_INT(victim_cpu),
> +			   SMOKEY_INT(suspender_cpu),
> +		   ),
> +		   "Detect SIGSHADOW vs xnthread_suspend race that "
> +		   "spuriously resumes an rt_task_suspend()'d task.");
> +
> +static volatile unsigned long victim_counter;
> +static volatile bool stop;
> +static RT_TASK victim_task;
> +static RT_TASK suspender_task;
> +
> +static int iters		= 5000;
> +static int settle_us		= 100;
> +static int quiet_us		= 200;
> +static int victim_cpu		= 0;
> +static int suspender_cpu	= 1;
> +
> +static unsigned int spurious;
> +static unsigned long max_delta;
> +static int cycles_done;
> +
> +static void victim_body(void *arg)
> +{
> +	(void)arg;
> +
> +	/*
> +	 * Tight relax/harden bouncing:
> +	 *  - syscall(getpid) is a raw Linux syscall, sets XNRELAX on
> +	 *    return, leaving us in secondary mode.
> +	 *  - rt_task_sleep() resolves via libcobalt as a primary-mode
> +	 *    syscall, so the wrapper runs xnthread_harden() before the
> +	 *    sleep proper. On return we are back in primary mode.
> +	 *
> +	 * The window between the two is when the deferred SIGSHADOW
> +	 * HARDEN posted by a concurrent rt_task_suspend() can land on a
> +	 * non-XNRELAX victim and trigger the spurious wake.
> +	 */
> +	while (!stop) {
> +		syscall(__NR_getpid);
> +		rt_task_sleep(1000);	/* 1us, also forces a harden */
> +		__atomic_add_fetch(&victim_counter, 1, __ATOMIC_RELAXED);
> +	}
> +}
> +
> +static void suspender_body(void *arg)
> +{
> +	int i, ret;
> +
> +	(void)arg;
> +
> +	for (i = 0; i < iters && !stop; i++) {
> +		unsigned long c1, c2, delta;
> +
> +		ret = rt_task_suspend(&victim_task);
> +		if (ret) {
> +			smokey_warning("rt_task_suspend at iter %d: %s",
> +				       i, symerror(ret));
> +			break;
> +		}
> +
> +		/*
> +		 * Let SIGSHADOW HARDEN actually fire so the victim
> +		 * either properly blocks on XNSUSP or, if the race
> +		 * fired, has already been spuriously resumed.
> +		 */
> +		rt_task_sleep((RTIME)settle_us * 1000);
> +
> +		c1 = __atomic_load_n(&victim_counter, __ATOMIC_RELAXED);
> +
> +		/* Quiet window: victim must NOT advance. */
> +		rt_task_sleep((RTIME)quiet_us * 1000);
> +
> +		c2 = __atomic_load_n(&victim_counter, __ATOMIC_RELAXED);
> +
> +		ret = rt_task_resume(&victim_task);
> +		if (ret) {
> +			smokey_warning("rt_task_resume at iter %d: %s",
> +				       i, symerror(ret));
> +			break;
> +		}
> +
> +		delta = c2 - c1;
> +		if (delta != 0) {
> +			spurious++;
> +			if (delta > max_delta)
> +				max_delta = delta;
> +			if (spurious <= 5)
> +				smokey_trace("iter %d: victim advanced by "
> +					     "%lu in quiet window", i, delta);
> +		}
> +
> +		/* Let the victim accumulate forward progress between
> +		 * cycles, otherwise we hammer it continuously and can no
> +		 * longer tell forward progress from wake. */
> +		rt_task_sleep((RTIME)quiet_us * 1000);
> +	}
> +
> +	cycles_done = i;
> +}
> +
> +static int run_spurious_suspend_wake(struct smokey_test *t, int argc,
> +				     char *const argv[])
> +{
> +	cpu_set_t set;
> +	int ret, ncpu;
> +
> +	smokey_parse_args(t, argc, argv);
> +	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, iters))
> +		iters = SMOKEY_ARG_INT(spurious_suspend_wake, iters);
> +	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, settle_us))
> +		settle_us = SMOKEY_ARG_INT(spurious_suspend_wake, settle_us);
> +	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, quiet_us))
> +		quiet_us = SMOKEY_ARG_INT(spurious_suspend_wake, quiet_us);
> +	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, victim_cpu))
> +		victim_cpu = SMOKEY_ARG_INT(spurious_suspend_wake, victim_cpu);
> +	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, suspender_cpu))
> +		suspender_cpu = SMOKEY_ARG_INT(spurious_suspend_wake,
> +					       suspender_cpu);

Do we really need all these options? Affinity tuning could rather be
done within the set of CPUs the test is given.

> +
> +	ncpu = sysconf(_SC_NPROCESSORS_ONLN);
> +	if (ncpu < 2) {

See above: You should better check for size of the affinity mask the
test has been given.

> +		smokey_note("need >= 2 online CPUs to drive the race");
> +		return -ENOSYS;

Let's warn and skip but not fail.

> +	}
> +	if (victim_cpu < 0 || suspender_cpu < 0 ||
> +	    victim_cpu >= ncpu || suspender_cpu >= ncpu ||
> +	    victim_cpu == suspender_cpu) {
> +		smokey_warning("victim_cpu and suspender_cpu must be "
> +			       "distinct values in [0, %d)", ncpu);
> +		return -EINVAL;
> +	}
> +	if (iters <= 0 || settle_us <= 0 || quiet_us <= 0) {
> +		smokey_warning("iters, settle_us, quiet_us must be positive");
> +		return -EINVAL;
> +	}
> +
> +	stop = false;
> +	victim_counter = 0;
> +	spurious = 0;
> +	max_delta = 0;
> +	cycles_done = 0;
> +
> +	ret = rt_task_create(&victim_task, "ssw-victim", 0, 50, T_JOINABLE);
> +	if (ret) {
> +		smokey_warning("rt_task_create(victim): %s", symerror(ret));
> +		return ret;
> +	}
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(victim_cpu, &set);
> +	ret = rt_task_set_affinity(&victim_task, &set);
> +	if (ret) {
> +		smokey_warning("rt_task_set_affinity(victim, %d): %s",
> +			       victim_cpu, symerror(ret));
> +		goto fail_after_victim_create;
> +	}
> +
> +	ret = rt_task_create(&suspender_task, "ssw-suspender", 0, 50,
> +			     T_JOINABLE);
> +	if (ret) {
> +		smokey_warning("rt_task_create(suspender): %s", symerror(ret));
> +		goto fail_after_victim_create;
> +	}
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(suspender_cpu, &set);
> +	ret = rt_task_set_affinity(&suspender_task, &set);
> +	if (ret) {
> +		smokey_warning("rt_task_set_affinity(suspender, %d): %s",
> +			       suspender_cpu, symerror(ret));
> +		goto fail_after_suspender_create;
> +	}
> +
> +	ret = rt_task_start(&victim_task, victim_body, NULL);
> +	if (ret) {
> +		smokey_warning("rt_task_start(victim): %s", symerror(ret));
> +		goto fail_after_suspender_create;
> +	}
> +
> +	smokey_trace("victim on CPU%d, suspender on CPU%d, %d iters, "
> +		     "settle=%dus, quiet=%dus",
> +		     victim_cpu, suspender_cpu, iters, settle_us, quiet_us);
> +
> +	ret = rt_task_start(&suspender_task, suspender_body, NULL);
> +	if (ret) {
> +		smokey_warning("rt_task_start(suspender): %s", symerror(ret));
> +		stop = true;
> +		rt_task_join(&victim_task);
> +		goto fail_after_suspender_create;
> +	}
> +
> +	rt_task_join(&suspender_task);
> +
> +	stop = true;
> +	/*
> +	 * Belt and braces: the suspender may have left the victim
> +	 * suspended if it broke out early. rt_task_resume is a no-op on
> +	 * a non-suspended task, so this is always safe.
> +	 */
> +	rt_task_resume(&victim_task);
> +	rt_task_join(&victim_task);
> +
> +	rt_task_delete(&suspender_task);
> +	rt_task_delete(&victim_task);
> +
> +	if (spurious) {
> +		smokey_warning("FAIL: %u/%d cycles saw the victim advance "
> +			       "during the quiet window (max delta %lu)",
> +			       spurious, cycles_done, max_delta);
> +		return -EPROTO;
> +	}
> +
> +	smokey_trace("no spurious wakes in %d cycles", cycles_done);
> +	return 0;
> +
> +fail_after_suspender_create:
> +	rt_task_delete(&suspender_task);
> +fail_after_victim_create:
> +	rt_task_delete(&victim_task);
> +	return ret;
> +}

Would love to add it to our testsuite, but maybe rather as part of the
alchemy tests.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
