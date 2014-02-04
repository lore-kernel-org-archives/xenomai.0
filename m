References: <1391373420.28930.YahooMailNeo@web171604.mail.ir2.yahoo.com>
 <52EF7772.2000008@xenomai.org> 
Message-ID: <1391541132.31887.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Tue, 4 Feb 2014 19:12:12 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <52EF7772.2000008@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] race condition when creating and deleting VxWorks
	tasks in xenomai-forge
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Monday, February 3, 2014 12:02 PM, Philippe Gerum <rpm@xenomai.org> wr=
ote:=0A=0A> > On 02/02/2014 09:37 PM, Matthias Schneider wrote:=0A>>=A0 Hi =
all, there seems to be a race condition in the VxWorks skin in xenomai-forg=
e=0A>>=A0 when creating and deleting tasks in rapid succession. The problem=
 seems to be the=0A>>=A0 adding and removing of tasks to wind_task_list in =
task_trampoline() and=0A>>=A0 task_finalizer().=0A>> =0A>>=A0 When creating=
 a task, before returning a handle to the created task to the=0A>>=A0 appli=
cation, calling threadobj_start() from taskActivate() will wait for=0A>>=A0=
 &thobj->barrier by calling wait_on_barrier(). This condition is triggered =
from=0A>>=A0 the newly created task via task_trampoline() calling threadobj=
_prologue().=0A>>=A0 Having unblocked taskActivate(), the creating task/thr=
ead will return to the=0A>>=A0 calling application, which in turn can delet=
e the task in quick succession.=0A>>=A0 Deleting the task will trigger the =
execution of task_finalizer, which will try=0A>>=A0 to remove the task from=
 wind_task_table. However, due to specific timing=0A>>=A0 situations, it ma=
y be possible=A0 that the started task has not yet added itself=0A>>=A0 to =
the list (it may still be "just" leaving =0A>> =A0threadobj_prologue()), le=
ading to=0A>>=A0 a segmentation fault. This behavior can be easily reproduc=
ed by adding a delay=0A>>=A0 in task_trampoline() at the following location=
 in taskLib.c:=0A>> =0A>>=A0 ret =3D __bt(threadobj_prologue(&task->thobj, =
task->name));=0A>> =0A>>=A0 usleep(100000);=0A>> =0A>>=A0 write_lock_nocanc=
el(&wind_task_lock);=0A>>=A0 pvlist_append(&task->next, &wind_task_list);=
=0A>>=A0 write_unlock(&wind_task_lock);=0A>> =0A>> =0A>>=A0 writing a simpl=
e test application that simply calls=0A>> =0A>>=A0 SEM_ID tid =3D taskSpawn=
(name, 50, 0, 0, task, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);=0A>>=A0 taskDelete(ti=
d);=0A>> =0A>>=A0 will then reliably demonstrate the issue.=0A>> =0A>>=A0 M=
oving the last three lines appending the task to the list above threadobj_p=
rologue()=0A>>=A0 seems to fix the issue, although I am not 100% sure about=
 possible side effects.=0A>> =0A>>=A0 Thanks in advance for commenting my i=
ssue,=0A>>=A0 regards,=0A>> =0A> =0A> All correct, the bug bites as describ=
ed. As you suspected, simply swapping the =0A> statements would introduce a=
nother race. Could you try this patch instead? TIA,=0A> =0A> diff --git a/l=
ib/vxworks/taskLib.c b/lib/vxworks/taskLib.c=0A> index 1ef52a5..e3457a3 100=
644=0A> --- a/lib/vxworks/taskLib.c=0A> +++ b/lib/vxworks/taskLib.c=0A> @@ =
-151,9 +151,11 @@ static void task_finalizer(struct threadobj *thobj)=0A> {=
=0A> =A0=A0=A0 struct wind_task *task =3D container_of(thobj, struct wind_t=
ask, thobj);=0A> =0A> -=A0=A0=A0 write_lock_nocancel(&wind_task_lock);=0A> =
-=A0=A0=A0 pvlist_remove(&task->next);=0A> -=A0=A0=A0 write_unlock(&wind_ta=
sk_lock);=0A> +=A0=A0=A0 if (pvholder_linked(&task->next)) {=0A> +=A0=A0=A0=
 =A0=A0=A0 write_lock_nocancel(&wind_task_lock);=0A> +=A0=A0=A0 =A0=A0=A0 p=
vlist_remove(&task->next);=0A> =0A> +=A0=A0=A0 =A0=A0=A0 write_unlock(&wind=
_task_lock);=0A> +=A0=A0=A0 }=0A> =0A> =A0=A0=A0 task->tcb->status |=3D WIN=
D_DEAD;=0A> =A0=A0=A0 cluster_delobj(&wind_task_table, &task->cobj);=0A> @@=
 -356,6 +358,7 @@ static STATUS __taskInit(struct wind_task *task,=0A> =A0=
=A0=A0 idata.finalizer =3D task_finalizer;=0A> =A0=A0=A0 idata.priority =3D=
 cprio;=0A> =A0=A0=A0 threadobj_init(&task->thobj, &idata);=0A> +=A0=A0=A0 =
initpvh(&task->next);=0A> =0A> =A0=A0=A0 ret =3D __bt(cluster_addobj(&wind_=
task_table, task->name, =0A> &task->cobj));=0A> =A0=A0=A0 if (ret) {=0A> =
=0A> =0A> -- =0A> Philippe.=0A> =0A=0A=0AHi Philippe,=0A=0Athe patch seems =
to address the original problem. Should this patch be merged=0Ainto the rep=
ository?=0A=0AHowever, I seem to stumble into a different problem. If I und=
erstand correctly,=0ACANCEL_DEFER() should prevent the thread/task from bei=
ng cancelled. I have verified=0Athat pthread_setcanceltype() is being enter=
ed and the CONFIG_XENO_ASYNC_CANCEL=0Amacro has thus been set correctly. Ne=
vertheless, putting a printf after CANCEL_DEFER=0Aand before CANCEL_RESTORE=
 shows that when rapidly creating and destroying tasks=0Athe CANCEL_RESTORE=
 printf is not printed. Also, I run into a deadlock very quickly,=0Adue to =
wind_task_lock being held (consistent with the observed printf behavior).=
=0AI am using Mercury on top on an unpatched linux kernel. Any idea how I c=
an debug the=0Aapparently non-functioning pthread_setcanceltype ?=0A=0AThan=
ks in advance,=0A=0AMatthias

