Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AB26ED3A
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 05:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443155; cv=fail; b=h3/eHS1g3FWC/McARMlarqjBz+M5Gzxa3k1Ip4uyeUQZsAOu2nT2DROZ9lhDqz9rGAErDxVjCpGkl/YvU8HSqMs/lCi2R8G68RKU0tH6h+vT7MEUsK7Ts8Hk1eGoGtJ+stt8/yLkRI/au27qwJTRwrDzFttVplUujtBTSLIK4M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443155; c=relaxed/simple;
	bh=psDbHx3CKg79JyRnkBwgaFqUIzEeUZ/GKapQGScQV6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qBTxnbB1Pjk/pOFk2Yob3XlYOcUQpqq3uY8DiXNHmlytrgNQ3qAXmEYJh6/BWcqsc9HtZBTFM5fWiPjrlqggT+4waoDp0ToqnB65irjEqJm33vgrXui4cUCsq3lEEmAcjuGPJMIQ7CpKWkCQqLeEPMDOc71upeST5AvJZri/CU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dTG82bwB; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dTG82bwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jhdx/2unGzuSKY59kWd1YwOsW5KIHFYEtNRN5CAXSO8c1H4veKXr4ocW6xXFx6iaehNMUBsrIXGmAtFOwiZkYpwDMQTkdNyYbNqiSn7ply2peuEIlZ5qr1pOL3+IQ8Vho9aCGWzfTE9bVwvk6LMed4cj46LNWiEPKe8pEy5Vt5/xzp3GqGhoYWck191xEOG/AAqqk0iyi8ArFvEPpq4S1t7VN085vwbF15Kh3vvcgOlQi5Ls2RoqU7jJ4YhzS5D5KCxflJiTTmxzZQc0gaCzQu6DK46d/CzFQNMyGJlQr7VrDRt6zKgMrAoTxxjH/+6lqLaoFj46XU7kuPKorzVNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0Hd4fHrOiKJKF1L107xMn02sY4VFDQZmruGIF7N1/8=;
 b=RiKQDZPJGYKk4jTXLgWux8SWrCa+mZT38k7IZxnCV655D1KjTATQNWza1hO7ztqVACTsDbCjOOyRq1BlmYSyxrbz+IT2luXKZYV4RI/4jIEOHj6Hq7hiGgtWUqAtQgBe9sJ1B44CcHHxqqhUrpRhQ1+3EC1FZiSJzFG/s0oxtp+AFgitGDGDFxq0T2j9oUIQsLyk1G07ZztYuxOmLK2aBWF9VkU/1NQLarTU8lwwFwKzGZ+Njh88sv5nPKgb3oqrHLzHfkoMJLlPi+n4jBjgNii/tMvS1gW+5/VOX6Mori9DZxqlUYrJNSrEF3bxcty7RZiTfrZ+Hkm8oi8pw5CkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0Hd4fHrOiKJKF1L107xMn02sY4VFDQZmruGIF7N1/8=;
 b=dTG82bwBSrCTvcmkQ27mN6tffICwqzsJcJ84yzjSm78Z/TJ1gl0PJ1OYv4KDMHXcjaOhiG4AQxFFOrxN/A10nuaiRpTdClN3SsIuyd9COiYkss1sNPJwg1099QKLk2bDvJZnEIaRb0xBba9sT+Af/q1drGB6MBNDtx3VgqRNpn/W1MK35AXnIZkGVr0K0NJjtd5PhJuWIfGm1teMtiUO88ktx6wlNn/6u3dKOHCXgvkRHIntPhMAVRxBgS/cEeQW4ZbVObOlDdc/TGiKjd/HJy4k4RHm8B8SiNx56lm1xoYaUhzk8auFdq1L7Q0DgqOLw9i3NAz7Yj1Lx1dSy892BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 05:19:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 05:19:07 +0000
Message-ID: <56aca972-d9b1-465a-900d-643c1a60ffc8@siemens.com>
Date: Tue, 18 Nov 2025 06:19:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_igb Ethernet support multiple devices
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPGw0T0tOz9kYb0qmJaF0RLoKfDLJCbJ0Kx5yzvy=2icUw@mail.gmail.com>
 <43ccaa58-1b6b-4bd4-ae62-713314be97c2@siemens.com>
 <CA+K1mPGR7R9eGyh9fe3kOYNbjOF+=4oH3CYRyRkX37szqYG6iQ@mail.gmail.com>
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
In-Reply-To: <CA+K1mPGR7R9eGyh9fe3kOYNbjOF+=4oH3CYRyRkX37szqYG6iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a3450d-afa7-43cb-4930-08de2661ff6c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHkvRExwS2o0ZU04b3lHRVdxZlFVWVEwV1NscXozRkEwNFRJOWpvZnp1RkIy?=
 =?utf-8?B?cVMxUlowdXgwQzlIVCtZRlh6dURSRFRVWFJWSG83TWZPancxNlJHekNYTm9z?=
 =?utf-8?B?Z0dLbXFJaW0xYUpOUG54Mnl0MFVVU0RwMWtDR2xSQmpPenhnOHNtN3lzKzVD?=
 =?utf-8?B?YmVpQ3RveEV1S0c5WFJhN3c0WmNzQWtFVkx6TzF2MTlGRmRLQ2NqMnVpcTRP?=
 =?utf-8?B?ZVFCdWxlZ0Jqd054ektRbk1tTGVqLzEySlV5UytzY0ZKeGE5d3RuazZpWTd4?=
 =?utf-8?B?dzdLTWVBdDFxcXpTaDRjWGhnZ20yWUlkdjR4bEdLNC83cjQ5bXFybm91S1dX?=
 =?utf-8?B?Vi92elVTSXB4SytnRE9tdGhpUnFhZWM0M2NpeTNSdlZaQkw2bXd6clhCV2Zr?=
 =?utf-8?B?Ti9CNm04QXpXMnBEZ0QxMkRRdGl5SFZEM0pIY0Z4VUt0anovenVVUmI3STRw?=
 =?utf-8?B?MWpDRTBDSDU4dWcxVWdOb2ZONDMvYVF6L3JMb0JaNHhkV0R0RENnZVU4UDZG?=
 =?utf-8?B?U3ZKczhxcmUyNjk0b2lab3pia3JJTEtvVkd5MnlhQjZEL1lReStnLzFLSDhP?=
 =?utf-8?B?clk4czF2dDJUZnJWWEJ0TXhBMGJGWDlhNTBNcFZQNTM0V2ppVUxpMnYrOUxr?=
 =?utf-8?B?am94eERTOEZWME5tT0NZNG5ROFBDREhLMXZ1U2RjT3VWOFB2S0xNYkRrUWc4?=
 =?utf-8?B?S2Z1anpDbHBiSnV0VVBkb3NCRGlOWjFSZXM2RmMyYVJOcWxNQ2xPSG1xMWQx?=
 =?utf-8?B?dE9NeDVrZzRZdEgxV1RpWW1qaWVPMmpCSXpES3BxVCsrVzN5WnlVTldsUDJq?=
 =?utf-8?B?MjBDZnBGOThGYktNbXRyRmZqcmZpQ2o4ZmxzY1JXdnRjQ3RkZGZOalFsbjB1?=
 =?utf-8?B?ZHNSc0FPc3NWMkVVcmlNRkFXTTV1ajlFZ1VLMjJ2NkJMNElWcC8wSWV0anJP?=
 =?utf-8?B?S3QxSVpPUTJva3dXcFgxMWJGNDN1V0lhSUMwK0dmT3lITkpMSCtJV2hFZE1Y?=
 =?utf-8?B?bzRkRlJLUS84OFlnR3pXd3NYU1U1ZERpQjlxa1ZoNnoveHU5S0ZCTWkrMVZn?=
 =?utf-8?B?VGlkbFhDZ2RiT0VzMVg5SWorRlpudnpsL3o2eXNxQ1paZ2F4MGNHbjJmcXdP?=
 =?utf-8?B?QkNod2pwcW94RVF5dGpka1Z2cWtRNm95RTZSeUdkR2g2Y2pINjRHN3RqdXkr?=
 =?utf-8?B?ZDBSUmhwQmUwVlRmaVRjYnJZcnNkcm43UFYxK2Y5eWJaQ0Z0b0J6aUFVNWZS?=
 =?utf-8?B?MURnb0dqZWNoc3l3czFZbVY0MmJDZHVsQjlubXVqelVIczFxWFZxdHRLbk03?=
 =?utf-8?B?RGFzRjJZNUZHdzArR2xXUWZXcklYTFp2NHczT3lSZTQxM3BCQVlTTzNiRWxa?=
 =?utf-8?B?VUxYQVNuTGpNcEVrTDJDSmFOeVB0MGdweWZVUlZsWXRCeWlYdDNxTTZ5S3B3?=
 =?utf-8?B?cnh6K0N4WDNUNEZzcXl6S1NoTEt2b3EyNFVjSC9aaDBZSG5PMzV5ZVZNM0tk?=
 =?utf-8?B?SElWQ2gxZ1NkSWk4VDZaUk5hbExJZUhmcm9sM2FEL05xUDludS8yK3R1VUhv?=
 =?utf-8?B?Q3BLd3ZvMzdBVXREUkx3dUtxeTRLRElVWlVjdy9SQjdWcXc1ZEhWSmJVelBR?=
 =?utf-8?B?ajBGbnRZWk9mVFIwVjBvUVhicVVCTFV1bnlpZkpCOE5hWHQ3bDErNVRGcndI?=
 =?utf-8?B?U3ZWMFJjaHdESUhVZ0tGNDErSEN1YzFpdG9QSnNhNjkxZUk3aUJaUzJFeVJF?=
 =?utf-8?B?WXRDSEhpRlhtbW5FcHg5dG1hSERKdnhFaUczejRmN2VqbnVMN0xjanIvdkcz?=
 =?utf-8?B?NDVBcUZaQ05KUXkxNEorK282UnpWVU9UbXlZRy9EMjhTcGRwTjU4TXJ3ZHEw?=
 =?utf-8?B?OVZjZ2NXY2RlSHRrQU9XS0YwL1FnMSsyc1QrZ3g5Ri8wZGg5MGFrK2FSRk42?=
 =?utf-8?Q?jYxJNOtJim19WGGnjPOUCQVZW6oWIE9g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3JEUXlaRnBFaU9jSlZWMDZsYTVxUk1nbjNGZzZqZTNxTjg2b2RWaGMzZHJh?=
 =?utf-8?B?ekMzSDlhRVV1SC95dGFpNTY0N0JFUU0zSlFnZVM5WEtrcGtkK2s0d1VOc1d1?=
 =?utf-8?B?TWlmTmdKVzBqVHM4M2IwRFYxVUw0SUowVXUyMXE5U3hrUWJpb1pydjJZK09a?=
 =?utf-8?B?RlNEZ0ZpMUwwTVRJNHBFK1ZzV2dWdE1pYTF5T2o0ZCtVdnB1eGVNRGc1SHVX?=
 =?utf-8?B?ZmY5RU5wWnV2U0c4eXVwV1BmUEEyRFVTWmhxeVp3NVhYTkJhNlQ4N040eFlD?=
 =?utf-8?B?UEVVZVRlRVdra3FRNm1Qd2paUjBmWk9JUkprQkk5UkNMcm9kTXN1RmgvZ2w5?=
 =?utf-8?B?aTQvb1lYZUhuZW5wc3ljRm9JVVNGNlQ4V3I4MmNlNVJCZnZYS1ZkRGhtenVY?=
 =?utf-8?B?MmNuWEZUK0o0NWt1SGJkWk15M1lBUE9RcWNqVm9CZXlGb2syVEZQaElOQ2lw?=
 =?utf-8?B?cjRWQW80N2EwT1dSQWFiaHZ2Mnp6Q1c4VnJhSDYzeGpYT2c4OE56SkN3UGRn?=
 =?utf-8?B?L0FYNG94QVIzSFVQeVRVYlJKS3hBeG9VL3NkdkVjdDJlZnRWQVV2Q1B3Nm5W?=
 =?utf-8?B?N0UvenRVS3ZNaVBodmoza0ZjNklXTDNORGlad2N1bVdRSFUvbllPQWpOWm83?=
 =?utf-8?B?QlBQWHVJNFBaeGhLaDJKNGFhbEpidFAvVTY5OVlaSnhTbGpvQTR4dUJTSGFU?=
 =?utf-8?B?VmlmRUJmVDFIKzR0Y2luMEp0eG9TVmhsbUVLMjNxOWhTRnZidzdLVWpWUkdq?=
 =?utf-8?B?bE9XczFwWFdmK3BmL2xHd1ROQW5ZR1pFZzNNSTNVcCs3Vnltamx0eVpFQzQ0?=
 =?utf-8?B?YzdzVnNONnRpK2ZjNGZSS3l3a2tLdDJyVEJweGo5RWIwL0Z1T0lJWnNWc0tS?=
 =?utf-8?B?QW4yNi8zbUpkR0JlcVpra0prVld1WTlpL1N1eEdtZlp2VVJrbUV6bHZSRjdU?=
 =?utf-8?B?TTVjUVJHMCtjQ3IycUNQc29QMHBJVnI3QkNGRG9qK1d1WVU2K0dkRGhWeitu?=
 =?utf-8?B?U01zK28zck0wL294b3ZEZVFlR2RIUHVxQnQ3eXQ5SkFBVXBWUUd0U3F1R2N6?=
 =?utf-8?B?NVpySnlSeWw5c0NFRFoxRm43VkVCTDREc3lxVEdVbFYvUTQrSkZLWkJPOCtT?=
 =?utf-8?B?d2V2SW16QjZCSnlYWnB5Ly9qVlJpWnp1cm9zY2dTeXlpS3BGalZZT1lEd05R?=
 =?utf-8?B?TVdWb0hnV2Zld2psMTIzMnNGRkZRVWVxNERjL0ZmTE1JZlJPNWt3MlE1ZXFz?=
 =?utf-8?B?VnZuYXNqalZDV0lZVDFBeld5RWJKVDZIK2JEOVVrdlhVcjFubHNqNHh1K1Nx?=
 =?utf-8?B?eGZnMHRNUnZiWmVXNG0yTVN6ZlBMUitycS83dmgwTm9TV2M5dlpOLzlEVThi?=
 =?utf-8?B?OHY0aWdDOFRFWWZGakZWQ2VSL2s0NEVkdkRTd21TTHQyWEZSZlp2U1BvbG5s?=
 =?utf-8?B?ek5iR1EyNnI2bEw2czV2cXpxd3dZYkVxZlUxRzJwYTE3dVVGZlN6b0Z5WHJa?=
 =?utf-8?B?YWhQVGlsRUVSTjhvZEh3K1VtMWdFVFNRZmo0anE1dnp6YlZwMnlkSG5JeVVI?=
 =?utf-8?B?eFZ5UU11VUhBWGMwMlVPTWRCSGhOYjV2amhHTWNaRzY3Ry9HbktmOWpoNkRq?=
 =?utf-8?B?Q21JamtDSm05cUFCbjR2T01JSWcyY1VKWWx6dWJybHpabDYvZklSSDlaMlNU?=
 =?utf-8?B?c1g5aVZhb1E3M0Q1SjcxbE5Ua0lRL2Nlc3JQYUlCY3YwN2JZSDN0U1VCUGZn?=
 =?utf-8?B?dFRtTXQyWWZrYUxrWVZvZnpRTWR0S3pWSklUckVjUFZBNWRheXN0RkJBOHRa?=
 =?utf-8?B?d1YrNjVNQW9VSm5zVEJ5N0o3Rk52ekNVWnUyTzBDTkduS0lyWkxXL3FFNy9N?=
 =?utf-8?B?czd4ZmtSRDljOWJ3M2hrQ1Q3TmR3OGJFK3RkZi9BaTFKSW1NSTY4K1pqWkVU?=
 =?utf-8?B?dXAwOFAzUDlxZU5uN2x0bHhWWDU1SlZ5YkRyb0RXS2M2VnYwRVFIK0tyaTJQ?=
 =?utf-8?B?VHEzNFoweTJiRDkyUnVoM1FBWWI3cDVFc2IvemttMGNwWFNzTkU0QVZEYmd6?=
 =?utf-8?B?VG5uSVJyZUk2NkVEejhYK0JOUmROWkVUTzhQVXhOalFEOXpoRmc1MDVQSTBq?=
 =?utf-8?Q?9CMbgFZ24mpoSyMVDCQT+S/2w?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a3450d-afa7-43cb-4930-08de2661ff6c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 05:19:07.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEerK0TFsSOx7iIJ+6YN5o16A5xXVl62GIPbEM3v9cyCWxmHHGsvnT9gOdmBaWIY2yzk5Myexm3xA7gCz1AFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8604

On 18.11.25 03:12, C Smith wrote:
> On Fri, Nov 14, 2025 at 11:32 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 15.11.25 08:09, C Smith wrote:
>>> Can anyone verify that the rt_igb module will handle multiple NICs
>>> simultaneously?  My motherboard already has one xenomai rt_igb
>>> interface which works fine. Now I want to add an i210 NIC to the M.2.
>>> slot as an additional rt_igb network interface (with a different IPv4
>>> network address). Has this been tested?
>>>
>>
>> I'm fairly sure that this will work as there were measures taken to
>> limit the number of devices. But if you want to test before buying
>> hardware: qemu has an igb model as well.
>>
>> Jan
> 
> I tested it in the real world and multiple devices work OK. I was
> receiving UDP data on one rt_igb NIC while transmitting data on
> another rt_igb NIC.
> They were on different IRQ levels, BTW. Do you think that these two RT
> drivers could share an interrupt?

Modern hardware uses MSI/MSI-X, and so the times of sharing legacy IRQ
lines are over. While sharing between RT devices is no issue, you cannot
reasonably share between RT and non-RT devices, and this was often a
problem.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
