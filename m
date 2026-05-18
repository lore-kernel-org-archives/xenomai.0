Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271E3E3C4A
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095797; cv=fail; b=guNOfXJboUXuxPodZwvAhCn1oafccjk6AkQ8xX27+t03B9YO/Wytab3dtI1v+Gztaz9eRrVz0DPxXZRB7+7mbJb6T4lUML4PV/ByJotbQz4Sulh3kEwSCrOxNzjJo9UJAX1GU6omUBqCB0mT57XvkL73+YSze+Y9jUb6ieRNzM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095797; c=relaxed/simple;
	bh=3cFVhxWb3WHRINQd9py1TPAPVECW/v6uwifa3maE2hQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SSyPN/hE4+aSekiRVk8cPVF0lDSs8EPqkXg6H/JBkdspWOUL22mC5S+Qoe5GOA/O9nVEWrHKyxGjf1GyGw02nqx3/HpIAkxvEXRizd30LwkH0onoY1cx3Q9t6PpCTN8GcaXRbut6IoginekZVguYn83/JP8UaQwR1291hn9hEY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M9dNuM9z; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M9dNuM9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBOk1r89KDa/b4/J6Oh04ARhghFzPuMHR7CfTkpoR8S8+CParzcClldmqWKqGJ6bFZUg6YqW19k92jJStqTlA0W1ToLRAjeAVIPMdkpWfoRiQYgiNmbJaSREJLqRM6PwWmLyyCWCXhdovnc60gX4IbdHsrnwESHEgV/GTduNUTWhOnezVyPIIfp6m+jzCVsLybo3GJxKOKnvdGY5t8XB/8d4sJv/r2L1w771Otvztl+/JnyumtnuD/rbv4bmD+XLaUS1yVmnaifMGRMlNKsnmzPrIw6oAbYMPcz3764WZL9Dmz1W5+8xkvernNs7Ra9s9oc1hXHSVZ7HuLRf3t2wPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTxHQJtGsEIw+NltW71japASSq2Ayku9BGMWihckQjs=;
 b=RvNy9rccKMPSADv/RWh772ORD5gwZctkO1JWVq6zkOulGjGe6pyUghL3Zr68mqkt5wENDK5yeT09w+Ge4jyZ/q4JHtcP17SF3s/76+GGRuWIyRQg8T559HE7lGz3fNw2TY+DciBNLbdMnwtWaaGlsIbiD2nC0LwxkPYYcXKM4erV33B6LxFeBNKuOXpwYhoYRWyoiZjXMlfgnRIrRuq1r0zp5nQdb4I5suWQXRKt2AEjb2pQBMQJswhwLWUrA/LdOtXPBDk49KRWVFncYJtFRvn3UhFEeJw3sijjFZ9InJgqrrkuzGQcRQsaJ9Opkbbg3eoiLDfjKQAGzGChJprx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTxHQJtGsEIw+NltW71japASSq2Ayku9BGMWihckQjs=;
 b=M9dNuM9zLX+ftY3Pe78whe9YgNNU0Xjl0qNOXis1M+K7VgrDIf2jcUU60nNBq3SfMAmIrCcm8qOYLnpco9DxY3XmubhcsY4ieyRpUEUwHbQiAefphd563XoH4rxQ7ednmZ0RaRBKmbB5sp8eD4Rm2csvfElN+P0E4y//y2CXn2UWXmapvD6Z+SmRv+++Fxf+AyeNXyZesqAkYywkJHnk/30Kprw1C4i5OBakGDdW5Ag79bJ+tPusmCwGF9r3KlEKUWZFgEuvmh2qToFaJitNzNgKyM4t4+v57jFMTnvLsWxZv4c32Q8XDQBjxugsIjmq4WphhItELraiXjAwkyM5NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:415::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:16:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:16:30 +0000
Message-ID: <31fe914f-add6-4b3a-979e-eebe34cf0e65@siemens.com>
Date: Mon, 18 May 2026 11:16:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] testsuite/smokey/vxworktests: Fix compile error
 seen with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
 <20260518-wip-flo-gcc-16-v2-3-f93562624fb4@siemens.com>
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
In-Reply-To: <20260518-wip-flo-gcc-16-v2-3-f93562624fb4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 149fffcd-f44b-4714-d114-08deb4be25df
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	jdptkUjAfRAOLnN+R0XhNJFogEDKAQG/gnZfLfYhZbYGb8zP4bGq0ebpXvXRi2wLpHaSLEZHptTKcR3VGukfrKvOe+G9cBeBmh+qXlqrFCf7DCx9TK26U/ChgZUuAc8Ip8QoWIrSvrHsUbYTRNW2oS3h9vXizkT0ppr2FMT4fQ3s7VjONk50nC4Lmo6kL19zNIpElVJ8viw+xusCUJQNTLLaVr/E8IfisrH3kl1KxrA2+J5eatTRD62jD0tf7D4pwv1otYNXUyxDD79qdWsCbqmQ12t6DSMMFf03TzaH681Zq49QjIL2U92UkamWrmLjzJgRGQEs2OI60TB6d9l3NzWFG/s9D5RWmlX58EE63yENKQq1yKc4314drQk2caR3DdTwnzHdKUPTz0Ad/XcgWKiz2ARNpHSgZg0dqo/AWHohWOaEOkg8haBz0HnLfAOY4pRbingjH3cGGnWOc1shuRUeW1LOShxcGD/kLMA3MimSaMcr+gI5HlP5rcuAgoFckEhAPz1dEe5cTCYi7Iz08WqJRB7aVSt2hma8sjk1dNq1hWHuVcQdTXC7UomjzQTEuci+u/PpdvxK/wJOLqjMzH/PnUjzUvlqlniDWOsbXKxfhBLzLqLXnSZC6SZ2yXifFCEW+BpAW6IbQ/gXDtXZ0D0AHSyFLMrEwpe5iihOmgx5POEDTLYcEOeyUdWqWDTq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWVoTDFpVXVtMnVSUlcwRkZsL3FjalJiM3dVckRxU1praE1NdFZGSHBxQ0FJ?=
 =?utf-8?B?T3BVa1hFM2hrWS9BMWVFL0M0TDBlQmRLSitFL0J0UG1sdkRzaE9HWUFKWnF6?=
 =?utf-8?B?bjcrT1BYTExoUEZUZ1VweTBsVWtvNHVSMlczZ0Z0L3lUMTJPSFlLdDhIS1Vk?=
 =?utf-8?B?RGt0REZsM05qYzU3LzhIL29QQVNjeDh5VmhUUytySHUwcExNeXhIQ05ROHpv?=
 =?utf-8?B?ODhMNmV0MDNaNUt6OGZVMW1EZ04rVHJ5Tnk4akRmeEVhWGhwOVkvb3JxL1dw?=
 =?utf-8?B?TmZhSjNSSlY0dURlMWw1VXgwRUY3clJqOEVuMHlZMWdZOTgvcXVPbDZjNnNO?=
 =?utf-8?B?cUxrVU5mN25uSXlYSVBuaFRwWWR1Q29VckFkNHFhcktWNlVEY2kzbDJLc2RO?=
 =?utf-8?B?dy92b1E0R2V2YWkzTG5lUm5vWEQreGZ3a0xJU1FITTBvSmNPRlRld05YT2Va?=
 =?utf-8?B?TXFCYUplZ3J0MGZUeHNXZFZMdEpiK3RHM3hXVHFOOVc1azhidjJFbEtnV2sz?=
 =?utf-8?B?QjdQK2o4OWEwRkU4RFR3amRuYW9VTGdDbmo5OUpob2JyN1BLdW1LSi9KejRj?=
 =?utf-8?B?elJRUGIyY2RZZGtoR2tzK2w2OHRJa3pWTVBCcGswQi8rYURFOVUwR3V2UGsx?=
 =?utf-8?B?ai81WFRmZHQyMFZRc3d3ZDVCdFlmOUprVVFFblUrTmtqVHMzTHBZdUpGWWg4?=
 =?utf-8?B?eFNxRmRrTlR5cGgxVU1XQ3NqdVFQNTdYa3ZkaU10eG5Nenc2ek9lNU1CUlZQ?=
 =?utf-8?B?TlFjY2xDK29GS3pHMTF3bXdybDVQYTVFY3F0S09Wb2JLYmh2SUhZU0hmM0di?=
 =?utf-8?B?WGhUYVROUXorekdkTjFQZnlHQ2lPeDF2a2NWMG1GMDMyeHJicTI2djgya2ZF?=
 =?utf-8?B?RGs1dEhmSWZmTmlLOEVlTGlTOUVrdTI2ZDAyS2kvRVZTS1pnRGl6d043M3Qw?=
 =?utf-8?B?TGNvWWhPcDNWT2EzUDEyNlF3UmFmUFltZE4xQ2pnaWJQenVpQnpvVGtudFo3?=
 =?utf-8?B?aG1RS2RsYllnd1lNZnd0UXNOQ2lPYTc2TDhtUGh0Q1dyb1ZNQlNiRURBR2Iw?=
 =?utf-8?B?di8yTUt6M1p2WUhoU3lIUUM3dlB5WHFkeFgxQ2h4bXdSbnMzRTBYQlFHMjA3?=
 =?utf-8?B?cDlubjJNS2U4MldJOGFmd1VVVFFMbmJ3ekZxdGdiQ0svbW1PdzZZdVkxZUxX?=
 =?utf-8?B?MDl4N1l2enhMOExpa0gxTUVBWHlYcTQ2MmowZWNIMmdsdmYzeWY3NmRuUkN6?=
 =?utf-8?B?QjBGUWxyRDdxZTVKWXRjZ3IwRC8xbmxnUkY5cWpwMng0VkEyMTJyUmpMQkVG?=
 =?utf-8?B?NnhjcTZ1dTRTTk5NYXo4NVFRNUtVTWpWOU82dFRUd29IZ2F1eXRyZGU2UUpT?=
 =?utf-8?B?OWNteDVSV1pMbVBxb0Vyb01ZaEJvR3oyRjFPQ1Fod084K0pGeXF1Q1hqcFQr?=
 =?utf-8?B?TjRUQm5WNkJ2MGo2cDQvRE5JZVd1aVFsRU5LZXRzUGlXUytCbDVoOGgzK3dx?=
 =?utf-8?B?Z2ZYS2RYOVNDVzBmOVIrUjV4TG9lc09rbUlpc0ZHM3Ntc21YZGwyYjRkNk0r?=
 =?utf-8?B?ZGdDMkdRNytXZzhTQWltTWNxaFJTTjEwcmwrY0NBQ3N0TnVFSHFIVDNOTE5G?=
 =?utf-8?B?YzZ3bWFud2k3UDBTTTN2YndmaUJrRW9ZL2tsbWdWWml6Ky9NMHYrMExkTUVM?=
 =?utf-8?B?MnNySUpDTGIyNTgwUEJ3NzkxNnZxUnFnZ3FLaDBEUXh4KzFXQkhIandES3Jl?=
 =?utf-8?B?SG9lQzRPMEc1NXpoeWxjL2dSSVJIK0tuNW4xKzVlZTBGVUJPQm53QU5CbWhB?=
 =?utf-8?B?cGZFTzAyR3AxWHZEZDNtWlJSQ3ZtbElZRnNQUlNyRXJhcnorRGxvSEFiam9z?=
 =?utf-8?B?RVBjWHZlRklrdUQwb1lTS3JmVXE4RXFVeTB0MGFsdE5OcndQTVh4bG1UK2Jw?=
 =?utf-8?B?bTREODhoRlBCaXk3akdtRG9YUytvSktkZTBGaGJ0cVY4SGxDMHc0eVBrQWk1?=
 =?utf-8?B?Wk8vZlRjaWNrdXlyK1RRc1UvZFlsOGZJaTNqbHZaRjViNFZmQkNsOUFZb2o3?=
 =?utf-8?B?UXFrdGhTUjJ4QzFDeThRK2tlOUMzOTlLUkIrU2twQzJLMlBYdjliZi9uM2lh?=
 =?utf-8?B?WGNQdHFvQlVuRHFTaWo2cC9vZkNzU2NqN0pOdU9UcjIxaEVXL3BRcWNncUhq?=
 =?utf-8?B?RFprdkV6VVBoTkRBd2VvRm9ucTlhSjhhSUFtUDZ1dnhuamV2YWNxU24zRHgw?=
 =?utf-8?B?WDlYdFFVdkhiUTEzeGgwYm5yU0ZMWmtCaStWNFBNY2ZvNTluZFJtYWdWdmRz?=
 =?utf-8?B?Z0dxSnI2RzFCemlGNUtuTUw2YUlKSlE5SnljQkVzbFFmL1VkdzVJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149fffcd-f44b-4714-d114-08deb4be25df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:16:30.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4K9bQkgIkMjOtSRodYAasC8Qg2nKpCBYWdAktlHN82xoobv9kTqCg/WBNBelLh0sgJpAo3rjzRvcSAZyBkHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8338

On 18.05.26 11:02, Florian Bezdeka wrote:
> Fixes the following error:
> 
> task-2.c: In function ‘backgroundTask’:
> task-2.c:26:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>    26 |         unsigned int safety = 100000000, count = 0;
>       |                                          ^~~~~
> cc1: all warnings being treated as errors
> 
> The busy waiting loop - to my understanding - is keeping the background
> task alive, so that the foreground task is able to call taskSuspend()
> for the background task.
> 
> As the background task is calling safe_pause(), the task will wait
> for the termination signal anyhow, so busy waiting upfront is not
> necessary.

It remains unclear, though, what the test scope of task-2 is here. The
busy loop keeps background in primary mode, foreground interrupting it
due to higher prio once the delay ended. In contract, pause() should
kick background out of primary and let it block in Linux. So, if the
test is (also) about deleting a suspended task in primary mode, then
this change would destroy that case.

Alternatively, you could spin in primary mode for at least 3 vxworks
ticks, likely some more to be safe.

Jan

> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/vxworkstests/task-2.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
> index 0cbb9e18a13383418c4360241ef244b8a24da975..60462e64ea7b2b4ddc810f336eea906cf6ca8c8f 100644
> --- a/testsuite/smokey/vxworkstests/task-2.c
> +++ b/testsuite/smokey/vxworkstests/task-2.c
> @@ -23,7 +23,6 @@ static SEM_ID sem_id, fdone_sem_id;
>  
>  static void backgroundTask(long arg, ...)
>  {
> -	unsigned int safety = 100000000, count = 0;
>  	int ret;
>  
>  	traceobj_enter(&trobj);
> @@ -35,9 +34,6 @@ static void backgroundTask(long arg, ...)
>  
>  	traceobj_mark(&trobj, 2);
>  
> -	while (--safety > 0)
> -		count++;
> -
>  	/*
>  	 * Enter infinite pause so that any pending cancellation is
>  	 * taken regardless of whether async-cancel is enabled or not.
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
