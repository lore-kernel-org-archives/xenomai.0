Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F648C3E3
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573577; cv=fail; b=tYuiJvyj0439FIHHaVblvX2S355eDrIaZU22ALnS2iJ729umEQboSSxNCZXgXaVEssgZ/yx4uUFF1/6fWApT3CnEaYTtkvrGNoq3D8HE/o/WwdsatRWM4Q9GfVebEp/nyjWAnx+Igpw0qggApL0UJ3XVgaTqJt76O9cj+0P8uFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573577; c=relaxed/simple;
	bh=qdkHrHuzJx5vnY6xSt15oh/f4Qa3SOYf4Idr46O9/gs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5khP2U8fyvHUhY+3WGSwmTS59DPpt02yrZGh2TSr/5k/NnrRK4LG5umpE+zP5tNoR2+8UHFOKDTANw+d6SHOk0TdSVPn9lGApfebSEUW0TKMfDFRC8yh4uWT71nkZmXBONFrZTVr2qXH3kh5K3fkwcZ1WAtIk6nAVLVQ5k03oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iAecUqv9; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iAecUqv9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjClEWjE8IJXOAfzesu0yx9n6VkpLMcn7/WXkQmFko2DrHiIVIwALssYjXQpiO14AyY5sGP9MPrxkUofimfntF+x26Hookl0lzir38ociDYaD9nrww7H2uqfZSVyPfDEwqZ0nifiuYW5kJLAH/fSKI1rMwWie8W5sYOYmt72a688AyYTQWNVdB4G4G4atyadQmJy6KPSaAim1InrCtGvpYLxBmZKDlS6bsZJJgsGB4gCXFZltOC2fXhetbBkKtQNuPMq5UU1yv+wwpLrk3L0Pte2+bX2gADpLLv0V4U7iBlDtFa3SONOPTS23lI7T0GIAvvY/0Yp317UB+TGSC+L9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+1qD7ni7QVsEZShmHPebUcmGJp9kMvKpCIm7/ITFGw=;
 b=ZlbEQjxvqDVgP9PKgkXZ9ChqI/j0bVfqTOGmq9HvNwcUGuPq+lFkqnseD+jiET6Om1noildPTMuexuw22KOkGqfrnI41xoo2TkYZpAvtmkszmY7CKN0img6g0BA/6jL7duwlE2yG0Odk+i7KQ7JcqMK0bZnV6C+fj4LtJiXg8qa02p15i6eqWUqNwIIc9MNc2xhjW2hYG4fosPzur89UbxS8rL/7amPDRbwDmIMj+I5jCCVoiVFARZ2NMASTJ0adYq8pI6G+oSg97hJyXeSPsv0aSBh3nDwMfPWQyvbl7YsaRGUXMf1KMVYNCIHFasRFQdFAEaXa+XWvjvoKG30Dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+1qD7ni7QVsEZShmHPebUcmGJp9kMvKpCIm7/ITFGw=;
 b=iAecUqv901fX3A5rb+JeOCSz4eu+b9Oo/1+ZtT4gF1Ukfi0HgMc2/YHDGFEFq8qXpPezs4wWUrUwTqnboVynfT7sgnsziKeGSBIhGMqG0RpvKe+31xsnhM8QqEem1SRPSv/rDZ64lgSa6aSgRdyBaP0yorMx0/kZ8zzAu9PuYuCZU5gCoAgFNoprQQdgXlfWJa63xX2SJvcjenq5Kb/pJ0ZDE5D0kOtRkkxyG+nglxgW6kvTADhbQNoOhoYxA+YlKMotK++iWD/9NLqaAfAm8HfjBfY8i0dTe/sgjjnBA9re2C+Z/vAgAtdo0t+aW/UmWPLY6RcbBplQ4d4ykGM7wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB5242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:12:52 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 08:12:51 +0000
Message-ID: <fb14e314-2146-48b6-af4c-9fd2403936cb@siemens.com>
Date: Tue, 12 May 2026 10:12:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v7 00/11] riscv: Add dovetail support
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
 <87ik8u2t2a.fsf@xenomai.org>
 <854c31ce523b9f1f10b2d40c8575c1cfb6aa07a9.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <854c31ce523b9f1f10b2d40c8575c1cfb6aa07a9.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 96299fef-aa43-49ed-430a-08deaffe4320
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/c+qE6qQupGCUvoDQ8Xq81aDew+N5LgX5tyTPqxg+Hgm912UXG2DOIqOeTRGguf5v0iEgMXfZQ00/njz1Px4u1l5NDKiCeEnY9/CXPS67wMrFbjEvABGIg0I9hi821Yx4QryN2SgUdbJOVBqO6A9Xbt6R7b4CzNwKXVbSRSsN0qhHB8OJ8ultoGJNvpMWZfUE7KSY/DReKfOfd/9n62KZmKi+ntOGPKYc5SyhfZDDeKd7I4Fxog0plF8Qp5B9/28Dt5j0u2Oaqd+cgW8m15m+3tO7qVBeSy1+7yFgbpjMmjGV+xjmJN4m1pOW6FD0dbq4OBjiNCRrs8Cno4H5EzgDyUpRojmJCHcZly+FgmgPKMmG/V9aK9XOWd015e1KEcDvTCQ2pq8kAJYhmBpzQFOzczoXzRWrY1V687+Q+k7WEuWR5elcKpzJhAta382J77kWQYFyB4/x6+QBe2dKPSw4emDo6C1Qky7nidXqgk/w+UAr55M2mZEhzf7UnTPO0aF/mCbGEWsJ1U2jzsgUckKFh4MSIuFowZanr1WJkCFb0o0Iet5XMtR1akTGdRG+S3YW+vx6Tmso5VmXAElp0kNbOWp45sr6BOUwCdwFe/InLH0EOKAI3Y97HxR07UH5wJZWvIKGfwlL2A+53xFNXD3RvP252hCDeoxSUFyXtibX7Jqv3pcOmrDlLq8QbCJdaAH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L002QnpZSFhMRXc5OWtHYzVITGxHMUJWSCtSZ3hEbkZZV0s5czMwVWU1eURQ?=
 =?utf-8?B?V2tKaEVZcFRSWkdldVptYkh3a29aMVlYbW5MTG8yamNkV0k1MnJDa1QvT01W?=
 =?utf-8?B?SVFidEdRMlFFS2IyU0R1V1J0N2ZidXV3T2tWUkpUUDhReVF6UzRwK0lFbkJn?=
 =?utf-8?B?QXBTY3dFUzQrYm1KdWR4MEI4bXpNSWhXRTkrNGV3aWZhT3JxYzlIY1NOb0hQ?=
 =?utf-8?B?dlZnVFArOC9Za0ZPY0U4ZDBvaVdrM0VlVXUybWNvd3prMHRrUmlzc3JsajJy?=
 =?utf-8?B?ZEJTWTBvbWdvejJlTkt1Z0JPcloyK2g3ek9WRVRTWFpSV0JuNVZzODA5ZUgv?=
 =?utf-8?B?WlZLdnZBcDRvUTdvNVR0ZGh6VGVZcXZwV0hXcWVIV3JFZU9TejVmTDVSZEkx?=
 =?utf-8?B?RU1TbU9MT3pNSkhWK0ZMV3AzekhuZk5CLzZ6QjBKUG9vWUh5My9QN3I3b0NN?=
 =?utf-8?B?N1o2eFgybEl5WVI4REx2a0NWM1RiOHhSdU45SmU2a3JKTnB3aXFnYlZNdUdI?=
 =?utf-8?B?VzFYS0dLb1VMejh6TDBBSjFxNTRGVC9XM2dWRno5NGt4NjNmOHZvN2trdUxo?=
 =?utf-8?B?TlVFczhFTHZTbTM1ZVp5MUtrWDI0aE15MENaY3VONVVpOHkvdm5ueWtSc1JP?=
 =?utf-8?B?K2pwaTAvQW10Zk5WeGQrNm9xSWNkTjBKazBnZnJ2enhYYXdwYkNaeGExME1O?=
 =?utf-8?B?alJISkQ3ZGRNblZWVEo1QlpvNE9WNmJOT1RuaWxrQ3Q4YkN3QytDRkwyS3ZM?=
 =?utf-8?B?MGM3Syt4d2tsS3RMeEx6aXhSeUtkb0VYdHd0QXZtN2xmS2xGMTZaaS9VeUV2?=
 =?utf-8?B?SUgybHdCR2J2R1BBWThVVkxTeVd5UkQyaFhiK2k2VUJQUW5pVnZKdkM2VWdN?=
 =?utf-8?B?blN1MWh1aVhRMWtGQmx4UGk0OThWRi85RmpKcXdZMzhwZnAza0g4SWtYaEVR?=
 =?utf-8?B?azN5WS9DVmVhbHNDdjZoMFBmMFNFNTJGak1oMHdGeExZUTFXd3o0VU5lZmQ2?=
 =?utf-8?B?bnlwVUVuNTZiYzVacXhkRjM4bjhsVm9hYkRJZHg3dXcyNStVZzMzMU1aM3F4?=
 =?utf-8?B?eWdZSVdjeW9WV0pvVVpzeVlGQS9oakR0a09jbEE0TU9ZdURnNU1rNlFoN2Fj?=
 =?utf-8?B?eTl4c05nZ3JEMitidkNLcUVoL2FnL1NNOWtOLzZnRG9rU1J2aWgzQkRjY0R4?=
 =?utf-8?B?QjhkcXJodGJTS1VJM0NUR3V0T2NoVjBqaEtYeVhYcHpyMHpUSG90VDc5Ylc0?=
 =?utf-8?B?YlRqUXEzNzE0UGhZMHU0RDljYU1ZTmROenA4OCtvcWJrZld0TzNBcWJuMmda?=
 =?utf-8?B?ZW5zaFB3TnQ1MUVHeEJPWmMwVjJHTDBlanJnWFFCcXFMY3V2Tmt0cDhLTWVT?=
 =?utf-8?B?UjYzQnhrWjMxS2xrS3ZWTTRLK1A3QjJSbCtGNDV0U1p0MmI3Um5oaTFGSWlK?=
 =?utf-8?B?MnpZbkp1ZHh3ZXk5ekRBbmY1U1N2L0F0UHJWNGw3WWd2dEE3QnpNakx1aTRl?=
 =?utf-8?B?ZmFVOHVvbzVVL1gzVStnL3gzQmZ6emtDY0RsZTJoaTRGNmpKbDMzR2t1a1pk?=
 =?utf-8?B?RUlxZURVbHp1NmNLeG43VGFPcXBsbDFZcjQ1am5CR1hpU0tLL3VrT2YrTVBm?=
 =?utf-8?B?dFVTbVNlQnljeFBZemU1NU9aVHZQNkJEN3NPVUFLQ0JxRWVJdFkwb3BzckIv?=
 =?utf-8?B?WEluQmwranhWTjQzQU5BZFIyamIrMDdQcy83WlNFOUZPTUg2RHJyMU9TNlVO?=
 =?utf-8?B?cTJFYi9Na1BwcStEaXVlS2NxemwyYThBUkVOMXVxS3BXeGxSS2phbmRieDI2?=
 =?utf-8?B?ZkVQQnBqdUZySlN3SllXVkM0VWlZeTBqMHJuVjFkYUhjUSt1a3VpNzdnZGMv?=
 =?utf-8?B?TFRNeUZHL0VHOEZSS3FXaThTUDl0WEw1REJiWWxnSTFCeGszdEFWb0hSMHJ5?=
 =?utf-8?B?aWprUFVQVUw0VUdsOTgydmxGZkxHNXpsbm5CUGwzbkY3NEJtRFlveGx1TVB3?=
 =?utf-8?B?ZENDTHRmTUF1UnBvZno2MTRGeUkrZTNFanNrRzlVZzRPMDV2V051dy83aitD?=
 =?utf-8?B?VWlmNUtrNWZtUmw0NzNEL3pWQ0xodkpTZTlRUkVsaFVYSFBBd1lYRFhaWUVW?=
 =?utf-8?B?TU5HZk1jbEZYQk9XUGRNZ1RTNDFESlhOYTZnNlNReUdIc1lJN3JGRTZyd0hY?=
 =?utf-8?B?cURsY3Iyb0hrZGlzVWN1T0tVaDRYSFg4c0dycTRzaU1icUZYb05lRE1JK1hT?=
 =?utf-8?B?dWVCckFGb2pCNFlTNzhDbUlOV2pjUFRIOGd0UzFHSWxkcDdmK0lUSVJDYVQx?=
 =?utf-8?B?RmxTenY3ZE9LcERLMGg1Nk1ld2h5Z09ZS084MWZGYm94ajh6MUp5RHp2SVlu?=
 =?utf-8?Q?sDVEgt41wG7gmpKA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96299fef-aa43-49ed-430a-08deaffe4320
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:12:51.8653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvL0hmnCekZIhfKrpcFy6xuS+JhBPP+hWgrd2GL+Xm4Don4H2PvmG4ia8Z48v518tr81YdaakNyIPvMnxYycBCsoWGEFFwNxgxHi/hUEMgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5242

On 5/12/26 09:14, Florian Bezdeka wrote:
> On Mon, 2026-05-11 at 11:29 +0200, Philippe Gerum wrote:
>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>>
>>> Hi all,
>>>
>>> this series introduces initial support for Dovetail on RISC-V.
>>>
>>> Feedback, suggestions, and especially reviews are very welcome.
>>>
>>> Changes since v1:
>>>   * Disable independent irq/softirq stack usage when pipelining
>>>   * Drop KVM changes as long as they can not be properly tested
>>>
>>> Changes since v2:
>>>   * Rework trap handling
>>>
>>> Changes since v3:
>>>   * Included the IRQ pipelining patches to have all riscv specific
>>>     patches included
>>>   * Rebased to dovetail/v6.18.y-dovetail-rebase
>>>   * Merged most of the fixes
>>>   * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>>>
>>> Changes since v4:
>>>   * Rebased to dovetail/v7.0.y-dovetail-rebase
>>>   * Applied suggestions from the last patch set
>>>   * Added starfive-visionfive2 board support
>>>   * Introduced raw console device based on sbi debug console
>>>   * Reworked pipelined irq handling
>>>
>>> Changes since v5:
>>>   * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
>>>   * Applied suggestions from the last patch set
>>>   * Use mark_trap_entry/exit_raw for kernel mode exception paths which
>>>     use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
>>>     irqs to stay off. This may be be subject to further optimization at
>>>     a later stage, but I do not see any negative impact latency wise in
>>>     my tests.
>>>
>>> Changes since v6:
>>> Address the review comments from the last patch set:
>>>   * Keep the virtual irq state in sync with the hard irq state in trap
>>>     handlers
>>>   * Fix irq_nesting imbalance when running with disabled IRQ_STACKS
>>>
>>
>> Ok, this is ready for inclusion. We should target 7.2 since the 7.1-rc
>> series is already running.
>>
> 
> I was blocked by some other hot topics here, so I didn't start the 7.1
> porting yet. I might be able to apply them on top and do some more
> testing for 7.1. Let's see.
> 

If you decide to do the integration, feel free to send me your WIP
dovetail branch at some point. I’d be happy to rebase my patches on top
of it and support you with testing.

Best,
Tobias
