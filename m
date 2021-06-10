Subject: Re: [PATCH] tracing: irq_pipeline: export missing symbols
References: <20210610072915.3832992-1-rpm@xenomai.org>
 <484393ce-6038-a846-9f73-a9e48cc0fa78@siemens.com>
 <87o8ce5cbq.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1f4b6067-2442-df7e-a9a7-fe44e7a8524b@siemens.com>
Date: Thu, 10 Jun 2021 11:19:18 +0200
MIME-Version: 1.0
In-Reply-To: <87o8ce5cbq.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org

On 10.06.21 10:54, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 10.06.21 09:29, Philippe Gerum via Xenomai wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>  kernel/trace/trace_preemptirq.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
>>> index 261ea4101d018ac..2b4110cf6ea2824 100644
>>> --- a/kernel/trace/trace_preemptirq.c
>>> +++ b/kernel/trace/trace_preemptirq.c
>>> @@ -124,6 +124,8 @@ void trace_hardirqs_off_pipelined(void)
>>>  	if (running_inband())
>>>  		trace_hardirqs_off();
>>>  }
>>> +EXPORT_SYMBOL(trace_hardirqs_off_pipelined);
>>> +NOKPROBE_SYMBOL(trace_hardirqs_off_pipelined);
>>>  
>>>  void trace_hardirqs_on_pipelined(void)
>>>  {
>>> @@ -142,6 +144,8 @@ void trace_hardirqs_on_pipelined(void)
>>>  		unstall_inband_nocheck();
>>>  	}
>>>  }
>>> +EXPORT_SYMBOL(trace_hardirqs_on_pipelined);
>>> +NOKPROBE_SYMBOL(trace_hardirqs_on_pipelined);
>>>  
>>>  #else
>>>  
>>> @@ -149,11 +153,15 @@ void trace_hardirqs_off_pipelined(void)
>>>  {
>>>  	trace_hardirqs_off();
>>>  }
>>> +EXPORT_SYMBOL(trace_hardirqs_off_pipelined);
>>> +NOKPROBE_SYMBOL(trace_hardirqs_off_pipelined);
>>>  
>>>  void trace_hardirqs_on_pipelined(void)
>>>  {
>>>  	trace_hardirqs_on();
>>>  }
>>> +EXPORT_SYMBOL(trace_hardirqs_on_pipelined);
>>> +NOKPROBE_SYMBOL(trace_hardirqs_on_pipelined);
>>>  
>>>  #endif
>>>  
>>>
>>
>> How about
>>
>> "blacklist pipeline tracepoints for kprobe"
>>
>> as subject? The symbols were already exported, but not in the right way.
>> The kernel says
>>
>> "Probing (trapping) such functions can cause a recursive trap (e.g.
>> double fault) or the nested probe handler may never be called.
>> Kprobes manages such functions as a blacklist."
>>
> 
> This is actually the export line which was missing for me. The kbprobe
> bits are a careless by-product.
> 

Oops, indeed - I somehow read

-EXPORT_SYMBOL(trace_hardirqs_on_pipelined);
+NOKPROBE_SYMBOL(trace_hardirqs_on_pipelined);

no idea why.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

