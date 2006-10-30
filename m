From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Qaae6H8mtfoFVncUHJ35"
Date: Mon, 30 Oct 2006 15:30:40 +0100
Message-Id: <1162218640.4993.5.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] xenomai revision 1772 on arm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-Qaae6H8mtfoFVncUHJ35
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

Should be a hint, if anyone has similar Problems:

Xenomai (rev. 1772) was not running on my platform. (no
timer_tick-calls; timer stopped)

I had to do following downgrade:

Index: include/asm-arm/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-arm/hal.h       (revision 1772)
+++ include/asm-arm/hal.h       (working copy)
@@ -103,10 +103,13 @@
=20
 static inline void rthal_timer_program_shot (unsigned long delay)
 {
+    if(!delay)
+        delay =3D 10;
+    __ipipe_mach_set_dec(delay);
-    if(!delay)
-        rthal_trigger_irq(RTHAL_TIMER_IRQ);
-     else
-       __ipipe_mach_set_dec(delay);
 }
=20
     /* Private interface -- Internal use only */


It's simply a workaround yet. I'll try to find the error in my
timer-handling.

	Manfred


--=-Qaae6H8mtfoFVncUHJ35
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFRgyQbMvu5jIEpfsRAtYRAKCFvwectaSjWOoudO4BguLfD6kqNgCdE9Jd
2WlbM1eWvkaZejZ4k3NOrR4=
=kqwA
-----END PGP SIGNATURE-----

--=-Qaae6H8mtfoFVncUHJ35--


