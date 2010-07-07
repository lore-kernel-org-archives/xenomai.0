Message-ID: <4C34AD18.9090902@domain.hid>
Date: Wed, 07 Jul 2010 18:36:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
	<4C347815.9050107@domain.hid>
	<181804936ABC2349BE503168465576460F384F38@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460F384F38@domain.hid>
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
>> Sent: Wednesday, July 07, 2010 7:50 AM
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
>> Hi,
>>
>> I had a look at the code, and chances are, that in fact it 
>> never worked.
>> The native skin threads are created with asynchronous type, 
>> and the rest  of the skin assumes that it is always the case. 
>> To kill a native skin thread, you are supposed to use 
>> rt_task_delete instead of pthread_cancel, and if you did not 
>> change the thread cancellation type, it will work. If you are 
>> interested in waiting for the thread deletion, you can create 
>> the thread joinable with T_JOINABLE, then wait for it with 
>> rt_task_join.
>>
>> We can, of course, modify the code to allow changing the 
>> native thread cancellation type. But the question is: what is 
>> the use-case?
>>
>>
>> -- 
>> 					    Gilles.
> 
> 
> I was not creating a native thread though.  I was creating a POSIX
> thread, which used some native skin calls.  I do not have a RT_TASK in
> this case to even use with rt_task_delete, unless there is something to
> convert from a pthread_t to a RT_TASK I'm not aware of.  In any case I'm
> wanting to cancel a POSIX thread, not a native one.

The point is that rt_cond_wait assumes that the caller is a native skin
thread, so that it is running with the asynchronous type.

> 
> My usage case is basically as I described previously.  I have some code
> sectioned off in a static library.  This code uses only native calls for
> stuff like mutexes and condition variable using the assumption that the
> end application using the library need not link against the POSIX skin.
> In one of the applications it was using a POSIX skin, with POSIX
> threads, and was cancelling a thread that was blocked with rt_cond_wait.
> 
> Just out of curiosity, is there anything analogous to pthread cleanup
> handlers in the native skin?  You mentioned earlier that you cannot use
> the rt_add_hook in userspace.  So is there anyway then to protect
> against the situation described earlier, where you delete a thread
> waiting on a condition variable.  Will the thread reacquire the mutex
> before deletion as in the POSIX case and does the rt_task_delete make
> sure not to delete the thread while it is holding the mutex in this
> case?

I already answered that: yes, the thread will re-acquire the mutex. The
pthread_cleanup_push/pthread_cleanup_pop services can be called from a
native skin thread, they are part of the glibc, not of Xenomai posix
skin, so you do not need to link against the Xenomai posix skin library.

Anyway, the proper way to fix this, which we use in the POSIX skin, is
to set the cancellation type to asynchronous just before calling
rt_cond_wait, saving the previoys cancellation type, then restore the
cancellation type after rt_cond_wait.


-- 
					    Gilles.

