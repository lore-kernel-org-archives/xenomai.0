References: <874kkjurgf.fsf@xenomai.org>
 <84f868cf-5713-c7cc-95bb-c03d3e89cd93@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [CXP] Discussing the RTDM specification
In-reply-to: <84f868cf-5713-c7cc-95bb-c03d3e89cd93@siemens.com>
Date: Wed, 23 Dec 2020 11:40:50 +0100
Message-ID: <874kkcvm8d.fsf@xenomai.org>
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

> On 18.12.20 15:19, Philippe Gerum via Xenomai wrote:
>> 
>> This wiki page [1] contains a draft proposal about specifying which
>> services from the current RTDM interface should be part of the Common
>> Xenomai Platform. Some proposals for deprecation stand out:
>> 
>> - I suspect that only very few RTDM drivers are actually handling
>>   requests from other kernel-based drivers in real world applications,
>>   at least not enough to justify RTDM codifying these rare cases into a
>>   common interface (rtdm_open, rtdm_read, rtdm_write etc).
>> 
>>   In other words, although I would agree that a few particular drivers
>>   might want to export a couple of services to kernel-based clients in
>>   order to provide them some sort of backchannel, it seems wrong to
>>   require RTDM drivers to provide a kernel interface which would match
>>   their user interface in the same terms. For these specific cases, ad
>>   hoc code in these few drivers should be enough.
>> 
>>   Besides, I believe that most kernel->kernel request paths implemented
>>   by in-tree RTDM drivers have never been tested for years, if ever.
>>   Meanwhile, this kernel->kernel API introduces a basic exception case
>>   into many RTDM and driver code paths, e.g. for differentiating kernel
>>   vs user buffers, for only very few use cases.
>> 
>>   For these reasons, I would suggest to deprecate the kernel->kernel API
>>   from RTDM starting from 3.3, excluding it from the CXP in the same
>>   move.
>
> That's fine with me. The idea was once that something like bus drivers
> would appear, but that never happened.
>
>> 
>> - RTDM_EXECUTE_ATOMICALLY() and related calls relying on the Cobalt big
>>   lock must go. For SMP scalability reasons, this big lock was
>>   eliminated from the EVL core, which means that all the attached
>>   semantics will not hold there. Serializing access to shared resources
>>   should be guaranteed by resource-specific locking, not by a giant
>>   traffic light like the big lock implements.
>
> This is more complicated: RTDM_EXECUTE_ATOMICALLY was in fact deprecated
> long ago, but users were migrated to cobalt_atomic_enter/leave which may
> now make it look like we no longer need this. Maybe this is already the
> case when using rtdm_waitqueue*, but let's convert everyone first.

Alternatively, In-tree v3 drivers could also keep relying
RTDM_EXECUTE_ATOMICALLY, the v4 implementation would be different for
them. Bottom line is to exclude from the CXP the whole idea that we may
schedule while holding a lock to protect against missed wake ups, in
general the very existence of any superlock which would cover everything
from top to bottom when serializing. I agree that having v3 converge
towards the CXP would be better though.

>
>> 
>> - rtdm_mutex_timedlock() has dubious semantics. Hitting a timeout
>>   condition on grabbing a mutex either means that:
>> 
>
> I think you are missing the use cases:
>
> mutex-lock-timed
> ...
> wait-event-timed
> ...
> mutex-unlock
> (which goes long with timeout sequences)
>

There is a couple of issues with such use case: first we should never
ever sleep with a mutex held, this would trigger SIGDEBUG if done from
user ( a [binary] semaphore would at least prevent this problem), but
more importantly, how would this pattern allow the event to be signaled
given the waiter holds the lock the sender would need to acquire first?

> In fact, all that could be replaced with
>
> mutex-lock
> ...
> atomic-entry
> mutex-unlock
> wait-event-timed
> mutex-lock
> atomic-leave
> ...
> mutex-lock
>
> but that is what we want to replace as well...
>

Yep, that would work for v3, preventing wake ups to be missed the same way.

-- 
Philippe.

