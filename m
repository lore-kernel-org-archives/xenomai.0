Message-ID: <53DFBD97.4000001@xenomai.org>
Date: Mon, 04 Aug 2014 19:06:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>	<53B57361.1000603@xenomai.org>	<CAKc2HpZROnFhxVZo3PWQzAoTYZHvvRCydFqxokKS_bQT2LHYVg@mail.gmail.com>	<53BC20E5.6090607@xenomai.org>	<CAKc2HpbWrU7_1JG4_K9+P_3H8Vs5-xq6W7aZ4ELjVNB+ReOD0A@mail.gmail.com>	<53BD0AA6.30901@xenomai.org>	<CAKc2Hpaaqi69CSgJZc54kqAYNVdPyTS_D0hnXjKAKLDb41BSuw@mail.gmail.com>	<53BD4EBC.5010601@xenomai.org>	<CAKc2HpbbN+kY9h55iYGqTk4c9bxDEb-OZ2orN07wKuyi42KndA@mail.gmail.com>	<CAKc2HpZ_VHevyV-Eh3jL5FhWub1LZjO=p3xBgesYdAgubN2H7Q@mail.gmail.com>	<53D62F5B.5040208@xenomai.org>	<CAKc2HpZOrT=VJnwi5q0W1FmPHQjDYHBpjpNjp+NUAn=txDU3UA@mail.gmail.com>	<53D6C634.3040700@xenomai.org>
 <CAKc2HpZZRA-364=tTdK94bUc3a2kK05xDMu3=YNgMzZp0XNEzg@mail.gmail.com>
In-Reply-To: <CAKc2HpZZRA-364=tTdK94bUc3a2kK05xDMu3=YNgMzZp0XNEzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/29/2014 09:31 AM, Kim De Mey wrote:
> 2014-07-28 23:52 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
>> On 07/28/2014 05:18 PM, Kim De Mey wrote:
>>> 2014-07-28 13:09 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
>>>> On 07/23/2014 10:31 AM, Kim De Mey wrote:
>>>>> 2014-07-09 17:05 GMT+02:00 Kim De Mey <kim.demey@gmail.com>:
>>>>>>
>>>>>> 2014-07-09 16:16 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
>>>>>>> On 07/09/2014 12:23 PM, Kim De Mey wrote:
>>>>>>>>
>>>>>>>> 2014-07-09 11:25 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
>>>>>>>>>
>>>>>>>>> On 07/09/2014 10:09 AM, Kim De Mey wrote:
>>>>>>>>>
>>>>>>>>>> Newer version --dump-config output:
>>>>>>>>>> ...
>>>>>>>>>> CONFIG_XENO_COMPILER="gcc version 4.7.0 (Cavium Inc. Version:
>>>>>>>>>> SDK_3_1_0 build 27) "
>>>>>>>>>> ...
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks. I can't reproduce this issue yet, so posting the current gdb
>>>>>>>>> backtraces for all the threads still shown by "info threads" after a
>>>>>>>>> deadlock would help.
>>>>>>>>>
>>>>>>>>> TIA,
>>>>>>>>>
>>>>>>>>
>>>>>>>> Below backtraces of all the threads. It is a case with two "worker"
>>>>>>>> tasks in deadlock. The "main" and "create_delete" tasks continued to
>>>>>>>> their "tm_wkafter" loop.
>>>>>>>>
>>>>>>>>
>>>>>>>> (gdb) thread a a bt
>>>>>>>>
>>>>>>>> Thread 4 (Thread 9406):
>>>>>>>> #0  0x77cc2d94 in __pthread_mutex_lock_full (mutex=0x77b03300) at
>>>>>>>> pthread_mutex_lock.c:321
>>>>>>>> #1  0x77cc7e64 in __GI___pthread_mutex_lock (mutex=0x77b03300) at
>>>>>>>> pthread_mutex_lock.c:55
>>>>>>>> #2  0x77cf91e0 in threadobj_lock () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
>>>>>>>> #3  0x77cf92e4 in finalize_thread () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
>>>>>>>> #4  0x77cc5704 in __nptl_deallocate_tsd () at pthread_create.c:156
>>>>>>>> #5  0x77cc5940 in start_thread (arg=0x75dff490) at pthread_create.c:315
>>>>>>>> #6  0x77bf1bbc in __thread_start () from
>>>>>>>> output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
>>>>>>>> Backtrace stopped: frame did not save the PC
>>>>>>>>
>>>>>>>> Thread 3 (Thread 31145):
>>>>>>>> #0  0x77cc2d94 in __pthread_mutex_lock_full (mutex=0x77b030b8) at
>>>>>>>> pthread_mutex_lock.c:321
>>>>>>>> #1  0x77cc7e64 in __GI___pthread_mutex_lock (mutex=0x77b030b8) at
>>>>>>>> pthread_mutex_lock.c:55
>>>>>>>> #2  0x77cf91e0 in threadobj_lock () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
>>>>>>>> #3  0x77cf92e4 in finalize_thread () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
>>>>>>>> #4  0x77cc5704 in __nptl_deallocate_tsd () at pthread_create.c:156
>>>>>>>> #5  0x77cc5940 in start_thread (arg=0x766ff490) at pthread_create.c:315
>>>>>>>> #6  0x77bf1bbc in __thread_start () from
>>>>>>>> output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
>>>>>>>> Backtrace stopped: frame did not save the PC
>>>>>>>>
>>>>>>>> Thread 2 (Thread 6970):
>>>>>>>> #0  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
>>>>>>>> req=<optimized out>, rem=<optimized out>)
>>>>>>>>      at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:50
>>>>>>>> #1  0x77cfa0bc in threadobj_sleep () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
>>>>>>>> #2  0x77d2af08 in tm_wkafter () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
>>>>>>>> #3  0x10000b64 in create_delete (a=0, b=0, c=0, d=0) at
>>>>>>>> delete_child_hangs.c:31
>>>>>>>> #4  0x77d296fc in task_trampoline () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
>>>>>>>> #5  0x77cf7d84 in thread_trampoline () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
>>>>>>>> #6  0x77cc592c in start_thread (arg=0x77a00490) at pthread_create.c:310
>>>>>>>> #7  0x77bf1bbc in __thread_start () from
>>>>>>>> output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
>>>>>>>> Backtrace stopped: frame did not save the PC
>>>>>>>>
>>>>>>>> Thread 1 (Thread 6969):
>>>>>>>> #0  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
>>>>>>>> req=<optimized out>, rem=<optimized out>)
>>>>>>>>      at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:50
>>>>>>>> #1  0x77cfa0bc in threadobj_sleep () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
>>>>>>>> #2  0x77d2af08 in tm_wkafter () from
>>>>>>>>
>>>>>>>> /repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
>>>>>>>> #3  0x10000c00 in main (argc=1, argv=0x10011030) at
>>>>>>>> delete_child_hangs.c:43
>>>>>>>>
>>>>>>>
>>>>>>> Ok, unless we've entered the twilight zone, the only reason I could see this
>>>>>>> happening would be that the thread prologue somehow gets hit by an async
>>>>>>> cancellation signal while holding its own lock. If so, then the patch below
>>>>>>> would cause an assertion to trigger in such circumstance. You will have to
>>>>>>> turn on --enable-assert in your configuration, leaving debugging entirely
>>>>>>> off not to significantly affect the current timings.
>>>>>>>
>>>>>>> diff --git a/include/boilerplate/lock.h b/include/boilerplate/lock.h
>>>>>>> index 6f0218c..b704987 100644
>>>>>>> --- a/include/boilerplate/lock.h
>>>>>>> +++ b/include/boilerplate/lock.h
>>>>>>> @@ -206,7 +206,7 @@ int __check_cancel_type(const char *locktype);
>>>>>>>  #define read_unlock_safe(__lock, __state)      \
>>>>>>>         __do_unlock_safe(__lock, __state)
>>>>>>>
>>>>>>> -#ifdef CONFIG_XENO_DEBUG
>>>>>>> +#ifndef NDEBUG
>>>>>>>  #define mutex_type_attribute PTHREAD_MUTEX_ERRORCHECK
>>>>>>>  #else
>>>>>>>  #define mutex_type_attribute PTHREAD_MUTEX_NORMAL
>>>>>>> diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
>>>>>>> index 05bb6cb..6547460 100644
>>>>>>> --- a/lib/copperplate/threadobj.c
>>>>>>> +++ b/lib/copperplate/threadobj.c
>>>>>>> @@ -1310,6 +1310,7 @@ int threadobj_cancel(struct threadobj *thobj)
>>>>>>>  static void finalize_thread(void *p) /* thobj->lock free */
>>>>>>>  {
>>>>>>>         struct threadobj *thobj = p;
>>>>>>> +       int ret;
>>>>>>>
>>>>>>>         if (thobj == NULL || thobj == THREADOBJ_IRQCONTEXT)
>>>>>>>                 return;
>>>>>>> @@ -1343,7 +1344,9 @@ static void finalize_thread(void *p) /* thobj->lock
>>>>>>> free */
>>>>>>>          * waiting for us to start, pending on
>>>>>>>          * wait_on_barrier(). Instead, hand it over to this thread.
>>>>>>>          */
>>>>>>> -       threadobj_lock(thobj);
>>>>>>> +       ret = threadobj_lock(thobj);
>>>>>>> +       assert(ret == 0);
>>>>>>> +       (void)ret;
>>>>>>>         if ((thobj->status & __THREAD_S_SAFE) == 0) {
>>>>>>>                 threadobj_unlock(thobj);
>>>>>>>                 destroy_thread(thobj);
>>>>>>>
>>>>>>
>>>>>> And...the assert kicks in!
>>>>>>
>>>>>> threadobj.c:1348: finalize_thread: Assertion `ret == 0' failed.
>>>>>
>>>>>
>>>>> Philippe,
>>>>>
>>>>> Could you explain this case of the async cancellation signal? I don't
>>>>> fully understand how this happens or why it causes the issue.
>>>>>
>>>>> I also tested once with CONFIG_XENO_ASYNC_CANCEL OFF and then the
>>>>> issue doesn't occur anymore.
>>>>>
>>>>>
>>>>
>>>> I have not been able to reproduce this race yet, but still the following patch would make sense:
>>>>
>>>> diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
>>>> index 05bb6cb..48aa032 100644
>>>> --- a/lib/copperplate/threadobj.c
>>>> +++ b/lib/copperplate/threadobj.c
>>>> @@ -1045,9 +1045,11 @@ static int wait_on_barrier(struct threadobj *thobj, int mask)
>>>>                 if (status & mask)
>>>>                         break;
>>>>                 oldstate = thobj->cancel_state;
>>>> +               push_cleanup_lock(&thobj->lock);
>>>>                 __threadobj_tag_unlocked(thobj);
>>>>                 __RT(pthread_cond_wait(&thobj->barrier, &thobj->lock));
>>>>                 __threadobj_tag_locked(thobj);
>>>> +               pop_cleanup_lock(&thobj->lock);
>>>>                 thobj->cancel_state = oldstate;
>>>>         }
>>>>
>>>> @@ -1243,9 +1245,11 @@ static void cancel_sync(struct threadobj *thobj) /* thobj->lock held */
>>>>          */
>>>>         while (thobj->status & __THREAD_S_WARMUP) {
>>>>                 oldstate = thobj->cancel_state;
>>>> +               push_cleanup_lock(&thobj->lock);
>>>>                 __threadobj_tag_unlocked(thobj);
>>>>                 __RT(pthread_cond_wait(&thobj->barrier, &thobj->lock));
>>>>                 __threadobj_tag_locked(thobj);
>>>> +               pop_cleanup_lock(&thobj->lock);
>>>>                 thobj->cancel_state = oldstate;
>>>>         }
>>>>
>>>
>>> I have tried this patch but it does not seem to make any difference.
>>> The threads are still deadlocked at the same location.
>>>
>>> I've only tested this on my setup with the old toolchain/kernel so
>>> far. I'll check also with the newer version.
>>>
>>
>> Ok, thanks for testing. I would not bother testing with another
>> toolchain, I don't buy the toolchain bug in this case. This looks like a
>> common race due to the async nature of the cancellation event which is
>> released while the caller holds its own lock without proper cleanup
>> actions. I'll dig deeper.
>>
> 
> Okay, in case there is anything you want me to try out, don't hesitate
> to tell me.
> 
> Thanks a lot already!
> 
> 

I could reproduce the issue eventually on your exact test code, by
dropping the cpu affinity from the test options (--cpu-affinity) on a
multi-core system. The patch below should paper over the current
manifestation of this bug, but the root issue which bites here lives way
below this API layer, and is clearly SMP-related. Are you running a
multi-core board?

diff --git a/lib/psos/task.c b/lib/psos/task.c
index 89ba917..1c37cc7 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -202,9 +202,10 @@ static void *task_trampoline(void *arg)

 	threadobj_unlock(&task->thobj);

+	threadobj_notify_entry();
+
 	CANCEL_RESTORE(svc);

-	threadobj_notify_entry();
 	args->entry(args->arg0, args->arg1, args->arg2, args->arg3);
 	threadobj_lock(&task->thobj);
 	threadobj_set_magic(&task->thobj, ~task_magic);

-- 
Philippe.

