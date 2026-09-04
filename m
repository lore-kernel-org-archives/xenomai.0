Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD42501F4E
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539792; cv=fail; b=ZaJoB8c+hE/5DtX1H4E1DT6ne1R/kPHJEqJolXpQG6s2eEVLyXEuIsQJFEKWpI3PG9q5Fbj/REudySRRVdRwYkLqyiQAUgnEyEgqcGVR6bOi1pwE+hB+5pEZEeHSLLZh8HnhFlEe8B7vMqUZQpHUc7VjOBY/jN8tM6garY/iNYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539792; c=relaxed/simple;
	bh=MTfdYE9Qt+tydglDhb3c4uNLX60B/LcL04zTL4BhCSI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgooTI+IX9KUqZ8CauHYf0nqwSgi5SZETnO8grgKIZh9+iHsvoE5NwPfsC4z2KBrVyXa/andOZZ0em7MWPo6/Y3/s9a3ikz8GRSBrlnjfkctK5tVPX6AaVxhhQbqY10BOeslo0DgQJTcGqIkolgtl9A2vS6nIq5T1DIRWI5764g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=t3jQHkNN; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="t3jQHkNN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw03lO99gHQTWibq+WIY33lcB3+M1LAcKjXwvdj7jGQJZtZjTQs/N/wtIF/e82YSxmGElQzN1JgOC9q8yWokc98fsuOXEgyit+q+k9ijX6iqUDAv024x8EPCfqJLwIBlq/OK7sBCZpr1458lV2EfAy6Kg/U0CkrALpCbMwfVyjNSZI7Cyxy+1FhSKnh1iqUnJff6BVG70PYxpm3/pEoDVrI25fMhAVhGa/crXihG+inCU+s1+qfWJhnA50OyUXCNlTU+x83xCSagcZrIEMKjDwKx5JE8j8w7pFNcFsq5UDK6YIvQYaGgRA8mua/wAi/VRCWzfI8YgMf2akqOMcH6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzWgWq2c3qj2IIieGtl3WweedPHY55ke4KSzWc4mOpY=;
 b=BNn4rXa9BvVuTn28gUQZJ/5oiN1rvqtaTOD3XE0b9uKGg9j+hnypvV4ZfoPUK7KSQUXXnMcmFtsLexM1nHOph/2AjtAPwdsuqyJqUJ74QzLYSxjgWfWUPFSNrkLQ0EH548c1XMaoOy7Q+ffdQUWfMM5KJOPsNkFkemqpastR1WxZT4MLwdH4dZoqPTy0EcbNkcZ8AWJLY23M8qZUZADyXgT8hSyv2U++W05flvsW1mNyBA61VKzqqUuVoym2NAWTayVVU3uiIfKHBaaXIOQfPYZc4nokNH/HN4bvwak4PEKMNqWgfyyjw+0yx9I7S7agcm2iIUF4wqKwDolJWgrveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzWgWq2c3qj2IIieGtl3WweedPHY55ke4KSzWc4mOpY=;
 b=t3jQHkNN7tE54ToyA2qHOjO8/157fJXalMFx5h7RzrKVQ9yXpDil4j4ZWicOrrctjDr32u5Cj/qNpJ5UKlyBWOMf935nlPvmrj4Jp5mm+ebXj0osJw6y4KaiE+hbcpeykTwMZiF7+ll8cuiagwhHyuDXOOeb4SKqXAvSN6tFHg+LFJuMlBkXUyVf7nkbyTVGkiPp3ofXbxWspoF3gvLltH9+bNJdBg7NQVjwR6ug+W88G0SISaARxrZOUOUeRGAyppH/tPosDmgt6BeHHUjQGjOpVA87d/ytPBOyYSgMo+aR/dT1om8qhzNZCh3IkdVDfyu5fidZLYQ4JAfh5cetWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:36:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 16:36:27 +0000
Message-ID: <c89187ec-0fc7-4157-bc1e-4535e772eec5@siemens.com>
Date: Fri, 4 Sep 2026 18:36:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] linux-xenomai: drop the custom riscv
 branch override
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260904160710.1502327-1-tobias.schaffner@siemens.com>
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
In-Reply-To: <20260904160710.1502327-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3603:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c2d935-4bf6-427d-fc29-08df0aa2aaae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|6133799003|55112099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	2F8Jvi0QJUrguQq8fK1rxmVNhgDZKmhm8Z95RWvVVNvPdcvLrdsjMDhXkdr9dD201DayPU6frebkx56QQ2Jv2wncCdn0iMQV8i556htn1ap6RrG5Ks/8Ma8+j4XDehJjBjzboS/ev0Z0dZiNywsH7zdBLIc4bhxBl4+YlCCQSsKM424uNYr7ggDZWZC/bP/7PUvl96Nv5OMJ/L17De5za/b6/oT6g7AoKylajoaGDkyeo43T7hqRH+pofB3u0f962Xa+eFzo67sM6CHpE3sh+6RIjRTN+uEBhfv3d6qt9jOFZlGD/52pE6VJCEemAeDxH49SqEQlSk2GPQXFcStr6JgnT8uQ7VYoGkV8h/cKSa7bPHNJ5jEGrP6Erl79EdabquTG9EcAkANndqT9kIRSaGPwzllXfBkJ8AE7TAoj9bVPfWY8lv84QV5ciKqSNOQ0ZM6fPEv4+v0y7BKZ/eSa8C5oW+8yyp+WHXK66g6ODLe1ecSK82mbvGW7scGr5/sINv/kgk/scRg7KiaCDPPLJD8mAdGaHmn2LbCXTQHDzrujt6Qs2JQKicN5zmBqeWJlIscFuUwX+eRqI4gpX1QbO+ATggG++LMfA3ewqn5e0F+qBgWiAQa+WbxTcP31x0sVIJ29/YE1OvdTl0K3YwaNDPw4Oq5hWMLw7y7nSCXyZLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(55112099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVBRL2lFSCtaeTVsTG13NzZwbDlvV2NyZlhsNG5KQ2dDMkd2OE5jTXZ3d2NL?=
 =?utf-8?B?eGI0VHovRGZxOVdmV24zNUF0bUN0RzRyNUUweGcvNG1OdVEwaUpyU0RLL0Y2?=
 =?utf-8?B?QnY4aURkVjhsWXYydlczMFhqL2ovMVI2Nm1jcEcvRU44ajhJanhtVEdSYmdp?=
 =?utf-8?B?MGh3UWNCKzRtbS80RGZUNEdKcEpnR3k4TzQ4MUdwM3RNbWRKb2xiK0VEeUps?=
 =?utf-8?B?ZzBWeHF5Rk5WNGxWMGVQQkMydDRCeEY4NENVUWNQWlI1ZFQzbVNPOHNpQWxW?=
 =?utf-8?B?UXR6ODlYRlBhMlZuVFl5akJLK1gzNVBodUp5YjZFVHhjMkRGb0U4ZGJmRmNI?=
 =?utf-8?B?a251UWRacVI5VTF3R1N3TWE4MWQ3cVFqSlF2UWhaY3lhOS9TbUdITHU2Mkdt?=
 =?utf-8?B?M2swWmZnNmhzY2FMTEVycUo0YWQzenVuZWFoQUlrN2tmSzV4d2w1QVhUenJs?=
 =?utf-8?B?cGcyeldlRlJtT3ZBQ1JLY0QrVjlXUWFGTEoyaHlmcTNhWE10TzQxZUxhQU01?=
 =?utf-8?B?ZmlJb2J1NUxBOEZ6WjA5cmdnVXFUT1JPL2ZvaGM2SzFwaHJOTVdwU1NBN0Np?=
 =?utf-8?B?dVZaM2pIUllDTDh6c2pueStSTEhCbkZ4S3o0SlA3UmlrTUdpVTh0cGFFdWVO?=
 =?utf-8?B?WG5CU3k4UGxEOVgwQkE1V2VLZTc4UVEwTDgzSVh1VFVOekxxZU85Y0lCdVd0?=
 =?utf-8?B?ZGVSVUV3bTdOUEFzaVMxWVRKNFM4SGtrWHJCUno1TE15NnhTL1FjVGhNTXNj?=
 =?utf-8?B?My9iWWlqNk55ZG1FMnArUlFaaEZOSkxsVHBId0w3ek9ieWpDUXBqYWJXczU4?=
 =?utf-8?B?NEZqb1gwcm1ZVHBYOGpleExUWitLRGhqS3ZTc1drSEJrNGZncmxKMzNyaTZw?=
 =?utf-8?B?UldLZ3g1M29MTDhuaG5uaXdYQlc1Y2V3T25SY0cwM3pTYk9FTFJFL3pXd082?=
 =?utf-8?B?ZmYzN1dvM2x5dDE3cmNLVnZOZGZnMXc2VTIvVWJEKzdJVTU4bzgxK013aGVE?=
 =?utf-8?B?QkVyVlpOU1VZSHk5VHBBaWlBS3gzS1ZtV2VxSFBJWm42QjNqWm0zOVcvZ2Zv?=
 =?utf-8?B?NEJxSlVKYUdtYUMwOGlnVHBrb2dRb0ZwanpwS25uTk1xeGZXRk12V0tkYjEw?=
 =?utf-8?B?NjVZSnEyWU5rTnJSQWJlMTIySHUyTmE2T2lIaDBXT3JXUTNUUkNSa0lvUXVx?=
 =?utf-8?B?cXdHbTgrVS9oMG56V2pyKy9jYTNlUmhLTGR6RlRTblZhTlVLbXE4aHlKYlFU?=
 =?utf-8?B?eG4vd2NRM3FUY2RFZVUwUXByR25OVGFobTdscVJXZzhZNXA4NWpiSU1ROWpU?=
 =?utf-8?B?OTdFVkQybUhwTHlFd05EQzhnUk9BcWlRQysyYno4SnZtUW5pOEJ2OGs2QVl5?=
 =?utf-8?B?V3BUSmZ3WFZObURmS1JnTVBwUUljRVNhSHdETUs4TFpHZTlXeUpYbDdraE91?=
 =?utf-8?B?L21UMWJScmpmNUV2MVNyNVNkRkVZSG5QSGZRbCtBNmRWdUNwY3BHYzFCRU1C?=
 =?utf-8?B?MUdERG54SUh6SmNNVThjYkIxRVQ5a25kdCszTTkxcDBVc0dUbU4vZkJuT1JK?=
 =?utf-8?B?M2gyM25aVCs0c2FVSGVKbSswQnNFTmZUWld4U0tGbTFNVWVxUXpiOXhRZnVJ?=
 =?utf-8?B?OTdMNmoyRkhoTk1xR2ZXU29MNS9oQ2lnUDhFT0Y1WGt5OWhhWDRWUDJFM0pI?=
 =?utf-8?B?NU9ZeVlPN2FxTVFqQmNtYlJJNC9LaUNCZ29PL0V0L3F5RUdaMWtkSld4Y3pz?=
 =?utf-8?B?RFdOVHhGU1ZqVFQwN3JKUUZiNlpwTytYRGtLak9hbWV2QnozSktjenhGZ01q?=
 =?utf-8?B?ZFhTdWlWVHBDOTRNM1FQQ1lUWEc4ZFhDZU1UWC9ZcEt5KzZMU2lWajRKQ0la?=
 =?utf-8?B?cDc0QmJHS0cxTk1leTlxMFJwaDQ1eGtOZEw0NUUxQUhXeDNXamZORU9FTkta?=
 =?utf-8?B?TkRVMUlYV1pLenFyMXhxRFVnTUw2RVp0SXhFK3EvT0Ixd2ZtOHdPUjBaNDFZ?=
 =?utf-8?B?VzJjeFAwN29PVGNZaFZ4Y1ZLOTFtOXhnME0wNzFORG5IbzV0bFV2QUx4enpZ?=
 =?utf-8?B?ekhHWTBUUkxZSnQrU0ZINWlnMzg0OUpmTm4wMG5KL1pDSzkyakVkU3ExclU5?=
 =?utf-8?B?ZitVdGp1NXhBc3F2azBPNmE4RFVLb0wweU5CUER2YnBiRlpwcXpiNDcxNHl5?=
 =?utf-8?B?NmFZUE5peElvVXZjRmZndE5BdWw0YWVFMmoyYWF1Q0lWTU9HSGFpbXdLUlk4?=
 =?utf-8?B?S1ExRTJzd0x0ejB4ZXJ2Mnh3R25kbmg4NWtVSFBLRkxjYmdyalp5SDVETUdi?=
 =?utf-8?B?WGlLSlh1eG1hUWZteFhMdGFEVFZWd2p6NXQ5RFNJVzRjUlR6ckRPdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c2d935-4bf6-427d-fc29-08df0aa2aaae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:36:27.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3opUw5nwqMmFOv6815rxLFRkPholxUhs/XGcMda+HqnbSXj/x0HBgHbBYZ30NyJt5qV198J5WbliUw6W2r0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3603

On 04.09.26 18:07, Tobias Schaffner wrote:
> RISC-V support has now been merged into next/v7.2-evl-rebase, which
> will be autoselected from now on.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-kernel/linux/linux-xenomai-4_latest.bb | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
> index 345809e..e0f743b 100644
> --- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
> @@ -34,7 +34,6 @@ GIT_BRANCH = "${@ \
>      'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
>      else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
>      else d.getVar('LATEST_KERNEL_BRANCH') }"
> -GIT_BRANCH:riscv64 = "wip/evl-riscv"
>  
>  SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
>  SRCREV = "${AUTOREV}"

Thanks, applied. Let's see how it goes:

https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2821087757

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
