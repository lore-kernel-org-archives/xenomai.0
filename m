Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093182192E3
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212738; cv=fail; b=W7xkyMKohDt3FekUk4pyFNTdgHGNywrSA4k8af4MfVX3qP3JiLekjPDyzxjMZ7QD2MQ/caGDvOKe4yR/7lkkGzwx+RWOo34dtn4Blg6478SPf88IO4ZLeDYdmj7jZADSQjjCXQWPKxpphS3KDMml5CMDT/C0c5IZbPwISCm7doE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212738; c=relaxed/simple;
	bh=EqrcohwPungStwgzCs/v8Is6qy+bqjXY6hrYAEQ6S8Y=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=llhk7/relkhLC/Nhl54zAn3NxL9B+qB/RimRzjJCEae78+B9/nab9T0zVspQBHvySVez73Ep16aezkibi1hmywZMn9GOGGoQhw89JUpbIbWTOnYgJ17Wil2P0jbuexLJXr4i36VNBEsycFtTfSuH89kqSSKiFFdAg9f0karjYfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=e1AjJDq8; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="e1AjJDq8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kff5Ia0GWFXgCTIeJPqoWG8oOuN5beGHse3VMP8YXpqWAoWfmsWSv1B5xKMiKAOHNnz5Bzpybl274xD4tPxeqQ/muZXntRvkacJrJmXMaISy7By1cwGXg9ZI6OqHkmGTB0NWzGId5byIwqdsGUzyBbtXPmI0nFrGdh9KThta0l7yTTS7FA5J0/mzjWr8tADQLTl/AWnW0WX2zq7UG3Bf8R1Yc6DpTd9SicSxdzza4tNQ2ODLK0uIxW7PBwxm1dHIjF+Ad8R8oe1QVA579u/NuTLSlriJ/uB7P7jyfWbo/yFP8Pl2FlgvgKm1pgMLEez6lCiKX6zAWXnl40TbHFy6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7EUBPN2Oe7GYjjTnTKdI2hkYyZ/Hj2y167o9WdIgm8=;
 b=Lek+BJtBhTZ3n+gXC6APGUrAeYu0PNlPrf87G1rtd5/+2J928Fu8pUZ/TQrc34GFU2s4rYhNzkAWdU8EFSzdxDsgJwTeMMXVEakE+MI23f8xKOnQkVRPF9KuI/dkaDmpINCaH9hcDlU6w85UcL3fFo+C2YuQGNwPA4scy2REw7oi6Hz+NgGBKEEVhplsml3k4rxD17sQ9i8vz1zF9nyvN0hu2RckNCyHZIiRWkPgwkMnRVyxjz+Mss9dRjHXiNTGIpt0GSrA8oRLcTbEBMSt/58fFxt0TOCoqLOkQ/OivwpRhS/M1I3f1UAfPDSlNjTPgWRLjtvjBjv9+Dp9kDRfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7EUBPN2Oe7GYjjTnTKdI2hkYyZ/Hj2y167o9WdIgm8=;
 b=e1AjJDq84851rNyyt8lpf3DTzNeC2N9G7r7oOi9TnzzoohgeoemWLrYR0WYtn20taK7/3noVycaugylTc3v3A/BYybjbUBx17b162iN8h1YbeqgPjjIYGLOJsmWnliFskkYrMhQApNcRVMrG0kRm+eq61zHyRZZmOA9HSB6HD7hlFA7bmGkLthDm6PStBJLzbDJNTjw3AKL0tZ6K0+W/2a967PPbVPP3L1qABSHiIapqSf4yXmOYGcI8XatD7tLxJm0/T9If+ZTXLjNYR4L9Njy0WwFrRCQ8zfs3n59+8EwUEdLxqGnYmkr7EDEmTRP3ym9yGZOwza8dxZpIEkoBIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:123::10)
 by DU2PR10MB7648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:490::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:25:33 +0000
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb]) by GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 16:25:33 +0000
Message-ID: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
Date: Thu, 18 Sep 2025 18:25:29 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop redundant
 hard irqs disabling
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:610:118::27) To GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:123::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0019:EE_|DU2PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7215a9-f662-48c8-b3d9-08ddf6cffd88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkFTMWozWWtOWFhsWkVsWnJ2YlRRUlFEYVBuYk15bkk3amFyNTdiRXpoN2d1?=
 =?utf-8?B?eWVNMjRncWMyZGJpalMvMFZDWGt2Ry9LT3R2bTY3Wk9nL2F1aXNYQ0p3L01t?=
 =?utf-8?B?VVdlVVRUZW5kdU1DQTcxQnB2Z3ZiZEJORnhDTURYVmdINDZRcWNqVmQrKzYw?=
 =?utf-8?B?Q3kvYkpEUWFISk9aSTJrN2ozenVLbGRkTXNOOTl6WHF1VXRjSG9XQVhWRWdE?=
 =?utf-8?B?blJJQUlYSDFGMnhENGFsUXBkR0dZOHBCRkJRMXIzMzVPdkw1WW9MaU8wU3g0?=
 =?utf-8?B?Q1RPQTJGME9hZTZCMC9lcVpMY2VQMUV3WC84am1NT1BQc2tSV0pMTmdWRUZG?=
 =?utf-8?B?ZFhZS0NVczVWNkxQUTlVNFdoMDNPNGRWNTVZMWF1a05kMWlFbS9menpmbUNG?=
 =?utf-8?B?UEgxRkRuUDAwUnUveWRWQ2x1SktCQlhBbHhjb2M4bWwvNGxQOTVDSUFqYmY3?=
 =?utf-8?B?enhCMFNBNFl4VGwxbXBoamlpSjFPMmRsSGlESVZ1b3ByL2tQMzdWNVlwaDNP?=
 =?utf-8?B?WFduUHRJTTQ2YmhITDUwWHlMRGRKckp0WXE1NjlCa0RsQ1JBMmc1eGgzcXhC?=
 =?utf-8?B?WjgyZm9IQ3lTU0crZ3hLQmNPWVo4QmtFaUh4VnI5K0NoenNRTUdwcWRMYk83?=
 =?utf-8?B?Wjc0RTR1bG1JYTZzL3c1R2JDYVVNZWdhSDhudzhMT2RGY0oycjJIMmFSSjZL?=
 =?utf-8?B?SHBWY01ncko5MmtPY1M0MXBUUWtXVUlzY0E4bHBTZGgwczk0dE5MNFdPTGl3?=
 =?utf-8?B?OXFxQUVqS0l1bkhocVB6RlMzOWxRUzdlMThtRTA4RTZERVRzTkMyc3VlSUIw?=
 =?utf-8?B?cDJFdDRwRUpzVnRDZUxYcERyWlVDYndhS2hXeFA3aGJZQ3V2S05hNW5IUVNH?=
 =?utf-8?B?VTBTamRKR0JjZEMxN3NjUVZ5ZjIyTHowRzAyT1ZheTM5cjBLT1ZYb29oR3lQ?=
 =?utf-8?B?NU9UTHFKR0wySi9uVStHU1pUWmJFSWlWa3N0NjYwWmtoakJ0cElIVGY2d29s?=
 =?utf-8?B?WHM5VGlDSk40Kys2QUtadFg4QXUvMGsxMVUrdjNrVWtRbnliY0lWTG1uWjZn?=
 =?utf-8?B?UXhsbHhScWFmeDl6NkRBYkRiZ2tVYlZYNTZNV0lMWGxkdzVGRWhycitlbVB2?=
 =?utf-8?B?N0c0dXBJNVdqelFJQnBMMW01WWYyckgvS1M5T1lyMHQxK2pLYVNYRjJKSGNN?=
 =?utf-8?B?a2VaZ1JmYXJpbXVYWmNOTVBKNEN0R0NLSURzNmR3bXBnRjFRUjlITm9xWnlJ?=
 =?utf-8?B?dWVENmZDUkFSMXpOSi92WXhQMGNtcktic1dldXlOMXBma3NRckNmSGZJR3Ur?=
 =?utf-8?B?UUMwRy9NaHlKbk5rTkxrM0FNVmZobms3WW5HdGpOVnpjMm40enozU0FabDN3?=
 =?utf-8?B?eVlvQ00vaXZBUlU0UTB1cnc5Rjdla2xyWmdiNVZPa1VULzV0Tld0QXIyRVpv?=
 =?utf-8?B?N0x4UjF1T011dWwza3pQZm5EbG5pdGVzYlVVcFRYS0VxOXYrRlBRWklTZnJH?=
 =?utf-8?B?elJTN3djYjhEN3E5WS9ycm15ZDh2Zk9WblQ0aFNBODFoQVNaQjZvM1BaOG9P?=
 =?utf-8?B?aTRVcW1XM2M0M0JHRGxZOHBNbjlrYnMzVTVJZzcxU3A4S213ZDRhcmtFamta?=
 =?utf-8?B?bGpIODRnQ3Rnemd5QldYQkZ5Wll4NjNwUGU4K3E4aWh6ZS9qakNEM3Y1MTJl?=
 =?utf-8?B?Rm9WcXIrSTNzVHVqMnp6L3RGZmVSZUpyOUNhSmhKT0pLN2FHNERKbHpNM29s?=
 =?utf-8?B?MmM3OFRyNGVtcWRoSG1hcmNpMlF3c0V1RjBST1RtbnRNNHpUVmt6U05Ra0V1?=
 =?utf-8?B?QmdhTHJwbTRvZzlLL1RWWndnTnRIVXZkMnE4YjVmTGNGd1FhKzJzQXYxM2R6?=
 =?utf-8?B?K0t1eWs1a3k0NkRFWjNkZXNwbVNVQkYxemF4cW9HMlg5QkNuNEg3VHZlNjBZ?=
 =?utf-8?Q?F4vrBSDXeDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0FkL2g5c2wrTWkvZHdrVXBZMGNSOFhvOGtSaEtKdmlHcU0wdjZOd2JaWFR3?=
 =?utf-8?B?ZFZlTEw4bnRjZmwxS3h4RkZ0REZqSnd5cDBzWGEzRGovMUdHVjhXcjFWVjJq?=
 =?utf-8?B?Ui9uZ0d3ckRZZTNyUlBMTTRRdTdoZ3d4ZWJ6UEVuNzZoYlBKdzFZa2RHUExZ?=
 =?utf-8?B?eU03dzBkS3BTeVdWdVhyVXhrN2JvMVlCeVZ5dkZOY3MvTXREckpqVUpWeXow?=
 =?utf-8?B?cnp3VG5xUlBTOGovWFdyZWs2ZmdhMGpPL0pTc2V0bGJSd2NSQkNXZzJadDdY?=
 =?utf-8?B?UFFJK21pUEhtTzhSeDdHcXlKNVBYK1pKczdUOEZDTldIa2VwaTExRVA5bmVW?=
 =?utf-8?B?Z1VvajF0bmhWNld2ZDNBSzhJRU1xaThXNjM5SlNzS0pSdUFhNitGNVhubDR3?=
 =?utf-8?B?RUk4YjVuaW96cVE2eTB5bnNYV0l1OVZHQ3BRK2VEZEFpUGplS2lpM3pHdStz?=
 =?utf-8?B?aW8wbDRaNHUvTmVtSXI5RnFkSUFRWWdpUS9vRVFKSFBoOWQwZE1nVSsyUXNZ?=
 =?utf-8?B?TEtuUXo1YzQrVXYweXNmSWgweFkydGVjNTFjSXBGMUc1d3FZdEhlY3poeFdX?=
 =?utf-8?B?U3JVL0VGRFJzTHJ6ZndBZzN1TEY2MXpWOGc5THFHTDM4eXQxR2hwenZHNitO?=
 =?utf-8?B?NmtPZFVQYnZWL091Ykp4aXczRTJ6QlJxSkVHdFNYbDdBd2E2OFJkbzU0YU0w?=
 =?utf-8?B?S1hhQ1NBa2l0OW53U2lGdXJDalIxT2lrRitSL21OOSs3VTNTMDc4TFEvNGJ3?=
 =?utf-8?B?QXUrSVRyN0c2TkIwM3o1dUZkMEMwWS9Ubk1lb1dBNXdKUk9tQVVyZlk5NVZF?=
 =?utf-8?B?cU1hdURieG1DUTVLSVpzaHQ5VkZnMWdwVDVOQVpIamlPNmNHRnRBN09RTkQx?=
 =?utf-8?B?eW8xWFVLU01mNXQwbEtqL1FxeTJXd1prTmN2UmdsaUQ4am5TQklZQlNUZ3JP?=
 =?utf-8?B?alhFOGVla3R0Qk9HSGhtdk1CQlM5NGxVOWtGWE1DOHkyUnJhcmIwbnRHRjhD?=
 =?utf-8?B?MkQyS2xzNE9uSzF5dU82bkl0RDhmVmpVNHFzT29nK1k4ZnZidW94M0txTENv?=
 =?utf-8?B?SGFsNmJYa0ZkelhXWjZkVnZrWHIvMGxGQWpQWDlMdTJ4dFVQK0Q3MnVFbVpZ?=
 =?utf-8?B?WlM1K1R4LzEzemVWYjg1TXZ4UWFmOVE2OEpvVkJNOWU2L3RYRVFnSmVWeVU4?=
 =?utf-8?B?RmtRTkdlL0N1Z0FoeG5kMFRNN1dFSHBtQ3o1MHRibUZuZlk5ejBQaC91MytE?=
 =?utf-8?B?M0pQWWpPQk9LVTNMRlN5aXMzcnJBUlFVYWw2UThxYmhoUW1RNy9hTFN3Nzhu?=
 =?utf-8?B?SGgwa2FNTmNGK0grbHVzb0dNT1UwMXdGYjBTdEtXQmtwRWNPQkQ1WmNXRzla?=
 =?utf-8?B?c0d4WUZVbjI0NU5YUXY3M1N3M0dyd0wrZ2Z0KytDYk4weHRjdTRGeVVXSkdo?=
 =?utf-8?B?U3VOQjA1WEY4ckp5WnZFTGgvTXRUS0cvR2Q3bmZzSVZ0Vm14NTVIZ1VrMmgw?=
 =?utf-8?B?SkxCNmtDdVh1RDJCTHM5SGNNSFI0OWFWeXhVN0ZOUEhwQjluSjFTOUcwNGlu?=
 =?utf-8?B?RllYZ0gwdUI4aTVabWgxck91WmVENVRMWWgxS1ZWOUtmRC82Y0xacElqNzJS?=
 =?utf-8?B?bTZEYm91eWJjVHY0aVJZbG1RU21Db1JoSktGR00ycnhTandsVlZTV2hUQlFV?=
 =?utf-8?B?ak9mQTRQaTlHOUtsdHh0ZnpJeGkwZmh1NEduVnFZM2N1TkdWOGhuaGlsaEFw?=
 =?utf-8?B?SHcxUkdFeWlwWnJpRmxLMXUraEhneXIvNFBoWjl2OFZIamFKM3NLZzRkYitq?=
 =?utf-8?B?Skw3YkcrRi95RCtJa21SRElVUXR4QTJCU1hKVlU1YkNCK2t4amF1aGhMRmE3?=
 =?utf-8?B?UTZqQzV0R3dhbnJhM21lOFV6VW9sRFFycFZnU21OcDk2Y0VBcTREMXUyZjZT?=
 =?utf-8?B?Yk9KVUhaNnpVQzNDeGcwNm1sMXF4MzNBTU5reURvS0tDU2s4WERsQ2J3OUFZ?=
 =?utf-8?B?SmVJMHB0TUgzditoY29zQ2tqWTRlOWJSNldSUU1MT0VZOUlhcVEvMUhtaE5s?=
 =?utf-8?B?RmhqNkVhV2xBQ1VaVVBDSDN0cThxQWJta3dRMUlaK05kNWhMUk04dFg0eHhj?=
 =?utf-8?B?cVREZ2VwekduUUxTMjhCOFY3UFRDcFRRekRmeitoV1A4c0syMm1tanJGMjE5?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7215a9-f662-48c8-b3d9-08ddf6cffd88
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:25:33.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yjb0Vnpxp4kNj4zf5wo2HV+XKZr6lC/1SbPe8rAc2JZ/dH+SiNSuGqHzod8dBbhLmK+6zBSpgUVgLQefSs7Q9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7648

From: Jan Kiszka <jan.kiszka@siemens.com>

fpsimd_save_and_flush_cpu_state() itself does take care of this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes for 6.1 will look different.

 arch/arm64/kernel/fpsimd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1f5fcac32b2d2..21f8785948ca3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
 static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 				  unsigned long cmd, void *v)
 {
-	unsigned long flags;
-
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		flags = hard_cond_local_irq_save();
 		fpsimd_save_and_flush_cpu_state();
-		hard_cond_local_irq_restore(flags);
 		break;
 	case CPU_PM_EXIT:
 		break;
-- 
2.51.0
