MIME-Version: 1.0
Message-ID: <OFD063D933.7A634F4F-ONC1257685.0047F2EE-C1257685.004B47A1@domain.hid>
From: Hagen.Langbartels@domain.hid
Date: Mon, 7 Dec 2009 14:42:15 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 004B479FC1257685_="
Subject: [Xenomai-core] Undefined reference to Posix shm_* with uClibc
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 004B479FC1257685_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I tried to compile Xenomai 2.5rc4 with uClibc 0.9.30.1 and ran into some=20
problems with references to the=20
posix functions shm=5Fopen and shm=5Funlink in /src/skins/posix/wrappers.c,=
=20
which do not exist in uClibc.

Unlinke in  /src/skins/posix/shm.c the existence of these functions is not =

verfied (via #ifdef HAVE=5FSHM=5F*)
and the build fails.

The following patch is a quick and dirty fix for this problem. I hope this =

might be helpful.


diff -Nur xenomai-2.4.93.orig/src/skins/posix/wrappers.c=20
xenomai-2.4.93.work/src/skins/posix/wrappers.c
--- xenomai-2.4.93.orig/src/skins/posix/wrappers.c      2009-03-30=20
12:24:50.000000000 +0200
+++ xenomai-2.4.93.work/src/skins/posix/wrappers.c      2009-12-07=20
14:22:03.983876500 +0100
@@ -245,17 +245,21 @@
 }
=20
 /* shm */
+#ifdef HAVE=5FSHM=5FOPEN
 =5F=5Fattribute=5F=5F ((weak))
 int =5F=5Freal=5Fshm=5Fopen(const char *name, int oflag, mode=5Ft mode)
 {
        return shm=5Fopen(name, oflag, mode);
 }
+#endif
=20
+#ifdef HAVE=5FSHM=5FUNLINK
 =5F=5Fattribute=5F=5F ((weak))
 int =5F=5Freal=5Fshm=5Funlink(const char *name)
 {
        return shm=5Funlink(name);
 }
+#endif
=20
 =5F=5Fattribute=5F=5F ((weak))
 int =5F=5Freal=5Fftruncate(int fildes, long length)




Best regards,
Hagen Langbartels

SIEB & MEYER AG
Dipl.-Inf. (FH) Hagen Langbartels

Auf dem Schmaarkamp 21
21339 L=FCneburg
Germany
Tel.: +49-4131-203-1133
Fax.: +49-4131-38562
E-mail: development@domain.hid
www.sieb-meyer.de

Vorstand: Markus Meyer, Torsten Blankenburg
Aufsichtsratsvorsitzender: Hans Reinen
Amtsgericht L=FCneburg: HRB 1805
Umsatzsteuer-ID.-Nr.: DE 116085664
--=_alternative 004B479FC1257685_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi all,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I tried to compile Xenomai 2.5rc4 wi=
th
uClibc 0.9.30.1 and ran into some problems with references to the </font>
<br><font size=3D2 face=3D"sans-serif">posix functions shm=5Fopen and shm=
=5Funlink
in /src/skins/posix/wrappers.c, which do not exist in uClibc.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Unlinke in &nbsp;/src/skins/posix/sh=
m.c
the existence of these functions is not verfied (via #ifdef HAVE=5FSHM=5F*)=
</font>
<br><font size=3D2 face=3D"sans-serif">and the build fails.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">The following patch is a quick and d=
irty
fix for this problem. I hope this might be helpful.</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">diff -Nur xenomai-2.4.93.orig/src/sk=
ins/posix/wrappers.c
xenomai-2.4.93.work/src/skins/posix/wrappers.c</font>
<br><font size=3D2 face=3D"sans-serif">--- xenomai-2.4.93.orig/src/skins/po=
six/wrappers.c
&nbsp; &nbsp; &nbsp; &nbsp;2009-03-30 12:24:50.000000000 +0200</font>
<br><font size=3D2 face=3D"sans-serif">+++ xenomai-2.4.93.work/src/skins/po=
six/wrappers.c
&nbsp; &nbsp; &nbsp; &nbsp;2009-12-07 14:22:03.983876500 +0100</font>
<br><font size=3D2 face=3D"sans-serif">@@ -245,17 +245,21 @@</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;}</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;/* shm */</font>
<br><font size=3D2 face=3D"sans-serif">+#ifdef HAVE=5FSHM=5FOPEN</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;=5F=5Fattribute=5F=5F ((weak))=
</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;int =5F=5Freal=5Fshm=5Fopen(co=
nst char
*name, int oflag, mode=5Ft mode)</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;{</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;re=
turn
shm=5Fopen(name, oflag, mode);</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;}</font>
<br><font size=3D2 face=3D"sans-serif">+#endif</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;</font>
<br><font size=3D2 face=3D"sans-serif">+#ifdef HAVE=5FSHM=5FUNLINK</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;=5F=5Fattribute=5F=5F ((weak))=
</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;int =5F=5Freal=5Fshm=5Funlink(=
const char
*name)</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;{</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;re=
turn
shm=5Funlink(name);</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;}</font>
<br><font size=3D2 face=3D"sans-serif">+#endif</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;=5F=5Fattribute=5F=5F ((weak))=
</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp;int =5F=5Freal=5Fftruncate(int=
 fildes,
long length)</font>
<br>
<br>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Best regards,<br>
Hagen Langbartels<br>
<br>
SIEB &amp; MEYER AG<br>
Dipl.-Inf. (FH) Hagen Langbartels<br>
<br>
Auf dem Schmaarkamp 21<br>
21339 L=FCneburg<br>
Germany<br>
Tel.: +49-4131-203-1133<br>
Fax.: +49-4131-38562<br>
E-mail: development@domain.hid<br>
www.sieb-meyer.de<br>
<br>
Vorstand: Markus Meyer, Torsten Blankenburg<br>
Aufsichtsratsvorsitzender: Hans Reinen<br>
Amtsgericht L=FCneburg: HRB 1805<br>
Umsatzsteuer-ID.-Nr.: DE 116085664</font>
--=_alternative 004B479FC1257685_=--

