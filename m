Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A725C802
	for <xenomai@lists.linux.dev>; Wed, 25 Jun 2025 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851882; cv=fail; b=WmpljrLSPiYI6s57QOOmO2UCIDcHbi5aqu8IVZhvV6hbgpbGQJTUA+fTm0dpNg051X4+q1mBbke6bXbEegoK70b4fipZT22U2J6De3Bu9H+ddaVgatz6js56ZoQAUrAQFHSmchYI6vlw09ZpsrWiClsi9eaPlAkN/wK4aYti0V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851882; c=relaxed/simple;
	bh=beAtiX1nqQfhqG0UhwnnbMmw58J1Q3ZzvxBZJiI156o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OcgxxgdkzjpEUDNfndrzojUHBKNHCvKhW1exTPQ/hirr65CDjiNaj7hF1KZcOCrJvMUIx/CpivJTi3aR7h5J1POCJRPVw4BZUIAJJDL8vkYOo1w+I3OMOL27ZRcibZTVKTGbdjGzRmGSuRUU5fXfGzqGdDO2DO9juXFiEWIxt70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ptZdNTSW; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ptZdNTSW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADILNMPtBqRV/R6cnmszFcWXIEgRG+CGfPkzDI0ZcNGEJOiS8ZY2gccqNIopn1y8mFTDMZmpWHoL9Y7Aq2kCzd3J+iMSo4SYvKSzT0DF7PsjYGFMqgHqfuRrCzCX1E9YXhM5I0BJwEE8HpwmhN4EV3Zshhob13w+loZBGDIgoIIJDVscXi0jd2y1phwcKw/jqwsFcW9XydS0eKfipopW5IqXUlcJLEkfW34T6321q73nkH5e5JiRkPbTauL1Pno9SuMs9D3yT99MYpzasraEtqosPVG5Mjerl8L6jfbazZMpekHdidZAPyMqBlumz6rn8cGEPaxHtXLXgB6Z7+xHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb4LJ6FjdFBZLnQPpXSmcJ0XVKjKd/VPnPUkVNomeRs=;
 b=dxIvE+7mYVEDFrYUqWwR44tPxmoHU/23luMAr2D8+DGwK/SeYUyU1PcE28p986SNHfvloMjYFCy0tDkVll5tRyap7CLZbDZks1bT5mvh0mqfF2dwF2DzQLqgGYTNsPBmBUdNVVbH1NDzEVB8x9yWuLNeLMdKem+Yec2mBhIgSUbmQUWnqdF17LreTzRxbGA3NEcygV51hh7yQ8rsmkXnatOPqNAajD70lCUs226JrTHEIsuwzuHKbsEZ1jsNN+KPxjk0qgnb4TC15FM4XOCm0af1hMKzLrQHSQcOR+T5OP40pcVGRs0cTqg1WULN1Ur1HTsBGpqLf2XxN9HpP2hwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb4LJ6FjdFBZLnQPpXSmcJ0XVKjKd/VPnPUkVNomeRs=;
 b=ptZdNTSW8rFJM1ValNFMBQY7GZ3P6ytlDgyUq6gTx1f6DoDg4g6DtjR7Y4STO3hJyDeStE9nQg0qgCt7rKRECX6JgkZPLYTuJV0XfdTi+QUY2ESqY3bY/MumJdbsjfTKQY/gZT1g18BzQLXyuk6tiuJW1j8AtDxPt47TDUz621gV5nnVDtCvN8U+tkuywj+Mz7geeup2dR23jDVdN4U0BeyNOUiQ+wH/VpGurjv0ZhsPdoqeKgXVTONk3cCw7BO8Fg6m+EeoauYpjU7Qo6j9nHIbuX4lrpQzD//Kc56iaNWvCXtFOHfTe+fHzITJxRjODLgNm3pxIIBw5nIg/uUYTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8282.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:388::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 11:44:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:44:36 +0000
Message-ID: <12e8936a-edf5-4d99-8c6b-79cf1bfdf70a@siemens.com>
Date: Wed, 25 Jun 2025 13:44:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: dovetail: Use appropriate EOI on error interrupts
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@lists.linux.dev>
References: <3cf01441-93e6-4004-a9e5-5183eb6740de@siemens.com>
 <4de91ab049a550d6715517da2cb240750cf839a4.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4de91ab049a550d6715517da2cb240750cf839a4.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: f18984b5-0076-402f-6f63-08ddb3dda91e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHlUNHBFQ3ZyWmlQL1ZXU2U4WElKQ01WbStESlVURU9pMDRyYjg3ZkJUeGR6?=
 =?utf-8?B?M2ZBN2VCT2NzQnRDR2pzMktaMFBTVXFWTllOeTd1aHF3OEFvNjl1RWF0YkRH?=
 =?utf-8?B?Ykx2d09SNkNURDZzc1JtV3VxM0lzakZIa3NlNlRZTXFBYkpiVWVlbXZmdno5?=
 =?utf-8?B?TVZjalI1Y3dGV1lETjA1bUJrRnhqOVBDU0l4bFlMaWxyb2dGcFFHbGFNS0gr?=
 =?utf-8?B?ekJVYUo4OE10SXlPd3ZLelY0YnVTZVJ1Q0xRWmREa0tTZkdOZXFKcVA0cFpH?=
 =?utf-8?B?ZlNKc041WVFtWmNqOXpHZzVUUW12di85eGcxYzJEN3NBcXJBUVlObkdNSlJZ?=
 =?utf-8?B?ZDlQTCtVZGFmQnlTSEIva1JOTDNCTWRNSDl4d1FXdUtoeHFrMWc4L2lLRTZq?=
 =?utf-8?B?c0txcDBPeUtoTzllNmdjK2llcjRNV0xCOWpOek5yM2FITE81YXovRjRxdWM4?=
 =?utf-8?B?cXhqYzdiMXNkbEhXSkdSRDlmdjBzdTFvVVBBK1czMEpKTzNOS2s4MC9yTUNX?=
 =?utf-8?B?RkU3cGdnMWl0eW5RY3g2NTRhWXRaMHNzZmZwQjZreHBwZFlDVDVqb25aVm9Z?=
 =?utf-8?B?MXpkcm5oYzJWbi9IRDRrQld5U3gwMXJEdCtDRHg2OFh1Qm5IZUw4Z0hIL0Ro?=
 =?utf-8?B?YWxZaXFYZmRyMGVEcktWQUhFd29BSXFacXRVUE5HMHZxS1hXU3B6em01SWFN?=
 =?utf-8?B?UzZUbDk2WDBiNVlaL0wwMGc4dHpRQW0vQmduVFN5OUhjdXNTYi9rYldTUUJp?=
 =?utf-8?B?a2d5OE03UU4rRTN4UU8zR21WVkxiaU02dkNELzJMVTkvNzY3ZC9IVDJrbVNS?=
 =?utf-8?B?LzJiUDNYbG9ETWxDNDI5eWR2QlVOUjYwZXdrdVdrclIwMzRUb1lmWmRTMFV3?=
 =?utf-8?B?MnpNRG1BU2lZQ0ptMCtEZ2dwSjliWUNnbXZNQVdVeFFrOWtIREg0cGxhVG41?=
 =?utf-8?B?VlRaSVN0d0VzZTBScTdBODkzdmVoM0x3eDVscnRaejVKQ25IbGg2QlJ1T2tX?=
 =?utf-8?B?d3p1UDl0SGloUmhnM0o1aDkydEVaM3g5NHBraWVYK3Q2aDE0dTBkQi9rTVRV?=
 =?utf-8?B?ZVdVd2RFcDEzUVAza1dMMFR1bEJOQlV5MVRPTGYwYUE3ckdNZ2V4czgxb3pt?=
 =?utf-8?B?Ri8rVDJEUzIyQmRNUWVyTHZBajQ4cC83OGVtejVpNWNkUE5RY2dTL2JsNDAy?=
 =?utf-8?B?eGs1cHRxckppVlQ2SUJzOXFBckxiK1VBS1l4RUVCZ3BsU01PNXp3cG0xOWZG?=
 =?utf-8?B?TlQ5Vy9tc0hsVS9ialYrZVd0T3hTUVkwdDBoRzlnSk5WVmp5V2oweDhOR3VY?=
 =?utf-8?B?YmMzaVNPeGhNMGxpTWZEeVQyd0FTWlUyOTc3cVdDRC9qK3ZRZy9JNGpldysy?=
 =?utf-8?B?WDdQSUIzYm5YMFgvVzN4cTZINTFwc3Jja0RHaTNNeTF6aS9XdmlyQWlnaDU2?=
 =?utf-8?B?dXVIWVZncGhuTHFSY3BybFRIdGhuRldRa1ZWQ0o0Z3JNYlZNbm5wOUlzai9Q?=
 =?utf-8?B?SmVVRjZsSmxLbVVwekVmaGJPVG1xRXVkZlloUk1zT2hVV1ZRYW9IaGlVVXZR?=
 =?utf-8?B?aThFMUVjeFN4SVpGMW9jNGQwMUZTSUFGYWZDZGU4akNNQ1VSWUNkSVNVakVj?=
 =?utf-8?B?M2ZYOXRQZWdQOUlLSFdPekJ2bjMyU0NNcytZZUtpSm0za0tjYVRxeVU4TERD?=
 =?utf-8?B?Tk9mK3BaQnowcEdjU3hXSkxqZWNjKzZyem9ablRZaUo3SEdmK2VVR1pyWGRT?=
 =?utf-8?B?WU50MzNvb0I5QXZKSEpUY2FrTThVQmlPUjVITC84c1QvUE1PbTZYUGZOWkJa?=
 =?utf-8?B?dFdFbVovVDVCM0U1Z2U0NnBxK3BGSEhjbEF3eHR5c2tRYk5sQmo5Y1dCM2N5?=
 =?utf-8?B?bkdtSnRHS2FHWlAvU3FwbG9YckZRcEFoT04wSzNzRjZCR3A1V280akthY3c5?=
 =?utf-8?Q?Ww44fXMDXiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1NKY1JLWGFmWDUyZjRYdkxtRDNrd0Y0RndJZnhSTWExdkJnS3V6cFdmeVVr?=
 =?utf-8?B?cWJZc1J6Z3ZBUDZmaVRoM0xFRXc1eWU3Z0xQamhTTkNVSUNxUHVjRUVBdysw?=
 =?utf-8?B?VXlCR1NWeDcxWVQxMUJXSXJhb3BrWVB3VGRlaXdYQTFuUytXeFQxcnd3SnJC?=
 =?utf-8?B?VkFlSU5JSW8wM09GRjlOdnRwbFVXMVVybEhsSEZET1JsQ2V2Uy9kaXY5ODUy?=
 =?utf-8?B?MC9LMTlhRDVWRy82MjF0ZzF5R0Z2NkRpV25LZDdmUWpkY2JyRlZtbklRbkVv?=
 =?utf-8?B?RW10L1J5ZjVvZWpkSm9MVkxub2VvNlZ2QmRWODJtQWFHcXY4eGdMN0FQVXU2?=
 =?utf-8?B?R2htcWw0c3I5dVMzclY4bEhwSk1WODAyQ0hqdGdtS1R0emI3b0NiS3k5OHMr?=
 =?utf-8?B?eTAzMmU3WkJubk5iK2haUkxjVW1haWQ0OEZhVW5GMGkrR3hjRmQvbVVCbG1t?=
 =?utf-8?B?eXV5aDRVRm53anBMdGNqb052amUyaDNHeG9wSGNBdWtSVzU4US9nY1pGUENH?=
 =?utf-8?B?WGs2RE40enJBd0pORjV6WHowSzlIQk9EQWNEUlVEVExBd1pzN1FXSUJWWjFo?=
 =?utf-8?B?QUQ1UjYzd1RDVVNtVHhubG02MGVRYXA2YThMaTBsT0xLZElVR1VZY3VlcUlo?=
 =?utf-8?B?OW1vRkR1eGpNZ2FsZ3NsUG1PS1NwSVNQL2pYRkN6em02MkFQNHIvb2JneE1v?=
 =?utf-8?B?SlppZUN0eWVpTXFCOWYwdlhrQ2lUM0VSV01ydFltQUhrakdod1FabUxEZk44?=
 =?utf-8?B?cHhncmdGVllXRnRmNzFUQ2MvemVZSkhVUzVFay8rS0dHZjdHVU5RWlpQcUJy?=
 =?utf-8?B?UkFtaUlCWUhiWFdYZWQrZFJuNFU2b1RQMHhGRncvaTFxZHFxZkt4dWplbWlt?=
 =?utf-8?B?MFFyakZIeklaN1F0N0FjckMya1prYU5DQ2RtN1d0Z3krdUtBOUJKM1ZhcmlH?=
 =?utf-8?B?c0hJaVlONEZDUVNPSFB5R2dFWHpSMmVaY2hHd1NGd0ZRQnlqUEl4U2Y1TXp1?=
 =?utf-8?B?ci9qMmpXaFJRbnUvUnVPejhZUExOUWM2NEhYTmdvdDRtRDZWUmFGWkRUWTFI?=
 =?utf-8?B?SE1yKzJmalJUbEtFcmkwVDI5aVBkMmZ1RzNDcG54Q2xQN01TUFpqVHlEVWdL?=
 =?utf-8?B?b3QzVUVZamxlMlZvSU5nQUN3MC9nek01RU1XNzY1VzFIMnB2cUhYYkk5Tjdl?=
 =?utf-8?B?ZnRDZVA1eGNsSGFqWTRhZDBOY3FnZ2JOUFJ4WkZZNHcxOEZDTS8rMVlsYzRQ?=
 =?utf-8?B?QTF0WHZyVE40Mll2TTZIR2JtQjhmT01zTVZwZnROQTcwNU5IeDFEU1k1QjhN?=
 =?utf-8?B?ckZkWE40WWVUempibUU0UUI0SjNrSmVCYmt6T3pwUDhZaC9Rd2VleE1jUjNP?=
 =?utf-8?B?eG9KcFlwRFVJZjlzUExhOFlWTEVKSDlkOVQyK2xtSGc3WkUwNWgwdkpPeXJB?=
 =?utf-8?B?ZlorenhIajRrSWhTeE94bnZhVW4yY0F0c3UyZFVoWXcyS2JDNmhJSkxDaEU0?=
 =?utf-8?B?SDVtVlI4VG84TE9EWWFGTXV4RmF6STJrQjhHVmF5YXF5WXAyeTZkdWQ3eHFv?=
 =?utf-8?B?TUdZUmc0c21pRGJRU0pvdGQyMFVvSGw3clF1dVpXcHcrd01uQ2ZPcEVTaHNw?=
 =?utf-8?B?NmxDc3FYRXlkUllKcHYxWHZHRDlpNnFsb0VnQ2hyWkdFeGk4WUFlSTJrREVI?=
 =?utf-8?B?TW5scktmVDl6c3huWGN6RTg0NjJOaGo0bUZRcW5GcHFWelB0Z2F3ZjFxQnlk?=
 =?utf-8?B?WC90WWRaaGloK1Y1QXMrcDNpWGtEWGU5MkYyMlFSOENTV05XNUtyVjVRbWJC?=
 =?utf-8?B?bmJ3VnFldC9lTmJobUNadmRCYURKbXh3MTN1NDlzSkEya1lCZm5PR1ZtcDd4?=
 =?utf-8?B?SEJNQkJMLzlqVTZ5cnRmYWZkcjlzZjlpME5GNzhKZzUrZTdFd09GY3B2cXFJ?=
 =?utf-8?B?R00vaGRsUURSSG9DMzlqZ0VMOVBURXBuTVk2ZnBBNEg0TUtCVDFVRnhQVlJ4?=
 =?utf-8?B?T0lOVHF2Z0ZSYm02Vy9hSytxRzdzbVlaL01PdVZOSWZvTzV0cjJaMVNWNnQx?=
 =?utf-8?B?bHhCT3liNzUwM1pMa2JCaWUzNGJvdURtNGxwZUJQNFdvbHpmeVY4ei9CQXVR?=
 =?utf-8?Q?ID4vhA8r/HCF9+CM+4TWFq5iI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18984b5-0076-402f-6f63-08ddb3dda91e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 11:44:36.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLmggzMQ921/6gRg54tMvRwlWD4rYmGcWjc/vcxl/311vwFuHvoBuxlx6ln7bVK/LyOCA+OzFGvQ9U5ELbCxTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8282

On 25.06.25 13:16, Florian Bezdeka wrote:
> On Wed, 2025-06-25 at 10:16 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Just like for the non-pipelined spurious interrupt, we need to invoke
>> the non-pipelined __apic_eoi while handling error interrupts. Otherwise,
>> the local APIC will stop receiving further interrupts, and the system
>> will stall.
>>
>> Given that it takes very special conditions to actually trigger an error
>> interrupt, this issue was very likely not relevant for most deployments.
> 
> On which hardware is that happening? Asking because of 
> 
> /*
>  * This interrupt should never happen with our APIC/SMP architecture
>  */
> 
> infront of the function...
> 

The user was very likely confronted with two errors at once: This one
here, causing the visible problem of getting no more interrupts and the
actual root cause of receiving an illegal IRQ vector on some core. The
latter was most probably caused by the special software deployment there
(half virtualization, half co-operative AMP).

> In addition we should properly check which branches are affected.
> apic_eoi() vs. ack_APIC_irq() (in 5.10), 
> 

Yes, it's going down to 5.10 at least (where it is about
__ack_APIC_irq). We have seen it with 5.10 in fact.

Jan

>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/x86/kernel/apic/apic.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index 1cd5f59f7962f..278e28c5290d3 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -2217,7 +2217,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
>>  	if (lapic_get_maxlvt() > 3)	/* Due to the Pentium erratum 3AP. */
>>  		apic_write(APIC_ESR, 0);
>>  	v = apic_read(APIC_ESR);
>> -	apic_eoi();
>> +	__apic_eoi();
>>  	atomic_inc(&irq_err_count);
>>  
>>  	apic_pr_debug("APIC error on CPU%d: %02x", smp_processor_id(), v);
>> -- 
>> 2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
