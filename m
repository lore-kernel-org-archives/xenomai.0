Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B4E8.A96ED320"
Date: Tue, 13 May 2008 13:01:14 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28A0@domain.hid>
From: "Markus Osterried" <markus.osterried@domain.hid>
Subject: [Xenomai-core] bug with tm_evevery()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B4E8.A96ED320
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
there is a bug in the pSOS user-space skin, calling the wrong
kernel-space function for tm_evevery().
The file xenomai/src/skins/psos+/tm.c should be fixed like this:
=20
=20
--- xenomai-2.4/src/skins/psos+/tm.c
+++ xenomai-2.4/src/skins/psos+/tm.c
@@ -71,7 +71,7 @@
=20
 u_long tm_evevery(u_long ticks, u_long events, u_long *tmid_r)
 {
-       return XENOMAI_SKINCALL3(__psos_muxid, __psos_tm_evwhen, ticks,
events, tmid_r);
+       return XENOMAI_SKINCALL3(__psos_muxid, __psos_tm_evevery, ticks,
events, tmid_r);
 }
=20
 u_long tm_getm(unsigned long long *ns_r) /* Xenomai extension. */

=20
=20
Thank you.
Markus
=20
=20

------_=_NextPart_001_01C8B4E8.A96ED320
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1595" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008>there =
is a bug in=20
the pSOS user-space skin, calling the wrong kernel-space function for=20
tm_evevery().</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008>The =
file=20
xenomai/src/skins/psos+/tm.c should be fixed like =
this:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D696244110-13052008></SPAN></FONT><FONT=20
face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>--- =
xenomai-2.4/src/skins/psos+<SPAN=20
class=3D696244110-13052008>/</SPAN>tm.c</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>+++ =
xenomai-2.4/src/skins/psos+<SPAN=20
class=3D696244110-13052008>/</SPAN>tm.c<BR>@@ -71,7 +71,7 =
@@</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>&nbsp;u_long tm_evevery(u_long =
ticks,=20
u_long events, u_long=20
*tmid_r)<BR>&nbsp;{<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
XENOMAI_SKINCALL3(__psos_muxid, __psos_tm_evwhen, ticks, events,=20
tmid_r);<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
XENOMAI_SKINCALL3(__psos_muxid, __psos_tm_evevery, ticks, events,=20
tmid_r);<BR>&nbsp;}</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>&nbsp;u_long tm_getm(unsigned =
long long=20
*ns_r) /* Xenomai extension. */<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008>Thank=20
you.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008>Markus</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C8B4E8.A96ED320--

