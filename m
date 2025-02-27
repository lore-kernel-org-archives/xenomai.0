Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019B21773C
	for <xenomai@lists.linux.dev>; Thu, 27 Feb 2025 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637781; cv=fail; b=bb4QclkPmSlsRrmQNRa25ZHhgKgEOrUZe9V3WbHBdUaloN8e/ekjLTeVMVsExp3Ky2ASHcsH8QjUVKR3315hkfLOPngLdZ1gQTHvx7XD/N02xIagC46ojVOkFLZZvjHEpfetsMPru5l6kAaL+7AUe6yjkytpzVmGOzMeyu/mhWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637781; c=relaxed/simple;
	bh=eINhOsWnIepT5M1GpWioZ06CZDSBtSXhQ8s+3hCykS4=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=OH/pu8sezU19/EU49inYkY2uVsbJtL4ho1wdvev4V34c2XYzrlkbdePP6sSc4o6fBZsR8KmZ6bR3c9s8Q8bwk8g8uUUV+ghVxIFlSJv/rTtAuNFPJssLhOgPVLIBz2zDXEbZGkUn5wNqozKZmSRj7ADC2tFi4SfccHjJaHwtT24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yxorUWxy; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yxorUWxy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yn4iy5EbcrL/ZLUSrstNMiEwftTXiFC9ownAREU8fOwXomQkEuypVha2TIr5oxCCArR7n7X3ftx5KxMcOekI2wnm6inA4I6+/kW2hQFsa6T9MLvWsbh1ymQKzXlicEcN+2LB5vWqfY1Jms5QQ8BcTN1fmgjtOzS+peyUwHStcrIuUCE+wxoIyXR7WMhS2UZJ74YuzJmesKNFrt9II7BauVWvHUPu5pwh2xBSbY14lAhWZ9suVlHn80/LyHRfGHa7tdHnTMRQKF5k3RtiRe89pADCZnxVvJSoqbud0l/YuhbHgKuyVa1ByI85Mg3ts51sy9/fgw3se/L7BNHLev8qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Clg7cY3HaWx8eayezxVRI/Z6+VDST//VclcYzGjebLQ=;
 b=Yeboqr+JHY76bdz75yrtyO0lHQZZXYYEP3Eap68A4MlB46MaLKwJtyepY+oaQh7C3IjVoqoGvcSF75mXc9M/PnBUBnQ8hNkykta2u6Zg8Ixa4fwpa1RXmWWjlh/hCSB6/2BznSbGj4OmSYkx3gukPBUPACeu+SSn3xZ3nyj9nw2rCwU0ayKVLY2/3tMhG5uZye9bCw1S03JUs5qy8UvVQASH3IkWudAao2teJ3wOMngKk8wlVS1+ppFmasLLboh0GDkpWlbSZG2JgpsU8DycB7BCPSN5aRX3fbqUxqzV8RnTM/hEehFmphzT6efhh4jd+B4pR5Doy06g9U/ENIWmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clg7cY3HaWx8eayezxVRI/Z6+VDST//VclcYzGjebLQ=;
 b=yxorUWxyKMFxC0xd0SuFREY3uIGdGRnDLnBBo26Ve4syHg2dXmBUUP0uHcbMUzhddoDx98E+Pw6riSYnRygI52S9Q8piQKBoMu5G446vsmLfp51F305eazPcpqxEt2IAO8utwXsxECp34unjDJAo0OITZ1rutmbu1CX4GCOcUxXOIRfdiO+LszVSRHgpzdiYVn3j+N4OFgRb9z/vBfNe3rOWouV+kza5dgDt2/1f/7D84RuqFAURmKJfH8VPYr6ho8OkJRH5VnkslB/soCC7oo0RvX+6YVW3PYVt44SkVaYQ2UDi1Qcfje6tP69GUr5Y0GN8pZ9NZ/+js85+mKc7Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.13; Thu, 27 Feb
 2025 06:29:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 06:29:35 +0000
Message-ID: <89fe268d-f404-49d4-8106-c1446e1d81e9@siemens.com>
Date: Thu, 27 Feb 2025 07:29:34 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [Xenomai 3] recvmmsg is broken when using timeouts
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
X-ClientProxiedBy: FR0P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c46e840-3821-43cc-e094-08dd56f81a4c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEFJTjZFekVjTmNuWVNEbnJjckhlbnJobTUvZkF3dVZvaUNnb0F1c1RQc0R2?=
 =?utf-8?B?WTFkSk5MWmhQcVdNUzRMaXB0RG5DcGN1WDZmRHFydlVxSjZudjRmL1ZjWm0y?=
 =?utf-8?B?c1hTTHBpZUwvS240aHVQOS9FbTdPRHFVSjBCUDRpclRIdmUrSW5nRE4vM3N3?=
 =?utf-8?B?VTgxVVU4cm5DUlc1WDRaeExCOGpxSDl6Q29zbTQwRE80TnJnVFc1Q3lieXJV?=
 =?utf-8?B?Z1o1QXhmdXovYXpWeHB5ei8vUDB3ZWFHS05uK2w2dUc1VDhQT3JOc2gvdXQr?=
 =?utf-8?B?NjhmZUUzMWtWaVV3aGgrK25mbEI1c0Jqa0FHK08vMU1lNWJUbkVKT2JRd04r?=
 =?utf-8?B?NXN2U2VqY2huaUp1T1ZQYUJFWk9ZMWVQK09DYk5sVFlkejQwNW4zZ0FRV1BQ?=
 =?utf-8?B?NHJZQVlFN2ZLL0lMN1A0bFYxdm9iMGZHOG1uNERIVFJjSHBYdzBLL09BeGk3?=
 =?utf-8?B?RW9EZUNIVHBZL01PcTZqZjI3VW05T1hsSllCWjRIOWNpZVczbHk3cWlMdVl0?=
 =?utf-8?B?TEt6S01MMXZVQkozMExuRXU5WFNuL1VZKzFqSFA0TkMvMVJTeHJ3SEJNOUxU?=
 =?utf-8?B?ZjRIemt0RXBzdDFKZSt1TGxpeEJkZVFDNHZ6K0llQzd6S2JtYUhNWTJOYmZI?=
 =?utf-8?B?NUlsbzYxakwySVRYMFdndXp6Y1dNbm5jNFllY2RZWG5qaHgzalppUit0cnpV?=
 =?utf-8?B?UmV1UGwxNFBMbkFGVndRV3BYdDZTRUJWdWFNS1RJWEkzaUpNSXhGQWx6bjd1?=
 =?utf-8?B?SFd5d0tCVHRHUHQ2RGl5eHJSejZpN2NTaUgwbk9CODhONjhWdmFiWWd2TTIy?=
 =?utf-8?B?TjZkWE1QOU9rYmwzRkxzSkp5UW13Z2hlYm9Ubmc2eXc5N0tSdEpVSkppREdX?=
 =?utf-8?B?U1B0dDVWcWdDT21Pbk1sWkxqSlhuL3pZejVkOXhMczRxci9ndVJkdXNLcklE?=
 =?utf-8?B?NVc2U2NLMzl4bDF3elcrdEZhN040UDc0ZURMM3VPOG9Zd0x4OER3dlg1WWdF?=
 =?utf-8?B?M0NwSnJBdElzSFVWOW9qZHRsWFhJQndkNlg4V0QwSExPVUtBc29ucFBkNjlQ?=
 =?utf-8?B?Si9IYW1EQXlkUHR0RmM1MWZpeHBZV1VmRTNuVVZ2Y2lJSllVSEJTVEpDVnVN?=
 =?utf-8?B?VmIwZ2FyM1JaNGd0bVEvMDgya0Y2QjRLN3ppTTNJVjlxVHFmZHVPcXk3NHBz?=
 =?utf-8?B?YXlZYWlydTZzRko0YXl6N0txQ2d0bVRaZ3BjaEdmZGsvTGZYRHIvTHpMWjM4?=
 =?utf-8?B?OWFGWk5qS0xhbWJxWDFLdGM1amVxYXNza3NudFM0VGc5WmNaTzRCNmgzQnMw?=
 =?utf-8?B?cm04cFE4dkFTUS9HOEVrSzlTVWRTQTVBK0wrNWRFdUp2TDRrV0RvU1hMaDYw?=
 =?utf-8?B?M0ZOaW9nRCtNNVhqWW51bVpwb0poZ3RXcEsybEdhTkdwWlBHYjFLaEtWdS9K?=
 =?utf-8?B?OEZBRFVXSkMwME4wdW5sNnhBY3c3cUlFNHA2MUJ1SHE1MkJlRThEdUFqYVRy?=
 =?utf-8?B?MHd1RGo4SHVtbldSelorU3pxWUxUbGZ5ckFrK1F4K1JqbW9qbnpVMERGMDN2?=
 =?utf-8?B?cWU2VUdkeFlZc3dKRUFiVkNYUThxWDdzVjBUZzR2YVo1dzhPSlhDc2pSaHFK?=
 =?utf-8?B?TlpUdDhPSDg5OW9kNThQOWc1SVhNUGI3bFhoakt3L25XSTdqRlJDRVJPYito?=
 =?utf-8?B?emZxU3ZnQ05GY25NU0J4TlBielc5MVNEd1NOMFFjUVdtNlVvRzg4aEF3RXdO?=
 =?utf-8?B?Z0I3ZW5EODdBVW43azZRdzlYMDB6eFV4S0ZYOHFZRGt4Sk9vdklRVkp2VnBG?=
 =?utf-8?B?azFTMDhFdEdqM20reW1xQUVXeUc2SS94cUQ1S0lkS3lkckx5ZU5Ia3RBMVNK?=
 =?utf-8?Q?/BwbvD7Wdrrx/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WENTNWF5dWI3Qk9qN1dTbDUwbjMrQVJIWDJCbW5MSXpUQjNWNHMzcDlwNGlH?=
 =?utf-8?B?YU8vU1dtVEVWZDE2YWx1eEJrUTl2UC8rV0pDNW92MUNWMWRUUm11SHBPRC9K?=
 =?utf-8?B?clhZUHpDd0VNWkZqTlVXZFR2MzhJbFAzZ2FYTmwwVjdsaFFhTUJVYWRUaFo5?=
 =?utf-8?B?eWEvNERCTHVGejNOcTVwYVJSU1RVUG5jRFFwdE81Wmpqa2RBcXFUbUp1VFRa?=
 =?utf-8?B?TzA5ZmliaG96WXBHbXBIT05GYmFKQ1VZTFYwa2c3d0EyNktoU3pBMmNzOUo3?=
 =?utf-8?B?azU1WGsvN2k1RUhyVDFYR2ZETjBRTFV1SmtRc2o3MStDblI1RlhBdTV1Um1H?=
 =?utf-8?B?YTlyUUNuZVFxNlMvU1l5cE5KMERFK3JuYXlCTGo5L2kyQ1pNYjBwN0M2NVAr?=
 =?utf-8?B?THNIZzJkT1YrbjBDYWxOMWk0S2dtQTY3S3NzUVZmSFJmbmZmbldoN3Y1UEp2?=
 =?utf-8?B?OFI5YjBOU0xYcWY0Y0lqQStCM2Y5aDBPZXVvbjU5T2E1VnZhMEo1TGpKYWhk?=
 =?utf-8?B?NGgrMjhiblFHeG83UVo4bkdObndHRmJuQjRCMnBnaDYrWEJTZEZBekRDMFdh?=
 =?utf-8?B?MTRZSnAwdHgzUmNOeDNHMERzQ1dDK09iNEN6WENETTlXUWhyRW54ZmF3cnhN?=
 =?utf-8?B?bm5OTHFXTys0UTRucUdNMEVDSC91aGl0K2k4WEJrR1hGSjM2TFJJZVo5VnJs?=
 =?utf-8?B?TVRvL3NHZnRhcDVYcEErN3ozNUlYNmxzbjRwM3M1WHJ1Sm9FNW9JYVE4b0c0?=
 =?utf-8?B?dmt6dCtIdVE5d3FuMWoycFk1cHJWNE9za1RLYkd6U3Q4Y2ZPdGpFYlhVMHcw?=
 =?utf-8?B?M2xOSnRLTHJtMGRvMGllSWR1SHdwd3ZoTXRUV3E5blVUM1ByMWhSWHhpODBS?=
 =?utf-8?B?NTlVM09pRUwyY0NWSHBvYk55WnZxaU5ZWlNFMVQ0WUFlSzd3clI5bk9nUmZP?=
 =?utf-8?B?bU9ZdmkxeCthblI3K1Npc2JUV1NlcTBvUWN5WGR1K1pRb2IyUG5Ndld2ZTlU?=
 =?utf-8?B?Z1c5R3VSUHdMSWRkT3FwU242OWxSK0M2R1ByaERTb1JuaE1NREs2Tkd6NndV?=
 =?utf-8?B?RDFCZG9reVcxMHpGRmJ4REt0ejFTZkNURzRzdWRTQSsxcTExbjd4Vk9DbVZ1?=
 =?utf-8?B?Qnowb05MSmZLSnpYRGxqbGlYQStFRDRmNVcrbUxaVTJ4MFIvTng4L1c0UmRr?=
 =?utf-8?B?bGYxT3oyblc2a1daZTlNV2VlTFNoUFFUVUtlM2dCV0xPWFI0ajVZcWQraTM3?=
 =?utf-8?B?aERrMlNWTHRPaTJPVThqWjJXNmEzREdzUGo1L3hTNTgrcmhmd0hRT0NrWnd2?=
 =?utf-8?B?VTg3MjZ0Q1oxdlBQaXpNRWNWRW1jSEROeW9ZaXRnSXY1dmt6LzZoZGJjUEtY?=
 =?utf-8?B?dHJlci9Nd056U0F0d0N0Mk5HQnF4TlF1dE4wZUgydTg0TDFodHRXMVZUK25N?=
 =?utf-8?B?OVVjSDVUY2Z2b0ZlL2FRd28yQy9PdCsrci8ySFBpVEdSWWpneUxCelBDSlE1?=
 =?utf-8?B?QlJzWlNZTmZUY1EvY05BenNJNWlmaFZNNGNydkdGaXhvL2FwbFVSNVoxTHRr?=
 =?utf-8?B?Y2FRWTBqZTQrZzNxWHNyS2VYZGhGUm8xNCtNUHgyLzQ2L0tQMTB4Q1l1RGhj?=
 =?utf-8?B?RDlSdFBVUG9kK2Jta2V2dzdTN0VuVXJuLzJqNFpzYzNVR1hEUjdtb1hGRThV?=
 =?utf-8?B?ZmhYSENUaE4vcThDcGRUbHE4YmJrYmo1dVRRemh5Zjl2d3UzUVZSRFVsUzZH?=
 =?utf-8?B?dW1qZXd4SCtDNlFUblNnYkJ4UEszdEVBZ3E2aDRwMU1nZ2lmaWFIcjk3UzMz?=
 =?utf-8?B?d2lsQlJpL0Y3dVg5L1VIVHMvVXBiQjdyUzArU1k5dEt1akVQMUdwVXJZbVU1?=
 =?utf-8?B?WUNsS0wrYnpRaGFtZDdHMm9EQmRsRXVNK095UUtxRzRiMmhodzZIcXZMVVdU?=
 =?utf-8?B?ektSeXJLWDkrQVp1bkY2YnlwTyt0R1RxaWwvQ25ESkZyZldHT2JZLzZycG8y?=
 =?utf-8?B?S1hXNXRYaVpyajBUL21BcmtMbytDa3hlVXh3K2VLaWl6RkdlL0JXeTZKZHNm?=
 =?utf-8?B?YUtFVjk4M0lNT3dJbXAreEp2Q1YzdXFVQ2tIVmJVZEdUQ2xmZ3U2R0lWVDFH?=
 =?utf-8?B?azF6TmR5Q1hKK2JicEV0STVmNkJXT1VSaGhDdFMrbWttRDEveVJlck9qbyt4?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c46e840-3821-43cc-e094-08dd56f81a4c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 06:29:35.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHKWNSagH1zw4UN1ZoNlxFgNHgLG8tJCMZ0s10gW2e4NbTBPfgLGPwGWRjcWnJvNgJEtY3fgy9FfmpwJj0YjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5936

Quick heads up, but I suspect only few are affected in practice:

The implementation of recvmmsg in Xenomai 3 is broken since day #1
regarding timeouts. The internal timeout handler
recvmmsg_timeout_handler races with the xnthread_suspend calls in the
actual recvmsg handlers regarding setting / clearing XNTIMEO. I don't
see a quick fix yet, will likely require some more deeper extension of
the cobalt core to support such a timeout across multiple
xnthread_suspend calls.

The issue can be easily reproduced by running smokey's y2038 test in
qemu while the host machine is overloaded. The test will eventually get
stuck in recvmmsg64.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

