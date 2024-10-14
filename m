Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ABC148826
	for <xenomai@lists.linux.dev>; Mon, 14 Oct 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946927; cv=fail; b=ULsatEJy19eA64goDwxITHit2rNjVDb2sX9xI6lzLKpcZe25izTLm+EmHwzIKpepwe97ufxqmWV8OAz4PVWyQuxJb0J3gjS49PqkVh/aLYAZ3cEdcYSN8ZAFHC0sUAiPYWeiEksPnwcY2fD6fLcIFyJ2ZbWxGK5tVekbACM45Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946927; c=relaxed/simple;
	bh=j5BfbZAT4fOxN13nGOqOOqTL9krdFd0HP1oBl6AFDWo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jzmeR804HfJ4SXKVIK3L5yUIAs8Mw2aYo+HyNS3xfE+DnFt0KK8ghFI0McuNedU1AAaqt4YUO6nqGxYsItyefPdmZV9kgnvmbN9/4rSS6fVvyqp05Z8B7Pbkz8lBIpbDWqW3GTq1XkOwKMhvxvUSw9tTUbc49FgwkV+mqovi7T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xNOTW4Tg; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xNOTW4Tg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk9lu+mAaMr+Rf5q+UqDfbgoTKOMqSyOB9k6SELXa97f9kusgkUgDQxkM9R/eMy4IZ8PC6copCDUOHRc3lZx3Ho0u3pRNjTTr8rsknFf5E+/bAFcXp4s59wnOTZClx+kUgrQAqhAHMkWqsdSr+G/KNFsWDky/KVoMVPS8fyKE6rsUBmT8d/Va2QUYK8xjAn25JW2y6SqQqIvwzNAjUaja7uI5nBmEFh1r6RWMw9YAiVzxJdNCD0h0iy0zHjtRxBEY8hXVGfGgg/jeNXb3hEAX4y+cD6Ltt29r2T5L8uzqhQhlsqHbRylK1OZLXrVjdcnwdraeuzz0yxOrqcIto8A/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEOiLHbmBn0/nh6IpXnQqaBdoWajBcXEDNNe5OBQ90g=;
 b=w4ppxDyAPR66GHv5g340xScW6TnZKUhsZlqrex3qFae6g8t/Qef2h/kv+PB7VDT9iz2cWzw1jGOGKbMJ3bACOfVqw87Kk4+YAnAFq784B6qxhy7ZS/0DgIaRrnLDzsooqA7m+J9qw0DHLOJw9z++Q/j3w5LqQkirYRjytPzVVpOHNNsG43gZDGQn7jv6I3qH3JJ4GrW4A2fcK2hVlLrbVzIs6ZDIoyEcAIyksYzzOSn6ceS4/Tfo285SLPQYWEf42R0eTUYKGGSfrIXKHXnQLdZcqngoi/nPhzwtazclohf4BgK2KxbZJeNrLFGI2al8O1xevAmEJb49I3r3YERVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEOiLHbmBn0/nh6IpXnQqaBdoWajBcXEDNNe5OBQ90g=;
 b=xNOTW4Tg99ndWeptcpKKcPC+kDwZ8wmFp6HCrmDPPcUzfFQLWmOdWDi+Dh67tf+f6MrpIONKhUWLbevjy8CqgIn2nWEn0+B6373OoTuDMRWAKlY77spQ1qAbGdnLY65GUl0tr7N4KibQbzmHA3gfiZ0RtNZeonMnyoRi1h4/pGDKV9aEDYf9uFVXWkICYb6vg2CxRCFZF5ghA1Gh5ULbf4N3Yh2I4xlCl617W4ld67ksqf7/uT+jHZ1wWNYLA1Fs7hQjvLIc6PEnJJ1upNyk96dJ6ZRzU+ZDWZkisNIYBQMAm2HTiiPBG/V7F/6jaHvNzlQSTV7bGAFvM0/NvVyE6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Mon, 14 Oct
 2024 23:02:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 23:02:00 +0000
Message-ID: <421826f0-0523-4ba0-861b-067a87301278@siemens.com>
Date: Tue, 15 Oct 2024 01:02:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add f81601 support
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
References: <20241014015648.883157-1-liuyang@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241014015648.883157-1-liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6a63ed-f003-42e9-00fd-08dceca4363d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aktVRmVHV1VYNGljWHNaUDZZeGsxaktZR3g4cEltOURJNmlpNUEvWGFhYUs2?=
 =?utf-8?B?dy81WThqZnZ4aUdaWEQ5K2c1aHUzUHBKUkwrbXUrK3lDSEJHbDRTL1BvSkxR?=
 =?utf-8?B?U2t0amgzS0hicjhPSDJNSEczR2FOWmdoRDVMenRKYlJjUFhSeWd0S3VFZ3Ji?=
 =?utf-8?B?ZlEwa1Y5V240akMyVjZudnVSM0NBUk1LTEtuOW90UmNFLzFvNmowOXRKb0pO?=
 =?utf-8?B?TWdWVGNvOEZpeUZvWGszeUhhYVBKdnZ6eG95UE5yVzczNjdtNzI0UEZhWmZx?=
 =?utf-8?B?eVc2MHIzWHBySXZZcnZ1MnRYcDB6eGtkZDBzWUg5bTVkRmhGbHZZNTU4STdx?=
 =?utf-8?B?SzYxOCtoQWNnNnlqUlVaYUlhUkhpU3U3c1lMVEh5ZjByUWgzdTM0R3RhaUhV?=
 =?utf-8?B?bVpLaGVabG9sZW5abnV5UkZhYjhNWEwzWkV3dmtuSkNnQjZtdmtiMzV4d1ZM?=
 =?utf-8?B?TExhQW14RnlTL2tyK1hOdW94ZlhJSWpGSlNVbFRNcEhaTXpubjlGUlowSVQ5?=
 =?utf-8?B?WWw0ZVZRcDZQcjJZRWtINkZNM204NEhCZHBhcHBEdUg2N0lsM2IreUhOcEwz?=
 =?utf-8?B?UCtCVkZWYURwTTBsRkpoWTF0aGhwcVgyRHZoWnhiVU5WOEt5SVMwYldybXp6?=
 =?utf-8?B?RlJmakZack9jL3R0alFjV2tLME1PY2ptTkRieEZ5Q2RrRGVpM0dnQ1dQVk1Q?=
 =?utf-8?B?TEoxc0VPak9uRWpCRTNNMm1qbE1jV2I3dDlmOXcvOEhPYUhLbmdtRnhSczMz?=
 =?utf-8?B?YkRhUlczKy9RaTFJUmlDQkJDdkJKWTdodllmbzF2Wll5TDhJSTNCUWZBSm5U?=
 =?utf-8?B?eExSWVJTWUUreGhsbzlsZ3lPNFhXUjBCNGo0QnovcnNwUjNpMEx5bm1IdzY3?=
 =?utf-8?B?RWRicEFJeEVTbDh3OGswL2pxVk10TzJjUWM5aVBvY0hSWXhBQXJUZjVkcFRn?=
 =?utf-8?B?SSsyWEZST1ZndHo5OEdwUVlJWXRoTGRyYy9lV0R6OHAwQlRxTFM5YTF0ZnZ1?=
 =?utf-8?B?em83a21VT3Y5RnNXaWs1WnhYTENFVmNIelBsZHVMMjZXaitaKzgyWUpWNVlY?=
 =?utf-8?B?U2ZUWkdtV0VZTXNodWt1ZVhHQ3AzZEVlZzhNdUd0WWE4b0VMNFVpUWE5VTZH?=
 =?utf-8?B?bFgwcDRFeTVENnhUd21qM2trOFpRamE4M2xhWXBycHAyTmtHeW1iNnZkdXFG?=
 =?utf-8?B?THdUZEtoeFJTOWQ5QTcyV05YN2FHU3Bxa2k3RHd4LzlEcWNRRDZuMGptVnJS?=
 =?utf-8?B?MzFhci9PdERvd1QxVXNrb3NHSVJXMCtUTXJiaDVmUndvMVA0cE1zZ2p6R0Ry?=
 =?utf-8?B?ZlBQN3hsQ0hNcGRidEZuN2ZibUwwck5SQXRNaS9RdlQ1czIyT3BoVjFHVGF2?=
 =?utf-8?B?d0RZZzl0bFVxK1BWeVVLdUtsa3lSRTNtNkVHOUZ6NDFUVlhUZzltbERkcFFm?=
 =?utf-8?B?KzlUWk1BZWEvYnhBOTI3RWNSVGh1UFBMaktxbGV5T2podW55bWpseW1ER3V5?=
 =?utf-8?B?REFDWlNROGY3VnFkN3ZZNE1NZE1tUm5hZlVoTUhjQjJvY25IRHVDNk1JZ0tq?=
 =?utf-8?B?U2lsNjZvSFBnanRYVFlIakZmZGxHNlE3ZGljMnMveFd5cmFzb01vMXNob0NQ?=
 =?utf-8?B?SzdvZEJocnU2cXBUZUt3M0hzNzVoUWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpPM1JGcDdkRE0rTmMxdFFwM0Q2Q1MweTBlWEFQaVRVZG5ITVluemV5ZEYr?=
 =?utf-8?B?MHdLL0tHbTZlc1lQVVFMb1BScmdvdEFveEZZVTZIN1lSRTFzNkY0Z2VhT1hY?=
 =?utf-8?B?bkVxZ2pMWHdrK1UveGJOUXpsc3lPYXcxb3FydnhjdHdwNjQrWWVZaGJicGtj?=
 =?utf-8?B?Q2tKaGl4c3hha05xTmkzS01FbERTRkJiZWpscGVIcXJGRWR3RWR1NGJVUHI4?=
 =?utf-8?B?WmVydEw5NlF6U2tQZ25wMG1UL2NXVUVISGZiQVVYc3p3K1BYM0Y1Ymxtd3Zi?=
 =?utf-8?B?ditNODZDRi9LaE1mQm0xUUVhaDJSVjM1WXd3TW5NRXNTcE5oRm9lb0FKWDVk?=
 =?utf-8?B?eXlWZXgxN1krWjRYUUhJSHZqemcrYkw2TlJrOFJ6b1dTVmpZQkpZZkNnYk1h?=
 =?utf-8?B?T1VZUGE2dmVOd2tna1pNVUNsZS8rZ3VsYlUvUjU4YWY1bHk1NFZnOU4wNWtY?=
 =?utf-8?B?aWozZXBkVHRvNmN3V0RpNnFseXJqTHA1ZFRTbGFlK1pob0xVVGNGTHM0djgv?=
 =?utf-8?B?TU1PRkplaHlYSTljbGZTS1p2TlBua3BYNEJoS1FJbmpQQlhtRWlZK3Fyd3JD?=
 =?utf-8?B?eVVPM1daZGIyS0N6akZCRjYxT2V4REVjTHdYbERMRFJqdWFpMWtRY1JvUW9j?=
 =?utf-8?B?QUg2OHdTNXNWU2U1c3l5bWpHNXFrK0RGRk9pcmZrd0NRQ2FPbVFZdnhmQXQ1?=
 =?utf-8?B?MS93Z0Z4cFdiMk9rRmRvYTBIVmh5UDU0R1YyUkVIdEZ1V203RnhlT3ZtUVlv?=
 =?utf-8?B?cDFTNGR1VzRZVzJOZm9qWlBSU0J1T0x0bkFYcWxFanZ6V2ZvQ3VERStwNmMr?=
 =?utf-8?B?dHJCK204RXA0SDZYTlpadCtuMXZ1UnFvYVFRdTRtM1p3a2ZmSmM0bUhvZm9R?=
 =?utf-8?B?VFFiNE5ybXlIWjZWVDViaERPeU9zOTljN0NXTlRtUnV5VFJ0bG5jWEZva054?=
 =?utf-8?B?NGt2L2pPRy84N2J5cUlBQTQ1RE11T3pHOW9jek5laXpXN0xldTBMZzk5Y290?=
 =?utf-8?B?SWxhRUVhcDBLZUZGZHdGcUZLbUpNYlFlQkM2WFN3RjVDNTZUUERTQkNVY3V0?=
 =?utf-8?B?V1ZDTURXMHRZRGwrUmduUGF6YU9wYVhEdXBIUGxPT2gzY1d3dGlrNElRNFJQ?=
 =?utf-8?B?a0FIZmNFVGxXNnZSZVY0Ti9WaGZwQVBKYUJtV3NlVlNORGNiL0hjQnJPb0JU?=
 =?utf-8?B?a0EvZHFXajZMQ2VHaHgxRllydzNQZXgzWnM3alpIclhsQ2U4ZmhQN2VCQm90?=
 =?utf-8?B?K2ZTZEdxdit1V2hRQ0F6d0JLZWoxSXZqd1l0NEFaTStlcmkwWnovaDh5VDFK?=
 =?utf-8?B?V0dCYWJGd3JTcCsyck1mc0syTUM1dVBUaXBjWi9scG9pWG55YmNSL25wSndM?=
 =?utf-8?B?VE9KNTgxZGs1RVVoalRPR1ZCT2JpTWtxZ05XczJIeXZ0eXJxU2pLWERqa1M4?=
 =?utf-8?B?YS9CUTVob1o3ZEtEblIzM0lDUmcvY0pQcS84ZmIvTkFkZk1Lek1aSW1Tekpj?=
 =?utf-8?B?T090SkJ0MWhIaXFIMHUwcWJ3ek5EdjN4VWdvbnRoT1V6aC9vdmREOXhPYmJK?=
 =?utf-8?B?S0haektUajBoMHAzNDBrQWR1QTNwM2tncERKZWx2elNxTEdiMzQ0S0Q4WjA5?=
 =?utf-8?B?ZWZ6SHlhL2MvT0NhTzROQ1FOUEFPMXlUZU1QSFpwKzA4UEhudjlWY0FPUkFq?=
 =?utf-8?B?U01ObmljNmpSeUxHM0E2dTBFcFJoc3V4RVJpV0IvRDBIMldndktmbCtrY214?=
 =?utf-8?B?UXVMbHBQRU4vSnEzWkIvOVM5ZXFvVSt5N1B5OHIvM0FoZmgwUzZVSkhLWVpy?=
 =?utf-8?B?UC9GSWJTR3E5VmtLQml2eWlHZ1FaaUVLYUtGYmgrbldKZnQyekFBVnQ3Wm1M?=
 =?utf-8?B?ZndGYktzUE91dlcyeDh2VjFTcUpscDNjOEcxSTZsK3FyNnhvSjN3TW1rakJ3?=
 =?utf-8?B?N0VYTUJPVWZuVVlNQk1FazlHR1F6d1g0VzhRMFNqSVczRVJYeEJZc01TWWU2?=
 =?utf-8?B?VFBFYklnd2dNbkFRMkVwS0doSjFsZFpLKzhqMFZ2UXFscFhlWGVXc0JiSFlI?=
 =?utf-8?B?L2tGZ01jcWhNRFA4czMwSFR0OTVPU2hCUnptZlBMVk9KNTRPWFExbnV4b0Fy?=
 =?utf-8?Q?dtLZdbyLxPdreNYHDaNh9L08J?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6a63ed-f003-42e9-00fd-08dceca4363d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 23:02:00.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5ygFGsX4iMWEgQsfPLfBgAagDDS5njPD5AhO0I9LzyLd+Z/a59eyN1CMzAj6BL3YOfE7fU/pWYtQHQurJkeQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3339

Some sentense(s) about the hardware that this driver targets would be
good here.

And the subject should carry some tags, e.g.
"drivers: can: sja1000: add f81601 support"

On 14.10.24 03:56, liuyang wrote:
> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  .gitlab-ci.yml                                |   1 +
>  kernel/drivers/can/sja1000/Kconfig            |  11 +
>  kernel/drivers/can/sja1000/Makefile           |   2 +
>  kernel/drivers/can/sja1000/rtcan_f81601_pci.c | 226 ++++++++++++++++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 kernel/drivers/can/sja1000/rtcan_f81601_pci.c
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ad6f37d1c..892c20b9c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -113,6 +113,7 @@ variables:
>      - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_EMS_PCI
>      - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ESD_PCI
>      - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_F81601
>      - ./scripts/config -e XENO_DRIVERS_CAN_PEAK_CANFD
>      - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN
>      - ./scripts/config -e XENO_DRIVERS_CAN_C_CAN_PLATFORM
> diff --git a/kernel/drivers/can/sja1000/Kconfig b/kernel/drivers/can/sja1000/Kconfig
> index 9fab4a475..043f7aac1 100644
> --- a/kernel/drivers/can/sja1000/Kconfig
> +++ b/kernel/drivers/can/sja1000/Kconfig
> @@ -98,3 +98,14 @@ config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
>  	to disable parallel port support in the kernel (CONFIG_PARPORT) for
>  	proper operation. The interface type (sp or epp), I/O port and
>  	interrupt number should be defined via module parameters.
> +
> +config XENO_DRIVERS_CAN_SJA1000_F81601
> +    depends on XENO_DRIVERS_CAN_SJA1000 && PCI
> +    tristate "Fintek F81601 PCIE to 2 CAN Controller"

Do you mean "... with 2 CAN Controllers"?

> +    help
> +      This driver adds support for Fintek F81601 PCIE to 2 CAN
> +      Controller.

Same here

> It had internal 24MHz clock source, but it can

"Is has and internal 24 MHz clocks source"

> +      be changed by manufacturer. Use modinfo to get usage for
> +      parameters. Visit http://www.fintek.com.tw to get more
> +      information.
> +

Extra newline at end of file - please avoid.

> diff --git a/kernel/drivers/can/sja1000/Makefile b/kernel/drivers/can/sja1000/Makefile
> index ff6715513..2d344c37b 100644
> --- a/kernel/drivers/can/sja1000/Makefile
> +++ b/kernel/drivers/can/sja1000/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += xeno_can_ems_pci.o
>  obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI) += xeno_can_esd_pci.o
>  obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) += xeno_can_isa.o
>  obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM) += xeno_can_mem.o
> +obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_F81601) += xeno_can_f81601.o
>  
>  xeno_can_sja1000-y := rtcan_sja1000.o
>  xeno_can_sja1000-$(CONFIG_FS_PROCFS) += rtcan_sja1000_proc.o
> @@ -22,3 +23,4 @@ xeno_can_ems_pci-y := rtcan_ems_pci.o
>  xeno_can_esd_pci-y := rtcan_esd_pci.o
>  xeno_can_isa-y := rtcan_isa.o
>  xeno_can_mem-y := rtcan_mem.o
> +xeno_can_f81601-y := rtcan_f81601_pci.o
> diff --git a/kernel/drivers/can/sja1000/rtcan_f81601_pci.c b/kernel/drivers/can/sja1000/rtcan_f81601_pci.c
> new file mode 100644
> index 000000000..0e577ce5f
> --- /dev/null
> +++ b/kernel/drivers/can/sja1000/rtcan_f81601_pci.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Fintek F81601 PCIE to 2 CAN controller driver, ported to Xenomai RTDM
> + * only use CAN controller 0
> + * Copyright (C) 2024 Liu Yang <liuyang@sinsegye.com.cn>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +
> +#include <rtdm/driver.h>
> +
> +/* CAN device profile */
> +#include <rtdm/can.h>
> +#include <rtcan_dev.h>
> +#include <rtcan_raw.h>
> +#include <rtcan_internal.h>
> +#include <rtcan_sja1000.h>
> +#include <rtcan_sja1000_regs.h>
> +
> +static char *f81601_pci_board_name = "F81601-PCI";
> +#define RTCAN_DRV_NAME "rt_sja1000_f81601_pci"
> +#define RTCAN_DEV_NAME "rtcan%d"
> +
> +#define F81601_PCI_MAX_CHAN		1

The help above talks about 2 controllers, but here you only allow one.
Is this constant wrong or the description?

> +
> +#define F81601_DECODE_REG		0x209
> +#define F81601_IO_MODE			BIT(7)
> +#define F81601_MEM_MODE			BIT(6)
> +#define F81601_CFG_MODE			BIT(5)
> +#define F81601_CAN2_INTERNAL_CLK	BIT(3)
> +#define F81601_CAN1_INTERNAL_CLK	BIT(2)
> +#define F81601_CAN2_EN			BIT(1)
> +#define F81601_CAN1_EN			BIT(0)
> +
> +#define F81601_TRAP_REG			0x20a
> +#define F81601_CAN2_HAS_EN		BIT(4)
> +
> +struct f81601_pci_card {
> +	void __iomem *addr;
> +	struct pci_dev *dev;
> +	struct rtcan_device *rtcan_dev[F81601_PCI_MAX_CHAN];
> +};
> +
> +static const struct pci_device_id f81601_pci_tbl[] = {
> +	{ PCI_DEVICE(0x1c29, 0x1703) },
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(pci, f81601_pci_tbl);
> +
> +static bool internal_clk = true;
> +module_param(internal_clk, bool, 0444);
> +MODULE_PARM_DESC(internal_clk, "Use internal clock, default true (24MHz)");
> +
> +static unsigned int external_clk;
> +module_param(external_clk, uint, 0444);
> +MODULE_PARM_DESC(external_clk, "External clock when internal_clk disabled");
> +
> +static u8 f81601_pci_read_reg(struct rtcan_device *dev, int port)
> +{
> +	return readb((void * __iomem)dev->base_addr + port);
> +}
> +
> +static void f81601_pci_write_reg(struct rtcan_device *dev, int port,
> +				 u8 val)
> +{
> +	writeb(val, (void * __iomem)dev->base_addr + port);
> +	readb((void * __iomem)dev->base_addr);
> +}
> +
> +static void f81601_pci_remove(struct pci_dev *pdev)
> +{
> +	struct f81601_pci_card *card = pci_get_drvdata(pdev);
> +	struct rtcan_device *dev;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(card->rtcan_dev); i++) {
> +		dev = card->rtcan_dev[i];
> +		if (!dev)
> +			continue;
> +
> +		dev_info(&pdev->dev, "%s: Removing %s\n", __func__, dev->name);
> +
> +		rtcan_sja1000_unregister(dev);
> +		if (card->addr)
> +			pci_iounmap(pdev, card->addr);
> +		rtcan_dev_free(dev);
> +	}
> +
> +	kfree(card);
> +}
> +
> +/* Probe F81601 based device for the SJA1000 chips and register each
> + * available CAN channel to SJA1000 Socket-CAN subsystem.
> + */
> +static int f81601_pci_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *ent)
> +{
> +	struct rtcan_sja1000 *chip;
> +	struct f81601_pci_card *card;
> +	struct rtcan_device *dev;
> +
> +	int err, i, count;
> +	u8 tmp;
> +
> +	if (!rtdm_available())
> +		return -ENODEV;
> +
> +	/* Enabling PCI device */
> +	if (pci_enable_device(pdev) < 0) {
> +		dev_err(&pdev->dev, "Enabling PCI device failed\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Allocating card structures to hold addresses, ... */
> +	card = kzalloc(sizeof(*card), GFP_KERNEL);
> +	if (card == NULL) {
> +		pci_disable_device(pdev);
> +		return -ENOMEM;
> +	}
> +
> +	card->dev = pdev;
> +
> +	pci_set_drvdata(pdev, card);
> +
> +	tmp = F81601_IO_MODE | F81601_MEM_MODE | F81601_CFG_MODE |
> +		F81601_CAN2_EN | F81601_CAN1_EN;
> +
> +	if (internal_clk) {
> +		tmp |= F81601_CAN2_INTERNAL_CLK | F81601_CAN1_INTERNAL_CLK;
> +
> +		dev_info(&pdev->dev,
> +			 "F81601 running with internal clock: 24Mhz\n");
> +	} else {
> +		dev_info(&pdev->dev,
> +			 "F81601 running with external clock: %dMhz\n",
> +			 external_clk / 1000000);
> +	}
> +
> +	pci_write_config_byte(pdev, F81601_DECODE_REG, tmp);
> +
> +	card->addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +
> +	if (!card->addr) {
> +		err = -ENOMEM;
> +		dev_err(&pdev->dev, "%s: Failed to remap BAR\n", __func__);
> +		goto failure_cleanup;
> +	}
> +
> +	/* read CAN2_HW_EN strap pin to detect how many CANBUS do we have */
> +	count = ARRAY_SIZE(card->rtcan_dev);
> +	pci_read_config_byte(pdev, F81601_TRAP_REG, &tmp);
> +	if (!(tmp & F81601_CAN2_HAS_EN))
> +		count = 1;
> +
> +	for (i = 0; i < count; i++) {
> +		dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000), 0);
> +		if (!dev) {
> +			err = -ENOMEM;
> +			goto failure_cleanup;
> +		}
> +

From here on, indention is wrong. This can be highly confusing for readers.

> +	/* set rtcan_device struct */
> +	dev->base_addr  = (unsigned long)card->addr + 0x80 * i;
> +	dev->board_name = f81601_pci_board_name;
> +	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
> +
> +	if (internal_clk)
> +		dev->can_sys_clock = 24000000 / 2;
> +	else
> +		dev->can_sys_clock = external_clk / 2;
> +
> +	/* get rtcan_sja1000 struct */
> +	card->rtcan_dev[i] = dev;
> +	chip = card->rtcan_dev[i]->priv;
> +
> +	/* set rtcan_sja1000 struct */
> +	chip->irq_flags = RTDM_IRQTYPE_SHARED;
> +	chip->irq_num   = pdev->irq;
> +	chip->read_reg  = f81601_pci_read_reg;
> +	chip->write_reg = f81601_pci_write_reg;
> +	chip->ocr = SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL | SJA_OCR_MODE_NORMAL;
> +	/* Clock divider register */
> +	chip->cdr = SJA_CDR_CBP;
> +
> +	/* Register SJA1000 device */
> +	err = rtcan_sja1000_register(dev);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"%s: Registering device failed: %x\n", __func__,
> +			err);
> +		goto failure_cleanup;
> +	}
> +
> +	dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d registered as %s\n", i,
> +		(void * __iomem)dev->base_addr, chip->irq_num, dev->name);
> +	}
> +
> +	/* force into reset mode */
> +	chip->write_reg(dev, SJA_MOD, SJA_MOD_RM);
> +
> +	return 0;
> +
> + failure_cleanup:
> +	dev_err(&pdev->dev, "%s: failed: %d. Cleaning Up.\n", __func__, err);
> +	f81601_pci_remove(pdev);
> +
> +	return err;
> +}
> +
> +static struct pci_driver f81601_pci_driver = {
> +	.name =	RTCAN_DRV_NAME,
> +	.id_table = f81601_pci_tbl,
> +	.probe = f81601_pci_probe,
> +	.remove = f81601_pci_remove,
> +};
> +
> +MODULE_DESCRIPTION("Fintek F81601 PCIE to 2 CANBUS adaptor driver");
> +MODULE_AUTHOR("Liu Yang <liuyang@sinsegye.com.cn>");
> +MODULE_LICENSE("GPL v2");
> +
> +module_pci_driver(f81601_pci_driver);
> +

Another extra newline at end of file.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
