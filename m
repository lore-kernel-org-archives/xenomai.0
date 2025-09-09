Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48C235074
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399244; cv=fail; b=qr3wTVKlIyX9KJumzfUgO5SsHvEpTw4VTZMrQiDXYZ6p96S0B4h6zY4izr/WvHGVV3cfJDtnLQXRhJKD4v9ooe3NLRYQunbvNxUvSDT2oM0SgfPEUkHRW/5xOKyU6OkNQ3qCv0YHMvhAjdnvxbCtlyDi8iJvqBSr7DPMNIjP3iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399244; c=relaxed/simple;
	bh=cpHxkwOM12kLzic5vQoEhJ7XbWN6+pnruSSg3CTvoqk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EbZs10kGny1NKNgvvis3oqjRVc43yARpWJ87PnJ/1u8iywsNszsN6vnPAUUy5A4LKrRk5hlbUiKXyAXFP0aV9ap5Y849nLfznA7Te6C+ba3p9Ro0USWU8MNw0RAvb68MR/NJmxYsCBDZH2keO6G29GPtqRzK6FUi1sNHQHQQnGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nPGcVKc1; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nPGcVKc1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh4WYZ+aAvbhvXqeuAuDDizhXxJdNpzuFCK+sH6bU7ZXFbPUabJIeejCf3so9eZcP7QqZ1qFimCXVjc1U+NdEqwwTZhLptUAaUoo/1AZBHzF1CF6hMy4+IyZ7Q/KAJtvjsE1qDtkTeYbSYfQvwaBgkIcfvBhCBHiHXqnxFBOUcjrUmNWe+v0yXhY9LrRd/CQEH1I7M6IB5++Y0NIpjAsUAIMvGZNK5QWE5n8Onr4rY3oox6s8V+dV9xQ/qMHn//I2ToZFryY8sw1TRWHLqjajBjqhBTwcOjn7qP7/59eMykHDXAxH3Dt8AB6x8F6iDdkaWkrjeS0qbjs5I8/dfz2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyCqXBaJc1u09iSh9H2gpBtsCNT0l9E0uhZ0pisAZQM=;
 b=mgrzuAy7B4+TdtN69MBKuYUF+6JnN+7sL2IVOmY+g7guRmrp9XF5GZZJgXPy4QZcA2wXknO9Fs1cIhlnIx1OGQCILRzmoiCTwmJi8midLrM8tscvzRY0xBfX/hStV49Rq9G25U4jMyRcm9hRUl7/tf2JGOnLkyWFEGD6eSvibkUwFt6Mj/+aVgG5eqrVl0qyuc8AjgKIWUEm1tBQJ2mvoQ+rAZHgJvAYQAmztPN+ROTtPOR4DwrFRg69lQ56N1bPGoGy9IZLVsZFyk75yDiMd21JDaYlEMLdGrGOj1IYq83GwLsWdQ/zrHt6q8/m/es5ldfWKNuArgvBW4tXd/zhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyCqXBaJc1u09iSh9H2gpBtsCNT0l9E0uhZ0pisAZQM=;
 b=nPGcVKc18SUtMqAavLKNhVqpsmwnQqbOTZoLT6/fxHa/8DS5sKEsrPcI1UsGSLIVt3aowcfjPSAXlKe8dEu3c8S/l7vqoBYltMqwLFV2/liCdPKKVcwPLigC+kWo8tQy/lDtmUEhysnuzEHmCIcyHUfWNnGNq05MP5kHDvRT3CnAzWs7QxkBoapLFqg1QAODGAtKUBy+A1vOCPHbZSsUW0q1y+JLvBZX3sjczDLHKUFF71jJDoaqbU01bgTqBnkyS0XtKdGnqHit+mOkHmJYnpETvCw+i3Q/kHzdjtm10rwWX0CufYfF4rgsVojCcIEkbgi0LZPfyNZ5mDkxzuNOeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB8010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:27:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:27:15 +0000
Message-ID: <a0024071-0928-4792-890c-3177e94c2e37@siemens.com>
Date: Tue, 9 Sep 2025 08:27:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci: Remove sstate-analyze step from CI
 pipeline
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20250908180921.518004-1-tobias.schaffner@siemens.com>
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
In-Reply-To: <20250908180921.518004-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: eae5ef2e-9d97-4f4c-42ee-08ddef69eb1f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUZlUGQxZnRkUE5xTHlFeDdzbEFWeWUwZmk4Sld3SndSQWlWNDBmYjYxS2V3?=
 =?utf-8?B?VjlWVFRpVnNuTkpRQkNIZ0pKd3ZBNGU0TGFUQVF4dld5NGhidDhnRWJ2R09B?=
 =?utf-8?B?TWtET29tdWNaclRvaTF5ZmJuWm44b0tiNTBKYWN0UFRXLzhGTWlDODN1NW5G?=
 =?utf-8?B?NFJNbFZBTjNnYUZobWVyWVFIaExwYzRpM2tUdDZZZ1ZCQTV5enRHeFI0VEJk?=
 =?utf-8?B?YmxWenpqQThGeGFJVFlaUXo2cDZPa1RWazBNQmxTVER5em52cTArbkt0b1g2?=
 =?utf-8?B?ZG9nSWNXbERzak1KL1BwNVA2SVQvR2JSRDhzdGs0L0VyMDBkWE1qWVVVOSs2?=
 =?utf-8?B?K3RQOEhqTlBhbldGNDI0UTVFVTFubTdmbGdwcUFySW5tQUFzVnY5blN2QjVn?=
 =?utf-8?B?SGpJdHNNYWtDaGkvQ2V6Vlh0dlRTL3MyRm9jRHFKTzlXM3lJSkFrL1hBK2lx?=
 =?utf-8?B?WEJieXdORVFkckVidk5VZnJXcXRqV0NPRWRVa284WEpjYlJVUU4vL0JLb2tt?=
 =?utf-8?B?MkdPZjBob3p6RC9pTE9JSXJOVEl0MlJwOWVuVmQ0UEdzL0crbml6QmVYRlIx?=
 =?utf-8?B?bmwvMzZ3TnZrbnFUNGgySGhUZFp5aXRHd1FpdHF1NlhuajlYRUpEcmxTQXdo?=
 =?utf-8?B?T2kzMmFkL281VXVGU2h0ZjJRV1kxZk5ZbWZsQzNMV3VvRktrVkFnR1hPaWx2?=
 =?utf-8?B?NWoxdm9RMUludHdUTW9Udk5ZYWNrM01RNFBBb3l2NlVtRnNzdU1qcXdPMnJp?=
 =?utf-8?B?dE1ZcUtXODlxbFNzMkpPWXFGb0U0TEE1MWRacjJYVXhybFZ3STBlRXlQNE1V?=
 =?utf-8?B?bWVzRzdXT2c5SnIwNHhGaXB5NE1Bc0dudVUrU2lpVUxrZ1QwRk5lNkhsWWZ6?=
 =?utf-8?B?bzQ4Tm14NzlkZHA3R3B6c29yUGJiazgra3pvdlJhUHMwa3VHZlRkbjJ6emdR?=
 =?utf-8?B?Q3hyU1FpM0ZNUDNieDd2Qm1oVjNpUjAzcHRDaWxWSjlhS09nTVNwdWQ5MnJ5?=
 =?utf-8?B?NTRQN3ZkSWtiazYzWnM3SHNpaVlIUmsxTlFVV29aZXF6aW44N0Z3RGNMMWZK?=
 =?utf-8?B?d2huQUh5cDBEazFoMzVKUjZ3MllZTnpmbit5aFY4THUxWGhLR3JFZ0pqTDRl?=
 =?utf-8?B?Z2diQ3YzNnZZOEFWMDlqRW5mR1NJam1yN21IMEpua09PYmtvMExJTko4Y1Vm?=
 =?utf-8?B?eHh1dGRCQXNJY25GRk85M2t6VTN3TkU2VHI0NUxZWmlLc0NRTHZuSkhHWjVJ?=
 =?utf-8?B?UVdlMm8rQ05IdHVvNmxrYVJsK1FMc2gwR2tpRVJmM2FrekIxOHZEU0dBaTI4?=
 =?utf-8?B?clM5L1B2V2tkYmVpeXE0eVZydUlPbHJuWjFrNkN0UDJ3andVWHRrckY4MFdT?=
 =?utf-8?B?L2dReWpFN2ZTa2krWUJ0cURQUlJtNGNJeUk1VEQwR2Z1UkRaTnZnT013S2lH?=
 =?utf-8?B?anhwK2FuUFNEWWN4d1pza1pSd213cU81Qk9wZytvQ0JzMitFczdyQjFDMjMz?=
 =?utf-8?B?aHFtbWwxV2poU1dPWTZNejc0elE3RHdvVk40cHRlNmtqbGJVT0NaZ3BFTDN4?=
 =?utf-8?B?eTJmQ3JQZU0xeWdYSDRPa2o0KzRUTGI1dlFTTDNHcFlMUS9CVmYvUytjMHRt?=
 =?utf-8?B?R2ZoRzJRL09OenZBcU5Xd0M2MEJNTDc5L3NKTFF2N2hJSzhyWldaUng1VnpH?=
 =?utf-8?B?TE11RU9rREc1RExwN0dDeFhrbU82TC94Mmhuc3Nnb3hwRWdUVTUrWGdza3A3?=
 =?utf-8?B?alFZOVNURS9weS9QZDg1ckR0V01wRzFOOUw0R1FBYldOMkkrYjN2dlJmUWhw?=
 =?utf-8?B?SXlxYis0T25EWFBERllkTGU5NmJUVEJZYWhxNmZoT09KSjNpdGw3SDN5T2dJ?=
 =?utf-8?B?a2dXNm5DTU5WdHdZOC84RmVFMS9veTVvZUlrVkZWVks3V0tPNlpRK3ZZejBk?=
 =?utf-8?Q?RVwpXLMlyyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkkrUzVDK1BySEM3OVgyVGVuTGxFRHdZUzVTcENpNTJSd1dOVlhlVHJFczVF?=
 =?utf-8?B?QXVMbGZCemtEVzZqbWRyMWxQVVFMeDdORkdNM0dUYnFrSW9OaytabEFKb2Ux?=
 =?utf-8?B?bzN5cE5tNHlWTlJHNHVZd0pmQU5NcWxjbWFiU2ZHSFdvcGNLeDJXblZWYjh6?=
 =?utf-8?B?MlRVeHljdHBkYlN6UGVoVDE0eWJleTBFQURsY3dmN2JjU3g4VFlKZzBxQm5F?=
 =?utf-8?B?SFBVcEswejgzb3VFNnlyZm1lTjNzMWZxbGltaXJ0dDVTMGRqdzluZGhjK3VK?=
 =?utf-8?B?bVVuelBVSmEzMHlUMGgzUDhrZHZOaWtHUnU0cHBlTVNROXZyYjl6MVV0UG1O?=
 =?utf-8?B?cmNGb2hTcDRsZ1lVc2V1SStpOHJYeWx6ZElpaGRpblgvc2REckk2MFF6c3Y0?=
 =?utf-8?B?QTFBa3hReUFLbkFOY3dwblY1Q2wvUUpybWtCakIydEpaL2Q2NlUrRWM5dTVa?=
 =?utf-8?B?aFh2dmZ4bktsSksvU2hqdWRhNGdZL0U3aGFKdlNpd3dzVWt1SGdyU205amJP?=
 =?utf-8?B?Z2MxVmh1R3BpbllSRHNvU3J6b3EwSDh6dUhKV3JUblgrWnhVYWZybWlOK2Vv?=
 =?utf-8?B?RG9yZkY0Uy9NRVVIWTdSZDc3T21uR0x5QzNRU0x4S2pHZCtjYUJzc21GZElN?=
 =?utf-8?B?c29sQ0loQ1NHTHlqZVhEYStjZXBSRkdLQ3FSSmd1VlAyaUlkYkF4VlRIMU9P?=
 =?utf-8?B?dFN1MjdYaTNlUE1RN2NNQkpqdWY4cU5pRzVtYVlZK0dUU1BGUmh5dEY3WVNH?=
 =?utf-8?B?azBTQjZwVmN3NzNsQnpKWktDQ2daZkUrQUVlVzhFMHRVN1k3cHp1UEZNN2I5?=
 =?utf-8?B?TXlhTXdtWVgvb0hmTTNabmo0dmtwSlN0VThuQ3RHdE16eFB3MmJtREpMUmhy?=
 =?utf-8?B?WlNYMDAyTnlrRjNVWFVFblpBdXFSNGp1ZVg5WWJ4czN1ZGZ2aXZ2aEpoYm1P?=
 =?utf-8?B?K250TVp4RGtSdytvTWF1VzgxTkxWUndJTlJSQ2YrWGdEbzdJdHNwTC82TEVa?=
 =?utf-8?B?ZDU5UnpoVFBZek5yVENDTFRuYXYycGFFN1hFOWRldEZSVUxTcWdEN2RqTk92?=
 =?utf-8?B?WVR4dHhpK3BNa3dSbmM1NDJDU3JubWF6K2c4U3hNcjNIektzQUNiMDJJc2F0?=
 =?utf-8?B?OWpjb3FEdGVFTmxRMTRXQ2VwOUlQSzhRU09YcjlJQVlyTGdBMC8xVGd4ZUl6?=
 =?utf-8?B?MTlNbWxvSkRhakp1K2hoVFp5NkNVenYvUzlKYjRUZTljLzUyUnRlSVZzeDdJ?=
 =?utf-8?B?U2Rvc2Q1bFBBcFNSK0RXd0lGSDhoaS9GM1MrQnpOTDZoUG5NKzd3ejZBYUxY?=
 =?utf-8?B?S3FhVFFWRVBHeFBMdDl6emlIeXQveFUrWkdoWlh6NkZwR0NWOHJ6aG1VRG14?=
 =?utf-8?B?UmVLanlWRTcxTEhBS0lHMTlrY1hESjYvZVkyUmFuMm9BVnVXWmRtOGpzM1lL?=
 =?utf-8?B?ZXYxbXJ3S1c5dW1SaW83WU45MERmNXltQXRUek5SVmFiaEtTSG1HQlRCYzVs?=
 =?utf-8?B?NVQ1ZEdyMzBhdjMxWHhlMnpzUzEyTVdacGEyM01GSjFSNTNyQmt5eFZwNEFZ?=
 =?utf-8?B?RTlaZEFLNlcycHoxUmNCSk5tWkp6Q0hWa2p2ZVluK0ozcE9VL2tvZHJaT0tZ?=
 =?utf-8?B?K2xycVYwSkFhazNueEQ3V1Q5WUFRb2ZNNzRMdG5LeFVwOUVldVg4V1pWdnhW?=
 =?utf-8?B?dXlTOEhWZWFJTGZ6eW1rZkVKWHlSMlN5Tm0zR2NTRFhhWFYwQ0dUdy9sQi8x?=
 =?utf-8?B?RzFtTkpiVHZNdDRGeGZzWkErQXR4TjVxcE9JR01NbjU5KzUyYm8zc3FYRi93?=
 =?utf-8?B?T3laV1FIZ3NLZWQzYXVDUmdUc2dwMXlCaXlFMzh4Z2Q4V1oyaml0TXZmOW96?=
 =?utf-8?B?M1BQcUVjMWNnWnNnanpZSEVxcXlNaWdvZFNuRFo1bkkwY0tkVDh3eFNEaWg5?=
 =?utf-8?B?MDhnQXpqTmF5NkZVMmJnZjNranFybHUyUlFieUR3ZjlUdDVuZXpVQTBZek9o?=
 =?utf-8?B?RHgwY1FNUW1BTUNEWU1qL1dLZXl6dFdFVnJSQjV0ZjVyaEpkTmhScVJLYmR5?=
 =?utf-8?B?azFYb2grTk5iSkt1Unc3dUVjY3FzeFZRNzFLVWFGRTNlLzFyMkl4Q0NTYXpV?=
 =?utf-8?Q?QTwXvcdtCCRBUxvq9LRbNKUS/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae5ef2e-9d97-4f4c-42ee-08ddef69eb1f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:27:15.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bvc8ZMBwmwjt4yGFl65tbKE+CKU2TzzhYthojy/vaW39rxTz2o7e8982qkuhWlXc7ls/+nkRRfgxg9j0D+nSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB8010

On 08.09.25 20:09, Tobias Schaffner wrote:
> Do not run the cache debug scripts for now, as the cache has been
> stable for a while and their output can occasionally make the job
> logs confusing.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 875d951..e3e310f 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -39,17 +39,6 @@ default:
>      - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
>      - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>  
> -.sstate-analyze:
> -  script:
> -    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
> -    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"

This is the one that generates the lengthy output.

> -    - echo "=== Check for cacheability issues in build/sstate-cache ==="
> -    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
> -          --sources-dir "${CI_PROJECT_DIR}"
> -          --build-dir   "${CI_PROJECT_DIR}/build"
> -          --pedantic
> -          --exit-code 0

This one is rather silent. Wouldn't it make sense to keep it?

Jan

> -
>  .sstate-upload:
>    script:
>      - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
> @@ -80,7 +69,6 @@ default:
>      - du -ah -d1 build/downloads
>      - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>    after_script:
> -    - !reference [.sstate-analyze, script]
>      - !reference [.sstate-upload, script]
>    cache:
>      - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
