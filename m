Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3527FB3C
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680335; cv=fail; b=WWKRIbRUql6oZSlRGMhueGmA8yMjoOgXMDRsYEBOlCRgeWAXqVdjuh71MParUGGu6wTgUxPa+X2EulEEZedxjKYLUKCQvFLF7THKPdbGZSXVR/7t8aDRxtfp747w04nqCpBwbFA8L2XE4uJnTn+NXh+5yNoeE09yY94NI6TcjPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680335; c=relaxed/simple;
	bh=B/1aGmLGcJ7As2Xi6e6MGrhk4IO2wzgdVOd9EMsIxP8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PARUBaX6MJVkosJUtHXO2BFAV/FFmuwRPHKaprPYYJCTv3B0pKwb50uCFdMtvE0X0J12GoRTmF6/YhyVfIoX3+iw6wS3anEBVCl9U32w3GBp1jX1uf9cpJK/L4XPJbt5WU6ZRytNRBWYv7/2FKftAje9uG5BrfM98BStGdXK0H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lxqz3THg; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lxqz3THg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIJ2EWOdNaUgxxOB68okTPYZ4E3yqZTIKRQp5jov2nFsK8anZzt9AxZrigrWGxqj4VhPs17SI7cWIBvKxwIv9eDpi9KlKtYmXnU9gOA3jg+JD+1kNKHYf6PKuGjRGPjwz3KfZb4h4i0bU4tC3pXEZU1zMQZSPdEkogiO98com6LEJ4tz4Od1SS/i1NCA4s0xcqtH4bsEj0xu2bHqHtLqsdlG49zs2+g8xBUzm8yWqp75OXzHAKklPxQu3bvvw9uQ4ikt8SnxMZWbB6EWneBhfmV6Aso7gyX7cmrHr3sljjx/RUQcYR2NsXoLq3OURC/NXchPCTq6mESC2C4SEOM8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAF6d0c+8l3ugSJ3RLPOz96faXlrlKqvg24zeuigo+8=;
 b=QJERGS2ut4iHXfsf3EPgpTFgPq+sS4ceuE05nBOSDg8ZIRUfc77nXuYZsSkvSHgNsbV0LsO43todnMuKXFHMXurjrYINx9NCAH6UVZHByd5OGp6AFP0fapU1mmnhbTEAIPY2QWkHf8yzCQBvJiMlnwhfHUe0ltxEbLBs8fgO/caPT4r1+gI8bU6LgjRogLaz5HRDiJ1xXhJK9B/3cYenpwSKdco6dfEChkiX9LsxkvxuM2a1P/Iw+PIw9n8bxWWX2Agbr6ByAhNMTTebzC9cHCA9tFEcVEH77LkNh3Vfivb91s3BCbE7qs9NAdKcsJ+3CWBMql/0e3wSlaI/MfrFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAF6d0c+8l3ugSJ3RLPOz96faXlrlKqvg24zeuigo+8=;
 b=Lxqz3THgxGyauyM1HG8pDwPY8ZKMP31ma99V6wVPGosc24YcGyD5XwLR0MpMEyM1Lszo7XGVMjKll2x/GzdnhoBJIaUS3Ixg2QUxdqUs4bEOXyXAUEi5TL0SNHWIDk2xUkThJBb14sXrc1H+OdAHgzaeEJLrVE1LTIavrwlnk4qiSguYX/yh7aqjh3JzVihgfRz1w98eevpOXxyqC4dGxul+44pMjsgP1z5rH1vk2jqInSaiWSE82vtRtwbkbU4wmgGfJ3+SqiYyw4SqqxCRTH9tyrTz1SDC9idNsncrTUXCP2VLfJuS7qPoNCGN45YwmrwC3m6hAuQ50okRLzAbyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8771.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:52:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 13:52:09 +0000
Message-ID: <0a460b08-ec31-48c8-9255-98c562f3ca50@siemens.com>
Date: Wed, 13 May 2026 15:52:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] testsuite/smokey/vxworktests: Fix compile error seen
 with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
 <20260513-wip-flo-gcc-16-v1-3-120ae1287401@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260513-wip-flo-gcc-16-v1-3-120ae1287401@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ac7265-39b5-4513-4d82-08deb0f6d3b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|11063799003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	XodT5IHFSds1a78b0Q2vWWQ7f6htH2MCJZ4AF1OnDKkysrGlVvSzCz9VX0SzDzC1tAgoHj17RxYXc/a/PsCJuxjPURoPAqJGIzWewSYnsISaNYh4t95QyW2ZXII286QtnfIDQRBi9tOH6T/7k86ncXzowNEZIGQbZXbeCRPWLVZNCZo2pXymOEsink9fX8Rp368SxnQZG0NjIwkLoVeVE/0HmBktivdK2SEDE0GCAa1LgKLdQR4FITmaWe/+Aqlj77XbgLGPtMLziQimoxPHJC05N/nCM5f54iyYxY8XNCEyTXNMlVzfeY8lLPCzXSp2zfb0OOOKtFA6Uje26LTjXq6t3Pws6v6nnNWNlo3bwC2CaqGcK+bwY7ZT0vPKvDqdYlOgKlLWQZGMbnQ5zlWStcXXx3cKc+x5QX+eWEfstwdKyXM96vsP6zlP1UUpDUWgLaR8Pdkn3GVKYAcWjj21TEY0qHz+UMGn8KsL93ItdeoaL6ZwuYSdnUvh2BBf3l6zRzKu7RFT+JVyIgEceRlEG3Zn/WseKXwwMVgQtiENosv0XbOAr1gu7pqwEMu2q5pD24cuVSjE8vwR9gWp03mcZwbLLXKYU2okL6tKhVj6ONUMuj28P9mDiWroGNXELVXWIS38SqGKeUU0W7sqcVejLnNiZOkCn98H6HjuGqUbpmeAEL6emVHFn/g+7mG2mMdV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(11063799003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTZrdnZydXFFRkVHTThkSDhtbFFUSFNhNzNObDh2WUdyRVR2QXdQcWhVV3k2?=
 =?utf-8?B?bEIyeFpoL3Mrd0hLNXRNMUszNlpYMW9HdWE1aHNZRWMzZUk4ZXhtOGdoSFRG?=
 =?utf-8?B?RzZVaUIvcy9DTStaaHZsb1NRaFI4ZXF3SW43Um9hR0liOXJiZGMyUnVraXVQ?=
 =?utf-8?B?c1BTVlZBb0MwU3Vib2VnTElNWkZxNXkwSkpwUkp2UXZzR3J3UzNtdU02Ymht?=
 =?utf-8?B?K0RETzhFMmU5ZytDQnQwYy9UY2VnODM1Q3RxWGlkeHlpN1VaRiswc3VWbDhv?=
 =?utf-8?B?NEtLQXBiOFVKcEJyRGNid0l6cWx3aWFac1dKYlhBKzZNakh0UHF0WlBvTS9X?=
 =?utf-8?B?ZzI4ZGh1eGhhS3lMdnRXMWtQUWlmWDNYTHlsNU5mLy94QldNeXR4dXBGaC93?=
 =?utf-8?B?ank5WmNscWtuL2QxQWJheGtBOHNzZ2hqK1lvSWlHQjJLNVMyeXFWdFY4dnBY?=
 =?utf-8?B?VHU5Z042NDYrK01WZmIxcys0N0l5S0w1RFpRNmkxRG1KMlVtVDROQlNlZEpT?=
 =?utf-8?B?bDF6WllEckRQZnorUm04WUFsZ2dVcHp2SnpwZ2RLRGJlL3lOZVgxQlFvV2d0?=
 =?utf-8?B?R0MvWWNVUkNBWmQwdllFTnptMXJOT0c0aFFoeHVnb0ZVazYzOUdQQkloREoy?=
 =?utf-8?B?MzR4MGpjNUVIUXFqVU9KVGNjTDB0SzB6QWc1bStCOWtZanNhVFFnVmVGRXpE?=
 =?utf-8?B?b05GT0t1b1VjMTZVSGk2eWFrVHhpcGN6bnBRdTNEeWlJTFI1dDhpc0V0TjdD?=
 =?utf-8?B?czAzb2doMmI5cE9haFFnVnBURE5OQ2xZdEp6bzFIUU5JSHk3U2o0WjlsTis3?=
 =?utf-8?B?MS8vY0dlREpuR1Urd1pvMytnVlMwSEpLbmpzcFQvVWkxODA0OUV4WHpMQ2Fo?=
 =?utf-8?B?NmpOU3hVcStNcG9VSGdYdG52R1lWSFhZZVZFUHlybzQrT0tjcWhwN1UyS1RT?=
 =?utf-8?B?ZnJvNGZxeGdpL2VBbzJ5WkExbkhmL0lMY21vUXVrY1dEQmZQOFc4TEVZZXB0?=
 =?utf-8?B?bWdpdVY2UWZEUGlBRkJISXJ6ZVBnLzFHd0ErdUVFM2ZMMkFsS1puWXc3THFr?=
 =?utf-8?B?M1ppdXdhOU9FY0sxdVp2NGM2VnVwTHZWcDlsdWZpS01PM2IraGFZb3BBMUlI?=
 =?utf-8?B?bjFhaVpqdjlXekVBSmdVc1RVYklBak1oendicCtEL2xrczlhS1hxN0V0VTdy?=
 =?utf-8?B?NTRZMDVOa0ZFT0tUeGN4c1FqNFdyNkFSYmoxRGFCRVdTdjIvRGVPVXk1UkRm?=
 =?utf-8?B?THF1aFV3cEJxMDJ1UGZUMHFzeGRremVVWFh0eFVmbXdJS2kvdXZoNnlVbi9U?=
 =?utf-8?B?bXFZT3NWTkF2eWJpZ0lLUUdkWGJWMGtkNmY4MlJrTjZYNVFPWWtKbTlRTjBQ?=
 =?utf-8?B?MDdGRUlEWktLdjM5NzNqNVJhN2s4TUhJcGFxd2F1UTVKZ0RzSmJGNTY0ZjE4?=
 =?utf-8?B?Yit1bEhWWGRoZEFFbWRpMXg5MHVPNStnSzRsVzNXVE0vaEpZMGtMSVBsUEpW?=
 =?utf-8?B?b1p0ZG1vaEpIZnlBZ2RYU3A4dktLL0dnMHFQYmtrU0FrOFNyTVpwVzltNnJK?=
 =?utf-8?B?ZGlzNnNRMy9ZZ1grWE9zMlM0R2MzMktaa2NsV041VCtkTEtnSDB1akJyOVNN?=
 =?utf-8?B?aForL3VvbjIrenBxVXN0aTY1alpxaVprQ1NvTDV2V1RCV05KODFxSVU1VUg0?=
 =?utf-8?B?RWVkS01LenZ5QmNXTGwzdklKTjY0NmJmam9OZTh2aU8yWjBZSTVNM0p1VFNC?=
 =?utf-8?B?TkxQZTBoZ0kyTFRkdHplQVlWek1scG9KS1dWRHBmSDZzL3JRclM5eTYzU3Jt?=
 =?utf-8?B?ZzdEaEtpL3M1cUd3RFpGYzdmUDdjenYrcHQvUjF2cmJZY01HQ09rdVhHS1Fl?=
 =?utf-8?B?a1N5cFM0K3M0T0FLd010eEc2TmJSVGYxQm9sS3AvWkgyUHgybHhVckxVV3hM?=
 =?utf-8?B?VDAwMWhOMEdEV0hSUXQ3b3ZoRmVhKzF3SUVLRkN1YUxOVUdrU1lzMFVXbWk0?=
 =?utf-8?B?bGNtYzExYmw5aGZtRjBpZVlUckFKV0tmTmdGY3ZhTU9rQk1jNU1Mdkk5cVBG?=
 =?utf-8?B?Ym9NdU5ZaGxXOUZSWkxta1ZwdkRDZFRudGNBaTJTYVVweldyaE93Z2FNdDdF?=
 =?utf-8?B?WG9qUlptTUR0MWVKMWZSaFNNb2wyZEdjV3Y0TzkxRDBPU0hHTmd1TWNpc1dS?=
 =?utf-8?B?TjBtaVY3Y0U2NWZpNkwrM25Ua2g3blJXQkw0OFMxc3J1a1FHMmNqWWphSDZh?=
 =?utf-8?B?YVRVTExVVzBQZG5DR04zeEo5MUhBZzR1UDQ5NEE3UW9GMjlSeFk0Z0lFRXhE?=
 =?utf-8?B?bjBRWTJXVkdZVm5iVUs4MDR5eTQvcnkvUlFQUWFjTDdJT1ViNDdkUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ac7265-39b5-4513-4d82-08deb0f6d3b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:52:09.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdO/dj5P1SwmMIflPa32jG/xx2HE9Dow+ezzuSQR+nvTjei6LkrNw5fQvCUOc33GlrOHv7XwoD1+25cGbYWcSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8771

On 13.05.26 14:50, Florian Bezdeka wrote:
> Fixes the following error:
> 
> task-2.c: In function ‘backgroundTask’:
> task-2.c:26:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>    26 |         unsigned int safety = 100000000, count = 0;
>       |                                          ^~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/vxworkstests/task-2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
> index 0cbb9e18a13383418c4360241ef244b8a24da975..ed3e31806baad930bb30edc53d2dc6b6e51d6277 100644
> --- a/testsuite/smokey/vxworkstests/task-2.c
> +++ b/testsuite/smokey/vxworkstests/task-2.c
> @@ -23,7 +23,7 @@ static SEM_ID sem_id, fdone_sem_id;
>  
>  static void backgroundTask(long arg, ...)
>  {
> -	unsigned int safety = 100000000, count = 0;
> +	unsigned int safety = 100000000;
>  	int ret;
>  
>  	traceobj_enter(&trobj);
> @@ -35,8 +35,7 @@ static void backgroundTask(long arg, ...)
>  
>  	traceobj_mark(&trobj, 2);
>  
> -	while (--safety > 0)
> -		count++;
> +	while (--safety > 0) {}

This first of all increases the risk of getting optimized out. I suspect
this is intended to generate some load, and that needs to be preserved.
We should likely do that via a busy loop which spins for a number of
microseconds.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
