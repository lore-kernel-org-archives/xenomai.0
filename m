Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F52F9D9E
	for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248905; cv=fail; b=LCkDePJXeo8lFq/y8zH5OZTa1yXGTNtvwLDN6TIMh1bLnyHCRI4vM6n7o6HVrFWDfpkDHkEge00hXQovCsO6Mf1N4AYHkdpVULlVypev04gvXj5WUUuEw1cY30szV1cuqQsuYEWgjxsS9unRQkz1yXK6H4K36R7gqEgmasViwxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248905; c=relaxed/simple;
	bh=igOsVQxo4j+IaxC0azaTxH0vQxLy92UGxaxNB5SVj9s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bSRra4Id6ho3A/DUJvmqCDloBkrTE+2GBlCwnzcTJ0kgpHBdsp/2ly9xshlUGkPOMHvXj5bpuhCMayJA8oC7GNi4qd7Mv8+FJiNFA74JeQs2M4o/Rzy0bGD7Q/aicGaKwXCi3yMoO1Q9IZZeGP5GjeRGH/LkFvR8iVKBUmI4p2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=B9vUkgZr; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="B9vUkgZr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZvzkv7sFvWL5zmi3+UJ/c2xBL6oancKcPplLZUVbh/iiq5sx4ODVCu66KnKBUjeKQULd7uDCvTD9uflwSdLtaXSzp7bEiYD/Td/4GcPT6TV6A3NE3FwFyeiszEnYQLAdlhlIuDHuXH3vn/jvUF8nJnzVL9nbSzvapk+dR8tNLG4U1cIPNQuJAIfUoT8oAJG6/rbXzLAUV1nSH9BV5BU2B0D3FSN/hiz7ajP6iVexW6Wo4D0yfwZOG0W5j+nNfwnZobkyALnxsXlKRpe7aGhTAKrliMS6LUIHqu7FUBQqkajTAFamixnRBsMoIh/H6RhIUPoPbPhGmzWIgjG4imktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxaJDuEp26Gzg2KZ8spp/WlB5QSZazfiP8rRS6Gd7+Q=;
 b=U8U95ri/AHE7IuXQ4lepyOGdx1D3tTmyU+vHuBcKuAB9OwEZf//I8cKVb7ekldXRNa+HcPSdNSjUjvlsyqKjBWsHCI8aJX+KRS6nMMMuCxiiVB3NuuVO2zVxrYT29qN6ZWfIXQUWuwqHMsMYb+v0tdmgeSGwmXZDr7W8fWgJmWSRAr4JFWhdBTdNb2NDUK2SYQ7yU5nOfLCMNvMG9P8cek2qcgYSx6VVlLK3ABiiuqbTDrAunx517DktcVV89fQ8tlvQCRYlgxb4v0Mhe4eUu2LAexz7ToDMqXY+9RJN9E+HMCSF61RGSgXt/ebk4N/A6XcJ/v/fOa2vcr8A1/OwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxaJDuEp26Gzg2KZ8spp/WlB5QSZazfiP8rRS6Gd7+Q=;
 b=B9vUkgZrOxCZUI1YY12RKpa+Ct94DyRAiqeAlBj2l61NFIA2ROFiICsFzLEF31inD4NcX51vFtLbk7hJUCkZyxQHqUWxkUejOyy7uR9GogffkRwrsLTlmpVjzlJC5jFNhOFQO/UQ/t9YMQpdnll2r0iM7gAuCrjTUWPB79z2N+PXRt2Jf4+t9rJJ27KbsljBXwfyoAAXc9VuRmGfXh50aDpRRmXzqn68RK9Gj2NHVN/wMFENl6Np0ksm7whWHPHNsC7rq5vJsZkGbgEZhfRCdgcV57k3Kf9+3h4auzw15fL7ttEwG4R+TkDTjPVyJDrPmAmY5VAp4J6f6GUwerT4QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 16:14:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 16:14:58 +0000
Message-ID: <8b63c1ef-d908-4aab-a28b-f158bde68542@siemens.com>
Date: Tue, 30 Sep 2025 18:14:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Used memory by a Xenomai 3 application
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
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
In-Reply-To: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 17201ce5-5e30-44d3-e89f-08de003c802c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjA0MnJzVGd3ZkhvbDdrRWFDUXh2d0E3YWhzdnZ1VVNmN2I3bFFuMk02Nkk2?=
 =?utf-8?B?OTZ0N000d1Z1cHdRUXdETktvcDdQdm9WSVlRdUdicnFMaFhmNVQzU080YVNv?=
 =?utf-8?B?a2ROdG85eVBYVnh4dzIvNzFTOUo1amErV09JYzJMVGQxYm5YS0VLaDZaZysx?=
 =?utf-8?B?elExUHZITXBveXBRQjdmQWltT0F6ekVXR3dBbUdRNjk1SWZtcGw1VFp1WlZy?=
 =?utf-8?B?UEJ2K0x3cS9mVEFHek5WYnNWc244UFAvcXZ2Q1pUYXdNaWx1YUFBL1Q1Vllk?=
 =?utf-8?B?UGIrUERFb0FlczM2aVM1aWdEMTBjZW1rVVpjR0E1d2VKQXFlZzRZNzJiN2Zm?=
 =?utf-8?B?NFZvZk1SNU9ONytpVXNLNTdqMkhRczRRUm5SQlhETDNGT1dRd1dNZzlWV21X?=
 =?utf-8?B?b3hCUjB3QXcrUitPOG95eGl0NHV3TEhrOTdDN2tJYVBGV2l6TnAycDU2R1hi?=
 =?utf-8?B?em41UDdaQjZEaXUwMlQwb0J0M3VGLzB1RVErT1hTdFdOMWhhbTgwTm9ldlFL?=
 =?utf-8?B?L3BWWjJaYVh0K2pVSUxBYTgzdXM3UlAzOU54Q1AyeVM3SUZpVURIZEZDdzBJ?=
 =?utf-8?B?Y2hkaUg3Zkt1NTVBN1pnTGZpbFVobTlFSStXRlBVV2xaenpDRm1rQTIrZjVV?=
 =?utf-8?B?Z2ExVG9JS0p0WkNtVC9NUGJzL1k1dEEvUExqY0dQa0FNQThkSDZkd3lQdUJk?=
 =?utf-8?B?eWw5ZlR2YjJON0pFZWJ5WFlUZ0lBcjJxdCtZd0hKNklGenc1NlVtd2tkVlMw?=
 =?utf-8?B?ZDZVM1dEN29LeEZMZ2ZLWVdPSFJGYlFRTEYyL1VETW5HQzIxOHlmVGN3djBV?=
 =?utf-8?B?R2psdHQvbmI2bUIzRHp3ek9TZFkyaytIRTBZMDRKak1RTjZwSXVOUUk0UGJP?=
 =?utf-8?B?Um9Sek1JRnEvcFdxMWNjenNxSGtwQkRNOHA0ZUhZMjlaaFd6YXpUeHB3UXU3?=
 =?utf-8?B?WnRaR3hETWxjVHFUQ0RUVmVUM0tHNXlReXZ4NDdCVXdDMmdzem81Z1preGtB?=
 =?utf-8?B?NSsxOExFNkZjV2RGU0txK2NPaWVIQWRzcGRTVVhPWWZ6TnJ3WU8yQmVhSlRX?=
 =?utf-8?B?dStyL0tmdTZYMDJHZUFtdGRhSG1mWkY1VDJqcUZsUjQyRmt0MmNmRy9lWi9B?=
 =?utf-8?B?V2JrVVF0WnlsQUc3S09zckUyNUR2MERrSHJaNkMrUnE4L2VsZ3c0USs1MHRG?=
 =?utf-8?B?SzlyZnNJREI5aUxoNFFrOWVWbGJpUmdySmY2bytXb1I4SnM1bkRyWjgrYnRk?=
 =?utf-8?B?TkV0ZW0yYlpva2tBQ1RkOGJWU09uMjhieWxySlJvYWZGWjgwemRKQTFyS1Mz?=
 =?utf-8?B?SEM5MnJybitsOU1ka1JTN21jUnplc09rQ3B4SHh2TUxrTmJxZWdoYWlVV3Na?=
 =?utf-8?B?WitLZklOR0UwZXVRZk9weEx3dThlQktCcFQzazJPZTBzcytVTXlGcVZ2aHdn?=
 =?utf-8?B?WWlvZHVKU2JPVXNSQWkvN0pLWTJGS0R5eDR0TG9pSjk4bTdaYUF2RXNELzZu?=
 =?utf-8?B?MVRFTERoT2NlTENoZWdvVmttbC8wTTJCZWt1cmx4WTQzTS9OQ0JBL3diNTd1?=
 =?utf-8?B?Sk9JVFVnR0h4b3lvajZNamxuUjVRUWlUYkllQVUrWW50ZStPUVdhU1FZNlJh?=
 =?utf-8?B?dkFEWFdOOXpidzJwcTJwbkFQYVhFZWZLVWQ4SDBZY1NIR1c0Z2NxWFlqeGxX?=
 =?utf-8?B?TTM2OWM5MjdySG1sNmhJZHVvY2ZOM1NURlJhWkdTYTZPK2NxdzVxcndYRmVn?=
 =?utf-8?B?OENrekRtYTI0UFVPcFFJa3BQc2szaXNsNFArbWFZekhORlo1eHV2cmNGTWdO?=
 =?utf-8?B?SjFJdTYyMW9iUmhpNzk3QVpqS2ZFaHlIV2FSbDVGbDdJZTViTlJuTmNUc01H?=
 =?utf-8?B?c2VwU2dRRU5PdWNRWEc1dTZwOWtpM3JEMEJQSHczN05lYXgvcnRJU1BXY1BR?=
 =?utf-8?Q?Uz/IG6XmkRUBjbg+fxnvLK4pTDCxw1JC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWhiYllsRE1qUWdNNjdwNXBSRlZQem9XVWR6ZFk0ZDlMUS82MEVIcDAyNlBN?=
 =?utf-8?B?MXhoTUxBYVc3S3NhbFdMZTgzdlp5YXBnZzdaMi9FcklnYVVhR2xZTWNoeHJR?=
 =?utf-8?B?R3l6a3JWTzRMMi9sWE0rZXJYZHpUQWY5cW1DdHFZOVRZV3ZGYnorNDI2b3A2?=
 =?utf-8?B?UGYwY1VOR0RrNGdQb2NzYms4NnJqZDg2ZXRuSG1hUVc2Rm5BbkxnK2RiaW5k?=
 =?utf-8?B?Rm9xYTdCeUxMaWtxa0gvb0s4QjZGNkRMVVVtcHJtNE9HdWJDUmxOYjNWZGQ3?=
 =?utf-8?B?RmEvWmx4Z3VFMXEwK2NFL0ZHRTVlQWJCUGFOb0lVY1pLeG1FTEdJSnJWblRG?=
 =?utf-8?B?b0hxUmRGWFg5RjlaTGQ5VS84SmFDWElXdlR1QXdwNnA2ZGhaSXU3bFhqdGV2?=
 =?utf-8?B?TnRIZ09oR1RsQm1SZzgvZnlpcjZKYWl1VUlJdkdUK2ZETDcxOVpjbUFnQmpq?=
 =?utf-8?B?MVQzZ25JWVVPVVp3SXVzRSs4bUorTy9FTzg2TVZMOHd2RHUvUjN5VkJ1UE9s?=
 =?utf-8?B?KysrSE14ZzN5VWJiYmtXNFJKZlU1eW1rVUhxSVJMQThNdmFta0Q5cnJoZXkr?=
 =?utf-8?B?WnZWdjNVTktsMkxLR1ZLdURraVkwSUlodnlvcllPZzRHd0UrZXdWWVI0RGs5?=
 =?utf-8?B?SzR2RDhwSjBNRFhaVEZvSGJZQVFEYkZRYUZaa1dWaFBvTUxMSGI1bjNGZFVH?=
 =?utf-8?B?UzVnbGRrQU5qcHB0KzhNS1lSL0lGYjBuV2RpU2ExSEx6eGdwQUdLTWNVeENC?=
 =?utf-8?B?dnkxYXQweUN5MEgyeFVIRnlpSThJYmJmbi8vazFGNEFBcGpLOTc2eDMyc2NN?=
 =?utf-8?B?dlc3NEdtOFBGcnJuL3haS3MyZUNROVdvMFp2NTI1TU8xalRteTJiQXZjVG4z?=
 =?utf-8?B?KzNWaktHWVRRUWVZd2w3OHI4U2JQTERITnJkN3dEczFabHhOUkI4MGZNbXhj?=
 =?utf-8?B?SVNZSzREUzhTMjlMWUxUQWRzTjBSRXllRityU3lXUHpxRDhMMDd1NjNKZ3Zh?=
 =?utf-8?B?NFdsdTl1eGZLS2o2RUVMWnM0bGkydWFYNXIxWWZYWlBJZURWREs0dGtmVGtF?=
 =?utf-8?B?QXhiWEpvN1dqSkNrN0puaGwySFNBeDEvU25DTW9wQThKT2FpWGZXRmJjaTlw?=
 =?utf-8?B?WDljOHpUWnVnMEcvN3RtQ3JtbUFoanRPQi9ZQ214SUpOQUdQTXJOOWdDcVd1?=
 =?utf-8?B?YVZnZWp5NEVZZkdsSThvVGV1UkFVUXRHS2RKbGRzRWZvTjVDM0RXVDRiZUdk?=
 =?utf-8?B?MWoyOTFNaHhpS0tRODhoTEIzcGtSZ01UYzFvWERnMzJGNFA2ZSthbzc1eVFB?=
 =?utf-8?B?eVN1NUFDa2htdm1IalVRd0xKWXZiblBGTEpPR0tObUVieUZFdFQrbE1RTlF0?=
 =?utf-8?B?eFVJam85ZGF2M1UrL0xNekZSLzRtM0srK1ViQzQzSGpBVGFUcGR2WUNrQVQ3?=
 =?utf-8?B?QUtLY1Y5RDIrL2NTZW5mWks0aHEyQjYrakdsOVdTb2gzakVnTWgxRHVTc2RQ?=
 =?utf-8?B?UVRybGhXNEVBRytRU2JOTnM3d3dMaERTY292VUxtaFNQK0xwd3FmL1dWdU9I?=
 =?utf-8?B?YmxhekpvdlBGczkzaXUxVjJrRWNGTDczVlNFV2ZBM2RETVdoSmFmc1draFV3?=
 =?utf-8?B?Y0Rja1F3Y0tvSzlGWGlraUsyU2dZV0xBVDZoMnB3REo3c1RaTjRGbG83TkYx?=
 =?utf-8?B?dm16Wng5Z3F3T3Z3UElrTzJMcHFYQ2xNOHRXMjE4a09pRkFqZFhyZkpVVFUy?=
 =?utf-8?B?a0ZVM3lZVXNWY0xDOUJzT3VCbjBnczE2V2htSVJid2I1RDRwWHAwTW8xTWtJ?=
 =?utf-8?B?VHBqZTJqM0ZvVHV4VXh3ZkJMUU1ENkVCMkZjaS9Lai9UclB3TEd3MU9NTjZs?=
 =?utf-8?B?NjdzcWZ3ZmJta1JzRFlsQWhiMmlmYlllNnkvUFpWU3AySkZFSWtUY0dmbXZR?=
 =?utf-8?B?eVByeG5LcVB3N29LRTFrcFdSb1RjSGFTQ1p5eHl3LzRhRm5MMDVEVHZFYkNy?=
 =?utf-8?B?a1JSWGZScWR5eGlBek5jSFBDd0lkeWRzRW0yRGR0L1B5NXlsdmVOcjVIdklk?=
 =?utf-8?B?VlpXV205c2c5dTN3TUtuZW9oSlUzVUlPd0hGUWVHbGluRUp3SkdxWVZUZXBr?=
 =?utf-8?B?VlovR2dvdGFGWHNoSFhBUy9uVWZ5ME04WUZRMW9hdGNQcVdtVlhFM0pPRFl6?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17201ce5-5e30-44d3-e89f-08de003c802c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:14:58.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcxHBkBGiQeId4JTxMeqMOTFSVA2TcAnZ5wMG+2wwm01gXyTuU1t1DfDmz1Eif/7uW4qzyBkbmPPtr58k31apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8808

On 30.09.25 16:43, Pierre FICHEUX wrote:
> Hi,
> 
> On Linux, one can get the RSS and VSZ for a running process with top or ps.
> 
> Is there a way to get the same information for a task running in the
> Xenomai domain?

A Xenomai process is memory-wise a Linux process - same sources apply.

> 'rtps' does not give such information.
> 
> Maybe /proc/xenomai/heap?
> 
> # cat /proc/xenomai/heap
>     TOTAL      FREE  NAME
>   4194304   4188544  system heap
>    262144    262112  shared heap
>    262144    262112  private heap[18470]
> 

This is listing the Xenomai-specific in-kernel resource usage of all
Xenomai processes.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
