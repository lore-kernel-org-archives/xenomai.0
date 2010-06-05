Message-ID: <4C0AA2F0.6050201@domain.hid>
Date: Sat, 05 Jun 2010 21:18:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid> <4C095876.3060605@domain.hid>
	<4C099329.6000303@domain.hid> <4C0A49C4.8000509@domain.hid>
	<4C0A9AB9.7030602@domain.hid> <4C0A9C2A.1030002@domain.hid>
	<4C0AA224.6060409@domain.hid>
In-Reply-To: <4C0AA224.6060409@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> GIT version control wrote:
>>>>>>> Module: xenomai-jki
>>>>>>> Branch: for-upstream
>>>>>>> Commit: 0352b068600bd4ef3172c8a42416badbcdad32ca
>>>>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=0352b068600bd4ef3172c8a42416badbcdad32ca
>>>>>>>
>>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>> Date:   Wed Apr 28 15:08:11 2010 +0200
>>>>>>>
>>>>>>> native: Rework handling of pthread carrier thread
>>>>>>>
>>>>>>> This patch improves two pitfalls of libnative's interaction with
>>>>>>> underlying pthreads:
>>>>>>>
>>>>>>> First, it tries to detect double deletions (cancellations or joinings)
>>>>>>> of pthreads and report them via an error code. This reduces the risk to
>>>>>>> trigger a SIGSEGV accessing meanwhile released pthread objects. And
>>>>>>> second, it properly detaches joinable pthreads when they are deleted
>>>>>>> instead. This properly releases the pthread resources.
>>>>>> I really do not understand that. What is the point of creating a
>>>>>> joinable thread if you do not want to join it once it has been canceled?
>>>>>>
>>>>> Keep in mind that there is no pthread_cancel equivalent in the native
>>>>> API. Moreover, even POSIX has pthread_detach so that you are not forced
>>>>> to join every joinable thread. I could imagine that one may want to use
>>>>> this fot error cleanups. But first of all this is about improving the
>>>>> API consistency and fault tolerance.
>>>> I have no strong opinion on that matter, but it looks to me like the
>>>> "joinable" stuff in the native API is made to look like the posix
>>>> equivalent, following the principle of least surprise. So, since posix
>>>> requires joining a thread after canceling, it should be necessary to
>>>> join a thread after deleting it.
>>> The problem is that there is no direct equivalent to rt_task_delete with
>>> pthread. What comes closest is pthread_cancel + pthread_detach (where
>>> required). Still, rt_task_delete is synchronous, pthread_cancel not.
>> rt_task_delete looks to me like really equivalent to pthread_cancel.
> 
> rt_task_delete was once designed to sweep a task object, not just to
> terminate its runnable context (thought that's hard - if not impossible
> - to maintain across process boundaries).
> 
> While you can join a canceled pthread, you can't do this reliably with a
> deleted task. It happened to work if you were already holding a (then
> outdated) handle. But, officially, the lifetime of a tasks ends when
> rt_task_delete returns. No service is supposed to accept any further
> requests regarding this object afterwards. Making rt_task_join an
> exception may raise confusion.
> 
>> I do not think rt_task_delete is supposed to be synchronous (it looks to
>> me it is not if you delete a thread running on another cpu than the
>> current one). And pthread_detach is not synchronous either. The only way
>> to wait for a thread deletion is to use pthread_join/rt_task_join.
>>
> 
> It is synchronous /wrt the validity of the task object which includes
> the schedulable part in kernel space. The carrier thread is in pthread
> hands, but Xenomai is out of the game when rt_task_delete returned.

Not being able to join a deleted task undermines seriously the utility
of rt_task_join... What is it useful for, then?


-- 
					    Gilles.

