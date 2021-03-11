References: <20210311064859.10971-1-hongzhan.chen@intel.com>
 <20210311064859.10971-2-hongzhan.chen@intel.com>
 <87v99yglah.fsf@xenomai.org>
 <MWHPR11MB1710261A737D070A6CC0190CF2909@MWHPR11MB1710.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/2] cobalt/rtdm: introduce new interface to init timer
In-reply-to: <MWHPR11MB1710261A737D070A6CC0190CF2909@MWHPR11MB1710.namprd11.prod.outlook.com>
Date: Thu, 11 Mar 2021 09:48:19 +0100
Message-ID: <87pn06gjos.fsf@xenomai.org>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Chen, Hongzhan <hongzhan.chen@intel.com> writes:

>>-----Original Message-----
>>From: Philippe Gerum <rpm@xenomai.org> 
>>Sent: Thursday, March 11, 2021 4:14 PM
>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>Cc: xenomai@xenomai.org
>>Subject: Re: [PATCH 2/2] cobalt/rtdm: introduce new interface to init timer
>>
>>
>>hongzha1 via Xenomai <xenomai@xenomai.org> writes:
>>
>>> Initialise timer on specified cpu.
>>>
>>> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>>>
>>> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
>>> index 5406e54a5..d58df33ce 100644
>>> --- a/include/cobalt/kernel/rtdm/driver.h
>>> +++ b/include/cobalt/kernel/rtdm/driver.h
>>> @@ -966,6 +966,9 @@ enum rtdm_timer_mode {
>>>  int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
>>>  		    const char *name);
>>>  
>>> +int rtdm_timer_init_on_cpu(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
>>> +		    const char *name, int cpu);
>>> +
>>>  void rtdm_timer_destroy(rtdm_timer_t *timer);
>>>  
>>>  int rtdm_timer_start(rtdm_timer_t *timer, nanosecs_abs_t expiry,
>>> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
>>> index 069a442e5..268bf8fbf 100644
>>> --- a/kernel/cobalt/rtdm/drvlib.c
>>> +++ b/kernel/cobalt/rtdm/drvlib.c
>>> @@ -583,15 +583,44 @@ EXPORT_SYMBOL_GPL(rtdm_task_busy_sleep);
>>>  int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
>>>  		    const char *name)
>>>  {
>>> +	/*cpu0 is used when no affinity was given*/
>>> +	return rtdm_timer_init_on_cpu(timer, handler, name, 0);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rtdm_timer_init);
>>> +
>>> +/**
>>> + * @brief Initialise a timer on specified cpu
>>> + *
>>> + * @param[in,out] timer Timer handle
>>> + * @param[in] handler Handler to be called on timer expiry
>>> + * @param[in] name Optional timer name
>>> + * @param[in] cpu that run on
>>> + *
>>> + * @return 0 on success, otherwise negative error code
>>> + *
>>> + * @coretags{task-unrestricted}
>>> + */
>>> +int rtdm_timer_init_on_cpu(rtdm_timer_t *timer,
>>> +		rtdm_timer_handler_t handler, const char *name, int cpu)
>>> +{
>>> +	struct xnsched *sched;
>>> +
>>>  	if (!realtime_core_enabled())
>>>  		return -ENOSYS;
>>>  
>>> -	xntimer_init((timer), &nkclock, handler, NULL, XNTIMER_IGRAVITY);
>>> +	if (!cpu_online(cpu))
>>> +		return -EINVAL;
>>> +
>>> +	sched = xnsched_struct(cpu);
>>> +	if (sched == NULL)
>>> +		return -EINVAL;
>>> +
>>> +	xntimer_init((timer), &nkclock, handler, sched, XNTIMER_IGRAVITY);
>>  	xntimer_set_name((timer), (name));
>> +
>>  	return 0;
>>  }
>> -
>> -EXPORT_SYMBOL_GPL(rtdm_timer_init);
>> +EXPORT_SYMBOL_GPL(rtdm_timer_init_on_cpu);
>>  
>>  /**
>>   * @brief Destroy a timer
>>
>>Do we have a potential user for this call?
>
> Yes. Latmus is supposed to use it. Evl  Latmus  is calling evl_init_timer_on_cpu in 
> create_uthread_runner. So I think Xenomai should have corresponding one.
>

Agreed. Today, the timer benchmarking code can only land on CPU0,
regardless of the affinity instruction given to 'latency', which is
wrong. So we need this new call in order to be able to place the
sampling timer on the tested CPU.

-- 
Philippe.

