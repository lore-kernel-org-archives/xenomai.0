Subject: Re: Still some lockups when enabling ftrace
References: <VI1PR05MB5917457C869A655D0B4CEDD8F6160@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB59174B685B454642A74A9E39F6160@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <5ad922f3-74a7-9724-ac15-669d51facca0@siemens.com>
 <e70bb54a-b3d0-f4e3-6770-606bbd135001@siemens.com>
 <9eab4c74-6317-9687-4693-89534f7ee978@xenomai.org>
 <a456a2db-7f80-a334-02b0-e53892b5f6a2@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <db52b0d9-2e0f-826b-8a9d-3b6d2e694fe4@xenomai.org>
Date: Mon, 17 Feb 2020 19:10:01 +0100
MIME-Version: 1.0
In-Reply-To: <a456a2db-7f80-a334-02b0-e53892b5f6a2@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 2/17/20 6:33 PM, Jan Kiszka wrote:
> On 17.02.20 18:25, Philippe Gerum wrote:
>> On 2/17/20 6:15 PM, Jan Kiszka via Xenomai wrote:
>>> On 17.02.20 17:57, Jan Kiszka via Xenomai wrote:
>>>> On 17.02.20 17:50, Lange Norbert via Xenomai wrote:
>>>>> I managed to narrow it down to this:
>>>>>
>>>>> trace-cmd start  -e 'tlb:tlb_flush'
>>>>>
>>>>> Seems to bug the kernel even if no cobalt thread is running, only a
>>>>> rt_igb and the rtnet stack.
>>>>>
>>>>
>>>> OK, that was already my idea as well.
>>>>
>>>> That rcu_irq_enter_irqson must not be there. Trying to understand
>>>> right now how it can sneak in. What are your RCU configs?
>>>>
>>>
>>> Found it.
>>>
>>> Preconditions: CONFIG_PREEMPT_NONE/VOLUNTARY -> CONFIG_TREE_RCU
>>>
>>> Now switch_mm_irqs_off, which we also use for primary tasks, carries
>>> some trace_tlb_flush_rcuidle. The "_rcuidle" appendix makes the
>>> difference. Such tracepoints end up in tracepoint.h's __DO_TRACE in the
>>> rcuidle path that contains a rcu_irq_enter_irqson of this form:
>>>
>>> void rcu_irq_exit_irqson(void)
>>> {
>>>      unsigned long flags;
>>>
>>>      local_irq_save(flags);
>>>      rcu_irq_exit();
>>>      local_irq_restore(flags);
>>> }
>>>
>>> And those local_irq* bite us. With CONFIG_TINY_RCU, rcu_irq_exit_irqson
>>> is empty.
>>>
>>> I guess we need to skip the problematic tracepoints, either when I-pipe
>>> is on or when the caller is in the primary domain.
>>>
>>> Jan
>>>
>>
>> Dovetail solves it that way, this can be easily transposed to the
>> I-pipe, the semantics are strictly identical between ipipe_root_p and
>> running_inband():
>>
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index 1fb11daa5c53..fd43fa65f20a 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -210,7 +210,7 @@ static inline struct tracepoint
>> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>               __DO_TRACE(&__tracepoint_##name,        \
>>                   TP_PROTO(data_proto),            \
>>                   TP_ARGS(data_args),            \
>> -                TP_CONDITION(cond), 1);            \
>> +                TP_CONDITION(cond), running_inband());    \
>>       }
>>   #else
>>   #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto,
>> data_args)
>>
> 
> Did you analyze if this is safe? The related commit is, well, not very
> telling.
>

The commit just says 'if not controlled by the regular kernel, then it
cannot be a valid rcuidle context'.

Now, I must admit that there could be other spots the I-pipe needs to
fix in order to support tracing better on x86.

-- 
Philippe.

