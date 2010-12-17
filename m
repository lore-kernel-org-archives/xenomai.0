Message-ID: <BAY149-w447F7BB129C6D2CB3E7509E4160@domain.hid>
Content-Type: multipart/alternative;
	boundary="_123452f2-66ac-49a6-b09b-def3195846a6_"
From: Chris Stone <chris.linux@domain.hid>
Date: Fri, 17 Dec 2010 10:35:54 -0400
In-Reply-To: <1292576987.1837.291.camel@domain.hid>
References: <BAY149-w131A596DF2F2249BFEFAA3E4150@domain.hid>,,
	<1292524810.1837.261.camel@domain.hid>,
	<BAY149-w569BBC6219044CB125C68BE4150@domain.hid>,
	<1292576987.1837.291.camel@domain.hid>
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

--_123452f2-66ac-49a6-b09b-def3195846a6_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Phillipe and Gilles=2C thanks for your help=2C you guys are awesome.

Cheers=2C
    Chris.

> Subject: Re: [Xenomai-help] Xenomai and timers.
> From: rpm@xenomai.org
> To: chris.linux@domain.hid
> CC: xenomai@xenomai.org
> Date: Fri=2C 17 Dec 2010 10:09:47 +0100
>=20
> On Thu=2C 2010-12-16 at 15:30 -0400=2C Chris Stone wrote:
> > Thanks for your reply=2C and I realize that I am now getting off topic
> > for this list=2C but if the explanation is easy perhaps I could impose
> > on you a little further. How does one fix the POSIX code to deal with
> > this issue? When sem_timedwait() returns with ETIMEDOUT=2C how does one
> > know that the time was changed by another task and the timeout was not
> > the duration that was asked for?=20
>=20
> I'm excluding small time adjustments=2C NTP-like=2C which should not be a=
n
> issue=2C because timeouts are not for accurate timing=2C but really for
> implementing a safety belt against infinite hangs=2C so this is coarse
> grained in essence. I'm talking about large arbitrary leaps forward done
> using clock_settime() from an application context.
>=20
> A possible answer then=2C is two fold:
>=20
> - you likely control all the code running on your embedded platform=2C
> which should include the task(s) issuing clock_settime(). Flagging this
> particular action so that other tasks could detect it later on should be
> possible. It should even be possible to exclude system time updates
> using a rwlock mechanism when other tasks are about to pend on a timed
> sync. Waiters would pick the read side before pending on the sync=2C the
> task issuing clock_settime() would have to grab the write side before
> changing time. In effect=2C this might postpone the system time update
> until all waiters have either received the resource or hit a timeout
> condition=2C but maybe this is acceptable for you.
>=20
> - upon ETIMEDOUT condition=2C if the difference between clock_gettime()
> when returning=2C and clock_gettime() before sleeping is preposterously
> larger than the specified timeout=2C then the code may assume a system
> time update took place=2C and act upon accordingly.  The cost here is one
> syscall more issued unconditionally before entering the timed wait to
> get the current time=2C but this may be acceptable as well. The grey area
> is for updates in the range of the typical timeout value=2C you would
> likely have to rely on something like the previous option instead.
>=20
> >=20
> > Chris.
> >=20
> > > Subject: Re: [Xenomai-help] Xenomai and timers.
> > > From: rpm@xenomai.org
> > > To: chris.linux@domain.hid
> > > CC: xenomai@xenomai.org
> > > Date: Thu=2C 16 Dec 2010 19:40:10 +0100
> > >=20
> > > On Thu=2C 2010-12-16 at 13:55 -0400=2C Chris Stone wrote:
> > > > I am trying to determine if Xenomai will help me to solve a
> > problem I
> > > > am having with embedded Linux in a real time environment. To set
> > the
> > > > context of the problem I am trying to solve=2C some background is
> > > > necessary.
> > > >=20
> > > > Our application area is telecommunications=2C we build cards for
> > optical
> > > > transport applications. We have recently transitioned from using
> > Green
> > > > Hills Velocity to embedded Linux as our real time operating
> > system.
> > > > Our applications are complex and multi-tasking and they use
> > standard
> > > > solutions such as semaphores to serialize access to shared data.
> > In
> > > > our first port of the Green Hills Velocity code to embedded Linux
> > we
> > > > often used sem_timedwait() to wait for a semaphore for a bounded
> > > > amount of time. However=2C Linux appears to have an issue with
> > timers
> > > > when a task changes the clock with clock_settime().
> > > >=20
> > > > The POSIX specification for clock_settime() states that: =93Setting
> > the
> > > > value of the CLOCK_REALTIME clock via clock_settime() shall have
> > no
> > > > effect on threads that are blocked waiting for a relative time
> > service
> > > > based upon this clock=2C including the nanosleep() function=3B nor =
on
> > the
> > > > expiration of relative timers based upon this clock. Consequently=
=2C
> > > > these time services shall expire when the requested relative
> > interval
> > > > elapses=2C independently of the new or old value of the clock.=94
> > > >=20
> > > > Additionally=2C the Linux man page for clock_settime() states that:
> > =93All
> > > > implementations support the system-wide realtime clock=2C which is
> > > > identified by CLOCK_REALTIME. Its time represents seconds and
> > > > nanoseconds since the Epoch. When its time is changed=2C timers for
> > a
> > > > relative interval are unaffected=2C but timers for an absolute poin=
t
> > in
> > > > time are affected=94. This indicates that the Linux implementation
> > of
> > > > clock_settime() follows the POSIX specification=2C as expected. Als=
o
> > the
> > > > Linux implementation of nanosleep() uses relative timers=2C as
> > expected.
> > > >=20
> > > > However=2C almost all Linux API functions use absolute timer
> > intervals.
> > > > For instance=2C the man page for sem_timedwait() states that the
> > timeout
> > > > is an absolute interval meaning that it will be affected by clock
> > > > changes. Thus=2C if task A is blocked in a sem_timedwait() call=2C =
and
> > > > task B moves time forward with clock_settime()=2C then task A will
> > > > return from sem_timedwait() with ETIMEOUT prematurely.
> > > >=20
> > > > From my examination of the documentation on Xenomai=2C it would
> > appear
> > > > that Xenomai does not suffer from this problem=2C but I would like
> > to
> > > > confirm my impression. My question to this list is=2C in Xenomai=2C=
 if
> > one
> > > > calls rt_sem_p() with a timeout=2C will that timeout be correct eve=
n
> > if
> > > > a task changes the clock with clock_settime()?
> > > >=20
> > > > Additionally=2C the documentation of the POSIX skin of Xenomai
> > indicates
> > > > that sem_timedwait() uses an absolute timeout. So=2C is the Xenomai
> > > > version of sem_timedwait() vulnerable to clock changes? Do I have
> > to
> > > > use rt_sem_p() in order to avoid issues with clock changes?
> > >=20
> > >=20
> > > Well=2C the POSIX behavior just makes sense=2C the kernel does not ha=
ve
> > to
> > > figure out that in fact=2C your code is not immune to system time
> > updates
> > > so as to eventually consider absolute timeout specs as being
> > relative
> > > ones in disguise.
> > >=20
> > > Therefore I would not speak about vulnerability here=2C it is just ho=
w
> > > POSIX works=2C because absolute timeouts do have an advantage over
> > > relative timeouts. Since Xenomai's POSIX skin wants to comply with
> > the
> > > standard=2C it does resume outstanding timers which end up having a
> > > trigger date in the past due to a clock_settime() request.
> > >=20
> > > The native Xenomai skin - which rt_sem_p is part of - has both
> > relative
> > > and absolute timeout forms. The relative form won't be sensitive to
> > > system time updates=2C whilst the absolute form will. So you may want
> > to
> > > switch skins=2C or fix your POSIX code to explicitly deal with this
> > issue.
> > > YMMV. (I would probably fix my code actually).
> > >=20
> > > >=20
> > > > Thanks in advance.
> > > > Christopher Stone
> > > > Optelian=2C Inc.
> > > >=20
> > > >=20
> > > >=20
> > > > _______________________________________________
> > > > Xenomai-help mailing list
> > > > Xenomai-help@domain.hid
> > > > https://mail.gna.org/listinfo/xenomai-help
> > >=20
> > > --=20
> > > Philippe.
> > >=20
> > >=20
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

--_123452f2-66ac-49a6-b09b-def3195846a6_
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
Phillipe and Gilles=2C thanks for your help=2C you guys are awesome.<br><br=
>Cheers=2C<br>&nbsp=3B&nbsp=3B&nbsp=3B Chris.<br><br>&gt=3B Subject: Re: [X=
enomai-help] Xenomai and timers.<br>&gt=3B From: rpm@xenomai.org<br>&gt=3B =
To: chris.linux@domain.hid<br>&gt=3B CC: xenomai@xenomai.org<br>&gt=3B Da=
te: Fri=2C 17 Dec 2010 10:09:47 +0100<br>&gt=3B <br>&gt=3B On Thu=2C 2010-1=
2-16 at 15:30 -0400=2C Chris Stone wrote:<br>&gt=3B &gt=3B Thanks for your =
reply=2C and I realize that I am now getting off topic<br>&gt=3B &gt=3B for=
 this list=2C but if the explanation is easy perhaps I could impose<br>&gt=
=3B &gt=3B on you a little further. How does one fix the POSIX code to deal=
 with<br>&gt=3B &gt=3B this issue? When sem_timedwait() returns with ETIMED=
OUT=2C how does one<br>&gt=3B &gt=3B know that the time was changed by anot=
her task and the timeout was not<br>&gt=3B &gt=3B the duration that was ask=
ed for? <br>&gt=3B <br>&gt=3B I'm excluding small time adjustments=2C NTP-l=
ike=2C which should not be an<br>&gt=3B issue=2C because timeouts are not f=
or accurate timing=2C but really for<br>&gt=3B implementing a safety belt a=
gainst infinite hangs=2C so this is coarse<br>&gt=3B grained in essence. I'=
m talking about large arbitrary leaps forward done<br>&gt=3B using clock_se=
ttime() from an application context.<br>&gt=3B <br>&gt=3B A possible answer=
 then=2C is two fold:<br>&gt=3B <br>&gt=3B - you likely control all the cod=
e running on your embedded platform=2C<br>&gt=3B which should include the t=
ask(s) issuing clock_settime(). Flagging this<br>&gt=3B particular action s=
o that other tasks could detect it later on should be<br>&gt=3B possible. I=
t should even be possible to exclude system time updates<br>&gt=3B using a =
rwlock mechanism when other tasks are about to pend on a timed<br>&gt=3B sy=
nc. Waiters would pick the read side before pending on the sync=2C the<br>&=
gt=3B task issuing clock_settime() would have to grab the write side before=
<br>&gt=3B changing time. In effect=2C this might postpone the system time =
update<br>&gt=3B until all waiters have either received the resource or hit=
 a timeout<br>&gt=3B condition=2C but maybe this is acceptable for you.<br>=
&gt=3B <br>&gt=3B - upon ETIMEDOUT condition=2C if the difference between c=
lock_gettime()<br>&gt=3B when returning=2C and clock_gettime() before sleep=
ing is preposterously<br>&gt=3B larger than the specified timeout=2C then t=
he code may assume a system<br>&gt=3B time update took place=2C and act upo=
n accordingly.  The cost here is one<br>&gt=3B syscall more issued uncondit=
ionally before entering the timed wait to<br>&gt=3B get the current time=2C=
 but this may be acceptable as well. The grey area<br>&gt=3B is for updates=
 in the range of the typical timeout value=2C you would<br>&gt=3B likely ha=
ve to rely on something like the previous option instead.<br>&gt=3B <br>&gt=
=3B &gt=3B <br>&gt=3B &gt=3B Chris.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=
=3B Subject: Re: [Xenomai-help] Xenomai and timers.<br>&gt=3B &gt=3B &gt=3B=
 From: rpm@xenomai.org<br>&gt=3B &gt=3B &gt=3B To: chris.linux@domain.hid<=
br>&gt=3B &gt=3B &gt=3B CC: xenomai@xenomai.org<br>&gt=3B &gt=3B &gt=3B Da=
te: Thu=2C 16 Dec 2010 19:40:10 +0100<br>&gt=3B &gt=3B &gt=3B <br>&gt=3B &g=
t=3B &gt=3B On Thu=2C 2010-12-16 at 13:55 -0400=2C Chris Stone wrote:<br>&g=
t=3B &gt=3B &gt=3B &gt=3B I am trying to determine if Xenomai will help me =
to solve a<br>&gt=3B &gt=3B problem I<br>&gt=3B &gt=3B &gt=3B &gt=3B am hav=
ing with embedded Linux in a real time environment. To set<br>&gt=3B &gt=3B=
 the<br>&gt=3B &gt=3B &gt=3B &gt=3B context of the problem I am trying to s=
olve=2C some background is<br>&gt=3B &gt=3B &gt=3B &gt=3B necessary.<br>&gt=
=3B &gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=3B Our application ar=
ea is telecommunications=2C we build cards for<br>&gt=3B &gt=3B optical<br>=
&gt=3B &gt=3B &gt=3B &gt=3B transport applications. We have recently transi=
tioned from using<br>&gt=3B &gt=3B Green<br>&gt=3B &gt=3B &gt=3B &gt=3B Hil=
ls Velocity to embedded Linux as our real time operating<br>&gt=3B &gt=3B s=
ystem.<br>&gt=3B &gt=3B &gt=3B &gt=3B Our applications are complex and mult=
i-tasking and they use<br>&gt=3B &gt=3B standard<br>&gt=3B &gt=3B &gt=3B &g=
t=3B solutions such as semaphores to serialize access to shared data.<br>&g=
t=3B &gt=3B In<br>&gt=3B &gt=3B &gt=3B &gt=3B our first port of the Green H=
ills Velocity code to embedded Linux<br>&gt=3B &gt=3B we<br>&gt=3B &gt=3B &=
gt=3B &gt=3B often used sem_timedwait() to wait for a semaphore for a bound=
ed<br>&gt=3B &gt=3B &gt=3B &gt=3B amount of time. However=2C Linux appears =
to have an issue with<br>&gt=3B &gt=3B timers<br>&gt=3B &gt=3B &gt=3B &gt=
=3B when a task changes the clock with clock_settime().<br>&gt=3B &gt=3B &g=
t=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=3B The POSIX specification for clo=
ck_settime() states that: =93Setting<br>&gt=3B &gt=3B the<br>&gt=3B &gt=3B =
&gt=3B &gt=3B value of the CLOCK_REALTIME clock via clock_settime() shall h=
ave<br>&gt=3B &gt=3B no<br>&gt=3B &gt=3B &gt=3B &gt=3B effect on threads th=
at are blocked waiting for a relative time<br>&gt=3B &gt=3B service<br>&gt=
=3B &gt=3B &gt=3B &gt=3B based upon this clock=2C including the nanosleep()=
 function=3B nor on<br>&gt=3B &gt=3B the<br>&gt=3B &gt=3B &gt=3B &gt=3B exp=
iration of relative timers based upon this clock. Consequently=2C<br>&gt=3B=
 &gt=3B &gt=3B &gt=3B these time services shall expire when the requested r=
elative<br>&gt=3B &gt=3B interval<br>&gt=3B &gt=3B &gt=3B &gt=3B elapses=2C=
 independently of the new or old value of the clock.=94<br>&gt=3B &gt=3B &g=
t=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=3B Additionally=2C the Linux man p=
age for clock_settime() states that:<br>&gt=3B &gt=3B =93All<br>&gt=3B &gt=
=3B &gt=3B &gt=3B implementations support the system-wide realtime clock=2C=
 which is<br>&gt=3B &gt=3B &gt=3B &gt=3B identified by CLOCK_REALTIME. Its =
time represents seconds and<br>&gt=3B &gt=3B &gt=3B &gt=3B nanoseconds sinc=
e the Epoch. When its time is changed=2C timers for<br>&gt=3B &gt=3B a<br>&=
gt=3B &gt=3B &gt=3B &gt=3B relative interval are unaffected=2C but timers f=
or an absolute point<br>&gt=3B &gt=3B in<br>&gt=3B &gt=3B &gt=3B &gt=3B tim=
e are affected=94. This indicates that the Linux implementation<br>&gt=3B &=
gt=3B of<br>&gt=3B &gt=3B &gt=3B &gt=3B clock_settime() follows the POSIX s=
pecification=2C as expected. Also<br>&gt=3B &gt=3B the<br>&gt=3B &gt=3B &gt=
=3B &gt=3B Linux implementation of nanosleep() uses relative timers=2C as<b=
r>&gt=3B &gt=3B expected.<br>&gt=3B &gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B =
&gt=3B &gt=3B However=2C almost all Linux API functions use absolute timer<=
br>&gt=3B &gt=3B intervals.<br>&gt=3B &gt=3B &gt=3B &gt=3B For instance=2C =
the man page for sem_timedwait() states that the<br>&gt=3B &gt=3B timeout<b=
r>&gt=3B &gt=3B &gt=3B &gt=3B is an absolute interval meaning that it will =
be affected by clock<br>&gt=3B &gt=3B &gt=3B &gt=3B changes. Thus=2C if tas=
k A is blocked in a sem_timedwait() call=2C and<br>&gt=3B &gt=3B &gt=3B &gt=
=3B task B moves time forward with clock_settime()=2C then task A will<br>&=
gt=3B &gt=3B &gt=3B &gt=3B return from sem_timedwait() with ETIMEOUT premat=
urely.<br>&gt=3B &gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=3B From =
my examination of the documentation on Xenomai=2C it would<br>&gt=3B &gt=3B=
 appear<br>&gt=3B &gt=3B &gt=3B &gt=3B that Xenomai does not suffer from th=
is problem=2C but I would like<br>&gt=3B &gt=3B to<br>&gt=3B &gt=3B &gt=3B =
&gt=3B confirm my impression. My question to this list is=2C in Xenomai=2C =
if<br>&gt=3B &gt=3B one<br>&gt=3B &gt=3B &gt=3B &gt=3B calls rt_sem_p() wit=
h a timeout=2C will that timeout be correct even<br>&gt=3B &gt=3B if<br>&gt=
=3B &gt=3B &gt=3B &gt=3B a task changes the clock with clock_settime()?<br>=
&gt=3B &gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=3B Additionally=2C=
 the documentation of the POSIX skin of Xenomai<br>&gt=3B &gt=3B indicates<=
br>&gt=3B &gt=3B &gt=3B &gt=3B that sem_timedwait() uses an absolute timeou=
t. So=2C is the Xenomai<br>&gt=3B &gt=3B &gt=3B &gt=3B version of sem_timed=
wait() vulnerable to clock changes? Do I have<br>&gt=3B &gt=3B to<br>&gt=3B=
 &gt=3B &gt=3B &gt=3B use rt_sem_p() in order to avoid issues with clock ch=
anges?<br>&gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &=
gt=3B Well=2C the POSIX behavior just makes sense=2C the kernel does not ha=
ve<br>&gt=3B &gt=3B to<br>&gt=3B &gt=3B &gt=3B figure out that in fact=2C y=
our code is not immune to system time<br>&gt=3B &gt=3B updates<br>&gt=3B &g=
t=3B &gt=3B so as to eventually consider absolute timeout specs as being<br=
>&gt=3B &gt=3B relative<br>&gt=3B &gt=3B &gt=3B ones in disguise.<br>&gt=3B=
 &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B Therefore I would not speak about v=
ulnerability here=2C it is just how<br>&gt=3B &gt=3B &gt=3B POSIX works=2C =
because absolute timeouts do have an advantage over<br>&gt=3B &gt=3B &gt=3B=
 relative timeouts. Since Xenomai's POSIX skin wants to comply with<br>&gt=
=3B &gt=3B the<br>&gt=3B &gt=3B &gt=3B standard=2C it does resume outstandi=
ng timers which end up having a<br>&gt=3B &gt=3B &gt=3B trigger date in the=
 past due to a clock_settime() request.<br>&gt=3B &gt=3B &gt=3B <br>&gt=3B =
&gt=3B &gt=3B The native Xenomai skin - which rt_sem_p is part of - has bot=
h<br>&gt=3B &gt=3B relative<br>&gt=3B &gt=3B &gt=3B and absolute timeout fo=
rms. The relative form won't be sensitive to<br>&gt=3B &gt=3B &gt=3B system=
 time updates=2C whilst the absolute form will. So you may want<br>&gt=3B &=
gt=3B to<br>&gt=3B &gt=3B &gt=3B switch skins=2C or fix your POSIX code to =
explicitly deal with this<br>&gt=3B &gt=3B issue.<br>&gt=3B &gt=3B &gt=3B Y=
MMV. (I would probably fix my code actually).<br>&gt=3B &gt=3B &gt=3B <br>&=
gt=3B &gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=3B Thanks in advanc=
e.<br>&gt=3B &gt=3B &gt=3B &gt=3B Christopher Stone<br>&gt=3B &gt=3B &gt=3B=
 &gt=3B Optelian=2C Inc.<br>&gt=3B &gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &=
gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B &gt=
=3B _______________________________________________<br>&gt=3B &gt=3B &gt=3B=
 &gt=3B Xenomai-help mailing list<br>&gt=3B &gt=3B &gt=3B &gt=3B Xenomai-he=
lp@domain.hid<br>&gt=3B &gt=3B &gt=3B &gt=3B https://mail.gna.org/listinfo/xen=
omai-help<br>&gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B -- <br>&gt=3B &g=
t=3B &gt=3B Philippe.<br>&gt=3B &gt=3B &gt=3B <br>&gt=3B &gt=3B &gt=3B <br>=
&gt=3B &gt=3B _______________________________________________<br>&gt=3B &gt=
=3B Xenomai-help mailing list<br>&gt=3B &gt=3B Xenomai-help@domain.hid<br>&gt=
=3B &gt=3B https://mail.gna.org/listinfo/xenomai-help<br>&gt=3B <br>&gt=3B =
-- <br>&gt=3B Philippe.<br>&gt=3B <br>&gt=3B <br> 		 	   		  </body>
</html>=

--_123452f2-66ac-49a6-b09b-def3195846a6_--

