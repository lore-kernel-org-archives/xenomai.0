Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8CD60.62B79D32"
Date: Fri, 13 Jun 2008 16:18:43 +0200
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E025B28D9@domain.hid>
From: "Markus Osterried" <markus.osterried@domain.hid>
Subject: [Xenomai-core] pSOS skin: bug in tm_ticks_to_date() and
	tm_date_to_ticks()
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

------_=_NextPart_001_01C8CD60.62B79D32
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
there is a bug in the pSOS kernel-space skin, calculating calendar time
to ticks and vice versa.
The file xenomai/ksrc/skins/psos+/tm.c should be fixed like this:
=20
=20
=20
--- xenomai-2.4/ksrc/skins/psos+/tm.c
+++ xenomai-2.4/ksrc/skins/psos+/tm.c
@@ -204,8 +204,8 @@
   /* Add one day for leap year after February. */
   *count +=3D 1;
=20
- for (n =3D month - 1; month > 0; month--)
-  *count +=3D tm_month_sizes[month - 1];
+ for (n =3D 0; n < month-1; n++)
+  *count +=3D tm_month_sizes[n];
=20
  *count +=3D day - 1;
  *count *=3D 24;
@@ -223,9 +223,10 @@
 static void tm_ticks_to_date(u_long *date,
         u_long *time, u_long *ticks, xnticks_t count)
 {
- u_long year, month, day, hour, min, sec, allsecs, rem;
+ u_long year, month, day, hour, min, sec, rem;
+ xnticks_t allsecs;
=20
- allsecs =3D (u_long)xnarch_ulldiv(count,
xntbase_get_ticks2sec(psos_tbase), &rem);
+ allsecs =3D xnarch_ulldiv(count, xntbase_get_ticks2sec(psos_tbase),
&rem);
=20
  year =3D 0;
=20
@@ -257,14 +258,14 @@
   month++;
  }
=20
- day =3D allsecs / tm_secbyday;
- allsecs -=3D (day * tm_secbyday);
- day++;   /* Days are 1-based. */
- hour =3D (allsecs / tm_secbyhour);
- allsecs -=3D (hour * tm_secbyhour);
- min =3D (allsecs / tm_secbymin);
- allsecs -=3D (min * tm_secbymin);
  sec =3D allsecs;
+ day =3D sec / tm_secbyday;
+ sec -=3D (day * tm_secbyday);
+ day++;   /* Days are 1-based. */
+ hour =3D (sec / tm_secbyhour);
+ sec -=3D (hour * tm_secbyhour);
+ min =3D (sec / tm_secbymin);
+ sec -=3D (min * tm_secbymin);
=20
  *date =3D (year << 16) | (month << 8) | day;
  *time =3D (hour << 16) | (min << 8) | sec;

=20
=20
Thank you
Markus
=20

------_=_NextPart_001_01C8CD60.62B79D32
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1595" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008>there =
is a bug in=20
the pSOS&nbsp;<SPAN class=3D332311114-13062008>kernel</SPAN>-space skin, =
cal<SPAN=20
class=3D332311114-13062008>culating calendar time to ticks and vice=20
versa.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008><SPAN=20
class=3D332311114-13062008></SPAN></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D696244110-13052008>The file xenomai/<SPAN=20
class=3D332311114-13062008>k</SPAN>src/skins/psos+/tm.c should be fixed =
like=20
this:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2><SPAN =
class=3D696244110-13052008>---=20
xenomai-2.4/ksrc/skins/psos+/tm.c<BR>+++ =
xenomai-2.4/ksrc/skins/psos+/tm.c<BR>@@=20
-204,8 +204,8 @@<BR>&nbsp;&nbsp;&nbsp;/* Add one day for leap year after =

February. */<BR>&nbsp;&nbsp;&nbsp;*count +=3D 1;<BR>&nbsp;<BR>-&nbsp;for =
(n =3D=20
month - 1; month &gt; 0; month--)<BR>-&nbsp;&nbsp;*count +=3D =
tm_month_sizes[month=20
- 1];<BR>+&nbsp;for (n =3D 0; n &lt; month-1; =
n++)<BR>+&nbsp;&nbsp;*count +=3D=20
tm_month_sizes[n];<BR>&nbsp;<BR>&nbsp;&nbsp;*count +=3D day -=20
1;<BR>&nbsp;&nbsp;*count *=3D 24;<BR>@@ -223,9 +223,10 =
@@<BR>&nbsp;static void=20
tm_ticks_to_date(u_long=20
*date,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u_long *time, =
u_long=20
*ticks, xnticks_t count)<BR>&nbsp;{<BR>-&nbsp;u_long year, month, day, =
hour,=20
min, sec, allsecs, rem;<BR>+&nbsp;u_long year, month, day, hour, min, =
sec,=20
rem;<BR>+&nbsp;xnticks_t allsecs;<BR>&nbsp;<BR>-&nbsp;allsecs =3D=20
(u_long)xnarch_ulldiv(count, xntbase_get_ticks2sec(psos_tbase),=20
&amp;rem);<BR>+&nbsp;allsecs =3D xnarch_ulldiv(count,=20
xntbase_get_ticks2sec(psos_tbase), =
&amp;rem);<BR>&nbsp;<BR>&nbsp;&nbsp;year =3D=20
0;<BR>&nbsp;<BR>@@ -257,14 +258,14=20
@@<BR>&nbsp;&nbsp;&nbsp;month++;<BR>&nbsp;&nbsp;}<BR>&nbsp;<BR>-&nbsp;day=
 =3D=20
allsecs / tm_secbyday;<BR>-&nbsp;allsecs -=3D (day *=20
tm_secbyday);<BR>-&nbsp;day++;&nbsp;&nbsp;&nbsp;/* Days are 1-based.=20
*/<BR>-&nbsp;hour =3D (allsecs / tm_secbyhour);<BR>-&nbsp;allsecs -=3D =
(hour *=20
tm_secbyhour);<BR>-&nbsp;min =3D (allsecs / =
tm_secbymin);<BR>-&nbsp;allsecs -=3D=20
(min * tm_secbymin);<BR>&nbsp;&nbsp;sec =3D allsecs;<BR>+&nbsp;day =3D =
sec /=20
tm_secbyday;<BR>+&nbsp;sec -=3D (day *=20
tm_secbyday);<BR>+&nbsp;day++;&nbsp;&nbsp;&nbsp;/* Days are 1-based.=20
*/<BR>+&nbsp;hour =3D (sec / tm_secbyhour);<BR>+&nbsp;sec -=3D (hour *=20
tm_secbyhour);<BR>+&nbsp;min =3D (sec / tm_secbymin);<BR>+&nbsp;sec -=3D =
(min *=20
tm_secbymin);<BR>&nbsp;<BR>&nbsp;&nbsp;*date =3D (year &lt;&lt; 16) | =
(month=20
&lt;&lt; 8) | day;<BR>&nbsp;&nbsp;*time =3D (hour &lt;&lt; 16) | (min =
&lt;&lt; 8)=20
| sec;<BR></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008><SPAN=20
class=3D332311114-13062008>Thank you</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008><SPAN=20
class=3D332311114-13062008>Markus</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D696244110-13052008><SPAN=20
class=3D332311114-13062008></SPAN></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT><FONT face=3DArial =
size=3D2><SPAN=20
class=3D696244110-13052008></SPAN></FONT>&nbsp;</DIV></DIV></BODY></HTML>=


------_=_NextPart_001_01C8CD60.62B79D32--

