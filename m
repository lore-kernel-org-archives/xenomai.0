Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6B615.6BFF71D3"
Date: Wed, 2 Aug 2006 10:24:14 +0100
Message-ID: <353F6272FE0A6544AA97D47F761F486B01707FDF@ples506a.stcl.siemens.co.uk>
From: "Doyle, Alan" <alan.doyle@domain.hid>
Subject: [Xenomai-help] Reading Memory Mapped IO
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

------_=_NextPart_001_01C6B615.6BFF71D3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

I have an application where I need to read four contiguous memory mapped
data registers in response to an interrupt. As its real time critical I
intend to implement the read in Xenomai. Having read and processed the
data it later needs to be passed to a Linux domain application, I am
hoping to use a Posix message queue for this purpose.

I seem to have two options as to how to implement this, I could register
the interrupt in a Xenomai user space thread and mmap the data registers
so that on receiving the interrupt the registers could be read.
Alternatively I could write a Xenomai RTDM driver to read the registers
on interrupt and use the driver read call from the Xenomai user space
thread to access register data. In each case the data would then be
passed to the Linux domain via a message to a Posix queue - after some
further processing that is not real time critical.

Could you enlighten me as to the pros and cons of each approach, I am
particularly unclear as to the implications of using mmap in the Xenomai
domain and what if any affect it might have on the real time
responsiveness (I understand mmap() to be a call back into the Linux
kernel rather than to the Xenomai nucleus).

Thanks

Alan




------_=_NextPart_001_01C6B615.6BFF71D3
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
<TITLE>Reading Memory Mapped IO</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have an application where I need to =
read four contiguous memory mapped data registers in response to an =
interrupt. As its real time critical I intend to implement the read in =
Xenomai. Having read and processed the data it later needs to be passed =
to a Linux domain application, I am hoping to use a Posix message queue =
for this purpose.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I seem to have two options as to how to =
implement this, I could register the interrupt in a Xenomai user space =
thread and mmap the data registers so that on receiving the interrupt =
the registers could be read. Alternatively I could write a Xenomai RTDM =
driver to read the registers on interrupt and use the driver read call =
from the Xenomai user space thread to access register data. In each case =
the data would then be passed to the Linux domain via a message to a =
Posix queue - after some further processing that is not real time =
critical.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Could you enlighten me as to the pros =
and cons of each approach, I am particularly unclear as to the =
implications of using mmap in the Xenomai domain and what if any affect =
it might have on the real time responsiveness (I understand mmap() to be =
a call back into the Linux kernel rather than to the Xenomai =
nucleus).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Alan</FONT>
</P>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C6B615.6BFF71D3--

