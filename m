References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
 <1399396759.65313.YahooMailNeo@web171604.mail.ir2.yahoo.com>
 <5369201B.1080108@xenomai.org>
Message-ID: <1399405610.93130.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Tue, 6 May 2014 20:46:50 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5369201B.1080108@xenomai.org>
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

----- Original Message -----=0A=0A> From: Philippe Gerum <rpm@xenomai.org>=
=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <x=
enomai@xenomai.org>=0A> Cc: =0A> Sent: Tuesday, May 6, 2014 7:47 PM=0A> Sub=
ject: Re: [Xenomai] FreeRTOS skin=0A> =0A> On 05/06/2014 07:19 PM, Matthias=
 Schneider wrote:=0A>> =0A>>  Are you referring to freertos_scheduler.sem? =
It is used to blocke the=0A>>  main thread while the "scheduer" is running.=
 Even when moving the =0A> task=0A>>  cancellation loop to inside the vTask=
EndScheduler(), vTaskStartScheduler()=0A>>  would still need to block until=
 vTaskEndScheduler() is a=0A>> =0A> =0A> I mean you don't need a syncobj. T=
his is overly complex for the purpose, =0A> you can use a sem_t. syncobj im=
plements extended semantics we commonly =0A> find in RTOS, which are not av=
ailable with regular POSIX ipc. But in =0A> this case, we don't need them: =
we just need to wait for a pulse, once.=0A=0AOk, got it. Now the last quest=
ion concerning this, should it be a=0A_RT(sem_init) or _STD(sem_init)? Does=
 it matter in this case?=0A=0A>>>  - vTaskSuspendAll()/vTaskResumeAll() mai=
ntain useless status flags.=0A>>>  Copperplate provides __THREAD_S_SUSPENDE=
D in the core status of threads=0A>>>  for the very same purpose.=0A>> =0A>=
>  This is not entirely correct. Consider the following case (part of the d=
emo=0A>>  actually):=0A>> =0A>>  vTaskSuspendAll();=0A>>  vTaskSuspend(th1)=
;=0A>>  vTaskResumeAll();=0A>> =0A>>  This is supposed to leave th1 suspend=
ed after vTaskResumeAll(). This=0A>>  information needs to be stored somewh=
ere. After vTaskSuspendAll(), all=0A>>  except the current thread have __TH=
READ_S_SUSPENDED set, so another way to=0A>>  store this informaion is need=
ed. I have also experimented modelling these=0A>>  functions using threadob=
j_sched_lock() & co., however, even on UP machines=0A>>  the following code=
 would not behave as supposed:=0A>> =0A>>  vTaskSuspendAll();=0A>>  vTaskDe=
lay(xGetTicksPerSecond() * 0.01);=0A>>  vTaskResumeAll();=0A>> =0A>>  Obvio=
usly, during vTaskDelay() other tasks of lower than "sched" =A0prio may=0A>=
>  be executed.=0A> =0A> vTaskSuspendAll() very much looks like plain sched=
uler lock, preventing =0A> the caller from scheduling out on preemption. If=
 so, then the whole =0A> issue disappears, there would not be any cumulativ=
e blocking states.=0A=0A=0ASo the recommendation would be to go for the thr=
eadobj_sched_lock()=0Aapproach? But how can I address the mentioned issue o=
f being scheduled=0Aout when waiting? It would make a lot of things a lot e=
asier, so much=0Afor sure...=0A=0A>>>  The other set of issues is all about=
 locking is managed. A couple of hints:=0A>>> =0A>>>  - vPortEnterCritical(=
)/vPortExitCritical() can't be emulated since we=0A>>>  can't mask IRQs in =
userland (and we certainly don't want to even try=0A>>>  doing so). This wo=
uld be a RTDM driver's business in the Xenomai model.=0A>>>  Looking at the=
 FreeRTOS doc, the closest approximation would be=0A>>>  threadobj_sched_lo=
ck() in userland, but since hardware drivers should=0A>>>  move to kernel s=
pace over RTDM, I'm unsure emulating these calls has any=0A>>>  benefit in =
our context.=0A>> =0A>>  Correct. I though I had seen use of it in the plat=
eform-independent demo=0A>>  previously, but apparently I remember incorrec=
tly. Defining them as empty=0A>>  functions thus.=0A>> =0A> =0A> I would ra=
ther not define them, to make sure the user knows about the =0A> issue when=
 the compiler complains about it. Silently ignoring a hard =0A> critical se=
ction is unlikely to help.=0A=0AThe platform-independent demo uses them a l=
ot, although it does not=A0=0Adeal with interrupts at all.. If I remove the=
m, I will need to patch=A0=0Athe demo, probably to the point where checking=
 in the whole patched=A0=0Ademo will make more sense than adding more and m=
ore patch files.=0AOr maybe it should be something like threadobj_sched_loc=
k() instead?=0A=0A> =0A> -- =0A> Philippe.=0A> 

