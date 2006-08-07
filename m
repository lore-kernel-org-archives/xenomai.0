Date: Mon, 07 Aug 2006 16:42:56 +0200
Message-Id: <1903864415@domain.hid>
MIME-Version: 1.0
From: Steve Kreyer <steve.kreyer@domain.hid>
Subject: Re: [Xenomai-help] Problems with rt_task_wait_period
Content-Type: text/plain; charset=iso-8859-15
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Ok problem fixed,

the last email was a typo by me :)
If I increase the period to 1000 ns I get a system crash, when its 1us the=
 task work like expected.
But what does explain the System crash if the period is around 1000 ns=3F

Thanks=20

Steve
-----Urspr=FCngliche Nachricht-----
Von: rpm@xenomai.org
Gesendet: 07.08.06 16:32:17
An: Jan Kiszka <jan.kiszka@domain.hid>
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] Problems with rt=5Ftask=5Fwait=5Fperiod


On Mon, 2006-08-07 at 16:17 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2006-08-07 at 15:45 +0200, Jan Kiszka wrote:
> >> Steve Kreyer wrote:
> >>> Hi,
> >>>
> >>> Iam new to xenomai.=20
> >>> For warming up I try to run this little test program:
> >>>
> >>> --------------------------------------------------------------------=
---
> >>> #include <native/task.h>
> >>> #include <stdio.h>
> >>> #include <sys/mman.h>
> >>>
> >>> RT=5FTASK task1;
> >>>
> >>> void rt=5Ftask1(void* user=5Fdata){
> >>>     int err =3D 0;
> >>>     printf("%d\n", rt=5Ftask=5Fset=5Fperiodic(NULL, TM=5FNOW, 100));
> >> You are running in one-shot mode, thus all time units are in
> >> *nanoseconds*. 100 ns cycles tend to pass quite quickly, thus the set=
up
> >> actually fails (but it doesn't report this - a corner case for
> >> considering this a bug).
> >=20
> > The setup does not really fail, but the period is so short that the ti=
ck
> > occurs before the task has a chance to wait for the first release poin=
t
> > in the timeline, so rt=5Ftask=5Fwait=5Fperiod() notices that no timer is
> > outstanding, but incorrectly concludes that no timer was ever armed.
>=20
> Mmh, wouldn't the box simply lock up if the setup succeeded=3F It's a
> periodic timer... :->

No it would not, because of the first test in xnpod=5Fwait=5Fthread=5Fperiod()
that checks if the timer is still enqueued, and because the application
properly tests the return value. Actually, using an additional flag to
state that a timer has indeed been started would be better than
recycling the enqueuing bit for the purpose of testing the timer
validity. An elapsed timer is still a valid one.

>=20
> Jan
>=20
--=20
Philippe.




=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=

Erweitern Sie FreeMail zu einem noch leistungsst=E4rkeren E-Mail-Postfach!	=09
Mehr Infos unter http://freemail.web.de/home/landingpad/=3Fmc=3D021131


