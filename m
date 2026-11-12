Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794492194;
	b=zOe4N0Oq7eId+fLQMu8tj2vHoS68rWfU3Tpd89bPqrwhzAVGjUgNi/cww1jAnGphFhlc
	 NFxmsjBVcJd5aR9f4vLcd/HSR5fN9Gbs+Iw+lFBUEVdIghgPpkniTCM0TWYQ9wvIVpheA
	 KiSIBmPq0wyvw6ym8+YrivcehFXRZXsCje08mA9w43cePPe+fF/02zFNbajJOWrvOQdiv
	 I71N6G+I0wE9FUW1PFLLV8rzxOG6fly7G4cueGhwctwMIk5QxdsATq3tdrgliQHzW5ugk
	 st0Fn29c3O3API/v0LrFxueY0Q75pqY8EPIG0Y+YaYl58S2iKyw1TeInKTqUTgi5xrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492194;
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
	bh=W3ame16JUQ0LN0dcbs9FG4QpzcWdQN6PCQDZth3aueE=;
	b=eLUT3UZAK+m+54GmD7aewLOD09CTAvlzXEeEMn/1uY50rFnk7m+ZXw6/5l22mjsD7uxn
	 Z1NaGsbcVPEvTZm2e3g84g9uepuSGAX98txMwNfcfK5yGqvN4sjA2IenrL6DJ5awBZVej
	 BwyDALuC12OCgBNun7wUQ3gf9lZJsufQSLZjBq2dVHDm0PnK98O7ymf2A4VbU7U5ViInJ
	 6Tjk16xwal2jb36EetDqSVSvw1rE4OzBpm6EfeZ3S+vZgaFoW2NFR7R3jNc/N0b20SML/
	 csQui9l852K52nFH9VFCxxzHB6L4vD3yo3r4H8CQKPnIBbxW6XckWRBZi6yZtdpSBXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=zxT5zMh7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2E606A323
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9A2E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=zxT5zMh7
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id C5E3C3F423
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:03:11 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4C19F27E04E3;
	Thu, 12 Nov 2026 14:03:11 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=zxT5zMh7;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::5 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmO03VdDnKQs7bdegK1HroRTLB6HU73I9YgR/CW+iCtfqlevjkHOabbc70NBbg1iEbqI6k7fUYQwwj4dehlcFmvSAH2A6KdDzPjWwPfftYSJBhLp3mwZwzPAxGaxURrHU6iaCBnm6C/G35V2iHKVWh8tqO3NFcmDXTO2AzIBbduX0/4ex5Cuzgz7vjQtcL/wxMS3bHHNZKpsv3XCbzf6nCUYVm3Qs5UKGOAZ/Rz4BFlVYvjuPBlFdaUvdXI1K3+Y7+D1F+8wH/uve/k90zOCpVNzJWwOXyxgvlt5HMOHQ1VxXvnGNaMA02iWpK2AL6KYidrB3RpBclEmO+JP/S8Llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3ame16JUQ0LN0dcbs9FG4QpzcWdQN6PCQDZth3aueE=;
 b=lBEMmXXOYb455PpRGXlwm2yYWLj1rB2Vk2eFewC5UBcJ3r104Tm+J+ZvZ334y2NPRNwU/iP5vPkkwpC2E73YdqnZQZTf0zsAqQr6ATlXdivlVxTfPM2MDwYUcWJtIYN8NQjdy56ZmjXhAVDvpTvBSrviL0kPI/KA1F9HM11ghx1n5BbAAgpPRG5sY3dA5ZfMPCK5cDNYQ0DfDtbhrHGb4U/bx4mo+PTcqwT1G1W9Ynb8rJFYCF19roplHHopXOmQBQpbYOILVjoZ0+gw6VVCrJn6DCuv1Wftds6HyjqgFmNNdwJuhhY77B8vaW98Ji8yJfu3j8pMJrsYZY5MET9I1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3ame16JUQ0LN0dcbs9FG4QpzcWdQN6PCQDZth3aueE=;
 b=zxT5zMh78YTgCIZFa02a7E52HC35+zOOgazidichTFIlX3Q3NLxyD2F+SrJbQ3N3bhN7x2BxA3+PFqYfj2wBHnNilYNCwg516j8XfbpXFjS3ZgH+VXHeLPEUU+Ydg5Om3yMUEYy+VB11dvNxSfzVCb7Ae2Zwlh7EqiDjUr0Pug8U/eE6TvXlTt2b6xmlIcKL3cXS2XktcehgwzBNgqc3EYudIYdzR+jxZUBIYubA0rNqCuADtEfDYgXGIAjOeO1tlRKoj1JI6+Y7RJi0jY3O+1yYnKnkQHRQHfhKvNxsbJIEIxngGZMSKVIR2fUO791+dsd/QcbyoqzYPQHP5J2teg==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM0PR10MB9624.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:746::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:03:10 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 14:03:09 +0000
Message-ID: <08720c97-6405-43ed-8096-7126cc9db235@siemens.com>
Date: Thu, 12 Nov 2026 15:03:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <87cxsa2vej.fsf@xenomai.org>
 <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
 <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
 <339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
 <6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
 <b4f20066cfe191c9aa22e4da524d56838da5df3c.camel@siemens.com>
 <ab4bf2bd-f38c-451b-9b76-d4ed3bbbf535@siemens.com>
 <874idm2okc.fsf@xenomai.org>
 <c3b7ca5c-cc7f-442c-be5d-9b9e80b0f94e@siemens.com>
 <87h5hm17op.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87h5hm17op.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM0PR10MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cba92c2-e3dc-43f4-329e-08df40c5aefb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|55112099003|10067099003|261028144727099003|4143699003|11063799006|5023799004|261022075727099003|261026121527099003|261022115727099003|261021135927099003|261021123027099003|261021121427099003|56012099006|261026140227099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	w2lFPV6Swxr8kzFSfC/FKFknf0eX4c2CGGAIlcbXewfW2AxpENEIMyHkMh7NvKwWOWLvE8mPdSf5h9gZ+wpRCkq7CiwUT7DGp+2ZdYtIqU+tUZghuHeQdgAtUzdR9svjZTrIP2Rr2MTxtJJ4Ep/924w9/w6yUMUt4iypeXkEWbGKUaL1spFGw0d7aBenUazQUYAgn5TnJdB4Bpz/RCyFMabKJ+pAys3OTWBr8wdXwhuCWXNR+NsxFBrWLz6d4Jn6dmNJ7nLQUWm4ijN4BbeJ0ggYFFy9oZtlWSBZbOTsHvvPr51GGdSFhw3PeXDiHL7eJ3IqS/qVC1eKVlaNZoRZummeVCF1OmlwFk/bhJ1x3BlmEafRKdzbHjhwEFed6A/fsrGYOQvIGNP4sLfOmYNYE8bUKmLCCG0hpt7NuzUc7GAwd4XPVr8kT58/ut5yR5LMXkhhrqpPEf78arO0aSSGki6bvFk4C1KrtGgE69ABQxmvBnJvxJwjyP+rYr9MSzvw/64bNiCobkAv+/j9q1Fv0h64DMedE21ejTMA4bIXzLYMATekkpwQ7emjMvt1vfTh/0I6IiWE9q7TXojIIW1/RkBXigL81cezvvO4kEe8Oktef0ZQxVzHuoRSUQjDUpffMW/rAlaJRMuzJNrcW5RFgz/0Fi3W4eMCgOzKHwuu7WU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(55112099003)(10067099003)(261028144727099003)(4143699003)(11063799006)(5023799004)(261022075727099003)(261026121527099003)(261022115727099003)(261021135927099003)(261021123027099003)(261021121427099003)(56012099006)(261026140227099003)(261022105027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJzZG42THlleTdjbFpPdExHTXEyZlg2aTUxak5SQ24wQ1l6TWQ2THJ3WjRs?=
 =?utf-8?B?VnBGUVNsU2U2Y1FiWkIvMEdHd1Z3WlFnMzlPSW10Q0tseFZBR2hsd0piclBV?=
 =?utf-8?B?bHN5dStIRzJFbWJ5NFF1T3ZXQ0xOMDVscmlOTndrWndUYkJKTXdZdDBPTi9q?=
 =?utf-8?B?c0ZDK0paZG8xdTgycmRVZ1Y1aE9RNCttd0w4R2ZKVlRxbU4zQ0x2RnA3bkdz?=
 =?utf-8?B?RllSKzdicUN6bDR1NXYvOXQxNkRjUXk2OXc4WWgyWEgzYWtJc2FvdFQzTENI?=
 =?utf-8?B?c2NKcDVvYzlERGI4WWR2ZG92YVVLTHQxRFpxQklrWlM2UXV3bXBxM2ZzamRs?=
 =?utf-8?B?NkxtSFltMEV5eTFkY2d0WkhZM21TM1h5WWM2alJ1TDlXdkNZMVBCc0Y1MEg0?=
 =?utf-8?B?U3NCSzhja256NE92VFJ5UHEyQmdmWFJoYXZ2NkY3VVNmUk1jSUEzd3NNM0h6?=
 =?utf-8?B?eWFKSW01ZldWK0lDditZQS9qNXJxWTNLWnl0aUwzSnk0M0VLanIxd1UvWkxh?=
 =?utf-8?B?RjNGWTJXbEpmYk9udWtiOHZ0T2ZoblJueTNiZzlINFk4cEY0WDcyMDVseEg3?=
 =?utf-8?B?dkozalh0WEorR1pQemYzc1JOL0pmTVROU2lNRlNyVG5Rdnd6dHBtZnFBOEMx?=
 =?utf-8?B?YUY0QjVabUUvZzFhTkpjNHBFNWxySUNSYXkxbFFZRWFEZk1ORHU0eHk3OWNu?=
 =?utf-8?B?MkQ0Vk9nN3dwVFJmV3FzYnRKWEdqRmFWZWErdjdydnYzTVFDbDM1VjYxbVpC?=
 =?utf-8?B?MmgwcjEyQU5ISjlFSVBEVXVyNFp6QVNUYW9Jc25GeHNUR1hXeDh3WERhQ3V3?=
 =?utf-8?B?Nkc3b0pBWUVoalk1aytveC9mTDNlZWxsK2NYc0s5OG5rZy9wNDlqT1FpUGlG?=
 =?utf-8?B?TkcwMDh3aVJsMVdyeVRZQktiS2NNY0Z1djBMMC90S2xtbzgvSDJOR2RxbVZU?=
 =?utf-8?B?bnlXYStsNGVLdC81TnNmcDJSUjFjQXQ4WUhhTGVYa2xOYlpjVmcxL0VJKzRC?=
 =?utf-8?B?MHExbUl1MTdUSU84NzRESmhBaStoSEZ3V2ZzeDUyRE1uNmRRYlVJTjNzQ1Bj?=
 =?utf-8?B?b1dwdHJsWWowbjRRaDkrQWhXQ1YyRXV4ZVkxUXFzTWpxcldVZnNUOEZDaXFQ?=
 =?utf-8?B?TEI3LzZQUFhlaXhJWTRTSk8zTnFnc3BhL3U4dUVtNHNneGg3eldFeXhvQkRU?=
 =?utf-8?B?YUNlLzc3amcrbFg2Ly9MT08zSEF1T1l0VXdHajlXV0VoMGk1cjBFNjdTR1ZD?=
 =?utf-8?B?clhSRlB2d3NOWHRpZGRON0RmOWNVbGxGQnRiMkFSMWFzNXoxUXFsTGNmemFQ?=
 =?utf-8?B?N1JkNWc1QjFqdlp3TGlBZUFLbGdOTTRZL1hnN0tsRkVxWCszOWZBKzFpTTdn?=
 =?utf-8?B?eFAwTEdEaUhHcTlhVldqYWdqWXc0WDdQVlF3V3NLRDMrdmZSaWJCSHFJSFo5?=
 =?utf-8?B?ZDFFdmQ2bVpkcWEyZm5vampUa1JucG13V0NQZjg5M3Q1RFNkVFA3MVJCZzJ0?=
 =?utf-8?B?bzZja29tS0lVVmFZY05rdFpBUXo2YVRFbTFxcVByVURhS1RCQjlFb1dGS1B1?=
 =?utf-8?B?QmVvcjB4bDB3UitqUTBtalZVRjM2MkRhSHdPcW5KeUQvRk5iM2p6UURDVmhu?=
 =?utf-8?B?QzlhN3BaWXJxUWxObUR3VkMzZFlJaHVNcnJOZDZha0hVcmR1SU1jTXZIZXVT?=
 =?utf-8?B?WHV1dlkxSHplTEdVZlY2N0dZaUQ5Rk0wU2dJOGZCeUxSSjJqdkxaWmdwcklW?=
 =?utf-8?B?Z2xWWFF5M1BwNVc5RTgxYkdpYWRicXlnSFZpL2Z2Q1V1YlZoTmtuamljMlUv?=
 =?utf-8?B?WFNhT3VRY0VTeUJwbmV1TGwwWnJwZWI2TzdOSzlzRlZoUFF3QXBCd1FSVkZq?=
 =?utf-8?B?S1lkVVhGTHhVV1R6OXlFd1ljVXN6VzN5TDltdkRURDZrVnJiWDYwNXArWDhs?=
 =?utf-8?B?c0xZQ1JTeVJRQ1pHdjFrcWovSmFsU3pGODdsUUZLNzB1ZUI5dVl1d0FLdlVQ?=
 =?utf-8?B?amI1Vmx6dmhaK1BpWUN4NENlR1ppU25OdHRjRnFzNDFocTJOSGFLTkdUZitq?=
 =?utf-8?B?YUM2RmNNRWRsanh1UkFIUS96bSsrb0NCbmgvS2RCbWRtYUJFbVpqV3djRCt1?=
 =?utf-8?B?S2ZZbzNnemFRR3UvUzJJWE1SRkFkTUpPaTVYMWk3YmhrZmhpSG5ackVZL2Vn?=
 =?utf-8?B?VkVRTTRZQzZhcXpBcnBaaW0yeHZiR1JCUkkyb0psSW9OY01kdVRRR0RnUEkv?=
 =?utf-8?B?bUJ4U1VIMGFaMkxLOEFLNXJSTW5wbkQrbUNPSU5ub3ZMeGhmZUNrbFMxY0Rn?=
 =?utf-8?B?QW40TGZFNTkySUNHbnBOYUhGWEdqN1Eybi9BWlZ0dHpteStENzBHZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cba92c2-e3dc-43f4-329e-08df40c5aefb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:03:09.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drHl6nxn9TFDiDzJGHbaBoILvevOWoT4hOp6MgftiH2NqUQ4eXFG28pE+bzsjI/jErqotu++0KBcmTKxKrX/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB9624
X-GND-Cause: dmFkZTFzr9Uhpe1sNUCC+hXenLJSvL2DfkEEeLfwGnPten8grLli7JlaVS27YKmsIbkZ/dXLNH0JwQ8MtCWLwXk/nrqH3+Ibiyqzn4yrK54BqOXtkyIh9ZwdyqwWXJxHxqzY7LAz2r05BDmowEONmQRYiyOP7pnKNrOABbLJ3xMfs2z/k7oF62Poe0ThAYXr/gtXhx/y7qsp+oDUgTOKWn+KQ35Vv7mv9h7fDekDb9CIHhhOOZQ3fokZ4nCST8wOGB2cXoOIDaISp0B1fFlTMfMVuaI7yGMo4N3mcwYq+miN7jplQsYJRF0u1Jsu/Jsw82hTQC9r6kXR5ADuW6ljI1RFN6ADqWBuw0aSiapsjk3QxZknhBS5IG/kYzaxvI0t1JDvCBfZANZxQSvj5VsocXJqG7YdKTuvLkBt7lgHz0afmMJqvHOrvRFro01r2GkMEYPVFneDAHvek2/3eOtFP3ClZKW1DC1sEAcqC+/OZnNEAEAECpctVzkQAPyhKCq7Tw4+n3bc2ZR1atoIr1R4ozjgEluEpg0RfZaf5i9VxRc1AX8itPH7weguqEfzzUgCRuptuZb1sxq3njXijyPSPm6h6WjqDxIXygMkkbfYukPRSoZ8PyCdJkqGoARcVr2xJnNLH0baaAFGIAWodB+EgXF1UERHqIVAFhxloJ3KIhckKfjQbg
X-GND-State: clean
X-GND-Score: -100

On 12.11.26 14:49, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 12.11.26 13:59, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 12.11.26 12:39, Florian Bezdeka wrote:
>>>>> On Thu, 2026-11-12 at 12:30 +0100, Jan Kiszka wrote:
>>>>>> On 12.11.26 12:25, Florian Bezdeka wrote:
>>>>>>> On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
>>>>>>>> On 12.11.26 12:05, Florian Bezdeka wrote:
>>>>>>>>> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I will share the lengthy test case as well once I'm done with stripping
>>>>>>>>>>> it down further (if possible). What the tests already demonstrated is
>>>>>>>>>>> that unpatched kernels crash.
>>>>>>>>>>>
>>>>>>>>>>> These patches here are almost completely generated. One of my few
>>>>>>>>>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>>>>>>>>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>>>>>>>>>
>>>>>>>>>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>>>>>>>>>> of them I already shortened, but most is still left. We can cut down
>>>>>>>>>>> further, but I would first of all like to have another review round.
>>>>>>>>>>>
>>>>>>>>>>> While doing that, keep in mind that AI tends to ignore issues left and
>>>>>>>>>>> right when being told to do a specific task. It may have simply missed
>>>>>>>>>>> further preexisting issues or even created new ones now. Watch out!
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>>>>>>>>>> that you are confident with those changes eventually.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Those patches should not go anywhere until they reached the latest
>>>>>>>>> development branch. The common "upstream first" rule.
>>>>>>>>>
>>>>>>>>> Everything else will add a lot of confusion.
>>>>>>>>
>>>>>>>> The v6.18 application was experimental, to validate that the test suite
>>>>>>>> passes on real hardware when all issues are addressed. Nothing is
>>>>>>>> official in rebase branches until it is tagged, including those patches.
>>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>>
>>>>>>> Why not just push out a wip/ prefixed branch? That does not require to
>>>>>>> temporary update branches looked at by different / more people.
>>>>>>
>>>>>> CI is not picking up such branches.
>>>>>>
>>>>>
>>>>> Which is OK. Those branches should be tested only when requested
>>>>> manually. The "internal" infrastructure has such a feature, while the
>>>>> public one is missing that.
>>>>>
>>>>> Upstreaming was not considered yet as it highly reworked the xenomai-
>>>>> images project. But maybe it's of interest now.
>>>>>
>>>>
>>>> I'm not using anything internal. If you have a patch for the official
>>>> one, please submit.
>>>>
>>>> But pushing to -rebase is also not a big deal because it is, well,
>>>> rebasing, not stable.
>>>>
>>>
>>> The dovetail rebase branches feed the evl trees though, which follow a
>>> rebasing model for a reason. Although I'm not concerned by the specific
>>> patches I mentioned earlier which look sane so far (review is still
>>> ongoing), let's keep in mind that dovetail rebase branches are not the
>>> right place for unstable work. As Florian pointed out, wip/ should
>>> preferred for this.
>>
>> Rebase branches were and are not stable until they are tested. This is
>> what they exist for.
> 
> No, they don't. Rebase branches are only a workflow for evl which do not
> assume that code might be unstable in there, only accepting that bugs do
> exist.
> 
>> Once testing passed, we tag. This is also how I run
>> all the stable versions I maintain. In most cased, the tagging goes
>> straight on top, but I already had to fix up untagged branches in the
>> past. Or rebase them once more because of further upstream releases.
>>
>> Now, if you ever tagged evl branches earlier than dovetail branches,
>> that should be avoided in the future.
> 
> I'm unsure why the tagging issue is brought up, this is not the point
> which is being discussed. The point is to refrain from changing the
> semantics underlying the rebase branch arbitrarily, only to find out
> that this may break the evl development that sparked the dovetail
> development in the first place, nearly ten years ago.
> 
> I'm generally ok for improving the process, like getting help from an
> LLM for the mechanical part of the maintenance, but let's do this with
> every stakeholder on board, participating to the decision.
> 

Yes, we need to align on this. Do you have your workflow documented
anywhere? Then blame it on me that I didn't read that. I only followed
intuitively reasonable patterns for many years now to ensure that
dovetail is broadly tested and based on recent stable versions before it
is released.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
