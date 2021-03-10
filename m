References: <20210310005732.13439-1-hongzhan.chen@intel.com>
 <6ab75124-acb3-4276-c8c0-0e39f63a946a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH V2 1/2] cobalt/rtdm: introduce new interfaces to init task
In-reply-to: <6ab75124-acb3-4276-c8c0-0e39f63a946a@siemens.com>
Date: Wed, 10 Mar 2021 10:04:07 +0100
Message-ID: <87im5zidmg.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org


Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:

> On 10.03.21 01:57, hongzha1 via Xenomai wrote:
>> Initialise and start a real-time task on specified cpu or current
>> cpu.
>> 
>> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>> 
>> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
>> index 733c49df8..42daaa5b2 100644
>> --- a/include/cobalt/kernel/rtdm/driver.h
>> +++ b/include/cobalt/kernel/rtdm/driver.h
>> @@ -1024,6 +1024,20 @@ typedef void (*rtdm_task_proc_t)(void *arg);
>>  int rtdm_task_init(rtdm_task_t *task, const char *name,
>>  		   rtdm_task_proc_t task_proc, void *arg,
>>  		   int priority, nanosecs_rel_t period);
>> +int rtdm_task_init_on_cpu(rtdm_task_t *task, int cpu, const char *name,
>> +		rtdm_task_proc_t task_proc, void *arg,
>> +		int priority, nanosecs_rel_t period);
>> +
>> +static inline int rtdm_task_init_cpu(rtdm_task_t *task, const char *name,
>> +		rtdm_task_proc_t task_proc, void *arg,
>> +		int priority, nanosecs_rel_t period)
>
> I think this was a typo of Philippe:
>
> rtdm_task_init should be implemented as a wrapper around
> rtdm_task_init_on_cpu. We don't need another call.
>

Correct.

-- 
Philippe.

