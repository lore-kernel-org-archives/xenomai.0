Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC834279334
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954763; cv=fail; b=bh5W4kMTM/ViD4vbHFF7a3ZJwn3NoJ8mgZrhW+496o8LjUvxgEYRW7BmkzgYrgK4itHiFIr73eKTHaPmIG0cuvTR6oiWILOCxUp+ErlJnhLTIMT2D0WtrjDCBc21DM1Cm+z7UIL0k1DWuyTnqq5XMsQe7cTAURpj7n+XM69Cu+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954763; c=relaxed/simple;
	bh=VD6Ai9K3+bHplV1feg0oWdZf2XtyEwQ89YPxQraggNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvcNu5pANWava0Xi5Kld2+IYIhvkAH0j7xI9qOrlCjtVPAfXS6uMzAz/dvyRG23+6EZtBR3Y4pfrmBWAIYXvkWuO76OUy9A0jppDGb8SytL49evQ/q/Kt6wuGi+ikOdgpPpTCVFKM9lty36rzvUK/4v5pT+HgzisfYSZIj0CEwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Oaxk2xTJ; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Oaxk2xTJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyHUIl7N5OSKj8bbnwjvb0KmygxDDN7hVSsTcDw7wmuD5br9RZbi38gRU55AuBfunwRuEYW6P6LQ9bMClb2T/7O/YypeupAUJ+AuL34FX5C5aDlO8DX+dNqtO9VwzZLVOwZi0sGKQC7z+Z9bGZZUVQ7H701J4LiUUG/3AiKwsUvYrV5kA+Ytm7sPiBJ+Q2St9shzGxPjPaNshEwYUrbO3AEAYM0jNHmR8tXvFCpt3K1TBdxpxPh7fNKiSWfWIKWUg3dzT2zP6aTyysbMaoE0w3EXhUQsWrjvxbE58L2qGdCoK21KJnHDrZO163FiLEOgp2nHBtW3EWfmGYd+U5TaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9EcKA1os2CqbtDrtVApdi7iLBmr4+gX1/W5BbiaKZY=;
 b=huA3i/lXstKT0DYenm5vR4yltJ/QvwFNJmKgJNG6XjZHKLA2Yh99adtB6fcFjNun7BNvaRdst/euLlVv8nsobQcAOSJ/MtQToQoUMa4vMdGFJNQ7k+uYvKhePtpUeCbJokwQnqLJGaGKyPkewuJ/7Bjs1mwfj+RzsyBjjP9vyJNAKM1fn+md8WLVPSmtEzrB4Yx+hUTCI8pELoHKkTO1VQlW5ZWHOSfaT13a2DptAnXTAY+3lqUFj8FzX2dACh3gcvm1TQ/lOp4qKhLvYHMTC1ViTGbLxXigZr1wNOGR2wj27QKR+91Lmb2Z1e1wnecPg+R3VtRLpEGixgZyUeEFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9EcKA1os2CqbtDrtVApdi7iLBmr4+gX1/W5BbiaKZY=;
 b=Oaxk2xTJ6SsepYed5AnrXARf2ml/yCMYxkFx86QPAfwaxIY6ADvD5/YZLRPBcburAX3yccq1MPU68nUyxGmL+nsbGs0zeh+IHknI0p95E2GKg0vbv9dVAVaB6S9S52u6YUCKMMOBmsc/eXcKs6M5O5H7xO3JWHqa9hKyRDw5BIZGc4QPAaeNDZFgQa1QxPy2rUFqLMkD0iNV4zsd7OI+Hh85hLWENitVy/HTFhE//dSsAgaDD24wU05TECGDXXqfJ5rRZqFL6NZZPe2M3NvRz8UABNOWRpua8WockZo2Iz0C1VUkkJxorO6uIcmCQoS4FdcGg6Buf1jJ9zhD7eMSsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 06:59:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 06:59:19 +0000
Message-ID: <75ab33ce-0a98-4154-add6-9e8fa989b4eb@siemens.com>
Date: Wed, 17 Dec 2025 07:59:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Mauro S <mau.salvi@yahoo.com>
Cc: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
 <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
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
In-Reply-To: <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3676:EE_
X-MS-Office365-Filtering-Correlation-Id: 52af828b-9a07-40a3-d226-08de3d39cc9d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VExoazJoVy9nL0ZUUTNZSjBiR05lQ0xkRm9BVkR4WW9vQjAzQUdoNldBOThL?=
 =?utf-8?B?Q0hMcWx2LzY1MmVRVTZFbjRPeGNSalFvbStPK3g0eGVQN2pTYnhhNVowV1FV?=
 =?utf-8?B?aTczMU5salFUai9MU2hhMEw4WFEvMEUwbHpXVFBUcy9kS2k2cmxscEJjWXVm?=
 =?utf-8?B?Q2IydHlYbkpnSzRtUEErR1o1YzVSR0FLV2tYMmp5cDlxQU45WkZ4bEUweXVC?=
 =?utf-8?B?WHdaTEJreE1pdjFsdWF6QWVpT2IwaTZST0VZeWZCYmJIQmVUWk5IbUpZalcw?=
 =?utf-8?B?RkdpVmFjbXBzaHQzdlpBajJhWkdxTDlyV2pia0xBaHlYbU81NEVxcFB3SE5Q?=
 =?utf-8?B?RFArYlhaV09zcldGSlBYdmlpZnNBUlNkZ1ppNStCU0xNVFkwOWxWSkNCenlN?=
 =?utf-8?B?WEJVeWFBa1FlKzB6SnlXdFpoY3YxdFk1dm1YazJmUVFTU2VaSWFkQ2hZdkpX?=
 =?utf-8?B?Yk9LV0RmVU5lTU9PWHBrRWhsQUZIekVFelhLNHFrSEdpMlpVdjFySnFMZzBj?=
 =?utf-8?B?cGIxTVFxYnFzNHh0aTJuamdhOVJYT1pVLzhmNmZoa0RwVlhNZWNqREFLY3Ey?=
 =?utf-8?B?SmxtSWZYbmFKRk1iZGFqMXVQWklJeDNBSkM0ZURJd0ZDOFVwQjJ2WksvRDJJ?=
 =?utf-8?B?Zm9VdHBOUnZRdGZ4UFFIUzVYbUkrNW43L2ZvcTNnS2wwcGM1YkFBRjYrQ1hL?=
 =?utf-8?B?ajdRdll0cWVuMGdtMjVPeTdaVXluWXR3MlFaWXZPME8zNzh2ajdNd0JjWENq?=
 =?utf-8?B?UDZ4WTU3N1VFZE5TZ0hvWGNKaG5JNU45VzNTTDIrYWMzd0Jzak5vYWhreXpa?=
 =?utf-8?B?ZDVDMnBIOFJUWEtORWFPa0FJSGpoWEdxaXlPMUlITGFKb0hEOVowd1crVmxh?=
 =?utf-8?B?a3ViVUJocmhLSytnazAvSTRKNzBGemxCUWM4Q0dIQndoL0J6a2J0bVY3RUh4?=
 =?utf-8?B?MEJ4WFZLMVViS29SR0Q1anFnWkRSN3RObitZOCtRbjVscml1dWgyL3NHL1lw?=
 =?utf-8?B?WjlYQWVsMGsrak04emdGT0VWMi82YVdiaUhqS1QreGEwK08zdW1vaTRWczcx?=
 =?utf-8?B?YWZ2U1htVy9EV25Hemt1Sk9qa2dtWXFIdVlOUnRFS3lleWUzYVBSc3BId0gz?=
 =?utf-8?B?dEp4dkVQSjNzamZGL1huTFpMRitILzNvQmVjVXlwT2Fmd0xBSytHQnNWT28y?=
 =?utf-8?B?QS9rY1h4QlU4T01aeVlxSm9vSXlUNnd4RDMzUjM1anF6cXFJcWVDRGF1Y29K?=
 =?utf-8?B?UDhlUW9wOGJxcmt5L3U1SGJhc0VYNjkvSmxuakdtcGpvdmlyNHVxVXBkbndI?=
 =?utf-8?B?cU9OS09ZZk92S090N0pXZVgxMW9xTjZ3aTVKWmJkWGFEQW9yVVNxblgzREQx?=
 =?utf-8?B?bkZvdWtiWDJLeUFUQnhyVmN5RnJaM1JMVTF0d1hqT09sbnllcFpEajlBV3RG?=
 =?utf-8?B?T2RtdHpPS2xEY2hDRm5XUHIwdjFxYlYxVHppQnRldk1jWlZqbjJRVlg0SWVQ?=
 =?utf-8?B?eEN4QTUxWjJSVklOQmlUS2E1cEV0dkRFQlVWcU5VVHRNZUNTclJETS8ydWFG?=
 =?utf-8?B?eVBkejI4aUc1R1dWcWtRRzVEQnh1dVhGcWg5eEdpM0lkVDUyelFUSFRzTXVq?=
 =?utf-8?B?UzZxMGs5TlJzMldGTVo0c3d0TjdqTVRMTHVLR3FhMXFpMnA4MWlJSndLQXA4?=
 =?utf-8?B?bGtoZ3lhd0dyNEdHdXRqdENjOWowNTZ4UHNTWS9vS0Z0d09WMVJTQ3BKOHpj?=
 =?utf-8?B?ZGE3aHdib2xoU01hQklSL2VTNkFEOE1Oc2JxSmdNUGE2Q0xsMHhMcEhuZ3Ay?=
 =?utf-8?B?VFJYMHM5blp0Q2dpWjFQZ01RT2wzUE5Md0xUK2I4bG9zUXcwRjVuMUpiRFRx?=
 =?utf-8?B?WEdBT1UzU0hLaTk0aW1KcVFPdWt3RmVDaXIxNitIbmYydlVudC9CQVdRaVlL?=
 =?utf-8?Q?nEfl5HDiixa4gjuaAQ/NDefWJd7XMPeT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NThzNm1TaDh5SitrSUFFRUY1Z3NtZnNLVmxkRHBHVVdrTnFYR3hiNnZwTHA1?=
 =?utf-8?B?ckNLNkVYSTdaMFlqeHA0S2pQQTlZS3FuU0NaZWlqQ0dNQWhYZ0R5MmxybS9i?=
 =?utf-8?B?MXVhNnlJSktzdTBGMEhxeGlNVTlPeUVXNEZCSXMwTEVvRWtZSDA2dkYwMWN3?=
 =?utf-8?B?MGsrSmhSZkZwOVByZ2JpK0xLMWU3NVVPNVRmeHVUYzJFRGZ4eG84WGFhWDdO?=
 =?utf-8?B?UEtxUFhuUU51OG9kOGhmemo5R0NnaTQyc0sxZGcxMkVNd2FVditMTmFDZGFm?=
 =?utf-8?B?UWNWRVRtY0Y1aXlwN3lLYXo1RkdIdFh3SExMYmNpTWxYK3kzSEJDU3VBdTA4?=
 =?utf-8?B?WitmTWw2L3FzVzB0LzFHTE1BbTR5YjRzbkJFZC9samxOdkJwZmhHa1k0bDIx?=
 =?utf-8?B?US9kSXlpR2M3TzJSS0dEMGN0QVpRd0xtTnN4YkdmdUNReGNiVmMrOTdjVmw2?=
 =?utf-8?B?ZWZBMXhNVWppMTFGUkJVZFBUSUZudVY4TTJ4aXZEMFlmaWhlaDFzV21LWDg5?=
 =?utf-8?B?WjNZT1ZzSlhGcjNpTU0ya3o2aFpKdk9TSVFRSlFWSjAvUnFDTGZMYTNzUTl1?=
 =?utf-8?B?akJYVjNpamxvWWZ3T0hBUmh4bzZaSkFyUnM3cEtReGJxMGRvV0I5Z1diRVBp?=
 =?utf-8?B?c2g5em1NZ3dERTJrWjdXMm14TlJGZlNRTUplcjJKcUU1SUVvNW4rZ3VOTHFJ?=
 =?utf-8?B?MEpuYkpwTjV5MzE4ekpoYW5UNkpSd3pPWUlVUFBzWER2QlpKVTFYZGJtU3dM?=
 =?utf-8?B?WkluTWZLMmROYTNxMUlPVlc4WG1WSzRiVVQyM2hZUHFKYmZubWNPckxEQmxC?=
 =?utf-8?B?RndLSEZ2TWFVcnZRa3N5cnczMzVYWUFRcmdFNURKUGhLbkJXcnk1TEg2MStW?=
 =?utf-8?B?VDc4T2V2ZXFNdWxYZ3pHYTBDMG5hekJlTDlaVnlQUEhKUUtkM1R6WlliTU9T?=
 =?utf-8?B?TW5McW80ZTR2cVlOZ2dZenBPbDJKU3JTMFZuN01NQVhFdUlmNldTRG9wUnRY?=
 =?utf-8?B?VXUxMW5iVnpPZW9GTzh3V1FuWTAwQnlPVHIyZDVBcW5iSXdnc3gzZThnSU10?=
 =?utf-8?B?SHpoT3F3bHNxTnVLeXlyMFdhUFVsblVkRnNoWldXMFBaRGJma0JmZVprUHU0?=
 =?utf-8?B?bFB0bDR5WlVyWVRKb0xWOFpFaTJCMkRlcWQva1E5NDM1c1lYYjY1YXE0N0th?=
 =?utf-8?B?dXl4cm5vcVRXc21oOGVKdkdqRnBnRDBaODIydjBsUTIrU0p1NXdpdUo0Ylda?=
 =?utf-8?B?SWdKaVRMRDBYYTFBeG5TRG5odlN0ZnlTbDE0dlBzdDREWnF2Mm9TSXFGSWU2?=
 =?utf-8?B?S2FjaS9HL29GQ2NUY1lNRytSWk05UGpUa2pOWENRaVYwQWVVWDRwN0dyYWVX?=
 =?utf-8?B?UEJXM2JHRVlwOGVuNDBaMm5ieU40K0YycWx1dks4blNQZnl1RUdZb1R4MVI2?=
 =?utf-8?B?VlMvOHRkaVZqTU02QVVXNUR1K1VSK0VWVUlSWkVFNnIySHJrUmRQT0w5eFRk?=
 =?utf-8?B?ek44UU03Nm0vMmwzNnJxVlViU0Q1TVE0Q2I1MDhBbkRMUm9zUXRtOVZ3bFVJ?=
 =?utf-8?B?dnQvNzJGMWRUMEhDQXUxOXBRdFZsVTYrOStJYkRnRW9OMXVpcGRpMndHd0R2?=
 =?utf-8?B?MGRIcDVkZDhyeUhobWdIYXdLTzJiR2lmcmRaWUtjc2V4cE9JdWdFaGVJa2V4?=
 =?utf-8?B?M1VyazV2Vm1TRkFZdk40U09aZU5GcUpCcUFQeHdhSTMvK3dKZ0Nrdyt5emVi?=
 =?utf-8?B?aUFkc0pnbTN1TnpvVHgyWlVSZnlOVHJ0VW9penBMTkplNkFLUW02SnFuRmQv?=
 =?utf-8?B?MU12SnBSNldZMVpGejd2TTJjR283TEtIU1daODFlMFpzMTlhRXVoM29BUURY?=
 =?utf-8?B?WXZ3cHErclhEcHBLN29VdkIwRmJRVXNlKzkrZmVWZVhreGdnYVZPUkx4cFh1?=
 =?utf-8?B?cUwxNHEybzRRdEpEMU5ScU9mdEYwSE44OG9ML1JiWlJnYnpxVDVFRzROQUE2?=
 =?utf-8?B?RWhSVkdmYlQ4bTZ2b0IzSXA2MkpBUEsxWURHaUUvN2IrL0JlaUlFY0pCa0Vs?=
 =?utf-8?B?QmxlY0dKUTNhYmx3UHA3aUR1YWlUSExQS1FvVUN6N1pxejZjcklINmhWMzla?=
 =?utf-8?Q?fFPpDEs2Dplb8e/mj7snLM8aq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52af828b-9a07-40a3-d226-08de3d39cc9d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 06:59:19.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqdAcdiNZIdf6m9CeSk2rNZNUHq10gZ+JqmdB9vZTPxW8tVH6CPLhGkGPoJGpWpf1Ni03WjTyTHLFuscHv7chg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3676

On 02.12.25 09:56, Mauro S wrote:
> 
> 
> On 11/26/25 12:50, Mauro S wrote:
>> On 11/25/25 17:51, Jan Kiszka wrote:
>>> On 25.11.25 16:10, Mauro S wrote:
>>>>
>>>>
>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Not sure if I found an obscure corner case or I'm doing something
>>>>>> nasty.
>>>>>>
>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>>>>> Target image and toolchain generated by Yocto.
>>>>>>
>>>>>> Please find attached test case code.
>>>>>> Program is very simple: the main task starts a bunch of joinable
>>>>>> tasks
>>>>>> that immediately suspend theirselves. After starting tasks, the main
>>>>>> task resumes all tasks. They do a small sleep and then terminates.
>>>>>> Terminated tasks are joined by another task, that was launched at the
>>>>>> beginning of the program execution.
>>>>>> Subsequently, main task continues to recreate, restart and resume
>>>>>> joined
>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>
>>>>>> What I observe is that, when calling rt_task_resume(), the wrong
>>>>>> task is
>>>>>> resumed.
>>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9,
>>>>>> the same
>>>>>> of the terminated but not yet joined task 0) has been resumed when
>>>>>> the
>>>>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>>>>> execution, but has NOT been joined yet: if I'm not wrong its
>>>>>> resources
>>>>>> should not be usable until join is done (at least this is what I
>>>>>> understand by documentation). I expect that calling
>>>>>> rt_task_resume() on
>>>>>> a terminated-but-not-yet-joined joinable task should return an error,
>>>>>> not resume another task. Am I wrong?
>>>>>>
>>>>>> I know that is some of a stressful test: in fact if I call the
>>>>>> rt_task_resume() only if task is not terminated (checking also the
>>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if) the
>>>>>> problem obviously does not happen, but as I said I expect an error
>>>>>> instead of a wrong resume.
>>>>>>
>>>>>> Launching the attached code, you should be able to reproduce the
>>>>>> problem
>>>>>> on your side. When the test detects a wrong resume, program
>>>>>> terminates
>>>>>> automatically.
>>>>>>
>>>>>
>>>>> Can you rule out data races on the shared TaskList structure? Seems
>>>>> both
>>>>> your sub-tasks and the main one are accessing it, and that possibly
>>>>> concurrently and/or unordered. Or does this also trigger in a uni-core
>>>>> setup?
>>>>>
>>>>> Jan
>>>>>
>>>>
>>>> Hi Jan,
>>>>
>>>> attached the modified code: each access to a TaskList element is now
>>>> protected with a semaphore (one semaphore each element).
>>>> Strange behavior happens anyway.
>>>>
>>>
>>> ...would have been too easy. Ok, will try the other day if I can
>>> reproduce and maybe even understand.
>>>
>>
>> Hi Jan,
>>
>> sorry, I should me more verbose in my response.
>> First of all: no pressure, take your time.
>>
>> Then, a more deep explanation.
>> I added semaphores to avoid possible concurrent access on TaskList
>> elements, but I already verified that code should access them in an
>> ordered way without concurrency, thanks to "joined", "started" and
>> "exited" flags.
>> In detail, TaskList elements are accessed:
>>
>> - by main task
>>    - under task creation, writing task handler and "joined" flag: this
>> happens only if task was joined before
>>    - to resume task, reading some elements ("started", "joined" and
>> task handler) and writing "resumed" flag before resuming the task.
>> Here, "started" must be 1 and "joined" must be 0, this can happen only
>> after task creation and start
>>
>> - by sub-tasks ourselves: during their execution. Variables written:
>> "started" (at the beginning of the task) and "exited" (just before
>> termination, after task is resumed and did its sleep). Also, verifies
>> "resumed" flag when got resumed, to check if resume request was for it
>>
>> - by join task: this happens only if task is "started", "exited" and
>> not "joined". This can happen only after a complete subtask execution
>> task resets all flags and sets "joined" to 1
>>
>> Printf sequence seems to confirm that execution order is OK.
>>
>>
>>> If you would like to understand a bit more already, you could catch an
>>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e "signal*") and
>>> study the task interaction (trace-cmd report / kernelshark).
>>>
>>
>> I'll do the setup to trace events (I don't have trace-cmd on target, I
>> need to setup a qemu image with it).
>>
>> Thanks in advance, regards
>>
>> Mauro
>>
>>> Jan
>>>
>>
> Hi Jan,
> 
> I made a sequential version of the test application: instead of having a
> join task, join call was done by the main task, one subtask at time.
> With this code, tasks does not access concurrently to variables.
> Problem happens also with this code.
> 

Starting to look into this:

> STARTED TASK Task0 (82a9eab0-829636c0)
> TASK Task0 RUNNING (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
> STARTED TASK Task1 (82a9e2b0-829526c0)
> TASK Task1 RUNNING (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
> RESUMING TASK Task0 (82a9eab0-829636c0)
> RESUMED TASK Task0 (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
> RESUMING TASK Task1 (82a9e2b0-829526c0)
> RESUMED TASK Task1 (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
> TASK Task1 EXITED (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
> TASK Task0 EXITED (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
> JOINED TASK Task1 (82a9e2b0-829526c0)
> STARTED TASK Task1 (82a9eab0-829526c0)
> TASK Task1 RUNNING (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)

So far so good.

> RESUMING TASK Task0 (82a9eab0-829636c0)

And here you are resuming a task that is in waiting-to-be-joined state,
right? That is an application bug, but one may expect it to be either
ignored, only affect that Task0 negatively, or even throwing an error
back to the caller.

> RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
> ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME

Instead, we see that spurious wakeup of task1. Let me debug into this...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
