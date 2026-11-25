Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795607077;
	b=UFECoGsq63+MLMK0lhvyhcHvB0YXYr9CqX6mpTZh0FORPFr/Z/Y9lJ/f2eLTnBcMFe1T
	 p77rP4Ewodz4CazGNjELqWeCWPHC4mOM1vcswg0HH8Vh0NyuLSqonkNpj302Jprz+hf0/
	 nr7m5tk/or5A6MZLwm/ZrjxED/9hvH9roI/DBApjy0D3vHudr+hR5QGVnW1ykCRvtasP4
	 a9sOcSOFvpNmccWoT5vjUIxEN0YYm+EAroxHP7u68pVL5bB1b+Nq9AkHIFnzWqT0WOLQX
	 21YWu/4yTjHpu+RK6+f7AgO+C5yU2oaVRUASDgUKgRaElui8SJVkBNFAPIbj3weR3OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607077;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fqzMu9dpXBKz6cJb3ddfR8iUuk5wWb8cDOmOs51eJts=;
	b=ypNGKOs9xvaYCbDCgxY+VfqxddVUrRiyh3cxpTpU73SdiAos7eETNwDW55OVFMISTwbX
	 u8oDdDMSHJJEu4engg92n/y8PRewCgGXlDU9JmW71Z1BsIa4+SAAhxdZ459c8qFCANlkk
	 BwBzUCky+RkIvbCvSAkMVkac4tX5bZYCaFlMWtxj3fxvajFbjtKoWyYHzIDBxEGf+Zjbx
	 /WRmV6Fx1JJHYcTp0YXTJ/Xxcr8ZTSyAy85Z/SplMUipBSaBnKVphE3pGOSsxkKyqYdVo
	 E4RIlaLPKZKmOlePNy3QMj6hCBqdboXf5yZdpSqA2kk8EY7DEHx+uxsyFv4GpsJbPlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=N5nP2Nds;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.42
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185E606A321
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 11:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9185E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=N5nP2Nds
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px7aVTjld2nwVawtriHF5McoW+GOvBijfOM7KVOzgsM4xVCi+duf3qxRBUerVPVabVPkCYCcovb5HD0y+lo86swjOfjKdfrEC7y3whtg58+pLl8XVcnlT6r6Atg4OLjUyMWUU8o1mrmTepWYqZ6W4xVIV7V6QNFMZw4mQaDyqS0WHOwmkwTO/ahCrPeF2oWnvLHSSyI8FfUfuzfspAS82wowM1j6HCrdb4pVU/qj3uZm2me2nylqnwc3FCi+8aCW4jTwbhdd6ilNFptlZPOWg2Vga3roXdskCu6g8yiNY1NTWO0H8eyXneMYrFNtiUc86vC8oq2RWKRPy7zktwUrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqzMu9dpXBKz6cJb3ddfR8iUuk5wWb8cDOmOs51eJts=;
 b=rG/4336N1U+O69NlX2M8cP1H9k8rfp2mMX4Q28LhAiX+C/YIMMO7zSBypnQoRQB9BnU5OVoV2iJ0pAlCXs/WgptqXynpOyOK8GRQKWBNOEKP8JPUrM9WeZTTYHkfHeeFYDsVn5Uf5F7OM/bSrDksUyorjKlzEaVKlb00iqQxl/YhggfCT8o09M/vpSALPMKGe55LqL1Os17ACxbPOoaQQRHbxgAeT78ZVN0bQO808qDzxvMeMebYVZdzWYaVzGX7e5FMh+q4Z0pKxju/CmnPwgBxfd8EyKa2eiTxNcShux3ZoS782DhlursObTVtoZ28aR7dPZ11vTyLITYpa9oWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqzMu9dpXBKz6cJb3ddfR8iUuk5wWb8cDOmOs51eJts=;
 b=N5nP2NdsTDbWK4sul3SQTvzx0oPL7D4PJf00gwnl3+ARWqYTP/IbkhNOyaQL+firaMDj/dDF4prOwbv4yHUCrafH25R2gVJRCaslXI+qS7/DEyM6GEk+2gUAEsvkoUy1C/BfoNA5d1ObwQXLt0veK+9f/meaNKLWH5eNkiQqCeeEsGmb9HopH3HUEYjjdKjMIfZYcP90NcjFmL8DaO1PBdEF0nsiePw0HDjBk0+q0SN2Qg/+ec9t/DV8k/2YH6wOhD+cxmGbn3TixPSbxiDdyQBHzx6DI6csGFgqVcLwhopRaYfIuzrrQGiPiOCt85KuBkZlw1t5gCbglMtVElATyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB8621.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:235::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 11:44:18 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 11:44:18 +0000
Message-ID: <5b39f820-a86d-4265-93a0-74b5569b71a8@siemens.com>
Date: Wed, 25 Nov 2026 12:44:14 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] dmaengine: imx-sdma: dovetail: Fix duplicate unlock
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
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
X-ClientProxiedBy: BN0PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:408:142::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: 972f1b76-2aab-42b0-fc4d-08df4ae97054
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|55112099003|261022105027099003|56012099006|11063799006|261021123027099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	eLC63rA5R5DCFK8BVCVHm0EhNi2ny6QB0rUDrdjiN5HWEB9b1B4LHvRPIUXQXFK4J+lihvZFHJUmrRw/2fIJ0VG8hSzN0JUYacjWkaq4LK+OdBelO7kDyjL/6FTD/iDi9RnuAEk2NZjrJ/lcDmpAE29KN+Wl/XGckQ/6d7ySoGP3tIMMoST+K3Kqc1Gy5egHnY6PCY7BqzhNjDmFqnhry99R5QLl7la+JADijiI3ww4eixhOiD2Io8sD4ndjiBE4ZbAYscYn4wr6zJexJ1Fun1LMKFl//veiLbAncINo6NFgJYEjAHfWyjd28AH12FD6+AvDylv0mdxNg8b2lg0FdYxDXMtk7HhWHIcd9eqJ7XTiSq9YRcV5MUDzhp4Bi6/ADIYSPUBms8UYCG9TMVz9lPp4hJ/F4RMpwyW+X0bX+DD1DzQBhpuvmlCqPQMGDJjs4Cy0CX3LSGrF2o64DbQ6JxkuYxJsdTSe8jKGOg4aR0y3b1jXzY6NeHdHQ9SWD8PJCLbST5eEQLYSO9YIv7gDm2iAtlt3/LpNY0FtfEE7O8AMa4RcCKiR1h0CC0ph/YHWrz1IpjNF4c8pYYWs/lF6zfAgvcb0eT9jav4/xebn38ZvZye8sMFAGcdeaZYmpmipIjUvLb4rWzTs9XZtFk6xZWODhlaYI01U8myZ1PbHMXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(55112099003)(261022105027099003)(56012099006)(11063799006)(261021123027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhYeE9UZlV1UlVBWGE1S2VQanBiMUN1T1RRTFNHRGxnaEJPUHNwQVQwY25E?=
 =?utf-8?B?aEoyTUJSSjJWSW92S0NQakJtUnlsbkJBU3NocysrV0QrZUZpL0JqR3IycEEz?=
 =?utf-8?B?Vm1JQkV3UmtqdjRMdzBsQ2xNSVRpSWpqajhnbUROOEU0VXRWV3VabXdyQzlq?=
 =?utf-8?B?aS8xTXA0eVNRMXpUYU5kbE90OFpCWStQVnUweC81TWExOVdtOFJkZnFDUkxU?=
 =?utf-8?B?RktyNVRtOHBGNFVnME8zL1QxN01KNEs1eExjZXFPVHJiR1FnQ2pheDhVd0pH?=
 =?utf-8?B?NVg5Y3pXTzVDNWFEUG84U3pUSGlyNHJSS1FkeUl3QU5FK0o4UkI1TW5Fa0wz?=
 =?utf-8?B?ai9INTRZQkVJckd5a05FTlRTVXBiQXpTT1QydGF5UEZwcDBFY0pjTEg2UUQ3?=
 =?utf-8?B?YTRxeVU1Q2srOEVKdU1PYUpjdm1tb3V6OUt3WmJxNXJxMzMxODRSUTlYeEdU?=
 =?utf-8?B?b1J3aUlrYTlTNFV1UTNqRmo3bHpGMHRiSXl0bkVIUWJ0dVlWNjFweG0ySnNO?=
 =?utf-8?B?MDlBeW05UUxvaUlSeDdtMDgybThON3dxWmVvMTRIYmg0ZnhaaURqNVBpWk1O?=
 =?utf-8?B?OTVQQVNVU3duV2NhekFRenJyUGRDZU83d2tyS25qQlB4L1NYZHVNcXJsVHFZ?=
 =?utf-8?B?R29XeWdGekN2aGV3UG9uQllJcGRQRHJ6V1Nac1h2UXZKdzZiMFNNTkpZWWZV?=
 =?utf-8?B?b2hTUmpUVkU5OG5GUFVUVVBjcHk0RzcrbUJDYVlNRzlQdkVrUkl1Mk1iRldC?=
 =?utf-8?B?RWlsRkg5NERsYW1ETi9XekNHR0pJVmh5ZU16d1hUWkNGeWxSYnRwVTJlNEpU?=
 =?utf-8?B?Mm1UaHk4U1lndGZhclFwd1NZekVTWjRNdDlKLzNoL1Z5MzJkMnUwcUpJSlN1?=
 =?utf-8?B?NEtYYWJEYmJ0RElkVm1vMVNCdDZyeDNtbGQ1MXgycXY0SVI2ZWI0TFBKSTds?=
 =?utf-8?B?Q0JQK2JYaVh1UjBuSDFrV2IxUHpMNXlreWYwcUhObVdHSjcwb0VVQ1VEWllw?=
 =?utf-8?B?TmpSTHB1L0dUcHlOZmt4RWtqZy9WcEZyTWhxN3V3TzcyelhEUGVoWklMdG5M?=
 =?utf-8?B?NThPWEltSGdoNkRNY3ZMc3YwWkwyR0E2NEhpZXdmYllWZWl5aUxqS2pBV0t5?=
 =?utf-8?B?R29rYlVTbzRUWmFhck9lNFhyVnhIMi9MVnZCU2FPbUp6WU02VjBycmg0NzN0?=
 =?utf-8?B?YlJtMjNzdWNBM0NoYTJmR1FVdWFvNXM2akZUT1ZvR1hLVFllTzNWZnFOYVg4?=
 =?utf-8?B?UmkwODdzQ0hjYmpYTnQvRFVVbXk5ODhXYzZzRmdIRHBJbGpCVkNJTHNORjNv?=
 =?utf-8?B?SWJNd2JldDNNQzFxNzhaZnR4Mk1EeUl5citRclNHenRuOHc3UWJJWE81QUQ5?=
 =?utf-8?B?SkxvdzgvRUlJZmhQZUhwWnA4SlpMM0dtbWFPczJoK29ycERrQTRlTGJPeDV1?=
 =?utf-8?B?ZGsyZ0RWa1VUOUdWM21EUiszQ3VURlkzRUlyOUxWbWZQMm9qU0lSMjYvNGJE?=
 =?utf-8?B?aU4wNS9oNmM4ekhSUlVVSGRoUDcvYlNtMWdmZFFtOTJ1ZWc5WmtNN1BzU0pt?=
 =?utf-8?B?MGFrY3MxbjRZV0FpQklReWFrRlA2ZWlQazhHVEkxaGFzdGkveTVVdWpJNVBM?=
 =?utf-8?B?bFVrYktvelZPMEF1NVlxN2YxR0hCZlBWQWhaMGRsUzRqVGVRajFla0owdVhN?=
 =?utf-8?B?OTFuOG9zRDBDVVN5M3NDWHcwYTkxNkwwS1hzVXR0SEJVVXJvZVFwOUQyZkZz?=
 =?utf-8?B?MHd5MFljK2NQdFNLQUJPNml0SUp6V2REUWtFNXlwK3NKTkJCTTVYSUZGZXJ6?=
 =?utf-8?B?SU14dnNBSHdiL0ZQZ05wS1VTSmVZRHY2OWVmdkZydE9BcGRiT1Y3bDQrODZM?=
 =?utf-8?B?Yk5GUzYybHJrQ0cvSWdKVytsbytkTUdYbHI0VFpQRFZ0QXRUVktEVVNSa2ow?=
 =?utf-8?B?Mnh2RWFqYjR1WVkydWMyRU1tcHVPdzNOQ1NqZS9naklEVjlpeTJ1NEptb3pY?=
 =?utf-8?B?NG1CSEZ3OGluOEVnMWZURWJxQ2FBZHhhVjRab2l1YlZKYTVveUJidWtOdjVr?=
 =?utf-8?B?NjNlT2FjVFc2WEtDLzdGWGwyc0ZJS3Z5aTRteVN2YXRpM3A4SlVGNzBWVnhv?=
 =?utf-8?B?WTdwL0pzTms2VUtpR21UQ2dUTGtyRnVFTnFVcUpjQlZRbUl5bnM1bFlSL0Q2?=
 =?utf-8?B?ZGtkRGY3YjlqcmV6djVmdk5FOEN5QVR6NzNGNUpJWEpmMEU2SXBtQlJzV05y?=
 =?utf-8?B?WkgvcjFnYWZNTjZldFdyK3BsZi8wTUEycnl1ZGtpckZlVEF1T1kxTDRKK3dj?=
 =?utf-8?B?bFRIYkxOekE5YTR2NGRqRW1TUGtSdzlsOWZKbVRYZVJzMW1nNGlHdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972f1b76-2aab-42b0-fc4d-08df4ae97054
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:44:18.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM+tTeFQ1hXbfTdGTrEPbxaj3e5M2c+p2OZN7A45yze9Qwg9UytBbKSD/lTJqRbgJtmW6tt+5fgoWaX1BwUmRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8621

From: Jan Kiszka <jan.kiszka@siemens.com>

The dovetail conversion forgot to drop the spin_unlock which is supposed
to be replaced with the vchan_unlock some lines later.

Reported-by: opencode:Opus-5.5
Fixes: 187b1d6237e5, v7.1-dovetail-rebase ("dmaengine: imx-sdma: dovetail: enable out-of-band operations")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/dma/imx-sdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 22c7cccc60179..5414df2269d4d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -986,7 +986,6 @@ static unsigned long sdma_do_channels(struct sdma_engine *sdma,
 			}
 		}
 
-		spin_unlock(&sdmac->vc.lock);
 		__clear_bit(channel, &stat);
 	next:
 		vchan_unlock(&sdmac->vc);
-- 
2.47.3
