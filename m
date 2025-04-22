Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91EA59
	for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300047; cv=fail; b=jeSX4oD+HB0AHVT5D2krSMRWjbf/+6rRO4n0hnfo6Kj1PNoR8pZGNsY8JhpycT7k11Uyn4YI+qSwvcX5tJH14ffTR2+jE/3JZc2XX8ryuY+Xt9KvJ75M1+N/TrxCnE141rSXLmuBzdhqayxthXSsJlwhbOrSLFbNEJPFSTmE1T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300047; c=relaxed/simple;
	bh=3o3xXZKaFo5EayKdvJpkevOz4kruKUoFRFf8HBxj0q0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uT2Bkt6y64QhPx7wutSQyek0dtFEiyPxfD8Jm5mLusv065s14lFtqe9NKkAGz4/96oefXtOAF8gQsna16DPVlUbywlIizsFHLCUlHFxeeyKefjZRinOAYOdp2yC9dPky+Wgq9WFzAoQSIUQf15R4QS78Wzeh4CSdeJY7iNkKEJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mbT3z676; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mbT3z676"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6gdPGlDt7mCpT3S8sB5rbSfWQqo7VIgYJSR4Xf1ggz2LvAc7+8GYr17vCHVx2VqLD8vHbtXxV1WECNldhi4/YsiwcE9uRM4AeIC2lxLYxjtyG4JPQYOrrJhzrVrTYqCNK1aEB7tCiHjANODiOPcaT9yrpnLL7JwjNy9Alf445o67Cnpbnz5MAT3gcYmqflHY+1xrGxAYwlu8mukYhMwI7M879nMk84IHJmXRpDJwswQ7QyNc6njMHQ+31BgecF3HCpxwl6lkMW3Z0Xk7qYhT+Y97fIrvab21x1gVm1huojInmywkl01JG6/ZRwCWgOhC+jbDIIbrPmKO5poT6Blzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+QU13udF0zZQzg39MScSW6GKPYauFJUhtj5azolYas=;
 b=JOMLE4ZnyD5KYsh05X0nV1YWu64ARazXcHPQtI0/JKCMMKWUaCo3XWULRgnPdfaJPej679ogyf5Zw/zjwzf61jj53Qj2LvLO3rjKrBawvK+InCmXpGxyPf0xHqose2LTYx3hAYGQhrcaKrOiTEzAlQtYs6y0x86sAadAQRLtmRgRI8GHi2jb4D2/w5JXFTTlj2fWEX1D2QiVOVrWv1g4OKKVGVuEVW75B/wGfV7fk/tQW6ZaXgBD/SDFYyVQVFbzO4zsryopkI50Em7uEFwybSWt5iuD5OqvHLVGasi0iBSt+Wp7+P0GKaBgprU/AMMBZtfycL130s38Ls7Xe01Lgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+QU13udF0zZQzg39MScSW6GKPYauFJUhtj5azolYas=;
 b=mbT3z676zmViQyn3NbEgM78OHIAco0AtKukS+y8n9RjijJYkWiSerpbczMPiv1oaiQQs8hKLOOdKMQs0mK4fnMWAO0U6iQ39+LOqNES37YTCbOmbQlNK8Ae7fsdc5I/eIxt7E0FZx1CnbfOzosGoZfcH9sKkU60EFAXMB/G+GkGfIssH01z87Aa7wLdroZzo/A3Yo+Flmq228Ayhxvm2FgpJt2RXsaQN1gv8UcXoW1qi19qpq3E6glPtN7nO1sTbVxM/pcA33eA4BcshfKOjQ353c0aW4J3TjZ+D4cIvHUBbxvEGbVQUjs3NZrrpSuhts0ffziVdIHGAjeZUWz7Bsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA1PR10MB8373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 05:34:01 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 05:34:01 +0000
Message-ID: <afeb146f-169f-4ad1-813a-74f58d73b14c@siemens.com>
Date: Tue, 22 Apr 2025 07:34:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Build error of kernel/xenomai/debug.c
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
 "Qiao, Wei" <wei.qiao@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Pirou, Florent" <florent.pirou@intel.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
 <b1f7b09e-344c-4320-a02e-24ea498a518d@siemens.com>
 <PH7PR11MB7499E92A39A41DC530A0A6F9F2BB2@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB7499E92A39A41DC530A0A6F9F2BB2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA1PR10MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f82f12-8bee-404f-4075-08dd815f497f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3BraWN3YjdhbjkvRW4wWHpXZFBVcElOVWxwMzY3Q2FTcmJ2cGdMK0xFZWxr?=
 =?utf-8?B?Y3pCWXZDZ3ZSa0VtK0JmY1JOcmttcnNrbWlucytzWmhyRTF6Wk1qTE9OcEZW?=
 =?utf-8?B?a21wYkExb1M1dS9QOW9jYUh3N2I0NE5VZE1ZaUpYOWhYMnpscFM3SUJZUTcr?=
 =?utf-8?B?Q2FKb0hCUnNUTTY4eDVkVEdYSHU4ZVJhb0FVdU01NjRYZkhpa3pLSzkrZ3FD?=
 =?utf-8?B?bGh4eUdBSXR1TWxxVm14ZFYvdGxJQnhxZWlueWFZdmtuTE5ZbVMvZlJOQVZQ?=
 =?utf-8?B?M2t0Q1RBZkFRRTlQZWI5dEEvRWZLcjVKcm5udFNrVHZlWUpNZEFwQ1ZXZ1pa?=
 =?utf-8?B?WEdLMWRHVFNYbWFTWm4vU3MwdUx6T0hSSkNsaGFLdHYxSkVvMUhYMWd0UTB4?=
 =?utf-8?B?M2N4K3JST2x0cThwZkhuOWNKY1ppakxZVDVnSzF5WFRFbEpZd01qMTEydFhm?=
 =?utf-8?B?cXJGK0lPQXJSR2h2RXdlVHN1dWJJeFVaN25pOFRFcEtmeU02cUNsa1MzVFI3?=
 =?utf-8?B?RFF5Unlja0dKQXV4WjQyenFSNnFkMllpdExuNG9YMDVKZmFsTENLQzhIc01P?=
 =?utf-8?B?Z1dBa3lxZUVlTmdsZ3JUV1BQVWVnbGZtaGpiaFVCRElueUQ4RDZ3NkpMaENk?=
 =?utf-8?B?ZkM3MUNBWlJpbFlMMEVlUU9YQ1JleGplNmVJdmNSNTl3eHgrMjZUYmJLSHha?=
 =?utf-8?B?b01zMEFzb081QTEzeW0rQk10bVZQQ3VNZ2NuNVdSblNFL3dVT2JZUi9QaTU0?=
 =?utf-8?B?Tk52aHNFOHh3SzJJZkRMQlMrakVZMTRjT0d0TnNObG15RTJPUzM4RTVHTVpM?=
 =?utf-8?B?ZW5say9HY3BuVFFTa2ZUYjViSzlCb0dHZGtlTmRCUGJQcm03UDM1bDMvY0px?=
 =?utf-8?B?UmpvNjRHZS9BYytheFE5cHd3R08vdjN3NjdOajVSU2xNYmU2VzhNSk9HQm05?=
 =?utf-8?B?Zi84NklYREc4RmpVdFFDOWdmdkxUeElOVGhUTm5BaVJNcXJGdnowT2FKR0hC?=
 =?utf-8?B?eGNDUHpMSjJqekxsYjBackNZU3lkaG42QWZsT0N2Q3F0eXJNQzEzV056YjZw?=
 =?utf-8?B?dkJtNmtKSE83OGNDZVhtTWREWGdwZHVVL29JTkZvb0VzREgxTXhHcS91aVli?=
 =?utf-8?B?NlMvTUJXQ3YvMDB4MXp0bDJ2VVdST0F5SFZOT3lVVXhXRkUvQ0wzMCt4d205?=
 =?utf-8?B?eU9YNCt4UUdyYmJTcjQrejlBOFMxSnlFZzJVVCtlZE5obmp6Yk02S0plNjBX?=
 =?utf-8?B?M3ZuckdsMk9sanVqd1Z0cFNWdkhETnRtaUV1a3YxRi9aRGlGdlJZb3B6WUFu?=
 =?utf-8?B?Zmh3OU5KUDNwZmcrS045azBYd3hQWjFrYU1wOEQ2MnB5Q0wyaXBNWXlxUWVm?=
 =?utf-8?B?bkRoazluVmZtRjRSREl6WVpLYXNvWlh1S0l3WVI5elplSG84K2ZtckcrVlV5?=
 =?utf-8?B?K1JXN2VLR3RKblY3K3M4MFZIZDQ0OGowY0Mxc3RJK0tCUG5VZkFRMVkvQkJY?=
 =?utf-8?B?SGVMZFdMdnZITXFrZmF3UUEyZ0E0bDBmbi9iQ0FRUnJveis5NTJuVm9SbkJj?=
 =?utf-8?B?elJYZ1hycTMwamtadjBLQnNLaElCU05WS1UzUC9TdmU1YmJLRy83b1A5bVBY?=
 =?utf-8?B?MGtBdTZpS2RqSzE5dkRsUmRPVkk1WGVJMXlkZkVPY3MwNGlVS1FtaU1TNVp4?=
 =?utf-8?B?ODhac3hmVTN6MU9ya3BmbUhLczJYMTZxVjYxT2Nmbm1IYUFZNWxveGpyMGhl?=
 =?utf-8?B?VWd1ODZEeS9BTTN5RUltcjdBU2h1Q0NTVXorb1RlaktsRUhKN0ZSNGRpeDV2?=
 =?utf-8?B?V003VUNPeGRKaVZRREZhRzJyUHovU1RwTURQd290RWVjYTVIaWsxN1pETHFB?=
 =?utf-8?B?UnF4c2owdU9GY1Y1cHIrNVN0Sis4WXVtUkVUV0xRc1RhOGJVdkNuMjd2c3p3?=
 =?utf-8?Q?2a5TpQNpHTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWh2ZlVrSGoyS3duSCsxQ2hFL3BRU3lVbnlYV1cwNWlzMDRzYnNvckFYOGh3?=
 =?utf-8?B?MGEvNmtmSXlnMFVxT1J1azNPT1QwbzRtc2R5b0l6OWJ3dE5uT0NLeUFpS09N?=
 =?utf-8?B?OGVnUnk0ZzFVVEIzN3FwTTlkcGkycFdiT1VrM1pVbHVJdkM5dWZjYWJZT21i?=
 =?utf-8?B?andDTUhTbVd6NStWSmRJQzlkSWw0VHVmbWQ2eDg0VEF0dU4ycEgwVldESysx?=
 =?utf-8?B?YWFEditwU0d3Q2JZMTVGZHcrdTNKQzI5VVZHNTF3Q0lGaS9JS1oyOWdDajJn?=
 =?utf-8?B?TEFuVWRhakFSdkZmblpYZnE3WW9SMFN3SjZqWGNWNXFSZXYwVU5rcnVHV0pI?=
 =?utf-8?B?TFh0eGQ4M0o2WkwzWVM4QXYvMVNyR1pUTXRMUWJpTVhWQlk0VnpnRFZKZzBx?=
 =?utf-8?B?bmRjMXk1bEdUSis1Vk41cC81NjBDNWxocGkvMDBRa01JalFJeTZ5bHFCb0o3?=
 =?utf-8?B?TTZkM1ZKOHZ3Z0daY1lhWGoxVkwvSlczLzNxcjAzVG9JaTNtejFRdVpPaFJo?=
 =?utf-8?B?ZHh0WjlrVmFwK2tUWFI0LzlzNVVkcXArT29YZSttMVFzbmxySGtVaXg0V2ZF?=
 =?utf-8?B?WUhVNnVkeFI3VHdOYTZ0MHhESnRVYzRiWGQzeXBTTEhNNmNCYTZWdHU1cWIy?=
 =?utf-8?B?cWp0UjdQaTFBVGlEZll5MHk5SkxKR2UyWGoxbFpMVXJXalZYUHA2eDAvTFQ2?=
 =?utf-8?B?QThwQ2Y0SUFFS0hObkpEWEFCWWRoWU5ITE0veUQvbkJHaVl5a21GQWVVUVJJ?=
 =?utf-8?B?aS90KzJjSWQ3eExMaGhqaklON1lLT2xsbWU1UnpYV1Z5bzNiWTlScFVrZnlp?=
 =?utf-8?B?bllNODlJTUczcFUvU1dNQ0VQZEVFblpTaGY2YzFpT1dGVkFqVU9CcE9WdGVG?=
 =?utf-8?B?a1BmVjVZSUNVSFdneXF6THNPaTE4cTZLSWVZVGVCZTQ1dThJbnpvZ3UzSHor?=
 =?utf-8?B?bWZvY2h5bmlVYXN0ZVY0ckM3bUlCMUtpaE1SNFhlSXlpN1BHQkJBTFV2cFdl?=
 =?utf-8?B?RFpISjYzbE9DV0NuTXE1SEZ0Si9uSDNZbXVKTHFkaC9vU0RiS2lvbHVqSFg3?=
 =?utf-8?B?cGo2Q0hnM0U1aEVNT0NCZnlZcGJNdHFKT2JmNWNYdlZER1UyQjVVSDgvdVBk?=
 =?utf-8?B?elE5elVpaTJlRmoyVU1lMEZlbXh1bEVuSUZOYVord0hEZUM3UDB6QlROY3dQ?=
 =?utf-8?B?ZU1PRU1IQ0NmT3VXM3BIaUdYUWJyT3RRaXpUYm94VS9JNzlqOG5ncU1YNDN4?=
 =?utf-8?B?R0JZR2h4Q2FMQmNyNTJYTlBySFMzcVhiZzFKdFZlb0F2aUhzK0lta3Rrc2Uw?=
 =?utf-8?B?dzVtYTJFTXJYbUVNZVhkL0g0Z3hZK0J2dHVjeDBwL0xmTUUySjYxaXQ1bkRy?=
 =?utf-8?B?R0VQMHNKbFpzbmNXSVVrV21ldTZDTlRjblJHNEFvTkg1a2E2eVlwbThYOEJt?=
 =?utf-8?B?L0NkMVhEdkQvcEV3WWpnZGdGWEtEUStXTFZzcVdMVWw5OXN0ODNGR0JEVkRl?=
 =?utf-8?B?bmN0dk00a0xqbmpzTnlBd3hSR3FGcnc2Zy9SaGp6QWc4QVc2cXJya2p1YzMr?=
 =?utf-8?B?ajFBb3NuTWRlQ3I1V1lNWlF0TVJpNit5WjdPL3dQNkZoOVhKV29UdytkKzhZ?=
 =?utf-8?B?c0F2bWFXZUp1TTNpcFpSUU9FQlRZRjBNalNCODBHTXNkbTIzbVFucTEyRkZr?=
 =?utf-8?B?QmhST2xLMlJYZTNQL2pzNU9yNTd2WURRZkE0RGJlSG5MY0tacnl3RzgxQmRq?=
 =?utf-8?B?MTJBRC9TV0poR3dSU3hZOUVOSlBPMWhGQXljWFRtYThjM094OE84YVFUK2xw?=
 =?utf-8?B?bURJNW5EQm5jV1B4UzVLN21aSXpIelY1TnN1SnFUczZlcDE3N2V2a3draHVP?=
 =?utf-8?B?UGMzVHE0WjAranlzd2tmMklmMHFxaGZkTGpncS84elRUN1ZmSjMvYXFma1RP?=
 =?utf-8?B?WGNYKzZPRHI4S1R5TFY5bEVNZXJEU3ByOFM3b1ZKaXdaUkU3eEdmd3BBUXp4?=
 =?utf-8?B?V21CUmhxZ2tyMkRFdVlUWmFnNEhIMEg2THZaZmxQWUw5b3dsZllqSkI0NXI0?=
 =?utf-8?B?QnNRalpEc0ZIWENyVGY0VkVtTDI0ZnRmSnpTS0x2bCtxRnR3VXFwVWdjUHhT?=
 =?utf-8?Q?WFM/Aa47ojzthIpP1rw2d3qBC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f82f12-8bee-404f-4075-08dd815f497f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 05:34:01.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNnW1C+Iyxxc4EUhnDhCvUYkKlrqom8uTRo0GW5zT/ISHbv1BNNJT053rfNqzyPMag2XWAxhU/0xaeiWscMpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8373

On 22.04.25 05:16, Chen, Hongzhan wrote:
> 
> 
>> parameter)
>>>>>>>   787 |                 __write_overflow();
>>>>>>>       |                 ^~~~~~~~~~~~~~~~~~
>>>>>>>
>>>>>>> This is because new gcc version has stricter FORTIFY_SOURCE( =3 is
>> ‌stricter‌ than =2). Please help to fix, thanks.
>>>>>>
>>>>>> That is the flexible array story...
>>>>>>
>>>>>> You could try something like below (completely untested) and report
>>>>>> back if it works:
>>>>>>
>>>>>> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c index
>>>>>> 25b194c26..d048dc757 100644
>>>>>> --- a/kernel/cobalt/debug.c
>>>>>> +++ b/kernel/cobalt/debug.c
>>>>>> @@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
>>>>>>
>>>>>>  struct hashed_symbol {
>>>>>>  	struct hashed_symbol *next;
>>>>>> -	char symbol[];
> 
> Can we try method "DECLARE_FLEX_ARRAY(char, symbol);" introduced in https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays ?
> 

Documentation/process/deprecated.rst:

"There are two special cases of replacement where the
DECLARE_FLEX_ARRAY() helper needs to be used. [...] Those cases are when
the flexible array is either alone in a struct or is part of a union."

Maybe do a memcpy using flex_array_size, instead of strcpy?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
