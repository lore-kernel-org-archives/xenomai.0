References: <874kkjurgf.fsf@xenomai.org>
 <84f868cf-5713-c7cc-95bb-c03d3e89cd93@siemens.com>
 <874kkcvm8d.fsf@xenomai.org>
 <63816e8d-12b1-648e-0312-61d2f80b865f@siemens.com>
 <87wnwmjb7r.fsf@xenomai.org>
 <ebb2debf-74a5-7e38-415e-5e4de39d2a71@siemens.com>
 <87ft37k43p.fsf@xenomai.org>
 <16b7e6cc-f1ac-cd97-55df-90c288c599ef@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [CXP] Discussing the RTDM specification
In-reply-to: <16b7e6cc-f1ac-cd97-55df-90c288c599ef@siemens.com>
Date: Sat, 16 Jan 2021 16:41:50 +0100
Message-ID: <87r1mkrirl.fsf@xenomai.org>
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

> On 11.01.21 14:14, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 09.01.21 18:01, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> On 23.12.20 11:40, Philippe Gerum wrote:
>>>>>>
>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>
>>>>>>> On 18.12.20 15:19, Philippe Gerum via Xenomai wrote:
>>>>>>>>
>>>>>>>> This wiki page [1] contains a draft proposal about specifying which
>>>>>>>> services from the current RTDM interface should be part of the Common
>>>>>>>> Xenomai Platform. Some proposals for deprecation stand out:
>>>>>>>>
>>>>>>>> - I suspect that only very few RTDM drivers are actually handling
>>>>>>>>   requests from other kernel-based drivers in real world applications,
>>>>>>>>   at least not enough to justify RTDM codifying these rare cases into a
>>>>>>>>   common interface (rtdm_open, rtdm_read, rtdm_write etc).
>>>>>>>>
>>>>>>>>   In other words, although I would agree that a few particular drivers
>>>>>>>>   might want to export a couple of services to kernel-based clients in
>>>>>>>>   order to provide them some sort of backchannel, it seems wrong to
>>>>>>>>   require RTDM drivers to provide a kernel interface which would match
>>>>>>>>   their user interface in the same terms. For these specific cases, ad
>>>>>>>>   hoc code in these few drivers should be enough.
>>>>>>>>
>>>>>>>>   Besides, I believe that most kernel->kernel request paths implemented
>>>>>>>>   by in-tree RTDM drivers have never been tested for years, if ever.
>>>>>>>>   Meanwhile, this kernel->kernel API introduces a basic exception case
>>>>>>>>   into many RTDM and driver code paths, e.g. for differentiating kernel
>>>>>>>>   vs user buffers, for only very few use cases.
>>>>>>>>
>>>>>>>>   For these reasons, I would suggest to deprecate the kernel->kernel API
>>>>>>>>   from RTDM starting from 3.3, excluding it from the CXP in the same
>>>>>>>>   move.
>>>>>>>
>>>>>>> That's fine with me. The idea was once that something like bus drivers
>>>>>>> would appear, but that never happened.
>>>>>>>
>>>>>>>>
>>>>>>>> - RTDM_EXECUTE_ATOMICALLY() and related calls relying on the Cobalt big
>>>>>>>>   lock must go. For SMP scalability reasons, this big lock was
>>>>>>>>   eliminated from the EVL core, which means that all the attached
>>>>>>>>   semantics will not hold there. Serializing access to shared resources
>>>>>>>>   should be guaranteed by resource-specific locking, not by a giant
>>>>>>>>   traffic light like the big lock implements.
>>>>>>>
>>>>>>> This is more complicated: RTDM_EXECUTE_ATOMICALLY was in fact deprecated
>>>>>>> long ago, but users were migrated to cobalt_atomic_enter/leave which may
>>>>>>> now make it look like we no longer need this. Maybe this is already the
>>>>>>> case when using rtdm_waitqueue*, but let's convert everyone first.
>>>>>>
>>>>>> Alternatively, In-tree v3 drivers could also keep relying
>>>>>> RTDM_EXECUTE_ATOMICALLY, the v4 implementation would be different for
>>>>>> them. Bottom line is to exclude from the CXP the whole idea that we may
>>>>>> schedule while holding a lock to protect against missed wake ups, in
>>>>>> general the very existence of any superlock which would cover everything
>>>>>> from top to bottom when serializing. I agree that having v3 converge
>>>>>> towards the CXP would be better though.
>>>>>>
>>>>>
>>>>> I'm fine with migrating to a new pattern first, drop that old RTDM
>>>>> pattern and declare the new one as migration path. Same for below.
>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> - rtdm_mutex_timedlock() has dubious semantics. Hitting a timeout
>>>>>>>>   condition on grabbing a mutex either means that:
>>>>>>>>
>>>>>>>
>>>>>>> I think you are missing the use cases:
>>>>>>>
>>>>>>> mutex-lock-timed
>>>>>>> ...
>>>>>>> wait-event-timed
>>>>>>> ...
>>>>>>> mutex-unlock
>>>>>>> (which goes long with timeout sequences)
>>>>>>>
>>>>>>
>>>>>> There is a couple of issues with such use case: first we should never
>>>>>> ever sleep with a mutex held, this would trigger SIGDEBUG if done from
>>>>>> user ( a [binary] semaphore would at least prevent this problem), but
>>>>>> more importantly, how would this pattern allow the event to be signaled
>>>>>> given the waiter holds the lock the sender would need to acquire first?
>>>>>
>>>>> Just look at the existing drivers for the use cases (which obviously
>>>>> imply signalling without holding the mutex).
>>>>>
>>>>
>>>> Excluding RTDM_EXECUTE_ATOMICALLY() which has no in-tree user, what
>>>> remains is solving the issue for users of the cobalt_atomic_{enter,
>>>> leave} pattern, i.e.:
>>>>
>>>> kernel/drivers/can/rtcan_raw.c
>>>> kernel/drivers/can/rtcan_socket.c
>>>> kernel/drivers/ipc/bufp.c
>>>> kernel/drivers/ipc/iddp.c
>>>> kernel/drivers/ipc/rtipc.c
>>>> kernel/drivers/ipc/xddp.c
>>>> kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c
>>>> kernel/drivers/testing/timerbench.c
>>>> kernel/drivers/udd/udd.c
>>>>
>>>> For the call sites listed about, AFAICS we'd need to:
>>>>
>>>> 1. move any blocking call out of the locking scope, by rewriting these
>>>> as wait loops rechecking the condition under lock if/when required. Only
>>>> a few would need the latter in fact, as in many cases
>>>> cobalt_atomic_leave() immediately follows the blocking call in the code
>>>> flow.
>>>>
>>>> 2. provide _nosched variants for signaling calls
>>>> (e.g. rtdm_event_pulse_nosched()) and use them, invoking xnsched_run()
>>>> out of lock as appropriate.
>>>>
>>>> However, I cannot find any code exhibiting the issue with mutexes in
>>>> these matches. Do you have an in-tree example of the problem you see to
>>>> point me at?
>>>>
>>>
>>> All serial drivers use mutexes with timeout in order to make write
>>> operations atomic and permit waiting for free buffers inside that atomic
>>> section.
>> 
>> Ok, but none of these driver sleep with the superlock held, which is the
>> pattern I'm looking for at the moment. Sleeping with a mutex is a
>> different issue which also requires some fixing, but neither involves
>> the RTDM_EXECUTE_ATOMICALLY() or cobalt_atomic_enter/leave() constructs.
>> 
>
> It /could/ require it if it was not sleeping with mutexes.
>

There is another way, which would be to align Cobalt on the common
pattern for waiting for events racelessly, i.e. by enqueuing the current
thread signaling the event under lock, but without rescheduling. Then
dropping the lock before calling xnsched_run() eventually.

For this, we would need the xnsynch_sleep_on_noresched() variant, which
would in turn call a no-resched variant of xnthread_suspend(), not
triggering a rescheduling if the suspended thread is current. This would
allow us to keep the signal+update sections atomic, without having to
reschedule while holding the lock. Likewise, the consumer side would
follow the pattern used with common wait queues. This is exactly what
the EVL core does, mimicking the common wait queues.

Ideally, it would be possible to amend the internal implementation of
the RTDM waitqueues to provide such support, without changing its
interface.

-- 
Philippe.

