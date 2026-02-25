Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACDA395DBB
	for <xenomai@lists.linux.dev>; Wed, 25 Feb 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046496; cv=fail; b=M1du8ZP/9knwkEbV11Opahe2MlFJXHd7T66k95nJjNg7KQWMSuPHUlISGFdkFSfux5x8rF9MEn1P638oUIq8ja2a+Z9OelEE85vB81qarVZOPXyoOQbRD+ZNMu8gLQF5A8Oo0bWOuwA+rhfVcCPbhM45uQg3ap63wMM6re0At4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046496; c=relaxed/simple;
	bh=Ld8Jei6cUgas3Y1zdgAbnkJ8ujZat/B3SqlSeAG3Nmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EWbutTXLuHSRqo9JaMW8Znd/EUd1rBUgkG68xCY7h+rsTYtGXTt5dfPUD8hShRsbhOlcSMr3/FP3aC6efOCvJyuZgAa5FeWtGt6dFTXsQz8PI1Ozw3q2VwkjlUyeK9Pjt53b5j6gftVbIN6Do8VOEgyrmOd7ozwt5BnB8yJooQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oHyM71vp; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oHyM71vp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyTKDUSrVLAq55rDDGbt2A6VxjRW8LxBRPS86EAHjnfWF1yuMLGXHscL5DTrZADQa71zQ4U27BtXlKVHu2fBYwm+91i9pTW83vHY/dWqYVyHRusR3iL/G1C4S/Jz3v2aZk5wF6FIBQekISKdwjwd5BW3cFRWARKXpdUPVYa5M6NUc7V3pYec1V/5uFS7ZSxpsjV4RxLjuHYxxtO+3ZySY5QIRGeY65+Cpx1DZ5g1OZBk5ptDMwco21vXvl2R5NfZRyuZbfVlo0rWfxTgb69igfsIjMFICewHnlDyWxrbldozzAS0SYwQ4SoZNgxPJt+fIRYq7x/rVVBhNwjCYuYfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbFjd6lsotTHYmc/uzlzbiQn+NwkiKl/oUaKUlfn7B8=;
 b=wapxazAgXyuaYGBnciSzsz19XEDRTEZC/kALWpOwxxtjuIYSfR0vms0jTF4pimYYhIZvLTnYqnsJV4d97ca/15lHO3czsTHrNR1dvPx5eZqJHEbBfFYSdKk2LyYBKotTThL69KgFd+YnF1pKh7CxFoJ5l5MQXeFK/81IZkiiBMzI045d+tM+vlvZ6uDh/FQuxvjwQh5PyNpe6FwAabCIC1Wzuhh63uE8fwZSXgQERzMVnorFrbNGvbzxTcX+QTDhCjGKrKeyV+IzTmUvZc03p/AEqdTXK8sRPogk+Ow1SCDDwALPRazc6zcW2z5jrDx25FoYlNffmGQKHIKY8b7wrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbFjd6lsotTHYmc/uzlzbiQn+NwkiKl/oUaKUlfn7B8=;
 b=oHyM71vpYeKMLkKnpaRWyTFVW9LHd7PNroHIlIDve2r7EGSWAGpyUWSDgH4n+ZX34ecbRCYlKBljCZX+uSrFlXt2hQMUMGsWopJHGl4wy6d0IHyegO9ZYW3bvHy19uKiS/eBgEBmt6uIn+w1/+a/+HshNVRsgJAQ5bk4dVcY9VpsSooz9saHEwKviS6/ijop+/oWYNxsKQ7ENvznTmOw/AixVWJPLl+of+V5ONJZGauwejiLUDP5pKbmpW1nzODp1Y6qpZNB2S/1Cf4DYO3xhCsyN+N2GX+BRaRtORlRHeDZvI0StmkPzP3QwbOajwu/dCe3grodv2AakydylMXcnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 19:08:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 19:08:10 +0000
Message-ID: <7861cc51-136f-447e-9bc5-ffd429049429@siemens.com>
Date: Wed, 25 Feb 2026 20:08:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
 <20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
 <cbadbf4e-0d05-476e-8d18-49436fe52868@siemens.com>
 <c2a6c8bf-0bb9-470c-81f1-bd3dd60c5f3f@siemens.com>
 <871pi8ydsa.fsf@xenomai.org>
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
In-Reply-To: <871pi8ydsa.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: efe2c735-32f5-45b2-c7b6-08de74a1378b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	SDsue51dv/pMCdIsyITh3EWLgxI3ZP5FoOehBGq0+Wn1dZwe+CMvBMTekpR9SXx9gWYN7fcpPj7QZ04QkWtUkcPiAz2ISA8c8d810w/vdNktHYTVa87VZr+KJAB94ak7sFEq3qqtFja/Mj96cc9yj08yo7nNs5+/AniZ0vIO0tMH5qFYoQtd6WDS/Juc7iRL5MypE9bJxSOrnfqFrId2JosEV1fiNv8d0v5kccBhPVsl3VFhFZfC/xo4lWq21lbepJMnJSflYY7K/3RvPzLJnNOIVA+pjAvwkhXs2vzFHJVqxxKRChfgX/1VZkeqkoeq9MgxYcAK7gN7evijdjJpIdBGfO/kM4+yWP0rFVJV9ckGbiOwS834XkaOGqf6B8ad7uWBcqT0eH7+90RJ1L9kuCIr9Mwj3JMJHUEUxdg+TkMfVOBidYWMn/kV7wmtRPNeb/jBMR8rGB0dksTrWNucCjzOMkwaDKkmnXrPrGR7vfZvY/zBAaZhWwsWNFXBci2wr4qix/2uYzgS0YDcQk1Tn0oKjdnS+PCk7T6ay0hrf8Ph9M/CrsZnVm7VVeB95NQF2Ql8QbdpU+8XN8XW7noCUtTkFDUibyroE75qk2SFSG9pbU0WdwhoYnhFnOLTFKHnXwp9xunAfmr1A+wq+w/+5UQzZy0c6J0xRtV2F+HNpf3fGyk2w2gbEEaE9b1FvDA2NNyETbykxVi4dog1BkufHwCMWzlopgyr76C4xQYJMJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWZhSGNKbkUyOC9nQzJlcTFUUVlFWXpVM01NUzFhWHhOdlZ1azBWSzFIK2h4?=
 =?utf-8?B?T2ErUC9qVmdFbWYreFI1UVI3d0JyUnJNQ1p2VVR0WmhtdC9wd2hIeWl4OGtm?=
 =?utf-8?B?K3Rua1hmb1ZnS2hsenV5WWg2d043cFNiZW9Va2RaMHJLVGpTWkdiN0s1dndG?=
 =?utf-8?B?ZUFEd1M4RkJ4ZERaeDJqVFBlL1BKMmYzYnNnYjMzMlB4YnVNQWdNb0l1dERi?=
 =?utf-8?B?a0Z4K1hhRnZKclBtMzFVZFdxTGp0MHJ0M3hiL1hSYWg4eWNSVmZVM1UzK21s?=
 =?utf-8?B?TVFWNFltWGZJbVZDWU1FL2lxWFk4WHRLY0dpRzdyMEt5SzVjTHpJUXJ6VUVS?=
 =?utf-8?B?VTlFOTFtMXU4ZnBMcEgybHJOU1lCNVJtQVJDRkxxTU5ydENYNWFuN0NUaEQ0?=
 =?utf-8?B?VVloWUwyOHVQc2VFUXhCVmNBaFNUVnpLaDd0dTh0UkZIK0JOblhSZFRIeTBF?=
 =?utf-8?B?dUEyVFFmVURDQkZXMzlFQy9NN2RWNWdFOVUzd0dPanRnYUdEcGI1M09Fd3hN?=
 =?utf-8?B?Ymg2cDhyV2FEMTAyZzB5SU1LTm9VNEJMYWRYQWs4N2RaU3ZQem9OdmIvNFVa?=
 =?utf-8?B?QlVraGw1L3hjTjVtb2JHZ3pDOXh2Wk9NVVF5OUlra25zVStSR0RnellFMWRs?=
 =?utf-8?B?Q2QvSHpIRmI2OW91eXNRY1NoZTE1bzNjZm9tbzN6T00xb1dxSnR4MVBHSGJw?=
 =?utf-8?B?VGlGQnNRT2kxTVdTSGpNYXdMcFRsekxublBaT00yd21menNnV1hIbklpWnZY?=
 =?utf-8?B?SGtiaGtRTVA0blpHVHAwRUxxTHFkM3EvcmE1djlYWlNlRFJOaVEyTi9VQXdh?=
 =?utf-8?B?aVVOeER5S1lkWVFUQkJpekVzRlBQMWdwZkNPaW9LS2RFUUhPZXhoaEFpdmFZ?=
 =?utf-8?B?TzJTNklGbXdXMVVCa3pLVUNGRE1jK3hKd25mM1ZoMmhyODJML3d4WVdJaDlO?=
 =?utf-8?B?cGc2OXZYU1hJNFZnMStvMzBVeE1CK1crbTJrOEJacmRZWGJZd0o1Sk5JUXdo?=
 =?utf-8?B?MVpwWGxDb3lVc3p1UDNqdWRUcGp4WVF2a0VYWU9WOWcwRnQxdXRpcDlSejdK?=
 =?utf-8?B?aG5BTzFwakZRYTNiMzRpZUR4ZkZ6c1RNZDdsaERLNldJMXlMYSt6SE5mUW5D?=
 =?utf-8?B?WFdvUHEyTER2UGozMTJCZzA4SGs2ZnBZRjg0U1U0UmxacHBSMS81cjVBaFlu?=
 =?utf-8?B?SDZSakJxdzc1NjdBVG01dHUrc3RVQTVFMDY2Ykl3RngwMUdSRGJTRzJRTHZ5?=
 =?utf-8?B?UUNodFJCbks5K3dBTXVmUGErWmRxZkEzbUZuRzJlSVRLbXI5c2wwdzEyTGNq?=
 =?utf-8?B?WTF6ak9KME9KWmF0WWVqUkNwdVBUWWhRQ3ViaVg1cVJ0RFM4YzV3eXpOV3hH?=
 =?utf-8?B?dm43eUs2S3llUVVXRU1nZWNWb0tsUFRJamc0K1hjNDdMY2xoZFNoWGI5dU1U?=
 =?utf-8?B?WHk4d2RkdE1JNFZua3Y2VDdpVnlMdTM5dFB0MVVJVEh0TVczSHFZd1pud1Jp?=
 =?utf-8?B?dUo1R0NPcngwc3QyRWplUVJmUTh4QnVOL2VBbStYMVZXQkFYQ2UycDR1V3p4?=
 =?utf-8?B?L0drQTFzWVJOK0Z6QXl0YThtYnpPYmQ0Vk9ZOU9URVI3THRpejVReXJmQUth?=
 =?utf-8?B?aUdidUlSVURVK1VTL3E5MWV6MVp2YTBzdFl1eVgyV0Z1WkQyRXE5QlhuZlU4?=
 =?utf-8?B?cjA4V1UvcjNkRHJtTy9oYzNPQzliT3k0cHh5ajMzRmtZdlppcVd2SmdaZTZr?=
 =?utf-8?B?M1dsMVhVdzVlU2tZMC9KU0RCQXcxZEhpUHhXNnpBYU5QNGYzcXpLVVRpaHo2?=
 =?utf-8?B?aDhJL0crcWlKS09CYXNxRmRCQWp5bjBhM05DTGpGcXJNcDhESnNnTEFPWi9v?=
 =?utf-8?B?SFJRZGV3Y2Ztcm96cHo1dGw3eE1VQU5oQ1dYWWgyYTE3WnVNTzl5V2Zrb1h0?=
 =?utf-8?B?d1dnK1YxWU5tVWozWWNCVnFWR2dkNEpmS0NoK0U2Wk1UT3JvekQ1OWdkRHBz?=
 =?utf-8?B?Q2ZiVndYL2t5L056dXZQY0l1SUVBMGltQkRZL0NSMHhicHNadHpxTFBHN0Za?=
 =?utf-8?B?SGpDMW5FK3JlaFJyNnFqcEV1UG9IOTc3Y0Y1NWRwd2FDSDdKdE05RnlIck5Z?=
 =?utf-8?B?ODZlTFNHOUlFSGl5cDdzUlBwZlVXSlhhMUFnajcxT1RRTnhJVi9zTTRKZ2lh?=
 =?utf-8?B?dW5uTHZsUmltekxPQnc3djEwd3ltU21QZDlTQUt3SU9kREYwdWZaOVQ4YkZP?=
 =?utf-8?B?VjI0am1mYUo0U0k1RWlxckI3WHdxRzhrbGpEK0R0eGFrZnlkTUE4MVYvWFQ2?=
 =?utf-8?B?Vml3eGo3dVZXTHduaS9kQy9UZjVkNis2QkdPTXZzTzVVc3kxSURtQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe2c735-32f5-45b2-c7b6-08de74a1378b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 19:08:10.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7R5LaaYjwli13TLUCHNFJKktn0uDbmxjBNoFF32A+1DF+1evC8EaO1a8GxKAs6Eytpft3qp2nLwX2+laOxD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9833

On 25.02.26 17:43, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 24.02.26 22:11, Jan Kiszka wrote:
>>> On 20.02.26 12:27, Florian Bezdeka wrote:
>>>> The signature of __request_percpu_irq() got one additional affinity
>>>> parameter in 6.19 and 7.0 will remove the function entirely.
>>>>
>>>> Dovetail 6.19 will introduce a new dovetail specific service called
>>>> request_percpu_irq_affinity_flags() that allows us to set flags and
>>>> affinity at the same time.
>>>>
>>>> It might happen that older Dovetail versions get the new API via
>>>> backports, so the re-#definement for older kernels might get
>>>> obsolete earlier than dropping support for Dovetail < 6.19.
>>>>
>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> ---
>>>>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 6 ++++++
>>>>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 9 ++++-----
>>>>  include/cobalt/kernel/dovetail/pipeline/sirq.h     | 9 ++++-----
>>>>  kernel/cobalt/dovetail/tick.c                      | 8 ++++----
>>>>  4 files changed, 18 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..df0b8ceb05c25d655a331d238e7ef8ac8a6afeea 100644
>>>> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>>> @@ -5,6 +5,12 @@
>>>>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>>  
>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
>>>> +#define request_percpu_irq_affinity_flags(irq, handler, flags, devname,        \
>>>> +					  affinity, dev_id)                    \
>>>> +	__request_percpu_irq(irq, handler, flags, devname, dev_id)
>>>
>>> BTW, this effectively invalidates the affinity parameter. Before we
>>> could make use of it, we would have to backport the dovetail function to
>>> older kernels as well (6.1 right now).
>>>
>>
>> For the time being, I would like to have a WARN_ON_ONCE(affinity !=
>> NULL) in the wrapper so that we have a chance to detect future overuse
>> of the new API.
>>
>>> At the same time, we seem to be forced to create all the OOB interrupts
>>> on all the cores anyway, even when supported_cpus is set to a smaller
>>> set. I do not recall why that is the case, I just vaguely remember
>>> having asked this before. And as long as it is required, the new
>>> affinity parameter will remain NULL.
>>
>> Would still be interesting to recap this aspect, both for classic cobalt
>> (supported_cpus) but also the evl core (oobcpus). Even if the lock
>> contention in the absence of a global nklock is not there anymore, I
>> guess there would be value in not having to proxy the timer on cores
>> that do not host RT workload. But evl is currently requesting the proxy
>> for all cpus as well, isn't it?
> 
> Only on the evl_oob_cpus set (tick_install_proxy()).
> 

But per-cpu interrupts are requested for all cores, no?

Jan


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
