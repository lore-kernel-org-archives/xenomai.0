Message-ID: <BAY149-w131A596DF2F2249BFEFAA3E4150@domain.hid>
Content-Type: multipart/alternative;
	boundary="_e26638d7-acbb-452f-bc90-cbfb15a68c6e_"
From: Chris Stone <chris.linux@domain.hid>
Date: Thu, 16 Dec 2010 13:55:51 -0400
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai and timers.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--_e26638d7-acbb-452f-bc90-cbfb15a68c6e_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


I am trying to determine if Xenomai will help me to solve a problem I am ha=
ving with embedded Linux in a real time environment. To set the context of =
the problem I am trying to solve=2C some background is necessary.

Our application area is telecommunications=2C we build cards for optical tr=
ansport applications. We have recently transitioned from using Green Hills =
Velocity to embedded Linux as our real time operating system. Our applicati=
ons are complex and multi-tasking and they use standard solutions such as s=
emaphores to serialize access to shared data. In our first port of the Gree=
n Hills Velocity code to embedded Linux we often used sem_timedwait() to wa=
it for a semaphore for a bounded amount of time. However=2C Linux appears t=
o have an issue with timers when a task changes the clock with clock_settim=
e().

The POSIX specification for clock_settime() states that: =93Setting the val=
ue of the CLOCK_REALTIME clock via clock_settime() shall have no effect on =
threads that are blocked waiting for a relative time service based upon thi=
s clock=2C including the nanosleep() function=3B nor on the expiration of r=
elative timers based upon this clock. Consequently=2C these time services s=
hall expire when the requested relative interval elapses=2C independently o=
f the new or old value of the clock.=94

Additionally=2C the Linux man page for clock_settime() states that: =93All =
implementations support the system-wide realtime clock=2C which is identifi=
ed by CLOCK_REALTIME. Its time represents seconds and nanoseconds since the=
 Epoch. When its time is changed=2C timers for a relative interval are unaf=
fected=2C but timers for an absolute point in time are affected=94. This in=
dicates that the Linux implementation of clock_settime() follows the POSIX =
specification=2C as expected. Also the Linux implementation of nanosleep() =
uses relative timers=2C as expected.

However=2C almost all Linux API functions use absolute timer intervals. For=
 instance=2C the man page for sem_timedwait() states that the timeout is an=
 absolute interval meaning that it will be affected by clock changes. Thus=
=2C if task A is blocked in a sem_timedwait() call=2C and task B moves time=
 forward with clock_settime()=2C then task A will return from sem_timedwait=
() with ETIMEOUT prematurely.

>From my examination of the documentation on Xenomai=2C it would appear that=
 Xenomai does not suffer from this problem=2C but I would like to confirm m=
y impression. My question to this list is=2C in Xenomai=2C if one calls rt_=
sem_p() with a timeout=2C will that timeout be correct even if a task chang=
es the clock with clock_settime()?

Additionally=2C the documentation of the POSIX skin of Xenomai indicates th=
at sem_timedwait() uses an absolute timeout. So=2C is the Xenomai version o=
f sem_timedwait() vulnerable to clock changes? Do I have to use rt_sem_p() =
in order to avoid issues with clock changes?

Thanks in advance.
Christopher Stone
Optelian=2C Inc.



 		 	   		  =

--_e26638d7-acbb-452f-bc90-cbfb15a68c6e_
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
I am trying to determine if Xenomai will help me to solve a problem I am ha=
ving with embedded Linux in a real time environment. To set the context of =
the problem I am trying to solve=2C some background is necessary.<br><br>Ou=
r application area is telecommunications=2C we build cards for optical tran=
sport applications. We have recently transitioned from using Green Hills Ve=
locity to embedded Linux as our real time operating system. Our application=
s are complex and multi-tasking and they use standard solutions such as sem=
aphores to serialize access to shared data. In our first port of the Green =
Hills Velocity code to embedded Linux we often used sem_timedwait() to wait=
 for a semaphore for a bounded amount of time. However=2C Linux appears to =
have an issue with timers when a task changes the clock with clock_settime(=
).<br><br>The POSIX specification for clock_settime() states that: =93Setti=
ng the value of the CLOCK_REALTIME clock via clock_settime() shall have no =
effect on threads that are blocked waiting for a relative time service base=
d upon this clock=2C including the nanosleep() function=3B nor on the expir=
ation of relative timers based upon this clock. Consequently=2C these time =
services shall expire when the requested relative interval elapses=2C indep=
endently of the new or old value of the clock.=94<br><br>Additionally=2C th=
e Linux man page for clock_settime() states that: =93All implementations su=
pport the system-wide realtime clock=2C which is identified by CLOCK_REALTI=
ME. Its time represents seconds and nanoseconds since the Epoch. When its t=
ime is changed=2C timers for a relative interval are unaffected=2C but time=
rs for an absolute point in time are affected=94. This indicates that the L=
inux implementation of clock_settime() follows the POSIX specification=2C a=
s expected. Also the Linux implementation of nanosleep() uses relative time=
rs=2C as expected.<br><br>However=2C almost all Linux API functions use abs=
olute timer intervals. For instance=2C the man page for sem_timedwait() sta=
tes that the timeout is an absolute interval meaning that it will be affect=
ed by clock changes. Thus=2C if task A is blocked in a sem_timedwait() call=
=2C and task B moves time forward with clock_settime()=2C then task A will =
return from sem_timedwait() with ETIMEOUT prematurely.<br><br>From my exami=
nation of the documentation on Xenomai=2C it would appear that Xenomai does=
 not suffer from this problem=2C but I would like to confirm my impression.=
 My question to this list is=2C in Xenomai=2C if one calls rt_sem_p() with =
a timeout=2C will that timeout be correct even if a task changes the clock =
with clock_settime()?<br><br>Additionally=2C the documentation of the POSIX=
 skin of Xenomai indicates that sem_timedwait() uses an absolute timeout. S=
o=2C is the Xenomai version of sem_timedwait() vulnerable to clock changes?=
 Do I have to use rt_sem_p() in order to avoid issues with clock changes?<b=
r><br>Thanks in advance.<br>Christopher Stone<br>Optelian=2C Inc.<br><br><b=
r><br> 		 	   		  </body>
</html>=

--_e26638d7-acbb-452f-bc90-cbfb15a68c6e_--

