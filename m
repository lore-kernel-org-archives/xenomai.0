Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673660;
	b=m67nO/zZcLGdGOWkIN9p1KqlHGk7TqQOaUWjXDyvXSSworHC3LesGcRerLSpxixYyMeA
	 PDjlhGs1ac6EnIEHLsiz7FJsKqEXDqewwleUV/j/ibc5G+GIRMBKXnssF7pgE2Yk7aD2R
	 NCPtS+b/7RDiahUN1I/Jd2XXtA9gkHy/Qk4KVfiEXwDwkTQLaYkZnZEgiGnm2gQfaU7R6
	 cBAHqEy++1QfuzW93GlFMiz9T24THbOYrq2/Vqm5L4AKT2/WMc/cT4kYhzKO3nB1PS/qP
	 RjuZ5hIlhszPyk/j4+4/XR2vGoEk6gaMN+DR+Q2Zxyhc75uOrr30xVoJjBUb6sdJIpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673660;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
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
	bh=yBiZA59Xgj55TwqRdt0O2FAoDicWBPUAm9Btezxy4Qk=;
	b=0h/7MWFE8BQdfW35UBWn2d5rcmaEEjIIY68Vmu0EVx2msAGWXcdGLG6Pvg7GaJ255isK
	 ghW3zlMOwKWsnUi3O7uLEbIiRjocI5IWrmY5Sp1FSvO9AA53nHJoFslJT44o66PexzGtW
	 ltrZbQxq8vFJeSgHeY1/G8AHkqD6QAGYcQhiBtheS9UY0/5uShUM+UfckbJ7aD6axRxZa
	 ob6Q45mUKuy1KtbL3D+E+5mjR51pASqctqUgmef/bRlDD7hlxKhpYxOxuw0Sae0u1N6Ut
	 85O+Tm5TseZLwZ7SiGEADnGaE5UfV8D/b9j3fFwvpVD2YyoNfCJDiZpYDRIwz/wcRUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=X9E1cJIq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.51
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0C606A31C
	for <xenomai@lists.linux.dev>; Thu, 26 Nov 2026 06:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA0C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=X9E1cJIq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LloAAp6NoeL4/Q/7Ch4emAi97oEf5ut2hc7HnIq1jJohJwa9ik1pUp2HgwmgreJmXElfH0o/a4Uz65YHhHxdrVLfo/SPkikZeAYoPdHEkLCxZu0ZsLOm398r9to4UnEBhBg3192iTlvEBHGmQl/pCWVq92QtSATJcMTwIT3AcNC79TbofE4JzLQJgpKExJx/2zjJEuHtBACsUOMynPnADrkqHxnc20/nTqWKpAwtXvmhJX7PUnNwcJdr4eLiwjXcSQ1Gw5v0DUB5VBlZf3lPgsEnnwgiH4GYHiMLiWcJ6GbCLHGMmBbAk6SUQHIw5pIOLkRwdPwoaQxKQ7yFvbgVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBiZA59Xgj55TwqRdt0O2FAoDicWBPUAm9Btezxy4Qk=;
 b=P9vId5q7097ehddyg92ABT7QpiAhWH3qJLjTEmmMC8dNdi13Aet195049xV0+MRC6KJDKJA1QMkW+6jYa2qxewdsxTEAD9kh4gltRDEnwDi/KJZwbMfbvA1nT9Al8/4ApoWbhUnizkNyiCYfePIgUWHA6uIak8a3d0EbYFp0WUTSJ2mmLGoHGLMkY+Jxn4oxuUOpUsM0SY4B0zUvVUcWxKZPJYExadZGfkUd6R2li4Ky6V+M5TGXKNutleaGQTre7PD94dVI0UkvLr2E+5ErGV+c0EN9S8daMj/BWN5A2bj5gsA9P/akuRM3U2mh3Oe9g3uoGsELgXzVDd04/Vt+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBiZA59Xgj55TwqRdt0O2FAoDicWBPUAm9Btezxy4Qk=;
 b=X9E1cJIqXya3QwWR4jpdVMz1hrZXpMRVP/85Bw8NsvVnOKz/bqMzAfnKf43Owf1dkA2q6RygEtHKR2cItaxWvEXbfbS542ZUEwMICqF8IHAAgMnIgOqvJQBFh6ZFArpxof4qdk8F8d+1T6CWV2foWB7kRIlikFHruxgU82YSAUJv+zvZjmKNOIv9CkVKhRvW5iIeaROXj2vyW9zg1zsTp6cBugxlnCPZT1QJYt5RFTlb2pbqTsQ+ivOZjPmgk3m+zoJHxb5bSD3rI/cvoE5FtWsOHr7d5usTFmP7eWVYYGjtecX6StE1L/QHE0nDkkfUjZMscnEldyOmMd0UwQQiJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by MI9PR10MB992256.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 06:14:16 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 06:14:16 +0000
Message-ID: <320f2a18-9b27-4583-8a1c-46b9aeddba2d@siemens.com>
Date: Thu, 26 Nov 2026 07:14:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] lib/alchemy/mutex: Allow any Xenomai thread to
 acquire a mutex
To: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>,
 xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at, Richard Weinberger <richard@nod.at>
References: <20261125213419.2363742-1-rw@kernel.org>
 <20261125213419.2363742-2-rw@kernel.org>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261125213419.2363742-2-rw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|MI9PR10MB992256:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f835981-ab60-4023-6aea-08df4b84801b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|55112099003|18002099003|261102123227099003|10067099003|4143699003|56012099006|11063799006|261022105027099003|261028144727099003|261026140227099003|261021123027099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	9kV5o4carDvlXt1zKsZREG6PRIFCZ58v148MIHWuTjxgyvQLA/u/cMlSI8QHR/ucmGgKiyxangYux2lyIvC8X3Qk2DoWxAFJuuKKZXd3ty5jgk1YzoFFgnjZj0e6i4ypVsmyiQ73D9i7bKSv5YFBSmnWyv8YIxHwiKx9/9ml6Klnc0pDFpKaCfZ7w8Utnz3GJTAJEggbb2DE7yBsJ5UA0kjGLt4PaTrN86XcL0nU/7HYtT5YWY7izgEb5eSyRyGEsJ7LI3TWCrTQR1N/3AUc5I25ilU9fW95Dq280MKNjx4aVhiIr1rGvbkCuQV4bmzZ7BMYexCIEYEftezCgrnvedRj83bFJk13W29N29AeydVRfyxSJHwHBmfKykdbbUez4UNGBGYDl86byUPf6HbNww56iYg5kW1cFSChPXJ4T/up4kcY2ZS6ilmdMrEf9KoTm7NXAH1e8RA6aii/K3DAiT+OzCr5XQoeKQoP9vFTl/xFNQlIynUq9O5rxR9Rr5QnXDrJdxBkmGfijMYucWe3dpCpYIZOWhS2Sc0Gvu21RwjbS5GEWrTdbLNvKsKFW7q09z/5KxAajHZRyxP4JpobSUf2wF1ilrejsSV7+hRz04Wk62caNpf1C8UV334f2oQ8suuShyDfVmCVXV6nfqgX/dwdbntQ2dHvXTbtP/PqkbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(55112099003)(18002099003)(261102123227099003)(10067099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1JSQml5Y1h1a2ZvVndUWis2S2xMUHRtNXZsWW8vUXBjR3dUbGZaS2tYU1gr?=
 =?utf-8?B?Z1dNeWtNYThkY3l1N04xQUNCaENVcG1meW0zQzJyMkNvK3JWUE0xVHBuTVU5?=
 =?utf-8?B?R1p0ZHVmSlFBZGZOYU5BOTU3S0xZb0FnbHN3bVpLSVVrcVVvYVR1dTYrdGxK?=
 =?utf-8?B?Ti9ick1sY0JheHlWa1BJaFlkKzdqZ0lDc2hUVStrOVpjcXYraVVYaFVLQjBK?=
 =?utf-8?B?Q1gveEN5Nkhkdk5nZFVSSjd0UVpEcVg3emt0NGd1WS9xUUN6K0xkZU1MVHNU?=
 =?utf-8?B?UlBrRlRnMWRXVGhoQ0Z3WndzMGdQWGtLZ3lBOUM0QjYwLy9IV0gxRmQvdjFO?=
 =?utf-8?B?NXpqbFlTVGEyRHRsZURXUTRMVVo2djdYN09BdnM5bU9sY2h6bHpRUHhtY2JT?=
 =?utf-8?B?anVYNnkydUdQb2hLL09lYjU0b2c0dFlPeEhPMmJHNFZnbVJhQW5tNzBOZXEw?=
 =?utf-8?B?WFBkQ0xadmpwWFAwOXZ2eW5yb3BRVTNtaytzZWZScGZxS1l6MFg1Z3dKK3A0?=
 =?utf-8?B?SEhaWFV3bm9xYnFDT1hhZTBTc1BhRzJtMDdKVnFRWmpGd3BTQ2lhRXhmdUlE?=
 =?utf-8?B?N0FsVUxDQTRJQlFXbTB6TXJmQ1lUVEhrTmFzbW1oK3grbERNUm8vZmphT0s0?=
 =?utf-8?B?NGhyV29BdFpURHdLM1pnS0xHNVlaYmY5NnRma1l6cTZLeklLSU9hNVFIWFZy?=
 =?utf-8?B?N0NSVS9WY1JqeGFLNnZMVlJxRmtSQUNla1pxeGFpWUVWaXBRYW5qTjErT0hQ?=
 =?utf-8?B?Q3NkUWJidC9aMGxLNU8zYUJuVlB6MXFTZmQ1dXY1ZllQUHA4MlN3UXFUUWF1?=
 =?utf-8?B?U2U5ckhUUitwNDNFZ1FVMUIzTVpnRmVJUDF5QzJqMGV1UEk2Q01McjZDTHlW?=
 =?utf-8?B?UmNOb28vZjlDZ2psaHFWRGp5RlZlOUlwQUl6QmtXQndqamxOTEd4L1ZlRWdt?=
 =?utf-8?B?QkRxTTRtbU1KbUUxMENFcVdzSkJ5VUwxdzUyMm9aTkRQSHFtSTFtSk5peGhH?=
 =?utf-8?B?TkVlSSt4bzgrNm9na1AvZnExMzBkck82b0ZvLy9tcU92aWFMZFNjWlNoYkpI?=
 =?utf-8?B?NzFhNXgyNVJCYWNkb2o4ZElaT3pIRExnTnZmYmFxQ0N2VE1YS25PcVRSTTJC?=
 =?utf-8?B?NXlBV0Z2em1uMU9LRkJqRklqUEJEN3AzUGQwd3c1UWYvWks0aFhRNDVNdXFy?=
 =?utf-8?B?aTBGSUlEdzduSSsxUkdFSS9LcXE0aVpTRHJoWkNzbGN6YVNhQjBsYnhEMEJO?=
 =?utf-8?B?RGlxRklNbnFTQlZyalJnaTJaOXF1Mllhc1MvdWZVaWVsUE1COEEwN0RlU3po?=
 =?utf-8?B?NWV4V3QrdEkvWFlpQkJrQTdVQlF3NWorbDRPS2EzeVJLYlhhekQwdXdIUHRi?=
 =?utf-8?B?cUZrMU1zNDRxMG0zYzZRNXdTN0pCYlp5RjdmQnR4Z3B4NnJUM0gyc2xQWnRV?=
 =?utf-8?B?QjU3SnhRTWltcjZLUGkzQ1VwWW1XYXdTK0lKQ05vR2FnNFFlOUtiVjlDMkZq?=
 =?utf-8?B?YVFDM0pka00zSkc2d1Y3cGJSczYyZlAwdkFaWmNxZVgwbWN2WDVkMWNGbE1I?=
 =?utf-8?B?UkphRUVTVGZqZGQxL3FpU3UzN1BtSWdRMkEzOXVWd1NNS3M3N0UwZFFqd1ly?=
 =?utf-8?B?NGlsb0lVVGtFL0FDZ20vWXVMUkJPLy9lR0VSRkJaK1dTYklYOWNyWlFpcXRV?=
 =?utf-8?B?R01rZjFqZjlmYk03OWtRWHlEY0lDUlp5TnlxOWdqalNIdmdYcXJQZGU2bjZX?=
 =?utf-8?B?NllwTk0xODFjL0dkREsrWFNHWGVmOW42d2FXV2ZtVjdiQk00NDlzY3UzWFd3?=
 =?utf-8?B?cnRVZk52ZkhXaEpzUFZOekdGWmRNQ2RnMEJBSWVsMnFJNVp2NENmalpoTzR3?=
 =?utf-8?B?d2pYelZYbHlPaEhJa1lvUWF2TU56L3Z3UTdYaFFxUlBDWWNrbkszTjRUSEVD?=
 =?utf-8?B?azY1MWp2aGJQN0tOeUJQdmFHK3V5ZWJzZmQ3YmgzVXJSbEVOUVNLaU4wbStt?=
 =?utf-8?B?Yi9pY0lvK3ZOWUpxNTlUSkhQSzJDdkVtbHRIcU9BcmNqNm9QRitOdkowVFQw?=
 =?utf-8?B?K2VoRGVVM0l1bUg1LzhZREF0Uk4zbmZxc0FmQnp2ZHZMUXVDVkdKMUVBUzdM?=
 =?utf-8?B?U0NUL0p5dmNGNmxFaTVIQ1E1Ky93L3FBb1BpME1zTWJrNDVScllhMHBVSCtt?=
 =?utf-8?B?R2JHQUdiWE0yZ0htalZOSWFFclhIbXJ4aWRxSC9xNVBGV0d1cFNIdlpKSXEz?=
 =?utf-8?B?UDlOaVFUMnowWlZCOUgvZGlKczdlcHNMa2NjNmRNOUhVRGxudHBESGJBM08z?=
 =?utf-8?B?UXpaeHhwYkE4WUdSNHFTS0dPY0wycTZUOUZaR05HNHd3R21WL2RiQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f835981-ab60-4023-6aea-08df4b84801b
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:14:16.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7PPotTLkYSXWcTBU7k9YsUldv5qJHK50TA1J52oJ4mgGTLWakEDJAAum0qp1Iw8UoW1yAMXJ8aNI5nnIlswMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992256

On 25.11.26 22:34, Richard Weinberger (sigma star gmbh) wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> rt_mutex_acquire_timed() returns -EPERM unless the caller is an
> Alchemy task, although the lock is a plain POSIX mutex. The Alchemy
> TCB is only used to record the owner for rt_mutex_inquire().
> 
> Only reject asynchronous contexts and report NO_ALCHEMY_TASK as owner
> for non-Alchemy callers.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  include/alchemy/mutex.h |  3 ++-
>  lib/alchemy/mutex.c     | 19 +++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/include/alchemy/mutex.h b/include/alchemy/mutex.h
> index 2c4212f33..ef391a294 100644
> --- a/include/alchemy/mutex.h
> +++ b/include/alchemy/mutex.h
> @@ -42,7 +42,8 @@ typedef struct RT_MUTEX RT_MUTEX;
>   */
>  struct RT_MUTEX_INFO {
>  	/**
> -	 * Current mutex owner, or NO_ALCHEMY_TASK if unlocked. This
> +	 * Current mutex owner, or NO_ALCHEMY_TASK if unlocked or
> +	 * owned by a thread which is not an Alchemy task. This
>  	 * information is in essence transient, and may not be valid
>  	 * anymore once used by the caller.
>  	 */
> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
> index 6bec2d9bb..9609f1fa5 100644
> --- a/lib/alchemy/mutex.c
> +++ b/lib/alchemy/mutex.c
> @@ -285,8 +285,13 @@ out:
>   * waiting on it. In such event, @a mutex is no more valid upon return
>   * of this service.
>   *
> - * - -EPERM is returned if this service should block, but was not
> - * called from a Xenomai thread.
> + * - -EPERM is returned if this service was called from an
> + * asynchronous context, or over Cobalt, from a thread which is not a
> + * Cobalt thread (i.e. a regular POSIX thread which was not shadowed).
> + *
> + * @note Any Xenomai thread may acquire an Alchemy mutex, including a
> + * Cobalt POSIX thread. However, only Alchemy tasks are reported as
> + * the current owner by rt_mutex_inquire().
>   *
>   * @apitags{xthread-only, switch-primary}
>   *
> @@ -303,11 +308,12 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>  	struct timespec ts;
>  	int ret = 0;
>  
> -	/* This must be an alchemy task. */
> -	current = alchemy_task_current();
> -	if (current == NULL)
> +	if (threadobj_irq_p())
>  		return -EPERM;
>  
> +	/* May be NULL if the caller is not an Alchemy task. */
> +	current = alchemy_task_current();
> +
>  	/*
>  	 * Try the fast path first. Note that we don't need any
>  	 * protected section here: the caller should have provided for
> @@ -362,7 +368,8 @@ done:
>  		ret = -EWOULDBLOCK;
>  		break;
>  	case 0:
> -		mcb->owner.handle = mainheap_ref(current, uintptr_t);
> +		mcb->owner.handle = current ?
> +			mainheap_ref(current, uintptr_t) : NO_ALCHEMY_TASK.handle;

NO_ALCHEMY_TASK == no owner - you are changing at least internal
semantics, if not worse.

I'm still in favor of fixing the docs, rather than adding this new mode
and trying to figure out which corner cases we missed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
