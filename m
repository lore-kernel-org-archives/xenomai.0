Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5B3FDB
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 05:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GspwYpuRnbuIqzhw4pajCC3aTrfQL0jWcnKQY+JqSQcpzs7AT0U6Jsgo49o94AoiP2ciyCjONzCCcJNHDpUGVo2WmNhqIXhpps7/9xM0onLaPb670Z+79bEx5Zh4flyvMtdCRtG6kbqUa9D5BM8I6uOAva1NH//Ejcn+WOeY1QL+HAY+xqp3mFXd5AHQ3lbbdlcRyIgKMgaeXAq3g12Cn+VTg9jMDxJ3l24vcdobj7y73ifzMW4shqSvWoSYAesPoM8d6XZIO2kln/TibskoP/rYymHPLmhGJh+np74QWBfleu4R4A+ZhMl/3C5WwayoMiYh20xovQsERCleqMKSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ucTOcwmLD2ZC1AEMJkAMeuBhshrrvA4R/AcG0rGroY=;
 b=kv6KezkP9PWVnozFVN6xNfcCyuGplhJ3gym1SquW6Isc0kZUhUPxxZx3Y6PIbNQtuIL5PXA828I+t5lXCuiRcdd6uLEcrfJCeQ7MoJ5sqSn7tZJ65aN8MzZZIXvhR5d/W4x4LH1zCvQRzZfu23NtDJyleE+IXp2JSMPGuUKUl2FXl4v3AnKVAUAci1/C1KybCrnAiEP9Ggez3SUTQ6vZu8e2K/y+57zKwLkMBxGGik8dFBnwal8mHlARwgu5qVQIfsvTzFk6KSjC1abYhikmfQUP9aKUsgtmD0ueiPGvBDEd7JVZtXttDzf6AZrrO2+9kZwiQGIcHUQBChGZ6VIzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ucTOcwmLD2ZC1AEMJkAMeuBhshrrvA4R/AcG0rGroY=;
 b=X/+Qnr6n7sg0H90FdGj/BkXq3qRWSH3MDKIqc3oFNLOkkzyYEQSgDoy5Ov5yxVLIpMQ/pckNlWkxfD93bGg1oRpu2AvgsgjV3mTTTeH8ZKEVVkurSC+G8k6X7OcgFPizgtVt74mDyJ7RmH7ZHIC31AgqgeMogQFDpopQfEZKtQjW9IG58anByx3oO13nZW/VW0iSV3tLvY4/rhGs5tWyxOLy+rDKtkdik4AkFdo9pJniKa7l3KcFLSs+OUHqLhNSL//Ed7mK7ERHzuaTrAqKCv/u5ofWj+DCHag0fhjfgcVL1rMHgkhPhzz1FNMMLNFLSObrg7Ed4jaJrAj8JFADsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 05:38:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 05:38:11 +0000
Message-ID: <de310dac-aaa1-024c-7edb-c5d47f01669e@siemens.com>
Date: Wed, 26 Jul 2023 07:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] y2038: cobalt/uapi: Migrate struct sched_param_ex
 to time64_t
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v2-2-b4e888eca2d9@siemens.com>
 <f0114278-3dc2-7faf-9b2f-fec6dcfbb4a8@siemens.com>
 <0e0aa54e62d8723d447682efe4c4d1caa3b278c3.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <0e0aa54e62d8723d447682efe4c4d1caa3b278c3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3657:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ab5966-9eba-4088-b331-08db8d9a7fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VEXprXUB0KnWd3q97PYOSlqh89B9MyfdoYDlDX+R/1G96xu4sIjaid2w6jiQiNC1LlPTEubugluQwEKLNnVt9PNvJcWKpFf3gITdBNpXCjKsWMjwDGsnW+dmM5OXwhF+gAdAU5TzcHG/6SFkSLG46wwXFfWWuSRPX3I5JCQntLPxwOd6H8yzIT+rFPHp+a0MYXs13UKu6ipIq2lbZjMlb4VRpylEGcTtFeoYs0J2Nh/9Gap6s/qvGkZP1CQvd+aeYwYCnxn5wLv4NU2yXxJmbrwrOQATs2dvJMWcnZGx+tpklBVckgDp2Cu2454UrIz+hMOlt4ruMiXKv2Vy6TeJXIsCrw1guHjPKdMnGWiJN5M5JxUVcJej9vRWD9BJq4khi2HahWzQHFS9UUEsz5sg60HVM8uUH0xhSYsnWZnd2/e9PrE+Xl3f3QDWv+k6XDMdKAcf/TPJOU1MWI0X2EtVzRYY5nXwyy6xqAq9yPpSzTCtwvJkCJT0NE2z3NCZrFOFX4G/P7fu9EvFFmBC3oGpLF8lVKR13Tqy9lsjTiDmA+jisSdGb0l0wyZ9fhinab3rZJ/qxXyyJhYdwtpH2jXjygGk5keMqtiZHKgywpY50dt11L/BbvchN3nQ6ir+m+5/9ZGXnUoN/oooNen33vhVxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(31686004)(66946007)(66556008)(83380400001)(2616005)(41300700001)(38100700002)(86362001)(36756003)(31696002)(8936002)(8676002)(5660300002)(82960400001)(478600001)(6486002)(66476007)(316002)(6666004)(2906002)(44832011)(6512007)(53546011)(186003)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNjVlJpWit4b05kaVk3aXhLWTRIa3IvTVBzZnpIbFA4WG54WUtSanIzb2tM?=
 =?utf-8?B?SVlnM2MyQ21VWmJSUi9FYjI1ZjM3dmZyWlVmd1JRTmFobm1zWGhQZFJYU25E?=
 =?utf-8?B?bGh1Y0pBeENzY2tvV2JxRjJHYUV0Tll2TFZoYUw5LytoWTBxTUh2WWoycVAy?=
 =?utf-8?B?OXRhZmh2MnpjVzNHVGJ6ZW9wWHQ2TG5ObzFlQ0dLTFNZS1dhL1h1c05kNkt3?=
 =?utf-8?B?VGc2NHk3bTJMdC9nelUrWE96cDQ2K2JrTmhaVVBlYyt3Y1hVVFByMTIvYjhU?=
 =?utf-8?B?UG1EcXNPSEszYU96SjFxYk9JZ2tKRkpEeTF3K0NtdEpkMWJJNnhvV1RMcjZP?=
 =?utf-8?B?NXE3Rnl3V01kZFY3QkVra0FUSlNLY3ljaW9zNG5zVnVwai9XVXVZbVl6Yml2?=
 =?utf-8?B?clFpRjBTMTdkQVdsL2x4WkdUUm55N21hNWVkRnMrSTdDd0pLQ0I2cDFtU1FD?=
 =?utf-8?B?cWRkWWhzd2VNYXV1MEt1cEh5YWFqb1lNSlJtUmhvMnhUUnlyTTl4anZDaWk1?=
 =?utf-8?B?Y202elRIeEk3eHE0bVM1WWpUTE9ieG5lVGtXNVVSMHVhUGV1QWxXV0pTUlRx?=
 =?utf-8?B?cGJnclNkZW5ZRFdORHlhbDRvcWJRb1h0UlJEWnRBQkdZSTJVcXZhV0Z1S09S?=
 =?utf-8?B?d1dnQzhXckhlQXA0SHNRVVZYWWQyUTZzeTl1c3duWWx6L2tQK3U5cEFtMFNi?=
 =?utf-8?B?Yk9oekNZSlYwK2t5ZGlKbWxTVnRSVlBtRlk5dHcxOFhxdXBtWjl2akN0NTIv?=
 =?utf-8?B?dmhTSDJTdmxsN3Q1SkVKWEZLYjNYMW5TbVFTZkZtSE1QTmRvbmZRSmdCcHVG?=
 =?utf-8?B?TlNuTEMrdHB5MjRMQ2RWZSswWTFYZWd3enRpODFvZThxY0FXUWRjVTNyWVpE?=
 =?utf-8?B?RG1JQkNPS3hJd0E3c1ZWOGI5bXY2bmxuSWwvS29KZjFVZXBkYWkzM0VocnpT?=
 =?utf-8?B?YW0vOWJoQzZkUFB6bXRMbGFwTFcrWXdjR2tEbTg0ZUlKb0R4cERhck5mdG5v?=
 =?utf-8?B?MmVWUlQwOWxIK1BWV0o3bFV2SjRxR05veFZPQW9uNUwvNlJESURwcTNIbGxX?=
 =?utf-8?B?ekFCTnRsd1FKMkFFWm9Nb1JINlV1b0U0ZjBUK1lMY3Q4bFZTNWh0QzhscjR6?=
 =?utf-8?B?ZWlrZEI5N0VoTHFSSHh2RUlzbHFtc3FydHRTbzRCQmIyU2tPNWZ6NDdpR3Za?=
 =?utf-8?B?TDB1eENmZmx4ajlEenlpM2NRUHRTR1FlNnF5blFUdUM3RzdmU0ZQa24rNXNK?=
 =?utf-8?B?cmdJRDd1UmVMSHJDYnM3RU1JaVFySzZlR2FQdHJobUk2TkNvWm03a1hwSFMx?=
 =?utf-8?B?MnVhTnB5STFSSXN0U3ZNRDY4aFlwZGN0K0xZQ1ZDWDd4eUtrSjlmandCU1NE?=
 =?utf-8?B?WlJ6STY2OUZoa0ZCNkx5UU9PWXlMaE5UbFROZWtRdVlJUmF3YVRoUURlVDdK?=
 =?utf-8?B?UWlJZnBULzEvUXM1SUJ4RE1oZ0FsUXphQVNWSFU3U09DRU1kMnhBUHNLbzR2?=
 =?utf-8?B?ZzVMZ2VxTUthTHptblhURFh4OWMyWkZqMENjYm0xT1F4a1ZRSmJEeWJNRkpl?=
 =?utf-8?B?Z3d3OERLS0pQUlNZSEQ2UWt4RWNXdUozNXo2RTZ1WlpYS3pUcXpMMjhJd1lh?=
 =?utf-8?B?bksxU0NZRFMrcUhpeDVYV244ZjVnTjhtQXE3ZWxZc0NBY0Z6NHdocmcybkk2?=
 =?utf-8?B?VGRtYjRYRjJiVkFac2d2S0hZWlpUNU43V1RmRGYwc3RiQzlCT1lFSE5aVkFW?=
 =?utf-8?B?cWNHT3FrSkp1a3Y5empWRWM4RC9HeXM0aHdTbGZVNGJqaVhzZ3VvS0NWYUt6?=
 =?utf-8?B?Z2tqVE8vemJDSlNSUGFpU2lwajlqS1cvUzRtRnNIZ2c2QzdnQi9TVnRLWU5s?=
 =?utf-8?B?amVCcnlTME44ckE1c29PMWl3dENqZS9RbW5SUmp6eFdPejQ3KzZFenRpSjFh?=
 =?utf-8?B?S1hTRlcwaWs2TWhqQUorQ2ZaMzdWTmkzNE8wd1RGdDdnT0d4WitURG9WZVBE?=
 =?utf-8?B?SzY4V1BHWThaOHdGaW1ZQ0MxdURINmp5emdqSkF1aXArSWhHMVJTUzdETE1P?=
 =?utf-8?B?WGN0M2EvakZmL2V2bmZsNDhaT0h3MVZiMjVDZ2R0TzhIam4wM3JpOWNIeEkw?=
 =?utf-8?B?UnN1MnRCSytVdHlVNjllMHprTXQvSDkyU1NDUXoycjd6dlRqU0xxY1BFOXlN?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ab5966-9eba-4088-b331-08db8d9a7fc1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 05:38:11.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Xctb/68gRmCVWHsT3Io7HySyeYzvhIcYOy6qKd5Lb7r7WUVyMPiKiIR13ZzsUdacNKJ1RAQb1puHnzQt6X3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3657

On 21.07.23 14:43, Florian Bezdeka wrote:
> On Thu, 2023-07-20 at 18:36 +0200, Jan Kiszka wrote:
>> On 17.07.23 11:10, Florian Bezdeka wrote:
>>> Instead of implementing time64_t based cobalt services for the
>>> following services we simply break the ABI and make it time64_t aware.
>>>
>>> Affected cobalt services:
>>>   - cobalt_thread_create
>>>   - cobalt_thread_setschedparam_ex
>>>   - cobalt_thread_getschedparam_ex
>>>   - cobalt_sched_setconfig_np
>>>   - cobalt_sched_getconfig_np
>>>   - cobalt_sched_setscheduler_ex
>>>   - cobalt_sched_getscheduler_ex
>>>
>>> XENOMAI_ABI_REV is incremented on all supported plattforms to express
>>> the ABI breakage.
>>>
>>> The memory alignment of some data structures is changed by adding
>>> some anonymous paddings. This allows us to remove some compat specific
>>> services afterwards. The memory layout is identical on all platforms
>>> now.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  include/cobalt/uapi/kernel/types.h                       |  5 +++++
>>>  include/cobalt/uapi/sched.h                              | 14 +++++++++-----
>>>  .../cobalt/arch/arm/include/asm/xenomai/uapi/features.h  |  2 +-
>>>  .../arch/arm64/include/asm/xenomai/uapi/features.h       |  2 +-
>>>  .../cobalt/arch/x86/include/asm/xenomai/uapi/features.h  |  2 +-
>>>  kernel/cobalt/posix/clock.h                              | 16 ++++++++++------
>>>  kernel/cobalt/posix/sched.c                              | 16 ++++++++--------
>>>  kernel/cobalt/posix/thread.c                             |  8 ++++----
>>>  8 files changed, 39 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
>>> index 2c931c29c..495c94506 100644
>>> --- a/include/cobalt/uapi/kernel/types.h
>>> +++ b/include/cobalt/uapi/kernel/types.h
>>> @@ -57,6 +57,11 @@ static inline xnhandle_t xnhandle_get_id(xnhandle_t handle)
>>>  	return handle & ~XN_HANDLE_TRANSIENT_MASK;
>>>  }
>>>  
>>> +struct xn_ts64 {
>>> +	__u64 tv_sec;
>>> +	__u64 tv_nsec;
>>> +};
>>> +
>>>  /*
>>>   * Our representation of time specs at the kernel<->user interface
>>>   * boundary at the moment, until we have fully transitioned to a
>>> diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
>>> index 14095870f..6b1639feb 100644
>>> --- a/include/cobalt/uapi/sched.h
>>> +++ b/include/cobalt/uapi/sched.h
>>> @@ -33,15 +33,17 @@
>>>  
>>>  struct __sched_ss_param {
>>>  	int __sched_low_priority;
>>> -	struct __user_old_timespec __sched_repl_period;
>>> -	struct __user_old_timespec __sched_init_budget;
>>> +	int: 32;
>>> +	struct xn_ts64 __sched_repl_period;
>>> +	struct xn_ts64 __sched_init_budget;
>>>  	int __sched_max_repl;
>>> +	int: 32;
>>>  };
>>>  
>>>  #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
>>>  
>>>  struct __sched_rr_param {
>>> -	struct __user_old_timespec __sched_rr_quantum;
>>> +	struct xn_ts64 __sched_rr_quantum;
>>>  };
>>>  
>>>  #ifndef SCHED_TP
>>> @@ -54,9 +56,10 @@ struct __sched_tp_param {
>>>  };
>>>  
>>>  struct sched_tp_window {
>>> -	struct __user_old_timespec offset;
>>> -	struct __user_old_timespec duration;
>>> +	struct xn_ts64 offset;
>>> +	struct xn_ts64 duration;
>>>  	int ptid;
>>> +	int: 32;
>>>  };
>>>  
>>>  enum {
>>> @@ -122,6 +125,7 @@ struct __sched_config_quota {
>>>  
>>>  struct sched_param_ex {
>>>  	int sched_priority;
>>> +	int: 32;
>>
>> Having these two lines back-to-back looks strange: Why do we specify 32
>> bits explicitly for the padding, why don't we have to specify that for
>> the sched_priority, and why don't we use the __u32/__s32 types here?
>> Same applies to the other structs touched.
> 
> AFAICT there is no difference in the data type used for the padding. We
> could switch to __u32/__32 as long as the produced memory layout is the
> same on all architectures. As this "member" does not have a name
> (=anonymous) it really shouldn't make any difference.
> 
> I'm not sure if I get the part about "why don't we have to specify that
> for the sched_priority" right. After the padding in sched_param_ex two
> 64 bit values (__u64 as part of struct xn_ts64) will follow. 

"int" is not "int:32" by definition. I may just be on our current target
platforms.

> 
> 64 bit values are 8 byte aligned on 64 bit systems but 4 byte aligned
> on 32 bit systems. To get the same memory layout (for being able to
> handle compat syscalls with the same data types) I added the "anonymous
> padding". The padding has an impact on 32 bit systems only.
> 
> The other structs touched have the same reasoning behind.
> __sched_ss_param and sched_tp_window will be extended to the next 8
> byte boundary on 64 bit systems automatically, so we have to "fill them
> up" with a trailing padding.
> 
> Does that answer your questions? Any follow up necessary?
> 

I would still vote for explicitly sized types in structs we have under
our full control, where we don't need to be compatible with types
outside our space.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

