Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69593F0A8F
	for <xenomai@lists.linux.dev>; Fri, 15 May 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833005; cv=fail; b=e7Y1VmyJWxPbFaOY0DoAl3IFsIg+bfFd1RUCBMMOsKclK2dcZnEIYVpk5jGc15B9c0NMJIVo17UD+Mo4J4ouBsSuvOMT4oDS9oARZP59/PzHPrhuhQa9ioMNGV4w8srCmN3V6e5aQn66ppODMO9kCuRxLe/hX5FrCzc7q8GLRls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833005; c=relaxed/simple;
	bh=E/gRY64twxx6/rKrLqsJdmVdtwLKx5C0IKiBNXE6IxE=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=n8tbaltgpf+PCeWhhar9iEFq7hApgs5xXkT+bZ8FMz1iKETRxVNwTI/BhsM6gmR46OpVU+e+XOqgW1QxoGtIHJhWttQUD7W/CfG8BRIy8ZoUqpK2dEJy4+QwLW0XaTt0nrUsF0Mzco+xrnPYpAV/EqlyOTPAQwaBR9sdUcw1tm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uOmTDEb5; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uOmTDEb5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtTARfwtXkm3+sBoIyw7mf4fL6IZSVxxnJNHXvne9VWxLvRqmlkZ5jP0Lt7fuVbTk5XtmggWhLO6KGWY27FoG8OyblKwPRUNiw97BW+k0elqU+5rDuPjPlPu95QlGhOSMEqwqar6zo6Xv8rdFLNV32GEkzIHr0jyZj+AAsQ7pp5meytouDVKq/yS7IAFokfMS0IHoKhZuy+QcyQpSHS7Rfn5tdpuO5zs6EwjfZ8cZq88FyaNRIXSE6jAWWtQDNBatuhH01xyMLnh9RnLmXonQOpYYB+gUIwN+zMGswRBlESXGrlBhGjPmT2fze4xE6taFbnOK2d43ipUiMn70WFBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VTL4pV0HtKD6eKs+ph1HWXY2cs72gDNRke0sEDI/tE=;
 b=qZaAqYAVwhc3LPRVUUoR4sa4+FXeV85WDZlF3KPfEjsGnqxmJfy7XF2kAzPIAa/xHNEoEQkoePQhpA0+HY/rT4BxX3zk6/PpfBylObx6aswHM9Ftts++PG8b5OxFQLS0Hlj+937VO9bTHrvXKoHiNMxE5hXtkrZB72h8nyEfBTK8DPl3XypR/c7bBqrceAQxrd4y1xcLyFJQGSgO7b19+EJDYS+I4168drXAmXt1yrkYWQNkfntllvgY8azTaob5CCaXKbtTS25faNPBx7XLDhYRSRtSdv9RcPA7kj8KgnFeraf5w15GtLWYeJs64fK5OosBRaFh/irmY0mepMgoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VTL4pV0HtKD6eKs+ph1HWXY2cs72gDNRke0sEDI/tE=;
 b=uOmTDEb5Gktz7VWAgXFbUkyqu3GcpJ0hNNRNvFgLXlMLoi/Xg5Aj5dalaXaYNKJGBfsfLyzl2gKRuos/+tZTFd9Mo3HuLgNrMjkvKOASZFleNQyaq1+72r1vuirNW//7pjECDvxgCj1lHsT49tbFVY319FiYR6Jq5SrjsFgAhclbe5Xe98x9TqMDC5jrmh6Nvl8k/+YX4B/w788QMHQehar4NBtYn3/6ihDbBKX2W3/wiySEi+jvj81fW0O3kZX3UP3WIocCmZzOEwrR4sfyLsSvqnyIzAbbCvXYSAH5ggZ4AaB+4Jhr6EZBMvCySGsa3WRu1qDdTpfTwloMDoM18w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Fri, 15 May
 2026 08:16:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 08:16:39 +0000
Message-ID: <fef0a9fd-c06d-4673-bb62-200dab5ae853@siemens.com>
Date: Fri, 15 May 2026 10:16:39 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 2/2] kernel/cobalt/thread: Confine condition for sending
 SIGSHADOW on xnthread_suspend
Content-Language: en-US
Cc: Richard Weinberger <richard@nod.at>, Philippe Gerum <rpm@xenomai.org>
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
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 90105ee1-0656-4fa8-c5ba-08deb25a4a4c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	93rhSdOEFDgUzawJ1hTEeHXJEqFYj7AELrabZ0gxmtyrZ16QHCZsqe+TjJJH8ZTtfHJFo5ADjGBa2UXUVmlFTvtZOzbRdKgqFxg0kagwpaqMCGZ8feJVFry9ZWhI+ll5f/6xMgfgOcijUvCqJCTtSdtSnGCByZcS0uEVfJb7wVOPtt9DsrvgIffdgu5vlWz68S85bb5w9s+dnUDTEleW7HsDwmdQGvxCmHcj42O6Y+ZwNQPoJTXoRpNgDjZgmfEs2Awww0wYJgCdKQ+9cwiSswL4l6i2w3PXMkdJB3bWINDKtaD3nj3gXG1zXUjS4gNhRPRSVrzi61IkVbpro9QZnNzEUPte/zJUK4jEaiZf364gOS5bRm9HqVsRoYKsox8q16FWdKPvbdY2+Fy3gogSx2PuUXJwfR9SGmzPlN1MhesfYDBUZGnNJG5JA9OFU9y/18yf+tAD1YRigjQs6ROZGAkxQZJkCXM5EaxKJFTCuCMgMVe4lsjLL5p0nG9Yi4m7NeTCT12zD5SuEzEgs6JSR26MnsmBewM6G86pDmKrAgw3k56C4cqzFu4J0BnfRPgZcAagqiS8hPn3qgaUpbq0XEz09KQrFf9ZXh8CRen02MX1oCsPLmVSL+HGq+So/QVcP9l0dZCigbT2VM1r1m0GCiUn1AQM8y23lI4pGvLIMg38oOOoGYH6vmbTonzXmGSb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emJjeE5SNENScmMyRUd1cW5wYk45QWhremV2dmFSOFJkYmhpSEZTUzl4eHJG?=
 =?utf-8?B?TmJlZ3RuZDdnUkhJUWNlQ3BPNkI5ekRSbkVkUkdocDFnU0xsdUtPU29HMUVB?=
 =?utf-8?B?WFU1SE9KSTdiK0xBdzRtVEdKdFNWYlQxRndvWThSVzZ2WXF4RnFJVXpMY3Y5?=
 =?utf-8?B?ZkxsQlBrRVpWTUN1c0R1Tyt4ajhjYzBQNEJKZUszQTczaUZSK21qS3YvUnpz?=
 =?utf-8?B?Rmx0a01QZnBkU0I2S0NmREVzck9qSzF5WmluVHJjUVZWSW1MNXF6cTRvZkJC?=
 =?utf-8?B?VWxRUzBEUS9uV0hSamJ1SFpETDB5UUp4aGg3TnVhcG1iQWpYZ1hTVmlUMVQ3?=
 =?utf-8?B?UjJ2Rmoxa3VtN1g3bmZYVWltcUEzWHBNamV1Qm90SEF0ZitqQWNBN2xhaWpQ?=
 =?utf-8?B?dFpXejhsY2ZObHFoWDFtMSs1MnU1djJqM0VscEg5ZVdaUnZhY3V2VnUvVURi?=
 =?utf-8?B?R2x6U3ZxbW1pbFFLMTVlUlFMRWZ4RXRzK09FL3F6b0JPNnMxeUJ5bUdmSzNl?=
 =?utf-8?B?c0Q5TG9ITkppOHd0dlBGWXB4TDNlc2M3YUlCSnVNZkpQM1ZFeDB1d2dGQzVa?=
 =?utf-8?B?dnVBSG1XN1d5amlKSE5MU1FTaDJjUkViYjg3MXJIMUd1djdvOUdlSmJyU3Nu?=
 =?utf-8?B?M3M0dFI3UStCdlFsb3llVG40K0E2Nk4vb2U1UEhmeTROMURpem1HSEkwV1dM?=
 =?utf-8?B?b2ZuUG9QMlMvVElvS01NVkl4bWczdjh5NVc0MGxXc1dQSXl3bk0xL3YvL1hK?=
 =?utf-8?B?aXdZTVArV3N6ZDZya1ZaUklkUDN2VkFIbGFrNVZWaTk1bDE2Y2plWVVoa09a?=
 =?utf-8?B?VEFVYThSN1BjZ0dEVDhOajRJRnVsYjczT1VPR0ZYMzVjOEg5UWVoanpJRk42?=
 =?utf-8?B?V3UwanlSV2gwZ24xc1JOTERTRHFTVDVpT2Z3WjFzQmxXWHVyVlNFSGFoeVE1?=
 =?utf-8?B?SDlkellJOW1uaEFYNkRYdCthdmVIQ2k3Ky9KZ3NlTG5aVFZrOEo1U2pSMVBm?=
 =?utf-8?B?L2tiWUEyYWhmWmhpWk12aVRRbzM3M2hPSWtVaVhzWjRuS3U5YitxS2FNZzlQ?=
 =?utf-8?B?ZkdpUG5SdVRXVyt0RE9nUU84NjEvZ09oN1ZSRC9TY1hoaDVUa2JGVCt0NVFq?=
 =?utf-8?B?OWdZTVEyT0YzT1NOQnVwRkNEMmpMc1VqUTd1cm5PNEZTYVhnZWpNRlRsNHU1?=
 =?utf-8?B?a3NuL3l6STdNRyt3MHFJUjE3OXJpNmlaNzFzeURKYVl3S3lkVkhnU29HSFhr?=
 =?utf-8?B?b3ZoT2h4WW9rbzFhNUpwN2xvRHJoV3VyWkJWa3poYkhIdHhKa1M1VDN3amhO?=
 =?utf-8?B?RFhRZEFHVkVJTDVxN0tPZCtVRC8xK2RKOWl4ZmxqTHV2MEdrL1pNYXZuRkpC?=
 =?utf-8?B?Y3I1UHlJVTV1Ynd2NHk5TjkwUllTeGt0bW5mWnhCRWNUaWFBdHZqeW5qbFpF?=
 =?utf-8?B?SVZDdkdZYU5ZS3RjVlJLbVg2Q3haVVRuZ0czV2h3bnFiY0xqZGl3UEY0ZDFa?=
 =?utf-8?B?SjlkOG5CWkVpc1pBYmY5ZmJNZDkvSkxpTHFHTTlESVJUZUxEYVQ3N1BjVGNp?=
 =?utf-8?B?MFhEaWJwa1VraGIzT3U3RXcxbDlvZ1phMC9LL3o3UTVzTEF3Y2FScGFPUTNv?=
 =?utf-8?B?VkxPOExKMGRmVGhDLzZ2ZHpPSnVLdjRUd0NnRHRUTW1mNW5NUGIwQ3BWSi9K?=
 =?utf-8?B?R3BMT0ZmSnN4NnkwdEtoTzNQRWxjOEpQajdLNDhQR1E4RFFQZHhWVXAvN2tG?=
 =?utf-8?B?a2R1TTFWWkJ2QWpCUVJ2V01nSlZrdGZtQ080Y2g3MFBUVGtXTU9ZcU9YYVV4?=
 =?utf-8?B?SkQ2R2xIZ2ZUdk84Qkw1TVF0MlliWjlzZmdzaTZjY3phRHRSb2lkdVkzR0pa?=
 =?utf-8?B?TFU0bXdGQmFrUFZyeWRCNGdvZGhWdUpabUloUzFhT283bEZpZmswcU9RUVVH?=
 =?utf-8?B?T2U0Y0J6YVhLVlU0eUpielN4TUVTOW91Ly9VSXhuQUo4bVRsVEJFMVFSR1lN?=
 =?utf-8?B?eVlPbXBUQXZZbXlWOWlHZTRrTVpveTFXSHBLWmRDSEZtTmJzTEtDNkZJdGlS?=
 =?utf-8?B?N2xrNlN1cWVJUFg0cDBKcTUwV24zRmwwelR5R2FKTnRXNE82andzZ0JuSytM?=
 =?utf-8?B?OER2eGcrUHFUNWpodnJRUkpsL0tSTEVoakR0VUcvZkZjMmZ5VlorK3ZzVmFu?=
 =?utf-8?B?c0xRK2FvWnI2aWIwRWlORitBdXBkVW5xcGdTWW9lMTBHZm1JYXRnWTM1Qm1k?=
 =?utf-8?B?NHFWeVpnY1JYY3JOQVdTMjQrcU0wTDA4RmZkQWxhRHFFL0xhalp6NHNOZlhp?=
 =?utf-8?B?WDkybFI3VUdNMFVDaVdBVGdlNlZNNDU1OWZ5V3RyVUdIUjc5aTlFQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90105ee1-0656-4fa8-c5ba-08deb25a4a4c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:16:39.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiZR7ylmXrgGLxjt3TVo6WYLu74XxBA2Q8Fh7sZ9XW/xWwtdxVy8ydUjgS/SboXO1kqt7ngClwnjl5sjLbhavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9421

From: Jan Kiszka <jan.kiszka@siemens.com>

In fact, XNDELAY is only self-applied. Drop it from the condition set
and also fix the comment explaining this as well as some other bits.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index b605781c64..5626e7655f 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -996,7 +996,7 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 * assumptions regarding suspended threads.
 	 *
 	 * We only care for threads that are not current, and for
-	 * XNSUSP, XNDELAY, XNDORMANT and XNHELD conditions, because:
+	 * XNSUSP and XNHELD conditions, because:
 	 *
 	 * - There is no point in dealing with a relaxed thread which
 	 * is current, since personalities have to ask for primary
@@ -1005,15 +1005,15 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 *
 	 * - among all blocking bits (XNTHREAD_BLOCK_BITS), only
 	 * XNSUSP, XNDELAY, XNHELD and XNDBGSTOP may be applied by the
-	 * current thread to a non-current thread. XNPEND is always
-	 * added by the caller to its own state, XNMIGRATE, XNRELAX
-	 * and XNDBGSTOP have special semantics escaping this issue.
+	 * current thread to a non-current thread. XNPEND, XNDELAY and
+	 * XNDORMANT are always added by the caller to its own state,
+	 * XNMIGRATE, XNRELAX and XNDBGSTOP have special semantics escaping this issue.
 	 *
 	 * We don't signal threads which are already in a dormant
 	 * state, since they are suspended by definition.
 	 */
 	if (((oldstate & (XNTHREAD_BLOCK_BITS|XNUSER)) == (XNRELAX|XNUSER)) &&
-	    (mask & (XNDELAY | XNSUSP | XNHELD)) != 0) {
+	    (mask & (XNSUSP | XNHELD)) != 0) {
 		if (mask & XNSUSP)
 			xnthread_set_info(thread, XNPNDSUSP);
 		if (mask & XNHELD)
-- 
2.47.3
