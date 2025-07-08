Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF732E0B45
	for <xenomai@lists.linux.dev>; Tue,  8 Jul 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001127; cv=fail; b=CyxuMj0vokLbFRM5jncHy+dFAbO3rqKyVNnH0xvFYow2ndKg7N9JXGDTN5UenyT/tahj7Fj82xj3mZE4tMR6dC02VLDd6AaWHo2o0imhzC/cIVOyjxiBMsuELo7ryQQK0QFofPYCxdkWKa3y+aoOgas/dHLtw58hfj9yWidjQLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001127; c=relaxed/simple;
	bh=8gnUJQ2rED1jmSgK5PQvWAG0oQ/E9/qoA4yPE40ahBM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=at92PkeyGfEj6+LxsiE39oNt8sMwFipf06reCIBAyQX05lYR86E5ds4ol0TCa8yjntgwwu2s6qRK6u4m1Rsbk4pCT+TSSmGKUm6M6dZdAmaHDSG+Opue+1X5QZL1ubxU1ZHnXIQPmQ7BojCGFiUDm1f+ijrfEsjr/D/zOISINnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nzcaZf5O; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nzcaZf5O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSrZhtOTYcV7f3uT8j1TVYqpV9bO9KVdkQBFR06Km3xQTtlY0Y6OZS86WE6z04/KrgkirDCtwMmJGet4B9p44418AdI6V2CQYN0+nS+Oc2tcNqzUBlEYjh8J8i5JWkVDWNCKbc5zQbdNNasK6V2YlybEFOd0c8hmB1K/wqSH29mViWOZfeUIfDcJq2xyzaqB9y4Vuex8Ldvbdl+U1F81xLdBnET2Bet4MrrVnJ8v4Z19Q7cbMKVO/dfaIMgClX0lI9MDHewKc+2j1vu0AzM24tboPxvITo1qIvhQ/SOdTAsT8QtcL4nyUrkR6f4ib3J4mnWnuXMni9zz+0Vwzbv1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6BLBv5iQAihn4OD6ISaPcqBnCk+LYyEryFQ7vx64Q4=;
 b=bRMHxFDfJW/59szFF3XNUKRaroSsuaUUX5WKHVNLEpINziyhBKCIiyTTOrcuAqzaMGQHhcD95HWC5BXIK3pFkyFREBwWaly9wb7Ii22gd7a2rBwxsMVougGLU+EjzuCjIAaYvU0cbgK4JnUotOtOvxNHOj3+3U4w9HBhdVTJrjHgRgaie+ybN2vnorvyCOjYvwfsOjA12hjrrSfGp5pR2mLg9Sme00jVw8Bce7ao822ICB8y+GEy+/QhugSTSk5uUyrUrE1Ag0kzZIXJ4bsb6xJ8jLsd8U5gIDQTtcAVhl7KZUofLthCd/88UxTlhYn3c1VsTsmXEnlJso6hHyaSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6BLBv5iQAihn4OD6ISaPcqBnCk+LYyEryFQ7vx64Q4=;
 b=nzcaZf5OaezFHYR0Ij2E8b6ZPCZA9jBfVKJmbyBGdNoP0DoJvZX32az2CaavoqfloobdWRG3y2UStCgpaCVDMpl0EY7CvOfdlk+TQXFB7qM6OjPeBKC1x2L6zikdwSed51dET7KI+jyy5YbmzYqJwchoMdjHcJZPRCCbFJHgtEQ3fBwwFnRB+40Cdc7AGG18xoQ63FMpNwL15S7knbcLhssg0Sow3daLoTr1kA/Ta+9QSch+S0OkY0SctKchqTXU/4Co6G2KuoHwcPAhNxro+dThdOI/J1iIq8XElxspR7qqMMMsGP5T2qZgMins3hPO9lGIeLNgUmE/IdH9vaWPHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 18:58:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 18:58:41 +0000
Message-ID: <39e400d7-9a07-4bcb-a4e7-b2b5c365d9ce@siemens.com>
Date: Tue, 8 Jul 2025 20:58:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Clarification of 'unrestricted' context tag
To: Sebastian von Ohr <vonohr@smaract.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <VI1P194MB21935AEB04E94F01CDD24FDBCC4FA@VI1P194MB2193.EURP194.PROD.OUTLOOK.COM>
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
In-Reply-To: <VI1P194MB21935AEB04E94F01CDD24FDBCC4FA@VI1P194MB2193.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a9c5a7-825a-4bf8-0976-08ddbe51749d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0N6eTJHeGFWWFZuNW10ZGNIeldMRy9hUTdsQlpCaFNlaUsza1p4eFEwQXA0?=
 =?utf-8?B?VG05Y0huNHpFRWVKRVFzYjlsRndkcXpRSHNMTXZPeEVrOFNMZjRDdEhIQUdl?=
 =?utf-8?B?Um1yYWtEbVR6TXZ2NW03RG5TOTA3UkZ2RFNHSjZxb0VLUFhLclVnemRlVUJJ?=
 =?utf-8?B?QVB4UGFCNkIzdjlPTnQyTmYrbjU0OVpsQkYvRDFqcE9BOE0zN0JOTlBxZGZh?=
 =?utf-8?B?LzJ6Z1RsYUpMWWxGejR1ZmNXdDNSUmM0ZGJLSCtBVEdSbkMvL2pqanRDVlFC?=
 =?utf-8?B?dkw4TUd2K2I0Ty9kZUVyTzdnQkdxeXhveVZrSnR6ZDVYQUpCSStYZjlDQmtU?=
 =?utf-8?B?RmZzSDRqWGVTK2xna3IxQXFkWTVWVURFR2ttKzZFdEVHczJtMmhCRXkyWko3?=
 =?utf-8?B?QmRRbVk2TDhlMFg4ZlE4MTZ6M1A4MjYyazJTYmw2dWJPckNpZ3FhZ1Fud0Vn?=
 =?utf-8?B?QzFlTlRSY3VVelpDSUdjeGtIRmEzSENBR3ZnNWViN1RkUWZYUzhVU0dGaFht?=
 =?utf-8?B?b0NTRndhODh4THdBY3NjRGx0U0o3RVZGSm1NNzFhWUQvakFaVHd0a2cvT012?=
 =?utf-8?B?cFVHVmdLSG85OUZFK0M2MDR6N3dBbzVsS3hyR05HYWFsY0pYWWhHMHVqckFK?=
 =?utf-8?B?Q1RJWE5SS1FJcjd6enAwdENwRW55OU9DaXV4RVdhR21Cd2FHcEpKSk9RZVZs?=
 =?utf-8?B?c2JNZDE0TStINVBlOWNlaWpTcUNjWlkzRzQzUmZtTzBSUlBCY2lNcU5hRVZT?=
 =?utf-8?B?bC92aEZDQ1d1RlIxR1JlRWJGWHhqR3g0ZWxRMkQ2Tm01NGRyNmxZSktwc053?=
 =?utf-8?B?US9nSWpucTNWR3l6SDFiRWlnRGljNVRmRm9pS0ZyKzI1UGlzeldRdSt5T1Q3?=
 =?utf-8?B?MG02MFlwbnQvVm0zZS9SYm10eEtBdnR2VHZ3V21vQ0M3am9BNFd2ekpVMVlQ?=
 =?utf-8?B?QnBlTWplRVhCYytpTXgraUdobjZkVU4yK2NuU1ZRcmowclVjM0QvdmdNeDV6?=
 =?utf-8?B?NnJWYmplVENyZnk3Z2VwcG8xS1FxMzFLUnlyeEsvTG9qZFAwN0ZOaE5zN252?=
 =?utf-8?B?WDFlMC9zRzRLSEhJSDQ5aXpEUTFQcXdFVStyZnJoeEJTRlBjWU1BWlFqd0NB?=
 =?utf-8?B?dWlpcnJENWs5UDMzRkZaK2I2ZWFTU0dCRTlnd2RpdTVBZUo4QlArTmdvcEwr?=
 =?utf-8?B?Uk1OV25XMUE5cXZUNkt4K0tCMUtlTnMrRWkxVGNjV0RLbXd6UmkvSVhPNlV6?=
 =?utf-8?B?c2NmRGQzek5VZWZLbE5LVWNJWVhkL3dZUU1YTXRMdnJlQjc5WVBRbWpFTXk5?=
 =?utf-8?B?NkZUUWRXM2hpL1R5WTB1eFJEK0NFZ085RkNqdk1CYllNSWRJRTJiQ0MzNjkr?=
 =?utf-8?B?S3pCUjg5MmxibEpyWHNYN3pLMnNKWE9hWTNxd3ZzZlU2REZlWWQ4OWVoZWdH?=
 =?utf-8?B?cU1RT0lLbzR1NDVvMmV6YWhtalczQzlPQ0NlVW1aSGs5Ymx4VnVsb0ZFalpj?=
 =?utf-8?B?NlRWUld0NE5XM21CenpPQUI5NEdleWJVQURIYmN2VFN3eHlGRDZKZTZFZGpE?=
 =?utf-8?B?U1kwRkNMcGw4cEt2VVZaWmpRUmtjd2lOc1R0MjdUY3puYTJxU0ZuWWFLdHM2?=
 =?utf-8?B?YVE4WktaK1VKYzhja2gwNGNycFYzK3MrV3dEWjczay8vQy9UYXpuVlE5UWNL?=
 =?utf-8?B?K3ZMTkhrQmpGbCtEUGk5QVRYdVRyZUtHUkQxYnRMbENkMk1QQ2dBOWwxZ2ww?=
 =?utf-8?B?K3IrYmhJZ0NVSmk4c1cwMHJ5dk5qTTVobklRMk50bVJKemJLT2llZFJWKzk3?=
 =?utf-8?B?Ky91Mi9KOWpOTnlHMUhrc3J2bWdPUldmRVNVMHBjMjVRRXZWNDRJV2plcFd4?=
 =?utf-8?B?ZG52eVJyRTUvcGVhWGs1cWVDZ0N3akc1SG84K3liK2dGMWVnTDcya2xRd2xm?=
 =?utf-8?Q?pR9e3Cu5s4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajRWdVZnQXB1UnVhbkZObVJ0UzFIYzdCNU1XY0pZcWEySzhwblFzVmRNVktC?=
 =?utf-8?B?K281UVB2cGFCYTR2UzNyb1Mva3hoQldyZnJDRUhTcXhENjJCV0lKZHlPL0dG?=
 =?utf-8?B?TGdnazBRWjh0QVFDb20vdGlTQ1ZhS0hxQ2NXMU13cGVkU2lEVzhlKzhaQTJO?=
 =?utf-8?B?ajlmYkZyODdVQ2FuYTBiUFlBd2Q3dUZ4NmNsVE9WSVA5LzRNM01oazJCbFFK?=
 =?utf-8?B?QjAxcW1TcW1uZ29nTE94NjZWd1VZQkw0elVPVHVoU2MzRTBjNmprK2lwT09J?=
 =?utf-8?B?RFlZZUxuTjBkOWk5dmFGTXhTMzdoZDJhdzJuMldUeE9PTDJISTVlMDBCM1g2?=
 =?utf-8?B?akZHQkVsWkhrMHJveDJRQnd2aWtmdUdESG93WGsxS0hneGk5bkp3ZTdSYmpn?=
 =?utf-8?B?YjEwYnJESUVwb2NxL21sdkxCUGtVTUhpaWZrblVVaGN1SFNCTmJBakVOWkhN?=
 =?utf-8?B?ZFZ1elRtRnRyNVYydkpjZ3hDT0ZSNHd6Y21kQTA5aDE4RmJDK3RLMUVncWE1?=
 =?utf-8?B?L1hxdU9nYmhPZVc2ZUdGYnk1Skd4Z0lHRFh2REtzaWlYYVFCOC9HYkpSQS8v?=
 =?utf-8?B?UGVrVy9iQjFDNUxuYjU4aUNPTlV2RXRRZDY4MTlVNmNXd3B4aFlndlFXQ3B4?=
 =?utf-8?B?WEFxc3A4SUJZODV4NXJDOXdWeGVBMEsvTnBWTWdta2ovRUYwU3lGZ1hTRkMz?=
 =?utf-8?B?RXMyQ0JBK2ZtSHkrYytsSlNJTHZFQmxBQjZlWEJFcGVJWmxjN0ZldXZwbTZh?=
 =?utf-8?B?VUl2TSt3Q3BCS2dPczhqcVdUMCtRYm1GU1dRRlBmMWpncnRrNVZFMm9LQ0gy?=
 =?utf-8?B?d0dycGpRaHRSWmRKSHdDMUtUa3FuZTRvSWF0Q2tlTUxKalZleXIyMnlMWWhk?=
 =?utf-8?B?ZFZNUlFOM3BuOFdyd2U4Tm1WcDl3aHpsYy90Y0hTRW54cDF5cEVVSTRMeVFk?=
 =?utf-8?B?c2tJYlRONitBNDZHZUZGOU9SMTFHVC93OW9LM3g0Um15eW5FL21LNmpBTEVT?=
 =?utf-8?B?a0FGN3JhQXJuZzJsd1lUbE1xdW0ycmczUUhrRi9DTVdSbVVsUDVhcTNCbnR1?=
 =?utf-8?B?YzA4SXpmeG4zRXFyRjh3b21vWXBON0xuTjYzQ3pWd3dJTUdwcFkvVC82U1Ft?=
 =?utf-8?B?b0tKYWJHeGZmZlNMakxWcGdTQTM5a05YM3JCKzRaZjUxTEgwTk5kQjRVMklP?=
 =?utf-8?B?ZHBmNU1FUUlUSnh2THJTS3B0QldBdnUrdUMvTTVUY3VCbHNEbW1NYmZxSGxS?=
 =?utf-8?B?dXJNK29yOXBzc1lVRUlPQTNWVHc5TXRhNVVuaU1NeHdRV2h4WHZuRC9qcWVh?=
 =?utf-8?B?ZzdGZGdyazBvYUg5bXoyaFJPMitwbWxDOHE5RnRwUDFjc21TOGdYUmplU2VN?=
 =?utf-8?B?aVJFK1NmbUNLYlhMMGtMRGR2c3Y4dU8xeGh4amNZTkJwZ2NXTjk0NHZkeXU2?=
 =?utf-8?B?bUc0UU1XMzJmY2hFWU1mWEovQ29qbTM4OWFwKzIxM2tvTnExOXlWbi9jb1FD?=
 =?utf-8?B?YVJCQ1BCRXl3MjJOa28rODBqeC9BdHBBUVY4dVlrb3N6clYvazAwSTNweUp2?=
 =?utf-8?B?dmt1aXNQWk9iUTVaRVlIYmlUaUl1WGcxekNrMXlyUldYMy94ZVhHU01nOVIy?=
 =?utf-8?B?VDlHQmsvMStaUEIxWk9wVFExZmVHRjIwL0F5cGRZWHYzcEJWRnhKNlVMZkth?=
 =?utf-8?B?a0JYdms0VU9rT2lrMzAyNlc2VzJLNTM1ZGVFTmsvZGJncFpWeTFiWmxYVlNF?=
 =?utf-8?B?OWRscTgxY2hwbUczelN5NEpwYXk0NGhqMUZURmZLZS9ocSsraUtuZ0VnYVMz?=
 =?utf-8?B?bS9DWXp4ZWNPUUl4djlJUXc1TlR1bkM3aTRlR1o0ZC9aNlRBVmVVcWIwOHor?=
 =?utf-8?B?MVRDTW5zNUpQM0cvd1cyWFVodUdsajhKMDM2aW4zdmRIMzhPS252a2tmZzVX?=
 =?utf-8?B?d213eVQxelpVV3RET1h2RFhyL2EyVUYvMC9vMXZ0dHM0MUhaR0RTZ1NsNGJI?=
 =?utf-8?B?amFTVzR6Tm5JUWVEeGdlNWVVYXVNUkNlZG5TcEZVRjZQWjArdWFUT3RyZjIx?=
 =?utf-8?B?cjh4dVZ0enZiNVVGekJhZDBnbVJZVk82OG5QYTFJYTJxQmVGSERhSm4wa2JN?=
 =?utf-8?B?K05OYnl6cWpFOFMweGJFM2dZZnNjL2wvcWZXcy9wM2VkOFdEYTFBNCthTk9C?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a9c5a7-825a-4bf8-0976-08ddbe51749d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 18:58:41.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSe1qk1Fw8YYol/6PJHwojz9CXKAFHQo9qv8DYQfEERkCxSmxn7IEpCHHuLEuhCy1ceaRSkgogsl2LPoGNT4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8660

On 07.07.25 16:47, Sebastian von Ohr wrote:
> I'm developing an application with the Alchemy skin (without the POSIX skin). The documentation nicely lists tags for each function under which context the function may be called. E.g., the message queue services lists several functions (rt_queue_alloc, rt_queue_send, ...) with the tag 'unrestricted'. According to the list of context tags 'unrestricted' means:
> 	May be called from any context previously described
> The previously described contexts include 'pthread-only', so I expect the functions tagged with 'unrestricted' can be called from regular POSIX threads, which have not been shadowed.
> 
> In practice however these functions do not seem to work when called from a regular POSIX thread. See the following minimal example:
> 
> #include <alchemy/queue.h>
> 
> #include <iostream>
> #include <thread>
> #include <cstring>
> 
> using namespace std;
> 
> int main() {
>     RT_QUEUE queue;
>     int res = rt_queue_create(&queue, "test_queue", 1024, Q_UNLIMITED, Q_FIFO);
>     if(res < 0) {
>         cout << "Failed to create queue: " << strerror(-res) << endl;
>         return EXIT_FAILURE;
>     }
> 
>     std::thread t{[&] {
>         void* buffer = rt_queue_alloc(&queue, sizeof(int));
>         if(!buffer)
>             cout << "Failed to allocate buffer" << endl;
>     }};
>     t.join();
> }
> 
> When compiled with
> 	$CXX $(xeno-config --alchemy --cflags) $(xeno-config --alchemy --ldflags) alloc.cpp
> the allocation in the newly created thread fails, while it is successful when moved outside the main thread. The main thread is of course turned into a Xenomai thread during initialization. Similar rt_queue_send fails with -EINVAL. Also, rt_queue_read with TM_NONBLOCK fails with -EINVAL. Is this supposed to work, or is it my misunderstanding of the documentation?
> 
> I'm running Xenomai v3.3.1 with the Linux Dovetail 6.1.123 kernel.
> 

We likely have several inconsistencies here in the annotations. The
usage of plain "unrestricted" should be limited to calls that take no
locks and can even be called from IRQ handlers (which naturally excludes
userspace library calls).

In case of rt_queue_alloc, the annotation already contradicts itself:
"unrestricted", but then "switch-primary". A normal Linux task cannot
switch to primary. rt_queue_alloc should be annotated like
rt_queue_create: xthread-only, mode-unrestricted, switch-secondary. Same
for rt_queue_send. And I bet there are more.

Would be great if someone could sit down an at least walk through all
the userspace "unrestricted" tags, fixing what is obviously wrong there
or asking for confirmation where unsure.

Thanks for reporting in any case!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
