Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC92C21E6
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601113; cv=fail; b=Fxr2e6yQbEWn9x1cXmUppTfDR/yY4soA7y5VV21H6KgitQLbTTYdZskY6CYHlxEBCYwpF2g3opwYw083PmqTmBdI1DeVOMUyels7APYmmWYmwqdraSpJoQL56oaBBPMKLhXen9iXSlX3M6TVG9pUpvfgllnzXaGej6976rw+3hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601113; c=relaxed/simple;
	bh=Z3xj45wPSPhseqgksaxB1KP5aoESk9parTvybUT+c6Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PGeb9fMHXrZSe0Y/IlntSKXmrqrQj2uY15eoR+MbGu5C5ZsE1CLOW6bDICgLw/IOH8KWxZLNx6AYY23Or2e5aT7VgzNUNzdL246V80ahY6BEMfkk5Fqq/P33zA9Qd552fAcRal3eG850RKCDfF7k4b60VKVxAYcdtuBZ09wQCh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dQk74uTr; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dQk74uTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErFoRD5Aqb92UK2R+f7SbYYwM1hbGKeoQOgfWGqMPxaK50OIYJTv1wGWJpQBwTL2LE3IkclS6t25igWkI6niWKqZNvdSBDh0ltHoTewKoDOS2JgYLORY53v4h1Dk95eKfI81qyPLyqrs4DsO8PMI3rKCLkh/W0ca7Tf4oC0PpZozSKo2jHHkj4TGPuG2H1PNhEb1iz4yv/I/c9rHhkcU/oKqSKpwr0tA1sDZxR6RzGgltA1BOCUSD1Sz+h86UQ7pLzAH/iI4G6yx4Ui0D7b9GK+rYIYlC1JEiblbMOxYGfI3IU8dx5kxLXHvWw7aBoAnoki3sOALJRKj8+dNRcKYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NTFvNTXn1QB3FfswBQo/HgNkg14oSQ9FIs+KOJCU14=;
 b=vTjCxHqDy4HXjfMS2FQAhfeqz8yMvHOSNAL9egbW481Wnq38PkhWNEAkTgJChsvN94dKbQPlThqoNn9f7Cy74/Bn8zapcUE/G+tidVG6BO5XXrE3yViNxl1oMDLd76979vc7kjfwqgHPCs3/d8iGX1HY7d198+A3Gp4YcR1TeJ3ubpWWQR0KlLKcEY538FYEOeLKYBTdP4rf7PzzzocCRrnGRtZb01bW4NomlhpylWT1R7hRGPZlK/BcApHgEiGxjxcZ6bqyjovhcvnqsTFA8KlRyRxV96UXXwCr57SF9BK0eJlCPZa86s+6NwPfpXZ33rq0F7Lm0mNSocRc0a/0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NTFvNTXn1QB3FfswBQo/HgNkg14oSQ9FIs+KOJCU14=;
 b=dQk74uTrFDBc48YYM8BNWif84J2mt4sqYRZ+Gp7wHsNSgyNZtlr5xPidIDQ7lEvAyS/Cx3EwD8WUqzIoZ0CPYRlMzds9bUermBg+HCtrx7YB2P5CpVDEjtEhHDiqfqsX30MX5IoXjO1NYw2NUMTmC2wjkI2X8DP/ttx9bEfgIi00gDIAEvV5Fx3svXAKieqbG/NU6kA59OyZzVORy/mehtG28zFKROA2qTLlt/PVmiggNZ0hnCUb9mR+gjahXU5V0M5PmUje0JIdOWlqlQCZaERdrahI+VR1etr+TbLjMZgZN9dl+MjBuoyahLc0xVp9hg7u1qYW96ftPbAFmdNQ3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 15:25:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 15:25:08 +0000
Message-ID: <918f3284-3b30-40a5-9db5-19222ab74f8c@siemens.com>
Date: Fri, 20 Feb 2026 16:25:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cobalt/rtdm: Prepare for new signature of
 mm_get_unmapped_area() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
 <20260220-wip-flo-prepare-for-6-19-v2-2-222effb01976@siemens.com>
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
In-Reply-To: <20260220-wip-flo-prepare-for-6-19-v2-2-222effb01976@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: fa650940-19b8-40fc-03e0-08de70943b3d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEpPT1BxQXlGdThXMmc5U1hsQUJ3UDd4cFY5Z2xheS9JR1NKN3ZhbEFLc2xT?=
 =?utf-8?B?Q0JyNWwyS25TR1gzdHZkcTEvYWUxc2dXT1U0Qms4dkhDck03YnpKamk5b1Zm?=
 =?utf-8?B?d25WbkRUVTdEdUNlTkR1UHZmKzVRU2RWWGhIbjBnaWtBTytBUGlPV25MNnBL?=
 =?utf-8?B?N2VzUnNuK0kzdTRNS05SS3lXUmpQUFBvVDNiNUswVklJMk5rbTlpSjZOcEFU?=
 =?utf-8?B?TUh3NExOSVpYQ24zS0l2WVA1ckRkNFc5dTUwZVFkZmJRRnloT2VEcmtoaytv?=
 =?utf-8?B?MXhwRmd0TjM5Y1hRazAycnpZTVd6SEtsOGRXa2c2dW9BZ0QvU0pjYkRtaVhu?=
 =?utf-8?B?SnJRd0lDTlpLRXB5aUEvalYrRzdtZkdSN25Rdm9mT3ZHclkxYWllOEpKZzB5?=
 =?utf-8?B?bGdFTXdhWnkrdkFFcDdpR3JwNjJSUTU5SG56dmV5ajFnNHJkUmpoRmNYa2F6?=
 =?utf-8?B?dWVLSWwvZkVraXA1dGdyTVYzRXlHRWZZU0lrdGdqL1B6M1RZaUFOa3hXdmNP?=
 =?utf-8?B?V2dzM3pFcEtoWlY0QUtnbEhxSmx5U3psN3ZKTmYrLzB4SmFuYlVIZDdoY2pl?=
 =?utf-8?B?MXlLdUJHaGNoczcwSnBqZDNxWGhrVjNrbGxRMmc2MkY4d2ljMmc1UjBCZDJs?=
 =?utf-8?B?MUxmZVZ1c0kvOGRjek5lNHJ3S0IweHNHa3V1U3htazZRUkd6T1hLVEdyVEpw?=
 =?utf-8?B?ZTM0cWxKeHZhVGYrZk8vMlNTYVNmU0Y0eHplN25IZWM5aVNNTFZyVm4rbnMv?=
 =?utf-8?B?QTA5am1UOFdzMUxGVUsrM3RBTDVRaENadlpLWUhrNlp0QUNLYlVZRHhJeS9B?=
 =?utf-8?B?bUwvL1hKSEM5M0xlV1hPVHZzMmdlc0xkd3pGMkZkRnhxYzI4Kzc5ek1BSmZS?=
 =?utf-8?B?anBJZTZLcWpFNmJnMS9adFB4aFZMMlQ0NXp4TUR1VnlpMkpMSWRJeUw1ZE1w?=
 =?utf-8?B?NXhiMVExU3J6RDUxTHc2a016bElqaExtYmNtRTZqR2RnaUdFQklmMmlIK2Ra?=
 =?utf-8?B?WFcyK1NvbFlCZFdpblJtbDBMcW9WTkEzcHU2VUxzYzkwUzlFTmRkVkgzcEJi?=
 =?utf-8?B?SEJDaTV5dmQ1enV5NFFvUkFBY2U0dzVMWDdOUVgxa1NDajc4Vm9ic2w3T0Mw?=
 =?utf-8?B?NTI2bEZHZTRNcTV3K1F5UkhnU0xqWVp4TVdBdmI2RTd4allwMEs1TElFU2dn?=
 =?utf-8?B?Z2ZpOTQ3T0tLMmNUS1EyRGYxRUFLVWhSRnNXdW9IMXcydzcwL3dwUVhiUkMz?=
 =?utf-8?B?aTJzS0V4MXgwVWR5Nk9WZ29vTTV6c3BiampwU3JidFlFTVFlWFRlZ1hNdEdD?=
 =?utf-8?B?ZU5hUDFJWHdUQjArQktrbU1hakJTeURpOWNtZlplNWxORXZZTVpHOTFmTThi?=
 =?utf-8?B?ejh4VjV4NUFjWkZyazZNbm9pRUJRSGF1U1BoWEttRVozQjdUSEJBb3FjMktT?=
 =?utf-8?B?QVlwVWw0WC8zWGJJbHBOM0dzckVQSDhPcFVWbUUrUkQ4QTNCdCtqc2cyTWNw?=
 =?utf-8?B?d1p0dC9peEhOSXZ6bktHaTM1MXYzM3M2UnZMbFVrSGxZWlR5VGpaZEhjVkYy?=
 =?utf-8?B?RkRib0pibUExODUreUk4dnBWZkNNQUFVQmdLTzFmTURjdlJCTkxPbTl3UUUy?=
 =?utf-8?B?VmxOWC9UZi9wa3R4T2QwMGN3S1c4K1hVZXRrMTgyODd6c2RvZVdhV1lIc3FQ?=
 =?utf-8?B?S0ozZnpLem9JcXpHN0NaTVI1d3Iyek9oMjEzbi8zaTJqamZnaDZleU1GSmpj?=
 =?utf-8?B?UXdyWGdxenh2UjYwWHZKeFlkcHlucWVZU0pqb2NUUnQ3T3ZFZHcyanVoQmRQ?=
 =?utf-8?B?cGNUaG9XNzZCeDBiTXp3eDlTcmJFM0Y2Vk5ObUk3L1NyMC9Pa2JHY3Bxcnh2?=
 =?utf-8?B?aGRYeC9sUXQ5Tnh0dTJGYzNDRysvZEdReXdsSXRqNXpKZ0MyMFllZ2xGNFRJ?=
 =?utf-8?B?V3hQZmNVcUJidUVwdVBuTGppUnJ5dEhKTVl3TWtYTmhHTUNqQU1uN1pYQzFx?=
 =?utf-8?B?QzJLVFhGSkpBaWJ0cHhkbDN0ZlcwM05KSi8zeVZUbnhPcGVpa1BDcmdvLzU0?=
 =?utf-8?B?WUpGaWdsMFZrMGlzVlI5dllrdHBuWUMwUlVqQ0U3YXl5OFJrOGhyRjFIMnZU?=
 =?utf-8?Q?sqG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SytLajU2bTYrSVArSVc4L0wzSmhlZnFBcy9BdEpyVnUvYVhER0Q4aVlOWWF1?=
 =?utf-8?B?YmZCNXllcDR5Z0dCQldpWGZreU01cE5RdCtoZnZxdUxxdHkrL2NXK2JFRTU1?=
 =?utf-8?B?RVN3OHErbkRaaFdYckx0L0lIc1lkYnlpQWRXdW1PdE8wb0lnNFViTlFldzR4?=
 =?utf-8?B?L0xXSFdtMTJERDlGUEVVbVJSNWIzb1g1QVczbUpqUnI3ME9jOXpKUW9kcjJp?=
 =?utf-8?B?ZVZWaUMxUUs2azRBUjk0amxNUjVXOW1NNWJMbXg0Q0xLUldKOVNuRkw5eEJB?=
 =?utf-8?B?SkY0end2OWhWNkVGeHErQUU5N1NoUUU2Y3ltandnMjhnZG5UQVRJNUVuVlVi?=
 =?utf-8?B?TTNuNUx6TXNoaVZ4dkgxcFFkWTR1T0Z1MWJEOGtNdWdhZUwrcEJmSVRtSUFk?=
 =?utf-8?B?Ynd1enh6bkhRUzJEZHA2YUxQYWdFR1U0ZEY0cmN1L2Vnb012RTJQZlpoWFNt?=
 =?utf-8?B?REpNMTNwSGhCNVVOR29rc2lyZnJnRDZrR293RnVwSFdsdFRXaVIyLzFzZDA5?=
 =?utf-8?B?N1RmdVNGampnS3AvdXBuOGJRY2hoY3U0clp6R25wc2hTcFFjZzdDeC9pdjZ6?=
 =?utf-8?B?YlkxeWt4QkV0NHZMTjBkTWpPZTdWZUtZSVNodnVrOWJ5UUFZK0hUaGdlV2ti?=
 =?utf-8?B?UEtLMWRkZndSNEZibXJVY1lZSUY3amVUS2NsZnhyR0hFUzhjcEhZcnJDdDB5?=
 =?utf-8?B?UUh0QmpIZllGOEhKMElIbUtEU1lzUkhyeTdPZitUbzc1MUVvc0JkQWU2YSto?=
 =?utf-8?B?dzNnNDBBK2N4bTdrS1B2Unc1STVPOW0zRzQrYi91U3FGUEx3MFQ2TVoyeWxV?=
 =?utf-8?B?b2s2Ri9yTW1iNlBselRBaVdBZkhrckQ0UmM5NFZLWlVEakF6V3pwS2J6Z1RN?=
 =?utf-8?B?QytEYjRjRlFVMVpZTE5YaGIwOGRFZldWZExHN3E3dXVUTmRQTU5YOWVyWGQw?=
 =?utf-8?B?Q1FOeFBCTXZRcmFFSlB4Qzhvdm53UnVKa2Q1ZlBFRTFnK2JIOHdjY0VjQWsr?=
 =?utf-8?B?YWVzaUlXMVdBQ0NwMmlsRE9YNXpta0xZdXRKRnJPOGJxYmZ4RDdUVmZlZGNo?=
 =?utf-8?B?eVk4SGJ4cHFYSUk3cWRMVjNBekV6QkJ2QkFSd1NPQXZ5bzFOMkJleUpadSti?=
 =?utf-8?B?QUdnTDhjRXNxSmo5TDdsei9WeXo3cDdSeEt4N2k1U25PN0hobVJBVUVuR242?=
 =?utf-8?B?QWJONmdCZUlITHhrVFdqaWJ1OERYcWZNWVZGSXl0b21EcWVMR1lla1YxNnV0?=
 =?utf-8?B?VmYzQndjQzVYbUZOcmdhb2VzMVkrclZXUTdMd2FZQ0hjVnp3OG82WEtTcDZn?=
 =?utf-8?B?dlBlTHRRS1d1VGtHMkpFbm1RNThzTmpENXp4dFBpSlh0cGo0aDdDZWVLV0pt?=
 =?utf-8?B?MHkvOUJJRzArdDBQWStJQ2RMMVJTMDZiUTRub1FmZUJPWnUvL1VydXNPSFg5?=
 =?utf-8?B?bzdaYnlIemszSERFbXZQQmIzQklrUzhHUkoyZHMwa3pzK1pEWFFhVjBONE9v?=
 =?utf-8?B?Z0plYzduMUpsRHE1TEtFZnRFRjBqdFdiZmVKeGxOT21pQWYzaHp5ek1Pa3Az?=
 =?utf-8?B?UVJjVDRKVmF6R2RKUFNBRU1zem1HK2NmbllqUTBWRDBpZ3JXanljc1g3cHpI?=
 =?utf-8?B?aEZBNzdwSmsvMnRXUDdFQWs5SkZ6SVdIYTMvQWg5Tnh6TXVGckNObEdaNWxo?=
 =?utf-8?B?UHI5ZER3cyt2RDFWbDZ5UFZrNmxHSE56RlhBdDJsWU0yaXYwc2xtZGlqY3o2?=
 =?utf-8?B?RHdBWmMzZHVGMTdrajlFNWRNY0c1c3VPSTlLNGd6TXdXa3FqZEgraUV4eHNw?=
 =?utf-8?B?bGczMkRUK0FiT3d5WW5VWkloL1R0aFluZVdiSXlLeG5UUFNhcmRRZEszYW9T?=
 =?utf-8?B?aE40YlBlWjcwOXcxMHoyN1V0cmVKYXFFYkZFcjdNSFFYWnpjTTF2RjJwdm45?=
 =?utf-8?B?aGNLVElZbnNaL25hamNEVDFzajJ0VllnMnNZUEsvc3RaZEpDTmhZSmoxSitE?=
 =?utf-8?B?ZUQ1N05Taml0SFNiYzE2UnoxZEhsVlRhRmFnZDM4akxIT2JRbTdXN2hoNDBl?=
 =?utf-8?B?bENvZ3p6TzdyTTAzVWl0N0RvbmJ0ZHlYMExrem0vZzJKK0hoNlduZnZlOWd1?=
 =?utf-8?B?ajZ4TFc1bDBSdDdZcnpIZ0hIWk8vcVdXU1d4YnVWSmlJTlhVNTl1SnVmL3JS?=
 =?utf-8?B?MVM5SFU1NTlxZmVhWWl1MnpvdEJCempYQmdjVys1L1lMLy9YT0tSSGtQTktk?=
 =?utf-8?B?azBsTnhXWkQ2blg2cDIvKzkzR0VFLzJTNU04WlpnUDlQYmk1QlRyK2hobElm?=
 =?utf-8?B?bkIyQVVBK0hwSDhWUTVKWSs3L05XNXVYZWg5cFZsUnNQY2QyVCt5Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa650940-19b8-40fc-03e0-08de70943b3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:25:08.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUfAItUAq2Tpr4RnQlSKeIivVH3XtqPwoMrzOuSPhKLm/Z6UpASsIpQJspRJWdHeuVHygDY8gYYO8X3NaYl7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9393

On 20.02.26 12:27, Florian Bezdeka wrote:
> Since 6.19 the signature of mm_get_unmapped_area() has one parameter
> less. The (previously) first struct mm_struct *mm parameter has been
> removed.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/rtdm/drvlib.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 86788743fe47b228662ef16831b4281ddefd04ff..0258100db5bbcc04880ddc71632b7992e50168dc 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -1907,8 +1907,12 @@ driver_get_unmapped_area(struct file *filp,
>  
>  #ifdef CONFIG_MMU
>  	/* Run default handler. */
> -	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff,
> -				    flags);
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
> +	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
> +#else
> +	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
> +#endif

-> wrappers.h, extending the existing logic there, using the latest
pattern here.

Jan

> +
>  #else
>  	return -ENODEV;
>  #endif
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
