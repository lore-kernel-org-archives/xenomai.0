Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C0E3D890B
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087229; cv=fail; b=SMzq3KyLAk2fOC9D+kExDeHGZk5Z64+b52efiJMQZvQ2Y0WtRJumJSCoDXeq8wrVfY8Q/owUWE6Zm9s0h+i4hRFYZq10QysY42HJrc6vZvwPqb3JQM4RpaKnRZMzMPowEg76oKqmMlRMMNbBBdNseKXzSMKp/a1zi5U85L4QxSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087229; c=relaxed/simple;
	bh=vHwXDbunH6C6Ub6UnMY5eAfOmhDCIcD5ZEL3/jFnvq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g716kwDM/hZ4EV/7gSUtW3mbdYauMWpPblTujXOSlLg8LQ04rlqbwUKQ3OoVTP6bqHBi+49QMvNCBbHFsvU568LT6kJgdr7C/HTp8tabe7dtwK25wLpXKMizeR+4YUgK9q1gfvf95F2gzIw8mF4LjPq6hWoegtm0kKVOR/g47cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fCwglyNp; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fCwglyNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuDrn06yJ47l7tADGkkCp6+wC2s0j79apRgnzw8JuEtYWzey0JkFN8RhZp+as7IY8LUc4CGynwEdrY3A6Kl4/JLY45wuxO++1Hgc4GG/uPM10T1Xgo8ORDR0n3AVbDTKzajIcl8PlEtkDRKZ0XjZppyYk95RcIXFB/cZNP3mB28rGJj9cnZHPwjvaAY7ATuuFTCKdlw3PBJL6dBRdkDxrSfcd6NiNqBsEotwtrQUoskSsZAlpdBZ4wpS0bMTWyfrHaUpe+AR6yQrPxO9MawY0b2U7lqxOWGGZERNjK3vVeZgXEHYW+WtElkvu4usECG/ZFh0PPEo2nmk5mLFgllciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idUSuqijEDuXVN0652TJc77NN/YSn3GxbNRCaAKCH/Y=;
 b=Sr7FYjwAQvGBBvkedGKY/JtuC97DaqmSPwssHf52VS1xVzXoxLuCfxT/LQ8EwrHX8STmqxQmMQ8owveBflBlkHHxwgmqqV2WIH+lMRe3I50kSszOFSyxzSUz5nF8Vo3sOBodCuigMhd8pZrXuXn1pn8fPFEdDkV8UjmwJVxidYNsIiCUCKSnVtBOJwN9eWdRnGGq15GiQ+O0xcEmr6OzlZHQRq2nAzas8Xw1fFXOWB69RK2yvTi3/haj4lcQ8nUc2/DufpdkX0CtXb28lW7GnAXZr83xVRB7r/Qs89unfLFtF+K/1hXMfDocUGbnLUPBDdMHRqq101MDL5Aqceckkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idUSuqijEDuXVN0652TJc77NN/YSn3GxbNRCaAKCH/Y=;
 b=fCwglyNpTdn7lCI+HwVm5HMXZ2DGniAsuYY25jk8Bv0MoJIPhvbcVBfj3dFTR5zPX+ffjlajevTdRTVrmZxzEL5W4chr6LVOOM28eTfO8+YMHWSgDZIEnqdMRMyQvwYrbopTKdBDKb8ifW6k0ubvL3XRUg7Iwp2fXqMWulmHlVjsfkv1cLVOLX5pPYC+rMPWQwPaTzLPlaCM8SNS8OZF0GaIEA2zj6FWrI84oEkLURFx+U41fjQ5Q5ivfrVoSPYsmcMfU02i8qKlDhl9EtJiXhd56qJZ85/veY4n4c7shZoiU5IIlwcZIif4KN1Unax4d49PVQtnVX3lEmmYd0lk5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS1PR10MB7620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 14:00:22 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 14:00:22 +0000
Message-ID: <e7debecd-2490-40e8-8223-4e076d39165f@siemens.com>
Date: Fri, 3 Jul 2026 16:00:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have been
 relaxed
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
 <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
 <88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS1PR10MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb5fc1d-d70c-4623-07a9-08ded90b6c87
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	y+hUTJRwbY47Zxr2yPjHVU14rs0zwqdv4Z2wc4ujuwrgrhzxXtXTPwzZ/qUHGp1dQCnl1jRjzxIkzBRNb/upTzk7wEh4wH4PxUIV9mgl+xImQ+iEDrdDKiHLdjfOkI5JQVd+1rHUwR8jf2pYnu/CRLzcpchCvk0AUNwrnry1VJpwm/Tyh6JuwfREAfFQGIONADrCRAkbXVub+sQs+VfQwK9YjHygNhZcMJXrHPifVXkjQJYQHnYM5zzUhmp87azIvHM0LH7JZl/d9BttrhX7YlJNQOyo9xrj0yj3gNE/twhEbfBvHOUF3BYFLwLxyw+GurtMGtuGbYXnarBwWPxlB0Eup7+Cdhel/3H/Rk8EjVV69PQ568TMonls+8HWcrUZF7G3rI/Vn2u5zka9PYXER4zcavKxa+7ODtcGNdykSs9jw1MvlE1tkSFB3NjYWw0oV+Fx6+ctjWR8oBKujjiyLQi/yNrYd5kC2nuc1MFYux+ruTpw0OGWaxW8oo9HA3EtIsizJVzNgSBeeG9h3+t5O4/BbbSLkzA5yApLHzeTwnZO35JlGTOVReynct+wn+x6r1Pj4XjhXG8PvxEZJPZTVzRzSDlgx3EcUtPm0t861Vw+QVtcIy2AJAsoZc73Xv2JZSz5vNnmNozpdRrWyAzKaA07rovuyXUiPmwh4S0nOXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktRUExWam95ZVpDR3dHZ0MyUnVtY1JPMktSZjRYUCtyOExhZHNHcVM0SFlx?=
 =?utf-8?B?RThURzMydld1ZHdrci9ObzZYbUN6UHQ1aXRDZXBsdWVpQUM5ZEE4TUZHQ3BR?=
 =?utf-8?B?Y1I3Q2kwN1ZhQWxaZWt2RWpMM3QwaFRUYk5uSGdVV2w2SGN2aUxDbFVyS1hK?=
 =?utf-8?B?RFRBbjhKajgwbU5mNlhhanBIZ2xZKzhab2c5d0txSE8zMW1KOUdhclBkWU9O?=
 =?utf-8?B?Vk9LeWFhU1dNYi9QUzB2blMrcy9oM2RMcjFTclNmZ0pmRGFRLzBycHhXdTBQ?=
 =?utf-8?B?Q3k1VVFMbG1KbnhCWlRGWXZWNVdFR0tibnl5ckROa1lwWjJMa1VCdkJVVnNL?=
 =?utf-8?B?MHNsN1NQZ3g1UlBBRlFFWVhqSzkvQjBDQXdwYk9YRXdBb3VqRWd4a21LZHZE?=
 =?utf-8?B?bE05aVpCeTFkK0o5NXBoU1l4VWpUNmdIY3lyallBUzkwemNmODY1end1aWdG?=
 =?utf-8?B?WkFEZVloT2hNOCtyRW8vVXk1T0V0UTdVekxXanA4Rk1YMWNkTjZVdHkyOVJs?=
 =?utf-8?B?YzI0VmVkdjd1elhQOFRZbW50QXNUODJrRFhZWDVJNXVuYStURWI4K0N1Rk93?=
 =?utf-8?B?WTF4VDdmMnZBd2VrazJ0Ty9ENTFNOTRjc3VyekU2bk50UFY2aGVDTTZhb2Iz?=
 =?utf-8?B?T0ZpNGk3L3hrS3NWYmM0dHd3RHJFRGRCN2RHUWZPQ3hVRzVCY25sL09tYWZF?=
 =?utf-8?B?SXZJQzVJaTZMZXBJTU5FbWhFMUlZaXJoR0F5Z0RBYVg3Q2lTald0WVRVVVBz?=
 =?utf-8?B?azl5bGdQUEE3UkNyY3F3U0JmWENRRlFBdDNpTVR4TXB0VTIxcmRTNjFtYzh4?=
 =?utf-8?B?VVE1ajJ4aVhvN0JWZERHdi9VSXYweXRGK3FQZXZWTWNKYnVJWmtLTjRqdERw?=
 =?utf-8?B?bVNEZGZtRTBJZ2NYL0dEVW5uVmowVXkvaE1BZ3BzaURPNUVLNUJ0MDI2SnQ3?=
 =?utf-8?B?ZlVjNkxKZkRRYXFiRHV1bmMvZnYzUlZaemdiOVBkcmR0SjBRWThmU1NLWDZT?=
 =?utf-8?B?UVlDcUFLVHhxeDc5T1I5czJQL1VqT21NU0pZcDRQQXJpeHloQVU4Rms5SUg1?=
 =?utf-8?B?TUh4cDJTNERJaklTcFgzS3pJVGI5M08rVjVDZUE1N3Rla2JjVWlqYS9nK0Zv?=
 =?utf-8?B?eEhKNVBFcVZmcWhNZUpPclVXMFNQWWVJc1p1ZXNiR1RWSDVVWEhlNEFPRy83?=
 =?utf-8?B?bnVCNnpPYTEzdktMZ09CSFlNSjNJOUt0ZHFncjNGc0VZcFBaK3lyd1llTm1Q?=
 =?utf-8?B?M2R2TjU0OFhjcXRDTmxJd1gwa1VLVy9od3c4Z09YOFkvcEtLdyttdDlRU01L?=
 =?utf-8?B?MmdaWUN5VE1DRGxIdXBpamRiM0c3ejZEOTNBMGxaNjVja2Ixa2tZR2l2c3dt?=
 =?utf-8?B?S1h2ZE9GUXMrM3BOL0VjOEpNcXlUcSszZ25YL0RNZkZYaGFoNk1lZnROeDRU?=
 =?utf-8?B?bDZac3dNbkZNRkl2NUtrd2F5U0RRbXp6TXF4Q0t1N05uKzJOK1NGdEJjaWcw?=
 =?utf-8?B?R1I5QURpOEdHZXNzM1FsK2hGeGQyUWJtck53MVI0dWtDempnMDRzbVR0SW56?=
 =?utf-8?B?ZmdPQTcwTCtpeG9ObkVsNHhkQkhMTlgyRXBaQVZOZU5CQWVVcmd5WmNSTlZ2?=
 =?utf-8?B?dXBrcjRMRXRXVTNwR3BMbkU3TStCOEVzZmw1d0JaM0JJNTh1YkxpeDFFTjFs?=
 =?utf-8?B?bktvMWsydVkyZy8yaWsvdUNDYkp6TmJHR1gxcCtzU1ZKT3lPbHhHbmYvYUFM?=
 =?utf-8?B?eStqK3hMSWxJTlY2Y0VQNzBPSWtTWWpVeFRaVi9ZZVFacG5RbEgvUkNzN3Nu?=
 =?utf-8?B?MnJ2TGZ6VkM3aFlYZmVkcDAzTEgraGxETDR1M3FmNHczanE0K0JZT1NpaUVL?=
 =?utf-8?B?d212c3AzT3pla2c3T2x6KzlnSXRraHFXdUdmZ21OVWJKK2JSVmpiMjd5ZFRm?=
 =?utf-8?B?alFrT1NCaENtVFludHBWeFhuV3NEVjRka2p5a2FpT0dkTlAyKytDckx2WXAv?=
 =?utf-8?B?OW0yUGFPZUpja1JDVmFCZG45T2I5ZHdzM25zaEtjblh0d0VybWZjTkNVZ1Z1?=
 =?utf-8?B?NkpvMDZGdVZya1FBRmwzMitaNDBlcnRMZ0JPR3pwdHJaZWhoSk1FcmtpbTBG?=
 =?utf-8?B?aXh6MUNuTFVqdmpDTWhIZUVJeTc1TkRHSmt4TGtVSEo5T0NCelRIV0lhLzFI?=
 =?utf-8?B?N0xqUjh6UEhyeHNSajZEQVdEUGdPOEQ3WVcxNThFMlRwMTg3OWsxOVZFZEVW?=
 =?utf-8?B?SDNPUUx2YjBjUXRSVENreGREb3RmVmx2ZXdwbVBsekcxSGVhYjBXZ05VRUkz?=
 =?utf-8?B?K3FFRVlZVkgvdnFWVUl4ckdqa3VmUXN6RDNNK2pyVFBJM1p6cU1Kc0hPZksx?=
 =?utf-8?Q?aA+LNOUhMb+AD9M8ab2gPawCGlA4rGmI5TXt2DnKfIDUO?=
X-MS-Exchange-AntiSpam-MessageData-1: hqNzRtw71tI60duoDXR/eQ7bQxW+Xf9axtI=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb5fc1d-d70c-4623-07a9-08ded90b6c87
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:00:22.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQW6S2Sw7h1NI3yyCWJf0E4pjWquFZs9jH2xRRZXvZGAmJcI3sCRZnI17FOciurabdzruQ24uIBa8I5YJfF2zH3ayW3lBVdSbIzxCX9vn4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7620



On 7/3/26 14:07, Jan Kiszka wrote:
> On 03.07.26 13:54, Tobias Schaffner wrote:
>> Hi all,
>>
>> in some of my test runs the sched-tp-overrun test was failing with:
>> 2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED:
>> evl_read_observable(tfd, &nf, 1) (=Resource temporarily unavailable)
>> 2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN
>>
>> I only see this on virtual targets.
>> e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/jobs/393605372
>> Mostly on arm but also saw this on qemu-amd64 in one of my recent runs.
>>
> 
> Maybe improper/missing synchronization during test startup? Or when is
> this hit?


Does not look like a synchronization problem to me.
The key part of the test failure is this combination:

/*
* Trigger an overrun condition by staying busy for longer
* than the duration of our allotted time window.
*/
for (;;) {
	evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
	if (timespec_sub_ns(&now, &start) > OVERRUN_TIME)
		break;
}

/*
* Now check whether we received the overrun event as
* expected. Since non-blocking input is enabled, a lack of
* notification would amount to an error (EAGAIN).
*/
__Tcall_assert(ret, evl_read_observable(tfd, &nf, 1));


The OVERRUN_TIME of 200us seems to be not enough to trigger the overrun
or in some cases or at least the message was not send in time.

I suspected the issue to be time stealing but saw the fixup parts of the
tp scheduler trying to handle missed time frames. I think we just have
to increase the overrun time but not sure how much to still keep the
fixup parts tested. I guess these code paths are only exercised on
virtual targets.

Best,
Tobias

> Jan
> 
>> Best,
>> Tobias
>>
>> On 7/3/26 13:48, Tobias Schaffner wrote:
>>> Remove the broad skip list previously used for tests that fail on QEMU
>>> targets. The list is not needed anymore as the evl test suite autodetects
>>> if it is running in a VM and relaxes the tests as needed.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>    ci/lib/gitlab-ci-base.yml | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
>>> index dfb33ad..0540628 100644
>>> --- a/ci/lib/gitlab-ci-base.yml
>>> +++ b/ci/lib/gitlab-ci-base.yml
>>> @@ -123,7 +123,6 @@ default:
>>>      variables:
>>>        ADDITIONAL_XENO_TEST_ARGS: "--vm"
>>>        ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>>> -    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|
>>> sched-tp-overrun|monitor-event-untrack"
>>>      rules:
>>>        - *test-qemu-rules
>>>    @@ -174,7 +173,7 @@ default:
>>>      extends: .test-qemu
>>>      variables:
>>>        TARGET: qemu-riscv64
>>> -    EVL_TESTS_SKIP_PATTERN: "ptrace-sync|sched-quota-accuracy|sched-
>>> tp-accuracy|sched-tp-overrun|monitor-event-untrack"
>>> +    EVL_TESTS_SKIP_PATTERN: "ptrace-sync"
>>>      rules:
>>>        - if: '$XENOMAI_VERSION != "4-next"'
>>>          when: never
>>
> 
> 

