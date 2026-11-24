Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795550015;
	b=lRuf5ST9MyI7XWPtIbZct5x6vUqLP2fYB9gZyJP+1c0uJpldOyUct7fSaW+n8z+thIG4
	 YdZkvJECI0725Yv4ouz8YiqcJbmcja87xGwhE8sx0RQNeAn4tPE4NLfClfze9G5Jp/N7d
	 PEcXyZ1rNYib4r1n6SwL5U2ZDwwMSrXEDggGuuHVF0ijmwTClMkvzUVVrpjtgUR89pniB
	 wcv18/yG6KK8AhNFDifuOyCil33fwLx03/TMaa6q2xKeg0zwtqKJSxYpFPM5pZrnO5t4w
	 oPTCL14JBhW2kWdTfKVjhA8lia+DC0ko0Z4JBzWj6sR77VrFxWLx9hFqLuuELmzkX/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550015;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CcR8Gz9Vo5WviI9Qm2EJ/FdbgdxcTV8F0RYJRqnNf5M=;
	b=Lx0q2u5kmg3an9ZnA8i5xdYhYIHH4qf6V4WFI9ma662151MdJNlN2DjNFFjTXZarAFAf
	 jjFeRzxYso4uyYb9+URzMR+OJqZFrdZ6AiC6ITcW8ughyB5K2KhZXhHEUl/1G3y1OiLz8
	 4/ajq5EUmuLBNVCft7M8Bef+wu4wvJltv73M/GA8pWNipm1fcveaW8y0JCzyOc2Bf4oEd
	 I+gOP9+JjwliJbVTr6A/j9/TUO7A+ifoK3U6TGNbrJrO/kz6U9nhIb4X5KAYOQacj7X7T
	 0yBDysQvmhseJpDBAS+smS8IfPuQ2/16nZjpqvGErBxv87XGtFVtOXbqF7r2cBjOKvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=s4cWo2PT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.22
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B21606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 19:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4B21606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=s4cWo2PT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E71oPGpwn59U3WBV0YTmoKpkcIBOvWqaCb4Lq4SFjJF5GNt18cY0kCv0l+oxWr5aijOqqIRF9Y9CDrPItfgKqgVeZJpfHwo2ME4AC7rs88xOx0vHC1V7d7tDJfMjEt9iOurj2AJwynA3RJMP/562dPgyTnMGpg4ZjBodOTIpGAfwp7+9rMhcJKVWh6VwtZBAk9Cw/osubUObyxZiq4fFitq5aFJZV+KBk7NHW8KSoEWxkZFAYDMa5RBSui7gzDejE+Q3LtDmzXxIgXqYLC6qXHHB8cxois8bpsQkYvuwGpkM/AJAzyRqqPpMk/u6bf31ZlDz0S+7rrTd5w/0TqKmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcR8Gz9Vo5WviI9Qm2EJ/FdbgdxcTV8F0RYJRqnNf5M=;
 b=Xh8Ulcpjh7KX7UvfXVT2+PEqgKCGMJnXePqlctI3lRplLIDK6K88pG77CGNBQWQMYfEW5/fJ49mKljIyPWkcV+KCzuvp+dRGrzxGAoPvFFCN47ecVdNfn2QGKqbqCvtEkIhYwRllj2J3eMCggPtJBTwLb9NvfJPrsy43dXdn1AGmHRalC3ZsyVSDS1IJbWYI/GyZGvxKsX+lpsXHI47eTFOgtEbu/+x/HaXHG6gKchgZf+oJ2Np2I6IVhyH83T2NSPIUKjr1SgEXqib0rubMyXj5x+LRJynEM/FCGQn7hSltL7xRzOTVN998HuV9SNI8if5iI96DsvPCWpbfKcLh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcR8Gz9Vo5WviI9Qm2EJ/FdbgdxcTV8F0RYJRqnNf5M=;
 b=s4cWo2PTmbPvzc9mDKPSIs4If24N+6sEtyx3T0IAqIysqaVl9eMhGdNB+Afbrj8l/0IosCOTgoYPq0ej52TQEQ6P4hR8rTnhlpI3DyryVlpsyP4N7B9abZT/RgvyKiQijihTziGhX+pVzesISkPrb41fmNSAHJt2BTdiu9OOrSljyKnSC/Bo+du1c0Qq9YKik2OEDdnacGTZcRFk0Q4k67k1XvNLuDhY16+5w365xCHPbwUMM2WJCv1nlG7jDMl1ZakY5+ThoG1YRwSk9Hc3CDLu9HzOjXJsZvZwRzHmCub8//dq+WXZ5rQlco9ATCORB3AzeUHt7Xoqn6j4bTtIlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM0PR10MB3121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Tue, 24 Nov
 2026 19:53:31 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 19:53:31 +0000
Message-ID: <0a1ae6c1-55ef-4e48-b9c5-b3963923701f@siemens.com>
Date: Tue, 24 Nov 2026 20:53:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
 <20261121165933.57310-4-tobias.schaffner@siemens.com>
 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
 <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
 <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
 <5e8681d8-7d2a-4337-807d-80eab19d36cc@siemens.com>
 <e55022378f5d521c20e037597c04a8698b615a15.camel@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <e55022378f5d521c20e037597c04a8698b615a15.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM0PR10MB3121:EE_
X-MS-Office365-Filtering-Correlation-Id: f69bbb1a-cbf4-4aa7-c626-08df4a649ddf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|10067099003|56012099006|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|22082099003|55112099003|18002099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	LPfpf9MTQQXPYh9hB3a8mDefkPh24Xuw78/97thGAgCBoerv4mDwOBBVjA0bl5JSB5AUjjiX4I3PU8v7S5jjvymE8k0nv90bV2iK7FMlDDTicJtZ6R07EaZHTW/CcgERj5Kzd3jrmTsMGaFWUGQ8SOvIfe41PDhO7wgF/Ka2PHVa3WsB/gnjazqsV6XgnS7VJPSv4A/GV2p6bFDFbs469gzlcbz/59YL/KkQYhLF2/OxR+NK/WQmI0zgSi3hxaJYMk/Qcn7JgGw541m7FzTvhZcnX4gtjEhiBmdOeSBa7hQB3eh7HSZFP20VALoL2eU1KGMOwNfgTbtIL5R5Kjs0Ojsu2dY8ZSzKHX2Zth6IpG+T4xYcjS1OR8CoTNa0G/EyToFUNyuLYVq0PtJ6ZFF0E9UVP/3vCUzygj7v/XDgoZDp+NHD+IhXp7AHLtIJOOu5or2/EGKVJb3vuiL2E5VBDLcpaF90ppDLg1omI3xOV42lJciEQD3aztN3HACHgsX+dqJdN+ItQETQyp4m0zZwu/GPWpNccC2ao8V60sGswi391GoGq30/409nVBSJQEyitQXt0Q7MYf27jMwm/VuGG4NxQMLJu2UaiDw2TyofBgLyygBEu9WUo1qFoOspAXsDCEK46OlBqO5bnXVretuZ42Tx94a0WY82BvBsRe5U6Yk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(22082099003)(55112099003)(18002099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2E4bGpMUTZQd21iWHpSaXZUZ2ZrU09VUVlrdGRBbnpuOGZuRCtXRjFMVHl5?=
 =?utf-8?B?Z2dmMVNzL3lLTHBXTjhjb2dZSU9VQnJoWlViTjhxbjM3MGNvSzBON1BJS0NS?=
 =?utf-8?B?SDRXdGNxRWFwVWl3YVp6VXdXTDNaeSsydytpZENLS1YrNGtwb2NtdXVKWXFF?=
 =?utf-8?B?RVpLWXBMenVJQ2xVZEtNYmtJV0Q2eUVyUW9Vb3RhVmxPdE5oNURaSmV5djBh?=
 =?utf-8?B?T0dRS0FBSlBLNXB3OUQ3VWNCSS9zcUdOd1JoSWFiOW5xWXJQVXJ4aHkwM3JR?=
 =?utf-8?B?QXYyL0tmSVNjemkwUFhOY3lIRkY3SWszR2pyYzBLVG9Xak5obk5QbXBqdDV2?=
 =?utf-8?B?N21SeVdWT25mTXlzZnU5SlRmV2swejRWdjZrWFRjYTA1d21BL0lrTmw1Nzhl?=
 =?utf-8?B?aEdpTEhTWkFneVNPLzEwTk5qU1JqRFZWdE5DUTh3NTNQNkpXdlN2ZzEvUnpi?=
 =?utf-8?B?dVJoVlBQLzBNbzdPTzhScDRydkFXNHpyMzQram84YVZjR2NVdCtqWGRIUEdI?=
 =?utf-8?B?MjlDeFNHOEVBNU4zek5MNllUOWZud3BJT0EwVENidUR5UmxoaUdKM0xiWk11?=
 =?utf-8?B?NW9UNnlGU2UvZWI1SUt0ZDM5OVZlWkxMVmZpSmM5WWRRcVlsMjZkU3k4ODhx?=
 =?utf-8?B?cUljYUY2NjVZQklRdnh1OE5LMUNRTEV6ZUtkY1dMOWNBRVNCZkY4Z1ZUMmN1?=
 =?utf-8?B?WS9xZU9UakJ3STR1YVJsTEl6OGo2cmdUK0YwWDc0ZEZud1dkS0JZZE5oKzR3?=
 =?utf-8?B?eWNMZC9GR2JtLy9MampNZ0xoV3FOOTlPaldNWkpUNzgwMktOcVlTR0JZcVFE?=
 =?utf-8?B?NThNZHdPSWVpQkE0anU3cGdtZlc3Y0xKckxVc1RoY2Zaa1lDb2JuZ3hadVVj?=
 =?utf-8?B?U3J5VnVFU2psc2o5bFBvRDJRYUw2SlFUN3NOcWpOQnRjeFFTSmZMRURqazR1?=
 =?utf-8?B?MitHcDYwekZjUmNXSjVsejdKdXQyZFRGaTRTVW9IZG9mTFRvSDdRd2FUcGsr?=
 =?utf-8?B?a2F3djhqMDM4QUxDQjRGT3VTQlRVaThpaWRuaXFUbi9kVGdIa2NHUEpWT1dV?=
 =?utf-8?B?UmxtUUlwRk1YcDlaWmpzaktXcnljWHF0TUE5ZjFySzYrbGtKa21tajR3SkUy?=
 =?utf-8?B?ZFhPR3QreWxESHJ2cm8rTmhxWFEyajV5cE5XTU03aXVlZkkvbjA2akNkRXUv?=
 =?utf-8?B?VXh5Mjd5SnMxRmtGZTlxVVoyWll6S2pyR1VKcXJ1WVlJdEVMaWpzYStrUjFt?=
 =?utf-8?B?aEp6cEU4TGlYTU15a1ViVEJlNWRvUENoV1RNemxDRTR1L0dmNWFpQTBSZlFx?=
 =?utf-8?B?R0l5aXo2Y01lVWhPTm8zWERuVUlEd1d3clR6ZGxpYnV0a2JubUlVL2hwS0F6?=
 =?utf-8?B?MlhsV3pwa3dLQUcwYWw3TzdvYzZmdVNEZ0ZjSGhvSEl2YkNubDhtU0pXNmNQ?=
 =?utf-8?B?RFZkZFlDSFFuWFBHMXB2WUVLZE52U0lzY05WSS9rTTMxamxNYThid2xkWTFW?=
 =?utf-8?B?anpOenp3bkFDVEN6czRYdEQ2cXBDaDBtb0dIdGpIRjlTdlRVNEt5UWE2R2Jh?=
 =?utf-8?B?aEJFVm5neW9aQlZvbzhlSGMxaldUaklhdFdMSTdCT0RrVS95aFU4Vm1CTGxk?=
 =?utf-8?B?S2FhdTZ5QUVrT0s0Rkh1WDdqbXF3d2dQbkhMMDBXUzRVOE41amUvZGpwTTBi?=
 =?utf-8?B?NlJNK2V1anJrVFVQNFdsOC96UTZTaThlT204L0k4WGo4Tm5pWTdZWERIejRK?=
 =?utf-8?B?S2JRYXg3eTVhYm04MCt5Qm43aXhIUUJMeXVPMEd5UkpacDdQKys3K3Bnc2E2?=
 =?utf-8?B?VWtOT0Foc1FyUXZUc09zUU5mbTRyc3U3dmZWYnRiTVBuaEdQSTZ3dFhBNk1R?=
 =?utf-8?B?MzViMFFDSC9wUDYwcGdiMXorYTBWMVdmNC80bXVHTFYzSDU2L29oQ0lSclMv?=
 =?utf-8?B?azN1aDd2NS95TEU5K3U0WDZMNWNIUkUyN2F2TW9odGhyazkreUlOWDFUcHU5?=
 =?utf-8?B?S1BwczM2NFR3UitJN2p4QUlTNXZ4bnQvMVJMZG9KQTVveGlvNUxMNnJ3OUdB?=
 =?utf-8?B?MzdkNEVhVGJQTU4zTGMra21malhLRXZqVkRKMHgycnF5WVcrVDh2ZEZaM2pn?=
 =?utf-8?B?ckhWQkJxZ1RpSDNkdmhnVFBYczFGRHE0OXYxczhqTXFtYmY5a3ZEVXlwQlBt?=
 =?utf-8?B?ZWRiRVkxd3lEZFYzanRsMFpUa1hPaVNZMFZkVU92RzRRTUVLZVVpNXFJdThh?=
 =?utf-8?B?cVovMEdEaS8wUnVZQTIrWkxjd2FpN3Z5d0dsMENtN0k4QTA2dnQyRXg5VEJU?=
 =?utf-8?B?SnBUNUt0QzhTZE9tMnJDZnErMWhCMmpTU0Q5a241M3pLTTdYdnZTSW8vOTU5?=
 =?utf-8?Q?G79aMa5+TssnrtFHCDPainQj4TV93UT8eVjalUhWz77VA?=
X-MS-Exchange-AntiSpam-MessageData-1: n6yZ9vInSWNjrCwUYcIxkVegGP0FpxSpOY4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69bbb1a-cbf4-4aa7-c626-08df4a649ddf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:53:31.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfir1etEO/ipKp1xyn5nNvlj3Dh8UuhnPRnBKGlOdrY2LJuogJW/y1p9/oL6wOVMntnyx48pJf+1+abBy5eyOP1hVUvwFD2tW6gUGPAmXoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3121

On 11/23/26 23:12, Florian Bezdeka wrote:
> On Mon, 2026-11-23 at 14:43 +0100, Tobias Schaffner wrote:
>> On 11/23/26 13:05, Florian Bezdeka wrote:
>>> On Mon, 2026-11-23 at 12:39 +0100, Tobias Schaffner wrote:
>>>> On 11/22/26 23:18, Florian Bezdeka wrote:
>>>>> On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
>>>>>> A page fault may hit kernel code which runs with hard irqs off, e.g. a
>>>>>> kprobe whose fetch argument faults within the breakpoint trap. The fault
>>>>>> handler still enables hard irqs for every kernel mode fault, so an
>>>>>> interrupt may break into that code. If the fault is handled out-of-band,
>>>>>> the handler also unstalls the in-band stage over the out-of-band stage.
>>>>>>
>>>>>> Enable hard irqs in handle_page_fault() only if the faulting code had
>>>>>> them on and we run in-band, and stall the in-band stage on exit only if
>>>>>> we run in-band.
>>>>>>
>>>>>> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
>>>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>>>> ---
>>>>>>     arch/riscv/kernel/traps.c | 11 ++++-------
>>>>>>     arch/riscv/mm/fault.c     |  7 +++++--
>>>>>>     2 files changed, 9 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>>>>> index a8e37ec27cc2..47799f18fa7d 100644
>>>>>> --- a/arch/riscv/kernel/traps.c
>>>>>> +++ b/arch/riscv/kernel/traps.c
>>>>>> @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
>>>>>>     asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>>>>>>     {
>>>>>>     	irqentry_state_t state = irqentry_enter(regs);
>>>>>> +	bool inband = mark_trap_entry(regs);
>>>>>>     
>>>>>> -	mark_trap_entry(regs);
>>>>>> -
>>>>>> -	BUG_ON(dovetail_debug() && !running_inband());
>>>>>> -
>>>>>> -	if (!user_mode(regs))
>>>>>> -		hard_cond_local_irq_enable();
>>>>>> +	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
>>>>>>     
>>>>>>     	handle_page_fault(regs, state);
>>>>>>     
>>>>>> -	local_irq_disable();
>>>>>> +	if (inband)
>>>>>> +		local_irq_disable();
>>>>>>     
>>>>>>     	mark_trap_exit(regs);
>>>
>>> Below comes another hard_cond_local_irq_disable() call that is a
>>> duplicate as already handled by mark_trap_exit(). => More code to be
>>> removed.
>>
>> One is for user_mode and one for !user_mode().
> 
> Can't follow here, but I agree: Some on the confusion is/was on my side.
> Let's bring back the complete sequence:
> 
> 	mark_trap_entry(regs); [1]
> 
> 	if (!user_mode(regs))
> 		hard_cond_local_irq_enable(); [2]
> 
> 	handle_page_fault(regs, state); [3]
> 
> 	local_irq_disable(); [4]
> 
> 	mark_trap_exit(regs); [5]
> 
> 	if (!user_mode(regs))
> 		hard_cond_local_irq_disable(); [6]
> 
> [1] and [5] open/close the trap handling section. Entry into this area
> and exit from it should match. But: [2] is inside the section while it's
> counterpart [6] is outside the section. That's a mismatch (even if the
> code does the right thing, more later).
> 
> [2] and [6] must be in lock-step. In v2 only [2] has been removed on my
> request, because it is a partial duplicate, right, but removal likely
> leads to confusion.
> 
> [4] must only be called when running inband.
> 
> Now the most confusing part, at least on my end: My expectation was that
> you follow the same pattern as x86 does. But that is not the case. The
> page fault handler on x86 does not use mark_trap_entry/exit() at all.
> 
> That's why cond_reenable_irqs_{user,kernel} exist. That is - so to say -
> the IRQ mask touching counterpart of mark_trap_{entry,exit}() on riscv.
> The fault handler itself is directly calling oob_trap_notify() on x86.
> 
> hard IRQ enablement inside the page fault handler:
> I went to x86 today and reviewed the code again, mostly to make sure
> we're not following a broken pattern. Outcome: I consider the x86
> implementation as correct.
> 
> The main logic (on x86):
> 
> 1) Re-enable interrupts following the following rules:
> 
>     - Fault over user space: Enable hard IRQs and in addition,
>       when running inband: enable inband IRQs
>       (see cond_reenable_irqs_user())
> 
>     - Fault over kernel space: Enable hard IRQs and in case the
>       inband stage was unstalled on fault entry: enable inband IRQs
>       (see cond_reenable_irqs_kernel())
> 
> 2) Notify the co-kernel, by calling oob_trap_notify()
> 
> 3) Call the fault handler
> 
> 4) Restore IRQ state (see cond_disable_irqs())
> 
> Coming back to risc-v now: Starting in do_page_fault(), I see a
> completely different order of things. Starting with mark_trap_entry()
> being called which notifies the co-kernel first, without doing 1) as on
> x86. At least the notification has to take place under the same
> conditions as on other archs. Otherwise we might confuse the co-kernel.
> 
> I hope that helps (and makes sense).

You have a point regarding the ordering. Thanks for putting that much
effort in describing this in detail. That helped a lot.

I will have to spend some additional time to think this through.
When comparing both I also noticed that some kernel traps are not
notified at all in x86 and arm64. This will eventually make it a
bigger change than I expected it in the first place.
