Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF084DF1
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050927; cv=fail; b=HSAAzi20/FBUm5tDYmNkj2V0gpKNble9PHmyqHGihoJKauK9rbD3HU7+tF82a0Lu9YlASTDKbK/nxhmblvQkzOPSmhZAZ1h2dt2yCxz08XXfSC+lbUYrEVe65RPXxlX1tZe/HH5aD8IeApjtLY85nzED4APvl0BctuG/roAjdQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050927; c=relaxed/simple;
	bh=ja+dFd5725sUpixaD1SuGGiFbVD2K5jyxVpW2xeWhAE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BXiIqWyQeEdL8zbmtTIAka1EXqZK+x1j/P6+gWoLKd8w3qJXb3fVTbnDel7N+5FndmQPn4isk34QzDq1JaN4Q/JfLlxbDNgBVWcG4RhCwuk+3zB58FMcGsL1xaIYPV1f9UhJJ7+fqg3nP06aRpDG1EEJV6XuMHQmYWlVkSdLCTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fE9OiukV; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fE9OiukV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRxD7cay+Qta6+fPQNC+QSPkn2qEpskQY90+8NItmP62JAicM92FOWl5tIdUiqHmeiW7lm+P+d3MvRIwmDudbKvSPsZPRsm1XVwofOcELrKVFbvI4siMLC5PANH0l4oiOJG65zBrb+slAoAZhqcnUQTo7jZj5Ty8fi3HPv7t1ec2AWrghwek5jEaXasinaHkHvx0Ea3EuiwW5kTCqmbOLoP5kD9MUsjJxua2WRbP+PUYuzbnhNl2eIKIkzkJ45CelBQQOMlzPD/NDVKgjerpcRSMGIvDOh9x/6YezEcgLkdJZ5MfCes7CGPTlF+oh1k7Wb215fo/bXZhouHyIbz9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgokHWU1pSkp+0cCsHSIVPJOiUsLRinCKIIgWnnUxoM=;
 b=K1xBmM2b47llCgN9+bJij2ftzTk4LgqKrMk4TEswS13o1Wvqq2x89+YHd+OLgSnUqlXkTx0e6PSlbNS6w7xFBqRlHfIt90Ae1qmfDfHI96F9CsgHRWLZ56POOs0qkijXzKoO60WuDnEOVJU1c5DoubwDExJ4KLa2trbgbXByUxu1z6yy+I75a/HvO0MxBhJRK5In/y8TKhDs9QZOdk7T0x440yRVTWmufYXg/LYJBW+Co+vdm87ilukeiZI0i6Wp/4eFepC6rMz2rJxN3DvnttStCdkvDA58YN04ZnrZHKkrVZi8bM5rvKFYLJ6JYpb8cUzmGCsZG+9DWu0SkuS5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgokHWU1pSkp+0cCsHSIVPJOiUsLRinCKIIgWnnUxoM=;
 b=fE9OiukVu9LzKFTO7ZBXmn5OJTFENBq914xjQPuk6oEGVFXfSRdowyAD//xZYQzr0Tu5H5vUV7dSPqiPeXkTJndvwJXoHGHhnAx5Uc6yf1RUg1wCnIW/E0O4xBsQ5WT6ALfs7Vyduup4giq/gR4rEFTAy/mWFtIEaUzD0ZqVjkiks+n3Jk8qpTg6vA9cz1WxSVCnpHrEOvMVI+LC7p+Cg3aK5KDgch4bWVjrAac2mmEA3hp+SwOziPTp8Qa4JQmhEwhwEDYOfDyzHsyqaczURNbkJx5S87pA17wrXLIo36N+6zCgVxsp5dANnqrd3PfX75TgA3mNaBFcjd+eFgefJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5203.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 17:15:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 17:15:20 +0000
Message-ID: <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com>
Date: Wed, 7 Aug 2024 19:15:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Thread stuck in IDDP sendto()
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
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
In-Reply-To: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 677ca104-0b2e-4fce-f173-08dcb70483e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjBnVnlPSjAzREoyQ3cvRUhLVkgxa2VkczViNS9xSnlYVnNzb3NVbkoyVEth?=
 =?utf-8?B?ZmVBeVZ2ZGZwK2pSVVNXWjIwdU1YUGh6UzI1QitnRjEwWTBrS2FKa2xYZW5G?=
 =?utf-8?B?UW9mTG9jNGRraXdlZHZDWlozQndjSGJ2eEhFRHp0RUZCbkFNaWxnMjBkU0FS?=
 =?utf-8?B?b3NMbTBycGYwQktJekhPQmZTTkNOWlQ3MjNIUzhrK2RqRFdzNGNBTktDamVu?=
 =?utf-8?B?cmZSZldQRzlUTjU4WFlQWlhUN0VsUzhvZGc5MzR4MWMyaS80azRQamlDZTJk?=
 =?utf-8?B?Y2FtMXdEQlJnOWtieWdoK3c2d2ZnZVNza2lmbG9vN01EZmhqTnlURUFGaUtJ?=
 =?utf-8?B?eHhuZGtNeXUzaWRxN25uRDRFQVBxZXBLNVEyRXl0bjE3K3pCc1YraDlHMktm?=
 =?utf-8?B?Y3ZrWlN2RmY5d2JqUnZYSWJ4M3RVWVpnbGxEMTZnajNGWnZXRlRrZTh5Rlcw?=
 =?utf-8?B?NUhLK2pscVIxa21Gc0JFelJmVFY3Uk1QdWRlL1FNdE5XQ2VTbXljS24zRkpU?=
 =?utf-8?B?cGtFZkx3bG5UWkIrZjhIYzNRK2pDMTVXdTlsSlhja1JCTlJ2a0Q1VFRabkRE?=
 =?utf-8?B?VUgzSVU5REhtZkU0anFYdXRPc2dERitvVHRzaDJORU9mWmVMTmRUdFMyRjBY?=
 =?utf-8?B?M0dVWWQ3QllRWjJuTkhKeTNzYzQ1YXgrd3Y2Q3dkOHg1OGF5Zkc0a0VtK2Vt?=
 =?utf-8?B?VFAyd3E5WUhoR0NZaTk3UFpRczV3NlQwaXlxdFIvN2lKSVVNOElPYk1Ca0Zt?=
 =?utf-8?B?NmNIUTB3d2lXWFR6Q1dpdUVUQ3cwWWlacTVLNlZNTUVnZ3JqVkpFdmJoZlRi?=
 =?utf-8?B?cDJzZGJLWmpndlEvSjliQmdlT2hkdTBjSXk5YjN1MytiNVh1THU5SDA0dmhj?=
 =?utf-8?B?S1pkU1BUWmJhREhHSXJTTDZnWllCbUQvbEdHT3hHSFkweWtrMlV3cTBkM08r?=
 =?utf-8?B?UEh2ZEpoU0svMXlpT1RIL2ZPUExGYWRKcldxUW16UldjWUk1V1VSdVl2TTB5?=
 =?utf-8?B?ZlArK2ZFMml4ZWZ2ZE9tRktCZUhwWG13WlZpUUVMQy9QbDhjczJzN1BkbGtp?=
 =?utf-8?B?L2xvS0cyOXc0eWxBQnIzZ2NCYWp0dTc2eDRrcGZMREZ0NVJvTzlZQS91bzBU?=
 =?utf-8?B?eEcvdXppeW53dGRoWkhxY3JxTUJaZEF2UGV6R1NqOTVYVnJ6ak1ncDhwQTJx?=
 =?utf-8?B?aW1sWmVwdFZWMy9QdVhodG9vMXUvTFF1NkFRZ3hqUnY2VTQ3QytkRHBVeXEr?=
 =?utf-8?B?SDhQNVcwSWwxRGhWc1EzUGlSM1NRa1JPOEdtcnMya3Z1cjkzdjZuZld6TkpI?=
 =?utf-8?B?QjVoSU4xaGJNeXJ2NmFORFVPalZhVWk0amI3b0Y5bDVMNnFyeEg2eE1adHN3?=
 =?utf-8?B?anFjYUFNRWdVZVVxa1hKQ0J6WU12QlU1QWx1cDRJVm1jT2xFUEZNY1FLMDRF?=
 =?utf-8?B?TUw4aGh1b08rejVLUWx0YlFTRDFMS0ZYZDFRU24zZkF5c2pVQXgwN0d0dDcy?=
 =?utf-8?B?Z2JBK1cyeGxRU2lMaUZqeVRjS0Q1OFczWU5jN0NxanNIRmx2OVY4WDRxaklx?=
 =?utf-8?B?MHlxUFdldjE2V3ZGU2pwNjYrdHZYQVk2aGRzanQ5RmNmVmdZNHNlQTNqUDcz?=
 =?utf-8?B?dmp1T2JOVlJqQXhXMU9nVjRzTTJ2MHY2QW1mdlU0STVjdy90QnBRcVd4Ykl6?=
 =?utf-8?B?NjdxalFnSWtEdDY3UGtqV1pUUnVOc1ptVkJYQlNMRENBMTNqSnM0V0RzSjF6?=
 =?utf-8?B?alJseEZEWWc5Um9QNDhiT0Y0emtVakl3bmd4NmY5elZwQjdEYUp6MjY5UHhl?=
 =?utf-8?B?UnhrRU1tYXBreGorN1RnUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zmg1eExOUXVnVFQvNisxb0FRWVJKeVFsekhseFNkVUlSTDFLZ0I0ZlR3U1RL?=
 =?utf-8?B?YU1CVThiTVRvZkZ6akxlTjlVSU0rUzVpMlRRcndJRlhMeE9QakR3STNqd3dZ?=
 =?utf-8?B?a2pTdUlrRWNnV0FGL2lWR1FpT25kNVplYlV3Qlh6dXdhb0hPRXdweXAySzRw?=
 =?utf-8?B?UTlJaGE3L0NieUVrclEyNEJRUStZMXBMaWRUTGsvazhSOHpzam1jd0pxdUxa?=
 =?utf-8?B?N3dyQ1I5S051eFdxZ29iWHphRDlxbzVJczFRTVdSeGpVRVlUSkxmd2xXZ3JK?=
 =?utf-8?B?Q09NK2pDNHQxaEYrUk5lT2UyaHlnRHlEVjBlSXNFNTBQNkNyVkczN1M5Mm5B?=
 =?utf-8?B?RWk3SGRjR3ByNGJBbXZ4eEhrK244KzhyZ1N3S0lXZVRIU2ZBcWNTVjNhTExJ?=
 =?utf-8?B?M1p3dGx6UVcrajRjTW81QlBCZ0ErbTFoZVZVL1pYTEZROWNXdkpqbnRJL2tL?=
 =?utf-8?B?Yk9NRCtncld1VkRXSFlmVUpTUDdtSEhvMFFPd1J0U05EN1I1L2E5M24wNWJl?=
 =?utf-8?B?M3NUMHVwMFRKYlBXQ053cHcyaXJHWnJ5aklpT0JIMlg4Q2YxNzR1UmQ5UDd0?=
 =?utf-8?B?TW5aa2hPMERXUXp5TkhzVk0zOFcyWEFadUE5RnBFNUpSSXFXNU5MNnVRSkc2?=
 =?utf-8?B?QzlLQTZDWnc2UW1qRlRCV3o0M0ozazBkaEtOZEZreDVTakk2cUx4Z2Iza0RL?=
 =?utf-8?B?Z2ZLSVBWaitXRU5HQmw0bm1iSVJMOEtDYnkvV0p1K3hiOGFDekJkcHVNeC9E?=
 =?utf-8?B?Zi92Rko5TTY1N2l1S1dyaDFLWVl0bG5FbktoUVBNdERNdllRUkU5eEdhelN1?=
 =?utf-8?B?T1U2a2FQTkhaamJPdmgwWkozOWUxTkFNNForRTcyem51bmV3Sk5URks0L3pX?=
 =?utf-8?B?T0g0SFFxYzJpNU8wRExKNmp3cktSajJYNlF4dlpabHd0QkRjamhYQWk0QUhr?=
 =?utf-8?B?cTk1Um5tUS9qZXZJangzS1VzN3JYcDM5NWpENGg2MTVJK3E4RHVabkxFdjMr?=
 =?utf-8?B?K3ZxbWxSb01sbHkzVXlMZjlTVTBxSFZWZ0VCNk9VKzdFTCtzSmw0cHdpSUxG?=
 =?utf-8?B?dFF1RE9vRW9XcGZZMU9nU0tjdHcxdnJ4ajBGK25vNnVXM2xqcDNvdUNwK3Rr?=
 =?utf-8?B?emRudk4zNXRrekZ6ZzFZeVpZajZKR2lXN2VIeHR6VTVUeHFpYktIenNwbU94?=
 =?utf-8?B?QzlXRUhEUFlPM2N6MU56ZXk2UGFJRXdOZnVTUWdOeWd5b2d4a0JMakY4Ymlx?=
 =?utf-8?B?a0p6Z05qOWIvem5vWmFMVkcrS09GcVczT1FQUXZqQ2o0cFIxU1dINTRmTEV3?=
 =?utf-8?B?T0lEbTV0bjdnTCtsQ1Z0ZGVGcXFDVnYzd2IxM0NTNFc0blVaa2NMTXc1RTZp?=
 =?utf-8?B?OU1LSXcyMTB1OEFZWEYzdmhlMnp1Ukh0MFl5QktjeUtvUTh5cE05czRoK3Rm?=
 =?utf-8?B?UDRzZ2F6eTZiRjhnd0hQbFJPRmNyUWI2YVQ0M0NFaG9zamVZdDR4QVJ2Z09n?=
 =?utf-8?B?WDAyRUE2VC9NVDhIeU1uQWw5TmNtRzJzKzQwQk9xT1ZZU21idGJyTmpXblBZ?=
 =?utf-8?B?c1hXeVVYTTJveEJ0UzVrTFU3ZmQ4MGFhU0t0UThPVzlMM013MDR1ODR6TDR6?=
 =?utf-8?B?NldtNUorcnR4U0t2dDVid2l0NzUzSGJLUGRKSkJsM0dQTGNXTlJnVzNWNEho?=
 =?utf-8?B?QmtTRGo4c2E2aXFYdEEvbmJVc09xa25rWlFOZXVFUXd6TmozWkhXYTg3a1p6?=
 =?utf-8?B?eDlFbitISjJQSE9UZEdubDhPTjY5dDdPWG9WU05iWFh1SzBra3YzUHJFeHR1?=
 =?utf-8?B?ZGNuajVpRHlYNDJXd2l3Z2xORVc0SmRuMEE3MThiTTNzK3NrdnNLVk5wMVMv?=
 =?utf-8?B?SCs5amY2MnY0RzdSZVk2VXJGYWZNV3BLVlZxVm5FTm9IZUF3am5UNWsyQWkv?=
 =?utf-8?B?UlFqZEJsdnBCOS8xSXRMenAzYmxNZU5Zc0NDcUpOL1pQbUZiOFVINjgxd1B0?=
 =?utf-8?B?TmRYVW5rYXdzbFhhcU5IS3I2RmxsM2hPTGVXTTR5VUJOVmNIeHJ2MmF0cDJX?=
 =?utf-8?B?OWlZN1ZQWG1kdVEwVVp0RmQ3ZGNJRWZrSlZPUXZMUkNnRm1jSm1rUlNEV3dG?=
 =?utf-8?B?dzZLelVJLy9ub3hScTAwQUp1RHJvYWoxU1NSSTlzQ01TNDRJTzB0NVBWZDR5?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677ca104-0b2e-4fce-f173-08dcb70483e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 17:15:20.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+JS5T0ZlyrUryG3w+FPBTm4BPrk3eF0lGPQZ6cczrMU5H0bBGs8arkJElaH0Q7D69yZznRKV/rbWtmxTwddpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5203

On 07.08.24 18:11, Richard Weinberger wrote:
> Hi!
> 
> I see a Xenomai 3.1 (yes, yes...) application hang in an sendto() on a
> IDDP socket.
> The problem is hard to reproduce and I don't have it on my desk, so I
> have only limited
> data.
> It seems to block on __iddp_alloc_mbuf().
> What I know that the reprieving thread is gone.
> 
> For reasons I don't understand yet, the following code does not
> terminate with -EIDRM:
> ret = rtdm_timedwait_locked(sk->poolwaitq, timeout, &timeout_seq);
> 
> rtdm_waitqueue_unlock(sk->poolwaitq, s);
>                                                           if
> (unlikely(ret == -EIDRM))
>                                                                    ret
> = -ECONNRESET;
> 
> Does this ring a bell?
> 

Are you sure rtdm_waitqueue_destroy() was called at that point, ie. the
socket was fully closed?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

