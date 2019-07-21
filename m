Subject: Re: rt_mutex_acquire() does not return EINTR upon rt_task_unblock()
References: <CAFLxGvw7QBucCM47XXq2RJe1YtQ_wuGVrNg8ZPkUSmXYB04HHg@mail.gmail.com>
 <5059c077-395b-6d84-18e5-618de941c64f@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <81ec6d6d-fb0c-b6d4-fce0-a79263289b6c@xenomai.org>
Date: Sun, 21 Jul 2019 17:42:41 +0200
MIME-Version: 1.0
In-Reply-To: <5059c077-395b-6d84-18e5-618de941c64f@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 7/16/19 2:46 AM, Jan Kiszka wrote:
> On 15.07.19 23:30, Richard Weinberger via Xenomai wrote:
>> Hi!
>>
>> Sorry for asking so many questions on RT_MUTEX.
>>
>> Docs on rt_mutex_acquire variants state:
>> -EINTR is returned if rt_task_unblock() was called for the current task.
>>
>> This does not seems to be the case, pthread_mutex_lock() in lib/cobalt/mutex.c
>> does:
>>         do
>>                 ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
>>         while (ret == -EINTR);
>>
>> So, upon rt_task_unblock() the while loop does one more iteration but
>> blocks again
>> and the function will never return with -EINTR.
> 
> Apparently, we lost that property when porting alchemy over the cobalt core. I'd
> first like to understand if that was accidental or intentional - Philippe?
> 

That was kind of required, since the whole API was rebased on a
POSIX-compliant layer, which imposes this behavior per the standard.

A non-portable escape way could be implemented by adding a dedicated
XNUNBLOCK information flag that could be tested directly from the
user_window. That bit would be set by xnthread_unblock(). If present,
the loop above would be stopped.

>From a user POV, kicking a thread out of pthread_mutex_lock() would
amount to sending it the SIGRELS pseudo-signal via pthread_kill(), which
rt_task_unblock() already does under the hood.

-- 
Philippe.

