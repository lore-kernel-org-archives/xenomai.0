Date: Mon, 07 Aug 2006 16:34:51 +0200
Message-Id: <1903846164@domain.hid>
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

Hi,

thanks for your answers that sounds plausible to me :)
But another problem arises:
If I inrease the period from 100 to 1000000 ns in the posted program, I ge=
t a system crash :)

Regards,

Steve

-----Urspr=FCngliche Nachricht-----
Von: rpm@xenomai.org
Gesendet: 07.08.06 16:13:39
An: Jan Kiszka <jan.kiszka@domain.hid>
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] Problems with rt=5Ftask=5Fwait=5Fperiod


On Mon, 2006-08-07 at 15:45 +0200, Jan Kiszka wrote:
> Steve Kreyer wrote:
> > Hi,
> >=20
> > Iam new to xenomai.=20
> > For warming up I try to run this little test program:
> >=20
> > ----------------------------------------------------------------------=
-
> > #include <native/task.h>
> > #include <stdio.h>
> > #include <sys/mman.h>
> >=20
> > RT=5FTASK task1;
> >=20
> > void rt=5Ftask1(void* user=5Fdata){
> >     int err =3D 0;
> >     printf("%d\n", rt=5Ftask=5Fset=5Fperiodic(NULL, TM=5FNOW, 100));
>=20
> You are running in one-shot mode, thus all time units are in
> *nanoseconds*. 100 ns cycles tend to pass quite quickly, thus the setup
> actually fails (but it doesn't report this - a corner case for
> considering this a bug).

The setup does not really fail, but the period is so short that the tick
occurs before the task has a chance to wait for the first release point
in the timeline, so rt=5Ftask=5Fwait=5Fperiod() notices that no timer is
outstanding, but incorrectly concludes that no timer was ever armed.

>=20
> >     err =3D rt=5Ftask=5Fwait=5Fperiod(NULL);
> >     if(err){
> >         fprintf(stderr, "Cannot wait periodic: %d, %d\n", err, EWOULDB=
LOCK);
> >=20
> >     }
> > }
> >=20
> > int main(){
> >     char* task1=5Fdata =3D NULL;
> >     mlockall(MCL=5FCURRENT|MCL=5FFUTURE);
> >     rt=5Ftimer=5Fset=5Fmode(TM=5FONESHOT);
> >     rt=5Ftask=5Fspawn(&task1, "task1", 0, 99, 0, rt=5Ftask1, &task1=5Fdata);
> >     sleep(10);
> >     rt=5Ftask=5Fdelete(&task1);
> >     return 0;
> > }
> > ----------------------------------------------------------------------=
-
> >=20
> > But rt=5Ftask=5Fwait=5Fperiod gives me always the Error EWOULDBLOCK, which m=
eans that I did not set the task periodic
> > but which in fact I did... The call to rt=5Ftask=5Fset=5Fperiodic is succesf=
ul.
> > Can anyone help me figure out why=3F If you need additional infos please=
 let me know...
> >=20
> > Thanks in advance!
> >=20
> > Steve
> >=20
>=20
> Jan
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.




=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=

Erweitern Sie FreeMail zu einem noch leistungsst=E4rkeren E-Mail-Postfach!	=09
Mehr Infos unter http://freemail.web.de/home/landingpad/=3Fmc=3D021131


