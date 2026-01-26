Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE73375C5
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447020; cv=fail; b=gHHKrY6hh1cJNNhdR5s7WOkAQMyzpyWwZjz2HKGofCzNxGF6pEW0eQ9j/Lui7BaiD1NZPiC3X0BTJeClhMUBBqB+JkKix5UV9nxRjbKpW4mXm28NnvqS2bzPBsiEkhyq7NsJv9C6PVlth19BKU2130Tm4u0trbTgaVxpxFg0NT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447020; c=relaxed/simple;
	bh=VpPV5oDMCqS3VRzg6vHlugtAhlxfb1T5B8PYcPUIfZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aOZe0oExczP+aYI4JEw8ioTbvgtmLM/vC37VC2NmetX9ZGk/bWVD3M/xzk3HFmSgckFvdPtY4i7hMNSQ1IgqUWN8x4EOmTcLs27mFQsu0qOBVXoX+mBgBWrkpkwnUrPrtwwWNccy97Kcn+BiHvkiMiXEIH//AP8633/fvZWQMO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Z27rDnhe; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Z27rDnhe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQrg/b7bxowwQsGAZ6+ne8vLpR0J1ULnH7HKA820gjm0XqrlMCbwgnI/e5DoO55awKyYNmSfBMr/X38gczFk/O7LgoXOBOuBZw5lE2lHEvPpb4b3H5arRQ6VuJm/Q5VITLlJEbAp4EYWAKUuEKeATZEUcNSBpFt5leKHlZDnlyBeFU9Ef5s4M7udbusIbR9gzBOL9S2/PjXAOkk7hUx3o7zn7CCVeL7LeoeMzsdBVRrF2x/zrtTA3Ouxjls5rPNuwT/tenoHbgjKDkgcXcyDUAksZosv34TNejmozjTsafXfSSKDZSMzeKjUM3W8c3jAJmpL00/VHkn/qtMjAjVbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MpcorHJH1fqewG45uGgJQiRIbG3+IRDsb3ROqSbomk=;
 b=rXT6pBoI0WL9XnrM6gSW0Mh2JhAGpm1NjGPZp2GNzLp0lo1vHTrq4kuZGctsWmr+J2b6DCVrXZzV5w2iR6i/a5Cu+wrrOIeGWemv/zRQBfLlIpYoWAXkMCHm13CNyurzgUQ7vjLUPR0u7EyM3mYjy6jDKekJG4myJuqaz/5edOl05i9juDEOfdZr0RuCqTPUU9cF/fGxcXEY9bAsAc4L+gBWkFAKENO6somZv6UlYTepJmqqHwYMQu2298/4JnkwdDpkeBDd7vZ6zwT1Tzf/S+dnfFOtTwpo176Gf2MZNHHD9T3ScQQMO7hwoiTlyNBbo/ENxezn+v2PepneVGI+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MpcorHJH1fqewG45uGgJQiRIbG3+IRDsb3ROqSbomk=;
 b=Z27rDnhePAIY8DczIAIlejrcvlqRULt2b/PYSaZIEbIDsQ84tO/Xr05f5c7lhzO2KB7ucgJcph8B9Ux6cF0qhaU9Jak2FaEND0BeDtluBlvNshkCdQtrdp84s1myxeZKKoIBh+sga5wydN2HJ/BYlWGf5RI+Y3tJ1Mxf7HzEii7Qdz5a2osQQRZDUH8THM37SNldBU299BL28vi7qRw6TdOUzuOYpunTvk1QAyfE/rmsPoNEwdXnWzsjBDFbcKfTGMGMV959ihyde4pJi7X2ItFbIb5f8PxvtRTmr5TdYynrTllrlIfYmcol5etds8FT9+FhnRur2PZ9wPTSxW10Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:03:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 17:03:31 +0000
Message-ID: <d953a897-92a8-4a83-ba2c-7d95059b4525@siemens.com>
Date: Mon, 26 Jan 2026 18:03:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CPU Hotplug Splat
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at>
 <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com>
 <1353891765.13527.1769446729193.JavaMail.zimbra@nod.at>
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
In-Reply-To: <1353891765.13527.1769446729193.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::48) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c841209-b220-4039-3b15-08de5cfcd561
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0NVcncxRzRKRlZuYUlkMnR3Rm9HSVRrVy91bzFUM3I0TkVGMExyMnNXN0l2?=
 =?utf-8?B?TFoyV0dYdTNwR0QxeG9jcUNNN2d0MXR3YWMzYTNjcTBncWxkNzlKTEpQelkz?=
 =?utf-8?B?ck9rd2dOeW1DdFhZTEtJOVhYZDBGWUpRem9jbmRURlJpQmlXajYrdVl3Smxn?=
 =?utf-8?B?cU03R3RiRkJZMEhOVU1pQTV5bzdhalQxZTQvQjlpRUU5bDdIeHY3RUlsa2Fn?=
 =?utf-8?B?MnIxcnIyL2pIUUNqSHY3ZE9naml6MU16T2ovandpUVNjK0hZcHBSQUx1TWdw?=
 =?utf-8?B?SzlVaUM1aW5pcGdndTRtVFNtWTRzdGV4UlBWcVQwV0g3NUF4M1kzUTFxcVZU?=
 =?utf-8?B?MkNRTi9aaVlyZ2krbkJtQVBOZkRLdVZDZEptVFJlcFhPNWR4d0xjdUFKdUVs?=
 =?utf-8?B?NTk5aDllNlJIeklUMXIzeGNYMWlrYVI0VThPK1M3czlrUW5DdXY2WXFFNmhK?=
 =?utf-8?B?YVBjby9HaWdXWVpSSUwrUVJ2ZjV2VEdoREtkUm1TdVVPSWZoRzFadDBKem0y?=
 =?utf-8?B?S2tRM2pubFpDNTlnVmJFNlIwT3FNVXk2RS9wZGFqdDE1TGIxc3lCckJseldN?=
 =?utf-8?B?d1dDSXBMeTZKTjR6ZjVHOVQvRzUrVFFrZURXM1Jjck1CVGh5MS9GUi8wM3Rw?=
 =?utf-8?B?NlRFWVpTRHVtbW92TjlUL2FnRyt2djU4TW1kNmZMbUZzVzJUWXZmVnVqWTFi?=
 =?utf-8?B?aEJyV2pkdnJVZkpaanhJdWFseG04QWgrM25sYWIzaVprbm1XQmVhUEVGeVdZ?=
 =?utf-8?B?QUExZEk2MVhRTkZkeG1qb3ZCZ2J5NVAvOUhESU1Yd0VaUG54TUtKUHY0cThm?=
 =?utf-8?B?c1FZYVFla2wyc1pxNEhudVFjaFFFbUdKay9RSjkyYXVlZEkwWitvQkdhU002?=
 =?utf-8?B?RjRoUWpkcmJ1cC84cDVtUmo3d1lzamxtTWVIT3Jqb2xtanpLNzMxZ1VkREtD?=
 =?utf-8?B?dTBXWlFjUUJTU1U1SWNTRWlVZC93YUV2OFhUL0d5Z3Y1Q1FFdDRYYytBUWpV?=
 =?utf-8?B?UGg3MnAxSDFrWDBCbjhUTlJDQUxiajhTVkpzVkJNRk1DTlZwdy93czNaMXVY?=
 =?utf-8?B?UnY2Wk1odit6L3FDL3l1WVkzNy9hU2Fpdm1BQ2YxcmMvbU5zRDFhSUJERm10?=
 =?utf-8?B?Z1hYNDM0VGlhZEx0ZStLNG5hK1htNEtlYTVZTSs5Qm1ZZXZJSENsMEdPWU5H?=
 =?utf-8?B?Qy9KK1NWN1ViWWtFTnZCZ2VLUnF1WFRVSWd3SGgrUnNRS1E2TVVCN2FweXlU?=
 =?utf-8?B?UXhoQnpiVDNHOStreWNxb3hvWDJjeXVSME00MHg3MUlZNm40QUhFL0xudkkv?=
 =?utf-8?B?cml3czZ6Sk80N2pLNmdxdm82ZVVHc2FKUFZqSkR5ZmwvZzZLS3lZOXA1U1Bt?=
 =?utf-8?B?Vk5DTm10RmVHaFhWaVhvcWRoN00ya0hlbWtqVkhqendaQlk1STdwbElTL21E?=
 =?utf-8?B?RW1LMXNJcjNQZWhESWZlYlZWT09BVEZLRWs3SGQwZVdIZmRrTXd0OGJDeEl6?=
 =?utf-8?B?RFZKV21tUXdYTjRQNDRFUDIzVVJKUllzVWRRUm4yMzVEeFdpdG1RWjNXN2xp?=
 =?utf-8?B?Q1dkRXZRMGZvZlRhQnZQUXFLWFYrMGV4TmFTRTlhc3FBd01UZXdFaGkrTy9l?=
 =?utf-8?B?N2QraUNpK0gwb2JMeVJxWWtkc3pxQU5IMWtHMVBac3p3a2xKa0lGdEFyMTNs?=
 =?utf-8?B?L29TMGpaeStMWWJzSTJaL3dHQ2dQNFlxOS9EYWNYQ3FYa3pzMmRieDhFU1Zr?=
 =?utf-8?B?b2wwc3daVy9wZU02dGN2d1I3UzJtcTFnREh1d2VMUUEwYTBDNlNBS01WN2Ev?=
 =?utf-8?B?NFRsTVk0RTdlOW9YUEYxaktVRUtCN25BSW5GL3I2Tm41UnNGNW1mQTVadUtL?=
 =?utf-8?B?NVJ6OGU0NENTaXRIRVVkSjBsSVA5cGNWOTNFZWoxWlNDTmpyWFBPaE5qeGdH?=
 =?utf-8?B?TzY0L20vODBmalU0YTV3S0hLTEw4aEhicDJUZWloMmtraVUvdnJLT0l0ekJw?=
 =?utf-8?B?bmV0eUJJOHJ5ckRVRTlPY1hwaUwwMnpMMjRjVmEveFlYMnBSVE80MUxBSTZr?=
 =?utf-8?B?VmtmRnQ0RUNrQ0pJTG1PWVp2dmdJelZjbzVld2xwWnU0NEJjS3dvM0d6N1Rv?=
 =?utf-8?Q?ltxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUVpUkFEdXdKU0JRc1RRV2VBNWVuTFcrbysvQitVWXRRV1FTcXBydGlZUTln?=
 =?utf-8?B?Sy9LeFRPSW91aFU4Nm1wNVlrSmljNzcra3AwYzFmSndRYnRwaXA2QUZQcEtW?=
 =?utf-8?B?eUg5N2ZwWW5FZ3hJNU85T2RwcGRDMGFQaUk0ODduZ0oxYnFZREJTVm5waGh2?=
 =?utf-8?B?ZTcyOXRtd0hhOFNVUVd0eGJXcDIrSHJPdlQ2ZWh5V0x0RitEUHlWekdOTm9v?=
 =?utf-8?B?WDZBVVBkVEtRNTJVQjl2bG5qWVJBeHg3VmgvWDlpeWg3QnNzZVJRcFVmcjRz?=
 =?utf-8?B?QXdWYlRHUjZyemQwMFpscGpPdG9CL2U3S3BMTUhWMjRFOEl5ZWdlRzgxQkpC?=
 =?utf-8?B?VDd2OGRUamQ3Mm96dTQrT2FkNUV3a0RZanNuR2x4eGE5dTRydHhkY1VyZ3RB?=
 =?utf-8?B?Y1k1dVg5RW9DajczRkI3QjBOVk02Qk85TXdiNCt0eEVISXRlbi95dktIVGtP?=
 =?utf-8?B?NDdqR2RRZnJoRFhsa2NFcjJxZ0hPL0lKdU5PSmRMNGJFeDlHdlk0OHhyZVBa?=
 =?utf-8?B?YzRFYjlnUkVuRXhYVHR1VGtvWHpQRFBnOFc2WUZqcG9FN3RnN0N0aGpYUFA2?=
 =?utf-8?B?ZzdXUStVSGYrcTNmUFFtZCthYys3emczTncyUjAydGRpMXVRRk93MFRhNzBR?=
 =?utf-8?B?ZWFUVkllZmlNSUlWdjhJVFE3TDlTOWJQblZTdEtmVFZGNlZvQWYyMUpzZ0pP?=
 =?utf-8?B?TktvVUpQTXFIL3pXN0plYVRFVTlDVUJoQkx0VnVKc1FoVDdxYnV1SVROZkQz?=
 =?utf-8?B?YmxpeENWVWhvQjU1d1dmZXlGK05zZ1B5MVRWTUVBL1lENTE5YXNBMjQxMXVG?=
 =?utf-8?B?U3NrZWNLNGw4WGI4dVY5NGlpaEsvUGFGUDE5WG5LV01ROHdZYzV4am82UCtR?=
 =?utf-8?B?cVZ1aU5rZmEwOEMyREl3WG55cGd4UTdGNit1dm9hNCtHT1RLNzZILzhFblhG?=
 =?utf-8?B?Q1k0cDRaY1RETzVuOVJxZmx3MWgzNlF5MTJFaWFaaVgzRFNtcTcwT2ZLSFhq?=
 =?utf-8?B?ZnBxSzVxQ2pHQmZWeXp3cDdqOFhIMmYwUTRHM291TE5xV25wOFNxTGVxOHRQ?=
 =?utf-8?B?QjJPMEs5RUZLSUFoNEdvbWxvOFVERUpvUTRFOU1tWlU0eEw4OGdVZytpYnB6?=
 =?utf-8?B?K0ROa1IwMEtWallqS2FBVnVXaWFWb0dsOXBzZGQrN3BydHlScXJ4VUJoL1Ez?=
 =?utf-8?B?TVJPZXQzeDhMMFY0WG8yaTNuZUV1ejFrc3FhdzA5VU1WMnhHKzg0bzhld010?=
 =?utf-8?B?NGhiMUFLa3c2a3FwV0ZUTTlxNDBUL3BpTHFZbDluYjhTZHExV2VkM0hGSEZu?=
 =?utf-8?B?VG5adXZXT09LUUVSM25aSlZvblc1dTJZRUJJWWRYaVR4Njl4bitJQjFBZDY2?=
 =?utf-8?B?Sk9XQlg2bERVOU5xSDZpSml1QXQ1eXY2TDF1U0JtbUtSajY5dmxtUTZoR1E0?=
 =?utf-8?B?dG93WG5LR3ZqVWUxOThJa2YwREh3T0t3OGgyK0hOWllaTDlHeFh1cnBvL0xk?=
 =?utf-8?B?cVNZZWlhbUo0T2F6eEsvYkE0UUM2M0FQL0NMT0ZBdmN5TXNJRERYaktucG43?=
 =?utf-8?B?RW45RHEwbTdMNkpFQ3pOM1FtNWRjZ21FUG1TSkxxK1J1MkNHcEF0ejFzRU1Z?=
 =?utf-8?B?alpWRnYrWkkvNWI5MVhYQ3dtUGxPc1dyVHZSS29xUWRhVnlGSHhFZDZBRDhL?=
 =?utf-8?B?OTlvTXZ5eWZHYXRMemZCeFRsUzl2bGdaMkVrZFBmUExIRkdweUhiYVYzc1Za?=
 =?utf-8?B?TUgvOTZ3OXh5THpleE5ZN04rUGlGTVFwbnpWd1pLY3M1eDZBbzZrWnhsUVV2?=
 =?utf-8?B?RGxJclVHL3drZXpQWEEvWG91dmc4QjYrVmZ5Tk5YQklQdnFmSnBvV2NpaDlx?=
 =?utf-8?B?Nmd5b0NTOXVTVmFDYkx0SzdWdXZPZngvVldSL1NQMCtFN3hna2wxWTVxYk1y?=
 =?utf-8?B?ckNHUGsxMFpJcHh1NkJFSUl1SThOYmg0emFsMGdwaXAzY21WVDM4WVNHb3FC?=
 =?utf-8?B?Y3BiNWlHOGdCTWxBTGRXSnZyRXFnZDd6OXk2Q3RZUjY1anR2NEJmeXlEQ2I4?=
 =?utf-8?B?THVwL3dOdFRKblZzYzEzcjJTbEhqYkRGV2FzWG9Td21GVENSUnZsbk9QcjNJ?=
 =?utf-8?B?Y1ErLzBLQnQ5THgrSWZ0aUJCbGs4aGh5c3lFaFB6NW82Z0QrVHlYT2NpNTJv?=
 =?utf-8?B?aEZ2cnQxQUxRdXI1VjZBMjN2Mm9FaUxiSVViY1hLdm0vSkI5b25ZeTg0b2Nj?=
 =?utf-8?B?SGtoRGZseDc0NEZUdjFmLzJXYXk3c2J3OUpvMVUvd0RpOUhXd0lRaEdYVlFo?=
 =?utf-8?B?QmVBaTQzd2Vzbk42eDZ3UTZqN3M3ejJ0M2ZJWitlS3dreGF2U1BGZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c841209-b220-4039-3b15-08de5cfcd561
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:03:31.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rl/pjjDqnongL7th7pkqxRLQFje/VI9sprqFMtNza8PXY1sv/ICZ5l6K5IYPB+yHiPB/sz94E7/s0iz4LlXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6824

On 26.01.26 17:58, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>> 6.17.0-g970519241701-dirty #38 PREEMPT(voluntary)
>>
>> I thinks 6.17 (which is retired BTW) never received this:
> 
> Hm, xenomai.org still lists v6.17-dovetail2 as latest.

Yeah, "latest" with a tag - hope we get the one for 6.18.y very soon now.

Jan

> I'll try a more recent branch.
>  
>> https://gitlab.com/Xenomai/linux-dovetail/-/commit/65f59eefa1043e9414b37312826de2a0fa07624e
> 
> Thanks,
> //richard


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
