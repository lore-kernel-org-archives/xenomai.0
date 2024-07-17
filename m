Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF01E526
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231677; cv=fail; b=JGZ3F7c7xEQz0kxAHv/fp4v1MjuiFUQSXc0a7gMCJfclBSf7ZLJb/0DUr0pF6S62RFihKPgXzGglr5CDbf/iSf2A/7fGDELshmfgRYL7BuntppDdiDDpUqbN/+PJl3lODV0h9Tb57sD1h/dmCEjr51KNcjtYdWy3OmwUeYnipPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231677; c=relaxed/simple;
	bh=eQ9ezAd5yawTrt9Fd8uP7hpsJDFsODhkeYQF/AnKfog=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gl7APimoueEY3enyMkhDjUyH/W+HjDeibUoFiVmGpENHKtRptT5kJhzec7dNkb/x09i2lGQPvM95p5KkeD/PRiR2uGx4DLD/gZebNejNl06AA/yo4ksjj2ABEKQD/yO2FtiUh4+yD7UDbR6OaCyUl9XQPSYz7xffSMspP1mAxks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PAHxKLT3; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PAHxKLT3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2XIQi9zf8+3e1cX3zaUG6tDQGn9oU+UueQvD9oWDJKWcuXF7J1iaUk474UcESzuPKK2W0MFu8m1OgwPJWTdJQB1fK4wvPFr2AcrxjdRGEa6hoIJVsKh23V38nL/MSAoyoi7L4/VBcviMkfIrTxQ7PmIAX4fP57pxCBDbI7kG3t+dIswKZugI6dmPM9XDkwTGIGvWSIN7aJbf0mj5t/ulnQby8yYUMlEzzaxG3BiS2V5YS3114AW9NpFpaG6w0LgmiwfYmoNUOVIYYQkDVopiZ6xaWaq0a54JUoG5MdkQjpOEoSgu5mcqAw4HEbZDzfkzP1Ji18dTfTJoSsY0IvbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry9oW3oIB/DFW64CjbmYd0hNona1RRwYrCD0xNvhQo8=;
 b=uwfTEoLVobD7YqZZUQNH4W+6ShREyhNRab7yuIvoTjDBF24cDudfx890XFZQp7cQgCUYG8FisRve51wWP340U31YWfzB1ilJ3EnPMLNiQCfslzXg99F4M6AYjCWKiEgb6LLRyBZQIAaWIXvYwXqPwISl2J3IGaFni5ZYqT+tesULIHt6cmbagSvGnGg4AeII+ClUDfHqzwBsiap+lZizgYQcztniy/Wp2YvAVihXHlqYLbQEpJtrQJchiNm3eHTkpKdWWxO6dNg0xpUHlCLr5gEYRar17Lmrg5iKXd5bCZIPYJYcyVT3p4toLczEX8omNNrGnX8SVcCR5waV8TzLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry9oW3oIB/DFW64CjbmYd0hNona1RRwYrCD0xNvhQo8=;
 b=PAHxKLT3KWXxGUaKrsUr+8qyz9u4IVIl6kXxrUNqjrbeFxtVskB87QFjDJxQ0DdzgtfJzf/kwd/cyPLowU50gT0Qmb6y2GrY53x6MqY7UOACZYr+wXje5jNYWYkftYi4OytoHvnu13nOvCuZEaK45xQLHptPn/F5RjOsEtsTd6q64Mxov1HnIFERC9bgar/o4V5R3CohXK6PqvWSVtmyejMukwjMEyUPxgC80yNHoRxcCaqipsOViGtbiZyy/uAR1+ME9m8KmKk8G8iAdHsstU9c+au+24f185b1ra61NN1hRXYVY8j8tOSioaw3OZb6cWT2Micgjt0qtW4+dUT23Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 15:54:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 15:54:31 +0000
Message-ID: <b7f5ac63-7cc9-4443-9556-f411311b23a3@siemens.com>
Date: Wed, 17 Jul 2024 17:54:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] ci: Add latency threshold to longterm tests
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240717103748.161788-1-tobias.schaffner@siemens.com>
 <20240717103748.161788-6-tobias.schaffner@siemens.com>
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
In-Reply-To: <20240717103748.161788-6-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: e9226333-ac42-4926-b819-08dca678bf52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnNCT3RVc09pbmErSlY2VnhUMEV4Y3k1b3R2YXZ5aDl4b0Q3SGtyU2dQbWsw?=
 =?utf-8?B?RzR5cEdnM1hhYXZseHhQUXFXeVF2SkJQR1NiMS93TnVrdE1saVYrZGNxQUk4?=
 =?utf-8?B?WlVnRmdrdUdCYjBVNnJmSWNPWXNzSVEyN3c3d05uQUpydGgycEo0RzBzSXFJ?=
 =?utf-8?B?QmhnV2tGOTYrN0tjYk16TGtiZC9sV2c3OFZySDkxOElyTFRYOFN3eWNiK1NV?=
 =?utf-8?B?ci90QmdXMjhML3hWV1lFeE5KRG5mUHlKZ0xhcnVscXAxSGxYdERVOUlYUE9q?=
 =?utf-8?B?TWgwVU5CQUZvNGhPbXBJNmVFM0dYR1dCZFV0OVJ6RVd4WE0yTjRNQnhrTUE2?=
 =?utf-8?B?S1VicE11RFk0QmJHR3pVd3p4bHU1ZUhsZWZud0ZhTHhjSWlETCsya1NQeXE3?=
 =?utf-8?B?ampmK0h3T3Noc2trSkVSRU5mUlNPUmRkK1ZsK2RVbmhLVEJqSStvK2tBdXQ3?=
 =?utf-8?B?b1dwaTVxazJvaU5ON2puTUw1b3J1clpSeTlxcVNJWVZGU2dtcU8rMCt6bGpo?=
 =?utf-8?B?clllYkVaVVdrLzBrcEtkaDBnNjlXZ0o0N3hPdEhQcFcyL0J4RXptVndiaWs1?=
 =?utf-8?B?V0hDVFRuT3V0TFdOU0VQRWtZQ3kzc2FOd3BTb1dyRzUwT1hyZnN0VE5pbFFz?=
 =?utf-8?B?cGR0cENreEVRRzZCcWpLdGIwblQ2WEtvQTltMGpQMWJlY0RyM0hkLy9FQUNU?=
 =?utf-8?B?MTdsU0lEQ2tEeUhJblFSczQ3WGFRQmpOTHRQTGRVNWRwK1pmNTFIUVRRTW9z?=
 =?utf-8?B?YUNrQmpwUlVZb0M1MHQvM2VyT29JYW8wRFJodFlueTNiSGV6T1ZCbWFLZ0RM?=
 =?utf-8?B?VFV3OTZyaU4xZHBOczVYYi9rL1A5MVpPUHhsWk9ZZkNCSUVLTzNNOHYwdkQr?=
 =?utf-8?B?b2QwUWtjVW5PRkRNck5kY3NvRy9EU1hVK3RoL1RCK0FQa3Arck5kOUNIc3ZO?=
 =?utf-8?B?a1RKNUc0WXlyWVMweTEvUU5YS2pVN2V1dTk3STQxNGZmdDRqQk1tY3FRU3VP?=
 =?utf-8?B?YnBUOTFrOEhBVW8vR0NsTVJsNzNnU3pKRE1ZZ28yanBqblhGMjkxQkVyM2F6?=
 =?utf-8?B?NHAycXJEQ0R1U05ROHJLSXpqUzF2UkZkbHhZQ2JmcFh3K1JSaGN3ZU9lVkFV?=
 =?utf-8?B?ZGtvRHp2VFlVR2ZDcTNrd0hlR3o5SC9yRHJMR2tGdTVVTE16b3d5N3lNd3lK?=
 =?utf-8?B?amRHT0dNZWR6bWl3TkhQSHd1clpES05mUFh6bG4vN2xOcXhtWkFJV25uQ3dE?=
 =?utf-8?B?ZTdTeENRZ2RTNUVSOTJRSm9Zc3JJRUNiMVNDOWdtUWlPVnhuWTl2d1AxOVdy?=
 =?utf-8?B?WldwdktaYitKYVRvWlBldGtZZHdROStjeUp2bjJzTnJ2RGRXUUJTQmVRcXd2?=
 =?utf-8?B?eHFYY1pqemVUclB5YldXZjUyUU5IQU5pZnBTSStUMU0reEI1eHhqMlRHTmxp?=
 =?utf-8?B?Q1VnaTA1TzhZcFdvVEdjS0w4R1dwN0hwanlYZnh6Z2ZueGJhem1sc0VoWTY2?=
 =?utf-8?B?VmVXMXlLN0t1eEpxWFpvY1NMY2xMOHptT2JGTmRZbVBvS3VVNkdQczNaOWFx?=
 =?utf-8?B?Um5TSElHWldicnF4MlAyalNrVUNxTVFXTEQ5cXRGTlJBVDRwMjJxWDFwSXh4?=
 =?utf-8?B?emE2YzRka2V0dVRzZ2Z0Q2NDYkhuQmpHaVNwSkp4NUp5L1huUlhNeUpnbDlq?=
 =?utf-8?B?ZWVEb252UkJ4QnU4U1E3QXVid0ZDTCtRSDB1WDg3UWRjWlB5bm1yZzBGdjVz?=
 =?utf-8?B?blJzZ3MrODlLNVYrMy9KWDY1RWdzZWZDdE9pazZKNy81TUdUb2xVMll4bXRW?=
 =?utf-8?B?THJBTmt4THRHRk9MQzV5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFYrY01oUVhxWHFaWFVMZlBZTVdMcXNSYmJCbzNKMkxtbnZ5UFB3Q0R5eCtj?=
 =?utf-8?B?Y2wyOUhoRXVCM0xidk1BOVNnQXUybEZPa1prOVBCUXhtSFJzWlZCQkhybXMw?=
 =?utf-8?B?NlVHMkl0RHpBVVYwYk5FT2psTjY0S2sxWE96QlpNQjUrMkxwMk1XNUlUaXJa?=
 =?utf-8?B?dHprQ01YdnN1ckNaQmMxMVRUamVRalFFeC8wbnhHUmE1THIrVUJNZmxTbFRx?=
 =?utf-8?B?SVBlcGdCWDBMM21wYVI2dDNQWXYwMlpXRStTY1JKSTRQWVpVbHdZU3Rlc0t3?=
 =?utf-8?B?OXJBUndqSmhyOHI0M04yaktrTzcydkZNWTVvM0hnelFjeXRDMWtKMlJsRWQ0?=
 =?utf-8?B?UGx2QWU0VldST3loZGlFNmdZc042Wm1HQTUwdHl5aVh2ckhCeVhVRFRtMEdL?=
 =?utf-8?B?Z2Q3a2QybVRHWGYwaUFqeTBVNERxWHBxZEtVemZHazcvTEFsWHRSZzhCQkpO?=
 =?utf-8?B?dXBBOEEyeUtmenk2QWk3OUtmUzZqbDJjNkcyU3VjSDlLeDZDUHhnUnVtRlRz?=
 =?utf-8?B?UWpCSEVHTjh1OTVBR2JETTJpd1RXc1pxVDJJUEIvNmg1MDhOb0N3bzVSdmtM?=
 =?utf-8?B?cWI3SzRJZ0w4S3RhRkFLUDR0TVhLb3gyOE9yQjFrL0xpZ1BJWThSR0h5RGhD?=
 =?utf-8?B?M1h1VXpSUHpTQUhjNU5NM01SZTF4Rk90SWJVL1VjeGhGeU96UzFHWVAwKzA3?=
 =?utf-8?B?aDEwdWI1WUhsdUppRkVlSXU2TzZIbGpHbUJ6Ry84c2hyU3JoNWttbFBVZHQ3?=
 =?utf-8?B?aFBPMlFnVHYzTFFtbWZmd1lPWGZLdG1kdWtZTDB4V2xhaHNFWWNUWkxvMzlt?=
 =?utf-8?B?bFEzUGtpYlRFRk1kbEExWWJ1cFM2bHN4SEEvQnFTeEkrZCtVWHcvdXdRZ051?=
 =?utf-8?B?eExrT3kzR3NFN21zQ3UybGJiQlRJMTBJOVRiUlF1OTBaVUlmaSs3VWVuVDIz?=
 =?utf-8?B?NGFVUnVmODBGWWIwMWRoMEp3RUw0WlpleUpaUERpVDdXdnZjcThyUFlJeWht?=
 =?utf-8?B?aDZWVUZrdjR4Qkt2MklEOHE2WnJ1WXIxb3JieVpPQzBBVHoyek1IbWVCdUt3?=
 =?utf-8?B?R3pNYmxLQ1hDcjRrbUU0WTQrRkxmNlpHNURjUE05c2lGZy9UMEdyczljMENW?=
 =?utf-8?B?bmlZYkp6aWdZbW1IbUhmTkZpYjVualp0QStOc2JRM3lxMXpZOUFCLzQ3VzVw?=
 =?utf-8?B?WWticmV0bDJoa1pabmUwV3A3c281UUVGNllpbVdoTWhlZWVOTkVTUWdoRVZa?=
 =?utf-8?B?RS9CT2xNWWF6OHBrOFZpc21OeldoR2J4WTA3RXcvTHZEcnJROVA2aHZ3aWhL?=
 =?utf-8?B?T0VQTnFFemptRFFWRHl5OHpCbWhGWnVPcG1GclhybHJsVElKUzlSVzJRV3Fu?=
 =?utf-8?B?UW1ia1NjWTJueXhyeGRLb2x0T0ZWOWxGL2o5NlY5ZE54UDRWa0RYWEdTc0hj?=
 =?utf-8?B?UkQ3dERhMFRDY3AvTDBQZ1RNSDBvVFBxazh3MHNSckhSRDROUEFENit1anAw?=
 =?utf-8?B?b0lzUk5PbjNjZll3L2xLT1QycnExQ0hSV1k0NmhQM08rL0I5N09iTTVqMmFk?=
 =?utf-8?B?U2tybFQwbXZ5N0ZBWmNDcDFsNHdCd0UwNDAwcFczSCtPOEZaQUEyVEgvZXA3?=
 =?utf-8?B?VWcwamtWdFA4Wk9CVWVvdktRcGxvMys3QVYrV3gyUFg2a3VHVDdpd3c3N3BD?=
 =?utf-8?B?K0NvQTVaZTNyZjVoeUJYbHFuSENqQTFnOEgweW5YbXNOUkEyS1Q4N1RZL2wz?=
 =?utf-8?B?S3M2a0J1dldTWm5pSjlIcW5wbm5PNFZzcW1Kb2c3dUoxc1NzRVo2MkpRUmV4?=
 =?utf-8?B?WmhuNndDWVNpVm03MG1US29QM1hoUEk2SjJlcWZSV2tXaStHbWJsL2pWekdj?=
 =?utf-8?B?Q3Nrcml0Q3JrYU5xWDVTR0MrTnQxNFRnUWk3eTVaWGVOd1AyWDlPNStsdWxn?=
 =?utf-8?B?elJqeDRqT1h6NWZraFlLZ1VIVEswZ1NtSnZJT0hKSXEzWHY5cFpPNlhFdmpU?=
 =?utf-8?B?LzFpcXdud3ZmbW9uTHk5WTFTK3hWOHJGNmhhQksyVVhKUkc1Z21ZS1dFNU5W?=
 =?utf-8?B?ZlZRcUlkbWV3SFhFemFOM2l0L3lmdGIwRjJFdDNWdnBXKzlaVlZlcDhHQnY3?=
 =?utf-8?B?NFRtYk4vMFdrWUZkTW1qWTQxVDlQclFiRnZpbWFxaDZnOU1abE9iSHI5ZUhv?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9226333-ac42-4926-b819-08dca678bf52
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:54:31.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LslJgomARP+D2TXsngSoBE7uBqhN1BB/wihZpqaaL9cVwXga6oG8tbcwofgRI/bF89ziyTURJAB/V9QeHiuRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8611

On 17.07.24 12:37, Tobias Schaffner wrote:
> Add a latency threshold option in longterm tests to guarantee a
> worst case latency of 150us. Fail if this latency is exceeded.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml           | 1 +
>  ci/kernel_6_6_physical.yml      | 2 ++
>  ci/xenomai_3_next_long_term.yml | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 29960b3..bc9d525 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -22,6 +22,7 @@ variables:
>    ISAR_DISTRIBUTION: xenomai-demo
>    BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    TEST_RUNTIME_SECONDS: 300
> +  TEST_MAXIMUM_LATENCY: 0
>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>  
>  default:
> diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
> index 95fc4f2..e57eea0 100644
> --- a/ci/kernel_6_6_physical.yml
> +++ b/ci/kernel_6_6_physical.yml
> @@ -21,6 +21,7 @@ lava-test-6.6:rpi4:
>    extends: .lava-test:rpi4
>    variables:
>      KERNEL_VERSION: "6.6"
> +    TEST_MAXIMUM_LATENCY: 150
>  
>  build-6.6:beagle-bone-black:
>    extends: .build:beagle-bone-black
> @@ -34,3 +35,4 @@ lava-test-6.6:beagle-bone-black:
>    extends: .lava-test:beagle-bone-black
>    variables:
>      KERNEL_VERSION: "6.6"
> +    TEST_MAXIMUM_LATENCY: 150

And what about our x86 physical target? We didn't split that off -
forgot if there was a reason or if that was just missed.

> diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
> index 5fb0de7..e3740f5 100644
> --- a/ci/xenomai_3_next_long_term.yml
> +++ b/ci/xenomai_3_next_long_term.yml
> @@ -18,3 +18,4 @@ variables:
>    XENOMAI_VERSION: "next"
>    LATEST_KERNEL_VERSION: "6.6"
>    TEST_RUNTIME_SECONDS: 3600
> +  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"

Jan

-- 
Siemens AG, Technology
Linux Expert Center

