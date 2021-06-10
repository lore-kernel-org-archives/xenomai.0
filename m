References: <20210610072915.3832992-1-rpm@xenomai.org>
 <484393ce-6038-a846-9f73-a9e48cc0fa78@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] tracing: irq_pipeline: export missing symbols
In-reply-to: <484393ce-6038-a846-9f73-a9e48cc0fa78@siemens.com>
Date: Thu, 10 Jun 2021 10:54:49 +0200
Message-ID: <87o8ce5cbq.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 10.06.21 09:29, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  kernel/trace/trace_preemptirq.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
>> index 261ea4101d018ac..2b4110cf6ea2824 100644
>> --- a/kernel/trace/trace_preemptirq.c
>> +++ b/kernel/trace/trace_preemptirq.c
>> @@ -124,6 +124,8 @@ void trace_hardirqs_off_pipelined(void)
>>  	if (running_inband())
>>  		trace_hardirqs_off();
>>  }
>> +EXPORT_SYMBOL(trace_hardirqs_off_pipelined);
>> +NOKPROBE_SYMBOL(trace_hardirqs_off_pipelined);
>>  
>>  void trace_hardirqs_on_pipelined(void)
>>  {
>> @@ -142,6 +144,8 @@ void trace_hardirqs_on_pipelined(void)
>>  		unstall_inband_nocheck();
>>  	}
>>  }
>> +EXPORT_SYMBOL(trace_hardirqs_on_pipelined);
>> +NOKPROBE_SYMBOL(trace_hardirqs_on_pipelined);
>>  
>>  #else
>>  
>> @@ -149,11 +153,15 @@ void trace_hardirqs_off_pipelined(void)
>>  {
>>  	trace_hardirqs_off();
>>  }
>> +EXPORT_SYMBOL(trace_hardirqs_off_pipelined);
>> +NOKPROBE_SYMBOL(trace_hardirqs_off_pipelined);
>>  
>>  void trace_hardirqs_on_pipelined(void)
>>  {
>>  	trace_hardirqs_on();
>>  }
>> +EXPORT_SYMBOL(trace_hardirqs_on_pipelined);
>> +NOKPROBE_SYMBOL(trace_hardirqs_on_pipelined);
>>  
>>  #endif
>>  
>> 
>
> How about
>
> "blacklist pipeline tracepoints for kprobe"
>
> as subject? The symbols were already exported, but not in the right way.
> The kernel says
>
> "Probing (trapping) such functions can cause a recursive trap (e.g.
> double fault) or the nested probe handler may never be called.
> Kprobes manages such functions as a blacklist."
>

This is actually the export line which was missing for me. The kbprobe
bits are a careless by-product.

-- 
Philippe.

