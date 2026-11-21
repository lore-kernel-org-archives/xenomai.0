Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795279501;
	b=v1aVJz5x9TMduqtWyA7WygeuEVD9deBPjUYWUXQwJyq1DrBx5Tr4O2L4/CCoURnlHb1m
	 JL5xaQunkksG0+RD/tlSDed7VDqy8nJ9At89+Z7Bc032+oSNp/PQwtmJUEeG6K5kIZ3qD
	 aeWJze2yP2rj6h4Qcfi9NjRSzU6MhSkMORWcr9hIMS5shT75j5WooChLqjx1E53a6p9M6
	 neNRXuNKVLu7yv1eWIx6NsW0bOEXOyv0a1CCndc/qtPy+GUt/ILWAImI1z0YHj7fCUXMY
	 caDRpfbziy9O8Mw3eLn26BTywABav6IltoVcVe42iqG1Ka+9lFzfRRLUrpG42nzO9Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279501;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=y3Cu/MeuQZr0NeBsDZbDFw/FOwGmVPor6zaHDfasW4E=;
	b=0VeaSK/JkRqlPl3idc3MG5cSpfenfMbdEo+s3FK8jDFjW6IcA1e1Iq3cKTzYIRFNPLGi
	 CM6XsGnwq1dZv5w3cmNBiN3BskEM7iX3O+BPcZFiIKbl2olN21OXbd87ysuIrgCXl0c2/
	 jzqF4qYP3LizdrEZuG5Dg5V/cVNXk/V7IpIpmJEVhMb2t3ZtO+2k3Gq+o2TVwMix79L4x
	 1vZPyhKXzwzhqLfn5RWFCBwsb4UIeqIPWvzj2zkcx31UzntWfg8aJ24QVFO+6fce50yxO
	 APfmIb7zW5jqdLvdWkOTcm6WkoY25g6Yy5SKHrR+sBnOIgnmUz+7cAESgRY6z789rUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=xzo74f1Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A828606A32C
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 16:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A828606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=xzo74f1Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hakmZWGBM2l/LCmoEgYRcS+1xaJsRUl/29VQ87Lq/Y1wF/YIX3X5QP9edPUNjP7KwQGioq8h7f5jHZizTMZyxuDjsPJpn8ti2hCYK9OUw+Er1ehG0uXlnd6Vaf5yZWxzjfvYDyAZSxekC7elFb0WJvgFazdiGE9VJW7FwDJ/oVEz9qs/xIBDYN382uWPt4U6tzSsoYWr+YxUf2PKUuxSwQAh6OOuO0SOroxwcaULTcpy9K828Ug9fywHma+yjM+CGje1vstCsIqKYHRjO0HEsSQkM3d5xuMueuxpExjnnMbkpt9FK9UPkP/Aujc/54IitxwX13xy7X1z7xqp+9LcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Cu/MeuQZr0NeBsDZbDFw/FOwGmVPor6zaHDfasW4E=;
 b=XSFInPFVOSZxG3Y+M+c3wp3wg/Nc4kZltVQNp1asjG8u+gXvFZSiSGA2CA8qtQUlStSwUiJtTVoN/eWBB4JpyoIEtSQ4VO7ScFistGa1dHLemEJJchVlTtyeC0RmKozKYJsSZBdWeXtPpXprX+ng23Rg7irxnBRbLcR4oq/3d2kjiN4az+hr5lDSY8l6p/vP38n/oAi33rb1QDxcKHD9pV2WqGuld44Ku43UXhc0Hs37kjNw37m+OU5Yd3i1AGFktDI8kchvt0ucByL6B3u7NFaP+BRSW3nzwKEvqR3/Py1fVI9Ko9td3eh3XwFOiBkb87XWzomuP++Hdf57lhWrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3Cu/MeuQZr0NeBsDZbDFw/FOwGmVPor6zaHDfasW4E=;
 b=xzo74f1Qv0704/dube1ZtovztijUOyN/ewyJw9j9lncrkbOaxjnl7QQOFYGq5Oolh7839H4BCu7m8AlnfjAjDOLRofuLrZ+n/hJOSmWbhoS5YAXCbXQoOaYyZsUcGJYAbbr4wMlMVo07SnLjNQegPrqWd/iXL5jGqxy3+G8EL3Ykloc+paPFTa4mzbf26i4Qisk8+KRYaqsOltjOPt/6Jm0xUfRK8yGmsiKbXEnsX7ulR2rYgtLSbzigbIhJ/pGbHoGAC5C9cbQdyU7JCzBfDhAZp7Q3yYM9kksNgWCUAc93rVnBG2l8xO6MbyTG+Zzucj6IPhtOIpKPPEkUipWYdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VE1PR10MB3917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:162::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Sat, 21 Nov
 2026 16:44:57 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sat, 21 Nov 2026
 16:44:56 +0000
Message-ID: <87cba6b3-12e8-492d-9c18-79f2ea922b12@siemens.com>
Date: Sat, 21 Nov 2026 17:45:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 0/5] riscv: dovetail: trap handling fixes
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
 <72d9742fd8baa9ea9735d241af0b738be56e85bc.camel@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <72d9742fd8baa9ea9735d241af0b738be56e85bc.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VE1PR10MB3917:EE_
X-MS-Office365-Filtering-Correlation-Id: b8edcfba-4a16-468f-2338-08df47eec670
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|23010399003|261022075727099003|261102123227099003|4143699003|261026121527099003|56012099006|261028144727099003|11063799006|261021121427099003|261022105027099003|261021123027099003|10067099003|261026140227099003|261009221227099003|261009220027099003|261009223027099003|8126099003|18002099003|22082099003|55112099003|261009223327099003|261009221727099003;
X-Microsoft-Antispam-Message-Info:
	XIONfKVG56PkRmSsFsxnAd+GM9p2Hvh/r0StCeWAzXw9ocB/EBJsp6NaDRHTwwVNc6KLc6fsrgjq19BRXO/fgbeDvK02o0Doy/eVbviz4VYZjGDkfOn13QTW0gq6gjjK6OVQV6lt0heTbjEsjIFR45XVMxYeHBUdQWGJvtph0bWYzSK7lI/bySTpl6sSZx5yTyeo3OW3+x2KAfyHfmYsin+VM5oTLniWyhvE5yZLwnw0gjwaLk9srv44CL3XgRRTtM8MWBsIuQSyq+5FhkhDhqSR3L99pbOvIuryy9EYji2tQjgs3gSsNMGH/MIymINULjmk0NGBArVBJ4QwVYVcj+LNvpU/qL0fBX9FtKRF/GgSVTdr7h+oPcbWqIBfQ89eOJVqiOh0U9B0uOt8WEP/p2lZCPDwt89PcsY957gObPLPGli+gvHBbVbUCGF53u/jOHE7GsfkPKuxeVW21QV72zda9l7E1n95/bNMdQ2qqWTXSpsUIJVMVd+iSH5d3QQ5Ddicv4KKmqasWL5bxtR/6XB+nFwC0+vK7ARjeL2g/+9KViXWhSRcyVpBkHXNYGU+0Jfnj2sqIJ1ni//tIDPJC2TuCjteNoep7sWtFP0PXsoUcuF7ZgNOQuHBYoGw43gE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(23010399003)(261022075727099003)(261102123227099003)(4143699003)(261026121527099003)(56012099006)(261028144727099003)(11063799006)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003)(261026140227099003)(261009221227099003)(261009220027099003)(261009223027099003)(8126099003)(18002099003)(22082099003)(55112099003)(261009223327099003)(261009221727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2NCZ2pya0hSY0R1M01RV1pxRXF6dWJteXV6a0pLUStFdGJyOEsrOFRLMi8y?=
 =?utf-8?B?OHgzY1VoOWZGN1ptbGNjT2Q1YlVITWVPdUtjS0RYRU9KYXBWKy9wRktiamlJ?=
 =?utf-8?B?NkRWZWJzMzJJS2JGS2oxeXBtODZQTk1iSE4zSlA1OGlkZjBkZEhyQXh6ODli?=
 =?utf-8?B?QTZOZXAyUi82a2ZuUzFoeXE4cmtvcWxpa1krcTBQUHlQb0hORThvT2JsN1A4?=
 =?utf-8?B?U3djaUhjZSthblAyQjBpbzJpaWliOUlJOVNIQ0ViMVBaYVI1L1B0a3A0eFBa?=
 =?utf-8?B?bm42UWEvOW1SUTVkVW5SKzRjNmFjellHb1JTUUxYeHozR1dWMjgvWTR6VXlN?=
 =?utf-8?B?UTc0R3R4YnhlallVdnhTRzRwekpzVHRFby90Ty8ybHF4MTY5eDJ4NXdSa0Jm?=
 =?utf-8?B?ck9CcUg4VDZLSE16bmJCL1EvYzR6Q09kRHRoUTVhdHNwakx2bHVsNStZaFpF?=
 =?utf-8?B?L1NQcFl1REx6aXRsdjd3aXNGUHBDcm5qRTlML01CVHdRWWpvS05aUFhJTHc4?=
 =?utf-8?B?L2g4Z2NQVTJ3UElmdFRyQjZPdm5vQ3BQV0hwZDBZU2tZRzA3TE1MSzNuYjBQ?=
 =?utf-8?B?RmVxYmtQai9LVWdnZnpDbEhlU2UyRnlCdUxKVEI1dFk0WjhuakpzaWo3ZHdQ?=
 =?utf-8?B?NGNLN2paTHM0dloreklJUVpqd2x0aFF0cnl1QXlicXpueHp3WDBiVG5Zbjk2?=
 =?utf-8?B?Ym1YWFdyMjM5YXA4WVdxRzBKelRyZFFjMU0vRmtZRUtiaC9rak53YTZTM0ht?=
 =?utf-8?B?ekZvaWMxb1M4Yjh2c2tHU3ZUenlRUXZTdVdseE1TUE5WTUVZOTJJMmpvd2lO?=
 =?utf-8?B?YzhMTTJDdHBRajRpRHNXTnlLMTA3a1NNT2FDMkpIbi96ak9zZWwvZDU5VWkv?=
 =?utf-8?B?dzZrTmNlRFJkR21haUZ1MlgvRGo4K0NaZWc5ejRoTTkveGE0SXg2ZHgwNjYv?=
 =?utf-8?B?ZGR1cGtIU1MxdmlxRUJmamh4OW9ZZFpKaW5nZkEzenhaYjVvSXpkblV0YkJK?=
 =?utf-8?B?OHIrUHVxZVpsWVZNL01IdHl5RTVyWXVNb1hWOWhXTGJqNXFtKzJVV3NVMlQz?=
 =?utf-8?B?UlBHZVd2bzFJU0prNFNBRGF6a091aWdWeXVtL1JibWNEZjJUNnJQTWcybitX?=
 =?utf-8?B?SEwvU0FxSTladXFiR2lCWVVUVnV4R0NCcFdVV3J6bXpnR0xDQmU5Z1hQZkVZ?=
 =?utf-8?B?WGVjT2dRZFFZczAzVDN2bUhYc2xJN1pPOW1vRW5xZDdYWU8xZGRBY1VEUC9Y?=
 =?utf-8?B?d2J1NlBPNkZXZjZ0TlIrRy9rbFdzeGxBdUlUZ0ZiWlB2MVJzNW5uMEhXRXF2?=
 =?utf-8?B?cG1rS3lxNE52VlQzZlFqVzFSZkZ0Qk1VVnFPWjMra3Z3bWRLZlBoVFFIWWpv?=
 =?utf-8?B?Z0VSUnNuZDNqditJRllBYytZb0YxZ2F2ZVlpb3dVdUxCSXFIM0NBQ21DYWVE?=
 =?utf-8?B?eWROQlY3OXIrL0xjeHZxQkRXVVkwTUJsTkpycGZxYkJ5ZmpXdmpkSHRvZ0xY?=
 =?utf-8?B?V3VVUFF1VVNtZTlGSlhvQ0JBY3pIK25hVlNwUjA5SWFQUkhEMVQvMFZqcWF0?=
 =?utf-8?B?b0haeXJmQ296SG0vMHRZaUJBMkFvYjR6NUtBQWlYckQydEdnSVUrWnpSVEJW?=
 =?utf-8?B?bFI5elhTbFpRS0RVRVRUbndYc3FCMk42VGFMeUY4cEJnRHlFcXY4cUNVcVc3?=
 =?utf-8?B?MXRZaGJFNFdVR1BaR2c5QmQxVG50ZGVYKzhQdnNpbitjeXpjdzBBczNybVlB?=
 =?utf-8?B?RkNLeGtlaU1sTyswNEtFRTRxMVhZM0hKbUlUUjcrTnBOeml3eTJyZTNETUMr?=
 =?utf-8?B?ZEJWQTM0dUtLWGZRTTZXNkIrQUdxTURDWFhDSjh1UklxMERCaWpQd1RwOWl0?=
 =?utf-8?B?ZENta1F5YXFjN0ZEalRXdDFSVFZOWXZYelhXTXliOVBuSjMrU3B2UzJTRDVo?=
 =?utf-8?B?R2N2VWx3eWMrcWpGTkhNL3Rydk5JbCtCd1hSY3hTdzlVTXNqTUk3aFN4cVRj?=
 =?utf-8?B?dVAvNGJidTBsVWEwSlJzdWd5VEhzU1I1b3JHVGhBQmFOZ2xqUnQyR0dVMGR5?=
 =?utf-8?B?RTZqVGtEUTY3RWZnUEw2eC9ySUZwMkZJQXhXVDlLNHBIUnJIQUZmei96ZWZK?=
 =?utf-8?B?WVRYTWZKblE4M3NlTzY1VS9DdGhVZUd5VC9CSThMelRGdldwTUJyL2MydC9R?=
 =?utf-8?B?TWZJT1gwUVFFc3VGYnBkTjRpSXhYRHVac2VCcUdPR0I4ZUxFb3haN1pDQitO?=
 =?utf-8?B?TmtKUlNuVFFRNm90dG1Pd0haams4aWV1blpOajduZkVTcHBqNXo3SlV2UDJH?=
 =?utf-8?B?WWVHR3p4OVgvM2Z2M2QzU0RGWFhQdlAxa0N3WW5TNE8yTjVod1dUV0lMenhy?=
 =?utf-8?Q?WZs3oCXEhrtpbSgEK55lESULe8ZtR1abTL38IJKtIp4Gi?=
X-MS-Exchange-AntiSpam-MessageData-1: zO5rLlKyxCE+3GvD+LN/lMKKCpcb+8aQEdU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8edcfba-4a16-468f-2338-08df47eec670
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:44:56.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SsvgVKUY/d8NPBpkib8stpn8sz3woZd9BDsgTGxYdwsfU5gqgbbRuuaEbMo8p7ANeCZlcCJY6c103/DxcYRj+28PnGfUsXs+RcXwqNXWBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3917

On 11/17/26 20:16, Florian Bezdeka wrote:
> On Tue, 2026-11-17 at 13:39 +0100, Tobias Schaffner wrote:
>> Hi all,
>>
>> this series fixes the riscv trap handling of Dovetail.
>>
>> Thanks to Jan for sharing his AI reviews on this which made me have
>> a look at this.
>>
>> The bugs were verified by running a trap matrix test, which raises
>> every kind of trap from an out-of-band EVL thread, with a more detailed
>> oob_trap RV monitor from the Dovetail RV RFC enabled.
> 
> Where are those tests?

Thanks for reviewing this.

You can find the current version on my development branches if you are
interested:
https://github.com/TobiasSchaffner/linux/commits/tobsch/rv-trap-handling/
https://github.com/TobiasSchaffner/libevl/tree/tests/trap-matrix

> The problem with that approach (fixes first, tests later) is quite
> simple: Once the fixes are in, interest in automating the necessary
> testsuite is gone.
> 
> Solution: Tests have to arrive at the same time.
> 
> In case they were on the list already: Please add a reference here.

You are definitely correct here in general. In this case this is
a continuation of the RV monitor RFC I proposed last week.
https://lore.kernel.org/xenomai/875wxsocpg.fsf@xenomai.org/T/#t

At the moment I am still validating and further improving the monitors
step by step. I will definitely propose this if RV in general got
accepted, but possibly over a few iterations.

>>
>> Testing was done on v7.3 with EVL under QEMU riscv64: the trap matrix
>> test, the libevl suite and kprobe tests hitting out-of-band syscalls,
>> IRQ handlers and nested faults all pass with a clean kernel log and no
>> monitor reaction. Reverting the fixes one at a time reproduces each
>> bug except the last one.
>>
>> Thanks,
>> Tobias
>>
>> Tobias Schaffner (5):
>>    riscv: dovetail: do not notify traps again from do_trap()
>>    riscv: dovetail: run kernel trap handlers the core did not demote for
>>    riscv: dovetail: do not nest the unknown trap handler in software
>>      checks
>>    riscv: dovetail: keep hard irqs off for page faults handled
>>      out-of-band
>>    riscv: dovetail: read the CFI trap value from the saved registers
>>
>>   arch/riscv/kernel/traps.c | 60 +++++++++++++++++++++------------------
>>   1 file changed, 32 insertions(+), 28 deletions(-)
>>
>>
>> base-commit: de6ccdbc1027fda48257c4033c90d57da3e676ea
>> -- 
>> 2.53.0

