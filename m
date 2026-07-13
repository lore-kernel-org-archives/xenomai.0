Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BE3E44E4
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938575; cv=fail; b=nqJO1M2fg1MBRiPmGkHi0INIQCYnkphja5y8U+b2tgEvfPO+02Gi85JEUYM7tEQg5lduvHeZAsFqw5r6/7wEo4uBbRQUGwpcMIArhpyhhXuBx0vAtJN111b18mjuveNlAHuQg6cJmrECB2vvbOLEMJJ4I2jSvfF+ZtPj/ZXl5v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938575; c=relaxed/simple;
	bh=UuYoUFpxqEsHjHMYsw4/QsHOqFcS6WUDNjm2eMdJRd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIABZf7AlgWgT+Dg0HHluogICJnmm8aybFl1i3HP+Iw6VCWItHjJOWqi6LnYsWCIwodMO5BA0/nWFF+Sr8+zyxZ9zkqEyVDa4Nsm8QI3ai5JHefPjq2CNgyC7gEbdEv+xaCgbtPaZgMFGbPQAgOo+mvhTpIj02xFyeZ1XfjEKXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TlCy3mW0; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TlCy3mW0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH5+zRVsM6qoOgRDCgMACFR1sRW1BgHzsjw164Lp4h+YIJggnV4J7MQCoTCxf+pEbTql5QIQOsz6Xjedecc9oIzkq8DlHP/EFkXwHdDum85pM8O8bAzNSUT0oUcGIUBHSZXluzbde4oIum6A1skTnr6PDfabC29Bo6oGKlX8NbHjiejEHRMSu4YGEc070dKKevOJ5o4HUDW5njvcCzmm+wJ54Sk9pSmwIquClnVqZiPZCEtC3zB3whQQu+wLvJsXgsD8BQK2qi1CD16N9Yi6TKNN7FHlz0SN4G61lcTmqsbFz8a6KXhJEflpJiLdhEsdAJ/APxMF40oDgfoWP0gx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwDuKoPNOqxYfgGRmP/DlkSgxmJlSUmmvdUH4W3axGA=;
 b=NVF6NSS8Vqm9MHUJeLGGpOuQcon8KIMhIkwyALZWDncKdQNAhiwMc8zkuKL2FAqVqzKAuJBowMRlmPh9duFNb57oWcoIHZfygCDfbL9tocQNUbdRu8EMA8rT+lTtk9HsNk1A3NiLsbUWeQvwPwilGGKgxid0fe3CvYMZB+jbZGXewXqhgZCspfxor63OJ2PXk0VJlm0n/fOrPZpE3h4kEU6X0IJkQzKbRvatDye0Z3gKvowNI9+tiRic2EhGSJAHwKr/R72MJXSyEx/tOeULJhu5nNNiHPPudy2FBXK7Uurz+EeftusZXCzJiBALosFgnAZ09LQp4ex1lbu5fQ5nJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwDuKoPNOqxYfgGRmP/DlkSgxmJlSUmmvdUH4W3axGA=;
 b=TlCy3mW09Xzkw4RVHmQKtTJtHD83MIzzutGq7jWp+/nGJWCMTub12h1eaQhQaax+cSzinu2Umnw9H1vfAuv2kvgzvha94qqJV06oJPsK203QFk0vgMGi63jeTwjlrS7Wxbetm8uxmCaT9HLIdbu+Oz5xGdBhnMSWiRoZf4LZcQx8D0HgmAR1fZwYZ3o2+A0XwwxNsgkjmzfoEzl/N78hQsjITgcfENqGCZXV8w2yRxDsjFMfdkF9HNLqiHeV9/T1rZ0is1GAe5XWaz1sTFwGLbd4vk8rxs7YB0NhIyB8f21EV+zjk3bR3mGcKyV87APwzZmo86V5ejtGMFpO9fQ6+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6621.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:29:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:29:29 +0000
Message-ID: <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
Date: Mon, 13 Jul 2026 12:29:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
To: linz <powertree@163.com>, Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
 <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
 <023fa6882b563713cbcc06bd954c8e9db4200d73.camel@siemens.com>
 <c017bc0.9041.19f5afdb56f.Coremail.powertree@163.com>
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
In-Reply-To: <c017bc0.9041.19f5afdb56f.Coremail.powertree@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 78da735b-9f8d-4675-7aed-08dee0c99edf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info:
	7m50T/RdlSebLaztoCfh2dEl1VrKz8O1AqyqPq5e2X37UkrWBJYk+pP92Q0EchJr88LnnEjIx5DOBOavvsWn6ovqvBBUnu0RXFhPNlQAgVqxOAaTQl6YSrui2Zt5tJtfcq393xT8Wiq1dFdKnHLxq65MeOuTokhBpwqE1nMx9XRHpPfkjjSWJaiAl/q0qq6HuD2kT78YXOqXZ+5VG3IMyxjyPyiGtFIclER8kgZUMilLKDfHKcYAHL6NC0vIiu4GTec6WXmREbBT60GVfoGSXiYb6tD2PfICO3O/WqUfpTcmsKndMt2fIN/a7uRpNwdlJphkqNJm7wGFf0n2V8yAg2sCtzopimC5dcAlP0ltjH871QRTd+EaK3lAsPjtjHP+j0PLPD1UFpyuUmQ5x9vWY4BQ/KAEjotKJQoIGh7tAN1KCnIuXl8Iox6/lyaTtDwcHZpFBro97CMcN2loN3nXGuQ+w7AayV2ZI4MhhyKyEZ/w/f844CmL5fcJOuD1EjU5VxOYGKbDXVtF2gGr2vuK0TnmR7YhrCkhENrZS+hsDWUR1P6n1YY9c33iVtxWZ9UicpWJaOlqS0wet2TEPVun8Vir8LWQH9dH5f5RGZnKVh2helpx9O9Gg/wnmE6l0S2Cu74inpDWbhvkrUPdKSTgVlCL7uY6kpdcYcRfMGgYAPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003)(4143699003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9MbTRkTzBWYVBtayt2dDhvSVhSOWVQWjhTYURVNDhRbURGOTg1c09TMmhH?=
 =?utf-8?B?bVpaM2lWZ1kxcm55RmRxbTNITjRJS21EVW1DV1Jkb3RVd0ppU21ZTkFsckw5?=
 =?utf-8?B?NjBPdWZRRCtQRER1US9mVHdaOFRrTFc3WWtlR2hsVWZubUNIN3lWRlhQY0xS?=
 =?utf-8?B?RDBxNUZRSWptM3VGcUdzbjRTVnc3NEIvWTVrUjlCVG1zM2ZMMWVFd1RxQ0pw?=
 =?utf-8?B?M3VLT1dFbytNbTlsd042eUVyelBvSFZ6ci93cFJ6K0lJdWlkL2dtcEtEYzN6?=
 =?utf-8?B?TUVnM082VEkvTGRVM2FRa01ET1V5RVZiTEhoSEFxaWVnY2xwQjFmc2Fud2s0?=
 =?utf-8?B?dGtJb2U2M0hQUjhQNVdnUXd6bWVucWNZaTh2ZkZaSzhuTkU1RHBqMGJhWWtJ?=
 =?utf-8?B?b0dtalBZNU42SFhEbXJzNi82eUdjYm9BdVRBc2psNWQwVEo4SFJzbCt5Ny9t?=
 =?utf-8?B?aDduZVUrYmZtaks2ZWhCeUlGUng4OU8ycDl2MGppVmJqQkRPeEh5NUtNazQr?=
 =?utf-8?B?TFRnU05TL2VhVWt2a2lYM1dMWm91dnE1NlBMb3dCbG4rT0M2dCs4RERQL3FT?=
 =?utf-8?B?R01rci9JaHNvMUpuMWVBMGdGRkJJaDhxZk5oNkFCTEhobUpFZlFTc2czQ0lm?=
 =?utf-8?B?N2VkUVo3WTBLM0kyU0wwNUs1Z3p0TWJGVFF4TmprcFdYRXM2akV6NGhGemFl?=
 =?utf-8?B?aTVPc1hhTXM2MERFWmFqWE84MUZaclFOVzZWUk9VYk5lL2wxL2hnYUo0eG5w?=
 =?utf-8?B?ZlhDQ1JJK1dEenlqSmVpL2JQc3Z1NlFGR2ROcUIremlEUUdBWnIvYzJHdDdJ?=
 =?utf-8?B?cW04aHExQ0ZSamhwOWFCME5qcGVVU0NOZk1oamozazZUUWU0MGpFZjhmdW50?=
 =?utf-8?B?U2Z3dDgrTEpSS2pMU0JEVVJPbGhuUVQrOTBudXcyaHpBV1hsa2tDMnA5TnEx?=
 =?utf-8?B?WS81L1dpZUZKR1NXdkhOSmRmYmRSdmJFdTFNV3Z2VTNhSkw1T2hKaUZvR2F0?=
 =?utf-8?B?U2hRTzR4T2pydkdydnBLYVV6Z1hyeEFxQ0hOQXpNV1AzSGNzVk16N0dDWUk4?=
 =?utf-8?B?QkUxQXU3aXJTR25NYUwrOFRNR0w0STU0NEFDKzlHWDd2Ukg4c3l3SFltMGFH?=
 =?utf-8?B?cHRmYzRTMklYNEpnNnUxaFR3eWpvQkVYdlFXUTYwWVpGeW1ydVdEZGxkSGNI?=
 =?utf-8?B?VW8xb2FJZnloQXBjc1dBRU9xUi96NFI0OTg2U29hVlpzYm5WSjhtakYyb1JQ?=
 =?utf-8?B?aGZ5L0JSeGpaZjBjeVVlNGltRW9mOURjR2ZydURra1pqL1VQTGdDVERVeHgv?=
 =?utf-8?B?UFJzNkVmeGVhMGd1SmtWUWJVVklvaEVYbHl2N3E4eXZCOXFHdEU4TWZzbGFQ?=
 =?utf-8?B?bDVOcVROY0RkN3JjOG5PNFRuc3NDYnhtOXEza3l1VEE5VzljSmtuNUxUeTVk?=
 =?utf-8?B?cUI1Q1UzTlcrWXhsbG5lTVhOdGNBVGFhOW9kb0s3OGJieC9XWCtubDZYc0hV?=
 =?utf-8?B?QWx0SFBIZE1TaGkrcWdURDJSa1JSYlR5YVEvdkcvQ2hlRjF6MDBVNHN1Nmpy?=
 =?utf-8?B?WTB3S3JaWFNBMndIc2d6clpSd0VOK1dIbFpMU2wyUUJXc09WVU5MTkVzVUxa?=
 =?utf-8?B?UkE4dkxoMXYxVmxZNGU5cE1NQUxGT1M2WFFQYnhCeUlTK2hQbzNRVWtpSTl5?=
 =?utf-8?B?TVBTSEFYMXoxbWRuLzNDMFlGTFovV1BOTCtVMFV0WlVqWGk5aVdIZmFOWEkw?=
 =?utf-8?B?ZWlNN1grWE9BdUVwcEVnT0JGVCtEaTY0RTF2UE5IQ2tCVDkvWnNIeWdyV0Mv?=
 =?utf-8?B?S1BmS3lNLzJhMXZNMDh5Ri9oTGdMSGFIWUVtMDdxZTFzM1QySHBPM0JYc2dB?=
 =?utf-8?B?S3pjMU8zeGFkeXJzOEhmRG1UUFJoTkVPSjR1dUJ0SXZoOVh3c0xZUzJuYVkx?=
 =?utf-8?B?NWR3STdINWlUbXo5ajhHTUVGQy9YYURUMUV3c2c4QkZ2NnkrUlJNK0lMRk93?=
 =?utf-8?B?R1cyS2ZzOE0rdkVpYmVreDdWQ0RrMVBGVitQVG9mYjV4SmdiTm1LbWFiYnNl?=
 =?utf-8?B?MERleDl3QUYyV2laZUQzanlXNU1kcEJ2UGhHeDNzZ0JZRmZTSGFubFluMXlr?=
 =?utf-8?B?ZTg3a1NnQkYwOVgwV2tiem5OYk5IWGphYTZDMWZCRnp1QWl2RmN0VEllMVBv?=
 =?utf-8?B?ZFI3VDU2SFVlZkl6N3VjUDJURk1SWVliNTFnTVYxN1VkK2ZHZVR3S3FEcUdJ?=
 =?utf-8?B?VjNUbkg0dHFOMTFnVHZLS1NCV3F6UHhxMlBucFRxSklZTFM5RWxwdUJsTktm?=
 =?utf-8?B?dkFLS1JCOU12cVZLNXpHS2VTQjJlbnluVm1ZWDJWMEhNc3lKWHZHdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78da735b-9f8d-4675-7aed-08dee0c99edf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:29:29.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4wK0XS78aQ11Ak7M1s3oGeCYr8v4a8xwx8p3TjAxCtWTqnWdEMZbUi2OFv8PRJKIQ52HLBfzqJ1a2qfro46KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6621

On 13.07.26 12:20, linz wrote:
> 
> At 2026-07-10 18:59:08, "Florian Bezdeka" <florian.bezdeka@siemens.com> wrote:
>> On Fri, 2026-07-10 at 12:12 +0200, Jan Kiszka wrote:
>>> On 25.06.26 11:32, linz wrote:
>>>> Hi, I find a call trace when I use v6.6.y-dovetail + xenomai v3.3 branch, the call trace is as follows
>>>>
>>>> [    1.510903] IRQ pipeline: some code running in oob context 'Xenomai'
>>>>                              called an in-band only routine
>>>> [    1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S                 6.6.63-dovetail2 #8
>>>> [    1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
>>>> [    1.510920] IRQ stage: Xenomai
>>>> [    1.510923] Call trace:
>>>> [    1.510926]  dump_backtrace+0x90/0xe4
>>>> [    1.510940]  show_stack+0x14/0x1c
>>>> [    1.510946]  dump_stack_lvl+0x84/0xc8
>>>> [    1.510953]  dump_stack+0x14/0x1c
>>>> [    1.510957]  check_inband_stage+0xb0/0xc8
>>>> [    1.510965]  inband_irq_save+0xc/0x28
>>>> [    1.510971]  _raw_spin_lock_irqsave+0x14/0x90
>>>> [    1.510977]  its_send_single_command+0x24/0x154
>>>> [    1.510984]  lpi_update_config+0x9c/0x144
>>>> [    1.510990]  its_mask_irq+0x2c/0x64
>>>> [    1.510997]  irq_chip_mask_parent+0x18/0x20
>>>> [    1.511005]  its_mask_msi_irq+0x1c/0x28
>>>> [    1.511012]  handle_fasteoi_irq+0x1cc/0x2b4
>>>> [    1.511016]  generic_pipeline_irq_desc+0x6c/0xa4
>>>> [    1.511021]  generic_handle_domain_irq+0x18/0x20
>>>> [    1.511028]  gic_handle_irq+0x4c/0x120
>>>> [    1.511032]  handle_irq_pipelined+0x40/0x64
>>>> [    1.511038]  call_on_irq_stack+0x24/0x30
>>>> [    1.511044]  do_interrupt_handler+0x138/0x158
>>>> [    1.511050]  el1_interrupt+0x40/0x110
>>>> [    1.511055]  el1h_64_irq_handler+0x14/0x1c
>>>> [    1.511061]  el1h_64_irq+0x64/0x68
>>>> [    1.511064]  default_idle_call+0x30/0x78
>>>> [    1.511071]  do_idle+0x128/0x150
>>>> [    1.511077]  cpu_startup_entry+0x34/0x38
>>>> [    1.511081]  kernel_init+0x0/0x1d4
>>>> [    1.511088]  arch_post_acpi_subsys_init+0x0/0x8
>>>> [    1.511096]  start_kernel+0x504/0x5cc
>>>> [    1.511103]  __primary_switched+0xbc/0xc4
>>>>
>>>>
>>>> The function call causing the issue is as follows:
>>>> generic_handle_domain_irq
>>>>     => generic_pipeline_irq_desc
>>>>         => generic_handle_irq_desc
>>>>             => handle_fasteoi_irq
>>>>                 => mask_cond_eoi_irq
>>>>                     => mask_irq
>>>>                         => its_mask_msi_irq
>>>>                             => irq_chip_mask_parent
>>>>                                 => its_mask_irq
>>>>                                     => lpi_update_config
>>>>                                         => its_send_inv
>>>>                                             => BUILD_SINGLE_CMD_FUNC
>>>>                                                 => raw_spin_lock_irqsave(&its->lock, flags);
>>>>
>>>>
>>>> On Dovetail-enabled kernels with Xenomai IRQ pipeline, GICv3 ITS interrupt handling runs in OOB (out-of-band) interrupt context. The original raw_spinlock_t used for its_node->lock invokes the standard in-band-only raw_spin_lock_irqsave() interface.
>>>> This triggers the following pipeline context violation warning: IRQ pipeline: some code running in oob context 'Xenomai' called an in-band only routine
>>>>
>>>> raw_spin_lock_irqsave() is an in-band exclusive API and cannot be safely called from Xenomai OOB interrupt context, which violates the IRQ pipeline isolation rules.
>>>>
>>>> I think that fix this by replacing raw_spinlock_t with hybrid_spinlock_t for the ITS node lock. The hybrid spinlock supports both in-band Linux kernel context and OOB Xenomai pipeline context, adapting lock/irqsave logic dynamically according to the running context, eliminating the context mismatch warning while guaranteeing lock mutual exclusion.
>>>>
>>>> The fixed up patch is as follows:
>>>>
>>>> From 1037fcf6d75ecf37e1caf283d1198177e7410be3 Mon Sep 17 00:00:00 2001
>>>> From: zhanglin <powertree@163.com>
>>>> Date: Thu, 25 Jun 2026 16:56:31 +0800
>>>> Subject: [PATCH] irqchip: gic-v3-its: irq_pipeline: fix OOB context in-band
>>>>  lock warning for ITS lock
>>>>
>>>> ---
>>>>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index 0e57735eac..847b008b71 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -94,7 +94,7 @@ struct its_device;
>>>>   * list.
>>>>   */
>>>>  struct its_node {
>>>> -    raw_spinlock_t        lock;
>>>> +    hybrid_spinlock_t     lock;
>>>>      struct mutex        dev_alloc_lock;
>>>>      struct list_head    entry;
>>>>      void __iomem        *base;
>>>> -- 
>>>> 2.34.1
>>>>
>>>> Please help to review it, thank you.
>>>
>>> Thanks for reporting.
>>>
>>> Philippe, Florian, any comments on this?
>>>
>>> Jan
>>
>> hybrid_spinlock_t doesn't look right at first glance, it's use should be
>> limited to struct irq_desc and IRQ chips. I would have expected
>> hard_spinlock_t, but I might miss something.
>>
>> Assuming the gic-v3 IRQ chip is already marked / flagged as
>> IRQCHIP_PIPELINE_SAFE, right?
>>
>> Florian
> 
>>
> 
> 
> Thank you for your feedback
> 
> The gic-v3 IRQ chip is already marked with IRQCHIP_PIPELINE_SAFE. 
> The its_irq_chip is not marked with IRQCHIP_PIPELINE_SAFE. I added the flag and tested, but it did not have any effect.
> 
> Meanwhile, I read the code related to IRQCHIP_PIPELINE_SAFE. If the gic-v3 IRQ chip is not marked with IRQCHIP_PIPELINE_SAFE, a call trace like the following would be reported:
> MSI domain irqchip XXX is not pipeline-safe! or irqchip XXX is not pipeline-safe!
> However, I did not see any such message in dmsg logs.
> 
> Based on Florian's suggestion, I revisited the Xenomai 4 documentation regarding hybrid_spinlock_t and hard_spinlock_t. 
> I agree with Florian's point that hybrid_spinlock_t should be limited to struct irq_desc and IRQ chips, and that hard_spinlock_t is more appropriate for the ITS node lock.
> 
> I changed the lock to hard_spinlock_t and tested it. The call trace no longer appears and the system works fine.
> 
> The patch is as follows. Please help review it:
> 
> From e0cbc9316af331bf007c86e1fcab0ef8699b05c9 Mon Sep 17 00:00:00 2001
> From: zhanglin1040 <zhanglin1040@phytium.com.cn>
> Date: Mon, 13 Jul 2026 17:53:44 +0800
> Subject: [PATCH] irqchip: gic-v3-its: irq_pipeline: fix OOB context in-band
>  lock warning for ITS lock using hard spinlocks instead of hybrid spinlocks
> 

Missing commit message. Reason for the change needs to go here.

> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 0e57735eac..3f2b02b8f4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -94,7 +94,7 @@ struct its_device;
>   * list.
>   */
>  struct its_node {
> -    raw_spinlock_t        lock;
> +    hard_spinlock_t        lock;
>      struct mutex        dev_alloc_lock;
>      struct list_head    entry;
>      void __iomem        *base;
> -- 
> 2.34.1

Please send new versions of a patch in a new thread, incrementing the
patch version counter in the subject (here: "[PATCH v2] irqchip:
gic-v3-its: irq_pipeline: fix ...").

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
