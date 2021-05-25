Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
References: <20210421050509.31420-1-hongzhan.chen@intel.com>
 <20210421050509.31420-2-hongzhan.chen@intel.com>
 <bda1f940-8d6d-25c3-3947-3117c89d998d@siemens.com>
 <BN9PR11MB5227514AE1BF8D69CDD502A6F2299@BN9PR11MB5227.namprd11.prod.outlook.com>
 <08fe3c7a-a541-404d-2f4f-293e78e0c958@siemens.com>
 <BN9PR11MB5227BCB84F664600F9F04F44F2299@BN9PR11MB5227.namprd11.prod.outlook.com>
 <87v979l7gg.fsf@xenomai.org>
 <BN9PR11MB5227A5C457C453397B2B70BCF2269@BN9PR11MB5227.namprd11.prod.outlook.com>
 <87sg2clhdg.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1cc5f4d6-f213-8fc1-dff5-100f23815ff7@siemens.com>
Date: Tue, 25 May 2021 08:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <87sg2clhdg.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 24.05.21 09:29, Philippe Gerum wrote:
> 
> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
> 
>>> -----Original Message-----
>>> From: Philippe Gerum <rpm@xenomai.org> 
>>> Sent: Monday, May 24, 2021 12:51 AM
>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>; xenomai@xenomai.org
>>> Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
>>>
>>>
>>> Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:
>>>
>>>>> -----Original Message-----
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>>> Sent: Friday, May 21, 2021 2:21 PM
>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>>> Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
>>>>>
>>>>> On 21.05.21 03:27, Chen, Hongzhan wrote:
>>>>>>
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>>>>>>> Sent: Thursday, May 20, 2021 11:54 PM
>>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>>>>>>> Subject: Re: [PATCH V3 1/3] rtdm/testing: latmus: introduce latmus driver
>>>>>>>
>>>>>>> On 21.04.21 07:05, hongzha1 via Xenomai wrote:
>>>>>>>> To support the latmus application for determining the best
>>>>>>>> gravity values for the cobalt core clock, and measuring
>>>>>>>> the response time to timer events.
>>>>>>>>
>>>>>>>> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>>>>>>>> ---
>>>>>>>>  include/rtdm/uapi/testing.h     |   63 ++
>>>>>>>>  kernel/drivers/testing/Kconfig  |   10 +
>>>>>>>>  kernel/drivers/testing/Makefile |    3 +
>>>>>>>>  kernel/drivers/testing/latmus.c | 1237 +++++++++++++++++++++++++++++++
>>>>>>>>  4 files changed, 1313 insertions(+)
>>>>>>>>  create mode 100644 kernel/drivers/testing/latmus.c
>>>>>>>>
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> diff --git a/kernel/drivers/testing/latmus.c b/kernel/drivers/testing/latmus.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000..bef662260
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/kernel/drivers/testing/latmus.c
>>>>>>>> @@ -0,0 +1,1237 @@
>>>>>>>> +/*
>>>>>>>> + * SPDX-License-Identifier: GPL-2.0
>>>>>>>> + *
>>>>>>>> + * Derived from Xenomai Cobalt's autotune driver, https://xenomai.org/
>>>>>>>> + * Copyright (C) 2014, 2018 Philippe Gerum  <rpm@xenomai.org>
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <linux/types.h>
>>>>>>>> +#include <linux/init.h>
>>>>>>>> +#include <linux/module.h>
>>>>>>>> +#include <linux/slab.h>
>>>>>>>> +#include <linux/kernel.h>
>>>>>>>> +#include <linux/sort.h>
>>>>>>>> +#include <linux/cdev.h>
>>>>>>>> +#include <linux/fs.h>
>>>>>>>> +#include <linux/fcntl.h>
>>>>>>>> +#include <cobalt/kernel/pipe.h>
>>>>>>>> +#include <cobalt/kernel/sched.h>
>>>>>
>>>>> Do we need those two? RTDM should be the interface when possible. And if
>>>>> some RTDM header is need of any of them, that would be a bug and a
>>>>> separate patch.
>>>>
>>>> Thanks for your pointing out. Yes, we do not need sched.h here but we need pipe.h
>>>> because latmus make use of xnpipe.
>>>>
>>>>>
>>>>>>>> +#include <rtdm/ipc.h>
>>>>>>>> +#include <rtdm/testing.h>
>>>>>>>> +#include <rtdm/driver.h>
>>>>>>>> +#include <rtdm/compat.h>
>>>>>>>> +
>>>>>>>> +#define ONE_BILLION  1000000000
>>>>>>>> +#define TUNER_SAMPLING_TIME	500000000UL
>>>>>>>> +#define TUNER_WARMUP_STEPS	10
>>>>>>>> +#define TUNER_RESULT_STEPS	40
>>>>>>>> +
>>>>>>>> +#define progress(__runner, __fmt, __args...)				\
>>>>>>>> +	do {								\
>>>>>>>> +		if ((__runner)->verbosity > 1)				\
>>>>>>>> +			printk(XENO_INFO "latmus(%s) " __fmt "\n",	\
>>>>>>>> +			       (__runner)->name, ##__args);		\
>>>>>>>> +	} while (0)
>>>>>>>> +
>>>>>>>> +#define cobalt_init_xntimer_on_cpu(__timer, __cpu, __handler)		\
>>>>>>>> +		rtdm_timer_init_on_cpu(__timer, __handler,		\
>>>>>>>> +			#__handler, __cpu)
>>>>>>>
>>>>>>> Why this wrapper? Why not calling rtdm_timer... directly?
>>>>>>
>>>>>> Of course, we can call rtdm_timer... directly. My reason is : 
>>>>>>
>>>>>> 1.  When I ported it from evl , I just want to align with original as I can 
>>>>>>     to pass same number of parameters here to replace evl_init_timer_on_cpu.
>>>>>> 2.  In addition ,when use this wrapper, caller may not need to care about
>>>>>>     name when it does not matter for user because define would handle it by default.
>>>>>>     
>>>>>
>>>>> The current code is abstracting a single use case (you can't use the
>>>>> code over evl as-is) - that is usually not a good idea. Once you have
>>>>> two or more active use cases, abstraction can still be done.
>>>>
>>>> Is it better to move this wrapper to ./include/cobalt/kernel/rtdm/driver.h  just like evl_init_timer_on_rq
>>>> doing in include/evl/timer.h?
>>>>
>>>
>>> Generally speaking, I don't see any benefit in sharing a generic latmus
>>> implementation that would build on top of the Cobalt/EVL cores with no
>>> change.
>>>
>>> The version for Xenomai3 must stick with the RTDM interface, just like
>>> the Xenomai4 implementation will stay with the EVL kernel API. If
>>> services are missing in the current RTDM specs to support latmus, a
>>> discussion should take place so that we may propose them for integration
>>> into the CXP.
>>
>> I saw that the latmus driver patch was already merged. Do I need to create a new patch based on latmus driver
>>  to fix it or resubmit the latmus driver patch including the fix?
>>
> 
> This is not upstream yet, so please send a patch against my tree, I'll
> fold it into the initial commit(s). Thanks.
> 

Let's avoid the indirection: The driver aims at upstream, thus should be
sent against it now. It has no dependencies on wip/dovetail, thus could
already use next as baseline (provided you include or refer to the two
new rtdm api patches).

So, just prepare a new series version, maybe organized like the tip of
wip/dovetail (I've reordered Philippe's branch to make this logical
relationship clearer).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

