Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B431CD1F
	for <xenomai@lists.linux.dev>; Sat,  5 Apr 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743865130; cv=fail; b=tSC2pQOBluKTjc0DRj68xssPnQpONabgyXDS5iGoXZQkmWCRaB5It82uJxURk8MlfRjn0vGWsw5Xi98W/xsJ6szPvP6GFjpExFIqQHx3d6ctIHnFSUG+qqPuU9jqcFN6zGid2Ualj0gink0CtD1vBS/SYOh1blcTm6FtRhGRsc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743865130; c=relaxed/simple;
	bh=UNNd81nDG9mypynJe1mQi3y2FMDbUjRDlD6W04OUgKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IdtXsWV5aSu2pLPowcivCShohO7AtTJ//8RJoepOvVuGRBdrQk3ygmY1b+pL1EBU3hyRc23Q0EYMvwkQHoHQdIJMqei3OMuzZP6ZCtEDD7vkYY53BjoN8tKPHnpzi9WhnlcpCa8ptE8PSjh4tJG+HPYPlso8YStEQJL5rQdM7dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WrJUialy; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WrJUialy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bfrggxrp+2WCXX1EAArvq2/Eo9HFDMt/MMTn1oO2ErIKufXXmpryx9WHYjJUiu0h5v6hN+m7LVTYZEvja5+qKqb7UDkrcCee6LDMyweINLbGN1yownPYPerkwaqbFyg9UJB/9aiVUOiksAQOmJA2ecif49AV9ezGu2Pgh+1UOt9lyl76pRVi4BnaUd+xwgz2zQ6gSlKe7Z8z2gk0aEvUcxMSALlA1jksHe2cDbQw8A98lTtXIixqhtCJaVaZwfo3kKkbWNz4B2Go2EUd/2liuMyAEGW3cd0U9J/hlRpnXoTWVS7xs8zptQhpE+cOAsAFSI0a+LFjWXIWtaYnxpahNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEKsnRKI0brDdGo62mT1hnbs2b5I13sY8LJT70Rqri8=;
 b=kItXXPBNwrO7hRn6MxJ5UeO3YukWaO8/Idyda0OlzVAuVVPPKSocvZ588ATRr4rbTxWf7AHPwBFrAwVTUyfUcuGi1Xmh3lmEu9kRy23Y48Gx4p6q0xNOYTaizzPikDtlWik4fHE+ebv03dcmH7mZFQ6DD/oNeq/98uZ6SutpRiy+8G8dZ3mqZJNmhT6g6JTRZ5jR8R1EQxA2Hpje3pzYqXIziknUVtpo//ubBau5Bf1zv6zujvgY5eQ+8nss9STxLuMmep69XlulzKFxyOqicZxhDNl4JO+2gc7F9/Yp5cZE274NoJIdc5IN3YpdbZ5BWLf8oxZTolcsvka45L+G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEKsnRKI0brDdGo62mT1hnbs2b5I13sY8LJT70Rqri8=;
 b=WrJUialyYpgtW6rbd8JitfsCVpsUu7CfHkIT7pNUgiFiKwMCj4BKDYT1V6q6ABNbMu7gHZgBcyG89is6qQYf1YAq/tz/ZpkxO4T0bnEnRaKzzSpVZlOUQYzuDcMwyYmP9jUsZXil6VydfiNN/QzR+aEOhlyW3A1/rjebMihOa3kUGHfjbYW9SnRT9PgyFOaOuYKlPogSyfQoFZlWOyGOuRffaXhjmkcDyuUSXxiNHIp+SMQF6nS18oaUVVWKrXZGn2Hc1rgSTxtG9HBvmrF/cgnZcAKLoNCSO3cvupLHDM8WagebCytOLJlwQYQ0vntNGG1oj+3v+pwhTKj7MeLYOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5375.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Sat, 5 Apr
 2025 14:58:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8583.043; Sat, 5 Apr 2025
 14:58:43 +0000
Message-ID: <771a6e5c-55f8-42b8-a3a8-d9754c5938e4@siemens.com>
Date: Sat, 5 Apr 2025 16:58:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/dovetail: Fill fault statistics counters
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20250404190857.17773-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250404190857.17773-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7063da25-242d-4593-9f36-08dd74525ba4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVd4WktOcW5PcStoODBGbGR3dE5EWG84NTluZ0l5RzNoVkp3S0NRV1ozQ3JI?=
 =?utf-8?B?ZmR2eGZZRHFJYUJSYVhaUE4rSGpLZXovQnRiTVZ3ZEpHR1hJVkNTNzdCRTlC?=
 =?utf-8?B?NVlObGhDa29zc094aitmZmovbTRaNjFSZTJtSHpBOW5nLzZuc3VRaXBrdkc1?=
 =?utf-8?B?Zm1FVDdRTm8vU0xUZklVVDRQWW9KQW9Yd1hOanpueTlOUjM4WVBIVGsvaUUz?=
 =?utf-8?B?MUlEdmF4MUJZN1NYQytoMjdXdXMwazVuVWRzczhScCtJeDFIRmM0Tm5PSWo3?=
 =?utf-8?B?RW5jSWUra3FMYVppY2RqdkpGZitwY0JhUHJWbFVLZ0hOV3N2djVTdHY4b2FJ?=
 =?utf-8?B?cWVPZEdLQnVRK0gwandad3FrcUNoZjBWRGMvRS81TDBFdVlPank5WVJnSEp6?=
 =?utf-8?B?a2pjazU3U0toNzhicGpoanNJeWdYVFlHY2dHWDEzbnY3T2tXdTFqT2U1U25I?=
 =?utf-8?B?RGpSdDJMU01ZbWFwTTBSSDVxcit3MGRDbVgzcVQ4NXMxcHlPaTFVK3RPc01N?=
 =?utf-8?B?d3pWUmRMS04zNmhWTDF2bWpwQjJvaFpOR05SMi9XK0VUZ3kzMmVWOHlyM1Z0?=
 =?utf-8?B?bVlnYnR1WVZKWUpRMC9EeEhlZjFHRDJBU3ZSWXhHOWVQNFN6YUNxb3U5Wlkv?=
 =?utf-8?B?MWZFdkphNWVsekVqWHlNUVN1UlhYNTc5ZFBhRHhUSWRvV0F0Y3FqYTlrV3pt?=
 =?utf-8?B?TVdBKzdJU1d0Z2xhZlA2dnhnWXp2dURGdXBGZFl1cHhwdE5lQ0UrUFlkSXEw?=
 =?utf-8?B?ZG9GWFdvUFMvWXhlWkJSc2xmZ3p2M0tIemg1MzRXZnBhQ0ZPb09SV2ZYMjkx?=
 =?utf-8?B?VCt2K0FHZS9naHQ3Y3JGSCt1MnFaS3V3Wm5yS0Y2aCtoSzNvamtWdW9yNk13?=
 =?utf-8?B?N2hQZFlTVEF3ZWJpNmlhZ1ZjbzdGd05heGlhRXhSZDdPaHdOUGxKUExWdkg4?=
 =?utf-8?B?NDNqYmdLYnpYQktDRkM0RHl4ZENxUU1zTDBLMTR2dnZqUS9qQ0tQR2MwUlZC?=
 =?utf-8?B?VlNvMGIwMUdyaHJsaEhZRWYwU3hYTlA3TmdPWVd1eXlFL0JKbSt0dG9ZR1Yx?=
 =?utf-8?B?bzJvdjgrb0ZDMi9SMEJ0ZWJCdkxBcVVTMVY5K3A4MzkvVjg2WHk2SGFlQWhF?=
 =?utf-8?B?Z2RUV0p0VGVtRFlteWVhRFRzcFllell4U0lqSVc2M1h2RUwxQXhHazFXVm53?=
 =?utf-8?B?TUt3K3hySkFhUjZRTkpnUUZuT1ROc0JwUE1nTHZwZ2drbUIrVWpnVUN1K0Vl?=
 =?utf-8?B?ZllIdjFHTm53N0xPaUpaekFWS3QyQnErNXk3UXRsSDFPSjZONk9iVkpSNzk4?=
 =?utf-8?B?VStmVVMzeGFMWXFhVk1RN3ZIK3FLSER2UVlBZEREUG1ESGJVeWJqRURrWVFm?=
 =?utf-8?B?RGhNamtNeTFKdjFDeFFOL1dtakhBajJuUEJ4NkVEVTJ0SFNSdEIyQ2tnbVhZ?=
 =?utf-8?B?amdjSTFNeEZ4MVFNNnVFZXBBeU50eWdQNlpMVy91NkZTNkFKZXQzZEk5UGpB?=
 =?utf-8?B?MVVIVi9FYVVUTDdpMzh0WDU4cHFVWFAyZUFHamZpMnFhZlJTU0pnemFKc0hk?=
 =?utf-8?B?L2hncFFOU3QwWGpDOFhRa3k3bVVZRktoVno2UzlHVitJU0RnU2N1eTZGbkhD?=
 =?utf-8?B?YVVLbm05LzRzdEJOVXJiU2NXa1FaTnpoc1YwWEh1SVNhdjZJS0ZpdWFFWTBt?=
 =?utf-8?B?Nk0yeHF5aUt1N1FSclNGcVZoVjdzOWU3RDkzRHFoWHV6SXlHY1lpd1YrdkZj?=
 =?utf-8?B?NnhIbitiWjVOeUE4dGFHWktPN1JqL2tHeExtb3N0K3JCK1o3YnJ3MWt0Zjh0?=
 =?utf-8?B?NE1xL2dYOWZCRW9VSWlQcFRGRjE2Q2xMbUgyOWM3VzArNkRPMUk3dEQ0WVBY?=
 =?utf-8?B?MkpENFY2eWxnWlJOTU10elB0aVVzblhvY0NrUWwwRUppTlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEFSNUdCN1ZlWjc2ZFpsd0Q1RXk2UXBmUkRGbDlQakpKNDVFYU1sc2x4UEQw?=
 =?utf-8?B?V0lFWlRmZThTYTBuSDZMTVA1VFA1OTRPR3FGZERtOVNKS0tiY2JGQlJxNXpo?=
 =?utf-8?B?TVRYUFN1dlZGZUNYOGJ6ZjltT2dlaFYvSVhodVE1Vk1xTDVtR25TL2t5SjBN?=
 =?utf-8?B?d0NTNFVqV2lPTVlmT3ljZU5VOCtiSndGTHdFcitXSGYxMnBqQzJCK0pNVDlK?=
 =?utf-8?B?SVRMbmFnVTI0S3FSQklYSXlsaGsxc2hkUHVoSndHSU1ScDgrUkE2c0NPWmZ6?=
 =?utf-8?B?dVcwdDhsb0RJeVdEK05ITWZyV2tobUpxY3NkOVBQNkIxUXYxTTRxYzFJeC8y?=
 =?utf-8?B?a1hVOGpoYyt6ZFBEL1JlR1BzTGtFQVd5OVVzWVZORnpYb25xZFpxUllOTlJV?=
 =?utf-8?B?ZVRtTGNCVE8wYkFlQU1jbExjSlRYek96VVRCZ2VvcGs0b3hvNGxSRlhMOWk0?=
 =?utf-8?B?ZTJ1cjc0L0cvNit0Snc5SG5FM3haOTJLZHhhUm52ckwxUGYwQlhlYzJBRHlX?=
 =?utf-8?B?SkZTOVR1d0ttSm44bWFteERHZmhLaFRJWDUvdnQzVFBXUGw4dk5UanZTUGhN?=
 =?utf-8?B?SzQ5TnNpZmc3aXVyNGUraHZiZFd4WWdiSTR6R0lCMnF2VjJrRzZ2THBVSlFa?=
 =?utf-8?B?ZUlpS3B2RWxGdkRLL040REpveHhxTnBoSnBhcHBTNTJnK0xWR3cwZmkyVnBp?=
 =?utf-8?B?d01yUDd1ck1wcWJZN2EwL0V3Rk9UaG1ZZEoyQWlmNGJ4K3YrVU45TVVIY3px?=
 =?utf-8?B?dU04RnpveEN0Q0FsQ1FNT05ZalNqQXFob1ZPYkROVlJhSkNKcjczNGl2VVA3?=
 =?utf-8?B?SFI4MW16QU9jTWJ2NEQ3QWtPZ2RKckJyNU9SRGhONHdKMFl2YzhKSG9vcEky?=
 =?utf-8?B?akl2V2N4OTgrMHdaUnpCNnIzbnprU1dlaXdBemtqNHRnbzFGTHRUQVhBNkwr?=
 =?utf-8?B?WVJJWmZvMStaYWo2R1g2NG0vc0JlWlhoYWtyeVNvaXEyb3ZqMGdMSTZOS3Q3?=
 =?utf-8?B?cmR1b0R1byt3NFRNRkpDREJIRWVlRE5oOFVyL1JJcy8wdnFjQTlLUUhUV0pO?=
 =?utf-8?B?SVVOUTI0SXErNzZpM3NrbEFHeGRkdkg2ZUtycVpJbkUweHNBc2ZIdFVreGJo?=
 =?utf-8?B?MFhQVHVQUFp0M3RVRmM4UGM3ekw2N3pnT1M5K0QwdUNKWWdJWW9HUTE2OEpJ?=
 =?utf-8?B?RkMrblNRNDJxMmc0SHg2RGRUQ1F6SjlaWnZMcGpXMUxVek85WWFqM1NCdmhv?=
 =?utf-8?B?VnJLZUllMnVEd1ZPNndUaXZSRHJjLzFNN3dweU1zRDVqdXIrWmJNMnlaNUx5?=
 =?utf-8?B?ZHdFNWxvUHFqZG1tdnQ3OGNsUWpWNmo1SGRJR1hSR2xZbWx5SnRKVVJ1ZEEr?=
 =?utf-8?B?ZSt5NjRSdCs0c1NRcjR4b3oyc2VPcUc2a2g2MXRVT2hDdkFHK0Nsb2hXS2xz?=
 =?utf-8?B?SzNlbnFOb2tqek1xMWtNSnhzK2tkSmtXS2VBb2dsUm9hRXVjK0xrQ0hBMFZL?=
 =?utf-8?B?R2x1amdDOGFJWUpWaGFrSFhsT2tDYkdjWTdUbTBGQmkwbE5zU2ErVndTVnhz?=
 =?utf-8?B?WnNVMXBwd0VHZi9zQldhRHFkVnZodWU2NHNtbmdwQTl2amlrNHZ0RjlBbFNq?=
 =?utf-8?B?bmRMWGpQRmlvc2VrMUgvc1hZWDNJSTZtRXZZV2NmempHaUNPaDM1ZXByUGpX?=
 =?utf-8?B?R2xLbmVrY2JvOS9YUG9RUTFmZ2Ewc1JrWWxCTGtZVEwrc09iYkpCTGhmekVi?=
 =?utf-8?B?WFJ1dFVrNjVkRHBXZ0JSSSttb1NacExFTXNYY3NSM3g4VW1yVTlCWXh3SVlV?=
 =?utf-8?B?MTdWM05PQkhYanY4bEtCb3F2a2p4Uy94VnFoNGlXMnBqYUR4R2lrVU1ERlVW?=
 =?utf-8?B?NnQwYW5GSkZRdThTN3JJREh1SDlSclkwcHdGVTZheTB5Uk0rS3hRMkJTSjMw?=
 =?utf-8?B?SnFtdEF0L2pVQ25xMFpyZGZkZzZObEhiTnJuVjBDU2QzZUFvWUNDVzVTUjZw?=
 =?utf-8?B?QmVVWUFqYzRTcDZ2cStGeFRuM0ZOMnR0VC85aFJEd3ZVQTBmZmc3Q0RGSGNV?=
 =?utf-8?B?UlMrRWlWSVVCSTBVdXBiSlV4YUNrVWNtazBjWWRGRkRRUGg3VDdaR1puTUdN?=
 =?utf-8?Q?p3K87zlTr6S1jZuL9Atjk2Gxc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7063da25-242d-4593-9f36-08dd74525ba4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2025 14:58:43.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogjDMXyyu7q5bH/ydd6v86rebNMMGu2H2WKKs2r6kRSGRHv8P5V4Rqd0uq5NBXpFy/29UX0VG0yQT7LiKxfaAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5375

On 04.04.25 21:08, Richard Weinberger wrote:
> /proc/xenomai/faults reports always zeros on dovetail.
> Looks like filling these counters was forgotten
> for the dovetail case.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/cobalt/dovetail/kevents.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index 0f70dbc27..9fa75faa1 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -43,6 +43,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>  	 */
>  	trace_cobalt_thread_fault(xnarch_fault_pc(regs), trapnr);
>  
> +	raw_cpu_ptr(&cobalt_machine_cpudata)->faults[trapnr]++;
> +
>  	if (xnthread_test_state(thread, XNROOT))
>  		return;
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
