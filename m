From: Philippe Gerum <rpm@xenomai.org>
References: <0ab5b536-2e75-fdfe-96e9-f6321aca107d@siemens.com>
 <8e002d9f-6357-2177-f53e-59580707c27b@xenomai.org>
 <3fcdb522-6088-6649-0f53-dcdfad5c28d9@web.de>
 <a76f6572-90bd-1dfd-a6c4-c62af253f989@siemens.com>
 <1e423b89-fe5a-0c33-64dd-fc7d840b72a2@xenomai.org>
 <0cce82f0-f5af-de7a-c208-10c66320cd9e@xenomai.org>
 <624b5290-2187-a329-d2bb-5fb0f8c6006a@siemens.com>
 <d973d0e7-729f-eb10-fbea-bbc3cee36bae@xenomai.org>
Message-ID: <5b38225d-c35c-2808-f476-55b2276b89cb@xenomai.org>
Date: Sun, 14 Oct 2018 14:42:17 +0200
MIME-Version: 1.0
In-Reply-To: <d973d0e7-729f-eb10-fbea-bbc3cee36bae@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] cobalt/posix/mqueue: Remove unused cobalt_mqq and
 fix error cleanup bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/10/2018 09:42 AM, Philippe Gerum wrote:
> On 10/10/2018 09:31 AM, Jan Kiszka wrote:
>> On 09.10.18 20:21, Philippe Gerum wrote:
>>> On 10/09/2018 07:58 PM, Philippe Gerum wrote:
>>>> On 10/09/2018 11:27 AM, Jan Kiszka wrote:
>>>>> On 03.10.18 20:43, Jan Kiszka wrote:
>>>>>> On 03.10.18 19:24, Philippe Gerum wrote:
>>>>>>> On 10/02/2018 07:03 PM, Jan Kiszka wrote:
>>>>>>>> cobalt_mqq was only maintained but never queried. Remove it.
>>>>>>>>
>>>>>>>> This also simplify the fix for the broken error recovery in
>>>>>>>> mq_open: If
>>>>>>>> xnregistry_enter, we never entered the new element in cobalt_mqq and
>>>>>>>> also already decremented the reference counter. But then we asked
>>>>>>>> via
>>>>>>>> rtdm_fd_close to remove the entry as if it was registered. That
>>>>>>>> could
>>>>>>>> easily crash the system.
>>>>>>>>
>>>>>>>
>>>>>>> This looks like a logic which got orphaned when Cobalt stopped
>>>>>>> being a
>>>>>>> module unlike the 2.6.x nucleus. However, Cobalt services can be
>>>>>>> dynamically stopped via corectl, and we should reclaim the named
>>>>>>> queues
>>>>>>> that may have persisted until that happens. Re-connecting that logic
>>>>>>> when the core is switched to the stopped state may be a better
>>>>>>> choice.
>>>>>>
>>>>>> Do we do this for other resources already, or would this be a start?
>>>>>>
>>>>>
>>>>> Ping.
>>>>>
>>>>> Seems everything was migrated with e0e2775ad335 to
>>>>> cobalt_global_resources - except for the message queues - why?
>>>>
>>>> Because named mqs are persistent, survive the exit of the process which
>>>> created them.
>>>>
>>>
>>> 'global' as an identifier may be confusing in __reclaim_resources. This
>>> is the list of objects which are (p)shared between processes, with a
>>> well-identified owner though; their lifetime is bound to their
>>> respective owner's.
>>>
>>
>> OK - but aren't named semaphores, e.g., of the same kind? Something
>> looks inconsistent here.
>>
> 
> Yes, as long as we have sem_open() just like shm_open(), we'd have to
> deal with persistence the same way for both.
> 

s,shm_open,mq_open

I had a closer look, and the difference makes sense in this case: we can
have process-private anonymous semaphores to deal with at process exit,
which must be reclaimed. In contrast, mqs have no owner therefore can't
be reclaimed at process exit.

However, there is an issue with cobalt_mqq not being flushed upon
corectl --stop.

-- 
Philippe.

