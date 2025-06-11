Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581417E
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749617035; cv=fail; b=g8ZRx+LqeZbrzpEwJOBYAzSaCTe0A0/Aq5fNQs5WhUCfXsVLutJkjdb2qwtKS2oboOG3eNpHdPvmytVAgVyY2MZZPNZs7DtgerPWp5ijypOLUabLrq0iAmp/5doEgyeVquTiOp1O9rDa5jDceZeNDTJ0kdAaPJn9ztZVrBgdDlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749617035; c=relaxed/simple;
	bh=dwBXZgmmZOkuwJnxEsT8Ck9Q766DpeAqujkSyAQPVlY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGlb/W0o12EMoxuchitGr78UG72uTW5HG4uvIP4FqvKFLjRf2b4S8GX3DrCGqLxai0johd8H7MHXNNZNFFSyWM5qh2yxbYwI8HlOLgQmbn66LYUGYF5a0NtUikMOsVIyuz0ETK9ZsfJpadwyL2AqwN42hEINeDaOvplCA6jBaKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U/C/aP9D; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U/C/aP9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KugEPAD+7BV32Is/ruMwthqxQ3d2KfQfhRCJak23fZPge1owNeRVPVkpuvnSaK3o7pNWcz9jtvBaQI8Gb9Qv9QgWyNoFni3VJ30/mlS1TO3pounKmZWP/CSrHiYfr4MBErIvLrsLvkzI2r38rWYC+deqH2pGgl7n0iCoYOoDc9GoRY721bIm6irxk+PEJ08I1CkI3mNyOeZ0B0p2ch3ANQjFZbflmfLxbpuJfLYMmLrjzisdchOKuUGCq1LpXU85VRVF2e4AQ+vW91NGO4Qot+djORVfuLYzAsBWreN3wwZfYifE6ZYGt62JkWpCHeKnYTqJyxDWqjqmGWZIURuQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMnNayKao8hRzW/mHevK1rBbbaVpBidFP/gKv2zgIMo=;
 b=IQee1EDtqbBPAXXt1VanTS11gV7DbtapQwwuqD5rwvQagS1YCkKwCM5eiL11AiSl6KHBlubOt2yoSoWi4OyUOKSkujdS4YD2tQ8dhA8EGPQfv2BrolKpEbIs0xBCAYaLvFDhzX+WR7rEOxdq0VyJgSq4XKfymTL6xkHDhswmK9trg4imBRCZS886wm13TwCmjfjWxVJoJw++X6YnwWtNnLgPqhUb1CH4MImTKORcivHvia3RZvJxutHYc8O5JAJ5FCFrL5rwg8R3K/T0gcv9GrwbAIBrXz/GpD/NVmRJUePoqeyYnTD48c4iWDWrD+zLRU0pTRGw9wgliOanu4PEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMnNayKao8hRzW/mHevK1rBbbaVpBidFP/gKv2zgIMo=;
 b=U/C/aP9Dycr8zaUEr7Q3xTCUgiYgj4Wh3tKm4YKZAyFDXBrHkIkg+blSuELVisaSL1T2gOOnedWZwOqls0ei28IoQTIFcZZW59cSIBxjeYvkjrLcCHGQQGhRShvXzAxjtCBKF+5WV4mj2+geOgzouBT/m+mdlfgKyt208qtz+uXGPcYRLpuJ7JUNA7Tqu2ciyr/xKUFG2y20Uvhx6oqmIZlkTAuF44XXE1IR5Nhnz1nIuVHV9BTvw1Rk5nYDuMykgjV1tVMGDwaIHjOglDHBah4bMWL+LX5/bB29qNfjgOkuGQ+5eOU2dy761Q/0+np3BDG/vZWROdOfTSW7Waf7tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 04:43:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 04:43:50 +0000
Message-ID: <0d834cc6-44fd-4727-8799-08f23809ad0a@siemens.com>
Date: Wed, 11 Jun 2025 06:43:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: printing device name
To: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPGcTjSfPztq_YyDSaAJoYUvL=9B1pTP3cKJ2S0WOa+VAQ@mail.gmail.com>
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
In-Reply-To: <CA+K1mPGcTjSfPztq_YyDSaAJoYUvL=9B1pTP3cKJ2S0WOa+VAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b805a6f-2090-4e8c-346c-08dda8a28f8d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjgxRjg4YkVZRk03WStXTUFLdnR2UE1ranY1U0ZEY3FaZjJYSmhYZ2FVeDRs?=
 =?utf-8?B?M1oxM2huWTlvakRKTWV0aTFDazZRNjVINTZWZzV1UHFQSFZ1OElGUktkR0NP?=
 =?utf-8?B?bUpxQ2lQeWs1NUh6TVBBdTdRUTMwYWlIaVlvYnZ0ZHc1bithNnc1ZnREMUdF?=
 =?utf-8?B?cVorNXA3V1hOV2kvNHhLYVlHU2Y5em1Id3gvNmYwSmJ1ZmdEd3RRd0RjRXho?=
 =?utf-8?B?d3V6dWdiVUxTVzJ3Q251SnVIUXY5aW5FQ3hJTjh0RmRIdDJNa0tSa0x1UmVt?=
 =?utf-8?B?QXNZc3p2am5NU2hqYzI3cjRsNlFIejZ0RW85VGNvakhQWEEreGo4SjFIR2hv?=
 =?utf-8?B?OFBOVGEwUHlwaUxndUQweEpST3QrUVNibHF3Nytla213Yno4OUk4cy81UlAz?=
 =?utf-8?B?RWFsd2RFcUlHYW15Y0FTYkpmSG5oQmtWQlJpVWtCOSsyTWZTdGxQNzVYdzNp?=
 =?utf-8?B?U0tyUWxxT0taT3hWa2Q0LzZQdHhyNXFrZEgxSHJGaXJIYllkL0dRenhlKy9h?=
 =?utf-8?B?alNqZHhtZTdWNkhuc2NLOHFjN0JiRHhQSFFJN0c2THFBY1F2ZXJVaEJPakQz?=
 =?utf-8?B?T0RCRVRkVGt3WDd0b3IrRHpCSm01RU9ISDM0eE9sQUNjMmpmOG1nSFRKOVA0?=
 =?utf-8?B?TGxCZXdXcVFobHFROXFERWdUK1V0cGo0Rk1iZ2RZMURGVmZhNVJWa3g2TWNS?=
 =?utf-8?B?MTltbnVJSytIbXhyZEl3ZHAyL3dLTlh6YlUralE1eHhPMndOMWJsQW9mZVpG?=
 =?utf-8?B?ZFRnTHhacXpxcGJ3K1ZEOGNQTVZDUFI0TFFDL3J3SVJJOW9PN25NVFA5Vkk2?=
 =?utf-8?B?c3E2TU45R0pYQ2JnaHZ6cDZGd01NWG42WEkvM1dqV2UvSDFyWXlNQyswblhU?=
 =?utf-8?B?L1dld3VHdnVVM1JRQXpvSHA5MFEwaVZGbXUrcmFzOHRlUCtKSDdrVU9IcHpM?=
 =?utf-8?B?bTc1UVBGc3RnenFQaDlvRkdpWE1ETmhHVFBUazdOSFB6R0puYldNQmQrM3o0?=
 =?utf-8?B?UC9CTTVTTGhRMCtBMnVQeXQvMEpoVTFjM0JlZ1VlOGlBUGl3SVcrYzZrWkp3?=
 =?utf-8?B?cGg0a0E3dndwT0VTMkdMZ2JxTGtDSzc1dEZrMXFWNmRUWkRvdjJzUEw5T1RI?=
 =?utf-8?B?UlE2aXp1d25iMEZpMVVPU0lNWVJwVzc2REUzTVVtanczYTBKSkhUbUdMTHhS?=
 =?utf-8?B?RGl0R1VNTlBMMlVsa09BUkRUNzJFRUpkelkyYjVMdmFwQkRpR20vMHZDdFox?=
 =?utf-8?B?Y1NkWStzWS9ZUHRwMlA4K2hJTktqTmN6cGVLUmZwL01NYUI1OVM3b2pFL0Zs?=
 =?utf-8?B?VHhpMDVuUWJ0eEhOQklWV2xHd2pDTDkwSFc5TmY2SVNSRWdabjhvSEd0blla?=
 =?utf-8?B?QlRISDcya1UzWEpYZUlaOWk3b2ttNHFFSG1kMFMvZWxKczErWjBRVUdvWXBU?=
 =?utf-8?B?ZnpBM2hMVTNTYUkydWZxYnNSY0xvMllzbGVQMzU0MXcwSFFBMG92Zk1KalU1?=
 =?utf-8?B?aEF2aVBBbXEzMFVxYTNFWDMyN1dsUFM2M2JMVVF2TmIxS3BWenA5c3VvN01o?=
 =?utf-8?B?b2x3NG9nWmRLWHdaRHRHdnprNVArR0lPTVU3SlE1RkFMQXE0U3ExaFlXTkhT?=
 =?utf-8?B?ZnZ1VlFwVlQ0amdoKzlDSG9tTXZ2c0Q2YzVBS2FPdE5CWW1IQVVYUUZydEpJ?=
 =?utf-8?B?RzdLd1dkejVxL1VBTDRmdkcwREE5NG9TNnJJdE1RZ2IvTGd0Nkw4Q1FiUldS?=
 =?utf-8?B?WGNSRXpqWGNsL3JNSzRhL2RpQi85S05BQ2pwSFhqMWtFWGxNbU5LS1VSbG41?=
 =?utf-8?B?aDU5Q3B5R25zZHVsbUdGVlk4MW1VcUpkNEdYYzdKOGlCWW96YTVwQ0hKMGVP?=
 =?utf-8?B?aHFLcVE0ZjZ5UFQ1RnU0SFFZdm81eEsyYXBzQ0NESzExa0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE1DM3FrV0ZpU0ZYYkFseG9PMEl3aXFkM0I3N0NOYXJUWG1id0RCeEUrdjIy?=
 =?utf-8?B?ZFlPMjczU1FSY0hXazc2blZrWTdKWFBxT3pWRkJ5VE5UaWhIcCtEcGo0L09p?=
 =?utf-8?B?SFZMZGZwUXdBVXhuYkFJNkJZRW5EN3Y1QWdwRHBIbVM5cldOUXpCRi96eVJU?=
 =?utf-8?B?aVlJMXdnK2lnUHJWMERoUmliNE1SVGI5YXVpY0hvQ1I3cjVLZFNwYkwvRG1i?=
 =?utf-8?B?bEZ2UXE5MS9lSGtXcE9kWjVsVWRVRTBqb2VzRmo0Ym4wdWVmcDRxZWI1b1Rl?=
 =?utf-8?B?OTNsMjl3WXdMblZ0WVVWVm1adHN4Vmx0NHlJMDdsYmx1SFU3dURwUUJmWTlw?=
 =?utf-8?B?M25STUU3dUVJQ0Y0aG9DZW95cVB5NXlLdUx2N2lyaTN6ZTZ3MWFmRzdOUHdD?=
 =?utf-8?B?SGtRWWpoWEtxNmM3QzJIY3pPdit3L1VSMDRqams4L3djLzA1T0YybUIyQWZQ?=
 =?utf-8?B?SnRUbmpFWUIxeCsxYk9uRFBvV0JMRFF2UEFOZzhkRWJuZjhScEllaFVzVVRk?=
 =?utf-8?B?RXUyZ1puUlBSUCt3NWpPVWd5TTNwbmxjK0czZHlyaHNIMzloaUNFMHM0TllC?=
 =?utf-8?B?UC95T0JuaXpMa3NxdjMxODNnQ2NibVJmZW1NZ2xTb2lwNjJuTStsOW5tT3Zs?=
 =?utf-8?B?QVUxditzVDU0dVBrS09KUTJhSmJHck00Y3FMRzhod09rdXEvSHZWZ2FCbDJC?=
 =?utf-8?B?ZXBPelpvMWszb0hOMEZBMzZkQktRd1hHOFVPbXRKN1lRNHFORnRvS3o2b2hH?=
 =?utf-8?B?N1lkTnRZVGllai9STDE5UVRsVGUzV1lGSVQrZnp3M2RkeFk4QldUKzBLTy9U?=
 =?utf-8?B?SGlpWWpMb25Pb1djL1ZMeFFaYjROeGQ4STNleFk3SjBSYTdTTzNmUE5ZblJp?=
 =?utf-8?B?dGJpTDdWQUpaMThhbFVESTBsVTk2eGpqeS8zQTkydTRMc1liMVJ2WTB4ejc3?=
 =?utf-8?B?Si9QL3dHOXVLTkdFL3ZRSUUzMlVYQkY2eVRvQS9mU2IyMFFncFVMaTNTbWFv?=
 =?utf-8?B?SjdjaXI4RHNKWnhnVm9TMjNkLzJxb1pqRlI2bmJaOXJLWU1tZi94c1FlVEZF?=
 =?utf-8?B?Z2d1YVlLMHdVZmtnZWZ5QXJXeE83L0M1WlpNaWVRallkYTNNS0xSenlpZlJy?=
 =?utf-8?B?SUNERXpqSVBJWWVobDEwTFR1aUZpZm5wZjFCSzlTV0dhVDVRbVh3S1ZEWWts?=
 =?utf-8?B?elVZS0l6aVVvZUNwYTRJRFRTWWs5a1JyZjRqMys5SzJwanR0ZmYveFBUT0hi?=
 =?utf-8?B?OXUzSUJpY3JucFBZdlNOcVpZODFyeFFsRFBwajhDOWE0aHJXKzR0M3lkeWV0?=
 =?utf-8?B?Zk5DaGhvc0U5Zm9IY25lMlJRSEFCZXlSd3dvRHVwNVR4Z1JBekFHbi9wdGlv?=
 =?utf-8?B?RWpkMzhJTjB6ZFgxV01raCtiOVVYdFY3ejErOUdKVUxlWW9TT0ZwMzh4M2tY?=
 =?utf-8?B?MEVvK2ljaEd2anZzeTlaT2lQUjU4TmUrNnBwdy9PRE9jWTFBMGlqSlo4eks4?=
 =?utf-8?B?R2FESnhRK3Y4Tml4MUZCNHJqSkJTbW1jMmVnU2trblk1djhEZmtRdVVXdWpV?=
 =?utf-8?B?bFRuUDZ3aXAxck5lUGc0R3VPdXpyQXR3dG9obGR1Z2ErT0FNUE92WjcvYWoy?=
 =?utf-8?B?R1VPZlFCTkNjdWVUMjNEZ2EzaWFJa01BL1BZZlk1L045V0VIMHRvWUI0ZElv?=
 =?utf-8?B?eUNUekR3blR3TUVBUVJ0WHAxVU9adkk3diszdUdPYm8weE5vZkxlZCsvTktR?=
 =?utf-8?B?eUlWeUN2Q2hkYjVUYWNjZUZRU2VORUNJekMyUFVLZk1XblJQK2FEZURqQUVi?=
 =?utf-8?B?K1JSbkpNcEdsMWxUUlJHYkpSN09XUCtacnVtT2N1Qkxqbkg1WWNKQjZrZGN6?=
 =?utf-8?B?OTRueXVWbmJadWQ5bWI1a0I5WnhlWm9HTGlud1dCL3NXOFpzYXAwNk1SeFB1?=
 =?utf-8?B?eHI3aWN2MFNYbmdhY0srN3c0ejYxb1BJQ0tJMXROZlRQVEU5WVVwMkxlMDhv?=
 =?utf-8?B?Rmk0b1NRU1FTUUJLUW8rdlVqbEtFYituVUZNaUtVYXNzU3dXSHdTVzQ5TllV?=
 =?utf-8?B?a0kzVkY2TlIrQjVMdHRaYXgxcjdMbndpaHluMzRYM2kzRTVyR1NzbzNSbUov?=
 =?utf-8?Q?dEPKMypa2cYZOEY94y2KbIErV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b805a6f-2090-4e8c-346c-08dda8a28f8d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 04:43:50.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMRG8G0UZbzNerCbsYoGK5W6FNE3TeruqHr1erc9bLdBypAKuZze9W3g4X0aR12zowPyB33xM78bJllMokempQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8876

On 10.06.25 21:36, C Smith wrote:
> I'm developing an RTDM driver and I'd like to printk() its name
> string. That used to be possible
> in using "name_string" in the rtdm_device struct from driver.h, but
> that is gone now.  Should I instead print rtdm_device->name?
> 

According to git, we never had a "name_string" anywhere in the code.

What kind of name are you looking for? The one used for named devices
under /dev/rtdm/? Then you can use that after rtdm_dev_register, yes.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
