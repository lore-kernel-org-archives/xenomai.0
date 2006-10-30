Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6FC79.BF3D13F2"
Date: Tue, 31 Oct 2006 10:18:56 +1100
Message-ID: <1F695B041C4BC345AFB7BD5D647B85000119975A@mail.senetas.com>
From: "John Weston" <john.weston@domain.hid>
Subject: [Xenomai-help] More woes with linux 2.6.18 and xenomai 2.2.3 or
	2.2.4 - irq_desc structure changed
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

------_=_NextPart_001_01C6FC79.BF3D13F2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Continuing from my previous email regarding xenomai 2.2.4 and linux
2.6.18 for ppc (8260), I have also noticed that the underlying irq_desc
structure has changed (in include/linux/irq.h), which in turn breaks
hal.c.

Are there any more recents patches available to fix this? Thanks in
advance

John  Weston
Senetas PL

------_=_NextPart_001_01C6FC79.BF3D13F2
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7650.28">
<TITLE>More woes with linux 2.6.18 and xenomai 2.2.3 or 2.2.4 - irq_desc =
structure changed</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Continuing from my previous email =
regarding xenomai 2.2.4 and linux 2.6.18 for ppc (8260), I have also =
noticed that the underlying irq_desc structure has changed (in =
include/linux/irq.h), which in turn breaks hal.c.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Are there any more recents patches =
available to fix this? Thanks in&nbsp; advance</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">John&nbsp; Weston</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Senetas PL</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6FC79.BF3D13F2--

