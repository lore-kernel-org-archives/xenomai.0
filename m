Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795526097;
	b=5Lt1EwiXtLkeVsLosvzds4zfAxVXw5XfrXd3+VLPAeLSiSkBN79ErSiTqgRbL+tWJFam
	 Ffd8LHQ5j+wEUyzJlGveVa60MXsbhsjwxZtTyRlzcLSv8qzYxKf7pJ2koiVC99VjCKjQA
	 TgY+QpabWI7vT3Dun2cvHXwgjQbyScnAGM5Lq1OJc41gZKO9487uS6XPjF27PdAgRSIZO
	 Yzo1Wved2Gd8MuJ17CHB/pJAZ7S2dX/EyzkDqyJC43hMVXzlRwEn4RuT6N91T6zAkZiLe
	 XDiBZbi/Zt11njjVoys3shXZZv/+tco0DTylJYXXLiGmFUV0wJady5gPkD+/g3o2NaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526097;
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
	bh=QtDdeXPhdjjsJXDTJej2ukkJoOABps/U45vjTqZ/44k=;
	b=5H3ROwt2hlbLZ3REGw6DQXUWPCoa0H0FHVJoQQ0ZxlsUe1vmEVGPHKsUyg+oGZImSs8E
	 KFRRJIWcgJdNfVZUEOxU6t9fobCG3nOsGRKPIzgne3+5dhiC5Ujw3QeFUOeL+UwLA8T66
	 k+ltgkF6IOGSbaVajk42U7r2tojKR1zz8tnFwUjI4EmO/aWjZZsR1TeecEoZUyL4DoQAA
	 Z9/Uw/+9dREviYiv2ASUaEiBDVPaXUPhnTKy0BOB5Unn5FTOM2KW+ZvjrJdAXbMJCsJFe
	 fzqbc1sbRqGEmImyzpit65edTDzUBF4G6a4XbTX7WWrRWRR0awQnbsNO24FAyNIm+Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=kYHACkQ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.13
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DB606A326
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 13:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6DB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=kYHACkQ5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKdqYDWFIY4g8x/zDpJgtY+zk3OPFAXvo05vNnO5pwcaZoAXPCX7d9kRQXBK3RYxmZEGQSmH4CMnKC/J6MnJjFySSEwbLMl0a/PmVTNuvZ98MQ86FURoNU8iuQGoN5Z1kovzS7xpiMN21g6to7DgOQoiGwaJJtfDsmW1kbed7sqrkjduCYAcyixLeWpj28LmrZuaXE9j9fAZeKg+BGb3UcSWCRiPEkKvrKMjgjqaJOjKaG4HCX8kA1qshLIGv+1vifZX321P7keJ47BrQe/S3j0FOK8ThSEicaKdXCcq3fCiwiJhtnaijeIvefvB0G8mztEEDgn8tw6vtWhSlGOJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtDdeXPhdjjsJXDTJej2ukkJoOABps/U45vjTqZ/44k=;
 b=JfAvMuYjNcf36k/vvjhojlLXYBndS63LwSvIT3i4ifF2N6zWjVT1pD7zJc81TWaQ3pMHoVZ+aaYsnrP2aOMrupJsy4Pnst+ritRWhq9O7CQ/s8EonZVCbcX69ZXDhnguaQgAO/Bba7ZgWP13dDME6q4BiEbyg92fyZeIp8ZE114DQPO5RCrHYJ5xO10kJq48ROvXo/ry7oSzFgplGiNjaEbUb/XJG4WqDZbomliXeaNaPq3+Uz/BEnK20WGdbaXZ6erYlb89DcdNxAgyjQvSiFECP2qtollqcShseIJWN41gwqc9wZlh4odjFr84E7mwalIGXHvlKAJwf9XSEzfRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtDdeXPhdjjsJXDTJej2ukkJoOABps/U45vjTqZ/44k=;
 b=kYHACkQ50ePeq9NnH2G92Djcy4sLxKjW34W1vV80JV3MSqAuZp5d4BAIrzSHJmfJ/T0PsF2+ljt4eu7SFQJTisBIyfamqCn2oDnjsvOQUiF5QA4JYDEXtKzIOqtuFOeocmWxgvBoBtAyfiRR6KC29e0jNs4RZZmT48QQmqi5drDrn2cNn3KYLHqfY+Z1l8vwnHeSdixuUNMni/96i/0mODsWTOt8YF4QGYS1tg91owPCibYiIJz0Po8Pzg/S7lWNP3I7VM/MZcCBYPe3Ke2XMs9xYItg8ajGNgpThkE8a78oqvLEODA5TdJJo32+FgIYNWPdxRr+EVFaxfyZDuQ3TA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB8277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Tue, 24 Nov
 2026 13:14:52 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 13:14:52 +0000
Message-ID: <39fa9809-0c64-4846-8acc-267d35c004d4@siemens.com>
Date: Tue, 24 Nov 2026 14:14:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Mercury build fixes
To: Yegor Yefremov <yegorslists@googlemail.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <20261118140632.1080213-1-yegorslists@googlemail.com>
 <9222017bd591f01dd92d6cbfd34b90f5e7abe93a.camel@siemens.com>
 <20261118214521.2292680-1-yegorslists@googlemail.com>
 <231ed4e64e4210b736a9ef7eb41a9b86abfd5ebe.camel@siemens.com>
 <20261120214018.3745861-1-yegorslists@googlemail.com>
 <9ce50b6edee8bf79bdb9bccb37decc9418857628.camel@siemens.com>
 <20261122143452.2973777-1-yegorslists@googlemail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261122143452.2973777-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::22) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 391c7ec6-df63-4962-5df2-08df4a2ced0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261028144727099003|10067099003|56012099006|261026140227099003|261022105027099003|11063799006|261102123227099003|261021121427099003|4143699003|261009223027099003|55112099003|261026121527099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AClK5Zgv2ZcQY427qS5TOuY6cgMPRiQ+Jgf96rh/oQXZMju8E+9BdGBB0LvWha34e2Wuh8pOPWKii8LldZEo4PuXALNTSPpPSObtyU7aU4dDLvb7fQqOajQ6zylMk2BqRiJ/dkdHrpvqjH9FTSJLVlF63QkETTqeIbhOr9c27cXKkX97kM26Wwge6414YxctbOjJpkcccKYFPdWj4qrAbWxv+SUQ3AVMBTfNdpH+Ed/SVsTxgGH0NUBicuw9iBDQCcGJjQhjUBkIfzhCQi5ueZMsXTEHep2gt+OlzuBKvVzGtr9bUhDXKzEFeMMhQbIP3/Sm9ZDq7sg7wYczTomEkyfApNL51YM1DuqSSM1W5MCTdTMXtLpiErRM0QALGo+pR2cPO3cOZfLEYmJ2TPLA87ndPEvEjeaZaS031dgaldCzmSm1/9NB/uOXv8RF8nvNrUqYUCDgYYz+6xIWGm91roiUZ8rKNM5fuqR4vaEcXa3A2l2EUxYlRIGJNEzTbjNJ7XevJcuhpghJ3eCZPLARiTwiX6lon0Dw9qVXQQCeekkepsPPMzomvxXzEAMIXobPNPHe0sL0ETp3KkZMEUDzPWON+B1h2IWoE9W5/R41sKdhhj5tFdX1i67NvJ7DHSNc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261028144727099003)(10067099003)(56012099006)(261026140227099003)(261022105027099003)(11063799006)(261102123227099003)(261021121427099003)(4143699003)(261009223027099003)(55112099003)(261026121527099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJ3UDFDRUJQdXNvSWIrOEVTSnB4TVdqcmVlK09WNVl2ZHk4eTVkL0t2bS9W?=
 =?utf-8?B?T1JZbzlHVGNkdW9Nak90VUJmSmoyTHNaajJ4RHd2Z2gxZ21oZyt0ZkNSajFL?=
 =?utf-8?B?TmNvVGlXN3p6Yk9BcUhzRlh4SlZzQWlXZS9kQURZdnJhSWlMLzRNZlNjZDZL?=
 =?utf-8?B?VmZ1azNXUHBleEFwWDRWMXlzdTlvb01WZjl0WUJoV2lDMlR2azV5YlpZckxy?=
 =?utf-8?B?cDEzcVJrTVQxdEI2bVF1dUhMZVYrVEpzTVV4Q1dCN3RGbFZ0UjAzRzIzN2hZ?=
 =?utf-8?B?eUZVR0tpc1RxVTFHdC9zVlJ3ODJXc0YvbVowaDg0TkZpR0QwakwzSU9nd05K?=
 =?utf-8?B?L2FxVXltUW5VV0NRYnQ4U3dpWExBRlRab3Zlb1h2QjZaSmlUTllNa3NmdzJZ?=
 =?utf-8?B?eWlSN1llSHlTTXhoYk00UzlHQ0VnN2sxTnpaQzRXQk1MVDRWY0ZDNkFPYXJH?=
 =?utf-8?B?MlFZZVJSVGNhOCtLQ1prWERHRWxGYlpyTEdTNXJUZUxOcGtKU0VTODFYNFBY?=
 =?utf-8?B?b05MU3pYZU9WZTdEa3UzNmRvbXUzU3JKcS9WSlF0ZktGdXZkL2xQVHk5cC9O?=
 =?utf-8?B?NEExanNBZFdCTmF5d3pwdytOQnl4eGVRK21RNjhKblJqM1VOaG9uZE5TQS9D?=
 =?utf-8?B?R1EwWE9ZSU1Cb1NaNzVIOFZSUTVkVUVIUnBmS2loRFpRWnVyQUFVWElYS1Fs?=
 =?utf-8?B?NmxCTTdCRmJvLzRaSkNldklVOUZZTlBwM2JWUlRuMjZCUnhPSWJUekdsYlBs?=
 =?utf-8?B?Z2w5aFRYSkZ4bUcrTHJ6eVhQTVY1aTlTSHBZY01JVytnUUtiM0tSL3A1RVI5?=
 =?utf-8?B?emRxSU5SRjFoNS9DWlozNHBKbDQ0dUE0OGQ0bFVhVEZDL0dtOGRMTHdSekZI?=
 =?utf-8?B?RnlvWXJhK0RjZWxPeGlzMFplUjlNZHRLNEVPUTNoQjJNZ09lbDNrSEpJNzhx?=
 =?utf-8?B?K1FqYUN1SHBJVGNhb0RXTDJIbXhLUG1kTWRDZHpXTFhseHF3WmlwUmxwcTRx?=
 =?utf-8?B?OGU5YSsvR2hOOTUxQnM0RVVvUjdnTlR0S3pObjJYbkNpVy9Qd0VYak5mYktR?=
 =?utf-8?B?dGpHMkxTR3RjNDJWaEtoQkQxWThNMWxWTU5zMzQrbUt1UkxlamIwQmlDM0Ez?=
 =?utf-8?B?bGlRVjFsWDJXeE40M2xWekFXOERWazA4dko3V0p4QVhvTlMwR3RhdHYvOTRD?=
 =?utf-8?B?Y0xubG9Fc3FhT2Q5RHZJRTF1UzJEcWJ6UXZhRXp0THcyRTlreXdrRWdqdEU4?=
 =?utf-8?B?Y3ZRWEovUitFSk1xMm1VVncrcDZjSkpHVkJiZW42aTJFWkNxVE5JN2NHZS81?=
 =?utf-8?B?bU03WmNxbVFFS2tJWTF5YzdmY00yVmhTd0VWQ25xS3ZZOHZzRDVGL2pzd1d6?=
 =?utf-8?B?UDlQbUZHRnhUMS81c2FoUlVDbDRLVmtBZmgwVEl4ME42d1RyTWV1bVdPSDdr?=
 =?utf-8?B?STVVOXg2b3BTUUNPYndPQ1dSakVUdjN0b20wckk2SGNIN3VRMzNOcmx3UE1B?=
 =?utf-8?B?dlo2QTdsd2NWV2h3YXZ5T0p2UDZ0OUV0elRrd2ptUzlmRGpEOTdnakRzOWJK?=
 =?utf-8?B?R2gxL3Q0SUZEU2hVYjhHaUFSTzFPL3JXOGM0SVZuamVGZTRHZitvUVlkZjB0?=
 =?utf-8?B?WnlmRlNXKzRqV21aZ2ROcmN4cHIyRGJqdkN5SUJCeUV0UlRCc0JjY1RiemQ4?=
 =?utf-8?B?SHdaUzgrbEVGOGsvV0JnbGZ5dDdzeTFSeUl3Wk45QXhHY3l6WloxbmdpTE1Q?=
 =?utf-8?B?dUF1U1RQM0k5dUxvbkQ0TjNQT3orUjcwU2Y5SHRla0tRWXBCYTZJeURJdHhp?=
 =?utf-8?B?Y2ZSUU52bDlBZ2JnRnpVbFF4UGl5NXBMQ2NwMHBIQU1uUjBjbVdueS9yOGxj?=
 =?utf-8?B?N1BoZkZ5MzdweENCN21vRE1ldkxLb2NkdkVnOGZnQngvenFGdmNTMzU5VERN?=
 =?utf-8?B?UWtiZS81dUw3QzAyOUQ0aGJlblYzaDNqMWpqV0lUNHhBZjJ6dGc3a1A0UW1o?=
 =?utf-8?B?OStxWVpLYzBkcWhDditscE5mUTcxdGV4YzhtcGpVSk9DcldVS2JONE5xc2Q4?=
 =?utf-8?B?SWpWTHFOS0NWM0lpaVJjWEJMQ1h2dFBxZC9sMC8xR1Y4amRSNVI1MDlNUjVi?=
 =?utf-8?B?U1ZBb1N1QzhBeXFoL29HVU5wR0dtOGkvQ0NBVWFneFplbDJVRjFXQkQ5enl3?=
 =?utf-8?B?ZG01RXFLYUMrUDRRNVNYWUhpNWRNV3B0bm1KaDR0NGN1SWxTbjR6MTlnTURT?=
 =?utf-8?B?MkkrSnMwVGlOSno5Q0tlQ2IzaXM4Ui93UU1TRlV6QWVEQmZuSHB4eVdSY2JM?=
 =?utf-8?B?L3N2L3FsTlV1VVNiSDdSZHc0TGZhQ1RSZ3JrcmN2OWphei9zM04xQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391c7ec6-df63-4962-5df2-08df4a2ced0b
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:14:52.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8DbBmXiBle1wVHxfFy5ZxQfz+EqZc6FDTWJ8cZfC4pedGMgU1RzfKTYAHZc3qqiFty1+SHKBcza1UyJbboMCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8277

On 22.11.26 15:34, Yegor Yefremov wrote:
> Hi Florian,
> 
> On Fri, Nov 20, 2026 at 11:17 PM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
>> I guess the first thing to clarify is: Do we want to support that? Seems
>> nobody is using it as it is broken for ~6 years already. I don't have an
>> opinion on that yet.
> 
> Fair enough, that's for you and Jan to decide. I've asked on the
> Buildroot list who uses Xenomai there and with which core and C
> library, and will report back. If Cobalt on uClibc-ng is not supported,
> I'll make Cobalt depend on glibc in Buildroot, so users get a clear
> limitation instead of a build failure.
> 

We should at least not actively make Xenomai glibc-only. Even if
uClibc-ng is now broken because no one cared, we should at least keep
musl as libc alternative in mind. But with AI conveniently checking now
also for corner cases, even actively building them, it can be
straightforward to also address them - just happened in
https://lore.kernel.org/xenomai/d0919a84-e71f-4e08-86e3-8900b30f9e5f@siemens.com/T/#u

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
