Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C49156227
	for <xenomai@lists.linux.dev>; Wed, 28 Aug 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852429; cv=fail; b=KSHTf+bVovBjA/X1f2mXqpse1Ek1yPD4NyYWo5GZrkC9s6etNdb9sUwDrEZRgrVvLDAXYtB+GodPQVCfqDg4fhMEyiFpR5WaNjli9r5KIwVQvPXcD2wYgIIRUq3SXrvLBxNsesc3yf2Oh8R5+UQCldCxsFoL7i/XzXScKxaJLjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852429; c=relaxed/simple;
	bh=2AuG0hK/cEtsLQblauhKVeW6yWJTdDeexEaSHzr4Rs0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+mc3gWDoW0aUL6LwPpXtp/gzhE37QwPZ5vkURUtY0+yXtR1+jBcXI2AAE7AXV5BsqLhh7wPaHq08FIXfZuZ4Dw7ie1wmJxdADI03REhBxrlmXhG+wiP3jwjiIeZDGRN+AQE/5ST9vshyWFme21xBlWy2+eyqbTHL4moCqB0HOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JDg5aSM0; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JDg5aSM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS4mew+YowPqtmxnKqg8V+0xeEe7gph3dLAvfYQ/XPXA39/d8lvLC05famoA7uezKSF81THAizLZMTRV1wZz4mKDxQ4ohG6Q9QW2tHQ8lyWCpXfXGdX1hudcLbBqfSTMN+YOxMaszWvP5NFiterch7ZnBvkfDya5BQYwHTvy/larHhgTYzJChfWNr5dZEBrIIizk6CLhvgHY+bL9LDt92HtRaICkrjyvo7bFWzyvQa2qUmVdBcBQuA30FV4bFkOWBrerPg7A9PTDPKjZNcFjf+N2zh8eTOsuproLQjZL+E9YIH8BCz/cd6hWwAt80Q+QizY8yoZz+8gvVpzKIiTGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ1TBjYUvEkOTRXAVKHdWa5geltDjTVdXphjCuiU5Jg=;
 b=QNZxrGFn44yVyc59MnsAAFmOqqAqg4yaLn0vCAyvjndgl67adbxJEj57ErgL7bm89BTTeZQGGqsQ0NngC5LhsitEtg5R2HpWelqGhkJniKEszVKdbh0lbGhcMYeiA+lweOL5lE7Ng4nRk1/2ZCeVTXso22L/8czbuxOsc1z+Yqq/eAcOWQDkKfVPw7MSpCTZTczz9VMQt5jTGVjHkFRJvLh3D93r20A6OU9tN5rN0LkkLv4rDACsh5F0tzQAZjV7Uw4ZlNpndxFMS34FPKZ+MGrXb8GSuWHqQiftx4lgyfhv6bNkfxWwVcV0L6ENUegkqcAoaQQBcGkcUy1zh1s/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ1TBjYUvEkOTRXAVKHdWa5geltDjTVdXphjCuiU5Jg=;
 b=JDg5aSM0zQnQn27/M0DSQznqKNifnOm6PUgXW1CGL6IlI91g8HqZj6Z+B0R/VfTKXYcIqkPAvIm3ZSQNkLbZ2U9uqpC0OlaMNvOBqEb7sAleoPfashjGKTRm30kIjFAmKL+wb2IuCULdIV7rstXlyiDXwjSpoH2flev0ARNcQYkP51JY98puDdZGF+H4kk0xqNXE9uJpv99uVx/OV3i4ZETTCY5Tf+pde5Uoy+uNjorst2Hcb3ZIgPOXSClthsNLngHjby4RfJlJTe4GmAss7xucRHA1jJz2CyrJVft59/m5nf9iQDQXh6ureJHMBWrjwBmkc6oluvhEHRF7GmaEOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:162::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 13:40:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 13:40:22 +0000
Message-ID: <e48a247d-db37-4c78-ae35-0d1a35646aeb@siemens.com>
Date: Wed, 28 Aug 2024 15:40:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "Mauro S." <mau.salvi@yahoo.com>, Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
 <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
 <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
 <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
 <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3917:EE_
X-MS-Office365-Filtering-Correlation-Id: b89eb183-54b5-4f78-1a40-08dcc766f70c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlZBbG1ocDlIeWxJZy9vRlVPZHRLSWFFRWtUSk1hTG82TTBzQ3BpNTNIa0xN?=
 =?utf-8?B?VHRtS1Y0ZWZYeEJSWnA5cDA0QzlJRWEzUElRMTQ1THlvRnUvRUdVWWNWZG1h?=
 =?utf-8?B?N0Q2Ym1QQUZGUk9ub2xBcDdzKy9VdHpkZCtDWURrRVV2VkhrK2Jhd25ITUdQ?=
 =?utf-8?B?NlJsaUVHMkROVjJOREZ0VGh0b3RGTUJTMUNUaHAzY01jcktVblByTmRzWnow?=
 =?utf-8?B?K2lTZWhUSzJoRmp2V3cvQzY4WVNGUG8wdXRJRURkdHAzMUpibDJmcER6Zlhm?=
 =?utf-8?B?WU1wUVZyMnZCZldyWm94RzFsRndQaU5tMEtZUG9MUWFld2xKSUJiL2Jwa1lO?=
 =?utf-8?B?aG12TDg0Z29mOTQ5ZmcrQnhxQStCL3VnbDZPbzE3QVFidEpWMXVSK0lkK2JP?=
 =?utf-8?B?TnRYeXJmcjF2ODgxWE04OW1MMkJUZWJiYzVQZFZJM3QwcFdNQ2FQNk8ydWNw?=
 =?utf-8?B?RVp6emp3VmZRQmp2L0ZJMS8raFV5YkxBOXhjd25vVzYyRkxLcUlDVVcrWWpU?=
 =?utf-8?B?L1R1YStnTGJwZis2aFJxakpqQlE1WXBwZlFzQ21sM1FLNGFWamhsWDdzMERz?=
 =?utf-8?B?L0NreFZEazNodW1ZQW0remRQYmVweVJJYjczbTloR1pPbUtSeFVKOHpHUlhQ?=
 =?utf-8?B?TFIwd1JkbVBsUEhmaVRzU3dCVnJaaDc2a1dUaVN3dGRzM2t4MmgxcDAyNnZw?=
 =?utf-8?B?b1g3ODdndVY0Y3o4QitDTVRTY1pMZVlLK0xOalVkTkdVVkc4WnM5Rjd3SDRR?=
 =?utf-8?B?OFdZS1hWK1hqbTNOR2VOemgrSFN4bXk5VVZqbHlKUnFqb3FDRkVBMURzRXNK?=
 =?utf-8?B?ZDVIWHR3bldTelZRei9aVnFMejFDbG95NzVET3dLdGxuMUNQSzRiclRqbGox?=
 =?utf-8?B?SXBQRnU0ay9ERW1SclFibjdZb0RUTFlnTkhWRXJJaTFQMDZNdFVyN2dyWm9H?=
 =?utf-8?B?ZDg4cVNzYWthRExiWDJtTWhHVzl5b0twT0IvWDNDWFFvQ1I4ZHZhS2tPVnpt?=
 =?utf-8?B?elJTdXhPTVRLNXk1OWNoU0JUdnUxT0lTNFZ6M0d0bml5Wno3K3I0bGd1dVcw?=
 =?utf-8?B?TzZzdi9UREhyZmd0aHg5ZE5Ea0hVclY1SnhaR1RHemljektad0V2a0o1blJv?=
 =?utf-8?B?TjJ5alVMSE9EL2lRbzR2VzVSQzJQcmZuQTVjNm1VN3NMeFNFc1R3dU5qd3pM?=
 =?utf-8?B?a3c2UHRnR0VXUGM1VlZWbVFuL0FmM3ZFTWFVR0lkRklVK3RSbWgrZ0I0WlBx?=
 =?utf-8?B?bnlSK2VoajZkbkE5Z010Y01RVXBFMlhyajYyamZyRkVFVUxheWMvN2lGbVZr?=
 =?utf-8?B?RkU1OEpyUjYrSWEvVkdnMVhBdnhWaWhic3NwcGMxUmlrRXdiZlkvN3FjNHIy?=
 =?utf-8?B?bjNzZ0lCZktIRFUxcHhZam8zUzFZM3hSM29mbnZ5dnNyNzJHSVduWkpqa0p6?=
 =?utf-8?B?NDl5RHhkZTYraEdaY1IxalAyVDh0MUUzNnBvdVVMMVpBc1pMb2N1RWpsaWZQ?=
 =?utf-8?B?NkJsbEJXODZTQlBVY0N0NDRPOGx5VHMyNkdReUJLdkVNWndDdFdUc2JZV3gv?=
 =?utf-8?B?YVk0d0h6dFBxWkZKZnVRZzR5VGplR3UxR1hUOGUxK3ozWk13VHpWK21wQWg1?=
 =?utf-8?B?cHVBUVF3N2VQbkgxNXV0K3psWGNEYnExU0VxSzBML3h1cElodnRvV2lzUmZI?=
 =?utf-8?B?SStnc2ZGL01wSlpCQUo5blNqZml3aHlFcVBEVWl2cDJldnpIMDF3bTNtK0kw?=
 =?utf-8?B?M1piUjFDUzl2TmRuYWRpTHVQSFp0Nmh5L1YwNXF4TVdqZTc4M3Z5TmpYL1dG?=
 =?utf-8?B?VkNyYUVGaVZVcGtjejV0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akpDcitoalpyWDdpd1JEMForbHVtdm5GZlp5ckt2TXNTcWdKRGc3TjlOakZy?=
 =?utf-8?B?ZVVHU3U0dXBxWjBkbDB4SU84WXlyYUZXc3hmZ2QyY2RHcUFNbXpLYXZtSENa?=
 =?utf-8?B?bS9MVlBzTis3QUp3MGFrYVlkMU5JYnhnTlhJNW5VaVBJaWlVOWF6akNVcXRt?=
 =?utf-8?B?TVRUbzh3aDBIeDBEdndJdDVQRlI2VE42SDF0OVZoUGprYkNtMThScmNiakJz?=
 =?utf-8?B?MWl6TkNNekp4SWpFZU1XUFYzUjIxNVg2bjUrc3FnYkZyVXExdFdKc1RUY3Zp?=
 =?utf-8?B?dlVWY3dkYWpDb21mWTYyY0tRRk1KcmV0c3ZSY3VXRUxOekdSV1lZNEl3b3Rl?=
 =?utf-8?B?cEtYQWNhcmZaRStWTDBjQ0h5MDZDdnpVcGozaHI0aUcvcVhEd1p3TXhSNUIx?=
 =?utf-8?B?bXplNHE0NGlsVFcwWWFkZG5EUGJ4TkpudkdDcFMvK2QreUllS2kyYWJlcG0r?=
 =?utf-8?B?WmI0ZDlXL3ZvMEFQamNJd2J6dHdTaURBbWEyNldNL0VYT0FzK1JKa3ROaGpr?=
 =?utf-8?B?U0t3Q2RTYTZIN004QjRVVFltQlBuY2d2ck16U2hMbkZLajdCVTRCOFdwZmN3?=
 =?utf-8?B?dysvWHozTGVOYkxWbkJnYzZPZ0FKVW95STdQUGROaGJhMnBiVzEvK0tjYjVC?=
 =?utf-8?B?Umo4MnNueDF2dFVTUmhVOG9raXFMTVVJckZuUEt3amM2Q0lHY2ZRcWhDN2wy?=
 =?utf-8?B?cGpyMXA0NzJPNGtSTzl5MzhnVlIvSXZKcHBZNFBJeHdrRTUvbm5ZRS9kZkFN?=
 =?utf-8?B?RnBZM2FzRU00U28yb2d5Q1dQbXJyeXBPN01CaEoreE93aG1sRlZZVktGVDlN?=
 =?utf-8?B?bjY0UUNMTEkrM09KbnBBQXlEeFhFd1dCNU85RWk4SE9iazkxaWM2czBhRGpT?=
 =?utf-8?B?NmJhSm9FK29RM3QwWXRZb0ozODY3WExRWlo4YTdCN2dOaEdTZEQrNXFJaTdL?=
 =?utf-8?B?Tkd4d0VEbFVubDk4TS9DbG1IRktsS1ozc3ZYWThpQU0xUkVuR2pENEU1NzVo?=
 =?utf-8?B?THhKZEFiRFE1djBnQ1F0N1pVQk5IZm9ybDlYYkhHcXpsblFDWVZEcjZRdDV3?=
 =?utf-8?B?SHBqSEczeTl4akRueThiK3h6eW5IU0ZIVk1wcGtMRjNScGtZeGN4bjg2cHJq?=
 =?utf-8?B?RnArTXJFYUJmcThlYmN6d1R5S1ozaWh2akgrSEYxaisrTk1rSEpMSzhlYkhx?=
 =?utf-8?B?Q3VnTGQzQmtpTDRkQkJJY1hXS0lNNVdPdzI1cTE0dGtqTVlMeTUySWUvWlE1?=
 =?utf-8?B?S3p2eDJhT3ZHdVVCd1VDQldrbkRYdXdsZ21xS1FjN1pmQjhZM1A0V3dSUWUx?=
 =?utf-8?B?YmMzTTlRYU5qSHRtcHFTVWhLZTZwS0VrMlp0emI1OFVzVHMrN0xCTHllL1Bu?=
 =?utf-8?B?cXo2YUZPd05kWm15OEpHeElJUzh3aStQL1ZSMUdJRG5xcWxSTWNrUlplRXhS?=
 =?utf-8?B?L25wSkdoMW1FTUE0TW9Fa096aTE5T3F6T1J4YUNlUnlQNlZ6eEVRTjNzMnk5?=
 =?utf-8?B?UGpreDFEem1URDVhdGlaL3A5ZGd6RWdqd1Y3ZkpXY29sa0V4UlgzbUdsak5a?=
 =?utf-8?B?aWtSUGJsYzc0RGN5WlozNlpqcjV1aDVDTTN5ODhzMW9CMUYyem0yNG9maHNS?=
 =?utf-8?B?K2d3VFh1UUZ4Q0tnQVdCbE44WFB5SnNKTFFCMjR4YUpxcWwzT1ZCUldMSGpU?=
 =?utf-8?B?eGI0UzZJUTFRYld3UHZwK2VpNi8xNHZiY2cvOTRsclIxWnBsWFFXWjlUTnBo?=
 =?utf-8?B?OGZYVWdCeGkwa3lVR3k2dEdPVk9JYXZDdkRXK3BybjhETFFrbGlhaXRWK29U?=
 =?utf-8?B?ZHJ5M2VlQkkwazA4czNuQW1mUUhJSDgyTnJCTHhkRGhIWkVNamhXRGlOZytI?=
 =?utf-8?B?L0lJS2lXWEZlcm5WZ0NERG5OQkVjNzQ5ODFBN0htV3gybTAzRnh2K1AyaVor?=
 =?utf-8?B?eFlQK3Y3UXBOTER4UVk3ZmU2QzZsZ1NnOEgycXA3NmNuV01tMUk1TmEyRDlL?=
 =?utf-8?B?WjU4MmFrMk13dmFHQ28xSFIwTGlPUWxzMGFPZitJeVREYzF2aURGYmJjSVBv?=
 =?utf-8?B?a3d6Q2EweFBYWWhuZXQ1MitCa0xkSlR6QmZDbmMvRk82YWcxOGJLMzlxUUx6?=
 =?utf-8?Q?Kp4SXFRyU/xFco3zkHzMl4MIw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89eb183-54b5-4f78-1a40-08dcc766f70c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:40:22.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDrHGQLreYfzOxhw1wuKo2euRb6i7RqeanfWjF0SGpk2tI+44IrRQOq8yhyOMOIUZBOk/tW0yVMTnwP9afGTIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3917

On 28.08.24 15:05, Mauro S. wrote:
> Hi,
> 
> I'm back after doing more tests also on real hardware.
> 
> Here is a summary:
> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto Dunfell
> (GCC 9.5.0)
> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai 3.2.4,
> built by isar in xenomai image (GCC 12.2.0)
> 
> I confirm that the problem shows only with my own kernel + rootfs, both
> on QEMU and on real hardware.
> Other combinations:
> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
> - xenomai-image kernel (and its initrd.img) + my rootfs
> - my kernel + xenomai-image rootfs
> don't show the problem, both on QEMU and on real hardware.
> 
> Furthermore, I compiled the xenomai-image kernel forcing the 5.4.255
> version and using my defconfig: the kernel became identical to mine,
> then I expected to see the problem using this kernel with my rootfs. But
> -surprise- the problem does NOT show.
> 
> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
> Then, could really the problem be triggered by the GCC compiler version
> used to build the kernel OR the rootfs?
> Actually, my kernel with the xenomai-image rootfs does not show the
> problem, then seems that the problem shows only when using GCC 9.5.0 on
> both sides.
> 
> Or is it a dormant bug that some versions of GCC hide?
> 

One option. Did you already try switching to a different, likely newer
toolchain while keeping the rest?

But it could also be that the compiler brings in some noise to a rather
narrow race window, widening it so that it becomes much more likely to
be hit.

> I can share with you my rootfs and my kernel and the QEMU startup args,
> or other things that could help you, and I'm open to suggestions about
> other tests to do.

Problem may be that we will have to be able to reproduce variations of
both in order to try out instrumentations.

I'm also still puzzled that it takes both your self-built kernel and
userland to trigger the issue. We only have similar but not identical
code for both when it comes to xnsync_fast_*. Hmm, maybe it is worth to
compare the disassembly of lib/cobalt/internal.o...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

