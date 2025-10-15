Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9506E555
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507169; cv=fail; b=S76dE+HYV7fhlQWzg8fWafw9ZVyihdnYhFI3IEaq9MoaO/ZEjSTpY0p8NwkhmyInTk8L7ZN5FKSWH/WN0pH6Lnxuz2SCJi3DmAt8Tzara/mVTYqT2XZaLxp0ccGUK9TFwZs3bI+1xmzLyQ5mBTR++pJFSvWDdaz9tXd94T6lI+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507169; c=relaxed/simple;
	bh=evTA5C5OS08iU60LnJUble7Dcjqo91fUv5jfKZWJb2g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SdT66aVF+ys+TTPznPulPkDse5DW8qwMk0Lqw1H/245hkAdID2ffr7aRxZWzd4rFNrKtnG30SHsBATAzZhh7qSGMezghdMxaB50rJeOnMNihdcxqnKotad7bDL1qY6KoE17OrHrPtGaP6+V94Cpp2EVjTrxyrk371CDVI8SQXS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EQVEssM8; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EQVEssM8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATwKqjUTUMm6X0q9S+inBoxKLd6USg/VYcDJrF7sCiNNA4o7a9kgUqD011w9ROSIoRiLMj1LnHvnil3CbNJsYN7BVnTSee8m0JXNZtW3/+foOjlDreqWUnmDWLaNoDN8BUA5kiYc6tkdwxRtJ6Wg2yONRQtaQcMV4V9Oy0rD0uemeP8XnOnmlKl5/dzLR7BQu35K20WcCDkF8I8m5AeU/P3yXlPWSpd1pxfTgE8NGvlFF8wfikcaVhjGBWfj4hACjkBm99gRK0qf8M2Xa7Ju/mJ1qYmT/8Vmnag/x0lN3DpOIDXGPYNtfOk6M8YL/pw0PVIA6IGWaTurDG6Bz/snyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WghqSEvo1Ix6qL8/daEl1QurIz3Znbo8nH/Brmyzfh0=;
 b=DVmD1tsn9a6MEUPQVf8Yz06e+y7I7thbx52Mc84siPRPLiEG930aZqEgCeTFsIlKWCrx63mztustiYjP+Bs+hys/cJhTMUqZ2t5szeS5Fr3shArN9K3964ApXQYIEMOTRbmLdGktfCpJ2zF6rKxToH/wHm+xIyA0Utk5i/pATFtkxRLDTklAd6tT0FLCMk7Yn64zS/B4qUXmV3+Wboh0QPhviqAvv0amZvQ8yqcnFjA1XihKuMw8TNOFHPlEAd/icyA+vAxAfLDHRUSWXIfeTyre0v91EiSwiSGg4eR7XbZok0fXLG15jZ0DnEyV8WlH63qtwmTlDndElv2pTYFBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WghqSEvo1Ix6qL8/daEl1QurIz3Znbo8nH/Brmyzfh0=;
 b=EQVEssM8mBLp/x1jwTGA4mpecCJu7VmzkxQDw1k8oBtjmMY1qw+XUH+MIRa4XXUvyTeB3VI6oeEb3A3iX3idzoPPrk298f/UikmFhMw8v+9FXp7UY60JIYtmTlYFeSTktuRf/bb2dyF7WldXp0h5u1beg9X8k5A6+8en8UPKNubvCaZbd/P7jeHEE2ek0aA+EjgGhyLCxRHdtgAQzmVOasyIGmsVImYhzonbJs8R1zuHDrW3YvqO4LYc/FVh+pc+oUPnjGO3C2XW260ZPdiEvRKmUvXEjAqfpO672JmW2Xke5nDSgcl0iPmLZW/OEEt0jSMayxn8fPu1TqdAnf1FXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 05:46:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 05:46:01 +0000
Message-ID: <0b90eeb8-aacf-4d1d-8523-4226a098d886@siemens.com>
Date: Wed, 15 Oct 2025 07:46:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-xenomai: Add arch specific debug kernel
 configuration snippets
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
 <20251009111228.3504354-2-tobias.schaffner@siemens.com>
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
In-Reply-To: <20251009111228.3504354-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: ea808dd0-6670-4abf-d05e-08de0bae1f46
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aktSMTBpYnd0QU95WjI2MXNVd0RYKzBxZ1U2aG0xVTdiOUEySUZ3THA4Q1NK?=
 =?utf-8?B?aEJ6YkhhRVBIRnlFZmNobDZML0JCc054YmxzV0xyRHZKS3dBT0J6WnErSGpt?=
 =?utf-8?B?clFwbHd2S3hDTVkyTW82MS9sQXFnMWp0b3VjMzVSOU11VU9CYm9zcUpJOXVj?=
 =?utf-8?B?STVPUjY0bkpLNFNmdmIydzFUWnhsUlJFQUZpaVFKcFl2TzFjZlVheHNrWC94?=
 =?utf-8?B?TCs2WndBWmJrd1JrOTEzTThvTWVqYjhwd1JsZnRTZDRnb2UrWUxFcURqZE1I?=
 =?utf-8?B?dFM3Ujg1U095Tm1CUGR5QzAwSndSVzA4QVBudG00Y3Z1eW1VVjk1L0pqcjFP?=
 =?utf-8?B?WnBENWZYRk4rRzU5dVZmU01MNE5oNnJoclpuQWpQVVZUZHFwV1hMMjBEb0pW?=
 =?utf-8?B?aU1VRXR1d2k0cXl3L3pYRDlTTzlnWVYvSzRqZFFNa1JSQnk1eVNZVWEzT0cw?=
 =?utf-8?B?Z0NiejdMdll1TWhmTjhKWW1OQnB2WVYwN29PTEp6SFF5VS94MVJUM3lEOWkr?=
 =?utf-8?B?RnFFQUtIN2xwblN1T3RsOGhwWHliaUhzVkczZmFqWmxSU2luYUhFNjgyM0Nl?=
 =?utf-8?B?d3lyc0tJUW5vdXdoZkR2VlYvNitvY1FKelVwZTh6TDVuYUltZGZsU2FjZnZM?=
 =?utf-8?B?OW80M2s4N0wyZWZjN2VCeVVYMHNqUTYxYTlaMlYwb2N2S1JBdkJrWXR3WkdQ?=
 =?utf-8?B?YXdZdjFTY0xqS0R1UCtGbnhaNW5id09zWWI0eldxN0gybUJBUjhDNXdCMEZz?=
 =?utf-8?B?eXBEblFKK2pySTlTOVEyRkR6cVg3VlU1d3RObmdlRVVCYXR4MldHb0JXbHhm?=
 =?utf-8?B?eFFkYUc1VUJ6VXRneWFrZTcwRkxXbEtLNDZlQ2NLSE1KZGdZU1hRYWUzbEZV?=
 =?utf-8?B?UzZKMVdlclhGWWhVTThZUy9YVXBpK1g3NUs2ZndURW52YmVqcGlJOEJ1VS9O?=
 =?utf-8?B?VDJqNmdvd1lBNUVoR0xwLzdJYlkzUEpYTWQrUTl2VHphS0JHR0hkWDRhTS9G?=
 =?utf-8?B?WDJOYktEdFlXS3FUdGQ1OVdLdkN6ajZGNFJqUjhrUzdXTGg0T1ZtOEVxSTNV?=
 =?utf-8?B?dVZBNkZOUzlSWUhoV2tWcHhaQWMyeXFCa3lCV1JlMmswL2Z2UlBwT1lVbHI0?=
 =?utf-8?B?K2pHbkpMS1B6QkxjZ3J6eDRlVk5JUTluekpxUTlnQUhFZVlhTm43ak1hRy9h?=
 =?utf-8?B?bERYWk5RcHkvWklHeEJvV0paR3M4RmN4ZEl2VUVreEVacS9vNkRGb1ZlZmg5?=
 =?utf-8?B?OWFmUlRIeGFRN3pNb0RhQ3hRMEZTL3B3RzlpR2JRSlNrK3ZHZ3UvRDdOeG1B?=
 =?utf-8?B?cE1RU29UYmwreGpjdHhyU29wd3dxN1JzYkpuKzVhR2kyMXZZS1htbFZQYXdp?=
 =?utf-8?B?TmltdE5HM1JjbnFrV2JUcjRHaGZ6NVNGelloWXFJTnRMRjlJSUV5ZWtpc0RY?=
 =?utf-8?B?NWRiUENUb0F5SVJPa2E4d0kvR0Y2Z3hIOUcwOEhId1AzS3lFdUg4N1NSQ3Nz?=
 =?utf-8?B?eCtUWnAxa0hSNlpJVGNuUWVlREh0alk5akhVbDZZM0VtTGNCZCtoQUdtWmN2?=
 =?utf-8?B?U3VmOG8rT28za1BxaDk5RXVCK1QrdVZxL2hsajVqYlBESmYyVDZHZVpIQTVT?=
 =?utf-8?B?WVVuc3ZNQ0NLbXN6TEREcnF2R1J1MHhjcTE3andGRHZIL0ZaQkxMQWg5NzdT?=
 =?utf-8?B?MjNPcEZoSXlyV1pldE1DbzMrVGFrbnNUSzBmK0pjKzBJOWRHK1FRQzV1UGRV?=
 =?utf-8?B?QjkvRFM2dCtIdTZjaFBwZlZRWElpSWplSCtrdFRVOEZmVjM2VHBINm50WGdr?=
 =?utf-8?B?WVRyRmlSaCs0a090Vk16Z0Y1Qkdnb2xtLzVBTEtmNGJkTFhkcnkyZFJRRlh1?=
 =?utf-8?B?aU9iREhnY1dTOGVQZVZ0dXRKZkJwTU9Ma3lGWTdjTkhzZFFuMy9USlYxNlB4?=
 =?utf-8?Q?2vaqm5m9dpGfvenHwqT+pVeyrIxZVaxb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmZrbFhCekk1Q2I0K0JCTGtaK2pPMVhSc0RjTTlXdHBxa1d3QWRzSlBoRU85?=
 =?utf-8?B?V1JER0VXRlQzZUVna1VpUXE3Ry9oMlhiVzNPZDJnT25oekJjeE9CbU9VMG9O?=
 =?utf-8?B?T1pCaUJETXIvTU4wTisxZjgzVXVhSGVOVjhrOGgxYTI2MEUzZ3F5WFFhcnJZ?=
 =?utf-8?B?d3lzdlp2Snczb1J2L3Fwc1VwelR2R09yS0JCSFdtR0lBYmN2Nm92K0xDREFN?=
 =?utf-8?B?VUJBV2JwQXZCdUFnbDZNVXFIZ0hqQVdWcEROTDR0RUJ1Z21MUUdGZmRweG1M?=
 =?utf-8?B?SjFvdWVKYis2MS96QjRXeUpmTE0xbmdkYWNGYWNRaSt3K1owTnJ2SzNWRGpR?=
 =?utf-8?B?OElhVklxa293c08xODMzVlJGblZsWm1qOTk5UHZETTZtcWJlTGc3b3NjaVVU?=
 =?utf-8?B?NnFCVGxVZ1pQU2k0bDV2bTBJeFR3MHNsdEpuaS9nRWJKNFRscHRZTitibDNp?=
 =?utf-8?B?OHVSSmF0ZUtyQm1LR2ZvQXJnUGlBMC9oNjR2RHJCWVF5T2U0WlcyN3ZjbTQ4?=
 =?utf-8?B?bE9BWWVVdkN3TE9WaldtSHBSbkRyNjhDT1l4Snp4eGJmRlhwZnhhY3FLQ3NT?=
 =?utf-8?B?cTF0Z28xNVl1QUNJQXV2UW1USXQyc3lsbyttK1dGVDlQMGVoK1lUNlNtb2Yv?=
 =?utf-8?B?MnYxLzIrOWJjYkhmVTFKOFRkOW9BTGZJcjZkNTlJT3QxWStLR0VtTEpscXJh?=
 =?utf-8?B?QzVFaEFSOGphenUrSEFra1E5aUw1SldXZzlqZHI2THhBM0QvVkkyVHR5TFY1?=
 =?utf-8?B?MElmb2FMSE9ZdVpIS2czdHhya1pRZWVORk1OWnZDZDhVeWtlckZpdnRaakwz?=
 =?utf-8?B?OUEycnhTQVZQQUw3Rk9jc1A0citDcmpWLzFHMDJmbFB4S2hEcGVjOWV5ZmRx?=
 =?utf-8?B?aHMyaE8yS3NRVE4wMG45WjhEUUpQalpQRURuU2NSN0gwTHpIZEpBaysxc2Fk?=
 =?utf-8?B?YVI1Y0F3a1k2MGk4QVVOQ2dUWGw5NEYvVFNUOXlkMzZZTDJwSUVzdW9SLzJW?=
 =?utf-8?B?Q1VQcmJuajlROVhZeERGSmdOUnNYNjRnWVpySGJpMW1qRUNjZk9kaytCRmha?=
 =?utf-8?B?Z1JZdWw3aGtac2hXdW0vUjUwTkpCakFGanoxY2tsZWswSW9hR2MreGd4eXNz?=
 =?utf-8?B?V2VYNW9LaVN0KzRxWlNBQ0NoMGhJejhKWVRCYkdVRFRnalpsQ3ZWQmkxWWJK?=
 =?utf-8?B?S2dJSnE3OWhocFBZbEdYWC9HNzh5dWR5dUZnSVhET3JjMU16SVJhOFZYYlhM?=
 =?utf-8?B?UnVjelR2SVFjTmZNckZMQmtCSElVY0ZpMFZaa1FhSWFXUlhaMmlsOUFkdkxD?=
 =?utf-8?B?WVJSd1EwNHNtTTE4V1puUXYycVFLN0VpcUJPMTZJZHBBK25ka3pWN1lnVGYz?=
 =?utf-8?B?WUNjQWhyUUtZeFZrUjNQTHpVaS96VDczMjZZM3FZZUJOQ0ZLblBnZ051cVgz?=
 =?utf-8?B?am03eDdoRkRyYWg0ZDhPeWFFL0I4WXNhbUtzeEkrSnBmU3NMb1pEWnRtOGxi?=
 =?utf-8?B?RUtvbUo0S2k2N3BVQjFpM1hlc3ZkVnkrVzhMQWdhbVRKTFIxVWZmZGlyZXVC?=
 =?utf-8?B?eFc2bDlIY3BseGtMU2kzNjEvUkhzbWE0UFdNbUJORS8vQkRxUUJwWGJjc3Uy?=
 =?utf-8?B?ZmFiM1QxYlY3eFk1a2ZYaURESTVRbnRONEh0U21KbWdtcVpvRVg5ZFVwckMx?=
 =?utf-8?B?KzlwK1d3MWFtcFMxWEVad29oY2VabkdwQ0U0UlFlcnhtVGo0VFFCOHRyb2R0?=
 =?utf-8?B?UW5YcVJXV1JqNXFXdWhxTjJhYXhDMjlrckJRZ05kUHBLQ1o0ZUJxUnFqbFUx?=
 =?utf-8?B?Q0hZTnZBTnBtaGZERWdoYWVoc0p6MzBMT0dCTjZMWVFLYjZzeS9RTkVoVCtk?=
 =?utf-8?B?WUovR2puN0Fwa0ZNS29pOVI3ZTIyeThaRXlkMjBodnNDOTRVZytRTCtpNmZ6?=
 =?utf-8?B?KysxMzZxdzloQkgzZ1RTYkttdlhqMlNpSXpDcmltd2g0ajhCa1hYU3c0UjBN?=
 =?utf-8?B?YWx0WEpBQjFWSVFOVUdGL3ppN0hhaUtEQW1haWtTdjZwQTR6ajNaSm9ialRZ?=
 =?utf-8?B?QTQ3a05wQmdOZXB3OWtoUkdmM3U5ODZjell2Z1EwZlpIcytobnNNOGpIQ2pL?=
 =?utf-8?Q?8E8EOy9SbEpuYIS26OlBaQn80?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea808dd0-6670-4abf-d05e-08de0bae1f46
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 05:46:01.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFXCRJcKlGrR0ttwf5e0OI+ybQj4KzszYkjaUmm1JjCSmmnqqXRFtbTH4W/1o9Y3JdO8BdlxQrOagDvKiOVIYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9403

On 09.10.25 13:12, Tobias Schaffner wrote:
> Add dedicated debug configuration snippets for each architecture to
> consolidate common kernel debugging features. This replaces the
> previous approach of using an inverted no-debug configuration to
> disable debugging options.
> 
> Separating debug and no-debug configurations improves maintainability
> and simplifies future consolidation of debug settings across
> architectures.
> 
> The change has been verified using the kconfig library. Applying the
> new debug configuration to the updated defconfig and running
> ‘make oldconfig’ produces an identical resulting configuration to the
> previous defconfig for all supported architectures and kernel
> versions.
> 
> Several debug switches that were previously left enabled in the
> no-debug configuration have been moved to the new debug snippet.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-kernel/linux/files/amd64_debugconfig | 436 ++++++++++++++++++
>  recipes-kernel/linux/files/amd64_defconfig   | 313 ++++++-------
>  recipes-kernel/linux/files/arm64_debugconfig | 404 +++++++++++++++++
>  recipes-kernel/linux/files/arm64_defconfig   | 149 +++----
>  recipes-kernel/linux/files/armhf_debugconfig | 438 +++++++++++++++++++
>  recipes-kernel/linux/files/armhf_defconfig   | 164 +++----
>  recipes-kernel/linux/files/common_nodbg.cfg  |   9 -
>  recipes-kernel/linux/linux-xenomai.inc       |   3 +-
>  8 files changed, 1594 insertions(+), 322 deletions(-)
>  create mode 100644 recipes-kernel/linux/files/amd64_debugconfig
>  create mode 100644 recipes-kernel/linux/files/arm64_debugconfig
>  create mode 100644 recipes-kernel/linux/files/armhf_debugconfig
>  delete mode 100644 recipes-kernel/linux/files/common_nodbg.cfg
> 
> diff --git a/recipes-kernel/linux/files/amd64_debugconfig b/recipes-kernel/linux/files/amd64_debugconfig
> new file mode 100644
> index 0000000..a07ec9d
> --- /dev/null
> +++ b/recipes-kernel/linux/files/amd64_debugconfig
> @@ -0,0 +1,436 @@
> +#
> +# Debug Kernel Configuration
> +#
> +CONFIG_LOCKDEP_SUPPORT=y
> +CONFIG_STACKTRACE_SUPPORT=y
> +CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> +CONFIG_ARCH_SUPPORTS_UPROBES=y
> +
> +#
> +# IRQ subsystem
> +#
> +CONFIG_GENERIC_IRQ_PROBE=y
> +# CONFIG_IRQ_DOMAIN_DEBUG is not set
> +# CONFIG_GENERIC_IRQ_DEBUGFS is not set
> +
> +#
> +# RCU Subsystem
> +#
> +# CONFIG_CGROUP_PERF is not set
> +# CONFIG_CGROUP_DEBUG is not set
> +CONFIG_SYSCTL_EXCEPTION_TRACE=y
> +CONFIG_KALLSYMS=y
> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> +CONFIG_KALLSYMS_BASE_RELATIVE=y
> +CONFIG_HAVE_PERF_EVENTS=y
> +
> +#
> +# Kernel Performance Events And Counters
> +#
> +CONFIG_PERF_EVENTS=y
> +# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> +CONFIG_SLUB_DEBUG=y
> +CONFIG_TRACEPOINTS=y
> +CONFIG_KPROBES=y
> +CONFIG_OPTPROBES=y
> +CONFIG_UPROBES=y
> +CONFIG_KRETPROBES=y
> +CONFIG_HAVE_KPROBES=y
> +CONFIG_HAVE_KRETPROBES=y
> +CONFIG_HAVE_OPTPROBES=y
> +CONFIG_HAVE_KPROBES_ON_FTRACE=y
> +CONFIG_HAVE_ARCH_TRACEHOOK=y
> +CONFIG_HAVE_DMA_API_DEBUG=y
> +CONFIG_HAVE_PERF_EVENTS_NMI=y
> +CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> +CONFIG_HAVE_PERF_REGS=y
> +CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> +
> +#
> +# GCOV-based kernel profiling
> +#
> +CONFIG_BLK_DEBUG_FS=y
> +
> +#
> +# Partition Types
> +#
> +# CONFIG_LDM_DEBUG is not set
> +
> +#
> +# Sizes and static limits
> +#
> +CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> +
> +#
> +# Latency settings
> +#
> +CONFIG_XENO_OPT_DEBUG=y
> +CONFIG_XENO_OPT_DEBUG_COBALT=y
> +# CONFIG_XENO_OPT_DEBUG_MEMORY is not set
> +CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> +CONFIG_XENO_OPT_DEBUG_LOCKING=y
> +CONFIG_XENO_OPT_DEBUG_USER=y
> +CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> +CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> +CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO=y
> +CONFIG_XENO_OPT_DEBUG_LEGACY=y
> +CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> +
> +#
> +# Testing drivers
> +#
> +CONFIG_XENO_DRIVERS_HEAPCHECK=y
> +
> +#
> +# CAN drivers
> +#
> +CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> +
> +#
> +# Protocols
> +#
> +CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
> +CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
> +
> +#
> +# ANALOGY drivers
> +#
> +CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
> +# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE is not set
> +CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=0
> +CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=0
> +
> +#
> +# Real-time GPIO drivers
> +#
> +CONFIG_XENO_DRIVERS_GPIO_DEBUG=y
> +
> +#
> +# Processor type and features
> +#
> +CONFIG_SCHED_OMIT_FRAME_POINTER=y
> +CONFIG_X86_DEBUGCTLMSR=y
> +
> +#
> +# Performance monitoring
> +#
> +CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> +CONFIG_PERF_EVENTS_INTEL_RAPL=y
> +CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> +# CONFIG_PERF_EVENTS_AMD_POWER is not set
> +CONFIG_ARCH_MEMORY_PROBE=y
> +CONFIG_MTRR_SANITIZER=y
> +CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> +CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> +# CONFIG_RANDOMIZE_BASE is not set
> +# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> +
> +#
> +# Power management and ACPI options
> +#
> +CONFIG_PM_DEBUG=y
> +# CONFIG_PM_ADVANCED_DEBUG is not set
> +CONFIG_PM_TEST_SUSPEND=y
> +CONFIG_PM_SLEEP_DEBUG=y
> +CONFIG_PM_TRACE=y
> +CONFIG_PM_TRACE_RTC=y
> +# CONFIG_ACPI_DEBUGGER is not set
> +# CONFIG_ACPI_EC_DEBUGFS is not set
> +# CONFIG_ACPI_DEBUG is not set
> +# CONFIG_ACPI_APEI_ERST_DEBUG is not set
> +
> +#
> +# Bus options (PCI etc.)
> +#
> +# CONFIG_PCIEASPM_DEBUG is not set
> +# CONFIG_PCI_DEBUG is not set
> +
> +#
> +# Xtables targets
> +#
> +# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
> +
> +#
> +# Network testing
> +#
> +# CONFIG_NET_TCPPROBE is not set
> +
> +#
> +# CFG80211 needs to be enabled for MAC80211
> +#
> +# CONFIG_NET_9P_DEBUG is not set
> +
> +#
> +# Generic Driver Options
> +#
> +# CONFIG_DEBUG_DRIVER is not set
> +# CONFIG_DEBUG_DEVRES is not set
> +# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> +# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> +CONFIG_GENERIC_CPU_AUTOPROBE=y
> +
> +#
> +# Bus devices
> +#
> +CONFIG_PNP_DEBUG_MESSAGES=y
> +
> +#
> +# Generic fallback / legacy drivers
> +#
> +# CONFIG_DM_DEBUG is not set
> +# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> +
> +#
> +# Character devices
> +#
> +# CONFIG_TRACE_SINK is not set
> +
> +#
> +# Non-8250 serial port support
> +#
> +# CONFIG_SERIAL_KGDB_NMI is not set
> +
> +#
> +# Other I2C/SMBus bus drivers
> +#
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_PPS_DEBUG is not set
> +
> +#
> +# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> +#
> +# CONFIG_DEBUG_GPIO is not set
> +
> +#
> +# USB GPIO expanders
> +#
> +# CONFIG_POWER_SUPPLY_DEBUG is not set
> +# CONFIG_HWMON_DEBUG_CHIP is not set
> +
> +#
> +# Multifunction device drivers
> +#
> +# CONFIG_REGULATOR_DEBUG is not set
> +
> +#
> +# iptables trigger is under Netfilter config (LED target)
> +#
> +# CONFIG_EDAC_DEBUG is not set
> +# CONFIG_RTC_DEBUG is not set
> +
> +#
> +# HID Sensor RTC drivers
> +#
> +CONFIG_DMADEVICES_DEBUG=y
> +# CONFIG_DMADEVICES_VDEBUG is not set
> +
> +#
> +# File systems
> +#
> +# CONFIG_EXT4_DEBUG is not set
> +# CONFIG_JBD2_DEBUG is not set
> +# CONFIG_QUOTA_DEBUG is not set
> +
> +#
> +# Caches
> +#
> +# CONFIG_FSCACHE_DEBUG is not set
> +
> +#
> +# Pseudo filesystems
> +#
> +# CONFIG_PSTORE_FTRACE is not set
> +
> +#
> +# Kernel hacking
> +#
> +CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +
> +#
> +# printk and dmesg options
> +#
> +# CONFIG_DYNAMIC_DEBUG is not set
> +
> +#
> +# Compile-time checks and compiler options
> +#
> +CONFIG_DEBUG_INFO=y
> +# CONFIG_DEBUG_INFO_REDUCED is not set
> +# CONFIG_DEBUG_INFO_SPLIT is not set
> +# CONFIG_DEBUG_INFO_DWARF4 is not set
> +CONFIG_GDB_SCRIPTS=y
> +CONFIG_DEBUG_FS=y
> +CONFIG_DEBUG_SECTION_MISMATCH=y
> +# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> +CONFIG_MAGIC_SYSRQ_SERIAL=y
> +CONFIG_IPIPE_DEBUG=y
> +CONFIG_IPIPE_DEBUG_CONTEXT=y
> +CONFIG_IPIPE_DEBUG_INTERNAL=y
> +CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> +CONFIG_IPIPE_TRACE=y
> +# CONFIG_IPIPE_TRACE_ENABLE is not set
> +CONFIG_IPIPE_TRACE_MCOUNT=y
> +CONFIG_IPIPE_TRACE_IRQSOFF=y
> +CONFIG_IPIPE_TRACE_SHIFT=14
> +# CONFIG_IPIPE_TRACE_VMALLOC is not set
> +CONFIG_IPIPE_TRACE_PANIC=y
> +CONFIG_DEBUG_KERNEL=y
> +
> +#
> +# Memory Debugging
> +#
> +CONFIG_PAGE_EXTENSION=y
> +CONFIG_DEBUG_PAGEALLOC=y
> +# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
> +# CONFIG_DEBUG_PAGE_REF is not set
> +CONFIG_DEBUG_RODATA_TEST=y
> +# CONFIG_DEBUG_OBJECTS is not set
> +CONFIG_SLUB_DEBUG_ON=y
> +CONFIG_HAVE_DEBUG_KMEMLEAK=y
> +# CONFIG_DEBUG_KMEMLEAK is not set
> +# CONFIG_DEBUG_STACK_USAGE is not set
> +CONFIG_DEBUG_VM=y
> +# CONFIG_DEBUG_VM_VMACACHE is not set
> +# CONFIG_DEBUG_VM_RB is not set
> +# CONFIG_DEBUG_VM_PGFLAGS is not set
> +CONFIG_DEBUG_VM_PGTABLE=y
> +CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> +CONFIG_DEBUG_VIRTUAL=y
> +CONFIG_DEBUG_MEMORY_INIT=y
> +# CONFIG_DEBUG_PER_CPU_MAPS is not set
> +CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> +# CONFIG_DEBUG_STACKOVERFLOW is not set
> +CONFIG_HAVE_ARCH_KASAN=y
> +# CONFIG_KASAN is not set
> +CONFIG_ARCH_HAS_KCOV=y
> +# CONFIG_KCOV is not set
> +CONFIG_DEBUG_SHIRQ=y
> +
> +#
> +# Debug Lockups and Hangs
> +#
> +CONFIG_SCHED_DEBUG=y
> +CONFIG_SCHED_INFO=y
> +# CONFIG_DEBUG_TIMEKEEPING is not set
> +CONFIG_DEBUG_PREEMPT=y
> +
> +#
> +# Lock Debugging (spinlocks, mutexes, etc...)
> +#
> +CONFIG_DEBUG_RT_MUTEXES=y
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_MUTEXES=y
> +# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> +CONFIG_DEBUG_LOCK_ALLOC=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_LOCKDEP=y
> +# CONFIG_DEBUG_LOCKDEP is not set
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> +CONFIG_TRACE_IRQFLAGS=y
> +CONFIG_STACKTRACE=y
> +# CONFIG_DEBUG_KOBJECT is not set
> +CONFIG_DEBUG_BUGVERBOSE=y
> +CONFIG_DEBUG_LIST=y
> +CONFIG_DEBUG_PI_LIST=y
> +# CONFIG_DEBUG_SG is not set
> +# CONFIG_DEBUG_NOTIFIERS is not set
> +# CONFIG_DEBUG_CREDENTIALS is not set
> +
> +#
> +# RCU Debugging
> +#
> +# CONFIG_PROVE_RCU is not set
> +# CONFIG_RCU_PERF_TEST is not set
> +# CONFIG_RCU_TRACE is not set
> +# CONFIG_RCU_EQS_DEBUG is not set
> +# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> +# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> +CONFIG_USER_STACKTRACE_SUPPORT=y
> +CONFIG_NOP_TRACER=y
> +CONFIG_HAVE_FUNCTION_TRACER=y
> +CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> +CONFIG_HAVE_DYNAMIC_FTRACE=y
> +CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> +CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> +CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> +CONFIG_TRACER_MAX_TRACE=y
> +CONFIG_TRACE_CLOCK=y
> +CONFIG_RING_BUFFER=y
> +CONFIG_EVENT_TRACING=y
> +CONFIG_CONTEXT_SWITCH_TRACER=y
> +CONFIG_RING_BUFFER_ALLOW_SWAP=y
> +CONFIG_TRACING=y
> +CONFIG_GENERIC_TRACER=y
> +CONFIG_TRACING_SUPPORT=y
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_FUNCTION_GRAPH_TRACER=y
> +CONFIG_IRQSOFF_TRACER=y
> +# CONFIG_PREEMPT_TRACER is not set
> +CONFIG_SCHED_TRACER=y
> +# CONFIG_HWLAT_TRACER is not set
> +CONFIG_FTRACE_SYSCALLS=y
> +CONFIG_TRACER_SNAPSHOT=y
> +CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> +CONFIG_BRANCH_PROFILE_NONE=y
> +# CONFIG_STACK_TRACER is not set
> +# CONFIG_BLK_DEV_IO_TRACE is not set
> +CONFIG_KPROBE_EVENTS=y
> +CONFIG_UPROBE_EVENTS=y
> +CONFIG_PROBE_EVENTS=y
> +# CONFIG_FTRACE_STARTUP_TEST is not set
> +# CONFIG_MMIOTRACE is not set
> +# CONFIG_TRACEPOINT_BENCHMARK is not set
> +# CONFIG_RING_BUFFER_BENCHMARK is not set
> +# CONFIG_RING_BUFFER_STARTUP_TEST is not set
> +# CONFIG_TRACE_EVAL_MAP_FILE is not set
> +CONFIG_TRACING_EVENTS_GPIO=y
> +# CONFIG_DMA_API_DEBUG is not set
> +
> +#
> +# Runtime Testing
> +#
> +# CONFIG_KPROBES_SANITY_TEST is not set
> +# CONFIG_BACKTRACE_SELF_TEST is not set
> +# CONFIG_TEST_DEBUG_VIRTUAL is not set
> +CONFIG_HAVE_ARCH_KGDB=y
> +CONFIG_KGDB=y
> +CONFIG_KGDB_SERIAL_CONSOLE=y
> +CONFIG_KGDB_TESTS=y
> +# CONFIG_KGDB_TESTS_ON_BOOT is not set
> +# CONFIG_KGDB_LOW_LEVEL_TRAP is not set
> +# CONFIG_KGDB_KDB is not set
> +CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> +# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> +# CONFIG_UBSAN is not set
> +# CONFIG_DEBUG_WX is not set
> +# CONFIG_DEBUG_TLBFLUSH is not set
> +# CONFIG_IOMMU_DEBUG is not set
> +CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> +CONFIG_IO_DELAY_TYPE_0X80=0
> +CONFIG_IO_DELAY_TYPE_0XED=1
> +CONFIG_IO_DELAY_TYPE_UDELAY=2
> +CONFIG_IO_DELAY_TYPE_NONE=3
> +CONFIG_IO_DELAY_0X80=y
> +# CONFIG_IO_DELAY_0XED is not set
> +# CONFIG_IO_DELAY_UDELAY is not set
> +# CONFIG_IO_DELAY_NONE is not set
> +CONFIG_DEFAULT_IO_DELAY_TYPE=0
> +# CONFIG_DEBUG_BOOT_PARAMS is not set
> +# CONFIG_CPA_DEBUG is not set
> +# CONFIG_DEBUG_ENTRY is not set
> +# CONFIG_DEBUG_NMI_SELFTEST is not set
> +CONFIG_X86_DEBUG_FPU=y
> +# CONFIG_PUNIT_ATOM_DEBUG is not set
> +CONFIG_UNWINDER_ORC=y
> +# CONFIG_UNWINDER_FRAME_POINTER is not set
> +
> +#
> +# Library routines
> +#
> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
> index a0a516f..d0c449f 100644
> --- a/recipes-kernel/linux/files/amd64_defconfig
> +++ b/recipes-kernel/linux/files/amd64_defconfig
> @@ -8,8 +8,8 @@ CONFIG_X86=y
>  CONFIG_INSTRUCTION_DECODER=y
>  CONFIG_OUTPUT_FORMAT="elf64-x86-64"
>  CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> -CONFIG_LOCKDEP_SUPPORT=y
> -CONFIG_STACKTRACE_SUPPORT=y
> +# CONFIG_LOCKDEP_SUPPORT is not set
> +# CONFIG_STACKTRACE_SUPPORT is not set
>  CONFIG_MMU=y
>  CONFIG_ARCH_MMAP_RND_BITS_MIN=28
>  CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> @@ -36,9 +36,9 @@ CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>  CONFIG_ZONE_DMA32=y
>  CONFIG_AUDIT_ARCH=y
>  CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> -CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> +# CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC is not set
>  CONFIG_X86_64_SMP=y
> -CONFIG_ARCH_SUPPORTS_UPROBES=y
> +# CONFIG_ARCH_SUPPORTS_UPROBES is not set
>  CONFIG_FIX_EARLYCON_MEM=y
>  CONFIG_PGTABLE_LEVELS=4
>  CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> @@ -84,7 +84,7 @@ CONFIG_AUDIT_TREE=y
>  #
>  # IRQ subsystem
>  #
> -CONFIG_GENERIC_IRQ_PROBE=y
> +# CONFIG_GENERIC_IRQ_PROBE is not set
>  CONFIG_GENERIC_IRQ_SHOW=y
>  CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
>  CONFIG_GENERIC_PENDING_IRQ=y
> @@ -189,7 +189,7 @@ CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
>  CONFIG_SYSCTL=y
>  CONFIG_ANON_INODES=y
>  CONFIG_HAVE_UID16=y
> -CONFIG_SYSCTL_EXCEPTION_TRACE=y
> +# CONFIG_SYSCTL_EXCEPTION_TRACE is not set
>  CONFIG_HAVE_PCSPKR_PLATFORM=y
>  CONFIG_BPF=y
>  # CONFIG_EXPERT is not set
> @@ -199,10 +199,10 @@ CONFIG_SGETMASK_SYSCALL=y
>  CONFIG_SYSFS_SYSCALL=y
>  # CONFIG_SYSCTL_SYSCALL is not set
>  CONFIG_POSIX_TIMERS=y
> -CONFIG_KALLSYMS=y
> -CONFIG_KALLSYMS_ALL=y
> -CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> -CONFIG_KALLSYMS_BASE_RELATIVE=y
> +# CONFIG_KALLSYMS is not set
> +# CONFIG_KALLSYMS_ALL is not set
> +# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> +# CONFIG_KALLSYMS_BASE_RELATIVE is not set
>  CONFIG_PRINTK=y
>  CONFIG_PRINTK_NMI=y
>  CONFIG_RAW_PRINTK=y
> @@ -224,16 +224,16 @@ CONFIG_ADVISE_SYSCALLS=y
>  CONFIG_PCI_QUIRKS=y
>  CONFIG_MEMBARRIER=y
>  # CONFIG_EMBEDDED is not set
> -CONFIG_HAVE_PERF_EVENTS=y
> +# CONFIG_HAVE_PERF_EVENTS is not set
>  # CONFIG_PC104 is not set
>  
>  #
>  # Kernel Performance Events And Counters
>  #
> -CONFIG_PERF_EVENTS=y
> +# CONFIG_PERF_EVENTS is not set
>  # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>  CONFIG_VM_EVENT_COUNTERS=y
> -CONFIG_SLUB_DEBUG=y
> +# CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
>  # CONFIG_SLAB is not set
>  CONFIG_SLUB=y
> @@ -243,29 +243,29 @@ CONFIG_SLAB_MERGE_DEFAULT=y
>  CONFIG_SLUB_CPU_PARTIAL=y
>  # CONFIG_SYSTEM_DATA_VERIFICATION is not set
>  CONFIG_PROFILING=y
> -CONFIG_TRACEPOINTS=y
> +# CONFIG_TRACEPOINTS is not set
>  CONFIG_CRASH_CORE=y
>  CONFIG_KEXEC_CORE=y
>  CONFIG_HOTPLUG_SMT=y
>  # CONFIG_OPROFILE is not set
>  CONFIG_HAVE_OPROFILE=y
>  CONFIG_OPROFILE_NMI_TIMER=y
> -CONFIG_KPROBES=y
> +# CONFIG_KPROBES is not set
>  # CONFIG_JUMP_LABEL is not set
> -CONFIG_OPTPROBES=y
> -CONFIG_UPROBES=y
> +# CONFIG_OPTPROBES is not set
> +# CONFIG_UPROBES is not set
>  # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
>  CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>  CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> -CONFIG_KRETPROBES=y
> +# CONFIG_KRETPROBES is not set
>  CONFIG_USER_RETURN_NOTIFIER=y
>  CONFIG_HAVE_IOREMAP_PROT=y
> -CONFIG_HAVE_KPROBES=y
> -CONFIG_HAVE_KRETPROBES=y
> -CONFIG_HAVE_OPTPROBES=y
> -CONFIG_HAVE_KPROBES_ON_FTRACE=y
> +# CONFIG_HAVE_KPROBES is not set
> +# CONFIG_HAVE_KRETPROBES is not set
> +# CONFIG_HAVE_OPTPROBES is not set
> +# CONFIG_HAVE_KPROBES_ON_FTRACE is not set
>  CONFIG_HAVE_NMI=y
> -CONFIG_HAVE_ARCH_TRACEHOOK=y
> +# CONFIG_HAVE_ARCH_TRACEHOOK is not set
>  CONFIG_HAVE_DMA_CONTIGUOUS=y
>  CONFIG_GENERIC_SMP_IDLE_THREAD=y
>  CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> @@ -273,14 +273,14 @@ CONFIG_ARCH_HAS_SET_MEMORY=y
>  CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>  CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>  CONFIG_HAVE_CLK=y
> -CONFIG_HAVE_DMA_API_DEBUG=y
> +# CONFIG_HAVE_DMA_API_DEBUG is not set
>  CONFIG_HAVE_HW_BREAKPOINT=y
>  CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
>  CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> -CONFIG_HAVE_PERF_EVENTS_NMI=y
> -CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> -CONFIG_HAVE_PERF_REGS=y
> -CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> +# CONFIG_HAVE_PERF_EVENTS_NMI is not set
> +# CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF is not set
> +# CONFIG_HAVE_PERF_REGS is not set
> +# CONFIG_HAVE_PERF_USER_STACK_DUMP is not set
>  CONFIG_HAVE_ARCH_JUMP_LABEL=y
>  CONFIG_HAVE_RCU_TABLE_FREE=y
>  CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
> @@ -361,7 +361,7 @@ CONFIG_BLK_DEV_INTEGRITY=y
>  # CONFIG_BLK_DEV_ZONED is not set
>  # CONFIG_BLK_CMDLINE_PARSER is not set
>  # CONFIG_BLK_WBT is not set
> -CONFIG_BLK_DEBUG_FS=y
> +# CONFIG_BLK_DEBUG_FS is not set
>  # CONFIG_BLK_SED_OPAL is not set
>  
>  #
> @@ -457,7 +457,7 @@ CONFIG_XENO_OPT_SYS_HEAPSZ=1024
>  CONFIG_XENO_OPT_PRIVATE_HEAPSZ=32
>  CONFIG_XENO_OPT_SHARED_HEAPSZ=32
>  CONFIG_XENO_OPT_NRTIMERS=128
> -CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> +# CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ is not set
>  
>  #
>  # Latency settings
> @@ -465,17 +465,17 @@ CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
>  CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
>  CONFIG_XENO_OPT_TIMING_KSCHEDLAT=0
>  CONFIG_XENO_OPT_TIMING_IRQLAT=0
> -CONFIG_XENO_OPT_DEBUG=y
> -CONFIG_XENO_OPT_DEBUG_COBALT=y
> +# CONFIG_XENO_OPT_DEBUG is not set
> +# CONFIG_XENO_OPT_DEBUG_COBALT is not set
>  # CONFIG_XENO_OPT_DEBUG_MEMORY is not set
> -CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> -CONFIG_XENO_OPT_DEBUG_LOCKING=y
> -CONFIG_XENO_OPT_DEBUG_USER=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> -CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO=y
> -CONFIG_XENO_OPT_DEBUG_LEGACY=y
> -CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> +# CONFIG_XENO_OPT_DEBUG_CONTEXT is not set
> +# CONFIG_XENO_OPT_DEBUG_LOCKING is not set
> +# CONFIG_XENO_OPT_DEBUG_USER is not set
> +# CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED is not set
> +# CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP is not set
> +# CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO is not set
> +# CONFIG_XENO_OPT_DEBUG_LEGACY is not set
> +# CONFIG_XENO_OPT_DEBUG_TRACE_RELAX is not set
>  CONFIG_XENO_OPT_WATCHDOG=y
>  CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
>  
> @@ -500,14 +500,14 @@ CONFIG_XENO_DRIVERS_16550A_PCI_MOXA=y
>  #
>  CONFIG_XENO_DRIVERS_TIMERBENCH=y
>  CONFIG_XENO_DRIVERS_SWITCHTEST=y
> -CONFIG_XENO_DRIVERS_HEAPCHECK=y
> +# CONFIG_XENO_DRIVERS_HEAPCHECK is not set
>  CONFIG_XENO_DRIVERS_RTDMTEST=m
>  
>  #
>  # CAN drivers
>  #
>  CONFIG_XENO_DRIVERS_CAN=m
> -CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> +# CONFIG_XENO_DRIVERS_CAN_DEBUG is not set
>  CONFIG_XENO_DRIVERS_CAN_LOOPBACK=y
>  CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=1024
>  CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=4
> @@ -552,7 +552,7 @@ CONFIG_XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES=32
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_NETROUTING=y
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_NET_ROUTES=16
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_ROUTER=y
> -CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
> +# CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG is not set
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP=m
>  CONFIG_XENO_DRIVERS_NET_RTPACKET=m
>  CONFIG_XENO_DRIVERS_NET_RTMAC=m
> @@ -560,7 +560,7 @@ CONFIG_XENO_DRIVERS_NET_TDMA=m
>  CONFIG_XENO_DRIVERS_NET_TDMA_MASTER=y
>  CONFIG_XENO_DRIVERS_NET_NOMAC=m
>  CONFIG_XENO_DRIVERS_NET_RTCFG=m
> -CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
> +# CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG is not set
>  
>  #
>  # Drivers
> @@ -600,10 +600,10 @@ CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP=y
>  # ANALOGY drivers
>  #
>  CONFIG_XENO_DRIVERS_ANALOGY=m
> -CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
> +# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is not set
>  # CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE is not set
> -CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=0
> -CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=0
> +# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL is not set
> +# CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL is not set
>  CONFIG_XENO_DRIVERS_ANALOGY_FAKE=m
>  CONFIG_XENO_DRIVERS_ANALOGY_8255=m
>  CONFIG_XENO_DRIVERS_ANALOGY_PARPORT=m
> @@ -632,7 +632,7 @@ CONFIG_XENO_DRIVERS_UDD=m
>  # Real-time GPIO drivers
>  #
>  CONFIG_XENO_DRIVERS_GPIO=y
> -CONFIG_XENO_DRIVERS_GPIO_DEBUG=y
> +# CONFIG_XENO_DRIVERS_GPIO_DEBUG is not set
>  
>  #
>  # GPIOPWM support
> @@ -669,7 +669,7 @@ CONFIG_X86_EXTENDED_PLATFORM=y
>  # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
>  # CONFIG_IOSF_MBI is not set
>  CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> -CONFIG_SCHED_OMIT_FRAME_POINTER=y
> +# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>  CONFIG_HYPERVISOR_GUEST=y
>  CONFIG_NO_BOOTMEM=y
>  # CONFIG_MK8 is not set
> @@ -683,7 +683,7 @@ CONFIG_X86_TSC=y
>  CONFIG_X86_CMPXCHG64=y
>  CONFIG_X86_CMOV=y
>  CONFIG_X86_MINIMUM_CPU_FAMILY=64
> -CONFIG_X86_DEBUGCTLMSR=y
> +# CONFIG_X86_DEBUGCTLMSR is not set
>  CONFIG_CPU_SUP_INTEL=y
>  CONFIG_CPU_SUP_AMD=y
>  CONFIG_CPU_SUP_CENTAUR=y
> @@ -725,9 +725,9 @@ CONFIG_X86_THERMAL_VECTOR=y
>  #
>  # Performance monitoring
>  #
> -CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> -CONFIG_PERF_EVENTS_INTEL_RAPL=y
> -CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> +# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
> +# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
> +# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
>  # CONFIG_PERF_EVENTS_AMD_POWER is not set
>  # CONFIG_VM86 is not set
>  CONFIG_X86_16BIT=y
> @@ -754,7 +754,7 @@ CONFIG_NODES_SHIFT=6
>  CONFIG_ARCH_SPARSEMEM_ENABLE=y
>  CONFIG_ARCH_SPARSEMEM_DEFAULT=y
>  CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> -CONFIG_ARCH_MEMORY_PROBE=y
> +# CONFIG_ARCH_MEMORY_PROBE is not set
>  CONFIG_ARCH_PROC_KCORE_TEXT=y
>  CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
>  CONFIG_SELECT_MEMORY_MODEL=y
> @@ -809,9 +809,9 @@ CONFIG_X86_CHECK_BIOS_CORRUPTION=y
>  CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
>  CONFIG_X86_RESERVE_LOW=64
>  CONFIG_MTRR=y
> -CONFIG_MTRR_SANITIZER=y
> -CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> -CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> +# CONFIG_MTRR_SANITIZER is not set
> +# CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT is not set
> +# CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT is not set
>  CONFIG_X86_PAT=y
>  CONFIG_ARCH_USES_PG_UNCACHED=y
>  CONFIG_ARCH_RANDOM=y
> @@ -864,12 +864,12 @@ CONFIG_PM_SLEEP_SMP=y
>  # CONFIG_PM_AUTOSLEEP is not set
>  # CONFIG_PM_WAKELOCKS is not set
>  CONFIG_PM=y
> -CONFIG_PM_DEBUG=y
> +# CONFIG_PM_DEBUG is not set
>  # CONFIG_PM_ADVANCED_DEBUG is not set
> -CONFIG_PM_TEST_SUSPEND=y
> -CONFIG_PM_SLEEP_DEBUG=y
> -CONFIG_PM_TRACE=y
> -CONFIG_PM_TRACE_RTC=y
> +# CONFIG_PM_TEST_SUSPEND is not set
> +# CONFIG_PM_SLEEP_DEBUG is not set
> +# CONFIG_PM_TRACE is not set
> +# CONFIG_PM_TRACE_RTC is not set
>  CONFIG_PM_CLK=y
>  # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
>  CONFIG_ACPI=y
> @@ -1460,7 +1460,7 @@ CONFIG_ALLOW_DEV_COREDUMP=y
>  # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
>  # CONFIG_SYS_HYPERVISOR is not set
>  # CONFIG_GENERIC_CPU_DEVICES is not set
> -CONFIG_GENERIC_CPU_AUTOPROBE=y
> +# CONFIG_GENERIC_CPU_AUTOPROBE is not set
>  CONFIG_GENERIC_CPU_VULNERABILITIES=y
>  CONFIG_REGMAP=y
>  CONFIG_REGMAP_I2C=y
> @@ -1476,7 +1476,7 @@ CONFIG_PROC_EVENTS=y
>  CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
>  # CONFIG_PARPORT is not set
>  CONFIG_PNP=y
> -CONFIG_PNP_DEBUG_MESSAGES=y
> +# CONFIG_PNP_DEBUG_MESSAGES is not set
>  
>  #
>  # Protocols
> @@ -3292,7 +3292,7 @@ CONFIG_RTC_DRV_CMOS=y
>  # HID Sensor RTC drivers
>  #
>  CONFIG_DMADEVICES=y
> -CONFIG_DMADEVICES_DEBUG=y
> +# CONFIG_DMADEVICES_DEBUG is not set
>  # CONFIG_DMADEVICES_VDEBUG is not set
>  
>  #
> @@ -3739,7 +3739,7 @@ CONFIG_NLS_ISO8859_1=y
>  #
>  # Kernel hacking
>  #
> -CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +# CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
>  
>  #
>  # printk and dmesg options
> @@ -3753,11 +3753,11 @@ CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
>  #
>  # Compile-time checks and compiler options
>  #
> -CONFIG_DEBUG_INFO=y
> +# CONFIG_DEBUG_INFO is not set
>  # CONFIG_DEBUG_INFO_REDUCED is not set
>  # CONFIG_DEBUG_INFO_SPLIT is not set
>  # CONFIG_DEBUG_INFO_DWARF4 is not set
> -CONFIG_GDB_SCRIPTS=y
> +# CONFIG_GDB_SCRIPTS is not set
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set
>  # CONFIG_ENABLE_MUST_CHECK is not set
>  CONFIG_FRAME_WARN=1024
> @@ -3765,58 +3765,59 @@ CONFIG_FRAME_WARN=1024
>  # CONFIG_READABLE_ASM is not set
>  CONFIG_UNUSED_SYMBOLS=y
>  # CONFIG_PAGE_OWNER is not set
> -CONFIG_DEBUG_FS=y
> +# CONFIG_DEBUG_FS is not set
>  # CONFIG_HEADERS_CHECK is not set
> -CONFIG_DEBUG_SECTION_MISMATCH=y
> +# CONFIG_DEBUG_SECTION_MISMATCH is not set
>  CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>  CONFIG_STACK_VALIDATION=y
>  # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> -CONFIG_MAGIC_SYSRQ_SERIAL=y
> -CONFIG_IPIPE_DEBUG=y
> -CONFIG_IPIPE_DEBUG_CONTEXT=y
> -CONFIG_IPIPE_DEBUG_INTERNAL=y
> -CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> -CONFIG_IPIPE_TRACE=y
> +# CONFIG_MAGIC_SYSRQ is not set
> +# CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE is not set
> +# CONFIG_MAGIC_SYSRQ_SERIAL is not set
> +# CONFIG_IPIPE_DEBUG is not set
> +# CONFIG_IPIPE_DEBUG_CONTEXT is not set
> +# CONFIG_IPIPE_DEBUG_INTERNAL is not set
> +# CONFIG_HAVE_IPIPE_TRACER_SUPPORT is not set
> +# CONFIG_IPIPE_TRACE is not set
>  # CONFIG_IPIPE_TRACE_ENABLE is not set
> -CONFIG_IPIPE_TRACE_MCOUNT=y
> -CONFIG_IPIPE_TRACE_IRQSOFF=y
> -CONFIG_IPIPE_TRACE_SHIFT=14
> +# CONFIG_IPIPE_TRACE_MCOUNT is not set
> +# CONFIG_IPIPE_TRACE_IRQSOFF is not set
> +# CONFIG_IPIPE_TRACE_SHIFT is not set
>  # CONFIG_IPIPE_TRACE_VMALLOC is not set
> -CONFIG_IPIPE_TRACE_PANIC=y
> -CONFIG_DEBUG_KERNEL=y
> +# CONFIG_IPIPE_TRACE_PANIC is not set
> +# CONFIG_DEBUG_KERNEL is not set
>  
>  #
>  # Memory Debugging
>  #
> -CONFIG_PAGE_EXTENSION=y
> -CONFIG_DEBUG_PAGEALLOC=y
> +# CONFIG_PAGE_EXTENSION is not set
> +# CONFIG_DEBUG_PAGEALLOC is not set
>  # CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
>  # CONFIG_PAGE_POISONING is not set
>  # CONFIG_DEBUG_PAGE_REF is not set
> -CONFIG_DEBUG_RODATA_TEST=y
> +# CONFIG_DEBUG_RODATA_TEST is not set
>  # CONFIG_DEBUG_OBJECTS is not set
> -CONFIG_SLUB_DEBUG_ON=y
> +# CONFIG_SLUB_DEBUG_ON is not set
>  # CONFIG_SLUB_STATS is not set
> -CONFIG_HAVE_DEBUG_KMEMLEAK=y
> +# CONFIG_HAVE_DEBUG_KMEMLEAK is not set
>  # CONFIG_DEBUG_KMEMLEAK is not set
>  # CONFIG_DEBUG_STACK_USAGE is not set
> -CONFIG_DEBUG_VM=y
> +# CONFIG_DEBUG_VM is not set
>  # CONFIG_DEBUG_VM_VMACACHE is not set
>  # CONFIG_DEBUG_VM_RB is not set
>  # CONFIG_DEBUG_VM_PGFLAGS is not set
> -CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> -CONFIG_DEBUG_VIRTUAL=y
> -CONFIG_DEBUG_MEMORY_INIT=y
> +# CONFIG_DEBUG_VM_PGTABLE is not set
> +# CONFIG_ARCH_HAS_DEBUG_VIRTUAL is not set
> +# CONFIG_DEBUG_VIRTUAL is not set
> +# CONFIG_DEBUG_MEMORY_INIT is not set
>  # CONFIG_DEBUG_PER_CPU_MAPS is not set
> -CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> +# CONFIG_HAVE_DEBUG_STACKOVERFLOW is not set
>  # CONFIG_DEBUG_STACKOVERFLOW is not set
> -CONFIG_HAVE_ARCH_KASAN=y
> +# CONFIG_HAVE_ARCH_KASAN is not set
>  # CONFIG_KASAN is not set
> -CONFIG_ARCH_HAS_KCOV=y
> +# CONFIG_ARCH_HAS_KCOV is not set
>  # CONFIG_KCOV is not set
> -CONFIG_DEBUG_SHIRQ=y
> +# CONFIG_DEBUG_SHIRQ is not set
>  
>  #
>  # Debug Lockups and Hangs
> @@ -3829,36 +3830,36 @@ CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
>  # CONFIG_PANIC_ON_OOPS is not set
>  CONFIG_PANIC_ON_OOPS_VALUE=0
>  CONFIG_PANIC_TIMEOUT=0
> -CONFIG_SCHED_DEBUG=y
> -CONFIG_SCHED_INFO=y
> +# CONFIG_SCHED_DEBUG is not set
> +# CONFIG_SCHED_INFO is not set
>  # CONFIG_SCHEDSTATS is not set
>  # CONFIG_SCHED_STACK_END_CHECK is not set
>  # CONFIG_DEBUG_TIMEKEEPING is not set
> -CONFIG_DEBUG_PREEMPT=y
> +# CONFIG_DEBUG_PREEMPT is not set
>  
>  #
>  # Lock Debugging (spinlocks, mutexes, etc...)
>  #
> -CONFIG_DEBUG_RT_MUTEXES=y
> -CONFIG_DEBUG_SPINLOCK=y
> -CONFIG_DEBUG_MUTEXES=y
> +# CONFIG_DEBUG_RT_MUTEXES is not set
> +# CONFIG_DEBUG_SPINLOCK is not set
> +# CONFIG_DEBUG_MUTEXES is not set
>  # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> -CONFIG_DEBUG_LOCK_ALLOC=y
> -CONFIG_PROVE_LOCKING=y
> -CONFIG_LOCKDEP=y
> +# CONFIG_DEBUG_LOCK_ALLOC is not set
> +# CONFIG_PROVE_LOCKING is not set
> +# CONFIG_LOCKDEP is not set
>  # CONFIG_LOCK_STAT is not set
>  # CONFIG_DEBUG_LOCKDEP is not set
> -CONFIG_DEBUG_ATOMIC_SLEEP=y
> -CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> +# CONFIG_DEBUG_ATOMIC_SLEEP is not set
> +# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
>  # CONFIG_LOCK_TORTURE_TEST is not set
>  # CONFIG_WW_MUTEX_SELFTEST is not set
> -CONFIG_TRACE_IRQFLAGS=y
> -CONFIG_STACKTRACE=y
> +# CONFIG_TRACE_IRQFLAGS is not set
> +# CONFIG_STACKTRACE is not set
>  # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
>  # CONFIG_DEBUG_KOBJECT is not set
> -CONFIG_DEBUG_BUGVERBOSE=y
> -CONFIG_DEBUG_LIST=y
> -CONFIG_DEBUG_PI_LIST=y
> +# CONFIG_DEBUG_BUGVERBOSE is not set
> +# CONFIG_DEBUG_LIST is not set
> +# CONFIG_DEBUG_PI_LIST is not set
>  # CONFIG_DEBUG_SG is not set
>  # CONFIG_DEBUG_NOTIFIERS is not set
>  # CONFIG_DEBUG_CREDENTIALS is not set
> @@ -3879,43 +3880,43 @@ CONFIG_RCU_CPU_STALL_TIMEOUT=60
>  # CONFIG_NOTIFIER_ERROR_INJECTION is not set
>  # CONFIG_FAULT_INJECTION is not set
>  # CONFIG_LATENCYTOP is not set
> -CONFIG_USER_STACKTRACE_SUPPORT=y
> -CONFIG_NOP_TRACER=y
> -CONFIG_HAVE_FUNCTION_TRACER=y
> -CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> -CONFIG_HAVE_DYNAMIC_FTRACE=y
> -CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> -CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> -CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> +# CONFIG_USER_STACKTRACE_SUPPORT is not set
> +# CONFIG_NOP_TRACER is not set
> +# CONFIG_HAVE_FUNCTION_TRACER is not set
> +# CONFIG_HAVE_FUNCTION_GRAPH_TRACER is not set
> +# CONFIG_HAVE_DYNAMIC_FTRACE is not set
> +# CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS is not set
> +# CONFIG_HAVE_FTRACE_MCOUNT_RECORD is not set
> +# CONFIG_HAVE_SYSCALL_TRACEPOINTS is not set
>  CONFIG_HAVE_FENTRY=y
>  CONFIG_HAVE_C_RECORDMCOUNT=y
> -CONFIG_TRACER_MAX_TRACE=y
> -CONFIG_TRACE_CLOCK=y
> -CONFIG_RING_BUFFER=y
> -CONFIG_EVENT_TRACING=y
> -CONFIG_CONTEXT_SWITCH_TRACER=y
> -CONFIG_RING_BUFFER_ALLOW_SWAP=y
> -CONFIG_TRACING=y
> -CONFIG_GENERIC_TRACER=y
> -CONFIG_TRACING_SUPPORT=y
> -CONFIG_FTRACE=y
> -CONFIG_FUNCTION_TRACER=y
> -CONFIG_FUNCTION_GRAPH_TRACER=y
> -CONFIG_IRQSOFF_TRACER=y
> +# CONFIG_TRACER_MAX_TRACE is not set
> +# CONFIG_TRACE_CLOCK is not set
> +# CONFIG_RING_BUFFER is not set
> +# CONFIG_EVENT_TRACING is not set
> +# CONFIG_CONTEXT_SWITCH_TRACER is not set
> +# CONFIG_RING_BUFFER_ALLOW_SWAP is not set
> +# CONFIG_TRACING is not set
> +# CONFIG_GENERIC_TRACER is not set
> +# CONFIG_TRACING_SUPPORT is not set
> +# CONFIG_FTRACE is not set
> +# CONFIG_FUNCTION_TRACER is not set
> +# CONFIG_FUNCTION_GRAPH_TRACER is not set
> +# CONFIG_IRQSOFF_TRACER is not set
>  # CONFIG_PREEMPT_TRACER is not set
> -CONFIG_SCHED_TRACER=y
> +# CONFIG_SCHED_TRACER is not set
>  # CONFIG_HWLAT_TRACER is not set
> -CONFIG_FTRACE_SYSCALLS=y
> -CONFIG_TRACER_SNAPSHOT=y
> -CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> -CONFIG_BRANCH_PROFILE_NONE=y
> +# CONFIG_FTRACE_SYSCALLS is not set
> +# CONFIG_TRACER_SNAPSHOT is not set
> +# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> +# CONFIG_BRANCH_PROFILE_NONE is not set
>  # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
>  # CONFIG_PROFILE_ALL_BRANCHES is not set
>  # CONFIG_STACK_TRACER is not set
>  # CONFIG_BLK_DEV_IO_TRACE is not set
> -CONFIG_KPROBE_EVENTS=y
> -CONFIG_UPROBE_EVENTS=y
> -CONFIG_PROBE_EVENTS=y
> +# CONFIG_KPROBE_EVENTS is not set
> +# CONFIG_UPROBE_EVENTS is not set
> +# CONFIG_PROBE_EVENTS is not set
>  # CONFIG_FUNCTION_PROFILER is not set
>  # CONFIG_FTRACE_STARTUP_TEST is not set
>  # CONFIG_MMIOTRACE is not set
> @@ -3924,7 +3925,7 @@ CONFIG_PROBE_EVENTS=y
>  # CONFIG_RING_BUFFER_BENCHMARK is not set
>  # CONFIG_RING_BUFFER_STARTUP_TEST is not set
>  # CONFIG_TRACE_EVAL_MAP_FILE is not set
> -CONFIG_TRACING_EVENTS_GPIO=y
> +# CONFIG_TRACING_EVENTS_GPIO is not set
>  # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
>  # CONFIG_DMA_API_DEBUG is not set
>  
> @@ -3960,14 +3961,14 @@ CONFIG_TRACING_EVENTS_GPIO=y
>  # CONFIG_MEMTEST is not set
>  CONFIG_BUG_ON_DATA_CORRUPTION=y
>  # CONFIG_SAMPLES is not set
> -CONFIG_HAVE_ARCH_KGDB=y
> -CONFIG_KGDB=y
> -CONFIG_KGDB_SERIAL_CONSOLE=y
> -CONFIG_KGDB_TESTS=y
> +# CONFIG_HAVE_ARCH_KGDB is not set
> +# CONFIG_KGDB is not set
> +# CONFIG_KGDB_SERIAL_CONSOLE is not set
> +# CONFIG_KGDB_TESTS is not set
>  # CONFIG_KGDB_TESTS_ON_BOOT is not set
>  # CONFIG_KGDB_LOW_LEVEL_TRAP is not set
>  # CONFIG_KGDB_KDB is not set
> -CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> +# CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL is not set
>  # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
>  # CONFIG_UBSAN is not set
>  CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> @@ -3986,25 +3987,25 @@ CONFIG_DOUBLEFAULT=y
>  # CONFIG_DEBUG_TLBFLUSH is not set
>  # CONFIG_IOMMU_DEBUG is not set
>  # CONFIG_IOMMU_STRESS is not set
> -CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> +# CONFIG_HAVE_MMIOTRACE_SUPPORT is not set
>  # CONFIG_X86_DECODER_SELFTEST is not set
> -CONFIG_IO_DELAY_TYPE_0X80=0
> -CONFIG_IO_DELAY_TYPE_0XED=1
> -CONFIG_IO_DELAY_TYPE_UDELAY=2
> -CONFIG_IO_DELAY_TYPE_NONE=3
> -CONFIG_IO_DELAY_0X80=y
> +# CONFIG_IO_DELAY_TYPE_0X80 is not set
> +# CONFIG_IO_DELAY_TYPE_0XED is not set
> +# CONFIG_IO_DELAY_TYPE_UDELAY is not set
> +# CONFIG_IO_DELAY_TYPE_NONE is not set
> +# CONFIG_IO_DELAY_0X80 is not set
>  # CONFIG_IO_DELAY_0XED is not set
>  # CONFIG_IO_DELAY_UDELAY is not set
>  # CONFIG_IO_DELAY_NONE is not set
> -CONFIG_DEFAULT_IO_DELAY_TYPE=0
> +# CONFIG_DEFAULT_IO_DELAY_TYPE is not set
>  # CONFIG_DEBUG_BOOT_PARAMS is not set
>  # CONFIG_CPA_DEBUG is not set
>  CONFIG_OPTIMIZE_INLINING=y
>  # CONFIG_DEBUG_ENTRY is not set
>  # CONFIG_DEBUG_NMI_SELFTEST is not set
> -CONFIG_X86_DEBUG_FPU=y
> +# CONFIG_X86_DEBUG_FPU is not set
>  # CONFIG_PUNIT_ATOM_DEBUG is not set
> -CONFIG_UNWINDER_ORC=y
> +# CONFIG_UNWINDER_ORC is not set
>  # CONFIG_UNWINDER_FRAME_POINTER is not set
>  
>  #
> diff --git a/recipes-kernel/linux/files/arm64_debugconfig b/recipes-kernel/linux/files/arm64_debugconfig
> new file mode 100644
> index 0000000..df45c04
> --- /dev/null
> +++ b/recipes-kernel/linux/files/arm64_debugconfig
> @@ -0,0 +1,404 @@
> +#
> +# Debug Kernel Configuration
> +#
> +CONFIG_STACKTRACE_SUPPORT=y
> +CONFIG_LOCKDEP_SUPPORT=y
> +CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +CONFIG_ARCH_SUPPORTS_UPROBES=y
> +
> +#
> +# IRQ subsystem
> +#
> +CONFIG_GENERIC_IRQ_PROBE=y
> +# CONFIG_IRQ_DOMAIN_DEBUG is not set
> +# CONFIG_GENERIC_IRQ_DEBUGFS is not set
> +
> +#
> +# RCU Subsystem
> +#
> +# CONFIG_DEBUG_BLK_CGROUP is not set
> +CONFIG_CGROUP_PERF=y
> +# CONFIG_CGROUP_DEBUG is not set
> +CONFIG_SYSCTL_EXCEPTION_TRACE=y
> +CONFIG_KALLSYMS=y
> +CONFIG_KALLSYMS_ALL=y
> +# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> +CONFIG_KALLSYMS_BASE_RELATIVE=y
> +CONFIG_HAVE_PERF_EVENTS=y
> +
> +#
> +# Kernel Performance Events And Counters
> +#
> +CONFIG_PERF_EVENTS=y
> +# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> +CONFIG_SLUB_DEBUG=y
> +# CONFIG_KPROBES is not set
> +# CONFIG_UPROBES is not set
> +CONFIG_HAVE_KPROBES=y
> +CONFIG_HAVE_KRETPROBES=y
> +CONFIG_HAVE_ARCH_TRACEHOOK=y
> +CONFIG_HAVE_DMA_API_DEBUG=y
> +CONFIG_HAVE_PERF_REGS=y
> +CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> +
> +#
> +# GCOV-based kernel profiling
> +#
> +CONFIG_BLK_DEBUG_FS=y
> +
> +#
> +# Sizes and static limits
> +#
> +CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> +
> +#
> +# Latency settings
> +#
> +CONFIG_XENO_OPT_DEBUG=y
> +CONFIG_XENO_OPT_DEBUG_COBALT=y
> +CONFIG_XENO_OPT_DEBUG_MEMORY=y
> +CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> +CONFIG_XENO_OPT_DEBUG_LOCKING=y
> +CONFIG_XENO_OPT_DEBUG_USER=y
> +CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> +CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> +CONFIG_XENO_OPT_DEBUG_LEGACY=y
> +CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> +
> +#
> +# Testing drivers
> +#
> +CONFIG_XENO_DRIVERS_HEAPCHECK=y
> +
> +#
> +# CAN drivers
> +#
> +CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> +
> +#
> +# Protocols
> +#
> +CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
> +CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
> +
> +#
> +#
> +
> +
> +#
> +# Bus support
> +#
> +# CONFIG_PCIEASPM_DEBUG is not set
> +# CONFIG_PCI_DEBUG is not set
> +
> +#
> +# ARM errata workarounds via the alternatives framework
> +#
> +CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> +CONFIG_HW_PERF_EVENTS=y
> +# CONFIG_CMA_DEBUG is not set
> +# CONFIG_CMA_DEBUGFS is not set
> +
> +#
> +# ARMv8.2 architectural features
> +#
> +# CONFIG_RANDOMIZE_BASE is not set
> +
> +#
> +# Power management options
> +#
> +# CONFIG_PM_DEBUG is not set
> +
> +#
> +# CPU frequency scaling drivers
> +#
> +# CONFIG_ARM_BRCMSTB_AVS_CPUFREQ_DEBUG is not set
> +
> +#
> +# Network testing
> +#
> +# CONFIG_BT_DEBUGFS is not set
> +
> +#
> +# Bluetooth device drivers
> +#
> +# CONFIG_CFG80211_DEBUGFS is not set
> +# CONFIG_CFG80211_INTERNAL_REGDB is not set
> +# CONFIG_MAC80211_DEBUGFS is not set
> +# CONFIG_MAC80211_MESSAGE_TRACING is not set
> +# CONFIG_MAC80211_DEBUG_MENU is not set
> +# CONFIG_NET_9P_DEBUG is not set
> +
> +#
> +# Generic Driver Options
> +#
> +# CONFIG_DEBUG_DRIVER is not set
> +# CONFIG_DEBUG_DEVRES is not set
> +# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> +# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> +CONFIG_GENERIC_CPU_AUTOPROBE=y
> +# CONFIG_DMA_FENCE_TRACE is not set
> +
> +#
> +# RAM/ROM/Flash chip drivers
> +#
> +# CONFIG_MTD_JEDECPROBE is not set
> +
> +#
> +# LPDDR & LPDDR2 PCM memory drivers
> +#
> +CONFIG_PNP_DEBUG_MESSAGES=y
> +
> +#
> +# SCSI Transports
> +#
> +# CONFIG_SCSI_DEBUG is not set
> +
> +#
> +# Distributed Switch Architecture drivers
> +#
> +# CONFIG_SKY2_DEBUG is not set
> +
> +#
> +# MII PHY device drivers
> +#
> +# CONFIG_ATH_DEBUG is not set
> +# CONFIG_BRCM_TRACING is not set
> +
> +#
> +# Character devices
> +#
> +# CONFIG_TRACE_SINK is not set
> +
> +#
> +# Other I2C/SMBus bus drivers
> +#
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_SPI_DEBUG is not set
> +
> +#
> +# SPI Protocol Masters
> +#
> +# CONFIG_PPS_DEBUG is not set
> +
> +#
> +# Pin controllers
> +#
> +# CONFIG_DEBUG_PINCTRL is not set
> +# CONFIG_DEBUG_GPIO is not set
> +
> +#
> +# USB GPIO expanders
> +#
> +# CONFIG_POWER_SUPPLY_DEBUG is not set
> +# CONFIG_HWMON_DEBUG_CHIP is not set
> +
> +#
> +# Multifunction device drivers
> +#
> +# CONFIG_REGULATOR_DEBUG is not set
> +
> +#
> +# Multimedia core support
> +#
> +# CONFIG_VIDEO_ADV_DEBUG is not set
> +
> +#
> +# Graphics support
> +#
> +# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> +
> +#
> +# ACP (Audio CoProcessor) Configuration
> +#
> +CONFIG_NOUVEAU_DEBUG=5
> +CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +
> +#
> +# Sub-drivers
> +#
> +# CONFIG_DRM_TEGRA_DEBUG is not set
> +
> +#
> +# Console display driver support
> +#
> +# CONFIG_SND_DEBUG is not set
> +
> +#
> +# also be needed; see USB_STORAGE Help for more info
> +#
> +# CONFIG_USB_STORAGE_DEBUG is not set
> +
> +#
> +# Gadget/Dual-role mode requires USB Gadget support to be enabled
> +#
> +# CONFIG_USB_DWC2_DEBUG is not set
> +
> +#
> +# USB Physical Layer drivers
> +#
> +# CONFIG_USB_GADGET_DEBUG is not set
> +# CONFIG_USB_GADGET_DEBUG_FILES is not set
> +# CONFIG_USB_GADGET_DEBUG_FS is not set
> +
> +#
> +# MMC/SD/SDIO Host Controller Drivers
> +#
> +# CONFIG_MMC_DEBUG is not set
> +
> +#
> +# iptables trigger is under Netfilter config (LED target)
> +#
> +# CONFIG_EDAC_DEBUG is not set
> +# CONFIG_RTC_DEBUG is not set
> +
> +#
> +# HID Sensor RTC drivers
> +#
> +# CONFIG_DMADEVICES_DEBUG is not set
> +
> +#
> +# Clock Source drivers
> +#
> +CONFIG_TIMER_PROBE=y
> +
> +#
> +# Tegra firmware driver
> +#
> +# CONFIG_ACPI_DEBUGGER is not set
> +# CONFIG_ACPI_EC_DEBUGFS is not set
> +# CONFIG_ACPI_DEBUG is not set
> +# CONFIG_ACPI_APEI_ERST_DEBUG is not set
> +
> +#
> +# File systems
> +#
> +# CONFIG_EXT4_DEBUG is not set
> +# CONFIG_JBD2_DEBUG is not set
> +# CONFIG_BTRFS_DEBUG is not set
> +# CONFIG_QUOTA_DEBUG is not set
> +
> +#
> +# Pseudo filesystems
> +#
> +# CONFIG_SUNRPC_DEBUG is not set
> +
> +#
> +# printk and dmesg options
> +#
> +# CONFIG_DYNAMIC_DEBUG is not set
> +
> +#
> +# Compile-time checks and compiler options
> +#
> +CONFIG_DEBUG_INFO=y
> +# CONFIG_DEBUG_INFO_REDUCED is not set
> +# CONFIG_DEBUG_INFO_SPLIT is not set
> +# CONFIG_DEBUG_INFO_DWARF4 is not set
> +# CONFIG_GDB_SCRIPTS is not set
> +CONFIG_DEBUG_FS=y
> +# CONFIG_DEBUG_SECTION_MISMATCH is not set
> +CONFIG_ARCH_WANT_FRAME_POINTERS=y
> +CONFIG_FRAME_POINTER=y
> +# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> +CONFIG_MAGIC_SYSRQ_SERIAL=y
> +CONFIG_IPIPE_DEBUG=y
> +CONFIG_IPIPE_DEBUG_CONTEXT=y
> +CONFIG_IPIPE_DEBUG_INTERNAL=y
> +CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> +# CONFIG_IPIPE_TRACE is not set
> +CONFIG_DEBUG_KERNEL=y
> +
> +#
> +# Memory Debugging
> +#
> +# CONFIG_PAGE_EXTENSION is not set
> +# CONFIG_DEBUG_PAGEALLOC is not set
> +# CONFIG_DEBUG_RODATA_TEST is not set
> +# CONFIG_DEBUG_OBJECTS is not set
> +# CONFIG_SLUB_DEBUG_ON is not set
> +CONFIG_HAVE_DEBUG_KMEMLEAK=y
> +# CONFIG_DEBUG_KMEMLEAK is not set
> +# CONFIG_DEBUG_STACK_USAGE is not set
> +# CONFIG_DEBUG_VM is not set
> +CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> +# CONFIG_DEBUG_VIRTUAL is not set
> +CONFIG_DEBUG_MEMORY_INIT=y
> +# CONFIG_DEBUG_PER_CPU_MAPS is not set
> +CONFIG_HAVE_ARCH_KASAN=y
> +# CONFIG_KASAN is not set
> +CONFIG_ARCH_HAS_KCOV=y
> +# CONFIG_KCOV is not set
> +# CONFIG_DEBUG_SHIRQ is not set
> +
> +#
> +# Debug Lockups and Hangs
> +#
> +# CONFIG_SCHED_DEBUG is not set
> +CONFIG_SCHED_INFO=y
> +# CONFIG_DEBUG_TIMEKEEPING is not set
> +# CONFIG_DEBUG_PREEMPT is not set
> +
> +#
> +# Lock Debugging (spinlocks, mutexes, etc...)
> +#
> +# CONFIG_DEBUG_RT_MUTEXES is not set
> +# CONFIG_DEBUG_SPINLOCK is not set
> +# CONFIG_DEBUG_MUTEXES is not set
> +# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> +# CONFIG_DEBUG_LOCK_ALLOC is not set
> +# CONFIG_PROVE_LOCKING is not set
> +# CONFIG_DEBUG_ATOMIC_SLEEP is not set
> +# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> +# CONFIG_STACKTRACE is not set
> +# CONFIG_DEBUG_KOBJECT is not set
> +CONFIG_HAVE_DEBUG_BUGVERBOSE=y
> +CONFIG_DEBUG_BUGVERBOSE=y
> +# CONFIG_DEBUG_LIST is not set
> +# CONFIG_DEBUG_PI_LIST is not set
> +# CONFIG_DEBUG_SG is not set
> +# CONFIG_DEBUG_NOTIFIERS is not set
> +# CONFIG_DEBUG_CREDENTIALS is not set
> +
> +#
> +# RCU Debugging
> +#
> +# CONFIG_PROVE_RCU is not set
> +# CONFIG_RCU_PERF_TEST is not set
> +# CONFIG_RCU_TRACE is not set
> +# CONFIG_RCU_EQS_DEBUG is not set
> +# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> +# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> +CONFIG_HAVE_FUNCTION_TRACER=y
> +CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> +CONFIG_HAVE_DYNAMIC_FTRACE=y
> +CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> +CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> +CONFIG_TRACING_SUPPORT=y
> +CONFIG_EVENT_TRACING=y
> +CONFIG_CONTEXT_SWITCH_TRACER=y
> +CONFIG_TRACING=y
> +CONFIG_FTRACE=y
> +# CONFIG_DMA_API_DEBUG is not set
> +
> +#
> +# Runtime Testing
> +#
> +# CONFIG_BACKTRACE_SELF_TEST is not set
> +CONFIG_HAVE_ARCH_KGDB=y
> +# CONFIG_KGDB is not set
> +CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> +# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> +# CONFIG_UBSAN is not set
> +# CONFIG_ARM64_PTDUMP_DEBUGFS is not set
> +# CONFIG_DEBUG_WX is not set
> +# CONFIG_DEBUG_ALIGN_RODATA is not set
> +# CONFIG_DEBUG_EFI is not set
> +
> +#
> +# Library routines
> +#
> diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
> index 1dc8b69..d5fac57 100644
> --- a/recipes-kernel/linux/files/arm64_defconfig
> +++ b/recipes-kernel/linux/files/arm64_defconfig
> @@ -12,10 +12,10 @@ CONFIG_ARCH_MMAP_RND_BITS_MIN=18
>  CONFIG_ARCH_MMAP_RND_BITS_MAX=33
>  CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=11
>  CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> -CONFIG_STACKTRACE_SUPPORT=y
> +# CONFIG_STACKTRACE_SUPPORT is not set
>  CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> -CONFIG_LOCKDEP_SUPPORT=y
> -CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +# CONFIG_LOCKDEP_SUPPORT is not set
> +# CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
>  CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>  CONFIG_GENERIC_BUG=y
>  CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> @@ -33,7 +33,7 @@ CONFIG_IOMMU_HELPER=y
>  CONFIG_KERNEL_MODE_NEON=y
>  CONFIG_FIX_EARLYCON_MEM=y
>  CONFIG_PGTABLE_LEVELS=4
> -CONFIG_ARCH_SUPPORTS_UPROBES=y
> +# CONFIG_ARCH_SUPPORTS_UPROBES is not set
>  CONFIG_ARCH_PROC_KCORE_TEXT=y
>  CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>  CONFIG_IRQ_WORK=y
> @@ -66,7 +66,7 @@ CONFIG_AUDIT_TREE=y
>  #
>  # IRQ subsystem
>  #
> -CONFIG_GENERIC_IRQ_PROBE=y
> +# CONFIG_GENERIC_IRQ_PROBE is not set
>  CONFIG_GENERIC_IRQ_SHOW=y
>  CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
>  CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> @@ -150,7 +150,7 @@ CONFIG_CPUSETS=y
>  CONFIG_PROC_PID_CPUSET=y
>  CONFIG_CGROUP_DEVICE=y
>  CONFIG_CGROUP_CPUACCT=y
> -CONFIG_CGROUP_PERF=y
> +# CONFIG_CGROUP_PERF is not set
>  # CONFIG_CGROUP_DEBUG is not set
>  # CONFIG_SOCK_CGROUP_DATA is not set
>  # CONFIG_CHECKPOINT_RESTORE is not set
> @@ -176,7 +176,7 @@ CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
>  CONFIG_SYSCTL=y
>  CONFIG_ANON_INODES=y
>  CONFIG_HAVE_UID16=y
> -CONFIG_SYSCTL_EXCEPTION_TRACE=y
> +# CONFIG_SYSCTL_EXCEPTION_TRACE is not set
>  CONFIG_BPF=y
>  # CONFIG_EXPERT is not set
>  CONFIG_UID16=y
> @@ -185,10 +185,10 @@ CONFIG_MULTIUSER=y
>  CONFIG_SYSFS_SYSCALL=y
>  # CONFIG_SYSCTL_SYSCALL is not set
>  CONFIG_POSIX_TIMERS=y
> -CONFIG_KALLSYMS=y
> -CONFIG_KALLSYMS_ALL=y
> +# CONFIG_KALLSYMS is not set
> +# CONFIG_KALLSYMS_ALL is not set
>  # CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> -CONFIG_KALLSYMS_BASE_RELATIVE=y
> +# CONFIG_KALLSYMS_BASE_RELATIVE is not set
>  CONFIG_PRINTK=y
>  CONFIG_PRINTK_NMI=y
>  CONFIG_RAW_PRINTK=y
> @@ -209,16 +209,16 @@ CONFIG_ADVISE_SYSCALLS=y
>  CONFIG_PCI_QUIRKS=y
>  CONFIG_MEMBARRIER=y
>  # CONFIG_EMBEDDED is not set
> -CONFIG_HAVE_PERF_EVENTS=y
> +# CONFIG_HAVE_PERF_EVENTS is not set
>  # CONFIG_PC104 is not set
>  
>  #
>  # Kernel Performance Events And Counters
>  #
> -CONFIG_PERF_EVENTS=y
> +# CONFIG_PERF_EVENTS is not set
>  # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>  CONFIG_VM_EVENT_COUNTERS=y
> -CONFIG_SLUB_DEBUG=y
> +# CONFIG_SLUB_DEBUG is not set
>  # CONFIG_SLUB_MEMCG_SYSFS_ON is not set
>  # CONFIG_COMPAT_BRK is not set
>  # CONFIG_SLAB is not set
> @@ -237,10 +237,10 @@ CONFIG_JUMP_LABEL=y
>  # CONFIG_UPROBES is not set
>  # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
>  CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> -CONFIG_HAVE_KPROBES=y
> -CONFIG_HAVE_KRETPROBES=y
> +# CONFIG_HAVE_KPROBES is not set
> +# CONFIG_HAVE_KRETPROBES is not set
>  CONFIG_HAVE_NMI=y
> -CONFIG_HAVE_ARCH_TRACEHOOK=y
> +# CONFIG_HAVE_ARCH_TRACEHOOK is not set
>  CONFIG_HAVE_DMA_CONTIGUOUS=y
>  CONFIG_GENERIC_SMP_IDLE_THREAD=y
>  CONFIG_GENERIC_IDLE_POLL_SETUP=y
> @@ -248,10 +248,10 @@ CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
>  CONFIG_ARCH_HAS_SET_MEMORY=y
>  CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>  CONFIG_HAVE_CLK=y
> -CONFIG_HAVE_DMA_API_DEBUG=y
> +# CONFIG_HAVE_DMA_API_DEBUG is not set
>  CONFIG_HAVE_HW_BREAKPOINT=y
> -CONFIG_HAVE_PERF_REGS=y
> -CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> +# CONFIG_HAVE_PERF_REGS is not set
> +# CONFIG_HAVE_PERF_USER_STACK_DUMP is not set
>  CONFIG_HAVE_ARCH_JUMP_LABEL=y
>  CONFIG_HAVE_RCU_TABLE_FREE=y
>  CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> @@ -323,7 +323,7 @@ CONFIG_BLK_DEV_INTEGRITY=y
>  # CONFIG_BLK_DEV_THROTTLING is not set
>  # CONFIG_BLK_CMDLINE_PARSER is not set
>  # CONFIG_BLK_WBT is not set
> -CONFIG_BLK_DEBUG_FS=y
> +# CONFIG_BLK_DEBUG_FS is not set
>  # CONFIG_BLK_SED_OPAL is not set
>  
>  #
> @@ -390,7 +390,7 @@ CONFIG_XENO_OPT_SYS_HEAPSZ=4096
>  CONFIG_XENO_OPT_PRIVATE_HEAPSZ=256
>  CONFIG_XENO_OPT_SHARED_HEAPSZ=256
>  CONFIG_XENO_OPT_NRTIMERS=256
> -CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> +# CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ is not set
>  
>  #
>  # Latency settings
> @@ -398,16 +398,16 @@ CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
>  CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
>  CONFIG_XENO_OPT_TIMING_KSCHEDLAT=0
>  CONFIG_XENO_OPT_TIMING_IRQLAT=0
> -CONFIG_XENO_OPT_DEBUG=y
> -CONFIG_XENO_OPT_DEBUG_COBALT=y
> -CONFIG_XENO_OPT_DEBUG_MEMORY=y
> -CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> -CONFIG_XENO_OPT_DEBUG_LOCKING=y
> -CONFIG_XENO_OPT_DEBUG_USER=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> -CONFIG_XENO_OPT_DEBUG_LEGACY=y
> -CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> +# CONFIG_XENO_OPT_DEBUG is not set
> +# CONFIG_XENO_OPT_DEBUG_COBALT is not set
> +# CONFIG_XENO_OPT_DEBUG_MEMORY is not set
> +# CONFIG_XENO_OPT_DEBUG_CONTEXT is not set
> +# CONFIG_XENO_OPT_DEBUG_LOCKING is not set
> +# CONFIG_XENO_OPT_DEBUG_USER is not set
> +# CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED is not set
> +# CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP is not set
> +# CONFIG_XENO_OPT_DEBUG_LEGACY is not set
> +# CONFIG_XENO_OPT_DEBUG_TRACE_RELAX is not set
>  CONFIG_XENO_OPT_WATCHDOG=y
>  CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
>  
> @@ -432,14 +432,14 @@ CONFIG_XENO_DRIVERS_16550A_PCI_MOXA=y
>  #
>  CONFIG_XENO_DRIVERS_TIMERBENCH=y
>  CONFIG_XENO_DRIVERS_SWITCHTEST=y
> -CONFIG_XENO_DRIVERS_HEAPCHECK=y
> +# CONFIG_XENO_DRIVERS_HEAPCHECK is not set
>  CONFIG_XENO_DRIVERS_RTDMTEST=m
>  
>  #
>  # CAN drivers
>  #
>  CONFIG_XENO_DRIVERS_CAN=y
> -CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> +# CONFIG_XENO_DRIVERS_CAN_DEBUG is not set
>  CONFIG_XENO_DRIVERS_CAN_LOOPBACK=y
>  CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=1024
>  CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=4
> @@ -485,7 +485,7 @@ CONFIG_XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES=32
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_NETROUTING=y
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_NET_ROUTES=16
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_ROUTER=y
> -CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG=y
> +# CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG is not set
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP=m
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP=m
>  CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION=y
> @@ -495,7 +495,7 @@ CONFIG_XENO_DRIVERS_NET_TDMA=m
>  CONFIG_XENO_DRIVERS_NET_TDMA_MASTER=y
>  CONFIG_XENO_DRIVERS_NET_NOMAC=m
>  CONFIG_XENO_DRIVERS_NET_RTCFG=m
> -CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG=y
> +# CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG is not set
>  
>  #
>  # Drivers
> @@ -616,6 +616,7 @@ CONFIG_ARCH_MEDIATEK=y
>  CONFIG_ARCH_MESON=y
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_ARCH_QCOM=y
> +
>  # CONFIG_ARCH_REALTEK is not set
>  CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_ARCH_SEATTLE=y
> @@ -775,13 +776,13 @@ CONFIG_HZ_250=y
>  # CONFIG_HZ_1000 is not set
>  CONFIG_HZ=250
>  CONFIG_SCHED_HRTICK=y
> -CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> +# CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC is not set
>  CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
>  CONFIG_ARCH_SPARSEMEM_ENABLE=y
>  CONFIG_ARCH_SPARSEMEM_DEFAULT=y
>  CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>  CONFIG_HAVE_ARCH_PFN_VALID=y
> -CONFIG_HW_PERF_EVENTS=y
> +# CONFIG_HW_PERF_EVENTS is not set
>  CONFIG_SYS_SUPPORTS_HUGETLBFS=y
>  CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
>  CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> @@ -1398,7 +1399,7 @@ CONFIG_ALLOW_DEV_COREDUMP=y
>  # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
>  CONFIG_SYS_HYPERVISOR=y
>  # CONFIG_GENERIC_CPU_DEVICES is not set
> -CONFIG_GENERIC_CPU_AUTOPROBE=y
> +# CONFIG_GENERIC_CPU_AUTOPROBE is not set
>  CONFIG_SOC_BUS=y
>  CONFIG_REGMAP=y
>  CONFIG_REGMAP_I2C=y
> @@ -1558,7 +1559,7 @@ CONFIG_OF_OVERLAY=y
>  CONFIG_OF_NUMA=y
>  # CONFIG_PARPORT is not set
>  CONFIG_PNP=y
> -CONFIG_PNP_DEBUG_MESSAGES=y
> +# CONFIG_PNP_DEBUG_MESSAGES is not set
>  
>  #
>  # Protocols
> @@ -3653,8 +3654,8 @@ CONFIG_DRM_I2C_SIL164=m
>  #
>  CONFIG_DRM_NOUVEAU=m
>  CONFIG_NOUVEAU_PLATFORM_DRIVER=y
> -CONFIG_NOUVEAU_DEBUG=5
> -CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +# CONFIG_NOUVEAU_DEBUG is not set
> +# CONFIG_NOUVEAU_DEBUG_DEFAULT is not set
>  CONFIG_DRM_NOUVEAU_BACKLIGHT=y
>  # CONFIG_DRM_VGEM is not set
>  CONFIG_DRM_EXYNOS=m
> @@ -4940,7 +4941,7 @@ CONFIG_HWSPINLOCK_QCOM=y
>  #
>  CONFIG_TIMER_OF=y
>  CONFIG_TIMER_ACPI=y
> -CONFIG_TIMER_PROBE=y
> +# CONFIG_TIMER_PROBE is not set
>  CONFIG_CLKSRC_MMIO=y
>  CONFIG_ROCKCHIP_TIMER=y
>  CONFIG_ARM_ARCH_TIMER=y
> @@ -5887,7 +5888,7 @@ CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
>  #
>  # Compile-time checks and compiler options
>  #
> -CONFIG_DEBUG_INFO=y
> +# CONFIG_DEBUG_INFO is not set
>  # CONFIG_DEBUG_INFO_REDUCED is not set
>  # CONFIG_DEBUG_INFO_SPLIT is not set
>  # CONFIG_DEBUG_INFO_DWARF4 is not set
> @@ -5899,22 +5900,22 @@ CONFIG_FRAME_WARN=2048
>  # CONFIG_READABLE_ASM is not set
>  # CONFIG_UNUSED_SYMBOLS is not set
>  # CONFIG_PAGE_OWNER is not set
> -CONFIG_DEBUG_FS=y
> +# CONFIG_DEBUG_FS is not set
>  # CONFIG_HEADERS_CHECK is not set
>  # CONFIG_DEBUG_SECTION_MISMATCH is not set
>  CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> -CONFIG_ARCH_WANT_FRAME_POINTERS=y
> -CONFIG_FRAME_POINTER=y
> +# CONFIG_ARCH_WANT_FRAME_POINTERS is not set
> +# CONFIG_FRAME_POINTER is not set
>  # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> -CONFIG_MAGIC_SYSRQ_SERIAL=y
> -CONFIG_IPIPE_DEBUG=y
> -CONFIG_IPIPE_DEBUG_CONTEXT=y
> -CONFIG_IPIPE_DEBUG_INTERNAL=y
> -CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> +# CONFIG_MAGIC_SYSRQ is not set
> +# CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE is not set
> +# CONFIG_MAGIC_SYSRQ_SERIAL is not set
> +# CONFIG_IPIPE_DEBUG is not set
> +# CONFIG_IPIPE_DEBUG_CONTEXT is not set
> +# CONFIG_IPIPE_DEBUG_INTERNAL is not set
> +# CONFIG_HAVE_IPIPE_TRACER_SUPPORT is not set
>  # CONFIG_IPIPE_TRACE is not set
> -CONFIG_DEBUG_KERNEL=y
> +# CONFIG_DEBUG_KERNEL is not set
>  
>  #
>  # Memory Debugging
> @@ -5926,17 +5927,17 @@ CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_OBJECTS is not set
>  # CONFIG_SLUB_DEBUG_ON is not set
>  # CONFIG_SLUB_STATS is not set
> -CONFIG_HAVE_DEBUG_KMEMLEAK=y
> +# CONFIG_HAVE_DEBUG_KMEMLEAK is not set
>  # CONFIG_DEBUG_KMEMLEAK is not set
>  # CONFIG_DEBUG_STACK_USAGE is not set
>  # CONFIG_DEBUG_VM is not set
> -CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> +# CONFIG_ARCH_HAS_DEBUG_VIRTUAL is not set
>  # CONFIG_DEBUG_VIRTUAL is not set
> -CONFIG_DEBUG_MEMORY_INIT=y
> +# CONFIG_DEBUG_MEMORY_INIT is not set
>  # CONFIG_DEBUG_PER_CPU_MAPS is not set
> -CONFIG_HAVE_ARCH_KASAN=y
> +# CONFIG_HAVE_ARCH_KASAN is not set
>  # CONFIG_KASAN is not set
> -CONFIG_ARCH_HAS_KCOV=y
> +# CONFIG_ARCH_HAS_KCOV is not set
>  # CONFIG_KCOV is not set
>  # CONFIG_DEBUG_SHIRQ is not set
>  
> @@ -5950,7 +5951,7 @@ CONFIG_ARCH_HAS_KCOV=y
>  CONFIG_PANIC_ON_OOPS_VALUE=0
>  CONFIG_PANIC_TIMEOUT=0
>  # CONFIG_SCHED_DEBUG is not set
> -CONFIG_SCHED_INFO=y
> +# CONFIG_SCHED_INFO is not set
>  # CONFIG_SCHEDSTATS is not set
>  # CONFIG_SCHED_STACK_END_CHECK is not set
>  # CONFIG_DEBUG_TIMEKEEPING is not set
> @@ -5973,8 +5974,8 @@ CONFIG_SCHED_INFO=y
>  # CONFIG_STACKTRACE is not set
>  # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
>  # CONFIG_DEBUG_KOBJECT is not set
> -CONFIG_HAVE_DEBUG_BUGVERBOSE=y
> -CONFIG_DEBUG_BUGVERBOSE=y
> +# CONFIG_HAVE_DEBUG_BUGVERBOSE is not set
> +# CONFIG_DEBUG_BUGVERBOSE is not set
>  # CONFIG_DEBUG_LIST is not set
>  # CONFIG_DEBUG_PI_LIST is not set
>  # CONFIG_DEBUG_SG is not set
> @@ -5997,17 +5998,17 @@ CONFIG_RCU_CPU_STALL_TIMEOUT=21
>  # CONFIG_NOTIFIER_ERROR_INJECTION is not set
>  # CONFIG_FAULT_INJECTION is not set
>  # CONFIG_LATENCYTOP is not set
> -CONFIG_HAVE_FUNCTION_TRACER=y
> -CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> -CONFIG_HAVE_DYNAMIC_FTRACE=y
> -CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> -CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> +# CONFIG_HAVE_FUNCTION_TRACER is not set
> +# CONFIG_HAVE_FUNCTION_GRAPH_TRACER is not set
> +# CONFIG_HAVE_DYNAMIC_FTRACE is not set
> +# CONFIG_HAVE_FTRACE_MCOUNT_RECORD is not set
> +# CONFIG_HAVE_SYSCALL_TRACEPOINTS is not set
>  CONFIG_HAVE_C_RECORDMCOUNT=y
> -CONFIG_TRACING_SUPPORT=y
> -CONFIG_EVENT_TRACING=y
> -CONFIG_CONTEXT_SWITCH_TRACER=y
> -CONFIG_TRACING=y
> -CONFIG_FTRACE=y
> +# CONFIG_TRACING_SUPPORT is not set
> +# CONFIG_EVENT_TRACING is not set
> +# CONFIG_CONTEXT_SWITCH_TRACER is not set
> +# CONFIG_TRACING is not set
> +# CONFIG_FTRACE is not set
>  # CONFIG_DMA_API_DEBUG is not set
>  
>  #
> @@ -6040,9 +6041,9 @@ CONFIG_FTRACE=y
>  CONFIG_MEMTEST=y
>  # CONFIG_BUG_ON_DATA_CORRUPTION is not set
>  # CONFIG_SAMPLES is not set
> -CONFIG_HAVE_ARCH_KGDB=y
> +# CONFIG_HAVE_ARCH_KGDB is not set
>  # CONFIG_KGDB is not set
> -CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> +# CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL is not set
>  # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
>  # CONFIG_UBSAN is not set
>  CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> diff --git a/recipes-kernel/linux/files/armhf_debugconfig b/recipes-kernel/linux/files/armhf_debugconfig
> new file mode 100644
> index 0000000..68f525d
> --- /dev/null
> +++ b/recipes-kernel/linux/files/armhf_debugconfig
> @@ -0,0 +1,438 @@
> +#
> +# Debug Kernel Configuration
> +#
> +CONFIG_STACKTRACE_SUPPORT=y
> +CONFIG_LOCKDEP_SUPPORT=y
> +CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +CONFIG_ARCH_SUPPORTS_UPROBES=y
> +
> +#
> +# IRQ subsystem
> +#
> +CONFIG_GENERIC_IRQ_PROBE=y
> +CONFIG_IRQ_DOMAIN_DEBUG=y
> +# CONFIG_GENERIC_IRQ_DEBUGFS is not set
> +
> +#
> +# RCU Subsystem
> +#
> +# CONFIG_CGROUP_PERF is not set
> +# CONFIG_CGROUP_DEBUG is not set
> +CONFIG_KALLSYMS=y
> +# CONFIG_KALLSYMS_ALL is not set
> +# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> +CONFIG_KALLSYMS_BASE_RELATIVE=y
> +CONFIG_HAVE_PERF_EVENTS=y
> +CONFIG_PERF_USE_VMALLOC=y
> +
> +#
> +# Kernel Performance Events And Counters
> +#
> +CONFIG_PERF_EVENTS=y
> +# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> +CONFIG_SLUB_DEBUG=y
> +CONFIG_TRACEPOINTS=y
> +# CONFIG_KPROBES is not set
> +CONFIG_UPROBES=y
> +CONFIG_HAVE_KPROBES=y
> +CONFIG_HAVE_KRETPROBES=y
> +CONFIG_HAVE_OPTPROBES=y
> +CONFIG_HAVE_ARCH_TRACEHOOK=y
> +CONFIG_HAVE_DMA_API_DEBUG=y
> +CONFIG_HAVE_PERF_REGS=y
> +CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> +
> +#
> +# GCOV-based kernel profiling
> +#
> +CONFIG_BLK_DEBUG_FS=y
> +
> +#
> +# Sizes and static limits
> +#
> +CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> +
> +#
> +# Latency settings
> +#
> +CONFIG_XENO_OPT_DEBUG=y
> +CONFIG_XENO_OPT_DEBUG_COBALT=y
> +CONFIG_XENO_OPT_DEBUG_MEMORY=y
> +CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> +CONFIG_XENO_OPT_DEBUG_LOCKING=y
> +CONFIG_XENO_OPT_DEBUG_USER=y
> +CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> +CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> +CONFIG_XENO_OPT_DEBUG_LEGACY=y
> +CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> +
> +#
> +# Testing drivers
> +#
> +CONFIG_XENO_DRIVERS_HEAPCHECK=y
> +
> +#
> +# CAN drivers
> +#
> +CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> +
> +#
> +# Protocols
> +#
> +# CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG is not set
> +# CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG is not set
> +
> +#
> +# ANALOGY drivers
> +#
> +# CONFIG_XENO_DRIVERS_ANALOGY_DEBUG is not set
> +
> +#
> +# Real-time GPIO drivers
> +#
> +# CONFIG_XENO_DRIVERS_GPIO_DEBUG is not set
> +
> +#
> +# Real-time SPI master drivers
> +#
> +# CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
> +
> +#
> +# CSR SiRF atlas6/primaII/Atlas7 Specific Features
> +#
> +CONFIG_UX500_DEBUG_UART=2
> +
> +#
> +# Processor Features
> +#
> +CONFIG_DEBUG_ALIGN_RODATA=y
> +
> +#
> +# Bus support
> +#
> +# CONFIG_PCIEASPM_DEBUG is not set
> +# CONFIG_PCI_DEBUG is not set
> +
> +#
> +# RAW_PRINTK to work. Otherwise, you will get no output on raw_printk()
> +#
> +CONFIG_HW_PERF_EVENTS=y
> +
> +#
> +# Power management options
> +#
> +# CONFIG_PM_DEBUG is not set
> +
> +#
> +# CAN USB interfaces
> +#
> +# CONFIG_CAN_DEBUG_DEVICES is not set
> +CONFIG_BT_DEBUGFS=y
> +
> +#
> +# Bluetooth device drivers
> +#
> +# CONFIG_CFG80211_DEBUGFS is not set
> +# CONFIG_CFG80211_INTERNAL_REGDB is not set
> +# CONFIG_MAC80211_DEBUGFS is not set
> +# CONFIG_MAC80211_MESSAGE_TRACING is not set
> +# CONFIG_MAC80211_DEBUG_MENU is not set
> +
> +#
> +# Generic Driver Options
> +#
> +# CONFIG_DEBUG_DRIVER is not set
> +# CONFIG_DEBUG_DEVRES is not set
> +# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> +# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> +CONFIG_GENERIC_CPU_AUTOPROBE=y
> +# CONFIG_DMA_FENCE_TRACE is not set
> +
> +#
> +# RAM/ROM/Flash chip drivers
> +#
> +# CONFIG_MTD_JEDECPROBE is not set
> +
> +#
> +# SCSI Transports
> +#
> +# CONFIG_SCSI_DEBUG is not set
> +
> +#
> +# MII PHY device drivers
> +#
> +# CONFIG_ATH_DEBUG is not set
> +# CONFIG_BRCM_TRACING is not set
> +# CONFIG_RT2X00_DEBUG is not set
> +
> +#
> +# Character devices
> +#
> +# CONFIG_TRACE_SINK is not set
> +
> +#
> +# Other I2C/SMBus bus drivers
> +#
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_SPI_DEBUG is not set
> +
> +#
> +# SPI Protocol Masters
> +#
> +# CONFIG_PPS_DEBUG is not set
> +
> +#
> +# Pin controllers
> +#
> +# CONFIG_DEBUG_PINCTRL is not set
> +# CONFIG_DEBUG_GPIO is not set
> +
> +#
> +# USB GPIO expanders
> +#
> +# CONFIG_POWER_SUPPLY_DEBUG is not set
> +# CONFIG_HWMON_DEBUG_CHIP is not set
> +
> +#
> +# Watchdog Device Drivers
> +#
> +# CONFIG_BCM_KONA_WDT_DEBUG is not set
> +
> +#
> +# Sonics Silicon Backplane
> +#
> +# CONFIG_BCMA_DEBUG is not set
> +
> +#
> +# Multifunction device drivers
> +#
> +CONFIG_AB8500_DEBUG=y
> +
> +#
> +# STMicroelectronics STMPE Interface Drivers
> +#
> +# CONFIG_REGULATOR_DEBUG is not set
> +
> +#
> +# Multimedia core support
> +#
> +# CONFIG_VIDEO_ADV_DEBUG is not set
> +
> +#
> +# Webcam, TV (analog/digital) USB devices
> +#
> +# CONFIG_VIDEO_STI_HVA_DEBUGFS is not set
> +
> +#
> +# Graphics support
> +#
> +# CONFIG_DRM_DEBUG_MM is not set
> +# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
> +
> +#
> +# ACP (Audio CoProcessor) Configuration
> +#
> +CONFIG_NOUVEAU_DEBUG=5
> +CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +
> +#
> +# Sub-drivers
> +#
> +# CONFIG_DRM_TEGRA_DEBUG is not set
> +
> +#
> +# Console display driver support
> +#
> +# CONFIG_SND_DEBUG is not set
> +
> +#
> +# also be needed; see USB_STORAGE Help for more info
> +#
> +# CONFIG_USB_STORAGE_DEBUG is not set
> +
> +#
> +# Gadget/Dual-role mode requires USB Gadget support to be enabled
> +#
> +# CONFIG_USB_DWC2_DEBUG is not set
> +
> +#
> +# USB Physical Layer drivers
> +#
> +# CONFIG_USB_GADGET_DEBUG is not set
> +# CONFIG_USB_GADGET_DEBUG_FILES is not set
> +# CONFIG_USB_GADGET_DEBUG_FS is not set
> +
> +#
> +# MMC/SD/SDIO Host Controller Drivers
> +#
> +# CONFIG_MMC_DEBUG is not set
> +
> +#
> +# iptables trigger is under Netfilter config (LED target)
> +#
> +# CONFIG_EDAC_DEBUG is not set
> +# CONFIG_RTC_DEBUG is not set
> +
> +#
> +# HID Sensor RTC drivers
> +#
> +# CONFIG_DMADEVICES_DEBUG is not set
> +
> +#
> +# Clock Source drivers
> +#
> +CONFIG_TIMER_PROBE=y
> +
> +#
> +# Extcon Device Drivers
> +#
> +# CONFIG_OMAP_GPMC_DEBUG is not set
> +
> +#
> +# File systems
> +#
> +# CONFIG_EXT4_DEBUG is not set
> +# CONFIG_JBD2_DEBUG is not set
> +
> +#
> +# DOS/FAT/NT Filesystems
> +#
> +# CONFIG_NTFS_DEBUG is not set
> +
> +#
> +# Pseudo filesystems
> +#
> +# CONFIG_SUNRPC_DEBUG is not set
> +
> +#
> +# printk and dmesg options
> +#
> +# CONFIG_DYNAMIC_DEBUG is not set
> +
> +#
> +# Compile-time checks and compiler options
> +#
> +# CONFIG_DEBUG_INFO is not set
> +CONFIG_DEBUG_FS=y
> +# CONFIG_DEBUG_SECTION_MISMATCH is not set
> +# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> +CONFIG_MAGIC_SYSRQ_SERIAL=y
> +CONFIG_IPIPE_DEBUG=y
> +CONFIG_IPIPE_DEBUG_CONTEXT=y
> +CONFIG_IPIPE_DEBUG_INTERNAL=y
> +CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> +# CONFIG_IPIPE_TRACE is not set
> +CONFIG_DEBUG_KERNEL=y
> +
> +#
> +# Memory Debugging
> +#
> +# CONFIG_PAGE_EXTENSION is not set
> +# CONFIG_DEBUG_PAGEALLOC is not set
> +# CONFIG_DEBUG_PAGE_REF is not set
> +# CONFIG_DEBUG_RODATA_TEST is not set
> +# CONFIG_DEBUG_OBJECTS is not set
> +# CONFIG_SLUB_DEBUG_ON is not set
> +CONFIG_HAVE_DEBUG_KMEMLEAK=y
> +# CONFIG_DEBUG_KMEMLEAK is not set
> +# CONFIG_DEBUG_STACK_USAGE is not set
> +# CONFIG_DEBUG_VM is not set
> +CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> +# CONFIG_DEBUG_VIRTUAL is not set
> +# CONFIG_DEBUG_MEMORY_INIT is not set
> +# CONFIG_DEBUG_PER_CPU_MAPS is not set
> +# CONFIG_DEBUG_HIGHMEM is not set
> +# CONFIG_DEBUG_SHIRQ is not set
> +
> +#
> +# Debug Lockups and Hangs
> +#
> +CONFIG_SCHED_DEBUG=y
> +# CONFIG_SCHED_INFO is not set
> +# CONFIG_DEBUG_TIMEKEEPING is not set
> +
> +#
> +# Lock Debugging (spinlocks, mutexes, etc...)
> +#
> +# CONFIG_DEBUG_RT_MUTEXES is not set
> +# CONFIG_DEBUG_SPINLOCK is not set
> +# CONFIG_DEBUG_MUTEXES is not set
> +# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> +# CONFIG_DEBUG_LOCK_ALLOC is not set
> +# CONFIG_PROVE_LOCKING is not set
> +# CONFIG_DEBUG_ATOMIC_SLEEP is not set
> +# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> +CONFIG_STACKTRACE=y
> +# CONFIG_DEBUG_KOBJECT is not set
> +CONFIG_DEBUG_BUGVERBOSE=y
> +# CONFIG_DEBUG_LIST is not set
> +# CONFIG_DEBUG_PI_LIST is not set
> +# CONFIG_DEBUG_SG is not set
> +# CONFIG_DEBUG_NOTIFIERS is not set
> +# CONFIG_DEBUG_CREDENTIALS is not set
> +
> +#
> +# RCU Debugging
> +#
> +# CONFIG_PROVE_RCU is not set
> +# CONFIG_RCU_PERF_TEST is not set
> +CONFIG_RCU_TRACE=y
> +# CONFIG_RCU_EQS_DEBUG is not set
> +# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> +# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> +CONFIG_NOP_TRACER=y
> +CONFIG_HAVE_FUNCTION_TRACER=y
> +CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> +CONFIG_HAVE_DYNAMIC_FTRACE=y
> +CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> +CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> +CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> +CONFIG_TRACE_CLOCK=y
> +CONFIG_RING_BUFFER=y
> +CONFIG_EVENT_TRACING=y
> +CONFIG_CONTEXT_SWITCH_TRACER=y
> +CONFIG_TRACING=y
> +CONFIG_TRACING_SUPPORT=y
> +CONFIG_FTRACE=y
> +# CONFIG_FUNCTION_TRACER is not set
> +# CONFIG_IRQSOFF_TRACER is not set
> +# CONFIG_SCHED_TRACER is not set
> +# CONFIG_HWLAT_TRACER is not set
> +# CONFIG_ENABLE_DEFAULT_TRACERS is not set
> +# CONFIG_FTRACE_SYSCALLS is not set
> +# CONFIG_TRACER_SNAPSHOT is not set
> +CONFIG_BRANCH_PROFILE_NONE=y
> +# CONFIG_STACK_TRACER is not set
> +# CONFIG_BLK_DEV_IO_TRACE is not set
> +CONFIG_UPROBE_EVENTS=y
> +CONFIG_PROBE_EVENTS=y
> +# CONFIG_TRACEPOINT_BENCHMARK is not set
> +# CONFIG_RING_BUFFER_BENCHMARK is not set
> +# CONFIG_RING_BUFFER_STARTUP_TEST is not set
> +# CONFIG_TRACE_EVAL_MAP_FILE is not set
> +CONFIG_TRACING_EVENTS_GPIO=y
> +# CONFIG_DMA_API_DEBUG is not set
> +
> +#
> +# Runtime Testing
> +#
> +# CONFIG_BACKTRACE_SELF_TEST is not set
> +CONFIG_HAVE_ARCH_KGDB=y
> +# CONFIG_KGDB is not set
> +# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
> +# CONFIG_UBSAN is not set
> +CONFIG_ARM_UNWIND=y
> +# CONFIG_DEBUG_USER is not set
> +# CONFIG_DEBUG_LL is not set
> +CONFIG_DEBUG_IMX_UART_PORT=1
> +CONFIG_DEBUG_VF_UART_PORT=1
> +CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
> +# CONFIG_DEBUG_UART_8250 is not set
> +
> +#
> +# Library routines
> +#
> diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
> index dee6f5e..97576de 100644
> --- a/recipes-kernel/linux/files/armhf_defconfig
> +++ b/recipes-kernel/linux/files/armhf_defconfig
> @@ -11,9 +11,9 @@ CONFIG_MIGHT_HAVE_PCI=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
>  CONFIG_HAVE_PROC_CPU=y
>  CONFIG_NO_IOPORT_MAP=y
> -CONFIG_STACKTRACE_SUPPORT=y
> -CONFIG_LOCKDEP_SUPPORT=y
> -CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> +# CONFIG_STACKTRACE_SUPPORT is not set
> +# CONFIG_LOCKDEP_SUPPORT is not set
> +# CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
>  CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>  CONFIG_ARCH_HAS_BANDGAP=y
>  CONFIG_FIX_EARLYCON_MEM=y
> @@ -21,7 +21,7 @@ CONFIG_GENERIC_HWEIGHT=y
>  CONFIG_GENERIC_CALIBRATE_DELAY=y
>  CONFIG_ZONE_DMA=y
>  CONFIG_NEED_DMA_MAP_STATE=y
> -CONFIG_ARCH_SUPPORTS_UPROBES=y
> +# CONFIG_ARCH_SUPPORTS_UPROBES is not set
>  CONFIG_VECTORS_BASE=0xffff0000
>  CONFIG_ARM_PATCH_PHYS_VIRT=y
>  CONFIG_GENERIC_BUG=y
> @@ -62,7 +62,7 @@ CONFIG_HAVE_ARCH_AUDITSYSCALL=y
>  #
>  # IRQ subsystem
>  #
> -CONFIG_GENERIC_IRQ_PROBE=y
> +# CONFIG_GENERIC_IRQ_PROBE is not set
>  CONFIG_GENERIC_IRQ_SHOW=y
>  CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
>  CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> @@ -73,7 +73,7 @@ CONFIG_IRQ_DOMAIN_HIERARCHY=y
>  CONFIG_GENERIC_MSI_IRQ=y
>  CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
>  CONFIG_HANDLE_DOMAIN_IRQ=y
> -CONFIG_IRQ_DOMAIN_DEBUG=y
> +# CONFIG_IRQ_DOMAIN_DEBUG is not set
>  CONFIG_IRQ_FORCED_THREADING=y
>  CONFIG_SPARSE_IRQ=y
>  # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> @@ -156,10 +156,10 @@ CONFIG_MULTIUSER=y
>  CONFIG_SYSFS_SYSCALL=y
>  # CONFIG_SYSCTL_SYSCALL is not set
>  CONFIG_POSIX_TIMERS=y
> -CONFIG_KALLSYMS=y
> +# CONFIG_KALLSYMS is not set
>  # CONFIG_KALLSYMS_ALL is not set
>  # CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
> -CONFIG_KALLSYMS_BASE_RELATIVE=y
> +# CONFIG_KALLSYMS_BASE_RELATIVE is not set
>  CONFIG_PRINTK=y
>  CONFIG_PRINTK_NMI=y
>  CONFIG_RAW_PRINTK=y
> @@ -180,17 +180,17 @@ CONFIG_ADVISE_SYSCALLS=y
>  CONFIG_PCI_QUIRKS=y
>  CONFIG_MEMBARRIER=y
>  CONFIG_EMBEDDED=y
> -CONFIG_HAVE_PERF_EVENTS=y
> -CONFIG_PERF_USE_VMALLOC=y
> +# CONFIG_HAVE_PERF_EVENTS is not set
> +# CONFIG_PERF_USE_VMALLOC is not set
>  # CONFIG_PC104 is not set
>  
>  #
>  # Kernel Performance Events And Counters
>  #
> -CONFIG_PERF_EVENTS=y
> +# CONFIG_PERF_EVENTS is not set
>  # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
>  CONFIG_VM_EVENT_COUNTERS=y
> -CONFIG_SLUB_DEBUG=y
> +# CONFIG_SLUB_DEBUG is not set
>  CONFIG_COMPAT_BRK=y
>  # CONFIG_SLAB is not set
>  CONFIG_SLUB=y
> @@ -201,31 +201,31 @@ CONFIG_SLAB_MERGE_DEFAULT=y
>  CONFIG_SLUB_CPU_PARTIAL=y
>  # CONFIG_SYSTEM_DATA_VERIFICATION is not set
>  # CONFIG_PROFILING is not set
> -CONFIG_TRACEPOINTS=y
> +# CONFIG_TRACEPOINTS is not set
>  CONFIG_CRASH_CORE=y
>  CONFIG_KEXEC_CORE=y
>  CONFIG_HAVE_OPROFILE=y
>  # CONFIG_KPROBES is not set
>  # CONFIG_JUMP_LABEL is not set
> -CONFIG_UPROBES=y
> +# CONFIG_UPROBES is not set
>  # CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
>  CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
>  CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> -CONFIG_HAVE_KPROBES=y
> -CONFIG_HAVE_KRETPROBES=y
> -CONFIG_HAVE_OPTPROBES=y
> +# CONFIG_HAVE_KPROBES is not set
> +# CONFIG_HAVE_KRETPROBES is not set
> +# CONFIG_HAVE_OPTPROBES is not set
>  CONFIG_HAVE_NMI=y
> -CONFIG_HAVE_ARCH_TRACEHOOK=y
> +# CONFIG_HAVE_ARCH_TRACEHOOK is not set
>  CONFIG_HAVE_DMA_CONTIGUOUS=y
>  CONFIG_GENERIC_SMP_IDLE_THREAD=y
>  CONFIG_GENERIC_IDLE_POLL_SETUP=y
>  CONFIG_ARCH_HAS_SET_MEMORY=y
>  CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
>  CONFIG_HAVE_CLK=y
> -CONFIG_HAVE_DMA_API_DEBUG=y
> +# CONFIG_HAVE_DMA_API_DEBUG is not set
>  CONFIG_HAVE_HW_BREAKPOINT=y
> -CONFIG_HAVE_PERF_REGS=y
> -CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> +# CONFIG_HAVE_PERF_REGS is not set
> +# CONFIG_HAVE_PERF_USER_STACK_DUMP is not set
>  CONFIG_HAVE_ARCH_JUMP_LABEL=y
>  CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
>  CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> @@ -291,7 +291,7 @@ CONFIG_BLK_DEV_BSG=y
>  # CONFIG_BLK_DEV_ZONED is not set
>  CONFIG_BLK_CMDLINE_PARSER=y
>  # CONFIG_BLK_WBT is not set
> -CONFIG_BLK_DEBUG_FS=y
> +# CONFIG_BLK_DEBUG_FS is not set
>  # CONFIG_BLK_SED_OPAL is not set
>  
>  #
> @@ -377,7 +377,7 @@ CONFIG_XENO_OPT_SYS_HEAPSZ=4096
>  CONFIG_XENO_OPT_PRIVATE_HEAPSZ=256
>  CONFIG_XENO_OPT_SHARED_HEAPSZ=256
>  CONFIG_XENO_OPT_NRTIMERS=256
> -CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
> +# CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ is not set
>  
>  #
>  # Latency settings
> @@ -385,16 +385,16 @@ CONFIG_XENO_OPT_DEBUG_TRACE_LOGSZ=16
>  CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
>  CONFIG_XENO_OPT_TIMING_KSCHEDLAT=0
>  CONFIG_XENO_OPT_TIMING_IRQLAT=0
> -CONFIG_XENO_OPT_DEBUG=y
> -CONFIG_XENO_OPT_DEBUG_COBALT=y
> -CONFIG_XENO_OPT_DEBUG_MEMORY=y
> -CONFIG_XENO_OPT_DEBUG_CONTEXT=y
> -CONFIG_XENO_OPT_DEBUG_LOCKING=y
> -CONFIG_XENO_OPT_DEBUG_USER=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED=y
> -CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP=y
> -CONFIG_XENO_OPT_DEBUG_LEGACY=y
> -CONFIG_XENO_OPT_DEBUG_TRACE_RELAX=y
> +# CONFIG_XENO_OPT_DEBUG is not set
> +# CONFIG_XENO_OPT_DEBUG_COBALT is not set
> +# CONFIG_XENO_OPT_DEBUG_MEMORY is not set
> +# CONFIG_XENO_OPT_DEBUG_CONTEXT is not set
> +# CONFIG_XENO_OPT_DEBUG_LOCKING is not set
> +# CONFIG_XENO_OPT_DEBUG_USER is not set
> +# CONFIG_XENO_OPT_DEBUG_MUTEX_RELAXED is not set
> +# CONFIG_XENO_OPT_DEBUG_MUTEX_SLEEP is not set
> +# CONFIG_XENO_OPT_DEBUG_LEGACY is not set
> +# CONFIG_XENO_OPT_DEBUG_TRACE_RELAX is not set
>  CONFIG_XENO_OPT_WATCHDOG=y
>  CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
>  # CONFIG_XENO_TODO is not set
> @@ -419,14 +419,14 @@ CONFIG_XENO_DRIVERS_IMX_UART=m
>  #
>  CONFIG_XENO_DRIVERS_TIMERBENCH=y
>  CONFIG_XENO_DRIVERS_SWITCHTEST=y
> -CONFIG_XENO_DRIVERS_HEAPCHECK=y
> +# CONFIG_XENO_DRIVERS_HEAPCHECK is not set
>  CONFIG_XENO_DRIVERS_RTDMTEST=m
>  
>  #
>  # CAN drivers
>  #
>  CONFIG_XENO_DRIVERS_CAN=m
> -CONFIG_XENO_DRIVERS_CAN_DEBUG=y
> +# CONFIG_XENO_DRIVERS_CAN_DEBUG is not set
>  # CONFIG_XENO_DRIVERS_CAN_LOOPBACK is not set
>  CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=1024
>  CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=4
> @@ -878,7 +878,7 @@ CONFIG_MACH_MOP500=y
>  CONFIG_MACH_HREFV60=y
>  CONFIG_MACH_SNOWBALL=y
>  CONFIG_UX500_AUTO_PLATFORM=y
> -CONFIG_UX500_DEBUG_UART=2
> +# CONFIG_UX500_DEBUG_UART is not set
>  CONFIG_ARCH_VEXPRESS=y
>  CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA=y
>  # CONFIG_ARCH_VEXPRESS_DCSCB is not set
> @@ -951,7 +951,7 @@ CONFIG_ARM_L1_CACHE_SHIFT=6
>  CONFIG_ARM_DMA_MEM_BUFFERABLE=y
>  CONFIG_ARM_HEAVY_MB=y
>  CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
> -CONFIG_DEBUG_ALIGN_RODATA=y
> +# CONFIG_DEBUG_ALIGN_RODATA is not set
>  CONFIG_IWMMXT=y
>  CONFIG_MULTI_IRQ_HANDLER=y
>  CONFIG_PJ4B_ERRATA_4742=y
> @@ -1110,7 +1110,7 @@ CONFIG_HAVE_ARCH_PFN_VALID=y
>  CONFIG_HIGHMEM=y
>  CONFIG_HIGHPTE=y
>  CONFIG_CPU_SW_DOMAIN_PAN=y
> -CONFIG_HW_PERF_EVENTS=y
> +# CONFIG_HW_PERF_EVENTS is not set
>  CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
>  CONFIG_FLATMEM=y
>  CONFIG_FLAT_NODE_MEM_MAP=y
> @@ -1413,7 +1413,7 @@ CONFIG_BT_HS=y
>  CONFIG_BT_LE=y
>  # CONFIG_BT_LEDS is not set
>  # CONFIG_BT_SELFTEST is not set
> -CONFIG_BT_DEBUGFS=y
> +# CONFIG_BT_DEBUGFS is not set
>  
>  #
>  # Bluetooth device drivers
> @@ -1501,7 +1501,7 @@ CONFIG_DEV_COREDUMP=y
>  # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
>  # CONFIG_SYS_HYPERVISOR is not set
>  # CONFIG_GENERIC_CPU_DEVICES is not set
> -CONFIG_GENERIC_CPU_AUTOPROBE=y
> +# CONFIG_GENERIC_CPU_AUTOPROBE is not set
>  CONFIG_SOC_BUS=y
>  CONFIG_REGMAP=y
>  CONFIG_REGMAP_AC97=m
> @@ -3697,7 +3697,7 @@ CONFIG_MFD_SEC_CORE=y
>  CONFIG_ABX500_CORE=y
>  # CONFIG_AB3100_CORE is not set
>  CONFIG_AB8500_CORE=y
> -CONFIG_AB8500_DEBUG=y
> +# CONFIG_AB8500_DEBUG is not set
>  CONFIG_AB8500_GPADC=y
>  CONFIG_MFD_DB8500_PRCMU=y
>  CONFIG_MFD_STMPE=y
> @@ -4201,8 +4201,8 @@ CONFIG_DRM_VM=y
>  #
>  CONFIG_DRM_NOUVEAU=m
>  CONFIG_NOUVEAU_PLATFORM_DRIVER=y
> -CONFIG_NOUVEAU_DEBUG=5
> -CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> +# CONFIG_NOUVEAU_DEBUG is not set
> +# CONFIG_NOUVEAU_DEBUG_DEFAULT is not set
>  CONFIG_DRM_NOUVEAU_BACKLIGHT=y
>  # CONFIG_DRM_VGEM is not set
>  CONFIG_DRM_EXYNOS=m
> @@ -5828,7 +5828,7 @@ CONFIG_CLK_UNIPHIER=y
>  # Clock Source drivers
>  #
>  CONFIG_TIMER_OF=y
> -CONFIG_TIMER_PROBE=y
> +# CONFIG_TIMER_PROBE is not set
>  CONFIG_CLKSRC_MMIO=y
>  CONFIG_BCM2835_TIMER=y
>  CONFIG_BCM_KONA_TIMER=y
> @@ -6821,20 +6821,20 @@ CONFIG_FRAME_WARN=1024
>  # CONFIG_READABLE_ASM is not set
>  # CONFIG_UNUSED_SYMBOLS is not set
>  # CONFIG_PAGE_OWNER is not set
> -CONFIG_DEBUG_FS=y
> +# CONFIG_DEBUG_FS is not set
>  # CONFIG_HEADERS_CHECK is not set
>  # CONFIG_DEBUG_SECTION_MISMATCH is not set
>  CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>  # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> -CONFIG_MAGIC_SYSRQ_SERIAL=y
> -CONFIG_IPIPE_DEBUG=y
> -CONFIG_IPIPE_DEBUG_CONTEXT=y
> -CONFIG_IPIPE_DEBUG_INTERNAL=y
> -CONFIG_HAVE_IPIPE_TRACER_SUPPORT=y
> +# CONFIG_MAGIC_SYSRQ is not set
> +# CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE is not set
> +# CONFIG_MAGIC_SYSRQ_SERIAL is not set
> +# CONFIG_IPIPE_DEBUG is not set
> +# CONFIG_IPIPE_DEBUG_CONTEXT is not set
> +# CONFIG_IPIPE_DEBUG_INTERNAL is not set
> +# CONFIG_HAVE_IPIPE_TRACER_SUPPORT is not set
>  # CONFIG_IPIPE_TRACE is not set
> -CONFIG_DEBUG_KERNEL=y
> +# CONFIG_DEBUG_KERNEL is not set
>  
>  #
>  # Memory Debugging
> @@ -6847,11 +6847,11 @@ CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_OBJECTS is not set
>  # CONFIG_SLUB_DEBUG_ON is not set
>  # CONFIG_SLUB_STATS is not set
> -CONFIG_HAVE_DEBUG_KMEMLEAK=y
> +# CONFIG_HAVE_DEBUG_KMEMLEAK is not set
>  # CONFIG_DEBUG_KMEMLEAK is not set
>  # CONFIG_DEBUG_STACK_USAGE is not set
>  # CONFIG_DEBUG_VM is not set
> -CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> +# CONFIG_ARCH_HAS_DEBUG_VIRTUAL is not set
>  # CONFIG_DEBUG_VIRTUAL is not set
>  # CONFIG_DEBUG_MEMORY_INIT is not set
>  # CONFIG_DEBUG_PER_CPU_MAPS is not set
> @@ -6867,7 +6867,7 @@ CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
>  # CONFIG_PANIC_ON_OOPS is not set
>  CONFIG_PANIC_ON_OOPS_VALUE=0
>  CONFIG_PANIC_TIMEOUT=0
> -CONFIG_SCHED_DEBUG=y
> +# CONFIG_SCHED_DEBUG is not set
>  # CONFIG_SCHED_INFO is not set
>  # CONFIG_SCHEDSTATS is not set
>  # CONFIG_SCHED_STACK_END_CHECK is not set
> @@ -6887,10 +6887,10 @@ CONFIG_SCHED_DEBUG=y
>  # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
>  # CONFIG_LOCK_TORTURE_TEST is not set
>  # CONFIG_WW_MUTEX_SELFTEST is not set
> -CONFIG_STACKTRACE=y
> +# CONFIG_STACKTRACE is not set
>  # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
>  # CONFIG_DEBUG_KOBJECT is not set
> -CONFIG_DEBUG_BUGVERBOSE=y
> +# CONFIG_DEBUG_BUGVERBOSE is not set
>  # CONFIG_DEBUG_LIST is not set
>  # CONFIG_DEBUG_PI_LIST is not set
>  # CONFIG_DEBUG_SG is not set
> @@ -6905,7 +6905,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
>  # CONFIG_RCU_PERF_TEST is not set
>  # CONFIG_RCU_TORTURE_TEST is not set
>  CONFIG_RCU_CPU_STALL_TIMEOUT=21
> -CONFIG_RCU_TRACE=y
> +# CONFIG_RCU_TRACE is not set
>  # CONFIG_RCU_EQS_DEBUG is not set
>  # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
>  # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> @@ -6913,21 +6913,21 @@ CONFIG_RCU_TRACE=y
>  # CONFIG_NOTIFIER_ERROR_INJECTION is not set
>  # CONFIG_FAULT_INJECTION is not set
>  # CONFIG_LATENCYTOP is not set
> -CONFIG_NOP_TRACER=y
> -CONFIG_HAVE_FUNCTION_TRACER=y
> -CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> -CONFIG_HAVE_DYNAMIC_FTRACE=y
> -CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> -CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> -CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> +# CONFIG_NOP_TRACER is not set
> +# CONFIG_HAVE_FUNCTION_TRACER is not set
> +# CONFIG_HAVE_FUNCTION_GRAPH_TRACER is not set
> +# CONFIG_HAVE_DYNAMIC_FTRACE is not set
> +# CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS is not set
> +# CONFIG_HAVE_FTRACE_MCOUNT_RECORD is not set
> +# CONFIG_HAVE_SYSCALL_TRACEPOINTS is not set
>  CONFIG_HAVE_C_RECORDMCOUNT=y
> -CONFIG_TRACE_CLOCK=y
> -CONFIG_RING_BUFFER=y
> -CONFIG_EVENT_TRACING=y
> -CONFIG_CONTEXT_SWITCH_TRACER=y
> -CONFIG_TRACING=y
> -CONFIG_TRACING_SUPPORT=y
> -CONFIG_FTRACE=y
> +# CONFIG_TRACE_CLOCK is not set
> +# CONFIG_RING_BUFFER is not set
> +# CONFIG_EVENT_TRACING is not set
> +# CONFIG_CONTEXT_SWITCH_TRACER is not set
> +# CONFIG_TRACING is not set
> +# CONFIG_TRACING_SUPPORT is not set
> +# CONFIG_FTRACE is not set
>  # CONFIG_FUNCTION_TRACER is not set
>  # CONFIG_IRQSOFF_TRACER is not set
>  # CONFIG_SCHED_TRACER is not set
> @@ -6935,18 +6935,18 @@ CONFIG_FTRACE=y
>  # CONFIG_ENABLE_DEFAULT_TRACERS is not set
>  # CONFIG_FTRACE_SYSCALLS is not set
>  # CONFIG_TRACER_SNAPSHOT is not set
> -CONFIG_BRANCH_PROFILE_NONE=y
> +# CONFIG_BRANCH_PROFILE_NONE is not set
>  # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
>  # CONFIG_PROFILE_ALL_BRANCHES is not set
>  # CONFIG_STACK_TRACER is not set
>  # CONFIG_BLK_DEV_IO_TRACE is not set
> -CONFIG_UPROBE_EVENTS=y
> -CONFIG_PROBE_EVENTS=y
> +# CONFIG_UPROBE_EVENTS is not set
> +# CONFIG_PROBE_EVENTS is not set
>  # CONFIG_TRACEPOINT_BENCHMARK is not set
>  # CONFIG_RING_BUFFER_BENCHMARK is not set
>  # CONFIG_RING_BUFFER_STARTUP_TEST is not set
>  # CONFIG_TRACE_EVAL_MAP_FILE is not set
> -CONFIG_TRACING_EVENTS_GPIO=y
> +# CONFIG_TRACING_EVENTS_GPIO is not set
>  # CONFIG_DMA_API_DEBUG is not set
>  
>  #
> @@ -6979,19 +6979,19 @@ CONFIG_TRACING_EVENTS_GPIO=y
>  # CONFIG_MEMTEST is not set
>  # CONFIG_BUG_ON_DATA_CORRUPTION is not set
>  # CONFIG_SAMPLES is not set
> -CONFIG_HAVE_ARCH_KGDB=y
> +# CONFIG_HAVE_ARCH_KGDB is not set
>  # CONFIG_KGDB is not set
>  # CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
>  # CONFIG_UBSAN is not set
>  CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
>  # CONFIG_STRICT_DEVMEM is not set
>  # CONFIG_ARM_PTDUMP is not set
> -CONFIG_ARM_UNWIND=y
> +# CONFIG_ARM_UNWIND is not set
>  # CONFIG_DEBUG_USER is not set
>  # CONFIG_DEBUG_LL is not set
> -CONFIG_DEBUG_IMX_UART_PORT=1
> -CONFIG_DEBUG_VF_UART_PORT=1
> -CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
> +# CONFIG_DEBUG_IMX_UART_PORT is not set
> +# CONFIG_DEBUG_VF_UART_PORT is not set
> +# CONFIG_DEBUG_LL_INCLUDE is not set
>  # CONFIG_DEBUG_UART_8250 is not set
>  CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
>  # CONFIG_PID_IN_CONTEXTIDR is not set
> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
> deleted file mode 100644
> index a57463b..0000000
> --- a/recipes-kernel/linux/files/common_nodbg.cfg
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -# CONFIG_IPIPE_DEBUG is not set
> -# CONFIG_XENO_OPT_DEBUG is not set
> -# CONFIG_DEBUG_VM is not set
> -# CONFIG_DEBUG_LIST is not set
> -# CONFIG_BUG_ON_DATA_CORRUPTION is not set
> -# CONFIG_FTRACE is not set
> -# CONFIG_PROVE_LOCKING is not set
> -# CONFIG_DEBUG_LOCK_ALLOC is not set
> -# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 8c7df40..501c212 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -16,9 +16,10 @@ FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
>  
>  XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
>  KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
> +KERNEL_DEBUGCONFIG = "${DISTRO_ARCH}_debugconfig"

Why _debugconfig? Isar only picks up .cfg config snippets automatically
and adds them to the base config.

And what makes the debug settings arch-specific? Do you have some examples?

Jan

>  XENOMAI_DEBUG ?= "0"
>  
>  SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
> -SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
> +SRC_URI += "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
>  
>  S = "${WORKDIR}/git"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
