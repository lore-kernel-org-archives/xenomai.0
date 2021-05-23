Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
References: <20210421050509.31420-1-hongzhan.chen@intel.com>
 <20210421050509.31420-2-hongzhan.chen@intel.com>
 <bda1f940-8d6d-25c3-3947-3117c89d998d@siemens.com>
 <BN9PR11MB5227514AE1BF8D69CDD502A6F2299@BN9PR11MB5227.namprd11.prod.outlook.com>
 <08fe3c7a-a541-404d-2f4f-293e78e0c958@siemens.com>
 <BN9PR11MB5227BCB84F664600F9F04F44F2299@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3b43cc03-5a12-c605-4779-302511849d50@siemens.com>
Date: Sun, 23 May 2021 15:32:21 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227BCB84F664600F9F04F44F2299@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 21.05.21 08:49, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Friday, May 21, 2021 2:21 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
>>
>> On 21.05.21 03:27, Chen, Hongzhan wrote:
>>>
>>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>> Sent: Thursday, May 20, 2021 11:54 PM
>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>> Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
>>>>
>>>> On 21.04.21 07:05, hongzha1 via Xenomai wrote:
>>>>> To support the latmus application for determining the best
>>>>> gravity values for the cobalt core clock, and measuring
>>>>> the response time to timer events.
>>>>>
>>>>> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>>>>> ---
>>>>>  include/rtdm/uapi/testing.h     |   63 ++
>>>>>  kernel/drivers/testing/Kconfig  |   10 +
>>>>>  kernel/drivers/testing/Makefile |    3 +
>>>>>  kernel/drivers/testing/latmus.c | 1237 +++++++++++++++++++++++++++++++
>>>>>  4 files changed, 1313 insertions(+)
>>>>>  create mode 100644 kernel/drivers/testing/latmus.c
>>>>>
>>>>
>>>> ...
>>>>
>>>>> diff --git a/kernel/drivers/testing/latmus.c b/kernel/drivers/testing/latmus.c
>>>>> new file mode 100644
>>>>> index 000000000..bef662260
>>>>> --- /dev/null
>>>>> +++ b/kernel/drivers/testing/latmus.c
>>>>> @@ -0,0 +1,1237 @@
>>>>> +/*
>>>>> + * SPDX-License-Identifier: GPL-2.0
>>>>> + *
>>>>> + * Derived from Xenomai Cobalt's autotune driver, https://xenomai.org/
>>>>> + * Copyright (C) 2014, 2018 Philippe Gerum  <rpm@xenomai.org>
>>>>> + */
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/slab.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/sort.h>
>>>>> +#include <linux/cdev.h>
>>>>> +#include <linux/fs.h>
>>>>> +#include <linux/fcntl.h>
>>>>> +#include <cobalt/kernel/pipe.h>
>>>>> +#include <cobalt/kernel/sched.h>
>>
>> Do we need those two? RTDM should be the interface when possible. And if
>> some RTDM header is need of any of them, that would be a bug and a
>> separate patch.
> 
> Thanks for your pointing out. Yes, we do not need sched.h here but we need pipe.h
> because latmus make use of xnpipe.
> 
>>
>>>>> +#include <rtdm/ipc.h>
>>>>> +#include <rtdm/testing.h>
>>>>> +#include <rtdm/driver.h>
>>>>> +#include <rtdm/compat.h>
>>>>> +
>>>>> +#define ONE_BILLION  1000000000
>>>>> +#define TUNER_SAMPLING_TIME	500000000UL
>>>>> +#define TUNER_WARMUP_STEPS	10
>>>>> +#define TUNER_RESULT_STEPS	40
>>>>> +
>>>>> +#define progress(__runner, __fmt, __args...)				\
>>>>> +	do {								\
>>>>> +		if ((__runner)->verbosity > 1)				\
>>>>> +			printk(XENO_INFO "latmus(%s) " __fmt "\n",	\
>>>>> +			       (__runner)->name, ##__args);		\
>>>>> +	} while (0)
>>>>> +
>>>>> +#define cobalt_init_xntimer_on_cpu(__timer, __cpu, __handler)		\
>>>>> +		rtdm_timer_init_on_cpu(__timer, __handler,		\
>>>>> +			#__handler, __cpu)
>>>>
>>>> Why this wrapper? Why not calling rtdm_timer... directly?
>>>
>>> Of course, we can call rtdm_timer... directly. My reason is : 
>>>
>>> 1.  When I ported it from evl , I just want to align with original as I can 
>>>     to pass same number of parameters here to replace evl_init_timer_on_cpu.
>>> 2.  In addition ,when use this wrapper, caller may not need to care about
>>>     name when it does not matter for user because define would handle it by default.
>>>     
>>
>> The current code is abstracting a single use case (you can't use the
>> code over evl as-is) - that is usually not a good idea. Once you have
>> two or more active use cases, abstraction can still be done.
> 
> Is it better to move this wrapper to ./include/cobalt/kernel/rtdm/driver.h  just like evl_init_timer_on_rq
> doing in include/evl/timer.h?

If you can make the code work as-is also against evl, the wrapper should
probably be out-of-line (and applied to both sides). But that should
likely be a latmus-local header, nothing in rtdm/driver.h. At the
current stage, you are using RTDM, and current EVL has no RTDM wrapper -
thus rtdm_timer_init_on_cpu is only one of the many Xenomai 3 specifics
in the patch.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

