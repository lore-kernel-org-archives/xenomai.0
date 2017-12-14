References: <45eb5a2a-6255-f3b8-484a-151d9ce931ea@siemens.com>
 <dbcba4b3-ce37-8767-10f8-59d460c76bbb@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <18becf30-f03b-1623-be69-896256c6a7c7@siemens.com>
Date: Thu, 14 Dec 2017 18:32:00 +0100
MIME-Version: 1.0
In-Reply-To: <dbcba4b3-ce37-8767-10f8-59d460c76bbb@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: Do not leak the preemption counter on
 interrupted migrations
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2017-12-14 18:13, Philippe Gerum wrote:
> On 12/14/2017 05:45 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> If __schedule fails because of a pending signal, we have to re-enable
>> preemption before leaving __ipipe_migrate_head. Failing to do so causes
>> a leak and sooner or later a "scheduling while atomic" or similar
>> errors.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Sending separately as it seems critical.
>>
>>  kernel/sched/core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index de3e8929a501..304399683e23 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8672,10 +8672,10 @@ int __ipipe_migrate_head(void)
>>  	if (likely(__schedule(false)))
>>  		return 0;
>>  
>> -	if (signal_pending(p))
>> -		return -ERESTARTSYS;
>> +	BUG_ON(!signal_pending(p));
>>  
>> -	BUG();
>> +	preempt_enable();
>> +	return -ERESTARTSYS;
>>  }
>>  EXPORT_SYMBOL_GPL(__ipipe_migrate_head);
>>  
>>
> 
> Merged, thanks.
> 

BTW, we have another problem of this kind:

With event tracing enabled, we leak preemption locks when a RT task is
suspended while holding that lock during a tracepoint execution. That
only affects x86 since 3.13 because that was the point where that arch
switched from per-task to per-cpu preemption counter.

Thinking about possible solutions for a while. Best idea so far: only
suspend RT tasks when they are sleeping already, are in userspace or are
about to return to it (for the latter, I have a hook to be submitted
upstream anyway).

Jan

