Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502832;
	b=tmq+SHlHS7ztpG6Ikd1EwUC2AiiFNAfv9HIh5YXtSE0QjAHbup5EnBXtFNAOYB/+RD2c
	 zcJGiWIO+UTjw/nk/sHmXVwIYu5q069AXrUlpfHoS6Qe1zNuzSUqxAVtppVpPnNeUpKuO
	 rcKkyXGQYvHdym5nvcKjRtcLrczs+w5e2PZnA3+XUnU/el6YJPq938lvwmHwyoeQ7Q92r
	 ZJFct1BGZIQ/6tXa4DJ2Ed+on2kiysvmg7EIEsZmD+ppmJF9EBbdcJOFBeABtNwEMu6dP
	 fHIaE60w6s7fL29cpi0Bj3bZLnsSDlMbn2v6XZHj83+ybK2fgXGqibd3dhnjpeJ+8Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502832;
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
	bh=uKhSrLSpOtq/k6rQYupyJW1XhBQLXb0/TAKv9UFJlM4=;
	b=ERtRzsXS8JjfbzLyQHcfhXg86y4IWlYgPMlf5vJ5d1Q0Nl6RNB7c6B0mHmK5shOW6okx
	 DrF+laSl6hi6WR3hfvsWIS5Mbq4WxNU8L8ODM/s9/lRe6NFu562hio3hadYJRc2FWcAlb
	 8mFaMn1WPi7JBPFX+3EV02mo5PZntISwUfzsqeTHaV1rZD86RII2L3Ukcvf37xt+scoVo
	 ZSREvKxWJ8juSbhKJy3SWV2bmpxPZG6Sv0pJLITEGkkm+G0Q4JjeWB4PauwcMo2Qrxsg0
	 b4jGFworE3Qx61X0RrLOf5doIuLmY6/DWWPPKK9cgbor5u5RZcy0Ma2IiRmf5LUdx6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=mvtIMthU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.55
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F9606A337
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 17:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 602F9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=mvtIMthU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcatIBR4N3kHJhG2EGyx0LlI3XHOCHtuh1HNQ7tm5wyjRDEk421zfmRDQEJnzSIfTEqGyMBI+OClGSZziKTDEJq+XJbcvwL/ivasOc/Q/keH6upzIpQrusk1mZtTS5EVvAYZtOX4vY7pHj+H6RRQIGjzuJs+1ZNqC/ync3z5E+pWYv6+3DFeA5GiVMm2/TmkgDkUdN3fPfJlasVY2dvgdYv/VrsTJE1VUrwsyvG8tu0d5sdzK6oJ/unNmCBMYDuI2nsLYAV2s3P5rf7io8yyBhTiJn631MiuKonaVayRlkb1NrEeDRPv490LUd0/VRJsAfMA0ASWRtap/CxHHglz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKhSrLSpOtq/k6rQYupyJW1XhBQLXb0/TAKv9UFJlM4=;
 b=xhn4kcdJKplCTmJHFQoY5MbBXhP26z8wTW+S/IPBFCIbIIS+IOkQr/RHNoRd1q3/EPd1NVi5nTqIgU5omDEpyF3PoaCheRwTrWZitNB3EmW709I5wMYfeHwrebgRPJd8Pp7a+wmeAW6a5SuGkAPW8dpoBXGiGueMov5R/RD9MXKP8b2OAJZPzToiohfSEyRb1ZuULFPiTUpwFvObpMiGPr8pHlx0qT0xbjprDyIOTRKY5W5LIzR6wV5VzSgEkU3fAT0mJmEo8dtNv5g2CsSSjB3B5I4e1ribZjnkI0khkefPYli/sN+TyBrPsHteeHzd7j/9S5Zrgdkuy0Wh3K/frg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKhSrLSpOtq/k6rQYupyJW1XhBQLXb0/TAKv9UFJlM4=;
 b=mvtIMthU0vv5meYYccDXylxPhkal+2R8drOln0ps+PuJFz5rgOsnDHX8BamTOrBKXJPkG1OrNFaYDw+UnkeFp7hqiCQrFgLz4Mx8X4gAk19sgu0eHxtlD1AlOG7zTaYbassJrO7fnL4QE991OhCwH4JGjLcBhJULC/0ESCgfuyD0KnoZy91pW3xUMRHOE16ZSe8rYNrITrDps1b9I/udKiEX7L2mIgkLspZHWluMVfSPLB/V3pc1D0Fkdh2yGdqX9a1/EYjNs38i+Jl/jwL5k2jLgCPQINXkeQzxVfqkc9VvwEeak3xSrPM+tY1z/0ltdy6KK0LBSxTzITJdNvLJfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB7684.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:630::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Thu, 12 Nov
 2026 17:00:28 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 17:00:28 +0000
Message-ID: <bd84bf4b-12e7-462b-8fcc-6180a737fe27@siemens.com>
Date: Thu, 12 Nov 2026 18:00:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: New issue with 64 bits wrapper
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev
References: <115efd-6af5eb80-27-36f80d40@101055125>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <115efd-6af5eb80-27-36f80d40@101055125>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae177d6-8881-477f-1122-08df40de73cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261028144727099003|10067099003|11063799006|56012099006|261026121527099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hu/0BFK+6GD+G4kjy9aHsVyXO55GPPKB1P8zZQ0s2Szgjq55aVHURW8wswRmc/bnSg7iq/xA+OzIW2O2+6IH9SHbjeZC0ZFGmvj6c8KMZM1N8+hKfqWE4kkyP/aBbYpnKb2L72zVupgnkf5muneuETKNybtECfrdBBJVu5hJ8+s/cZD27oQimHA9R/3i88WDlvE87IbUPgU6triMaqjeT6iG0Tp16H+bDsYft3igHf6m/yS+z3FAu4M0l4A/smFDZV0hUq9vDmCR8s7Bw7x/IG0jawaBS9WIRYWwb08km/iqNYysPSH2sHiQCl9oKadAAHrZw0DpbGYThUpeHpB1yJO49RtTnZIo5rt6cWqoTSOC/KlmYXKfTsCfExVE9WyyXYNrx/JKYoLGsbJHUtgPfynDikNOkBH4C/htXBfJJDWVfgUQWkTyX6lJg2jHm3/AFhyfMNvDBoAiQQslmg4NI69jm6lJSRDA3oyFzPHbnAbl2MsG2jZ8oz+4FLWuqs+goBF7G3kpL7RnSUZc450SEmARiLBPaFpob/ctgfFXnZ3QCkVovBjFatXPcjVxXzGDod735IWUp0fm7zoaEZMWq+kIwPK42eePb7rhqr7nA+3MuiSPcsPN25JQfzlXJvN1R4wxn++DROYrQwDRUqydeQ+P4LSUAWQ8Pu9Sq0anKX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261028144727099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFdSbktWUWR2YkZ5WXg4dkRCWXF0QXd1U1ZWZmp5ZGxzc0pMU0lORkpoZitu?=
 =?utf-8?B?cjVST2FsTWtqQUlReFhZVkJFNWZ5LzRhZ0NhWTMxMk1EY1FuY09xQzR0QXBs?=
 =?utf-8?B?c0hHclNoZXlsVG50bVNGMVpqZTZMTGFyd2ZUVkNjMnJ0blY0OG1EWUxVdTJ4?=
 =?utf-8?B?cE9hbWt0WXlSeHB5eWFpWDBhaFRPRmlPL2FKb2ZZcG85RHRmclZsanRyOGl6?=
 =?utf-8?B?WStITmFXNkh2MlErY044OE1oVGlXbW1iU29pdEFBdnpGTjdUbU1mSUw3alZw?=
 =?utf-8?B?SWs5RXFHNlBzZ1hRR3JRcTNLZkZrWkYxMUh5OC9tOHZuT2ovU2J5dTB5ZDlK?=
 =?utf-8?B?ZmNUa1hwV253UzlMdDl4L2pHUFlOcEQ5UzE1T2MrSGdLNUtib2VraWJRYzRN?=
 =?utf-8?B?M3hPK01CL2xlS3ZEbUY2T3FFMmNoRmRIQStpOHB2MElieklaRjlNRWRsNk9F?=
 =?utf-8?B?MUpCcjVxV3JKNVpEQmhKc1BsUFE0V0JqOEJudlMwQ2lZUWVaalVzQXJRazBh?=
 =?utf-8?B?RmwzS05CcnZmMnB4cy8vdWxMeTRsSm1xZ2RPUjd5eUFXM1N1SVRCeERjQm12?=
 =?utf-8?B?RUw5K0VDTTNyM1dzU2FJckptMmo3d2tNUjcyTWdGK09VUXhTTGMxWFlYODhJ?=
 =?utf-8?B?UFdIYjlqUkNNSjEwZnFaY3ZiLzk1Q0kvaWZ2ZnhGOXQxc1ZvS2xWL0NvYXZO?=
 =?utf-8?B?N1FqQXBiVEVqb2tvMFRXVnhsS1N4ODNTdWJhNEhXRTRVMmJLVEZFcjhLUGZD?=
 =?utf-8?B?VkRxT1RBQUV4QlRLcThJN3BTNmhXaFRta3EvOGhsU3dXWmM2bmdJeVBCUVhG?=
 =?utf-8?B?S1ZudGdIdWVxNGNpSWIxWnpBLyt4d0R5REJJZGN0ZGp0UlpQaG9XTHNTajN0?=
 =?utf-8?B?b0RjZXVGdWVrc1U1N005MmIyMUFEcUw5Wmhac0hXSW16Mk40LzQ3NVpEdVNu?=
 =?utf-8?B?LzdVM09ycjZFQ3dWVWtUd1FBNFlQTjA2aUtLMlBlR054U0ZaWStQV2g3Rnpa?=
 =?utf-8?B?ZGxPSmNJVXJ5R1pYN3JPak9iZUM5SFYxUUtIZVFmSDVJNHVPVjIrL1hUQXJR?=
 =?utf-8?B?RG9pTUErUzMvK05rZU1hSzdnRXVHOHRLTFRaUGtiNjlyb0lDa28vakhGeHF3?=
 =?utf-8?B?d2RFWmtXUkNsUGd1UUFkSkNmcFNvTjc3ckRQcnhmcHpkNUZYR1dzQk9nNzhM?=
 =?utf-8?B?dGxKLzJqWEkyLzkwYkQwdWxvUStxL2ZIcmE1V05ROXZWUTlHL1Ewd3JsTFBL?=
 =?utf-8?B?RnRRMUMybEF3UzArS3JBQ2l1VkJQTkF2MGh3VnpEMUgyUFdOb3dFY1doYnVU?=
 =?utf-8?B?c0pQb3FpTmdVejlVbksvMDBVWG5PandBV1NSeUxETWxCaVVQa25KU2RMdEYv?=
 =?utf-8?B?OTc5TitzUmxabURROEJiRVNNMFRmS2d2UnpkR3pQM3c5L0VVWkwza3J4TXNW?=
 =?utf-8?B?aGtRdUhUbWFhSzllekY2aFE0TkFZUitMN1NBOFdNZDlRR0R4dVNxNk05U2No?=
 =?utf-8?B?QmRWcVlFbDZFN1NkdFhFdkQ4bFpkaCt3QmswTjFLMHlxZWIwYW55cHVZZnhy?=
 =?utf-8?B?MHd0V1BFNEdieGhLcUZSUFluRmpwaFBuejBUNG4wZ3dWbi9iVkhUUWVTR3dt?=
 =?utf-8?B?RnNZZkd4U0E5dDlGRWFRRy9MVmREdjJrajZYeDlEcmQrWVhHTDcycnZ2eXJz?=
 =?utf-8?B?Smg2UEo1Ulh2ak8yNHlQWHEyS2dqdDhSZjdxUDJ5NGFnUGF5a0k4SlZzZ1RQ?=
 =?utf-8?B?NTZWZEduWkNuYWZTVmNsYXZnWDVQU0JJS1NQNW9zTzlHVThPU1I2ZUpBV2ZX?=
 =?utf-8?B?WVJ6cy81Rm84SmR5Z0Q1OHhlbHZiRTJQL1JWUy9zNWVwTGtSZEVlbkhIOGpY?=
 =?utf-8?B?eDlRVlRQQkVJWUErRHByN3BOSjMzaEhsMXpXZGxNWU1ya0YyZWMweWJmbWJG?=
 =?utf-8?B?SkVIdGRlSUdFQno5SzZGUEtxLys4SVppVnk2dVE2ZUdCbHkzalJkc3NRWXpK?=
 =?utf-8?B?REdSZzV5SzdGa0I0alBIaE8xaitEaDRUY1RKTjhWTmx6cktmNW5SaFFLd0tU?=
 =?utf-8?B?UnhOeUlxZXdndUVQZXBFZWpMUUhtRjNTNFJqdG9Gd3gzQXR1UGxxQUlaVFN3?=
 =?utf-8?B?MEtkZ3llcHo1alRqOENBUzBadEpRLzUwZ21hNVBVMXpxWDBVeFVneXFmUWlZ?=
 =?utf-8?B?bUZCQ214RzRwYnNBQXYrbmxFS0ZzQXg5Q25Rb0RKOTBNWnFZbG5wbkFPUXg4?=
 =?utf-8?B?RVlYM1dZSW4xK0ZKZ0hsTU9EbkRHY01SU1YvSXFKWE1sZ1ZrTEI0RGxVWGVz?=
 =?utf-8?B?K09zMkdPQXpUUEpvOHVQakFCR3g5T0Q5NUlLU25DT29mVURmNDA3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae177d6-8881-477f-1122-08df40de73cf
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:00:28.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4BpMXXLTuSuyFZW8ybC9jbmJqsKAZ9sW9crLslO/CyvSVhVlf7CrL85rerMCk3RNxHQff90o/mpVJpzqq5WHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7684

On 12.11.26 17:37, François Legal wrote:
> Le Jeudi, Novembre 12, 2026 17:31 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 12.11.26 16:59, François Legal wrote:
>>> Le Jeudi, Novembre 12, 2026 16:35 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>  
>>>> On 12.11.26 15:34, François Legal wrote:
>>>>> Still in the process of porting my app to linux 6.12/x3.3, I've got a build issue regarding mmap.
>>>>> Arch is arm.
>>>>>
>>>>> if I build a function that calls mmap without __STD decoration, it gets translated to 
>>>>> bl	0 <mmap64>
>>>>> by the compiler.
>>>>> However, when I use the __STD decoration, it gets translated to
>>>>> bl	0 <__real_mmap>
>>>>>
>>>>> which itself fails because the real mmap expects the offset be a 32 bits integer, which is it not.
>>>>>
>>>>> So I wondering whether the definitions in cobalt/sys/mman.h
>>>>> COBALT_DECL(void *, mmap,
>>>>> 	    (void *addr, size_t length, int prot, int flags, int fd,
>>>>> 	     off_t offset));
>>>>>
>>>>> #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
>>>>> COBALT_DECL(void *, mmap64,
>>>>> 	    (void *addr, size_t length, int prot, int flags, int fd,
>>>>> 	     off64_t offset));
>>>>> #endif
>>>>>
>>>>> should be replaced with
>>>>>
>>>>> COBALT_DECL_TIME64(void *, mmap, mmap64,
>>>>> 	    (void *addr, size_t length, int prot, int flags, int fd,
>>>>> 	     off_t offset));
>>>>>
>>>>
>>>> Xenomai version? Would [1] help?
>>>>
>>>> Jan
>>>>
>>>> [1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608b6fa7129de1ff4213ddf31298616cbf23
>>>>
>>>> -- 
>>>> Siemens AG, Foundational Technologies
>>>> Linux Expert Center
>>>  
>>> Hi Jan.
>>>
>>> it's xenomai 3.3.
>>>
>>> I don't believe [1] would help. I'm on ARM with -D_FILE_OFFSET_BITS=64.
>>> In these conditions, mmap as its last parameter offset as a 64 bits integer, an thus mmap64 should be called. Always.
>>>
>>>
>>> Looking at [1], the decorated __real_mmap still calls mmap which is wrong in my case. I believe what is supposed to be fixed by [1] is only partial (the __cobalt_mmap should work).
>>>
>>
>> These mapping/wrapping topics always cause headache to me. That's why I
>> threw the fix I recalled at you, though also because I think it came
>> from a compat x86 scenario.
>>
>> Regarding your change proposal: It's likely pointing in the right
>> direction, except that TIME64 would at least be a misnomer because the
>> actual control here is behind 64-bit for offset - although (not only) we
>> demand to couple both in Xenomai configurations.
>>
> 
> That's what I thought too while writing, but it was just to propose a simple and understandable strategy.
> I guess I can provide a patch with somethin named like  COBALT_DECL_OFFSET64 that follows the same logic  COBALT_DECL_TIME64 does.
> 
> Tell me if it's ok.
> 

My brain-extension suggested COBALT_DECL_OFF64 as well - please go for that.

AI also found another issue along that road, will send a patch soon.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
