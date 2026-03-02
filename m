Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F832430BAC
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435428; cv=fail; b=PSzZp8KXfOZElJNVXZMYkf4tUHsvLLV+caIXA7+pSOrE0NhS04tR7fCCDUVMW5LR9Nk0jG/i7SAjxTwKpdY4k2gDogNp14y8OcwqyiALcRoLCKkwcHkGx1NuiK/CMunDtoifZGdcu7gycbPcna838YdCqkxvYi5DYPnNtCEOzlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435428; c=relaxed/simple;
	bh=ux8VdJ6E/uhyaRnKLboVUfpA0lXYh6fZ8CbCrDAO/gQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MWPCt4fOdbhmf2PPcM9kU26E66sHJJJDMXoBy9eDAK9VCG2IV6FAtf/EUSAMU+iWpL30A8E0IxE7kCOIQu30729XWKe90TeU7uSoEIgNKjXF0soWw1LR9zJnXnwTrHWmua16BD5j9ZxiAM23hxMlZ/iJtIIkTaN43X9eECnrFiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lxd2HHBD; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lxd2HHBD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQ6H/z7kCp/wAJQfM9QPvgS2rjMCFvs6GirnfCC1w12SPmBJeO2SRKdp184sCHahBi+sTjFI2cOjtk1gAHAjyKvnCPPJMeexDuct7M2EMxaUvLArhhUTc5pipY8yv3GEZZpnX4OovY+EWLdkWSqYWlQwtuoan2cD8/tvvspZUxdGFludNxnlmdRmfxyjaCVwgVkucQBrwLiQk39eHcQBMgeKhCWm42n+dAE5FltPKKCtQKZfcj34K9RHC96AdZiFhocjiGDt7tmAq/0g7kRywny4+9SYD89Zb1yLYIUQXij4HU95OS/tHdXpcVLqPfVulqKvuTxIM9lVp6skTITpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=154ITvtd0mhadqFuWEAmifzRHLqHKmqbraab3pzWFUQ=;
 b=LC14+OFMGNuYYlHAHCdMWvLlMLWxoOJ41bosAhWY/CDxQ2eMMYBRSPndPPIAeiPw2s4KigkF9FkOSrHFedOL1fghiReXkU/qKcyk//kWTqfZ4RCPSQtSirbmHGm+FeOxKwVZ0iJqr0keb772mxrADXSLKAtxohEWcb/EfDOjlfKJejimQtAqSiSYSCtp4cxG6QNvOtvOP7A59FZFKi8sHrolCRQRc4xTaEXWDkv0gXuBtmjDJ+TnihHrpwjuiNZhOUrJ0T5phRXBaC41hs8J5qyjVybLhvRguj4V4QTNKhhq2GVrztg/r2NT6NPqAWO1TGiDK7OZy3Q/uzi/zbzPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=154ITvtd0mhadqFuWEAmifzRHLqHKmqbraab3pzWFUQ=;
 b=Lxd2HHBD2Hw1035BVUxVKdjy6GUbFi47h1VjDZe7gZvgbAO4nCEL3zqSupKENoEaVrIgJOmmGK+PFa+F0RwWGYdboMwWSKECjJgYN9uSZZl5im4ffpoVyPK5AZfuYJtk/jdnOZ/G627NZhsDXhKcgahBWdjIoqZdgju9ivdfdNQ+DxJrLrmMyM3D0E5LyCIo+YtFJljvltk5hHnm3WcYx3/Xw0Uz5WczuoE621DLgXXPjX7DmsEYVLuiU47dMvt2csgTc08WaMLNmUdpx3BA6BLrb++sySeVjx5zssdLNkFTpufHVead+8JPxtJRkqxOjcb+8NCxxvScZ+9EVx27Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 07:10:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:10:23 +0000
Message-ID: <d90d6140-3c8d-4ba8-8c78-77f2435ab708@siemens.com>
Date: Mon, 2 Mar 2026 08:10:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: ptrace-sync: relax breakpoint pattern matching
To: Yuan Wang <yuan1.wang@intel.com>, xenomai@lists.linux.dev
Cc: Junxiao Chang <junxiao.chang@intel.com>
References: <20260302142601.83860-1-yuan1.wang@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260302142601.83860-1-yuan1.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: e20bbf2b-5fa5-4520-9453-08de782ac5ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	G/gW3mDCU5z7uk8w6CVOpwWlKGG3cPvcxnytT6rp2NKnVrBd4BOtRKTFR57Pa9VUVWtejEnswggEyzt72vnmCp0Sfcud/OmDNpcZu+jN2qkpscm//Vf37R0fRJdZC37K2LURC15m3OmVj38k2fJRn5/c25bjYrWvDXide764kEQ2+X7PTKwBqaEaStMBY/z3THyBIgwftqnd03W4yeDNgmosgZxnDHYd14wc8vRjoKwYPTu7g6iBvrWN6wiEKq91mQa9C90lrBDpoFMWeDFqG7gpPXeLitreBD5fdp4djMEz90PCH8qBDwx9CyJbZmKQ/XNqmTTLLlfgS3gDyQxBEqPA71OgjSu38e5uwk88BILFVxYrOCy3GGWQJx3E0W3lcBqzuTZ7ryuP0Dfcsdlk7IWaABl1+FSV7tH8EwtzEKpw/vaV4Kh/SjCMps8jde9bQo6fuYXeJE358IPmvw9WVFeR0rLMxS3BPQtCRnmH5cW3uERlQtgMzor2d7CA0dTC+TLQCCR3OVSTG91doutVK54QlgzmERrobOgezmURilppRrahR2Zv836IO10oJaSTxSOWmbSIl9irg+QA7k7b23NkyjYXDlOJr03PMDcK8eyjkhv5wfNwncRn4hywz9DKNQty96v5OK2Z3VAYP1KBy73mLXtFHe5gRUCY0LlGeqM583zGoep5qiC9DvQHstC5F7Q+RXplVDpG/+bR+vY7EbqfveXojLM0kWuHMF72SHo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFiSFZ4MnVzdzE4eXlVU0lPWG5rN2g4aktoUG84OXNQNXlmZW9LNU1GYno2?=
 =?utf-8?B?aUtiZ0xLem5Pb09KaExzRXNmWWJCY0ZNTnFwWlJhZEtsYnhBK2ZlRnlyVFRj?=
 =?utf-8?B?UjFaNGs4SkJLZWZycHN1QzZYNVdFbjdZNVZ2RzBnQTVaYlpKc1k3NGJKYWRw?=
 =?utf-8?B?S2RWb0V0aHliN0NTeTlCMUJCNmloS1loeWZkUHFQMG40eExqZTZFcjFPbzM5?=
 =?utf-8?B?T2pMZ3ZSVlFBa3JGK0k5MENwMTlwNkJUblFBNGx1M2NjYTZtQk9hYXFpL0l3?=
 =?utf-8?B?b3lzVVN0aEc5b01rckYwQ053dWVpdC92TWl4K0kyditYOFprL1FkMXpwOHdo?=
 =?utf-8?B?VWxxWW1DREwvazlDVndSZTBsVzlGdHVuTDc4K1J1em9qTHlkZTlUZzVJU2wx?=
 =?utf-8?B?cUdCRUxzcE5NRWxja2Rrc05yR1pkeUgvRi92dDdQVDJDOTBGSS80cVJqUFBa?=
 =?utf-8?B?K1NqbVYrUmtNOXVkUlFreGpzemsvcFd1WDFUYStpaW1CNGRCWW5KdlRHSU9O?=
 =?utf-8?B?L3VuQ2xwWHhhajg4USswc2JDZGRoMFQ0M1hUbnNiQTErR0pOcVpXSk8ydzhm?=
 =?utf-8?B?WER3SVdXM1F5TUFFcTMyc1ZTNWdLVkExQVdmM3N4YjBSbmJwZ2xLMnVEcllH?=
 =?utf-8?B?QVRzVXlHRmVXWlZvS3hQWkNYSVE2d1g5K1p6TlcyKzIyK0xkUFRJS0Y3N1dU?=
 =?utf-8?B?QnJhQys5WmZKVkNyR0UxQnE3TnprTUt0VW9RZHh3c0VNSE1VS01qaWkrTGFN?=
 =?utf-8?B?QklLU3RORVVZZnZvUTUyZHBwbmNGaThQWkdVYlBmc0Vib3NxK0NoMkttTldY?=
 =?utf-8?B?VzViQjcwMFg3NW5NRk9yeVhLVW14dXhud0xNd0ZKSUVyUVNBVTV2ZEF1TFJ0?=
 =?utf-8?B?WS9NRy9kcGdvWWREaXVVelM2YjNZbEpGbEFINkkxblNPY2wvWWNQS0k2bDlL?=
 =?utf-8?B?MFVGNFZUekRZS2tEeUM3WmxrbGx3dWRSS1pyWCtMbWVmNEJNdmpUays3eHR2?=
 =?utf-8?B?WU56RnZiV2RwNFU5SHpBeHRuMjBydUplekE0V2ozeFJadmhwV0QzT01hc3pK?=
 =?utf-8?B?dDJwcFpURUVOOWFtaG5wKzF1MjgrMGQ3SFZZVG9sYXMzYWJiVzg5ME4vOG5n?=
 =?utf-8?B?L2tjb1lLdllDa25JbDdUU3FER1B4OEN0SVZiSktpd0J0WTQxK25VWDMxcko1?=
 =?utf-8?B?R3o5MjFFQUl3ZlVUUTNBa29tckFibkkvMXg2T0hNeWtPOUVNRFhKVUxaYmNj?=
 =?utf-8?B?Q0I0V2RPZlpDelhhc0h5TFdIZ1c0bHV6L2RKV1NubWR1SXRMeGM1bEZvZkc1?=
 =?utf-8?B?YnVKVEQ1eGFPL2NjSE9qZUl1WG10QTM1U1Z0NG91MjlabXpMREM2SkZMRWRs?=
 =?utf-8?B?eXJwTTFhTkoxUWMzdVo3eXZPOHNkcTJXUUlER285UDBqRXErTHAxcUxkQjZm?=
 =?utf-8?B?SmxDdGU0TjV6ZzdtOTE4dmgvZWRPdTEyVEZMUVJ6TDZKcWlidE1MRGRLVXlB?=
 =?utf-8?B?OHIrN2NNVGtlaTBNWGIxd05ENEc1WEJ5Q2U1YVRUNkVOcWVhbVRscGt1dVNs?=
 =?utf-8?B?Y0NleXhxRDFCNi8rVG5xN29GL282V293dlJkVDA5Nmx2Sk1waEp0WmQ2eTBY?=
 =?utf-8?B?N1lNbE0vb25XOEE5eHlTWXEvcENHZEZ3dGJyTGJDNmhvVE9NeXVDd1ErRjRB?=
 =?utf-8?B?MSttVm1pMFh6dU1Nc0s1dkRzNW45NGlKU3A2YjhXczhTUVQ0SWxqNnZlc1RY?=
 =?utf-8?B?V2dKSkN5K2VJUkVkcTBMQ0NmMlZzU1pmUVg4S1JmMHczYkdPalhFRVdvL3N3?=
 =?utf-8?B?TllORVJXNlRkaE15RmdFRWlLUERMaGxQNHB0V1gweE9JYXBDY3M1TzdPVEU5?=
 =?utf-8?B?bzREMjF0dmlDWEY0TE5UTDd3Zi9oMXZYYlU5a001WHE5SkVHVG02Wkp3SnZz?=
 =?utf-8?B?TExVVVJPMFlwVllpK0tPSjJpMHVsMmhoSFdveUt0bGhOUCtqcVV1Q0h0TkRU?=
 =?utf-8?B?SHo1SGs2VFM1Q3pxYTNYWXdOWk9yclNBMnBlYitGK3NIcmp3dTNuT2MwM01M?=
 =?utf-8?B?VExIaDd6elJQMWxSdXR6MnZSZ3hsRWpvVDBRc1ZSaC8rY2IxT0NMQnRqTUtD?=
 =?utf-8?B?WFVHYmVneC90NVYrN3Y5SWcrVDBWdG1MZWNmcXZZYzRFQU5NdGxqcGpTTWNZ?=
 =?utf-8?B?N052ZktlcTlWVU1pK2xPZFFIaXRBKzlRdjBHeDV6ZnNaL0lPQWZyblRvVmF6?=
 =?utf-8?B?Y3dNL2g4RXVJWXBMcDA2Uk4rdWJ6SzJQbmZnOXdmMTdFSW1BVG92cllCbzJP?=
 =?utf-8?B?TEpRZmVSYTNWM216djE5SzB1K0o5eW1YdHkxVHlVSzZCOVN0cDR1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20bbf2b-5fa5-4520-9453-08de782ac5ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:10:23.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPp39SstRwHvHfVGnHDjAT4GjJmFNWJrG8RDsIJTN06lybF5aV+SlXw+M8m5KF6vchVu7tuTV7vd3zQQRqtU3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5923

On 02.03.26 15:26, Yuan Wang wrote:
> In some OS distributions, the gdb output of the break instruction
> doesn't contain the function name where the breakpoint is set. This
> is observed on Ubuntu 22.04.5. with GNU gdb
> (Ubuntu 12.1-0ubuntu1~22.04.2) 12.1., causing pattern matching
> failures and subsequent test failures.
> 
> Remove the ": bp\." suffix requirement to make the pattern
> more robust across different gdb versions and configurations.
> 
> The original failed log (run with -v) -
> 
> "
> -> {{ "b bp" }}
> EXPECT {{ ^Breakpoint 1 at .*: bp\.}}
> <- {{ "Breakpoint 1 at 0x28b9: file ../tests/ptrace-sync.c, line 59." }}

I guess the difference comes from this toolchain compiling bp into a
single function, rather than 3 inline spots like gcc-4 of Debian is
generating.

> <- {{ "(gdb)" }}
> 
> <timeout waiting for gdb>
> "
> 
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  tests/ptrace-sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ptrace-sync.c b/tests/ptrace-sync.c
> index 4c56e73..556c7a6 100644
> --- a/tests/ptrace-sync.c
> +++ b/tests/ptrace-sync.c
> @@ -147,7 +147,7 @@ static struct dialog {
>  	{ "^Reading symbols from .*", "set prompt (gdb)\\n" },
>  	{ ".*(gdb).*", "set env __EVL_DEBUGGEE__=1" },
>  	{ "(gdb)", "b bp" },
> -	{ "^Breakpoint 1 at .*: bp\\.", "r" },
> +	{ "^Breakpoint 1 at .*", "r" },
>  	{ "^Thread 1 .* hit Breakpoint 1.*, bp ().*", "c" },
>  	{ "^Thread 3 .* hit Breakpoint 1.*, bp ().*", "c" },
>  	{ "^Thread 2 .* hit Breakpoint 1.*, bp ().*", "c" },

Maybe you could tag the target repo in future submissions, e.g. like this:

[PATCH libevl] ...

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
