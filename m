References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org> <53679427.90603@xenomai.org>
 <1399360194.79292.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53689342.2050005@xenomai.org>
Message-ID: <1399395015.38309.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Date: Tue, 6 May 2014 17:50:15 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53689342.2050005@xenomai.org>
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

> From: Philippe Gerum <rpm@xenomai.org>=0A> On 05/06/2014 09:09 AM, Matthi=
as Schneider wrote:=0A>>> On 05/05/2014 12:33 PM, Philippe Gerum wrote:=0A>=
>>>     On 05/04/2014 06:59 PM, Matthias Schneider wrote:=0A>>>>>     Hi al=
l,=0A>>>>>=A0=0A>>>>>     please find enclosed a patch with a FreeRTOS skin=
 for xenomai-forge I=0A>>>>>     have  been  working on for some time.=A0=
=0A[...]=A0=0A>>>>=A0=0A>>>>     Ok, thanks for this. Let's address issues =
gradually,  starting with the=0A>>>>     task module.=0A>>>>=A0=0A>>>=A0=0A=
>>> In addition to the above, there are a few coding style items:=0A>>>=A0=
=0A>>> - Please always take the fastest possible path when exiting on error=
,=0A>>>     so that we don't have to cripple the normal processing followin=
g the=0A>>>     failure point with error-specific checks. e.g. what is done=
 with  the=0A>>>     "task" variable in vTaskStartScheduler(), within the t=
hread=0A>>>     cancellation loop, ends up being convoluted and confusing, =
compared=0A>>>     to unwinding and leaving the routine immediately after t=
he error is=0A>>>     detected.=0A>>=A0=0A>>=A0=0A>> I will review the code=
 and simplify occurrences of the mentioned pattern.=0A>> However I do not s=
ee this pattern in this particular code fragment, since=A0=0A> it basically=
 does the following:=0A>>=A0=0A>> * take the first entry of the task list=
=0A>=A0=0A> The first check for list emptiness looks racy, as it is not cov=
ered by=A0=0A> the scheduler.lock.=0A=0ATrue. See below.=0A=0A=0A>> * check=
 if the task object can be locked=0A>> * unlock the scheduler lock=0A>> * i=
f it was possible to lock the task, cancel it=0A>> * else wait 1ms and try =
to lock it again=0A>=A0=0A> If you found it in your task queue but can't lo=
ck it, then call Houston=A0=0A> because we have a problem: the task finaliz=
er where this task is dropped=A0=0A> from the list runs prior to deleting t=
he lock. However, testing for the=A0=0A> magic word on success is indeed re=
quired in the current implementation,=A0=0A> since the thread lock is dropp=
ed shortly prior to canceling the thread=A0=0A> in copperplate.=0A>=A0=0A> =
You could use pvlist_for_each_entry_safe() for iterating over the task=A0=
=0A> queue.=0A>=A0=0A>>=A0=0A>> No error condition leads to leaving this lo=
op. I do agree however, that the=0A>> code is convoluted, mainly due to the=
 erroneous-looking nested locks, one=0A>> for protecting freertos_task_list=
 and one locking the threadobj. The list=A0=0A> should be locked while acce=
ssing it, while holding it when cancelling the=A0=0A> threadobj will lead t=
o deadlocks (task_finalizer takes freertos_scheduler.lock).=0A>>=A0=0A>=A0=
=0A> Setting task to NULL upon locking error, only for the purpose of=A0=0A=
> avoiding the magic check in the normal code flow is the issue I mentioned=
:=0A>=A0=0A>         if (task && threadobj_lock(&task->thobj) =3D=3D -EINVA=
L)=0A>             task =3D NULL;=0A>=A0=0A>         if (task && threadobj_=
get_magic(&task->thobj) !=3D=A0=0A> task_magic) {=0A>             threadobj=
_unlock(&task->thobj);=0A>             task =3D NULL;=0A>         }=0A>=A0=
=0A[...]=A0=0A=0AOk let's simplify the code (and add the missing lock):=0A=
=0Awrite_lock_nocancel(&freertos_scheduler.lock);=0Afreertos_scheduler.stat=
e =3D taskSCHEDULER_NOT_STARTED;=0A=0A/* cancel all tasks in list */=0Awhil=
e (!pvlist_empty(&freertos_task_list)) {=0A=A0 =A0 task =3D pvlist_first_en=
try(&freertos_task_list, struct freertos_task, next);=0A=A0 =A0 if (threado=
bj_lock(&task->thobj) !=3D -EINVAL) {=0A=A0 =A0 =A0 =A0 =A0 =A0 if (threado=
bj_get_magic(&task->thobj) =3D=3D task_magic) {=0A=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* need to leave freertos_scheduler.lock since it is=0A=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 taken in task_finalizer while w=
e block in=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 threadobj_canc=
el */=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&freertos_sche=
duler.lock);=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 threadobj_cancel(&ta=
sk->thobj);=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_lock_nocancel(&=
freertos_scheduler.lock);=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;=0A=A0 =A0 =A0 =A0 =A0 =A0 }=0A=A0 =A0 =A0 =A0 =A0 =A0 threadobj_unlock(&=
task->thobj);=0A=A0 =A0 }=0A=A0 =A0 /* Need to release the lock for a while=
 since a task in deletion=0A=A0 =A0 =A0 =A0 may need it to unregister itsel=
f from freertos_task_list */=0A=A0 =A0 write_unlock(&freertos_scheduler.loc=
k);=0A=A0 =A0 struct timespec rqt;=0A=A0 =A0 clockobj_ticks_to_timeout(&fre=
ertos_clock,=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
0.001 * xGetTicksPerSecond(),=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 &rqt);=0A=A0 =A0 threadobj_sleep(&rqt);=0A=A0 =A0 write_lo=
ck_nocancel(&freertos_scheduler.lock);=0A}=0Awrite_unlock(&freertos_schedul=
er.lock);=0A=0AI had used pvlist_for_each_entry_safe() originally, but due =
to the possibility=A0=0Ahaving to=A0access a single task multiple times, I =
ended up=A0with two nested loops.=0A=0A> --=A0=0A> Philippe.=0A>

