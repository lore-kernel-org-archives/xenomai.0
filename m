Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1022E401
	for <xenomai@lists.linux.dev>; Mon, 22 Sep 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525729; cv=fail; b=io3iXO2ukvVw2EBb5gUAnPbtcFBXHpLDrTA2OMEW7VkT8Dx0WAvOyBuHEnBqMRlqJTjIoFIA16xaYfI/DL8JpL8BQGIhHt7R6MKfhkzsPVW9byUOqplRSzOF3KkQlHINyf0a0E8WowzOEaxLLNwhGFpzf65Y4S4vbjZPeSdinQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525729; c=relaxed/simple;
	bh=UvuqpgdpIXcb/PUABeSodCkPiqhzn0By0vOQCAFYAmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CHNBmRCzqFQwSBkGfM7xllzPGw+XTHQgz4AkKiJul2IM2d1FMtnAX0XbQvlQiYWhdP+EEwOQszpCgG9hX3HTW14/QZ2sG4VlR5GtRpHTyT/lcu33HJPUAkx/j7KOnxKchwmOByy/ZS0qZrOHIjjH6Po4nKhmEZjysdSXT0NLliM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CiwN/R4x; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CiwN/R4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqY99zdE2Kbcu/P++6QjWKKb/A5nuJBF7mDPdP2OZIkFDHQA8pnycSJhWQ/Fy3+IbhCAiaPJI/dMTXWNm8RJW3lyDBxJLJBZQ7/vVMQBFGU3tZXK/EzXmBklIUW8W4OI3Gvy7UM6GJ6zfTUruA7/qXmlaq86vqehK3mb5rFlzj5zoOZHW4asaGtBvSxWwHx1yu29equ8vDzmDp51ZtyCa6vqK2jTmiCj4XMfdJvmIbvzbhPF+mddK6X5Li9vdi3gGU/jfDjPcX6Yqsw6eOmFjm7n9iGJJYqsXxgxLcbyje7UnSZ4Z2udunSI0nY7F/iU1rYZd3gljk4X90f3+DuIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6Ot1nKGZyyvcsVC2S+t/OLdAUm5HYCwt8t/WAanN1s=;
 b=ZbPxN0oFF/MNa3Q7Pt/NwegX5pq5hU1CkuyYtlP0vzfSdSTGIzPhDGdzYajMOSXeFrqCCHkDrycvH40hkEDEUtJBY4eTKgRwm2fmJa3Y0RQ0vVkiku9mdk5Qc+09ljzT5w7JwbJlrZOroR/VxhkyAGWjCtQcrJYPUpwBa8iSfUl1wQbdlxTp3zAEsBz1MPnDxudOBBndylFQDUPJihen37vvJgsuwQq0u7OZQzc37mMYE+BzQ5nIFPVSCM4zpijyaDVvqzL+BPsiD5Zkev9R1xys9oAeiRv0s0WRM6jydPVyfomkJKme2+fn9m++fN/LkKxMuvtfpaBVZffxQclrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6Ot1nKGZyyvcsVC2S+t/OLdAUm5HYCwt8t/WAanN1s=;
 b=CiwN/R4xTraaoecH05KxHHAjAEN6kVsD4/narnEXzqJBoaT5IF9g95J+lnxgatjuWwvjMlO81+dnxXaKCMz7TZ6ewbceEGtG487e+UYakbB7/RcZD7PVgNMVkRiuAk1uhZDZWjX7YmmIaFRcRao54Gq1ZZvwO+5A8lecPBAoc7yxh7kaAWUB64qJLcXoR+Dk2S9wu/87Glk2apHxjcJvEIN/PSF5v5gBczh+qsosdupUtNdAwflaRCTJgx2cVBHgvUX5fMDy/JZ6ZgSCVKEyjSXDorolSzlaM1CkBw/wBeWFtppXqFYhDw3m5hehV7Ncdws0TolhhN4/NO2pNBaRJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5592.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 22 Sep
 2025 07:22:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 07:22:02 +0000
Message-ID: <115cc6e1-f850-451f-96a1-e711e4ecaa66@siemens.com>
Date: Mon, 22 Sep 2025 09:22:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail 6.16 v2 0/4] dovetail: Add support for hyper-v as
 hypervisor
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
 <f8a3f95c-f16d-4db3-8785-3acda2c738f7@siemens.com>
 <efaeb08a17e419695579f4edba542974fda2f4d4.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <efaeb08a17e419695579f4edba542974fda2f4d4.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0381.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: a6426e9f-4a54-485a-c4f6-08ddf9a8b9b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUJnOHVDaml6RzVnS0Q1a1ZNNXhNbWlqWE55QnpFdU02b2xmK0JSRXNackww?=
 =?utf-8?B?elRvN2poZUxjaHhvQlZEVit5UmpEYXdFUnZ6d0I4WVdBZG9Pekp5Z3dzOEZz?=
 =?utf-8?B?ZFRtU3R3SDUrR3czck5oTC8rUjlhUmtrVmN5TEYyVFlpdm5GTUpxMFZNc3ox?=
 =?utf-8?B?c3paNHJZQldFOFNqN3V5K24veXdBbVF2WVZjZ1A3MkZ2RHRPVlRMSUxPZW00?=
 =?utf-8?B?RStKU0o4dGxMT2cxdzZ0Yy9NeC9OS3NjYTFqOEpPSkRxT3NhWUx0VU1NZWJn?=
 =?utf-8?B?cXEwR0lXcHBYdE41QTRZRzVtWnBsajJZZEJ4VVFKZ1libER1WDBTTitBeTRn?=
 =?utf-8?B?K3k1MWdwZk9LTG5pU0M2eGZNQzE3aGdTVnZYanhyUGpxMStMOVJnSEg1YlZa?=
 =?utf-8?B?Wm5tZklVODdTMktIb3B4aHdENHRmNDluZnFCN2MxY0U4NGlmZW11Nm54OTFK?=
 =?utf-8?B?YlVzVU5jS2w4Q2ZsZjhMU3hIVERPdytXOCt0a29UcjhmVWl4eHRTNjFKUm5P?=
 =?utf-8?B?b21tY2RnWFRFdG5hUTh6dVZRWThZMm5yUWRZdXExV2Ryc1BEamZySEJ4bVJU?=
 =?utf-8?B?YVdZWktVYkFCZFZBRVpJVVpEKy9VVDFSZVNLbE10SWpyWm1zRmE1UjJYS2Zl?=
 =?utf-8?B?Rm53VVdFazJ0UDdQRFU4MW9BanhGTC9GUVlYNCtvQjZHclZMTis5bVNweCtt?=
 =?utf-8?B?ZldrM1YxWUZoRCsxeHdnOGZ1NUZWTnFpSDdXbHZDMUZsa2J0NFVLNVFnWlp5?=
 =?utf-8?B?VCttVWhjN1Z1QkFIYWJVL09PWFlYNFBJK1hhdFp2WEphNkdyc3VtdWxtVU5G?=
 =?utf-8?B?WGhma2hlMnJVdjZWNmNscGtIWlc0UVBuUE1rbWZwdmpLUTNxcDQ1VitOZ29B?=
 =?utf-8?B?ZFB0UjAwMkI2djlkM0hhTkhmK1c0cjlBSkszV0tOclQ2NG0wUGtXZ1NGRVZV?=
 =?utf-8?B?bXdaWHdibzN6WldCN1AyTTJSbWxQK0FmSlJmemZnZG5iMTBKc3kzK0cwcVdO?=
 =?utf-8?B?R004NkZPaS93d1NQYzZsTlNQMnExS3FFVW9UL3FGYVhpR2tHNStwQUJOTGJ5?=
 =?utf-8?B?bk5FMUhwK3cySmNrcWo1OHVwekdBUUc1cTdicjZ1enpudnljR0JIUjZWYVh1?=
 =?utf-8?B?b1BQQVBKU0VnUy9zeklUMlpMZ28zeHkwZUdwbEUxcUxyVWx6SmYvdjA5QU1t?=
 =?utf-8?B?eEtzRmpRdTlCVHJGTVJDWXJBLy9RWUtYUjJudjhodGRYSTNseTl4S1A1Qmsw?=
 =?utf-8?B?V0F6R2hFMVJSR2Y2cW5PVFY1Q2I4R3RQTmZpeC9rZFdjUVFlYW0zRG1oN0FV?=
 =?utf-8?B?VEZpSDV3K2h5UnlSWDlDRmFmYjVsa1VKenZ5SXphQmlQWVpscmhoSFJIVkRB?=
 =?utf-8?B?N0pqWU1UMk4rN1ZrSFJsdm91UGRQUVh2MW85d3pWNjN2OEFiT0pUUkdsT0hF?=
 =?utf-8?B?b2hQZSs3eUVvZjhjQklEVHozcm9PSkQ1ZVUvWk1kM1pYRVQvTWR6c3ZJV1ZF?=
 =?utf-8?B?MTRETndyRXZpMEhQYmlSM1JiRU5TclNUblBBMm95MDYwTEVFVmZ5N29ZMmpU?=
 =?utf-8?B?SkVSMEJWWlJtZU4weXRkVGNGSGtwWXBUMjRqSG5KTnJKbFUrcHBLcmQyMm84?=
 =?utf-8?B?YlVzNUtuM1l1U1NQZXoySzhGRmprcFRvVlZlb2J5RXA5Mk50NFUwRUtRenZl?=
 =?utf-8?B?dEMxWEdSalBiTXVBN0NVMkJibXJDSkREejhNbnMyeVJPK2hVYnJpcEpBRmxM?=
 =?utf-8?B?R2dGUC85RVVzWHA1QWlOVFpQdDZzV1RjWkFobWJBUFlNOEk3U1V0dlhCeEli?=
 =?utf-8?Q?Jl37N/N7tLDobHbsD6XlWqL/fRB8HgKmvl0ZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW9iMkducCtMR1pnU3ZHM1ZSa2FrNjFyaWlRSVhjWVVjci9sdmh3UFFrczVQ?=
 =?utf-8?B?c0lDUElEYjE1K0xOMUpOcWNZNytkWGFhQ0FQeUJRQUhhRFZidFhCUkJ6ZDRt?=
 =?utf-8?B?NFcvU0RDbDVUNXkvdm1XdWV2ZjdyWVM3RzJQMU16OVZGcmFFSDJFaUVXNXFG?=
 =?utf-8?B?bFVkdEtrUmFGQ0tuSGc5ZzJOUXBoV0xveFU0RlU3SjdlTXp2OHdmSnpWNEly?=
 =?utf-8?B?eCtJdEZHM1dONUMrQ05QM0hDSHZPa0hmazBERStjR000REZ0MmVISXJ3bEZ1?=
 =?utf-8?B?QjJ4RUdoVFRjUEg2N2tQTFNlUDNQd1FXZ1hGWnM4N0xoMnpkZGFLMG55dDJo?=
 =?utf-8?B?NFJWWE8xb29kOU54ZTl3TmsraStiQ3Rob0gybThCWUM0ZmduelNCd1FNY2Fq?=
 =?utf-8?B?ZGF5NWdOMGhTajZLOUU1bjhzS01DWVU3ckJaOUJmYnNTeE9KckpYN1VudkJi?=
 =?utf-8?B?M3hYS1ViWFdtdThBUDhIcUlpWHRYc3VNZ0N0SWZoMmtHS2MyMEZhdGtWRUxw?=
 =?utf-8?B?VjdISTFSTjZSU0xyaE1taDdxcmNpd2pSRXQ0OFl5eXhaMmFTUGNXV2RpSWl2?=
 =?utf-8?B?YW9wWFA4RnhFQjBsekJMQ0V6ck1ITGRsQzRJdDlpbFhhNllaWFdhOWFUNjdF?=
 =?utf-8?B?UGpGWWNiam15VGtLUkM5SjlFKzF3akVuUUx1eUc1bzBSMnI2UHZQZDVGYkxE?=
 =?utf-8?B?VkRGeG81K1VpSGRFckgxUEkzaUE3NTdhbXhIdE9yQXl3MVZNekhXb2hVREJs?=
 =?utf-8?B?VVEvTEJ6dlkxc1hWQW5jTHJPY1RIS0dERzd1WDdaeXFac21LNzhtcTVwNldh?=
 =?utf-8?B?ajZUQXowa2xRQU5QN2lvaWRSWDFhYUtJQ3hTdmZFVWFEUHBpcGZaQ1E2RE8v?=
 =?utf-8?B?RVN4NG1qeHFUS3VlblB1bHdVRURKZzJpWkxLMUwxWHN5Y1VPODZNSnJaNXNa?=
 =?utf-8?B?M0ppbTM3bHJDeStnOUxYWmYwOHlYdXpDNm52K3F2b3FkL0NWcnp1bklueWNC?=
 =?utf-8?B?L1hOSjJGV0FmVWdubXRybklMMWNzR1VsQWJMODAyTll3QmoxbDljTzl5YUJO?=
 =?utf-8?B?VWt1MXZBVjlHMWVUQlBSdXBKcnY4Z29VU2YwMFJxTWFwMmlKMWpETjVVeXF5?=
 =?utf-8?B?NG5XMDhRM2dneVQyNC9LVTlsZGtFVVg5SjQ2RWpTb0hxRUhQNnJ1dmtJZzlE?=
 =?utf-8?B?YXBsWnBjU2dreTNuUVVjWFpoYkh0SnNyQ3J2cTU3SWpKR2Q0QlpIb2FhWUVJ?=
 =?utf-8?B?cWduYndJenBvV3RwWmphcC82U0ZNTk91OXk3QlEvQXpwdnpSTVN5ZFh0QlpN?=
 =?utf-8?B?MURicUlocmVDbEhubm4zQlcrNmdQaXVjRzhPbjNlU3ovNmlHRjNJWUIwWmd4?=
 =?utf-8?B?VC9ReEZFMFN2V2lIOENZTTgzeFlhRytUZ3VMc2t5STl2dzBKMXhGRE53NHYr?=
 =?utf-8?B?cGJHcHJubCtoYTgwelRVVEZGNjhjVWROOUhpb0srNEtWNmV3NVkrWmVzd2Fp?=
 =?utf-8?B?VXZ3bTRKdCs2b2ZLQkswSmo4NGJtemgveHRQWEdWM25Ea3p5WFJxSk5JWFpW?=
 =?utf-8?B?d2pMZ0dzK0RUdG9vekhwWEZqbWhMdC9YcW1Kb2JTV1dZSjVwYjNhL3JzeWdq?=
 =?utf-8?B?Vk1ybnN3MXN0TzRtMUpEZURYOElvRlU0SU0xVTMrQ28vY1pnMnFoRW9QbGVI?=
 =?utf-8?B?aGtjMEx3OUV2NStMcTRYa1BhOThwWlQ5bC9jcTM3NXViZCtpS0pNWjcrdGlp?=
 =?utf-8?B?VzVFaml2NHNoMXdiODlGSkJhSDlWS21WK3lQQndPSFIveEdRTkRHYWtPR09N?=
 =?utf-8?B?bTU1OXRScG4wLzE0L1V5TGdsS2xuVm43SmZxd1ZCazVlVlFmVGJVbVRYMXRE?=
 =?utf-8?B?VlZUQlk1Znh5WDAyMWkzMFg3UmJCSzVEbEJCRmN3MnBZK3V5Y2c1aUlrelNP?=
 =?utf-8?B?VmhhV0ZydDNJa1dMbkpoV1hyNlJXYWZCaDFXM24zZC9NNGsyTEZGVE5LeWZF?=
 =?utf-8?B?MzBtc0ZrTDBzMjJoeDlnWXBUUTlBLy9aK0xDOFcvYjl3VVh0UlpBOEt6Q1hH?=
 =?utf-8?B?WE9vM0xlN0Z2N3ZvcEFtWC8rVWZ6aGFWMmlFcXJUZmNid3lTbGFCMHpKemJQ?=
 =?utf-8?Q?+HbDenjmLPEGCbNyoozGt5khZ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6426e9f-4a54-485a-c4f6-08ddf9a8b9b1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:22:02.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPAZ9bExINrc2ORF0+Jdoldi5VSipLxkMpt61jpjEvcbwpaEI7k8h51Ut6hrXnyqOmv0rIozOTR4Dnvd1y70Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5592

On 22.09.25 09:04, Florian Bezdeka wrote:
> On Thu, 2025-09-18 at 18:19 +0200, Jan Kiszka wrote:
>> On 18.09.25 15:41, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> with this series applied dovetail is successfully booting up on a
>>> Windows host using the Hyper-V hypervisor as virtualization platform.
>>>
>>> You won't get any RT guarantees - that's clear - but it helps to test
>>> non-RT stuff using a dovetail enabled kernel on such a platform.
>>>
>>> The following config knobs were turned on during testing:
>>>   - CONFIG_HYPERV
>>>   - CONFIG_HYPERV_NET
>>>   - CONFIG_HYPERV_KEYBOARD
>>>   - CONFIG_HYPERV_TIMER
>>>   - CONFIG_HYPERV_UTILS
>>>   - CONFIG_HYPERV_BALLOON
>>>   - CONFIG_HYPERV_IOMMU
>>>   - CONFIG_HYPERV_STORAGE
>>>
>>
>> Looks good to me.
>>
>> But the only way to stress these things remains running on a real
>> hyper-v. QEMU/KVM is not able to emulate essential PV interfaces that we
>> use here, is it?
> 
> Yes and no. 
> 
> Yes, qemu is able to emulate some of those so called "enlightenments",
> see [1].
> 
> But: Linux does not run into the code paths where such features - like
> the stimer - would be enabled. 
> 
> One of the first things the Linux guests does during hypervisor
> detection is firing the HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS cpuid
> call. The received hypervisor signature is "Linux KVM Hv" instead of
> "Microsoft Hv". Linux stops the hyper-v para-virtualization
> initialization at this point and moves on to using KVM guest para-
> virtualization.
> 
> My current interpretation is that those enlightenments are made for
> Windows guests were the initialization code paths on guest side are
> different.
> 
> [1] https://www.qemu.org/docs/master/system/i386/hyperv.html

If you do not use hv-passthrough but rather enable features manually,
you will get "Microsoft Hv", see qemu/target/i386/cpu.c and
qemu/target/i386/kvm/kvm.c.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
