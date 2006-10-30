Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6FC72.6871BDD6"
Date: Tue, 31 Oct 2006 09:27:11 +1100
Message-ID: <1F695B041C4BC345AFB7BD5D647B85000119972A@mail.senetas.com>
From: "John Weston" <john.weston@domain.hid>
Subject: [Xenomai-help] Build problem on kernel 2.6.18 for ppc
	(rt_mutex_lock redefined)
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

------_=_NextPart_001_01C6FC72.6871BDD6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to build denx kernel version 2.6.18 (rc2) on a ppc (8260),
and while  there are a few problems easily overcome, I am seeking advice
on how to overcome the following build error.

   CC [M] kernel/xenomai/skins/native/module.o
In file included from kernel/xenomai/skins/native/module.c:41;
Include/xenomai/native/mutex.h:117: error: conflicting types for
'rt_mutex_lock'
Include/linux/rtmutex.h:88: error previous declaration of
'rt_mutex_lock' was here

....


I was previously using 2.6.15 and xenomai 2.2.3 and did not have any
problems with the build. I tried disabling RT_MUTEX in the main kernel
config, but I do not believe this is the correct way to go, and it did
not fix the problem anyway.

Any ideas would be greatly appreciated.

BTW: another problem I had in both version was that the preparekernel
script looks for ipipe.h in include/asm-powerpc, but the file is
actually placed in include/asm-ppc, so the build reports that the kernel
has not been patched. Simple fix, but thought I would add it here for
the lists attention.

Sincerely

John Weston
Senetas PL


------_=_NextPart_001_01C6FC72.6871BDD6
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
<TITLE>Build problem on kernel 2.6.18 for ppc (rt_mutex_lock =
redefined)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am trying to build denx kernel =
version 2.6.18 (rc2) on a ppc (8260), and while&nbsp; there are a few =
problems easily overcome, I am seeking advice on how to overcome the =
following build error.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; CC [M] =
kernel/xenomai/skins/native/module.o</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">In file included from =
kernel/xenomai/skins/native/module.c:41;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Include/xenomai/native/mutex.h:117: =
error: conflicting types for 'rt_mutex_lock'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Include/linux/rtmutex.h:88: error =
previous declaration of 'rt_mutex_lock' was here</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&#8230;.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">I was previously using 2.6.15 and =
xenomai 2.2.3 and did not have any problems with the build. I tried =
disabling RT_MUTEX in the main kernel config, but I do not believe this =
is the correct way to go, and it did not fix the problem =
anyway.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Any ideas would be greatly =
appreciated.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">BTW: another problem I had in both =
version was that the preparekernel script looks for ipipe.h in =
include/asm-powerpc, but the file is actually placed in include/asm-ppc, =
so the build reports that the kernel has not been patched. Simple fix, =
but thought I would add it here for the lists attention.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Sincerely</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">John Weston</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Senetas PL</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6FC72.6871BDD6--

