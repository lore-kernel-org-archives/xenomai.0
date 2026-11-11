Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399319;
	b=VB8O25aW4NjgaUqqKs/ENFQ6vG4uEy+lx6v/rcA/PNcCcYyJ+Yt1P/IeZLG8fS12N/ia
	 hzXW97TN8w4jWnA/gPZXh9gbecyz5tY4gmCaSV2+Hw608nD/sKSRN2XeoHZTiWClLutNz
	 7NSHv/K8pGqhRwRowz5CBvxPaL13tOH/l1NKY6dYbOJuXWXxB/3N1WcPA/sqrCYFT4Vlo
	 +SR8F/cM7A2PalJujjf8EjfNOooWML0ZFBn5L7DqPPcSul2H2s+jZSmdiFSDHwTqfRvF3
	 I5w8YjgIEhcKU4vvUi0kPmlnmtVZpJAUjqwo/Yk9toG+NeDhQtFBktCgM72tkxL6Oxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399319;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Cause:
	 X-GND-State:X-GND-Score;
	bh=KU9x3g5sI4xBQcRPDJ91Hht22E6LNwePsc5Y+qU9KFs=;
	b=D22K+nciAhESb8mYIZB7OmMJw92/k4W/Qo1W7/nkN5mllAjCVpfOr9xQ6jX9S08Bwm81
	 FJobUxGo2KkYEftmWHbio41zqLBrUOR+Lj9/pc80iumhY6J6YqQS4lO0EmxUvTFWl16lz
	 4JTlYYvD2GRx48iS2kO+/zX/+kslmTINuLzE8KECbml0FCNQVEjGDsDTZZba7mUh71DN4
	 OviGegaMWdorkWMGrtJ4zlB2mSDYjlDs1OEXhB2zYxe6WCrVSVIe6UeW7FHIePjPvHX1v
	 9odMEgTfo/2VYzGeVb9ZrFiYpUSaqW+OhmuogFg7hRje9HJAMXrKjqDThzaQHz0jsZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Q+JouL3v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C1606A33A
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B2C1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Q+JouL3v
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 46ED43EE57
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:15:16 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 168C6560347;
	Wed, 11 Nov 2026 12:15:16 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Q+JouL3v;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c207::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMGrveNO+EdGVpQ4R9WX+yG23Xmnvz24OFfrbzawCly3L8XOOqqZ1xy/nINXXaJ+gdHcwbiz25yMnMg/fhYqayRvoGa5EokLhhSa+XwftVYFsCJ5e7TC/RN/zyBsUgsf6NkF3R8/4s3N6Nrb1dwmkKK+5hdiQ0zBdpwUapgVWoHQ35RoIY88XFhcyU2t27naZo+JUlmJ0FqjmyKw/ClSKeh/DkE+kofziHlO9SmMtMe5eVVZ8XFI/OEnNjYWFH9S0RYtxxq8DcLSLpnUJ3ceWzjG/nP59NXEUhEw0bS3w5ZE4SF8GXsSgCIajy6INpHtOGp3EWqACJWYAdqPhDIgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU9x3g5sI4xBQcRPDJ91Hht22E6LNwePsc5Y+qU9KFs=;
 b=TqkWcfd0KaKe1CvyhlraJXzFhgZNS2Lvu0rDMsmmdEGSUHJUWa1B2q5PvaTriZfN5OKwCNWyRXXlYceC3v33ktb6GMOeE4mJbNo/FbD5eljkiEdMvnw1v9dv0UmeNBuZrwIe9Humw2KIT3gWVqVnMzOTV8OxcPmQtNXUsFbCFbUpeFzW89jNxxVb7jiS+jsWkX3lOnpiCRzUveQIZMAR4YLxJ63Ww/T/y3KwAcSKIPKRfbmuGFyiG4IuVZ9zpkPTU7hpEfeJmdJG+Wtfd7EMdcxW8weizDiyiP+gvtqucHZyVfodcZzuwM4l1PBLAv6wumn6fYGwYkdJ2hAeOvAx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU9x3g5sI4xBQcRPDJ91Hht22E6LNwePsc5Y+qU9KFs=;
 b=Q+JouL3v2xSItkAJRGKvLtrzlPJuMDKJSjEyEUEyt7W46HLB+nHYzoyirVeYzVgOYVD0e2EPlzteYueD+furrfKv/12loVOHOvJjwU8zBtMp8OnnK450NVMirdKoXaj5FED2IYtwmtH4jk9jnSe7Gwe1X0yOxYaAJjXIk/ftIVN6tICrkcRXity9h4pqZQQzj9y9IEOW9Kyu/McnkAY/oaYlMtXO6HrXu7MuqAOwHS8JadJcYx80maQ4q7T9PXzhLlZDAuWQsIyZ+wrQZY2q9kAoUGmmyqOrQDemnFnhCCX5H/oydX43jpmFLKzUpsovmye96RXYr5uPVP8ndTyg9A==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB8893.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:451::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:15:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:15:05 +0000
Message-ID: <d39d9dd1-9757-453a-b33d-2951c7b6ae65@siemens.com>
Date: Wed, 11 Nov 2026 13:15:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH 0/4] ARM trap fixes and generic handling of trap
 nesting
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
References: <ed4a5ca3-009b-431c-b014-02046df3c04d@siemens.com>
 <87ld6z6a7e.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87ld6z6a7e.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0441.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f8c4e2-46e9-4090-3e37-08df3fed6b5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|55112099003|3023799007|261021123027099003|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|10067099003|4143699003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	Dx8T49YG+U0TuqZDkH5fwyGk0ZgOEYZtboP4V5uHI8mH2okPWYb68mYVA4YCmSzW4L8bXmwFY/uKKQPeRCeFk3tQhkfA3nW0EPT9O9ACjj43PUavIf8xwWlQAeZGoeXzY8+/DR104R9gJQB7u5qdfF5q63n4yz1euyQLdw5bhitkdCHyTbUGRu6R8kJ94FCIWXHCQ71HUV73eB3IMQBZvzAU4ANlfIiGqjAFVb4jxFVQ4X+/N27pmQg7h+b2yQQTg+bpvZn5a4nxg3zHphE6bpcxcY4dei3U6cAbU3VE1cLLgjG943kPgwH/hbxD3DeNBxgkCcdbuIVhKSlwt+GPlpYpWMqwpoBU1h5fEM30LXN5nPsBgV1kK5pXPbyGGMOmbSKjh1QN+/MOiN66Z/mjGDDUB5P2WmBLBX8MhFqb0f3EmZA7e9n+8IoramL7VKZKlImzuz80DaAwrGmg4NQKUaohFZHcdE3fGvPkHgcDu0wnVgX2euEd+mXYQg53x6kKfXXCC7rRj7qHMaAdZvk+F6lfzVDpBV2Tx++2Cb5w0Yjx+0WdX3B9aW/ERG7yw/vJeO+ily4B0BMe4Srua2IWp2HmkFtxxb8dcrF+OraQjzuWY+EiNNKrUg5igubRKwCn/r5Ys/XcoYtyaeQ0QyW68v/f8ZJisYb9l3oi3eWTBSY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(55112099003)(3023799007)(261021123027099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(4143699003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUFLNERqcUV2VFAyb2VYT0xsQUEvMWkvdldZUTJ6NytuTGpkZWFhb09weHVw?=
 =?utf-8?B?OTdNVE8yOFNWMjlGSGgrOXlHa2pHQkF3ZURFb3NOM05VQnZiRXZWYm50cVFi?=
 =?utf-8?B?d2NjRlFpU01xSUR2ZnNSQVpDYjFjdkl0dTNQN0NIbHlZNU4wNXdWMmFHR3Ji?=
 =?utf-8?B?Tm1DVEk1eEVZZ3B6OHJ2a3N2Wkw1UHpnQ29Zd2k3czhKVVRnUUVndkwreTFP?=
 =?utf-8?B?WGN3bi9KYTNzUlUxUnVnUmdBdnF1VDRsczYxY1hOUGhDbUR4WGs5Z2xQMkpI?=
 =?utf-8?B?WlhaOXhwWUhVUTY3emJRcENoNjBFcDgzbG9Oa1dUOUxmR24zZ3VzU0RrRXB5?=
 =?utf-8?B?TUwzbmtXcnUwS0NoNDU1S29CeEZLL2l0aGNYSWtBdzdnSDZmNThkTDFCMTVL?=
 =?utf-8?B?cWRyajZnTmswZ1hNbE0ycThWM0tyc1Fod0xZRklZM21tbWxsN3lRS0FOd3Bw?=
 =?utf-8?B?YklDQnBFc2gyRHd5SDRLSERmWUFmYkxYdVJ6Qy85bkV4ZkdhOVQwa290eThV?=
 =?utf-8?B?TVdYd2dWVlU0Z3JadmNJSTNFVTlRWG05cFV4MXZ4UjFseXFjbWkrU0dWTTE2?=
 =?utf-8?B?Y0VZcExlZVJlQ1JweVpiRTZvMGpqSGpYQ1UrdGwvTlp2c1VWRU5JaVU1V1dk?=
 =?utf-8?B?cnU4cHVGZzBDOHRlNHdnNkpGMWhiZlQwcW10dFVoZDVHa3dMM0VSTWxrUWVs?=
 =?utf-8?B?SXNYRUVNdEdCZ0Zncm92QlhSS1EvWFVmL3ErcjdHeEo3T0t6UXp6WGMwUko2?=
 =?utf-8?B?WmhNZTBhKzYxcFZmS3JoeUFZU1A3N0Q4ZXBuK1MrS3ZwQmR3SnhXSmowVkhh?=
 =?utf-8?B?a0xsdFNHZjd1Z3h5MGNjTUtsbHI4L1V2Ynlqb0psc2ZqZytoWnhpSDVwTDgv?=
 =?utf-8?B?MStra3ZNcEZKYlI4NnFJekQwb1AvOVdXZzNJb1I3Q0JibEhUSERFODdtcUxy?=
 =?utf-8?B?a01LVkZYTHZYM3A1cGJISlp4ZFhUcG5BWEZudnpPZnk4WHkvaVZOQTF0K09U?=
 =?utf-8?B?aEVnTWE1bG92a1N1Nmc2NmtCN0w2VjduZWUwNWtYYzdYYkU0OEp5UElRQUlp?=
 =?utf-8?B?KzhQeFkyRDZyajRadUdHREF0Q2JnOUl1aWpCbFh3azFTMUw1bE51NkhxRTlJ?=
 =?utf-8?B?NU51TCtXU0tpSzJkS0wybzllTzBmcExwaFJjSm05eVFyRUhXdWc2QmFhNzc4?=
 =?utf-8?B?akR5dzdCOTBqUGo3OEF4c1JQdUFRbllSOVVKSng1K282allWSjV1cGdjVG9m?=
 =?utf-8?B?dXdJOUgvSEh6SjVNa3ZPRWlsQTk5RGZxNU1EL0U0aHA4NVFTVExiSTBsVmhR?=
 =?utf-8?B?SktTQkdHOUpUT2M4eW04TDQ2NHFWTUF6MllMeVJvcDBlbFBLdWRneDNHZm1I?=
 =?utf-8?B?eFNXUGhMZmtVVzU3c0NXNkp3MnZ0dlFmVU9ac1ljMUdyVytiSFA5Nmlrdk5D?=
 =?utf-8?B?T2ErZHJSRU42UVBpb3h4RktESnZ4WWxEc0dEOXlYVEErd3Z0NCtSODJYOGNX?=
 =?utf-8?B?RnBxblc1NXBQbFh4ZWFveEhoUUw4MDZmNjgzRVVEeksrWU5Bd3BsK0VkOElw?=
 =?utf-8?B?QmV5U0JZL1E0UE1pT1ZUQW5uUG1pREFhdEhqYzdCZllnMEVVakVKU0pHK3pu?=
 =?utf-8?B?ai9FSlE1ZE8yYjF5K2FhL0JzQ0UwOTFWczl3NWd2Z2V0ZFR4OUc0cm5Qa0Rm?=
 =?utf-8?B?ZU1OOWxiQ3lZV0t5R3d0WG13TFpja1hHYnBQWm10b3VZNHcxd0I2bWRxTEg0?=
 =?utf-8?B?L1U3UmpFRG9TcVV1RFFNeHBOZUhiY01BVUlXMDcwbCs3cWRjd2NEeFltMEha?=
 =?utf-8?B?M1lrOEJGOUQ1d3dGdXk0am5WcHVZODFYcUxuN1J3M3A4VlVZMElQZGNSVGlE?=
 =?utf-8?B?WlJGL0dkMTd2Sk9SRjBLZjlpYWtSOE5LTmtxaXBHdXMwRk5FRStOL092NkNK?=
 =?utf-8?B?em9xd0x3K1N5TFJINlZ4UmtXeU5JOFhsUWpKbURHRUY1TVFOUVRxQlBQaVV1?=
 =?utf-8?B?QXRuOWNCWnhXdmROMmM5eTZSQjFpeDZRSzBObEVSTzB6SmZIdDFYMmR3elo3?=
 =?utf-8?B?NUZGTFp5UXhzSmtmQnd0UzZGNGdrVGg0ZGpqRjFQZ1lMMFhlT3Vma0MrVmk5?=
 =?utf-8?B?TzNXTUpDVys5TVNyS1hWb1Vka3diQmVaVmlrM01EbHdmeEhSNDcvVTFrNkdy?=
 =?utf-8?B?d01XSUV3TGdMRVZRSkJ5TnZ5T2NFK1BDZi9ZYTExSHAycktNdS9oYTFMYjha?=
 =?utf-8?B?Q2RHbFNRWUl4WndNYnNkMDR5Y0ZYVDM5aWZOZ05KNGhtTlR3VmQxSlZBQ3FW?=
 =?utf-8?B?L21MU1E3T0dFdmFRK2NOZGxSdThKWXhZdHphZWJMd0YvbEtRUUZsMnBwcXQ0?=
 =?utf-8?Q?4ZLZa6pSYa2QmxdQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f8c4e2-46e9-4090-3e37-08df3fed6b5c
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:15:05.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQtUenItnAUXfqPORNzRFJh3hNUtGZgfuCDiqRs7hkOLkl61JxfIdh4P3mq1icdYh7+ulp1H0Nr57JqP6W5YSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8893
X-GND-Cause: dmFkZTEYLRNzo0ZJgL9jKqNRS0dSE54sX41osKIheErm55z84N38RzpBGpE1lMnIQFQsL0xv4U3eXjzyOe8cZgDqibD8vVLPCiKVVpP12wLe97g1rcNJQkSrK2sjIZcsjTAK2MzaXPdvOoAhKdTYNjqlDuWbEcPKDFldO5dHAByXcknQteiU0cJt9Kfz6kWiWQzWwm7BpTtI5hA5J1oEBiANrvKIURy7EOuxEc1wlXUngwjg2XFCrilGTVNLeGinkKtu+wJxGzcvin9ABWbVddgUAEbr2GOe1as4cB3iFgjnviYawC7FVi2254hLsi62Xy5Osn4KuGByqzcMfKC0Mmg0MjxmklaTvjP0kLTF6wEy9msgF89BURis3Z8oNWYI135LHHQQdhvEdSIn6i+MJYGgmLYzVzgdQUOiutMLEqrhDhwrbnWyF3gQw1ifyf6jNWCGM9jNJgsGvxrk3IBxOTtVEGFTZXplSRIQ7JuoS+BpOii6rwPKoNp+LbxX0nMBCAPYKRRSc2MEuYPwjI4PmFICm1jEoH76E1UFShm5i3a9ROlqleO7H6m44iLb2R+AlDXyN2dT4haW6huK1r84Qcfh1+KY6R2KOHsUlNkwzYN6FfpCrCGMgfbx+EnJrmk25FaOAuJu4Xq1OL6N94cr793AijRn73QQADjSTZjbr6tTa5kW/w
X-GND-State: clean
X-GND-Score: -100

On 11.11.26 09:31, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Jan Kiszka (4):
>>   dovetail: Track the owner of a trap notification by exception frame
>>   ARM: dovetail: Fix trap unwind condition in __und_svc
>>   ARM: dovetail: Notify the core about undefined instruction traps from
>>     user mode
>>   ARM: dovetail: Fix VFP exception trap notification
>>
>>  arch/arm/include/asm/thread_info.h   |  1 -
>>  arch/arm/include/asm/traps.h         |  2 ++
>>  arch/arm/kernel/asm-offsets.c        |  2 --
>>  arch/arm/kernel/entry-armv.S         | 20 ++++----------------
>>  arch/arm/kernel/swp_emulate.c        | 22 ++++++++++++++++++----
>>  arch/arm/kernel/traps.c              | 27 +++++++++++++++++++++++++++
>>  arch/arm/probes/uprobes/core.c       | 10 ++++++++++
>>  arch/arm/vfp/vfpmodule.c             | 27 +++++++++++++++++++--------
>>  arch/arm64/include/asm/thread_info.h |  1 -
>>  arch/riscv/include/asm/thread_info.h |  1 -
>>  arch/x86/include/asm/thread_info.h   |  2 --
>>  include/linux/dovetail.h             | 12 ++++++++++--
>>  include/linux/sched.h                |  5 +++++
>>  kernel/dovetail.c                    | 10 ++++++++--
>>  14 files changed, 103 insertions(+), 39 deletions(-)
> 
> Please resend the whole series, some patches arrived garbled.
> 

Done, hope this one was better.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
