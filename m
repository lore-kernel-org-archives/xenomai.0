Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332610;
	b=ZqI11uaXv7TVQkQubsN7di3OXSbUr/BAOv7xvJ5KM9i91Ds5H69O/yCJ1fhjSE9LGYwN
	 MHvLU3udxRwProa+26WrfyUI7YqpBQ6G3f+mIxwzvWi/QPidsD4pysbOKQlsLCItLTIvw
	 JDXpIrI+k69MM4YgnCTtdXQURwHsjqd57RQKrv4gNPNN9XWIWWI53BbFCqcnYN2SeordN
	 nDjk3QnNvidSsnhLI/OYAFY52nsI4ii0ADK/kcTTOfgD6QU76/SNlesQtdLLPjWw1o+K2
	 Vm9NFfdfQlpV35ouylkuAKY3wV2MwT9c2gzMVNsBwoKwuvM0oKksG95k45u4dT+UdYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332610;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Content-Language:Autocrypt:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QSk4QgRWcK5kqw1cLWFXvLb6KkwH0t00tJayN/dgNDA=;
	b=Ti5KcTDVxsVkncyQ500YEOXDNWNLK+1pfISh7vIaq+HN62X7b7vnJTF2Zwb3EHUl+kto
	 jPPw6tCb/c26G63sZh2LyWu19Gc+ZqSKPOAYsga7+5IIzm+ojuEKQJraJWS9ndKluR2f6
	 TQpMlZ84yLkBZvSi+r3+NgmFHPeTx4Cb+2gKddDSxfdyoEkyKVFjfiCvsHPHt5e8eWaCp
	 /eFJK0mWatOCm8Kg1Lo+RAgwXraa82B/IG0fEfDHUGaNvJ8yiK38BnqTp4VoP1PPZPHL4
	 ZMGtDw7p1qrEx7IcfnLUexJb16UTBrblenUsMtL1qOz2hG5c+OqhmEDeT5sKQ5se7GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=AXBwP7yg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.64
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CD606A320
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 17:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F6CD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=AXBwP7yg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJlAhM3eGgQ0b1Iqr6xm7wPntsBcJakuVYdM/whzukVZrkzq9DExZEugnvfabaVsuXkMpkYFTzSzH35tGbfFT7acTMPOJUC7NqVGbVrWeoJv/xU/W9GHU4TG8H2uohhvToQ5Y1krFjuLvxtLSSrMDyFkQEIPAjirnijpjO/9Y/w0pmNhuLePIuXN/NoDgSdm98Ls/afZVhx7ybEMmg8AJtxNmM37YstKdRzSz4ZodSszc8gELTvOiolCaX/52Fx9lonhYoqyBgGgYNH5tfwIKRemVGPYC3wjrrMZrdZGfJkjTtcsw3FSQNzwcc+qVx0K8dcpbdYLElN702fixrxdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSk4QgRWcK5kqw1cLWFXvLb6KkwH0t00tJayN/dgNDA=;
 b=ORsLyeD03susgsUaePlpAqIagaRMYgBh+nwJwB8DD1ZSXViTX64Q01G0+fEVdHy+PNyAINJwAr1HWJ5wOpaTTX2Vhrye9/Sb9FvwpypjYUt+JxjZM1dfFxsq8i8uZKjMAToLRLV674Dx8wJ3d8KnVU0u4sspRSgKs8zr+P9mFlsJyMvF9ktEy3MA2hmOk8anG67upx90enI573PyuhfnLn4bMPt5EH6SZutGTK8vmbLP/nbH5hg3M9GlBSNpVhCJuyyDxUeNurQ5gGIgL65slos5Iv2ZfozRuuOLB53QKgkyVuRCAe+C+3/23oEdiKANGEDoVhz6BAUKytMR+DyvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSk4QgRWcK5kqw1cLWFXvLb6KkwH0t00tJayN/dgNDA=;
 b=AXBwP7ygQZTXXidjCxV1r+lRLsGHERr2vrbWnxUDBqY2OMeAwCILF7tcWygbdNGeCXbw4bF3DgxouWPCbsC/osTsty9n3mZ/DGHVvygf15rFjUOysve/P9tUdIN70ihzQGUE5Zb3E8XLhdKqgzc1wOrZMlmfdWd35+HixhQYwVVJdZ3c7synIJxZ8e52SFMFnwVlSELvmynwLVVGeJKvuQwBFv1v3Pgc4zSpe6gftC6UApLjbF4XMPLQi6B9RflAbffeBEL3R5azeS798wXpyKjefXyL805T/w7WWVnmQDni/q3LUd4pEuoQicjPR3Bz5fOL+9s14MhAobLv6VGThg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB8074.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 17:43:27 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:43:26 +0000
Message-ID: <33ce72f2-0e24-48ac-bc67-c01f32b632ab@siemens.com>
Date: Tue, 10 Nov 2026 18:43:21 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, November 11, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0407.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::22) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 455ed468-a7ec-4fc2-862f-08df3f522004
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261009223027099003|10067099003|261028144727099003|4133799003|261026140227099003|261026121527099003|261022113327099003|261021135927099003|261022075727099003|261022105027099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	GcyuMGRQsacsPrUvi0/yndXhghoAiac+kkM6Yu4ZzXvNKQ82Gg5UqjIrwwH41O+GfQ7C7Mj9ib4VMW8qnbCnlnrscZjsAy0NTJEc1n6OhxtPEaQI1nbMus1NpNsiGCINtO1GM5KnCtglv89husug9W09YAJqO4y19G92OaSwIfn+8rH1U/vM6+shde0lTD/c2Q05K0CCoUJR8+FT/hebRznuCAqyiiNS4ZDli97pGk6esfeQmeBlGHjoRvtr5aKtzR+75GDronmE56i58jncg8zSoV6py9DC9kQyMVDQDBPPbZC/aTJQuxNNdb7xesnMaf4F1EWOm4JIWWASRfJZlvsDhRzoIi1qgd3CM6tjDp7q+OnduaHSEiP7RvHhmt3/T3RUUsIggqJok4/fG0RnIs/XTTc6urg2CkIbk2s9Lr0hS5JTderYpq6IfQiglZp0+CX91TfoE4QcQRrNZpMhbE96yUmVv1AAoIgi7LnyBQthRgt7n6Yhqa/jwxs472WiyN7UKsLWC5UQ4ih8aSUnGcpV9KzzK47kJLbwp/ehAwkVrJ3orNKW2yefIqQXq5H8O8zG5AbYcBjj+YfJnQJ7lQZtvJd31NJNbKNuYt1ynZos3pRHfBR2ELoXE2wjXllAUCD2dMipeZvd3L4m+JnU55FW/tE/Vq3CwuTYBZbdtgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261009223027099003)(10067099003)(261028144727099003)(4133799003)(261026140227099003)(261026121527099003)(261022113327099003)(261021135927099003)(261022075727099003)(261022105027099003)(11063799006)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a28wYmgrTGljSUY0RFZ2VDRxWWRpQmc2aiszWDQ0bnJtRG1EbFZqck8rdS9X?=
 =?utf-8?B?YS9WaDJJOFB0c2xwY0JPTHBNNTVMSjBQbEN3ZE14ak91RmovWnd1UGM2WGdz?=
 =?utf-8?B?NnR6Zkx1aUdQL3F6dFd6MUk4Z0d0b1pxclhQa3dEN1dmNlI2MFE3bXRIemZq?=
 =?utf-8?B?MlVwMXFkZEVXRnVraE9rQm4xdlhra0JoOVRIL1ZjNy9yRS8ya2V3b0Rob3Bj?=
 =?utf-8?B?UXhyQy9aODlkSjM4eDJ0dnRzdXI1SVpBZkpOT1MyNDBPZEQ5YXZHeVZOcGdI?=
 =?utf-8?B?aDNKSVBEaFY0SDdwWElJcVVWVjZhWWdKUWtUQ092WkorTTV6WmVwRlNaWTNL?=
 =?utf-8?B?OXFHbHpjdHhsRWQvdGtiVytSSWtoUHJ4aWVUYXhwR1hLdFoyMEF1M2RJcWcx?=
 =?utf-8?B?dkZWU1Rpem9lWFNkWWluTWQvNnhpVlhQN01QaThlazhRNi9SMWRiMGNIeTM0?=
 =?utf-8?B?QURJbytFbGwrUWM2cHZ1ZFJ5YzNQRVlqSUQyK0FjQVBpMzYzTzNqTXhwNlVr?=
 =?utf-8?B?eVkwLzFlU3NLUmZ6K1M0U2FKUDFGb0x2NlgrcFErT0FVemEvbVRaUTJZbTZ6?=
 =?utf-8?B?Z2ZPbHpwWmovRE5yVThocFloamZ5ZWRlRi9pUEF2WmQxZ1BBQmMxNzlvZUxE?=
 =?utf-8?B?Qm5MMldvS3d4RENZWGRaMW5SYmJIdnQvYVI2aHg2cWtVamU1ZmcvaGp4OUlr?=
 =?utf-8?B?emRIVXRxbmJULzlDUW1Gb1Nqb3grYW1haTB1MVYwSVFvZ3QyZmZielBtOE9E?=
 =?utf-8?B?TXlMRzJCWi92LzYvOXgvbEplaGdxcHZ2Q1NrNEY0d3hlOEE1bFlITlcreER5?=
 =?utf-8?B?RElMcFh2Vkp6WUpKc1ppamNzZHF2M3hHakIrV0N0VXh0Uk9aNC9ET3hLdE1O?=
 =?utf-8?B?QU1CWDU0ZjFNTmpNUzdZYmYzYkZFRkRsZUVoaXhBUVpTcjdBRVVqMlB4aFgw?=
 =?utf-8?B?ZGs5OEViMUVGdnpxczMvMEtDV1RBSVlVWGRrTTNvakRkQXFGZEdwSUFqVW9h?=
 =?utf-8?B?M1pudnpDQ3d4VCsxSVZTTkxpRE9BL1l3ZnVrcy82T2xubUMwOVpibTJqMGhz?=
 =?utf-8?B?WVMrVnk0cS9UN0VjcnFWbGZlSkRVSDFVR3dobG9OdnBkSUxCR0d6T2lqVHRP?=
 =?utf-8?B?QnRQOVBneTl2Q3hXQ3RBSlZFWm5JemtVQWxUeWYrNStMSFpZT0d4S3Z2OE4r?=
 =?utf-8?B?NURBUCt1c0dzalRxcHRTOEdVakVETGlYaXBYaUwvQVZGYkVIVW9hSVNmZTM5?=
 =?utf-8?B?M0x4MGF2blR6TldtdjJwSXhZVlEzek90K0VQMnhiTEIzT2xBSmJlZWwzZ2lC?=
 =?utf-8?B?ZHp3YjllT0s1ZmlPVVpGdS9Kc3RqWTRxc3lEWm4rS1d3QmdtM0FlTi9oK3FM?=
 =?utf-8?B?emJ0RUtOZlNOVjhPZGloMjdEb0U3TmNzbnBpM0wwVGZTdk9ITHVzQWxEajZO?=
 =?utf-8?B?L0RENmgyeUtJdVZIenlXa2I4QmplNDgvT2o4Y3c4dUZYWGZrampzcXdaYmZT?=
 =?utf-8?B?ZVYxclJFdGphejFzRGxsbTN2V3FLZCs2THRKQjMwbmFCQzZPcC9XQ1Z3WkM2?=
 =?utf-8?B?OW9LVjdBUThpNmpDTXc4cFIzbU5EQi9nWVppdzRLRnR0Q1N5enhyeDBRalNj?=
 =?utf-8?B?Szk1bWd0U3NuQlJTWUQ5ZGdJYUhINWNqR3gvOWZ4MkVBdW9jUHJXUTNORGJv?=
 =?utf-8?B?VGJUWllaUUpLaDZLMVFkbTd2YldLY3p0MTRHcUpVWjFlSCtjR3hxeW5meHMv?=
 =?utf-8?B?UVloQUhDaHdvMHpkc1kzaEptOFFraFh4Vkk3WTd3Q2pwOFJsTDFrd00wbW5I?=
 =?utf-8?B?YjU1NHhISWcvVjZCb1ZQUXp5Ymp4OStmVmlVK1ZQMTNCM2UvR0gxRXdKRjY5?=
 =?utf-8?B?ME9tYy92Zml3a0YzY0VPbTBqUzNSbC9pNjBVMytsS0NySWsvd09pWTlqOE00?=
 =?utf-8?B?VldYNkttKzB3NS9Wbk93Um1JSGdxcnUwVDlHNUlIYTV5aE4xZWFpMjFhVWVS?=
 =?utf-8?B?RUVqWTYxWDRyUnpFRy9ucjRBZnJ0c2E1WVg5bnZreDRnWHBCTnFSaGZyaUdI?=
 =?utf-8?B?RktvWW1JZTNNbkNWQlM1N2hsQTBTc0Qxajl3SFpmN1lqK1h0UStZUkZEbUJ2?=
 =?utf-8?B?bnJTZHBCSWpzNElwL0ZEQXZhbUJIbjJkR1dwaThxVW1DQ25tNlF5cU45aDN3?=
 =?utf-8?B?ZjhCNWxuOVR3ZmgzM1Vpc1NOQklCMzFLbDVOMXZFdCtzMkN2MkFwMUEwbGFp?=
 =?utf-8?B?anBtZ00wMkZGei9iWU94M0YvRVg3bkFTM2JGR1RvYWY1dUJzVCtkS2hiMXFH?=
 =?utf-8?B?TG5HbXlyLzJlWTNmbmJEUnB2UnFFQzhHRnRKekJqMlZlZ3U5aU1ZZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455ed468-a7ec-4fc2-862f-08df3f522004
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:43:26.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEIUlrYY2aUEKz5QsssKsA9oXDuAXeD6sE0zc3thRRAmFLrnQZ3nc9MtcbjnvP3bMhSzwEB26VXuoo/6Lc0Z0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8074

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, November 11, 2026, UTC 7:30 AM
Paris, France CEST 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
