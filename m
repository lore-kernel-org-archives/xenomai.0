Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694255;
	b=g+W/txLnmMTcQBUP/uJN7SOC7tpmQEC0yuCHIGxN/jY8w2kFyCeKjGzGr9ND508Q3eCU
	 e2F3cADGMud6tdjvfoGQ59ZeIeYYCgcIlGs2fKrBhpHJs9RJeqca0UOTUrdlbvT2wuRlF
	 cv12rg1avGMqngN0A3a5p85unxk2i+zgGwPtl7DyHkA1IfpC6UGRqY3erKK/XROYwzXNG
	 S8B4YEZRM0sfby6NbAfp2zAWKm9h8aV8RSs9RFExVZu1i8TOrs85stX5LI4t/ZSoTQfZj
	 3zNa+u2wj96IhbVNpdXAZrAGVjEZ2AUsdadmWqI4JXgSOig+6g7CmV8TNEFFfRrdF0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694255;
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
	bh=TRV5nkJ47v5xX3mb0MGMvNkOHNgHApTzH68LNgd9z2o=;
	b=CsLRKzCQsq4Cj1O7h1fXFO+X5tiLOoZJ0Rc+GF7PK2pFSs+ILPIPvdsFwMg0Koghd6b2
	 xmpTVP53QgwWdAqL1HAG8X2jaV8dTvO7H2nDNtAIrDhqxvl4Rt4a5uchiFPQnCFQruaKe
	 uuA6tBvlQ7CrGQwealOFELkm5ypm/gL7N3tBqrxhEqzIEpMnNF2WYozs2hkfnPAvLcCZC
	 IC9Wa7btpv/je7ymHs7t65WWk1xLecT5cDxBQOMVzpgJP4VrMFnmfQZjbjpOHHA6dMh3G
	 HbF0MrAfcW/n3p9FFNs8oaI2YVz0E5FUF2CndaduMOxVn5N1GwH60PJ8dNLkimyS+rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=q6an8wyV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.45
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765B606A324
	for <xenomai@lists.linux.dev>; Tue,  3 Nov 2026 08:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D765B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=q6an8wyV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cECBG/UWprEuSMMfGp2AVAlTjm3t3RvbgjvffOr0389YJTaftpDaTLKJwYax2MMpltbm15i//qiCbvs2itaOo/j34jx3GL+NtfZhzmZgGJQc/TDG/9bzYZo/k4fjovXSYbvL07oXzvVBE7WOzadnSZnb69sS04vBnPuLPzUJIJjDoPMPewmC6fXmjjyABw4sIDDuxgehtDZe0z+Jb+zWNyYRZRi4x1aSWvWNE7LkmRNB2/0uLRvoHqGx3SkxmIeylsJ+NwxCfHF/fGczwvTNA+UFX/EhRGWqUcE/dr3lMUhh8vjGl6nPCzbXj5YZ4hvT3WF5236NOH7VzSNpwWlNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRV5nkJ47v5xX3mb0MGMvNkOHNgHApTzH68LNgd9z2o=;
 b=zBsoHm4cp/vg57jzsTU9K1h0A15ETQtpyQXc5N0hSIQvZ0CAE8O50BIdrmLAX16+e87mUBj4p4hvTOT0yoYI/AHs+7A0GRHUKZZVboapyX4j0C+V23h9oz/4Rdn/CuUoIRiY/omRdxXafJNKXOR8suZWE9f3M09p9yro9OdG3XxmrYO5WDPvNk5ptsjUfO5XKS8nj9+FphtVBYDwB2AeswqjCMq1skBDYWGNbMUwny6nz5fPTFKsGtxwKqELk1DM9jQtnI5tCCql8MKTGE11eVIncyBhKGO95QdGYehH2Jfgjfai+/qJYKFmV8Qtp3oMslWYSc1e2Y6mXZ+mJxDl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRV5nkJ47v5xX3mb0MGMvNkOHNgHApTzH68LNgd9z2o=;
 b=q6an8wyV11QZr/gl/qqXj6AKRg6oXK75X5hSqnDOk3BD6P7KZVQ4xL0ZWVRvquOrk2RXyNdfjt5NeloYTgjeNxay0sTcJvJekv9Rh6FbwJvCLWFnD3cExm9zStbxj1v/E5UDlnKOqEcYjPzkqOP+WfU31SFTCW3SwbjOHhpyw6W8+aJX5UCLuMGumu8wVrJATOv+lsL7fe1m1rsy0hKlIcU94UxCqR0zEBM71L+a6FB8b3bl8Ir45ERD59MlRFVmPw94D8VAbvEjWQ9bvQz1GiZRAnuG6RXUhJqnAYFXTNpEuW5PKrUyypFWZUKZpidI9GYV68h+nm/U5gR2qkO+Xg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3258.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:118::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 08:24:11 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:24:11 +0000
Message-ID: <ff32cd76-1dd1-4e0a-b1e7-ea069663c4ad@siemens.com>
Date: Tue, 3 Nov 2026 09:24:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail 7.3 v3] ARM: dovetail: Fix inconsistencies in
 trap routing
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-v3-1-1738670e743b@siemens.com>
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
In-Reply-To: <20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-v3-1-1738670e743b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::13) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3258:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1bf17d-9eae-448f-10f3-08df3983d6d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261022113327099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|56012099006|22082099003|18002099003|261102123227099003|6133799003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	eXanI8op57sFCPEiuEiWQnRvZivQylc9+k2+Wibak2oVVHUztPsjGjgy/2hGs9J4ih51eQxxjgXB3sv9Yt8E2I+1Dj3oQN73s7fhbch2gqU3T0K4RSbapwjripxGYQsnb3m9NaGHr/FmlSHsNe8USuda2kkqc/CEe273qB1tfg81oQ6ebubTmf8DK94F5bVJD0Rgc2uyedvq5J6L70thbRtfQkkE2KujDsnezfdgqErE90vbtMGEOxm3dprVS4uf9bFSNUEpRQAGDoq+S1KzSzsjywd64Q+y+HD1V7PXaWCwoavEDEQuVHUSynKIDxxh1V8ILOGrVBKecektFmdsJqqmBudMrT0EPo13iypDMj/G2BSC2k44Qwu7dZEYAoBrL+pNaapNdf/l8UpPJGgny/A1Dlp3V4aTFnLSpry2lLbuGC3B9fQeR+ev1qfF5KZ91iNIS6NhojX2y9Un2riIZ0NkYUCLHuk47XMHd0hWOOZP2KAziqy1npi4YUzNmjrvsKG2fJHgXdVyNYOKk5cPRiu4B5P7BiZwQSMj3Sxbc1knv+69iHS18nWwJvxKBFqYajY6c7vtgULfrHOFtJ+fU65vD2lRvTgi6/soAQwK2KaIsyg/8Yo2FMmfNRULFc0zzIjEw2PEG109PIXp99nAXlpZqoMI29vysbiQzZ85IVI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261022113327099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(56012099006)(22082099003)(18002099003)(261102123227099003)(6133799003)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVRFN3pTcDBTaktONXR2NitvVU12WHdWK0VHbktLYWtlN1YxRzBNUGtnVCtN?=
 =?utf-8?B?VlZtQnZhUDBaaTZWdUxxMW1pRXBwQ1ZCb1Y3UzBaazgrRHhSZ1I0NEFGMC9v?=
 =?utf-8?B?dHNlQWdVRTRsVTJNUmlISE9SaWNVNVJSeFhPQnY3VjdtaUJKMmZyeENyZmxR?=
 =?utf-8?B?cEhsWXZIMzhzdEluTC9Rd3FvdzkrQmo4MWZodUltOVVIVisvbGQ5UnNoelho?=
 =?utf-8?B?T3Z2UkFuL1FEbEpSK2Exc1N6N3lVektUVEVQK0ZmWnNJUFg3TXpKK29ENHZ5?=
 =?utf-8?B?V0J6OWlGUTFBK3VENjVnbVlZRFJnUjcwL0NqSkJ1Vng5ck5zWms3bWpJQmVl?=
 =?utf-8?B?RVFpMEJoWnlDT3VtSyt4bG9PREJvbnZ2eEtXVDEwNWkzYkZ0WEhSNmxRd2k0?=
 =?utf-8?B?bmtLOVRaUUNEdUVzdFI2emQ2WWZaSStXRHgraFVrSk8wK3dKR0RmR0grRnh6?=
 =?utf-8?B?OWlDV3JGUkxoeXdPNFZoK2JzS3owcUdPYVd3QkpZcVE4TXowMXdscTJqNHV0?=
 =?utf-8?B?UU5GU3QxVFlLOStPYUt1OFlNZGtqU2J0dTd3YXY0L2ZLOCtWb3dvSU0xbG41?=
 =?utf-8?B?emxhN25RaC8xQWV4QytGUlQ4ZnFFT0pLV0hEU0lnL1JWdmpNNEpVKzBROS9a?=
 =?utf-8?B?ckFoV1lRNGZ3WExiUGxZaXBnc3FleEZoVnFZZ0lBQjB6eVlUMXZHMXNIVjlF?=
 =?utf-8?B?YS9CZjFuYXJnRUFFdGtZeFVwaWs1RXM3dWl2bllDcVU0S3NDa1hzaWJoLy84?=
 =?utf-8?B?eUtZdmZxa3hYRnoyOVAvNCswem52c0g3ZWpyZFpaclU1Mmc1dTlvMThYRDBB?=
 =?utf-8?B?empST2tHbWQ4TWRaTEhEbVZPRTFrOU80OFFQRkc5a3BrZm84TFltMGJDbEtM?=
 =?utf-8?B?YjQvQVBEejhUWGQ3UzFIc05nS09wK3E1Kzk5NnZkR2kwVlEvYlJNNGNKS2VT?=
 =?utf-8?B?dkRHUDB3MUFYN0RYVWE3Y2UzTkFRdDJwOFJmZ1h1WFY4bmxTOEhHbStZOWFN?=
 =?utf-8?B?V2NWWWR4SnA5ZGY2YkdRdGNMZGJLNVFxQTlnTDUrSEZIdGhwci9XQVcxemRO?=
 =?utf-8?B?M3ZyS05wbDlrZ0Fna0VRRHhwcENhclJtbTRQMnQ5QUpjWWdycElaa1J0RTUy?=
 =?utf-8?B?Nnp1M0FvQWIrUmdSc0xQalZjMWhJTUtTai81WGpUNzFzcTA0Q2loRFZ4Visx?=
 =?utf-8?B?Zy8rM0E5WnJlbXBUQlYvWUF5ZFlLUHpCdUFPTlJIQ1NoN3JwaXVEU214a1Qr?=
 =?utf-8?B?U2tvbFlVNllHOXVvQTRIR3ZxRVZFL01TUzVZTkZMWXI2eXRPSFJJY0wxN0RN?=
 =?utf-8?B?SXFtMnVvWklMajhiOWFRa1BMZWpSVTZaenNLSzJuK3BXYjlENitIdTBJdk1U?=
 =?utf-8?B?K2QwYmFnSC9iSHVWY2FGNDkrdWVkeGx2MmdjTFNtWGhXZ2I2R2pOU1BNUlI2?=
 =?utf-8?B?QmdFZEFCQ3owR3gvQmdpNXFWdVhXdnVCTVpSTE9kN1hoODJwMStCeGlxaG5K?=
 =?utf-8?B?OUFiM0R4N2I5dkxoNmlzMGZabUszUVlXWXd5azJpc2JMK0hBWlVjL3ZEbXpC?=
 =?utf-8?B?SG4yRWkzb29wWWJFa3FwUElpRGdrVWdJNE1xZjBCemxlS3VCRnR1bXJwN0Fi?=
 =?utf-8?B?NndFKzc2YzFVSUR3b010a1VSNzFpRzRvVVpyczYwdVpvWFdCV0loZlk2Q0pj?=
 =?utf-8?B?bFdkclFLaW1MK20zbGNiQWZwbnFQeldOOUVIZC9kTnRJanA1bG93WTlVZnlt?=
 =?utf-8?B?SE8vOXdXTWVGMjNlckFQeS9yZXhyL3lwODN4UlkvRjh2eXYwOE8wN0RaR0pD?=
 =?utf-8?B?RFc0RVZKVWdFTjZVSlB5b01IbXdVd2FRZ3hObStpUkRrRitQWC9zUHhvcEo2?=
 =?utf-8?B?VG5za1pUOVh2enpQL3U2ZU9SNThVcGU1QnlvSis1bXNWRDBaK2poeS82cU9M?=
 =?utf-8?B?Vmk3eVJMTWpjeVdaMExpM1lON0VMOE1xUHRQV1dTOGthdUxSTDJTY1ZoM2Nl?=
 =?utf-8?B?SzVQS3NZcm5YWUxNYWdFdllKT2dtdWJjYTBCRC9OR3ViWTNVdXJJbjJ2ODR3?=
 =?utf-8?B?eWNRdGZOeExuMSt6NWxjQVNaVHpjeE5EcWQ4NzVCWnNrN3dPOVhMeEV0Yklx?=
 =?utf-8?B?UjFodEhvZzQ5Rkk5YVAvSmtKSjFjQkRXSExuVGR2Uy9KNmEyb1NYaUQzbGFv?=
 =?utf-8?B?UkVhQUZOL0xNYzAxRjgveDVORDc1Y0xHQTFpR2EyUUVQSkVZRVVnWldrUkhj?=
 =?utf-8?B?TEVkK0ZUSHEyZktWa1BTN1Urek9nelRnMVJPK2pnVk4wS3dPdUY5YzNsVGYr?=
 =?utf-8?B?TGpES0xLSzlWdTRPMVd5UUtveEtPUXZkMkwyU1BWYnkwYkgvT0NYUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1bf17d-9eae-448f-10f3-08df3983d6d3
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:24:11.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjXidYSqiwQTLoURGgUxuNfNLamk3Ff4XgvbsqAuBRiLQUoFDMQBaaUBAFyQPlvPEI+A9c5KlH+F7C605nCmpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3258

On 02.11.26 17:19, Florian Bezdeka wrote:
> do_bad_area() was informing the co-kernel about an ongoing trap
> handling - but only for the trap over user mode case. Removing the
> dovetail_fault_{entry,exit}() pair removes that inconsistency - we
> never inform the co-kernel now, callers have to do so -
> and fixes yet another issue:
> 
> do_bad_area() is called by
>   - do_sect_fault(): fault.c
>   - do_alignment(): alignment.c
> 
> do_sect_fault() already informed the co-kernel about the trap, but
> with a different type: ARM_TRAP_SECTION vs. ARM_TRAP_ACCESS. This
> nesting is removed at the same time.
> 
> The second caller, do_alignment(), used mark_trap_{entry,exit}()
> instead of dovetail_fault_{entry,exit}.
> 
> In addition, leaving a comment in do_bad_area() why we do not have
> to use mark_trap_{entry,exit}() here. All other users of
> __do_{user,kernel}_fault() still have to call them.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> To: Xenomai <xenomai@lists.linux.dev>
> Cc: Philippe Gerum <rpm@xenomai.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Changelog:
> 
>   v3:
>     - Fix ordering problem in do_alignment(), calling
>       dovetail_fault_exit() after hard_local_irq_disable() would
>       trigger a WARN_ONCE().
>     - Fix whitespace issue in fault.c
>   v2:
>     - Fix wrong comment in do_bad_area()
> ---
>  arch/arm/mm/alignment.c |  9 +++++++--
>  arch/arm/mm/fault.c     | 12 +++++++-----
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 612db267f6246d5e5ed1c2e9291d51e315aaec25..f3be49a007a66357573f431125bd4cf8bed19c87 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -25,6 +25,7 @@
>  #include <asm/cp15.h>
>  #include <asm/system_info.h>
>  #include <asm/system_misc.h>
> +#include <asm/trap_entry.h>
>  #include <asm/opcodes.h>
>  
>  #include "fault.h"
> @@ -803,6 +804,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  {
>  	union offset_union offset;
>  	unsigned long instrptr;
> +	unsigned long irqflags;
>  	int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
>  	unsigned int type;
>  	u32 instr = 0;
> @@ -815,7 +817,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (addr >= TASK_SIZE && user_mode(regs))
>  		harden_branch_predictor();
>  
> -	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
> +	irqflags = dovetail_fault_entry(ARM_TRAP_ALIGNMENT, regs);
>  
>  	if (!arch_kentry_test_stalled(regs))
>  		local_irq_enable();
> @@ -1001,13 +1003,16 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  		 * entry-common.S) and disable the alignment trap only if
>  		 * there is no work pending for this thread.
>  		 */
> +		dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
>  		hard_local_irq_disable();
>  		if (!(read_thread_flags() & _TIF_WORK_MASK))
>  			set_cr(cr_no_alignment);
> +		if (dovetailing())
> +			return ret;

My token consumer says, that this condition is true for
CONFIG_DOVETAIL=y, but dovetail_fault_exit is only becoming a stub when
IRQ_PIPELINE is disabled. We either need
IS_ENABLED(CONFIG_IRQ_PIPELINE), or we make this unconditional.

Jan

>  	}
>  
>  out:
> -	mark_trap_exit(ARM_TRAP_ALIGNMENT, regs);
> +	dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
>  
>  	return ret;
>  }
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 95870a96a628631d67d391ac857ce038c10610e9..d4cb5d8db89b41eed4b1ab3bd6189cd6945084ad 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -212,17 +212,19 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  {
>  	struct task_struct *tsk = current;
>  	struct mm_struct *mm = tsk->active_mm;
> -	unsigned long irqflags;
> +
> +	/*
> +	 * irq_pipeline: No dovetail_fault_{entry,exit}() here. All callers
> +	 * are expected to have informed the co-kernel already.
> +	 */
>  
>  	/*
>  	 * If we are in kernel mode at this point, we
>  	 * have no context to handle this fault with.
>  	 */
> -	  if (user_mode(regs)) {
> -		irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
> +	if (user_mode(regs))
>  		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
> -		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
> -	  } else
> +	else
>  		/*
>  		 * irq_pipeline: kernel faults are either quickly
>  		 * recoverable via fixup, or lethal. In both cases, we
> 
> ---
> base-commit: 1e576742fe11627dd0343deef641cd6805a76f22
> change-id: 20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-d38cb5798455
> 
> Best regards,

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
