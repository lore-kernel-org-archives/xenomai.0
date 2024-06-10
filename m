Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8246FC7
	for <xenomai@lists.linux.dev>; Mon, 10 Jun 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998234; cv=fail; b=BTGnHAvjfjw73mGBsYqcCBTYfJycoHBv20bHAj23Z8r08J9LFZvZSQSYWqphvOswLAaaWE3zYjFX7cIA8YhWcVl0mCKCFsjaPQTIjZTJkH5UbJDvEHfvGdvsyB5aP6AWmPzcy4aSCOshRnj58AWgJwnS9ViI9KlJ84qpvwcx7/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998234; c=relaxed/simple;
	bh=HEMYEcDt7NWl1cSRMC8QltQCgFAqSFhdse7uo0VRun8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CaAJ7QhSxgNZF9vF9fneXhOPgZMcSLzIv2mjOtGK7OIxVx7YfhOour5EW1QJpKrkpzqMdmfuMvxklMoAe2aWLSbYHY3SFG2UFJr5nKayxWZ+eNlWqSfsX5BVmxZBk6ZfmMNmQl7jvzM4WWocXPAtwsZK1wZtHux0Xzp5FcduV5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pfFl4fyo; arc=fail smtp.client-ip=40.107.104.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pfFl4fyo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3YxDeOwNbKNCdAiu2I9Eb6TDPhKFuJ8RdIKAEnwDYBA9xaf5dV6cKhQHvWV0+1E3AxQj9RzEoliOKKKI0bFX6aMsw/cMkXoqLP8wCu7B9mGd2UdPeLiUJeho+ugaEOyjqPpFeuMpps5eMHZ6ZQHFqPwvZ95HsHqFeYQqqub3an+5vRRF2TULwsHvnhJa8lfmbmXgnw2m45C3SWiZeGUbcvoVcwFs3ZuPfeM/c6l64fqYvehabZGC+Eq9mFqZICPb7KRZur7mn3bczKLqiPDzsKcPSx5m1inmSX2MVgGJFc+Psfwik7mWQKJqP0LW+kaRivYbpVu3qalnWR2mtP70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IlsD//kvV1UL6ZHR82KDwcSsIojT+Cn37j6BCBoS1M=;
 b=Y+LYQSoHvuMPEDtxuCHlecr2Nh5jRDDR8R2QW4LgarE9svfCGQ2YVi+eXD4mr3vpY0GaPHKZ1vb6R88fIXMVJYNJQjYSoMfZFRp8meTpOOBxlvjlYkXEr4qWPeIRfU1T24vqSjt17Tio5xu0mhM764+OLS8WuyCNjHufnkbVDK/DXblv9Txhv1B2+OA1aMKn19tj3HmSXiArcQtsPyWYTevYxb/Xad1s6ovdm2Ui8u6WdknfDh1/ut4Bx8uwbrQIuHgFbMHHprARScEF8WlL/JQWITv+PNUP+7ZNFTl+zPD+CnUrCiEwZEjEz/qcSatxRKzJTa1jGGT9AoH8jbZAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IlsD//kvV1UL6ZHR82KDwcSsIojT+Cn37j6BCBoS1M=;
 b=pfFl4fyorGlZq6B6CsgUBYM2RDhMPnb+ijeKyAYRGYZ46DueRwl2fF+zDZ27S8YCgPllNAEuzIZzaAM9FYPhN4PQvNqzqpb16px6rLV/42tWXqzL3hyywxeYNJolc11cQ/PWqROeQrQLQX6cJO73wa5xMyGOInYZ/j2ZBuf31cyH3ckrejSX7aEgmF0Lush6Yh1GoHDVz+8NF8a1YF923RbPoMJMM0XxFy1J4dAM4flURUZBU9YtD8lw32glmONsvsfWcbUGZb5SxW9+/AbdZr5WXmE8vuJ8kfNacUqKUxVjmPl5OadXjLRRorjvPzXP8hpzkxvCQgnMZRInP0XRHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6433.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 05:43:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 05:43:47 +0000
Message-ID: <5c4192f8-067d-4a92-9ea2-ac5e77ff65bf@siemens.com>
Date: Mon, 10 Jun 2024 07:43:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
 <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
 <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
 <dc350628-f444-41e4-93e8-b9724046b5a0@siemens.com>
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
In-Reply-To: <dc350628-f444-41e4-93e8-b9724046b5a0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: fcec5825-aec5-401c-4062-08dc89104c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFNNN2lHeG41Zk9NZk05YU01eHUvSVIwaGJzRWFmaWs1cy93V2w3NlNvRGJR?=
 =?utf-8?B?dFpDc0hraHVFZ1JBYng3a3k2OFArWTVLeW4vS3JkUjBTSEdMazdhbjZRc1pk?=
 =?utf-8?B?V0xTS3huTFVlVktLZXg0b29Pd3hQelUxQ3VQbHVlR1UwRG0rMytlQmM3ZVJQ?=
 =?utf-8?B?QkZUZzhsOTNRaTV6akxlMTRpa3M2YXNCUGloNHJhWXlaNG4yYk8rclhDRTh0?=
 =?utf-8?B?bDhUMlRMa3M2QVJHQkkrbkc1Y0w4SXN5TFFVVlBKTzZGQWlIR3V5Ny8wUjZ0?=
 =?utf-8?B?NzNuQXB4ak9vS3diUWM5T1NZWUpBcGRRRS9hVGJUVTJaL1VVZC9IQk5UR0Zr?=
 =?utf-8?B?MHEzcTRITFYvL1A5MERoVjEwM2JyY3JyK0xaZnpyQkpNM01hY3dubmtCd29k?=
 =?utf-8?B?R0hKTCt1cWV3VGE5ZjVNL2VBcHgwaVJuc2lqcDYvOE9oSGpWendGZU13VWlL?=
 =?utf-8?B?czFCakVWZUliN1Z1YjNuSS9nSmFOdkpVWE1qS0wvTHo0cUEvZmpDbmxPbDRk?=
 =?utf-8?B?THEvdGs5eUZMKzduV0o4V0FGWUtKM3UwOGZCcEtxUnpoSVJQVzcySXd5N3dC?=
 =?utf-8?B?cGdlOWdPcEVOeVhRMHVVYW5YK0ZTRG9pUFlBZHNLZGEva0dkb05XY3VvalZr?=
 =?utf-8?B?KzV2WktkNWFUNHFQZFh1OWN1Q2xlcjNjUUN3WFdvREpuWGNnd1pqdnR5VG91?=
 =?utf-8?B?SmJycElDVkFOU3hrSUt5THdpb3JDS0ttRzRUOFlyWjB4bUc5anhsbUQ0VVpm?=
 =?utf-8?B?OGk0Y0Fub21IR09Ga0JqSUlXYzNzdldLd1A2TnNuSmFnalZsT1VXR2s5OEd4?=
 =?utf-8?B?M1dWRk1oeHU5WmU3eVgxL2V0a1VSN3M2Rk5wS2V0VXZkT2t3RitLNGFIWDdi?=
 =?utf-8?B?bVFQc3VpSGRtQzJSYUUzL3dkWnJNMlZSNEZNMVdDamVPUHYzL1kyN2w5MjA1?=
 =?utf-8?B?Y0poNEtBb0dETC9kbDdBK3o5bjNTamdRVkpPcHZ1cDZ4VStVQ1hZNUlzd2o4?=
 =?utf-8?B?ZVV5eW9pU0U3Y29ubHVYVjFHelhFbkN0NGpHTjhUVFd4VVZKTFlqbldiMEVi?=
 =?utf-8?B?anJIc2lOYjJWWml0M2hNME5YNVJINzN0MFhPdndoN0Z4MitoaldWd1pka2VI?=
 =?utf-8?B?T0RINjZGeHdwNXVFLzRYZFRYTnZHVlNQZW9ndEUrVmNWVmxHMzY5Znptb05N?=
 =?utf-8?B?RFRncHc2YTZzZ3IwMDZWQkZlTUNnR0F3UDJrT3g4U2dHMFV6Njh3TXNmUGRN?=
 =?utf-8?B?SFpEeW1La3R5RFIyQ2JOdENDWHNFQ0V2N3dvWkdCczRQRy9ZMmtvRXVPL0FG?=
 =?utf-8?B?UUZmZTUxdUh1S3VlSE9TTTEwQ1h3WHptZk5YREFYa3MyMTJGM2hzNGN1TFBY?=
 =?utf-8?B?dkdjUVhUbnNlTjZ5QUs5ZlExYUFRL1Y0SkpIWVlzRUFyQldubS9ZbFA4Q2g3?=
 =?utf-8?B?UnFPRjdPNElZY09FK2xIbWVralBUa1c4RTRURDFGN2wvd09rNFB1dnlmRCtZ?=
 =?utf-8?B?MjJjVFpWaGtFR3hZRi9lMXVSWXU0TURGdXZnOERZTVJQei9pOVhWLzBSWXM1?=
 =?utf-8?B?UXlPYytwTElYWEErTlFrR0JrTGZNZnRPV2FhNFVtUGp3N0V5SE01UEh4Zlhy?=
 =?utf-8?B?SGVRRHlYT08rQUI2YmhKVlVKYTNvNjJFZE9HblloMko1YWhCU3ZvMlhwSURk?=
 =?utf-8?B?aVFQSjNMdXNmZFRXdGRZRTRsTmNZc0ZSQ0ZvejNwRFltR1pKeDd3bFh5dHQ1?=
 =?utf-8?Q?eNzPrOPmz3wsKxtY8QCNWkRjeKzMEZPDuxVMRM6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXp6NEluNnE4V0FpbDI3YWdPYVozSmhySHdScmpnVFZUbkVLaHkyU3NaMGRJ?=
 =?utf-8?B?RkY2UFgzSHBvdTBaUmJZUDhVK1hFOVpyRVE5RGQvWXlKaDNSNXY2UXhxZ2Nm?=
 =?utf-8?B?dEpoVDA5ejg5VmR3YXhSSDNkM2lsZlR1ZUxaYzFFcnRsa2tuNW1hY3pMeitN?=
 =?utf-8?B?SW80d2c0L3c3TXBQN1o3WXZldExLNWRyQmwvUGlOc2V0REtOOVJLYXkySS94?=
 =?utf-8?B?ZUZ5UWFJQXIvSFhuSzd0Y2ZrUDRacGVjNG5pT2FNYUtJQlY3VDFZbzFZa0ZF?=
 =?utf-8?B?M3F6N2VQNWtZVmwzWmZyZ2RmUlU2eHZ5S1VTN01YblQ0YjlRcmJyeGlMcVNN?=
 =?utf-8?B?a2VTL1F5amlmd0IwaGpiMGNXcitCYm9VdHJxU3V2YmsyVTlKcU9qU1RIR21U?=
 =?utf-8?B?UzhyUm02UkpJN0xEUUpOcG1hRXBVc1FGYTlkWXJIcHE3RTZSMEhWZ3AwOG5o?=
 =?utf-8?B?cVZzbmw0VnVZVTFTMlZRYzBIcUFSenRlRDFCVk9pUkVqeEFuVmhUVlBySmNF?=
 =?utf-8?B?NWdBSSsxQU5JK0NFNlRNNWhhWTJIZUxKS0EzWUVNNW9VcTR0NzgwTnZmdzZh?=
 =?utf-8?B?cnN5bnNwSlQ1Mk5kUWtZOStrZVFHNm5VdklzTVhWNlRGQUUzNnlxYVZOd25Q?=
 =?utf-8?B?NExrN1NsN28vQmZhTDJHUGtsU2ovYkpUMGJIZzBjV2dVZHJNbE1tanFTM0lS?=
 =?utf-8?B?WHlmNkpyaHlWSVFjSnV0OWIrQzFGUHJDMkVBVXlQUHZZa3N1dUNmZHFoUHFQ?=
 =?utf-8?B?NkdLakxUd3hQaXdwTGZxdTNQOXkyVTlTcURuSk1NMWZ3TmlsQWJ6dVM3d053?=
 =?utf-8?B?ZVhoWWd0NUhtZmZ1L01ud2JmTTlmVFl0U1FKZmttemxyVU5WZ0o0TUVoWkZK?=
 =?utf-8?B?M1hyZG56VmhsWkVKdUR2ODlxY0Z2YkNmSTBFeDZ0NGdLWVlvdDQ4blRjeStn?=
 =?utf-8?B?TWRzOEhZSG9TVFpOQ2Z4QkJGSmJXK1N3dmdYQ3NaT2FJVlBWOU0vMlJRczZn?=
 =?utf-8?B?TC8yZkZKY2lBWWN5V2RmM09pUktNbUJzR1FaTmZLdkp0Z0dlS1huYlJOU0or?=
 =?utf-8?B?R2J5aFc1d3N5WkUvZTdja0JEcWFTU1dQaGU4eVc1TjFiSTFUdFNnMGFGUXdJ?=
 =?utf-8?B?bklBUk1xaGxoOHBIam80K0ludkZNRmxjSlp3SmlJai8rOHl4ZEZSaHdrdGMy?=
 =?utf-8?B?d0FZTXI1QjZ3VHl2ZnA4ZWJTVUFJd2RTbGc1dE92TGJHaGlXTEVOQkFaL2Jw?=
 =?utf-8?B?UWpoYXlYL3dTdlNLNzBFYStWaUcwaXVXTzFNMGhzbmJPSEtJWlhvZ0szaTI0?=
 =?utf-8?B?M3piNjRIM2tCbThROHJrNEtUZFZ2cXhGUC9iRVJjOFNmYUdwNThISGs4elQ3?=
 =?utf-8?B?dDNWcEhqOXlXNTJjZzBXKzdNMFUzZm5yVjdXTVpWU3lQMnFDTFBLQjErWU94?=
 =?utf-8?B?SS9EZU9mMXkvWUlaczRWZklMZzVuMWE5MGRLM24zUGJISC9QVmtidzY4ak96?=
 =?utf-8?B?a3l6OW9EVDd6ZlBiVzJWczVvOTVwVytJdUFPNWFWSEREaEM4UCtzTjhyMDl2?=
 =?utf-8?B?L29ORjJ2ZXBPa3FmM1Z5RXNuQTh4d0tYcHhmRlJTcDJXRkNzWXJmSnhOUkF6?=
 =?utf-8?B?MlFUYXY0cW9mdHFucmUxOGFHMVEzV1hodHZQWW9Ub3lvN3JHbmU0RHBHeG5N?=
 =?utf-8?B?Y25FcFVpSS96MFB4S0x4c0pJZ1dRcVhWUDdsbGxPMHNNU1Q3eTQ2Y1VkQng0?=
 =?utf-8?B?by9CaWkxKzNwTmtDejE1WkxYM29kRE9IV1UxSXk0dTluL21PQVkvaFJ5Yk13?=
 =?utf-8?B?STZGWUxiSWRkM2owVDZtdmpBVWZBZUtGK053ZE5NWnZseVNTazNLWlNONUZH?=
 =?utf-8?B?WVpmeDJMazlrVW9RaWlCSXphd3VucmY2YStoOEJwb0E5Q3lwNHJhbDFNU0oz?=
 =?utf-8?B?SFFiVyszYmhiYzZUZDQ0VU5XMHJDWGYxU3ZvU2N6RUl0aXFHTWwrN0NuTVYw?=
 =?utf-8?B?UEthTzJOUFJ4Tk5rS0l3RUZiTWhnQVp3TUpQTEF2ZnJDRmQyUTNSWlN6elVV?=
 =?utf-8?B?TmxBcnpTWjhja0xTaXNMaWhYY1V0c2loandqaHo3SjNzY3F2WFJHK3hrWXFu?=
 =?utf-8?Q?Rw5ub+htOvmvKdrItLcYn7pUQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcec5825-aec5-401c-4062-08dc89104c5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 05:43:47.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lUl7BDvIHjiqTWtMrXNL1ii1EK3/WEIBYpgB30CB78HEfDHDWcXxS6aaHLcLl+YesV0CLbpR6vZaRN6t/vEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6433

On 10.06.24 06:21, Jan Kiszka wrote:
> On 09.06.24 13:44, Florian Bezdeka wrote:
>> On Sat, 2024-06-08 at 07:31 +0200, Jan Kiszka wrote:
>>> On 08.06.24 01:04, Florian Bezdeka wrote:
>>>> kvm_wait() unconditionally enabled HW interrupts when called from
>>>> pipeline entry code. That broke the PV (paravirtualized) spinlock
>>>> implementation.
>>>>
>>>> When running with CONFIG_IRQ_PIPELINE enabled we always call
>>>> safe_halt() to allow HW IRQs to be handled.
>>>>
>>>> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
>>>> Linux.
>>>>
>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> ---
>>>>  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
>>>>  1 file changed, 53 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>>> index 655b1cf8c9ab..3180a26cdfe1 100644
>>>> --- a/arch/x86/kernel/kvm.c
>>>> +++ b/arch/x86/kernel/kvm.c
>>>> @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
>>>>  	 * for irq enabled case to avoid hang when lock info is overwritten
>>>>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>>>>  	 */
>>>> +
>>>> +#ifdef CONFIG_IRQ_PIPELINE
>>>> +	unsigned long flags;
>>>> +
>>>> +	/*
>>>> +	 * We always use safe_halt() to be interruptable by HW IRQs.
>>>
>>> Nope, see below.
>>>
>>>> +	 *
>>>> +	 * HW IRQs off:
>>>
>>> Let's stick with the nomenclature "hard" instead of "hw".
>>>
>>>> +	 *
>>>> +	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
>>>> +	 * lock owner.
>>>> +	 */
>>>> +	if (hard_irqs_disabled()) {
>>>> +		if (READ_ONCE(*ptr) == val) {
>>>> +			safe_halt(); // enables HW IRQs
>>>> +			hard_local_irq_disable();
>>>
>>> Just halt() - if we entered this with hard irqs off, we cannot assume
>>> that it is fine to take an IRQ before returning. The kernel doesn't do
>>> that either for Linux IRQs.
>>
>> ACK.
>>
>>>
>>>> +		}
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * HW IRQs on:
>>>> +	 *
>>>> +	 * If inband IRQs are disabled the LOCKDEP state is already correct.
>>>> +	 * We can disable/enable HW IRQs without further bookkeeping.
>>>> +	 * = Linux IRQ context
>>>> +	 *
>>>> +	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
>>>> +	 * infrastructure about the HW IRQ disable/enable event.
>>>> +	 * = Task context
>>>> +	 */
>>>>  	if (irqs_disabled()) {
>>>> -		hard_local_irq_disable();
>>>> +		flags = hard_local_irq_save();
>>>
>>> Why this? We have tested that state above and know it for sure. Just
>>> keep hard_local_irq_disable().
>>
>> Paranoia and to clearly express that we try to restore the state to the
>> state that was observed on function entry. As hard IRQs are/were on the
>> result of irqs_disabled() might be outdated. (I think that would be a
>> Dovetail BUG(), but paranoia...)
>>
>> No strong feelings here. I can change this if this is preferred on
>> other ends.
>>
>>>
>>>>  
>>>>  		if (READ_ONCE(*ptr) == val)
>>>> -			halt();
>>>> +			safe_halt(); // enables HW IRQs
>>>
>>> Yep, this is needed to avoid delaying hard irqs while waiting for the
>>> Linux lock-holder.
>>>
>>>>  
>>>> -		hard_local_irq_enable();
>>>> +		hard_local_irq_restore(flags);
>>>>  	} else {
>>>> -		local_irq_disable_full();
>>>> +		local_irq_save_full(flags);
>>>
>>> See above.
>>>
>>>> +
>>>> +		if (READ_ONCE(*ptr) == val) {
>>>> +			safe_halt(); // enables HW IRQs
>>>> +			hard_local_irq_disable(); // fix HW state for LOCKDEP
>>>> +		}
>>>> +
>>>> +		local_irq_restore_full(flags);
>>>
>>> How about this instead?
>>>
>>> if (READ_ONCE(*ptr) == val) {
>>> 	safe_halt(); /* enables hard irqs */
>>> 	local_irq_disable();
>>
>> Confused. I think you mean local_irq_enable(), right? Otherwise we
>> would jump back with hard IRQs on (again), but inband IRQs disabled.
>>
> 
> Yes, enable. The goal is to avoid that hard-irq back and forth.
> 

Actually, there is no need for this dance at all. Just translate the
Linux version of the "irqs on" branch to dovetail:

	hard_local_irq_disable();

	/* safe_halt() will enable IRQ */
	if (READ_ONCE(*ptr) == val)
		native_safe_halt();
	else
		hard_local_irq_enable();

There is no reason to touch the Linux IRQ mask. It's open on entry, and
we can take any type of IRQ while waiting.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

