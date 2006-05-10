Message-ID: <4461DC6D.7020100@domain.hid>
Date: Wed, 10 May 2006 14:28:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] zombie mutex owners
References: <44619D0B.1080402@domain.hid>	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
	<4461BB5A.3010403@domain.hid>
In-Reply-To: <4461BB5A.3010403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
> 
>>Hi Jan,
>>
>>
>>>running the attached test case for the native skin, you will get an ugly
>>>lock-up on probably all Xenomai versions. Granted, this code is a bit
>>>synthetic. I originally thought I could trigger the bug also via
>>>timeouts when waiting on mutexes, but this scenario is safe (the timeout
>>>is cleared before being able to cause harm).
>>>
>>
>>just in order to educate me as probably I might have got something
>>wrong at the first glance :)
>>
>>if we take this one:
>>
>>--- mutex.c    2006-02-27 15:34:58.000000000 +0100
>>+++ mutex-NEW.c    2006-05-10 11:55:25.000000000 +0200
>>@@ -391,7 +391,7 @@ int rt_mutex_lock (RT_MUTEX *mutex,
>>    err = -EIDRM; /* Mutex deleted while pending. */
>>    else if (xnthread_test_flags(&task->thread_base,XNTIMEO))
>>    err = -ETIMEDOUT; /* Timeout.*/
>>-    else if (xnthread_test_flags(&task->thread_base,XNBREAK))
>>+    else if (xnthread_test_flags(&task->thread_base,XNBREAK) &&
>>mutex->owner != task)
>>    err = -EINTR; /* Unblocked.*/
>>
>> unlock_and_exit:
>>
>>As I understand task2 has a lower prio and that's why
>>
>>[task1] rt_mutex_unlock
>>[task 1] rt_task_unblock(task1)
>>
>>are called in a row.
>>
>>ok, task2 wakes up in rt_mutex_unlock() (when task1 is blocked on
>>rt_mutex_lock()) and finds XNBREAK flag but,
>>
>>[doc] -EINTR is returned if rt_task_unblock() has been called for the
>>waiting task (1) before the mutex has become available (2).
>>
>>(1) it's true, task2 was still waiting at that time;
>>(2) it's wrong, task2 was already the owner.
>>
>>So why just not to bail out XNBREAK and continue task2 as it has a
>>mutex (as shown above) ?
> 
> 
> Indeed, this solves the issue more gracefully.
> 

The real issue with the XNBREAK bit is that xnpod_unblock_thread() 
should only raise it for threads which it does actually awake, and not 
for those which are already resumed, e.g. by a call to 
xnsynch_wakeup_sleeper().

This explains why task2 gets -EINTR from rt_mutex_lock() albeit the 
syscall has indeed succeeded, so that the next rt_mutex_unlock() was ok, 
but the downstream code might clearly be confused by such behaviour. It 
should get a success code instead, since it has been resumed by 
xnsynch_wakeup_sleeper() _before_ xnpod_unblock_thread() has been called 
against it. Fixed in the repository.

-- 

Philippe.

