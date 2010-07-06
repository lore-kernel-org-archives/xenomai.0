Message-ID: <4C3380CA.10704@domain.hid>
Date: Tue, 06 Jul 2010 21:15:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
	<4C3378E2.2050401@domain.hid>
	<181804936ABC2349BE503168465576460F384827@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460F384827@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mixing skin calls (cancellation points)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
>> Sent: Tuesday, July 06, 2010 1:42 PM
>> To: Steve Deiters
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] Mixing skin calls (cancellation points)
>>
>> Steve Deiters wrote:
>>> Is it in general valid to mix calls from different skins?  In 
>>> particular, can I expect the native skin calls to work as POSIX 
>>> cancellation points?  For example, if I have a POSIX thread with a 
>>> pthread_t identifier which I know calls rt_cond_wait 
>> somewhere, will 
>>> it work as a cancellation point when I call pthread_cancel?
>>>
>>> The example program attached will not cancel if I have 
>> CANCEL_DEFERRED 
>>> defined as 1 at the top, which sets the cancel type to 
>> deferred.  This 
>>> is on a PowerPC with Xenomai 2.5.3.  I think this worked 
>> with Xenomai 
>>> 2.4.10.
>>>
>>>
>>> --------
>>>
>>>
>>> #include <stdio.h>
>>> #include <errno.h>
>>> #include <stdlib.h>
>>> #include <unistd.h>
>>> #include <pthread.h>
>>> #include <native/task.h>
>>> #include <native/cond.h>
>>>
>>> #define CANCEL_DEFERRED 1
>>>
>>> RT_MUTEX mutex;
>>> RT_COND cond;
>>> pthread_t thread;
>>>
>>> void *entry(void *cookie)
>>> {
>>>    fprintf(stderr, "Starting thread\n");
>>>
>>> #if CANCEL_DEFERRED
>>>    pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL); #else
>>>    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL); #endif
>>>
>>>    rt_mutex_acquire(&mutex, TM_INFINITE);
>>>    rt_cond_wait(&cond, &mutex, TM_INFINITE);
>>>    rt_mutex_release(&mutex);
>>>
>>>    return NULL;
>>> }
>> This program would also deadlock with plain POSIX: you are 
>> missing a cleanup handler which releases the mutex.
>>
>> -- 
>> 					    Gilles.
>>
> 
> My situation here is that I have some library routines, which were
> written using the native skin.  It was done like this so users of the
> library were not forced to link against the POSIX skin.  Not to say that
> they would use the libc POSIX implementation, just that they may want to
> use only the native skin.
> 
> Is there a deadlock issue here if I have the cancellation as deferred?
> Won't the rt_cond_wait already release the mutex.  This is similar to
> pthread_cond_wait which is a cancellation point in POSIX.  I realize the
> potential for deadlock if it asynchronous which is why I want the
> cancellation as deferred.

pthread_cond_wait, when cancelled, re-acquires the mutex, so, if you
want to release it, you have to pthread_cleanup_push a handler which
releases it. This is standard practice with the pthread API.
rt_cond_wait should behave the same way. Anyway, I do not think this is
your problem since no other thread has the mutex in your case.

> 
> If I ever do need to do something like this, can I use the
> rt_task_add_hook looking at T_HOOK_DELETE in place of a POSIX cleanup
> handler?

Basically, hook do not really work in user-space. So, you have to use
pthread_cleanup_push. pthread_cleanup_push is a function of the glibc,
not of Xenomai posix skin. So, you do not need linking with Xenomai
posix skin to use it.

> 
> This still doesn't say whether or not I can rely on the rt_cond_wait as
> a cancellation point.  If not I may have only two options: rewrite the
> library using the POSIX skin and force the users to use the POSIX skin,
> or force the user to use the native skin or avoid using pthread_cancel.
> Neither one is an appealing option.

It should be a cancellation point, but my point was that you may had the
impression that it was not because the thread was in fact blocked in the
mutex re-acquisition. Anyway, it is probably not your issue, so, we are
going to check your test case, and tell you more later.

> 
> Thanks.
> 
> 


-- 
					    Gilles.

