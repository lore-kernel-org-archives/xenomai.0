Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498742A1A4
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411870; cv=fail; b=bc452bngFuNmMxCGA/oBchUGv+9XxpXmU6bClARu1ixx8WJjX9enE+xa1XqFx9hCZVms7yTHEvHFMRJTi6WR3Vl4weNdawtwz+c0VWgBPIlTot086OJCMCYWnwVtZBAH7/MjKKUJC325Y9SDZqSlbU2rWSU1Q6H3y29ekTzml3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411870; c=relaxed/simple;
	bh=fWXQIl10QY2MzsRe0RcnevK0B3Tx6NVdE+r27oNUGqo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oq11x1b3ikI4kv41LLWTbM5VY3DVw/L1AZNNCL9nLm+WcGSQ9LoaZKHS/tCEznBmv/JtNEiGePtCkPFgwF2hIl5zczLfHS2OibsSn+sAwSoH6AaGCGDtHNgWGqmoL+ZUUizQ3pw/48uIy0lj0kh7c8m2A1FKlB3igqrxsiZfdtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hAhFI3BI; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hAhFI3BI"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id EFEED43615
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 16:10:58 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20620.outbound.protection.outlook.com [IPv6:2a01:111:f403:260c::620])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 35999AC0DAC
	for <xenomai@xenomai.org>; Fri, 16 May 2025 16:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaB9cxro0yo4t7INEgKDTd7b1JBoWNKB5GBTBrwn4yN5gVyTQVl2H5LJb0jyc7CeDoq6WsSv7beBgkmCCatmJqorW9h+BY/aHTxZMkhZAS/moPzcXweLW9ZRHnMZA4OxMhGAS4E2aVAFFdHKuDyYIgqu1gAziJScDCIGiRLxGm9C4JY2SjVaY1TBerQD5I4Y6tDAxc6FmvCvT1rOwbWlEndOfVUvGDnLjS4oQmQsKgXofp9FwWkZI2Z8wr1JBVuF/PNbFyr32tf+DUnkhl47yr6jwnqlt9R4GrqLjODHoUtl4Ze2ghAoyCJs93hR53hTRVrrsjWz0XBZrWye+CYgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uCuuPfEvU1sq4FAjXdRFTC3WI6JPJtd4FpDXOlH+MY=;
 b=OZEDjASYAGbdMsvCapW0MYyCLUxrvPJrSSdSq3rs2/b8u2EBkQVtaF4oYfCxxbqbEe1ZeICoENuSLge2nBXgmcb61wmpKXHkO+wmyfOnj8lLxxhFRci4UXncwaf8w1qhxc19DgHcoUfswHUWYH0qHq0E/9Dxh3qhoAgr1GqMxNUywQMH62KBDQ5mth89rczcYhqGh6AfAxK1sbOO7VoPtx1/BRD67ndEPnTLC4qqxFJDF81wpQfbryo9JtemIaxIBHibGFwN7j8Q1ZhiatDSUEQZRh9HCZz2WrGrSZJz5nyz7XL4Wtkc8xw0KHWMbqDLzuAbdcU40fAL7wUi/8Jl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uCuuPfEvU1sq4FAjXdRFTC3WI6JPJtd4FpDXOlH+MY=;
 b=hAhFI3BICfFT+mMOkwBKgq+emLe5JBBZai5q7++AkwTbHJFk1/UIislBz1eUfIB30BIsansCyHi+DdVLpERsG4Xoi4EDSUNC8b5MwIaQUJgF0MNCDHqeMtMLgvLbi1Qnf1PAEZaiqvnTSXmXnU29ng6PzrgCdKTU+KiluGNy76mAIxbRPOJ0qbJyDljrRLKO64n+kCeUyEeDEOUNE6cUwhQr5H2quA9/vGSmTULjm6Wj6E4ScNh/QXp9FOhPAB9m6kuncza/LJMktO5C9NWFf1SkCvLMjcVmcBpfBySfhOg6WbDFwOb1u+f4DHcdJobVIj9uwVdWx7Do+/R2t3NgDg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3663.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 16:10:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 16:10:56 +0000
Message-ID: <971fb2dd-2b53-4ff9-aac2-8c78ca0b2812@siemens.com>
Date: Fri, 16 May 2025 18:10:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry about Xenomai Performance and Latency
To: =?UTF-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?UTF-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <PU4P216MB1353703F35EA11A43EEDA57AA993A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PU4P216MB1353703F35EA11A43EEDA57AA993A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3663:EE_
X-MS-Office365-Filtering-Correlation-Id: 55253913-883b-4a8e-8aa3-08dd94943d62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0MvNnZEN3E1eVNrdFFWSmdTeHZDK2xTcTRwYzUwQThEYndVY1M4RzdLZmY3?=
 =?utf-8?B?WUhMU0ZhQWc0VElRQVRuWkZSaG1vai94QzZwSFFsWStRUGx0N3A1dDBaMk1H?=
 =?utf-8?B?enY4MnlpaGFDNjYvMHRRSnNIRzZqckh6Q3V4Tzl0NDlEdWNSUGUxTGZIS3pX?=
 =?utf-8?B?aEhlMGRhTHFVK04yRnVwWTRmVmRFdjZLN090dlBHY0kzVlJGVnAvSC93S2Q2?=
 =?utf-8?B?MkVTZ3lzRnByVi81Z0JES1N1QTM5bXZNUUV3SkZXL1ppaTJwYVZ1S0VHa0ZD?=
 =?utf-8?B?c3VhUmQwSWlqNmp3N08xSTZzbE43SW5WOGFlbkR3ZTRmdUhmV0tkdjh1b05o?=
 =?utf-8?B?ckplNS9JZ3ZUdTZFTGxDaHhuYU5ZQkFVYktmc3ltaTBDakVvbVBqNHI2emxm?=
 =?utf-8?B?ZEpPUHM2OEk2ZzQ0bVE1ZHVRaFdERDcrazF4WXBtbERuRnd6WFNpQXRPbkFS?=
 =?utf-8?B?NS9qNlVaNEUyUWdqY0padktQTkdyYjF6bnA4Mm11ay9rQWp3c3VXVVY1UzF4?=
 =?utf-8?B?TklxQ2ZacnNvREFIbXRkeWpBd3hvN2xHYkpFMW1tbkl0WEhodHhoOVBNZDVk?=
 =?utf-8?B?bm5WTVNZTXJ2NmRldlVoNVBXTFJlWGRNU1dsOU12M09wejRKM203bTFhczR0?=
 =?utf-8?B?UVdMUjRsUDhzczVSazZ2a2hvaGJPdC9WQjJKdGk1VnN6UTRrallwSHlQMWw5?=
 =?utf-8?B?RjI3a3JvM2NSclBJYWZoZnd6MGFlSWFXTGVLZVQ3aWMwajhTM3lORm9KRE1r?=
 =?utf-8?B?WkdUalhXaTJwYWhQZ3hPN0dBNEw3cXVjZVNncm9BZVN4VnhDM25NUE5IMnY4?=
 =?utf-8?B?b2JOQWVYSE5MbVAvUXd2V0lLYndBbU1UbG9JY0pNd3RCUEZmelpnWFNzYjFi?=
 =?utf-8?B?aExUdDJMQnRxdTZLRHkxeXpBd25yUkdtRHJxend2c2w2NG5haUtPVHk3Slor?=
 =?utf-8?B?R1BVMkZYMmFvdERkR010aHV2SmplU1dPbjE0SWtPMmJpTlpTaThyYXpkdnBO?=
 =?utf-8?B?ZkpuNEtYbC8xMVlXNnF2WTRPZmcwWXMyc0lXYTRwMlByeGt3bWtpR3hMMjFV?=
 =?utf-8?B?bXZvVnQ2ckprMHkzdHZWTGRlVXZqaks1eGduRFRnNkRXUFViZDN4bVg1MDYr?=
 =?utf-8?B?TjYyUnJYb0FyL3dqeEJ0NmVOeUhvL2JIbVBzMC9QcVdpU0E0TkJQQm1wbjFG?=
 =?utf-8?B?ZEljSDV2bW5ubFJNRnFTcmhDSVg4ZXhhbVZhdG9LRDRSNTJ4TGdkRWlTWGhZ?=
 =?utf-8?B?VjMzNGRrZU1JYmNHZG96OHdQcGpOa1E3WjV5bG9CZS91L2lsWVlYb0FzeXFP?=
 =?utf-8?B?a3g3WEtVaW0xT0ZsUmxWQ2RVSEVlOFllR21GMkszWHdTNzE4NURvR005M0N0?=
 =?utf-8?B?c2dFR1ZSK1RIRHJrNmF0WlpablAxVUliTnc1Q1NQemtUcjAvbzBPRUNZcFBn?=
 =?utf-8?B?L1ZkRDBRRnh4YTM3cy9ZVDAxRkNVQXpSVlZjblFLRHpLd2lTYTQ1K3BYd2ZF?=
 =?utf-8?B?RHQ5SXVrM2ZsWmdZc2VxOVR2QkpUaFBzS0dJb3JNeS9YQjRRKzY4QVY4UjN0?=
 =?utf-8?B?RENuVVQyWXFWbGhRTUQyVENPL3FxOW01dEliNk1WZHB3dzFwYnFoN29nTnYy?=
 =?utf-8?B?QThYRlpadnl0VHRkLy9UZnc0VUhOTzN3dFJ3aFlyZFQrZ0N6RGZ1SzN1elBy?=
 =?utf-8?B?VGVBU1hydEZ5dWx5NVRoTjBKbUVFNDJUbVgxWUNJMG9teXF4VXpNdmYvKzNQ?=
 =?utf-8?B?enkvL0FGN0RhQi9CQUF2SzBRYitpcUloVk9BOVBqN1RwMXRrR1V5alcxWGZt?=
 =?utf-8?B?STI5QWtQOXYvNlY1cVpyOW9lK1BuR0VXK1BEUzgySkExMVJqV2dzam1LamQ2?=
 =?utf-8?B?Q1NpUDZuVkZxTFcrQjBtN2o5VElOalk2UVJyc3R0ZHU5TVIzYzRTRUNtNXA3?=
 =?utf-8?Q?113A4rvgZi4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlVmTWdYc3JqVXUya2llYWVPaU9LQVZ6WExiNkpOaDh3UW1BMm51NFJ1Z3U1?=
 =?utf-8?B?bzVXWURtMmNaRzRPRXVSNlpiRUZSR2hlSlkyZHRNd2hXS3J5UzVBeVdOZnNa?=
 =?utf-8?B?eHozTTM0RTgvRmpnRk1TZ1BjZnY0MU1hUDR4ei9FR1B6MFd5ZDYwQzFFUkh1?=
 =?utf-8?B?dFN4bi9HaW56UTBLOTdzLzdPN09tdG1ZZ3ZIMEh1VlZSSjZaZlo2UmhLNDFG?=
 =?utf-8?B?QUUrdXNrdG5OcGIrQlVwSFhOYTJVTERzWkx5ZDBuYmF4Y09zbnBGZ2YzeS9D?=
 =?utf-8?B?TDM2UlIvdUovMzVVL056WDhxeUxjRThKUzVaOG5sUGU3clVmVm9WUmxYR1BP?=
 =?utf-8?B?Wi9WQ2pqUlluOFlmaEU4alBNVGFWdHRpT0gwUnJjSVpqZEk0b1E4Rk4zbW04?=
 =?utf-8?B?YjZyQWRYay9ZOElkQTNDNWhHQWFKaTM5dkx3YXNBZXhoemJaN3FvajdTa2Yv?=
 =?utf-8?B?Yk1jUEN1SmNuY0hWdUVneDQveWwwamc0alJTUlhuSzM3MGtFRHJwUmhjMjdC?=
 =?utf-8?B?Z2lpa1JvQkVoZ1YvR0p2bmZ6M0ZJRW02Z0F2V2tLcWFxekNyaEtFOGpLQkNq?=
 =?utf-8?B?S012cFZQSXFUY1FDVU45UGhlOHNQZllRV1VtN1pqckk2S2J5aDlwL2dzUDk4?=
 =?utf-8?B?ZEJHMG1wb3hOVTBVK2RWeWFtR2NVTjg5TEV6c1pYMFJmTitPQ2tCeXZXaktK?=
 =?utf-8?B?ZVBhalI1b2k2cHBNTWJCaUhhbG9USzdCRitFQzZrM2ZYZWVPS1FGWFBvWkpF?=
 =?utf-8?B?YVh3ckVjSHduZWpUQ3htRFRDWXFuVkdXTFJFNEJrUU1wRFRjNms3R1R1eldR?=
 =?utf-8?B?cm1ibkVZQThPM3c5d2MxMWRSVkkza2RSQlAwOXVxYVkyWnFZdklrQmQwNnZO?=
 =?utf-8?B?WHNRL2UvOHpJMVpteS9NVHU0WTRMZ2k3VkdoQ3BNb0l2dWQ0VjZ3Rjk1blRO?=
 =?utf-8?B?TmwrODQvTGZENjhmOWw0TkRpMGtKYUJrREplbm1Mbnh6KzNTVUNMeXJEYnpZ?=
 =?utf-8?B?akMyZk9YbTZaeFNZdEY2U1ZjZkpFMmRPakREaVZ2M3hZaXFiMllja1JXTjlI?=
 =?utf-8?B?YVphcThPNE45aTR5UkZ4Ui85UDVKSWhSSkxHSFJ5U3M1TjJWRVhDak15cGZZ?=
 =?utf-8?B?UFFoTWovVVhwMUgwNlJNRUNZWjdUbDQvWDJIdG8xRTRTOFg3VEFUR1dkSS9N?=
 =?utf-8?B?OGlLZ2RNd1U5RkN1TENadmhSM1VCQzA4UWxzWi9PSVJncjIvaForTFROL1pF?=
 =?utf-8?B?TGRmaWtmZzdGeEFNWVZydlE3UFJIbmtNU2J0Ym93RU5MSCtaQ1NRUXhDdkJO?=
 =?utf-8?B?anFpb1loZlJMRUtGUDB6UCtFWkVuY0NmYmtLRi83eE9tVDlhUGozVC84UGc1?=
 =?utf-8?B?U2tOeWUvUkR1MThqL1dEZTJNc1Z4cU9EUWJqUVozMWRkeWpXTWl6Skpkb3hz?=
 =?utf-8?B?a2dkb0ZjZnZwbjNVbzNBQW1qSWozL09uOUtVS1I3cjl2VTBmTFdyTVU1QWkr?=
 =?utf-8?B?NEU4ZTFPZ2NKRkFuVTRoK25pVGx6TzNZMWZwTUpaYkdZOEtVWjJxNTAvT01p?=
 =?utf-8?B?VjlLcUFaclF0R0orWWZiLzdxTEJaRWxKOHJLemZUckliUFJQcWZQNjZ1YSt3?=
 =?utf-8?B?dUVGOC9JUm01Z21Udm5BYlVQUW82NzAwdlhVNHZyZHN4V1RIb1NwQmxYeVlP?=
 =?utf-8?B?Y2o3WjZZYTNvSFdnSVJmblQ2VlJ1NXdVR2FXMWV6TmNFbDZVVHZUMGFUVWFY?=
 =?utf-8?B?K01UMlpLRWdwZkhCODl4d0FMT1VCNXEwSk52cjlnYi9OQTdUOFh1QjRyMllp?=
 =?utf-8?B?dU15WW13THcyYlhUQVh5M3JDdFo0Y1MxVktRNFFKTTdsb09RVjF3aTBwdFhj?=
 =?utf-8?B?SFpuSGZuck96eGNJS0FNbG5HR3FFL1ZsV05MRkhRdTdXM3ExMUQ5ZmU2YjBD?=
 =?utf-8?B?Um9WQ0t6ZWRJZnY1UERSQkRDSDZKM0NPQ1hFWTVoYlhmWmd2Z3lmWERoSlF3?=
 =?utf-8?B?eUFhZTJFclN0NGtNSGlHRG93QWxBWGVwQ2tpUzh5V3o3Yk92czA1RFJyVXgz?=
 =?utf-8?B?UnFOc3MvazBHZVJTVC9TMDVaaXE2SkpmUm13MjdDMU8zQXhwRlBHTWZnM0Iz?=
 =?utf-8?Q?Hb/+xFD629Y/B3oZYyWDmhlcX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55253913-883b-4a8e-8aa3-08dd94943d62
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 16:10:56.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClpSCtiJqdeTatoBUnlSu2auwAsCfxvfOgOt1pL6Pk+sYKPYbQCNbD69inmzIaTqZ604NZZz5SCdyDxWFE2PPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3663
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=hAhFI3BI;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:260c::620) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepfeffudehkedukeegudefffejieethfehkeevtddugeevheduhfetfeeuvefhffeknecuffhomhgrihhnpeguvghngidruggvpdigvghnohhmrghirdhorhhgnecukfhppedvudejrdejtddrudejkedrvdduvddpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduvddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 16.05.25 11:20, 신민철(Mincheol Shin) 선임 두산로보틱스 wrote:
> Dear Xenomai Project Team,
> 
> Hello, I’m Mincheol Shin from Doosan Robotics.
> 
> I’m a user interested in developing real-time systems using Xenomai. Recently, I encountered some performance-related issues and questions about the Latency program, which I hope you could help clarify.
> 
> I hope this email finds you well.
> 
> Q1. I have read that when using more than 4 cores with Xenomai 3, there is a performance degradation in the Cobalt core. Is this issue related to the 8-core CPU architecture, or is it a problem with the number of cores being used by Xenomai? If only 4 out of 8 cores are used by Xenomai, will this performance degradation issue still occur?

4 cores is more of a rule of thumb. Where the scalability limitation
actually becomes visible depends on the concrete use cases. Xenomai 3
uses a single lock for protecting most of its internal state. However,
it also takes parallel activity on multiple cores that run into lock
contention so that this limitation gets relevant.

We have run older Xenomai versions already on 256-core machine, but only
2 or 3 cores were actually involved in RT tasks. If you use the
xenomai.supported_cpus tunable
(https://source.denx.de/Xenomai/xenomai/-/blob/master/doc/asciidoc/README.INSTALL.adoc?ref_type=heads#cobalt-kernel-parameters),
you can help Xenomai in such setups to stay "in its corner". However, if
your RT workload should actually scale over many cores as well, you are
very likely better off with the EVL architecture of Xenomai 4.

> 
> Q2. Is Xenomai 4 more performant than Xenomai 3 when using the 8-core CPU architecture?

See above. And/or test your use case on your target hardware, at least
some mock-up of that workload.

> 
> Q3. Could you explain the meaning of negative values output by the Latency program provided by Xenomai?

Please have a look at our documentation, specifically:

https://v3.xenomai.org/installation/#calibrating-the-cobalt-core-timer

Best regards,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
