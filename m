Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A0156C5B
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751837; cv=fail; b=iG2i8UM4cwhpbcnslo8gI7rGQnqJaqK6nYBda+cIgOIkx0ksrhaQCFPJSSB5fyqjLrfazw57Q8Ej8NDCOC8hV6yINimSAkKDyQcKId7aWISF06OOAbdp0J0ku7a2Ipgyu0n99vZslskxn7y6h6R9EDE12aEjzgzk/TRreRgaaXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751837; c=relaxed/simple;
	bh=9/6EAoyTikeLD3wxAaU1upu+OGajiw7DEvQN3dKJtNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tykcjp4R3EI9pXJ2BYejdm7NF25jS2HPV7tTvOyRYsW7OPtNQKrvO8a7UK/JAT400qu5jpuO6bmsSARrA7vjwhmomENcYyqAMh33hecYGYZZFc8NLfBPSLYj/wCuQZJnSp4l9QqkK2dx/tQI6/o8GIsCATA/6yBGYLBeGSBWgsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wEUVOkx1; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wEUVOkx1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzQAdIYIl4C8PuJCCB6xJZN4VJzdW7Aw14UKvNBtm+YjSWceCV38DTtK3QFXx3exnDkF6zuL0OnpQfjPXksnHfVL0U3I64MWO1EhWGB8MM0f8irmD1h4OKxTh82mooUSuK9X2t+Rd6Gv2uqK71lDEa49A5injMC13kaLyNWeVL3hOOb5RVdNBpBg28vkb3I7vU0JhLxPt8VOibnfw4I0PUUKEjxYeGPBUdd5zNbORwUgjcCChpDzBD25txYp8hi3M5hvy3qz01dY3sqI00T46VIcetgRepPStpQ3dCvjRh2AE2PJODwWz0X6h8mnhSte388IuRwzhGfA4xvE7QRpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H49NDM7O9WYT0UFYeCoyYraiH1bBzmCz22KJp7IcR1c=;
 b=js3A2NgcafzeXXrsoXQFxk9vyQP4WrsVtwIWN1HbiVNUSlgbmI8dEaNQWJFPO01azZNQHyMYIO/qmBXk7MZeZyXjqDVMWXqku6YOjUpCU5POUQwOyskZIFWwkQPnPx7hzgQKl6/Mooxv++IXUBWSnw3sA0AgxaP7QsD8+ftprZAP13X1RpPR7Kl2u4V0AB/u+U4atCexJr0sHh9wJvZsK1JWs/EyKYopARpDZ8kStOrZfUdQyLas4/MIfK6T7dZNCJB0kJ0rcq0kOShMFfvMAgAKG/kOq5lnVlCnVq32LhRH5+DkZIxgXPdzlxJpduibQHsPMKeCmhxRBgW3JN2rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H49NDM7O9WYT0UFYeCoyYraiH1bBzmCz22KJp7IcR1c=;
 b=wEUVOkx16DkG4PaKmzcDwmz627cZiThFtwxJr6YONJ/IQsupKbuT4A6TbjoRZzzKkfZKSDpMJbMLMLUWmc64udcquB98A3DVhjDfRizcGS8gMFg9e3QPrD+cm5j0KVlXJSiIPz02B9h2iyNW/xduM6wxgoVY9YyeJ0i3d+6a9hRLBsI1jQW/F3/gk28ok+/F3CtkSfi4SVyPfwdVrc7BG2oAOzci/TT1e2mKc5tTv4a3iGbMYP7dy/p5AFMQXyyygDnu1vIZFS8182sRb/Ijb6q43kSx9VB8eXjs5jCo5v0ESWFQUJsOCQdGtfPxFwERyIjsWolAfy/pDgVs06a76A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5804.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 7 Jun
 2024 09:17:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 09:17:10 +0000
Message-ID: <fcc72d7e-6391-4315-8dbe-5079d22b339e@siemens.com>
Date: Fri, 7 Jun 2024 11:17:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
 <87wmn2eawl.fsf@xenomai.org>
 <7a14422b15d534a2a66b6128938e24f8ed08fe99.camel@siemens.com>
 <87o78edytl.fsf@xenomai.org>
 <de1d8749762542e17035afeb7b1fdb5be61107d5.camel@siemens.com>
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
In-Reply-To: <de1d8749762542e17035afeb7b1fdb5be61107d5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 533034c7-fc66-48da-f187-08dc86d29c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGI3dXFYeWZDQ1JmSTdBMVBoUE41eXhzTjFnUkpNMnBNOFNucDFGUnNHdlRJ?=
 =?utf-8?B?MzZxN3RVY3VMNWpwNWphOVM2OEdQZEJVRXpmek5MdjJiWnBKZXFyTm8ydFE2?=
 =?utf-8?B?RzMvM0orY1hpd1BmRTBrT0I5ekQxZ25yaVRCejVCTURoN25QekJyNEJEM2xu?=
 =?utf-8?B?ZER0bHJuM1MrSytrU0JvSU5EVk11NmdOcHJwU3ZHcnY3MC9LTTcySGt4S0kr?=
 =?utf-8?B?aCs2VGUvcXNJRHVqTXFzcE9lUDVZRlNxQ3JOUXZUWU1mcFA3K0FGb2hLV2Ft?=
 =?utf-8?B?eG1VSWNMUG4zRDQ4Q09iQ0xqN1VVWWJTQXB4K0lEYzR3bmtMTUZrN00zcHc1?=
 =?utf-8?B?d1NnM1M2b3dKNHJnMklIVEhpMjdWOXlNS0cxVCtyMWFIQUJtQzk1dzNQQUtz?=
 =?utf-8?B?REFRQVJ2Sks5RzlrRHo0amhxRkJVb0ZwRjFqNDdaUTZ6Slo3VlBhMjFJVHZz?=
 =?utf-8?B?aE5aREQ0aFlaNE8zTk5oenRwYVNvTytGOXlyeHFGMWpSdHVrV2tucldVRXBO?=
 =?utf-8?B?bm9lbThjS2pXRkpVUGxPOXVqQXlIajloZ0Rma2M1NnJ4b1JsSW0zN0x5UGhQ?=
 =?utf-8?B?VkRLYkdIaEx1cVUxV1NlNFdyRGcyaTREYjdYUGRKcXcxYlRVOG9RMXZkelNY?=
 =?utf-8?B?OHhHN1NROWFOMlJISTZ6NnpEL1l3Q2g5L3ljbFk5aEEvM0pXdGlKZHdncjY4?=
 =?utf-8?B?SS9wTzV6YjBkcjlPYndXYkNvaUtZQVprblJmM0hHSTQ1ZmwvTkVWak5MRksx?=
 =?utf-8?B?RkpHcTJDcHRoV2JwQlNuLysyejVTSWJCTzZTNXNlYW5abTdwZ09ybDdycVZ6?=
 =?utf-8?B?b3g3Um5vK3JZQ2FIdFY5UkZKSTBxNzQ3bTJqb2tFaFNxYXNiK2Fjd2NwdHA3?=
 =?utf-8?B?MW1Mc3ZmTTlEaUt1YmY3bTZibmtTeU5sbFdSb3ljbWIzTDJFQnBiNVVEdHVK?=
 =?utf-8?B?d0VnaGRxbzRSNi9EV0FzLzdLTlM1eEpxNVRFejFBT05lQkVjMS9ieFRWdkNS?=
 =?utf-8?B?ZUsxcm5FK1Q4OFdiUTZqYndEUzBzaFVMY0VtRTVVMXNDTFJXaHg4SUcveDlG?=
 =?utf-8?B?NzZBa3BhcExKcWExWmZwY1VqcFVLdUN4TUtQYS9JRDk2Z1lrZUZmYUVUUWlG?=
 =?utf-8?B?L1FxWk9MSXV3dXY1ME1pUGJsVXJMd2Y0WmF6eHJ1dW8xb3d2M3llWGVGaThu?=
 =?utf-8?B?cUtPcnBSMHlTdkF4RzEwdWxhMlN6WWVxQ01RZmFsVHQxSCtWNGU0Y3FvMXhl?=
 =?utf-8?B?N1RGUUx5K05OZnErU0ZYY2NzM05rWkxBb3NJNUk0WVNwMW9GOXdWbFBYQlkr?=
 =?utf-8?B?alF4ZXhqaHdudG5GaTRQby9SQ1lMM3NXdGt1RXZOMGROWmRNRFhzWFJWbkQ2?=
 =?utf-8?B?QkU4TzNLRFZPTm9FUFFVWEovR01OS0lEaWMwNHVkMlNMSHRZb0JjRExVVGh6?=
 =?utf-8?B?UndFNkM2ZFRETmgrNDA4dEkweHoySTdkMWpZeE5rbXlKMHBrYW1mbmcwdU94?=
 =?utf-8?B?alFGU0dSMTAxWm0rUnZpbnNIYmRSd29JYURqQTB4Ykc3czR1bFpQV0xlc3NZ?=
 =?utf-8?B?N25nNW5iNWZZNGJ6ckwvWmhoTmd0ci85SkxpSTlyRnMxVE9vMmxXdTFXNVZs?=
 =?utf-8?B?Rm5oK2VDVnBXQlhyRFpXYnplQS9UWHRPWU5vNlNNR21BNWQwcGVtMkhDNUhB?=
 =?utf-8?B?UHd1L3o2RTVnWmVoMU42VjB1MXNjZ0hKTS9Vd1RhUUptQVlleWJBTkFTd1h4?=
 =?utf-8?Q?LSzURslZCtpxVuK8zmdTAQivx2QFB5U72W6HmCt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhoODA1YW9ZV1dTOEFqa04yaTVCL0pYM3FlbE81L2lPcXVOdXBWL3ZUVFJN?=
 =?utf-8?B?WEl3SUVkcUczTXMyN2RrbGpWMElSUE5HejZrUXQ1S2JkZHB3dDZId0NTWkRl?=
 =?utf-8?B?aHJLNVFnSFBJVkhCZXBjK3RvTlpZLzlQenBvL2xoK1YxSHkvVFR6Q0dYcGdR?=
 =?utf-8?B?bnZwNGVoNVZ2TEhtdCs3SExzVUVtUlZBNWJoNHR5S0dTdXhtYmE3Z1FsSUFN?=
 =?utf-8?B?akdHN0RjQTQ0cUFOOXNiR2lieEhaVWhuR2ZqeFJHY00rbDRwZXpIQ083N0tU?=
 =?utf-8?B?VnB4QXQvTTNXaFJ4dHhSeEFza0dYeVZIVnI1N2dDK1lUcW4vQyt0aU5oNlkw?=
 =?utf-8?B?aHJOUitRc2o3SkFEYzFYVEJobHRkcy84VWk5RXB5bDVLL010djl2cGcrejNE?=
 =?utf-8?B?U01HbnRQODFnUkRTN2VROXU4UUNEVHhqU0thTGFMS3dVMnY4aitmU0ZUNDls?=
 =?utf-8?B?Y2pMb1RGUEtWdnRZNGJuRWg1elU0a0dxVnMvVHpjbGw1eUVURC9XYW1PVWZ0?=
 =?utf-8?B?bEQxb3Vrc3ZwQWhia2FzeGtGaFZFZ0dUbTBHNWZ2UnNOMTAyRXArUnp4RzFw?=
 =?utf-8?B?M2ZnWGZxellRU3BsTi9PVHdqZzRwbWdlYkNqRklIL0F4b2xRQlZrdTJFWnk5?=
 =?utf-8?B?VGl2ZDJXeWhheEdwcitoajRTNHFYN01MdVA5Ykh1UDRIOG9xd1Y1ekRGalJR?=
 =?utf-8?B?SGVudHIxVmowc0VRVjVHaW56VExVRTlVVGFCdTdYQmxydnQra0IzeE1xdGNq?=
 =?utf-8?B?VkhRL2g1VWFrSW9QR2RPNFdWYitQSHQ4MjZuYjRENUF5a05TRFBJNXlQYStE?=
 =?utf-8?B?TVE1SS82dFpwWmNkNzIwWlhPdUxsQUw5cjMxNjZ0N3VBdEZvbGZRUVBhQkdK?=
 =?utf-8?B?WldjSUFFV3l6Q2dJL2pxVzhtcHZpa3llc1BHcm81U1ZnNnJWN2lSbTJMVlRZ?=
 =?utf-8?B?R0xGNGx5UG8xZEhsemc5ZjRvZjZIbFVvN3BwZG9ocS9MbEJkbUpGNU9TMVhG?=
 =?utf-8?B?QThOWXhtS2p0UnhyTFBidTVXdS9KdlVyaDdKUkNNZ04vczN6NUYxbHpTcDkx?=
 =?utf-8?B?WTBCdjd5UFNCUVFTL3QzbGJRVmFxUzJ4dEpPKzdHU1pIOEFaMkFCaWxIbHpU?=
 =?utf-8?B?NnZaZk1XWUxRQ2JJS3hWT2ZOb2hSbFNuRFNMZUNTYjBITUhOdTRvOUJjR0N0?=
 =?utf-8?B?b2FVU254MnBLeUJVenlzNmRqUG01Tlp6RHZiNFhIeUFtYnBTbUx3MmxMeG5h?=
 =?utf-8?B?aEZXTCtkSXg1WXBDMGhTWDJkSElwUUdVL2p3aHgrc1loUFFQcTdydjVPRGpV?=
 =?utf-8?B?OFZGL2JCb3dseXlmRmdhSUhKOGFHTmt5c3E3a2tCTk5nZG5LdnU1Y1NhZVRh?=
 =?utf-8?B?Ui9YY2tYWGMzRGlacWpnZDNWQzVVM0VxVEhMekJZWk41ZGNnVzhJYnh0RHBW?=
 =?utf-8?B?VS9ZR0hLOS9oRW15cm5DcTU4VExEeC91NXhXMjBwYW1EU2FMMmR1OE9ianBp?=
 =?utf-8?B?Q2JqWWI1NWFWME93WlY4bDJCMm9weUhIVU10YlpPazJoTnp0YTJFTHFqeUdI?=
 =?utf-8?B?emltMzVyOG0rbE03anM5VkthRWpMVUxMbkV5ZER6anIxbjVyZXM4SWEya3c0?=
 =?utf-8?B?ek1UeituaDRCQmpuQ2k1Z0VGbW82NFJYSUt6VUphdXRoUGlSTTRFWmE1Q09P?=
 =?utf-8?B?aDZvY09KTVRzWDZDNkFMUmVua3gxMWlzczRQeDE1WW9naVZGdDI1eWJTL3lW?=
 =?utf-8?B?KzRsemsrYmlrVG01SkNzT25OK0V4TGhQZkpWUng0L2FOWk5VUE5NL1pkejVl?=
 =?utf-8?B?M0hwQ1BsdC9YWkFKVUVRR05zTFhYZDRpdnVQeGlaTnhyZkt0RG5YMDI4VG12?=
 =?utf-8?B?MWVLL250Z1N0K3ozTnRVNkRBaWFSSjFLa3FudmhmMFNGcEZhQ29iVmIzMmdy?=
 =?utf-8?B?Z0doZ2JGWEZlbEtReDA1UFZiTm4zTkVZbVRnZGZyVW1HdWRnZjlONEY1UnpF?=
 =?utf-8?B?SG05MjVQTUVjbTFOcGhFYjEyYWlEK1k2WkFQVTNwWkJueEdpUVQxMElWOUlH?=
 =?utf-8?B?NTlDdUwyTDFLU08xTlF2NWlGSytQakpSS1BFMHZDTXBNMHZKMUY1QmRPeFI5?=
 =?utf-8?Q?L8iIs+Xg7RNcpiGehLfzEKVYe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533034c7-fc66-48da-f187-08dc86d29c39
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 09:17:10.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my/5n0yGViYXMChCHbRVb/HlxfP5jrSe51iAUQSAAYOcImXCQob8JuvyFeXddG0GD7bVvtX6npgf91/MtDO3+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5804

On 07.06.24 09:37, Florian Bezdeka wrote:
> On Thu, 2024-06-06 at 14:42 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>>> On Thu, 2024-06-06 at 10:18 +0200, Philippe Gerum wrote:
>>>>> When running over an OOB task that is currently owning nklock, we will
>>>>> release the lock unconditionally, leaving the task "unprotected" /
>>>>> unsynchronized. Right?
>>>>
>>>> No, the only way for a task to hold the ugly lock safely is to disable
>>>> IRQs if it has to compete with an IRQ handler. So this scenario is by
>>>> definition a usage bug on the application/driver side, not on the
>>>> infrastructure's. Meanwhile, the _irqsave() variant prevents spurious
>>>> lock release in recursion using a special marker in the saved interrupt
>>>> flags.
>>>
>>> I just checked all nklock usages. Most of them are indeed using the IRQ
>>> safe variants. But:
>>>
>>> In xnthread_relax() we have:
>>>
>>>     splmax();
>>>     xnlock_get(&nklock);
>>>     xnthread_suspend(...);
>>>         xnlock_get_irqsave(&nklock, s);
>>>         xnlock_put_irqrestore(&nklock, s);
>>>     splnone();
>>>
>>> As xnthread_suspend() is using the _irqsave() variants, it's basically
>>> a noop, the recursion will be detected / handled correctly.
>>>
>>> What happens, if right after splnone() the Xenomai timer tick is
>>> handled?
>>
>> At this point, the current task is relaxed and does not hold the nklock
>> anymore. It's been released by ___xnsched_run() <- xnthread_suspend(),
>> on the exit path.
>>
> 
> Exactly. Thanks Philippe.
> 
> I think I narrowed it down to kvm_wait(). Propably it's not a good idea
> to enable the hw IRQs unconditionally after coming back from a vCPU
> kick. Testing ongoing, maybe you can have a look as well. 
> 

If we ever enter kvm_wait with hard-IRQs off, they must not be turned on
before, while or after waiting. Maybe this condition is simply missing
from the implementation because it assumed to only be enter with
hard-IRQs on?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

