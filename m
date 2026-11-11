Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794420098;
	b=qbW8OX/dPkQ0JwihPoEBEeRuoLSC9bzltOcw8BsL6NKYD+RvNcPtGEhCF9t5sDds0p3I
	 jEbo9jJ5mhZb+4J/JU7cCrvC4AXcasMbkYYXJ24bioCYrBHK1AQ4tjL5GU+tGJq4tf/5N
	 X0oZ+08NbQVBEQqf+X9GwltC36madRbHuc5pUwOqkeEbYi7Du7XmByIABsjfews1T+FfQ
	 IYJfqQoGKVELcaC+sVO5cnqEPvwk+UhUWdjvljT7YsWqZF0s7r/3qqLrNDnUl71Z8usHd
	 F11UeXmlylnnpyDx/hmNx+3UU+APglN9OmFoftmyJ1TCwzD/9zbyqH2qaXag1Q91Wvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420098;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=q1jMmVpds6grxjD1B8MFIiHJze3ez2Dgb10K9+0nBtM=;
	b=K9UXvCJG+I+Vngn2NYD5MZsDjkEwIoHwXQZWY9tIzxy9S3ahW+CacABaq99Zad1Wpq64
	 OSED2L4jDGjFDIDCe8D9SC2Jf+Hq3isVGoZ66FaN/ariGKxtEbO1DIUgW2ccv7u7IzC3A
	 So2osuihYBFoDzw3OUhWtX/kYiu9YeyT/JuJyAYN71NJrxrLXneho9o5d/wgDomBrP6kL
	 f9kfKs03M0AieZkiAW9yF/sHE1o2yetomuEWU/WEj4iS0cb3IcjDsmkHynrb+1Hh2XPTq
	 9eZ7WHA5Us35jjfnbjrbMFdaBkdbIasdopKz0s7MMujlUkrB2jQszNIntfuXhU10lfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=woT7Okho;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.60
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF44606A32D
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 18:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF44606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=woT7Okho
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7IHkxhNeHu/xCtKbyWxAW6iOuV/xFD11isaQX2ZW867SKwtEfxVSZpgwa22bcOTYO5lNjFfyWcSW6jxL27ePUhuXkGSyMvmDJMdqvAZYWGMe5AvtcdirTRoMGt7evMRi9e0NVBp43pOadXCwiZR6HFPxk+C5GFvFfbp0jcSnjbRnsseJhxRtnnxg1sUt0EPzrDejUNqFbaXxVLc7Qc0map1Zg/fIhSUdOjADVP+fqwyyD7vCual5t4f6nxtMKWPSgm9P5eleFTnfIefi8OhymX44gTU/V1w2Ns4DOu6wK6mcY6OkbsrWW5wkCOFQHxXPuLzU3obaOIV8tSxXfVk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1jMmVpds6grxjD1B8MFIiHJze3ez2Dgb10K9+0nBtM=;
 b=qr8msln621B9DL4otMfy/RqPutoESY0N+wVPBbZJRDNJ7Of6tIQj7em7lMq/eBUEgJrnOrO4Gk3eI4wPG1CAWkPVe6QxDKV7+gATwklkxCJNPqTR9l7tOaFzstV746ikMrRbbIkvGXy1uHvMBgsFLKUXUX//RLc7ipt0V2OLv8iWT3tja9Bl6eFbIeUnfLSLRTEgx7AbPFzW2jU1qIIwBEbxdXCqcqgfHpXIjtZ0a7R90vb/196ChrVxmXbS/PRHY2a+oCV8ion+iuivjYSba2KFntTG9rBlaBuZTxDWBob0PAnWP3ETnLb0qg4IWV2zwX4bWATXpQ4U3XcRdE0LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1jMmVpds6grxjD1B8MFIiHJze3ez2Dgb10K9+0nBtM=;
 b=woT7OkhowuIgfmb/vqJRcHoULkla4xsjGvn1O+88FQAAY0SulEdrDVPv+Zk10QW99zUzd0jXIGKTOAepoiYnjnu9jzgQ3vrB3MB3pHcuG4V3jEXTZrnO7U/JVc17iNXZjj3dF+BWNK4TfLpTmhFZeskA2yjhrvh02w6h6qj3P5RkFkcmt1gS8Q6KrfK7idZEMDgrV3PlMs3MuNGH9XTYu6JhDURlv6qdPGNbDixWlnfk7NXXpKgAwzBRa8xTop+N5h9rpp4FARZrLud0PkdzRD2LjUN8noQPvBT51EDfWaNdTw+OXCgG+MqB4U3RIZZzPkTzxegoOeK/b/xzI2V9Hw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AMBPR10MB089059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6ec::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Wed, 11 Nov
 2026 18:01:34 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 18:01:33 +0000
Message-ID: <f0b54322-4487-45f4-bfb3-11a0164a1466@siemens.com>
Date: Wed, 11 Nov 2026 19:01:27 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] pinctrl/sunxi: irq_pipeline: Fix irq_chip flags
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
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
X-ClientProxiedBy: CH2PR18CA0060.namprd18.prod.outlook.com
 (2603:10b6:610:55::40) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AMBPR10MB089059:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f266132-e2cc-4dd7-86bf-08df401dd222
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|261021121427099003|261021123027099003|10067099003|261102123227099003|56012099006|261009223027099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nSENYfwmNaqkBx1ky78f6MPQecohKixF6cDy0L7eeIPuK6OdwTFde42r6Bx7g0kGdoPWvrICHOTfh2m/vhHiiWdih2vof5esXBZs4fbTCDYW9uy+uJzCG0QCgHLt89dixGDtIbCtfqkN9AF6CgHiJaSiYciiYMMwglUSgof6hr3/ESzf8DIYW+w+Dujp1VpegRupYCA2wJZ2W/EqJov3aLR8IwQAGIQjB992qGi/57NBbGsyXukLNeJnngk7zz0CDe+ok8XDy71E6P61+U5yqyzuJ8KPiY7pDKFkxGsYSAJnvFJCxHh2zILb2tcJ9pH9zuhsiLKGSbxW3l1MnCus7vqADVwA1PzUpv2Fv6jYzED99Jf0xRsfNDuJEdOFyCsNUPJeqWMln8vJ2fnCgdCynAVSLqTobCcFBzMWBTD87Dat+rOKbOhAb/PbJUXJqg/ikO8DOV9U/FSdxF8hf/61hAIJTxUTefWVHZmjtWlSEXd194P+eJJB1vHoTuFf93j1h/vxOKUUOqIGvVzwa7T/4YQnoel6dLMkbsN5iNK384QvfK/0BJ/zg5AspOS15pmIqediRGLphPsQ1nhmF3A34dbndjElOKiOEg/WjheKFQWOzVYzKk9O/xINKHfGrx3K/HZaju7d7G5LeB0R63f6lp9VlZSCbIIYNO3B4mcSR78=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(261021121427099003)(261021123027099003)(10067099003)(261102123227099003)(56012099006)(261009223027099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2U0SXFqTkxWWG04dXA1dytqc1B3WWF5ZWROZ0ZSRXIzSktTbWNIa0hnVll0?=
 =?utf-8?B?QVRFSGJ4Y1h3Z3dKWXY3REhrSU1MN0ljNDVMWnl1aTJQRTBCbDhSQ3ZuTDVD?=
 =?utf-8?B?OEVnZVFpcUZBQkdLUWluN2RiTnZSNnArWHdpZjlPeHdwemtsZjBmL0tVWDdQ?=
 =?utf-8?B?NmlFdWNQR2l3a0pyWWhhNUdnWW9MSitqYnJ6WTZLclVWMHdKdFJZRHpWT2FJ?=
 =?utf-8?B?QmlhWEdkd2pucDMxWHhBdy84dnY3WVI4My9rL1JYbEN5Z0pyVE5zM2JSTW9Z?=
 =?utf-8?B?a3pab0FyTER0dTFYZklRZ2RNSEFWY2JnUjhmVVRMc3VtZmNuTHkzYUEzRm1m?=
 =?utf-8?B?RURYdkFRR0VTa2ZHY1lwVG9XSVpoVTRwV3N2Vys5cmVqb0VYcHJQeFhYdEtZ?=
 =?utf-8?B?blc4SXVCZ0kwWHJ1YWgzS0ROZ1RRQ3FWWWRSRG4wZkZVczdvZVEyc2xrNU1O?=
 =?utf-8?B?KzNkVHpQZHBPOFNyV1RpVm92bjlUVmxQUkNxNlBKSmpocksrMjMva2RpK01Q?=
 =?utf-8?B?a3FxQ0RrbFBDeFRoSXpjMlFWRTJpMmRpM2R3T05Fc0xDams3WUVDVXhCM2My?=
 =?utf-8?B?MHpKRmxyaW9RLzBxNk1ySFBCTFlCUm9scVdzUFVwQjllZFY0ZEZWY2NxMFhI?=
 =?utf-8?B?cmhwZXRscTdSbGVHTmd5bzFDYjRtbldHRUc4c1ZQU29kTEV6OEE0c2hhazhx?=
 =?utf-8?B?NlJROEcxYld3TmZoRUV6L0lGVkFJR3pXZ1k0RDZsUUZtYXliNnVuUmQ2MW1V?=
 =?utf-8?B?MXVlSzFBMzNmR3ZnaTJLK2lyV1c5cnlNUDBYeExJRVJpMGpZRjlYejdNV013?=
 =?utf-8?B?ZHVGOUVKL0lraitoQlRFTmMwd2RrcDRsTXUvQTNJSUgrVTcxWEE1SzIrYlQ2?=
 =?utf-8?B?OU9vcHdMTjFTVVhIb0E0VHYvOEdrRG1tQlVUaXZlaFJ0VHp0WjdVcXQvZ3pE?=
 =?utf-8?B?cFNGYk9QQ2JQd3hPQkcrRWZEdXcwaFhWLzIyWko1TXVYTXNaVGQ2eTllNzNk?=
 =?utf-8?B?aEVxTVRVaXlIYkZzM0ExYW5Edzh4Njd6MVpFQVhpdENCckd0andhUys1N2Ny?=
 =?utf-8?B?YlJIejViVU5kNmh0eWRjZWhBbWEyNllrb0ZKd1NhamRlNDlMNTR0b1p6bXgy?=
 =?utf-8?B?cjhQWGNjMWkycG1TMUVWOS9CMUU0NTJUVXkvSDVUSnVzV0hrdXc4eFA1ZHpz?=
 =?utf-8?B?dnlnNWc1dXRVR2dSMlE5VjVWSm8yUHlWYmc5WTZRVEl2ZDBnNkx3V1JnQTVa?=
 =?utf-8?B?K3dOd0F2SE9kUVhqSGNjTVFDb0ZxSXFDcnZEZ08zUVBMcVNhMWZ3V3BZWnBp?=
 =?utf-8?B?cWFiU25rTmY2WTA2eFJRc09KRnB1aU9mYWI4cktKYjFhU0Q4NDVseHNhaVEr?=
 =?utf-8?B?eEFWbmhzQVkxNDh3ZTJpSE5KcXR2VHB4azBjN3hrc2dOTGZhbUF5T3RHWnFW?=
 =?utf-8?B?ajVRK3B3Y1BnYkZXOTRHS3dmMFJpZnBCZ21QUGJySkZLem14NTAzYmt5a1Za?=
 =?utf-8?B?ZG9RMjB5ZXo2cjRSU2Rkb2xRRkVscmxGY0hDZ0s4UVVmMFlyTExkbithRVE5?=
 =?utf-8?B?aE8zTDllVXhJZ1crbmd2VkU5RzRKSEtpUUt2Qy82ZDhjQlo5MXJ0RnZJUk50?=
 =?utf-8?B?R3JtYkk2ZGZJNlVLZCtZVTEzbUYwWm13TnR2YWQzd0IxM3lPQTQ4Z0hOUWti?=
 =?utf-8?B?Y2lVRFdwNFFTRE9xWHRuQm4xOTB4aE50cGlQeDFzbWVKTUxyT3g0QVg0RVFN?=
 =?utf-8?B?eWNKK2d5bk9wdGdLTnhkcEJKc3JnRkpSbkp6ak5OWVpuNUg5V2x1TldPNjRX?=
 =?utf-8?B?TTJJSFBQMnZFL0ZSRE9iNklaTkdhZmlyY0gySTdjc3FvamZVY3lNMEw4c0l1?=
 =?utf-8?B?bDBrOTVlQzRCaGQ4NUFzQ2JDYU1iVHNUVVJBdkk3LzBqbEJUZ2VFbjFQWUpz?=
 =?utf-8?B?ZVE0QVVZUTRKN3dtbUxlWUhaaDFhdXJPNlIvTDhRaXBpZjkzREIwa3RPV1Az?=
 =?utf-8?B?QmtXbU4xWjdXclZiTUpqYURKNWtUcU9OeWVEWi9qN3pwVXduamsyaDRzL0RD?=
 =?utf-8?B?VDI3QU5ZMUl0MTRtSldkR0VtcE4vRmFSYmIzOEV6cHExTmg1Y01BZDFRbmhG?=
 =?utf-8?B?Q2Z0T1l4YzJ3eW5hWUlYcEt6RGVzR1pVdHpKNXRRMHhOWnZiUS9vMXNYeW93?=
 =?utf-8?B?QTdQQ1lVTlZDeC82VG80Y3dTdm1aeWMzZ2JCM3BOckp0R0l4bm91aEJ3WE4w?=
 =?utf-8?B?REVEc1FobTBkTmNqZ3JCU0xYQzFYd0dscFVkcm1Wc3JYUlNNT3JDOWhqZS90?=
 =?utf-8?B?akl2WUtJc3pHcFFKaHFCVFdRZGpsN3czTmEveFZJNmhNZDdKZjNXdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f266132-e2cc-4dd7-86bf-08df401dd222
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 18:01:33.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj5FGPOKmrqlIRWJcD1ZtK6cnyDryNZlLDvxMr9XEUBFew+sItvJUQK6N6sM7/TusgZJ9/pj+SSGZ2osag44Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB089059

From: Jan Kiszka <jan.kiszka@siemens.com>

The unpatched version uses IRQCHIP_MASK_ON_SUSPEND, and there is no
apparent reason to drop this or add IRQCHIP_SKIP_SET_WAKE.

Reported-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index fb73cdaa30ca4..0ee7d4ee0a51b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1280,7 +1280,7 @@ static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
 	.irq_release_resources = sunxi_pinctrl_irq_release_resources,
 	.irq_set_type	= sunxi_pinctrl_irq_set_type,
 	.irq_set_wake	= sunxi_pinctrl_irq_set_wake,
-	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip sunxi_pinctrl_level_irq_chip = {
-- 
2.47.3
