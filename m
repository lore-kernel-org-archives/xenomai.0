From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <BAY149-w569BBC6219044CB125C68BE4150@domain.hid>
References: <BAY149-w131A596DF2F2249BFEFAA3E4150@domain.hid>
	, <1292524810.1837.261.camel@domain.hid>
	<BAY149-w569BBC6219044CB125C68BE4150@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Dec 2010 10:09:47 +0100
Message-ID: <1292576987.1837.291.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and timers.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chris Stone <chris.linux@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

On Thu, 2010-12-16 at 15:30 -0400, Chris Stone wrote:
> Thanks for your reply, and I realize that I am now getting off topic
> for this list, but if the explanation is easy perhaps I could impose
> on you a little further. How does one fix the POSIX code to deal with
> this issue? When sem_timedwait() returns with ETIMEDOUT, how does one
> know that the time was changed by another task and the timeout was not
> the duration that was asked for?=20

I'm excluding small time adjustments, NTP-like, which should not be an
issue, because timeouts are not for accurate timing, but really for
implementing a safety belt against infinite hangs, so this is coarse
grained in essence. I'm talking about large arbitrary leaps forward done
using clock_settime() from an application context.

A possible answer then, is two fold:

- you likely control all the code running on your embedded platform,
which should include the task(s) issuing clock_settime(). Flagging this
particular action so that other tasks could detect it later on should be
possible. It should even be possible to exclude system time updates
using a rwlock mechanism when other tasks are about to pend on a timed
sync. Waiters would pick the read side before pending on the sync, the
task issuing clock_settime() would have to grab the write side before
changing time. In effect, this might postpone the system time update
until all waiters have either received the resource or hit a timeout
condition, but maybe this is acceptable for you.

- upon ETIMEDOUT condition, if the difference between clock_gettime()
when returning, and clock_gettime() before sleeping is preposterously
larger than the specified timeout, then the code may assume a system
time update took place, and act upon accordingly.  The cost here is one
syscall more issued unconditionally before entering the timed wait to
get the current time, but this may be acceptable as well. The grey area
is for updates in the range of the typical timeout value, you would
likely have to rely on something like the previous option instead.

>=20
> Chris.
>=20
> > Subject: Re: [Xenomai-help] Xenomai and timers.
> > From: rpm@xenomai.org
> > To: chris.linux@domain.hid
> > CC: xenomai@xenomai.org
> > Date: Thu, 16 Dec 2010 19:40:10 +0100
> >=20
> > On Thu, 2010-12-16 at 13:55 -0400, Chris Stone wrote:
> > > I am trying to determine if Xenomai will help me to solve a
> problem I
> > > am having with embedded Linux in a real time environment. To set
> the
> > > context of the problem I am trying to solve, some background is
> > > necessary.
> > >=20
> > > Our application area is telecommunications, we build cards for
> optical
> > > transport applications. We have recently transitioned from using
> Green
> > > Hills Velocity to embedded Linux as our real time operating
> system.
> > > Our applications are complex and multi-tasking and they use
> standard
> > > solutions such as semaphores to serialize access to shared data.
> In
> > > our first port of the Green Hills Velocity code to embedded Linux
> we
> > > often used sem_timedwait() to wait for a semaphore for a bounded
> > > amount of time. However, Linux appears to have an issue with
> timers
> > > when a task changes the clock with clock_settime().
> > >=20
> > > The POSIX specification for clock_settime() states that: =E2=80=9CSet=
ting
> the
> > > value of the CLOCK_REALTIME clock via clock_settime() shall have
> no
> > > effect on threads that are blocked waiting for a relative time
> service
> > > based upon this clock, including the nanosleep() function; nor on
> the
> > > expiration of relative timers based upon this clock. Consequently,
> > > these time services shall expire when the requested relative
> interval
> > > elapses, independently of the new or old value of the clock.=E2=80=9D
> > >=20
> > > Additionally, the Linux man page for clock_settime() states that:
> =E2=80=9CAll
> > > implementations support the system-wide realtime clock, which is
> > > identified by CLOCK_REALTIME. Its time represents seconds and
> > > nanoseconds since the Epoch. When its time is changed, timers for
> a
> > > relative interval are unaffected, but timers for an absolute point
> in
> > > time are affected=E2=80=9D. This indicates that the Linux implementat=
ion
> of
> > > clock_settime() follows the POSIX specification, as expected. Also
> the
> > > Linux implementation of nanosleep() uses relative timers, as
> expected.
> > >=20
> > > However, almost all Linux API functions use absolute timer
> intervals.
> > > For instance, the man page for sem_timedwait() states that the
> timeout
> > > is an absolute interval meaning that it will be affected by clock
> > > changes. Thus, if task A is blocked in a sem_timedwait() call, and
> > > task B moves time forward with clock_settime(), then task A will
> > > return from sem_timedwait() with ETIMEOUT prematurely.
> > >=20
> > > From my examination of the documentation on Xenomai, it would
> appear
> > > that Xenomai does not suffer from this problem, but I would like
> to
> > > confirm my impression. My question to this list is, in Xenomai, if
> one
> > > calls rt_sem_p() with a timeout, will that timeout be correct even
> if
> > > a task changes the clock with clock_settime()?
> > >=20
> > > Additionally, the documentation of the POSIX skin of Xenomai
> indicates
> > > that sem_timedwait() uses an absolute timeout. So, is the Xenomai
> > > version of sem_timedwait() vulnerable to clock changes? Do I have
> to
> > > use rt_sem_p() in order to avoid issues with clock changes?
> >=20
> >=20
> > Well, the POSIX behavior just makes sense, the kernel does not have
> to
> > figure out that in fact, your code is not immune to system time
> updates
> > so as to eventually consider absolute timeout specs as being
> relative
> > ones in disguise.
> >=20
> > Therefore I would not speak about vulnerability here, it is just how
> > POSIX works, because absolute timeouts do have an advantage over
> > relative timeouts. Since Xenomai's POSIX skin wants to comply with
> the
> > standard, it does resume outstanding timers which end up having a
> > trigger date in the past due to a clock_settime() request.
> >=20
> > The native Xenomai skin - which rt_sem_p is part of - has both
> relative
> > and absolute timeout forms. The relative form won't be sensitive to
> > system time updates, whilst the absolute form will. So you may want
> to
> > switch skins, or fix your POSIX code to explicitly deal with this
> issue.
> > YMMV. (I would probably fix my code actually).
> >=20
> > >=20
> > > Thanks in advance.
> > > Christopher Stone
> > > Optelian, Inc.
> > >=20
> > >=20
> > >=20
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> >=20
> > --=20
> > Philippe.
> >=20
> >=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



