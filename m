Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7947277CB8
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100327; cv=fail; b=Jwi7FExuwm85mR2epJFSigqZHdrRq2tyiyiJlHqVYC/gUeyTpN2GgRs91G0oA8746yEeFsrOwe9bJJPoAYToBuo+5/ReCweK9x3Blm7YKKiYmHgrf/qA+CopKRYaH9Z4JVNS/tsEMK9ICjFQatqT6eaMkNVn0lI6hoUeft9hISw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100327; c=relaxed/simple;
	bh=mPQZL+zlqbCSGfbW6Bt1R3dYNcsAP1pXThGLCkLLgEY=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=mpfbitPShxve9O13Ms9HZFg/1/KOlGdYYIIg3VlGf01FaXhE+Nun4mawMAVdzZFcAOkIWdZLj5PLNmaozPDE85l0wZBSQA/gWDj3G2EHN/V464w49rjOyEpMyjh7vrkJgb1ITNNadkua43fbDneZngcI0Jl1IHe82rsj7AhiuJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RwzFTaGU; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RwzFTaGU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh3s3H0U1w76xwOi4sJOvUin0O8ue+w1ywCNQIX1L6upb0EKNryvzQKk2kxcvyxSMNRhHhJfVjCK9bpMdeXRBfpTsDzDMSYY7bssLHVwVIi1nIseGBh1QL7dJ8uHIcITcVr6PuSclhWoFggMNZtwB6UHBvJXT7BVSMWtCF7TMddYz7hDkmuG4jhSm2R0OiV860k8A5X7dEQO3S6LeZx6jWn47vkajx0i6JGj9L19fYAEgwIzzGLroC5XivIc3NbB3BiMwYA8n67x/8Uzn+30ggX+v9rCCzhaNjRwxqN/EVuVr8JZeeRadou2TiMTsAeP6w0G9FX/uj8JWhxqmYYglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPSOni0hmC1hZUBPX+E3FMGEQLqyV9ycMRl/gXgdxn4=;
 b=TkhQypO5xIJIjYzlwzJxtI5Jvgn52exiCbg2l81zIcbvyaOucmpU8FlNd2qWZ9fb6+8qMF7jm8Mc8LoOti2ojiJZCwWe/Jexz+gAFryFVwza6a9/CSh9XsSwtyzzZxkXgNcFnHgcDkHfFINITJD+gQ6BI+XZ8mUK02c1VBha5WYeyu6kR6Eh5OSEWfZhc4vrhR86pD6/fa0iF3XVBTNZcwmac2d4ZvZOVj0bFGOBksjN/PrVN4OQar2zP0lGbBfZ5JO0hkVlPEKupSu7KEf0DwWxAATK2Xanopv+gq8/nA4zCIN9NuwhqNW3tvgvf5WFbme0HmHF2Hnpd83NtNV//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPSOni0hmC1hZUBPX+E3FMGEQLqyV9ycMRl/gXgdxn4=;
 b=RwzFTaGUEnhJRaYwGk/54EqQMfWl+v9APsfmt0HFTQvNYVd7pSHTKvPWmjxNrVkNI8KhcFhRsb3s90oaZutAbWN0X2hjiGDYZiXXfBl02jmuQRKvNqEQ1JGr9CXM+JpLWZ0IjOPPw04sL95D5nkNSHqdml1tak9laVi2rKr2IrBywbYtJdyNHe9TzDAInvj5QLBQB6R3y3w6JvnPqsiCi9uuEtbZ5Fr97fyDZvekne5KdkFug3vo7VrHPBzCIHGZRJqXX96juE8PlWAp64z36j268Zz0AMUxlTghQAjsezqwfJ9CNi8p+5Muc+eS3L6WXmeB39YWUjon7WIGD7C8fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 19:52:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 19:52:00 +0000
Message-ID: <a583022e-ab0b-4cfe-830d-6a282faadac0@siemens.com>
Date: Tue, 25 Nov 2025 20:51:58 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, November 25, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 4188c84e-1d47-4cb5-653d-08de2c5c18d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2xOdXloc3U1UDA5SU9hQXYvQ3grL0dGcVJ6d3RRUXByeTd3RHl3VHNRSU9G?=
 =?utf-8?B?RytwWXV4SExzWjFDMjZnUHpwMUNVWXZwVHBCeHBJdzAzSWFRY3BjZDVQbSs3?=
 =?utf-8?B?bXlFb3d0bTdkN1Fhd2U3ck02SGdhNlVTTW9JMkRlWDRob1d3TGJXa3Q3OWFL?=
 =?utf-8?B?VFErT2FGYlh5dFp0T1ZJeWMzazZWdzlsR1FkbzNLMDlNYWExVENVaElpWnF3?=
 =?utf-8?B?eHVITEtGWHJXZGZIa1JMVDdvcnVSb1FwWm84UE83cDExN0E4OVg5MzR5cWZp?=
 =?utf-8?B?QWR0b0d5b01rbXBFOVZjWUNkOElraEFaOGxIa1pRWFhUZEU3d3JIQ0VMVU5O?=
 =?utf-8?B?ZitUSWNWdnd2dkFSVlZDNkJRSkxjcDFJVDBCZzJOOVhBdjA0QzZOanRuMmpR?=
 =?utf-8?B?cDBZUXFnNWxMSW5XQ0JRdjd6ZHF2NW5NZWRMM1R5VmRleER2ZmcwOVpZdWk1?=
 =?utf-8?B?N1dVY1M4K0xJdmxseGU5bW1nMzh3LzcxbW1MUmkvR0k0MzBQck0rVm9QMkY3?=
 =?utf-8?B?ZHV5a2k0RFdzdnJyUjlUUW0yczhENmVxcHFMb2JYU3hhTjd4dUJ5bkJjZkZO?=
 =?utf-8?B?QkJValluUVR3eS9BWEhRYWNPNVpCT3dYb05oNHNmTThMUk1JYkJacXU3WTNM?=
 =?utf-8?B?Z2t1R0JBcnFoZzFtOEs3VHBjRXlBZld2cVlBZWk2c05ibUFYcGNaN0M2Wldp?=
 =?utf-8?B?TGlFNUZEejc3eDFPZUEydTdYNWp0MXhIZGsrYlBVbkVxTFF4ZVVGalAxcy91?=
 =?utf-8?B?QjVoTHFieDBKOHBYblFscSsyaW96YkY4cEJHeUxmOS9UMG9CZHdVZGgzS2p3?=
 =?utf-8?B?TEJIL3BpMDc5Q1J0TVN5akpRaG43R0Z4TldzVnVGalY5TkxIYWloNkkycEho?=
 =?utf-8?B?d3FZLzd4UWJxdFVkT0pZWm10S3phdUhXWUJVNFVCQ2VjK056VzJFZzNuaGpS?=
 =?utf-8?B?OCtwdmcxWDEyZlo2bzl2ZENTek9zUExqeGNDVS94YnhNTURiOEx1NktNamsx?=
 =?utf-8?B?VG1CRUN6OTZMY3VUcElZcmZRYjdLVW9pbDJ5R2Rkak5yd0d3ZWR5RlRNOUQ1?=
 =?utf-8?B?cm9MVmNZVk9rMGJjY0dKQ1RhNGVmZnI0bnBLTjFGYVFVaEgwSHR1RXZaOUZS?=
 =?utf-8?B?TDN0ZTM1WXFjZUlzWFRkaTFZU3hqWjdITmgvaDlpRHY4a1VsU01SZ0Y5VkJH?=
 =?utf-8?B?cXk1ZjFLbGZkNE0zMUpIbXJvak1hUDY0WDFsdElWWXlYZ0xXMnRnSHhxWkZw?=
 =?utf-8?B?NTJwNCtuSE05ZVpxeFNwNWxMZFZYUVZVa09LZEh4VFdySUZtYllUR2NFamQ4?=
 =?utf-8?B?QTlNWEIwRktTUG9DdU5RMDBRWFllV2x5Mmw3WnF5N1RpdFRGYm8vSTlzMkJn?=
 =?utf-8?B?bll1Q29WK2Y0aWRtcE5QSFNGazFWU050bmhWK0Nsc0M2a1gwRm92Undwb2k3?=
 =?utf-8?B?Q1pRZHVDNVB5dEVDZXFoaElrOGhObUlqS2Q5QTFEWURSOVV1UEZXUDQyM25R?=
 =?utf-8?B?dFlpRHRncGVrVUhoZ0YwblhpNjhLR1hQUlV3S0Y0eVduVDNMeG9BTEdvT3VV?=
 =?utf-8?B?ZklhWUsyN1E1cWtMcEhWcVNEcnNaTDdXWHhDVTd0YTB0Tmh4S1lqNXFMSlFx?=
 =?utf-8?B?UTNKL2JBWXh5UnZraFRpcVdQUlFoN0xXdk5aM05hUEJLdEF2NjFvd0xTcmxu?=
 =?utf-8?B?NXdDdlNpUkNJU0NsTUhVQ2hLMlIzU2QyMUxjbFdHU3Ywek9DOGc0REh6blZX?=
 =?utf-8?B?am4rTUFnZGg5K2dwM3dCWEt6cWJ4d2h0TUhNdmFtSWo3UWE5aFgwcTZURXEv?=
 =?utf-8?B?UFRuRGlSQ2dxMzlBQy93SWVIWm9nejM3WFBjb2taNDlWTUZMWDNNTTIvc0or?=
 =?utf-8?B?N1liencydVM0djVTbkY1ci9RTXNGR3JMUUpVK1BpMjAwWFZyeUhyNkNKZ1VN?=
 =?utf-8?Q?r4uU21MDuiOWieOiaI9G6NBAtLEsTyhw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnRNU0UzdER0c0RYVmhoL2g5YmZta0Q4Rkd3N3ZZbzV1aVdHaVZkc1VFM1hC?=
 =?utf-8?B?WE9tcjhxOXZldmtDMmIvQTVSZXZBTzBrLzJCZVM4WDVucEJPQ21HdkFCdCtN?=
 =?utf-8?B?ZnVHMklIZmlmMmlFR2tCNHVuVmtBQXhyTitOL3Y4VmZCYmVQOUNIQ0dIR3Va?=
 =?utf-8?B?K2x2NGVNWExMd3JWVGpPUCs5M01jU2k0N3RkbFRoVWN3U21wbmRVd0p6eC9w?=
 =?utf-8?B?Qys4MHg5ODZtVU5XVzJBZURRM1R1ek91VlV0dC96OGIzK3BrYU5UYUwrSDZB?=
 =?utf-8?B?UHBEbGZyRnpla0JFK1VBdDlGbmdXbzduZ0hhZ2I4Titjc25SazYzVTU3NFZO?=
 =?utf-8?B?bitYNnRiMkdCalNVKzZFc250L0cweG41cDJSVnZzVit0Umg0b2RidDZWL2dY?=
 =?utf-8?B?TFpNMU1NeUMxd0phM3dUSko2aEpObit2d0o5dlR6SUdBVFJPK1dFOTFGYmFu?=
 =?utf-8?B?OHFlek5Zd3FiTjFHMGhXelJuWlpiUVdZK1VRc283SnoyV3VlU3pzSHMwWmVM?=
 =?utf-8?B?Y1RWOUtpeUhsUGtiOTl6ZnprTjJvait0bnpFUnNsOFc0alpLakdIYW4zcUQv?=
 =?utf-8?B?MFJ4MHp6UFdDejFRZUUzZ0dNc05ScmpJM0JKdUo1aHVWYlNkajZDVmNsMEZY?=
 =?utf-8?B?RldDQldYekpXdmRjT2ZOaUxqWEl4OGZhdy92dGprRWdnWkxvbnh2R0hzSVBy?=
 =?utf-8?B?NDlWZVQyeHdJd0FqdWZOcWVPK2ZjKzVRUUptR0dxUnB4Zndjck42Z1FyRlc4?=
 =?utf-8?B?bFVyUHlUZDlJTXNpUk8wOGNsR1orY09JQUtoMVl5YjhlREt1ai8reHdvV2Fl?=
 =?utf-8?B?Tm1jejQ0ZG1aQzdTTXBKSXRNZDE5bjJPZ243UHplUXYrd0diTjNETHhjazgy?=
 =?utf-8?B?L0VaQVNlV00waHVmbUM0V01BSitRQ1phS2VPS08vUGxBd0ZWOFc3M1hGT3Bq?=
 =?utf-8?B?OW5vNklMcDhDNU1MWldQa0xielFkVVF4Z0ZMb09XZjRNQ0Rxa1VSOWhHUmYy?=
 =?utf-8?B?eWcwMnFYZFc2akRtaEhKcWlYdlVYM2MzTzFRdlNiMDg0eUJiaUF3OUpDdGgx?=
 =?utf-8?B?TlBEckxFcjZtMFlOQnYzTFM3RnhmU3U3VVlrbkUzRDZrOTl5S1VKcWVQaERz?=
 =?utf-8?B?bzdaTi8zbGdFbXhzUExpck1oT2VXRUs1L0s5ZFFWbWNoNVRzZkZPQkxmQnp2?=
 =?utf-8?B?UGtRYjMzMlhVdWNYS1lFSVd3T3lzUC9UWmZ0TWFnL1NqaFc3LzBCSEFObzdk?=
 =?utf-8?B?MUVQNEpvZitydzZCcVRhOHNJbnlSMFlHaTh0WlVhQjFraFJHK2sxbE5lUjNt?=
 =?utf-8?B?Qm1US3BBdk1IaVlXYlRVM2xxMGs4THk3OXduUXJKM2w5aG9KK0ZDZ1k3RmhB?=
 =?utf-8?B?V3V4MDVzbmcwaC9NdHhFamlqZ3FrZ014eVVtOVpWbzlicjRMM01pT3BPWmdM?=
 =?utf-8?B?NlJVVk9tUkprd1hEQnRNYmdKNVU1SUtqTCsrbVcrTUk0WVY3cE90Y3g0RERW?=
 =?utf-8?B?R3EzMVpjSEcySG5IKytFVG5hc1BSMmcyQktOand1Z1EvSjBkVE5uY0FRMDFa?=
 =?utf-8?B?Y1VsV1JIMmJ3bTR2dDBQVzZIOCs1UFVQZzVvWm9CWVBwcFN0cmxnVDVkTENa?=
 =?utf-8?B?ZVJUMEprQ1F1WjVCQmxna2MvS1liV2IvVlJDY1E2SFVWanJZWkh0M1hNYkZ5?=
 =?utf-8?B?M2grQU9OYlFNSkMzUmxmdHBoZGo3aGJpYXZXVmtpTldObksxTFRNUDkwNHBS?=
 =?utf-8?B?UUxQTEdEdi9hc1RxNndiUjJvWTVHczZWeTR6Y2lNTWVIS01oUWU4czRZNmQ2?=
 =?utf-8?B?RXhSdEVkcllna0J6REYzZGk2QXJoNUl2MURXZGRWYmJXaCtWWVRVSlVmNDFr?=
 =?utf-8?B?LzVSYjRvK0JXaFNlWHdBT3NFeU5nM1VMREdKZVFXL2hLMGIzRlBRSDNsQUZ5?=
 =?utf-8?B?ZUdYdmJTRHh6blRJZlkxUDIxY25oWmlWV204VEtpRk5vTm53ZHZRc3ppaFBF?=
 =?utf-8?B?bWZLRSs1OFlKU0hyY04yRmx4eW9NQ1JiYUNaZ0IwWXFnWDRXMU82QktPb3Zv?=
 =?utf-8?B?OVlxUE1TeGJUKzJUTTFJNDROTDYyVE1CQURBK2h5aDU2OCsxOFBrMUFIeVo2?=
 =?utf-8?B?aTYvRS91ZG5wY20yekVqK0RjUlFZeU51c0JSN2h6Z0tVN3pwTG14VFJUZXNs?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4188c84e-1d47-4cb5-653d-08de2c5c18d3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:52:00.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jibdLX1FnXcEkMUPTJocXbAfZa6oOLE28rWqL+Juh7k10GPE3ilu4AUsPUYXxdT/OsZAIPDMqpbRVdqj/b0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8459

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, November 25, 2025, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
