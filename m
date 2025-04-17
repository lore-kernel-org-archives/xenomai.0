Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012057.outbound.protection.outlook.com [52.101.71.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4710E5
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890845; cv=fail; b=DU0NIWYJOV3hwZLOGdznGuHauh6VB/pohND/Dz5iDvrlGkMhr+jH/EusomhIXqTUV/vc8SJUAcrNEWuHiWMXfbHD3VEI65u0e7R1SVcuG+z5T9Hj8o1Av2QGWCTtlx/cnCT4YPdj/aZjfrztToUESaVi+nJYPh3j11dBZay5DAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890845; c=relaxed/simple;
	bh=cwvj0h1F66aBOXH9Y5qu2RT1igymevZpsD/FTxImqDk=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=ZnxsMXFZu2wLgqis2xmE/Ohu+5JjlYfMKR63RkGCHgsvGvQJx3VIMo3U9BqqF1/trEQOb1Rbo4tuc6l5oUhcIJUdIuKjjgS8XICsqzeC8NQczL6bazR9/srLYsAVGSgwr7Tk9qcKIGMEwSH3XFhMa2sheVwiV7LbF78v+QfQcNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=T4sLZPDP; arc=fail smtp.client-ip=52.101.71.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="T4sLZPDP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVd05dXB7QUGQ6qh1x+ZdZ5qd5+gXiQui5Ziee75ZJL1b+XQwvzo0XaqFFqrNTgrCuyoy0vjaYHB1qNWDG6J9LZhQ/EvMfy7OG+Szs30OEVVuHrrIwGh6WIIn8DZFDloEcvDO1SyeZgeO2NK04G8dy6KxufM0hDbSDrmfDGaGchN411bpj41EF1i4Is37GVkeHMdaXdzJmLEOXJTwOI0bQhb3SnbZcOxBZeXXR0fe3L4PKrVchgN9BxppyaEJPjNkNCkTlCTu7YqPL59YK2B/DANXkHxx8DzL8er1g29AdlxM/3dwZiYkBPMewOz76GX+Bf58U5O0CewsHm2i+8BCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3Y4mzR0dT9iWl37VPOA3W/kZOxfbcvfAZW5bpJIdB4=;
 b=w3Ym5NeA8ResKC2ei1itTAfN1y1VhS4ATISpZwAK7a3Vlm1vqeYGnqrUnT8QSWYTPXxlFlcLu9o0yPfs/asLKl9azV6xNRvvB0T6cKNn8P/BjmEbXxvfkU0xkYkU2jlP6CyGFS7O7NK77WqnHKqWoxQtHvdAhwIRlo/b4mL5snRFMhigTEkp0GCp8AtO+VYGUHT8WhnCMQcczUxi5Pbb/Tk0To/CTOtDO5m9d6+pzv2068PkHmToYQ2k/SLt8XeFDwx6yyJQZR3O8exgcXKWcC3So835tUr5cEAaJgni3xGCddI2QX3wuE0anptmXyL4xwdK7F8j0FSX+SRQzVg0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Y4mzR0dT9iWl37VPOA3W/kZOxfbcvfAZW5bpJIdB4=;
 b=T4sLZPDPSffz/lFFE8sugGjsIcLJ9v//+R33TCHYv4FwUehlmMc3+XFRycGNQGFhsVDrf1v+Bml6vuXfZsYb6z57KeZE9t5DU/6AFLlsmDu6i0Q9Ncj5gowe8C/UqnXPJqvrfZQGCraWp2MOrrO3b39nSbDHpBObtTeeoYLSoO9kNeApbygJ2AFbGbRS7uOKS65kV524bTLg4ofwPIJWuPSwbYqV/6eTkEkaFjZYTFla1+bfGjnPfoyhqRsiCf7mT2LlXirNBOdZeAOwNUyaSp3m6CKkljdzx8p3SfFktPpImZrrDyMkTpDT2oU+dXYN/ZbIpwTIJ95WXM0QHlUG4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 11:53:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 11:53:59 +0000
Message-ID: <38d1574c-12cb-4095-a0b1-f5c497344b46@siemens.com>
Date: Thu, 17 Apr 2025 13:53:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.1.6 released
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
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: ac955f0a-d7b2-46ae-0651-08dd7da68a1f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlJoN2VOVTk0TnBsbkhwVE1sc0grc0g4ZG1lM1oxZXdQYTI4WHo3a0loYTVh?=
 =?utf-8?B?d3V2UDZXWm5sUGVON0s3bGdXYitRUzFENVhITTFidHFOWUFMcFE1RHJrTW1o?=
 =?utf-8?B?dVdrWC96NjVMdkNpdGZ2OTl1dmV0d3E5NmRmLzZpQThBaW5kTHJTdXdJdHo0?=
 =?utf-8?B?bzFCSysycTdGNWlhQytiMStrMDljOHRkYVNHRVYwbmJoTldLK25qL1ZNejQz?=
 =?utf-8?B?K3ZMTGxJMzdQWHZyNjAyMWRiZmw1TDlHaFNiU1hNQjhkblJ1TlVKRy9nL1Ji?=
 =?utf-8?B?Nys2WkxBcDNKMzZqNE8xbUNaM2tpTUFjaWdyZFVoQ3RpYVNLTTU2WDJUcEJa?=
 =?utf-8?B?cjJXbm41aFMzWVRmeURhbTRCTWppVnVvbzdzc3V2Tnkwdmg2dGQ2d2RTQzMr?=
 =?utf-8?B?M2F6VVJrL1JRN3hoMmJFOWN4TytYMG1LazVOeXppVXNTMGU0RHR6UUthM1l3?=
 =?utf-8?B?ZXVBb05rYm95ZkQ3SmY2OVVVOEU1YkdNKzBWcW0vZTJneVh5WlJ3em9pUUwx?=
 =?utf-8?B?RkozdmcvVkFpTStaNm5xWFZDT1J1aVIzdEJoNGFzbG1xWFltNXoyTWkrbG12?=
 =?utf-8?B?anNRMEpoa1NncnBGSXZDbm1peC81NFRkc3MwTmV2R2R0VHhXcDNyYkJUUlFv?=
 =?utf-8?B?eXpuVXpObGFwNkI0ZTZDekc0ckZuTTZtUjUwUTRPVHpVdCtYV3YrajZIMVJG?=
 =?utf-8?B?MUZ3N05MRDZIYkhBWDEyWE0vK1A0L1FmbDF4SkFrQW5TZi9OUEFOcU1NTnA1?=
 =?utf-8?B?Y2l3RmlnMnY1dUVMdWo0eGlpTWxIdVE1YzBENmt2TU5UNVY0dVBoTkpCejB2?=
 =?utf-8?B?ZllraUd2VDNHckExc1V3V1NheEE2RWpHSndVLzBpeVB4TFZkSFk2bzMwbmZT?=
 =?utf-8?B?MHVBeDdKU2tnZW1mWkVzM2R5dG5KSXpuVXorTEhEcGNTNmptNE44UWtVdmUy?=
 =?utf-8?B?Nzd4NGgwQUlpK0hoc05TOGxqcW85VnNJVUJOam9zeGM4TmNEVTR1bUVBYjhY?=
 =?utf-8?B?Kyszdlphd3h2eGpseE1LMkd0REFuUUUxN0pMcmkyc3FWRU9ybTFvNFNUV2lF?=
 =?utf-8?B?SVpsd3V2b2lDMnl1QjJBd25qSXRBZnVONGg2Wk1RRktTRVBlc3N3bXZITU1E?=
 =?utf-8?B?Q2FmSmxJRVFjTXBFMm5rV3hJMENGOEM5d0pHQmx6blplUXBDL3BEVHI1T0M3?=
 =?utf-8?B?ckxaQUxSZ2ltcmJoQ0FBR052SzNBWXN4ZWpYUHloUFJhVTBUSWVxYnV0VDF4?=
 =?utf-8?B?aHdoTzZ6RjNZZFFkdElmZmtSUE90R0dEWFNyQnJHdUZ6ci84bmFPT01IQXlu?=
 =?utf-8?B?djlrUmpRVzh3bS9MZzZSOG1JandCZzJKZE5ZakxMV3JLUEpxUmZXMlNzK2ps?=
 =?utf-8?B?WXBYYnZrTnJYS29LcGFkR0dEaDZKWFZLbE9GVCtIKzZ5TDNtaWVWMnpaSFEy?=
 =?utf-8?B?eVlOQ3BkMUJRNnJ0VVFGV0xOY2pRODFsVFkwTGpXeWdRR1ZsZEw0OUhhbmhn?=
 =?utf-8?B?MmpSK2ZjbDNUNm9kRWVPTVUwb3g1NGZKayt4Y1M5SGYxblZIZkRzN01RYUZw?=
 =?utf-8?B?QkNXM3pJeUVWQnRGQjZYOXNWSE1QSGdBdjdKVlB1NWl0RVBKTHVjNTNPSk9x?=
 =?utf-8?B?NUNmektTZ1dGZFBSQjE1SnJCMFQvL1RnR0Z5SDE3bEhlM2NFeEJhRCtmNEZC?=
 =?utf-8?B?cWVBWVA2YTdFQVI3V2pFcWFtUmE0TVBUSnAySUEyQlArYXRwYmNZdnUvNTl6?=
 =?utf-8?B?UUEzYi94SnM5eURvTnlDZHYvV2lFVmxUcDI3SVRSc0pVUndFZFZkQnZIWkxq?=
 =?utf-8?Q?IS/PJ7yvyf81fuSg6yz6PmOeeW5NwlvH7NkBE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ZFbDlTM3o1b3czb2VQWTdnVXhCeCtkbzZvajZRZCtxOHlKK0QwMzE5RmRa?=
 =?utf-8?B?TzNvUUI5WFd3K1ZNeTl0c3p5TVN3d2sxU2w1V2FEeXprRkhZR2VoUzVkaVd3?=
 =?utf-8?B?N1dqSHZrcmRJMU5raUl6N2Q1c1gveVc1Y2plejMxSVhTSFNGTUlhVVgyYkE5?=
 =?utf-8?B?Y3Q1eVNkK09qQnpWRHY2b3AyWnRYTlkvK1FzRnJrdjE0eTlOTVhrVDUzT3JE?=
 =?utf-8?B?ZHdYWEZHUml2VktETzFPSVFnK0kyZllMTzlhMXBsQ0hpdVE5VWp4a2NFQzNH?=
 =?utf-8?B?Qjd0YnYwSGE5RkVmZHFQMStVcnZpQWpXY3NIb3NpeTc4ZGtrdGY0YjlTZ0JE?=
 =?utf-8?B?YzZ4QTRwc3p3NjR0bHUySEgwdDBrN3Nkc00zN2FjMmd3Z01iMElCVmFOQ3Jq?=
 =?utf-8?B?ajk4dnVRd1B3WDBVTlZiNEl2ZlpxTWFxdWpqZTN0Q2NNelo0ZDlJUlpkY0RE?=
 =?utf-8?B?K0ZSMGRPZ0ZZUmNlTGF3TXdDc1dGYnJBejRpRC9pTUcxb2ZidzloWWdqNWNr?=
 =?utf-8?B?MUlqalNTVlFOL0s4VFFTQkZjbXp5NTY3c0FpNndhcThRajF6N0tSeFRXWHVl?=
 =?utf-8?B?bkgvUDg3enhybXcwaEJhZ0xEL3h6T2NqWmlEbEpSRUl3ZXk2b3JjU3ZkaHo4?=
 =?utf-8?B?Q3RNcFZYQjJwRHU3Z284aDJORlVwNHZXSGV5NHl5QWs1eG11bEkzaGVqdENL?=
 =?utf-8?B?YXVhLzZTRENlNmYwV25OY1RITi9UUTlOZ2tRMlllZWZXcTJoM0owMkZ1bm9J?=
 =?utf-8?B?RDRiNFYvdzJ6dVJxdkhUem5WSDVmUXMwQStEUjVWMC83SmFYa29qWmhzb0x6?=
 =?utf-8?B?TVZmWmlBblZhbGE5SGtzbWZaRzJoNlB0a1ZZcWszU21FUzM4UlRmMU90ZnJH?=
 =?utf-8?B?am1LdDZOSjVXaFgvTEhFaXZEczg4UVozYzI5U1FoaDF4c3dqWUN6OGtlS0tm?=
 =?utf-8?B?NnArMUNSczhRVWwvdzVwLzhKTkhuZG5uWDZ6KzZQREk2a2tibElFMnROMlJS?=
 =?utf-8?B?czFWdzhoalpHSWFocnRUSUVtSjhDNnM3OHppY2VCZEp2ZlFIclREOGtXbzNK?=
 =?utf-8?B?bTNJbS9Cd2RJdFVJc0FjSmJuVHFCc3FkQTlVSUpFemh3VmJjVmhXeE5YVm1j?=
 =?utf-8?B?QjR2K3dlTk1lSWZCQlNxeS93YlQrSkNyV1l6cWxDL2RUY1Q3QmZJYVRLOUh2?=
 =?utf-8?B?MXZKS0NvV0oxZEoxMzB5akduZXNjNlF3MGdRMnJHRG1DK3habXREV1lFQ1lX?=
 =?utf-8?B?dU5CRGF1QWVyUkFYbWlhU2x1RGZJV3dSQXZnZC9UTjNzSmJwSENmeHo0cG95?=
 =?utf-8?B?bCtnRU1XQVd4Vncxcm43TGx1MnN6eUdFRklpem0zeXozbS8wWGE4aG1wSnNQ?=
 =?utf-8?B?SWZHbXN6SGlnRWJ1azFEbEFGczIxdHZ2WXd0RkFlVFBtWkQ3dGR0a2MrRURX?=
 =?utf-8?B?WTNrdmtoRmdtRnRaQ0NWZ2FKSnBNa1RBZ01lc25reUFpVWMxc09rejkwcGNV?=
 =?utf-8?B?L1dvWWt0UlNyeDdQOWc4SVZTMTJIekF6dFFBVjdNM0ZHL3NVeHBVM09RWlpl?=
 =?utf-8?B?WTZvMUFmT0gvZERuT1dDWWtwNEEwWTlwMW1kVzZLQm4rRGRrNXhUY3RlU1JP?=
 =?utf-8?B?WUxXaFQ2V3lJb3pCR0l6dkRuOFdVVDNpVkpnSTdlQ3FmUGxGSDBaUmRtbzNW?=
 =?utf-8?B?d0ZENWNJem53NkRIUk5QeGRiQjI5YnBmUGhXODFhdkI1c3lWbGlTYkQ3dFQ2?=
 =?utf-8?B?eU9XR0UzeEtJNkJCb1VHWkZwNnNvaDNhdGhld2x4OFIyNVVGK3Vvc2R5SjhE?=
 =?utf-8?B?UTVaSitSUDdxdVh2S2ljUENVNnJJaTN2M2tHckJHODZFeUUrNDdiSmdLa0VP?=
 =?utf-8?B?cFAzSmZSYkFRWC9LMFNRMUFYVHpKc3h0Mm4rVXhxV09QL3dTQktZamZ2bzBM?=
 =?utf-8?B?SzdxNnFMdUZxK3NNS29KZnpVblQycHcxUGhSWlhDbmlmTFZMc1VOMnRHdk5h?=
 =?utf-8?B?czdpUTNkZmp3bVNRby82U1Z2T1BnYldCVVdqL2EvVHdvSzhZeFV1dGlJTGYz?=
 =?utf-8?B?SnY3ZFcxUTg4aE1leVBubVgrWWFaUTFIUXVuOVB6QVZJZHp1d0FKSjV3RHo4?=
 =?utf-8?B?TWNPelRidEk4SlNmVkpGSnNzMlNnK2daajNSWnJxSys1SU9YZFRISmg4Nnk4?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac955f0a-d7b2-46ae-0651-08dd7da68a1f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:53:59.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKTDUeGJAt1xdB8bbkf6NzrDT37u4sr0r4z3u0D7rFzzmYtXd2qP2xDcvNC8lX5N/NUnjWbHmcGIhjuffQOe1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7082

And here the stable update for 3.1. It also includes the recvmmsg 
timeout change [1].

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.1.6/xenomai-v3.1.6.tar.bz2

Changes since 3.1.5:

Florian Bezdeka (1):
      drivers/via-rhine: Fix a build warning in via_rhine_init_one

Haiyang He (1):
      lib/cobalt: Fix a deadlock when release_buffer() attempts to re-acquire buffer_lock

Jan Kiszka (10):
      ci: Do not run CI for tags
      testsuite: alchemytests: Give more time when running in a VM
      cobalt: select: Move nfds range check to caller of xnselect
      ci: Exclude master branch from builds
      README: Update links according to our new homepage structure
      cobalt/vfile: Plug race while opening
      kernel/cobalt/posix: Stop supporting timeout parameter in recvmmsg by default
      ci: Tag build jobs
      ci: Fix detection of tags
      config: Bump version number

liyinjie (1):
      kernel/cobalt: use flexible array member for symbol in struct hashed_symbol

[1] https://lore.kernel.org/xenomai/8e0ce080-1167-486e-8887-9fd8a3d250dd@siemens.com/T/#u

Jan

-- 
Siemens AG, Technology
Linux Expert Center

