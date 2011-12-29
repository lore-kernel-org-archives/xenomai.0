Message-ID: <4EFC4E21.3000804@domain.hid>
Date: Thu, 29 Dec 2011 12:25:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EF27CD5.4060603@domain.hid>
	<4EF8FBB6.4060107@domain.hid> <4EF8FD8D.2090306@domain.hid>
	<4EFB696E.8000508@domain.hid>
In-Reply-To: <4EFB696E.8000508@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrew Tannenbaum <trb@domain.hid>
Cc: xenomai@xenomai.org

On 12/28/2011 08:09 PM, Andrew Tannenbaum wrote:
> On 12/26/2011 06:04 PM, Gilles Chanteperdrix wrote:
>> On 12/26/2011 11:56 PM, Gilles Chanteperdrix wrote:
>>> On 12/22/2011 01:41 AM, Andrew Tannenbaum wrote:
>>>> Summary: I am having a problem running rtcansend/recv on Xenomai 2.6.0,
>>>> with the processes hanging in their cleanup code.
>>>>
>>>> I had been running Xenomai on an Intel Atom system with a PEAK PCI
>>>> SJA1000 CAN adapter.
>>>>
>>>> I was running Linux 2.5.35.7 with Xenomai 2.5.5.2.  I connected a servo
>>>> and motor to the PEAK adapter, and I was able to talk with it using
>>>> rtcansend and rtcanrecv.
>>>>
>>>> After working on other things for a few months, I need to return to this
>>>> project, so I downloaded the latest Linux/Xenomai pair, which I think is
>>>> Linux 2.5.38.8 and Xenomai 2.6.0.
>>>>
>>>> I was able to compile these (using the Debian build advice, generating
>>>> .deb files for Linux and Xenomai, which I install with dpkg -i).  I used
>>>> a Linux .config derived from my older build.
>>>>
>>>> With both the new and old installs, I am able to run xeno-test and get
>>>> decent latencies and such, though some of the tests fail depending on
>>>> what I have configured in Realtime/Drivers/Testing Drivers.  That is not
>>>> what I'm asking about.
>>>>
>>>>
>>>>
>>>> I am having a problem running rtcansend/recv on Xenomai 2.6.0:
>>>>
>>>> I can run rtcanconfig and it sets up my rtcan0 properly so I can see and
>>>> configure the servo.  The data in /proc/rtcan looks ok.
>>>>
>>>> But when I try to talk with the servo using rtcansend, the rtcansend
>>>> process fails during the close phase, it looks like this:
>>>>
>>>> $ rtcansend rtcan0 -v -i 0x0 0x82 0x1
>>>> interface rtcan0
>>>> s=0, ifr_name=rtcan0
>>>> <0x000> [2] 82 01
>>>> Cleaning up...
>>>> ^CSignal 2 received
>>>> Cleaning up...
>>>> $
>>>>
>>>> So it hangs after the first "Cleaning up..." and I hit Control-C and
>>>> then it catches the ^C and exits.  The code at the bottom of
>>>
>>> After various attempts, the bug happens when the main thread exits with
>>> pthread_exit while other threads exist in the process. It was already
>>> there in 2.5.6 at least, but we did not see it with rtcansend because
>>> there was no other thread than the main thread, while in 2.6.0, there is
>>> now the rt_print thread running.
>>>
>>
>> And it is in fact a linux/glibc behaviour. A test program compiled
>> without xenomai exhibits the same behaviour. Here is the test program,
>> simplified to the max:
>>
>> #include <pthread.h>
>> #include <sys/mman.h>
>> #include <time.h>
>>
>> void *loop(void *cookie)
>> {
>> 	struct timespec ts;
>>
>> 	ts.tv_sec = 0;
>> 	ts.tv_nsec = 100000000;
>>
>> 	pthread_detach(pthread_self());
>>
>> 	for(;;)
>> 		nanosleep(&ts, NULL);
>> }
>>
>> int main(void)
>> {
>> 	pthread_t tid;
>>
>> 	mlockall(MCL_CURRENT | MCL_FUTURE);
>>
>> 	pthread_create(&tid, NULL, loop, NULL);
>>
>> 	pthread_exit(NULL);
>> }
>>
>> So, rtcansend should call exit.
>>
> 
> Gilles,
> 
> Thank you for your help, it explains and resolves my immediate needs.  I
> am not sure I understand the underlying problem, and I have more
> questions about it.
> 
> Re the new loose private rt_print pthread, I am not comfortable with the
> suggestion to call exit() explicitly (instead of pthread_exit() or
> rt_task_delete()).  Asking the user to call exit() instead of
> rt_task_delete() is not intuitive.
> 
> In your simple example case, a simple solution would be to call
> pthread_cancel(tid) before pthread_exit().  I understand that in a
> Xenomai program using rt_print, the user isn't really handling the
> rt_print thread.  If rt_task_delete() doesn't mean process exit, the
> question gets more difficult.
> 
> Can the rt_print pthread be cleaned up automatically?  atexit()?
> use-count in rt_task_delete()?  If not, should rt_print be started and
> stopped explicitly by the user?
> 
> I'm wondering about old programs that may hang when they are ported from
> Xenomai pre-2.6 to post-2.6.

Here is a patch which only spawns the rt_print thread if the user calls
rt_print_auto_init(1), or rt_print_init(). Then if you have called these
services, you are expected to call rt_print_cleanup() to cancel the
rt_print thread, before calling rt_task_delete().

diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
index c1849a5..5533e29 100644
--- a/src/skins/common/rt_print.c
+++ b/src/skins/common/rt_print.c
@@ -91,8 +91,11 @@ static unsigned pool_buf_size;
 static unsigned long pool_start, pool_len;
 #endif /* CONFIG_XENO_FASTSYNCH */

+static pthread_once_t init_once = PTHREAD_ONCE_INIT;
+
 static void cleanup_buffer(struct print_buffer *buffer);
 static void print_buffers(void);
+static void spawn_printer_thread(void);

 /* *** rt_print API *** */

@@ -344,6 +347,8 @@ int rt_print_init(size_t buffer_size, const char
*buffer_name)
 	unsigned long old_bitmap;
 	unsigned j;

+	pthread_once(&init_once, spawn_printer_thread);
+
 	if (!size)
 		size = default_buffer_size;
 	else if (size < RT_PRINT_LINE_BREAK)
@@ -415,6 +420,8 @@ int rt_print_init(size_t buffer_size, const char
*buffer_name)
 void rt_print_auto_init(int enable)
 {
 	auto_init = enable;
+	if (enable)
+		pthread_once(&init_once, spawn_printer_thread);
 }

 void rt_print_cleanup(void)
@@ -432,6 +439,7 @@ void rt_print_cleanup(void)
 	}

 	pthread_cancel(printer_thread);
+	printer_thread = 0;
 }

 const char *rt_print_buffer_name(void)
@@ -596,9 +604,16 @@ static void print_buffers(void)
 	}
 }

+static void unlock(void *cookie)
+{
+	pthread_mutex_t *mutex = (pthread_mutex_t *)cookie;
+	pthread_mutex_unlock(mutex);
+}
+
 static void *printer_loop(void *arg)
 {
 	while (1) {
+		pthread_cleanup_push(unlock, &buffer_lock);
 		pthread_mutex_lock(&buffer_lock);

 		while (buffers == 0)
@@ -606,7 +621,7 @@ static void *printer_loop(void *arg)

 		print_buffers();

-		pthread_mutex_unlock(&buffer_lock);
+		pthread_cleanup_pop(1);

 		nanosleep(&print_period, NULL);
 	}
@@ -620,6 +635,7 @@ static void spawn_printer_thread(void)

 	pthread_attr_init(&thattr);
 	pthread_attr_setstacksize(&thattr, xeno_stacksize(0));
+	pthread_attr_setdetachstate(&thattr, PTHREAD_CREATE_DETACHED);
 	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
 }

@@ -653,10 +669,11 @@ static void forked_child_init(void)
 			cleanup_buffer(*pbuffer);
 	}

-	spawn_printer_thread();
+	if (printer_thread)
+		spawn_printer_thread();
 }

-static __attribute__ ((constructor)) void __rt_print_init(void)
+static __attribute__((constructor)) void __rt_print_init(void)
 {
 	const char *value_str;
 	unsigned long long period;
@@ -752,7 +769,6 @@ static __attribute__ ((constructor)) void
__rt_print_init(void)

 	pthread_cond_init(&printer_wakeup, NULL);

-	spawn_printer_thread();
 	pthread_atfork(NULL, NULL, forked_child_init);
 }



> 
> -Andy
> 


-- 
                                                                Gilles.

