Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D59276028
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598319; cv=fail; b=lBp3/K7eGOF2MBb+nWwQRZeQkLDnGzMLVqxSSyq8iShRuiGpru+04AZRBtW7XIvGIlwjj3fW3fLNQLiE7xI6eXu+cld136+IsZK6r+CBYjXS6dwRFmFHZSZB3pclle1/leGNc3vSRX9yqCuEkYYoO8j19/y9+PsFoIECLbfrgAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598319; c=relaxed/simple;
	bh=aKAWygyA3lHWjbTfVb+FGAygdIOaG5804kiCpuT0wJ0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C17fQi06XEVydj1eQ7w7gCOw+H3BF559k9HhXXTnLEMO/P9/Z0MaS5NMd9RC4ANfmKTt4bq7LNpxB4zSnIugV9/3Rc2DWaR8ie+h5EDSlNXe49z533k2V1ZJBlhGiJG8RizxM4o+/FFacGQep9Osh4ap01HsGaaYFMg/YdUcT3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dke7VSyX; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dke7VSyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS61mj7rkTR4NEZVq/05jD2ffPCKOPrOq03ipY44BwAdvjIV9n/2kNi3AVknTbAbVFqmhAixG9fJyDkgkRzSSWnh06I+RjWZgj9Z2OuNJd1sn6H/gvbjgXNQZB2rMJ0eBzNmcfKblbPQU5gmOQDvv6qvD00VRKd1rRWagYXNfaQvyfD6iZuPYEQ1WMs1nnFczm8Fffhdns8PdPJWOw57/oMilwOCjPMdWii3wH5tzBjnqzREh4Qq206Urxna6F8xi9tmA6nXS/f+kco0zkVJIpjI4f0jlJ2U7wHfKKo7ZRDn0lAKdRzR2hO5VrkPPYbQorQ66+4vmd2u6n70J68DKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj6BWmut/3hiyGQBV/5vqhz9bMSDH+stefG8AndKO2g=;
 b=PBL9ic12VwtPMWImEgW+uvz1E71201xbFoG5CaCgSkpqMRNVvYx6X28JxolzCa751fM64+7Kwq1xv8BCiehAicom4pawUcaPhFN2Zsz8/l7WhuyH8+v2IFUt2fedXJeOd0OtDDgFoRnnk7B/SldJ6Q7A+49S8oS3ZqfGiNGqlsq2LS4Bv18lIWZTIn03m+W35oY52s7KVaHKqJYfAEgULrNhG9Ked7ptjrEhm9Mo6XwUPdyrCqzxBUZWqpk2RVFBLqoy+MH54HE5TXZqHdXJJasmQMT1mY5da7oKUtoGlMNhnwXCLP8W2LbgFa+0xOEELXNJtMy0gtYfCTdwVKhElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj6BWmut/3hiyGQBV/5vqhz9bMSDH+stefG8AndKO2g=;
 b=dke7VSyXpRHDBYIqARV6LP2fW1nMivjoGafmgjW1zgOjGk9xJkzwgmoG9GVNPMlPCRaj2+i2Ieniay6mbEvWRdudCeCVixGwTB53IEzfGiEEmLRwBKGwX6iijLvRncYQgHHb5mCTd/ZLeCiwtFPrM886ziG4e5AiSW2Bn5M59ezv3qb+bZ8nTnc7XTAQTmUNER5VvfpDZRXbp6y82Oe2OuZ4xPapKRKLSrLKRPUf+nxbWCrmVeKW1jFNO++Cs88NEktIbmlwF1y3x2iSrGHXs8bdCHrWr95hlf+/pXiWwVaA9DcBG9XFi/M8E9OBIuL6LEcDYf6vRNLplyYzdfR3uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:310::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 14:38:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 14:38:33 +0000
Message-ID: <e98cce6f-f488-4ff0-8034-4f09365032e5@siemens.com>
Date: Fri, 20 Feb 2026 15:38:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] lib/cobalt: select: Move select services into
 wrappers_time64.c
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
 <20260220-wip-flo-fix-time64-32bit-native-v1-12-731c773e72cc@siemens.com>
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
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-12-731c773e72cc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cc75d7-9041-4d66-3b34-08de708db939
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T25nbXkweEE5R0FzZ04yMWREUGdoODd5Z3NCWGRDbVhIOTFCY0ZEZGdndy96?=
 =?utf-8?B?dmlOOVNKQzR3c0M0bjNKc3JIVGMrM2R0RmJiUk9VaXBBdjcrd2JxSDFydVVi?=
 =?utf-8?B?U0hFVDh2cm1mdW5INkxnMW44M1Buei9Ickw4MWdZd2cwVjBHREc1MEZhaUNK?=
 =?utf-8?B?dlZOM2lpSjFibnlVVEQ0ZmlwUnNjT2ZhSlY4WmZkS2QwR3hkY1FVSWc1ODFi?=
 =?utf-8?B?OHlwLzhLUjRtdWJHOWJMNkxseHFvNEZlVEt1UVlpWms0My9qSWVobGpHYTZx?=
 =?utf-8?B?a3daTlYvNGtCQ3dwcFc2NjZnaTFzVG5kRHU1RE94dXo2SnZOVzZaNDZEbEV6?=
 =?utf-8?B?czZBQ2I0Vmd3N0hSdGVxZXdpY2FBVFFwUUtidE40c1o1TnFJMm9DTkxZVkJt?=
 =?utf-8?B?dUNHdzU0eVVYTXJQMFVONWpjMklRdlM1RnQrS2hIZmpOSFhjL3JReERTdG1r?=
 =?utf-8?B?aHhtUW9LbXBRUmZpQjhlb1pld2ZpL1lGSm1QaTFHQU1kcHFJUi81WTBVK1I3?=
 =?utf-8?B?THhHQmgzc0ZVODJsdmhmeldjaGpwdXJLZkw1TEYxbWgwZUVybEFsUndoOXk4?=
 =?utf-8?B?Y0R6bUllb250VEl3Zkg3Y0oyenlhSTNQTUR6MHZzZVBOVFRIamJhY0RuaTUr?=
 =?utf-8?B?ZGpzU2tJWStSeU85OFdLNjQySk5UTVpuY1UyYUVwTHpadVZFT0hYUGl5Q2d3?=
 =?utf-8?B?a0VVdGIyV3Y0V3NFZWZQRzNJbUJ5aTBSZDhWd1VMZ2JMdWpLSU94Y2VnTjE1?=
 =?utf-8?B?SS9hTExkV3EramwrYjJKR01rWTZOSDBXaGExTjVXSGhFUHFhK0FXRndpQXQ4?=
 =?utf-8?B?aWswWVJTM2ZyYVY5Y3N1MUM2UkVCOHJtRkR5NkZUS1dlNGJ4UTlLVHZwTXFS?=
 =?utf-8?B?Ync1TFRwQTdlTUJHd1JsSzRqVzI3RHpScVZ4S1JVRUE0R1hBQTY5YURrQWUw?=
 =?utf-8?B?d2hhZlJJTEN4dDRKdG5heW5MdkhNR3VEZXVJSFBhbmNGbHhZSXpEb21qNThB?=
 =?utf-8?B?N21MeFdrOTg1dVNJcldRSEc1OHJVSWRZcEdUc1FiQ3N4ZmxKTHh4cXNxK2t4?=
 =?utf-8?B?RFRvRXRvTE9LTkY4RkxxRm8wUXZCMFFmbnB0KzJzR0VjNGtZY0RRTjRoMEcx?=
 =?utf-8?B?SUp2MW1hUE5WcHlFSVF3REg3VFVVbGwzRGFEeVNiNDVkdzZwS1I3VDdWVERn?=
 =?utf-8?B?MkFQM0gxS01sU2JnSFZDbmlLY1JqWTFXcERBL3RnNEMzcno5dW81emtuRzZL?=
 =?utf-8?B?bTJwYi8wVjgxYStlMnVwN0VObGFFaHNRYk9DSENublZrTEJ5NEtkYlhjSGZx?=
 =?utf-8?B?MjRqYis1Y3V3Z2NrdXFCUVZWNXVHcU5SbEViZlF1MUUyaTRMeXRIRFg1RVVz?=
 =?utf-8?B?WlJ4WlVrN2tleTZLTzhPNHVuOVFkL3ZpS0VMN285ZEJON20zNHU1VE1JRjQ2?=
 =?utf-8?B?ZGhxRmptc0RMNHVYWWpKWXN2RWpvVmRPZW10UVRxQmxtWXdlU1MwZm9oMFda?=
 =?utf-8?B?eSsyTGRCUTZmV2hrYzhQTENvZG13SVdRcWdtQlNVZ1hnUnMyOG55N3Rzd1ZS?=
 =?utf-8?B?WjAyWmV1S1BmNk5kL2M5RzA2dExIQ0FQNVppVzI5YlQ5UzNCWWYzOGFyV1V3?=
 =?utf-8?B?eHl4cTB3WktGQnk5bU9jeHZIaE1XLzVjVzNsTVc3Yi9rQkNRU0FmdndKbUw1?=
 =?utf-8?B?VXgrank5REdwWXIxeWQ1NjIxa2NYQmprMDFiK2EyK1A3a3pRWW5aN0VZOFZW?=
 =?utf-8?B?TnRmaDkxNjg5UzJhY2VBemZCVGNMRzkrRU1LYWUyWUd2VHc2cXpwQlZHcHZu?=
 =?utf-8?B?U2t6SzF2ZlhlRS9ha2JLelh5WTJXUTRwNERQMFo2NUtMVk04cStsNWZUMXJR?=
 =?utf-8?B?QUVrUERvUFZhazd3dHF4ekJEMVYxaldEZ2YyYXV4RXZoWVRiWGZRUEM4ZkVr?=
 =?utf-8?B?UTBOWHllS2RtMkt2d2kzbjU2T3c3YXVxQjM4bnF2OUZKckRBQ05CdlpwdGk2?=
 =?utf-8?B?OUNWamdSRUZneVg5MkhjVVhaWmJzdVVtRzJ4QzJqUmpvcEprK1FYeHJtNmh5?=
 =?utf-8?B?QkU5S0JRelFEMUxwSVJRRVhSRE41ZTZ4QnIxNGlRRXRmejUyWWFlaHd3aXJG?=
 =?utf-8?Q?iuqo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXlkdGEydVlWc0I3RTFFQ0d2b2VlaktnVHFZSGdGY0ZFU0sxSEpoT1MzOE5L?=
 =?utf-8?B?OW5ETjRXOGduY3cvUUpheGFrcFgwczVGckdVVGF2WjAwSUdBeFQ5ZG52S3ZH?=
 =?utf-8?B?cW5KVWJTVm94TDZ2aHJnL25NcUJDcVQ3YkJwOTVaSmJlUHcwTlJUZEszenNO?=
 =?utf-8?B?Z3p2R0Joc2Ztdy9TSDdKZERaSkZaR21DZHk4L2pua0NSYi8yNVBtZktrQUFI?=
 =?utf-8?B?V1hJZXlnMjlWeHROcCtibUd2Z0VrUHF6VVVSa2I2em1GdUdPMVZUd0JESVNu?=
 =?utf-8?B?M1ppSFR5NjRBK3ppT3dxUDk2ZHFOUmZpeEZEQ1ZNUUl2ak5URnJMZldsejkz?=
 =?utf-8?B?dmxvRlZiNVo4ZnhHY0NtZ1FFTlJZNnJ2T3Z5SXpWQjdxV0tHMVJvY05nV2JZ?=
 =?utf-8?B?OEY3TFFwNWROdmlJRVlYd3BZRTJNNE5lNFNlNkJKLzQ4RjJvdTFqUXBvOTA3?=
 =?utf-8?B?Tkg3L25OMS85UmRIbC9UNEVtMjRhZ2J6b2kzODI2NXp4bEZ3b3VvaWRqSjRB?=
 =?utf-8?B?NXhycnFwbldWYzVCSUc4VThPWm0zT1JzOXB6azUzak1iU0E0Y0RzbUQ5ekM3?=
 =?utf-8?B?RGgzN0dON29pY3kyRjN2VGJld1ZJSVR6ZDVWd3AzV3FXc25nZURIUDBJRjlk?=
 =?utf-8?B?YWcxVU01MENUUHdlUFRCWDBBNDNCZVM4b3hjZFZoTGlabjFsZVV0Vnl6MzVN?=
 =?utf-8?B?OUUwaHhveXZxaXVoMjZoeVJUanhhSUlubTQvSkVyWEZwUkt0QVlIZ1Rza2pG?=
 =?utf-8?B?ZDhWL3JXcXVmSFp4dE5DZWNJWlRLd3hLVFJYbmF2Uk9wVVc3OE8ycTlQYjdO?=
 =?utf-8?B?amh5TjRKeWRIQ1BaTjl4V0orOGdSZnFEWm5hQklGNk1KL2dCWjM0ZEJyMjh4?=
 =?utf-8?B?M2dEUTZpSzZ3aTdlUmNZQUhtZjBVYU9Tbzl0RXdiUEczdlJTek8vYzZHV1Rx?=
 =?utf-8?B?TUNQTWI3engyc3pkTCtjdlkwZjk2ck5nTlpwQ3Yrb0ZZQTViYkt3YnREZ2dn?=
 =?utf-8?B?MXE3ZjBZUS9JcGY3TytuOWxkRzdSelYyeGU4ZWVvRUl5NmJhMzIrZXpDZUZG?=
 =?utf-8?B?MXBSb0xSdE1KNzhmVG5YSjBxdUpkNE1BMHBXWHMrQ1NQSyttc3dKcjU4c0Rj?=
 =?utf-8?B?Z25tOE1sZmlJM2I1NFBTZmQzNEZ5ODNXY3dzak1ITXAxbDI4NW56YXE3a2Vh?=
 =?utf-8?B?eDFlR0xUT0V3eXRxMTJsYlhxVndlNU03bEtPQWlxbjlOVkpEL0RIN2NpcFAy?=
 =?utf-8?B?SzlqMDRZQkY5TGNLaG9hMnZMY05oRmQ5dXJFQTBFK1VnUFExQnQ1NmU3ZTZW?=
 =?utf-8?B?alZ6QVYxdERJODNaSUZjWE9XM3FNK2NMZDlINDJUSXM4Szg0OW9RMVFVQmFG?=
 =?utf-8?B?R3hwcnRWKzdOVWlKOEV5NEJpNjhqK0xjSWI4MGhhN0xjZGExRGlEeHlZdThN?=
 =?utf-8?B?aElPeXVXQWtoTG5mVXNFaWwwRVR1emVWRm9UVnJiYTlEQTFLWVVHMWdmV3Nv?=
 =?utf-8?B?SzlPdHNoNVduZGdFYUNrMGw0Q1kxc0tBaEQ0eFpoWk5Cei82S2hlQThSRnNU?=
 =?utf-8?B?UTFuM3prZWUrbkFlMnBRMktVMVlYYkswMHpKREZpejF4R3hkemlsVk1QR0ph?=
 =?utf-8?B?UVg4VnVkcTlTb2xPek5mdjNiWURJNUZEUWFHd0M4VVV1cXNXaW9HNUwvQVhq?=
 =?utf-8?B?SUs2cXFPNStXZzlqWFlGNEZ1dEVDUjRxdVRpdkswbU84R2NRNmFFbEJ6WkMx?=
 =?utf-8?B?a05STGlnYXIwNS9PcFh3N29EbjNZSnNkeWN0L2J3R0FOUXVlcHpzVmdtYkIr?=
 =?utf-8?B?RW9QTUpxb2VYUlFKRHptOWdYNHN4d2hPR0ZoWWFKRjdGQkxtdlJpd1dSM3B0?=
 =?utf-8?B?aitpcXJISTF2OSt1by9WTlNzNVM5WTNxU2hzVk9uVlIvajAva28vOHBpKzZi?=
 =?utf-8?B?dTBFZU9ET0FVMVIreFVnc2NzN3llekRUbHIwWWRPaXpGNVRRb1d0Z1hPa3ht?=
 =?utf-8?B?dlFLQVkzTGNGN3NSQUxTbUxKN2ZUQkQwWEVaQXg0Y1A1OXVEUFhYRXppSm05?=
 =?utf-8?B?QlhGUFBtYzVBWEJhc0svaVJHRm1aLzJFYnJNaHAxY2J6TnhjLy9WQXRuSEpZ?=
 =?utf-8?B?ZU5SWkxNVEN5KytkY2VBSDVJSnN5ak1wQkp0Z3JIUXdIL0VlUGhxU01VQjNr?=
 =?utf-8?B?VHN2N2xNdUlhakw0Y25OTzNIZ0FRSjRyS1M1cXlBaFlWakUxa1dqV3h2bUND?=
 =?utf-8?B?dFp3dVpRSm1zWUUrQjBKVjJPcVZlOWFyUGUydDREdE1aZXVDZm93dXdWV0NH?=
 =?utf-8?B?SDJSMHFlTzBsWUZMZjJXTjl0Q3FFb2lYaW5QYmNGRExlVVlYNjJTUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cc75d7-9041-4d66-3b34-08de708db939
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 14:38:33.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc4C52jdIf8nRdU2Bt8SSbIclVQEkzoQUzgid0N+5aL/dKq/JJqPrq6jtVsLvSfWDK63hn32PXMzabiBSHXa/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9606

On 20.02.26 10:08, Florian Bezdeka wrote:
> select.c is no longer needed as everything inside is time64_t affected.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/cobalt/Makefile.am       |   1 -
>  lib/cobalt/select.c          | 108 -------------------------------------------
>  lib/cobalt/wrappers_time64.c |  86 ++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 109 deletions(-)
> 
> diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
> index 17e203f9015fe2bb5306609e4d51c62f3a725780..c31f030117dfc3ddf5ae386897fbc8a2435912a8 100644
> --- a/lib/cobalt/Makefile.am
> +++ b/lib/cobalt/Makefile.am
> @@ -33,7 +33,6 @@ libcobalt_la_SOURCES =		\
>  	printf.c		\
>  	rtdm.c			\
>  	sched.c			\
> -	select.c		\
>  	semaphore.c		\
>  	signal.c		\
>  	sigshadow.c		\
> diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> deleted file mode 100644
> index 5472e991e126c2f521b346a7cf3c884bbf6f6317..0000000000000000000000000000000000000000
> --- a/lib/cobalt/select.c
> +++ /dev/null
> @@ -1,108 +0,0 @@
> -/*
> - * Copyright (C) 2010 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Make sure to not lose copyright notices...

Jan

> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> -
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
> - */
> -
> -#include <errno.h>
> -#include <pthread.h>
> -#include <sys/select.h>
> -#include <asm/xenomai/syscall.h>
> -
> -#if __USE_TIME_BITS64 && __TIMESIZE == 32
> -
> -#define USEC_PER_SEC	1000000L
> -#define NSEC_PER_USEC	1000L
> -
> -/*
> - * The time64 wrapper for select() is a little different:
> - * There is no y2038 safe syscall for select() itself, but we have pselect()
> - * without signal support.
> - */
> -static inline int do_select(int __nfds, fd_set *__restrict __readfds,
> -			      fd_set *__restrict __writefds,
> -			      fd_set *__restrict __exceptfds,
> -			      struct timeval *__restrict __timeout)
> -{
> -	struct timespec to;
> -	int err, oldtype;
> -
> -	if (__timeout) {
> -		to.tv_sec =
> -			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);
> -		to.tv_nsec =
> -			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
> -	}
> -
> -	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> -
> -	/*
> -	 * Note: No sigmask here, we already reached the limit of 5
> -	 * syscall parameters
> -	 */
> -	err = XENOMAI_SYSCALL5(sc_cobalt_pselect64, __nfds, __readfds,
> -			       __writefds, __exceptfds, __timeout ? &to : NULL);
> -
> -	pthread_setcanceltype(oldtype, NULL);
> -
> -	if (err == -EADV || err == -EPERM || err == -ENOSYS) {
> -		err = __STD(__select64(__nfds, __readfds, __writefds,
> -				       __exceptfds, __timeout));
> -	} else if (__timeout) {
> -		__timeout->tv_sec = to.tv_sec;
> -		__timeout->tv_usec = to.tv_nsec / 1000;
> -	}
> -
> -	if (err >= 0)
> -		return err;
> -
> -	errno = -err;
> -	return -1;
> -}
> -#else
> -static inline int do_select(int __nfds, fd_set *__restrict __readfds,
> -			    fd_set *__restrict __writefds,
> -			    fd_set *__restrict __exceptfds,
> -			    struct timeval *__restrict __timeout)
> -{
> -	int err, oldtype;
> -
> -	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> -
> -	err = XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,
> -			       __readfds, __writefds, __exceptfds, __timeout);
> -
> -	pthread_setcanceltype(oldtype, NULL);
> -
> -	if (err == -EADV || err == -EPERM || err == -ENOSYS)
> -		return __STD(select(__nfds, __readfds,
> -				    __writefds, __exceptfds, __timeout));
> -
> -	if (err >= 0)
> -		return err;
> -
> -	errno = -err;
> -	return -1;
> -}
> -#endif
> -
> -COBALT_IMPL_TIME64(int, select, __select64,
> -		   (int __nfds, fd_set *__restrict __readfds,
> -		    fd_set *__restrict __writefds,
> -		    fd_set *__restrict __exceptfds,
> -		    struct timeval *__restrict __timeout))
> -{
> -	return do_select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
> -}
> diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
> index ded0232824fade9b2f656c03ac3e5515fb5f8b38..7b634976eb07d7ae143b4567983dbea7f4ddebea 100644
> --- a/lib/cobalt/wrappers_time64.c
> +++ b/lib/cobalt/wrappers_time64.c
> @@ -754,3 +754,89 @@ COBALT_IMPL_TIME64(int, setsockopt, __setsockopt64,
>  
>  	return __STD(setsockopt(fd, level, optname, optval, optlen));
>  }
> +
> +#if __USE_TIME_BITS64 && __TIMESIZE == 32
> +
> +#define USEC_PER_SEC	1000000L
> +#define NSEC_PER_USEC	1000L
> +
> +/*
> + * The time64 wrapper for select() is a little different:
> + * There is no y2038 safe syscall for select() itself, but we have pselect()
> + * without signal support.
> + */
> +static inline int do_select(int __nfds, fd_set *__restrict __readfds,
> +			      fd_set *__restrict __writefds,
> +			      fd_set *__restrict __exceptfds,
> +			      struct timeval *__restrict __timeout)
> +{
> +	struct timespec to;
> +	int err, oldtype;
> +
> +	if (__timeout) {
> +		to.tv_sec =
> +			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);
> +		to.tv_nsec =
> +			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
> +	}
> +
> +	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> +
> +	/*
> +	 * Note: No sigmask here, we already reached the limit of 5
> +	 * syscall parameters
> +	 */
> +	err = XENOMAI_SYSCALL5(sc_cobalt_pselect64, __nfds, __readfds,
> +			       __writefds, __exceptfds, __timeout ? &to : NULL);
> +
> +	pthread_setcanceltype(oldtype, NULL);
> +
> +	if (err == -EADV || err == -EPERM || err == -ENOSYS) {
> +		err = __STD(__select64(__nfds, __readfds, __writefds,
> +				       __exceptfds, __timeout));
> +	} else if (__timeout) {
> +		__timeout->tv_sec = to.tv_sec;
> +		__timeout->tv_usec = to.tv_nsec / 1000;
> +	}
> +
> +	if (err >= 0)
> +		return err;
> +
> +	errno = -err;
> +	return -1;
> +}
> +#else
> +static inline int do_select(int __nfds, fd_set *__restrict __readfds,
> +			    fd_set *__restrict __writefds,
> +			    fd_set *__restrict __exceptfds,
> +			    struct timeval *__restrict __timeout)
> +{
> +	int err, oldtype;
> +
> +	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> +
> +	err = XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,
> +			       __readfds, __writefds, __exceptfds, __timeout);
> +
> +	pthread_setcanceltype(oldtype, NULL);
> +
> +	if (err == -EADV || err == -EPERM || err == -ENOSYS)
> +		return __STD(select(__nfds, __readfds,
> +				    __writefds, __exceptfds, __timeout));
> +
> +	if (err >= 0)
> +		return err;
> +
> +	errno = -err;
> +	return -1;
> +}
> +#endif
> +
> +COBALT_IMPL_TIME64(int, select, __select64,
> +		   (int __nfds, fd_set *__restrict __readfds,
> +		    fd_set *__restrict __writefds,
> +		    fd_set *__restrict __exceptfds,
> +		    struct timeval *__restrict __timeout))
> +{
> +	return do_select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
> +}
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
