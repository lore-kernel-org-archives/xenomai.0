Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695932C181
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310115; cv=fail; b=rx8kMh3RUaBxzfbvPVtQNKNjlsJzLmpFIsOP//jWofc5Ul1L33u9dg6C427ipS5FZbG+aHkYp/3m6WSUArNXGVHZq3JjW4SyaJ6c0cpUAOkykX9BkhNbzsRCU92imr4CgSl806LYjRH8Nse0wh8M6eHP6osdoCV1LZNp70euXaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310115; c=relaxed/simple;
	bh=COMV7/+S4psGJ86rsJOipeuMsTpW8123wmzpCKEvXOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+y8OLWdVbrZsRkXB00ONy2m1TCeOXesPalj05Fhu6NU/DP2mcj/LNabiOgc63kdpcsq6QS0kBmJCD6Anjff1nRRWz/08sW21k5/m3owjOuLWBEmytwCqeofetPTpNFJ219NWvOdS5mz2w0kjmP3Pmm5LVAb1H0q1EOI0FwlOYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rs9rJE3S; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rs9rJE3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of1/zzfgJbRZ4xqG0mYzwN9EGOIfDD5u7Gf8qix58nT9xaN5aYWgPcG09BRlZKySoGIhBEN5F/HKw/yZyZ+sZ4PHseOOUtvd4Dlgltx0FLH5wkXo+H0uzvszr3ZfhbkdEDBS2PLMP9es106FRE08zNVstJZHP/Y28hOgls8PEyvPBhUT59vkr9fySQF7lbaxJkOBZlNYDQ2aBnipsdLFewfAQB1jaLMpLYE9xel4hLKTYFTMLuCjTnwUwHkxzZfiD3/1Fp3bRjGWU+uWiRyioXnTsUErrLuBX1GvW0oYeZyPiUB4C04F+3URfuYlUKzoZEdMoYEX1Xh5cl/ex4BnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHjodPf/IQUP9rwQQYS8IkujYw1i0wItyrceHFkAhnU=;
 b=BngzQFgqLuDzZebPtqFjqZyUsXuVsFuAQ9brqSV8FS4ObQ3pXFiEyNsF6dN/JHrne1OLYskzmQvtgzvJI6hcOxXLDNPfg+Fy3YPRrkbLKX+ViS2ZIGw3U1sBgB83IUOJqB8gc+FI0Ay8dRKk97UTj2Mxyu7SQCmaLUpnT8SAlF7Fq3qC2nyZS1cdCRUy4WzocpyJrlSAy6bmyrO/0hPLlA1oqOkg7CM7KiQC0mWiSpSLJj8Df3lBfI6/XeZskcRCtbzhEugXPxKmFbESgUyr/yK1XuB6/kCfO5Zt3NXcPB68n7/lZ+QR2X5t9OpB0Miw2PCGWAu3ueqzZjVLyLkPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHjodPf/IQUP9rwQQYS8IkujYw1i0wItyrceHFkAhnU=;
 b=rs9rJE3Sg1WSy9sINohiHsILSoEG4Nt9LzP3haTnPMSkDd5l/Me5nPZXAqznJPtROWVz/UpNBsRnszbNgndMocleSggNgn7QpOwTg/i9sPEw7uhlJkomIT9t2V1rdzaFIQ0OO+8fWDFw7cpTYoHl1cr2SaUh+Hu8k0peobRLz2/rxh1D8GLOQ3kXOLqycnQ7tYmu16pq/X3b+MSrRB1j2y94UzBXeCNfz08RproWwfVh8HByaGxdhpi/VfJTL/FFQS90ljEUxy3WJCOmd6s5K8tLEodrVHftyWUf6m11lTLXPnp2hvgNwWzzViJUauTVHBKgG/MCYQtNAvL5JWaYhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 16:48:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:48:28 +0000
Message-ID: <6c5e26c8-c3b7-4359-a7e6-82382431f1c1@siemens.com>
Date: Tue, 21 May 2024 18:48:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] testsuite/gpiobench: Synchronize index of loopback
 mode and react mode
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
 <20240416085911.62073-4-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240416085911.62073-4-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8adbe3-0ac9-4acb-98a2-08dc79b5d73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWRwV1RJTCt2OEptMmxmdVQvWkF5N1BoekU3ZzBqWVdwWnREeVg4N0h6aU11?=
 =?utf-8?B?dVZUeUVqVXFTUnNSMTJkRzhWaFVqOXFaRjBqaXBLYkRFVnFCNWMzUHFaUUR3?=
 =?utf-8?B?dGNpcEtVdGZvNXJSWUFaRWVlRkFmOEpOT1BFMUZJWXNoenNKUVQwTGNrMWg3?=
 =?utf-8?B?NmNoRGIyWUNGSjcxN1hZVWpLUjhYR3h1bmx1NEtIVXF5RkQ0ZUk0N1pBcTZy?=
 =?utf-8?B?c3pUeVFFVCtTS2hWWlNKSHpFQjRoUFVwUGFvSTliWjk4bDVSYWVGL1ZSQWlu?=
 =?utf-8?B?cVh2YVN5Nnp6anVaM1g5ME1NZ05McXArVEMwTlpoV1NqLzY5UXpPWHNEblAv?=
 =?utf-8?B?dCtZUGdnNDJ2dTdjQjNsSVFzdVV3N3hYUEFKeW84V2FEOVFYYXJJUSs2NHFC?=
 =?utf-8?B?Ym5QMVFOZHhGK0hnOFllNWRvanI2TElreVhuNkFaNUc0cEFsK295TG9LVTNV?=
 =?utf-8?B?eXdLS0x6cXo0eWdCa052Z3I3WGFTR1paaFNMblpSRTVWbUV6aEFoTzZockkx?=
 =?utf-8?B?eExsTVVROUYrWXhaWXd0cXU3N2JaSExHS3E2MVFNbGhmMWZFcFpGYjN5ZnVt?=
 =?utf-8?B?RjZnMTdFRHltUmxsYnBGNzRtYXhiZXZJOUV6eVpaY29jTEZYZDVZek5uK3VE?=
 =?utf-8?B?R1pSTm5oakh1NStBTHVXYkhJRmVKa3EwY0hPNVdvTEQwRjYvYUpBd1lEYlVG?=
 =?utf-8?B?QjBRSkRDVmNZOGhkWFc1VkwzTVg5NmR0TGpKTXUwR3p3a1R6RDdxK1FNbUMr?=
 =?utf-8?B?Wk4yYzVpUHJVdGVGQ3hqMitGYzdWVmhMdmpSRGU5MUZoN1MvdXVIckQreTNp?=
 =?utf-8?B?OEFETGZiWDl0ZkE3MnMrMWg5NWdON0kwd0J2bHVZemRLVTU2b1d3bFpWdWRS?=
 =?utf-8?B?d1BDYmJ6QUtBcWtKSlpyTGhGQjI5OE1OK1o0dDFYamdaL2FBa1d5UkFnOFZi?=
 =?utf-8?B?Y1pmUEFQTUdRSnJrK3dmVFN6YTh3Yzc5aEF2cisyUTI2RkcxbWFJWkJiZVRY?=
 =?utf-8?B?SDVPZXhtN3ZpN3owc1dxZ0l5M0wxa25YSnRGQ2lqUW5ZaE9WNFRYS1lOZGhv?=
 =?utf-8?B?Q3JZeWM2RkQ5YWV4eEx6aDBPSWxPT1VpNE9YTitGQWl4RlczemFCeUtlZGRn?=
 =?utf-8?B?M3FxcUU3dFRHRGszRG1yVXRHTGN5RHdmaG11akdtVWNhNXY0SWxIOE1LRkw5?=
 =?utf-8?B?OXJlVUdPSG5tLzYrczVJM2MyTnZveW4vOElOVTNvUVI0TmNvOSt5Vyt5QzhH?=
 =?utf-8?B?RHlJbWlXblA4OHZHMHkwUExqVk9xSit0a1BLZmpPWXBYdE5naDlsYnE2RlF0?=
 =?utf-8?B?aFYyTndyWWpHV2FaRjR6R3JnMXJSOUNXdUJXUW4vcHlSQk9RLzg3YTJBMHFt?=
 =?utf-8?B?eHZ5S015alhqZWJkdDVXdjVwT2tuZTdHTXR4MEdWVVVlcjBGcThlTk1KOU92?=
 =?utf-8?B?eXU3OUNUVnZPRkNLalRvMDdKNTc2U05kU0FLZnk2bnpOVjNPcU05WDlJT2tm?=
 =?utf-8?B?aEd6N0lOQWJjcU9kSVZOQzU2N0FEbmNvQ3QxWHdlN1o4c2xpMXFNLzJ2RDNn?=
 =?utf-8?B?NTZFSC8vQjlmU2pjVEpGOURUUXhKZDlwL2Y0NDhYQkVoYUkwNUI5UFZjUkxS?=
 =?utf-8?B?cEQwSGZzZ1A0MUhFc3RaZ0lQRVR6Y3FxSEpKWXFKRXV1VWVKZnlsNFcwZ2xr?=
 =?utf-8?B?dEIzNWROeXRCOUNBUWFkUHIzQkRZTk9QVEdDWkxuRjUwZDl4cmRDTldBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VS9xWVkxRjdiRW9EdmltdEY4eUlJK002K0VEWVZtQkJoV0VZR3AwdUliYk0w?=
 =?utf-8?B?SGRCcFRsR0FqeitDcm1NbjVKM0doK2o0NDFpeWJ4aEZzTWZ1TkRhakRoKzlK?=
 =?utf-8?B?RmllV1pqTnloeXhMWWtocUhuNkhyRUE3US94NXltQkJvWUZjWEFwdGE1QWJG?=
 =?utf-8?B?RVc4dWpsRkd2eW56WUlhZGYxWTlsUXorMzZmVEQyYlpMSlVDbmNPYXRtRkht?=
 =?utf-8?B?anl1MXFmTzQ4R3BCb3lvMG5XRDJGdUFZZ3hxYVZmODRtcVpXeCtLOXNNUnhw?=
 =?utf-8?B?YWZ2d1dCWkN2cXpML2JTaVNmR1ZYRDc2MU5ad3ozL1NtVHFvM3plNmdjSEp5?=
 =?utf-8?B?dWk5VGxLTldkUGFJWW4rdlVrUnB4bDlnb2k3TmFiYjFNdFVSejlDVTVycGZo?=
 =?utf-8?B?QU5wQWZKZ0luczVQR3BXYmRUSnZoaWY5L3F6cWluR0dLTFdXVmZ5Qi8xSE1S?=
 =?utf-8?B?bGplUXo4Q1psTU83ejIxbUtWaDRTWW9CN1BOWk05cGtOWkx2S1pLY3VwZDNm?=
 =?utf-8?B?V0VqRlA1dXB2YzFqV3RCV0RjNEgweHFxVTVxSThvaXdaUWdYL0lvVUY3QWhv?=
 =?utf-8?B?NUVOUm90UldJeGd2YWkyNDFDd2lxYnI4SHJqOTVhMjU5TkdLdlZKcnhFQS9B?=
 =?utf-8?B?YUlrYzhYdVlucEcwNFhSa05lRVYvRWpKQlhTbHQ4Mk5lRUluZGtXM2dHbXJh?=
 =?utf-8?B?MDh0ZHJBUFQzSHFHbms1elczeDROT0pSNjJhTm9Oc1FGK3ZrMS9mOFJlZlRH?=
 =?utf-8?B?alFOekZKR3RlQ1JiMUN0QnZIVFpRb2RZTVBHMjNNaTVvS0FKTURWMXpGQ3JM?=
 =?utf-8?B?KzRlaFc0V0l2ak9iSWxjbjhPZHROaHZvWHNMSHhtV3N2VWVOR0F4dC8zZDVT?=
 =?utf-8?B?ZW9oWC9PR2xjbWdyTmhYbTBBV1I0Y2xkVDVaOWU4K0hIMUhzVy92RmRjQmpn?=
 =?utf-8?B?aHZVdEN5YnpCdWV5ZkYxYlpkR2pXUVBzcFRaNnR0YmgxOE9MMERhZmhkZ3dD?=
 =?utf-8?B?KzlhbjRza1hZSUdGVkVKRnJiOGo0MW5BZDBiTk0vYVlWY2Faa3lhd2ZBMDhh?=
 =?utf-8?B?eHZtcnVSSWlaZWhWNjd4Q2ZIMTh5RklVNFh5M2ZCNTd4dEhNMGE3cDlqRmpK?=
 =?utf-8?B?bXRwUDFudTk5cnR2YVI4dlBkTXIrNzVhZXZscTRmZUJ1bHZYWDg1OFNRdlpE?=
 =?utf-8?B?d3RmdEJSRUxDMnNreVphenFxWWk4N24rR0tQNnZicGoyNnJXN1BiNFEvSFZw?=
 =?utf-8?B?azdYeUVycVo4Ylhkd0JISGpVMWtEOGZzL3JEZWhRMHdpbXhtL3dnUG9jVGI1?=
 =?utf-8?B?dXdYbG5KeHo0eFQ2bTVhRzdLVU1wbW5nWjBKTktCOTV2K04xSXNSMEVYVVFK?=
 =?utf-8?B?TEZ4Vm03YmhiTFpYU085ZkJ5MFB4bEJUR2xxK0RxaDRzZSs1NWdDN3ZnVzhL?=
 =?utf-8?B?UkdxaVRSRVl1NVhJZU91a241aC9GQmRlTWh4ZlczUStXS1NLQnJYeENaaVhy?=
 =?utf-8?B?a3lZZnY1M01nam1SejV1NzdoQUhmWC9zR3pQYXBkQXFjWEVHYnZEQjBlMldq?=
 =?utf-8?B?NUd1Zm94NE1kK1dvaStLMFFjZWVLdm16czJtZER2Y1dIOE53R2d1aWF5cUZE?=
 =?utf-8?B?WjJ0aStqaittVFhoU0MvZzA4bURVbGsrR3cyTUdlYXNDMVhIcWNLWDlCNTZi?=
 =?utf-8?B?R2g4dHIybXNOYWhnU3F6V1Fnc2daUkdUY2MvNGZyY3AvaFJ1c21uc0tTeFpX?=
 =?utf-8?B?dXZCdHlFSWJtdXFqQi90SkdRNXE3TTNtOVFHZ084RVBmYk9DTTBaZ1BHQWQw?=
 =?utf-8?B?cjAzaGI2ZlcwdXA4MEpwd0s5d2VoSkRkREJFWjBjeHFDbDhPdHlZR0hNTmc5?=
 =?utf-8?B?Q2ZmMytJMXcwcUQzdmFSaFRkUHlEMjJXY2J1aGxNVG0vUWl0OGgvNEN1UDUv?=
 =?utf-8?B?UEliQVZqeVNFSDVTaU1PT3BKVk84MDRzTVNWRElYVktISjNGY01FdEFGYXdV?=
 =?utf-8?B?c3BmQmI4a2JCd01seFo1V05ZcDdKbDRYVWovbGJyMHhFdFRaT2ppdnREK21M?=
 =?utf-8?B?WEY4S3ZBNU5uUS82aG0zTnREQ1o3TVhqajJZUWg5ZzliK3ljM0VRejI3b0Rl?=
 =?utf-8?Q?0hBtmKW66pnAigAsmCzgGfKME?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8adbe3-0ac9-4acb-98a2-08dc79b5d73b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:48:28.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8IGRv21KpqhmaCYxN+EoobbWyMehRpCkF9wldrETh3O7CFfhtQlnCuOFEhb5aK5UoXdGxmT+0x9ajN7cC1xSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6978

On 16.04.24 10:59, Clara Kowalsky wrote:
> While the index of the react device is incremented on every round (read,
> write, increment), the index of the loopback is only increased on every
> 2nd round (write, read, sleep, repeat last steps, increment). This
> results in the unintuitive behavior that half the number of loops would
> have to be passed as a parameter for the loopback device in order for
> both devices to stop at the same time.
> 
> To simplify this, the index of the loopback device is increased for each
> loop. The calculation of the average latency is adjusted.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  testsuite/gpiobench/gpiobench.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
> index 707f35ae9..1c525269e 100644
> --- a/testsuite/gpiobench/gpiobench.c
> +++ b/testsuite/gpiobench/gpiobench.c
> @@ -374,6 +374,7 @@ static void *run_gpiobench_loop(void *cookie)
>  		/*take a break, nanosleep here will not jeopardize the latency*/
>  		thread_msleep(10);
>  
> +		ti.total_cycles = i += 1;

I dislike such assignments with side effects, and this may even be
misinterpreted as "total_cycles = i + 1".

>  		ret = rw_gpio(GPIO_LOW, i);
>  		/* send a low level pulse from gpio output pin and
>  		 * receive an interrupt from the other gpio pin,
> @@ -392,8 +393,8 @@ static void *run_gpiobench_loop(void *cookie)
>  		thread_msleep(10);
>  	}
>  
> -	ti.ts.inner_avg /= (ti.total_cycles * 2);
> -	ti.ts.outer_avg /= (ti.total_cycles * 2);
> +	ti.ts.inner_avg /= ti.total_cycles;
> +	ti.ts.outer_avg /= ti.total_cycles;
>  
>  	return NULL;
>  }
> @@ -506,8 +507,8 @@ static void print_hist(void)
>  		printf("\nTest is interrupted and exit exceptionally\n");
>  		printf("Please run again till it exit normally\n");
>  
> -		ti.ts.inner_avg /= (ti.total_cycles * 2);
> -		ti.ts.outer_avg /= (ti.total_cycles * 2);
> +		ti.ts.inner_avg /= ti.total_cycles;
> +		ti.ts.outer_avg /= ti.total_cycles;
>  
>  	}
>  	printf("\n");

Jan

-- 
Siemens AG, Technology
Linux Expert Center

