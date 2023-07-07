Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C2BE7E
	for <xenomai@lists.linux.dev>; Fri,  7 Jul 2023 11:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ6loeCaSNvxO9043x629ML/S96EtTYGINDqLzk+TjxiDt8T35ZwNDCszhKhvlxPpP/LJSQAlUSRYmWz/Ues1B9wjprD1J0FkWxe9Qj0ozDxOoRPR2+MEIZD8bWqqlHYigzHO38NDLEiEvXJtJMQgXrk5GirP0Dt7yq0cFNWNt1PLkwnvrpCeC2E75EzI1gH4wvFQCqB6dXlrFKSoMgyPXAclfzuANctoTR7XvZ4Yv7WOLSOHn3xCSG/47Gh9A17mVYXjSnLYNYO/v7PMd8nE0zC/Jw0aWIe8vZvR9fDeoigfJQydM/9LOlHSO6ardHCPWNnOhYXk8f2EZyc+iUv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+mZkScJFfwu60W4VluBwP/xdFzV11DL/Nbw+TaFrbo=;
 b=NU44Z7u+tnaj9mD0pHBu3hvd0s6A4wliOvl4mpT2oPNPpjIK+b7M+qwfUfqDwa0CiqdNsz4uAwsPJFAI2WXkmt17BEETvRe8N44fceFKmXiM5Xw8uhC+9dgkIB0TE81XWJcz2vhpfZrJegqv71VoSYKm/xd+jX9qeXhcU5zSJ+sSlg58hEVckV3Zuc+aGkQ/rlpMXtzvfoUo7DPDv9NI6Hu6eWL8WgTsnruoiA9YJmYhm9YackIIsh4hS0kqgOc8I31MV3/kSIfS1Kvw9N2BSmFqktggBDeMMdpcDRL+fxILLaEqa7m3Pj4IT7XljtJX7FIH0wGzqyIYfJTruQlWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+mZkScJFfwu60W4VluBwP/xdFzV11DL/Nbw+TaFrbo=;
 b=abFoiupZUenUl3+c9wmMN+9TggFmfkvu8LZkq6GkCdsYGtbQsiHLWm0mZEKFvGNpES1metMZdRhsEk92TYQ045iNmX+tpCEkwUljPkhqMV0iSa+gVioEEHq8ea9SCLGvL9O9Eedk+m05XS7ul78GrPjvfSc7M8DR91ryPFToj00L1XHA19Cvv/hChLyZx8DS8J01FWuqluyPe0vkYa0ny0B1Uq+9ZXOGEeS3F0BUuTPWbVg2pw9UyDRE7iTyma5isWJyCBhtAEcftHUwz0v7cDeCCod16qY0PZjDIK2yH21KNWYeL7DCOR/oJnu768AD5Lc3PaTXdjyJOku7jmhpJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 11:37:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 11:37:19 +0000
Message-ID: <6a248eae-34f3-cf4c-eba3-4829ed05c759@siemens.com>
Date: Fri, 7 Jul 2023 13:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/12] y2038: cobalt/uapi: Align memory layout for time64
 related types
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-6-604a089542c2@siemens.com>
 <68fd52af-9c3a-059a-d4f7-1c798c3ae17b@siemens.com>
 <aaa0e6b0eb40c2b8015bbed1e14d8a188acf44a0.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <aaa0e6b0eb40c2b8015bbed1e14d8a188acf44a0.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:610:75::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: ea120f35-189d-4ed2-2b65-08db7ede859d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JK3+50YB2HOUeCBsSlih/7CMd8/CTXVqGaY0u0B0CvYl4X6VEnU0dCqIyEdBu3E/Fc2B9tSHHHtNB4RRBTu7RSmq5kAWVaE1av9U7t+i7pIUbtM7rWRfalmPpXZCZvFupm//hokdOpdysRyoq3CEJMcXcAldzOHv39wSU2yHbZtuc+CsYo52UENEcNzh7u0yKeHpxaq/Nx6NOJbvycuhicBOeIB1x1s7MiyTfy9hRALQFwoqswfaGOmeqW2kro8pUULJo9eFXvnJAa1TiLK51CqwUDbpHDjo+9aE5Vv8Bz2oH2Ql9UeNlMftXQpQW/vd+FkbHYZc63K3oHvkVazVtZ19hH9JkM6kY7ltQXA+oYGcJDVz+ZFiteqUYDcwph3a6+zvF9m0we8cG5tOVfLVfG37MQcjxunsCLD8Njbw4mdGEpxWXqQUTMBZc+CEHUXcrh8jnDkAI+YkajIt32YXesDBicm/XVUoKu8II+HJlcZZyPfoEgwhqzXnwUUXgqBG9/u5rJDTPqh5TBl4XNzrvQaOAIpk6qa8px8tavDtIBjv/Qib5Q39UypawNiEIwopfVRbL0BT0us5ZtMPJCjx+K5TuUQVNYSE3Jg1kNl4udiIbXp8AXVCc+6HZZuawwfaIEw3Ux8GCZHdO8SrHjBwBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(44832011)(31686004)(66556008)(66946007)(66476007)(478600001)(2906002)(316002)(36756003)(5660300002)(8676002)(8936002)(41300700001)(6512007)(26005)(31696002)(86362001)(6486002)(53546011)(186003)(6666004)(6506007)(38100700002)(2616005)(82960400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk52dE83OFRXVDBKVi9SUEUwMzRPbUxPSXcvSDRCRUVMK2NsaUxPWnhQTS9i?=
 =?utf-8?B?Tnphd1NjYVU0SHp0eHVncjk4SUVHSVJscXNwVTFzMDdBVzlBbjRlNUZLNEtB?=
 =?utf-8?B?Q1ZMcEF5VTUrdFN4RFFudjd2WVU0VEtSYlBJNzFlYjJuMkZod1hPVjFNWnZq?=
 =?utf-8?B?OWIvSjIzS0MrcFdkVXZVUjJXSGxBMFROY3pSbG94UmhPZ3dQMTBZQ1ZZVHJM?=
 =?utf-8?B?dWpQeWtvTEF2bnhpNTR2b2l5Z0pyaEVob0dYMm1taVZEdUR4bWVhRGtqdkti?=
 =?utf-8?B?a256SVgzVGlSM1FmTnJDQmNsRDhacnRqd0pNN2JJYitLa3RtRjhCUHg5SXNX?=
 =?utf-8?B?ZkxkZkZRMXovZmNBbDhPNEpYK3dFeG1XNUJxV05iZnV6MUUvZFlUenNmS0lO?=
 =?utf-8?B?SkxwQ01BR09oMVVtMk81c1NkNklUSFNHZUJLWDg2TXBKTWppKzBZRjhWN2xy?=
 =?utf-8?B?a0RUbWlPS1BIVXRBYkxaSnNmeFdHNGhMdXJUZmFIaWlVUkpGUFg2NkJjVDQw?=
 =?utf-8?B?ZzBORytEU1BDNVQ1WUxKdDA0ejBidkczaTQ3UmFjaFhBZnlnWWJQcmgxTEZk?=
 =?utf-8?B?MTlzcG1BNkpMWmhSZEZHNThpVTk5ZG5YcitrUzFMdWFhbksvUzhqYnBjTHFD?=
 =?utf-8?B?ZmNaZU1TSnlPTGtpNmp5emxKOWN6ZE9aT3ZKMTlncm9RNFpKalRDelMwcU9M?=
 =?utf-8?B?b0VzVjBkYjJ3OTd3VmlYME81aHFYUkw0eTYrOWphN2pFS2RWcnBubjd5NzdL?=
 =?utf-8?B?NWlUVzZJTS81MFJiUm9kZERTdnhsa3lUaVVBYUxsMTVjRHBCQU5NdXFZUFR1?=
 =?utf-8?B?QVFDNjl4bmQzVTRyTzZZajlUYTJwSFFVTjUxMlphamhqeVNXOFVVb2VMdVVi?=
 =?utf-8?B?elJvdE9DcnhiT0lhWkxaZ0hTZjRBOW53TFRMeWp5U3BtZ0hSc1FtdDN6NjNJ?=
 =?utf-8?B?N3hLUGdkbDZ0Vm0rYzZSNStrOUNIczlIK1VmNTBrc1RIMVdMVG1SN213MHV1?=
 =?utf-8?B?enA4Q1Y2MUdLZjU2dmhhYzdRd2pYM0I2djhha2lMVkg3b25maDRXakw3L2hP?=
 =?utf-8?B?VTlhczVTQ2J3bHhnNUFQdkhBdlFVMkprVUxIWUZ6L29jaTRZTnhIbXBiNTBr?=
 =?utf-8?B?MFgwYnhBYTlkMXM0NTBYc2g1MU9kYXIxM3FEUDFEQVVHOUZaZ0tFY0JhS2Jp?=
 =?utf-8?B?eWZ1RDYwL09FZVhWc2VWUThITXVGMlVZcGdNZ1huRk1GT2plaUJHVmdwTml2?=
 =?utf-8?B?aWpPSTVIOCt3SXhWeStJMkJHcFI3NEpjVFhKdlZFeCtKdG9uaFJzWmk5TXor?=
 =?utf-8?B?NmpIRDJTZ21FTmNWaVZ1cDdLaTd2VTk3aXdmQ041RGdzbTZIU1J2R296aTNH?=
 =?utf-8?B?MTYrTzZUU3F3UWppU25NMnJwSmZselMxYThFamJRa1hPM0JVNFo2bzRWc09V?=
 =?utf-8?B?c0hTVzlWNVhnZ3U2WG9qbUo0bWNJYVU2ZUJJUnlYMWFwWTYzdWF2RmJWczFZ?=
 =?utf-8?B?SUpIcElIbkxTeE1wRTJIbXJJRkVzNjl5bDRsYitwWHA4bnJCUEZBN0c2RDlG?=
 =?utf-8?B?U05vd0hPY2RYYW5RRUlwelQxL2hmM09WUGQvazhkSmxVY2NaWGpiTGdDMlJW?=
 =?utf-8?B?REh4emhlZm1iUFdjcG5zd2JoWkV4a0d5dmc1VTVlTnNucFZHOFVkbE1kZ3lG?=
 =?utf-8?B?dlBWYjRUYzlnMmVSMnJLeDVpT002R2hzTUYvaERpVnhVRkdDYktkSW9DQ05L?=
 =?utf-8?B?V2lQSVN1RC80ZWVmS0FmNWdXMitLc01KMXVUOVZMYXpHcUlJdU43QnhqcjRF?=
 =?utf-8?B?eXNoeSttelNCeHJzaTQvUW1ucHNtZitZRXZtVXlBWVNmSXdMY040TGQ2Qmxv?=
 =?utf-8?B?UUFHRGc4WmlsK2poMENFYnQrUkF6bEVUbkNhRXpPWmI1TXlWMDlFdjN6RGpy?=
 =?utf-8?B?M2pwck9adDErSXBJaDJ5VUNacThqOHViMGcxMnI1Q1VFWkpteGFWcEJObExi?=
 =?utf-8?B?RkVTVEFmZCtzNnlWVFJjM0lZSkc1KzN4dnRyM29GT3FDbGxkSmRwNHprOUd0?=
 =?utf-8?B?eDNYT256cHhRTzlab1gwTVZGbXpFRFpYRHJKUjNKeEhacHpkMjdaTlR3bWQ1?=
 =?utf-8?B?QU5JZE1KbEFGTTRzTkJBMlR4dUZ0YVp6QVBIUk5FQkZBS1kvSlRsM3FxRnZI?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea120f35-189d-4ed2-2b65-08db7ede859d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:37:19.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIfqnwWpG9Qll0lmoyDXn69U0gu1l5VQg8SOfaI8F56x/t8YuaY38Xet57oZZooYaIfT+EldHHhHLfAB72Ad6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7848

On 06.07.23 09:50, Florian Bezdeka wrote:
> On Thu, 2023-07-06 at 09:23 +0200, Jan Kiszka wrote:
>> On 05.07.23 08:38, Florian Bezdeka wrote:
>>> When turning on time64 support the memory layout of
>>> struct sched_param_ex (used by userspace in any case) and the "shadow
>>> type" (struct sched_param_ex64, used by time64 related entry points)
>>> have to match.
>>>
>>> Simplified example for different memory layout (offsets) of
>>> struct sched_param_ex:
>>>
>>>                                            offset 32 bit   offset 64 bit
>>> struct sched_param_ex {
>>> 	int               sched_prio;           0                0
>>> 	struct timespec   __sched_ss_param;     4                8
>>> 	...
>>> };
>>>
>>> With padding we get
>>>
>>> struct sched_param_ex {
>>> 	int               sched_prio;           0                0
>>> 	struct timespec   __sched_ss_param;     8                8
>>> 	...
>>> };
>>>
>>> This is a backward compatibility breaking change. Incrementing the
>>> Xenomai ABI revision on all supported architectures to express that.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  include/cobalt/kernel/compat.h                               | 4 ++++
>>>  include/cobalt/uapi/sched.h                                  | 4 ++++
>>>  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h   | 2 +-
>>>  kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +-
>>>  kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h   | 2 +-
>>>  kernel/cobalt/posix/thread.h                                 | 3 +++
>>>  6 files changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
>>> index f2dce74b4..71010e3a9 100644
>>> --- a/include/cobalt/kernel/compat.h
>>> +++ b/include/cobalt/kernel/compat.h
>>> @@ -30,9 +30,11 @@ struct sched_param_ex64;
>>>  
>>>  struct __compat_sched_ss_param {
>>>  	int __sched_low_priority;
>>> +	int: 32;
>>>  	struct old_timespec32 __sched_repl_period;
>>>  	struct old_timespec32 __sched_init_budget;
>>>  	int __sched_max_repl;
>>> +	int: 32;
>>
>> Why not u32? And why not using that type for the other int fields as
>> well? Same below.
> 
> I just followed the glibc way of defining such paddings. Is there any
> significant difference?
> 

OK, if they do it this way...

But I was also wondering, as we are breaking ABIs here, if we shouldn't
use types of static width for all the touched structures.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

