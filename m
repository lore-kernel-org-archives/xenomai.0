Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B0C318B9D
	for <xenomai@lists.linux.dev>; Thu, 28 May 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956606; cv=fail; b=FF/UNWwH/s208UOnstgiETp4us0AYGzEfnzeplSydaKwKMjoH8Xw8Crk53zsLUFEVoxOnNMJM7SuKWjNpOldoR44c7Xcg+R//BYko/Vzi02qewz8QS8rlRBYArzTvELe9dsCUORqtXOwBJTDp1w3Kp1gsU9OSLlNL9Jf8jXGzv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956606; c=relaxed/simple;
	bh=m5tg7iu1tl1WRjJ2O7rGuKBxyLfpIXVVHq3JBszoTGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuvorSnjyjMkRHWWCkf6YrgTbooEjXpaqGjTqPUyAcQpBt7V3Ns/el+OERToRmf6lTcxudDIrEokfxpfzYPB1/gXk4NeQ+1eMnMOKSJ3SA2ATkliCJksORuPpZhZrMYCwPHHj3OuR+1aO0+mruiOzaJFV0GIEEplW1FKmlEw+OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uaQIJcFw; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uaQIJcFw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfLUUevLDhKfr0XKgtkWpEi5IG9V6Dg1+NUXbkgCiHn19XXiCyXPg10h+Bz1Ff/X5gz9BYbbslYJuq4DBeOE/PuNLDn+fQy7C8NgcIq5jqofm6DWTml33+hVTRCB3HvDf+DULuidZ1CaMnwTItTvILVJmEIGvFeQwuJuNvXrEzRf7BFDOn4rMcVefD0+6xVISk4Id1IhdkdLkuH8Wl+WkMI9cX2yPOY4zkbT5TzZwatvQv4rwn72lEgs4lLZ4GWLCMakYgpX6oi1ECGUoXbttIhNpK0+btBOT+XWnRT/Gf4gRYHC7/Wj7Ca/88W7GofmO5z1WTk+uagfymB/44hrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75i3qBaUXBleue6u3HdpQgkCdx5MJQZ8kI01JfOIOr4=;
 b=AGqROQDI58/gQAhSFgH3u/vn17WujDsNDqGNR/LzSRCUmQdnGXgDl5QVa5mNKfcACyFYaeU/4JPgNe7v46wbMe8O+eJocvwiH/N2T3DjKGr4/qLOl2UBfM/2xL3r/K9ti2J9Px5+FqSiNai6b64rrpKogStXv4iaHorzM7Bo8e4xS4eOTdVpBjj/LiPLMMC8B0QnK7Mah225LjBmkkTHSrJQGZE+lYM8xDv3HILytUM8lQO5y/aTV0GTXyaxCiX/opfVBPMb8z4Zzco3xroeKsfxEJgzCJmpaRqZ3Ibz01MizhQqM5c+2FBXZTGJXnVPnpf1deNAalH/Wus17lHVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75i3qBaUXBleue6u3HdpQgkCdx5MJQZ8kI01JfOIOr4=;
 b=uaQIJcFwX8Td2mb+jIbJjf2Ic2wat28NZ3+ZQwadXwrTBKO2dWrRG8ZjmTezzzQm+8E5ODUTeXhx51TfjFn6I4C0cMesWD0nHbo+SFCTA2pW+QknBhaL4KsWc6y7iaIEvqVl/55kPOQPIrTm9vAIATx1atdPwIN+V3ysC+RPbxRc6qkiCJKeTFH0N5wJ7OrsFLTIFRob4rI6X+OuDpAuodIQa2FkZYlYkXusvjOb/xD4wJ/AIaTTQhSEYO1XUMYMq3KcOVGbHIbcAl+gUQHMPXVjUSV+QcCUgudHBAV6BJmI4JrexNyMzl25o+w7mBHOhvfaVsXmpV6O2d8Qm0dd3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB5442.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:23:18 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 08:23:18 +0000
Message-ID: <a3c33da9-d717-458f-a124-f276a9bafb3d@siemens.com>
Date: Thu, 28 May 2026 10:23:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v7 11/11] riscv: dovetail: add core support
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
 <20260430111101.1539377-12-tobias.schaffner@siemens.com>
 <2c2db565533aa453c6099704580825aa5cce81e3.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <2c2db565533aa453c6099704580825aa5cce81e3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f11f6b-2218-4bca-f6f2-08debc925f75
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info:
	8xjoxLIsOKH4qdiBb+MiGaTwkjr6iQypP8DXJk0AefPaNabo7KCRzUVXwFbMnSicjGCsYtCSiTCOEbuSH6MJu3jvkHBhfqP90VizMkqm8txHlCOClRm/P2XkssIwq1TfY0Lf3Ixc2G+l/ohRjLVw2z/Kp0GDdJ60oJZ9u+hARsywQJXrliQEZgiJLvEMXrSjvPnQYb5xg5FeWE8X9M7PTGEKi0yp2XUNGMoR1tUdb/TVC0+rwBIRTq/MdhNz0li2tnrEys3vGk2c1pcSDr1v2pLVIs2FEXWWm8mtxf541kQruZ/I07AOkWm06Z7WMP0pPME+Qq5hVFWKwrNhnvYP4B4sUUi7ojxE5eNfhgUCJywdC3KyZuI28Z0Jn5xKm0jn6ClJ/5IoUjPvESYNgqI64jg5Dpp6fpBB3QGv+PbDla/v/yQPmUAhy3XZupLy0W0A6IiEvRthPvFoWnzqQvxVBtUYep7cZIyqesftSvRGD1zuNEmB7wRgexQTEoiBm/oywOSQx7rnPQRWCiA39MZPV18SUdDSsxasLn/yCGlfBsBfIBZtHymCpD7Eqn4KCsfofN70yqw55UGCRxN+TYbRNuP5K7sncnhMRTZDuIuw6OpMfrzvLiOmPqgtma0OhQikXCCorck9DzZ6rOhh4J4geTNse7UI3Z1jRCWrTLheJd3GeFB84oe1cYgxEXP7bBy9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEQ1SVgyWVprdWpnTThoUWdlMDRMbC81cmcwWnZ6aWVzREk4V3MyK3ZLNTMz?=
 =?utf-8?B?aVhJR0pWVXJMUmlaQVpMNkR0RVRWT0dYM1AwV0Z2M0NuVys5QmFyUGV6OTY2?=
 =?utf-8?B?ZEpnd2F4VlNLKzVyQ1hBV3ZqdlZhaEZJQVhtdEErQmg3SURKNHEwcG9aREph?=
 =?utf-8?B?aVNRcDh6bmpNbFZMTjNrR0M4Z3lQOUFEdlZFblZCZ3RxbGk3eDFkM21zWDFN?=
 =?utf-8?B?Vk5FNWxlcnRVRE9MVDZFYzlGL05vUThjUCtzekhadzRaTVR6dTBHZG1XSFlR?=
 =?utf-8?B?dEk0UDhOblBBU092SDdJazE4RDdPTlhaS21ZTEFJQ2c3VFpBUXBvWFJBVmVJ?=
 =?utf-8?B?SmhRWEF0YnVoK2gzaVh0Y2pYWkhtcS9nSzVUb3NLYm9yV3hneEZtSk1VbnNv?=
 =?utf-8?B?YUp3dzk2ZnB3bHRVS292S0swRVZLckM0Ym1lbzNXTGgzcy9jODMrR0QvSU44?=
 =?utf-8?B?R01mU0RLeTkyWnJvRk5iRmgvRkJhYVJ3Q0kyR1ZXYThyRzc5bTVZcHpSeXd5?=
 =?utf-8?B?WFhEMFVzcGZ6S0U0QzhNQmJKUmdqOXdiZ2phZkZaQlNkYTQ5UkVnUUhLN3Ba?=
 =?utf-8?B?eStyYnl4ZklpUDgzdmJyOVFkUWtURGVhT3BLWDR0Z0hxckZmYktkcW56NjFK?=
 =?utf-8?B?bkdXcGJGbXVvR2tpdUVQcmczcHhlVHhTc3ZGN0tsQVBIaUFGNFhTU0ZWWU1P?=
 =?utf-8?B?NGZ4V1UwQ0xqaGJnWk5aMlpLa1VNZUdIVGExeW9uSmNiKzA2M3hrem5Td3pq?=
 =?utf-8?B?UG4wOEF5TnU3Z01PQmxHd2tTMVhNcDdOdXptTExTVkg4blpyL2Y1UVlUWUlK?=
 =?utf-8?B?OURDYzVLcDh1UUFCbzM5NGZ5c3VlUFhYN3dCQXdkSzRnSTlUcUdpV2ZqL1Vj?=
 =?utf-8?B?dTdYMllRb2s3Z0diRnZoSFliS1g2V3pxRklVelZGYURvc09GM05DTjFqSUoy?=
 =?utf-8?B?KzBORjdDc29RNnorNXhMK3V1Smk0WHZkZFdJZ09WcUhWZk5PcFduaTlUeEVz?=
 =?utf-8?B?R1piTS80N3dSNUNXU3JobmNMa2IrNnU0Zzd5NFBlS29ZUDRobE9mL01ZY2dX?=
 =?utf-8?B?aEdqYnhEOWR4RG5FL1dQTVptc2Zwb0toaCtuV3RaQi9vcEwyYzFFWVJVaGsw?=
 =?utf-8?B?S2tsQW5NUU9LTm10RHp3eDZrakRuaVMxRW1OdGhWZFAxWkVOSEVsWHJPUzhK?=
 =?utf-8?B?b0NMUGt6bERyMFBkRFRCWFdQNzZLdHBWR2p6WWZFMUQ1ZTRqQ3hVZWtYZkRq?=
 =?utf-8?B?YjgvbUlsQ1UyWUtMUHVhd1lzTEFmWHRPeTg2MWoxeFV3cFJ2cmxldXBkZWdh?=
 =?utf-8?B?RWV6bUY2Qi9wWHBMYWF6QTdORmRGZm00T1pML25Eb0h1VjNLY2plaFlSRFFj?=
 =?utf-8?B?Ri9PUlI3a204YjcvNi9GUXhObFl2WG53UC9MemoxME1tcEpydUdFcUUwcktX?=
 =?utf-8?B?b1pTVjlpVHY2a0hxeTdNbU1UQ1hRZnkxb2JCaVM0UE40dW5rRk1Qa2tXL1JQ?=
 =?utf-8?B?bWN2MW42L0pwbFJZY29xYzBIYWwxR0ZKRXM2VmVEd0FvRCsrS3VFMm8xbmVq?=
 =?utf-8?B?NE44WDUwKzRNbVl0blpQV3RTUG8vSnlqRzRiYkMzakZQNWJ6V3dkRG1IL0ox?=
 =?utf-8?B?OXhOeTFJZ3AvKy9GVFFDdXVhallId0VkakdpNWpoZHo5cjdMRUd4V3h6WWp3?=
 =?utf-8?B?VS95eXJlSldTYmtYc3l5bFRKdTE1emxUL2kwc2xaQlVrMGFjNWxuSlB1anM5?=
 =?utf-8?B?cEdBZlB1N0kwT0RwZ29BNHdWb2g1Y01DalBRNzZpMElJUFE3Y09JTUFpR09o?=
 =?utf-8?B?cXpnNmhYYVdoZW9UdmdyYXp1YXJ1TDM1VlVqUGp1cURJM0poeFdNMWRMTWdv?=
 =?utf-8?B?VXZwS1N0ZDU4VEQvOW9nbXM2NEs4YzNiVnlzamUrMjZ5SzlkR3IzK2ZyYnly?=
 =?utf-8?B?L0E1V3R6TEdNemlyb3FqT09PVEhIV0djYmhSVUR6aG9kQTl5b0F5SHg4UFFi?=
 =?utf-8?B?cDk0bkcxQ2s1WllYQ0dEVjV5Zk52OGthUGdYV3dWclBYUjVIdmRCOHpPbXBF?=
 =?utf-8?B?ZVF6WUNtczNPOXgxTUIzbEYrS1ZvSTM5SVBLczM2SHMvSm8yaXhIOVN0b0l5?=
 =?utf-8?B?TXhBT0F4NkFhdkppSC9kVG04M1pYUVpkQUZLVk1sYXJ0YWc4TTZ6ZnQrTHV3?=
 =?utf-8?B?WXJGK3hlYkcweTY1OTBxdDlPT0loVUFlQmhIR3BHMWlwYWpNMnN1cWhoSzV1?=
 =?utf-8?B?ZXgwbUpMelhCZHVDUXFYVEJKNlVSaGdyeDJJSzNtcWZMZTJtNFZuemxYcXNV?=
 =?utf-8?B?bW96QXRPMzFmQS8yOFlpdUtMOTRIRDNGZ1JKR2xGU0RtQ0MxbVg5Y3R6VDk5?=
 =?utf-8?Q?S4d4N8ptGH7R8yLU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f11f6b-2218-4bca-f6f2-08debc925f75
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:23:18.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBoXWvtkIl9bZjE7E0mg5D1a5nlWu3EMsCwbLwy1h5bRmikOOyu39kGMDuSmPVTxndsabVdwlF0k7dKFoHVLpmJh1NovWl3hYHXJRngrMzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5442

Hi Florian,

On 5/28/26 08:39, Florian Bezdeka wrote:
> On Thu, 2026-04-30 at 13:11 +0200, Tobias Schaffner wrote:
>> Add Dovetail co-kernel support for RISC-V, including, irq pipeline
>> integration, out-of-band aware trap handling and memory management.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   arch/riscv/Kconfig                   |   2 +
>>   arch/riscv/include/asm/dovetail.h    |  23 ++++++
>>   arch/riscv/include/asm/mmu_context.h |   2 +
>>   arch/riscv/include/asm/syscall.h     |   6 ++
>>   arch/riscv/include/asm/thread_info.h |   8 +++
>>   arch/riscv/kernel/traps.c            | 102 ++++++++++++++++++++++-----
>>   arch/riscv/mm/context.c              |  20 +++++-
>>   arch/riscv/mm/fault.c                |  28 +++++---
>>   8 files changed, 162 insertions(+), 29 deletions(-)
>>   create mode 100644 arch/riscv/include/asm/dovetail.h
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 0d8291a6c4da5..70ea8457e1f66 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -151,6 +151,7 @@ config RISCV
>>   	select HAVE_ARCH_USERFAULTFD_WP if 64BIT && MMU && USERFAULTFD && RISCV_ISA_SVRSW60T59B
>>   	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
>>   	select HAVE_IRQ_PIPELINE
>> +	select HAVE_DOVETAIL
>>   	select HAVE_ASM_MODVERSIONS
>>   	select HAVE_CONTEXT_TRACKING_USER
>>   	select HAVE_DEBUG_KMEMLEAK
>> @@ -379,6 +380,7 @@ config AS_HAS_OPTION_ARCH
>>   
>>   source "arch/riscv/Kconfig.socs"
>>   source "arch/riscv/Kconfig.errata"
>> +source "kernel/Kconfig.dovetail"
>>   
>>   menu "Platform type"
>>   
>> diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
>> new file mode 100644
>> index 0000000000000..ac08db99f4e92
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/dovetail.h
>> @@ -0,0 +1,23 @@
>> +/*
>> +* SPDX-License-Identifier: GPL-2.0
>> +*
>> +* Copyright (C) 2024-2026 Tobias Schaffner
>> +*/
>> +#ifndef _ASM_RISCV_DOVETAIL_H
>> +#define _ASM_RISCV_DOVETAIL_H
>> +
>> +#if !defined(__ASSEMBLY__)
>> +#ifdef CONFIG_DOVETAIL
>> +
>> +static inline void arch_dovetail_exec_prepare(void)
>> +{ }
>> +
>> +static inline void arch_dovetail_switch_prepare(bool leave_inband)
>> +{ }
>> +
>> +static inline void arch_dovetail_switch_finish(bool enter_inband)
>> +{ }
>> +
>> +#endif /* CONFIG_DOVETAIL */
>> +#endif /* !__ASSEMBLY__ */
>> +#endif /* _ASM_RISCV_DOVETAIL_H */
>> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
>> index dbf27a78df6c8..a1ac9192d51c8 100644
>> --- a/arch/riscv/include/asm/mmu_context.h
>> +++ b/arch/riscv/include/asm/mmu_context.h
>> @@ -15,6 +15,8 @@
>>   
>>   void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>   	struct task_struct *task);
>> +void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
>> +	struct task_struct *task);
>>   
>>   #define activate_mm activate_mm
>>   static inline void activate_mm(struct mm_struct *prev,
>> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
>> index 8067e666a4ca6..12376b54268e0 100644
>> --- a/arch/riscv/include/asm/syscall.h
>> +++ b/arch/riscv/include/asm/syscall.h
>> @@ -117,6 +117,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>>   	return false;
>>   }
>>   
>> +static inline unsigned long syscall_get_arg0(struct task_struct *task,
>> +					     struct pt_regs *regs)
>> +{
>> +	return regs->orig_a0;
>> +}
>> +
>>   asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
>>   
>>   asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> index 8a9e85c6e6316..8153a4f263638 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -41,6 +41,7 @@
>>   
>>   #include <asm/processor.h>
>>   #include <asm/csr.h>
>> +#include <dovetail/thread_info.h>
>>   
>>   /*
>>    * low level task data that entry.S needs immediate access to
>> @@ -80,6 +81,7 @@ struct thread_info {
>>   #ifdef CONFIG_RISCV_USER_CFI
>>   	struct cfi_state	user_cfi_state;
>>   #endif
>> +	struct oob_thread_state oob_state;      /* co-kernel thread state */
>>   };
>>   
>>   #ifdef CONFIG_SHADOW_CALL_STACK
>> @@ -123,6 +125,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>   
>>   #include <asm-generic/thread_info_tif.h>
>>   
>> +#define TIF_MAYDAY			14      /* emergency trap pending */
>> +#define _TIF_MAYDAY			(1 << TIF_MAYDAY)
>> +
>>   #define TIF_32BIT			16	/* compat-mode 32bit process */
>>   #define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to user */
>>   
>> @@ -132,5 +137,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>>    * Local (synchronous) thread flags.
>>    */
>>   #define _TLF_OOB		0x0001
>> +#define _TLF_DOVETAIL		0x0002
>> +#define _TLF_OFFSTAGE		0x0004
>> +#define _TLF_OOBTRAP		0x0008
>>   
>>   #endif /* _ASM_RISCV_THREAD_INFO_H */
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index b37bb5da87c5c..1f7d471457892 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -115,26 +115,47 @@ void die(struct pt_regs *regs, const char *str)
>>   static __always_inline
>>   bool mark_trap_entry(int signo, struct pt_regs *regs)
>>   {
>> +	oob_trap_notify(signo, regs);
>> +
>>   	if (likely(running_inband())) {
>>   		hard_cond_local_irq_enable();
>>   		return true;
>>   	}
>>   
>> +	oob_trap_unwind(signo, regs);
>> +
>>   	return false;
>>   }
>>   
>>   static __always_inline
>>   void mark_trap_exit(int signo, struct pt_regs *regs)
>>   {
>> +	oob_trap_unwind(signo, regs);
>>   	hard_cond_local_irq_disable();
>>   }
>>   
>> -void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>> +static __always_inline
>> +bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
>>   {
>> -	struct task_struct *tsk = current;
>> +	oob_trap_notify(trapnr, regs);
>>   
>> -	if (!mark_trap_entry(signo, regs))
>> -		return;
>> +	if (running_oob()) {
>> +		oob_trap_unwind(trapnr, regs);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
> 
> I think that it should be possible to merge mark_trap_{entry,exit}_raw()
> with the non-raw variant, so that only mark_trap_{entry,exit} would
> stay.
> 
> The _raw variant is used for traps over kernel-, while non-raw is used
> for traps over user-space.
> 
> We could check for user_mode() and handle that within one function.
> 
> But: See do_trap_break(), break point handling.

I think you're right. Now that we do the hard irq enable/disablement 
anyways when comming from user mode, we should be able to merge this 
entirely.

I'll do some testing and create a v8.

>> +
>> +static __always_inline
>> +void mark_trap_exit_raw(int trapnr, struct pt_regs *regs)
>> +{
>> +	oob_trap_unwind(trapnr, regs);
>> +}
>> +
>> +static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsigned long addr)
>> +{
>> +	struct task_struct *tsk = current;
>>   
>>   	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>>   	    && printk_ratelimit()) {
>> @@ -147,6 +168,14 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>>   	}
>>   
>>   	force_sig_fault(signo, code, (void __user *)addr);
>> +}
>> +
>> +void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>> +{
>> +	if(!mark_trap_entry(signo, regs))
>> +		return;
>> +
>> +	do_trap_raw(regs, signo, code, addr);
>>   
>>   	mark_trap_exit(signo, regs);
>>   }
>> @@ -157,7 +186,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>>   	current->thread.bad_cause = regs->cause;
>>   
>>   	if (user_mode(regs)) {
>> -		do_trap(regs, signo, code, addr);
>> +		do_trap_raw(regs, signo, code, addr);
>>   	} else {
>>   		/*
>>   		 * Dovetail: If we trapped from kernel space, either
>> @@ -175,37 +204,46 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>>   #else
>>   #define __trap_section noinstr
>>   #endif
>> -#define DO_ERROR_INFO(name, signo, code, str)					\
>> +#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
>>   asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
>>   {										\
>>   	if (user_mode(regs)) {							\
>> +		if(!mark_trap_entry(trapnr, regs))				\
>> +			return;							\
>>   		irqentry_enter_from_user_mode(regs);				\
>>   		local_irq_enable();						\
>>   		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
>>   		local_irq_disable();						\
>>   		irqentry_exit_to_user_mode(regs);				\
>> +		mark_trap_exit(trapnr, regs);					\
>>   	} else {								\
>> +		if(!mark_trap_entry_raw(trapnr, regs))				\
>> +			return;							\
>>   		int stalled = test_and_stall_inband_nocheck();			\
>>   		irqentry_state_t state = irqentry_nmi_enter(regs);		\
>>   		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
>>   		irqentry_nmi_exit(regs, state);					\
>>   		if (!stalled)							\
>>   			unstall_inband_nocheck();				\
>> +		mark_trap_exit_raw(trapnr, regs);				\
>>   	}									\
>>   }
>>   
>>   DO_ERROR_INFO(do_trap_unknown,
>> -	SIGILL, ILL_ILLTRP, "unknown exception");
>> +	SIGILL, ILL_ILLTRP, "unknown exception", regs->cause);
>>   DO_ERROR_INFO(do_trap_insn_misaligned,
>> -	SIGBUS, BUS_ADRALN, "instruction address misaligned");
>> +	SIGBUS, BUS_ADRALN, "instruction address misaligned", EXC_INST_MISALIGNED);
>>   DO_ERROR_INFO(do_trap_insn_fault,
>> -	SIGSEGV, SEGV_ACCERR, "instruction access fault");
>> +	SIGSEGV, SEGV_ACCERR, "instruction access fault", EXC_INST_ACCESS);
>>   
>>   asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
>>   {
>>   	bool handled;
>>   
>>   	if (user_mode(regs)) {
>> +		if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
>> +			return;
>> +
>>   		irqentry_enter_from_user_mode(regs);
>>   		unstall_inband_nocheck();
>>   		hard_local_irq_enable();
>> @@ -220,7 +258,12 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>>   				      "Oops - illegal instruction");
>>   
>>   		irqentry_exit_to_user_mode(regs);
>> +
>> +		mark_trap_exit(EXC_INST_ILLEGAL, regs);
>>   	} else {
>> +		if(!mark_trap_entry_raw(EXC_INST_ILLEGAL, regs))
>> +			return;
>> +
>>   		int stalled = test_and_stall_inband_nocheck();
>>   		irqentry_state_t state = irqentry_nmi_enter(regs);
>>   
>> @@ -230,11 +273,13 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>>   		irqentry_nmi_exit(regs, state);
>>   		if (!stalled)
>>   			unstall_inband_nocheck();
>> +
>> +		mark_trap_exit_raw(EXC_INST_ILLEGAL, regs);
>>   	}
>>   }
>>   
>>   DO_ERROR_INFO(do_trap_load_fault,
>> -	SIGSEGV, SEGV_ACCERR, "load access fault");
>> +	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
>>   
>>   enum misaligned_access_type {
>>   	MISALIGNED_STORE,
>> @@ -254,15 +299,22 @@ static const struct {
>>   	},
>>   };
>>   
>> -static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
>> +static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type,
>> +			       int trapnr)
>>   {
>>   	irqentry_state_t state;
>>   	int stalled;
>>   
>>   	if (user_mode(regs)) {
>> +		if(!mark_trap_entry(trapnr, regs))
>> +			return;
>> +
>>   		irqentry_enter_from_user_mode(regs);
>>   		local_irq_enable();
>>   	} else {
>> +		if(!mark_trap_entry_raw(trapnr, regs))
>> +			return;
>> +
>>   		stalled = test_and_stall_inband_nocheck();
>>   		state = irqentry_nmi_enter(regs);
>>   	}
>> @@ -274,29 +326,32 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
>>   	if (user_mode(regs)) {
>>   		local_irq_disable();
>>   		irqentry_exit_to_user_mode(regs);
>> +		mark_trap_exit(trapnr, regs);
>>   	} else {
>>   		irqentry_nmi_exit(regs, state);
>>   		if (!stalled)
>>   			unstall_inband_nocheck();
>> +
>> +		mark_trap_exit_raw(trapnr, regs);
>>   	}
>>   }
>>   
>>   asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
>>   {
>> -	do_trap_misaligned(regs, MISALIGNED_LOAD);
>> +	do_trap_misaligned(regs, MISALIGNED_LOAD, EXC_LOAD_MISALIGNED);
>>   }
>>   
>>   asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
>>   {
>> -	do_trap_misaligned(regs, MISALIGNED_STORE);
>> +	do_trap_misaligned(regs, MISALIGNED_STORE, EXC_STORE_MISALIGNED);
>>   }
>>   
>>   DO_ERROR_INFO(do_trap_store_fault,
>> -	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
>> +	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault", EXC_STORE_ACCESS);
>>   DO_ERROR_INFO(do_trap_ecall_s,
>> -	SIGILL, ILL_ILLTRP, "environment call from S-mode");
>> +	SIGILL, ILL_ILLTRP, "environment call from S-mode", EXC_SYSCALL);
>>   DO_ERROR_INFO(do_trap_ecall_m,
>> -	SIGILL, ILL_ILLTRP, "environment call from M-mode");
>> +	SIGILL, ILL_ILLTRP, "environment call from M-mode", EXC_SUPERVISOR_SYSCALL);
>>   
>>   static inline unsigned long get_break_insn_length(unsigned long pc)
>>   {
>> @@ -348,6 +403,9 @@ void handle_break(struct pt_regs *regs)
>>   
>>   asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>>   {
>> +	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
>> +		return;
>> +
>>   	if (user_mode(regs)) {
>>   		irqentry_enter_from_user_mode(regs);
>>   		unstall_inband_nocheck();
>> @@ -369,6 +427,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>>   		if (!stalled)
>>   			unstall_inband_nocheck();
>>   	}
>> +
>> +	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
>>   }
> 
> This is the only trap - or more specific: caller of _raw() - that is
> different. Why?
> 
> All other traps are using _raw() for the kernel- and non-raw for user-
> space part.
> 
>>   
>>   asmlinkage __visible __trap_section  __no_stack_protector
>> @@ -385,6 +445,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
>>   
>>   		syscall = syscall_enter_from_user_mode(regs, syscall);
>>   
>> +		if(dovetailing()) {
>> +			if (syscall == EXIT_SYSCALL_OOB) {
>> +				hard_local_irq_disable();
>> +				return;
>> +			}
>> +			if (syscall == EXIT_SYSCALL_TAIL)
>> +				goto done_inband;
>> +		}
>> +
>>   		add_random_kstack_offset();
>>   
>>   		if (syscall >= 0 && syscall < NR_syscalls) {
>> @@ -404,6 +473,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>>   		 */
>>   		choose_random_kstack_offset(get_random_u16());
>>   
>> +done_inband:
>>   		syscall_exit_to_user_mode(regs);
>>   	} else {
>>   		int stalled = test_and_stall_inband_nocheck();
>> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
>> index 55c20ad1f7444..8f38b4a5eb262 100644
>> --- a/arch/riscv/mm/context.c
>> +++ b/arch/riscv/mm/context.c
>> @@ -25,7 +25,7 @@ static unsigned long num_asids;
>>   
>>   static atomic_long_t current_version;
>>   
>> -static DEFINE_RAW_SPINLOCK(context_lock);
>> +static DEFINE_HARD_SPINLOCK(context_lock);
>>   static cpumask_t context_tlb_flush_pending;
>>   static unsigned long *context_asid_map;
>>   
>> @@ -315,7 +315,7 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
>>   #endif
>>   }
>>   
>> -void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>> +static void do_switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>   	struct task_struct *task)
>>   {
>>   	unsigned int cpu;
>> @@ -336,3 +336,19 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>   
>>   	flush_icache_deferred(next, cpu, task);
>>   }
>> +
>> +void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>> +	struct task_struct *task)
>> +{
>> +	unsigned long flags;
>> +
>> +	protect_inband_mm(flags);
>> +	do_switch_mm(prev, next, task);
>> +	unprotect_inband_mm(flags);
>> +}
>> +
>> +void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
>> +	struct task_struct *task)
>> +{
>> +	do_switch_mm(prev, next, task);
>> +}
>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>> index 885e2f66515e3..32cb7285d6db8 100644
>> --- a/arch/riscv/mm/fault.c
>> +++ b/arch/riscv/mm/fault.c
>> @@ -7,6 +7,7 @@
>>    */
>>   
>>   
>> +#include <linux/preempt.h>
>>   #include <linux/mm.h>
>>   #include <linux/kernel.h>
>>   #include <linux/interrupt.h>
>> @@ -315,8 +316,12 @@ void handle_page_fault(struct pt_regs *regs)
>>   		return;
>>   	}
>>   
>> +	oob_trap_notify(cause, regs);
>> +	if (!running_inband())
>> +		goto out;
>> +
>>   	/* Enable interrupts if they were enabled in the parent context. */
>> -	if (!regs_irqs_disabled(regs) && running_inband())
>> +	if (!regs_irqs_disabled(regs))
>>   		local_irq_enable_full();
>>   
>>   	/*
>> @@ -326,7 +331,7 @@ void handle_page_fault(struct pt_regs *regs)
>>   	if (unlikely(faulthandler_disabled() || !mm)) {
>>   		tsk->thread.bad_cause = cause;
>>   		no_context(regs, addr);
>> -		return;
>> +		goto out;
>>   	}
>>   
>>   	if (user_mode(regs))
>> @@ -334,7 +339,7 @@ void handle_page_fault(struct pt_regs *regs)
>>   
>>   	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM))) {
>>   		if (fixup_exception(regs))
>> -			return;
>> +			goto out;
>>   
>>   		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
>>   	}
>> @@ -357,7 +362,7 @@ void handle_page_fault(struct pt_regs *regs)
>>   		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>>   		tsk->thread.bad_cause = cause;
>>   		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
>> -		return;
>> +		goto out;
>>   	}
>>   
>>   	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
>> @@ -375,7 +380,7 @@ void handle_page_fault(struct pt_regs *regs)
>>   	if (fault_signal_pending(fault, regs)) {
>>   		if (!user_mode(regs))
>>   			no_context(regs, addr);
>> -		return;
>> +		goto out;
>>   	}
>>   lock_mmap:
>>   
>> @@ -384,7 +389,7 @@ void handle_page_fault(struct pt_regs *regs)
>>   	if (unlikely(!vma)) {
>>   		tsk->thread.bad_cause = cause;
>>   		bad_area_nosemaphore(regs, code, addr);
>> -		return;
>> +		goto out;
>>   	}
>>   
>>   	/*
>> @@ -396,7 +401,7 @@ void handle_page_fault(struct pt_regs *regs)
>>   	if (unlikely(access_error(cause, vma))) {
>>   		tsk->thread.bad_cause = cause;
>>   		bad_area(regs, mm, code, addr);
>> -		return;
>> +		goto out;
>>   	}
>>   
>>   	/*
>> @@ -414,12 +419,12 @@ void handle_page_fault(struct pt_regs *regs)
>>   	if (fault_signal_pending(fault, regs)) {
>>   		if (!user_mode(regs))
>>   			no_context(regs, addr);
>> -		return;
>> +		goto out;
>>   	}
>>   
>>   	/* The fault is fully completed (including releasing mmap lock) */
>>   	if (fault & VM_FAULT_COMPLETED)
>> -		return;
>> +		goto out;
>>   
>>   	if (unlikely(fault & VM_FAULT_RETRY)) {
>>   		flags |= FAULT_FLAG_TRIED;
>> @@ -438,7 +443,8 @@ void handle_page_fault(struct pt_regs *regs)
>>   	if (unlikely(fault & VM_FAULT_ERROR)) {
>>   		tsk->thread.bad_cause = cause;
>>   		mm_fault_error(regs, addr, fault);
>> -		return;
>>   	}
>> -	return;
>> +
>> +out:
>> +	oob_trap_unwind(cause, regs);
>>   }
>> -- 
>> 2.43.0

