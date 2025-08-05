Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD71E5B78
	for <xenomai@lists.linux.dev>; Tue,  5 Aug 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391414; cv=fail; b=u5c5ES9d3HF8x9UOBH6aLyL0SFo+5c+iSQon8igkuz6YygurSlCzq4sQyMvVRKoPiA2V9xbXGQ7u0My4XrPo4xV92RfnqsuoW+nWnkg/lnq1Oal78mN5mI1LkjYrx0b+R98t9rrcIq7SlGvoGOq4athfuZKCvjhpapqf0tIe9So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391414; c=relaxed/simple;
	bh=WMc3mB7p8f+gYWnJrNSA0e39EFIJ+JIWuEXZdnaH6SU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KNlDFsP7ZNFzagZgielrrcVHAZ6FcG+D5f8vr7ua+yVaFjbH1WLJoRJRwsU2lYBJcrSlWTLS6qqFBSuAKH7crUfUkt7v7oNIezEqs/X/37ylr+Jk0uczzW+T1mqXw+Hn1kNv6SxRbuHP56WZ8NIosUv6V+NRCZamkOay/E4mtvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Kn/crbHi; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Kn/crbHi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbRXUW9ShuPsn67qIVR2xX3tq0FtiZp5o58BD8QekBfGzznNBkv3ae761q3bXdWjXOPrujpinZiKqdAd5q0y3Iq68NRuvy3DmVrzEjkaj8MA9LqbH9eZxNILn/c9A02mAHO/2YGp9DGO64k5HgbcRZRzn684+LR4mG6cvtrJPUTSsbGVALRXUvY612HFHlabXaGuEB+8rkVu/YDyIwJcUcJjrNdVtc15eEEWFLLGfbVO9zfu+zng57AV2vMv9Ab/dqZHDpO3l9nVC0xyQEDi3yAw30/5ABE7JWcTPBMS1ZhGUchTouhDiv6VgRI18iNv+sSqL23hNrLZfSDpCKfxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3kG4Ro6qmFh96b/2kVsiapoVg8kXY7xWdo3FjtB3l8=;
 b=FW6Tsgu2Nho2b2MNF6b+fHNceBqcnsPvm0QQxeGH6Tbkyt7AxeTi8xsNwozV1I215H6KuFDSXbcnkC0rRcJR3Ef+ahBeSewISTw7ZkI1Qwy+XSU5fEVxBPU32YqCmumOhaM6qOg4uj2ycqSYUqQRPJqLSZhihDhVbAST5VcPxkd19p/nNXAzrZhKdl4S5BXHnr7KtcVCGRPx8Mi3hDZcWCu57sGPhHf9kROicyd1cPBoJGpmMNkiZ25VTlObxuPksdWdL9hHrWrzqLMce5bBVBozemdGHdqSW/mxvd6f3vHDKOJpJBkyuc3Tzn+CP0dZqcLEsVKHXFLMPgwhTynBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3kG4Ro6qmFh96b/2kVsiapoVg8kXY7xWdo3FjtB3l8=;
 b=Kn/crbHiiwHH0TiajfJv2DkQxM5KTxwqCW0VNBJQXPrvpaQhSljmCofnRrvA0kZm2e4E+/B/GSbTE1gHklU0im/4ttuTZUNkJkJXVzXr3l6/yRtnq3a7iEQ54Za0grdmx9mytWjDcR1eVsEM1wNYUaNGr0/p+VS+UgjP5OzKwu8FBEgeRMJ9dnjWUNBwJ8C7a7c3nhDd6rdUhTByoCbUrm52pYrS+TWXEdHCEP7aF8I4QLauaJavlHHJe8ddHuZAag0wPh+/VxJ5pTCTOl+1xiM0mnPCrZz4AmxMBWQ4opqdecUx+5qWND/RGcYQuygg9kyMmv65SCRYk8kVXpTDeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:506::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Tue, 5 Aug
 2025 10:56:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 10:56:49 +0000
Message-ID: <fbdc183f-122a-4445-8f1f-9ea91e6e4aed@siemens.com>
Date: Tue, 5 Aug 2025 12:56:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: compile error
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 Xenomai <xenomai@lists.linux.dev>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.7c286a69.cd5e.495d.9c9c.dd0849b27801@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.7c286a69.cd5e.495d.9c9c.dd0849b27801@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfe9ba5-c70f-4e7a-b02e-08ddd40ec704
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2pUVVFIZ0FrM3Zhbkg4WGlxK1Nmc09jaVJHQlc0UjludmdJejk4eDFIRjYv?=
 =?utf-8?B?ZFl4R3ZQK3lLcFR4cjJCOEhFODJEZms0Zm1vTWF1WFRzUXhUT0RDcmd5NW5P?=
 =?utf-8?B?NjA3Qm0zNm1wUXJmK0FTRDJWRFFmOUZnVk11eHVFZVEwZTVEaFB2T0hiSFpK?=
 =?utf-8?B?aWlsbGV4TzhmMXFsaSt0b3Y4QTFBd0E0UURvV0xHTEdMNzVCaythVElaOWZC?=
 =?utf-8?B?SHRYTEVHalg3dG1HdmhCUnBEZzNmb0hhanM5NDh2dWFSTlFOTHloSllQQ2I4?=
 =?utf-8?B?aVNkTGtyQXdDMDZneHZwZUJXb25oRVdZcjJGNEQ0OHNsaGZmaUJBNjlTSi9C?=
 =?utf-8?B?b3V3UEhJK082bDBVNmJpUDBTczBQN0NiVDg4Nkhka0tkckh1U0hOdWoyV2Q1?=
 =?utf-8?B?eDVOcnYzVGJsOVJFc3BTVzJ2QlFieTBONVlkaHAyUXo2T3ZLYzBJdnlwN1Y4?=
 =?utf-8?B?NnAwb09ZZ3VaSUtrVEI2MGtsVFJBMlhxcEkrdko5QnhyQ3ZPMUtocU9nZGU4?=
 =?utf-8?B?c2daRXlKcktSQks1NHhYS25vRTNEeXNFWStNUWhWRENNQVRQMDRTcTNqelNk?=
 =?utf-8?B?cUpYdStHNkVlb1hzZlY5Ym1hanRGSmg4RDBnRzlpYjczYmdaaWk5WG9pWWda?=
 =?utf-8?B?NTl2bjNndjViQWJ1Y1o3YmRJQklndjkvWDdPSGtleC9zb2U4TmRYSnp6dUhu?=
 =?utf-8?B?c0lhWUtYM3ZmWXNZV2hHTHlNS29WRGJNbkRtQUpxNmV1TkNTcTNkcC83UHYz?=
 =?utf-8?B?ZjRObFYzT2t2OC9OT05ETEtSVkh3N1VhY0prQ1FJVlBpZEJ2VUp4T2JmMjZ0?=
 =?utf-8?B?eFFDOG5YLzJCZysvMlFqNVE5czZQRm1Yb1M0VEc2UG55clJEVlNUc096UVUv?=
 =?utf-8?B?aVE4dXI0VmpQTjNQazQyRVQ4VHZ5VXc1Y2pBQVNLclhaeFNQUXV5SGRwNGtu?=
 =?utf-8?B?MWZaOFcxb2Rhc09rY25wUXlCWnc4dTJZd0hDcEtvSDI4L0xONDZiYnZHYnVX?=
 =?utf-8?B?QXMwTFpzRDdGTzU3VktMNmljL0VubEhJTHMvSjd0QXdYMTJ3eDN1bjJOZzAz?=
 =?utf-8?B?cGZYNVk1aWh5L3JFWjNMWGE5YkJtL2F6Syt2alI0b0NvakdZbDJZQWdBWTZG?=
 =?utf-8?B?Wm54b1hpN0JVL2EyL3dRYWhsd1FhREJUbW81RVRlWnBZUWlKUHdJcC9qS3RE?=
 =?utf-8?B?M0xLZFVPbnQ5djQzckZmcGZ2OXlBcFNyNGpvYWYyM3dSdkhXSGJ0OUNGVW1l?=
 =?utf-8?B?Rk82eCt5d0JnRlVKQTJLVVBmaGR0Q3plMWIraHBNdWdFWnYyQml5czZxNktp?=
 =?utf-8?B?c05lSk5XVjJFOXY4dG1sMDM0NDFkTjNrVWR3Nm5YTXR4MmRVQm92cUhTMmoy?=
 =?utf-8?B?RWt4ZVorckJMNHplMTJ6OWkxVTd0SURzdkI2bnJBQ3pEZ09lOGJTeTRORGd6?=
 =?utf-8?B?aUdmbGwvNjBPYlE4YjVDaENScnAxY2FveGJ2bnJQU2owM0QxRUluYm1xb1Q0?=
 =?utf-8?B?TUtHdmtRZG5BZkhvc1RBRlZVU1d2TEV3L3pTOENPY1VwQzNqb3Z4UU9rblhS?=
 =?utf-8?B?ZG1sVzY0Qm5yWlZhdTRuVzI3VXkva0dLS21GY2FhRVJRR2diTmlCd1JZRlZL?=
 =?utf-8?B?TStLUDFEdERNRDRzVmVKODJ6Y21zMDAvVmppaEFUb21GOENGa1N4eGlITVZ2?=
 =?utf-8?B?RnFlQzYrVDdRSnJwSW1xYXgwc2NuakluYjdmWDNDdUJHTm1HU0h0NStZRW8v?=
 =?utf-8?B?U2pDYXFNZFpiR1Bza0gzemVFd0RDaCtPQ2JpQWtoTnU2a2NFNTRiT2VxM0lR?=
 =?utf-8?B?QUNkbmRvS1dWRk5CTmM2bVlOMkVKZk1aK2lGTHYvcTMvL1FSanU5M2t1Qjc4?=
 =?utf-8?B?cjJ5UEhCdk1pSGE4ekdUZE5LQVNwc0NTNFo4UzJmOUloaWQwbHh1MkVrYys5?=
 =?utf-8?Q?1d+q49R/LX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXVQZ293SlcwVHcrRHNIQjNOck42UU5aQ2poWktRckx5dDJiSnJRck5lV3JH?=
 =?utf-8?B?VjVVdjNycmZJTEN4VU5XeGd1c1RHQ2pPYXN2SUpVdUgybk9xdDJQL1A2aTlp?=
 =?utf-8?B?Ylp0K1FjeGVWQnJGbVRrYXkxdDBFMjdJT3ZGYmdScHUzb2NTQmhzNGk2MDRq?=
 =?utf-8?B?d0d6REo0SVVyUXVlT3lHTW90U0R2NjdERFdCL2Y4RTUvUVlPUzNjYjdxb1FU?=
 =?utf-8?B?OWszSEN4ZnlUeC9SeXZsV01wTkQrQ0gxNWJ3VTJqOGYvS3hnczFnOXJsZjd4?=
 =?utf-8?B?SjhFMmhFYUdGNHVpVEx0TXJLUHhpcU00Q1pQc0ZWd0lUTDNRNHEzS1N0NGM5?=
 =?utf-8?B?aDVxUk1oR01qaEEwY28xeUJOWWdsSWFMN0xWeHV6RGZaa1NGV2lkWUlubzI5?=
 =?utf-8?B?eE96WEdOWmxlZ2JXMm1NRE82TzhSNjIvYlNtSE9CSnNzdmZGQ25sTFJhTUl1?=
 =?utf-8?B?YlltYXc0dUx1akNZN0NwYlkrS2JKWDBBMVcvamZkTjFBcnIrTEE1Vi9PRktZ?=
 =?utf-8?B?RGthNU92dTRWa28yS2ZwNmZINFdXNU4xQkVDOW81cmJyNjMwcTByRnhTckFW?=
 =?utf-8?B?bTdYSEtLRWFBQ1ZFdDBBMWFTanNpWE9ZWHJ5Y1BZejcyQW9qOTdKT0FsK0tN?=
 =?utf-8?B?R3JSSjcwQ0VWZi9mY1NBWkFWVUlUem93cDRVNGxPeXQzYjFucE91MU8xKzJt?=
 =?utf-8?B?MDJrRWM4YkxtUzA0OUhmN09ZdzFXNUx3N0NXU29DcGJRYjF3YmJsbUpQN3pU?=
 =?utf-8?B?MkJTdlJqeTNmbEV4YTJZNWE3ODl5V2hGSE5henU3b296QzZCQ3NoMjBZWW0x?=
 =?utf-8?B?a0x2UnY1Q0dMWlRqU252L3NwdHFXS3lrQ0dPN2tmWHAxd3lWTGhxUjlEOVNh?=
 =?utf-8?B?UUFHczRibEFKZjIxY2xFQ0dxa0x4N05NSTdoMFRRanV5VExkSEgxbHBKVGZB?=
 =?utf-8?B?R2lIaTRwWk9oT0dWclM3eFJNc20yZ1owZHV6WVdwOHlkaXpSSXRpWW15b0pj?=
 =?utf-8?B?UnBwb3l4UGZuVjd3UWhwRi9jdnZKQzZZU2hROEM2ckRjWGlRczdteGpaWmhi?=
 =?utf-8?B?ZG9seGJUNjRjY2trS0YrVDQzNTBlWUZ1eDFYeG5jYlZGYlNETGRWSGNNblRh?=
 =?utf-8?B?YTl1VUx4M1JpRmNNZXF4c2orQkVYT1hVWHlsdkFzYlRJaVdaYlVtRzVicTZB?=
 =?utf-8?B?Qk9ncHFpZDhVTFBCZFJCZGEvVUhvT0g5cmpuS21GV3dHUTlMcnhOc21DYVJQ?=
 =?utf-8?B?YW4yWUw2Njk1VE1xVWg5ajBSL2ZwY1dGN1JzNFNLSW5kRFZESWpGNWJ0UVdB?=
 =?utf-8?B?eHF5dTI3Q3FXNXNqdUVCaUNDSzJZcGk3TjRqNVZWSU11NmtoYTBCZDBaaWFz?=
 =?utf-8?B?cU85b3h2NDh5VkZkY1lnR0kyOWh0V0EvTE9OczZJdGd5RzRmOTZPaVdnTW1q?=
 =?utf-8?B?QldIWk9ZUTNvS2Uwcm1GcEg1R1Rvc2VmWGRSUG1ReGZlV3VnSzhwVkhQSFho?=
 =?utf-8?B?UjFtTXhlbmJGRmZqZHIvQzNDdlhaRUE4RFhINTRFblJxcmVQcWl1WG5YODll?=
 =?utf-8?B?TG5YS09GL3ZjblBvbnVsNStWaGZLZVpCaXYvaE5TN2FVZXZxOXBNRFQzMS9G?=
 =?utf-8?B?RWNyVlV3MENxNS82Y3ZGQUlLUE5lMzJ0Wkp0c1kxZE9OVzFkdzZ4VFFDQ1hY?=
 =?utf-8?B?WkVYeTVpZTBuWnRwNXBCclBLL3lOWEdYbkIxTThWQlJqUHhWM3VUV0dMSEFC?=
 =?utf-8?B?eTBGYitsSzlkazVUdFRPK1NJTTNwQmg3OURJNFJyeDJFdmtLcS9SMVAybVV5?=
 =?utf-8?B?R2RRNStFM2tFb3k4dUtyWW10eHdwTlJLc1JDdGJPbUJYUFlWL053T2s4OUdN?=
 =?utf-8?B?VWV3ODVTellCMElZRStGMFM0N0pLQVNBc3d3b1BpalNCMHZqVU9qUnAyMWJP?=
 =?utf-8?B?MVl3czkxNnROdnNsQ0lCZVF0RjJ6S3lqSk1FKy95MUlUUXJuSitiVnlxRzlw?=
 =?utf-8?B?OVBkM0luV3JEUGJXUVZqVWIxV09BQUpNRmlLc21MVUFQbVloTnFOTTl3MUFh?=
 =?utf-8?B?VFBVNUdrek1pbWVjMzZGRzhMMzE1WWVGdzB0ME5IbzZ3QnR4ZFJLTGxvOEl5?=
 =?utf-8?B?YS82RmpZb0phY1NBQm1SZ3l3Mm44bUxTMVhMTStnVEdmZ1NvQ0J0c21SRjhi?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfe9ba5-c70f-4e7a-b02e-08ddd40ec704
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:56:49.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pc2EpgQVYANb2kx+A0VqQwaUTKL+wtt30AQknHt2tBY5+q0/xSxXsRSJ7nU9gFvg1OjKsKxwvhWexZ1sqVww0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5799

On 05.08.25 04:39, 刘杨 wrote:
> Hi xenomai：
> My compilation environment:  kernel 5.15.51   xenomai:  3.3.1  platform: x86_64    gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04)
> When i enable CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG, I compilation failed.  The error log is below. 
> #####################################################################
>   CC [M]  drivers/xenomai/net/stack/rtcfg/rtcfg_event.o
> In file included from ./include/linux/printk.h:582,
>                  from ./include/linux/kernel.h:19,
>                  from drivers/xenomai/net/stack/rtcfg/rtcfg_event.c:25:
> drivers/xenomai/net/stack/rtcfg/rtcfg_event.c: In function ‘rtcfg_do_main_event’:
> ./include/linux/dynamic_debug.h:131:49: error: expected expression before ‘do’
>   131 | #define __dynamic_func_call(id, fmt, func, ...) do {    \
>       |                                                 ^~
> ./include/linux/dynamic_debug.h:152:9: note: in expansion of macro ‘__dynamic_func_call’
>   152 |         __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:162:9: note: in expansion of macro ‘_dynamic_func_call’
>   162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>       |         ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:597:9: note: in expansion of macro ‘dynamic_pr_debug’
>   597 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~
> ./drivers/xenomai/net/stack/include/rtcfg/rtcfg.h:45:33: note: in expansion of macro ‘pr_debug’
>    45 |         (rtcfg_debug >= (n)) ? (pr_debug(fmt, ##__VA_ARGS__)) : 0
>       |                                 ^~~~~~~~
> drivers/xenomai/net/stack/rtcfg/rtcfg_event.c:107:9: note: in expansion of macro ‘RTCFG_DEBUG’
>   107 |         RTCFG_DEBUG(3, "RTcfg: %s() rtdev=%d, event=%s, state=%s\n",
> 
> I made the following changes and compiled successfully.
> diff --git a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> index eb9ad076e..7e480f792 100644
> --- a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> +++ b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> @@ -41,8 +41,11 @@ extern int rtcfg_debug;
>  /* use 0 for production, 1 for verification, >2 for debug */
>  #define RTCFG_DEFAULT_DEBUG_LEVEL 10
> 
> -#define RTCFG_DEBUG(n, fmt, ...)                                               \
> -       (rtcfg_debug >= (n)) ? (pr_debug(fmt, ##__VA_ARGS__)) : 0
> +#define RTCFG_DEBUG(n, fmt, args...) \
> +    do { \
> +        if (rtcfg_debug >= (n)) \
> +            pr_debug(fmt, ##args); \
> +    } while (0)
>  #else
>  #define RTCFG_DEBUG(n, fmt, ...)
>  #endif /* CONFIG_RTCFG_DEBUG */
> 
> Is my modification correct?
> Thanks.
> 

This looks good. Can you provide this as regular patch?

BTW, I just tried to find out from the original author why he once wrote 
it like this, but I claims he cannot remember this anymore. :D

https://sourceforge.net/p/rtnet/code/ci/52bf61fc20550158616d4ab8399ddf0155a5b795/

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
