Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675F17F51C
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401400; cv=fail; b=Sh6AYJgy7oYs3P4KjbhQCVVMXP3lgSlh5F16rTP5ePVFjUqJS6qJD9pEe9nbcAXO/qnZtLWLWRyOSJZ8SBSvVI4o34eJIX52bLxawQ3ogCvAA6654MDZBMCUkgZ42fviZclW6QPXbQvxApn/xkrLNPKYDkYp3hKztwXUcHdcMe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401400; c=relaxed/simple;
	bh=HCCXSYgfigBXf9hQlJ+5c92RLcrlqBBqNNo4gSZC8MU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VUNAa209Tjh/fNLLzZZN2X83gGHTv98hRwg/RJ5bS4DU7fK4/hhsgEcnzukD1CTFxFXorGiMm5gvKuNRJPwOx1FLv0jxHeuIKzOvTm6zjQN0EaVeYynnDFCuuYRmR1aOGt4Ze19Qx1in4ZmpwpNlTB2jrD6q94bE3RR886uRoos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=i2I4r2cn; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="i2I4r2cn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHqZX7QlC8ejmICP94IapNimQVLx9+u/WJBnwftemQv20ccF7TrCipl8R0eU0ruSG/vPQ9RGJuOBZmwl3VtHaJZbdr0K2mkcVSSX56GjAXbRNuPmLo02h0dmgh4BY96hS8JxWlhGvOFRFtrzvghaoc5ax43BkydKiFvCvjqop6nBKE+Lg85C8X1uDu72KTJxl7zvRDLlok/fYq9NHvz9yfu9TtfBxqjM50mdXFNiYQs+MR8sFzZMNQXysiobuwvKSjfNmNITqNyW0jZxaJ67IQm5/+18JjgXliqCQlceBFp0XwhHOorbbAUQqXlNdcpPRFqWGW/YLnKjPY7Cd5+FTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=munrBPIYhhCttKltam+bkVh9C/ZCmWm+IPZdWAxPXfI=;
 b=hAK34ejQ4k1UXYi/zAMgl7/9HMK/26BBf6+8IpbfH4lrW8O4YgrAYXXq4HBeyzs8PYUEDeUEIViVK2DDCWrb7ADZIRMW/fwZvbTBBt7C+oL/5LtndUhZHtofLMI8r0znqJU4zymq1MwC6VAxWkSyiUe1NXgtYGzDL+cOMD74hA0L3BFpRT44btLke1aH78EkPtfL7w2hvdIXdlVyP2G24e/jqmoFv0mhc9votn7iX9KLgPTq8qZGEwS8d0OX3zltHxMDCy+kvWSYcjJ2FckyBdDurmPRPRjL6+xIEWYQMnqi20VqiOqeGoZCmRiZ7zM8EMaZfac7LT93m8cEk+o/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=munrBPIYhhCttKltam+bkVh9C/ZCmWm+IPZdWAxPXfI=;
 b=i2I4r2cn81s+qac6G2wgOuNPXAJO8jN8lZWQyccNr59Z1UkcOabyjL6pg0Ni/VamSZTspzUWHciLav9tJUr9k0gRihqfpOJIJ4mFLFVeQYI56F4Gu1ZJAK5eFdToYnPAp0K60CxurwiriQfmkOz+2usMB3W/MOTF9wPCe1h7dsljOGM+VaveJE7nNflsDc4Eg4ToCvVUxEAbgqa8Sr66Cxks+ayPua8RCUDP/MFzTtHtyvU6Tcw9HzbYNdvKXnvySTa4KSdQMfwuKj/qZBdZmggv+fF2bUQGy2uMuvt5TABcbWWQaB0xAdWQI4WGCx5Mm5tyiHFfe4jNPF3cV/fXwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 11:29:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:29:53 +0000
Message-ID: <98bce1fe-9669-4cda-b5af-7d2194808f79@siemens.com>
Date: Wed, 26 Jun 2024 13:29:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v5 0/2] Fix KVM guest support of dovetail
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
 <875xtwcd0v.fsf@xenomai.org>
 <92516aba9b4726ac25f00731abce36d99c96ef84.camel@siemens.com>
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
In-Reply-To: <92516aba9b4726ac25f00731abce36d99c96ef84.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:b0::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fd1d82-b07f-4c0f-ff03-08dc95d34c3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0VTMWxzcWVuQm84TmlHMEpabE05NVhsbVRzWldNZDMrWmY0SmVoNEZxeXNy?=
 =?utf-8?B?ekZmeDdqY2t2NnM5TGZ5QVZKREpzZDlNaGtSNTJ3dnVmUjJNYjRpRXlYaGdJ?=
 =?utf-8?B?aDVOVkQvb1FMemwvcWUrY1FWU1F1NFlpVVZENHAwTW5GbGNDbjRSTklLUzY5?=
 =?utf-8?B?VzEwbEx3Q2pPNXFrOXZRRHRrSWY2ZnhqdnJHTXFKTWpQTm1ZbHFSd1NoOERk?=
 =?utf-8?B?amVmWkZkaEIyQkJINUtBZ2VjWUlhRnppYWtRYTNFU01HWFdzZ3dHdWhraVNQ?=
 =?utf-8?B?cXF5REEwQWQ1OCtKRXlGYUkydVhuWHgydWhTN3FyVm5pYThlNEFqVTFQVzlV?=
 =?utf-8?B?SDQ2dWFybVFPSGppT01BQk5OMTJYVzFYeUpXSUw4Ykc0Y0UzOFdhc1FoNUJ6?=
 =?utf-8?B?QjJDQ0hDOE4zaXJnRTRIUkthWDFpNXc2cTJocjNsTTlwK0s1cmNsVUN1QUNC?=
 =?utf-8?B?MUc1N25qU1B4SFZaOHUreWxFQ3dYK0dJWWJ4cm0ybE1IYXJsUWlzV1A0NmpI?=
 =?utf-8?B?TWg5dUFyQnVUejd0d2UzZUZ4ZE1PSTNPSmxvUWt4bXRJUTBkV0t0SmlmaCtx?=
 =?utf-8?B?ZVQyeWxISExaUHM4cU5QWmZPZytxaDc1OEpzamtydmN3Wm4vVG02RWxhckdz?=
 =?utf-8?B?UE9PRlBzeUJrR0RCTEFYczRRUVZNUlAvcXowR0VYZDdQaG5xb0xSbWYrUit4?=
 =?utf-8?B?bGRkQ1A0a1U4Vko5Y3p0S08wK0dWZ1dZSGZTRWYrN1RRd0tuR05XM1dzUkpI?=
 =?utf-8?B?K2dpMlNuNXYvREk3QlA3R3ZGeHhIU0tZSHlxVllqK0U5dnc3dlhLR3BsZkZ6?=
 =?utf-8?B?eGNaTGUrT2daS3o4aVlBKzN4OVhxQ3Q5WFBvM2IwTDJkWm1CclVpWnRTbFVC?=
 =?utf-8?B?Z2FINTJ0Y1R1VTROemJFN08zNDdlQjU3WDE4ZkhPRkIvN0E0U1VlbXBVQTVq?=
 =?utf-8?B?VTlJd1YxN2xEZ09qOGQzb2RZK2dmc1NodWNNdHFaVy9kbFF1WVprNHVIV2NW?=
 =?utf-8?B?cUhmcURnYVdSa2VVa3l3V3NISXlCNDZCclZ6Nkp6dzdhQmxBMzRxSi8wQk1m?=
 =?utf-8?B?RTNQNDFab2l6SXhwNXM2ZWlEc0FrSVBqeDlMYTZpTzZsYjIxUG1JMzRGdWVR?=
 =?utf-8?B?Znl2cEdWU3BLSXpzV1VRSXRGWmExT25QTG4xKzlYOThJNDErSUFSbjJCMTJi?=
 =?utf-8?B?UjE2MG5yc1V3UC9xdVQyaU1BcXZVT3lNN0g5T2Z6NHdZRWpub0V2Uk9CTDBw?=
 =?utf-8?B?ckN5MWFnUzhabi93T0xqVGJXVHU0ZUVZS2pKYjBiTnFlWHZIQVJkV2g2WVA4?=
 =?utf-8?B?dTR1YmkzWk8zZitRa0hJU2JZRG9wdTJTOW5FczhOb1lqZGJ5TkxZUWJ2SlpG?=
 =?utf-8?B?Ull6OGd2ZUpYQVFUQ3ZyQ1VHYUplOGwzZnRkb2F6RzFJYm5XQWxjbENmc0w3?=
 =?utf-8?B?WnE0MmMrRk1nVko5b2FSekx6cmJTRW5vbExnUFdKTnNiMVk1cFV5RWRFeDZj?=
 =?utf-8?B?VVlWL3FGSUpWUXRLUkFINElQUjFFbmppU0ppay9lYTAyc0lUbEVoZHBBVEYx?=
 =?utf-8?B?aTVuaUhjYkl2NHFhc1FOaDhKN3ZQR1J5YzBWRG5zSEZUNk9hZzVwdktSQ1Bn?=
 =?utf-8?B?YXBjTExZUEo0NzdicDEzUTIzclNFVW9BTStWelRTbEwzRUFKQXh4Nnl4NDR5?=
 =?utf-8?B?dVpwQjErUWUwdWszMjNsajk0TG0rV2JRZmxKdEdLdExqMWFmT1FzUDZ5bGEz?=
 =?utf-8?Q?B0bVR1ZSOC4HgOVRJo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC8zcmZ6ejgwNnl5YWwvTml0aXJTY2tRa0VoeXJ1MUJHdnh6SkxwOWhGN0J3?=
 =?utf-8?B?SXd3QmRsWUJKK1IwVStQY0RuUFoxNXFZazhlR0VqYzVBWGptQUdPbDBCZmRB?=
 =?utf-8?B?M3JIaDBmYm1CcUlhYWducFpOWm9WbWZEVkM0Y2gwdnZ1bGxWWWpmcnJ4TWU1?=
 =?utf-8?B?bGR3VkNhRFdmSjF5RUprQ2R0Q2FodjVhR0RhYmV4Z1BldVFMT2tXMTR5VmFs?=
 =?utf-8?B?ZnE4a2o3Nm15YlZQTi96WTJZem1TR2FqSjdLMEFhUGx0S3M5MEVFdWM3bDNN?=
 =?utf-8?B?VCtFak1CRXY5QVBqZTJQYjdsNGFoV1FoSHh3T3ZsTnRhZzFJWG9LQ1k5U3BB?=
 =?utf-8?B?THBJUGFhbmJDa3RVR2IrcUhHYzVYOTFZSUpHRFBiQzNzblc3OFVGdDlHMjVF?=
 =?utf-8?B?SVdzemxVRmRmOCtmeU1GNmMyNlFCNWRjOUxmeUhOR2JLTDJFaUtuUG1kMHU1?=
 =?utf-8?B?VTBUWG1FaUwrRVRIOEJ4NXFpdENvc3NkVzladTcyMGVGZXErM2NwNHJ1MUV0?=
 =?utf-8?B?eHVxYjM2RXBRcnRUWDhDOGZSUmRRRFVvdGlpS3hRZythYkVncFowVlQ0dXBm?=
 =?utf-8?B?VWgxVHRWTnRRRzhKcVVzSUM5ZmI1NWZkQTZrVGYwa0ZNMncvd1JKUUxrVDdE?=
 =?utf-8?B?d09PSUcwUlpRbzUwemJNc0t6bmpvSGp5aVI3ZVhqdStST3hPczFyZUpZaFpl?=
 =?utf-8?B?Z0R1RFBRQVVCVzhwWlhTbUEycFFjdjRoaWRqVkZ3MlN4WDFac3ZldWtLN25Q?=
 =?utf-8?B?SWJtUVlMVmxvMVUyTnBXeERqSCtiVEdpNnQyOHhBQkVZNXZkOXZGOGtCNEt6?=
 =?utf-8?B?bFJ6NStPSHpYTy9BNkVYTzNjcUovMTNsWWVKOWZPT2ViZjAyZHZyeDEydE9K?=
 =?utf-8?B?cCtJeFowc1U4NyswdzJIY3d1OFltcXNXQ0QwSXpvcjJnTzViNWt0OThjQUdN?=
 =?utf-8?B?cHk2dzhGOXVUanJpZ0s1cG5IUy8yeDJDMDd3ak1xQnQzZGs0REM1QmxtQk5R?=
 =?utf-8?B?cmpqZzNVK215L2VldWhMTVhSK2pkSTh4ekREdUZjOGNoNW1mMFQ5VFlnRmh6?=
 =?utf-8?B?OHg5ekZ3MUhHS1F0aHZzc2IyOG8vSkRRMnZxTm9rNG1HMnF0SnlJRkpLUXdZ?=
 =?utf-8?B?ZHdmWWtTaWwyd0xNdlhKbzd6NUx0dWp0WURscnZUSFhOSUE3d3RzSFJMcDBi?=
 =?utf-8?B?L2hOVFUyTi9JSG5OK0Q0NjlheGx0WWtrK3BYTkJOOHBZazhBYWtud0QrRXRD?=
 =?utf-8?B?Z05OVlFVRXVSS1dVSkVqaERVYmdZS1RvNjZ4dHlTSnlNWi96QWJjMTJpeHdz?=
 =?utf-8?B?eFBiaEZCYUN2Z1ZoU0hPRVFDSmdZcE9pcUsrMUF6OU1LQW5sOXZLV3M1aGNI?=
 =?utf-8?B?UDZxYXBYODhWSlZ6QXNrNDdSZHFYcFJjNHFkSXd1YXd2SUZmYjR4ODU2cldW?=
 =?utf-8?B?bjc3WmZYbXBadS80OXlCbFQzZk0vZEdkRm1xK2dmNCtRdkN5T0IyUDNGeU1h?=
 =?utf-8?B?NXpTV3I5Y2NwV0Z5U0ZlREVtUmlrM05xby9KUmQ2VjUrWE5OUVVlaWlvVFJP?=
 =?utf-8?B?dWtSbkdnT2d1VDMzd1Zwa052T3FJVk1Bd3JLazh0QUtTWDdMc0FVYWExQ3N3?=
 =?utf-8?B?MlJKekc5WVRzeHB1a0YwYnZEdmtXbVgrVG1YaE8zTlVESHpXR3FldW9WZndH?=
 =?utf-8?B?dHVLdnlFZmV1b2UwVmN4ZnJkeFBSRnZ5eDRsSS9uOXIwV1RmTSs5NUNJZkQ0?=
 =?utf-8?B?NzQ3dlp3d2dQRXpub2dzS2s3aURYTUxlN1JHMi9wVkk5OERZTGt1TXBBZTVS?=
 =?utf-8?B?SVllSnlybGtobW5IOXVic0s5MmU0TTF3cXhOaHlQUDE4Mkk4bEpWNEVYZEVJ?=
 =?utf-8?B?R3FBZTBtOUp0Z3hVcm0rWjJpL2FLR2tIaW5kWlNxQzlFOTR0KzZiRVBhQy9Y?=
 =?utf-8?B?LzlIdVZHYndudHJJaGRHenhQWW9FckVZNHVUaHM5aGhNZUNKYkFudEZhd2x4?=
 =?utf-8?B?bnV1b1ZZVXp1c2VpMVpNbWxHcm9raDBOS0hXNGpxZEhjUkYxQWlaQzBPQnFa?=
 =?utf-8?B?U2k1VzlSOGh2djg4K09qWW9GT1UvbUExNVcyM2VzQld5cEczdUliUEtOaXhF?=
 =?utf-8?B?bWw0VE1vNTQwdDNLSEI1WWNvMlIrNVRTbUJLN2M0TWRVejFnVUhIc0FrTGlM?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fd1d82-b07f-4c0f-ff03-08dc95d34c3f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:29:53.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MHb1iIPJ5ypJg7skcwiJ0HFYvkCkxWvOsc3oxHdnea9zECS03qs0CnZ3U4g8PFd3Uy7MaVpxE7Ba5a5RxwxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5340

On 26.06.24 12:44, Florian Bezdeka wrote:
> On Wed, 2024-06-26 at 10:40 +0200, Philippe Gerum wrote:
>>> Florian Bezdeka (2):
>>>       KVM: x86: dovetail: Move handling async page faults to the inband stage
>>>       KVM: x86: dovetail: Allow kvm_wait() to be called from any context
>>>
>>>  arch/x86/include/asm/idtentry.h |  2 +-
>>>  arch/x86/kernel/irq_pipeline.c  |  6 ++++++
>>>  arch/x86/kernel/kvm.c           | 29 ++++++++++++++++++++++-------
>>>  3 files changed, 29 insertions(+), 8 deletions(-)
>>> ---
>>> base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
>>> change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad
>>>
>>> Best regards,
>>
>> Merged, thanks.
> 
> Nice. What is the procedure now to get that into the (non-rebase) 6.1
> branch?
> 
> As written in the cover letter, patches should apply down to 5.15, I
> can look into 5.10 again if necessary.

I will take care of the 5.x updates.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

