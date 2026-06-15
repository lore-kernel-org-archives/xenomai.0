Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFE3B9D9B
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514279; cv=fail; b=CGUlrF1LG5EUkFOc2waEB7E54yQjGd9m6nJKxWver3F1dul2Vb5+8J3eVa8d5rGvPPlC65G3JqZYcAHbnDS56cKc5RWAOohPbQnEtxRo1wNhH6GWjInCcHGx+hGzyvegvQClx47GXLlBsUoLAKA2sVk3wTXkngPLwdNdv0TfpII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514279; c=relaxed/simple;
	bh=A3wpDos8uK8jEyWg8/N6p0ckorQ1yFv8vhfyPwVA4LI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dGNVKiLHGZauebPpBBpR+1JUwVNzTSS6rGmzrXnPF5xiRyRcL43RvTi1JaO0Sbl0i1XFo66Ti/3HvW93/8XjjcRkG5HccuAkuwleFWRJzR6shw7xWYwOMyZjzSO/VkJfzI/q8V+NUgW24yEZLSk9OQnnUd11L9dPJfstFVpYYIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yLZDHyZs; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yLZDHyZs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzO33H4ZeNXPksjoXmFQTIuXqr7aCFE2MROWS9O8gzVQPfghJjBoNyB12CZ7aaWuV3WgzS6GJ0NShmPbhiQsljvEmcYsc8+4tLYUbT0S/6F4EV1KAQJ2kBz65xgMuw4MON4oewO6WVxR35SaOqQEQZUVQSv+dAsEs01KCNsG8MMq55dydRiXF1yi5wIqHGtr0Pw2YmOp5sXp1oS/liGTGggs5Q9+46Jdp27VAnGspz0V0NLlajBzJQ1OrNeEXttNFqS1HJcUpgoj1Cmre0xkshbtlqCquoJZHcMvWmWICZWktVX1Qtvk+8l0Fq+tmIBLPeGFKjOl22blD9+fWDT0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcmc18b+Mx+NlehF/64TjvebAmeedlFFsOJJdTDAjNY=;
 b=MiEUXoOCvU6VPdDSmNu7YwbD4Iwk2lyhcjBJdeaWgeZ2Ux1o6tDGzPTTukM1fi/12sSYL7edYYngHFqwWU/PHwbnN55NhavAi/YsRC2IvyxxutLsDyIJoj38a4/xBofQZVCKMrAGO9DJ1yv/C01YRiCkQUPeRQK1+qQU72snCRw8xKBKES6VU+FKvvXCV0X8vHw0YJCfsvxdJ5t+Q99jrfrph0RoF3+dwSXQPcEsNfiRXxFL2xI8/Fk9o5lDpUT7ZJcerWWXdsu0SDHdiZTKZiBGMxUALvaiO1UDt3niRqoZ65y0ElG+i0lgPjxa49qlgpm/mncILt5fpO0nPUfwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcmc18b+Mx+NlehF/64TjvebAmeedlFFsOJJdTDAjNY=;
 b=yLZDHyZsn5j/OSlRwo123EewAHFXSeAliAmYQOIiZTiVvkZ/B8N10OhruMGuluCDHmmvnXHTcXgllWjiO40nP+LxQwkX1Ur2VbqHsDJ9dnyeSa9AzQHl9kFYFFWEIPFF4IsA6obdxQjsLVl4nDsA3aDVBinY4LctqkXMS/0KBFhxxSVlS8lqcPXDKNWUKVaTrhloUHsgua80PlbtF/5fHnNKVSgPkgMoRApbztReUaaHfDe2j2xVUO2heW2GOuQVP8Of83Qctn9ND3xQf3anoWVp+31F7su8zP/i4U5QfVj4oG9kB9Ogls8h0zqx80HZjUMNkeO1+VteLBabaI0L2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 09:04:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:04:33 +0000
Message-ID: <4797a713-e16f-4792-ab7a-51a2876fb6ef@siemens.com>
Date: Mon, 15 Jun 2026 11:04:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
 <87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
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
In-Reply-To: <87a4swi9sy.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: f326c3e1-1866-4f26-309c-08decabd1ded
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|55112099003|56012099006|5023799004|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VikSk+FQ8F+ozlperbmE/9q67p1XhY3TjRKNcPVKsV/TS+zS6o9A9wlyxad3o73FHCva1dy0Sr2dtRB2Y3UXqoh4AkyZ5IjjCDzACZDD0ggJNjrfjIxVAUCAfL3kMe5IYpG4S8+ubTq8e7IUaYmOszuPzNOJUmfCdHzpCQMDkg24jlE0QgUv2HP60ucG7kLQrNW60wc3wA2w4LjNauktuRd6P4ZGoydzpfXSMS1Ed/4uAtTxyCmawzpk1xuEyd0oMdt/yfmPIDh+ARUQc+BoBxAWtB6LxCOcIUd5mdorVdoxsW6yii1EzFxB5tw+YMm3zjGUMRoa3/tyLg4sTYDkvWNJXVWBbri9ZTcFwcnecixkNK4oE15gHIbHg1iDuaCD3QXMwHPQE5x2KXBV2BcVcQDmSL1lkm+czzuEjbSgKfU7b/SeB9BVDwNbSjqP0raUyXwoCv1HdYl0iH/PCIukpSTTtsH4zyGFDw2WwVGzP4TFVBHJ6JWZlXYD0QKYQXwZRdMfLuH+tcToZN9+kgLdYz0aedt1CjLv+/A9/OX2nbH5YH8sfkdCecdiwnTAIe6FVm0yh+cttR7eV9IjCp0WSMlMNkwN0dSBaM7OLRvUZaT7lDi7Cc89I26vkkq6sxCkmyg3lHCHseQ0FGBcl/rBFkpMHlxQGUOvLiU1fHNYcf7YQsOlltz8BVW0K/AEslCj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(55112099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVpWTlZRZ2ViNmJZM2JzQU5neTlkVTkvRGw1RzJ4RlNIVktNZlE1Mm5RWDFP?=
 =?utf-8?B?eStzeEtaUW0yUnVsTnFTUTZrZ0tzY2lWaFd2TXBhNzhOVkprSkR2NTROZ1N6?=
 =?utf-8?B?b2JQeVd6T1Rjb0hZT0R5cnA5Q1BDV1dGVDl3M0YyeTJWMHBkWEl2TFVqcmlV?=
 =?utf-8?B?czlEd25NdWhVVjhQZzFkTmI0TEtZSEhSZHZuR1QyMlVZQnJRSkU1RldkYnZN?=
 =?utf-8?B?QUoyM2FHVTduMlVISUxreEFEYmpHRlRjV1FXZ1ZhVjJBOEdtTXRFTVdPZm5G?=
 =?utf-8?B?QzhDRE9tODg4ZGU0ZVVybGNqTG9VNldCMjRWMDQ5dlZvTXpBTGFyZzhpLytY?=
 =?utf-8?B?ZEJuQ25HdEZKcHRKTlJGU2xLNVJlaXJadDRkbnJ5dUNJTXZMTi85NitTSCtw?=
 =?utf-8?B?Kzd0MVdtSGZlY0lVRXVvK0VuampvWGtxTVB3MHVublBOQStzZkltZTJBZUxp?=
 =?utf-8?B?QkplNjZ4elIzcXVGalhjQVlmOGdxOEhTQWpLb1JTSjJzN1hRaWE3VG9URnY2?=
 =?utf-8?B?M3NhRXdPWEkxajJ6SUlJa052VHpSWnREaEJ5a2FYdnpoUy9BVHBzNEVSdSsw?=
 =?utf-8?B?bmFkdkxaWjdleU5LaVladGNjTVlVZlM1MjJ1eU5BOFdjZ25PSVREdjRRWWp5?=
 =?utf-8?B?c3lmdDNILy9UY3creW1pUHczSGJ1SkVoMzlLZG9ONGpyU2hnVEpCV3NDRGpj?=
 =?utf-8?B?Tm5vS2prWTRERXJGVE11dVFnbnEwc0VCWmQ0L1l4OHR5MGY5TC9kMFZnQXZm?=
 =?utf-8?B?RFVOeEo2YW1NNjFLRUdadWJ0MHJERURNd09ZeEJLcm1oQXZDNTBGSUxWWFcv?=
 =?utf-8?B?UHB3VlpmV0NqUzVUVm1vSGg5RjlEZGhkY0wrU3kyeHlSNU5ndVpKaFVUdUt2?=
 =?utf-8?B?WEpsRkZFeTN0eXllVmxNRkloRU9lQlhpWjVpWVpWaThyUE80RFllbTVwK1hJ?=
 =?utf-8?B?SHdmeHgvOW96NzdTUHNTUXIwZzBzalo5QmRIWTZtR3BkT29jZm1EM0hDWkF4?=
 =?utf-8?B?eWkybWIzeG82MDVGSEpUSTB2VUFHQ29HTlFqTytJNG00RHZPRW90SDNmdmhk?=
 =?utf-8?B?SWtndGNOUEk4RFlWcFlweFJ6UHhXSUpGbzJMNmZvR0JUUWgybnF6RFBXOWtx?=
 =?utf-8?B?WW8zdWUvbzZKZy84T2JUQXUvS1gwWklESmdPWGdBQm4yZGVOK2ZxRlc0eWY1?=
 =?utf-8?B?eWh1Tlp0MjhhaVgwVG5iRktWcS95RTJKUHlxeVRjNzFQTlZGeDJKeFJEKzli?=
 =?utf-8?B?NG9zZkpBSkJnQjFYU21ZTzFCY0lmMC9nUmtZNjJCL09neUlCWnlHMUFrc3p1?=
 =?utf-8?B?SitsVmYxRDNhQTFTL25IQmdXcG9oSDhTMnNkSVc4RFQxRk1aVk9VckIrMWtS?=
 =?utf-8?B?ODJ4ZzB0Y1FwTUd1R1BUWHB1MjJLZGxmUlhHY2hpc0JvMWdudzRDbERjajI0?=
 =?utf-8?B?ME04dktNNUZmaDVHYStsQTU3eitBWS9nNlQ3S0tOUUVBMEl5bjdlSzY0NXNF?=
 =?utf-8?B?ZFh2c0lpZFFiQWNOYm9jKzZ0aGduMWpZWVB2ZUYvc3d3L2NQRktwVC9OaHQ0?=
 =?utf-8?B?NG9lSURLUUUxeDhTOUsvT0dLeHdONGFrSHdEU2NCMHNPT0cvWWFZeklVMTh1?=
 =?utf-8?B?WE43MjlZT1VhSkJ5VUtxbU9hUWtNNG5pTjZLUG5tOVMxQUZmUEN2cmlFZzgz?=
 =?utf-8?B?RzlvSFlKKzdCQnBVVVBVdGNmYjlLOExUWGg4RHpXSDV1UFI0Q3NXSFhMOVM0?=
 =?utf-8?B?a0xHWStNMitlbWx2UVBjQTJpU1JHWUVvbVFDUDNTZWI0bGpVSGhoS2t5YU9V?=
 =?utf-8?B?NUZzenpXNUZweXF0RitFR0xDWXRYUzVSQW9Ed1JueVpkZE9pNC9BQ01rNHpZ?=
 =?utf-8?B?S0NMZ2RMdGtGWXlSQjNxc2pIVkVvMTNMOHlZbEhkTDM4ajlLTXpEWGtJREM0?=
 =?utf-8?B?NUZoWXAwb3dTTkxQL1FJUUhsWFo5bnQ5a2o3cWpjNFpFL2lKNHIxYkRIcFh2?=
 =?utf-8?B?V3gvQlQvLzVnWThXa2txQWdUL0gxVE56dzM2aW5jRzNNNktlMThpYXpQYTBS?=
 =?utf-8?B?UDhLUXZvWlhQeU5wR2xhdGRUcVpEUERmSjhvVm9uN3NnOUxwWWRNTlFzVWVq?=
 =?utf-8?B?bFhweXpYeTBCLzNaaXUwMWkvTGdOV1pHOXo5N2Y4VXMxQTVnTkxkN3hWYmxn?=
 =?utf-8?B?TjZQZzdPV0dqZExxZVFxTG9mREIxcmw1NDcvSkxvNTJ6d0lhRHhQK0ErSlpt?=
 =?utf-8?B?SUZ1NVJmZWE5UHM5S3FDaGVDNEdlaUV4a0JZV1ZHWGlEb3BuWExuYndPcW1C?=
 =?utf-8?B?V1lOYmJmbStqY3piNGlCNit4R3BvNDJMcTN6NjJ0ZnVWWUZ1VEpxQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f326c3e1-1866-4f26-309c-08decabd1ded
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 09:04:33.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reDX7I40GbFmt3e3js1bq2+HJbsKFTn0997n1ni60DSV8+6OwHsB5HV6QazT2DnHBRuifeSgS8I2Joy0ZiTkHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6555

On 15.06.26 08:42, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This shall be invoked before a thread switch, providing both the current
>>> and the next thread as arguments. Some scheduling classes may need it to
>>> correctly handle their state as the sched_pick may not be invoked when a
>>> higher-weighted class is providing the next thread.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  include/evl/sched.h     | 2 ++
>>>  kernel/evl/sched/core.c | 5 +++++
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/include/evl/sched.h b/include/evl/sched.h
>>> index ae9690860146c..0b16f1b1cf626 100644
>>> --- a/include/evl/sched.h
>>> +++ b/include/evl/sched.h
>>> @@ -120,6 +120,8 @@ struct evl_sched_class {
>>>  	void (*sched_dequeue)(struct evl_thread *thread);
>>>  	void (*sched_requeue)(struct evl_thread *thread);
>>>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
>>> +	void (*sched_out)(struct evl_thread *thread,
>>> +			  struct evl_thread *next);
>>>  	void (*sched_yield)(struct evl_thread *thread);
>>>  	void (*sched_migrate)(struct evl_thread *thread,
>>>  			      struct evl_rq *rq);
>>> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
>>> index eb133e334d30f..0d49fc16bd67e 100644
>>> --- a/kernel/evl/sched/core.c
>>> +++ b/kernel/evl/sched/core.c
>>> @@ -910,6 +910,7 @@ static __always_inline bool test_resched(struct evl_rq *this_rq)
>>>   */
>>>  void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>  {
>>> +	struct evl_sched_class *prev_schedclass;
>>>  	struct evl_rq *this_rq = this_evl_rq();
>>>  	struct evl_thread *prev, *next, *curr;
>>>  	bool leaving_inband, inband_tail;
>>> @@ -990,6 +991,10 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>>>  	this_rq->curr = next;
>>>  	leaving_inband = false;
>>>  
>>> +	prev_schedclass = prev->sched_class;
>>> +	if (prev_schedclass->sched_out)
>>> +		prev_schedclass->sched_out(prev, next);
>>> +
>>>  	/*
>>>  	 * Careful: we _must_ have updated this_rq->curr before
>>>  	 * performing the rest of the context switch code
>>
>> I've been working on this lately too. It turns out that we need more
>> than this, although this is definitely part of the solution. I'll follow
>> up on this issue.
> 
> This is still wip, I'm sharing this early to discuss details for
> reconciling both proposals (the hunk in __evl_schedule() is merely
> cosmetic, no functional change).
> 
> commit f49dbd63c1389a6b99508ef0da852545b102d1cc (HEAD -> wip/fix-quota-sched)
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Sun Jun 14 12:08:59 2026 +0200
> 
>     evl: sched/quota: fix budget tracking on preemption
>     
>     Upon preemption of a SCHED_QUOTA thread by a SCHED_FIFO one, the
>     runtime budget of the former is inaccurately tracked. This is due to
>     the fifo->pick() handler returning a valid thread, which prevents the
>     quota->pick() handler from being called. As a result, the last runtime
>     period of the outgoing thread is not accounted for.
>     
>     To fix this, we introduce a new sched_out() handler which is called
>     for the outgoing thread, which the quota policy uses to update the
>     remaining budget of preempted threads appropriately. In addition, the
>     implementation no longer shares the runnable thread queue with
>     SCHED_FIFO.
>     
>     Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> 
> diff --git a/include/evl/sched.h b/include/evl/sched.h
> index ae9690860146..cc824c28004b 100644
> --- a/include/evl/sched.h
> +++ b/include/evl/sched.h
> @@ -120,6 +120,7 @@ struct evl_sched_class {
>  	void (*sched_dequeue)(struct evl_thread *thread);
>  	void (*sched_requeue)(struct evl_thread *thread);
>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
> +	void (*sched_out)(struct evl_thread *thread);
>  	void (*sched_yield)(struct evl_thread *thread);
>  	void (*sched_migrate)(struct evl_thread *thread,
>  			      struct evl_rq *rq);
> diff --git a/include/evl/sched/quota.h b/include/evl/sched/quota.h
> index dfe3b7390958..dc8416645da8 100644
> --- a/include/evl/sched/quota.h
> +++ b/include/evl/sched/quota.h
> @@ -40,6 +40,7 @@ struct evl_quota_group {
>  
>  struct evl_sched_quota {
>  	ktime_t period;
> +	struct evl_sched_queue runnable;
>  	struct evl_timer refill_timer;
>  	struct evl_timer limit_timer;
>  	struct list_head groups;
> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
> index d1d025e06a5d..7127d4e52df9 100644
> --- a/kernel/evl/sched/core.c
> +++ b/kernel/evl/sched/core.c
> @@ -773,7 +773,8 @@ static inline void set_next_running(struct evl_rq *rq,
>  		evl_stop_timer(&rq->rrbtimer);
>  }
>  
> -static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
> +static __always_inline struct evl_thread *
> +__pick_next_thread(struct evl_rq *rq)
>  {
>  	struct evl_sched_class *sched_class;
>  	struct evl_thread *curr = rq->curr;
> @@ -821,8 +822,14 @@ static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>  /* rq->curr->lock + rq->lock held, hard irqs off. */
>  static struct evl_thread *pick_next_thread(struct evl_rq *rq)
>  {
> -	struct evl_thread *next = __pick_next_thread(rq);
> +	struct evl_thread *next, *prev = rq->curr;
> +	struct evl_sched_class *prev_class = prev->sched_class;
>  
> +	if (prev_class->sched_out)
> +		prev_class->sched_out(prev);
> +
> +	next = __pick_next_thread(rq);
> +	trace_evl_pick_thread(next);
>  	set_next_running(rq, next);
>  
>  	return next;
> @@ -972,21 +979,20 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>  		return;
>  	}
>  
> +	prev = curr;
>  	next = pick_next_thread(this_rq);
> -	trace_evl_pick_thread(next);
> -	if (next == curr) {
> -		if (unlikely(next->state & EVL_T_ROOT)) {
> +	if (next == prev) {
> +		if (unlikely(prev->state & EVL_T_ROOT)) {
>  			if (this_rq->local_flags & RQ_TPROXY)
>  				evl_notify_proxy_tick(this_rq);
>  			if (this_rq->local_flags & RQ_TDEFER)
>  				evl_program_local_tick(&evl_mono_clock);
>  		}
>  		raw_spin_unlock(&this_rq->lock);
> -		raw_spin_unlock_irqrestore(&curr->lock, flags);
> +		raw_spin_unlock_irqrestore(&prev->lock, flags);
>  		return;
>  	}
>  
> -	prev = curr;
>  	this_rq->curr = next;
>  	leaving_inband = false;
>  
> diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
> index 0829da711a66..14748e3a843e 100644
> --- a/kernel/evl/sched/quota.c
> +++ b/kernel/evl/sched/quota.c
> @@ -12,45 +12,35 @@
>  #include <uapi/evl/sched-abi.h>
>  
>  /*
> - * With this policy, each per-CPU runqueue maintains a list of active
> - * thread groups for the sched_fifo class.
> - *
> - * Each time a thread is picked from the runqueue, we check whether we
> - * still have budget for running it, looking at the group it belongs
> - * to. If so, a timer is armed to elapse when that group has no more
> - * budget, would the incoming thread run unpreempted until then
> - * (i.e. evl_quota->limit_timer).
> + * Each time a thread is picked from the ->runnable queue, we check
> + * whether the group it belongs to still has runtime budget.  If so, a
> + * timer is armed to fire when that group has no more budget, would
> + * the incoming thread run unpreempted until then
> + * (i.e. quota->limit_timer).
>   *
>   * Otherwise, if no budget remains in the group for running the
>   * candidate thread, we move the latter to a local expiry queue
>   * maintained by the group. This process is done on the fly as we pull
> - * from the runqueue.
> + * from the ->runnable queue.
>   *
> - * Updating the remaining budget is done each time the EVL core asks
> - * for replacing the current thread with the next runnable one,
> - * i.e. evl_quota_pick(). There we charge the elapsed run time of the
> - * outgoing thread to the relevant group, and conversely, we check
> - * whether the incoming thread has budget.
> + * Updating the remaining budget is done each time the EVL core
> + * schedules out a thread undergoing the quota scheduling policy,
>   *
> - * Finally, a per-CPU timer (evl_quota->refill_timer) periodically
> - * ticks in the background, in accordance to the defined quota
> - * interval. Thread group budgets get replenished by its handler in
> - * accordance to their respective share, pushing all expired threads
> - * back to the run queue in the same move.
> + * Finally, a per-CPU timer (quota->refill_timer) periodically ticks
> + * in the background, in accordance to the defined quota interval,
> + * replenishing per-group budgets, pushing all expired threads back to
> + * the quota ->runqueue too.
>   *
> - * NOTE: since the core logic enforcing the budget entirely happens in
> - * evl_quota_pick(), applying a budget change can be done as simply as
> - * forcing the rescheduling procedure to be invoked asap. As a result
> - * of this, the EVL core will ask for the next thread to run, which
> - * means calling evl_quota_pick() eventually.
> + * NOTE: forcing a call to the rescheduling procedure is enoiugh to
> + * apply a budget change.
>   *
> - * CAUTION: evl_quota_group->nr_active does count both the threads
> - * from that group linked to the sched_fifo runqueue, _and_ the
> - * threads moved to the local expiry queue. As a matter of fact, the
> - * expired threads - those for which we consumed all the per-group
> - * budget - are still seen as runnable (i.e. not blocked/suspended) by
> - * the EVL core. This only means that the SCHED_QUOTA policy won't
> - * pick them until the corresponding budget is replenished.
> + * CAUTION: quota_group->nr_active does count both the threads from
> + * that group linked to the runnable queue, _and_ the threads moved to
> + * the local expiry queue. As a matter of fact, the expired threads -
> + * those for which we consumed all the per-group budget - are still
> + * seen as runnable (i.e. not blocked/suspended) by the EVL core. This
> + * only means that the SCHED_QUOTA policy won't pick them until the
> + * corresponding budget is replenished.
>   */
>  
>  #define MAX_QUOTA_GROUPS  1024
> @@ -61,15 +51,19 @@ static DECLARE_BITMAP(group_map, MAX_QUOTA_GROUPS);
>  
>  static LIST_HEAD(group_list);
>  
> -static inline bool thread_on_quota(struct evl_thread *thread,
> -				struct evl_quota_group *tg)
> +static inline bool current_on_quota(struct evl_quota_group *tg)
>  {
> -	/*
> -	 * Check whether @thread is running on some CPU, and belongs
> -	 * to quota group @tg.
> -	 */
> -	return thread->quota == tg &&
> -		!(thread->state & (EVL_T_READY|EVL_THREAD_BLOCK_MASK));
> +	struct evl_rq *rq = tg->rq;
> +	struct evl_thread *curr = rq->curr;
> +	struct evl_sched_quota *qs = &rq->quota;
> +
> +	if (curr->quota != tg)
> +		return false;
> +
> +	if (curr->state & (EVL_T_READY|EVL_T_KICKED|EVL_THREAD_BLOCK_MASK))
> +		return false;
> +
> +	return evl_timer_is_running(&qs->limit_timer);
>  }
>  
>  static inline bool group_is_active(struct evl_quota_group *tg)
> @@ -82,7 +76,7 @@ static inline bool group_is_active(struct evl_quota_group *tg)
>  	 * runqueue, in which case tg->nr_active already accounted for
>  	 * it.
>  	 */
> -	return thread_on_quota(tg->rq->curr, tg);
> +	return current_on_quota(tg);
>  }
>  
>  static inline void replenish_budget(struct evl_sched_quota *qs,
> @@ -134,10 +128,10 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
>  	} else if (tg->run_credit) {
>  		credit = ktime_sub(tg->quota_peak, budget);
>  		/* Consume the accumulated credit. */
> -		if (tg->run_credit >= credit)
> +		if (tg->run_credit >= credit) {
>  			tg->run_credit =
>  				ktime_sub(tg->run_credit, credit);
> -		else {
> +		} else {
>  			credit = tg->run_credit;
>  			tg->run_credit = 0;
>  		}
> @@ -150,8 +144,8 @@ static inline void replenish_budget(struct evl_sched_quota *qs,
>  
>  static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled */
>  {
> -	struct evl_quota_group *tg;
>  	struct evl_thread *thread, *tmp;
> +	struct evl_quota_group *tg;
>  	struct evl_sched_quota *qs;
>  	struct evl_rq *rq;
>  
> @@ -167,7 +161,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
>  		if (tg->run_budget == 0 || list_empty(&tg->expired))
>  			continue;
>  		/*
> -		 * For each group living on this CPU, move all expired
> +		 * For each group pinned on this CPU, move all expired
>  		 * threads back to the runqueue. Since those threads
>  		 * were moved out of the runqueue as we were
>  		 * considering them for execution, we push them back
> @@ -178,7 +172,7 @@ static void quota_refill_handler(struct evl_timer *timer) /* oob stage stalled *
>  		list_for_each_entry_safe_reverse(thread, tmp,
>  						&tg->expired, quota_expired) {
>  			list_del_init(&thread->quota_expired);
> -			evl_add_schedq(&rq->fifo.runnable, thread);
> +			evl_add_schedq(&qs->runnable, thread);
>  		}
>  	}
>  
> @@ -195,7 +189,7 @@ static void quota_limit_handler(struct evl_timer *timer) /* oob stage stalled */
>  	/*
>  	 * Force a rescheduling on the return path of the current
>  	 * interrupt, so that the budget is re-evaluated for the
> -	 * current group in evl_quota_pick().
> +	 * current group in quota_pick().
>  	 */
>  	raw_spin_lock(&rq->lock);
>  	evl_set_self_resched(rq);
> @@ -221,6 +215,7 @@ static void quota_init(struct evl_rq *rq)
>  {
>  	struct evl_sched_quota *qs = &rq->quota;
>  
> +	evl_init_schedq(&qs->runnable);
>  	qs->period = quota_period;
>  	INIT_LIST_HEAD(&qs->groups);
>  
> @@ -337,8 +332,8 @@ static void quota_forget(struct evl_thread *thread)
>  
>  static void quota_kick(struct evl_thread *thread)
>  {
> +	struct evl_sched_quota *qs = &thread->rq->quota;
>  	struct evl_quota_group *tg = thread->quota;
> -	struct evl_rq *rq = thread->rq;
>  
>  	/*
>  	 * Allow a kicked thread to be elected for running until it
> @@ -347,7 +342,7 @@ static void quota_kick(struct evl_thread *thread)
>  	 */
>  	if (tg->run_budget == 0 && !list_empty(&thread->quota_expired)) {
>  		list_del_init(&thread->quota_expired);
> -		evl_add_schedq_tail(&rq->fifo.runnable, thread);
> +		evl_add_schedq_tail(&qs->runnable, thread);
>  	}
>  }
>  
> @@ -358,79 +353,82 @@ static inline int thread_is_runnable(struct evl_thread *thread)
>  
>  static void quota_enqueue(struct evl_thread *thread)
>  {
> +	struct evl_sched_quota *qs = &thread->rq->quota;
>  	struct evl_quota_group *tg = thread->quota;
> -	struct evl_rq *rq = thread->rq;
>  
>  	if (!thread_is_runnable(thread))
>  		list_add_tail(&thread->quota_expired, &tg->expired);
>  	else
> -		evl_add_schedq_tail(&rq->fifo.runnable, thread);
> +		evl_add_schedq_tail(&qs->runnable, thread);
>  
>  	tg->nr_active++;
>  }
>  
>  static void quota_dequeue(struct evl_thread *thread)
>  {
> +	struct evl_sched_quota *qs = &thread->rq->quota;
>  	struct evl_quota_group *tg = thread->quota;
> -	struct evl_rq *rq = thread->rq;
>  
>  	if (!list_empty(&thread->quota_expired))
>  		list_del_init(&thread->quota_expired);
>  	else
> -		evl_del_schedq(&rq->fifo.runnable, thread);
> +		evl_del_schedq(&qs->runnable, thread);
>  
>  	tg->nr_active--;
>  }
>  
>  static void quota_requeue(struct evl_thread *thread)
>  {
> +	struct evl_sched_quota *qs = &thread->rq->quota;
>  	struct evl_quota_group *tg = thread->quota;
> -	struct evl_rq *rq = thread->rq;
>  
>  	if (!thread_is_runnable(thread))
>  		list_add(&thread->quota_expired, &tg->expired);
>  	else
> -		evl_add_schedq(&rq->fifo.runnable, thread);
> +		evl_add_schedq(&qs->runnable, thread);
>  
>  	tg->nr_active++;
>  }
>  
> -static struct evl_thread *quota_pick(struct evl_rq *rq)
> +static void quota_out(struct evl_thread *thread)
>  {
> -	struct evl_thread *next, *curr = rq->curr;
> -	struct evl_sched_quota *qs = &rq->quota;
> -	struct evl_quota_group *otg, *tg;
> -	ktime_t now, elapsed;
> +	struct evl_sched_quota *qs = &thread->rq->quota;
> +	struct evl_quota_group *tg = thread->quota;
> +	ktime_t now, consumed;
> +
> +	/* Timer off means that we are not tracking quota. */
> +	if (!evl_timer_is_running(&qs->limit_timer))
> +		return;
>  
> -	now = evl_ktime_monotonic();
> -	otg = curr->quota;
> -	if (otg == NULL)
> -		goto pick;
>  	/*
>  	 * Charge the time consumed by the outgoing thread to the
>  	 * group it belongs to.
>  	 */
> -	elapsed = ktime_sub(now, otg->run_start);
> -	if (elapsed < otg->run_budget)
> -		otg->run_budget = ktime_sub(otg->run_budget, elapsed);
> -	else
> -		otg->run_budget = 0;
> +	now = evl_ktime_monotonic();
> +	consumed = ktime_sub(now, tg->run_start);
> +	if (consumed < tg->run_budget) {
> +		tg->run_budget = ktime_sub(tg->run_budget, consumed);

You also need to update tg->run_start. Otherwise, you will overcharge
the next time this group is checked here.

> +	} else {
> +		tg->run_budget = 0;
> +		evl_stop_timer(&qs->limit_timer);
> +	}
> +}
> +
> +static struct evl_thread *quota_pick(struct evl_rq *rq)
> +{
> +	struct evl_thread *next, *curr = rq->curr;
> +	struct evl_sched_quota *qs = &rq->quota;
> +	struct evl_quota_group *tg;
> +
>  pick:
> -	next = evl_get_schedq(&rq->fifo.runnable);
> +	next = evl_get_schedq(&qs->runnable);
>  	if (next == NULL) {
>  		evl_stop_timer(&qs->limit_timer);
>  		return NULL;
>  	}
>  
> -	/*
> -	 * As we basically piggyback on the SCHED_FIFO runqueue, make
> -	 * sure to detect non-quota threads.
> -	 */
>  	tg = next->quota;
> -	if (tg == NULL)
> -		return next;
> -
> -	tg->run_start = now;
> +	tg->nr_active--;
>  
>  	/*
>  	 * Don't consider budget if kicked, we have to allow this
> @@ -439,25 +437,29 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>  	 */
>  	if (next->info & EVL_T_KICKED) {
>  		evl_stop_timer(&qs->limit_timer);
> -		goto out;
> +		return next;
>  	}
>  
> +	/*
> +	 * __pick_next_thread() might have requeued the current
> +	 * thread which is still leading the pack.
> +	 */
> +	if (curr == next)
> +		return next;
> +
>  	if (ktime_to_ns(tg->run_budget) == 0) {
> -		/* Flush expired group members as we go. */
> +		/* Park expired group members as we go. */
>  		list_add_tail(&next->quota_expired, &tg->expired);
>  		goto pick;
>  	}
>  
> -	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
> -		/* Same group, leave the running timer untouched. */
> -		goto out;
> -
> -	/* Arm limit timer for the new running group. */
> -	evl_start_timer(&qs->limit_timer,
> -			ktime_add(now, tg->run_budget),
> -			EVL_INFINITE);
> -out:
> -	tg->nr_active--;
> +	/* Arm new limit timer on change of running group. */
> +	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
> +		tg->run_start = evl_ktime_monotonic();
> +		evl_start_timer(&qs->limit_timer,
> +				ktime_add(tg->run_start, tg->run_budget),
> +				EVL_INFINITE);
> +	}

I still don't fully get how the limit timer should be started on
setparam over the current thread. Will curr be NULL in that case, thus
curr != next? Is that the reason to go for a separate runqueue?

>  
>  	return next;
>  }
> @@ -542,7 +544,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
>  	 * Unregister the group before we drop rq->lock. As a result,
>  	 * it won't accept threads anymore while we are busy moving
>  	 * the current members to the fifo class, and concurrent
> -	 * evl_quota_remove requests would receive -EINVAL.
> +	 * quota_remove requests would receive -EINVAL.
>  	 */
>  	__clear_bit(tg->tgid, group_map);
>  	list_del(&tg->next);
> @@ -556,7 +558,7 @@ static int quota_destroy_group(struct evl_quota_group *tg,
>  	 * hold rq->lock on entry, we do a trylock dance to prevent an
>  	 * ABBA issue. No livelock is possible since we unregistered
>  	 * that group already, so &tg->members can only be depleted
> -	 * (by this loop specifically).
> +	 * (by this loop exclusively).
>  	 */
>  
>  	while (!list_empty(&tg->members)) {
> @@ -583,10 +585,10 @@ static void quota_set_limit(struct evl_quota_group *tg,
>  			int *quota_sum_r)
>  {
>  	struct evl_rq *rq = tg->rq;
> -	struct evl_thread *thread, *tmp, *curr = rq->curr;
> +	struct evl_thread *thread, *tmp;
>  	struct evl_sched_quota *qs = &rq->quota;
> -	ktime_t now, elapsed, consumed;
>  	ktime_t old_quota = tg->quota;
> +	ktime_t consumed;
>  	u64 n;
>  
>  	assert_hard_lock(&rq->lock);
> @@ -615,16 +617,8 @@ static void quota_set_limit(struct evl_quota_group *tg,
>  	tg->quota_percent = quota_percent;
>  	tg->quota_peak_percent = quota_peak_percent;
>  
> -	if (thread_on_quota(curr, tg)) {
> -		now = evl_ktime_monotonic();
> -
> -		elapsed = now - tg->run_start;
> -		if (elapsed < tg->run_budget)
> -			tg->run_budget -= elapsed;
> -		else
> -			tg->run_budget = 0;
> -
> -		tg->run_start = now;
> +	if (current_on_quota(tg)) {
> +		quota_out(rq->curr);
>  		evl_stop_timer(&qs->limit_timer);
>  	}
>  
> @@ -646,7 +640,7 @@ static void quota_set_limit(struct evl_quota_group *tg,
>  		list_for_each_entry_safe_reverse(thread, tmp, &tg->expired,
>  						quota_expired) {
>  			list_del_init(&thread->quota_expired);
> -			evl_add_schedq(&rq->fifo.runnable, thread);
> +			evl_add_schedq(&qs->runnable, thread);
>  		}
>  	}
>  
> @@ -786,6 +780,7 @@ struct evl_sched_class evl_sched_quota = {
>  	.sched_dequeue		=	quota_dequeue,
>  	.sched_requeue		=	quota_requeue,
>  	.sched_pick		=	quota_pick,
> +	.sched_out		=	quota_out,
>  	.sched_migrate		=	quota_migrate,
>  	.sched_chkparam		=	quota_chkparam,
>  	.sched_setparam		=	quota_setparam,
> 

Looks ok otherwise, tests pass as well.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
