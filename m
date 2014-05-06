Message-ID: <5369201B.1080108@xenomai.org>
Date: Tue, 06 May 2014 19:47:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
 <1399396759.65313.YahooMailNeo@web171604.mail.ir2.yahoo.com>
In-Reply-To: <1399396759.65313.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/06/2014 07:19 PM, Matthias Schneider wrote:
>
> Are you referring to freertos_scheduler.sem? It is used to blocke the
> main thread while the "scheduer" is running. Even when moving the task
> cancellation loop to inside the vTaskEndScheduler(), vTaskStartScheduler()
> would still need to block until vTaskEndScheduler() is a
>

I mean you don't need a syncobj. This is overly complex for the purpose, 
you can use a sem_t. syncobj implements extended semantics we commonly 
find in RTOS, which are not available with regular POSIX ipc. But in 
this case, we don't need them: we just need to wait for a pulse, once.

>> - vTaskSuspendAll()/vTaskResumeAll() maintain useless status flags.
>> Copperplate provides __THREAD_S_SUSPENDED in the core status of threads
>> for the very same purpose.
>
> This is not entirely correct. Consider the following case (part of the demo
> actually):
>
> vTaskSuspendAll();
> vTaskSuspend(th1);
> vTaskResumeAll();
>
> This is supposed to leave th1 suspended after vTaskResumeAll(). This
> information needs to be stored somewhere. After vTaskSuspendAll(), all
> except the current thread have __THREAD_S_SUSPENDED set, so another way to
> store this informaion is needed. I have also experimented modelling these
> functions using threadobj_sched_lock() & co., however, even on UP machines
> the following code would not behave as supposed:
>
> vTaskSuspendAll();
> vTaskDelay(xGetTicksPerSecond() * 0.01);
> vTaskResumeAll();
>
> Obviously, during vTaskDelay() other tasks of lower than "sched" prio may
> be executed.

vTaskSuspendAll() very much looks like plain scheduler lock, preventing 
the caller from scheduling out on preemption. If so, then the whole 
issue disappears, there would not be any cumulative blocking states.

>
>> The other set of issues is all about locking is managed. A couple of hints:
>>
>> - vPortEnterCritical()/vPortExitCritical() can't be emulated since we
>> can't mask IRQs in userland (and we certainly don't want to even try
>> doing so). This would be a RTDM driver's business in the Xenomai model.
>> Looking at the FreeRTOS doc, the closest approximation would be
>> threadobj_sched_lock() in userland, but since hardware drivers should
>> move to kernel space over RTDM, I'm unsure emulating these calls has any
>> benefit in our context.
>
> Correct. I though I had seen use of it in the plateform-independent demo
> previously, but apparently I remember incorrectly. Defining them as empty
> functions thus.
>

I would rather not define them, to make sure the user knows about the 
issue when the compiler complains about it. Silently ignoring a hard 
critical section is unlikely to help.

-- 
Philippe.

