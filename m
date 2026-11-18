Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795002883;
	b=s4aqWS+s8H2JifMkMU28Lf5TWwXXMKudK6/vG8sP0NxROIDHcIobRrCx+aIOPNUw4a5p
	 6Q9kmXiOLkS0IPUq7OBvO8f36SYrTOjzBKeHnKQy3eAgH3/9fjxJd6uWNPMa9KsoxgPcF
	 /lK3X3mp0Eocs0R7fwG/agvWQDXhW3s3zapZejed2GAQbeNM7G6THNbnnUrJajJCLM1YX
	 ZNzg9BBSbOFxPEx4MxtR4LGr4n3e7PyYXIdgqqJXw24e2iuuNSDoBJasrEltUeKpie0Mq
	 AOFEktKSJIHPV4D1Plg+Uehu5v7ipMYRszKX7c1AEvlFHWQW4PFCZPT99Xym+xz/6mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002883;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=v3+WhjeAd4BZPIGNfaHgB9lQmGz5BGwL/VJgUpWYUgM=;
	b=hL4J8uFHfn0zuHBoYJuTRHEY50IdTDi+2vimoWfd/nlpv4YeIZl4v2w8PpJOkkuVl7NQ
	 Y6/f2TyxD7C+ZyPl6o6c6F4k7A5fvfBsFa2l5HAMiwcPoV1lm/pJbIp6m6twYAzUaqAl7
	 qiUhQKyujU/06amB0AJIlgExFGSTVtDGL5kTc7MJ5+tyvGPTPyfEOkY8+2ytmvnniL6dt
	 mEoz0TkKvu2ecnAAMKL/PVNf5GoBWYwBUK60yK9QX/SJfpP1/Iz5wguWBq/xA4aLgGPy/
	 7S8Q5TKshbc5PuawMashOayvIxdQPbpJCn7q6g/pbHSVa9SSzRcswwALilD4gTywAcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=OO5WIFu+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.12
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85D606A320
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 11:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC85D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=OO5WIFu+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlEHczPF/mMQV78lHxtdHb5yqQu2fUE2PYmozNaPghYmYFNFpKqXiQukJEBL8+fFEhFXAfKBjfjVffGjoC9ky2aMSZIwBcL+PyxuRNDfO83Vf3LYEVuIcufiPbdPzNfXLSf9gTz7yILJhbfBU2bg+A7cntnnZjmOBL1vqRG+1+sigVod2tewW7D6zD2/19/qjFyy76dtwGe4L61x0kce9/xJjm2P5TNs3TQJthnumJtLTZmFLNUD98A+CPDd98hs4WIzCg3A4GBiyNem4sBklE5OrDoErr+IS6/nCGUczNLa4Y1M0gf8FTK4VLJiQMv51n3CpMwc+bIwkqOqZ8f8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3+WhjeAd4BZPIGNfaHgB9lQmGz5BGwL/VJgUpWYUgM=;
 b=nw8YdEXx2BFKqinm1eMAKJY2qLLjLq102U+mSOqxXXSgu+0CZAokB6tOKQL4zTCojz9WYVhQza+mWQcYcYa14i4C/jlqKBTlxAjbAA5QhOPljnGD6GBZR0lYJhkXztNddu1AM0MghV/ytvyGLgNW5h/6s14OhNC7LbJ45AiBcFLzo35zth8MdH3AovL5CzpQlw51YqafDDLhHZrDIohtvBDbjZi8mXFEDVBwmvXl1WFR5pAk2J/yqiJCpRq+Dfjzj+rfkmsfaU3kO2rbqy23wTIofp3wa6DxDkK9hsjAho5fRfXxMi+bvLRQlMxFrYXceKZuYEgvuIeIC7bI7O/0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3+WhjeAd4BZPIGNfaHgB9lQmGz5BGwL/VJgUpWYUgM=;
 b=OO5WIFu+CVxgjOeZGqXpaO23ZFEVY0f2bF9k0denoaSTsYXYgqYxt7p6gbhtH5D/fSNAf4N5jMmJUI9zEtqkvBYDWMgNd+NGuFrwxk7z2cZYgOq13NPRrqOq6elnq7rLaZn/QJHP1zbuahkgn+IA1GXuhnfjGXBr9+zGUvnGcagiPue3kA0FtO8U9DfPeN52QuSpErP6WbTqfMqgRPq6DQ/B7PKznPeQs/xfPWiCUf3JX2Mi6dHZUNqOBn98PupoEkGbUgg8+gaPqv8zS9VZBueJC0hnkmsrdhvjAW7y3pClwJKOejR+XnFqUGOK2LITLEOVQNqUfOkUcxw4gGRVRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GVXPR10MB8927.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Wed, 18 Nov
 2026 11:54:38 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 11:54:37 +0000
Message-ID: <90eddfb3-0a7c-4f14-b718-e77662527fae@siemens.com>
Date: Wed, 18 Nov 2026 12:54:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Build fixes for Mercury, GCC 16 and glibc 2.43
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261118114909.3030884-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GVXPR10MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bcea55-f9c0-4788-1f8d-08df456ab839
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|6133799003|22082099003|18002099003|261009223027099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1FflVEN5592gER6uhnlBL1wzdys27SSM6P8xcWp9To9SO2bsiAL3RS+04UHeiteF1qb4VQNJC/zt4Xxl9uKcWx+DkJOskTBW6oGpme+e9RKzW+6e1iUPuasH1RdUlNudw5X9ukry8OLLNW5mqA8gfks8jfuxL3l1thSrXsG3rravy/sR0zjOH4bMVoaxiQh97/fAml1iJnjVMWzw3HnRzvN+UcEtkMpPhE4vjgtADWR7TXJsocfklKWM2KXquMR9n0RHojX2fWeeYdNsOsf+uA0k43rDdsTML5gKvZazJYuVi2gZf8pOPTBTkbDBIPYeLvtS/YQ9MTloqvT8LdLosFI4OyqgS2YXZ7BtzoFLRnnl8ys5eir3HPweRc0ll1t+0hhWsolZKF3whqLG0BWq9v5aWs1/sfDSBARsTvexSWKM/9KBekKPOluUTbQmM50wgomcPmBYYDeXORp/Jes+rELP1VIef0h8C0jF8ju0wbj0LDrB/oN6mvfU/3e5RRb8yYQKY4cvTD5qGVYBwXIznfu/hbabkOJ4XdhkD1aLoNydiU3ntTTvvFqE7tMgnRX1ln7+FlIwn9LLFZQo8RLW4HafsVB2UUYz8w7H3+S1wVg8w/0K/Q1eb4iJMqgoSeg98OFgzjW4s2iy2r+O4AECUVPiyqrIWAY6xfam2ERzl0I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmhpZ2p1WVJ6L0doajZReEhvdlpYMXZLQjQwdk0zV3dKWU9nZEhrM1daVjhL?=
 =?utf-8?B?UUVsWlc4SW84YzJnTnJzNVlWc1JheWZXaTQxcHQxd2Z5L2RuemNETjM0V1Rk?=
 =?utf-8?B?dmZkczgwVVo5NWgxcG0yWVpRT3VrZ0R2aHhXd2hPeEx0UUlxenJ2K3V4Q1hp?=
 =?utf-8?B?MnpKQWN4QU1EZW95R0RneHlaamIxVTVjVDkydk10N0ozQ29sVjA0cWt1bFlP?=
 =?utf-8?B?QUNNRjNuSWJmZDI5NWRjYVp4bzVDS2Q4b3crd2tEejcxaXdqaW92WE92aDZ2?=
 =?utf-8?B?WHVYS2JPOG5aVkpjeCtBZDhoNThwL2pTM2ZFV2RMN2ZCdlZHTC9oSitDbTZq?=
 =?utf-8?B?alRQUWVYVTZCUkc4ZVNUY2I3bXlEQUhGV2hFckpMb3ZwQTRWWjN3OUdCZ1k3?=
 =?utf-8?B?Rkd2WE11UDU0N3NEbWhzQ2hEcysrSGxoUGZqOXpxOU1ZYTMyU2pjdk9nRzF4?=
 =?utf-8?B?WFNpM0NFdys0Vld3RW1qR3VDSGRvOEU3T0M5T0h3UHNkZUdjTEQydHpKVE1v?=
 =?utf-8?B?c0t4a3huUERwR3dSNlNVaG4yWjJuRUxQQk1wNGR6UkpsRFdNVWRxdmE5QXBy?=
 =?utf-8?B?dXEwRG1PVnpvSDNuaUNvQmZON0lWTmN1cXZiV2tDZGZ1TjIxMGhRM0x2YVBW?=
 =?utf-8?B?SmVlNmExT29Zc2U5SElDdTJhYXlQRVVmNmY3OTRnYmpxUFNqRGx0UlFJRU81?=
 =?utf-8?B?MVBndXF2dkxuTDN4TzI4RmJqMWRUcnZKM21uaTRDL1pSM0h1S2dmWERpT1Y0?=
 =?utf-8?B?WG1uaFVvOXc2bUtZZVRVcFZGWk9OZ212S1dmbnRadm5LSnVBS2RFSFFGVUQ3?=
 =?utf-8?B?dWN4RXRQQ1k4KzJRL2o3RDZnY0RlQ1ZkUW9TeUdLd1Vac0ZQMnR2RCsrdXRQ?=
 =?utf-8?B?a0o3bk5TU2N4ZFFIU1FaWjNibzkwWXhtNnVReDdySVVsMSs4YXZPQ3p0bFJj?=
 =?utf-8?B?dDB4d2ZQY0lRKys4MFgxelJvd3BMenhNK1Ixc01ibG5hZ2tweklDMVl0dXFH?=
 =?utf-8?B?MTV5NjNrWFgvaVhlbFZmMVFqS0toVmI1eDhpbVI3REtmT2RNOGxpMys2cTJF?=
 =?utf-8?B?MDUweWs5aDEzVVpWdFJFR2RzTktGWXZMZGxlUHN5SmpmRFhUejAwTGdMV1VZ?=
 =?utf-8?B?ZlZUSmRZNGFneVlFWjljZUU2MWE1TVNSMTlJUjB1Q0lwUFBNQWNna2tDbGxu?=
 =?utf-8?B?VlVCVUduSlRualVHdS9DK01KMDZXZ2MxSWpXcUlNcFBmbjF0bnFsVkk3UGRv?=
 =?utf-8?B?OWhJTDdqanE4N3dRaG5uTlVlanZzMjE1RFZOblNKTzgyUjNEenRpN3kwRW9j?=
 =?utf-8?B?NmsxbTR4aDBKQ0ZiUkV5L3EwS3lwQy90b3JTSVYzUkd0ZUtUREhkdklWZTB0?=
 =?utf-8?B?NWFhcjJnaGZ0Y1hTOTUvVGlLalgxZlZsOTJMK2QxRVNOSkFUL0NneUpuNmkr?=
 =?utf-8?B?dnRFazlITHB2WjcrKzdVOW5VVlhabk8wUkk5VG0wUmJLRVZWUHo4dTdtYmJP?=
 =?utf-8?B?WXExeWZsNlZndWdHdEZhNWxzUUtVb0IzYTU1VndVakgwVVlSekV6VFhFYmg0?=
 =?utf-8?B?d1ZSdEI5WS9SbThSbVp2ZVozNk1CcG1kcWxxM3VZWHhmbHMwdXBuQXQyYnYw?=
 =?utf-8?B?cVpPS0V3cGl0MFBJR1daY0Z4MVlOZUc4aHdobkxNZHZNbk93VUpod1hTNGpa?=
 =?utf-8?B?M1EyZEwycjY3VERmK3NvTTB3ZHBHdENsMWZtK3pZMGhhK0cvWCtLMWRjM0w1?=
 =?utf-8?B?dzFtYVhsa3EwK0lyQ0RjMzNqcjl5clUyV2hFVXhibVhhNGtCNjZTZW1DSFg0?=
 =?utf-8?B?WUxIZ2R0aWxzL3M3ZytNYmR4UExPYWkwVW41STlXMTNteWhQV3ZWdS9jQTFa?=
 =?utf-8?B?UnlsQ1JZam0zT0VJR1lHSWZoVG9EMFY5d1JlVy96ZVN0Qmh1R2M5ZGxvRWty?=
 =?utf-8?B?QVd6eTFWUHpMNzFMTDA0RHBUUno1ejRsdXIxVUhPQmkwZTJjcVR5c1h1TkNX?=
 =?utf-8?B?YmFwYzlKd2Q0S3MraiszL1k2ZjVCWVNoUmZYbml6WUdhaFV4OHdPQ1Y1d2k1?=
 =?utf-8?B?MDlGKzVkREdpckg3VVNtQ291SkdzSVJWa2lPTTAyNzVhZUkrUEtaVHNTdmpN?=
 =?utf-8?B?N2tKZHEvajdjQThFbGhwUVZHMnpDUDRMQVg2VDh3WThqVitwZEpteExVcUxN?=
 =?utf-8?B?VnJsa2dQRzRSaHhKNzRQZk1INzZMYnhCaWl1OE1zc3hud25UNmcyOEpyWjcy?=
 =?utf-8?B?Y29sNDJnQUxPYnlkaXQxaXUwT3JPNnFYdW5tOEhNK0ExNlRZcGUzc0JXbGox?=
 =?utf-8?B?ZUVwY29BVG91dnBWYVR2ZEV1MGxrdjk2NFdwWUVOVWs5dStGOEZnNndnU1ht?=
 =?utf-8?Q?EX+IToKQmuI0WDjM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bcea55-f9c0-4788-1f8d-08df456ab839
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:54:37.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aebmk4Vp2GyoSpftdsSYIDxf602fhPsfAzxX7xwQ/SAJDdp5bWnwkDtXOXy6C95XtuKFcmUfG9wCgCNBYmN2DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8927

On 18.11.26 12:49, Yegor Yefremov wrote:
> While bumping Xenomai to 3.3.3 in Buildroot, I hit several build
> failures. Xenomai forces -Werror for userspace code, so new compiler
> and libc warnings turn into errors:
> 
> - The Mercury core no longer builds at all since the include cleanups
>   in 41de7cc7196f and 7b7ddf4a3658: mmap()/MAP_* and __NR_tkill are
>   undeclared. This affects every Mercury build of v3.3.x.
> - GCC 16 warns about variables that are only ever incremented
>   (-Wunused-but-set-variable), in autotune and in the smokey tests.
> - glibc 2.43 makes strstr() return a const pointer for a const
>   argument (C23), which breaks sched-tp.
> - The alchemy tests miss a couple of includes.
> 
> All patches apply to stable/v3.3.x as well, and would be good to have
> there, especially the first one.

Means you validated the next branch with your fixes?

> 
> Tested by building v3.3.3 plus this series with Buildroot: Mercury
> for arm and aarch64 (glibc and uClibc), and Cobalt with the testsuite
> and the Alchemy, pSOS and VxWorks skins for aarch64, i686 (GCC 15)
> and x86_64 (GCC 16).
> 
> Some testsuite issues remain on Mercury that this series doesn't
> address, e.g. the alchemy pipe test calling the Cobalt-only
> rt_pipe_read() and task-11.c missing <stdbool.h>.
> 

Fixing all these is primarily driven by your desire to fix the build
recipes, or do you also have a use case for Mercury?

Thanks a lot,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
