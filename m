Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C67807.6796EDF9"
Date: Mon, 15 May 2006 12:07:42 +0200
Message-ID: <AD78122AD7C05B4B936EBAD7F49738C0AB2B3D@square.bfh.ch>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
Subject: [Xenomai-help] CPU load over 90%
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

------_=_NextPart_001_01C67807.6796EDF9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20
I am using Xenomai to read data from different sensors in real time from
user space. So far I am reading position data from a device attached to
a serial port. The CPU load is at about 1%. I also have a
microcontroller attached via USB to read encoder data. The USB device is
a USB-to-serial converter. As soon as I open the (USB-)serial port with
normal systemcalls and read the incoming data my CPU load skyrockets to
over 90%. I only read about 30 bytes every 100ms.
I ran the application on a much newer computer also to rule out any
buggy hardware. The results stayed the same. Intensively searching the
mailing list and provided documentation have not helped solve the
problem.=20
I'm using Xenomai 2.1.0 with kernel 2.6.15.6. Xenomai is compiled into
the kernel. I also use the driver xeno_16550A loaded as module. The
USB-to-serial bridge used is a CP2101 from Silabs.=20
Regards,=20
Nathan=20


------_=_NextPart_001_01C67807.6796EDF9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>CPU load over 90%</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT><FONT FACE=3D"Times New =
Roman"> </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">I am using Xenomai to read data from =
different sensors in real time from user space. So far I am reading =
position data from a device attached to a serial port. The CPU load is =
at about 1%. I also have a microcontroller attached via USB to read =
encoder data. The USB device is a USB-to-serial converter. As soon as I =
open the (USB-)serial port with normal systemcalls and read the incoming =
data my CPU load skyrockets to over 90%. I only read about 30 bytes =
every 100ms.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I ran the application on a much newer =
computer also to rule out any buggy hardware. The results stayed the =
same. Intensively searching the mailing list and provided documentation =
have not helped solve the problem.</FONT> </P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm using Xenomai 2.1.0 with kernel =
2.6.15.6. Xenomai is compiled into the kernel. I also use the driver =
xeno_16550A loaded as module. The USB-to-serial bridge used is a CP2101 =
from Silabs.</FONT> </P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Regards,</FONT><FONT FACE=3D"Times New =
Roman"> </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Nathan</FONT><FONT FACE=3D"Times New =
Roman"> </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C67807.6796EDF9--

