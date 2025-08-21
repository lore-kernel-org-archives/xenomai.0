Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57B1F948
	for <xenomai@lists.linux.dev>; Thu, 21 Aug 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804410; cv=fail; b=B5byI5mQmY6MQOarR9EChUtCGiN2bkY5STc3uP6ARLDxq+T6sARA75AOmvkvkdHm+QqfDFuYeHM9FlSz0cmhPAWGPHDsEa9fe0hGYhYyYpjGW+B57WuldYb0k4q5yMXnqvp0YvYPIpa0XbuvXBjzkayKEmgoiVxlIyVRwv094i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804410; c=relaxed/simple;
	bh=vW0C/iSqG2CrJEWJmwS7H2Xt3aV7SkEGADlG8pkNof0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JdUaS/C2a1A/snB7RwC9maGp4XA4PzLSmTL6SYN8BXbBmpzOF2eTVgyF7V1eISY3Sv4H0gUwotQCMNfXXqhABLwm3tpXM0AtWKsAM8fBePviyeuqk2F68adOmqeNoyPRRIM0tKUK9k1PqyYkEMwAb02m/UiMFdo9K+TEpjanRxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=otdMRubV; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="otdMRubV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhSjn18ZZaGW7GwHxM1UKKN31KCDSqa2UifZwPyWL9k/QSWQdYNy4p/5vELvv/jSnWFq9XXEQ8tXxMUXks6QiGpfdQOgOqXTg7VudjJXPH2spArU4U4YgmqA+ra+hA/qcYr7iurWMvLdxf7pbJGPH0y42FnRWsFmgJvyCWLyb+bqeZIKxhc07lhhyghfH9V2im7TqobxHl+6wSGa8PRtk/z9BtPz1u0hd8y3xKU04kzvV6BUtUfgUDYdENUugMD587P9vf184pJJV1EVLYUzCxXOVzJmgqsqbUQzKJxX4hA5sPb6MwhCCbEGrLCQkvKp5X4738w0eua1ZknWsvhJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=komFsLlpT1mYimFJKQiLzHmDhIQBDYXx9alTIGc9maM=;
 b=MwrJ3Cb/oY8eCZFUMseov9Dowrgwge8saFoJba3uGRlyphe16pvfUSZpnmnJQU1FLwctea742wivodzy1zv8EKAoKrgBBwqF1Lv0h2j16onWY4AJqHVM47sxj/fXcIVdhlaCmuSD7fGbX1H2AWyWx2JdIZdPfQaZNN2tPKK3+hWtNgzEd2Bw/QEqIou72vUlt8ZnnNBkXHzdCn32oe6Sf1u0yeV0Sc6/WcQhF3KOO87Kw0XearaxTw5vVFStPDSrACpYPPOUwmHVupg7dpl4rrMhdmZrjpIFv4ISZxPThqLBurXxN4dskEmnl1XVlMabaxrZsSOyT5+k1xKYYUYGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=komFsLlpT1mYimFJKQiLzHmDhIQBDYXx9alTIGc9maM=;
 b=otdMRubV0P6+/7fncVmzoUkK7Ma3wKc+GQdvQYtwJWcft271ZA4wOEMEIfFmLOS9Kt7HENrN4ZiUlgz3GZVkVuHhsU+niZmne/aXmcKpFmyDVo2x8kCujqXDcSF8yzw0agFGwEQ51tOfjJ4539LqDjH7TbPSKot1GIZ5VuZH68jO2wP93PVhxHiGl+gIo4RfOcY4sR0END2HXRERrNSDdVCilNBg+YxDZFrAACe/2urV88//iO6L4strTZyrB+Yz7q5VuMwTVLwXP9OOkVJjlWWNMnvn+SE+uA32b+kNUW9k9Yn945doL1V5lUceZAe8f4dUcAC+YB06URdmGBAg9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 19:26:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 19:26:44 +0000
Message-ID: <24d3ca0f-52c9-4d82-9ffa-7ceee81c8ba8@siemens.com>
Date: Thu, 21 Aug 2025 21:26:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Replace obsolete AC_CANONICAL_SYSTEM macro
To: "guangfeng.wang" <guang_feng_wang@163.com>
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com, xenomai@lists.linux.dev,
 wang <guangfeng.wang@siemens.com>
References: <20250720142542.12859-1-guang_feng_wang@163.com>
 <06d7a9cc-db46-4c4e-bc62-a0c3b6d48c80@siemens.com>
 <1fca7b9d.9ee0.198cdd3d09f.Coremail.guang_feng_wang@163.com>
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
In-Reply-To: <1fca7b9d.9ee0.198cdd3d09f.Coremail.guang_feng_wang@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcdc150-4652-479b-d925-08dde0e8a9fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDRJU1A2QWZDOUpaRytQSXpaak5wcUNsTkRBYlUwWXVWT2tpd3R5bXlxMHY0?=
 =?utf-8?B?ZTgzNk0rU0ViK0tEZDdMZ0FMZXBqeGw3Y1pLbktUeHpaTWVNYVFtSTZ2cEFZ?=
 =?utf-8?B?U2NTQTg2a3RHeHlaK2IzZmpGRllGdlU5NG1OTnB0aktLb0JMdmhxbVNVQnNY?=
 =?utf-8?B?cGpTclFGVVB4MXdvQk1KQUNvN1ExMnRyYXZtRVZnTGhSdXFzeXVFR3FPUm5x?=
 =?utf-8?B?Z1F4WjIzMURxWHFlblliVXhqRjZTdFRBREVvK2x1M1RBWFkyT1prdkw0THAz?=
 =?utf-8?B?ZG5VZW5sbEJVSHEwT3dPcjdJdEJyQjg5TXFjcG0zcHh0T0VqeURoY0wwVXFX?=
 =?utf-8?B?SFJSR1U3YTBYcVJYY1RtUkVNTWJVa0R0RmkwdTBCTkNsNjZGUHlNYy9WbEcw?=
 =?utf-8?B?Snljb3FXbVlVekxOK3ZhaG9xNWtsb0NvS09DOFdUclBLZjMzNHVmUDVyWWgw?=
 =?utf-8?B?QTlVN1NFUUtDdW1NQVpPUTh3M2hVN2lrVmI1aWJJb1E2YkZmNXh1amhrS2xZ?=
 =?utf-8?B?a2h4RG1KUnU1ZFp6Rm8yTlNQckdiN3ZQWkZmU3VhTDhWWFU0dDJhMms3WUhq?=
 =?utf-8?B?TDVKeGx0eDZzQktIam5sM0FZbzAxMUtjMjVNNmRqRy84ejJFWmNvUnpMY1o5?=
 =?utf-8?B?SDIxRDloZElCcUU5SVcxZmRPbTlBTlR3K1J0Ti80SzRZWEVGSWJNVzRmTkYr?=
 =?utf-8?B?eEZ5M1NMcDBNQkUxeG5pd0ZJNHdUVVNMT3p4WnlyV3VoRHd1QkE5K3c5V0hR?=
 =?utf-8?B?dXdXQjNENXVqWloxcE1DVXRwbC92NWcxQjJTVSt3ZndROFNoUW94SHN4TTJo?=
 =?utf-8?B?ek9tTDZseVNzTHFhUGpsUmdOaVJEZmRSVEprNUFKQ09COTRRMExHT3pFNVBu?=
 =?utf-8?B?UGc2SDF4NlJZM1Q5cWU2VGpab0ZnNGtIbkNkck0wOUZHMlZkUWVycjVPeXZM?=
 =?utf-8?B?NFczZ09yZFZUa24yWVBobVJCTXl3U0VrdG5TTGxqM0xLVDh0ZTEvc2ppV0tt?=
 =?utf-8?B?MmJwQThQOTIxaHBTZEFDSjhsTGJ1cGxCOFVZSmZmVlZXMmJPMlJLTUtDS2Y3?=
 =?utf-8?B?cURXVCtSRHJFL0dic0FmaElocWkxdU9SazVOck0yU0J2bm1taHE3RE9Pcy9w?=
 =?utf-8?B?b2NxWmpzcDdsbXFzb2Z6a09VZ2FrZ3lwZU5TLzJDQjJ1cERMQ2x2cGVGUHpw?=
 =?utf-8?B?a0hPRnpvQWd2SXRia212VkpyY2tlM1FITzMvRHU5UDRHSEF0eWVPSHVrS3gw?=
 =?utf-8?B?Y3hNSGh6M1ZoVVo3SFVZejVQRnVmV3NoOFVLME9FYjVUdG9GZXo2WFZ2ZTB6?=
 =?utf-8?B?eEd2QXhUVG42Z09wUUwxa05SOHpsd0tVdzFpdGUrMTMxQ0xMZUpYS2VVTjlP?=
 =?utf-8?B?NllsY3pOdnFvQ0YvUWY2eSs2YWZNL3RlUUNteXpRd3Brc214OXBkUm1MMUFO?=
 =?utf-8?B?YS8rTWhla0pHWk5qMDFrSE01ekUvajFjczF3ZDEwbmhxWUt0bTZ0TzY3eERa?=
 =?utf-8?B?bkU4THJsTU1OdFhjQXhENjFzdFBjTEt4Y1BRZ1pCOVM5eUlnaDQyVWhoWmZR?=
 =?utf-8?B?MXk4TGdXMHI3S1I3Yzk5TmVWR1MxcytwcjltM2Z3Mzk4TEZBc05haVZHUmpo?=
 =?utf-8?B?YmxjenQ2NjFKd1Y0dTduZzFYY1Nyb3NNamQwa3ZOL3JhOEx5VzhnZXlxUFhn?=
 =?utf-8?B?ZjcxM3VYNUo4UXc3ZUZ5OXVKMmNPMUlxcGp4Nmw2dU1jd1ZnQkdBSTlnWUha?=
 =?utf-8?B?UldnRnJpeFRCN3RlVTh6d0REWFByelFUcUZYQTYvU1pPNjRlOHE3N0ZPWUsw?=
 =?utf-8?B?NzRCa1VYUUxLcTJVVUR4ZUVmSVBiWm1rK29uMGtTazl0bUovcm43dmRicTNv?=
 =?utf-8?B?bGFmV2ZTSjdYNm5mSm0ySGtYcDJmYnloVkszRWtNcTE1L1NidE9iWVpwbjJY?=
 =?utf-8?Q?RRaZxtZFSIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THp4cDlqSE8vRmpWdWUxMHhwNndsem1CaVI0U1Y3OTd6endqZ2dTVllCejR5?=
 =?utf-8?B?ZXBVU2MzTzlLTzFQRW9KcDQ3RllmTmdFUFpieEVlcnM2Ym91NHhaR3RRYndQ?=
 =?utf-8?B?TGFmdjNNQi9NY2pyZFl4eVBUeHVHMkdINXhhTFRKMCtidVNwVk5VME9ib1Bm?=
 =?utf-8?B?b3JFTTRpWTVqZjMzSjdWRGljc0NwaG5IWFBCbHcxWFpYR2twN3hJbVo0LzNN?=
 =?utf-8?B?VVFKaG5Od0lUUkFJZndKNmVyUU10bG0yYUFjOUpycHBsMzlIRDZpb1JqVWtL?=
 =?utf-8?B?Si9rbmdhM2k5KzlmcTEybkpyckJpKy9tL09IWDIrL2hwNzNnQnRUYkJya2pU?=
 =?utf-8?B?SnhyM2RaWW4wOVp6aXNBNmxQdTZMOEplQTNZNE16bTZWMTI5bTJLeHZOQ3Bt?=
 =?utf-8?B?bDR2YWVpZTJMb0Z6eU9nc3dpNklXZXoweThoT0RjZGhubEZOTW5HT3F3bTMy?=
 =?utf-8?B?SXJobjBnY2VMWFZkemZFZkNQVTZQQmZWSm8veFptL2lhT3lUME54YTYxbU40?=
 =?utf-8?B?VHBSdFVDdUZuVzg1dUlGNWdISGpOdWQ5Q3Q3aXFocUJCbVFhQ05GTGc0V3lI?=
 =?utf-8?B?L3VRRnJNS3FxdmlmTTRHSFRuZHloWklCTStOY2hNU3FDNHZuWmgrVm1UeElL?=
 =?utf-8?B?OUw0SE91enliMUJHNG1OeEJGOVJXRXVGWWVJVmFmUThlS3k0RFFWa0JVcThG?=
 =?utf-8?B?QnREeW5TTTV2eldaZFhHWHFTd3JDUnNDN3N4K2RwQW41Uk5NSnhxQ1lpQ0s4?=
 =?utf-8?B?RnpnKzd6V2VJSmMwemdRUzcyQ2M3eWFRZWRrekY4eTdZcVJVTWRBK3kvN2R1?=
 =?utf-8?B?WVVjNjhBaGhqVi9JUUxlNGhObUFQb0xGMkpJa05VdmQrTzhtL1VCUWEwSWNt?=
 =?utf-8?B?cmo2a0lpa1I0cTU4RUN3cVMyS1Vza0tKdFlZblRhUUQzdG15WFJaSUhtL1hH?=
 =?utf-8?B?MU0xYVI0WG5vMVE4bUV0ZG1CbTEwNW5uQXpWVVVwRVJRMFlOVGJnZGQ2bHE1?=
 =?utf-8?B?cVFmNWI5V01EcVpwQ2gxUWgyZE4yN2hvbHF6Q21CS2hST3VUSFJEK3g3QWdy?=
 =?utf-8?B?UVpreS91RDgvK09KdG5UcElObHFVV1haUUNXUWxwYzV3TVRUejh5MW1lTFhF?=
 =?utf-8?B?Vm5DYWZJTnBseklMNVA2ZDZrNmZUZ29qOE1ZUUV0ZDZkcGRWMjF4SThiTnht?=
 =?utf-8?B?RzFHQXIxZGRpbG5aL01tK0VMNHh2NUMwQWtUdEhpV01TM0tjcFZMaC9raW1T?=
 =?utf-8?B?amp2c1Qwa2htUExvSkNTUEFHMnM1dnV5bTRkQnJFb0dpaE9xK3ZvWFVsS1hW?=
 =?utf-8?B?VWxPS2k3bHFwdXE3TzRscVlVMzVGYStxR3l1UEIrYkFqL2NlZ3E0Wi9wNHUw?=
 =?utf-8?B?Y2t3Ym1Gd0YrYnZxOCsxa1Jqalc3cG9JZ3dYWE9zajZSR0Mva1pKTHFEOExz?=
 =?utf-8?B?WUR2YkVoR2pKSFhrcWVJb05oaVFKdmJ6RHFzMnVZbGRjR1p2QXVPQ2lzaFdK?=
 =?utf-8?B?aGw1eWl6a1RoKzN3aGhaUG1CTjR3ZjlHSjVqSm9rdUo4bHd0dEtGQnJzMHla?=
 =?utf-8?B?eVlKcjBiZkVXcHA3WFNJNk5Fcm9rK0dqVFNFOTVnTUFXQ1FrZzhCRjhWcERU?=
 =?utf-8?B?dGRyYkhwUDJVMzVGaExDTisrMllWMjlITkJtVCtxQTlBbldyUDhOZWUrZnJq?=
 =?utf-8?B?T3phRVI1YmR1TUxNU2JRY2hWSGNWbis4RUZTV3d4QlpvcnRINS9LTjEwamtS?=
 =?utf-8?B?d09JVXIwU0taekloQ3FTdFoxL2lreUVxYnFoektxMmwvSnBGVnYyMUwzTHkw?=
 =?utf-8?B?OGFKR3RsN3c1UEhsd292SVFBajNNOTEzUWpDTitTY09MZU9qRGx1ejhONzhN?=
 =?utf-8?B?SW1wVGlhUmVXSGxpRldOc2g3ZS8zVFo4WGpIbHNnL2tNclhUbXIvbUFZR2lF?=
 =?utf-8?B?WEFUNG9HcHhYMVdhRWJ6WkVYdyttYlJVNFBMcmJxK0JiSUhzSVNjditieEVM?=
 =?utf-8?B?eWplNmdjYXo3Yit0WW91Mll4UCtJWHNBdTNrSkdtR1AyZmMzY0xBd2pyTjhQ?=
 =?utf-8?B?elNheGdWRDh1RGxENnEyN0lJR1JSQ1JTVTUzZHZzQ0VNTk9MZnZha3ZHeDZZ?=
 =?utf-8?B?ajQ2YVBxZjBOT1k5OXV2NGZ6cXdpWk5VOVIxUHByOGJyS3ZMREFlS0NZRVVD?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcdc150-4652-479b-d925-08dde0e8a9fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 19:26:44.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dze9HYPesJd9M1PwdchhYZLvlqCpuzWFrx7TXoXqEawAeA2BOxzbKMty536yFoInBFNqDYlGZUxcthEk0At1lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8834

On 21.08.25 20:11, guangfeng.wang wrote:
> At 2025-07-31 00:47:04, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
> 
>>On 20.07.25 16:25, guang_feng_wang@163.com wrote:
>>> From: wang <guangfeng.wang@siemens.com>
>>> 
>>> The macro `AC_CANONICAL_SYSTEM` is obsolete and triggers warnings
>>> in modern autoconf.
>>
>>Can we define which version of autoconf started to trigger this? And
>>where it is printed? I have 2.69 here e.g., and it remained silent
>>during scripts/bootstrap.
>>
>>> This patch replaces it with the recommended macros to silence
>>> these warnings.
>>> 
>>> Signed-off-by: wang <guangfeng.wang@siemens.com>
>>> ---
>>>  config/ac_prog_cc_for_build.m4 | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/config/ac_prog_cc_for_build.m4 b/config/ac_prog_cc_for_build.m4
>>> index 8cba24927..2c78c3f6b 100644
>>> --- a/config/ac_prog_cc_for_build.m4
>>> +++ b/config/ac_prog_cc_for_build.m4
>>> @@ -5,7 +5,9 @@ AC_DEFUN([AC_PROG_CC_FOR_BUILD], [dnl
>>>  AC_REQUIRE([AC_PROG_CC])dnl
>>>  AC_REQUIRE([AC_PROG_CPP])dnl
>>>  AC_REQUIRE([AC_EXEEXT])dnl
>>> -AC_REQUIRE([AC_CANONICAL_SYSTEM])dnl
>>> +AC_REQUIRE([AC_CANONICAL_BUILD])dnl
>>> +AC_REQUIRE([AC_CANONICAL_HOST])dnl
>>> +AC_REQUIRE([AC_CANONICAL_TARGET])dnl
>>
>>Do we need to list them all?
>>
>>"The user is encouraged to use either AC_CANONICAL_BUILD, or
>>AC_CANONICAL_HOST, or AC_CANONICAL_TARGET, depending on the needs. Using
>>AC_CANONICAL_TARGET is enough to run the two other macros [...]".
>>
>>But we actually use AC_CANONICAL_BUILD and AC_CANONICAL_HOST in
>>configure.ac.
>>
>>Jan
>>
>>>  dnl
>>>  pushdef([AC_TRY_COMPILER], [
>>>  cat > conftest.$ac_ext << EOF
>>
>>-- 
>>Siemens AG, Foundational Technologies
>>Linux Expert Center
> 
> In version 2.69, we need to add *-Wall *or*-Wobsolete *for the warning to
> be printed. I checked my Autoconf version, and it is 2.71. Some warnings
> are printed to stderr when the macro is expanded. Running "autoupdate"
> can automatically replace old macros, and most obsolete warnings can
> be resolved, but this particular warning is still printed.
> 
> Starting from version 2.70, this warning is enabled by default.
> Autoconf also provides a "silent" parameter to suppress the warning.
> To do so, change the code from：
> *
> *
> *AC_REQUIRE([AC_CANONICAL_SYSTEM], )dnl*
> *
> *
> to：
> 
> *AC_REQUIRE([AC_CANONICAL_SYSTEM], [silent])dnl*
> *
> *
> With this change, the warning will not be printed on stderr.
> 
> Yes, AC_CANONICAL_BUILD and AC_CANONICAL_HOST are enough for native builds.
> I have tested it, and the warning wasn't printed. But for cross-
> compilation,
> AC_CANONICAL_TARGET must be used instead.
> 

"Using AC_CANONICAL_TARGET is enough to run the two other macros" - so,
shouldn't it be enough to ONLY have that one then?

Jan

> "Macro: AC_CANONICAL_TARGET Compute the canonical target-
> system type variable, 
> target, and its
> three individual parts target_cpu, target_vendor,  and target_os. If --
> target 
> was specified,  then target is the canonicalization
> of target_alias by config.sub, 
> otherwise it defaults to host."
> 
> Refs: - https://www.gnu.org/software/autoconf/manual/autoconf-2.69/
> html_node/Obsoleting-Macros.html <https://www.gnu.org/software/autoconf/
> manual/autoconf-2.69/html_node/Obsoleting-Macros.html>
> - https://www.gnu.org/software/autoconf/manual/autoconf-2.70/html_node/
> Obsoleting-Macros.html <https://www.gnu.org/software/autoconf/manual/
> autoconf-2.70/html_node/Obsoleting-Macros.html>
> 
> Best Regards,
> Guang Feng Wang
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
