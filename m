Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1221E0E14
	for <xenomai@lists.linux.dev>; Fri, 10 Jul 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690937; cv=fail; b=pHfx08h0upEzvziJRVu3G7Pw5RoePz3PMbqrWHs4GOkGjCM+7yyt9IkG+tpZOH8Zt+6SLjpe3uCf/h5c/Q4s1WpuKbdRfYbV+Q9FZ/acodipq1tMQNoW3ETkPwZFu7azgxovmt3BjiG97zYN5nOsF+zKwIMxTFcuH0ltse8Kj/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690937; c=relaxed/simple;
	bh=aYm/mS48tFSJmKkElAP7SiEECHRLCfWwqzv5CrTvMMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iX+aVqCDJQwfwP7dniARFYFA9IsL3pBVnv92FhmC7tcu8Q5duRRXEMvKLvLQMzJUbdV9cWlU1m72MtWUC+cbl2JERmyKqEMALJqBdETiqb4eXeCwN8B/LY8fQR4HzpOg0E0lcDFaLk5XqZnoSHEzwjYjn4pXZ2ikWr8J94CSuAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ymRPN1r5; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ymRPN1r5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhPBAIdwN8fF862Fl6aT6AAJGck8vfcARvv+rLR8pxkxSs6HVZlEZxnLSOjkNoZNg71bhXCoOZSaArA5k9tJVpDbcX9EAB+BBh2LDZ89k3dgQwnpnqugzaSNuRzV6E2WsjUwVG9XsBEORPiZsv2kXmLRROs3Xv6lrfS5i0lfnwcz+h9qFMPTLwh0wP88zcQpV7kmFbIxnOZIyOZqUjRl2T+Z8MnJYbquh/FoV2nISauN2VTci6cav5P8inFbqLRmwPdZN8kQ/PuVkVbCDkooZX3ZAiFU6Z6vh7MGwLUE+8MfvPcdmX63LsVZEL54XnGBKR09db0peEQMqS1bd4RhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ustj7iHxF2ysV0Nt5HF1S8ZvldMNmpTT/bXj83X5P2c=;
 b=Ya7k8UxTq4iViEykUDB8m8aQXitTPHw97K/FUonAhW6ZsEiasd1kA2eBIJFnsgL/uOhrDNT3WEIjdwyXxqzZEJUxOjRaLxv8NkIJBuTYaae7GWSJRVENidII1cfJgZxIdeMs5foC+Rx4ZzoRWEfba8iDp/cQuZlv4apEgbFKKCj/fbZlbw2jRs336oGChOW1Nt0uxhgrE4MSc2quJXspy7PjtMEoOo2BjPsFAXKSkCq3QjVQ/zM2vMQAIaTO4EQ7d46sQuyJcx5BMj4JnJlMj5iNAoOEuB/i/9mmUEcKFWWpN7xacSyApBbo7ynw/FCMc/gLUs8rxea3fxAYvL1Xeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ustj7iHxF2ysV0Nt5HF1S8ZvldMNmpTT/bXj83X5P2c=;
 b=ymRPN1r5J77QkEoMG4IzhSbG9MEB0f7ThXNpmN9fLdpzIBqIa1URQnXmL1q1jqDFgMlV71sR7COclCS33MS2Rtee61GEECaOAOnguWPxZFNckcS7a5/Nj/PoX6XYrU7iFLoh0/db7ZXg+vwNE4HW6ETh1SqTWOm94BqB4YuvPzGJXmvBJ3jrBJCTBBmIxgHgvFD0pyjpTaOThV+p9wCMmi4zQSio6b2shD+s37Juj/MvJIaY0D5I3MVZpVcHS4fZSHhG3O8rw5VHRN657hmDga0q/O/95een9SgqLl6ZrmI6m+gDp9QocPAHuwRpH/wbUjV/vKNYR/S4+TfX8cYT6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 13:42:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 13:42:10 +0000
Message-ID: <d78464b8-96f6-4ee9-8a3a-de9e4da5a219@siemens.com>
Date: Fri, 10 Jul 2026 15:42:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] linux-xenomai: use the wip/evl-riscv
 branch for riscv
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260708194021.1236842-1-tobias.schaffner@siemens.com>
 <8c6ada2a-b6d8-4665-b3ef-61774e919df9@siemens.com>
 <95f135cd-c4d4-4376-a72b-e301abf4dc8e@siemens.com>
 <b6b72107-bfc7-415b-905e-d0541861d557@siemens.com>
 <11a89f68-50d0-432c-8774-c5cc6658b383@siemens.com>
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
In-Reply-To: <11a89f68-50d0-432c-8774-c5cc6658b383@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: b94c1df4-2b89-4ad4-2fce-08dede890a40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|4143699003|6133799003|22082099003|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	hXldttr3AKu3I3xA+ylXHqMWhw3bTlGP4KRmLvhTNkCUCynPyG7KGrcI00G/vDD+I3oyAgh2kJjf9mKB4GKvitcLLw6igSvxRPS4F4kMKqiFnVgAkgmNIDQPydFJs5x502l+E0wOwBnUjUgZZg5ennMFMkUYTuCFRZs9Iwb4GzHC3dlDCBWo7j9Zn7XcW+BlEslXSsXN/WcS579EYkbjUSw/57v1e6Y6kUONkm8BRFwGmhrK36kIDmroWMJpZkstxpyd4nHJ3nvjasIktsG26jg5CRnbbD9T2LeIvvbG6S1kn6jGlyyH0qb/stZFjexSngF4uDtSf9dggU0deR1Q9Bt0HxqNJbpU2tEUrY5l0fayZIwlYYC4hpAYnr0U2v/8qXZlw95uKgjNDPaKT4o8P6yKBJIiCejJ20jlvugOmHGvx9TOgxWs4ztHsLR5DWcSopQq9AxOKtfeQUZgrcszcxhlm0DhoNFFvrpUd8LWVqPkLjC1FNcqrGe5wwYGOQpZoqMqZY/0mBkL9EUycIk3nsy/9fYOjy82TCoKBeBI6dkGwHkFihgScqvCE4aabxONcC/rIMZBK2YfOVzIiZ1HagAFbgNo70en3sffkhuw4ya9GWDSap/4OvXTvURl6yWy1AAThKCm7utip3edr0FKhA4WNlru5mr7TjgU9frBhtw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWQ3a0tyY3Q2eEVORXdzZGlIZ0ZUcUxIdmYzS2Ruazgyb1I3RkpncjJoNEVG?=
 =?utf-8?B?clpMN3k0bDhycVNsa1N6bHUwdDVLQTJVaExCV3Z3aE5NK1F4WXpHNlJManFC?=
 =?utf-8?B?MTU5UHhrczlmUkVCVXVaaFRmVVZVa1JrdElqSHVnVWEvM0NFTHEvWXQvajV5?=
 =?utf-8?B?RWxvMDNCRVJWWmd6TXE0SE54MUF6WnJpWC9Ob0NYdi9OYlJuUHNSVDNNN3Ex?=
 =?utf-8?B?REFSeG15WmIzNllSS0UyNWZ2OHVQRnBwWWV4Y1g0TlZKT3VjbzVKZnIybGlO?=
 =?utf-8?B?VUtzUEhZdmc3d3ZMU1BxdnhHRlBWbitLN0FwSzY0Z3c2Tmc4MFlBZTVWUkhI?=
 =?utf-8?B?OEF1MjhGWllEMzk4Si93aGsrK0s1RlFnYyt1Z1RiREVscWtTT1FZd0txcVVI?=
 =?utf-8?B?bWI4dWdiUDZHcVRrSUplQlVYbG5CbTVJYzRyUW84dDRwd0RLUUdlOXBXUzlW?=
 =?utf-8?B?YmRTSGdWYU9JaTVtenlvZmw4VVBvSDVXbnZPL29kbjlTa0dBTzFvZ251Nnl5?=
 =?utf-8?B?dkpyMy81RWJrL2x6SmFIUk5WU1d0VmQvVzY3NlRPdG1rbkhZeEgrUHFmWkJm?=
 =?utf-8?B?Rm5lelpvQUNibjVkcDRIaklPc28wSFdhOEhHZGNObnhrUkxmTktzVzFSRHVa?=
 =?utf-8?B?OXlXMXVCNWZTa2tlZWpERlRQSnEyS0t6M1hhZFZJYkdtK1ZxdElqQ0pkalNI?=
 =?utf-8?B?QytiTGZpMkw0QXlpUkVoUnhmMnhkb0pFL09PaXo3Q25xUE9NYThDUzdsZDRL?=
 =?utf-8?B?NkFjbEQwVVprUXZsS2pZZTRUT0xUTkcvRXhHazFibzFaQWsva2g1U1kvWHVv?=
 =?utf-8?B?WHZtYWVnQ1owL1pSZUcrRUtlbmd2b1lkNzVqZFhtNHdFSjFLWlo5a3ZEaDdB?=
 =?utf-8?B?L2JZWkI0YmpITFFjRnlIQys4YjduQ0p2eEwreWNFVFBtTDg5WlNlOEhUQUZs?=
 =?utf-8?B?dzJCV21hVW1VWWo5dmQxMTJxS2VWbzd2dUp2M2lZMEJSMExaYnFLS1kwcXJx?=
 =?utf-8?B?ZTdBbW5hUWtndHh1cnNOcExzQUVGZGFoVFVkeVJyOG1jOGk0WTZhNWFlTS95?=
 =?utf-8?B?VkxHMU9CcUcxTUk0TUcvMXdQRmdhSjdhYXlzbW1Kc2Y3RHFsa24vYi81ckhz?=
 =?utf-8?B?WnFTNDU4QlhBTm03a0JoSmRUMCsvYzE5OEFJaXdCWFJRaXQ4R0tWWjZmc1VY?=
 =?utf-8?B?L3R1azljRTJGNGduc0JYajNvMUFsb01obDNXdUZCb2VZZlUrcXBUWklHby81?=
 =?utf-8?B?WUs2cGFxbmt1Y0pXQXhQb1VJenF3Q1Z4UzRHdHlKWjBFdjR4RlBFcGg3eFRX?=
 =?utf-8?B?Q3Z0NXZrdGJlSUhiUDVHMGk0YWdSME4xUWNLVmVNWHZJWUlCSlJ4Y2tDNEFu?=
 =?utf-8?B?ZnJ5eiszVVdvai9EZE9Rd0dDR3dqSG14Y2MzcGFyc09xNTV0UVppM29Ybm5h?=
 =?utf-8?B?Q2ZldWhQQnVHb2J2RlFycENPTmpSOUtqWHRMZnBrOGs4UW5SZGJWZEllN21L?=
 =?utf-8?B?bDd1eGw2UmtWK3EwbmVCL1lVWk1LbzFFOXRvZzh4KzZ3Y09oc2JucTRiOGN4?=
 =?utf-8?B?R05GZXlBZEJzckVZcEp1TEg1dzNqaWx6ZkNBTzJjaWxqa3RITTNpME02RnMx?=
 =?utf-8?B?SVVLR3V6cWFyTXJKcTViVFVNdjl2N3pGMmw0L1Z6RGR0TFdBNkVMUXYwRHF0?=
 =?utf-8?B?Y1QvejBsZmFCVzZjV3NWTUhMRWRJakRWWk9EWktGS1ZFYlQzZXl1UmtiSTdj?=
 =?utf-8?B?cUREMVIzaW4wM1NFbEh0UGNpb25xaFk0anV6Y0ZYaWZmNVFTY0l2Y2FtazFo?=
 =?utf-8?B?dlhqNUE0QlhIYy8vbTFZMW1qSER6OXBCYW5hVmdQZkl3aVpQd1hhY1I3TlNK?=
 =?utf-8?B?bTlGVDdYeEh2eGxQQTM5U3JXVHY2Q1k1SmE3WElWeUViQkxsSGYzbXNYQm4v?=
 =?utf-8?B?WUNoRjJObm4yK2JENWpXbjVibHk1ZlBuRkFWekdHNUlwY0F0dWEwaGE4U1g2?=
 =?utf-8?B?b21uSE5jWVdUL3BpVlN4V1ZZaUFEaW94U2Jid1ZKdlBtMUZqQW00cmxpWHo5?=
 =?utf-8?B?NzdZb0FlZzhma1FUZVFpYUxZV0dwamE0c3grR0lKS2V2OXZGWWh5a3V1dHly?=
 =?utf-8?B?eHVUcUhNajJmYm1ZbksxN21SbjVDWTVqU0N4VlZKMkx1WTFJTXlIQ1pmeGN5?=
 =?utf-8?B?RGVHQ3plYjFCTW1KK3ZTYUNydXpDZ1RDMUNqVmhrSVgyaU85bFBjbkd5RTdN?=
 =?utf-8?B?OFBCNU5JeUdsQzlJYjlXK2t2dWI1ZmNzRk1zSEFzWllpYjA0alNxVnZoc3h2?=
 =?utf-8?B?Yk4rQkpNbWM2NVdPblEvYlp0U3VIM1pNVXdwSE9MYlRPRzBHY3JVdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94c1df4-2b89-4ad4-2fce-08dede890a40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:42:09.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3upJtd/n48Ic1EUrUDZAaIaJNXZkLMLl34SBkAfmcj3x9DRjf84tpeoBHP1EApOuUrE+MN7NPFkNoHVCeY8BSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6259

On 09.07.26 09:52, Tobias Schaffner wrote:
> 
> 
> On 7/9/26 08:31, Jan Kiszka wrote:
>> On 09.07.26 07:03, Tobias Schaffner wrote:
>>> On 7/8/26 23:26, Jan Kiszka wrote:
>>>> On 08.07.26 21:40, Tobias Schaffner wrote:
>>>>> The wip/flo/v7.1-evl-rebase+riscv branch was a temporary branch
>>>>> for integration of the riscv patches into 7.1.
>>>>>
>>>>> Switch back to wip/evl-riscv which should generally hold the
>>>>> current riscv patch set ontop of the latest next.
>>>>>
>>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>>> ---
>>>>>    recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/
>>>>> recipes-kernel/linux/linux-xenomai-4_latest.bb
>>>>> index 48499ca..a542e80 100644
>>>>> --- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
>>>>> +++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
>>>>> @@ -34,7 +34,7 @@ GIT_BRANCH = "${@ \
>>>>>        'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
>>>>>        else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
>>>>>        else d.getVar('LATEST_KERNEL_BRANCH') }"
>>>>> -GIT_BRANCH:riscv64 = "wip/flo/v7.1-evl-rebase+riscv"
>>>>> +GIT_BRANCH:riscv64 = "wip/evl-riscv"
>>>>>    
>>>>
>>>> This branch became stale, that's why I switched (535ce20bf0e8). You
>>>> just
>>>> updated it to 7.1, but its baseline is again outdated.
>>>
>>> Florian updates the Dovetail branches and after that these changes have
>>> to be rebased into the evl branches and I again have to rebase or
>>> cherry-pick my dovetail and evl patches on top of that.
>>>
>>> What is your expectation here? There are three different parts and at
>>> least two people involved and I do not have something like a automatic
>>> pipeline.
>>>
>>> I am still trying my best to keep the dovetail, evl and libevl branches
>>> up to date.
>>>
>>
>> Also because of this split between to persons, I was switching to his
>> branch, assuming that, when he updates the baseline, he will also rebase
>> riscv.
>>
>> But this issue should be resolved now within the next 2 or 3 weeks by
>> finally having riscv as part of the latest evl-rebase branch.
>> So I'm unsure if it is worth switching branches once more or rather wait
>> until we can simply drop that line above.
> 
> Fine by me as long as I do not have to change any additional technical
> stuff until then and riscv makes it into v7.1.
> 
> Care that the riscv patches included in the wip/flo/v7.1-evl-
> rebase+riscv branch are already superseded by v11. As this revision only
> contains cosmetic changes this is fine.
> 
> We are choosing between the latest riscv patchset and the latest state
> of dovetail integration here as both developments happen in parallel.
> 

Well, as I had to update things anyway, I've taken this now.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
