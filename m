Message-ID: <537B0A10.8030602@xenomai.org>
Date: Tue, 20 May 2014 09:53:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
 <1400437808.41304.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <5379B6BA.2040509@xenomai.org>
 <1400569593.17864.YahooMailNeo@web171602.mail.ir2.yahoo.com>
In-Reply-To: <1400569593.17864.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/20/2014 09:06 AM, Matthias Schneider wrote:
>
>
>
>
>
> ----- Original Message -----
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Monday, May 19, 2014 9:46 AM
>> Subject: Re: [Xenomai] FreeRTOS skin
>>
>> On 05/18/2014 08:30 PM, Matthias Schneider wrote:
>>>   ----- Original Message -----
>>>
>>>>   From: Philippe Gerum <rpm@xenomai.org>
>>>>   To: Matthias Schneider <ma30002000@yahoo.de>;
>> "xenomai@xenomai.org" <xenomai@xenomai.org>
>>>>   Cc:
>>>>   Sent: Monday, May 5, 2014 12:33 PM
>>>>   Subject: Re: [Xenomai] FreeRTOS skin
>>>>
>>>>   On 05/04/2014 06:59 PM, Matthias Schneider wrote:
>>>>
>>>>>     Hi all,
>>>>>
>>>>>     please find enclosed a patch with a FreeRTOS skin for
>> xenomai-forge I have
>>>>>     been  working on for some time. I would like to get some feedback
>> and advice
>>>>>     what still needs to be done to get it accepted in Xenomai. There
>> is a set of
>>>>>     unit tests included and the possibility to download the original
>> FreeRTOS package
>>>>>     in order to run most of its (platform independent) test suite.
>> Until now I have
>>>>>     been working under mercury only. Documentation is available in
>> form of a README
>>>>>     file in lib/freertos/README, which should also be a good starting
>> point.
>>>>
>>>>   Ok, thanks for this. Let's address issues gradually, starting with
>> the
>>>>   task module.
>>>>
>>>   [...]
>>>>
>>>>   - the read/write_lock_nocancel() form is reserved for protecting
>>>>   sections which are known not to traverse cancellation points, as
>> defined
>>>>   by POSIX
>>>>
>> (http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_09.html).
>>>>   This is about self-documentation of the code, and optimizing execution
>>>>   by omitting costly management of cleanup blocks when it is deemed safe
>>>>   to do so.
>>>>
>>>>   - CANCEL_DEFER() / CANCEL_RESTORE() should protect sections against
>>>>   asynchronous cancellation, we typically do this before invoking the
>>>>   copperplate layer, so that we may assume that pthread_cancel()
>> won't be
>>>>   a problem when running inner code, provided we have been careful about
>>>>   handling read/write lock cleanups. These macros work by disabling
>>>>   asynchronous cancellation for the current thread when
>>>>   --enable-async-cancel was given at build time. Otherwise, this part is
>> a
>>>>   nop.
>>>
>>>   Obviously the *nocancel locks in my previous patch (task.c) were incorrect.
>>>   However I am not sure which way to replace them - I see several
>> possibilities:
>>>
>>>   a)
>>>   push_cleanup_lock(&freertos_scheduler.lock);
>>>   write_lock(&freertos_scheduler.lock);
>>>   //will correctly clean up when thread is cancelled
>>>
>>>   b)
>>>   write_lock_safe(&freertos_scheduler.lock);
>>>   // will disable cancellation until lock is released
>>>
>>>   c)
>>>   do no care about locks in cancelled threads and just use
>>>   write_lock(&freertos_scheduler.lock)
>>>
>>>   Since freertos_scheduler.lock is essential for the correct functioning of
>> the
>>>   FreeRTOS skin, c) is probably out.
>>>
>>>   Any hint?
>>>
>>
>> I would restrict this lock to protecting manipulations of the task list,
>> nothing more. It seems to be covering too much code right now. Assuming
>> this, you would only need the _nocancel form to protect basic list
>> operations which do not cross any cancellation point.
>>
>> Having vTaskStartScheduler() wait for task termination should be as
>> simple as a condvar-based protocol, e.g.
>>
>> __RT(mutex_lock(&tasklist_lock));
>>
>> for (;;) {
>>      if (pvlist_empty(&task_list))
>>          break;
>>      __RT(pthread_cond_wait(&tasklist_cond, &tasklist_lock));
>> }
>>
>> __RT(mutex_unlock(&tasklist_lock));
>>
>> You could then synchronize with the task finalizer, e.g.
>>
>> task_finalizer:
>>
>> __RT(mutex_lock(&tasklist_lock));
>>
>> pvlist_remove(&task->next);
>>
>> if (freertos_scheduler.state != taskSCHEDULER_RUNNING &&
>> pvlist_empty(&task_list))
>>      __RT(pthread_cond_signal(&tasklist_cond));
>>
>> __RT(mutex_lock(&tasklist_lock));
>>
>> I would also introduce a new scheduler state, e.g.
>> taskSCHEDULER_STOPPING, which could be used to prevent a concurrent call
>> to vTaskStartScheduler() to respawn the system until the ongoing
>> shutdown has eventually completed.
>>
>> PS: The __RT() modifier means to pick the dual kernel version of this
>> call over Cobalt (i.e. the real-time one implemented by Xenomai), or the
>> regular glibc one over Mercury. __STD() means to always pick the
>> glibc-based call, regardless of the real-time core underneath.
>>
>> If you mention no modifier, either of __RT/__STD may be assumed
>> depending on whether symbol wrapping is enabled at link time. To prevent
>> any ambiguity, a skin should always specify the appropriate modifier for
>> calls the Cobalt core overrides from the glibc, since applications may
>> or may not require symbol wrapping.
>>
>
> Considering that the simple approach was the one I had originally employed
> until I implemented vTaskResumeAll and vTaskSuspendAll
> I suppose it all comes down how to implement these two functions.
>
> I am nearly convinced to implement them via threadobj_lock_sched() and
> threadobj_unlock_sched(), which should make most of the proposed
> re-simplifications possible, but I have still two points:
>
> * On smp machines, it will not behave as expected since the mentioned
> functions will prevent the current thread from being scheduled out,
> but not from other tasks being executed on other CPUs if I am correct
>

Yes. But does the FreeRTOS API spec state that such calls should be 
SMP-capable? Is there any FreeRTOS incarnation leveraging multi-core 
systems?

> * functions like vTaskDelay / threadobj_sleep() will not perform as expected
> since they may cause the curren task being schduled out.
>
> Is there anything I can do about these?
>
> Also, functions like xTaskIsTaskSuspended() and uxTaskPriorityGet need to be
> adapted to return simulated values, but this should be easy.
>

A more general note about sched locking in a Xenomai environment (both 
Cobalt and Mercury):

threadobj_lock/unlock_sched() will not even prevent the locking thread 
to be scheduled out, it will prevent involuntary preemption, which is 
quite different. If that thread has to block internally for gaining 
access to any resource, it will schedule out, including on UP systems 
(think of a copy-on-write fault or blocking on a native kernel mutex 
with Mercury, or relaxing a thread with Cobalt, both threads holding the 
scheduler lock when this happens).

On most legacy RTOS with no MMU or sleeping locks, this won't happen, 
therefore blocking voluntarily while holding a sched lock will actually 
freeze the system entirely, as this is not considered valid action from 
the application. Xenomai allows blocking voluntarily while holding such 
lock, which is automatically dropped during the sleep time, because 
there are situations imposed on us by the host GPOS which may require this.

Generally speaking, sched locking/unlocking is a fundamentally wrong 
locking method: it's just about using a single giant traffic light for 
controlling access to resources.

This (anti-)feature is provided only to emulate closely enough those 
legacy RTOS APIs for supporting applications, but using it for 
synchronizing emulators internally is definitely not the way to go.

In short, sched locking is not simple, it's just coarse-grained and I 
would go on to say "unreliable by design" over Mercury, since there is 
no way to prevent a thread from being blocked on some kernel resource by 
the host GPOS running the emulator. The only option would be to force 
all threads to suspend in a signal handler (and make sure they did 
before proceeding), which seems to me seriously overkill, given that 
such locking construct should be discouraged.

This said, I agree that vTaskResumeAll() and vTaskSuspendAll() should 
map over threadobj_unlock_sched() and threadobj_lock_sched() 
respectively, hoping for the best possible emulation of the scheduler lock.

-- 
Philippe.

