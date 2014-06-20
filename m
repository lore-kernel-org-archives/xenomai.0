Message-ID: <53A3E8FE.5020005@xenomai.org>
Date: Fri, 20 Jun 2014 09:55:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
In-Reply-To: <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin #2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/02/2014 08:46 PM, Matthias Schneider wrote:

> Please find enclosed a new version of the FreeRTOS skin. It adapts to the
> latest changes in forge/next and also removes the previously included
> workarounds - thanks to the changes done based on the first review round
> they were no longer necessary.
>

Thanks. Here we go:

* vTaskStartScheduler()

Dropping the task_list lock then yielding is superfluous, the caller 
will wait on the condvar for the scheduler state to switch to SUSPENDING 
anyway, implicitly releasing this lock before going to sleep.

* vTaskDelay()

Cobalt wraps sched_yield(), so you likely want to call 
__RT(sched_yield()) to pick the proper implementation depending on the 
underlying real-time core.

* __xTaskGenericCreate()

- It looks like the mutex attribute initialized locally is a left over 
from a previous implementation.

- Drawing unique identifier labels should be done using a name 
generator, e.g.

static DEFINE_NAME_GENERATOR(task_namegen, struct freertos_task, name);
...
	generate_name(task->name, name, &task_namegen);

The open-coded method also used by other emulators is racy.

* vPortEnter/ExitCritical()

- wouldn't these calls better emulated by threadobj_lock_sched() 
assuming they stand for a global serialization mechanism?

* Task registry support

The code looks outdated, using fsobstacks is recommended. The registry 
helpers in lib/alchemy/alarm.c illustrate a basic usage.

* vTaskSuspendAll()

Running check_processors() there may switch the caller to linux mode
at each invocation, due to calling sysconf/sched_getaffinity indirectly. 
I would rather assume that the CPU affinity is not allowed to change 
once started, and determine whether a task is bound to more than a 
single CPU in the trampoline code. Then vTaskSuspendAll() may do a 
simple flag-based test for checking the consistency, still allowing 
different freertos tasks to be pinned on distinct CPUs though. At any 
rate, this would be an acceptable restriction, since freertos does not 
seem to be SMP-capable in its reference implementation anyway.

Next time, I'll start reviewing other parts of the emulator.

HTH,

-- 
Philippe.

