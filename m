Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Feb 2008 06:20:43 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B4C@slcmail.slc.mew.int>
In-Reply-To: <47B16CA2.7010000@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
	<47B16CA2.7010000@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] pit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> RTAI (at least the version you used) has a single per-task internal
> timer, which is not really a timer, but rather a "resume_time" field,
> the RTAI core is directly testing to know whether it should wake up a
> delayed task.
>=20
> Therefore, if your task used to call rt_task_make_periodic() on RTAI,
> then just blocked on a semaphore with no timeout value, then this task
> was dequeued from the timed task list, and for that reason, no oneshot
> timer ticks had to be programmed to wake it up anymore. The drawback
is
> that you have no timer object, independent from the task itself.
> Everything has to be related to this single "resume_time" field, on a
> per-task basis. This is why the RTAI core has to save and restore this
> value when nesting some timed operations for instance.
>=20
> Xenomai has independent timers, which also means that if you call
> rt_task_set_periodic() on a task, it will arm an internal per-task
timer
> (thread->ptimer) which will tick independently, regardless of what
your
> task is currently doing. So you will have timer ticks fired for that
> task, even if it is blocked on some synchro with no timeout, in which
> case, the tick handler will attempt to resume the task, but since the
> DELAYED+BLOCKED wait states are conjunctive, it won't be able to.
>=20
> I'd suggest that you choose whether your task has to undergo a
periodic
> timeline or not, i.e. whether it should call rt_task_wait_period() to
> wait for the next timeslot, or block on some synchronization object to
> resume its processing for the current period. Using both is one too
many.
>=20

Hi Philippe. Thanks for your explanation. I have made a change to the
sound driver to remove the task periodic timer before waiting on a
synchronization object. The effect is that irq0 doesn't do as much work
unless the tasks are running. In the case of my high-load tasks, one
runs at a variable period (motor ramp-up/ramp-down control) and the
other runs every 2ms to take a couple A/D measurements. The problem is
that these two tasks running together take up too many resources. If the
measurement task runs every 3 ms, then it works fine. ROOT only has
about 20% of the CPU left to it. I will point out that I noticed worse
results when having the variable (faster) period task signal a cond for
the other one to run (which is at a lower priority!) than I did having
them both set periodic.=20

As I stated in a previous email, I'm starting to suspect the latencies
in syscalls as the source of my problem.

By the way, I enabled periodic timing again and had used
rt_timer_set_mode(125000) and I notice better performance in terms of
the irq0 handler under load. I think maybe this is due to the number of
threads running and, as Jan suggested, the simultaneous start date.

Steven


