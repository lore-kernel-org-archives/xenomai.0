From: "Christopher Stone" <chris@domain.hid>
Subject: RE: [Xenomai-help] help with using alarams
Date: Sun, 7 May 2006 12:15:37 -0400
Message-ID: <001601c671f1$7ae3e310$a10a10ac@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <445C34C100012AEC@n016.sc0.cp.net> (added
	bypostmaster@domain.hid)
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

Is this the actual code you are using? It looks like pseudo code to me.
Please do not post pseudo or sample code, post the actual code you are
using, and then we can help you.

If this is the actual code then I can see these problems:
1) if (condition met) is not good programming because the actual =
condition
is hidden by the definitions of 'condition' and 'met', which makes the
program too hard to read. I would replace this with the actual condition =
you
are testing.
2) alarm_handler is never called from the main program. Thus, the while
statement is an infinite loop.

Cheers,
   Chris.

----------------------------------------
Christopher Stone
Principal
Sombrio Systems Inc.
www.openembedded.biz
613-831-1892

> -----Original Message-----
> From: Prashanti Bedapudi [mailto:pbedapudi@domain.hid]
> Sent: May 6, 2006 10:30 PM
> To: xenomai@xenomai.org
> Subject: [Xenomai-help] help with using alarams
>=20
> Hi,
> I am new to xenomai and linux. I am having some problems with alarms. =
Here
> is a sample piece of code that I am using.
> If you look at the main function, I have a while(!quit_now)=A0 and I =
am
> setting this flag in the alarm_handler. I am seeing some weird =
results.
> When
> I have a printf statement in the while(!quit_now) loop as I have =
below, it
> works as expected and the program terminates when the quit_flag is =
set.
> But
> if I remove the printf() the program never terminates, it just hangs, =
even
> if the quit_now flag is set.
> Any insight into this problem will be greatly appreciated.
>=20
> I posted this message 2 days ago..but I got a reply with message =
saying
> 'HTML attachment has been scrubbed'. Not sure what that meant, so I am
> posting it again..
>=20
>=20
> alarm_handler()
> {
> =A0=A0=A0=A0=A0=A0=A0 for(;;)
> =A0=A0=A0=A0=A0=A0=A0 {
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0 rt_alarm_wait();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0 do_processing();
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0 if(condition met)
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0 {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 quit_now =3D TRUE;=A0 /* =
global variable */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0 }
> }
>=20
> main()
> {
> =A0=A0=A0=A0=A0=A0=A0 rt_alarm_create;
> =A0=A0=A0=A0=A0=A0=A0 rt_task_spawn();
> =A0=A0=A0=A0=A0=A0=A0 rt_alarm_start();
>=20
> =A0=A0=A0=A0=A0=A0=A0 while(!quit_now)
> =A0=A0=A0=A0=A0=A0=A0 =A0 printf("Inside while\n");
> }
>=20
>=20
>=20
>=20
> thanks in advance,
> Shanti
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20




