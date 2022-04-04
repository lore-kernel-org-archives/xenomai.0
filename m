Message-ID: <1018f867-d9a7-4c0a-a6ee-6b9a5d457c0a@siemens.com>
Date: Mon, 4 Apr 2022 14:34:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Content-Language: en-US
References: <20220330201614.31083-1-richard@nod.at>
 <70be73c4-2b97-7a92-014d-5655a489a0b2@siemens.com>
 <169724307.214985.1649074667197.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <169724307.214985.1649074667197.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@xenomai.org>

On 04.04.22 14:17, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> An: "richard" <richard@nod.at>, "xenomai" <xenomai@xenomai.org>
>> Gesendet: Montag, 4. April 2022 13:21:45
>> Betreff: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX
> 
>> On 30.03.22 22:16, Richard Weinberger via Xenomai wrote:
>>> Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
>>> implementation.
>>> POSIX requires that pthread_mutex_lock() shall not return EINTR,
>>> this requirement breaks rt_task_unblock() if a RT_TASK blocks on
>>> a RT_MUTEX.
>>>
>>> To restore the functionality provide a new function,
>>> pthread_mutex_lock_eintr_np().
>>> It can get interrupted and will return EINTR to the caller.
>>>
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>  include/cobalt/pthread.h |  2 ++
>>>  lib/alchemy/mutex.c      |  2 +-
>>>  lib/cobalt/mutex.c       | 14 ++++++++++++--
>>>  3 files changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
>>> index 3e9bd47053bc..2994c2467219 100644
>>> --- a/include/cobalt/pthread.h
>>> +++ b/include/cobalt/pthread.h
>>> @@ -62,6 +62,8 @@ COBALT_DECL(int, pthread_mutex_destroy(pthread_mutex_t
>>> *mutex));
>>>  
>>>  COBALT_DECL(int, pthread_mutex_lock(pthread_mutex_t *mutex));
>>>  
>>> +COBALT_DECL(int, pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex));
>>> +
>>>  COBALT_DECL(int, pthread_mutex_timedlock(pthread_mutex_t *mutex,
>>>  					 const struct timespec *to));
>>>  
>>> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
>>> index f8933858647a..bb97395142aa 100644
>>> --- a/lib/alchemy/mutex.c
>>> +++ b/lib/alchemy/mutex.c
>>> @@ -327,7 +327,7 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>>>  
>>>  	/* Slow path. */
>>>  	if (abs_timeout == NULL) {
>>> -		ret = -__RT(pthread_mutex_lock(&mcb->lock));
>>> +		ret = -__RT(pthread_mutex_lock_eintr_np(&mcb->lock));
>>
>> This won't build for mercury, will it?
> 
> Uff yes. Just tried building with --with-core=mercury and it failed. ;-\
> 
> So, when mercury is enabled, alchemy will use NPTL.
> This means rt_task_unblock() cannot work on mercury because
> pthread_mutex_lock() will not return EINTR either.
> 
> Fixing the build for mercury should be easy by adding an ifdef CONFIG_XENO_MERCURY.
> But I'm not sure how to fix unblocking for the mercury case.

Either by ignoring that case on mercury (it has not predecessor in
Xenomai 2, and it can't be fixed via posix means) or by redefining the
behavior for everyone, i.e. by exempting rt_mutex_acquire* from
rt_task_unblock.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

