Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5619AA7B
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771955; cv=fail; b=tteCXQJIQ+R9UHOHU9rnL1VhHKpPNud4/b9Pd3ws+4LZBV+HZbEo4CQ/JPBK856tfWslWrP6NxT2grW+QKYUm9YSKPj/wAAkoSYuyggEkV7/puDKlzGB5wQKb3nMSSZJBPKZ6v8NXaMlDSZIAkmzaLwt+SuygaMUdaWlHNnOkfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771955; c=relaxed/simple;
	bh=s1YhOFY0NfP3VAIdq+gInV8I1Ms+UGYbFlFFFqtMRGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OsOBBMq/Vi+63wHOTIHgJYMtUbZzB6LlL9mVT9qqRRzEiPxSmJJ5g1ppDfHLNeZ48CCLX+63gTRqA8ICZv95DgzOYc2jqHHxp9U66vBCgXZLTwCY/8oNlW1P42Oe/lOU8KdLVxXMN2lkD5bjW+YDRCjyUVEqCQ2R3lAm5YmxTUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qdJXdlK6; arc=fail smtp.client-ip=40.107.13.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qdJXdlK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEnVh6hEHtKT7mwtUVW95iaG9+d1UGKXdXk0+/bLvL9YgNYl9o+IPVib+pTjgpk/44/o23SoEGm5gsHxmkl2QEKqkzFFoTcP/dcG0S6RF/sPjf5RqkyvWyvrBxD3f9setn8CIBsEGIzlJ1Upj10t7Xbncbd0kjrg3V50k0tsrpUfXjY80TeTVe9kosiGd0rPgsBCnURk6qF1NHdG1lmN+Pj0Zm4NST3L1azeEtmJezGwh3WEWL9EpSFxclxwDxPpyxYQ5s7dyzmEmSWXzjmGRIZUaJaN5y1ZPlmaI+Il0HAbO0UUDUd7njgdKsLc0kr4+07UEj/aEKIDcXpk3UAaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSYriz73+kmyeKDmMSQHlGzTaz+RWobZWlb4sNvPyU0=;
 b=YRVXPgwENMHMsWhXuHtRTZsVqEr8RNQBprh5eiXUKt05axGtjlEk46KxA4vOAm4sXq3UkXhFt5OkKD9rGnWxNRAm3vk3N5jCpMKjWOulXbkTdi58nIsaK0QsXYAjmve1DSZ8xnAMQ0yWRSwTJbn7KU8B0bSCyw+66OXCLvD6LNGrzWPsGnJYEICFmL0nxOTLzcEiNoT3YvYqWYPZp24VubFpXF4ps4BBpF88o06F7HhUYj1OnMz2oVXyiG+x9VkgzS5YLyRf7nliFM2MG6j36OKOioZaU7a3ZNnlTahYHbzFxh4sPieP5qlrAmZnFk9IvV+0Z6/fnCQ5QJfZyf/lMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSYriz73+kmyeKDmMSQHlGzTaz+RWobZWlb4sNvPyU0=;
 b=qdJXdlK6wsVnHiOcCiA9rHazN9pgRcv1FoSjGvfujqdK3LSc9dPleSmRVboe7aUYyKrCHEOEzH5Ojr8bI/XMyi8GW+gmpDWfZcbpll5nmaWbzduiLI1nqoHcTcmeqKdP5OPVdJwp7RKHkhq9hU8NNloe8BSBCxYupC1EqG8zacdDwTFnn5QFiXmz9MckiEMW8Tdbmuv9LKRxjYeLTnUtDqR9dwXTLuP5jmX1YjoM+UT/lS26UdSdKeHt3pv9A5EsXRBH8c9wvjKBSQoiKvZo1EPq5zJxNtPNJJhRUG55h8y7FKKujGIvMd/GIIhZj13W+NlDO7VwFQanAEuDOoO29A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Fri, 7 Jun
 2024 14:52:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:52:25 +0000
Message-ID: <e53c7c31-a98d-4dd9-8c84-0d0b72c3644d@siemens.com>
Date: Fri, 7 Jun 2024 16:52:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] I/O benchmark fixes
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240607134551.3450170-1-clara.kowalsky@siemens.com>
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
In-Reply-To: <20240607134551.3450170-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5d8333-a79a-41d9-7bf0-08dc8701720d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2N3VXVHRlFDZm5pNjdhaTVsUDEraC9yMnhRODNyZ3RxTUhIRnF3eTFNU1hi?=
 =?utf-8?B?MEs5S1BRd1N1cDh1Rit5SDY1R2hGTmEzaVRtNHFRK1FWMXlNaXZCYTJDTkFr?=
 =?utf-8?B?eS9FL3BERFhSRCsxMi9lNEQ3Z2FCMWJoMmlncVhHNE9sL05PODJkaEt5enVQ?=
 =?utf-8?B?SW5BVE5jUy9lQmFvQkJTZ1NxQU5ITTkzbExDOFdmS3dKVC9iN1VCeDFud3ky?=
 =?utf-8?B?K1Q5MHZrV1ZLbkl1bzFmVWo1VTlXbTVwU3pwaEhoOFJxTU1IcHdFVGYraFg3?=
 =?utf-8?B?ZDEybGdHV3FRd3YrRTlSM21vV0JieXhpYm1MaUZtVmZsRWNhaTRMaGtGS3Rp?=
 =?utf-8?B?WlY0MmNVWkwxZUtDS1JqUGtZU3h3TG9QK2NiZTI1dU5xdzQ4LzhhSng5bnU1?=
 =?utf-8?B?a2pnZjhPUFFoVVFBVHo2bDVwOW11bWJkRTVlNWdsQWM2QWpFODY3OHdDeDBT?=
 =?utf-8?B?ZEVpY1RyS2JRcEIwbFVwZ1NCcm1SVW5JeVU4S0hkVWUzMEdWVEZBRDNGTVRH?=
 =?utf-8?B?dDNVU1FoQis0N1pGRENKS1F6Q1hBWDRBdWlMK0htZ0NwWVR4UFFaWCtGbmN0?=
 =?utf-8?B?RnFwRjdaczNBc1p4U0draXVTUXduL05RQ2VueWZyZHljRjM1c09QS0hSakxz?=
 =?utf-8?B?cE1zZXdEd05ScmRPQ2hCb05JeERkTjNaVEwzYmRyck5XV0J3RVJIVnNtRldJ?=
 =?utf-8?B?MTlQQjBYemdwcDQ2eWVZcTE4ajlXYTlHTG9uRC85WnhqMUxCS2RpRnJRS3d2?=
 =?utf-8?B?MzVySDdic1JuSnFSNStrNnByVnVCbUJkdjlhVUZ0YlAzT21mVmc1ei9hVnIw?=
 =?utf-8?B?VGdhblllS1EvMW94cE5wVFdNYnIwdEVMUHJvNGNqaXByRVZvWExyR2hmVUtR?=
 =?utf-8?B?cDhOM1Fqb3o3eHRJYmRNYTR1YVAvRk4zL29KN1NFajZFWjFsa21SWFZmbU1S?=
 =?utf-8?B?UUk5UzBBQzRHNU9rbm1uUTVpWWJIUzBJZG5hTVFoUGQ0bTQwbG9wSEEzbWhl?=
 =?utf-8?B?ZkM5Q2FWUHlPVzZEMWlOdW16NUtrYjh6VnhQNXFhUVZFNEFkTk1KYnZIcnlO?=
 =?utf-8?B?K2xYc3oxMmtjSmtOY2MveTRQNWZyM2Z6UHRLbHpad2xqMkVuUGNjYStSU1FB?=
 =?utf-8?B?WDlwME9LUlNnODB3L1UveWFzZUVTREVVWmNmMFpOai9JbnV2V3hXS2Nld2xi?=
 =?utf-8?B?RE9DK2NBTUJRZFlWaXh4SWlPbmVWMFloOGRUYzVOcks4MzN4a3FJYVZQd0dn?=
 =?utf-8?B?d2lSbENIZWlZbmtmWFlRVk1ibXMxVnp3aTNXWWp0Q1IxMy9Ld3FVazlqV3Rl?=
 =?utf-8?B?ZG5BRDFxWnZ3MW5nZ3I1RlEzWWtTdjIwbzh6eFRtbFBZbDlXZUhHQk5IazVZ?=
 =?utf-8?B?YjFOdkxiWGJISExMQU5EcHlGYy93SlR3UVNEVEZaMWlRZ1M2NXFlaXRMTnlJ?=
 =?utf-8?B?MFVhTGhwOUNQYzIyTmtuQklFVU5vSTJtZUdtSXQ3QTZ1TVUwUVpBbUwzbHlU?=
 =?utf-8?B?K0JjK1ltZ3dYczlicDNoRTNXcjlRQ0NaeVgzc3gvSW14QWFDUEVsRGtCVWxp?=
 =?utf-8?B?c3AraTN0S3ZoZGFvL2UwZ0JVelNZTUVVM2YwTGxiMGdlSVlpWThFUnZSeW90?=
 =?utf-8?B?TWx3SnFrbDdHRlFTU0VkU2RnRjRhbGFrTVo2RDRWd3pwMWxNekZMdDlHc2JY?=
 =?utf-8?B?eHRqdG9VNFBOV2RHeFNOMitDWGZRMG5RVS9LZm8zdHYwU3h5NkJ5bHBGdHhC?=
 =?utf-8?Q?Cn72gkCj7a7r9T5YAjPvHlgGdDQTRZbuUKIW2hI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHFsM3lGb0dCTWg3cHNlL2liYTcraTE2eXNiZW1VelBXcXMrUlRRbEw3OVV4?=
 =?utf-8?B?Ylp6VmQ5N0w4V1B6Nm5XUjJ5aThwTWsrWGc4MHhyZCsrVEVUWDlqZEhET1o4?=
 =?utf-8?B?V0xGc3hrMnRZVDdqNDZKMWROdW0yUmhuN3VlNENaOE8rQW9RRG9rdXV0Ly9h?=
 =?utf-8?B?WVZtNVhnQjR2WjZGcFhEKzVXOTZkZWxrZlF4d0l0Rmd6bHpVR0ZWaCtDMWV0?=
 =?utf-8?B?OW52UWhSUU8wTUhDbHErTkNwNE1TdzUvdWhuU3JYVVhEVTFZZS9kRTgzWmdZ?=
 =?utf-8?B?RHN4c1VndXVKQ0lpUzB5eGhDa1ZqYXhHWTY4engwUWNSWDdYdkZNVGZSb1RB?=
 =?utf-8?B?bUFFSlk4amtMMHNWNTBhQkt5cDJBNmNpMG9UOUhqV01pL09FazU2bFVIYWZm?=
 =?utf-8?B?OUlmVzh4ZTJZeGYyZno2d3RYaDJaMEVQQ3ltMWg0VUdTK0h2bGZ1MVVZSUYv?=
 =?utf-8?B?TWFPbVZXK1hpb25WRjFkODdHZWQxVVJscXJLc280WlZMZCt2a0t0aFFERnd0?=
 =?utf-8?B?Zlp2emVHcDZackZDZ0Q1aXI1RXZic3Nab0JyNmlyeDI1K0JEaHR0Q1oyclg2?=
 =?utf-8?B?eHpKdWM3TzVUMnlNSW1xVWJNVHNvL3NXSHhlZFlhQjhudHdZWDFiSGVvZjFx?=
 =?utf-8?B?RHhxeGlMTXZJcWFNVGhLZHMrdjlFNWpId25mVHRXeVV3eCtiWVBkalNzKzRT?=
 =?utf-8?B?MlB5bE1GUEhSUjBuaVZ4RjJBdlVFT28wWTlDbm1DUHpoSThzd0xmTXU5M0dQ?=
 =?utf-8?B?THZMUGZhZ251anAzenBEVmgyMjZ1RWJPanA2bnpwMVlmVTVFRTV4RVZCTXFl?=
 =?utf-8?B?MGlMbmRCTGEvQlovem9paEdRbzhIZlJmTFlYdCs3NkhGbjkzQ1JySzBnWGVM?=
 =?utf-8?B?cHlYQVhkNWs5WE14Yk9kUHorNXJURFd6YjRoSWt6T1RtbnhXb1YzenM1UVpp?=
 =?utf-8?B?dUJqYlRlblpoeEhINUdiMGwvanRNdWlDQUQvVUdhMjRnTG9OeWxzY2QrZ0J4?=
 =?utf-8?B?bENiU3I3dTVpSklualhKeHNUWFdmbGFvK3JkSEFGY2dEdUdINHI1cytwU05y?=
 =?utf-8?B?cERrMDZBOWdEZ1FTZlVtZmRYOTN5dXFSazNocExDQ2JCT3dPUUtFWVh4YzFv?=
 =?utf-8?B?QzduWTdpdHlrUmtYSW5WdEx5bVZZRkFOQkZYTlpjYkRuNDk5blgrNzFWOTAw?=
 =?utf-8?B?RU5FS1pkWTd4NWVmUDYwdVNHNzVCcmFuU292SW1LWDFFeUtoU3J2MURPZnpR?=
 =?utf-8?B?bnZTeiszM1NQS0JyejlkUnphUVd2RTVDNExWcm53L1dVR0R5MUI2MDU1b2lt?=
 =?utf-8?B?Q2Qya0dDVGJva3J5MGZ4a1FNOUgra3d0NkhYbzFKdGhNdHkyNnd6TERZSVdm?=
 =?utf-8?B?cEFvdk0zclFwNytmakJKaEhMV3BWSytYeUNOanZDZnVOOStwUVpBckNQeGlq?=
 =?utf-8?B?ZE43eTZJYXFVZmsydTR0MG54cC8xeHE2V0MyTEQ4Qy80UTBXTWVleVRuWXRa?=
 =?utf-8?B?ZS95c0RJZWZGZUNNdnBxbklnZGtWbTQrektnc3d5WlAxeUhRa2FKR1dLRllQ?=
 =?utf-8?B?ZmpFWUNZaGtkY0luRW9CSTlkcnpGYjkrMDJFU2xtOS9VajJUSzI3dVZjRmxh?=
 =?utf-8?B?UVpWYVpQcE1xY1VIL1ZtRmV0ZG9NRTB3NXp2V0JnNjlJSzBiSTN4eUpGV3Jq?=
 =?utf-8?B?QUFnSHV5cVBBbFFCcDBMbDQrcXo0ckdiRXU1eEpScmRVVzFTb1dwbGNHYzhy?=
 =?utf-8?B?QWVvRXNDSW1INGRHRWoxREFkSnk1TThZSjQ2dVNGTUtxdTdNMEx5cDRDclVG?=
 =?utf-8?B?cGJIYTdGSGY5aWtHUUFSSlArSytkOWowa0JKTGxTbFltMElhdmZhcjRkcVhk?=
 =?utf-8?B?d3pKdkJ4Z3lQL2ZTeXFQNkcrQy9MSVA3eVhrUmZ5STVyakJLWlhVeGlXbEp3?=
 =?utf-8?B?M2tTNFFScUJITmkveXRJdk41MXllc24weXJOMUc4d0l4Q2NLQitWR283NmRG?=
 =?utf-8?B?OGlaYVQ4OVc0RnBVRVZqU0xWR3FJKzh4cU43ZlhXSVZCWDNkTnkraGozR1Fi?=
 =?utf-8?B?by9FVndWN3l5VDdYbGZYc3RhdnlhUjJxRUI2U0grVGpHbFZMc3FVMTRXRlFI?=
 =?utf-8?B?RWlpU1pic1NucWNYK1ZFcjFmdlo3Ui9CekZWY0hNNnhvcFVVMmdaYmVwNmhI?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5d8333-a79a-41d9-7bf0-08dc8701720d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:52:25.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzzS04fX2P5O5RrOXk3aAfRVPzSerFczw8agNR/cNQwxIFjCEY9qE/bVk1kN04kPORENY5Or0YbzVxK2ot053Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5988

On 07.06.24 15:45, Clara Kowalsky wrote:
> Hi all,
> 
> this is the second version of the series for fixing the GPIO benchmark.
> 
> Thank you, Jan, for your comments on v1.
> Changes in v2 compared to v1:
> - P1/3: Let it build in the gitlab-ci
> - P2/3: Fix style
> - P3/3: Fix style
> 
> Best regards,
> Clara
> 
> Clara Kowalsky (3):
>   drivers/gpio: Add driver for BCM2711-based SoCs
>   testsuite/gpiobench: Fix output pin in react mode
>   testsuite/gpiobench: Synchronize index of loopback mode and react mode
> 
>  .gitlab-ci.yml                     |  1 +
>  kernel/drivers/gpio/Kconfig        |  8 ++++++++
>  kernel/drivers/gpio/Makefile       |  2 ++
>  kernel/drivers/gpio/gpio-bcm2711.c | 27 +++++++++++++++++++++++++++
>  testsuite/gpiobench/gpiobench.c    | 16 +++++++++++-----
>  5 files changed, 49 insertions(+), 5 deletions(-)
>  create mode 100644 kernel/drivers/gpio/gpio-bcm2711.c
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

