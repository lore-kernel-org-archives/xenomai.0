Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE834CDD
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489906; cv=fail; b=MLQTk2Vf/8wmGleL0+V3cXkeVtxXk98h/gMsTQqJnLw6BlEpo1bG4F+BKDv0wnWhB0l533MkWBFkqRnw6azfdv3aBTcSiAELPcynQjfM9j/qY1ZmKKJAwcbn1Zgt+8FpSndRVsj8SxgTQ+ksm0ichNh+AHx/Owrv3LijJ/MpltM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489906; c=relaxed/simple;
	bh=G94jpIUGieJnemkWfOVANpmp9TBrxdzZoX9afY9TefE=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=P3IGXDamImmOTWdzKcA8Sp3EnEuSK73R4S3e/bdTL04mlLuldVMQhZtJymDmu3JSqOEBaSqH3AxM7LvklNBu1ZeL5cfqtDApmcls5b4h5Rtr7x3RCjpWR/LMA6Cv8MqgufdccUc5QAKy6qkbHPaKs2XJXlWZL3DaC840pYgg1rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QRnAmK3o; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QRnAmK3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is7u020AYjzgQFoLBo/O0UytN4HgTiMTSRO7rq/jR2Z2LQbhzIVAmpq9Y/2YDn+QoqGNM8QfPSMrimj8uQUHy0yE5jPoWfSRcxxW14R/bZmoAlaR73/cuNo3ZnZECzT4pzRu3Ugl1EXAWaWndSn0kbH+SAIuoc0PzcPzTP3S2WNembWEXglWjNTK1aTQkeyfXvxSQMS25De3iX3MnJnSaDW2Jaf0DsyKceZ/Dtp31mXLGijlQzwt0H/bvQJNRcXzs7kUBZsHf6E3nD2dSbOOpbf/bGEtudBQgP0u6fD+KM4ZN1rJZrZ5tnu99Mv2I69vY8hCq2DP2XNW1D0yqrSsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVvFDWLqzN3miaRduk1tA0uCQ0kiRnGdoJiJhuKRQno=;
 b=J5luumfTdOycSLT/q7hwxZvnESG8juRtOxrTZ4qGSWMe1KZwMDzdge7VfnEoXLf3rOMliLlA9zsq+jwLTE5Eg9b4vg6RqlniTRacQbUcxcASOQ6wf6vu8Oxj21zhvHm7rzPxJvtdFtWIH+BKFd02IjnXOKTQ50gpU+C1vC0h0HmPwj8MFjLtsqGv4moWbfcAvvOu3mZ60NVBnyavMdBWtkFSAT05y3lhmT4iy/jauIzN7Yjc1MiKjmgUAJPmv4Q9r+tTD+a/QRhp8IVDM8NuDEtm+RVrwzHk+LLEq9Gg+Ox1KCVJBk9+1x1rHjKXyEZslmkOnsuhnEZSGKrz9TBUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVvFDWLqzN3miaRduk1tA0uCQ0kiRnGdoJiJhuKRQno=;
 b=QRnAmK3oJGRMm3U9l8v/Sl05ykJUELRi/1+GjFqPdKLm6GdLTSnsC0XS9SXvdtwSzMZTfZv2+C4HERu9NPffYiEggAZInyZ7mjv5YDiP4m2Ki07VzXnfTWkTz09AZikg0oJbUH50CCM7Ps+qLxFynUYw6lJgF/MGeLhEYEp49vcrRPOPddmJc1VfRScKOJ5la8IH0XDJeXfQ6xRrdIRC8zu0KGG4U1DZKNhcwHpJR/uDjfPXLdpYLYfLBDo0L9Zb3oA7ZHBxz4go5U3p/1XcMnHZsnKrGiwK5grh2eF++dRJo9HYYFf/8QbofFWs9YSfLW51ka399qk6/mB3lEnsaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 07:38:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 07:38:21 +0000
Message-ID: <b10f1074-d50b-49c1-a084-5500dd5aa1f6@siemens.com>
Date: Wed, 10 Sep 2025 09:38:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.3.2 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3662:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3ea50f-f3ac-426c-1878-08ddf03d0419
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXpseHErTU8zOGxnRWhJSVlnQlBmc2t6RkJ0NTVXYXA1b0xRUDNDc3VOK1hJ?=
 =?utf-8?B?V3FCOXRoNCsrM1NUaGhQUTVvL2RmcnpISnJ2eHlWZ3JQN0kyRDlPNjVuYVRQ?=
 =?utf-8?B?ZlB4T0d1R0t1L1YrdTFFeG5jNlhJbjRxOEtVN0wvQXI1cDVRcERoUTk0WHc4?=
 =?utf-8?B?WVR2RnN2OGdWVlk3cVY5QTN5V3BsZGhFVjlsaGVMV3dxQkIvOUpHRERVaXc2?=
 =?utf-8?B?WHVHcHgwZjkyTkxzWFkvZzZsMzg0RngxTjZtZ0xQRmVlRExlbDh1bHhRYWhG?=
 =?utf-8?B?SExoaXhlVW9JZzVnRzViWjhXVHNiN0ZzNGlKY3p4TnV1K2FnWVlpUVVCdGxI?=
 =?utf-8?B?Zm53WnNOQ0ptdUhodEl5U1ZIOXRQVS94UVIrOVl5aG9Dci80bmUrZzJKYTI2?=
 =?utf-8?B?YVlrMVEyTVRJdnFjS3ZXamY5ZXlMeFRzRHB2U2pmaDZkeEZVN2QyUkNFSDdY?=
 =?utf-8?B?Q2d5SlpQMnBSUEZXSWxkSU9pSkZEYzZxQmxpL0o1Q1FodDQzQ0M4NlpEUkww?=
 =?utf-8?B?L2lJRlozdStFaG5naGFtcmRBdW5RMVZrM08xNm5HYnNrTm5TQzBNRldqUkNK?=
 =?utf-8?B?MmllamNtK3d2dFgyRGJEdmVEcDhIMERReUkvMnEwTjBCL2IzcEY3by9BZnFD?=
 =?utf-8?B?NEUxOW9aWEJyalhIcnNLb3N1aG9uMHh0bC9odFBvVzhGOVo5UHVnR1Y5Q0VC?=
 =?utf-8?B?bVJWYThrcUZuK3U2aVk5UDNaRjdVRFpaMFNTSEV0aEFiN2ZNSmhtVlp4ajM2?=
 =?utf-8?B?ZUo0T2ZCV1ZtOUxjNG9BVjBwc3FvbDJWaXUvSlB4VUR6UEdmR3dUTTBxTUJP?=
 =?utf-8?B?Um84Ky9vVmFJa3puOHd5TTZNQmJqK0R0a1VOQlZRVk81NURYT0tKZ1drN2k2?=
 =?utf-8?B?Snl1Yy82SUZGaXcrY0YzVHhvVzd6cDEweWhNNjh3a1gyK05td2ZNTnlTS2xN?=
 =?utf-8?B?SXhjY29LZ3UzSS9jdW9DV00wN0xoOW1WUDZTZU5ZQXFKTG9rVENYUFh2bzV3?=
 =?utf-8?B?b1pXbnIxOHp6SERydElKajQ4S1k3Nlo2VDJENHVoQS9WbTJpNENmeEl0a1Nx?=
 =?utf-8?B?VEdES0FWOFNrZE9qc3k3M0RaYU5QcTIwTS9PeWxqQU91eDFNcTJCcVUxS3A1?=
 =?utf-8?B?ZXhQdTQxdjJ1U2JEalJvckFqcEdUK3NIMm5Kam5GbWtudVB2Z0xtZjhNTUdO?=
 =?utf-8?B?VWsxdlg1dlRIQ1pCb0VQY1ZLMG9veWJ2bjJRT3pma3gxRVhBMFBSS1IzYkZU?=
 =?utf-8?B?aEpiRmdwSC9iSzd4WTFQVUJMYTVOdmVacUt4VUNQVzVrTURIYXQ5VjdLQklt?=
 =?utf-8?B?ZEgzdHBzaFB0Ym1Mcm5KSGdIVGZ1ejlwa1lIekVycldmanExeUlVQTlXT0Vn?=
 =?utf-8?B?VlMxb3M5bWdvOXVCb0ltNVV1MmllK2tlWC95bmwvRmlSQVVVcHpaMDFTU1Fa?=
 =?utf-8?B?Wnd6R0ZUUEFROE55SFY4aW93dEJjZDBjRFdHazZWLzFXUW1hT08xK0pNN0Jk?=
 =?utf-8?B?QUxMcWc0V0NXV1VVNFJncDc1NDdWOFMzUmVCKzNDemZVbFNUc28wSDhmdzhZ?=
 =?utf-8?B?eThHcWt0MnZoeGM2UERvZ0JEbDlRRElZM3QyYy9JN1JWOVFUTVRLZ2I1bkdn?=
 =?utf-8?B?VUw3QjlnK3JudDFFbmN1K0JoVWVMOXpjWUtqNGRQd3dLVTdVRDkyZVNCVWhR?=
 =?utf-8?B?OHpjMUdvV1FLOEQxM0E4VXlTRm01anprK2FNMzNMK3JWUVJ5Ukh1SklPNFRm?=
 =?utf-8?B?LzNKbC91ZG1yUXdYWWZFQmhHWEpHYlV0TC82NzUzcnRSU01PcDNXMU1UeFQ4?=
 =?utf-8?Q?JE6uPlScznkL1wZh5HSB3FbUuCrKhg9MuVLGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1J0L2puN0dVcldudFlLSGtQbmhLSmNRL29OYkluVm43cWw3bmNEUEFIaGFo?=
 =?utf-8?B?Q1JGL05lUUhjT2FIcUY5eDM4QzV0L1p3eWY1N0d3OEdLeHRDclhJUlVLa00x?=
 =?utf-8?B?RFNqNFg5UGV2MGtHb2l0dENiYWVlVWk3RWJHcFN4OUkzTjk4bWJFZDNMS0xn?=
 =?utf-8?B?aFNLQ3hWSlhRbFRiaTdHZkUyRVdOTERKd2NDL0ZPaVJEV041UkQvazVFR1Z4?=
 =?utf-8?B?ZjM0R1IvV3pIRWZEY0NCUWY4T3g4TUljOFNTZDJKeGlRQVMveU5YQ1FvUDhB?=
 =?utf-8?B?ZjFNdllCN2JFOHVLT3k2Ym16VjMxZDlKaHNQVXNWdUxkSC92NW0wQmZlVkRF?=
 =?utf-8?B?RkFWUzd6cGUyMnFEcWdZZE5DcWtDK3VLVXpxZmV0cHdNQThwZDJyNkRCWWF6?=
 =?utf-8?B?MExTdWw2OGxudFlCUVUvVTVJb1VqVGZmd0Z1L3RzRENPaVo5d2lNZEJ1UHYx?=
 =?utf-8?B?U0RQM2hiaXRBQWhlN0NsSlNrQUVTc3JRdWQyVEVjaFVnNkFDaHRxV0Y4ZUpm?=
 =?utf-8?B?QUw4SXBPZ0FXZzJWOTJVbzhjT015dFcxTk1jNWRUZHdhbko5T0VmM0tVV3h3?=
 =?utf-8?B?bGlPTG5sdGQrS1BVRkxzbFJ0Q255T3BId0VJSS9aeUhUOEw1a0FNM0loVCtL?=
 =?utf-8?B?WGFScTliU1dQY3E1VVVCc1cxS2NtVlNXVzdXOUZnWWI4d296NkR6OTV6N3Fu?=
 =?utf-8?B?RjgzV2w5azk1NmZCMTd6Zi9YZm1mODRWdlBFL25TTEQ3emM4Skd2eTRjNFNa?=
 =?utf-8?B?WkhZakxYa3FmYnpOdFpxOUFmVmxaSFVJUXRVSEZVdFFoVXJBWXdDMVB3SHZJ?=
 =?utf-8?B?S0grWGp4Syt3NmlkOVEyUk9RSlV0R2tDUFlQcUd4Ym8yd2hEUDVEVDRaNkd3?=
 =?utf-8?B?eTNCNjZyTlZnbHcvaFRHQWZ3OUJXK3A1c1p6NVJaZlhKekhPdU9tSzlKT01m?=
 =?utf-8?B?OEo5ZmY5Tit2WlRxYlJlSENtc3FZa1N1Q2hlc281NUhCNjNwaFRFdGtWbjdK?=
 =?utf-8?B?YjNBemhpVHlhaitTQWN5aCtIdVZoMDNZRjRCVmVTclFCcHlOYWZML2JmMzRo?=
 =?utf-8?B?TmNHZUhlOURHTVlicXhMcE5lMW5YKzh4cDdMQ0lEOGVWb2VkWU93aUV0RTZj?=
 =?utf-8?B?ZTJybnZwdmZ3S1Vtb0lDSWQxYThJZnNZQWZueVpBUE42bDgzRlJ3b1RsK200?=
 =?utf-8?B?S2hLZG5BSURmdDRwWUREdWI3KzQvbmNYVmFJSEROQklhMFdUN1UxK0pub0pp?=
 =?utf-8?B?ZGg2Ykc0Tjh0UXk1M094ZGFmdlVpczJPaGtyWGQrT2FWU2lySHRJQzFYQXI2?=
 =?utf-8?B?WDZLVVEvckZRdWZ6Z3pwMkVVKzFkeTZNOGhycVE3ZWlPUXQwaXlrN08zMTNX?=
 =?utf-8?B?U0oyN0UrcElaUHhMRkJzdC9uc1Ivc1ptN05tb0JtMTdHWWR1aW9CNktSNEFt?=
 =?utf-8?B?NStFVlk2dGQvRTNVelFLaTZWVVQ5OTRsWEtocE9xeWpiSlRadWd0NTdCSmNH?=
 =?utf-8?B?eDBhdkpSNmpPQUpCNWk2M3dvN2pGeWEzaVRVS0oyK0dyMXc4WXBjV3l3a1FJ?=
 =?utf-8?B?aGZUOTBQRGRhRzlPMVJmd0dFWXZwZ0FrbkM1dFhWY25lZlZobG4zajRVT0M4?=
 =?utf-8?B?WHRTemtlWlE2WFc5bjROWmU3alNyRzhDUytXQ1NlL2pyM3FJc09ETDRxV2xG?=
 =?utf-8?B?UDhXMDA1YlFFRlRnNy9zdDZ1bHFsY3U1VlB5SFdEbmc0b2tyMWhUNHV1Yzda?=
 =?utf-8?B?dVVTL0ZoTU0wZW1vazBpRkJGMTFnTlFhUGJ0RmdYNW1pUThNU1NmNDgwWUV4?=
 =?utf-8?B?YjdOWkNPL0U1T0VnT2NpQ0g3VmJmVVdlTXA3cm9VY1ZaTXJNVEdnZTFRdk9o?=
 =?utf-8?B?WWh3ZVRBRlZ4OW1DbUgzTkJYT3lNRUlpa2Z3Si9zYitUTEplSzNNS3pvNWdz?=
 =?utf-8?B?NE1pUXNHZXVXa0lnZ0xsZk5kTFo3ckR4Y3ZWdlAyaDdlbHFONTBOZjlCSkZi?=
 =?utf-8?B?N2dleVV5N0RBeEhmeEV5L1BlUStvWEtlbUp1N29jL1Z6WFdiZGZZN21oOS9a?=
 =?utf-8?B?cFQ0ZkpwdHhJRWxCOGJ5NUNDejJVcGRJRjliQVlrS0Zlb0hTRUgyNFExenRx?=
 =?utf-8?Q?kq9IMYHjq6yiCl/tC/7uJAKSe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3ea50f-f3ac-426c-1878-08ddf03d0419
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 07:38:21.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ls/7g3CqpNg8eCAzs1tChlgWYryGimH4x93VlVKpKTPzi1bJF3X2dT/2cLTRsLgornj3U70f5g8TQhYqi5MuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3662

This stable update for 3.3 brings various smaller fixes, probably the 
most notable one for the cobalt library to resolve lock-ups in certain 
cleanup scenarios. If you happen to run Xenomai with PREEMPT_RT enabled 
(easily possible since 6.12), one fix by Florian for xnpipes in this 
release should be of interest.

There are also several build fixes for newer kernels and toolchains 
include. Just note that anything newer than dovetail for 6.12 is 
currently receiving several fixes. So the officially recommended kernel 
version for 3.3.x remains 6.12 for now, at least until the next LTS 
kernel is released and sufficiently tested here.

Last but no least, several smaller glitches in docs where backported so 
that our website can benefit from them as well.

Thanks to all contributors!

Download: https://gitlab.com/Xenomai/xenomai3/xenomai/-/archive/v3.3.2/xenomai-v3.3.2.tar.bz2

Changes since 3.3.1:

Florian Bezdeka (15):
      cobalt/pipe: Fix invalid wait context in xnpipe_wakeup_proc()
      demo/posix/cyclictest: Fix building with glibc >= 2.41
      drivers/gpio: Add missing MODULE_DESCRIPTION()
      drivers/testing: Add missing MODULE_DESCRIPTION()
      drivers/analogy/national_instruments: Add missing MODULE_DESCRIPTION()
      drivers/net/freescale: Add missing MODULE_DESCRIPTION()
      drivers/eth1394: Add missing MODULE_DESCRIPTION()
      drivers/stack/rtmac: Add missing MODULE_DESCRIPTION()
      drivers/stack/ipv4: Add missing MODULE_DESCRIPTION()
      drivers/stack/packet: Add missing MODULE_DESCRIPTION()
      drivers/stack/rtcfg: Add missing MODULE_DESCRIPTION()
      drivers/net/addons: Add missing MODULE_DESCRIPTION()
      drivers/can: Add missing MODULE_DESCRIPTION()
      drivers/spi: Add missing MODULE_DESCRIPTION()
      drivers/udd: Add missing MODULE_DESCRIPTION()

Haiyang He (7):
      prepare-kernel.sh: expand tilde in --outpatch path parameter
      Doc: Add supported_cpus param for Cobalt kernel
      Doc: Add watchdog_timeout param for Cobalt kernel
      Doc: Remove xenomai.cpufreq param from MIGRATION.adoc
      Doc: Add fallback path for asciidoc-icons to fix install error
      scripts/wrap-link.sh: Add support for -h|--help option
      lib/cobalt: arm64: Fix syscall macro argument casting

Jan Kiszka (17):
      ci: Fix detection of tags
      testsuite/xeno-test: Raise watchdog timeout while running in VM
      ci: Lift kernel builds to cip-based branches
      ci: Limit compile tests to 6.12-head
      lib/copperplate: Handle allocation failures of pvstrdup/xnstrdup
      lib/cobalt: Unbreak sigshadow installation for statically linked applications
      debian: Install cobalt-glibc-time64.wrappers
      cobalt/posix/clock: Allow NULL resolution on clock_getres64
      drivers: Switch from del_timer_sync to timer_delete_sync
      lib/cobalt: Fix cancellation issues over pthread_cond_[timed]wait
      lib/cobalt: Avoid deadlock during cancellation of pthread_cond_[timed]wait
      Switch hosting URLs to gitlab.com
      debian: Enable parallel build
      README: Update project URLs once more
      drivers/net: Account for renaming of from_timer in 6.16
      Add __percpu type tag to xnclock::timerdata
      config: Bump version number

liuyang (1):
      drivers/net: fix compilation error caused by RTCFG_DEBUG

liyinjie (1):
      kernel/cobalt: use flexible array member for symbol in struct hashed_symbol

Jan

-- 
Siemens AG, Technology
Linux Expert Center


