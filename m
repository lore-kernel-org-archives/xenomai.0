References: <0531d2db-aa87-1950-6d7f-41c80d4fe679@web.de>
 <875yyrf3yo.fsf@xenomai.org>
 <c6633047-7570-294f-e0b0-ab74f0c2a33e@siemens.com>
 <87a6o2b0to.fsf@xenomai.org>
 <50f40c7f-ae8d-7ded-9dc7-91310f0d7909@siemens.com>
 <874ke9bzde.fsf@xenomai.org> <871r9dby8b.fsf@xenomai.org>
 <87y2blajle.fsf@xenomai.org>
 <20bb33a6-9b17-4002-4e79-8d4c45641c8b@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] irq_pipeline: Prevent returning to user space with
 pending inband IRQs
In-reply-to: <20bb33a6-9b17-4002-4e79-8d4c45641c8b@siemens.com>
Date: Mon, 07 Jun 2021 17:11:17 +0200
Message-ID: <87h7i9aewa.fsf@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 07.06.21 15:29, Philippe Gerum wrote:
>> 
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>>
>>>> 2. This one should be replaced by a fix in local_irq_disable_full(),
>>>> pending some tests ongoing here:
>>>>
>>>> irq_pipeline: Prevent returning to user space with pending inband IRQs
>>>>
>>>
>>> Tests went ok. So [1] should be replaced by a patch inverting the order
>>> in local_irq_disable_full() as we discussed.
>>>
>>> [1] irq_pipeline: Prevent returning to user space with pending inband IRQs
>> 
>> Likewise for local_irq_save_full() which may cause the same problem,
>> i.e.:
>> 
>> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
>> index 8663f19cc7b7b68..051c72751db42d1 100644
>> --- a/include/linux/irqflags.h
>> +++ b/include/linux/irqflags.h
>> @@ -242,14 +242,14 @@ do {						\
>>  
>>  #define local_irq_disable_full()		\
>>  	do {					\
>> -		local_irq_disable();		\
>>  		hard_local_irq_disable();	\
>> +		local_irq_disable();		\
>>  	} while (0)
>>  
>>  #define local_irq_save_full(__flags)		\
>>    	do {					\
>> -		local_irq_save(__flags);	\
>>  		hard_local_irq_disable();	\
>> +		local_irq_save(__flags);	\
>>  	} while (0)
>>  
>>  #define local_irq_restore_full(__flags)			\
>>  
>> 
>
> As you tested already, I assume you will make the corresponding commit
> available via -rebase. Let me know otherwise if I should do that.
>
> Jan

Yes, I'll do that.

-- 
Philippe.

