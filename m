Message-ID: <435919C8.6080906@domain.hid>
Date: Fri, 21 Oct 2005 18:39:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid>	<4357C9F7.2060808@domain.hid>	<4357CF67.8080601@domain.hid>	<4357DF0F.3060806@domain.hid>
	<435896AA.1060103@domain.hid> <4358C829.5050304@domain.hid>
In-Reply-To: <4358C829.5050304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Ok, so I took the time to delve a bit into the xenomai code to check ou=
t
> by myself how complex would it be to implement absolute timeouts. This
> is from a 1 hour walk around the code, so I'll post my thoughts so thos=
e
> truly knowledgeable can correct me.
>=20
> (BTW, here goes another praise: nice, readable, structured,
> understandable code, you know what's my reference for comparison)
>=20
> All synchronization primitive's blocking calls that take a timeout end
> up using
>=20
> xnsync_sleep_on()
>=20
> to suspend (delay, actually) the current thread. That function takes a
> relative timeout, just as passed to the blocking synchronization
> primitive call. After some magic, xsync_sleep_on() ends up calling
>=20
> xnpod_suspend_thread()
>=20
> again passign the timeout as a relative value. Eventually, the timeout
> is again passed in a call to:
>=20
> xntimer_start()
>=20
> which in turn calls xntimer_do_start_periodic() or
> xntimer_do_start_aperiodic() depending on the current timer operation
> mode. In xntimer_do_start_(a)periodic(), one can see, finally how the
> wakeup time (xntimer_t.date) is calculated from the current time and th=
e
> requested sleep interval.
>=20
> So, we timeout trail is:
>=20
> rt_mutex_lock() --> xsync_sleep_on() ---> xnpod_suspend_thread() --->
> xntimer_start() ---> xntimer_do_start_(a)periodic()
>=20
> And my assumption that internally the scheduler works with absolute
> timeouts for delayed threads is true.
>

Yes.

> Now suppose that I want to implement absolute timeouts. There are two
> alternatives:
>=20
> 1- Write an absolute timeout alter ego of every "public" function in th=
e
> native skin AND in the nucleus, except maybe for
> xntimer_do_start_(a)periodic.
>=20
> 2- Add a parmeter to every "public" function in the native skin AND in
> the nucleus which specifies if the timeout is absolute or relative.
>=20
> 3- Write an absolute timeout alter ego of every synchronization call in
> the native skin, and add a parameter in the nucleus calls to specify
> absolute/relative timeout.
>=20
> 4- Rewrite all functions that use a relatime timeout to use an absolute
> timeout.
>=20
> (1) Would mean copy&paste of code. Definitely a no-no.
>=20

Indeed.

> (2) Is very easy to implement. One downside is that, for example, the
> locking of a mutex requires three parameters when most of the time one
> would do (just the mutex). Another important downside is that it breaks
> the API of applications written over the native API.
>

No-go.

> (3) Best IMHO. Would keep the native API intact while providing all the
> absolute/relatime timeout flexibility in the nucleus.
>=20

Again, the nucleus internals are not the issue here. Actually, Xenomai 1.=
x=20
worked with both rel/abs timing modes on demand; the feature was removed =
because=20
no clear sign of usefulness went backing the decision to keep this dualit=
y at=20
that time. So let's keep this aside, there would be no problem adding the=
=20
feature at this level.

The real issue is only about extending the absolute timeout support to _a=
ll_=20
blocking primitives from the native API, or only to a single one for whic=
h there=20
exists a clear POSIX counterpart (i.e. rt_cond_wait -> pthread_cond_timed=
wait).=20
I'd like we focus on this issue instead. IOW, would rt_sem_p_abs() or=20
rt_queue_recv_abs() be of any use?

> (4) Worst IMHO. Would break the whole API, would be a nightmare to
> debug. However, I have to point out that this would probably have been
> my initial design choice. Work always with absolute timeouts, if the
> user wants a relative timeout, he should calculate it from current time=
.
> I cannot imagine a situation in which a preemption in between getting
> current time and issuing the blocking call would be undesirable. I'll
> explain:
>=20
> With the relatime timeout API, if I want this thread to wake up at
> t=3D1000, I must calculate delay as d =3D 1000 - current_time and then =
call
> rt_sem_p (or whatever). If the thread is preempted between getting
> current time and calling rt_sem_p, it will sleep for longer than desire=
d
> and will end up waking up after t=3D1000, which is what I wanted exactl=
y.
>=20
> In the absolute timeout scenatio, suppose that I want this thread to
> wake up in 100 ns. In 100 ns since when?... since current time?... then
> use the absolute timeout and you're done. Since some other operation
> like setting a digital output?, then there is anyway nothing you can do
> to prevent the possibility of being preempted in between the I/O
> operation and the actual rt_sem_p call, so why worry about that
> preemption happening in between getting current time and issuing the ca=
ll?
>=20

In any case, changing the semantics of existing calls now is the last thi=
ng we=20
should do.

> Nacho.
>=20
> P.S: Not to be a purist, but I think that functions like
> xntimer_do_start_aperiodic and xntimer_do_start_periodic should be
> declared static, since they are only to be accessed through their
> pointers in the nktimer structure.
>

Indeed, they should.

> P.S: As a side note, wouldn't be a good practice to expand tabs to
> spaces in all the code?
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

