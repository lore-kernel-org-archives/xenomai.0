Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FD339719
	for <xenomai@lists.linux.dev>; Wed,  2 Sep 2026 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337980; cv=fail; b=kWs9DI23eaPSQaKRQM61qXDuWiNzwZIalpM+ga0mS13f5VxqxuhWbgkuIn9yN0YUvnFKInXq2t5EJHHntza50OB/5RRPpz+cLW8tnZR9NmbtGR3jlHTpWk9n4fom0nAFhQzmNOON4sKYJegOUQ56tOGciNQor6dG7EPyiPvK9qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337980; c=relaxed/simple;
	bh=dG1vBCg9WdMXGCpFznzyK75j9NWjxDQiefYUmoe2epw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fpzsDj+ym4H4GInyEYB483Y6xzj8IWcU7tvZYYhRE/E9H3aM2FV3OGTtHyrMfW4uNkLlfh1kJFpnt9tibDRP7XRBt+vVscRpkauO97zuaj8iWdeKGISTbdGG2hGZnxnjwf/f9qMIb9UfrWX+55iG9sDfxWetPxi5KJ5P9qcslB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jqygqgfF; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jqygqgfF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpsGFlt7E/Dng80syd3OnlHlABoTOTLUUDf/cylEyj9fs6NnuELw7WzDQ68yDZRCWLBCQnrRctrtIAyHTSTL+SA/rFEqWjq+2Cf40nPTn7HyY56t2FSDP4ENZNS2RF2ukOXdMLrCTIBj5D5HAesqTjXdCjZI6R6gWKZ8WOqP1MN+YELtSsJf9UiAztKQ6439Dm4GnG3Bbm9yLUrJ0ElyFs00JlY1EeDdAaSfgJH90E9kA1BrXvXa2iVLAyoe5XioMFQHHIiGl6cHjyL7BeZUoTY+/cq/Ip7D5cAlWikeHVeYrqwktnhTnJzsoaITEpw+w3FLFr+DIr4rFhh3sJ3klA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHHrmWxRCIg/ghUX7PLnFUOv3iLpHvQ6WZImanSibp0=;
 b=D9ehHpmJySvVhwT6kR73o/sLzALokvJJNsPwimd2vlzgklp3+D5Pmym6zi39r9CiTSkwNY35zVIcTr3fkTqi8YIBy9eRZEbAK2M/SJdgB2W+OmZ5pik9l42w/Tqf6z+r9v7Q1e4kMUd88VCB6wMTgXuRTyNuQDJWyYKlScjGRDMKnWxBDBl5mafThz+FbE+F2q92Z3ZWMr2y6CyprQPyiwm6AOzOdApjDBex96oILHjxScWozYdw1jdWSw/Pr/1bqLKxXrmkM7CSftAmYVNFQI6Yp85vvhpTi93sgOyidhMXIBUb2cRqqmdIBFuEYYWDbWOBP3YKO+u9K4KUnPdv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHHrmWxRCIg/ghUX7PLnFUOv3iLpHvQ6WZImanSibp0=;
 b=jqygqgfFZEC/N58aTjFflfiRwARDTIUsF+Wof7sAC5BzgyApkkdV3pujWgcWy1guHlukxem+ynZg2KO7ZEp2CJmmjGSPq7P9yM3wFZdDfkncXvkPxknYiISS5BEwXK748ae38IPeM5yQO8+wj0DLlA/48CEu8sBirYvOWSGn2LM9HP2NqajSxvakRdDm+kZvVtu7oyvVP4Z8wP0wjYS0mQwlQqpyAbZYZc1kT7x7FYtUrYcYL1Rz4Fz/ESkuWl/STsUrtddwEOSQnJ+t8TZP7mpIfJ5/C9C5od0G5Reue/zbG1Fn87zi0uTNkGd0z2nW+VvaAXPgbt+Nogm0n51EdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:32:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:32:53 +0000
Message-ID: <f313d863-21c9-464f-9957-01dc111220de@siemens.com>
Date: Wed, 2 Sep 2026 10:32:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: dd keeps the CPU fully loaded
To: Yongxian Yao <yxianyao@126.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
 <5a675ae.2fa0.19927496712.Coremail.yxianyao@126.com>
 <f293b971-906c-41e2-a966-a39b65e1e587@siemens.com>
 <267d379d.51f8.199280f6d63.Coremail.yxianyao@126.com>
 <e0f650d2-95ce-469b-af87-25de450ef43e@siemens.com>
 <2f1eee02.4b46.1a060df1a66.Coremail.yxianyao@126.com>
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
In-Reply-To: <2f1eee02.4b46.1a060df1a66.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: df01cd03-5626-450f-54a3-08df08ccc84e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|6133799003|10067099003|4143699003|18002099003|55112099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uJBe6RntaqkHTYVmGLJPpPTBcx13QPqoQVKM1poorMCtRLHjs495p8mOQadiynKdT+0+PNJ/AWhabRhE/6M+0V/gTuCftvkbt6/wSAX16zXOofUTDt8AAUWF/dB3l4M01P7QS22zfrLdQsb8H3o75yQd4qQS83G86E9TXouYxSxBFJvNA3Q7cdOuqB0z83MONFcozI4ScnLXFRS2cJhhHFHlWRdipDwXbU3MExlnGSwEouokVz+jGNvlMUh4i1trEEA+7qkQLXxnsoIp6IAxO/UUrc3y2RUbMfFRVixjyzwDrqSMLk5hRugnksB7a5zWLVK8PETteM32ohe64kAJynjC0FSUvqpeysTgYx2Yd8yX1KbVWgG430O6ul0uT57DPzbwepkKjS8pOq/1H8RzvcK7xpAGbasLBng1d26GDdsHNdV4JVAtMKf9oWW5F4t4aBF/6L3e+KWDn6cNaohuHoeihRvh79lzcmD2nPp+LDWInvS/DlRh2+umIViT+dFmCwTJhLXpbZHZaoZixdUS03akj8I9PHc/ZH51Ln42wYt0uu51jRvhfXwNQJsfkwZTswINHsF8ahqcc7bO8/VM5KV1EXgdhQFDomOTdCMKAe+rgprGzhls0paXg3PT+6B9TgtHclXJlkjOEgKSVqo4v5hn/8psHb1srcL0K0LS26Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(6133799003)(10067099003)(4143699003)(18002099003)(55112099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RIZnZHbk01bFdGTW85a2UyMkUzakxqdmFZbXYxRnFMUDNFN1lKd25TQVBw?=
 =?utf-8?B?VXV5NjA2ODZmOWZwb0NXUUdjdHh2ZEc4SFl1QWJ1RTE5TTBORVVtOU1Sbnlk?=
 =?utf-8?B?eHhqRGl5S2VvUGllVVdtWVUvR1BlSEVFR29QcWM4S2JXL1pZcmdlTmlodk1m?=
 =?utf-8?B?MUJLckErN2RmQ3QyOUxmbmhaVFNROXF4cmtLZ1dzcmIzQXp1d2FJOGQ2MHVl?=
 =?utf-8?B?VXV0WSs1SzRLTnF0SjZzcW4zUGtVUDl3MW1xL25qdkZITmZFb1ZNVkNPeW1Q?=
 =?utf-8?B?SmNRbmtRMExnT3lob1gyNjZIUVRYcHFLbWhuaGo5V3hpeXZySEY4Rmo3Z1Vs?=
 =?utf-8?B?VVF0OTNNWC9XTitwOVJtMUkrUzhzQlJaY1FGUHpEY1c1aCt1MUFZdFhreXd5?=
 =?utf-8?B?WVg2M3ZSQkhYa0VUSWJoKzRIb3ZxY01QODBIczl0cWlFSVRnRlNDUmUveW5i?=
 =?utf-8?B?cnlCSE1KQTUyYjhNZnZVUEpmSU10Z3B2NVA1b3JxMWxNUENqYng1bjBRdzNS?=
 =?utf-8?B?UnhQKzRoL2d4ak1MNEVhU3YrTDZBU2w2anMyNUlOVFZkWmVTdlFrSmorbURw?=
 =?utf-8?B?ZzI2aEhOL3JnbkMyNVlnNTdtU0FHTVJQMHp0Q05jdVVWbWFvZ3lCeWxZREdp?=
 =?utf-8?B?emdKM25raG9WYUM4ZWFVQW9DbjNJcy9RRnE1NkhNK0hhZG9PbVFUa0lNN2xK?=
 =?utf-8?B?L3ZNR2pLZkJHdkFxRGNwZk1WbkRWcHp4UU9iNHhhM3pRNnR3VTU5RytOVUpV?=
 =?utf-8?B?a1pyZE11SWhBZTVlaVdKamVxalpEalViY3hqOUtyVnlPbmpGb1NTODhWcytO?=
 =?utf-8?B?NWR1UGd3NkxPNzNVWWs4QlQ1aG45T2w4ODI1eHl2Y0ZMTjN0MDlRSHVIZDFO?=
 =?utf-8?B?Z3h0c0ZuQ09zNFVaQUtFL3hpVkY0aTg3VVF2R2lzaFRCRTVyR0gvL09SRTUz?=
 =?utf-8?B?a1VnVHg3WnNUZFVXeWJqbGdMcWFRMG5XUjBLeUcyRE9nS2YwQTQ5dVpUclJM?=
 =?utf-8?B?ak8xT0htQXQwQS9WN1ZpQ21ONGdxYU0wT1BhUHF2WkxkNHRieW0xNTlIQjFi?=
 =?utf-8?B?TVZoRERWY2g3UTBDbmNUaExPQWlsVWFCbXNvN2NlZzhNckNsQXRicHd1cUdX?=
 =?utf-8?B?d3FmVHZMeldxMyt1UUNHN0tGTHVtMUZxRFdGSnozWFUwQUgwU0J0Y0xqc2tu?=
 =?utf-8?B?OStLVEdGdytGb3drbGVINVM5N0xQVFFuKzJ0MGYzdDFmTVpEU1BFTlJSbmcz?=
 =?utf-8?B?em9xcis0U3h4NWR4aDNCZ1BEY1h6UFl5QzcyUW9IYnR0aER6WVBMWDVobW1a?=
 =?utf-8?B?SmtoMjlPaVdoVW02ajB4dlBEclBsRDNqREJLa0pxb3JNS3NjaXhzYmp0ZXgx?=
 =?utf-8?B?ditZOHlCU2ZqRTVnR3RrREd0SlhESDNsejI4NUxPSUFnUzJtYjVxK3hrVDlS?=
 =?utf-8?B?QzBUWm83NWUrdWdPSDdWUm44ZHZZc3U5UWFvOTUyU0g5RzNqa0kxRVBQYmFq?=
 =?utf-8?B?djZlaW9WSzJybXFoemYrSTl6dkdyeXRCRWNYLythN2tQRTVPdWphaGc0Szlp?=
 =?utf-8?B?aTFuc2NvaHhNMUExUEptVjRpeFM0bjQybEVtb0piUDMzS2R5MnJBM09zRjBn?=
 =?utf-8?B?N2JSQVVXaThtTU9VeXEzS3daRnhVV2tEQWFEYWVUaEZ1WUY3T2ZrMW5sZUFS?=
 =?utf-8?B?SUhyUEdaMWs0eWZDR0M0cCtLbS9ibG1aTEhvd2xRQlZUK3M5VWZuYVhUKzJ3?=
 =?utf-8?B?VWNLd3B4QzlZRnF0WndoRzR6dDFDY2ZZNkNFUmNTR3EwcEhKdW5PaytwRUhP?=
 =?utf-8?B?bmVPYUxLU3l5QS9ZdXRYWnBQVTM5WUVhU3I3TWk0UDZ2V1ROeGM5dDJCMFQ2?=
 =?utf-8?B?aTc2alNWOFVjR2puQlE5bkNZK09DblRPZTVxSE1YR1Z5b1pnR2xTY25WZFRD?=
 =?utf-8?B?Zy9ENkFRSGpONVd0RmZ6WlFKbytla3JFaUE0YzBpMnk4ajZsaDlRVmNodkc1?=
 =?utf-8?B?RloyTnUySU1ySjdWWlRUV3UwMUJCUytnRUtRK2xJTy9LSjVwVWcvOGF5T0I5?=
 =?utf-8?B?Qlk3WmJCRzJ4bmFpc2x3OHE3VnhZL0FTdjBGekduWk9WSUREOFFPNkZiR2dn?=
 =?utf-8?B?UStCakJyUjZLWExuQ3BxeFdSWHdoZHJ3bE44N2ZnaVBNVE1nQnZqL3dlS2tW?=
 =?utf-8?B?QW1Zc1hnazdjaU5hM2lYRnZNZXBiSzZzMVJjOU55dUl1d0JEbWF6V0hNQStL?=
 =?utf-8?B?UGM1V21XNGFudjgzelhpTFl4SEg1cUJoRU9IV25KNlJVSnZ0QTNpMHRFcm94?=
 =?utf-8?B?eWFTQzVwa0c0N0dVZmhnc1VaV2IxVUdDNDFtK2F0alc2a2l4T0t3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df01cd03-5626-450f-54a3-08df08ccc84e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:32:53.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlqw41hHOVB+6nljxKqoWODnQtTdaxVb6ekAf8yGrA8xqC7+eBfh3YJpd5mz1EvYs0584hFKM64tYGagnt+8Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6121

On 02.09.26 08:47, Yongxian Yao wrote:
> 
> Hi，
> 
> When testing latency(latency -P 1 -p 100 -T 43200), use the dd command to fully load all CPU cores.
> 
> 1. bs=16M, the maximum delay exceeds 100 μs
> 
>     dd if=/dev/zero of=/dev/null bs=16M
> 
> RTT|  00:04:55  (periodic user-mode task, 100 us period, priority 1)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|        1.129|        7.108|       66.484|            1|         0 |      0.879 |     103.594
> RTD|        1.260|        7.294|       71.064|            1|         0 |      0.879 |     103.594
> RTD|        1.187|        7.015|       58.703|            1|         0 |      0.879 |     103.594
> RTD|        1.103|        6.909|       57.830|            1|         0 |      0.879 |     103.594
> 
> 2. bs=1M, the maximum delay is less than 10 μs.
>     dd if=/dev/zero of=/dev/null bs=1M
> 
> RTT|  01:40:28  (periodic user-mode task, 100 us period, priority 1)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|        1.415|        1.753|         2.125|            0|          0|        0.856|        6.255
> RTD|        1.465|        1.756|         2.533|            0|          0|        0.856|        6.255
> RTD|        1.417|        1.751|         2.163|            0|          0|        0.856|        6.255
> RTD|        1.432|        1.752|         2.179|            0|          0|        0.856|        6.255
> 
> Why is there such a big difference?
> 

Caching effects, IRQ-off sections und I/O load, possibly magnified by
unfortunate configurations (forgotten debug switches?), but likely not
by factors. What is your target hardware.

Jan

PS: Please start new topic in new email threads, rather than replying to
older ones.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
