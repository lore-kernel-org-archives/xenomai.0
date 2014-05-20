References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
 <1400437808.41304.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <5379B6BA.2040509@xenomai.org>
Message-ID: <1400569593.17864.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Tue, 20 May 2014 08:06:33 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5379B6BA.2040509@xenomai.org>
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

=0A=0A=0A=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@x=
enomai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xeno=
mai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Monday, May 19, 2014 9:46=
 AM=0A> Subject: Re: [Xenomai] FreeRTOS skin=0A> =0A> On 05/18/2014 08:30 P=
M, Matthias Schneider wrote:=0A>>  ----- Original Message -----=0A>> =0A>>>=
  From: Philippe Gerum <rpm@xenomai.org>=0A>>>  To: Matthias Schneider <ma3=
0002000@yahoo.de>; =0A> "xenomai@xenomai.org" <xenomai@xenomai.org>=0A>>>  =
Cc:=0A>>>  Sent: Monday, May 5, 2014 12:33 PM=0A>>>  Subject: Re: [Xenomai]=
 FreeRTOS skin=0A>>> =0A>>>  On 05/04/2014 06:59 PM, Matthias Schneider wro=
te:=0A>>> =0A>>>> =A0  Hi all,=0A>>>> =0A>>>> =A0  please find enclosed a p=
atch with a FreeRTOS skin for =0A> xenomai-forge I have=0A>>>> =A0  been=A0=
 working on for some time. I would like to get some feedback =0A> and advic=
e=0A>>>> =A0  what still needs to be done to get it accepted in Xenomai. Th=
ere =0A> is a set of=0A>>>> =A0  unit tests included and the possibility to=
 download the original =0A> FreeRTOS package=0A>>>> =A0  in order to run mo=
st of its (platform independent) test suite. =0A> Until now I have=0A>>>> =
=A0  been working under mercury only. Documentation is available in =0A> fo=
rm of a README=0A>>>> =A0  file in lib/freertos/README, which should also b=
e a good starting =0A> point.=0A>>> =0A>>>  Ok, thanks for this. Let's addr=
ess issues gradually, starting with =0A> the=0A>>>  task module.=0A>>> =0A>=
>  [...]=0A>>> =0A>>>  - the read/write_lock_nocancel() form is reserved fo=
r protecting=0A>>>  sections which are known not to traverse cancellation p=
oints, as =0A> defined=0A>>>  by POSIX=0A>>> =0A> (http://pubs.opengroup.or=
g/onlinepubs/009695399/functions/xsh_chap02_09.html).=0A>>>  This is about =
self-documentation of the code, and optimizing execution=0A>>>  by omitting=
 costly management of cleanup blocks when it is deemed safe=0A>>>  to do so=
.=0A>>> =0A>>>  - CANCEL_DEFER() / CANCEL_RESTORE() should protect sections=
 against=0A>>>  asynchronous cancellation, we typically do this before invo=
king the=0A>>>  copperplate layer, so that we may assume that pthread_cance=
l() =0A> won't be=0A>>>  a problem when running inner code, provided we hav=
e been careful about=0A>>>  handling read/write lock cleanups. These macros=
 work by disabling=0A>>>  asynchronous cancellation for the current thread =
when=0A>>>  --enable-async-cancel was given at build time. Otherwise, this =
part is =0A> a=0A>>>  nop.=0A>> =0A>>  Obviously the *nocancel locks in my =
previous patch (task.c) were incorrect.=0A>>  However I am not sure which w=
ay to replace them - I see several =0A> possibilities:=0A>> =0A>>  a)=0A>> =
 push_cleanup_lock(&freertos_scheduler.lock);=0A>>  write_lock(&freertos_sc=
heduler.lock);=0A>>  //will correctly clean up when thread is cancelled=0A>=
> =0A>>  b)=0A>>  write_lock_safe(&freertos_scheduler.lock);=0A>>  // will =
disable cancellation until lock is released=0A>> =0A>>  c)=0A>>  do no care=
 about locks in cancelled threads and just use=0A>>  write_lock(&freertos_s=
cheduler.lock)=0A>> =0A>>  Since freertos_scheduler.lock is essential for t=
he correct functioning of =0A> the=0A>>  FreeRTOS skin, c) is probably out.=
=0A>> =0A>>  Any hint?=0A>> =0A> =0A> I would restrict this lock to protect=
ing manipulations of the task list, =0A> nothing more. It seems to be cover=
ing too much code right now. Assuming =0A> this, you would only need the _n=
ocancel form to protect basic list =0A> operations which do not cross any c=
ancellation point.=0A> =0A> Having vTaskStartScheduler() wait for task term=
ination should be as =0A> simple as a condvar-based protocol, e.g.=0A> =0A>=
 __RT(mutex_lock(&tasklist_lock));=0A> =0A> for (;;) {=0A> =A0=A0=A0 if (pv=
list_empty(&task_list))=0A> =A0=A0=A0 =A0=A0=A0 break;=0A> =A0=A0=A0 __RT(p=
thread_cond_wait(&tasklist_cond, &tasklist_lock));=0A> }=0A> =0A> __RT(mute=
x_unlock(&tasklist_lock));=0A> =0A> You could then synchronize with the tas=
k finalizer, e.g.=0A> =0A> task_finalizer:=0A> =0A> __RT(mutex_lock(&taskli=
st_lock));=0A> =0A> pvlist_remove(&task->next);=0A> =0A> if (freertos_sched=
uler.state !=3D taskSCHEDULER_RUNNING && =0A> pvlist_empty(&task_list))=0A>=
 =A0=A0=A0 __RT(pthread_cond_signal(&tasklist_cond));=0A> =0A> __RT(mutex_l=
ock(&tasklist_lock));=0A> =0A> I would also introduce a new scheduler state=
, e.g. =0A> taskSCHEDULER_STOPPING, which could be used to prevent a concur=
rent call =0A> to vTaskStartScheduler() to respawn the system until the ong=
oing =0A> shutdown has eventually completed.=0A> =0A> PS: The __RT() modifi=
er means to pick the dual kernel version of this =0A> call over Cobalt (i.e=
. the real-time one implemented by Xenomai), or the =0A> regular glibc one =
over Mercury. __STD() means to always pick the =0A> glibc-based call, regar=
dless of the real-time core underneath.=0A> =0A> If you mention no modifier=
, either of __RT/__STD may be assumed =0A> depending on whether symbol wrap=
ping is enabled at link time. To prevent =0A> any ambiguity, a skin should =
always specify the appropriate modifier for =0A> calls the Cobalt core over=
rides from the glibc, since applications may =0A> or may not require symbol=
 wrapping.=0A>=A0=0A=0AConsidering that the simple approach was the one I h=
ad originally employed=0Auntil I implemented vTaskResumeAll and vTaskSuspen=
dAll=0AI suppose it all comes down how to implement these two functions.=0A=
=0AI am nearly convinced to implement them via threadobj_lock_sched() and=
=A0=0Athreadobj_unlock_sched(), which should make most of the proposed=A0=
=0Are-simplifications possible, but I have still two points:=0A=0A* On smp =
machines, it will not behave as expected since the mentioned=0Afunctions wi=
ll prevent the current thread from being scheduled out,=0Abut not from othe=
r tasks being executed on other CPUs if I am correct=0A=0A* functions like =
vTaskDelay / threadobj_sleep() will not perform as expected=0Asince they ma=
y cause the curren task being schduled out.=0A=0AIs there anything I can do=
 about these?=0A=0AAlso, functions like xTaskIsTaskSuspended() and uxTaskPr=
iorityGet need to be=0Aadapted to return simulated values, but this should =
be easy.

