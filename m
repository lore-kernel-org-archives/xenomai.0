Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04D389DE8
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511312; cv=fail; b=iGGakd2+WuXFO+5cMGD6KwnIIoldWDV7ph6m8DXxCzBG1hYsprPIw7gdmnr8U4J7DDnclc/klwmqdnArD6VFklTSMu7gBCNEWGfcpRTpXK7mfE58KVyJAjU/eBkt5j85kTqOj/HqRUBbAR556qVu/J+yfhDTro/mmgeI/BPU6AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511312; c=relaxed/simple;
	bh=YQ3asEon/Tqdk/51GSqZl2JMeN1Y1+s5lX4A+twiroQ=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=dTgzkz4suzy6MJCN872gv7paqGrWUU9A2JibemgFbRPojF5B1jZTl0AoKUk3QJOVbtG6csiKSaAK3Da8Cxxf/1lOjkz1C5wt7ymwAoRcqhHmGZmf0C04VRgqKhPgIhgYHC5iHlcuKED8j9vYvnmtwwalCuPz5EI7PPASeHVLbF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TDIjCrZq; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TDIjCrZq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG7exWVnfQjfglTcYrnAWCeM75v1g1/JYgKqdFfDoXxp6xPsxkzwXoPZAcR/z+rmyKNHBUnNIUNXyFrTczy9HNwEBEIBpgPzw1Wq/CGg5uYcKZT+GNBI7tj4RrUA31fh+BLT0TExPcZ6eaxnl2Gq75naU62e7ft4suS8HjG/x3JUtBvAWYUqwnNQftWxCb/FnJWaz0ndmqufJz8L1Ppy1NDq3SarU5FzWYhzHvU7gJhVoFtGQmCvEdOw8A6GnX9H9U++bosymcdUmumdU+VvCB/6EpFH0Axf3a0M7rYfVx4A1L9jHTautLzKu+BDl+KCw45dTX9a96NFY8qn4XlZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQVPPuM3NCHif6YY6q258qoZz12zpfo+9njX8UNYBdU=;
 b=Ji3cxBhXkoGs49Y6v4+FezEucMYB1kyLiHIoetepsMGtKC1RgACwQuE1f0//+oVp9+iqW2vTGgjWDKlIWIhpyaAYuOk5X/cV+7IbSzwZdoTWoe8Ul7N5ZG3IS5lNuw7zPVPHQ41T+r37y9iR/9mc//DE6eFzG8dZuBZVQPKXFJWUOmk2cj4FFFELb3Xdjeas5c1OW7D/QHLqYN5C0X5f/0Ombkd+tMyNxsPRE0PiE/orUuGmzT1fKfEDfGF7sQSS1zgNkDXpQnenPi5XI4rHXh8gHvTaFblGp34SZD+xpfaxUP+dKcZ4X6dNmxFka4vzQ2Al5rhUEqxeNc6AC36thA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQVPPuM3NCHif6YY6q258qoZz12zpfo+9njX8UNYBdU=;
 b=TDIjCrZqym48iCNu/GRLb8Ep74dvlY8mx6Lt5Ncw09objjcIJz4gSAeZglALCXq1NFJHns2zx4HdpFXCeXY+EtRAGGEPn1Nmvj1LL7x3A77skFYqIrz1i21+j2gxy0NyEt1BiL53lIksTcuIwRa4ym3BlKRxnPhczVK/VC/fXustb2VGuwQBEPG37eyEfYN4HyG5BuicXnEc3e0q773rK1T7XcOBGZ8/GbFpMSbxe7wZ9KBli64wg2FMI3wmBLyqJoIQYIwH8O5ccDqWRXm6qd42vUlyE07IkmIADDQSf6/ictt7zsjueGjUku+CBU1gRM7CVOfBQTM7ImMdQh7bVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6352.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:553::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 11:48:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 11:48:27 +0000
Message-ID: <88c8d881-af3f-443d-b399-75d43575bcaf@siemens.com>
Date: Wed, 8 Jul 2026 13:48:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] lib/alchemy/task: Drop EINTR from valid return codes of
 rt_task_suspend
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 561ab6d8-bbbd-487d-77ce-08dedce6d31c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mG37IRV1I6otKc0E3gCk48OdyI/dXnyPxUKzZYLHJF5gvXctooot6lCoicP5WhfKbAYGHQT1jF23Rrlz046hN5F20gd9fcnYiRdGxST6QY1wERC3ux59dVpRqwYmYCAn+YoPlJWK0X0HXSprSd970MEGBjhGy7nq4EhUgxCniOUvh5qJeC/tyMWVlmubQ6xnFpA1kSCWpRyZw2JvFEuGS/KVTvmj3feeIagTm1fgFvPIm1+CxaerA72EKDBT+QC+uo66q6i6k9o1vD0VVRzDgK8cOH0zkL3gQPLQB99lG1wLbBFMxOqrf7OCJvJLqJp4MSgeZ/PBOvGgNtzjc4G+HZb18+TUTn0w09ei+ZO4pb2pvzqEcPOR27AtYWb9dNPW0uCEI1mEdFNfi4qdUVZ5XlUd+Jj+tqaKy1AiBP/MBRatw9elXzI39V/F/Z0XEMLScSOYwP+blA2jMScXHzTX91s7HbmyD5QDanDzyy20nRhBFDpd3q0H6EzpOt/aRvdbBBmrtghoy6PN6G158CG3+wjuDDUS8UXELt7WoLhmlz3varfN/1hYHVfeahA2lEXLUBh9nlq54AQYnYmS85TVqTvpKGIrns2d+PO3L3HErO2LDBoeml3cB1a3RJ2YRz04ig72ODfPK73vGc3s+6vyURcOQPNxdlnQPnnD5Xz/ysI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2krOWFBVHNPU0FadjhpVU16SllsZUVTU3JPcEVwcmp0YnMrSzg1bDQ3Y2Zo?=
 =?utf-8?B?b1VMby82MmNoUXdtcjhteHpZYWdHS0lLYzFwU09CS21xODZEV0lIbjBsV1ZK?=
 =?utf-8?B?dk4zZzA2b0lTY3F1dTV1OEd2OE9vMjJUVHY3Z3Bwa2V3SDZGNW1hRFByWUZv?=
 =?utf-8?B?SDlPOUdxem5mZm1Qa2pBQko4WGc1cXFuTnR5ZExtcExmUDJaZjVVc0I3bnRx?=
 =?utf-8?B?TDVrdnNzdFE3N3hsa2ptcUU4TkxFVStObGF6cGFMNUd0Ump2bXAwUGgwM1pN?=
 =?utf-8?B?eStTeS9WcytUMVgxWCtZNnBVNnlPUmRGSUYxTWxUNElSd3phMHVQT2FvMTlN?=
 =?utf-8?B?QlQrRWpBaEE4aXI4NHY4VndPTHhxTDVJVktmeXNzK1d2V2VhL3pqVmxEZkUy?=
 =?utf-8?B?REthUUxsKzdnbk1TYmdkZ3VQOGxXZTlJM0dQZ2U1aTl1WWRSZmpZUTF2T29n?=
 =?utf-8?B?MzRrdVlBdm1iRWVxQVkrS056T2VJYnNUWHk2NXlaSmJ3K21ReXZSVVEwdldR?=
 =?utf-8?B?Y1JZbGFLUXFLRlM0QlVKeXdIelIxNE9yT0lRYWNBeHU1cS9uaTJuL0p5bGsw?=
 =?utf-8?B?SnhadGZEZHBWMU5VQS95RVFCM0Z2blI0VzNhalltSmdQSTRxWE1kR3NHbmgr?=
 =?utf-8?B?NmdhTS9SQytJUWZ5T1hlc0N6QWZNU3RsMXNXazl3QVdtemRRQmJMV0pPdmtK?=
 =?utf-8?B?anBQRlRKTUEzbWlIQnZnam0ydjgwM2t3S2lETlUvbjBYMmRUSTBSUjQ1bDVL?=
 =?utf-8?B?QmRmY3BuWm5tQVVCR2N2cFJuRUlzMmFrNlcvUUU1WWRza1JPS1F2WG1XWmpX?=
 =?utf-8?B?L0sxcmdGOUxvcjBtMjNWTXJJdExOMTc3SjQ5emhtUWNUNll2TXBuWGFCelk3?=
 =?utf-8?B?ZlFxRUgrRFJmeG1tUGltaU1XY3VYaUpsV1RVYjZjTHpKV21QYUFBV2RYM2Rq?=
 =?utf-8?B?dVhpeFREL0kvZS9mQWE5RWFmVFQ0c3ZTQzRZNm1ONXdLYVdaazNQbGtqYTk5?=
 =?utf-8?B?YTEyK21RblQ3TnBDbWJrOHlQVTdDK0hSYTMweHJQbG9Jd0J1ZWNCOFB6am5N?=
 =?utf-8?B?VHFWWEE0ZVdoem9CRDYxQkxPZ0luQWE1dzJOTTBucEc2NGpZS3o4aDc2ejJM?=
 =?utf-8?B?Z3JiOS9qUnhjTld5T0FYNEt5dDl6cmZKdHAzeGUrWDM5RHV5OFlvelI1K0I2?=
 =?utf-8?B?U2dFSmx4NlZZU0wvOW5YY3Z5cGdHc2ZNM20vQkFENXlsZmFRUzdBc2hIMVk5?=
 =?utf-8?B?U2NMekJ0M2UwUmwwWUVTRnE1UFlWZGFJSWJoa2RxU1dFSjNyMms5THRaWjVt?=
 =?utf-8?B?MVNLVGNOYTVuL1UyV0Q2N2ZaU3ZubnFWOEJxOC9NdmZKWmhTRTJKNWRiWnNS?=
 =?utf-8?B?TXYxZFVKQ1YvbGJuaFkxLzkvb3h6STRUQ2NYOU1CUmliT0ltMTNScmJrQ3dn?=
 =?utf-8?B?ekRxdWtDa0JvTVVlVkJTUklmVGV2aWcxelN2NmovNzdaZjdWVDdnYWJFMzRl?=
 =?utf-8?B?MUFRMEtIZzBOOStQaHNoVW0wWTI4NzIybHBieFlVVmZWYXo4ZmxFL1hwb0Vp?=
 =?utf-8?B?dExpa1NBd1NmT0NzSGg3bXVqQTR0L1JNbm9pWUY3VlQ0c3FGaG5Ib0VrVVJP?=
 =?utf-8?B?QnR1MnlJQjdRdnBoVWdBWklpaEp6QjZaZENpeGxoanNGOUVTUS9Zc0FOWEo5?=
 =?utf-8?B?M0VyODNhVlNUS1pzZGtPd1RnQS9XNjdsN1hHQ3pzZVR3dzB3bUVuWS9FYU1o?=
 =?utf-8?B?d2xOOExwbkhNMGxGa1Avcmp6S0dlVWQxbFl3K05sbFdyNy9QRnZtcy82K1My?=
 =?utf-8?B?MDBjODcraUdLa0VzSXBXRVhETTVNc09DamJ0MDFPWmE0cmNaSXhBeXY4RHZD?=
 =?utf-8?B?QzRuMktETzhwV1orUk42WnRacEhtMVlOVTlGYkNjUUQvbUVJVjBsbVhIWlk5?=
 =?utf-8?B?eFRXN0MydWE2Y0tYdzhIa2RoVVFPaEx4OTJweTJFN2ZjVjhBcWxmV0Nac3Ax?=
 =?utf-8?B?bjdHMHZMZVZtK0J4Z3dUNDdXOC9pU0xVbm5HN3F2UWY3cG1aS0c5NGxHQ2NF?=
 =?utf-8?B?RmJSYk5VZzBVeExnZmNsLzRucCtFTEtJMXdOdlNBOTZENkZXTm5xUlMzOGVt?=
 =?utf-8?B?RFNUODJhR3hVbkYyRHhmbUVBUzBZRURVamFFMDJYWVgvZndYUlBneWYvUy9C?=
 =?utf-8?B?WUZLdTh0dFhuVEJxbEhNSEJLa3U3QnFXR2ZFVW9vWHVsTlozZWRkNlJjNEFq?=
 =?utf-8?B?d3JDQmZMQkp2cWg2aW8yOUMrVmlraW1PUmdpVTA2MUFqRCsyNm1xc3BIbldm?=
 =?utf-8?B?WGJkY29pbUpsaUM1SVJubU5IYllsQlNOMjE4NlBXL2FPVFkxdkNWQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561ab6d8-bbbd-487d-77ce-08dedce6d31c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 11:48:27.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5NXEHhZiljUEhSDcXzMLIhXmtSZEWNYukUjOnXzIx7KDIXQMeld2p3ByjlIqUwkwFNBpu7sB+awtyOdlrjj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6352

From: Jan Kiszka <jan.kiszka@siemens.com>

Suspension is implemented by raising SIGSUSP via kill(). This service
restarts the syscall when being interrupted by a signal, thus will never
return -EINTR. This has always been like that since release 3.0, only
Xenomai 2.x returned -EINTR on signal interruptions. Align the doc to
this long-standing reality.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/task.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index df5a6da76a..73844d34ae 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -1130,9 +1130,6 @@ int rt_task_same(RT_TASK *task1, RT_TASK *task2)
  * Xenomai task, or if @a task is non-NULL but not a valid task
  * descriptor.
  *
- * - -EINTR is returned if a Linux signal has been received by the
- * caller if suspended.
- *
  * - -EPERM is returned if @a task is NULL and this service was called
  * from an invalid context.
  *
-- 
2.47.3
