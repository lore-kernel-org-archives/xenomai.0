Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75756.F77E91ED"
Date: Fri, 23 Feb 2007 15:29:03 +0100
Message-ID: <AD78122AD7C05B4B936EBAD7F49738C0AB2BA0@domain.hid>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
Subject: [Xenomai-help] error after timeout on serial port
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

------_=_NextPart_001_01C75756.F77E91ED
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am polling on a serial port during an init sequence of a positioning
device. Every once in a while I get a return code indicating that a
timeout occured, code -110 (ETIMEDOUT). After a timeout occured I can't
read the port anymore. Whenever I call rt_dev_read() again the function
returns the error code -14 (EFAULT). Is there a flag I must clear to get
the port operatioanl again?

Regards
Nathan  =20



------_=_NextPart_001_01C75756.F77E91ED
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
<TITLE>error after timeout on serial port</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am polling on a serial port during an =
init sequence of a positioning device. Every once in a while I get a =
return code indicating that a timeout occured, code -110 (ETIMEDOUT). =
After a timeout occured I can't read the port anymore. Whenever I call =
rt_dev_read() again the function returns the error code -14 (EFAULT). Is =
there a flag I must clear to get the port operatioanl again?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Regards</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Nathan&nbsp;&nbsp; </FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C75756.F77E91ED--

