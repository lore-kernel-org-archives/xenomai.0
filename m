Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400162;
	b=bLzdUHEv2ZqiYtN34Yxa8nH7zdbPc9VqMcegVbOrwUq6qIxYfmhUzYExIq21C4VpHIuA
	 dperZ+Ay9/mfzmn4iRt6a3Dw7Mk9Y4AE5HUWkl8YpsJ5N41oX04wSudKKH9ONqGYsZQam
	 lxhOUrEyaWweUtWd6w5Opw3b8NUm9eBkS1a7uBhZQ0p1y0ihibmzXDa7r8gNhYL6nu927
	 Rc+jhB7I/CFnu1sE+3mAgC3ubYxfqyN8Fjp/QOXgXZEyJGMgwVSPb+CtbCUOBcgtqvSFm
	 ZC9UA2UTgpEmqIu9xBlKfOn7qBJVqIpOiBFZiZ9/Vsjxf3Ct+QOkkszQIBou2c7v29w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400162;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Content-Language:To:Cc:Subject:Autocrypt:Content-Type:
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
	bh=fVGXE3KnnaTScaPQOPKpJK7kO4IHuufZwU7SingxSkQ=;
	b=BEnD5639EgLhKVNvcZELOvhixpAUPaLR0O4alH7ss0XkXQKlxUu41tBvmJNEpVYfEYMB
	 3pbKqkmIiGkJy1ywXbWBujA0T8+ISsXNjYfcjhJXgWGEPhKcdEW5ATkdbKSlFA+WV3i+8
	 R5iBQbb48HPYnGWEvFEQLAYNJcbJv/coJ8Lv5JU3BJmZ6g1XreWAgUFhQCR1BDiIm2KYl
	 wT26sCNJwCceDpPpKcDqaPGHt3HjsnV84/rO873dZvy/R2FoKumQB5Udfjw6AZPnn5uOK
	 NMHdYPI2a5i1WuEfATJ1azPMdEhhJAZXbr9kE5s+cKojXU/5xsosb6XxWVcGkdbUhww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=cJQpZBG0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD11606A8BB
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD11606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=cJQpZBG0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhXA0rNsGZK6eVprnSOK5SAued/5mIJqjJxFhCc0pvVWlFRe0OK3M+SfttMR00n4GKSo6XF4zkIYwLleszLuNHTSxkKa09sRgSj4h2pHz/KpCC2iXgIQxMkekYRY7Ey8agyVgyWIaLhmQDYPWGabtKGHIzJBMfvFbJ5hzHH+QeQTTM6h8HOb8XLGRjuXrR64RLI4I1rK+c04ZBE9q+q92nPtJoEDckq5LjRdqwI4Zt7p9wJyrP/gYfdcleOK9QICVkMwJDxhDd5w8jMNQaygI5ZoVhh1XrQl2owXeb5B5nEmDpICUiaVOi/r1r8ecY91o6WuelgnvPk1weCKsBBdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVGXE3KnnaTScaPQOPKpJK7kO4IHuufZwU7SingxSkQ=;
 b=jN7C4bELd9bUJklPxYmj0QwNf1x8d/7RVGxy4JuO3O7ftgI0S/yiw2W2XCNjAWxHskud+sbrUnaoBvjxZAUnhaVWCqQqt/AEUHAAE5e5uepHbKdcdqRfAsMwGOtS7yI5xoDqnxuDWbqIsGOGSxpTxe0/1KkR2nIEN3zeeBakMpGP7oez7iH8U2KJ9YV3EJwosvBpSOHj82ZXowh6GGH/W58kqCgokzpFVneSuleyiK3CudYHtBgFj2zWAKap0cVp2BdQm679BQwNHtA6C+q45x51UVCAb39DVrIcyBxNj7LhT4I0qU8Ycvnh3paPCqCRjYb23IRmY7SNCD7p21cPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVGXE3KnnaTScaPQOPKpJK7kO4IHuufZwU7SingxSkQ=;
 b=cJQpZBG0xpjps/qPNjYWMeBSX3DQ6x+b1ndrcuzGq6aA1VPh9d5wyFn4NkGXpMAyJNIPEAaxOyCcIqpZeEqULX2FIfVMWpxH1A9jglgfCATrTqywG9o7SwVFISv2vf2tpcUdBDxEedDz9hff6EaSvFKmmJvjA410oP/NnuyhlogfHZwrf9FmOaZWiJ1UH4zjROKM9KaBy7/h0ydDJC8BOu+Mqb5wa1ZHSKMEyfXzXNmMmgJfiudYdd/CHn2ngtpdf2V+4FIQEVm+86S/uCXmLfRmJEw2koNzyQGbRKYG2v6ltAJYGZc7M2fJ13oyDYAWWcxcFJSX6qo9zvHbFobpAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV2PR10MB7584.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:29:18 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:29:17 +0000
Message-ID: <c5adedb6-0aa8-4a8b-b6b6-5047240bf58f@siemens.com>
Date: Wed, 11 Nov 2026 13:29:12 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: pinctrl-sunxi dovetail changes
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0273.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV2PR10MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: ad840c60-aa33-4f4e-8e3b-08df3fef6720
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|6133799003|55112099003|10067099003|56012099006|11063799006|261102123227099003|261009223027099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	tpY6Zzl8mzIoxpczAwZZTan4dKgU5viI5GfYOk2OxQq2TRFhzaxvdSgM87PRNzAgpaxFhj8EAA83Wz/y1T/bupIxt6G+blAZTFaCo3x9px9L4WfJP262R8t4xzIY+n/N+uJfW98gMoOdFDkaZumcyGYjAvz2mmLlrRzV/4HxOokcXZ7Snh966SLxVXiOpYhl7/FatxjEnI4kXUAlTGBJlBZwzXfGmPse0BQczpo9+LqN/WOI5EIuzgOi/+2NcmPlVmHtIEqOJliI7XCyLYm/LOBWHrqSJWs04Zm+d8D5WJ7BrbBsZRRt3HHX7eHnr1FqX29pz4I306t3RZVRYml67pRfSPM81hAcWKZTBPAOM8KM3ytQS55cyyB87T5JS74ajR2wWk5dO/mkZsXi13mXcW37o2UjXGPCB4ZlHSf9a4mW1H91jZHdZFkVxldrwIl4lUZ8YOdk6t5Gy0YOGeyebcCQQB1zbqcpiElzB81Z25+UC4Ovz2qJzxHedwjJ67X29riQ0ejJukn6ScENgnyYHld74gFS6Z0YRZ1EbsfpYoRgBZl6VLB0oGaHokWAf4sFqrv8jHvVJQkRA2EWdGng8buh3716hasXWTPS2qeJQwY9wSTl+edxA75v47N9L3JDBeFKeIie/jefoCU9B6Zd0Zwr7ab6NOapvnH+PKFPsHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(6133799003)(55112099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U200OEJhUUpjMGJlSnM3Z0Fzb0FXdFp6aDRscnhNMkhSUTdPbDIrKzRhZEtl?=
 =?utf-8?B?TVNkbzNwazY0b0ZxV091Vzk5d1hhdlZDMk9lancwdW5vNFZBa2NSYU9LKy9E?=
 =?utf-8?B?WHFYNXZzajEwa2l6elp6SDI5NitJdy92SG4vN3hDbFpacXJkcE9JZVovOVNO?=
 =?utf-8?B?bncva1B4UklwR1NDa0xjZDNvVy9Zc2ZzQ0QycTlaL25iVUpCVlRxUDhsZ0lL?=
 =?utf-8?B?KysyMFU4L01XSUpsdzVkNGt3L3NwRFEvaUMzMVN3Uktvb09iWEdFL2FUais3?=
 =?utf-8?B?UjZOM0dIbGZtMnR3QXRmaVl0K29UQ1RlaU1YYWVqU2p6d3dWVytvbHUyR1dW?=
 =?utf-8?B?Y2FuZTdaWmsrRnpVQ3pzSDYzTEwxYlpEL0ppRjIwMmRmTk16dTl5K0YvM0pK?=
 =?utf-8?B?VmdILzRGNnQzU3FVTTJDVFhqa24xR21FbXRXWnBycVRKbld0UGEzeFNkMTRO?=
 =?utf-8?B?ODkvYkZSa1U5cE0way9Tb2s0RUtBeXkvZ3hPZUlxWFl0TTZ0V2N5cXJBb1Z6?=
 =?utf-8?B?VHYxaEtqcExyMC9kU3pRVkVwcTJaa2hMbmZobDNNVEF5YldnRE4ralBMRWk5?=
 =?utf-8?B?SWc5bEVmalh0RXNMMjZqbndneTlGTi9xalJlWGtOak5hamdORTVQNzR2NWhi?=
 =?utf-8?B?TDdrc3pDSC9QYXZ0cUY0cFhUamRydnRlaWlQSGwyZGZLRGplNUNQUVdGU2xG?=
 =?utf-8?B?bVBXVlZlU0RQd0lYTXk0bFBmeElIL2xaajNZVFhQU3kwNHlJQm5KWW5xcVlR?=
 =?utf-8?B?WExNMUR3cDA1RnBITzM5dTFrZFJzU3c1T0J3a0p0K0ljcEU1U0tLMG1YeXlj?=
 =?utf-8?B?dWt5QUk0MXdVVVk0K3Nta3BtK2s0SVJ1Vi8xNEtUYkZQWXQ0UmM1Q01BNkZX?=
 =?utf-8?B?S29PMnFRdkFCempkS0p0OGJQNythOVptTStIcG1rd3ZDRVNiVDMrVXArY0N0?=
 =?utf-8?B?aEM5eHZ5N2JoODNrQjJhZnZYTk1VMTVJeUlPUU9YMGZ3NDJZbkthaFEyelhQ?=
 =?utf-8?B?Q0hxazg2OStWUDU1SGF4WSttRXl4VVRnUlRGYSt5OHowejlQZDhjL3BES2Qw?=
 =?utf-8?B?bVpIbHREWDIxY0FMQVg4RlJiTXJncTdjbitBaS8yK2pDeXRLaXFpd3E5bVZG?=
 =?utf-8?B?WWVtMmdaWElmZnBmQ2p0Zngvakk5V3IxbDdMYmN4ekIybmo2VEt3d3djeFhx?=
 =?utf-8?B?ZDlJZGFVWDQ1azZLb2RqTUN6dy9nQUJHWFdlejFqUlpQUDNGVzRNRHFkT0V4?=
 =?utf-8?B?NFQwblY2ZEZQdnZlVTJvOHNZMmczLzZTaUdWN2tnVUtObGFHenlXQ1ZlL1JW?=
 =?utf-8?B?dDRPWS9xUHgvYlBiOTdBeXRrcGdXMnZNMWx4dE1EMTZpaS9qOUJmR0ZJS1lo?=
 =?utf-8?B?SThoSEcwUTRaT2pGcDFiSDMycStsU1NOS084WXdwelVITmdZU1d5MGszeFY1?=
 =?utf-8?B?MG1OOTVEMVZ3Y3R6WWNMbEQ3dXNna0RoNXZhcHpKRmdxMStlTnJKcUplRzJ1?=
 =?utf-8?B?bHhBaW15czZUTnJFWlZPdjZSbytHZzJwZmlmT0d2SmUxNWlRcmxXVWthOWcz?=
 =?utf-8?B?amFhY2hWUXhMNVA3Qi84eCthb0JRdEFrWlU3aC8zWFNINW5wMzF4M2FCekd6?=
 =?utf-8?B?ZjZZZUdkanM1WmdZVVBVNExmZzhpMnBrL0JEU1c3WEZkbXU1ZE9lWGpEa1lJ?=
 =?utf-8?B?TkF4OHVUT0o4RGoweWdiWmV1TXg2MEtVVDNsc1J4ejIxNnJqQ0V4OGQ1UlhV?=
 =?utf-8?B?WmV0SEtXdzJFZFNjandoeHVPeDhmSUQyREFPK0FxeGM1Rnd4L0dsNmphZHNF?=
 =?utf-8?B?dXdqemFkeGR4cnllS0RsN1paZHR0cmcyQXNmL2NHUVd3ZDZwZ28vVFNtS1lZ?=
 =?utf-8?B?LzVxNkRuT1AzUG5kVzNESHR3R0pQRkF2QjEvQWs4ckFZUEhZdXVaTGlYdmpI?=
 =?utf-8?B?QU4xTnkxdHZMcG16dXRQdWlIRS9oVzY2SDhUdG9PdlJtU25VbFlDS1BpTzVY?=
 =?utf-8?B?bWhqditKM1grUDYvdDlTd3RGVkxJTXVIV2RlYzlydVFwaW11OStVb1dOd1p0?=
 =?utf-8?B?RFM4c1F1VnBGRGh3bWpsTGF4a0QreWp1QU0vK0VKL0NpNU5RY1IwOFdlVzVp?=
 =?utf-8?B?TVhyU0txNXVnUmMxYVdnd1YxK2lJNHdpSjZaaWZ5Y2xWNy9SU0ZlZG80RWxE?=
 =?utf-8?B?TEVLUEpJR2J3dFROaEJhcjVBMGVnaEZheGx2Z1lKamdPRHZHTnY3ejN4TFUw?=
 =?utf-8?B?WFRUOXdtVDI3OTI2L09zclZ3a0Y3Y2FWbFZUc1ViNE8yZUJMa1gwNm9yOUJa?=
 =?utf-8?B?ZVlISmFReCtiS2h4Zk42Zm1wNU1jejN2ckpSczRycWJKNFNFK2Zjdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad840c60-aa33-4f4e-8e3b-08df3fef6720
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:29:17.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKWfnVAecpH6DtyvFB4u6eckyk7CGGcV+FKX0r6hJUgXlyZ9cPnCa2mKPV7owNEpIlJu0Q4ES/gBcxkr9sTrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7584

Hi Philippe,

the LLM considers this pattern unusual:

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 31cd142ce0f79..fb73cdaa30ca4 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1280,7 +1280,7 @@ static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
        .irq_release_resources = sunxi_pinctrl_irq_release_resources,
        .irq_set_type   = sunxi_pinctrl_irq_set_type,
        .irq_set_wake   = sunxi_pinctrl_irq_set_wake,
-       .flags          = IRQCHIP_MASK_ON_SUSPEND,
+       .flags          = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip sunxi_pinctrl_level_irq_chip = {

Since day #1 of the patch, we are dropping IRQCHIP_MASK_ON_SUSPEND and 
setting IRQCHIP_SKIP_SET_WAKE instead. Do we need the latter? And do we 
have to drop the former?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

