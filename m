Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C66E9D.DD2CAFC6"
Date: Wed, 3 May 2006 12:39:32 +0200
Message-ID: <AD78122AD7C05B4B936EBAD7F49738C0AB2B39@domain.hid>
From: "Lauener Nathan" <Nathan.Lauener@domain.hid>
Subject: [Adeos-main] ipipe/tracer.c compiling error
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C66E9D.DD2CAFC6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20
I just patched my adeos enhanced kernel with
"ipipe-tracer-2.6.15-i386-1.3.0-00.patch". When compiling the kernel
with the tracer switched on I get the following compile error:
kernel/ipipe/tracer.c:122: error: bad syntax before "void". It seems the
compiler does not recognice "notrace". Did I miss something when
patching the kernel?
Thanks for your help=20
Nathan=20


------_=_NextPart_001_01C66E9D.DD2CAFC6
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
<TITLE>ipipe/tracer.c compiling error</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT><FONT FACE=3D"Times New =
Roman"> </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">I just patched my adeos enhanced =
kernel with &quot;ipipe-tracer-2.6.15-i386-1.3.0-00.patch&quot;. When =
compiling the kernel with the tracer switched on I get the following =
compile error: kernel/ipipe/tracer.c:122: error: bad syntax before =
&quot;void&quot;. It seems the compiler does not recognice =
&quot;notrace&quot;. Did I miss something when patching the =
kernel?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks for your help</FONT><FONT =
FACE=3D"Times New Roman"> </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Nathan</FONT>=20
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C66E9D.DD2CAFC6--

