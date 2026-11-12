Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482523;
	b=gJxSbhdK3qlg4wIK6BoJPbOCtGIZkuu6XjZYj7dvg6/2ecU8DBa7GcyJusPfcxcn7cGE
	 vKKNXvYyyy+vEwPlqNLy78qurMpnlgqxNx/wroe70W3PFpu9u2DFeWYLWxz8R58gUsDWb
	 r8FrL6JIVQkE12UZM+r9XX1EThil8qC9VO3pcNkXPIT7C0J04/cZbuXBeYxQ0K+Vp8HJt
	 ZBH3E0kScZ5TAuMB/B+RjIikwiSguXbslEqBJp8hb2YkZRChDCsijKAXFmBcAJcSIN55x
	 C3i1SA/QgVKlK0EZZFPDMPlNFQZp9ZSSpcJw/PmVQf30NrPdsLAFD+dSheuSWgcTzWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482523;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OkSuA5RlQNzQlGduNRpT+dN4ZKcnZGV8vOuB3tNpz8M=;
	b=wl6BtP7BoYq+PlA0R0fyHu1oir6By/oo+PzPSiOMlT/kp2DbGYbdG10wTI3IcUyEjNTo
	 kpwbGoxEtnMKbmdohcBeDJGaTGAyYUkE5AVk9D8sLCxDoLzrGBtYrtU682V8OtZqrcm67
	 Hs1ZHemD0tlKg+CbllZDOvlB5WcGpuLyZlUPl4T7d1htS17GPcO76y3wg/LueeRBZz7kO
	 7V8tDhZOdSBOUOgoGjBm8ynpRbnTa9S9mXO7vztGxefi21lULEvHZOXomKQ1gp/y0jZSR
	 1Dv9mv0MpZPb0qGbeUAhYcHrqNCwDF4X3MMfq19Gn6Q4DxwbMGaQ+XUT/0jkBiFLaFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ixuPTyD1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.59
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C0606A8A4
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C97C0606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ixuPTyD1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuLLMt2aBCvWIN7nFUkGPWuKgevIVhVs3emq2KNDmgcralp4oHW5KMJP5xlNfCJAneUmXfQ4GWuQwfq3Txaihi6aI6BpUGdPwmVF1yiAd19muBB448V7bPntRd1AE2qN9LA5bDycS75jLfmceY/cl4z5offqLv0GTw7eVtNtXpo+gUcMK/z1G1OyrbwlJJ3Awxs9HDSdzfIyedfddbnNgskvt5reD4vsrzjb2nvHhx+xxrAkVEwIgilWNqWV13HqSoqBmJSnSV5OkKbenNcce6NH/a+nR1de8M5l9L3e9Kl8D0QbN4br3XK8lkq5e0fHf3lCHOYIYMAFsJ+YrQSvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkSuA5RlQNzQlGduNRpT+dN4ZKcnZGV8vOuB3tNpz8M=;
 b=Jnd87jr37J/BRf3br7EmiBMx2DqtDYuly0BGxi1fZlg2WN1WioHI4L9XuV7a8N3/H3WTGqUt1RG1iWLfHxC8yDAtqsvHVA9fRKErxkO/UaP1SwQ2cPYPna8qJPir46QWJ816f0qCecGTp55Z5n/+094Rp5wZ9gInYOspp3aukr3oiY9di9AV9NDdSLCvZ5KumbKZivXH4o3V8k+R6BOwtEWdcjLLemBeDQAnUnAlHbz03XLineJHzpJeJSxE1u/u+tMNu9RHu8uH2E5XCe0qmUEq1RyYuz1uKWewH1YHeZxU/tTBxrtsOAxrpxDzQeiK9OSURWmZU2Tigd+A2xdU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkSuA5RlQNzQlGduNRpT+dN4ZKcnZGV8vOuB3tNpz8M=;
 b=ixuPTyD14A/UHJPiFksJV/N6NO/6vE/jhotvmYG+MqAZ6btgvzlqKq+QoAO71tXUM+EiCoay4NyRdhcM1ysTq59a9Vq96Uo402IhHZExohg+zoo/gy1jjylessw8lCkqkgRkbFMkpGceOfDot52qX18AnVTCje8waWgmSZyH4BLFAsSiiaZEHZm8LmzHtA7qPtc7KdL9tF5/ORY/pROb2byqJNdwfSiR27/CBWTcyT2uXoAsYBVkKOPowg+njbm5ULfyAcgyFHqZNNEb4mYg1zcTRcDassYVN0H9pM9vixsH0gOzf/OfK1+kFLp03Dy9oxL6rOqIr534h/SuccCKBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB9100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:214::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 11:21:58 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 11:21:58 +0000
Message-ID: <4d04a4b7-52a9-496e-b6c6-b0bdb1d97597@siemens.com>
Date: Thu, 12 Nov 2026 12:21:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 7.3][PATCH] arm: dovetail: Deduplicate dovetail fault
 stubs
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <ca829aa7-2caf-493e-be78-e5a97e624e0e@siemens.com>
 <df7cb91395df478c36022cd72f22dde93cc63ab7.camel@siemens.com>
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
In-Reply-To: <df7cb91395df478c36022cd72f22dde93cc63ab7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:208:32e::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0701e5-ac82-4ee9-2bb6-08df40af2a43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|55112099003|10067099003|261028144727099003|4143699003|11063799006|261022075727099003|261026121527099003|261021123027099003|261021121427099003|56012099006|261026140227099003|261009223027099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	QMktW0nb+/2+HS0xrKAizSOjXnYAk6OKg8Fd0mQ4miQsTYl0wkngoSYDQtvk9D/gLLLCyNcCs56lt16EUqkG7NpyoCLLchMK7ido/kkztP8mCScjuHUczuQIqi26PA8cMHT7U6SfBtN5DRZmd/qJG9SdT0OEjaH2VjslM5ea0RCdrpDHBcJaIt+idVd0sUYj75ZLvu2sVMR5pf+y65NIiJB69vX3A+bqNqhSN3lyyeJgggYNL9OgqMuOD6bbF587SedIkgeT7u/aWe2JguGc1AYR1NRG1rtsRYYuVgi0dEM/SHrZlRor6nEsAW0yItOyYffW3ZYmthhqYEGM2roDM7UlaxI44nV7Xur06YrC9qQiRr2XWoPudXT160VWP07ytuG8Lq0j0F3fYKIextujdYjtq8UlPsvPw3F+ZjLZosmPNTNli6o2rkVREty3x04GvUAe2S11KtizddlfIm7lYDHNwueeQ0Y02GOHcTk+RNe4zV5W5Or4laIfRWvX142jLUp7n2SpAUikuSTjnIRX9HyrSxFkT6dC4X4nJsgQIMzol/5zP6yNyr98bo1Ig+OLlgaM5DzQl1E+Z9UKpSFjaYTgAuPO606NO981D9azuiSIwiqDFfFGXOdqr43WiUuO4nxHuvtA5qcMAIqrk5EsCGPOhhXuz6BNUp6TvTaLsag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(55112099003)(10067099003)(261028144727099003)(4143699003)(11063799006)(261022075727099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003)(261022105027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU9EQTZCUVdKcWdYbnZJSVdDdmwxcDNFc241bHUrdHduYm5zT3lVTHRNVERX?=
 =?utf-8?B?SW1QeGIvZDRveiswZms3RWFrSUxlWklrNC94NVhyQS9xZDNXT2lVdlcxeHhY?=
 =?utf-8?B?UC8rVURqM0hQNkZQS25wMkYxV3pxaFpZN01YWVdjcXJ0dGhKZmYyRThUV2FG?=
 =?utf-8?B?MnQ4dlFpNWEzQ2FtN0F1NVY2SzN4OCtRY2cyaW1nRGp0ZjdNSXNOU1pYMC9E?=
 =?utf-8?B?NEpmOHorZ1ZQSWFFeUJObHgzakliczlSMGluOWdlekE0eXU3K2RYMUVyUis0?=
 =?utf-8?B?ZitEb3RxWHNBYTFZMzJPVjVlOFlZUTRTMGk5SjBqQmpFZlcrQzNLWEhGbmtu?=
 =?utf-8?B?RHM1Q3BrZ0x4MG5XM3FRRUVPeW14UjdYY0taNm9KV3lvcks3Z1NIWmJha1lX?=
 =?utf-8?B?NlB0K2hxRGhZZlFGYnhlZHU4YmpDVlAzeWZ2eHl1WGZUb2wzTUN5QnN3OUhJ?=
 =?utf-8?B?dE45R2U1VXNKVmhGTWhMdm4yL3pXUTQwVzhzL2hyNUxxUVdobFN3ZitPc3d4?=
 =?utf-8?B?d3R6QythdkN2WHRscURTazZoa1h6eS9BUGhkcVE5cTN4UHA1ZmFXaVRkbXYv?=
 =?utf-8?B?UjhiR1lIT2k3cFBEVFVzKy83QkFXVkNCZUcydnN1VkNrejVTQStBOTJ1MWFY?=
 =?utf-8?B?ZWJnUmNIOE1ITmlMWmdVbXNSS2tXbmxuczlMWXhQS29Jc1VuUXV5YXl0MFRM?=
 =?utf-8?B?TXVCMTBRTVJxQ0x2Q29SMEtaZFdDZDF4djBqcEpoQ1RqUnVqdTBWUzNSOURM?=
 =?utf-8?B?TUFsSStaaUVCc0pSN1BvVUp0b1NEL0ZVMXFHU0c2NCs4R1ZVL212NXR6QWdV?=
 =?utf-8?B?dC85R2cvMXpuTHVHUXdnR0ZnSTB5U3VvanpackxkdGVoRi9OVXJ6OEhIRmpF?=
 =?utf-8?B?ckNOSWlMZjVNMWRkQ1g5dEhlR2ZHRk1nb3NsTm51Y1Z3RXFlek01Q2lCcEFn?=
 =?utf-8?B?ZG5TKzhGQkMvSzl3cHRWdVlzSXd0TUdEeWJlbnRlcml3K1pYbjdyaUZENTR6?=
 =?utf-8?B?a3puSW8wRUdVS3NFOCt6Wm1HZ2lNOWZna25uZXZEZlpMQjNjdXlRc0R5VXlL?=
 =?utf-8?B?UUo2L0QvU1BxTVM4bktUcVphNE1ZTTlSaGJ5b0ZTa3RwVEdQOHNibkRkaTht?=
 =?utf-8?B?WVMvNDFzZzRuVWVaeFI4QTJsR2FTaE9oa3poRTU0NjkyQ1FQOEZ0QytBRVJ1?=
 =?utf-8?B?OUtYMmhSMEwzUERmVW4zSUVmL2s2V2lTVmoyS2VjK1dEYmp3c2F4S3cwV256?=
 =?utf-8?B?UjFlRzY4REZpRFYwdStkU1VmVjlkZnh2b3cwNmsrZXA1T1pxTC9oa3c2U0tS?=
 =?utf-8?B?enNRODJva0hlZk1VdTdnMnR3NnNYbWVHWVNDQ1JISTVtbGs4MmxzaC83UE5v?=
 =?utf-8?B?ZDlwcGVCVmY1bmxDSDZmTSsxdUZTZFBHUDhwNmpHVkp0Q2tBNWpoUUIrR1oy?=
 =?utf-8?B?NmJ5SWhsTE9wNmE0T3BwM3c3bGkwNS9BUjAvU2FQUXoxb2VJbTMyVURBWllS?=
 =?utf-8?B?QnFqUGlVazNyL2lJZTNveWw0Y0pWcFdhQ1B6K2Zlb3VjYmgvL2dDS2N3NWZt?=
 =?utf-8?B?SG5ESXlQelhOWExTcmx4eUFrZ0gyVW56bldJdCtwSWsrRjVabEYreFkvRGRl?=
 =?utf-8?B?K0ZxaTJSWS9XNVY3S2hWMEZ1S1pzQVdpZEVja3ErMHNqV3d0aWVtWVU4SnI5?=
 =?utf-8?B?ZWpxRmEwTEdjZG44bjlIMHVTbnFKU1d2dDY0ek8yczJLT2FJUVVBaVBMTzBl?=
 =?utf-8?B?RE41WnlpTFAwM2pGUUJjTVpiVG82Zm1qVTQ4RzNtVTViMVNaVDgyR2RmbFRs?=
 =?utf-8?B?MDczUVQyS3oyaFRqYk5abmRqZkh1TnFsZmF1OS9HS0tqZnh5UjkzY2xEbk9l?=
 =?utf-8?B?Y0VkZCtmenB5TTllZmQwSi9VY0NkSEgxbmd6UkR1emhXTmdObk9UNGcvTEFB?=
 =?utf-8?B?NDhjTi9PdlBwcDAzQTU4RHdFM3FNVUl2WXkzOU5xQ1Ezc1lHSzltdjBWMmwx?=
 =?utf-8?B?SzBIekdoemZ5dW0zTjZBWnNPVldjck5oc1cydWdvS1RSQU5WK1dWSUhIVmJo?=
 =?utf-8?B?dDE0dHEwTWw1dlVXOXdWY1BoOWtXVGdOek9FZ1p6TllKK01QOE1DSmI3dmkv?=
 =?utf-8?B?cHV5Ylg2Qmg3dm9OcGhZL254SjdKZWNDam1sV3k1eXpFWEpoamVTMW9yRFB4?=
 =?utf-8?B?MkNqdnZGTXBMdmFUV28vWlJ2TXIwVVk3UEhObHU1bWdOVjFOc0pwbXhwaVl6?=
 =?utf-8?B?VGhtL0ZxY0kvZjlxUDNJWG80N3lLdkZwZVhETGtlY2Y3UWdLL3c1L3NSekV4?=
 =?utf-8?B?eDBaUDFkY3lDUDNHTXJuYnZvMHpYS3BYRmtNdWpiRWZwTnZnbXJiZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0701e5-ac82-4ee9-2bb6-08df40af2a43
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:21:58.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwFmcBcqQscmhTiYa+WNJXrrVjucdSxAo5fp93b1A9toDi/1q0MIZFizARreLMMPBHdzA5PYJPs62snU8Z7Cwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9100

On 11.11.26 22:47, Florian Bezdeka wrote:
> On Wed, 2026-11-11 at 17:31 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> BTW, the backport of these to <7.3 went wrong, or 7.3 was fixed up 
>> without fixing older kernels.
> 
> I fixed that up during the 7.3 forward port. But: I cannot send
> backports for something that has not been released yet.
> 
> In addition, if i get this right, this is just a cosmetic change. This

Yes, makes the code more maintainable.

> is one of the files that has to be regularly rebased. We try to do that

Nope, this header is fully dovetail-owned.

Jan

> with pure additions / removals, to keep the process simple.
> 
> That may require some minimal code duplication from time to time. This
> seems to be the case here.
> 
> 
>>
>>  arch/arm/include/asm/trap_entry.h | 25 +++----------------------
>>  1 file changed, 3 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/trap_entry.h b/arch/arm/include/asm/trap_entry.h
>> index 2af401098cec4..a332f90d8843d 100644
>> --- a/arch/arm/include/asm/trap_entry.h
>> +++ b/arch/arm/include/asm/trap_entry.h
>> @@ -5,8 +5,7 @@
>>  #include <asm/dovetail.h>
>>  #include <asm/trace/exceptions.h>
>>  
>> -#ifdef CONFIG_MMU
>> -#ifdef CONFIG_IRQ_PIPELINE
>> +#if defined(CONFIG_MMU) && defined(CONFIG_IRQ_PIPELINE)
>>  
>>  #include <linux/irqstage.h>
>>  
>> @@ -55,7 +54,7 @@ static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
>>  	hard_local_irq_restore(flags);
>>  }
>>  
>> -#else /* !CONFIG_IRQ_PIPELINE */
>> +#else /* !CONFIG_MMU || !CONFIG_IRQ_PIPELINE */
>>  
>>  static inline unsigned long dovetail_fault_entry(int exception,
>>  						 struct pt_regs *regs)
>> @@ -72,24 +71,6 @@ static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
>>  	(void)regs;
>>  	(void)combo;
>>  }
>> -#endif /* !CONFIG_IRQ_PIPELINE */
>> -
>> -#else /* CONFIG_MMU */
>> -static inline unsigned long dovetail_fault_entry(int exception,
>> -						 struct pt_regs *regs)
>> -{
>> -	(void)(exception);
>> -	(void)(regs);
>> -	return 0;
>> -}
>> -
>> -static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
>> -				       unsigned long combo)
>> -{
>> -	(void)exception;
>> -	(void)regs;
>> -	(void)combo;
>> -}
>> -#endif /* !CONFIG_MMU */
>> +#endif /* !CONFIG_MMU || !CONFIG_IRQ_PIPELINE */
>>  
>>  #endif
>> -- 
>> 2.47.3

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
