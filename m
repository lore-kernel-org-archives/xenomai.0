Message-ID: <4DB96C9C.9000005@domain.hid>
Date: Thu, 28 Apr 2011 15:33:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <31508283.431303994486968.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <31508283.431303994486968.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_join() call hangs in shared lib
	destructor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
>> Gilles Chanteperdrix wrote:
>>> Mauro Salvini wrote:
>>>>> It looks like a typical pthread_join deadlock. The thread you
>>>>> are joining is locked on a pthread mutex, that some other
>>>>> thread (I would say, the one calling pthread_join) has. It
>>>>> can not work. You should not call pthread_join while holding
>>>>> a mutex.
>>>> Yes, it looks like this, but I don't use any mutex in my task.
>>>> It looks like dlclose() locks a mutex used also by
>>>> pthread_join() (that was called into shared object destructor),
>>>> and here is deadlock. But executing realtime task as normal
>>>> thread does not raise this issue.
>>> The trace you sent clearly shows that the problem happens because
>>>  rt_task_trampoline calls pthread_exit. In your tests with 
>>> rt_task_shadow/pthread_create, did you try to use pthread_exit?
>>> Or could you try replacing the call to pthread_exit in
>>> rt_task_trampoline with a return?
>> Answering to myself: no, in your examples you did not use
>> pthread_exit, that is the difference with the rt_task_create case.
>> 
>> 
>> So, could you try the following patch?
>> 
>> diff --git a/src/skins/native/task.c b/src/skins/native/task.c 
>> index be4ea2c..70ba6f7 100644 --- a/src/skins/native/task.c +++
>> b/src/skins/native/task.c @@ -113,7 +113,7 @@ static void
>> *rt_task_trampoline(void *cookie)
>> 
>> fail:
>> 
>> - pthread_exit((void *)err); + return (void *)err; }
>> 
>> int rt_task_create(RT_TASK *task,
>> 
>> 
> 
> Yes, patch works: rt_task_join works correctly now.
> 
> By the way, before apply patch, as you suggest in your penultimate
> mail, I tried to use pthread_exit in tests with
> rt_task_shadow/pthread_create: application hangs as with
> rt_task_create().
> 
> So, I deduce that pthread_exit must not be called into shared object
> threads/tasks, to avoid joining hangs when object destructor was
> called. Is this a libc bug or is the normal way of coding?
> 
> Thank you very much Gilles for your precious help! Regards

It definitely has nothing to do with Xenomai, whether this is a glibc
bug or not, only glibc maintainers can answer.

But the workaround is easy, just create a function to shutdown the
thread in the .so object. And call this function before dlclose.

-- 
					    Gilles.

