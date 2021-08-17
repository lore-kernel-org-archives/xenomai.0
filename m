Subject: Re: [PATCH RFC 2/2] cobalt/registry: Adding trace events for
 registry_{enter,unlink,remove}
References: <20210816161214.62995-1-florian.bezdeka@siemens.com>
 <20210816161214.62995-3-florian.bezdeka@siemens.com>
 <2b74e54b-cf6d-05ce-9dde-7b15d8a6e7d5@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e8cc81df-9ca2-526f-838c-94d60ab245b9@siemens.com>
Date: Tue, 17 Aug 2021 08:41:05 +0200
MIME-Version: 1.0
In-Reply-To: <2b74e54b-cf6d-05ce-9dde-7b15d8a6e7d5@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 17.08.21 08:09, Jan Kiszka via Xenomai wrote:
> On 16.08.21 18:12, Florian Bezdeka wrote:
>> Adding the following trace events to make registry-usage traceable:
>>   - registry_enter   (object gets added to the registry)
>>   - registry_unlink  (object is made anonymous)
>>   - registry_remove  (object is removed from the registry)
>>
>> These trace events are helpful if there is a need to track down
>> resource leaks triggered by an Xenomai based application.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  kernel/cobalt/registry.c          |  5 +++++
>>  kernel/cobalt/trace/cobalt-core.h | 33 +++++++++++++++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
>> index 8befa795c..c20c4cc1a 100644
>> --- a/kernel/cobalt/registry.c
>> +++ b/kernel/cobalt/registry.c
>> @@ -685,6 +685,7 @@ int xnregistry_enter(const char *key, void *objaddr,
>>  	nr_active_objects++;
>>  	object->objaddr = objaddr;
>>  	object->cstamp = ++next_object_stamp;
>> +	trace_cobalt_registry_enter(key, objaddr);
>>  #ifdef CONFIG_XENO_OPT_VFILE
>>  	object->pnode = NULL;
>>  #endif
>> @@ -866,6 +867,8 @@ int xnregistry_remove(xnhandle_t handle)
>>  		goto unlock_and_exit;
>>  	}
>>  
>> +	trace_cobalt_registry_remove(object->key, object->objaddr);
>> +
>>  	objaddr = object->objaddr;
>>  	object->objaddr = NULL;
>>  	object->cstamp = 0;
>> @@ -932,6 +935,8 @@ int xnregistry_unlink(const char *key)
>>  		goto unlock_and_exit;
>>  	}
>>  
>> +	trace_cobalt_registry_unlink(object->key, object->objaddr);
>> +
>>  	ret = registry_hash_remove(object);
>>  	if (ret < 0)
>>  		goto unlock_and_exit;
>> diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt-core.h
>> index 88ed5700d..d98787c5a 100644
>> --- a/kernel/cobalt/trace/cobalt-core.h
>> +++ b/kernel/cobalt/trace/cobalt-core.h
>> @@ -26,6 +26,7 @@
>>  #include <linux/tracepoint.h>
>>  #include <linux/math64.h>
>>  #include <cobalt/kernel/timer.h>
>> +#include <cobalt/kernel/registry.h>
>>  #include <cobalt/uapi/kernel/types.h>
>>  
>>  struct xnsched;
>> @@ -149,6 +150,23 @@ DECLARE_EVENT_CLASS(timer_event,
>>  	TP_printk("timer=%p", __entry->timer)
>>  );
>>  
>> +DECLARE_EVENT_CLASS(registry_event,
>> +	TP_PROTO(const char *key, void *addr),
>> +	TP_ARGS(key, addr),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(key, key ?: "(anon)")
>> +		__field(void *, addr)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(key, key ?: "(anon)");
>> +		__entry->addr = addr;
>> +	),
>> +
>> +	TP_printk("key=%s, addr=%p", __get_str(key), __entry->addr)
>> +);
>> +
>>  TRACE_EVENT(cobalt_schedule,
>>  	TP_PROTO(struct xnsched *sched),
>>  	TP_ARGS(sched),
>> @@ -778,6 +796,21 @@ DEFINE_EVENT(synch_post_event, cobalt_synch_forget,
>>  	TP_ARGS(synch)
>>  );
>>  
>> +DEFINE_EVENT(registry_event, cobalt_registry_enter,
>> +	TP_PROTO(const char *key, void *addr),
>> +	TP_ARGS(key, addr)
>> +);
>> +
>> +DEFINE_EVENT(registry_event, cobalt_registry_remove,
>> +	TP_PROTO(const char *key, void *addr),
>> +	TP_ARGS(key, addr)
>> +);
>> +
>> +DEFINE_EVENT(registry_event, cobalt_registry_unlink,
>> +	TP_PROTO(const char *key, void *addr),
>> +	TP_ARGS(key, addr)
>> +);
>> +
>>  TRACE_EVENT(cobalt_tick_shot,
>>  	TP_PROTO(s64 delta),
>>  	TP_ARGS(delta),
>>
> 
> Thanks, applied to next.
> 
> Jan
> 

Fixed up a missing include in registry.c.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

