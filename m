Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEC1ACEDE
	for <xenomai@lists.linux.dev>; Mon, 29 Jun 2026 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740097; cv=fail; b=QuXj8F84/hNsGrM6piZUFUZfu88aFkpWapFI4/hlhRNLEMuvd+95dYA0cHEbqcwhBVKrn+7V9sk5II9JIDkjLkuRNfRQr706gTK6qkKYoYg0mGa6SB/JwVHGYdZOX2LJTPsHTMUISUWVgU1xcPfw7Siynm/E1rzWDPcxe60Z1mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740097; c=relaxed/simple;
	bh=OU1y3WbckDrSgNairdupq2T9gj+LEJ48nVgNjXlgfZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L1r9tWRygEBhK9l/s6cbjBnbDt3x8FfNVqcB6d9UQyLrPy+oEQlXhK1gy2eJFD1hP/qRFwUGZMEv+2wRVfOrmv00tn5wWh8DHdfs1R6qCNUF//c1LqnJKkuBSNIuZpEMgk7bsqYajLXqbYlhAyVix4GBw5ACvfhWcfTWnadFfHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LMaXUhdX; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LMaXUhdX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0YB4yfqmATugdO1DMaQmv7fWNid1A5/zFUdnF14gU1hEric+IeBWxF9NUfdTUD6qurCRDn7YjZjr573q56Y+SRfVEWW1QmY+84tgsu42xkvbyPmv6+ofPxpMKcIGqDPZ0tQ+ZCtGFkYnyFmIMfkIMQs42vAOZHOFTTSlAW75pyIOsWe2HD7TNlN1UUVvVTw63iXJfrgoZ6d0ZMbtMLnudISpfq35zX7mTCGiNe5j+oQKwklbXSdQyzNJOfSRAe53wB7+gAEelPW0z8QbtyVCSiLs6RzHYvsOJ0pbTNa9EYoAIwDE+zeuYS2K8OldaCZlrV6FLfmsuxkImUbkvhNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyWOimpiA+ir6J6XbyAletgof0ZHwnjznIu8CMXBGHw=;
 b=XoKS0PGMBFHHcPJ4kT41kZKD+WH3gt7az1aO5B1f1Gq0YGwdqPb9nBWx6NgmxOEsjGee65gTwGWW2Ok1vyK7FzRuQjXiSyMvhQy+1AHU1TlWqWo9Tv8fHJl1qBcR+vIX3vsRcuys6VtBzuneSxJk0RmmtfbVqaybN7H5T1MZTYe1LQFtEIVgFXmSidnvslK96VmhVmRD/Oy8s8EoedR4wIFqaYVk90Kq0TXg0McPbz9M7CToLz5ZJQkAw72EFbxTn1djMaTpdKBhkOOkq0mmMteDIcwtEhn/eYbNMsf6DhDzMB+86YWzmgds2S0NPcc8Oxq8Ikwj2IyMTRB04cGl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyWOimpiA+ir6J6XbyAletgof0ZHwnjznIu8CMXBGHw=;
 b=LMaXUhdXZOta55QdkuZx4/082c9ZbXchh069d5O5Lv4GlXK/nOdQ6KEIVBSfE7SON1ZxAn11d40lLb6Rp2DVHFg0yepv+5qok7IHYENR9Szr2mAr8psTuMXNq6yTptqvLctMx2OhM5dojs1QngrGbifFU1EaJyVKuhywZb35xItqNavDj01yiImAMnLpNAkybfdqp8Tbk78yzcR2+e7RrrYvKE/X+kV0rnQrO4fsUXyMX0/4eKWEZR6ab9TARyq1F7NOdP3uNdqeJdavUKC/l7gMVCYNYzARsVXwqjDBg7z0/Eqd7LOl5RZUUEAl1hqIZEJ+gH08/G+ir1cy1Jm5Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7366.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:34:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:34:52 +0000
Message-ID: <c80fc363-6723-4210-903d-debfdc16662e@siemens.com>
Date: Mon, 29 Jun 2026 15:34:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: After upgrading from Debian 11 to Debian 12, the latency became
 worse
To: mars_liu <mars_liu2023@163.com>
Cc: xenomai <xenomai@lists.linux.dev>
References: <7acb182.9d78.19eeeecbe17.Coremail.mars_liu2023@163.com>
 <cda3f311-155b-408e-828e-e90c21c857ad@siemens.com>
 <d5a8d97.9cac.19ef9dccf5b.Coremail.mars_liu2023@163.com>
 <589ddc8c.9df7.19f134cea3a.Coremail.mars_liu2023@163.com>
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
In-Reply-To: <589ddc8c.9df7.19f134cea3a.Coremail.mars_liu2023@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0b91e2-7a99-4860-7c42-08ded5e3331f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|55112099003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	aKXoBI9bcYKb8Dj7LXEUqOFoyS1pSpDUFfgHimBD0NskvSNUBeIWlLX9qCgAi6Z0//zjG4wYC7P9ZoTPT9QdP9zA6X1RRjbS3XPE/EbNBU3RKpnivD25QQRnWVxhXSAX3Qw7xMnLnmU+of1Mr35YsVOpYyafU3q5Z4kkrpn+P5oxu7ZjOSJ5NgzAYH4f2s4zKsnEemuF00nkhUBi10v4w2WNWbbXeW8grTV5wmPeEB+NCaJj+dVVsF0+hPFkKuEIhzTaeD3Vdo3a1IVaxH2Ew+bsZ1v5EGrzPat6bXUjv6UUBbM7Ql+0QV29dYtODvPQYTcxHJSI/cul2Q7Qms9mu3zP12u7q1MDvIv9HJ02xcz+H18rys2O0bk3KOqRzct2CzoRTW1zAvxZfJcKIvPpPJ5jl7amu6SBPdEe3uePut+l7Wf8maUPefScn37gUalShl+b8yGzU9GMwd17IsIVPwpTAzYHew+iQP2r8l5eT2VlkiWNT0FZP28WypoLoG6gfG/ToQ9YwmCopofp2Gpow83rrj5XtDSB858LGwWaDFzJnCzwiOysnETtzTtV6C+8vCLuba5BzF/mabHTgO7k6KX3jWSruk1GR/jDSemc0WPRbpjSpKd0bgSMKReIRDbEgma1es8vlrrqa175ZHFMV8ia7eL9VR5tpZ2TBjllK1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(55112099003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0hLYUNBVW5ZOHNDYmorOHk3MVR4bUFERFNETVJ5azl6Q20wTVNxMzMwL21n?=
 =?utf-8?B?c285ZExoaklrZ2h2dVpIZmRNdzBOcHZLaGt6emdVa1BqQ0gwVEJyT1JFUFRT?=
 =?utf-8?B?YWVKZHVpVnVRQktHUEQrcUJtRWZnYmRtVkg3T2EreFJtMkovd3F2NkpvYjkx?=
 =?utf-8?B?UFFTYmluc0VBSXhVaStWYTNxMEJMY2xSV0FoVkxwRXBJOEdPZHNKUkkxS2hT?=
 =?utf-8?B?Y3RxL3NjWll3QkhvZmxpNjYwd0Zacnh6YVpMbzFUT3p4bjdVQkIreTg0VGdD?=
 =?utf-8?B?Mk0wQ3N2dE9UQ3A5c3hUZml6dUFFanNYZWFhUFJSQkZoRjY1Y01zOHpUL1BB?=
 =?utf-8?B?ak16NkJock1vd29vZGVzRTI3THJSU3FEdDNkRmN2UGVCSFliaUhjdU5kUVVR?=
 =?utf-8?B?UlhzQjVYMmxTaWR0dk9qZVV0NUpCVW5jNzdBRk5xZVpNdkpDeUVvSVI5K1pN?=
 =?utf-8?B?S1JjVWl2T2VOM2M3cUFNbFhlVWlpNjJnYVJGT2FqZTNBYjhJajlXbTZXWTlU?=
 =?utf-8?B?T2tqbXR3RllnZ0dKY2FHOE5tWjlDZHQwRnZEWks0dnlyeTNPMy9qTzZoVzFQ?=
 =?utf-8?B?dkcrOFVlbXNhZFVHQUFTL1JLNkxSZllSQXNiYUVqS3FFaVJzVkxnc2VUU0RT?=
 =?utf-8?B?WmcraFJPT3lsQXZZUzJWYlRlZUNlNEdXdU90RWJTd09ySmo1d1NJaHRpencx?=
 =?utf-8?B?bVRBMzZIWUV3d2tqWDRwR2VSTlZNV2RaNnZoWms5ZVlRcDZVTHBmVnRQaFly?=
 =?utf-8?B?cUV0NmRYdmw2OEIzbXppc3QzeUROWHo4V2tuTGJaUTViOGozK1ltYnA2RXFK?=
 =?utf-8?B?WFp0QjFZZUVFRnR0NmNiMzE1OVFWUjNMbDVpNXgrbUhjTGc5Y3NucWdXdGN5?=
 =?utf-8?B?dGJuSDcxc2VQSHgxaVkrR0o0aGRqVUpzempLR2c1T0hEQ0V3Qkt0WGNvQ1I5?=
 =?utf-8?B?UWFGYUJDbDJpVThYT0FWRXdhOU53ZTZwVlJCVHpCTFF4cXJhRnNvYTlnYm9I?=
 =?utf-8?B?cjhWZFZMa3RIRHF5WjUrOFNaeTRXOXZrYk5rSnU4dnJKNEMzcDJFeVJEV3J5?=
 =?utf-8?B?Z2YxZkw3T2YwWk45OUVpOXc1SExwdkYrNWtTWUVpbC9LZURNSmZOYmRSb0lq?=
 =?utf-8?B?V2ZLQkpiZ1hVZmZUSndrZFBQWThQSWsrNDlhWkhjb1hqdCtYbWhuSjE0SEhz?=
 =?utf-8?B?MWRubVNkaGl0eEg0K3JCMUVJckZOVDJLL3BiNTdMcTEvRUFxeEVBekxmSnZ6?=
 =?utf-8?B?VVdBVGdvUmE3c2hrT1pyMG92Yi9XUnEzWnRQcWtOVWFvS3Nzb0NFVUVWUFkr?=
 =?utf-8?B?RFRtS1JhZ25HaDJlSXpPSWFxTXpvanN2SGFyVFNtcG0xY21Nc2ZsV2UweWFW?=
 =?utf-8?B?VjJNWmVJVW5pNjhpYXhkZlVMMUdlZkFUUjhuTytEeVFtQW5yZllRMWtZbUhI?=
 =?utf-8?B?VU5YOUdNNmFMWHl1SzJVWW5WNU9hZC92K0hvMXp2QnpSeUVZSUFCNWZvSjlS?=
 =?utf-8?B?emNpMjdyU0JmREtjL0ZQRHJhemxZTUl2bk9UTDlKbCtFdzI3L0hGbEJWVDlP?=
 =?utf-8?B?aW01bVVmRGNzRHltc0l0KzROK0tBWTB4U0dFWGZKVXlvdWlkZk5jejdVcWRJ?=
 =?utf-8?B?WG1SQ2crOHZzYlhPTnlJN09RcE45VjZtcDF3TDJCWk9EZmNKNjVNTEN6R0FX?=
 =?utf-8?B?bkxDdXZDZEVDTExZN2UxUGt2cWQwV3RJRHNRWUJFVHZsS2pPZzViaHRNRytV?=
 =?utf-8?B?TTFsY2JUbWxZSzVLc2p4VHlhY2twNTIzdHlqSGNrMGNtTWlkU1VmRmJDQy9q?=
 =?utf-8?B?ZUVqMG9JY0RReml4ZHJuMXQxcjVRZnlPUFROdmpCTms0SHJ1YlVoQXd0cnRN?=
 =?utf-8?B?UHI1eGcwR2J1V2ovbzgvUjdTOFpMVmN1ckl2L2NjOHJZRjh5Z2tZbXgrTTNs?=
 =?utf-8?B?SE93TWFkcDhBaVVTdGl3akdLeERHeEplRlRLT3hvSHN2TkVkMnFOUWQzaWty?=
 =?utf-8?B?UXVVR09ucEc0VlRhZzRoU1FpbCtqWnYrbUM5R2pKVUN5MkFOYS9adm5oQ0lW?=
 =?utf-8?B?dnlsdFJyUXdiZWpLRlRRSFZxRGlsVVovOG02V3Y3UDhCVmRTaExlbUwxZThS?=
 =?utf-8?B?ZElnRDQ2Yjh1WWdoUW11Y2VWbGY0TVpNd1QvaUlZNVR2V01FVmNPckhybnV2?=
 =?utf-8?B?L3c5QzN1VHVKQzZ6TWVRNjI2WVQrRDR5dGpHQUx1OVh5akRVK3hEUHVQSFR0?=
 =?utf-8?B?QUNwMTgybjJOMHR2Q2VaR3V4NTNPSHh5VGFCNVZHUXQ5TGdiZCtacE9qOEs1?=
 =?utf-8?B?UU5HakRpcDRoalFoUTVWU242RVhmazU2UVlwd29LOFpRMUNTN0d0dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0b91e2-7a99-4860-7c42-08ded5e3331f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:34:52.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7umMVwShKB/omVFMroQZyg9GHYrkVUVkSuuGHyByc0G3VQLtyBa27CZXKO6BPuF3IHz8jPzWXgdHDWrYB+a4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7366

On 29.06.26 14:13, mars_liu wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2026-06-24 21:40:58, "mars_liu" <mars_liu2023@163.com> wrote:
>>
>>
>>
>>
>> At 2026-06-22 22:17:28, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>>> Can you try to systematically eliminate variables that may contribute to
>>> the increase? E.g., use the old kernel with its original configuration
>>> on the new installation or go back to the original Xenomai version.
>>>
>>> If the kernel is the cause, checking once more if the effective config
>>> of 6.1 is not missing or adding suspicious things compared to the
>>> effective 5.10 kernel config.
>>>
>>> An alternative is obviously turning on tracing and record one of those
>>> events that are longer than expected. At least basic event traces
>>> (cobalt events) should not increase latencies on their own a lot while
>>> giving a general overview what happens.
>>>
>>> Jan
>>>
>>> -- 
>>> Siemens AG, Foundational Technologies
>>> Linux Expert Center
>>
>>
>> I was running latency test with event trace on. Initially I enabled cobalt event and irq_pipeline – got result 1. Then I enabled local_timer_entry as well to see what's going on, got result 2. Both times the test cut off when max latency exceeded 70us.
>>
>>
>> result 1:============================================================================================
>> 	      ...
>>              ......
>>              dd-1728    [000] *.~..  7426.819882: cobalt_tick_shot: next tick at 7426.819975 (delay: 93 us)
>>              dd-1728    [000] *.~..  7426.819883: irq_pipeline_exit: irq=524547
>>              dd-1728    [000] #.~..  7426.819883: cobalt_schedule: status=0x10000000
>>              dd-1728    [000] #.~..  7426.819883: cobalt_trace_pid: pid=1728, prio=-1
>>              dd-1728    [000] #.~..  7426.819883: cobalt_switch_context: prev_name=ROOT/0 prev_pid=0 prev_prio=-1 prev_state=0x18008 ==> next_name=sampling-1732 next_pid=1736 next_prio=1
>>              dd-1728    [000] #.~..  7426.819883: cobalt_timer_start: timer=00000000885e65cf([watchdog]) value=1000000000 interval=0 mode=rel
>>   sampling-1732-1736    [000] *.~2.  7426.819884: cobalt_trace_pid: pid=1736, prio=1
>>   sampling-1732-1736    [000] d.~2.  7426.819885: cobalt_head_sysexit: result=8
>>   sampling-1732-1736    [000] d.~2.  7426.819885: cobalt_head_sysentry: syscall=read
>>   sampling-1732-1736    [000] d.~2.  7426.819885: cobalt_fd_read: device=00000000705fa65c fd=3 arg=0x8 pid=1736 comm=sampling-1732
>>   sampling-1732-1736    [000] *.~2.  7426.819886: cobalt_synch_sleepon: synch=00000000a14e53ef
>>   sampling-1732-1736    [000] *.~2.  7426.819886: cobalt_thread_suspend: pid=1736 mask=0x2 timeout=0 timeout_mode=0 wchan=00000000a14e53ef
>>   sampling-1732-1736    [000] *.~2.  7426.819886: cobalt_schedule: status=0x10000000
>>   sampling-1732-1736    [000] *.~2.  7426.819886: cobalt_trace_pid: pid=1736, prio=1
>>   sampling-1732-1736    [000] *.~2.  7426.819886: cobalt_switch_context: prev_name=sampling-1732 prev_pid=1736 prev_prio=1 prev_state=0x4c042 ==> next_name=ROOT/0 next_pid=0 next_prio=-1
>>   sampling-1732-1736    [000] *.~2.  7426.819886: cobalt_timer_stop: timer=00000000885e65cf
>>              dd-1728    [000] #.~..  7426.819887: cobalt_trace_pid: pid=1728, prio=-1
>>              dd-1728    [000] *.~..  7426.820043: irq_pipeline_entry: irq=524547
>>              dd-1728    [000] *.~..  7426.820044: cobalt_timer_expire: timer=00000000a7d2b833
>>              dd-1728    [000] *.~..  7426.820044: cobalt_synch_wakeup: synch=00000000a14e53ef
>>              dd-1728    [000] *.~..  7426.820044: cobalt_thread_resume: name=sampling-1732 pid=1736 mask=0x2
>>              dd-1728    [000] *.~..  7426.820044: cobalt_trace_pid: pid=1736, prio=1
>>              dd-1728    [000] *.~..  7426.820045: cobalt_tick_shot: next tick at 7426.820075 (delay: 30 us)
>>              dd-1728    [000] *.~..  7426.820045: irq_pipeline_exit: irq=524547
>>               ...
>>               ......
>>
>> result 2:============================================================================================
>>            ...
>>            ......
>>              dd-1510    [001] *.~..  1689.009700: cobalt_tick_shot: next tick at 1689.009796 (delay: 95 us)
>>              dd-1510    [001] *.~..  1689.009701: local_timer_exit: vector=236
>>              dd-1510    [001] *.~..  1689.009701: irq_pipeline_exit: irq=524547
>>              dd-1510    [001] #.~..  1689.009702: cobalt_schedule: status=0x10000000
>>              dd-1510    [001] #.~..  1689.009702: cobalt_trace_pid: pid=1510, prio=-1
>>              dd-1510    [001] #.~..  1689.009702: cobalt_switch_context: prev_name=ROOT/1 prev_pid=0 prev_prio=-1 prev_state=0x18008 ==> next_name=sampling-1512 next_pid=1516 next_prio=1
>>              dd-1510    [001] #.~..  1689.009702: cobalt_timer_start: timer=0000000086a46b6d([watchdog]) value=1000000000 interval=0 mode=rel
>>   sampling-1512-1516    [001] *.~2.  1689.009702: cobalt_trace_pid: pid=1516, prio=1
>>   sampling-1512-1516    [001] d.~2.  1689.009703: cobalt_head_sysexit: result=8
>>   sampling-1512-1516    [001] d.~2.  1689.009703: cobalt_head_sysentry: syscall=read
>>   sampling-1512-1516    [001] d.~2.  1689.009703: cobalt_fd_read: device=00000000693aa32d fd=3 arg=0x8 pid=1516 comm=sampling-1512
>>   sampling-1512-1516    [001] *.~2.  1689.009703: cobalt_synch_sleepon: synch=00000000978f36ce
>>   sampling-1512-1516    [001] *.~2.  1689.009703: cobalt_thread_suspend: pid=1516 mask=0x2 timeout=0 timeout_mode=0 wchan=00000000978f36ce
>>   sampling-1512-1516    [001] *.~2.  1689.009704: cobalt_schedule: status=0x10000000
>>   sampling-1512-1516    [001] *.~2.  1689.009704: cobalt_trace_pid: pid=1516, prio=1
>>   sampling-1512-1516    [001] *.~2.  1689.009704: cobalt_switch_context: prev_name=sampling-1512 prev_pid=1516 prev_prio=1 prev_state=0x4c042 ==> next_name=ROOT/1 next_pid=0 next_prio=-1
>>   sampling-1512-1516    [001] *.~2.  1689.009704: cobalt_timer_stop: timer=0000000086a46b6d
>>              dd-1510    [001] #.~..  1689.009705: cobalt_trace_pid: pid=1510, prio=-1
>>              dd-1510    [001] *.~..  1689.009800: irq_pipeline_entry: irq=524547
>>              dd-1510    [001] *.~..  1689.009861: local_timer_entry: vector=236
>>              dd-1510    [001] *.~..  1689.009862: cobalt_timer_expire: timer=00000000ac269294
>>              dd-1510    [001] *.~..  1689.009862: cobalt_synch_wakeup: synch=00000000978f36ce
>>              dd-1510    [001] *.~..  1689.009862: cobalt_thread_resume: name=sampling-1512 pid=1516 mask=0x2
>>              dd-1510    [001] *.~..  1689.009862: cobalt_trace_pid: pid=1516, prio=1
>>              dd-1510    [001] *.~..  1689.009862: cobalt_tick_shot: next tick at 1689.009896 (delay: 34 us)
>>              dd-1510    [001] *.~..  1689.009862: local_timer_exit: vector=236
>>              dd-1510    [001] *.~..  1689.009863: irq_pipeline_exit: irq=524547
>>           ============================================================================================
>>
>> In result 1, the max latency interval was between the expected next tick and irq_pipeline_entry:
>> 7426820043 – 7426.819975 = 68 µs.
>>
>> In result 2, the max latency interval was between irq_pipeline_entry and local_timer_entry:
>> 1689.009861 – 1689.009800 = 61 µs.
>>
>> What caused these two scenarios? Please give me some hints. 
>>
> 
> Hi Jan,
> 
> Regarding the first result, when the issue occurred again, I didn't see any SMI. Usually, the interrupt delay is within 10 µs. What else could cause the delay to be more than 60 µs? Or do you have any suggestions for further debugging? Thanks a lot for your help.
> 

Power tuning is one of the usual suspects. Or hyper-threading (if not
disabled at firmware level).

You could try running with the function tracer enabled. That will
massively increase latencies, but if you do that both in old and new
kernel setup, you may see qualitative differences.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
