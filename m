Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30052F0693
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107725; cv=fail; b=NF2VI2mNx6Qk1MvNfszXhbNS5yUvEX2sqoL/lpLBgoBzful+MVOJ92uhv4/A8GOEkVfn8j9EYd5IeHfoBHMozHRapduDisaAa+ts04j5NoCNAPEMEt0fCMIzHvxXSkROkA0q5D1vH2sFGoDi8MSOjtwQBBHfbn0jhNNFnOe8etA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107725; c=relaxed/simple;
	bh=ZNHtZgZxDOKGMeHzWe1sNLJJYCjTuINbUjIVGe0lFYM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=elnkUiQY0ugMpu46+VNPxprPOTJHdlw1U1dnL/VryjVVF8aBGosg1+1VwwzUx/ayDVTjPY4LWiSarMofREDKMR+Uulc1TJOYpvUIrR6ydd69g6x/tmt16QDQFOhnPibcgZSupbdS9G5hNu0fqqiEqchq6f7TEs7wTWAzGA/e5e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZDB/DQ5V; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZDB/DQ5V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcrAxFl8Mf5e9WLmckdnUTK8h1UhdNj/0RpAY5E31RG4G9If5M5Mtj/DYHD/GOH5vOEy4FjpUpfaLmAgyFohGv2qqQ8L66h1FPeRARvnx69xcAr6qflwp1lzKP3PRM9/Y0sK4EBm0DjkInhy7lCVgmBPE6tzebvqqubZ+N/SLId4YX395aGrP9XSTtgGeHmSfUeTmsn3ofMnL6DC6aBhUmTq+886fmAVBmvDYw5XTihN7Uo8QiE+tNtDfP5ZcbF27SqUkLr/xYj0LbzG1jmcHO3ikw3Q5H+Lm102zwZJl3JImr3UC7IDoTvxtXdZdndZNA4OTOTItp+BcRQo0eq9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q67P+pSfd1xZVUc+3WybNj06mgwmUQntuL3UCS8FO5k=;
 b=yxk7qR4vc9MdmluXtI1bSTr4vfEQ3z5YCNMI2z0IqjMvH7/IScrmhui/SF7T/o5Hir6C7ibuYLbGcLIC070uIktkS/QTJdufW3el8tRTCfKs+16SUwGPZH63SL4teV6xiwOV7fWgDmIadaF9H2/Z+yuRF5ILnOsbxzE7nkd01YpjRjhNATLW7k+UTMkRLMSIeWbpjDZqObHlofA1s9OrzcFb0DHOMnfQnCIjj7r51Cn9OPQQKBGqX63Xo65JUt0LtGvogrnCJefrAjvUZlH5PyuquO0p2IK0nAztNlOc2Msw6WkLiFnXPqVi2YsZLeS+wbT73LEahDdFzEeuDkVrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q67P+pSfd1xZVUc+3WybNj06mgwmUQntuL3UCS8FO5k=;
 b=ZDB/DQ5Vnnz8pMsmw4cmN9mY9PYWt24dqx22UD1as3vyavlfA1mk00+1A//jE4UJ12mr6cdNX2CzTl+rBbkl2oq9mXX+SnV5dGuRYl8ySoHMJGDU12Mj+wKMkS89YFYjJOc8O62Y9Q9bIqbYMzXI+qUw8YAJtAEDlQEQ47Ebd+9SuLtuFc2alyBXbcLf1IKG5dr+eln5ZDKvFyUPChphWJJsDesNl7DJZYRRKt4+FqX/SE5K7MjG6wTyGHfiNfdCQl/war8nFGyxazasGU7ncn7WHb7RzBsPzL9oOih9QqsMu7bWzuGfSZ72dC6AFVhO3oPOMq38UowUD4w3j7YHqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PAWPR10MB7365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:48:40 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 14:48:40 +0000
Message-ID: <1c53c64e-c23b-4978-b595-ef150e7eb7ef@siemens.com>
Date: Fri, 10 Oct 2025 16:48:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv64: Add support for RISC-V architecture
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
References: <20251010101717.3759565-1-tobias.schaffner@siemens.com>
 <20251010101717.3759565-2-tobias.schaffner@siemens.com>
 <2225a246-5cc5-45aa-a5cd-8434065ff69a@web.de>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <2225a246-5cc5-45aa-a5cd-8434065ff69a@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PAWPR10MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0a21b3-59d8-4c79-6166-08de080c1a27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3l3Smc2SDE2dFk1VmZQZXBIS1E2OVRoN3hGU1FHUU9NL1phRFN6YWhYTEtS?=
 =?utf-8?B?VDZiOHprTmxubHBwaUlUWEFhVFlIVzlPV2dSUWxZcTJvOGNuZjNvY0NMZUhM?=
 =?utf-8?B?VTUyWWJLL0s3dEQ4aGcyMzRmc05jSWs1RzVxcGJhTTdsdncvcWpLRkI4M0RB?=
 =?utf-8?B?WlAvL2tOaktYTzczckdSRHFpR1A5VlluOENhcWlDUG5ZQWk0WDh3TndnWmpz?=
 =?utf-8?B?eVNpTlNBVUs3c24rY3JOdmlhbW5oSFd4aXRHNmxhczlGTlB1NG5CTldNQVRL?=
 =?utf-8?B?OE9OZ3ZhNzlCaS8wbE9NenNHdUFTQ3l0Nlc1Q3h1MWVEWWhXT2NwWHR0N0d5?=
 =?utf-8?B?Y0ZSOUNlYloydE5CSHN5ZVFjdnlpUXBNckR5WEc4QWI4VE9pTmZNbzdYMnNS?=
 =?utf-8?B?MzdEQVlRNStWNk9oWXFQVEJMME5qN05vQjd3RGtGY2VyUTE5VTF3d1A4S3N5?=
 =?utf-8?B?TjZNcXRQUUNHYXlROUpsalA5Q0NLVHNWeGp4ZWdDOVkvc0ZPaVpzQ2NtMFlw?=
 =?utf-8?B?UTRzenFtc1RaZFFiVTlhUmxjdXV5YXZHUU54UUVLTUpEQVltQ2hOdXplak9n?=
 =?utf-8?B?SS8vUjBiSEN4eUUvVFhGN0VJTnBLQXFlM0daekwzclFKNnZTenJGbjlqOU5z?=
 =?utf-8?B?VTNJZjdWZUFVcjRsWHkvdVhLeGNaemJqTzE0K1ZDNFJoa0lZME9SVDNUR004?=
 =?utf-8?B?bVp4WGJZSnFhdE9XWCtleGFyS0pITHBCQm05eTR5VktKVHJrajNwZGoyOWZp?=
 =?utf-8?B?eGhkdXRjLzlDQnBybld5UlU1Q2l4ZDdSa1lNNEp4R0JuQkJPTXhhOVZNa3V2?=
 =?utf-8?B?NWhzVDhNRWVtNzVPSi9XK0orRHJYZWFtbzEvZmpVdGoyMWcxQ0FJak9qbDRn?=
 =?utf-8?B?QzIycVdZL1JES0NSSlN4aWpJV0NobzA2SXRUS2lSVXN6SzVYemFnOEhTZG5W?=
 =?utf-8?B?SXE0eGFqWEtTZ3ZWQ2YrQjlXVG40Y2p2WG9WZWJCRmJCR20vTnp1ek5NWjF0?=
 =?utf-8?B?aHQxdndEWmRtYU15Qy80ejExVXlxSVI3aHlpUEwzTU5OakNpelpjeFNqV0lO?=
 =?utf-8?B?VlNUb2JwdEh3Y0dBTnNJTzFUTW1Uc0xMakRpTEY5SllCbU1FY3R4ZFgyQmhv?=
 =?utf-8?B?VmtWN2F6VHFjbkVRZ0wxRHJyUjRNc0VIZzNuSkpZODdVVWpoWnhtNWNmWlhq?=
 =?utf-8?B?SHY5WHJUb2xGRDBicTZOcDkrT0Jad3lrM1AwM2p6M282dTR2bTdQdjd1VWM0?=
 =?utf-8?B?bm5pWWpoL25EY2xaeXhRL2FabUhPSmJGaFdoMWsySGlyK09RaHdVSkJlMkQy?=
 =?utf-8?B?VlY1NEQzNVljcDVJK3BvUitGKyt2MnRKMG9LeGY1aDhGK1hUMmRNVzNFSmRJ?=
 =?utf-8?B?MzJKWkNDNUZIcndRWFNVUVYxQWRuZ2pnb0Y0b2lzTXlHQW1vR29sVGR2UVE1?=
 =?utf-8?B?VXJJb3UrRGg2VTJZdkJpZnZPUTNSWVZ6RnpEWkIzd1BuZWNPWS9LQnNVaEx5?=
 =?utf-8?B?aGhOcnh0S1JXTGFmVjkyTW9UcjRkZVFwZTQ2eUR0ZnVPa28xQUxPeE5ZYUJL?=
 =?utf-8?B?SkVqQ0xPZWg0N1RXZTZGaVNMSzdseFdpS2lQN252QW1TZEZjR0QyRnNvYW5i?=
 =?utf-8?B?c3RoNndWV1N0bllOM1pHbTZVYndwZXFmd3BROHNpeEVkMmRZTGc2eCtUb1hN?=
 =?utf-8?B?czljMVZudllxVUZtYmxsMGRRUXVFSHkyeDZNdGs5THJib3RMWHc4b0tqUjly?=
 =?utf-8?B?cnZ3MEFDRVdYa3p6TjlVNTFnaTBMRXMxMGs5QTJVMndZdGYzQnJUUXZ5NTJ4?=
 =?utf-8?B?VFdZempTUGhtSjZEb1FQbXkyemRUdWphWmxOVHprUlNDWHhmekt5UnFQVVNx?=
 =?utf-8?B?azlCajdIb3JxRlBrYmFaNXJGem1JUE1jZmhFM1NRTndxdE5YdW9iUi9kYjF0?=
 =?utf-8?Q?rTgwH94wdeWUJOXppFn6HnkdKH1HowAJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjYrQ2wzaVFXWnZvdHhMb24wWDExR2RVYlZWZzZPdFdFa0hIN2RiclZCOHoz?=
 =?utf-8?B?L2RvTVNQWi82MXBPWHU0VHQyeTBleXlGV2o5cWpKOHhjbmdZYS85SVB4Q3Jo?=
 =?utf-8?B?Z3ZhdFR0YXkvQlcxb2NmR0hvZ0ZOUjF4SkJlNnRLdW14VzM2cGQxM0g4WCs3?=
 =?utf-8?B?MU5iWi9MZXZ3K2JobXRtSDhtdUFZVWZML3V4VUhWOTAyUXA0eVhmU3M5NzRp?=
 =?utf-8?B?djRUbEdWQW10VGhtZVBZdnpselhKNGFDQUFqV1hjQXJNd25zYk8xVjlUaEZu?=
 =?utf-8?B?ekRxdGcyTktrM0NQNWV0WUFibmxCUkN3dzB4cS85VXZIZ0ZGOWQwR3hnZWpE?=
 =?utf-8?B?c1ZYbHlVRFNGcXJYbHRwTjVIY21LUHJyZjlKbGcvU3dkU09Ta2ZocWwyTXdP?=
 =?utf-8?B?UnhNOGQyQnIrYXUyc0g2SHlaZWxEVHk1MzNJeC9XK2pzbjVNVTBHbFJRNmZW?=
 =?utf-8?B?ak9tbEJUakZrV1ZxamlXVElKUWsrRWY2OGRhVkwyK3NXdUxsWXRINlU0bXYr?=
 =?utf-8?B?ZW1NTzc0QmtHUWZLcTMxY2NRRjN2Y1pVZDBSZkRFeTd2ZWlJQnpvTlQwUjJF?=
 =?utf-8?B?TTFXWU5VUGp3S2RiV0pBTXhQaFEwRVVxdUxRVjRRYVU3dXBYanh6N1JLck0v?=
 =?utf-8?B?TVpqaW5BWkFwWlIzaWxFaXlkejl1QmphdFhmL01RQ3I5NGFDdi8zMG80VUhB?=
 =?utf-8?B?eVV5bVVDTW11SG10ZUVCT3hWazBkY21Xcy9rY09OOEY3ME1QeHFGYlA4cGRF?=
 =?utf-8?B?cUpzdnlWQ2F4d2tOclBjREpsK0lENENsNG5vQy9vT1h6VGhFK3oxWkxqd3Rp?=
 =?utf-8?B?ckl5ZmN3b202SUIxM2pERGlZcUxEZmNVUkJCS1dFbGhGRW5YMWZqQjlkMmxt?=
 =?utf-8?B?Lyt6T3NPQWk3aGxVaFB6TXlmck5HaytFSlNQS1oxVi9BQnNXU29kSVV2eUhK?=
 =?utf-8?B?dVpsYTZndkF4am5md2Z4dWZuTHpPR2Q0bGRqM3ZtbUEvVjFHOEN3R0JoRVNm?=
 =?utf-8?B?K28vbDIwaFFWNU1KV291MGhGaUM5b1EzOHZ5ek04dnZLdXNXTlB6cFRiblhn?=
 =?utf-8?B?UjhUY2hSZ2cyWitleVUzUmFCdEcyb3pSd0I2VldWUkQrNno0NUptb095eC80?=
 =?utf-8?B?L3lORkJNZElnUm5xdC9yWVoxb1ljTmVTb3QvWDBZRTd0Z2RDR05pOW9HSFlO?=
 =?utf-8?B?S3c0TDNnU2JEeHQ3ZW1MMG9MVVp4TGFxaDZXVFBhTllobFFWMzZEeGRnTmE2?=
 =?utf-8?B?Rm16Mm5OVS9ldHhBajduYmJWcjFDeGFydEljRjRpV3ZCalNDQkhXYXhnbkFL?=
 =?utf-8?B?cC9XUXhneEJQN05qb1ZnK1JrUG8yaWZVYWJ3RU1UZ2NNRGV0Kzc1a1RYQWNl?=
 =?utf-8?B?NG44d1lJZDFudmduMm5TVExGaTVwUDdGYmhIN0x5Smh4VGFtTXRMcEhXMUlq?=
 =?utf-8?B?WlpUVDJwMW1wdDUrdEpHeWRaNTNpMU40Q1p2cUZxaXMrOU50YXpHY2psVk5s?=
 =?utf-8?B?dE1LVk5OZWRyY2FpR2F6NVBML1Vhc0o0QzJvSUYvNU4xbWtZQllHUDYzcU9Y?=
 =?utf-8?B?R1duczZGVGVrZzNIa29NRytFeThYRDRCYzRybkZUeU5FNHhaTkkyV3QrTWRP?=
 =?utf-8?B?WDd2aFUzcUVFZTZKYzVPakszVjVTUFczWTAvUXQ3cElJckhKamNxTzdEdFRX?=
 =?utf-8?B?QUs2UnpIOU11aXU5em5iRDdJalMyN21YNllMVnlvbi9GaWRWbWpFcW5VWkh1?=
 =?utf-8?B?K0VtUUIxQmNlSGJhaDB1VkF6SVY5R0MwQnlpVHNiMkFLdzBLeXM4VDRMS1g5?=
 =?utf-8?B?SklwN1hHK3V2SE9WU1VOeHpac05SVFBPRXdaMkJwMStwRWdJQkVKT1VEWXZs?=
 =?utf-8?B?SDFVSEd2WU5TZFdOcVFCeEpHeUdwaGswa0RBUWE2ZjVnQVdnZGY1bmNMUUZw?=
 =?utf-8?B?L3BUS21wSmRrR1JCVVNiaXdCY3ZkWlFPUEF0dDh0cFV2T0QzY2NlOTkrSEVV?=
 =?utf-8?B?TEZLK2JGeHhxdzNjNE9ZQXBDNHJJWTBEQ0ducGkvRWZjSjJERHBKSUNZSFAw?=
 =?utf-8?B?NC9UN0Z1dGNkSUFLOXNuVnk2VU5Ybmw2MzdDeVpoV2tLSVVVaDFrd244OXFj?=
 =?utf-8?B?aHZRaEtmYlcvdGlXdXJqVXBvQlF1MWdnWDJ4Mng4TFU3STNjdXdqbnZpNFdi?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0a21b3-59d8-4c79-6166-08de080c1a27
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:48:40.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfjZxK8NXIefXyscwZH45Z0llzZQyWZ1dLs9/eXslzECgsR+zMw2gMlhXKPbAFhT5iVus3m2wy1tf1vulheQKkhePddn6SRBItTO/q0L/xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7365



On 10.10.25 15:55, Jan Kiszka wrote:
> On 10.10.25 12:17, Tobias Schaffner wrote:
>> Introduce support for building EVL for the RISC-V QEMU target.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   Kconfig                                      |   12 +
>>   conf/machine/qemu-riscv64.conf               |   14 +
>>   kas/board/qemu-riscv64.yaml                  |   15 +
>>   recipes-kernel/linux/files/riscv64_defconfig | 7378 ++++++++++++++++++
>>   4 files changed, 7419 insertions(+)
>>   create mode 100644 conf/machine/qemu-riscv64.conf
>>   create mode 100644 kas/board/qemu-riscv64.yaml
>>   create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
>>
>> diff --git a/Kconfig b/Kconfig
>> index a3e3885..23d5f4a 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -17,6 +17,9 @@ config ARCH_ARM
>>   config ARCH_ARM64
>>   	bool
>>   
>> +config ARCH_RISCV64
>> +	bool
>> +
>>   choice
>>   	prompt "Target board"
>>   	default TARGET_QEMU_AMD64
>> @@ -41,6 +44,10 @@ config TARGET_QEMU_ARM64
>>   	bool "QEMU ARM64 virtual target"
>>   	select ARCH_ARM64
>>   
>> +config TARGET_QEMU_RISCV64
>> +	bool "QEMU RISCV64 virtual target"
>> +	select ARCH_RISCV64
>> +
>>   config TARGET_HIKEY
>>   	bool "LeMaker HiKey"
>>   	select ARCH_ARM64
>> @@ -58,6 +65,7 @@ config KAS_INCLUDE_TARGET
>>   	default "kas/board/qemu-armhf.yaml" if TARGET_QEMU_ARM
>>   	default "kas/board/beagle-bone-black.yaml" if TARGET_BBB
>>   	default "kas/board/qemu-arm64.yaml" if TARGET_QEMU_ARM64
>> +	default "kas/board/qemu-riscv64.yaml" if TARGET_QEMU_RISCV64
>>   	default "kas/board/hikey.yaml" if TARGET_HIKEY
>>   	default "kas/board/rpi4.yaml" if TARGET_RPI4
>>   
>> @@ -65,9 +73,13 @@ choice
>>   	prompt "Xenomai version"
>>   	default XENOMAI3
>>   
>> +if !TARGET_QEMU_RISCV64
> 
> no, rather...
> 
>> +
>>   config XENOMAI3
>>   	bool "Xenomai 3"
> 
> depends on !ARCH_RISCV64
> 
> BTW, we will likely have some kernel version deps as well, won't we?

Most likely. :) Noted: will set this as soon as we have something 
integrated upstream.

>>   
>> +endif
>> +
>>   config XENOMAI4
>>   	bool "Xenomai 4 / EVL"
>>   
>> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
>> new file mode 100644
>> index 0000000..65c1a53
>> --- /dev/null
>> +++ b/conf/machine/qemu-riscv64.conf
>> @@ -0,0 +1,14 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require qemu-machine.inc
>> +
>> +DISTRO_ARCH = "riscv64"
>> diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
>> new file mode 100644
>> index 0000000..a659c2b
>> --- /dev/null
>> +++ b/kas/board/qemu-riscv64.yaml
>> @@ -0,0 +1,15 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 14
>> +
>> +machine: qemu-riscv64
>> diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kernel/linux/files/riscv64_defconfig
>> new file mode 100644
>> index 0000000..c57065e
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/riscv64_defconfig
> 
> Is this a real config, not a defconfig, right? Is that needed?

It's a defconfig with some debug switches (some of them EVL‑specific) 
applied.

I think I could unset KERNEL_DEFCONFIG and add only a debug_config 
snippet. The ISAR custom kernel recipe generates the defconfig in this case.

Do completely generated defconfigs introduce more changes across kernel 
versions than using an old config and relying on the defaults for newly 
introduced switches? If the defaults of existing switches rarely change 
over time, this may be a good idea.

> Jan
> 

