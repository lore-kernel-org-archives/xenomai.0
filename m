Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAA457.3B7CC830"
Date: Tue, 2 Feb 2010 16:29:56 -0600
Message-ID: <181804936ABC2349BE503168465576460D8F07F0@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] pthread_make_periodic_np initial start date
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAA457.3B7CC830
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is there a way to specify no initial delay when calling
pthread_make_periodic_np?  If I pass a value directly obtained from
clock_gettime, it will return a ETIMEDOUT error due to time passing
before I make the call.  I could add a small delay to the value obtained
from clock_gettime, but I would be concerned that due to other
happenings in the system, the absolute date may still have passed by the
time it gets around to calling pthread_make_periodic_np.

What I would be looking for I guess is what happens when I call
rt_task_set_periodic with an idate parameter of TM_NOW.  Is there any
way to simulate this behavior?

Thanks.


------_=_NextPart_001_01CAA457.3B7CC830
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asc=
ii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7638.=
1">
<TITLE>pthread_make_periodic_np initial start date</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Is there a way to=
 specify no initial delay when calling pthread_make_periodic_np?&nbsp;=
 If I pass a value directly obtained from clock_gettime, it will return=
 a ETIMEDOUT error</FONT><FONT SIZE=3D2 FACE=3D"Arial"> due to time pass=
ing before I make the call</FONT><FONT SIZE=3D2 FACE=3D"Arial">.&nbsp;=
 I could add a small delay to the value obtained from clock_gettime, but=
 I would be concerned that due to other happenings in the system, the=
 absolute date may still have passed by the time it gets around to calli=
ng pthread_make_periodic_np.</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">What I would be=
 looking for I guess is what happens when I call rt_task_set_periodic=
 with an idate parameter of TM_NOW.&nbsp; Is there any way to simulate=
 this behavior?</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Thanks.</FONT></SP=
AN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CAA457.3B7CC830--


