Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1553369
	for <xenomai@lists.linux.dev>; Thu, 15 Feb 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996596; cv=fail; b=H27FQgOcxy5mVoStxztqx9TJvHvzs3qMBPPdCdvbCZRHy1HYAeIgZjtOXLTjahWaPA7yFzaQYUVSMzd05JcmBTu1De6cbTCBkWbhM4Y0PgUaKbwFtOI///rR3IJ5VKDVIXx4LOKUkxmNhuXVuuknhIoa1jG0o5QAuU0CruuOeI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996596; c=relaxed/simple;
	bh=zbEVwMrSmGp8OHX79S/zLgeOmyWA3TqVzKglQE79czM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eAMHFc+Vn1EMO3vct60Lx0YM4mWK9LqBi6Frl/NLUpD8pAncBxyKKWVepBTY8QDXW7AhX2iXZK3NDSEQv3JNWrmbuEJp64a0gUiKyri8gYDgXIioxIKK9loRJth4y87MfDpP7SpCd2movdiIqwRXlG7wYYDCrCAkuJ2lOmK2wdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qHEhm46B; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qHEhm46B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkjlPX0Pes3/9B1PW9OOKgSSvWHCrBWkKGlG0ql6iAlolVPfz45Q4c4vXXRjH7xDgG1WyXRDAkpfx6oSTmYBEl1GJk0RG49amxOHK6Q/KKOwPrq2GqsrMk6OXUoESl3ZfEhR3ZvNB8bLF2dF2KDJ4/RPBNFWsDzX8qz9wL2yhqh2rRJk2YR4ZKmt+dMl5oGsvXQTR1HzIT6BOUqlULsEdfKuxTFZ/qpDOhG7vxYa1NBMCfRFIDXQGi4YVtn6BYehoBULe7MUM3zgxK9PxCqwMk/7WO+balnPXCtGofwqqFGutSQsq3S2thuBIPdlqhGXBjz5K3hx0Y3zJtjHF7yKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzuohw5Q8jAk/gCOGcEYtzgUIQfWHG2Idlv82eENdLQ=;
 b=PXOkAnK78/CZO8plpZcdkWty+X9032IEmFFZCtIbHgGqQW8sHjInDq5UMsrokSaK7yr+Gc0kdUsTPceiGW07f32lxcraNMXgI3WFdcmDRx7JtwqegrMgdTMyxgQtCynyRTw8CLXlvsEgnWfnYS/10qmyhem5YJ+s6q9QKQvSpkPj/QczyeDodN1ZM9vCkVlVS5JU8DXE0LP/4EGjqaXfaYbWpUfQ6wjM1vT5UG0XvFW/7BgDI9M2Z6rkAXX8nAw5HpUDJjcvVth37nrmuY4LGtFoQjXKovR1esA0qZy6/m0+iNifOOww8YZkLTuXFM3M7DKZuH3D1cqrg2y5XT82Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzuohw5Q8jAk/gCOGcEYtzgUIQfWHG2Idlv82eENdLQ=;
 b=qHEhm46BUg+PAwwaBTKuw5O7m6yYf35LN2eI2/DInN9l0apD8HkYr7MVCYa/z9tkjM3Jl228Axll14bm+k7kVeKLv4LOIT17PPWOTfDM/9YR3dspNxBWH+YDwOqVQNlc8t9yr2DLUgUmguTck8Bh/F4DOfG8fiKmPev7tfR0uKzQVSzX/8u8apf8ru971QDvLoe0VFHdB8p7BCOzxAAaqxR6iP6gUil2CEBV9JV5pv2qfhBTBLsw7F0JK8oj0sWGRZjpGJfygDX9p5nuSS3qpEWJKeogRHgVhk51hOsxbM1/9s9C7983qHggouckClMnDz9pnd51uNdfUmPAYqzBGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 11:29:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 11:29:50 +0000
Message-ID: <8296d2ce-9c89-4b6f-ad6f-3d139caecaee@siemens.com>
Date: Thu, 15 Feb 2024 12:29:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add 32-bit compat support for arm64 to xenomai
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:610:58::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a690d5-a309-40a7-3e00-08dc2e196c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KEdL+9VSalukVmIY+HIQq9wpldThUyRB8Soh/2m63AZjehwNI2rNWEJ6YkD+xwJUhDcnEaqon8dxCVxf4/UoZWmZ4C/93lGonSUU1LVA1VpSO759nhqJHMkVTTMZNz8q3x8hx9GgX6CSYfFSKfsOhHMQJ+o+4KxT7GrygcjpRVtny0sMBoV3GMUtwKvnNSZxoJXoJG2AKkWrpMKIWLcVUnRdzEh0GF6SUwz4rR6bNMbU/rm7uk3vZiIZpPjPcbU8671J3uHJ79Xf1f1fujd+w4E3RAoRofKr5roP4ybzkhPyYQMC1EpOeTVtAagRNSj+956pumMgYS24dG5BZTpq6RUnsC9WRS2a/50maOui5KPrdKU+RkMWqm0u+f2Lj5u7cqN2ItPW6VkfSqSK3pD3jHVzzjiW9p+hIvyJgghaHYC+RtKeRndMupm4d3tVkyHJO0leK5/W2/mxJfDhz6dWNaQ1DA+OJrhR/bsXmSRPSdPMmU04fEkY2TiPufmizxveCzYmjXHPMHAg3cC4F1N0ykQHHct+Z/3O7fg6ioqoMn+CpXutNjQBAvN7rOvknBcM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(36756003)(86362001)(31686004)(66556008)(44832011)(66476007)(4326008)(2906002)(8676002)(31696002)(8936002)(83380400001)(66946007)(5660300002)(38100700002)(82960400001)(41300700001)(6512007)(6506007)(53546011)(107886003)(316002)(6666004)(478600001)(26005)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Njk5ajVKc1h5dFcxRkFzRndnZm0wbGIxVXE5RFFqTHpBK2p2Njh3dTJ5bUU0?=
 =?utf-8?B?OUZSRDR1UGZTWllWaURPb3dndlF5THhFQ0x3N3F0NUxZMzVUd1JhOXhkcTlD?=
 =?utf-8?B?WU1ZVXlpOWs3ZlkrRzlwOVMzbHo0SE9IV1VWV1FJQkQyeFE4d0xJSVZzcVRi?=
 =?utf-8?B?ajJNczJDN01ScHIzcThjZTRpRXBSN2NPUmZJUDgvazl4NUFOOVhQTENiS1Rq?=
 =?utf-8?B?UTVXNGRvY2xUVXJwTS9waFNhQytuNGxKcWJ6MDN2MTZOb3B5Q25LdHZ5N2tI?=
 =?utf-8?B?NndLbTNDSXVlMkh4QXFyT3V1L2psSWxOelB6WmhwOTBLaFVtblpRSlpOMHR6?=
 =?utf-8?B?V1BXdjNnYmNCM0lsVDhodjdFM2ZkMVhlUngzUjB6NFhUN0tBeWxVSDdZdmk3?=
 =?utf-8?B?OFpKd3pOZjhBMzlnNnNiRmVKMS9LS3ZWUEJGTGVySHlHNzdmOVRzVjQ2ek1n?=
 =?utf-8?B?aXFaMUhGRllsb3dJS1I5dnhEbXpvMGRJOGY5aUVzeEpaRHpHNW5VZ1FqTU85?=
 =?utf-8?B?UmJmMEtMWlAwK1VGRldFejVoUnhrNFA0Zk5abndLRy82U0x5eWw4eDlKNjNR?=
 =?utf-8?B?cXorcGJrWXZhSTdlVDhJV3lkUGNvQ2plK1ZZNitDdHByYXhwQzhOOWdxUWlN?=
 =?utf-8?B?ZzAzYjZ6MDc5OWE0RDB3UGVNZmZGT3RNcDNYazI0NE9wNkZMbHExdFQ1dGY2?=
 =?utf-8?B?N05zemFDWThvcFY3R0wvcVdhZUZLajRSTS9ENlNmY3BVcGs1UXk4bm5DZ1ht?=
 =?utf-8?B?L0gvRVRZUDJmYTBqVEgwRHB2UjJiZkwyeHNqZU1wb3hVQ1JvYkdtaVU5Vkkz?=
 =?utf-8?B?eU52WTc4bzBFdlFmdmFCZjZDOVFTbGFWdVJqWHh0QmhJaHJnVmNhZXFybmNx?=
 =?utf-8?B?cExqQXhzQmhHb2N0Znc5WjZTZ0M1TnRrRytNSTY5VnFudzNHTk95SnB6QURR?=
 =?utf-8?B?QWNJUTgySU9RZ3hTZS9NdGpIQk82RExMTC9oMzVWUEUwaXJTYU0wdm4veWVN?=
 =?utf-8?B?WHV4aDNHSWU5UkNYSFdUbWlxL0VtQUV3b2RGRXdkUndFTlZESTYyN0VWZG5t?=
 =?utf-8?B?aFNOOTNZWXh2UzdNZVQ3TVpJL3F2RVU1d0kxQldjRnZUc2U5Y1g5MldteHRW?=
 =?utf-8?B?akE5K0t4TFZtblhLN2EyaWpJTjV1bDNiMlJXUytDbjNYNjIrbE9JWTg4VWdG?=
 =?utf-8?B?bHhETlRXMTlFdk5oTm85U3VRakdEdU5Geiszd2RnbHBCRnJjblhzNklWMTBY?=
 =?utf-8?B?N3kvMDBONCt3VVRPNVpjdERJZDlFVTlObnZld2R0OGRxSUcxMkxWRnZ3c3Nq?=
 =?utf-8?B?aXJqNTJGUDdocmpvdlQ3K3BqNUl4QkdhTU42MmtYREYyb0ptRWd6NGtDM1ZT?=
 =?utf-8?B?QUF4bXkyMnE2RzJHZmM4dWtJWjdNM3ZhUWhiMThRMHNuOGR1bTdkWEw4MVRR?=
 =?utf-8?B?Yko0NWVEb3dQMEh0L3gzM3pmQU4zVXFhUVA3MGJaVVpIL3FZUFRQam15dW5G?=
 =?utf-8?B?NXRLZG9qZFExYmhMcmFQK3FCL3o0ZWZMMFZObE1pOFptS1MrTG5yelFCcERR?=
 =?utf-8?B?eWx6MGt6RzRQMmlHdFJ6MWgyR2UrODBtekZvdGRiZlRCeVJ3ejdOWW9ROFM1?=
 =?utf-8?B?a3YwNms3UjJzQ3VDMHY5dnZWTGtTdkdaV1RDLzkzZ2crempmQWZBU0g2M3NX?=
 =?utf-8?B?a2NObHlxRVBqWnhHK1FyTW5KQnNwUjNtdnY2OGdORGlUdnRrQ0t1Z1Z4NmdD?=
 =?utf-8?B?MmNzQXcvSHlZV0dES1YrRU9TQ1UxcHY1V2lKWVNLZFFnRW5iMkpJZUdsb05P?=
 =?utf-8?B?M0JHaEZyaUlQRlgxWWtEcklXWG1pMFpDVU1IZ09kNjJaZzU3YmwrQnJMT0Fy?=
 =?utf-8?B?OXFKY0VJV0VGUDBCNysvcFhpVG5tYVpLR3VwU0djNnc0Y1g0WVRyZXBvOTl2?=
 =?utf-8?B?VURwc2xZSmRaQ21oRkZaUTlCeko2VGNRRXhYZFlQU3BMc24reHp2NzQ1RUlu?=
 =?utf-8?B?ZHFydzByOElneHB0TkVSTm5DOWQ5THRoVEpiRkF6K0x3WUN1bDYzcW5iKzAw?=
 =?utf-8?B?TUZmWEh1dFpBVkZWSjA5K0V5NWY4dHhRV3NjU2ZyNGcraWdwRUpaVXpORmt1?=
 =?utf-8?B?REs0elVWYWdydGowQjhWVGtJeXdJWkZjQUxBc1c4T0ZDdkdmbUhpRlBCWWxO?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a690d5-a309-40a7-3e00-08dc2e196c06
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:29:50.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvmC0ObpW4InjvyuF/atRmDE8/21vGInvfiBZsYQYjEcX4O/nERdamyzgCOzSQqFengX2I4sYjzTl5WxrBPdwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5365

On 14.02.24 17:20, Clara Kowalsky wrote:
> Hi all,
> 
> this is the third version of the series for adding the 32-bit compat
> support for arm64 to xenomai 3. 
> 
> Thank you Jan and Florian for your comments.
> Changes in v3:
> - Squashed patch 2 with old patch 5 "Use syscall_get_arguments()".
> - Cleaned up pipeline_get_syscall_args() and added reasoning.
> 
> Best regards,
> Clara Kowalsky
> 
> 
> Clara Kowalsky (6):
>   compat support: cobalt: Move 32-bit compat files to generic
>   compat support: cobalt/arm: Refactor registers for arm alignment
>   compat support: cobalt/arm64: Add compat support and clean-up
>   compat support: cobalt: Bump ABI revision
>   compat support: lib/cobalt: Fix VFP detection for arm on arm64
>   compat support: cobalt/arm64: Enable compat support for arm64
> 
>  .../kernel/dovetail/pipeline/pipeline.h       |   9 --
>  .../arch/arm/include/asm/xenomai/syscall.h    |  26 ++---
>  .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
>  .../include/asm/xenomai/uapi/abirevision.h    |   1 +
>  .../arm/include/asm/xenomai/uapi/features.h   |   3 +-
>  .../arm/include/asm/xenomai/uapi/syscall.h    |   2 -
>  kernel/cobalt/arch/arm64/Kconfig              |   3 +-
>  .../arch/arm64/include/asm/xenomai/syscall.h  |  10 +-
>  .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
>  .../include/asm/xenomai/uapi/abirevision.h    |  16 +++
>  .../arm64/include/asm/xenomai/uapi/features.h |   3 +-
>  .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
>  .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
>  .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
>  kernel/cobalt/posix/syscall.c                 |  16 +--
>  kernel/cobalt/posix/syscall.h                 |   2 +-
>  kernel/cobalt/trace/cobalt-posix.h            |   4 +-
>  lib/cobalt/arch/arm/features.c                |   5 +
>  .../arch/arm/include/asm/xenomai/syscall.h    |  65 ++++++-----
>  19 files changed, 166 insertions(+), 205 deletions(-)
>  create mode 120000 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abirevision.h
>  delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
>  create mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abirevision.h
>  delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
>  rename kernel/cobalt/{arch/x86/include/asm => include/asm-generic}/xenomai/syscall32-table.h (94%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

