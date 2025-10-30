Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56624186294
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823352; cv=fail; b=cnzuwy7c5zisvuXRxsk9/cKvEtIyRebwXhGJ5DdMtYOsNZr9OqsT6IuC9r86N9/EzenSWMznREjlYNDzf+6ptZvshzuVZ0cEBJppiIMWTaIbv5CalrBMEBVrRPcqpCVO4Ia48s/1rOIIjRqYa0aF49PdmZTceOzm5K6wf3KNYsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823352; c=relaxed/simple;
	bh=Tm1Q6cRI+iDVgrXQtSemXeUX/Z88FppIlZy6TTMU7LM=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=Ye3OT+PS/ZtD2CDNzH3nXkCuiMmX1eUJo9tAt/3GVsmU21HSa3l0hjbEnJ6twBceQOps5d+kKLqSEAwjQ/9IAEBgh/T+rJ5fknc/comuGlz637HAqE2PlJEsw+gXhbzvx3Pj6IXEqeRb+IKnbYetbwKBxymxnzReKrvmK2GFFXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eSC7uP11; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eSC7uP11"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIt/povpLxCgubuFn4HCCXWuK913TRFNOhAPAfhTswMCPOlP/00MykNdTboGw97iQgxiKI2Jv0odYN8OAckt1PaoMOsjvkcoFF3SOh1pbzVW3HsxbtxEPBVHzSxaqPrdk8luWDPeZCANMvDM0G3Wuo2luWRw45RkbmRq/ezchtZnJIs2xFGUrpXhKg38wYKzmLY8zutG1l68Kl8UpROQ/5Vd78Aev6DXk2DwDmeCBrXqhkJkb3FBqNET8tZyhJ+4K9vgBIhZaJ3O6dPUuinAGT6MHWxsRyACTc1EAJkLPUZyo/ONjX4fB3eLvUtwlR87fuGsUvFkS2GfDRPIe/wnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6f5YWGhpMUGGe+ohwyXazirsPVHXf2TvUSV0T5TlLY=;
 b=HUvYNcy1W5STF/3hw/jmCodHKfptf7yN+ZdDNnwWcVe3R8ErNrgbJX5ODuitGLknStXQ5yX2mw/i/YLhthJmOZK0TNW3/1dhTtqWp2HJttiHVSJHktRA8MAEdMALmahyM+aa1v9we+bhJ3fDhYxQYKJ31LTrouZwZuLLDDCmZ1dXKnm/ono75rtVcJnZQI6NeqD+xkHvAa2YMKttHxnYGp/1bWAxsYfcokJfExu91vFFtEn0a1hOehArZdcCgbKIQXHs2FbX1JS6C45XzO/Yurb3mADV+vWp5X/ZeHL1WMhDYEI+bxHEd+96HqGoGLTlJPxFxhrTFn62vv4nlrE/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6f5YWGhpMUGGe+ohwyXazirsPVHXf2TvUSV0T5TlLY=;
 b=eSC7uP11BlztOrRD3X7WbrYU2S8gCmtCDBZJVnMavaIwl5pv6cojalcfLGsHqLgYi1ClDuU+S4mLcXpOKPtsG5GZRQ7xq3Glutu2bru6u/IlmI+N9ccp9mYRw1lYj1oqfy5c0HhdmROU8IDFjmhkAp9lqAzRh6J9PmZo8o2Ga0JWJ8T1oEdOjMGu2MB8T8nkiQsPVMVHp44hXGbLA4ekU2HV2HQFstIflD7nPtBvrrQwcGF2XX6iwU4JQSCHSIkhBjhuptJOFU4eeM34w5xO7hIwlEtW88SHUOa+8Z2nb8pFmyO/ns2CjthsTbacH9Xg6iL324bMjCjBJR565hUoMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 11:22:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 11:22:26 +0000
Message-ID: <87b4abde-7131-4590-a4ce-39358a853752@siemens.com>
Date: Thu, 30 Oct 2025 12:22:24 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail 6.1.y-cip][PATCH] arm64: fpsimd: dovetail: Use
 __fpsimd_save in irqs-off section
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 319783c3-bb33-4442-beb3-08de17a69a9a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXBhbllrQkVyMW1VMWVJdFdVN3RGdGtNZkxiMGU5V0JMaytvcXY4bWtOeFZO?=
 =?utf-8?B?dEh1MGtmNVVxQmxJb3lIMDA5Rm5PY21aRU1UV1EwYmc4V3BhM1Z5UUpOWUhX?=
 =?utf-8?B?aGI2TGVPZ3lRRlF1UzkwR2xvMFBsY3NPWEsxdW5xZkkwZzZ1QjJqUWhMQzZO?=
 =?utf-8?B?M2ZnY0ZsbGJpeElTbFJqd3B3ZlFVYmtXZ3c5RGxPazV0R01FdVpiMW1Jd3do?=
 =?utf-8?B?UHdNelAzWjZHbzByekRQMjFiTmErSEhvN1ZZT0VjRmRpcVpNMEV5K05vaVBM?=
 =?utf-8?B?bnZyQ3VCN09vNktLcWdvRG51Ky83MUo4UENZaWlYYXdmTk1OU0pHMy85WVZp?=
 =?utf-8?B?ekl0SUczR3U2Zmx4eWpuTGlhNUZsU3VKd2FIbEsrNWhScE5UcHM3ZmlvU3FW?=
 =?utf-8?B?bWpIZmExeExlclBqaS84a2ZPV3NKdDdwbmJLWVVzUnkzb2tQaXdNVHlEN25i?=
 =?utf-8?B?SmZrSVU0WVI1M2gxK09jQW5QUTNGTkRVODZXakx1ckh5czI2QlJ4MDJmQnFJ?=
 =?utf-8?B?TXVoemtzWFU2NHFsUnYybEd4aGRObzdTMllvdXlQTklwbDEvR2FIb1hFYzB6?=
 =?utf-8?B?elI3OUR3ZjJ5UDloUGtyU1JESGM2cHBsVEl5UEFzQnBNMlR0OUFZN0x5aVNF?=
 =?utf-8?B?ZnV2UEMrN1Z1bTR5K0pZT2VFM0kyMTM5NG91bldDZlNDK1hoYk9lTU52Rzha?=
 =?utf-8?B?Z1N0Qk51TGMzVjEvNFZxTkZjTEwzMW5FMG5QUDMzaGhZZjBpSElmQVo4bncw?=
 =?utf-8?B?L3pCTFBwK05ET3RBNlM4cjl1TE5JZTVpNjhTNWlPbVhQRTBzL3U2VDA3akVY?=
 =?utf-8?B?N29OQ1B3cVk2NlpPTHY0K2t1ZktoMENENUxXY0NEOGZFTTdVVXJha2Z6T3Bo?=
 =?utf-8?B?aCt6b0d4a2ZoQ21KdjNsVlhZWG1hRXZldCtmcE1kM3hhOHBsZURmU2JaQlE1?=
 =?utf-8?B?dWJRWjZ4cnBIR3lmdW9rSUFPUWF4SXoyL2lSdCttYytPbnA2MmtoNlpESFVR?=
 =?utf-8?B?czdWTjZ2bmpjblRLaytLSEZlZldqN1RPTnRLTmcwbDZQZjBJaU9lQ1IvV1py?=
 =?utf-8?B?RmV3QjZxTEZEeHl4OUwrZXZibVFLQlZFc1lobEpBU0x3d3hkVVhBVm5CRTBh?=
 =?utf-8?B?SXlXUm1NSEpEVVNDQU9POVVjekZCQjRKSHBISkV2KzdPd09Bd2MrOERSUldn?=
 =?utf-8?B?K2pJdlVRTERaTGdYenlaZWZYN3JHUlowL1BTQ3crbXNoVUpyWFF1TEYvQU5H?=
 =?utf-8?B?R0RGL2UzQmkvQVQ5UXVBVjRZYUFTQXNGZnRGR3p0UndoQnB3TXBDek5CaVhq?=
 =?utf-8?B?am95TGdSbVNMUjltTFNSeXltSGs2bDRDQmYxNlR0dFNvUmVEZG8ycXBIaC9n?=
 =?utf-8?B?bTZTd05zWFBoQ2tscUt2VWhZOWZaUTZHNklDR1daTzkrZW44SW5GOXloVG92?=
 =?utf-8?B?Qy92Y1U4OWc1TWJzeDVFdG00QlRVRUdIaHhNbm9lR3lLUzJNcEtuUlhTQVkr?=
 =?utf-8?B?dVRVQ0tnM2dCTEVzelFpa0hMcHp0V3V5ODFCVmcveW9XMEhtMzR4cU9YWWpW?=
 =?utf-8?B?Qk9uZkNwRXQvWnVOYmpZY2wrRDhUM1NoY2RuVEdhejE5RmFjbE5qb0VZVUc3?=
 =?utf-8?B?L25namVSeFRhMnVuVGgybDAxeHhoN0VoT0FjUURUalJRSU4xMm1rbkI5Q0dv?=
 =?utf-8?B?UCtXWHoyZ1dySXg2R2hEWHJKeUFhendxZXdFdjJCY0puN0VWSWdPYVV3ZHN5?=
 =?utf-8?B?VnNhRGhHTm1XRlErdUdHejJDdGhDTGJaYkJFVXNYZzBUY3ZTdlRrcmN6ck9n?=
 =?utf-8?B?c2EyTEpja3czbVBqN1FiU1hYYkY3eVY1RHhZVFNsbURMVkxtNTFsMzhzQW13?=
 =?utf-8?B?RVBoaTBscEE5VUZaWUV4TzBvRmllS0hiQmRFMDc4cDNnc3ovaHVhUHFxTmJS?=
 =?utf-8?Q?QGQeOmra6QpIh9dHuenTQi+Jp58+448F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3Voc3N6TkEwTGxjanNWUWFsZm13bkgwb1VQNHpPWERJYWlPUDMvbm56MFQv?=
 =?utf-8?B?eG9QZGZmeXhlNE1RVXRPRTlpYUI0YkJqWFQyYzV0aitrcFNvbDhpSnBJY0tq?=
 =?utf-8?B?TWIyRWdNSEloMXhnUUdFVVd4dW9hZjJ0cWlhd1FzWUM1aWZMbW12VXM1WWY5?=
 =?utf-8?B?WU52d1dJQi9kNWxDc2pMaVJYQkpwR1dFR1pRVTVEeHBuWWtiOCtPbHVKT0Nh?=
 =?utf-8?B?eFd6c2Q1OWR6ZG9xMlJiVHFXdWZwT3cyc1FjR1hnOEk4Sk5FQUZnM3BCNUtx?=
 =?utf-8?B?bUxGWExtUUtBbW9WUmVrQ3AvVlh0QUZrWFYxeCtWcjBLWU5GZEhTbWJNSXNl?=
 =?utf-8?B?UnRiQ2dQQjRzaHBFSjdISDhCdHR5VlhvTy95NktRSGRtVldCQkxrVDMyQkky?=
 =?utf-8?B?b2p3T2ZBMHVBVW83RExTenN6bjB3ZXM4L2JDamxUSnZkMllWeXFNNmk0Y3hT?=
 =?utf-8?B?Ynk4a28yQ0pKN0lndHp4cXpraEl2Q09OY2xsbzF1MjVjdWFFKzI2Ymg5YVFx?=
 =?utf-8?B?SU83aFpPQmJGTkJZaHRhQmloWkk4bE9WVnF3V0diaEVNelpiUFdmN3loRldl?=
 =?utf-8?B?RVU1WEp0VmNidkVxUW1Mc1F1cXdUTGwremR0RWYzSjRXVkZ3MnBncE92Z3ho?=
 =?utf-8?B?SDJmeHIzRlMvVHd0YnJTZzdKRUREd1VsdHhBT1VYYVFzNmR5SkVlaWUyZW95?=
 =?utf-8?B?Z3JSTThqdm9qZ3gwT08rZHQzc0o1NWtIekJvZkRSdkVsaEVIRk1BL3BuNjFV?=
 =?utf-8?B?dktWNjdJR1hXMTQ3K3pFRytPTld1QmxveC9zcmQxemNCem93RXFyQlNTZlY5?=
 =?utf-8?B?bHIwTW9uYk95dkJDRmcxQ25zM2pqTCtZLzFuZGRBb3Mxckd1QjM0c2puS291?=
 =?utf-8?B?cWZjQmJXNk9OSHdEbzQ2ZGwySUdWLzRBaXZUNFIybE5BbEE2aW5vQUhrWTY0?=
 =?utf-8?B?VCtWbGhtVzJWRlFrY0VoanQrSFNXK2kzYTdyS2NUYjlVMEJMamorZkNUaXlW?=
 =?utf-8?B?UVoxbEdzK1FXMHMzNVlJZEFSUDVjUzB2VVZkZFUySUhyTTY3SHhrZFBtVEls?=
 =?utf-8?B?N1pCdXRtYWREcHZBUzJ1ME1HMFh6Y2RzT3QwWWx4Y2Y4RmlVTStsY2xKdnhO?=
 =?utf-8?B?eExkZFZSY2loOUFHVERvcXJCNEZxNGVQV1B6d3lKaktsSTZXYUVTWklDR1JJ?=
 =?utf-8?B?Ym5YZ2hyTmNXWU9RalgvSEdzcTNJUHlTWTN0NVFEMVoyMmFjR0ROZTd2blN4?=
 =?utf-8?B?dGVCNERqK0JJNktBNFRya3FuQXBPeE94OHBZcWIwbzdvWEk5OE9KVmZ0cXFh?=
 =?utf-8?B?U1pWb1lBamY1alRiT1J3UmxoSUkzWWxwMkU5RGZrQUdjY1NOK0VBZ0lIZFE0?=
 =?utf-8?B?VzBJU0treVQ1bnA1ZkhmUDZQM1R2NnQxWUFici9UbHIvbDdJQWdsYytNVnRn?=
 =?utf-8?B?eFdnRFhtNmxoQXVlWG9HSzdXZFZEVHkwNS85eU1WUG5EdENYNlpaZVBLUDNy?=
 =?utf-8?B?RzBBL2lOdGRDUDVNVFBQbmFxR2oxNk1NSzA4RlhnMllCMlFZK3l6ajJadDZl?=
 =?utf-8?B?TkVhSFFBcGNUVVZxbUxsZlhrSkVVUVlqVlo1UC9UU0dpWVQrMHk0L2tlNldm?=
 =?utf-8?B?cVFBWjZ4VDArMis5Y3FYdzNHSjFVSnZlQ0tJWXlEU2F5d3d2UnZrcldQdkVs?=
 =?utf-8?B?NnFFWng2WVJWZjdjLzgvQ0EzZFl2L1RjbjhKNFF2aW5zM2VySEUrRmhzRFRV?=
 =?utf-8?B?QzBDcEVqekIvUDJqY3FxcllORnJXbUc3WHR0TU9XeE10RitDQ21WSGY4U3Bz?=
 =?utf-8?B?VGNCOXZFeXRqS0ZBQzlsM0JsV0FoanhBLzhRRDBSV1hsYVV3VFhSaFA0K2ZV?=
 =?utf-8?B?MzVlM0tQTmZXak1LMHJqd3FsVkV3YlJHTjVHVExvNnVHMkFGb2hNcnUyL3pY?=
 =?utf-8?B?RnhPU1FzdEhRb0x0WHVtQ3JSMVlFY2RaUkJ2THd2N29rdDJvVmdYNWZqVEVh?=
 =?utf-8?B?SU5qRFhnTnZJU1lwNnNrelJ2YlVhSHViRzRseXVDMWU2K0FUWnJ5Qlp3V1pS?=
 =?utf-8?B?Ny8zWWg3R0VFK2RLanhvemhvcXVadW1QL2RaTGM1bkt1VUdvMnlSUTVFN28x?=
 =?utf-8?Q?Y/UeK/SWNtB2n08yX5PLiVaEy?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319783c3-bb33-4442-beb3-08de17a69a9a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 11:22:26.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Pb/OGII+pHPkm2inPN3sfklHfw1Vn5DkTYevnTOgi/aZLJ44BEkca6YrAxB5/ctV2OI5A6HKg6DhgYQq74zyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7274

From: Jan Kiszka <jan.kiszka@siemens.com>

get_cpu_fpsimd_context already disables hard-interrupts for us.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 06e981edf3fec..0b5c2af07d82a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1954,7 +1954,7 @@ void fpsimd_save_and_flush_cpu_state(void)
 		return;
 	WARN_ON(preemptible());
 	get_cpu_fpsimd_context(flags);
-	fpsimd_save();
+	__fpsimd_save();
 	fpsimd_flush_cpu_state();
 	put_cpu_fpsimd_context(flags);
 }
-- 
2.51.0
