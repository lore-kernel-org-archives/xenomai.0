Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE521862A2
	for <xenomai@lists.linux.dev>; Mon, 15 Jul 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038835; cv=fail; b=OPFo+MITyZEA4OjxMgnZur6j3sjrUzM95N6Gi8POsptPWIzuGvb0Cq82KMHGVp598cc5hLuVLBGJKyCx10KBGL4vtVJflPTfDXJsikIdh3JAqcHHsmhh28i3r0BytYw05feuT81voyowhr8I0Al93/KtyBhcwJ8og6Cqxo/dPBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038835; c=relaxed/simple;
	bh=VQpgWg3zk5cRmfmSEXeOFnlS1m+goXPChBAJsOo/lHY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOqARzPPEz/M1IVgKYc2FxI9NnHJwvGMJAwxp343W4YUkEl6ilyUHXhTol0AQKJ6Bd/TqAoqyk01S20s++XN95x5Y7NkdTfd2uDSGZgTJ6A5PY1OIGpmTE89hkQQIM0va1A3V5KEFZyl8+Iaqh1ll+FPGC9wcT2RcmtMUUKV5XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AUCZcvWQ; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AUCZcvWQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0pE2vTokX0ChY8+YW34yKCLKSuVK+l2ZYzWnLCUzceEwG59HvoYv9gesa35Zbzl2nVuOkS0+OdSaj3n9OCeLdJl4KMZ8knWBUkQrtql4IlLUN0YhyPPEQk+NzSW8AhtCG4sG8BzSZZByl/TB4wCBIuOdsVkEPxHxO42LsXyYpfpC5gg5ASNe727Arnpxx09QD9b+6s+9HXAyw8Vf6A2epE9BcV9fK1aZiEZsLDkycTTv4lbJGmgQ/WNQcuW3KvSq/9TVG1NR9hhri7HkpKIyh4BLs/GkYXb55IFjFvkiADg/CUjFmvrbSfgORulCi5V7wx4ti7jIi+5bToPp2Wu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3xZXvzIy0r26oTMPP0UI5haBLS023UxRhlOeowGq+M=;
 b=vJIUj0gIIQOMAV0oyP/7aoKFaSEuOXg9oBf6EnK+a73iyxVRH4RRmYkiC3Ff6H6DgvZbZY6geLt/2VVcfbLDVtNJ9S7L0VPltmy4vZZvMighJn7i+P85K69gk71iAyXEwoJB3CQlIRYVVLt1tyCvPx7ZkihXAmX9MUVFCQnUecRZJkLPyfcDro8tb1/Xdseg7j/m2BzYeBr5YHa4Ji5z9IzruhfAd7MoJw1sfjlT1AeZKHpnwMxZFrav6Fa9e5I2P9yZOXt4wekm2VPiLeu+nCshAfOR2I1G+xNWOwowph2fOcHlps4bDaREDoS5ICGFuQjxGDAhNhmh2Op2SxELTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3xZXvzIy0r26oTMPP0UI5haBLS023UxRhlOeowGq+M=;
 b=AUCZcvWQMvUN2+slN5A2SprUqtk+yDaTwGbmM2w5Tl4MA6JD4+Ym8W8aeO83/C/gznIcwZTm5mz0jt0kcZXa7HnUmkwMuRoAMV9gBl7myEnCLmSC+Ng813HSEjnRYdsDnPuXglffr74QK2YDNr3xvewUd7tPM5vaxCex7bM7jrlpyZdLk/rpTmcQSM4yI5utTrS0a4lUuih8rwzLulOAW8sSxB1r7sCgcbbs6xCbWGN3HOqREAPMXnq6w1DboGkzj3KHWikZqd2uvg+rpKc//Hk1qWewc0WW/8gfl/BAs9zOVO1hI1nIwmhylM3GljUDmMStBN22Bks1tCKaRVCpdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8435.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:419::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 10:20:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 10:20:27 +0000
Message-ID: <1adb6804-7db5-475f-99ed-21487f67fea5@siemens.com>
Date: Mon, 15 Jul 2024 12:20:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/33] drivers: Fix missing printk log levels, remove
 rtdm_printk()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
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
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8532be-3310-47c6-f1b9-08dca4b7bf5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0xuM3lnRExQSW1kMXhiRWNpWjdSRmtuNHRQN0JoaGN4T2pMZEhUK3FXbXRX?=
 =?utf-8?B?bW9LSnJBdW14aXg0QnRYNE5FUG1xZmRvNERqM1FhWS9MdnNnMkF1Y1V2cUZW?=
 =?utf-8?B?VHpZN3UvSkI5Z3pqZGJNTG1SeU9HaG5sa0hvVTJFQzhXRThCZWpValpzWXkr?=
 =?utf-8?B?dHRlSnVFQVh0WjA3dnBOZ2F2dEdTcHVDWHFFZ1FVQjcxSGhScXZ1Z1dNZFFx?=
 =?utf-8?B?SFdNSUNINjBGM1Q5WkVIbVRGbWljMnpIMk9iV3BjeEwyOWFVNHZKU1FMTkJI?=
 =?utf-8?B?Qm9KNXg0c0ljejVFaklaT0lodzY5aWFmYkNDd1pERlA4aWFYZ3FCUE91NGpq?=
 =?utf-8?B?V3dqTnI4T0RYZkVFU1Y1ZGt1cks3ZmVGMHVPTzZwNXBudFRGOWYrM28rK1c4?=
 =?utf-8?B?SWt1Y2NvTHR6eGhTaVl2dW1DUTZ3bzdOK1g3Vm8ydkdvT3dCdW5obzNkVVlO?=
 =?utf-8?B?MXhDRWp5Wjcrc1YreldGVG9QZ3c3dXZrbFBRTlZ5T1hmUUxqaGF5bDg4eGdy?=
 =?utf-8?B?UmxvZkZ4Y1dwa0ZYVlA0Y09YR3NlUmR2RmxXYk5SbUYyVHMvOVFxVW55U3Vj?=
 =?utf-8?B?d0lJS1pKd3pycWQ4alJTNnFHK1Q1RlhRTk94NDAvb2lTcGdHUHRBbFQ1N1FR?=
 =?utf-8?B?ZkovaDdmZjh1bUdEUFo0SE0wYjlpU3NQZmQrakFKMG9HeVdlVFdmazFxUjBl?=
 =?utf-8?B?ZldIUHFRQXRmSVhlMXlkUnFVZUQ1WTlCUnFFUGpYZnEzSjlLK0haMnJJUTZG?=
 =?utf-8?B?SVJRK24rL3dGazNwcW9FUDFrc3RvUGN2VGJDakhsb1hoTXd5UnZtR1MwTGZz?=
 =?utf-8?B?Y3J2Uk1ZZWExVHoxRjBwQURTaXJpbnZ4UDVmTUthajJQN3Y3Z0grclRzcmhw?=
 =?utf-8?B?cCsxdEVwQ0l5MnBnTE42VEFISmk0UFRvckhGc1NmQ3dReGJsaWNjSFFFTkpo?=
 =?utf-8?B?RkdUR1NjUVl0QWltTkt0OTN0R08wY3VHNWZBbE82SG11Q1hTM2VtR3VPdU4x?=
 =?utf-8?B?NDRxSk9JcWliVStKVzVPTm42VUJySDVlb0NseU8rdUlDWHhZbGJ0VHJSY0c0?=
 =?utf-8?B?NUpXeHBqYUxPUmpEQzhsNzlLbzFMOCtpV1ZqVk1zTEZ0UklNTitjdWdBU2s0?=
 =?utf-8?B?YlJ4MUdaSXozVzR1OFlxYWp6T3ZNMDUzajU4NW5ZMFhkVDcyV1NHbllJOGIv?=
 =?utf-8?B?VVpQblVQQm5McHNmK3UzUWtLUm9QSERYYW94OUx5Z2FxT2dDWVdOejdvYTJF?=
 =?utf-8?B?OUhpeUp4ajZqKzNhWVZKTEZLYnFrNWhOUTJMNUJrcnRDMW1LMUJQbmxGZnU1?=
 =?utf-8?B?ei9YU1RuSDBoZTdBL2hoblBGOXMzSk5rdHFWSnlEOVRlaytqYkZ1a3dHZ0ZO?=
 =?utf-8?B?b0N3Umh3MENqczFMTjh1QWttZGJQUXVidUV3RWpkWjFWSFlLc0JxTVB3dEN4?=
 =?utf-8?B?amJZZk1YSXRObGZ2YS9hdG0vcVhIUU9LNDV1MENmUEs5RkJJNFdzS0QweitK?=
 =?utf-8?B?MzUzTUs1elBBQ0VLdUxZdmtkODBGMG00VjZtc3haWXFxbHRQNGFYQWlxbjRK?=
 =?utf-8?B?ZlhPQXR3OXZmQ25uTzBHNXJPQ09TdzN0bkFKNkxDdmZSWkdGNGNVRmEzcEt4?=
 =?utf-8?B?Y3FCZ3kwMmp5aXlzNU1EdzI1V29qQzg4dG1zLzRUcWVaeTlFNHVPNjE5SmpX?=
 =?utf-8?B?L3JZU2ZvNlY5bml0VVlQVkFxSmw2a1d2S2dEeFN5c25qeHh3VHk4OUtMenla?=
 =?utf-8?Q?0w7QkqvHNSc05Q08aY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEhsMXd3dFRUdXB3aUc0UjZaNlFhaDRHLzhmQVVuQkNuRWdOdW9rMHN5bE0v?=
 =?utf-8?B?ZVllcmFCZlQ2M3pnUjZVU3lxZWlWaFJuVUZXV0lvY1FSZnduT1RFWElvdGk4?=
 =?utf-8?B?R1hQMGtYV0hieDV1NUJML2I0QnJGZ29GaUJHSGszeEMxSFMvYkpHdGhHdkc5?=
 =?utf-8?B?Tld2Nm5RM0h4VDI1azZ3K0xqTHNRRG1BeVJVWXZ1eTdyRGY4SjNPb0pTM2lu?=
 =?utf-8?B?VUNJellKS0pXSWthMnM4by92eW0rNDRrVUZkWDZDbTBaN0gyV2d0TXJad2NI?=
 =?utf-8?B?dmtraHBteFRFU0g3ZmQ5b2pVazFBVHozZVJKTW1NZjdyK0F2UkNZNzJtOGth?=
 =?utf-8?B?ZmYwZEgrc0s4bnJpZkZyWWl5SzcxTFdRN0N6UUxhTnBTNEdUb2ZyQURvVE9i?=
 =?utf-8?B?VGtBa3JaejFVcWtkcm5jN1F2TkxTSTAvc0lGRUp5NXFxWmQvMFFrSXJFZlov?=
 =?utf-8?B?ZnNKWXZkdjY5QTFkdWpxeDRUYWp6NTdCckZFR2UzYmZpQ2NnSDBnOXFCS3JX?=
 =?utf-8?B?VFlqcC9UTTBGSlVQUm5RRGsyZWJWSGNKM21vVlp4aWsrS2RxSnhVczVnYWdB?=
 =?utf-8?B?L1o4WldFc3IxbURqMWhJaElXWGRwQVJYUGNrWHp2OHliTEpSUllFZFg1c0VB?=
 =?utf-8?B?a3pQQjFiVlJjemhkMDZMVWFabHUxRWZlRVJqMmVvRVZIaHV1UmFnV1lrU0dB?=
 =?utf-8?B?YzNIckhHTjlVREhMc3VRanJuNzBWTlg0dzFhTm5LV0ovYmhiR29zYUtaTWI3?=
 =?utf-8?B?cDlINldGQnFvYlRIWnA4SUltYkJzTEpER3dvQmVoVGhKbG9JYm44RmVmNW1z?=
 =?utf-8?B?VTRUNnVGKy9HU3hBYWpCS1loMndTMWxmZzRQeDF5aTBKYmZrODZzaktYWld3?=
 =?utf-8?B?VkgyUk9xbGluK3RUSy8rL25CTjBURTFWNDZZcEdiOXpYK2pWSUxSMDgzak5n?=
 =?utf-8?B?S214UHZuNkhwM05TeVU3UFc0V08zTDZBd21QTExXcUp3VWx2UVBmdUpPMXJq?=
 =?utf-8?B?UEJmcXRRMjB1UjVsV3Z1RDMzeGY5YitlRXpmSUtlT0ludmtCQ2EvQlpWUmFX?=
 =?utf-8?B?K01XTU9KVU4xcU1tZXFVZ2hkSkZJOXIyTWlGMkRxZjVXWDJkdG9zN1BlT1Ns?=
 =?utf-8?B?c1BDOGk0S3k5VmFUdzQzVHY4TVJ3SlV0MnJ3QXNvSkpUSkg0aGdiUCtra1Zj?=
 =?utf-8?B?cFlYMlJyYVFvNWNMam1rTHU3bGRqOURpWjlTcHArS0NuY1QxWnBBMUhrbDAy?=
 =?utf-8?B?OWlnQ3kzWHkrbUxFcnlTekN0eUc4VUh2WHhza2VyWElQTVBPakp2eEkyNDMv?=
 =?utf-8?B?RzFXSmh3RHI0MEZDRlpNQWRJb0JDajQ1OG9zbEk1bEZqNk1KbGZjUS8vbzJH?=
 =?utf-8?B?YVZBY0Z2UW5hVlEzdzBKcThabjd0WWFDZ2tPTnR3Qlh2VUtHdnpzUGJEazha?=
 =?utf-8?B?bkErVVA1bGM0SDJjS256SDdtQk9hWTQ1RzFLU3FaNlY2VXovbmx2RWgzRGlK?=
 =?utf-8?B?WS9ZV1dra0tURStzQ05kUlBWdjIzQ3BYK3FqN2E5VDdyNnYvSmg4Zk80dGtT?=
 =?utf-8?B?Tkp2aGtUbmt2eHUrRHVCZ29uTU5XRWMyQ0Y1NlkvMVBlMWFGcVphYmZIVFpt?=
 =?utf-8?B?b1pXU2k0K0hiTTRreGtadUtxSStGdndqaFJqVDBCSXpub2NXK0lSU0s4ekNY?=
 =?utf-8?B?R2hyRHRZOGVmMmQ3WWppanZZYUpESnJYM0F3aEZ0K0Yva2ZjaTZqMkRVRFYz?=
 =?utf-8?B?MGJXZldxYWxiaFN5L000ejJZV1I0aVh0RGJBMWQxN3R5UFZQMzBSWlFPRDBL?=
 =?utf-8?B?a3liem1OalhDSlhyTm9OOSs5SnB2K2p6V1UxdTgyVTg3NEVnUVk1dXY4cWNX?=
 =?utf-8?B?SVJlcGFOcy9CQ01iTEUvT1hjZElTRlZVR1lLMnZuY0F5Rml0NmpLR0JObVM2?=
 =?utf-8?B?VGp5U2trbjlYYXRRRVJvc0J1WEN0Q2VtckZNVFdTOGNtYmtiREw0QkppYlZn?=
 =?utf-8?B?M2lCeVNJY0U3RlFpTHl4amtVenp5eVZSVmh0WCtNVzdNRnNQRmNYRGtuY29N?=
 =?utf-8?B?ejIvQlJPVVVlS0NtVldacTFNNHJiZnlNVk1jQkhESmdhSDZ1cE9sbGpYeHFO?=
 =?utf-8?B?R0w3SmhWbHNvTGZRdlhBYnN6YWdNZ0J1V2pIc0lmRkpTcVAxMEIzcXRjb1NS?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8532be-3310-47c6-f1b9-08dca4b7bf5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 10:20:27.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arEEWiioZCxAuc3YbgvcOvC0F2DYFdyuOrNBCfl+F2m4V9jVRtA3hMs+sDiXHBHuf8fh3USrx11xtSchmS3bKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8435

On 12.07.24 12:48, Florian Bezdeka wrote:
> Hi all,
> 
> some background first:
> 
> It happened several times now that logs produced by CI runs contained
> important warnings (or any log level above) but the actual test run was
> still marked as success.
> 
> The idea is to add something like a "dmesg check" script to the CI
> infrastructure that basically fails the CI run if anything above Warning
> (or any other defined log level) is detected.
> 
> That requries us to get "warn free". The problem: The default value of
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT is 4, which means WARNING. So whenever 
> someone calls printk() without any log level it will generate a warning.
> 
> This series revisits all of our printk() calls, making sure we use the
> correct log level. Especially printing version information is no longer
> producing warnings.
> 
> As most printk() calls reside in drivers there is another point that is
> addressed now: Migrate away from rtdm_printk(). This function will be
> removed at the end. rtmd_printk() was only a wrapper for printk(). We
> can remove this wrapper and migrate to the "modern" pr_*()
> infrastructure.
> 
> With that series applied we are closer to the "warn free" goal, but not
> there yet. Some remaining "warnings" have to be addressed upstream while
> others might not go away in all of our test scenarios. Some filtering
> might be necessary... We might find some inspiration at the kernel CI
> project.
> 
> This series is compile tested only, no runtime tests could be performed
> on my side. I don't have the necessary hardware at hand.
> 
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Patch descriptions: Remove the "no functional change" statements
> - Patch 3: Apply the same pattern twice (review comment from Jan)
> - Patch 27: Additionally remove ERRMSG markers (review comment Jan)
> - Patch 28: Additionally remove ERRMSG markers
> - Patch 29: Additionally remove ERRMSG markers
> - Patch 29: Additionally remove ERROR markers
> - Link to v1: https://lore.kernel.org/r/20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com
> 
> ---
> Florian Bezdeka (33):
>       cobalt/clock: Use xenomai specific log level
>       cobalt/x86: Add missing log level to printk()
>       drivers/analogy: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/serial: Migrate from printk() to pr_*()
>       drivers/can/peak_canfd: Migrate from rtdm_printk() to pr_*()
>       drivers/can/sja1000: Migrate from printk() to pr_*()
>       drivers/can: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/addons: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/e1000: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/e1000e: Migrate from printk() to pr_*()
>       drivers/experimental/e1000: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/experimental/rt2500: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/freescale: Add missing log levels of rtdm_printk_ratelimited()
>       drivers/tulip: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/8139too: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/eepro100: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/eth1394: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/natsemi: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/pcnet32: Migrate from printk() to pr_*()
>       drivers/r8169: Migrate from printk() to pr_*()
>       drivers/r8169: Remove RT_DBG_PRINT() macro
>       drivers/r8169: Remove DBG_PRINT() macro
>       drivers/r8169: Remove rt_assert() macro
>       drivers/r8169: Rework assert()
>       drivers/via-rhine: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/experimental/3c59x: Remove unused / broken driver
>       drivers/stack/ipv4: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/net/stack/rtcfg: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/stack/rtmac: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/stack/rtwlan: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/stack: Migrate from rtdm_printk() and printk() to pr_*()
>       drivers/spi: Migrate from printk() to pr_*()
>       cobalt/rtdm: Finally remove rtdm_printk()
> 
>  include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h  |   16 +-
>  include/cobalt/kernel/rtdm/driver.h                |    2 -
>  kernel/cobalt/arch/x86/c1e.c                       |    4 +-
>  kernel/cobalt/clock.c                              |    2 +-
>  kernel/cobalt/rtdm/drvlib.c                        |   13 -
>  .../analogy/national_instruments/mio_common.c      |    3 +
>  kernel/drivers/analogy/national_instruments/mite.c |   67 +-
>  .../drivers/analogy/national_instruments/ni_660x.c |    2 +
>  .../drivers/analogy/national_instruments/ni_mio.h  |    2 +-
>  .../drivers/analogy/national_instruments/ni_stc.h  |   19 +-
>  .../drivers/analogy/national_instruments/pcimio.c  |   21 +-
>  kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c   |   41 +-
>  kernel/drivers/can/rtcan_dev.c                     |   12 +-
>  kernel/drivers/can/rtcan_internal.h                |   14 +-
>  kernel/drivers/can/rtcan_module.c                  |   10 +-
>  kernel/drivers/can/rtcan_raw.c                     |    4 +-
>  kernel/drivers/can/rtcan_raw_filter.c              |    9 +-
>  kernel/drivers/can/rtcan_virt.c                    |   16 +-
>  kernel/drivers/can/sja1000/rtcan_adv_pci.c         |    4 +-
>  kernel/drivers/can/sja1000/rtcan_esd_pci.c         |   10 +-
>  kernel/drivers/can/sja1000/rtcan_isa.c             |    8 +-
>  kernel/drivers/can/sja1000/rtcan_ixxat_pci.c       |   17 +-
>  kernel/drivers/can/sja1000/rtcan_mem.c             |    8 +-
>  kernel/drivers/can/sja1000/rtcan_peak_dng.c        |   25 +-
>  kernel/drivers/can/sja1000/rtcan_peak_pci.c        |   22 +-
>  kernel/drivers/can/sja1000/rtcan_sja1000.c         |   25 +-
>  kernel/drivers/net/addons/cap.c                    |   22 +-
>  kernel/drivers/net/addons/proxy.c                  |   10 +-
>  kernel/drivers/net/doc/README.drvporting           |    3 +-
>  kernel/drivers/net/drivers/8139too.c               |   50 +-
>  kernel/drivers/net/drivers/e1000/e1000.h           |   16 +-
>  kernel/drivers/net/drivers/e1000/e1000_main.c      |   18 +-
>  kernel/drivers/net/drivers/e1000/e1000_osdep.h     |    2 +-
>  kernel/drivers/net/drivers/e1000e/netdev.c         |  205 +-
>  kernel/drivers/net/drivers/eepro100.c              |  235 +-
>  kernel/drivers/net/drivers/eth1394.c               |   83 +-
>  kernel/drivers/net/drivers/experimental/3c59x.c    | 2752 --------------------
>  kernel/drivers/net/drivers/experimental/Kconfig    |    4 -
>  kernel/drivers/net/drivers/experimental/Makefile   |    4 -
>  .../drivers/net/drivers/experimental/e1000/e1000.h |   14 +-
>  .../net/drivers/experimental/e1000/e1000_main.c    |   32 +-
>  .../net/drivers/experimental/rt2500/rt2500pci.c    |    4 +-
>  .../net/drivers/experimental/rt2500/rt2x00.h       |   37 +-
>  .../net/drivers/experimental/rt2500/rt2x00core.c   |    7 +-
>  kernel/drivers/net/drivers/freescale/fec_main.c    |    8 +-
>  kernel/drivers/net/drivers/natsemi.c               |  188 +-
>  kernel/drivers/net/drivers/pcnet32.c               |  136 +-
>  kernel/drivers/net/drivers/r8169.c                 |  219 +-
>  kernel/drivers/net/drivers/tulip/21142.c           |    6 +-
>  kernel/drivers/net/drivers/tulip/eeprom.c          |   22 +-
>  kernel/drivers/net/drivers/tulip/interrupt.c       |   42 +-
>  kernel/drivers/net/drivers/tulip/media.c           |   38 +-
>  kernel/drivers/net/drivers/tulip/pnic.c            |    4 +-
>  kernel/drivers/net/drivers/tulip/pnic2.c           |   14 +-
>  kernel/drivers/net/drivers/tulip/tulip_core.c      |   96 +-
>  kernel/drivers/net/drivers/via-rhine.c             |  184 +-
>  kernel/drivers/net/stack/include/rtcfg/rtcfg.h     |    5 +-
>  kernel/drivers/net/stack/include/rtmac/tdma/tdma.h |    9 -
>  kernel/drivers/net/stack/include/rtnet_internal.h  |    2 +-
>  kernel/drivers/net/stack/include/rtwlan.h          |   14 -
>  kernel/drivers/net/stack/ipv4/icmp.c               |   25 +-
>  kernel/drivers/net/stack/ipv4/ip_fragment.c        |   17 +-
>  kernel/drivers/net/stack/ipv4/ip_input.c           |    4 +-
>  kernel/drivers/net/stack/ipv4/protocol.c           |    4 +-
>  kernel/drivers/net/stack/ipv4/route.c              |   21 +-
>  kernel/drivers/net/stack/ipv4/tcp/tcp.c            |   62 +-
>  kernel/drivers/net/stack/ipv4/tcp/timerwheel.c     |    9 +-
>  kernel/drivers/net/stack/ipv4/udp/udp.c            |    4 +-
>  .../drivers/net/stack/rtcfg/rtcfg_client_event.c   |    5 +-
>  kernel/drivers/net/stack/rtcfg/rtcfg_module.c      |    6 +-
>  kernel/drivers/net/stack/rtcfg/rtcfg_proc.c        |    4 +-
>  kernel/drivers/net/stack/rtdev.c                   |   20 +-
>  .../drivers/net/stack/rtmac/nomac/nomac_module.c   |    6 +-
>  kernel/drivers/net/stack/rtmac/rtmac_disc.c        |   14 +-
>  kernel/drivers/net/stack/rtmac/rtmac_module.c      |    6 +-
>  kernel/drivers/net/stack/rtmac/rtmac_proc.c        |    4 +-
>  kernel/drivers/net/stack/rtmac/rtmac_proto.c       |    9 +-
>  kernel/drivers/net/stack/rtmac/rtmac_vnic.c        |    4 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c   |   10 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  |    7 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c   |   14 +-
>  kernel/drivers/net/stack/rtnet_chrdev.c            |    4 +-
>  kernel/drivers/net/stack/rtnet_module.c            |   10 +-
>  kernel/drivers/net/stack/rtskb.c                   |   13 +-
>  kernel/drivers/net/stack/rtwlan.c                  |    6 +-
>  kernel/drivers/net/stack/stack_mgr.c               |   10 +-
>  kernel/drivers/serial/mpc52xx_uart.c               |    9 +-
>  kernel/drivers/spi/spi-master.c                    |    2 +-
>  88 files changed, 1185 insertions(+), 3985 deletions(-)
> ---
> base-commit: 00454d5d127c29b93f8c0babf1336bfc35be3b98
> change-id: 20240702-flo-removal-of-rtdm_printk-b5320a2a2930
> 
> Best regards,

Thanks, applied to next. I just additionally removed the dead 3c59x
config switching from gitlab-ci.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

