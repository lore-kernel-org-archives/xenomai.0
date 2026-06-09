Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCB348C62
	for <xenomai@lists.linux.dev>; Tue,  9 Jun 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020997; cv=fail; b=MNV6xdmMkm0T74m4qrVbbR7xuaLze6i9dTt9Ia5WCBKOsQbnVZ3OaOpnlm9mZQWsyHjBaJLIhcDZoTgfzQAN4wrbu7klKQPizAOa55efbl1K3L3ox9+KQMISGWmI8RAa0cPG9oiaz3fk+pQgfYvnwD42Qi6uOKI2w9AFaGUZC5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020997; c=relaxed/simple;
	bh=2CzHCBThINTNI7iUuOqT/K6KZKWcFsdd1KD7hE1uGDU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=Aymdq1mA6jY06Kc3X8E11QzlXsI2DR58ZsbaC5dC3cCzi7Ng/xmW840zF0sjTRU1TNPoedUeVWQNAMSgOHYX5bZEClCx9uugb5T4SCufJSHL8eJZBE86/IlTPZPivI+E0fUmm/cnilt5qFD9/iO4hQNpPOE0sHgQQvnlx7G3r8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lt3t2ClP; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lt3t2ClP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBZgcdpFo4Kq0WVaycSuBJjbpGZMEj7jVaC5/8JymaJkXQ+JJbf1W7+f70rIVuVoO5G7LLo8YHFrXupQYai4N4qvyUy7GsavaHC5llVcVnoztqP1jRauzUedGNCYoo4sQP98H6FzUMuFflnJhfUWuJQkvbHyvQSgipwIpfAt31SRfZqg/LxhCVvaP/4ZenYqO8clayOV8axwSLDT7Lj9KyELz04/HETUm3yB2V+izqlih669Ip+wWwRHHY68hyhUSwGA08Th/Y+SnxRzClK1RD/2COK3+EenjANgYrd74mZjDzFmpJutPA302jECp+OQjo3XD+yceiYdXieUSwe5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CzHCBThINTNI7iUuOqT/K6KZKWcFsdd1KD7hE1uGDU=;
 b=kMFXkFOJ2MUFI3Bn4lZosgMCMejD0Ir+6dfks03L027EgO8hWEMR8+Ksi6fWXAptEROHuaMWwu1dHj1Irop6BsJvFoAN6mozyzdkVa892KlI9XoLF9fG7ckX0ld1t9bc+wM26+qlr4M2abCzjTf6QEipJfcEWxqqJtMUZ/fp9okH70ACiDs9c+4pcMVCLEC1E0LTHfjbGk9qMveMwhDymYrqom0/nURqcJe3tjbN6Kw+NVBPIc9jaZ0UkT5c60217a5kjE9Hh/uEz+qu0oiHp6V4df1NIan/JNcGk6xAqHRtjYKz3JCD5F89eAvVqiyOKE2CBwwj31VI4RuIgTIFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CzHCBThINTNI7iUuOqT/K6KZKWcFsdd1KD7hE1uGDU=;
 b=Lt3t2ClPzfm5W6rhRK3mhjLdAG0FNtPdDYWlngJp0jvBLiMcdij81EVxxbivN36mK601JZrX49EXa3+jeTjh/VEc3NkiJPGjxGO53bUr8NrEqgjoAZoIzz8tUZBFyDc6yosL5QOy1EbV8uvL3BK808fkUyQ9Pqm/B3E0ruterOTXnOrewZVkZtwZhnMFA4fdtQCzQWJ27JiJXSXX6rDcQwT6TKRJlbZm+NjcFzRgFh9ZEYv217du/wVFIYnv3WWXnyuvCh4dpx0FXL5cIbZdQ2x7KC5ThaQqGDQWt+0lr/9NoFcxLFxbuFPQ5J/qVG1g8+1IA2DEXyr7z2Rq5rR5KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 16:03:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:03:12 +0000
Message-ID: <d90b3816-1522-4e8c-b769-8c9698f69b41@siemens.com>
Date: Tue, 9 Jun 2026 18:03:07 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, June 10, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
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
X-ClientProxiedBy: SI3PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: d151cc5e-feb5-4837-f1f4-08dec6409ba1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099006|4133799003|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	C8Btn1yH1RXVMIuDcFtq2rOID/Z8GTAxF4RvDzNp4+XvvX/3x4e7XQSRnyi/TyGccuC/2zD0ywGqcndcKOd/S8CC/rNo7YFxeOfFm1sA8Zzoshh2UIQXnvBX0M966h3R79XyWxsNXp70pFZlp77KnflDP5vLbBoEcr6A3jslK7LQh5zRSy6j3ffjAh4VP8BrFeUvNeiMzflcKgusjsozJCaL3KABDX9KESTagKasDiHJTivlugHRUdVpn4R3QHVHT4QTHd/0vRbp9mG1dCRXzP+cRfgHUBLjlIM7dZFWRsFrQnBQw13XoY1d5cEbzIoPE6N3PIPai3hrTo4rvswuIV2/DTJDu1uM+pumlEQiRUABQcbhKuH92ND9dgN6rR+68Zl/jRmPeV8bV8qLUfoYbaQgqPX2MEgoS4kQ5fkrZMb8HoTx33j650UEm89IimPnaWwv2ta1Yzxai16au5fZS5yP50M7KtVJbXHDK5UWAzBxtg1rTzvmNTb8Jdn9ELvxPTNgmayhyeOQjLdfhxZJp6Q/cen/mHbLD34SMBuKdhHH5qiDjPBSwIse7S73GaRd1d2Hs65dOVGXIJXjLgxvvtMBTuzUZeecMo47BWj6dp1YmfDuAQAwLSNwzGppi2RKBIHzHnwEXRLL/Dpd+N1BVhHxItXNFpDn9FPi54ZPweBdogJvvbmRczsoe+CFEZHL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099006)(4133799003)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW1rZlR2ajNBaWdtNjJDTVVnQ0ZycXE5T1JJUUxEOFZRYUluejlZdjNjdCtw?=
 =?utf-8?B?NVF5amFvak1hUWdwNVN1c1I3T0g3Z3ZPTjBaRVVBY1c0bHNOWDNNRkVXZmIv?=
 =?utf-8?B?TkxGU0N0aldKclNLSUF3ZWNNbzdGZjJIeXJiSHdFbm1yRytmNCtkekpIYlk5?=
 =?utf-8?B?SkN3aUFFSlZLYWdEZnZxajgyZU5pWDlnWGxlMmU2QmFPMW1hbTdtR2NIaCtV?=
 =?utf-8?B?R2NlTHNjZGV4WDJndUR4L05oOGM4Q2s1VURWYmMxODNCOTFKMTBtOEF1eHp5?=
 =?utf-8?B?ZzFZc2ZYclo5Y2ttaklPQzJBbGdLa1VMWnBrazJncTM5NUVoNkVLeW0xWVda?=
 =?utf-8?B?Y0xLc01seVZjd2JFNzNWaTN5anFhTjZ3MlNlaFB0N2hjZTVWYlZEQ2dNNGEw?=
 =?utf-8?B?L3FvNU4rNjU2NmNQK0NXYi84Qzg5bHZtS2Y3elNXcmw1RU1CNlYzZlJTRW1w?=
 =?utf-8?B?dHZvdlg2emhPZHpDZmVlUkNKN2JpVFp0ZWJ3aWVaekNFU29KSWRzUDNpVnk1?=
 =?utf-8?B?RUlZd0hYVkR1bVpNdlhrUzVGNE9tR0hONXZ2T2xTVmovM1YwWDFub2hWQ09B?=
 =?utf-8?B?WWRvL0VKSVR4bGNvaG5jaVE0NithUU1nWDh5ekE1ZkU0ZFJrMm45RTNDSlFN?=
 =?utf-8?B?RUlNYTJ0bmVHVmI2K3lRME9KRUZWQkxkZWdLaEVVUHFLOHhHa29tTXU3UlVw?=
 =?utf-8?B?Q0dVQnZlSEI2dGFNN0w3dnROblEwbFpucDNWMWVMSmErR3N0L2l1UllxUlZq?=
 =?utf-8?B?eDFmK1F1QzFyeUlEUDVFaHdFd2c4RFk5am1xMkxBbzAvVm5MbXhrOThZTFVF?=
 =?utf-8?B?RkJZQkdEQTJ4K3FDOTltYkVYTGJGK3Rva25HZXoyRHA5OHA4MkZFVTZlcG1y?=
 =?utf-8?B?T0MyelVKUDgwWDU5L29GWlc2UzlzSUxLRUhRQkd0SFNXWDcrdW9Ra1lIL1d3?=
 =?utf-8?B?eDd6YWlqTHpYemZjYk10ekhXUDM4bzdsK2tjY3p6QkhiZXFFL29rLzhyQ1JL?=
 =?utf-8?B?U0dmSEtNanNzMnphcittNFFuT3kvNlBvbXgwalIvbERxNzR3bE9nRDY0azk0?=
 =?utf-8?B?U0Nua3NZa3FvTkRXckwzdjJtdk55ZGprZFhhNXE5NUxsSS80TUV0bnZLSGV2?=
 =?utf-8?B?blUwQUV6Z3NYMC8xWVV1VXlRbGgzVUtRWERGRlBLaXpoZStIVVdVVGhxN0x0?=
 =?utf-8?B?b0c1cFpPWDI3YUozM1ZqRm50OVpXWmlTOXJiWEt6M0lhUmtWQlVJbytkcmpP?=
 =?utf-8?B?YUFLZnNhYnJuSEZjTnRhV1QxMHZpZUVSTGs0UDlkUWZUd2JZZEUvamg0Z0Vt?=
 =?utf-8?B?bDBXR3JFanRzQXVvSjZhQXJMR2Z6cVJlNVhubGdWRk0wZnF3NzVWbGNIVnF2?=
 =?utf-8?B?ZnRVOHI5VFprN3diRHk1ZzdGUXdXb3JxT3pRemNHdXJobm8veEZQbTRqK0Nn?=
 =?utf-8?B?S1RqTkRDaEQ1TEUvdlF4TGpPanF4bjI4WTNjT0hydURXZnpuQ2lOOFRqT0dJ?=
 =?utf-8?B?Qml3aUxjb2JpYk9RemN3YlJhNnJEUG96OTBweEdmK2grZ3hXNXVkeXZ3U3l2?=
 =?utf-8?B?S290bnoyUFFPYzluMVpUQ0xxdm9CWDdLZnZETmd0MkNneHVaczdQRWhjQ0Iy?=
 =?utf-8?B?Y2ZIQXAvV09CVkdGRDFtUXplclRhOHFCcG9TQnRReUFzbDV1cUhadWZDT2o5?=
 =?utf-8?B?L2JLYVlRV2FYaU1mWWhHcFdjZXQvRVg0Ujl4bncrWVg4ejBuQmpTMnpFUndI?=
 =?utf-8?B?U1dPOHJpOHcxNzZwMTBPVUNtdnoyUVp4amI0ZUVuNUtEbi9xbzFNUm5oaFM3?=
 =?utf-8?B?TlNlVkJ3Nk4zdnlxTnVMN3ExYjBEN0x1RnpPc3JXdjM4V3JVeGxHNC9wSGxQ?=
 =?utf-8?B?QVE2eDJiRXVOTk5kTmhmZHlXQnNoNFNYSlFUd3BCMVRma3RkeXgza1ZlQlZW?=
 =?utf-8?B?a2VDVmNFR2VVRnZHYTI5MzlPSWt6QmZ4K0s1SWk4RTNvS1hOSGR4Tks5ZGxU?=
 =?utf-8?B?Z1dMMmtPTmt2RjBEeTdZWXNublpkODZKM3hWbjFkSEdHTkJhTE5XNkFqYS9h?=
 =?utf-8?B?UEtSQ0htd2tEMERrUi8zVkg4eUt4czBFYTlVZkhpTHk1U3p3UzAzNmVXMEFz?=
 =?utf-8?B?dkd5U1JNVTNhS3ZnVVBNZFY0ZG4ramljdEJCSkpUWGZpYllhS3RXVFlNK3FG?=
 =?utf-8?B?SXk5MW1hNDBvdXBQMy9xTVdjbUV1Y2dZVkkzUDdQeUQ3cXQwYVMvdmpreXRu?=
 =?utf-8?B?Q2pEYjRkSms3NEYrZEJUTVJCT1l1aW1RbFBXbmorR0NpR1NxWEtJUlZnbC8v?=
 =?utf-8?B?cGVodFQ0c3lndzJVSFR0SzJWeW1RQ0VwUDlDcnE3SmZTRm5ncmZqQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d151cc5e-feb5-4837-f1f4-08dec6409ba1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:03:12.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUbVkc6KkL/kLLjMG6ecIa2VorJYTQ4F243xblpG0RBDmqfK1PGBIG1Ijc+ql7RXaQXmoVEFork2uNZP4xLMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7387

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, June 10, 2026, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
