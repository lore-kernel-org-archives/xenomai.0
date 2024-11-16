Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60366610C
	for <xenomai@lists.linux.dev>; Sat, 16 Nov 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731764027; cv=fail; b=J5mNi3+XrtQv4QWLK/ly4glAe89No96ICWZdfk+r8yQ2ix9nsQRCo0lo3Ej+XFRf9ThZBePMpHqjm877u61fOAeh9D6HtSxFnNYC6bHTEhAAxj1Fof5wh4WO04ohBhorKx2hL/gjp3OR0EVSR2hXYB5jd9mbhoNrhlpYTG9mw4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731764027; c=relaxed/simple;
	bh=KTVAtIuIQZNo91rSTNV3FKbcNLAebfvEnMyPhy28dOg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bla8MpxmnppI5B0QLfnSlR+2KWKMHBUYA0QRhw1IZO+MTTx/oBAgSzp7xRYmFt+eIFgUnMJBLrbMRPJQLLaPDeJCi/mD8IJtzxaddK61l/pzgxKHFf5xm4+doavYdvAnHDvmKJd0mi6HGN7Rf/+6ACSU0yrkyQJ8QiN7T2unuL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VkblAGSO; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VkblAGSO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7d+KzgyS71dazEtlin9V2I4/vYCdDjd9GYHhkgd0tNA9ukC46kgTiH4hDsOfMmkIFhWdbLJSmCjBQW2iOtc6ClU9mun0+8Sd9uGUKwdDyT8dIGBLy9xoKZO5e2KuR1Lu01T0gFzkT8pKj6Fwip7BnfGDTDSqYFq7fBmZmNeYq5Tx19yHvfbQVOVyKp6ZPYMRyB3MuWv4J5AaNwBI3J6cD3d4G+OlsjZneOQpr1iclN9LncH6QQlKa6Zc+zz3zKuodiaNQfvwvEwSLuEQ84VlQ0Y4IpWPfbJHdTvm1XhTmS3ej8RXHUMaemvRVGxrqPgB2xBg0xDACq5VZ9PNVgA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd2PdLQWXnZe0sG+taTJrX+z/oG1RuFN41bPUYGXons=;
 b=vYWUgk/JaGHKzalfkjlOVe+V2wpsnyXOgXGuIo+tfWFc376N9JUhZ8+MZOm+PUHVcZxdiJl4csB4GGGSA+d+IlMgMx27Dyk0FPxnCduTA68uPyf9+W9k6+Ou9N10RFd7DyzFT/xYNoRJwJGLZNw+wJqXUOcRJM5w3S+UsXOnenUuaEhUF5DQ8MZrswhkBtoaHacj9eOn2GiEtQ3Tx56e1UXptvA547atqGJDbNygNFBglesp7PRD0zZU+LlyknunJzfUwAkYii6zEabEA7E6WPeWYPmAEqvxANZgBYPrmi6+0uY3GYab1Nxdl634tIVRH4rbUQLJsoG9uThj+SKNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd2PdLQWXnZe0sG+taTJrX+z/oG1RuFN41bPUYGXons=;
 b=VkblAGSO8yifxUUowYd/WiWMHKCyOSDH4raEmAUz6YNvDGUIZwvDpbO67UI+1jOQRPPriqMACqsZEuQeydZo9p0Kz7c9iH5/DvG9g/NVOTXR/xpK3/QgQ+mKOaIiQiezNJLYk5JBtcbjVfSOrjV3L49pbycH5fe5vE7vGmKWO10tyo7jnF0Gk0Rm0uU6aIH8Ts9Ci+hnresCUQZoFOIUxUHWQ9ndDslaI722xDNGBgoyRZWEcyFYUxvWXx+VIDTW5gDh6lDhmCmX4+4YDbpdoIULWezvWz5FdbLGcqIMTC7IMNQMmaaZw1qFj0aktHQCaOWEYK9vwxKMLOhc/5ZDQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Sat, 16 Nov
 2024 13:33:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Sat, 16 Nov 2024
 13:33:40 +0000
Message-ID: <d4ff4ae6-91d5-49af-acc9-eee9b2ef2bf5@siemens.com>
Date: Sat, 16 Nov 2024 14:33:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai latency shows negative value
To: =?UTF-8?B?5a2Z5rab?= <suntaoworks@163.com>, xenomai@lists.linux.dev
References: <18194dcc.758d.19329a45455.Coremail.suntaoworks@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <18194dcc.758d.19329a45455.Coremail.suntaoworks@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7cc00a-d1e0-4427-8096-08dd0643481c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3FwelhrOC9ZcUNkRk5JZEZvMzRFVXFoeUhOVUJ1TjRPOVJjY2VVOWpYRWhz?=
 =?utf-8?B?Znl0dUowZ1NCSDhuTmpmRnFVRFBheXNUcnVvT21ySDVpUXNpZnh4dmJxZlhB?=
 =?utf-8?B?Y2ZHd25TSlJ2L2kzSGhHWDdydkYyQzdTMDNvSTZRMU9BbWFCOUd4SDhaYndw?=
 =?utf-8?B?RGRJUkNneW1MV1pBUUxqM2JYT2N3NGNSZjVDM3hvdm5BNzJNNFlGTWM3eXRN?=
 =?utf-8?B?UDVQUE9PNnNrVldFMU1OaDFVOFNJR2JWTjZIRTdRRHBzY3ZFaUxpbGw2MnFD?=
 =?utf-8?B?V1c5SHA4VFNpeGJlM3E3WU1vNENzZ3pJV1NLU2czUEI0WlNreXZyNzNXblVk?=
 =?utf-8?B?NDN5TmdCMFo4bVBUdUwyOEIzUHQ1QUtWbHZmZGNySXF3cnhUS2RveUtqcVE3?=
 =?utf-8?B?YnRoRGlQOWlrR0g1dHRzajlnbTlVSmVGc1NjMzQzQ2lNejZISjJZUWdsZlpy?=
 =?utf-8?B?TFdGSk9qcUJwQTY4L3RzOWVzRkc1WE0yRGxtNmp2bHJUZ3pCRy9mN2RPd1VF?=
 =?utf-8?B?d3RFQy8rUlgzSS9Pc3k1TnNFZk5FUUdWK2JVNkhjMGluQTlBcCtzdUI3R1pi?=
 =?utf-8?B?L0JzdzZtZlIvUXlMMmVYQUlTZ0VIN2g5Z0FoMkh5cytBMmlxc2dReXBKbnRR?=
 =?utf-8?B?REN5Zy8yNkVNcEtwdGNROGNOUUVtZjRPVDNFWmVXYUcwOHdGbGZsTUdwanF0?=
 =?utf-8?B?UGVWYXFIQUVHOTF1Qk9sVHdwbzNkRUM1Z2MwZFBqNTlQNWhUMzVpOENJUUFM?=
 =?utf-8?B?SGJHdHJwMHhKWkZqMG5NV3FhN25CdEVBbzJqVTNMYTlQM0R5ZDB2Qjh2OWZp?=
 =?utf-8?B?cUhuQ1ZyaVBOK3U5TmtqRFU5ditucE5ERVkrUHBJeDYveVlMcG04YnVlTFpC?=
 =?utf-8?B?b0tKNWRCb0prRFIwZmwxSkdRb2ZxaFlqMGt0UDJ2R05YUldZaVFNSU5YTlNl?=
 =?utf-8?B?bHpoVmhzeTNWY3BEOXFFWVlYcGJMcXk1ZDlPQWJqQzFISlN3YXdqZlFpTWU5?=
 =?utf-8?B?UTgrVGtvSGQwblhDb1dHUlVkaFFLT2F2Vy9GMEZBKzA3SVdrMnRaQzAxc2t1?=
 =?utf-8?B?UUJpTjBUWHIvTlFEY2xKKzE4V3VJRmd0NE1odjZnUFNSczd4RTFYSjdJenYy?=
 =?utf-8?B?VGtWMFUwWHErdGorRG44cUdna0E2bllWRGl4ZTdwa2Jub0laaDhrbEVVZ1pJ?=
 =?utf-8?B?Qm16YnhZZENBN0MxOW11b3U3bWlLbzFZd1duRGVDcXJrSTBYY0phY0dhalBW?=
 =?utf-8?B?d3U0ZjhudExiVkRYY3B4QWpRYkNnMXR0d1VPdWdvVmpsSFhqMDlWNGhmc1Fs?=
 =?utf-8?B?ejV2WlpOT090OUFUR0h1cGwvOGdPZUtvcVRGb1BMeTJ0YWxFM29OUThGOEtL?=
 =?utf-8?B?aG1VUWdxNXhTc3NpVEtzVm05S2VBeWhnanF1YlcrUFIybXRKK2FTVXpPcEk1?=
 =?utf-8?B?YnJLYnd2U0daYmsycmFweWhXUDlkdDFES1BPTFlpcFZLcUQzV2VEdVdVVUla?=
 =?utf-8?B?VnJWUFA1VkM2bFNIT1JGdFFFZENkOVdjcmpjMmFyNGVodFNtZjB4Q1dFbFc3?=
 =?utf-8?B?eUxhY3JuMWc2dDkxMW9DWmJ5WVFsenBXZmZ3bGFadTR4dG1CVEtMajRGOGJG?=
 =?utf-8?B?cEc4SXhwNTBqdmw0bmNrelJ3TVFkenBFWGpzOGNTVTBMVjV6WVF0dE9kTjJa?=
 =?utf-8?B?M3IrRThicVFoOHBKV1RpdnR4UkJRcTNiQTZVajlEMEkrUXBiV0h4NVZ2R3Ni?=
 =?utf-8?Q?tlWsftL+8SrZ4ZUBIpze9uu91BohDEcKPTvQ06T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmMvQjBTZy8zditFTzJxNEZQYWQyRFRBMW5UOE1wT1FLUG9YM09Fam5ibDRF?=
 =?utf-8?B?b002WTNYclNsaXdsWS9aSGVVRk1yZnVKVzM1TTlTMEVhMXJvcGppbTQyaXNW?=
 =?utf-8?B?dXJza3NFbDNKTHF6My9KWklvR3hwcVVyMS9keEsyMmpCSGVHQ2dMb3A1Y1lT?=
 =?utf-8?B?YmJGOWZSN2NkdHdYRWZ0MWdZVWtCZkRrLzAxMG9zYnJDczlDRXA4VXE4Q29S?=
 =?utf-8?B?ZFl0N3BJQzNCMHp6UGgwaEM0YUpsamlaR1RvN1FHMURlL3FacmxnR0M4VW5p?=
 =?utf-8?B?U1BpNzVZbU90ejRiRXZpUHZDR2NMTDc5L1hydVhia1lLdWRYM0xEZm1SOTlI?=
 =?utf-8?B?cUNpclluUDVobXl2WnhvdmdWaXAxYlNMQ1R6cHpnN20yYzFZWm54RDVqL1ZX?=
 =?utf-8?B?MTg4MW4rVzRmeUZLT2pNNnRVZGVnSlRObVltY2lNWE1LQWgrekI1bmFtREg5?=
 =?utf-8?B?U1JLd0tLWCs4MTFsZTB0U0VZZzByU0pCVnJGREFvSkFrbTByTXNsK1dqYnMv?=
 =?utf-8?B?aWlkMDFNd3Rmb3laVHJDb29HZkI3b1dPMHplQ1IzeWlBK3l1WEZUSDdaamJM?=
 =?utf-8?B?cWtEeGU4dlEwZGJBT0QvZ3VLTmtybTNFNithMWFVTnJFV2gydFFiRDB4Sy9E?=
 =?utf-8?B?bWdzYk5GKzhHQ1JkcnpIajdBZzVVbXJ3dFNpVVl4ZzNDaVdJcWVzZjB3SUtF?=
 =?utf-8?B?YVVPU0trSmZlcDEzeEF2VTN1d1J1RzZ1UzkzTTc0M0FUaFF5Zjl3MVlkeGVw?=
 =?utf-8?B?ZHZDYjJDK3R5TmVHTGUxYTM5UVZKZmUwNWNZY1RjNVZnalJUNGlOZG9wc3VM?=
 =?utf-8?B?R2JCbUd5czByNW1vZlRQdGZyMUcwN056VGdCMUlRUXhWSWx5SURSQy9MT09a?=
 =?utf-8?B?VGxydmxoam16RzV0K3FkWEp2QTJ1WjJ6SmNJVWlwY21pS3hDYU1XRzJ0MTVr?=
 =?utf-8?B?MmxrdXMzd0Y5TmszNzBWaW5YT0NRd2JDY1l4Qi9XRndPZEdmMHpvOGlGUlZv?=
 =?utf-8?B?TEdNZklTMFdhN3dNU2RBRnpkcW5KQ2FHM3F5MnRTcGp5R2JMVGYvQXFtYmRB?=
 =?utf-8?B?TzVYYlowV0JDT3hxTm42N2c5TzNnZGdnWEJxc0V1RVk3Njg3cklKQ2hMNk5H?=
 =?utf-8?B?dkpkTjZqQTJtVGRYMUEzaDZsWko2aTlxVklZa0JDRysxWTY5RG5DU2gzcnZ0?=
 =?utf-8?B?WFpTUSsxNGh4N2lLOVZTZE83VVpMSVpRYitYa01UZXhwZHNXM2ZON3FUM3Js?=
 =?utf-8?B?RldVbGNvVU1USVJKQmdIK1hSdTNVRVVVWHIzZkxLMWdUNkdBeWx5di8xdStY?=
 =?utf-8?B?dGo5Y0UwUVhTT0IwMDN3SVJqWTlCcXB2Y0FWcGZoZkhZSnE2QWJyWGYrZVM2?=
 =?utf-8?B?VTRtNGJGNGZ6bUVFT3MzeUZiNEM0MVNHdmQ0eUpZbW11UXNGSE14S0pMdlRE?=
 =?utf-8?B?QWp0VGF1K2lQT0I4NVhvZzVnVVVHRDh4VXRLU3VkdDFtRW84MXhjd01QMS8v?=
 =?utf-8?B?RWhVR0pvM0RTOUkvV2dDalZKZVFKRklhbGFhNmw0VUtsUDhGUTlWWkU4VFQw?=
 =?utf-8?B?OTdzZWJkNExSb2VTY0p4VnNPZHFGS2tGMkFwMG82bEgvUHlMaGQzTXl5dVhF?=
 =?utf-8?B?KzNGMVp5b3dWYVo0UjhEV2dvMnlOaFBaQnJFcFY0Y0Y3Wjg4Y2ZhNTEya29l?=
 =?utf-8?B?aFF5WSs1cVhVS1piSmJld01ZM3d3MnJMMXpDd1JLR280TEd4eDh6d0JiUENx?=
 =?utf-8?B?OE54dE5GdTdpY2w4YUY4T1loSXZkNmNuc24xQWZlZEcrb3JzNnQzSXRheGZz?=
 =?utf-8?B?dE4yaVVBL1JVS3duV2FoMlVhcUFkS25vd1dqNFErVVJDcG90SlgyR1dNWnJv?=
 =?utf-8?B?VHdDbmFqOE5Cay9nQzhuQ0xBTEEwREpMa1lpUUtKWW1ka3o2N0UwelNiWUxs?=
 =?utf-8?B?V296ZS85VXFmUUgra0pyUGthcmR1aEFKZkMwSm5UekRWODE4Z2JrdUtoN3FJ?=
 =?utf-8?B?T28rU0tWTG1EbWRiQW5ETkZRd1hTc0w0NHVXK2FtOWY0dWlmZjk0by9OV0Uv?=
 =?utf-8?B?dmNxaWRFWms1OGExSkg1eDBVSVQzK1FmZzdIanFzYmFOOG03bDl4WE9HaVB3?=
 =?utf-8?Q?1uTFFJNtY8sFUY8b/av9Gq/ov?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7cc00a-d1e0-4427-8096-08dd0643481c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 13:33:39.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trtQu3K29JSt2fEMkKkr+Xeufv4q1U38Q63Lfn9WhBkKGZN/Hp83Wc9SvZuCz+VkwqoCKXn6tkbXC5Eyc7fHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5811

On 14.11.24 08:47, 孙涛 wrote:
> 
> dear all,
> I run xenomai latency tool on my device like "./latency -t 1 -p 100", the "lat best" shows negative value.I autotune it like "echo 0 > /proc/xenomai/latency", it changes nothing.Please help me.

This only clears the userspace latency, not that of the kernel or
interrupt handlers, see /proc/xenomai/clock/coreclk. To manually clear them:

echo "i0:k0:u0" > /proc/xenomai/clock/coreclk

Jan
