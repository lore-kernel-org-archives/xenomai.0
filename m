Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10F2FE07D
	for <xenomai@lists.linux.dev>; Tue, 28 Apr 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392062; cv=fail; b=bbcyYjEKpa46fkLzSWYlrieQingw6iSg+NaQmCGMUpiDBnsh7Yv2EBW3hAiCk2DCAh10MoS6nlX0SwX3vrFx8H8VzUNbJZN1LKaqdyMd9lNajRcvA1XTSYbJMe7ItQaqtV6w6BWsHm7ig5SOLFzOmR1dEiaozYT+9zEL+67whvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392062; c=relaxed/simple;
	bh=NlR9Nz1CIKogravdq+HxvGB5b3fEfd0wxez84Jw+buk=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=mPAUCD1yjFVOIZfnAPAoC0TWBoj8LYQ2ekwpxdJ4C66aA/0LGGoUEaZwbfHD9e+4GxkTkKk0R1w/l9qmFLjyBN2OxB11AmfK9QfqjPw1y/EDQWWAi1UvuvfCLXBNfYSLZBqaH1tmORwF8gKLeh80/aUmMUMMkOoXT6IeTrmZtmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ApuYI9oL; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ApuYI9oL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G50iSpsS0v0TEVB2xQ/FqS+XVGxbBM+zETkq8W4D82ue3ELBn/JmMWFRQry9rqjo7mBCzZFTGqzA3oi+VSEfGASYrh/Eny4M4/RnM8nSy0bqO4zq1gP3cjNq/OyJ8aGQ9RslQV1SaCQM/by24re9dyrQkf3MV/iHhf02HRpuoOk34vZJ615e3vx1CpXrVj+ZVYfjwtW6YqqFFxl9WM1pd2i2aWHhCSzdTjKfob7mTRPzqZ0mQZD7C5aVaOqwufTjg805qeapBucKDJwzUm1RQb0XuWyt862RfBzxZGiaoqm/Yk79tYn7HXo5zKrEWKYopEyQ0YcvC7skiBdXKwWQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlR9Nz1CIKogravdq+HxvGB5b3fEfd0wxez84Jw+buk=;
 b=s43SYaSva7FMX3C+uRQatkERXbHgcQVsV9J2yxJIL1FxrZMQuxwf0C22sCvLAsbpZTz3ULeKIL0A2iyVDNb9aHb46JDoz3JS+pN7NTLPm4XCg71iHuIVirMgHLqgYUDHzXOsacGk2irGZMetp8hf95NtZDDB5KldkHKMQqVXrLNWfw5dDHJiJVdgu4xFjcNur6VTDDst7lEDtN1UgWnaXwO/cw+pj6Q4FWfuqH8MmbHwCeCW+iBB7NpMMaweso+UWEBIb40xbQdj2u8aVQQNoSdu4YFtJR78iiBrdKpqYLqwoRVDa+0X0hcGTY2LFrtEseipYHGCjGlTncx0gsItdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlR9Nz1CIKogravdq+HxvGB5b3fEfd0wxez84Jw+buk=;
 b=ApuYI9oLsNYUrrBE8G7FnMVPfZIxLt7qYBhl/VoF2thJ4x8Kd5F8rY3/5K0Xckf7APoHtmkonGJ40N/BQ979t4ZGxx+z84EgROFnhWQ9ssPwKxuH7NEO9igyJZd3DYXeX/0OaMMji8iPkvQwN8vitj8dXS8LT03GE+WNn0jyDpr08BU4sL/VOM4ugQ/VxWz+tpAOHMe84wI1sxcd2y7dCMkEgnKZwX/tf1Om/K5Kivuc2zes48dJg90tbRYuzFJ2g5EONMgh9e5ACwzd0azA+E8J/bMOzmjZDCTfJSP+Opn+99x9Y+pNgvVu63tT2Lo9KmD8UlDwVAPduxKAu1PWfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3921.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 16:00:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 16:00:57 +0000
Message-ID: <aa59f1d0-0755-45e6-9e24-fc19cd1beaeb@siemens.com>
Date: Tue, 28 Apr 2026 18:00:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, April 29, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
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
X-ClientProxiedBy: PA7P264CA0407.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3921:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ac663e-8c35-434b-c483-08dea53f559e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/SEkwbpOo4lOBSONYJ9Siyq45ym9RkxUCaKTbuhahXK8jjgvWZcbL/uYw+h3rewCTme7NS0927ajkRBqRDlgZZzSRsiWr7mWeqz4Tlr6BdH3hE97KnYYX1AAf4XwYZ70kGZV8EaVDuUO3n174WfgJYM++6GecZqtIC4K+Wj+/mQWXoo3gRaqNR5aB64nJ8lWmYjXsXPwwZCoCFL19HU8X0tw9pJGTWctiKRx10bNWnGVr/ZjT+QeAqQvFxjwT6qnGm3r4qvje3hFiOyo0DMiG/Vo4C6cZ5QZXiypQBuPXDao9GeeFkokZcKLAuvyd8V8sAMCBUXe6ZY8YFo5bsBwbSuy3mjMdsQLNAY8ioUSwWg0zuOoQYlVHDhZGepDNzEDEhPGmBYJYnjeihqX7civeIqPszynTlHBO8YarkyYAqvKw1K6NJIOS0ltXOmWoW7HHzMVwg+N8RC24sKqH8jifswC2y/IMWFOQ6XvsqKMmz4KO2LbCDG4X5A4w/4j8K58toWX+5JJ7jgZv6W4pBsIhNCSwFpWgpoS7sHkVd2EbWG0RXAD8Z/fRI7yDuS/G6ZEk842cG0y78JGwhmTzXg159qYRd/Ux4WDV9uURNhy22BGuxLMZj3lOy8yG8HBUKcEQ769KpiZHxgiE3KyavH8a7Hph1C2m0u9eniQckGdXS6gztJAkiVfug9U1BgD+L2AW90gnjJPn+txEd4xfU/j6Mi8CN8Q3xa1P825Je0GAYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEp2UW9WRFo5c1JZNU5wVll0QzZRSUN0NXNNWkEySDhuNytheWJpNytENXhE?=
 =?utf-8?B?ODV5a1hJbUs5UklINzRLMmNDYWR5eVhLRS9makFyY0FxNmdZcy83cmhtbWp2?=
 =?utf-8?B?N2RVTHBzVXh0L04xNm1RdzV4SDgycThmYnpja0pjbmFPQS9BQmg4d3kvRGc5?=
 =?utf-8?B?L0l4VVdPbFN4cHZ3b1d3YU81MDViQzRXWmdQZ1RLR0ZHR0lsWVYxc1VsR0xu?=
 =?utf-8?B?cEN2djMybm5UUURxZ2tqenpvVC8zeFlNcmZrdXhPVCtJTVZGQWtaRHRnQnFT?=
 =?utf-8?B?NkxaNXVYQmF1TW4wSExzdDJ0bi9qM2lkU1NrZE05dDZZcjBuK2FOY2Zkb09s?=
 =?utf-8?B?NERXK3lxRkZWa3FiZDFaU0cwdFNVUHhOdkZ0OXl6OU1SQ0FJaHB3VHpGNkly?=
 =?utf-8?B?aWxnakVMZk1SbStsei9xbUIremNSN0psQ002cnpIQ1FvOEx4RkNqN0UrMndv?=
 =?utf-8?B?WXF3Z0ZNR2RoTW92b2RLRHlnMjVtNm1qcUhhZm9PVk1xZjZIMEN4cGZGdEhJ?=
 =?utf-8?B?QnRib3dqQ2dyOEV0ZGdHblZQaWp6d253dlVIQ2t0SThiVjZ3b3BxaW5pZEkr?=
 =?utf-8?B?VFdHeExBWDdOcERuN0RGLzdOUmN6SkZvR2lJOFByeENJendRUXQxbEFkRlNa?=
 =?utf-8?B?ZDZiakhhTUNGb293L201NUg1aVAxOUEreFNkVENKckpRWXNaeWtTS3RNQk0v?=
 =?utf-8?B?TUV4QktBZC8zK0JRc2xjd3FQUmEzWi9vUnl3ZG9hMm5ibUVFUjhZSk0wZ2dN?=
 =?utf-8?B?bkM3cUJIaGw5QXVRQVByeGFTZ2pUeCtwNDFjaDdRVDhMenlHWVVRemxWbmtQ?=
 =?utf-8?B?SFpHNU1UZ0YzcnljOTE5d2xXL09Rd0g4bmFrcmF0ZnkxTVp1RVFhZlpGeFk4?=
 =?utf-8?B?SUdKQVhVL2Z0OTJYWkJTcU05N2VYbEJNYlpPczNVUkNYSUpsRURxQm0ybG12?=
 =?utf-8?B?Z3VDSzZzOWIwNzZ0ekVvQlk0SldkVmcveHBoZ24xUWRvenpsemNDRWxxaGx3?=
 =?utf-8?B?OElEc01zUkcxdXRTUnhDc0tzNXRVTXBNaW9QZEp0ZzJHWHpqL3BkSkJQQzhS?=
 =?utf-8?B?dWdLLzQvL1pYTXhqZ0RmVjEyUE5Ib3pjRjlnazQzNWN5YW1iak5ldVZUeEpu?=
 =?utf-8?B?SEtML0JZQ3Z5KzRGSmRwRHNWM3lLcm1yU1l4TmVOSktRK1piemlsNFZENnly?=
 =?utf-8?B?WS83U1VxSm9RdHJ6NUJIOUtNVTh5cXB2c0RUWWNPNFJML1BlWnNxTDRLTGVu?=
 =?utf-8?B?SENKVCt6T2dXNXpndEN6M1laV2RJd2ZTMW8wc01iWVRicHozbkRoSUZMZFpv?=
 =?utf-8?B?UEU2TXd0QjR0MmdSLzErQjU4QzRYSHNEL1BFYmgyMU16VHgzNDMycko1V2VP?=
 =?utf-8?B?eUkzVGFnbnBGSEd3TzRoUm9EdUFuMG5CbzJZajZ0QW1qcEJ3Z3BYeHJ0Zno4?=
 =?utf-8?B?TWg5ODF4RUVZMFM2enpPZjZyWWxydUxmdFdha2J5YjZDb2M0cllCWGlQL1cr?=
 =?utf-8?B?QlBHNWc0VHBHK283aFFuUnNwZFpxQWQ1TCtqWld4N2VGVDJJVGFmU2F0YVFW?=
 =?utf-8?B?OFJER3BlbVFDc0c2ZE12M3crQVk0S2FBWWhvYk1ib2llK3NqaTZFZmhGUWtU?=
 =?utf-8?B?S3dSY2F3L1VlUkg2bDVlRlduK2UwSk1yUHEzQXBsLzRkVEtabWhTSTZqRUlz?=
 =?utf-8?B?dGdrVHpVV2xERHpqZGI3VCtHRkJONWd3cVdRQkdNWEM3eTlDSEM2SmYyMnpO?=
 =?utf-8?B?RDdSdlNhRUh6VVpydk9rbkVrWjZSUXdtTDlEdkxNYVRuMUlqdzA2bWJkUXIv?=
 =?utf-8?B?M2hpQTlJTDgvL29aTTVVQis1cFZxSXFhUmthdzVGQVBoQ1hCZWlzS3hnNlZW?=
 =?utf-8?B?ZkMwTGVkVzdab1VRdytTNHFrS3ZLTnMyVnIrU3M4U3VxWXhQRkQ0TGl0dVZZ?=
 =?utf-8?B?UDJ5ODdVa0hpZnBrNGM1dmZDZnFwYS9PSWY3MlRDRU1EV0xvbmdVdGVUZW5X?=
 =?utf-8?B?OVFVYTVvZ1V1STVueWJvYXVmSllSdVZGTDRuMk9tVDBnMVNwSWs4clpZNU5P?=
 =?utf-8?B?N21rUWRkZy8rN3h5U2hueGFidTJjMlFYUzdOZVJuWUZGdllwUC9CSFlXRmNV?=
 =?utf-8?B?bU5nTGttN0ZlSk9YemdPaDBTYWN6NjNubkhIdklpTElEalRqQWtQQ1JYUHl1?=
 =?utf-8?B?M2pCS2FDc1Zjb3E1YnB2ZWxhMTN2dExTdTFhWDJUenBZeDhic1lIdTVuZ2Nj?=
 =?utf-8?B?VlVFcU9kZjhjUW1sL0RZSG9HZHBXSlFWUDRHMEdRak9Ua1VEdm9RcmtweExU?=
 =?utf-8?B?NUlmdUhQVk1wY29GWWpYTEsvMVRaNHBRbC96dXVMZmd1R1NHWHdhUzdwZ1Mw?=
 =?utf-8?Q?MUuFPcyqMLAMFrdw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ac663e-8c35-434b-c483-08dea53f559e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:00:57.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/7WHedk4KQhq3dvOQayCTk+cBoGYbAdV4hlW2y0bO1bYPY7I6uIMXf3nMSnGWsI77HUwXvVeF2iensmY0DGJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3921

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, April 29, 2026, UTC 7:30 AM
Paris, France CET 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
