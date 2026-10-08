Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C249AA38
	for <xenomai@lists.linux.dev>; Thu,  8 Oct 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462792; cv=fail; b=kS21lM8Wz/Bc8CCLKqS20P0aE8cV6xDBgbK2ZJTWR1Tey/7hk++YKqVc9l8Gc2tIyuP1s0d7t+L8rrjw0q4EAaipeIcm/menWn/jNQuDI01Hwdy6kr01W0+embW4jFEm4nK/p7RPNMk02No4nibaiF/pqwI5chqTHnYRs8ZGwTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462792; c=relaxed/simple;
	bh=diCk5fVtRiObqwQ9ssEYgj5J9BSIwPx5EXMrUYj+Siw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IGdT4ala7ugFQMXrsVzUj4oAioCGPXMChIQFMMwoZHwzjO37ffxrzTQPBFoCpHzq472HV1EbNONuN8B/P1fc2D7gk9RuS+YSnuQHmVcrHfXxOkb6/RRNu7HdubHMsGuYsY92bkjXecUvUlFesxiePmwlZxioUD558LWZR/oSPIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=o0duzOy5; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o0duzOy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3U98D6P42JlePzcFvKjpv3Z+lGJoqR/oBolFsGm/BJ56sj7jtGHpq2CVd+VojEoWguaI21mLuijxPe1Tne40yUgN2PynPRHddalHAg1nLyjqz9Q5TK3CBJz+S/Pt+vtBxjFICnP9HRsubEFN77eL53HuJnzhW/X/59kXSKd+4W2OyYZ3pjC4tHbBGOr9mvdQ/camTqpETZykWTgJ+nLBYX90i/EXQGxDV47nRr5jm7+dmR27yNSV/t0NTHw4TXoIoDeH/GE8Zyhx4Lhu9Fu2gJNROMQ5ZfmI1ZCGsEahULOsVmG0lrAngxkYyj70nn0vrSxKJ5A3aEzXoQaSBczxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCjmvfex4WdDq0b4jxpcxtbUWqtANkypVxBjnS6jeMc=;
 b=TT1KpWdaZQ3zhmfI6b1cO+Ol0AERHXKPNH/6fO+7L7ga4h0Jv6QVp7XxDlWn0cub6n8JA1c7ks8oo4DMVrVcFU8UuPnWYOEW/rgmnmmXxOafvl+RotTvh/u3oykD4L2nFyPzZszQ4r4Z1VVEIGe0AiQybqik387pctAGfDRZnLBFqzrC4VYZrhSqIXLXuGN4QBK8GW2pCn3MZH7M/BiXPiBi/w5pAAUDRvPvUbN3FO5DZDUkrSfhajZdZq4eUnJs2s/WAoszFmmJWfxv3d7DK4YR9dVhR/KwvKBwqYRMDf39yGrm9TdYQbFC7uWs6OabnvW8ZDgQ80MQV4QKGDpKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCjmvfex4WdDq0b4jxpcxtbUWqtANkypVxBjnS6jeMc=;
 b=o0duzOy5sOvAVZ50SOS6jBz3sGwZzZvmqCh0Eokd0td3GHpJo9y6klzxQhHjZbeBoLl3bmA+oOZwovs6isSbR8wFclQqIPb2jEiohiQF7kU4YnpME4yl5DaW7w3CBqpk+SHT9CyxgQ1yFZGf3dYItD1XBoyxDYTVkGAdH4TCTpm/zh1kUNauSWC4HpzVfEXLZaHtqC5NAG8QOT2eMrPYfnwar3hYO6pZUh4iPp03tFJ5ZY1aOayavhOcongSHrhOAuciFjy+BNWaU9Qon91HW70K3pfG9OG9npx9RP5DusKfpL4wIAtGIyMzuPrByVZrGSa1DpaYTCxGG3SveIj+Lg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB9101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:44f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 12:33:04 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:33:04 +0000
Message-ID: <c67f0cec-7fb4-4600-8652-b501b56891a8@siemens.com>
Date: Thu, 8 Oct 2026 14:33:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] fixed missing time64 wrappers
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>,
 xenomai@lists.linux.dev, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <1208-6ac76700-4b-2c92e940@166990483>
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
In-Reply-To: <1208-6ac76700-4b-2c92e940@166990483>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6128c3-7bb8-4b66-9d18-08df25384cb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|55112099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vQceLJr84rvgru79DBNsCi3CvP1AA+1oNLDEweKmrerqDP7a4lsWJxhLxQiH3ooTAtru0qVZbrRuLn026R9zHYAcvNILLXK3s4wBCx0jCwMdJEmgy/U3ZG5ZvTA8GS7VUD4ReL1h9pK1hxuyZMysg2btdiZK2MUn4Wpxu48xVg8ghG+yKTcaWcJvg6R7qteI6tNBmW8vYyYHB37GI7y9P7fsikoTt9a7W8ko2uAPFEwLR/i/UCMhE0eiHCsmvGDZ4CLrPJQ0xao4KAb1wZToO98TytU6lPHBiAIIMA8IWF6d07h7wx0sfE5SN6sFJHF0YzV0hBMQDob8I9ipVQHBFy9JYTJa1zcojWLwX9jRKnQEoc+EL6BS5M0bJBrFZ0WJRI6zmiLbCXnfM5wjgVPHtO4l6IDJFqn/i6tNEVDVPJT5tcVd8u5FqISy5g7Vy9aFEGzczlea8rDv19Xv5x3p8//L6YvZANZ5AVXj/KMjo38aoumsBpmYXKtkQYaD2+pv08nu52hKrDNs4u//Z07rElp8jTfm3pXvxzePYnxcZQUz+jzwmrdaUUnL8hCH+TxmXsYTIFlTlqhYbrcTu/z//cfrXy8xe0SJGaeYdyyGRc6GZ7dL0trnLE+nTsdJTVhHrGDXy8mq7TI9Bg7tTLtxSlLqDkMTMOk2jR0hmBI33Io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(55112099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXJMOTYxeEd1Y29MenQ5bGVtWWw4WTNtc2ZleEh0Si8yTURDc3ZSSWlIOEV3?=
 =?utf-8?B?Wk9QejI2eUUyb0NZQ3RyQjJYRldzZStETllJMlBFMWxWNnVpNWtYNHo3L3hV?=
 =?utf-8?B?UkIxd3lWS1lTV3FEeHl4Z1NuSTVqc2NYTjE1NldLR1pDcFd1aFBPd1lqcCs4?=
 =?utf-8?B?eWRwSlVHQW9ZVnFXQ21TVHpqNGNBOFZhaFU2bkVQTURFVVAzb2NSd3REZHlk?=
 =?utf-8?B?ZVEzanVvVEhxVk5sNTFzc1BMc3BhZU5zUm5EWjBFalhwWmd2LzhIenEwbGJD?=
 =?utf-8?B?VS8xN1FVdzhsV051TmMwRFB1ODNOYW1NV1laYkc1WXhURXpMcDlZVTlWZDVL?=
 =?utf-8?B?ZkUzOUUzVDZLeDFwMWpGcEEyQXJvWXYxcHJtVnN1UmF3d3dQQXlQZC9RcnZV?=
 =?utf-8?B?R3lZekJFZ3JiRWI1K0ZGMUNBYUw1bnEzWUZNLzBpbjArZVJRcDYwbzd2L2VU?=
 =?utf-8?B?MHQycEo0T0tzWDNNTEdhNW5JTVJVRWtEcEpRNjVaVS9PbmsvQlVhVkFEQzlZ?=
 =?utf-8?B?UVA4SDZabU41d1pVTlpPZzN1VTlPSS9TNEY0cUptL3RXeUkzOVJxYmRvdEZh?=
 =?utf-8?B?UmJ4TTVCelZDQ2M0bHN2Z3JJV3BtZ2RpYzZhRUNPQ2h1QnVJVGhxb0hkUWh0?=
 =?utf-8?B?cVNoWUJCTWVlUGZiODV2aXhzYkhuamxwSGxDZkV3L0JaNG1xcFRBcVQ4dGU5?=
 =?utf-8?B?aUQ2ZkhOMmlhUERBdHVmb3puZE5iZUtzMkVnTnUvbmEzL1JVbEJ5ZW5tbkpX?=
 =?utf-8?B?T3Y5Vzg5YmVCYU1Nb21DRzV0Z1M4SDRqbWxPeDNsRjMwRlF5VmNEbk9ub1JK?=
 =?utf-8?B?Z1gxdyt5TVhJSk9xRGVia3JLNjZ1VTJyL3o0b0U1ajJWM0pHbjdPNG11bDBG?=
 =?utf-8?B?d2w5WXJIKzlYUGcwNW5vbWhrSlFFL3NtTlo1dGpSSGpGc2NjclpPdGc2NDdE?=
 =?utf-8?B?L0VoNTVlWmM5WWh2cTE2NzUxUGg0UXV0cmRLNXg4N05FVHpDbi9qaE1sbEJt?=
 =?utf-8?B?Wmt2Lzg5cmhPcWdoLzB4c3pISk9FWDVnQUxkYzVNaFJqb1ZJTTQrRGphemV0?=
 =?utf-8?B?K2E3V1dEOUIvdnprcEVha3RUa1FTdC9wNWN0ZGtWZVVFZnFGREVaUm5sLzB2?=
 =?utf-8?B?YWsrT2IvemtwWTloaDVTckE0Y0VvVlZWbWhseVZRbm9mWXBkaENzeU1LMUhX?=
 =?utf-8?B?MjE1OUI2dDlNVS9WWFN3b0twNVFvdTFPSmg3MkJGS3l1UEpObURLNGRpNGdQ?=
 =?utf-8?B?S1h5TE5BREk4V1p5b0p6MUwydzh5R0psK0hBMEpTZFJVS2R6UXdOVjkvaGFm?=
 =?utf-8?B?UVRGZVRnVmh4TXVoYlJOWU9CckxpUzhmWEptTitUbitMN2pQM3VKdTYvMlBq?=
 =?utf-8?B?UzJkS2ZidW55bFIwUlhCYlpCS1hwQUtWc0Q0RkVoYm1Ta0hPVitWRTVGdERp?=
 =?utf-8?B?ZjJ0QkcxMTRVb3NSOXlUelM4M0psSWY0T0l6MW9uWlZWLzdPOXBHMmFZRmlN?=
 =?utf-8?B?aDV5WGhabldIZ1JBZ1RQOFFOMEdQK25FN1MrY1NkWWNUU2prN2FRR3dpZ3NR?=
 =?utf-8?B?cmZWV0ZUYVJOUlUzQzVpSm0vSkFaV25hZU9QMnAweHJ0bmFLcDhxcUp3eFhP?=
 =?utf-8?B?TVRHS3IyN2k0ZnNNVFRseC9rRGZZbmE5SE92eUhFNEJYMTJabXJoemJZOW42?=
 =?utf-8?B?SjBCMkR3VTA2TGFtM2NPYTNSUDFXNlFVTjVNZlF0bDlyekQwbmFNYnNYTXpX?=
 =?utf-8?B?QU5mTGtPRGZTU2ZZMHEzTnFQYmZiT2Z0NDFUQ240Q3Fuam91allnd1B2dVBk?=
 =?utf-8?B?VktienBBQlJuaElHZE12a25KM3hPNUtpbmxOTzFpNnJkNTl6OXEva25LM0oy?=
 =?utf-8?B?OUFhNXE2VFlKd25IMk5tRzdSTllzL1lVdXFjTlpUSlBlNE1vdWVDZGdYS0Ft?=
 =?utf-8?B?alVlcHhHS3JFcHVzUXc1ck1zdElCby9UZ1o5dVJUd0xlbUxvaDBHdkljYzhE?=
 =?utf-8?B?K3c0QTdoYjBSeE1qYjlVK2g0QlE3ZmRoaGxaZkxXYmxYRjhtTU1jQSs5RGNO?=
 =?utf-8?B?dDQ2WVR4RzY3cksrQjNRZ0tzRWVvS1h3L1FPWkhQVno5TXY2Ui8ybkpSdDAx?=
 =?utf-8?B?WFd0Z2NRNU1nS0o5Vk4vL3UyeXFDQzVTRFp5VU1BS0Q2NXVGS0tpQzArUVRn?=
 =?utf-8?B?cHl0WldzTTgvVnN4czFXU2NZNFlYTUcrWUhQS2dZVTlRaXlTY1pBQ05va2l1?=
 =?utf-8?B?UkJITkxhN0N4ZS9aVXhXNzRoODErbzhLMlRDTzdqSjhmKzJwMHA4M1BwbHJw?=
 =?utf-8?B?Zi80a3hDSnlYU1gxRTVlNkZoSzVXYUtDeVNXZlRYWXJPeWdET3N1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6128c3-7bb8-4b66-9d18-08df25384cb1
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 12:33:04.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1El5uDLIg2ZZr/QG82WXHuqiScaHymji8L06lyQpb6nRpKRc+T08gDj6s7+xlZXHaHQmlXXtD+TEZBO9PdzuRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9101

On 08.10.26 11:48, François Legal wrote:
> There are missing wrappers for 64 bits time in xenomai 3.3 :
> - __recvmsg64
> - __sendmsg64
> - __sendmmsg64
> 

Hmm, where do these functions carry a timeout? I thought they only do
implicitly, set upfront via socket options? But maybe is still too early
for me today.

Jan

> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> ---
> diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt/cobalt-glibc-time64.wrappers
> index 0bf895ca9..483a8ce24 100644
> --- a/lib/cobalt/cobalt-glibc-time64.wrappers
> +++ b/lib/cobalt/cobalt-glibc-time64.wrappers
> @@ -8,7 +8,10 @@
>  --wrap __mq_timedsend_time64
>  --wrap __mq_timedreceive_time64
>  --wrap __sigtimedwait64
> +--wrap __recvmsg64
>  --wrap __recvmmsg64
> +--wrap __sendmsg64
> +--wrap __sendmmsg64
>  --wrap __pthread_cond_timedwait64
>  --wrap __timer_settime64
>  --wrap __timer_gettime64
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 00c1aaf4b..264de8ace 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -254,7 +254,7 @@ static ssize_t do_recvmsg(int fd, struct msghdr *msg, int flags)
>  	return ret;
>  }
>  
> -COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
> +COBALT_IMPL_TIME64(ssize_t, recvmsg, __recvmsg64, (int fd, struct msghdr *msg, int flags))
>  {
>  	int ret;
>  
> @@ -301,7 +301,7 @@ static ssize_t do_sendmsg(int fd, const struct msghdr *msg, int flags)
>  	return ret;
>  }
>  
> -COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags))
> +COBALT_IMPL_TIME64(ssize_t, sendmsg, __sendmsg64, (int fd, const struct msghdr *msg, int flags))
>  {
>  	int ret;
>  
> @@ -312,7 +312,7 @@ COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags))
>  	return __STD(sendmsg(fd, msg, flags));
>  }
>  
> -COBALT_IMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
> +COBALT_IMPL_TIME64(int, sendmmsg, sendmmsg64, (int fd, struct mmsghdr *msgvec,
>  			    unsigned int vlen, unsigned int flags))
>  {
>  	int ret, oldtype;
> 
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
