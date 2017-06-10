References: <DB6PR0701MB24569CBFFA2BDB4E246360C8B5CF0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0403698a-861b-8ca3-6e7a-3582b6a84a3b@xenomai.org>
Date: Sat, 10 Jun 2017 22:02:06 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24569CBFFA2BDB4E246360C8B5CF0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_taks_bind() returns -EAGAIN for existing task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/10/2017 09:34 PM, Giulio Moro wrote:
> Hi,
> Xenomai 3.0.5 here on kernel 4.4.68-ti-xenomai-r106 on a AM3358 (BeagleBone Black).
> 
> If I create a task with `rt_task_create()`, I can then successfully bind to it using its descriptive name from within the same process that started it, e.g.:
> 
> rt_task_create(&task, task_name, 0, 40, T_JOINABLE);
> rt_task_bind(&task, task_name, TM_NONBLOCK); //this returns 0: success
> 
> But, if while this program is running (and I can see the task's stats in /proc/xenomai/sched/stat ), I start another program which tries to rt_task_bind() to the same task, the latter's call fails with `Resource temporarily unavailable(-11).`
> 
> Note that I run both programs with --enable-shared and I tried both with --skin=native and --skin=alchemy.

"native" is a pure alias to "alchemy", not to break legacy Makefiles.

> 
> Here is an example of my code: https://github.com/giuliomoro/xenomai-mode-switch-detector
> 
> This program checks if a task with a given name exists. If it does exist, it returns the number of modes switches in that task. If it does not exist, then it creates and runs the task.
> 
> I run the program once, wait for it to display "Run" (so I know the created task is active), then while I leave that running, I run another instance of the program in another terminal. I would expect the second one to successfully bind to the first one, but that is not the case (i.e.: this second instance also creates another task with the same name). I can see both running tasks in /proc/xenomai/sched/stat
> In both programs, the first call to rt_task_bind() fails with "Resource temporarily unavailable(-11)."
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
such as tasks, you need to mention --session=<some-session-label> on the
command line for both. Otherwise, each process would have its own
separate namespace, and binding requests may fail unless the object you
want to bind to was actually created by the calling process.

e.g.:

$ ./process_A --session=foo
$ ./process_B --session=foo

> A side note: it seems that calling `rt_task_bind()` causes a switch to secondary mode, as I see the MSW counter increasing for every call to it.
> 

This should not be the case in x3; you may want to run the app over gdb,
enabling the T_WARNSW flag at task creation, so that a signal will be
sent to the process when a mode switch happens. Inspecting the stack
backtrace should give us a hint about the code causing such switch.

[1]
http://xenomai.org/2015/05/application-setup-and-init/#Standard_Xenomai_command_line_options

-- 
Philippe.

