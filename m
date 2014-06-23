References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
Message-ID: <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Mon, 23 Jun 2014 11:31:50 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53A3E8FE.5020005@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

----- Original Message ----- =0A> From: Philippe Gerum <rpm@xenomai.org> =
=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <x=
enomai@xenomai.org> =0A> Cc: =0A> Sent: Friday, June 20, 2014 9:55 AM =0A> =
Subject: Re: [Xenomai] FreeRTOS skin #2 =0A> =0A> On 06/02/2014 08:46 PM, M=
atthias Schneider wrote: =0A> =0A> =0A>> Please find enclosed a new version=
 of the FreeRTOS skin. It adapts to the =0A>> latest changes in forge/next =
and also removes the previously included =0A>> workarounds - thanks to the =
changes done based on the first review round =0A>> they were no longer nece=
ssary. =0A>> =0A> =0A> Thanks. Here we go: =0A> =0A> * vTaskStartScheduler(=
) =0A> =0A> Dropping the task_list lock then yielding is superfluous, the c=
aller =0A> will wait on the condvar for the scheduler state to switch to SU=
SPENDING =0A> anyway, implicitly releasing this lock before going to sleep.=
 =0A=0ADone. =0A=0A> =0A> * vTaskDelay() =0A> =0A> Cobalt wraps sched_yield=
(), so you likely want to call =0A> __RT(sched_yield()) to pick the proper =
implementation depending on the =0A> underlying real-time core. =0ADone. =
=0A=A0 =0A> * __xTaskGenericCreate() =0A> =0A> - It looks like the mutex at=
tribute initialized locally is a left over =0A> from a previous implementat=
ion. =0A> =0A> - Drawing unique identifier labels should be done using a na=
me =0A> generator, e.g. =0A> =0A> static DEFINE_NAME_GENERATOR(task_namegen=
, struct freertos_task, name); =0A> ... =0A>     generate_name(task->name, =
name, &task_namegen); =0A> The open-coded method also used by other emulato=
rs is racy. =0ADone. =0ANote that some freertos specific code remains to ma=
ke duplicated task names =0Aunique.=0A=A0 =0A> * vPortEnter/ExitCritical() =
=0A> =0A> - wouldn't these calls better emulated by threadobj_lock_sched() =
=0A> assuming they stand for a global serialization mechanism? =0AUnfortuna=
tely, this seems cause some test cases in the demo to fail. =0ASince these =
tests are rather time consuming to investigate, I would like =0Ato leave th=
is item open until all other issues have been addressed. We =0Ahad also tal=
ked about other options concerning this subject as well =0A(removing the fu=
nction or leaving it empty), so I still need some =0Atime to think about it=
. =0A> * Task registry support =0A> =0A> The code looks outdated, using fso=
bstacks is recommended. The registry =0A> helpers in lib/alchemy/alarm.c il=
lustrate a basic usage. =0ADone. =0A=0A> =0A> * vTaskSuspendAll() =0A> =0A>=
 Running check_processors() there may switch the caller to linux mode =0A> =
at each invocation, due to calling sysconf/sched_getaffinity indirectly. =
=0A> I would rather assume that the CPU affinity is not allowed to change =
=0A> once started, and determine whether a task is bound to more than a =0A=
> single CPU in the trampoline code. Then vTaskSuspendAll() may do a =0A> s=
imple flag-based test for checking the consistency, still allowing =0A> dif=
ferent freertos tasks to be pinned on distinct CPUs though. At any =0A> rat=
e, this would be an acceptable restriction, since freertos does not =0A> se=
em to be SMP-capable in its reference implementation anyway. =0AOk, reading=
 the affinity information once and caching it makes sense to =0Aavoid the s=
witches to secondary mode. However, vTaskSuspendAll() / vTaskResumeAll() on=
ly works as expected when all tasks are pinned to a=A0=0Asingle cpu, storin=
g this information on a by-task basis will not be sufficient.=A0=0ANow if t=
here is one place to retrieve this information, which would it be? =0AI can=
 think of freertos_init() / freertos_scheduler_init() or =0AvTaskStartSched=
uler(). However,  freertos_init() would probably not be =0Aable to allow se=
tting process cpu affinity programatically at the =0Abeginning of main() if=
 I am not mistaken. =0A> Next time, I'll start reviewing other parts of the=
 emulator. =0AGreat, thanks in advance for all the input.. =0A> HTH, =0A> =
=0A> -- =0A> Philippe. =0A>

