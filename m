References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Message-ID: <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Mon, 23 Jun 2014 21:27:42 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin #2
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----

> From: Matthias Schneider <ma30002000@yahoo.de>
> To: Philippe Gerum <rpm@xenomai.org>; "xenomai@xenomai.org" <xenomai@xeno=
mai.org>
> Cc: =

> Sent: Monday, June 23, 2014 12:31 PM
> Subject: Re: [Xenomai] FreeRTOS skin #2
> =

> ----- Original Message ----- =

>>  From: Philippe Gerum <rpm@xenomai.org> =

>>  To: Matthias Schneider <ma30002000@yahoo.de>; =

> "xenomai@xenomai.org" <xenomai@xenomai.org> =

>>  Cc: =

>>  Sent: Friday, June 20, 2014 9:55 AM =

>>  Subject: Re: [Xenomai] FreeRTOS skin #2 =

>> =

>>  On 06/02/2014 08:46 PM, Matthias Schneider wrote: =

>> =

>> =

>>>  Please find enclosed a new version of the FreeRTOS skin. It adapts to =

> the =

>>>  latest changes in forge/next and also removes the previously included =

>>>  workarounds - thanks to the changes done based on the first review =

> round =

>>>  they were no longer necessary. =

>>> =

>> =

>>  Thanks. Here we go: =

>> =

>>  * vTaskStartScheduler() =

>> =

>>  Dropping the task_list lock then yielding is superfluous, the caller =

>>  will wait on the condvar for the scheduler state to switch to SUSPENDIN=
G =

>>  anyway, implicitly releasing this lock before going to sleep. =

> =

> Done. =

> =

>> =

>>  * vTaskDelay() =

>> =

>>  Cobalt wraps sched_yield(), so you likely want to call =

>>  __RT(sched_yield()) to pick the proper implementation depending on the =

>>  underlying real-time core. =

> Done. =

> =A0 =

>>  * __xTaskGenericCreate() =

>> =

>>  - It looks like the mutex attribute initialized locally is a left over =

>>  from a previous implementation. =

>> =

>>  - Drawing unique identifier labels should be done using a name =

>>  generator, e.g. =

>> =

>>  static DEFINE_NAME_GENERATOR(task_namegen, struct freertos_task, name); =

>>  ... =

>> =A0 =A0  generate_name(task->name, name, &task_namegen); =

>>  The open-coded method also used by other emulators is racy. =

> Done. =

> Note that some freertos specific code remains to make duplicated task nam=
es =

> unique.
> =A0 =

>>  * vPortEnter/ExitCritical() =

>> =

>>  - wouldn't these calls better emulated by threadobj_lock_sched() =

>>  assuming they stand for a global serialization mechanism? =

> Unfortunately, this seems cause some test cases in the demo to fail. =

> Since these tests are rather time consuming to investigate, I would like =

> to leave this item open until all other issues have been addressed. We =

> had also talked about other options concerning this subject as well =

> (removing the function or leaving it empty), so I still need some =

> time to think about it. =

>>  * Task registry support =

>> =

>>  The code looks outdated, using fsobstacks is recommended. The registry =

>>  helpers in lib/alchemy/alarm.c illustrate a basic usage. =

> Done. =

> =

>> =

>>  * vTaskSuspendAll() =

>> =

>>  Running check_processors() there may switch the caller to linux mode =

>>  at each invocation, due to calling sysconf/sched_getaffinity indirectly=
. =

>>  I would rather assume that the CPU affinity is not allowed to change =

>>  once started, and determine whether a task is bound to more than a =

>>  single CPU in the trampoline code. Then vTaskSuspendAll() may do a =

>>  simple flag-based test for checking the consistency, still allowing =

>>  different freertos tasks to be pinned on distinct CPUs though. At any =

>>  rate, this would be an acceptable restriction, since freertos does not =

>>  seem to be SMP-capable in its reference implementation anyway. =

> Ok, reading the affinity information once and caching it makes sense to =

> avoid the switches to secondary mode. However, vTaskSuspendAll() / =

> vTaskResumeAll() only works as expected when all tasks are pinned to a=A0
> single cpu, storing this information on a by-task basis will not be suffi=
cient.=A0
> Now if there is one place to retrieve this information, which would it be=
? =

> I can think of freertos_init() / freertos_scheduler_init() or =

> vTaskStartScheduler(). However,=A0 freertos_init() would probably not be =

> able to allow setting process cpu affinity programatically at the =

> beginning of main() if I am not mistaken. =

>>  Next time, I'll start reviewing other parts of the emulator. =

> Great, thanks in advance for all the input.. =

> =

>>  HTH, =

>> =

>>  -- =

>>  Philippe. =

>> =



Please find enclosed a revised patch.

Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Initial-Freertos-commit-no.-4.patch.gz
Type: application/x-gzip
Size: 34354 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140623/2a04404=
8/attachment.bin>
