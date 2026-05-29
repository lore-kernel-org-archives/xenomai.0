Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B52C236B
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062651; cv=fail; b=fsHuNvGIGYmLUqAZDELJzAoYKCmRtW2+Ywz0ElBbUZYewRdZK6lXXY8x1zZ9SwVpjUMmwSuY2jt8VFQdv5DJcNaMtFG5FbV9njOWaf6hweUam+6mX3BvPeWJZQElXi3XfQkDqs4XX9GbCsQeOoEN7lJ9RbGNgHRdek0fT1pU4kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062651; c=relaxed/simple;
	bh=NPHjYzVAEkt3YJW9I40HckdSp78HgONMJEOxUDHWe0E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u9IZA4LSYyZF6jCjGIE2WgUjt6/q0giX3zYwFCRMm3zwYaUPUCRD+9YkuoSdjyKlV3argOgX9d71RHW+//4V3aEzEHTe/JZdRjewvCtWMed/guDqnjL594SG+vq2+BynafSc92nqcNE0Z9j3P56BbmrIrY+XQf0yv0gkm3S6ykg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QUyRPj7q; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QUyRPj7q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEc2nQxyAq7GpfM0kLmsPkYdko1j2tBcNwjS9V8ydeR2Ey0pVwewNHHcFcHxE4mLKpV7vybfP+IUGv7fzNgkC5wohYfIfsv3HV0codjuJG2ki5C7UkFGd5cDLj8i1SX4VycOJ3rUccGyqZX8W+GP3gbthFqMU1Hy5UR89KsL9VeH4NiDIEyD4vzYv0Ipe5Uc5cJOdbag6N1vANKQtqmIRDDgvyGZbNidycj6jt3wytdSfQDBpM250/SZq0GLxKckEY1caAp0wN+EE4LK8W1m1Owj7M0yWFTIhgX2HnCPxk9myHXLA5raTHOFOJZ1W+3QFMPkvIofUs2ysc1vMvuxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaZyXWOB5CmFlwaqESPv0S9j9CKrMEnYDrI19n795IY=;
 b=QM05IWi/NHzZg4DRJXm7tIxx2t+ps3dwjls+oqH0hzrHEoE058WmxglfDji5kWC1toIYX4ob6A8MHDo3AQfY33hNCPwyUcHvnpVnd9HzCB6OU0jr/RqxkzhbtTNu/OnlWNfD9GqVI249qyJ7ANg4AM9FBJ4U0E9XiWO6c36RUIW2RgAK6WZ646AE8c0D7eEfDY+3uBNb9WYWzQ7GrxPGO3W2hdrgT48f+R3GFu3ZyTf4ZeJLxBVPjJR9fgJZTSv7SI5NADW3dk/C83yL3vm6bt2+ZM4dywR8ilMkX60noBw+XzKHuhQdCQ90Oyauuk4/IzH4z1qunMm9jq0IOkkf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaZyXWOB5CmFlwaqESPv0S9j9CKrMEnYDrI19n795IY=;
 b=QUyRPj7qceTmvi9gdrG2vq5ad0uqw9tQEdbcCTg3B3E/+8pzayVqWwkvVOmejAGrHifFRJQz6oRdbeGlTYw2Gcg5VKPPULU1h3P/v0if4h0hlTB5GCeQ4TjVZNMb46SjpcFoTHFNHLOB1UTQ4/Rl4RGK+xwXbg/0xdqOiuX9bNokE3Qkdputvsy2Kgq+bcPy3YnNjmvRvngkdVleRAwyVa6Y/c4O+Q0tIVp6MP/0mYrBR7saiyljcLMCL8o3dU5ytvGGqlv8AHllFMn7j+rW78jga4HkLHoyUTOfbhiuFg6KGDZ/gdQ6eYhj9t23ApYriyzgWwO44X3WGkovPDTI+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA1PR10MB8837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 13:50:46 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 13:50:46 +0000
Message-ID: <5b942ee7-8b22-47d5-913f-96ee37df8a19@siemens.com>
Date: Fri, 29 May 2026 15:50:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail on risc-v: Testing strategy, managing efforts for
 forward porting
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
 <87bjdyil4u.fsf@xenomai.org>
 <030f8cd8-a587-496a-ab3d-11e67568a732@siemens.com>
 <87wlwmh4x4.fsf@xenomai.org>
 <b63745f3f56d5494ae60f0248e4f2ea440448bc6.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <b63745f3f56d5494ae60f0248e4f2ea440448bc6.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA1PR10MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d6c909-4782-4cb0-ed64-08debd8948d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|4143699003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	TTtuUq/FME+rym+9hM4bw1+M1gHJJkY+t/9B49CoZDbFV+DZ+KkOOIxIponLWJqiFX2br+TVUZnIOTt8yubS1+32FiUFk2WRmOpzo6RjhV5O3wKux6Tqsv5yOmmH5zT471/aoIBKh9rreSyiTZLM3pHbKlyp7Nwc7I2PxtdmNFtlb0FMbho77CCEeBRFb5YcfL97sVJc4/O6qBx34AzLd8eYWa5r06eiBsdvVONdvGI0ZWb6LYxzg+T2UdB6qwcIiR/pXJjWGvpGNblyIbuOz8Y9LkPApnTNy4hk9HjxzfOtGcm7l44QqScV0hK9VGMkj8cX5tXchCHorjStkFSVirblOsGbIS/7xVRha5f8c58d9rh/DpVqPLVQTflJ0iIno7MwNwtYwbrLrQi2yeKwSnoIr5wQsNEVh2pw6nrfWTXjpIYuvP+AUH/v2g+NW3+Zm+FGnozgBoSxQC1rfjQhma1oPVBxHi6goDAfBHlLF4SJcO3fnX36HrLnS8E43Kee2/bPYNqxY/GHWdu8WrtcFPfz8RKmSz2jWf5FMpW+VtsEhI6M6jV6Qj/gzTlk8yx4i59i52yhxXK7iyTon0ze4EqX77DI2gjWxIUtDYk6VcMHG0XAh4EbYTjLWzP5sdHCfr47sk8bcp1782dQgyLTb5wsIAsL303iUXvDuj+tZek8oYxnilgmK1bmotaI0J/zehAMpd/kVcfb+Hq6c0oT9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWJ2WGdoOHlMdVlrK2tXZmsyTzNIK1MzYWhNMXp0Q0ZHQ3RQdmtJNUtYT1Q0?=
 =?utf-8?B?UDV6cklTSnRIRzFMUktTK1BLMHpSZkc1VkxvMGF3WEpHb09tbnVqVS9aeUlQ?=
 =?utf-8?B?d25FN2VVQU1WRk96Q0lnbC9wTUVPL29yWTU3M2tXTXo1Z3JrdzJWaGttOUk3?=
 =?utf-8?B?aVo2all1WUlQd1hPYW9vQzJ1ampLUjRMMyszY25Qd1Z1Q0NOdVVLQ0dycGhm?=
 =?utf-8?B?V25vK1JsZDRxb3J4K2dqOU1zV1FvUjg0dlpiNys5dEsvaldSWUwrYWlzMWpu?=
 =?utf-8?B?aTBiaTFWT2lOSGJuMjZwL3RmN29kOGF4NHlwaDQwWVhUV0Z4VWgvTStocGVz?=
 =?utf-8?B?YVJnbkIwK2lCZXZxZitqcjZDRWJWdXkvNEFxaXBBZ3NjaG9yMHBOZk1PVzM0?=
 =?utf-8?B?aHNxU1hoQ01wU0Zsd0VtVytuTlQxc2I4aGtyNmVOL003aWtNZHZWbWhOUmJQ?=
 =?utf-8?B?bnZoclhMc3lKT0VBNlZIOHdaSVdGL05WUXkvcXBlOXRJM2pjWXhpMHI4N1Zo?=
 =?utf-8?B?NDdUclhLbkczVjZxcVJMUXpjR2plVWtVd1lOeUhkZUY3VGJrYUdaRFFwMVAx?=
 =?utf-8?B?amY0T0RCWkVNU2tYWXYrYzdQRUhjSmhoNUFzald5RkNBdWx0UjlyLzRIRng5?=
 =?utf-8?B?dGFnNGpHMFdrejFzVkEycDA5d0U2MGZkTmxSY3Nvb3kzMVhGMjVEcEROckVJ?=
 =?utf-8?B?MUtGRk1yUUNGOW9YT3BtUSt3c0VZVml1ZTQ4ekJ1b2J4RmVFMlJkSDBoK0Jw?=
 =?utf-8?B?ampldkUrOElEbEhKbEhFWGNpU3FxTmlPOTRxN0xjT3FMcXp1ZVlUdHBGaEZJ?=
 =?utf-8?B?T0hjNWliUVhqaHd1ZXpsa0NCa1M0YU1Pd2FobGtCRVdBbjVSNndibzJkbDRT?=
 =?utf-8?B?Y0ZNNk9ibU5qWHF6ZTBvTm9IdHJhaFBYMmVHa0FBL09BYUZXVUJhbm1YTVBK?=
 =?utf-8?B?MzE0RHJ4RnJKNmtkckhNYnM0SHNXaUtZempIbXlnL3luSll0Kyt5U0p5M0Jx?=
 =?utf-8?B?Ny9xblBCZ2kwK0lkeFd6NUIvNmdORTVPRmt4VGFmRFBHNkw3M3BpL0ZvN3FJ?=
 =?utf-8?B?UStjSkI5R29MYlI4Ung5cXJjREFObW5rWU5MT2w0NmdLY21VOUQvV1ZMRmpW?=
 =?utf-8?B?N1plZVJtRVd5S2taOVVmc2I0S05hRXdrOEp1K2ZmY0Z5aDZ2bytXWlY1RU5z?=
 =?utf-8?B?cGhmVTArTlluVEF0Sk4wTnJid3JoS0xMaDJOU3pVQzBRUXkwNXpJbjgxS0hE?=
 =?utf-8?B?REhXSFVSS01ZZXVuT3ZzWDliZEZuWExrVnJlMURpWmtwL2RBMFpmZkgyREs5?=
 =?utf-8?B?MVNqVmlUT0VXU3ZINTZkTTRhdmxiejg2M3V2RkxKZzB3NnBzUTJDQ2JRRk10?=
 =?utf-8?B?bjRjNzU0OS9TM0tMcE9vSElZRXR3d1hlNGZ5YmxkTGlzUno2dGpybElObkRB?=
 =?utf-8?B?cnprNHBZbmJBOTU0c1NmMlNReHRmbENQY2NlREt6UU1RK0VIMXZCNEtqdlNi?=
 =?utf-8?B?ZzNndGZ4Sko2bFBWbmw0NHRjWEQ2eGo2bWhyMXZIRFoyclFyenhKUjNINlhm?=
 =?utf-8?B?WUFwNk9walNnMjEyeVY1SG5kajJuRHdnZi9KczJMSlp2MFd6UmR3MTBmTGw3?=
 =?utf-8?B?aUpISGRUMjZVNFd5M0VNV0FlTDNub0ZYeGVMMjhFb0FqaFBsL01odmNGU2xL?=
 =?utf-8?B?dXhIc090NTdLeTlMYWI3Vms5YXlvV1VQMG9JbDhndVNzN2FlYmFwQWo4Y2xH?=
 =?utf-8?B?TzBaOXIzeGVGTTgxTlBCOERNRHVKMnhZYVJnMjl0UThIMzNLbGdqckd6Rld5?=
 =?utf-8?B?dE16d2EzL25LbUtWVzgwSTJXMS82YkY4Z1J2T3M4ekg5aFczU2RpNjF2WTRO?=
 =?utf-8?B?UWhVeDU3b1RROWJkYWxnWi91cXVOUjYwNEg2ZjI2UXI5WFk5ajlEcU9oRU02?=
 =?utf-8?B?anFQNFhmMkwxS0tEODZLaDJEOGlQTlNMVW1rQ3ljZVNXT0FJT2xPZFVyM2Zi?=
 =?utf-8?B?bWhlcU0zUVFTRC8zb2NPMFdFR3VQTWJDTlEvRHRHYWdiMHJTT2dkTVZSTmZk?=
 =?utf-8?B?WGlXRTd2MnpTWm1NdDIwMXNiMkVhSE4ycU9scEtnS25aWUovWGloSDMyYmZM?=
 =?utf-8?B?ZWZLcDNYWDJhemI3ZUJHcmhmeDZhbjZPWG5GUHlJaE55aGZDNkRZNHNzTzAz?=
 =?utf-8?B?S0ZDU1kvOWxpblVpdGNGOWNjako2akNLbDVubksxL1NaSHp2Uzg5cVUwYnVl?=
 =?utf-8?B?dWtBWEVOd2lDdDZnNDNPRmQ4dFlZOVJoTUNmK2tpaEhMcDhXL2tPU0RLUlAz?=
 =?utf-8?B?dTB5eGtaUythQit2amZPUCtYeTJYUE9wWnhQUXVJL0g0Z0ZHZEZWV1NDMHM0?=
 =?utf-8?Q?PPhpF9++q1usYjz0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d6c909-4782-4cb0-ed64-08debd8948d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 13:50:46.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsTvACwRCQiwuA8urx4ZEsRvCnO0LVr/AyR00vPx8h3juMx8WqJF7+dGZppnpsA4FoKXN8nUTytqN3wwgZvWizU+/BX7HGahYW8sOIMNZp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8837



On 5/29/26 12:49, Florian Bezdeka wrote:
> On Fri, 2026-05-29 at 12:43 +0200, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 29.05.26 12:08, Philippe Gerum wrote:
>>>>
>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>
>>>>> Hi Philippe,
>>>>>
>>>>> I'm currently waiting for a v8 of Tobias' risc-v implementation. A
>>>>> couple of minor things still need fixing, but overall I would say that
>>>>> we are looking good - ready for merging - assuming that currently
>>>>> running tests are successful.
>>>>>
>>>>
>>>> Really nice stuff, thanks to anyone involved.
>>>>
>>>>>  From my point of view there is one issue left, that needs a discussion:
>>>>> Testing and forward porting in the future.
>>>>>
>>>>> Up to now I was able to test all architectures using cobalt / x3. That
>>>>> will change now, as we don't have risc-v support in x3.
>>>>>
>>>>> I see the following options:
>>>>>
>>>>> 1: Additionally forward port linux-evl in the future, so that we can run
>>>>> tests against risc-v using x4. Additional effort for me, especially
>>>>> because we don't have an in-house user for that. Can you estimate how
>>>>> much time it takes you to forward port linux-evl in comparison to linux-
>>>>> dovetail?
>>>>>
>>>>
>>>> Porting evl to a new arch kernel-wise is fundamentally trivial, the real
>>>> work is done by Dovetail. For every currently supported arch, the amount
>>>> of arch-specific evl code is 60 lines of C, merely wrappers in headers
>>>> (arch/*/include/asm/evl/*.h). Tobias already contributed the few bits
>>>> libevl needs to support risc-v.
>>>>
>>>>> 2: Add risc-v support to x3 as well. To my understanding there were no
>>>>> plans yet, but it might be worth it to limit forward porting efforts. I
>>>>> could focus on x3 for testing. This might also help to compare risc-v
>>>>> against the other architectures.
>>>>>
>>>>
>>>> Although this may require a little more effort compared to x4, such port
>>>> would still be tractable since Dovetail does most of the work here as
>>>> well. Adding risc-v support to x3 is Jan's call.
>>>>
>>>>> 3: Ignore risc-v during forward porting. Yes, this option exists, but I
>>>>> don't consider it as a real / valid option.
>>>>>
>>>>
>>>> Neither do I. Merged implies maintained.
>>>>
>>>>> 4: Merge the risc-v support into linux-evl. That would make risc-v
>>>>> support exclusive to evl, where we could already test it. Would that be
>>>>> an valid option for the evl side?
>>>>>
>>>>
>>>> No, I believe that we can deal with one arch more such as risc-v in the
>>>> Dovetail maintenance process. Besides, we really want the generic
>>>> Dovetail code to be shared by all architectures, otherwise this would
>>>> become a maintenance nightmare for the risc-v port.
>>>>
>>>>> Any additional option available, that I missed?
>>>>>
>>>>
>>>> I'd say, the simpler the better. Today, enabling risc-v for x4 would be
>>>> straightforward while keeping the current maintenance model for Dovetail
>>>> mostly unaffected.  Granted, forward porting to the latest kernel
>>>> release may require a bit more work in order to maintain the risc-v part
>>>> too, but my understanding is that Tobias is willing to help with this in
>>>> the long term. AFAICS, the arch-specific part in risc-v for Dovetail is
>>>> fairly reasonable in size as well.
>>>>
>>>> So, first step would be to merge the Dovetail risc-v support into
>>>> linux-dovetail like other supported archs, enabling it for x4/evl in the
>>>> same move. It could be enabled for x3 next, when time allows on your end
>>>> if desired.
>>>>
>>>
>>> To my understanding, Florian's concerns are not about the first-time
>>> enabling or risc-v but its future testing when going to a new kernel
>>> version. While arch-wise, most work is done in dovetail, testing would
>>> only be possible once linux-evl is ported to a new kernel as well. And
>>> that porting is widely arch-agnostic but for other reasons (drivers
>>> e.g.) quite some generic effort.
>>
>> This proved to be a limited effort over time. Porting issues in generic
>> driver code for linux-evl can only affect the GPIO core, all the rest is
>> on the Dovetail side (NIC drivers, SPI and DMA cores), so already ported
>> actually.
>>
>> Those issues did happen but rarely, and the complexity to address them
>> always were an order of magnitude smaller than it has been for Dovetail
>> over time. Most importantly, those merge conflicts were all due to
>> changes in symbol names and routines moving around due to upstream
>> refactoring/cleaning up the code, still keeping the original logic
>> untouched though. I'd say such porting work still qualifies as simple.
> 
> With that: Let me try it. Which branch should be the "source" for v7.1-
> evl-rebase? next/v7.0-evl-rebase or v7.0-evl-rebase? (with or without
> next/)
> 
> I would do it the same way as for Dovetail: I would push to something
> like wip/<release>-rebase and ask you to take over / release. Right?
> 
> Florian
> 

I have a working evl rebase based on your wip v7.1-dovetail-rebase that
I used for testing here:
https://github.com/TobiasSchaffner/linux/tree/wip/tobsch/v7.1-evl-rebase
The rebase was streight forward appart from two small issues in drivers/
gpio and kernel/time.

I am willing to support with the forward porting of EVL now as well as
in the future if we decide to go down this route.

Best,
Tobias
