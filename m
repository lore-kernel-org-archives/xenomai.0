Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5692AF05
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666833; cv=fail; b=mosI26jzM/osYfg5187NB3fEJ+YUAkLfih+m9qkny8vWwuxgVwTqEBInv57MrxyzlH157Lmo5MP4NK+Kze3wij5eo8nLWMySsHTrl5gD17WgRVKAEoqx79p6TJsojZr+7oAfTVp4CREYeTT0YYq9xwohz3GgSFd9cm4j8lPBtvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666833; c=relaxed/simple;
	bh=oazPaFQPhGTG7Cuhsib/jNdTe3T0IX3UyFdAEbpB1ns=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CFY5WTWyVgUGvhwT0i7hhBwf4IiHeKp2zcev0PlpdAnc8t7YfKrWcAXMTyt78Oy13gns/gAwBr563ZIEX0uE/U43nZgfwW0Y/rMCgNm4ZdWLb0+euIR4me+GRmacjY2cOlQqXI6oBAomSvpNv0Yl7Mm9K0RQzspFrva0dLCoamM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cc+FcQnH; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cc+FcQnH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWUQ0asZwIZt9twxnPNrX3HFLgnfilNJgb+DUevDmijB0H83mICItBzL3l9u01QWzWxGAgXg+FP+kLQSSmtt49gG+ObRe1w20IHN6uFuC4Ik57PL0iEX2lIXWVpABr0cSHShtLFHJp1gKxKluL0T91fb9RNwSbEHHNCR5ACeBeLBsXu356KK43NtKCYQKvsjSWhqit2YP4jgI2FUdHO5cPU3UyoMavGdJ0MV5mVtIRVARmAHvY8lzAKNVD2YfkSRdPiZlyFqzoTq/zETvpPJuIprGziNEtadcVIgDpsV0JXV6+CINl3g9/eobW7HES/VWMwoPtKMrCkcqK/OrdVeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Et+514dgMeZI4cwEJsn9mSLStDir79iTE+5m9Rc/mY=;
 b=YSjVSWPoWyAzPxJfdUMxPpwQ5acQTo1qX4dXQ2apHXG2IqUPwCBvYfaYVKHwu+lVyh6TOV9W+U+6uny4OfQmCeajHoDsmhImFfy8l65xGbhCK5PpJWGVqOCE9W9NqARw1767+MAG72EDOOZxe7y71Q1GkD4C/szfaNRSWEfgEFEbXftvRiEmrn/yFo5EqVAaFDnUA/ydT8PzZ4BWYbjEo0ByCnEWbyAERvAp3b5oSwXuBOLZKxLnt+8KTdas7POgfUSZUEmVtjLxA3wFoleR4MptNFlCNreAjaZ+HqN3ALqOj/u0aucWP3f89aYdOoheKKvTfFLImCjxgkJrdMuO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Et+514dgMeZI4cwEJsn9mSLStDir79iTE+5m9Rc/mY=;
 b=cc+FcQnHtHh6duEdN5KblY2fBjNSjqqGJqgo/5fgtG0ra90I0kiKpfsSyBkvXybJjXxRVJnEmelnaqLl+31NZzHbyRKULhd1ECIiHRn9vXJqPuqE9EDC6fY1csL/gX+21LSwGDLm76im09oHHSSLtdPNBoAZ3nqk8ZilM5BBFLWpEQdEyhfdX1JixeeRb/T2qW0poN3QYXwLXaRP2xGw/Glp7jPrjV4VyVIJ+JDdI2ZTMazkyKk2o+rGmX3eFWxyhmkK0RopI2qeAkOl9+OKjL7Xp1Wu8ACgPQglNfyh80H3eKwKyPGkX/UhEeZs6sd3LheVemYBvpENzBqCjaRkbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 10:33:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 10:33:47 +0000
Message-ID: <ec462a4d-e060-49a7-82d7-088cacd381e4@siemens.com>
Date: Fri, 15 Nov 2024 11:33:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CPU threads supported?
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPEtkU71sT7Dz6U2N-uXLiuuTsXEtvniU5jWBog81D1gvw@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPEtkU71sT7Dz6U2N-uXLiuuTsXEtvniU5jWBog81D1gvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 5caf9bee-7afc-4f15-694e-08dd0560fcea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a094c3Z1NG44ZWpYcHVVRzNwc3dFVnc1bmM3Q2luUkMrcFJ6UzdIWk1yNVFm?=
 =?utf-8?B?UGwxMUVSVUYvL2R2eWVtQmorZU0rcHkvaVYxSVRUMWE1bElLcDNXaEhuQWZq?=
 =?utf-8?B?L0R3R0wwNzZSMDRMZVQvVXVoT0RROEtnUEgxVzFUUFhBeWV0SG9iTDRmTzRE?=
 =?utf-8?B?Q3I5TWNreG41SGoxSnhidFpRMHpXZHRKemRkbC9LZWdiMlIwTmJRVXpxMWVI?=
 =?utf-8?B?dXZQdlRBcS9vWHVWMWQwOURva1ZKU240TVZXZ05tV200RzRDU1FISjdLcnFU?=
 =?utf-8?B?ZDhwdUpTQ1JsMkcrby96N0t5Zm1rd1JERW15R3VqeXd1ZDZySFI4NWVocHZM?=
 =?utf-8?B?QWZMMGtsT3VCNjQyNnJzcDN2aFhQa21RMXIxdkU3QzRQVExiT3lMd1dWYy80?=
 =?utf-8?B?L1BKNVhNV3RFcUx4WmY0a2pHQkwzam14cXo0TVlDaWErYmN0SWdvMjF0amhv?=
 =?utf-8?B?NlJxL1ZmT2F6MXB0K0h5STZMWm4zNzQ4TnFOaHJ5QVpsQXAzSEJIRzdKbjcy?=
 =?utf-8?B?OG13SmcxVDB0ZVJucy9NVzc3TjhzaW94Tk9PMjJ6U3BTdXpJbSs1SkVPZFp3?=
 =?utf-8?B?UVBRNzMvN3hWc1VqSkc4Mkt6dXlxeVhPYzlGbStDVlJtN0dVTUFVV1VjOVFW?=
 =?utf-8?B?Z3NxRHpjdGYwOUpPTUFENWtHcGthNmdrenhmemQxVEFuUWtYSXVYcUEzTExK?=
 =?utf-8?B?RWpaRFdyTGY4czY0U2toTXpXU3NDdlltT2lIcTBjUWVpdlZpZTZWM2h2YXdP?=
 =?utf-8?B?bVZqbHJSN0xiQnBqYlFwa3J3aExZTzV2Q2R2SWMzYmNQTlFUWFhLMXIyWk5V?=
 =?utf-8?B?RCsrTno0L2dhTUVQa1BBb1o5SCs1NXZMWG1DZmFZK3IrRk0wRWdvd09FRW94?=
 =?utf-8?B?SVdrNXMvRVNIbXg1NUVIU3NXeVdGNUk4YVREQlI3SVlzczhFYU9vTE5kWjlT?=
 =?utf-8?B?ZklBdnlOMUIwSkE4NDFyZVA3S1VYRnpHN21sU1RMcWc4Ui9lTnhMUGlEY2JG?=
 =?utf-8?B?ZVJpVERLSzRYMWFmaWJQcWxXaVp4STVwTGg4QUdUK1dSd256akZJMXI3TEFp?=
 =?utf-8?B?U3VGSUlNZm50Q0ZxQ3QxSVBjWi9naG1zc2tKbzBJc3d1ZHY2TUN4ZmdVTzVt?=
 =?utf-8?B?ejlwa3VqREhtMFlsblpCeThQWWxVeXg3YmNBVG0vNHFINHY1eGNMaWJWWUVP?=
 =?utf-8?B?QWhMWUJlcVhSbFdtcUkvLytzWEkzM3lMbDk2RCtDbmgwWlhYTmpTN2VnbGRr?=
 =?utf-8?B?Tm9NOEl5ckZ4Z3c0eHlKb003UldldkNURmsreUZOcVFWMzlQT2pEcndtc1d3?=
 =?utf-8?B?Z2dvc3dhMkQ1NFVLaE9maHg3S2pQVnJXV1NLN0h2NWhlVGlEL2xkRHEwTFVq?=
 =?utf-8?B?Q0xBNmo3OUtIUE53WlQ0VlZ5TFZTaThJc1hza2pDMWJ5N0ludThmYTFQR3d0?=
 =?utf-8?B?NVdCcnU1UXpxSGVvM0xlNFlacGd0WUlXNjNLMFowTDUwMmFSeFJCdDd1L29x?=
 =?utf-8?B?aGppMkl2VUVWdkhoWFp2RkdUTWs0b2xGUmp1VnJzbGxiM01XOUJqTGR6OWln?=
 =?utf-8?B?SS9TV2ovTkR3VWpDUUNoTWhGUUcxTGxEL3JxTGhwc0x1YU9OZzlldktXUzlO?=
 =?utf-8?B?SnIzdXlJb0NCb2JsV1dYbk1UVldGbmtFUVFmY3FpODl1cUNaRTd1Ri91cDZw?=
 =?utf-8?B?ZndaYjZsSW1sdjFGUWRPMTlTalRQaHd2UEhRbERJcnd5QzNHeDdseGgzZWYx?=
 =?utf-8?Q?u5bea0ENpBvyNGSwn8RtrdqJJ4g7CaQGint8Yoo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTluTFNCVXp4ay9PT0M1Q2FyTmpad05uU2NMVDZoUWU0YWRWTkFtSkZ4ZkxM?=
 =?utf-8?B?aFhJSnpYb0NyRFQxM21LTkx6c0JaeEdkU1NyZnBQSENqWVZsclBmeVBjRDh3?=
 =?utf-8?B?U1dsWlJWUjVleWJ6M1U1QUMzYUVlZSt2cGRnOTFYNlB4TThiWWtRRVE3Vkp0?=
 =?utf-8?B?UHA3aytaeEtZd2hZejhVbmJKbk1uNVRUQjErbGJpUmxzMFZOSndjQ3Eybk16?=
 =?utf-8?B?YXFNK0VpNHovaHRrZzhLMk1MMDZTUWxSRFVJR012dEN2QmwyQTREd3BHUVk4?=
 =?utf-8?B?Q2t5aVpNbFJDa09oUlErZnYrNytCQ01TSEkybGkwY1hTaHpzUXhZdHkzNE4w?=
 =?utf-8?B?Wm9CSXR4ZHdieEx4MGpMZ0xKdW5TakFRUkpUUEFGNUNCa1NDRUtEdTRVeUxv?=
 =?utf-8?B?MmFWVjE4blJUUWZpeXAraE1nWndLYjhzK0Jqb1N3RWl6Y2lvU1dRWVpld0tL?=
 =?utf-8?B?TzVobUsxaWN4OHp2dFhYRmpURGpYUzVHZ0k2enBkNWMyN3hkRHB0YXZTb1l3?=
 =?utf-8?B?YVlGb3lwdzFBK3UrMDE3WlloZ3psa2lqWlpTZEZWWjFpd3FtMUM0SkVFOFp6?=
 =?utf-8?B?YzlzMkR4d3lCczhUckQzL0p1anJxY3MyZFg0NTNNQ2ViNnUyYUE0c3NRRkoz?=
 =?utf-8?B?L1BvZWR6S25hZ0k2dERFcmMwaklrbnBPUmNRMEZpUWdyR0NuN2tkZElaeDl6?=
 =?utf-8?B?eGNvVENjMlBWang2RHNsUDFwazQwZTFIM3h0QTFTNmp0Y3VrRldaNUVveEZ2?=
 =?utf-8?B?dVFYRWJWRzhNL25jR0MraS9WaDdXMlNCR2RlWWVKaXkvQ2lLZmVZUW4rb1FP?=
 =?utf-8?B?UGwxZVdYWEprdEdxcE5LbnVVMlJPQklod3g1RzdieFh3ZG5VUnJBZk52aktT?=
 =?utf-8?B?RUNKNGxnMS9LeXVkY1FMc3Y2clM1ZkZnVUUvQzhRMEw2cVYrWDhQdDN3bitH?=
 =?utf-8?B?Z1VoWm9uUFREWCtaSFNNT2RFOHV2UDVoNXpNQ1h6ZnVjaVZ5YXZ3VUdzVmJV?=
 =?utf-8?B?T1VpeStBZGx6bW0vRGFmNkhGaFo4U0kzQjBDL3c3alQ1ZXhVRE9KZ29seWZ2?=
 =?utf-8?B?TnB0MFdtMjBGVHlkdnJvc2I5aVNFNW8ydS9HajJHUzNtTGtNWDJUWTVlZHBl?=
 =?utf-8?B?NEsxNkVFVHNmNjNjQVM1Tlg3aDhrd0Rqc2J0ZSsrSFJ5SWV2T2JRb1ZCRnRO?=
 =?utf-8?B?Q3MydkdJUU1jdHI4QytPOWs4VEV5UURDZkNFcFo0aFErMCtmOVhRcUJGTk1N?=
 =?utf-8?B?RDhSVVRDaWRWeU5PYWhoY0l0QUpidFYzWHpLemhHL2JLdEhJRi9RZnpFN1FP?=
 =?utf-8?B?a1M5Ym1TTHZmaU1HMUZ0T3dndzZjRnltZElWMXBGQUNUR2pleUZtQ0JndWZ3?=
 =?utf-8?B?WUdKN3kwQU9FRmF5Q3hld0IyREVvVGFCcWRSQ1A2Ty83WFNWQlhLbW5MT2xn?=
 =?utf-8?B?Wi9JUXJFbVhwVitIUTdhU0lpR2RaM2FsV0ZLeStWQU15Z293S0ZyRTQ5bEI4?=
 =?utf-8?B?bEI4Y0ZOZnpvY0loa3FtVGthTTkveFNsbk9Od01GVEQ3MXFzOUN0ZGRHeW9B?=
 =?utf-8?B?QVpCZG9jS2pkVHNveDR2bGhBS3hBZ0NKM2pUL2xQL3dqK2xsMWd2ZzBBWENS?=
 =?utf-8?B?TFRndkpsT2xaUWlicC9Cd3hoKytnZmMwa0Q2Ky80VzFRK0g5VmtPQllKdE5F?=
 =?utf-8?B?LzFzUjJLU3l4bmRKYWdTSWRxUHBtcGQ0YXhXNmd6WVhSd2JJRnN2bTdHczB3?=
 =?utf-8?B?blpZSUo4RUw5Vkx3V0Zvemt1MitBWkQvUjJBeEZuSXVkUnZ0Tm9ZUC9UL3hQ?=
 =?utf-8?B?aE9Ncmp5cHdiSXg4VEdTVkxsSENrckR6MGIwZFI2VUVIS294bXAzWnFhR0lM?=
 =?utf-8?B?TUl1d0QrSlNWN1hQY3k5T2Y0Mm9rMzRwM296L00wMVRMS2k3VWw1OTdmUjZ6?=
 =?utf-8?B?a0ZWU0FTb3lPNTFKUklFa1RxYTJBVHBRZjR3TDh2a2dpVUNwNmszZjJKaEtU?=
 =?utf-8?B?dExMNVVselB3d2dsMERZMU5Rb3RVcVU5RjJnaVk1amdzWUc4Vit0SjZXRWtk?=
 =?utf-8?B?N04zWHpWZzRsRHNaT2N6dEQ2UlYyLzBoM3BSRVJVdGVpOGxhR3RwMUQ5aVdS?=
 =?utf-8?Q?9sSp/XStnGOR4cvRFmAkxuIkk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caf9bee-7afc-4f15-694e-08dd0560fcea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:33:47.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqSnC9Wuqn8AlDB5nzdqLTeTBcj6DiY//CILwvssQaQpmcDZYf1glDJzNUFkZ0Pvab6CJbOQOW9y4pZmoWJdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6339

On 15.11.24 08:29, C Smith wrote:
> Does Xenomai support the _threads_ of an Intel x86 processor, or just the cores?
> I'm using Cobalt kernel Xeno 3.2.5  kernel 5.4.281
> I have this 8-core CPU: 11th Gen Intel(R) Core(TM) i7-11850HE
> I don't see anything in my kernel config that indicates thread support
> is enabled.
> lscpu says there should be 2 threads per core but does Xenomai 3.2 use them?
> 

Xenomai does not differentiate between physical and logical cores. And
that means, if you want to get a decent latency (<100 µs, on some CPUs
even just <1 ms), you need to make sure yourself that the sibling
core(s) are not used (e.g. offlined via cpu hotplug).

Jan

-- 
Siemens AG, Technology
Linux Expert Center
