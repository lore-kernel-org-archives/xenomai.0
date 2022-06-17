Message-ID: <860d3069-69b1-4963-2f49-8940533ed939@siemens.com>
Date: Fri, 17 Jun 2022 12:31:52 +0200
MIME-Version: 1.0
Subject: Re: [Xenomai 3.1 PATCH v2] process: update clockfreq when receive
 corresponding event.
Content-Language: en-US
References: <20220616001850.9276-1-hongzhan.chen@intel.com>
 <52822f61-c7fc-9226-8a8c-a5389df94356@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <52822f61-c7fc-9226-8a8c-a5389df94356@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 17.06.22 08:08, Jan Kiszka via Xenomai wrote:
> On 16.06.22 02:18, Hongzhan Chen via Xenomai wrote:
>> 1. When there is clockfreq param passed down via command line, we
>>    do not update clockfreq even if we receive event of updating clockfreq.
>>    Or else, we update the clockfreq with notified value.
>> 2. At the same time, we would like to update clockfreq param showing
>>    in sys filesystem after apply updated clockfreq.
>>
>> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>> ---
>>  include/cobalt/kernel/init.h  |  2 ++
>>  kernel/cobalt/init.c          | 12 ++++++++++++
>>  kernel/cobalt/posix/process.c |  3 ++-
>>  3 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/cobalt/kernel/init.h b/include/cobalt/kernel/init.h
>> index 41dd531a8..36d1ea290 100644
>> --- a/include/cobalt/kernel/init.h
>> +++ b/include/cobalt/kernel/init.h
>> @@ -51,4 +51,6 @@ void cobalt_remove_state_chain(struct notifier_block *nb);
>>  
>>  void cobalt_call_state_chain(enum cobalt_run_states newstate);
>>  
>> +void cobalt_update_clockfreq(unsigned long freq);
>> +
>>  #endif /* !_COBALT_KERNEL_INIT_H_ */
>> diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
>> index dbe321c3b..558030292 100644
>> --- a/kernel/cobalt/init.c
>> +++ b/kernel/cobalt/init.c
>> @@ -53,6 +53,16 @@ module_param_named(timerfreq, timerfreq_arg, ulong, 0444);
>>  static unsigned long clockfreq_arg;
>>  module_param_named(clockfreq, clockfreq_arg, ulong, 0444);
>>  
>> +static bool passed_clockfreq;
>> +
>> +void cobalt_update_clockfreq(unsigned long freq)
>> +{
>> +	if (!passed_clockfreq) {
>> +		xnclock_update_freq(freq);
>> +		clockfreq_arg = freq;
>> +	}
>> +}
>> +
>>  #ifdef CONFIG_SMP
>>  static unsigned long supported_cpus_arg = -1;
>>  module_param_named(supported_cpus, supported_cpus_arg, ulong, 0444);
>> @@ -150,6 +160,8 @@ static int __init mach_setup(void)
>>  
>>  	if (clockfreq_arg == 0)
>>  		clockfreq_arg = sysinfo.sys_hrclock_freq;
>> +	else
>> +		passed_clockfreq = clockfreq_arg != 0;
> 
> If you assign in the conditional branch, you don't need to check
> clockfreq_arg, just set it true.
> 

Fixed up while merging.

Both patches now applied. This one to stable/v3.1.x and stable/v3.0.x.
The I-pipe patch to 5.4, 4.19-cip and 4.4-cip. Tests are running, please
also check.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

