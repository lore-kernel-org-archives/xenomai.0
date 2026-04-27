Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CA3A4F56
	for <xenomai@lists.linux.dev>; Mon, 27 Apr 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280931; cv=fail; b=VKB4qtUOwWjcN+ODzlUjqa16+ncFbvLClv1eZFKb7n2/vY6uZkmpaS9oeqb/cG98XbQcnqPNQxeSVpBgHSglIqi/cYx9uhj0Q3d5VkruLvKntnZpgmtjWWPZF6DWk/GrW0e/SxSe8SF8MKc7NvwtaGDVwpEXEyswlaQ7V5sTJaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280931; c=relaxed/simple;
	bh=pA/9AxwZ3DbOGQEm2mbrwy3DK5opwHmLxlkVsxGL8KU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kD+7cHbva2v5cJTLYOqQ2S8/ru6eX6/YvfzOurGLOAvaWfQUIqYolnh/Vk4nm/hGMuSydh+8TFmKeb+eIYYWxHFiSir+XcoBnZUmNIEh9ueMzotZTCZfgVSo1eaJE7vTsS8mk9k+O98jTshUTOvplGEM0FBZ9TxOnBEOfyFrs9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Fj8/NhA7; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Fj8/NhA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIiM/IbVEqjUx4dpyKHZ96d3Y4DSjhmEjBKS5HRZs2TP7jFvVp0phkzdbekeE1lsR3+NJoX5DYgMsB8cAMjXnnXKiByejNM7RVmm7wXDAxGbIOjlcvktKKrTk5fbJ+L5oppHLrrsEgkX+Da1hZxHt8kU1UtYbZggzzwQYirpLwtJ6ye2rLEWE+YPjlJWNX19zcFKbxWSwjjdNHU7cwRNRerxQA7ixqhtyE7PRpzHBOAOfbCm0WqqNgT34IbyAbPYKNuYFIwWC2nmWOnkpUmghEgTdue6Ztkqnj1uv/0lVeK7NgfQQU5GRwjuY2nlk+kzI/tMwf+IITeH27Ev2E3ocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej9pEu/D2jjjBhpxjnrgrZXvJuFJML1i0FWfzQhOQnQ=;
 b=WeWryCFlyBXfOvIiY0ggqhoOYO1BXxM/ymuwhqW7ef6r8X8Hv0flfu2+aP4/Sr5RFmgPgvbcOhSQnslJ8ZaQ6X1kSYpPuWJOWkORSZkoGPknqXWWdPYgfud/t3GiMWtqnXXEeyJHDGklKPubE+F1RaODJnvWHMVidRtvFP1aFw69Z4nWtOdcOGjF+AWfHbvQ/+8zSlFC29eyKmGNMQZIqFHcWG0qNSJ+9MRsgBU8TTuWCrLn6z4B0H3hh/BkeyZ4qeqTDJRv5sBa+DC/3ynYqViPJFdfKW2rtOKvgtuwGsNjr+25UWs4TWsgAoSaGMn7GnPx/B4peVTvb42fdCnIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej9pEu/D2jjjBhpxjnrgrZXvJuFJML1i0FWfzQhOQnQ=;
 b=Fj8/NhA7Q9OCu8l1DEVJuu3kRf6V75yK8oDiSDOgF4rbBMla4uQXbzevJMEHKILG/58XkaRGU8jPNhL8KSocEafQGUVXb3cKp4kEp8jNhEp9wBO747pqWxyVQttg5KOyVzWrsPoXPRuIWqY2e1LsRoXWx7wCDISdijByAQzKh2zlOOcATSO19mryxiwBb3UPHXzIQBpMpbVezslefKsloHQz8BeVJxHGqCNqx/nWAsdvO2BVxKG0MRAFUU/hR/Q0okjFK1Epe+RPPpozO2Wy/eAOq8bAJQazNO8rxxh9tfoCGogqLuAm/OZv5xVqEScayaMdrpMR/kQWyCpPJRCQlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:08:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 09:08:46 +0000
Message-ID: <af5b3981-753b-42ff-b883-1e0186cbf9fd@siemens.com>
Date: Mon, 27 Apr 2026 11:08:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debian: Add rtnet.conf / tdma.conf to package
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev
References: <20260425153523.4935-1-hannes.diethelm@gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260425153523.4935-1-hannes.diethelm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: d6739c31-d1a9-4d8f-429a-08dea43c9688
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	g9UT9pValu+4CDc6pOBHfZQYLDpjmmUqTkYcBfMXeJIXajJiidEX1wxl+vn8bc0GpYsweqF9YdZyz3t1RJJazTbkINbX6M+qEj2UoiejZ6uN3z9Va3vgoPwMPppU2HHoaQn90oyJ4pBszFg779p+sfLmCn4X4Ul09mDa+F952EwB8pAs8dWYpd/zgLqJLg+gZmbGxZlbkBbcWoGCBGnA6VhtdcHv1vX4gdFXo8zfQPmMCAAtUUnkQbJbkgcumsAAE6J9r5X8i9M/hG5sLS1d83UbcLH/VpALfzIZ+Zwc2L1yCQfKn2iVocAguV0tfFothraCZek7+Xwd6O6qlZPlxA01i//TUnCD1wssmsi13+iT1/UoMj7M4kbYuaYnFByO335+h1lPfS8jDDrjQmIIqId7E4yp9BBYIgy2GpvxSJcdapOw2O9gtlMVT9oKYSmpxM0vDIXVRUWf+7F2NG5U7canbCtn9UJfJcW+tDzYKlYvyTxdQFzJXPNpc9l2qJeAunV9jLDF0EFoVHU/dojmhfaxFkiVBuIzfLslFSuoZfrfzZbH6TB7NioiLUZ+Wh950sXW47V8PsLqZY12rgOOt+BBK8hyX3T37Ftq9+zy1bLYvKQhotWXK57UkXguIlBUh+ejSFZiBxLvfJCHLfOOz5+Ehd5T0hb6/gcwZyuDyR/r6Fa/lkupuDWyAfOIAlzy+O2OoS5qQ2anZDkFgGTDrfnpHo3VzVOKFpD3qxw5GMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEZYVFlDSjVsVUdxU2pZcXg4aHdobXgxMVJJNUJyaGN4eDJtNzN2TWlVTk1y?=
 =?utf-8?B?MG1YOVpTREhKc01aVlE2QWwyRmt6aGQ0aWF4aEZxUE56eDRBZHlGbFVodmVS?=
 =?utf-8?B?MXFrbUxLNHlWQzhxYks4bzY4Yk9Zak95TmVoa0dHVktGajFpRGxFRlhrcVo4?=
 =?utf-8?B?UDd1MGNIL2ZraHhPYlA2V1ErTGVyRkttdmtlNDhjdFJJang5S1ZUUkJnMi9K?=
 =?utf-8?B?NUk5RGZOZG5Ic1FTTnhST0s3dlNscDdVNjJXZmkwNzZwam9pMytGS0tTaUtk?=
 =?utf-8?B?SkhMYmF4bkdoTk84QjBDa2xOcVd4aXVhaVp1U0xCZ3MrejFsYktDUGd0R1cv?=
 =?utf-8?B?RFRKWEVFMkZuWHo5cDRhL0JiMGVUbU16ZUtTN2RNaTdVU08xUHpqUjJXanlm?=
 =?utf-8?B?MG1uVXI0MDk1bGFTTmdreEh6UE5KaXRZS29jMFBFUFE3dHhGOVJtSnFsU0pE?=
 =?utf-8?B?QTR0YjNDUUlOZnpkaGtZaTNEbDd1bE5LclhCaXRQbHE2OTlsS1A5UkxmRnds?=
 =?utf-8?B?ZDlrd3daTFlkWWdPYTc4UENaZ1JOL2RvVUE4WitmcWRCQ2VTQUdSNkx3ZDIz?=
 =?utf-8?B?NXQwZGlQb3BmNHJVZUlLZlA4ZS9maGlsOEZGWVo1cVlEby9Xb3ZkRGdLRVFX?=
 =?utf-8?B?NDl4NEkyRVhYKzNJY0creDFYQ0tyVzlwWWJ6bGZ4dmdZNGpzeHluWDVXeVNE?=
 =?utf-8?B?OXlSZmI4WC8vSThMMFEwQStmOHQ4VTFWTkIrSVlxRFdVSWJpRkRTaThzQXQy?=
 =?utf-8?B?dUtKVVVVR1lJUUdoSHVGaUlzdmI5U1pSSnZMc0J5dUU3ZUs3M3BTckJFbFVx?=
 =?utf-8?B?WEFwR3NBTEJYUzFmMndJZk5VV1U4V3NDRlhJQmQxZno5bkZyWk5CTUplR3E2?=
 =?utf-8?B?N0I2UnI2Yi83NEVUd1BjZkx3WG4zdWd6Q2VvSThHQW1GQXZIWDVoWnB2K1dW?=
 =?utf-8?B?TFZMQXNzdFlUejVVa1JSd2t4WEF6akhJMWttUFZITzlkNlZqeENHTGtBSnl3?=
 =?utf-8?B?WGdaNmdvK1czZk9tSXQvN3d6aXdqNzlXaldsRTBTUjlMS1VoaUpXRUNDOSt1?=
 =?utf-8?B?K0Ztd3BWak5KTWdGQXMvTy9ldk5wZjdVVnN6M2FpSm03K25OeTVwOWZITmxR?=
 =?utf-8?B?RGthY3Q1QzZveUhBbWNUbjVNL2Q0cFBaekdwRzc3ZWVaenY4WXNXSW5QRVd0?=
 =?utf-8?B?U1dHUHNCZXYvQWdCc0JZZ0JOak1YamcwU2FmK2tPRXYwYU9RcEd4bkdtUWdj?=
 =?utf-8?B?R3d3TTROeWxHb1ZKNFRvOGIxWkt1aG5jeUwweGN5NUllWExKNWhWVFFlWS9Y?=
 =?utf-8?B?ZVhlbjJlYjl6VW5ERy93bGFQZ01IQjFZRHdjeUVPM2dUbDV0NzNQNk5hQjZp?=
 =?utf-8?B?YlQ2OWpmMkNtVUF1Wk1uYlhBQmRpd2FXQU12SithRTdyRklmS2JWcm5YaW93?=
 =?utf-8?B?anhFb2tHT2VxQXpadGVHQm9LMm1VZnQyUS9DckxURm80VUl4NHZ1RU04eVdy?=
 =?utf-8?B?azdjMUVUbVR0NTE3ZmdiYUFnNFNNRTVYczNZQjVIcVp6RnljRUFPWjZOVHli?=
 =?utf-8?B?cU1yT29JUEw1R205czI1WVpYWEdQWTFTRUoyemt4N25BRlAySDE0dTgzZkgr?=
 =?utf-8?B?QVNhUnFkWnhFTTlIRDhIODdGdGRmQk5zYm4rcEd5eGl6d2VnUGNUdGc3SjY1?=
 =?utf-8?B?aCtxcXFLVjMzQndsMkV5OVZIbXNDcFpodU9JUDZVV0E3UXgwaEZTVHFtSHpM?=
 =?utf-8?B?RGF5aWI3RHBuNWFJNFltYlEzYWM1TDNZdFp3RVNGVGFVa2ZtTEhTSUFGVUFn?=
 =?utf-8?B?b3M3RTc1eUp6TXNvbHRXUUJTUHBFbGtkUUU1bkVMZk5oSnZTemZSY0c3VDFL?=
 =?utf-8?B?Q2M2RERIWm1Nd3hxbDk1c3U2cDFXYXNCZGUvV2VYODRWSWFLUnVuaVV5V2or?=
 =?utf-8?B?ZWF0R2hzVC9taTE0Q3Zrd3VvVjdWSWhiNVlSNEg5R2lmbldOVnZlUXNiOXJH?=
 =?utf-8?B?aHNYS1N4dTFJYVlSRHNNOXRRNkVGNDBLSEZuWWxaNy9qempXSVBSVmY4VVVI?=
 =?utf-8?B?RlNLREZRSmkydk13RzQyYjZ2aGtHZ3p5a3BmMElHcnROY0pTL1ZETmNYVis2?=
 =?utf-8?B?TnJ0bU4wdWw3T2RmTXh6OXgrYjk4ZnZsaU5NZDBxZ0RUZXg4UklxdzUrWSs4?=
 =?utf-8?B?UW85MjlhbEttdkFLZE9pdjFXMVM5NzJDbitSL0ZudXdXNEo0d28rNmg4dGYx?=
 =?utf-8?B?Vm9odFZKTG1qTlZ1Q2lENHl0VElhaDhYR01rNEN2OVFyNXRyQ0ZZSDRWQ2ZJ?=
 =?utf-8?B?OUVaV0RUV2JWVGpRNm02YXZXUm12dVNOMGFheTJKaHdodVRyNlc3QVhoNUl4?=
 =?utf-8?Q?4JqmhYJPWCfh5UWw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6739c31-d1a9-4d8f-429a-08dea43c9688
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 09:08:46.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qy+SNw+2Fx8QMyQVjAcl6THj/idqD0ddBEAgWYllH5ysIUK7R+yG7UDjggRYJOnIKscxfR/o7bCy09zRpPFMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7721

On 25.04.26 17:35, Hannes Diethelm wrote:
> The two config files rtnet.conf / tdma.conf where missing in the Debian
> package and --sysconfdir=/etc was missing in rules.
> 
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  debian/rules                   | 1 +
>  debian/xenomai-runtime.install | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/debian/rules b/debian/rules
> index 225c743c5..9e56de260 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -15,6 +15,7 @@ DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
>  
>  CONFIG_OPTS = --prefix=/usr \
>              --includedir=/usr/include/xenomai \
> +            --sysconfdir=/etc \
>              --mandir=/usr/share/man \
>              --with-testdir=/usr/lib/xenomai/testsuite \
>              --enable-lazy-setsched \
> diff --git a/debian/xenomai-runtime.install b/debian/xenomai-runtime.install
> index 77a4c445a..a9effa984 100644
> --- a/debian/xenomai-runtime.install
> +++ b/debian/xenomai-runtime.install
> @@ -5,3 +5,5 @@ usr/bin/wf_generate
>  usr/bin/wrap-link.sh
>  usr/bin/xeno
>  usr/sbin
> +etc/rtnet.conf
> +etc/tdma.conf

I suppose we never considered them valuable enough to install. OTOH, we
are also installing all the RTnet tools and scripts, so this makes sense.

Thanks applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
