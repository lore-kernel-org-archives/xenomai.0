Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794476410;
	b=R490ucqOQz02QnkFS4qlfd4TOe+BUeSbT31gADRJ4+chgupeYyid9nhMWdgcnUhv+uyU
	 QDFoqPAPbxy1Nk8jm1KKeeyZjlMC9M5Pmb9GZcXOoOe0V38LkYbEuETm56GcDe8SIg7aK
	 mcF6OcuxVYXJF8QRO5p7qzC+4aA5Sa+8NSk0OtGFYDSA5B3fRnzkQgnrQL9uLh9NHXpUV
	 va9L3QZk29Q2WbMQhP9U3DkbXUMd3L9hpKy3J1UWUJZKcSAQcxlfXxG2IZcV7ZKG5Kqjb
	 DA59RDXlQhaKwMHLU0Jt3EoMF0HnTRaA72U5H1uWIkKYnKnHdOj0ueY6BwP3+0lVc8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476410;
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
	bh=2gNajQKMKBdb5QrybLW3vk2wGt/LIkOht20kc+cbomY=;
	b=glOrHh/wiL5M/PGMJrinQ/YqwYZJ4CgSLATcBENxA0Be/jmKcJY20cdfVH7+xuBzqXA4
	 h4/oAaMHL4+VHo4vCtgYsrtcRKS+yZS/qIqhSm/kQyR4fgTt4np7IBQLaqXamIT7d7e2Q
	 dqfev9dn/vo2WxArsr+3zUssQI9L9h4UG3R9WEWGaXXRqOOIe76DfQAXcowb4I+0zCZB/
	 ZZq3l+GFvG6HPoFEOWilZyaz+G6zGl9JsmAY/Vooos50iQkDlRxIDph/UC9j3FuEqGs0K
	 mSsWwf/QGXOEFDojPWEZuPKIU1NIJPbhxFLerNrP3/SIwvykuoSwdLZVB6DEqLs3uYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=A1g+IOkJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.51
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0260A2627
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 09:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C0260A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=A1g+IOkJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmdsOkjHyK2Cnf92FO3zi/coaAWR1YQJ9ukzrgk/FN+6o+BYZG3tDmhriFwJRero389LQ6GjkRbDgDChvivgR6D1vgbCdoMO3miAU9WpKO7pzeb7Ew6f6BccKZOXnZgl1dl7lQ20yZNozB0kuxf2myUsdm+C2qnvziPuYllFy2HUAh0olg2EMVHj1iK3nJD2NIuYIzMB2OknoZ4DimrbnQ9wfI4wiOgGJnd9cNEXBajaeJVWqGMixS6JzNqUGL6Vqe9hLbqBYOy7H5nx68jdImTSwAuiGkoUEo9S2YtVhTDyKN9kNasW91AcWrsDJtqJX7qmzKogZGnqMhvUaCOrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gNajQKMKBdb5QrybLW3vk2wGt/LIkOht20kc+cbomY=;
 b=xKQ25xCeZjly8/BCxbtc5ObPGlAGexlPPleZyKd8oQI8iTRxZqIZvQX32LPc7sd4ts7PiDjUGBMbNP/xFTlTc2PUDNTbLCSZmOhqWGshl7IO+2ttXK7yCGOgIDRXtKcQ8x8oDTCOec+1qnaW+EV13GiH7Jy3pCDfhwY9qyuB5RKZmasGi8Lvqf5qY0QXU7YXqxdxuO5vfuJRAcJvkU77YVnlaSZNu2anwhst6s+Ao7oFDTYOSikCw7kHhGtE4HhX5xRNUriAXDgbhJQ5gg1XT1UVaI4tFYRk6Ibc0z1p9eMDgKHzaTF21Tl0rTbjSRxS6deNbCtqmTn5qXYMjhMPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gNajQKMKBdb5QrybLW3vk2wGt/LIkOht20kc+cbomY=;
 b=A1g+IOkJuSwwQCJ31Zht1m0oakCTCg4WPaoPxZtB+c9llDMdUJABSDTcKMyWX1Zsmib+Q7eOnoYOjrrk0sKyaEZ1VR10Lk5UOmKJ+8/gcYxhjCG1Q7goHZqAAQIFwWDv7zZ1H7yb7tp1NE8FOu88ZiAL1mAX5mK5twAa9nfOJfZRUiuVZ+dTO7WA7brhACwds1YMcstw/FDs+4xaKM0i/kDp+3NBet5Jquzd3kalKBuxMfRTY6m9ZDG6+oiD5TBBnGUnyLMWywwqRk2CpAhlBlrQKh1+izLfveOX17SmpqyrKEBqOyo6RlkzhXIojxj1CNbxebgevT2BQbhIrq2Fzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB8978.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:440::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Thu, 12 Nov
 2026 09:40:07 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 09:40:07 +0000
Message-ID: <24d60a71-2f4f-4e6f-9099-79ee7906bcf1@siemens.com>
Date: Thu, 12 Nov 2026 10:40:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: local_irq_disable_full() in x86's __bad_area_nosemaphore
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <e5aee699-ea3e-4c02-861f-12f165f2d381@siemens.com>
 <968e9ff2fb76bc031622f3857a7e1a7373d8d695.camel@siemens.com>
 <21a5d7a6-876e-4dc1-a660-bae4f75d3217@siemens.com>
 <87tslm2zhf.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87tslm2zhf.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cbe8a5-e422-406b-2003-08df40a0eff4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|261026121527099003|261021123027099003|11063799006|56012099006|261009223027099003|261026140227099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	X0JdPAP0+ABJycXSA27qu71SKjCLvOD4JLCKBFUcEUqzoxKJ31+/hvli9/UIUE5+aGWJkIjX01REhOAU9BqerJfjtiap0uuu6LeX2j5yZ+2LuEcJ7d28dzE1Vw3Xglb6Guiyl9/tP8vt2957mkSC90NpQZqckgQY5r0QX6BY58hNN7katKTOXS24XFmG6Ntn+7RB5tbRSdzNSE59sol27wt5LE6gZq8Vv75IWeSYE/JusuQ33CluHai4a88OOMJZCaBB98hwd7myR6OoJBbQl93qDb+ckCgN1y1dFA1upGStSzj0W9ipnqArtDQJbGbBbyjhAGBA4LSC1b83i65zVj89Y46sgyrUhPm0NCnJwbmdkeGZ43Cj1eBhZq3YBTNmMEtgo+0Wp/zISMMpk0KxBCQezx1FW7y6UDG/jwHAdQo9JnPEPHHUTGY9CAs7NdIja4po361FL1SiIWTwmNThgMvvGubAzi8ku5HxNGKLh0PNPUDWi0hYTiECa96uTNqU55WL+0rVEwuClCFiDk1ec3BlWF+0CNCYTEUME0w8sJu+jrermFJ9muXYdgge6AHG9cH/FTEA0nOIFtFvPHfxt0JRXZDXn9fzKRXDX0Yadf1yHpRxZVkfd5m4RbAFPfZZNhzYBb+kazHuhPXoQ45Uol7AoilCreBGavyPl721A6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(261026121527099003)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGpmY1IxaW1uSDUyMVZHdTNPUFBrdFRUejlLQWFzOW9LZEw3ZjlhUUVZeDVJ?=
 =?utf-8?B?eUpTRGtuQ1J0Zno0Y0tWQ2UwMC9meVQrRFRaSTR0VE5pWHlVQTFsdnlDU3Zs?=
 =?utf-8?B?amd3OXErd1FNc2FESEZsZndJT1hpbGEzMGNEb2ExS1phSC93UERiMXBEUTRi?=
 =?utf-8?B?TlhGZzN5YWZUMkZpcVI4VjdocWRPT3lsZzlJRE9KbnpCdU8zN3pLL2ZNcXBJ?=
 =?utf-8?B?MWFvQUwrcDhRT25qWTAzZUdxNDN0dWZmNlpDdTZ4NHVKL1Bna0pmTUEwcUpy?=
 =?utf-8?B?aUFWdGlKQkM4SktWd2xxNGVoenJLL2VkbG5SdW5lQ3U1akZzeHBwRWxRVllM?=
 =?utf-8?B?bW9EaXR0SlNXV0k2RzM0eE10OTZaeE42ZFk5eUF3cmxNaDNCS25SZ2RMOElW?=
 =?utf-8?B?QXRjSENYTG1obnRoUE9GMlFJTkdkbi8wQzFEOWYrWW9henZyNXIvSXJXZlJU?=
 =?utf-8?B?SGN4Q3E5Z1ZhaytBRXdYTWRPWDBnTDdxUzJTYnpqdnlwbjhVMlRYcUpmeDR2?=
 =?utf-8?B?a05jcG96VUZvZnZhUFVpVktRdXQ1RDI4dGordjV3VDBXakgyZFVGaVEybUJv?=
 =?utf-8?B?bU5GSDFtMlZtMDhyMjNWV3M2WWIyOHR5aTFZWGQ5S1Y3NHlaL204d0d0aEFp?=
 =?utf-8?B?ZXl5Y1BPS2plUDVITnppLzFSODhQd2h5by9WOVVybFhIV2tLVkZBSnM1WElQ?=
 =?utf-8?B?TkJlRFZXV0tzU05aeVQ5NlBpeVRtekFaT0RXc0VidmQranFPY1BxWHpVSGZw?=
 =?utf-8?B?MFpzRXBjSGVHbHh2L3FpUXVJdVBNR1pDZlUxSFdSV1pZQ1hlVldzanZlaXlO?=
 =?utf-8?B?RTByQno0K214MUNoc0lsa3pwek10bXI3Yms3ckpEeTI1emhPaDhpcU5kcHlR?=
 =?utf-8?B?T3ZIUjhwQnRKK1lpMXZLQVFuK1NQTmJuY1M0TlRJUFBXVTYzaDNmaGdpdUZZ?=
 =?utf-8?B?K2VNaUg1U3pvSHFQL3hJcG1zZ240L3JuTnNldW53OURWMWpDS09ubHZDcmZo?=
 =?utf-8?B?NjJOS3FzVG1adzVPRFozRHhhM01yMTRZTEtuMGNBL3M2OXBTNUV3VlFRZkI2?=
 =?utf-8?B?TFllZE5rbTB4T3NoaDFjY0ZSWEhqcnhPbXlrdGdzQ2dHdUpJcHA3dkhmbE5x?=
 =?utf-8?B?WVUwamJWZU1sc1VCUFFxckxWd1RlQVdrdVZLVkJLdWNJQm5wNHdYUFU2aUxz?=
 =?utf-8?B?QUh5TTcvMTE2WTdPWkNJZXpieXBmbjcySWhPRy9ONE1GbG40MDNrdnFWaVJZ?=
 =?utf-8?B?aUxQSXUxdkF3OTQyNVBIMnZJa3RmTHVIbXlVdU9SNGlnby9aSzFhTllGeWZ1?=
 =?utf-8?B?WmxIK25wd3YzK21zRkdMTEY1d3BUNDgrZVY3UitjM2NVOTM0TlJ6VGJEVmhC?=
 =?utf-8?B?N0tib0luY2s4VjdGYVdXQnhvY1JDaFpibnJ0bEZ0dEE3Sndmem0vcDJicERD?=
 =?utf-8?B?QW1zRDZybXducjNKWThEVlk5Y0dYdEZxZGJuK2RDRUEyU3pWa2UzWmFtMnFj?=
 =?utf-8?B?YUVSdHhqZ21LdVYrS09EVEdwZ0lramFJRCtYeTlRbS9LVlg1aUZ6QlMySE52?=
 =?utf-8?B?MG5NN2R5emRubTExNnNWODVvWUhPS2RpM2NiY21JVURQZEFvNEV1K0RtU1JM?=
 =?utf-8?B?bTJidDFtSnkrMXMyV0EzV0ptaTB0TkV5Sy9VN2FRM1Q0cjBybm5PVmVOR0lx?=
 =?utf-8?B?QitESSt0UEhSdXhzNWpYSWlDVnNMeTdmUFhkYjJQUEFuMk9rQlJReVRkekxZ?=
 =?utf-8?B?NEpya2pocmNONDZoMEtFbjVqSENWVjVxVnBJVVRMdlArTzNZZ2djd2JoNzlW?=
 =?utf-8?B?MUpSTGE4TTBFdDlCbzFUdUFRZDhJa1ByWHd4K01MR0F2RG5zbzdwWUpTMVdG?=
 =?utf-8?B?YUR6ZC9vUEUyU1paUlBuMmZmZUdYajcwODZlYjE5YVhHa09MckdGM285NTZL?=
 =?utf-8?B?ZklydDZkVUNsS2l1bmRYbDFpRkJYekllWVdoWUJhRXRKVXhydlZlcm1taUpB?=
 =?utf-8?B?aEdCZmphVG9RUVRLWitQRzZkaFcyOFNhM2pQUE40dE4zNW13NGx3aGNBUjVT?=
 =?utf-8?B?NzgvdThHRWtSMTlNbUR0R1ZLbkRJc0dQL2pOZFR6bWpKYmZWNVB0aGhXRytB?=
 =?utf-8?B?VW1NMWVadG96TGd6dnJzUTBxdUV6bVV1V1hzTjdTNlVMRzEvSkxIMVNiSGph?=
 =?utf-8?B?WlF4OSs1N2tyWHloMzZPZGxIc1VUQThCbU5vbytaNDFHMzNnWFo4RjUzSE1v?=
 =?utf-8?B?aHg2KzdDUUlGNGIrZlVlZmM5djlyRDhzdEREdVB1em8zTnR5Zjk2eWdaaTFF?=
 =?utf-8?B?a3VsWURpNnY2a3FvYmhHV0FuVVVRbGhlTnpjalFUakc4STJLUTRFZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cbe8a5-e422-406b-2003-08df40a0eff4
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:40:07.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQDgBIVcnB+2w9hVz9vzK7lxX9GvEThjazwLFBGhHepEmKpo2mtXgn6QVsnAPQ1hUmCERY1Hnaiz7R3dQ/GMSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8978

On 12.11.26 10:03, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 11.11.26 23:57, Florian Bezdeka wrote:
>>> On Wed, 2026-11-11 at 13:58 +0100, Jan Kiszka wrote:
>>>> Hi Philippe, hi Florian,
>>>>
>>>> I start to love pattern-matching machines:
>>>>
>>>> Since 6.19-dovetail, commit 6af591980d1750b29474f001902c7dc58c3f1ba2, we have
>>>>
>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>> index b83a06739b511..024a67bd2de6a 100644
>>>> --- a/arch/x86/mm/fault.c
>>>> +++ b/arch/x86/mm/fault.c
>>>> @@ -821,6 +821,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>>>  		force_sig_pkuerr((void __user *)address, pkey);
>>>>  	else
>>>>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>>> +
>>>> +	local_irq_disable_full();
>>>>  }
>>>>  
>>>>  static noinline void
>>>>
>>>> The final code is
>>>>
>>>> ...
>>>> 	oob_trap_notify(X86_TRAP_PF, regs);
>>>> 	if (!running_inband())
>>>> 		goto out;
>>>>
>>>> 	if (likely(show_unhandled_signals))
>>>> 		show_signal_msg(regs, error_code, address, tsk);
>>>>
>>>> 	set_signal_archinfo(address, error_code);
>>>>
>>>> 	if (si_code == SEGV_PKUERR)
>>>> 		force_sig_pkuerr((void __user *)address, pkey);
>>>> 	else
>>>> 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>>>
>>>> 	local_irq_disable_full();
>>>> out:
>>>> 	oob_trap_unwind(X86_TRAP_PF, regs);
>>>> }
>>>>
>>>> Do you remember why? As this was folded into the forward port, this 
>>>> delta never made it into anything older. If it is valid, we would need 
>>>> some reasoning. But this rather looks like a mismerge to me.
>>>
>>> This one needs some more cycles here. It might already start with the
>>> call to cond_reenable_irqs_user() earlier in this function which is
>>> unconditionally enabling hard IRQs, even if the oob stage might be
>>> stalled. The possible in-band migration happens later.
>>>
>>> If we leave with hard IRQs enabled, we would corrupt the oob IRQ state.
>>> I need to check the calling context in more detail. Maybe this cannot
>>> happen, maybe it can...
>>>
>>
>> The oracle says:
>>
>> "No. With a working companion core, the oob stage can't be stalled when
>> this code runs, and the handler never returns with hard IRQs still enabled."
>>
>> The point is that the cond_reenable_irqs_user is only run for faults
>> triggered over userspace, and there we should never have OOB stalled /
>> hard IRQs off. Kernel faults are filtered early in the function
>> ("if (!user_mode(regs))").
>>
>>> Touching the inband IRQ mask (one part of disable_full()) seems strange
>>> to me - at this stage - especially as Linux does not do any kind of
>>> "restore" here.
>>
>> This is why I suspect a mismerge during forward porting.
>>
> 
> Although this might be the case due to the significant code churn in
> this area which is even worse on arm, on x86 and arm64 for that matter,
> the whole logic is driven by the generic irqentry/irqexit scheme
> (irq-entry-common.h). In short, the exit path expects the in-band stage
> to be stalled if running in-band, hard irqs off. There are lockdep
> assertions to enforce this, and specific provisions to unstall the
> in-band stage as appropriate right before unwinding to the asm entry
> point, e.g.  exit_to_user_mode().
> 

This does not explain what makes things different here, both with and
also without IRQ_PIPELINE.

The more I look at it, the more that local_irq_disable_full() looks
stray, at best.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
