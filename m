Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE72DC77A
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130270; cv=fail; b=cGg1yaHMur9P3DYstEQR4KyKmDFf7eVn/lPC5atyQoOrud0cz0zTlIXjlsjftBAGlQV6QxSVx5VjeDhR0HhYF2iteEEGwrbkW6s/KLLaXWf0N7dO4fBxopp6FGpRuuDhfwsIOwNg5sE24iguWHp8OBqnG7NaKHVuFPyrrWSzYWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130270; c=relaxed/simple;
	bh=daMsE1zMmmUAgj3ZwHnkYje49T4C/soFz54PIsRzFKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PJFyMkItni0yMxwrOvCWnl7ZK+6kp8yY+MVehClLQxURNBIUJqgmbJMhmlEatkEdrnY1cwt0C0fiwmWm3AOogHBbJi17MCOy1ybpVOih/bqj+BH3EeiAcQ3C/fxKWXoiYBcyUGBAdPU6nueZvD2UNH0nhOYAzN9q02BDnXErNbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Dw4dMleo; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Dw4dMleo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8ES34qleJlv2hYumO9NLckKZddkZdth2HuXzkgAkki/WK8z8cyF1SIs597J0kjq3u0kjjGmOR8/6evLknGOTtuPUyjgdmFOR1Mxd10L2G02KWPqYOTOOfBSkrtAtFHganR/hEyv2kf5L2sFtoxnqqttFK3Z2liAxA05XHHhqx3wR71N1LRhjvXYFLExnauw2FGdUETJ2qNXiKUbG3pyy5+6vUgAVtcRpbEjf8PwksmpzaGXRdqSRMu6M668kFXKg/bUvtGfb3E2udbmWQOqdF2lCbopo4IIQSXqPNFF2whNQW3fcdW2r6ICA+xY5W/0WOhmr4hyyEBdm/RXKNgt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJhRCVcBQ+4aidmSPAbhfDtnn8ni530hraZWWjFAD2Q=;
 b=SgOzouT5jL/nTwinq/ie6yRdNhBbRfpJWnWCfNDOl0Ezkb7Ih6mJN51XN9cEULZos8ZCGpWn2QcyhJyMsNDCpHHeRxQHIvX0fd7CI/eBJFEBMqEfaYV+ypMyTewP+7CYdJwAc5vZMdxflc2v/ZNVCfGMpUHIYnHpJmTviUi9MW71uoRLxuNGmED41QwRiSEzs/bP14f/ezDW36k7wEnXHq4KCHh2bQaGtcur8q1fdoWh3fRKKM0jyMP9hVRynY/zhuVsO6PcNQkcuZuB6M11z6OM/J7r363xyfwwU27uPps7oPUL8HLXsscuggODIX80B+XVaChpX0QRLGnA0O2jiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJhRCVcBQ+4aidmSPAbhfDtnn8ni530hraZWWjFAD2Q=;
 b=Dw4dMleo1WdQvWSQfcKnv1HpgJbyjwf9M5eQh52I+XT4k2PBvttZnj905xfoplxX6qY/HMXC23xvy9ntwA0WV3T9HGK6cHGDn6dTkfVx068d/9f2t41NymdODxHgaVFsYnYcXbcvJU/aL/VkUfL8spTRmSNhE/P6+FkDLv1xWk3KjHGbbfWVmML3rIQnsHbpDq49hatbc+Q72+X51H4YoezJkodygSMMl6JEzhLTRRNUISBuX6RwFg31YL4JTmHWWyg5/2230PKYNBQChaV0x6lui/Kk29T4wYpDyyixjDE2OA4ML9x4q0oh+wq9+53j8GKmKhQmjEIR0pk7nQ9Jag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 07:44:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 07:44:24 +0000
Message-ID: <f5b506bb-2906-4a5f-9574-e5ca1676bf69@siemens.com>
Date: Fri, 19 Dec 2025 08:44:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Some fixes for the select syscall
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
References: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
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
In-Reply-To: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3145:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e93bf5-32d3-4b97-aede-08de3ed26dbf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlhLd28xQ2hOamxWc3JLWHhtb2lVREpHZ1dPMzU2TUQ2UG5nMCsvV3BuRGF0?=
 =?utf-8?B?ek9jcFNEV0dsWWoyckFsMC9PNjVhM29aYUVFcFU4MDRqSjlib0tKWWpPMWZY?=
 =?utf-8?B?QkZMYk5VM2hIdjY2bWFrd3UyK0F3QzNmNlJ0MjFBUjg5YTgyb0R2RzdLMS9Y?=
 =?utf-8?B?cWttOHVaYkxTNGw0Z08waDZHcXJ0dmdxQmhwODBFZkl0Yy9NMmVleHZWWlN0?=
 =?utf-8?B?cGdVMEFIZ3hrdjZvY0pxRTB6aWRMcWFMYUhSVVkrY3YrMVh0bGdwa0hxUzNM?=
 =?utf-8?B?dEhqZVRVaDNrUHdrL2c1czlWaGlEQzRvVjJkUGxJaFA2SDNSOTRtZzF5bU9n?=
 =?utf-8?B?SVp3bVJjSkhXdS9ienU5Sit5K0loQ2V3Z05qUzlTVUowaklEenoraHRqb0pm?=
 =?utf-8?B?TCtWajJNQ1ZZWDlaYk5KWkN3dlB6ZkcvRTdsS2JyREJqMDMvdTkycW1NS2dp?=
 =?utf-8?B?QzB4RklkTE5xMWdoanlDbU82eXRGMlVodENHTk5WaVVkWHVYbE9TaXNVOUV4?=
 =?utf-8?B?YlBzUjhIck1OU050clJKUTI0UEF5d2gwd0NaUkhzVDVUNUJzbTVKT1ptelVw?=
 =?utf-8?B?MGxLK1JSam82bjhJeGgwbUlPNWhrRXhXaU5OcGVWd0lDQ3hYU2ZmaVI0YUF6?=
 =?utf-8?B?NVUybU0vWGxWcmFKMnRVS2hHYkZWUzZBeE1lZG9hWmJJcG1pOXkxb2lvaUJG?=
 =?utf-8?B?SUk3R2xVVWFrMithR1ErbVJORitkdUFFc2g0dC9LYVplcXdXSmpEYXJDUkRh?=
 =?utf-8?B?UzJTMmI4dm11dStPL3laSWJxTlZCOE13aTZYQmt4TnZUYTcvN0p2ZHMxOVhS?=
 =?utf-8?B?cFdXdHNCaW51cEVmRUdxdE9JZEk4ZFZJZzh2bWlyT1h4blRBRFl6STRQa0RZ?=
 =?utf-8?B?N0M1TVVxcHZaeTE5N1dYNWRVREhTdDhyMDRBNFB1ekMzQnVwTzQxcS9tOWJn?=
 =?utf-8?B?OVBaR05USExlNTdwS25RNEFUSGRhdkRyRGJJTGdONHhFZ09FVXhOR3JvWWg4?=
 =?utf-8?B?ci8yNDgwa2lCRjJla205bkt4LzRObmxzR0RqUEdrdGh6TFZET0JuQzJLcktB?=
 =?utf-8?B?SXN4RU1QaGtPWWVkU3psZEUwalFkdWhHMlgvUS9MUmkvdGc2UzgzVWJMZ2pD?=
 =?utf-8?B?WGVLZzJMa0tpUjh4MElKWE5MWklLWHhQTi9kN2lsbU9uM0I0dW9xSE9nWHZo?=
 =?utf-8?B?VTdjL0theUNUTkc1NGFzeExPWkIzVDhyS3NWRC82WUxvZ3hWUWFXcDZiVGNY?=
 =?utf-8?B?VzNyT2Vuc2ZURU1sUUlUd3o3Z0l0QXBMMUNGTXhrY01FR00wWGg5dmpzYkph?=
 =?utf-8?B?b2FITlR0aUZrUlh6VEY3VkRCVjVYcEoyd1ZjUzVTUTJkNVJwZ0NEajI2c3pT?=
 =?utf-8?B?VEpKK3pPRHJyYlVXZUpCV2ZlTVZ5YVJNaGVGQXlYZ3FxNW91aHRLdHBxdDU3?=
 =?utf-8?B?d3JLM200TzFyLzR6WGRWQnJkOUVOanN5cmNmVTRLV2hYdnovRFlOc3RtYzNu?=
 =?utf-8?B?Tzl3eDc1UXgzbm9nay82bWJUamU5Q051dWNUdDBHcGFHRnphdk1KdHZ2dmFl?=
 =?utf-8?B?M2lwNGQzMStBNWN6Qnp0clpCdTZLQWRWL3RSeVY0VzBBVHVnOHZ5aWI1ZlZm?=
 =?utf-8?B?VGRHMFEyenQ0dytzQ05SVVpjYk03UVRieWpJcS9KTjZVWEZ0UXBVVm9rdjJP?=
 =?utf-8?B?bS9VM3dtcUhRTHh4K1U1ck5xWGJPaXFueWVYR2ZFNG4vdGhjZEpMNExiVGUx?=
 =?utf-8?B?MWIwZHdKL2ZuY2p5OW95NFNBZ2Z5dnovanFoSG9GOVVWZG9HWnZqNTJHS2F4?=
 =?utf-8?B?dENpd0RQZWNGV25LalVMNWV6OCtycEl6NjJHVUpwU0JwRnpJKzM5dzV5OTBU?=
 =?utf-8?B?djY3ck5IZVVXdHgxYWdBTkZmZWVlem9CTlVwWmgzM1p2T0cydkFhYjVSYWFQ?=
 =?utf-8?Q?KjM3FkChxmOsxlJ7IbLKo6Dl8TRfKxiA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUdMQ1R3WUw4SzVRb1BWL3dkNnR6MUdzeldlVkpSVmhYMWh5VE5hYUJSaTlv?=
 =?utf-8?B?RHNpWWxBS3UyNmlsLzdPdW9FNmhVTDFaTllhOUw2bmh3bFg0Skt5Z1lHa0F4?=
 =?utf-8?B?RmpRbkptTWV4TllkY2xIOW1QcEEyNWtrUyt0MEdzdVhQUEk5bzlJQ2NaV3Iy?=
 =?utf-8?B?bG5pUG4ydCtrc2JraWF1dnNna05NTjNKQTVqY1Y1Q0w2dXl5SXltclFjWldE?=
 =?utf-8?B?K2Q5emphYnplUnZzck9QcGRUTC9kOWM5OFNSNkVPRmc4WTdaRExGRWx3clRO?=
 =?utf-8?B?aWlKeHVNOUxWcjIrTEJ6QzdKcGJFMWZrcVVjRnFXRXJXVnQrRVQzVm9IRmJY?=
 =?utf-8?B?MnNNd0xnTlhhYjFCclYzOW1jWTRiNlpLOWZyK1NadUdKeHAxN3pzYUc4UElu?=
 =?utf-8?B?dHp5VDBjVjJiU3pWaXpwMUtSQTFVSGxsK1B1eVZqTjA1YSt2MmRaUmJ2VzRD?=
 =?utf-8?B?YWpNT2cxZk4xS0JEcXlVVEkyRkZSM0tnRzRLTldGb3BTVDlJaU56dGtZaENX?=
 =?utf-8?B?aUE2UGFtMmovdHlkSVJqY2ZzQkdqb1BkWmUrRFE4Z2VZVFNoc1BaNXFwUnNL?=
 =?utf-8?B?cjd0b0hyTVhxbThxUEhhc2Y3T1ArYk9BY2NGbnBHbXI3d090QjA5emcrN2NC?=
 =?utf-8?B?M2FhS0RNVkdjN1I1ZHF3bUFxQUhjbUdpRTFmTG1JZG50T3JPTnpsNUNnUzF3?=
 =?utf-8?B?VE90SGVkZlFJbWNhS1FZWlNmeVdxMk9HOVVHQkx6L2oweEpWQzUrd1g2dHZa?=
 =?utf-8?B?KytpTEFUSzRMbUQ0Mi9VYWw4b0pnMlI2RFFZQTI4YXVQWERUbWZ4RzFlTGVD?=
 =?utf-8?B?dHhwU3J4T1Awa0pnOHkydjBuaTY4Qy9WZDNpWFZ1YlZPM014M1YxZ0tuUWFS?=
 =?utf-8?B?MGkxcHJjUXBGREJLeW1hbytoK3dLL3gyZ2RaNUJaNEMyNVVLaW5sZFBMMXpo?=
 =?utf-8?B?TGVlbFpPN1dFUlVTaWs5Z0FHeHhZZ3JsOFdZR0ZndnVnb25HQ25MdWxIU1k2?=
 =?utf-8?B?K0MzcTBtbXQrdE1yVEM4YXJ3eEoyWVhZYTBGc0s5TGhPRjA3VzNOeHFESEMz?=
 =?utf-8?B?RGJ5bmRxeStmK20xK0gzcEdZQ0hDdjdIb1ZMVGFtbDIwRERGditlZk9QbzZm?=
 =?utf-8?B?K01RUm5QZXlFY1dYbWo4dHJ5YVRHa3NzcUVFSEdHVSt4T0ZiNE5lQnNFU251?=
 =?utf-8?B?YjVrdEpnVThVYlZhQy81SUJCcEVoelV2Q3dYR0laaTJKY2YrQ1pNT1dPQzdU?=
 =?utf-8?B?R0I1Vy92Ylp3RkQ2YnJnZ0JpSlhhOXlTZ1QyZUZKZ1dkSjAvSFhJS3hrdEh0?=
 =?utf-8?B?UlhPM1g4dVI2bE9BU2FydkZub01ZSHFvb1cxY0hhK1NuN29mUC9zV1A1UElt?=
 =?utf-8?B?ZVB4em5OQXJraEdjMjh0Y1VFOE9LRDNTVEh3RmVuNVh5UWdGbzgrWFhDYVJG?=
 =?utf-8?B?MWtmT2JhZ1JWZnhHbTc3ZGE5eGd5UG5kcUhKbHgrZndya3pyelJZOEc0dzkx?=
 =?utf-8?B?N0hrSzBhUDRFZTZpNkhpUEVTUVQvczQvNjV3VUtaSnJqM0NCY0l5M1ozWkEr?=
 =?utf-8?B?YlhxTG1KdlNoUzY1OC9sMjViaXkvbWJNUkdWays3M05KVHZ4ZTlDaHhhdHZE?=
 =?utf-8?B?NXc5NE9mcFJwaDBjOHV1ak1aamxtVmVPYUlxN0lmbldHeU1mL2pHRldpQm1i?=
 =?utf-8?B?ZllpZWc3MWlHWGswbUVzSnZkYUtEYktSOExNNCtjYjdiOEZDaXVwcEhrNzZL?=
 =?utf-8?B?cUZmb1RnYllHZTN2MkdNdkE5T2E0bW1NVHA3WWVSc1N3anNEak0yRHh5aDUx?=
 =?utf-8?B?eVpiRXhFY0QwYlpDT2J2NU9kbUxVeG9mNWZkNDFSK1htUlVUeVJHRHM2VVdE?=
 =?utf-8?B?Q3FLY1B1Q2QvM2JHT1UxQ1pjNEROZFpjcyt5eXZkQU1XSzlxa3BMN1ZCY29X?=
 =?utf-8?B?dDNHSmlLTStTU2FONENNWmE4eWJONTJGdkt3MXErUFd5WDNPVjh6eVZFd05h?=
 =?utf-8?B?a05rSDlDZXFWK1NsWnJQVlRHWVlwZWxTeElka0tkOGhYS1Mwb2lEMnlVeWpy?=
 =?utf-8?B?Vlc5dUUraVdSbVFKbWdVbW8vQjFmbGQ2R2ZuVXF5anRiZ0tlR0RFS3hkQllS?=
 =?utf-8?B?Kzc4cTFhcjhhUXlZUWZOZlRjaUlNYXBIT2NtWmYrandsaGtubGN3TGdEQnMv?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e93bf5-32d3-4b97-aede-08de3ed26dbf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 07:44:24.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF3/AO8TH/zx6f/U2fn5H6EEHWC+1aZ86tE7Pi0a1xdAQIgzDsboHDcteqrn4qwfu/6TkxevBb/0maim72Qsqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3145

On 18.12.25 21:02, Florian Bezdeka wrote:
> Hi all,
> 
> This is the result of a short debug session triggered by Andreas, who
> was staring at some strange select() behavior.
> 
> The issues were introduced while working at the y2038 support, so it's
> kind of 3.3 only, but: We have a difference regarding the timeout
> handling in Xenomai 3.2 and 3.3 now. In case someone is running a
> testsuite against both versions the result might be different.
> 
> The testsuite has been extended so that we cover the missing case now as
> well. CI test runs were based on dovetail 6.17, covering all supported
> architectures, compat userland included.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Patch 2: Optimize timeout writeback code
> - Patch 6: Address review comments from Jan, improved the test
> - Link to v1: https://lore.kernel.org/r/20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com
> 
> ---
> Florian Bezdeka (6):
>       y2038: lib/cobalt: select: Normalize timeout value in the y2038 case
>       y2038: lib/cobalt: select: Fix timeout writeback of the compat time64_t case
>       cobalt/posix/select: Optimize cobalt_timeval_to_timespec64()
>       cobalt/posix/select: Optimize cobalt_timespec64_to_timeval()
>       testsuite/smokey/posix-select: Move message queue test into own function
>       testsuite/smokey/posix-select: Extend the testsuite by invalid timeouts
> 
>  .../cobalt/include/asm-generic/xenomai/syscall.h   | 25 +++------
>  kernel/cobalt/posix/io.c                           |  4 +-
>  kernel/cobalt/posix/syscall32.c                    |  4 +-
>  lib/cobalt/select.c                                | 16 +++++-
>  testsuite/smokey/posix-select/posix-select.c       | 65 +++++++++++++++++++++-
>  5 files changed, 90 insertions(+), 24 deletions(-)
> ---
> base-commit: d557f120bf73a0e467196c99e9de210244b29774
> change-id: 20251204-flo-fix-select-syscall-bfc518960f1c
> 
> Best regards,

Thanks, applied

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
