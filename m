Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22561230D0D
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794642; cv=fail; b=Cdi9iaiWd2HIuq54iOg5XxmUb4jRWqOgykBebofGAfhewib6FxhP7uaQwUE2UcxDAKI6qrGPP1J8mUnETpunFQzuMlFQ+uYlm3ucC08C5KV3UwR6rBRCPLDSvD9Qa5Z6aWwieV8vO8CA/8UrId1BKHccAbEMokxINu6o4msa7dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794642; c=relaxed/simple;
	bh=KugHdhSDgS+g1Hql0nvqieSKSmsOvbhXx4f1Zzjt9MU=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=jvd6Y1ZQgYkd/4GF5mdqXnUJnpg26LIp5KapZiFUuAD1Cp6vwMRixjRxOgbVhHv8Lllq0jX3hOZzUMn4CFcSpu5BNRey1usAFIXCpRVlmC+PAr7QsNNIK/ijBhVcVxDiv9JC5ON+cdo6r5C9QFvDk2sUHD6tRiWotf+j93xtIv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jRKhZgUa; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jRKhZgUa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIFtlinkFICv8p1tip6jJL+hYGTvQpp2aSbUMNSS4hRboxvyb5lczfjkskPrpTMVhcahHv1uUpAvFo/QQBIC6pEMLPOCOeGXO+jciouSEDmxRnSLTJv7hoVSSs5oAOtM3ghvWt9xV/dcXe1jFOJIpr8SC622sKiCP+/EaMHfvhcfoQydbWeDu9LNrwu9tTRAvStBzwOiFL8/7e3CMM9s0GwDLUnFnefI4A6cD/asbQQ/2ZYVEr5LLcRgtcWsB/wGxtZVyI9LKTbaS2oXpFBoptvEtLGJV5F0xCf7yX+ksnScFoVWwFWJmS0MSFuWl2oIwGiogAf6veqhdWRdPY74Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTJVOy/c1T+N20EO0U2l2NHexaQobabthWunMYe5a3g=;
 b=YkxqDOpCXrWVelbIOEsLWQ5zxdRcWHiSnHzBkAhxkp5ZpyYD0h31rvJAy0dHSCTChkJprLP7hgmS1lQuW8gA+64je35DgdSvHGrBMCUF89RLNilna8/sta+ZGXvI0X4+6doGGIvWFohE7tpiQLcqYj31tHbc5iKINOKZ6w/3MqS+TnbUfrZSm9tZ6NZWcgNVmoj8xrW1eFUwEQxK1FS4Dni8vLHfgaSg7bOHyHgpfQ+BcN+RQIrSJOF0QFcmeFpFbbVVzPWlPo7tymP31rA7tadye9iIr2GrDQFCbn347u1RYa4SNjm9dnSnSYJfo2V5RhnvPgkDhMtz3ph8QrSMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTJVOy/c1T+N20EO0U2l2NHexaQobabthWunMYe5a3g=;
 b=jRKhZgUaXApG+SFTeu2OxnOs1+G5gC3E4o3/QdByfiLhollCLOameyDGwxHIpAE/ZshfawPU8SzIURqDMX6vx575w+2i2SauihlW2RLhBW7R9kVrjXaej7F9b19Q4FlXMQFgFJOoqL1ujB7FNIUsUqxzuTpAMwFttLsCIbZa2kdDeVxmVslLj1uqmNfvbSdDiioIG/igS2iQL+9L83fpS5aX9XGQ/qE5ludpZ53uWHyRFgF2LuohAA3zTEwOKXPWv67qHMtYBd8uxY0lQQbzbPCcvElRapABfckpZDmOIYBqK6btN0a2/JvHZMP2aZgyQhU49kliO9Y32t3ln6itjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 09:10:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 09:10:37 +0000
Message-ID: <342ef123-fd38-48d1-addc-23f15e2bfa84@siemens.com>
Date: Wed, 16 Apr 2025 11:10:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Fix detection of tags
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
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b995eca-8b54-4e2e-48fd-08dd7cc68d64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXQ5RGxjQjRjdnZOSjMzOEcyU2k3U1c5WE5vR1d6cGJrNm1ZcFZWVkhHZEIx?=
 =?utf-8?B?TGhVcnhWMWI0K0U0WSt3OUZESm9HYStEbWJFYmg3dkpqeURUZlZCcGZCVE5Q?=
 =?utf-8?B?NlNUWnNPei9CdGUrRDkvNEY2VW4yZmRSN3BmRGExMjR6WDRvZ05Vcnd0NjA4?=
 =?utf-8?B?RGZyVkJXM3FOZ09vSHFkcityVWN2QUVvT3ZFcFBTc3ZJZ0Z0Y2VmQys5M20y?=
 =?utf-8?B?bzJYd3I5NFRHejJYT0RBQTNmNGVDUVoyMjhqd0Rua1VGWU5kdy81cnQvWVF6?=
 =?utf-8?B?QW4rdnI0WDRBRENJOThYSFhsZGxxTGp6SkdPdi95ZTdqWFVBZ2ZFTWpnTVQz?=
 =?utf-8?B?QVFrRFhPdS9ONHhaZm8vMVdBNHlSV0FFQnJrb0FCNkZncFVCaDRFdEtHM2VY?=
 =?utf-8?B?OS9vVk1WT2lNN2N0WVhRR2ZpeHZwNU9lVWRhdWt1Z2o5NlFSYTZodzZic2xq?=
 =?utf-8?B?YmtMTWUvTnFEYXJXeG9IVmN5Mm15cXc3cGE1M0JtbkZZSXlCSG5VL2JtVTJ1?=
 =?utf-8?B?eHo5cDlMbmdlLyt2Sjl5RTZQSDc1QWFwbFFPMkpxekhCS2Z0cnFaVlJLc1U5?=
 =?utf-8?B?MzVERXczZGhrK09teFNOdEpZZWhTRmR6ZzJ3VjFvbW5ONG5kVFcvUElnNU1w?=
 =?utf-8?B?cDJrTlZ5b2FWOUhqSkRnWlNhVFMyTlhLSytzS2ZZQXpzTjAvaXlGN2VEYmJ6?=
 =?utf-8?B?aFByTG9SSW43MFEwb2QwOEFGOWRiUUFBRXVmSWdYMnRPaG5hTmJxNFAzMktj?=
 =?utf-8?B?cGIzM0svMlFocFhkK1hCckVCQ0ZoeUV5VURRczZiOEw0WGlycFZIVjAxaVVB?=
 =?utf-8?B?Zk9uTzhzTnJKSXgzckhsVi91cXd0Q0o4TXFac1pzQ3d2QWFEeWoyeUJwVTI5?=
 =?utf-8?B?bHRGeXhGTWlRaXV4cURLOGV2T3VtUXpGOGVlWmlRUTVVUlBEOUJuZ0RaK3Rv?=
 =?utf-8?B?ZUgxdC8zSndzSVNlTVlOTWV6WWJDWFBmQTFEbW5mZWRYUUFMT01CNGtSTUtD?=
 =?utf-8?B?RzJFdXk5MDZ5bUUzR3ZGRVNZMEVTbkMwYVRyS3N2TS91MGMvd29JdVZRYUdK?=
 =?utf-8?B?MUxIZWZPRnNTem5XVlJMSWx5dEY2czJ0M2J4b1ZLdWZOdkExeGFsU1dIbW5E?=
 =?utf-8?B?WmhjVmh4UnFqbE1OMnVQWGZQM2xzTEV0dmhWbVVDUnZnZXhNbGJRZmlCYU1Q?=
 =?utf-8?B?clREWVAzY3Q3MG91QWtCeTkrL1lTNjMrbzB4aE0vcnpGK2JGb2d1OEhnNFBK?=
 =?utf-8?B?TTAxdDg1d3F4cG95NkQvN0Y5ZUFPTFc0SC95enprcVQ5elQzbkdRdzREbHRX?=
 =?utf-8?B?NFNGMm13V1Zsblc5VTZnaFpYcGxwRzB6TWZUVjU0VTFUOElITTY2blNYUmsr?=
 =?utf-8?B?Zm5ONjhkc25yVWx6TEFJVmduWUhQWVZKT2tYVjlzaFFrSHVCWG9EeFV0NnNx?=
 =?utf-8?B?cHJNb2M3RVVLaWRkalM2dnZRVjVDNkRvUkNzMWtpRk1YS1Y2N0lFaFlFZmNy?=
 =?utf-8?B?cElaenZqSk5LaVFvb0VOWTBuS005cVYvZlVNWVF1NUJnWThCMnhqaGtWcWYy?=
 =?utf-8?B?RGhveFJ1Z1lQTDA5ZDNmMk4zcnMwd0tsYlNnQk5qL2tkK1hBOGs2d0JYN0NE?=
 =?utf-8?B?YkZmclY4RXk2YS8zZ0Mxa0R5M0lmMmgzMlY1cTA4TWN0NVV5YnduQzN1cEoz?=
 =?utf-8?B?U0RKYk5CWTdXRHNmZ3IrKzJaeWFvRWloWms2N1hENDRWMVRCRVNuL1liekJJ?=
 =?utf-8?B?SkgxWkxpY2tLQjNFYVFFK1NCanArNXdENHVGclBDYjkvUEk4Wk5mbWlVQWEw?=
 =?utf-8?B?NzBXc1NGWDhma3dUV1FmeXhsTFBsaHFQK2dBakF2d2VadWpWYXoyKzZZaVlL?=
 =?utf-8?B?cnczeU1PNHNycW5tR2VyUFFwN0tnNDVWejRzaE1mU0VKdTRoTlVqUndnVHhi?=
 =?utf-8?Q?jWtNScKG0aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnlQRGd3bnlhZUd1YVJOcGlteUszVzRwc05TbUluaURKcnRJNEgrMFdVVVF4?=
 =?utf-8?B?UkdSVHN1ZWg3d3daQ0FtN000NFNsbWNqbWpMOFJ5WG9mZDdiSHkxWWZBZFQw?=
 =?utf-8?B?TFIxb2l4VnRicnl0ei9yeHVYV2ZpWDdXazhENFY1eTVQMnp3LzIxVm91b2JD?=
 =?utf-8?B?dGJDSXVYU3NoZ3RvQUIwK21ZNGNMK1RrTUZaRHdFL2pJTTZNdDMwSDk1UmNH?=
 =?utf-8?B?OVRpV081SHhMSlY4S3BRekMyd0VLbkdiUmhQRmFZaXdJR0ZkZG9DR2NWVjFl?=
 =?utf-8?B?YzRnZTU4UW9DSW45MmFJYVdWc0NUN1p6bkgrcmVtRE5ldUxGeUVkSTh4VjZs?=
 =?utf-8?B?dDloYlR1amtpaHJHMHVsMXlrY0FydXVmOVpnZUo4dEVIYXcwV0lkcFdKK2R3?=
 =?utf-8?B?VmJjaERTYVhDZHNxdW9sVmxycTFrS2I0cUFHcXF4QUgxb3d1SjZySXgyaWM0?=
 =?utf-8?B?d2llTGNTYWtsdS9WOVhMTk1vemFRek1Qb09FekFZTHNucVNjcE5BbUtqYVlP?=
 =?utf-8?B?Y1ZYU1R2WVpLUG5sOW81RldxM2c2by9jc1p1MXhFaWFmSHFKL243dnpCR1F6?=
 =?utf-8?B?VzVVUEc5MEgxUnp6NGRXZTFBSXpIWkhidVEwMUE5U0xWUHFIUkxOdFFucU9z?=
 =?utf-8?B?WXR5c0JtTmFYN0RHSUVURUhSZGEya0x0MFNJNGkzaUlWc0F6STkrK1E5RG93?=
 =?utf-8?B?ajdaQmpnV2tPWXNyUkhxdG9ZbjFXcDV6NERGVnFMZi9aSFY4dDVaUFI2OUIz?=
 =?utf-8?B?YVltTGJCWmhuc3JYaEQ1MWVLR3ZLM0k0R0xrd2pNR09adUNTRXJkMkF3eDdO?=
 =?utf-8?B?MjFTSGcrbTk2Tmhsdnh3ZDFlb0pSekY2NzQ2RjczdFFDMlFTY215anhkTEdE?=
 =?utf-8?B?L3ZCY0RmVWZJLzU4UEZETVlTQkJhSFNtMmJoWHovdkZzUzJiOW9vN055NmZ4?=
 =?utf-8?B?WDRsUVZJZUVlU1JtSWZhdkd6RmFVM1kxZmZzVVdDLzVQVEt4eFVpSDJBeitu?=
 =?utf-8?B?ckNQdDRCKzZudXB4a2xieDBRSGVJRkkvY1pGd1ZmMnBMMkhLNlNLWGRXRFRS?=
 =?utf-8?B?Umh5aWJORWY1T0QxUHpMZFpDMzd1d0poK2RIa3ZuUHJhZUFIaU9mbS9Pckp0?=
 =?utf-8?B?QzdMd3RXNnZOT3ZrNXhFWVkvMVU2SVBJYUluQ0tiNzY3R2dpbytBbHFSQXI4?=
 =?utf-8?B?TnRRbHVMa2hhclByVngvL2VtZDFqeEZ4VmxRS2NNQ2hnK3VUNjdhTVBtZ3Z4?=
 =?utf-8?B?bmJ2eEJqOG5CMzVXWTA0Zy9EWlE2bkNySVpCa0FPOGNJZDZQVVFYOHk3cWdK?=
 =?utf-8?B?R3BjdnEwUDRIT2grMEkybzdrQ1VoZG8wYnpJNXBGWjFnTUhMN2NGYnQ3TlRS?=
 =?utf-8?B?Rk1DbXBhTlpCZHVROWk4d2RZSG5kMUd3Q1dXWE9IRVhodGtjbHlHWlZOUnJW?=
 =?utf-8?B?MitCTGJQa3EvYjVxeFZsWUNTTGFjdjRFSGV1endUWW1Vell1My9ZazlPZzNH?=
 =?utf-8?B?S2N4TUloWTBCZ1ZTbDBYeVp4WWExVEhvajl1RVRmamtOL2hSMkFGaXd1dG5D?=
 =?utf-8?B?dXhrOG0vVTF4aXp4WXM5c21ZamJWOHYzallEOTF2cVBhem5lTjZrSTg5ODla?=
 =?utf-8?B?UkwyRklXWkViMlhIajZjNW9KZjN3dGF3V2JVZkNTdjg1eGUyOXh4WGEwTWd5?=
 =?utf-8?B?NjZrS3REWWZmcGtSKzZBbkdKT1k0Z2w2M0xSVms0OUh1cFA3UThvbGFNbCtj?=
 =?utf-8?B?TTJieTJUQXhLZ2NSR1FUa1FIeDE0MTJUQWJoNFViRFIrUlRGTnJzUHJZN2Rz?=
 =?utf-8?B?TllhcHpESkd4bGxBemNaM1dQbEVnZ0tmRHhuWktOeXlzQlRJbDRlUjZjZmUy?=
 =?utf-8?B?R1d5MXJaU3REbVlJemZiOXVHZ3dxcXlQMHpNeWlHYzlnNll6ZG5tdGNzOUNP?=
 =?utf-8?B?NlA0azVWWHB3dFI1S3hkZlZhWi9VQzhIT3ppbGp1eGRUSDc2VTJpWVR0NkVU?=
 =?utf-8?B?YWlWSHFrcmF4QVRFRG5HdWt3Y1BVUTh4OVBKSkZHOTFRRG0yUEVHVEZ4UXdC?=
 =?utf-8?B?MkdOdU41N3FZRGU2czNNR1VnNGtPZkU5NThzTDBybnVpaUFuWjVTVVh3aEth?=
 =?utf-8?B?UFVkY3FLS1pqcnYrUGpBMXhkVi9aRkNnZGRYZlBpbkpZTXRwN2F4Tlp6MVVo?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b995eca-8b54-4e2e-48fd-08dd7cc68d64
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 09:10:37.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ymd30sIkEQYl5j0xp/z8USqVgnqeXMCC3YHFEElvraK3snZ4v4Lp65GdDPNTizmaesY22KtVk6aTasu+EGpNcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7914

From: Jan Kiszka <jan.kiszka@siemens.com>

Likely due to some changes in gitlab, we started to build taged releases
again, instead of just the corresponding commits. Fix that by adjusting
and simplifying the logic.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0bea8fc00b..82dcb437de 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -36,9 +36,7 @@ variables:
   tags:
     - build
   rules:
-    - if: $CI_COMMIT_BRANCH != "master"
-    - if: $CI_COMMIT_TAG
-      when: never
+    - if: '$CI_COMMIT_BRANCH != "master" && $CI_COMMIT_TAG == null'
   before_script:
     - apt update
     - ARCH_PACKAGES="PACKAGES_${ARCH}"
-- 
2.43.0
