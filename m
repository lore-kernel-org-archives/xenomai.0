Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FD14D29B
	for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352672; cv=fail; b=mRtHsB+4GqMeaoJrYUHikrlHuIX1gEBmU9wtUK3byeNRq1kbcOGpxOI1fVXKrGaClISXmfmGVXPUT0xGKLPWckcUxb93GUfG5tTjxnOdIth407mrtkN1B60fgQP8N91y+qdBPC+/BXcyXSURdX6gMlUweEm/hJcO+FwtJqlpE2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352672; c=relaxed/simple;
	bh=NgFh/qnt97+yaGdyvxStSHbI9Nyhbg6ozo+j7qwo1Js=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RaztwgyLEs8ioeVydxX8XoyV7ugLwAqeIaRfuV1wxuhPXFXm0G1Dexm9UR1ePAYkxPM9mzIo0Uu+JQ45wOCstAd/BL+48vQzaAh6/nRIUxVcBOGq0aSXebf4gUjZuUdaYVuRagVTGD9n+qc9e1WM9lvAOKtAeEN2OFYPpcjvYpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OET+3Jma; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OET+3Jma"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evp1kyZxWqTpen5iQNgWj/Bwh9fpcY+1hF9mfpYN2xsYO7ybwVMbzQz5kPwmEB2GTewZUV6AAOkqpUBN5GjC4rOzRco0kWBzwaK1cSqrRhnrVTjRV8Zffv8oSkdooaPPKSq+fM+17e9RTfCbP3oyH+lsarFzNeu//paYdyG0DFfRmNsKSOG1iK+IUuMyFmOtp/LxNiCte6EnnHtdvXX1OHu3VfqaDwNyLDzVqDIedXXlL2hFT+PBZM+rrDn+ECTS5PLtHXzfsOl29pQP7CYePypO7azCOs3ZLJkz8tJgIMmPlP8XgafKE6XICJA+nr5e1gRTb7hL2U+eo/YdtRGq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5lN85N4RszTkUCwRtlLQRUtSnU86YZcUtNq+4+0zhQ=;
 b=eWSS3hyKzY7l7YqjzM1ZFmeKD4G6t/0JwFNvnZSafKvO7UfvPahOxOl7ixRIgB02LYm7MrUHNV+Ss4yjEmKfgIdR/m8hYQXABI3K/P/jiQZNat8DU73AnLm2Fc5ztauho4Zb0NT4C1wFoinana1ZY6b+YzUeky2gTfQBJTE95zol7JzZAujJK2Z2tZXW2l7xKTx7K0nqBQxhRc5meU7LvO9wF7VOiQJb1EWE6C9D3oEesgpVcsYVHNcdXGsXk0oocmt7/sHunUfJcKqjzq3KWlAkUSMJMarF+/f7zhmyPUCuQEq/nJCDabgsjumJLffmCnKFDYP90oRpiumYllcvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5lN85N4RszTkUCwRtlLQRUtSnU86YZcUtNq+4+0zhQ=;
 b=OET+3JmaKYqvvmeTqBe/ogGBjip0J93iP1/UFW8/en2c7P+Z2FsxpRysgHxJ5fnFQ7P4blX2Jb5Mn871j8Iq1wUIy23V1UchKkj/mUcOXJ7D2Mq3bHgRf2ccgYuOxWq6TU9oUbWaaPIVLG5u+SuMQoUdfMWIfrs30Gt8fPBrsAuYA3S5p2qnH357iN1BPKUicZcrCfTxmJF6wmem5GDFYxtXnA/LXASCoGvs5PvgmmT5q+kdT14AEtFTkMsAf3TkDNbgHGSOW5c4U03OL9U+EQdQYtVEr9NWVApkRsOdJ8mf6v9v5RjYQd7h84F5LzLoPOG0kTEH2+Vh6OxEK8JMLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5758.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 08:11:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:11:05 +0000
Message-ID: <524550c9-3eeb-4f01-a350-f1f7934d34ce@siemens.com>
Date: Fri, 14 Jun 2024 10:11:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] xnthread_set_periodic: Improve period adjusting
 support
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
 <20240608195337.11137-2-david.oberhollenzer@sigma-star.at>
 <e8572de411ac7bc002cd08c276bc967aaf9c5ab3.camel@siemens.com>
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
In-Reply-To: <e8572de411ac7bc002cd08c276bc967aaf9c5ab3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: d7800bc8-a2aa-4cc6-6b5f-08dc8c4989a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmhlNXEyK0ZKa3ZpSG1ha2lJdFJvSFE5b002SGUwVDB5WnFTU0xMVVp0Y01x?=
 =?utf-8?B?MktRSnZHN3pKODlZclJraWFvZENZMURMd0NyblhVdVNkdjZ0VEFJWFVFQVJ1?=
 =?utf-8?B?bDlCZnFkNTRDbXdkdSt3ZmE2cmJEV0FEN1A5NmEyVWNRL3JxRVhzRFpObnRp?=
 =?utf-8?B?UjhyZVBLYlFnMlQ2VUlVdDJvcEFOZURCRXdqNzRyVGlVUXdGWFRJb2hoYlVX?=
 =?utf-8?B?cXEvdUFub01FeWhGb2tDaE1XakVSOTJ0dmRpc1ZQOERqQzM1aHBYWDB1V0xV?=
 =?utf-8?B?dnEvYUcvbmQyV2xUS21wekpKV2w1a25nNWF6Tjk2bXhhY2pia3VSMWJiM2xH?=
 =?utf-8?B?eTFhaTNFaFc2WXNFV0RVSkZYaUtPc3VRQmFJMUhiNjJXT08yQXJBOUFVZ0lJ?=
 =?utf-8?B?bEs2S2M4QXE3UU9ySk9pNVhWTGthWGJtRXNIWXJudGRMeWRQbHJLc3ltb3hy?=
 =?utf-8?B?RjFOMDhDMTluWGh4V1A4Ymt4VUh0T0ZkRWNBUFJjODEwdDZGb0VnWTVFNXk0?=
 =?utf-8?B?c3FrUkR4bDhjZXQxU0JEOUZqczEySjJRTlNjNmJvdlZXTzBqYjZjRFQ1eDdL?=
 =?utf-8?B?UTY1RzhRQlhQbXVBdUVpMkM0UExoME8xd0lILzAra211WVRqd1hrVWhFKzVB?=
 =?utf-8?B?b2VETzdxa2ZnNno2Z2ZLL0tDNEJ2eUw5eUVjalBkV09RcE0zZ3pRU1VTMUZ5?=
 =?utf-8?B?U0VpRHl6djd5UGtKZDdtTUJkYlVFZGl5aVZHcEFOQmFyaVpMRmJ5b2lEVWZw?=
 =?utf-8?B?MmV3WFRDMzFCV0FsQ1NMdVQwc2s4RURCWjFmRHlCRUhnU1JZOWp0bVJXWmNU?=
 =?utf-8?B?bVpNSWtyMDNyUUo0Zi8rMGZDYmVXaVJrYVo5ZlFyMkwxb0R6OTl5SXFMWG5M?=
 =?utf-8?B?cGxiUnhvQzlzWk9xOUlWdlcrWndSanV2c09VMkNQNkd1S0NKZmpFOXlFYmwy?=
 =?utf-8?B?N0JySDgxckVSbVZTZ05UbHdPQ2x4a1VjY1I2SE5mSGhBaHVWY0w4V3pwYXR4?=
 =?utf-8?B?clUyZXVFa1Mzd2xkVVB4aU9zajYxTXpuMlk2bms0RDlQVEVyZkRveGsreTRl?=
 =?utf-8?B?WXQ2OHdOL1lhUURWTWcxRnpoOHdkckM2NzV6UjZyWXVIYWV3SXQwbHJFUGVz?=
 =?utf-8?B?bXJVVkU4Q3phcWdQQUF2RGhwek9iNEd4SVBtUC9iem9KRFBxMUQxT0Z3d1lh?=
 =?utf-8?B?Wm8vR0hZRmUvbG5oMjdIMjhYWGlVTWRaQnBvT3E0R3IvTWwvK3ZqVm9UQVA1?=
 =?utf-8?B?OXcyVGs4OS9oRkFkU0dsTm1BNG9RWERTd0Vra2xLVStGSzQ1bmJqRWVCckhJ?=
 =?utf-8?B?eS9qY0toanlDbEtjT3FFSGF2Wi9UM2xSWlYzb1dxazNOWHdPSVVQblNmdEFq?=
 =?utf-8?B?VHVvaUJ5SkFEaCtzTUpEM29VS2Z0MTg0a2VYY2QraTVYYzVwWmtRUkxLU3FI?=
 =?utf-8?B?UU9qYmtTWDJFd1F2eVJzUHB5ZmFJS01NNDJzSERRM2RRTlRuOUVPZkEzMG44?=
 =?utf-8?B?NlFKZjZNRGRVcmJvSlN2OVRkbzR2aWRZbXgzaGQ0SklKdUpUSG5uTTRrY3U5?=
 =?utf-8?B?a3RtRUlZM3JzT0pMNHhtNVN4QysxM3ozWHZleVhmTldxNEpJR0M3NlNlcTJC?=
 =?utf-8?B?WDlTSTZlbWZUVXJpR3FYUDN6SmwxUGRWcmozM3k1TFpXM2h3bnJTdjFKS2Ex?=
 =?utf-8?B?ZmRPSlRjby9EelVoZlJKbDRSRmFPUFRJTWRZY05aTHFGaldUcE1DMlhGYzZn?=
 =?utf-8?Q?3z2BXUfZjg0tNhVgU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21VME5tZWJiUytDcytnV05XM0U3ZG1Wd1B2RTc5bGNBUGd5R1F1OHhwc0pR?=
 =?utf-8?B?WC9NY2JzUmNtS2xaTW9KWFFWODFnQ2ZIWXBkMWkzMnEvMitWbzUybU93WkRj?=
 =?utf-8?B?TmNxMU1nR2M2L3hXeDRFUU5jcjg2K1BYUG5MODNETTBJdGtwMjdSTjBTNXlJ?=
 =?utf-8?B?OGNhUkNtTnQxZ3VWelVDcjZVUXRIWHBESmNqd1R5WmFmQSszSGlKUGhkUzcz?=
 =?utf-8?B?WXNsa0V0VGNsWkR5TGRUOW4xbkZiL1ZsSlRTYWJyaXc2MlhwR0tLcXplbmVJ?=
 =?utf-8?B?b3BIQkkycVhuTjlCTG5zMlh4L3VXayt3K2c4T1Q3R1JRMlVqbzhsUHZlZmxy?=
 =?utf-8?B?eXo0SUFUamF4a3hMTHJobkw4THJPSmpmZWpnVEkycU9NcFJvLzlCT09mUU1a?=
 =?utf-8?B?TXZ4dlFSeVh5RmUwTWtCVit3aGxJMGtPcVRUT1l2R0pzUFJUZCsxRmY2RXFI?=
 =?utf-8?B?ZTJUZ0RyVHlGMG1SWlgxRWkyRytaMjRVMCtETzNVUVFBelFUT3VvbjhIUTRy?=
 =?utf-8?B?TStKcVRlU1JhZzhiTzVnQklqby9EVCtnS3RWMm1ueUVJbnlhSlJabUh5NFEw?=
 =?utf-8?B?S29LVDgxaEEzQU5qbDNURzRmM2JBM3pBSWo2YkU3c0xQSVFlYzJCWXlrb0xh?=
 =?utf-8?B?V0JYQmdORFY3alBTQS92dnU2WDdERmQySEVCaG94WWM4eGdjUnNXdFovUnRk?=
 =?utf-8?B?bTliUytpZHFMTWJOYVp5TGhpMnF4S0taem8xeTBPUEdEVHZEMzR5cEhOU2ow?=
 =?utf-8?B?cjJmVHdwZVRoM3doK2hEbGNIMWVXaEl0RkMyS2pyTmRYMkU4b1BSbFJCNUJt?=
 =?utf-8?B?Zi9kQWFnVG5SY3kvRW9NVk9xR3BQU0VZY0FzT2Q0MG5WR1M4aitxVlNxYXQw?=
 =?utf-8?B?QzhQeFZTbE16Q09yVEpaVUNDTXpURnNhMGlTNUdYem0vRGRrT0tUZytpbEJR?=
 =?utf-8?B?bXVCSUNFMzU0TDdqR0xEdngxK3RESkdiYWQySW83a1d4VFNhVXNIUnVyQnlM?=
 =?utf-8?B?Q2l3YVltbTZRR21kL1dwa1NuRnk4UG1ra0tpMFR5NHMraGRJMGdSc01lVS81?=
 =?utf-8?B?RlRNdnJ2cWtVR3MrRWlFUWlDU1RKcHB5VEFxODBNdHdNek9xRC92T3htN3kz?=
 =?utf-8?B?N1BGMTFnQ2p4VkJxeU13a1hmMHU5VkdLR1BIRWpjS25abitqbjZQQWhDTEhC?=
 =?utf-8?B?K0FTY0drRml0ZWJCT2JEUVMzQmQ4TSszdWZHQ1BaNk5kVTc0b2docFpVOHg4?=
 =?utf-8?B?S2VKak9EenczUGd0blZCVVRoU2ZJMlNwSGd1TXdKVDJDWm1lcGpkN2VXMk5v?=
 =?utf-8?B?dElYd1dwVWEyZklCVVQ2YmJTWnVYSHpJQU5YS3ducU8wMTRMM0hBdUtpTFJR?=
 =?utf-8?B?TUhpLzZaMnNsZXNFMWRMZXNXdFBBUjVjaHBEYXVsclMrSkNBSlJvL0IrQzNX?=
 =?utf-8?B?Zk1ZamFma2NDalFVKzk3Mm9mQ1J2QmFBSnl0RExNbE91empjMklDRGFKWlE5?=
 =?utf-8?B?T0tWUDhFSzRZVE5sbkNBaFU2TnhEM3VBaDZ2ZlozRjA1Q0lUOE9wYmZsUW9Z?=
 =?utf-8?B?WU9VRkRlcXNNellkVnF0am91UnZQYmhhVGdRbWF2L24xQVFnSFdsNEtQL0Iw?=
 =?utf-8?B?aW1LRGludWNKRWd2VXJTci9PenJ2bUxjZGx0RkZ3NE4rWWVhT1Fxb2ZUbVph?=
 =?utf-8?B?VDBvODRhckUwNVlUZEFENXN4VGdGejZORHV1WXoxZ3JteDd2VDZWb0RkVGpp?=
 =?utf-8?B?aWhmKzhiWDJVL3lXdm82YUppVkdudm54LzZWS3RDOXlta1RsclYyT0U0d1g5?=
 =?utf-8?B?LzJOWU5FQ05xNk9kR083WlkxV2R3dDBZeU5SNU85NTh1TEc4bVp0bi9RL1B3?=
 =?utf-8?B?OFhtNkJ2Y1pwcEhhdUdIWjg0VUFMUDJTTnNOa05JWURVN2dFcDBVaTNkb3Fl?=
 =?utf-8?B?eUpxYTBEOEJhN0Q0Snk0K3lkeVBaRkFGNWVETzdQeVIwZ01vUEFVU0ZLUjdH?=
 =?utf-8?B?cmdKL2FXZ09YSXA0d3lCODVKckd3WlBMbG1WNEJ5RGZ5aFNVWStDMDZ1NkZT?=
 =?utf-8?B?OXc0VG1ZK1Axb2pQdGhzRW10UTlURXdlek1ONEl5a2xoMzVLM2lUL3dDbFZX?=
 =?utf-8?B?UG1mSGlEYWo1WkdsVzlkbUFVL25LMU05YmlLOUxPd0tUd2pObEhKL2htaHJy?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7800bc8-a2aa-4cc6-6b5f-08dc8c4989a2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:11:05.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbOOgXtunU+IqG5lZQ9A6IRvfuJORQpx961YIO148nahLZkx/IHo2BzMSZwVnwMius4B3xK8hynIueBPcO96Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5758

On 13.06.24 10:07, Florian Bezdeka wrote:
> On Sat, 2024-06-08 at 21:52 +0200, David Oberhollenzer wrote:
>>  	xntimer_set_affinity(&thread->ptimer, thread->sched);
>>  
>> -	if (idate == XN_INFINITE)
>> -		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
>> -	else {
>> +	if (idate == XN_INFINITE) {
>> +		idate = period;
>> +
>> +		if (xntimer_running_p(&thread->ptimer))
>> +			idate = __xntimer_get_timeout(&thread->ptimer);
>> +
>> +		xntimer_start(&thread->ptimer, idate, period, XN_RELATIVE);
>> +	} else {
>>  		if (timeout_mode == XN_REALTIME)
>>  			idate -= xnclock_get_offset(xntimer_clock(&thread->ptimer));
>>  		else if (timeout_mode != XN_ABSOLUTE) {
> 
> This changes the behavior of rtdm_task_wait_period() when called again

You mean rtdm_task_set_period, right?

> while the timer is already running. This documentation is updated (note
> the comment from Jan) but what about backward compatibility?
> 
> I think we are allowed to change that in the upcoming 3.3 release, but
> should we add an additional note about that change somewhere?

We do not have a specific file for API changes within the 3.x series,
just about those that came with the 2->3 migration. I could mention it
in the release notes, though.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

