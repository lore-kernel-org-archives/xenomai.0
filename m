Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93176026
	for <xenomai@lists.linux.dev>; Tue, 18 Mar 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305639; cv=fail; b=tu26ALpvnHWmlNsr6YOjrCeTguamxfFMZkJpUm6RWANmb5zJ3CzujvoxE84u/2X5jOAsAUzG/Lhq/vm64syZGF1THjjFT6BEegEGFPHDdOQrYyqxGfhv+V5HR9QQ0KqbYuIfCh4aFyNCtH+0hgBfDfqo5R+Azhyu/Y/PE2Z745k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305639; c=relaxed/simple;
	bh=mLJtJkFtsCFKTMkd2MA7ZCfvif33hb6RFjDycJ+Jj9o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eeRs/eaOqikqGzp7ekj5s4MW6i0FCZmVD7KMdIavSWkFqcbTZM6be/kWnv6xzxgHax/DnrfJXQt+PKAMdZKAIckVxuqA+CZtHXp+eK7u1/1gdc/XQsZEssiGg6ohZiiKzlfhnf5P4NneSPaEDu+AMYIb+/xMjYyqYO37SrDzhYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tg0RFhb/; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tg0RFhb/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGfw2TE/869i989GyyyLKBYsqfl7qOWxC7y/ibVEinaFoeaHwYHvCHAHpxi4ZBXUbTllWZrRSGgzuJu+1n224bqFEO0n1kCz8bnHTxK6eI6ABdALk1F2AmOH6JdXYhSw0itpj50C0mKKhks/3bNBkkZ6L/KDoXYLu3fJ1uBbhdKBclXPzh5CTWXunnc/uptvW+foxdHFbP6mh3VZgQPBzGwxjsDGiXTLk+CqycOcgHN2QrCWxjsNs889ZOJ4rJz6Ad6V9xfOmWycGSfZVrKV9mYBcPCetnUtl7eliXRH9wZeqXE2CqcZAzd7KYa3LsL1p+15DNpRxgsBu2ff209Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tK9jMPi9kgh09WVrfjKUnGMLJJZ6XYA7MkeHPXUZlU=;
 b=WT5u+bp0mQqiL7Z+glFtzi+9HD+N9rqTbK0UPmglWM5TUKj+ha3WYo4StUs28AJmmlv9ogm9lHMWzmz98XzEP+9z8+6iDK4j3RdqhJWrkkijt089RFdfnheJjQQVbnJzFl7J8VFPavGSyM8IkoKTJxTYYvBbpGcVncKJQNxazehRX1R8onJuQmmNVl8SWyp8KCHo7LGL89MI5BUQDE3g0RWU7VQMOgcbo0CggaVXvLc/T8HWKCUK3Kd+a8Ez5RFX6/A65QGJpUtb7/m54/LxU3+sMNweakV3ZhrNFcRYh6u9CoFfd5P0hBbmWYTNmJOXX0g6kCmKJ0rqIgWrkNDR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tK9jMPi9kgh09WVrfjKUnGMLJJZ6XYA7MkeHPXUZlU=;
 b=tg0RFhb/VLOmjfPh10u/fc4GAHvgawB6oAc2irJLUkwq7ITWOBkiXvhvGoRpgGG0xyty7eWFb3K9N2+hKThjFJqfvM0SblUJGX4viqL1xENerAYbJRSkckn+aMTqzH3EfaOMSAns59tWWpUo7Jqw1CvYYbvekjRhTHxWWR3ZWNh0t2apqKlTNuCWnwOTBuCte/7TiPMPlVZtIpxVKXmEXBpwS8957bwUudW6RaRBNFrTUlPRHGRkegI0qnesEDHfRdcpgawfUIlVmBIrMN+iMXq8BFJf1jz3uYhwN2N+T3q643EZU9RNCVAOijIDWGEnNjemV6y8a2gx/vDZBQ0s2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:47:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:47:13 +0000
Message-ID: <cb853716-802f-483b-a586-dad91e7f37ac@siemens.com>
Date: Tue, 18 Mar 2025 14:47:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: dovetail: Harden __send_ipi_mask[_ex] for KVM and
 Hyper-V guests
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <5235edf1-6689-4417-9754-52584ecdb6b8@siemens.com>
 <7577efa5673691900d6b826024c30c6e74496f78.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7577efa5673691900d6b826024c30c6e74496f78.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 880a4eff-3bbf-498e-4671-08dd66236320
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjNRblVPOEVseGI0T01lQk5TTGZGRWtlNWdMOWJGQWZrOHdHQ3VoVDJweVZy?=
 =?utf-8?B?S1g1bHlHTXJuWUphS3c4MW1PWWFHRnZPY1p2blNQQlRPTzQ1NHNzR0lDLzNm?=
 =?utf-8?B?SitmaC9hekdqa01qVFU0ZzEvdThNOGJBZWFrbDY3UytkWVRMWmN2cW1pS0hv?=
 =?utf-8?B?TVNKUEdwaTRORnNXY3B6ZXZYMkxJb2VFY0NTRUMwbGRWVGtBVEd6dWhhcVJa?=
 =?utf-8?B?NlJxU1E0YVJZbXRVdUc4cWhNbFRGVGdid3BKc0hJdEtnWmpCN0s4YnNndWQ4?=
 =?utf-8?B?cjhBc0ZvVzRvS2Q4NEFzcUNHc3h2aXdzWVFaN2I1RVlkeUh6Vy9KS1RXaVUv?=
 =?utf-8?B?V2tBRGxRb1FWcXBDOUp4UHJkclY5bU9kTGg0Q2cyallEWFlDdjh2dDhNdDht?=
 =?utf-8?B?cHAySXArdU9sUlFQbnQwYzJkbzRlbTN4anFCcFRXTDM0VGc4SXZFTHZHY2Z6?=
 =?utf-8?B?SXBybmNZbjRhWVFiVHpzN3BuTWVJWHF0R1pNNzFkNTdsdjZRVlJUSHQwWUJv?=
 =?utf-8?B?Sk5aY1dMcDlSYWRwMUdmY3Q5M3NjRFJRajdMV3NqNWlkNVZuWmxYNEVlQlNE?=
 =?utf-8?B?QWd0QTNvM3R2RXNVUVpMUjZ5eXhjQTFyOHdYR2RKaDM0SEpxMU5ITThEL1k5?=
 =?utf-8?B?Ymw0VmZSWmhlRW5TSHg1RU4rMXNsYjFnVzdJUnh6V1N5WTlQbWpKb2orVzk4?=
 =?utf-8?B?NCs1L0l2c2NieWRKQlhaYU8vVWRvbmF5bHFuek9lNzlINm9hQWNZZ1pNKzhN?=
 =?utf-8?B?by9UeFJyN1YvRmhCZHpvZ3NxT05nNU9MbzRTVy9GMUtCYldRbFdGaklZY04z?=
 =?utf-8?B?d2kxemFjejd3cE45WkN6cFA1ZTBNeVEyalFCZk50WVV1THlObzhDeVduT2tz?=
 =?utf-8?B?OUV0OVh5cVM1b0Y5V3VFbXdYM3JSNENmSHVuTi9ZL0FZYUhnWnhUd2t3Rktr?=
 =?utf-8?B?aUM0dlNGQnBUVStXUDcvUmR1cDNIc2I4VlVnVm5BNDBxM0hCWTZPMXFMQVFk?=
 =?utf-8?B?S2ZkLzgyNXZaKy9PaHNzcWxEWHpDQWpsMEk0OVNKSlBuczlvR0sxRHJrWUY4?=
 =?utf-8?B?QTdmODFvOEFENFF5NE42clc1eVVjakRvQUxNYkNHc3NBeUhGL3dEVlVDK2dT?=
 =?utf-8?B?OFhLN3N3WkVLdzRGNkk1TnZqdnMwSWd5UVBJeUE0TTg2REcwZlBycy9aaXdw?=
 =?utf-8?B?SUNBYTYyMk8rODQxV0hCZ3NETzdKMU1aMW5WaWoreTJrNDZpc0ZDdk5GWm1H?=
 =?utf-8?B?NXNzdU1EV2FmYlFOajZsTnpQTWVON3FEV1h2YkxMdGF4YWsyZkErZ21GaXp5?=
 =?utf-8?B?d3ZJTmN6aXJtL3pibWk3VkRTbTVVS3lrTms2SXR2Q3lDaXUzT1VVeGloUkox?=
 =?utf-8?B?a3dPaGlvbHNncVJxQnJ6VW1xUjlxbE5yKzdCTE4veEVCcDR2NnNNZ2drRGFM?=
 =?utf-8?B?M3c0VWF4eXdzQTY5STFYRWM3WWdMdHFpRTdsNTlsTXpOSGd4S0twYlZnaWVq?=
 =?utf-8?B?aTJvS3B6NDFGSVNieGMrYjFnV0MzZDAzWHRTR3lPQ0hpQlZRTlk1dGR0Snk0?=
 =?utf-8?B?eGd6WEtjL0xqZWdzZ1hYalJOZVpmT1BVcXdzK3NzQXl2bklBQVdET0l3VDlu?=
 =?utf-8?B?NVVnWWo4eE9MOTdFTG5yT1daYWp1Ymc0aW40ZWR6cGVueTI5N1ZhODlycjBl?=
 =?utf-8?B?eFo5SUhqQmxCZlJXekhIUkNhbnUxRVowQnpqU3ZlaVZCNGMvTW1rK2pjMmRL?=
 =?utf-8?B?ZWwzVE90UDhKelhGQnNQbDdxaVNwaUlaaU5QK2hFSjJPU0loMWllekZlU0xJ?=
 =?utf-8?B?ZENYR1JiQzVkd3p5VDk2ckJqbFk1TkVHZlJvekpURy9GL2xjRnI0M29DUEVE?=
 =?utf-8?Q?8mIt6KROIU/cg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZktNaXFibWhQNUNaK1RvTlduSEpOVW1KQ3pPNWRSVXptNllGb1U0NVVLa0hC?=
 =?utf-8?B?K3RRMDRlUWx6SmFxYlVmc1V3OGhjanRXQXBwMFBZOXZoRVNTWTFjQ0VhQ25H?=
 =?utf-8?B?Smw5Q3dtOFFPdjBtWWRkdUVoWCtEWGJCWXRqN1pQZ3JXcCtvbnB4TVZibkNZ?=
 =?utf-8?B?RGtTRFFQU296Yit2RlF4b0h0M1hNQzJoSU96alMvOFExVnBsT0Z0MzI3aVJK?=
 =?utf-8?B?NWthdXVrOEthUE1WYmt1VVBsZGdRZy9uNDRGM29aOXROMzJyNlNUV0lSNGli?=
 =?utf-8?B?TlFleFZqSTJoL2JPc0wyYmo2OU0waVExM21DaDZuYjJFbGFhRXlYakJvUisz?=
 =?utf-8?B?cTdPU1FHRjhYdHRrS1NDMmhCb1EvUVYxWUhDb0NxOXJHUGRyZ1l6U1JyOHdC?=
 =?utf-8?B?UnlXVXdoNTdHUnM4clo4dXhBSjJDNVU1N3ZTcHZFblhyZFRhcjhyTzdoVS9M?=
 =?utf-8?B?Sjh1cWp4RDVDcmhLcElydWQyRWRYVHlxdi9qa2tMMXFaVFByc0dCNTBOWDk2?=
 =?utf-8?B?dlhVb2R0Q2FnT0pKb3h2emFqTWkzMUQwakhGZjRSV04veHhVcmhUdGlvaGYz?=
 =?utf-8?B?R1VmOVlEczM0RjE3L1ZCL29URjdSOGVubVV2aURodkZJNEJaZG04Qmd0dy93?=
 =?utf-8?B?cUdzbUN6dUpCZ3l2bmh2Q25GaDJBQ0dsNERORTk4OGxVYmpGWWxzbGxmeDJH?=
 =?utf-8?B?Ly82VVZES1oxeXlyUmZPOUJKR2pRcFBJWTMvaStpWGFyL0lwRkxTZzIza09x?=
 =?utf-8?B?YmRqWXU1N3dDT2JIOGVRaGJIU1kvMk1qYW0wUWg0bGxjd2J6c2JUMURYTm0w?=
 =?utf-8?B?bkIwNG5QRnRtM3BYUmNKaUxmQ3ZiZDB5RmRVUlR6S210WG9NaDhVcGhLZ2ww?=
 =?utf-8?B?K1I4NHUvZ1AzREYyYnQ0clk5ZFgrQS9WSm91OGVmSXFQTkpxVGdwNko1R3Zq?=
 =?utf-8?B?cENlLzBwcjJxSGQ4c1AvU0lod2VSWlcxcHE1QllsMi8rRCt5M0lJTmEvUDJJ?=
 =?utf-8?B?R0RCK1dHNjlCaXNUVkJJQmNRNGlET2tSOE1wVnpOOG5qZ1RLWFQ1WVJ5ZFZU?=
 =?utf-8?B?azh3bHFzeThhTnFMSS9TRzg5MSsxZmZHei9ZWTJXamFFc1VVeXc3Ym1qS2Jk?=
 =?utf-8?B?WHo4b3Nid0doSmxhbHNaeS91SVI2ZE9yUm5FMWZTZFZYYzNob2dtZ3B0M2tP?=
 =?utf-8?B?TVlxV3lsTDZPOHAvdUhqQWZMZ01FMCs0S3dXUUhDd3BqZy9WRjllQ1k1ZjNo?=
 =?utf-8?B?U2xzTEpUcnkweFdWaWplKzVOUlFEZTQvSlVYdCtxRG1XcGhxVEdRd0YrUVNB?=
 =?utf-8?B?OHltb2E0RTJzN0twdU5JU1c5b2ZaczRBY3d6U1YyeUEwVmNPcUszTVFFeDBC?=
 =?utf-8?B?K3l5NzU3a2p0OGFwaEJNRDdQcW1VdndCaG5JZWNyRHJ2QTdjSTFBMnlUZzJp?=
 =?utf-8?B?S2dFaTR0UWl0cWNoL0prN2cwZlYzSGVydHlUZzNVNkxJL3JyMFN5V2drRGVP?=
 =?utf-8?B?ajFFc0Q3ZGYvbmlTNEdkaDh0VHRGL05HRlBQWmJNWjl0bkRzb1pWSTRQbVZa?=
 =?utf-8?B?UTB5SGdybGZuZnRKcmRPMFI3cHRXc3U0N0VsTDAyYkp6Q0lHOCtIVU9MWml2?=
 =?utf-8?B?eWpFMmhJaW0yT0JTd1VwTkZlVkEzMTlsakdacE1OZ2l1M1kwN3FUODdic0hv?=
 =?utf-8?B?d2psMjBTdnQ5VGwzejlub0p3SFBrMisvSCs0bUVNNkdkTjlXQ3RTcmVUZnpZ?=
 =?utf-8?B?SkVpTHpPZWNaT2x1MWFKeFpDam9tTG9XVTl4dFFIQUxxeXlvZCtRNE45aGY4?=
 =?utf-8?B?d2dNNlVwN3BwaDZsLzF3YTUwQkNsN0dZN3hQTnlpS1pDU2Npa1JWZUp5Z1N2?=
 =?utf-8?B?V2laTmc3SDgwdjJpeUdTNHo3cVdEMmRyVEZnSDlCUHlJRnNFcGxrVlJkL0Ev?=
 =?utf-8?B?MzRTSjRsTXZ6RFl1TVorVTZyQ2JDdWs0ZU8wNnBnTzYxS0MxVHJFYTVQYXpC?=
 =?utf-8?B?a0pSdGZ1SVVIa2Vib1F4dUYzbFZsQXhBS1FVRFdpUmhGaXBDT1VONTdCMjVT?=
 =?utf-8?B?a21POG0zQTVpeUlMa2Z2NDlWZkNERWdCVUs0TE5pVm0rcTZzZ1g2YkQ5SlFt?=
 =?utf-8?B?dmtUZU9VRnJDSEQ0SnFDYkU4SUZKK0l4Z1piLzFPYnZKMGxLV1FZTWdyZUVX?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880a4eff-3bbf-498e-4671-08dd66236320
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:47:13.1330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDhioDCipkojdY5a9JO6CWSvaYc+lk2rLabTXsFqm1Q9yOVu/mOj0oRvlAcVnFohSKV6mYtWzqYpDdRnubQyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9076

On 27.02.25 15:25, Florian Bezdeka wrote:
> On Mon, 2025-02-24 at 22:07 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> These functions are called in case paravirtual IPIs are used.
>> Just like for hard submission handlers, we need to harden the path to
>> avoid splashes like these:
>>
>>  IRQ pipeline: some code running in oob context 'Xenomai'
>>                called an in-band only routine
>>  CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
>>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>>  IRQ stage: Xenomai
>>  Call Trace:
>>   dump_stack+0x84/0x9c
>>   inband_irq_save+0xa/0x30
>>   __send_ipi_mask+0x81/0x260
>>   ? preempt_count_sub+0x96/0xe0
>>   ? _raw_spin_unlock_irq+0x33/0x50
>>   ? xnsched_pick_next+0xe0/0xe0
>>   ? ___xnsched_run+0x491/0x5b0
>>   ? ktime_get_mono_fast_ns+0x50/0xb0
>>   ___xnsched_run+0x491/0x5b0
>>   run_oob_call+0x97/0x170
>>   xnthread_start+0x23f/0x330
>>   ? rt_stack_deliver+0x340/0x340 [rtnet]
>>   rtdm_task_init.part.14+0x7e/0xc0
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/x86/hyperv/hv_apic.c | 4 ++--
>>  arch/x86/kernel/kvm.c     | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
>> index 0569f579338b5..e7b2a57c720ed 100644
>> --- a/arch/x86/hyperv/hv_apic.c
>> +++ b/arch/x86/hyperv/hv_apic.c
>> @@ -115,7 +115,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
>>  		return false;
>>  
>> -	local_irq_save(flags);
>> +	flags = hard_local_irq_save();
>>  	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>  
>>  	if (unlikely(!ipi_arg))
>> @@ -150,7 +150,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>>  				     ipi_arg, NULL);
>>  
>>  ipi_mask_ex_done:
>> -	local_irq_restore(flags);
>> +	hard_local_irq_restore(flags);
>>  	return hv_result_success(status);
>>  }
>>  
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index 5df1061fc6ee1..b183caf41aa44 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>>  	if (cpumask_empty(mask))
>>  		return;
>>  
>> -	local_irq_save(flags);
>> +	flags = hard_local_irq_save();
>>  
>>  	switch (vector) {
>>  	default:
>> @@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>>  			  ret);
>>  	}
>>  
>> -	local_irq_restore(flags);
>> +	hard_local_irq_restore(flags);
>>  }
>>  
>>  static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
>> -- 
>> 2.43.0
> 
> Applied to wip/v6.14-dovetail-rebase already.
> 
> 

Seems we are still missing this in stable (6.12, 6.1 - and therefore
also my 5.15, 5.10 right now).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
