Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E72D3725
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681035; cv=fail; b=Rqpo4wAkO0x9lwqw6GvxNSfDA7Bmz6++7h0Z1L4FPP9KbbplrydQmFsYV0wQP4HMtmBnKKaQztbn7CIUkC/ywqJUgbneYM9bE8mzRtDAqHZ3QVUz7yOMtr59KRObfaS/WOYBGfoGQBTgaGlmGHXVCHPT4Lmumamum0TeWVlSj3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681035; c=relaxed/simple;
	bh=kDpzzOHic5ZOINbIoWu2Z/NGAOrbgOilXqih92sxw7Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h+8JpPtxVVD5fzgFCsvQLQC/L2N3GHUFQrtYFYQyALIQmgNjppsKl+6TJY2jqTlIqEpTzDgwdQfgc7jQt5IRV+mMHtWGjal7pFpXkWOKP2QzyHrOdgYmv2P5F+rzGfTFqQdJg+H+T8ubdmybS06mN4R5uDx+FwCToHwwFNaJ0dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ewG5LN3g; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ewG5LN3g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORw7/2otKNY1n9oB2DDBYjcUcjafMkU86urMTYzt0MFLRFcGUPcGk0fMl/koTE3Lj+UOQKBADlf0yEEPevNE9QbXrTGa2N2cAc2/f6/eWfG5D/A0xfVfsVb/Pgzl/IkNkRRt3S0msgjy/wzwIj+mZvd5qyZR5lZr803/gV2CrDF2IkcLB1EDaO12gKlPfA0oodjN3ml32g/aJ/7DaOHieqogO65sXtNSickS9QL6a6aD0cJIu5mgf+PjvvQd46KphwIEf05YH6yWRX+/IAgCPgFADdhLrP4IcYsZT1+iogUOo81kEF19QCemp3GttNGJVSIFfib7GvfTbcm9EwuxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kAMsO0QRARvYIphgZa7+AET7Y2KzLOYr3bJtN3Lm9I=;
 b=n6KLmzmNRapY26b9eHvsCFMBMca+2OY7DrJn9s4ybktxB27ok0ZzEx5Nx44XopTMmS/DQsm+m1MYYvSkogWaZc935qzD5LVZ0S/rtmDq+9L7UM1pFmKciCsetu/leVZmzHhepibpC+OaaIk4t0SEgZ+WgWK+Lzxu31t8Iw95zjAvH8rTEbBZNOT39VYyxjnY7CXcmnOwwJ5UsLJa6PRMgNUaCLRrfmrx7bEeGi+Z3BaVOFILAjs6m0zve3Cj0+cod16JlCUCDlj57wZZC3D2hFspe6pJy1n8EKJbqDsmb84fW3MxBPBOmClTAnbCicksn6M9IS+zskw5Ey217A1r4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kAMsO0QRARvYIphgZa7+AET7Y2KzLOYr3bJtN3Lm9I=;
 b=ewG5LN3gf0m7TtHXHY4xNLz3j2R4URHQKliOP4ChZJzOCD+iGVFJgNzfT+cHzQ0+wzyz4Z1j0h5kTKhnhBaeSWXLO9nRph7vIPI4rRupdVVrjhBbZsgabfyfMipefTtiUjjx3c5oqIRma2mphVeORXTwX92++payKOpL/0UVPVpAtlWBX0MWiAIP9yL95fEN3cea6PQjRdnmv634RnK/QmqbuJkiHPa2JebKlf4NgEitwwz8m2mHp0C2xK032JVAUd4qyf98jNrlbr0NQzZqxxWe0p8LKwUtmFauPQWx4uCSyg18mV1MvWrzYWDKxeYGKi0qgqH+M/0Uffy/FLqXPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 14:03:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 14:03:50 +0000
Message-ID: <cd4d6255-405e-4ada-b7d3-bfe56b286e7d@siemens.com>
Date: Wed, 13 May 2026 16:03:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] clang-format: Squash empty loops into a single line
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
 <20260513-wip-flo-gcc-16-v1-5-120ae1287401@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260513-wip-flo-gcc-16-v1-5-120ae1287401@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:610:e6::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ccc026-2de4-4260-db8b-08deb0f87570
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|55112099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	HprgeqoKb2Vgpi+VsYk3bvE6KanIHv0LoZ6Q4UF71+nq6SwHeLjqowuDJiPY2ItgQTRptmU7BfE06miwPglzYovjDf1+xmxaxw/51bSZV/NuSbLRp+jeN88/Ll/s3Y+Aq5oi9u42u0DGEDy05gdLPVSv5RlpqqmwzMCHxgOhGbwtlIjPZr3MLHyaExgOw9MHDFHOcDQ9uhbX+3tE2B/z1oNfSpFHsVfFe75WUgE55MkMa59nh2RvxxSI3+STj2sLDiidYTFiIOA2rM1eXUBV2EIKdPA6geUoFeth2iCDv2AQeJmsKHotrx6Rrr4UQ6BJrC+XE0vW1I1F3t74yPySSkc969UrC5jpjAg9xu+hJtWBeWXmE0CU6WoL/bGCgu+r6xeAL4cdt8szwBPVuJ2sgoWLi4D4phiI+AnXhf5QbXLzbX81xNwvVAhVt+git0y8KjTey+tX9fUNqJD8YwwmwZkRLqnLlyMa+TBwP1zg8ZUjgCxcHqE8Q6jzeAVDjIblRUWxjx0nVbhVWqsiHv54T7M+Qb4P+15JyHxmJ1EpdvQO+megHQSASgAyDIuLPcVE2WpHcwvNb7b9LTLGM5Q9Lqw+mpK7eHq5QCepge3G+1nVw5qOp+VLxZ3gA3138sKmp6NUUf+ymSTLRzzTapUF0fVd2pCHw8Mdqap2DXNl9uwq8uP8fC4UGSLG6os+I9+i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXRRWSt4ZlExaUhtakkyVlRVYURKdlBDS20rM1Eyb3A3UkE4SmtoSmlod0VU?=
 =?utf-8?B?RFhnVnk5bjA1WXdMZU11K0h2bkovZjVSbGNCTjViTjFFQXNpSk9pWUtrRzdy?=
 =?utf-8?B?eklIK0NoLzR3ZkNqK2NHOHNGZlNibkJHWHJkV0Fqb0NDWjRSdy9UaFJYOE9O?=
 =?utf-8?B?ZldZTlNJbkxBK0ZGOXdhbnVoYm16VXVNQVo2Uys4V3p2VW9sVDZiYVl2eGtW?=
 =?utf-8?B?QlZFdEkyQzFicm52SFZuNFVOclFrcWgvTVhsY1VzcnMvQzU2eU5EYnFOblAv?=
 =?utf-8?B?Qldjd2wvZWJLMGdxYlBGc0FyZ2owSXBpQUtlTG9jTUJPTHp3WFZNTng3OEd0?=
 =?utf-8?B?N0lieGlJbmNwaTV0VHBXdGcyNyt0bm1zMWVyQmFGNk5SZW0yajNuYXBSZ0J1?=
 =?utf-8?B?bWEwdlUwYVNscFBjUXVPcWdhVnhkSGNJTUpkVjFxcHE1Y0JBaWYzREZsYmoz?=
 =?utf-8?B?SVJkYWQ4TEY3V1M0NzdUUUZ0enVOQ0VrMWdaTS9naHpxZ3lTdkVwbGJkQUkr?=
 =?utf-8?B?SjdGWThiV2lpazVMMlBrVnNOTzFwd0F0dFEyTEZscHlPQ0M1cGZERjRsWEpq?=
 =?utf-8?B?NmEwU2RHSDZzaUp6dlZBc1QyUFFsSmdUallSd0tFVU5CYmkvV2cxc3IyWHR3?=
 =?utf-8?B?SEhWY3lpUTkxTlduUGx5bkVnUk1HYTJ5ZXJqZWluSWVsUUwzSy9iQW9LOURh?=
 =?utf-8?B?QklEYkhMbVBrNTNTQmNmMFN4VVNNTFJIeGxVSHVHY05jMy9YNUdUYzl2L0JX?=
 =?utf-8?B?blA5VmVMVmQrc0hZMno0VHNUQzlsM296YlpLYWlqVWxhM3Bua08wZjQ0NnZo?=
 =?utf-8?B?NTN3TVVQKzRqTVE3NjNreTQwNWdZWmRiUWtlb0ZjVEJIbG85cjlPOXBHVWRC?=
 =?utf-8?B?dzdZZFJqeDl2bmpFeGpmLzFWWnNvSCtReGIzR1dyUVpkbnFrd0wwMlNGQmV0?=
 =?utf-8?B?bTRoeFY0RXU4N2FNTVZvbjBoZGpSdHRLaFcrV0FRWlNxbHZmQVhqaXhHT0Z0?=
 =?utf-8?B?UW94bmZ2RmJVc0RuemRmcWdRSktCL29GNy9JdHp2QjNCaDdqQVNKRWo2eEY1?=
 =?utf-8?B?cnplVGMyK0kyTnkxU1JvbmZDYzFKNUlqVFg4b2tEWVYyYS9DNFRDUWRNT1VP?=
 =?utf-8?B?T3FXSDdHbE1rOGdidFBLMG8vSXNYaXMwWndLSWdlSnpsbHQvZ0duQVU4UllG?=
 =?utf-8?B?VjhlcFBDbnVabTAxMGdzOHB2RVYvcm9NTHBsY3dtRzRVZGF6L25lK2Z5SjI4?=
 =?utf-8?B?RDgzNndiakYvM1ZJVDRFUmpSNGdOVXNQWnk4VThMM3E0TjNLb0pmaTRaQy82?=
 =?utf-8?B?UEVSNjB6bXJndnNZRlJoazhiUUZ0aGJiaXluMXhOSzNpdzdTVy9MZGZRZGVF?=
 =?utf-8?B?YjVmc3dhYkJScm5FU3pKM2I5NEQ1bUZGWHZBL1VqWVEvRlQvU3hTZ0tWMlZq?=
 =?utf-8?B?UEsrQTBZZys2bnB5Sm14SDNJZVdnbExSMUxVSFU2eDVsUldqYm1LYnBQd214?=
 =?utf-8?B?eWFYNVRGb1JWMS92MkY5VWNKRHVUZklnREY2MHFMSkRRTWhsK0xtZXM5TWU3?=
 =?utf-8?B?cDIwQVUwUndjMkg1UWFQdldwMndSWkZzUjdSaVB3VlBmTXV4NnEwVUtHendz?=
 =?utf-8?B?cFljNDFNek1aeGVUQzBDLzBoNFQ3dkJIQnFVQmhWT3pXcHJ2SUZmUzcyWFB6?=
 =?utf-8?B?c2FjYkdhTFJIK1FTMUlzbDhnODlValEwNHpFQ2xuN1Y4a0JQaDVQaGE1ZWJS?=
 =?utf-8?B?clRiQnFaV2hHano3QTVHYjB4eTZYbDZNNUx1S3daRWlpT2Jxb01ONnY1Z2ZS?=
 =?utf-8?B?NTlQdjIyUVpuS056VFh2WTZDU2lGWVpuQ09oVU1IQ3UxTGQ5ZXNpUGgwVlNR?=
 =?utf-8?B?d2xxTnkxMEQ5VDgvdnl6KzdscCtrQ0JhZDJaMlVEakJwRGljQkw1OXRZWHNZ?=
 =?utf-8?B?MkY2czBtdlBweTlKSmpYeEdXYXFsOHIxZHo5ZG5zK2p2RVNiYTBlcU5qNy81?=
 =?utf-8?B?NldBbjh2NWtaUnRYeFBodXFzQUZKWldzdUxPNjhKcm4vTzRiZGVNV1gwR1dr?=
 =?utf-8?B?am9tUzVSd0gvcXQ3d2ZyUGh5aHhlbG1vUnRQdGxVYXpETi80a3VNZ3RYNEYr?=
 =?utf-8?B?THR0clpKQy9aN3JOcUJXWThpTVNERTNwbTVERFlEV0RYc0hYOTdOQ2Jna2VB?=
 =?utf-8?B?SkxxYWlobDdqVkRTa3lucHdvWSthalFOVzRIUHFOWDZGSFdvRU1pekdxVnVT?=
 =?utf-8?B?dGwyakhMUU1RRnFFMC83SFZ2Qm9welhGZ0gzeVIvQmNqR21Fc3N1dEExVi94?=
 =?utf-8?B?S0ZVSldTenYyeFRuT2xMRCtZc0VCV0VtckRmdCtxYzhtYTc0RHV5dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ccc026-2de4-4260-db8b-08deb0f87570
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:03:50.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktYThKBR8tT8dG51zPhntP7n/Ud1fA9lRUPE0RKHLXnZvX1wZ263G20WuHE2jJ8k175NWr2xUfe0kWgZBIVTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9482

On 13.05.26 14:50, Florian Bezdeka wrote:
>         while (cond) {    vs   while (cond) {}
>         }
> 
> The alternative
> 
>         while (cond)
>                 continue;
> 
> triggered a warning inside the analyzer:
> Redundant control flow jump statement.
> 

This should be obsolete when patch 3 and 4 are reworked, no?

Jan

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  .clang-format | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.clang-format b/.clang-format
> index 2ffd69afc1a8280654a8763e044e27e08be7a69f..2792bc6a0b6f8d6eba81e2dbf7d0c6ba745707ca 100755
> --- a/.clang-format
> +++ b/.clang-format
> @@ -17,7 +17,7 @@ AlignConsecutiveDeclarations: false
>  AlignOperands: true
>  AlignTrailingComments: false
>  AllowAllParametersOfDeclarationOnNextLine: false
> -AllowShortBlocksOnASingleLine: false
> +AllowShortBlocksOnASingleLine: Empty
>  AllowShortCaseLabelsOnASingleLine: false
>  AllowShortFunctionsOnASingleLine: None
>  AllowShortIfStatementsOnASingleLine: false
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
