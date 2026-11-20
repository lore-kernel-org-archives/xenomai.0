Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795155848;
	b=LNWvf9SrDL+sc0O5W9oCEEoN2MXjIgH+iVggoCw/EW7bCp3stWaI7jh6mDmhObkXHSp/
	 +t/FZ4UzH7dBBV33gGSFkrTRWFDT7wtvn5/5emKZc8nQkSz3qJT9KdGCv87JVmVLMG7U+
	 Wd+engXSF8ScN7eGzYrMOPQz7eXTyIg1r+PdIscL7OIV8jKcTxg3hqBHHp43DL5z3P5Yj
	 Ci5gzv2hjcBRzRN9EzR6NBiAeXtoKqfApDi99G0Wfde0wUgDuJxpJDKd+P006gQp0zQkO
	 aADLs0EmYAW9tSNR/0Atrjy4AhDmMgI7eui+VAOQCgmIC2o7TlAk2KZHv4F7JihspKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155848;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Cause:
	 X-GND-State:X-GND-Score;
	bh=OBKFo+nc939wKtMO2V9m4aEw/Wj/IxLvLpnicllLsfY=;
	b=Yg1YkiFwXVZ5hCoyFaM1A+xkF+qJsmZZ76LEULODiYrChAfK5YoW/fb2mQ81TUeTMjBX
	 KrwbWBoVCiZrbv3LARf55dgub3lYNjOGOuxdFXzzGlN5NR/tghP0oQ05hSJqBxRPjRmAl
	 BhNFDQlSXBXnlreFVExTIKugWxe8yyOrlCK4uY0G2JuOfpGucE8eClXCnBGWSfOhVMJGu
	 N39Pli9sMIcQpSkseMnvAQtDjQRZpN1qmTHtGOnkPpM/Wlok8vdS7MINlLZLG9FwT5/YO
	 G3feWEN+Gg2qkpdHAhd9ePO5EtYwpIQJsEqmJUL7HYXCey6p2xXStehdqmGZ0eWfbSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=bpQmmOTx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F360A2602
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 06:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51F360A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=bpQmmOTx
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id CAC563F4A1
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 06:24:03 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 880045601D5;
	Fri, 20 Nov 2026 06:24:03 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=bpQmmOTx;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP1Jl/H2+9yBvs4PLUicAeVIZaG3A/e17zXXhrjbgmEZr5BcY9CKMWVdcX74SQX+XLUauz4ruaxAt+F/b1zPuIScHv+XZ1mm84CWVGbRJLtqwQuQokqn/npnh8hLzGhP0p2PB1OO4vCrcpDJ5JO7B7fbkPtBfElLK4FZbCV7Em1C6sJAMwFXeUV/u9ZCjFj3a0RlKHnj6Vv0dVx3YqqDfV3Tu422juwfiZ9xAc7K+0tVg1DzzmdkFn4tiNNcPoIKZxmM09w8qd1rgt6zkF56/hTJly/IUwq219jPYJRC9hXF5g9ABb3zZotQtyo0sr23epqCMypo8pyVs5P4MNzE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBKFo+nc939wKtMO2V9m4aEw/Wj/IxLvLpnicllLsfY=;
 b=zKi+l9SB4de/ZMMoU+sYAac2azKJDyJRFA4krM3BECPgTEAEr00cFm8BN4OsXGx8vwVGRT8Pmh3dQilOyDZFM3yOrLn2jS0NieSeBfcv4mZE6Khg5Qamq9HBv2HbFbRqoe2+OjNNlEg6HHcMmiu+xRobQCg1VN9KxQlGi3eE3Q2/NNndI4M0FRu7NM9NwGRJpDgnL3Y8YG14tiLfH9BWCuW2nl6wlJl2MI4mz4JTDdoqNVAvofrJo4ErZnmmKp5iijzukBrrstUVwR8pvfgWEQvAnXMvRWlaOEvHipnQ37TOIs8V8C0AvcWTdtEWJWvjkLPXNHDJchGnIvhZHlHwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBKFo+nc939wKtMO2V9m4aEw/Wj/IxLvLpnicllLsfY=;
 b=bpQmmOTxGIRhcSIu4UjJTw8YiIL3/K2CmoAMYMqa6OmwuzqHnipPztHjdvUFWvF1sR2lhnFoWP8lJLhlPX9QpxMqMEDwtqGbcllSCNKc0h0a5w1BaF/ih67vkwvaV3vDvEuCNMYr/ZuJsxbyO84GNnWulPkHzRfHO30zvoCsqfGUgUtA7DbB8ID1DMPX23RCC9rFvZzQLb0NpGzoxlC9cSMfqgCOg5o86K9GuxsHkyh0hh8+MRFE6daEuFCsLYaW6DbFGQXLowTtiULwxjS8DxU8v8dDWB9C23G8ihXfV49wghIN0t7xI2aMgf8TB2w2d0S4gewslBQ2bdXTr1r19g==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB8460.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:440::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 20 Nov
 2026 06:24:01 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.000; Fri, 20 Nov 2026
 06:24:01 +0000
Message-ID: <c37dc798-282b-4b4d-bd9c-f2c2f498e08c@siemens.com>
Date: Fri, 20 Nov 2026 07:24:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap
 notification by exception frame
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
 <576b2607-3fb6-4aa7-b96f-e76ac2f542c1@siemens.com>
 <87h5hcoesz.fsf@xenomai.org>
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
In-Reply-To: <87h5hcoesz.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac8a470-e064-4cf8-0a8e-08df46cede50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|4143699003|11063799006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uiOM1PGYD09rrxIAtK9Hlj5s1MCUCoqPc0uyw91LKp1bOUypwVcTNdFHteejcZX6YOyj9p7nAUaIIMo5PfUp7ryRi9gOmjNJp3NOpo3FZyWcv3KmlxLnYblR5+aYd28IuIfqxmvZsOjK4HKKUnMaxDpzMJQYoF8ROIpUdYDO2sqrNOiWkSv9QVXSN4UvxQ1LNF7wxHA8ftS3DcZos7EMAKPZPsKSUlZkFXznJaoLDcpPigkBPnbLcO4qnXT4jfKHLzel6WeEYU35vlcFr1xpVVlWpOe/UbASepLcD1zfzx7ID4acfVj7r1aDjaeCiEM+l4GZpkxILqtIrEutzeZ+f3rfWcSn3V+FRCFuxRAIX2SdmK8AO4B1GiSfi2mNJe9JFkI59N1PnKMCuNQe5Y1vht/zsCbclKRiBXUYk1kOUR3ke0+hUdQtrEiM/mirt/cpJA2/e3AgAx0mdFvA/ErnzcRKxnEgOuIPY2SdwjPn+Q3hicdN1n896Fx5eR8RG+Suno+k6sa0JI1egnpm1IyRvJfAR/M0CmCKrjgD5+4GKTcfvApRN4FEPGH21Qt9dtaBQhx44C7LWLfxXVfhqvE+GW4wl46fn7jkr9PuEmtrRiWuc7XrPac61H2JdOVHsOF1MXVDijZgSwwFa/8N01ReK+Wzm2+iR5rX6Q1Kv/cpe+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FBT2gzcXk5MStXZnBzVDQ1NDBsOTREMTIrZU9GWmZKeGVXQnFCcTlXdjVh?=
 =?utf-8?B?KzNTRDloS003aitQazRPUGVuMlpKVlk5SEJycUtBWjU2aUJ4QTlEd3pmVTU5?=
 =?utf-8?B?eHp3UktmZnpPWDdSODlEWHZJQWMvbjVrbll3elQzZUZiL1JDd0lYVU1nbjNY?=
 =?utf-8?B?WEFmMUJaclIvZTZHei9wUlNFM1hnY0prd0VkcFQ3cFhETWZ5OVlva0JzME5G?=
 =?utf-8?B?Z0RJU0hmK0NZV0pjd2wwcWIveHZwVG1rSVVhWmdGZHkrblVOZGpxd0dNRTN2?=
 =?utf-8?B?MENFNEtEZ2hyQUpqOE8zbnBrSTRCQmFITGVCU1llaktISWxaU0IrcnFWOHhQ?=
 =?utf-8?B?cW5ES3N0cXFKOEZmc092QzFDZGhpcVBsMlJ6eHVRdGkzNEUyaElCREhwY1Ju?=
 =?utf-8?B?Z3ByWEJwOFlqQkh6NWExZTAxY3I5ZjdJcVFWZVNMR2hhY1M0YVp1eHNUa0Vr?=
 =?utf-8?B?bUhKdk15cGx5SmdpbDBYYmx1NGNoSHpqTG80d0RLQXhYeWM2TkJ4VnNqcXpH?=
 =?utf-8?B?TkhTMmcwQVplNGJWZFhlMldiS2cxY1p6aWtnQzhGMWVGRWg3QUlodHN3a0hH?=
 =?utf-8?B?VDR3ZnovR2hFS21rTTZIemhiUm5rTldpTHNrTmNhMktRM0NiRHB4QlVhTWZK?=
 =?utf-8?B?c0d4bTVwdkNYaXFtU2JURWNmQzkwY2VidFNweHFoNEM0QzFTQU9Fc0pKSTVk?=
 =?utf-8?B?M2pPQjJQL1k0K0ZtejYxdnRPZGJka0VxWGcwc2IrcVBwZm1JK1JFV2NLazFt?=
 =?utf-8?B?ZEJVWnpKVGs2OHVFREVWVTA5SGtrTittb25KSlc0dTBlck4xd0FSY29VQ1Jm?=
 =?utf-8?B?R3FML0xuem9XckxaRzhIVmxPRmMzbzU0RHBPMnNqck9MbUQxbnR0dzhyUFRN?=
 =?utf-8?B?Z3oxalU2dEY0bE5yU2lyQmx5dVV0Q09GM0k2alpLZW1CMkxUaE0yM3M4Rjhv?=
 =?utf-8?B?Z0FLaEhNTGg3SW5qQUVxNm1tbytiYWhlTzNQUlB3R0pyNUp1a1I4TXVES21U?=
 =?utf-8?B?RGhjUVZWdUVmMXZsVXorM1ZYM3p6ejI2eTB4Tm90dU5tVVlTVnFaWThGRGZU?=
 =?utf-8?B?dENURndubzE0NjM3ZGdTdnJ2a2RRL05xZzNxaFVKTHJ6RndoOEpQT2VLN2ox?=
 =?utf-8?B?dGpEY1o1THJ6VWNTYVUwVnpGd3FzbGJMdGJhd2l4bVlvd2R6MmtHa1hNUG4z?=
 =?utf-8?B?Y3J6MXpjeFpna1RKWC95QThub2ozSGJFMDVEYWJOY2Z1WFFEUk1yd05CK1Rm?=
 =?utf-8?B?cmgzMTZxaGpGWHJhWHZ1Y3NRSWZramJoYkE4cTUyQlJpT3htcFRPZDBQZ253?=
 =?utf-8?B?Mms2MEJWWkZaMG10dGZWUlJqV04xMng4a0d2RkxoMk1wNHhvNXNaZzFjK01D?=
 =?utf-8?B?MkFiUEZoSVQ5VWFVUmgzdWw4eVFoejBTMTlvWFBRaGtOOWFnYkorcHphSkRu?=
 =?utf-8?B?SkRkOFdQUk56anFaUXFKOGZiMHRlclF4VUxNVDJLMHN6eXlhdVprMlhsN0pm?=
 =?utf-8?B?ZHNSWlh4VDF2cTJSWEwxN2lMdU5Qb1RUc2RIb0ZMWkplbmNMQTZJUmU3U1Bz?=
 =?utf-8?B?Yzc2TWdGeFFpSVhKV0ZxcEZUVGVrSExVN2wrcHJYTFIyTWZBZVJMWkNSWkxO?=
 =?utf-8?B?WDNrUHFuRmlEZW5pV283NHNsU1pKRTg0Rk15WlQ5eWlKTzErUVI4Nm11WTY1?=
 =?utf-8?B?UkRtZ3Z1cEZMVWxRbXF6SWFyeGJpT2k4aHRsZVhJdnIyMHBySzJYWUJ3dlpL?=
 =?utf-8?B?M2NmSlFsSkFIRnVqT3hiUmNaZytzQWVkNUw5dHlwL1ZWYmVaVHdyckZSSms4?=
 =?utf-8?B?S1JEeVpjWE1aNEN3Y3VyV1psTENySHhaN0JlczQybnhTdzFUaGloMHBxNkRZ?=
 =?utf-8?B?MzgxRWlxazczMm9PUFU0MDRUa3lQaDlEQUhiK3lJUy9UNi9wV0w3ZGRWbzVl?=
 =?utf-8?B?L0YybXYyUzh2ZHlic1ZTN2lScU9iTXJnaGdMSFpHL2trRVRRSUpMaEdHZUxT?=
 =?utf-8?B?bm9YQUlvNjVXb2JweU8wZ1M3eC9DUno0MUVtWEFWa0ppWXJpa0ZLZ1J2T0hy?=
 =?utf-8?B?ZHpWalV0L1R5dmJYQ3ZkYVFsakI2NWRkV296c004eGd6MktjcHJ0TC9zbWNJ?=
 =?utf-8?B?YnJaeHkyOXV2S1ltTzE2cVZVR050SjMzTEhnakFTcnYyQmVSeWoxVGU5eEtD?=
 =?utf-8?B?alIvVXpnQU4xdGEwSmpiSGYrVjF6ZmhRTXZaZmlFNE9WVUZJcUwxTEp4b0lR?=
 =?utf-8?B?dVo4YS9nTWVxNzJ6M01sd1lWUzQxemV2Y29ZWEZIY1k1TkJ1VDJ0Yzg0WnRP?=
 =?utf-8?B?RUpSTUFMM0hDZVhjeG1PVjQ0Z3RTcVhGN0tkL1lJYzNuZnBtTGJlQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac8a470-e064-4cf8-0a8e-08df46cede50
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:24:01.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htS64pTwcZTGcYzCRsAQVzg9yoKM6KRT0odPRIpBoJd/LRjphC7lfUyz1TvvbJf1YJVT/X4ROig1bxf3fi1MeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8460
X-GND-Cause: dmFkZTFhnihPy4Iy3NNsjsYwHxan+yoofJjOmZEvz4OYbiEpiP22JRprSqsEeaDSpTr8SUZvig7xTZmvLGA0U+wuzQEQ43TxnaOAgb95Ip2KoGLPgPRxjnrGIA0S1JXJ/eatN/m9ZVP36sTMLQsOLKenUt9BaOvaBzAgEeiVKmNnR5GL0X9mqfrsorUmgTqGPyKdZnaHxf3oFteiAdvhwy040lMAoKpC4QMlpEOTcNyH856yYln6slprIAdFHxaRz53Bv3eVoEUiccpRamUjuGP4a5UIGUTCHgMiP5YYujWUwf5Lg1cpvS1WAsfOOBEEyF7BQ0JSfmMLqcZE+73iyvAzIxfmXQciolCCD0pT+RYPv+noOo3myPW/HO8AqzjqSkiBfajs8fZXZBvmIAhM7+ZWohLnt2KYgeCWi/loUdit3fbL/tCmyxQrogKFjOXcrp7gUiBfLm8l5rd01liambiR9/oYUfhHO+72WoLplUUluKaRXFQinqlFwY2FKAKk6NFB6jdEhfAP6nTSmVc+R3FsWJy6o17rBprcJUf6rPtMSxuqVh4C5+0tbfKq5yRMIRrh4zcZrG6R6OVUo4hCUxWj3HCw+2qCMMl4VfmbChF7l6WYTdFOqil+v2VbCsq0YqH3JI94UyfIPwVwCo6r0/o6B3LjMMJNkLvOP3GjJ/0i3DBJeA
X-GND-State: clean
X-GND-Score: -100

On 19.11.26 19:29, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 11.11.26 13:10, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
>>> calls into the companion core if the flag is clear, and sets it;
>>> oob_trap_unwind() calls the exit handler and clears the flag whenever
>>> it is set.
>>>
>>> This does not cope with nested traps. A trap handler running on behalf
>>> of an oob thread may trigger another trap before it reaches its own
>>> exit annotation, e.g. a user access from an emulation handler faulting
>>> in a not yet resident page on ARM:
>>>
>>>   do_alignment()                      <- notify, _TLF_OOBTRAP set
>>>     do_alignment_ldmstm()
>>>       ldrt/strt to user address       <- translation fault (SVC mode)
>>>         do_DataAbort()
>>>           do_page_fault()
>>>             dovetail_fault_entry()    <- notify suppressed, fine
>>>             handle_mm_fault()
>>>             dovetail_fault_exit()     <- unwind fires: wrong trap number,
>>>                                          wrong frame, and the core may
>>>                                          switch us back to oob
>>>     ...emulation continues oob...
>>>   dovetail_fault_exit()               <- no-op, flag already clear
>>>
>>> Since _TLF_OOBTRAP is per-thread and the thread does not change across
>>> nesting levels, the flag alone cannot tell which trap occurrence owns
>>> the notification. The exception frame can: every nesting level pushes
>>> its own pt_regs on the kernel stack, and the frame is already passed
>>> to both the notify and unwind helpers.
>>>
>>> Record the owning frame in the task struct when notifying, and only
>>> unwind when the frame passed to oob_trap_unwind() matches. Inner trap
>>> exits become no-ops, the outer exit unwinds with the trap number and
>>> frame the core was notified with. oob_trap_regs can in fact encode the
>>> semantic of the _TLF_OOBTRAP flag, thus drop it.
>>>
>>> A forking parent can never be inside a trap handler, so neither the
>>> flag nor the owner frame can legitimately be set when a new task
>>> inherits its state. Add a debug assertion for this in
>>> inband_task_init(), which turns an unbalanced trap entry into a
>>> loud warning on the next fork instead of silently propagating the
>>> stuck state to the children.
>>>
>>> Assisted-by: opencode:Fable-5.1
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  arch/arm/include/asm/thread_info.h   |  1 -
>>>  arch/arm64/include/asm/thread_info.h |  1 -
>>>  arch/riscv/include/asm/thread_info.h |  1 -
>>>  arch/x86/include/asm/thread_info.h   |  2 --
>>>  include/linux/dovetail.h             | 12 ++++++++++--
>>>  include/linux/sched.h                |  5 +++++
>>>  kernel/dovetail.c                    | 10 ++++++++--
>>>  7 files changed, 23 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>>> index 23cae59037c1e..12ab7e49b7b76 100644
>>> --- a/arch/arm/include/asm/thread_info.h
>>> +++ b/arch/arm/include/asm/thread_info.h
>>> @@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>>  #define _TLF_OOB		0x0001
>>>  #define _TLF_DOVETAIL		0x0002
>>>  #define _TLF_OFFSTAGE		0x0004
>>> -#define _TLF_OOBTRAP		0x0008
>>>  
>>>  #endif /* __KERNEL__ */
>>>  #endif /* __ASM_ARM_THREAD_INFO_H */
>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>> index 48563d782a99a..934b080246146 100644
>>> --- a/arch/arm64/include/asm/thread_info.h
>>> +++ b/arch/arm64/include/asm/thread_info.h
>>> @@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
>>>  #define _TLF_OOB			0x0001
>>>  #define _TLF_DOVETAIL			0x0002
>>>  #define _TLF_OFFSTAGE			0x0004
>>> -#define _TLF_OOBTRAP			0x0008
>>>  #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>>>  
>>>  #endif /* __ASM_THREAD_INFO_H */
>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>> index 820a596d9bf65..11164e12317fa 100644
>>> --- a/arch/riscv/include/asm/thread_info.h
>>> +++ b/arch/riscv/include/asm/thread_info.h
>>> @@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>>  #define _TLF_OOB		0x0001
>>>  #define _TLF_DOVETAIL		0x0002
>>>  #define _TLF_OFFSTAGE		0x0004
>>> -#define _TLF_OOBTRAP		0x0008
>>>  
>>>  #endif /* _ASM_RISCV_THREAD_INFO_H */
>>
>> This hunk was forgotten while merging the patch.
>>
>> Jan
> 
> Not sure how that can ever happen since I'm applying patches with mu4e
> directly from the MUA (mu4e-action-git-apply-mbox). Anyway, ... fixed.
> 

Please fold the fixup commit into the original one, or we will have this
commit twice in the 7.3 and 7.2 trees.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
