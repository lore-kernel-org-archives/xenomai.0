Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2E3EB809
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497806; cv=fail; b=SM5KHfOErvJSf/FEa8zS6gxKJJ/k3FL3xO2VXH4LK/8OvxLx0rFBZS6opLig08l/h2L8H66ea+uGG6LWok0BtNawAdDJi6Fxq3QgvwxkqxHK/iDsvxnvUh0jLBL+fzl/r8zp78BN5WMUFyHyp3DT2c4RshbwMAXaI1OgtHgNg5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497806; c=relaxed/simple;
	bh=dRYg0GLWjp+TRjjW8pnTlGpcJeBNDynifLkvhdtT4h0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JjlgbMFXSB5QmeUG9cIf3DPRJk8A7vr0c9UHz+7mxnIirenDK22uugCBLfChZPqPXC05Uz57pMU95y1a/d7KeI35q9foRWRfbINLR8l+KpiDd1thPFnmHlQy4lqIBZYU2Mlw4BOySMc10azZavbz0zVaOqQFCBMIKTqWTcnDZoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jw9+Popj; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jw9+Popj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b782wmSCieEF5mi7r77EeQBjcdz3C3ESWkHrgyGk3b/YixrA+vryP3n0EZZTXRtoTIfVJyBkAxEvILN26mtoWUgDOgOp+lqAcQiT7r0BQAoIH0zGg/sKtMXV+UOjYyewl+z5djcVmLwoQZ0ALe33BUGX/mG5rbbMQoATDcr0wBoegLFsu4Xwj8U1mf1yGWDKQY1Og8y6PVXKG+S+dI6BdOoRKgyo/yBemPciHuSyo7/mdO1gIXKDxNcqTigQHohmjt4EDoP1eDCdlkQ+UK+0SOy3g29bynKAnSHNdIMP3JzEI95i7WuwYvr9sFfQpajnrcBrObK8smXVFDNDNqI1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUJBK+JBGb82Yyg5a/5N0EPdtmgHrrDUxZZGJE95504=;
 b=KxrGDyjDYo3/P6/rW9ZjVoJ/ZOYCT4F7KAEhj+myd4ZpQCYQ/g776nP1UH5wtaUwpDOtaE0v5BVk1+WLd6ggqkJ66G2Hx1Z6z4qOKmn/QQDCaH9qakpzegq/IZzWL1AiBIAXMufIqNcLhPsCdQQEKYVE7HSZtPjgVqTa8VFLYdrqDvu7S0OOBYk1Scrm5HsBglu5BT0PoQsXh63S2OUjIEuu4w2nXfnzfMBpTabJGctIMuRXjNq75LMf27+Line0RCmlEp4RDb2JgyK8MKNrSEV7TSJCfrwmIPAlnPwcWjN7HGhfs1O9jwLl4s/61o3TkREmBrazd886JhaWknuhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUJBK+JBGb82Yyg5a/5N0EPdtmgHrrDUxZZGJE95504=;
 b=jw9+PopjH1eL+z/jMyESbqwuIoDvCkgbjDSh1azMspWm7JgmXf3Qfylf4po/eJdZIzdrDqCzu0aBXbrK0Qec+T5xW/OR4ubC9KofFECUuL1oN3qrz+TYyJVjEOkJFX05/+JwUgf/8s3oo+PUF+DGKFxtnMV3Sd52PRg1MBARW/bFVZAibsDcKhcYf20i2h1kFi/wC9Dg/k5PCeYFSwLGEh2txBAcYen2HG8FwjVY4ZsEC/iyso5DBP1WeMJM20Rgx2eV2ezGCJa+y8Vou5KNd4ERPIDrwCGssRqYRVPrBS0xQIieTV9RRj7hq1Xs1lCxzFqSUM094DFqJM/b9Npiyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB9195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 08:03:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 08:03:16 +0000
Message-ID: <255484c0-7955-4bb3-b592-742d4fbd79ed@siemens.com>
Date: Wed, 8 Jul 2026 10:03:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting
 FIFO thread
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
 <38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
 <87cxxlbik5.fsf@xenomai.org> <87jyrta2c2.fsf@xenomai.org>
 <ef230925-f258-4cf5-9fc1-6426167fc819@siemens.com>
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
In-Reply-To: <ef230925-f258-4cf5-9fc1-6426167fc819@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: ee17af59-a7b2-45ab-e33f-08dedcc75de4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	OlTKm1vFTTnwADAmEM7v73I6mdbQ697nEO7KcHsMXDMIEUDMUbAjMjGYcRqwjxjC27bXtlrCi/Ef6cjhZlbvAWfl5G1kvWbJ9TLHAbV5jrd9kvK5MugtQLvry91SRPePNhCD1jiI6f4p5GN+W8zQvTYE3ITUnIyu0jl6k0Q+SRyY3iN3NJPV6xFpyEWdiYEppz8hhbHypy7UtGVV293cbBvGyAmaORLiLEfp/EkG0I2ygUptAZDoz1Tg2v64jG2BOuAiotnvLrNr5vPXmduKbC8C4xtHok8TUqT70MtPOHFdlkM25kjo5ldErbf2UxSQpLYzMTut5zt+gFdEEh2d1UUieyqyPJUIdsl9VjFjTMuKHVlq1COjFesnURIN2SiGmwsY51HYpYh3nPPvsBBERmGk5WJ44m/fTCAHYruuuNkpx8Sx20wbZy4YKTZT1VUUMv31Mojr3CzjaUBP8ClEJVEIMWbA3VUUYDwfF2twigAPDiQApAWdH0OMkifPPvaIk3oqzNibBh/oXOTOIehDP23617/uNKrHL9Nryd1abYKTrrZybsGzkDQHcEVzelshU1Lv3Hm4DXeLvNqN/jwIG/RRAbOxhDRKA3+IvtHEzpOcMGgNB6qN1/kUExMTDZr2n/Kto1l8hP80qi2lFLP6ptAzI48sb2fUadtQGrDPZ1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJZdndPbTZ2V1RXWFdjK3p3WURPa1ZtamdCazRTaC8xc21UVXNOSjE4TnJu?=
 =?utf-8?B?MDRkaHdtaFdsVUcxNmZPa3dRKzBTeHRTOW5rcXVIOWxyNFlRaTdtUHlEa2hh?=
 =?utf-8?B?dUI4ZXBUYU1pTWRIQi9CU0U3Wjh2WU90VTVaTyswN3Y3NitqOHVOL3pZUjVI?=
 =?utf-8?B?NlFXbVVYZzQvZENnS2VWcitYWkVRcU1oYVlKL0RDaTBOTTZSZW03RStGVkdB?=
 =?utf-8?B?OElMV2h4Q0I4bVY3SDlmSVFIUk1ReE4yQ2Y5dFd3YktJRU13amNMM2FpUng3?=
 =?utf-8?B?UHEyUnZzbXE4NUV4N1hhbEtyM2RibVJaLzY3VDF2WmtqRDQ5MWF5WFZSNHJ2?=
 =?utf-8?B?ZHQxdU9Vd0FBc045VVVtWkR3VXh4OEpMVlMzOUd0V3g2NUltZ2FTYmdreExI?=
 =?utf-8?B?NjNqaGFFZ3N2QWdEb29TRE4zaFRBdUVCZUdidDBYS0wyQk9qMFcwbkhJSG1v?=
 =?utf-8?B?TnNTYjdsUWs2dmFnbE9vZnU0am5Xb2RtZVVaT2FiVnFpNEh2YlZ5cTFQdzhO?=
 =?utf-8?B?dkVYRVVXZjZiSTN2cXF5ZjFTM1hOZ3hJRDdFNC9VTjRPeVhLcWM3bEhQTEpv?=
 =?utf-8?B?YmpUd0hoM0VmMEw5YVd5Z1JDRTlzZ0VyM0VTWWNCVkRna0w1NnNzN3RTM0cx?=
 =?utf-8?B?bm8wZkdCUkdOdU9PVTRNanFYVVlvUEJzcXpGRS92TGlDa0JiNGZDalpQMU5u?=
 =?utf-8?B?Si96TEpSbld2SHdxcFg3UXQ0TUJXWWE1bUR2aytCUnNmTy9ibDNXUTIxN09V?=
 =?utf-8?B?NU5wc2pvczVYVmtmSTBSZzkzQkZuVjNWL2FQQnBxeDNvNEw2QWQyV245SFdK?=
 =?utf-8?B?WWFDMTAwczNlWDJwSzYrUElrVEFIVzV3cUlQdjZ2YitaMzE5QStwa3ppSG9E?=
 =?utf-8?B?ZWtFVUlzRUFtek10ZFlncU45TC8zZEJxdUlFQ1h3YXpHbW04OUFaNW1vUUc0?=
 =?utf-8?B?VW83bjFsR2d5VVN3MUw3U1F5VFZwZXJZcVBmenhzdzlFMGRCdWJOYm5zTklh?=
 =?utf-8?B?bVhQYTExVUxoV2o0VUU0d3VNTDNwdGJmS3BUWnY1UUwwS250dEkyaVhkeG4v?=
 =?utf-8?B?MWx4Rm92N3F4elRXR21QemRJZ0FrTVpWVE42ck14SEZnU1BMbVhWcDBmWWYv?=
 =?utf-8?B?L3hKdjhWU2NTbGJmSU1uejZ5QmNRa3I2MnFWV1k4S3Z2ZWZzSm1IKzlrekc5?=
 =?utf-8?B?MGVjT3U2cU42VTlqVk42Z0VjeGExT1I3bThyS2kwWmlsS1Y5Rmc1T29kNkJy?=
 =?utf-8?B?OW95QkZvWHdjYjdzQ3RLQ3R2NnVHUkZxSmhMQS9UaHh2bXBwN1M4MEJDYWxq?=
 =?utf-8?B?OE4vZ05oR0ZwZEJncG4rSUNDRUZ1aFlwUlhoNjJCSE8vMXhUR1pEVFp3c3lB?=
 =?utf-8?B?djdXMEIzSmc1WTJBTXhhaXZaeHk2dnRqQ2RRUVp4LzZhb2VXelExcG42M2xV?=
 =?utf-8?B?OWVLQjAxQWRjclR4N0p5aXpScERHcmFyT09mNk96SHkvY1B1ak5qeFdnT0o1?=
 =?utf-8?B?VzlwaTJVZVJzYjhhanA4Y3Y1OHIwMEhVU1BwTFV1eVhUdE9wRnBoOGU2OWpL?=
 =?utf-8?B?Sk10VTlFTW9mOG9aY3hnWitmNEJJL0VmRkx0ZEJjblVibStXUjZPcTkvWUlx?=
 =?utf-8?B?TUhlRC9FRWJhd3lQOTNlaWdOWnJ5c3JLRlhPSTJySnYxYzNxeDVsV2RheS9y?=
 =?utf-8?B?QlI5bGI5WGgvOTFoOVNjMU1HckhiT1RLNk1iSzZHNWdvdlhMQ1hBeWp4Vk1m?=
 =?utf-8?B?b25ZZDVtOUhITnNKR3pyd09nWHdUVnhiTHpLZjdGNS9mWlNHMUZDUXpiT044?=
 =?utf-8?B?VkRONlVFSVg0U2h6NGpHYlJDMGNBc3hjaXBiNDR2cG42ODRMc3RmTWJGYStF?=
 =?utf-8?B?M1BoeXNDUXFPUW1lMkdGc0VWMVFsVWpjb24zNWYzTVdjeURPTGUxSUhGRzJK?=
 =?utf-8?B?NjhqRUFvQjJDYmkzUjM0cWo3ZjkrcWRXbWN4SmczTkt5NnZQRG1DSG1MdXND?=
 =?utf-8?B?L0piZy8xa0FNWCtZTVBjOEVydUhXZ0NNWUMxUlJCWGxqUmhSQVVMbTFWSTd4?=
 =?utf-8?B?elF2RG9LZXFkVVRKbm1Eb2JSaUkya2UzUEhObTg2YXZPdmNCQkxxK3BWSUg0?=
 =?utf-8?B?c2RIdUNtdEc2OTJIMXpxVFVneTM5Zm9HRmVndkpBMWxBakVsZ3VQMDQxeVBi?=
 =?utf-8?B?SWJUNjU2MGRITFUxd29mTFZwajU4cm1zdWo3RkJybkNzMUpkUlJSL2ZNR3Yz?=
 =?utf-8?B?RVRLdG1RWkdJdEhvTnIxK3prWmJZMmVTNWZVU0FxY2pTSElhbWxvTkcvWmpn?=
 =?utf-8?B?endOZ2h0MjZVTENBMUFiVWhua0hlNjhzdnQ0L3JOQ2FHbE1yVG4wZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee17af59-a7b2-45ab-e33f-08dedcc75de4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 08:03:16.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK4m1AbVGcMY9dAaAxS9SLr14BIz6URjG9iuGkOwayQlgWCrjF6G84ihBnYmnBGHFn7WYtJGCnoG0p6YgsMKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9195

On 20.06.26 14:40, Jan Kiszka wrote:
> On 20.06.26 13:17, Philippe Gerum wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Test that higher-prio SCHED_FIFO threads do not run on the bill of
>>>> SCHED_QUOTA threads and that their accounting is not otherwise
>>>> disturbed.
>>>>
>>>
>>> This patch introduced a regression when determining the accuracy of the
>>> policy with respect to allotting threads the expected runtime budget:
>>>
>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>>> sched-quota-accuracy: 494.0%
>>>
>>> The proper result would rather be close to the following:
>>>
>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>>> sched-quota-accuracy: 99.1%
>>
>> Ok, I guess the fact that the calibration process does not factor in the
>> disruptor explains the full breakage we have with the accounting now:
>>
>> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
>> picked CPU1 for execution
>> CPU1: calibrating: 893547 loops/sec
>> CPU1: new thread group #0, quota sum is 10%
>> CPU1: done quota_thread[0], count=150399
>> CPU1: done quota_thread[1], count=145636
>> CPU1: done quota_thread[2], count=141552
>> CPU1: 3 threads: cap=10%, effective=49.0%, disruption=49.6%
>> sched-quota-accuracy: 489.7%
>>
>> Which does not make any sense since the effective value should be capped
>> at 10% in the above case, compared to the nominal (full) report which
>> should be:
>>
>> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
>> picked CPU1 for execution
>> CPU1: calibrating: 899203 loops/sec
>> CPU1: new thread group #0, quota sum is 10%
>> CPU1: done quota_thread[0], count=26818
>> CPU1: done quota_thread[1], count=26709
>> CPU1: done quota_thread[2], count=35612
>> CPU1: 3 threads: cap=10%, effective=9.9%
>> sched-quota-accuracy: 99.1%
>>
>> Dropping this patch from the -next branch for now.
>>
> 
> I would rather recommend taking a trace and debugging the scheduler -
> this could very likely be remaining issue in the quota fix.
> 

What is the state of this? How can I reproduce the issue you saw? What
is specific to the target, what could also be seen over qemu[/kvm]?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
