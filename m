Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F98C12C
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 14:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqv0TCJ6AQh1trFkKOsp8j6Xk0lmuSxrGans1eEnQW+bktTbPK9QvZt6hng1B6OF1DTJQHMN06V2YfJJVSPQsu9VswklpumTjEWAGZRMTA50K6N4kHgxQKqDuf9IzTzVICNjwwp7ZGaIPBM8ZI0DYfPv7Bp7oOYLJmrewOTD3nEKCuXiSy74+FSVvb//Xsn3IAHOJ/EwphnjKmxRTnrGpCTgJAdwiBEKjrHvJeN7xQp8AjqcEJyustDPFEZ4W/Vbc48dOoy5ZUXnFdMyVKpNg2R6aQ+n8+auhj7ZqY51wE8QOoVSsKKrvlGDWucyCn3ZSKP2MgqKttmdtnvl4HvPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW2xMVxQ/xZLlpa+dy7ksvEyX5Q2zH2FFuRyOdlRH+c=;
 b=WMRv6FYhXLoLfXCyREk13qz9cYau5NRrjHxEvygWoiNT+Ee/S4ZR0C0ezPeeuG0LbLq37CQgB+PgfQwV7W/Df3kKeOovQrgcxz75EOmx0Oxpo0jMJ/K0jOgeh6m/OP247vJoi2M17q8MtJ8YkVjHNv8QJvXsEWuT5VjH8mvtFCIaq2HvjEFiVxLa84/uFd+jbYW6f7vGBgHbA9igXhYq54KyAO6NvanjgHqm4me1XnrG9dGH7sfO/HLxgAZO2XLZpKGmqGpIVUsRufBrNx3KoRwxQIuQbcxlWc3mgvGrADWO8AUBdV81hkmFdfGIxwXx81+Cy+jUoTp45Sfa8pyO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW2xMVxQ/xZLlpa+dy7ksvEyX5Q2zH2FFuRyOdlRH+c=;
 b=IKMk1peoRGrR8OLWgy91U1pGl/7fwQk9KrkSnWZYcDf7jmQZ0aH4mWhxFAH1KOFfhTVyCVrsDn4bQDnEtgBOB9UAbEfYL5ZilBtXiQSyNTy6i6TMi9reMliQJKrCBO9LzSu1eksW5CPTauIuJnsnrIKSdxJPRimZ5OY43Ny41CBE1pq0pAPdt4mhjCu80J3U4pLTkazna8Ww4dNdWjb8+PgpgouCB+kAM+CH/LAgVa24Po8+5Ey4mJ47ZF9gfvkDgAXoPVD/ArkAFZDTa+T4gr0Qu/pwTmBR0s+SkJ/RsNkI8UBthSfmBJdBWW1TNk1F8IwfKF+/VIeUKfQQ5i4VrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 14:11:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 14:11:57 +0000
Message-ID: <9a52921d-2a1e-4203-80bd-8783c852a549@siemens.com>
Date: Fri, 1 Sep 2023 16:11:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 xenomai@lists.linux.dev
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
 <4c8551a6-8c70-4605-8ebc-76b2e3a558d5@siemens.com>
In-Reply-To: <4c8551a6-8c70-4605-8ebc-76b2e3a558d5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcef68d-2de6-4599-17f8-08dbaaf566cb
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 hbDsDVCg1dejSlWUDvxWZwwxYoZ2SNGNIYKbe3ZGjtmuHNAtD3Wlhw9zNOiorTJ2qdnC0B/6bQmWkbQYyPuvWeBbXJ851VrxOdNOYVfOeogj90cubHqCtfoaq7xC/bM5RMMCGZy5vNwAOdrcn96HLhfsyKX4javLtvLDj36nDRpHYsqEv2ctvfRSvejh61JaWq5G9i60pqmqZb7KlkqeaCPLjDrBKsEw95pmGYUZdEhBW09Im4yQFo8CaVY3W9lWJnV3JIsxVXxIkC/pi1+5adhpUvcOcn6EFdcfeOek3VgLvfBkryIYy3SWx6BjBUnvI5mfktnTv2/l5m4JoZoOgvyBBm3O/vBVmLx42hH4+WtT9FcnB2tgWYMUJ14bs0p/3vNtQtcWryRN7QsyEJmMe7iON4cVMsiQI2w8lP/Vwp4JMP8ArD2O2JVZqI5G/T9A9AyrtubqEPKyrzd+UA8sw3P4e7lTZFr5txzC/S7vGiVD/s61Hik4PmzZiabb8+r7Q9ZFYVyJonAUyhCuM9V/snBVfDwUdlMUX5qWwgk6fdw4N++FEJlkAUV2MdHqRwp+1uJ0jJFN7jdLUyXL/rOpWZDiyykGJI4kHF2OUv429pC3DdzvqmekoPThT6vzaZqLTvBn9EQYOUvf0dTWVWMBwg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(186009)(1800799009)(451199024)(8936002)(8676002)(26005)(5660300002)(53546011)(6486002)(6506007)(316002)(66556008)(66476007)(66946007)(6512007)(36756003)(2616005)(38100700002)(41300700001)(82960400001)(478600001)(86362001)(31696002)(31686004)(83380400001)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UlRkMGlnbUg4MG8vMjdLNjN1VTY1d0h1Z3FUMUtVdjlualZIRU15QmYvRWt2?=
 =?utf-8?B?Nm1kTVFKYllTQVJDZkhrWithTDkwL0E2TkY2ZDhPT29RODZ1UEpQdGVGYi83?=
 =?utf-8?B?NTA5NS9sV3N4YnV2cDNNOHdLdHl2TFlvQUFBa3hJUWtKT0NPZlIyNEVWbjJX?=
 =?utf-8?B?emJGOVFPaGt3OFhPMG9adkY4d0IzY2VsY0RzeHZYaEYrak1XeXlMMDhOM2RC?=
 =?utf-8?B?SVpHaitsYlhMdHJCVXNlbWJMRlZXT1pEWkJRTmRnR2VYdWRhcnhzNW9HS0ta?=
 =?utf-8?B?a0huY2lQeVF3a2FWYWRNOHJicmljUldEb1NVeU56RmhzeVlSVU9SbEt2c2Zh?=
 =?utf-8?B?Y2VHSE56QUdFKzZjQWU0Rk90M0ttYnN0SHZ6anp2RWJBT0FROXRHM0tRZTJx?=
 =?utf-8?B?RU9xb3ZqM3AxVjNCVG54QnZuVDMrVWswUVkyV1c0WlVHOGtodFRsTXBUVnpT?=
 =?utf-8?B?WnlSeHpNQWluV1d3VWQ2Y0lwUGdGbHlNVHErTisrRlhZVnJUY3hFcmpZSGlH?=
 =?utf-8?B?akl0TmpxN0J5Q3pZT0pIUXVsbTRtUEkyeHUyQ1pDWDQreUpDS3k1cld2VjNS?=
 =?utf-8?B?anNyS21hbXNtNnU4ajhBekVaMU5BMzhtNlBFell6NmZHSVlZWTFEWHlYUHN4?=
 =?utf-8?B?WlpXSU5Say9hOVJJMmhPZ0grMGR6UHhRdXpSTjR0alZZbWpBUSt0ZlF5ejJn?=
 =?utf-8?B?VlphVmVoeUgyZGJGZFVmUHNicFFZUnhSZzM3eDBvSVc3RXVyNVJKMmhRdGZy?=
 =?utf-8?B?Z2Zsb2wweGZVajN2WFp2aFlic3BxL1pFL3Y2Y0hCemlVMHZLZ1czRWc1MUlY?=
 =?utf-8?B?ckszNVdXbGJhTFdKQ05RbG1nOGMzN1RMYTBsR1lTbTk3SDBGMmd0WFBVQWdX?=
 =?utf-8?B?VlJpL1Iyd2dCdzZHWkNCemQrWElvNGdhcnNWSG9HOEZNWnRudjhOUDhHZFUw?=
 =?utf-8?B?b1RpczYzZC9kRXJ3VXdSMllha1lxYUJOY3M1SlgybFBRcHIwQ29NZ3hDaGpI?=
 =?utf-8?B?VEh1N1RZRUUxWU1IaUFJemdUeVFNM0FNMVROdUJ2cUpvS0ZrbDNIMnkvRlhw?=
 =?utf-8?B?TnpFYVRqOE9tcGFTN1hXeTZkNmFKU3RKRlN0a3FSTWhOR01MMXFnQnJDSXl2?=
 =?utf-8?B?MDNHUGJLMDg5ZDVHVEJrTjRQQWppTzd6SElCdzlPQ3gycUF5WHBrNERSdnlX?=
 =?utf-8?B?UnBqY3hlMFZsRjdzVTIwbFRUQWc2NW1FV3NtVlVRNUd0NkZET0YvQ3hCOTFX?=
 =?utf-8?B?T3YyekQ1SVFFN0ZWa09EMjQ2WDMzOEdJWktjQytDZjZMUThzQkRZbkUwU1No?=
 =?utf-8?B?K3NDSjd0aTRQMnVRT0N0L0Urc2M2eVlBY0hoUmNhRXFwMVdSUjNaWDFpR2c2?=
 =?utf-8?B?cndoTUZDRVRTZDVEa2kzQ05HMUJSV0liRlIvUlh0NDNxOTVvMyt3U0h6MVM3?=
 =?utf-8?B?ekRWNTErSEFHWFk2OWUrbnQ3MEMwQXJINDh6RXBYdDJDQTRjMFNFOTNxY1N6?=
 =?utf-8?B?a0M4TlFYOS93M0ZLdkNNWkZ1QzIwbEdZdkZENXZlaUhJS2g3K3hkamFMbWQ4?=
 =?utf-8?B?OENLMVZjcGhJbi9zeXk5dW1PL3RZck8wK0FtOHlFWitTalZjanpvQnVQVmlU?=
 =?utf-8?B?b3FWcWJTdDB6b2RMRXhmL29BcEhFQU9LWUVoY2taY29SNkxnVlgzWTZyekg2?=
 =?utf-8?B?YWVTUzNmNWZvNzR2d2hwLzhMNVh4NnhuUkY1UGphbVhYZ29mV0JPdStzSGha?=
 =?utf-8?B?OU9WYTdoZGxLVXo3bndKaTRNUnlDUUdHdnFyQW9DM0ZaeUJHcWtYeDVLVkl1?=
 =?utf-8?B?ZzE3SXp4WTRYVXYyWUNENS9Dc3U0RENOS1BLOG9zbnExNHRTellGbFlzcytP?=
 =?utf-8?B?VFdlczI5SjY4QXBQNHVmZFdRR3gyVnlHbmlmNG1uVDNoK2syVTZSOGJDb1Uv?=
 =?utf-8?B?OG9KdEdVYk51NmRZVUpoM1NTTGNOOEFYUWUxQnlSVnlCUk41Y3hRTGFXektN?=
 =?utf-8?B?ZkxOejB5R2hxSmlXWUJmUnVGZjNqNU1kTlp2akJPN2NtR3ZKQ1BCTXVrSFpB?=
 =?utf-8?B?Vnc1Rm80bE1kRWZCTmVKSlpFbVRjL00xTGM5dHl2QUhveUpuOU9yc2MrZGg5?=
 =?utf-8?B?ZXRrbDdleFdmQjRIRUV1QWczWnk5Zk0zMW1iREJqVlNPZHBDQ3ljSVJFT1VS?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcef68d-2de6-4599-17f8-08dbaaf566cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 14:11:57.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omB68UbJywNC3Afrh29agletOufXerRCaOSg+IZPB5N5fiwLag+tjG6yn+/WTy+/DMmbpFxHcwGrE2YHmarPYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7965

On 01.09.23 15:51, Jan Kiszka wrote:
> On 16.08.23 12:18, Johannes Kirchmair wrote:
>> +int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
>> +			   long errcode, int *sig, struct kernel_siginfo *info)
>> +{
>> +	switch (vector) {
>> +	case 0: /* divide_error */
>> +		*sig = SIGFPE;
>> +		info->si_signo = *sig;
>> +		info->si_errno = 0;
>> +		info->si_code = FPE_INTDIV;
>> +		info->si_addr = (void __user *)regs->ip;
>> +		return 0;
>> +	case 1: /* trap_error */ {
>> +		unsigned long condition;
>> +		get_debugreg(condition, 6);
>> +		set_debugreg(0, 7);
> 
> This looks suspicious: We modify DR7 unconditionally, even if we do not
> handle the signal? Is that OK for the kernel code that takes over then
> because it will simply do the same?
> 

I fact, I'm not sure if we can solve any real problem by permitting the
application to catch breakpoint or single-step events over RT threads.

We do have the use case of hooking in with a high-prio RT handler prior
to a debug stop of an RT process, and we have a downstream approach for
that. But that is using a special monitor threat and cannot be
re-modeled via synchronous signals this way.

For now, I would leave out DB and BP traps.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

