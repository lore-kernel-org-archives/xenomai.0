Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74EB201036
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519751; cv=fail; b=ob0SRbffCJAv9xKt5TacsNAbIurtwnFnuzp+yMj9WfNfgvusKQ/+RhvyJKZaIxejdaywpvUu2FelV3bki+q7xrPR2vz+MMtV93mikJ1Qw+mw0J+ehhd/yNPFueNL0VCrNQv2k6jf8iPixsvceahKJ+a4HwIFtmBv/Vgwe6X+iCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519751; c=relaxed/simple;
	bh=BolRmcyHbppitj/O3xcHpuwakuvvs3dC+PIwwZ+KejQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzB4wXpLuuG+BQ983V7W2/5E5Km+jjytVDDrNVodnKdD6U6YOKZL5g6B5NkJz2NJQVf/BI1VM+DiHI4gpgL27VpC0FrScGCL6kOlNfUpBgVO1elKR8yjSx9bYTlE3ew5jyPqENdIrDje2WBZ/+CwKtCCkgGg42cXpjHwKvZNyzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OMyB77Wh; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OMyB77Wh"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id B2C5E1A0010
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 17:42:18 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on20610.outbound.protection.outlook.com [IPv6:2a01:111:f403:2608::610])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8C95DAC1DE8
	for <xenomai@xenomai.org>; Wed, 13 Nov 2024 17:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/1g7AMK6qf76v1SERnEhD7ht6XP0zT57r68UqvTpRQZpTJH0+vg0GVFt4UTrN8cXeFvIyuIyfKMpbvBSCAtS31gjJEH1eqwmn3ZvvmPZTgDr/g0i/4M8dUzKF8csD3WhFPb8mBdyaKgZVKTx5pCh7fHjUr4jEqFT3g1aWzj5XXoUfZWCZoguabV6b5saYqA2ewAAzs4+QASMUPESdz352xFZ+RdywDacIsJD/K6oL9xpRjMc54lNUpAmvRfPATXZebu7gVblwxPYl+HkS9GWxx+hCHE4IxZZ6SnPseQBvAqX9lHRQhC5TuCOgjZ+sLolUuEoMqTvms10FJAvC8TUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHmncujhKIhUIpTp8XcE2dzNGRzu5J6Bc9WJlL1z8yA=;
 b=yD9cPVyTlU8li/fCjSo3HgSfhFOYNfK76PZqYCQ2m2XgHo9JkUX7P06lgk1RAOCX8h8bz9sJlgkE8GzCVV6lghgJ5XG+XocU9+oM32xGHSg0ZBXEnAaJWAvJIaTxZY3Ji8fWOfi36xuq6ELWQLJWntRd1cVWPZD2ZsHkN1+3gPJoxLT4iWva7Yk5GkQLRTyh+mZnr4M22TabI4iy4Iy9rObsjAiWyNRP0Zao3PepKSl2+L7rpKZeCU/74lk3bmMgR3sb37fm53dmEEt7omDWHPuA+jGUxY37O3scOwmWlYWytAR5xjLD6DK0Hm0UQ6Dq8Olu6eUtokQ8/0Iq+IYcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHmncujhKIhUIpTp8XcE2dzNGRzu5J6Bc9WJlL1z8yA=;
 b=OMyB77WhqIHgd+LOLOQQn5rQWPuQt3PVgALi0CYo2BMMKByXT+n17VK0xFmksCX4gSPyt5VSzZ4hIWyof7XMsBgZ93K7BL62IMzJF1ciCYAXsNTvo9oFE88r1cj1EBdt0C6SsvYT+umIOLFFWXaQxp38/WXJJ6gpoZc//sAG50QJBVeXEEl1J3deJTAQeFruSgGPhYLMbUiDm+rIdFntRxam39MoVVqBYHXlfSVRcwyAx0KqZWZPqrd7hejS+FLPyRG4INcfTHcT8voQdj9wi+eoxrTssvIz9kscuZmm73agPtWpdnnajWBX5iE8wf8TlQc3V9lVpV3a0f+JDQ0pWg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 17:41:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 17:41:23 +0000
Message-ID: <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com>
Date: Wed, 13 Nov 2024 18:41:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Error building xenomai-images
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>
References: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
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
In-Reply-To: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:52::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 11be1aab-914c-4d84-94ac-08dd040a643a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0JoUjQ0Wk5UekpYQk5aMFRKam5EenNxb21sM2pUR3A5VGdJR1o5ZFRYbTdX?=
 =?utf-8?B?cW5BR3ZyNEE1U1AyVVZMTndteTd3dnAydU8xcmJQVHp3R01ENXNXaWdBNURE?=
 =?utf-8?B?bjZKVGF5T1pEVS9ueEJrNm4rZGd4N3E5UTlscVdlSGh5b1lXZDFuK2o3cVdq?=
 =?utf-8?B?bkNrZDFKQ3NNMXJMd3JWYTgzUVRURmtQV1lxQzVVTWRnQjg1MXdKVnBxYmYz?=
 =?utf-8?B?b2t1dElETk5FQlQyN1FjSlJGdVNBT3JKaDFIS2RRdmtQUytpNTVaU3FoK0hu?=
 =?utf-8?B?QThtSHpMeUtMQllWaVl2MXFPVEpycUdVYmhINEoyVFFraWRHcWUraFBXakwr?=
 =?utf-8?B?Yy9nSVByRDJoN1dTMUtWT2t3TTB4bGVCRkErMkxQUWpNQS8wbGZXL001OGJJ?=
 =?utf-8?B?SHFZZnNOR2tvM0lRbWkzSnJIMXJ1Ukp1bm5lRFlRMktJOERuQ3pjRXlQeHRX?=
 =?utf-8?B?Q0xtK2puWmtNdDNESXRsVHA2dDdYcjY2RktZT2ZpR09qOWg0N25Qc3R1aHpr?=
 =?utf-8?B?MG9wUk4vQzFIOXZsUkFqRklUUTNUMzJiSFI3WllhMVJ2QUNyakJ4SXB2SG5M?=
 =?utf-8?B?UU5ERDRlbzk5ZGJPZ2c0RWhpbGFMNE9oV3dUUnpLeGgyOGh3QVpzakdkWEhh?=
 =?utf-8?B?eS9rV0RFUXQ5c0Y3M3BWR2NnN2FtSDFHQ3dINzM1d2hIYzFrZHRoamFnbzZI?=
 =?utf-8?B?eDFzYXVHWmJtdW56Ky9RNUtINzlLMit3REoyM1AyR3VoRzd2cFMwdUtUYUFC?=
 =?utf-8?B?VGR4eXp6Nkh5cmdDVjZZcFY1Y0Vwb2k0L1crL0Z0YVlpRmRBWVZwcmY3Mk1S?=
 =?utf-8?B?WGpIQmlmY081L2hzSkxMTzFlUjMvZXNaejdLcVdKemRvb0NiWU12eDVpd0g0?=
 =?utf-8?B?TnpndEluYVNhQ1JMOUZMK0tCeEhZZm1kc2lSaVNPWjFFSStINit0bElFa2ZQ?=
 =?utf-8?B?Ry92bFFIVlJsMWQybDlEU0JJVjBZd0UxVXdBNGh2Tm5zZkM5U2NmK0lISUZB?=
 =?utf-8?B?L1Z3ZXRmWFBXSDY3eTVaWk1CNnJuRXROdUR3bW84ZUcvOVlHb0lXbC9wa2py?=
 =?utf-8?B?M0hqT205M21RMzFqRnJxRythTWhkRnowYk1tNDF4cVVFaUlLUFRtbDJYQ2h3?=
 =?utf-8?B?OC9zNU9RYThqT1JPTTVXMGRXSzdTNTVsNFBHWXZCRkhrUWdBSGtwQ05tajZx?=
 =?utf-8?B?OTRsZk9zWFlSeHV4azBpczlzZHk0Sy96YzhqOEtSU3Zkbk9lUFRhZERmdGtp?=
 =?utf-8?B?RUlrRDR3MnVQWlF2M1pDM0FXenpzYkRMZE1QYTMwOFRybmhtbWszWXovSjdT?=
 =?utf-8?B?V1pQRzNkVlRSL25LSDJ4WFdBU2NZekVzek5FK1NjK0lDMDRmbXRpbUx5bGlX?=
 =?utf-8?B?bjRXSjNtbjAzeCt2cWo4YUpjQ3g2M0lWdjUycmhCTHdVWGI5dE9pSkNFcGVy?=
 =?utf-8?B?M3UzSkVWdG5kQUpXblhQb09HZ0FVL2MxQjZkQ3R3SW52MHltS3ZYbnNWa2JY?=
 =?utf-8?B?SjFvNlQweWlnNHVvZ1g4YmZTenNyTkRmOEpNcTUwbERsd09MUkwvU3RWVjAy?=
 =?utf-8?B?MEpoSTJ3K25LR2ZQWFZJY25Sc1hodm9SekI1RnA4ZktGVWxLZFRWbFg3WG56?=
 =?utf-8?B?eHpYaC9BYU0wYk10Wk1lYnlPcGE2S2xkK0ZQRkhDdjNQcXQyWHBsd0sxK25R?=
 =?utf-8?B?Zk0wTnF1MTFpSHVZQS9jVkk2NSswZldONXZvdFBJaTErNDFVbUhzV0Q2UDU3?=
 =?utf-8?Q?v53Afzu3SgnEQs2uACIIt8Qio7QVLIjk+RSzMl7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ljYkJaeUxOZFNHYjFXVnlQb3lTOHpIc2tHSlEwd2hLMGNpRG8xNHRVbytU?=
 =?utf-8?B?WUp2Si9wU0xrNDJaWDVIY3QvclQ5K0JSeFpxV2dOckQ2UWdNNURJSlFmSExU?=
 =?utf-8?B?eFFoTUZRdkFyd1JEb1Z0c1JlQlg5YW5Uc3E3ZDRRTnVCWUVmNUJmNHl4ZEF4?=
 =?utf-8?B?NFVmMEhkTkc3YkNFM1lhK3V3NVlmWFI5THArM2kvKzYzcXRqeXBEQ0NQYVBm?=
 =?utf-8?B?NE03Z2ZqdG5objNuWDFpRFplOTk2T2xNeG1CQ0tGekloTjhkVjcrYk5qRlpX?=
 =?utf-8?B?bHNqVS9UZnV5MDkrVHZQU2Q3aFRUb3pnSXZMSUhtbEUxcnllb0xqTm1tYmY1?=
 =?utf-8?B?am9hU3lobnVuZ1dtVjRjUUNvcHFwRTJid1VocWJiMzh1Sm9XZTBiZUJpUFNB?=
 =?utf-8?B?MzcvV2d1MWRRd3VEdUNvaW5EUnlKRGtVNUF4c1M5Ump1Sm1tOVc0WFVqRGRL?=
 =?utf-8?B?dDlyaHhwY2ZIVVg3aWpCMVhlWlVsaklVZWJXTHJreVpiVGVPYTh6aVVmYkFk?=
 =?utf-8?B?SDlmb3hSbkc3VWxnS2xtSkoyRkNxTit6ZmFnTERsU3JlUjJsN1YyMGJKWVB1?=
 =?utf-8?B?WTlpN3ZuNytOT3FuWG4zYW9xZmhMeEczNzRoKzhGU3lnS2VVSDVyN002WWxv?=
 =?utf-8?B?SkhtUFg1TzJDbzhxNjYyNFh4VjE0eHZ5WjdEdk5TQ1paL2Vlcll4WkFObXg0?=
 =?utf-8?B?aE1XaXZHcHhpZHJyK2Z6Y3V0OGhYVzJqOGhzckxpZDR4SVVjeXcvR2NLMWFV?=
 =?utf-8?B?VlpxQUNyNWd4UmdhNlIza21heUtIVWNKc0U5UHNhY1BJWTduajhlU0pwdkIv?=
 =?utf-8?B?MXdVMk9KVWh2RUhBekJIWFB6VG4waFVLbTFDTVdCdHBCSE5YVldKNTN3bVhD?=
 =?utf-8?B?TmRQaEJQS0kvd1A5cnhWeCtTTmY5RlU3WGNxcm1iVGZYbXk0blIwUmNhL0cx?=
 =?utf-8?B?eWZHcjN5Zzh0T0ZiSTF2cEViTGZzMzFlOVl1cnBNa241ZkVQOW14TTBGWVB4?=
 =?utf-8?B?TkppSExvWm5qQmNObjZCTUprcVo3NW1KZlJEVktPKzdlRGo1bzZraStIRWlB?=
 =?utf-8?B?d3h2bmQ3dWRMQ3NoeTAySE5aMEdFMmxMeU10K2plcWYvQVJnZ1NnK1c2Tmpt?=
 =?utf-8?B?OEtiSGV0TGRRRDl3WkxsT3JtQmZRR1kxODBERXBPMThFMmtOc2ZNN05BNjUw?=
 =?utf-8?B?akVJbUs0VVRnaWdFaHpwamNvN3JBRE1qcTJjQkNGNC95OEpaZ2RYTisvMFlm?=
 =?utf-8?B?eGJTTzZqWFhhV084bnRLMHVXRXVObUNFajh2VnBZWEY1TEFrQ3piRG0vVHV1?=
 =?utf-8?B?anZHaGlNcDFMdEF6ZkR6azJvNkx0Q2RhQ1RmNnFqQkZQYXRURDJjK2c5ai8v?=
 =?utf-8?B?UDJQRkc0U0lkRU1xV0FzbDVrRDE5VWRGSmxTaVpyVUU1TnVWVWtraDRDS1ln?=
 =?utf-8?B?MmZMTHBmc0lYeDMwVEFBZHlxWTRYb25sT0crVjVCS3NwVzRIVlZ1UW80VUJ3?=
 =?utf-8?B?R1BReWNKdmRDalFVL01icXI3Vm5CMnY5UjlxTkFKTTBtTnQyZ0N6TzlIZ2xh?=
 =?utf-8?B?MHQzVHhVdUZwUGN2VXc1VVhFeHRIb0xxZnlxNm9oNGgwRlJpMDhyL001QlFn?=
 =?utf-8?B?WmpwN0w2ZlBPVTN0VENmdHVadTh3Y0JRQWYzTmZTR0lPcTBzVnd2MEtPL1JW?=
 =?utf-8?B?cU9qVXUyMWlrekxQdTl0aDJKNy9jb0pTUTFTMkhhTkRiNjRidTJjRGZ1NWRC?=
 =?utf-8?B?b3ppZmh2d21VTHNBMkxBWGRRV1pDb0lzSlI1Vm9iOXhUaTY1c0w3cWw4SDdN?=
 =?utf-8?B?a1Z5OFFUeS9wVzQzNytXbHpPYXYzODlwaEdtY2lPd1E5VkxVV0JCNmY1bzhI?=
 =?utf-8?B?N1hObUYwTVVVd2Vkb0NqV0EzeGtHZHpFWFIwdDRycmtFa3laN1FDenljWXJx?=
 =?utf-8?B?bUdwN3lTcnNJSi9TOFBDSnFUdzB0RXNzRG9zSk9WSXI3Q3EzbzBPQkhNd3Ix?=
 =?utf-8?B?WWxrN0FCRGlteTZRWjhWeTRDYUtTSVNEdEhqMnlYVnVzbFV3UHJUQk1pQVNU?=
 =?utf-8?B?eEhpdHVSRDczOCtNVGRKaUJ0RThOazFNV2JoVEFkSm1ZR01CZ0NuaDFQUWZx?=
 =?utf-8?B?RkhqSkhhODhGRDNlOEFXcG5oOVBXek83UGJJdSs1dEcxTnZmSGVPelRGNEZy?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11be1aab-914c-4d84-94ac-08dd040a643a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 17:41:23.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZTTo5M30seD8pE+5Wq9u3NpK2pEU2aOtjy49EquzBgY9ZIQqByx8AYJMQ5bh83lMN3TgyKFmVcxGr2i1B876g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7043
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=OMyB77Wh;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2608::610) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 13.11.24 17:07, Pierre FICHEUX wrote:
> Hi,
> 
> I have the following error as trying to build an image with kas-container :
> 
> $ ./kas-container menu
> 
> I use the Build button for a BBB :
> 
> 2024-11-13 16:05:02 - INFO     - kas 4.5 started
> 2024-11-13 16:05:13 - INFO     - Using /repo as root for repository xenomai
> 2024-11-13 16:05:13 - INFO     - Repository isar already contains
> 75488685dd2123417deb70f6d0923b8c2772954e as commit
> 2024-11-13 16:05:13 - INFO     - Repository isar checked out to
> 75488685dd2123417deb70f6d0923b8c2772954e
> 2024-11-13 16:05:13 - INFO     - /build$
> /work/isar/bitbake/bin/bitbake -c build demo-image
> Loading cache: 100% |                                           | ETA:  --:--:--
> Loaded 0 entries from dependency cache.
> Parsing recipes: 100% |##########################################| Time: 0:00:04
> Parsing of 46 .bb files complete (0 cached, 46 parsed). 86 targets, 0
> skipped, 0 masked, 0 errors.
> NOTE: Resolving any missing task queue dependencies
> Sstate summary: Wanted 11 Local 0 Mirrors 0 Missed 11 Current 0 (0%
> match, 0% complete)
> Initialising tasks: 100% |#######################################| Time: 0:00:00
> NOTE: Executing Tasks
> ERROR: isar-bootstrap-host-1.0-r0 do_bootstrap:
> ExecutionError('/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/temp/run.do_bootstrap.1248',
> 1, None, None)
> ERROR: Logfile of failure stored in:
> /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/temp/log.do_bootstrap.1248
> 
> ERROR: isar-bootstrap-target-1.0-r0 do_bootstrap:
> ExecutionError('/build/tmp/work/xenomai-demo-amd64/isar-bootstrap-target/1.0-r0/temp/run.do_bootstrap.643',
> 1, None, None)
> ERROR: Logfile of failure stored in:
> /build/tmp/work/xenomai-demo-amd64/isar-bootstrap-target/1.0-r0/temp/log.do_bootstrap.643
> 
> Same issue for QEMU.
> 
> Any idea?

And build/tmp/work/xenomai-demo-armhf/isar-bootstrap-*/1.0-r0/temp/log.do_bootstrap are empty?

BTW, what is your container engine here, docker or podman? What is the host OS?

Jan

-- 
Siemens AG, Technology
Linux Expert Center
