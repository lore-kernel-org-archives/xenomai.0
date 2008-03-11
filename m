Message-ID: <47D6E7D8.90908@domain.hid>
Date: Tue, 11 Mar 2008 21:13:12 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47D6CD29.4020700@domain.hid>	<2ff1a98a0803111127p7868350axa976c68714cf4f05@domain.hid>
	<47D6DD05.2040007@domain.hid>
In-Reply-To: <47D6DD05.2040007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] What have I misunderstood about
	condition	variables
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Anders Blomdell wrote:
> Gilles Chanteperdrix wrote:
>> On Tue, Mar 11, 2008 at 7:19 PM, Anders Blomdell
>>>  To me the symptoms indicate that the high priority producer gets the mutex and
>>>  signals it before the consumer has properly started to wait on the condition.
>> I have not read your program in detail, but what may be your problem
>> is that condition variables are not semaphores: if you signal a
>> condition variable when nobody is waiting the signal is lost. 
> I know this, but the problem is that the program loses signals when it is
> waiting. In the consumer:
> 
>     rt_mutex_acquire(&mutex, TM_INFINITE);
>     rt_printf("a");
>     rt_task_sleep(1000000000L);
>     rt_printf("b");
>     err = rt_cond_wait(&cond, &mutex, TM_INFINITE);
>     rt_printf("c");
>     rt_mutex_release(&mutex);
>     rt_printf("d %d\n", data);
> 
> i.e. after a 'b' has been written, the consumer is waiting on the condition
> (Yes, I know that I access data outside the mutex...).
> 
> In the producer:
> 
>     rt_printf("B");
>     data++;
>     rt_mutex_release(&mutex);
>     rt_mutex_acquire(&mutex, TM_INFINITE);
>     rt_cond_broadcast(&cond);
>     rt_printf("C");
>     rt_mutex_release(&mutex);
>     rt_task_sleep(100000000L);
> 
> i.e. the condition is signalled just before 'C' is written.
> 
> To elaborate on the [unexpected] output sequence:
> 
>      a		(consumer inside mutex)
>      A		(producer about to enter mutex)
>      b          (consumer starts waiting on condition)
>      B          (producer has entered mutex)
>      C          (producer has signalled condition)
>      ...here I would have expected the consumer to resume...
>      A          (producer has slept for 1 second, outside mutex)
>      B          (producer has entered mutex)
>      C          (producer has signalled condition)
>      c          (consumer has got the second signal on condition)
>      d		(consumer has left mutex)
> 
> 
> 
>> condition variable is supposed to be associated with a condition
>> relying on variable external to the condition variables itself.
> Yes I know all this, but the problem is that a high priority thread waiting for
> the mutex, claims the mutex and signals the condition before the low priority
> thread has started to wait for the condition (even ).
> 
>> ...
>> Note the while loop, instead of a simple if, it is necessary to handle
>> correctly spurious wakeups.
> My problem is the opposite, I don't get the wakeups :-(
> 
> The following program is more like my original problem (which was tricky to
> isolate):
> 
> #include <native/cond.h>
> #include <native/mutex.h>
> #include <native/task.h>
> #include <native/timer.h>
> #include <rtdk.h>
> #include <sys/mman.h>
> 
> RT_TASK main_task, producer_task, consumer_task;
> RT_MUTEX mutex;
> RT_COND cond;
> int waiting, signalled;
> 
> static void producer(void *arg)
> {
>   while(1) {
>     rt_task_set_mode(0, T_PRIMARY, 0);
> 
>     rt_printf("Producer sleep...\n");
>     rt_task_sleep(1000000000L);
>     rt_printf("...producer slept\n");
> 
>     rt_mutex_acquire(&mutex, TM_INFINITE);
>     rt_printf("Producer has entered waiting=%d, signalled=%d\n",
> 	      waiting, signalled);
>     if (waiting && !signalled) {
>       rt_cond_broadcast(&cond);
>       signalled = 1;
>       rt_printf("  sent signal\n");
>     }
>     rt_mutex_release(&mutex);
>   }
> }
> 
> 
> static void consumer(void *arg)
> {
>   while(1) {
>     int err;
> 
>     rt_task_set_mode(T_PRIMARY, 0, 0);
>     rt_mutex_acquire(&mutex, TM_INFINITE);
>     rt_task_sleep(1000000000L);
>     waiting = 1;
>     signalled = 0;
>     rt_printf("Consumer about to wait waiting=%d, signalled=%d\n",
> 	      waiting, signalled);
>     err = rt_cond_wait(&cond, &mutex, 2000000000L);
>     if (err != 0 && signalled) {
>       rt_printf("Consumer not awoken err=%d, signalled=%d\n",
> 		err, signalled);
>     } else {
>       rt_printf("Consumer awoken\n");
>     }
>     rt_mutex_release(&mutex);
>   }
> }
> 
> 
> int main(int argc, char *argv[])
> {
>   mlockall(MCL_CURRENT|MCL_FUTURE);
>   rt_print_auto_init(1);
>   rt_task_shadow(&main_task, NULL, 1, T_FPU);
>   rt_mutex_create(&mutex, NULL);
>   rt_cond_create (&cond, NULL);
>   rt_task_create(&producer_task, NULL, 0, 50, 0);
>   rt_task_start(&producer_task, &producer, NULL);
>   rt_task_create(&consumer_task, NULL, 0, 20, 0);
>   rt_task_start(&consumer_task, &consumer, &consumer_task);
>   while (1) {
>     rt_task_sleep(1000000000L);
>   }
>   return 0;
> }
> 
> And here I get the output:
> 
> Producer sleep...
> ...producer slept
> Consumer about to wait waiting=1, signalled=0
> Producer has entered waiting=1, signalled=0
>   sent signal
> Producer sleep...
> ...producer slept
> Producer has entered waiting=1, signalled=1
> Producer sleep...
> Consumer not awoken err=-110, signalled=1
> ...producer slept
> Producer has entered waiting=1, signalled=1
> Producer sleep...
> ...producer slept
> Consumer about to wait waiting=1, signalled=0
> Producer has entered waiting=1, signalled=0
>   sent signal
> Producer sleep...
> ...producer slept
> Producer has entered waiting=1, signalled=1
> Producer sleep...
> Consumer not awoken err=-110, signalled=1
> ...producer slept
> Producer has entered waiting=1, signalled=1
> Producer sleep...
> 
> What am I missing?
OK, found the bug (not mine!). I suggest something like this:

--- ksrc/skins/native/cond.c.orig       2008-03-11 20:42:52.000000000 +0100
+++ ksrc/skins/native/cond.c    2008-03-11 21:00:10.000000000 +0100
@@ -438,13 +438,20 @@

 int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 {
-       int err, kicked = 0;
+       /* We can't use rt_mutex_release since that might reschedule
+          before we do our xnsynch_sleep_on, hence most of of the code
+          is duplicated here */
+       int err = 0, kicked = 0;
        xnthread_t *thread;
        spl_t s;
+       int lockcnt;

        if (timeout == TM_NONBLOCK)
                return -EWOULDBLOCK;

+       if (xnpod_unblockable_p())
+               return -EPERM;
+
        xnlock_get_irqsave(&nklock, s);

        cond = xeno_h2obj_validate(cond, XENO_COND_MAGIC, RT_COND);
@@ -454,10 +461,26 @@
                goto unlock_and_exit;
        }

-       err = rt_mutex_release(mutex);
+       mutex = xeno_h2obj_validate(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);

-       if (err)
+       if (!mutex) {
+               err = xeno_handle_error(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
+               goto unlock_and_exit;
+       }
+
+       if (xnpod_current_thread() != xnsynch_owner(&mutex->synch_base)) {
+               err = -EPERM;
                goto unlock_and_exit;
+       }
+
+       lockcnt = mutex->lockcnt; /* Leave even if mutex is nested */
+
+       mutex->lockcnt = 0;
+
+       if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
+               mutex->lockcnt = 1;
+               /* Scheduling deferred */
+       }

        thread = xnpod_current_thread();

@@ -474,6 +497,8 @@

        rt_mutex_acquire(mutex, TM_INFINITE);

+       mutex->lockcnt = lockcnt; /* Adjust lockcnt */
+
        if (kicked)
                xnthread_set_info(thread, XNKICKED);




-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

