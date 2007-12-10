MIME-Version: 1.0
From: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Message-ID: <OFD2B0EC2A.B4C937F8-ONC12573AD.0036F9DB-C12573AD.00370BC4@domain.hid>
Date: Mon, 10 Dec 2007 11:01:17 +0100
Content-Type: multipart/mixed; boundary="=_mixed 00370BBFC12573AD_="
Subject: [Xenomai-core] Antwort: Xenomai v2.4.0: CONFIG_XENO_OPT_SHIRQ_LEVEL
	vs. CONFIG_XENO_OPT_SHIRQ
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--=_mixed 00370BBFC12573AD_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

we had a problem compiling the CAN-Driver for the last release candidate 
when
shared interrupts had been enabled, because of the re-named option
"CONFIG_XENO_OPT_SHIRQ_LEVEL.". After a quick look, version 2.4.0 still
doesn't fix this. A patch is included (for ksrc/drivers/can).


Greets,
Thomas



--=_mixed 00370BBFC12573AD_=
Content-Type: text/plain; name="patch.txt"
Content-Disposition: attachment; filename="patch.txt"
Content-Transfer-Encoding: quoted-printable

diff -urN sja1000.orig/rtcan=5Fems=5Fpci.c sja1000/rtcan=5Fems=5Fpci.c=0A--=
- sja1000.orig/rtcan=5Fems=5Fpci.c	2007-09-16 19:20:45.000000000 +0200=0A++=
+ sja1000/rtcan=5Fems=5Fpci.c	2007-12-10 10:14:58.000000000 +0100=0A@@ -272=
,7 +272,7 @@=0A 	if ((err =3D rtcan=5Fems=5Fpci=5Fadd=5Fchan(pdev, EMS=5FPC=
I=5FMASTER,=0A 					  &master=5Fdev)))=0A 		goto failure=5Fcleanup;=0A-#ifd=
ef CONFIG=5FXENO=5FOPT=5FSHIRQ=5FLEVEL=0A+#ifdef CONFIG=5FXENO=5FOPT=5FSHIR=
Q=0A 	if ((err =3D rtcan=5Fems=5Fpci=5Fadd=5Fchan(pdev, EMS=5FPCI=5FSLAVE,=
=0A 					  &master=5Fdev)))=0A 		goto failure=5Fcleanup;=0Adiff -urN sja100=
0.orig/rtcan=5Fixxat=5Fpci.c sja1000/rtcan=5Fixxat=5Fpci.c=0A--- sja1000.or=
ig/rtcan=5Fixxat=5Fpci.c	2007-09-16 19:20:45.000000000 +0200=0A+++ sja1000/=
rtcan=5Fixxat=5Fpci.c	2007-12-10 10:14:54.000000000 +0100=0A@@ -254,7 +254,=
7 @@=0A 	goto failure=5Fiounmap;=0A =0A     if (channel !=3D CHANNEL=5FSING=
LE) {=0A-#ifdef CONFIG=5FXENO=5FOPT=5FSHIRQ=5FLEVEL=0A+#ifdef CONFIG=5FXENO=
=5FOPT=5FSHIRQ=0A 	channel =3D CHANNEL=5FSLAVE;=0A 	if ((ret =3D rtcan=5Fix=
xat=5Fpci=5Fadd=5Fchan(pdev, channel,=0A 					    &master=5Fdev, conf=5Fadd=
r,=0Adiff -urN sja1000.orig/rtcan=5Fpeak=5Fpci.c sja1000/rtcan=5Fpeak=5Fpci=
.c=0A--- sja1000.orig/rtcan=5Fpeak=5Fpci.c	2007-09-16 19:20:45.000000000 +0=
200=0A+++ sja1000/rtcan=5Fpeak=5Fpci.c	2007-12-10 10:14:51.000000000 +0100=
=0A@@ -292,7 +292,7 @@=0A 	if ((ret =3D rtcan=5Fpeak=5Fpci=5Fadd=5Fchan(pde=
v, CHANNEL=5FMASTER, =0A 					   &master=5Fdev)))=0A 	    goto failure=5Fcl=
eanup;=0A-#ifdef CONFIG=5FXENO=5FOPT=5FSHIRQ=5FLEVEL=0A+#ifdef CONFIG=5FXEN=
O=5FOPT=5FSHIRQ=0A 	if ((ret =3D rtcan=5Fpeak=5Fpci=5Fadd=5Fchan(pdev, CHAN=
NEL=5FSLAVE, =0A 					   &master=5Fdev)))=0A 	    goto failure=5Fcleanup;=
=0A=
--=_mixed 00370BBFC12573AD_=--

