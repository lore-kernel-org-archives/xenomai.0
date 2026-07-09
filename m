Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D812E7373
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604408; cv=fail; b=X+Wt5zHyXHWfB/Onlgfca2ghpFjUFsnX4vQbZVeMYZ6Gbn/v9GvPLOlDZnzy2bxbHZHz42/7+cAx4sCvWB7Wm/lDWYNdTsq7tfMBbur4KjH5389C9AvxazbnV7O+lLcUtDwZUmRXgu6Nv5TPWfalLUhZ3T6UBUKPQ67EgU8vWlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604408; c=relaxed/simple;
	bh=6khx99mcPneDA6gZKZ8Ae75GaVxvZPWsL5vs9v/V88A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pyZ4Ju7TCbV8WRGb5vAx7cAzCJHEKWNQjAeyFYGDyds//dp0F3z3DKk+/s68mk6fz4Ex996Aj2S85scZU9r9faFcWmIxnY6ctSVwvxOuparHv4IFaqyB0J1JsyNASUg1oiqwGr2hzrbfJW4lwoU3z10ET2x3azwBqKqub1k69w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YrnD2Gvx; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YrnD2Gvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxkqUg4Fd0ZHwmqz/t9k2M7OJtmkl0TsNSBIMTZXiGVaRNvmS0FtPMfcrjl7A7p8BbbemUf92lGpCNy0rFyIdZARuikLvfvF+3czQsw88C2HDPKejfk0V/Z7fdqHkOc+OtNj1kLZGMmFductBVAznDPw/UsHITtfc2lAOxxWhe/Ktskael7ojUTWEypd4NcM4TfGah/XIZjhF+V6j2ysRpDtnriMb+QeLX7buqzUpq1BP3eU+cqvjT3n/PEhdUkMd+k57jpwwLhMb65EsMkpoOHtD2lWPxtUjWzq4sS/YwN3NbukopR90rHdL8wvG000aCrpKvGnbx53z1CkPFqK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvUM9rbmIi+yKxOdcc+KhWcgrLgUiRkUv1nuORItQD8=;
 b=dBFfVgoONHd1O4vuSbZqqBNM3zDUMUIZF7MhLnh/YSWEQngaGq8ctJjAm8su460dchWEpZPQmW8hj+rfAFLZoJPy2Td8EFPTsjpezn/0+Va6EtHzcpsDfZHtwy/gsJzeaqyYwTahSoiZktacR3mgnmDeh5Ed3LbOsudukiLdLhl5USRDV7XnrwaLKOZZ5dvG+BGdmmkAkHhRFx0T9DH2x3e+mI6k0Cgl+0Tmenhn25L7uS7AnR0v55R3a3jGhhtQrLDw2ASb5XrQsdSGRl9AxRZCXhW8TaneFL9mEZfEukKXjZTX+CwRU9u9DLatG0pY3nnyUgQpL5H+XJQdIo2UMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvUM9rbmIi+yKxOdcc+KhWcgrLgUiRkUv1nuORItQD8=;
 b=YrnD2Gvx+EMxhYqm74G87VooY8ftWAChBGZxNB+FvBR+BNylRe27yI+WwSqbFdAzvLyfLgA/LDN2FFa+0mFxuGx3CfdHwhBREcMZK525EJcfXpHeM5cNuKRt+tMN/B6R13/xRd2kul/q0geAc1r9X6SXc806pS0cCyMsXOHtngXuewIsR+VdNx78xjxKBp3wWnffMnT/y2CvG60SXobZr5aBIhOHKpGqD9MD9R6bc7efwQeXNUwSYfUCHsAXDKSt2dyenxtz+MaYfchpFteBLCNi8QsK1plC/o4x/lHsRfNAMz68IpkSuQddUy/KBKCdjJFoZIRgYfizjeOmiMvg2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI1PR10MB7878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:39:58 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:39:58 +0000
Message-ID: <22796f23-74ed-4cfe-8188-df22b2547ae3@siemens.com>
Date: Thu, 9 Jul 2026 15:39:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have been
 relaxed
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
 <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
 <88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
 <e7debecd-2490-40e8-8223-4e076d39165f@siemens.com>
 <27d44aef-6dd8-4323-b24b-70f0770a9f49@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <27d44aef-6dd8-4323-b24b-70f0770a9f49@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0128.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::25) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI1PR10MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fc52a1-5c15-4bf4-3e3a-08deddbf9188
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|4143699003|6133799003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	JJtz5sOzuXxwyZSwLaJFauMx6weXqBLClsd9sBu+cbQZGOWt/GZRDSLxPGXIBVUWR5161zdpAlprZl+SCHkvXIYTkbCGwsVDzKxQy2BAjDq9ZdXgMKMr4uZErPISTrHJWVIVnRHf3rNF++Kef67+L+O2nEnmB9j7MT+GbXihmGmJE7ZgtVm1wSdCMd+lKBjVBbGHTDsmzqJBfZV1W3b51TqlFnXkGRd2AqYI6IFfKwz/ay7Mu9dnhYGNiyslua8e11XHrxMa5HzaOPoezj22X5plqBRUpIJ69/AfTTZguMP7bpYWDfqs5oorGvdla0ugRTUJIhaWx/LVuoa6c2Tg7Xw9+V5fGxeBOsPnDrviCk/uh4K9GEGbFjgi6TySX0+PzVL4lOxVvS+XIgQe8uZ3MVPdezGEalCfwW+Nk/BWVP55+aBHJ3WWBVyCDeRxkihuX+lVBup+Ot0f/sOtLvBcxmKt2GW6cROT15pw9NC0M3WJUg6sN6CEnkVEeuQebAlEzJ5jDHUotvB+0/WRaSzs0/3H8RM32la0UWR5BXYNkzdHXMdkt+Y+YhrEEbGbFZQfg9YwTMeVg+XQlI4SZflozDa2/Vg2RKTAZ/yGsyNaohMQvGDxF8XqnEt0lHCdGeWAnQvEOK23y0hoFFvRFj+urR8+ttBZsNIMJTPf7HJ50ME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2ZZMk9qYTFKOEJPSFBlN1FOVUpSNjRiTytmKy9wVXVKalUvNHJHZHJSK3RE?=
 =?utf-8?B?WFZMM09KMTdyS0Y2YTVWRDJFR24wYkZPZ3BVMnNYQ2o4dkVMYnpKWldqUk9C?=
 =?utf-8?B?bXVIcUNlQ3ZZY0s0UjNxdmdvOTdnRmxWNm91QlVZL1JRWWw3TVQzZy9lUzhV?=
 =?utf-8?B?dnprUGIvMXdDKzhOZ1NvT2xiRENSbmtGR3EwRG1hVGtpeDIrYWdteFVNSThH?=
 =?utf-8?B?Q0hNeFptbTRGaTk3bll0NnI5eFkwRzlBOFQxMG43T1VQWVpaOURxaXoydGsx?=
 =?utf-8?B?ZURIUWVmK0RhcFkxSnFRaWdUVnFKV1RXSGs3a0VLRHpqWkZtRzhDYTZkakts?=
 =?utf-8?B?NXBEcTVmcDhnWkZ6N3E4MkkvQWpCQXZueURSYTJ4K3k2LzZ0TXRwSjJYNkxi?=
 =?utf-8?B?T1Q2b0d2OWswRjl4K0ttSU1CRFZBOTRuME0yS2pSY3ZVNjAxcktXK1FLd2Rk?=
 =?utf-8?B?akRhRUhIK3JnaDgrR294ZHhrVVhOaEVZeWlQUUt0Q2lkM2VFOWRNdmFqRXdB?=
 =?utf-8?B?VmRLekhxL1gvWW9Yb0k0Z2NkQ1dHRktjNlI2QUcyK3NkeElxWC9nY3VSa2lO?=
 =?utf-8?B?R2dQV09tNU92KytLL0hQUGRRRFVQblcwV2pETUNMZ0dpSnFxaDMvdE1BQzlI?=
 =?utf-8?B?NDkxODNLTEtScElaSU4zVSt1UlRyRXh5VE9YTTVkc0Z1RUcveVNrRmx5bXBS?=
 =?utf-8?B?NHJ2SVhLeGdnNkQ1c3FSYzA1WkZlam1sTko5L2pVNElJeUp2eTVpSUQ3Qnhz?=
 =?utf-8?B?WGdraktIVHJURkNwUStva2lhNlhZUXRGZmlucXFtQWJVd2dzMmJsMWM5RW1l?=
 =?utf-8?B?QkhoMzdFYk5UZmdzdzFWTHRFVVY1OEZaYndkMld5ZGJLNFp5bGdrNXNvQytN?=
 =?utf-8?B?S0h1VFJVemNzS3FWYjZlZktJa3dUM1dyMGs0Z3J4SzV5SDFGYm51T1k4b2Ra?=
 =?utf-8?B?UUIrSFFnSWFITE5nbEdUYzUwemlHS0EweXdzUFdGVlpPRDNpdDdrNXo2dTVT?=
 =?utf-8?B?d1ZCRFUyekVjaW9OVy8xRXQzQWN3VmM4WWZwTGJNWHJ0OFB0NWxURWNMd0J5?=
 =?utf-8?B?UFQyRktPeWlaTEpSeWthV1BvcUkzeGJEUi9zcGd2Y0hIMEQ5YVAwbDYrK2FD?=
 =?utf-8?B?ODlMV0svK2JPeFlzeWYrVkRyUnRDVHpSZGd2SVVUcGJxMWY3L2VuS2gwam1n?=
 =?utf-8?B?ZDZ5T3BldWh5VDFvdzE1dzB6TDJ1RmZDSzEvSlhLS2VSVjEyNnpZZmJlamFr?=
 =?utf-8?B?YTBqQ0lPRXdPRjBvNm9MN2h4TW1SdGRPalVoNmxuSlVWLzVuV3YzQWZha0k3?=
 =?utf-8?B?bW41WVRUQmpjQlZ1UFU1bGd5ekdVMG1UL1h6Y3lBZDgvVmszS2VoK0F6eXRO?=
 =?utf-8?B?eXkrbUc1WjNRaEd5UVJnS0pCdm5CMUQ4YUFvbUh2M1pMVXduRHB4NWFML3Ja?=
 =?utf-8?B?VEtTRWRwc251WHpOdGhWS3JjMG1NWXQxSmVvcUhZWWUxcW5Mcko4T0ZWTHRw?=
 =?utf-8?B?NUJyUnhSejFmQ29veXVZSVg3cTRmc2k2cTBzVXl3OCt0TkhQOEd3YVN5RWl4?=
 =?utf-8?B?WkxPM3BMNlhrOGhiT2ZjRVF2T09NNkVpaVJJeWkyRFpiK3I0UEFZS2tzTVh6?=
 =?utf-8?B?U2V0ZVplMkZkOHNtaGRmd1IvdHlRTnFVdFhGbWxBY25xaFA2Z0xlT2RHRDZ6?=
 =?utf-8?B?NlhQVkpxWkhyeGJsZXE5SDZSdCt5d2ZGR2wxTXlZcXRWZC9UcDVvVDFZVEZw?=
 =?utf-8?B?Zk5rQzBoVHlITEgxQ1ZMREpqUWRNVHhGV3dXSkg4L1pSbVg3Q2hORVFOcFRj?=
 =?utf-8?B?M3lSWHQxZndvQk5NZERzTGxuQXFBblU4anBHZWxDZk1EeFYvTS9CUzRrY0dL?=
 =?utf-8?B?eVo2UnBNTFpiRXpMOVhQQ0wvaFRCMU55bjJrcVFaNldnNDVUZWQ2eXVIMkdi?=
 =?utf-8?B?a2h1RDViSGNNdFB3a2dRSEJscXhTaStyYkYyWDJRSVZsUm1uYTNPTERSNUZP?=
 =?utf-8?B?dGRRN1dSNWY3Y1JBVDF4UWVtWVZlMnY1YjlNM1hEWmV0a0lqMzR2WWtOQWN3?=
 =?utf-8?B?Mm9QQXdwVEJvdnFlZGsyY0dQNmJFeUN4c1BoT2FML0hyRFJob1hqTkxWRnFT?=
 =?utf-8?B?UDVlZEluUnVIWHhtN29QZ01RelFydmprR3NObDhCcGxrRlNpWTIrZjFHL2wy?=
 =?utf-8?B?WW5oYk9TM2sydEdYeS83U2t2eVlZNFhsanVQNzhVZmVZbktkd0cvc2ZzWE1k?=
 =?utf-8?B?U2wvL0pZWFh2aUpUY09PZjA3a0loYzlPWkVsNEo1OTZJSmFpSVVpN3FZYUVh?=
 =?utf-8?B?UklnUmJGK25qMjVVM0oyeHpnTVdSS3lLZlN5RmdOZTNqbUFoN3ZxL1FYVito?=
 =?utf-8?Q?eyxo0/LmgKozITRc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fc52a1-5c15-4bf4-3e3a-08deddbf9188
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:39:58.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UABfHOLDrOxihXFGg+tFkCJ4WP/XGwh5cyrT7ymwJHzo4BtoBtmeXGZddmM78xWw71qO3ITilXCQuQGth/oygwY8tBzLpIEUU81/8E4z5Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7878

On 7/7/26 13:21, Jan Kiszka wrote:
> On 03.07.26 16:00, Tobias Schaffner wrote:
>>
>>
>> On 7/3/26 14:07, Jan Kiszka wrote:
>>> On 03.07.26 13:54, Tobias Schaffner wrote:
>>>> Hi all,
>>>>
>>>> in some of my test runs the sched-tp-overrun test was failing with:
>>>> 2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED:
>>>> evl_read_observable(tfd, &nf, 1) (=Resource temporarily unavailable)
>>>> 2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN
>>>>
>>>> I only see this on virtual targets.
>>>> e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/
>>>> jobs/393605372
>>>> Mostly on arm but also saw this on qemu-amd64 in one of my recent runs.
>>>>
>>>
>>> Maybe improper/missing synchronization during test startup? Or when is
>>> this hit?
>>
>>
>> Does not look like a synchronization problem to me.
>> The key part of the test failure is this combination:
>>
>> /*
>> * Trigger an overrun condition by staying busy for longer
>> * than the duration of our allotted time window.
>> */
>> for (;;) {
>>      evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
>>      if (timespec_sub_ns(&now, &start) > OVERRUN_TIME)
>>          break;
>> }
>>
>> /*
>> * Now check whether we received the overrun event as
>> * expected. Since non-blocking input is enabled, a lack of
>> * notification would amount to an error (EAGAIN).
>> */
>> __Tcall_assert(ret, evl_read_observable(tfd, &nf, 1));
>>
>>
>> The OVERRUN_TIME of 200us seems to be not enough to trigger the overrun
>> or in some cases or at least the message was not send in time.
>>
>> I suspected the issue to be time stealing but saw the fixup parts of the
>> tp scheduler trying to handle missed time frames. I think we just have
>> to increase the overrun time but not sure how much to still keep the
>> fixup parts tested. I guess these code paths are only exercised on
>> virtual targets.
>>
> 
> So, do you want to drop tp-overrun from this patch for now, or how to
> proceed?

This is resolved now. The test is skipped since the merge of: 
84b8efc58b3db882d527e08b9e28af01fc5b2753 - "[PATCH libevl] tests: skip 
sched-tp-overrun in virtual environments"

Best,
Tobias

> Jan
> 

