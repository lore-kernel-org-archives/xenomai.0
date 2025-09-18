Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7922FE15
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207932; cv=fail; b=hMab9M5miL+hVbi8hI3tqkvS91nNjxoqE1VWzZkhmnn3MRs/aHAt0WLC9YrKewcfN20uQeM2PHgRJSXzIQU8DDaTDTTpRKsFLw2QhJV5WPRnuJg6KLgcOPovGJAMCaUyhstiH0PTefXreVH9wgs2oR4Cc2/oySmZBg3108fGGbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207932; c=relaxed/simple;
	bh=dakKXmdpmTDPhdKOq3bSld22ALI8kwm3YOlvbrjgWVo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UbOG0sC/M2ZgmhunXF0nEXlOOw55SQxQj/w7JqllgJM3fjKE/pWOm05+fZVXd2XKrG55M9UsxGejuL+0fiu69kiMGOmlrChmgEbv5qMMWWx6VowdshH7TxZHQjlS6P+GGY0wWSoIUGZVPDKrfHX8VMrNGCO8EOSFwNJOmqCq1/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XNA7eJuz; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XNA7eJuz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxdiqPtNXNELRE08oXsiHQku/MyDKmLdjSe4z2hqk5rh0IxuryJWQbiVd0+iLPFScMOLjqjsriRo3YkO5sTQkv2EPasrCsRnhcizcHOrGsjLU+hY6XRmdo2tO42t5b3j0E4omXJGO2QAN4hozFwMx4b4XUGqhWLkaPzdO17MPwLTpSFz7cP8kpXj34mVDdotk6W2nttp50ysuf4lWiSaXmLsdMBpCWl6vVe5JO0JX1bL3XSt/WOOrxlUWFr8PCp+9+azseKqQ1OzE5CDmpjS0nHS5uLpUhzlcjrbPKJhs1qvYZWkaTYJT6Pa/c2EBKLocWTjb6LmoGBeFIsGOIwDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUloQRTuC8JWNs3s36yZarRohxUwVbUd0DSi+icxhK0=;
 b=ATdbFEu7YO+hB/iMsrG6MrzP7lqrKr+6xYOpd+j1emURGR5ZhUrR3U65iJ+h7+PF6hCe13Jo3giPREwosGPfNV5kgpoMQGWNiaGI0CJv3qHYdVgKfRBY/4Wl4jacaX4T8s/6GHFlEZTnPy8cZDUJCcft0+GYjnRUtpqKe11N2qvN/6nSO/RzjXMy0l/REk9/yMkkKIBUxPHbu6bhs7K85f4PjkzvtcnffEIbkrqxtatBWO26q2/sYv2tu8sSWW8k7egD9RN7+xX9gXq/rEm3383yANM9O3fO9q13UyQiv8c7hbTXddnh01sdblqVLQFwNP3Cu46JHKk8LbDP8Ia3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUloQRTuC8JWNs3s36yZarRohxUwVbUd0DSi+icxhK0=;
 b=XNA7eJuznuo8u/QgxN7atnIwDaqCSCKVWtxRKn0JfGqMMNfV3kv54pwYFEkxI+C3dWqIEpGfa6ESpuGVQRquJWNlxg5s1tJgoor9NxtdIZceqeuNhOMHBLXFPT+0cNaSVVarMhqpdtTuy70cs0hqOduhD+xheNYWJwFME3bf6FFpwbYyko4xItnfDorYQKhEAaDZJxZL+U6Oa1Tj9H+5/rBgfS/rHw/RpnpBQ45CKMo4TIaswJ8fKyvUCctGWa0cbUP2VYKx6FRK2CpHAWBOHavq+r8ZcMfWruCk1l6MuQehlRnw5rx5zgjzEWS4WPC29ksMJ36glSg8TeXw3YY3iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:123::10)
 by FRWPR10MB9225.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 15:05:27 +0000
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb]) by GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 15:05:27 +0000
Message-ID: <877fbd76-4b40-4f10-a623-63105c65005d@siemens.com>
Date: Thu, 18 Sep 2025 17:05:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][ PATCH] armhf: Enable audit syscalls
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, xenomai@lists.linux.dev,
 florian.bezdeka@siemens.com
References: <20250911121216.2585340-1-Quirin.Gylstorff@siemens.com>
 <8fe896da-950e-4f76-9386-accd3b87c1d5@siemens.com>
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
In-Reply-To: <8fe896da-950e-4f76-9386-accd3b87c1d5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:123::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0019:EE_|FRWPR10MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: bcac2459-94b6-43eb-3eaa-08ddf6c4ccd2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjlEbHNhZjJvK1FkNzdKNG1iczlvU2R2VHJUSGZ2V0tubStIZWVOaUJmK3Yr?=
 =?utf-8?B?RzVmQjlUQThWUzlaQ1VpVnB6WmxZRXhVNS8vODk1OHhzSmlQYVZINU91cDg0?=
 =?utf-8?B?VER5eW9XcDQvN3NTdmpNTU1RdG4zbWNpN0h0bngzczU0cHVGRHE0aWtTTGpw?=
 =?utf-8?B?cjE5bnJPODdLMEhVL3l3YTFOQmxuOTdLT3Awc1JycHlxZ00zSjh3TWMvRmRW?=
 =?utf-8?B?cE02TEZyaUFOVnFkQmYrUFNrQ2l2aHh3YVZZZFM5R0huMm52a1BIeTdpMXJP?=
 =?utf-8?B?c20vamtuM1BvSCt6ZkhJMGtkcHZOM2RoY3hjQWlaa2xkM01aS0toMXdraUZO?=
 =?utf-8?B?TTVlMENPbDhFSWdsc3IxT0c5QlVQTVJJVUNhUUtRZmQzdEJXSll5ak8xci9C?=
 =?utf-8?B?YS9JRUpRY210S0pOTC8vdXZFTjFlcGRwSTRuSlo3VU00Q1VMRWZvRlArUEtG?=
 =?utf-8?B?WWhxOHlQUDNnNVNDN1hhUVc0b20rVkhzeWRUQzRxL3IxT3c3WllDZGtML241?=
 =?utf-8?B?cHF2MGg0NldVNlloNmZFOTNHR3RGMlJMMzg5bVdDcS9hRkNXNzluT2pNZnNU?=
 =?utf-8?B?ZFhROXQvTmdhOTd1em9IMm1WOE45cmRRM29OeFNLeXdJVlMxdHpqWUU3NjZi?=
 =?utf-8?B?OHNyczhHVjI1TEcwQm1OamhtZDZsUFkwSkFyN2RvbTBRSVRKNkszM2pVYnh4?=
 =?utf-8?B?cXZTaWFDRlhoZHBoY0loMkxYSW9XczZyb05Qa0RQZXFURjU5MGg2bUwrK0Zt?=
 =?utf-8?B?Y095VSs5TkREMEl1L3FyRWV6dTcvdVZDRUd0VTVLWkI5T1Z5YWxueFBPMGlY?=
 =?utf-8?B?RVU1Vm5IQVF6d0Y1ZEx1WWE2V243bkFyT01OdVFESWVUcWtQTDBPdzNDMEYx?=
 =?utf-8?B?SGdFbDhIRVNmOG9SaXdTdUw0aUZXajV5MnVId09HT0ludjgwZERhKzVjMWZl?=
 =?utf-8?B?MXQ2TndIUW11N0s0aHpFV2JCS25URVdIdlpORWtMZVVPaWtaeFlZc2lJLzRL?=
 =?utf-8?B?b1VHUW5DWGN4RGZZRGRPUUJjKzNXZmFGZEhBYWJxUHA1VVo4RmdvL0JRYzFx?=
 =?utf-8?B?WGxOUDBsSlBsVVZDK3ZrZTZjd3lhbW9PRi81N3g0UnBnaUdTdE1jMGtBT0ZG?=
 =?utf-8?B?M09MQ2FqWC80Vk1ram5ES29JUGR2djUwS2Ryb3k3Ull6S3lyQ1RsQk1icENE?=
 =?utf-8?B?RWVQRnM4VzVLNmZKUzBtMUZOa3I2QklycWRieGUyQlBQL0NPUm04dWx0S3dR?=
 =?utf-8?B?VVhhUHVQZDUrSVRQVkMydUFuQXphYW1UMldwMUl4TmlQbUQ2blp0S25tOWd1?=
 =?utf-8?B?UG1MTnlGamJoTldNTFZOeGlqNlBicHlERUNaa2p4dGMxRitMaTJ5Z1VSVnNp?=
 =?utf-8?B?UncwSTF1Z0tqZXkyZitTYkdhVWRxem4yZk5nK1c1WG1uai9nem9DOHh4ZnBO?=
 =?utf-8?B?WHpJeC9JQXB5VFRhelJuYzcvYXNiSnlVMTNiWHp3b21IOXd6cjRBRjZwSzM1?=
 =?utf-8?B?SENRUDEwcmVlR3Uxa2pMSDEvMFFaZGR6SVkrMUFUZCsxd2txUlRWUXc1TUIz?=
 =?utf-8?B?Q1lnS0pqZEpZS1hNSDE5VDJrdVorUThQUHA5d1o2SWtiQmV6bC9ycXdiZFBC?=
 =?utf-8?B?K0JGWEhSWmkyejJHWlIra3FSSVFCMkhkNU1TVFA2czlJUDBtL1Rvc1FGNVhi?=
 =?utf-8?B?LzRtWU11WjNCV1RISUUvdnZhdWwzaVhEWGhXMUU3UkZiWHEvREVjOUpiYUNI?=
 =?utf-8?B?OW4vZ293YXVMbFU3QzI2RllGOVJYaGNhZlJ6ZVRBdFh1NHNVWGMyczJKc1JY?=
 =?utf-8?B?NVQ0aGxyZVUxK1Fuc1YvODczK3JVRHNNRXNYT3NLQVVIQlN2dzdIME44ck5N?=
 =?utf-8?B?dHJMK3JEeEVTT0hwZmpGRVF0Q09iTnhQYkdaMzg3NU81dEdKdW1mV0RGcGp5?=
 =?utf-8?Q?mhatHSg7DM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXhMU05JcTJBUUFGM0tEcU84SjNTY0tUZ3dDejZYR001blNUNzFia1FHcklw?=
 =?utf-8?B?M1htOUk5cXJXc1BmNnY2bkFCTXF3UXJQcjN3NXE4YkZTNmp5czIyMXpmYTJ0?=
 =?utf-8?B?VFpJalJGOENLbjFyVHJheW1ZZjJHNWkyQU9RMUZWQ0FvVWNaRHIydUJFc2Jm?=
 =?utf-8?B?c0JSNnNnbzEwZmtGdldvc2JNTzVuQndidjlQV0EzWStRYWFhcVBiMm40bWNh?=
 =?utf-8?B?TTgveGM3UEpRYTZ4am91c2UzV04xL2REWGhDUzR0cHVRbk1QV21Lak5IQnRX?=
 =?utf-8?B?UGppTjZtckVibVBTeGpWUzcrU1hlcDRGblFRZDExTEV5NkE1RjJEQUVrbEw2?=
 =?utf-8?B?ZGMvZ09KUS80MWlqMTVMdWJ0a3NrUElaT3N1ZWhkS21lTGRxNzBvTVV1ak9y?=
 =?utf-8?B?bXNLU1Z6WFAyeUJKZld2Q3FIamIwQ2ZaWXNNQjhLUGlDOGJnWlJQU2tnR1Nn?=
 =?utf-8?B?RnJTS0RUZ0ZRWmhtT3BsUEhLVCtNakJTb1R2aTBKeXhzOUdoVlZIYlJINEVI?=
 =?utf-8?B?dnpkZ0dvZU1wV3pnTUd2azAvKzRuMlQ4RVp2eWRQMTA1OXNtb2g0b1pHM1NL?=
 =?utf-8?B?SDlhd0kzczZFbWlpUjE0RnpCalBjVjk1ZWdpanVyaDlWOExyQnNnVkFTNzdV?=
 =?utf-8?B?ZmI0ZGZBdUI0SHE2VURrejhQcUp3K0pMbnh2ZHhUcGFxdDZBSTIwbnRxNXY2?=
 =?utf-8?B?RUlmcWlKYkRibndXSkxUMkZVaVVCYW5oRDhYRFd1NlF1MVZmbEd5c214a2ZS?=
 =?utf-8?B?KzRTUDl4ZWpCanJreURpNlBmWFVTMjlaQjJxR0FxS1plVGdXeE1XcWkrTWpw?=
 =?utf-8?B?V1Z1cWlMQ3VUNjg0ekxpemx1Y29JeVRkeDgvZCtDbmdzWEtKVHcwL3dXR21T?=
 =?utf-8?B?aitwS3BERDQxdlozdDNFbXRJUG1KNVNUSGN2SFJCM0pqT1Q2VjhsM3VPZkk1?=
 =?utf-8?B?YzlEZGQzRDBMRy9yZ2txc3l6YzhrZzcrS3BhS1Jvb0hBbThtQUxGbUlmOW1k?=
 =?utf-8?B?Y3orQnpqM0FWNDFrT0srcVdJbzJaRHpMRGVCbGVJSUVNM28rZUhHSVZQNGMx?=
 =?utf-8?B?b0JKd0RpWDNHbTh5UWNzelgwSjBvMm9lS1N3YUVza1p4Z2xCSlRMOG41VEY1?=
 =?utf-8?B?NTVwZzZ5TVFnbHJhb0l1cUdGVXQ5bkQrSm1TUEoxSzF6NHo5WDVZN3BmcUFM?=
 =?utf-8?B?cm5YeEd6WE5nc2F0am5jWXFaWnlYdjNjcVdxanNwanpPREl6Vm1XaVoyUEZo?=
 =?utf-8?B?eEN6azM4eUZPS0lRcytFc2xFbStxNUl4YmFYZ0tlWmtTUHF3dGtSNmhiaHVa?=
 =?utf-8?B?Zm5Yc09ySlFwNURyZURUWEFYNURMTEtmQ2drejNoQUNCck5MS01ndnRVUXZw?=
 =?utf-8?B?YXJLSzRGVEFiTFFEY1d3b2ZOcGdiNkgzV2VMaDY5Qlc5K21QT0RtMDkveko4?=
 =?utf-8?B?Q2ZEVDBMRkFFejAwTHFtKy9FQmdzamIwV0NaRHRuUGg0NVpMc1V2eHdmeW9u?=
 =?utf-8?B?WkZIS1BBcHdoTUZJQTdjTGQ0UDhHMjJwSFNLcklZMDJLRWp2OGQvVzZQRnJZ?=
 =?utf-8?B?OWk5OE0rVStjazhsV01KMUJDb1U2R0ljdEZrREd3Q292NThoTE9hckVuOWNi?=
 =?utf-8?B?S21UbW9aMWEvNDgyeDFDZUg3VW50a2tuOW5JcFlXUkxHc0hQNVI4Q24za015?=
 =?utf-8?B?MWsvSUg1VzN3bXFCenkzN2NyWDJOeHlzU3hNNExzUklOV2F6Y1cyRTVaRjNE?=
 =?utf-8?B?UGVkNWlvRDUrVnFhaDZVUnFWOVJEOXBBWSttVzNSb0Z2YktQRDNkbmhUcFNU?=
 =?utf-8?B?dGoxZHhkSGFMaDcwWVVGS3R4andSSXRwVU1vUjNRL2JPSGdnNUZNMXFhMEt0?=
 =?utf-8?B?T29RNmgxdjd5VUJPOHlBQ0M3Tis1UXVvelBKYUhnSzhVM1IrVzBYeDlEU1R0?=
 =?utf-8?B?em1Gb1BHSDNSQ0lOb2RkaUxFSzhHYklSbmhBcy9mYXJ1UnJDSE9oL09rVnpX?=
 =?utf-8?B?QS9SZTN0QytjclgyZW1FLzZEd2Rrb3FIS1QxQWJPaStKdGxtRlV2U3NWSkZI?=
 =?utf-8?B?MUUzc0pwR0FzQ285OForWlpVTzczSyt5WHRoakp4dWRwREY3Z1hSdTRCcFJC?=
 =?utf-8?B?ajZ5bXYyZDZadFhGcGVnOGdmTGlzeHlkckpRb1BFbzRCamI2S2RKODJjWHhz?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcac2459-94b6-43eb-3eaa-08ddf6c4ccd2
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:05:26.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nseEIDwVkJaj+qor8LaSP+08FakFkEmVq8CPM7fqcIwGVF0cmpIgiduY/KO3JAY6rbuMtfjSeB4K0yPvKLGSDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9225

On 12.09.25 07:35, Jan Kiszka wrote:
> On 11.09.25 14:11, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes the following error during the execution of the LAVA
>> testsuites:
>> [[0;1;31mFAILED[0m] Failed to start [0;1;39mauditd.ser…e[0m - Security Auditing Service.
>> See 'systemctl status auditd.service' for details
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  recipes-kernel/linux/files/armhf_defconfig | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
>> index dee6f5e..7f370b9 100644
>> --- a/recipes-kernel/linux/files/armhf_defconfig
>> +++ b/recipes-kernel/linux/files/armhf_defconfig
>> @@ -56,8 +56,11 @@ CONFIG_SYSVIPC_SYSCTL=y
>>  CONFIG_CROSS_MEMORY_ATTACH=y
>>  CONFIG_FHANDLE=y
>>  # CONFIG_USELIB is not set
>> -# CONFIG_AUDIT is not set
>> +CONFIG_AUDIT=y
>>  CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>> +CONFIG_AUDITSYSCALL=y
>> +CONFIG_AUDIT_WATCH=y
>> +CONFIG_AUDIT_TREE=y
>>  
>>  #
>>  # IRQ subsystem
> 
> Thanks, applied.
> 

Currently held back as we first need an update of 5.15 to fix a build
issued that this triggers.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
