Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C96219E1
	for <xenomai@lists.linux.dev>; Wed, 31 Jul 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456265; cv=fail; b=iAeZHz51Wo4Qex4EyhtN/2hVyW35y6hHbeLM7BWw4OyLlRNlAvddSUxDtxWTVNb9ZJuoUdbzCZqV6LGvdtCA+yRcKOcOTecdM0SLiM4+FG2Oy1znRdhfWEd1gAgyCmbckv/KihcG1VD3sb2lX0NGre4IAhmWhGrqZM58Q9TKcBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456265; c=relaxed/simple;
	bh=us5VbWGrJLa2N2MeJtWwQW7wuKay8wA6wb71CG21ZdI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SR77pOKQzFTIIJVS2tun+oAfR9Tbrcy4oTQuwC35oNAB0C+J+I6e3GaEeRxcUMa2qa+dSVN7ZbXkwokbVcl+jPZrOQMM6bbgf7lBgEDCCSZiaQ61xLjuSlTKzhhfgCbOAI3jr+UpKYROs15/UU98zZk57V48scuLr0rknBmyJMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lr+0AObR; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lr+0AObR"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id B9AD5240002
	for <xenomai@lists.linux.dev>; Wed, 31 Jul 2024 20:04:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20616.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::616])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 024E4941B9D
	for <xenomai@xenomai.org>; Wed, 31 Jul 2024 20:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xie7NdBzWQFntjipbpTU3KGjlIm2KKBNpEraBTa/G+32HSCAK5LR6OyGIMlfF5b2XLBFY4yf2hOBc8/teqT6XVnN40tgdi9peYJOpBUfxCArdHD/7mGhiaNA5pTOSUK+1+F/6r4w77+hnh52aDD5bLTPRjlUFQ278yrULFn8rtZVBhKfLlVtMLxMG/0NYt5ZEosUOUvyo/IRRW2VytXoOLLX4s8FeH9A5bX2NR/epuTOssGu5EpTKVAZ5ZWFy1YKQpgNT2ObaIABKJhKV58S4G+ILQmeqh9+eLtCqbmWsvPUFa+R5swYWWUPULdOamLaHjHRjiuynitudUHrivBNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CgHYXKliV2W/X/1CEdszt9I347C95ChLb0STaoXA8M=;
 b=DdZzPmdMz66N4TBIXBazJdrWiMC1CAHCjHHoMV+HX358NNog5HH9fMCP8wBp89KxD2UYQnsKz0Bremtn0TlR86N3NHWYb3z24JfcQVsm4crS20oRv4ZC1WKLMihg34jPpj1xyqads7/fSgSAWkDc7OTqTSE34JxL9OU3II8cOk6RExaqx5DZCxCJyPFef/61H6W0UHRTRZznvvFHunbLlMP1KiO/QGDf1hJwhczQkFtN5NRhz6b+eCfYAHd0pI9ZhGS+i7eKIIAP5STn0FDDB1yUvIYIjS/v9hdxFKEgjXcrtMdJ+P3CT50pSUdHYf+oC7z7EVJ3pK2B2b8Lkl3hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CgHYXKliV2W/X/1CEdszt9I347C95ChLb0STaoXA8M=;
 b=Lr+0AObRhwGVJpsu04bSOOuOMzIdCDUFEHq30KCTDqyHe1WLmRu1d3ehu8vF5H2BLBiOrck8+kLKWs5b8Lxp1/a3988gThfTVfgJTNVVWHz951NRPM1xUuoeD3Ph5R9vD8NqWVBIPDCiEP8EwijhR3XZ++OuffgfGbaZJoWIabJju7t+e0oUk+I/rM1hNzKqCEbDvJ1gnTwjYxALgHp7If3va39VYloyu/QZZIDTrjyyxCJug0hVjgfM43p6cGXbRl0zPNRiS535OF6FlPF57/kv7wDDgF0nW6lQs5MMgJ71A0uzN+GheTGPuIlvEWx9abGz7OjOgw42yVey0cXBbw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:381::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 20:04:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 20:04:17 +0000
Message-ID: <eb114103-89ed-4ecf-ac58-8f6f61215d5b@siemens.com>
Date: Wed, 31 Jul 2024 22:04:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Retirement of stable 3.1.x, warning call for 3.0.x
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>
References: <32ec5e8d-c8ff-4bf0-9718-2d61340812d7@siemens.com>
 <CA+K1mPFxVYh48qJ3HnJ1gC0uGG6W2ghUTgEUkzAu0nZgwf6oKQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPFxVYh48qJ3HnJ1gC0uGG6W2ghUTgEUkzAu0nZgwf6oKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c3caf2-1f54-4c45-613d-08dcb19bf595
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlMyT1ZRZ215RGdSbGk3c2lBakxVMzJSekhlMDNLdENPSFhWY2RDa2psUWxC?=
 =?utf-8?B?S2YrRGtXU01acnpsL2VTR3BNaWxFcktYUlVGeDhKMzdZMThNd3I3NS9IdkVl?=
 =?utf-8?B?VkplQm5vWEo4Um1hVWQwVmtEY2w4dFJtVENXbTdwM1hjaWVwT1NyeGM3K1lq?=
 =?utf-8?B?NFZFcFFrT29MeUZ1Q0syYlNheWxsQ2ZNYmh3RHhlSGlhSFZWWExEbVdxN3M3?=
 =?utf-8?B?Z1k4WEpZd2M3d0tWTWQ5eTRDb2wyZWdoQ0RpQ1E4ZkdCL01NZXpUYi9qbzFu?=
 =?utf-8?B?RjRobk93b1ZlbXNKS1RyTXJXZmxNVk5ML3VZMFRiVEZESTRYWjJJMElJMmhE?=
 =?utf-8?B?U1daRngxakg3UXduUEl5dlR3Z1k5R1kva1ZsdE9DQ3FiZUxpNWdoaXNEaWxB?=
 =?utf-8?B?RU9CS0orbmFxRXRtSkdsemk0MERVdFZyVmZtQkVzUFZOd2szdlQ2Tmh1d3Rx?=
 =?utf-8?B?NERmbjY5alpub3J4djdCM3YwVnp5T2phUHRtK2tjOFkyaWxmUUdQUWFySU9w?=
 =?utf-8?B?OS9HOXdGU0RMTE4yTlBKU1g3N1p1SUo3U2FUTTNLbE1BWHFhWlhFN0liaGVK?=
 =?utf-8?B?U2t5dnBmY3BGREdHQVBHMkE3WHFVZDRWdGFRZzZKbUVGaWdPdEVDSVFrTXgx?=
 =?utf-8?B?UTNUUFd4eDVueEZERUM1THpZM0xPTEdWSUdJekE4Nm9POWp4cEwycnNEVTR0?=
 =?utf-8?B?SnZlb0dDQSt5c2lpQ0Vnd1EwMlljQXRPdTJhOTFhZVJoMlI0UVJ1aml1QmpQ?=
 =?utf-8?B?ZlQ3ZWg0U2hCU3poek50d2Z3b00waXh2QVJDR3N5bmYxWjA3UWpsWXNyQlpQ?=
 =?utf-8?B?S1crZlNUaHAxd1hmREVhcFl3b2grRVBzQ3VqS2FWL2F6c0FCcUw0VzkrS1FE?=
 =?utf-8?B?MVlvZDZUTURLMjNEQ3J6N1h1Smh6QlJOZTYvQW45L0VnTFE2NGlVak8zVjh1?=
 =?utf-8?B?d0JRMWs1WDkwSWpOU2ZlTE5CYVZhL3o4UlpHenFrRzlZT2IxWllpVUV3T0dG?=
 =?utf-8?B?aThXRUlWcDcrM0xFMVhWQnFtZTlaK2RtT0pOeSt0NkcrcjM0MHd1N3N5YnVz?=
 =?utf-8?B?MkV6d0NnVjdrR0tWcjYxdjJULy9BZ1gzRHhGTG0yZTlvWHlldStnajRNbGw2?=
 =?utf-8?B?eURxanFvU0dNZGJMdU5sWFdocVI0VGVNUndyVjQwWUhRM3dXQlgzVGpQWk52?=
 =?utf-8?B?bWNJamlwcllXQmRnaUppSEptUTd1Y2VrcDdCYllabGJ0bFdEUCt6L0x2b0Z1?=
 =?utf-8?B?Y2VDdnI5czR5YWNieHJ4UVBLTjNhTU5kR1psSG16dE03dkwydjFaaStpMlNM?=
 =?utf-8?B?enNhNzh1MnVscm81bTBsQ25yQTU4ZVArYkJmMU0vTXNsWXoxYytlMmRBcVpE?=
 =?utf-8?B?NTh1N0g4bS9JSEhLRmpocHhiUGNFSGxiazZVSGNwcVcyYWRVZDI0cjNMaU1J?=
 =?utf-8?B?SFJoQ2hnZitvVjBHa0laVjJwS2YzVlJWbm9BZURBZTI4Zjg2NjNLS2s2N1Nx?=
 =?utf-8?B?WStpUTk3Wlk3OUNWT3lBKzhIeExKWHJ3S3FtNXFHT1ZTTTFjc3BpRUZMbkFh?=
 =?utf-8?B?K3VZaGdBdld3ZkFPeGVLWkJhTkc2dHBVVm5uSnRRK01sb1c3QzF2am1IOEp1?=
 =?utf-8?B?VExoN2hKdCt4ZlZOWS83YlI3Qno0c200L3loV01CVXZ2ZFNjbldOT2IyR2RQ?=
 =?utf-8?B?M25CTnkvVjhUTjlFa2lHNGFoaDJ2a3dPMXQzaFFkNmpXazhmTXRnOEpJblNJ?=
 =?utf-8?B?Z2d3dHFpNnpiaWtCSTRla1VQVDU0L0xKRTJrMmE3Q3pEdkh0c0syQktPcTRr?=
 =?utf-8?B?NnlIZGxKZUp4VE5MSEZLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHhvY2x1amZGU0RhL0RTdXQrYXRpWXBNWnN3Sm04cHREM2s2OEZKcXNoWlEw?=
 =?utf-8?B?aFdDVlNoU3dMZWpjVGpUM01mYlpRVjlYc2ltbERzMDVVNy9zYnNYRTlQeDhk?=
 =?utf-8?B?UkJFTmc2VWpDTm5ZUnVTaElucnZXbng0MG1JRVhSMFBqWFFmR0RLWUdEcm1I?=
 =?utf-8?B?YTNOMmlyVCs5cG1ack9NQzFoeUc2REJOVTAwWTBPN282NjlkdjhsYWkxaWlh?=
 =?utf-8?B?ejRZaTV6KzhYejlOeWV2SFpTR0hBVHgzU2ZUUVRHUFcxWGZ4ZFJhYWlPMkZ2?=
 =?utf-8?B?SWdYOWFPcHd1L1Q2R0YzNWN0d0g2NE5NLzVQOFJZUEZ3b1hGMXQ1NXhpUnRV?=
 =?utf-8?B?bVFvellGNWdGbWkwTUliNnZZSzk0QzNrSlRUOG0xU1p5bWU2Uzg1RWkxVm92?=
 =?utf-8?B?azNEVUtYL3hMM0ZRT0N5djI5aFpyeDk0bXVETVhlazF5bmtCOGNCZ3lRdjJ1?=
 =?utf-8?B?NUw3dHFBc0JYM1kwMWMxWmpoQnpRc2lGQy9iZzFlRFlFbmJBWnBLNkh3OTlQ?=
 =?utf-8?B?eXZpcjA5YTY2T3I4VjVPSzJFVlQ3RTBDTXd6ZzZTQ0Y0WlhTY3ZlYlFYZ0dh?=
 =?utf-8?B?Wmw0UWs1T3pYa0p6MHovUHdpWm9IQnRXL254S2NJcFIrNzh5dnB1YWI0cjhP?=
 =?utf-8?B?MDluZWFBSm9RbGlNUG1iY2lzRCtjU0wxaDVRVnBXNEFpWTgzVFBla2d1ZFVG?=
 =?utf-8?B?bTdmdjV4YVRVdUVGdnBNUzlnT2NpRHlQWnNBQTFtWGN0TlRWa2hhdDVFUitN?=
 =?utf-8?B?NkNKcHJ5VkxRTEp4azJDTDdiWUkybEZyQjdtaVFUTjRDYnFWL0NCY3Q0ZXZm?=
 =?utf-8?B?VUhCNW5OcTdJUWR6cHdSYnpBOWFyaU9IdE5rNUFnbWRmc3Z6K3BmNFE5cTlB?=
 =?utf-8?B?YWh5N1F0azhQbUJBMXA2NXBrdFNLdUFJN2JJM2xkY2JBbzhRc24wRThFU3BD?=
 =?utf-8?B?V2g2VjFJaFl4L0FteGVpN3A2dzYrZE0ydlNRK0xFRFh0UkNqTDFqNXFROVVh?=
 =?utf-8?B?ckY1Y2dNZjRjNDdqbkgwUnVrUjc3bFVNeFM5RVVESnk5djRwcE9raWNVTzlp?=
 =?utf-8?B?RVBxTXJuYVBaWGNmVjNlaEdUM0NhT2lRQlBpc1c2Z0U5eHh5ejIxT2xWaTNa?=
 =?utf-8?B?cE5uUEJhY0RrZmZrK3Vvd3ArMFBFMHJscGdPM1lmMDNMRmI1WUNNMWJ6ZzVC?=
 =?utf-8?B?UWwzbk1qVjVtUzJvYVg0Qm50d2MrWHI2TjQvWThPVFAvM1BHMFNPVEVRajFn?=
 =?utf-8?B?ZXRSbXUwTllibndCYmZ6WG4vYi9TVm1rRzNaQ3cvMHBZS2ZXajl2QmNFeVVV?=
 =?utf-8?B?ZS9OcGFScEoxRWhoUWpHYXFObDR1ZVc5MG94dVhTemVtOEtLRHc3Rlh2a08w?=
 =?utf-8?B?enlYczNHMTR0RE9yVXNQb3pPWGw3aUZwL2FOUnNGbHRDWHJpMTYyVXZDeEFJ?=
 =?utf-8?B?VzlVclliQlk3UFVmL0tDdjZsenlRODNSWkdaOWtUZEVCL1FtWXBaM1kxOG4x?=
 =?utf-8?B?RnROT2N5NVA1RUpmQ3lJcWNJaUxrOXgweWNXMmdQNE1OY0FscE5yTDJrOGNS?=
 =?utf-8?B?Wkl2K0dCU0tjMEFHWjJ2UVNnU1JYdi9LbEd4U1VMT1dLNENqYmk1bGpMbDFp?=
 =?utf-8?B?c3ppNHhWdHZMZ1JNemZSclU3S25kcFVSdmRzZVdUQ01NTW9vK0VuN0c2aUFm?=
 =?utf-8?B?Wms0RUJ4UkFYY2I5UnhmQmdzdWJQK2FOMk1rYjNCYlZsSjBCby9IbUlqWWw3?=
 =?utf-8?B?MGhyUUo0d2pySTFnWWxCNERSakk2ZEs0WHBnclp2b3VaalphSms3ZHJydVZz?=
 =?utf-8?B?R3VHaXFJN1lXL25GV2F2azdIREZEWUVDc1lvRkx4U0cvM0ZCV1YvWGdKcU9B?=
 =?utf-8?B?eTY3cEIvQjNPcmg1QWE4Wm5jODgzb2hDWlpKNDVxMWI1eTRlbkowWnMyUGl6?=
 =?utf-8?B?ajRiSzMxNHhGUG9qSFQwV09xb2daVWZOUVkwZnd2MVVNYjFGREdCMVBLZTRV?=
 =?utf-8?B?bHB3eHY5NXoxS2NTaHBIQ1FPaFBWZi9NL05aeURUdVF1KzYwcWdTaUlNNDk0?=
 =?utf-8?B?R2JHWjV0RWhTWE1Od1ZEZHNvRVNZOXhjZWdJV0Flc1Q0dzNzN0lYaExFT0Zj?=
 =?utf-8?Q?hSjs8P8t02v4Pgye680/cPeQr?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c3caf2-1f54-4c45-613d-08dcb19bf595
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 20:04:17.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHg35eWGp8CqD7LsJ81KZQGPuf4NxOwax7qbqnGSFsvaD+x6B0gKjhgl966YfBukiAh/q7DYvQ+JoYsqiNi8zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8163
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Lr+0AObR;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2612::616) smtp.mailfrom=jan.kiszka@siemens.com

On 31.07.24 07:57, C Smith wrote:
> On Thu, Jul 4, 2024 at 11:55 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> Hi all,
>>
>> around the upcoming 3.3 release, I want (and need) to reduce the set of
>> actively tested stable trees. Soon I will do some final releases for
>> stable/v3.1.x and then remove it from the test CI. If you are using that
>> tree, I strongly recommend to schedule a major update.
>>
>> In case you are bound to the 4.19 kernel, by now the only supported
>> kernel with 3.1.x, a natural choice would be 3.2.x which also still
>> supports that kernel. But more recommended would be renovating the
>> kernel as well at this chance.
>>
>> The 3.0 series will remaining formally supported, actually only because
>> I have an active user on it and need to keep the test pipeline working
>> for updating the 4.4 kernel from time to time. However, once that user
>> moves forward and I hear no other voices, 3.0.x is the next to retire.
>> Be warned!
>>
>> Any concerns about this plan should be brought forward NOW, ideally
>> backed with support proposals for the aging trees and pipelines.
> 
> Our project is still using Xeno 3.1 on kernel 4.19.229 and will likely
> be deploying that until the end of this year, at which time we could
> start migrating to Xeno 3.2 - but I can't get our existing users off
> of Xeno 3.1 anytime soon - that's a difficult process for them
> logistically because it means an entire hard disk swap.

Maybe time to look at some remote update pattern? Those do not need
physical interaction with a device, even if an update should not work
when designed carefully.

> 
> I'm just letting you know that long-life and stability is essential in
> our field of work. We don't require active testing on Xeno 3.1 stable,
> just occasional questions answered.
> 

OK, that sounds feasible.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

