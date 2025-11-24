Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3536D4E7
	for <xenomai@lists.linux.dev>; Mon, 24 Nov 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971555; cv=fail; b=e2Jhn/wJH1509A13PztNFoT36lTcB2OQf2qMA+QCDtfj+7NXEDqr2exduSOs10yh5TLqDj4HCU3stCDJ1P/EepppYvtBEdbKPO0H0BYuNIVbjjT3Tq1iYr4T/GTVknMsdk+iVzb56FfhD8+CWdmG5DXnfhJBFlQcGs/P2stntA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971555; c=relaxed/simple;
	bh=ORcXtNsRHWgWn92aZ7o86gV1krkBmRGnHfcyjZ4d+Xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tU8WTIBMDtCBv4gT2SPbh67GJQ5nLKaf3FTv8b+Mx+70ho2HgGV7K20aM+G+hIyCj5tEmgB1wIXzGOOtOMvfTB+r1vG/NTiZ6eC72l4jZ0RsOTn1X7AeagkGiRj/+yOEUTSPR/ZHA4y9CtnF7qQiI4xRwNqC6uewF9Q6HMm2rPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jxQCzqmr; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jxQCzqmr"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id A634D43B61
	for <xenomai@lists.linux.dev>; Mon, 24 Nov 2025 08:05:50 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1539827E00A2
	for <xenomai@xenomai.org>; Mon, 24 Nov 2025 09:05:50 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=jxQCzqmr;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c20f::7 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-Status: LEGIT
X-GND-State: 0
X-GND-VSscore: 0
X-GND-VSVerdict: clean
X-GND-VScause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeektdejucetufdoteggodetrfdotffvuc
	frrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthem
	uceftddunecunecujfgurhepkffffgfuvfevfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpe
	flrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggft
	rfgrthhtvghrnhepvdehtddutdfhfffhleehveffkeefgeejhfduheektdejheehgfevvdegheduke
	einecuffhomhgrihhnpehtihgtkhgprhgvghhsrdhmhienucfkphepvdgrtddumeduuddumehfgedt
	feemtgdvtdhfmeemjedpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvg
	hrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemudduudemfhegtdefmegtvddtfhem
	meejpdhhvghlohepqffurffrtfdtvdevfgdttddurdhouhhtsghouhhnugdrphhrohhtvggtthhioh
	hnrdhouhhtlhhoohhkrdgtohhmpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgv
	nhhsrdgtohhmpdhqihgupeduheefleekvdejgfdttdetvddpnhgspghrtghpthhtohepuddprhgtph
	htthhopeigvghnohhmrghiseigvghnohhmrghirdhorhhg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efos3aZI/Q7fh4kqfK+lFq5RBbxkmmT9tW0b7r4WsciqD/Gc7ujc/1ulMGOeT3XNBOgqJzKCkbatuMMrsdmR6hitHVamVDfugz3sunTzzcX9SYvirNDWjpLoZgzL4WUkfbMNoQWtIfTbjlq0PFtmWv4iVwzYzEgjFK8Hz4omxKPkORLkAv8uWD4Rjnpfg3QcWGVj0jfAocN1MrzuYHynjrhCVhyzFGiKWsQxAjYWbiKfSaS8xlY6CaV9lu84bV7jXTarqjmudsqPzotZQO/FRmVvAFVBgPDEpSyXEL7HLIfBznk0jSA88jz1VlkVzuRvfG/pIb5/byiisIYHt5vJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmo6tJRO5CyLe4oABYyZFFSczXDpa2JDvk+5y4o/41E=;
 b=pMnxv6ROGRsaSP5Mc0kGw/4VuFQNIXJy9Jz2LMG6GkVfBr7+GLGU47oQAODhC1Wr1BtIFd/ur6SjPqD1siqN48M3BQPdpqpFBK9SSL2zZhPPlzoUvmI1q3JtxMbC9SNVUFfItF+8AFvNnuso+G4k4D1TquYxq7eMK8ewI3Bo41NP1WpAz2kb48jmr6Qh63EN6s0DFMe0kGIM8xeJvbLVhDQXHHUf+HR+CmgCikD2yShzGsOZWQUmd3aenY89VOs6p9WkinOjJmsWIc2NXPkfdGFTK9pnvkaAhy2rXRKe4k49xo/7D/cVd6J2Ze12tKVO8KKNhXCW++TYRz+ECmfBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmo6tJRO5CyLe4oABYyZFFSczXDpa2JDvk+5y4o/41E=;
 b=jxQCzqmrn2og86tMhq3kv9gUrN1gQPn5nQ5n4wOyQBCL+EPBvbIoP1njUYvzp5N12k+H79nIwrqou0Qk3XCouPpiNUaO9J78SyZ9GApP1R5El3cloGf3yh5ZPsruTHy8/4j6shhhuZl6dwrUvV9ssdqc/r1wMVxkboG9coI2xLC2m16O0gRy3QsUqZd9lClTcRQp+/VlCFBs73tOtCkvYBwqcqWbtfOWhjZ6eZSjLq58OsOPOn0je0sakfPBiQj0ZCGdKvlR/AVH8Y4tfoD35tNJsJ/juf5ifuAzDqKhPoSQl0Rb/hS7rdcIVSL5vpjejjXfk1uaW86/2NSL2BdQAA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:05:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 08:05:48 +0000
Message-ID: <e8922e1a-f56e-4ad4-b93f-6c1798bb9a7c@siemens.com>
Date: Mon, 24 Nov 2025 09:05:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry Regarding IRQF_TIMER Usage in arch_arm_timer on ARM64
 (Jetson Platform Porting)
To: =?UTF-8?B?6ZmI5Lyf?= <chenwei43@xiaomi.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: =?UTF-8?B?6YKx5paH5bm/?= <qiuwenguang@xiaomi.com>,
 =?UTF-8?B?5byg5Yev?= <zhangkai16@xiaomi.com>, =?UTF-8?B?5a6J6L+q?=
 <andi6@xiaomi.com>
References: <f8c35bb814fe4e258fb82ba542b83f80@xiaomi.com>
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
In-Reply-To: <f8c35bb814fe4e258fb82ba542b83f80@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3199:EE_
X-MS-Office365-Filtering-Correlation-Id: c7760a79-b6fa-441b-e5c5-08de2b3046e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmtnYWUrditrdTREWlUzT2FQLyszMmg1TTVSblJUaEtndmlmWTgxc1BGVmgy?=
 =?utf-8?B?Kyt2NUNUOFhqTzlxTlJKaVo5QnVILzd5VHF0OTRaZzZ4TFVJWnFoNFZxZjlP?=
 =?utf-8?B?SE1VOSsybFk2VkZxaXI2ZTIwVysrNDZpdkY1NGNDODFaN0F1ZXlkR1pFb2sr?=
 =?utf-8?B?YjQyeEVUalFReVNrNXpBd2RYNFRtd1haRWNjYjg0VzdLbzBmcVZCUGFUNDBm?=
 =?utf-8?B?R25ESG56V3JPQlhaK2NvcUllR2hYWFFhUzFsOXJ1cVVBcHlqUGhRM0hUaEtq?=
 =?utf-8?B?NndrR0pBdElFZmVnV1UxSXFOTUxWY01mbjVCb2dkbnY1Tm41SHBNazRlbDB4?=
 =?utf-8?B?clA0TEp1bVBJN1lOelBYNFM0ZWdMaTAvSkNmUjh1RlhsT0ZMaVYxSEJCRlUx?=
 =?utf-8?B?TTl3UEJZYngwS2xRSzhyK09GNS8zdU1HcWlkRnB2bHZGTk9udnhuTndvTWtS?=
 =?utf-8?B?ODM4N2duUHlaeEZSMWh0OWRZUjZORUZEZlo2RW5ibTNja0R1cmlOQXV0OTBj?=
 =?utf-8?B?UEsxR3MzMjZGdTVWSVFSK2NaNTNraWkyQ0RQUWZIUDhuVVZGejA4aXhWb0oy?=
 =?utf-8?B?VVdJRjlQZWluamhZYVh0NklpRGtPalR1ZFdRNVNBbUZtb2Vwd2hlNjJ0OUI5?=
 =?utf-8?B?MktoLzh2bldHU29UeWNseWlGMFZaYm91eDBQUVg4TDNXbFd4b3J3SG5QR3I3?=
 =?utf-8?B?eFpXckJiZEZFbmFTV2V0cHJBL3pQZ3Axa2F2K2hiekdPdnRSRmlsdUFka0pI?=
 =?utf-8?B?TlE4T2JyNmFZLzhwNlRQVVBKNWR0L2R3T1pieVBnTmMyWDBmVDh0ZDN3eHRN?=
 =?utf-8?B?Y0wzUmV0VGZxc2oycUFiKzIvSTlETmNCeklVcldnMVBJQzY0dkZKWEVxT1Vr?=
 =?utf-8?B?Um9IQzJPeWIybEFoT1F6ZkxLYTF0cGgzYlhTUGVnaUdYb0o5TE5IUStLUVlS?=
 =?utf-8?B?Nm5POFZlcUZuQnk3V01jWTBvTGFmOHVNTlRGYnljRmUydytxQnYzZWQ4Qi9M?=
 =?utf-8?B?VXBwRFBvYnBia1lYb0JzUjROSDFLbzQ0YkN5bXVCT0ZYeHAyQ1BqYjRRR3Z2?=
 =?utf-8?B?M3Z3TEJvSkVTdWsvSGlNNkdnR2VkY1BVaElPT1cxNExOVmZmRDNYS1Y0R0hZ?=
 =?utf-8?B?SC9RWEpJL0Fha0Q1RW5ZOEY3UnVvVzcvOURqVFh3bUxEMWJyNm0rWThBRHk3?=
 =?utf-8?B?OWhabEdESWlDVzZZUURMM0RMUjNVRnd5YnBiblhtc0czdWpKN1dmSWxpMzBv?=
 =?utf-8?B?SmN0QXdGU0F1Qk5tbVFoZXJ4VStqQ2llcjhXd05UOU5SaS9rTlY4azBreExY?=
 =?utf-8?B?bGt5V2M1VXQ2WmlQbUV6SUlRZGZUV0wrM0VwL1JwT3RVSWN3Q3BvaWx6U2ZB?=
 =?utf-8?B?clg5Zy9Dc0ZTeWlFVWVhMDdFdHlMN0wwTmVZbDNnK1lENmF3QU93UFkwTFVo?=
 =?utf-8?B?bUxpMWwrNlJ2cE9XV2dwSWFFOEcvWUdBaEN6TEoxbGdIRDVIMlh5N1lTNVVl?=
 =?utf-8?B?MlozdU9NZDMvR1dKSnNWaWErc2ttUDJSV0dyQmRYelJIQkVGYmRoU2JDaHor?=
 =?utf-8?B?VHd0Y2tSSE1zTVVWZmxkVUdicnpmOUJNQVhHWk9uYzY2RVFnTGlxRC9sb095?=
 =?utf-8?B?QnBrNG80UnRHUnRKSitXVW5DVnNOSUV4SUxKRTJWUWlDTUVSdWpXY1BVQzZS?=
 =?utf-8?B?N1FXamhCRmdkb2M2YWRLS1lHeGY5NUZ6Nnc1bmlXUWtMVzE0RWJSOHRZeGZR?=
 =?utf-8?B?ZXg1OGltMnQzQVhGRGljYW9zMGtleExSbnRDd0FrU0g1N3BEdVNjeDV4M3p0?=
 =?utf-8?B?V1lBVExZSGRmdWNHRDVrOEFKQ0lLM1hKUEpGelgwYlhSZEFlTjhWcVVPaVBE?=
 =?utf-8?B?QXd4V1ZqaklmMHErT1ZyeXRaZm5NL2tubklGUVBwZm1kMFNPaEE4Ujdzdjlx?=
 =?utf-8?B?aWtIeTZRNVExSEpxVGpMTU9RUzJqVStvNkl0WURXYjF5MFRBMk8yVzlzR1Fn?=
 =?utf-8?B?eU94UEE5S3U3SVpBZlIybVJTMnl3WVlNS1lETUlMTkM1d0dEb1htaUJqR2Zu?=
 =?utf-8?Q?yIpmRA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0NIb2NpWTYxWkU0VUxhZWpHd2FCV0RrWURhWnZNZ3NqTGs1NzFzdVluQm5x?=
 =?utf-8?B?N0xVczNBckRudkZNUGpwQ0hTSmZFcHRTeFFxZ25jTWhOQjhTckhqamFPVnJy?=
 =?utf-8?B?TmZGL2lMT0dzQW5ndld5UkRNUVBMNFVmaE9kUVlQNEJ4ay9OeEZWU1piVHJT?=
 =?utf-8?B?MFhqK1JhTitqbUtuUVRnVGRMOWNCMkhTd0JzcUdaNElsK1JVNXRYZVBDYnZE?=
 =?utf-8?B?Vm5BK2FzKzhDYStocFg4WjE1alY3N3VrR1F6L29kQ0pFaFFsOFJqZFd0bXdC?=
 =?utf-8?B?cEpMRmZUYk83MXhlUTQ3SlZJOWs3RGcxeERUMi92QmJuSDJrcXVZZStPSE9Y?=
 =?utf-8?B?NkNPdEtmend2RnBmNGlzeWh3WEdldW8xUVRqc2hEdmV6ZmxoMEZaM0duZ1I4?=
 =?utf-8?B?VlhJYUp6K2lVTW9YSXJ0MkxURkJxYXZLeEdDQVBYWEs2R3k1YlNWTHJGUWlP?=
 =?utf-8?B?cEw2TStsMHdyU21SL2NqN0dhcEFzaFpPMENYejIxdE1mVVZ1M0FXeHlmNGhT?=
 =?utf-8?B?SGFEdWJOTTZJdU9DdTF5Nk9aMU5PRStSYWFIY2F6Q3JMMFJUbEl1Ym5Lc3E0?=
 =?utf-8?B?ZWNpbzlVV2I2cTdmdmNXVGlqOWxNMDBHQ1QyMVJLN2xQOHBvMGhEMFFwYlJO?=
 =?utf-8?B?YW5IOVNKbzV3QTdCMWF0Vms5Nlo5T3loWGtHZUdNYXF1R2l2MmNrcDZ6VjRB?=
 =?utf-8?B?MEZienFmL2t6REF0cHgyUGZtQ2w1SUlwYWhnNmIvM09Vb0lsSW1vR05jT0hL?=
 =?utf-8?B?bmZJSjB6amRLUmZoKzkycEdWejJEc1UzNnVHQnB3MUFRWUt1c1NibmdNbVRx?=
 =?utf-8?B?c2hBNllRMFVWUVRRT0FBTjd6N2tFU1k0NGpUenBlK3R5eHpuWnpqdmdST2Qy?=
 =?utf-8?B?ZTBGakRFOUZ0MmdYd1QzN29aKzVCbE81NnRsWHVDYVdJY0dPZ0g3SFNGa3dh?=
 =?utf-8?B?eDIzaFNoVW5WUVZZeERGK0l1ZHplTDlmWHZBS2NTTmg1am9KdjRNcjFjeHd4?=
 =?utf-8?B?RjBwYmwzRmkrSjdhNSt4NjF3ZC9Xd0tzSWhmQ1VRWEFJUjlHM2NvS0lrWXFE?=
 =?utf-8?B?Qm9NMFRYTGl3QmIyZDY1bmx2TGY3dWxoZlIzN3dIM3BjY0liTmVLbDdMYVRW?=
 =?utf-8?B?ZDJvSUNYb2FITnYxZ3FoT1ErdHI2Z0lHSUF0cTE5TTY5SjlRQnlWUGo1enhY?=
 =?utf-8?B?UzNyYmRCc2ZSN3dEbWtYWGFjMVdFU0tRSG4yeDYrWmhnV2t2UnVmRDlNeTRy?=
 =?utf-8?B?VFd4aldSUWxycU9MSHRrdDRTWFlGcU1NaWlmSngyM1l2NGRKbk5VUS9oaTUy?=
 =?utf-8?B?YnFRRHhxSmZMQlR1cG8wRHBlc2loTkJFQ1NURWJMNVd1NjhETUs0WFFIVThP?=
 =?utf-8?B?VFUrdmltSndpQnZraEdLa3NPbk9qa3BJU2FCa3A1RzNLOGVrTkRtLzE4ZWlO?=
 =?utf-8?B?aGdYeWxzNDltVjZIS2VDaG8rWEtYNnFHbVpYdHFlTFM3b1lKejdIZC9CS05S?=
 =?utf-8?B?akhsd3RudGFCZHhGMml6bWUvQWdkbjBVdkFabUdBYTd6Kzl0L3F0R1FIK1Vq?=
 =?utf-8?B?SnZJV3ZVam1XSHRWZGdHaHY1YnpBd0xCVUxXeDFUcVByOUhzQ1VscFVaL1Fo?=
 =?utf-8?B?ZEUzeFdBdEE4QzJjSFNiOUZNTjkrQitFNUJUM2ZIcTlLQ1VseU5tYWJIcXIx?=
 =?utf-8?B?cTJwUzNmL0dDa3RPaXhnN25ORlFueW1QMTVxc2loNjBRSWpIU0d5ZHRkclBX?=
 =?utf-8?B?aWlmSVdES0JYL2grQUN1WGdYRUJHcm5HUEhQTmRqeWxSZ2NQV2xaR29UV2FW?=
 =?utf-8?B?SGh1czI4S3M0L0c1d2dGV1I3K2l6c2lOSG9LakFJWGdtditwNERDY21KSS9y?=
 =?utf-8?B?elcvUWlEQm5qYlY0RkNxMDlEaWNZUzIzZlJDTnhMVDJuT09DSTZEcWpMbjRU?=
 =?utf-8?B?OTZCT2VpKy92RHZ5L2lNa3o3bXo0MEVIVTd6S3g5ZTl2Ym4yMkc4YUNodGVF?=
 =?utf-8?B?ZU5EY25WM3JENk9QVHprTituVnZ1TzhTRitrdHQ4cHVxd3JNSEtxMEk3aWNX?=
 =?utf-8?B?blNHbVhYZktnKzd3QkRaUHNEQXlZdFBTRVdTQ25uWjhBRk5OQUlYUlVBdkhI?=
 =?utf-8?Q?pZfWb9NXaiVDm797IAeuGXXRK?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7760a79-b6fa-441b-e5c5-08de2b3046e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 08:05:48.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgWKuRpfo2tTlMpGjKO7j2x+iAe+BTOX1TTVspDpaCueBLlzaUKp10j0z9ZuXTkH0miuX+bK6viKfVLn6q66zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3199
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeektdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffffgfuvfevfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepvdehtddutdfhfffhleehveffkeefgeejhfduheektdejheehgfevvdeghedukeeinecuffhomhgrihhnpehtihgtkhgprhgvghhsrdhmhienucfkphepvddujedrjedtrddujeekrddvuddupddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddupdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

Hi Dany,

On 24.11.25 08:42, 陈伟 wrote:
> DearXenomai Community:
> I am a developer at Xiaomiworking on porting Xenomai to the NVIDIAJetson
> (ARM64) platform. During the porting process, I
> happend to encounter an issue that I would like to confirm and seek
> guidance on.

What is your kernel version? And are you targeting some Nvidia 
downstream kernel, or already upstream? Last time I checked for Orin, 
upstream (+their infamous downstream GPU driver) was fairly usable, and 
that was somewhere between 6.1 and 6.12 IIRC.

> In the copy_timer_regs function, checking is performed on desc->action-
>>flags for the __IRQF_TIMER flag. If this flag is present,
> The function updates pipeline.tick_regs (which includes PC and PSTATE
> information on ARM64). However, in arch_arm_timer.c,
> when registering the interrupt, the code uses:
> request_percpu_irq(ppi, xx, "arch_timer", arch_timer_evt);instead
> of:__request_percpu_irq(ppi, xx, IRQF_TIMER, "arch_timer",
> arch_timer_evt);As a result, the timer interrupt never carries the
> IRQF_TIMER flag, and copy_timer_regs never updates pipeline.tick_regs.
> 
> My question is:1. Is the omission of IRQF_TIMER intentional in
> arch_arm_timer.c, or is this something that should have been updated but
> was overlooked?
> 2. If this design is intentional, could you please clarify the rationale
> behind it?Thank you very much for your time and assistance.

I think this is even a question to upstream Linux because it's not 
dovetail which invented IRQF_TIMER. I suspect we need something like 
this - in upstream:

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 90aeff44a276..05a85067beef 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1023,25 +1023,29 @@ static int __init arch_timer_register(void)
 	ppi = arch_timer_ppi[arch_timer_uses_ppi];
 	switch (arch_timer_uses_ppi) {
 	case ARCH_TIMER_VIRT_PPI:
-		err = request_percpu_irq(ppi, arch_timer_handler_virt,
-					 "arch_timer", arch_timer_evt);
+		err = __request_percpu_irq(ppi, arch_timer_handler_virt,
+					   IRQF_TIMER, "arch_timer",
+					   arch_timer_evt);
 		break;
 	case ARCH_TIMER_PHYS_SECURE_PPI:
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
-		err = request_percpu_irq(ppi, arch_timer_handler_phys,
-					 "arch_timer", arch_timer_evt);
+		err = __request_percpu_irq(ppi, arch_timer_handler_phys,
+					   IRQF_TIME, "arch_timer",
+					   arch_timer_evt);
 		if (!err && arch_timer_has_nonsecure_ppi()) {
 			ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
-			err = request_percpu_irq(ppi, arch_timer_handler_phys,
-						 "arch_timer", arch_timer_evt);
+			err = __request_percpu_irq(ppi, arch_timer_handler_phys,
+						   IRQF_TIMER, "arch_timer",
+						   arch_timer_evt);
 			if (err)
 				free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI],
 						arch_timer_evt);
 		}
 		break;
 	case ARCH_TIMER_HYP_PPI:
-		err = request_percpu_irq(ppi, arch_timer_handler_phys,
-					 "arch_timer", arch_timer_evt);
+		err = __request_percpu_irq(ppi, arch_timer_handler_phys,
+					   IRQF_TIMER, "arch_timer",
+					   arch_timer_evt);
 		break;
 	default:
 		BUG();

(untested)

Maybe the extra semantics of IRQF_TIMER are not needed for the arch 
timers, and that is why the flag was never attached in upstream. Still, 
it looks inconsistent and should probably be discussed with them.

> 
> Best regards,Dany
> 
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出
> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄
> 露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件
> 通知发件人并删除本邮件！ This e-mail and its attachments contain
> confidential information from XIAOMI, which is intended only for the
> person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to,
> total or partial disclosure, reproduction, or dissemination) by persons
> other than the intended recipient(s) is prohibited. If you receive this
> e-mail in error, please notify the sender by phone or email immediately
> and delete it!******/#

Long live the corporate footers ;)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
