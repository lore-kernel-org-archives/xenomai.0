Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05738330F
	for <xenomai@lists.linux.dev>; Wed, 23 Sep 2026 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143433; cv=fail; b=rEhKa1iZaqIjkTcJ/vNlmIIxCbEzdWnxO3hb7upum3J7qrd8aQM6SBgY8bs1wxZ1nJDQwii7eoVreSGTLuPdxWQE05Bc2zWVrFq20wMaxKBuoF2g7HoMD2jpweMrAQ8L7q9mzZTt722i4loN+zt7Ee/7axMODnk22tRPIgYLwo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143433; c=relaxed/simple;
	bh=xJQKA1/YKu0pNVdYjQcD3Erd7Tv9wJuaGbtmy6uSljY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9x1H7jsdyktqLO6JnNnuWI8rpL2swd3dqH/M85+bfhcnLhLHfJA/suAaKLeWaZ4YtOsEF1vH4Qhwgro8mqvWnQowDQebID51ckS7dLQ2hyKvbe5M/NTDceZ/h/bT4Vrjw1F0N1cVVb6fH6H1ePMnmyVdh0UvyqzklqDMYOnojs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M7VhvIhk; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M7VhvIhk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVwud59xH1i8rgmPLMbmZPRMm0ST0eV7E0yVfF5mFR37V1RtWEBipS0N/Vv0FPN36biwFgm8j02hlnOQudM9iIoEmWlqX9LNfGBXP49qk77yQdyyxwDtNIPlyEg1A9bk9N6H7zsQ5xp9PSxRU0bFc1hOvMuZtVEuH7AbEoomF4kcE/eJkQCSu9Og7ok7QbJuvHVFfpa79HWPC+by5jxhyzXaYldTap3An5Hm7wTG9yF+bfWIfD3G9bDhEQyq3rm5WI6nI1pYkRQF2jyaPOtsHFNvCMOwdsMNpYwDKFTcOhVHhnGLYrkiLJoJorpdgZJZc8NjdLlkbHxOtq9xOTnMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTWh/MKhGE508VxtP0kkzlkmENESVplGtmPDCzKM7TU=;
 b=FG8FQ8IyrrZe8y927kdCTRFlwed/jq8wg4lE90tOumEkYbY5lvyo77OQ+qi6er26/G9gdjEF67AH3wzCb/8+CXw+wD5FdEZqKXU71JDieNniWMwaKFPCjaL43d7Xs1EAH80rYAp6VJ0QouVfyx5Qqpkecyc3rBoEjDWc05rApLdcppmrZ1gVjgezCqi5uTHRxiO66mlJ31F1OnTSn+cz0Z4mYCgkZIRmXYAxMECMxjugMBmRVcMFI1y/X30VDl9sORKQM2DYk8s4NgufdpBeWLhlX/bT4pgvWldi7qde06EN2vngmS+uiQAlZX6yWOKUdmnc6+i8Q/TUn/UUFNbskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTWh/MKhGE508VxtP0kkzlkmENESVplGtmPDCzKM7TU=;
 b=M7VhvIhkSU1lMsrgi7VSAPhZ+8ozYQ8wpRHjO9N5huJcL/ItT1W78RdO1ypjI7UZvF+N2YjWKVb1MAExiwoSuipR8cw03dG52khv/1E9oFoP3ICKTlyIWvxIjcNvBlepi03LRKmp1PQEAORcCEzohGO2KUrAVZYpgqWT0PZaJPw1qeIPps1bFsD+z1R7HtcJf5r8bag5OgymOlloZ1NY7yPCAn8NNSMbOpkIaYvFi7u2NMBw2ykCk2RUX+NY6rzQQ+Ne37gxJOFPNGkV0CWK33rXsfn0XvXVeYzA6qqk6dKwDeAKwS/xwH+fKVREkLKUtAkASWDG9g59NU8DxA+3aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 06:03:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 06:03:43 +0000
Message-ID: <00f73467-9ce0-44fb-b969-9861f415cc46@siemens.com>
Date: Wed, 23 Sep 2026 08:03:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Fix physical interrupt handling during
 vmentry/vexit
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 songjianwei@sinsegye.com.cn, Philippe Gerum <rpm@xenomai.org>
References: <20260920032219.1799313-1-liuyang@sinsegye.com.cn>
 <b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.27e5e5db.849f.4897.86af.4aed0afaa453@feishu.cn>
 <8f3e2103-29a1-405e-b664-f1f1af82c4c5@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5bb5075f.c6ee.417d.8f02.9923dc98b410@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5bb5075f.c6ee.417d.8f02.9923dc98b410@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 39887cb3-ecb1-4a08-e4e5-08df19386c06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|55112099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	eJ/DLSLVG9DxuXGZijSYeBqZsVVLjyz21XNrGaok00Cog6EXRN+ClCgW5TDSroguewCtfEjEqf8xMPoKPI7umgPQ1tJomPKwMubBrRTRhLkJRGqqLZ3qOnKbOqytxCltG/RZoq5XeKrYKJ9YYx0jkqzjEBORde0ZzXJUoJwNA7BZi3vThjg3LAQOaW67zxd+blttH5RQp9BhLV5OmvQGhspQsEhGA0OZW1Fr30gXZR34AnfeorZGpETj0LSj22k5+ze7aM3AFvPiWZL9btKU7EtuYiT7gdmh04Z1/HK3JKK4Li7VwyUifhqaoHUmxWH3IchC26hfpDjkyPj7DeCqVi5Da4RdrxixypFYaZaX2fGS+Ha72Tg2+8LhF7sDMIbyXH1qGJbVUb7dmPTVHY26JVjTw6etq8Nh8QS5hB1DyTH7Dyeg3MuENM7xGjxuxpBFkOochkfxtzKqi6PYMj+5pzy+Lx0VyKUOScauKYL7syq959PxuLHmM3tECSWUVUbOG0VXyX/sA81zvILovpTZIgi1AWbp85z3d3L7n4A2LrupGpiXmgWQLykZwA9tSn6zgd9zq3Kv3wTEHfIai9H8jP4HtjUAXmoZzPnLNcORLnB0ovngdU+YRjbTuAy5FnxuLMD7SH1nBRdmWxSSplDG/OcQqM6ntuOGZexT1SIEikg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(55112099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnI3RlBSeklGWUJSZktTaWpmTWt0cnhoNFMyV1ArNWVzUlExTkl1OTlWK3hH?=
 =?utf-8?B?TVRwR2daNFVqNERvYlFBRmJ1MVVlL0w0OGRIS0JEL3ZTR2NiSXRVNjNMVTh0?=
 =?utf-8?B?Mlk3QlhOZVJlUGtpWDk4UWxjVVVRTzFsazRVdHUyNzk0dStmZFV2R0s1M3kx?=
 =?utf-8?B?bmRSS0xDTGxLb0tQNjR6Z1BqWnBjOGRrenBmMmIrK3NqZEVUT0JuUEJkUGhV?=
 =?utf-8?B?SUN2YmdQMGhLZ0JVUXQrdWVMS2NtR0gyZE95TW1vb2YrV3Y0cjZLL2tBclZV?=
 =?utf-8?B?Q01Sc1VEa1RybFd6UkxPWGh5L1RYczV0S3NCZHBhdndPSWlIMEFyaHlCdGhK?=
 =?utf-8?B?UUg5VnhDaTl2MFdZUUJacVZ3eElKL2xlQ3lqYUlZQzE3NjNtcUFLZEwzT29r?=
 =?utf-8?B?dkZnRjA3YkRZSDlMSGpKNGZVKy9aeDZPMGFJcGNYVTYzemZ4TEhYQlA2SGU3?=
 =?utf-8?B?MTUrYTB4dWsvNDNKRTVGNEIyTUErRUc0TVpRczg2d3RVMFdiejJHc3MyUll6?=
 =?utf-8?B?SHpMSEZOK0UyWWNoTUoxWHBvRUtrUG9FME5ySC9NU253R3p5bU45ZCs2RkR6?=
 =?utf-8?B?cWVOZmdpWmw4WWdOWXRWMmU0NU83OFZ4ekxJWXdhaVpIbXA4dGdwYmkxcWMv?=
 =?utf-8?B?cVNzRHpQeFhBSWwwd216M3JqTFhnOENlZVVOcW82UHdibDVITEpKM0cvbStu?=
 =?utf-8?B?TUVsOTlNRzd3aUhwL2tEbDBPcFJPWHhseUswSHJ3YWowKzNFSjhqWFpJMHI5?=
 =?utf-8?B?YWRicVU0QnZRQ2grUWE0eWV0S0ZwSis5MFJkWE96Q2F6TkNQYkZpNFUxUnpm?=
 =?utf-8?B?cnA1cExPQVBibGtHem93SG9RSkV2L3Z2T2EyUldKU00yUXRrZFM4WlNKTzR6?=
 =?utf-8?B?YzJMczVPcTkxV09YaG1TUHVxWnFxcFQwaytJc2w0QmJrUWcwNTNKcTZySVhr?=
 =?utf-8?B?MXpSUWtGWVhRS25WUWEzbTJvZVNyN1dack5aNkk3OUxSREhrOXMwaHU5czhz?=
 =?utf-8?B?NGRjanJ0eC9mNHBZczU1UlZ1QmMzSmFRbWRwT3JjOGVUWDhzaFU4RUM1eDB6?=
 =?utf-8?B?WklzSzBPRFcwNjMzOXVjSkMvbWtsSjh6OVdZNk9LNGJLTzVCSW94TG1UTmRT?=
 =?utf-8?B?N0dqTWEybi9RVUtSanZoOFpOSGxrcHp6T3IyRm1rRStyNFhhOEJ1NHFLVDNr?=
 =?utf-8?B?UUtMQ3B3RjE5MDNJMk1sMFIwNkJBMklUb2x0czFlZmdKcSs1VkRzdnBDcEFZ?=
 =?utf-8?B?TUdUV3FYTE5TZWFsOVAvNkE2ek9EN1ZIRGp1UHVxeThlV3lScVJIYjIweDNk?=
 =?utf-8?B?MnFycW5xVlArRGIzbjFZbkt0SVdUd3dOSlllYmVNalVKcEovTnRhU3JlRTkx?=
 =?utf-8?B?eXFIa0Y1TVQva29tMDBKRXBWTCtQQUh2WFI0a25qa1NjYk93Yko5RzZ3ZGJr?=
 =?utf-8?B?MW94aVgzL3NZd2lteGZZaGZlTWxBZ2x5ckpTR3lKcmtzVEZxRnNoQzFGTXlQ?=
 =?utf-8?B?dXc0aGZhM0hoNFh6V1g1WmI2bDhzempoNERDczhXV2Y3Q015cHQ4NEs5Skhi?=
 =?utf-8?B?Z0NsUU1tdVd4aVZwMjZwRTFGMk5FZTVJR1NlVGUrWUZKWjViZXIrTTZud3dz?=
 =?utf-8?B?RmFrMGNzcHd4VVlScm1qd1FWTG1NLzFUNWh5RS8zRXFCcjNBT3JucVU0UXMx?=
 =?utf-8?B?OEp2bldTTEZsVEdldFZqY3dnTGUrV2E4aXQzZFdwS2hlVEcvWUtvaXBsdVhs?=
 =?utf-8?B?S0srcnY5OS82SEsvaGJuSmFZVWVNRGV2NnloVlhpVXlrVXd3SU5pWHJ4YjIy?=
 =?utf-8?B?Nk9KWCtKUzd4OEM1VWt4YWVyUzBWSzNTQzJaMWxMU2VFaUpaSnYrdDEwWDBY?=
 =?utf-8?B?TUs2NnUxQnRpN0tabUF2NjRiOWtnWHdwaTA0K280c2RyS3RzdTRMTDArYjhS?=
 =?utf-8?B?dEJKR05kY01Xa2tpNzF5N3lOYjZPYzh5Ly9ONlhadE9GcFQyVnRLYmJMc1JP?=
 =?utf-8?B?NjVPLzhkRmVmclVMeFNMSnpGWEdTOXRUWWN3ZXhYdm9JSzlvRm1Lc21GRFV0?=
 =?utf-8?B?Mm9NN0hOTGxyN2h6OEFTVkJPTkcvU3k0ME90eEJ0eVNlR2pUb29rNnVuTVNL?=
 =?utf-8?B?NzE2L2FERjdUNjdjcDNmYjRTdXFSYytCOFVnRUN6VjJwWVpRbWhzdHpyLzVY?=
 =?utf-8?B?VWNTalFlSkQ1WlcySkJEbVVkWTEzMmYwRlNLTG9RUlJOMStBZnhpbzcxRGUr?=
 =?utf-8?B?Yk5jT3RBWVhjN1RlUVN2MlVKRi9hZlc3ZGxzNEl6c3lsN1JxUjZZandXUjJT?=
 =?utf-8?B?cXdFNi9QRDRTVjhreEpRSVMzOHRsQnAvYjN1WmVENERpdDB0a2RsQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39887cb3-ecb1-4a08-e4e5-08df19386c06
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 06:03:43.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYR+KQg+Y/OL4zboNfnvO4QQWPtzA5nHT3hZ74Zij2j26B2PC+DZXEwK88VduLmgcQFY18blb6N7Qirl4puyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9098

On 23.09.26 07:52, 刘杨 wrote:
> Hi Florian, Jan,
> 
> Thank you for your feedback and for reviewing the patch. I would like to clarify my test setup, as I may have given a wrong impression earlier.
> 
> Regarding stress testing: I did not run any stress or IO workload on either the host or the guest. The issue reproduces simply by booting the system 
> and starting a virtual machine. About one minute after the VM starts, the whole system hangs. After applying the patch, everything works normally. 
> I tested this on AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.
> 
> More importantly, we have been using linux-dovetail + AMD KVM on a 5.15 kernel with Xenomai 3.2.3 for a long time without any such problem. 
> The hang only appeared after we upgraded to the 6.12 kernel.
> 

And that is exactly why we need test cases so that it does not take you
to update to 7.4 one day and find the next regression only late.
Anything which runs as part of CI can catch things already when we are
porting to the next kernel version.

Jan

> Best regards,
> liuyang
> 
>> From: "Jan Kiszka"<jan.kiszka@siemens.com>
>> Date:  Wed, Sep 23, 2026, 13:34
>> Subject:  Re: [PATCH] KVM: SVM: Fix physical interrupt handling during vmentry/vexit
>> To: "刘杨"<liuyang@sinsegye.com.cn>, "Florian Bezdeka"<florian.bezdeka@siemens.com>
>> Cc: <xenomai@lists.linux.dev>, <songjianwei@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
>> On 23.09.26 04:08, 刘杨 wrote:
>>> Thank you for your reply. My test setup is as follows: 
>>> We use KVM+QEMU on an AMD platform, with CPU passthrough and AMD integrated GPU passthrough. 
>>> The codebase is linux-dovetail 6.12.90 + Xenomai 3.3.2. The issue I encountered was that about one minute
>>>  after the virtual machine started, the entire system would hang. After I tried applying the above patch, 
>>> everything is running normally now. I'm not sure if there are other places that also need to be modified.
>>>  I have tested on both AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.
>>> You can use an AMD platform and start any virtual machine on the latest linux-dovetail kernel.
>>>  
>>  
>> ...or fully emulate SVM in QEMU - much slower but possibly also exposing
>> remaining races (if any) differently.
>>  
>> In any case and I as already pointed out the last time KVM came up: We
>> need KVM workload aside RT in our regular test pipeline. Could be
>> combined with switchtest or at least become part of the background load
>> that we run during latency tests. And if that requires having a physical
>> AMD machine in test rack, then we need to add one. But maybe QEMU is
>> sufficient for that as well.
>>  
>>> Thanks.
>>>> From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
>>>> Date:  Tue, Sep 22, 2026, 21:15
>>>> Subject:  Re: [PATCH] KVM: SVM: Fix physical interrupt handling during vmentry/vexit
>>>> To: "liuyang"<liuyang@sinsegye.com.cn>, <xenomai@lists.linux.dev>
>>>> Cc: <songjianwei@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
>>>> Hi,
>>>>  
>>>> first of all: 
>>>> Thanks for reporting that issue. Highly appreciated. 
>>>> Some comments below.
>>>>  
>>>> [ Cc: +Philippe ]
>>>>  
>>>> On Sun, 2026-09-20 at 11:22 +0800, liuyang wrote:
>>>>> commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable} in
>>>>> svm_vcpu_enter_exit") replaced the explicit cli/sti around VMRUN with
>>>>> raw_local_irq_disable()/raw_local_irq_enable().
>>>>  
>>>> The translation into the dovetail world:
>>>> commit b2a37d35 removed updating the hardware interrupt state.
>>>>  
>>>> The code below now touches both states, the hardware + virtual IRQ mask.
>>>> That is not an 1:1 replacement.
>>>>  
>>>>>  
>>>>> As a result, the pipeline may still believe that physical interrupts are enabled
>>>>> while they are actually masked. If a physical interrupt is taken during the
>>>>> VMRUN/VMEXIT window, the out-of-band stage can observe an inconsistent
>>>>> interrupt state, leading to a stuck vCPU.
>>>>>  
>>>>> Restore the explicit sti/cli around VMRUN so that the Dovetail pipeline stays
>>>>> consistent across the guest entry/exit path.
>>>>>  
>>>>> Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_full in svm_vcpu_enter_exit")
>>>>  
>>>> The Fixes part is not really correct. We never touched / supported the
>>>> AMD / SVM part of KVM on dovetail.
>>>>  
>>>> Looking at the Intel / VMX part (see commit 
>>>> f6885fab3c2b ("KVM: x86: dovetail: enable coexistence with out-of-band
>>>> scheduling") in 7.2-dovetail-rebase, I assume there is more work to do.
>>>>  
>>>> How did you test that? Did you (IO) stress the host as well as the
>>>> guest?
>>>>  
>>>> Seems I have no AMD system at hand ATM, so unclear how I could test
>>>> that.
>>>>  
>>>>  
>>>>> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
>>>>> ---
>>>>>  arch/x86/kvm/svm/svm.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>  
>>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>>>> index e02a38da5..0e19d42b7 100644
>>>>> --- a/arch/x86/kvm/svm/svm.c
>>>>> +++ b/arch/x86/kvm/svm/svm.c
>>>>> @@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
>>>>>           * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
>>>>>           * this path, so IRQs aren't actually unmasked while running host code.
>>>>>           */
>>>>> -        raw_local_irq_enable();
>>>>> +        local_irq_enable_full();
>>>>>  
>>>>  
>>>> local_irq_enable_full() enables both, the hardware as well as the
>>>> virtual IRQs. The virtual part of that should be fine, I'm unsure if we
>>>> should (unconditionally) touch the hardware state.
>>>>  
>>  
>> This should be fine, look at the comment of the original code above.
>>  
>> I vaguely recall that guest entry has another IRQ mask that protects the
>> atomic section between the host switching certain bits to the guest
>> state and the actual guest entry instruction that switches the rest,
>> sets the guests virtual IRQ mask, and restores that GIF to 1 so that the
>> host will receive IRQs targeting itself (via a guest exit).
>>  
>> Jan
>>  
>>>>>          amd_clear_divider();
>>>>>  
>>>>> @@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
>>>>>          else
>>>>>                  __svm_vcpu_run(svm, spec_ctrl_intercepted);
>>>>>  
>>>>> -        raw_local_irq_disable();
>>>>> +        local_irq_disable_full();
>>>>>  
>>>>>          guest_state_exit_irqoff();
>>>>>  }
>>>>> -- 
>>>>> 2.34.1
>>>>  
>>>> Best regards,
>>>> Florian
>>>>  
>>>> -- 
>>>> Siemens AG, Foundational Technologies
>>>> Linux Expert Center
>>>>  
>>>  
>>  
>>  
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
