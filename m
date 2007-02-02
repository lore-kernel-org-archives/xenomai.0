Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C746B4.09E5E6F4"
Date: Fri, 2 Feb 2007 11:22:27 +0100
Message-ID: <AD78122AD7C05B4B936EBAD7F49738C0AB2B99@domain.hid>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
Subject: [Xenomai-help] rt_dev_open() returns -EBUSY
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

------_=_NextPart_001_01C746B4.09E5E6F4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

A couple of days ago I updated my system from Xenomai 2.2.0 and kernel
2.6.17.8 to Xenomai 2.3.0 and kernel 2.6.19.2. Everything worked well
until I tried to open my driver for the parallel port. The function
rt_dev_open() always returns -EBUSY even after loading the module and
trying to open the device for the first time. I had been using the
driver for several weeks without any problems and havn't touched the
code. Any hints?

Regards
Nathan =20


------_=_NextPart_001_01C746B4.09E5E6F4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>rt_dev_open() returns -EBUSY</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">A couple of days ago I updated my =
system from Xenomai 2.2.0 and kernel 2.6.17.8 to Xenomai 2.3.0 and =
kernel 2.6.19.2. Everything worked well until I tried to open my driver =
for the parallel port. The function rt_dev_open() always returns -EBUSY =
even after loading the module and trying to open the device for the =
first time. I had been using the driver for several weeks without any =
problems and havn't touched the code. Any hints?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Regards</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Nathan&nbsp; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C746B4.09E5E6F4--

