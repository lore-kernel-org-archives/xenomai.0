Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715212FF6F
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641750; cv=fail; b=XyAsVA1fJjdAbJXbGsPYsYoTArGAytrc/gnMYfjQxlnS2ayngtL3acYjWDaMZL6aCUSh5f6oMAw6BdWtm3TLFrYUuDOfndG7O+IBb8Jt9NIjtRxTQvs52AKRvOarCrM0qSuhtEkkkZN2Xr7FpGInXQKPIxwZSd8D83cltqMRyfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641750; c=relaxed/simple;
	bh=Wy/cI8kHojcZlCsM2l4CraHXfBf3CvdV5sVQda60pAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dCxyCCrpCNPipvO1gtfMUzdfwoM21eUqlx/f960OJc4/qRl1kKIgW9lWFN5tSKIBP5ukz8y7nZfO1+dzcsXEEV0xA5EtuYMF4St31F3A6nzjISCITFd0UsL2uoaEk4wErwvZ7KRjLvHlMlYLV29TzpXXp9ojL/eychJEaePFFBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uiJJi8gA; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uiJJi8gA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKizaJnqa5IpzvtRfQO4WP2O9BNi6m3O3bWZB+/4ExT/BDVlYOkcIxp8RTlMSw4hk4zdnrYmnYbl3dGIJ8WE0voz7XpENh7mE0JREZcIdDDlbTonThaM6fBukqwgLuK9BBXrcY7I1SnbXcaAbyXsMoF9yg/QRRVG0szE3xk3df0GuAtYZSzLfTdVqPhXjUZlPo4B31CZ0Ix7paSu2Dfan3ZG7R0/0qroodxuKWPCHuQ9nnMHG9+58fmR/2vHQ4Mc0jun+zLrYaQAW2buS18HUnq9MDzGX9ULRyMM23IgNOMw5F/OmYH4mtysh0j4+0QSmecfRyUifdLsQ2+Klerrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJkAOAud/o81ETCgMyAxcbXytifOppPq9q5QhL037Gk=;
 b=GNRRt5TrFK5WuBn2r0SSEr1XkKQaCMIA6ia5O0mClNiPaD6U3tehEm+Zeha+wi3dXt3Db4C81LH+c7YO7Ueo0DDtxWCG8vYqLOad09GLw8DvLg8pr6rKcr6pYKbhqJsmTToM7/ax9sgRrFjaJ2OHjgYSQZbW+dJMVjNcEHbc7SYLUUPxBUg/MF+BzFvqN2hkHlaxF+IxlrAwOWwpolkNQSz74zHWuIhkWy3e3sB2X+HfiO2jI5TuYRLWugi6tIce/LuDq423T45N4U/MyincTlnvOjXEDy3rCGEPULpeNfvpynuCwOE6RYcw04p3HJIq6UPk+hP1MW40IBzBtvjc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJkAOAud/o81ETCgMyAxcbXytifOppPq9q5QhL037Gk=;
 b=uiJJi8gAFeU9F51sp/c4vNGnS5Y/9sM/RNAYbxbKIxr8+oD1Y7pkP0gMPCq30txpff9GYPXYdxPJYSWu8GMXr9d1Z66ZRFAaK3JQ8m0Lm4Sigb+fV2zWrFYqot6PfGDL+QlXWWA7DP2ffTKBmlYJjWNwDIgX3EwtuB9ONLh7gxhfUEN+/zx1xfyZBlO5NbY8UU7W2AZCKoa7nXZoIfRU0HAAsEKUgbQ1o6ANMvyZe0oF+6FVsp5SLoGox+cwpa/nxXg1wmYmz1maOiRxMiV8R9b66qft+3pn+sDzIaaxyA2VSWczF7CNcIyMKKdIOmS1nPK32wb4yQ7ZJFfnrKYwpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6751.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 08:02:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:02:23 +0000
Message-ID: <1265cab5-f8dc-441f-a683-675e64b505d9@siemens.com>
Date: Mon, 19 May 2025 10:02:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/cobalt: Unbreak sigshadow installation for statically
 linked applications
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: Haiyang He <aspirestro@163.com>
References: <dcc04a18-af0b-4661-9a2b-f07674f2239c@siemens.com>
 <11e61990decb9a05266fa955cfa62bf6773a4774.camel@siemens.com>
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
In-Reply-To: <11e61990decb9a05266fa955cfa62bf6773a4774.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: b740262c-7eb5-4b5e-f2c5-08dd96ab7caf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0tiVkh1aGJPaWFPdEhwejN1R2pqZFk4cU1GeUx6TjBGTmNMc2hiQVhueEhE?=
 =?utf-8?B?Y1pHNm9UNzVvVEd3aTltbEdYbms4alZodFdjZnBMMFhIeitXS1o5Z2d0NjBn?=
 =?utf-8?B?M0hBZVVNbjZWR3hzSzBraFBVQVBtZUNoMU04OEFtY3RKRHI4V01jMkFtU0hz?=
 =?utf-8?B?MTNzbTFJTWxXNFVDZ0dGdTFoLzQzN0locU41UHhVNWJSdjZJZGhnZ0dKU3Jk?=
 =?utf-8?B?SUdoOWNPVUF2UmxhVjhtanpJaXoxZk9CZ1B2T2NxN0tTdnJKbzhxaEEzRDc4?=
 =?utf-8?B?UTVISmdIL0VVOUpmcGxHMFhWY3RJb2dPS2tSeUJrcGZzYVFaN3BSVkdjN3h3?=
 =?utf-8?B?QXdkNWNOWmpZTEphYVBpUk43REhiSy9Ud3Z4L1JsYkpveWoxNnI3a1NKRjg3?=
 =?utf-8?B?L2YxcDJoZFVNeHJpUW1UcW1VRElydmxxOHRVcXIySis3QkVWQ1JLQXNCcGhx?=
 =?utf-8?B?OExmU3IrQUE4Q0JrQVkxNlh6YXhic1BPd2NNYlptUGliVU1sbEJUd3hTN0lL?=
 =?utf-8?B?MjhlWEZaL1RaKzc4ays0YjRBWjdKdFJ4T2hqUHQ5MTlpNVpiN3JGN00wSjRI?=
 =?utf-8?B?MVo1T2FEemc3NlRHbUltQXpkRVQ2Vm0vM2F3OHhDSk1HMU9Ta3ZOQWV1M3B6?=
 =?utf-8?B?b1Qzbm1wK1kzbmJmdDlCQkZFbFdtQ1NxMDU3WHN6OVNPM2VJcno4eDU0ZUpn?=
 =?utf-8?B?SUVjcmxHUzdzL2R5SkFCcmZGTlQ3RDlKbVNsWGhSVElYeWJac0hQd3BiQjdE?=
 =?utf-8?B?cWxpNUhpUUMvRXF4bkZ3QUpDb3BtTHY4UUg4eFMxZHJDTTBjWWN3SWErVmhO?=
 =?utf-8?B?U25sZnhjV2Q3VHI3dkpBRTR5azNLSE5CUWd3Qyt6OFVFK1JWaVpGaDVXRlJa?=
 =?utf-8?B?TWlOdFdpMWd6VUVmTzRZd2tMUkkra09mcTZlVGVMUDcrQ25wTE5LTkFLVk5S?=
 =?utf-8?B?MVNtYVp4NEVoN1BJQXFoOXZnMkJPcDdBcmM0Z25WK3hFZllzT0hUc09tb08v?=
 =?utf-8?B?MDU2eVRLQ1NpYVE1ZXQxdm1WZVR3dGg3Y2d6ZkZSSkFXK0tqeklScEVBSTAr?=
 =?utf-8?B?akRIU1FGM0ZZSW0vWWEzU0tqZXBkajZyb01tTVc0ZzV0Z3NmdFJlYVFKRmJ1?=
 =?utf-8?B?anhwYjh5aDRkYWNYVFdycGJ3aE5kTU53NUl3cElQbHVDNk8vSGhSVDhZMXhm?=
 =?utf-8?B?L05aYUFBV1J2ZEt1dit1TkJZeEwzWC96aU1IV3EwUmovaWJXTTVwVEVrQ1ZB?=
 =?utf-8?B?WktpZEZTUk05YVdiV1JPaDkzNUhmYlA3d1QwalpkNmx1R2lHMjRvM0ZUR253?=
 =?utf-8?B?TnQ5T1g1cUVjb3E0aXBWVmJQSzZGTzdmcHBXSVVXTzhZQlFjbXNEWjZBYlBE?=
 =?utf-8?B?eDNVdStZNUV6Uk0xRnJ6K3lYOXRmcUdIdG91WkpEUlRBcWJpeWJ1aEp6N2t1?=
 =?utf-8?B?WVJldTZqRnczdk9aYlpOdC9LMmxaaGFMaWQrTjNNTnlKOHdoNG5nL2RvK240?=
 =?utf-8?B?L3AzNGc3Y0xlMUt3V3JxRFZWZld5SWEwMVVVeXB6dmpuZ0RuYUxIeFhERm0z?=
 =?utf-8?B?TEJTeW5yUjlGSkdKa25yR1hUMU9CdDlHYXdwYVhNbVFBUUE3UmM1OFcweWRS?=
 =?utf-8?B?azl0K3lEYUtqWEN5dWM4TVU2cXE4ZDRkNnVDdmI1SFIrRTFvSjR0T0tMc25i?=
 =?utf-8?B?N3NId2M4dUpRbm9xNXVtWnp5ZHlGancxdlFzaU1za1dKOEJKdkFpbklLUGkx?=
 =?utf-8?B?L1R0VU44TlM3c2VCdkpqMUZXaWx0dnNsbDh1Z0xDc0p4TmxEc3A3bjZjalp6?=
 =?utf-8?B?YTM2a1IzcmVISW8wUWs2SXN6QUYyZHlmY0tRQmVtNklUd0lJYS9tNHdhWDVu?=
 =?utf-8?B?YU5MeDVNbW5GejdKYWJuTk4wWTVoY3ZGelMvSHVJTVVkN3RDRzFOa1BvajNR?=
 =?utf-8?Q?8h8K9rvy0FY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHI1NGZVSGE1Q0VncVZPdUo2YzdzSmhsTXpjRjBrTmR3UkNMbnI4MmtuNEdJ?=
 =?utf-8?B?Y0lqcHFEdEdmMzRLbzhodGo1NHdLdGM0TGZ4UHBpcTZoa2o4TzdKUElBaEJZ?=
 =?utf-8?B?SjkwQUxNRjZQaGpmVEp5L084ZTFDWGFvM0ZLQVhGZ2ovb3pWcjFkeHhpOGxG?=
 =?utf-8?B?Z0UwbU4vMkpQbVF6V1JRTHpoV1prNDczb1dabTRUSHhiL0xNVmp6MzBpTG5O?=
 =?utf-8?B?M0M3Z0ZGenZqb2FmcU1UcTZXTm5ZSktIKzJVWWd2cHh0cFhkVEw2YnJ2ckVJ?=
 =?utf-8?B?YStLZllYSC9FQnErbTdZd3FxZFlXMXRMd1JRTWZDRkU2cjFHY1ZUWmJjUXgr?=
 =?utf-8?B?NFo2WkdxYWlEc1BuWFg2L3pCT01aTDFtcDZhaUF4WmRrby9NQVd6TzZZUlU1?=
 =?utf-8?B?aWVwaTdGcldUYlpETCtBaEM1Q2wvR1Axdi9PTXdSbkxLazNMK0p2b1ZvVURo?=
 =?utf-8?B?NEJNN3NmT0gxSE8xS0k1TmFjMGwvRys4UkNma25JZmNINy80ZEhOeVRGUzBG?=
 =?utf-8?B?dm80N2EvaWVLVnRTQkxvN016WkNMcTFKK0V6VE1pVGUvSUxTbXkyRDRIUmVp?=
 =?utf-8?B?UUlFaDNWK09JV1lJZTZqT3dhT1RBbHRxc2YrRjk0UVN6N1ZhUzZUaytlYWJJ?=
 =?utf-8?B?eDNvK1ZUUENGNkR5UEtKR2haMElhZjMzZFVPaFNObFhvMEJTUWRuVkxwQ3RC?=
 =?utf-8?B?MENsa1l2dm52SGlUNzAvSVZoSnVJdGh6TkRFU3RRNkdCRW5US2IrQjFpdGVR?=
 =?utf-8?B?ejNNb3BWN0s4QzlZSTh2QTBaWFIzWUcxdlZhYnpxeVN4NXBqd2lGVGR1VGZk?=
 =?utf-8?B?WFhYd3RkVGhlc0M3aFBpRGtRMmlSZkNObm1IcDN0dGU5R0drOFlYYmJ0VEVP?=
 =?utf-8?B?M0k3Tk5TYURzcndybVAwUmt5ZERGRXZRMjdvZmIzSjRkYkd6cVhSOHNZMk9l?=
 =?utf-8?B?RVVmbDRhWjlmWDN4VHJnYXFsRkVMdFdHYTJlQXI4K2h0VFcxeWRGQ3B6RDRL?=
 =?utf-8?B?b2x1UEEzTHM1Wk1vWE5wSHQzV3JPYnViajhlenRhU2NmcXROT0VlOG5qTEtG?=
 =?utf-8?B?aVlXaVZDTzZhZW5ROVdBNWlpZzRBKzNDVDVBU2pjRlFiZXBlRlVoUS9TZGgz?=
 =?utf-8?B?czRwOEV4V0ZoZU05Z09NRzhZaG5iWXRweGJscjFMYkMxYzRWbzI1eER0NjZ1?=
 =?utf-8?B?RncvQ0s0ZHNmRGNPQUVpWkZNbXh2bVVEcXZodnA4VWE0cVUrc2xBcGtaRHpq?=
 =?utf-8?B?b29mZmcyYkJpQVA2YkhqbERWT2REelVkUm1GS1VmWC9aRzRjZmNLVmt3YUw3?=
 =?utf-8?B?YU9NckY1SXRJVENyUVJSNnFBR2VpQlozNFAzRmZHUDZRdlh6MzFqd2w5MXZ5?=
 =?utf-8?B?QVlZRkxwOGpSNlFMazRXdHhxNlJXeVJoVjJiNkNtK3FxMjVIa0laOTF0RnNx?=
 =?utf-8?B?QjlrVDRjditSQ2E5aWhyZWw4Q2lHeGJRRHRwcXU5VWcrMjUzZkJNY1NwMzBq?=
 =?utf-8?B?Ri9JYXpVWjhjaE0xZDROTHNOODlEK0tjWlpyL1hjeGI1bUtDTHNxbVIwQURZ?=
 =?utf-8?B?QTVXNnd3MnArcjVxWE10elFwUlFKMHhPQVovODlxZklIYnBZL0Y0bzZaN21N?=
 =?utf-8?B?eHA2U256V0czY1ZkMDBLRzJNanBhQ1VrMmxEMks4UnVrUWZzdlowRXpLelFm?=
 =?utf-8?B?OWMwOTBMQnVjRG9Fdm9rV3BSejN4QVpuRGlQWDM2VnloUFZTZFJvSVh6Y2Y0?=
 =?utf-8?B?WkNrV0VoTi9sbW5DMkxIMkxKbVBKQ0hxb1BpUFc2bTNBa2sxdzJRMXA4bzY4?=
 =?utf-8?B?UkFxaGdBbUNtd3lBcHU3N1Z2VzZTbVJoL1FBakcwREpCRGowRnZVNG9uZGRG?=
 =?utf-8?B?SFNNUDVEck1NTmk4TGo4anBIazhhL3F2cmluNFBpNHl3allOTEt2ck5kc1NJ?=
 =?utf-8?B?OXM0ZFZDK0ZiUnZLWVl5aHphTDZiejJ3UGRyeVZEUnUvMnU1T2Z0d2NHR1h1?=
 =?utf-8?B?bHpkcmlmRmxzMExSemk2SlhMOFRtN1UyUmR2bGpWOFpXam0yM3lNUmtQWEQx?=
 =?utf-8?B?ZXdTWFFwb3hQczhVZStVWS92RStSYWpLRExUZG5qak10R3lYbytSbFNIMUx0?=
 =?utf-8?Q?WzEHoFfrqhRncqdZcW3TuGd98?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b740262c-7eb5-4b5e-f2c5-08dd96ab7caf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:02:23.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0uO8gYRty9F4Due4C3aG4MoGvVvK9AR7b7x7pGUMUkmmJyGoA0liZRvL0fMdBJjV5e0ca16LmITN6UVhdlUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6751

On 19.05.25 09:41, Florian Bezdeka wrote:
> On Mon, 2025-05-19 at 08:44 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> When statically linking, we do not have a .eh_frame_hdr section. If we
>> then call backtrace before frame_dummy was invoked during late
>> constructions, we abort. Address that by moving the backtrace warm-up
>> call into a separate constructor that is armed earlier by
>> install_sigshadow, or call it later directly if install_sigshadow is
>> running after the construction phase.
>>
>> Reported-by: Haiyang He <aspirestro@163.com>
> 
> Was that a private conversation? Seems it didn't make it to the list...
> 

Old list address, I forwarded his posting.

>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  lib/cobalt/sigshadow.c | 33 ++++++++++++++++++++++++++-------
>>  1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
>> index 092cadb08a..abdb6b5491 100644
>> --- a/lib/cobalt/sigshadow.c
>> +++ b/lib/cobalt/sigshadow.c
>> @@ -33,6 +33,9 @@ static inline int backtrace(void **buffer, int size)
>>  
>>  static struct sigaction sigshadow_action_orig;
>>  
>> +static bool request_backtrace_init;
>> +static bool past_constructors;
>> +
>>  /*
>>   * The following handler is part of the inner user-interface: should
>>   * remain extern.
>> @@ -96,19 +99,35 @@ static void sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
>>  	pthread_sigmask(SIG_SETMASK, &saved_sigset, NULL);
>>  }
>>  
>> -static void install_sigshadow(void)
>> +/*
>> + * Kickstart backtrace() so that it may call malloc() from a safe context right
>> + * now, not later on from the sigshadow handler.
>> + *
>> + * We can only trigger this after main() started or very late during
>> + * construction because, when statically linked, frame_dummy in ctrstuff must
>> + * have run already.
>> + */
>> +static void __attribute__((constructor)) trigger_backtrace(void)
>>  {
>>  	void *dummy[SIGSHADOW_BACKTRACE_DEPTH];
>> +
>> +	if (request_backtrace_init)
>> +		backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
>> +
>> +	past_constructors = true;
>> +	/* ensure visibility of past_constructors after init phase */
>> +	smp_mb();
>> +}
> 
> Could we reuse on of the exiting "constructor priorities" like
> __setup_ctor or hook into the setup_call() machinery? Benefit would be
> some more control over the ordering of the init phase.

No prio = prio 65535, and that puts us behind frame_dummy. If someone
finds this specified somewhere, we could improve things.

Jan

> 
>> +
>> +static void install_sigshadow(void)
>> +{
>>  	struct sigaction new_sigshadow_action;
>>  	sigset_t saved_sigset;
>>  	sigset_t mask_sigset;
>>  
>> -	/*
>> -	 * Kickstart backtrace() so that it may call malloc() from a
>> -	 * safe context right now, not later on from the sigshadow
>> -	 * handler.
>> -	 */
>> -	backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
>> +	request_backtrace_init = true;
>> +	if (past_constructors)
>> +		trigger_backtrace();
>>  
>>  	sigemptyset(&mask_sigset);
>>  	sigaddset(&mask_sigset, SIGSHADOW);
>> -- 
>> 2.43.0
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
