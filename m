Message-ID: <4B4DDB2F.40307@domain.hid>
Date: Wed, 13 Jan 2010 15:39:43 +0100
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
To: Jan Kiszka <jan.kiszka@domain.hid>
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
> 
>>>>  	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
>>>>  }
>>>>  
>>>> @@ -464,6 +464,15 @@ static void forked_child_init(void)
>>>>  	struct print_buffer *my_buffer = pthread_getspecific(buffer_key);
>>>>  	struct print_buffer **pbuffer = &first_buffer;
>>>>  
>>>> +	if (my_buffer) {
>>>> +		/* Any content of my_buffer should be printed by our parent,
>>>> +		   not us. */
>>>> +		memset(my_buffer->ring, 0, my_buffer->size);
>>>> +
>>>> +		my_buffer->read_pos  = 0;
>>>> +		my_buffer->write_pos = 0;
>>>> +	}
>>>> +
>>> Ack.
>>>
>>>>  	/* re-init to avoid finding it locked by some parent thread */
>>>>  	pthread_mutex_init(&buffer_lock, NULL);
>>>>  
>>>> @@ -518,3 +527,13 @@ void __rt_print_init(void)
>>>>  	spawn_printer_thread();
>>>>  	pthread_atfork(NULL, NULL, forked_child_init);
>>>>  }
>>>> +
>>>> +void __rt_print_exit(void)
>>>> +{
>>>> +	if (buffers) {
>>>> +		/* Flush the buffers. Do not call print_buffers here
>>>> +		 * since we do not know if our stack is big enough. */
>>>> +		nanosleep(&print_period, NULL);
>>>> +		nanosleep(&print_period, NULL);
>>>> +	}
>>>> +}
>>> IIRC, that's what cleanup_buffer is supposed to do, triggered by the
>>> pthread key destruction. Can you explain why it failed in your scenario.
>> pthread_key destruction is called when a thread is cancelled. My
>> testcase was calling exit.
> 
> exit() does not trigger these cleanup hooks? Too bad.
> 
>> Besides, cleanup_buffer flushes the buffers
>> from the context of the calling thread, which is a bad idea, due to the
>> stack sizes situation.
> 
> If a thread requesting rt_printk services is not capable of performing
> this work during it's cleanup, when there is no significant stack load,
> I would say it's misconfigured /wrt stack size.

Do you agree with this rebased patch?

diff --git a/src/rtdk/init.c b/src/rtdk/init.c
index 2084c73..b864175 100644
--- a/src/rtdk/init.c
+++ b/src/rtdk/init.c
@@ -22,3 +22,8 @@ static __attribute__ ((constructor)) void __init_rtdk(void)
 {
 	__rt_print_init();
 }
+
+static __attribute__ ((destructor)) void __exit_rtdk(void)
+{
+	__rt_print_exit();
+}
diff --git a/src/rtdk/internal.h b/src/rtdk/internal.h
index bd15b2d..345d4fa 100644
--- a/src/rtdk/internal.h
+++ b/src/rtdk/internal.h
@@ -23,6 +23,7 @@
 #include <sys/time.h>
 
 void __rt_print_init(void);
+void __rt_print_exit(void);
 
 void __real_free(void *ptr);
 void *__real_malloc(size_t size);
diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 1d2b70a..fc170d0 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -29,6 +29,7 @@
 
 #include <rtdk.h>
 #include <asm/xenomai/system.h>
+#include <asm-generic/stacksize.h>
 
 #define RT_PRINT_BUFFER_ENV		"RT_PRINT_BUFFER"
 #define RT_PRINT_DEFAULT_BUFFER		16*1024
@@ -464,6 +465,15 @@ static void forked_child_init(void)
 	struct print_buffer *my_buffer = pthread_getspecific(buffer_key);
 	struct print_buffer **pbuffer = &first_buffer;
 
+	if (my_buffer) {
+		/* Any content of my_buffer should be printed by our parent,
+		   not us. */
+		memset(my_buffer->ring, 0, my_buffer->size);
+
+		my_buffer->read_pos  = 0;
+		my_buffer->write_pos = 0;
+	}
+
 	/* re-init to avoid finding it locked by some parent thread */
 	pthread_mutex_init(&buffer_lock, NULL);
 
@@ -518,3 +528,13 @@ void __rt_print_init(void)
 	spawn_printer_thread();
 	pthread_atfork(NULL, NULL, forked_child_init);
 }
+
+void __rt_print_exit(void)
+{
+	if (buffers) {
+		/* Flush the buffers. Do not call print_buffers here
+		 * since we do not know if our stack is big enough. */
+		nanosleep(&print_period, NULL);
+		nanosleep(&print_period, NULL);
+	}
+}

-- 
					    Gilles.

