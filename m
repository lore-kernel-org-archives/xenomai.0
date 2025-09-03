Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013024.outbound.protection.outlook.com [52.101.83.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8C2BE7B4
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915952; cv=fail; b=mqBDJWX4GWWjVR8mdIzxXqPEVjHg4Az7I3dPvIsZEDP4poVIbomrKcujiBWWfFfqngg7NVEwZgfifGfAHDLUykIL8OT07QPD/Mm9JcdoDA9+hU12o24qW5QeuMRM7VbNguiYSoaVQZH63tczg9w4P1ZjI+0QoS9WuKlahc73P/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915952; c=relaxed/simple;
	bh=Ya2XmoAiO7RFNDVGfUnYDqwOhwKW6ftBO63u5l0DQdo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DkjhrYIOeI5cPamx6ZewgE7SIBGmmXOQYYkhbNQxR2ZwgUgCdPpaTfO9aGOvpqNal8GnGjxWEZs33G0WnQeVbAVlmh98+d8Hx/ne9fXIc9KvdZucogPKrd7JDY6d7gCXN8mTpKu0/Alupt/M+EoKY7H92FzScMnxjShIWU6dpSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HtHNK0/h; arc=fail smtp.client-ip=52.101.83.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HtHNK0/h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7fwTBMakDwpX4X1lKgZqjEfLNkSc1Gmbck8U5HXnwenSYigOi0qr60a2gar6Vm3uCvut9W1jPxHNcWzkyqc909Qw+KDItWGpx10pojg3yxRDwRo0kPEWq5GC+5DacSx8LL/5L2z3u57gWB02iOVXTIfLRbe9jI+kPJdOV9E08Iz0MokFc7/Zct1VEw/uYXnoqUs4l1hN3KCNH/2IzNmRqzps4brmEgfe+MX9xgsnvOrnJ4FOBpLFqZ/n7e1Q5ecbYCJpoxIbHG6S6XDWt2wyALQbgIq76aOz3cP0BzLBYB+8LAMB65bd2EsGcv9R3fghTUW/qc/zKnAHf37/5J4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2jDdD0U9iEPtuDth1/Qtp1zGU4+H7g/fJASlowgON8=;
 b=QIe2DieJk7mFSkMqUQWenjt+zuazRQbsp4/vIaAZSZML9pIPKLsvVijgIWxaowMeCSjVdMN0UxNIkAwVaiwmtE8F1f03doIjBQP90ADzCTWJCm7fBtE49w1A9rcrx+W9XjF5U0/5BcdU3rweAwQ6/PuNuryGbdRzuxjpTpp4JRYXiohkjOsMVi356nhsQrlqcq+jdRUwyJE94PMic4Q+AhlnXxuEAwugjxh478EHdLdRN5CB0fIkj0Mu2mVS7JU93tm4jPdCVsUe3fWxZweFoXcw0CPFPpjMVEZZrf+NwX3mTglyVdg4AgmICOktm2T22WpNkYfo0xEmOkEaDltrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2jDdD0U9iEPtuDth1/Qtp1zGU4+H7g/fJASlowgON8=;
 b=HtHNK0/hnya2KiGnu0ITpItZ9/KXHR4XY5ZGlYwUm5dW2GxG89KZaOkVu6TsCB5NQ3ky1zOEFWGSrsP2+7EMs0fvblLY3uOS9JB7GWP8efW1pSsNsFXad7HPvbVjA/W6RGi6VCd8xHGZj7coxuA5yeiH1sC3LaZ4spB8MJ6zns2FfQjsDPQOr81EuDMophzTV1HDQpb5JaWBk8xQiWkaQuoX0mbPcCHtsB7UIsSN0gzMLvjBO5DHkn380Wv78oZWNBWi+63RPGhdZQxCYc7qol1VP9d1TSRdaL+lrxHEYXBCIYX2sfd/r4g5TeJzyaiTEmIYZNSGWnK1tMDyIZ8bnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB7307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:12:26 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:12:26 +0000
Message-ID: <5654f25b-911f-493c-b66f-192b03be6be0@siemens.com>
Date: Wed, 3 Sep 2025 18:12:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/2] ci: retry 3 times to download the
 test report
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20250903122513.1072751-1-Quirin.Gylstorff@siemens.com>
 <20250903122513.1072751-2-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20250903122513.1072751-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0423.namprd03.prod.outlook.com
 (2603:10b6:610:10e::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: c13a330b-8c7e-477c-a8c4-08ddeb04ac90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3lOOHdPdlJSNVhNazhyMmxFREdWYytHdTYwTXhoYkwzcnZrV21oTHgySHE0?=
 =?utf-8?B?ek5BTjltZVNQSVZmZFduZ0tma1p5ZVF5ajIzZkRUMDdOUE1qMTZHR1RmcWJv?=
 =?utf-8?B?VDBOWVNZZ0J2K2RXUW1kcnFUTERGbENtTThKR1RLMUdLQmNmUjJtR0Jkc1VW?=
 =?utf-8?B?em5OcXlsblM0cFZhNGxhSTE4cStmWEFnUS9adjhHYW45ZGZuUjJEdDR3aUFJ?=
 =?utf-8?B?VE8zSDB3Tm9CZnVDQXFTZHpRd1poZWVFQ3dUVU1BeXkyeXYzU0hzS1VaSEFV?=
 =?utf-8?B?T2JYanVxMkxOSmNWZW9oSk1FRVRLWTZwSk5IdGlwSFQzWFVZcUtUTzF0OXk4?=
 =?utf-8?B?ampqV2RDMVk3NG96STM3U21zbXJNaUtyTmJ6NHhJaTJINGxVUTVCSWtRZ1VY?=
 =?utf-8?B?aWtzKzkwTVFTTUtFaUJtM014ZVJpUm9MWEZjVkovMDNlNUkrTGVDTndjaVo0?=
 =?utf-8?B?R3dkZWxORngzMzhtV0tGMmQ4cEgxeGhnbWRvaStPM2ZDRmhrQmFKcmRwOTZF?=
 =?utf-8?B?a1hpbkVmYnNEenRqQ29aN1BuWEtmVHB0QmtSN1RQTmZCaCtPK3p0NndBNkdj?=
 =?utf-8?B?NXdYOEdiU1I4c2tTL0lwS2RSUTdMdEFBcUxUd28zMnI1Z1QwNElBZTJTZGcx?=
 =?utf-8?B?aFVJcStQUFdxMFAzdExUWFdXU2FoYmtodUJlV2tiWEVUQ3RETkdKTWVuV3F0?=
 =?utf-8?B?cHlncXhKK3pZUEJOa1JEMEtIclI4N3ZkTitIbWxaMjB4aDFHeVkxZHB5UVM2?=
 =?utf-8?B?N1dPWFUxeDVjZ2ZBVStzaERxb3RjVE1QQmxrWUp2STUyYzltYVI3bVpzbzZT?=
 =?utf-8?B?emdJNzJtWG5WM3FHU2Y1bjVFbkN4MnRjM1JkRnEzVDNkeCtrWENhZmh2NFFi?=
 =?utf-8?B?cU11RHgybU1rNXIyT2xOdnVkQUc0OW53aUlCR0Vncldka1p3NUxQbGNGSjlG?=
 =?utf-8?B?akdTdk9oSGhjR0VGaENDcUVsSkxCZDZEZVBvVENaczAvSXUwWW5rTUdQK3Y1?=
 =?utf-8?B?RUhpMGxkeUliV1RxNVU1cVE1My9HSks1dG42UFZyY1lUREd4VWlUVG1BcUQy?=
 =?utf-8?B?dFJjcitIa3AxeTI0eDc3ck1oYUZPZ2JSQlI4RWdYREVCelNEcjlvTW9jRFFi?=
 =?utf-8?B?eFE0aXpKL2N2cUpYa2ppRGJsNGFVWjNCdkFsYVFRUjZidGI0clgvKzJ3Rng3?=
 =?utf-8?B?Vk9EQTlCVkkybEN1WElQQVRnWEludEVTZmJqOXJxdlJPeC9GWmR0ZTgwZHp6?=
 =?utf-8?B?THlSbnFkY1ZlVDVZMVp1U1Bpa2VockdlaXpQQmRhSFNVRlNnZWt4S1c1QXgv?=
 =?utf-8?B?SUx0N3ZtZnd6d0dMV0tRWHNrSXV0SEZ1QUFOUmNwTHk4MlhiellVMmNKanRn?=
 =?utf-8?B?dFN1Yk1IM1RKNTB4WGxiRERIL1lOeUR1Z2pYVXZKMjI0OW5YT2NUOTBUc0h0?=
 =?utf-8?B?dVgwRHFaM1VHRzBaeHRYK2x6WklmZThhK3doNHhkQTg3cktlbE1lT2R3WW9l?=
 =?utf-8?B?byswdmZwcjh6aVY0alR5UHRhckNZQThyTThDblF3MEh4eWducUJwdE5xYnlT?=
 =?utf-8?B?VGhvV0tOWUd4K05yam1qc3B2NjN6dHF4TGFmTzhJMjhKWi9DVkx4RjFqT3NX?=
 =?utf-8?B?VU5sMjVac2VGVk4ySlZKRVFvdG1hQWxrSTA1UzQ0WldaT1AzODZRR1ZkSDlO?=
 =?utf-8?B?bnFXWHViK3dSb2hSck02VWxzMVhoNFRkSUZmVlFXRWRVMnFkME1iLzJGSWhQ?=
 =?utf-8?B?amxHeTlUUitROGc2VC9JdVpHZEk4aG9zZ3dsZUJsVFRXVkhVczFsYnowKy9K?=
 =?utf-8?B?cFhWeWp6TE0zdTAxVWdjTmw0YmtwZmE0OTd1TFc2Y2M3MWlIVHpWcDh6SzlF?=
 =?utf-8?B?R3lOYVE1eW1jVVIvSGtqakZPMHlWQmd4K0VkNGpjNDhURDRQUS9NNEl0eFhi?=
 =?utf-8?Q?LQwGREjeCbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTQvdHhXUUJjUmpKZ3RQTldBeUEyYWlVTGxEQVo3UXN0L2dtNjhaTERQRFIz?=
 =?utf-8?B?UGtxSGY5Y0FGV3pyZytqVTJHYjZZODBDQW5VRFlreE1Fd0JkZDViaTdjemZM?=
 =?utf-8?B?TXlsZ3pTejBrM2xEOUdZQ1BoOVBibnZKd2EyakhKUUpqOEJaUkJVdXY1UlQy?=
 =?utf-8?B?Y2VQNzM1UjVnR3VIU2N1bXM3V1oyTVZtUVpKUDhRNllkYWFlY2ZOaUMzZnBN?=
 =?utf-8?B?ZEVkUFRFV2tZc0lMYlVBc1JSOTl3UjM1YUYwcnBoYVp1c0ZKNEQvZ3FFS1BU?=
 =?utf-8?B?K096TGNNU2thVmFEQzM2QTNMc3pDRmIycjBMZ3A5RzMxRGdTWExoOU5nUDFq?=
 =?utf-8?B?QkYxOFVKS0JlbmszRjU5STBWZUNpNFRYM1ZJd2hpRjlZa2RLQi85YzB0Q0FI?=
 =?utf-8?B?WVNtVzAzMXFiK243dUoyK0Z1REVhTkZjaHlrZVR1a1ZyYnFqWjBCbFN3VlVj?=
 =?utf-8?B?R3VONzd2Y2R4NzF3ZmQ1YVJ5aTZPVnpKbmRJaWxZRlV2UzI4azUzUXdFOWlM?=
 =?utf-8?B?WHBWSHhHYkNGTFNBNUZYenZ0NmYzMkFqKzNKSEh4Qkc3c0JiQ0czOFowOWxk?=
 =?utf-8?B?azlwa1MvZ2o3MFdHT2hoQ3EveXZ2TjBHczFtbDBtM3A3OXFncHBMOE9nWmZo?=
 =?utf-8?B?eHIvVjRaQUxqdmNVb2ZycGFlY3VpSllpTE9PYmV3dE9OazJxWDV5UDFwa2g1?=
 =?utf-8?B?OCtKWCs4UExvSElncDVoV0dPalpjN0dIRkN2M1NzZ3RYbUMxeEdybEQvQ0dE?=
 =?utf-8?B?ZFB5RkpFZTJ1Y3gwOHZqWHp1ZzJFSHdFanQwNmkrdytKekhHQ2Y1ekxvK2xX?=
 =?utf-8?B?ZnpZQ2pVU3BKTmRSRXZwa3FRdWl5VWxhTDJhVHFST1lyK3QxcFNyOWg1ak9y?=
 =?utf-8?B?OW5GMHl2NHp5TzFsNEZkL0QzYjlqWElTblRSck1tS0JobHRueHpubTJ3N0Y3?=
 =?utf-8?B?NmhZQVJtbStnclFMS0gvRFp5Sk85aytYZ3dqMFFwK3YrNEovVTd4U0xvbzVX?=
 =?utf-8?B?akpLREVWb1R4RWNRaUFTVlRYM0w2ZGllSldOQ1YvcHZ6cGZLZmJscjBGQjBN?=
 =?utf-8?B?TklIUDY0SlNUdHlYdTRCYk5SeFdBQ3A2OGFtWXBVVDFmSndXazhVUWVxSldC?=
 =?utf-8?B?Vll2a3h4ekVOQUpaWnVDZ2xyY2t0c1B4N1JkQmdaTEVCMm5zS1Ztcjc4M0Ey?=
 =?utf-8?B?cnhLRzdMQ2ZmbXQvdjBPUi8xV1krMWV5Ukdxb2t3SWZMOEtuL1lpWlR4dzdt?=
 =?utf-8?B?b0g4TWpOT0FJV2lmQzR6SlZIRmkxcnNpOFUvV1UrYy9IYnNHdzNOaEthcXpu?=
 =?utf-8?B?OUxBalJJMXlnK0ZtRnR3S0ZCdFppUjdDM3ZPR1pmaHBtQ2J6MTAxNVhVd2Js?=
 =?utf-8?B?ZENjdzZTUTNnQUhyU21Sd285Z25YdTNMYi82NXF6WDdxMU9hNS9yakZRSi96?=
 =?utf-8?B?Rjl1VklCUGVhRlMyV05JVTlyYmJwWS8xU3o1WkVQSGpsMVJRNTBUSlVmc1Yr?=
 =?utf-8?B?dUpOSHpRSnR1WGlGSWhwakN6RnQ0b09uWlBjY3I0MkZONmIvdVZlYm5JeDN0?=
 =?utf-8?B?bkw3bDQ1Y3lQeWZrcUh3YjhQNFRDZXRmd0lNNkdyVTRkcGw5ZHpkbXlRaU9s?=
 =?utf-8?B?MXh1elo3a1NXQWpmcldPYUhyejRwb1ZGbVR0U0xjclZ1eUlaWjNPblU3OVAv?=
 =?utf-8?B?elhIZmpSNUFGaFh4RHNnbllWQzRSY3NOcDNNM1JiVmJDaGkyWDg0dGMwZG14?=
 =?utf-8?B?YWhETVo3cHgrUFNiRG0zMkxUcWhPOENWZVd5OE5QdzdvdU0xWHRoUEFRUDNT?=
 =?utf-8?B?VXU5QlhqZW9uSTZyTVppTW9UdWN5MjZHdU1uaEpwZ3dUZTVEU25Vd3p4OFNV?=
 =?utf-8?B?aUd3RS94cTVLRFBHMnBxQUhuQ2hkTkhJOHdoaXVUSFVQMHZ2SHhmL0k4c29I?=
 =?utf-8?B?MEh2MG9yeXlJcGV0TzBlYzlwZks1S1J0YnJ3ZXl1aUE4WnBWclUrb2RDWEc5?=
 =?utf-8?B?T0JPSjlseE9tN3l6WlJ1MkNIeTNJOGpvRlZRWlZNeTRYSFVUT01OT2xYSkZ5?=
 =?utf-8?B?ZVdiK0hzcjU3bWsrb3ludDU1cG1WakcyTFFjR21CR3NYTmtFMVkwL2E4ZVNP?=
 =?utf-8?B?cFJlamJqdGhoaWRkejNqRy92anFyRVlIVUdnKzRleVhRUUxLQ1pNcENDRFJW?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13a330b-8c7e-477c-a8c4-08ddeb04ac90
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:12:26.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+yzdYK36IpOHCiC8GY6SpvShpv/CyJMsOSPbXKWVvLFoRI2U0GjDEbEV6t7RwdxrT2Q0H/bTu8wSPvQIhG8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7307

On 03.09.25 14:24, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Avoid a test failure due to connection errors.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/run-lava-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index e97dd2a..649e2e6 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -93,7 +93,7 @@ api="${lava_master_uri}/api/v0.2/jobs/${test_id}/junit"
>  auth="?token=${LAVA_MASTER_TOKEN}"
>  url="${api}/${auth}"
>  
> -curl --silent "${url}" -o report.xml
> +curl --silent --retry 3 "${url}" -o report.xml
>  
>  # change return code to generate a error in gitlab-ci if a test is failed
>  if xmlstarlet sel -t  -v "/testsuites/testsuite/testcase[@name='job']/failure/@type" report.xml; then

Thanks, applied this one already.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
