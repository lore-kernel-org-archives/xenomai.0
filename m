Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741A174EFC
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025383; cv=fail; b=p+VKJr/FyIWelhiXKMdL4yEZI7xamg5/j95hK5tC6nTwPAfFVBsDLZyAEwRBVTLM92fQtmWCzdvyVlEHJojItbFvUub82INOrHCXjVYMOJ+UkiwZ+fnD4PA77zjxIyJpzurT6oclBAMs3Y/uZXNdGlfW3Qv6J4fADE+BWFtgwvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025383; c=relaxed/simple;
	bh=OiNtoUM9YSDqyWBpyOJMkcun9cNPvdaAY9eRF46kA8k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TeIjfpbFuhRIY6EuxqDnHGkb6qRyuQi68UizoC6weCzj8ZymSVuT6DJQBvGjFj0mw97cLJehRJznilsUBuxLIOyqaNZ4LDL+ThO0FlQfucwh1Dw0Hkbn1hv61NwS4+rdNIOjD8ZCsYvAPHlGp9UqsJQ+XLgFRtnWPSRMHS0nOHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YEFkveuG; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YEFkveuG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvi32XCmq0FhtGduPWlKEGpSHm4F3PcII4W9+QnyRiA6/SXjU2WVRLKzNvljOMBXdJtudI2B0vyrqFC634lvbs1VO4lFosA0X0Z9+hYmLq12xecMQuiW+xGrZVHHblApGzgqun0B9if8IcGJdKwxA5lESb3tPVpvneckR/9HAVeozIgiycsbTqqfpW/arI/kRdLSV7N8V2YUWbE/fVO5O8leBN2X3WZMaRKJ9D3Fp28mXrBGyAwkto4qo7ZiAurxMWLpdDfphLZd+gJ66PvB7Zej5SA1DmtiZ1IL1pAm4R1ucgV8unnoqSWpq+kOlLvHDOoHDfjyZkEjYgUGzuKbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP0ISj4W6OdcUf8KdwgDCRMju1xOmYxw4aOm2R6S+YQ=;
 b=SJuBZXKLP64eoAq9NxksgPX6it+LILshXUYHwlswaxleI7QPBFaIzH2+nNjPYYVOwLxV7swPaeUoqalD3UPuJV3LyiHIwk1NytMvxH84rbf9oN0itCWGWsGeM86Fe0EKdCMrGa5YlCLghSBZtPu8R2HVEJaNuP4/oqOugfx7OyfVCXAQBHLcsbML/Gq47anXdlt2QN1aMT/qkY+EDJ7eI22B2qAbO+22eetph/Z2HHM85gva8rTiFzhwZMc3R282PzXU0f8jF6yB7w7VH88wiEfH4MHhYP2LuUM3KvwkJgKTsBqrMM7AxvPb286RweNvZMdRGF8qW+2HFVehpVvbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP0ISj4W6OdcUf8KdwgDCRMju1xOmYxw4aOm2R6S+YQ=;
 b=YEFkveuGQOHpdQ4KZQ4OJgkh/zAaaRsWlaKzwyu5y2kXkd5K/h2uNdoCV94aBfbO3UMEpfwk+hYDym9Og+QbLqzIYRo89oXGfXK+Fft6vd2rbQ1JA/rEXpB7obMWwm0Ve4MhLduDXx+qHWkjesW1HlMAYtA4EDO1F928wU9O7agboFCzGEuiienRjpKawJWVQM+V6vDSg7QpgricvM5AMbP472RiFqsqIEJT66AumeR/BLZFfBb/BdQzsGQxWPRqRpw8S60Al0KGJqgRFXFdlY+LmdNzSLgO8yziEjTwhaG6Jq55a1chi4b1VKx+BVXdjhaGZWRbToVufoQcawdOeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 16:49:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 16:49:34 +0000
Message-ID: <56a2015f-c36d-4836-9b63-881ff98dda24@siemens.com>
Date: Wed, 3 Jul 2024 18:49:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] drivers/analogy: Migrate from rtdm_printk() and
 printk() to pr_*()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
 <20240702-flo-removal-of-rtdm_printk-v1-3-cc91bffdd063@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-3-cc91bffdd063@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a36e92-d94b-4cdf-99df-08dc9b801e28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTFHQ3VRMlZDNHlUdWlpY0IzcVp5SVRtaGhTZW85Lzg4MGJ4OVBsL2U4L1My?=
 =?utf-8?B?L2dKUjZlcEJERHdRSlFxWHRkZnFhNkZrYm1rd0Y4L3lJZVR3aXdaVlZMTXJR?=
 =?utf-8?B?UU94UlZoSjhOL0VOOEpVZVZ3UE5QeGlGTUZNVS95YWtxOTNGNWhJc3BWU3li?=
 =?utf-8?B?QjJsWEZHNG96VTFDMTJQQlphYTk3ZkdOYytEa29vbG9Zb3V1L0xnaWZhSzN5?=
 =?utf-8?B?VDVTcnp1R2Y5M2J2Rm1FYkZzS1BzZUgxY0Uyc2FZQSs5UVJtSmtWbUJScXo2?=
 =?utf-8?B?bXZUUWdSbTZHeDRzenREbWVWS3R2MGpYNWVvRkE3aDFUUi85WHNJWHFIZC9y?=
 =?utf-8?B?WUVaa1pLOEQ3Z25sN3VWZnVTa1RiaXFkNlAzdGVDMlY5Zi84OXFQUXVZajlJ?=
 =?utf-8?B?MVM3OU5tZXJFNGNGUVRRT1NoWEFYdThHSGtYSG9jZEpHN3dHYjNGRElUeEtx?=
 =?utf-8?B?UmhXSUxwU0xnWW80d29lUDJsSm1nVDZ3bUo1b3Niemx6aGpxZDh5TDd4SXJw?=
 =?utf-8?B?UHZWM1ppYzNNbXBsa3VibklndlVVSlJWaUFieTVxRFlqZ2xBTlJrVW5PbmpV?=
 =?utf-8?B?T2FwbUdYYWhoMWVXUCtDTi9xWHhRK3BNallmeW85UW9ONEwwNzMvc3VLc3da?=
 =?utf-8?B?ZHhRdEYxaitZcDZKYXZ3akl3VUM3ZklZYzBYNzNzYVgvMXZTeDJFTDBtZFM0?=
 =?utf-8?B?YTVJZVRxYTFlcGY2Sm0zTWZJTFp0VWc3aFErV3JyRExoZGJUR3VOS2EzRkhz?=
 =?utf-8?B?aG56aDJnVElvTG1XbUN6aDFVRmxNUGdQcklLTU4vM05rTWs3U0dLMERjem9z?=
 =?utf-8?B?V2JNQmJqS1RHRFhtQkNNZ0x1N1dyYzhBTnRHRzlpWDFEZjZoMDRQcUlWV0p1?=
 =?utf-8?B?UlhpQlRaNXdveVRDbFNuMmtvTHUxTG42T3RXWGRkdVlMOTNCVFQ5cnlWMExV?=
 =?utf-8?B?N2NNckNZeSsyTGF6ZUU0dGI3dWRsSDV3SUlLbFNKQUpwZWFxNzI3SWNzRGhD?=
 =?utf-8?B?UWovVjQ4M2s0MFJtTUt6WXE0WGYzOVl3cW1XQWhXVm04MmdLem8vQmZUcyt6?=
 =?utf-8?B?anR5Vk9KTDVITWtmVUM2bWt1Y1R6NWp4bWpDNzE2OVFQUlZ5cVZqMWpiK0h1?=
 =?utf-8?B?WG9CQTc3Y09rUVI4ZkhSR3ZjS0RFdGZYbkxYbnBMOW1JeXV4WlR5Nm9YOTRi?=
 =?utf-8?B?bmlKNTdnQXVnTkx0UzMrQUFFdDFPRWdHbXV3V2Q3eis4b0RyQ2VqcGF0MTJV?=
 =?utf-8?B?YVNzcjg2Q255ZDczblVuTU53dkcyaEpaMFh1NnJKV0ZzNThGTnNyYXg0NUVF?=
 =?utf-8?B?cDQ3dTk0QVd6QUJLOU9GZjRvZTBWMEdWaTdJYUgxNThVdmRKWXlVUXp6eExn?=
 =?utf-8?B?U2JUZlpIR2hndXFRdllZZlVHSFhrbzFpVmQ3Wkl6R3Z5NGFLMEtyVW9Tbm5W?=
 =?utf-8?B?SmJkTFNqUmxvNFBrRzBmSHFsbWRTZ2JPR1AyTnZhcGFjTzJQYnRzOHlXNFJB?=
 =?utf-8?B?OWcrMHh3cTFQZDdlTlJuajZ5aTByNmtuMW85ZkJaWDJRMEJURWdzc0VmdGlW?=
 =?utf-8?B?dndhaDB5QWxEeTNhVEdmMEJzS1BZb3RmNWJpY2w1MWtmdFJzNnZGWm00NWNi?=
 =?utf-8?B?ZTd2RjM2SHFpVzlRY0s5QlovRXRMSlQ0ZloxYTI4OWhJbGFXaG1ZWmI0VGVY?=
 =?utf-8?B?anEvdWxtWnZTK3lFalQ0ZEZXRDVzMFZyQUZ2UjdQeENtZnV1aVV2S21nZ1BK?=
 =?utf-8?B?QXU4cXo2Z2hsT2ptaUFPR0YxT0Y5RWlaTE9nUXZCbi90TDMxb2RhYnZNWWU1?=
 =?utf-8?B?VFhsZ1JQYTNtcDBYa2R3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3BLVmRDUElxOEk1YW5IVWZ0ZTlZaFlyTDBsRERYdkc2RmFtUHFkOE85eWFx?=
 =?utf-8?B?eUZvdDhNcTZtVE5wR2piMEVrSUdwWnRyUEw3NXM2RU5VQU0vVGU4K1ViSXZR?=
 =?utf-8?B?Y1BSbGdmcXNYK0ZWR092NW1weG1hZmVsUWtYUTZEc1BEV2dNSlBqeHF2dEVI?=
 =?utf-8?B?V3dxR3QzN3hrYjF4SEc0djdQb2ZKdWdFbkcrSkh0TTNSMWg1bkRENDY5NWVG?=
 =?utf-8?B?czhrUE5WOUp6dkdZN2xBdmxhMm92eHVhMjVJZzJtamZINFhpekhEQkdGMTlh?=
 =?utf-8?B?NVFtZW9rUkhnZzRoeXlrVmVsUXZDdlVuZWtSTVBoaVF0L09TWUQvbE82MFQ5?=
 =?utf-8?B?UDlCdUpmOUhHamxYRXJVZjR2Zm5vMk83cE5IYVowMFBKSDVUZ1M5TEw0b0lK?=
 =?utf-8?B?aGVQQUdZenExWnp3N1QzNGEzbG1PZllRbVRMOFpuYVZ2Y0pKaWpDbmxBZ2t5?=
 =?utf-8?B?TDdNcTB5dlpMT1YveGpFSnNYdCsvZE10b2x1V0dpWEk2Uy9oUCtpYnJ4R1Bn?=
 =?utf-8?B?bDB3dXBUeXFnb3U5OXJLcU83SjFlNWsvaGtyN3JrLzhMTFkveVNSbXNBUzcx?=
 =?utf-8?B?WWtDWnJ6WlRVQTkrWkdvYjZyYWJ2NUxON0UzVnl4TUtEMVhFWnVJWS96M3Nm?=
 =?utf-8?B?K0ppU1phYTVWR2d3aWlWQng4VGJ3ZnVBcDdldGhLYnB0Zk9FR0lVMkJFNjEr?=
 =?utf-8?B?R3BHb3IxbkJlZ1pZNlgwNTYzTWc1N040M0VuN2FMY2F1ZERUTXRhUzl5aExY?=
 =?utf-8?B?R0xDQ2JLSHFWbGVlRVM3V1dkR3BIc1J2RFYxZEVYY01JcTlVOHYrRnF5dzNk?=
 =?utf-8?B?THhzbFZ3RjNNNDY1M3pNcEFXdmNwT1RNeTdSZlo5bTdDdVl4UExYK1BBcVFv?=
 =?utf-8?B?Uk9wcUxrVVhERHNiNFpaSHVwK2twWnppR0xicW9hTTlnUllodHc1WEV4N1lX?=
 =?utf-8?B?TWd1aUc5OWp4YStRN2dDbnhLaHc1ejZ4RldsTCsweTkyVGxtbVNnZmxDR2F5?=
 =?utf-8?B?RC9OQjRpWVlNK2pHZm9aY0lwTkc5TlhsaWRFOVovWWUzelRqZTl4UFpCQzZ4?=
 =?utf-8?B?VTdGejNZbTZjVTlacDNQczNWcDdpTnZuWUFNeDdUUnYzOUU4K3BIRitkYjhr?=
 =?utf-8?B?WnBTWHdwbzVTR2lWM3V4SEhOaXRJcVA5d3Q0dmI3N3JwQ0xJUklFZ3lyd29p?=
 =?utf-8?B?UGNuckdHM3REV3I1QWcyeTVCUWNib0QwamVlYU1hMnBmWnorVUVrZ0JPblJI?=
 =?utf-8?B?bjRHMnhxYnhHZzNsL2hlZ25HZWpIb3BRWmpmUjN4K3EvWU5kdU9oaEV5UTYr?=
 =?utf-8?B?RWt2YUI3STI4SytnMGNRajNXNE11Z1hWK3E1Mm1XYWZpNTQwYS9aT0tFM1Ez?=
 =?utf-8?B?UE9Fbk40OVdwMXhRQlVveHBNS0lOWGlUelFoSUROa0E1SUMvSklqZE9tV3Qy?=
 =?utf-8?B?S2kxb3VNK3hiTkh5QldIVTNISC9kbGc2d1pIWlVLUWdqOEVPbFk3cGhYSitI?=
 =?utf-8?B?dG9PNlBrdWlIcGZjSGZBQkdjdGZCRGlEUjFWbUlTTTg1VHNDSms2TFBLVmhj?=
 =?utf-8?B?clBGbVdrSFpKUTgwdEM5Mi9NemVtenZOZzFNTkRtN1VRQ3RreGdUTlJiZEt1?=
 =?utf-8?B?eG11Um1nY0srMGFSQ3pxWm84U3VPaDNlOTI2U210L0Q0MFNzWXcrc1dDdUFK?=
 =?utf-8?B?aURVZGJDd0gyR2p5RFNrV3kxK1VhVXhNLzlONHJZcW9GUUpFdVBsZXJkbmZJ?=
 =?utf-8?B?WTFhMVVKRXpzam5kOVEzMVFMWDVjK0RoNGk2V1BpQVc0WTVSeFduSDZ1QVI4?=
 =?utf-8?B?OVEzcEgwdjBuNm9pRHpVZHQ5L2VUb2RTci9zdDNhZCsrZldaUGVmai9PbmQy?=
 =?utf-8?B?YUVWV0VtUlVIQ2N2aWpXUGpia0xsZmxWQXB1QndBTmhtYU5TVVhLaG55dTZM?=
 =?utf-8?B?Y1FXNGxobXNtUktWZEp2TmJnUUJKSmpseXc2emp4QlZSVmRtU3hNNTdhRDNP?=
 =?utf-8?B?Z21jb2JtR2NXc0xrVWVRaFJlY09DV2NFUk9jTW1DcW5jUjdlT0Y3aElHOXBO?=
 =?utf-8?B?dGt6NzkwNEtZakxGdXB1a29GSGRaQ2xRcUlvYWJ5SWx4dXIrczFqL3c1R1Rl?=
 =?utf-8?B?VXp2OXJ6MFlEczkxVTlSZ0tZU0RLU3hReFVmTTErR3M2Tlc3Qk9vSGt0YlpN?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a36e92-d94b-4cdf-99df-08dc9b801e28
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:49:34.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEaPtrbZmOVPa7FjzqyV+ASpknjDeqiD5FE7gsJcRR1ViDKlofXx4lLffUaekFQUwxYCLoIp/1NCtkRmHnowhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7520

On 03.07.24 15:25, Florian Bezdeka wrote:
> There were a lot of (rtdm_)printk() calls with missing log level
> information. The default level (= warn) does not fit well for most of
> them.
> 
> Adding log levels is addressed by migrating to the pr_*() API.
> 
> No functional change.

Besides the rewrapping topic below: By giving the outputs a log-level,
you do have a functional change. Some messages may now only appear if
the system is set to the right loglevel. Not agains the change, just
against this statement.

> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h  | 16 ++---
>  .../analogy/national_instruments/mio_common.c      |  3 +
>  kernel/drivers/analogy/national_instruments/mite.c | 68 +++++++++++-----------
>  .../drivers/analogy/national_instruments/ni_660x.c |  2 +
>  .../drivers/analogy/national_instruments/ni_mio.h  |  2 +-
>  .../drivers/analogy/national_instruments/ni_stc.h  | 19 +++---
>  .../drivers/analogy/national_instruments/pcimio.c  | 21 +++----
>  7 files changed, 69 insertions(+), 62 deletions(-)
> 
> diff --git a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
> index 1de219f96..2adcb15b5 100644
> --- a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
> +++ b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
> @@ -35,14 +35,14 @@
>  
>  #define RTDM_SUBCLASS_ANALOGY 0
>  
> -#define __a4l_err(fmt, args...)  rtdm_printk(KERN_ERR A4L_PROMPT fmt, ##args)
> -#define __a4l_warn(fmt, args...) rtdm_printk(KERN_WARNING A4L_PROMPT fmt, ##args)
> +#define __a4l_err(fmt, args...)  pr_err(A4L_PROMPT fmt, ##args)
> +#define __a4l_warn(fmt, args...) pr_warn(A4L_PROMPT fmt, ##args)
>  
>  #ifdef  CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
>  #define __a4l_info(fmt, args...) trace_printk(fmt, ##args)
>  #else
> -#define __a4l_info(fmt, args...) 						\
> -        rtdm_printk(KERN_INFO A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args)
> +#define __a4l_info(fmt, args...) \
> +	pr_info(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args)
>  #endif
>  
>  #ifdef CONFIG_XENO_DRIVERS_ANALOGY_DEBUG
> @@ -53,10 +53,10 @@
>  		trace_printk(fmt, ##args); 				\
>  	} while (0)
>  #else
> -#define __a4l_dbg(level, debug, fmt, args...)						\
> -	do {										\
> -	if ((debug) >= (level))								\
> -		rtdm_printk(KERN_DEBUG A4L_PROMPT "%s: " fmt, __FUNCTION__ , ##args);	\
> +#define __a4l_dbg(level, debug, fmt, args...)                                  \
> +	do {                                                                   \
> +		if ((debug) >= (level))                                        \
> +			pr_debug(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args); \
>  	} while (0)
>  #endif
>  
> diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
> index 7cd57ecf2..ae9af547a 100644
> --- a/kernel/drivers/analogy/national_instruments/mio_common.c
> +++ b/kernel/drivers/analogy/national_instruments/mio_common.c
> @@ -42,6 +42,9 @@
>   *   as yet. Terry Barnaby, BEAM Ltd.
>   *
>   */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include "../intel/8255.h"
> diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
> index 2f2014bcd..736656f06 100644
> --- a/kernel/drivers/analogy/national_instruments/mite.c
> +++ b/kernel/drivers/analogy/national_instruments/mite.c
> @@ -41,11 +41,13 @@
>   * ISSUES:
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/module.h>
>  #include "mite.h"
>  
>  #ifdef CONFIG_DEBUG_MITE
> -#define MDPRINTK(fmt, args...) rtdm_printk(fmt, ##args)
> +#define MDPRINTK(fmt, args...) pr_debug(fmt, ##args)
>  #else /* !CONFIG_DEBUG_MITE */
>  #define MDPRINTK(fmt, args...)
>  #endif /* CONFIG_DEBUG_MITE */
> @@ -254,17 +256,14 @@ void a4l_mite_list_devices(void)
>  {
>  	struct list_head *this;
>  
> -	printk("Analogy: MITE: Available NI device IDs:");
> +	pr_info("Analogy: MITE: Available NI device IDs:\n");
>  	list_for_each(this, &mite_devices) {
>  		struct mite_struct *mite =
>  			list_entry(this, struct mite_struct, list);
>  
> -		printk(" 0x%04x", mite_device_id(mite));
> -		if(mite->used)
> -			printk("(used)");
> +		pr_info(" 0x%04x%s\n", mite_device_id(mite),
> +			mite->used ? " (used)" : "");
>  	}
> -
> -	printk("\n");

Hmm, no functional changes...? Is there a reason to rewrap the lines here...

>  }
>  
>  
> @@ -399,7 +398,7 @@ int a4l_mite_buf_change(struct mite_dma_descriptor_ring *ring, struct a4l_subdev
>  				   n_links * sizeof(struct mite_dma_descriptor),
>  				   &ring->descriptors_dma_addr, GFP_ATOMIC);
>  	if (!ring->descriptors) {
> -		printk("MITE: ring buffer allocation failed\n");
> +		pr_err("MITE: ring buffer allocation failed\n");
>  		return -ENOMEM;
>  	}
>  	ring->n_links = n_links;
> @@ -716,63 +715,62 @@ void a4l_mite_dump_regs(struct mite_channel *mite_chan)
>  	unsigned long addr = 0;
>  	unsigned long temp = 0;
>  
> -	printk("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
> -	printk("mite address is  =0x%08lx\n", mite_io_addr);
> +	pr_info("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
> +	pr_info("mite address is  =0x%08lx\n", mite_io_addr);
>  
>  	addr = mite_io_addr + MITE_CHOR(mite_chan->channel);
> -	printk("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr, temp =
> -	       readl((void *)addr));
> +	pr_info("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr,
> +		temp = readl((void *)addr));
>  	a4l_mite_decode(mite_CHOR_strings, temp);
>  	addr = mite_io_addr + MITE_CHCR(mite_chan->channel);
> -	printk("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr, temp =
> -	       readl((void *)addr));
> +	pr_info("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr,
> +		temp = readl((void *)addr));
>  	a4l_mite_decode(mite_CHCR_strings, temp);
>  	addr = mite_io_addr + MITE_TCR(mite_chan->channel);
> -	printk("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
> -	       readl((void *)addr));
> +	pr_info("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
> +		readl((void *)addr));
>  	addr = mite_io_addr + MITE_MCR(mite_chan->channel);
> -	printk("mite status[MCR] at 0x%08lx =0x%08lx\n", addr, temp =
> -	       readl((void *)addr));
> +	pr_info("mite status[MCR] at 0x%08lx =0x%08lx\n", addr,
> +		temp = readl((void *)addr));
>  	a4l_mite_decode(mite_MCR_strings, temp);
>  
>  	addr = mite_io_addr + MITE_MAR(mite_chan->channel);
> -	printk("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
> -	       readl((void *)addr));
> +	pr_info("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
> +		readl((void *)addr));
>  	addr = mite_io_addr + MITE_DCR(mite_chan->channel);
> -	printk("mite status[DCR] at 0x%08lx =0x%08lx\n", addr, temp =
> -	       readl((void *)addr));
> +	pr_info("mite status[DCR] at 0x%08lx =0x%08lx\n", addr,
> +		temp = readl((void *)addr));
>  	a4l_mite_decode(mite_DCR_strings, temp);
>  	addr = mite_io_addr + MITE_DAR(mite_chan->channel);
> -	printk("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
> -	       readl((void *)addr));
> +	pr_info("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
> +		readl((void *)addr));
>  	addr = mite_io_addr + MITE_LKCR(mite_chan->channel);
> -	printk("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr, temp =
> -	       readl((void *)addr));
> +	pr_info("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr,
> +		temp = readl((void *)addr));
>  	a4l_mite_decode(mite_LKCR_strings, temp);
>  	addr = mite_io_addr + MITE_LKAR(mite_chan->channel);
> -	printk("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
> -	       readl((void *)addr));
> +	pr_info("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
> +		readl((void *)addr));
>  
>  	addr = mite_io_addr + MITE_CHSR(mite_chan->channel);
> -	printk("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr, temp =
> -	       readl((void *)addr));
> +	pr_info("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr,
> +		temp = readl((void *)addr));
>  	a4l_mite_decode(mite_CHSR_strings, temp);
>  	addr = mite_io_addr + MITE_FCR(mite_chan->channel);
> -	printk("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
> -	       readl((void *)addr));
> +	pr_info("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
> +		readl((void *)addr));
>  }
>  
> -
>  static void a4l_mite_decode(const char *const bit_str[], unsigned int bits)
>  {
>  	int i;
>  
>  	for (i = 31; i >= 0; i--) {
>  		if (bits & (1 << i)) {
> -			printk(" %s", bit_str[i]);
> +			pr_info(" %s", bit_str[i]);
>  		}
>  	}
> -	printk("\n");
> +	pr_info("\n");

...but not here?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

