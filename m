Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E83C8C73
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492423; cv=fail; b=URN5WRRczikRiikqnJOfGor30H79YAJcz0Gpv8IE+xj4r3jJa4gEZieO3Cm7C1FHqXBRsxPYBYtpVMoZYnCgr0V82+IgeLR3DGJrCsgOSAU9ztE/HIQE2mVR6rqidOH20Rw3QYIsTBtZVyVDxZH5hbVKsNMyRTEWUP3xWdKkVFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492423; c=relaxed/simple;
	bh=ZeUrJmmyy2nm5jKrAYd59s8KRcipvsi2HxRpnjP+inA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=el5XxVRxcbTf93kt+1NsWvL0eVbbtdAPqN5XHeHLPFoIY1fo8z4CBGaqn6skn26J8rKYrAmJeIo6uVeledo9D+JMPScmBoPpWXefNYXNHqRi2fFBNHX0mR9lIkPUpHsCA/wCMKogioFDbpfdoLiYqU8s6DzIDEPmokuPaHM5Qsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zveh4Zky; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zveh4Zky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKzWy9gWsDYfKb3YCB/dKwd7sA5pRGWJ3AhofOea6TKSccEojw9diVrCprYD5Z4kZ8ROP7VMm27EPoHBaXEPUf/cem8F1bUDPbnvca5ZgAt0ubJXJc0AbyJTzjgD3SXKMIL+rLeZs7hN94H+l9SndQxCRajGCJgxJLGD+0NzBqtROKbfv+Xqoj+3rMn0OCkB9vJVK09GRK4eQ+yRES7J6Nk+0GLsaUFJhnnQlRwG4j5m6jM744r4FiK9fpaD2Q4rQLj7MnWCMRymtNSmKmbrbyfNvhdZJfk01pKZ6uaiYwkth6/WNAUfFKoPMJHEy60XUPve7CLyL6vPpRDEj5R7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYyi8fTvvJLH40ng9uYi1UcxehHBrFphZGqHskPeab8=;
 b=BBqxoEKklbzGcVBHjr7tojbiINnDdlDT4ck9KdauR1VtaiLsptlNpXtQjh5ER0i5tZhwxyRfV2G4LexqciiUrd0oQUpKWadLv+CqvyC2M73Oi0EgQbcvUGeFEeSihAY+xKsL1dfRT3jmIrOj/dkWakVX7FaoxPF2b8GXgK5a57DO7AMw15izJwIpbkVwENJnjEupjT6b9h2yay/zgneLuyRx794MgHwSr7Muud087dY6cNlVfAZekBd5EzZ+iqmBHbzsAGoK6qP3fvFbGo1p9KKuMCVNHQVS/p+jeZnO+wfkc8ocv6XXJGcoFsk6gWMZz/fZifcE99guuGNy2Jzcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYyi8fTvvJLH40ng9uYi1UcxehHBrFphZGqHskPeab8=;
 b=zveh4ZkyNwoVttYqyq2hdyzUvdMZhFmmKbF3aWHZiaZM1NxKZLSLvsL89jbHH9pw1+o9nn3IngBXWFgT/+iYvczv2brKNZmvw35MvpJpEv51oalYBtwJVPwFPM1q4XToH3Vhn61h66vE73qrGiZdm+HievgYDSJCpxKJ8MnaK2823kXaM1/3JwYNxqxdCtiCuXv6E0pjsT6TgICcoxg2NlDVJ838fj7jj6xLavn26cCFFlacKfLp6bSzI1DbzD4n2DMCUe7Lstj3Pdh0TqHGA2n+y01p8oqxN6N0MZcrEGONK6z33mctC1c8rTpHrTwEISDJvVoEOuDHcQPJ1Y4Jag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB6945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 06:33:38 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:33:38 +0000
Message-ID: <3f229285-b3a9-457a-9e36-689bd692a8a8@siemens.com>
Date: Wed, 8 Jul 2026 08:33:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
 <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
 <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
 <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
Content-Language: en-US
In-Reply-To: <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 975f5aac-cf52-441a-c7c0-08dedcbad80f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10070799003|55112099003|22082099003|56012099006|11063799006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	EAHTOra/+NJaS1RXShDmlat7gDfOqbzIerykfGvLsQGDj33UsPdKfRfh+MhFiga2VP2MPFhixPPxYHfzycVJLTuga5zK4eqWy9zAyxdXwIczzJpyKp40J0jQAft2CLgmtWl8AIZItYhoHl7TTqhrbh+zewJ4SMUrdcb974DqE/vJBtbgdrtAw8mOHhz64baOtGF9LWa0DXVXMU2InOGy9GNrsD13qGX1lFxPi33FeWtGwgM9zzjA4IBdPYfPr8ZinuoiTxr37d7DoWnB6jktMgnUBfiM6OVH/BnbeV5VIXTm2rGoGRV5AJE9nYqxhF/lwnQ9xe6i7DXl1yUL9JnKyc4v4FiAln3gkdrMllv/n87AKN5Nvj11cXH24McEoDK3BULx72vksu2yjTcuafjPK0dYo2g3meEOz+3wWHu5aJXxqBsBykZvPCCxWLGr7YOeTStvu4Egtc3Z3qhz2KMwTRmJPSMU0HrrSfW18Ihj/neDZrcN2c7CS/L9QlQwOpC+Bg1/bN4bmvRHoxOK2Jf0lpCcNJraelxxwMbzuBxBQdK6aUFD90msbAK3FhzAd0ZQwyqa7Flrm4Vu2TEqQCnCMCv5II1EMXUwCzI25+FGgsg8MSvi4k5P1kzfZr6webcPi0klNYb6hm21HjA7Yh+Cttu0w6MO1UjNSqxVTZqc070=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10070799003)(55112099003)(22082099003)(56012099006)(11063799006)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTRKeXE0ZERLbkNpMGVNUml5QnV4TDhqQUhiemZVZDNZNUdRM3IvZzg3RS9S?=
 =?utf-8?B?V1lPcy9UaE5SSVJvbnNMK3AzNmxGU25uTjN0eDArYXh3a01xb1lSa3dHR1k5?=
 =?utf-8?B?YVh6bnVVUnlrdXZIQ1Y5WXVnYy9hdTFzei9kQTAwakk1KzFhZU50dThhRndP?=
 =?utf-8?B?ZUJnK3dCbldYVTA5MTBxb2ZiYUZ1ZXMxUFJpRVE5bGlvTWVERFdmbXN6bEg0?=
 =?utf-8?B?K0ZkNDc2cTB4MHRVVllReWNtQS9POWZOd3B2L1pTcmVuN2JzM3hKYnEwcTBu?=
 =?utf-8?B?aWVYanc5V1phcU56UkR4ZThyVUwxVlR1S09wcmw0dFJ5NDBxNXB2WkFEWUd2?=
 =?utf-8?B?MWVvOHUxUVdNZ3hSa2w1bVFJbkZ1N05JTEk4b0pEc0tWRTNWdWh1OStEajBh?=
 =?utf-8?B?cmw3WXJURFZFQjBlUlBoR2VmNEFpRUdwU3ZFOVFKZ0wwUWNMZlN0enF1ODYz?=
 =?utf-8?B?dmhjWjVnTUZxeUMwUjJEYWZPMVFmTnMxSy9aN3JQVHJFdXBzVytyUVhtTllh?=
 =?utf-8?B?NVg4T0E0VXZWTnhQd09qcWF0dWh5akFIcDllUHUvSlhWeUQ1dTJJcStqaU5h?=
 =?utf-8?B?OFpOMlYzVHJTazFZRER5bW14U3NJWThqRTZaNHpvQXhGaHdtdk96MHdaT2Jm?=
 =?utf-8?B?cDdTTURBY0dReG1DVVQrWGc4NjNWbktaVzRRNGpHeGVRNFFYQVQ1UjdVajB4?=
 =?utf-8?B?U1A5SUFVWE9UTkpyQUdUd2xQcm5ncmQ3dDk4cmFRSWJJQjZuR3JSZGZqa3Bn?=
 =?utf-8?B?SUVFU2s0dDk3TU5UNzhrS0JYMkxISUVtNkNmQ0RBb2JKV1JHVGF3YnZBakQz?=
 =?utf-8?B?UGloSU82bHQvbjFCUmR0aU5oTnJNRkxIc3JtNTJSclpKUE1OcTF1TUdMdU1C?=
 =?utf-8?B?M0hEVi9uc0srdkhMbmFlN0syZlB4V3Uzay9mdlVVOUNVVnB5NlE4YUJ1Lzdm?=
 =?utf-8?B?Z0NSdkRDT09LYVkwWkRNMlg0YURZZWkzbllOVXo2RWl4VWVsZXlCc0lYaFpK?=
 =?utf-8?B?TVo5SEpxTy9MdERGZUNjNTUvV1pTaXhqYkprWVN0Q0FYc0RuSjViNU05aWxO?=
 =?utf-8?B?ZExCMnAvWCtqMW1XNU4rYmdZUTBSZUhBcm1LSmFrMjQydGk2a1lJbmFCUGZu?=
 =?utf-8?B?ZW9kM1Z4RmRQbnM5b3dLR3VKM2wxWXRKTUdCMzR4ekhTNlVCN2s2S29MV2RD?=
 =?utf-8?B?cmY1cE1WSTcyRzF5Njc4eHBmR0hLcm1OOXQxUlJKNmdMSWhCb29MbnFlMElj?=
 =?utf-8?B?TE13MXVkbEtnelBUSEtmODltdDRYaG5PZWFWQnBQcWlxV1NPOXFQMjBESXNk?=
 =?utf-8?B?ZkZrSXF1S0g1aVU2TEJaNElUV1hIWkcvZU1ZTndYNjZ4enV6Z0NZVnI1ZjZP?=
 =?utf-8?B?VHhBUHdVUWFXS2RKUnF0TTFWaDJGMHF4cUV6SkRhclBqc1BtR0EybkhNWXJa?=
 =?utf-8?B?aUVqMzdKamo4ZDQ5WmtIK3oyMWpyaDJjODJpL3ZtQ0RXeEZOQlBLSGVyUVhx?=
 =?utf-8?B?blhLYnMvZ1JXSWpsT2luUnB0Z1NBZ1JkdGQwNHdWVVBHMjk5c0JTeWVhQ1h2?=
 =?utf-8?B?VVZqYmJsT3VpdGFrSFpQZ09JVGZaT1loRkFTSUs1VHJRQXhDMUI1OElTUGNY?=
 =?utf-8?B?YVp6a1JSU2tlM3k0TjkrbEQrSFJySEJ1WGoyL21OYnYvdmZnUUNzdHNaVEJX?=
 =?utf-8?B?U3RCY0VQVFBOcm5YeFVLbHNMaitLTE5zZkNoK1NIcDBBampweDlNN0lXVDh5?=
 =?utf-8?B?bHRFYXpCM3B2U1VkOEhYOTRyOGZtcERaaXBDRzFPMEJZbTlYUVkybFNhMWV1?=
 =?utf-8?B?WjgrLytGVkJONUUwM1FqRFVyS0RIWXNhVHFGVWI3V1RNUUxZZmhsbkNCWTI4?=
 =?utf-8?B?bVlPalRtMG9CZkMwRi90Z0FQbW5PVHRiRi9wTU5mWjJTV1hZZEJtd3p2OVAr?=
 =?utf-8?B?ZG5kTnJlYTk0UjRYamgxRVh2UHVzWklSckpCRzRsM0VaUDNiNDl0eXlGMXVV?=
 =?utf-8?B?Nm1DMVVUdTl0N0JjN3lQZ2t2SzRlNDlMZnA2bnBOaE1EWTcxMmIzZmxFM2hM?=
 =?utf-8?B?TDkzRHN3dmRmSEtMU29mM1Rmak5maGp4QTlDeWNqQnhRYjZsRGFFR3gzbjdh?=
 =?utf-8?B?L2ZMZXVFcFFlbERaWEZWZ0xLdVFkdS80QmZBcXdxaEcxL2Rqb3JYWllOS2wz?=
 =?utf-8?B?RWJxQVRnRllVeGNRZnFkQWZJemhkM2lITTdaZy9ibSt2T01JUlBGcWwrYXdz?=
 =?utf-8?B?MVNyb1V3cW5rckprbytXZ05FYi9TbytOaTFHU0lielJ5blc4NVZtSHp1S0ZK?=
 =?utf-8?B?ci9oNmlML092SEtsTm1NbnhwS1QyTWNQeTVhSk9DTUNoak5SVERjOFhhN3p2?=
 =?utf-8?Q?79L5tkb+p/oZX5jfI70vRX+qOksPsYuI4oL33sI8F6KDI?=
X-MS-Exchange-AntiSpam-MessageData-1: ztpXBFvtEfj9D+5YY6AxQ1gM5zOgVTgmS3Y=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975f5aac-cf52-441a-c7c0-08dedcbad80f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:33:38.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofqkYGsJlatqbEgzSa1KO5C8jFL8OCB5Tu5swgj8JRaz6hRVad/2V841fJP4pu3yEGpzqkd+9yPaZrnM6iqMAIFZ37J45vCcXeEZ4gJkOKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6945


On 7/8/26 08:26, Tobias Schaffner wrote:
> 
> 
> On 7/8/26 08:07, Jan Kiszka wrote:
>> On 08.07.26 07:17, Tobias Schaffner wrote:
>>> On 7/8/26 00:30, Florian Bezdeka wrote:
>>>> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>>>>> Hi all,
>>>>>
>>>>> this series introduces an initial EVL port for RISC-V.
>>>>>
>>>>> While some tests are still failing, I’d like to share this early
>>>>> version with the community to gather feedback, reviews, and hopefully
>>>>> some assistance in refining the port.
>>>>>
>>>>> The patches have been tested in combination with the Dovetail RISC-V
>>>>> port on top of v6.12-evl1-rebase.
>>>>>
>>>>> Looking forward to your feedback and suggestions.
>>>>>
>>>>
>>>> I tried to apply this series today, and run into the following issues
>>>> reported by my tooling.
>>>>
>>>> Patch 1 is fine, patch 2 has some checkpatch findings.
>>>>
>>>> A couple of debatable warnings like:
>>>>
>>>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>>> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
>>>> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>>>>
>>>> WARNING: unnecessary whitespace before a quoted newline
>>>> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
>>>> +
>>>>
>>>> In addition to a serious one:
>>>>
>>>> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
>>>> <shanmu1901@gmail.com>'
>>>
>>> I did not get any responses from this email anymore. I can try to reach
>>> out to him one last time, but what do we do about it if he will not
>>> reply?
>>>
>>
>> If I read that patch correctly, it's majority is taken from the
>> corresponding Xenomai 3 logic. How much is unique contribution, how much
>> was your work, Tobias?
> 
> I added the evl_set_fpregs/evl_check_fpregs content which is a 
> translation from what Gilles Chanteperdrix 
> <gilles.chanteperdrix@xenomai.org> did for the x86 and arm architectures 
> with some isa enablement bits added.
> 
> This should be the initial version by shanmu where I added this on top:
> https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv/ 
> evl_port/arch/riscv/include/asm/evl/fptest.h
> 
> Best,
> Tobias

PS: We have the same issue for:
https://lore.kernel.org/xenomai/20251009125736.3520623-1-tobias.schaffner@siemens.com/

> 
>> Jan
>>
>>>> My perspective: We definitely need that.
>>>>
>>>> Best regards,
>>>> Florian
>>>
>>>
>>
> 
> 

