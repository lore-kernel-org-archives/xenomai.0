Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8762D595D
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663800; cv=fail; b=XqD/Dis5j78wtKnEXgaBXmETWhjX/e0afUp9TAXbucs1nVz2yoEkPUGShkhW/jds+TajUmExsXcjpWtn3erbIVY/xhSNy37YVaNI8h/ZOX+FId6JcKY/hywdsj0jNAdbnXpnY8b3NL823xHA+4KIvXo/ox+OCX40ZuEyKtwFyZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663800; c=relaxed/simple;
	bh=EhM0UAPs5uhQgfn3AABjTyWvrlCr28akj5xtPFPQgoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MyF3koGA4AFk/4sfC8CWkTELRzNa8i1rNzbqSJT4QWsFcMMCONfNZZNjCwx7QJR5vMdBnrQbBgYzwmXDyXyyNC3Nmz2GA1NZq/XKk5PhhyFSErpfcyOV1zHHM9nUsGUqlXDC/LL1wKzlFDgHCL+fLAvDE07f4rsHdl5c0LxvTQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pf7I+G5E; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pf7I+G5E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNFek7NjQDrqw6+YUck4HIbYpXqcy/Va82hjcEp9YkdEYXZbOp6VtDY20Ya45nXUs/GL1I72DzHViKYXnhrnpklyz/JXKI4JfKQHUvcS0qaxTzZDwWZdfS5DkIdsOUZ6d1byVK6HCErNyszd02QAIYEFsNbeEGbNVsImbzFRUzB4HBwUU7S7KDWZzppOsKCrrekYenPoKZcQ8OfYBsBe1gbdifs5/DRSdJZFDWq06R/vwF9MA/FZBqSJag07HxLkoJSS2XbHqWG5hcaZPilNw0j+LtOvnuzkroVrmUSFd8Wi/gYxUKrY0n/+wGjaE/DtNHGNrP9aEbmSCw1s1oabqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq5ru2dh//adrI92QopWsbRINY7xK550lpHep23SNfU=;
 b=OgKMpp/Z3jLW74PAHcGYqf0J00umjDgHWgs4rlx3I67sa0Nhwzjy/Dp3FeUfZiZdlP01Sxlr4qLvUYhtlMemBIUiyCgIycS9HPe6c+xAi9iUviCxdcob6qIzdUvmRvlrJqGzg9fREsSONjP4iJ36YgXVXaklkxcqQF5DY1Bd9keB7F2DpbbRICfDXFkcMNeRRYb2PRj8VmdnyZQsYymyThk0zC7fqXvTa4lNaWw0S9qW8//R2uWD9BAHlP/LQjkw8ThWC0zcIs3hCzfpsMRp/K0sruG9aC6HYjLiinXIysx33x9PLE53mjzQu62nBFanK6jeZrnx4h8swxdXpch7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq5ru2dh//adrI92QopWsbRINY7xK550lpHep23SNfU=;
 b=pf7I+G5Eot5C0oAbgVk7vl1l3/ScWcNUgomKvu4wVKwbdx4kfxOn5FpfOaJLtcjjlfpTbelkE5X9g9s7/bJcuUjvJgTAuf2z8+faMMrVkuLyDFD4q5ytQzj+Vn4wCdljJkZqoVJDGyDIPVKH0AJXj34G96LlXTH3Mo5q7PDurvqMKauUS72XQWdz50iVNAY5D7DVqp3gCYTLztjF9uHfY37y3nU957Uo93nncb9WW8ylJNblmfPCYJMftBgJfzMtUM+UY5UC9bzq7N/dx7dJogzeGQqwJdPt7zELhRym+FnU6vX9G4vWrl9OkfWBCVpyi7guvyfStLUVjdtz73RYuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:43:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:43:16 +0000
Message-ID: <df46a8f5-09ac-4c2e-9ea9-00f9dad4dde2@siemens.com>
Date: Mon, 20 Apr 2026 07:43:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: Disable evl monitor-event-untrack test
 on qemu targets
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260417205515.2288339-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <20260417205515.2288339-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5b29be-fccf-4ce9-74c7-08de9e9fb821
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pqxVRZpvB4pqprbW9vbXAteIY+PFzIRyiKrMQ04l4mmdBRtg8O/gDhrFlMQwYSO0DRsgaNbxgC1/K4pToQA466ZUvmNgXWTqIdVVV3/Hs6NzCmrmChtb9rUJmdvwHYZyjI1wpwBrwEEvKfAPgi/5Bt/pHx4BXE4NAqPEpL0wpQ0TttPDVWojLGHfIeg01D+7K8AlmAZRuoB7IFIVTtnQHKGIIoEmiX6rpUk7zyiLKQ2/LNHrhXfmWumRUL+8R0Ebtw13P23aZF6omtIJLZy9tSnUknMIx0gNGsiiwgPrRw87KSFmG5zIGfNZEHO7soiWfo3uRLwsQCTZw3tfXmVPCRmCkC5njNoUETXTJZVqc7fitRp2BKX2d5UyAX44VI+B7f4kH3MGqhPxU0CKVccOUus6Df8CGt4O55btgAa+GjdgiBfW0wKRC7ogsxVCvxqApSK82JnHcJex9EDQluI027KDa/1mPN2NDmrNyPOwkAR9eLBzqJShXeXLZ5nX8JnhB/+nOJhH2CvCwQjUtexsR9DevoFa7BFNtxTHoq5tTqZZvbUm+4HlnmZn88oQvXfC6dKnRXgevWcD7HoLwWUb57LYuXlbkEYEBKnAc3DOGBgE7nBxBzZtmTdEwmsRXzdPTZarGqM4Z6HgpGFe2E+metctTE6gWzTCObYoajCgLUI/wU3qWDpATRiJvczgJ65R5YyHf5o8q46T1ITvuoQje+XyEaxzvqS4KLO1QXRdy2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXJvbGlKR1lPcU5SN0tQYnd5aGpKb2xock54VnI5TDAwMGgraUtuVmdIRzdT?=
 =?utf-8?B?dmJBOUNzeG94czhpZDZxaDI0Zm52MVA5bHc0MWNvc0l0bkI3QWk5a3VBamFi?=
 =?utf-8?B?S3pDN2RONkMrOGZpVUJ5ZUhZTm5YSlhHdk1IVElJQllNZkZyazFOaFBOU2dL?=
 =?utf-8?B?N21NaWx1am9jQU1May9iYWNsQlhsU2hFYVZWdDFmdFROM2VLUGRTUmpjVGlR?=
 =?utf-8?B?QmUwMkdHNVMzTnIrNHpKa2NseU9hWW5pbS9pUzZRcXJMbFhDcFRGb0g3bUgw?=
 =?utf-8?B?YXg2MktWWEV6bEFTSGZzZVl1WWFTamNwWjZYZlF5b0xGVG5CTG92MHpyVE9G?=
 =?utf-8?B?eW52VVplR1RaNGtkZU54WEhqS0wyV1BwTk9IMVJmV1g2YWdyaXFPMDhmYWt0?=
 =?utf-8?B?NVAwZ3RCN1ZOSHpUazlld1poKzVkdjlkTDhBMWdqRVMvSVVLcm5hakFvTGVu?=
 =?utf-8?B?b3dZc1AwMEVYQnpmOVE4MFpEUk56c09DY24rNHdpSCtWUzdDaXljV1NVM0Y5?=
 =?utf-8?B?Z2hHeE9zMVF5K09uTUF2RGw2WjNNV3FNTzAybWQ4a2p1aU9QSlpBTmdIMFJh?=
 =?utf-8?B?ejFrSUdwRWtsM3FPOFdrSlVscmFpalUvV2JkU0k1c2k1TU40ejN5OWNVWTVh?=
 =?utf-8?B?UlYzTlhHMjNSR2Yvcnk5bWc2VW5sM2dqempMRnRRZWpmUnRYdDNxRFNjR01s?=
 =?utf-8?B?ZU9PVkcxSUlIa2pBTnNPVFZ1dmVpNFZ1SEttK2xkcEI4dlJQRXAvK3ZBMTE0?=
 =?utf-8?B?QjBPV1hzWk1EQlRmSnVSMDBwS1NsRTNRa3NrNHkvVVhlOTRqZUZNNm1vWXlV?=
 =?utf-8?B?RFpLaWFSZDFNMk5IazQ3TStsckc2eU1taU5NbDNmQjRJWWRaZzJKNVQ1em0v?=
 =?utf-8?B?WWlwTWxrVlN3VXNsazFPRzNrZWlFSFNHaFczVlAvTHhsWUx5Ykh3SzBKRmQ4?=
 =?utf-8?B?TEp2VFFQZFdiekRSSzhsdS8wdDJTQXYwbzVETFdRZjdMWk5PTFN0QnpmeUJs?=
 =?utf-8?B?Y2hTZjJkZ0N6QjZRZkRUOWVUOUlzQlQ1OE1POXFGSCs2dGdLOWtPdWhTQWVU?=
 =?utf-8?B?eXZjbDl4UUtBUmV3QmFNTzZOTzlBUFhqVUVlTjFaaVRacEphbGlxbXhySnNv?=
 =?utf-8?B?aCtJck9RcE9IbTJ1VnFBZHpXZnVwNFp5Ymx6aTJEd21MQys2WUR3cE1tWUIx?=
 =?utf-8?B?MU9CS2VKNWFmalcwMEdhNnRWRXU1OU1xbHhBdFFMUEpxQjkvVW5YdWs5c3By?=
 =?utf-8?B?K3NIUWtZMlZZckszSUk3T0d6RWMrSHJRamNMeDNFNkQxeHprUmZnK1d4MFNI?=
 =?utf-8?B?TStVYXBWQ0hINTdZemNUUlVHSHF2ZnZHckhwRmRoa1ZBR1oxeGRUcmN5WkhY?=
 =?utf-8?B?bTRMcG1qOFUxQVYvanRQcEQxWE9IYlNTL1BsQlVCVGVpWnJZdWNhWUxQZFJB?=
 =?utf-8?B?QkZPME85ZlR4bXdrSGtsZDZUbW5JQjloTWFSMjc4TWZHZEpiQ0NXVDdadVJs?=
 =?utf-8?B?VDcyZ3l4eXZTa1pDU3NFMWJLKzh6VUl4RWZxcVlUODIwemY4ZVR4UFVuK0Ix?=
 =?utf-8?B?K3NLcXFXWExGWVdYRXgwR2xZOGFSamdxWjd6eHlvNFZ1S0pMSkhiUTVlRzU5?=
 =?utf-8?B?OFBvUEo5Ui9EeHBTSnkxUU5taEF2Q3ZKQWlmNXlsS01kbzVnMFp4dTNBazQ3?=
 =?utf-8?B?em5YczcrZytQNFRSWW5EMWRnMCt6NmZMVGxuMUxodXlERkh2SjY3a3IzQXoy?=
 =?utf-8?B?UEVia1VDd3lsazhJWG01Tk9VQVJoNHRxM2FkZDR1Q3ZBL0NVajNVWEZMNHpR?=
 =?utf-8?B?bEdEMEU3b3hpS1pnNENtbnE3K3ZvYnR0M0thRjJnQnY0d0MwTUFQV215WGVa?=
 =?utf-8?B?Q1VzamxmRlQxTlpsR041d3lleFNOZmY0N2VKam8wOEdCT3Rhb00walkyMHpz?=
 =?utf-8?B?dmdKMWtkb3JYR1g5TGx4djJlcHd0YkJDM0lkZFVnUTQyRm53bkREMWZKSUFw?=
 =?utf-8?B?cGx1SHAwVytCMzFqanU4U01qVURLZ1V6S3BEc0xnY0NUS3g0THRCQWF0aElr?=
 =?utf-8?B?cWhVLzJaOUR5YzEycmZ1U0YrVkp6QXhaeEEwaFY2RTF1U0pOVncvcGY2WkU5?=
 =?utf-8?B?UzN3V3poTXpMZFBTaEFtNkRtVVI2aUswbndWR0xkbFZjbTFDQVpaYktoTDVt?=
 =?utf-8?B?bWdPU3RtcGMreTh0RFd1bUFzbjhWQmQ3K3RnNktRcm8xUzZueVFORkU3djcv?=
 =?utf-8?B?QkYxUUJteFczKzhFMEZtK0QxOGVxYzZyUjJqdUg0eGc0MHpVM0xHNHhOQmsy?=
 =?utf-8?B?Rzl6ZzIyL2xaWkdGTFNmelQ0ZkFnL3MraFZkUjdqS29ua2lZeXU0UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5b29be-fccf-4ce9-74c7-08de9e9fb821
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:43:16.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjeLjO1x/eOXZWj59SWVVdBCc8IL12Uvnl61H9QVhjEWp+YCAe8YMzo7PqkRCo2YUTkOT9wEN63WVJDHO98N7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7125

On 17.04.26 22:55, Tobias Schaffner wrote:
> The test is time sensitive and flaky on virtual targets.
> 
> Disable it until we have a proper way to relax the tests on
> virtual targets as we do for xenomai 3.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/lib/gitlab-ci-base.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
> index 76e38e6..d815474 100644
> --- a/ci/lib/gitlab-ci-base.yml
> +++ b/ci/lib/gitlab-ci-base.yml
> @@ -114,7 +114,7 @@ default:
>    variables:
>      ADDITIONAL_XENO_TEST_ARGS: "--vm"
>      ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
> -    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"
> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
>    rules:
>      - if: '$LAVA_TESTS_ENABLED != "true"'
>        when: never

Thanks, applied. Hope this can be resolved properly soon. And I hope
this was the only remaining fragile test case (not sure right now - we
will see).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
