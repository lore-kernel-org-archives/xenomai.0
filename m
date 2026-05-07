Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B787373C10
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156619; cv=fail; b=ihSws/y7d/NwickQ6C9TcTUA70bOeUZVhTdbGAEcUBpLl+wMSN7HNlu4Eq8w5TpSHfVRvs0O7Z0q7s5uWAUk0PzkfToAk+8lg/+7SkMN5FGIhcbkUYW5RSc81oZnySldc5cLs7ECvRcV+rtcTH5gJjbrJQCszPgIzKLLDcPYfPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156619; c=relaxed/simple;
	bh=x2MSIuOygh+WmeqgS+7/exBPCpmzoZ3s+H1TuRbh6hk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALHD9z1+28mj0MUjhCNH3O/GEGy0u61TaDr6tinoKZ+CNmcZ8B+DgnlU7nrjwDjVoVxOTiuNUWcuxafMLYvxmFqf4LHzpIIk/Me0+R5xvVpTcUPpgp/il7xwXFAgwbkSUZlnKevhmteL6SktwqmTwpjYpi1pOUIALXlvCch5Vec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ir9VGg7b; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ir9VGg7b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRsx6TjKdkigU20w4zjt0CiXEYxaAekcEg/5Qh5mIoUEUlndnqYoVzpjhgs7vlhfDFV1OgRD/klM07FJQGmhbbErP3p1D1Wjo9IGjgwV1oIm6QRllbZuB1RoUxyL/ZHbXp5UYwQ76dPKK0b4JhiB8NamnIgKaefJm/ATfFiw8ryhSXcjayIyyAK+W8kOy/Gpvah/UTgzzV3ki3GuajguhErOXVyKpq3tV7CG1N+eNAQxUvxIlJ1gdVs+YPVWCY57ZZkXdd01+kYND7bIBlJp2mXdGUHktVyeV0s492NIZTIq3L3fcoJJkMZbvj8qYNpPvFz4tgi/SoB7CBmi3dk1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSTC1SbTiqvrgEG7G3mfI4FJh8tGclUaedT7pSsSK4k=;
 b=TGrQhzrtyEzwl/gWj6prIWS2/PCCrBV8Bfx/SblzBqXFitLF1dbfcbxcNNgFVDDuZukY69WZ69a3Q614Z8NDL+BqZM1UOjtWTZ/3m/drfchLkXbLFiJKExVlSjKNcl2RInKsQPdvWEr9cl1gG+SjKrmSlVjqgu9K+j3xwlrzYXL17mWqWnto4x7CgTmVIwsTNCu8DYZvuex6wBlvBzLcs8st8YNdd6tDF1K7RZ1PYnVK4ZD4pOZBR6YhEaWMm5fV8lHFXaJftmHs86RWIZfYPJlrF8S90o9WAHDMXfwZwcBCjnpAU7RY/fprZxVC0UQCiKyknDjdFvHrsK/W7gAX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSTC1SbTiqvrgEG7G3mfI4FJh8tGclUaedT7pSsSK4k=;
 b=ir9VGg7bVHMnZNdxJAkg6ZOj+Pw9kZqD1ZiYe44+H1H6Nzv+0Z8/2XkKaLWNMg1pblmQtltCNWZDdpTzVNYr57NWw/1S3r8+InmQ43UQ58kGsQQtOaIOyqDYyz/l1QnvalXNd2qTptL0wtktqfx24/uQ74TN7EDVqT6XI05KOF3AcPBnkrFoTjkKuvjsXeHD/bju6eUawnpOKWM7ymbiQ02sDh0DPylexwEooycWTStSB0S4Wi7Ln21IyzP16Jb3mbOfYADEWOXexqvJ7gXzkETa/F08YqlM4lb5OJNunvr+P/2I0oWg/b2z2BopmEBiAtkkYzezWV05Tso8VAW62Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:23:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 12:23:30 +0000
Message-ID: <50dd943e-4c75-456b-b540-5d8d2781d901@siemens.com>
Date: Thu, 7 May 2026 14:23:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/smokey/alchemytests: Relax mq-2 test over VM
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
 <dc069eaf339d470fecc3bae1d1f6e2d299c0cafb.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <dc069eaf339d470fecc3bae1d1f6e2d299c0cafb.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fc8be5-327f-49cf-a44b-08deac33730f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n8q+LgR7BmWescd2YlgQ2lhLPuHcQhXN8qeO1u1dcxxvRXRgw7BnC3p3Tl1jejIGVQHO3r7ACtBNupDDR87m8+fnxlJCOjo9443rsjwGh8akbQbNjQea3nqbGJ51+zg84B/IBWvkOuCgD45cgL6rX/CpR+Xf6o3Pd/gGfvSoO2As7nv40q1Xu3N+c5QOgDRHbGK0LWB6FtWqq7i4fVo6y/WKpIQ1P5iAFqk4NfRxi/iZFl/bEbDw9EOCXaWWAYio9l7w2/uAJnqCQZzwkR7Q9bRCVujRfitYAJUcsvPdZneuUeSKdfRAVy8qAVFZt9KCvvZeMjDO/0+yGlZKR7szpaoVbyj7D9Am8I6QM82CO1HcZoqs8tcO0BqMiRQOUauhAVk6Z7z/lUPKlQl8PdieJ7dcJYTV1eL54S6TTMuhnGWalNctrLLyJYWc0+oC0KOWxou4FonFWmlK4AP3KSu65EPbSUF3lGEDiSs4YThIfWrGx7PgnXSmDfSie/mqJAfC/8U+efBLUdeEqtsn3M+jl/ERQuUUiO2uHFBxUcVsQBVr405uK+S4yShgHzIGp1SvW56JtUiMkyIXrs/qFEtuFb5z2sT4Q85bfBUOjUhDZsAR+qJ5zpwXub5XZIItc7402NacesQWyCoK9cifV+E+Ftdv63L/EiwWArcS8WkO4qgn4k9thoFCDTt+bxjv/hGh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WS9rWlI5RTVxL3BMdVNEQlYxR0s3V3ZCbi8rYlRXcktCVVBLQWNYSm1FZzZ4?=
 =?utf-8?B?SEg3QTFzQSszQXVzSzZQZnFLa01xd1F0eXRWQ0wyc3hRZGl5eGMwQ0VpN1lI?=
 =?utf-8?B?L1c3VTdnZVhDMGlnc1pSZ0UydEY2N3J3NlAzdXRDd3V3MnBRc3F0ZnozL0E4?=
 =?utf-8?B?RlcvRGJnenpqMTJvRWJyUEpRZjVTTy9QZkFZSTk5a0szUlVZS1MvVTA3MGdL?=
 =?utf-8?B?Y1d5d0lsWUIxUEJiWUN6MDBHM0dUUDd0NHdsK1ZqWWZ1Nis4dlVKMWRlMnl1?=
 =?utf-8?B?NjhtcFZKYjgwUTg1d052cDk1TzMyRGhtRVo5T0lJbTdJVmNlMzhPcGdOc3Nx?=
 =?utf-8?B?cmRtOEwwb3NvTXVtblFHK05FNzV6Y2dJS281cmlqdHNlT3VoT3hBL2c0bGNo?=
 =?utf-8?B?bEFxVjFQNUtISE5jSlB0b29NaEU4UlRQR2g5TElvOEJLaGlQRC9iRUJtaC9s?=
 =?utf-8?B?N2JGaVdlRVhsckI2L2FvRmtTWDNHSGQ5enE3M1lBUEYrT1BRQURhUGJTWW5C?=
 =?utf-8?B?YW85aTRwNm53cmMzcW1Id3pleGJ6ank3ak9oUjEvUFlpTnlReE5pWFU2ZFZp?=
 =?utf-8?B?VXZ4emRocmdmZUtnYjRyWlErWHpmaTVoK2ZhR015c0N2TVUyOUJOSTgzaWdG?=
 =?utf-8?B?N1Y4cDZtQmhDcFBxOXU1ZXZSeE1scm5BdFBlZ3dZb05Dd2l0U2VFNnFNUk5J?=
 =?utf-8?B?SGFBVTFhbG14SzZJK1VINFZlMDNYUGZkVlFxa0JvcTAxZjhndzRpWnpieXJK?=
 =?utf-8?B?MUtVbU5qMys0cEtqSUNPbWQ5UkR1dHc4TTFhaXBkREJUMGlQMWdkN0lCcTdT?=
 =?utf-8?B?NVZLS3REV1Y3OEpHbnk0TjFtbkpVeE9icUxleDNxQndudGc4STY3R01odTR5?=
 =?utf-8?B?R21OcGhaNmZTcENHL2ZCN2FQZDRwSnRySnZzNTM3TzFvSnNUOGkrNHBqNFNr?=
 =?utf-8?B?MEVHcXRBR3VpQTNMMW1iMjJ3ZmFSTFZFbFJIdlR4bHVOaWlBOHIxUzU5ZGdj?=
 =?utf-8?B?MXkrMjlUR0ViUnFMUUxIcklHMHREWmRCQ2lNYy9xSzhSQ095K3RrMnlGQ3FB?=
 =?utf-8?B?V2ltVk5ER0dLQW5BcExyUmZhQkU4eG5wUTVNNDY0WU5XUER3dm1EejAzZHNq?=
 =?utf-8?B?Rmh1aVIyWU0xbm01SXVCODZJUlZIMWFaNWFPR2pPQWp6NTh4RlN2UHM4VnlJ?=
 =?utf-8?B?N2M1MlgreXFYZWdOVEtOQkdoa2lFbmNvS1Y1dUEra3ZCTnVTUlVEemRJeHdN?=
 =?utf-8?B?dm4zQUUvbERKUXgvMXphREZqWXRKR0JCUmpTejhFWXZEdURUUThqc1RpOElS?=
 =?utf-8?B?TTVwcEVZYTBlbWVsNHAySFhxdU9TaDdQK3NIMjRMV3NPSjdyeGZIUlMyUkFt?=
 =?utf-8?B?K3hkK0FHdzJVdlRQUnFtSzIxZHhzY1M2SFprVS8reHA4OFIyQnVPQXNQMEd5?=
 =?utf-8?B?UTZiaEJjZFUzeTZNWTRROVJQb2VSMDh1bWM2RTdaRUVyc255ejRpczZXZmpB?=
 =?utf-8?B?SjQ3d0xOZ3RPY0E3Tk5TSDdmRTRXVW1mQnlhTFVlNnAzazJZOGFFMzRyWEJ5?=
 =?utf-8?B?a09vcHBNTjk1d2djbk4zblhZeXBmdmVhWDl6bEpaa3kyYi9EV00rWHI3V2Jh?=
 =?utf-8?B?UkN4ZFRUYkdFTFhVTmRjbk5KbkpWdU5RVXBuTTB0RWc3K09nMnoyZmdFMzJL?=
 =?utf-8?B?UWZXV0hmL0t2bU9oSnZFTURUQ0QxamR0NnFUZ3lERkZvRTFSTzgySnZGaHlS?=
 =?utf-8?B?anlNUGtnK0tlN05RNlIvelFjNEx5R2p3blJ6U3IvRFh3WUhJTW5pNVpFU2RG?=
 =?utf-8?B?MzVUdUZ2MnY5aVk5KzVYTmkvaDU2QXpmR2JqbHpTa3dYOFBSSnE2VDY0SXJW?=
 =?utf-8?B?VWl1bURCZm02c1dITzkwS0pQTHVEa3JOUm1Na0NtYkdSUVNkaFEyK0V4THo0?=
 =?utf-8?B?MS91WThYVEZBYkxCWS9hUnZwL0R5YWlFK0FIUHpLNHA5OWgyNjV4d25vRGov?=
 =?utf-8?B?Q1RINFZVSGlTbFlJSUdpM2VyUTB3ZnRxWjlzSzZZYkhOZGF5OHZPYm5UWFFm?=
 =?utf-8?B?b0cveEhTblNUcXdqVGhoRTdoUzRBNThLZ0FnVDNhYTBJNUZ6K2g0MzVrYmQr?=
 =?utf-8?B?YTU5WDlLamUzdm9hU1dLNG9RQmNjcHZLVEFvUUlqcGhDWlVWZGpvWXZINFF4?=
 =?utf-8?B?YXF2VjJBYlJid3lLMSs1WStvYkJEdGJXVjV2NEJreUI1WVF4RVZKYml5MGI1?=
 =?utf-8?B?UDBndlZUTmsvdjVWWlFqaWsxRVA3YkRvMFBGYlFua3hvVnVBYVdLaEFyLzF3?=
 =?utf-8?B?eGFTV0dNUDdhYTAvVTBCK1g4SitwNGhGQ3ZCNmJ2WWJNNW1pSG96Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc8be5-327f-49cf-a44b-08deac33730f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:23:30.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBAgcJIECbYnP9zFROU1JAvw92QaU2IXwecgLvD5o6vy0iZ6FazIZ91+YAdSFAoResJLP7aP0xDNEUPkCjLc7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6114

On 07.05.26 13:03, Florian Bezdeka wrote:
> On Wed, 2026-05-06 at 12:26 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> VM environment may delay or reorder the execution of tasks, so relax the
>> checks.
>>
>> Part of #52.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  testsuite/smokey/alchemytests/mq-2.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
>> index a389e46db0..09b26b2135 100644
>> --- a/testsuite/smokey/alchemytests/mq-2.c
>> +++ b/testsuite/smokey/alchemytests/mq-2.c
>> @@ -7,6 +7,7 @@
>>  #include <alchemy/queue.h>
>>  
>>  static struct traceobj trobj;
>> +static bool on_vm;
>>  
>>  static int tseq[] = {
>>  	3, 4, 5, 6,
>> @@ -87,9 +88,10 @@ static void main_task(void *arg)
>>  
>>  	ret = rt_queue_inquire(&q, &info);
>>  	traceobj_check(&trobj, ret, 0);
>> -	traceobj_assert(&trobj, info.nmessages == 0);
>> +	traceobj_assert(&trobj, info.nmessages == 0 || on_vm);
>>  
>> -	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
>> +	if (info.nmessages == 0)
>> +		traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
>>  
>>  	traceobj_exit(&trobj);
>>  }
>> @@ -99,6 +101,8 @@ int main(int argc, char *const argv[])
>>  	RT_TASK t_main;
>>  	int ret;
>>  
>> +	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
>> +
> 
> Seems a bit risky to expect --vm as first argument only.
> 

It's not a new pattern, and I thought (please prove me wrong) that this
is already a filtered argv, freed from generic switches.

Jan

>>  	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
>>  
>>  	ret = rt_task_spawn(&t_main, "main_task", 0,  50, 0, main_task, NULL);
>> -- 
>> 2.47.3


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
