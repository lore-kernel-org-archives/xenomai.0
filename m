Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A13E7BC9
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492552; cv=fail; b=oSTP9hunE2f+ifKtAQauFJSKABqR9AKTMHbWTVhnRGTJpDrAcDirlfVFTMCjNOzrg8eChHpclfJfKAGWC5mzdfnzyqCowN9O1RwQiKSr4Ahqqg2xjxqpvW8ck++qNYHW2+estTKG5qdbDvyiILZAgj8Hap145yJKoWyZyXe7gy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492552; c=relaxed/simple;
	bh=rSyMV6qx0nBHJ2tzEC3dPp89ENcqbN7Sgaq555CspUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wz1xqjxJClcUDh44BnxrYtbecurOEMEycKXYWF3lzJouncvvkIlK33qps+Ba3K2E8tEdwlQa/1kQa0xnn80mzpRc/jz9KQB/ZYxycEB/O7o0sMHK8ieaU9Rtnf2X7WEBVBPWt98pWBFStI/rqP0iylVkqSaJJwn+nHa4K4MT8bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WjHwxSBh; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WjHwxSBh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIhQnvBfVyZjPIGLq3vbr2T4zwY00mhy7WztxKSeO5WjB3zQUXXkNZYBwlwmWXk+5Mh6txG0ZmA3ij3eKQ2kIMl0GBFhHaE5nVl1mBnOO6o878hmfyfhfWi7iKjRIPDb2o2FcnPvZzURGR87ZC6sNvdRuksjwpVi7pHJwBZLY1c61r71+NFA7jUQC2oQ7V2JXA2BUpPwBaVCF6x5DH4jVzPHsaR0QFMHuJ79QbnbqTDxFt/olFQITQcVI0zfF8YqKl5bJswBwugwpq1KpRyZi7AY5CQI21ZkoInVP85JYuduHTexAl8M7xq85Ds4oQcx9ir5D7qWdcj+D7WvblzdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGmOuayRpZKBI/eKFzPSsrKtPJrItHq1wDeXfe5+Fx0=;
 b=QPU8nvXa5T7rdIUUvN2B+COYVZ9DTWEqlKHcXBv9ShhtoZoSOSD08NFOT35oZAeRYD2WV2zzBylcbTw8z9uBkz1wN7xriL5MLNTy72RlfQ9n3oXCTVVxoKRh02mpqNU23Wig2SiDSTmR6ILOJag16Qks4rEw7nADDi/GAQLGuu596c1BwlucR/f7Nb3FKdWyTSFNsmNJnX2bt8VP0OkqxhsHqLoPT4llmSu8/HnhTEKuwW/MxSbMGmnJrLoye4x0DlYzc3v484PdtCO9B9IYAF/6VpUg+shewXL6FuMLLGOmujJ7z9oNtXVMnnV8dQ//LLAjd3c+IwITTRlSj52/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGmOuayRpZKBI/eKFzPSsrKtPJrItHq1wDeXfe5+Fx0=;
 b=WjHwxSBhwC7dYZtEoTHwBa9jXs215SSO/EzO01M5adAyv1MJqpEpk+TyCSkJi+vAWRFVBnJ9yDIc6gNW1yOx2I7Ij1RgXndyvX290RSxQTWm4KlPOGr4YifC3/nyTwEA886wK2zNQcLK8g/SpWKTiy1g1sJJU/ZNa0rH5M7+OdxtMHE4tsqiE9nOTYvzgkBGjwasxTHwiASUQF6q6ysYiZG5ZiCObcDgSkaHQV2J0GvY86gtZASdR4RNoQt4M8V4TgQz9ZKMWfWzrVKQy+3eNUZ/V9L0GbZSol8XtQmE7jEwo4reMIqBIQTg7DeAFVFckzRWSETgDwlfswLz5izrWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB6945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 06:35:46 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:35:46 +0000
Message-ID: <0b476df7-81b6-4fe5-861f-8056c62266e6@siemens.com>
Date: Wed, 8 Jul 2026 08:35:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libevl] build: add initial RISC-V support
To: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
Cc: shannmu <shanmu1901@gmail.com>
References: <20251009125736.3520623-1-tobias.schaffner@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <20251009125736.3520623-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ebcad1-a39b-42c8-4ad4-08dedcbb2468
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10070799003|55112099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	qMdqP7Efurqw/esr8IgizFw6INnuYczv3o6V6iR9hQ11KPPBZET74HcStHMtP7Fgtxm2uikG0H8jC+RTnbHPbpTEXLaScMrbVdmECwjEuAxdD+Ra+ODQQySTCCmA01GbwUyqQq4hrx23e8YcHDILJO4hahwyJjyXwZP1tKRp+WZ7HzFvQTw7W3f4uke0xBaQN2CylzhxvpFh0hzN7EDdylLOibProxzsUB3HcA9ONxnOBG7w//JbDA9FswmY8JJQ382vDE/YZBPkcSDlXtHQgU1Y+mp6N+FThs9hhgaUOn5khGK95wBxghOVO8f8Bl53qXdoHbSH7g4AqItZD1/P5gTSXTkSw2M/7o4ouoTyM2zZHHuhA3duYlGbQ3rV85buhmOPXd+b1hO6jf8Kgf+mYiord1MmW7BxLH7JLO7U8+JFNwCZBgmpMUypD5AnhPI5jhk3S+tV/JE4+2YMdrG2k6zVwSExLjwoBI4481MsEfZnYvKgvlN0Z2+Fqu6mTg/bv4+2EUDvfVmExEn2vs1+jyD+vXNrFW1kU8LHsDtPAx7IuVXNkH6wBORXgtRhAkASENVpN259kecth/f1rfoK7Aei04JGeesRTPSGu2HFVuAlzpXP4VTti59Tua4V31/9nVbvez8juNSXuizJ4Pfm4y4BWlQpolW3ZS3uPANUu0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10070799003)(55112099003)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDlqZkE2Z3RZL2M2OXhzbU9heHVrWnZyNjlUeGZjSExrSExTOHhMZ2ZiZjBH?=
 =?utf-8?B?NDRnVVI4TUxzeUY0OERNRG9GOFM2OTI5RVdkNGZvRUNiQ1F1alJWV2ozNnU4?=
 =?utf-8?B?b2Q0Wnp3WU1LZW41c0FWVGRVT3JTM21TbXNRalBud1JYc21vcS9TUDRydVRE?=
 =?utf-8?B?aHdqQTJVT3JoNmxESk1NZlRUT0pqNjRjMXpOMkNKbE1hREhGbTE1VE5CdVQ4?=
 =?utf-8?B?bmVXUVRtc0FITEZvRGlESTFHNVErdks1bkFwdzNvV0oyZU80T0duZHRQVlFn?=
 =?utf-8?B?dmRWbmpwUFJRd011L1IvZFFGRVRNbDRrTStKZVUwOXh0eFB4dzZwdXpJWFpn?=
 =?utf-8?B?N2t0TElsTGdiMnhpRGdFZWZRQnZycjZnZmlDVU82Yk8yaW1NV1R3UHVCSmh0?=
 =?utf-8?B?S2phL3FzNDRmS01JdC9QVmZnYnFEejVZRy9uc0hQV1hMZnVYY1p2UVQzSW41?=
 =?utf-8?B?N3plOXlTV0Jib05sY1VyYjlnalcwUm42VmFVc2tzS3BQTnppNndEVVNRRFIr?=
 =?utf-8?B?SkVnbHFhZ0tCM01NVzhyVU5DeFE1dFU5NEpZczljU01QK3JLZTJCSTlSclVp?=
 =?utf-8?B?NDViUGFMbHZvQmNKd29uYXRZVDhoemQrKzNqc1BzRm9TMUVIMCttS0lPK3Bp?=
 =?utf-8?B?L2ZxdGcrRTBrSWJ6MkZxVXAyck9oTkV3ZlNya093M3BDT0pjQ1R1a3VsdDNs?=
 =?utf-8?B?NXFVdW5FdDhzVkZuZjZMMFNQanR4Y2svUGdrNkxRKzJ2UHZyZ3F0MWIvVnp0?=
 =?utf-8?B?RTdJVUpPcTJXNE9lQ09TWVBpaGg4NVFnTjA5eVhYcWdBOW9FRmxCUENnRU0z?=
 =?utf-8?B?Ri9UVEpzMUtmZ2ltZGVIaFdvZnFjeDdUdjA2eGdJdDAxcXRaV29rMTBEZVho?=
 =?utf-8?B?K0FHT3lUWTNGMWpFenE0TTBHY0IydkN2QnhyTllpNU5GdVZiQ0x3WW96OVpj?=
 =?utf-8?B?LzBsNnB4bXFKRCtySGFiU3J6Q1RZU0V4MjNPY2xVdm5jWGoxVjZMelhOeVJP?=
 =?utf-8?B?TENyWk54VzltVFY1bThQY3BGR05ySUtRSklzdCtMMWJuMUpjVTJ1VDBnZnp1?=
 =?utf-8?B?ZFhHTkcvUlpmS01VblBEVnlhWlpWWm1icENzRTlHU04wN2dJL09UK1RQUVdx?=
 =?utf-8?B?Rk9WREVvblFsSkhJM1l0ZVUvd2N3L3hwaldEU3Q3Y1c5eUFqTW5wSEZRQmpz?=
 =?utf-8?B?c3ovVGhJSVVHWWVDSkpKbll3ZmhvK0ZDNC9zbFY5Sk9PbC95ZWMxV2RmdlJx?=
 =?utf-8?B?LzdMcjFCU3piZGtjQ1U2aEt5NmowbjdZZlJ1RStCY01FSXY2N2tVclpVekxm?=
 =?utf-8?B?SlA5b2kyaUVkRVZQaGMxaFpUdWM1L2pYeHJkKzdjMTRLQ2lFd2lLZXAzZXBh?=
 =?utf-8?B?UlB3TnB6N1pQMWR5ZGgvSHloNkRyZWVwaDVHNXl3aDlRd3BZRXBTazBXLzl6?=
 =?utf-8?B?RCtJV0hZeXZUQXNVTzJRVW5WZTh4M3ZHSzVmblBlVk5FbjBoRlUxU3prZy9G?=
 =?utf-8?B?eXlxbU0xWlVONXBKQzUrOUZ4L2JJL3RHWmJGaUhvVFhKenV6UUl5eEtHQXpC?=
 =?utf-8?B?WFUzNzJXMG1ybDdQOGxtcDdOOWpDTjJqcEU2aS9UcVNqbXRjNjU5OW84LzJ6?=
 =?utf-8?B?dG1iUDdZY1hTYmJpT3ZaMmZyUkdGeHBranltV08zKzl0TnN2S1JmSU0waG50?=
 =?utf-8?B?YnoyN1F1bEZWdEhhZitPUEEzU29PU0w2ckt3RXhtSUVNcnRNTzNlMmF5ZTRk?=
 =?utf-8?B?d0hONGkreWQvMlNwcjdOWWF1LzRvK3M2VWVCcU81QjhuVlk4aSsvUWRVQVpp?=
 =?utf-8?B?RENsTFFyaUdJNVdVeXpDNER0OGUwaWI2L0JJMVdUY0dKQTBIWUR4MjZ1MmpQ?=
 =?utf-8?B?SytlV2Z2QTQ3Rm81M2UvTXdSbGVBMnJxS04xWnpTYTZBdFhjVCs2eDFEZUlK?=
 =?utf-8?B?VDVTM3VlRWg5T3ZpdG0xVEFIaWQrMTBrQTBWK2tFL2JWZFpBK3BrcHNFb3pK?=
 =?utf-8?B?Tk9HTTJqbjcvWWJkQXE5ZlZhWGNBUmlTTFZiQXU1dy9tUUdub2pXNklLT2Z1?=
 =?utf-8?B?VnJXenZSZVRMUXNDSDNSTU42ZmtQNXdDd09pbzJCc1FrYWJRS3hpT05kZ0l1?=
 =?utf-8?B?TXExR0cvSTVHZEhseEc4UWxPQjBTWTcxMWlOMnIzRkpyYlpwZnNtM3h2dGs4?=
 =?utf-8?B?elAzN1Z0K1YyQ1lZQllHUDZoN1BwZXhqSHZUdkZHK2tQdjhJcmlkTi9TVDI1?=
 =?utf-8?B?VWhKVFRkY2xubzRoaUZtL3NOZXRkVzdmaGUwUy9JRk9iN1MrT0NmdnI0QS9N?=
 =?utf-8?B?Y3oxMStGeWNxblZvWXdVc1RDbnlORnhXVVFmbUFEL3J3SlpabW52bmhrbU1K?=
 =?utf-8?Q?aYEAsKNuJHOGmzrlPpQOni/BssEcwXVTPoC4xpoTgeUfV?=
X-MS-Exchange-AntiSpam-MessageData-1: gYaC3yn9o7+GQDbpewTluacHvAmmzrbPdlU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ebcad1-a39b-42c8-4ad4-08dedcbb2468
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:35:46.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlLji0ZIyMwPXRxNBDx/MwqSPpqLfpqdmk6PC3oCtkkpY+mgNB6smCPGbvd9srFiVcqLVXBNiKfvZPouAbMSVBjwZSJKsKAqx5ObHJbSycI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6945

Hi Philippe,

On 10/9/25 14:57, Tobias Schaffner wrote:
> From: shannmu <shanmu1901@gmail.com>
> 
> Provide the basic build infrastructure and VDSO definitions
> required to build libevl on RISC-V.
> 
> Tested-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>

is this ready to get merged apart from a missing Signed-off-by by shanmu?

Best,
Tobias

> ---
>   lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
>   meson.build                           |  4 ++++
>   meson/riscv64-linux-gnu               | 18 ++++++++++++++++++
>   3 files changed, 36 insertions(+)
>   create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h
>   create mode 100644 meson/riscv64-linux-gnu
> 
> diff --git a/lib/arch/riscv/include/asm/evl/vdso.h b/lib/arch/riscv/include/asm/evl/vdso.h
> new file mode 100644
> index 0000000..5e331fb
> --- /dev/null
> +++ b/lib/arch/riscv/include/asm/evl/vdso.h
> @@ -0,0 +1,14 @@
> +/*
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
> + */
> +
> +#ifndef _LIB_EVL_RISCV_VDSO_H
> +#define _LIB_EVL_RISCV_VDSO_H
> +
> +#define __EVL_VDSO_KVERSION "LINUX_4.15"
> +
> +#define __EVL_VDSO_GETTIME "__vdso_clock_gettime"
> +
> +#endif /* !_LIB_EVL_RISCV_VDSO_H */
> diff --git a/meson.build b/meson.build
> index f241daf..038b2f0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -57,6 +57,10 @@ if libevl_arch == 'aarch64'
>       libevl_arch = 'arm64'
>   endif
>   
> +if libevl_arch == 'riscv64'
> +    libevl_arch = 'riscv'
> +endif
> +
>   post_install = find_program('post-install.sh',
>       dirs : libevl_scripts,
>       required : true
> diff --git a/meson/riscv64-linux-gnu b/meson/riscv64-linux-gnu
> new file mode 100644
> index 0000000..6eb3b4e
> --- /dev/null
> +++ b/meson/riscv64-linux-gnu
> @@ -0,0 +1,18 @@
> +[binaries]
> +c = 'riscv64-linux-gnu-gcc'
> +cpp = 'riscv64-linux-gnu-g++'
> +ar = 'riscv64-linux-gnu-ar'
> +strip = 'riscv64-linux-gnu-strip'
> +pkg-config = 'pkg-config'
> +pcap-config = ''
> +
> +[host_machine]
> +system = 'linux'
> +cpu_family = 'riscv64'
> +cpu = 'riscv64'
> +endian = 'little'
> +
> +[properties]
> +platform = 'generic_riscv64'
> +sys_root = '/usr/riscv64-linux-gnu'
> +needs_exe_wrapper = false

