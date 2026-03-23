Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4F3C141D
	for <xenomai@lists.linux.dev>; Mon, 23 Mar 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286233; cv=fail; b=iMJ3AWiQwtEetQCCiOf8MThlwRr7O3DmpwDc+VUm0gyvSShb/s8Kfr/QVah+D+cXduUcghLclKppDIgYEBmJ0Scj78RwrPL6/DL2CQYyPXZPMFES69c1FfXJxjT8pMf9mxFXYxVBonzJvvv2J3xM/qgKDZPNb3XUWzzVJq+EGSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286233; c=relaxed/simple;
	bh=SjQrVylsTPFB2/ZbWZJHvJkfHOesUI3xQ6OrvWviKGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ji3b1M1HT3XHrgIYCcPesITBuncBh42oxXOalIbU0gd4hLe89KFu984+BkjM5K4GMbyedwj7iWXUCvXcfYg3e0D7q7Y16OMMZceXwHDkr1DD/4ahMTTFmc5W/C2UUOxaHvwWlL5ocsfNoCgzokgs+C3NUPwbak27zFywJWEOD78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NG/YQO+8; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NG/YQO+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhgeiQq+ecWEjmGkfADf1mHvwa3/PxxDZ2Dt9yltTnUEl5mar93o/eq/1huWKEJA/GilNqt6Sk1noKutTAfo76frgcrdfaeJlytwi1TF4pyI01o4jk4k4s/y3zLeztbpL/fYCOgpknrcKQKe4o8vbKry9ghlysNgVqzS1Q2OVjD1NX/WN+TpEMvx/E4ojcoHtiB283GDZlC77q1CbpaEpXIdaoRiBEJHW22D+/3TqJNaFUla18o4jI+3NosDK2Br44TUimtJSJv65xvLz00urHVXzDeK1F/ulJ6kDXPPn/W3up3Ahjw2xNifskrSGbgzOlgKxd5TzLGUS5Pz03wElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00R282KvE4/lCznSngd4FsTVOJK4GnDFf2428Ssazpg=;
 b=VZMuOkCevXsid0P5g7oaxe3/uWWVchyTLZLy6EZaIyzrbnVtaRW4ukc2Nms0NR8P/UBHS2+swO3HKWyP+l2Q5koQSP/o7Oi6fkuPygw2uuLuwimlrJU/rjtR6gOsX/odZLwEgPfmh73Zbl96esfZ/Qc6elmAjxjt4NaqQKyyQcwefAozjLCcSWuHPpWKXJE/WQDaixBx/474jOBLUv5ltRJtkrIruH32+PWXkTGdAaO6uGAY1rwNxAr5Le1CDeb9xdJ15XkStPr3In5gvD3X6JgELJYz5/FAW9MwxK6qD4gtU1fBzkoffD/LMjl+zYO5HpsEZIHEUtzRDt+VTrbfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00R282KvE4/lCznSngd4FsTVOJK4GnDFf2428Ssazpg=;
 b=NG/YQO+8xqApa8muixdWuQRHaBGYKwHVgG0OXeA4qc1yjh6qEPfm9aBa8zY/qjU57iEfk+G0kBPi0azxgtCFQS25l6Ne4+czwvslfJ0n7IY09tzAU6VFdgtwCkG1m/99bnvti6AYPb0G19qPwCoX7+aJJeeXhIZqKdYknRvt2XRS9dHAM2FwZP7BwlQJIMKueRLHxEmn5oSjzXZNNpUNx8JSAwEu1Dl/IvvM6oW8cNMV6JqiGJZjyUVZL+Ne46edh3E2kXu1g5T7zIymTAnrWAPlw7CbVbzDVfbPqxonEmZfU9lIVSGFDcMJEX7ILG1lbpilRkxDz5+40b9rkj/75A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 17:17:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 17:17:02 +0000
Message-ID: <a60fe6fc-3cd5-4dfb-820f-b5832900d53e@siemens.com>
Date: Mon, 23 Mar 2026 18:16:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v5 00/12] riscv: Add dovetail support
To: Bjorn Helgaas <helgaas@kernel.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, florian.bezdeka@siemens.com,
 Thomas Gleixner <tglx@kernel.org>
References: <20260323155338.GA823051@bhelgaas>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260323155338.GA823051@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9b592c-298c-4856-2d6b-08de88ffffa2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	j1XmuzioAz1uPoJFTCPcUfHAKoqII2A4sSGj7tLJNIJpfeuI1Kon67a0b1JysGoLquJ/yFigod8Yok5YrbuSjRzqg3qgdCv0V6Bsbt1YEYoO1dijpFp1xntY5po3Zj0CkQwHj2CukwIzvzBJjyLVdCOPdDoc8vXYBuJUuUjTrwCGQdHoZQ8lhWl9j2h/B3xiofTwkTQHWuQRusk6aPsrJe8nQw9SymC+Zkl87KDmefudhOFtwd1OBopnPZf0x2mQO6v80tpIYIIYx9+/sX/HsoTALHKgzikCy3OXwgNNH+bA+RnzTGBfp9xuKWfjgIsRRSck//4JnEyHhb14CneWzxKClz52Rp3a0amAsm8p/xgK6qYUrPtCLjxpc1NGdW081qsL5sA9PLsXRGB6Q67kSlhiupoNxZRAqwp2rkb+RR7ydyfCORJT7lsOyGenf4OvSC0x39gqyd9DVPQIg18Xd68luh+IGC0fWOGPrTpmCAiNRaGrysMKUloAaDRp3345SI4Tu9QkcXh+68Lpf456DsT60fw4iJrXeB6WqjQJfJXvQHnJkorw54FSamHFrb/Z9S9sgiD3ywPde9D/nDgyQav3+Faf9U3KbH1fFYMxQ5yPSxNiLUOXnwE7ljSZbqiZjg+TuwvYyOztOj2kpszb9awVsvSK+pgVdgI5pFA+QMucORvabJLPxCyHBZ0MJLpvGpmEDdSwHFQTlCRjvGZuSP5ia+YkEOWPSNedb54wdiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEJrckdWek96WE5Fc0Fvem1odGtpazNJQlY1VEhoQ2dneENXNmJrZjhxaFJD?=
 =?utf-8?B?WFFldWpnQkhhaFFoYnFLUGdHOHBVNjhWL1pNS2QxRFV0aG8xQk5Ja2NMTzV0?=
 =?utf-8?B?M1p6RWJ2VXJKMXptTjZEL3E2SlVPWGdDdmdlU2FxSXA0L1AxeldadmVNV0dS?=
 =?utf-8?B?aUVLMVFSWmgxN2VpRTNtUXJWUFFuYVMwTE5vT0p6S0Rra0RkUDNHMElTRjIy?=
 =?utf-8?B?Y1A0ZmE4d1k5Rk1OcHB4ektvekptSHRpS2xJZDhLNUw0NzlPeE9pL08xS0h0?=
 =?utf-8?B?Uk0wYjRUcm5qVitTMGhPMExDQTVWaE1RUHRUWGt4VVc0RElac2NpL01sRXhm?=
 =?utf-8?B?WlBuaUlNcEErQTBmUTBab0FEUHlkZ3JNMmlDL1hrSFp0ZktLSW9rRFBLYzZU?=
 =?utf-8?B?c1Nka2RwVm9VN3ZYU2VQc0hvUnVUcjFWQysyRDNYVnNKaXA5eURQdFkvTjNv?=
 =?utf-8?B?dERvYzdQLzZwOGVyMkNGSnc2RzVwbDhqcm9KamJ2Q1dCYko1SytmbWlDVUU4?=
 =?utf-8?B?TTNteW5WcG1aVVhNSmhYTzBuZzZKcWE2cEVjM3hjUGJTczErNGY5Z1J0U2hK?=
 =?utf-8?B?OXBjNnJvUmUreVBNbi9GOFJyRWFKTlBSRE02czQ2S0xzdjdneHVwNC83akxZ?=
 =?utf-8?B?aWJmdWw0VEx0a213cG1aT0dnQlRHQVhsQWtGcjhDcnNYai9iY0tKMjVOSERN?=
 =?utf-8?B?Q0NxazZyT3NCN2t5YlNwTEFtMDVkdGhvVlRMMWRhUG5Hc3UrdkZ5ai9mNHJu?=
 =?utf-8?B?LzBUVFNwM1ZRYmRSRWFWTzdTaHkxRmV0MWhEQUZuNHlMbU9zNGtocmcvSHBT?=
 =?utf-8?B?RmFMU1VsUis4YlVaTm4xaU8xR3hCRFRXamRaMVloekJXamE1c1pPMjY2QUkr?=
 =?utf-8?B?elpLUnk4SXJwaGE5bENDUlgzVWYwQmx0NUJ6U3VZazc2M2xMc0lDY2VYSWVH?=
 =?utf-8?B?V01pcFAraThNQ2hnRyszNU1zS1VyN1FaSzdsR2hmOTBiZU1pSjNYNEMrOEV5?=
 =?utf-8?B?OTU0cGx4dElVZm9iZzVOWDNlb1lzS2NidlRjaHVzeUorRmI2VFVTQVJlYy9R?=
 =?utf-8?B?Y05HMDZ6amU0RkxmaVdPVVlHdUdXcHYvaG9aN2IycWVwWkpUbGtUVWVkRjVM?=
 =?utf-8?B?WmROZXA4L3l5QnBycWM5cGlJeEtpTjRyNnI5dzY1YjVMNWNJak10SUZGbHkx?=
 =?utf-8?B?dit1c1p3cmRzTC9kVlRyLzBvYjJoL3VuS2duZmE3QUVLS1V3RmpsSGtsNVFj?=
 =?utf-8?B?NjI3bS9oM0RFeUVMZDZOTEVhZTFOUm80YkRoZlFxVWNXYjcwcThLVFJoTkdN?=
 =?utf-8?B?TGMxVHh6QyswNHZvZFVteWtmZlYvaXlsOHhVTmEvQVlBL013cnBURHF1NVV4?=
 =?utf-8?B?c0RaQ3VDVmsydnA0dXJPUzBpemZuNmJ2bjlYb09WR2I5R1V4T1Yzc2I1NVc3?=
 =?utf-8?B?YTd4dXZYRlpVU05OUXlDWERiNXdUaGZaU2I5cTBZcWZNVFZvNmRmeHE0L2lF?=
 =?utf-8?B?K2pJV2s0TzNkQnJrS1c5aUZnWlA5RWZiaFUrMkFhcUdVNzZIYVEzcFRMaWkw?=
 =?utf-8?B?SktqQlYvRFN2OStyZGxJeVFuRzVWREZxbzRESERzMVhNUkVlREN1OGNJWm04?=
 =?utf-8?B?Z216S3I0cWtocDg2Y2J5SjNEZFh3VTJSKzZxVXljY1lMQ1R5SWdiN2Exci81?=
 =?utf-8?B?bEJzbHI4bTAyaXZvaU5pZzlJWElnTGpqSDl2Y2VFSDRVbU5IMkNlM2RUbStO?=
 =?utf-8?B?S2hiTWd1OWJ4K0ZLS1hCemhPRzhwaFVjMUhNeWVjSUJ1clJ3N2J4VkZIbU9B?=
 =?utf-8?B?U3hzTFhUeS9TV2ZxTS9nWmc0MDRiNUxjU0dFY1hFZWswNVBOM3lwZkttb3cy?=
 =?utf-8?B?U1pWYStNN3JmZ3lFQnBQSUNIZ1NTckVuc1pQamNkUGR5Zldud2wxOXhuL1hk?=
 =?utf-8?B?MjlFdkM4eDFCd1N5R2pVRU8rZ1JhZ1FCelhBWUZZaDhWVVJTbWNxbjV5dFpM?=
 =?utf-8?B?L1lnZlR2YXBOMkFML01SY0tVZVplS0RYdXVWTkxsTUx0NlMxa3Vzek5uU0Uz?=
 =?utf-8?B?ajhkTS9mOXZiN2IvMnhLdlFsWkkraUJPRlY3SEVIcTk5QitXTjUveWhMQ2lN?=
 =?utf-8?B?SlZuWHZYbWI0V1RydXpLT3o0eDZ2UGhEY3QyV3JzTm53NCtSVDlBWjNucEt5?=
 =?utf-8?B?dmN1Ty94djk2QTFDNGo3bDNDSHdmTExUbEVBYjNIZFIzenZabXRhTmhSOHBv?=
 =?utf-8?B?VmpRcyt1Ry85ZnVwc2w5ZHJVOHdIZDBoWDdINlpwT3RhVXB5alAweDlXS1k1?=
 =?utf-8?B?UEpyM0k3bDN3R00yVlJDS05mdWdWamlkc1kxSHNwTTJoamdvR0RqL0E2dWpH?=
 =?utf-8?Q?sbKeL0ASrLAdyZ3c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9b592c-298c-4856-2d6b-08de88ffffa2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:17:02.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne6nMk8Kq9xw0oBk/OzaUOegt6SSiSCQYCEUr9W4nl5J0Uco1nBs1iqQbxRsrMMnfdyeGA4YhGSQRxyDo6t8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5762

On 23.03.26 16:53, Bjorn Helgaas wrote:
> [+cc Thomas, irqchip driver maintainer, series at
> https://lore.kernel.org/all/20260320213657.2210419-1-tobias.schaffner@siemens.com]
> 
> On Fri, Mar 20, 2026 at 10:36:45PM +0100, Tobias Schaffner wrote:
>> Hi all,
>>
>> this series introduces initial support for Dovetail on RISC-V.
> 
> 02/12 mentions "the Dovetail/IRQ pipeline model used on other
> architectures," but my quick grep for dovetail and IRQ pipelining
> didn't find anything.
> 

These patches are not targeting the upstream kernel.

I wonder how you got aware of them as I only see the Xenomai list in CC.

Jan

>> Feedback, suggestions, and especially reviews are very welcome.
>>
>> Changes since v1:
>>  * Disable independent irq/softirq stack usage when pipelining
>>  * Drop KVM changes as long as they can not be properly tested
>>
>> Changes since v2:
>>  * Rework trap handling
>>
>> Changes since v3:
>>  * Included the IRQ pipelining patches to have all riscv specific
>>    patches included
>>  * Rebased to dovetail/v6.18.y-dovetail-rebase
>>  * Merged most of the fixes
>>  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>>
>> Changes since v4:
>>  * Rebased to dovetail/v7.0.y-dovetail-rebase
>>  * Applied suggestions from the last patch set
>>  * Added starfive-visionfive2 board support
>>  * Introduced raw console device based on sbi debug console
>>  * Reworked pipelined irq handling
>>
>> Best,
>> Tobias
>>
>> Tobias Schaffner (12):
>>   riscv: introduce raw console device
>>   riscv: irq_pipeline: add IRQ pipelining core
>>   riscv: irq_pipeline: enable hard IRQs during in-band trap handling
>>   irqchip/riscv-aplic-direct: enable pipelined interrupt control
>>   irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
>>   irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
>>   irqchip/irq-riscv-intc: enable pipelined interrupt control
>>   irqchip/irq-sifive-plic: enable pipelined interrupt control
>>   clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
>>   pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
>>   pci: plda: irq_pipeline: enable pipelined interrupt control
>>   riscv: dovetail: add core support
>>
>>  arch/riscv/Kconfig                            |   3 +
>>  arch/riscv/include/asm/dovetail.h             |  23 ++
>>  arch/riscv/include/asm/irq_pipeline.h         | 145 +++++++++++++
>>  arch/riscv/include/asm/irqflags.h             |  32 ++-
>>  arch/riscv/include/asm/mmu_context.h          |   2 +
>>  arch/riscv/include/asm/smp.h                  |   7 +
>>  arch/riscv/include/asm/syscall.h              |   6 +
>>  arch/riscv/include/asm/thread_info.h          |  17 ++
>>  arch/riscv/kernel/Makefile                    |   2 +
>>  arch/riscv/kernel/irq_pipeline.c              |  26 +++
>>  arch/riscv/kernel/kernel_mode_vector.c        |   2 +-
>>  arch/riscv/kernel/raw_printk.c                |  33 +++
>>  arch/riscv/kernel/sbi-ipi.c                   |  12 +-
>>  arch/riscv/kernel/smp.c                       |  55 ++++-
>>  arch/riscv/kernel/smpboot.c                   |   2 +-
>>  arch/riscv/kernel/traps.c                     | 202 ++++++++++++++++--
>>  arch/riscv/mm/cacheflush.c                    |   5 +-
>>  arch/riscv/mm/context.c                       |  20 +-
>>  arch/riscv/mm/fault.c                         |  29 ++-
>>  drivers/clocksource/timer-riscv.c             |  11 +-
>>  drivers/irqchip/irq-riscv-aplic-direct.c      |   3 +-
>>  drivers/irqchip/irq-riscv-aplic-msi.c         |   3 +-
>>  drivers/irqchip/irq-riscv-imsic-platform.c    |   4 +-
>>  drivers/irqchip/irq-riscv-intc.c              |   2 +
>>  drivers/irqchip/irq-sifive-plic.c             |  10 +-
>>  drivers/pci/controller/plda/pcie-plda-host.c  |   2 +
>>  .../starfive/pinctrl-starfive-jh7110.c        |   2 +-
>>  .../starfive/pinctrl-starfive-jh7110.h        |   2 +-
>>  28 files changed, 593 insertions(+), 69 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/dovetail.h
>>  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>>  create mode 100644 arch/riscv/kernel/irq_pipeline.c
>>  create mode 100644 arch/riscv/kernel/raw_printk.c
>>
>> -- 
>> 2.43.0
>>

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
