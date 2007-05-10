Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7932F.64751F11"
Date: Thu, 10 May 2007 14:16:55 -0400
Message-ID: <D412DC851FDFAB4D8976895AC5C1F8AD30A6E0@domain.hid>
From: "Zhang, Haobo" <haobo.zhang@domain.hid>
Subject: [Xenomai-help] rtdm_iomap_to_user question
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

------_=_NextPart_001_01C7932F.64751F11
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am currently working on a project which is running on a PowerPC
platform. In my rtdm driver, I use "rtdm_iomap_to_user" to map a few I/O
memory locations to be accessed from my application. All the function
calls seem to work (no error code returned). But my application fails to
use these pointers to manipulate any I/O. Is there any restrictions I
have to be aware in order to use those mapped I/O mem? I am new to
xenomai. I would really appreciate any help to this.=20

Best Regards,
Haobo Zhang



------_=_NextPart_001_01C7932F.64751F11
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
<TITLE>rtdm_iomap_to_user question</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am currently working on a project =
which is running on a PowerPC platform. In my rtdm driver, I use =
&quot;rtdm_iomap_to_user&quot; to map a few I/O memory locations to be =
accessed from my application. All the function calls seem to work (no =
error code returned). But my application fails to use these pointers to =
manipulate any I/O. Is there any restrictions I have to be aware in =
order to use those mapped I/O mem? I am new to xenomai. I would really =
appreciate any help to this. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Best Regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Haobo Zhang<SPAN =
LANG=3D"zh-cn"></SPAN></FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C7932F.64751F11--

