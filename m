Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325566;
	b=JEA0cwspNegtI3MUPYrqIeY4cmiqlG28+VXZ7i3JRVqrxQ/e0kWmPR4tIN5haKMLBcoQ
	 Y+zZ6FLEFuMMz0/TD9G3M2XSYor2AH3OZf8fi6ksYMbTCn9fOrHksqO8nZ9CzTSFBSP9g
	 whm4R1R4naLKlqiIrZU1L6+TKSy4ISMhAMkd3MYSfD22iYfSFZJlj/pKl9K/+1lT4a2xl
	 AbXkC1FLhpnccBUVQm2SLzkAZlqz/o3ZHhXYm7NNV6HxLYYV9Yo/MFg8Q7IBF1fxAOub1
	 A5WjMSpgj/D69SWb94C53rbMxy17vPYQ+f63t4vjpmpdeerZ1WEfLwmp5IlrrFcHejg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325566;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
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
	bh=WvZD2esMVTDf9u77RR0LQBa8CzsuiXX1WRS0W1Ro6NU=;
	b=nXX3y9FF5Po7fngv5pgLtJL0sMHzLeBU79m+ClqlJlxjdpxLXllHLPhATlgMneCWMksc
	 GDP5XGqoyYNi7HEMWAiC8oQKrqHf1K2FGGNww8pvafWxxjiksiFoTW1Xih/KHhWv2wNV1
	 HVSD1VswO6VMnw2ekIp9zBZOuT73zWo7NxGdOpq8Ukg9tAqdJrfxcKJnm992UQlCmhyYA
	 6+eqXRJe2HoTCldIyJwcd03FDJh/0zAxgHAfRKi3gvP4KU9dO+C379QwWYghpotGAMVS3
	 VrDo1Sfqc50Rj0dc652tk73+F5LSInF5wKq2FwWp1PlKFCTQC2h3lW9SEQY3KCcWqGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=VZf1b29e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.61
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B690606AB6D
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 15:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B690606AB6D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=VZf1b29e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIo9m8mkKmAYa1a3641cHy6yiFnsF5Tj7oDGnvi7eRknNkQAWJa8cOjFSO2Lh0SvcM/TX9sFn0wEC89bFzDPZFNM1L7VBqM1NQrlDrEjiIxPMsdHtBcliJ2NAYknK77aizwezv9jTu6cGozUdNdYb9sxq6DlSUxdIdPzwQ+cj0c9vwMDpginn8ziQs8+17an5Rh4qLggKrdNOf5gcwDomwTioHUnejrVScSKNnuWkrFsjaujSJQ5jJONjbKphK6bLFucuniKvSZjpM6jgPTWnabpK4c3EUNqHgYdXUxK7uBuSNrMur16D34Avx4TORGKM6+8g6YwZmaycVJshFW4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvZD2esMVTDf9u77RR0LQBa8CzsuiXX1WRS0W1Ro6NU=;
 b=M+Eq+uUcv1wzwYCUWWFyL3E22D6WeCSQR3ThfzJfSIinH1ZTLUHCPKy8rE2HV59pw7jMl++aK53asAkAZcQ+Dj19a8vFtJb8WT1TKXM8iMORzhmQ/mwO+nNsaLRNrOBPvwwaYCmYBpMeVJ7WE21Bdf4/26k/KtOW2YyZOpE42cMJ88gwSs6dB7Uf5RNXvUKTFslq6B7N0fc2Y3NQYXXGg4BV7+QrHGN+lrWnWSLitZadTNze5BWDOSvxuTHARnofvYaNsIpeMrlWndBj4lR0JsuKMrACcvFGMqMoHrG5ALuTnfykik0XwGhDkNcTeuSAo3C8OimPWp1VWas/XZBU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvZD2esMVTDf9u77RR0LQBa8CzsuiXX1WRS0W1Ro6NU=;
 b=VZf1b29eNmtM0132bcVvR11KwPTh1ghJkOuc3ug26N7uebUjnKvMC7x5EPPCslRhnY97o91kk5SHK0c/4ESMWIjlChhJQ1B9g+3zlGYbde3MFfWnONp4UiPbbVrVaki1kvs+uSoRqNsgSTo4J7rltGBg1vwl9S+baOofomsztVQoazMkhzU5XkXJzKA/jgMffrZFA7BIfm33BwmTr7jA2+L9ULd2ggVvAeeRjoiNwGkG0II/5qlmNkK/7P2lEyizBmFmr5ccMAL2FqHxsWrenNkk/CX2gLv/XF8gzBEhZJ99XmydWweHw+EApt4xChpA9zB2yyt4lhUCHx0WJH31vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB5698.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:47a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Tue, 10 Nov
 2026 15:46:02 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 15:46:01 +0000
Message-ID: <4d7b7926-4a09-40c0-b4e8-d5512f8107ef@siemens.com>
Date: Tue, 10 Nov 2026 16:46:00 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] arm64: dovetail: Notify the core about compat
 alignment fixups
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: e13e6655-748d-405c-d48b-08df3f41b8f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|55112099003|3023799007|10067099003|11063799006|56012099006|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	0MJYY9kQgDMdYA7efAneRMP1Jey7lKNNToiusecUaDz3OkHp7Xc3vsxdUgodbLUp9sS+N3+B/zLCOM5OjVsrGBNF7rCQh/GqRUT3rTyAbtoSKbpotE8dZkpMeCoX2R9Oe7v3LeswrsQgFgSeF8YtU0zpROhe31EBui27HGHH9QzYUtooJziLAyA6rd4S6XDBEtnhzbBJQavRBeC4Rmq8LhIo7zIUYkr/zWDTiuQIwcy0bpOrDddfIPOAe6usHvV6W7S7SPj6QtNR+/aLuJGKw7Qgxpr7LMrT73wDnXQta2ycGzdxFUq4/JJtihLVBzwhbeK018IKNYAIEi2xO17lDOD/Ywh1zxTCY0p5g+FeOG47qemq3CH4xJJiRjO+FevPzWGHzfuWo4iuKxzY0rf9n+e7bbORaioTERXOCK7aqhoojzYnmftCU6vsKcUYcs2HCcNF9bG7usxoPh51ljdCBBYEo8vcc6+nBHX6kOoOywcnkrKPH2x07nm8cV5BVtjb2mcB1HOGUfnafJHNuHUjQMd2gyaL3AW8cKxe0BuTsuCJQo7q+k7Ae7jKu17qE9ZvD+ewDlPVlr9uP/dQs2lhpAHV2Q18QL4qpDue6cyzs8Z3oA0a+JNIY+uN9fZ8lwpQNMhl0StOyiG9L8NGpy5nkaHucRx2g2cnv65KuHNyHbw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(55112099003)(3023799007)(10067099003)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlpMeHVoanlsNTVIM3kvVTdjczMwWWErWkwzL0JqLzQ0TlRsVDIzWFJDTUxk?=
 =?utf-8?B?eTloRkJGY1h0TTNhSG9RQlhFRVdKc1RyYjhDNGMwYnRIMXN3ZkNwNnZaS001?=
 =?utf-8?B?RXlnUHlMOVB5VkZYcXFFRytZMlNFbytONEw0SG5uNjVwOENSOXozK2JUMTRL?=
 =?utf-8?B?ejhnQ0xBZE9vRjRTNzdwcGRVV2R0WlFLR09ZRnlSckJpV2ZHT0sya3VWYzhT?=
 =?utf-8?B?cHdHeGQ5L1g1MTVESFkzMERiOHFISnFpSXZ2NjVFZXZrd3BXeXJDcFdub2hU?=
 =?utf-8?B?T1VreUZ5Z1M0b2xNVUFZVVlzb0dVQVFyQUJXdXBrakprQXZucWtRVlRjbDJ3?=
 =?utf-8?B?ajBSeUFEWS96RW9mUm1CT21ybDVlTWp5cDRQOHJpanJQMlI4TjBxdWNCcnA4?=
 =?utf-8?B?TnhCTU5sUmNOZEh6SDZFNjVlcGVlWHAvOWhjdy9hdEZLbEZiUkFUYXFvNzVi?=
 =?utf-8?B?TFA5K3o0cG1CY29aejRTZldicThoRlJNRmtlcmRkVXNJeW9YRTEvbjlCU01D?=
 =?utf-8?B?RnFWWEdYS3cvR0JvVDRNTG9McTBIdmJuYlBDb2FWRHkycXhBRzdtQXBzTnp4?=
 =?utf-8?B?Z0doK0F2aUZtOG1SZGliWHRlNWRmQ29UdXVCOFR5cGxyR2xMUmk3NTM4cjlD?=
 =?utf-8?B?UVMvWkFFZklMZE5WUThVSGNma01wZ2pxYXAvSVo5c1hGMGhNa3lLUU5YU1ds?=
 =?utf-8?B?SGlsVEpkV01STEwrZDdoWnZmZTB4d1MxWUpoeXNwcXpSdGVXc3YzaHozbElj?=
 =?utf-8?B?OWRuQ2tJV2dIS3BkTCtTeThPaVhQb3JBRXFDQk1wRC9WemZkc3lLa3FZRFY2?=
 =?utf-8?B?Q01WMFZWRHg4LzlxckVZN3Z1VGYvbXdqTzNoZThCdDNncXZiUkIvQkFkWVdh?=
 =?utf-8?B?Z21BNElVVVpWVERkOWdSc2pqcXUxVnVtSXk5TW5oUnV0MnpkSlNuZHpheGRY?=
 =?utf-8?B?R1R0VC95bXg4OUFEMzVTRGZhTmdGOXJYVk1rMzZScnRMMHMzWTBPSXF0UG9E?=
 =?utf-8?B?RkgzMTVCOEx0dlJIUW51U0RZaWdyS2lRd0NXMUlITWFlMmhUcVNPNloxOTlM?=
 =?utf-8?B?blM0RUxjRlY5bzVtVTlUZjVNRWxGZjNudVJ2aTNqZVNSMU9TRUVIdFBnVXF6?=
 =?utf-8?B?TTlNNWtCbVpjSWZNYXZ1Sk5IcE1XY0JIeFM2QUdaZFgxSGI0K0sxRWViVGpu?=
 =?utf-8?B?UTlGeVBtL29aSGlDQ1pHOEF2Uyt6bW40RlZWSXkzdEdKaHhxWmhBUlp6Q3cv?=
 =?utf-8?B?NnpPdmV5WXhMMnpGZ0RlTkRtV3RCY2x1LzAyaVYyYk9ORFRBWjdCL3VwTzg4?=
 =?utf-8?B?OEdLZERWOTdHVlM0dDEyeEJaaWJFWkNNeC9NTmRKeXdVaW5MaStQN3F4d1lK?=
 =?utf-8?B?c1JVb1MwTzFaQkRNT1Vmd0Y4QUJjUHFkV2VwWWFBZi9POTdmVnRIRHN5Qjhy?=
 =?utf-8?B?MkVuVWYzU09OZGEra0pPbWpsbENOb0MyR0lLaWM5Vko3R3VUNmdHQnFWK25Y?=
 =?utf-8?B?V3psaFB3Q3NPVEFJaFpNdHMzY0t3YTB6MzVPSlJKcWU2YlBEVy9VRXVxVTFR?=
 =?utf-8?B?a2VaRnRTR3ZoaStyZjNVZmZBcC8zYzJpL2dLMFgwdmErVnVmV3VON1M1WGsz?=
 =?utf-8?B?Wi8vTFV4MVRTMzlLSFFNTlFkK0pHRTVLZ21IK3NVTHRQVVlRc2g5VVJsZHBS?=
 =?utf-8?B?WUxTSVlNMWVsTDc1Y05xVDRLdXNjdkdLSXRVQzFQTjdNR3FVZUdLNXRyb1hu?=
 =?utf-8?B?b1ZDMUdnS1VieGRXbVQzOEN4WkFHRkdRaTdQdjVnb3J0eXVXaWg3cFhNOHFD?=
 =?utf-8?B?bkRFTUIvU1dwOTFvckxuVFE3TndKajdSVGQ4ZWJiUFE0c3VMZ1RiaEJOZWp3?=
 =?utf-8?B?MkEvZlFQOERzN1ZabGFJUXRIVWN3c1RTK1RIemFzSVVySU1NV3RuUElUSVlj?=
 =?utf-8?B?N255VzI4aUUwZE43dmVyY21qc1ZLV3RqK0FGQ1RvNGEzNVZIU1VsbzZNYjlB?=
 =?utf-8?B?WHV4Y3hzaGthYXZ0NXNKdVVZb1l3RXVzQVNUdGwzSE8zSVpqY3JROWxtbys0?=
 =?utf-8?B?azJ3NFZ2WFVoemFodjJRR2FIMzJPNHljcjZuTm16dmRjMFNadXZzOGtLZk1U?=
 =?utf-8?B?ZGgvblY3QStsYm5sSExsOXI3eGFULzhLMmwyWEcrT2dmeXl3TnBkQXRSejZv?=
 =?utf-8?B?Rno5SEN5TDBNV0k2SXZhM09sdENuZUE1Y3Z5T0F3WXQ1em9wbWh5M0doV01m?=
 =?utf-8?B?MzNSNFBxeHRSS20zVERHR29GSDhUZjFUcDkrc3FwTUt0dWM4U1R5OFBPSmVn?=
 =?utf-8?B?SkNqVEVQV3YxTlVwVHFBTVVFaDhDSkQ0UnY4aGk4dGNYTlc3TkV1Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13e6655-748d-405c-d48b-08df3f41b8f3
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:46:01.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3w4Ftw8jLRbYMmkZd/in8+F5L8bQ+zuH+ZixKnk6Q+yOzqilLJ3xegOytvNSuW2iwQ1nhoN/2aMNuznSyq3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5698

From: Jan Kiszka <jan.kiszka@siemens.com>

With CONFIG_COMPAT_ALIGNMENT_FIXUPS, misaligned multi-word loads and
stores of 32-bit tasks are emulated by do_compat_alignment_fixup(),
called from do_alignment_fault() via do_mem_abort(). The companion
core is only told about the trap when the fixup fails and
do_mem_abort() falls back to signal injection. If the fixup succeeds,
an oob thread runs the whole emulation from the oob stage: it fetches
the faulting instruction, emulates it by accessing user memory, which
may fault in pages, and accounts a perf event, none of which is
oob-safe. On arm, the equivalent path in do_alignment() is annotated.

Notify the core before attempting the fixup, reporting the trap as
ARM64_TRAP_ACCESS like do_bad_area() does for the same fault when the
fixups are disabled. If the fixup fails, the notification is unwound
before do_mem_abort() goes on, so its own annotation pairs as usual.

Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This was a found by pure code analysis as most setups have
CONFIG_COMPAT_ALIGNMENT_FIXUPS off. It was not tested yet, working on a 
setup.

 arch/arm64/mm/fault.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2726eb3fa2d46..c3532ff0440ad 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -867,9 +867,15 @@ static int __kprobes do_translation_fault(unsigned long far,
 static int do_alignment_fault(unsigned long far, unsigned long esr,
 			      struct pt_regs *regs)
 {
+	int ret;
+
 	if (IS_ENABLED(CONFIG_COMPAT_ALIGNMENT_FIXUPS) &&
-	    compat_user_mode(regs))
-		return do_compat_alignment_fixup(far, regs);
+	    compat_user_mode(regs)) {
+		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
+		ret = do_compat_alignment_fixup(far, regs);
+		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
+		return ret;
+	}
 	do_bad_area(far, esr, regs);
 	return 0;
 }
-- 
2.47.3
