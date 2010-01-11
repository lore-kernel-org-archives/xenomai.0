Message-ID: <4B4B0458.9000403@domain.hid>
Date: Mon, 11 Jan 2010 11:58:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1262955043-5304-1-git-send-email-gilles.chanteperdrix@xenomai.org>	<4B4ADB17.4070905@domain.hid>
	<4B4ADEE2.9070000@domain.hid> <4B4AE4AB.8010905@domain.hid>
In-Reply-To: <4B4AE4AB.8010905@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/1] rtdk: various fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> When exiting a process, rtdk buffers are not flushed. Fix that by
>>>> introducing a destructor for the library which flushes the buffers.
>>>>
>>>> When forking, if the main thread has an rt_printf buffer, it is reused by
>>>> the child, which is a good thing, however, it is not emptied, so could cause
>>>> the same message to be printed twice. Fix that by emptying the main thread
>>>> buffer upon fork.
>>>>
>>>> When spawning the rt_print thread, it uses a stack size of
>>>> PTHREAD_STACK_MIN, which may be too small for printf to work reliably on
>>>> some architectures, set the stack size to the
>>>> empirically-known-to-be-working size of... 32Kb.
>>>> ---
>>>>  src/rtdk/init.c     |    5 +++++
>>>>  src/rtdk/internal.h |    1 +
>>>>  src/rtdk/rt_print.c |   21 ++++++++++++++++++++-
>>>>  3 files changed, 26 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/src/rtdk/init.c b/src/rtdk/init.c
>>>> index 2084c73..b864175 100644
>>>> --- a/src/rtdk/init.c
>>>> +++ b/src/rtdk/init.c
>>>> @@ -22,3 +22,8 @@ static __attribute__ ((constructor)) void __init_rtdk(void)
>>>>  {
>>>>  	__rt_print_init();
>>>>  }
>>>> +
>>>> +static __attribute__ ((destructor)) void __exit_rtdk(void)
>>>> +{
>>>> +	__rt_print_exit();
>>>> +}
>>>> diff --git a/src/rtdk/internal.h b/src/rtdk/internal.h
>>>> index bd15b2d..345d4fa 100644
>>>> --- a/src/rtdk/internal.h
>>>> +++ b/src/rtdk/internal.h
>>>> @@ -23,6 +23,7 @@
>>>>  #include <sys/time.h>
>>>>  
>>>>  void __rt_print_init(void);
>>>> +void __rt_print_exit(void);
>>>>  
>>>>  void __real_free(void *ptr);
>>>>  void *__real_malloc(size_t size);
>>>> diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
>>>> index c6b5c55..dae7d7b 100644
>>>> --- a/src/rtdk/rt_print.c
>>>> +++ b/src/rtdk/rt_print.c
>>>> @@ -455,7 +455,7 @@ static void spawn_printer_thread(void)
>>>>  	pthread_attr_t thattr;
>>>>  
>>>>  	pthread_attr_init(&thattr);
>>>> -	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
>>>> +	pthread_attr_setstacksize(&thattr, 32768);
>>> Mmh... maybe rather $something +PTHREAD_STACK_MIN?
>> No, PTHREAD_STACK_MIN sucks, it is not appropriate, and have very
>> varying values on different platforms. On some plaforms, with some
>> versions of glibc, it is 4096, way too small, so that printf generates a
>> segfault due to a stack overflow.
>>
>> However, due to the work done when solving the stack issue reported by
>> Stefan, I hid the magic constants in a function called xeno_stacksize
>> and xeno_stacksize(0) gives a reasonnable default value.
> 
> OK, then go for this service (is it already merged)?

it is pending, was waiting for Stefan confirmation that it fixed his
issue, should be pushed soon.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

