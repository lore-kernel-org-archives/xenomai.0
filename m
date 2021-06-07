Subject: Re: [PATCH] irq_pipeline: Prevent returning to user space with
 pending inband IRQs
References: <0531d2db-aa87-1950-6d7f-41c80d4fe679@web.de>
 <875yyrf3yo.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c6633047-7570-294f-e0b0-ab74f0c2a33e@siemens.com>
Date: Mon, 7 Jun 2021 07:53:55 +0200
MIME-Version: 1.0
In-Reply-To: <875yyrf3yo.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 06.06.21 16:43, Philippe Gerum via Xenomai wrote:
> 
> Jan Kiszka <jan.kiszka@web.de> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The correct order is hard IRQs off first, then stalling inband, see also
>> I-pipe. Otherwise, we risk to take an interrupt for the inband stage but
>> do not inject it before returning to user space.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Fixes the RCU stalls Florian reported, at least for me.
>>
>> I'm afraid this wasn't the last regression of translating I-pipe into
>> dovetail..
>>
>>  include/linux/entry-common.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index 0fb45b2d6094..00540110985e 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -203,7 +203,8 @@ static inline void local_irq_disable_exit_to_user(void);
>>  #ifndef local_irq_disable_exit_to_user
>>  static inline void local_irq_disable_exit_to_user(void)
>>  {
>> -	local_irq_disable_full();
>> +	hard_cond_local_irq_disable();
>> +	local_irq_disable();
>>  }
>>  #endif
> 
> Good spot, real issue here, just like the CPU_IDLE code deals with. The
> fix looks good, but maybe we could do even better.
> 
> The way local_irq_disable_full() works tends to introduce this issue in
> a sneaky way, when the code path does not synchronize the interrupt log
> (exit_to_user_mode_loop may be at fault in this case, which does not
> traverses synchronize_pipeline()). Lack of synchronization would still
> hit us if some trap handler turns hard irqs off -> on -> off the same
> way, and we don't leave through the user exit path.
> 
> Inverting the order of the actions in local_irq_disable_full() may be an
> option (inband_irq_disable would allow that), making sure we cannot be
> caught in the same issue when returning to kernel mode is another
> way. This needs more thought I think.
> 

So, always this way?

local_irq_disable_full:
	hard_local_irq_disable	
	local_irq_disable

local_irq_enable_full:
	hard_local_irq_enable
	local_irq_enable

Or even flip local_irq_enable_full as well?

Was there ever code that required ordering local_irq_disable_full the
other way around?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

