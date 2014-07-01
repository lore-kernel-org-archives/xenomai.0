References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Message-ID: <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Tue, 1 Jul 2014 17:48:09 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
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
To: Matthias Schneider <ma30002000@yahoo.de>, Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----

> From: Matthias Schneider <ma30002000@yahoo.de>
> To: Philippe Gerum <rpm@xenomai.org>; "xenomai@xenomai.org" <xenomai@xeno=
mai.org>
> Cc: =

> Sent: Monday, June 23, 2014 10:27 PM
> Subject: Re: [Xenomai] FreeRTOS skin #2
> =

> ----- Original Message -----
> =

>>  From: Matthias Schneider <ma30002000@yahoo.de>
>>  To: Philippe Gerum <rpm@xenomai.org>; "xenomai@xenomai.org" =

> <xenomai@xenomai.org>
>>  Cc: =

>>  Sent: Monday, June 23, 2014 12:31 PM
>>  Subject: Re: [Xenomai] FreeRTOS skin #2
>> =

>>  ----- Original Message ----- =

>>> =A0 From: Philippe Gerum <rpm@xenomai.org> =

>>> =A0 To: Matthias Schneider <ma30002000@yahoo.de>; =

>>  "xenomai@xenomai.org" <xenomai@xenomai.org> =

>>> =A0 Cc: =

>>> =A0 Sent: Friday, June 20, 2014 9:55 AM =

>>> =A0 Subject: Re: [Xenomai] FreeRTOS skin #2 =

>>> =

>>> =A0 On 06/02/2014 08:46 PM, Matthias Schneider wrote: =

>>> =

>>> =

>>>> =A0 Please find enclosed a new version of the FreeRTOS skin. It adapts =

> to =

>>  the =

>>>> =A0 latest changes in forge/next and also removes the previously =

> included =

>>>> =A0 workarounds - thanks to the changes done based on the first review =

> =

>>  round =

>>>> =A0 they were no longer necessary. =

>>>> =

>>> =

>>> =A0 Thanks. Here we go: =

>>> =

>>> =A0 * vTaskStartScheduler() =

>>> =

>>> =A0 Dropping the task_list lock then yielding is superfluous, the calle=
r =

>>> =A0 will wait on the condvar for the scheduler state to switch to =

> SUSPENDING =

>>> =A0 anyway, implicitly releasing this lock before going to sleep. =

>> =

>>  Done. =

>> =

>>> =

>>> =A0 * vTaskDelay() =

>>> =

>>> =A0 Cobalt wraps sched_yield(), so you likely want to call =

>>> =A0 __RT(sched_yield()) to pick the proper implementation depending on =
the =

> =

>>> =A0 underlying real-time core. =

>>  Done. =

>>  =A0 =

>>> =A0 * __xTaskGenericCreate() =

>>> =

>>> =A0 - It looks like the mutex attribute initialized locally is a left o=
ver =

> =

>>> =A0 from a previous implementation. =

>>> =

>>> =A0 - Drawing unique identifier labels should be done using a name =

>>> =A0 generator, e.g. =

>>> =

>>> =A0 static DEFINE_NAME_GENERATOR(task_namegen, struct freertos_task, =

> name); =

>>> =A0 ... =

>>>  =A0 =A0=A0 generate_name(task->name, name, &task_namegen); =

>>> =A0 The open-coded method also used by other emulators is racy. =

>>  Done. =

>>  Note that some freertos specific code remains to make duplicated task n=
ames =

> =

>>  unique.
>>  =A0 =

>>> =A0 * vPortEnter/ExitCritical() =

>>> =

>>> =A0 - wouldn't these calls better emulated by threadobj_lock_sched() =

>>> =A0 assuming they stand for a global serialization mechanism? =

>>  Unfortunately, this seems cause some test cases in the demo to fail. =

>>  Since these tests are rather time consuming to investigate, I would lik=
e =

>>  to leave this item open until all other issues have been addressed. We =

>>  had also talked about other options concerning this subject as well =

>>  (removing the function or leaving it empty), so I still need some =

>>  time to think about it. =

>>> =A0 * Task registry support =

>>> =

>>> =A0 The code looks outdated, using fsobstacks is recommended. The regis=
try =

> =

>>> =A0 helpers in lib/alchemy/alarm.c illustrate a basic usage. =

>>  Done. =

>> =

>>> =

>>> =A0 * vTaskSuspendAll() =

>>> =

>>> =A0 Running check_processors() there may switch the caller to linux mod=
e =

>>> =A0 at each invocation, due to calling sysconf/sched_getaffinity =

> indirectly. =

>>> =A0 I would rather assume that the CPU affinity is not allowed to chang=
e =

>>> =A0 once started, and determine whether a task is bound to more than a =

>>> =A0 single CPU in the trampoline code. Then vTaskSuspendAll() may do a =

>>> =A0 simple flag-based test for checking the consistency, still allowing =

>>> =A0 different freertos tasks to be pinned on distinct CPUs though. At a=
ny =

>>> =A0 rate, this would be an acceptable restriction, since freertos does =
not =

> =

>>> =A0 seem to be SMP-capable in its reference implementation anyway. =

>>  Ok, reading the affinity information once and caching it makes sense to =

>>  avoid the switches to secondary mode. However, vTaskSuspendAll() / =

>>  vTaskResumeAll() only works as expected when all tasks are pinned to a=
=A0
>>  single cpu, storing this information on a by-task basis will not be =

> sufficient.=A0
>>  Now if there is one place to retrieve this information, which would it =
be? =

>>  I can think of freertos_init() / freertos_scheduler_init() or =

>>  vTaskStartScheduler(). However,=A0 freertos_init() would probably not b=
e =

>>  able to allow setting process cpu affinity programatically at the =

>>  beginning of main() if I am not mistaken. =

>>> =A0 Next time, I'll start reviewing other parts of the emulator. =

>>  Great, thanks in advance for all the input.. =

>> =

>>> =A0 HTH, =

>>> =

>>> =A0 -- =

>>> =A0 Philippe. =

>>> =

> =

> =

> Please find enclosed a revised patch.
> =

> Matthias


Please find enclosed another calling the check_processors() only when start=
ing
the scheduler and remembering its output. It is also adapted to the latest =
changes.
Any comments will be appreciated.

Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Initial-Freertos-commit-no.-5.patch.gz
Type: application/gzip
Size: 34306 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140701/e7483da=
c/attachment.bin>
