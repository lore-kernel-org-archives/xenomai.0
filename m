Message-ID: <53676902.5050405@xenomai.org>
Date: Mon, 05 May 2014 12:33:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
In-Reply-To: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
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

On 05/04/2014 06:59 PM, Matthias Schneider wrote:
> Hi all,
>
> please find enclosed a patch with a FreeRTOS skin for xenomai-forge I have
> been  working on for some time. I would like to get some feedback and advice
> what still needs to be done to get it accepted in Xenomai. There is a set of
> unit tests included and the possibility to download the original FreeRTOS package
> in order to run most of its (platform independent) test suite. Until now I have
> been working under mercury only. Documentation is available in form of a README
> file in lib/freertos/README, which should also be a good starting point.

Ok, thanks for this. Let's address issues gradually, starting with the 
task module.

I'd suggest to revisit the following mechanisms to get our feet wet: 
vTaskStartScheduler()/vTaskEndScheduler() and 
vTaskSuspendAll()/vTaskResumeAll().

- synchronizing on scheduler start/stop events can be made simpler, by 
waiting on a barrier after threadobj_wait_start() has returned in the 
task trampoline, meanwhile starting all tasks copperplate-wise at 
creation time via threadobj_start(). Such additional barrier should be a 
condition variable protected by your current scheduler.lock mutex, 
signaled by vTaskStartScheduler(). Tasks would have to check for the 
scheduler state before breaking the wait loop.

- assuming that threadobj_cancel() already waits for the canceled thread 
to finalize, you should only need to change the scheduler object state 
in vTaskEndScheduler() prior to cancelling all tasks. You should not 
need the extra syncobj.

- vTaskSuspendAll()/vTaskResumeAll() maintain useless status flags. 
Copperplate provides __THREAD_S_SUSPENDED in the core status of threads 
for the very same purpose.

The other set of issues is all about locking is managed. A couple of hints:

- vPortEnterCritical()/vPortExitCritical() can't be emulated since we 
can't mask IRQs in userland (and we certainly don't want to even try 
doing so). This would be a RTDM driver's business in the Xenomai model. 
Looking at the FreeRTOS doc, the closest approximation would be 
threadobj_sched_lock() in userland, but since hardware drivers should 
move to kernel space over RTDM, I'm unsure emulating these calls has any 
benefit in our context.

- threadobj_sched_lock() does not prevent the caller from scheduling
out, it only stops involuntary preemption when running non-blocking 
code. Typically, locking a mutex is potentially blocking code, so the 
guarantee disappears in that case. IIUC, the current code assumes more 
than this. Moreover, issuing a sleeping call voluntarily when holding 
this lock is logically wrong, even if Xenomai won't jump over the window 
doing so, unlike many RTOS vTaskStartScheduler()).

- the read/write_lock_nocancel() form is reserved for protecting 
sections which are known not to traverse cancellation points, as defined 
by POSIX 
(http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_09.html). 
This is about self-documentation of the code, and optimizing execution 
by omitting costly management of cleanup blocks when it is deemed safe 
to do so.

- CANCEL_DEFER() / CANCEL_RESTORE() should protect sections against 
asynchronous cancellation, we typically do this before invoking the 
copperplate layer, so that we may assume that pthread_cancel() won't be 
a problem when running inner code, provided we have been careful about 
handling read/write lock cleanups. These macros work by disabling 
asynchronous cancellation for the current thread when 
--enable-async-cancel was given at build time. Otherwise, this part is a 
nop.

- Scheduler.queued_task, .state and .num_tasks all seem logically 
related. So .num_tasks should be updated holding Scheduler.lock, instead 
of using an atomic type. We'd need to issue smp_rmb() prior to reading 
that counter locklessly.

HTH,

-- 
Philippe.

