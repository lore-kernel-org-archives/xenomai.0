Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795163859;
	b=JvUes4DvvzqYp9U0LMccTD3m1/8ZlVeA7DfOEBtYNtqalkieTd9+8SIghX0te7mnqv3m
	 JJLpG90OSIJa+6gype3PL56s+4ZljkWV+KQzke4sxLg2uNKTZZFYt5ryYkNwvck+zZrJ3
	 QWf92esyipQaetSnLflmLdWptZH/1lGgcWzpbUerjxEXO1CGCWvKG0qQ7Oa4OXdLUZJPN
	 KNLXBa6MfjPX9bc8diIVkQjYr5n8YaPwYH5LqHxB3yvsONYYbOCOwYNCAXY/f8KB+h7MB
	 zTSvRDJscuwlx+QGV58atdx5tOZf/ALb98N+FTvbyOpJiOBx+GwUJrMeVnqIRQ1Hxzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163859;
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
	bh=G4KlgOQlxOzMmgkKcxM/1GZZmUf+V10qCPudur/493w=;
	b=XE/KpHC4ENcbOkU/Cft+iLzGzsn3fonWpu8MEM9Qv8d5QpStYZiv7cCcduxgLY1BA72t
	 my9mQ4rjxdNEbfKRgWAi/l/OFysjQ2kn7narJS8/yn6A3QFLtibI/rdDyytv/nfOOX7ql
	 5kIFJjtJ/2uZiqjILgod4wEhq8s14INs9mNf1lmGd/hg9ZLV6S4DqZh0TUJ0ajGD65m1H
	 A4j++UhousAS8uwTOdezPP/teGkX5NWWK4MaOGUKdehWpQpVeUNL6L3Z1FPVwRTbRucKD
	 +0UiS0jpPqCF4X5DepzizaVUNg7pqNFidv+c2zaOk8Iy0ES828t23W699bO7vLHFaqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=TrTxORBw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.18
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE8606A325
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 08:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FEE8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=TrTxORBw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clwpO3yATVdoPjQIlAAT1WUK6ShyZ8wNLUQYYQLBsbS9atG1DAuIitJ6a8u4sTedDFER7etMR4xpkCeU5nhj5YbiA+yYaWiKjp0TSu+biBEHDdsNdD8FACi6rqWcdyJAwVrBzqFcLDoIBoX3t9dq7MBcGDfGKLYqbleSsKudU4qm+xUVswMCIRGn1oh3OiVfhD7KtIA3lAUDEzvCbMHJH7fqmpx/EW1pQqjxm45HERzlu2Z4bvABhFH1cwipkaGQ+6HoXfytoVYOktzuLn3/E+jxHphYUS5w3dQAW5ttS/8NBzUSNGvMbDuwzDTM9Wq/RF240OXNaqWygkjPLRI4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4KlgOQlxOzMmgkKcxM/1GZZmUf+V10qCPudur/493w=;
 b=qIarl0Pj7j/kan64jeB1ME1QGLJrNOjU5el4jJxDuH3VqhZQE419IgVp8G6+TPqwhFdcGbbAxmc5MnabbIRSjxeLyuvf9aywuBa8hhQpHCQN5UFoLvySyiGE5z8uWbgHyWgHqIf8UgIRGyt8Tsm1BHmM09ZPoMEYmOjlF8cxZyWKX06CX7TBwOf8EI6wAP9c+mIRMCY3ciWFe4UKGdOP/+goqp4XZRvlAAjEJ6+Ez9Uo/YV5+zca8P77yL+rzdIAtzJ5XMjIES2l2Zs+r7WnLvqDcIcb1Pi/UJzRXyEOaWkN7tm662rqAYKsXG02NgV7Fk0fdKhfNphs61wtFjJePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4KlgOQlxOzMmgkKcxM/1GZZmUf+V10qCPudur/493w=;
 b=TrTxORBwM3x+/Wlx5ot2xhmnjRMuRN+z7WBKtG62SOEcFNkXtfd10pTw8Sv8gLDljCh+pSsk1f2RBXHh8FdUmXwiDfeAo5si36NghzIQ24Mf/mh3nZ3Bc9QbFZwSZqP+aE5EBIVywdC4p6Bze4EnjR3csujItBPLyTnPjTof0BRAGFHKPVg/p2DzShGZl/2MdORUwy+JAiaiBmGLA9zYYd0+bVxO7zjhk7kKQtaixGi0ZXq/a3LzHEtwBrGWvJ1rV5jOPtCazId7kNhP3Xs5NAMJf6h3WgEwrUVE7M+Q5zsonu6QHRT9U/ARVtCOxHl/qNydUMsvHNX2cToxX3DNmw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PR3PR10MB3962.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:4f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Fri, 20 Nov
 2026 08:37:35 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 08:37:35 +0000
Message-ID: <585e5c5b-dd25-4566-b0bc-4bebb04d891d@siemens.com>
Date: Fri, 20 Nov 2026 09:37:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixes broken mmap patching on 32bits archs
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev
References: <115efd-6b000580-3f-36f80d40@101056808>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <115efd-6b000580-3f-36f80d40@101056808>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PR3PR10MB3962:EE_
X-MS-Office365-Filtering-Correlation-Id: a67c6564-f3d9-4f8f-c2a4-08df46e186c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261102123227099003|11063799006|56012099006|261026140227099003|261021121427099003|261022105027099003|261009223027099003|261028144727099003|261026121527099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RIJxq4Ydnj3W9scxX5mcC7QDBWEvLtNrodnpGHTvvGzC4nw3u4Ro3ILWyxZwlFEqgNVNcAlwQora0iU6W3qXsl8lAEeMjp7JDBGSmv+zO4/UhvGM9MKcZImffAkaP9r0E5Iion1DORI1wqkUeV8oRiWtjla+DtrVVIFR+JZsl1yQqQt8BLvFZadftkYujpqmPvBxYcvm/P9tHb1LLLo5n3mWSrGb1v2HWFebpNu5R1sJdqSNCWJeYAoaYokkPC+KljAGK+4PyUisfya2N5WC/K5OIHa0KmTU5VOcvGWfyX6dDLnMYvJZKfRZD3Oogm+kFPf/j0rgRi9VOX1cqKFsmVjO02veXCRieGdQ5noDlAWp+4irSzJl61qpPrDPJokzSWbVpmdUiBUhg0HnrGA+MZsMBwEAu64i+X/781e6IIHPSx9vv2jvS/XExY7m1IZHPBIp+UMTwMBi9lChSHl2WKZmIyg8PzN2dbfcpQeikUUdXQzX5btDspVe7U5qbjMn7n/3vcwNV84j4BolPlZ/VIhhT4wL/+9H/YdMfbE0ERpM6X9PI6MigpwPP/uq2bz6Fc3oyJQj6/krOZebJfKvBfo8OCHLZkG2DG5JthkTS22M+bKflzKFtBhYUGuSfTxAmmcyIlGTsOHeCCBfS55emnjBh3rraO/2DQzEUzDNVlY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026121527099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmNRUUdmVm5uM2pyZ1p0WUxIaXFNNXhGalV6SVdKTnhsbDRXcG15K2lLVzNJ?=
 =?utf-8?B?dEE4K0tOT0ZBTERPVXpqa0haRVpjcHM3NWkxdGZCVXRrZkpUcnlySUVSbFA0?=
 =?utf-8?B?ak9aTFQ1VTQ4S1pjUUVxd1BXdXZ5VDAvRDNvRktTWVkvenpKdm1tUVYySFU5?=
 =?utf-8?B?NWllOUZBb2V2ZVNxMCt6QzJMZTU0SkU0dEN4NWlubCt1K2RhcUM4QVViVlR2?=
 =?utf-8?B?ZHoxWGhYYnJiVHFUTHk0WmlOVHVaTmhaS3BXWkhyMGE1SE5LUWxSY2lRZ3B5?=
 =?utf-8?B?WmhoWW54YkQ4K1FZMW5uVnpTamVJTVdSZGNkSHNKSFRJYkxNZ0djNHIzeFg2?=
 =?utf-8?B?b25QTk5lamxSTTZaNVZSRmFVdE9nR1pVNXpYMmM0b1MxVEI2bnpKK2Fwakky?=
 =?utf-8?B?NXFFeVQ3VTVPNmNqZ0dObnhTT1RSQWZlNk5sa3BhMEhaZzlWaGdTTExHRmVQ?=
 =?utf-8?B?UVc5TzVZdHFDcjgvRmNjYXVRUVRJNGN0MTJjelZ0SDhkVDIwaStpR1VqTU96?=
 =?utf-8?B?S2hQWEk3WUdEMmxQZWlwc0FOWW1tZEJnRHdYc0NqdEEvMXpwRS9YajlybGl6?=
 =?utf-8?B?RDNTSE95NXQ0RmJCSTgvL0NzR0pZVHp6bllPbzNSL0hMc1hIY28za0Flc3lW?=
 =?utf-8?B?UTUwQUhNa1pRVnpBVkgzMnpwWWI2SGpsYUZWa3hTK08xZHVhVmZYV3lsOUdn?=
 =?utf-8?B?MGorelpEcDhNU2JoRGhCT3E0NlYxWE5EYkZyblBRRGVJZG1LQnc5NEN4aWpO?=
 =?utf-8?B?WktXNzBxV3ppcC9aT09zMWpqa3ZTMElsVHBKT2N4cTB6V3A4bjU4QlBnTk02?=
 =?utf-8?B?UTB4cTAvaTBZWU56VHp1WFVrVFlUb0J1Qy9SUmRuMS81bXM2aTdsd0E5czMv?=
 =?utf-8?B?S1JsU1NPd2NMcnpuTy9HZk90V25NbnB3UmFwaHZ3dkJKaXFTU3NkMUVRdmNj?=
 =?utf-8?B?TDd1dVlFTmFxQjhRYUdBRzYrTWIzdHpxeWpwUnRoZWd4eGFKSTZtQmM0K1JQ?=
 =?utf-8?B?dmZTQ20zU3BsUUZKMm5uRTc4aTBmZDhzalIyS25JaUg3NVB2blBXSURmemRC?=
 =?utf-8?B?RERqTHVnYmxQL0lSMU1GcERJWFpONWsrWjBFVmVTTFR5REhxYUd5d296bWZU?=
 =?utf-8?B?UFp5RmVFbkVXbGJUVld2Q3BEWTNzOVpXNHdHeGVndDA1ZzhCRW5JZ1VFWGVV?=
 =?utf-8?B?ZEVQaGYvQmdSUmlpZVVqTGtORjA1M2t1cElYR3c2UDJFZ1pJZVF5STNQRUxH?=
 =?utf-8?B?VXZMT082b2UxVHNzbmNpcFhJT1RyVktQMWsrL2J1czRFUkhrcEZMTUtFMVQ2?=
 =?utf-8?B?bFpEQm9TSmVoZ2JjSkRKRXlYWG8rZjFpQkx1Z3I4Sm4vajVhaW0zaUxCUnFF?=
 =?utf-8?B?WEpmemlvRzhpeCs3VDFQWUlJa2VwY1Bta0xUcUxkUjFqeGN0YkRJUktKNnZH?=
 =?utf-8?B?NWRlTjhtQ0VkczlBNGVhcTRQQTlrRGdNSTA1NkppcFRkVjVBZXpnZXNVWWdW?=
 =?utf-8?B?VXNZYkdaQnNzbEhxd3FicHJiNHZFNFdkZkpmMEQ0MUIxekdmQ2tNUkVUb0hS?=
 =?utf-8?B?R3ROdVJ2SkFDU01WbFBVWUd3VnVRejQ5OVpuZUxPQm9SVnYzQzdYRTI4elQx?=
 =?utf-8?B?cDlyRWJxM1pFTUptSEZCODFJT25LUW5aWXkzcVVkVWlnYXAyM0F3VHV0NWZv?=
 =?utf-8?B?YjFpOERFUDllS1dsbCtZUVM5YVA3KzNxR0drbjF2VXhyWDFQSDMwNW81TFJ0?=
 =?utf-8?B?U3psWHkwYkcwTXVFbkNZaWEzMTBLb3ZJM2EybkxSaTY3eFBRRlhKQVo4RTRL?=
 =?utf-8?B?dGJ5VlRzSmlheGJmVytkTHR0UTFLK0o2cDVyaTFKVzRUMTYzMEh6WVJZdjR2?=
 =?utf-8?B?dXhrNS9Qd3plUE93RE1IR21RU3JFZHhhV3Nndk5jWFpWcjlwRGpZaXoyQlN0?=
 =?utf-8?B?bk8yOXEvVzN3Y0hCT1NYeEJ1bHVxMHhEQnJYS2Faa0I1R25UQmswSDdoZFYy?=
 =?utf-8?B?Y2pxR0JJdll1SThyb1VtTXc4TXNGNlQra25MQjZZcFRIU2R0REVzOVMrS28x?=
 =?utf-8?B?Qk9UOHpCZ0JrY1IzQ0xiK2dnOEVjZU9Sb0lEV3RvUm9NVWJla2lGazgxYjVk?=
 =?utf-8?B?Vklpa0hldU9pSG5WeDNLMXA0Mm1JN2gxdlp4ZWdpMzRZQytBVFhjZU9WdFNt?=
 =?utf-8?B?UlFySDFQRnpHWnZxaU5udy9vd2ZoZGg0VldDZjdybG9ERDlMWW5Rcm5YbzBX?=
 =?utf-8?B?cndtVGR3bGJjTFJNU1dvNllTRFMzeFBlREtJa1Q4OXdoSWhtS2RZK0srcGZx?=
 =?utf-8?B?UmYyRnZlMXp2Z3JYTDBSSmtMSWtSSm1kK1Vmd0RvM21abW8zaEFjZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67c6564-f3d9-4f8f-c2a4-08df46e186c7
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:37:35.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvExqekOq5cztyzU5YwwNYjTwUtkM13kIjj2eU+Uc7Z7lqw17IX4iwiOS1Sein9ITNFtnANmxBEEfdC3MUkv9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3962

On 20.11.26 09:32, François Legal wrote:
> Le Vendredi, Novembre 13, 2026 13:20 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 12.11.26 19:11, FranÃ§ois Legal wrote:
>>> mmap is broken on 32 bits arch when __USE_TIME_BITS64 and __USE_FILE_OFFSET64 are set
>>> in that case, libc translate calls of mmap to mmap64 because file offset argument is a 64 bit value.
>>> We fail to catch that with the decoration logic (__STD/__RT) and plain libc mmap is called.
>>>
>>> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
>>> --
>>> diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
>>> index e291f50ef..b6d650876 100644
>>> --- a/include/cobalt/sys/mman.h
>>> +++ b/include/cobalt/sys/mman.h
>>> @@ -28,16 +28,10 @@
>>>  extern "C" {
>>>  #endif
>>>  
>>> -COBALT_DECL(void *, mmap,
>>> +COBALT_DECL_OFF64(void *, mmap, mmap64,
>>>  	    (void *addr, size_t length, int prot, int flags, int fd,
>>>  	     off_t offset));
>>>  
>>> -#if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
>>> -COBALT_DECL(void *, mmap64,
>>> -	    (void *addr, size_t length, int prot, int flags, int fd,
>>> -	     off64_t offset));
>>> -#endif
>>> -
>>>  #ifdef __cplusplus
>>>  }
>>>  #endif
>>> diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
>>> index a5645a1d4..82c9aaa69 100644
>>> --- a/include/cobalt/wrappers.h
>>> +++ b/include/cobalt/wrappers.h
>>> @@ -46,6 +46,23 @@
>>>  #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>>>  #endif
>>>  
>>> +#if __USE_FILE_OFFSET64 && __WORDSIZE == 32
>>> +/*
>>> + * Make __RT() and __STD() usable in combination with time64_t related services.
>>> + */
>>> +#define COBALT_IMPL_OFF64(T, FN, FN_64, I)                                    \
>>> +	__typeof__(T) __wrap_##FN_64 I                                         \
>>> +		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
>>> +	COBALT_IMPL(T, FN, I)
>>> +#define COBALT_DECL_OFF64(T, FN, A, I)                                        \
>>> +	__typeof__(T) __STD(A) I;                                              \
>>> +	extern T __REDIRECT_NTH(__STD(FN), I, __real_##A);                     \
>>> +	COBALT_DECL(T, FN, I)
>>> +#else
>>> +#define COBALT_IMPL_OFF64(T, FN, FN_64, I) COBALT_IMPL(T, FN, I)
>>> +#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>>> +#endif
>>> +
>>>  /*
>>>   * 
>>>   * Each "foo" Cobalt routine shadowing a POSIX service may be
>>> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
>>> index 00c1aaf4b..11a6e86e6 100644
>>> --- a/lib/cobalt/rtdm.c
>>> +++ b/lib/cobalt/rtdm.c
>>> @@ -542,7 +542,7 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
>>>  	return __STD(shutdown(fd, how));
>>>  }
>>>  
>>> -COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
>>> +COBALT_IMPL_OFF64(void *, mmap, mmap64, (void *addr, size_t length, int prot, int flags,
>>>  			     int fd, off64_t offset))
>>>  {
>>>  	struct _rtdm_mmap_request rma;
>>> @@ -574,8 +574,3 @@ regular:
>>>  #endif
>>>  }
>>>  
>>> -COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
>>> -			   int fd, off_t offset))
>>> -{
>>> -	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
>>> -}
>>>
>>
>> The LLM is not convinced: On 32-bit arm with time64 libs, this version 
>> will map __RT(mmap()) to a variant that expects 64-bit off_t, while a 
>> caller which uses 32-bit off_t would rightfully expect mmap to be 32-bit 
>> then.
>>
>> Its counter-proposal:
>>
>> diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
>> index e291f50ef..54c028ad9 100644
>> --- a/include/cobalt/sys/mman.h
>> +++ b/include/cobalt/sys/mman.h
>> @@ -28,9 +28,9 @@
>>  extern "C" {
>>  #endif
>>  
>> -COBALT_DECL(void *, mmap,
>> -	    (void *addr, size_t length, int prot, int flags, int fd,
>> -	     off_t offset));
>> +COBALT_DECL_OFF64(void *, mmap, mmap64,
>> +		  (void *addr, size_t length, int prot, int flags, int fd,
>> +		   off_t offset));
>>   #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
>>  COBALT_DECL(void *, mmap64,
>> diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
>> index 6d826eedf..9dd022a75 100644
>> --- a/include/cobalt/wrappers.h
>> +++ b/include/cobalt/wrappers.h
>> @@ -45,6 +45,21 @@
>>  #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>>  #endif
>>  
>> +#if defined(__USE_FILE_OFFSET64) && !defined(__COBALT_NO_OFF64_REDIRECT__)
>> +/*
>> + * Make __RT() and __STD() usable in combination with off_t related
>> + * services: the libc redirects them to their 64-bit variants in this
>> + * case, follow suit. Code implementing the native variants opts out,
>> + * as some libcs enforce 64-bit file offsets (e.g. uClibc-ng).
>> + */
>> +#define COBALT_DECL_OFF64(T, FN, FN_64, I)                                     \
>> +	extern T __REDIRECT_NTH(__STD(FN), I, __real_##FN_64);                 \
>> +	extern T __REDIRECT_NTH(__RT(FN), I, __cobalt_##FN_64);                \
>> +	extern T __REDIRECT_NTH(__WRAP(FN), I, __wrap_##FN_64)
>> +#else
>> +#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>> +#endif
>> +
>>  /*
>>   *   * Each "foo" Cobalt routine shadowing a POSIX service may be
>> diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
>> index d30b1722d..bf8772f6a 100644
>> --- a/lib/cobalt/mmap.c
>> +++ b/lib/cobalt/mmap.c
>> @@ -18,6 +18,12 @@
>>    USA.
>>   */
>>  
>> +/*
>> + * We implement mmap() for the native off_t next to mmap64(): keep their
>> + * names apart, even if the libc enforces 64-bit file offsets.
>> + */
>> +#define __COBALT_NO_OFF64_REDIRECT__
>> +
>>  #include <sys/mman.h>
>>  #include <rtdm/rtdm.h>
>>  #include <cobalt/uapi/syscall.h>
>>
>>
>> I challenged it why we need that __COBALT_NO_OFF64_REDIRECT__:
>>
>> "Why the time64 pattern doesn't carry over
>>
>> - __USE_TIME_BITS64 && __TIMESIZE == 32 works without a marker because
>>   the native-time_t implementations are compiled with -U_TIME_BITS, so
>>   the condition is false in exactly those files.
>> - With glibc, the same works for mmap.c, which is built with
>>   -U_FILE_OFFSET_BITS. The counterpart of __TIMESIZE == 32 is
>>   !defined(__OFF_T_MATCHES_OFF64_T), which glibc and uClibc-ng define
>>   when off_t is 64-bit anyway.
>> - uClibc-ng 1.0.58 and later always define __USE_FILE_OFFSET64, so
>>   -U_FILE_OFFSET_BITS has no effect. On 32-bit targets
>>   __OFF_T_MATCHES_OFF64_T isn't defined, so the property test is true
>>   inside mmap.c as well. That brings back "__wrap_mmap aliased to
>>   undefined symbol __cobalt_mmap". Only an explicit opt-out by the file
>>   that implements both variants avoids it."
>>
>> Jan
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>  
> Hi Jan,
> 
> I had a hard time making your patch apply to my tree and build (it came a little bit garbled in the message).
> Anyway, I ended up succeeding. It works. However, to make it build correctly, I slight modification is required in [1].
> So for the records, I paste below the mix of both patches, the one that actually build and work.
> 

I suppose your problems relate to backporting the patch from next to
3.3, right? Because it applied and was testing on next IIRC.

Anyway, let me send it out properly. Once it's validated over
next/master, we can also backport what is needed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
