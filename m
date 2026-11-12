Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794494274;
	b=nQtZ4FKxYUhwGL+2dGIo/h/+KdTFBDOXXUSt7GbrQ8xdXNnxMZ8fUU/w0mFHC8hJWziN
	 1hy/wxiVQrCrv8g+c1uZ9jTZCGyVFQpq9Bhb9Fv/3UW2n2fiy+JNYN9kZKusTHRyFvdu4
	 ueE0PeS2vvqjNoVWl0FMKTEjIOYeGvEpPWJ3x9NOCFPAVWGAIE/K9h1csIMFiwF3QAdA/
	 sUsoRifBvpC4zStLYXbiE9N0aPledOzbLefQnZiUW9yLnd6vEutzH0dA6gN+BdFqbO8M6
	 e0S3xdttPFmsVx5+KSkdi//IDkwaCzslMx3QmM6fgyGfSAnom1kwv7fzCf6sOgfflAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494274;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Mon7I5bJg8cx5CWGztcI/XQSkaXyuk9IyZNHFZZc42k=;
	b=FHL8YM+wac01RpWMuCIN++Pnyg2k6e1FZ56pnP7D3JB4icnIjC20bHFeYBMq8JdlZc8F
	 4lkPXWKFRlQNhx9BdQBXp0x++yY1xFImi5dG7Tj7LGpPJrRf9uOd4wDWOAA2Y2pAcl5Ao
	 TjdWL0AHRokVwT6nXiMn93TS94ae2ZKrLBOlyQjYukOJGnVgphrEGO/vlU51p4YkCfbpj
	 dEqbvejWIayKGs/LCJI6OjJu7lvmzBq8T4F4XWqAenOsizAvZs77785Fs2382fpY94U03
	 Vw2GQSfH6OV4Zv0EiWQAgW8H1wubcJ5Qt0BfqKAdSQiw6XwYhILXUwMBsw4Z2rH3cIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=E3nC78qM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.32
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8C606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=E3nC78qM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTHyNHtDzEoDgmZpB7C5vus4rCZzp8Mj+5buJxoMOxfOSDl5zd0UR8xbNOaVbaj7zc2DYbVLzmVkVwnEvlNckYYUsR/c8xniBSgFjlv2e8rIuQ2SF0h+tkBXK7ao18+pBzSMZgm/Hr6+FLsoYlXo5KQ7wnxqBqPNthcX2p/DFDR4wp6GOA/1z9aawijOhRB4El5l8YyMAaO7nsJieGkYF2MaJOog+vFTdRaOQx3jz8IRayZlBAdknrrkHgR1zEuzQZtViyJoEVB6Lor0mmq4KxCYHfF4G1Uks/fVc0gHQ6Tx+VcmvhX1Nn2dPj57jJE5wwk4+BAThqC1SJVTytDa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mon7I5bJg8cx5CWGztcI/XQSkaXyuk9IyZNHFZZc42k=;
 b=swzFvioB3swU059o735uMZDhzC+M1T7iGGD23gHZuFYCi5y3pZviepllZaLMqV4uuUYvn0fnX7is5p2Y68LhnmdXbdEaJv+XU9hfTX6mhLtj1A086UGJ0kLEpLhc9knxnkfS3xq7VWjtJ5el9iXxrisQ8ybmvePSkpKxBbn//DYNeCPIva3hahXSvAW8TbSBZC+Oi+XtIbI9Eb4zORJXVri1KT6JrcVoVZ+MSna2qzlsb5nnFUqdRtjcy/o4v5TT0OrkOHkO3WvaYHT7U7qbRUuap3fSW83SE9BEeRssm8kY3g1PrCrP/2fEy/hvBbGguoUWDFhqKrstXb3E8toKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mon7I5bJg8cx5CWGztcI/XQSkaXyuk9IyZNHFZZc42k=;
 b=E3nC78qMBAgq4xwJSvCXzNe96ja8eRhauEa+08PKVp1angvG4ipLzXEtkcdYCrEoWoyKOSObqekQgk1Lo6FmIwo6NWoKnRlU9dKAseiQw2xoYdfTuGha5nRlDF+dcy+Nl1s+InQKAIStmD85nlKyh1Tz7/xenmcN5cgNZJsd4dRSLG+vZBjg5daxvmWWzVThowVELSPdhHdKGBJz1Ldyoxr5pTrQ6U5PePm9nMISSewxJHXspA7dgbLaIz1nt7MuCuxx7EEtyTwJDcAbE4Fvj4R4gR7Ymiz8HK+FlH+soPZgjQDtmkABG0Se1FEKd0bSipZizBYEy4QbH8nBzQgCOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI1PR10MB7756.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1cc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Thu, 12 Nov
 2026 14:37:34 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 14:37:34 +0000
Message-ID: <46113f08-c972-48b2-9434-bf2dfb2fbc15@siemens.com>
Date: Thu, 12 Nov 2026 15:37:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH] x86: dovetail: Drop bogus
 local_irq_disable_full from __bad_area_nosemaphore
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <e6cbf1cd-dbf7-44f9-8956-95d010fff9a0@siemens.com>
 <87v76219j8.fsf@xenomai.org>
 <174b3fcf-32ff-4b80-a33e-1c87d0585159@siemens.com>
 <8733t6174d.fsf@xenomai.org>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8733t6174d.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI1PR10MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: eef93aa9-7fd1-4691-d6d9-08df40ca7dc5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|261009223027099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|261021135927099003|261022075727099003|56012099006|261021121427099003|261021123027099003|4143699003|6133799003|10067099003|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hu1PHSN1U9gCB+//SeL6IbDOa8TqrIfpxUhVY/jc/7NiK+BF8nGE7iFbzma6XnZttrz8WBhiGsoQ131JYLdZS73Hys8wdg1mZIggV4jicXSr5UWwmglOLE3HBfS1F9BNVBopPr2v6kIqbLjL4qYEM+dwuqc188RrDpiP1G2EFKH+FUo9JOlmxRwtVS+P8PACUBE9iFjSskwYKvT4V7iaQTvf68bJay6lYWNoCdBc0JU9Ys9PVT2fcZ4H1I1q7xxNVpD07PKJAG8gt5rIhAVq6VPUzEgqvfkgyCYoBO9/lwR/m0rgCjrcaviApYeLHOnhmnakt1sbCGtqihbUT75v2CFBV55RsTuIlV+PWldWV9YMLLbt1PaWgX7Xp7AaLP0YrNjjD3jOmlAYMLlmaXZq+2+g/ckWbDXaD61Ck18ULhJieRm2ObzBihI7Gzxx6dTe5R5fxPXkE8IH0Pu9fa21ya2w9edLx58l8QcofpvoRq3geXYpX7+o6FKzLi1HfuF8FuUbh0JxbRfZmMVH+c9cjv5a8omM0LPlnUdcqvw/t74P+RHJt/GKxUlE75gLDGUeMDRsn4YXzRHsUlkH36P1R1QTCW9XorOXaYqJxpUZ8QX07tsNKedcjXQpZkUUmL+288nYZlRmieknJi9YLXPsCp5QKZqkDBGd1vqHclyj5aY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261009223027099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(261021135927099003)(261022075727099003)(56012099006)(261021121427099003)(261021123027099003)(4143699003)(6133799003)(10067099003)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTdSMjBBWHo4RGpIVXI5d2RMZmtzbFQ3Qmd5V0JBdkRTR0g2V1JKcmNIbE90?=
 =?utf-8?B?KzcvQ3VSOHYxWFdFUFBKaW5Wd0JCYU1EWTN0Um4vc1FwR1BwYUtuV0xoQjJD?=
 =?utf-8?B?ZTgyMTRmTWs4RUI0bGpKVWFLdFlRajcyQ2MxRmU5Rmg0TkdjS1FoYXRrKzRP?=
 =?utf-8?B?aklzYUlvTXg5Z0VrK0Rsbkp5bkJIRGxScGRMZlRqQXF2WmcyQ1VPYlIvOVI2?=
 =?utf-8?B?ajZCeDNKSFNzaXYzZzljRzFZZFRKcjI4WnVTZHFQUnVMNU5PeENEcUhEWXVL?=
 =?utf-8?B?dUw5TWJSM05BNmtlYXRhanpvS1B1WEM5VEVha2xGR3VpVy9yWnBWbmNoYTFt?=
 =?utf-8?B?Sml2aGQxZnlHeGs0Z2l3blkycEQ0ZTZzNDl2ancrYnNFMmlFclNST3dlcEVB?=
 =?utf-8?B?dXI5MWdpLzFZTEFMakN4aXNMQnl1d2hjNjdEWXFGQXI4K2ZTQUFtMGJoKyta?=
 =?utf-8?B?Rmx3eUhYZjZEaE1IbmRXSjFJYXFFRHBxOVlnc2gyaWt1d0pwRkowbk0zdTRn?=
 =?utf-8?B?TGZJaU5IaFZNZHV4YWJERFQ4bGVEYXljczg2YzdWZ1ptWUtQQzhlQUltYzVR?=
 =?utf-8?B?TTVTbWVQckVaL1hPakZMdzVGZkN3S3h3eFA5ZlE2ZStGdnU4WllyUjV6dXRo?=
 =?utf-8?B?azM4N1RQOTZoTlI3Yk5TWjk0L2NYOSsxNHB2dFhINVZDVzFYOVc3RDVTU3I5?=
 =?utf-8?B?eVA0SmNxMk16eVFkOGdqTmFLV1FGSGNvTVRGWkhyWmF4Z0o0TnhFUTFFQWVs?=
 =?utf-8?B?UWJ5WVVUTVpheVVUK1QzZmh1SWRpVk5xQ2dmQVVHWGNmRUZ0YXJGbkt5Y0V6?=
 =?utf-8?B?aStNZnNwMFBjNDV1N1dXNzRJeSswZUYwcFdhbFRzVDFybHh6WWhVcGtwZEU0?=
 =?utf-8?B?QVJqNHNzbWJMSEQzMnliaHFMRmdjN1lSOWU0ZU9udEsvd3kyRHdodmU5VFN1?=
 =?utf-8?B?Tk1KK0lLV2FiL0VsOHpGbGJMZ2FlRmI3dk0xcVNOTkZMT3k4NmtkLzVsKzFz?=
 =?utf-8?B?V3hMeHBqYUp6ZVZVOFRHd3lsSmd5cThpSHUrdDU4ZWlwV0lrNythZlRYL292?=
 =?utf-8?B?eEg0LzNEck9MaEc5VmtPN1JLT05yeWV1ckR0dzlmaGljQS9oc3lGTHhhSm13?=
 =?utf-8?B?Nk5NVkd1SkkrMjVKeXVIWncveGU2YkxOMms4L0QrN1h5eDhQelpOMWZRWEhO?=
 =?utf-8?B?d0owUzl1QVpxdkt1YWc1MWFkRzRPWVFDOWV4N0ZQZUFmRzNkWVQ1UDBSeSs4?=
 =?utf-8?B?VTZqdmxXUGdMc1ZmKzFBUDczbWdCRm83cnVaOHhKSU8xY1ZEdFo0YUNBTHJB?=
 =?utf-8?B?QXRIcmN3RWdwSkpEbWx4OXQ2M3hIOHlxTHdRaytPbW1pN3BZWkVaQmdTcUs4?=
 =?utf-8?B?RWlmY2JDNHQzNlprWjlVSWJXWWIvSkN6dVgzMDBSTlNIYUNFckRXNTBtdEFU?=
 =?utf-8?B?Y3IvZ0t0VmRQdGpJdmlONVdRdlh1dEM0c2ZvcDFBM2tQS2NpdjZVY1A0UmNi?=
 =?utf-8?B?OHROaEhLcHU1MFdNQUJGVGlEUGRvdnR1cnBxeGZXUjR3RGMxNkdyZGxhdnFx?=
 =?utf-8?B?a3J1SkRqUGxBZWdHWmdMZDBadE9JanZNWmJHdHlvMGQ2MmJRcVM2azc3dDgr?=
 =?utf-8?B?NXU0MGRqcXpwelFTdkZjMDZQN2UxWXFUK2dOd1hNNTV5RmdURm9kQkw1QlBo?=
 =?utf-8?B?YW95Z0UvUC9DM0xvRDV3RG9uRnZBaEd2OTB2RGZIek53K1VodWZhUVM2QWdM?=
 =?utf-8?B?aUpsUlFrK0JOaGRFbHFrWGZCTEtQdmVBYWp3eGQvelVxZkJCbWhWYUxTdU5T?=
 =?utf-8?B?MmExVzcrbVM0RWpKRjVUc0JqSXlmQWU3NjFWSUd4bmxoN1hoWXUwQmhVZXAx?=
 =?utf-8?B?WDh3c3pnZmMrM3JiL0xuZDMxRFI2QU81aWdmTmFEdGdCQWYrZGdPK0dnRVhO?=
 =?utf-8?B?aVVOWndtWXhLVHQyZmlJaEYwRE84dVgyZVVDeTg5VzRGT3dQdnJMNWd2WXo4?=
 =?utf-8?B?UUtzQWQwbkJMcy9xUzI5T2pwazhNV3MzT2tNWTkxWHdDSVV0UE1TK0NrVEdO?=
 =?utf-8?B?clNmTi9ETUxUZm1naTFabGMrWVZaTTRkaE5rRGJmYkVReVhRcksyZVRGRGlX?=
 =?utf-8?B?UUxnRlc1aDFGYUdUM1B6VFEza2RwYTJLN0laelZkbzVxK2lLQ1liRlkwU3Jk?=
 =?utf-8?B?MEV2ZGhLYlVkWFZhQksxNk15eEg3VlQvWHN2N3hLVzdUZWx0T3ZPN01NaTE5?=
 =?utf-8?B?N1VNL29ZOFF1R0dJVW1pOVZKdjlDNnhaUzI5eEVUZm9ITHFyQ2xWTE9yL1V0?=
 =?utf-8?B?bFdBSmJ2Yy9JbkRPaHhHakdpTzB6VG9vamM5UVRjMkE4Mmx4N3dYdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef93aa9-7fd1-4691-d6d9-08df40ca7dc5
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:37:34.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfTFuPKBx9l3yvaJsol9oXeN/5gYK2CA3AZgLaDBh2OPbCNGYwoE7yJr8DMbODK6sAreJp3amzeKZviIk8LX3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7756

On 12.11.26 15:01, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 12.11.26 14:09, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> There is no technical reason to disable IRQs here again, neither when
>>>> the IRQ pipeline is enable nor when it is off, which this change also
>>>> causes. We are never passing this point from OOB because of the
>>>> !running_inband check and jump earlier in function. The inband case is
>>>> identical to the !IRQ_PIPELINE case, and that one does not need any
>>>> additional IRQ disabling as well (upstream code path).
>>>>
>>>> The addition was most likely a mismerged during the forward-port from
>>>> 6.18 to 6.19. Remove it.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  arch/x86/mm/fault.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>> index e41ed2092730c..e9a08a5d26e60 100644
>>>> --- a/arch/x86/mm/fault.c
>>>> +++ b/arch/x86/mm/fault.c
>>>> @@ -886,8 +886,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>>>  		force_sig_pkuerr((void __user *)address, pkey);
>>>>  	else
>>>>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>>> -
>>>> -	local_irq_disable_full();
>>>>  out:
>>>>  	oob_trap_unwind(X86_TRAP_PF, regs);
>>>>  }
>>>
>>> When removing such code, replacing it by an assertion like
>>> WARN_ON_ONCE(irqs_pipelined() && !irqs_disabled()) would catch wrong
>>> moves.
>>>
>>
>> IRQs are enabled at the point where local_irq_disable_full was located
>> (-> cond_reenable_irqs_user / local_irq_enable), so this warning would
>> always trigger.
>>
> 
> See my previous answer.
> 

OK, LLM may again help us out of this confusion, it likely found the
source of it:

Before 614da1d3d4cdbd6e41aea06bc97ec15aacff6daf (late in 6.19), there
was indeed a local_irq_disable() at the end of __bad_area_nosemaphore.
But that commit moved it to handle_page_fault() where we also convert it
to cond_disable_irqs(). And that commit was also backported to stable
versions.

So, the current local_irq_disable_full() in 6.19+ became misplaced AND
checking for irqs_disabled() at that point would be premature before
they are actually disabled again in handle_page_fault().

I can try to rephrase the commit message accordingly.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
