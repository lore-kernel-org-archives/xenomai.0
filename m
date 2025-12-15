Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB62F0C7D
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765782851; cv=fail; b=Xy7ezOqmquYQW+M6N90ZYSWD9tb3WZcFpVl33Giw33D6vRN0l3DaYrcSFFE30To5/CBSOXOLPGcZIHpfJJ/J8KURWsVnkCitEJL8kTXvGEaM+KDviiBpdFY3S3uA4z9bG8lmj7wBso7GSoIZUu9v1aWRTCJKlesjIc09HWIrQLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765782851; c=relaxed/simple;
	bh=OVK3rZQUZkjgavSVS1h0F81uSVheYLXBDNb72IDMD48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ll2BP2LbcBupHJmgVBv3lQhz58t3TGoYbSS8MoN/riwwWR6w20HPWVPdmHxs87ZXQx6s68Wn1GVJxMV0mCsaqEXbE9wy1Vakh7nUXsuw+eNUrpcMR0zSNUVCPDqMJ3OCByHrwiQ0nTu15q9t/tkD4ljNdGCPo23GqeSApVzMYeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KI/sghZc; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KI/sghZc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M328XpIHcrX5aS3R7DfYvfIfZ6tOR9o2H2Dtosbu8M9ni13mhOnkT52Aq9M3X9tt5FIxRypTsTafbxyuBSCfWeADPojg09wIyR4K+OCJbWt65S8PxRTa2/Rk+8RboqPJ5axAlxFa2F7ZvNquk2vUK+lJ1m0zIatKYvOGpZQSBT63mI8FyX/yxRUVLDToyVwO6K9WDyXqyglB4s1Cj8Rh2zXjFuxcjSRDgHuCXDky9dYLuLUMoInnPhoZ0f4kQnPqujplvqAIAXUeZcO6iKGvogfob+hRqqSLR03jkrcI8GrMg2fJuVFHDMABBA8dkHv0FjG/xwRv6xlpsbyBDgVOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgEtJjKJYcgB9qErdu6mwZj1nadfqPzZUCspxBoOvmc=;
 b=SLmpGUrHqUV5BNWG8ctzv4AfNRRLVWkSyzoCX/v4foBGoriV4cUORTZskthmcoum7wLbfjFq/C3cIf0cCHkb1t1KPGEManQHCAvKBSjhQPerALVxNtAPgEbjBI2z4i+LNugWy3m6cT6QuJOlQs67WEcIHOOgeexI4aOZ96zALq9sbYMcD6R5jmbx4AkYRn4x618EUFATN8rsnY8dNUNeZaffiJZS//kQBF/lKfLfM3nmjRxFxig68AsduYSDDswzSrsL7zzy2x79QJWptjYuIDBWVP9ZvgjLCmXz4h9OIS9P3Xg7hqJBVGPW9+GN0b/KzKJWBSwl9d5yhX2gLlrqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgEtJjKJYcgB9qErdu6mwZj1nadfqPzZUCspxBoOvmc=;
 b=KI/sghZc5IBIDjVuSQw+HtRFsMjHceD0o2VJcDWmk17Fzxtk81ZuE1D00trYuEPAtEmiQutQR8sUAVMJICFheqiNhvPKjUdxxVOVZCCu1TPThcI0fE8wLAqX268p9DyvvU6BVn21AJ1MFGcmUtVJs2Wzvbuv/7LkaSZFEqfNeXDG3CpUOHYLwIOKRgcsLSCoW8PkYw17+WJ7Yc0nsILfAk7u2CcSn9WTfQQZSJCx5GsxJdzqypWy85Iv4OxEcvyDoR6/TW5T5u6BzSc/55GV9b5QWkqD5DMB1Ttq1SP5gniA9b0Id6YibsXeStVsP24SkgwZ5KgD58doQLxns20hFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:14:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:14:05 +0000
Message-ID: <12fc2bb5-4abb-43fd-bcb3-ea7823501bd4@siemens.com>
Date: Mon, 15 Dec 2025 08:14:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] testsuite/smokey/posix-select: Extend the testsuite
 by invalid timeouts
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
 <20251204-flo-fix-select-syscall-v1-6-7f9c545a63ce@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <20251204-flo-fix-select-syscall-v1-6-7f9c545a63ce@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3754:EE_
X-MS-Office365-Filtering-Correlation-Id: a94fe78b-5e2c-4215-cc2f-08de3ba987f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNKVmdDbGNlNGs2VnpRSHRZa0FhZE5OMWVCSDdwVyt0K0pBK25VRVZrZngr?=
 =?utf-8?B?SVBvWTVkUDgwejRVdlN4WEFIMWU1QklZSWt3dFR5cTVROGEvRWFQU0VQd05k?=
 =?utf-8?B?Z2ZxZGZLTC9vU0tzM0J2OHduV3NITGc4L2syL1c3ajYwUkR1a1FERS9lSEln?=
 =?utf-8?B?NGMzWkJobC9zT0NHZ0sza3ZxcThXUk8wVmIvNjJEVk9kZFAyNWJ6UDVVTG5y?=
 =?utf-8?B?eGZ5TjYxSkZOVEJJcjhyR1RiSUtGcGNLSXRUT3BGNStKMnVZUWpCVVVlR1JF?=
 =?utf-8?B?ZkJXU08rNTBPK3QwUGhqbGw0TnhSSjc4Q3lZNmZCMGtleE8rVTJNRGVKbTBl?=
 =?utf-8?B?MDAyWUptTElyZFBySmRFODQzMmFJaDUvL1dLQ3BxMTNBTEhPUFcrZEhjSmVy?=
 =?utf-8?B?cW1ma3dORU9kRncvbEpwcklpbjNERFFjbFR5MlNaTlBtaWthWGE1ZVVPdzRJ?=
 =?utf-8?B?K0F5QTVrWU43ODdMV1ZDOEFwRWJxRG1VM01NbXY0ektkTENTRnR6U3lTK205?=
 =?utf-8?B?UklBZXNkNndnTEs4dUhIc0dBTGxZSGYzdlB6VENRRXBrb3lYc2JjdE9ITk1s?=
 =?utf-8?B?aGNJQlkwTzI4SGxwYjdwOTJZUXg5WFBuRGJyc3BnMTZUZU5UMnpZNmNVNTIx?=
 =?utf-8?B?bFpPTnBEZ2FmaUc2Q2tvNkNaZUdGZEpGZjlSUzVKdy80WUhVZ083UGptckhO?=
 =?utf-8?B?ZDVzNGpFaXNzSHNmSnVNOEZkTFVrdnJOcHRWSTFwanYzR3BHUzRkNWFKbURH?=
 =?utf-8?B?M2dZbE1CR1dzYnVaU0RqL0FZWll6U0wzZjlwK1ZiSE50cWs4aWdyMjRKTmQ5?=
 =?utf-8?B?QjROUDAyZWVEZUttWEtIdVR5R25pY204bk9IbCtWVk50WU9kLzEzbmJFTGZq?=
 =?utf-8?B?UGFXS2tuQ3h6Wm9LWlM5ZGhoUmxLbjNZV29RdW1ITTJsNXZHdnQycXdxaGF0?=
 =?utf-8?B?TEpQMEJMSWVkTVBQZExMVXdHMCs4TldmOFJ2N2pxUVpHK0xyVmFSdjgzc0E4?=
 =?utf-8?B?Y0JlT3RiaXpmVGNsT1VjNWdCMnpxOG9yQ0NSOXFDQ2FsQ1dNVGpSeXFDMG1o?=
 =?utf-8?B?VDlIMldHTVIxdkU3M1FYaVZteVJUMmpCUnJnZ2VhaG9RNXNUU2NOdTQ0TVlF?=
 =?utf-8?B?RG1JQnMxZjFYbWxPV0xqSG82ZDRXRVFyMWEySnlBSld0MHlmTThSU2ZHUFY0?=
 =?utf-8?B?MlY3aVIwcjA3Umo1a282VzgrQUNjemxzcHMvWEpwU1JIMWRZNDF5UExHL21h?=
 =?utf-8?B?eVplQWZlcHM4aVc4bXBKdWxRMTgyUVRDam5HaFloVjFxSlpLQnp5ZlhqZWpy?=
 =?utf-8?B?MktsVlpFSWdPODNQZkpnYy9IbURGZEp3UnM2eGVjZmgxdXZNQURCc3YzMDNx?=
 =?utf-8?B?UXBkYktmVFkwU3o3UmVmNlFHbm9NOHJ4QjAwMXpsYVY3RGpHQWF5YkdLR1BS?=
 =?utf-8?B?SHdRUWhtSit6NEQrT1pxYit2TkZLdjlHT1BXUFdwME9PdUp1a3pKOFFYQVhR?=
 =?utf-8?B?c1lHYjJvak9TVFdtcmhiQncybHNHUENGMjk4MklwRm9kZHBhL3NraGFmdEcy?=
 =?utf-8?B?K05mQ3pMbnJzUUZqR29xVWdnY0dNYW1aSy9qVnpmOVNJZjhJdmFUeVdOOENI?=
 =?utf-8?B?M1NKRXZuYlhMZnppbDdZU0h1MzVVWlk0Z250MmRHVGR0dVVOd2t0ZWJOeEww?=
 =?utf-8?B?TUY5Uk95Z0VZWWduTFFyNlphQ0I0TVVrU24yRnVFZkZ3d1M1aFVSTmxhanpI?=
 =?utf-8?B?MmZFUHg0ZUJEdjR1RDRRN3QvZkh6ejdQQ0F3U01UMGF0enF6bytyb2xqQklU?=
 =?utf-8?B?eUMwcklkS1pva0l5OU5rdmJoRTlRMW8wd0hZTTlsSzY4VE4zVlZtQjd6Qnlp?=
 =?utf-8?B?MWhNaURXbm9EeUE2UFZTaERaVVZYdVI2UWwxdVNyYy84d0E4MEtqZUhCY20y?=
 =?utf-8?Q?EBr/Rmkt+aYKfujOGcdYrhxcqRk6ipgY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZ6VFlxOG9KQkhpNVE2c1Rxb2luN0QvZGNaL0R3SFRLa21qRmRwaWVnY0tC?=
 =?utf-8?B?VFZkb2dpcGZpem5WQWgyZml6VC9wOXd3TnNCbXFudUhOaFgzVThhY3FYOG0y?=
 =?utf-8?B?TjRmRzRoVFhSWFJGbmM3RkM3eGJMMjlpU0R6NE9vZ3BnZlhSSVZJd3Ivb09y?=
 =?utf-8?B?V1YrZHR2RkpHYXg5YThTcFlZT3VRWEFCMG1hbkEwdTlDVnE0SnhzZSsydDFv?=
 =?utf-8?B?T214UXlXVi9HQllEMXB4WUtoZnZyWEJGYjVpMFN3RHd6V1F0SXJrU1JmMzVu?=
 =?utf-8?B?NzZzL1R2VFQ3SDBBSk1qelJiS29xS3hxS2ZVbmJ5VGtxbEtIUGRZTW5rVjA1?=
 =?utf-8?B?SDVDd1VHbktPQXBJK2l0bTZLeGJSRWZKbnVaTXl0TDlnNkI1dVpHQUdpbzlI?=
 =?utf-8?B?R2RDK3hRSEkxS2Z0VGxHazdlMWExQzZZOFlCcEdNcTU3Tk5WdE9LZzc1ek9i?=
 =?utf-8?B?dS80MU8rbUdoSDZjZmh4STJ4R1BnL1J5UDJiVnNkUHVGQ1kxVVdaUjF1Smli?=
 =?utf-8?B?V0FqWDUvUWRkVU8vVmVIOUo3RStxNjBMUGN5SHpOYk1rZFMvSFE5dnFqQWRG?=
 =?utf-8?B?U2VWd0lEYzRQMzFrNXBhZGtVNFZSR3ZSNjdHTU5KVVZxcEJsTGhDNi96QWtQ?=
 =?utf-8?B?eTd2blNJZTVRa1FVZTFqazRQbURqRXByQ0U0MVpYSDJ5SjlMZWM3M3FteVdI?=
 =?utf-8?B?YW02QzBucVFlS2FodWp1Zkl1RnhVT29sbzdnblhMUHo3S2VRSWQ3VHV6VEw4?=
 =?utf-8?B?b2grUkN1Skg2NXhIdngwbmpJVC9wTDhGUHRwSUFIQWFBcmp2bUV0SDZLQkwr?=
 =?utf-8?B?YkVadzJwajlIUU5pT1V2N2Z3MEpxcHRxTG96Nzc5YzRyL3NkRG1HSmNSeE1D?=
 =?utf-8?B?Q2Fib3E3U3VYUUpIelhqT0FOL0tMTENXRGQ2TGR3bmxJMzBaQmowcVlvQnM3?=
 =?utf-8?B?OXR0TDAwMjJEaUFmSGlBb1BlcWE3TFVzbzFTOHp3bVlEditNWXJBcGtEdXVa?=
 =?utf-8?B?aGlDbVNBQVlIVzAzRmJrR1lKQzU2dWNXQSszQ0M1V1pjWCtZbXQ2bENsbHlB?=
 =?utf-8?B?SU14V0Vzc29PYmNQWHFDdDE1citSbVhVSWI3VDdXb3l2ZVNGMzQ3QlVUQzlF?=
 =?utf-8?B?THhpUjlKbnRtK2N3NEhuaWszdysvdFMvcnE4YS9TNStlM1p2WjNJcnRzUTNL?=
 =?utf-8?B?c0lvMEloUGRoK3UwN3RnSjZjMVhXeVMycnN2NVpWeGhpNTRVK2R1Q2toaERE?=
 =?utf-8?B?cEQwL093bHl1ZU1VaHE4Z3RDNmYyUGd3eXpvSjBLa0Vwc2ljbjY2QTZ5T0l6?=
 =?utf-8?B?WThoZVhEK1U4d0RSQ0VieXRlVVJLQTRzejdaMW40L1FTSjQ1bzZWN2FJYysx?=
 =?utf-8?B?ZWZncndjTi9hcmsxWGJVTlVDQWdSSDQ1aHFFT3habGt1WnJSTlhFMXhkOWlG?=
 =?utf-8?B?UHBrS3MrOHk1ZHhLS3huYTlOakRMd1J3UXN5eWdJalFGT05GYnlLUzBTNFo3?=
 =?utf-8?B?OTBrVFVpalFycE1hSXdwQzJOcllsT0xkVzd2MktaMlVyOWZzMVcyZXpRMXV2?=
 =?utf-8?B?a1Y3VFRXaUUySndYUzFtbjI2V2prOTc2NTA3bDIxM3d5TG1IWWxPRnIvM2NK?=
 =?utf-8?B?aGxQV3kxS1JwSkxieUxDMmJZY3ZZU2RxYk9uVHRGYXduV3M1V3dHY2U4WkM1?=
 =?utf-8?B?cSswWHdSTTFybk9CYTI3Yk8xakpEeWRyUU5VcStGbFhxS0JsZXFMN2pDVFhU?=
 =?utf-8?B?VHRLbjFpUVJpalBkNDVJRXdIakJ5YkRDbjU0MXFnVGdHRXBINzdpNDM3U1hU?=
 =?utf-8?B?anpUN1hRUzBNOXRaQ0xVd0dMbUFjVGp2YStrOXh6WEJuTjVUQXdVbUlhLzE2?=
 =?utf-8?B?aHlUcUVBSk5tOGNuS3V3NjdnMnJOTTdURTNQZWpwWkFxVVVsV0FBUjBJTVJF?=
 =?utf-8?B?R3R0T2FtVFRpMW40Q0tGN3ZiTlAxUVhTZVV0WlNyVkRXeDJHVXpDcWE5ck9B?=
 =?utf-8?B?OHNtRUY4THN2WmgrN0dWUVJRalRnWDNKemw3UFJpeFRkeXdyNGhUVHBXT1dy?=
 =?utf-8?B?SnQ1YzI2Nkl1TmpIdnIyMHZMYnZWZ3pCRDMxdWxhN2RCbnVXNnpzbUxxTGdq?=
 =?utf-8?Q?C/hzKSw3X/R73z8L+zTkGgGFd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94fe78b-5e2c-4215-cc2f-08de3ba987f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:14:05.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwsC4g+Z2dRNgWszzNNO/QWiX6KOKYt5qKituQQeEe7+oxX0dn2ZsflJOgFvbRAEYQgXZ6pzrj1Y20oS+zpEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3754

On 05.12.25 10:03, Florian Bezdeka wrote:
> One corner case was missing a normalization about the timeout value
> supplied to select(). Extending the testsuite to make sure we cover
> that case as well.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/posix-select/posix-select.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
> index 154b3d730..6d1fcaa0d 100644
> --- a/testsuite/smokey/posix-select/posix-select.c
> +++ b/testsuite/smokey/posix-select/posix-select.c
> @@ -143,6 +143,30 @@ out:
>  	return ret;
>  }
>  
> +static int test_select_timeout(void)
> +{
> +	struct timeval tv;
> +	int ret;
> +
> +	/* Invalid timeval, usec too big, normalization to 1 sec, 1 usec */
> +	tv.tv_sec = 0;
> +	tv.tv_usec = 1000 * 1000 + 1;
> +
> +	/* y2038 speciality ahead:
> +	 * select() services provided by Linux and Cobalt both normalize the
> +	 * timeout value before using it. pselect() services do not do that.
> +	 *
> +	 * As the select() service of libcobalt is routed to the pselect() of
> +	 * Cobalt we have to do the normalization in userspace. The test below
> +	 * is exactly stressing that case.
> +	 */
> +	ret = select(0, NULL, NULL, NULL, &tv);
> +	if (!smokey_assert(ret == 0))
> +		return ret;

This is checking that no error is returned but not that the timeout is
actually > 1 s. Maybe use a much larger overflow and validate that as well?

Jan

> +
> +	return 0;
> +}
> +
>  static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
>  {
>  	int ret;
> @@ -151,5 +175,9 @@ static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
>  	if (ret)
>  		return ret;
>  
> +	ret = test_select_timeout();
> +	if (ret)
> +		return ret;
> +
>  	return ret;
>  }
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
