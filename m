Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEF3E51CD
	for <xenomai@lists.linux.dev>; Thu,  5 Mar 2026 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732595; cv=fail; b=X/8D1TxQ+moxL5wKxrKgXNecI+UBzRN0izBISnZXtKEwkjedXRQPM9SNJcwBLuc0dL1TpLli5N2CayMoCdc3h0pOtAFiztAYhEvLccj6zjFLRrct+2qMMen+Wq+2jEpJE2ipJN9InBIAcxtgPeossSmNTAucA7KqpxNH03y+UHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732595; c=relaxed/simple;
	bh=nsTGbGjyAKOzCumBarCC/x8TzHmd/zDuZndF8EVi9IA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O0yjJqkfM+i93FdJCdLE81apuOH3Qh04hngYUPzB3cULThnMSOXD+JWekoPf/DI3VKlSBrsNK6WLRALKPOBSW6lMPWMnr5KrPp4qh+9Zti03t3lK9VgID4NZ6Ca8CfYKiX6qFV2KZLWKvCeL63DIlKzi2WtGhAbEG9UcGI02sp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IYXmKr31; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IYXmKr31"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdYlvA9Y2AMSfTFwKPc2DlnG1y5PHnhJNKNqGgmV9xvaxCV8gYZLHBJz2zMiAP9Y1cNiQE0qfCfwL2LX6FJ5kYgpxUoPgQleQCDZ/8gtA5WiWuu3SYvPnpXHLQqV15FkpW9oyW9zc0jY18bJp6kwSMA8MOxk859gn9/Na3Nxh48wWWSP4CDe4OHnPip+TzcJuqh5RbVOr/6pRuK57ozBKLo6zYcN4qu9jWry7SDEITGu8S2OwKBX0o9jse/I6miBwVDcYn5BVs3lY8gUiEh/+VIJJQl55YEFGLIe04Vjiy2Hk2EElmIb3VRJDJ3Y/mtNRzdD2ttGyaxDBBwi3avKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/FhQmIfODpJ/wIxJwukjMYBp5oBP9vOtGaDwf1Kdkc=;
 b=T+D1lkU8Ebw2qbVfeDbloeWjEjN4TKN/rx0ZYtyg6I1Xp7qOABJJ9W7kFxOBuOXEyb+N6ES22F4mbzpPQsct2shTZ5N5l0z30pEgDMkmfe1iKR+tXH48A9y4bjF2g+3eHyP1phqnlgAO1/becKxKfbW4852M2dH3k5VMky4NII0j6+REGWvQjAhu4WN8M5ZqiXl2ks/PPdyA6UUhaCm9zoX6Gmt0F/sm3dWRsCYdsjKicMambNqIBk8nsb1B4bZd7bpbdwavdIk0UumL3qq8aSRgC7HeLAJknRbzdcK3v8Z2FYccpPVoWiTcGnN1OGDRORPP4d6yynIZ3vXQazM04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/FhQmIfODpJ/wIxJwukjMYBp5oBP9vOtGaDwf1Kdkc=;
 b=IYXmKr31DF43gzuGNyHOGBtg9aNoYL2gOmJxsPuYUNaKCbgIhAzKuve3ub+iEEyDGmgBAjtQvioxSa7JWVYczsPd45l/+Rx0Ip79aefbAEsYK/tnC4t0ZFdg7HuDV6/J/m8Lzag81+p3tEaczm5GBYR0v5gbMOl+jpIfXi7KJN395WiQU4Y5rcJzMLU2t8DH+ox44kGMKpjFhWMFtl+UIZHUdhgpvCyXYSc9mIxvKaf4/j73SE8a/9mELJGL/XM/06zv9S+uaQ9erDCJge7w38KOEBG0JQdqBvbxsv1uQ/HpEYxthZKc8mRk/p6t0hyYO2wKHtrO4Hxxbk3atSuwoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMBPR10MB9904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:75f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 17:43:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 17:43:10 +0000
Message-ID: <60cbd1b8-160f-4a99-8ce4-eef6434b27fb@siemens.com>
Date: Thu, 5 Mar 2026 18:43:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai 3.1 application compatibility with newer kernels
To: davide gandolfi <lasertech@adige.it>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <AM9P195MB08852B8E9DE3958539FA4EABE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
 <AM9P195MB0885C2567A22284ACB34BD1CE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM9P195MB0885C2567A22284ACB34BD1CE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0327.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMBPR10MB9904:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7441c3-0024-40be-9451-08de7adeaafc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	8C0uggAYl6+xdDQG6yqc+Bkr3ccvFpqGcNNM/IzGZ89TeA/TgFu47/JV/82gZVTWrd7lxBIx9Tuxh++Jc4w1RA6LSUZjfhyF7ulsBTIFRERgsD2Y/x9sju76MX78q6D9c3DeeocSiwd0FiuQZD3kVUANuebWUaXOWmVAdIbrut0q+gfGDHtNE1Sc1ps+vCoF4tJAxVyoTKKSQavlCiPEEB3GmTgIncjN9XQNaMKuy89ePqdb/+BWgXqPDclzBI/r05ijoBbbaUoqzZGVAZ5WfipO7YeFsONx9T3K/4otpLH8cuKao8JP++dP5U/c6a9cmQI+903Fgbo5WeMxjyRz+8eKOyMp7RsmigfL49meNsKPKUgK2p1WyT/NQRE2aCI7SnTLpIh5e5ZV3ykSKVMNrX/EdzOMFvBBMpoyg9T+mXLGGp8rXRGl9WoT5kJ/8t5ld0CKcN8GoRptV8HzjyhCd3gadgYcbgyglHuBCeqZMsg7zwkPUfmX1w0wgC/YZccO0mEQSlFttcqpdHeHWxYFEEuA74JW4v1mL0YCYU7ZOHxSLuCMtZVCCTWb/hWwXjfvXwkj4ghWKouDopp+n6N1/VChf2T6zb8CHIKe31IievR0wUIP+E/+16XOrivxqw3B/l3cS7zzmDQXy7E1nDOGPBb9ZlgvDQrFiGLCiGtWhI0fM1dJbbHWj7VW25yNq1DNgEAoeqNXDqwpKJoIDT+Sb+eOPdoWYBWdBku0NMn9Fo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzBMVUxYR2tKSTVBRzArVXArakJZQzNmSmczQ2dBVjZZWUZBL2J1bzF0UGh2?=
 =?utf-8?B?U2JHKzkxbEppK2RhNmljMXJsQWFYUU1aZFVYWUVvS29XMlBsUVFBVVNMcWJL?=
 =?utf-8?B?ckRqelZYNERIa1BjWm1PbnFQRC80eFcxbGFEQlJRcEUzbFp4MmdpOHJ0dlJ4?=
 =?utf-8?B?VDdLWm9qU3BINzJtUGZ4MlljY05XdTA2WHducEJhRGcyWmlUWTZWV2ZpazRY?=
 =?utf-8?B?NjZqbVZDYmJUQ2xLZmY3ZU5oRHUrM082SXJrb3ZtNFpxR1YvdW5JdzlHZ3o4?=
 =?utf-8?B?SktvNk1JUFpCNzlSMzM5NGRqUlQ2UVBuVlVsRm12a25wZzJqaVdNUkU4Skpy?=
 =?utf-8?B?ZTByUldldmQwUWVQc0xJQkJ5SXh0Rm1CYU1jN1VNQ01Bb2FLM1lJSC9RY1Vr?=
 =?utf-8?B?NUtONFU1dTQvS3dYbjRCU05nUTFlUnRyMWl0VDRUcStpOHRwSGIzaHFYOXd5?=
 =?utf-8?B?Sm5PR0tNMjhXQXVTRGlRQUFhNVc0M1lCZ2ZPc2dMK2Z1SlNYN0RKL2FDdVBW?=
 =?utf-8?B?UUFqTWdZc0xPMkhIcDFmTndNdzhNQTNXS293b3hENXIvZVZTZ3VtZ0o1U1Jl?=
 =?utf-8?B?eVBCdnhsRHlwQXZpd1lxMTR6aEwyck5OY2w1QW1kRzZhT2JPdDBEZlF0U1FD?=
 =?utf-8?B?SGJjRlI1YjlWZjZMZFNuU3NSSGRuNHdXeXpxYS82VTVhZ2ZhaVNtMlNScnEw?=
 =?utf-8?B?dTFuWGlIMVFUazZjRldQUTFoMWJXQ1ROMzVkYU9BdjdvSlh1OHFQblVEWEd3?=
 =?utf-8?B?dStwanRHYzdidDd2VmxUejkrMlE1NitDaWVlVDhHRnpMQVBPYk1wTDJobGJF?=
 =?utf-8?B?MklGN2Z0WFNJcld1NG1pNTJWdHVkVFRYc1pteElYek1VaHZnNXowN1YzSFBF?=
 =?utf-8?B?M2llWnVISW9xMEpWYUFybTh0MktheUZkQ0t4dVkzSHhsRTJ1eTQxakFyNFlH?=
 =?utf-8?B?TlA5WlhZVmZnUjF5VEtmZGRGdEVUN0JFdEtxYjhrR1pmMUlKLzNqdjJ1b0RP?=
 =?utf-8?B?U3dhSXhSeDhLeXlDV3pJc29td0g5bVgyckRKSnZyUzhsaGd4WWxxQzJ0N1Jh?=
 =?utf-8?B?S3VjZWp4V0FNeElnM3pEdjhacWV4ZDV1aCtTK3o5aXpBOURlbDFQWVV0RVRp?=
 =?utf-8?B?OVBhWGtFY2paNHJYTDA3Y0JnZ3FUNUFsbVdmZ1ZodDdCV2JtdDdXNVlFU3pa?=
 =?utf-8?B?bGJjWTdXT0NxZndoVDMyZDQ0eU80R0xIOXZSazNQb2RvQkZqeUJKQk9KYjBH?=
 =?utf-8?B?QzNRNEN5bGo3UTI0ZHRQeHBmcWtldjlhYUM2amttNWtrZkNQSUFSRFVSR09P?=
 =?utf-8?B?aEYvSmx1RDdUODNYcWl2Yi83RWhNeUxTMDVQT1BzdDR3SVNaMTlQMktUMkVa?=
 =?utf-8?B?UXBxc3ZCcmd5Uk9mQXR1VDQzV3c2UXR0bjBPUGpiSVhqUVhPYTM3VDYwMThT?=
 =?utf-8?B?LzNmcE80dkVpTy9Eem1Xc3p6STJjRDBXWm1FVmp3MHpjQ2plbXNZTW1zaHNl?=
 =?utf-8?B?bXJaOE9yV0JHRFpuT0JGQmluSmVJdVU0bVIvRXN6Ly9BOFFOOVlnWFlOYXU4?=
 =?utf-8?B?VFNHUXFHNk9VRlpPMU5qcHNOVzJNSXJkdWI2U2dKcGNtdjhuRksxcDE3OExM?=
 =?utf-8?B?cUdPVXp0UUNpSkZYL2t5NkJHQ0lKdVdjN2RWSllhbVJDa0lRN0JuVVRadDFo?=
 =?utf-8?B?cUY4VDA4V0FoNS9wS0hibUg4MHJ0Q3lJOU12TnRjNGxaRVIyTmNiTUdYLy9t?=
 =?utf-8?B?SlYwTTJ1L1g0eDdGZ2JnTTdvelAzNzFML1FPcVRaZ0VvUWt6TWhNNmVBVnhn?=
 =?utf-8?B?MXRyQWt0YWJBMDM4ZmZjblphdDVPWE40b3Vpb3ZXQUpMb3o0L3YzVHlURUNr?=
 =?utf-8?B?dUQzdnZVU1ZNcUhDK2FsREJzQ3VaUSthTHVLRStsTmZQblRqT0gwdnR0MzYr?=
 =?utf-8?B?QzN0MDI4aTFLZS9FRzNrTmdycytKSGNDUkV0ekQzeGxsci9YR1ArcEhtamxY?=
 =?utf-8?B?d1pOdGMvait3cmh0TmVYVUs5R2NKWEdybzluQ1JCOGtxTWg0dlZsTG1reTlV?=
 =?utf-8?B?dzdvKytwQ1ByUWRaYWdnc3NJcmM0UnU4NG5tTzZLNkVVRFZHcWtPOFRHZitX?=
 =?utf-8?B?TlVFdzJabWhHandFWm5Hd2RleHNVV3hsL0JqMlFHNTlXdjlNWWY1d3JPdVNG?=
 =?utf-8?B?eXZHd2VCek1TZjJTdTZNUGFkcmhKZWNLWERySktydDBiNHE1dHpDLzNyZDFV?=
 =?utf-8?B?ZDNRcXFFRzBqWHAvdC9SV3RJVVBkdFY1VUxjOUx5RFI4MUV0YlVHNzJmS3Ar?=
 =?utf-8?B?ZnJ4TjNHUlJrazlUUERzNTV4bXVXQm1uWmlrcXRaUElpMkFZdkRvemsyTnk4?=
 =?utf-8?Q?qUHTC0m6wy61ZkxI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7441c3-0024-40be-9451-08de7adeaafc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:43:10.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMJprrF9SDK+v566LiWrBXN7Q4zQInLHzLN3VzeMdHtHs6sw4LqN7NaJFB9dRHXNZzr9+kI4Rb1qU5ZxAUZM6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9904

On 05.03.26 18:33, davide gandolfi wrote:
> Dear community,
> 
> I have an application (a library) that is linked against Xenomai 3.1 (I bet using the Posix skin), and runs fine with kernel 4.19.114-cip24. In particular, it uses RtNet drivers.
> Now I need to update the hardware, and most solutions on the market have newer cpus not supported by that kernel. What are my best options?
> 
> On the ipipe-x86 repository, I see that kernel 5.4 is supported, but it is not clear to me if Xenomai 3.1 supports it.

We stopped testing against 5.4, but 3.1 used to support it.

> Moreover, 5.4 is still too old for Alder Lake or newer processors.
> Then, we have the dovetail repository, which is the most updated, but I think it does not fit with Xenomai 3.1, am I correct?

Correct, you need 3.2 at least for dovetail-based kernels.

> Lastly, I could update Xenomai to 3.3.x and use the latest dovetail kernel. This is what I did and the system works fine with basic tests (like "latency"), but works horribly with my old library.
> In particular, I have several spurious relaxes and mode switches on the thread that, I guess, is responsible of calling the RtNet driver (not 100% sure on that because the library is closed source). 

You can use system-level tracing (trace-cmd & Co.) to understand at
least from the kernel perspective what is going on, e.g. which syscalls
are issued or what other reasons there are for relaxes.

> 
> What are your thoughts? Is it expected that the API, in particular for RtNet, changed from Xenomai 3.1 to 3.3? Please note that I don't have any segmentation fault or crash, the application seems to work fine, just not "realtime". Shall I expect better compatibility if using Xenomai 3.2 or it is not worth trying?

I would not expect the issue in RTnet, specifically as that code barely
changed in the past releases. But let's collect the real reasons first
(see above) before speculating about them further.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
