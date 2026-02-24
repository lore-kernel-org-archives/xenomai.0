Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AB33AD9C
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958284; cv=fail; b=Ar0jc8xs1EwRRVKI05pvu4dnv1q/BN8scuiTWlBWm6rAUrXIsdrvgwiQmXSVUBRSAVaHff6mz/r1LAIxHBGsVI8B7IfQAJtKDvxqN2hT1XbikgOmt6mZyKlBssFqwxprryo6JuvGbaVd3d5+rCLeTVupHBqtpYdghlVlPhhfw3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958284; c=relaxed/simple;
	bh=/PbL1O2zgoI44by2dMdrNkoCedVJQjz4mnQFwi7jHw0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=MxnY0Z7r+Tsuj4HoUTZuAJ3kilgTFxRAQNhRP+wr0PD5Nkw9n9/drD+gtl/wswVFOSqQTNzkCXSiZM6DMeNeGy5ZKRSL2oAVwdOKXu/8l9TL26T7z9BNwrDNol445MJtpu9iprDqBtb3hgNuqTri+9ouzuoK84HO0yXtZY7wtK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jwOqUGmA; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jwOqUGmA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWajFXkpT+j2PE4F7tOY9P1CZYilHvNP3oaNMY3yd6qWbbSINr1zcVsNHq4PHPuJlezE02zn+1HZ5+f321MdAd5o0kUBXv6WNgpL1g6z1xcU5fDCfUbMqHPYzrt/z/as4PfJQOHN6U+leUjm5VOumkzsml8x8M4KH26U66n2mLCkcFARmTDk5FLj01Lfl8Wnk8Bzf7o69ZskvIqscL2H6NoS1BSmiphv6Kb6mQQg4aX5J8nI1urF18sNZLsR09yelOhDtV3nHXXBAsz39P9oCMNxTYahWuKVoJ5wpHGxNVm/XoOyjacdil4qgb/u7skjpL5gWDVHFG4zS98BsYtmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6V3xOjbJs9xiTHe50tPvliPd1x2jW/8DQg3JEjqBjc=;
 b=QVIJKTAWo0Qbxjs4aCUMudTXKD8W/UCxnXJtmvtv4xium2nj47onOOAYxNZ3GkDFhezhiU5/vpY/W+nNbUEPygsjMLLmgtYrx82+v+28Fxg5orOWH8h+pqAOXre0gzsykNMS3yBSstFZrsaTq2BKg4GV7TgENbx1I4GhAWu67BTDvYbGDHvJqUIhmkKxRZtAVIhik1apduNKlZ5Bz5W0doKGy7YDX2D7DY5iX1gGB2lOqRZPEMbNIyGwtJsO7ttNg2H4jiOK9XlmNA/fIWYDicPNsZMZvnvs8FgfRU2zOHxCNdveEwmZmxc6Gz1Fnhwyn0FdTjFiGqbxutOlKILLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6V3xOjbJs9xiTHe50tPvliPd1x2jW/8DQg3JEjqBjc=;
 b=jwOqUGmAkpl5NTMj0r6wUmVdsh4uVTRS3EEDefoDtrmQoMLGD/Z54ccg38/QhJAwCAIcBnZVmudmpPhX9VvrwPyrXt1S1SyHWYHF17x+TiHGxiym5i4XDe6j/VNeu5UWNCteGZxIatrsd6193UHi2Q3GH2etTaQ8Ig3IVwIoASY68q3tmHDIml8icpIeu5FaBF6p5SJc9gcRSyEY8C5OZEcX1gvR0FsZ5OSns1uY6mG7GRAdX/vYVKBMsOGF3NR7W4zQXnbYPdGb7eyYYVZ3PavZ7t1yDRNv/6ytiO6kgl+TX5OotXJQQHV3kqmoCUMH7GQ5LAAV9Q0/i8sZo761BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:38:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 18:38:00 +0000
Message-ID: <bed186f3-117d-4652-811d-0e1adf7d189a@siemens.com>
Date: Tue, 24 Feb 2026 19:37:56 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Define our trigger source for downstream
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
X-ClientProxiedBy: CH2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:610:57::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: c24677fb-8231-46f3-84d4-08de73d3d638
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWc0N0U3NXA3dEprRmFDdUwzS3VIbk1XTm5hdjBLV2lzWC9xVDhrMlRBdDh6?=
 =?utf-8?B?ZjhPeEppeHU2QnRnR1FZUE4yMndxNS9MSlErbk9JcFlyTmlzUDZGQytKaHBP?=
 =?utf-8?B?OEt2ZGM1NzBCTTJ6d2dxcysyRjVTQnBDbWJDemNENVZUeVFJWGZKRzR4OGUy?=
 =?utf-8?B?VWdsK0dZQjdYdzh0RHVwVWRsWjFnT1FQbkNSMy9JZDZVRnFTVHU5ZUM5L1dk?=
 =?utf-8?B?Z1piUlhzOVF1Z1lTMjQ1ZkV2S000Q0daRm9LbEpDOXZ1OGZqQWN2Q3REY1I1?=
 =?utf-8?B?bE1pRWQvYmtVTGNjYkhQM2Jaak9CZnZ6b2F1ajN4QVFlVWNRQVNJRFhwVDFM?=
 =?utf-8?B?WUw2VTJTMjk1dkJVQThqT2plRzVDRjJ3SGhicklJZE5QVVdQZnR3V2pLMkpq?=
 =?utf-8?B?ZTJxenFpVXJ1TmpKeDdaZ01LNnYyMjZBRTBVR0lqcGxOL21nUmpHblFMaHpK?=
 =?utf-8?B?a09sa2R3N0NHQ0JXdmUvTy9wd25UajNjY0pkbnlNYUVDZWp5Vkt6QjJ6YVZo?=
 =?utf-8?B?ajRxeHpzNC9EUWFYeURJbklkN2pGK0ZwdEVXdnB2ZzZWd0g2Y1BKTC9ZN0F5?=
 =?utf-8?B?dmhkQ0gyMTYveUMydzl0eVVoT3IwZGllWGxaazFkOWNjTlZheExnZm9ZMEtQ?=
 =?utf-8?B?cmdvMDJPdXpqaEhXQVZuelBYMFdZV3RPVEI0VU1xU290dUhRY3F3R3dZMXdO?=
 =?utf-8?B?RncydUE5eisrVFNDam91eEQ1cU1DdGVkalJlSzdOREU4MStuRW90ejBqajZr?=
 =?utf-8?B?Q2tDRmUxNTBCYmxHbTM1bGVKcC83M0dGQUROYlZXVXZYcVkvMTZFcml0cmZk?=
 =?utf-8?B?T0t6OWdWNnhHSkFNc0RrTTl4WVNhVlRaYWtvSDlDcE13SGZIRDlxMXRMQzlj?=
 =?utf-8?B?bjBNanBwYndTd0RvNnhtcDNSQTd1VXNKWHFtdGlXWHRKRXNmTXJsamVTRHk3?=
 =?utf-8?B?YzZ2QVdrWU1TWlVjb3plVW05UDJLRHBLQTNlVk1NZ0wwUExkdDJPQ0pjdXJE?=
 =?utf-8?B?OVp3OTJoM1JwNGR4Mm5ScExhYTlwZWg3WThzeGRHMlF3dlc1bnV0TzJmT1ZH?=
 =?utf-8?B?NWt1dGVZMDJ5dTZEN0phOGZtb0w4b3ZlNEUrWmIxVC8yZExRamkyL1RydlZn?=
 =?utf-8?B?WG1lazBZNzNpZm1rWjBWOUZyZHVObVBkdjRpRlRNRjF0cnNwYXdRZ0wveE0x?=
 =?utf-8?B?TmRlWmlHOHk4T1luNVhEYTdIRE54SEEzaFRGOUxaTDNHVzZEUEo2ZllqVkxh?=
 =?utf-8?B?WUlDdkRla2FxWEpqdGVMQ1FMVTY0WXQ0dDNFSGNIWFVDLzNFTDNFQjcrNmkz?=
 =?utf-8?B?SVJhaTcrOXlteGJmMnM2WHZkZFZQMlFUVSsrTDJad0J6ZldsR3djdFFsanFy?=
 =?utf-8?B?ZEFjUUtQQnNWM0FSei9ObS83SXFXVUsxYVVqdEIrbkZCTHFoUWdQbDNicjgx?=
 =?utf-8?B?djZrbUZKNTBPYyswcnhybWY4ODRReHVqcEIrRlpVTU9SS1JVekYydjd0RW1W?=
 =?utf-8?B?eFA4eHlxaXU5c2ozR1Q2cUZNOG5sd29LOEoyakMxNWx5c1BxUHBVYXNmNVA0?=
 =?utf-8?B?QktkYnA0dm1iMkwyc1dIN3BaQ0pyampLZEVGYlBQejJaaVZFRGhoZUJ4S1JT?=
 =?utf-8?B?OThxZC9XeERUdmc1UFBTTTRIcjRYeC9PZDM1anJTa21aSzBMQm1sMklwR1BK?=
 =?utf-8?B?WmZjMFlTVFVUcGxXUFYyVFJHdmRPa2JoSWNnY3ZhclVLWFRNam9yemdVcXhZ?=
 =?utf-8?B?M0s2OFRoUlQwQy83ZmIxME5MWHZEOEhBTERoTW9WMVVXbkErYy90ckltVXdV?=
 =?utf-8?B?eVZZRzc3dFVvb2hXZ3JEMkRyNUxud1JpK3JqL0FhMWRWUThKWjBVRHBDay9S?=
 =?utf-8?B?ZFI5eWNRcUdKQ1lFakhxWDVRT2tiVU5WSFR3UUZHZ0FqTUZLeTgySytPbEFi?=
 =?utf-8?B?dHF4T1VKcSttYVJoUnUxWE4ySUtLQy9xb0FVbll2OUJDcGxaRGRRYTgrNzA5?=
 =?utf-8?B?dHp5d0xEV0U3aVNCWjNMZFAzTkdFci9iMDVvY01XMVhVQnRTekkrL0xyM1Rk?=
 =?utf-8?B?K3VnbDZTeHFLR2JDRXdyR0lkQlY0ZnRJRG94MlYwSWR4ZWJNTzRNQVlRakhK?=
 =?utf-8?Q?yc+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXR5dU41OUJaeWd3MXRuV1BaUVlBUHBQRUZNQ0cya1dzVXg3Vmk1T3p3aGl0?=
 =?utf-8?B?MjdDbTVFVWYvaTBJVUZmUHZOZmtiY1dEWXdELzBWUUtOMVRYNCsyWlZGcDBV?=
 =?utf-8?B?aEFQalcvOEdpRk40OWc4N1ovT2EwRVI1M2duUGZkemgwSjJ3TUtBMEFYTUVm?=
 =?utf-8?B?SFdOSnl5WFZ5c3JVSGEvNjRlY3cxTVY5ZlBKUWtIUUZpdXk0UllFUFhxUWZV?=
 =?utf-8?B?aDFzcjdwWVJFVmRHL1JGNXBrOXVnbGthS0JScXFCMHpQdiswSlZEMDQ4NDdv?=
 =?utf-8?B?d3dZTVd3OFRvSXlqZG1hN3ZlVGtER3hHMDU1dnUydWxEd09YOHRib0liTjZt?=
 =?utf-8?B?dGlzT3Rka1Q5MnVMYm1OVmsxa3M1enNnYnkxNHVuakJQNTlpanIyS1JUOTVC?=
 =?utf-8?B?SFl5Y1pCTC92T24xb1JGYThOdGI3Zk9sWVJPelJNVEdDQ3E5RXEvQk9tK3Jp?=
 =?utf-8?B?Yk9vREF5dDV1QTAySi80c1FyMC9sZkMyanpIMW5aL0k2aWMrRkhzUUwreUl2?=
 =?utf-8?B?OG9pWXo2d3hWbjZJMjdRWHhxWjFsVXE2UnJ0T2t6VGJZRWc3cVpqclZBTVda?=
 =?utf-8?B?VkVTcXlmMytsNjZON2YrcWN0eU1UMGZzRTVTeUJKWnA2c253dG41aER6dXR4?=
 =?utf-8?B?SGpwT3VVakU3UWt0T09QQnRwVGNMRmwxTUVGVitISjNna3U1Ym56cHpMdXRD?=
 =?utf-8?B?RTQ1Y0VwTURvWUsxeCtBWGtqQzJsVEVvWmt6cHhMSExDNHBTcyttSEFDSUZu?=
 =?utf-8?B?UmdRa1pyZ2lRd0t0V2ZhUVlSQysrSWtlVENxejA1anJjaFFkTXZVMFJ0L3Mv?=
 =?utf-8?B?M3oyS0Fwa2lwSGR4ZHpMZ3VIeUFKU1pxSHVQT0J5NkNPanJUS2FQZTNlOU5Z?=
 =?utf-8?B?MTFoNU9qV1lPNndBWmVqMy9vYVFvLzdoR3VkeHA5Q1h0VHZORFltTktwT0gx?=
 =?utf-8?B?Qm45dmdzK281ZWxqQUtneFF4TkRNZnpNUkNUbW5kcmJsUk5MU1VGUEROV25x?=
 =?utf-8?B?bjZmSk94cCtnVnlTR0tDdkN4M2trQ1VENlJzVkZpdGFlaEl1WlF4bllQQTha?=
 =?utf-8?B?VDJlajBIQTNDK3NZS2p3N2R6ZlFZVm9WU0VuVmVnTk4xaXhhU0c1R0d3ZUMz?=
 =?utf-8?B?aDVWVDlsOTRWbUV3Tk9FWW8rRS9SVjZJWTRvdGVLK1R6aDNvZHBrVEJqVEtF?=
 =?utf-8?B?dis2QWJKUldXUmRMSEcyZlFWSC9YUUNHSEd2bWR1eGhCejRsbjRiUHh4TVhs?=
 =?utf-8?B?YjBGYnN6YlN2VEx1VnBpaFVhV0xTWGVpNE56TStJSDRVZXplMHU3ZC9PaGNM?=
 =?utf-8?B?WUFvMjQxejVLRmxTS2QrYTV2V3UrUjJCRG1weTRyT0dtTnYrMjRFZDZqRmlC?=
 =?utf-8?B?SnlFSUI3eXJQMlEzaDBPTTY3Y0luL3hCYU11Y2hNc1dEY3VpQ0Z5d0RMNnJQ?=
 =?utf-8?B?YlhaY0w2bVQza1pjNm8rak9XZ2k2OEVjYXFWVGxCT1Z6bTE4WkE5QlRPN3cx?=
 =?utf-8?B?OTVBeGtCSE9IT2VUaVJiMWFKbXYwNDlkM0poRWZERFk1Q0xiTVQ4b2xGSEF3?=
 =?utf-8?B?MnFwNTcxdWd6UXFrT283Z2NmdG9nZHJlaXI5OXMwOXlBQ25XRWlxNjZTZGlZ?=
 =?utf-8?B?NFFwZGZxZkl5TzIydGtSbGM4T2R5ZUxNdFQ4cFBJS0w2RzErKy94cG9KcG9l?=
 =?utf-8?B?QzBCRTdFanhSb1d5Q0x1aHQvd2FPeHlUT0U2S2dyVWJRVU5vY3cyNTBveHYz?=
 =?utf-8?B?enNxN0o4Zzc5bXBEbk5UaXRvRmFTZCs3a3ByS0xuamVpUEVCV2NObVRVRE1q?=
 =?utf-8?B?K0lUZG5QZUgxK3hHZWIzZ1lGdEwrYlpHeXRhY1BrdnoyYXU3Szh5UGxRT2xQ?=
 =?utf-8?B?UENrZGJNVGpSZkJ0RXllL3prdXB6WVB5N0hab2RlMTJreDNNRU9PN1JiYTZm?=
 =?utf-8?B?SVNQVlVXVGh6SFlMMGpXd2ZNcHpKWDNSeUo4TTBSdmR4TmpaRTdCMXRSMzhI?=
 =?utf-8?B?bmZUS3pQbHRkaVFsOVl4NjJuejhVdTVFcWxVd1htTUk5MUFGQURyczdHZUtv?=
 =?utf-8?B?OUVyeUd4ZE1icnp4cThuVWpuK01veHBDa3loa0kwNjZQUUNwcjREcUFxbkM2?=
 =?utf-8?B?T1RkVFUvbk82QW9QZUErYU1DMjRndGkwekFHV2gyWE1Tc052Nk5WSzgybW9U?=
 =?utf-8?B?V1JjVUNQOGovWHV3VmF5YXdIZS9XZUVnZEU2YVJqaEg5cDR1RUVSSGpPNmJ1?=
 =?utf-8?B?Vk5ua0VHK0tDdmU3eFRvaHlVS21BUkpiaHpzYTcySWNEeEdudDc2SHJxNDJS?=
 =?utf-8?B?NDhhbXJmWkllYkJiRWlaWE1NMUlCU1ZnV0ltc3ZISS9UWTV2Qk9TRUwxd3NF?=
 =?utf-8?Q?0nAJujoP8mqKdE9o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24677fb-8231-46f3-84d4-08de73d3d638
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:38:00.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00e5CCElhjtjb1fKmPUi26vkO3FPLwnMIEuHoERlzjYcOQLhzPnQFpQHuilhWubfKdXbftmLqeq7Elmjh64dcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7652

From: Jan Kiszka <jan.kiszka@siemens.com>

Will give downstream pipelines in xenomai-images a name that already
shows on the overview page where we are coming from and what is being
built.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 572e0990a3..4a605214df 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -270,6 +270,7 @@ trigger-xenomai-images:
   stage: test
   variables:
     ONLY_RUN: xenomai-3/${CI_COMMIT_BRANCH}
+    TRIGGER_SOURCE: xenomai-3/${CI_COMMIT_BRANCH}
   trigger:
     project: xenomai/xenomai-images
     branch: next
-- 
2.47.3
