Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4513AF9
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197313; cv=fail; b=Us75PncfzPu9/tGeE9hGXwXBbDAYqEfyEKgtKosEz8Hete2mSmoXqj3G5EPoSnR1pmFpQMG2cP4DcqY22RCgWK+rBr7WSpxf4JvGv4EqGRkNkrYC1xVwgi/ZDFZwxR9zne6Rf7Qm8yl3IMqTaBrT1stHPJE2w3VktD4/K8dCka8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197313; c=relaxed/simple;
	bh=Sc6uGLNCO4pexyKPihUvbGwxXChdYc0virIER2JkVfw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FuuPo6F80dv5hJDysOnyHuosMcti/ft701acHFbRjVNPKm7+bsBrfjnUmUYXllbgm/FrFkxb6cRmarTiIiTxd20RpcQ90+URNkGbX2DU2fwIeW6cdwUUZTEYt3tinaIxt2TNSx/yHX1W9zbwgUeCaPzjIv5XZj3+kV4JPwPaMvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=C5Y2ECyY; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="C5Y2ECyY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Why7vZvB+Az0JA0bKy6PkdBKvi/ZEIhVvmcAHhoAujVIqLLQNUhFBB5V4rB70ewj6hVfAL/kvNTVl8TmYM+NrOiZP0vWDpbSUd9xTqp7FNqwPT9WhcBDD3dARIDYmU5Ue4/nNbNb+eAhvZ2Y9zJR/ySIQE9pxiT0SPP5xjrCFqTcoS4I121X/tdTWD3ITuyEukRahMeroXqLBiga8U0Zmy2MkFXsPODDpG94p5J5JJSz4IixZVm6kfSJcEYJUGpeXa9KiSeFz0eBMtdeamwJ0KAvkIxL0K3bUL3OOTkEfEcj8O7G5+vtQ+Pp/U9eI/z08upmX9N10dRqveGnhXvQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/4LzOIaN0+6JTACEHOd+VMyPYJuVI8/Kc5Yytu7PG8=;
 b=c8BPYQQhf7GajCNQPA0S+TPRELlc73UblUwVq4129VpKZovqNihRHjxynEDvfMtgiKipkH2FdWx2DaJFJrC+pfmcVAYO6jkBKUqnoOW9EjRKg+Qn1OEcBOIv24pSLN4RviYn6sxYCN7UvZ1zKgqle/j5v+VJtyfD5VuTmIh8OTLLZI91fwpEDyKAkkHQkBWMc4cqu5cFFSI9bsjsisEFNdbLwCb9F3xdejTIW5c8UX/KMipEAM6iEDn0lK3RUpN/VohaktyX+XpbuOJccoTaRPOd5mVSKPQi4k1+Ffaz/JctI0pqUW/7qkNg4lR3XXEl8ioUUMsgWfFpNwkc7/O0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/4LzOIaN0+6JTACEHOd+VMyPYJuVI8/Kc5Yytu7PG8=;
 b=C5Y2ECyYypA/qXZtMC6dxBYRPmkD183PF3Xlh9rsNan8Dk+9ocVUnKnzZkJ9ym6v6qRqyTIHnjEXATEKyyb4Vq2ui4BvlDsp4riu51v6jWhyP/7Ayz6G5elcs+cnKwWLmyEzyYPjVm5gslWJT0Qidr+k+uv3Yp/oraF/qWcguHQV7Z+R940m+0+YSml2NCHdjh3ZDT5WEyiqCMOodLAKmyNmebhLSpFCvNeehUbeaO5mcHl+FmD7xbdCqctO/mkaLKBjaubPP/FUk4mCzFSSWOHBMZzinGBF06Y7DJJ1S1Wz4r0Cn/LdTIP+H5mmVgOUWDh2wmN/5Gre4OySgrRvVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3647.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:140::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 06:21:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 06:21:47 +0000
Message-ID: <140e76dd-773e-49b1-a587-fa51576bc018@siemens.com>
Date: Wed, 17 Jul 2024 08:21:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ci: Add latency threshold to longterm tests
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
 <20240716183326.1432379-5-tobias.schaffner@siemens.com>
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
In-Reply-To: <20240716183326.1432379-5-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0649a607-342e-4497-ff0d-08dca628bcba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHpFcEJxKzFFVStIakVCVm84NTJsQWZiUzZUckNmM1lYeUJBNVdCZVMzdlVx?=
 =?utf-8?B?MmNuT0Q3aHVEMDhwdGtrWlhPTlBPWmswaHdid3pORHFTRUNCZlhGOU1TNEhK?=
 =?utf-8?B?UGhlaHYrUzE1OUlFK2NncXN1YjhXUC84dTNITlprUDhubjJRTlVjbG9hVXVK?=
 =?utf-8?B?TlFzR2loL2VFNG4vUHRLaC9SWEVrZlA3U3dFYys3SGdwQ0gzNk96WitTNzdp?=
 =?utf-8?B?UDZ3VThmc0dBVEJpOVhENWJETEZXMzhrMjBEeEtCRjg2TWgwVzBMalNBZmY2?=
 =?utf-8?B?RTlsRVV6MUQwVnk4U3d4Y0ZRSWxGSkVpTWtCeHNxTXdoaDhjSGI3Zy8zN0x3?=
 =?utf-8?B?V1pTM0luMU03ZE5FTVVqNjMvaXZQRmZZZ3pZVnliQVQ2b3lySmpjMklMV0hX?=
 =?utf-8?B?blJvVTUwZS9iMUtYQzBDck5sZ3hyNzJRU0VTT3ZNV2tEdFhIOTRJSHhwNkNY?=
 =?utf-8?B?amVIMWhaSFd4UnNCQTRpVnVXeDdmbWFHWFJYMDFaNVpaVDV4UG5zTUhab0hl?=
 =?utf-8?B?QTRqZXVla1NGR2lScElWZG00bFRzeWRleFNYcTdGU25OTnpSb0czd3ZvSHB4?=
 =?utf-8?B?TlIzN3NxV0daZUQ0VUJaYWJ6bXZJdTBzQXltMXVubWM2cmQvV0NVS1NUQXBL?=
 =?utf-8?B?VlNzbU96Q2U1ZklObUZhRXZRYVFxY1V5K01xVFpHUE1ZVWM3MDNWZEpFQzFw?=
 =?utf-8?B?UVI5MDdLR2RxbVE0UmlJbHovRDNNVTQ4WHA0VjVTTjg0OEQ3TGFHNVR4Sm5M?=
 =?utf-8?B?UFZwdWoyOHZhNFpweUl1ZlA4ekYrb0tYOHU4QWJQUk12Wk82aFlkelFtMmxN?=
 =?utf-8?B?Y2tHTitrenpaQ05yTE84elplQmtUYWlRQmRqRTlqYWQrdXN0MFJrTE8vOUlB?=
 =?utf-8?B?ZThQdTJUWkEvZzR2SllkWGtYMkc5WDJaRVVIZ0FKWFF5NmhFTEp6bTY0Q0Ev?=
 =?utf-8?B?VE9Wb0FtSnFwRXd6eXBaK1dYeVJBZ01jQ1dQQjgwQUR0L1FhNUJBOWZ3OVRJ?=
 =?utf-8?B?cFZJd2RLbzVUUlNmVUhEZzV4a05QWUNObjhscG5TVFkwNGY5VFNud01LL2k2?=
 =?utf-8?B?VERPL0xweStDd0xIZnd3eDJPM25DKzNXaGEzRmV0aHMyU1Z4R3JUN1dkcUNw?=
 =?utf-8?B?aW83WG5iK2FpdXpYQkdJekowb2paWHZZQTNNbURhU21yN05Qdktlanc4b3p6?=
 =?utf-8?B?K1c2MmpHeDZmQjI0elVnQ3hZK0hNWFBySlVxeGZEd0VEL1dOa1pJc24zS0Zo?=
 =?utf-8?B?ek9vTW5lbHBaU2MrS3c3YjJIdnhxU0VmSWxiUlZwWVNKTHBpUkNCaFl2Zi9B?=
 =?utf-8?B?cWJISUhuUjdORERNLzhlY3QxM0JCQW9BVjdRV3NTTUtpWTlJc1E0ZG5XaGZo?=
 =?utf-8?B?RmM4cm91MzB1TXdjdTBrdnFieXBBM0tBTFBBNXRSZHZTZGlzNE9rNFYvRUFJ?=
 =?utf-8?B?c1NLVzJBbzRWWjg5aUpJS1RJalhpdVd3QjdpVllETC9mL2huS0MxajAza2xL?=
 =?utf-8?B?S254bXFTSEtyQjdxZzRiY0ZHQ1hsT3BsUXYzR1V0T25kbmt4a2FyR0VGOWM4?=
 =?utf-8?B?VlRaTlhzVEVINFB6Zk95NDA5Tnd1TGdOM2NSTFBTUlV5WGhtWVZnNG96bzVo?=
 =?utf-8?B?dVRxVXdnUkFydHEwMFZRdmRKQWNtNVhoTWZLYzZXSmJpc1c2RDJDZE9iWjl6?=
 =?utf-8?B?YmIxck9oUTF0ZHo4K3V2Q2lwVm1GenY3aXM0V2IxNW9ocDd5MTZzMHlHbzkv?=
 =?utf-8?B?dTdpSnRQeTdGTzdjMzR1bTBTVWtxcDVlaGhKOVZBOGE2VHhQc2VJT00rVHZC?=
 =?utf-8?B?RlJKMHYvc2tBUm5rYVVhQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZsUEpPOGdoa3FvKzMwcHNmZ0Z0WElkcmJwcHlsblFSVEFvSDNwRHFUL1Ur?=
 =?utf-8?B?MTMwUnhjUC8wekk2bkdVZXR0RGZtZlNkVGxRT2NIMG1haXhpVm83UC9MeEp0?=
 =?utf-8?B?ZWRLQ3JxOHpsSFBsTzZoTXFFbm94SnV0QlVaZ0lObmVJenJkUFp1NVFBUHMv?=
 =?utf-8?B?bUtaK0M0Wk1vaWpMcFg3a0ZadnFyZXV3OG1mcEQwUHRjY3lkN0lLR3hCWWVt?=
 =?utf-8?B?UVg2bFhESGlsM3VOWFVoVkZlamtyME1ZbnpHMHJMbmQwU1dTUTBqblBlOEdZ?=
 =?utf-8?B?QWJYNFljbWRDazFIMGRDUDFpYUNLOVo1UzRWdVZ3WDlrbkppWXBSUlZzWXN0?=
 =?utf-8?B?Y29WcXhuSXhPbVR0dGFSVjlVMzVFMTU5c2NlQWloL2IwZmR1TjRnK2pRVHEr?=
 =?utf-8?B?Q2ZCdkJ0dnM2dGVsNnVKaHVON1d1TnkrWU1PNTZkK1AzR1RtWTBKTDJwSno2?=
 =?utf-8?B?VzFPKy9BRVNzT1ZFQktxMVhnVXNiV28xaHJLdktVSEhUQTczZTJrd2VkZ2or?=
 =?utf-8?B?QXlLbXBkTm4vY1Q2YnltZ1ZrM3UzNFlWK3hvS0ovcnArNExTUU5hRmNPVXds?=
 =?utf-8?B?RU9UVzlkYTJKV0FRWDZkaFlVMGorZkRxdE1IR0NITWpwWUFpL3NycTJ0VXd4?=
 =?utf-8?B?djVTWmxNVzBLaWtKczI1bU12Zmx0Nm1zMzFCK0V4c1RGVldIelpaamk3aGhU?=
 =?utf-8?B?MVZJcWY1RUxGNkRBZC9GZHlESTRjazZhVjdIWXVsOUJKblR1REV5KzlBeG0x?=
 =?utf-8?B?UDVBRE5ucXU0OVBEZjNxK2R0dnJtRUp2MmxUdG01UTNzL0k0K25pOHE3VUJE?=
 =?utf-8?B?aE5VVFFXN2dqQjIyQWRqcWRJa2h3dFVUa055RFg1b01oaUgvNHdMSXREa0FN?=
 =?utf-8?B?VUF4R0xRRnNLcjNEZG1LYnVBckhNeHlQVXdVNjdFZlBINWtUQmRiclpQSjRw?=
 =?utf-8?B?QmF2RUdweWFwM1NGbkttYmwvblp5TlcvNkxGeXdlZmxKMFZ6eW5kV0Y4RjJW?=
 =?utf-8?B?Nm5hTTZhd0hBMXlpYTFVMnZ3Y2ZtV0tFS0xNV0lQYWVHbGl4VzdOYlhocGVw?=
 =?utf-8?B?Tms5cXdhdTYzcWx4R2ZJeWRaMU9LazJBY3BGQUc5djRJTm14YmUzTU9vMTFZ?=
 =?utf-8?B?ZFg5ZGwyc0hLZ3Vjdk83L21XSExhU2ZhbnpEa1RESVUvNUpzNVZFV1pmOEs3?=
 =?utf-8?B?M0FLQVFyUmxUc2lGVCt0ZFdVM3U4ZktPbHZkNmlKMllqNFVwNkUvWDAxWkJP?=
 =?utf-8?B?eGhxVVpGdjJqN2xoUVVsUEJ1NUtWc0tjcjJnMlJwV1BTdVFsQ3MvT0FYMld5?=
 =?utf-8?B?eVYrdmFKV29uWmhJYmcreS9wRW1aUEd0NXkzb2h2bUNZR3NpMy9OVldmUmFG?=
 =?utf-8?B?Z1BTZ2Uwam0wYnBudTljaGg4UjZrZVpsRng4cmE2dmFydTV1Q0Zzc09hM0Ft?=
 =?utf-8?B?L0pvdGd5aDcxNGRTZDRsMEZFVkdFM1NGOTZ3MlorOVU5OWpuL1JjaTFOR1Fi?=
 =?utf-8?B?U2cyOUhPU3BqWC9Bdm8xTExqZXM3dkNuTmp0RlBFN1VEc2VmUGJhMkJGb1k0?=
 =?utf-8?B?NU1nNEtEMko4UEVDdDVuK2J5a2xBWnJCcmsvRWlpU1o2amh2OUZyZTZ5clVh?=
 =?utf-8?B?VGduZXpPRzh3M2s0WmhHZ25ST3QzNUtpcDNNSjFxMXhUQWJOblY2b1dpb0ly?=
 =?utf-8?B?N0hna1FGMW8xU0xKS2NYdE5yRG5oNmo1MWxnMW4yYnBaVWh5T2tyS1QzbkY0?=
 =?utf-8?B?TmNNbkp5cE9Gc01qMmtFSU91RXBuQitndUF2SmU0STRjS2tHM2FDUWJEdG1z?=
 =?utf-8?B?MUhoNHhtekJ0eWx5c1k1VCt2azFKTlFUNG1GRVQ1WHcrZTNQRHZUUmorNzgy?=
 =?utf-8?B?MGptRndWdjdDNkVXQ0ExYk1TOWpIVlB6QXNkL1lvakJ2TmpKWlRicU9iUncx?=
 =?utf-8?B?T2c1RjRRbVI2QlE3V0hLc09XWVJMWlRjOUQ3czNYT0VTV1p2ZzFSZ3pLN3pq?=
 =?utf-8?B?Tml6MS9wc01HakZRVWpwVWFhUUxmQUNjaVAvekl0Zmt4ZVpKSHJ3L0NWMUlk?=
 =?utf-8?B?TmZnTHl3NXR1MThGZTlnMXo5MzlnaFQ4cjQwK3ZIZkFkd1JQNjJ5Vm5mWlRk?=
 =?utf-8?B?V05YU2FHWTVLV3kvTldYVXRJcG5HVjRRRHdqNTRDQy95R1dzUWlEellGSmli?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0649a607-342e-4497-ff0d-08dca628bcba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:21:47.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYhD89FWPjVqZ/+ThK0CbPfXtvXKHxDTpfr692MjY4uq/5CG+hwb2dJ9dRJiRO3iAwsElLdV44Wll9nVv8DGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3647

On 16.07.24 20:33, Tobias Schaffner wrote:
> Add the latency threshold patch to next builds as long as it is not
> merged. Use the new threshold option in longterm tests to guarantee a
> worst case latency of 150us.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml                         |  1 +
>  ci/kernel_6_6_physical.yml                    |  2 +
>  ci/xenomai_3_next_long_term.yml               |  1 +
>  ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
>  recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
>  5 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 29960b3..bc9d525 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -22,6 +22,7 @@ variables:
>    ISAR_DISTRIBUTION: xenomai-demo
>    BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    TEST_RUNTIME_SECONDS: 300
> +  TEST_MAXIMUM_LATENCY: 0
>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>  
>  default:
> diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
> index 95fc4f2..e57eea0 100644
> --- a/ci/kernel_6_6_physical.yml
> +++ b/ci/kernel_6_6_physical.yml
> @@ -21,6 +21,7 @@ lava-test-6.6:rpi4:
>    extends: .lava-test:rpi4
>    variables:
>      KERNEL_VERSION: "6.6"
> +    TEST_MAXIMUM_LATENCY: 150
>  
>  build-6.6:beagle-bone-black:
>    extends: .build:beagle-bone-black
> @@ -34,3 +35,4 @@ lava-test-6.6:beagle-bone-black:
>    extends: .lava-test:beagle-bone-black
>    variables:
>      KERNEL_VERSION: "6.6"
> +    TEST_MAXIMUM_LATENCY: 150
> diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
> index 5fb0de7..e3740f5 100644
> --- a/ci/xenomai_3_next_long_term.yml
> +++ b/ci/xenomai_3_next_long_term.yml
> @@ -18,3 +18,4 @@ variables:
>    XENOMAI_VERSION: "next"
>    LATEST_KERNEL_VERSION: "6.6"
>    TEST_RUNTIME_SECONDS: 3600
> +  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"
> diff --git a/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
> new file mode 100644
> index 0000000..6adb7d8
> --- /dev/null
> +++ b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
> @@ -0,0 +1,76 @@
> +From 032a29ccb649cc2d076f14e7769bdee8eba8ecfe Mon Sep 17 00:00:00 2001
> +From: Tobias Schaffner <tobias.schaffner@siemens.com>
> +Date: Fri, 21 Jun 2024 09:35:08 +0200
> +Subject: [PATCH] testsuite: add latency treshold option to latency test
> +
> +Add an -m option that allows to set a maximum latency treshhold to the
> +latency test.
> +
> +If the option is used, the test will fail if the maximum measured
> +latency is larger than the treshold passed in microseconds.
> +
> +This is mainly implemented for CI long term latency tests to
> +automatically let the pipeline fail if the measured latency is higher
> +than expected.
> +
> +Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> +---
> + testsuite/latency/latency.c | 14 +++++++++++++-
> + 1 file changed, 13 insertions(+), 1 deletion(-)
> +
> +diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
> +index 7856b48b8..52e315d9d 100644
> +--- a/testsuite/latency/latency.c
> ++++ b/testsuite/latency/latency.c
> +@@ -89,6 +89,7 @@ int32_t *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
> + char *do_gnuplot = NULL;
> + int do_histogram = 0, do_stats = 0, finished = 0;
> + int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
> ++int max_latency_treshold = 0;	/* default = 0 (diabled), -m <max> (in us) to override */
> + 
> + #define need_histo() (do_histogram || do_stats || do_gnuplot)
> + 
> +@@ -536,6 +537,12 @@ static void cleanup(void)
> + 	if (histogram_min)
> + 		free(histogram_min);
> + 
> ++	if (max_latency_treshold > 0 && (double)gmaxjitter / 1000 > max_latency_treshold) {
> ++		printf("\nMaximum latency exceeded: %11.3f > %d\n",
> ++		       (double)gmaxjitter / 1000, max_latency_treshold);
> ++		exit(1);
> ++	}
> ++
> + 	exit(0);
> + }
> + 
> +@@ -614,6 +621,7 @@ void application_usage(void)
> + 		"-c <cpu>                        pin measuring task down to given CPU\n"
> + 		"-P <priority>                   task priority (test mode 0 and 1 only)\n"
> + 		"-b                              break upon mode switch\n"
> ++		"-m <max>                        fail if the maximum latency is larger than max\n"
> + 		);
> + }
> + 
> +@@ -648,7 +656,7 @@ int main(int argc, char *const *argv)
> + 	cpu_set_t cpus;
> + 	sigset_t mask;
> + 
> +-	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
> ++	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:bm:")) != EOF)
> + 		switch (c) {
> + 		case 'g':
> + 			do_gnuplot = strdup(optarg);
> +@@ -722,6 +730,10 @@ int main(int argc, char *const *argv)
> + 			stop_upon_switch = 1;
> + 			break;
> + 
> ++		case 'm':
> ++			max_latency_treshold = atoi(optarg);
> ++			break;
> ++
> + 		default:
> + 			xenomai_usage();
> + 			exit(2);
> +-- 
> +2.40.1
> +
> diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
> index a2e8802..07a63ec 100644
> --- a/recipes-xenomai/xenomai/xenomai_master.bb
> +++ b/recipes-xenomai/xenomai/xenomai_master.bb
> @@ -15,7 +15,8 @@ require xenomai.inc
>  CHANGELOG_V = "9999-${PV}"
>  
>  SRC_URI = " \
> -    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
> +    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV} \
> +    file://0001-testsuite-add-latency-treshold-option-to-latency-tes.patch"

Thanks for the implicit reminder (explicit would have been more
efficient ;)) - patch is in next now. You will be able to drop this in v3.

Jan

>  SRCREV = "${AUTOREV}"
>  
>  S = "${WORKDIR}/git"

-- 
Siemens AG, Technology
Linux Expert Center

