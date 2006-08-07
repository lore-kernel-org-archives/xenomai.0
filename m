Subject: Re: [Xenomai-help] Problems with rt_task_wait_period
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1903864415@domain.hid>
References: <1903864415@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 07 Aug 2006 17:32:28 +0200
Message-Id: <1154964748.4322.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Mon, 2006-08-07 at 16:42 +0200, Steve Kreyer wrote:
> Ok problem fixed,
>=20
> the last email was a typo by me :)
> If I increase the period to 1000 ns I get a system crash, when its 1us =
the task work like expected.

There's likely another typo here.

> But what does explain the System crash if the period is around 1000 ns?
>=20

The bottom line is that, if the period is short enough, the timer code
ends up programming timer ticks way too often for the box to be able to
handle any other work than the one managing the timers... So this causes
a lock up (not necessarily a crash since there is no kernel exception
going on, only too much work for too little cpu time).

> Thanks=20
>=20
> Steve
> -----Urspr=FCngliche Nachricht-----
> Von: rpm@xenomai.org
> Gesendet: 07.08.06 16:32:17
> An: Jan Kiszka <jan.kiszka@domain.hid>
> CC: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Problems with rt_task_wait_period
>=20
>=20
> On Mon, 2006-08-07 at 16:17 +0200, Jan Kiszka wrote:
> > Philippe Gerum wrote:
> > > On Mon, 2006-08-07 at 15:45 +0200, Jan Kiszka wrote:
> > >> Steve Kreyer wrote:
> > >>> Hi,
> > >>>
> > >>> Iam new to xenomai.=20
> > >>> For warming up I try to run this little test program:
> > >>>
> > >>> -----------------------------------------------------------------=
------
> > >>> #include <native/task.h>
> > >>> #include <stdio.h>
> > >>> #include <sys/mman.h>
> > >>>
> > >>> RT_TASK task1;
> > >>>
> > >>> void rt_task1(void* user_data){
> > >>>     int err =3D 0;
> > >>>     printf("%d\n", rt_task_set_periodic(NULL, TM_NOW, 100));
> > >> You are running in one-shot mode, thus all time units are in
> > >> *nanoseconds*. 100 ns cycles tend to pass quite quickly, thus the =
setup
> > >> actually fails (but it doesn't report this - a corner case for
> > >> considering this a bug).
> > >=20
> > > The setup does not really fail, but the period is so short that the=
 tick
> > > occurs before the task has a chance to wait for the first release p=
oint
> > > in the timeline, so rt_task_wait_period() notices that no timer is
> > > outstanding, but incorrectly concludes that no timer was ever armed=
.
> >=20
> > Mmh, wouldn't the box simply lock up if the setup succeeded? It's a
> > periodic timer... :->
>=20
> No it would not, because of the first test in xnpod_wait_thread_period(=
)
> that checks if the timer is still enqueued, and because the application
> properly tests the return value. Actually, using an additional flag to
> state that a timer has indeed been started would be better than
> recycling the enqueuing bit for the purpose of testing the timer
> validity. An elapsed timer is still a valid one.
>=20
> >=20
> > Jan
> >=20
--=20
Philippe.



