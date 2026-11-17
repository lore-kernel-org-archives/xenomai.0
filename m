Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794892004;
	b=CTs4f2UkdXT7ICdMEeLV1GDL7EfF66oDll6slhGLSjAPi2At3NiTk6VMaOcC1jPmgwFu
	 JHsDwzS7eQejmIUX/voDP32Hc864HyZS0cYLGsLcogByz9b6Nhc6RluU/aJ+VDvXzscuw
	 VIHT5PK1v/U47rMRQhdtyZ4hyUF1+xxApF1QEEF5fvYMKAk9d2CDB9l7CoGtdkunZQ5bw
	 8iuKwqA06mEr/vcyGkD3P5QXME4JfdBo1mU53TvVMCqnmONN50IcPjs7IIkCboRozYQZO
	 hUpWIjJuGu2r0zT8d1f2gheC2brXcwKxaA9Nxb1BSOBREMy2ETG0kZTP5undmM+/1vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892004;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eRS63bjDiwTWadqMXX3mObCVH/kBcsMbqGK4ElTzarc=;
	b=r2HVqlU9q+7kEi9c32Pfz4GGAtNryYdWnkxMCjQQQQrkOiGPgw36EaKTnXEKfFxSE/UZ
	 V17ZHwskZUKiwgxu6JiMs6mZt2dlRepsaVAyvlQC/wksIHAL+Iycsp4jYVQNDeifmdhG1
	 M9wxzZ0Z3nmFi27RU6CtRjHStVntqU+16zxc8Z345bE8R7CTZyEVlxhqm1jduTxfo2dP3
	 8dFhWd1GQ6vKW6g29H6lHgGKhuLFgDAfQQCFuYtkw5Ze/h1Vj2J3KlKSa+veAPhhNLKLY
	 UZg9ZZejPnKfhGpRomIyQMgYxiJhOv9POpVuHrkvSOUcsfiMdGPEwYfhbvM5g/EZtPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=gv6SlEO3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C40606A32F
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 05:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44C40606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=gv6SlEO3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iojV4JUcZqLdC+2oUI15ZW5I0xbDTBLx1CCtt7MZ6Y7RAyBTVVN3EO0yrPyi4cQR7sEB8la6txnPocedGtlfDKTuhBkaPAvZ+W04ItNLFVsmM6cCcwNrPiM4oEV7zjkTRjblbN+NZTJIkk/ESKAV01YuUS+/5YUQNDo0KRtfdclpJ4oLUa5bt4IRFpxefYGGa7cmJtaUESSB+CQkzDODANeEP+UBAWsl734788bzLfimJBJElSmleowzkpQz3f2sVxifWV3Eg0zk3UEwfhrsQ3zFPH7Lx3kG68DHE2Mjuw5IP/hyydBEgXl0ijSn+VOsriiA9gv294kg69EUDfKqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRS63bjDiwTWadqMXX3mObCVH/kBcsMbqGK4ElTzarc=;
 b=h0R6eN0J9rCUYn95IImSk2fUeRo9xy/QFhycGbJ2gi3fSHluIUqVDnmPXvJfCO9rjzxNxE6z5mptJeeefvypqAyLeKHZM7P0bG+iwZoHLL4cxKeK1u7XZbHrqhnp5BChAWOMt5Zx0ruyXCp39JNe9qLP2jyVNKy54WUI9Nm9b2tzUMIlX4TAy923uOhdoMg3MfNgqFDB1qdry1hp7l1u8bbPhYcpUz+ULlwKG8H8FFqInpqyLVX8t8DVN0Z2pJnNv+VfFjcIfj5jgYEwHPEMrWFs4Lf5s8YDjKjvrKMi9dLv30LqAqNvhWv2Sli+sqcAO6xa84YgMyFvpkKvrR7yAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRS63bjDiwTWadqMXX3mObCVH/kBcsMbqGK4ElTzarc=;
 b=gv6SlEO3RwiEYiBkztrZsAq0b2YXrdhL16GB7p/UoA0AjV9waW0Gx2qovak01ERsjnS8adisrqY3Ts89GlzKMO9kCAvV7sqwR1uENomVFe+oDrrB0b0oHoIVW5j3Z7ocmMojZ2DvBqOl6FGV6pHASLgVYEQZ9zw727NRzCOW/2IRu8L+3UMUf1m/RXWiQTsR56MmTympoZAElc7t4WtG1/1V/zksTTnWqg0TziI1Co9Db5Jzbmt+7LcOUrRDfkpDKfekqOjO0uVYORPftS4KLy9pI4H5sNDK+QLlcVyJm6/h/tGdG+chZ8Amzd0WwwgWO+ucpGhxokN6Xup7Vawmhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5504.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:307::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 05:06:40 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 05:06:40 +0000
Message-ID: <5e3b4c9f-6f1b-4642-a923-6c33188e9cb1@siemens.com>
Date: Tue, 17 Nov 2026 06:06:39 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] clocksource/bcm2835: irq_pipeline: set clockevent
 IRQ
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
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
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f39918-9b03-44f4-5f61-08df446890dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|55112099003|11063799006|56012099006|10067099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	R7f/MQ+6a2G2r6A83YhUGjXhm2MK1YM512VCGCS9rfIHtvBJli+S7KPGrflhq/3vUBG6ofUKMo7J3IExmcGguwI3jmrRWduY9oywKyo/8izqxVadHb6MSOMTb/AwSa32/WxdK/fQFXWvExMYEF70ImF/y0HJo8bI7vEj+Ms74kIFoy3T9mIaQeG8F6YewSPCCb1LdTfs7iz31638dCl8s3xSCE3nAH5PGuJXpFR2bZfkQg4vlM+vLfRRu4qG7cyBoAVA/yR1t5+9Gk+/rNQgdDVnjoVfhOUcxxPKUpmF4DZbN7mAJLgqABlQso3dkJL0L8fs4DukIpvzbUA+VFDPTPRwWGjQj/aRyB3UMc9Mdn0G1vJJ7uVkJFPv7F4aZm57YCJSeoQ3Wn/GUaW+RzLM7/znpdoV40OUlCogWLXWNqhOXK5TyoO+UlIZo/tiju306ZrTW4EsoGiyfrwalbs2KPf5jRlH9MoeMYTgxadF1axb3oDgpXc1/NvItFZmjI9F8xA9GZ/u35HVWwmjIpkQsQLwy+FPgUR4ppsif4QEUtf/90hImGozRdRF8ACiues2y4vAvN88OmFd/3DW6h771RPmUwDF6W1LaPP74ObuKzJFTEbq+DdJ4AbuscG0BMM02d0Be4+g1MZzHrecPKmOvUgafWo3u5Lf1yRYsHwTXPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(55112099003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHpCRlBVMDZqQWpzbDNRUnJ4NVhFZGprWS9ZMEVqSkNWb2hKS0doZG1pZUhu?=
 =?utf-8?B?SDkvcVhwY0JTOXRYcmMwOXNROWFpOFJMWVJjNEUwL2JYc1EzQ2JZMTErbEcx?=
 =?utf-8?B?VTZPM1UreUxnaE9QQkRaOVVtNnVyR1dDdmVIVHFyZkp3eG12TFRtWEx0cm9K?=
 =?utf-8?B?dmVwVGVqWjNzVG1jZkkzVFlNMkh5bHZXMzRoS3Uwa3JJVzVvNWJTcVNtMTA3?=
 =?utf-8?B?aXg4czE2Q3c4MW0yZEpWYmEzdlZLdUtHNjhaUHp1SFhzNjdVY0N4YWIyRWFP?=
 =?utf-8?B?MjFORld6anMzNVJkM05VUS9ONElmY3prNVhnR3oraXRRQ3BzNjJScVZqMEw1?=
 =?utf-8?B?SllrazRiS1BjVXNkMnpsdXp0N1ViUkFIaHhqYmh4TkFYMTNiaVRkbk5FV0VN?=
 =?utf-8?B?ZTNMdzE3SlJnclpOY0Y2c1AxeXo1bGY3VXZDVkh1V01LL1ovRUQvYit6akta?=
 =?utf-8?B?UXFqNFNNR2lvNlIvc0U3RlVFV090cmVrVWhzd2kwbHdIYUhmaCt1MlUxSFgv?=
 =?utf-8?B?V3AwNEhiV3BuMzlKM3lWb1dIN1lvQlVrT3YvaVdaVXF3K0F4V0NiY3VueXkz?=
 =?utf-8?B?a2Z0R3VjM3Z3akYxUUNnNDdBM2hkTTlpdWJrV1M2dU50Vi9zZW5BSngwdTg1?=
 =?utf-8?B?SUZqZTR2NXBXTWlHQmVvTlprV0FLZ1hGenNWaHYvcnc3eDhoQzJRUGJVeXhS?=
 =?utf-8?B?RWVWTFoxbFArN0dnTTRXUTlhcGtnaWQreFd4MiszUm1zQm9UUHY4bDFvcXFU?=
 =?utf-8?B?MEhQMS9tRXZka3l3NGZEd1ppMDkxVzlmQ0dUSWxzamRvYk1sdHJJUVJHYjJK?=
 =?utf-8?B?a1d3cUkzaFUvQnhvK2cvclNvaXZ6RWxHU1ZIdnUrNDcyTE1oY3VieVQvVGpS?=
 =?utf-8?B?TlJYeUNvQ2twMjdlcUtFYkhIakd0NkNLUUNnSkVVVEVhYnk2d1dwVVdnUzNE?=
 =?utf-8?B?RStKTngzb2sva2NtaTdYbGFVLzV0RWM3N3dmSXV4c0VwYkNwQTB6SW9KNCtD?=
 =?utf-8?B?Nkx1eUN6K0ZzM3ZldUF5N2ZBSEhPY0JCN0dvSEFsR1grdDdBR2NMb2kxVEFx?=
 =?utf-8?B?dFFodFUreUtVVnA4V3BGWHlhakRiTFRWTFVraXREa3A0ZnBUZTlrcGFOa29w?=
 =?utf-8?B?R1BpUmVyMlBkY1B0bUMxWTJYY213SkhnN0NPSEorZEtvd2o3MkRxcUFqYjg2?=
 =?utf-8?B?YWh3V2k2VkhwNStUaVp2OVNZSFRQckN5Q1NmVjNWN3ZlcHNsanYzZXVFdVc2?=
 =?utf-8?B?ZXltMENnSUpId3lIUkhKdlRYV0FoSnBwZzE0SkNhRGRNdXFKY05HREJFRDVG?=
 =?utf-8?B?UEhCV0J0azR4eE90L1RNM2N3SkJvdTEza0JHUDFGdGpGcUk1T2luSm4vZEg3?=
 =?utf-8?B?YjlQKzY4c1VyYU5mRGt6bHBUc1hUVmRxcitqTTFiMU5jM2VYQWIzSW5QWmRZ?=
 =?utf-8?B?TTdvNGNlWjFiOExsOThKcHJuaklMZDNBL0dwdGw2Vkk1b0ZEeUwvVS9PVWRX?=
 =?utf-8?B?V0xYaC9JeEtHWUZQeTF1aENTbEdJT1dxRHNTNmtxakxkaXpxeG56Z1JYVlQx?=
 =?utf-8?B?a1pSVFhjYWJmSW5FY2poOHd2TlNWR1NKQXVYM01oZlVOYVN0V3F3MWRIZm1t?=
 =?utf-8?B?QU5HeFZIbXdBWEh6bG81OUo2aFdESFl5TmlsSnRxZ3dNRE1nK1loRHRZVjlw?=
 =?utf-8?B?M1ZDVWt1YzRCcHZIdDlMVGJRbXY1V3hwVXFiUW5HNWxUc2h3MHB0RUlXc2tl?=
 =?utf-8?B?cUxlTXpvN0JXcExsUWtDMUU0WG93Sm5oTHVwek5GakhEL3U1cWdkalJHazY2?=
 =?utf-8?B?djBLdXFtM2tLWlB5WE9ZV0JRUFJJUENGZ1gwUGNaYVhGTTdnYW44dVI1U2ov?=
 =?utf-8?B?aDJuK0RiWmZRcjVIZnFUSk5aTXFnOEJndG1PSmw2czR1L2pYQTRlc2RrdFpv?=
 =?utf-8?B?VkFrMmdCT1NSOW9IVy81ek5RajZ6bkU0bzQ0czR3OUlCRm42KzBNLzB3Rzln?=
 =?utf-8?B?amRjbk1ZUVQyS3UycTcxeUtORWI0UkZBeEFYRDNVU3QxZkUxazl4SWIzc1Va?=
 =?utf-8?B?STJVWjVHbXpnN0U0eko1R2xiOW9ESVhHdVVlQ2JhSmNGUjVaUWxzV1RVNnhh?=
 =?utf-8?B?WVFlWDRxTHViTVRHTnhYcEhQd00rMXJHY2tGVFZlYkVYTHNqaG9uMDBoSm5N?=
 =?utf-8?B?dWxIRFVFMDFSczF2R3ArM2VBbkw4NkhJQndLcjZWaU9oaTJpZEJoTG9sdHBZ?=
 =?utf-8?B?M1VabGRNWTdaVGo2dm1rQU51SldvOEFEcUFpN1gxdnFUUjdidUVxc01KQVQv?=
 =?utf-8?B?eWh6clBuNnpXd3dKdjFoM1J5MWJyelNJd2t2dmY4RFlXa3ViaEVGZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f39918-9b03-44f4-5f61-08df446890dd
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 05:06:40.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRTiPXcnjrCljG+gWEYutXHh+fiVJ/OqiKTWS35gzz3Z2a55u3lRFQAQdG/k5GyQIjvjn2DNg7ZvWsezN25P6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5504

From: Jan Kiszka <jan.kiszka@siemens.com>

The bcm2835 system timer never filled clock_event_device::irq, so
switching it oob and marking it as IRQ_TICK targeted IRQ 0 instead.

Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

The AI comes with these piecewise, this time while actually reviewing a
6.12 branch for the 3rd or 4th time.

 drivers/clocksource/bcm2835_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index c3d5739da5ec4..73ae9b678decf 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -125,6 +125,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
 	timer->evt.set_next_event = bcm2835_time_set_next_event;
 	timer->evt.cpumask = cpumask_of(0);
+	timer->evt.irq = irq;
 
 	ret = request_irq(irq, bcm2835_time_interrupt, IRQF_TIMER | IRQF_SHARED,
 			  node->name, timer);
-- 
2.47.3
