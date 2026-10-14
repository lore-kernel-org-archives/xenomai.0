Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251E92EDD78
	for <xenomai@lists.linux.dev>; Wed, 14 Oct 2026 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954642; cv=fail; b=J5bUNDSor9nbXofo3Mkm8N6IULeJcS3uns7z/3SHlo4TonTVgOi2yjVxFxKpT/3cRMrZ4na19dmua9K4V9hxMLt87BYuC89SrZ/YbUSAnKInRzjWce40nJ6KOBAYVBtk9XLEHaIQCyLp0ixg50lkhKG0wvdm1KwbisSQz/5z5Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954642; c=relaxed/simple;
	bh=p6Y550kNoT/zuUG2aG819e8HFehUOYlGlPoC3J8dLyU=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=OPr/nD3QBleZM9UPGRHP/E2QEUsMwxmrxD/6ds5cH94Yb0fDCyBzJA1pglheUl8uoErNLsxgBMVpHgNW5i3N2eoiWK7FXuYIOu/k0qZMlnB71iDFutv8XcPBiPb6SGvrUvAcfF9Zg+8E5UB2Vs5Tzoa/csNSgN6Zv4Nlme3nk54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=etSToEkb; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="etSToEkb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDjEqPtFxD38T5qADJq2vOdSYAmB21pId3kzKFdtGaN3mxCVQPFxpwB7hxYzVRfnLy3y/fOhxyxX43fwjIDVqAaK0Asr89QyIF3dayX7BWqTa0v5kuGt3vaZquDJTIniaTRQvnvsvuY352LhilaJjEhHZBhQBOd187ks9wUsejQXXqgh+w2aPimIBh5W+1nPY02cB5EbVElxWWtYmx92NvxybOZjoB/BKyXp0QIZSWSp3dQ3mucOxXtBkZfnTxPiQYCo9Y7p7MnE2ZLnrtFTnNL0k1mTgo01CbxIZUit+G/wFwvPJgJTK+68ROYwCAnAki/GuDkjdvY3K0L8yo9hwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiYSZcZh8qFuSjE+Ku5p5sotsrBv+2ovM2SqewaSpTA=;
 b=XOnfP4N4INPg/tQ5lg89BzI8Lylat7nrd61E92QyOhaiRDZS8lked/aeUT3RTfYZqanc8KWzD1iAwi6a6q5fna4I5E1SfpTqSfAxaKcHOp4KrvIVyxdzrMWM7wxHUvBf2BmjeZA/46erwtBpuo66aqbfFmzsLK4OQzhdgdAUA6VyQofkrH9SSGryD6oV+kPr0dCVgC1KWvOyKysbqSpV4dWEVAxzlDHLXYRJ8D1jRKp+Stdyajs5J1Hv5ToyIC79ipjzvbUWGeQ6uwxdAjD81nUGd6cY7YemDrIb1gUAwBkHBBI6PXRzLz0c6FxZNigvdXOhbMG+UphRJ5es0g5KcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiYSZcZh8qFuSjE+Ku5p5sotsrBv+2ovM2SqewaSpTA=;
 b=etSToEkbNJxdfnUMsrHXbW85zQrMvR/FebMQyCC8lKx4fxwb+sd3pk38Q5RfnCs40ooidrQGxXvfpbceVpSWBz27OI0AW/Do12mbXeCpGkv+u4BRXCnMnH9pRkyiVOjBnXWFrmEN25s6/lIZcvm9ABr9pNKKY36Jzs7znuEk+Tjyc+2Shia+ZHKmEqAUo0CqoVFXu812VRsbW7QNTDfftqVEP2JWKOobcByspKWEPnLgENiD7hAMUaaOIWw9+OzjP3vP+jvCLA8X5fS14pI7HUWobfXCPQ/eP4Ob/YhimCeHyVdLN3yveM373GPs1K8/CqPKXJTATek0iczZlu4ZMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by MI9PR10MB427317.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 05:10:37 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 05:10:37 +0000
Message-ID: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
Date: Wed, 14 Oct 2026 07:10:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "guangfeng.wang" <guang_feng_wang@163.com>
Subject: Call today
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|MI9PR10MB427317:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5449b4-8bc5-4528-cc51-08df29b17be6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|55112099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cVHTTyzaQZY1zmRUyh1rV42edA5t/3V970W+A/6WUx9ZiQag9kyv+3JurXA7qIRa+SSmeeL78FaIPg2a4MV28TR/hkkIkV+r9cvBscP3T12gIzh4NOIvr4ZmcDxEUlK9E3zDC7RCZNwXQffoP0k7U5yyvHbtILREslTQNsgbjSxasHaTaexEMJ4VY/qgtGz4gZPZ+lQebElBYnC91hzPOGpkHyYEL2UmfV1ETm3kWjnBvrd1Xr6TLTydwpS8JCgdLnLC3qIXFfgHpHvgtzsdCEfgC/IQPnMRMRmxW1FljJ3sLF7Y+iVP9LMj7HX0e0CzU5eTrVNyvw41sc9EaYhOdkEhc5XxRRvK3zCGkrnbKbEhgbwlZnb+OEFul9TfUOMV0qaIZoQ9VeBNMkpvRt88FtjttWPkkDlH1Ij4MEsP1+5Zrn7tb39A6nBVdCIlr8ISC7yRCc2hgq9yd6PD5SSNy9qagqbXC5lYvmwfUVdXUX/cVT8BQTm/YeCbEs22RCzUGfEj0Ie97qh3F9+rzB6tU6jB0xvyydPs5bvCUot4xoxsk0wx5PKH4zq1u2F8AUSOUKbmCoFwRbShkPBxI7RCc/w/pkpzcArZJA7iGPgM7yeZMS7wQYzHe99O47ZirK28dQTkQP424inyaoCmDPbEHJZ0cKZFQfEwNgJoJrz0i7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(55112099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWFycFBIOVV0OEhMMzJ4SmRGQ2sycjFFWXpIUEQxNTdVUEppYUNPejRwelE3?=
 =?utf-8?B?a1FmRHhDbUpjZGFDOW1FNGRxN2hjN3lZNm1mdlJua2xKVGRwTWNjVC9EN1lZ?=
 =?utf-8?B?K28rOVZ3ZVd3V2RBcHVSQThpeTJmMUdTRlp2YTFSbkVuQzY0NmZxSFFaSXc0?=
 =?utf-8?B?WEhFb29PdVV3bU43bzZjOVhqeVpyeFVBa0oxWVRTV2VVTlRHZ1hTWVNlMHZO?=
 =?utf-8?B?TjVyUDVnNlZyOHhlbVVQRDNyTVdBNzRYZjJEOVVqQlNvSjRuRlBIQ25LeUxi?=
 =?utf-8?B?VFk1SWo0ckg2cExFRXdvSDFOblVZY0NnWmVSR01xbkwrQ2Y5M2xRYStVdy9w?=
 =?utf-8?B?ZnpLR3hXYjc4Ynl5RkRTcGh1TzFNVS9mNWFscHlidWIxMm9WTytBZ0MvV2hT?=
 =?utf-8?B?TC9iOHpScm00a0xCYlV5ZEIyZmxKc204Z2xVTEZOQjQwdUZ1LzJhdWZYNkE4?=
 =?utf-8?B?R2JLUGNzcFYraW12YmNKNVM0QUJwSThybWowaXY2eWJwQzdyNFZFVm1LV0Nn?=
 =?utf-8?B?YWkwV2JwRUMvc3lSMm1nRUhwMmJaR1VlcnBkS0JWcFdzTDRNSXh2OWhZUngw?=
 =?utf-8?B?bXJuSncxd2F3cGdRV2xrUmRscnBRNFdMQlFWV2VrMlJ0SkdhbnB3RSt4OVYw?=
 =?utf-8?B?MHhidTBLWVRvUHhJWERPZnhJT25YbVFxN0xtMFBZb1JVUGpMRlBPRVNESDJ4?=
 =?utf-8?B?cVNtTzNRaEFidDhISEN6bnRRa2FwcEFGMnE1aWdqUUtVZXQyQldZUkJkbFJS?=
 =?utf-8?B?d0tGallKa2NRVCtJTU1FelU5NmVZMWZURjRoMVdCT1BLNDNSWDRDRlFSakJB?=
 =?utf-8?B?cnRJMmdhWHZFRFdPYTRLNzhaZThyd1J6T0ZvVVl6QUZUMzFWTzlLdG5TRTR0?=
 =?utf-8?B?R0ZqaFk3UjZPYnU5ckdTYSt4Q01sTXV2TW9vUkdHYlBQNzdrMTd6SnVkMWtY?=
 =?utf-8?B?UTRqQjlkNlNWWXFsSUY4U1FWeFEzWlB5NGJiQ3MyODh0SFhrWjVkNmRPdWpH?=
 =?utf-8?B?bTFiaURkenkrVzRKWHpDcndsNy9ZS0t0TVZ0V3RqZ1Y1VFB6RUVkcmJlMjd3?=
 =?utf-8?B?SVljUFJsZXZVenFSRFVnRHRiUXFVZy9zYU5lcW5jTW0yK2UvYnpjc3A0Vmlh?=
 =?utf-8?B?ajBWVzZOTjR0dEtQc0NkVzZITDZYVkNtZDRaMU9wbFFoMDE3WjNZUC80M0tL?=
 =?utf-8?B?S25jSEFtNk5QVFRRSEhiQk11UHlwb3FRU0o3aTNTd2dnYkRZMFFCZk8vRGV0?=
 =?utf-8?B?WWVQejdzSWY5NE8zQWhoYWJKQXVSQ1Jmd0VzcnlidmNaMW5pQTh1bkRSNjFS?=
 =?utf-8?B?YkI0SkZUSHNYNXJVUzBrbEdXVHBCeWJ1NnhFZWJEVGJTcFFjN09QTlVoZFE2?=
 =?utf-8?B?ajM4RWxBUGxZU3FJYUh3MTlHQkxRaTFqc0xCRVhwYU9Vd0JvY1l4SFU2ZlpV?=
 =?utf-8?B?eEVLRStZTTZMZDErQzJqQTRTYXRYV1JETk5HTllLNE5wVGJuYVFzSDc2Rk9i?=
 =?utf-8?B?WmFwbFZEMjg5QllSY21ySGZ4TGgxZFpLSDdyZnQ0OVZoZWc0blpYWlZYL2JX?=
 =?utf-8?B?c2ZXeXZ4MlEwTCtNRmRIYmc5RElLMWN3OWxQVDQxY1AyczVMSEpuMXgzcG5j?=
 =?utf-8?B?V3hXdnVYVTRKQWUvdUdoQW5kS3duQm5mQVBpeW1CNFRtTmlVOTJPN2k2eWY2?=
 =?utf-8?B?SURnWlhYVmFVZmRCUk5GRnNLN0dabEpNVkE1VGlpZTFhcTRTV1hUU3NQOWVK?=
 =?utf-8?B?cGE1R1VWVVA2VUVrckhpbDVjenRUNUFoTXlhWkFZMEgxUStwN1V1bmd3bGNs?=
 =?utf-8?B?dTBBYVFPVWt6ckR3WXJBaTFRcTU2aXVHTGlGVWNrejhMd1AwQW0vKy9NMUVu?=
 =?utf-8?B?ekgzSU5kR0x4SFZNSWRFUzdHR1RVNFpFQ3FVR0R4Z21PMlNMdGZTMlNtK0hL?=
 =?utf-8?B?TjBpYU1TcDBvYnJ1UmVWZnpwcngvdEZOQXlYMmgwZUpDWnp2bHkrS2VJNVA2?=
 =?utf-8?B?V3A5blFHYmVnTTQxTk9UeEZaL1hmMHdBOWp2RGExSHpRZXphMnh3YmpvbnF5?=
 =?utf-8?B?VXpONXZWVkloeDg4VHVEZHhiUnNiUlVtSXJHMUJMYmFGLzJISm1Vc09SNElx?=
 =?utf-8?B?Q0sxL2lvUTM1QUt4UXgwWXVjR280YzhoUDh3WUI4a05IaEd2cVFkS1Q3QzBa?=
 =?utf-8?B?dENIekNaaFdJSU4xVkpiQmE2WHIxbzI5WkxEM1hRV3luelNUMTFOMFJ0Q1FR?=
 =?utf-8?B?RkFMUjM5TUtheHk0N3h4N3VsdzByRm4rWDdRZnJBdHpoUmtyeURFQUdwa3lG?=
 =?utf-8?B?dkh1SXMrQ0l1V3hqb1pZNEF5U3lQNUtuOXM4NjB4d0NseXlDOFlnUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5449b4-8bc5-4528-cc51-08df29b17be6
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:10:37.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97qEfaIoy+uw9mdOErQOSwUY19/CexdMmYe9ib/JHlUX3GiGSmpNw8AY/VkphtcGKh+mTAfIFDG4ilzEmhkppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB427317

Hi all,

sorry all, I won't make it again today for our regular call. If there
are topics, please drop a note if someone would still like to hold the call.

I will also have troubles to arrange the call in two weeks due to
traveling far East. But there is an in-person meetup in preparation if
you happen to be in Beijing on the 28th - details will follow.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

