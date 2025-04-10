Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBB28A3FE
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294166; cv=fail; b=H9fE9lxtvadHoPp8V3mLm75kBfS802B7T//IgI0hvwG2QtUfn8zLsY/aJqJ941PMxadWz3yLga/+zhN6NI4cSYccuHPAiCMwFbhdG0owwhAwP3QsY4HWNIL9ZApNwKIEk8JgaVOsT90Y7kRRFk+7iCFgftfy/hRVFyvmGzww2Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294166; c=relaxed/simple;
	bh=RQX5a2I4dxXoda2FvjUt2OcQL8Q+iSeNdZuwpk+Mc88=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=mpszrXjMyK0AhYsikbBJJtfLpBfS2ZIwjNjpgEbq25K6rFY4EViJxw4St7bb+cgsgx3DhaTv20vtHsfqtzbTjEXcIg3r9UFD/Kz+U/dz3NnPcoX7bBzTKmnXhIoa7OKTVTQP+GoM9nOUrd56rQscZICDhHNIgUi6ZQXP6oK6EBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CIXiJ9H+; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CIXiJ9H+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0j+C4d9amxv56LfWW6qyg8xPnhK8E68ABSxbwUhzmnYzW4asS6JUzrFBX24m+3pHGPPrsTU0mNrW0wabYFRDy622Qm6eQ9pvfGhHgOdFvFBRQOghCOAdEahI+mVFj9OOQSrtGHhHEJ6zijNIFiJ8EGYo7MUMhUr/PeHOsSTZjfsSwLPYpH7TKF4aoNA5ULg/0n0Q+ej4ICJk9P3aFoyKTFXMtLF6BvLtRDXkl2auYZ8ZcVS/oBKhXeHluOBWqzXH5i378O9pBwJaooJvtsuOwVP4ulLI1ExEsTaXVmuDmCYqqAr00mVsgdwDl9hDGXsLGHAPYuqcj2HudYWkDK/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvMrG6FR71FdXH5wXJ9vA/KVkSXG1FQ/Z4B1upCzij8=;
 b=ir1vItd0VBGP+r32vB4yztxbOsW39Uavgm0+xz2aLCbkIn+ukocVOO9cOBAxaByWWyozDQsWsMNVXIMENdD9+Mwo7YOuRjCRSsHa0PpGvJiUQpYUOspBuDWfMq7dH0oVtVuunmF+JDjpLjDR37nqNz21MsEJGxb9i9EQCM/aMaN3j6m9a3Aesbe2K4v+buJJcDcFptnmsqwcvFaalb8IClMRZYcy8kgAW69sv2LAvhnyA+TGZHorQn5KFMdCVkN+K2UF/bNXgD2g0ovFPTpXfvRjGJuYRim4KG6Qko5uvyNCi8Oxo39b4IBVt3xoaxcMIXN/L/8sjrkBHQjVwiFo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvMrG6FR71FdXH5wXJ9vA/KVkSXG1FQ/Z4B1upCzij8=;
 b=CIXiJ9H+oCcKcmnzL8soxYUwl10G4lvXmQPL4ov+IDrnrsBIHRNzJJbB0YmZ6xzPya9z18xAFJijNPhwF14Z2HkxOWjLB9mURkNgm2vZ5Joswl6/Voko/eTqCtmxm3xnDBuxJKlH0iF69kQVYvPzFbSaSJxdXr0QDX7udd5hxVsG2uZJAzaiB3IRonbmSCAMs+45ItHsrrOE4vpU8h+6jZJStRpHccoO67n8QhirQ48VciCTKlzxD7okZ6pqybU1t9euYNkwUO+Jy4El8J3rhyxllvRQgji4cnCZxoi1iTjAb5YdqWzmFoVhId0/5lalOIF2jx9F4bbHey+ys7/Lrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 14:09:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 14:09:21 +0000
Message-ID: <8c7874b6-8b0a-4c4d-a177-2083effd2306@siemens.com>
Date: Thu, 10 Apr 2025 16:09:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Tag build jobs
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9fab8a-ca18-4571-958c-08dd78394a7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGx5Ynh0TkVyMkxGZXFPZHN6TzBTZkdIOHcxNGl5ZXpUbjNNR293Q2xIejBp?=
 =?utf-8?B?RFZsREtqVVhmdW05a3lMVGdFUi9NOXFiSnZKT21hOHJINjI1Z0JKZlkxOWVR?=
 =?utf-8?B?cU9FeThJQ3RVQytRUU1GZHFLSDhvbTd0Mjc3eXB0UDFyaklISDdVZDNQb3Fo?=
 =?utf-8?B?R2QwOUMyTzQvaWRRZkh2SGUrM2hBM3lBVEFCVWd1UiszN2N5SHBMVEIzMnls?=
 =?utf-8?B?a1VIWlZIUHdqVjRiRWtzSnpjU3ZOSDRiL0psc290NW15Q3I4UXNDL2JyQ3Y5?=
 =?utf-8?B?UkQ4dXRYQ3E4R1ZVdnQ5enFxQkpNaHFtVUZCSGZtbWVRTDM3TGFNcktObjhr?=
 =?utf-8?B?QThFMFBzUm5taC95ei9RMXlQdWhtTlFaZlJSa0FpU215ZFhLYTByeTQxZFZC?=
 =?utf-8?B?d0RZVk5WeHM5QVZicmhSSW50NFN5NmVDaFpJSEI1Z1JOa3pVQk1peW9MaGZJ?=
 =?utf-8?B?WXBTN2x3TU9ZczlveUZFT0djMlc5aUxwckxRbS9BUjQ2Nkx2ZjVyZW9Nc21T?=
 =?utf-8?B?aXhFOEJkYlJzdDBUenBPTXVKdzV6RVB3bEY0SFBycUpQdklib0RjTExETDNk?=
 =?utf-8?B?di8zdFlkQnczeUh6eUQrdlRIVXovakVGbFVVVmZCd3FENkM4NjlwU0JFKzhR?=
 =?utf-8?B?T3kvTlpoYTJLSGVVV2Vnd3lWOW83MmxSYmRFdEY5UVVHR0pKK3dwb2lWQVBY?=
 =?utf-8?B?N0RvR1laN1Jndy8zcGIyMEFiUWxReXdOWmNDM0xpcEcyNDZIVFFzZ1RFaElp?=
 =?utf-8?B?blVPaExVZWlsclBIUnBsMFVKa0E0cGszQ3FLdFJ5N1ExVmRLTmcwT1pkM0gr?=
 =?utf-8?B?WkczcDU5VENLRituME1QVzJBMG13c2Ewd1JOdGw1S29mbUtaTTR4OXJrY2JY?=
 =?utf-8?B?QjJkR21CUTRua280ZFJnWEdmVlhZWFpVNFJRcWxSYkRubGVMVXh3N3djQXhh?=
 =?utf-8?B?cVpuZEVuY2NleVBmaE9QdlBobzMyUC9zbVZpdHNiNUFCWWxUdlBRNGpQbk5n?=
 =?utf-8?B?WTdoY1N1MHdRRkZmK0pkbkIyc0dhcjRyWVd1cHpWWmY0NHRNMVZCcU5UbzFv?=
 =?utf-8?B?aHhYejNRUFE2L0hRNXZ0Y3RwV2g3bW5vanFrNUxCSHp6QjE1VlFrcmptQUh2?=
 =?utf-8?B?MXVadjlqNlZWUHFwczRmVTdpWGhLeDVGajZSMHRCS05ob1ZjRGJpQ3RDNm5P?=
 =?utf-8?B?ZmtYK2xkWnBIRnFpSXI2SW5lR2cwTXUyeFNBb2F2aU5jRDZrL3BTZGJQZGhF?=
 =?utf-8?B?RjdHdlVwQ2J0VXRSR3JscFFoQ01sejBHU3I5YndEMVRaOC9uY3NuU1VXZDNi?=
 =?utf-8?B?RzFSY1ZrTUpqT0tKTWpVUGp4Y0lpSmlCZzRERVg5bzIwcnkwaFJ4N2pqUnVO?=
 =?utf-8?B?YzcyWTJPOGxYendFMkUzRmVnc2FCSzZsc3YzdzBFZFdTeDZSaG1PbFM0REwy?=
 =?utf-8?B?TVM0SjMwdkoxS0JTMkxQM1IvcVVPdGhldC9NUDBZOUpqczI2YzhEazBTQzNn?=
 =?utf-8?B?Q0JSTGZnT1dMWlJVNmhZWmRPQVJVYnNqZFFNbit6cy9acUhzUVJ2M0JxeFFr?=
 =?utf-8?B?N1gySm9ldStkazBaeFVBclVZcmE0bHpBOE5ORzhoRGxSZTBHcnVhZloxU1dT?=
 =?utf-8?B?MVNLSzlZRzRLSEEyeW1zMFdlVlpHSVdZanFpd2JBQ0x2WGNTTXB0R0ROU2FM?=
 =?utf-8?B?bDAwMFJXTzNUMDU0ZWVvWEIxRk9RbWhrSmVlUkJCbzU1Ukd5b1NCNEtIYjlm?=
 =?utf-8?B?MGVHVkdkS3EyRHFTdHNQd0grQVJHUUF0Z2RVY2N6dnYrdk1zWVF1SndTWEVG?=
 =?utf-8?B?Zkg0NXM4clJIaERZUVllTWVjRzR3OENoaDh0ZW1RNmM4YjIxOU9FWVV0aW9N?=
 =?utf-8?B?WkhzdTBYU1h1VElSL0NOWDZPY3BzTEVrSEtqdkZ6NE1DaWptbE1YMjBRWEFa?=
 =?utf-8?Q?6eMa+Jfyd9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGtQUEg2N0hGZTFJNElha0lEQkNMV1pRWDRxQWNQamxsaG9mOUNheWpMQTU2?=
 =?utf-8?B?WElpR2htb2tRbWR4YjlpRUNRNTVPN1FYQXJxWHNESHFJSEhtRndDMHl1aWlY?=
 =?utf-8?B?MzlYdjFBMXpxaCt6RjFnTjZra3R2TlNGdC96cDR0V24xTDdPT2VKVW54VlBQ?=
 =?utf-8?B?eVEyeGdUY2Judm9PdTBGS0dVU0Rza0JGSkVIZXZyL29KL3k4a3V0YUtXUXg2?=
 =?utf-8?B?ZW9Jc2drbWQ4eSs4UEEwcHpZRFowK1VNMmlNekcvZW1sTjVZV0J3WFhDVi9r?=
 =?utf-8?B?cE9IUEJvdTNwSzNTUG9kcjRoUU10cVZPOGdZNnY5ZEQrVHoxTERFejJZYUhQ?=
 =?utf-8?B?UDY2cEZyY2JBbzJwaHd5enV4T2ppc212MEVxWUhJbDMyaXdvZnNHS0RrUjlL?=
 =?utf-8?B?Q1k0WGYwdENjQUFiaHdGOEFrV1FOMFhwa3Zyd1kxODJjdUljeFY5RjRqSTRM?=
 =?utf-8?B?RnUxdFdBWnNPQ0RHaFFYTEZoU1hGMjBMdm1ad1RHbmZBQ3VjeVdGRHJ6RXVs?=
 =?utf-8?B?R3lTLzd4RHpqbG9YWXBDeFZoTEJ1Ty92S0FqMUNISUFTTnVTWHVuY0hvWG9G?=
 =?utf-8?B?ek9PTStlb3FEeHIrbTZjMXgwbDIrQmxJdExMY0drSmhBUmkxYlVCOTk5d3NY?=
 =?utf-8?B?U2NkTFhhU3VTdGI4VzdGRDk5cVRMVnlsVlU2M0o4Vm5HMGJKQUNWYUdjSm9w?=
 =?utf-8?B?MVFpNGIvSFQ3enRQc25RY0ovUHQ1SDJqTm40ME11cnZkKzZhOVBpd25jWWd0?=
 =?utf-8?B?bExMSm9ORHVTdnFrc045STZtTkdpSWFDM3pMUHUxMjQ5ZDNxdnRxbjc2WXV3?=
 =?utf-8?B?bWhRdWJCN3B2Vzk3b2hXRlVOWXRVMjc4OXFaZFZxOGtaMnRNcGVZZTU5VmI1?=
 =?utf-8?B?NEgxRVZpdS91ZmlvVkg3MnVBNklxc2FqbEplbzUyTXYxb1d4dDZ3bGhJcWFW?=
 =?utf-8?B?MHR4aG11ZndFWHI2dmpMUG8yRXZMa3phTXBsYlp3UmNEU05nVisrSEVvMW9m?=
 =?utf-8?B?R2NsckNWT3dwRXNFVFdlN3haNk9JWDJpMHhtZ0Y4MURuTDBFSlMwalZNWVph?=
 =?utf-8?B?UGFoS01lSUswQ1BlNnhZUkF6SnZ6VUFMdDQ4ZEZRd0VONTBlMTRXaGRBR0NU?=
 =?utf-8?B?RWpGM0NFOGxnOG5seVluTXUzZGN1QWFZVkp2a3ZtZXdGUng1c3lsNGQ0UG0z?=
 =?utf-8?B?UHBBNHAxTDdZUEMxTnh1OTc5eE5jNmhDdS9WaHFLL25PVkZpblMwN25vWUZ1?=
 =?utf-8?B?UDRTRGdCUExUb0dJVlZyUnZPSU5lVXBhaFpDN0dZOFZUQXRCVlZIK0VMUHVY?=
 =?utf-8?B?V0tSM21POUtab0xaRDEzVk41ek9KbFNxMVZBWGxHdWtSeUQrd09KM1NzUkJ1?=
 =?utf-8?B?SXh1K1lIcEQ1am00NzA1WjVteStwMCtYaEZJOXEvWk80VDh0T1lTU3E2dzc2?=
 =?utf-8?B?KzhuZnp3cDE2TUZ6eEx0emdrMXJHRjJ5OUNNUmkwbkpPbGVVbFM0d3NZSlZZ?=
 =?utf-8?B?RkNFbGVGRUpLUDFYd2hYU05hQTlEMXZnOC92VStsdTV1dmZtcm1ZdGw4NlBm?=
 =?utf-8?B?MnY1OVVwSDZ4aXVMQ0VkR1hDMHJuMTl6NUpMTnNiK0FZLzlCa1dOT056M2tM?=
 =?utf-8?B?ZmlYaWRwK2RWVWVFT2lDc0ZxWkxLQ2dVd05OTThnT2xLcTFFZFNmbHdwK2s0?=
 =?utf-8?B?RTVMUEIyaEdUY1dUMnlMN1U0NXd6MEZOQkNiZ0hDb0hnVy9hd2hFZGF0YjRt?=
 =?utf-8?B?RnN2NzFJWVQydDJ1QUZaWHI1N2VnaTZBSVNKR2RjdWhEY3p1aDdLT094UlFt?=
 =?utf-8?B?d2xCZG8xT2ZXdnFQMm9acXg0ekYwd0dCUmlCSHE4R2hIV0VrYWZVYk9TZkc1?=
 =?utf-8?B?NWFRcEVZaEdDWTdJZUZ0bTMyU3NBbTAzQVBpK2lYQ2pRQUp4aUJ3ODFWNE5G?=
 =?utf-8?B?MlVLc3hQeFVOQU9iWWpXTFhRSjJBeGowYnZ5ekFzT1IrcWw4VmlvdjRGeFRR?=
 =?utf-8?B?V0VPaW0xZ1lubzQ3NEtHdDFMb01aSEY1czBRYzNiZ2hPN1drY2lwWURHd1dG?=
 =?utf-8?B?eEhkK1FTM2t6U0hlYy8rRUNoRjc5REJiTjZoTkhFaTMyUkFpVUcxc2pnbGtW?=
 =?utf-8?B?NUJCQkk4NXd0cUJGakh0bDNJamludE9pRU1SbkFoRUUxbnlpYUhVMC9wdjFa?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9fab8a-ca18-4571-958c-08dd78394a7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:09:21.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcM/PQuWPEONS0bSt7qbnbmxinDYY0F+LlhOTH0pwvTZ0RaTftg9wRsaw+bbYjgYAKHUt+HnkTJck/gjSEtSEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5183

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows our bigger runners to pick up only build jobs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 39af030691..0bea8fc00b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -33,6 +33,8 @@ variables:
 
 .build:
   stage: build
+  tags:
+    - build
   rules:
     - if: $CI_COMMIT_BRANCH != "master"
     - if: $CI_COMMIT_TAG
-- 
2.43.0
