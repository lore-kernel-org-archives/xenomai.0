From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sun, 11 Jun 2017 02:11:19 +0000
Message-ID: <DB6PR0701MB2456F0521C5DE7B8D4297F24B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB24569CBFFA2BDB4E246360C8B5CF0@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <0403698a-861b-8ca3-6e7a-3582b6a84a3b@xenomai.org>
In-Reply-To: <0403698a-861b-8ca3-6e7a-3582b6a84a3b@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] rt_taks_bind() returns -EAGAIN for existing task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Philippe, it makes more sense now.

> You want to use a common namespace shared between several processes.

> A bit of background first: Xenomai 3 application namespaces are
> implemented by sessions. In x3 parlance, a session is a set of one or
> more processes which cooperate, forming an application. In order for
> this cooperation to be possible, all processes which belong to a give
> session share the same central/main heap. The ability to create such
> heaps is obtained by passing --enable-pshared. With this feature, a
> real-time resource (such as a task) created by one process can be
> referred to by any other process from the same session.

> By default, a process belongs to its own - anonymous - session, unless
> the --session argument is given [1], in which case it is assigned to the
> session specified. So if you want several processes to share objects
> such as tasks, you need to mention --session=3D<some-session-label> on th=
e
> command line for both. Otherwise, each process would have its own
> separate namespace, and binding requests may fail unless the object you
> want to bind to was actually created by the calling process.

Great info, it would be good to integrate these in the main docs somewhere.=
 I had been at that URL a few times already, but the brief description of "=
session" given there is really not as complete as the one you just gave. I =
now see that "session" is mentioned twice in the task API documentation:
The task documentation, for instance, mhttp://xenomai.org/documentation/xen=
omai-3/html/xeno3prm/group__alchemy__task.html
Unfortunately, someone finding it there would struggle to link it back to t=
he command line options page and to put it in a wider context.

Perhaps a solution would be to add an "API tag" to rt_task_shadow, rt_task_=
create, rt_task_bind and all the other relevant functions (I assume there m=
ust be something also, e.g.: under pipe/queue/message/semaphore?) and add y=
our description here http://xenomai.org/documentation/xenomai-3/html/xeno3p=
rm/api-tags.html ?

Thanks,
Giulio

________________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 10 June 2017 21:02
To: Giulio Moro; xenomai@xenomai.org
Subject: Re: [Xenomai] rt_taks_bind() returns -EAGAIN for existing task

On 06/10/2017 09:34 PM, Giulio Moro wrote:
> Hi,
> Xenomai 3.0.5 here on kernel 4.4.68-ti-xenomai-r106 on a AM3358 (BeagleBo=
ne Black).
>
> If I create a task with `rt_task_create()`, I can then successfully bind =
to it using its descriptive name from within the same process that started =
it, e.g.:
>
> rt_task_create(&task, task_name, 0, 40, T_JOINABLE);
> rt_task_bind(&task, task_name, TM_NONBLOCK); //this returns 0: success
>
> But, if while this program is running (and I can see the task's stats in =
/proc/xenomai/sched/stat ), I start another program which tries to rt_task_=
bind() to the same task, the latter's call fails with `Resource temporarily=
 unavailable(-11).`
>
> Note that I run both programs with --enable-shared and I tried both with =
--skin=3Dnative and --skin=3Dalchemy.

"native" is a pure alias to "alchemy", not to break legacy Makefiles.

>
> Here is an example of my code: https://github.com/giuliomoro/xenomai-mode=
-switch-detector
>
> This program checks if a task with a given name exists. If it does exist,=
 it returns the number of modes switches in that task. If it does not exist=
, then it creates and runs the task.
>
> I run the program once, wait for it to display "Run" (so I know the creat=
ed task is active), then while I leave that running, I run another instance=
 of the program in another terminal. I would expect the second one to succe=
ssfully bind to the first one, but that is not the case (i.e.: this second =
instance also creates another task with the same name). I can see both runn=
ing tasks in /proc/xenomai/sched/stat
> In both programs, the first call to rt_task_bind() fails with "Resource t=
emporarily unavailable(-11)."
>

You want to use a common namespace shared between several processes.

A bit of background first: Xenomai 3 application namespaces are
implemented by sessions. In x3 parlance, a session is a set of one or
more processes which cooperate, forming an application. In order for
this cooperation to be possible, all processes which belong to a give
session share the same central/main heap. The ability to create such
heaps is obtained by passing --enable-pshared. With this feature, a
real-time resource (such as a task) created by one process can be
referred to by any other process from the same session.

By default, a process belongs to its own - anonymous - session, unless
the --session argument is given [1], in which case it is assigned to the
session specified. So if you want several processes to share objects
such as tasks, you need to mention --session=3D<some-session-label> on the
command line for both. Otherwise, each process would have its own
separate namespace, and binding requests may fail unless the object you
want to bind to was actually created by the calling process.

e.g.:

$ ./process_A --session=3Dfoo
$ ./process_B --session=3Dfoo

> A side note: it seems that calling `rt_task_bind()` causes a switch to se=
condary mode, as I see the MSW counter increasing for every call to it.
>

This should not be the case in x3; you may want to run the app over gdb,
enabling the T_WARNSW flag at task creation, so that a signal will be
sent to the process when a mode switch happens. Inspecting the stack
backtrace should give us a hint about the code causing such switch.

[1]
http://xenomai.org/2015/05/application-setup-and-init/#Standard_Xenomai_com=
mand_line_options

--
Philippe.

