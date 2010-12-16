Message-ID: <BAY149-w569BBC6219044CB125C68BE4150@domain.hid>
Content-Type: multipart/alternative;
	boundary="_5d68e3b7-3661-4885-a687-fe0d4ddc7dda_"
From: Chris Stone <chris.linux@domain.hid>
Date: Thu, 16 Dec 2010 15:30:47 -0400
In-Reply-To: <1292524810.1837.261.camel@domain.hid>
References: <BAY149-w131A596DF2F2249BFEFAA3E4150@domain.hid>,
	<1292524810.1837.261.camel@domain.hid>
MIME-Version: 1.0
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
To: Xenomai Help <xenomai@xenomai.org>

--_5d68e3b7-3661-4885-a687-fe0d4ddc7dda_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Thanks for your reply=2C and I realize that I am now getting off topic for =
this list=2C but if the explanation is easy perhaps I could impose on you a=
 little further. How does one fix the POSIX code to deal with this issue? W=
hen sem_timedwait() returns with ETIMEDOUT=2C how does one know that the ti=
me was changed by another task and the timeout was not the duration that wa=
s asked for?=20

Chris.

> Subject: Re: [Xenomai-help] Xenomai and timers.
> From: rpm@xenomai.org
> To: chris.linux@domain.hid
> CC: xenomai@xenomai.org
> Date: Thu=2C 16 Dec 2010 19:40:10 +0100
>=20
> On Thu=2C 2010-12-16 at 13:55 -0400=2C Chris Stone wrote:
> > I am trying to determine if Xenomai will help me to solve a problem I
> > am having with embedded Linux in a real time environment. To set the
> > context of the problem I am trying to solve=2C some background is
> > necessary.
> >=20
> > Our application area is telecommunications=2C we build cards for optica=
l
> > transport applications. We have recently transitioned from using Green
> > Hills Velocity to embedded Linux as our real time operating system.
> > Our applications are complex and multi-tasking and they use standard
> > solutions such as semaphores to serialize access to shared data. In
> > our first port of the Green Hills Velocity code to embedded Linux we
> > often used sem_timedwait() to wait for a semaphore for a bounded
> > amount of time. However=2C Linux appears to have an issue with timers
> > when a task changes the clock with clock_settime().
> >=20
> > The POSIX specification for clock_settime() states that: =93Setting the
> > value of the CLOCK_REALTIME clock via clock_settime() shall have no
> > effect on threads that are blocked waiting for a relative time service
> > based upon this clock=2C including the nanosleep() function=3B nor on t=
he
> > expiration of relative timers based upon this clock. Consequently=2C
> > these time services shall expire when the requested relative interval
> > elapses=2C independently of the new or old value of the clock.=94
> >=20
> > Additionally=2C the Linux man page for clock_settime() states that: =93=
All
> > implementations support the system-wide realtime clock=2C which is
> > identified by CLOCK_REALTIME. Its time represents seconds and
> > nanoseconds since the Epoch. When its time is changed=2C timers for a
> > relative interval are unaffected=2C but timers for an absolute point in
> > time are affected=94. This indicates that the Linux implementation of
> > clock_settime() follows the POSIX specification=2C as expected. Also th=
e
> > Linux implementation of nanosleep() uses relative timers=2C as expected=
.
> >=20
> > However=2C almost all Linux API functions use absolute timer intervals.
> > For instance=2C the man page for sem_timedwait() states that the timeou=
t
> > is an absolute interval meaning that it will be affected by clock
> > changes. Thus=2C if task A is blocked in a sem_timedwait() call=2C and
> > task B moves time forward with clock_settime()=2C then task A will
> > return from sem_timedwait() with ETIMEOUT prematurely.
> >=20
> > From my examination of the documentation on Xenomai=2C it would appear
> > that Xenomai does not suffer from this problem=2C but I would like to
> > confirm my impression. My question to this list is=2C in Xenomai=2C if =
one
> > calls rt_sem_p() with a timeout=2C will that timeout be correct even if
> > a task changes the clock with clock_settime()?
> >=20
> > Additionally=2C the documentation of the POSIX skin of Xenomai indicate=
s
> > that sem_timedwait() uses an absolute timeout. So=2C is the Xenomai
> > version of sem_timedwait() vulnerable to clock changes? Do I have to
> > use rt_sem_p() in order to avoid issues with clock changes?
>=20
>=20
> Well=2C the POSIX behavior just makes sense=2C the kernel does not have t=
o
> figure out that in fact=2C your code is not immune to system time updates
> so as to eventually consider absolute timeout specs as being relative
> ones in disguise.
>=20
> Therefore I would not speak about vulnerability here=2C it is just how
> POSIX works=2C because absolute timeouts do have an advantage over
> relative timeouts. Since Xenomai's POSIX skin wants to comply with the
> standard=2C it does resume outstanding timers which end up having a
> trigger date in the past due to a clock_settime() request.
>=20
> The native Xenomai skin - which rt_sem_p is part of - has both relative
> and absolute timeout forms. The relative form won't be sensitive to
> system time updates=2C whilst the absolute form will. So you may want to
> switch skins=2C or fix your POSIX code to explicitly deal with this issue=
.
> YMMV. (I would probably fix my code actually).
>=20
> >=20
> > Thanks in advance.
> > Christopher Stone
> > Optelian=2C Inc.
> >=20
> >=20
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20
> --=20
> Philippe.
>=20
>=20
 		 	   		  =

--_5d68e3b7-3661-4885-a687-fe0d4ddc7dda_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
Thanks for your reply=2C and I realize that I am now getting off topic for =
this list=2C but if the explanation is easy perhaps I could impose on you a=
 little further. How does one fix the POSIX code to deal with this issue? W=
hen sem_timedwait() returns with ETIMEDOUT=2C how does one know that the ti=
me was changed by another task and the timeout was not the duration that wa=
s asked for? <br><br>Chris.<br><br>&gt=3B Subject: Re: [Xenomai-help] Xenom=
ai and timers.<br>&gt=3B From: rpm@xenomai.org<br>&gt=3B To: chris.linux@domain.hid=
tmail.com<br>&gt=3B CC: xenomai@xenomai.org<br>&gt=3B Date: Thu=2C 16 Dec =
2010 19:40:10 +0100<br>&gt=3B <br>&gt=3B On Thu=2C 2010-12-16 at 13:55 -040=
0=2C Chris Stone wrote:<br>&gt=3B &gt=3B I am trying to determine if Xenoma=
i will help me to solve a problem I<br>&gt=3B &gt=3B am having with embedde=
d Linux in a real time environment. To set the<br>&gt=3B &gt=3B context of =
the problem I am trying to solve=2C some background is<br>&gt=3B &gt=3B nec=
essary.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Our application area is telecomm=
unications=2C we build cards for optical<br>&gt=3B &gt=3B transport applica=
tions. We have recently transitioned from using Green<br>&gt=3B &gt=3B Hill=
s Velocity to embedded Linux as our real time operating system.<br>&gt=3B &=
gt=3B Our applications are complex and multi-tasking and they use standard<=
br>&gt=3B &gt=3B solutions such as semaphores to serialize access to shared=
 data. In<br>&gt=3B &gt=3B our first port of the Green Hills Velocity code =
to embedded Linux we<br>&gt=3B &gt=3B often used sem_timedwait() to wait fo=
r a semaphore for a bounded<br>&gt=3B &gt=3B amount of time. However=2C Lin=
ux appears to have an issue with timers<br>&gt=3B &gt=3B when a task change=
s the clock with clock_settime().<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B The PO=
SIX specification for clock_settime() states that: =93Setting the<br>&gt=3B=
 &gt=3B value of the CLOCK_REALTIME clock via clock_settime() shall have no=
<br>&gt=3B &gt=3B effect on threads that are blocked waiting for a relative=
 time service<br>&gt=3B &gt=3B based upon this clock=2C including the nanos=
leep() function=3B nor on the<br>&gt=3B &gt=3B expiration of relative timer=
s based upon this clock. Consequently=2C<br>&gt=3B &gt=3B these time servic=
es shall expire when the requested relative interval<br>&gt=3B &gt=3B elaps=
es=2C independently of the new or old value of the clock.=94<br>&gt=3B &gt=
=3B <br>&gt=3B &gt=3B Additionally=2C the Linux man page for clock_settime(=
) states that: =93All<br>&gt=3B &gt=3B implementations support the system-w=
ide realtime clock=2C which is<br>&gt=3B &gt=3B identified by CLOCK_REALTIM=
E. Its time represents seconds and<br>&gt=3B &gt=3B nanoseconds since the E=
poch. When its time is changed=2C timers for a<br>&gt=3B &gt=3B relative in=
terval are unaffected=2C but timers for an absolute point in<br>&gt=3B &gt=
=3B time are affected=94. This indicates that the Linux implementation of<b=
r>&gt=3B &gt=3B clock_settime() follows the POSIX specification=2C as expec=
ted. Also the<br>&gt=3B &gt=3B Linux implementation of nanosleep() uses rel=
ative timers=2C as expected.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B However=2C =
almost all Linux API functions use absolute timer intervals.<br>&gt=3B &gt=
=3B For instance=2C the man page for sem_timedwait() states that the timeou=
t<br>&gt=3B &gt=3B is an absolute interval meaning that it will be affected=
 by clock<br>&gt=3B &gt=3B changes. Thus=2C if task A is blocked in a sem_t=
imedwait() call=2C and<br>&gt=3B &gt=3B task B moves time forward with cloc=
k_settime()=2C then task A will<br>&gt=3B &gt=3B return from sem_timedwait(=
) with ETIMEOUT prematurely.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B From my exa=
mination of the documentation on Xenomai=2C it would appear<br>&gt=3B &gt=
=3B that Xenomai does not suffer from this problem=2C but I would like to<b=
r>&gt=3B &gt=3B confirm my impression. My question to this list is=2C in Xe=
nomai=2C if one<br>&gt=3B &gt=3B calls rt_sem_p() with a timeout=2C will th=
at timeout be correct even if<br>&gt=3B &gt=3B a task changes the clock wit=
h clock_settime()?<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Additionally=2C the d=
ocumentation of the POSIX skin of Xenomai indicates<br>&gt=3B &gt=3B that s=
em_timedwait() uses an absolute timeout. So=2C is the Xenomai<br>&gt=3B &gt=
=3B version of sem_timedwait() vulnerable to clock changes? Do I have to<br=
>&gt=3B &gt=3B use rt_sem_p() in order to avoid issues with clock changes?<=
br>&gt=3B <br>&gt=3B <br>&gt=3B Well=2C the POSIX behavior just makes sense=
=2C the kernel does not have to<br>&gt=3B figure out that in fact=2C your c=
ode is not immune to system time updates<br>&gt=3B so as to eventually cons=
ider absolute timeout specs as being relative<br>&gt=3B ones in disguise.<b=
r>&gt=3B <br>&gt=3B Therefore I would not speak about vulnerability here=2C=
 it is just how<br>&gt=3B POSIX works=2C because absolute timeouts do have =
an advantage over<br>&gt=3B relative timeouts. Since Xenomai's POSIX skin w=
ants to comply with the<br>&gt=3B standard=2C it does resume outstanding ti=
mers which end up having a<br>&gt=3B trigger date in the past due to a cloc=
k_settime() request.<br>&gt=3B <br>&gt=3B The native Xenomai skin - which r=
t_sem_p is part of - has both relative<br>&gt=3B and absolute timeout forms=
. The relative form won't be sensitive to<br>&gt=3B system time updates=2C =
whilst the absolute form will. So you may want to<br>&gt=3B switch skins=2C=
 or fix your POSIX code to explicitly deal with this issue.<br>&gt=3B YMMV.=
 (I would probably fix my code actually).<br>&gt=3B <br>&gt=3B &gt=3B <br>&=
gt=3B &gt=3B Thanks in advance.<br>&gt=3B &gt=3B Christopher Stone<br>&gt=
=3B &gt=3B Optelian=2C Inc.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &=
gt=3B <br>&gt=3B &gt=3B _______________________________________________<br>=
&gt=3B &gt=3B Xenomai-help mailing list<br>&gt=3B &gt=3B Xenomai-help@domain.hid=
rg<br>&gt=3B &gt=3B https://mail.gna.org/listinfo/xenomai-help<br>&gt=3B <b=
r>&gt=3B -- <br>&gt=3B Philippe.<br>&gt=3B <br>&gt=3B <br> 		 	   		  </bod=
y>
</html>=

--_5d68e3b7-3661-4885-a687-fe0d4ddc7dda_--

