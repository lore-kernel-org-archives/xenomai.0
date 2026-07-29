Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1600D3B7B68
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318156; cv=fail; b=Gg5JHNYPdEfx0wn8iMeQJGkFTpP8r/JyLpfBENfhbWGC/9moQWSt1K0xWy+O/anqmSFv1tbfEzPSBbfZXLRNnjE/VfaY0FRpvS3U2vnR/93lo+j6mZ/YKTIgRyBX8LsFP9j0R7C4IHhNTNOX25tvY/hVSnKW5tqnCCSwz4Uv4vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318156; c=relaxed/simple;
	bh=aNiCjAj5ccVHNfGbj3koFdufG563rhIYAxS65InT9P0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IntlGOqEL2PUAdKzo/u9OxbH8eYUzfHLmEUIKJmqHSJfs5/5pWqYBS9pbkYHOHlCIaF9V8JfHxk4zUnY7pTsGmoxGvm1av+aCKhpoyrZT5QG7T52V0/WsUVCKukPUNYZng2aGiYdkuTTT24YM06GkuIzCZyWyROgpMt/vbzcxDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=g2vGKmL1; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="g2vGKmL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9P3YDWf3Eo5+3bETKZrlnnb1b8paSOpSEqtSSgQFmD4f3h1HLogZqf2ZFY8YMFXZaWTCwAk/uTObiOluKZcW4OnFPBprEj2AYtRLuDgCS8ICU931vuQdspJ3OeMtNLp8OQvfQf/jJiJ6J6TvdNlMmXbvnv9Wy5eZ/uh/bHc5e9ekAUId95ioz2EcoZAw76Dyb0V2lVMBoXShDmNt6RFw4+jGBV/2yxIyLKeApYnWEl22VY6X/dOBvXukIB/eYFd0rGXq3wpkM1dBy9MBbZKGDLIK4OTqfFQgfLazGMRPTKvSEJuMu6i8I0slFZ5/LJxrc1p3aqxBi2JOVAy/XwZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PT8JPsEFqro9orAjxtgmC9Llx72J3iEkEVJKRPz/bo=;
 b=s2oxhihv1ar+tIdqYp1NLzPJdz1gqcwkiSRFjX11vO1s7fJuBl2gi6yKLRrxRYdIiW4VIjTAKcnG81l2uKwgTnEEyz7qNsMby9Pn1lAeNOhOUigILozxBow9nfuVlIIDde7kJQDyPOsEIY7BxI6MrAXuNyRY5PCB1Ikahle+2KF52E5k3qyFUVyJrycoH1nXBV5QJVwInqeUpiIdlVfCnWwx8GzmgSrgowB/WniBh78+coAoCQT4XhKrxxt9UNumIswXjIbXbfJBtMbS4qVNKcUATGhZhTQmumszUkcdizVdhYuY3lgiUDJ1V5EsyVUxIna7mK+bq6cD5AbSEcw6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PT8JPsEFqro9orAjxtgmC9Llx72J3iEkEVJKRPz/bo=;
 b=g2vGKmL1gb4C4aESdTIDVMGzJ6JHbNp//9kvGWVwpp/ZIRcyVTFlSn2NTr5zoutwtB/s5n6SfQjeXgjMaGznoPfs160p/jHfDYgWqZlIe/QQKJRZEhw1DIpZFgLgN9cpH/bqzlT/pNXtePIKIPOICwDEu+az+4tQDCyLGRXDWjLhWZI9uenzKcIPy3Pycieh9J63lLnSoUJ+oUqCil5o3/LG79IyHHmRjutU9TzB5ifrtqprp3ySSCjZSaLGY2ynLP6Ogh/Uk2ALIqRzCrZ6soMQghBovCK9+zMbvKvqmgNHQqTEMgmV9y0AyP8KXd2ITac7ZFqLrCMstNJB/xPYpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6454.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:42:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:42:31 +0000
Message-ID: <6aac4166-9107-4b09-b37a-cb3f71ee0cbb@siemens.com>
Date: Wed, 29 Jul 2026 11:42:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] libevl: remove the riscv custom branch
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260728143332.2746337-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260728143332.2746337-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVAP278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b534d2-d39f-4085-6b2a-08deed55b575
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|55112099003|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	QulB1Fws8BmhKSdluZ/0CKnmQLNyULhFvUG9yUntSKv41d3ExKPqVgKnUgPwo6OJMQ8rvahtKrdJAyQSt8oic+neGnOSQzPYHmPpDiifJbffDcKey/OmcDMoRihgv347KtnbI3Vg86dsUk1I6uhPGEeTLgbVin9ro8/Rtrj8mqXoJY+3tQV+mvopTYFj3dyg3nbleA67Z0O0LAnBvH0+csfV46Qvc3QTprm1HRdQj7Lnf/0pr0nCurHBO91OKdOaSRCt4yFEXnIsNejb/aAozXzmYOgOeEqy8afJ7JRdyOtRPpWU3RjD7v2NeVQl09G17bTIHaN1BTqHtGcl1KKeqCGnJ3dorcp5mAiep5pGf6aK7b1bCnN8zmZC4l0/O4d9vQo/BeD21wwxzBr1w6V+N70ZS4wRfn2Nu7yP6X3ZgFHrRE8Ot6ZD17N6jGg5bIaiBRwskjX7oPbOx2BuYjtUrPiD9Zls0boogLgeFWb0Stbp+i1BtHOx18WTIAklo+ss1WbNKAaKwmQrGW4NWGq+2ACJyCP9bTmJYr4myfyJAFAEz+ZOgG72NUuOUsknU2qycetK1nKV0GSrUvyIhyfHbxyEIs3/DEvjbBv2ko9BygrlBikgPv+YlX0SWO1ukMFHHEwa+GAVOw2pHwZx+BRSFOE9PjT/rcV71di+5yihP3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(55112099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnM0ZE9ZYk9kUmpKdHpIVHBuSGtoQzhCRlZielhOaTJFM0VwSmQveHEyUHhh?=
 =?utf-8?B?K0ZUbytudzl0cGtmajhlTWNZbkFwYXpaZkhiTUVCVHlUZm9YMFRZcjlpY1hn?=
 =?utf-8?B?RGtQZGpyWGs3YXNLZVhid2JGTHdCdlpJR3FMWlZxYm94MVF1UFRST3JFR1dE?=
 =?utf-8?B?dDArNE5NWDhSaHRZZzdKQVdBcjJiT3F1MDh2M1BTbmRPTS9EWFZ1MHJUN0g4?=
 =?utf-8?B?dDFkNkhWL2pLRE5qcXlvZnhLdzhXYk0zcGJHN2Q0alJ6WEs0WEY2NDhub2Rj?=
 =?utf-8?B?K2lTaWFPNTNFMFgxZmVLOEdrMWNDbHR4clM3bmRRNmJCN1ZXTGtqU2YrdjZL?=
 =?utf-8?B?SFVaWGdqUDMwcWFxVFp5bTBodVpOUU9HTUVQbGtLdkVDcTMyeXVmVFM4alN5?=
 =?utf-8?B?NEp5MmdKRFR5bzgzN0hyUk1Id0F5aHc4MUVjSHVyYVUzMElFdWR5OFg2Q1Y0?=
 =?utf-8?B?NGNjQUViTjRrNU5aRmNERm1KU1pkRm8rQjRjNHQ0MWMyRkhHanB5SG1ybk5w?=
 =?utf-8?B?czV3TUVtSXByajE2emhpNXNld0dIVmFQNlNHSVNXaVNUeENhRGRMbmNJWlFh?=
 =?utf-8?B?VEFhdUJHUlo1aXRkTjVYdGlKOVBLdy8wU0tvQW8rS3YwYjNJc2ZVOWtXTjcx?=
 =?utf-8?B?TWF3WUdlUFJoSHhtVWs2eEU4eXhLdHBJWGc5azEzeU5OVGV2TFNIdVFZU0pS?=
 =?utf-8?B?RDlQdHFXUUdrN0d5TnNtcjlqWVcvRjFRZnN5dko3NWtnc1BRSEFrOVpIT0lD?=
 =?utf-8?B?Rk9OekZCMWsxakZpTm4vTmhGbnF2a2hmdjY1cXI0UzhVTFFhNzRPTGF1RGpB?=
 =?utf-8?B?ejh2ZlNzWHVTN3E2ZDNNb0hEZG9MbWRkaHZlNlVXQTdjaWU2U25lTExOSXJw?=
 =?utf-8?B?eHBBUHhxOEZqaGxoUlhpL1h3ZU4zamFqTjVGME5aYkhJOVQ0UFZ2RGdDaU5P?=
 =?utf-8?B?bkJKSlo4cU8waWhicXVmdytTc2VnYTZSQmlvZWxhSVdmMjFQenQxQWE4Vjda?=
 =?utf-8?B?RFdwUzdEUDh4dGt6b0hvMGthS0hURVBkM2p3TUwrcnN6eXkwSGdIL3lHWVNS?=
 =?utf-8?B?WXh3TTh1Q2d6ZWYzZ0dWamVtbmRsS0NmdjB1TlNyV2hGUkFWdjBVemJNTTEy?=
 =?utf-8?B?QVpFN2JPQWpOd2Q4Y3RjelpCbkRrQnFlT1M4d0oyUXVEdEFVUWdNWVY3NTQw?=
 =?utf-8?B?aHRhc3hJaTRXV0cwYWxWZnJDWDhNWnQvZ1BteTB1OXhKMlhPcjE2bWk0N1pr?=
 =?utf-8?B?eVNYREdyblBINVhVajVkUVFleHBRUDRJaG52clIzQXNyNkozNjY1c0xQSjYw?=
 =?utf-8?B?WDJUQXZENGxvTEFWVDYvcTFTNjdCK2N5YTBQVU10RlJNMUVaKyt0SDZJeUZi?=
 =?utf-8?B?R0tsTEpLMGJ3ZWRnSU1oMkFhVk4xL1Q3ZlVKWHVRSWZ5OHovTFJMVmdUeFFV?=
 =?utf-8?B?TEx3SHFiakMyVTdkdUJ4ajVhb3VDQkxESFNoS0hsTTBLeWNNb3UweFBQRTN5?=
 =?utf-8?B?S3h0R1hYZi82U0M1MXVPTnE4TXNSNGZkc2YwdzlxZjVsMEkxQzcwM3kvK3BK?=
 =?utf-8?B?SGNDWkY5bVpPZFlNNXlkQzNsa3dYZVMvOUJ1eEZaR29id0poUVB0YjZGZzk2?=
 =?utf-8?B?M1paMExUR1d0TmxlR09nOUpEaDVESmFBTjhLdlZqMk1taE5UekJHYlcxcVF2?=
 =?utf-8?B?NDhqbUZVSUJvWExUN2RBUXBVUEpibmZ3SHp0Si90QTdVUVZ1U21rL0oyVURX?=
 =?utf-8?B?NVJNVHYxcmZwaEFTNGtDd21oT0ZPS0hHS1cwNlhzWVdLR2QrdFJqUU1XaWZX?=
 =?utf-8?B?RnAxNStYTGpXd2hWS20rc2FMMTFEL2hWSTBLN3lIR1dpc2JkdERpTlNNRlZZ?=
 =?utf-8?B?cjg2TUR6QjB1bml3ZEN1RXNIeFFmenhBbzRTMDQzNkx1NzZHdG53T3drb2Rn?=
 =?utf-8?B?d29PaGZ0TVdLRGJvdzU5b0lvY3lsYkRRZFk2RTd4UVpYSzJyWUVhUmR1Y1hj?=
 =?utf-8?B?ZnlWY3BJcWZXdTl3VytjanZ2eGNqeUkyeGQxVjd4b21xM0lsZ3V2N1pJYytV?=
 =?utf-8?B?bmdtbDF3M3JXMW9ERHRsNUxMd25GMUxIV3MxeU9KcU4vMlZsa0ZMUmVhVjBp?=
 =?utf-8?B?cTZHRWNSU3pmRGN5czl4SEs0MWErZkZiWXd5aXA1YkhLRVFKTnN0Mi9zZmJr?=
 =?utf-8?B?OGF1dVp4b0pBem1UaHpWM0NjQmoyMmVqWjVwclZCdTlwdVpzbWIvV0ZLZEJv?=
 =?utf-8?B?a2VCUGZ0aFpDeFRKckRFOHQ3MnpnVVhEYUJHZHRLODRRQlk4Y0EwWm1RUHEw?=
 =?utf-8?B?NE9oc1paVEovVFhGanRmbmwxeVY3RTllNng5SjdhdndPT1JwaFdHdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b534d2-d39f-4085-6b2a-08deed55b575
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:42:30.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tTg5mK8lGgBJHqTP72TjEK/qXqlfcHJKk7LedIjnW9rDvokewTz+lk25bchN1gO2mTZCnyeQFfG1GJJ3IOYRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6454

On 28.07.26 16:33, Tobias Schaffner wrote:
> The riscv build bits have been merged into the libevl next branch
> and the custom branch is therefore not needed anymore.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-xenomai/libevl/libevl_master.bb | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
> index 48f10dc..f59949d 100644
> --- a/recipes-xenomai/libevl/libevl_master.bb
> +++ b/recipes-xenomai/libevl/libevl_master.bb
> @@ -12,7 +12,6 @@
>  require libevl.inc
>  
>  GIT_BRANCH = "${PV}"
> -GIT_BRANCH:riscv64 = "wip/libevl-riscv"
>  
>  SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=${GIT_BRANCH}"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
