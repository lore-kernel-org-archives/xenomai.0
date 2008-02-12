Message-ID: <47B16CA2.7010000@domain.hid>
Date: Tue, 12 Feb 2008 10:53:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] pit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I compiled the kernel for 586 and am running the PIT timer. I still get
> the 17000-18000 context switches per second, and now the irq0 handler is
> taking up 11% of the CPU instead of only 5% when the two 8000Hz tasks
> are loaded but delayed on events. I think that the problem isn=92t with
> pit, but with the tasks being periodic even though they are blocked.
>

RTAI (at least the version you used) has a single per-task internal
timer, which is not really a timer, but rather a "resume_time" field,
the RTAI core is directly testing to know whether it should wake up a
delayed task.

Therefore, if your task used to call rt_task_make_periodic() on RTAI,
then just blocked on a semaphore with no timeout value, then this task
was dequeued from the timed task list, and for that reason, no oneshot
timer ticks had to be programmed to wake it up anymore. The drawback is
that you have no timer object, independent from the task itself.
Everything has to be related to this single "resume_time" field, on a
per-task basis. This is why the RTAI core has to save and restore this
value when nesting some timed operations for instance.

Xenomai has independent timers, which also means that if you call
rt_task_set_periodic() on a task, it will arm an internal per-task timer
(thread->ptimer) which will tick independently, regardless of what your
task is currently doing. So you will have timer ticks fired for that
task, even if it is blocked on some synchro with no timeout, in which
case, the tick handler will attempt to resume the task, but since the
DELAYED+BLOCKED wait states are conjunctive, it won't be able to.

I'd suggest that you choose whether your task has to undergo a periodic
timeline or not, i.e. whether it should call rt_task_wait_period() to
wait for the next timeslot, or block on some synchronization object to
resume its processing for the current period. Using both is one too many.

> =20
>=20
> Running in PIT mode with periodic timing on uses only 9.5% of the CPU. I
> show about 9000 context switches per second. (the 2 8000 hz tasks and
> the 1000 hz linux interrupt.)
>=20
> =20
>=20
> With periodic timing, it=92s 5.4% when the tasks idle and about 9000
> context switches a second. When one of them becomes active, the irq0
> handler is using 10% of the CPU and the sound task is using about 8%.
> These are two kernel tasks.
>=20
> =20
>=20
> Userspace stack size is set to 64k. I forgot to mention this to Philippe
> earlier.
>=20
> =20
>=20
> Perhaps the problem is the overhead that the timer handler introduces
> being able to support multiple skins with individual timebases. It
> sounds like in order to save some cpu cycles, I may want to turn off
> periodicity while threads are idle and also avoid setting threads
> periodic when they can be driven some other way.
>=20
> =20
>=20
> Steven
>=20
> =20
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

