Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.232
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794212020;
	b=k7ZWm63fYcQjeKX6S+ZPoilx1V1OK3vgWQr91SEUcwD/vSEor4LQ75g+hSO+eza27p7j
	 OGeVY4miJ7bjc6qfcKFm6qp+Q+LYck5PhQIF6iUqqOA4d+hL3+V5g2FkGeZLsxdt3I99D
	 SFFt6Kd58PUzws1ep5D9NFVTVbUj0hdYeH/qMlb4CMCnlkWjn20mZ2Kwmr9jp9oVhln/M
	 6EgCPaWvSOL3U+C5YquFKRlJnLTGddFSDsgded8MptHgBq33axjRIfZs3IkiRDZqmElpP
	 CJTk5hlk5DU1wiziAwPDVQCE2KJXq/pAoQ35NlUMmZf8UbvYFVFCUUzql3S3OMSa18A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212020;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:From:To:References:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-State:
	 X-GND-Score:X-GND-Cause;
	bh=sICgNzu3xwPy3iQN0NFldgD9YhZZBMf6Qz1SZEmxq9M=;
	b=qs0z9hRYhir2RYnPVpJZjlws8f3oG2180syxmhR2if3xBFQV9nCE5trWfVacAXhRj4Ax
	 aZt4WSP4+syfNtkSHOSGMRR9jKb38QQtUlBwV7ryXpVwFjbuvz/gkyVudHC83c2Xrp4HB
	 pFcGv2pmkpUVsQCPmkyWUQDUcYLH8p1XOc/fx5RSxseJRN6BWcC2juAVwn7K2LKCwYUeJ
	 E19fbPrNrbiKEdyquOfEZfjVgUInhIj0albQ9hTzwyki2Am9e3byBOXWqisxRJOFJPuDC
	 /IMlv7kDifBAeMZyGdlf9pdlfjhrzDv1GBbj9rafxKn4WnMbhYlkVDXztCoyT/gPmYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=xh8dWvEK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427CC606A31C
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 08:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=xh8dWvEK
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 6305F3EA2B
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 08:13:37 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 42C9CC0011E;
	Mon,  9 Nov 2026 08:13:37 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=xh8dWvEK;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT1ItwZzojej8s1euY7d+UpzH7Ls80qXZnQTLIm32jFV8iyXxsekLJSJS7l3Yt1FIo1MgJBBRsnGWiaTirAFXI8hshurLxHvbAPo6612/wLH8axP1F3Fa7KwxF0hL7F2FbQ6/qbFzYk6KxoJctQPubGhiIKHhzO8zgYrbxielgq5IGzQvhguhZJ1Hw7lBDaN02sBryAQmgBMDG/YRS6Wu57ifSQjCvocvhLjz4nIbeOPwKCD2mZtJqdoa/Tn8w7vRsr9YlZde7bJO3rblQuKq7q3bcv010O/G/Vj6oJt4e3yd920iFs037mPfuUSfdE9Vi0E7DYUtLqbkRpkNvF9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sICgNzu3xwPy3iQN0NFldgD9YhZZBMf6Qz1SZEmxq9M=;
 b=jkRmDNVG6Uz7kTybE5Nw3MgEexkEakKFWDXwDXCx6c69f+vXO1cB3iS/Xb/+yGKZozI0/fRPtEOGHooqo/G1KBJ5HDJc5qL6ceNeyi/2wZ8b6ZEas44ZpZ9I6DfLP066OBKLLrxJxQo4BHkePqZodVITLkOKqjqgJ/rsp14u4iK5rziAjX0tu/q6EUA68n2r31gV9rFoEZIjJl1wVqx/7xExSuU0hzGNyoomZFTZoU+DlYpZ9LDnVme4gnsgLvkzTC7oUymN1kxVVQaNkinT7koq7AYYxSG9TakHgOATr6zsW+eMKDroHKAL+P40fc8fdY1rF2UMBhxUeaXsQLtRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sICgNzu3xwPy3iQN0NFldgD9YhZZBMf6Qz1SZEmxq9M=;
 b=xh8dWvEKdeV9wsx/IFvEUs6aIDB23K/6PG7jJySSakxfGPUQf81kdNI49WjbvjXumK+A8MouTajG2u/xrluJiNZ8p5NtIx4JFoEwjfwRJH2YYkP9xllExccM0BQcyJkG0iG1KZF3EBTqfRZqfCjdF+cVXn/mV+8JsR14A5Sz27iQRD9sZyUTW0YIf334tnmME0jSDmwE7Mqh7BjzCGrrGOZQSshQOJXb0EBV3WUcSCQnnMHwo3RpPI8s+/LINY8GpciFifODVM43atRREwSqpSclTbd5n5YkjWlAqTGx95TeC2TXJfXROPEfOBoB/JJpV5xQbP5rS8/U8/2OMOy12A==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU2PR10MB7882.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:46e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 08:13:35 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 08:13:35 +0000
Message-ID: <4b1bd7db-7198-4efc-97f6-348ddcac1676@siemens.com>
Date: Mon, 9 Nov 2026 09:13:34 +0100
User-Agent: Mozilla Thunderbird
Subject: [dovetail][PATCH 2/4] ARM: dovetail: Fix trap unwind condition in
 __und_svc
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
References: <ed4a5ca3-009b-431c-b014-02046df3c04d@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed4a5ca3-009b-431c-b014-02046df3c04d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU2PR10MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be2ae57-852e-473a-d97c-08df3e3959fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|10067099003|55112099003|3023799007|56012099006|11063799006|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Pf3wdBGMcHkKp/RbhCnGwDkqf9fOY+d8BrK20hHeIPf+Gmfd9Rdw0Rs/PQVn0jx6edW3a5P9SckX6FMWZG54b5dN77vK5pW9zeGsvQh854quLe2nrXruOE+1opMmWRv9o1pl0z9uUUEAq8L0XJKzUKUGL4WS3mVXAaYGIy78uJb5Cyu3UL7MDwi+TnSYLbeOWKb8HTZJC/rxbCxJ7Y7EXHSVZo52A3vLkWm5jX/FN+v191f0uCqERmOyVQmJGdLcEZt3es0jxoW9CZSzOuQLgkMZYWxQC+xejk4I9ZB8/X1zbRfHeIQTayZ7/Clh/saCyOpPJJNfwbqqSsvbc1b0/BdWaebwQRm+DRK5g612/5sK1UnqS+thjS5k7njXAs5aus4nsLRqAZyrN5CiJThjeiF2UuV8cmxUFhrFgE0mK6B0IIV7Q1c329TSPVxIPQ7n60McKmDg7nWgO2s8sMBAWETOoU7000xBLwbHlZMnnn4QmbClux8hec18dhMgUXKzbrxOyKO5FhYHg51CFUZlnCWCmdVTGPtAp/Decp4ncM33mE2+i2pe2MaDetxSn+uBqoXVsj6peUOU/Wwxs4efowQwolS5Ii5Pqqt8VR3F1aabqcTY6xkJlTscvX2cLjzE4KwfI3w5ReqnzjcZx7vZnTrquMiPlAQKkNN3Ss29KUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(55112099003)(3023799007)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVNURlR5YnIwS1U5ZWNxVEY2aHBXSDFxUmpUdDZ3L0JlRENxNGhsd2F0OXZp?=
 =?utf-8?B?a3IyemRYNXo3TDFoOEJ5Nk5OVm1RTVo0M0VRcHFqMURqcXI5TVYvYUVCNXZW?=
 =?utf-8?B?ZXhKT2xHV3E4aS93aWJOUkJzSjNKeGJ4SDN0N3JTNGlLUi8xdG02aUtZMmxT?=
 =?utf-8?B?OGpnNGcxY2IyTkxGV2NQeDJoZkIrRkM5SEVhUGJnaVZpTmxoNVU1My9LMGw4?=
 =?utf-8?B?djBCREwvbEIvSHAzall4dFJJTGk0MURNdFNLUGJJSmxPWDkxbU9WQXMvdk1Y?=
 =?utf-8?B?K0FGcSs4bS9VK0tuNy9vTlFlTXVNaUpMcVRlSEF1OFZjRXduOEZBK2hPNkxB?=
 =?utf-8?B?OHpnVW5pdUd2NlJvTmdUaGhPeEMzNktlWWVjcmZJczhhZTBGQXBvVE9qcUpC?=
 =?utf-8?B?NjBUL1hXUkF0N0tiNjR4bTBPai9WR3RGRTFoN0IxckxCZWlmRXNRWmgwdExF?=
 =?utf-8?B?VkVwUUdNQTAyMk5NN25XMVI2ZEtCbC9OdlJNLzBPY09VTXJEaHI5UjgrSTRK?=
 =?utf-8?B?RW1CeUZ0KytBYlZaSjhkN2FlWlE4dkY3Z25uTXdGS2FYTWI2ZlVqMHBiUzEr?=
 =?utf-8?B?a2xwZUVFVTYwNzdNSEtsejFrKzYyQnNJK3AwTFJJTHBMR1RWLzNwNUtWZGgy?=
 =?utf-8?B?N0Y4SzcxNEU4ZkovSWF6cmYwM1kxdUVlZlVYWU5zVkYrMXI1K05MUzcwR0to?=
 =?utf-8?B?Z2JmR1NTbW15WGF5MTJIUWNTOEpqV2h0RVMxaE5ma004ZjR3TzlnNkRtMTBB?=
 =?utf-8?B?SmpnUzZneVVLUFdqd29HOHZoRFJJVGYyNEFVbHlObWl6ZU9wbHNCNjlwUFBY?=
 =?utf-8?B?eUY0c05BdGtoaUNZQmdPU0pNejJ4MXFhbWI0UXovU0dRRXdFVjF3aVA0bnlK?=
 =?utf-8?B?eGtjL3RWWmNUM1FQdGJaN241T0lXRE9TT3VFMTFYb0dpUlkxYUZxd1hIRFBH?=
 =?utf-8?B?QThBODBEa20wdkRlSStBY0Z3cnlqZ3N6UnNhU0pBVkg3Tnd3b2o4eExiQkhK?=
 =?utf-8?B?WUZ3T2puSGlaSk1BUU8vYzRRam93WjdibjZlSlh6cHdUa0FyRmpwV2ZtRjFZ?=
 =?utf-8?B?UXFsTFlDdXZ4aGxsN3p2N0luVHVwK3VySDdzMWRNR2xDbW5DVVZaRElNR2FB?=
 =?utf-8?B?N3FRZnJjUlJsdmt4cUJkdER4elJzN3VuM2pzSitzTWwrYUpUMUorZEo0UEdx?=
 =?utf-8?B?RVZRRjJkNi8vcEk0VlU5aUk0c0pjaHAxYzRBeEZUVTBQaHptVTQ1Y1ZqM2Vm?=
 =?utf-8?B?Mkk4eEh6QjkxanBFUWpQVUlMVXpDbWExR0RvOXpiVks2UnRmTjgwd01yRE8v?=
 =?utf-8?B?d1NBaGUvTWt5VkcwazlsWExJQTlaQXNISFZGTTNpNzVFWnFlTW15ZFhhcVB1?=
 =?utf-8?B?TTNMcnUwVGlpQ1VMM3Q5NUVwTDBsOE8xZVJZS0M1SXNKeGRoUmwrQzJUdUl0?=
 =?utf-8?B?bDZYMG5MeHR5amtCQlN3ZnNnMm5LckFXa1IzOWVNcnhEbi9JQVRHNVZzS1Jv?=
 =?utf-8?B?NFUvOTlVNTlEcy9DU2hrc3R2dGQzOEVXbGRWZ21tbWVhc21SS1RydjkzKzFm?=
 =?utf-8?B?UXhrNzBtODZDSFlXbVl6cENtSnIvc2MvdndIZFA4WUpWR05pSlRrbWowWk43?=
 =?utf-8?B?RncyOCt2dkpIMHJRY0Zna3l0VVhtVXJnY1ZhUys5eEZmKytuOGVrSFp3NTRw?=
 =?utf-8?B?ci9uUnMrT0d3aE5MYU4zcHMralZWTnVMSEp6Qkw3a2dna0ZwbTRNSWJXN1Nl?=
 =?utf-8?B?VDVpamdVZk5kdDJxQ2p3U3gxNW5RdHlJbUJxNXRia0RSVWs3eHpMeDdjemsv?=
 =?utf-8?B?YkgweVBKTzdyQVNvMFRWc3BnaytNQzM3UW1TQkxsWUhOWWxZQlpjMVZxT29m?=
 =?utf-8?B?VE4yMWU1VGZTMTU0cC9md2YyRkdPZEU4V2xjNVcyVisyUXVmNnFKVTV4UU5v?=
 =?utf-8?B?TVZDaUIyOFV5NW1YMjJ0aVp6Sjh4RXN1SS8ycDJ5Y1Q3TkhYaTRIajdCYzJR?=
 =?utf-8?B?NzhvaVBmeTNZSDUyaHBSVXNXUVVpOEVWSm1ZRk9VUkFzWEp0S1I2TVFIRk01?=
 =?utf-8?B?RkxMUGF2VEQ5R01xajVQdTZVdnZhc01mdzdld29zd01ndnhKdHUza3VkOFYr?=
 =?utf-8?B?UGwxaTgxdGFkWDlsUzFSZUF5bm1TQVBTMkZPamxGVFMvakN5RGxYbDJoRVJq?=
 =?utf-8?B?YnRKdGtud1VWc3YrdHFOTEtrUXdBLzB0N2JaeENBUEowSVlrbjRHLzNpNCto?=
 =?utf-8?B?eHJMbnFWaFN6UVZ3N0xGbDZkd1loVU5laER2eGRMZThIdEhyWTMvVFkzNXE0?=
 =?utf-8?B?Z2szN0pxcE13bDQyT1JSSU12aHVML1NGSHl0am9ZZ2Q4Ung3VnpkQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be2ae57-852e-473a-d97c-08df3e3959fc
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:13:35.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGvIprearqM67Z05cb69D9Yk4qZR3aYOZKN9GP5C3Fswo9iqaZFHK3NXCwoXsdRagVXWXdZT41NXSrzM4uP4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7882
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFaWfYyxmq1dtJG57v4vVcwxZEVyRNP3r7Z3OII8h9ugp+fEulfUHltjSyNs2Nhjv6AVcmuQk7KJTqoypKiD8rHVGBgQWT52FSlI6broEgkXpXJuIUF0XXGEWYHEivvz7SxqA1B8WPXDRnX0g0oevFpQpMRwD7HOXEl3CF9k7K9sKm190k8pLIcrBdKOPLln5Fo5qle1+okVGOFzRS/IUKh9asIa2bryteoszTmEbVi96+ovX24smzM8d5AqEPemKUZ1jvcAlssOzxV/F7vuFuoFs2BtA5iXfjoB7MC3rbOe6ghHBTbP81YwN2ILnglYsXHsMvjMKFWgq3SNrzEiaTVaMFayO0n5V+jur/LXacDrWLvzPU8GRbiCe1eU97ilGMkg9WfRjp4BKuAaQl7eZZy9fHYfYVGM8n+mnP0uSuogrIrlG6Fy/N3JwwW7LdH0pr5wkdTO70NWl7E32xLcB4oiITLu9FzbF21aUh8qZVTZ48fQvPCYbBSd6486107/7baebcWTR/eiYb09JzSFfFpvtURE9oExXFs2vk2Lm+7flDhv7zkyyHHIcMWWcrL7oY2zFxNeSa5ikh6PdIcM19vJgOqD/3wnY42WIfL/W4bDk2vFNQdukkOkURNjeYK6i7k4iQAp5pO2nWdDqMKWazkg30pzCCBkwokB0Ccd/8ZHA

From: Jan Kiszka <jan.kiszka@siemens.com>

The kernel mode undefined instruction entry notifies the companion
core from assembly, testing the current stage both before the notify
and before the unwind call. The second test is wrong: if the core
demoted the thread to in-band upon notification - the common case -
the thread is no longer running oob when __und_svc_finish is reached,
so the unwind is skipped altogether. As a result,

- handle_oob_trap_exit() is never called for that trap,

- oob_trap_regs stays set, suppressing every later trap notification
  for this thread until some unrelated trap exit eventually clears it
  with a stale unwind.

The C helpers get this right, keying the unwind on the owning exception
frame, not on the stage, also acting as nesting guard.

Replace the open-coded tests with calls to small asmlinkage wrappers
around oob_trap_notify()/oob_trap_unwind(), so that the assembly entry
follows the exact same rules as the C trap handlers. Overhead is
negligible in the exception path. The wrappers are blacklisted from
kprobes like do_undefinstr(), since a probe there would recurse through
__und_svc.

The TI_PIPELINE_STATE/TI_OOB_MASK offsets and the asm/dovetail.h
inclusion in entry-armv.S have no users left, drop them.

Assisted-by: opencode:Fable-5.1
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/traps.h  |  2 ++
 arch/arm/kernel/asm-offsets.c |  2 --
 arch/arm/kernel/entry-armv.S  | 20 ++++----------------
 arch/arm/kernel/traps.c       | 15 +++++++++++++++
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 2621b9fb9b19b..8f7d526c36ecc 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -44,5 +44,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs);
 asmlinkage void baddataabort(int code, unsigned long instr, struct pt_regs *regs);
 asmlinkage void __div0(void);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
+asmlinkage void und_svc_trap_notify(struct pt_regs *regs);
+asmlinkage void und_svc_trap_unwind(struct pt_regs *regs);
  #endif
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index a5e5a666930ae..6135e9352335b 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -55,8 +55,6 @@ int main(void)
   DEFINE(TI_ABI_SYSCALL,	offsetof(struct thread_info, abi_syscall));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
-  DEFINE(TI_PIPELINE_STATE,	offsetof(struct thread_info, irq_pipeline_state));
-  DEFINE(TI_OOB_MASK,		STAGE_MASK);
 #ifdef CONFIG_VFP
   DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
 #ifdef CONFIG_SMP
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index a314c3152072b..1f44c9fad0186 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -30,7 +30,6 @@
  #include "entry-header.S"
 #include <asm/probes.h>
-#include <asm/dovetail.h>
  #ifdef CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 #define RELOC_TEXT_NONE .reloc  .text, R_ARM_NONE, .
@@ -298,14 +297,8 @@ __und_svc:
 	svc_entry
 #endif
 #ifdef CONFIG_DOVETAIL
-	get_thread_info tsk
-	ldr	r0, [tsk, #TI_PIPELINE_STATE]	@ get pipeline state
-	tst	r0, #TI_OOB_MASK		@ oob stage?
-	beq	1f
-	mov	r0, #ARM_TRAP_UNDEFINSTR
-	mov	r1, sp				@ r1 = &regs
-	bl	__oob_trap_notify
-1:
+	mov	r0, sp				@ struct pt_regs *regs
+	bl	und_svc_trap_notify
 #endif
  	mov	r1, #4				@ PC correction to apply
@@ -317,13 +310,8 @@ __und_svc:
 __und_svc_finish:
 	get_thread_info tsk
 #ifdef CONFIG_DOVETAIL
-	ldr	r0, [tsk, #TI_PIPELINE_STATE]	@ get pipeline state
-	tst	r0, #TI_OOB_MASK		@ oob stage?
-	beq	1f
-	mov	r0, #ARM_TRAP_UNDEFINSTR
-	mov	r1, sp				@ r1 = &regs
-	bl	__oob_trap_unwind
-1:
+	mov	r0, sp				@ struct pt_regs *regs
+	bl	und_svc_trap_unwind
 #endif
 	ldr	r5, [sp, #S_PSR]		@ Get SVC cpsr
 	svc_exit r5				@ return from exception
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 60c4725fa8530..8ca5ba26d2598 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -27,6 +27,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
+#include <linux/dovetail.h>
  #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -495,6 +496,20 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 +#ifdef CONFIG_DOVETAIL
+asmlinkage void und_svc_trap_notify(struct pt_regs *regs)
+{
+	oob_trap_notify(ARM_TRAP_UNDEFINSTR, regs);
+}
+NOKPROBE_SYMBOL(und_svc_trap_notify)
+
+asmlinkage void und_svc_trap_unwind(struct pt_regs *regs)
+{
+	oob_trap_unwind(ARM_TRAP_UNDEFINSTR, regs);
+}
+NOKPROBE_SYMBOL(und_svc_trap_unwind)
+#endif /* CONFIG_DOVETAIL */
+
 /*
  * Handle FIQ similarly to NMI on x86 systems.
  *
-- 
2.47.3

