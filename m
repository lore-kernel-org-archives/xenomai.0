Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E72951A4
	for <xenomai@lists.linux.dev>; Fri, 23 May 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009568; cv=fail; b=FW1EUvtH6QPt+aVDpwjkHbUDNdiDHrDXTKHkv11M673FS/9RT0qih/DIWebAS7DW94U59kjZtYAo2RbxJdhZ7b7hzpQnFz2LBXRJpOUvYw/EqPa3oOu1DagNbZZv+zVybMZH4T+pmgIkjxpmD/yV6TX1/V2y0fTXCQjvZWMRsxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009568; c=relaxed/simple;
	bh=P4NWEU8ZtMX5BJ4JvJZf3pGvpxO7uGF16J3vBvt3U4A=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=g8IAeebiD1ai4sJFfoimyxnijp+2iWBvXaaChsa2KCqDbB2UsZUkA+1aW6vKDMHHt/NMozcSXRTSyNTecU88f45ZbqOSRAbnB6G6jzGBZwggaUo0i63WkdCbZryx+ZEy9TfGxVff9zRXX9SQ5Hb9R2hCGz7n4nTY+FSmoazlkyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gQEOUvPe; arc=fail smtp.client-ip=40.107.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gQEOUvPe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa8XvQhoh7Ep9Y59JsPYvQ/ucX76Z8w5dDs5koW5T1hhsid9VLrNu+DRlx8wrU+CBLH0LAhaqM2Svmwh5rDwoboMZsk2xoWQmyPpLP+mbDO20YEStj5tAtvlyKWiMECoB5TLoMrJ3cZ+/4MI6Tm734SuPINlMoFb88srB+i9qaNvFOL5iw5xp/8w1BCs937zX21FC6nWRhq/6mQSOQ/aFM4hGxYQb7aSqmkYl5/tsPkLiz/1x29XTdwFggRB1tYB4oSCSxsSJHZwTqDzuwRrm94DfZ/7ZrxOV8xaNUNNiNNFw8Qn4kSt+MspXSz3iVj6ha0ETYDkxpRxAwdJoimwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGpcOHyMgKxzWmWXk/crOENzNtHkSI0tlWt4wtsyfkU=;
 b=NmS6H2jvyHB/3wpPmKxpeYhCjkb6/V0+xIsIMBqRta50boZWe667Ct4nq+ERssi+N5cv1bWxKIYznStPHYwhJ+r5AuBNjOqttBb1t6GExAhHzusNv4bvPZ327ZvMLRyUKcFpUbK4p307bLWr3y7GvBQaqQYC6Za/aRgXYavcq/FXT2fue7A3apzZc+XQXZSC9iM7S+7S8ecpzBRbwMewHmFdEfaK9VVT7y5C8H/qOFDqrIPBMVNHBX2W5RiIGvN4e6048v6Q2ylhss7HRSU72jfSekPAOV6+W+JflwU+olG6mUoKPj0bSt4mHBBL6U1+ywISfeoDKF/J+UI5Bhp1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGpcOHyMgKxzWmWXk/crOENzNtHkSI0tlWt4wtsyfkU=;
 b=gQEOUvPe5L8gLOVKr1RAyJy4H10hoJq9LBiuA5PRH1TG/UHTxRAzSQNKSMr2A1wgpyIufNLzk0WYLiFyRP2xcsufzuXwYyV+oybYIs/r7NHnvknEzPCscaOuoZobHIdu8y81HrgTCYXmzbxAqLUgebKUsZFmAyAKp2lAtmxgMhHs3Ln+wBNvxXaBej8g6efD6UfqZQAyi3xiIlPdQMffMNiEabKyw2F00+TNvr4TQev/aHZ0J4NRDLBqcdpOglPPDZZ2XFoN5UxP/ywwALhFE9MdVkde6N1WM6luTa/PcgkEFc+XjVw1d/NvUKlaR8t/dfQU+0w23VYXyEFRQnGlYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 14:12:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 14:12:42 +0000
Message-ID: <5c70fa6a-125c-45a9-9f19-b3fc7c996fae@siemens.com>
Date: Fri, 23 May 2025 16:12:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Remove support for Xenomai 3.0.x and kernel
 4.4
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d49df50-180a-4e19-5770-08dd9a03e208
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnJFU2NoKzIxRFJkNVRVcEpGRVY0UGZWR1c3cEYvZzRCNnp5SWc1RUNmR0M3?=
 =?utf-8?B?WkpxMU5YTVpXbG0ybmFQbmhULy9hK1NpQXF0VGc3REJvcElrQlVCcE03LzU1?=
 =?utf-8?B?SWt3UEF3aGt2VUY1STdXNG0xUDB4Z3JHdVR2cGhtK2gvUTNGUHRHdVAwRGFj?=
 =?utf-8?B?b0ZSZ3hkUUpUSTgvQ0gyZ0ZzejMvSVFuWHZaUnlyTGRRV1BiOUZBNTNJbWlB?=
 =?utf-8?B?Um1QWW8yYS9OQzZ0cmJIcy9qSFBSUGRCR1pQcHVMUldwTXVrRysxSGJlUXBm?=
 =?utf-8?B?RDRLak5FMUwyOFhSVXpuWGJEaGY0NVNMdHlXdVZmWW1JU2hzcVFGVFQ2ZERq?=
 =?utf-8?B?Mlk0R2NpM0IxSmRpamJZWm9XUnZiUmthamxMbXNNQ2xabS94Z21yZ3l2R1pl?=
 =?utf-8?B?UFhXRUFQYjF1SUY4aDY0c0xRbXhRcEp0QUxqc1ZLTGhnOUIxT3Z5VTZLUHhK?=
 =?utf-8?B?Tk5sZjVRRHlUU3NZTktHTjFzRnZ5YXdnczVlckNiYitCeHlNeHQyTjRObHdy?=
 =?utf-8?B?M3pEbHVPdmFoUXdvQThTdjFGNitRTlhyaHRZaSt3bXBNbGRwVlVxOCtHVnJ1?=
 =?utf-8?B?Tis1aUJWYzlIK21OaGx6OWFuM3ZhcnRtcG5Bd2l1YlRmZ1A5a2d0cjFtVlFZ?=
 =?utf-8?B?TmUzUjFMMnB4Z0NFVk5rTWJCRzZ5UVNzRnZ2K2JNQ0lJK2dHbTg5MU1tYlRr?=
 =?utf-8?B?RTZIOTh5VDFrU3hLdWhLNlpOdEt4ZDY0dkplOHNDaThKa3hiTFE5aUloZEdn?=
 =?utf-8?B?RkhGVXp6b3lwa0JTWm5mYUJMYU9mQnNSZTNvaThRMll3VWxGdnBYMjVlYkdM?=
 =?utf-8?B?L2tmeEJYazhpRDd6SUFjRzFRMEdXWE5JZ2txT2REbjc5SEZhTSt3dXhmQlpm?=
 =?utf-8?B?bEZCbmRVb2RLZzg3TklJRDZraFFKOExBaVZmTytBVnNwT3VUTXZMSlN2dTVs?=
 =?utf-8?B?OEZWb3lBRGl6QjVUaFlqTVRLbmFaTzF4NkNXNW1kZ0o3M2dQTHRXV1RBUTMz?=
 =?utf-8?B?S1hwQUZYeDlpMUM5V215TU13ZGc1Tjl2RUxYM3ZCWnBBM2xNYkpybXNxYU94?=
 =?utf-8?B?cmZZczY1RWVlcksyMmpNNCttSFpMYjI2QU93bDNkVDFxNEdoK2RuNHcwcEpB?=
 =?utf-8?B?dngrMWdqZkpvazRRRHFwUldlTjkwSWxVN2xpUUpydlpkWktZWWUrZHNTU1NV?=
 =?utf-8?B?N0NTakdUWDMyT0FIOXN3SnR4TVVjZGdiS3gyYmdJYmhhY3VMbUg2Y0VxNHA5?=
 =?utf-8?B?QTM3a040Q0RoSjE5RkVmem5iN2IxNis0ZVhFQzMzMDl0U1M2amNBM0hqWGll?=
 =?utf-8?B?ZHlrRytJZUdSZ3F1M2RjUG14cFY0Q1J2S3FDVm1kcThiQ2ZGUXBHMmZhZmdD?=
 =?utf-8?B?U21INkF0aVpGQy9pVVJCK0lkWjI1bHZ0anlOeEhWRVB5VWovTFliY2F3K3JY?=
 =?utf-8?B?S2pXaVpscDJ1b0ZESFp0a0ZQNjdja01HRTdkUk5TMUpmUVk5Qm5nZXBZUGRW?=
 =?utf-8?B?VytwL0IvdEZRRDU1dXE4OEg4WVVwSVpLZjZnVVdrY213SUw1Y2E4UGxiUUl1?=
 =?utf-8?B?ZTM3Nk9EZGpBaUduL2ZManNCQmpBdHpkM3k5b0JDZWpnODQxWS8yN1lwTWFr?=
 =?utf-8?B?UW5RMHhoWnlOMzNNWSt1cWhpajNXSW9QQTBSNDZPUFp0ZDZEczlGWXB4aU5G?=
 =?utf-8?B?U2cwZkJZVGl5NVJ1S3hCNVY5NUdaVUoxVUZGa1lxcEZaYWRxTjVBU2RiSDZU?=
 =?utf-8?B?ZUJWWVlNV3A3ZHcrMTUrc2lHV1B6dUYzdkxmTS92S0kwM29Od0E5K3VmWHFw?=
 =?utf-8?B?UkF0Rkc2VGtCWHdxR1dTb25WTHZaWldvSTc3d3ltSVZBQzExWW5jQlc1L3dO?=
 =?utf-8?B?UnVRRnFTMWM0SUV5RS9EcCtNRVN6YnMrS2VrOFY5OVQ2M0NmMytCVG5oa3ZC?=
 =?utf-8?Q?nsMRBHKQj0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3NySE85VGkxWTZ3NytZaDlQQmIrZzNSYzlKNTRZdS9vc3prOFp5RDZDNXBz?=
 =?utf-8?B?NG5NYmNtRTBNTHZZNFczZHE0cS81RVo0V3ByWHBYVkVYWkZYNk5SRHAwNUl0?=
 =?utf-8?B?MG9XSGNxelNmMEVCWWx5bWsvaVUwNzhZZjdQQ1VmblVEK1BqR0FUeVo2KzJ0?=
 =?utf-8?B?TjZKcy9FdVNVSEY0VnA0akNwT3JXRmcvL0VNOGlaRmJjY0xCT2pCZ2xlczlq?=
 =?utf-8?B?QjYyei8zdXhHUmJyVWMydURORnpjZm04M2ZRb3JZRUpIdS9pazBLdWVJZTFH?=
 =?utf-8?B?cWJWVDJiYlRwK3ZnVWQ5bnBmTEoxRUk3dEFSaFNNaXI0N2xtS2w2cGE0K0VV?=
 =?utf-8?B?ZHFrMENnUUVaVFpwcHlNSG5kZS91Z3cxSElOaVp6ZUJaUmpZdUxnc0RrN21q?=
 =?utf-8?B?cjRoV1NvNlM2bkVsbHV5LzFQY0wzSDk3eWtveUJJeVFLbmM2Nmt3alUzS0lP?=
 =?utf-8?B?ejdNRkQ0U2RMMlJiS04rdTUrbmpySjZnczNoUWhHK0g2eEYxSXdoZUdCczNw?=
 =?utf-8?B?MkdvNkpPVTQ4VmsyOXMyb3hDMFRYQWlQTldnNFM4RXNmMnZhVWlYQWFCK3ph?=
 =?utf-8?B?UGVuK1N0eVAzb2dkOEtLdFNITURuRzlreGNETmhxbVdHTUFVUFdUOWhlOGlx?=
 =?utf-8?B?LzBDVng0UU9FWm1pZnhZY0RUL0xidDlJcHhMNm1NeWJOUUQ2dDdWTlZ0cis2?=
 =?utf-8?B?M1ZkSENkWUtRTnU0L1A4blZnL0ExcVNaNDVDLzNlcndpdWNQWlBRTVErRUc3?=
 =?utf-8?B?SFhJbEZvY1NpbFE1bkdJWVN4TDZ6cjVOWHM0VDZydG1DV2EzZHZmVVdBL1pE?=
 =?utf-8?B?N3MzYXdtcDJsUWtrbjRDQVp4MmRaR2ZPTHl2Z0VmK2dwaGN5Qm9Va1g5SDZs?=
 =?utf-8?B?MDYxUGxFSHZDMFZiYm9mbHpFeThzZ2pzd1pMdnhtb3lmWmhjU0hiY0M5VGJk?=
 =?utf-8?B?RmVmMDVndFlxazl5Z3lFV2pST21xM1ZIdnJmM3ZWTWY3bVo1ZEo4UE5lMFFw?=
 =?utf-8?B?VTNmcWthRWRnWWErdVB6YTdDWDZhR05jenI2VFAwd2YrYXp3WkNBSC9PdlBs?=
 =?utf-8?B?RnJDVnpGWjJ1SFcycVBUOHJLT2w3L0lYZEpyUE1QYStmV2laY2Y5VTRrYzll?=
 =?utf-8?B?TVdzOCtSRWFHZUxwQ1Vqd1lpcGp1L0lPY0hRa0grVkFlak5NQWZXUzBzejQ0?=
 =?utf-8?B?UkttSUpUeWZaTHY4UnBDZ29CWC8wZ0NTcUYwRFQ0VXZ3TEh3K0lyWDljSUxT?=
 =?utf-8?B?VVdmei90Q2o2MERmS2VlTXk4N0lRcTY5dzhYRVljYzVjdHZjY3ZiSVU1Tmx5?=
 =?utf-8?B?TGFSQ0E1RWJ1MXoxaWdkNnRUSVlCeWRrb0lpS2M3R3BLWnFzYVByS0pNVEhY?=
 =?utf-8?B?VlRjWmxDZUFFRHF3YUo2M1Frd0lVWmluZUEyU2YwUmI4L1Z4a29JVHNkc3dn?=
 =?utf-8?B?dUpXb3NYQkZBa0ZjOGlWUHZ0TWR6bm04VVhvVzVOai9pdVRGSVhWK1VBdEZ4?=
 =?utf-8?B?WlNkb0g1elhsQzJyRzBVUENZMHV5NWZGR3I4c01vWU5wdjk5WGgwandKRmxR?=
 =?utf-8?B?eDYzalVHaWpDdDRaY1Izdysya2g5YU12TFZKZWd0bFZ3d3FZNVNPUVRndUVq?=
 =?utf-8?B?cjdDeUptVFovT1E2U0xUeG1JT01kZ2VuVnJUY00xV3crd1A0d0FTdk13RmQw?=
 =?utf-8?B?d2EyOEdTTnREYzRLTkZ0YnIvbUxIdGZPM3BsNFR5VklUVU1nMUFQM1djT0Fz?=
 =?utf-8?B?MEdUQmE2WTZKVkovR0tkMkxCMmZ6TjkxbGpsODlSMjgyN0JkL2tJUUxMREc4?=
 =?utf-8?B?SVdFQ1FmaVR6UjBTWHR4bDFEK1FoVG1PYVNxRkZXWE82ellvYi92eGFmNjhR?=
 =?utf-8?B?M1h1bTNuU1JNSUV5cmJCRG5pWCs5cHhsNGI0Ym8wRHdyQStQeXVLNGpPdnhH?=
 =?utf-8?B?YTZxM2Z0aDJzY1ZScXhBeUhWTlppYlpGaUJodjd0SHBWS0ZKemZUaTlLMmZu?=
 =?utf-8?B?bkNLOFhiZmpjclUwTXNJeHF5MzRsc3g4aE5QVmZGM2gxRVZFT2F3WTM4cVBx?=
 =?utf-8?B?UTdydHR0UFIwU1poRTJiRVZTODQrWGQ2a2MvNW9ySDJCNy85SXVudnV0TnRq?=
 =?utf-8?B?VlBseEc4NERrNHplYTF2NUF2UkJMMy9tRmZvbWltVXowTGNNZ3FyVlJzUVNk?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d49df50-180a-4e19-5770-08dd9a03e208
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 14:12:42.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDPI99pvx+8Ia9Vsr5KkbmIDUxCMAuegRq4UFc8X1Hfydo87kkaCJsbWYqPGttgPJt6nNCRthn/RXnUDFTLU+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8878

From: Jan Kiszka <jan.kiszka@siemens.com>

This line is now officially retired.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                                |  6 ----
 Kconfig                                       | 15 --------
 ci/xenomai_3_0_x.yml                          | 34 -------------------
 conf/distro/include/xenomai-version.inc       | 18 ++++------
 opt-linux-4.4.yml                             | 17 ----------
 opt-linux-latest-4.4.yml                      | 18 ----------
 opt-xenomai-3.0.x.yml                         | 18 ----------
 recipes-core/images/demo-image.bb             |  3 +-
 recipes-kernel/linux/files/bbb_4.4.cfg        |  4 ---
 recipes-kernel/linux/linux-xenomai-3_4.4.bb   | 21 ------------
 .../linux/linux-xenomai-3_latest.bb           | 18 +++-------
 recipes-xenomai/xenomai/xenomai_3.0.15.bb     | 18 ----------
 12 files changed, 11 insertions(+), 179 deletions(-)
 delete mode 100644 ci/xenomai_3_0_x.yml
 delete mode 100644 opt-linux-4.4.yml
 delete mode 100644 opt-linux-latest-4.4.yml
 delete mode 100644 opt-xenomai-3.0.x.yml
 delete mode 100644 recipes-kernel/linux/files/bbb_4.4.cfg
 delete mode 100644 recipes-kernel/linux/linux-xenomai-3_4.4.bb
 delete mode 100644 recipes-xenomai/xenomai/xenomai_3.0.15.bb

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f4daf38..de48bc3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,12 +27,6 @@ stages:
   rules:
     - if: '$CI_PIPELINE_SOURCE != "schedule" && ($ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME)'
 
-stable/v3.0.x:
-  extends: .parent
-  trigger:
-    include:
-      - local: '/ci/xenomai_3_0_x.yml'
-
 stable/v3.1.x:
   extends: .parent
   trigger:
diff --git a/Kconfig b/Kconfig
index 042be93..3bcf9ef 100644
--- a/Kconfig
+++ b/Kconfig
@@ -98,10 +98,6 @@ config XENOMAI_3_1_LATEST
 	bool "Head of stable/v3.1.x branch"
 	depends on !TARGET_RPI4
 
-config XENOMAI_3_0_LATEST
-	bool "Head of stable/v3.0.x branch"
-	depends on !ARCH_ARM64
-
 endchoice
 
 config KAS_INCLUDE_XENOMAI
@@ -110,7 +106,6 @@ config KAS_INCLUDE_XENOMAI
 	default "opt-xenomai-3.3.x.yml" if XENOMAI_3_3_LATEST
 	default "opt-xenomai-3.2.x.yml" if XENOMAI_3_2_LATEST
 	default "opt-xenomai-3.1.x.yml" if XENOMAI_3_1_LATEST
-	default "opt-xenomai-3.0.x.yml" if XENOMAI_3_0_LATEST
 
 choice
 	prompt "Kernel version"
@@ -176,14 +171,6 @@ config KERNEL_4_19
 	bool "Latest 4.19-cip I-pipe release"
 	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
 
-config KERNEL_4_4_LATEST
-	bool "Head of 4.4-cip I-pipe branch"
-	depends on XENOMAI_3_0_LATEST
-
-config KERNEL_4_4
-	bool "Latest 4.4-cip I-pipe release"
-	depends on XENOMAI_3_0_LATEST
-
 endchoice
 
 config KAS_INCLUDE_KERNEL
@@ -203,8 +190,6 @@ config KAS_INCLUDE_KERNEL
 	default "opt-linux-5.4.yml" if KERNEL_5_4
 	default "opt-linux-latest-4.19.yml" if KERNEL_4_19_LATEST
 	default "opt-linux-4.19.yml" if KERNEL_4_19
-	default "opt-linux-latest-4.4.yml" if KERNEL_4_4_LATEST
-	default "opt-linux-4.4.yml" if KERNEL_4_4
 
 comment "Features"
 
diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
deleted file mode 100644
index 0b0c837..0000000
--- a/ci/xenomai_3_0_x.yml
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2022
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-include:
-  - local: '/ci/gitlab-ci-base.yml'
-
-variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml:opt-debug.yml"
-  LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
-  XENOMAI_VERSION: "3.0.x"
-  KERNEL_VERSION: "4.4"
-  CACHE_KERNEL: ipipe
-
-build-4.4:beagle-bone-black:
-  extends: .build:beagle-bone-black
-
-lava-test-4.4:beagle-bone-black:
-  needs: [ "build-4.4:beagle-bone-black" ]
-  extends: .lava-test:beagle-bone-black
-
-build-4.4:x86-64-efi:
-  extends: .build:x86-64-efi
-
-lava-test-4.4:x86-64-efi:
-  needs: [ "build-4.4:x86-64-efi" ]
-  extends: .lava-test:x86-64-efi
diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 81c61ac..c64101e 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -11,9 +11,6 @@
 
 XENOMAI_DEFAULT_KERNEL_VERSION = "6.12%"
 
-XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.15 stable-3.0.x"
-XENOMAI_3_0_KERNEL_VERSION = "4.4%"
-
 XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.5 stable-3.1.x"
 XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 
@@ -23,18 +20,15 @@ XENOMAI_3_2_KERNEL_VERSION = "6.1%"
 XENOMAI_3_3_VERSION_LIST = "3.3 3.3% 3.3.% stable-3.2.x"
 XENOMAI_3_3_KERNEL_VERSION = "6.12%"
 
-# If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
-# XENOMAI_3_0_KERNEL_VERSION. Same for the other XENOMAI_*_VERSION_LIST.
+# If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_1_VERSION_LIST use
+# XENOMAI_3_1_KERNEL_VERSION. Same for the other XENOMAI_*_VERSION_LIST.
 PREFERRED_VERSION_linux-xenomai-3 ?= \
     "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
-        '${XENOMAI_3_0_VERSION_LIST}', '${XENOMAI_3_0_KERNEL_VERSION}', \
+        '${XENOMAI_3_1_VERSION_LIST}', '${XENOMAI_3_1_KERNEL_VERSION}', \
         bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
-            '${XENOMAI_3_1_VERSION_LIST}', '${XENOMAI_3_1_KERNEL_VERSION}', \
+            '${XENOMAI_3_2_VERSION_LIST}', '${XENOMAI_3_2_KERNEL_VERSION}', \
             bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
-                '${XENOMAI_3_2_VERSION_LIST}', '${XENOMAI_3_2_KERNEL_VERSION}', \
-                bb.utils.contains_any('PREFERRED_VERSION_xenomai', \
-                    '${XENOMAI_3_3_VERSION_LIST}', '${XENOMAI_3_3_KERNEL_VERSION}', \
-                    '${XENOMAI_DEFAULT_KERNEL_VERSION}', d), \
-                d), \
+                '${XENOMAI_3_3_VERSION_LIST}', '${XENOMAI_3_3_KERNEL_VERSION}', \
+                '${XENOMAI_DEFAULT_KERNEL_VERSION}', d), \
             d), \
         d)}"
diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
deleted file mode 100644
index b026c70..0000000
--- a/opt-linux-4.4.yml
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2020-2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-local_conf_header:
-  linux-xenomai-version: |
-    PREFERRED_VERSION_linux-xenomai-3 = "4.4%"
diff --git a/opt-linux-latest-4.4.yml b/opt-linux-latest-4.4.yml
deleted file mode 100644
index 34b57be..0000000
--- a/opt-linux-latest-4.4.yml
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2021
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-local_conf_header:
-  linux-xenomai-latest: |
-    PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
-    LATEST_GIT_BRANCH = "4.4"
diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
deleted file mode 100644
index b078e6c..0000000
--- a/opt-xenomai-3.0.x.yml
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2020-2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-local_conf_header:
-  xenomai-3-0-x: |
-    PREFERRED_VERSION_xenomai = "stable-3.0.x"
-    PREFERRED_VERSION_xenomai-compat = "stable-3.0.x"
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 241cd99..fbc4ed4 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -18,10 +18,9 @@ DESCRIPTION = "Xenomai demo and test image"
 # Since 3.3.x a new package (xenomai-testsuite) is providing the testsuite.
 def has_testsuite_package(d):
     xeno_ver = "PREFERRED_VERSION_xenomai"
-    v3_0 = d.getVar("XENOMAI_3_0_VERSION_LIST")
     v3_1 = d.getVar("XENOMAI_3_1_VERSION_LIST")
     v3_2 = d.getVar("XENOMAI_3_2_VERSION_LIST")
-    all = v3_0 + " " + v3_1 + " " + v3_2
+    all = v3_1 + " " + v3_2
 
     return bb.utils.contains_any(xeno_ver, all, False, True, d)
 
diff --git a/recipes-kernel/linux/files/bbb_4.4.cfg b/recipes-kernel/linux/files/bbb_4.4.cfg
deleted file mode 100644
index 4628f44..0000000
--- a/recipes-kernel/linux/files/bbb_4.4.cfg
+++ /dev/null
@@ -1,4 +0,0 @@
-# CONFIG_RAW_PRINTK is not set
-# CONFIG_DEBUG_LL is not set
-# CONFIG_IPIPE_DEBUG is not set
-# CONFIG_XENO_OPT_DEBUG is not set
diff --git a/recipes-kernel/linux/linux-xenomai-3_4.4.bb b/recipes-kernel/linux/linux-xenomai-3_4.4.bb
deleted file mode 100644
index 678f7f6..0000000
--- a/recipes-kernel/linux/linux-xenomai-3_4.4.bb
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2018-2025
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require recipes-kernel/linux/linux-xenomai-3.inc
-
-SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRCREV:amd64 ?= "ipipe-core-4.4.302-cip91-x86-40"
-
-SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe.git;protocol=https;nobranch=1"
-SRC_URI:append:armhf = " ${@ 'file://bbb_4.4.cfg' if d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
-SRCREV:armhf ?= "ipipe-core-4.4.302-cip91-arm-25"
-
-PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 0aeeaa2..7381ea6 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -14,10 +14,6 @@ require recipes-kernel/linux/linux-xenomai-3.inc
 
 PV = "9999-g${COMMIT}"
 
-def is_xeno_3_0(d):
-    xeno_ver = d.getVar('PREFERRED_VERSION_xenomai') or ''
-    return xeno_ver.startswith('3.0') or xeno_ver == 'stable-3.0.x'
-
 def is_kernel(d, ver):
     linux_ver = d.getVar('LATEST_GIT_BRANCH') or ''
     return linux_ver == ver
@@ -37,12 +33,10 @@ python () {
 
 # default: amd64 or i386
 GIT_REPO = "${@ \
-    'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
-    else 'git://github.com/xenomai-ci/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://github.com/xenomai-ci/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
 GIT_BRANCH = "${@ \
-    'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
-    else 'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
+    'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe-x86-5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
@@ -52,12 +46,10 @@ GIT_BRANCH = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:armhf = "${@ \
-    'git://github.com/xenomai-ci/ipipe.git' if is_xeno_3_0(d) \
-    else 'git://github.com/xenomai-ci/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://github.com/xenomai-ci/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://source.denx.de/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:armhf = "${@ \
-    'ipipe-4.4.y-cip' if is_xeno_3_0(d) \
-    else 'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
+    'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
     else 'ipipe/5.4.y' if is_kernel(d, '5.4') \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
@@ -81,5 +73,3 @@ GIT_BRANCH:arm64 = "${@ \
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-
-SRC_URI:append:beagle-bone-black = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) else '' }"
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.15.bb b/recipes-xenomai/xenomai/xenomai_3.0.15.bb
deleted file mode 100644
index 2c0debd..0000000
--- a/recipes-xenomai/xenomai/xenomai_3.0.15.bb
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require xenomai.inc
-
-# Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
-
-SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
-    "
-- 
2.43.0
