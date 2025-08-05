Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354D13E02D
	for <xenomai@lists.linux.dev>; Tue,  5 Aug 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396534; cv=fail; b=LeXIEJMhM8nTlvOndi9CEQfNbt6fISjrNhk4IIXukqN19dtBuCK+dUhjTUWG6an3TEwYZoz0LRvJ1UHPeTKgKpBZHun+lrkVhZ+YC9fOt7LYzKO4vbuX8zvDgnFSiA+WVETdaJf7SlibPDTiNdrgh64ZI4Itm7LTsbQPPCzlWlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396534; c=relaxed/simple;
	bh=1m2RyyLqPyy06zFR0uy+4G4aNzGEE/D3yUl7YT5IqpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kY3SWeGt3IjUxCtuJ5lSp003WL1TCjaaa4nYk2FKL0WqfnyU0cJyNFe9oCnm5O8WJeEh1pyabd2ErNSxnpfSXs4Mix1YCdav9CdY1LK8nufmJSZ+VYpbzXGZ5rGj0zqFKNnAke6MD5DOQqJfV21yoe6iubKkV2nd6qFlrK7FLwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wxMT5tAr; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wxMT5tAr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjL0cu+INmwZEWInr35GhhEUlFLC1U2vzahzVu6yumj3VFnZGFw2vHBH3a/EX6uG1gDWFwcjf+d5a7dOoE9LldTqudazkuF7UxBiJAA884xdGGiYRr8I3e8e2u/eK+Z5cfBo6WHUSbDgRMLV4xgCBef5r2owO9tTOF8X9A/gZZweTt8UHRwCqgB0gBPJWngbMziKoWyj8rEReI78r5m3MUigROJAZPwgPHWNdE5LioVyl/YLkv1b4cQOzzgLfEnpifZVkF79bNsUN6dCbxDvDruLxA0vLIepja6Q1ciFMGHGhUtgZB65Oxx/wUrZxCrOyE7WXYy3vcO2JGPI2SlMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/44AqgY5GOTIkuYPIH6GPRENY+ybyBsFV6668oxofrk=;
 b=uXvpH+4cZo7/q5dXu+J/tcrCsd0wCl60eQSVqJciIKyJnz5/+bJvkzcKLbUszNQJOjgiAIo3pyud9rzGnfHd+DQhi04W7NWHwTDxSo8yoHOjvpABWDeXzKY1zlX7obV/L3i03PddSOulEWYs4gHp+cDyGgHCQjnNhN4hpsGIN24VVpWiPm24UHwxUqY3O9iOPTOe7+zEkr8MhnJ8PLLADmj4c3PV06qwYfntjBlSt4uffPnAahF2YxtvZn9P0o520QkdddvLDaAcRjO9tJ1mIPbvhifPoosOtn4WF0ajtEeKh6dAnUIqFN7Rm1m3I5+ge5ymHKDPRolBpwKvA+3tSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/44AqgY5GOTIkuYPIH6GPRENY+ybyBsFV6668oxofrk=;
 b=wxMT5tArxUn+iP7E1YJ0arQnp7meIIm6XGjonCGhxywANexzh3ZhMbeVSuA05vp1tBBtic+M9z+NaOmxInpJ9JRi91Ap/zOiljH/O0vXFLc1I8Jnm22+CfuuL3ZiIMEQdwG53APjiwHIIjgrSfVC5fviw1ms1gkYhJl5QbZYfVBi2K+bYCvL7FpQQaB/GER7DtFPOAphqzc28lv0cK3dOQSHH/wJLRRYY7A3p4O/IkmnhYASVT9PWVrqEEn5mepf/eIMTRi8CgABJaBJWje5XFeRwME3CVhOQdsNuSNQpKlut0iyDysJKEb0qme7luSMhM5TFwYL1Ckdb5B2VY0OgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 12:22:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 12:22:07 +0000
Message-ID: <0da48454-40a9-4cea-bf10-24127c6bdc58@siemens.com>
Date: Tue, 5 Aug 2025 14:22:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fix RTCFG_DEBUG macro compilation error
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn
References: <20250805111445.313736-1-liuyang@sinsegye.com.cn>
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
In-Reply-To: <20250805111445.313736-1-liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:610:77::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3482:EE_
X-MS-Office365-Filtering-Correlation-Id: 59457082-8cb0-4f17-66cb-08ddd41ab1a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmhTbGpISW53aGRhWmZQWVlncDFNVjJCYm1jaUduNUwrbWZ6VFpTUVRoUU1N?=
 =?utf-8?B?c2h4c3FTQnRETjF3bEpTMEk4SW1aTGZ5OXlvMnc5ZXhNcEhTZnVFWVZyTzZU?=
 =?utf-8?B?N1luNnYvK2c0bkJsbC9BVGk3Q0FxTHhVZUNiY3NvNElwMHJTVlNQaUdGbHkr?=
 =?utf-8?B?NS9sWC8vVkpzcWpwQkg4Zml0Y2NvaDlnaExNM3hyeU9TTlVFS2ZKb1NGZmZ1?=
 =?utf-8?B?RENLNUdqME05QUJIYW1zc1p3ZGlBR2hnZDdvR2RLRmE1UVNEMTJLTDFEaDM0?=
 =?utf-8?B?MHczeGVSSjNHZVdIdElPOXJJeGNxbG9sSTNVdW05bDJkMXQ2SG9tMzJLYUVR?=
 =?utf-8?B?NFN0ckVKL1ZyLzdrYVdoNmpucmtlTlQ1bWgrc2xkWTdqT2ZSbFF4MnN0OEQy?=
 =?utf-8?B?U0tEKzltUHdkeWZZaTg4ZmkrQm45U2RTZE1sRnZOTGVSY2pncVZmaE5qdXF3?=
 =?utf-8?B?ZnNNS1VxOWZkeUxXQWxVQlk0ZkN0Zm9ja05mYUdtL2Q0b09rWlRkS3hnZGs2?=
 =?utf-8?B?S2JRSGkyaFNMT21pcVpnb0VZRTFZVFVkNWNoNlJORktLbE1YYVgzWE5pNUsv?=
 =?utf-8?B?L3pXbXlQQVIzOW1ITVFNMUdGUGdXczRSdzJOdko4VEpYN1Z6Umo4YVloYllE?=
 =?utf-8?B?M2JYQ1JQWjlOU2N2amQrcms4Y0F2aGRYNW41QnZLTEtYYnJzeW1HUVRwWDBp?=
 =?utf-8?B?ckE0S1FKNXFYb0RtTlhLKzFPYjNXWk9GUnFWd2lHS3F6UHpTUTc5TlJLRWty?=
 =?utf-8?B?K0Z1ek5rYWtZMTRZOFJuOFRyeVZPa0xPVm1xYjEvbGE0U0wwWnJPK0lURmIy?=
 =?utf-8?B?Y3RLdVlRY21JdysxMy9EdURqUzVZQzdBNktZNElYNjlQL1hwMVNNZ1FISW94?=
 =?utf-8?B?TnZKQ1hBTktHOXZPQ3crOHB2ZnlaT0hvVmVLL2h2WFUrU3pJSFh4d3hqNnNq?=
 =?utf-8?B?ME5yNm12UXpxYzlIRjlHR25Walo5QTJLUHFGSWM5bGhUVHB2UkFlNXUvVjBO?=
 =?utf-8?B?eDNidElYTkFrZUprRXBVM2RJbFh1dDZ6WGlrRnkybkNyZVI1UWRURWRhMXRx?=
 =?utf-8?B?c0xrNTl1L3VaNUNvbXM2c2J6MjNNNlNBSXJGRzkxY01RckMxZnJGd3Nqc0kz?=
 =?utf-8?B?Z0NJWUN1SUdGRzlsR0JtbXlsU013cC9OcmFSNmxvem5qRVpkOFJlTlpWUFZS?=
 =?utf-8?B?MDdlSFNIYTZPS0JyaUlTSnJ3WC80eFJFM3h1TVg2OHJsWm1VWVNybHhINmRL?=
 =?utf-8?B?ZWpZeGN4SE5PZHpIak8zNnV5Z0o2cFQxb1lJWEVRTVIyZWZGNUJSd3prbnFy?=
 =?utf-8?B?alJ1V2d5VmdmN1NtLzhNaTNra2k5bUl2ZEVGbCtJMzlCMk1ZVU1XUXBaN0xU?=
 =?utf-8?B?VG9iUEV6Y3A0M3RLd2ZCVGp4NTMxSXdCa1dBWWRxang5dWJhMEdVcERNTEJP?=
 =?utf-8?B?SFVDd254bzUvTFNxNVRtbCs5NEQ3SUFuVjR0amJFMjNLUk5yaE9Hb0YyVU9u?=
 =?utf-8?B?SFlIL3pkNVRSbmNqelN5cnU4RVUzOGFaZzk5Rkh2N2UzaWZyZk44YUgwZDFK?=
 =?utf-8?B?YklFem11MWczdC90SmtaMnpRUzdoQnJSWUFJMTA2MXBHbmIxZzViTmM2WHVr?=
 =?utf-8?B?QmhsaG11RmkzclpLeFFDdWF2eDdkNDdLQTdUNmVBL3l6OVJDc0FwUGJvMHZF?=
 =?utf-8?B?c3VodzV6NWRjNjk5ZEREYW5OdXhXc0lPeHVhUjBjMExqM28rQkNmUEpGN2tD?=
 =?utf-8?B?MjNXQ3c4Z0RIYjY0RVVSenBobmFSZlJaSVluVGpaV1dEUVhscmFVR0NBVC9E?=
 =?utf-8?B?MmhUVlhHQ0NHV0Rvai9RejlMY05PR2swbnFqSzdsZnNnMWdzczF4d0JySmZ6?=
 =?utf-8?B?K3RBdmluVDBpc2ZtemxwbmtNSXRBMXVQbDVrSjZLS3djTnllK1E5L21YUDJ4?=
 =?utf-8?Q?C2FrKqXUL5I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0ZhbHl0OW0xTkxtekJtb1NKLzM3RWtmWWQ0L1VESTJkUkU1U0FiVHhzZytC?=
 =?utf-8?B?RUNtZlB6SWVXdGY0eEViL2w3c2l4ZDhvZzdoYk1nV0RpWU10dzYyVm42Wnhr?=
 =?utf-8?B?YnA0aEc1QTNuZ0JncDdxR0NTZHVKcFpKOGtKZ2dNUjVxYjY3Q0dXdkVUMTJR?=
 =?utf-8?B?Z0pKQVVGMFpDcUtiZWZkWGJpZ3FOWXZHRXZna1E5a0cvREFNOURLOTEzd0lU?=
 =?utf-8?B?VjJPcjBxcW9nSnFvRkxDL0dpT0NpaEZ1K0tsTmNUT3lFdWNjUHo2aG1KMFln?=
 =?utf-8?B?UzJ6NVpTVkJDMlFoZUdMcFVNL2hJNUxCakFZZFlDeTRSdGRyM1kzR2R5MTcx?=
 =?utf-8?B?ajNlUHgyMEV0TGpVbEFpQmQ5ZEZFbnZybVJ5M0pxTlFXR2syRTNjZ1llMXMx?=
 =?utf-8?B?eE1KL0RibUtCZENvT2pjS1RxK1pva1BKM296bnVmMElZemg0NGN4Q3JXWFlG?=
 =?utf-8?B?QkorTmhRZjZLUFhmR0VLQysyNFVWMk9YZndwdlZvUFo0eDNDZzgwWDhTZVhl?=
 =?utf-8?B?Q0pPTEVWbW1UMDhNWHdEdHRZblJDQ3FhVTQ2UGU0b2VBeEhWK0hSc2pNbTF3?=
 =?utf-8?B?Z1RZQkRyQlpwRlRrcUgzLzRRQnR1QU9xd0RTZ2djZjZZRDNYcWhpOTQ2RnBB?=
 =?utf-8?B?VmpQWENSL3FLL2U3QzByQm1jbVpxdVV4ZTVWaG9pOWgzVGFVK0N5QzVkK0tw?=
 =?utf-8?B?WTIxTjZmNGZOUFF2bkFFci9rRUhQN1RLRWNYamwyQ0VzZGZsMHYrNlBMSnVG?=
 =?utf-8?B?K2pnSzRTT01Vb2Jldlp3ZHFkVnFreUNJcEpRRFNvZW5vZmFWbjNHYnF1cEwx?=
 =?utf-8?B?U3N6RU9JZWFLYWJtL1c5aHRpb1hpSWg4UDc3a0tMT0dxanlnYVdpRUFEeUJq?=
 =?utf-8?B?VXZzclQwbW5DMUhhQlZlUzFBeENOeEp6SWQzSytleXlFb2RueHdoajEwVXZu?=
 =?utf-8?B?ZDRlUmpWbi9OekE4WHh4b0JVR0xlV1plZWpOYngvK2ppVXF1SzZmRVJ6WWlq?=
 =?utf-8?B?WDdvNTNJbVlxU0p4S3RiVWYybWJycTNhQU1FRHYzM2JaVlhhREVKU0RPK1Bn?=
 =?utf-8?B?c3NyNDBNTnZBNkVnWWpBS1dJekVBREZoeVhHRlh4bmMxUnBOSUh6MmNnL3U5?=
 =?utf-8?B?M0xPcG9vWWxuQlNCOVM2QlZoZ2hxdUFQdVJ0YzVlUDVqSVpLTmE4bllpVWYz?=
 =?utf-8?B?NThFd1I4cFNySlhVQy8zQ2x5emd5TkhPeVVOZndNaDJEbm9xTXY2S3JBcGtz?=
 =?utf-8?B?cEFBNVFwcFZudWs0b01kVHg0aVBLREcvQkRrVzdNejVQelg3TC9teFRMbVlU?=
 =?utf-8?B?bWs4SGFIWm0zOTR1Lys2bXZZb1hEck15RjBXek1wWXA0ZUlxaE5VZzFVeGVm?=
 =?utf-8?B?NzNXTnZVYVdQb3U3ZmNCcmZtbmZQekZHT0cxZTBzTXlQZVEwYlhyNi94VGpj?=
 =?utf-8?B?MjlsMVFEWDlyK3VWTzFjNEJuMWpkYzEzTmZ2eVMxV3lNcHV0cnpPa0FWTFVP?=
 =?utf-8?B?d1JxQStwamlUc1ovRzdadU9hbURpQkxSWmNJTXhjaG55R2pzOWk0UlFuODNN?=
 =?utf-8?B?L0Y3MmRDUjkxVVRjaXBFYmdCcWZseXl3ckZSeGdnaU8zR3hkWFM5L2RkMzgz?=
 =?utf-8?B?QWVHazVqUUZpUFdMZDVBeVlNZU93MFY4SEFwZ2dSUEVSS1VzSHNqUElLWUxI?=
 =?utf-8?B?aTdOc3prVlRWVndZK1FkMndQRDhPdkVwbnBZc05RTWluZHFtUjlsQVJNSG1z?=
 =?utf-8?B?S2Vtd2lUMmZGdlhVQnR6bkg4SGxsWTlKRjNQSFFCcnd2OXM0QnBwaEdNT1B4?=
 =?utf-8?B?aWZBTFU2dTY4ekFVLzVFaGZjM0MwRE5zRlhOc3dvaEdNZHNnRFNkZEN5cmRL?=
 =?utf-8?B?d3hyN3VWa2VwdnB3Zjc2b211VXFOR2FtaGdoakNCZ3BMZDRad3VtcHFIQ0lE?=
 =?utf-8?B?UVRXWktCUk5yN0pWVGZyWFBnbW1QU3RiTDIwTThFRDdwQkFHb1NSN1NJaUpi?=
 =?utf-8?B?Ky9RWXUvSGlwVnFRMnJzREdiSEowZUszU21Cbm1aOXlXWDdmbjRRSDFiOFR5?=
 =?utf-8?B?b0FuQzJNaFlWTXIrREkyUmdrODhNMjZkWGVxSnQyZmlUWlhYYm5ENkVhdlZ3?=
 =?utf-8?B?NUZqWVp5dFhoVEZyNVdKb0dJTXE2SlJVV3NqaHBTWjlTSTUwVk5wdFY0a0Jk?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59457082-8cb0-4f17-66cb-08ddd41ab1a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 12:22:07.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrNu2OL2gCZNA6x196tH8ZYcOJ5h4x3V1v2A6AOEpIoBV0LJFsLdOAg1QDQmfx0pBbM2N20uaSWHEG4Ee1oaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3482

Would be good to explain here (in the commit message) why / when
compilation fails. One needs CONFIG_DYNAMIC_DEBUG which reveals that
pr_debug is "returning" void, rather than some int, and that is causing
the build breakage. Is that correct?

You could even cite a compilation error here as example again.

Thanks,
Jan

On 05.08.25 13:14, liuyang wrote:
> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  kernel/drivers/net/stack/include/rtcfg/rtcfg.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> index eb9ad076e..df0e8e06d 100644
> --- a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> +++ b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
> @@ -41,8 +41,11 @@ extern int rtcfg_debug;
>  /* use 0 for production, 1 for verification, >2 for debug */
>  #define RTCFG_DEFAULT_DEBUG_LEVEL 10
>  
> -#define RTCFG_DEBUG(n, fmt, ...)                                               \
> -	(rtcfg_debug >= (n)) ? (pr_debug(fmt, ##__VA_ARGS__)) : 0
> +#define RTCFG_DEBUG(n, fmt, args...) \
> +	do { \
> +		if (rtcfg_debug >= (n)) \
> +			pr_debug(fmt, ##args); \
> +	} while (0)
>  #else
>  #define RTCFG_DEBUG(n, fmt, ...)
>  #endif /* CONFIG_RTCFG_DEBUG */


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
