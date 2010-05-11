Date: Tue, 11 May 2010 16:26:53 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100511142653.GA22374@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Scheduling clarification/solution...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

having done some tests and having read the thread
https://mail.gna.org/public/xenomai-help/2010-04/msg00051.html 
i got the following understanding:

1. Xenomai tasks can be in the state RT and non-RT (relaxed).
   That means: If in RT state, it's scheduled by the Xenomai
   scheduler and if in non-RT state it's scheduled by the
   Linux scheduler.

2. After a Xeno-task did a Linux-Systemcall, e.g. getpid(),
   it will be in non-RT state, raising the Xeno-Root task
   to the priority of Xeno-task (setup by rt_task_shadow()).
   Clearing T_RPIOFF with rt_task_set_mode() disables raising
   priority of the Xeno-Root task when the task is migrating
   from Xenomai RT to Linux non-RT state.

   The Linux scheduler priority of a shadowed Xeno task in
   non-RT state is not touched when migrating from RT -> non-RT.
   Linux scheduling policy and priority depend only on calls
   to sched_setscheduler() pthread_setschedparam() and similar
   Linux/Posix calls. (on the other side Linux/Posix calls
   does not control priority when in RT xenomai state).

   Lazy switching means, that this non-RT Xeno-task will stay
   scheduled by the Linux scheduler until the next Xenomai rt-call.
   This implies, that it may be blocked by other non-RT or
   plain Linux tasks of higher Linux priorities by the
   Linux scheduler while in non-RT state.

3. After a Xeno-task did a Xenomai-Call, e.g. rt-driver call
   or rt_mutex_acquire(), it will be in RT state, scheduled
   by the Xenomai scheduler.

   Lazy switching means, that this RT task will stay scheduled
   by the Xenomai scheduler until the next Linux-System call.

We want a setup with 3 xenomai-shadowed tasks:

  - RT-Task: Running in high priority RT context
  	(Xenomai scheduler, low latency high prio)

  - Cyclic-Task: Running in non-RT context
	(Linux scheduler, prio 0 equal to system services)

  - Background-Task: Running in non-RT context
  	(Linux scheduler, low/IDLE prio)

All of them may acquire shared rt-mutices, which is the reason
for shadowing Cyclic- and Background-task (plain Linux tasks are not
able to acquire an RT-mutex). What we need is:

1. When Cyclic-/Background-task acquires an RT-mutex it migrates
   from Linux to Xenomai scheduler. When releasing the mutex,
   the task should be forced to migrate back to Linux scheduler.

   How to achieve that?

   By calling Linux-Syscall getpid()?

   Is there a Xenomai flag (rt_task_set_mode()) doing that automatically,
   after all RT-resources are released? Which version 2.4.10/2.5.x?

   Do we have to use the patch mentioned in the thread?

2. If Background-task acquires an RT-mutex and is interrupted by RT-task,
   which tries to acquire the same mutex, background inherits RT-tasks
   priority in Xenomai RT context. When background calls to Linux in this
   state, Xenomai-Root task gets RT-task's priority (priority coupling),
   but, because background is scheduled by Linux scheduler now,
   it may be blocked by other non-RT threads running with higher
   Linux priority (e.g. while(1) in cyclic). Is there a method
   in Xenomai to inherit Xenomai-priority to the Linux-scheduler
   settings of a task while the task holds RT resources?

   Is it possible to detect if an RT task calls to Linux while
   holding some RT resources? E.g. a SIGXPU (like for T_WARNSW)
   dependent on acquired RT resources?

   I assume/conclude: While holding RT resources a task must not switch
   to secondary domain. If so, we move control to the Linux scheduler
   loosing RT capabilities. Right?

Best regards and thanks,

	Olli


