Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.233
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482176;
	b=oVu1XJ//fzA4avLh+YLThh1HlxK2ADCWjWPws5uth/gg34KhFHr/ZPg22A4wfADHUs3H
	 v0ivAtvuJgSxD4PgFWHOVACp3szzLcJIgxAbKeOy9wLJTQPFSpX57wOyoko0YBj7an8bH
	 PFNOxkE5vvWC5gQ+kFnP6EnmFQETRO7Ey02r56I7lZOUij2+THy+/VdoyJg/Tck9yffZ2
	 rilX7Wh1SxztEkWIvMATEGuC1LqpKHpcRRE7b081HlEspNKt1XA7FteW+6eP0POYTJQ9k
	 F6lD+Nmkpk3jiCXXQ6Ft4hn8KwsrIYyslALqf/8bzx6DMX34zVv86bwaZyjrmHrffDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482176;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Cause:
	 X-GND-State:X-GND-Score;
	bh=/YyvAQVASi5Do1xqdNG2Yei07q9bn/uzGjR8hJK2jH8=;
	b=3eQQrsah72mbkoJRNFVck3lGRoC4JIsDafyAmeCELPyfV5owLbcHchmACoouXoMqq2Qk
	 GNTO55frQky/DfHVfN819tWyFzwBnT1IKr9w77K0dJKkNjTQWHlOvVcfF4qg/b4ept/AK
	 pqhmDbyg7lmGr0owenEiUndH2tamkMXFwVi9HOYiLCjv4XLVSGmMRFSTw2PccIJV9Ek/P
	 oTjjhWJLwAV4UFE7DCRHPz5lheogrvKHOHGQZT4gV0JQ3XfO1EV0LzEiJYNMPWbvCuBBc
	 VMGB9J2XpOY0Ognfhp908FR6mLYkOwSah1QBHNBSASxIAutBLmAzaBASiQ8H9IXtP/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=m4NBqi2w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.233
Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F93606A880
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F93606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=m4NBqi2w
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 257C73EAA6
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:16:08 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E5D6427E0086;
	Thu, 12 Nov 2026 11:16:07 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=m4NBqi2w;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::5 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOza5aMw4rg0hca50ZznoFodu2ewSEnOZd4GipiF2VnOs7d+74Ws0ARs1pWrSoigncK+WTvn5HEal9UBTpbzPhZAJmXXipruuQqDxXHUn8Mcn+m3BkUTs7BuPxt0jnjoGsqrsdYWv3jUq9ESo/oDTJ7AOyCUcusXtwZz6fZBeZwEQXSrmkkWVeoHu8RT3t7B151nUcH80Qfeamf/YJqhT/YQHBP548kNXIrl4zl1s3bNhT9ZIff+lA34qEyGy00iW/YKMUBh7eZZNOZTEO0ywLKaSJzjKW1rQRFrfaGBxX5GY98VHXeN21ZCuh4M1ZASOKpBhb5VVuDdDQL9ZyEItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YyvAQVASi5Do1xqdNG2Yei07q9bn/uzGjR8hJK2jH8=;
 b=iXEz3s7iaNVowZGa0Tsi5eXrNaEI6OoJl3rC+Pqws0e/1fxpZTSn+41bCIXaFZqlvjM11/n4PCDolSSLmu3D4NlZcJjwHjD1BTUSJOZ6Fi9H4UiN7FuC2gMO2EBZikVswGpUDFzr2D0NhZr554pvM8swspTuPpeySjWDSsTPrAa19ehIV0MBqIjp5x5iVIqOsnn9UysYfR++rLfUDtnHC0Vqp/D3mxfkXs98tl4PAwGhl7SwbRq1cqcS2cIRyxyflxroU/UX7aqIQ/SmmmdWxsfJwqEScTdIjGZttMkqbRu5wi8Cw6GTw52COoTXFL0vobE+/PWDmNqo6F5vuLwuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YyvAQVASi5Do1xqdNG2Yei07q9bn/uzGjR8hJK2jH8=;
 b=m4NBqi2wasa87QpolRey+abxjdSTFclBt6HtST1yT6wfN7lvKh7yzQN3Pnis9u7HBW2om6yNuS4AjuQDdX4AEWcam9tdGahyffJXsbyNA+vkKzY1oq8E02sS6dh8FHjTuB97iQpK2x2cQ9ncUIcn+VMhXo5DDZg1Te/qNht4D+T43honsejP2mmg9bUDDQAFFfRizuH21N62RpTdRZkJCkkyD4Zpiuvx8jiiq5uG3TBQK81Fq0B7J+8r4kMmVq9d825fmkb6oiE1H6PntSIczRYCpwNx7fsICJHM8yvJ1WP6kSXrR+L0VlBELtwB1Y9wT8shTJIbDA6KfA4xjcLk+Q==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB8301.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1dd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Thu, 12 Nov
 2026 11:16:06 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 11:16:06 +0000
Message-ID: <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
Date: Thu, 12 Nov 2026 12:16:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <87cxsa2vej.fsf@xenomai.org>
 <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
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
In-Reply-To: <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:408:e8::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: f9dc7685-5a54-4930-cfaf-08df40ae5863
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|6133799003|55112099003|56012099006|4143699003|11063799006|5023799004|10067099003|261021121427099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	i1VHlNTQP+hwPtYdtY8LFT2yGoaG+9UOodeFV1JY/bBgMae/e72oybXs4bVQH9aIftBNCFi5bfWMh7zCkRbj/bxKTW5wSILlVcR3tUBhDCWYoVnbzmkpT6fIqaD+WRt/q8lnXQpwgbEG5oIHaDuR7sbofdnzigoW/3UumoBU+2Y5J3uVHLQ52tO7IylGCbTxSSq3Cs9ajaev5iJUVEOYQK9o5cRJuG7RhaTwBHqea4ESE0Ay/LH320f6+kERhhkSx7/FgBtznwX3h6vt2NGy0QSFjaDjZ7CTlQ4Rygqa/HsbRteL67go6sJuXHELJ699WH+FZ8yp/LVCJI7ixmnKhwxAzWvnhbzALedXxlR0OpqqtiFAioxbNIuxMeC1UvLPvMLBH6cr4/lyr3uoPsPOMhbLejijRoXPD0xYKzjoNSl8+v1N4oIJCE45NcNmfMbckhDonHKV41PtT37CkLEpKs/cAGlEqkjxtBja9iEbNkoxenfBmwE+gJvac/wlYLQ4IRxDhQW5048wQR/mDERhuCVvO0s6ijL4rQvoa0jhF3uK6QrjSPHv+LY0dpGUZSfzboJRa4clu0jz+YnH735Jw5sf3mBVG3PvfUNJh/PzF1rIo9jexN/45mcZCSpzeitU00CQzV83ZXbICHYQunqEyCsNLuD8upYkQVUYN+S6FfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(6133799003)(55112099003)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(261021121427099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXdOSE1tSkQ5V0FiOW5qNUFvaHN2NGw5NW5lUVZETlUwMjdpZ01BU2JpTjFw?=
 =?utf-8?B?aFFmZ2hFaVRmeGl3cDNFMFNKRVpGbHZtZFl4ZmkxN1NZcmNnYkFraGZwTnZK?=
 =?utf-8?B?UFFmS0luTWxqK0V6ZWNpUUJzTVFYYlV0VkFwQ3owNnlJRHVQQ21nakpEcS9U?=
 =?utf-8?B?Q3pKQzRnenlNNEhKRUZzbm9Sbzk2cDR5VDVmaUFUOWJBK3Q3c3pEcjkyVjk1?=
 =?utf-8?B?MUV2OHdYWUY3RlZYaktZaDN6SEY0QUNBUkMwbjM3cXg4SVMxNVA4QTVRcWFJ?=
 =?utf-8?B?ZVZkcEk4dXN1T0tIOGlmSDVlWU01NllZaDhJbFU2bVFHUVA4M2tQRnRTQ1M3?=
 =?utf-8?B?dlBOM0pvVzYzaEM4WFNQbGJCMWwxNGJUT1NyZ056YndUSGdjTWs3V2tsWkxR?=
 =?utf-8?B?dTR1T1ovSGp3Vm9qUkZzOVEwR2JRTEZYQ3pjRGdRbjVBdVR1RUFhNVpUdFBH?=
 =?utf-8?B?WkMrTWU0eUdma3FsSFVjV1NINUJVajM3c1ptMXNPYzlYcEFGWlF1VC9QQTRa?=
 =?utf-8?B?ZGpQUU1lYjA0UnU0cFU5MVJVRTRDSnUvejZ1NGFYNmswTXc2S2J1d3RDVFdk?=
 =?utf-8?B?UlowdHZXZHd0dlJJOU5udVZ5TG5IY2cwTS9LejV3Q1d3TTF5cGNyQUJFdVhT?=
 =?utf-8?B?dVdiU01yay9lM0cvYk1LNi9qODBLU3UzUXh6MFVXcWFXS1dXQXBnN1hNbmdl?=
 =?utf-8?B?R05zUmZNTUtsMGVUTUhyRm9RekdCUitEUEJERnJ2b1ZlL0RWRklBQ1J6Qng0?=
 =?utf-8?B?U1NDc0tjY2NqQURteFhST2poQ2N3a011dStiTmdOdk8vMEc2eDJjbGRydTNa?=
 =?utf-8?B?Mm9RWkZrRFNMUWxVSnNIQW5mTkdVVjVlMkpmNkFFKzc4cEFaTTRjVDJrZ1h0?=
 =?utf-8?B?OWVnT2toTlMwUENwR3Q1S0tnQW1CR2JSbFp2VXlUUTNrQ2QrU1VHa0MxVDUy?=
 =?utf-8?B?em96eU0xYWVVU0FEYWdaRmxyd09LdFp2ZTlCSGFMRURwdGdQNmdQUVJGQ0RH?=
 =?utf-8?B?TlYzQjNoNnU5b1laODFzZUVPM2JSdzZjdVUxaTA4ZllMQ1loVlFEdTdQZDlw?=
 =?utf-8?B?OXM1d3ExdExGTmJ3RU1KMTl4QWtmOXV3ZXpkdGMrbHJBdEJNcDBVSWdZUVJG?=
 =?utf-8?B?cTRabUh0R09QczVPbFJMVkl5YVRYYjVtU0NPOTRqNit3SkhXb2JyYVRQeitm?=
 =?utf-8?B?NHNieHdwOVNQUU01YlRwYkFpcUpDQjRFSWdDTk92akgwdnY1ckM5U3c5RE5Q?=
 =?utf-8?B?azdGRVg0Y2RtdXlmcWhpZnprRG1oSlAxa29MWTFsSVNkaDZZdEtTRFRUL1pE?=
 =?utf-8?B?T2tLWlF4amZJNExvNkIzcmpZSnZHbnhzYlBPMXRTandkQzlTMEVHa1pFbWpx?=
 =?utf-8?B?bGtRUXpxcWNSQXRvUllIbmx1dlZhWlpqSTcxTXhTV1Y0QkdYY0dzNDA5REpN?=
 =?utf-8?B?UzFTNXFYZHhJY2I5VGRRS2t5cm5nZHI5dGZndlBwQTU3SXU0TmlaTS9SQmFJ?=
 =?utf-8?B?YzErL0VRZTE4NmVldlBoUEg1ZHFwbkUxc21VTTV4N3pyRlhXMzZBd1ptbW1J?=
 =?utf-8?B?Um1zTTJsdit5RmR2YTZ1T3lWQ3ZjUXcrT0FwMWxqeGd3QTVVdzJGNmFEbU5I?=
 =?utf-8?B?eFFYUFBPSHhlaWNmQU93TkJnYWY0c2pkZnVqbGdpTm9FSGx2MHhNd05ENXlK?=
 =?utf-8?B?bzRhWEE1eEJFQ0dHN3B4M2c5WEQ3bTFPNnpYZ2NrUG43SEFrUnhmZW12ZVFt?=
 =?utf-8?B?UkdJUnVnRDlBZGNiOENZdkdMQjBxZUt3dHM0U013aG9qOXZJeU9rMGxYWEg1?=
 =?utf-8?B?VTZlUEhvcEhzT2QzT0hWakRheE5PelRXY1JnaTVITmhDN3RnWGxzMzV3bVZB?=
 =?utf-8?B?V1J5R0xNamNMQWt5RE9RbmhRVDhPdFNkUWZVYzVYR2lXREJPT2RtZzJTQkJy?=
 =?utf-8?B?UWJReFc2SGJIUFVMNi9sd2ViQm1nNnFxbGVMaGx6MlMxQ2lCUk5RWHVFTzdT?=
 =?utf-8?B?ZnN0WTNXb05wbm9IelpmMlU0NkN1bU1sRjVWcXp5OXkxVlFMWnpiSytPV2h4?=
 =?utf-8?B?cVUzTTBCanhNbkxlVkdubi8wTUpUMVpHTVhZSE9ETUFMU2dqQW05NjR1ZHd2?=
 =?utf-8?B?L0VLY29IdnNUQ1paOFcxejBQQlh5KzNqRVg5dEppTU9kcDZ0b0xkdUhVbTF0?=
 =?utf-8?B?bGlUdGl2TlBlazg5Z25ScHp5VzEzdG9aNkZWNGZiczJudVl1OXpRWUJKUHBi?=
 =?utf-8?B?cC83cVlsV2ErNjFGbjRpRTVBejhwY093MlowQkxPb2N1ck1ma0pkR05SQURR?=
 =?utf-8?B?ZTBrMFBWNlpsSUxHbWcvT1FUV2Rid2hMcGZyOUFDdWY5TklCQVp3QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dc7685-5a54-4930-cfaf-08df40ae5863
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:16:06.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qJcLnvVZ0+A4l3op7mKBhmP4ucJgK/4gAAGe6Z0KmPqrqOJTtPTv7Nzs3+ogYz/UeSCWs953W1FbRfvuC8ALQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8301
X-GND-Cause: dmFkZTGmw3LJiBdyMoJCzru0GVO5p8RqBsjijbxHlAoZAMexejk6Iv4bWciqUy/BJN9reYfCFUX0t4HeXVwQllm2jUHx/pCc5x1A73w5uapFSBOpZ7tc41OlbaoZF7JP8ygkbX70gYyltddDaDg6RiuFbH49e/rU3NyNPOthieG7pwNJh+MKWoxvDqNWi4J01A2AqyeHdxxW0vS+ud4z+YFm2kHcfj7bOVlpBK966F8TOP53EW9lU8h2b/w2BhD5XZIy2g1X6adDhKbdMt0wOPtYk+gzfKhJ4AChoaXpWXHQqovoRQEaH7fnErY4GYUMDvL6YkMePesZjVfd4Hzahj/xQQmTtw4DOWFyzECteMYiyRvx7oJP0z5slEr+Ew8qyctEH/ss2x1p8iwj+p1DypSDLmzFuE3CdNKX87zQHrn7R+/c2RN8k44v3tXRts3azJkQzcb7a4DeOzd82s2HIGkKpOxq2ou/aPzXE8Jt9tcfzimbnxjmrTkjU5ohZ8AnVIC2WgXnpQCJopdYgU/+zjdZB/DjCZrHgojID5YHDLRwNT6kD3VfxgXhuek4/cSeYs1FY9F3j3OMUOl/EdTGTQxXeqAaQ5feoGgFZvIZ+5EGYe6HI7RpLW5fFJkrT+MtnmdjGK+k+l0GEvF9YN55Sb6bXuJjChQ4Qi/W0EG9EsOQWlLktg
X-GND-State: clean
X-GND-Score: -100

On 12.11.26 12:05, Florian Bezdeka wrote:
> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>>
>>> I will share the lengthy test case as well once I'm done with stripping
>>> it down further (if possible). What the tests already demonstrated is
>>> that unpatched kernels crash.
>>>
>>> These patches here are almost completely generated. One of my few
>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>
>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>> of them I already shortened, but most is still left. We can cut down
>>> further, but I would first of all like to have another review round.
>>>
>>> While doing that, keep in mind that AI tends to ignore issues left and
>>> right when being told to do a specific task. It may have simply missed
>>> further preexisting issues or even created new ones now. Watch out!
>>>
>>
>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>> that you are confident with those changes eventually.
>>
> 
> Those patches should not go anywhere until they reached the latest
> development branch. The common "upstream first" rule.
> 
> Everything else will add a lot of confusion.

The v6.18 application was experimental, to validate that the test suite
passes on real hardware when all issues are addressed. Nothing is
official in rebase branches until it is tagged, including those patches.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
