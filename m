Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2172EBBA9
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242223; cv=fail; b=FZxXswrK5+QOmsOcpeXoq/zaq9m/Kb15TxIafArtJ/e8L4n3lrMRqA+ThsCuFLurTKNvO9oJX/CCYlq4B/lcr/kATQa5cQKwq7SIJ090oTglRl1khdK4NsRL5vQn9CXmyOG9aZecuQsrzmjNkryOZv/ZTwYavDWSvR/v1BG2+iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242223; c=relaxed/simple;
	bh=4jbt1anTqd+IGIDOtx9ErsCKUKcRqeA5p4Niz7RG+Y4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=peq9Knoha18ZJf8Hp0TIXIsqStXIhOrIaQuE9EgARwLn6o4HfAVXZrg+W87/pNS3Rat5lhjvm98xH98JG7z45XEnSc8/GFdzGB+gNrxrjveHOHhGO5NIE7VVt4r7AGUqtIc5RHRGkIxSitRPNr55nJMQvrmwhO1dbxqnEbRpUDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xZCyczX7; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xZCyczX7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtMxotI8PCWcYj49JcMvlXUikjiqeFUOyWBJXBCjmlju54nbg69xDCcFx/57x77Du2sgu/EvkSaU5cSW3lQi8CqKeKspYAY9QkpE07Bo0OnB/B3nMjb9TlFzUtt62DRVeIy8672SIcUqiTPRZ+Ml/4fQrQlNtOesjYyYraMCn4nyPIvMJ+FgbepHQvoCF5gNXf2Zm2oVxGFdwt+tR5kJSlH4BIzbJQ9JxAhVJQ2Rg80osjZPRpAH1OUy9OLs8He0OKXQASwT+Iijy2FToAFM57b1pSmzz5Uq7oHFAQKG3fmagEslVSqisGWSJzZXtsl2zCbLtKKAuXKyuntbqvZbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqXsLfLHNJmvBez7qKNh/+O1o0mANkoXuuHzsITVmx4=;
 b=vsbTdw9sStx+WKxbR1dRx++E6/Amod0OGQNKMEMd1aFGos1Um5qGyu5J3zU9xS/HcfWw9M33tEnSNMEjHGW2QxrHUcex6ceCZPrUSpele/pwQe6sl65TzXb0bkwySWyLqTlS+Lqco0HlcTo9KAyRgqOFwiSrgOxcqhQ808pHZJtnWUCFEQSeCgGG2wKbj87KrQLEiA8+LRGq+TDDxMhKLt0vKv3P+7JGoAvh5PBRy+p5ItFCrBIGrZlQnQY+cBkU+Dxw357bfH8KzLavizWQhuRH6Nz+2h2W6+1hA+ogY5Izb7Ryr1G73kJzzZLT/p9S1dnkMQ+Dcn6CTjPqatIgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqXsLfLHNJmvBez7qKNh/+O1o0mANkoXuuHzsITVmx4=;
 b=xZCyczX7kr9uM6lU7ERuKZSJyFO2H+D2wyVAm/akMP3Oi5lnzT5FLiDNK6p52JLzjoLocCVaR4rUXz1fSHM4NJvCO9ZkaPI8NlYsChqyAfD7iXX2TibSrF5Rimgnk3Je2Z+SyrHzTXAaiN2W1e/skvycunDQ8RFnTH/h0o7lB1MJ5FWWZtUbg7kXskgzbkCOxbRtXzY9+ZuglesfLB5Mh3faO8GT2BMSBqYHgHhyyaa43FEg6mFi2PzgKYCeXOFrKBXD8ZcM8BnefwtOClJzGXF44CFn6MT8cdNaA28Aa+ZR4+9W3SIJeNf1soz7jQO/qPiS91FrrUxp25uOU3vcBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8394.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 11:43:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 11:43:38 +0000
Message-ID: <dd35c586-269c-40b5-b628-1c78479cfc98@siemens.com>
Date: Mon, 16 Feb 2026 12:43:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
 <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
 <0c22f949-8bf2-4566-aa37-10baca291b5c@siemens.com>
 <07bf64686c2fe140c55cd6d3b38a00f0b603024e.camel@siemens.com>
 <d0042085-122f-4fb4-a47b-7a8bed8133a1@siemens.com>
 <22e57c125201eae8993aeaaa6fb49a5d9ccfa3c7.camel@siemens.com>
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
In-Reply-To: <22e57c125201eae8993aeaaa6fb49a5d9ccfa3c7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4e0014-86fb-43bf-ab19-08de6d509fef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXArcUljaEV3dDF1dzQ5MHl6N1pJUm53RnlxRDV0UnNiSFZrTG5XUDVkakNH?=
 =?utf-8?B?STRTRWRhS1Frc0d0YmFlWXdVWnBraWRCRzFpSitSVERITC9EKzFqVDlXUzJ1?=
 =?utf-8?B?eWlLN2JyWWUxOEFNYUorWVlrNkMxOHkvalg5Qy9ydEdVQUdYSU1PTkRjamVC?=
 =?utf-8?B?VXIwdFBYTFJjT3pwdWIwR2I1VmhCNktXUU1DSDMvTWw5dUE2eU5BOUZPbUQ2?=
 =?utf-8?B?cjI4TjhVZW1oUnVHSnNsejgwdU9vTm96TE81WUJLdGYzOEZlSiswK2RjSDFo?=
 =?utf-8?B?cGIvTFEyTko0NFlHU3UwQ0Q5VndXSkJ5WGVpdWNDbW5VTVBpZ1dYQnlockFk?=
 =?utf-8?B?U2s5MXl3eEhicjE3SXJZazJVa0hvU2N1TGNNRDM1RmdnS3dtQS9lUWFsUWdQ?=
 =?utf-8?B?V0dZekFDYXdia1ptWEhJa2pUSWhSZ1JRMEpRTCt5eFBYY0o1ZDU2OFhjRUQ5?=
 =?utf-8?B?Q29JVlUwcXI4eUR2MXZtYUErS09GQTFwcVhXa3lzakFNT2xnRkY4bnNabU5E?=
 =?utf-8?B?L1FWc1JlY0ZMZmxRNGptLzd0OTQrSUhTL3VDRHZPZFU4bWhnNEJoWEpMWk1E?=
 =?utf-8?B?RFhqZ2drdjdGb0xmQ1l3aWxObzdhMVNPY24yZ1BHT2FTRE8zelExSkpCdjRv?=
 =?utf-8?B?eDRVRUQwdXFyc2c1U3BNTXl6cmpYWU1VYjVORExBMW1GTXIzSzI0L3grRWFi?=
 =?utf-8?B?THNGODJYbWR0UmRGdU5XeFFsOUVOVEY4NHhMUkg0Z0tCcjhyN1h4Ti9Canps?=
 =?utf-8?B?WFRxUmZBR0EvRGt5enRHWnpLY2Q5TFFKSTJlNkFCdy84KytHaEZ5aXFtdDI4?=
 =?utf-8?B?V0R0OXJJQW9nQmhLV3VKZlM1ZTUydTR3TXNsMWkxRStJb2hWc2RyTFYxaFNx?=
 =?utf-8?B?Z3hobko3UHBkL2lsdXlpYm42VFVjNXk1SUZGUXdSZkRad3VTdlpXdGlhSWxx?=
 =?utf-8?B?SWxQeWE1a2pjNWIzOEdJRFplbUdNOEgvREZCdmdxZ1B2SDhmQUE1SzdDdWJx?=
 =?utf-8?B?Z3JGZHNTemxDVWVDL0pMak5SRXQxKzB6NDMwYUc0WFpnS0hYWmk4Q291SXBk?=
 =?utf-8?B?cW5tWHJ6ZkoveFpZWmttZkFNYXVqczR0MFpmSitWSVhkMFRrNE9VMTlJVENC?=
 =?utf-8?B?N1QreG1XSjlvTENiakIwRXJpT05QZ0d3UmJOakxXaS96SE5nMGFIS1UxNGNi?=
 =?utf-8?B?K0lLemtTMHB2MWpwR0RCMWVwZFRDV3dMakxmMzBxR0R2dElvZFhHWHgrSVVk?=
 =?utf-8?B?M21PeGViR09na21GMFAxUjdOdWNyTTJ4Nm1Ea0UvTmZMQ1VLQ1FuZC9ISXU0?=
 =?utf-8?B?ZDdjSEJTOU5rK3RjQUE2SW5lemcwV2ticUVsbUE2a0J6UGIvZ1BxLzNhb3k2?=
 =?utf-8?B?Y3A5aVpGZWJZcXJJbFZpNFRLbjdxZVpmQ0JySnJRcXdmWi9yZGlRU0UvaTl2?=
 =?utf-8?B?L3g5SVhhcDI4UGpEelhhMVdlckRmNjJUckphNUFhRW5EcEtRNEhsYm5Ydmla?=
 =?utf-8?B?czM3U0xiNTQzalJhdDBhdjlQWDJrUDJINWhhRk5ERU4vNk8rQmdBUktCN3lV?=
 =?utf-8?B?V1l6cUJxQU1OT3FMVlV5WnBvK1k3RlFMS1pKYUkyVDUrcVdkWHpFU1E4OVJY?=
 =?utf-8?B?WGFkc3RRc2tLUkY5RnZ0Q2k0TWRoNHphTGdiN0lWUUJXbU1zQjFNNmk4VTl0?=
 =?utf-8?B?dGhYK08vREpLM0hVVVUvZDNERTQ5MDE1amh4cGIyRHMwSngyS1VJcDlUSTFh?=
 =?utf-8?B?STdvcEdNRHdxZ1NFbDY3Z1lzeHFBcUFGTStrNXZUU1I4cTUwOVpIUmtySTdO?=
 =?utf-8?B?MU9wWFkvYUE4NUhETjhkOXphNkhMMDNVclN6d3ZyTnNqcm1zcjh5SmU5TGll?=
 =?utf-8?B?YnpudlcwQ3hIT1pRNm5iYlNzanhhSUpjTHJwUllSdGtjY2JWYWMvV2Evd2N6?=
 =?utf-8?B?NG9UWTNZaXFGVlR1QndxMFRpclpzSDBsdFo0U3U5MHF0VTRKYkpzd0VaNUNx?=
 =?utf-8?B?K2dFRExBZUpwRGdPYzgyRURORWVNNVJYZTJ0ZmxQMEoyd0lqVytIQ3NOcGlU?=
 =?utf-8?B?UVEydlRqYWJGaUFUL3BuaG1MWUdUbTlLZHF0LzhveTNlZ0FMSmprRmNTL0lQ?=
 =?utf-8?Q?Q0jY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0MrOHBSNlBhMVdwOXF5UEVCblIxRUt4OUhQdHE3SWFCKy9DN1hXQld6ZVR4?=
 =?utf-8?B?ZUFoOGVGd01MNjZHRlIyOTkzUTZqREZPL29FQ2VpWG1tTkthaWxCbTlhdVZv?=
 =?utf-8?B?a2ZrdDJzTzM1cnpxWW1kMmJjQ0hmdlRyWmlOR3cwNlBXVHJrQ1lIUVZrU242?=
 =?utf-8?B?YmJiRlQyR3M5YTd6dWw5dG9icSt0aUdNanJBMTdMK2g1ZG5uczFDYW5GKzY4?=
 =?utf-8?B?U2ZaSitJV2RRb0sxUDJKQlZOWkxzdWdKVTFqQW9Jc1RSRGdLYWVhc1V2SSs3?=
 =?utf-8?B?S3B5RkcyM2R0eHFxNExiVzZ3anRLanAyM2Z5T0RCMCtvb3BCbUdoUmVlWjho?=
 =?utf-8?B?SXVMMlBMTktBLzFoUXZGaEpDWkZHcVViUVBNSlMzeTBWTTVXUEJFQUhWMnVM?=
 =?utf-8?B?QXFyVytiQVJibEhGVzkzRS92TEZZMGQyUEs3QjA1TDN1bjJqMTRiL3JZMnhy?=
 =?utf-8?B?WEhsZUdna3pzUnl0OUxzd1BrMmVwbCtHbGFhVG5kd2I4QVN1MU9sRU45UXBz?=
 =?utf-8?B?dTNRMWxtL0l5R0N1MTB6S1VTQ29BMFBQUC8vNGNaN0Zlcnd4OVUwRnhxR25v?=
 =?utf-8?B?RWhCUTZlcW5Ic1labnhraGFIRVFKMDJzakhEd1duZUI5dVlYTTNIbTlOTi9u?=
 =?utf-8?B?Tjh2QlVlWlM1UlN6Z2U1ZzgvanN4MFVHaVpBUnZRN1UwaXlrajZsMVRQb3Fl?=
 =?utf-8?B?RXNLbGNGOTZuVk4zbnJrYVF0c2FzQ29aUlVjUWxkTmVVRGkrN3dSbTZxOGlH?=
 =?utf-8?B?eW16a01SQ2hjYnVIRzZVU0pteldSNldmVHNWbW5lSlZCcFlRNHltZEVucFBt?=
 =?utf-8?B?bjZjT0IzVExDZEpTUi9GV1BCem8wM3ZMMEZmeEtERERrc3drMjYySHNvazN2?=
 =?utf-8?B?WkNNRWNsdFZmMm9HUWxneEp4bU5KY29nd3dtSGVCbVNuQWYrcjRnZDVLTmlQ?=
 =?utf-8?B?c1lCWVRpK3ZRa2VVZ0orTFNqQnJzUG9oK1lEVlFKM1VycnE2dm5IYUVvVkdE?=
 =?utf-8?B?MEtZZVNTanZaOFRMZnBxc2Y5SjdPVzNHak02anl2MnBVbko0OEd5YjdLUnJ3?=
 =?utf-8?B?TENjZlJtUVlpZG5vVUxVNHk3MVpwWDFqOWY4cjJIVWptR2hOck9COEFLOFIy?=
 =?utf-8?B?THQvR21hb05QV2lWUmIrVjlWM080V1Bia09FU0NFK0JSaHpseFoxVlhiS0do?=
 =?utf-8?B?RHlIUWx2azdTdzFFM3dXd2tMNjJhMXBxWFdtdjMrdE9ZUTRxT2NvNlRFVEsy?=
 =?utf-8?B?cVNoYTBIYk1ibUZsL2xpVXNNakkzNjJneXRTN0ZTaE5naWM0M00zVTdhejFo?=
 =?utf-8?B?N3lXaEtmb0g2SEdpTXplSFRVY1dWeGxHTHNTSm8yNE9VdzhyNnB3bTR1bUJB?=
 =?utf-8?B?VStzU0ZybjF5d0JPQTFTaitSUjV3Qmg4a0w4cGJzQzNYM1BEeUZabDVaRWVF?=
 =?utf-8?B?SDFVdUN6V0l6RzBHSEIyUm5nbHVGSTRhc05uUDdoSXYrZTdxOWo0OVo3UGxF?=
 =?utf-8?B?aXZwak1jSFVSaE1CR2JhampCeFV1blFTMk9GTWRCUUVNZ2tDZ1RaMlBYNmQv?=
 =?utf-8?B?Y0p2QkZvOHUvNVRYcDV2TjJPMjE2WEs2NEc3cktmb1djaFRYZm5YdjRISGYr?=
 =?utf-8?B?ZEwzNS9wN1p4SDJQVEErUWgvUzkwMkJxU0NKSHF5NlUvSmxIWlk0U1FZNnpy?=
 =?utf-8?B?cWlreVA4aUZ2RFZ3dWIxMW93QXRGaW5aeGxBdWhic092OTI2Y2N4dXRVOEcv?=
 =?utf-8?B?TFY0M3dBQUdxSFZxZGw3NHJ5cTZRQ1RjNkhMTU9RL0psRnltaTR1V05Na3Iw?=
 =?utf-8?B?aWNFbkg5OXNnd3lSUlYrZ3NOK1ByRE5HN2hzbXFxWlJHQ0dWaUxVNU56WWNJ?=
 =?utf-8?B?QmtPRE9UK1E4Ukl3TTdBMCtaYkZvclMrNWRVTXFJUThxVGJHdVRyR1NCTkEv?=
 =?utf-8?B?eitZZDJyQ0Yxa3JOd29VUzFwc1JnbUpwaGtsbVpkYzBxRWlTT2IrK29KZkV6?=
 =?utf-8?B?ZmhjSUN5SURJV0NPUGplbGtBYTY1U1NiYkh2d2Zxdk1pVUNyYTFQdWxwc0NP?=
 =?utf-8?B?UGM5NVBDUndMcWdsQTdkb0pzTHFYcnI0aDlUSnNGbHJUcmY2R1Npdzh1R01T?=
 =?utf-8?B?eFJ3STBweVhvMm8rYk83ZVpPV3BzWnYrMExabnBMUjJ4am9xT1dFOGxuNjY1?=
 =?utf-8?B?d2hheHhsbzFrNlNoc0JUTEZ4OThPNnVETCtvMmkwRElVQ2xBcUo4YUU0ZFlM?=
 =?utf-8?B?VGdXZEZYUjQ4cjdVaDVqb0hXQmZQa0pkckJQaUlNM2RVdW84eHRTRHd4M3lu?=
 =?utf-8?B?bHBmNEdpUFBQYmpvUHZJM1p4WG9tNzZoRzlsQzJoSXBaNUJwQ3VKVUVBRFlS?=
 =?utf-8?Q?K26rPQJVKRVkKeq4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4e0014-86fb-43bf-ab19-08de6d509fef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 11:43:38.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XY6X6gD+SD4k8ZTcZNpBtjF731c5LpAZtXA6MuCiVnYfbRoye99OMN/fwSQAYMwrfBCv675SjutxTUDDeYhkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8394

On 16.02.26 12:22, Florian Bezdeka wrote:
> On Mon, 2026-02-16 at 12:16 +0100, Jan Kiszka wrote:
>> On 16.02.26 12:15, Florian Bezdeka wrote:
>>> On Mon, 2026-02-16 at 12:11 +0100, Jan Kiszka wrote:
>>>> On 16.02.26 11:58, Florian Bezdeka wrote:
>>>>> Since 6.19 the signature of __request_percpu_irq() got one additional
>>>>> affinity parameter.
>>>>>
>>>>> A new Linux version specific wrapper cobalt_request_percpu_irq() is
>>>>> introduced to hide the signature change between different Linux
>>>>> versions.
>>>>>
>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>> ---
>>>>>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++++++++++++
>>>>>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-----
>>>>>  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
>>>>>  kernel/cobalt/dovetail/tick.c                      |  8 ++++----
>>>>>  4 files changed, 32 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>>> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb3223889ccf827b5b8cb279035a5dd7b 100644
>>>>> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>>> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>>> @@ -5,6 +5,26 @@
>>>>>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>>>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>>>  
>>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
>>>>> +static inline int cobalt_request_percpu_irq(unsigned int irq,
>>>>> +					    irq_handler_t handler,
>>>>> +					    unsigned long flags,
>>>>> +					    const char *devname,
>>>>> +					    void __percpu *dev_id)
>>>>> +{
>>>>> +	return __request_percpu_irq(irq, handler, flags, devname, dev_id);
>>>>> +}
>>>>> +#else
>>>>> +static inline int cobalt_request_percpu_irq(unsigned int irq,
>>>>> +					    irq_handler_t handler,
>>>>> +					    unsigned long flags,
>>>>> +					    const char *devname,
>>>>> +					    void __percpu *dev_id)
>>>>> +{
>>>>> +	return __request_percpu_irq(irq, handler, flags, devname, NULL, dev_id);
>>>>> +}
>>>>> +#endif
>>>>
>>>> Please use a define for request_percpu_irq on older kernels that uses
>>>> the new signature and resolves to the old one via __request_percpu_irq
>>>> as needed. 
>>>> Yes, also switch to request_percpu_irq directly because
>>>> __request_percpu_irq is going to be removed in 7.0.
>>>>
>>>
>>> request_percpu_irq() doesn't allow us to specify the flags. IRQF_OOB and
>>> IRQF_NO_THREAD would be needed.
>>
>> Then request_percpu_irq_affinity - whatever survives 7.0 already as well.
>>
> 
> No flags as well. 
> 
> I was not aware of __request_percpu_irq() being renamed in 7.0. Will try
> to find something else, but that doesn't look promising at the moment.
> 

Ouch, indeed, trouble ahead (or extra API needed from dovetail). If this
becomes a blocker moving forward with 6.19, just re-#define
__request_percpu_irq for now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
