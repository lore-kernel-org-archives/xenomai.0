Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795070432;
	b=4Tx1Ej3zhLAGyHUULhJzPFWK9Pu5oKVxH6x7ffY0IH3Tm3/EbOLYx3SGvZNuc6kmCkMG
	 SZQ9/VpWLitwemhKIviE+ag3O5Dgr053SRpEOzVJtSX/+73oD+vtsRHwWWFHcc3ISCXwW
	 +iyPOxF+S9TyNfEZ5qItBKUBeg/CH+1bG52PPYdHnAZsYtm+WZI1XhxTf4TBMUhYxMLlS
	 alH3ifnbJ5vBFG5tY5hFpTMYEG4ofZ0WXbbpeGgPZRt8XFE2pdmAyhrmYiTcttED8U//3
	 TaaEaAdOD6uUJvdjnUO/1FY2eT5IAhPZSyoYuYcNG85CQ0RFFqOIwE2mcNbyOyyll1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070432;
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
	bh=d/BgifBhTnLKRcfh6bhCCNVGKoeKnRIVwHrSPbTWLeo=;
	b=Ef3/abkxpvcSZkWJkFfNwHaq3kipJwF5du6eCylci+J+UQ6JUdqwJcRfAzQ23MTVWc5u
	 c8ETlV0lSkvgTnjgkX9IP6a7JiMsYqgCGI+AFYTK5zqLmsmCOgwLcjsaJ0/DJxev0x6ef
	 LjpkPtBfPD+bmXSXn7a/+dX394EydJWJ2Ct7SekKGVnzIAGpRjJnlf0p+CAdHgh1kGKh3
	 7x7Vy+haPwi2QqbqZUEcV7smTjKFAGlvqpnJLYxDYX5MHTw0FcGla7fTrEzU9xR33vgd4
	 Wsoarl998qcrwJjBj7KoaEm1Mjdr4FPVBoQ89ODyc/8e283hZe1Te25DzU6+Z+HIkBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=I4CfECP2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.47
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCD606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 06:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCCD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=I4CfECP2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=insHS4nbB0ELLEmG2oNDl5CcfhT67uTy4sfnPIVbJxMWiXY1kAaLWF0cOQwNVO6t3cQykWu0bASWEcL/dAAIbImUP7PYBpmGUdSQ1W5C1su1oq2lcFbdKn0gSYDMyCEd0r5tC6PIQ3/wO+kf1rI5aesJ3nR30w2cpB5zbizQ1THpP3NSkUk/Zu5srpB5hyZ57OhIs2d8Cy8Y8/9KY451Okg5Iml0wlyqOFWnlQM193Xn8pN3af+7FbCHyRzmVsb7HBQWD1/DLm80Wl6btpMrwOJtpzuQ8Kq64CMxb3ibhFfPHKd1wlF50QeXDID9jKNzHpbSrk6zlfNJoQDspZK3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/BgifBhTnLKRcfh6bhCCNVGKoeKnRIVwHrSPbTWLeo=;
 b=Bo/70MOWoKJZr2vsdz4w4zttSOQm29ThcaFK256s9LetgcXZcC4C/v/qziBBiElLIK5rzKPaF2eRVv7ziHMJJDxMAMFMtjXm58x9BRCjf+l8b8oWzxMGlVM0P3RPrOlptiON4v7lco4V6rRhe52WPx6ki5rFggYExfTrwbX6X3Ed6uvG++x4Mo1JM+BTwmwdx61/R+J6I5XKRSCZSBkkFQ7a1or4/6RK+3+m3OY6k3xpnN5Id4QGEIEy9jbqi6P9XV5HVnQto+yHV3oWQVT3poBxTktocZK/L4uTpKzdKC3vkeJvE4bugzYM2xTGnrYVQbrpbrZ7eWkiOQg96+op8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/BgifBhTnLKRcfh6bhCCNVGKoeKnRIVwHrSPbTWLeo=;
 b=I4CfECP2ZbNW8liWbivVAPX6xkX9dRt4yrIBJ/lK4s2voPowgMuNfsczxB7LjqpiyY757QsxD9yNo1yLBjAZ8bdMApE9Gu7tmQn0/WmmhAs0lzzL6og9x13wzuHy9qgvaBa3IfNSSaIj/IGff6uECuiWRw+6TuqE6AaiSyMnnFk3X/BGlvZcNs369ymV/s+wU8ox8Q3baiwbO0yxU7cvfCT7pGMKQs13KOx3lhGon98Q1kK2e7C6eEzqFPDWjbRrrciNmWs3uDNY9qvdy4ZOtj4LtZhfTx2iXnWNhlzw8fITnLrDIOKCF/ykw3KPAuNS5kNGCHx/wESPKxnmClp5CA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB9389.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:2ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Thu, 19 Nov
 2026 06:40:28 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Thu, 19 Nov 2026
 06:40:28 +0000
Message-ID: <adf07ac3-1539-4a65-9344-b5c66d4e8fa4@siemens.com>
Date: Thu, 19 Nov 2026 07:40:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH] clocksource/exynos_mct: irq_pipeline: set
 clockevent IRQs
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <5a8651c3-9f93-4ae2-b1b4-0fcbdc5a1501@siemens.com>
 <87mrr6ecc5.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87mrr6ecc5.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 78becc71-2ffc-4553-db4d-08df4608003a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|6133799003|18002099003|55112099003|11063799006|56012099006|4143699003|261021121427099003|10067099003|261009223027099003|261102123227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	oKd28oIk2qurrHMRXTnxwMjFLEPuTlSXSH5AC8J8LbnnLTLKrZrqfrkfK3bU7avEpBxjfEOpqBSSMlUALMbcDt6L8YlbXVXKyjhaEzo34x5SSvYAYZn8YMsrl55S/bKu+RFhUY3Z2MJBBMYrSEKKU5cyrgZYCNRLbovCCxNpnBl6KR1EkIK0kHzonN+ykbm4aa4PDBZBAAIYiuBcWr3aB7lCkc4CObqDwLt+zGH+1A41+KzClT0ju4kaFCRPaO3MhvkQqy7+2RXAPfIUF4xOoplXb0FNSlXkP67l5PXf4Kk7gfffpkt8HvFxgnYDIstbsD0O1wMXbiLkUxFBORj7OyxJUVAiwr5nW+yTAQRrB7CiWGTUo7tY62oged//sjkKPVAxf3f3FbC9wImA9uqF+som9H4+qLFLAguVkDHpD5QFUsBh3/UhIA2qCBRy0i7ljzXitupkzSuURxz9XCOIlFBCgklwerKDvGNJHVx1OP0bBq7TqqtnTqs1XALsW4/RabwOR7sahzmxwzjU11dwR5YcPCpd7cteUXK85Jjom1/eO5pIrnJ7FIeEZw27sAiIXwLwJ7EJM4awMNrlPLai2D57qujSReSwNmaPDszvTpogPaJC5IzqkzX2+NGhbBIt7xZKjQKyPrlqq+38Ta0a5OAZe6mEvvl30QX0egbISEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(6133799003)(18002099003)(55112099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(10067099003)(261009223027099003)(261102123227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjNJemZTTTZpSnVaTG1abHBhSE1oZHFBY1FIMVNPZTUvbm5xMXQ2YlN6cFA3?=
 =?utf-8?B?YVZQR1ZsbjZOeG9pT3p1aWRZb1pFMnM3SmMvL0cwNXIzVGhQSWt4bzJJMG5v?=
 =?utf-8?B?QzIwY1Y0Qnlua0lIYk44Snh2cGxHT3NBOUpweTFSNHRjWU82OWJVTGw1WDlY?=
 =?utf-8?B?QUxjejBTTUgwaFJ1R3NPdGJraTJVQUF1alROK0JYUVA2MEh1MHpoSTcrVFlw?=
 =?utf-8?B?SEJmbEpxZU5ORzZOMndUM1RRY2RFUWF2blk0YUFxNG5tVG03VEJmR0o4SXlj?=
 =?utf-8?B?YW1WcnpwZ2dZT3EvVDRpTVNCMVowbjhrd0N3N2pmTGJxV2N6cHZnTG5IYnNV?=
 =?utf-8?B?Mmk3Ukh5cDZmVEtpQUNyOGZHbVR0OGhyTDhBZ2g3UVZBQ2RmQ0hzbHkwd3Bw?=
 =?utf-8?B?N1F2cW9GeTYwZlBjUXprQUMyT1RxbzV2QVBleVpzN21udjVUVFN4UWdiNFBS?=
 =?utf-8?B?a2QxcFNtT0RROGNEMHpQVVVDVm9UZHd0UUVQT0VBTCtUMlRWY0F1cEM1TSt4?=
 =?utf-8?B?djVmQkY1QmNubWkyOEpiMWMzZ2N0dFpMSnRGRGI4UlJvclA4WGRjR3NKUGM5?=
 =?utf-8?B?ZDBPSDFUbWI5NGtibGZ0VWtsTnFWcnJmcGRzcXFRTWlPMVV2ZHptSmhTanV3?=
 =?utf-8?B?WEsyRE5CZlZ0aWt2RHdkelJuMThhMm5CY0QzSnQ5Y25GT3g1eHN1WXV3WXNU?=
 =?utf-8?B?THRsTHlPcDkxdzMrRU9ndWhVV044THlvMjN4QU05WUE1c0c5MlJwYkhJYWRo?=
 =?utf-8?B?OFJpZUUwQmJ3S1lZRnZvYnZod0JMQ0xnUUIyMFRKTHhaTFgzVHlPZFBxTEdz?=
 =?utf-8?B?anJUYVY0emtIV3E0SERBTXBXU29meDNHdjR1bkQ4UDZkTTZBNE92VElqQWdK?=
 =?utf-8?B?Z1YwNVZjU1c2dm9mTmltT1l5N2hYSndLWStXTUw4OUFXTmRoVnR3SDEyS2xo?=
 =?utf-8?B?SFRwZ2FmRzFuSGZrUHN5ZkVHQkV3RnhzSnJSWFFyeDdnTndodThxYm9zZlVi?=
 =?utf-8?B?WnU4elpWQjY2VTI2VVpFYjh2WlJlblpTQzkrRDFrOUhmcVN0S0xYbEIvaUpr?=
 =?utf-8?B?Um4rZ09VYmlYQ2FXbyttKzJIRjVRTEp3amJENUFzc2xhTVBmSWtHc1NYdWpv?=
 =?utf-8?B?a3JBQ0xzSDI3aGVjZFp6bjhnYzFUeStVV2ZjbFZLNG9Rd2RjR3R2bEJZbWM0?=
 =?utf-8?B?RkV4d3RMNVIxUnVBTlNQbmluWVFueTlRb1NwRmU3dmRQWGg3dm94KzhwM1JJ?=
 =?utf-8?B?a052SHFXeEw5TGR2YlpNVzZKSXEvVkFpbTQrc2tSRks2dUxRUytlQnhkY1Jh?=
 =?utf-8?B?bWZJaDJUamkzZGowS2pQelBzbVJiaDhoT3hNQTRnVmFRTVM3SGpMZEFPTGhv?=
 =?utf-8?B?cXA0bWNLOVhjS2dUZzdkcHo5VnVFUGUza3JSWUpDUWxBSnJ4MUtGaWNPRkla?=
 =?utf-8?B?L1lHaWtIdFE1bGszWCsvRVh4a1BueE9xV0FDMkhnM0pzSnE4QXp4WUtzRGFt?=
 =?utf-8?B?T3JGMnlCbkgyZFk2WTJaaUk0dXlic0lxYk9ldVJKUnlFbzYwOUptOERjOEcv?=
 =?utf-8?B?T0U1ZThUOVhGRWZ3cVZmUHZXWG1BcVVoQmJHbThqMnFZR0VEOVc5czRhMi9Y?=
 =?utf-8?B?YS9LajdGWkpTdGRBUitUeXQrNnN2bVRSSmtkTUl5SHhrK2UzcDJsejk0aFB0?=
 =?utf-8?B?RzJQcGZiMzU4d2ZPZXMwbnRKcm94blZqTVNhYkpvcG1FU2gxbHJQNE1jRWJv?=
 =?utf-8?B?TDhSL1E1d0FEMVd1a1gvb3VNQ0ZZMTRNVE5QU08vMm5ocnJIMTgzdGlsS1JQ?=
 =?utf-8?B?M3NQMzJIR3dicjlReFpKd29QdVY4alVkYzBlV1Q2MGJha1l3cjRqU0w3WUta?=
 =?utf-8?B?NEV5S2crWUpMYmVjTFhEckRYWEpRc05qaVhqbFgvYlkxWS9BQyt2V3BMR2lh?=
 =?utf-8?B?VEJHazJCaEFMc0F3TGs5dGxKVHdIYkd5VXJDN2prVkZTdE0xeGp4TTRmVnE0?=
 =?utf-8?B?dW1wL3hRQ2t2RWQ1bnZuaHVWSzVWcWNxVkJzaVRlY281SHp1LzlnM3BWQzV6?=
 =?utf-8?B?STczelB3Wm1hMFRmZVR5SStGVi8vOFdGanJSMDEvV3pOSUVmQ1pKMmZNZ0xI?=
 =?utf-8?B?UEt2dlNkV0JkYW8wbEdiK3h4QU95eks0ZkNYVXJWZys2enZnZ3doeXYzSldQ?=
 =?utf-8?B?QzFGTGMyUlNVUGdFOW1Ic3p2T2FjWWcrRG1rVkRrVTl3Wm9RUEZFQ1lhYWYr?=
 =?utf-8?B?YW9zR2lKbFhyRjNhZ0Zla0hpdHFWTmRaNFd3NzhLUVBFeXh1d1hHQlVHZmMv?=
 =?utf-8?B?SWErS1V5Y3AvOWVNSDdJaHJsc3ZyZk52WkNRMjZMbzR4MlJTYm9EQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78becc71-2ffc-4553-db4d-08df4608003a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 06:40:28.8007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eMDQp8WKbKpMo2zs7ZmsswA2nbVrCLy59eFia3clhUKiDqz5aaI2i+nVfdgdzZU5ERrgLDmibSRTD+q47P1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9389

On 18.11.26 10:08, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The MCT driver only fills clock_event_device::irq for the local timers
>> in SPI mode. In PPI mode (samsung,exynos4412-mct), the per-CPU tick
>> devices were left with IRQ 0, so the proxy tick device never switched
>> the local timer interrupt to out-of-band mode, and the in-band tick ran
>> on registers which were never saved, making every tick look like a
>> user mode tick on ARM. The global comparator device had the same
>> omission.
>>
>> Assisted-by: opencode:Opus-5.5
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/clocksource/exynos_mct.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>> index 23d39bf9bdaf9..a548ac338f3bc 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> @@ -350,6 +350,7 @@ static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
>>  static int exynos4_clockevent_init(void)
>>  {
>>  	mct_comp_device.cpumask = cpumask_of(0);
>> +	mct_comp_device.irq = mct_irqs[MCT_G0_IRQ];
>>  	clockevents_config_and_register(&mct_comp_device, clk_rate,
>>  					0xf, 0xffffffff);
>>  	if (request_irq(mct_irqs[MCT_G0_IRQ], exynos4_mct_comp_isr,
>> @@ -487,6 +488,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>  		irq_force_affinity(evt->irq, cpumask_of(cpu));
>>  		enable_irq(evt->irq);
>>  	} else {
>> +		evt->irq = mct_irqs[MCT_L0_IRQ];
>>  		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>>  	}
>>  	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
> 
> Merged, thanks.
> 

Thanks for merging the first bits. Do you plan to push soon, or are more
merges or tests on the list first?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
