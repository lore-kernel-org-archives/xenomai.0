Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CE3EA76
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473796; cv=fail; b=leNaQVSHz39IMvSPXW+ZaV8H80yqatOuFAdYl7spyIeCNQtuXQ4mLaOMammaxIXsS4vcNwxh+piJDOQwVAY8XKEpqkYooj9BCo1dM0ehew/WlEPFb29t3AC4e0FuGWC29RYGL99iIfRnY/1tcL7WoLiSvB27jYY4QnmEuVfq+Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473796; c=relaxed/simple;
	bh=l/uxvdxoJVuhkwfSocRYBolp5bNVHUoKyclRxAadDwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyGfsjpcXtEoPEMFDUNxz7c4RQwR2krzZXqcn2qBu6x0U4YCK+whETbECQVfL6KGxwLHYHi0tirl0R69TgBIyhBkMDAE57SonNPVbhvBM7qwVV13U2AZCTHbfpsMDG3DMOysqihjDivRn0Zp24B6Kz6o2MtcSLjr0oxvkyO3/cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZggrYG7q; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZggrYG7q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYCKtkfaj8su6mLrNdl0jxH3M6FLSVOG6i/F+abzOTx7VNR+3ICAmOyc7yaSgw57ZUfBXZ2XEosiO5PUN3fwB2vaiEWp2eW+a064vjFsef66SU4K2ZHsrSqHQ46lVS2xLguj1WkTs23Ry9goYypMGAAGRZyZMy96ZVPd82hWnAu54hDN7mA4twjVXpvXGj/BXl3T4lwquz7yD77DaE2oCc6HW81KAWl58or5/vfrhariQGs6/jn6BSnxtiGLq98RQi31eARVGoXjL9oyUKe8y9VElGPFCnt+6Rwma+wzUjwD8R+fLlMOqFe8WzewL5zsi5eEmZoo6yl2qcd+v641pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OCFEoimJx3/Z0F5lCeG6P2ccNpb6bcQRgpmf2xL5QI=;
 b=bj7RCHyle3Z8uFrTG1yv9JWNZ8iGNiY5j+UpLrvnwi0iqj2uzR8Pp7svaWmh04pvnTNE0JezPu7LG0EjojB+fXrX6U5amERuws5dfQSAvX/oTkmIkjp1wYiDBFCdMKsKPEv6YlxWnETCK4MMMRrl4HJ0CEvk5lleGxohRVl7qasPwfdHuDl7dKD95k+iLhGs5dsPz8fnPSxG+hXxhY42i0dF5aU5qi5rrlmTkc/J7QgrilDvwZVUyjEVUaAv34YXrSJj0+CFvwUyWLeUTLYlzawQmz9UIleqAHmhOsZL0X+3f3kN8GETa9095WVeGYj3Oi/zdjA1V/sgWB7AwCnddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OCFEoimJx3/Z0F5lCeG6P2ccNpb6bcQRgpmf2xL5QI=;
 b=ZggrYG7qYJPgEPeL9EdQ1fJzqB8+HJdEsoT2PFIYrR3TGFCNJK7U860QHbOz0YctOYAC1B3tebDUyiMpKfwxZY/2JGtbTcpLgMGyUcwyofpcyV6+vKO1wEIoMthStaeh3GKatgDWIxjJlx6HKQxugRFDEfmy/FuJu5YUafoTNi6fOtz373EUFv3f8wSrx/g1RtEv8rjODbb7I1PwzODr0gEVAiMsU8tgQTb40onr040AQXVdEQqW1vzO2crHB0o5EAINy+cRYcLTZ2SDPu+uV+up/UEuqhAjaRi3mzS3yC+tUHvzNqUhIGabz/qBEM+9xvX3R00QXXeRBh10VbBSZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 07:36:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 07:36:29 +0000
Message-ID: <33dbafe0-3da7-4065-bfa5-0fc7fe4432bf@siemens.com>
Date: Thu, 27 Jun 2024 09:36:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Clean up generated syscall_entries.h file
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at
References: <20240626192625.14745-1-richard@nod.at>
 <77eb1c15-be5d-4f99-b023-844a679699cc@siemens.com>
 <4209190.8TcEBkooeH@somecomputer>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4209190.8TcEBkooeH@somecomputer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 304a6cc6-8f0d-4e42-fb7e-08dc967bdbd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3hrc2lGZTBMbDVwb0dSeEhaUFVlNWt6MGZFZ3JxR1QvOHA5UVBDazBaOFR6?=
 =?utf-8?B?TVl2d21nbFFtc1FLQWdyV1NDak1QMldpSm9wc28wa29GbHlsZDFqSm0wQVR5?=
 =?utf-8?B?VkdjR2g2a05aQ25ldVRFVGdRYWRrbkpFZVZvNUUvb0Z0UDVIRDFKM2hDZHJP?=
 =?utf-8?B?TnNXMTBINmpsSVdXSTFVUDY5NWhkamRVeGlQZFNzeDAyeWltaDNCcEF6OWto?=
 =?utf-8?B?MzFHUFRmclBwdVB5YllCK3ljTGtDK1g2L2d5WldabWRtYUY1eG45cGZYZ3Fj?=
 =?utf-8?B?b0h0bHp6cHJTUTFEVGMrVk5FLzFWZU9FKzlKNUs4MUdVNG0yQTEvZnN4V2JH?=
 =?utf-8?B?eURLdFlEMlZKQktzeHQ0c1luRU9OU0ZESzQ5VEhFcEZLbGorb1BhdDZuL3B3?=
 =?utf-8?B?ZHhtVFhuWUt3VnBMVStCUHFBWFBIeXpJR3lqOXR4Sm5RNHhNMEFuRXhiY05C?=
 =?utf-8?B?cEZKV2lDVFRHUUdMTzF1dVcvQjllR0xsUGlsekJYSzE3ME9uL2pCbWtRRkE5?=
 =?utf-8?B?eDRQRCtCakRvdVpiOG1hc01YNzl6Snk3VnFZMXp5c2ExSDZxUGJyS2hSazFw?=
 =?utf-8?B?czVsWTc4WWFkK3VlYXdtZ1RwMHdnbmVsbCtMN3RNNkVwTmdYY0l2OU1pRHlO?=
 =?utf-8?B?ZmNFWUxNajk5ZjFDZXNiU2JxaHBiZVcrUmVGTEZiZG5yVVBob21veGc2Ly8x?=
 =?utf-8?B?ckJKQlZLVEVwTS9yMUlYUnQzcTVyaDZGWTZobUoyL1c2MzE4TkNzeFdXTEhk?=
 =?utf-8?B?Mm1ibTE1cE5XdDY3em1CaHJvdEVaRFM4L0pOKzF1M1BZZHczZGR1WEhhR29a?=
 =?utf-8?B?emZVaTQ3cmIycGVNd3ZZSCtLQThFeGo2a3lES2NQcitrdmhGb2xEL3Z2ZlZi?=
 =?utf-8?B?NjZGSExUdDhTemtHRmFxbFZkYXlGK0FqMG1EZmxKUXE2S2k2bHpJNHNqMzh0?=
 =?utf-8?B?YUNvSnZnd01welJDQ0VwUTlPdGovNldveDBpL0lWRkk0R0p5VWl6dzJSQkJ0?=
 =?utf-8?B?eVRyOC8zNzlBOVBiMytoV1dRM29CNWlORE01TUdVV0d2cHpLV05Ib3Jqcit6?=
 =?utf-8?B?cGlPeGVWY3cyUE9oVHVJKyt0YzU1d2h4OFZDaFZsWHhEQzNzcmI5WUJRem9x?=
 =?utf-8?B?bGsxK3lsWGVHOVdqUTMydFlCMHFOWEhsYjBLYlR5bUtGZDVHb2lZOTlMVFQ3?=
 =?utf-8?B?VlovZHR6aWEwUWRrT2VnZEZaekYrYnRMWi94bEx0K0RjTDRRQ2ZOY2NTZGlM?=
 =?utf-8?B?SDhZVWZPdFkyZ0I4Y29EYjhCU3djdWVTdmw5SW1pazU0a2x2YkhiSzRZS0Zl?=
 =?utf-8?B?M3BLd3Y3dnordlNZMi9wUUZyaXVCVkorTnZsU1BNMUE5UHhEZUNMYzRZRUg5?=
 =?utf-8?B?N2NlQVB4cU13MzhXZk9TTzlweWp2Mk9GcUx1am9mcG0vRCtUUjFPS3RBdlAx?=
 =?utf-8?B?VFM0UWx0dUx6VXBQenlQMWxlVkRmd0xRTElYZGlDa1ZTZWpyVXN3OUJYRUpK?=
 =?utf-8?B?KzQrNFh6dytYU2grL2dKZDhIT1FMc2VybHBYNlJhRWJqOEt0eHovdXJnQy93?=
 =?utf-8?B?c0JmU3kwVEw3TXN5cmFHc0RCY3BLT3VYSnBSMDFnSVg1N2VYeDIvMzNiV0R4?=
 =?utf-8?B?alBMTldYOFBZaUcyYm5NTjE3ZlREZUVSUWV6U1Fyak5vekV0ZE1JNE14VUR6?=
 =?utf-8?B?elhCNVZFOGJ5R0FHbUhzbytjczFJWXFwUHE2OXlPeURtYWxQY0xDMHFXMERy?=
 =?utf-8?Q?rq34Fej+b8F+dgqzVFa1EXsBbIQ3uuAOUaz4JBF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1VOTzBpWGFBVXAwa3dTenUwY3lFRC94ZGd5NnhZRVlCaXUvUUF0VTUyQWxC?=
 =?utf-8?B?OXlPdHRrQWNlZzNDelY2dkF5NkVZTUR6ZG53TEVXL1ZyTy8wVW5jS0IrNkEz?=
 =?utf-8?B?dmtMUng4b1dpcEk4ZzM1a2F4SWtyRHNDek4vWFl6YXVONFZVYXcyMWdWQWww?=
 =?utf-8?B?czBrLzFGSHlyOUVRVXNZS1FqSlBTRjV2THFWY011UmVCMlNZTlk2M1Q0eTNS?=
 =?utf-8?B?YWVoVDgvWUR1VW5rRERubnRrZU9iMzdDM1F6OC9haERwbGNQNkI0Tkdnbmpx?=
 =?utf-8?B?eWJnczhWTjcvS1RQSGNReDhrR0w3MWxvZXM5bXgvdmN1UkpSaC9nMzlOeit1?=
 =?utf-8?B?b0toRXNqUnV3V1k0azVlSVRVY1FDa0YxakV5ampNL2JLWTd0Rzg5bW16N2Fr?=
 =?utf-8?B?Q01EQyt3dVVFT0l3TU4yL3QyQ2xsYlVZZkhtYzQzQWpBY2QyamtmMUtPa3BV?=
 =?utf-8?B?ZW9WdHdqVWNTZzBrS01IMXZUSzRHYjh4SFpWeUkzRTd3VkJRNjAxUUpTY2lr?=
 =?utf-8?B?R1NaL1YrS3ZpaTVmejlEV3JIMzdNK1ZleTQwUW9Mc3k5YTVlNnJyV21UWUV5?=
 =?utf-8?B?UGJOT0NqckNqTDE3WEd0TjBheCtLYm1yYUlqUVFZZThqT3lscTlJOFA2NDAv?=
 =?utf-8?B?Z2NBb2hMbVpkK1Q5NVplUHBtOEU0SkVrVWxBbC8weU0wYUVtQ05paG0vTlFG?=
 =?utf-8?B?ek1FZHRNdUtud3I0R0pQYXZpQWNMN0t1S0xqcG80UFpsN0hsd2pjb0VYdFBt?=
 =?utf-8?B?R2M5WGczbWtqQzNpMDArQzJRNndvcGZ6Y29lMG9yUGd5OUR0RnhCTFY0ZDMy?=
 =?utf-8?B?Y0NGZmdBVnNnKzVma2IrVVhlc3A3RFlYeTR2RTVob2duNHBCWE1KV0pHT2cy?=
 =?utf-8?B?a3dkQXRFeHNVWnB2ZEFXa2hlM2FBbHZEQkpQVWw3aXczdnpQZmVTTlRrTkMv?=
 =?utf-8?B?OHJ6b0tnVldhd3o5bnQ3a2loekJKd0UvMTM5aEQ0bUZkTzNnVEc4U3gzcnVR?=
 =?utf-8?B?Q0xKNEJPOVB6d25HeVM4OHRmQ3lZeU13aW9wNW5XeFFNRlUyMjMzZEZIcDJO?=
 =?utf-8?B?RlRLSGhuRmJVenB3ejdoaU1MZGhORWJxSHZ1WEZIRlFMTkR6NytZZms5WnJs?=
 =?utf-8?B?MHNXTXdBaUQyYWJvTEpiWHI3L250WGIrb0xTT3A4RTUzbkpENmpuaTNyZlRD?=
 =?utf-8?B?NUhycjBmSUhEVWZrSkZQTlFkT2pMQ1hwMmhibFZoSlNrVmZBYjlxL2lJM3RP?=
 =?utf-8?B?dENZNzJUWTFaN0h4U0p5SVgyU0FXcUkvTHcwMjgva2NXNUxDdkxURXFHT25H?=
 =?utf-8?B?RDA3NTlWbFVzaXdaVldUbXBkd1E5UEpXVzIrK2lGVTVOSFNWTmlSa0FsanBs?=
 =?utf-8?B?QU90ZU5objRLd2lIQThhaEdZZ0tkZWtZZHJKV0VzZm0ySkNMZjQxVElFMVo3?=
 =?utf-8?B?K21tOUtjSTlURnZxVlNabVgvMEJDVUcvVGdTRWM5WTlIVHpaY3ZBbDJLQUo4?=
 =?utf-8?B?dzlzSU1lZ2I4YldLem1vazdZdG0wSEJjQWV1cTBHSE9idWdVdU0zL3V6ajcw?=
 =?utf-8?B?RmRPYitEMDhvYlRUUUdDUUFOdkUrblM1MnlJWGFZS2MyUFM5OHhHVzlEem1S?=
 =?utf-8?B?blNpSHRJZERjUmJveTBINXo2ekUzMFhVWHhFT1E4NVJWN0hhL21nL2h5QjdO?=
 =?utf-8?B?YU5qMlhHc1lta1dyOUJrN21yR2YzUmdWUVBlNXl0K3Erd0dJaTdZTVF3bnZm?=
 =?utf-8?B?aTdUcFBVYkU2YkJSY2xtS3FlL21aRHRVbXFpUXRkOUM1ekdSd2Ntd2M2QWJi?=
 =?utf-8?B?T2pVQ3VUWmtXNDBNbWJrcEhscDF1d2E3Z0gvNzJRVlA3VzZOL1VEbjVzNzJH?=
 =?utf-8?B?WjJpSmt4RWFaSU4wQ1kxTGF0QnY4RC93YVc3UVYvTE1tZTVhT2JmbDJCNjE1?=
 =?utf-8?B?bnBKQUI4aDhsMWJlT0g0NkZyc2h6SjJmRFNaRnZ5ajdsRjUva0gyL1lyeCtv?=
 =?utf-8?B?N0h0T1NqK3pDY2wxNHIwa1c3am1RMk5ONlQrNEdtdmdIdmVBbEVlcDMzejkv?=
 =?utf-8?B?UkMxOHkrMzVQMmJqWXNwZU5OcVpJWUFkN0RWS2RVNlo3Unh0azdHbDRwSU9z?=
 =?utf-8?B?VldDWVgvYXFNckZLVTZVRk5OZmE2OXJZR2N1VlUrZVl4V1Jkc3B6Zk1KaW82?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304a6cc6-8f0d-4e42-fb7e-08dc967bdbd3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 07:36:29.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDlUIrSTT19gvQRMArmyrfjIYkdWi4k/OQIWLZimCI/HXEj7uhKUWwXzMyHP9hzKTcRnAO3gAdjHze9kLZxNsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9087

On 27.06.24 09:25, Richard Weinberger wrote:
> Am Donnerstag, 27. Juni 2024, 08:29:46 CEST schrieb 'Jan Kiszka' via upstream:
>>> @@ -31,7 +31,7 @@ quiet_cmd_syscall_entries = GEN     $@
>>>  $(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c) FORCE
>>>  	$(call if_changed,syscall_entries)
>>>  
>>> -target += syscall_entries.h
>>> +clean-files += syscall_entries.h
>>
>> target is generally needed to prevent re-executing the build although
>> that target file is already present and recent. Did you check that a
>> second build will not have this problem after that change?
> 
> I thought you want re-executing because of the "FORCE" property.
> Why is FORCE needed then?
> 
> Why doesn't the "default" maineline work?
> e.g. something like that:
> diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
> index 5b4f3214a..e57628cf1 100644
> --- a/kernel/cobalt/posix/Makefile
> +++ b/kernel/cobalt/posix/Makefile
> @@ -26,13 +26,13 @@ xenomai-y :=                \
>  syscall_entries := $(srctree)/$(src)/gen-syscall-entries.sh
>  
>  quiet_cmd_syscall_entries = GEN     $@
> -      cmd_syscall_entries = $(CONFIG_SHELL) '$(syscall_entries)' $(filter-out FORCE,$^) > $@
> +      cmd_syscall_entries = $^ > $@
>  
> -$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c) FORCE
> -       $(call if_changed,syscall_entries)
> -
> -target += syscall_entries.h
> +$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c)
> +       $(call cmd,syscall_entries)
>  
>  $(obj)/syscall.o: $(obj)/syscall_entries.h
>  
> +clean-files    += syscall_entries.h
> +
>  xenomai-$(CONFIG_XENO_ARCH_SYS3264) += compat.o syscall32.o
> 
> LG,
> //richard
> 

"Any target that utilizes if_changed must be listed in $(targets),
otherwise the command line check will fail, and the target will
always be built."

If you find a better pattern, that propose it - but test all the corner
cases of required as well as unneeded rebuilding first.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

