Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484181E1A3B
	for <xenomai@lists.linux.dev>; Mon, 21 Oct 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511717; cv=fail; b=shmXu9IpLQlH4W0TYtYj5myandUgqGQYRqh3OUPh8isCHdWZCYJUPbzTrtSIVXJvSSdAjFJmlG3riKRqfP6GAihBm8Ccr4NumzvT3f/y9eCm9/2jYz4t1QWDyHYqUgwou47OfxdUv6LRG13VHjEVqfyTZyJTVJWlwpRVLlKV9qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511717; c=relaxed/simple;
	bh=T+y/DTJzSMAEUT8dmOUJpYjIKEpKlhLlWl4kFJkTgwI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JVLFoWHu67fDRbyMz8+5d9PWDP8GAurqbCc85jtlA6ds2AsYHDJQUrMDDtR88sw2cpYNOA5cpOb9UjbDECAPpiGw84ZLtGgVZSgtvevxYhnKeh1Ga0B5h6sc9CRMgbZp/mF6vlUKaLkWGYxN/6y/D9kyyh5qXWTWgoDqXQLNlNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=esVGFMhT; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="esVGFMhT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3fBlqVbab9CBbrPJtoDdklXKolXozkMxTR2UcDWmbAaGVJjtzFwx+j3OMDKNS2PNH67WpOP5rsvV+V3ol152NDntBxWmClzgJCddfFXBluLEWLbd6vAdcEoRqnl6bahqgo5lIuGOKhuOYNpldgPpaphwzbKhJn5o2oJyd6sklvJYHdJ+8jNwr6coNbA4qalVhj3y+/uLsWwQcHbvUHnkIWOyCZtLkcA0aJn5G7r3arrcaTIviHUV6INdAx7ojXnTf/lCQZv4P6oQZmCv3/+6Ji4Kkig7Uy+9ago2C4u1tkCeklLC978Pk7PRA0PtsLJfdKN8pMFeupkfOFv+lgUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCeNKu8393oh+JJpZIoRIiGZzyqpJdb42h/yMV/Fn+E=;
 b=dtXKTJplqtSIgGcJmWD9NL62yW909oaw/P4OdfOBnos806uCAaRX2JBOsnCcqUkjiX4DrPw1pAYMZTh3YXcZg4v/+rDuLbdNo9lzD/UqvAuqzxXeb/i779mbhhzqcgFQG9NpR6KfJz9m9XFNKOldUb2XCpy3JVHe48OE2LrxfmPfRkyRqNgxC8HT8A5wC0ZvKZ8saISLjcigxSTPjHOe0qJ0qJQ8dIkc+WXam9VQNVh0Yewd5cQe73bSShnh6dZi84K26csA3NNQ25f8SiuugwlCdr9qd96Bi+rUWMC8JofmB3dLI/myihmXkX5ZprJ9Qv1vr5/pDKnF01BxRZDiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCeNKu8393oh+JJpZIoRIiGZzyqpJdb42h/yMV/Fn+E=;
 b=esVGFMhTbkTgqolkpfMuWjGkqZQYr4ZV9Ef/qaTFLDNepoEam90Z/U1qwzz/e9cScRwok1U6fq2mc4uum/BW9MkBtu9Xx1a+wIuTyZ5q7W+HDv0KT/H/y9rLfFOfUfNwcj8PfLadiZy+fd+r+pr0/u7VJmZkPvitg46bwZ8T2OFDwUjhgqBIbpoTdiffvPsM46nFIQ6QjwMvFiZ9nle0P7Sq/VicwOQwvXxkVY1+8bf4revas41eiy7welxPJuwoz/4GK9pxw5FsuCAUg0G3MTKfysLHM0wLcV9vPzAUf5+9hetPWbwFCGfmUYkAtfptSA0lvi5m/nTU/1/IejmcKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 11:55:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 11:55:11 +0000
Message-ID: <22d28433-8d1e-4b29-b1bd-33eadbb24336@siemens.com>
Date: Mon, 21 Oct 2024 13:55:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] *** Port dovetail 6.6.y to Loongarch***
To: Zheng Zhang <lz5333885@gmail.com>, xenomai@lists.linux.dev
References: <20241016183505.738682-1-lz5333885@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241016183505.738682-1-lz5333885@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:610:60::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: cec54dce-db3e-4f7d-a3aa-08dcf1c737c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXdLNEE5dWkzWmZuN0l3MklaSlAzUE1IYVdhV0xBUERkVFZRVmM3YjN6WDl6?=
 =?utf-8?B?cXBzVkFiK082TWNFbVRwaThuQlFuV2tJaENpNE9mU3FMR0JUNE1HSnVhZlEw?=
 =?utf-8?B?bmR2aEtZTDhybUl1M3pRNjR1dnR3NmVXaXRKdmlucUE3RHkyK2YvQnRkWWM3?=
 =?utf-8?B?V3RRRDBDanl1Nm54NG1SM1F2QWt3Rmd4M0JzZmE5aXBuQis2ZkVpU2QxK0hE?=
 =?utf-8?B?cGsrRXVXb3oxQ25rS1Bmay9Odmp0aFd2UTZYZjY4UjZGcVpqQlBseHVtMFRw?=
 =?utf-8?B?blBXSEZGZitDUUxpSzNwYlBhSER3RExGSXRrZXN0Qk1ISnUzekhmcG9yN0hZ?=
 =?utf-8?B?ZXVWSHFTUlM0Zk8xT0VUQklsb2VwS1k0WFI3SWR3TkR2dW5TM1pDOW9VUTJu?=
 =?utf-8?B?WXV2M0twZkl0Q25BMUxBTmN3ZnVzOWxabTBLY0V4SEY1aVZTQmRsVFhIMkd0?=
 =?utf-8?B?RXFrYUJ4VHdxL25nc1VHQTdXSEE3SnJEUStSMmhvaDYrSm81RktXV1VTRkY2?=
 =?utf-8?B?UHNLYWRweFdxdmc0eTBHZTg5cGVPZGNJZDJVQVBCdnJqUFRGeHB3eFI1TGpH?=
 =?utf-8?B?ckx2UVVBbkxJdXgrMmJ4ellycTFCUzczT0RsdXJlOXliM1V5UVVVaVN1UmFG?=
 =?utf-8?B?YnplYmdSa3BZMnF4VlNqNnMvMVBjYlZPMDRqM3JVY1M4aWRjaTkrTnJxUDJ2?=
 =?utf-8?B?Ti8vRURvM3Q4ZTY0bGdhVkpoY2E4SmV0ZnV1M2cvMUxwZkVUVTZLM21rd0Q4?=
 =?utf-8?B?UTVSYkdrVE1QWFVjSC9CSWJ0eFZGdW1kdTJ0UHdrSnFkQ1dDRnkzcU5Wam93?=
 =?utf-8?B?VFBTYzcxOUEyL3BDM0YrS21xeUlGTzRIa0dZNVBwRHo3dVExMUkxZDhsSDRJ?=
 =?utf-8?B?Sk5PSUdsZWNJZk9abXRaUVRSQTFtdXovZzN3dmlYUnF6aUJvZExPbTRpeGNF?=
 =?utf-8?B?ZzA4VGJiM0pubDEvVC9yd1ZmV3lLNGo3aW5tWTZudHBLWkFDNVhLRGpKZ1dF?=
 =?utf-8?B?VTF0aEREWlUzdmF2SlNNY1IyQ2tTWEtCVDJJVzQ3d3B4cnFmb0o2dWZPU2w4?=
 =?utf-8?B?SEZiV3VjaTNEL1ROVlZ1MGdMQ0hBM2hWSVVuUGovL1Z0RHlxNjdnZzVReC84?=
 =?utf-8?B?N1kyWHRDMFJIMHAydnE3Q2FNVVkzYVVxNnZHWTFvTkZ1SVRrZU1UZnEwaStC?=
 =?utf-8?B?MlRYTEZTUVlHaGxUUEIxTkZzdzFoYThpYTdXODdyWU1qc1lEYVFGSTdwQ0Iy?=
 =?utf-8?B?NjZhZW96d3VOOWVEempZbkRTUW04SUI2b0FGS29uYUxZYUlZWktDV1pKQTRz?=
 =?utf-8?B?V2JMano3ZzdLekxpYVRFMGhXcStnS0IwekdjeHlpMThaeC9FMWhlSkNtNXlW?=
 =?utf-8?B?N253MjBqYU5JbkIwbmtsckdGOWFnTkozWjNkd3Myb0l6RGRKRHJMZXNkUHJT?=
 =?utf-8?B?YzBiM0t0aFg1cVhIQXVIdnNSUm9mR1hkWkdadGVMbTI2Sm85RlhKaEpRcXdq?=
 =?utf-8?B?dW9WelFsSXRWNmJUcElNVzV0NzlVWjl0VUk1b1VmUU5IbTBoTUkzRXQ2OWZH?=
 =?utf-8?B?TUFzbUFtRlNMNVdpYTc0VnZnTzloeFlrM1A3eWlmWERMSmhsL0VPZTR3K2Zq?=
 =?utf-8?B?WFQ0bjVITDI0TnpVN2pxamhBWFFEQ1B3M2oxaVZQK2F1ZmhDNW5BVFVQSkZZ?=
 =?utf-8?B?ajNCY2JnWk5tMEVrT05WUlZIMWkxcWowTThKU1BGT0V0V2pBalk5bi9OYUVm?=
 =?utf-8?Q?TFTMs8IoZoQKHcUMem0FKGTc2F3hevlDT1RkxWu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3R1VHROMTExckF1enY1NXdiNllURkljdVIrV0pjbnhvbkEzdUlBb0dMbUxw?=
 =?utf-8?B?MHVEYVhnbE5TODlEYmxVSUdpWEljYWFCQW5vSjNxSGZLMzc3L2VadXE2cHdv?=
 =?utf-8?B?ME5Jb0h0Wnhtc09XRThPRmdWaW1oZHplbERDbkIzMGkvMWM5OWp3dklEaXFY?=
 =?utf-8?B?WlRHT3AzMmR2ZkVKckhvb1M4SlUyR1B2WkFFTG9TSHo3c0JCUWNxcmZCVHNk?=
 =?utf-8?B?OGpqSUJiNXVNWEV3RThSbWJ1WnJieDBjUXpEWU5HU0xHNzVYZ3cvcTFIdFlO?=
 =?utf-8?B?aWUxWnVqWkJtbng1VTcyY09tZEcwSy8wVU14a1RPeCtDaEhOWWEwYjhpSWFR?=
 =?utf-8?B?RVZQd2lmeTVDWXZBMWs5MWx3Szh5cWVWdUc0REtoelVTRUhiWnVtNjZSK0th?=
 =?utf-8?B?cXhnQkhLMVN5dGQyTm4xTU5UZ05CNkwxb0xzZVhYN0l5Um5FT3pCMmVINWpQ?=
 =?utf-8?B?bmpFNU1wbjJabnNhYjNhYVo0OHF3c0ZGWnF1YklxNytJczZBTkRUbjdpOXRj?=
 =?utf-8?B?T3BtR3gyNTlFWlBnSEZ1NDBiLzQzakxhOVlVVWFwelM3dlF3dmV1cGlWNE90?=
 =?utf-8?B?UDFtNWRsNHVWZEpiWG1CVG5hOTBWbkxFYStvSFVIS1YzVHJIMks2aS9uZG5G?=
 =?utf-8?B?clhGNmIzRlJrYUFLZEdudXVQSENwRFBzUE4zMEk3REFoY0RqQkdyeHVoTWhp?=
 =?utf-8?B?ZnBiUlhrTk0rUnErYndRZ0pCd1JoczhwOFNQQVFzLzJ6eGhyUG1YdDV1NDRE?=
 =?utf-8?B?T3lSd25qYUNLbHNCb3BrNmFuT3lCMnpFaUJtK21idFh3Y1NyYXpsMUNaSGc5?=
 =?utf-8?B?TENOY2F6WVY0bjNhUWVQY1dzZHk0dUlrYVp0Y1pHYmZxMHl4N0tBRTlWT29n?=
 =?utf-8?B?MEJObHFxY3grRllKMys0cGFIbFZTaG5qTzNob3Jud1ZwRUpJMi9qenpwTjN0?=
 =?utf-8?B?eXpIbkZvOVpEWU94L09aOFRrNXNzc09ObmlTMW9vbEl4dWtOaU5xMTBOTlND?=
 =?utf-8?B?ZFl5MWpXRk4ycmFxRTdtSUo4bUtZekNERXMvb3dLdTNjbkJiRmRhWmNyYjVa?=
 =?utf-8?B?TDIxN251cEYwZUx3ZFNJR0xXMFNDMkRsSEpzdTRKTG9hVEhNRmhmVWM5ditO?=
 =?utf-8?B?dE9XaFZleFV6dkQ5REdwN2tralNmQnhOanNVaGcydXR4K25aSkFFa2ZNS1Nw?=
 =?utf-8?B?MGttZEZvbG5BUXh4WklyVUJ4aHRKdmgxNlVPanRZcHlxaTFsUGdheXR6R2pN?=
 =?utf-8?B?Snh3c0xBMEp6ckxVV2x4RTMxaVNQc2lGcWR3aDZHM0N0bGtDcEFOSFBwT1JK?=
 =?utf-8?B?cmJLcGFweTlqR3F1YXl1eW0vV0ZTbHEyUzN4T0VJeEdka2laQ2RtNmZ3Z0ti?=
 =?utf-8?B?QzhodnNvVEprUU1FRktlSWhVU0J1NXp2M3ZNVGRXUmNEeVUvbnBxUGxUaHc0?=
 =?utf-8?B?blFNTm1ubVJzM1NWTjByZWZ2Rm1mRGU5SzAxeHlhekVUdkV5QXhobHNrNmdG?=
 =?utf-8?B?MG1BQ2pWMG9HQ2dlamRqb2tEaWJKeDNEUi9FNkNQYWN3cStpVk9La3hRU1NQ?=
 =?utf-8?B?NStUUXI0SldWYjdaeXloVGo5amk2YnpNN1MzY1V4bElQZDJhbFZzNC9xU2tF?=
 =?utf-8?B?S0xsMzNBc25ad1AwSDlsMldXL3lzSFI2UVl6UG5kS3cxS1NYeXRNZkRIV0FM?=
 =?utf-8?B?VCs2dlRKTnh0MVRDY28rcXNVTzNQc0RaMWJUTkFKNTQrNWtFVzN6QzUwY2dE?=
 =?utf-8?B?TGFhZEhxV05jM2dsZndiRDh4blFaM25jbzhsMXBwbGtaY2ROTDl5ZC92cWJ4?=
 =?utf-8?B?TkhOc1JnUmNMU2ZNZXhsb3N0cnN2MVBXbGd4WmdwRnVaVGZjc1lHTERnTEdI?=
 =?utf-8?B?TGFyTzRpRGUwL0piOWY2dTVtalRiTVdXUURBeTRPdkVKRnBrTlloSi9VZU1W?=
 =?utf-8?B?aXFvcXJkRSt1NTFpKzVvVTQ0amF2WnpFNEhvOGtnMCt1V25QaWFxUm5HNUo2?=
 =?utf-8?B?R1ZCZzdaU3JlajFHUjAzajNwdzZtOWVMRkdNM1Z4SERxemlZM2tZQ0dva09T?=
 =?utf-8?B?aXQwTWF4TFVReGdiQ1JtbTJBNk10dFYvNkR5WURJZFdHRDVDcjAxcVVVOEhn?=
 =?utf-8?B?N1ZKblk4Z2NqQWNmNUN4eUZ1dmh1MXBYc01nNGR3Z2pEQWpJaitCeWxCWHhp?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec54dce-db3e-4f7d-a3aa-08dcf1c737c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:55:11.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP4G2ybLQCW4rB7H69ga9zfhdTI/STylEszqB/fVIPSjNLPGlx1Zhzcocf6jlF9DC/MbvQdj5XJa+avOEHYSog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8098

On 16.10.24 20:34, Zheng Zhang wrote:
> Hi all!
> 
> This patches is base on 6.6.y-dovetail-rebase aiming to port
> dovetail to Loongarch. Most of architecture related code has
> already been ported, except ipi part, which I will add in
> the later patches. This patch is tested under qemu-9.1.0 with
> irq torture test in single core.
> 
> If the community is interested in porting Dovetail to 
> LoongArch, I am very willing to continue improving the current
> work and maintaining it in the future :^)
> 
> 
> Zheng Zhang (6):
>   dovetail: Add dovetail and irq_pipeline option to Loongarch's Kconfig
>   dovetail: Port Architecture bits related code to Loongarch
>   dovetail: Adapt Loongarch's clocksource
>   dovetail: Add place holders for smp/ipi related functions
>   dovetail: Disable irq in mm and fpu's critical area
>   dovetail: Add more irq-chip support
> 
>  arch/loongarch/Kconfig                    |   3 +
>  arch/loongarch/include/asm/dovetail.h     |  44 +++++++
>  arch/loongarch/include/asm/irq.h          |   2 +
>  arch/loongarch/include/asm/irq_pipeline.h | 145 ++++++++++++++++++++++
>  arch/loongarch/include/asm/irqflags.h     |  28 +++--
>  arch/loongarch/include/asm/mmu_context.h  |  31 ++++-
>  arch/loongarch/include/asm/ptrace.h       |   3 +-
>  arch/loongarch/include/asm/syscall.h      |   6 +
>  arch/loongarch/include/asm/thread_info.h  |  17 +++
>  arch/loongarch/kernel/Makefile            |   2 +
>  arch/loongarch/kernel/alternative.c       |   4 +-
>  arch/loongarch/kernel/asm-offsets.c       |   1 +
>  arch/loongarch/kernel/idle.c              |   2 +
>  arch/loongarch/kernel/irq.c               |  23 ++++
>  arch/loongarch/kernel/irq_pipeline.c      |  34 +++++
>  arch/loongarch/kernel/perf_event.c        |   8 +-
>  arch/loongarch/kernel/smp.c               |  28 ++++-
>  arch/loongarch/kernel/time.c              |  10 +-
>  arch/loongarch/kernel/traps.c             |  52 ++++++--
>  arch/loongarch/mm/fault.c                 |   4 +-
>  arch/loongarch/mm/tlb.c                   |  17 +--
>  drivers/irqchip/irq-loongarch-cpu.c       |   1 +
>  drivers/irqchip/irq-loongson-pch-lpc.c    |   2 +-
>  23 files changed, 412 insertions(+), 55 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/dovetail.h
>  create mode 100644 arch/loongarch/include/asm/irq_pipeline.h
>  create mode 100644 arch/loongarch/kernel/irq_pipeline.c
> 

Thanks a lot for this contribution! I leave the detailed review to
others ;). Is your plan to build EVL support on top?

We will eventually have to look at the testability of this, just like we
will have for RISC-V. QEMU is a convenient starting point, but
eventually there will be a need for real hardware as well, then also for
building test images and finally running them on real HW as part of
regular development jobs. But one after the other.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
