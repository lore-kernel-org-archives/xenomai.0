Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A58A.17CA908E"
Date: Wed, 23 Apr 2008 17:36:30 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F20@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid><18446.32522.986935.299094@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid><2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid><2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid><18447.31623.723753.421351@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A58A.17CA908E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gilles,

thank you for your information about this-- I guess the handling of all =
error reporting, writing to disk, etc has to be handled in another =
thread.  In terms of priorities, should I set the serial task to have a =
priority of 99?  I was also advised to make a smaller buffer to flush =
data to disk. I'm currently using the defaults which might be a large =
cached buffer.  If I flush data to disk at regular intervals I can lower =
blockages.  Nonetheless, the writing to disk is a data-logging task and =
could be moved out of the RT-Task, leaving only the capture of data and =
processing of packets in the RT Task.  I assume tools like hdparm (which =
unmask serial interrupts) have no place in the xenomai world, right?

Take care,

Joshua Karch




Karch, Joshua wrote:
 >=20
 > Gilles,
 >=20
 > I decided to eliminate the pthread and create a task that handles the =
entire packet process, from reading the serial port, to decoding data, =
to disk io (saving the data to disk)  The only thing that's serviced =
occasionally is the main loop, which looks every half second for a =
keypress to quit.
 >=20
 > Now, I get overrun errors once every 10 seconds to 30 seconds.  The =
machine is a PC/104 and I'm using fprintf to print the data received =
from the sensor to file-- should I use perhaps an RT version?.

No, as I already explained, you can not use fprintf and hope remaining
deterministic.

There is no function writing data to disk while remaining
deterministic. That would mean have disk drivers and so on written for
xenomai.

You have to design your application with an rt-task doing the rt work,
and a non rt-task doing the non rt work. This non rt-task can be a
classical pthread, in which case you will have to use an rt_pipe for
communications between the two tasks. Or the non rt-task can be a
xenomai thread with priority 0, in which case you can use any other
IPC.

For assistance in the daunting task of keeping deterministic, see the
bit T_WARNSW of the rt_task_set_mode service, or the bit PTHREAD_WARNSW
of the pthread_set_mode_np service.

--=20


					    Gilles.


------_=_NextPart_001_01C8A58A.17CA908E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Gilles,<BR>
<BR>
thank you for your information about this-- I guess the handling of all =
error reporting, writing to disk, etc has to be handled in another =
thread.&nbsp; In terms of priorities, should I set the serial task to =
have a priority of 99?&nbsp; I was also advised to make a smaller buffer =
to flush data to disk. I'm currently using the defaults which might be a =
large cached buffer.&nbsp; If I flush data to disk at regular intervals =
I can lower blockages.&nbsp; Nonetheless, the writing to disk is a =
data-logging task and could be moved out of the RT-Task, leaving only =
the capture of data and processing of packets in the RT Task.&nbsp; I =
assume tools like hdparm (which unmask serial interrupts) have no place =
in the xenomai world, right?<BR>
<BR>
Take care,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
<BR>
<BR>
Karch, Joshua wrote:<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; Gilles,<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; I decided to eliminate the pthread and create a task that =
handles the entire packet process, from reading the serial port, to =
decoding data, to disk io (saving the data to disk)&nbsp; The only thing =
that's serviced occasionally is the main loop, which looks every half =
second for a keypress to quit.<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; Now, I get overrun errors once every 10 seconds to 30 =
seconds.&nbsp; The machine is a PC/104 and I'm using fprintf to print =
the data received from the sensor to file-- should I use perhaps an RT =
version?.<BR>
<BR>
No, as I already explained, you can not use fprintf and hope =
remaining<BR>
deterministic.<BR>
<BR>
There is no function writing data to disk while remaining<BR>
deterministic. That would mean have disk drivers and so on written =
for<BR>
xenomai.<BR>
<BR>
You have to design your application with an rt-task doing the rt =
work,<BR>
and a non rt-task doing the non rt work. This non rt-task can be a<BR>
classical pthread, in which case you will have to use an rt_pipe for<BR>
communications between the two tasks. Or the non rt-task can be a<BR>
xenomai thread with priority 0, in which case you can use any other<BR>
IPC.<BR>
<BR>
For assistance in the daunting task of keeping deterministic, see =
the<BR>
bit T_WARNSW of the rt_task_set_mode service, or the bit =
PTHREAD_WARNSW<BR>
of the pthread_set_mode_np service.<BR>
<BR>
--<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
Gilles.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A58A.17CA908E--

