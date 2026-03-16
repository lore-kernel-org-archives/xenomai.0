Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1238E122
	for <xenomai@lists.linux.dev>; Mon, 16 Mar 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691901; cv=fail; b=iCtF6UBu0PGNyyC2u0vf/NrSIDwANP1oz0JxCaj76FRH+DGTBat/BibnHGdoKjHEIEvy/w79KHNF2kkSb0A9hNSJ8sa5jGOzIrjCTpx35mC/3sxZNf7HN5tmA5KaITdQb2h3soovn+8WkzyqjI7zE1G0tsRtqCkQw6qGBi8mL+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691901; c=relaxed/simple;
	bh=EmkR18yT3+F3HiqCpP5paog/555gCg1AwHomnQ1rYg4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XX5o2AnpU+yCpqHisbm9tCoFRqNTI/KiH5ljVxelz6Ci9i+iAUBfAwuRT+BpovkrM4Sws6KUcBLktwtvuajBRghQm+e/IYHuTwtrXxR5rojphBqo+nLEEBB0tpD2MSJb2oPdoPGOmD2kpY6xQ8het+CXVr8mIRatShlko5cNiRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LGDD4MPG; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LGDD4MPG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMz4vRjt+19zzkwbgoyfIssFMfeImIxHeRmE8Q6l0uCqHQraCTY7PJmxfG56bDIG/J6tO32JgEgBw6YCVE84EtS3m9jQBMzfG3c5w2ETt7sE3J79kk4zbfo6ZZw/31Rx1X5PZSiJ81SlJh1biAKHYIbjuMs43qJYuWp1djJ8T/I06zVUdQLrqomdJ7M6ae7hGDr15uMC7PA3v+tv0r70Jfy969pq4iMHub5xvIt1UTBQ6EdAgCL5R2Z7YcX/WwCEq+Xbig3R4iG9TAnkbLyF17cYrf6WH/plfagtdyNfWQgdPQ5hEjJdQ6+O4GpjPvf2piGRU9iLhoOnoZHHZ69qpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YJm8/rI2bqdKa+ckAPdxNyFhnLj6IQbNaF1IqoksUg=;
 b=c841oBCzBay+L1mwexcbuzypSQSjaiBUryTVRzL1PW9Oelr549cTG1tmyYBEHb9/0i3yLFXSr+oB/vV4hPJelPrKMQoQi8qUqpJillRMN/R4BfSqo49JUCRfatU6T0LYbT8Vi5nouCT/s1FBoHWH6ObxleRlASACPzgF/84pM3z/R5snyPz55rTd7IuX/Qk0s6MGnx6wVK6p2brDWoMcK9c8weXohK3WgwZqGbQbW17f9Epqsc766MfkY2u9pi4u1nqmYbL/rpnxpBLMm6nFfswGfU2HRKabva/JV1Gcy/14Yn3wCAyF2n42c3POKUgel/FEyYJF83d5wYcipFfP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YJm8/rI2bqdKa+ckAPdxNyFhnLj6IQbNaF1IqoksUg=;
 b=LGDD4MPGGN0fb0GXkqLTC/EGTtVSZMIkRBgLYURoCOOCO0+puchg/YoFOK5hRvE5DnVU+KOoZiK3mub+D/sme/8HsVIPvEs5htZKBy7/sLAXIW436/OxqAB6fQJA120zInrBUKPfaI4wRHe9Icsj1ZmmwmvZ3w1uCjhN7aKheYLgk5A5SiZfwM+VWqJfHU1um4fZmvFw4VpNk9KspiW28iAk5rv5SFkU3czeQrKjllwZFtwe9SLGdOTi3xy+8DcXxaEwtj3rvlSef7TfMOK8etsr/r5i7WxXQcgEWMXj7D9/onLqWKfaltqKXGyzNibpNdZuedOEdua7y6E8H9HR8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 20:11:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 20:11:36 +0000
Message-ID: <34b30ed9-ddb2-4af5-a8e6-10b3b6bb33db@siemens.com>
Date: Mon, 16 Mar 2026 21:11:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c58849-6e55-4f82-7046-08de839839aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|7053199007|55112099003;
X-Microsoft-Antispam-Message-Info:
	wnUYQ6tJUI1dxKSv42Rh6u5ynZ8FnYhtuqwUhPtbrao0n3G+wbPj06TWQ6NLqwB7jPoxNlNU1O/2+nDht7/4ArMszV+bYwSFrdYK6yWsvgizU6xKYGM8LDQqEasQUCJl37YOKLrQ0I+BmCEtvDrfaj3kIh8mEfhKFnmy7uzRJb52J9kT9vP7ZLB+ja2SPB5D/JUcZ5taVQjUHClghZnmJK5AdDuyfGZuhS5wn7eD5jtuMntQwtw4I6Ka1FwXiXSKADbbAHLdRDVUe5AY+9uXrbS6Haq4Pwu5GaYG8ZwhbsBQzEtlz4TpWRL4KwAsSxOXAtzmXGtzldHiQIKzPrPVuilwGfUwPahuCdS1l5EYaptV2uM+e5cdGTudKnk5Q9QeQHTE/p0Lf7Z/VpGhkAPg+s5M3yVXI+MqQClW8pvnsRX2nJq0lhsWfT0gsR4ifcw7/ciuBr1fWETRbiwkpR40D+uJwH9BZORNbDYOIU3hJFkbW/v2KHQKyocit6J1rMl53iYX/RwPOBhmcZ4EACJHcrHBSYvBltNh2SnSBk+/hbcnpTCpsKT+McaWIBMR9HNbT77XlFIrw8nQNpmX9Uwz8MwXM4XZqULlWEjpEyyTv8v/TtXFY9DC8NQn1mw2Rd0SoYTShcCbn34FhTS5KzfbbH4jY24vJ74fMJMzOgk1GbXx+tNKY71OPjez6naGzAoC7aLSTSUSUr+Q4QMjAI939vLBg/AWlCrK84/P7rKezm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU8xcGwxNTRzemRRUDZ2ZWNIWHltMW5EbUFndDRQcWltT2ZvTWt1b3E4ZzFk?=
 =?utf-8?B?K3VoREVJYUIwcVF5cy8rSWhjbjY1c3YvRVp6cU5JcW16UXhLTHMrM1dETFhL?=
 =?utf-8?B?aWx4YktvNGxwak5FL0pZZmEzNnJWc1hIMjhqOERvVUVWQ3JGUEFWaXlKM2F0?=
 =?utf-8?B?N0tIYVpyRUNWekNsYVo1b3hNMTdJZmlFOER0ems1cHg3QlAvamh1L25WWG5h?=
 =?utf-8?B?VmtwWERiUWYxNWpMc0huN2l4QkM4MEE5cEFjM1RvSlZpdHRwQXhZeWxVMmVk?=
 =?utf-8?B?dEVGT1V6NjcxOUZMaUk4MHQ1NlRqNmFkU2o5TmQ1RTdiS3NZekF6U2RxTVQv?=
 =?utf-8?B?MzhubmorMHNyRlg1L3MrcDdOd2xnYTRXRk91Y1BIQWNZaVJQT3BSSE53VUln?=
 =?utf-8?B?UW1oNUdmNXhyeDhlS3B0NkthaGZrMmdFMU42bm5taHlVUjY3UG1Xaks1OTg2?=
 =?utf-8?B?azkxVmVHdWFscTFTZU8yQXBVY1hLcVFrTGhmYWZsZTJlZVVSc0pLUVFvQS81?=
 =?utf-8?B?REU1d3ZGK2xETWYxdzJwbzN6WVJBYzYvYUZabi8zazZ2M2wxUVM0MjlrNW1K?=
 =?utf-8?B?SCtGYks2ZFZzTjYwWUZwU21xOFhnVUZLaEJFdUlUKzRTWUZCTTNPTk9aSE95?=
 =?utf-8?B?TkY5eDc2c3pRVE1aL2dSYmZJUWdvbjU4T2ozM2NHNGJaU2lxVWFCRVpXek5N?=
 =?utf-8?B?WFFwRy9DMVdYaXFJUjhhdjE1UGZHT0lFOC93L0puV1ErL3ppQnZSS0E1aG9i?=
 =?utf-8?B?VE9KVWpnWWlXMmd1WGg1VW4yTW0rNHM5TXdGTisxMStSdzRGWER4MzFsQW1k?=
 =?utf-8?B?eXg1Wi9MMjdHV2pwSnVuMU9NeEpzYUgrR0V3YWt2eGdLQXVWTk9FUHpxak1l?=
 =?utf-8?B?SDNEK2ZaMEhKL1ppL2hlalV0MHpYNGlkcy8wWXRRVmsxLzdwZjZNNlRETCtv?=
 =?utf-8?B?NHdjaCtqYVFFYXIzMVdzblBoYjM3U2JubDBhRzRGRVhySitBYSsxTjZENnVU?=
 =?utf-8?B?eXcrMU93UnB3TUZFV01EdUEweC9MK2FXMkNTejRQVnpYVHV2V1h4d0YvTVBk?=
 =?utf-8?B?c1dmRDU5N1NURXpmU1pUUG0xaWtKREcwMnhDcFM5Y3h3Mms0WVdkZVp6clpu?=
 =?utf-8?B?SlBMQm1RbVdhZks1Y1JlLzdXS2hZdkhrSmVWSlhnK0dQRFZuUzhqK3Q4QlJn?=
 =?utf-8?B?K3c1dEIxNWZicTlFM0Zwd0dhQUo0YTJJckdtVnNpRVNwV3dtVlVHNW1PdTZF?=
 =?utf-8?B?VU5vK1AzZERYQU1sRFVXRVoyU05FWXE1SnZHYThsZU5GTTFxWnBEelJyM3dU?=
 =?utf-8?B?WnVxUjFodUZJTWxPaDFWUWZZajg0ZUZDNmlwdktNMldCemI3dUhZaHdEaFpu?=
 =?utf-8?B?YnpRNkRvVnMySEtZdXJ2QS9PVVNkZzROd2dtYnloQnlFbDMxRHNqR0o2ei95?=
 =?utf-8?B?N3B6SWVSZUcxSk5jSGFGazluMEV4S1VTcFQvUm5sVVFCb2I5Y05pcVhRVitT?=
 =?utf-8?B?b05tbW5wcHQ0d1VFRFFjMDV6YWRBK2syc2NEUnEzWXRCbENiSlZmbVIxUTUr?=
 =?utf-8?B?bVFxSE5ualgwWUlPWVhVMS9mcWNDc3ZoYm9vZE0yZFFLUXJybXIxalNEOUhI?=
 =?utf-8?B?TkMzWDlTYkt6M0N6V2ZlT2ZlVDNzbEhGLzNuTSsydHE0U3RFdTVRdUY2VG9k?=
 =?utf-8?B?TzF2WHR1SG5YckVlOTYxeGN0Y1dEOHhEY21RRStHemhCdklmMmd4U2l0VVdS?=
 =?utf-8?B?b2RSWFJNaVNVRWJSdUxmZGFmQnlQNGN3U0dwQkdIK0E0N3RDQjc2WDBOUlgz?=
 =?utf-8?B?bElSdGRTV1dwSXdJRGVLTU4yL2ZiS1M3NjY4RUpIR0gyT0UzcXRoKy90NXND?=
 =?utf-8?B?OWdGT3NUeGtBVnd5eTEyQVN4Rmg0bFZCS2hGb3F2MEJnQTNaK0w1QVFiTzlH?=
 =?utf-8?B?eVVrQjJqRE1CRDNGU2RxRFRPSWs1ZG1NTXBkM25pMHVBNzAvLzExN2x2MzMx?=
 =?utf-8?B?TlRINjVXb0c2NGF5Nlh3ZFVaam0rdUhSakdDTkc3Z2l2bWZmd2o4MVdrUmZt?=
 =?utf-8?B?WStibzBheUJEWHduTURuV2tibFAxNU9kR2dmUU43TURwV1ZLVXNYdmtjS2dN?=
 =?utf-8?B?TlJuSHUrUGU3ZWVTb25xL1VaeGtXNWpoSGpBREVrSnQ3Z1FBS3p6R1lVVHA5?=
 =?utf-8?B?SjFJYWFLdHRNTFgvOWxncnUxbWZ3TzdRTmlRV0RKZmJIUndiY2J0TDh4cFFR?=
 =?utf-8?B?ZjlvWWhUcW96Q2pyNTlNdDNBT2gvOE15WStTbzRGazFGV0NBMk1weDZ2aUJK?=
 =?utf-8?B?MkxMTkNleTFRTitlamlITFZKUFBOb25TZXR6RWhCWDc1UG40djR6Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c58849-6e55-4f82-7046-08de839839aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:11:36.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+NHnp76fSaSFTYfpW6lpmq+MZnfo00DE97stZ1EYO4mL8ne89HeRrfSiznkwLUMnCE9zhONF/dtxwTJ/9k/2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7989

On 02.03.26 10:37, Florian Bezdeka wrote:
> Hi all,
> 
> The current time64_t / y2038 support switched libcobalt to time64_t
> only, removing the interfaces for the native time_t type.
> 
> With that series applied both worlds can live together in one libcobalt
> build which should hopefully increase the backward compatibility a bit.
> 
> All time64_t services have been moved into a separate compile unit that
> can be compiled twice now, if necessary. Unaffected environments like
> x86_64 won't do that. It's not necessary as the native type is already
> 64 bit.
> 
> The most tricky part where the __RT(), __STD() and __WRAP() macros.
> That has been solved by redirects on linker level.
> 
> To: Xenomai <xenomai@lists.linux.dev>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - SPDX headers for all created files
> - Add copyright notice to all created files
>   I checked all moved code parts for their previous authors and in case
>   there was a copyright notice in the old location I copied it over
> - Link to v1: https://lore.kernel.org/r/20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com
> 
> ---
> Florian Bezdeka (20):
>       lib/cobalt: Introduce cond.h
>       lib/cobalt: Introduce mq.h
>       lib/cobalt: Introduce mutex.h
>       lib/cobalt: Introduce rtdm.h
>       lib/cobalt: Introduce wrappers_time64.c
>       lib/cobalt: clock: Move all time64 related services to wrappers_time64.c
>       lib/cobalt: cond: Move all time64 related services to wrappers_time64.c
>       lib/cobalt: mq: Move all time64 related services to wrappers_time64.c
>       lib/cobalt: mutex: Move all time64 related services to wrappers_time64.c
>       lib/cobalt: mutex: Provide time64 variant of pthread_timedmutex_lock_interruptible_np
>       lib/cobalt: rtdm: Move all time64 related services to wrappers_time64.c
>       lib/cobalt: select: Move select services into wrappers_time64.c
>       lib/cobalt: semaphore: Move time64 related services to wrappers_time64.c
>       lib/cobalt: signal: Move time64 related services to wrappers_time64.c
>       lib/cobalt: timer: Move all time64 related services to wrappers_time64.c
>       lib/cobalt: timerfd: Move time64 related services to wrappers_time64.c
>       lib/cobalt: Move XN_USE_TIME64_SYSCALL to wrappers_time64.c
>       lib/cobalt: Finally build the native time_t interfaces on top
>       lib/cobalt: thread: Cleanup and reorder includes
>       scripts/xeno-config: Allow disabling the y2038 / time64_t support
> 
>  include/cobalt/pthread.h      |   16 +-
>  include/cobalt/wrappers.h     |   13 +-
>  lib/cobalt/Makefile.am        |   27 +-
>  lib/cobalt/clock.c            |  309 +-----------
>  lib/cobalt/cond.c             |  154 +-----
>  lib/cobalt/cond.h             |   85 ++++
>  lib/cobalt/internal.h         |    5 -
>  lib/cobalt/mq.c               |  151 +-----
>  lib/cobalt/mq.h               |   39 ++
>  lib/cobalt/mutex.c            |  211 +-------
>  lib/cobalt/mutex.h            |   97 ++++
>  lib/cobalt/rtdm.c             |  105 +---
>  lib/cobalt/rtdm.h             |   37 ++
>  lib/cobalt/select.c           |  108 ----
>  lib/cobalt/semaphore.c        |   67 +--
>  lib/cobalt/signal.c           |   26 +-
>  lib/cobalt/thread.c           |    8 +-
>  lib/cobalt/timer.c            |  121 +----
>  lib/cobalt/timerfd.c          |   39 --
>  lib/cobalt/wrappers_time64.c  | 1097 +++++++++++++++++++++++++++++++++++++++++
>  scripts/xeno-config-cobalt.in |    5 +
>  21 files changed, 1439 insertions(+), 1281 deletions(-)
> ---
> base-commit: c7226edf0167451a290b9a82e7331a15cc88122b
> change-id: 20260219-wip-flo-fix-time64-32bit-native-8e5d8b7c7ca8
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
