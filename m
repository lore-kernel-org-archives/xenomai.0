Message-ID: <49E4BFB7.50702@domain.hid>
Date: Tue, 14 Apr 2009 18:54:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49E4B5CC.1050902@domain.hid> <49E4B84A.9040805@domain.hid>
	<49E4BA8A.8070207@domain.hid> <49E4BD20.4030008@domain.hid>
	<49E4BEBD.90904@domain.hid>
In-Reply-To: <49E4BEBD.90904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] posix: Avoid double declarations
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Please pull from git://git.xenomai.org/xenomai-jki.git for-upstream
>>>>> and run bootstrap.
>>>>>
>>>>> ---------->
>>>>>
>>>>> Recent glibc versions come with support for
>>>>> pthread_mutexattr_get/setprotocol and pthread_condattr_get/setclock.
>>>>> Make sure we don't declare those prototypes in Xenomai's pthread.h a
>>>>> second time as this can cause g++ warnings and even errors.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>>> ---
>>>>>
>>>>>  configure.in            |    4 ++--
>>>>>  include/posix/pthread.h |    4 ++++
>>>>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/configure.in b/configure.in
>>>>> index b291ce4..6a8b821 100644
>>>>> --- a/configure.in
>>>>> +++ b/configure.in
>>>>> @@ -750,8 +750,8 @@ if test x$CONFIG_XENO_POSIX_UITRON_MLOCKALL = xy; then
>>>>>  fi
>>>>>  
>>>>>  save_LIBS="$LIBS"
>>>>> -LIBS="$LIBS -lrt"
>>>>> -AC_CHECK_FUNCS([shm_open shm_unlink mmap64 ftruncate64])
>>>>> +LIBS="$LIBS -lrt -lpthread"
>>>>> +AC_CHECK_FUNCS([shm_open shm_unlink mmap64 ftruncate64 pthread_mutexattr_setprotocol pthread_condattr_setclock])
>>>>>  LIBS="$save_LIBS"
>>>>>  
>>>>>  AC_MSG_CHECKING(whether to enable dlopen support for skin libraries)
>>>>> diff --git a/include/posix/pthread.h b/include/posix/pthread.h
>>>>> index 2344158..98db325 100644
>>>>> --- a/include/posix/pthread.h
>>>>> +++ b/include/posix/pthread.h
>>>>> @@ -418,17 +418,21 @@ int pthread_intr_control_np(pthread_intr_t intr,
>>>>>  extern "C" {
>>>>>  #endif
>>>>>  
>>>>> +#ifndef HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
>>>>>  int pthread_mutexattr_getprotocol(const pthread_mutexattr_t *attr,
>>>>>  				  int *proto);
>>>>>  
>>>>>  int pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr,
>>>>>  				  int proto);
>>>>> +#endif
>>>> That is not enough, if these functions are defined, then the
>>>> PTHREAD_PRIO_NONE, PTHREAD_PRIO_INHERIT, PTHREAD_PRIO_PROTECT are going
>>>> to be defined.
>>>>
>>>> Are you sure that the missing "restrict" are not causing the errors ?
>>> This is enough to fix our build breakage due to different prototypes of
>>> those functions, at least under C++. The magic __THROW may make the
>>> difference, but I didn't test that in details as I think its simply
>>> fragile to redeclare them.
>>>
>>> Don't know if those constants can cause trouble, they didn't do so here
>>> so far. But I can Include them if preferred.
>> If it works, it is just as fragile as trying to match function
>> declarations of Xenomai's pthread.h and glibc's pthread.h.
> 
> Nope, because you don't repeat function attributes for their
> definitions. So Xenomai's pthread lib should pick up what the host
> header declares.

Currently, PTHREAD_PRIO_NONE, PTHREAD_PRIO_INHERIT and
PTHREAD_PRIO_PROTECT are defined in Xenomai's header unconditionnaly.
You see no warning or error because they are defined in an enum in
glibc. But this is a fragile situation.

-- 
                                                 Gilles.

