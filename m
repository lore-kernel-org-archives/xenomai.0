Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA47246BBA
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778045838; cv=fail; b=PBKOzwkBNhzfg07GJM8zeDkwv7Zom+napgcQOLMvXp6Rurp2Vq2DG9cDMulMH8KrF6E5mPPa2E0Pf5aoexcvDwljTjcjOTbnLnc38/lcAkzjI/U4tGOyKc4fDKa2j06itopznvX/lFuXliX+VV44aYdjm8cbxaDivFSeUNJ3PY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778045838; c=relaxed/simple;
	bh=ccAUjfNukHtMv+mYZ9vmBeJFy5rFYlfkDmdIvfz5Upg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=oitlOmwOPSRBSEkdabB/PNvI9AdiscqQ6C8FhFeL8rE/VE0FBmNpFIVrc0B5hZCYWrceLHZjjvm4yJadtM3ajaj9iEfDF6ruj8tE3CFLHMUZOA9xDVOlARxIjL07B4NHPw7BY/2hHYND2B3gV9+8DOzNLDF8Ri0633L3/H4TdJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w3zSEEGI; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w3zSEEGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dahPJsT6w6QZnEuGBGj5E73/7S8fiMGDVmIf1lhQkTJQuisHKpvPnIuF32kZ7gZntM2iOX9idG8JUx848uXCpsojITMBqH9wzL86UpGcq7HkCNcGMkbasHMOgGLoJ0Twy/tQYzKhPAaQe8cp/UG1uwjUMYa0qJt3y/ZJHfEUFITm3CnAvIls3qPB0McjXGUxWHnjd9OWtmLu46DJwvdlWl1j3PNKhaM1s9N/uIwL5d5WYcRp9l9cNP8Vy4rCPPbJUObFHcCHbZ3j8cqYrj/s1qPA4Pu5pBKyio0TpnyhVWAy/Z/zMLf505angvOFMzikNXWRszKvq8fOLF/Q5nnGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qG45KSyv9sKqkuI0GTw99qMnBQQwojcnCQr/wFxDn8=;
 b=kSts7ym7WYZB3W4cK7wvT6DBOPLEMbsHoVRG66+t3S5tz3AZMo1jvCaR3i17JtuyEVWQt+yCdKN0/fSsqn1276DGimC7nKASpV4a8IM0WA46CgXUrhKGAaND1T9c5/Ym/2YAEFKvVahWskj+tg6K9fiNVhezx/WtOyHoUKAO4jq48guoRmxBhHdMlbCgbSCPRcFNMqGAIvAfzYYuk55K9y2Q04Lf1yZZdhnLsH6q5Ny2StPgsAdTF+Pi7a/w6+JEwGPePG5BVCTvBErXHdOTlCrKADS5MZ9I/v6L6a1mzXITKVlU5KmDLlcttGA0ltnWH2JZk2SY79Hg78WmHiX8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qG45KSyv9sKqkuI0GTw99qMnBQQwojcnCQr/wFxDn8=;
 b=w3zSEEGIIlhcBqbAAASHi4b3YWSNKqn7wzO+QHm8sjCX8VM8nc1/bOUm6sn/73V2wW5ZtX9km/hnfjDqXLpFWfSYdAfcAZ3Erhhh93GZtFxqWR/LZ9I3GBrkej10PLNKDReISRSxV93j644YQ7x+Jcevva6hYDH5+2X6/JJot1dnV//63hzu7hjf7AmvWDnMPJ7NIJtjPkyusBxYjT/hw7fv/zoNJoZWBZ9+PmE9b2CN7CZj1bTUdG9bEYkt97KUVa8sy81frWLoPvNtmkZxN77PZN9DA41W30xDgKF8WzYcaKt2QCvVHljoGJhy6c5Reu++yawtP60zH/skkIjwKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB9785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:650::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 05:37:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 05:37:13 +0000
Message-ID: <9ed77f4d-3246-4e36-bda2-da466c23cbc3@siemens.com>
Date: Wed, 6 May 2026 07:37:12 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/alchemytests: Be more tolerant to VM
 environment
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: e59378d8-0c26-42e9-a77d-08deab3186ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	3Wt4l32FFDv0gANcbO79lwDXnR3Y+Jj9e4jUN9UGw8zpSeL5A6q2PiD+UZkOVytiueMMDpvQZ3+2o1n1hbZvpdKQw5IPBuKKYSd00pm3uviR+deQfyPteo5fmGNrzKXqAEUqE9fi6s2rsHP5fd1XBB3N3e/IdGBAz0XO2A6SLdewUikWlraEcK/zYeXT2BGSPNpmRblJ0arqkXt7p+PxSx33fkEq2+ljU/qmfn36IRFHGTdxFY+poNR1j7k9qX/eAtxzbBpx6zCrYKKzgZegwzOo9l4j98RmlxchNmVaxigJ9iMRZa3VON1ad5K/k412uS8E6G+9hFNRTyhcean3lTywh4Gh+FXyTax7CIh+q1FamotGA2gbvLO92EBE/CyL1rk9HUF+WuVXfCEje3IZnt7pCKmwwJeFXJUWuq05fu8sdxbdZpk3DTW68IQiYRGBMHpnHqa2ItYzAA7NI5gUnCtyHgIvsU8OxVKG5LO9Q0w36o7GWbzF6fqZ/IRxl7ZqpPagGal5qjQgsyJ0sD0H7Ho37ZVzDrMbjubdKRE8kqOI1GGOtKjoBbDBSUk/2v/JC04lPu8Qb2/4YlzYxEMCKnfX7b0tyRDMiyJi4X6whlU+63i97+YNHAcPZYlIKFYIBdirw2ruTf3c3gzVwWorNENUu45n6XUBJMauVRW/bDZbsoufCKtRhRrglE7CRTlb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE9EaDgxVXhTSU5VdW4xVVkvRjd4TVVVZG1Pb012SVgwV2NES056TkV3c2E1?=
 =?utf-8?B?YWNDR1lLMVNZSGlUNFc2VVF1T0VPMnJGMk5MdjA5clBwTkwzeXpNYU5RN3p3?=
 =?utf-8?B?eWQzSmhiaGhiT2lHanhWdmJlaDc0TFczenAyYXZKeWZpRkRnb1VCVTRUSkY0?=
 =?utf-8?B?bk93QlpIeExYaGh2RGp4Y1pzLzJvOWJ1SmlJNE1GK0c0NGY5bFB4Q213b2My?=
 =?utf-8?B?MndLTDNyaVR1OVppdlpBb0lVSEk2S0pYV0dXd0N4SjVVd0pzTnpVdmlYWkNa?=
 =?utf-8?B?T2N2TnQrQUtHZXhOM1M2Q3V1RTZiSHRkdjlIUXVmMW4wblo4dU5OZHJuek5w?=
 =?utf-8?B?TkpHc3FhbkF0YVFkRnY5WXZqYkhFQU9OYTYwOXVtVXpIVjBBNW1kSzlvUi83?=
 =?utf-8?B?TGFvdWM5UkFFZlBYeEpMcXRZUFNiWUwvUEFsT1FFb0hYNWVTemh3aWZIUjhz?=
 =?utf-8?B?K2NuL0VCWGFzeERxYnVzVzhaRlpYcnFrT2psc3hrQ1dKaFFxenFsVnNuZHB1?=
 =?utf-8?B?MUVHam9SOHZ2ZkhHM0d2THVrSXNRdnMwVytKYm1Ia3FhaktEV0lzUm9CWjhB?=
 =?utf-8?B?NGZvN2xDb3MxRHkyTmY2bXF6M0tGRTJ1dWxsNE9RUVo5NFBCczlKb1dPY3N4?=
 =?utf-8?B?WGNYY1JYOUM0a0NFVUcxQmxtZTkxWmRheklkV2FCb0NqWCtTYy9pVkFXYkdC?=
 =?utf-8?B?WW9rUklXb1NtR0drazE5aEs2cG56S2FSQnhGZGx1Z3VNUVN1U1M4TlZXTm9S?=
 =?utf-8?B?RVdHMzZaWUx4VVdsN0VIRmNYNG1rMGlEcXFhM29UY2YwaDBmQUpEZ3ZDNnRh?=
 =?utf-8?B?c3lsMHlOSmhoVGs5eHRkd1JFMzhPL3lNSHBOTVBldG5UWlE3bEcrSmpRMXhj?=
 =?utf-8?B?THdLK2JCWlJRV0hzTExaYStUb01KbmYwL1pwN3pVL29HNXltN3Q4Rlk3Vmhs?=
 =?utf-8?B?QktkaVFXWFkrSlVzTm54NGdJWDRGVmhIbjJEOGlpaGRpekIwZW5tbXAxdjJC?=
 =?utf-8?B?Mks3cUVRY3FPUW0xdFY4RzdXVXYwelMvbW5SNmpka2o4NllaVjRLaG5abVFD?=
 =?utf-8?B?d2cvaUtqbzhvL3BPVlRIOWdHc3ZoT1VDQkYzVnMrREJTWEdYWkRnT1RIczc5?=
 =?utf-8?B?aXM2dGhDRE12NnhtUEt6NVNpaytaSCs3cmM3S0FhMVh3R2FnRDVNbHJUL1Ni?=
 =?utf-8?B?Z0NmbXhmVmZzQ1R1YVZobm9VVU5FRldHdElyN0tWY2IxTnZoVXlZOC9qUlRu?=
 =?utf-8?B?ZU4zMC9EdHg0VUt1NjhHcVV3WGxxYnNjYklVS0xicW5nd1ZCcE12U3Y4Sjgv?=
 =?utf-8?B?TXMrd1BGVEJ0VVhTblcreUIyS3d0ZjV1VE01L0lsby9jTWZiekIxVkZPMHM5?=
 =?utf-8?B?U1RpY1pKcGJtQWhBSGp6OFFCaHNmK3pkUFdOUU1sTThtSzlSSSt1QThKRkdS?=
 =?utf-8?B?MTBmRUx5NmJSOWo0TXRhMVZkK3hnK3JtZHRRVDBaQkg3MmpnQ1RTK2JhL3Fz?=
 =?utf-8?B?bkdvWUw3bjJUVGFlalFBMFA1dDQ1N3hOL0Nwb2VhbHZwZTVyaHpkWHdqSTl3?=
 =?utf-8?B?eTQwLzFWSS9reWxwUXFsb2VGL3lTSmdoK0ZaaTdiYkxXZXEwWHJOeGU3TzVl?=
 =?utf-8?B?N0IxZC9mcEVHbmhCR2pSa3hINnlGZldmSlVjV2U1dTRSNjR3bURDK2ZuWmRi?=
 =?utf-8?B?Um5uWXJldVp1em53MXN6UXZkc3I0TndEaFAwOG5IMzUxOCt6WnJEYnVNZnlQ?=
 =?utf-8?B?Vk5IcWMyWDhEL3hHb2ZzSk9uZDBlMWVWQkw0UVdCbGhjL3EreXlPUlVQZ3ZW?=
 =?utf-8?B?Z0VxRzFkdVBjYXZBdDRDeFFtOVhmanJYOE82LzQ4VTJZUUdkT09VZld1bEdR?=
 =?utf-8?B?aEs2dDFKbFg1aTVnZUkzMVE0MHdBcy9SblE3VVg1T3AyNHV4ZzI3dHFQNDg5?=
 =?utf-8?B?UjJQdXphRUJYUWNTaENJU1BnK0ZjVERkQ2JxbGszbTZKMXpXMVFMejN3aGVR?=
 =?utf-8?B?WU9aWGdieloxZUxWOHVDZ0NWUGlCcThocXpPNUpxS2ZNTlVlTXNFOU1qTU83?=
 =?utf-8?B?bUlzVXArMjFFdWVoczNIK0ZEbCs4M0ZSNWM5eVlPL1A1dHQxRW1CUXBQYWdK?=
 =?utf-8?B?aG4wVTBJWTB4RWpzOHJkbXlBZ3F5TmpBb09hRm5FYmtQa0dYb3Bsb05EaWN6?=
 =?utf-8?B?QnNXTGtnWlBpOHJTaXlCaEtYUGZ6NjJKdTVvM3h3YzNGbGRjbEZoam9HTElP?=
 =?utf-8?B?YitPUmlzVWxXZ2x0Zmh1WUtFMHFkVnNQU2swbVFwMXVEZW5TYzNlSGRtMVVY?=
 =?utf-8?B?NlBOaFlyTVV0V1NBT2ZGTUd5L045dFdIL1MxODF4TjRZYjBocHJKQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59378d8-0c26-42e9-a77d-08deab3186ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:37:13.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXjKAvmH7YRQE2vuKkEzQ74p910eRwsTRtKWftCewMt49ZzWO8lFvIGRrHT8rhDPYtPokLisT3biY15GyhdaWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9785

From: Jan Kiszka <jan.kiszka@siemens.com>

We already relax the duration check in task-11, but also
rt_task_wait_period could run into errors if hosted in a VM on a busy
machine.

Part of the issue #52 story.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/task-11.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
index 819eca715f..6d07e02703 100644
--- a/testsuite/smokey/alchemytests/task-11.c
+++ b/testsuite/smokey/alchemytests/task-11.c
@@ -15,6 +15,7 @@ static RT_TASK t_test;
 static RTIME duration[TEST_ITERATIONS];
 
 static struct traceobj trobj;
+static bool on_vm;
 
 static int tseq[] = {
 	1, 2,
@@ -45,7 +46,7 @@ static void test_task(void *arg)
 			rt_task_set_periodic(NULL, TM_NOW, PERIOD_SWITCH);
 
 		ret = rt_task_wait_period(NULL);
-		traceobj_check(&trobj, ret, 0);
+		traceobj_assert(&trobj, ret == 0 || on_vm);
 
 		end = rt_timer_read();
 
@@ -61,9 +62,10 @@ static void test_task(void *arg)
 
 int main(int argc, char *const argv[])
 {
-	bool on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = rt_task_create(&t_test, "test_task", 0, 99, 0);
-- 
2.47.3
