Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.230
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211862;
	b=1lJBmAZip/nQ2lR/1QzsCAf8WFdGKSo8gelNo5mDEnGlqKKwZwrQYL4JiBpIwMUHAs4Z
	 zK5Xpllq1aoktiOcm4myD2e/wzU5QBvwk5o1oyUML6wAD7kXHBzOTINgjOrwhaMJTySKO
	 Wqs0yQ72J+DdYtISqq/rlAYa+2bttvXv2DHU/PRAD/OIbUwQGPo16Vv7Yl9sW6oqeTHLR
	 di3UVG+VCy6hYvpinzzwoS++vIHnHWn3V1/DgbSPwegsmd99Sd/miURC/Gy7JdFCZRk7j
	 LH39ry8klHaboUaTlntsPY9LMVLSh8TQTjlFLLks0CUm7xAu3Pl+0RgJcP5R00+qW6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211862;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Content-Language:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Score:
	 X-GND-Cause:X-GND-State;
	bh=miAW/oS0HnLmwI7ZReOGZMQ+Lv7zcsniiKMQAX8UCTE=;
	b=qP5CdH/CtQmU+j6W1oj1LIMHq4hDrUSnfirl9SZ7l1Bcot8GH6WiZN4VgryL/idLIg28
	 47VrDwkAzE/DxfL3h8ChKdgLE3alTOznv8dykEMlTNcdkAK7iphzDqFGY1sYY0DoSKdRK
	 +nsyPuWfku9IsolspJJqg4w5aso3P1mopbm5VHkVGZOmI3gVEKxtJsXVZyLWJHUKYkYbK
	 0ebFcyxt45NCbPcDetGJbWFOHAlFRgI1z8eUhB8Ziip2zdMa8PyomtM/l92ecdSdFemL8
	 iBYN+lfUpUw5SBuKsJrfquUD+FvR7CH3NllZSaIsZC8TYO7gP/DUx0Qlja10U9eSs9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=lPwHcxT1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.230
Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72820606A31C
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 08:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72820606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=lPwHcxT1
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 56B153E919
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 08:10:59 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id EBE84C00437;
	Mon,  9 Nov 2026 08:10:58 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=lPwHcxT1;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbfDAvNjf9VQ/Yf0p0ouxxkLULvUZYu20qPAaHHTWxno3mYIlaP1JHL6K5PeFBPJfSkkkyc+YpdhZk7t2Lg4RHb7t4Z4RedyEoaRmTI6G1FDwerB8Qi/utbnFkEp+f/T8U36nA8bmK9PhccGdn+DdYj3pxDear1+wQRGb1clTuXxsK380ILgDEQSxpsO7HBq8UBNE88ji/cZ5ZXRjCZgGyxOTNbBtuBfXIzSJa6wJ/KuWn6LogpM9xxCS0A+Jf9drLIw8uvHET9EJnhywHR1UTgRTpGQdTWOAiFsvdckOKJr1pwtMQtG3ptkgSFxvX2B4MsyrQaK/0tvViTGZMPl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miAW/oS0HnLmwI7ZReOGZMQ+Lv7zcsniiKMQAX8UCTE=;
 b=jYGb4nNWK9qOntzJ5zqO79kjmvt7Q+hnKvACRs+Zzc+9j8JFe82jl/31KKO+m4D2c1Zi6A3Jix9W76sg2pk+W74jlEdbgmfAgAbjeSRP3SQH7PNf7HCTRn4MzTNQJCEVAuCp8GXLjFiLIxPz1rWKf7lKqwt9mr9df4KMRPSxQBMhkv5rgY5yJ82/U4hjKtIjSol+8voIH3KHTAYIHoQ8Z3PV7qdOsMAQOKch2TQuXwuA63QgnLL4HIoRZ6BbGR47DzA6qrq7fV7PsbZ9RKSEYi3k1k+NHw8VoGjJJgxFyfKodhIVqZUs4x0U9aSfzDHuBHtjKqtLy66gnIyQkkDkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miAW/oS0HnLmwI7ZReOGZMQ+Lv7zcsniiKMQAX8UCTE=;
 b=lPwHcxT1q6KAxpYmfp0pdXBAene1x80yC+61bTDhdX+h0gL+kqcqLgBNmlru/UwhNLONMKsvm39Avmh4fQxxYMzt+Ex/4BjwU6OtAQZW2NSQQl/WJalmS34jcUFccvBapXjK+qMez0KQARX0vl6L83EvbjqiNsYaR1BhhnJIapeXwAHlplwllEOfTJ1OhFq5N4T00kQt+WRQ8XMVB5RmI+vNa13dCeWiv+jFVM3hOUSGPwCBDFzYS50ekO/CDFfdcUHaawXCF00zZFxNDjglrk82bR4JwoQMVD92+H0wn5Din9FwTlzIBnkkSZuQ0HxNqFZMnzrSXbCuVgLjxNAMgQ==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM0PR10MB9647.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:743::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 9 Nov 2026
 08:10:57 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 08:10:57 +0000
Message-ID: <ed4a5ca3-009b-431c-b014-02046df3c04d@siemens.com>
Date: Mon, 9 Nov 2026 09:10:56 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH 0/4] ARM trap fixes and generic handling of trap
 nesting
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM0PR10MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a3536f-dc18-4440-5e62-08df3e38fbd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261022113327099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Yk7obLbS52LxL8ydroH36F0qkD0Tutl+K2dLcCoYtdRBIsb7VkY+zhoxYOVHAz/2ASCd2RXGYqQ6gINusOQpLt3N8VFXT8zF5gtbJtTgJsr3U8iFK4jqMqyOkIDeZCh9/oWNLvl0u4OaNnlw6i39wBof708mcovf3ikD850NgES5aJt6Hg8nkdxkxT8omFn6TK3xyozvjiqvDKbm5N3gJLB4tI0tOc5vBN5o3V8aNtR9XnURO1kGJ7rV9eyVqqnXzqzgHCr3ioYI7NKnMkHx6xgKBl/KWFSwY2YQjoMw2AbFW5btW848hxs2ozQCHqsdNYeRkN7NLEWRe306t6njSQIfIuqAUxxeRoB/xFujbg/ajgTcjyoJNcLPiccPYOYaeW3S9qPMWyR6zAOQY67fsvlMLF8P6VQXRDT4Bxr4/W+17ieKbuzsE8kSuEDAyJFn7y1Jc8OaAVPOJf2Msf/xslzVZLIQ4luJExZmQ6E/l2kZ+3+9NcNPDKClCFEokQgt7qKAbruwsLvJU5Lj9gOXyLcWGj3YAUwgExZ6bkVDrwCK6UHLcBT4S9RAR+DpVRHagLBqvvIZ9v58NXSqNh6QP3/UkVNNpaMUuNChrrOet6HvD6vdwi5P44NQmrdQszD2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261022113327099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2xqcTVrUUJQK1ZJNzNTSkU2ZUs1OHkwNCtwelUrQjR6VHV1OGI3SExqakRV?=
 =?utf-8?B?ZmoyOFZFYWlsQTJqS1dFQ2F0ZW9iY2VQYUd4RjdkN2NpWmMvMVMvWkw5Y0dC?=
 =?utf-8?B?dnM2by9NcXNYS3lzbkhMbjFsRXFzTFU4eXRycXpkNkdFTjNRRW4zbGE4ekhX?=
 =?utf-8?B?SW4wYXV3Qlc4NTV5WnJnZUVlM091R2p4QnFWdEdmK3FBbGFjVHVTZkJJNTJj?=
 =?utf-8?B?blRmeGRQM1NFNm5UM1JRWW9nZFMrbFB0cFc4akJvSjNTeXp0Q3B1RmUwdFVC?=
 =?utf-8?B?OXNUeDZyeXdldXdFdlFOY2wvcXJTL3VYZElUNUVsSkVyRzFIM1FDbTA0UlJR?=
 =?utf-8?B?Y2RJZnNUVTZwTDFpOWJ6d2JmdnRINVJGZEZoZE16YU9WdFN5MW9VWFpqSU9J?=
 =?utf-8?B?RzJqaFZObitIOGYxUy9KYlpicWQxNHJyQWVNOGY1KzVwWkdwOTQ3WnVPamIx?=
 =?utf-8?B?eWVyS0RJSEFVWmZPbnZJaG9OQzRrMlNJYVJBanRLOEpJc0l2bW1UdVd2dnN4?=
 =?utf-8?B?RXR2V3FMdXFhc3h6Z1VNd0NaNHo4RElBUStNdk1sb3Z3L1g1Q3FoTTgrY2lx?=
 =?utf-8?B?WVMrZzkzakNlYVJZNit6TzhhZVYyRzdxZEhwbXRBUnNRekFJckdQcUJsQ1A2?=
 =?utf-8?B?SVVhTWpKZFJWNjlVTElJbHhwcThxV1d0b0w2SkYrNGxVUHVzb2VQeXd4YnA2?=
 =?utf-8?B?RzZPNytqZUphWTFvNmJBZTM5VzQxU2FpWU5OcTZMd1g2SmxPajFmczRDSFhw?=
 =?utf-8?B?T3RTZno2VWpRSHVOVmM2dEVCUHJaMmZ2U1dBNEhESk03S0FNTFJCYWg5c1Qw?=
 =?utf-8?B?T21ReHdDMUJjYS9KY0E3RndUdmppU0d5N3ZqVjFMVFYrTGVweGJVMDN5UkJ2?=
 =?utf-8?B?WDVNcENnOUo0WDJycmVTM0RGMEV0VDhTbThTcm1MS2N3NzV4cjNJVkluQTBL?=
 =?utf-8?B?ZC95elNqZXV4MGlhRTkrWEhQT2NCVUNZNFpwQXNmcVF1b2Zld3VlRE5lc0pC?=
 =?utf-8?B?TjM2ZkxnTXBmTVRqSWE3dy9EZnNqZmdIRVE1UUM1RmJiWXpENHg0c090dEZn?=
 =?utf-8?B?aHJ0L2h3RVVKWWRGT09nbTI3WGdzRVJHaUNUNjRERXpsWW5QZ00vQktQOW1N?=
 =?utf-8?B?N0RXMFl5ZFlTR0w0a1VtUnNpY3JxbkJiOWd3VkFxU2hQUnpzVnRuZEVZc3BV?=
 =?utf-8?B?aCtmVWVTejcxWTJjYnpSdCt4VHlpaUYwWFhaQ244VFVWSmFxbGtJTlJYM3Nz?=
 =?utf-8?B?TXpoMTJLcVZPc1ljbW9tdEJsVUtCMDhWZU9vWm90eUFobGI3YlJ2cmJHUTlt?=
 =?utf-8?B?Z2E2R1VaL2o5RTRJRTc5QTZtb05SbjJMRUwyZTJKS2lsd1VjQUs1VkxpZHBE?=
 =?utf-8?B?UXZ0T1EzcHdWUE5CMC84Q2Y3dFlpdEI5TzN0dGU5RFc2aHdtcnUrMEtDV1Jo?=
 =?utf-8?B?TEhIQVRyR2xHZEZGa3QvVlU3SXhkbzVkMnJvQUZyMXd1MUtYdHA2Z1IwcjJt?=
 =?utf-8?B?QVVadndBTTY5TGNHYWVIUHFEUlpWYnJvT3JwS1Y2cFBONEFMZG1VT2s0S2Z0?=
 =?utf-8?B?Q3RmaDI4Z1FYVGJQMjhEZUNrbERYckdsZGtQTGE4VmFkVXphZXBqcjVwSjRn?=
 =?utf-8?B?SnhGR2lzRmVFRk8zOHc1TUdSTE82L0VpVGZxVCtYVmkxVVV0Ymcwc3BNaUJs?=
 =?utf-8?B?MmVTb1RLN1lvbEI1YWZGejZSZExRY2x0VlpVUnJwK0wzVU1LRXB6MTFpNENS?=
 =?utf-8?B?NTRSZnlYODNublc5Y0k3Z1I5YWdZYjZRUE41STZoamJyRzJIMmszaXRLTDR3?=
 =?utf-8?B?Zm1BWGR6SFV2c01XUEJRVW5tRkMwMnNVSTRWRzNBbXpZV3VFaTFRMFBRSWx2?=
 =?utf-8?B?dFhPNjJ3Q1F0TVNrcmIvdk9uTHVTVFZ1WmI4ZGhHS0NHb2cxdmNpUHpOcHZP?=
 =?utf-8?B?VUZTajVtM25yQ2MrTnN0d2N2SjlTa0ErMHQ0d1lqOUU4ZHBjVGVhVmVWcG9H?=
 =?utf-8?B?dmdqVEFrOXhPOVY4V25WQnRPVWhHc1c0ZnM4UmlHNlJlWVhrVjh0aVFYNFVq?=
 =?utf-8?B?b00xYSt5RWhCdEZ2S0FQckMrSDhVcE1IMi9YS0R0Y3FsNGN0blZ3UVdCaUI5?=
 =?utf-8?B?Yk1tZE55RGVYdlRiMHlhWVpxM2pMSXNxeHZ2WEJoVkNidFRvMmhaRzlVMjlZ?=
 =?utf-8?B?V3V2UnN3RDFQOWY5ei83a3o4T3M5RnNqeWZFa1B1SW1qSFFkbzRFbHpULzJW?=
 =?utf-8?B?UHo3TENQUnNVTDB4QllaQ3I2bVRxcElSNHEwRmM4S0NSYjliYW5HOWVHUW8w?=
 =?utf-8?B?RTl2akpuNnU2enJqcXp2U0g5bWRUYWJOMHU3ZG81cGxNRnd2QkIydz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a3536f-dc18-4440-5e62-08df3e38fbd3
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:10:57.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErcwbhBkfDJVBHkC4wZgQlz4vo1DRnJJFE6FaIyJaRZZBHIDE2ellGEIIAgigMTeIDtxifUmmF8RbULk/u5ruw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB9647
X-GND-Score: -100
X-GND-Cause: dmFkZTFDPCzz5/5wahhHtF7SgoqNU9BfAq7UMicG/pTaBc0aPdtbNaQjSvawlTKW17d/YOMDkkOcNtRCucPFutNxslpetOpHXNfmq9qJpVW41xHrCAb4KxPwzSwzbXwXVTTRkHHhnKJ/iSck7wskFVCSRGYRxo6ezGycWwVm7g8bD2clyeCs+3Rl5ItHpXAu5YsB7BYDUZ1Xc10JNW3OJlXoDB6h9Y1klGYEVRbQvsCvQfgN7cLkJ+NkNOtDsSMm3wrkFgeokeCX4upapDuNNsyMNaMgyUBanzEFWER6SKh0GsBvOdJCEHe+Pd8MRHWODNItZH9oDe1PcnceVlftuqeRvyqbQ+1f81+LSnO79sP19ZPYFIg9Wq1CszpTNtPAsZHPhRkeatxLaIdAAjP/R9a/Nhf8/9EumKHccPzX3gUZGy4Bsh/G9EbyE4B/MJFWWawKjeZOLo5SNTnCRE/95wG5Hwpx1bxcfWAePVFE8ZSpttikyIrKDk/FbUCWcn389AfF1nkeAJjhmI6VNOFYXfbCAn6bM8bnEpTrDQPZzW0khlz80pHXOkFGHxMZFcoquZhfMjKfASzkJFmfoFnBEuTx9dChBLsHTTmwuQkC3/wGPmzJyEnehtxi4aN2qm6W0xVVnvPvw5NAg1mz8FGN4bE3Nn9gtRU6Zz/mQYuqzo4xI4YOgw
X-GND-State: clean

This is both an expression of personal laziness as well as an experiment
update about AI support for Xenomai core development - and it seems it
was fairly successful:

After noticing [1], I simply prompted in Opencode using Fable 5.1 to
review the ARM trap entry paths for inconsistencies:

"in arch/arm, analyse the annotation of trap entries with
dovetail_fault_entry and mark_trap_entry regarding completness and also
corresponding dovetail_fault_exit / mark_trap_exit"

For that, I just presented the wip/flo/v7.3-dovetail-rebase branch. And
the model came back with finding on [2] as well was these patches here.
Next, I asked for a review of arm64 and x86 as well, but there were no
findings.

Finally, I asked for the extension of smokey with some trap test cases
that demonstrate the ARM issues and test similar paths on arm64 and x86.
That turned out to be quite wasteful - I should have filtered out
irrelevant traps first, namely:

- ARM VFP exceptions - no hardware exit to stress them. But I'm leaving
  the related kernel patch in here because the code was already
  instrumented, just apparently incorrectly now.

- x86 Alignment Checks - can be enabled by userspace, but everything
  left and right in common libs will then explode. IOW, they have no use
  case in modern software. At the same time, some patching of libcobalt
  would be needed to handle SIGDEBUG for an #AC migration.

I will share the lengthy test case as well once I'm done with stripping
it down further (if possible). What the tests already demonstrated is
that unpatched kernels crash.

These patches here are almost completely generated. One of my few
contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
of having oob_trap_regs as a nesting detector came from the AI, though.

As usual, AI is still rather verbose in descriptions and comments. Some
of them I already shortened, but most is still left. We can cut down
further, but I would first of all like to have another review round.

While doing that, keep in mind that AI tends to ignore issues left and
right when being told to do a specific task. It may have simply missed
further preexisting issues or even created new ones now. Watch out!

That said, it is definitely impressing to see that a frontier model is
able to build up decent understanding of the Dovetail architecture
without further hand-holding. I would not blindly trust them yet, but
they seem to be ready now to act as debugging agent or at least
companion, even in complex scenarios. Giving some LLM access to a CI
pipeline may even result in automatic regression tracking, probably
already today. I definitely want to explore further what is helpful and
reasonably needed to support stable kernel maintenance.

Jan

PS: If someone is interested in the token costs: Due to my inefficient
model usage, the counter stopped at about 170 EUR. Most tokes went into
test case development and its debugging (#AC issues, e.g.). These
patches here likely costed about 40 EUR with Fable 5.1, checking the
other archs maybe another 30 EUR.

[1] https://lore.kernel.org/xenomai/8ecd3d1a-86d1-4f39-b175-b712c0be6eec@siemens.com/
[2] https://lore.kernel.org/xenomai/2e3b8eec-7911-4abe-8082-97296000e88d@siemens.com/

Jan Kiszka (4):
  dovetail: Track the owner of a trap notification by exception frame
  ARM: dovetail: Fix trap unwind condition in __und_svc
  ARM: dovetail: Notify the core about undefined instruction traps from
    user mode
  ARM: dovetail: Fix VFP exception trap notification

 arch/arm/include/asm/thread_info.h   |  1 -
 arch/arm/include/asm/traps.h         |  2 ++
 arch/arm/kernel/asm-offsets.c        |  2 --
 arch/arm/kernel/entry-armv.S         | 20 ++++----------------
 arch/arm/kernel/swp_emulate.c        | 22 ++++++++++++++++++----
 arch/arm/kernel/traps.c              | 27 +++++++++++++++++++++++++++
 arch/arm/probes/uprobes/core.c       | 10 ++++++++++
 arch/arm/vfp/vfpmodule.c             | 27 +++++++++++++++++++--------
 arch/arm64/include/asm/thread_info.h |  1 -
 arch/riscv/include/asm/thread_info.h |  1 -
 arch/x86/include/asm/thread_info.h   |  2 --
 include/linux/dovetail.h             | 12 ++++++++++--
 include/linux/sched.h                |  5 +++++
 kernel/dovetail.c                    | 10 ++++++++--
 14 files changed, 103 insertions(+), 39 deletions(-)

-- 
2.47.3
