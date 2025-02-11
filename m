Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927701F0E32
	for <xenomai@lists.linux.dev>; Tue, 11 Feb 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288041; cv=fail; b=tTsOcdsI4+0sWa1oymKjdiH7be/4XWGWapG3yn3AcWzmOn4TKtNkEdSUNNAXyUfl59ZHGLymfQoBB2NYJIlAnSBYK+gM05VAqdGVXIJS7TbWy7E8lXpCnxHQjPZ6SKNXy5AWGDGL8Saj5jqGFHTy8LVEVNTbVw3EWiqDKSAxGt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288041; c=relaxed/simple;
	bh=4J1T0iGEsJ/2oL+ITl/fF0BoN/RqRv1ehv7bVa+S/0g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KehsUn62nsqLQN3GNkoChj12+dEjchgVuLrGN1iFtAz7vmDbRmjLMsXH08Q9/yjgpUSb13dNx9JCA8Tv/Gj37bPk+6A2R7qn6ceMHGz51tsqCaj+GgA2zdumDbjSQLBELhmz+nUE/D8fqOav1Q2jHeI3MTGchAQoBL8kd19uXeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QU58/sqc; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QU58/sqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwGJdArGgDC4F3D5FWnxj0DXIfaufCVfS6b0rQgcyoxqebWjV758zvW47Z2OivJm9edrWacibrvLWSKgmNt/PNWAglhNecoARfITCXQMqVAWIcI4M11n0/xLd8jEiO+9+u/tz4MyjALGsmoqNOxcxehwzr9Rxk/L6zDSlZfuGRjPcLc9ljN4MflbWcyPtgwZXJh7awkNtAUoCiRUeYe8GsFoZOQ3G7jZdiM+4IP5HUlATRfbdiJhvDEGHX+vPoL/W32/aCVlr4GltwXRqCJMysfEXdwmZIp2fzvFxdPFRgE2GM9vWKHPsEFnKbYSYZHjLC/xouzlMebVfrIRXPWW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeMY3MKqkIZVHB3Fid4+T2MKR0NL4HdUcC1wbhdDtQg=;
 b=c6CzaQvIian2C9LM4RtHWg6mLc62g5NcT4Fv8cb6KkPmXey1VKmdUtr2cj89gev/2WWOlsbTZ+yqq7a7DNuVtDM10WbZJQpcr5hlnBGRNTD2KzxaMox+C9cTYhBxnGalIuyR0oiwV8tJkW+4Nbt6JZSVyHBeQvQH/uU5JlgQwdwVG96LgMtsTmmOqR4b+U4KdL4TxqFhNGcY4S8M452Q/EfxEoMqJC7n3Xuv/ptPr3ZFkvEQ/VlLOkJb53v1ZOl+2a3SR+ce9QMAkD12aWQ4tG9doaDMnVqPZepyZW6tQuCjkgkb1QomPpoJDxGGBWMIiYNUvwwMcE0ZRrPPFDmvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeMY3MKqkIZVHB3Fid4+T2MKR0NL4HdUcC1wbhdDtQg=;
 b=QU58/sqcVo+B5uxBgTgqr2EVAe1zqE5HKhTjzcH+M5xxLR3fOyL+4ge/PsBUgWemoXQF5C9j2jyvPEvS9yBZQ0uM+UaqXGop/Fsrr9aGgAV8JcggJKcGOX4ZFUIQjSb3EuDWg8ab0t+O4zR4KUQDaZ32rt69DKB68skEdIDhv6K1Lym+a5stOkLDGorcrCd/xeTWtgYkd5Tl1SPIcNiYGH4hsPOeJgOSFSNACl1jDDhqY5IKJQVmdf9fnfzaX8U8iIjdfr4XUcc8DrLl4pOk0ggIA1KYagJssqGGQtiHFYNEMsUKhIr+eojQdBoAQDd2q5TiQjoW0iNe85EqXy4MgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 15:33:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 15:33:55 +0000
Message-ID: <af1ab7a1-42dc-4ba8-994b-7d5eb1238f53@siemens.com>
Date: Tue, 11 Feb 2025 16:33:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] migrate to syscall(): Measurement results
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
References: <68d9f583-59de-4bbf-8ea2-af8ece427495@siemens.com>
 <20250131154200.1221616-1-florian.bezdeka@siemens.com>
 <20250131154200.1221616-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250131154200.1221616-2-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:610:77::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 67efa35b-93d0-471b-7a93-08dd4ab17ea6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3BsSERsa3FVbndoeEJTSnhJaCttdVBabkdRWnE2OE1DQzE3S1Y1RXNmUzlv?=
 =?utf-8?B?ejNSWEpCV3k5QXdTR1FMMU14NGQ1Z0JDa3h1bmNqVU1DUU9LZTlqaGlpdThQ?=
 =?utf-8?B?SGhmalBLQmxkajJwRjVFVEU0aUhSL1RremxCRzJuR1luWHc0TGtieVBta0hE?=
 =?utf-8?B?QkxRYXRJaWtvNVpBa3ltTHlIOTBTTmVWR2Rha2RJWER6U0t2d2NZOU5GRzhz?=
 =?utf-8?B?ZUFCSEZJWi9jUmUrNkFWOUdMMGNkNzVnRG9XN0J5ZElZd3crZFRSbUliZkdV?=
 =?utf-8?B?ek53cG9jV204THdML3hINkJQV0YwbDhaRCswZVd3VjhBbUpTY1E2Q0N0SENK?=
 =?utf-8?B?VkdTMVdJR0JwaEo3ZzlySVdBOGRtNnp1QVpJWDI4bkVBaDVJaENQcGJIbmRE?=
 =?utf-8?B?T0pXVURTTit3RGVoaXV0ZFh3eEx3Nys1VW9JUTh2NEhvR1cxRDFNZmk2cURp?=
 =?utf-8?B?ZUNCZllKNW9KbW9SM1hXdjJUdkhUVFVxUHZsNmpjRWl3dVZVRHM4V1ZVMWxp?=
 =?utf-8?B?VnQrWXhyTUN6RnREUm1Ka0kvRTgycnNvdVlnN1E1UUN3NE1URHJIVW4wZ2I0?=
 =?utf-8?B?WW81M1ZURGs3Y3pWbkwyUmE1R3lxQlQ2OG9zK2VWREZsajI1T0d5SXlVWVg0?=
 =?utf-8?B?VmdVK09YSFRWUEhjZlBCWGFYbHNtK0dwZjNlelVzdnRQcHJva2hONEdpN3Vk?=
 =?utf-8?B?UVFxdUszRlpQMmdGc2w5NURFMEUwMkZkVEt6M2ZxVk1WYTJGS1d2UTY3QU5U?=
 =?utf-8?B?VVJFeURlVDZoOTVUNWdrWW1Tb0JzUy9ZUnoyeWRHbDBwQ3VHMVZDL3JIUGV0?=
 =?utf-8?B?M2dpMmltR3h2cUZ0dkpzOFg3UmkwUUUrdXBSNjF4L0R1K0hQb0toQ0JNdkxx?=
 =?utf-8?B?dXQxOG9oZmh6UEI1bnU3OHEza2FLY28rMWQ2RTVmRXE2NDNnMFNBRkdDZXFh?=
 =?utf-8?B?REpuZTFqNmFKdzZ6Zm8vRDkrVy9Db2RYSkZLZkY4M3E5ck1xT3NKLzhiY1RB?=
 =?utf-8?B?NlhXWTNTZzVUTkZ4R3VodGZTSjRPdjNYMmpDZnJBNGs0ZUN0bWVTQW5TTzNM?=
 =?utf-8?B?VThzOXQ3NUVFZEdNNjhyTWhEM1daVG91VnVrSGxpc2gzanp0QWgvVkVnanRV?=
 =?utf-8?B?Y09CanBUU29ETUVxUURiVmlYU0gvbkN2ZytGeGUyUG9EM0VoTTJUZHpOaFNP?=
 =?utf-8?B?WFVJWFBsL3NiRlZzeXBEYWxQRTMxdUpCdk11Y2lXc1RRaURwVk1FTjNBdXho?=
 =?utf-8?B?T3N6L3hhclRJSlZNbjlCWmdXY3ZVNkVpVnFDc1VNaU9QNFd3Z25XaER2R1dy?=
 =?utf-8?B?VDlCc3F6NktGRHE3eVBFZkpyblpidjQ1bm1GalhwVzJtUmQ2NHRLZmVzVWtE?=
 =?utf-8?B?T3lBTHpIMTZwSkxoVVk0RE92Y0ZObVQ5aXZIWDlzUXpiTmpEMVZmdStWZUFm?=
 =?utf-8?B?dXJVTXdPZE5MRUp6Wm9BNFJ5bldDRnloSUdiMHdNcWl1SHNKMk12aFRvMjl6?=
 =?utf-8?B?NzMycEQ4cVFuMG94b0hISVd1UVkvT2NNV2QwR0R6MzlGZ3d4NkkwS2xlTUUz?=
 =?utf-8?B?a1VIOVZocS9FOVhVellyNXpZZ2NtWFkyMEwwVWRCQWpNMWlnNVQ2d2M0Rk44?=
 =?utf-8?B?NFpQL2RhSFluelhKaStOOUxXdUtGL2d3SkxWbXowSEE4OUdxSjA0SlRhT3Fm?=
 =?utf-8?B?OVpYVkErcnlQeDdpcGJGaVNMWnNlUGVKd00xQ3hpR3JpOHJYZUNTb1lqQW1X?=
 =?utf-8?B?SlZnUG10VC9wRjdhNTRBNXJCT3JRYzRNN01XTGMzbkpIMGNoSTQreGFHMCtl?=
 =?utf-8?B?MGpXZ05qSnRQZk0yL0N4STE0NWtRQnRKNlMvb1ZQZTgvNWFBcEVtaEZyZDhQ?=
 =?utf-8?Q?Uyw8ZcUPlpiG+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Njk2ejY3SDU2NW9HRWlQbHlWWC9CYW9JK3gyMzAramtDUVBtZDZXaTZNdS9G?=
 =?utf-8?B?K0tVR2hQTTFzNi93emRqZDNXS1A4anRrc3U4YTc5Zy9wZUVZY2U0MURkTGI0?=
 =?utf-8?B?bnRHQ0xwTXAxcGVMdmxwbCt3dEt5VThtQnZ3QzZxYy92N2JTTDN6RWhQejli?=
 =?utf-8?B?L2pOd2RyM0RWRnNQNzAyRTZESU81QmFQRHljSzVONFRvNFNFUDhybFg3Sk12?=
 =?utf-8?B?U3dsY0xlU05TcDBpQmx6cW44V3F1UXJaTjE2SXZlSE9qTmttR1lZa0h1UXZS?=
 =?utf-8?B?VVdWYXlTb3M5czkyMHdsWHJJTEFvNHJSeUpTSEJFUzkvZi9OUHM1T2pwQUtD?=
 =?utf-8?B?Zld5UkN5aTQ4alB2bUJ5OXdrRzhVSEU3Y29rbTdRa0lEUERCeFhiOGx1WUow?=
 =?utf-8?B?SFlwbE1SRk5aZm5oTzU5VWJQODRtbDJRRFVYYkVlZzZXVk1pdkR1VVVSUklD?=
 =?utf-8?B?YTlzTzJpRkk4RGhMR1FDdUg0M3hmMjh6ZDJMVXJVdUFVQUl6NEZFUnZ2bTEy?=
 =?utf-8?B?VktRNTFqQmZ6UnBydmVvN1RuWlJPYzVOWEFCOGs1OE1Gb0tPb0ZBYk5Id1Zs?=
 =?utf-8?B?UmlKcjlzYStPcHpSRUlkd3RxR1JoUzlkQUZJcDNPVHJwVkphWWRLdFdKWkpT?=
 =?utf-8?B?cmZMY3J3RUhzSFFsd3p0aVkvVkk1bktTRUk4aGNHaFFwcU1XRVM4cFdjMW1P?=
 =?utf-8?B?V3psREYvOXpOc2hXaVBxZDA0c2hjT0s3bVdqMXpaWnFnN1ZZVXVqbEtUWlYv?=
 =?utf-8?B?M1RHSlRYU3BOUXFZcHIxT3VGVjB1NERKb0lsOFNSS0Y5ZkVCaUd0TUZrc3FJ?=
 =?utf-8?B?bC9qZzFuekFFN2svcW1jd3k5Q0h6ckNKS2c5cGR6bTZBRDBNTWVnY25wUERF?=
 =?utf-8?B?QnpEeXFBZUVjTEZFT3FNTXlSMEhjZm9Hc2NJQnU3WlVTMTZBMUloREx1N3Ey?=
 =?utf-8?B?S2l4VmF0MjRHVG12QlhwRHVvczBycDRLWnVIZkJoUGszdExtRXh0VjIwVlFl?=
 =?utf-8?B?VDZrTHUxRy9sclFjRTJBOTZOTlZBVzBLOXlvQ2NZdDE4aGlwcUt2WWtMaTcw?=
 =?utf-8?B?ZEdnL1BZclB3SzZ1bEJNNmdEa0F0SWJrb01sWWpvUjJqQkwvWUxxUEk1czRF?=
 =?utf-8?B?YTZBcVo0STQzWThFRjA4RXU1VWxhQnEwUFlGOEsxRnhoanhjK240UHZzRlZp?=
 =?utf-8?B?b05uc3dZV1lvVmdYTjlDY252UzIzQ1dJZUExVUl3MHNObjloMEtmUnVoVEFr?=
 =?utf-8?B?OXhFZUdQQzh0WGZKTStBY3lDQXFVV3JBVFRBVVd6emFOWXF6eHRMb0RMMTRj?=
 =?utf-8?B?K2JrNC9qUHAvTExMVVcxWTJUNDJEa0J3U3I5clE0dmswd2V2QjdmMGhwc3Vz?=
 =?utf-8?B?elRYMzdKeSs4L2pUcWY2NGIxSEZNallTd2ZVREFLNnNOREtUbDcrR1hZenJ3?=
 =?utf-8?B?UDV3YTNRZkJGRWVUZ3lPMjVkUXdIUHVhRGdyQ0owTDhJcTFrUVArN1pxVzNW?=
 =?utf-8?B?K1NPbEgyNENBVVU1NldXMGwzcjgvdmVPbytzejgwUzN5eDZwOFEybG1oRGJl?=
 =?utf-8?B?dU1UTHJ1MFM4KytPWnY4VXp4SnZ6YmdYVEhiUUZxL3AxMTFTUnhrSGVGME5X?=
 =?utf-8?B?USs3ZDVRMXpYL3BpNEJ0STkzY3A5WkdZM2hPZmhmaktDT0VUOFRyQlQ4UHF4?=
 =?utf-8?B?RnBoQWFvekpXS1FEK1ZPMWwyMU8yMm0yRXhjMVBNcVlhdytZNkt2TEFHenFM?=
 =?utf-8?B?VEwwbTVrY0RoZVdXOG9PQmxSUzRGQTE4UGowUit0eUNnbmZMZWxBSnRlWjla?=
 =?utf-8?B?TEJDeHhCWkNpcS9kRGNtNUQ4N3N3RHRTRXNNYTlnVDdBald0WEF5b0xXWjgz?=
 =?utf-8?B?cVFvVlhhYnNUcXZYQ2t4SnZqMEJURVdmbGJMTXRXZGI0VmNTdTg1QlRsVk41?=
 =?utf-8?B?c2FVN2NlbEtDVU9ScklwdUN6bGNSa28wRnpBb0FBbkZ3V1VsN3hLR0xQakJI?=
 =?utf-8?B?MVVhaEwrNlJUZDZYb3F0dkhlKzRmcklCQ3FPWDZuQWlQMGxSRmNjSk5Da1hn?=
 =?utf-8?B?SEczcndKT0VTRHcrV3J2WUZnVy9yencvNFBHMTJZN2xaRUhVMEpmREdiV05Q?=
 =?utf-8?B?bVprRUN6RTBPa3d0WDBGZW9hRjBCK1ErOHJ2MXFRYVZPRDNjRG5mUHBVV3lK?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67efa35b-93d0-471b-7a93-08dd4ab17ea6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:33:55.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEGD3B6KVOImo9LdHwjVfID3AktdclQXIc0qd+trhhQ4s+5hlvaDOKF2irXnzZUpMplQDemQuPQpHWluNNwuLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8286

On 31.01.25 16:42, Florian Bezdeka wrote:
> Hi all,
> 
> here are the measurement results, comparing v2 of the patch series with
> Xenomai next branch.
> 
> All measurement runs were executed for 6h on the boards mentioned
> below.
> 
> The second line (per arch/board) shows the results of a measurement where
> only the userspace (so libcobalt) changes were applied, while the kernel
> (cobalt) modifications were missing.
> 
> Versions:
>   Xenomai:
>     next: Xenomai next branch with the "measurement patch" applied
>       v2: v2 of the patch series + "measurement patch" applied
>   Kernel: all measurments with Dovtail 6.12
>      
> Boards:
>    armhf: Beagle bone black
>    arm64: Hikey 
>   x86_64: Siemens IPC 227E
> 
> The numbers (need more than 80 characters...):
> 
>        +-- execution time of the injected syscall  --+
>        |                                             |
>  Arch      min    min     avg    avg       max     max          latency                latency
>           next     v2    next     v2      next      v2           next                    v2
> 
>  armhf   2.875  3.125   5.347  6.251    16.625  34.125    17.884/ 43.247/ 98.016  18.086/ 44.097/102.018
>                 3.083          6.065            37.625                            17.889/ 44.425/ 99.143
> 
>  arm64   0.833  0.833   2.575  2.716    40.000  48.334     4.306/ 15.240/220.732   4.957/ 14.216/217.138
>                 0.833          2.703            47.500                             4.620/ 15.515/210.081
> 
>  x86_64  1.104  1.308   1.356  1.577     7.116  12.396     5.274/  8.498/ 41.115   5.654/  9.015/ 43.380
>                 1.272          1.555            10.801                             5.609/  8.902/ 45.061
> 

So, there are differences, that was expected, but some are much worse
than I would have assumed. And using the syscall Philippe proposed may
only enlarge the relative change (by reducing the bare syscall costs).

If we can rule out any mistakes, I would say that the syscall clean-up
is not worth the costs it can bring.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
