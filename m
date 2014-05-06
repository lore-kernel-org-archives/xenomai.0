References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
Message-ID: <1399396759.65313.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Tue, 6 May 2014 18:19:19 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53676902.5050405@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin
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

----- Original Message -----=0A> From: Philippe Gerum <rpm@xenomai.org>=0A>=
 To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenom=
ai@xenomai.org>=0A> Cc:=A0=0A> Sent: Monday, May 5, 2014 12:33 PM=0A> Subje=
ct: Re: [Xenomai] FreeRTOS skin=0A>=A0=0A> On 05/04/2014 06:59 PM, Matthias=
 Schneider wrote:=0A>=A0=0A>> Hi all,=0A>>=A0=0A>> please find enclosed a p=
atch with a FreeRTOS skin for xenomai-forge I have=0A>> been  working on fo=
r some time. I would like to get some feedback and advice=0A>> what still n=
eeds to be done to get it accepted in Xenomai. There is a set of=0A>> unit =
tests included and the possibility to download the original FreeRTOS packag=
e=0A>> in order to run most of its (platform independent) test suite. Until=
 now I have=0A>> been working under mercury only. Documentation is availabl=
e in form of a README=0A>> file in lib/freertos/README, which should also b=
e a good starting point.=0A>=A0=0A> Ok, thanks for this. Let's address issu=
es gradually, starting with the task module.=0A=0AI will try to address som=
e of the mentioned issues now, the rest later:=0A=0A> I'd suggest to revisi=
t the following mechanisms to get our feet wet:=A0=0A> vTaskStartScheduler(=
)/vTaskEndScheduler() and=A0=0A> vTaskSuspendAll()/vTaskResumeAll().=0A>=A0=
=0A> - synchronizing on scheduler start/stop events can be made simpler, by=
=A0=0A> waiting on a barrier after threadobj_wait_start() has returned in t=
he=A0=0A> task trampoline, meanwhile starting all tasks copperplate-wise at=
=A0=0A> creation time via threadobj_start(). Such additional barrier should=
 be a=A0=0A> condition variable protected by your current scheduler.lock mu=
tex,=A0=0A> signaled by vTaskStartScheduler(). Tasks would have to check fo=
r the=A0=0A> scheduler state before breaking the wait loop.=0A>=A0=0A> - as=
suming that threadobj_cancel() already waits for the canceled thread=A0=0A>=
 to finalize, you should only need to change the scheduler object state=A0=
=0A> in vTaskEndScheduler() prior to cancelling all tasks. You should not=
=A0=0A> need the extra syncobj.=0A=0AAre you referring to freertos_schedule=
r.sem? It is used to blocke the=A0=0Amain thread while the "scheduer" is ru=
nning. Even when moving the task=A0=0Acancellation loop to inside the vTask=
EndScheduler(), vTaskStartScheduler()=0Awould still need to block until vTa=
skEndScheduler() is a=0A=0A> - vTaskSuspendAll()/vTaskResumeAll() maintain =
useless status flags.=A0=0A> Copperplate provides __THREAD_S_SUSPENDED in t=
he core status of threads=A0=0A> for the very same purpose.=0A=0AThis is no=
t entirely correct. Consider the following case (part of the demo=0Aactuall=
y):=0A=0AvTaskSuspendAll();=0AvTaskSuspend(th1);=0AvTaskResumeAll();=0A=0AT=
his is supposed to leave th1 suspended after vTaskResumeAll(). This=A0=0Ain=
formation needs to be stored somewhere. After vTaskSuspendAll(), all=0Aexce=
pt the current thread have __THREAD_S_SUSPENDED set, so another way to=0Ast=
ore this informaion is needed. I have also experimented modelling these=A0=
=0Afunctions using threadobj_sched_lock() & co., however, even on UP machin=
es=0Athe following code would not behave as supposed:=0A=0AvTaskSuspendAll(=
);=0AvTaskDelay(xGetTicksPerSecond() * 0.01);=0AvTaskResumeAll();=0A=0AObvi=
ously, during vTaskDelay() other tasks of lower than "sched" prio may=0Abe =
executed.=0A=0A> The other set of issues is all about locking is managed. A=
 couple of hints:=0A>=A0=0A> - vPortEnterCritical()/vPortExitCritical() can=
't be emulated since we=A0=0A> can't mask IRQs in userland (and we certainl=
y don't want to even try=A0=0A> doing so). This would be a RTDM driver's bu=
siness in the Xenomai model.=A0=0A> Looking at the FreeRTOS doc, the closes=
t approximation would be=A0=0A> threadobj_sched_lock() in userland, but sin=
ce hardware drivers should=A0=0A> move to kernel space over RTDM, I'm unsur=
e emulating these calls has any=A0=0A> benefit in our context.=0A=0ACorrect=
. I though I had seen use of it in the plateform-independent demo=0Apreviou=
sly, but apparently I remember incorrectly. Defining them as empty=0Afuncti=
ons thus.=0A=0A>=A0=0A> - threadobj_sched_lock() does not prevent the calle=
r from scheduling=0A> out, it only stops involuntary preemption when runnin=
g non-blocking=A0=0A> code. Typically, locking a mutex is potentially block=
ing code, so the=A0=0A> guarantee disappears in that case. IIUC, the curren=
t code assumes more=A0=0A> than this. Moreover, issuing a sleeping call vol=
untarily when holding=A0=0A> this lock is logically wrong, even if Xenomai =
won't jump over the window=A0=0A> doing so, unlike many RTOS vTaskStartSche=
duler()).=0A>=A0=0A> - the read/write_lock_nocancel() form is reserved for =
protecting=A0=0A> sections which are known not to traverse cancellation poi=
nts, as defined=A0=0A> by POSIX=A0=0A> (http://pubs.opengroup.org/onlinepub=
s/009695399/functions/xsh_chap02_09.html).=A0=0A> This is about self-docume=
ntation of the code, and optimizing execution=A0=0A> by omitting costly man=
agement of cleanup blocks when it is deemed safe=A0=0A> to do so.=0A>=A0=0A=
> - CANCEL_DEFER() / CANCEL_RESTORE() should protect sections against=A0=0A=
> asynchronous cancellation, we typically do this before invoking the=A0=0A=
> copperplate layer, so that we may assume that pthread_cancel() won't be=
=A0=0A> a problem when running inner code, provided we have been careful ab=
out=A0=0A> handling read/write lock cleanups. These macros work by disablin=
g=A0=0A> asynchronous cancellation for the current thread when=A0=0A> --ena=
ble-async-cancel was given at build time. Otherwise, this part is a=A0=0A> =
nop.=0A>=A0=0A> - Scheduler.queued_task, .state and .num_tasks all seem log=
ically=A0=0A> related. So .num_tasks should be updated holding Scheduler.lo=
ck, instead=A0=0A> of using an atomic type. We'd need to issue smp_rmb() pr=
ior to reading=A0=0A> that counter locklessly.=0A>=A0=0A> HTH,=0A>=A0=0A> -=
-=A0=0A> Philippe.=0A>

