Message-ID: <1391373420.28930.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Sun, 2 Feb 2014 20:37:00 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] race condition when creating and deleting VxWorks tasks
	in xenomai-forge
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

Hi all, there seems to be a race condition in the VxWorks skin in xenomai-f=
orge=A0=0Awhen creating and deleting tasks in rapid succession. The problem=
 seems to be the=A0=0Aadding and removing of tasks to wind_task_list in tas=
k_trampoline() and=A0=0Atask_finalizer().=0A=0AWhen creating a task, before=
 returning a handle to the created task to the=A0=0Aapplication, calling th=
readobj_start() from taskActivate() will wait for=A0=0A&thobj->barrier by c=
alling wait_on_barrier(). This condition is triggered from=A0=0Athe newly c=
reated task via task_trampoline() calling threadobj_prologue().=A0=0AHaving=
 unblocked taskActivate(), the creating task/thread will return to the=A0=
=0Acalling application, which in turn can delete the task in quick successi=
on.=A0=0ADeleting the task will trigger the execution of task_finalizer, wh=
ich will try=A0=0Ato remove the task from wind_task_table. However, due to =
specific timing=A0=0Asituations, it may be possible =A0that the started tas=
k has not yet added itself=A0=0Ato the list (it may still be "just" leaving=
 threadobj_prologue()), leading to=0Aa segmentation fault. This behavior ca=
n be easily reproduced by adding a delay=0Ain task_trampoline() at the foll=
owing location in taskLib.c:=0A=0Aret =3D __bt(threadobj_prologue(&task->th=
obj, task->name));=0A=0Ausleep(100000);=0A=0Awrite_lock_nocancel(&wind_task=
_lock);=0Apvlist_append(&task->next, &wind_task_list);=0Awrite_unlock(&wind=
_task_lock);=0A=0A=0Awriting a simple test application that simply calls=0A=
=0ASEM_ID tid =3D taskSpawn(name, 50, 0, 0, task, 0, 0, 0, 0, 0, 0, 0, 0, 0=
, 0);=0AtaskDelete(tid);=0A=0Awill then reliably demonstrate the issue.=0A=
=0AMoving the last three lines appending the task to the list above threado=
bj_prologue()=A0=0Aseems to fix the issue, although I am not 100% sure abou=
t possible side effects.=0A=0AThanks in advance for commenting my issue,=0A=
regards,=0A=0AMatthias

