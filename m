Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A219F48D
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515755; cv=fail; b=tJ3RIqXLLJ73VEcEkGpZTxr9GNqhOpgb+6hKxxIxBlvcZ7iDcZ64llUtG+ZWOLe1AzmmdVilzv15fpmmB5xKPju8d4uMzeWIMDfaUvo/0r8rMssmc8SE+pfStl/cma4ZoRqlEhGVGFYLJ/w8c9wsOSgEsdog0fAKitN/N+WUWb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515755; c=relaxed/simple;
	bh=g8Xfu/etul7NEvhUYJ6gx2g7TWUksoi9DS48N0KHD4g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DagQMjXeWkp4lNYCks6MRgxvGwMM/2dePd5tGqu/EAuhvKjGyxXQ4KkOaPsXIds4JcdpFNtmlmzqiu7TSfaDbPppOZL8lY8U36d0qk4vOHWngcwv9gDHVr11x4n4MNKrDrKS0lhDEGlc5lKN3D/C0PMRuRFh+4H8phbc1v0x4Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OVfpWYXk; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OVfpWYXk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGi0NnYk40HRZFmF0kwRxiVSIl4uZ55DOsTN2osj7/qz1mbSEe3cKdAnlLRqkTiLemj5bvhNSRYkp7enUuRLrhhTID4UvednP7bbKMCURuaDiF8BbPwmcWNCdVA3MlrmNVq0NO/p/dqqDTeBiBFItZmDcBis+LSYENORBkDW5uGwkSGaaTIWqz0FpRDyhavDhsICEK5nwg6s3GrOjeF0JxkfA03cymKBV/q+U+sBpcAjH5VMbCOz+H/LDj+nsCGL3wJ/U0ZtgSJOkiagVILJ2+kBD8zoN3MnayAM8/mi9uu6p+ea71rfGckBu0IugJRKLWHI3oZ3XWi2dhTvI3dJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGEMYTdB0Tqc9f06KNBSNp1ciHMeQ1iVitmzBjAgs7A=;
 b=HbrT6PL8j/f50KOGgIOnw+rpjVGuazu99RohfYjT4dVorVFsN6vtwKr11ItkhZzRG3/x7N9SHR6c72+YSb5I2iqmoN40ZBIXrNqlDgbkPnfe6RV4DyKPHc3Kaka9EPMwN85Yi8nlBHfHJ/BtHxXYsLTTn7SzXi8vCDN31l5EljHaFOZbN+gI6JFLekDNVryza0I/Ge620W+J+IJOI06B2C2n4WZar0a4La59KNRv+AhMjFnEAffmQ04Xu4Emya00vTMkbeFakOAte1CYwuBA5HinrYGITLcNb+kEVq0wpR7lCPP1uN6IfzRAIibqKmRFt1eI5ny4aluvJMPswi9U6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGEMYTdB0Tqc9f06KNBSNp1ciHMeQ1iVitmzBjAgs7A=;
 b=OVfpWYXk9rkfPYqvDIspNUezYTE9v2tneFQaed7EYe+Amley3bHdzx5bbzh+a+UhqNwbPZnGj6rRbpS4atp4noD5HArDTLyp++aFMf4l0oY0QwxdfsIT/K+5+xX9r/Mi8MMLcVrwr1psn5kGS3AiiA74XktbeT4QAYP/bWZFebMeX9ZhwV177r1XPhRbb9eSMq+CuKeQTswmClk/Qp3rhhcDFv+9qQQVuJyhT6dSx9EeWVXuumfB695QBG9KNz2i6XMWzamJu70ZPnXyOuEu0oxIxwXwJcdFKJYKCdWuvn6LwSI5NeoBAxH1s3MQYY53oU62eniey3FssygpCqT6wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:09:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 08:09:10 +0000
Message-ID: <c0207278-bb5a-4ed2-bbbc-4cd7e7d24e38@siemens.com>
Date: Wed, 15 Oct 2025 10:09:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Fixes related to toolchain / libc update
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1760374860.git.jan.kiszka@siemens.com>
 <8ae5a640b977e3eb6b8cf684482e6b273171b356.camel@siemens.com>
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
In-Reply-To: <8ae5a640b977e3eb6b8cf684482e6b273171b356.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 84845690-dfdf-4cc0-5e34-08de0bc21ef5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjg2UXE2dVVTSmdmeFlkeG5SbHhVQUlwRjErV0E3MzZMVkR2SGRkemcrOXhK?=
 =?utf-8?B?U285bmlLckdwazJ5UTA0RGszNTBHdFNSaHBaV3RrRXV2eS8xVWlLOTBDS2Zj?=
 =?utf-8?B?RHUxcTNwajJBazNxV3pQNHhqeXJuNFdIZDVxdFBNYUM0L2xTNU4wR0g2Y0E5?=
 =?utf-8?B?VjNBcUlkVUttRjNGVDFlZWYzeEdOcW9COElHcEZmN1VpZE42eWk1RzhmckFw?=
 =?utf-8?B?Qjc4UGJyb3J0c0xCSVdMaGVoTVpZL0RwNUdlMG1NcDdnTzExQmpnYldEL3lq?=
 =?utf-8?B?M2pPZXhhMno4b0xsdzhZRnhQSzV5MS9qTzFScDkveG9jYmp5U2RkcVlyZFhX?=
 =?utf-8?B?UkNRbTExZzVPcWtWL2hTSzVPVGtsMmFyNkFQNEJqckRlZzFxRGJOcURKRWph?=
 =?utf-8?B?WU5ITG9ERlNSaHdFdkRmVEEwZ3Z3L1Zjd2JEMU1JdlNCOHFIVjFiTDJUY3Zy?=
 =?utf-8?B?MEE2dFFHQ3NocTRNRDRQS0taSHkrRW1Cb2RTdjhETFRaQkZ0dHBRZEJ1aVJt?=
 =?utf-8?B?bW5jNnVXTGl1R1dRZzVNcFpuZHZGZ3hiaTZmRU1xb3daSU1vTjBvRDFsb3gw?=
 =?utf-8?B?NXRObUVrdGtNS3ZmK3ZRS0Q3R0F3azRvTzhNQ0xkQldxNEpmMmw3S1JuMjdH?=
 =?utf-8?B?ZURRV2RSa1IwbVp5MjZDWkFlMUZCR1F1QnhHeUEvRVBIS3VJYkJjL2Z3Ny9a?=
 =?utf-8?B?V2FLa2MvS2t6VTlWTVRIdkZ2WlFJcGIzR2FIVlowUTRQalo4SldWRUtoT1Fl?=
 =?utf-8?B?SnVJa3gxOXZ3UTU2Zkl4Yko5aGZIeU13WlNXK0lBbzl2VFNVZzFaZzN0V0dJ?=
 =?utf-8?B?ZVZ6eDNJMDNMU1R5VEltVm1FS2U4bVFIaUVwQmt1S3JDQ0Fwak9nZmNiK2ZG?=
 =?utf-8?B?WVBVRVpncURBVklDR3dPenl4TnM2TG1ObW1wNGNMQ2FjQWxFcnJEMDAxNmFp?=
 =?utf-8?B?cVJqZlVVcU1XMTkvQlkwOFBsNHdBL3ZzUFZaTk1SQzl6ZEtFZjlpSFordVJY?=
 =?utf-8?B?V24xUEliU2U0ZS9TOTY5aHZtKzhuYWJlYk8rZExUd29RS0hvai9ILzd3RWJv?=
 =?utf-8?B?aEN5bVVzdGhlSjVTWVJDVzM1Wi9mMGJnYWdrbHh5M0RjcDd4NzJMK0psWWpI?=
 =?utf-8?B?ZVpTR2tLZE56TExYNXFDOC94ajYzK0ZkakpFdVdnYWlqbGUzb1hYT1RsNklU?=
 =?utf-8?B?Q3Z4VzdsaUxOYkdUQytnc2EvN1djelBvZHRmUUV5eWpUS3V1dDFFdFhKVDk1?=
 =?utf-8?B?R1RoR2pnbWwzSDArTU9nVHRoZWR6NmhFT3R4YW13MVNybXhXZGpoWk1lRFdH?=
 =?utf-8?B?djJIb3AwK0FEMVJjcWtNdFUxcE9HUFR3cnlTOCt3RzRrVG50dlBHbWtHNEph?=
 =?utf-8?B?ejlOR1FMVHNaWVNnNzBlRnhOdFQ5U0V3MXhTb0RvZ3FNdnZ0NHpaNDVwblVs?=
 =?utf-8?B?c2R0bzJIcVQ4Z2VKTUN5ZExxRmROWWs4TjltNDVtUzhnaVBsOXZGTXAyU3oz?=
 =?utf-8?B?NEFVdWZpM2YrQUVIQUZzYXoxa3Y3RTVHdFkxOUFZY0tPQTlnS1FqQmFuSDlT?=
 =?utf-8?B?Ri9GejBiVWoyeWxOd0xzMmd2WmErYmVQL3hlU1p5VGJwYm92bkFpWEl3dk85?=
 =?utf-8?B?OTdqWnAzOXpLUmVxdDVtYmM0MFJKQTdBM3VmZnFaM0ZLa1h6ai9SeFVnN2lk?=
 =?utf-8?B?MFlZdm9sekswSkVYZ1hiSXQvTFZwL0lqMDdJRjFsMXYxNHFqdEVVZWs3ODNh?=
 =?utf-8?B?RHlTOVcwd1Qvc09rYkxOOE9uZmd0a1p4RDd1bEJHT3ZKVVVWME9LWGsxNFVP?=
 =?utf-8?B?Z1J3QXFjY1NuZ0FzbFNsd1pUY3dhQnVMOXpIbjIvck5hOWNOZmU3ZVJLUGpa?=
 =?utf-8?B?bUNhNEUva0VNNlh2SE1INitSK1haS2xsRGNnOTdUOFFURHN3VHJqeXFtZ1F6?=
 =?utf-8?Q?3JVgD26zN3A9qDonE7lpdbjyDB2fQLpU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG5wcGlFS0o5dmlJQ2xBbmM5aHhRRU1pSVJzazlJbXhqSTZjaUZEQVc0dDhY?=
 =?utf-8?B?Q1pBQVpKUVdoak80NVNzVm5CUUR4M29FYURGSWF5TWxWQ1Bva2JsL1FkOUdE?=
 =?utf-8?B?WVE4d2FHemNYRVlvS1RLYjRGUTQvNFYxcnBsZ0tEaUpKbm53RDdIbXhBR3FP?=
 =?utf-8?B?YSt6ekxyMWxCL08xMURUYUNOdjc3MTBKKytTS3NLcVVjb3ZCVldPZUx6STdt?=
 =?utf-8?B?bTRmNk52Zy94WVpoV3gxblYydkVNRHg2c2FZTzhKMWRNbGs4WGJlWjc4V2V0?=
 =?utf-8?B?bW5XekVnSVVYS0MvY1duNUF5WThGYXBjN1B4YTM0YzhJamhCSlNGWkUwQ1NV?=
 =?utf-8?B?WXBjc3BHOU4yb25pazlOWXVSZGd1bEQ1TlNnWHZHMHpVWWIxdXRyU2E4alVN?=
 =?utf-8?B?THNqZU1ud1BpdDBUQUFSOW5aeXBUVERXVnZ6NUZSR29na3FqbVJLZDlBT0lt?=
 =?utf-8?B?Z1FKVERvNFdaaWl1RTBIeHVQaVFlbnZLVkE5eXRqbHRLWlRwU2FhbHRORTE5?=
 =?utf-8?B?eUY4MXpvV1A3a0toSWpKYzY0c0NwdnlyUFJZUWRaUERZbnFwZUFVNjUyRGth?=
 =?utf-8?B?dzlYeUdqb3ZWUzZNc1NBWHNvTjFxVHE0MW5QeXFpdjFoS3pQM1I1L0gwUXQ5?=
 =?utf-8?B?NWZWcEhRVUw3VXRQMHhTMEdtNUJsUHZWUEdFL3E4ankwMnJpT1R1NWUxUmRj?=
 =?utf-8?B?V1ZBTWpWRUJ3UjQyTElyMjJIaWFJekowYnBkOEdORHR4TFdzY1VjVVd0cjlj?=
 =?utf-8?B?Z0JBQVVjSktNSlJBVkNnOXo2WnV1SFpvaDVvZFNWOWR5c0hxVUNoQ1ZjN1JY?=
 =?utf-8?B?Rzc4Vll5RVBwbWljS2lNSXhqSDRRejY1UnlBdU9Ga3Y3RFhNakMrNWJKSWNQ?=
 =?utf-8?B?cWJuMkNpaHYyWHQ0RmtQa3hXNUJHRHpFK3JObmF6eHNWNmFEaVVHY1lXVmRI?=
 =?utf-8?B?WHBZVkQyMVhIWW9BR3hXd2RRWC9BYzhaTEJwYzVpcWFyQVJKTi9XdTUzMHFH?=
 =?utf-8?B?a0NHOGRzUjd6d0E4d0JrY3NCWDNucU5lbDUrWHEwREh6QkJncmVVNExnWS8v?=
 =?utf-8?B?am1lbS84M2x6c081SlZQd3JaUTJKNnlTWGxiMEM2VkgzMWoyWFY2Qlg4RXlH?=
 =?utf-8?B?TUFnTU1Za2NneFdCazJoblNXM1hsRERUZVp3NldjUzFwSVBvWElRVmVUZDQ3?=
 =?utf-8?B?cFc5QkhEVGZtRE9KSnQyTnpHL1lxQzY1eDNYK0JmNGRmK3lNaVpyR2xoTnRU?=
 =?utf-8?B?bXZpbjRpTlE5Q3F6T1RnS3M1ZTEwaFBSdGFWZ1d5S3VPVUh1RWhuTG9QY3Bk?=
 =?utf-8?B?eGZrc2w2SzNjWEJpNWlqc0g4aC9DRXRpUktLNjc1bU5PZVdXV0dacW4vUG82?=
 =?utf-8?B?MjJFQ0pEQ1ozai95V1ZFdkNOcWo4eTRBeVRqcUpUNE5oaStUUkRZcUt0UDZp?=
 =?utf-8?B?cysveElTYk4zTWJFa0NhaUl4N3I4SXAxNS8vNVh2aXhueXBVZG11VDhYWUsr?=
 =?utf-8?B?eU5nR1UxY2FNV0x6TTN5aExYUjFYVE1xYTBIL1VRK0JPZXJLZXo4eWxqMnBr?=
 =?utf-8?B?WElFbDZacEtGcUYyRyt5WTBBWUh0azl5bzArOWtQem9HaTQwbzZlTThzRmVI?=
 =?utf-8?B?UVNhV3JtWXl2TUdDSlJjTy9oZEczVWRYVzZjTERVVmFtKytCMTB1RFpnYmE3?=
 =?utf-8?B?bm9zYWdpRFpydnRwNWtNSG91MnlGeFM1V1lValJHNDF0d0E4RFBkVkYvcXpT?=
 =?utf-8?B?Nit0WjJ1NU5GTFNrZWRrOWV2NFFLRnBkRmpsNEttN1VGaUJ4OHRuRjZKTEYr?=
 =?utf-8?B?YWhLdU1uc3VheWY5ak5ob2dvcmxjQTNWb2UxK2hXWFlOUHVGTDAxZDlxYmMx?=
 =?utf-8?B?WFl0V2lsenZkWlF1WVpBT2FSNDhRQTI4NnJmQWkwVTcvRDFlS2hQY1Rqbk5T?=
 =?utf-8?B?ZWhVaHU5UEtmMkZOS2ViMXdaK3FLRnE3cGJBT2pYT0JyTkNyUU5xZHBGZTZz?=
 =?utf-8?B?TUFvWDZRbjNGaHdoeDZ2YjBDMXFNS1lhemRWc1VLY0swTUlvMHovL1JTbjVT?=
 =?utf-8?B?NkUyNmMzOTF2NjlIS0hCYkZ6RHJiOU9oZjA0RTNxWUxOVTk3YTlERk9LSmJP?=
 =?utf-8?B?SUtDdFNDRlJKendqc1VnM3BUNkV6T0FDWjlsenJTY3I4bWdGWm9sb3NwQ3BO?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84845690-dfdf-4cc0-5e34-08de0bc21ef5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:09:10.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f53y2dgYCHo8hgvGAeuFVFwo73b4hiG9DkqV7Jpg1so1v2o33pOdZZwKg4J1CP+Qeue7g4r9Ojszw5uEjWlJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7027

On 15.10.25 09:07, Florian Bezdeka wrote:
> On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
>> Fixes that where found via the trixie update in xenomai-images and some
>> cleanups. Most affect ARM 32-bit, the last one also 32-bit x86.
>>
>> While the patches do not change the ABI and would therefore be backport
>> candiates, I will likely only pick patches 3 and 5 for stable.
>>
>> Which means that current stable versions of Xenomai should remain
>> careful before updating their toolchains or libc versions for ARM and
>> 32-bit x86.
> 
> Looking at patches 3 and 6, fixing problems in the low level syscall
> entry path, I'm wondering if we should revive [1] instead. Basically
> moving to libc syscall(), avoding the arch specific register dances in
> Xenomai.
> 
> That would also help moving forward to prctl(), which has one blocking
> point right now: The select() syscall has one argument to much.
> 
> evl does it the same way already...
> 
> There were some concerns about the additional function call, that would
> require some more measurement first.
> 
> [1] https://lore.kernel.org/xenomai/68d9f583-59de-4bbf-8ea2-af8ece427495@siemens.com/T/#t
> 

As already mentioned in the patch: The strong arguments against that are
A) arm 32 is low-end and will likely suffer most and B) glibc is doing
inline syscalls as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
