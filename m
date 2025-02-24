Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956022192F6
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415492; cv=fail; b=kkc97DvHDqdHldkE2QmvF1RYYNFRLh9zGciB30CH/s34GTllzFD7dOFn0BVleNRGnubHEZStYKy88HErOY8vrHq87Zb8bbsRoabRBtAANhfRdxfUPuglWy3TzWRA1lizTtRFyIUexTO1PWAbBs7v4Vx400Aofxh1sLsQIc1sQ6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415492; c=relaxed/simple;
	bh=4sSQwYrPO3z0f+BJ7fOMkV7tZ39uexdZfEuSTfJc3Hw=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=gNNr2qEML/1g18nma9tc2yFWFh7RY0+Aj4372q96q/FV+gDxwu1Fd5TaSHAzn8AtALx2kC6KOOuI7JPcPaUkASmFICjhwqgnAzgnxgeSe1bKmYRuXhtU9KTawDv9VGOWjKmhNVwKY9p315uUrny4qq03zFtEwDyy5PW1PzcerCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h8cCnIxR; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h8cCnIxR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/vev7tdvEi/sXD3G9UDJl/eC75gk1QCz1zuoVQbNIwECPj5z/g3/JWmFDMZB7IWMYsY9Qvxgy16AlBj6/+KY0AY18qJD2DUt3abNww6c12dOeRQlhWvt5u6d7JQoLHGGB/2ZRyCnkUrGq3WYqrtk3pr3U8WW+TY/oFC74QnfPq/XEDRaV5ZYTgzpDmmtHcAxGYTtArAUmJnuikyFUYd3KL9AZbPUegB0d6F4kcwGbrMk0vgsNtObgdqJT5S+938q/zKYUg23F1S+KQTbZhvnseHq1kQz5Ss+HWaX9LLwnzOng/ddEfkzdcRutMyMbFA2Mh0gJFphzLeotIMrg6gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eidac7o3g2wSeGv3+ybmJd6W9VI8vVtdlFz1ylNqOno=;
 b=Nplay2mkFuK0I5dtLJDZV6JlCiFZFbWt01ylVkmJwp4ZO/Wfnuj43cyBLR6jUT9RaDJMc1uKgQUOBIaxARxr5XWLkv6wHhkqB/5+Fo6m5QCf+PiuBYa1FJIB+BrAvdfjcaFbb2at3JixhzUs//jzp9IHFEhJVnzo1LiSWOSpaBUCPnvsUp42jG7GnQogScoe+vVOUPklIRgQ316ILHBwGd854aax7rjFKlmJ+YK2jYIOTms9dIcZYwjxsCPRdKxrc9PFnW4MUnSr4fppt+ztcnHK0A3/gUFvNCaywEZLBaqAYn4o6BSLIltiYNZa4hGicUaOoC+IG6ycZ0Z54/lIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eidac7o3g2wSeGv3+ybmJd6W9VI8vVtdlFz1ylNqOno=;
 b=h8cCnIxR6ua9ImiYoGkzzeLui47ICcW99TjxHhxAMqKS1cY7el3TPdjv6fcmjbSAqK+GucvNx4Bpn7EHS9Q0EAUFds95hBannATAfgLHDGkv+o/wiJW+iECFsyedkBz6fluTeaAHPuGBcfPR6OOKiIaSQRgcGq+QkFW/0RJdvw0sYVkcQjo1Wotn4hzXpWJgKlyuUx57XpEueYk5G0p1U/6IxfCtR0zbTA5q7b9Gig7mzBjOuiBTOITOSAGKPvmHukJlARBthcR5ypckhyUqSPGfIYOyMIc6fmS7dAayUNDxm4Z8vhwVDH8mpEcYU3ssD/VJonBvU/JUrejgYnSreA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:452::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 16:44:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:44:45 +0000
Message-ID: <eeca1faa-bf32-47c9-aba7-fa197034dcac@siemens.com>
Date: Mon, 24 Feb 2025 17:44:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: dovetail: Harden __send_ipi_mask for KVM guests
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
X-ClientProxiedBy: FR0P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ade98f-d65c-48ee-4758-08dd54f28b9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWpFbG5MVnNMM3JsU0gxMHZVWE5vQ1MxQ2xxL3hsakcxWjRmQzAvckZzc0Vi?=
 =?utf-8?B?SVlSbGhPQjUwM25lVU52UkFkanoxZU9IZXMvYWhOSXpHTjUxdTRzRmU3SWV3?=
 =?utf-8?B?U2xGMEJxejdqbWZOOW1zWUFvVGY1YWlLWUMwUW5GUVdwRi9xV0g0LzJTWFZq?=
 =?utf-8?B?Vmc2VHp0cTFMTDlxT2pDNTNhb0ZrU0hvUFdBTFA1UUlvbGdPem44WVJaQlox?=
 =?utf-8?B?TlhaZFA2bWRJTkRTWDFFdy9qSHVsVWNPdmZrVzFKTGM3dUNrQkVGc1AvWHpk?=
 =?utf-8?B?SW1HdUpkVVVtUjZQVXFoTGR5b3dXeFZkV2lyMkU4S3dvQStWWEw4Z1lUS0Fh?=
 =?utf-8?B?M09Gbmpodlc3WjJhczZicURjK2hycGxNelNvM1pSOXhxNEZNbGJ3OXVZem13?=
 =?utf-8?B?bWFwMVFhLzBITS8yY2xOb0RwYmVaaTV4NDg3eklLaC9aeFJROVRyeU10UXE2?=
 =?utf-8?B?OE5leWd1RHphSVZ4SnE4TkwrQjhFRGI4NE1jazE4NEpiOE9lSFpodFdJaUJC?=
 =?utf-8?B?VkJRcHlScVdSSzBnNDZ1emlwZHN2TllKSlhHcGQyejdKQnM3YUphdGhaMWVq?=
 =?utf-8?B?dDZUWTBzb2JTRzM0QzVkVm5maFpSeDY5VmxKQUpBV2o1RGZTbWc5VjhRR3R2?=
 =?utf-8?B?Q2NHZmxUWkR5T2VpT29oZ01VUTZqbENockFHbDV0czlhUVJpSXlLSWdpem5j?=
 =?utf-8?B?VWVzcjRUbUFFODVLSXY0Sll4R1diWndSbE4rbmZEbkVHbnQzeU9wdGRiQUZi?=
 =?utf-8?B?bVVzRXplZ0IrVFdQa3BjNURTbTl1Y2k4N0FYb0RkMGQ0dkRxazR5SjVyNHdQ?=
 =?utf-8?B?ditHcFh0MElRVkNwWEZlWklVM3VSMTZsc2ZINlZlRVZvL1hXWlU0STlBdnY5?=
 =?utf-8?B?U1d0QW1kOFFNU2xEU0pndG42SlFJeFh5SGVPekJaTzFOeVdVUm9jbGlQbWln?=
 =?utf-8?B?OFFuOHpMTTAyZUM5Z1NIWXZVbHpoaktBc1VMT04wUjRSM0tlM2ovbGRmVzUx?=
 =?utf-8?B?VEJzall1ZU9IdEtpU0wyWEFCWXlHb1FNYmdPYitjSlhnNXRtZDhEZG8rZkhZ?=
 =?utf-8?B?VTZ3T2ZjNE16YUxQUWNJSmtmTHlHeWZ2M3crTU4vTkp1eG1TQk9seURFeDZk?=
 =?utf-8?B?ME15YkxLOUN4ekhYbnR0QjRZYmY4UHJZc09sNnJ6bEJsTEt1YVRxL3RPNXZT?=
 =?utf-8?B?WHdzeWVzRkQ4WmM0NzE1bFd4N0xwamk4UUFQVjFRNzlYMnQ2UmRrMTl5UmYw?=
 =?utf-8?B?K3dXUWlFNCtFdSt5S2F6KzRZdHhGdEc1UXZ6UkFmSmZLVEN3Vzg3WVZBTHZu?=
 =?utf-8?B?T3ZpeWMzeXpqMVlVMXpwb0NXRU90TldwcXVnL1gwTjU5dkJoQlRpNVU4VHZD?=
 =?utf-8?B?RGxKM1creWxnam5KamF1d1B6VWpqcmJuWWFaQlhCcVJQQ1BEOUtXTzRmcGg1?=
 =?utf-8?B?WVdFYjRkZXhjRExmUjlSYXpZSlU2R013eGFuaWlKQzRtcG5MdlJsOFJrejhr?=
 =?utf-8?B?OEtkSkk4TVJSajBBeXR4NkxiV0UwcW9QREFvVXJEZ0VDY2VBUlFwYXozalJo?=
 =?utf-8?B?WHY0dm11QWhaR3RRMk9lb0p2MFR4b2ZrQS84OUNlWkg3ZlJ4N2lnOFBid2JI?=
 =?utf-8?B?SFgxZ1laOWlsUStCOHJ0aC9CUG5VRitwc2V0OGpXenNyQVdyQWhYQmFveUV5?=
 =?utf-8?B?dUlUc3hTSUFqd0UzaFUzTW15M2lMTjBoYW0vZjk3bk4zalNQZGp6cVpyV2RB?=
 =?utf-8?B?L0VWbjBEMkgyblZxT05nVzd0OWdTVi9XTGdscUpabmVkSW4wSmZXUHNabDZm?=
 =?utf-8?B?M0dhZTU1U0M1aHVxMXVneXBMZFlJb1VoNC9yTUwvMHBNQWNkZTRWTE9rOVNI?=
 =?utf-8?Q?OPwYfNL+VtZND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXk5ZlVJa0RDcWk4ZUEyTDdYb1lHeEFJT2Vtb0NlWWc1VmltcnY2TlhCbWU5?=
 =?utf-8?B?b24wRHp0SVlrazdtbEMrbXRwOW83ei81ZFJLbDB1YTk1aUEraGlFM1R2Q1J5?=
 =?utf-8?B?eFNXMFk4SlErUjRXTDcxaUVSYVV3QndRQ0JVOU04anQvOGFwRzZETVd0K004?=
 =?utf-8?B?Z0FqZXMzeTVzSE5pSkNXaE1saTdiSjJaYnYvMG40Z1l0NG8vQXhNcUM2RS95?=
 =?utf-8?B?SjRyOUVIam5qSGtvQ3ZHSHplNEhyWVhwZUg3UGZUWnBRREJKNDF2QzFhUW4w?=
 =?utf-8?B?L1JyWWdzSU1WeG9FUDhoWXREWW4vdDFuYnNmaTNoQ3lyRFBCVzNOdHhkUEd0?=
 =?utf-8?B?Tm92RlRuMmZ0cjJ2VmwwS2t1UkM4ajV4VDlGSXRFK3p1OWFYSXh0R0ZOOEo4?=
 =?utf-8?B?RVlrNU1DZ3VNRSs5djdrbFVJUEhmekd4WG45YlJ0WmtBdS8rcGlDWXl4dUc4?=
 =?utf-8?B?RzIzb0hrbVJZQjYyRGE2RVVrRVVvekdBbktCV2VIaDJxVE4rcHh4T3BSK2dm?=
 =?utf-8?B?ODhudm1kTHlmenh2OFBHeWE2c01EbVpWcW00eFZMc0YxQzlvYlRhNm5RMk1T?=
 =?utf-8?B?MnhJWUNLenI2YkdyaEQzUVQvQlh1UmYxUGk4UlliMjArbmkrT0RlWnZ0eTRs?=
 =?utf-8?B?b0ZRNlRHVmdGMEFWT21wL3FPeHUyWFNpT0pZSHlleDU5RWoxUHp2UFJGb0t6?=
 =?utf-8?B?NkNYYTVnWU9WVlIzUHFyTEFQc0lJVThiZTBtUGptMjYxd2hmenBmVXVFTlpx?=
 =?utf-8?B?TzY0UFRPbHp6SVREekZQVEJURGNFdlFnRzRyRFNGOHU4M01VYWN4Ykx4dlR3?=
 =?utf-8?B?MGE1MzJSTmRKaE1pQlFRYjBPenV2aDE2TGFKb3M1Tm9DbCtqb2xHdzY5b0Yy?=
 =?utf-8?B?cEROcGM2NXJmVm14UUpuN3Qvb1JadjBVQXhCWkpidTZqRTNoaFBqYzFlQUpO?=
 =?utf-8?B?WkcxYmpDbHo5ZnlRTGpwdmxoTExJak1Xd2lXWFlVU3NQUWtlS2tnK2cxcjhl?=
 =?utf-8?B?d3JJbTlCTk0rNHl4UmNnOVNjZ2tWbDRSaDM4SlpIbDgrMGd6cDVOdzM3enJ6?=
 =?utf-8?B?YjVReVhpVXFiN3crZHZIMEFCSFEzRTNMLy9XYXdTb2xWV1E5dzdOZUtmS091?=
 =?utf-8?B?a3lFYWJZaEJCYjZ1L2t2bDdGNlpWbGNubVNIaXJSRU9UYjY0cWVjUW1rUHpr?=
 =?utf-8?B?UllFdXJ1VzlJQmpYQVlVUzNxczdEakFwdnlxMnFwQ0NlQWJkbVM1d1dLaWNw?=
 =?utf-8?B?UmNrdHQvU1c4czdiVnB2bktRcmhWOWZqZkJ4RTlJbVBxTVFpZGZHYmVKZ2l4?=
 =?utf-8?B?NXhFUnVjUDA3U1JDR2U1QkdHTlZ4M2pnL3ZRbDRwWUVWam9uc1RmdzQ1NWFu?=
 =?utf-8?B?M1YzZEcxK0xTQVdYSklIdk1mZW9TYjNFRFk5YWt2dm9TZWFVRmptY2NydE5k?=
 =?utf-8?B?enhEcHh6d3luM3ZuQmk2d2hMdUxTazZBOCs2enhySmUvWVRFTTNUYURHQjhZ?=
 =?utf-8?B?MFhRcmtZSmRISStTUStJVWNDKytvR0gySlgvdmtEcWlVVjh0SjkxNlhXaGRB?=
 =?utf-8?B?bEt2b1pTaXZoVEtESUh1bU14SzRaeVZ3WEtVTDk4SFJNYkVYK3NMaGRiOG0w?=
 =?utf-8?B?WUNqekI1Z2p1L2NSMG5QVXI3NXE1MXhrRTBSLzZleWZEL1lEci80QlhQa1kx?=
 =?utf-8?B?clNmZHV3Z0x6dUFzZkg2azZoWDVBTGhRZlFTY0szU1czb1Q3N2t4Sy9Id3hJ?=
 =?utf-8?B?eXI3d2VjR1l5aWZNTE5XMUgvakpXM2ZuTG51WGlQMVFraG45WTFYL0IvYVZ6?=
 =?utf-8?B?OUJXS2NJQjl0bTVJUC9RZjkyU0p0RGJRQmhQSmZjVUorTHdkQ1RpLzBTVXVI?=
 =?utf-8?B?QlRINkEwWUtPS3ZnRUlHOGRhVHhyc3RwaUlmOStVeHIzalo5MzRaaXR1ZXRY?=
 =?utf-8?B?aXNvSnptVHp4cjhiL3BZaXJiRnRTeFpQdFZ4N29RbFlwVERRdHRhSlJyNGhj?=
 =?utf-8?B?c1A5amh4dVc1ZlFOQUVoSDQ3Qys4Kzl2SE0rd0xPQUN5VWpKV1hocDZhY3FI?=
 =?utf-8?B?SHBGeFVQWWJUUU1Ia2ZuUFE1YVR1WDYxQ1dFbGwrd0RhU2lxNnJ5b1pja09E?=
 =?utf-8?B?K2hxSnN3VDQzYmRHMDMwd3dzVGhaVXdBenhxU0IwSUY4TWJ0bmJCNHhrYm13?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ade98f-d65c-48ee-4758-08dd54f28b9c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:44:45.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei9htNx5mzkn/AYvUZb6VihUJAsI1e8gBFfoqjc89BYsBvXZHFHPAwVSJ2ME2g2NmvES4eiPfZ4g0FJX6V1b9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7146

From: Jan Kiszka <jan.kiszka@siemens.com>

This function is called in case paravirtual IPIs of a KVM host are used.
Just like for hard submission handlers, we need to harden the path to
avoid splashes like these:

 IRQ pipeline: some code running in oob context 'Xenomai'
               called an in-band only routine
 CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
 IRQ stage: Xenomai
 Call Trace:
  dump_stack+0x84/0x9c
  inband_irq_save+0xa/0x30
  __send_ipi_mask+0x81/0x260
  ? preempt_count_sub+0x96/0xe0
  ? _raw_spin_unlock_irq+0x33/0x50
  ? xnsched_pick_next+0xe0/0xe0
  ? ___xnsched_run+0x491/0x5b0
  ? ktime_get_mono_fast_ns+0x50/0xb0
  ___xnsched_run+0x491/0x5b0
  run_oob_call+0x97/0x170
  xnthread_start+0x23f/0x330
  ? rt_stack_deliver+0x340/0x340 [rtnet]
  rtdm_task_init.part.14+0x7e/0xc0

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5df1061fc6ee1..b183caf41aa44 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 	if (cpumask_empty(mask))
 		return;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	switch (vector) {
 	default:
@@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 			  ret);
 	}
 
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
-- 
2.43.0
