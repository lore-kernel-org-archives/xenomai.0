Message-ID: <00ea4e43-71c6-5bcd-86b5-efed9a67e2f5@siemens.com>
Date: Tue, 25 Jan 2022 17:44:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] libtraceevent: Add new xenomai plugin to print param_ex
 correctly
Content-Language: en-US
References: <20220118024746.23951-1-hongzhan.chen@intel.com>
 <865a2a7064e879af1f3db312a60e8b7009c82093.camel@siemens.com>
 <MN2PR11MB4285221E304F6D183D5470E4F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285221E304F6D183D5470E4F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 19.01.22 02:25, Chen, Hongzhan wrote:
> 
> 
>>
>>> +/*
>>> + * Copyright (C) 2021 Intel Inc, Hongzhan Chen <hongzhan.chen@intel.com>
>>> + */
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <linux/sched.h>
>>> +
>>> +#include "event-parse.h"
>>> +#include "trace-seq.h"
>>> +
>>> +
>>> +#define SCHED_SPORADIC		10
>>> +#define SCHED_TP		11
>>> +#define SCHED_QUOTA		12
>>> +
>>> +#define SCHED_COBALT		42
>>> +#define SCHED_WEAK		43
>>> +
>>> +struct __sched_ss_param {
>>> +	int __sched_low_priority;
>>> +	struct timespec __sched_repl_period;
>>> +	struct timespec __sched_init_budget;
>>> +	int __sched_max_repl;
>>> +};
>>> +
>>> +struct __sched_rr_param {
>>> +	struct timespec __sched_rr_quantum;
>>> +};
>>> +
>>> +struct __sched_tp_param {
>>> +	int __sched_partition;
>>> +};
>>> +
>>> +struct __sched_quota_param {
>>> +	int __sched_group;
>>> +};
>>> +
>>> +struct sched_param_ex {
>>> +	int sched_priority;
>>> +	union {
>>> +		struct __sched_ss_param ss;
>>> +		struct __sched_rr_param rr;
>>> +		struct __sched_tp_param tp;
>>> +		struct __sched_quota_param quota;
>>> +	} sched_u;
>>> +};
>>
>> Looks like a code duplication. Everything around sched_param_ex is
>> still y2038 affected and might need to change within the Xenomai
>> codebase. Not sure if it is really a good idea to duplicate such
>> affected type definitions.
>>
>> Btw: This patch is not targeting the xenomai code base, right?
> 
> No,the patch is not for xenomai itself but for libtraceevent which is pure linux user
> space lib used by kernel-shark or trace-cmd. But according to Jan, we need to maintain
> them in xenomai tree. Basically , we will create new correspoding folder such
> as libtraceevent or kernel-shark under xenomai tree and also related documents
> to tell user how to use them with libtraceevent or kernel-shark but it would not compile
> together with xenomai.
> It is to fix part of issue https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/33.

OK, a README would be fine for the start, though I expect that we will 
eventually be able to plug the build into the Xenomai autoconf/automake 
as well. We do want this to be generated along the regular build, 
provided the user installed the required dependencies and/or enabled 
this feature. Would also ease packaging for debian, and building for 
xenomai-image (enlightened "trace-cmd report" could work even on the 
targets).

> 
> you are right that we had better not to duplicate them but I can not find a better way
> to share them between xenomai kernel and Linux userspace under current situation.

Once the plugin is integrated into the Xenomai code base, including 
existing headers should be even easier, specifically if they do not 
belong to our devel package.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

