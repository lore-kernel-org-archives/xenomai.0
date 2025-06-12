Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823422BF3E0
	for <xenomai@lists.linux.dev>; Thu, 12 Jun 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744921; cv=fail; b=GeN/yXQh3ZWrT0lSatp+MqlN67iDH6PrwlZIQdAj/rJ6+g8R6PDW5NQhnscq1Ia3tGLitcZsXLya6qiSymikLhBoycuS/FQHQ5xScJms+rxwjjzRwIdvMrdDKohMOlnNCICXrgwr8WP8kduimVsvsiZs20lUrZUkb3Jvd8DxPq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744921; c=relaxed/simple;
	bh=cM5NLSnrnYvuWIg7w8/FJfNGWYodiezRfiQGkWcPf5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ffCbYnYnqDLkX8oEkrmHqLV1Pss/t5gKgMSwQYmjI5bMRTylzKqBHSZYAQjFIg83wm+r8nDbN1dUb36Lgs1iBvMo+XUwmjKdAAbbznLmooU+mOtUC8oceHTyh2nDu12SQKshvGG19UHtNayuHPrDxIxBqAuMES6/oHKgewEUzDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=C6C4UFmM; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="C6C4UFmM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZjURPOgYGpbjSFq5d0kGn/pVXpIqeg5IOpvcgWCYU5ci6Bf4gFdvEpAlhNKFB8y/lmeJkHvwovjGNxG9U+0EZM1JWrAIFPSP1t0Z3F+yDsQmYzCIJLvuhk+6SouPivnMluZK1xFy8dwG0HMsJD/o9ruBnNqip37WE33Nbglp5KT13qBy9MeE/aO/LVi/96XYJd934iMcNzCtCP6/k3/1QYYdIBUUlZrV0QOmJujxmaXWCEV6GzCQvWs40qkilx50MhPINV44iGMRfEgZnHyK9Xdt4yZQtnhTjJiK0+78sWA98hhg6/ksQwgVouOoyJVv6NxlxgbHUWu6lO0Lg+F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yefZvSQ/MzV5lNJqS/2LuKSvZVdG1d47njGlBjLCigo=;
 b=zCqGeXIdoKK5r42k2sw5YZIKcFKbhi3X5a44nbQOsMvblnLFqBz9crGCxeBo7r7tQlX+Pf8x2FqpZQKbp4XKtMtdBN2MOilu9MUqksiHyrinSFyNKtNEPgJGhtpBjnx24eiJamYab3wzQ7/ZkAQKxszzj7aI56Wuis4E8Qd8hszX6BemAru9mCIFw57L/V1eLnZB/+HgGAGqvc6cXX0DO+KGfps93fPhnrdgjTheyEYYzQRl41974tP/uni70UYoObQdhFJ2wsNZp5TaF/95435dkeVFvGuXNH7e/fJghm7eznAzFlXBQWkf7hTMxtTu7NdcErpX1e3sStIrxlwf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yefZvSQ/MzV5lNJqS/2LuKSvZVdG1d47njGlBjLCigo=;
 b=C6C4UFmM6/vlf59ZiwtWNN+guQrOWdktW0sth2hEObI6whl3NksZwPRV35q9EBvRSafwmyIe6aBJv6FsAUNVE9LUL6Q4L+daAZL9dDXs2S8XFw2e0MywUHYvQqyV5ZXkY5kgj6iR11RDfvE+5c4uVLWrS3/reS5dU5bQkdjX82/XfFq+fvTJX3hGBDarUAiJjug8qsO6RbEcBICgfI5s2Yk3FIAKa3oBr0GGFl9TXqj1/ZkYFdGDxX0gGYYgZSKT9HyloAf/5NqZGyBWEljpo/dqh5R0rMikRfrZ5SM8d8Tg3Tl41LhmrK48tVsDCLoovj/XBmlbmsxmO0ZH3jUUzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 16:15:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:15:13 +0000
Message-ID: <edede9ec-0b4a-40b1-8a7e-0784db1d9a43@siemens.com>
Date: Thu, 12 Jun 2025 18:15:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
 <847f6d81-cf28-4155-b969-aeebb76e03c8@siemens.com>
 <87qzzpuh8p.fsf@xenomai.org>
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
In-Reply-To: <87qzzpuh8p.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: a1746ca6-1f89-4efa-f0b1-08dda9cc4fb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFEySS82SHJpc1dkZmhNSTJzSzJMSTRmenpmM09FVERCWHlMamlwQXp4QUZw?=
 =?utf-8?B?SEFQcGF3THplZmtXcjl6Q1U0anNSMXp6UVpuenU2ZjR1aTJKYk5LVFplZVZl?=
 =?utf-8?B?VTRYb0tjK0hKaFduWklZQjk5L0gvNk42bkpuL0dUNVNZb3I3MmhWNWp1MFNP?=
 =?utf-8?B?NGZtT0pCUktTWUZEbXozRTV0M2V0UjdZMlNYaDBhczc5WnJmWnBjSmxuLzdk?=
 =?utf-8?B?aHdGbk1IR3c0QnI3ajZDQzM4c3owVklMTnV1ajliU0dHS1BXdnlmMGhtYTJ3?=
 =?utf-8?B?NlNGZmF4SDcxd3U1QTlubDY0NnFITEswbnJmNitXNjJGb0RTb3c1c0pIN1VJ?=
 =?utf-8?B?enA1Wk5HcHo5TWJESHBva28rMnFnaWpxMlJiMkF0MFp5dHgvbVN1aU9CWnhJ?=
 =?utf-8?B?T2RZNG1QeDZlY1lPUDhPcW9rTW00OTBCZi9LUHJYNlpvcThuYWpkTWFKdytq?=
 =?utf-8?B?UlUycmVNYkRSQ0hDeUllL2RLWGUrNWlndU11VGtXWmxGbU9oamVRM1VKT3FO?=
 =?utf-8?B?SUpLd2pYRkp2emJIZ2NvdFdwMjhKYW4zQUpsem5ocmdOamw0OHFvWitvQVF2?=
 =?utf-8?B?U0tNRnNnVi8yWkNuMDBiNUN1MWthT1YzbjdmS1l6aDJTYUNrd3haa21GdVQv?=
 =?utf-8?B?Q2VwcnhZS1hnUmsxSHIrUEpXMWVpMnZPVFI3VjB6VlNrYjhqem9aa1FMOWpM?=
 =?utf-8?B?SzdnUnVZK3pzMDV0ZFNFTDR3UXJudjQ4QjNEUHhwV0N2TjZpUlNHU0hnZ3hE?=
 =?utf-8?B?Vi9aT21qNGFsQWhvb09aQWc2elBQWko2MmVodDdSNitoNXFjendETWV0VE1k?=
 =?utf-8?B?MzdjTkZ6VzN0NkdhNHowRTFXdDJjbXBidkxkM2lOTEJ3YmVWOHZ5cGZFWFBB?=
 =?utf-8?B?cDgxNTRPU3oxNlVNTEh2Ymh1S2RsVW5raC9NTVNEb3Z5ZWY4V0Z0eFB2a0RZ?=
 =?utf-8?B?RE8yR3NvcU9WTVNhajBuK08yUE9ZakVIeWZDbmlGK2RFM3ZNRDVaaGFiV3hN?=
 =?utf-8?B?OGltMFBXd0ZCVmhyaDY4dHFQVDdSVjJiTHFiRTdUZUVJSWFsZ2VSSUZBZEJF?=
 =?utf-8?B?d3JoVm1UWTRxc1dhV1VYNFh1VEtyZUlmdSt4NURvODB0VDJkRWRWdmM4VGVx?=
 =?utf-8?B?WHBaeXd2MjZHN2d2TDRDSENzb0p2TjRjSlJhWGRFSDY5SEhhUnQ4ampibFkv?=
 =?utf-8?B?ZUloNUhBQmFYcm4vQkQ1cTBHZEJ3dFFkc2w0UkRDVlErTnBNb0VvOEFiZFlT?=
 =?utf-8?B?Wkd4aUZtY3kwZFNsZmZVa1NKcENVZFVtSTROdFR1aFUxVy9NMXUvbW9WdnRi?=
 =?utf-8?B?WE11NzNTNzlya3NZdEkyTXhuRisvWVVFd1pSSk02WlJXa2pUOWdvekI5VEpG?=
 =?utf-8?B?UU4xMG9QeSthTmwwU0d1TXU2NHVBNi9WUmo1dTZublhGUkZza3hlOWxOaElo?=
 =?utf-8?B?QS9HTHV5clZ5MGh3K1p4VkQ2MUJZeUN3RmNhek5uVGMxUWVIYXd0VUJ0a2dM?=
 =?utf-8?B?UDNYcWlEQjhpS0RONHpDNU5WWDdxRWVWU0ZXVk5wWkp2VFhkNWJYQzRCUEQr?=
 =?utf-8?B?dmU5V1JQbExGWDhxMHZVMjdxTyttVE1EM2V5Ukg4TEhKem5iYnpmVUxacVly?=
 =?utf-8?B?Z1drelRlRDZNMXpwVk1jdHhRZTZYTVdVZ24yTEZGUXpCaHA4MlovN3oxMVFk?=
 =?utf-8?B?WTJKaVBtd1J1VEhkcldlc3hQaklQclByaFRqQk1sUENjd1pZK0ZyaFNySmRw?=
 =?utf-8?B?dnluS0dYN1FlNmJRaFgxZU5RRkpQNlUwNUtqMHg5VWtQSXBuMys4Y0h4WExp?=
 =?utf-8?Q?XZdi/TPuaAZjuaVD035JCB7AOERkgnbZuYv2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c09LSi9GaGZuelRQUkU4S2REMlIvWFBBb0pBYldja2JpN2EyVGs5Nk14NGhr?=
 =?utf-8?B?aFVSWTgxQjNoallJUDg4VnFvdkFjTGh5Qy9FM1BrNzgvMFljcjNPajFOTEFB?=
 =?utf-8?B?R2RiTGxBbXhCdTFyejh2QUVJVCtVWTVJRU8xQVMxN3kvQ2c5ZGwwbzNQYXZz?=
 =?utf-8?B?WG5wMTFQdUJ4Sm9lemRrRFdCSEVJTzJ3a21ZR3B3TDBOY04vbDEzK2p6a09r?=
 =?utf-8?B?aEN4TVQvZ092T0ttSkRUZVFXbHNoQ1l3KzI1WmhWUjhYSlAxZVIxQWhPQkkw?=
 =?utf-8?B?d2lNd1RNWCs4Y1Y4R0U1cTB5MkdqRWxGK2k3T044YUh0dmVDbzNTd3BxL0gx?=
 =?utf-8?B?VW4vcW1pOFJqYVYxWWpFazEzLzhpelZsazIrTGFyVnhpNi9CM2ZxMjFpVDlO?=
 =?utf-8?B?L3g3ajFkeE5QemIwcFZkVG5COTMvdGV6MEZZanlEK1ZHYzgzWGZmWTVDVUls?=
 =?utf-8?B?UlhzUys1dGZVWTBpWVc3MlFXSGdnTzBqdUxSSDBuMTNjQ20ybXBkMVpZMDZj?=
 =?utf-8?B?eGV4VjFOM0N0U21mRDBYdWJKMzFKeDlTalE2bFMyMmJ5S1ZGaVBxZzc0TFdu?=
 =?utf-8?B?SGo2Z1VzWGlaU3FNd09zQkdqTEZzZ1dsODZkYzBZaFpGeWNiM1gySFZTL1V5?=
 =?utf-8?B?SGtzMGRCaEdrSUJGbGVlZUZibFFrU2xaT3kzTzdDdjVZSUl1eXNJaXpEbW8v?=
 =?utf-8?B?djAvS1VlREI0UDdBS1QzM3FqcE42RHVtMmZkbmtWamJqU1VoQUgvR3F0VFEz?=
 =?utf-8?B?dUhUa0dUSUVOUG9VNXh5a0czVFk2WlcrWHNYc2xRbzFFSHNKZzJJZklzTTZ3?=
 =?utf-8?B?WCtwVm5qcVd2UHljVEYvWm9LOS8vaEF0cDluK0NZaUR0M1VmVXBKME4vZkZD?=
 =?utf-8?B?NUxNRDBVSTliVGEvR3ZkZ0oyNTIrQTNqMS9lL0FvbSsycXhQUkF5d3NTYTdM?=
 =?utf-8?B?UVNOdG55R09aV25UZ0xNOWxza2x0R2JnQ3RJNmJZa1cvYVpGeTNEMzBhbEJi?=
 =?utf-8?B?bTE5Nkt4VFVKekJpQVB1VmJZdlA1dkMvUlJJb3kyUGYyVnlNVlVISXUweVp6?=
 =?utf-8?B?K3lEUTdhQTlYcjhFcnI4UmxtMTlUWTZ2SEhUckJGLzhnd3dzQW5HVzBBN2tp?=
 =?utf-8?B?M0FjUHdQR3ZNSFFtbFNuaG5JWDJNNUFHcFhJRDR6aW9aZnlSMncvejRKb1da?=
 =?utf-8?B?eXNqMXlqZnJLMFV4RDRmSlBGOW1mS1pzYVJuVzQ1TzBxTEFNQyttdmpqR1F2?=
 =?utf-8?B?dG94Z0xhL3dUUWNUYkdlQ2ZHSWtkK0tvWlhWZ3FJdFVMaVFlYlBHZkVnMk04?=
 =?utf-8?B?aVRtWnZPcEFYajBET3A5L2c0bk9Wa1RBZ2RwWU5OM0dxU3EzMWVXaWpNZjNL?=
 =?utf-8?B?NzhYYUF5RFA4L1E4ZlVwRnpOb1RwVjZBVDRYTlNLczVoRVRxamVjajZVMjIx?=
 =?utf-8?B?azlMYUkzMVl3OHB3SHVZUWg1V1NBcHh5WHBWdTVWYXVWdTdaN0draXlnVHd6?=
 =?utf-8?B?dXMxNVVkbWtqQjNGM3RKSnRoMXovL1hEbTRrS2tybzFLNm13ZGk5S1c0ZHRz?=
 =?utf-8?B?bkdHWXExLytXOVhic2laOUttTitlTTcrY3ZlRXJvQm1YcDFwbnd6OHZhQjFT?=
 =?utf-8?B?TVJEYUJsWTZ0MmVkU1Awb1JmL0JkMXl6K2hCcnBieExSNmpkL0VIM254cFAr?=
 =?utf-8?B?cmIyMkJjbDlPdk5WN1FmMFo2dHdrQk9IbFhhSDl4bzdPd2lLaEVhWTdZOGlr?=
 =?utf-8?B?SjJvOTBqUGViTWQ3K1YzL1dyNHlKUGlKUTlPRUVyOWRLNGdoTGpORnVnai9t?=
 =?utf-8?B?NlRuTjRoczlGU21BOWhRb0drWHpEcHIveC9TTU1RU0c1Vi9RUWpEOVoyd0tI?=
 =?utf-8?B?eXZsTmtmNE9La1ZZUW5UcURod2Z0Z1I0cE5tUUZMQTZ4Umx2Zlcwdm5JZDZo?=
 =?utf-8?B?SnlRY2hxWkZRNVZoN0F3ZmV5cFlJQ3lPSGFkQWVtTUNJbDRQT0dTNHlxcTBl?=
 =?utf-8?B?Y0ZxNmpycmlaWFowY2NSZHlxeWU0c3VPT3FQUWMzSUdONnA3ejA4VFdzY2VU?=
 =?utf-8?B?ZW43Z0F0b2hTdkNMSG5hbVU1eFd5eDloZkJVNWVJQVJ3bWVTUms1SHVLWHhN?=
 =?utf-8?B?Z0ZSK2RQSjJMTmdqeklHL29IMGZFb1h4TlMvdDBFMWZSY0I0Tm5zT2NQa3Bl?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1746ca6-1f89-4efa-f0b1-08dda9cc4fb1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:15:13.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2yTI0erYEgLgvrDy2Dwon838Hc9b5bFPf99vsSSucU+2Wo3AcrzOYYNHZkIHhMg3F81wP8VCZL2PNVtSWc4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9165

On 12.06.25 17:11, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 11.06.25 18:20, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Not yet tested, but this should make our pipeline green again:
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
>>>
>>>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>> index c0932a3cb220f..26be743f2a6cf 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/pagemap.h>
>>>  #include <linux/netdevice.h>
>>>  #include <linux/ipv6.h>
>>> +#include <linux/skbuff.h>
>>>  #include <linux/slab.h>
>>>  #include <net/checksum.h>
>>>  #include <net/ip6_checksum.h>
>>
>> Sorry, this was wrong, at least insufficient:
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1167536
>>
>> Seems there is no way around reproducing locally. Will keep you informed.
>>
>> Jan
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 26be743f2a6cf..67920a8a66733 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8910,8 +8910,10 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
>  	if (unlikely(!skb))
>  		return NULL;
>  
> +#ifdef CONFIG_IGB_OOB
>  	if (igb_is_oob_page(rx_ring, rx_buffer->page))
>  		skb_mark_for_recycle(skb);
> +#endif
>  
>  	/* update pointers within the skb to store the data */
>  	skb_reserve(skb, xdp->data - xdp->data_hard_start);

Yeah, that looks better - we are not enabling OOB networking in Xenomai 3.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
