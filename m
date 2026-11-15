Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794752075;
	b=YZhIFxLq+zHuuEspYmgyFcr2/r6QLsjF8Y3cyf/oaDKUWwWE3Vj/jGh+TUDcGgmljoQK
	 6TdOS0b+M+LuR0Ssmpu0sc60w7QSED8XpEWYMvZKAXOzhvk0DFSx74B5H3mEm3MjiN5YJ
	 mmE4Hjku7NInhb4v4XJpYpypGnYkHo1isPKWgME8oD+Cou6eswAPWuSnheDR4G5F0amMN
	 AJnRKKbisQOP0VzrddF2grmthntDxRzRmvQCvIrRA6yLzj+vPyoPtiU8u3J+9GMOjrzxj
	 uxrxf5ZOf5fDv/jT+1DCYuTn67AOa0pW+DT/s8r+vMSIqXs3rKWg/ZPP37c7lh5ecQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752075;
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
	bh=OJThLlOSD59Aj81Y4+/s7EqFCse97riofiMcacv4sNM=;
	b=Y5w5ISxdfIqwkdPSqFxCkm3gI0QQObQQl94Rlf6kSo46+htxNOY65iGrwBByLu/7HOj8
	 7s4a+8kcjIZB8Zl8zusL4s3mzhwMlLzFk9s/ltrJJurwXXVgAIuElvz0ySeaRI0Ga8fFI
	 WQ3YilY1/woHJgcAdjMN1zmmWobTG+3TWnIiuWwRdlPJsMwxlUV8D9BdUVm+SmxwM5vmy
	 ge8qqrBnNmkO2+72ZTJJUEGPJ31gxBsU9GF1fanmpf7F4FpCHu+Vp0A/aJLE7G9N1zrpe
	 dSeKs8zWlgrDhwEWX11TBK5acKx8zQd/4GOI+zQyrqNOCEwGK3fOZS93niMRLU8Awtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=s7HCXrhA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.3
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D744606A32C
	for <xenomai@lists.linux.dev>; Sun, 15 Nov 2026 14:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D744606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=s7HCXrhA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyRJHkabS/a2vJSi6YCeaPgGSqtz87PyEvfxbbwI+XFDiUitujCdWikdISgCYSA5OzojsWeRiNxaduAxoptAs1I9JU/hWKi2r0oqQezX7wLINgrcK0MwM5uWFj/WU8AIVn551/3I7OZ8QhYNBIqAEwWIOrDynpQrwevAOVxFR+7k8tjC0Wn6QMYY826e5K7XjLTYjXHG6xjmESgBME/bGEyu2r5czBOfNLtgRyXvGApLYNEAbfP0bYHfkERQhsygjDwneVdOdao/d6UKIEg78LfE5zwqCocJ38/E7grGP2LTQ7f5htb0To628D4RSCyxkTsyxZXAwyhfx44OOQQZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJThLlOSD59Aj81Y4+/s7EqFCse97riofiMcacv4sNM=;
 b=ZMeBb+0XMoiijXiLqi3XOzjRI9ZN6Y+5ZZ/aK3ff24H+Ls4JZ5DDiwW/szzUYdjAdIjUu2a/p89z9XIU9+IcZw17eoclBA9UvuO4N0UhlGkd7W3LKh7I8tiIICyBuDF5ber/357+bV5rpiMdfcaUgV6ELrMzq9FEurpDYG4yr2fGyyJ6Cgq2WOPnzGyyQv0ypYtb8ACz7UXQf5RUvMzEmcvtP3q1i6ILEJt08P1P1etvwe0xsHjFlUOcwLRIvhXDWGmtHj+KT8iCEKrVWun0GRImcgySSf3u01GZFnRflXApnYMd/3A3gmbid44jhALxWG1fA6KnCPg/zgXttQpO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJThLlOSD59Aj81Y4+/s7EqFCse97riofiMcacv4sNM=;
 b=s7HCXrhAVFQPx+rQs0pmJpydPnRAHy+n6XFp3am1cFnyuyumy/SPeL0Voy4nwRlpFSwLSxd2YaVncYB5dW81q6+pLrvdsDtWIbSlDG4UtFaxSYW/Ipk+wO6HzmhMDR7FnAkV+bmYLzy8l5dacENNBMN+ROFPTvTUNoM0fbNh+pwbB6+utnYdcSrUGkucxi+rm+lfo1B/Vt9zqBuzXZ7YG4Icacag9Dwt+Qez+Wp6PlFe/KjOZfmIaQ2WB26w3N5XCTJuRcICk4B+r111fJgSkm12QBdW8fzc+fbceeu4Xo77DTNAZ0avy2SBfdyJQxgPYZhErmfBxrjqgsS9hrbNbA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3179.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:11e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Sun, 15 Nov
 2026 14:14:31 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.003; Sun, 15 Nov 2026
 14:14:31 +0000
Message-ID: <1690feb7-cb3c-4e1a-9b35-0a564dc3ee9d@siemens.com>
Date: Sun, 15 Nov 2026 15:14:31 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] arm64: dovetail: Multiplex IPI_KGDB_ROUNDUP via
 SGI0
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
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
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3179:EE_
X-MS-Office365-Filtering-Correlation-Id: d742e8fd-84ae-4050-35b4-08df4322c4bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aNWMDEorgHgh1nrbez5bqhpiCLApWfy0RMzSQR0oVlH95fK3jM1vIw0NYL7DxN3RU3VPmOZSp+kFvbBuxpX1XHmnEUsnMHCw7qyiPt7y/hOVTshyW6vGRF3xcNcw70+uh9G8jowRQbeOQ7cJWiBC0ZoswROzVba0gXaPjL5gPaj7KA06QFxofz1XA+v6fG5Hl8HzUFIcp8oqjh6nboG4VRIbknrUZyu73fjHV31LLQX51AvfncCMP/0IV9GB4IZSsRNLp+YAOxe7EuDa8ahujzGrSNhtA0hCAWZUe6tVor5OIgzFrZhQgqEtdqRvkCuU1RCDR9/nb5CvZUOPm295iqoLtdfvB7dSVU1FcEQonXWSkTb7IttamZoeYC5hJsStRUGzX+3lXPij7odA2QQc7FlK8XJBkdoK0nM2xr8LYHXxBEuF4mBeZNkEON6/3CaVxtiuL2QqhnH+Ei6V773En7sGAIaoiXKgtPGtNTB8ls19sR3+37wjh6zq9xGs+o3YNmwOV+tfx7HMGRW4Hl0M7XScKCscZ7xRW3QdaD3J9UE1Y+PUIs5T05KHkN5dfRt10d/l01QbZ0fsP7FW/kbpTV8SzM0CYxYBNzBHXhVtxS8cbL06KGeFeq1fKj/pky5zhtbVBwVFqzOr47Tdjwe6xFVWe6bN9O0088Fwq+aJMh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bklJTmE3a1pMQ0FMbXBqcFo1T2JONDhSQVdUQ1dvZDg0d2ZpWWV0VjFyanZF?=
 =?utf-8?B?VEtYbXBnWmJYQ29pc0laVlcvcVJKOUN2bzh2TzdGRHVpdi9ZalRNR0VWVVFS?=
 =?utf-8?B?NHZya3QxR0J0YVRuYWU3eDJheU1SQ1hMR3JnSG01dFNXaGJKQ2htaW44aURl?=
 =?utf-8?B?WHp4ZzhSUEpWZnVlWElPNDBKeW1hUUMrNCtDM2VhNmxuaGtYMzdTWFhMRnFm?=
 =?utf-8?B?Mjg0UlNMejF5ck9ITi93ZU1jNVFvemRWZFIyTFhOKzg3T25vNnJjd0dSL1g4?=
 =?utf-8?B?bUdtTWd5dUMvMDF5dWdwTWJ5L1FLYStSUDAxelljcjc3WGtadjE4d1dhUTZy?=
 =?utf-8?B?djlqKzNTNEVtVC91OHBNbC9iZDBDNEVsQWZJL2JleHdnbzVNSTZhUVNSZEpD?=
 =?utf-8?B?LzFmYWxkZEtzc2FuMEJxOXlJU0wvQU04R2EwTTQ4S21pRURFc05JSnM1eko1?=
 =?utf-8?B?ZXY3cmlrNmk5MUo1cmZlSFRnZUhEZFpTZ3V5Y0x1VFhtVUw0TnRzT3p2dGlE?=
 =?utf-8?B?R3BKMURNWFFnQzZRMFNPY3BWeG1yWHkwVDY2dkpQVXd5MnYzdHZIRUJqSVp5?=
 =?utf-8?B?azJXdjJMT0Ntd0RJb3ZKdm1kRUpGcTR6UDFwZDRISTM1MzU0ZEFHTmxxajFm?=
 =?utf-8?B?VlhrSWRCVmlOZjFMMGYvYUQvL3hQbHpCSkJzMG1kdDdNUStKRGl2QU5lM1VV?=
 =?utf-8?B?ZGc3d1kxLytkVFpFcm96S25tTVVJWUdnSVVrVHE4T1RuWW9HNEdjQVFVcS9o?=
 =?utf-8?B?ckZ2amRZblVvczdNdzBqL1ExWi9XcGY3MHkwd2M5Y3RxR2h2SnF0K3RWWmYw?=
 =?utf-8?B?YThzdFhWMnROc1ZMOW54MndFV1VicHQrVlZRckFvRFljdXJYeDk0emJGNklG?=
 =?utf-8?B?Yk1vd2dodEZOOHV0cXVqeXllMWk2OTRiWEdHdUVDOGovWHdEUHRQeHJ1OXg0?=
 =?utf-8?B?OEltN1FISGJZUnlOT2VRd2pnZ05LVmY0Zi8yNXpHU1BKVmlJNnAvZTFWdWZ3?=
 =?utf-8?B?NTZlMGdhYVYwSVJEdGVlTjYyVFR6aFNNbnh5S0VoZTFJUGcrZlJNcGg0eFh4?=
 =?utf-8?B?L0h5cUcxNmdRMVF4V3dCQVJ2MkZPWWVNNm5ubUo0dEpQWWo5TEduaWVIYVpK?=
 =?utf-8?B?aXowSUx4QmJaTWNIK2FuR3l0dWZIaEl6YTFpZHZTNTJuMVNMQnlWMDZmQkMy?=
 =?utf-8?B?bE5udmNwSW9odjB3N3VUdXNRdkpOZjB4QWFJYjgvQTB0dDNpanB1VmQ2ZUVW?=
 =?utf-8?B?Y2I5eGdsRWpMQVNXMUlaNGRxYjUvUGlHZzRYVmlicUVWaTRNd0h3M1VRT05X?=
 =?utf-8?B?SWExZ3UvU0N0SldCMWJpVlk3T0NzRFpla3EyOUt4S2d2K0dCWEg0REpDL1lT?=
 =?utf-8?B?Z3BPVUJ1YTl6WHRjL3dVZndMV2ZTMWU5Ujg5N2Izd245VDI3czUzdzJuOHBk?=
 =?utf-8?B?VlpSUFN4aVlIazFEekNlc1NxajNJcGtvMkFDUWJhUUFCaUxjOVNWWmVWb04x?=
 =?utf-8?B?UlR5VWE0VGlaN0xwa1hoODdEbGlwZFE3Z0g4RnZsazBTbzhJSHBNRlk2TUFE?=
 =?utf-8?B?L29MZTBWV1NDRWhiSGJlNHZtY29xUmFvS0N0ZkpDNDI3RjRkTDF1cmxlVVlP?=
 =?utf-8?B?V2srZEVmVHE1WDI0U0dZUXVnbzNvaXBLbDlSYlV2bGkrUmlXckR1aUMwaGk1?=
 =?utf-8?B?Q1JiY2ZxaUQ3aUUxVkxRQ2RuMzR2Y1FNSWx2SzBhN2c2Q3NJVU1aTkRUNXNk?=
 =?utf-8?B?dlJxK3RaK09JUVR0aWFXelZPNjMvbVFPOUZiejYyVGkrVjZLUU5CWXNFZmZ1?=
 =?utf-8?B?dGhEWWpXY3JDbWhLVkwvb2VlMzZVWXZPK21pbUtRRjJQTUVwRGsyZmZOOGJL?=
 =?utf-8?B?V09acHNZaW0zZ2NJNVhRTXgrTndZSmxyWkRiY1h1dE5vWnAzd1VaMCs5aHR6?=
 =?utf-8?B?RXdFNW9yRUxvNUdOQk04N00rM1c1WmNkUEZ4dUNHZjB5dVJMVXp3N28zd0dY?=
 =?utf-8?B?ZExGVFJGcU9wclp1WVV4djJ0c3huMC9JWjcybVhhUDY5dTdvVlgyalAzaUd5?=
 =?utf-8?B?MGtKMGljUUtZYTJ1bngrV24wNXZWZUg1VTJxRFl3S3o1cnQ5RnVRM04wbUcv?=
 =?utf-8?B?TlVnUFVvR2NhWnlkRGNmWmFQbGx6ckROR2J0dHk2R2FOUG5UN0xvekJnWjFR?=
 =?utf-8?B?S001R0VBeFJ6bHZOU1VUN0ZlZS9zWEpPRWNHQjRkMk4vVGwyUXplQmdKaTRC?=
 =?utf-8?B?MDBReUZidGFxZjF4bER5YTVEMlREUVFTR1dOR2JsZmI1elMxRnNheWRyMEJW?=
 =?utf-8?B?RDdtSTAwU3JZZkh0aUZFVFhQYmhvaEJ0QmhBaXFpZ2RnOEd2ZERtUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d742e8fd-84ae-4050-35b4-08df4322c4bb
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 14:14:31.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCUDp0Qwq35tH8Vbmemxda46FVuhNXep4nmObG3xB3hozVJXLBSFAl80+ymCehFORcInLtGGBQdc8yDfdaadyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3179

From: Jan Kiszka <jan.kiszka@siemens.com>

We still model KGDB as inband service, thus have to multiplex its IPI
accordingly as well.

Reported-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ceb9840c35eec..be6b428e91e48 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -987,6 +987,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 void kgdb_roundup_cpus(void)
 {
 	int this_cpu = raw_smp_processor_id();
+	struct ipi_index ipi;
 	int cpu;
 
 	for_each_online_cpu(cpu) {
@@ -994,7 +995,8 @@ void kgdb_roundup_cpus(void)
 		if (cpu == this_cpu)
 			continue;
 
-		__ipi_send_single(get_ipi_desc(cpu, IPI_KGDB_ROUNDUP), cpu);
+		ipi = mkipi_inband(IPI_KGDB_ROUNDUP, cpumask_of(cpu));
+		__ipi_send_single(get_ipi_desc(cpu, ipi.sgi), cpu);
 	}
 }
 #endif
-- 
2.47.3
