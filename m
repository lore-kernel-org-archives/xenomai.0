Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F022FA0FD
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863107; cv=fail; b=nTmhWtib5b+HSg/j9ZsTyB6kh7VdN4IDu3ypnwxe3/gCSWfY0kAcR+Qmen31yts/4OdfClfxbKZ7pemny56vUW5G+YG9iQJ0AhKYbwpZJX4aMowhX4HcxdLA42YSmWxyr5JQI9Xr3FdjneW/BF20w3kpndn47xPm5SHZLWnbphI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863107; c=relaxed/simple;
	bh=3hdN2D6REJaQnInCwlsq5I1j9VPeFkajiuD3wadaftA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UA+WW1bNfPS2VGbpcPsgoEGEA0J3Xp40wVaZbjXfrJRlSACXu/W7HZQGUrhGar7qD3oAODd8pqlRuURhEDALcZOf2EwMY6WfQfxtBx+pSRaFb1PP0eTvL2GtupIri7TXS1fTAHN+Pw8/3lphZN+SCsiOHSUTsCnepOTcFMCJwQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rq7tgMv6; arc=fail smtp.client-ip=52.101.83.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rq7tgMv6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDuiaMGR+Li/7tcShcEojvYyN6x/PlqDdqEmnDtuuwXK0WxObcQyzonyVRlRbDRpp+jxDOI9pH9orCcr3Jo++zpwb5Epxir5S0w/y5W26zN1p//vke2KBXDXWvTaBggdsDv0YwSiIQSjEZi0MUm5zhddGWOErtaGcknWkOgYfUWh3Z+ED7FLbcfwgu4a5hbiS2mGh2C2lFxCrqLAN/nLFz8Gon36bg8dOgti2gCZxGff6M7VYKlhfvnIeVQEK8jMFb3/4N3uU6d74AjJDRMdaVBUnqyb5dgY7sf/OPN5ntAWLtc9KJ4yFmRXgjuXXrfSxzijrxFGJ5xMv2gQWpL01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqprdjOppSPCcooHoNTa8SeXgfM90IJOeYCIWbVVg2E=;
 b=tqswZqNtDiPb68cb+p1bs9odBqLd7/Ip/+d/miE286e02C4ylQr51yBffHbH72KcCNDKDd1ov9LlEGEpyz34YPoV1RLGebrfHwpEHKZffZDUM5uFuOh3GrgcsQIYUMhTOjHMxGdmg7t6gq3HWHVXYHsiHARyB7ZGywhAYge9jpPjwJDnGDemSislm7mMCyZDYLs9pb3RoBcX6qSraTh0QIcU+NudDbjudNEdQYF2SLVh5YfChWFLIvV8cIa/ap9K+3g6uO3hETuyMiAsFc1LChI7fREm+7XBRqUNV3S7Nt9gomoecqDoQfE+b+nrPnz1s1NhesaUgmt1803/R8WrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqprdjOppSPCcooHoNTa8SeXgfM90IJOeYCIWbVVg2E=;
 b=rq7tgMv6q+/0vIhoU5R5OZ7NgJcgOSwNpqYJqYSEEeHl3ojDFQQBWkeT77HhEhXpJwc0CLeZIO5xLD1x0ySzVcztp5MOSgw3IgkcERy//7ujemfe+qCY3o9zBPcr6ZOY2zV0voJcQ+m9kMOoKmysLQtaRi79PKA+74txJJ0i0fEJ1W5vBW8gx8fXZY9Xn+Y4+x+kyG6xIZx1mN5Mp3xKVnsRZ6ZphNG6gWRBDYX7OiMdX8T7GBcDO8ayX126rA3uHBzge2lDwENgmSvovmVB+iIYTK47+zSHRS94Pdq1NQn0Pt7orBOvddxiYy7/1vrHvJ9JFt+3O0/IIGYRmv+rrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 11:45:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 11:45:01 +0000
Message-ID: <12854fa0-b0de-40a5-a78b-acaaa959dfec@siemens.com>
Date: Fri, 22 Aug 2025 13:44:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Replace obsolete AC_CANONICAL_SYSTEM macro
To: guang_feng_wang@163.com
Cc: xenomai@lists.linux.dev, wang <guangfeng.wang@siemens.com>
References: <20250822042059.4812-1-guang_feng_wang@163.com>
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
In-Reply-To: <20250822042059.4812-1-guang_feng_wang@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1872af-c193-454c-6284-08dde17153d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0Jic2pHKzdKamE2K0VDSElicVBnckkxRWFQVnBUVnk1QUNYekdhSGNFQVpZ?=
 =?utf-8?B?dUQ3WGhoS1dibU5jdm9pMVNVV1haMkVwK0tkdUthamRYTWJ3OWtZcGZWVTlk?=
 =?utf-8?B?SlkvQThXbXg3RFNTMUlLbkJVMkc2aDdlZWlLS0tPUWFXbDQ5YlJQY0VFWjUv?=
 =?utf-8?B?ZUZwK3JRaDN2cW13Y3QwVGIya2p3eWdiejBsbEYwSzZodFl2blV4VjQ2VDRV?=
 =?utf-8?B?N09kTFgyU1NJVzMyL2hHWVRxeWM1Sk1yaGVoOHoyK0pLeHVZZGpqcFVvOGp5?=
 =?utf-8?B?UEFuYzlrcEVMRkgxNlE0NlVlM2VPRVVWOXhwYjBueGEzcDIwZER3SWV3Q3k5?=
 =?utf-8?B?MFluNjc0aysrSVhrRFhkd3pHcnI4LzNlcjVBeDBlaDhuTEVpeUxpTW93ZzN4?=
 =?utf-8?B?TTl0QzhhQTBQeUdzUDArNlhkV2ZyN3RZWjJnMW1ZRURqZkhxMWY0WUlwNlpT?=
 =?utf-8?B?NThRa29XRmtVWm91RG15WTJVTW5vc3hycmp5dWQ1QmVsWDRGUXd0WEMwcldU?=
 =?utf-8?B?TUxaVkZhUmNab2hFeWRSK2loaHFhZ1J0THFXK28xTDRoUitsTjkvUmF1bnk2?=
 =?utf-8?B?TW1SeWlwbk1qbUN1azROL3EwY0RCcG9kdGt4RDhNb3hzSVJrREVQOUhUYkZC?=
 =?utf-8?B?cUlLNTNnWE02T1dqKzVZcWNYU29GVnh6NkV3TU5wajBDMnZnRUl2TVB2ak12?=
 =?utf-8?B?RWY3amg3VVk3TVh2ZzBPc0tOc1ZhM013MlNoTjZPZGRQWWtMU3lUSmhOa2tW?=
 =?utf-8?B?K1ZSVzl5TUN0WFJYVjg2bUhBMEVXeU0vc1IxaGU5aDAzektUc0ZjMVhhSkhk?=
 =?utf-8?B?b1UwMXptS1NNc0k3ZmZxckdTYmxhUUFvVmFxcXJBcHZvamZHZkdoN0x0ekx6?=
 =?utf-8?B?aTNtelNmZ2VGUmdteE9qWm9zVldnUTNYS3cxSG1rVVU3NEFJK1dNMnVNb1A4?=
 =?utf-8?B?YUw0RisyNGwrZ2VkalNSeUpHcTVZTHJ2Q2liRGZnZTM2Ymxwcmt6QVE4aFlv?=
 =?utf-8?B?NmVkZldHVHpXTDdJUlBrVDk5NWhZbkhrQlRqYjBzcVhvckxZWkdhM1M1Tkxr?=
 =?utf-8?B?UkpDYXFia2pOa01LZU1SUWlETWlEZkRWYVU4aW45aHpZVFlKM1AzQTlXdkty?=
 =?utf-8?B?QS9zV1lBMHBHWGc0UkduaVV0SG10UU9HQXlqZFNhcFZnblN3S0dIdTIzQ3hv?=
 =?utf-8?B?TXRtMjViVDFYL2h0K0NwKzhnc2djVU92cEJaQmJsUDlJYyt0S1phZlpad0VU?=
 =?utf-8?B?OFhjNXA2b1M2TUlvYlBkQldQTGtxNkVhcEdGRFJ4MEMxR2VNRnp2TkY3dURi?=
 =?utf-8?B?QnFKR1M5TktlTmdrc0JpVWRxZXcvY3FRcWVtbDllblMwU0p5aVlQVHU0Rk9D?=
 =?utf-8?B?VkZTcWJVa1V4YThmZ2VJZ2tkWVlTN3NtK1ZqYktGa1hlTnljTGFERUcycHh1?=
 =?utf-8?B?WFEwSC9JZjNjcWdVUWZiM2ZBTXhKMWRqdGJyekZ4VkhqT0RYemFmOXhqUWV3?=
 =?utf-8?B?MitTa3JyK0l0aWJtVWU4TU40eHowaDJxVjQ1QWZkY25lWVJIUzFzMER5TU9l?=
 =?utf-8?B?TTdKSDN6aEYvQTdueTJJS3NJT1dFYkVENXZEQ3paRGFNU2dWTW5URkwyaWh5?=
 =?utf-8?B?Nm91NjU5UU9DSmlhdDFtOU0yN0RaMHl6WnMzV2w2elJoR2JUaWlZTTVaY3Q3?=
 =?utf-8?B?SVRUc1p2eDhPSnIvdFpQbUY0RWFIYUpNREJoZDZnOEFGNnFsVG1uaHhoVy9j?=
 =?utf-8?B?UjRsS08ycndOU0QyL2NUVVpSbDlJOUdzdE9obkRxMWxwTklIZHR1TURwdjB5?=
 =?utf-8?B?UmtrOTMya3YvMFE3dXF6dWp4RENQMDBNdStsR0Nxdm5Fd0w2SzJua2huMVJr?=
 =?utf-8?B?WDBINFpPeTBRZ2oyeTNxWC9BM01mWXJPSzc4YjRuYTE2dHVzaGdORndQTmxq?=
 =?utf-8?Q?JOAro15qjRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkppZ2E1eEtBRzVocCtMVmwwTU4vWWtxNzVjeVlESGxNWVFDM2tJdEQ2VjVi?=
 =?utf-8?B?K3pTd2xtWDR5Z1lqdGFBTWtJSzNrS082dTJFOXNKRWNFWWgrT0xhaFNiT3Zk?=
 =?utf-8?B?T1J2cGpvZUhRVFVYNjNOQ0Q2ZUpSaVpvTUVtVjNCeS92S0hxY0JxZWtSSVZv?=
 =?utf-8?B?RWNnbHBrVjNOS3NMTVo0QlNEenRqUGZiVU8yektzNTNIcm9NeDg4M2RVSWNj?=
 =?utf-8?B?cVpjNTNoYTNHK0lYRVAvMnFvcVpmR3EyUmVpMytRWnRKWEVTYkd2akF1SExC?=
 =?utf-8?B?WDBreEdEVEh4UE8vcWNGRWxLbVAwS2N4YndRZ2Vqc2FWOEN0Q2ZBZzVld3pH?=
 =?utf-8?B?aU83Y2k4ckhHK1VXN3B5czNZd2prbFRDOFR1SDJjWUVSbUdZK3ZpRUVneW9w?=
 =?utf-8?B?eVMveVFCUWo5N0ZpelU5YTlxR1VwODNaRS9JcFh1MmN6dHhCbXkxcVZpa1pW?=
 =?utf-8?B?QmQvSkFlTldCU2Y2OFNkT2ZadncwckF3VGFWbFBtaUxKWmxiTDJqczB3MGlJ?=
 =?utf-8?B?YjRkVVlCSThZeG80cC93NCtOVVVINmJTYVRWR01hdHFPcENDSXJrd0tCU0sr?=
 =?utf-8?B?dURSUUtweW1pL2pIcUhOSlloaVMzakxwOTh3RCtkR0NEdGRIcmJYYXdpTlJQ?=
 =?utf-8?B?amVlYWxocnhubHN2dnhGbFMwVGhqZmwxYlgwaEowekFSdXpGbDhlUFhtdUx2?=
 =?utf-8?B?TSswOVUrRUxuajd5bjdCOEtxdDh5L0NaR204L1Rmc2ZYaWFqT0Y1aFFEdGQx?=
 =?utf-8?B?aXZwU25aRHd1aWdkZWxLM3czSThLd3YxbXhLY3NJNFZEZDIrVnNCZDBSczNy?=
 =?utf-8?B?UStkVGhyclUrOExMTFpOTlpUcjZPbnM0d2VjeTVvQUlzd0NUbnZQb1A3U2xY?=
 =?utf-8?B?d3FuMFZyOVNvcEZ1UTgzcUFtSE1zS1Fxbk5RbzlEV2xCb1Z0Z0FBeDExWHVT?=
 =?utf-8?B?cUl1MURmN1lLUG42T3lRSDh3cExrK3l4QzYzeTREaEV2VjMyZTJ5OGkwT2JT?=
 =?utf-8?B?eXBLTVF3MXR6VGFDYy9lY0RGcnRGL1Vwa2xEZldaeVZsOFdrVnFzL2xKcldY?=
 =?utf-8?B?SGhzK0dwY00rdmV0bHRnMTM3TzFVZ2pxM0IwK1lJbjVFWXFEY1JaL1lIZDlX?=
 =?utf-8?B?NUx6MFpuZGFjanBjdFV6b3RyN3Q0bzV3UHk1Q2NZaXhRZTN4YzVmbS9hc2E5?=
 =?utf-8?B?L1QzK1dlUFluc1hyTE1qZUgvM2tlK25jTjd2ODBLRWRRT3JTY3NYSytyMThB?=
 =?utf-8?B?cmdaVHRZU3RiYzlCdEFBNy9tQXc4OGgyem5VLzdlMTBmdXVFaGhzZzVxTHMy?=
 =?utf-8?B?RkM2dFhQR0ZoWnVLRnBHaDNxNllwL1lrV2MvYksxSk9BdExHdkgvUnVZNVcy?=
 =?utf-8?B?UXdXdW02eVZhL0pJdEsyRFB5QkRuTDlzVjRPeHh6eVNqUDVZMy9tWENxbmIr?=
 =?utf-8?B?Z283Tlg1ck5uNStSSkJSVjNFdERUSFo0MXBiTHNXWlE1VVBRcmJTdWg5cmlw?=
 =?utf-8?B?WWNDSU9VN0ZzYzhYQzVYNzl1eW5lTExwbUlKbWlyZ2QwazNDbys4Z28ySVF6?=
 =?utf-8?B?TDduYWwrN0VobkJqRWFmQWlHc0JyKzBCRVZoN3YrdHdCaFR2VUdVb3VXMGEx?=
 =?utf-8?B?eC9BeUtRQm1rbm1qZVRjb3hrSnYwL3JnRE1zNUlLVFh1UHBoK2NqN0JraWFn?=
 =?utf-8?B?MzFyU3lrWUVmb283eXB2VmhVQkdySW1wM3JxUEp4WUtoODYrTGJiOXdwTlM2?=
 =?utf-8?B?RTlMd2V3eEdYRGx3Uk1DeWpGdzVqY2ZVN3FVTHoyWXFPRm52Zk1rUEVvR3Ew?=
 =?utf-8?B?aGtHbHNQVVVYc1RBQnJUUTRJZ21jbkpzNkZadmJXcGo0S20ydm9ubk5YYWFu?=
 =?utf-8?B?cUYweTdkK0EzVSs1UUdLOEhGOExDWUFGQjdGbCtNQ0tHemd5UEdmNzNab1I4?=
 =?utf-8?B?K1lOdmZWRms3WmR6R3M2ZUZrdDVrQXM2TEp3K0paM0pidDBSRnUxdUJNSVpP?=
 =?utf-8?B?VDdXNml3d0VWeGlJYnVLRWhnRTZmZ3FEK2s3SFdWQlRJT1FRcnpoQmVnNVhL?=
 =?utf-8?B?d1NtRHZLS094TWNSdjRUVytQWVQrOEwvR200NjRVYys2MnVDMWpFdDFBdHBm?=
 =?utf-8?B?MUN0akpHekVCeWNQZThyU05rbGpCd29QdmFUTUtMaVV0SHBhRVRzTlpoWnVM?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1872af-c193-454c-6284-08dde17153d0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 11:45:01.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gy01edehhzTaFys9BUHSWxZLIFOD1bs7ZGNXXl4zCKKs+IyeAWLuRNmbLA0LFpBnhkVMQ9fngRkvpbq2x2Z9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7708

On 22.08.25 06:20, guang_feng_wang@163.com wrote:
> From: wang <guangfeng.wang@siemens.com>
> 
> The macro `AC_CANONICAL_SYSTEM` is obsolete and triggers warnings
> in modern autoconf.
> This patch replaces it with the recommended macros to silence
> these warnings.
> 
> ---
> 
> Patch v2:
> - Using AC_CANONICAL_TARGET is enough. Delete AC_CANONICAL_BUILD and AC_CANONICAL_HOST.
> 
> ---
> 
> Changes in v2:
> - Fold in previous discussion from:
>   https://lore.kernel.org/xenomai/24d3ca0f-52c9-4d82-9ffa-7ceee81c8ba8@siemens.com/T/#t
> 
> Signed-off-by: wang <guangfeng.wang@siemens.com>
> ---
>  config/ac_prog_cc_for_build.m4 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/config/ac_prog_cc_for_build.m4 b/config/ac_prog_cc_for_build.m4
> index 8cba24927..731de2b22 100644
> --- a/config/ac_prog_cc_for_build.m4
> +++ b/config/ac_prog_cc_for_build.m4
> @@ -5,7 +5,7 @@ AC_DEFUN([AC_PROG_CC_FOR_BUILD], [dnl
>  AC_REQUIRE([AC_PROG_CC])dnl
>  AC_REQUIRE([AC_PROG_CPP])dnl
>  AC_REQUIRE([AC_EXEEXT])dnl
> -AC_REQUIRE([AC_CANONICAL_SYSTEM])dnl
> +AC_REQUIRE([AC_CANONICAL_TARGET])dnl
>  dnl
>  pushdef([AC_TRY_COMPILER], [
>  cat > conftest.$ac_ext << EOF

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
